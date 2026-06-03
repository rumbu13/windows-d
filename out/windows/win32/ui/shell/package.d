// Written in the D programming language.

module windows.win32.ui.shell;

public import windows.core;
public import windows.win32.data.xml.msxml : IXMLDOMDocument;
public import windows.win32.foundation : BOOL, BOOLEAN, BSTR, CHAR, COLORREF, FILETIME,
                                         HANDLE, HINSTANCE, HRESULT, HWND, LPARAM,
                                         LRESULT, NTSTATUS, POINT, POINTL,
                                         PROPERTYKEY, PSTR, PWSTR, RECT, RECTL,
                                         SHANDLE_PTR, SIZE, SYSTEMTIME, VARIANT_BOOL,
                                         WIN32_ERROR, WPARAM;
public import windows.win32.graphics.directcomposition : IDCompositionAnimation;
public import windows.win32.graphics.gdi : HBITMAP, HDC, HMONITOR, HPALETTE, LOGFONTW;
public import windows.win32.graphics.gdiplus : InterpolationMode;
public import windows.win32.networkmanagement.iphelper : NET_ADDRESS_INFO;
public import windows.win32.networkmanagement.wnet : NETRESOURCEA;
public import windows.win32.security : SECURITY_ATTRIBUTES;
public import windows.win32.storage.filesystem : FILE_FLAGS_AND_ATTRIBUTES, WIN32_FIND_DATAA,
                                                 WIN32_FIND_DATAW;
public import windows.win32.system.com : BYTE_BLOB, DISPPARAMS, EXCEPINFO, FORMATETC,
                                         IBindCtx, IBindStatusCallback,
                                         IConnectionPoint, IDataObject, IDispatch,
                                         IEnumFORMATETC, IEnumGUID, IEnumString,
                                         IEnumUnknown, IMalloc, IMoniker, IPersist,
                                         IServiceProvider, IStream, IUnknown;
public import windows.win32.system.com.structuredstorage : IPropertyBag, IPropertySetStorage,
                                                           IStorage, PROPVARIANT;
public import windows.win32.system.com.urlmon : SOFTDISTINFO;
public import windows.win32.system.console : COORD;
public import windows.win32.system.io : OVERLAPPED;
public import windows.win32.system.ole : DROPEFFECT, IDropSource, IDropTarget,
                                         IOleCommandTarget, IOleInPlaceSite,
                                         IOleObject, IOleWindow, OLECMDEXECOPT,
                                         OLECMDF, OLECMDID, OLEMENUGROUPWIDTHS,
                                         READYSTATE;
public import windows.win32.system.registry : HKEY;
public import windows.win32.system.search : ICondition;
public import windows.win32.system.systemservices : SFGAO_FLAGS;
public import windows.win32.system.threading : LPTHREAD_START_ROUTINE, PROCESS_INFORMATION,
                                               STARTUPINFOW;
public import windows.win32.system.variant : VARENUM, VARIANT;
public import windows.win32.ui.controls : HIMAGELIST, HPROPSHEETPAGE, LPFNSVADDPROPSHEETPAGE,
                                          NMHDR, TBBUTTON;
public import windows.win32.ui.shell.common : COMDLG_FILTERSPEC, DEVICE_SCALE_FACTOR, IObjectArray,
                                              ITEMIDLIST, PERCEIVED, SHCOLSTATE,
                                              SHELLDETAILS, SHITEMID, STRRET;
public import windows.win32.ui.shell.propertiessystem : GETPROPERTYSTOREFLAGS, IPropertyChangeArray,
                                                        IPropertyDescriptionList,
                                                        IPropertyStore, PDOPSTATUS;
public import windows.win32.ui.windowsandmessaging : CREATESTRUCTW, HACCEL, HDWP, HICON, HMENU,
                                                     MESSAGEBOX_STYLE, MSG, SHOW_WINDOW_CMD;

extern(Windows) @nogc nothrow:


// Enums


alias SHGFI_FLAGS = uint;
enum : uint
{
    SHGFI_ADDOVERLAYS       = 0x00000020U,
    SHGFI_ATTR_SPECIFIED    = 0x00020000U,
    SHGFI_ATTRIBUTES        = 0x00000800U,
    SHGFI_DISPLAYNAME       = 0x00000200U,
    SHGFI_EXETYPE           = 0x00002000U,
    SHGFI_ICON              = 0x00000100U,
    SHGFI_ICONLOCATION      = 0x00001000U,
    SHGFI_LARGEICON         = 0x00000000U,
    SHGFI_LINKOVERLAY       = 0x00008000U,
    SHGFI_OPENICON          = 0x00000002U,
    SHGFI_OVERLAYINDEX      = 0x00000040U,
    SHGFI_PIDL              = 0x00000008U,
    SHGFI_SELECTED          = 0x00010000U,
    SHGFI_SHELLICONSIZE     = 0x00000004U,
    SHGFI_SMALLICON         = 0x00000001U,
    SHGFI_SYSICONINDEX      = 0x00004000U,
    SHGFI_TYPENAME          = 0x00000400U,
    SHGFI_USEFILEATTRIBUTES = 0x00000010U,
}

alias SHCNE_ID = uint;
enum : uint
{
    SHCNE_RENAMEITEM       = 0x00000001U,
    SHCNE_CREATE           = 0x00000002U,
    SHCNE_DELETE           = 0x00000004U,
    SHCNE_MKDIR            = 0x00000008U,
    SHCNE_RMDIR            = 0x00000010U,
    SHCNE_MEDIAINSERTED    = 0x00000020U,
    SHCNE_MEDIAREMOVED     = 0x00000040U,
    SHCNE_DRIVEREMOVED     = 0x00000080U,
    SHCNE_DRIVEADD         = 0x00000100U,
    SHCNE_NETSHARE         = 0x00000200U,
    SHCNE_NETUNSHARE       = 0x00000400U,
    SHCNE_ATTRIBUTES       = 0x00000800U,
    SHCNE_UPDATEDIR        = 0x00001000U,
    SHCNE_UPDATEITEM       = 0x00002000U,
    SHCNE_SERVERDISCONNECT = 0x00004000U,
    SHCNE_UPDATEIMAGE      = 0x00008000U,
    SHCNE_DRIVEADDGUI      = 0x00010000U,
    SHCNE_RENAMEFOLDER     = 0x00020000U,
    SHCNE_FREESPACE        = 0x00040000U,
    SHCNE_EXTENDED_EVENT   = 0x04000000U,
    SHCNE_ASSOCCHANGED     = 0x08000000U,
    SHCNE_DISKEVENTS       = 0x0002381fU,
    SHCNE_GLOBALEVENTS     = 0x0c0581e0U,
    SHCNE_ALLEVENTS        = 0x7fffffffU,
    SHCNE_INTERRUPT        = 0x80000000U,
}

alias SHCNRF_SOURCE = int;
enum : int
{
    SHCNRF_InterruptLevel     = 0x00000001,
    SHCNRF_ShellLevel         = 0x00000002,
    SHCNRF_RecursiveInterrupt = 0x00001000,
    SHCNRF_NewDelivery        = 0x00008000,
}

alias SHCNF_FLAGS = uint;
enum : uint
{
    SHCNF_IDLIST          = 0x00000000U,
    SHCNF_PATHA           = 0x00000001U,
    SHCNF_PRINTERA        = 0x00000002U,
    SHCNF_DWORD           = 0x00000003U,
    SHCNF_PATHW           = 0x00000005U,
    SHCNF_PRINTERW        = 0x00000006U,
    SHCNF_TYPE            = 0x000000ffU,
    SHCNF_FLUSH           = 0x00001000U,
    SHCNF_FLUSHNOWAIT     = 0x00003000U,
    SHCNF_NOTIFYRECURSIVE = 0x00010000U,
    SHCNF_PATH            = 0x00000005U,
    SHCNF_PRINTER         = 0x00000006U,
}

alias QITIPF_FLAGS = int;
enum : int
{
    QITIPF_DEFAULT       = 0x00000000,
    QITIPF_USENAME       = 0x00000001,
    QITIPF_LINKNOTARGET  = 0x00000002,
    QITIPF_LINKUSETARGET = 0x00000004,
    QITIPF_USESLOWTIP    = 0x00000008,
    QITIPF_SINGLELINE    = 0x00000010,
    QIF_CACHED           = 0x00000001,
    QIF_DONTEXPANDFOLDER = 0x00000002,
}

alias SHDID_ID = int;
enum : int
{
    SHDID_ROOT_REGITEM         = 0x00000001,
    SHDID_FS_FILE              = 0x00000002,
    SHDID_FS_DIRECTORY         = 0x00000003,
    SHDID_FS_OTHER             = 0x00000004,
    SHDID_COMPUTER_DRIVE35     = 0x00000005,
    SHDID_COMPUTER_DRIVE525    = 0x00000006,
    SHDID_COMPUTER_REMOVABLE   = 0x00000007,
    SHDID_COMPUTER_FIXED       = 0x00000008,
    SHDID_COMPUTER_NETDRIVE    = 0x00000009,
    SHDID_COMPUTER_CDROM       = 0x0000000a,
    SHDID_COMPUTER_RAMDISK     = 0x0000000b,
    SHDID_COMPUTER_OTHER       = 0x0000000c,
    SHDID_NET_DOMAIN           = 0x0000000d,
    SHDID_NET_SERVER           = 0x0000000e,
    SHDID_NET_SHARE            = 0x0000000f,
    SHDID_NET_RESTOFNET        = 0x00000010,
    SHDID_NET_OTHER            = 0x00000011,
    SHDID_COMPUTER_IMAGING     = 0x00000012,
    SHDID_COMPUTER_AUDIO       = 0x00000013,
    SHDID_COMPUTER_SHAREDDOCS  = 0x00000014,
    SHDID_MOBILE_DEVICE        = 0x00000015,
    SHDID_REMOTE_DESKTOP_DRIVE = 0x00000016,
}

alias SHGDFIL_FORMAT = int;
enum : int
{
    SHGDFIL_FINDDATA      = 0x00000001,
    SHGDFIL_NETRESOURCE   = 0x00000002,
    SHGDFIL_DESCRIPTIONID = 0x00000003,
}

alias PRF_FLAGS = int;
enum : int
{
    PRF_VERIFYEXISTS         = 0x00000001,
    PRF_TRYPROGRAMEXTENSIONS = 0x00000003,
    PRF_FIRSTDIRDEF          = 0x00000004,
    PRF_DONTFINDLNK          = 0x00000008,
    PRF_REQUIREABSOLUTE      = 0x00000010,
}

alias PCS_RET = uint;
enum : uint
{
    PCS_FATAL        = 0x80000000U,
    PCS_REPLACEDCHAR = 0x00000001U,
    PCS_REMOVEDCHAR  = 0x00000002U,
    PCS_TRUNCATED    = 0x00000004U,
    PCS_PATHTOOLONG  = 0x00000008U,
}

alias MM_FLAGS = uint;
enum : uint
{
    MM_ADDSEPARATOR    = 0x00000001U,
    MM_SUBMENUSHAVEIDS = 0x00000002U,
    MM_DONTREMOVESEPS  = 0x00000004U,
}

alias SHOP_TYPE = int;
enum : int
{
    SHOP_PRINTERNAME = 0x00000001,
    SHOP_FILEPATH    = 0x00000002,
    SHOP_VOLUMEGUID  = 0x00000004,
}

alias SHFMT_ID = uint;
enum : uint
{
    SHFMT_ID_DEFAULT = 0x0000ffffU,
}

alias SHFMT_OPT = int;
enum : int
{
    SHFMT_OPT_NONE    = 0x00000000,
    SHFMT_OPT_FULL    = 0x00000001,
    SHFMT_OPT_SYSONLY = 0x00000002,
}

alias SHFMT_RET = uint;
enum : uint
{
    SHFMT_ERROR    = 0xffffffffU,
    SHFMT_CANCEL   = 0xfffffffeU,
    SHFMT_NOFORMAT = 0xfffffffdU,
}

alias VALIDATEUNC_OPTION = int;
enum : int
{
    VALIDATEUNC_CONNECT = 0x00000001,
    VALIDATEUNC_NOUI    = 0x00000002,
    VALIDATEUNC_PRINT   = 0x00000004,
    VALIDATEUNC_PERSIST = 0x00000008,
    VALIDATEUNC_VALID   = 0x0000000f,
}

alias SFVM_MESSAGE_ID = int;
enum : int
{
    SFVM_MERGEMENU          = 0x00000001,
    SFVM_INVOKECOMMAND      = 0x00000002,
    SFVM_GETHELPTEXT        = 0x00000003,
    SFVM_GETTOOLTIPTEXT     = 0x00000004,
    SFVM_GETBUTTONINFO      = 0x00000005,
    SFVM_GETBUTTONS         = 0x00000006,
    SFVM_INITMENUPOPUP      = 0x00000007,
    SFVM_FSNOTIFY           = 0x0000000e,
    SFVM_WINDOWCREATED      = 0x0000000f,
    SFVM_GETDETAILSOF       = 0x00000017,
    SFVM_COLUMNCLICK        = 0x00000018,
    SFVM_QUERYFSNOTIFY      = 0x00000019,
    SFVM_DEFITEMCOUNT       = 0x0000001a,
    SFVM_DEFVIEWMODE        = 0x0000001b,
    SFVM_UNMERGEMENU        = 0x0000001c,
    SFVM_UPDATESTATUSBAR    = 0x0000001f,
    SFVM_BACKGROUNDENUM     = 0x00000020,
    SFVM_DIDDRAGDROP        = 0x00000024,
    SFVM_SETISFV            = 0x00000027,
    SFVM_THISIDLIST         = 0x00000029,
    SFVM_ADDPROPERTYPAGES   = 0x0000002f,
    SFVM_BACKGROUNDENUMDONE = 0x00000030,
    SFVM_GETNOTIFY          = 0x00000031,
    SFVM_GETSORTDEFAULTS    = 0x00000035,
    SFVM_SIZE               = 0x00000039,
    SFVM_GETZONE            = 0x0000003a,
    SFVM_GETPANE            = 0x0000003b,
    SFVM_GETHELPTOPIC       = 0x0000003f,
    SFVM_GETANIMATION       = 0x00000044,
}

alias SFVS_SELECT = int;
enum : int
{
    SFVS_SELECT_NONE     = 0x00000000,
    SFVS_SELECT_ALLITEMS = 0x00000001,
    SFVS_SELECT_INVERT   = 0x00000002,
}

alias DFM_MESSAGE_ID = int;
enum : int
{
    DFM_MERGECONTEXTMENU        = 0x00000001,
    DFM_INVOKECOMMAND           = 0x00000002,
    DFM_GETHELPTEXT             = 0x00000005,
    DFM_WM_MEASUREITEM          = 0x00000006,
    DFM_WM_DRAWITEM             = 0x00000007,
    DFM_WM_INITMENUPOPUP        = 0x00000008,
    DFM_VALIDATECMD             = 0x00000009,
    DFM_MERGECONTEXTMENU_TOP    = 0x0000000a,
    DFM_GETHELPTEXTW            = 0x0000000b,
    DFM_INVOKECOMMANDEX         = 0x0000000c,
    DFM_MAPCOMMANDNAME          = 0x0000000d,
    DFM_GETDEFSTATICID          = 0x0000000e,
    DFM_GETVERBW                = 0x0000000f,
    DFM_GETVERBA                = 0x00000010,
    DFM_MERGECONTEXTMENU_BOTTOM = 0x00000011,
    DFM_MODIFYQCMFLAGS          = 0x00000012,
}

alias DFM_CMD = int;
enum : int
{
    DFM_CMD_DELETE       = 0xffffffff,
    DFM_CMD_MOVE         = 0xfffffffe,
    DFM_CMD_COPY         = 0xfffffffd,
    DFM_CMD_LINK         = 0xfffffffc,
    DFM_CMD_PROPERTIES   = 0xfffffffb,
    DFM_CMD_NEWFOLDER    = 0xfffffffa,
    DFM_CMD_PASTE        = 0xfffffff9,
    DFM_CMD_VIEWLIST     = 0xfffffff8,
    DFM_CMD_VIEWDETAILS  = 0xfffffff7,
    DFM_CMD_PASTELINK    = 0xfffffff6,
    DFM_CMD_PASTESPECIAL = 0xfffffff5,
    DFM_CMD_MODALPROP    = 0xfffffff4,
    DFM_CMD_RENAME       = 0xfffffff3,
}

alias PID_IS = int;
enum : int
{
    PID_IS_URL         = 0x00000002,
    PID_IS_NAME        = 0x00000004,
    PID_IS_WORKINGDIR  = 0x00000005,
    PID_IS_HOTKEY      = 0x00000006,
    PID_IS_SHOWCMD     = 0x00000007,
    PID_IS_ICONINDEX   = 0x00000008,
    PID_IS_ICONFILE    = 0x00000009,
    PID_IS_WHATSNEW    = 0x0000000a,
    PID_IS_AUTHOR      = 0x0000000b,
    PID_IS_DESCRIPTION = 0x0000000c,
    PID_IS_COMMENT     = 0x0000000d,
    PID_IS_ROAMED      = 0x0000000f,
}

alias PID_INTSITE = int;
enum : int
{
    PID_INTSITE_WHATSNEW     = 0x00000002,
    PID_INTSITE_AUTHOR       = 0x00000003,
    PID_INTSITE_LASTVISIT    = 0x00000004,
    PID_INTSITE_LASTMOD      = 0x00000005,
    PID_INTSITE_VISITCOUNT   = 0x00000006,
    PID_INTSITE_DESCRIPTION  = 0x00000007,
    PID_INTSITE_COMMENT      = 0x00000008,
    PID_INTSITE_FLAGS        = 0x00000009,
    PID_INTSITE_CONTENTLEN   = 0x0000000a,
    PID_INTSITE_CONTENTCODE  = 0x0000000b,
    PID_INTSITE_RECURSE      = 0x0000000c,
    PID_INTSITE_WATCH        = 0x0000000d,
    PID_INTSITE_SUBSCRIPTION = 0x0000000e,
    PID_INTSITE_URL          = 0x0000000f,
    PID_INTSITE_TITLE        = 0x00000010,
    PID_INTSITE_CODEPAGE     = 0x00000012,
    PID_INTSITE_TRACKING     = 0x00000013,
    PID_INTSITE_ICONINDEX    = 0x00000014,
    PID_INTSITE_ICONFILE     = 0x00000015,
    PID_INTSITE_ROAMED       = 0x00000022,
}

alias PIDISF_FLAGS = int;
enum : int
{
    PIDISF_RECENTLYCHANGED = 0x00000001,
    PIDISF_CACHEDSTICKY    = 0x00000002,
    PIDISF_CACHEIMAGES     = 0x00000010,
    PIDISF_FOLLOWALLLINKS  = 0x00000020,
}

alias PIDISM_OPTIONS = int;
enum : int
{
    PIDISM_GLOBAL    = 0x00000000,
    PIDISM_WATCH     = 0x00000001,
    PIDISM_DONTWATCH = 0x00000002,
}

alias PIDISR_INFO = int;
enum : int
{
    PIDISR_UP_TO_DATE   = 0x00000000,
    PIDISR_NEEDS_ADD    = 0x00000001,
    PIDISR_NEEDS_UPDATE = 0x00000002,
    PIDISR_NEEDS_DELETE = 0x00000003,
}

alias SSF_MASK = uint;
enum : uint
{
    SSF_SHOWALLOBJECTS       = 0x00000001U,
    SSF_SHOWEXTENSIONS       = 0x00000002U,
    SSF_HIDDENFILEEXTS       = 0x00000004U,
    SSF_SERVERADMINUI        = 0x00000004U,
    SSF_SHOWCOMPCOLOR        = 0x00000008U,
    SSF_SORTCOLUMNS          = 0x00000010U,
    SSF_SHOWSYSFILES         = 0x00000020U,
    SSF_DOUBLECLICKINWEBVIEW = 0x00000080U,
    SSF_SHOWATTRIBCOL        = 0x00000100U,
    SSF_DESKTOPHTML          = 0x00000200U,
    SSF_WIN95CLASSIC         = 0x00000400U,
    SSF_DONTPRETTYPATH       = 0x00000800U,
    SSF_SHOWINFOTIP          = 0x00002000U,
    SSF_MAPNETDRVBUTTON      = 0x00001000U,
    SSF_NOCONFIRMRECYCLE     = 0x00008000U,
    SSF_HIDEICONS            = 0x00004000U,
    SSF_FILTER               = 0x00010000U,
    SSF_WEBVIEW              = 0x00020000U,
    SSF_SHOWSUPERHIDDEN      = 0x00040000U,
    SSF_SEPPROCESS           = 0x00080000U,
    SSF_NONETCRAWLING        = 0x00100000U,
    SSF_STARTPANELON         = 0x00200000U,
    SSF_SHOWSTARTPAGE        = 0x00400000U,
    SSF_AUTOCHECKSELECT      = 0x00800000U,
    SSF_ICONSONLY            = 0x01000000U,
    SSF_SHOWTYPEOVERLAY      = 0x02000000U,
    SSF_SHOWSTATUSBAR        = 0x04000000U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ASSOCF_str
alias ASSOCF = uint;
enum : uint
{
    ASSOCF_NONE                 = 0x00000000U,
    ASSOCF_INIT_NOREMAPCLSID    = 0x00000001U,
    ASSOCF_INIT_BYEXENAME       = 0x00000002U,
    ASSOCF_OPEN_BYEXENAME       = 0x00000002U,
    ASSOCF_INIT_DEFAULTTOSTAR   = 0x00000004U,
    ASSOCF_INIT_DEFAULTTOFOLDER = 0x00000008U,
    ASSOCF_NOUSERSETTINGS       = 0x00000010U,
    ASSOCF_NOTRUNCATE           = 0x00000020U,
    ASSOCF_VERIFY               = 0x00000040U,
    ASSOCF_REMAPRUNDLL          = 0x00000080U,
    ASSOCF_NOFIXUPS             = 0x00000100U,
    ASSOCF_IGNOREBASECLASS      = 0x00000200U,
    ASSOCF_INIT_IGNOREUNKNOWN   = 0x00000400U,
    ASSOCF_INIT_FIXED_PROGID    = 0x00000800U,
    ASSOCF_IS_PROTOCOL          = 0x00001000U,
    ASSOCF_INIT_FOR_FILE        = 0x00002000U,
    ASSOCF_IS_FULL_URI          = 0x00004000U,
    ASSOCF_PER_MACHINE_ONLY     = 0x00008000U,
    ASSOCF_APP_TO_APP           = 0x00010000U,
}

alias NOTIFY_ICON_MESSAGE = uint;
enum : uint
{
    NIM_ADD        = 0x00000000U,
    NIM_MODIFY     = 0x00000001U,
    NIM_DELETE     = 0x00000002U,
    NIM_SETFOCUS   = 0x00000003U,
    NIM_SETVERSION = 0x00000004U,
}

alias NOTIFY_ICON_DATA_FLAGS = uint;
enum : uint
{
    NIF_MESSAGE  = 0x00000001U,
    NIF_ICON     = 0x00000002U,
    NIF_TIP      = 0x00000004U,
    NIF_STATE    = 0x00000008U,
    NIF_INFO     = 0x00000010U,
    NIF_GUID     = 0x00000020U,
    NIF_REALTIME = 0x00000040U,
    NIF_SHOWTIP  = 0x00000080U,
}

alias OS = uint;
enum : uint
{
    OS_WINDOWS                = 0x00000000U,
    OS_NT                     = 0x00000001U,
    OS_WIN95ORGREATER         = 0x00000002U,
    OS_NT4ORGREATER           = 0x00000003U,
    OS_WIN98ORGREATER         = 0x00000005U,
    OS_WIN98_GOLD             = 0x00000006U,
    OS_WIN2000ORGREATER       = 0x00000007U,
    OS_WIN2000PRO             = 0x00000008U,
    OS_WIN2000SERVER          = 0x00000009U,
    OS_WIN2000ADVSERVER       = 0x0000000aU,
    OS_WIN2000DATACENTER      = 0x0000000bU,
    OS_WIN2000TERMINAL        = 0x0000000cU,
    OS_EMBEDDED               = 0x0000000dU,
    OS_TERMINALCLIENT         = 0x0000000eU,
    OS_TERMINALREMOTEADMIN    = 0x0000000fU,
    OS_WIN95_GOLD             = 0x00000010U,
    OS_MEORGREATER            = 0x00000011U,
    OS_XPORGREATER            = 0x00000012U,
    OS_HOME                   = 0x00000013U,
    OS_PROFESSIONAL           = 0x00000014U,
    OS_DATACENTER             = 0x00000015U,
    OS_ADVSERVER              = 0x00000016U,
    OS_SERVER                 = 0x00000017U,
    OS_TERMINALSERVER         = 0x00000018U,
    OS_PERSONALTERMINALSERVER = 0x00000019U,
    OS_FASTUSERSWITCHING      = 0x0000001aU,
    OS_WELCOMELOGONUI         = 0x0000001bU,
    OS_DOMAINMEMBER           = 0x0000001cU,
    OS_ANYSERVER              = 0x0000001dU,
    OS_WOW6432                = 0x0000001eU,
    OS_WEBSERVER              = 0x0000001fU,
    OS_SMALLBUSINESSSERVER    = 0x00000020U,
    OS_TABLETPC               = 0x00000021U,
    OS_SERVERADMINUI          = 0x00000022U,
    OS_MEDIACENTER            = 0x00000023U,
    OS_APPLIANCE              = 0x00000024U,
}

alias SHELL_AUTOCOMPLETE_FLAGS = uint;
enum : uint
{
    SHACF_DEFAULT               = 0x00000000U,
    SHACF_FILESYSTEM            = 0x00000001U,
    SHACF_URLALL                = 0x00000006U,
    SHACF_URLHISTORY            = 0x00000002U,
    SHACF_URLMRU                = 0x00000004U,
    SHACF_USETAB                = 0x00000008U,
    SHACF_FILESYS_ONLY          = 0x00000010U,
    SHACF_FILESYS_DIRS          = 0x00000020U,
    SHACF_VIRTUAL_NAMESPACE     = 0x00000040U,
    SHACF_AUTOSUGGEST_FORCE_ON  = 0x10000000U,
    SHACF_AUTOSUGGEST_FORCE_OFF = 0x20000000U,
    SHACF_AUTOAPPEND_FORCE_ON   = 0x40000000U,
    SHACF_AUTOAPPEND_FORCE_OFF  = 0x80000000U,
}

alias HELP_INFO_TYPE = int;
enum : int
{
    HELPINFO_WINDOW   = 0x00000001,
    HELPINFO_MENUITEM = 0x00000002,
}

alias NOTIFY_ICON_INFOTIP_FLAGS = uint;
enum : uint
{
    NIIF_NONE               = 0x00000000U,
    NIIF_INFO               = 0x00000001U,
    NIIF_WARNING            = 0x00000002U,
    NIIF_ERROR              = 0x00000003U,
    NIIF_USER               = 0x00000004U,
    NIIF_ICON_MASK          = 0x0000000fU,
    NIIF_NOSOUND            = 0x00000010U,
    NIIF_LARGE_ICON         = 0x00000020U,
    NIIF_RESPECT_QUIET_TIME = 0x00000080U,
}

alias NOTIFY_ICON_STATE = uint;
enum : uint
{
    NIS_HIDDEN     = 0x00000001U,
    NIS_SHAREDICON = 0x00000002U,
}

alias GPFIDL_FLAGS = uint;
enum : uint
{
    GPFIDL_DEFAULT    = 0x00000000U,
    GPFIDL_ALTNAME    = 0x00000001U,
    GPFIDL_UNCPRINTER = 0x00000002U,
}

alias SHGSI_FLAGS = uint;
enum : uint
{
    SHGSI_ICONLOCATION  = 0x00000000U,
    SHGSI_ICON          = 0x00000100U,
    SHGSI_SYSICONINDEX  = 0x00004000U,
    SHGSI_LINKOVERLAY   = 0x00008000U,
    SHGSI_SELECTED      = 0x00010000U,
    SHGSI_LARGEICON     = 0x00000000U,
    SHGSI_SMALLICON     = 0x00000001U,
    SHGSI_SHELLICONSIZE = 0x00000004U,
}

alias FILEOPERATION_FLAGS = uint;
enum : uint
{
    FOFX_NOSKIPJUNCTIONS        = 0x00010000U,
    FOFX_PREFERHARDLINK         = 0x00020000U,
    FOFX_SHOWELEVATIONPROMPT    = 0x00040000U,
    FOFX_RECYCLEONDELETE        = 0x00080000U,
    FOFX_EARLYFAILURE           = 0x00100000U,
    FOFX_PRESERVEFILEEXTENSIONS = 0x00200000U,
    FOFX_KEEPNEWERFILE          = 0x00400000U,
    FOFX_NOCOPYHOOKS            = 0x00800000U,
    FOFX_NOMINIMIZEBOX          = 0x01000000U,
    FOFX_MOVEACLSACROSSVOLUMES  = 0x02000000U,
    FOFX_DONTDISPLAYSOURCEPATH  = 0x04000000U,
    FOFX_DONTDISPLAYDESTPATH    = 0x08000000U,
    FOFX_REQUIREELEVATION       = 0x10000000U,
    FOFX_ADDUNDORECORD          = 0x20000000U,
    FOFX_COPYASDOWNLOAD         = 0x40000000U,
    FOFX_DONTDISPLAYLOCATIONS   = 0x80000000U,
    FOF_MULTIDESTFILES          = 0x00000001U,
    FOF_CONFIRMMOUSE            = 0x00000002U,
    FOF_SILENT                  = 0x00000004U,
    FOF_RENAMEONCOLLISION       = 0x00000008U,
    FOF_NOCONFIRMATION          = 0x00000010U,
    FOF_WANTMAPPINGHANDLE       = 0x00000020U,
    FOF_ALLOWUNDO               = 0x00000040U,
    FOF_FILESONLY               = 0x00000080U,
    FOF_SIMPLEPROGRESS          = 0x00000100U,
    FOF_NOCONFIRMMKDIR          = 0x00000200U,
    FOF_NOERRORUI               = 0x00000400U,
    FOF_NOCOPYSECURITYATTRIBS   = 0x00000800U,
    FOF_NORECURSION             = 0x00001000U,
    FOF_NO_CONNECTED_ELEMENTS   = 0x00002000U,
    FOF_WANTNUKEWARNING         = 0x00004000U,
    FOF_NORECURSEREPARSE        = 0x00008000U,
    FOF_NO_UI                   = 0x00000614U,
}

alias SHGDNF = uint;
enum : uint
{
    SHGDN_NORMAL        = 0x00000000U,
    SHGDN_INFOLDER      = 0x00000001U,
    SHGDN_FOREDITING    = 0x00001000U,
    SHGDN_FORADDRESSBAR = 0x00004000U,
    SHGDN_FORPARSING    = 0x00008000U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-_shcontf
alias _SHCONTF = int;
enum : int
{
    SHCONTF_CHECKING_FOR_CHILDREN = 0x00000010,
    SHCONTF_FOLDERS               = 0x00000020,
    SHCONTF_NONFOLDERS            = 0x00000040,
    SHCONTF_INCLUDEHIDDEN         = 0x00000080,
    SHCONTF_INIT_ON_FIRST_NEXT    = 0x00000100,
    SHCONTF_NETPRINTERSRCH        = 0x00000200,
    SHCONTF_SHAREABLE             = 0x00000400,
    SHCONTF_STORAGE               = 0x00000800,
    SHCONTF_NAVIGATION_ENUM       = 0x00001000,
    SHCONTF_FASTITEMS             = 0x00002000,
    SHCONTF_FLATLIST              = 0x00004000,
    SHCONTF_ENABLE_ASYNC          = 0x00008000,
    SHCONTF_INCLUDESUPERHIDDEN    = 0x00010000,
}

alias STORAGE_PROVIDER_FILE_FLAGS = int;
enum : int
{
    SPFF_NONE                   = 0x00000000,
    SPFF_DOWNLOAD_BY_DEFAULT    = 0x00000001,
    SPFF_CREATED_ON_THIS_DEVICE = 0x00000002,
}

alias MERGE_UPDATE_STATUS = int;
enum : int
{
    MUS_COMPLETE        = 0x00000000,
    MUS_USERINPUTNEEDED = 0x00000001,
    MUS_FAILED          = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-folder_enum_mode
alias FOLDER_ENUM_MODE = int;
enum : int
{
    FEM_VIEWRESULT = 0x00000000,
    FEM_NAVIGATION = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-folderflags
alias FOLDERFLAGS = int;
enum : int
{
    FWF_NONE                = 0x00000000,
    FWF_AUTOARRANGE         = 0x00000001,
    FWF_ABBREVIATEDNAMES    = 0x00000002,
    FWF_SNAPTOGRID          = 0x00000004,
    FWF_OWNERDATA           = 0x00000008,
    FWF_BESTFITWINDOW       = 0x00000010,
    FWF_DESKTOP             = 0x00000020,
    FWF_SINGLESEL           = 0x00000040,
    FWF_NOSUBFOLDERS        = 0x00000080,
    FWF_TRANSPARENT         = 0x00000100,
    FWF_NOCLIENTEDGE        = 0x00000200,
    FWF_NOSCROLL            = 0x00000400,
    FWF_ALIGNLEFT           = 0x00000800,
    FWF_NOICONS             = 0x00001000,
    FWF_SHOWSELALWAYS       = 0x00002000,
    FWF_NOVISIBLE           = 0x00004000,
    FWF_SINGLECLICKACTIVATE = 0x00008000,
    FWF_NOWEBVIEW           = 0x00010000,
    FWF_HIDEFILENAMES       = 0x00020000,
    FWF_CHECKSELECT         = 0x00040000,
    FWF_NOENUMREFRESH       = 0x00080000,
    FWF_NOGROUPING          = 0x00100000,
    FWF_FULLROWSELECT       = 0x00200000,
    FWF_NOFILTERS           = 0x00400000,
    FWF_NOCOLUMNHEADER      = 0x00800000,
    FWF_NOHEADERINALLVIEWS  = 0x01000000,
    FWF_EXTENDEDTILES       = 0x02000000,
    FWF_TRICHECKSELECT      = 0x04000000,
    FWF_AUTOCHECKSELECT     = 0x08000000,
    FWF_NOBROWSERVIEWSTATE  = 0x10000000,
    FWF_SUBSETGROUPS        = 0x20000000,
    FWF_USESEARCHFOLDER     = 0x40000000,
    FWF_ALLOWRTLREADING     = 0x80000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-folderviewmode
alias FOLDERVIEWMODE = int;
enum : int
{
    FVM_AUTO       = 0xffffffff,
    FVM_FIRST      = 0x00000001,
    FVM_ICON       = 0x00000001,
    FVM_SMALLICON  = 0x00000002,
    FVM_LIST       = 0x00000003,
    FVM_DETAILS    = 0x00000004,
    FVM_THUMBNAIL  = 0x00000005,
    FVM_TILE       = 0x00000006,
    FVM_THUMBSTRIP = 0x00000007,
    FVM_CONTENT    = 0x00000008,
    FVM_LAST       = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-folderlogicalviewmode
alias FOLDERLOGICALVIEWMODE = int;
enum : int
{
    FLVM_UNSPECIFIED = 0xffffffff,
    FLVM_FIRST       = 0x00000001,
    FLVM_DETAILS     = 0x00000001,
    FLVM_TILES       = 0x00000002,
    FLVM_ICONS       = 0x00000003,
    FLVM_LIST        = 0x00000004,
    FLVM_CONTENT     = 0x00000005,
    FLVM_LAST        = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-_svsif
alias _SVSIF = int;
enum : int
{
    SVSI_DESELECT       = 0x00000000,
    SVSI_SELECT         = 0x00000001,
    SVSI_EDIT           = 0x00000003,
    SVSI_DESELECTOTHERS = 0x00000004,
    SVSI_ENSUREVISIBLE  = 0x00000008,
    SVSI_FOCUSED        = 0x00000010,
    SVSI_TRANSLATEPT    = 0x00000020,
    SVSI_SELECTIONMARK  = 0x00000040,
    SVSI_POSITIONITEM   = 0x00000080,
    SVSI_CHECK          = 0x00000100,
    SVSI_CHECK2         = 0x00000200,
    SVSI_KEYBOARDSELECT = 0x00000401,
    SVSI_NOTAKEFOCUS    = 0x40000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-_svgio
alias _SVGIO = int;
enum : int
{
    SVGIO_BACKGROUND     = 0x00000000,
    SVGIO_SELECTION      = 0x00000001,
    SVGIO_ALLVIEW        = 0x00000002,
    SVGIO_CHECKED        = 0x00000003,
    SVGIO_TYPE_MASK      = 0x0000000f,
    SVGIO_FLAG_VIEWORDER = 0x80000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-svuia_status
alias SVUIA_STATUS = int;
enum : int
{
    SVUIA_DEACTIVATE       = 0x00000000,
    SVUIA_ACTIVATE_NOFOCUS = 0x00000001,
    SVUIA_ACTIVATE_FOCUS   = 0x00000002,
    SVUIA_INPLACEACTIVATE  = 0x00000003,
}

alias SORTDIRECTION = int;
enum : int
{
    SORT_DESCENDING = 0xffffffff,
    SORT_ASCENDING  = 0x00000001,
}

alias FVTEXTTYPE = int;
enum : int
{
    FVST_EMPTYTEXT = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-cm_mask
alias CM_MASK = int;
enum : int
{
    CM_MASK_WIDTH        = 0x00000001,
    CM_MASK_DEFAULTWIDTH = 0x00000002,
    CM_MASK_IDEALWIDTH   = 0x00000004,
    CM_MASK_NAME         = 0x00000008,
    CM_MASK_STATE        = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-cm_state
alias CM_STATE = int;
enum : int
{
    CM_STATE_NONE               = 0x00000000,
    CM_STATE_VISIBLE            = 0x00000001,
    CM_STATE_FIXEDWIDTH         = 0x00000002,
    CM_STATE_NOSORTBYFOLDERNESS = 0x00000004,
    CM_STATE_ALWAYSVISIBLE      = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-cm_enum_flags
alias CM_ENUM_FLAGS = int;
enum : int
{
    CM_ENUM_ALL     = 0x00000001,
    CM_ENUM_VISIBLE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-cm_set_width_value
alias CM_SET_WIDTH_VALUE = int;
enum : int
{
    CM_WIDTH_USEDEFAULT = 0xffffffff,
    CM_WIDTH_AUTOSIZE   = 0xfffffffe,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-sigdn
alias SIGDN = int;
enum : int
{
    SIGDN_NORMALDISPLAY               = 0x00000000,
    SIGDN_PARENTRELATIVEPARSING       = 0x80018001,
    SIGDN_DESKTOPABSOLUTEPARSING      = 0x80028000,
    SIGDN_PARENTRELATIVEEDITING       = 0x80031001,
    SIGDN_DESKTOPABSOLUTEEDITING      = 0x8004c000,
    SIGDN_FILESYSPATH                 = 0x80058000,
    SIGDN_URL                         = 0x80068000,
    SIGDN_PARENTRELATIVEFORADDRESSBAR = 0x8007c001,
    SIGDN_PARENTRELATIVE              = 0x80080001,
    SIGDN_PARENTRELATIVEFORUI         = 0x80094001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-_sichintf
alias _SICHINTF = int;
enum : int
{
    SICHINT_DISPLAY                       = 0x00000000,
    SICHINT_ALLFIELDS                     = 0x80000000,
    SICHINT_CANONICAL                     = 0x10000000,
    SICHINT_TEST_FILESYSPATH_IF_NOT_EQUAL = 0x20000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-dataobj_get_item_flags
alias DATAOBJ_GET_ITEM_FLAGS = int;
enum : int
{
    DOGIF_DEFAULT       = 0x00000000,
    DOGIF_TRAVERSE_LINK = 0x00000001,
    DOGIF_NO_HDROP      = 0x00000002,
    DOGIF_NO_URL        = 0x00000004,
    DOGIF_ONLY_IF_ONE   = 0x00000008,
}

alias SIIGBF = int;
enum : int
{
    SIIGBF_RESIZETOFIT    = 0x00000000,
    SIIGBF_BIGGERSIZEOK   = 0x00000001,
    SIIGBF_MEMORYONLY     = 0x00000002,
    SIIGBF_ICONONLY       = 0x00000004,
    SIIGBF_THUMBNAILONLY  = 0x00000008,
    SIIGBF_INCACHEONLY    = 0x00000010,
    SIIGBF_CROPTOSQUARE   = 0x00000020,
    SIIGBF_WIDETHUMBNAILS = 0x00000040,
    SIIGBF_ICONBACKGROUND = 0x00000080,
    SIIGBF_SCALEUP        = 0x00000100,
}

alias STGOP = int;
enum : int
{
    STGOP_MOVE            = 0x00000001,
    STGOP_COPY            = 0x00000002,
    STGOP_SYNC            = 0x00000003,
    STGOP_REMOVE          = 0x00000005,
    STGOP_RENAME          = 0x00000006,
    STGOP_APPLYPROPERTIES = 0x00000008,
    STGOP_NEW             = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-_transfer_source_flags
alias _TRANSFER_SOURCE_FLAGS = int;
enum : int
{
    TSF_NORMAL                     = 0x00000000,
    TSF_FAIL_EXIST                 = 0x00000000,
    TSF_RENAME_EXIST               = 0x00000001,
    TSF_OVERWRITE_EXIST            = 0x00000002,
    TSF_ALLOW_DECRYPTION           = 0x00000004,
    TSF_NO_SECURITY                = 0x00000008,
    TSF_COPY_CREATION_TIME         = 0x00000010,
    TSF_COPY_WRITE_TIME            = 0x00000020,
    TSF_USE_FULL_ACCESS            = 0x00000040,
    TSF_DELETE_RECYCLE_IF_POSSIBLE = 0x00000080,
    TSF_COPY_HARD_LINK             = 0x00000100,
    TSF_COPY_LOCALIZED_NAME        = 0x00000200,
    TSF_MOVE_AS_COPY_DELETE        = 0x00000400,
    TSF_SUSPEND_SHELLEVENTS        = 0x00000800,
}

alias _TRANSFER_ADVISE_STATE = int;
enum : int
{
    TS_NONE          = 0x00000000,
    TS_PERFORMING    = 0x00000001,
    TS_PREPARING     = 0x00000002,
    TS_INDETERMINATE = 0x00000004,
}

alias SIATTRIBFLAGS = int;
enum : int
{
    SIATTRIBFLAGS_AND       = 0x00000001,
    SIATTRIBFLAGS_OR        = 0x00000002,
    SIATTRIBFLAGS_APPCOMPAT = 0x00000003,
    SIATTRIBFLAGS_MASK      = 0x00000003,
    SIATTRIBFLAGS_ALLITEMS  = 0x00004000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-categoryinfo_flags
alias CATEGORYINFO_FLAGS = int;
enum : int
{
    CATINFO_NORMAL          = 0x00000000,
    CATINFO_COLLAPSED       = 0x00000001,
    CATINFO_HIDDEN          = 0x00000002,
    CATINFO_EXPANDED        = 0x00000004,
    CATINFO_NOHEADER        = 0x00000008,
    CATINFO_NOTCOLLAPSIBLE  = 0x00000010,
    CATINFO_NOHEADERCOUNT   = 0x00000020,
    CATINFO_SUBSETTED       = 0x00000040,
    CATINFO_SEPARATE_IMAGES = 0x00000080,
    CATINFO_SHOWEMPTY       = 0x00000100,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-catsort_flags
alias CATSORT_FLAGS = int;
enum : int
{
    CATSORT_DEFAULT = 0x00000000,
    CATSORT_NAME    = 0x00000001,
}

alias SLR_FLAGS = int;
enum : int
{
    SLR_NONE                      = 0x00000000,
    SLR_NO_UI                     = 0x00000001,
    SLR_ANY_MATCH                 = 0x00000002,
    SLR_UPDATE                    = 0x00000004,
    SLR_NOUPDATE                  = 0x00000008,
    SLR_NOSEARCH                  = 0x00000010,
    SLR_NOTRACK                   = 0x00000020,
    SLR_NOLINKINFO                = 0x00000040,
    SLR_INVOKE_MSI                = 0x00000080,
    SLR_NO_UI_WITH_MSG_PUMP       = 0x00000101,
    SLR_OFFER_DELETE_WITHOUT_FILE = 0x00000200,
    SLR_KNOWNFOLDER               = 0x00000400,
    SLR_MACHINE_IN_LOCAL_TARGET   = 0x00000800,
    SLR_UPDATE_MACHINE_AND_SID    = 0x00001000,
    SLR_NO_OBJECT_ID              = 0x00002000,
}

alias SLGP_FLAGS = int;
enum : int
{
    SLGP_SHORTPATH        = 0x00000001,
    SLGP_UNCPRIORITY      = 0x00000002,
    SLGP_RAWPATH          = 0x00000004,
    SLGP_RELATIVEPRIORITY = 0x00000008,
}

alias _SPINITF = int;
enum : int
{
    SPINITF_NORMAL     = 0x00000000,
    SPINITF_MODAL      = 0x00000001,
    SPINITF_NOMINIMIZE = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-_spbeginf
alias _SPBEGINF = int;
enum : int
{
    SPBEGINF_NORMAL          = 0x00000000,
    SPBEGINF_AUTOTIME        = 0x00000002,
    SPBEGINF_NOPROGRESSBAR   = 0x00000010,
    SPBEGINF_MARQUEEPROGRESS = 0x00000020,
    SPBEGINF_NOCANCELBUTTON  = 0x00000040,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-spaction
alias SPACTION = int;
enum : int
{
    SPACTION_NONE               = 0x00000000,
    SPACTION_MOVING             = 0x00000001,
    SPACTION_COPYING            = 0x00000002,
    SPACTION_RECYCLING          = 0x00000003,
    SPACTION_APPLYINGATTRIBS    = 0x00000004,
    SPACTION_DOWNLOADING        = 0x00000005,
    SPACTION_SEARCHING_INTERNET = 0x00000006,
    SPACTION_CALCULATING        = 0x00000007,
    SPACTION_UPLOADING          = 0x00000008,
    SPACTION_SEARCHING_FILES    = 0x00000009,
    SPACTION_DELETING           = 0x0000000a,
    SPACTION_RENAMING           = 0x0000000b,
    SPACTION_FORMATTING         = 0x0000000c,
    SPACTION_COPY_MOVING        = 0x0000000d,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-sptext
alias SPTEXT = int;
enum : int
{
    SPTEXT_ACTIONDESCRIPTION = 0x00000001,
    SPTEXT_ACTIONDETAIL      = 0x00000002,
}

alias _EXPPS = int;
enum : int
{
    EXPPS_FILETYPES = 0x00000001,
}

alias DESKBANDCID = int;
enum : int
{
    DBID_BANDINFOCHANGED = 0x00000000,
    DBID_SHOWONLY        = 0x00000001,
    DBID_MAXIMIZEBAND    = 0x00000002,
    DBID_PUSHCHEVRON     = 0x00000003,
    DBID_DELAYINIT       = 0x00000004,
    DBID_FINISHINIT      = 0x00000005,
    DBID_SETWINDOWTHEME  = 0x00000006,
    DBID_PERMITAUTOHIDE  = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-thumbbuttonflags
alias THUMBBUTTONFLAGS = int;
enum : int
{
    THBF_ENABLED        = 0x00000000,
    THBF_DISABLED       = 0x00000001,
    THBF_DISMISSONCLICK = 0x00000002,
    THBF_NOBACKGROUND   = 0x00000004,
    THBF_HIDDEN         = 0x00000008,
    THBF_NONINTERACTIVE = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-thumbbuttonmask
alias THUMBBUTTONMASK = int;
enum : int
{
    THB_BITMAP  = 0x00000001,
    THB_ICON    = 0x00000002,
    THB_TOOLTIP = 0x00000004,
    THB_FLAGS   = 0x00000008,
}

alias TBPFLAG = int;
enum : int
{
    TBPF_NOPROGRESS    = 0x00000000,
    TBPF_INDETERMINATE = 0x00000001,
    TBPF_NORMAL        = 0x00000002,
    TBPF_ERROR         = 0x00000004,
    TBPF_PAUSED        = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-stpflag
alias STPFLAG = int;
enum : int
{
    STPF_NONE                      = 0x00000000,
    STPF_USEAPPTHUMBNAILALWAYS     = 0x00000001,
    STPF_USEAPPTHUMBNAILWHENACTIVE = 0x00000002,
    STPF_USEAPPPEEKALWAYS          = 0x00000004,
    STPF_USEAPPPEEKWHENACTIVE      = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-explorer_browser_options
alias EXPLORER_BROWSER_OPTIONS = int;
enum : int
{
    EBO_NONE               = 0x00000000,
    EBO_NAVIGATEONCE       = 0x00000001,
    EBO_SHOWFRAMES         = 0x00000002,
    EBO_ALWAYSNAVIGATE     = 0x00000004,
    EBO_NOTRAVELLOG        = 0x00000008,
    EBO_NOWRAPPERWINDOW    = 0x00000010,
    EBO_HTMLSHAREPOINTVIEW = 0x00000020,
    EBO_NOBORDER           = 0x00000040,
    EBO_NOPERSISTVIEWSTATE = 0x00000080,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-explorer_browser_fill_flags
alias EXPLORER_BROWSER_FILL_FLAGS = int;
enum : int
{
    EBF_NONE                 = 0x00000000,
    EBF_SELECTFROMDATAOBJECT = 0x00000100,
    EBF_NODROPTARGET         = 0x00000200,
}

alias _OPPROGDLGF = int;
enum : int
{
    OPPROGDLG_DEFAULT               = 0x00000000,
    OPPROGDLG_ENABLEPAUSE           = 0x00000080,
    OPPROGDLG_ALLOWUNDO             = 0x00000100,
    OPPROGDLG_DONTDISPLAYSOURCEPATH = 0x00000200,
    OPPROGDLG_DONTDISPLAYDESTPATH   = 0x00000400,
    OPPROGDLG_NOMULTIDAYESTIMATES   = 0x00000800,
    OPPROGDLG_DONTDISPLAYLOCATIONS  = 0x00001000,
}

alias _PDMODE = int;
enum : int
{
    PDM_DEFAULT        = 0x00000000,
    PDM_RUN            = 0x00000001,
    PDM_PREFLIGHT      = 0x00000002,
    PDM_UNDOING        = 0x00000004,
    PDM_ERRORSBLOCKING = 0x00000008,
    PDM_INDETERMINATE  = 0x00000010,
}

alias FILE_OPERATION_FLAGS2 = int;
enum : int
{
    FOF2_NONE                    = 0x00000000,
    FOF2_MERGEFOLDERSONCOLLISION = 0x00000001,
}

alias NAMESPACEWALKFLAG = int;
enum : int
{
    NSWF_DEFAULT                        = 0x00000000,
    NSWF_NONE_IMPLIES_ALL               = 0x00000001,
    NSWF_ONE_IMPLIES_ALL                = 0x00000002,
    NSWF_DONT_TRAVERSE_LINKS            = 0x00000004,
    NSWF_DONT_ACCUMULATE_RESULT         = 0x00000008,
    NSWF_TRAVERSE_STREAM_JUNCTIONS      = 0x00000010,
    NSWF_FILESYSTEM_ONLY                = 0x00000020,
    NSWF_SHOW_PROGRESS                  = 0x00000040,
    NSWF_FLAG_VIEWORDER                 = 0x00000080,
    NSWF_IGNORE_AUTOPLAY_HIDA           = 0x00000100,
    NSWF_ASYNC                          = 0x00000200,
    NSWF_DONT_RESOLVE_LINKS             = 0x00000400,
    NSWF_ACCUMULATE_FOLDERS             = 0x00000800,
    NSWF_DONT_SORT                      = 0x00001000,
    NSWF_USE_TRANSFER_MEDIUM            = 0x00002000,
    NSWF_DONT_TRAVERSE_STREAM_JUNCTIONS = 0x00004000,
    NSWF_ANY_IMPLIES_ALL                = 0x00008000,
}

alias BANDSITECID = int;
enum : int
{
    BSID_BANDADDED   = 0x00000000,
    BSID_BANDREMOVED = 0x00000001,
}

alias MENUBANDHANDLERCID = int;
enum : int
{
    MBHANDCID_PIDLSELECT = 0x00000000,
}

alias MENUPOPUPSELECT = int;
enum : int
{
    MPOS_EXECUTE       = 0x00000000,
    MPOS_FULLCANCEL    = 0x00000001,
    MPOS_CANCELLEVEL   = 0x00000002,
    MPOS_SELECTLEFT    = 0x00000003,
    MPOS_SELECTRIGHT   = 0x00000004,
    MPOS_CHILDTRACKING = 0x00000005,
}

alias MENUPOPUPPOPUPFLAGS = int;
enum : int
{
    MPPF_SETFOCUS      = 0x00000001,
    MPPF_INITIALSELECT = 0x00000002,
    MPPF_NOANIMATE     = 0x00000004,
    MPPF_KEYBOARD      = 0x00000010,
    MPPF_REPOSITION    = 0x00000020,
    MPPF_FORCEZORDER   = 0x00000040,
    MPPF_FINALSELECT   = 0x00000080,
    MPPF_TOP           = 0x20000000,
    MPPF_LEFT          = 0x40000000,
    MPPF_RIGHT         = 0x60000000,
    MPPF_BOTTOM        = 0x80000000,
    MPPF_POS_MASK      = 0xe0000000,
    MPPF_ALIGN_LEFT    = 0x02000000,
    MPPF_ALIGN_RIGHT   = 0x04000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-file_usage_type
alias FILE_USAGE_TYPE = int;
enum : int
{
    FUT_PLAYING = 0x00000000,
    FUT_EDITING = 0x00000001,
    FUT_GENERIC = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-fde_overwrite_response
alias FDE_OVERWRITE_RESPONSE = int;
enum : int
{
    FDEOR_DEFAULT = 0x00000000,
    FDEOR_ACCEPT  = 0x00000001,
    FDEOR_REFUSE  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-fde_shareviolation_response
alias FDE_SHAREVIOLATION_RESPONSE = int;
enum : int
{
    FDESVR_DEFAULT = 0x00000000,
    FDESVR_ACCEPT  = 0x00000001,
    FDESVR_REFUSE  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-fdap
alias FDAP = int;
enum : int
{
    FDAP_BOTTOM = 0x00000000,
    FDAP_TOP    = 0x00000001,
}

alias FILEOPENDIALOGOPTIONS = uint;
enum : uint
{
    FOS_OVERWRITEPROMPT          = 0x00000002U,
    FOS_STRICTFILETYPES          = 0x00000004U,
    FOS_NOCHANGEDIR              = 0x00000008U,
    FOS_PICKFOLDERS              = 0x00000020U,
    FOS_FORCEFILESYSTEM          = 0x00000040U,
    FOS_ALLNONSTORAGEITEMS       = 0x00000080U,
    FOS_NOVALIDATE               = 0x00000100U,
    FOS_ALLOWMULTISELECT         = 0x00000200U,
    FOS_PATHMUSTEXIST            = 0x00000800U,
    FOS_FILEMUSTEXIST            = 0x00001000U,
    FOS_CREATEPROMPT             = 0x00002000U,
    FOS_SHAREAWARE               = 0x00004000U,
    FOS_NOREADONLYRETURN         = 0x00008000U,
    FOS_NOTESTFILECREATE         = 0x00010000U,
    FOS_HIDEMRUPLACES            = 0x00020000U,
    FOS_HIDEPINNEDPLACES         = 0x00040000U,
    FOS_NODEREFERENCELINKS       = 0x00100000U,
    FOS_OKBUTTONNEEDSINTERACTION = 0x00200000U,
    FOS_DONTADDTORECENT          = 0x02000000U,
    FOS_FORCESHOWHIDDEN          = 0x10000000U,
    FOS_DEFAULTNOMINIMODE        = 0x20000000U,
    FOS_FORCEPREVIEWPANEON       = 0x40000000U,
    FOS_SUPPORTSTREAMABLEITEMS   = 0x80000000U,
}

alias CDCONTROLSTATEF = int;
enum : int
{
    CDCS_INACTIVE       = 0x00000000,
    CDCS_ENABLED        = 0x00000001,
    CDCS_VISIBLE        = 0x00000002,
    CDCS_ENABLEDVISIBLE = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-associationlevel
alias ASSOCIATIONLEVEL = int;
enum : int
{
    AL_MACHINE   = 0x00000000,
    AL_EFFECTIVE = 0x00000001,
    AL_USER      = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-associationtype
alias ASSOCIATIONTYPE = int;
enum : int
{
    AT_FILEEXTENSION   = 0x00000000,
    AT_URLPROTOCOL     = 0x00000001,
    AT_STARTMENUCLIENT = 0x00000002,
    AT_MIMETYPE        = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-_browserframeoptions
alias _BROWSERFRAMEOPTIONS = int;
enum : int
{
    BFO_NONE                             = 0x00000000,
    BFO_BROWSER_PERSIST_SETTINGS         = 0x00000001,
    BFO_RENAME_FOLDER_OPTIONS_TOINTERNET = 0x00000002,
    BFO_BOTH_OPTIONS                     = 0x00000004,
    BIF_PREFER_INTERNET_SHORTCUT         = 0x00000008,
    BFO_BROWSE_NO_IN_NEW_PROCESS         = 0x00000010,
    BFO_ENABLE_HYPERLINK_TRACKING        = 0x00000020,
    BFO_USE_IE_OFFLINE_SUPPORT           = 0x00000040,
    BFO_SUBSTITUE_INTERNET_START_PAGE    = 0x00000080,
    BFO_USE_IE_LOGOBANDING               = 0x00000100,
    BFO_ADD_IE_TOCAPTIONBAR              = 0x00000200,
    BFO_USE_DIALUP_REF                   = 0x00000400,
    BFO_USE_IE_TOOLBAR                   = 0x00000800,
    BFO_NO_PARENT_FOLDER_SUPPORT         = 0x00001000,
    BFO_NO_REOPEN_NEXT_RESTART           = 0x00002000,
    BFO_GO_HOME_PAGE                     = 0x00004000,
    BFO_PREFER_IEPROCESS                 = 0x00008000,
    BFO_SHOW_NAVIGATION_CANCELLED        = 0x00010000,
    BFO_USE_IE_STATUSBAR                 = 0x00020000,
    BFO_QUERY_ALL                        = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-nwmf
alias NWMF = int;
enum : int
{
    NWMF_UNLOADING       = 0x00000001,
    NWMF_USERINITED      = 0x00000002,
    NWMF_FIRST           = 0x00000004,
    NWMF_OVERRIDEKEY     = 0x00000008,
    NWMF_SHOWHELP        = 0x00000010,
    NWMF_HTMLDIALOG      = 0x00000020,
    NWMF_FROMDIALOGCHILD = 0x00000040,
    NWMF_USERREQUESTED   = 0x00000080,
    NWMF_USERALLOWED     = 0x00000100,
    NWMF_FORCEWINDOW     = 0x00010000,
    NWMF_FORCETAB        = 0x00020000,
    NWMF_SUGGESTWINDOW   = 0x00040000,
    NWMF_SUGGESTTAB      = 0x00080000,
    NWMF_INACTIVETAB     = 0x00100000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-attachment_prompt
alias ATTACHMENT_PROMPT = int;
enum : int
{
    ATTACHMENT_PROMPT_NONE         = 0x00000000,
    ATTACHMENT_PROMPT_SAVE         = 0x00000001,
    ATTACHMENT_PROMPT_EXEC         = 0x00000002,
    ATTACHMENT_PROMPT_EXEC_OR_SAVE = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-attachment_action
alias ATTACHMENT_ACTION = int;
enum : int
{
    ATTACHMENT_ACTION_CANCEL = 0x00000000,
    ATTACHMENT_ACTION_SAVE   = 0x00000001,
    ATTACHMENT_ACTION_EXEC   = 0x00000002,
}

alias SMINFOMASK = int;
enum : int
{
    SMIM_TYPE  = 0x00000001,
    SMIM_FLAGS = 0x00000002,
    SMIM_ICON  = 0x00000004,
}

alias SMINFOTYPE = int;
enum : int
{
    SMIT_SEPARATOR = 0x00000001,
    SMIT_STRING    = 0x00000002,
}

alias SMINFOFLAGS = int;
enum : int
{
    SMIF_ICON        = 0x00000001,
    SMIF_ACCELERATOR = 0x00000002,
    SMIF_DROPTARGET  = 0x00000004,
    SMIF_SUBMENU     = 0x00000008,
    SMIF_CHECKED     = 0x00000020,
    SMIF_DROPCASCADE = 0x00000040,
    SMIF_HIDDEN      = 0x00000080,
    SMIF_DISABLED    = 0x00000100,
    SMIF_TRACKPOPUP  = 0x00000200,
    SMIF_DEMOTED     = 0x00000400,
    SMIF_ALTSTATE    = 0x00000800,
    SMIF_DRAGNDROP   = 0x00001000,
    SMIF_NEW         = 0x00002000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-kf_category
alias KF_CATEGORY = int;
enum : int
{
    KF_CATEGORY_VIRTUAL = 0x00000001,
    KF_CATEGORY_FIXED   = 0x00000002,
    KF_CATEGORY_COMMON  = 0x00000003,
    KF_CATEGORY_PERUSER = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-_kf_definition_flags
alias _KF_DEFINITION_FLAGS = int;
enum : int
{
    KFDF_LOCAL_REDIRECT_ONLY = 0x00000002,
    KFDF_ROAMABLE            = 0x00000004,
    KFDF_PRECREATE           = 0x00000008,
    KFDF_STREAM              = 0x00000010,
    KFDF_PUBLISHEXPANDEDPATH = 0x00000020,
    KFDF_NO_REDIRECT_UI      = 0x00000040,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-_kf_redirect_flags
alias _KF_REDIRECT_FLAGS = int;
enum : int
{
    KF_REDIRECT_USER_EXCLUSIVE               = 0x00000001,
    KF_REDIRECT_COPY_SOURCE_DACL             = 0x00000002,
    KF_REDIRECT_OWNER_USER                   = 0x00000004,
    KF_REDIRECT_SET_OWNER_EXPLICIT           = 0x00000008,
    KF_REDIRECT_CHECK_ONLY                   = 0x00000010,
    KF_REDIRECT_WITH_UI                      = 0x00000020,
    KF_REDIRECT_UNPIN                        = 0x00000040,
    KF_REDIRECT_PIN                          = 0x00000080,
    KF_REDIRECT_COPY_CONTENTS                = 0x00000200,
    KF_REDIRECT_DEL_SOURCE_CONTENTS          = 0x00000400,
    KF_REDIRECT_EXCLUDE_ALL_KNOWN_SUBFOLDERS = 0x00000800,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-_kf_redirection_capabilities
alias _KF_REDIRECTION_CAPABILITIES = int;
enum : int
{
    KF_REDIRECTION_CAPABILITIES_ALLOW_ALL              = 0x000000ff,
    KF_REDIRECTION_CAPABILITIES_REDIRECTABLE           = 0x00000001,
    KF_REDIRECTION_CAPABILITIES_DENY_ALL               = 0x000fff00,
    KF_REDIRECTION_CAPABILITIES_DENY_POLICY_REDIRECTED = 0x00000100,
    KF_REDIRECTION_CAPABILITIES_DENY_POLICY            = 0x00000200,
    KF_REDIRECTION_CAPABILITIES_DENY_PERMISSIONS       = 0x00000400,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-fffp_mode
alias FFFP_MODE = int;
enum : int
{
    FFFP_EXACTMATCH         = 0x00000000,
    FFFP_NEARESTPARENTMATCH = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-share_role
alias SHARE_ROLE = int;
enum : int
{
    SHARE_ROLE_INVALID     = 0xffffffff,
    SHARE_ROLE_READER      = 0x00000000,
    SHARE_ROLE_CONTRIBUTOR = 0x00000001,
    SHARE_ROLE_CO_OWNER    = 0x00000002,
    SHARE_ROLE_OWNER       = 0x00000003,
    SHARE_ROLE_CUSTOM      = 0x00000004,
    SHARE_ROLE_MIXED       = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-def_share_id
alias DEF_SHARE_ID = int;
enum : int
{
    DEFSHAREID_USERS  = 0x00000001,
    DEFSHAREID_PUBLIC = 0x00000002,
}

alias _NMCII_FLAGS = int;
enum : int
{
    NMCII_NONE    = 0x00000000,
    NMCII_ITEMS   = 0x00000001,
    NMCII_FOLDERS = 0x00000002,
}

alias _NMCSAEI_FLAGS = int;
enum : int
{
    NMCSAEI_SELECT = 0x00000000,
    NMCSAEI_EDIT   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-_nstcstyle
alias _NSTCSTYLE = int;
enum : int
{
    NSTCS_HASEXPANDOS         = 0x00000001,
    NSTCS_HASLINES            = 0x00000002,
    NSTCS_SINGLECLICKEXPAND   = 0x00000004,
    NSTCS_FULLROWSELECT       = 0x00000008,
    NSTCS_SPRINGEXPAND        = 0x00000010,
    NSTCS_HORIZONTALSCROLL    = 0x00000020,
    NSTCS_ROOTHASEXPANDO      = 0x00000040,
    NSTCS_SHOWSELECTIONALWAYS = 0x00000080,
    NSTCS_NOINFOTIP           = 0x00000200,
    NSTCS_EVENHEIGHT          = 0x00000400,
    NSTCS_NOREPLACEOPEN       = 0x00000800,
    NSTCS_DISABLEDRAGDROP     = 0x00001000,
    NSTCS_NOORDERSTREAM       = 0x00002000,
    NSTCS_RICHTOOLTIP         = 0x00004000,
    NSTCS_BORDER              = 0x00008000,
    NSTCS_NOEDITLABELS        = 0x00010000,
    NSTCS_TABSTOP             = 0x00020000,
    NSTCS_FAVORITESMODE       = 0x00080000,
    NSTCS_AUTOHSCROLL         = 0x00100000,
    NSTCS_FADEINOUTEXPANDOS   = 0x00200000,
    NSTCS_EMPTYTEXT           = 0x00400000,
    NSTCS_CHECKBOXES          = 0x00800000,
    NSTCS_PARTIALCHECKBOXES   = 0x01000000,
    NSTCS_EXCLUSIONCHECKBOXES = 0x02000000,
    NSTCS_DIMMEDCHECKBOXES    = 0x04000000,
    NSTCS_NOINDENTCHECKS      = 0x08000000,
    NSTCS_ALLOWJUNCTIONS      = 0x10000000,
    NSTCS_SHOWTABSBUTTON      = 0x20000000,
    NSTCS_SHOWDELETEBUTTON    = 0x40000000,
    NSTCS_SHOWREFRESHBUTTON   = 0x80000000,
}

alias _NSTCROOTSTYLE = int;
enum : int
{
    NSTCRS_VISIBLE  = 0x00000000,
    NSTCRS_HIDDEN   = 0x00000001,
    NSTCRS_EXPANDED = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-_nstcitemstate
alias _NSTCITEMSTATE = int;
enum : int
{
    NSTCIS_NONE             = 0x00000000,
    NSTCIS_SELECTED         = 0x00000001,
    NSTCIS_EXPANDED         = 0x00000002,
    NSTCIS_BOLD             = 0x00000004,
    NSTCIS_DISABLED         = 0x00000008,
    NSTCIS_SELECTEDNOEXPAND = 0x00000010,
}

alias NSTCGNI = int;
enum : int
{
    NSTCGNI_NEXT         = 0x00000000,
    NSTCGNI_NEXTVISIBLE  = 0x00000001,
    NSTCGNI_PREV         = 0x00000002,
    NSTCGNI_PREVVISIBLE  = 0x00000003,
    NSTCGNI_PARENT       = 0x00000004,
    NSTCGNI_CHILD        = 0x00000005,
    NSTCGNI_FIRSTVISIBLE = 0x00000006,
    NSTCGNI_LASTVISIBLE  = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-nstcfoldercapabilities
alias NSTCFOLDERCAPABILITIES = int;
enum : int
{
    NSTCFC_NONE                  = 0x00000000,
    NSTCFC_PINNEDITEMFILTERING   = 0x00000001,
    NSTCFC_DELAY_REGISTER_NOTIFY = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-_explorerpanestate
alias _EXPLORERPANESTATE = int;
enum : int
{
    EPS_DONTCARE     = 0x00000000,
    EPS_DEFAULT_ON   = 0x00000001,
    EPS_DEFAULT_OFF  = 0x00000002,
    EPS_STATEMASK    = 0x0000ffff,
    EPS_INITIALSTATE = 0x00010000,
    EPS_FORCE        = 0x00020000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-_expcmdstate
alias _EXPCMDSTATE = int;
enum : int
{
    ECS_ENABLED    = 0x00000000,
    ECS_DISABLED   = 0x00000001,
    ECS_HIDDEN     = 0x00000002,
    ECS_CHECKBOX   = 0x00000004,
    ECS_CHECKED    = 0x00000008,
    ECS_RADIOCHECK = 0x00000010,
}

alias _EXPCMDFLAGS = int;
enum : int
{
    ECF_DEFAULT         = 0x00000000,
    ECF_HASSUBCOMMANDS  = 0x00000001,
    ECF_HASSPLITBUTTON  = 0x00000002,
    ECF_HIDELABEL       = 0x00000004,
    ECF_ISSEPARATOR     = 0x00000008,
    ECF_HASLUASHIELD    = 0x00000010,
    ECF_SEPARATORBEFORE = 0x00000020,
    ECF_SEPARATORAFTER  = 0x00000040,
    ECF_ISDROPDOWN      = 0x00000080,
    ECF_TOGGLEABLE      = 0x00000100,
    ECF_AUTOMENUICONS   = 0x00000200,
}

alias CPVIEW = int;
enum : int
{
    CPVIEW_CLASSIC  = 0x00000000,
    CPVIEW_ALLITEMS = 0x00000000,
    CPVIEW_CATEGORY = 0x00000001,
    CPVIEW_HOME     = 0x00000001,
}

alias KNOWNDESTCATEGORY = int;
enum : int
{
    KDC_FREQUENT = 0x00000001,
    KDC_RECENT   = 0x00000002,
}

alias APPDOCLISTTYPE = int;
enum : int
{
    ADLT_RECENT   = 0x00000000,
    ADLT_FREQUENT = 0x00000001,
}

alias DESKTOP_SLIDESHOW_OPTIONS = int;
enum : int
{
    DSO_SHUFFLEIMAGES = 0x00000001,
}

alias DESKTOP_SLIDESHOW_STATE = int;
enum : int
{
    DSS_ENABLED                    = 0x00000001,
    DSS_SLIDESHOW                  = 0x00000002,
    DSS_DISABLED_BY_REMOTE_SESSION = 0x00000004,
}

alias DESKTOP_SLIDESHOW_DIRECTION = int;
enum : int
{
    DSD_FORWARD  = 0x00000000,
    DSD_BACKWARD = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-desktop_wallpaper_position
alias DESKTOP_WALLPAPER_POSITION = int;
enum : int
{
    DWPOS_CENTER  = 0x00000000,
    DWPOS_TILE    = 0x00000001,
    DWPOS_STRETCH = 0x00000002,
    DWPOS_FIT     = 0x00000003,
    DWPOS_FILL    = 0x00000004,
    DWPOS_SPAN    = 0x00000005,
}

alias HOMEGROUPSHARINGCHOICES = int;
enum : int
{
    HGSC_NONE             = 0x00000000,
    HGSC_MUSICLIBRARY     = 0x00000001,
    HGSC_PICTURESLIBRARY  = 0x00000002,
    HGSC_VIDEOSLIBRARY    = 0x00000004,
    HGSC_DOCUMENTSLIBRARY = 0x00000008,
    HGSC_PRINTERS         = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-libraryfolderfilter
alias LIBRARYFOLDERFILTER = int;
enum : int
{
    LFF_FORCEFILESYSTEM = 0x00000001,
    LFF_STORAGEITEMS    = 0x00000002,
    LFF_ALLITEMS        = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-libraryoptionflags
alias LIBRARYOPTIONFLAGS = int;
enum : int
{
    LOF_DEFAULT         = 0x00000000,
    LOF_PINNEDTONAVPANE = 0x00000001,
    LOF_MASK_ALL        = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-defaultsavefoldertype
alias DEFAULTSAVEFOLDERTYPE = int;
enum : int
{
    DSFT_DETECT  = 0x00000001,
    DSFT_PRIVATE = 0x00000002,
    DSFT_PUBLIC  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-librarysaveflags
alias LIBRARYSAVEFLAGS = int;
enum : int
{
    LSF_FAILIFTHERE      = 0x00000000,
    LSF_OVERRIDEEXISTING = 0x00000001,
    LSF_MAKEUNIQUENAME   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-default_folder_menu_restrictions
alias DEFAULT_FOLDER_MENU_RESTRICTIONS = int;
enum : int
{
    DFMR_DEFAULT                        = 0x00000000,
    DFMR_NO_STATIC_VERBS                = 0x00000008,
    DFMR_STATIC_VERBS_ONLY              = 0x00000010,
    DFMR_NO_RESOURCE_VERBS              = 0x00000020,
    DFMR_OPTIN_HANDLERS_ONLY            = 0x00000040,
    DFMR_RESOURCE_AND_FOLDER_VERBS_ONLY = 0x00000080,
    DFMR_USE_SPECIFIED_HANDLERS         = 0x00000100,
    DFMR_USE_SPECIFIED_VERBS            = 0x00000200,
    DFMR_NO_ASYNC_VERBS                 = 0x00000400,
    DFMR_NO_NATIVECPU_VERBS             = 0x00000800,
    DFMR_NO_NONWOW_VERBS                = 0x00001000,
}

alias ACTIVATEOPTIONS = int;
enum : int
{
    AO_NONE           = 0x00000000,
    AO_DESIGNMODE     = 0x00000001,
    AO_NOERRORUI      = 0x00000002,
    AO_NOSPLASHSCREEN = 0x00000004,
    AO_PRELAUNCH      = 0x02000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-librarymanagedialogoptions
alias LIBRARYMANAGEDIALOGOPTIONS = int;
enum : int
{
    LMD_DEFAULT                          = 0x00000000,
    LMD_ALLOWUNINDEXABLENETWORKLOCATIONS = 0x00000001,
}

alias AHTYPE = int;
enum : int
{
    AHTYPE_UNDEFINED         = 0x00000000,
    AHTYPE_USER_APPLICATION  = 0x00000008,
    AHTYPE_ANY_APPLICATION   = 0x00000010,
    AHTYPE_MACHINEDEFAULT    = 0x00000020,
    AHTYPE_PROGID            = 0x00000040,
    AHTYPE_APPLICATION       = 0x00000080,
    AHTYPE_CLASS_APPLICATION = 0x00000100,
    AHTYPE_ANY_PROGID        = 0x00000200,
}

alias ASSOC_FILTER = int;
enum : int
{
    ASSOC_FILTER_NONE        = 0x00000000,
    ASSOC_FILTER_RECOMMENDED = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-monitor_app_visibility
alias MONITOR_APP_VISIBILITY = int;
enum : int
{
    MAV_UNKNOWN        = 0x00000000,
    MAV_NO_APP_VISIBLE = 0x00000001,
    MAV_APP_VISIBLE    = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-package_execution_state
alias PACKAGE_EXECUTION_STATE = int;
enum : int
{
    PES_UNKNOWN    = 0x00000000,
    PES_RUNNING    = 0x00000001,
    PES_SUSPENDING = 0x00000002,
    PES_SUSPENDED  = 0x00000003,
    PES_TERMINATED = 0x00000004,
}

alias AHE_TYPE = int;
enum : int
{
    AHE_DESKTOP   = 0x00000000,
    AHE_IMMERSIVE = 0x00000001,
}

alias EC_HOST_UI_MODE = int;
enum : int
{
    ECHUIM_DESKTOP         = 0x00000000,
    ECHUIM_IMMERSIVE       = 0x00000001,
    ECHUIM_SYSTEM_LAUNCHER = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-application_view_state
alias APPLICATION_VIEW_STATE = int;
enum : int
{
    AVS_FULLSCREEN_LANDSCAPE = 0x00000000,
    AVS_FILLED               = 0x00000001,
    AVS_SNAPPED              = 0x00000002,
    AVS_FULLSCREEN_PORTRAIT  = 0x00000003,
}

alias EDGE_GESTURE_KIND = int;
enum : int
{
    EGK_TOUCH    = 0x00000000,
    EGK_KEYBOARD = 0x00000001,
    EGK_MOUSE    = 0x00000002,
}

alias NATIVE_DISPLAY_ORIENTATION = int;
enum : int
{
    NDO_LANDSCAPE = 0x00000000,
    NDO_PORTRAIT  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-application_view_orientation
alias APPLICATION_VIEW_ORIENTATION = int;
enum : int
{
    AVO_LANDSCAPE = 0x00000000,
    AVO_PORTRAIT  = 0x00000001,
}

alias ADJACENT_DISPLAY_EDGES = int;
enum : int
{
    ADE_NONE  = 0x00000000,
    ADE_LEFT  = 0x00000001,
    ADE_RIGHT = 0x00000002,
}

alias APPLICATION_VIEW_MIN_WIDTH = int;
enum : int
{
    AVMW_DEFAULT = 0x00000000,
    AVMW_320     = 0x00000001,
    AVMW_500     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-application_view_size_preference
alias APPLICATION_VIEW_SIZE_PREFERENCE = int;
enum : int
{
    AVSP_DEFAULT     = 0x00000000,
    AVSP_USE_LESS    = 0x00000001,
    AVSP_USE_HALF    = 0x00000002,
    AVSP_USE_MORE    = 0x00000003,
    AVSP_USE_MINIMUM = 0x00000004,
    AVSP_USE_NONE    = 0x00000005,
    AVSP_CUSTOM      = 0x00000006,
}

alias FLYOUT_PLACEMENT = int;
enum : int
{
    FP_DEFAULT = 0x00000000,
    FP_ABOVE   = 0x00000001,
    FP_BELOW   = 0x00000002,
    FP_LEFT    = 0x00000003,
    FP_RIGHT   = 0x00000004,
}

alias BANNER_NOTIFICATION_EVENT = int;
enum : int
{
    BNE_Rendered       = 0x00000000,
    BNE_Hovered        = 0x00000001,
    BNE_Closed         = 0x00000002,
    BNE_Dismissed      = 0x00000003,
    BNE_Button1Clicked = 0x00000004,
    BNE_Button2Clicked = 0x00000005,
}

alias SORT_ORDER_TYPE = int;
enum : int
{
    SOT_DEFAULT           = 0x00000000,
    SOT_IGNORE_FOLDERNESS = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/ne-shobjidl-folderviewoptions
alias FOLDERVIEWOPTIONS = int;
enum : int
{
    FVO_DEFAULT           = 0x00000000,
    FVO_VISTALAYOUT       = 0x00000001,
    FVO_CUSTOMPOSITION    = 0x00000002,
    FVO_CUSTOMORDERING    = 0x00000004,
    FVO_SUPPORTHYPERLINKS = 0x00000008,
    FVO_NOANIMATIONS      = 0x00000010,
    FVO_NOSCROLLTIPS      = 0x00000020,
}

alias _SV3CVW3_FLAGS = int;
enum : int
{
    SV3CVW3_DEFAULT          = 0x00000000,
    SV3CVW3_NONINTERACTIVE   = 0x00000001,
    SV3CVW3_FORCEVIEWMODE    = 0x00000002,
    SV3CVW3_FORCEFOLDERFLAGS = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/ne-shobjidl-vpwatermarkflags
alias VPWATERMARKFLAGS = int;
enum : int
{
    VPWF_DEFAULT    = 0x00000000,
    VPWF_ALPHABLEND = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/ne-shobjidl-vpcolorflags
alias VPCOLORFLAGS = int;
enum : int
{
    VPCF_TEXT           = 0x00000001,
    VPCF_BACKGROUND     = 0x00000002,
    VPCF_SORTCOLUMN     = 0x00000003,
    VPCF_SUBTEXT        = 0x00000004,
    VPCF_TEXTBACKGROUND = 0x00000005,
}

alias DSH_FLAGS = int;
enum : int
{
    DSH_ALLOWDROPDESCRIPTIONTEXT = 0x00000001,
}

alias CDBURNINGEXTENSIONRET = int;
enum : int
{
    CDBE_RET_DEFAULT          = 0x00000000,
    CDBE_RET_DONTRUNOTHEREXTS = 0x00000001,
    CDBE_RET_STOPWIZARD       = 0x00000002,
}

alias _CDBE_ACTIONS = int;
enum : int
{
    CDBE_TYPE_MUSIC = 0x00000001,
    CDBE_TYPE_DATA  = 0x00000002,
    CDBE_TYPE_ALL   = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/ne-shobjidl-nstcstyle2
alias NSTCSTYLE2 = int;
enum : int
{
    NSTCS2_DEFAULT                  = 0x00000000,
    NSTCS2_INTERRUPTNOTIFICATIONS   = 0x00000001,
    NSTCS2_SHOWNULLSPACEMENU        = 0x00000002,
    NSTCS2_DISPLAYPADDING           = 0x00000004,
    NSTCS2_DISPLAYPINNEDONLY        = 0x00000008,
    NTSCS2_NOSINGLETONAUTOEXPAND    = 0x00000010,
    NTSCS2_NEVERINSERTNONENUMERATED = 0x00000020,
}

alias _NSTCEHITTEST = int;
enum : int
{
    NSTCEHT_NOWHERE         = 0x00000001,
    NSTCEHT_ONITEMICON      = 0x00000002,
    NSTCEHT_ONITEMLABEL     = 0x00000004,
    NSTCEHT_ONITEMINDENT    = 0x00000008,
    NSTCEHT_ONITEMBUTTON    = 0x00000010,
    NSTCEHT_ONITEMRIGHT     = 0x00000020,
    NSTCEHT_ONITEMSTATEICON = 0x00000040,
    NSTCEHT_ONITEM          = 0x00000046,
    NSTCEHT_ONITEMTABBUTTON = 0x00001000,
}

alias _NSTCECLICKTYPE = int;
enum : int
{
    NSTCECT_LBUTTON  = 0x00000001,
    NSTCECT_MBUTTON  = 0x00000002,
    NSTCECT_RBUTTON  = 0x00000003,
    NSTCECT_BUTTON   = 0x00000003,
    NSTCECT_DBLCLICK = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/ne-shobjidl-undock_reason
alias UNDOCK_REASON = int;
enum : int
{
    UR_RESOLUTION_CHANGE  = 0x00000000,
    UR_MONITOR_DISCONNECT = 0x00000001,
}

enum CommandStateChangeConstants : int
{
    CSC_UPDATECOMMANDS  = 0xffffffff,
    CSC_NAVIGATEFORWARD = 0x00000001,
    CSC_NAVIGATEBACK    = 0x00000002,
}

enum SecureLockIconConstants : int
{
    secureLockIconUnsecure          = 0x00000000,
    secureLockIconMixed             = 0x00000001,
    secureLockIconSecureUnknownBits = 0x00000002,
    secureLockIconSecure40Bit       = 0x00000003,
    secureLockIconSecure56Bit       = 0x00000004,
    secureLockIconSecureFortezza    = 0x00000005,
    secureLockIconSecure128Bit      = 0x00000006,
}

enum NewProcessCauseConstants : int
{
    ProtectedModeRedirect = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/exdisp/ne-exdisp-shellwindowtypeconstants
enum ShellWindowTypeConstants : int
{
    SWC_EXPLORER = 0x00000000,
    SWC_BROWSER  = 0x00000001,
    SWC_3RDPARTY = 0x00000002,
    SWC_CALLBACK = 0x00000004,
    SWC_DESKTOP  = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/exdisp/ne-exdisp-shellwindowfindwindowoptions
enum ShellWindowFindWindowOptions : int
{
    SWFO_NEEDDISPATCH   = 0x00000001,
    SWFO_INCLUDEPENDING = 0x00000002,
    SWFO_COOKIEPASSED   = 0x00000004,
}

enum BrowserNavConstants : int
{
    navOpenInNewWindow       = 0x00000001,
    navNoHistory             = 0x00000002,
    navNoReadFromCache       = 0x00000004,
    navNoWriteToCache        = 0x00000008,
    navAllowAutosearch       = 0x00000010,
    navBrowserBar            = 0x00000020,
    navHyperlink             = 0x00000040,
    navEnforceRestricted     = 0x00000080,
    navNewWindowsManaged     = 0x00000100,
    navUntrustedForDownload  = 0x00000200,
    navTrustedForActiveX     = 0x00000400,
    navOpenInNewTab          = 0x00000800,
    navOpenInBackgroundTab   = 0x00001000,
    navKeepWordWheelText     = 0x00002000,
    navVirtualTab            = 0x00004000,
    navBlockRedirectsXDomain = 0x00008000,
    navOpenNewForegroundTab  = 0x00010000,
    navTravelLogScreenshot   = 0x00020000,
    navDeferUnload           = 0x00040000,
    navSpeculative           = 0x00080000,
    navSuggestNewWindow      = 0x00100000,
    navSuggestNewTab         = 0x00200000,
    navReserved1             = 0x00400000,
    navHomepageNavigate      = 0x00800000,
    navRefresh               = 0x01000000,
    navHostNavigation        = 0x02000000,
    navReserved2             = 0x04000000,
    navReserved3             = 0x08000000,
    navReserved4             = 0x10000000,
    navReserved5             = 0x20000000,
    navReserved6             = 0x40000000,
    navReserved7             = 0x80000000,
}

enum RefreshConstants : int
{
    REFRESH_NORMAL     = 0x00000000,
    REFRESH_IFEXPIRED  = 0x00000001,
    REFRESH_COMPLETELY = 0x00000003,
}

enum OfflineFolderStatus : int
{
    OFS_INACTIVE   = 0xffffffff,
    OFS_ONLINE     = 0x00000000,
    OFS_OFFLINE    = 0x00000001,
    OFS_SERVERBACK = 0x00000002,
    OFS_DIRTYCACHE = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/ne-shldisp-shellfolderviewoptions
enum ShellFolderViewOptions : int
{
    SFVVO_SHOWALLOBJECTS       = 0x00000001,
    SFVVO_SHOWEXTENSIONS       = 0x00000002,
    SFVVO_SHOWCOMPCOLOR        = 0x00000008,
    SFVVO_SHOWSYSFILES         = 0x00000020,
    SFVVO_WIN95CLASSIC         = 0x00000040,
    SFVVO_DOUBLECLICKINWEBVIEW = 0x00000080,
    SFVVO_DESKTOPHTML          = 0x00000200,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/ne-shldisp-shellspecialfolderconstants
enum ShellSpecialFolderConstants : int
{
    ssfDESKTOP          = 0x00000000,
    ssfPROGRAMS         = 0x00000002,
    ssfCONTROLS         = 0x00000003,
    ssfPRINTERS         = 0x00000004,
    ssfPERSONAL         = 0x00000005,
    ssfFAVORITES        = 0x00000006,
    ssfSTARTUP          = 0x00000007,
    ssfRECENT           = 0x00000008,
    ssfSENDTO           = 0x00000009,
    ssfBITBUCKET        = 0x0000000a,
    ssfSTARTMENU        = 0x0000000b,
    ssfDESKTOPDIRECTORY = 0x00000010,
    ssfDRIVES           = 0x00000011,
    ssfNETWORK          = 0x00000012,
    ssfNETHOOD          = 0x00000013,
    ssfFONTS            = 0x00000014,
    ssfTEMPLATES        = 0x00000015,
    ssfCOMMONSTARTMENU  = 0x00000016,
    ssfCOMMONPROGRAMS   = 0x00000017,
    ssfCOMMONSTARTUP    = 0x00000018,
    ssfCOMMONDESKTOPDIR = 0x00000019,
    ssfAPPDATA          = 0x0000001a,
    ssfPRINTHOOD        = 0x0000001b,
    ssfLOCALAPPDATA     = 0x0000001c,
    ssfALTSTARTUP       = 0x0000001d,
    ssfCOMMONALTSTARTUP = 0x0000001e,
    ssfCOMMONFAVORITES  = 0x0000001f,
    ssfINTERNETCACHE    = 0x00000020,
    ssfCOOKIES          = 0x00000021,
    ssfHISTORY          = 0x00000022,
    ssfCOMMONAPPDATA    = 0x00000023,
    ssfWINDOWS          = 0x00000024,
    ssfSYSTEM           = 0x00000025,
    ssfPROGRAMFILES     = 0x00000026,
    ssfMYPICTURES       = 0x00000027,
    ssfPROFILE          = 0x00000028,
    ssfSYSTEMx86        = 0x00000029,
    ssfPROGRAMFILESx86  = 0x00000030,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/ne-shldisp-autocompleteoptions
alias AUTOCOMPLETEOPTIONS = int;
enum : int
{
    ACO_NONE               = 0x00000000,
    ACO_AUTOSUGGEST        = 0x00000001,
    ACO_AUTOAPPEND         = 0x00000002,
    ACO_SEARCH             = 0x00000004,
    ACO_FILTERPREFIXES     = 0x00000008,
    ACO_USETAB             = 0x00000010,
    ACO_UPDOWNKEYDROPSLIST = 0x00000020,
    ACO_RTLREADING         = 0x00000040,
    ACO_WORD_FILTER        = 0x00000080,
    ACO_NOPREFIXFILTERING  = 0x00000100,
}

alias ACENUMOPTION = int;
enum : int
{
    ACEO_NONE            = 0x00000000,
    ACEO_MOSTRECENTFIRST = 0x00000001,
    ACEO_FIRSTUNUSED     = 0x00010000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ne-shlobj_core-shell_link_data_flags
alias SHELL_LINK_DATA_FLAGS = int;
enum : int
{
    SLDF_DEFAULT                               = 0x00000000,
    SLDF_HAS_ID_LIST                           = 0x00000001,
    SLDF_HAS_LINK_INFO                         = 0x00000002,
    SLDF_HAS_NAME                              = 0x00000004,
    SLDF_HAS_RELPATH                           = 0x00000008,
    SLDF_HAS_WORKINGDIR                        = 0x00000010,
    SLDF_HAS_ARGS                              = 0x00000020,
    SLDF_HAS_ICONLOCATION                      = 0x00000040,
    SLDF_UNICODE                               = 0x00000080,
    SLDF_FORCE_NO_LINKINFO                     = 0x00000100,
    SLDF_HAS_EXP_SZ                            = 0x00000200,
    SLDF_RUN_IN_SEPARATE                       = 0x00000400,
    SLDF_HAS_DARWINID                          = 0x00001000,
    SLDF_RUNAS_USER                            = 0x00002000,
    SLDF_HAS_EXP_ICON_SZ                       = 0x00004000,
    SLDF_NO_PIDL_ALIAS                         = 0x00008000,
    SLDF_FORCE_UNCNAME                         = 0x00010000,
    SLDF_RUN_WITH_SHIMLAYER                    = 0x00020000,
    SLDF_FORCE_NO_LINKTRACK                    = 0x00040000,
    SLDF_ENABLE_TARGET_METADATA                = 0x00080000,
    SLDF_DISABLE_LINK_PATH_TRACKING            = 0x00100000,
    SLDF_DISABLE_KNOWNFOLDER_RELATIVE_TRACKING = 0x00200000,
    SLDF_NO_KF_ALIAS                           = 0x00400000,
    SLDF_ALLOW_LINK_TO_LINK                    = 0x00800000,
    SLDF_UNALIAS_ON_SAVE                       = 0x01000000,
    SLDF_PREFER_ENVIRONMENT_PATH               = 0x02000000,
    SLDF_KEEP_LOCAL_IDLIST_FOR_UNC_TARGET      = 0x04000000,
    SLDF_PERSIST_VOLUME_ID_RELATIVE            = 0x08000000,
    SLDF_VALID                                 = 0x0ffff7ff,
    SLDF_RESERVED                              = 0x80000000,
}

alias SHGFP_TYPE = int;
enum : int
{
    SHGFP_TYPE_CURRENT = 0x00000000,
    SHGFP_TYPE_DEFAULT = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ne-shlobj_core-known_folder_flag
alias KNOWN_FOLDER_FLAG = int;
enum : int
{
    KF_FLAG_DEFAULT                          = 0x00000000,
    KF_FLAG_FORCE_APP_DATA_REDIRECTION       = 0x00080000,
    KF_FLAG_RETURN_FILTER_REDIRECTION_TARGET = 0x00040000,
    KF_FLAG_FORCE_PACKAGE_REDIRECTION        = 0x00020000,
    KF_FLAG_NO_PACKAGE_REDIRECTION           = 0x00010000,
    KF_FLAG_FORCE_APPCONTAINER_REDIRECTION   = 0x00020000,
    KF_FLAG_NO_APPCONTAINER_REDIRECTION      = 0x00010000,
    KF_FLAG_CREATE                           = 0x00008000,
    KF_FLAG_DONT_VERIFY                      = 0x00004000,
    KF_FLAG_DONT_UNEXPAND                    = 0x00002000,
    KF_FLAG_NO_ALIAS                         = 0x00001000,
    KF_FLAG_INIT                             = 0x00000800,
    KF_FLAG_DEFAULT_PATH                     = 0x00000400,
    KF_FLAG_NOT_PARENT_RELATIVE              = 0x00000200,
    KF_FLAG_SIMPLE_IDLIST                    = 0x00000100,
    KF_FLAG_ALIAS_ONLY                       = 0x80000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ne-shlobj_core-autocompletelistoptions
alias AUTOCOMPLETELISTOPTIONS = int;
enum : int
{
    ACLO_NONE             = 0x00000000,
    ACLO_CURRENTDIR       = 0x00000001,
    ACLO_MYCOMPUTER       = 0x00000002,
    ACLO_DESKTOP          = 0x00000004,
    ACLO_FAVORITES        = 0x00000008,
    ACLO_FILESYSONLY      = 0x00000010,
    ACLO_FILESYSDIRS      = 0x00000020,
    ACLO_VIRTUALNAMESPACE = 0x00000040,
}

alias FD_FLAGS = int;
enum : int
{
    FD_CLSID      = 0x00000001,
    FD_SIZEPOINT  = 0x00000002,
    FD_ATTRIBUTES = 0x00000004,
    FD_CREATETIME = 0x00000008,
    FD_ACCESSTIME = 0x00000010,
    FD_WRITESTIME = 0x00000020,
    FD_FILESIZE   = 0x00000040,
    FD_PROGRESSUI = 0x00004000,
    FD_LINKUI     = 0x00008000,
    FD_UNICODE    = 0x80000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ne-shlobj_core-dropimagetype
alias DROPIMAGETYPE = int;
enum : int
{
    DROPIMAGE_INVALID = 0xffffffff,
    DROPIMAGE_NONE    = 0x00000000,
    DROPIMAGE_COPY    = 0x00000001,
    DROPIMAGE_MOVE    = 0x00000002,
    DROPIMAGE_LINK    = 0x00000004,
    DROPIMAGE_LABEL   = 0x00000006,
    DROPIMAGE_WARNING = 0x00000007,
    DROPIMAGE_NOIMAGE = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ne-shlobj_core-shard
alias SHARD = int;
enum : int
{
    SHARD_PIDL            = 0x00000001,
    SHARD_PATHA           = 0x00000002,
    SHARD_PATHW           = 0x00000003,
    SHARD_APPIDINFO       = 0x00000004,
    SHARD_APPIDINFOIDLIST = 0x00000005,
    SHARD_LINK            = 0x00000006,
    SHARD_APPIDINFOLINK   = 0x00000007,
    SHARD_SHELLITEM       = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ne-shlobj_core-scnrt_status
alias SCNRT_STATUS = int;
enum : int
{
    SCNRT_ENABLE  = 0x00000000,
    SCNRT_DISABLE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ne-shlobj_core-restrictions
alias RESTRICTIONS = int;
enum : int
{
    REST_NONE                       = 0x00000000,
    REST_NORUN                      = 0x00000001,
    REST_NOCLOSE                    = 0x00000002,
    REST_NOSAVESET                  = 0x00000004,
    REST_NOFILEMENU                 = 0x00000008,
    REST_NOSETFOLDERS               = 0x00000010,
    REST_NOSETTASKBAR               = 0x00000020,
    REST_NODESKTOP                  = 0x00000040,
    REST_NOFIND                     = 0x00000080,
    REST_NODRIVES                   = 0x00000100,
    REST_NODRIVEAUTORUN             = 0x00000200,
    REST_NODRIVETYPEAUTORUN         = 0x00000400,
    REST_NONETHOOD                  = 0x00000800,
    REST_STARTBANNER                = 0x00001000,
    REST_RESTRICTRUN                = 0x00002000,
    REST_NOPRINTERTABS              = 0x00004000,
    REST_NOPRINTERDELETE            = 0x00008000,
    REST_NOPRINTERADD               = 0x00010000,
    REST_NOSTARTMENUSUBFOLDERS      = 0x00020000,
    REST_MYDOCSONNET                = 0x00040000,
    REST_NOEXITTODOS                = 0x00080000,
    REST_ENFORCESHELLEXTSECURITY    = 0x00100000,
    REST_LINKRESOLVEIGNORELINKINFO  = 0x00200000,
    REST_NOCOMMONGROUPS             = 0x00400000,
    REST_SEPARATEDESKTOPPROCESS     = 0x00800000,
    REST_NOWEB                      = 0x01000000,
    REST_NOTRAYCONTEXTMENU          = 0x02000000,
    REST_NOVIEWCONTEXTMENU          = 0x04000000,
    REST_NONETCONNECTDISCONNECT     = 0x08000000,
    REST_STARTMENULOGOFF            = 0x10000000,
    REST_NOSETTINGSASSIST           = 0x20000000,
    REST_NOINTERNETICON             = 0x40000001,
    REST_NORECENTDOCSHISTORY        = 0x40000002,
    REST_NORECENTDOCSMENU           = 0x40000003,
    REST_NOACTIVEDESKTOP            = 0x40000004,
    REST_NOACTIVEDESKTOPCHANGES     = 0x40000005,
    REST_NOFAVORITESMENU            = 0x40000006,
    REST_CLEARRECENTDOCSONEXIT      = 0x40000007,
    REST_CLASSICSHELL               = 0x40000008,
    REST_NOCUSTOMIZEWEBVIEW         = 0x40000009,
    REST_NOHTMLWALLPAPER            = 0x40000010,
    REST_NOCHANGINGWALLPAPER        = 0x40000011,
    REST_NODESKCOMP                 = 0x40000012,
    REST_NOADDDESKCOMP              = 0x40000013,
    REST_NODELDESKCOMP              = 0x40000014,
    REST_NOCLOSEDESKCOMP            = 0x40000015,
    REST_NOCLOSE_DRAGDROPBAND       = 0x40000016,
    REST_NOMOVINGBAND               = 0x40000017,
    REST_NOEDITDESKCOMP             = 0x40000018,
    REST_NORESOLVESEARCH            = 0x40000019,
    REST_NORESOLVETRACK             = 0x4000001a,
    REST_FORCECOPYACLWITHFILE       = 0x4000001b,
    REST_NOFORGETSOFTWAREUPDATE     = 0x4000001d,
    REST_NOSETACTIVEDESKTOP         = 0x4000001e,
    REST_NOUPDATEWINDOWS            = 0x4000001f,
    REST_NOCHANGESTARMENU           = 0x40000020,
    REST_NOFOLDEROPTIONS            = 0x40000021,
    REST_HASFINDCOMPUTERS           = 0x40000022,
    REST_INTELLIMENUS               = 0x40000023,
    REST_RUNDLGMEMCHECKBOX          = 0x40000024,
    REST_ARP_ShowPostSetup          = 0x40000025,
    REST_NOCSC                      = 0x40000026,
    REST_NOCONTROLPANEL             = 0x40000027,
    REST_ENUMWORKGROUP              = 0x40000028,
    REST_ARP_NOARP                  = 0x40000029,
    REST_ARP_NOREMOVEPAGE           = 0x4000002a,
    REST_ARP_NOADDPAGE              = 0x4000002b,
    REST_ARP_NOWINSETUPPAGE         = 0x4000002c,
    REST_GREYMSIADS                 = 0x4000002d,
    REST_NOCHANGEMAPPEDDRIVELABEL   = 0x4000002e,
    REST_NOCHANGEMAPPEDDRIVECOMMENT = 0x4000002f,
    REST_MaxRecentDocs              = 0x40000030,
    REST_NONETWORKCONNECTIONS       = 0x40000031,
    REST_FORCESTARTMENULOGOFF       = 0x40000032,
    REST_NOWEBVIEW                  = 0x40000033,
    REST_NOCUSTOMIZETHISFOLDER      = 0x40000034,
    REST_NOENCRYPTION               = 0x40000035,
    REST_DONTSHOWSUPERHIDDEN        = 0x40000037,
    REST_NOSHELLSEARCHBUTTON        = 0x40000038,
    REST_NOHARDWARETAB              = 0x40000039,
    REST_NORUNASINSTALLPROMPT       = 0x4000003a,
    REST_PROMPTRUNASINSTALLNETPATH  = 0x4000003b,
    REST_NOMANAGEMYCOMPUTERVERB     = 0x4000003c,
    REST_DISALLOWRUN                = 0x4000003e,
    REST_NOWELCOMESCREEN            = 0x4000003f,
    REST_RESTRICTCPL                = 0x40000040,
    REST_DISALLOWCPL                = 0x40000041,
    REST_NOSMBALLOONTIP             = 0x40000042,
    REST_NOSMHELP                   = 0x40000043,
    REST_NOWINKEYS                  = 0x40000044,
    REST_NOENCRYPTONMOVE            = 0x40000045,
    REST_NOLOCALMACHINERUN          = 0x40000046,
    REST_NOCURRENTUSERRUN           = 0x40000047,
    REST_NOLOCALMACHINERUNONCE      = 0x40000048,
    REST_NOCURRENTUSERRUNONCE       = 0x40000049,
    REST_FORCEACTIVEDESKTOPON       = 0x4000004a,
    REST_NOVIEWONDRIVE              = 0x4000004c,
    REST_NONETCRAWL                 = 0x4000004d,
    REST_NOSHAREDDOCUMENTS          = 0x4000004e,
    REST_NOSMMYDOCS                 = 0x4000004f,
    REST_NOSMMYPICS                 = 0x40000050,
    REST_ALLOWBITBUCKDRIVES         = 0x40000051,
    REST_NONLEGACYSHELLMODE         = 0x40000052,
    REST_NOCONTROLPANELBARRICADE    = 0x40000053,
    REST_NOSTARTPAGE                = 0x40000054,
    REST_NOAUTOTRAYNOTIFY           = 0x40000055,
    REST_NOTASKGROUPING             = 0x40000056,
    REST_NOCDBURNING                = 0x40000057,
    REST_MYCOMPNOPROP               = 0x40000058,
    REST_MYDOCSNOPROP               = 0x40000059,
    REST_NOSTARTPANEL               = 0x4000005a,
    REST_NODISPLAYAPPEARANCEPAGE    = 0x4000005b,
    REST_NOTHEMESTAB                = 0x4000005c,
    REST_NOVISUALSTYLECHOICE        = 0x4000005d,
    REST_NOSIZECHOICE               = 0x4000005e,
    REST_NOCOLORCHOICE              = 0x4000005f,
    REST_SETVISUALSTYLE             = 0x40000060,
    REST_STARTRUNNOHOMEPATH         = 0x40000061,
    REST_NOUSERNAMEINSTARTPANEL     = 0x40000062,
    REST_NOMYCOMPUTERICON           = 0x40000063,
    REST_NOSMNETWORKPLACES          = 0x40000064,
    REST_NOSMPINNEDLIST             = 0x40000065,
    REST_NOSMMYMUSIC                = 0x40000066,
    REST_NOSMEJECTPC                = 0x40000067,
    REST_NOSMMOREPROGRAMS           = 0x40000068,
    REST_NOSMMFUPROGRAMS            = 0x40000069,
    REST_NOTRAYITEMSDISPLAY         = 0x4000006a,
    REST_NOTOOLBARSONTASKBAR        = 0x4000006b,
    REST_NOSMCONFIGUREPROGRAMS      = 0x4000006f,
    REST_HIDECLOCK                  = 0x40000070,
    REST_NOLOWDISKSPACECHECKS       = 0x40000071,
    REST_NOENTIRENETWORK            = 0x40000072,
    REST_NODESKTOPCLEANUP           = 0x40000073,
    REST_BITBUCKNUKEONDELETE        = 0x40000074,
    REST_BITBUCKCONFIRMDELETE       = 0x40000075,
    REST_BITBUCKNOPROP              = 0x40000076,
    REST_NODISPBACKGROUND           = 0x40000077,
    REST_NODISPSCREENSAVEPG         = 0x40000078,
    REST_NODISPSETTINGSPG           = 0x40000079,
    REST_NODISPSCREENSAVEPREVIEW    = 0x4000007a,
    REST_NODISPLAYCPL               = 0x4000007b,
    REST_HIDERUNASVERB              = 0x4000007c,
    REST_NOTHUMBNAILCACHE           = 0x4000007d,
    REST_NOSTRCMPLOGICAL            = 0x4000007e,
    REST_NOPUBLISHWIZARD            = 0x4000007f,
    REST_NOONLINEPRINTSWIZARD       = 0x40000080,
    REST_NOWEBSERVICES              = 0x40000081,
    REST_ALLOWUNHASHEDWEBVIEW       = 0x40000082,
    REST_ALLOWLEGACYWEBVIEW         = 0x40000083,
    REST_REVERTWEBVIEWSECURITY      = 0x40000084,
    REST_INHERITCONSOLEHANDLES      = 0x40000086,
    REST_NOREMOTERECURSIVEEVENTS    = 0x40000089,
    REST_NOREMOTECHANGENOTIFY       = 0x40000091,
    REST_NOENUMENTIRENETWORK        = 0x40000093,
    REST_NOINTERNETOPENWITH         = 0x40000095,
    REST_DONTRETRYBADNETNAME        = 0x4000009b,
    REST_ALLOWFILECLSIDJUNCTIONS    = 0x4000009c,
    REST_NOUPNPINSTALL              = 0x4000009d,
    REST_ARP_DONTGROUPPATCHES       = 0x400000ac,
    REST_ARP_NOCHOOSEPROGRAMSPAGE   = 0x400000ad,
    REST_NODISCONNECT               = 0x41000001,
    REST_NOSECURITY                 = 0x41000002,
    REST_NOFILEASSOCIATE            = 0x41000003,
    REST_ALLOWCOMMENTTOGGLE         = 0x41000004,
}

alias OPEN_AS_INFO_FLAGS = int;
enum : int
{
    OAIF_ALLOW_REGISTRATION = 0x00000001,
    OAIF_REGISTER_EXT       = 0x00000002,
    OAIF_EXEC               = 0x00000004,
    OAIF_FORCE_REGISTRATION = 0x00000008,
    OAIF_HIDE_REGISTRATION  = 0x00000020,
    OAIF_URL_PROTOCOL       = 0x00000040,
    OAIF_FILE_IS_URI        = 0x00000080,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ne-shlobj_core-ieshortcutflags
alias IESHORTCUTFLAGS = int;
enum : int
{
    IESHORTCUT_NEWBROWSER    = 0x00000001,
    IESHORTCUT_OPENNEWTAB    = 0x00000002,
    IESHORTCUT_FORCENAVIGATE = 0x00000004,
    IESHORTCUT_BACKGROUNDTAB = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellscalingapi/ne-shellscalingapi-display_device_type
alias DISPLAY_DEVICE_TYPE = int;
enum : int
{
    DEVICE_PRIMARY   = 0x00000000,
    DEVICE_IMMERSIVE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellscalingapi/ne-shellscalingapi-scale_change_flags
alias SCALE_CHANGE_FLAGS = int;
enum : int
{
    SCF_VALUE_NONE = 0x00000000,
    SCF_SCALE      = 0x00000001,
    SCF_PHYSICAL   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellscalingapi/ne-shellscalingapi-shell_ui_component
alias SHELL_UI_COMPONENT = int;
enum : int
{
    SHELL_UI_COMPONENT_TASKBARS         = 0x00000000,
    SHELL_UI_COMPONENT_NOTIFICATIONAREA = 0x00000001,
    SHELL_UI_COMPONENT_DESKBAND         = 0x00000002,
}

alias ASSOCCLASS = int;
enum : int
{
    ASSOCCLASS_SHELL_KEY        = 0x00000000,
    ASSOCCLASS_PROGID_KEY       = 0x00000001,
    ASSOCCLASS_PROGID_STR       = 0x00000002,
    ASSOCCLASS_CLSID_KEY        = 0x00000003,
    ASSOCCLASS_CLSID_STR        = 0x00000004,
    ASSOCCLASS_APP_KEY          = 0x00000005,
    ASSOCCLASS_APP_STR          = 0x00000006,
    ASSOCCLASS_SYSTEM_STR       = 0x00000007,
    ASSOCCLASS_FOLDER           = 0x00000008,
    ASSOCCLASS_STAR             = 0x00000009,
    ASSOCCLASS_FIXED_PROGID_STR = 0x0000000a,
    ASSOCCLASS_PROTOCOL_STR     = 0x0000000b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ne-shellapi-query_user_notification_state
alias QUERY_USER_NOTIFICATION_STATE = int;
enum : int
{
    QUNS_NOT_PRESENT             = 0x00000001,
    QUNS_BUSY                    = 0x00000002,
    QUNS_RUNNING_D3D_FULL_SCREEN = 0x00000003,
    QUNS_PRESENTATION_MODE       = 0x00000004,
    QUNS_ACCEPTS_NOTIFICATIONS   = 0x00000005,
    QUNS_QUIET_TIME              = 0x00000006,
    QUNS_APP                     = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ne-shellapi-shstockiconid
alias SHSTOCKICONID = int;
enum : int
{
    SIID_DOCNOASSOC        = 0x00000000,
    SIID_DOCASSOC          = 0x00000001,
    SIID_APPLICATION       = 0x00000002,
    SIID_FOLDER            = 0x00000003,
    SIID_FOLDEROPEN        = 0x00000004,
    SIID_DRIVE525          = 0x00000005,
    SIID_DRIVE35           = 0x00000006,
    SIID_DRIVEREMOVE       = 0x00000007,
    SIID_DRIVEFIXED        = 0x00000008,
    SIID_DRIVENET          = 0x00000009,
    SIID_DRIVENETDISABLED  = 0x0000000a,
    SIID_DRIVECD           = 0x0000000b,
    SIID_DRIVERAM          = 0x0000000c,
    SIID_WORLD             = 0x0000000d,
    SIID_SERVER            = 0x0000000f,
    SIID_PRINTER           = 0x00000010,
    SIID_MYNETWORK         = 0x00000011,
    SIID_FIND              = 0x00000016,
    SIID_HELP              = 0x00000017,
    SIID_SHARE             = 0x0000001c,
    SIID_LINK              = 0x0000001d,
    SIID_SLOWFILE          = 0x0000001e,
    SIID_RECYCLER          = 0x0000001f,
    SIID_RECYCLERFULL      = 0x00000020,
    SIID_MEDIACDAUDIO      = 0x00000028,
    SIID_LOCK              = 0x0000002f,
    SIID_AUTOLIST          = 0x00000031,
    SIID_PRINTERNET        = 0x00000032,
    SIID_SERVERSHARE       = 0x00000033,
    SIID_PRINTERFAX        = 0x00000034,
    SIID_PRINTERFAXNET     = 0x00000035,
    SIID_PRINTERFILE       = 0x00000036,
    SIID_STACK             = 0x00000037,
    SIID_MEDIASVCD         = 0x00000038,
    SIID_STUFFEDFOLDER     = 0x00000039,
    SIID_DRIVEUNKNOWN      = 0x0000003a,
    SIID_DRIVEDVD          = 0x0000003b,
    SIID_MEDIADVD          = 0x0000003c,
    SIID_MEDIADVDRAM       = 0x0000003d,
    SIID_MEDIADVDRW        = 0x0000003e,
    SIID_MEDIADVDR         = 0x0000003f,
    SIID_MEDIADVDROM       = 0x00000040,
    SIID_MEDIACDAUDIOPLUS  = 0x00000041,
    SIID_MEDIACDRW         = 0x00000042,
    SIID_MEDIACDR          = 0x00000043,
    SIID_MEDIACDBURN       = 0x00000044,
    SIID_MEDIABLANKCD      = 0x00000045,
    SIID_MEDIACDROM        = 0x00000046,
    SIID_AUDIOFILES        = 0x00000047,
    SIID_IMAGEFILES        = 0x00000048,
    SIID_VIDEOFILES        = 0x00000049,
    SIID_MIXEDFILES        = 0x0000004a,
    SIID_FOLDERBACK        = 0x0000004b,
    SIID_FOLDERFRONT       = 0x0000004c,
    SIID_SHIELD            = 0x0000004d,
    SIID_WARNING           = 0x0000004e,
    SIID_INFO              = 0x0000004f,
    SIID_ERROR             = 0x00000050,
    SIID_KEY               = 0x00000051,
    SIID_SOFTWARE          = 0x00000052,
    SIID_RENAME            = 0x00000053,
    SIID_DELETE            = 0x00000054,
    SIID_MEDIAAUDIODVD     = 0x00000055,
    SIID_MEDIAMOVIEDVD     = 0x00000056,
    SIID_MEDIAENHANCEDCD   = 0x00000057,
    SIID_MEDIAENHANCEDDVD  = 0x00000058,
    SIID_MEDIAHDDVD        = 0x00000059,
    SIID_MEDIABLURAY       = 0x0000005a,
    SIID_MEDIAVCD          = 0x0000005b,
    SIID_MEDIADVDPLUSR     = 0x0000005c,
    SIID_MEDIADVDPLUSRW    = 0x0000005d,
    SIID_DESKTOPPC         = 0x0000005e,
    SIID_MOBILEPC          = 0x0000005f,
    SIID_USERS             = 0x00000060,
    SIID_MEDIASMARTMEDIA   = 0x00000061,
    SIID_MEDIACOMPACTFLASH = 0x00000062,
    SIID_DEVICECELLPHONE   = 0x00000063,
    SIID_DEVICECAMERA      = 0x00000064,
    SIID_DEVICEVIDEOCAMERA = 0x00000065,
    SIID_DEVICEAUDIOPLAYER = 0x00000066,
    SIID_NETWORKCONNECT    = 0x00000067,
    SIID_INTERNET          = 0x00000068,
    SIID_ZIPFILE           = 0x00000069,
    SIID_SETTINGS          = 0x0000006a,
    SIID_DRIVEHDDVD        = 0x00000084,
    SIID_DRIVEBD           = 0x00000085,
    SIID_MEDIAHDDVDROM     = 0x00000086,
    SIID_MEDIAHDDVDR       = 0x00000087,
    SIID_MEDIAHDDVDRAM     = 0x00000088,
    SIID_MEDIABDROM        = 0x00000089,
    SIID_MEDIABDR          = 0x0000008a,
    SIID_MEDIABDRE         = 0x0000008b,
    SIID_CLUSTEREDDRIVE    = 0x0000008c,
    SIID_MAX_ICONS         = 0x000000b5,
}

alias SFBS_FLAGS = int;
enum : int
{
    SFBS_FLAGS_ROUND_TO_NEAREST_DISPLAYED_DIGIT    = 0x00000001,
    SFBS_FLAGS_TRUNCATE_UNDISPLAYED_DECIMAL_DIGITS = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlwapi/ne-shlwapi-url_scheme
alias URL_SCHEME = int;
enum : int
{
    URL_SCHEME_INVALID       = 0xffffffff,
    URL_SCHEME_UNKNOWN       = 0x00000000,
    URL_SCHEME_FTP           = 0x00000001,
    URL_SCHEME_HTTP          = 0x00000002,
    URL_SCHEME_GOPHER        = 0x00000003,
    URL_SCHEME_MAILTO        = 0x00000004,
    URL_SCHEME_NEWS          = 0x00000005,
    URL_SCHEME_NNTP          = 0x00000006,
    URL_SCHEME_TELNET        = 0x00000007,
    URL_SCHEME_WAIS          = 0x00000008,
    URL_SCHEME_FILE          = 0x00000009,
    URL_SCHEME_MK            = 0x0000000a,
    URL_SCHEME_HTTPS         = 0x0000000b,
    URL_SCHEME_SHELL         = 0x0000000c,
    URL_SCHEME_SNEWS         = 0x0000000d,
    URL_SCHEME_LOCAL         = 0x0000000e,
    URL_SCHEME_JAVASCRIPT    = 0x0000000f,
    URL_SCHEME_VBSCRIPT      = 0x00000010,
    URL_SCHEME_ABOUT         = 0x00000011,
    URL_SCHEME_RES           = 0x00000012,
    URL_SCHEME_MSSHELLROOTED = 0x00000013,
    URL_SCHEME_MSSHELLIDLIST = 0x00000014,
    URL_SCHEME_MSHELP        = 0x00000015,
    URL_SCHEME_MSSHELLDEVICE = 0x00000016,
    URL_SCHEME_WILDCARD      = 0x00000017,
    URL_SCHEME_SEARCH_MS     = 0x00000018,
    URL_SCHEME_SEARCH        = 0x00000019,
    URL_SCHEME_KNOWNFOLDER   = 0x0000001a,
    URL_SCHEME_MAXVALUE      = 0x0000001b,
}

alias URL_PART = int;
enum : int
{
    URL_PART_NONE     = 0x00000000,
    URL_PART_SCHEME   = 0x00000001,
    URL_PART_HOSTNAME = 0x00000002,
    URL_PART_USERNAME = 0x00000003,
    URL_PART_PASSWORD = 0x00000004,
    URL_PART_PORT     = 0x00000005,
    URL_PART_QUERY    = 0x00000006,
}

alias URLIS = int;
enum : int
{
    URLIS_URL       = 0x00000000,
    URLIS_OPAQUE    = 0x00000001,
    URLIS_NOHISTORY = 0x00000002,
    URLIS_FILEURL   = 0x00000003,
    URLIS_APPLIABLE = 0x00000004,
    URLIS_DIRECTORY = 0x00000005,
    URLIS_HASQUERY  = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlwapi/ne-shlwapi-shregdel_flags
alias SHREGDEL_FLAGS = int;
enum : int
{
    SHREGDEL_DEFAULT = 0x00000000,
    SHREGDEL_HKCU    = 0x00000001,
    SHREGDEL_HKLM    = 0x00000010,
    SHREGDEL_BOTH    = 0x00000011,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlwapi/ne-shlwapi-shregenum_flags
alias SHREGENUM_FLAGS = int;
enum : int
{
    SHREGENUM_DEFAULT = 0x00000000,
    SHREGENUM_HKCU    = 0x00000001,
    SHREGENUM_HKLM    = 0x00000010,
    SHREGENUM_BOTH    = 0x00000011,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlwapi/ne-shlwapi-assocstr
alias ASSOCSTR = int;
enum : int
{
    ASSOCSTR_COMMAND                 = 0x00000001,
    ASSOCSTR_EXECUTABLE              = 0x00000002,
    ASSOCSTR_FRIENDLYDOCNAME         = 0x00000003,
    ASSOCSTR_FRIENDLYAPPNAME         = 0x00000004,
    ASSOCSTR_NOOPEN                  = 0x00000005,
    ASSOCSTR_SHELLNEWVALUE           = 0x00000006,
    ASSOCSTR_DDECOMMAND              = 0x00000007,
    ASSOCSTR_DDEIFEXEC               = 0x00000008,
    ASSOCSTR_DDEAPPLICATION          = 0x00000009,
    ASSOCSTR_DDETOPIC                = 0x0000000a,
    ASSOCSTR_INFOTIP                 = 0x0000000b,
    ASSOCSTR_QUICKTIP                = 0x0000000c,
    ASSOCSTR_TILEINFO                = 0x0000000d,
    ASSOCSTR_CONTENTTYPE             = 0x0000000e,
    ASSOCSTR_DEFAULTICON             = 0x0000000f,
    ASSOCSTR_SHELLEXTENSION          = 0x00000010,
    ASSOCSTR_DROPTARGET              = 0x00000011,
    ASSOCSTR_DELEGATEEXECUTE         = 0x00000012,
    ASSOCSTR_SUPPORTED_URI_PROTOCOLS = 0x00000013,
    ASSOCSTR_PROGID                  = 0x00000014,
    ASSOCSTR_APPID                   = 0x00000015,
    ASSOCSTR_APPPUBLISHER            = 0x00000016,
    ASSOCSTR_APPICONREFERENCE        = 0x00000017,
    ASSOCSTR_MAX                     = 0x00000018,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlwapi/ne-shlwapi-assockey
alias ASSOCKEY = int;
enum : int
{
    ASSOCKEY_SHELLEXECCLASS = 0x00000001,
    ASSOCKEY_APP            = 0x00000002,
    ASSOCKEY_CLASS          = 0x00000003,
    ASSOCKEY_BASECLASS      = 0x00000004,
    ASSOCKEY_MAX            = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlwapi/ne-shlwapi-assocdata
alias ASSOCDATA = int;
enum : int
{
    ASSOCDATA_MSIDESCRIPTOR     = 0x00000001,
    ASSOCDATA_NOACTIVATEHANDLER = 0x00000002,
    ASSOCDATA_UNUSED1           = 0x00000003,
    ASSOCDATA_HASPERUSERASSOC   = 0x00000004,
    ASSOCDATA_EDITFLAGS         = 0x00000005,
    ASSOCDATA_VALUE             = 0x00000006,
    ASSOCDATA_MAX               = 0x00000007,
}

alias ASSOCENUM = int;
enum : int
{
    ASSOCENUM_NONE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlwapi/ne-shlwapi-filetypeattributeflags
alias FILETYPEATTRIBUTEFLAGS = int;
enum : int
{
    FTA_None                  = 0x00000000,
    FTA_Exclude               = 0x00000001,
    FTA_Show                  = 0x00000002,
    FTA_HasExtension          = 0x00000004,
    FTA_NoEdit                = 0x00000008,
    FTA_NoRemove              = 0x00000010,
    FTA_NoNewVerb             = 0x00000020,
    FTA_NoEditVerb            = 0x00000040,
    FTA_NoRemoveVerb          = 0x00000080,
    FTA_NoEditDesc            = 0x00000100,
    FTA_NoEditIcon            = 0x00000200,
    FTA_NoEditDflt            = 0x00000400,
    FTA_NoEditVerbCmd         = 0x00000800,
    FTA_NoEditVerbExe         = 0x00001000,
    FTA_NoDDE                 = 0x00002000,
    FTA_NoEditMIME            = 0x00008000,
    FTA_OpenIsSafe            = 0x00010000,
    FTA_AlwaysUnsafe          = 0x00020000,
    FTA_NoRecentDocs          = 0x00100000,
    FTA_SafeForElevation      = 0x00200000,
    FTA_AlwaysUseDirectInvoke = 0x00400000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlwapi/ne-shlwapi-shglobalcounter
alias SHGLOBALCOUNTER = int;
enum : int
{
    GLOBALCOUNTER_SEARCHMANAGER                                      = 0x00000000,
    GLOBALCOUNTER_SEARCHOPTIONS                                      = 0x00000001,
    GLOBALCOUNTER_FOLDERSETTINGSCHANGE                               = 0x00000002,
    GLOBALCOUNTER_RATINGS                                            = 0x00000003,
    GLOBALCOUNTER_APPROVEDSITES                                      = 0x00000004,
    GLOBALCOUNTER_RESTRICTIONS                                       = 0x00000005,
    GLOBALCOUNTER_SHELLSETTINGSCHANGED                               = 0x00000006,
    GLOBALCOUNTER_SYSTEMPIDLCHANGE                                   = 0x00000007,
    GLOBALCOUNTER_OVERLAYMANAGER                                     = 0x00000008,
    GLOBALCOUNTER_QUERYASSOCIATIONS                                  = 0x00000009,
    GLOBALCOUNTER_IESESSIONS                                         = 0x0000000a,
    GLOBALCOUNTER_IEONLY_SESSIONS                                    = 0x0000000b,
    GLOBALCOUNTER_APPLICATION_DESTINATIONS                           = 0x0000000c,
    __UNUSED_RECYCLE_WAS_GLOBALCOUNTER_CSCSYNCINPROGRESS             = 0x0000000d,
    GLOBALCOUNTER_BITBUCKETNUMDELETERS                               = 0x0000000e,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_SHARES                           = 0x0000000f,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_A                          = 0x00000010,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_B                          = 0x00000011,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_C                          = 0x00000012,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_D                          = 0x00000013,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_E                          = 0x00000014,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_F                          = 0x00000015,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_G                          = 0x00000016,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_H                          = 0x00000017,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_I                          = 0x00000018,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_J                          = 0x00000019,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_K                          = 0x0000001a,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_L                          = 0x0000001b,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_M                          = 0x0000001c,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_N                          = 0x0000001d,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_O                          = 0x0000001e,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_P                          = 0x0000001f,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_Q                          = 0x00000020,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_R                          = 0x00000021,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_S                          = 0x00000022,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_T                          = 0x00000023,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_U                          = 0x00000024,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_V                          = 0x00000025,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_W                          = 0x00000026,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_X                          = 0x00000027,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_Y                          = 0x00000028,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_Z                          = 0x00000029,
    __UNUSED_RECYCLE_WAS_GLOBALCOUNTER_RECYCLEDIRTYCOUNT_SERVERDRIVE = 0x0000002a,
    __UNUSED_RECYCLE_WAS_GLOBALCOUNTER_RECYCLEGLOBALDIRTYCOUNT       = 0x0000002b,
    GLOBALCOUNTER_RECYCLEBINENUM                                     = 0x0000002c,
    GLOBALCOUNTER_RECYCLEBINCORRUPTED                                = 0x0000002d,
    GLOBALCOUNTER_RATINGS_STATECOUNTER                               = 0x0000002e,
    GLOBALCOUNTER_PRIVATE_PROFILE_CACHE                              = 0x0000002f,
    GLOBALCOUNTER_INTERNETTOOLBAR_LAYOUT                             = 0x00000030,
    GLOBALCOUNTER_FOLDERDEFINITION_CACHE                             = 0x00000031,
    GLOBALCOUNTER_COMMONPLACES_LIST_CACHE                            = 0x00000032,
    GLOBALCOUNTER_PRIVATE_PROFILE_CACHE_MACHINEWIDE                  = 0x00000033,
    GLOBALCOUNTER_ASSOCCHANGED                                       = 0x00000034,
    GLOBALCOUNTER_APP_ITEMS_STATE_STORE_CACHE                        = 0x00000035,
    GLOBALCOUNTER_SETTINGSYNC_ENABLED                                = 0x00000036,
    GLOBALCOUNTER_APPSFOLDER_FILETYPEASSOCIATION_COUNTER             = 0x00000037,
    GLOBALCOUNTER_USERINFOCHANGED                                    = 0x00000038,
    GLOBALCOUNTER_SYNC_ENGINE_INFORMATION_CACHE_MACHINEWIDE          = 0x00000039,
    GLOBALCOUNTER_BANNERS_DATAMODEL_CACHE_MACHINEWIDE                = 0x0000003a,
    GLOBALCOUNTER_MAXIMUMVALUE                                       = 0x0000003b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/ne-shappmgr-appinfodataflags
alias APPINFODATAFLAGS = int;
enum : int
{
    AIM_DISPLAYNAME       = 0x00000001,
    AIM_VERSION           = 0x00000002,
    AIM_PUBLISHER         = 0x00000004,
    AIM_PRODUCTID         = 0x00000008,
    AIM_REGISTEREDOWNER   = 0x00000010,
    AIM_REGISTEREDCOMPANY = 0x00000020,
    AIM_LANGUAGE          = 0x00000040,
    AIM_SUPPORTURL        = 0x00000080,
    AIM_SUPPORTTELEPHONE  = 0x00000100,
    AIM_HELPLINK          = 0x00000200,
    AIM_INSTALLLOCATION   = 0x00000400,
    AIM_INSTALLSOURCE     = 0x00000800,
    AIM_INSTALLDATE       = 0x00001000,
    AIM_CONTACT           = 0x00004000,
    AIM_COMMENTS          = 0x00008000,
    AIM_IMAGE             = 0x00020000,
    AIM_READMEURL         = 0x00040000,
    AIM_UPDATEINFOURL     = 0x00080000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/ne-shappmgr-appactionflags
alias APPACTIONFLAGS = int;
enum : int
{
    APPACTION_INSTALL      = 0x00000001,
    APPACTION_UNINSTALL    = 0x00000002,
    APPACTION_MODIFY       = 0x00000004,
    APPACTION_REPAIR       = 0x00000008,
    APPACTION_UPGRADE      = 0x00000010,
    APPACTION_CANGETSIZE   = 0x00000020,
    APPACTION_MODIFYREMOVE = 0x00000080,
    APPACTION_ADDLATER     = 0x00000100,
    APPACTION_UNSCHEDULE   = 0x00000200,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/ne-shappmgr-pubappinfoflags
alias PUBAPPINFOFLAGS = int;
enum : int
{
    PAI_SOURCE        = 0x00000001,
    PAI_ASSIGNEDTIME  = 0x00000002,
    PAI_PUBLISHEDTIME = 0x00000004,
    PAI_SCHEDULEDTIME = 0x00000008,
    PAI_EXPIRETIME    = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/ne-credentialprovider-credential_provider_usage_scenario
alias CREDENTIAL_PROVIDER_USAGE_SCENARIO = int;
enum : int
{
    CPUS_INVALID            = 0x00000000,
    CPUS_LOGON              = 0x00000001,
    CPUS_UNLOCK_WORKSTATION = 0x00000002,
    CPUS_CHANGE_PASSWORD    = 0x00000003,
    CPUS_CREDUI             = 0x00000004,
    CPUS_PLAP               = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/ne-credentialprovider-credential_provider_field_type
alias CREDENTIAL_PROVIDER_FIELD_TYPE = int;
enum : int
{
    CPFT_INVALID       = 0x00000000,
    CPFT_LARGE_TEXT    = 0x00000001,
    CPFT_SMALL_TEXT    = 0x00000002,
    CPFT_COMMAND_LINK  = 0x00000003,
    CPFT_EDIT_TEXT     = 0x00000004,
    CPFT_PASSWORD_TEXT = 0x00000005,
    CPFT_TILE_IMAGE    = 0x00000006,
    CPFT_CHECKBOX      = 0x00000007,
    CPFT_COMBOBOX      = 0x00000008,
    CPFT_SUBMIT_BUTTON = 0x00000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/ne-credentialprovider-credential_provider_field_state
alias CREDENTIAL_PROVIDER_FIELD_STATE = int;
enum : int
{
    CPFS_HIDDEN                     = 0x00000000,
    CPFS_DISPLAY_IN_SELECTED_TILE   = 0x00000001,
    CPFS_DISPLAY_IN_DESELECTED_TILE = 0x00000002,
    CPFS_DISPLAY_IN_BOTH            = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/ne-credentialprovider-credential_provider_field_interactive_state
alias CREDENTIAL_PROVIDER_FIELD_INTERACTIVE_STATE = int;
enum : int
{
    CPFIS_NONE     = 0x00000000,
    CPFIS_READONLY = 0x00000001,
    CPFIS_DISABLED = 0x00000002,
    CPFIS_FOCUSED  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/ne-credentialprovider-credential_provider_get_serialization_response
alias CREDENTIAL_PROVIDER_GET_SERIALIZATION_RESPONSE = int;
enum : int
{
    CPGSR_NO_CREDENTIAL_NOT_FINISHED    = 0x00000000,
    CPGSR_NO_CREDENTIAL_FINISHED        = 0x00000001,
    CPGSR_RETURN_CREDENTIAL_FINISHED    = 0x00000002,
    CPGSR_RETURN_NO_CREDENTIAL_FINISHED = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/ne-credentialprovider-credential_provider_status_icon
alias CREDENTIAL_PROVIDER_STATUS_ICON = int;
enum : int
{
    CPSI_NONE    = 0x00000000,
    CPSI_ERROR   = 0x00000001,
    CPSI_WARNING = 0x00000002,
    CPSI_SUCCESS = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/ne-credentialprovider-credential_provider_account_options
alias CREDENTIAL_PROVIDER_ACCOUNT_OPTIONS = int;
enum : int
{
    CPAO_NONE            = 0x00000000,
    CPAO_EMPTY_LOCAL     = 0x00000001,
    CPAO_EMPTY_CONNECTED = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/ne-credentialprovider-credential_provider_credential_field_options
alias CREDENTIAL_PROVIDER_CREDENTIAL_FIELD_OPTIONS = int;
enum : int
{
    CPCFO_NONE                              = 0x00000000,
    CPCFO_ENABLE_PASSWORD_REVEAL            = 0x00000001,
    CPCFO_IS_EMAIL_ADDRESS                  = 0x00000002,
    CPCFO_ENABLE_TOUCH_KEYBOARD_AUTO_INVOKE = 0x00000004,
    CPCFO_NUMBERS_ONLY                      = 0x00000008,
    CPCFO_SHOW_ENGLISH_KEYBOARD             = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/ne-syncmgr-syncmgr_handler_capabilities
alias SYNCMGR_HANDLER_CAPABILITIES = int;
enum : int
{
    SYNCMGR_HCM_NONE                         = 0x00000000,
    SYNCMGR_HCM_PROVIDES_ICON                = 0x00000001,
    SYNCMGR_HCM_EVENT_STORE                  = 0x00000002,
    SYNCMGR_HCM_CONFLICT_STORE               = 0x00000004,
    SYNCMGR_HCM_SUPPORTS_CONCURRENT_SESSIONS = 0x00000010,
    SYNCMGR_HCM_CAN_BROWSE_CONTENT           = 0x00010000,
    SYNCMGR_HCM_CAN_SHOW_SCHEDULE            = 0x00020000,
    SYNCMGR_HCM_QUERY_BEFORE_ACTIVATE        = 0x00100000,
    SYNCMGR_HCM_QUERY_BEFORE_DEACTIVATE      = 0x00200000,
    SYNCMGR_HCM_QUERY_BEFORE_ENABLE          = 0x00400000,
    SYNCMGR_HCM_QUERY_BEFORE_DISABLE         = 0x00800000,
    SYNCMGR_HCM_VALID_MASK                   = 0x00f30017,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/ne-syncmgr-syncmgr_handler_policies
alias SYNCMGR_HANDLER_POLICIES = int;
enum : int
{
    SYNCMGR_HPM_NONE                 = 0x00000000,
    SYNCMGR_HPM_PREVENT_ACTIVATE     = 0x00000001,
    SYNCMGR_HPM_PREVENT_DEACTIVATE   = 0x00000002,
    SYNCMGR_HPM_PREVENT_ENABLE       = 0x00000004,
    SYNCMGR_HPM_PREVENT_DISABLE      = 0x00000008,
    SYNCMGR_HPM_PREVENT_START_SYNC   = 0x00000010,
    SYNCMGR_HPM_PREVENT_STOP_SYNC    = 0x00000020,
    SYNCMGR_HPM_DISABLE_ENABLE       = 0x00000100,
    SYNCMGR_HPM_DISABLE_DISABLE      = 0x00000200,
    SYNCMGR_HPM_DISABLE_START_SYNC   = 0x00000400,
    SYNCMGR_HPM_DISABLE_STOP_SYNC    = 0x00000800,
    SYNCMGR_HPM_DISABLE_BROWSE       = 0x00001000,
    SYNCMGR_HPM_DISABLE_SCHEDULE     = 0x00002000,
    SYNCMGR_HPM_HIDDEN_BY_DEFAULT    = 0x00010000,
    SYNCMGR_HPM_BACKGROUND_SYNC_ONLY = 0x00000030,
    SYNCMGR_HPM_VALID_MASK           = 0x00012f3f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/ne-syncmgr-syncmgr_handler_type
alias SYNCMGR_HANDLER_TYPE = int;
enum : int
{
    SYNCMGR_HT_UNSPECIFIED = 0x00000000,
    SYNCMGR_HT_APPLICATION = 0x00000001,
    SYNCMGR_HT_DEVICE      = 0x00000002,
    SYNCMGR_HT_FOLDER      = 0x00000003,
    SYNCMGR_HT_SERVICE     = 0x00000004,
    SYNCMGR_HT_COMPUTER    = 0x00000005,
    SYNCMGR_HT_MIN         = 0x00000000,
    SYNCMGR_HT_MAX         = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/ne-syncmgr-syncmgr_item_capabilities
alias SYNCMGR_ITEM_CAPABILITIES = int;
enum : int
{
    SYNCMGR_ICM_NONE                 = 0x00000000,
    SYNCMGR_ICM_PROVIDES_ICON        = 0x00000001,
    SYNCMGR_ICM_EVENT_STORE          = 0x00000002,
    SYNCMGR_ICM_CONFLICT_STORE       = 0x00000004,
    SYNCMGR_ICM_CAN_DELETE           = 0x00000010,
    SYNCMGR_ICM_CAN_BROWSE_CONTENT   = 0x00010000,
    SYNCMGR_ICM_QUERY_BEFORE_ENABLE  = 0x00100000,
    SYNCMGR_ICM_QUERY_BEFORE_DISABLE = 0x00200000,
    SYNCMGR_ICM_QUERY_BEFORE_DELETE  = 0x00400000,
    SYNCMGR_ICM_VALID_MASK           = 0x00710017,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/ne-syncmgr-syncmgr_item_policies
alias SYNCMGR_ITEM_POLICIES = int;
enum : int
{
    SYNCMGR_IPM_NONE               = 0x00000000,
    SYNCMGR_IPM_PREVENT_ENABLE     = 0x00000001,
    SYNCMGR_IPM_PREVENT_DISABLE    = 0x00000002,
    SYNCMGR_IPM_PREVENT_START_SYNC = 0x00000004,
    SYNCMGR_IPM_PREVENT_STOP_SYNC  = 0x00000008,
    SYNCMGR_IPM_DISABLE_ENABLE     = 0x00000010,
    SYNCMGR_IPM_DISABLE_DISABLE    = 0x00000020,
    SYNCMGR_IPM_DISABLE_START_SYNC = 0x00000040,
    SYNCMGR_IPM_DISABLE_STOP_SYNC  = 0x00000080,
    SYNCMGR_IPM_DISABLE_BROWSE     = 0x00000100,
    SYNCMGR_IPM_DISABLE_DELETE     = 0x00000200,
    SYNCMGR_IPM_HIDDEN_BY_DEFAULT  = 0x00010000,
    SYNCMGR_IPM_VALID_MASK         = 0x000102ff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/ne-syncmgr-syncmgr_progress_status
alias SYNCMGR_PROGRESS_STATUS = int;
enum : int
{
    SYNCMGR_PS_UPDATING               = 0x00000001,
    SYNCMGR_PS_UPDATING_INDETERMINATE = 0x00000002,
    SYNCMGR_PS_SUCCEEDED              = 0x00000003,
    SYNCMGR_PS_FAILED                 = 0x00000004,
    SYNCMGR_PS_CANCELED               = 0x00000005,
    SYNCMGR_PS_DISCONNECTED           = 0x00000006,
    SYNCMGR_PS_MAX                    = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/ne-syncmgr-syncmgr_cancel_request
alias SYNCMGR_CANCEL_REQUEST = int;
enum : int
{
    SYNCMGR_CR_NONE        = 0x00000000,
    SYNCMGR_CR_CANCEL_ITEM = 0x00000001,
    SYNCMGR_CR_CANCEL_ALL  = 0x00000002,
    SYNCMGR_CR_MAX         = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/ne-syncmgr-syncmgr_event_level
alias SYNCMGR_EVENT_LEVEL = int;
enum : int
{
    SYNCMGR_EL_INFORMATION = 0x00000001,
    SYNCMGR_EL_WARNING     = 0x00000002,
    SYNCMGR_EL_ERROR       = 0x00000003,
    SYNCMGR_EL_MAX         = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/ne-syncmgr-syncmgr_event_flags
alias SYNCMGR_EVENT_FLAGS = int;
enum : int
{
    SYNCMGR_EF_NONE  = 0x00000000,
    SYNCMGR_EF_VALID = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/ne-syncmgr-syncmgr_control_flags
alias SYNCMGR_CONTROL_FLAGS = int;
enum : int
{
    SYNCMGR_CF_NONE   = 0x00000000,
    SYNCMGR_CF_NOWAIT = 0x00000000,
    SYNCMGR_CF_WAIT   = 0x00000001,
    SYNCMGR_CF_NOUI   = 0x00000002,
    SYNCMGR_CF_VALID  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/ne-syncmgr-syncmgr_sync_control_flags
alias SYNCMGR_SYNC_CONTROL_FLAGS = int;
enum : int
{
    SYNCMGR_SCF_NONE                      = 0x00000000,
    SYNCMGR_SCF_IGNORE_IF_ALREADY_SYNCING = 0x00000001,
    SYNCMGR_SCF_VALID                     = 0x00000001,
}

alias SYNCMGR_UPDATE_REASON = int;
enum : int
{
    SYNCMGR_UR_ADDED   = 0x00000000,
    SYNCMGR_UR_CHANGED = 0x00000001,
    SYNCMGR_UR_REMOVED = 0x00000002,
    SYNCMGR_UR_MAX     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/ne-syncmgr-syncmgr_conflict_item_type
alias SYNCMGR_CONFLICT_ITEM_TYPE = int;
enum : int
{
    SYNCMGR_CIT_UPDATED = 0x00000001,
    SYNCMGR_CIT_DELETED = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/ne-syncmgr-syncmgr_resolution_abilities
alias SYNCMGR_RESOLUTION_ABILITIES = int;
enum : int
{
    SYNCMGR_RA_KEEPOTHER         = 0x00000001,
    SYNCMGR_RA_KEEPRECENT        = 0x00000002,
    SYNCMGR_RA_REMOVEFROMSYNCSET = 0x00000004,
    SYNCMGR_RA_KEEP_SINGLE       = 0x00000008,
    SYNCMGR_RA_KEEP_MULTIPLE     = 0x00000010,
    SYNCMGR_RA_VALID             = 0x0000001f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/ne-syncmgr-syncmgr_resolution_feedback
alias SYNCMGR_RESOLUTION_FEEDBACK = int;
enum : int
{
    SYNCMGR_RF_CONTINUE = 0x00000000,
    SYNCMGR_RF_REFRESH  = 0x00000001,
    SYNCMGR_RF_CANCEL   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/ne-syncmgr-syncmgr_presenter_next_step
alias SYNCMGR_PRESENTER_NEXT_STEP = int;
enum : int
{
    SYNCMGR_PNS_CONTINUE = 0x00000000,
    SYNCMGR_PNS_DEFAULT  = 0x00000001,
    SYNCMGR_PNS_CANCEL   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/ne-syncmgr-syncmgr_presenter_choice
alias SYNCMGR_PRESENTER_CHOICE = int;
enum : int
{
    SYNCMGR_PC_NO_CHOICE            = 0x00000000,
    SYNCMGR_PC_KEEP_ONE             = 0x00000001,
    SYNCMGR_PC_KEEP_MULTIPLE        = 0x00000002,
    SYNCMGR_PC_KEEP_RECENT          = 0x00000003,
    SYNCMGR_PC_REMOVE_FROM_SYNC_SET = 0x00000004,
    SYNCMGR_PC_SKIP                 = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbcache/ne-thumbcache-wts_flags
alias WTS_FLAGS = int;
enum : int
{
    WTS_NONE                 = 0x00000000,
    WTS_EXTRACT              = 0x00000000,
    WTS_INCACHEONLY          = 0x00000001,
    WTS_FASTEXTRACT          = 0x00000002,
    WTS_FORCEEXTRACTION      = 0x00000004,
    WTS_SLOWRECLAIM          = 0x00000008,
    WTS_EXTRACTDONOTCACHE    = 0x00000020,
    WTS_SCALETOREQUESTEDSIZE = 0x00000040,
    WTS_SKIPFASTEXTRACT      = 0x00000080,
    WTS_EXTRACTINPROC        = 0x00000100,
    WTS_CROPTOSQUARE         = 0x00000200,
    WTS_INSTANCESURROGATE    = 0x00000400,
    WTS_REQUIRESURROGATE     = 0x00000800,
    WTS_APPSTYLE             = 0x00002000,
    WTS_WIDETHUMBNAILS       = 0x00004000,
    WTS_IDEALCACHESIZEONLY   = 0x00008000,
    WTS_SCALEUP              = 0x00010000,
}

alias WTS_CACHEFLAGS = int;
enum : int
{
    WTS_DEFAULT    = 0x00000000,
    WTS_LOWQUALITY = 0x00000001,
    WTS_CACHED     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbcache/ne-thumbcache-wts_contextflags
alias WTS_CONTEXTFLAGS = int;
enum : int
{
    WTSCF_DEFAULT  = 0x00000000,
    WTSCF_APPSTYLE = 0x00000001,
    WTSCF_SQUARE   = 0x00000002,
    WTSCF_WIDE     = 0x00000004,
    WTSCF_FAST     = 0x00000008,
}

alias WTS_ALPHATYPE = int;
enum : int
{
    WTSAT_UNKNOWN = 0x00000000,
    WTSAT_RGB     = 0x00000001,
    WTSAT_ARGB    = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/ne-mobsync-syncmgrstatus
alias SYNCMGRSTATUS = int;
enum : int
{
    SYNCMGRSTATUS_STOPPED                = 0x00000000,
    SYNCMGRSTATUS_SKIPPED                = 0x00000001,
    SYNCMGRSTATUS_PENDING                = 0x00000002,
    SYNCMGRSTATUS_UPDATING               = 0x00000003,
    SYNCMGRSTATUS_SUCCEEDED              = 0x00000004,
    SYNCMGRSTATUS_FAILED                 = 0x00000005,
    SYNCMGRSTATUS_PAUSED                 = 0x00000006,
    SYNCMGRSTATUS_RESUMING               = 0x00000007,
    SYNCMGRSTATUS_UPDATING_INDETERMINATE = 0x00000008,
    SYNCMGRSTATUS_DELETED                = 0x00000100,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/ne-mobsync-syncmgrloglevel
alias SYNCMGRLOGLEVEL = int;
enum : int
{
    SYNCMGRLOGLEVEL_INFORMATION = 0x00000001,
    SYNCMGRLOGLEVEL_WARNING     = 0x00000002,
    SYNCMGRLOGLEVEL_ERROR       = 0x00000003,
    SYNCMGRLOGLEVEL_LOGLEVELMAX = 0x00000003,
}

alias SYNCMGRERRORFLAGS = int;
enum : int
{
    SYNCMGRERRORFLAG_ENABLEJUMPTEXT = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/ne-mobsync-syncmgritemflags
alias SYNCMGRITEMFLAGS = int;
enum : int
{
    SYNCMGRITEM_HASPROPERTIES  = 0x00000001,
    SYNCMGRITEM_TEMPORARY      = 0x00000002,
    SYNCMGRITEM_ROAMINGUSER    = 0x00000004,
    SYNCMGRITEM_LASTUPDATETIME = 0x00000008,
    SYNCMGRITEM_MAYDELETEITEM  = 0x00000010,
    SYNCMGRITEM_HIDDEN         = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/ne-mobsync-syncmgrflag
alias SYNCMGRFLAG = int;
enum : int
{
    SYNCMGRFLAG_CONNECT           = 0x00000001,
    SYNCMGRFLAG_PENDINGDISCONNECT = 0x00000002,
    SYNCMGRFLAG_MANUAL            = 0x00000003,
    SYNCMGRFLAG_IDLE              = 0x00000004,
    SYNCMGRFLAG_INVOKE            = 0x00000005,
    SYNCMGRFLAG_SCHEDULED         = 0x00000006,
    SYNCMGRFLAG_EVENTMASK         = 0x000000ff,
    SYNCMGRFLAG_SETTINGS          = 0x00000100,
    SYNCMGRFLAG_MAYBOTHERUSER     = 0x00000200,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/ne-mobsync-syncmgrhandlerflags
alias SYNCMGRHANDLERFLAGS = int;
enum : int
{
    SYNCMGRHANDLER_HASPROPERTIES          = 0x00000001,
    SYNCMGRHANDLER_MAYESTABLISHCONNECTION = 0x00000002,
    SYNCMGRHANDLER_ALWAYSLISTHANDLER      = 0x00000004,
    SYNCMGRHANDLER_HIDDEN                 = 0x00000008,
}

alias SYNCMGRITEMSTATE = int;
enum : int
{
    SYNCMGRITEMSTATE_UNCHECKED = 0x00000000,
    SYNCMGRITEMSTATE_CHECKED   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/ne-mobsync-syncmgrinvokeflags
alias SYNCMGRINVOKEFLAGS = int;
enum : int
{
    SYNCMGRINVOKE_STARTSYNC = 0x00000002,
    SYNCMGRINVOKE_MINIMIZED = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/ne-mobsync-syncmgrregisterflags
alias SYNCMGRREGISTERFLAGS = int;
enum : int
{
    SYNCMGRREGISTERFLAG_CONNECT           = 0x00000001,
    SYNCMGRREGISTERFLAG_PENDINGDISCONNECT = 0x00000002,
    SYNCMGRREGISTERFLAG_IDLE              = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbnailstreamcache/ne-thumbnailstreamcache-thumbnailstreamcacheoptions
enum ThumbnailStreamCacheOptions : int
{
    ExtractIfNotCached = 0x00000000,
    ReturnOnlyIfCached = 0x00000001,
    ResizeThumbnail    = 0x00000002,
    AllowSmallerSize   = 0x00000004,
}

alias TLENUMF = int;
enum : int
{
    TLEF_RELATIVE_INCLUDE_CURRENT = 0x00000001,
    TLEF_RELATIVE_BACK            = 0x00000010,
    TLEF_RELATIVE_FORE            = 0x00000020,
    TLEF_INCLUDE_UNINVOKEABLE     = 0x00000040,
    TLEF_ABSOLUTE                 = 0x00000031,
    TLEF_EXCLUDE_SUBFRAME_ENTRIES = 0x00000080,
    TLEF_EXCLUDE_ABOUT_PAGES      = 0x00000100,
}

alias HLSR = int;
enum : int
{
    HLSR_HOME          = 0x00000000,
    HLSR_SEARCHPAGE    = 0x00000001,
    HLSR_HISTORYFOLDER = 0x00000002,
}

alias HLSHORTCUTF = int;
enum : int
{
    HLSHORTCUTF_DEFAULT                     = 0x00000000,
    HLSHORTCUTF_DONTACTUALLYCREATE          = 0x00000001,
    HLSHORTCUTF_USEFILENAMEFROMFRIENDLYNAME = 0x00000002,
    HLSHORTCUTF_USEUNIQUEFILENAME           = 0x00000004,
    HLSHORTCUTF_MAYUSEEXISTINGSHORTCUT      = 0x00000008,
}

alias HLTRANSLATEF = int;
enum : int
{
    HLTRANSLATEF_DEFAULT                = 0x00000000,
    HLTRANSLATEF_DONTAPPLYDEFAULTPREFIX = 0x00000001,
}

alias HLNF = uint;
enum : uint
{
    HLNF_INTERNALJUMP          = 0x00000001U,
    HLNF_OPENINNEWWINDOW       = 0x00000002U,
    HLNF_NAVIGATINGBACK        = 0x00000004U,
    HLNF_NAVIGATINGFORWARD     = 0x00000008U,
    HLNF_NAVIGATINGTOSTACKITEM = 0x00000010U,
    HLNF_CREATENOHISTORY       = 0x00000020U,
}

alias HLINKGETREF = int;
enum : int
{
    HLINKGETREF_DEFAULT  = 0x00000000,
    HLINKGETREF_ABSOLUTE = 0x00000001,
    HLINKGETREF_RELATIVE = 0x00000002,
}

alias HLFNAMEF = int;
enum : int
{
    HLFNAMEF_DEFAULT          = 0x00000000,
    HLFNAMEF_TRYCACHE         = 0x00000001,
    HLFNAMEF_TRYPRETTYTARGET  = 0x00000002,
    HLFNAMEF_TRYFULLTARGET    = 0x00000004,
    HLFNAMEF_TRYWIN95SHORTCUT = 0x00000008,
}

alias HLINKMISC = int;
enum : int
{
    HLINKMISC_RELATIVE = 0x00000001,
}

alias HLINKSETF = int;
enum : int
{
    HLINKSETF_TARGET   = 0x00000001,
    HLINKSETF_LOCATION = 0x00000002,
}

alias HLINKWHICHMK = int;
enum : int
{
    HLINKWHICHMK_CONTAINER = 0x00000001,
    HLINKWHICHMK_BASE      = 0x00000002,
}

alias HLTB_INFO = int;
enum : int
{
    HLTB_DOCKEDLEFT   = 0x00000000,
    HLTB_DOCKEDTOP    = 0x00000001,
    HLTB_DOCKEDRIGHT  = 0x00000002,
    HLTB_DOCKEDBOTTOM = 0x00000003,
    HLTB_FLOATING     = 0x00000004,
}

alias HLBWIF_FLAGS = int;
enum : int
{
    HLBWIF_HASFRAMEWNDINFO   = 0x00000001,
    HLBWIF_HASDOCWNDINFO     = 0x00000002,
    HLBWIF_FRAMEWNDMAXIMIZED = 0x00000004,
    HLBWIF_DOCWNDMAXIMIZED   = 0x00000008,
    HLBWIF_HASWEBTOOLBARINFO = 0x00000010,
    HLBWIF_WEBTOOLBARHIDDEN  = 0x00000020,
}

alias HLID_INFO = uint;
enum : uint
{
    HLID_INVALID     = 0x00000000U,
    HLID_PREVIOUS    = 0xffffffffU,
    HLID_NEXT        = 0xfffffffeU,
    HLID_CURRENT     = 0xfffffffdU,
    HLID_STACKBOTTOM = 0xfffffffcU,
    HLID_STACKTOP    = 0xfffffffbU,
}

alias HLQF_INFO = int;
enum : int
{
    HLQF_ISVALID   = 0x00000001,
    HLQF_ISCURRENT = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/ne-shdeprecated-bnstate
alias BNSTATE = int;
enum : int
{
    BNS_NORMAL         = 0x00000000,
    BNS_BEGIN_NAVIGATE = 0x00000001,
    BNS_NAVIGATE       = 0x00000002,
}

alias SHELLBROWSERSHOWCONTROL = int;
enum : int
{
    SBSC_HIDE   = 0x00000000,
    SBSC_SHOW   = 0x00000001,
    SBSC_TOGGLE = 0x00000002,
    SBSC_QUERY  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/ne-shdeprecated-securelockcode
alias SECURELOCKCODE = int;
enum : int
{
    SECURELOCK_NOCHANGE                 = 0xffffffff,
    SECURELOCK_SET_UNSECURE             = 0x00000000,
    SECURELOCK_SET_MIXED                = 0x00000001,
    SECURELOCK_SET_SECUREUNKNOWNBIT     = 0x00000002,
    SECURELOCK_SET_SECURE40BIT          = 0x00000003,
    SECURELOCK_SET_SECURE56BIT          = 0x00000004,
    SECURELOCK_SET_FORTEZZA             = 0x00000005,
    SECURELOCK_SET_SECURE128BIT         = 0x00000006,
    SECURELOCK_FIRSTSUGGEST             = 0x00000007,
    SECURELOCK_SUGGEST_UNSECURE         = 0x00000007,
    SECURELOCK_SUGGEST_MIXED            = 0x00000008,
    SECURELOCK_SUGGEST_SECUREUNKNOWNBIT = 0x00000009,
    SECURELOCK_SUGGEST_SECURE40BIT      = 0x0000000a,
    SECURELOCK_SUGGEST_SECURE56BIT      = 0x0000000b,
    SECURELOCK_SUGGEST_FORTEZZA         = 0x0000000c,
    SECURELOCK_SUGGEST_SECURE128BIT     = 0x0000000d,
}

alias IEPDNFLAGS = int;
enum : int
{
    IEPDN_BINDINGUI = 0x00000001,
}

alias TI_FLAGS = int;
enum : int
{
    TI_BITMAP = 0x00000001,
    TI_JPEG   = 0x00000002,
}

alias PATHCCH_OPTIONS = uint;
enum : uint
{
    PATHCCH_NONE                            = 0x00000000U,
    PATHCCH_ALLOW_LONG_PATHS                = 0x00000001U,
    PATHCCH_FORCE_ENABLE_LONG_NAME_PROCESS  = 0x00000002U,
    PATHCCH_FORCE_DISABLE_LONG_NAME_PROCESS = 0x00000004U,
    PATHCCH_DO_NOT_NORMALIZE_SEGMENTS       = 0x00000008U,
    PATHCCH_ENSURE_IS_EXTENDED_LENGTH_PATH  = 0x00000010U,
    PATHCCH_ENSURE_TRAILING_SLASH           = 0x00000020U,
    PATHCCH_CANONICALIZE_SLASHES            = 0x00000040U,
}

alias IURL_SETURL_FLAGS = int;
enum : int
{
    IURL_SETURL_FL_GUESS_PROTOCOL       = 0x00000001,
    IURL_SETURL_FL_USE_DEFAULT_PROTOCOL = 0x00000002,
}

alias IURL_INVOKECOMMAND_FLAGS = int;
enum : int
{
    IURL_INVOKECOMMAND_FL_ALLOW_UI         = 0x00000001,
    IURL_INVOKECOMMAND_FL_USE_DEFAULT_VERB = 0x00000002,
    IURL_INVOKECOMMAND_FL_DDEWAIT          = 0x00000004,
    IURL_INVOKECOMMAND_FL_ASYNCOK          = 0x00000008,
    IURL_INVOKECOMMAND_FL_LOG_USAGE        = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/intshcut/ne-intshcut-translateurl_in_flags
alias TRANSLATEURL_IN_FLAGS = int;
enum : int
{
    TRANSLATEURL_FL_GUESS_PROTOCOL       = 0x00000001,
    TRANSLATEURL_FL_USE_DEFAULT_PROTOCOL = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/intshcut/ne-intshcut-urlassociationdialog_in_flags
alias URLASSOCIATIONDIALOG_IN_FLAGS = int;
enum : int
{
    URLASSOCDLG_FL_USE_DEFAULT_NAME = 0x00000001,
    URLASSOCDLG_FL_REGISTER_ASSOC   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/intshcut/ne-intshcut-mimeassociationdialog_in_flags
alias MIMEASSOCIATIONDIALOG_IN_FLAGS = int;
enum : int
{
    MIMEASSOCDLG_FL_REGISTER_ASSOC = 0x00000001,
}

// Constants


enum : HRESULT
{
    HLINK_E_FIRST = HRESULT(0x80040100),
    HLINK_S_FIRST = HRESULT(0x00040100),
}

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/wm-cpl-launch
    WM_CPL_LAUNCH   = 0x000007e8U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/wm-cpl-launched
    WM_CPL_LAUNCHED = 0x000007e9U,
}

enum uint CPL_DYNAMIC_RES = 0x00000000U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/cpl-init
    CPL_INIT     = 0x00000001U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/cpl-getcount
    CPL_GETCOUNT = 0x00000002U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/cpl-inquire
enum uint CPL_INQUIRE = 0x00000003U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/cpl-select
enum uint CPL_SELECT = 0x00000004U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/cpl-dblclk
enum uint CPL_DBLCLK = 0x00000005U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/cpl-stop
    CPL_STOP       = 0x00000006U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/cpl-exit
    CPL_EXIT       = 0x00000007U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/cpl-newinquire
    CPL_NEWINQUIRE = 0x00000008U,
}

enum : uint
{
    CPL_STARTWPARMSA = 0x00000009U,
    CPL_STARTWPARMSW = 0x0000000aU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/cpl-startwparms
    CPL_STARTWPARMS  = 0x0000000aU,
}

enum uint CPL_SETUP = 0x000000c8U;
enum int HLINK_S_DONTHIDE = 0x00040100;

enum : GUID
{
    FOLDERID_NetworkFolder  = GUID("d20beec4-5ca8-4905-ae3b-bf251ea09b53"),
    FOLDERID_ComputerFolder = GUID("0ac0837c-bbf8-452a-850d-79d08e667ca7"),
}

enum GUID FOLDERID_InternetFolder = GUID("4d9f7874-4e0c-4904-967b-40b0d20c3e4b");
enum GUID FOLDERID_ControlPanelFolder = GUID("82a74aeb-aeb4-465c-a014-d097ee346d63");
enum GUID FOLDERID_PrintersFolder = GUID("76fc4e2d-d6ad-4519-a663-37bd56068185");

enum : GUID
{
    FOLDERID_SyncManagerFolder = GUID("43668bf8-c14e-49b2-97c9-747784d784b7"),
    FOLDERID_SyncSetupFolder   = GUID("0f214138-b1d3-4a90-bba9-27cbc0c5389a"),
}

enum GUID FOLDERID_ConflictFolder = GUID("4bfefb45-347d-4006-a5be-ac0cb0567192");
enum GUID FOLDERID_SyncResultsFolder = GUID("289a9a43-be44-4057-a41b-587a76d7e7f9");
enum GUID FOLDERID_RecycleBinFolder = GUID("b7534046-3ecb-4c18-be4e-64cd4cb7d6ac");
enum GUID FOLDERID_ConnectionsFolder = GUID("6f0cd92b-2e97-45d1-88ff-b0d186b8dedd");

enum : GUID
{
    FOLDERID_Fonts           = GUID("fd228cb7-ae11-4ae3-864c-16f3910ab8fe"),
    FOLDERID_Desktop         = GUID("b4bfcc3a-db2c-424c-b029-7fe99a87c641"),
    FOLDERID_Startup         = GUID("b97d20bb-f46a-4c97-ba10-5e3608430854"),
    FOLDERID_Programs        = GUID("a77f5d77-2e2b-44c3-a6a2-aba601054a51"),
    FOLDERID_StartMenu       = GUID("625b53c3-ab48-4ec1-ba1f-a1ef4146fc19"),
    FOLDERID_Recent          = GUID("ae50c081-ebd2-438a-8655-8a092e34987a"),
    FOLDERID_SendTo          = GUID("8983036c-27c0-404b-8f08-102d10dcfd74"),
    FOLDERID_Documents       = GUID("fdd39ad0-238f-46af-adb4-6c85480369c7"),
    FOLDERID_Favorites       = GUID("1777f761-68ad-4d8a-87bd-30b759fa33dd"),
    FOLDERID_NetHood         = GUID("c5abbf53-e17f-4121-8900-86626fc2c973"),
    FOLDERID_PrintHood       = GUID("9274bd8d-cfd1-41c3-b35e-b13f55a758f4"),
    FOLDERID_Templates       = GUID("a63293e8-664e-48db-a079-df759e0509f7"),
    FOLDERID_CommonStartup   = GUID("82a5ea35-d9cd-47c5-9629-e15d2f714e6e"),
    FOLDERID_CommonPrograms  = GUID("0139d44e-6afe-49f2-8690-3dafcae6ffb8"),
    FOLDERID_CommonStartMenu = GUID("a4115719-d62e-491d-aa7c-e74b8be3b067"),
}

enum : GUID
{
    FOLDERID_PublicDesktop   = GUID("c4aa340d-f20f-4863-afef-f87ef2e6ba25"),
    FOLDERID_ProgramData     = GUID("62ab5d82-fdc1-4dc3-a9dd-070d1d495d97"),
    FOLDERID_CommonTemplates = GUID("b94237e7-57ac-4347-9151-b08c6c32d1f7"),
}

enum GUID FOLDERID_PublicDocuments = GUID("ed4824af-dce4-45a8-81e2-fc7965083634");
enum GUID FOLDERID_RoamingAppData = GUID("3eb685db-65f9-4cf6-a03a-e3ef65729f3d");

enum : GUID
{
    FOLDERID_LocalAppData    = GUID("f1b32785-6fba-4fcf-9d55-7b8e7f157091"),
    FOLDERID_LocalAppDataLow = GUID("a520a1a4-1780-4ff6-bd18-167343c5af16"),
}

enum : GUID
{
    FOLDERID_InternetCache         = GUID("352481e8-33be-4251-ba85-6007caedcf9d"),
    FOLDERID_Cookies               = GUID("2b0f765d-c0e9-4171-908e-08a611b84ff6"),
    FOLDERID_History               = GUID("d9dc8a3b-b784-432e-a781-5a1130a75963"),
    FOLDERID_System                = GUID("1ac14e77-02e7-4e5d-b744-2eb1ae5198b7"),
    FOLDERID_SystemX86             = GUID("d65231b0-b2f1-4857-a4ce-a8e7c6ea7d27"),
    FOLDERID_Windows               = GUID("f38bf404-1d43-42f2-9305-67de0b28fc23"),
    FOLDERID_Profile               = GUID("5e6c858f-0e22-4760-9afe-ea3317b67173"),
    FOLDERID_Pictures              = GUID("33e28130-4e1e-4676-835a-98395c3bc3bb"),
    FOLDERID_ProgramFilesX86       = GUID("7c5a40ef-a0fb-4bfc-874a-c0f2e0b9fa8e"),
    FOLDERID_ProgramFilesCommonX86 = GUID("de974d24-d9c6-4d3e-bf91-f4455120b917"),
    FOLDERID_ProgramFilesX64       = GUID("6d809377-6af0-444b-8957-a3773f02200e"),
    FOLDERID_ProgramFilesCommonX64 = GUID("6365d5a7-0f0d-45e5-87f6-0da56b6a4f7d"),
    FOLDERID_ProgramFiles          = GUID("905e63b6-c1bf-494e-b29c-65b732d3d21a"),
    FOLDERID_ProgramFilesCommon    = GUID("f7f1ed05-9f6d-47a2-aaae-29d317c6f066"),
}

enum : GUID
{
    FOLDERID_UserProgramFiles       = GUID("5cd7aee2-2219-4a67-b85d-6c9ce15660cb"),
    FOLDERID_UserProgramFilesCommon = GUID("bcbd3057-ca5c-4622-b42d-bc56db0ae516"),
}

enum : GUID
{
    FOLDERID_AdminTools       = GUID("724ef170-a42d-4fef-9f26-b60e846fba4f"),
    FOLDERID_CommonAdminTools = GUID("d0384e7d-bac3-4797-8f14-cba229b392b5"),
}

enum : GUID
{
    FOLDERID_Music           = GUID("4bd8d571-6d19-48d3-be97-422220080e43"),
    FOLDERID_Videos          = GUID("18989b1d-99b5-455b-841c-ab7c74e4ddfc"),
    FOLDERID_Ringtones       = GUID("c870044b-f49e-4126-a9c3-b52a1ff411e8"),
    FOLDERID_PublicPictures  = GUID("b6ebfb86-6907-413c-9af7-4fc2abf07cc5"),
    FOLDERID_PublicMusic     = GUID("3214fab5-9757-4298-bb61-92a9deaa44ff"),
    FOLDERID_PublicVideos    = GUID("2400183a-6185-49fb-a2d8-4a392a602ba3"),
    FOLDERID_PublicRingtones = GUID("e555ab60-153b-4d17-9f04-a5fe99fc15ec"),
}

enum : GUID
{
    FOLDERID_ResourceDir           = GUID("8ad10c31-2adb-4296-a8f7-e4701232c972"),
    FOLDERID_LocalizedResourcesDir = GUID("2a00375e-224c-49de-b8d1-440df7ef3ddc"),
}

enum : GUID
{
    FOLDERID_CommonOEMLinks       = GUID("c1bae2d0-10df-4334-bedd-7aa20b227a9d"),
    FOLDERID_CDBurning            = GUID("9e52ab10-f80d-49df-acb8-4330f5687855"),
    FOLDERID_UserProfiles         = GUID("0762d272-c50a-4bb0-a382-697dcd729b80"),
    FOLDERID_Playlists            = GUID("de92c1c7-837f-4f69-a3bb-86e631204a23"),
    FOLDERID_SamplePlaylists      = GUID("15ca69b3-30ee-49c1-ace1-6b5ec372afb5"),
    FOLDERID_SampleMusic          = GUID("b250c668-f57d-4ee1-a63c-290ee7d1aa1f"),
    FOLDERID_SamplePictures       = GUID("c4900540-2379-4c75-844b-64e6faf8716b"),
    FOLDERID_SampleVideos         = GUID("859ead94-2e85-48ad-a71a-0969cb56a6cd"),
    FOLDERID_PhotoAlbums          = GUID("69d2cf90-fc33-4fb7-9a0c-ebb0f0fcb43c"),
    FOLDERID_Public               = GUID("dfdf76a2-c82a-4d63-906a-5644ac457385"),
    FOLDERID_ChangeRemovePrograms = GUID("df7266ac-9274-4867-8d55-3bd661de872d"),
}

enum : GUID
{
    FOLDERID_AppUpdates     = GUID("a305ce99-f527-492b-8b1a-7e76fa98d6e4"),
    FOLDERID_AddNewPrograms = GUID("de61d971-5ebc-4f02-a3a9-6c82895e5c04"),
}

enum : GUID
{
    FOLDERID_Downloads       = GUID("374de290-123f-4565-9164-39c4925e467b"),
    FOLDERID_PublicDownloads = GUID("3d644c9b-1fb8-4f30-9b45-f670235f79c0"),
}

enum : GUID
{
    FOLDERID_SavedSearches       = GUID("7d1d3a04-debb-4115-95cf-2f29da2920da"),
    FOLDERID_QuickLaunch         = GUID("52a4f021-7b75-48a9-9f6b-4b87a210bc8f"),
    FOLDERID_Contacts            = GUID("56784854-c6cb-462b-8169-88e350acb882"),
    FOLDERID_SidebarParts        = GUID("a75d362e-50fc-4fb7-ac2c-a8beaa314493"),
    FOLDERID_SidebarDefaultParts = GUID("7b396e54-9ec5-4300-be0a-2482ebae1a26"),
}

enum GUID FOLDERID_PublicGameTasks = GUID("debf2536-e1a8-4c59-b6a2-414586476aea");

enum : GUID
{
    FOLDERID_GameTasks      = GUID("054fae61-4dd8-4787-80b6-090220c4b700"),
    FOLDERID_SavedGames     = GUID("4c5c32ff-bb9d-43b0-b5b4-2d72e54eaaa4"),
    FOLDERID_Games          = GUID("cac52c1a-b53d-4edc-92d7-6b2e8ac19434"),
    FOLDERID_SEARCH_MAPI    = GUID("98ec0e18-2098-4d44-8644-66979315a281"),
    FOLDERID_SEARCH_CSC     = GUID("ee32e446-31ca-4aba-814f-a5ebd2fd6d5e"),
    FOLDERID_Links          = GUID("bfb9d5e0-c6a9-404c-b2b2-ae6db6af4968"),
    FOLDERID_UsersFiles     = GUID("f3ce0f7c-4901-4acc-8648-d5d44b04ef8f"),
    FOLDERID_UsersLibraries = GUID("a302545d-deff-464b-abe8-61c8648d939b"),
}

enum : GUID
{
    FOLDERID_SearchHome     = GUID("190337d1-b8ca-4121-a639-6d472d16972a"),
    FOLDERID_OriginalImages = GUID("2c36c0aa-5812-4b87-bfd0-4cd0dfb19b39"),
}

enum GUID FOLDERID_DocumentsLibrary = GUID("7b0db17d-9cd2-4a93-9733-46cc89022e7c");

enum : GUID
{
    FOLDERID_MusicLibrary    = GUID("2112ab0a-c86a-4ffe-a368-0de96e47012e"),
    FOLDERID_PicturesLibrary = GUID("a990ae9f-a03b-4e80-94bc-9912d7504104"),
}

enum : GUID
{
    FOLDERID_VideosLibrary     = GUID("491e922f-5643-4af4-a7eb-4e7a138d8174"),
    FOLDERID_RecordedTVLibrary = GUID("1a6fdba2-f42d-4358-a798-b74d745926c5"),
}

enum : GUID
{
    FOLDERID_HomeGroup            = GUID("52528a6b-b9e3-4add-b60d-588c2dba842d"),
    FOLDERID_HomeGroupCurrentUser = GUID("9b74b6a3-0dfd-4f11-9e78-5f7800f2e772"),
}

enum GUID FOLDERID_DeviceMetadataStore = GUID("5ce4a5e9-e4eb-479d-b89f-130c02886155");

enum : GUID
{
    FOLDERID_Libraries       = GUID("1b3ea5dc-b587-4786-b4ef-bd1dc332aeae"),
    FOLDERID_PublicLibraries = GUID("48daf80b-e6cf-4f4e-b800-0e69d84ee384"),
}

enum : GUID
{
    FOLDERID_UserPinned           = GUID("9e3995ab-1f9c-4f13-b827-48b24b6c7174"),
    FOLDERID_ImplicitAppShortcuts = GUID("bcb5256f-79f6-4cee-b725-dc34e402fd46"),
}

enum GUID FOLDERID_AccountPictures = GUID("008ca0b1-55b4-4c56-b8a8-4de4b299d3be");
enum GUID FOLDERID_PublicUserTiles = GUID("0482af6c-08f1-4c34-8c90-e17ec98b1e17");

enum : GUID
{
    FOLDERID_AppsFolder           = GUID("1e87508d-89c2-42f0-8a7e-645a0f50ca58"),
    FOLDERID_StartMenuAllPrograms = GUID("f26305ef-6948-40b9-b255-81453d09c785"),
}

enum GUID FOLDERID_CommonStartMenuPlaces = GUID("a440879f-87a0-4f7d-b700-0207b966194a");
enum GUID FOLDERID_ApplicationShortcuts = GUID("a3918781-e5f2-4890-b3d9-a7e54332328c");

enum : GUID
{
    FOLDERID_RoamingTiles     = GUID("00bcfc5a-ed94-4e48-96a1-3f6217f21990"),
    FOLDERID_RoamedTileImages = GUID("aaa8d5a5-f1d6-4259-baa8-78e7ef60835e"),
}

enum : GUID
{
    FOLDERID_Screenshots        = GUID("b7bede81-df94-4682-a7d8-57a52620b86f"),
    FOLDERID_CameraRoll         = GUID("ab5fb87b-7ce2-4f83-915d-550846c9537b"),
    FOLDERID_SkyDrive           = GUID("a52bba46-e9e1-435f-b3d9-28daa648c0f6"),
    FOLDERID_OneDrive           = GUID("a52bba46-e9e1-435f-b3d9-28daa648c0f6"),
    FOLDERID_SkyDriveDocuments  = GUID("24d89e24-2f19-4534-9dde-6a6671fbb8fe"),
    FOLDERID_SkyDrivePictures   = GUID("339719b5-8c47-4894-94c2-d8f77add44a6"),
    FOLDERID_SkyDriveMusic      = GUID("c3f2459e-80d6-45dc-bfef-1f769f2be730"),
    FOLDERID_SkyDriveCameraRoll = GUID("767e6811-49cb-4273-87c2-20f355e1085b"),
}

enum : GUID
{
    FOLDERID_SearchHistory   = GUID("0d4c3db6-03a3-462f-a0e6-08924c41b5d4"),
    FOLDERID_SearchTemplates = GUID("7e636bfe-dfa9-4d5e-b456-d7b39851d8a9"),
}

enum GUID FOLDERID_CameraRollLibrary = GUID("2b20df75-1eda-4039-8097-38798227d5b7");

enum : GUID
{
    FOLDERID_SavedPictures        = GUID("3b193882-d3ad-4eab-965a-69829d1fb59f"),
    FOLDERID_SavedPicturesLibrary = GUID("e25b5812-be88-4bd9-94b0-29233477b6c3"),
}

enum : GUID
{
    FOLDERID_RetailDemo       = GUID("12d4c69e-24ad-4923-be19-31321c43a767"),
    FOLDERID_Device           = GUID("1c2ac1dc-4358-4b6c-9733-af21156576f0"),
    FOLDERID_DevelopmentFiles = GUID("dbe8e08e-3053-4bbc-b183-2a7b2b191e59"),
}

enum : GUID
{
    FOLDERID_Objects3D      = GUID("31c0dd25-9439-4f12-bf41-7ff4eda38722"),
    FOLDERID_AppCaptures    = GUID("edc0fe71-98d8-4f4a-b920-c8dc133cb165"),
    FOLDERID_LocalDocuments = GUID("f42ee2d3-909f-4907-8871-4c22fc0bf756"),
    FOLDERID_LocalPictures  = GUID("0ddd015d-b06c-45d5-8c4c-f59713854639"),
    FOLDERID_LocalVideos    = GUID("35286a68-3c57-41a1-bbb1-0eae73d76c95"),
    FOLDERID_LocalMusic     = GUID("a0c69a99-21c8-4671-8703-7934162fcf1d"),
    FOLDERID_LocalDownloads = GUID("7d83ee9b-2244-4e70-b1f5-5393042af1e4"),
}

enum : GUID
{
    FOLDERID_RecordedCalls  = GUID("2f8b40c2-83ed-48ee-b383-a1f157ec6f9a"),
    FOLDERID_AllAppMods     = GUID("7ad67899-66af-43ba-9156-6aad42e6c596"),
    FOLDERID_CurrentAppMods = GUID("3db40b20-2a30-4dbe-917e-771dd21dd099"),
}

enum : GUID
{
    FOLDERID_AppDataDesktop     = GUID("b2c5e279-7add-439f-b28c-c41fe1bbf672"),
    FOLDERID_AppDataDocuments   = GUID("7be16610-1f7f-44ac-bff0-83e15f2ffca1"),
    FOLDERID_AppDataFavorites   = GUID("7cfbefbc-de1f-45aa-b843-a542ac536cc9"),
    FOLDERID_AppDataProgramData = GUID("559d40a3-a036-40fa-af61-84cb430a4d34"),
}

enum GUID FOLDERID_LocalStorage = GUID("b3eb08d3-a1f3-496b-865a-42b536cda0ec");
enum GUID CLSID_InternetShortcut = GUID("fbf23b40-e3f0-101b-8488-00aa003e56f8");

enum : GUID
{
    CLSID_NetworkDomain = GUID("46e06680-4bf0-11d1-83ee-00a0c90dc849"),
    CLSID_NetworkServer = GUID("c0542a90-4bf0-11d1-83ee-00a0c90dc849"),
    CLSID_NetworkShare  = GUID("54a754c0-4bf0-11d1-83ee-00a0c90dc849"),
}

enum GUID CLSID_MyComputer = GUID("20d04fe0-3aea-1069-a2d8-08002b30309d");

enum : GUID
{
    CLSID_Internet   = GUID("871c5380-42a0-1069-a2ea-08002b30309d"),
    CLSID_RecycleBin = GUID("645ff040-5081-101b-9f08-00aa002f954e"),
}

enum GUID CLSID_ControlPanel = GUID("21ec2020-3aea-1069-a2dd-08002b30309d");

enum : GUID
{
    CLSID_Printers    = GUID("2227a280-3aea-1069-a2de-08002b30309d"),
    CLSID_MyDocuments = GUID("450d8fba-ad25-11d0-98a8-0800361b1103"),
}

// Native encoding: ansi
enum const(wchar)* STR_MYDOCS_CLSID = "{450D8FBA-AD25-11D0-98A8-0800361B1103}";

enum : GUID
{
    CATID_BrowsableShellExt = GUID("00021490-0000-0000-c000-000000000046"),
    CATID_BrowseInPlace     = GUID("00021491-0000-0000-c000-000000000046"),
}

enum : GUID
{
    CATID_DeskBand = GUID("00021492-0000-0000-c000-000000000046"),
    CATID_InfoBand = GUID("00021493-0000-0000-c000-000000000046"),
    CATID_CommBand = GUID("00021494-0000-0000-c000-000000000046"),
}

enum : GUID
{
    FMTID_Intshcut     = GUID("000214a0-0000-0000-c000-000000000046"),
    FMTID_InternetSite = GUID("000214a1-0000-0000-c000-000000000046"),
}

enum GUID CGID_Explorer = GUID("000214d0-0000-0000-c000-000000000046");

enum : GUID
{
    CGID_ShellDocView       = GUID("000214d1-0000-0000-c000-000000000046"),
    CGID_ShellServiceObject = GUID("000214d2-0000-0000-c000-000000000046"),
}

enum GUID CGID_ExplorerBarDoc = GUID("000214d3-0000-0000-c000-000000000046");
enum GUID CLSID_FolderShortcut = GUID("0afaced1-e828-11d1-9187-b532f1e9575d");
enum GUID CLSID_CFSIconOverlayManager = GUID("63b51f81-c868-11d0-999c-00c04fd655e1");
enum GUID CLSID_ShellThumbnailDiskCache = GUID("1ebdcf80-a200-11d0-a3a4-00c04fd706ec");
enum GUID SID_DefView = GUID("6d12fe80-7911-11cf-9534-0000c05bae0b");
enum GUID CGID_DefView = GUID("4af07f10-d231-11d0-b942-00a0c90312e1");
enum GUID CLSID_MenuBand = GUID("5b4dae26-b807-11d0-9815-00c04fd91972");
enum GUID VID_LargeIcons = GUID("0057d0e0-3573-11cf-ae69-08002b2e1262");
enum GUID VID_SmallIcons = GUID("089000c0-3573-11cf-ae69-08002b2e1262");

enum : GUID
{
    VID_List    = GUID("0e1fa5e0-3573-11cf-ae69-08002b2e1262"),
    VID_Details = GUID("137e7700-3573-11cf-ae69-08002b2e1262"),
}

enum : GUID
{
    VID_Tile    = GUID("65f125e5-7be1-4810-ba9d-d271c8432ce3"),
    VID_Content = GUID("30c2c434-0889-4c8d-985d-a9f71830b0a9"),
}

enum : GUID
{
    VID_Thumbnails = GUID("8bebb290-52d0-11d0-b7f4-00c04fd706ec"),
    VID_ThumbStrip = GUID("8eefa624-d1e9-445b-94b7-74fbce2ea11a"),
}

enum GUID SID_SInPlaceBrowser = GUID("1d2ae02b-3655-46cc-b63a-285988153bca");
enum GUID SID_SSearchBoxInfo = GUID("142daa61-516b-4713-b49c-fb985ef82998");
enum GUID SID_CommandsPropertyBag = GUID("6e043250-4416-485c-b143-e62a760d9fe5");
enum GUID CLSID_CURLSearchHook = GUID("cfbfae00-17a6-11d0-99cb-00c04fd64497");
enum GUID CLSID_AutoComplete = GUID("00bb2763-6a77-11d0-a535-00c04fd7d062");

enum : GUID
{
    CLSID_ACLHistory   = GUID("00bb2764-6a77-11d0-a535-00c04fd7d062"),
    CLSID_ACListISF    = GUID("03c036f1-a186-11d0-824a-00aa005b4383"),
    CLSID_ACLMRU       = GUID("6756a641-de71-11d0-831b-00aa005b4383"),
    CLSID_ACLMulti     = GUID("00bb2765-6a77-11d0-a535-00c04fd7d062"),
    CLSID_ACLCustomMRU = GUID("6935db93-21e8-4ccc-beb9-9fe3c77a297a"),
}

enum GUID CLSID_ProgressDialog = GUID("f8383852-fcd3-11d1-a6b9-006097df5bd4");
enum GUID SID_STopLevelBrowser = GUID("4c96be40-915c-11cf-99d3-00aa004ae837");
enum GUID CLSID_FileTypes = GUID("b091e540-83e3-11cf-a713-0020afd79762");
enum GUID CLSID_ActiveDesktop = GUID("75048700-ef1f-11d0-9888-006097deacf9");
enum GUID CLSID_QueryAssociations = GUID("a07034fd-6caa-4954-ac3f-97a27216f98a");
enum GUID CLSID_LinkColumnProvider = GUID("24f14f02-7b1c-11d1-838f-0000f80461cf");
enum GUID CGID_ShortCut = GUID("93a68750-951a-11d1-946f-000000000000");
enum GUID CLSID_InternetButtons = GUID("1e796980-9cc5-11d1-a83f-00c04fc99d61");
enum GUID CLSID_MSOButtons = GUID("178f34b8-a282-11d2-86c5-00c04f8eea99");
enum GUID CLSID_ToolbarExtButtons = GUID("2ce4b5d8-a28f-11d2-86c5-00c04f8eea99");
enum GUID CLSID_DarwinAppPublisher = GUID("cfccc7a0-a282-11d1-9082-006008059382");
enum GUID CLSID_DocHostUIHandler = GUID("7057e952-bd1b-11d1-8919-00c04fc2c836");
enum GUID PSGUID_SHELLDETAILS = GUID("28636aa6-953d-11d2-b5d6-00c04fd918d0");
enum GUID FMTID_ShellDetails = GUID("28636aa6-953d-11d2-b5d6-00c04fd918d0");
enum uint PID_FINDDATA = 0x00000000U;
enum uint PID_NETRESOURCE = 0x00000001U;
enum uint PID_DESCRIPTIONID = 0x00000002U;
enum uint PID_WHICHFOLDER = 0x00000003U;
enum uint PID_NETWORKLOCATION = 0x00000004U;
enum uint PID_COMPUTERNAME = 0x00000005U;
enum GUID FMTID_Storage = GUID("b725f130-47ef-101a-a5f1-02608c9eebac");
enum GUID PSGUID_IMAGEPROPERTIES = GUID("14b81da1-0135-4d31-96d9-6cbfc9671a99");
enum GUID FMTID_ImageProperties = GUID("14b81da1-0135-4d31-96d9-6cbfc9671a99");
enum GUID PSGUID_CUSTOMIMAGEPROPERTIES = GUID("7ecd8b0e-c136-4a9b-9411-4ebd6673ccc3");
enum GUID FMTID_CustomImageProperties = GUID("7ecd8b0e-c136-4a9b-9411-4ebd6673ccc3");
enum GUID PSGUID_LIBRARYPROPERTIES = GUID("5d76b67f-9b3d-44bb-b6ae-25da4f638a67");
enum GUID FMTID_LibraryProperties = GUID("5d76b67f-9b3d-44bb-b6ae-25da4f638a67");
enum GUID PSGUID_DISPLACED = GUID("9b174b33-40ff-11d2-a27e-00c04fc30871");
enum GUID FMTID_Displaced = GUID("9b174b33-40ff-11d2-a27e-00c04fc30871");

enum : uint
{
    PID_DISPLACED_FROM = 0x00000002U,
    PID_DISPLACED_DATE = 0x00000003U,
}

enum GUID PSGUID_BRIEFCASE = GUID("328d8b21-7729-4bfc-954c-902b329d56b0");
enum GUID FMTID_Briefcase = GUID("328d8b21-7729-4bfc-954c-902b329d56b0");
enum uint PID_SYNC_COPY_IN = 0x00000002U;
enum GUID PSGUID_MISC = GUID("9b174b34-40ff-11d2-a27e-00c04fc30871");
enum GUID FMTID_Misc = GUID("9b174b34-40ff-11d2-a27e-00c04fc30871");

enum : uint
{
    PID_MISC_STATUS      = 0x00000002U,
    PID_MISC_ACCESSCOUNT = 0x00000003U,
    PID_MISC_OWNER       = 0x00000004U,
}

enum uint PID_HTMLINFOTIPFILE = 0x00000005U;
enum uint PID_MISC_PICS = 0x00000006U;
enum GUID PSGUID_WEBVIEW = GUID("f2275480-f782-4291-bd94-f13693513aec");
enum GUID FMTID_WebView = GUID("f2275480-f782-4291-bd94-f13693513aec");
enum uint PID_DISPLAY_PROPERTIES = 0x00000000U;
enum uint PID_INTROTEXT = 0x00000001U;
enum GUID PSGUID_MUSIC = GUID("56a3372e-ce9c-11d2-9f0e-006097c686f6");
enum GUID FMTID_MUSIC = GUID("56a3372e-ce9c-11d2-9f0e-006097c686f6");

enum : uint
{
    PIDSI_ARTIST    = 0x00000002U,
    PIDSI_SONGTITLE = 0x00000003U,
}

enum : uint
{
    PIDSI_ALBUM   = 0x00000004U,
    PIDSI_YEAR    = 0x00000005U,
    PIDSI_COMMENT = 0x00000006U,
    PIDSI_TRACK   = 0x00000007U,
    PIDSI_GENRE   = 0x0000000bU,
    PIDSI_LYRICS  = 0x0000000cU,
}

enum GUID PSGUID_DRM = GUID("aeac19e4-89ae-4508-b9b7-bb867abee2ed");
enum GUID FMTID_DRM = GUID("aeac19e4-89ae-4508-b9b7-bb867abee2ed");

enum : uint
{
    PIDDRSI_PROTECTED   = 0x00000002U,
    PIDDRSI_DESCRIPTION = 0x00000003U,
    PIDDRSI_PLAYCOUNT   = 0x00000004U,
    PIDDRSI_PLAYSTARTS  = 0x00000005U,
    PIDDRSI_PLAYEXPIRES = 0x00000006U,
}

enum GUID PSGUID_VIDEO = GUID("64440491-4c8b-11d1-8b70-080036b11a03");
enum uint PIDVSI_STREAM_NAME = 0x00000002U;

enum : uint
{
    PIDVSI_FRAME_WIDTH  = 0x00000003U,
    PIDVSI_FRAME_HEIGHT = 0x00000004U,
}

enum : uint
{
    PIDVSI_TIMELENGTH  = 0x00000007U,
    PIDVSI_FRAME_COUNT = 0x00000005U,
    PIDVSI_FRAME_RATE  = 0x00000006U,
    PIDVSI_DATA_RATE   = 0x00000008U,
    PIDVSI_SAMPLE_SIZE = 0x00000009U,
}

enum uint PIDVSI_COMPRESSION = 0x0000000aU;
enum uint PIDVSI_STREAM_NUMBER = 0x0000000bU;
enum GUID PSGUID_AUDIO = GUID("64440490-4c8b-11d1-8b70-080036b11a03");

enum : uint
{
    PIDASI_FORMAT        = 0x00000002U,
    PIDASI_TIMELENGTH    = 0x00000003U,
    PIDASI_AVG_DATA_RATE = 0x00000004U,
}

enum : uint
{
    PIDASI_SAMPLE_RATE = 0x00000005U,
    PIDASI_SAMPLE_SIZE = 0x00000006U,
}

enum uint PIDASI_CHANNEL_COUNT = 0x00000007U;

enum : uint
{
    PIDASI_STREAM_NUMBER = 0x00000008U,
    PIDASI_STREAM_NAME   = 0x00000009U,
}

enum uint PIDASI_COMPRESSION = 0x0000000aU;
enum GUID PSGUID_CONTROLPANEL = GUID("305ca226-d286-468e-b848-2b2e8e697b74");
enum uint PID_CONTROLPANEL_CATEGORY = 0x00000002U;
enum GUID PSGUID_VOLUME = GUID("9b174b35-40ff-11d2-a27e-00c04fc30871");
enum GUID FMTID_Volume = GUID("9b174b35-40ff-11d2-a27e-00c04fc30871");

enum : uint
{
    PID_VOLUME_FREE       = 0x00000002U,
    PID_VOLUME_CAPACITY   = 0x00000003U,
    PID_VOLUME_FILESYSTEM = 0x00000004U,
}

enum GUID PSGUID_SHARE = GUID("d8c3986f-813b-449c-845d-87b95d674ade");
enum uint PID_SHARE_CSC_STATUS = 0x00000002U;
enum GUID PSGUID_LINK = GUID("b9b4b3fc-2b51-4a42-b5d8-324146afcf25");

enum : uint
{
    PID_LINK_TARGET      = 0x00000002U,
    PID_LINK_TARGET_TYPE = 0x00000003U,
}

enum GUID PSGUID_QUERY_D = GUID("49691c90-7e17-101a-a91c-08002b2ecda9");
enum GUID FMTID_Query = GUID("49691c90-7e17-101a-a91c-08002b2ecda9");
enum uint PID_QUERY_RANK = 0x00000002U;
enum GUID PSGUID_SUMMARYINFORMATION = GUID("f29f85e0-4ff9-1068-ab91-08002b27b3d9");
enum GUID PSGUID_DOCUMENTSUMMARYINFORMATION = GUID("d5cdd502-2e9c-101b-9397-08002b2cf9ae");
enum GUID PSGUID_MEDIAFILESUMMARYINFORMATION = GUID("64440492-4c8b-11d1-8b70-080036b11a03");
enum GUID PSGUID_IMAGESUMMARYINFORMATION = GUID("6444048f-4c8b-11d1-8b70-080036b11a03");
enum GUID CLSID_HWShellExecute = GUID("ffb8655f-81b9-4fce-b89c-9a6ba76d13e7");
enum GUID CLSID_DragDropHelper = GUID("4657278a-411b-11d2-839a-00c04fd918d0");
enum GUID CLSID_CAnchorBrowsePropertyPage = GUID("3050f3bb-98b5-11cf-bb82-00aa00bdce0b");
enum GUID CLSID_CImageBrowsePropertyPage = GUID("3050f3b3-98b5-11cf-bb82-00aa00bdce0b");
enum GUID CLSID_CDocBrowsePropertyPage = GUID("3050f3b4-98b5-11cf-bb82-00aa00bdce0b");
enum GUID SID_STopWindow = GUID("49e1b500-4636-11d3-97f7-00c04f45d0b3");
enum GUID SID_SGetViewFromViewDual = GUID("889a935d-971e-4b12-b90c-24dfc9e1e5e8");
enum GUID CLSID_FolderItemsMultiLevel = GUID("53c74826-ab99-4d33-aca4-3117f51d3788");
enum GUID CLSID_NewMenu = GUID("d969a300-e7ff-11d0-a93b-00a0c90f2719");

enum : GUID
{
    BHID_SFObject     = GUID("3981e224-f559-11d3-8e3a-00c04f6837d5"),
    BHID_SFUIObject   = GUID("3981e225-f559-11d3-8e3a-00c04f6837d5"),
    BHID_SFViewObject = GUID("3981e226-f559-11d3-8e3a-00c04f6837d5"),
}

enum : GUID
{
    BHID_Storage            = GUID("3981e227-f559-11d3-8e3a-00c04f6837d5"),
    BHID_Stream             = GUID("1cebb3ab-7c10-499a-a417-92ca16c4cb83"),
    BHID_RandomAccessStream = GUID("f16fc93b-77ae-4cfe-bda7-a866eea6878d"),
}

enum GUID BHID_LinkTargetItem = GUID("3981e228-f559-11d3-8e3a-00c04f6837d5");
enum GUID BHID_StorageEnum = GUID("4621a4e3-f0d6-4773-8a9c-46e77b174840");
enum GUID BHID_Transfer = GUID("d5e346a1-f753-4932-b403-4574800e2498");
enum GUID BHID_PropertyStore = GUID("0384e1a4-1523-439c-a4c8-ab911052f586");
enum GUID BHID_ThumbnailHandler = GUID("7b2e650a-8e20-4f4a-b09e-6597afc72fb0");
enum GUID BHID_EnumItems = GUID("94f60519-2850-4924-aa5a-d15e84868039");
enum GUID BHID_DataObject = GUID("b8c0bd9f-ed24-455c-83e6-d5390c4fe8c4");
enum GUID BHID_AssociationArray = GUID("bea9ef17-82f1-4f60-9284-4f8db75c3be9");

enum : GUID
{
    BHID_Filter            = GUID("38d08778-f557-4690-9ebf-ba54706ad8f7"),
    BHID_EnumAssocHandlers = GUID("b8ab0b9c-c2ec-4f7a-918d-314900e6280a"),
}

enum GUID BHID_StorageItem = GUID("404e2109-77d2-4699-a5a0-4fdf10db9837");
enum GUID BHID_FilePlaceholder = GUID("8677dceb-aae0-4005-8d3d-547fa852f825");
enum GUID CATID_FilePlaceholderMergeHandler = GUID("3e9c9a51-d4aa-4870-b47c-7424b491f1cc");
enum GUID SID_CtxQueryAssociations = GUID("faadfc40-b777-4b69-aa81-77035ef0e6e8");
enum GUID CLSID_QuickLinks = GUID("0e5cbf21-d15f-11d0-8301-00aa005b4383");

enum : GUID
{
    CLSID_ISFBand        = GUID("d82be2b0-5764-11d0-a96e-00c04fd705a2"),
    CLSID_ShellFldSetExt = GUID("6d5313c0-8c62-11d1-b2cd-006097df8c11"),
}

enum : GUID
{
    SID_SMenuBandChild          = GUID("ed9cc020-08b9-11d1-9823-00c04fd91972"),
    SID_SMenuBandParent         = GUID("8c278eec-3eab-11d1-8cb0-00c04fd918d0"),
    SID_SMenuPopup              = GUID("d1e7afeb-6a2e-11d0-8c78-00c04fd918b4"),
    SID_SMenuBandBottomSelected = GUID("165ebaf4-6d51-11d2-83ad-00c04fd918d0"),
    SID_SMenuBandBottom         = GUID("743ca664-0deb-11d1-9825-00c04fd91972"),
}

enum GUID SID_MenuShellFolder = GUID("a6c17eb4-2d65-11d2-838f-00c04fd918d0");

enum : GUID
{
    SID_SMenuBandContextMenuModifier = GUID("39545874-7162-465e-b783-2aa1874fef81"),
    SID_SMenuBandBKContextMenu       = GUID("164bbd86-1d0d-4de0-9a3b-d9729647c2b8"),
}

enum GUID CGID_MENUDESKBAR = GUID("5c9f0a12-959e-11d0-a3a4-00a0c9082636");
enum GUID SID_SMenuBandTop = GUID("9493a810-ec38-11d0-bc46-00aa006ce2f5");

enum : GUID
{
    CLSID_MenuToolbarBase = GUID("40b96610-b522-11d1-b3b4-00aa006efde7"),
    CLSID_MenuBandSite    = GUID("e13ef4e4-d2f2-11d0-9816-00c04fd91972"),
}

enum GUID SID_SCommDlgBrowser = GUID("80f30233-b7df-11d2-a33b-006097df5bd4");

enum : GUID
{
    CPFG_LOGON_USERNAME = GUID("da15bbe8-954d-4fd3-b0f4-1fb5b90b174b"),
    CPFG_LOGON_PASSWORD = GUID("60624cfa-a477-47b1-8a8e-3a4a19981827"),
}

enum : GUID
{
    CPFG_SMARTCARD_USERNAME = GUID("3e1ecf69-568c-4d96-9d59-46444174e2d6"),
    CPFG_SMARTCARD_PIN      = GUID("4fe5263b-9181-46c1-b0a4-9dedd4db7dea"),
}

enum : GUID
{
    CPFG_CREDENTIAL_PROVIDER_LOGO  = GUID("2d837775-f6cd-464e-a745-482fd0b47493"),
    CPFG_CREDENTIAL_PROVIDER_LABEL = GUID("286bbff3-bad4-438f-b007-79b7267c3d48"),
}

enum GUID CPFG_STANDALONE_SUBMIT_BUTTON = GUID("0b7b0ad8-cc36-4d59-802b-82f714fa7022");
enum GUID CPFG_STYLE_LINK_AS_BUTTON = GUID("088fa508-94a6-4430-a4cb-6fc6e3c0b9e2");

enum : GUID
{
    FOLDERTYPEID_Invalid                  = GUID("57807898-8c4f-4462-bb63-71042380b109"),
    FOLDERTYPEID_Generic                  = GUID("5c4f28b5-f869-4e84-8e60-f11db97c5cc7"),
    FOLDERTYPEID_GenericSearchResults     = GUID("7fde1a1e-8b31-49a5-93b8-6be14cfa4943"),
    FOLDERTYPEID_GenericLibrary           = GUID("5f4eab9a-6833-4f61-899d-31cf46979d49"),
    FOLDERTYPEID_Documents                = GUID("7d49d726-3c21-4f05-99aa-fdc2c9474656"),
    FOLDERTYPEID_Pictures                 = GUID("b3690e58-e961-423b-b687-386ebfd83239"),
    FOLDERTYPEID_Music                    = GUID("94d6ddcc-4a68-4175-a374-bd584a510b78"),
    FOLDERTYPEID_Videos                   = GUID("5fa96407-7e77-483c-ac93-691d05850de8"),
    FOLDERTYPEID_Downloads                = GUID("885a186e-a440-4ada-812b-db871b942259"),
    FOLDERTYPEID_UserFiles                = GUID("cd0fc69b-71e2-46e5-9690-5bcd9f57aab3"),
    FOLDERTYPEID_UsersLibraries           = GUID("c4d98f09-6124-4fe0-9942-826416082da9"),
    FOLDERTYPEID_OtherUsers               = GUID("b337fd00-9dd5-4635-a6d4-da33fd102b7a"),
    FOLDERTYPEID_PublishedItems           = GUID("7f2f5b96-ff74-41da-afd8-1c78a5f3aea2"),
    FOLDERTYPEID_Communications           = GUID("91475fe5-586b-4eba-8d75-d17434b8cdf6"),
    FOLDERTYPEID_Contacts                 = GUID("de2b70ec-9bf7-4a93-bd3d-243f7881d492"),
    FOLDERTYPEID_StartMenu                = GUID("ef87b4cb-f2ce-4785-8658-4ca6c63e38c6"),
    FOLDERTYPEID_RecordedTV               = GUID("5557a28f-5da6-4f83-8809-c2c98a11a6fa"),
    FOLDERTYPEID_SavedGames               = GUID("d0363307-28cb-4106-9f23-2956e3e5e0e7"),
    FOLDERTYPEID_OpenSearch               = GUID("8faf9629-1980-46ff-8023-9dceab9c3ee3"),
    FOLDERTYPEID_SearchConnector          = GUID("982725ee-6f47-479e-b447-812bfa7d2e8f"),
    FOLDERTYPEID_AccountPictures          = GUID("db2a5d8f-06e6-4007-aba6-af877d526ea6"),
    FOLDERTYPEID_Games                    = GUID("b689b0d0-76d3-4cbb-87f7-585d0e0ce070"),
    FOLDERTYPEID_ControlPanelCategory     = GUID("de4f0660-fa10-4b8f-a494-068b20b22307"),
    FOLDERTYPEID_ControlPanelClassic      = GUID("0c3794f3-b545-43aa-a329-c37430c58d2a"),
    FOLDERTYPEID_Printers                 = GUID("2c7bbec6-c844-4a0a-91fa-cef6f59cfda1"),
    FOLDERTYPEID_RecycleBin               = GUID("d6d9e004-cd87-442b-9d57-5e0aeb4f6f72"),
    FOLDERTYPEID_SoftwareExplorer         = GUID("d674391b-52d9-4e07-834e-67c98610f39d"),
    FOLDERTYPEID_CompressedFolder         = GUID("80213e82-bcfd-4c4f-8817-bb27601267a9"),
    FOLDERTYPEID_NetworkExplorer          = GUID("25cc242b-9a7c-4f51-80e0-7a2928febe42"),
    FOLDERTYPEID_Searches                 = GUID("0b0ba2e3-405f-415e-a6ee-cad625207853"),
    FOLDERTYPEID_SearchHome               = GUID("834d8a44-0974-4ed6-866e-f203d80b3810"),
    FOLDERTYPEID_StorageProviderGeneric   = GUID("4f01ebc5-2385-41f2-a28e-2c5c91fb56e0"),
    FOLDERTYPEID_StorageProviderDocuments = GUID("dd61bd66-70e8-48dd-9655-65c5e1aac2d1"),
    FOLDERTYPEID_StorageProviderPictures  = GUID("71d642a9-f2b1-42cd-ad92-eb9300c7cc0a"),
    FOLDERTYPEID_StorageProviderMusic     = GUID("672ecd7e-af04-4399-875c-0290845b6247"),
    FOLDERTYPEID_StorageProviderVideos    = GUID("51294da1-d7b1-485b-9e9a-17cffe33e187"),
}

enum GUID FOLDERTYPEID_VersionControl = GUID("69f1e26b-ec64-4280-bc83-f1eb887ec35a");

enum : GUID
{
    SYNCMGR_OBJECTID_Icon                  = GUID("6dbc85c3-5d07-4c72-a777-7fec78072c06"),
    SYNCMGR_OBJECTID_EventStore            = GUID("4bef34b9-a786-4075-ba88-0c2b9d89a98f"),
    SYNCMGR_OBJECTID_ConflictStore         = GUID("d78181f4-2389-47e4-a960-60bcc2ed930b"),
    SYNCMGR_OBJECTID_BrowseContent         = GUID("57cbb584-e9b4-47ae-a120-c4df3335dee2"),
    SYNCMGR_OBJECTID_ShowSchedule          = GUID("edc6f3e3-8441-4109-adf3-6c1ca0b7de47"),
    SYNCMGR_OBJECTID_QueryBeforeActivate   = GUID("d882d80b-e7aa-49ed-86b7-e6e1f714cdfe"),
    SYNCMGR_OBJECTID_QueryBeforeDeactivate = GUID("a0efc282-60e0-460e-9374-ea88513cfc80"),
    SYNCMGR_OBJECTID_QueryBeforeEnable     = GUID("04cbf7f0-5beb-4de1-bc90-908345c480f6"),
    SYNCMGR_OBJECTID_QueryBeforeDisable    = GUID("bb5f64aa-f004-4eb5-8e4d-26751966344c"),
    SYNCMGR_OBJECTID_QueryBeforeDelete     = GUID("f76c3397-afb3-45d7-a59f-5a49e905437e"),
    SYNCMGR_OBJECTID_EventLinkClick        = GUID("2203bdc1-1af1-4082-8c30-28399f41384c"),
}

enum GUID EP_NavPane = GUID("cb316b22-25f7-42b8-8a09-540d23a43c2f");

enum : GUID
{
    EP_Commands          = GUID("d9745868-ca5f-4a76-91cd-f5a129fbb076"),
    EP_Commands_Organize = GUID("72e81700-e3ec-4660-bf24-3c3b7b648806"),
    EP_Commands_View     = GUID("21f7c32d-eeaa-439b-bb51-37b96fd6a943"),
}

enum GUID EP_DetailsPane = GUID("43abf98b-89b8-472d-b9ce-e69b8229f019");
enum GUID EP_PreviewPane = GUID("893c63d1-45c8-4d17-be19-223be71be365");
enum GUID EP_QueryPane = GUID("65bcde4f-4f07-4f27-83a7-1afca4df7ddd");
enum GUID EP_AdvQueryPane = GUID("b4e9db8b-34ba-4c39-b5cc-16a1bd2c411c");
enum GUID EP_StatusBar = GUID("65fe56ce-5cfe-4bc4-ad8a-7ae3fe7e8f7c");
enum GUID EP_Ribbon = GUID("d27524a8-c9f2-4834-a106-df8889fd4f37");

enum : GUID
{
    CATID_LocationFactory  = GUID("965c4d51-8b76-4e57-80b7-564d2ea4b55e"),
    CATID_LocationProvider = GUID("1b3ca474-2614-414b-b813-1aceca3e3dd8"),
}

enum GUID ItemCount_Property_GUID = GUID("abbf5c45-5ccc-47b7-bb4e-87cb87bbd162");
enum GUID SelectedItemCount_Property_GUID = GUID("8fe316d2-0e52-460a-9c1e-48f273d470a3");
enum GUID ItemIndex_Property_GUID = GUID("92a053da-2969-4021-bf27-514cfc2e4a69");
enum GUID CATID_SearchableApplication = GUID("366c292a-d9b3-4dbf-bb70-e62ec3d0bbbf");

enum : uint
{
    IDD_WIZEXTN_FIRST = 0x00005000U,
    IDD_WIZEXTN_LAST  = 0x00005100U,
}

enum : uint
{
    SHPWHF_NORECOMPRESS     = 0x00000001U,
    SHPWHF_NONETPLACECREATE = 0x00000002U,
}

enum uint SHPWHF_NOFILESELECTOR = 0x00000004U;

enum : uint
{
    SHPWHF_USEMRU      = 0x00000008U,
    SHPWHF_ANYLOCATION = 0x00000100U,
}

enum uint SHPWHF_VALIDATEVIAWEBFOLDERS = 0x00010000U;
enum uint ACDD_VISIBLE = 0x00000001U;
enum const(wchar)* PROPSTR_EXTENSIONCOMPLETIONSTATE = "ExtensionCompletionState";
enum GUID SID_SCommandBarState = GUID("b99eaa5c-3850-4400-bc33-2ce534048bf8");
enum int NSTCDHPOS_ONTOP = 0xffffffff;

enum : uint
{
    FVSIF_RECT      = 0x00000001U,
    FVSIF_PINNED    = 0x00000002U,
    FVSIF_NEWFAILED = 0x08000000U,
    FVSIF_NEWFILE   = 0x80000000U,
    FVSIF_CANVIEWIT = 0x40000000U,
}

enum : uint
{
    FCIDM_TOOLBAR = 0x0000a000U,
    FCIDM_STATUS  = 0x0000a001U,
}

enum uint IDC_OFFLINE_HAND = 0x00000067U;

enum : uint
{
    IDC_PANTOOL_HAND_OPEN   = 0x00000068U,
    IDC_PANTOOL_HAND_CLOSED = 0x00000069U,
}

enum : uint
{
    PANE_NONE       = 0xffffffffU,
    PANE_ZONE       = 0x00000001U,
    PANE_OFFLINE    = 0x00000002U,
    PANE_PRINTER    = 0x00000003U,
    PANE_SSL        = 0x00000004U,
    PANE_NAVIGATION = 0x00000005U,
}

enum : uint
{
    PANE_PROGRESS = 0x00000006U,
    PANE_PRIVACY  = 0x00000007U,
}

enum : uint
{
    DWFRF_NORMAL           = 0x00000000U,
    DWFRF_DELETECONFIGDATA = 0x00000001U,
}

enum : uint
{
    DWFAF_HIDDEN   = 0x00000001U,
    DWFAF_GROUP1   = 0x00000002U,
    DWFAF_GROUP2   = 0x00000004U,
    DWFAF_AUTOHIDE = 0x00000010U,
}

enum : uint
{
    SHIMSTCAPFLAG_LOCKABLE  = 0x00000001U,
    SHIMSTCAPFLAG_PURGEABLE = 0x00000002U,
}

enum : uint
{
    ISFB_MASK_STATE       = 0x00000001U,
    ISFB_MASK_BKCOLOR     = 0x00000002U,
    ISFB_MASK_VIEWMODE    = 0x00000004U,
    ISFB_MASK_SHELLFOLDER = 0x00000008U,
    ISFB_MASK_IDLIST      = 0x00000010U,
    ISFB_MASK_COLORS      = 0x00000020U,
}

enum : uint
{
    ISFB_STATE_DEFAULT     = 0x00000000U,
    ISFB_STATE_DEBOSSED    = 0x00000001U,
    ISFB_STATE_ALLOWRENAME = 0x00000002U,
    ISFB_STATE_NOSHOWTEXT  = 0x00000004U,
    ISFB_STATE_CHANNELBAR  = 0x00000010U,
    ISFB_STATE_QLINKSMODE  = 0x00000020U,
    ISFB_STATE_FULLOPEN    = 0x00000040U,
    ISFB_STATE_NONAMESORT  = 0x00000080U,
    ISFB_STATE_BTNMINSIZE  = 0x00000100U,
}

enum : uint
{
    ISFBVIEWMODE_SMALLICONS = 0x00000001U,
    ISFBVIEWMODE_LARGEICONS = 0x00000002U,
    ISFBVIEWMODE_LOGOS      = 0x00000003U,
}

enum : uint
{
    DBC_GS_IDEAL    = 0x00000000U,
    DBC_GS_SIZEDOWN = 0x00000001U,
}

enum : uint
{
    DBC_HIDE        = 0x00000000U,
    DBC_SHOW        = 0x00000001U,
    DBC_SHOWOBSCURE = 0x00000002U,
}

enum : uint
{
    SSM_CLEAR   = 0x00000000U,
    SSM_SET     = 0x00000001U,
    SSM_REFRESH = 0x00000002U,
}

enum uint SSM_UPDATE = 0x00000004U;

enum : uint
{
    SCHEME_DISPLAY  = 0x00000001U,
    SCHEME_EDIT     = 0x00000002U,
    SCHEME_LOCAL    = 0x00000004U,
    SCHEME_GLOBAL   = 0x00000008U,
    SCHEME_REFRESH  = 0x00000010U,
    SCHEME_UPDATE   = 0x00000020U,
    SCHEME_DONOTUSE = 0x00000040U,
    SCHEME_CREATE   = 0x00000080U,
}

enum uint GADOF_DIRTY = 0x00000001U;
enum uint SHCDF_UPDATEITEM = 0x00000001U;

enum : uint
{
    PPCF_ADDQUOTES    = 0x00000001U,
    PPCF_ADDARGUMENTS = 0x00000003U,
}

enum uint PPCF_NODIRECTORIES = 0x00000010U;
enum uint PPCF_FORCEQUALIFY = 0x00000040U;
enum uint PPCF_LONGESTPOSSIBLE = 0x00000080U;

enum : uint
{
    OPENPROPS_NONE       = 0x00000000U,
    OPENPROPS_INHIBITPIF = 0x00008000U,
}

enum uint GETPROPS_NONE = 0x00000000U;
enum uint SETPROPS_NONE = 0x00000000U;

enum : uint
{
    CLOSEPROPS_NONE    = 0x00000000U,
    CLOSEPROPS_DISCARD = 0x00000001U,
}

enum : uint
{
    TBIF_APPEND      = 0x00000000U,
    TBIF_PREPEND     = 0x00000001U,
    TBIF_REPLACE     = 0x00000002U,
    TBIF_DEFAULT     = 0x00000000U,
    TBIF_INTERNETBAR = 0x00010000U,
}

enum uint TBIF_STANDARDTOOLBAR = 0x00020000U;
enum uint TBIF_NOTOOLBAR = 0x00030000U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/sfvm-rearrange
enum uint SFVM_REARRANGE = 0x00000001U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/sfvm-addobject
enum uint SFVM_ADDOBJECT = 0x00000003U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/sfvm-removeobject
enum uint SFVM_REMOVEOBJECT = 0x00000006U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/sfvm-updateobject
enum uint SFVM_UPDATEOBJECT = 0x00000007U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/sfvm-getselectedobjects
enum uint SFVM_GETSELECTEDOBJECTS = 0x00000009U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/sfvm-setitempos
    SFVM_SETITEMPOS   = 0x0000000eU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/sfvm-setclipboard
    SFVM_SETCLIPBOARD = 0x00000010U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/sfvm-setpoints
    SFVM_SETPOINTS    = 0x00000017U,
}

enum uint GIL_OPENICON = 0x00000001U;
enum uint GIL_FORSHELL = 0x00000002U;

enum : uint
{
    GIL_ASYNC       = 0x00000020U,
    GIL_DEFAULTICON = 0x00000040U,
}

enum uint GIL_FORSHORTCUT = 0x00000080U;
enum uint GIL_CHECKSHIELD = 0x00000200U;
enum uint GIL_SIMULATEDOC = 0x00000001U;

enum : uint
{
    GIL_PERINSTANCE = 0x00000002U,
    GIL_PERCLASS    = 0x00000004U,
}

enum uint GIL_NOTFILENAME = 0x00000008U;
enum uint GIL_DONTCACHE = 0x00000010U;
enum uint GIL_SHIELD = 0x00000200U;
enum uint GIL_FORCENOSHIELD = 0x00000400U;
enum uint SIOM_OVERLAYINDEX = 0x00000001U;
enum uint SIOM_ICONINDEX = 0x00000002U;

enum : uint
{
    SIOM_RESERVED_SHARED   = 0x00000000U,
    SIOM_RESERVED_LINK     = 0x00000001U,
    SIOM_RESERVED_SLOWFILE = 0x00000002U,
    SIOM_RESERVED_DEFAULT  = 0x00000003U,
}

enum uint OI_DEFAULT = 0x00000000U;
enum uint OI_ASYNC = 0xffffeeeeU;

enum : uint
{
    IDO_SHGIOI_SHARE = 0x0fffffffU,
    IDO_SHGIOI_LINK  = 0x0ffffffeU,
}

enum : ulong
{
    IDO_SHGIOI_SLOWFILE = 0x00000000fffffffdUL,
    IDO_SHGIOI_DEFAULT  = 0x00000000fffffffcUL,
}

enum uint NT_CONSOLE_PROPS_SIG = 0xa0000002U;
enum uint NT_FE_CONSOLE_PROPS_SIG = 0xa0000004U;
enum uint EXP_DARWIN_ID_SIG = 0xa0000006U;
enum uint EXP_SPECIAL_FOLDER_SIG = 0xa0000005U;

enum : uint
{
    EXP_SZ_LINK_SIG = 0xa0000001U,
    EXP_SZ_ICON_SIG = 0xa0000007U,
}

enum uint EXP_PROPERTYSTORAGE_SIG = 0xa0000009U;

enum : uint
{
    FCIDM_SHVIEWFIRST = 0x00000000U,
    FCIDM_SHVIEWLAST  = 0x00007fffU,
}

enum : uint
{
    FCIDM_BROWSERFIRST = 0x0000a000U,
    FCIDM_BROWSERLAST  = 0x0000bf00U,
}

enum : uint
{
    FCIDM_GLOBALFIRST = 0x00008000U,
    FCIDM_GLOBALLAST  = 0x00009fffU,
}

enum : uint
{
    FCIDM_MENU_FILE             = 0x00008000U,
    FCIDM_MENU_EDIT             = 0x00008040U,
    FCIDM_MENU_VIEW             = 0x00008080U,
    FCIDM_MENU_VIEW_SEP_OPTIONS = 0x00008081U,
    FCIDM_MENU_TOOLS            = 0x000080c0U,
    FCIDM_MENU_TOOLS_SEP_GOTO   = 0x000080c1U,
    FCIDM_MENU_HELP             = 0x00008100U,
    FCIDM_MENU_FIND             = 0x00008140U,
    FCIDM_MENU_EXPLORE          = 0x00008150U,
    FCIDM_MENU_FAVORITES        = 0x00008170U,
}

enum : uint
{
    OFASI_EDIT        = 0x00000001U,
    OFASI_OPENDESKTOP = 0x00000002U,
}

enum : uint
{
    CSIDL_DESKTOP   = 0x00000000U,
    CSIDL_INTERNET  = 0x00000001U,
    CSIDL_PROGRAMS  = 0x00000002U,
    CSIDL_CONTROLS  = 0x00000003U,
    CSIDL_PRINTERS  = 0x00000004U,
    CSIDL_PERSONAL  = 0x00000005U,
    CSIDL_FAVORITES = 0x00000006U,
}

enum : uint
{
    CSIDL_STARTUP   = 0x00000007U,
    CSIDL_RECENT    = 0x00000008U,
    CSIDL_SENDTO    = 0x00000009U,
    CSIDL_BITBUCKET = 0x0000000aU,
}

enum uint CSIDL_STARTMENU = 0x0000000bU;

enum : uint
{
    CSIDL_MYDOCUMENTS      = 0x00000005U,
    CSIDL_MYMUSIC          = 0x0000000dU,
    CSIDL_MYVIDEO          = 0x0000000eU,
    CSIDL_DESKTOPDIRECTORY = 0x00000010U,
}

enum : uint
{
    CSIDL_DRIVES    = 0x00000011U,
    CSIDL_NETWORK   = 0x00000012U,
    CSIDL_NETHOOD   = 0x00000013U,
    CSIDL_FONTS     = 0x00000014U,
    CSIDL_TEMPLATES = 0x00000015U,
}

enum : uint
{
    CSIDL_COMMON_STARTMENU        = 0x00000016U,
    CSIDL_COMMON_PROGRAMS         = 0x00000017U,
    CSIDL_COMMON_STARTUP          = 0x00000018U,
    CSIDL_COMMON_DESKTOPDIRECTORY = 0x00000019U,
}

enum : uint
{
    CSIDL_APPDATA   = 0x0000001aU,
    CSIDL_PRINTHOOD = 0x0000001bU,
}

enum uint CSIDL_LOCAL_APPDATA = 0x0000001cU;
enum uint CSIDL_ALTSTARTUP = 0x0000001dU;

enum : uint
{
    CSIDL_COMMON_ALTSTARTUP = 0x0000001eU,
    CSIDL_COMMON_FAVORITES  = 0x0000001fU,
}

enum uint CSIDL_INTERNET_CACHE = 0x00000020U;

enum : uint
{
    CSIDL_COOKIES        = 0x00000021U,
    CSIDL_HISTORY        = 0x00000022U,
    CSIDL_COMMON_APPDATA = 0x00000023U,
}

enum : uint
{
    CSIDL_WINDOWS       = 0x00000024U,
    CSIDL_SYSTEM        = 0x00000025U,
    CSIDL_PROGRAM_FILES = 0x00000026U,
}

enum uint CSIDL_MYPICTURES = 0x00000027U;

enum : uint
{
    CSIDL_PROFILE   = 0x00000028U,
    CSIDL_SYSTEMX86 = 0x00000029U,
}

enum : uint
{
    CSIDL_PROGRAM_FILESX86        = 0x0000002aU,
    CSIDL_PROGRAM_FILES_COMMON    = 0x0000002bU,
    CSIDL_PROGRAM_FILES_COMMONX86 = 0x0000002cU,
}

enum : uint
{
    CSIDL_COMMON_TEMPLATES  = 0x0000002dU,
    CSIDL_COMMON_DOCUMENTS  = 0x0000002eU,
    CSIDL_COMMON_ADMINTOOLS = 0x0000002fU,
}

enum uint CSIDL_ADMINTOOLS = 0x00000030U;

enum : uint
{
    CSIDL_CONNECTIONS     = 0x00000031U,
    CSIDL_COMMON_MUSIC    = 0x00000035U,
    CSIDL_COMMON_PICTURES = 0x00000036U,
    CSIDL_COMMON_VIDEO    = 0x00000037U,
}

enum : uint
{
    CSIDL_RESOURCES           = 0x00000038U,
    CSIDL_RESOURCES_LOCALIZED = 0x00000039U,
}

enum uint CSIDL_COMMON_OEM_LINKS = 0x0000003aU;

enum : uint
{
    CSIDL_CDBURN_AREA     = 0x0000003bU,
    CSIDL_COMPUTERSNEARME = 0x0000003dU,
}

enum : uint
{
    CSIDL_FLAG_CREATE        = 0x00008000U,
    CSIDL_FLAG_DONT_VERIFY   = 0x00004000U,
    CSIDL_FLAG_DONT_UNEXPAND = 0x00002000U,
    CSIDL_FLAG_NO_ALIAS      = 0x00001000U,
    CSIDL_FLAG_PER_USER_INIT = 0x00000800U,
    CSIDL_FLAG_MASK          = 0x0000ff00U,
}

enum : uint
{
    FCS_READ       = 0x00000001U,
    FCS_FORCEWRITE = 0x00000002U,
}

enum uint FCS_FLAG_DRAGDROP = 0x00000002U;

enum : uint
{
    FCSM_VIEWID          = 0x00000001U,
    FCSM_WEBVIEWTEMPLATE = 0x00000002U,
}

enum : uint
{
    FCSM_INFOTIP  = 0x00000004U,
    FCSM_CLSID    = 0x00000008U,
    FCSM_ICONFILE = 0x00000010U,
}

enum : uint
{
    FCSM_LOGO  = 0x00000020U,
    FCSM_FLAGS = 0x00000040U,
}

enum uint BIF_RETURNONLYFSDIRS = 0x00000001U;
enum uint BIF_DONTGOBELOWDOMAIN = 0x00000002U;
enum uint BIF_STATUSTEXT = 0x00000004U;
enum uint BIF_RETURNFSANCESTORS = 0x00000008U;
enum uint BIF_EDITBOX = 0x00000010U;
enum uint BIF_VALIDATE = 0x00000020U;
enum uint BIF_NEWDIALOGSTYLE = 0x00000040U;
enum uint BIF_BROWSEINCLUDEURLS = 0x00000080U;
enum uint BIF_UAHINT = 0x00000100U;
enum uint BIF_NONEWFOLDERBUTTON = 0x00000200U;
enum uint BIF_NOTRANSLATETARGETS = 0x00000400U;

enum : uint
{
    BIF_BROWSEFORCOMPUTER  = 0x00001000U,
    BIF_BROWSEFORPRINTER   = 0x00002000U,
    BIF_BROWSEINCLUDEFILES = 0x00004000U,
}

enum uint BIF_SHAREABLE = 0x00008000U;
enum uint BIF_BROWSEFILEJUNCTIONS = 0x00010000U;
enum uint BFFM_INITIALIZED = 0x00000001U;
enum uint BFFM_SELCHANGED = 0x00000002U;

enum : uint
{
    BFFM_VALIDATEFAILEDA = 0x00000003U,
    BFFM_VALIDATEFAILEDW = 0x00000004U,
}

enum uint BFFM_IUNKNOWN = 0x00000005U;
enum uint BFFM_SETSTATUSTEXTA = 0x00000464U;
enum uint BFFM_ENABLEOK = 0x00000465U;

enum : uint
{
    BFFM_SETSELECTIONA  = 0x00000466U,
    BFFM_SETSELECTIONW  = 0x00000467U,
    BFFM_SETSTATUSTEXTW = 0x00000468U,
    BFFM_SETOKTEXT      = 0x00000469U,
    BFFM_SETEXPANDED    = 0x0000046aU,
    BFFM_SETSTATUSTEXT  = 0x00000468U,
    BFFM_SETSELECTION   = 0x00000467U,
}

enum uint BFFM_VALIDATEFAILED = 0x00000004U;
enum int CMDID_INTSHORTCUTCREATE = 0x00000001;
enum const(wchar)* STR_PARSE_WITH_PROPERTIES = "ParseWithProperties";
enum const(wchar)* STR_PARSE_PARTIAL_IDLIST = "ParseOriginalItem";

enum : uint
{
    PROGDLG_NORMAL        = 0x00000000U,
    PROGDLG_MODAL         = 0x00000001U,
    PROGDLG_AUTOTIME      = 0x00000002U,
    PROGDLG_NOTIME        = 0x00000004U,
    PROGDLG_NOMINIMIZE    = 0x00000008U,
    PROGDLG_NOPROGRESSBAR = 0x00000010U,
}

enum uint PROGDLG_MARQUEEPROGRESS = 0x00000020U;
enum uint PROGDLG_NOCANCEL = 0x00000040U;

enum : uint
{
    PDTIMER_RESET  = 0x00000001U,
    PDTIMER_PAUSE  = 0x00000002U,
    PDTIMER_RESUME = 0x00000003U,
}

enum uint COMPONENT_TOP = 0x3fffffffU;

enum : uint
{
    COMP_TYPE_HTMLDOC = 0x00000000U,
    COMP_TYPE_PICTURE = 0x00000001U,
    COMP_TYPE_WEBSITE = 0x00000002U,
    COMP_TYPE_CONTROL = 0x00000003U,
    COMP_TYPE_CFHTML  = 0x00000004U,
    COMP_TYPE_MAX     = 0x00000004U,
}

enum uint IS_NORMAL = 0x00000001U;
enum uint IS_FULLSCREEN = 0x00000002U;
enum uint IS_SPLIT = 0x00000004U;

enum : uint
{
    AD_APPLY_SAVE             = 0x00000001U,
    AD_APPLY_HTMLGEN          = 0x00000002U,
    AD_APPLY_REFRESH          = 0x00000004U,
    AD_APPLY_FORCE            = 0x00000008U,
    AD_APPLY_BUFFERED_REFRESH = 0x00000010U,
}

enum uint AD_APPLY_DYNAMICREFRESH = 0x00000020U;

enum : uint
{
    AD_GETWP_BMP          = 0x00000000U,
    AD_GETWP_IMAGE        = 0x00000001U,
    AD_GETWP_LAST_APPLIED = 0x00000002U,
}

enum : uint
{
    WPSTYLE_CENTER     = 0x00000000U,
    WPSTYLE_TILE       = 0x00000001U,
    WPSTYLE_STRETCH    = 0x00000002U,
    WPSTYLE_KEEPASPECT = 0x00000003U,
    WPSTYLE_CROPTOFIT  = 0x00000004U,
    WPSTYLE_SPAN       = 0x00000005U,
    WPSTYLE_MAX        = 0x00000006U,
}

enum : uint
{
    COMP_ELEM_TYPE          = 0x00000001U,
    COMP_ELEM_CHECKED       = 0x00000002U,
    COMP_ELEM_DIRTY         = 0x00000004U,
    COMP_ELEM_NOSCROLL      = 0x00000008U,
    COMP_ELEM_POS_LEFT      = 0x00000010U,
    COMP_ELEM_POS_TOP       = 0x00000020U,
    COMP_ELEM_SIZE_WIDTH    = 0x00000040U,
    COMP_ELEM_SIZE_HEIGHT   = 0x00000080U,
    COMP_ELEM_POS_ZINDEX    = 0x00000100U,
    COMP_ELEM_SOURCE        = 0x00000200U,
    COMP_ELEM_FRIENDLYNAME  = 0x00000400U,
    COMP_ELEM_SUBSCRIBEDURL = 0x00000800U,
    COMP_ELEM_ORIGINAL_CSI  = 0x00001000U,
    COMP_ELEM_RESTORED_CSI  = 0x00002000U,
    COMP_ELEM_CURITEMSTATE  = 0x00004000U,
}

enum uint ADDURL_SILENT = 0x00000001U;

enum : uint
{
    COMPONENT_DEFAULT_LEFT = 0x0000ffffU,
    COMPONENT_DEFAULT_TOP  = 0x0000ffffU,
}

enum : uint
{
    MAX_COLUMN_NAME_LEN = 0x00000050U,
    MAX_COLUMN_DESC_LEN = 0x00000080U,
}

enum : const(wchar)*
{
    CFSTR_SHELLIDLIST       = "Shell IDList Array",
    CFSTR_SHELLIDLISTOFFSET = "Shell Object Offsets",
}

enum const(wchar)* CFSTR_NETRESOURCES = "Net Resource";

enum : const(wchar)*
{
    CFSTR_FILEDESCRIPTORA = "FileGroupDescriptor",
    CFSTR_FILEDESCRIPTORW = "FileGroupDescriptorW",
    CFSTR_FILECONTENTS    = "FileContents",
    CFSTR_FILENAMEA       = "FileName",
    CFSTR_FILENAMEW       = "FileNameW",
}

enum const(wchar)* CFSTR_PRINTERGROUP = "PrinterFriendlyName";

enum : const(wchar)*
{
    CFSTR_FILENAMEMAPA = "FileNameMap",
    CFSTR_FILENAMEMAPW = "FileNameMapW",
}

enum : const(wchar)*
{
    CFSTR_SHELLURL            = "UniformResourceLocator",
    CFSTR_INETURLA            = "UniformResourceLocator",
    CFSTR_INETURLW            = "UniformResourceLocatorW",
    CFSTR_PREFERREDDROPEFFECT = "Preferred DropEffect",
}

enum const(wchar)* CFSTR_PERFORMEDDROPEFFECT = "Performed DropEffect";
enum const(wchar)* CFSTR_PASTESUCCEEDED = "Paste Succeeded";
enum const(wchar)* CFSTR_INDRAGLOOP = "InShellDragLoop";
enum const(wchar)* CFSTR_MOUNTEDVOLUME = "MountedVolume";
enum const(wchar)* CFSTR_PERSISTEDDATAOBJECT = "PersistedDataObject";
enum const(wchar)* CFSTR_TARGETCLSID = "TargetCLSID";
enum const(wchar)* CFSTR_LOGICALPERFORMEDDROPEFFECT = "Logical Performed DropEffect";
enum const(wchar)* CFSTR_AUTOPLAY_SHELLIDLISTS = "Autoplay Enumerated IDList Array";
enum const(wchar)* CFSTR_UNTRUSTEDDRAGDROP = "UntrustedDragDrop";
enum const(wchar)* CFSTR_FILE_ATTRIBUTES_ARRAY = "File Attributes Array";
enum const(wchar)* CFSTR_INVOKECOMMAND_DROPPARAM = "InvokeCommand DropParam";
enum const(wchar)* CFSTR_SHELLDROPHANDLER = "DropHandlerCLSID";
enum const(wchar)* CFSTR_DROPDESCRIPTION = "DropDescription";
enum const(wchar)* CFSTR_ZONEIDENTIFIER = "ZoneIdentifier";

enum : const(wchar)*
{
    CFSTR_FILEDESCRIPTOR = "FileGroupDescriptorW",
    CFSTR_FILENAME       = "FileNameW",
    CFSTR_FILENAMEMAP    = "FileNameMapW",
}

enum const(wchar)* CFSTR_INETURL = "UniformResourceLocatorW";

enum : uint
{
    DVASPECT_SHORTNAME = 0x00000002U,
    DVASPECT_COPY      = 0x00000003U,
    DVASPECT_LINK      = 0x00000004U,
}

enum int SHCNEE_ORDERCHANGED = 0x00000002;

enum : int
{
    SHCNEE_MSI_CHANGE    = 0x00000004,
    SHCNEE_MSI_UNINSTALL = 0x00000005,
}

enum uint NUM_POINTS = 0x00000003U;
enum uint CABINETSTATE_VERSION = 0x00000002U;
enum uint PIFNAMESIZE = 0x0000001eU;
enum uint PIFSTARTLOCSIZE = 0x0000003fU;
enum uint PIFDEFPATHSIZE = 0x00000040U;
enum uint PIFPARAMSSIZE = 0x00000040U;
enum uint PIFSHPROGSIZE = 0x00000040U;
enum uint PIFSHDATASIZE = 0x00000040U;
enum uint PIFDEFFILESIZE = 0x00000050U;
enum uint PIFMAXFILEPATH = 0x00000104U;

enum : uint
{
    QCMINFO_PLACE_BEFORE = 0x00000000U,
    QCMINFO_PLACE_AFTER  = 0x00000001U,
}

enum uint SFVSOC_INVALIDATE_ALL = 0x00000001U;
enum uint SFVSOC_NOSCROLL = 0x00000002U;

enum : uint
{
    SHELLSTATEVERSION_IE4   = 0x00000009U,
    SHELLSTATEVERSION_WIN2K = 0x0000000aU,
}

enum : uint
{
    SHPPFW_NONE         = 0x00000000U,
    SHPPFW_DIRCREATE    = 0x00000001U,
    SHPPFW_ASKDIRCREATE = 0x00000002U,
}

enum uint SHPPFW_IGNOREFILENAME = 0x00000004U;
enum uint SHPPFW_NOWRITECHECK = 0x00000008U;
enum uint SHPPFW_MEDIACHECKONLY = 0x00000010U;
enum uint CMF_NORMAL = 0x00000000U;
enum uint CMF_DEFAULTONLY = 0x00000001U;
enum uint CMF_VERBSONLY = 0x00000002U;
enum uint CMF_EXPLORE = 0x00000004U;
enum uint CMF_NOVERBS = 0x00000008U;
enum uint CMF_CANRENAME = 0x00000010U;
enum uint CMF_NODEFAULT = 0x00000020U;
enum uint CMF_INCLUDESTATIC = 0x00000040U;
enum uint CMF_ITEMMENU = 0x00000080U;
enum uint CMF_EXTENDEDVERBS = 0x00000100U;
enum uint CMF_DISABLEDVERBS = 0x00000200U;
enum uint CMF_ASYNCVERBSTATE = 0x00000400U;
enum uint CMF_OPTIMIZEFORINVOKE = 0x00000800U;
enum uint CMF_SYNCCASCADEMENU = 0x00001000U;
enum uint CMF_DONOTPICKDEFAULT = 0x00002000U;
enum uint CMF_RESERVED = 0xffff0000U;

enum : uint
{
    GCS_VERBA     = 0x00000000U,
    GCS_HELPTEXTA = 0x00000001U,
}

enum uint GCS_VALIDATEA = 0x00000002U;

enum : uint
{
    GCS_VERBW     = 0x00000004U,
    GCS_HELPTEXTW = 0x00000005U,
}

enum uint GCS_VALIDATEW = 0x00000006U;
enum uint GCS_VERBICONW = 0x00000014U;
enum uint GCS_UNICODE = 0x00000004U;

enum : uint
{
    GCS_VERB     = 0x00000004U,
    GCS_HELPTEXT = 0x00000005U,
}

enum uint GCS_VALIDATE = 0x00000006U;

enum : const(wchar)*
{
    // Native encoding: ansi
    CMDSTR_NEWFOLDERA   = "NewFolder",
    // Native encoding: ansi
    CMDSTR_VIEWLISTA    = "ViewList",
    // Native encoding: ansi
    CMDSTR_VIEWDETAILSA = "ViewDetails",
}

enum : const(wchar)*
{
    CMDSTR_NEWFOLDERW   = "NewFolder",
    CMDSTR_VIEWLISTW    = "ViewList",
    CMDSTR_VIEWDETAILSW = "ViewDetails",
}

enum : const(wchar)*
{
    CMDSTR_NEWFOLDER   = "NewFolder",
    CMDSTR_VIEWLIST    = "ViewList",
    CMDSTR_VIEWDETAILS = "ViewDetails",
}

enum : uint
{
    CMIC_MASK_SHIFT_DOWN   = 0x10000000U,
    CMIC_MASK_CONTROL_DOWN = 0x40000000U,
    CMIC_MASK_PTINVOKE     = 0x20000000U,
}

enum : uint
{
    IRTIR_TASK_NOT_RUNNING = 0x00000000U,
    IRTIR_TASK_RUNNING     = 0x00000001U,
    IRTIR_TASK_SUSPENDED   = 0x00000002U,
    IRTIR_TASK_PENDING     = 0x00000003U,
    IRTIR_TASK_FINISHED    = 0x00000004U,
}

enum uint ITSAT_DEFAULT_PRIORITY = 0x10000000U;
enum uint ITSAT_MAX_PRIORITY = 0x7fffffffU;
enum uint ITSAT_MIN_PRIORITY = 0x00000000U;
enum uint ITSSFLAG_COMPLETE_ON_DESTROY = 0x00000000U;
enum uint ITSSFLAG_KILL_ON_DESTROY = 0x00000001U;
enum uint ITSSFLAG_FLAGS_MASK = 0x00000003U;
enum uint ITSS_THREAD_TIMEOUT_NO_CHANGE = 0xfffffffeU;
enum uint CSIDL_FLAG_PFTI_TRACKTARGET = 0x00004000U;

enum : int
{
    SHCIDS_ALLFIELDS     = 0x80000000,
    SHCIDS_CANONICALONLY = 0x10000000,
}

enum : int
{
    SHCIDS_BITMASK    = 0xffff0000,
    SHCIDS_COLUMNMASK = 0x0000ffff,
}

enum const(wchar)* CONFLICT_RESOLUTION_CLSID_KEY = "ConflictResolutionCLSID";
enum const(wchar)* STR_BIND_FORCE_FOLDER_SHORTCUT_RESOLVE = "Force Folder Shortcut Resolve";
enum const(wchar)* STR_AVOID_DRIVE_RESTRICTION_POLICY = "Avoid Drive Restriction Policy";
enum const(wchar)* STR_SKIP_BINDING_CLSID = "Skip Binding CLSID";
enum const(wchar)* STR_PARSE_PREFER_FOLDER_BROWSING = "Parse Prefer Folder Browsing";
enum const(wchar)* STR_DONT_PARSE_RELATIVE = "Don't Parse Relative";
enum const(wchar)* STR_PARSE_TRANSLATE_ALIASES = "Parse Translate Aliases";

enum : const(wchar)*
{
    STR_PARSE_SKIP_NET_CACHE                 = "Skip Net Resource Cache",
    STR_PARSE_SHELL_PROTOCOL_TO_FILE_OBJECTS = "Parse Shell Protocol To File Objects",
}

enum const(wchar)* STR_TRACK_CLSID = "Track the CLSID";
enum const(wchar)* STR_INTERNAL_NAVIGATE = "Internal Navigation";
enum const(wchar)* STR_PARSE_PROPERTYSTORE = "DelegateNamedProperties";
enum const(wchar)* STR_NO_VALIDATE_FILENAME_CHARS = "NoValidateFilenameChars";
enum const(wchar)* STR_BIND_DELEGATE_CREATE_OBJECT = "Delegate Object Creation";
enum const(wchar)* STR_PARSE_ALLOW_INTERNET_SHELL_FOLDERS = "Allow binding to Internet shell folder handlers and negate STR_PARSE_PREFER_WEB_BROWSING";
enum const(wchar)* STR_PARSE_PREFER_WEB_BROWSING = "Do not bind to Internet shell folder handlers";
enum const(wchar)* STR_PARSE_SHOW_NET_DIAGNOSTICS_UI = "Show network diagnostics UI";
enum const(wchar)* STR_PARSE_DONT_REQUIRE_VALIDATED_URLS = "Do not require validated URLs";
enum const(wchar)* STR_INTERNETFOLDER_PARSE_ONLY_URLMON_BINDABLE = "Validate URL";
enum uint BIND_INTERRUPTABLE = 0xffffffffU;

enum : const(wchar)*
{
    STR_BIND_FOLDERS_READ_ONLY = "Folders As Read Only",
    STR_BIND_FOLDER_ENUM_MODE  = "Folder Enum Mode",
}

enum : const(wchar)*
{
    STR_PARSE_WITH_EXPLICIT_PROGID   = "ExplicitProgid",
    STR_PARSE_WITH_EXPLICIT_ASSOCAPP = "ExplicitAssociationApp",
}

enum const(wchar)* STR_PARSE_EXPLICIT_ASSOCIATION_SUCCESSFUL = "ExplicitAssociationSuccessful";
enum const(wchar)* STR_PARSE_AND_CREATE_ITEM = "ParseAndCreateItem";
enum const(wchar)* STR_PROPERTYBAG_PARAM = "SHBindCtxPropertyBag";
enum const(wchar)* STR_ENUM_ITEMS_FLAGS = "SHCONTF";
enum const(wchar)* STR_STORAGEITEM_CREATION_FLAGS = "SHGETSTORAGEITEM";
enum const(wchar)* STR_ITEM_CACHE_CONTEXT = "ItemCacheContext";

enum : uint
{
    CDBOSC_SETFOCUS    = 0x00000000U,
    CDBOSC_KILLFOCUS   = 0x00000001U,
    CDBOSC_SELCHANGE   = 0x00000002U,
    CDBOSC_RENAME      = 0x00000003U,
    CDBOSC_STATECHANGE = 0x00000004U,
}

enum : uint
{
    CDB2N_CONTEXTMENU_DONE  = 0x00000001U,
    CDB2N_CONTEXTMENU_START = 0x00000002U,
}

enum uint CDB2GVF_SHOWALLFILES = 0x00000001U;

enum : uint
{
    CDB2GVF_ISFILESAVE       = 0x00000002U,
    CDB2GVF_ALLOWPREVIEWPANE = 0x00000004U,
}

enum : uint
{
    CDB2GVF_NOSELECTVERB  = 0x00000008U,
    CDB2GVF_NOINCLUDEITEM = 0x00000010U,
}

enum uint CDB2GVF_ISFOLDERPICKER = 0x00000020U;
enum uint CDB2GVF_ADDSHIELD = 0x00000040U;
enum uint SBSP_DEFBROWSER = 0x00000000U;
enum uint SBSP_SAMEBROWSER = 0x00000001U;
enum uint SBSP_NEWBROWSER = 0x00000002U;

enum : uint
{
    SBSP_DEFMODE  = 0x00000000U,
    SBSP_OPENMODE = 0x00000010U,
}

enum uint SBSP_EXPLOREMODE = 0x00000020U;
enum uint SBSP_HELPMODE = 0x00000040U;
enum uint SBSP_NOTRANSFERHIST = 0x00000080U;
enum uint SBSP_ABSOLUTE = 0x00000000U;
enum uint SBSP_RELATIVE = 0x00001000U;

enum : uint
{
    SBSP_PARENT          = 0x00002000U,
    SBSP_NAVIGATEBACK    = 0x00004000U,
    SBSP_NAVIGATEFORWARD = 0x00008000U,
}

enum uint SBSP_ALLOW_AUTONAVIGATE = 0x00010000U;

enum : uint
{
    SBSP_KEEPSAMETEMPLATE  = 0x00020000U,
    SBSP_KEEPWORDWHEELTEXT = 0x00040000U,
}

enum uint SBSP_ACTIVATE_NOFOCUS = 0x00080000U;
enum uint SBSP_CREATENOHISTORY = 0x00100000U;
enum uint SBSP_PLAYNOSOUND = 0x00200000U;
enum uint SBSP_CALLERUNTRUSTED = 0x00800000U;
enum uint SBSP_TRUSTFIRSTDOWNLOAD = 0x01000000U;
enum uint SBSP_UNTRUSTEDFORDOWNLOAD = 0x02000000U;
enum uint SBSP_NOAUTOSELECT = 0x04000000U;
enum uint SBSP_WRITENOHISTORY = 0x08000000U;
enum uint SBSP_TRUSTEDFORACTIVEX = 0x10000000U;
enum uint SBSP_FEEDNAVIGATION = 0x20000000U;
enum uint SBSP_REDIRECT = 0x40000000U;
enum uint SBSP_INITIATEDBYHLINKFRAME = 0x80000000U;
enum uint FCW_STATUS = 0x00000001U;

enum : uint
{
    FCW_TOOLBAR     = 0x00000002U,
    FCW_TREE        = 0x00000003U,
    FCW_INTERNETBAR = 0x00000006U,
}

enum uint FCW_PROGRESS = 0x00000008U;

enum : uint
{
    FCT_MERGE      = 0x00000001U,
    FCT_CONFIGABLE = 0x00000002U,
}

enum uint FCT_ADDTOEND = 0x00000004U;
enum const(wchar)* STR_DONT_RESOLVE_LINK = "Don't Resolve Link";
enum const(wchar)* STR_GET_ASYNC_HANDLER = "GetAsyncHandler";
enum const(wchar)* STR_GPS_HANDLERPROPERTIESONLY = "GPS_HANDLERPROPERTIESONLY";
enum const(wchar)* STR_GPS_FASTPROPERTIESONLY = "GPS_FASTPROPERTIESONLY";
enum const(wchar)* STR_GPS_OPENSLOWITEM = "GPS_OPENSLOWITEM";
enum const(wchar)* STR_GPS_DELAYCREATION = "GPS_DELAYCREATION";

enum : const(wchar)*
{
    STR_GPS_BESTEFFORT = "GPS_BESTEFFORT",
    STR_GPS_NO_OPLOCK  = "GPS_NO_OPLOCK",
}

enum const(wchar)* DI_GETDRAGIMAGE = "ShellGetDragImage";

enum : uint
{
    ARCONTENT_AUTORUNINF     = 0x00000002U,
    ARCONTENT_AUDIOCD        = 0x00000004U,
    ARCONTENT_DVDMOVIE       = 0x00000008U,
    ARCONTENT_BLANKCD        = 0x00000010U,
    ARCONTENT_BLANKDVD       = 0x00000020U,
    ARCONTENT_UNKNOWNCONTENT = 0x00000040U,
    ARCONTENT_AUTOPLAYPIX    = 0x00000080U,
    ARCONTENT_AUTOPLAYMUSIC  = 0x00000100U,
    ARCONTENT_AUTOPLAYVIDEO  = 0x00000200U,
    ARCONTENT_VCD            = 0x00000400U,
    ARCONTENT_SVCD           = 0x00000800U,
    ARCONTENT_DVDAUDIO       = 0x00001000U,
    ARCONTENT_BLANKBD        = 0x00002000U,
    ARCONTENT_BLURAY         = 0x00004000U,
    ARCONTENT_CAMERASTORAGE  = 0x00008000U,
    ARCONTENT_CUSTOMEVENT    = 0x00010000U,
    ARCONTENT_NONE           = 0x00000000U,
    ARCONTENT_MASK           = 0x0001fffeU,
    ARCONTENT_PHASE_UNKNOWN  = 0x00000000U,
    ARCONTENT_PHASE_PRESNIFF = 0x10000000U,
    ARCONTENT_PHASE_SNIFFING = 0x20000000U,
    ARCONTENT_PHASE_FINAL    = 0x40000000U,
    ARCONTENT_PHASE_MASK     = 0x70000000U,
}

enum : uint
{
    IEI_PRIORITY_MAX = 0x7fffffffU,
    IEI_PRIORITY_MIN = 0x00000000U,
}

enum uint IEIT_PRIORITY_NORMAL = 0x10000000U;

enum : uint
{
    IEIFLAG_ASYNC    = 0x00000001U,
    IEIFLAG_CACHE    = 0x00000002U,
    IEIFLAG_ASPECT   = 0x00000004U,
    IEIFLAG_OFFLINE  = 0x00000008U,
    IEIFLAG_GLEAM    = 0x00000010U,
    IEIFLAG_SCREEN   = 0x00000020U,
    IEIFLAG_ORIGSIZE = 0x00000040U,
    IEIFLAG_NOSTAMP  = 0x00000080U,
    IEIFLAG_NOBORDER = 0x00000100U,
    IEIFLAG_QUALITY  = 0x00000200U,
    IEIFLAG_REFRESH  = 0x00000400U,
}

enum : uint
{
    DBIM_MINSIZE  = 0x00000001U,
    DBIM_MAXSIZE  = 0x00000002U,
    DBIM_INTEGRAL = 0x00000004U,
}

enum : uint
{
    DBIM_ACTUAL    = 0x00000008U,
    DBIM_TITLE     = 0x00000010U,
    DBIM_MODEFLAGS = 0x00000020U,
}

enum uint DBIM_BKCOLOR = 0x00000040U;

enum : uint
{
    DBIMF_NORMAL         = 0x00000000U,
    DBIMF_FIXED          = 0x00000001U,
    DBIMF_FIXEDBMP       = 0x00000004U,
    DBIMF_VARIABLEHEIGHT = 0x00000008U,
}

enum uint DBIMF_UNDELETEABLE = 0x00000010U;

enum : uint
{
    DBIMF_DEBOSSED   = 0x00000020U,
    DBIMF_BKCOLOR    = 0x00000040U,
    DBIMF_USECHEVRON = 0x00000080U,
}

enum : uint
{
    DBIMF_BREAK      = 0x00000100U,
    DBIMF_ADDTOFRONT = 0x00000200U,
}

enum : uint
{
    DBIMF_TOPALIGN  = 0x00000400U,
    DBIMF_NOGRIPPER = 0x00000800U,
}

enum uint DBIMF_ALWAYSGRIPPER = 0x00001000U;
enum uint DBIMF_NOMARGINS = 0x00002000U;

enum : uint
{
    DBIF_VIEWMODE_NORMAL      = 0x00000000U,
    DBIF_VIEWMODE_VERTICAL    = 0x00000001U,
    DBIF_VIEWMODE_FLOATING    = 0x00000002U,
    DBIF_VIEWMODE_TRANSPARENT = 0x00000004U,
}

enum uint DBPC_SELECTFIRST = 0xffffffffU;
enum uint THBN_CLICKED = 0x00001800U;

enum : uint
{
    BSIM_STATE = 0x00000001U,
    BSIM_STYLE = 0x00000002U,
}

enum : uint
{
    BSSF_VISIBLE      = 0x00000001U,
    BSSF_NOTITLE      = 0x00000002U,
    BSSF_UNDELETEABLE = 0x00001000U,
}

enum uint BSIS_AUTOGRIPPER = 0x00000000U;
enum uint BSIS_NOGRIPPER = 0x00000001U;
enum uint BSIS_ALWAYSGRIPPER = 0x00000002U;
enum uint BSIS_LEFTALIGN = 0x00000004U;
enum uint BSIS_SINGLECLICK = 0x00000008U;
enum uint BSIS_NOCONTEXTMENU = 0x00000010U;

enum : uint
{
    BSIS_NODROPTARGET = 0x00000020U,
    BSIS_NOCAPTION    = 0x00000040U,
}

enum uint BSIS_PREFERNOLINEBREAK = 0x00000080U;

enum : uint
{
    BSIS_LOCKED                    = 0x00000100U,
    BSIS_PRESERVEORDERDURINGLAYOUT = 0x00000200U,
}

enum uint BSIS_FIXEDORDER = 0x00000400U;

enum : uint
{
    OF_CAP_CANSWITCHTO = 0x00000001U,
    OF_CAP_CANCLOSE    = 0x00000002U,
}

enum uint SMDM_SHELLFOLDER = 0x00000001U;

enum : uint
{
    SMDM_HMENU   = 0x00000002U,
    SMDM_TOOLBAR = 0x00000004U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/smc-initmenu
enum uint SMC_INITMENU = 0x00000001U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/smc-create
enum uint SMC_CREATE = 0x00000002U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/smc-exitmenu
enum uint SMC_EXITMENU = 0x00000003U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/smc-getinfo
    SMC_GETINFO     = 0x00000005U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/smc-getsfinfo
    SMC_GETSFINFO   = 0x00000006U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/smc-getobject
    SMC_GETOBJECT   = 0x00000007U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/smc-getsfobject
    SMC_GETSFOBJECT = 0x00000008U,
}

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/smc-sfexec
    SMC_SFEXEC       = 0x00000009U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/smc-sfselectitem
    SMC_SFSELECTITEM = 0x0000000aU,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/smc-refresh
enum uint SMC_REFRESH = 0x00000010U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/smc-demote
enum uint SMC_DEMOTE = 0x00000011U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/smc-promote
enum uint SMC_PROMOTE = 0x00000012U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/smc-defaulticon
enum uint SMC_DEFAULTICON = 0x00000016U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/smc-newitem
enum uint SMC_NEWITEM = 0x00000017U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/smc-chevronexpand
enum uint SMC_CHEVRONEXPAND = 0x00000019U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/smc-displaychevrontip
enum uint SMC_DISPLAYCHEVRONTIP = 0x0000002aU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/smc-setsfobject
enum uint SMC_SETSFOBJECT = 0x0000002dU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/smc-shchangenotify
enum uint SMC_SHCHANGENOTIFY = 0x0000002eU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/smc-chevrongettip
enum uint SMC_CHEVRONGETTIP = 0x0000002fU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/smc-sfddrestricted
enum uint SMC_SFDDRESTRICTED = 0x00000030U;
enum uint SMC_SFEXEC_MIDDLE = 0x00000031U;
enum uint SMC_GETAUTOEXPANDSTATE = 0x00000041U;
enum uint SMC_AUTOEXPANDCHANGE = 0x00000042U;
enum uint SMC_GETCONTEXTMENUMODIFIER = 0x00000043U;
enum uint SMC_GETBKCONTEXTMENU = 0x00000044U;
enum uint SMC_OPEN = 0x00000045U;
enum uint SMAE_EXPANDED = 0x00000001U;
enum uint SMAE_CONTRACTED = 0x00000002U;

enum : uint
{
    SMAE_USER  = 0x00000004U,
    SMAE_VALID = 0x00000007U,
}

enum : uint
{
    SMINIT_DEFAULT           = 0x00000000U,
    SMINIT_RESTRICT_DRAGDROP = 0x00000002U,
}

enum : uint
{
    SMINIT_TOPLEVEL    = 0x00000004U,
    SMINIT_CACHED      = 0x00000010U,
    SMINIT_AUTOEXPAND  = 0x00000100U,
    SMINIT_AUTOTOOLTIP = 0x00000200U,
}

enum uint SMINIT_DROPONCONTAINER = 0x00000400U;

enum : uint
{
    SMINIT_VERTICAL   = 0x10000000U,
    SMINIT_HORIZONTAL = 0x20000000U,
}

enum : uint
{
    SMSET_TOP     = 0x10000000U,
    SMSET_BOTTOM  = 0x20000000U,
    SMSET_DONTOWN = 0x00000001U,
}

enum : uint
{
    SMINV_REFRESH = 0x00000001U,
    SMINV_ID      = 0x00000008U,
}

enum : HRESULT
{
    E_PREVIEWHANDLER_DRM_FAIL = HRESULT(0x86420001),
    E_PREVIEWHANDLER_NOAUTH   = HRESULT(0x86420002),
    E_PREVIEWHANDLER_NOTFOUND = HRESULT(0x86420003),
    E_PREVIEWHANDLER_CORRUPT  = HRESULT(0x86420004),
}

enum : const(wchar)*
{
    STR_FILE_SYS_BIND_DATA             = "File System Bind Data",
    STR_FILE_SYS_BIND_DATA_WIN7_FORMAT = "Win7FileSystemIdList",
}

enum : const(wchar)*
{
    HOMEGROUP_SECURITY_GROUP_MULTI = "HUG",
    HOMEGROUP_SECURITY_GROUP       = "HomeUsers",
}

enum const(wchar)* PROP_CONTRACT_DELEGATE = "ContractDelegate";
enum GUID SID_URLExecutionContext = GUID("fb5f8ebc-bbb6-4d10-a461-777291a09030");
enum const(wchar)* STR_TAB_REUSE_IDENTIFIER = "Tab Reuse Identifier";
enum const(wchar)* STR_REFERRER_IDENTIFIER = "Referrer Identifier";
enum GUID SID_LaunchSourceViewSizePreference = GUID("80605492-67d9-414f-af89-a1cdf1242bc1");
enum GUID SID_LaunchTargetViewSizePreference = GUID("26db2472-b7b7-406b-9702-730a4e20d3bf");
enum GUID SID_LaunchSourceAppUserModelId = GUID("2ce78010-74db-48bc-9c6a-10f372495723");
enum GUID SID_ShellExecuteNamedPropertyStore = GUID("eb84ada2-00ff-4992-8324-ed5ce061cb29");

enum : uint
{
    ISIOI_ICONFILE  = 0x00000001U,
    ISIOI_ICONINDEX = 0x00000002U,
}

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/abm-new
    ABM_NEW    = 0x00000000U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/abm-remove
    ABM_REMOVE = 0x00000001U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/abm-querypos
enum uint ABM_QUERYPOS = 0x00000002U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/abm-setpos
enum uint ABM_SETPOS = 0x00000003U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/abm-getstate
    ABM_GETSTATE      = 0x00000004U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/abm-gettaskbarpos
    ABM_GETTASKBARPOS = 0x00000005U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/abm-activate
enum uint ABM_ACTIVATE = 0x00000006U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/abm-getautohidebar
enum uint ABM_GETAUTOHIDEBAR = 0x00000007U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/abm-setautohidebar
enum uint ABM_SETAUTOHIDEBAR = 0x00000008U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/abm-windowposchanged
enum uint ABM_WINDOWPOSCHANGED = 0x00000009U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/abm-setstate
enum uint ABM_SETSTATE = 0x0000000aU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/abm-getautohidebarex
enum uint ABM_GETAUTOHIDEBAREX = 0x0000000bU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/abm-setautohidebarex
enum uint ABM_SETAUTOHIDEBAREX = 0x0000000cU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/abn-statechange
enum uint ABN_STATECHANGE = 0x00000000U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/abn-poschanged
enum uint ABN_POSCHANGED = 0x00000001U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/abn-fullscreenapp
enum uint ABN_FULLSCREENAPP = 0x00000002U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/abn-windowarrange
enum uint ABN_WINDOWARRANGE = 0x00000003U;

enum : uint
{
    ABS_AUTOHIDE    = 0x00000001U,
    ABS_ALWAYSONTOP = 0x00000002U,
}

enum : uint
{
    ABE_LEFT   = 0x00000000U,
    ABE_TOP    = 0x00000001U,
    ABE_RIGHT  = 0x00000002U,
    ABE_BOTTOM = 0x00000003U,
}

enum : uint
{
    FO_MOVE   = 0x00000001U,
    FO_COPY   = 0x00000002U,
    FO_DELETE = 0x00000003U,
}

enum uint FO_RENAME = 0x00000004U;
enum uint PO_DELETE = 0x00000013U;
enum uint PO_RENAME = 0x00000014U;
enum uint PO_PORTCHANGE = 0x00000020U;
enum uint PO_REN_PORT = 0x00000034U;

enum : uint
{
    SE_ERR_FNF          = 0x00000002U,
    SE_ERR_PNF          = 0x00000003U,
    SE_ERR_ACCESSDENIED = 0x00000005U,
}

enum : uint
{
    SE_ERR_OOM         = 0x00000008U,
    SE_ERR_DLLNOTFOUND = 0x00000020U,
}

enum : uint
{
    SE_ERR_SHARE           = 0x0000001aU,
    SE_ERR_ASSOCINCOMPLETE = 0x0000001bU,
}

enum : uint
{
    SE_ERR_DDETIMEOUT = 0x0000001cU,
    SE_ERR_DDEFAIL    = 0x0000001dU,
    SE_ERR_DDEBUSY    = 0x0000001eU,
    SE_ERR_NOASSOC    = 0x0000001fU,
}

enum : uint
{
    SEE_MASK_DEFAULT        = 0x00000000U,
    SEE_MASK_CLASSNAME      = 0x00000001U,
    SEE_MASK_CLASSKEY       = 0x00000003U,
    SEE_MASK_IDLIST         = 0x00000004U,
    SEE_MASK_INVOKEIDLIST   = 0x0000000cU,
    SEE_MASK_ICON           = 0x00000010U,
    SEE_MASK_HOTKEY         = 0x00000020U,
    SEE_MASK_NOCLOSEPROCESS = 0x00000040U,
}

enum : uint
{
    SEE_MASK_CONNECTNETDRV     = 0x00000080U,
    SEE_MASK_NOASYNC           = 0x00000100U,
    SEE_MASK_FLAG_DDEWAIT      = 0x00000100U,
    SEE_MASK_DOENVSUBST        = 0x00000200U,
    SEE_MASK_FLAG_NO_UI        = 0x00000400U,
    SEE_MASK_UNICODE           = 0x00004000U,
    SEE_MASK_NO_CONSOLE        = 0x00008000U,
    SEE_MASK_ASYNCOK           = 0x00100000U,
    SEE_MASK_HMONITOR          = 0x00200000U,
    SEE_MASK_NOZONECHECKS      = 0x00800000U,
    SEE_MASK_NOQUERYCLASSSTORE = 0x01000000U,
}

enum uint SEE_MASK_WAITFORINPUTIDLE = 0x02000000U;

enum : uint
{
    SEE_MASK_FLAG_LOG_USAGE     = 0x04000000U,
    SEE_MASK_FLAG_HINST_IS_SITE = 0x08000000U,
}

enum uint SHERB_NOCONFIRMATION = 0x00000001U;

enum : uint
{
    SHERB_NOPROGRESSUI = 0x00000002U,
    SHERB_NOSOUND      = 0x00000004U,
}

enum uint NIN_SELECT = 0x00000400U;
enum uint NINF_KEY = 0x00000001U;

enum : uint
{
    NIN_BALLOONSHOW      = 0x00000402U,
    NIN_BALLOONHIDE      = 0x00000403U,
    NIN_BALLOONTIMEOUT   = 0x00000404U,
    NIN_BALLOONUSERCLICK = 0x00000405U,
}

enum : uint
{
    NIN_POPUPOPEN  = 0x00000406U,
    NIN_POPUPCLOSE = 0x00000407U,
}

enum : uint
{
    NOTIFYICON_VERSION   = 0x00000003U,
    NOTIFYICON_VERSION_4 = 0x00000004U,
}

enum : ulong
{
    SHGNLI_PIDL       = 0x0000000000000001UL,
    SHGNLI_PREFIXNAME = 0x0000000000000002UL,
    SHGNLI_NOUNIQUE   = 0x0000000000000004UL,
    SHGNLI_NOLNK      = 0x0000000000000008UL,
    SHGNLI_NOLOCNAME  = 0x0000000000000010UL,
    SHGNLI_USEURLEXT  = 0x0000000000000020UL,
}

enum : uint
{
    PRINTACTION_OPEN             = 0x00000000U,
    PRINTACTION_PROPERTIES       = 0x00000001U,
    PRINTACTION_NETINSTALL       = 0x00000002U,
    PRINTACTION_NETINSTALLLINK   = 0x00000003U,
    PRINTACTION_TESTPAGE         = 0x00000004U,
    PRINTACTION_OPENNETPRN       = 0x00000005U,
    PRINTACTION_DOCUMENTDEFAULTS = 0x00000006U,
    PRINTACTION_SERVERPROPERTIES = 0x00000007U,
}

enum uint PRINT_PROP_FORCE_NAME = 0x00000001U;

enum : uint
{
    OFFLINE_STATUS_LOCAL      = 0x00000001U,
    OFFLINE_STATUS_REMOTE     = 0x00000002U,
    OFFLINE_STATUS_INCOMPLETE = 0x00000004U,
}

enum : uint
{
    SHIL_LARGE      = 0x00000000U,
    SHIL_SMALL      = 0x00000001U,
    SHIL_EXTRALARGE = 0x00000002U,
}

enum uint SHIL_SYSSMALL = 0x00000003U;

enum : uint
{
    SHIL_JUMBO = 0x00000004U,
    SHIL_LAST  = 0x00000004U,
}

enum const(wchar)* WC_NETADDRESS = "msctls_netaddress";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ncm-getaddress
enum uint NCM_GETADDRESS = 0x00000401U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ncm-setallowtype
enum uint NCM_SETALLOWTYPE = 0x00000402U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ncm-getallowtype
enum uint NCM_GETALLOWTYPE = 0x00000403U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ncm-displayerrortip
enum uint NCM_DISPLAYERRORTIP = 0x00000404U;
enum uint CREDENTIAL_PROVIDER_NO_DEFAULT = 0xffffffffU;
enum GUID Identity_LocalUserProvider = GUID("a198529b-730f-4089-b646-a12557f5665e");

enum : uint
{
    MAX_SYNCMGR_ID           = 0x00000040U,
    MAX_SYNCMGR_PROGRESSTEXT = 0x00000104U,
    MAX_SYNCMGR_NAME         = 0x00000080U,
}

enum : int
{
    STIF_DEFAULT     = 0x00000000,
    STIF_SUPPORT_HEX = 0x00000001,
}

enum : const(wchar)*
{
    // Native encoding: ansi
    SZ_CONTENTTYPE_HTMLA = "text/html",
    SZ_CONTENTTYPE_HTMLW = "text/html",
    // Native encoding: ansi
    SZ_CONTENTTYPE_CDFA  = "application/x-cdf",
    SZ_CONTENTTYPE_CDFW  = "application/x-cdf",
    SZ_CONTENTTYPE_HTML  = "text/html",
    SZ_CONTENTTYPE_CDF   = "application/x-cdf",
}

enum uint GCT_INVALID = 0x00000000U;
enum uint GCT_LFNCHAR = 0x00000001U;
enum uint GCT_SHORTCHAR = 0x00000002U;

enum : uint
{
    GCT_WILD      = 0x00000004U,
    GCT_SEPARATOR = 0x00000008U,
}

enum : uint
{
    PMSF_NORMAL   = 0x00000000U,
    PMSF_MULTIPLE = 0x00000001U,
}

enum uint PMSF_DONT_STRIP_SPACES = 0x00010000U;
enum uint URL_UNESCAPE = 0x10000000U;
enum uint URL_ESCAPE_UNSAFE = 0x20000000U;
enum uint URL_PLUGGABLE_PROTOCOL = 0x40000000U;
enum uint URL_WININET_COMPATIBILITY = 0x80000000U;
enum uint URL_DONT_ESCAPE_EXTRA_INFO = 0x02000000U;
enum uint URL_DONT_UNESCAPE_EXTRA_INFO = 0x02000000U;
enum uint URL_BROWSER_MODE = 0x02000000U;
enum uint URL_ESCAPE_SPACES_ONLY = 0x04000000U;
enum uint URL_DONT_SIMPLIFY = 0x08000000U;
enum uint URL_NO_META = 0x08000000U;
enum uint URL_UNESCAPE_INPLACE = 0x00100000U;
enum uint URL_CONVERT_IF_DOSPATH = 0x00200000U;
enum uint URL_UNESCAPE_HIGH_ANSI_ONLY = 0x00400000U;
enum uint URL_INTERNAL_PATH = 0x00800000U;
enum uint URL_FILE_USE_PATHURL = 0x00010000U;
enum uint URL_DONT_UNESCAPE = 0x00020000U;
enum uint URL_ESCAPE_AS_UTF8 = 0x00040000U;
enum uint URL_UNESCAPE_AS_UTF8 = 0x00040000U;
enum uint URL_ESCAPE_ASCII_URI_COMPONENT = 0x00080000U;
enum uint URL_UNESCAPE_URI_COMPONENT = 0x00040000U;

enum : uint
{
    URL_ESCAPE_PERCENT      = 0x00001000U,
    URL_ESCAPE_SEGMENT_ONLY = 0x00002000U,
}

enum uint URL_PARTFLAG_KEEPSCHEME = 0x00000001U;

enum : uint
{
    URL_APPLY_DEFAULT     = 0x00000001U,
    URL_APPLY_GUESSSCHEME = 0x00000002U,
    URL_APPLY_GUESSFILE   = 0x00000004U,
    URL_APPLY_FORCEAPPLY  = 0x00000008U,
}

enum : uint
{
    SRRF_RT_REG_NONE      = 0x00000001U,
    SRRF_RT_REG_SZ        = 0x00000002U,
    SRRF_RT_REG_EXPAND_SZ = 0x00000004U,
    SRRF_RT_REG_BINARY    = 0x00000008U,
    SRRF_RT_REG_DWORD     = 0x00000010U,
    SRRF_RT_REG_MULTI_SZ  = 0x00000020U,
    SRRF_RT_REG_QWORD     = 0x00000040U,
    SRRF_RT_ANY           = 0x0000ffffU,
    SRRF_RM_ANY           = 0x00000000U,
    SRRF_RM_NORMAL        = 0x00010000U,
    SRRF_RM_SAFE          = 0x00020000U,
    SRRF_RM_SAFENETWORK   = 0x00040000U,
}

enum uint SRRF_NOEXPAND = 0x10000000U;
enum uint SRRF_ZEROONFAILURE = 0x20000000U;
enum uint SRRF_NOVIRT = 0x40000000U;

enum : uint
{
    SHREGSET_HKCU       = 0x00000001U,
    SHREGSET_FORCE_HKCU = 0x00000002U,
    SHREGSET_HKLM       = 0x00000004U,
    SHREGSET_FORCE_HKLM = 0x00000008U,
}

enum : uint
{
    SPMODE_SHELL      = 0x00000001U,
    SPMODE_DEBUGOUT   = 0x00000002U,
    SPMODE_TEST       = 0x00000004U,
    SPMODE_BROWSER    = 0x00000008U,
    SPMODE_FLUSH      = 0x00000010U,
    SPMODE_EVENT      = 0x00000020U,
    SPMODE_MSVM       = 0x00000040U,
    SPMODE_FORMATTEXT = 0x00000080U,
    SPMODE_PROFILE    = 0x00000100U,
    SPMODE_DEBUGBREAK = 0x00000200U,
    SPMODE_MSGTRACE   = 0x00000400U,
    SPMODE_PERFTAGS   = 0x00000800U,
    SPMODE_MEMWATCH   = 0x00001000U,
    SPMODE_DBMON      = 0x00002000U,
    SPMODE_MULTISTOP  = 0x00004000U,
    SPMODE_EVENTTRACE = 0x00008000U,
}

enum : uint
{
    SHGVSPB_PERUSER        = 0x00000001U,
    SHGVSPB_ALLUSERS       = 0x00000002U,
    SHGVSPB_PERFOLDER      = 0x00000004U,
    SHGVSPB_ALLFOLDERS     = 0x00000008U,
    SHGVSPB_INHERIT        = 0x00000010U,
    SHGVSPB_ROAM           = 0x00000020U,
    SHGVSPB_NOAUTODEFAULTS = 0x80000000U,
}

enum : uint
{
    FDTF_SHORTTIME = 0x00000001U,
    FDTF_SHORTDATE = 0x00000002U,
}

enum : uint
{
    FDTF_LONGDATE = 0x00000004U,
    FDTF_LONGTIME = 0x00000008U,
}

enum uint FDTF_RELATIVE = 0x00000010U;

enum : uint
{
    FDTF_LTRDATE            = 0x00000100U,
    FDTF_RTLDATE            = 0x00000200U,
    FDTF_NOAUTOREADINGORDER = 0x00000400U,
}

enum : uint
{
    PLATFORM_UNKNOWN     = 0x00000000U,
    PLATFORM_IE3         = 0x00000001U,
    PLATFORM_BROWSERONLY = 0x00000001U,
    PLATFORM_INTEGRATED  = 0x00000002U,
}

enum uint ILMM_IE4 = 0x00000000U;

enum : uint
{
    DLLVER_PLATFORM_WINDOWS = 0x00000001U,
    DLLVER_PLATFORM_NT      = 0x00000002U,
}

enum : ulong
{
    DLLVER_MAJOR_MASK = 0xffff000000000000UL,
    DLLVER_MINOR_MASK = 0x0000ffff00000000UL,
    DLLVER_BUILD_MASK = 0x00000000ffff0000UL,
    DLLVER_QFE_MASK   = 0x000000000000ffffUL,
}

enum HRESULT WTS_E_FAILEDEXTRACTION = HRESULT(0x8004b200);
enum HRESULT WTS_E_EXTRACTIONTIMEDOUT = HRESULT(0x8004b201);
enum HRESULT WTS_E_SURROGATEUNAVAILABLE = HRESULT(0x8004b202);
enum HRESULT WTS_E_FASTEXTRACTIONNOTSUPPORTED = HRESULT(0x8004b203);
enum HRESULT WTS_E_DATAFILEUNAVAILABLE = HRESULT(0x8004b204);

enum : HRESULT
{
    WTS_E_EXTRACTIONPENDING = HRESULT(0x8004b205),
    WTS_E_EXTRACTIONBLOCKED = HRESULT(0x8004b206),
}

enum HRESULT WTS_E_NOSTORAGEPROVIDERTHUMBNAILHANDLER = HRESULT(0x8004b207);

enum : const(wchar)*
{
    SHIMGKEY_QUALITY   = "Compression",
    SHIMGKEY_RAWFORMAT = "RawDataFormat",
}

enum : uint
{
    SHIMGDEC_DEFAULT   = 0x00000000U,
    SHIMGDEC_THUMBNAIL = 0x00000001U,
    SHIMGDEC_LOADFULL  = 0x00000002U,
}

enum HRESULT E_NOTVALIDFORANIMATEDIMAGE = HRESULT(0x80040001);

enum : HRESULT
{
    S_SYNCMGR_MISSINGITEMS = HRESULT(0x00040201),
    S_SYNCMGR_RETRYSYNC    = HRESULT(0x00040202),
    S_SYNCMGR_CANCELITEM   = HRESULT(0x00040203),
    S_SYNCMGR_CANCELALL    = HRESULT(0x00040204),
    S_SYNCMGR_ITEMDELETED  = HRESULT(0x00040210),
    S_SYNCMGR_ENUMITEMS    = HRESULT(0x00040211),
}

enum : uint
{
    SYNCMGRPROGRESSITEM_STATUSTEXT = 0x00000001U,
    SYNCMGRPROGRESSITEM_STATUSTYPE = 0x00000002U,
    SYNCMGRPROGRESSITEM_PROGVALUE  = 0x00000004U,
    SYNCMGRPROGRESSITEM_MAXVALUE   = 0x00000008U,
}

enum : uint
{
    SYNCMGRLOGERROR_ERRORFLAGS = 0x00000001U,
    SYNCMGRLOGERROR_ERRORID    = 0x00000002U,
    SYNCMGRLOGERROR_ITEMID     = 0x00000004U,
}

enum uint SYNCMGRITEM_ITEMFLAGMASK = 0x0000007fU;
enum uint MAX_SYNCMGRITEMNAME = 0x00000080U;
enum uint SYNCMGRHANDLERFLAG_MASK = 0x0000000fU;
enum uint MAX_SYNCMGRHANDLERNAME = 0x00000020U;
enum uint SYNCMGRREGISTERFLAGS_MASK = 0x00000007U;
enum int TLOG_BACK = 0xffffffff;

enum : uint
{
    TLOG_CURRENT = 0x00000000U,
    TLOG_FORE    = 0x00000001U,
}

enum uint TLMENUF_INCLUDECURRENT = 0x00000001U;

enum : uint
{
    TLMENUF_BACK = 0x00000010U,
    TLMENUF_FORE = 0x00000020U,
}

enum uint BSF_REGISTERASDROPTARGET = 0x00000001U;
enum uint BSF_THEATERMODE = 0x00000002U;
enum uint BSF_NOLOCALFILEWARNING = 0x00000010U;
enum uint BSF_UISETBYAUTOMATION = 0x00000100U;
enum uint BSF_RESIZABLE = 0x00000200U;
enum uint BSF_CANMAXIMIZE = 0x00000400U;
enum uint BSF_TOPBROWSER = 0x00000800U;
enum uint BSF_NAVNOHISTORY = 0x00001000U;
enum uint BSF_HTMLNAVCANCELED = 0x00002000U;
enum uint BSF_DONTSHOWNAVCANCELPAGE = 0x00004000U;
enum uint BSF_SETNAVIGATABLECODEPAGE = 0x00008000U;
enum uint BSF_DELEGATEDNAVIGATION = 0x00010000U;
enum uint BSF_TRUSTEDFORACTIVEX = 0x00020000U;
enum uint BSF_MERGEDMENUS = 0x00040000U;

enum : uint
{
    BSF_FEEDNAVIGATION = 0x00080000U,
    BSF_FEEDSUBSCRIBED = 0x00100000U,
}

enum uint HLNF_CALLERUNTRUSTED = 0x00200000U;
enum uint HLNF_TRUSTEDFORACTIVEX = 0x00400000U;
enum uint HLNF_DISABLEWINDOWRESTRICTIONS = 0x00800000U;
enum uint HLNF_TRUSTFIRSTDOWNLOAD = 0x01000000U;
enum uint HLNF_UNTRUSTEDFORDOWNLOAD = 0x02000000U;
enum uint SHHLNF_NOAUTOSELECT = 0x04000000U;
enum uint SHHLNF_WRITENOHISTORY = 0x08000000U;
enum uint HLNF_EXTERNALNAVIGATE = 0x10000000U;
enum uint HLNF_ALLOW_AUTONAVIGATE = 0x20000000U;
enum uint HLNF_NEWWINDOWSMANAGED = 0x80000000U;

enum : uint
{
    INTERNET_MAX_PATH_LENGTH   = 0x00000800U,
    INTERNET_MAX_SCHEME_LENGTH = 0x00000020U,
}

enum : uint
{
    VIEW_PRIORITY_RESTRICTED        = 0x00000070U,
    VIEW_PRIORITY_CACHEHIT          = 0x00000050U,
    VIEW_PRIORITY_STALECACHEHIT     = 0x00000045U,
    VIEW_PRIORITY_USEASDEFAULT      = 0x00000043U,
    VIEW_PRIORITY_SHELLEXT          = 0x00000040U,
    VIEW_PRIORITY_CACHEMISS         = 0x00000030U,
    VIEW_PRIORITY_INHERIT           = 0x00000020U,
    VIEW_PRIORITY_SHELLEXT_ASBACKUP = 0x00000015U,
    VIEW_PRIORITY_DESPERATE         = 0x00000010U,
    VIEW_PRIORITY_NONE              = 0x00000000U,
}

enum const(wchar)* VOLUME_PREFIX = "\\\\?\\Volume";
enum uint PATHCCH_MAX_CCH = 0x00008000U;
enum uint IDS_DESCRIPTION = 0x00000001U;
enum uint ID_APP = 0x00000064U;
enum uint DLG_SCRNSAVECONFIGURE = 0x000007d3U;
enum uint idsIsPassword = 0x000003e8U;
enum uint idsIniFile = 0x000003e9U;
enum uint idsScreenSaver = 0x000003eaU;
enum uint idsPassword = 0x000003ebU;
enum uint idsDifferentPW = 0x000003ecU;
enum uint idsChangePW = 0x000003edU;
enum uint idsBadOldPW = 0x000003eeU;
enum uint idsAppName = 0x000003efU;
enum uint idsNoHelpMemory = 0x000003f0U;
enum uint idsHelpFile = 0x000003f1U;
enum uint idsDefKeyword = 0x000003f2U;
enum uint MAXFILELEN = 0x0000000dU;
enum uint TITLEBARNAMELEN = 0x00000028U;
enum uint APPNAMEBUFFERLEN = 0x00000028U;
enum uint BUFFLEN = 0x000000ffU;
enum uint SCRM_VERIFYPW = 0x00008000U;
enum HRESULT E_FLAGS = HRESULT(0x80041000);
enum HRESULT IS_E_EXEC_FAILED = HRESULT(0x80042002);
enum HRESULT URL_E_INVALID_SYNTAX = HRESULT(0x80041001);
enum HRESULT URL_E_UNREGISTERED_PROTOCOL = HRESULT(0x80041002);

enum : uint
{
    CPLPAGE_MOUSE_BUTTONS   = 0x00000001U,
    CPLPAGE_MOUSE_PTRMOTION = 0x00000002U,
    CPLPAGE_MOUSE_WHEEL     = 0x00000003U,
    CPLPAGE_KEYBOARD_SPEED  = 0x00000001U,
}

enum uint CPLPAGE_DISPLAY_BACKGROUND = 0x00000001U;
enum uint DISPID_SELECTIONCHANGED = 0x000000c8U;
enum uint DISPID_FILELISTENUMDONE = 0x000000c9U;
enum uint DISPID_VERBINVOKED = 0x000000caU;
enum uint DISPID_DEFAULTVERBINVOKED = 0x000000cbU;

enum : uint
{
    DISPID_BEGINDRAG       = 0x000000ccU,
    DISPID_VIEWMODECHANGED = 0x000000cdU,
}

enum uint DISPID_NOITEMSTATE_CHANGED = 0x000000ceU;
enum uint DISPID_CONTENTSCHANGED = 0x000000cfU;
enum uint DISPID_FOCUSCHANGED = 0x000000d0U;
enum uint DISPID_CHECKSTATECHANGED = 0x000000d1U;
enum uint DISPID_ORDERCHANGED = 0x000000d2U;
enum uint DISPID_VIEWPAINTDONE = 0x000000d3U;
enum uint DISPID_COLUMNSCHANGED = 0x000000d4U;
enum uint DISPID_CTRLMOUSEWHEEL = 0x000000d5U;

enum : uint
{
    DISPID_SORTDONE        = 0x000000d6U,
    DISPID_ICONSIZECHANGED = 0x000000d7U,
}

enum uint DISPID_FOLDERCHANGED = 0x000000d9U;
enum uint DISPID_FILTERINVOKED = 0x000000daU;
enum uint DISPID_WORDWHEELEDITED = 0x000000dbU;
enum uint DISPID_SELECTEDITEMCHANGED = 0x000000dcU;
enum uint DISPID_EXPLORERWINDOWREADY = 0x000000ddU;
enum uint DISPID_UPDATEIMAGE = 0x000000deU;
enum uint DISPID_INITIALENUMERATIONDONE = 0x000000dfU;

enum : uint
{
    DISPID_ENTERPRISEIDCHANGED = 0x000000e0U,
    DISPID_ENTERPRESSED        = 0x000000c8U,
}

enum : uint
{
    DISPID_SEARCHCOMMAND_START        = 0x00000001U,
    DISPID_SEARCHCOMMAND_COMPLETE     = 0x00000002U,
    DISPID_SEARCHCOMMAND_ABORT        = 0x00000003U,
    DISPID_SEARCHCOMMAND_UPDATE       = 0x00000004U,
    DISPID_SEARCHCOMMAND_PROGRESSTEXT = 0x00000005U,
    DISPID_SEARCHCOMMAND_ERROR        = 0x00000006U,
    DISPID_SEARCHCOMMAND_RESTORE      = 0x00000007U,
}

enum : uint
{
    DISPID_IADCCTL_DIRTY         = 0x00000100U,
    DISPID_IADCCTL_PUBCAT        = 0x00000101U,
    DISPID_IADCCTL_SORT          = 0x00000102U,
    DISPID_IADCCTL_FORCEX86      = 0x00000103U,
    DISPID_IADCCTL_SHOWPOSTSETUP = 0x00000104U,
    DISPID_IADCCTL_ONDOMAIN      = 0x00000105U,
    DISPID_IADCCTL_DEFAULTCAT    = 0x00000106U,
}

enum : HRESULT
{
    COPYENGINE_S_YES                   = HRESULT(0x00270001),
    COPYENGINE_S_NOT_HANDLED           = HRESULT(0x00270003),
    COPYENGINE_S_USER_RETRY            = HRESULT(0x00270004),
    COPYENGINE_S_USER_IGNORED          = HRESULT(0x00270005),
    COPYENGINE_S_MERGE                 = HRESULT(0x00270006),
    COPYENGINE_S_DONT_PROCESS_CHILDREN = HRESULT(0x00270008),
}

enum : HRESULT
{
    COPYENGINE_S_ALREADY_DONE       = HRESULT(0x0027000a),
    COPYENGINE_S_PENDING            = HRESULT(0x0027000b),
    COPYENGINE_S_KEEP_BOTH          = HRESULT(0x0027000c),
    COPYENGINE_S_CLOSE_PROGRAM      = HRESULT(0x0027000d),
    COPYENGINE_S_COLLISIONRESOLVED  = HRESULT(0x0027000e),
    COPYENGINE_S_PROGRESS_PAUSE     = HRESULT(0x0027000f),
    COPYENGINE_S_PENDING_DELETE     = HRESULT(0x00270010),
    COPYENGINE_S_PENDING_BATCH_COPY = HRESULT(0x00270011),
}

enum : HRESULT
{
    COPYENGINE_E_USER_CANCELLED         = HRESULT(0x80270000),
    COPYENGINE_E_CANCELLED              = HRESULT(0x80270001),
    COPYENGINE_E_REQUIRES_ELEVATION     = HRESULT(0x80270002),
    COPYENGINE_E_SAME_FILE              = HRESULT(0x80270003),
    COPYENGINE_E_DIFF_DIR               = HRESULT(0x80270004),
    COPYENGINE_E_MANY_SRC_1_DEST        = HRESULT(0x80270005),
    COPYENGINE_E_DEST_SUBTREE           = HRESULT(0x80270009),
    COPYENGINE_E_DEST_SAME_TREE         = HRESULT(0x8027000a),
    COPYENGINE_E_FLD_IS_FILE_DEST       = HRESULT(0x8027000b),
    COPYENGINE_E_FILE_IS_FLD_DEST       = HRESULT(0x8027000c),
    COPYENGINE_E_FILE_TOO_LARGE         = HRESULT(0x8027000d),
    COPYENGINE_E_REMOVABLE_FULL         = HRESULT(0x8027000e),
    COPYENGINE_E_DEST_IS_RO_CD          = HRESULT(0x8027000f),
    COPYENGINE_E_DEST_IS_RW_CD          = HRESULT(0x80270010),
    COPYENGINE_E_DEST_IS_R_CD           = HRESULT(0x80270011),
    COPYENGINE_E_DEST_IS_RO_DVD         = HRESULT(0x80270012),
    COPYENGINE_E_DEST_IS_RW_DVD         = HRESULT(0x80270013),
    COPYENGINE_E_DEST_IS_R_DVD          = HRESULT(0x80270014),
    COPYENGINE_E_SRC_IS_RO_CD           = HRESULT(0x80270015),
    COPYENGINE_E_SRC_IS_RW_CD           = HRESULT(0x80270016),
    COPYENGINE_E_SRC_IS_R_CD            = HRESULT(0x80270017),
    COPYENGINE_E_SRC_IS_RO_DVD          = HRESULT(0x80270018),
    COPYENGINE_E_SRC_IS_RW_DVD          = HRESULT(0x80270019),
    COPYENGINE_E_SRC_IS_R_DVD           = HRESULT(0x8027001a),
    COPYENGINE_E_INVALID_FILES_SRC      = HRESULT(0x8027001b),
    COPYENGINE_E_INVALID_FILES_DEST     = HRESULT(0x8027001c),
    COPYENGINE_E_PATH_TOO_DEEP_SRC      = HRESULT(0x8027001d),
    COPYENGINE_E_PATH_TOO_DEEP_DEST     = HRESULT(0x8027001e),
    COPYENGINE_E_ROOT_DIR_SRC           = HRESULT(0x8027001f),
    COPYENGINE_E_ROOT_DIR_DEST          = HRESULT(0x80270020),
    COPYENGINE_E_ACCESS_DENIED_SRC      = HRESULT(0x80270021),
    COPYENGINE_E_ACCESS_DENIED_DEST     = HRESULT(0x80270022),
    COPYENGINE_E_PATH_NOT_FOUND_SRC     = HRESULT(0x80270023),
    COPYENGINE_E_PATH_NOT_FOUND_DEST    = HRESULT(0x80270024),
    COPYENGINE_E_NET_DISCONNECT_SRC     = HRESULT(0x80270025),
    COPYENGINE_E_NET_DISCONNECT_DEST    = HRESULT(0x80270026),
    COPYENGINE_E_SHARING_VIOLATION_SRC  = HRESULT(0x80270027),
    COPYENGINE_E_SHARING_VIOLATION_DEST = HRESULT(0x80270028),
}

enum : HRESULT
{
    COPYENGINE_E_ALREADY_EXISTS_NORMAL   = HRESULT(0x80270029),
    COPYENGINE_E_ALREADY_EXISTS_READONLY = HRESULT(0x8027002a),
    COPYENGINE_E_ALREADY_EXISTS_SYSTEM   = HRESULT(0x8027002b),
    COPYENGINE_E_ALREADY_EXISTS_FOLDER   = HRESULT(0x8027002c),
}

enum : HRESULT
{
    COPYENGINE_E_STREAM_LOSS           = HRESULT(0x8027002d),
    COPYENGINE_E_EA_LOSS               = HRESULT(0x8027002e),
    COPYENGINE_E_PROPERTY_LOSS         = HRESULT(0x8027002f),
    COPYENGINE_E_PROPERTIES_LOSS       = HRESULT(0x80270030),
    COPYENGINE_E_ENCRYPTION_LOSS       = HRESULT(0x80270031),
    COPYENGINE_E_DISK_FULL             = HRESULT(0x80270032),
    COPYENGINE_E_DISK_FULL_CLEAN       = HRESULT(0x80270033),
    COPYENGINE_E_EA_NOT_SUPPORTED      = HRESULT(0x80270034),
    COPYENGINE_E_CANT_REACH_SOURCE     = HRESULT(0x80270035),
    COPYENGINE_E_RECYCLE_UNKNOWN_ERROR = HRESULT(0x80270035),
    COPYENGINE_E_RECYCLE_FORCE_NUKE    = HRESULT(0x80270036),
    COPYENGINE_E_RECYCLE_SIZE_TOO_BIG  = HRESULT(0x80270037),
    COPYENGINE_E_RECYCLE_PATH_TOO_LONG = HRESULT(0x80270038),
    COPYENGINE_E_RECYCLE_BIN_NOT_FOUND = HRESULT(0x8027003a),
}

enum : HRESULT
{
    COPYENGINE_E_NEWFILE_NAME_TOO_LONG   = HRESULT(0x8027003b),
    COPYENGINE_E_NEWFOLDER_NAME_TOO_LONG = HRESULT(0x8027003c),
}

enum : HRESULT
{
    COPYENGINE_E_DIR_NOT_EMPTY         = HRESULT(0x8027003d),
    COPYENGINE_E_FAT_MAX_IN_ROOT       = HRESULT(0x8027003e),
    COPYENGINE_E_ACCESSDENIED_READONLY = HRESULT(0x8027003f),
}

enum HRESULT COPYENGINE_E_REDIRECTED_TO_WEBPAGE = HRESULT(0x80270040);
enum HRESULT COPYENGINE_E_SERVER_BAD_FILE_TYPE = HRESULT(0x80270041);
enum HRESULT COPYENGINE_E_INTERNET_ITEM_UNAVAILABLE = HRESULT(0x80270042);

enum : HRESULT
{
    COPYENGINE_E_CANNOT_MOVE_FROM_RECYCLE_BIN = HRESULT(0x80270043),
    COPYENGINE_E_CANNOT_MOVE_SHARED_FOLDER    = HRESULT(0x80270044),
}

enum : HRESULT
{
    COPYENGINE_E_INTERNET_ITEM_STORAGE_PROVIDER_ERROR  = HRESULT(0x80270045),
    COPYENGINE_E_INTERNET_ITEM_STORAGE_PROVIDER_PAUSED = HRESULT(0x80270046),
}

enum HRESULT COPYENGINE_E_REQUIRES_EDP_CONSENT = HRESULT(0x80270047);
enum HRESULT COPYENGINE_E_BLOCKED_BY_EDP_POLICY = HRESULT(0x80270048);
enum HRESULT COPYENGINE_E_REQUIRES_EDP_CONSENT_FOR_REMOVABLE_DRIVE = HRESULT(0x80270049);
enum HRESULT COPYENGINE_E_BLOCKED_BY_EDP_FOR_REMOVABLE_DRIVE = HRESULT(0x8027004a);
enum HRESULT COPYENGINE_E_RMS_REQUIRES_EDP_CONSENT_FOR_REMOVABLE_DRIVE = HRESULT(0x8027004b);
enum HRESULT COPYENGINE_E_RMS_BLOCKED_BY_EDP_FOR_REMOVABLE_DRIVE = HRESULT(0x8027004c);
enum HRESULT COPYENGINE_E_WARNED_BY_DLP_POLICY = HRESULT(0x8027004d);
enum HRESULT COPYENGINE_E_BLOCKED_BY_DLP_POLICY = HRESULT(0x8027004e);
enum HRESULT COPYENGINE_E_SILENT_FAIL_BY_DLP_POLICY = HRESULT(0x8027004f);
enum HRESULT COPYENGINE_E_SUPPRESS_DIALOG = HRESULT(0x80270050);
enum HRESULT NETCACHE_E_NEGATIVE_CACHE = HRESULT(0x80270100);
enum HRESULT EXECUTE_E_LAUNCH_APPLICATION = HRESULT(0x80270101);
enum HRESULT SHELL_E_WRONG_BITDEPTH = HRESULT(0x80270102);
enum HRESULT LINK_E_DELETE = HRESULT(0x80270103);
enum HRESULT STORE_E_NEWER_VERSION_AVAILABLE = HRESULT(0x80270104);

enum : HRESULT
{
    E_FILE_PLACEHOLDER_NOT_INITIALIZED           = HRESULT(0x80270110),
    E_FILE_PLACEHOLDER_VERSION_MISMATCH          = HRESULT(0x80270111),
    E_FILE_PLACEHOLDER_SERVER_TIMED_OUT          = HRESULT(0x80270112),
    E_FILE_PLACEHOLDER_STORAGEPROVIDER_NOT_FOUND = HRESULT(0x80270113),
}

enum HRESULT CAMERAROLL_E_NO_DOWNSAMPLING_REQUIRED = HRESULT(0x80270120);

enum : HRESULT
{
    E_ACTIVATIONDENIED_USERCLOSE     = HRESULT(0x80270130),
    E_ACTIVATIONDENIED_SHELLERROR    = HRESULT(0x80270131),
    E_ACTIVATIONDENIED_SHELLRESTART  = HRESULT(0x80270132),
    E_ACTIVATIONDENIED_UNEXPECTED    = HRESULT(0x80270133),
    E_ACTIVATIONDENIED_SHELLNOTREADY = HRESULT(0x80270134),
}

enum : HRESULT
{
    LIBRARY_E_NO_SAVE_LOCATION       = HRESULT(0x80270200),
    LIBRARY_E_NO_ACCESSIBLE_LOCATION = HRESULT(0x80270201),
}

enum HRESULT E_USERTILE_UNSUPPORTEDFILETYPE = HRESULT(0x80270210);

enum : HRESULT
{
    E_USERTILE_CHANGEDISABLED = HRESULT(0x80270211),
    E_USERTILE_LARGEORDYNAMIC = HRESULT(0x80270212),
    E_USERTILE_VIDEOFRAMESIZE = HRESULT(0x80270213),
    E_USERTILE_FILESIZE       = HRESULT(0x80270214),
}

enum : HRESULT
{
    IMM_ACC_DOCKING_E_INSUFFICIENTHEIGHT = HRESULT(0x80270230),
    IMM_ACC_DOCKING_E_DOCKOCCUPIED       = HRESULT(0x80270231),
}

enum HRESULT IMSC_E_SHELL_COMPONENT_STARTUP_FAILURE = HRESULT(0x80270233);
enum HRESULT SHC_E_SHELL_COMPONENT_STARTUP_FAILURE = HRESULT(0x80270234);
enum HRESULT E_TILE_NOTIFICATIONS_PLATFORM_FAILURE = HRESULT(0x80270249);
enum HRESULT E_SHELL_EXTENSION_BLOCKED = HRESULT(0x80270301);
enum HRESULT E_IMAGEFEED_CHANGEDISABLED = HRESULT(0x80270310);

enum : GUID
{
    CLSID_CUrlHistory     = GUID("3c374a40-bae4-11cf-bf7d-00aa006946ee"),
    CLSID_CUrlHistoryBoth = GUID("6659983c-8476-4eb4-b78c-e5968f326ba0"),
}

enum : int
{
    ISHCUTCMDID_DOWNLOADICON      = 0x00000000,
    ISHCUTCMDID_INTSHORTCUTCREATE = 0x00000001,
    ISHCUTCMDID_COMMITHISTORY     = 0x00000002,
    ISHCUTCMDID_SETUSERAWURL      = 0x00000003,
}

enum int SFBID_PIDLCHANGED = 0x00000000;

enum : int
{
    DBCID_EMPTY      = 0x00000000,
    DBCID_ONDRAG     = 0x00000001,
    DBCID_CLSIDOFBAR = 0x00000002,
}

enum : int
{
    DBCID_RESIZE     = 0x00000003,
    DBCID_GETBAR     = 0x00000004,
    DBCID_UPDATESIZE = 0x00000005,
}

enum : int
{
    BMICON_LARGE = 0x00000000,
    BMICON_SMALL = 0x00000001,
}

enum int CTF_INSIST = 0x00000001;
enum int CTF_THREAD_REF = 0x00000002;
enum int CTF_PROCESS_REF = 0x00000004;

enum : int
{
    CTF_COINIT_STA = 0x00000008,
    CTF_COINIT     = 0x00000008,
}

enum int CTF_FREELIBANDEXIT = 0x00000010;
enum int CTF_REF_COUNTED = 0x00000020;
enum int CTF_WAIT_ALLOWCOM = 0x00000040;
enum int CTF_UNUSED = 0x00000080;
enum int CTF_INHERITWOW64 = 0x00000100;
enum int CTF_WAIT_NO_REENTRANCY = 0x00000200;
enum int CTF_KEYBOARD_LOCALE = 0x00000400;
enum int CTF_OLEINITIALIZE = 0x00000800;
enum int CTF_COINIT_MTA = 0x00001000;
enum int CTF_NOADDREFLIB = 0x00002000;

// Callbacks

alias SUBCLASSPROC = LRESULT function(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam, size_t uIdSubclass, 
                                      size_t dwRefData);
alias BFFCALLBACK = int function(HWND hwnd, uint uMsg, LPARAM lParam, LPARAM lpData);
alias LPFNDFMCALLBACK = HRESULT function(IShellFolder psf, HWND hwnd, IDataObject pdtobj, uint uMsg, WPARAM wParam, 
                                         LPARAM lParam);
alias LPFNVIEWCALLBACK = HRESULT function(IShellView psvOuter, IShellFolder psf, HWND hwndMain, uint uMsg, 
                                          WPARAM wParam, LPARAM lParam);
alias PFNCANSHAREFOLDERW = HRESULT function(const(PWSTR) pszPath);
alias PFNSHOWSHAREFOLDERUIW = HRESULT function(HWND hwndParent, const(PWSTR) pszPath);
alias DLLGETVERSIONPROC = HRESULT function(DLLVERSIONINFO* param0);
alias APPLET_PROC = int function(HWND hwndCpl, uint msg, LPARAM lParam1, LPARAM lParam2);
alias PAPPSTATE_CHANGE_ROUTINE = void function(BOOLEAN Quiesced, void* Context);
alias PAPPCONSTRAIN_CHANGE_ROUTINE = void function(BOOLEAN Constrained, void* Context);

// Structs


//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HDROP
{
    void* Value;
}

@RAIIFree!SHDestroyPropSheetExtArray
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HPSXA
{
    void* Value;
}

struct PAPPCONSTRAIN_REGISTRATION
{
    ptrdiff_t Value;
}

struct PAPPSTATE_REGISTRATION
{
    ptrdiff_t Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmgmt/ns-appmgmt-appcategoryinfo
struct APPCATEGORYINFO
{
    uint  Locale;
    PWSTR pszDescription;
    GUID  AppCategoryId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appmgmt/ns-appmgmt-appcategoryinfolist
struct APPCATEGORYINFOLIST
{
    uint             cCategory;
    APPCATEGORYINFO* pCategoryInfo;
}

version(X86_64)
{
    struct DRAGINFOA
    {
        uint  uSize;
        POINT pt;
        BOOL  fNC;
        PSTR  lpFileList;
        uint  grfKeyState;
    }
}

version(AArch64)
{
    struct DRAGINFOA
    {
        uint  uSize;
        POINT pt;
        BOOL  fNC;
        PSTR  lpFileList;
        uint  grfKeyState;
    }
}

version(X86_64)
{
    struct DRAGINFOW
    {
        uint  uSize;
        POINT pt;
        BOOL  fNC;
        PWSTR lpFileList;
        uint  grfKeyState;
    }
}

version(AArch64)
{
    struct DRAGINFOW
    {
        uint  uSize;
        POINT pt;
        BOOL  fNC;
        PWSTR lpFileList;
        uint  grfKeyState;
    }
}

version(X86_64)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-appbardata
    struct APPBARDATA
    {
        uint   cbSize;
        HWND   hWnd;
        uint   uCallbackMessage;
        uint   uEdge;
        RECT   rc;
        LPARAM lParam;
    }
}

version(AArch64)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-appbardata
    struct APPBARDATA
    {
        uint   cbSize;
        HWND   hWnd;
        uint   uCallbackMessage;
        uint   uEdge;
        RECT   rc;
        LPARAM lParam;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shfileopstructa
    struct SHFILEOPSTRUCTA
    {
        HWND        hwnd;
        uint        wFunc;
        byte*       pFrom;
        byte*       pTo;
        ushort      fFlags;
        BOOL        fAnyOperationsAborted;
        void*       hNameMappings;
        const(PSTR) lpszProgressTitle;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shfileopstructa
    struct SHFILEOPSTRUCTA
    {
        HWND        hwnd;
        uint        wFunc;
        byte*       pFrom;
        byte*       pTo;
        ushort      fFlags;
        BOOL        fAnyOperationsAborted;
        void*       hNameMappings;
        const(PSTR) lpszProgressTitle;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shfileopstructw
    struct SHFILEOPSTRUCTW
    {
        HWND         hwnd;
        uint         wFunc;
        const(PWSTR) pFrom;
        const(PWSTR) pTo;
        ushort       fFlags;
        BOOL         fAnyOperationsAborted;
        void*        hNameMappings;
        const(PWSTR) lpszProgressTitle;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shfileopstructw
    struct SHFILEOPSTRUCTW
    {
        HWND         hwnd;
        uint         wFunc;
        const(PWSTR) pFrom;
        const(PWSTR) pTo;
        ushort       fFlags;
        BOOL         fAnyOperationsAborted;
        void*        hNameMappings;
        const(PWSTR) lpszProgressTitle;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shnamemappinga
    struct SHNAMEMAPPINGA
    {
        PSTR pszOldPath;
        PSTR pszNewPath;
        int  cchOldPath;
        int  cchNewPath;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shnamemappinga
    struct SHNAMEMAPPINGA
    {
        PSTR pszOldPath;
        PSTR pszNewPath;
        int  cchOldPath;
        int  cchNewPath;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shnamemappingw
    struct SHNAMEMAPPINGW
    {
        PWSTR pszOldPath;
        PWSTR pszNewPath;
        int   cchOldPath;
        int   cchNewPath;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shnamemappingw
    struct SHNAMEMAPPINGW
    {
        PWSTR pszOldPath;
        PWSTR pszNewPath;
        int   cchOldPath;
        int   cchNewPath;
    }
}

version(X86_64)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shellexecuteinfoa
    struct SHELLEXECUTEINFOA
    {
        uint        cbSize;
        uint        fMask;
        HWND        hwnd;
        const(PSTR) lpVerb;
        const(PSTR) lpFile;
        const(PSTR) lpParameters;
        const(PSTR) lpDirectory;
        int         nShow;
        HINSTANCE   hInstApp;
        void*       lpIDList;
        const(PSTR) lpClass;
        HKEY        hkeyClass;
        uint        dwHotKey;
        union
        {
            HANDLE hIcon;
            HANDLE hMonitor;
        }
        HANDLE      hProcess;
    }
}

version(AArch64)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shellexecuteinfoa
    struct SHELLEXECUTEINFOA
    {
        uint        cbSize;
        uint        fMask;
        HWND        hwnd;
        const(PSTR) lpVerb;
        const(PSTR) lpFile;
        const(PSTR) lpParameters;
        const(PSTR) lpDirectory;
        int         nShow;
        HINSTANCE   hInstApp;
        void*       lpIDList;
        const(PSTR) lpClass;
        HKEY        hkeyClass;
        uint        dwHotKey;
        union
        {
            HANDLE hIcon;
            HANDLE hMonitor;
        }
        HANDLE      hProcess;
    }
}

version(X86_64)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shellexecuteinfow
    struct SHELLEXECUTEINFOW
    {
        uint         cbSize;
        uint         fMask;
        HWND         hwnd;
        const(PWSTR) lpVerb;
        const(PWSTR) lpFile;
        const(PWSTR) lpParameters;
        const(PWSTR) lpDirectory;
        int          nShow;
        HINSTANCE    hInstApp;
        void*        lpIDList;
        const(PWSTR) lpClass;
        HKEY         hkeyClass;
        uint         dwHotKey;
        union
        {
            HANDLE hIcon;
            HANDLE hMonitor;
        }
        HANDLE       hProcess;
    }
}

version(AArch64)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shellexecuteinfow
    struct SHELLEXECUTEINFOW
    {
        uint         cbSize;
        uint         fMask;
        HWND         hwnd;
        const(PWSTR) lpVerb;
        const(PWSTR) lpFile;
        const(PWSTR) lpParameters;
        const(PWSTR) lpDirectory;
        int          nShow;
        HINSTANCE    hInstApp;
        void*        lpIDList;
        const(PWSTR) lpClass;
        HKEY         hkeyClass;
        uint         dwHotKey;
        union
        {
            HANDLE hIcon;
            HANDLE hMonitor;
        }
        HANDLE       hProcess;
    }
}

version(X86_64)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shcreateprocessinfow
    struct SHCREATEPROCESSINFOW
    {
        uint                 cbSize;
        uint                 fMask;
        HWND                 hwnd;
        const(PWSTR)         pszFile;
        const(PWSTR)         pszParameters;
        const(PWSTR)         pszCurrentDirectory;
        HANDLE               hUserToken;
        SECURITY_ATTRIBUTES* lpProcessAttributes;
        SECURITY_ATTRIBUTES* lpThreadAttributes;
        BOOL                 bInheritHandles;
        uint                 dwCreationFlags;
        STARTUPINFOW*        lpStartupInfo;
        PROCESS_INFORMATION* lpProcessInformation;
    }
}

version(AArch64)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shcreateprocessinfow
    struct SHCREATEPROCESSINFOW
    {
        uint                 cbSize;
        uint                 fMask;
        HWND                 hwnd;
        const(PWSTR)         pszFile;
        const(PWSTR)         pszParameters;
        const(PWSTR)         pszCurrentDirectory;
        HANDLE               hUserToken;
        SECURITY_ATTRIBUTES* lpProcessAttributes;
        SECURITY_ATTRIBUTES* lpThreadAttributes;
        BOOL                 bInheritHandles;
        uint                 dwCreationFlags;
        STARTUPINFOW*        lpStartupInfo;
        PROCESS_INFORMATION* lpProcessInformation;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-associationelement
    struct ASSOCIATIONELEMENT
    {
        ASSOCCLASS   ac;
        HKEY         hkClass;
        const(PWSTR) pszClass;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-associationelement
    struct ASSOCIATIONELEMENT
    {
        ASSOCCLASS   ac;
        HKEY         hkClass;
        const(PWSTR) pszClass;
    }
}

version(X86_64)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shqueryrbinfo
    struct SHQUERYRBINFO
    {
        uint cbSize;
        long i64Size;
        long i64NumItems;
    }
}

version(AArch64)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shqueryrbinfo
    struct SHQUERYRBINFO
    {
        uint cbSize;
        long i64Size;
        long i64NumItems;
    }
}

version(X86_64)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-notifyicondataa
    struct NOTIFYICONDATAA
    {
        uint              cbSize;
        HWND              hWnd;
        uint              uID;
        NOTIFY_ICON_DATA_FLAGS uFlags;
        uint              uCallbackMessage;
        HICON             hIcon;
        CHAR[128]         szTip;
        NOTIFY_ICON_STATE dwState;
        NOTIFY_ICON_STATE dwStateMask;
        CHAR[256]         szInfo;
        union
        {
            uint uTimeout;
            uint uVersion;
        }
        CHAR[64]          szInfoTitle;
        NOTIFY_ICON_INFOTIP_FLAGS dwInfoFlags;
        GUID              guidItem;
        HICON             hBalloonIcon;
    }
}

version(AArch64)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-notifyicondataa
    struct NOTIFYICONDATAA
    {
        uint              cbSize;
        HWND              hWnd;
        uint              uID;
        NOTIFY_ICON_DATA_FLAGS uFlags;
        uint              uCallbackMessage;
        HICON             hIcon;
        CHAR[128]         szTip;
        NOTIFY_ICON_STATE dwState;
        NOTIFY_ICON_STATE dwStateMask;
        CHAR[256]         szInfo;
        union
        {
            uint uTimeout;
            uint uVersion;
        }
        CHAR[64]          szInfoTitle;
        NOTIFY_ICON_INFOTIP_FLAGS dwInfoFlags;
        GUID              guidItem;
        HICON             hBalloonIcon;
    }
}

version(X86_64)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-notifyicondataw
    struct NOTIFYICONDATAW
    {
        uint              cbSize;
        HWND              hWnd;
        uint              uID;
        NOTIFY_ICON_DATA_FLAGS uFlags;
        uint              uCallbackMessage;
        HICON             hIcon;
        wchar[128]        szTip;
        NOTIFY_ICON_STATE dwState;
        NOTIFY_ICON_STATE dwStateMask;
        wchar[256]        szInfo;
        union
        {
            uint uTimeout;
            uint uVersion;
        }
        wchar[64]         szInfoTitle;
        NOTIFY_ICON_INFOTIP_FLAGS dwInfoFlags;
        GUID              guidItem;
        HICON             hBalloonIcon;
    }
}

version(AArch64)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-notifyicondataw
    struct NOTIFYICONDATAW
    {
        uint              cbSize;
        HWND              hWnd;
        uint              uID;
        NOTIFY_ICON_DATA_FLAGS uFlags;
        uint              uCallbackMessage;
        HICON             hIcon;
        wchar[128]        szTip;
        NOTIFY_ICON_STATE dwState;
        NOTIFY_ICON_STATE dwStateMask;
        wchar[256]        szInfo;
        union
        {
            uint uTimeout;
            uint uVersion;
        }
        wchar[64]         szInfoTitle;
        NOTIFY_ICON_INFOTIP_FLAGS dwInfoFlags;
        GUID              guidItem;
        HICON             hBalloonIcon;
    }
}

version(X86_64)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-notifyiconidentifier
    struct NOTIFYICONIDENTIFIER
    {
        uint cbSize;
        HWND hWnd;
        uint uID;
        GUID guidItem;
    }
}

version(AArch64)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-notifyiconidentifier
    struct NOTIFYICONIDENTIFIER
    {
        uint cbSize;
        HWND hWnd;
        uint uID;
        GUID guidItem;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shfileinfoa
    struct SHFILEINFOA
    {
        HICON     hIcon;
        int       iIcon;
        uint      dwAttributes;
        CHAR[260] szDisplayName;
        CHAR[80]  szTypeName;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shfileinfoa
    struct SHFILEINFOA
    {
        HICON     hIcon;
        int       iIcon;
        uint      dwAttributes;
        CHAR[260] szDisplayName;
        CHAR[80]  szTypeName;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shfileinfow
    struct SHFILEINFOW
    {
        HICON      hIcon;
        int        iIcon;
        uint       dwAttributes;
        wchar[260] szDisplayName;
        wchar[80]  szTypeName;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shfileinfow
    struct SHFILEINFOW
    {
        HICON      hIcon;
        int        iIcon;
        uint       dwAttributes;
        wchar[260] szDisplayName;
        wchar[80]  szTypeName;
    }
}

version(X86_64)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shstockiconinfo
    struct SHSTOCKICONINFO
    {
        uint       cbSize;
        HICON      hIcon;
        int        iSysImageIndex;
        int        iIcon;
        wchar[260] szPath;
    }
}

version(AArch64)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shstockiconinfo
    struct SHSTOCKICONINFO
    {
        uint       cbSize;
        HICON      hIcon;
        int        iSysImageIndex;
        int        iIcon;
        wchar[260] szPath;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-open_printer_props_infoa
    struct OPEN_PRINTER_PROPS_INFOA
    {
        uint dwSize;
        PSTR pszSheetName;
        uint uSheetIndex;
        uint dwFlags;
        BOOL bModal;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-open_printer_props_infoa
    struct OPEN_PRINTER_PROPS_INFOA
    {
        uint dwSize;
        PSTR pszSheetName;
        uint uSheetIndex;
        uint dwFlags;
        BOOL bModal;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-open_printer_props_infow
    struct OPEN_PRINTER_PROPS_INFOW
    {
        uint  dwSize;
        PWSTR pszSheetName;
        uint  uSheetIndex;
        uint  dwFlags;
        BOOL  bModal;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-open_printer_props_infow
    struct OPEN_PRINTER_PROPS_INFOW
    {
        uint  dwSize;
        PWSTR pszSheetName;
        uint  uSheetIndex;
        uint  dwFlags;
        BOOL  bModal;
    }
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-helpinfo
struct HELPINFO
{
    uint           cbSize;
    HELP_INFO_TYPE iContextType;
    int            iCtrlId;
    HANDLE         hItemHandle;
    size_t         dwContextId;
    POINT          MousePos;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-multikeyhelpa
struct MULTIKEYHELPA
{
    uint    mkSize;
    CHAR    mkKeylist;
    CHAR[1] szKeyphrase; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-multikeyhelpw
struct MULTIKEYHELPW
{
    uint     mkSize;
    wchar    mkKeylist;
    wchar[1] szKeyphrase; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-helpwininfoa
struct HELPWININFOA
{
    int     wStructSize;
    int     x;
    int     y;
    int     dx;
    int     dy;
    int     wMax;
    CHAR[2] rgchMember;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-helpwininfow
struct HELPWININFOW
{
    int      wStructSize;
    int      x;
    int      y;
    int      dx;
    int      dy;
    int      wMax;
    wchar[2] rgchMember;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ns-shobjidl_core-cminvokecommandinfo
struct CMINVOKECOMMANDINFO
{
    uint        cbSize;
    uint        fMask;
    HWND        hwnd;
    const(PSTR) lpVerb;
    const(PSTR) lpParameters;
    const(PSTR) lpDirectory;
    int         nShow;
    uint        dwHotKey;
    HANDLE      hIcon;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ns-shobjidl_core-cminvokecommandinfoex
struct CMINVOKECOMMANDINFOEX
{
    uint         cbSize;
    uint         fMask;
    HWND         hwnd;
    const(PSTR)  lpVerb;
    const(PSTR)  lpParameters;
    const(PSTR)  lpDirectory;
    int          nShow;
    uint         dwHotKey;
    HANDLE       hIcon;
    const(PSTR)  lpTitle;
    const(PWSTR) lpVerbW;
    const(PWSTR) lpParametersW;
    const(PWSTR) lpDirectoryW;
    const(PWSTR) lpTitleW;
    POINT        ptInvoke;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct CMINVOKECOMMANDINFOEX_REMOTE
{
    uint         cbSize;
    uint         fMask;
    HWND         hwnd;
    const(PSTR)  lpVerbString;
    const(PSTR)  lpParameters;
    const(PSTR)  lpDirectory;
    int          nShow;
    uint         dwHotKey;
    const(PSTR)  lpTitle;
    const(PWSTR) lpVerbWString;
    const(PWSTR) lpParametersW;
    const(PWSTR) lpDirectoryW;
    const(PWSTR) lpTitleW;
    POINT        ptInvoke;
    uint         lpVerbInt;
    uint         lpVerbWInt;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ns-shobjidl_core-persist_folder_target_info
struct PERSIST_FOLDER_TARGET_INFO
{
    ITEMIDLIST* pidlTargetFolder;
    wchar[260]  szTargetParsingName;
    wchar[260]  szNetworkProvider;
    uint        dwAttributes;
    int         csidl;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ns-shobjidl_core-extrasearch
struct EXTRASEARCH
{
    GUID        guidSearch;
    wchar[80]   wszFriendlyName;
    wchar[2084] wszUrl;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ns-shobjidl_core-foldersettings
struct FOLDERSETTINGS
{
    uint ViewMode;
    uint fFlags;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ns-shobjidl_core-sv2cvw2_params
struct SV2CVW2_PARAMS
{
    uint            cbSize;
    IShellView      psvPrev;
    FOLDERSETTINGS* pfs;
    IShellBrowser   psbOwner;
    RECT*           prcView;
    const(GUID)*    pvid;
    HWND            hwndView;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ns-shobjidl_core-sortcolumn
struct SORTCOLUMN
{
    PROPERTYKEY   propkey;
    SORTDIRECTION direction;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ns-shobjidl_core-cm_columninfo
struct CM_COLUMNINFO
{
    uint      cbSize;
    uint      dwMask;
    uint      dwState;
    uint      uWidth;
    uint      uDefaultWidth;
    uint      uIdealWidth;
    wchar[80] wszName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ns-shobjidl_core-shell_item_resource
struct SHELL_ITEM_RESOURCE
{
    GUID       guidType;
    wchar[260] szName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ns-shobjidl_core-category_info
struct CATEGORY_INFO
{
    CATEGORYINFO_FLAGS cif;
    wchar[260]         wszName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ns-shobjidl_core-shdragimage
struct SHDRAGIMAGE
{
    SIZE     sizeDragImage;
    POINT    ptOffset;
    HBITMAP  hbmpDragImage;
    COLORREF crColorKey;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ns-shobjidl_core-deskbandinfo
struct DESKBANDINFO
{
    uint       dwMask;
    POINTL     ptMinSize;
    POINTL     ptMaxSize;
    POINTL     ptIntegral;
    POINTL     ptActual;
    wchar[256] wszTitle;
    uint       dwModeFlags;
    COLORREF   crBkgnd;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ns-shobjidl_core-thumbbutton
struct THUMBBUTTON
{
    THUMBBUTTONMASK  dwMask;
    uint             iId;
    uint             iBitmap;
    HICON            hIcon;
    wchar[260]       szTip;
    THUMBBUTTONFLAGS dwFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ns-shobjidl_core-bandsiteinfo
struct BANDSITEINFO
{
    uint dwMask;
    uint dwState;
    uint dwStyle;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ns-shobjidl_core-delegateitemid
struct DELEGATEITEMID
{
align (1):
    ushort   cbSize;
    ushort   wOuter;
    ushort   cbInner;
    ubyte[1] rgb; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ns-shobjidl_core-smdata
struct SMDATA
{
    uint         dwMask;
    uint         dwFlags;
    HMENU        hmenu;
    HWND         hwnd;
    uint         uId;
    uint         uIdParent;
    uint         uIdAncestor;
    IUnknown     punk;
    ITEMIDLIST*  pidlFolder;
    ITEMIDLIST*  pidlItem;
    IShellFolder psf;
    void*        pvUserData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ns-shobjidl_core-sminfo
struct SMINFO
{
    uint dwMask;
    uint dwType;
    uint dwFlags;
    int  iIcon;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ns-shobjidl_core-smcshchangenotifystruct
struct SMCSHCHANGENOTIFYSTRUCT
{
    int         lEvent;
    ITEMIDLIST* pidl1;
    ITEMIDLIST* pidl2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ns-shobjidl_core-knownfolder_definition
struct KNOWNFOLDER_DEFINITION
{
    KF_CATEGORY category;
    PWSTR       pszName;
    PWSTR       pszDescription;
    GUID        fidParent;
    PWSTR       pszRelativePath;
    PWSTR       pszParsingName;
    PWSTR       pszTooltip;
    PWSTR       pszLocalizedName;
    PWSTR       pszIcon;
    PWSTR       pszSecurity;
    uint        dwAttributes;
    uint        kfdFlags;
    GUID        ftidType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/ns-shobjidl_core-previewhandlerframeinfo
struct PREVIEWHANDLERFRAMEINFO
{
    HACCEL haccel;
    uint   cAccelEntries;
}

struct BANNER_NOTIFICATION
{
    BANNER_NOTIFICATION_EVENT event;
    const(PWSTR) providerIdentity;
    const(PWSTR) contentId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/ns-shobjidl-nstccustomdraw
struct NSTCCUSTOMDRAW
{
    IShellItem   psi;
    uint         uItemState;
    uint         nstcis;
    const(PWSTR) pszText;
    int          iImage;
    HIMAGELIST   himl;
    int          iLevel;
    int          iIndent;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-datablock_header
struct DATABLOCK_HEADER
{
align (1):
    uint cbSize;
    uint dwSignature;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-nt_console_props
struct NT_CONSOLE_PROPS
{
align (1):
    DATABLOCK_HEADER dbh;
    ushort           wFillAttribute;
    ushort           wPopupFillAttribute;
    COORD            dwScreenBufferSize;
    COORD            dwWindowSize;
    COORD            dwWindowOrigin;
    uint             nFont;
    uint             nInputBufferSize;
    COORD            dwFontSize;
    uint             uFontFamily;
    uint             uFontWeight;
    wchar[32]        FaceName;
    uint             uCursorSize;
    BOOL             bFullScreen;
    BOOL             bQuickEdit;
    BOOL             bInsertMode;
    BOOL             bAutoPosition;
    uint             uHistoryBufferSize;
    uint             uNumberOfHistoryBuffers;
    BOOL             bHistoryNoDup;
    COLORREF[16]     ColorTable;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-nt_fe_console_props
struct NT_FE_CONSOLE_PROPS
{
align (1):
    DATABLOCK_HEADER dbh;
    uint             uCodePage;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-exp_darwin_link
struct EXP_DARWIN_LINK
{
align (1):
    DATABLOCK_HEADER dbh;
    CHAR[260]        szDarwinID;
    wchar[260]       szwDarwinID;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-exp_special_folder
struct EXP_SPECIAL_FOLDER
{
align (1):
    uint cbSize;
    uint dwSignature;
    uint idSpecialFolder;
    uint cbOffset;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-exp_sz_link
struct EXP_SZ_LINK
{
align (1):
    uint       cbSize;
    uint       dwSignature;
    CHAR[260]  szTarget;
    wchar[260] swzTarget;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-exp_propertystorage
struct EXP_PROPERTYSTORAGE
{
align (1):
    uint     cbSize;
    uint     dwSignature;
    ubyte[1] abPropertyStorage; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-shfoldercustomsettings
struct SHFOLDERCUSTOMSETTINGS
{
    uint  dwSize;
    uint  dwMask;
    GUID* pvid;
    PWSTR pszWebViewTemplate;
    uint  cchWebViewTemplate;
    PWSTR pszWebViewTemplateVersion;
    PWSTR pszInfoTip;
    uint  cchInfoTip;
    GUID* pclsid;
    uint  dwFlags;
    PWSTR pszIconFile;
    uint  cchIconFile;
    int   iIconIndex;
    PWSTR pszLogo;
    uint  cchLogo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-browseinfoa
struct BROWSEINFOA
{
    HWND        hwndOwner;
    ITEMIDLIST* pidlRoot;
    PSTR        pszDisplayName;
    const(PSTR) lpszTitle;
    uint        ulFlags;
    BFFCALLBACK lpfn;
    LPARAM      lParam;
    int         iImage;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-browseinfow
struct BROWSEINFOW
{
    HWND         hwndOwner;
    ITEMIDLIST*  pidlRoot;
    PWSTR        pszDisplayName;
    const(PWSTR) lpszTitle;
    uint         ulFlags;
    BFFCALLBACK  lpfn;
    LPARAM       lParam;
    int          iImage;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-nresarray
struct NRESARRAY
{
    uint            cItems;
    NETRESOURCEA[1] nr; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-cida
struct CIDA
{
align (1):
    uint    cidl;
    uint[1] aoffset; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-filedescriptora
struct FILEDESCRIPTORA
{
align (1):
    uint      dwFlags;
    GUID      clsid;
    SIZE      sizel;
    POINTL    pointl;
    uint      dwFileAttributes;
    FILETIME  ftCreationTime;
    FILETIME  ftLastAccessTime;
    FILETIME  ftLastWriteTime;
    uint      nFileSizeHigh;
    uint      nFileSizeLow;
    CHAR[260] cFileName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-filedescriptorw
struct FILEDESCRIPTORW
{
align (1):
    uint       dwFlags;
    GUID       clsid;
    SIZE       sizel;
    POINTL     pointl;
    uint       dwFileAttributes;
    FILETIME   ftCreationTime;
    FILETIME   ftLastAccessTime;
    FILETIME   ftLastWriteTime;
    uint       nFileSizeHigh;
    uint       nFileSizeLow;
    wchar[260] cFileName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-filegroupdescriptora
struct FILEGROUPDESCRIPTORA
{
align (1):
    uint               cItems;
    FILEDESCRIPTORA[1] fgd; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-filegroupdescriptorw
struct FILEGROUPDESCRIPTORW
{
align (1):
    uint               cItems;
    FILEDESCRIPTORW[1] fgd; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-dropfiles
struct DROPFILES
{
align (1):
    uint  pFiles;
    POINT pt;
    BOOL  fNC;
    BOOL  fWide;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-file_attributes_array
struct FILE_ATTRIBUTES_ARRAY
{
align (1):
    uint    cItems;
    uint    dwSumFileAttributes;
    uint    dwProductFileAttributes;
    uint[1] rgdwFileAttributes; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-dropdescription
struct DROPDESCRIPTION
{
align (1):
    DROPIMAGETYPE type;
    wchar[260]    szMessage;
    wchar[260]    szInsert;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-shchangenotifyentry
struct SHChangeNotifyEntry
{
align (1):
    ITEMIDLIST* pidl;
    BOOL        fRecursive;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-shardappidinfo
struct SHARDAPPIDINFO
{
align (1):
    IShellItem   psi;
    const(PWSTR) pszAppID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-shardappidinfoidlist
struct SHARDAPPIDINFOIDLIST
{
align (1):
    ITEMIDLIST*  pidl;
    const(PWSTR) pszAppID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-shardappidinfolink
struct SHARDAPPIDINFOLINK
{
align (1):
    IShellLinkA  psl;
    const(PWSTR) pszAppID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-shchangedwordasidlist
struct SHChangeDWORDAsIDList
{
align (1):
    ushort cb;
    uint   dwItem1;
    uint   dwItem2;
    ushort cbZero;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-shchangeupdateimageidlist
struct SHChangeUpdateImageIDList
{
align (1):
    ushort     cb;
    int        iIconIndex;
    int        iCurIndex;
    uint       uFlags;
    uint       dwProcessID;
    wchar[260] szName;
    ushort     cbZero;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-shdescriptionid
struct SHDESCRIPTIONID
{
    uint dwDescriptionId;
    GUID clsid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-auto_scroll_data
struct AUTO_SCROLL_DATA
{
align (1):
    int      iNextSample;
    uint     dwLastScroll;
    BOOL     bFull;
    POINT[3] pts;
    uint[3]  dwTimes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-cabinetstate
struct CABINETSTATE
{
align (1):
    ushort cLength;
    ushort nVersion;
    // Native bit field: fFullPathTitle: [0], fSaveLocalView: [1], fNotShell: [2], fSimpleDefault: [3], fDontShowDescBar: [4], fNewWindowMode: [5], fShowCompColor: [6], fDontPrettyNames: [7], fAdminsCreateCommonGroups: [8], fUnusedFlags: [9-15]
    int    _bitfield0;
    uint   fMenuEnumFilter;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-openasinfo
struct OPENASINFO
{
    const(PWSTR)       pcszFile;
    const(PWSTR)       pcszClass;
    OPEN_AS_INFO_FLAGS oaifInFlags;
}

struct QCMINFO_IDMAP_PLACEMENT
{
    uint id;
    uint fFlags;
}

struct QCMINFO_IDMAP
{
    uint nMaxIds;
    QCMINFO_IDMAP_PLACEMENT[1] pIdList; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-qcminfo
struct QCMINFO
{
    HMENU hmenu;
    uint  indexMenu;
    uint  idCmdFirst;
    uint  idCmdLast;
    const(QCMINFO_IDMAP)* pIdMap;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-detailsinfo
struct DETAILSINFO
{
    ITEMIDLIST* pidl;
    int         fmt;
    int         cxChar;
    STRRET      str;
    int         iImage;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-sfvm_proppage_data
struct SFVM_PROPPAGE_DATA
{
    uint   dwReserved;
    LPFNSVADDPROPSHEETPAGE pfn;
    LPARAM lParam;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-sfvm_helptopic_data
struct SFVM_HELPTOPIC_DATA
{
    wchar[260] wszHelpFile;
    wchar[260] wszHelpTopic;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-itemspacing
struct ITEMSPACING
{
    int cxSmall;
    int cySmall;
    int cxLarge;
    int cyLarge;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-sfv_create
struct SFV_CREATE
{
    uint               cbSize;
    IShellFolder       pshf;
    IShellView         psvOuter;
    IShellFolderViewCB psfvcb;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-defcontextmenu
struct DEFCONTEXTMENU
{
    HWND           hwnd;
    IContextMenuCB pcmcb;
    ITEMIDLIST*    pidlFolder;
    IShellFolder   psf;
    uint           cidl;
    ITEMIDLIST**   apidl;
    IUnknown       punkAssociationInfo;
    uint           cKeys;
    const(HKEY)*   aKeys;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-dfmics
struct DFMICS
{
    uint                 cbSize;
    uint                 fMask;
    LPARAM               lParam;
    uint                 idCmdFirst;
    uint                 idDefMax;
    CMINVOKECOMMANDINFO* pici;
    IUnknown             punkSite;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-csfv
struct CSFV
{
    uint             cbSize;
    IShellFolder     pshf;
    IShellView       psvOuter;
    ITEMIDLIST*      pidl;
    int              lEvents;
    LPFNVIEWCALLBACK pfnCallback;
    FOLDERVIEWMODE   fvm;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-shellstatea
struct SHELLSTATEA
{
align (1):
    // Native bit field: fShowAllObjects: [0], fShowExtensions: [1], fNoConfirmRecycle: [2], fShowSysFiles: [3], fShowCompColor: [4], fDoubleClickInWebView: [5], fDesktopHTML: [6], fWin95Classic: [7], fDontPrettyPath: [8], fShowAttribCol: [9], fMapNetDrvBtn: [10], fShowInfoTip: [11], fHideIcons: [12], fWebView: [13], fFilter: [14], fShowSuperHidden: [15], fNoNetCrawling: [16]
    int  _bitfield1;
    uint dwWin95Unused;
    uint uWin95Unused;
    int  lParamSort;
    int  iSortDirection;
    uint version_;
    uint uNotUsed;
    // Native bit field: fSepProcess: [0], fStartPanelOn: [1], fShowStartPage: [2], fAutoCheckSelect: [3], fIconsOnly: [4], fShowTypeOverlay: [5], fShowStatusBar: [6], fSpareFlags: [7-15]
    int  _bitfield2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-shellstatew
struct SHELLSTATEW
{
align (1):
    // Native bit field: fShowAllObjects: [0], fShowExtensions: [1], fNoConfirmRecycle: [2], fShowSysFiles: [3], fShowCompColor: [4], fDoubleClickInWebView: [5], fDesktopHTML: [6], fWin95Classic: [7], fDontPrettyPath: [8], fShowAttribCol: [9], fMapNetDrvBtn: [10], fShowInfoTip: [11], fHideIcons: [12], fWebView: [13], fFilter: [14], fShowSuperHidden: [15], fNoNetCrawling: [16]
    int  _bitfield1;
    uint dwWin95Unused;
    uint uWin95Unused;
    int  lParamSort;
    int  iSortDirection;
    uint version_;
    uint uNotUsed;
    // Native bit field: fSepProcess: [0], fStartPanelOn: [1], fShowStartPage: [2], fAutoCheckSelect: [3], fIconsOnly: [4], fShowTypeOverlay: [5], fShowStatusBar: [6], fSpareFlags: [7-15]
    int  _bitfield2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-shellflagstate
struct SHELLFLAGSTATE
{
align (1):
    // Native bit field: fShowAllObjects: [0], fShowExtensions: [1], fNoConfirmRecycle: [2], fShowSysFiles: [3], fShowCompColor: [4], fDoubleClickInWebView: [5], fDesktopHTML: [6], fWin95Classic: [7], fDontPrettyPath: [8], fShowAttribCol: [9], fMapNetDrvBtn: [10], fShowInfoTip: [11], fHideIcons: [12], fAutoCheckSelect: [13], fIconsOnly: [14], fRestFlags: [15]
    int _bitfield0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/ns-shlobj-bandinfosfb
struct BANDINFOSFB
{
    uint         dwMask;
    uint         dwStateMask;
    uint         dwState;
    COLORREF     crBkgnd;
    COLORREF     crBtnLt;
    COLORREF     crBtnDk;
    ushort       wViewMode;
    ushort       wAlign;
    IShellFolder psf;
    ITEMIDLIST*  pidl;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/ns-shlobj-shcolumninfo
struct SHCOLUMNINFO
{
align (1):
    PROPERTYKEY scid;
    VARENUM     vt;
    uint        fmt;
    uint        cChars;
    uint        csFlags;
    wchar[80]   wszTitle;
    wchar[128]  wszDescription;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/ns-shlobj-shcolumninit
struct SHCOLUMNINIT
{
    uint       dwFlags;
    uint       dwReserved;
    wchar[260] wszFolder;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/ns-shlobj-shcolumndata
struct SHCOLUMNDATA
{
    uint       dwFlags;
    uint       dwFileAttributes;
    uint       dwReserved;
    PWSTR      pwszExt;
    wchar[260] wszFile;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/ns-shlobj-shchangeproductkeyasidlist
struct SHChangeProductKeyAsIDList
{
align (1):
    ushort    cb;
    wchar[39] wszProductKey;
    ushort    cbZero;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/ns-shlobj-tbinfo
struct TBINFO
{
    uint cbuttons;
    uint uFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/ns-shlobj-sfv_setitempos
struct SFV_SETITEMPOS
{
    ITEMIDLIST* pidl;
    POINT       pt;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/ns-shlobj-aashellmenufilename
struct AASHELLMENUFILENAME
{
    short     cbTotal;
    ubyte[12] rgbReserved;
    wchar[1]  szFileName; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/ns-shlobj-aashellmenuitem
struct AASHELLMENUITEM
{
    void*                lpReserved1;
    int                  iReserved;
    uint                 uiReserved;
    AASHELLMENUFILENAME* lpName;
    PWSTR                psz;
}

version(X86)
{
    struct DRAGINFOA
    {
    align (1):
        uint  uSize;
        POINT pt;
        BOOL  fNC;
        PSTR  lpFileList;
        uint  grfKeyState;
    }
}

version(X86)
{
    struct DRAGINFOW
    {
    align (1):
        uint  uSize;
        POINT pt;
        BOOL  fNC;
        PWSTR lpFileList;
        uint  grfKeyState;
    }
}

version(X86)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-appbardata
    struct APPBARDATA
    {
    align (1):
        uint   cbSize;
        HWND   hWnd;
        uint   uCallbackMessage;
        uint   uEdge;
        RECT   rc;
        LPARAM lParam;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shfileopstructa
    struct SHFILEOPSTRUCTA
    {
    align (1):
        HWND        hwnd;
        uint        wFunc;
        byte*       pFrom;
        byte*       pTo;
        ushort      fFlags;
        BOOL        fAnyOperationsAborted;
        void*       hNameMappings;
        const(PSTR) lpszProgressTitle;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shfileopstructw
    struct SHFILEOPSTRUCTW
    {
    align (1):
        HWND         hwnd;
        uint         wFunc;
        const(PWSTR) pFrom;
        const(PWSTR) pTo;
        ushort       fFlags;
        BOOL         fAnyOperationsAborted;
        void*        hNameMappings;
        const(PWSTR) lpszProgressTitle;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shnamemappinga
    struct SHNAMEMAPPINGA
    {
    align (1):
        PSTR pszOldPath;
        PSTR pszNewPath;
        int  cchOldPath;
        int  cchNewPath;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shnamemappingw
    struct SHNAMEMAPPINGW
    {
    align (1):
        PWSTR pszOldPath;
        PWSTR pszNewPath;
        int   cchOldPath;
        int   cchNewPath;
    }
}

version(X86)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shellexecuteinfoa
    struct SHELLEXECUTEINFOA
    {
    align (1):
        uint        cbSize;
        uint        fMask;
        HWND        hwnd;
        const(PSTR) lpVerb;
        const(PSTR) lpFile;
        const(PSTR) lpParameters;
        const(PSTR) lpDirectory;
        int         nShow;
        HINSTANCE   hInstApp;
        void*       lpIDList;
        const(PSTR) lpClass;
        HKEY        hkeyClass;
        uint        dwHotKey;
        union
        {
        align (1):
            HANDLE hIcon;
            HANDLE hMonitor;
        }
        HANDLE      hProcess;
    }
}

version(X86)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shellexecuteinfow
    struct SHELLEXECUTEINFOW
    {
    align (1):
        uint         cbSize;
        uint         fMask;
        HWND         hwnd;
        const(PWSTR) lpVerb;
        const(PWSTR) lpFile;
        const(PWSTR) lpParameters;
        const(PWSTR) lpDirectory;
        int          nShow;
        HINSTANCE    hInstApp;
        void*        lpIDList;
        const(PWSTR) lpClass;
        HKEY         hkeyClass;
        uint         dwHotKey;
        union
        {
        align (1):
            HANDLE hIcon;
            HANDLE hMonitor;
        }
        HANDLE       hProcess;
    }
}

version(X86)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shcreateprocessinfow
    struct SHCREATEPROCESSINFOW
    {
    align (1):
        uint                 cbSize;
        uint                 fMask;
        HWND                 hwnd;
        const(PWSTR)         pszFile;
        const(PWSTR)         pszParameters;
        const(PWSTR)         pszCurrentDirectory;
        HANDLE               hUserToken;
        SECURITY_ATTRIBUTES* lpProcessAttributes;
        SECURITY_ATTRIBUTES* lpThreadAttributes;
        BOOL                 bInheritHandles;
        uint                 dwCreationFlags;
        STARTUPINFOW*        lpStartupInfo;
        PROCESS_INFORMATION* lpProcessInformation;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-associationelement
    struct ASSOCIATIONELEMENT
    {
    align (1):
        ASSOCCLASS   ac;
        HKEY         hkClass;
        const(PWSTR) pszClass;
    }
}

version(X86)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shqueryrbinfo
    struct SHQUERYRBINFO
    {
    align (1):
        uint cbSize;
        long i64Size;
        long i64NumItems;
    }
}

version(X86)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-notifyicondataa
    struct NOTIFYICONDATAA
    {
    align (1):
        uint              cbSize;
        HWND              hWnd;
        uint              uID;
        NOTIFY_ICON_DATA_FLAGS uFlags;
        uint              uCallbackMessage;
        HICON             hIcon;
        CHAR[128]         szTip;
        NOTIFY_ICON_STATE dwState;
        NOTIFY_ICON_STATE dwStateMask;
        CHAR[256]         szInfo;
        union
        {
        align (1):
            uint uTimeout;
            uint uVersion;
        }
        CHAR[64]          szInfoTitle;
        NOTIFY_ICON_INFOTIP_FLAGS dwInfoFlags;
        GUID              guidItem;
        HICON             hBalloonIcon;
    }
}

version(X86)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-notifyicondataw
    struct NOTIFYICONDATAW
    {
    align (1):
        uint              cbSize;
        HWND              hWnd;
        uint              uID;
        NOTIFY_ICON_DATA_FLAGS uFlags;
        uint              uCallbackMessage;
        HICON             hIcon;
        wchar[128]        szTip;
        NOTIFY_ICON_STATE dwState;
        NOTIFY_ICON_STATE dwStateMask;
        wchar[256]        szInfo;
        union
        {
        align (1):
            uint uTimeout;
            uint uVersion;
        }
        wchar[64]         szInfoTitle;
        NOTIFY_ICON_INFOTIP_FLAGS dwInfoFlags;
        GUID              guidItem;
        HICON             hBalloonIcon;
    }
}

version(X86)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-notifyiconidentifier
    struct NOTIFYICONIDENTIFIER
    {
    align (1):
        uint cbSize;
        HWND hWnd;
        uint uID;
        GUID guidItem;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shfileinfoa
    struct SHFILEINFOA
    {
    align (1):
        HICON     hIcon;
        int       iIcon;
        uint      dwAttributes;
        CHAR[260] szDisplayName;
        CHAR[80]  szTypeName;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shfileinfow
    struct SHFILEINFOW
    {
    align (1):
        HICON      hIcon;
        int        iIcon;
        uint       dwAttributes;
        wchar[260] szDisplayName;
        wchar[80]  szTypeName;
    }
}

version(X86)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-shstockiconinfo
    struct SHSTOCKICONINFO
    {
    align (1):
        uint       cbSize;
        HICON      hIcon;
        int        iSysImageIndex;
        int        iIcon;
        wchar[260] szPath;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-open_printer_props_infoa
    struct OPEN_PRINTER_PROPS_INFOA
    {
    align (1):
        uint dwSize;
        PSTR pszSheetName;
        uint uSheetIndex;
        uint dwFlags;
        BOOL bModal;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-open_printer_props_infow
    struct OPEN_PRINTER_PROPS_INFOW
    {
    align (1):
        uint  dwSize;
        PWSTR pszSheetName;
        uint  uSheetIndex;
        uint  dwFlags;
        BOOL  bModal;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shellapi/ns-shellapi-nc_address
struct NC_ADDRESS
{
    NET_ADDRESS_INFO* pAddrInfo;
    ushort            PortNumber;
    ubyte             PrefixLength;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlwapi/ns-shlwapi-parsedurla
struct PARSEDURLA
{
    uint        cbSize;
    const(PSTR) pszProtocol;
    uint        cchProtocol;
    const(PSTR) pszSuffix;
    uint        cchSuffix;
    uint        nScheme;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlwapi/ns-shlwapi-parsedurlw
struct PARSEDURLW
{
    uint         cbSize;
    const(PWSTR) pszProtocol;
    uint         cchProtocol;
    const(PWSTR) pszSuffix;
    uint         cchSuffix;
    uint         nScheme;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlwapi/ns-shlwapi-qitab
struct QITAB
{
    const(GUID)* piid;
    uint         dwOffset;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlwapi/ns-shlwapi-dllversioninfo
struct DLLVERSIONINFO
{
    uint cbSize;
    uint dwMajorVersion;
    uint dwMinorVersion;
    uint dwBuildNumber;
    uint dwPlatformID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlwapi/ns-shlwapi-dllversioninfo2
struct DLLVERSIONINFO2
{
    DLLVERSIONINFO info1;
    uint           dwFlags;
    ulong          ullVersion;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/ns-shappmgr-appinfodata
struct APPINFODATA
{
    uint  cbSize;
    uint  dwMask;
    PWSTR pszDisplayName;
    PWSTR pszVersion;
    PWSTR pszPublisher;
    PWSTR pszProductID;
    PWSTR pszRegisteredOwner;
    PWSTR pszRegisteredCompany;
    PWSTR pszLanguage;
    PWSTR pszSupportUrl;
    PWSTR pszSupportTelephone;
    PWSTR pszHelpLink;
    PWSTR pszInstallLocation;
    PWSTR pszInstallSource;
    PWSTR pszInstallDate;
    PWSTR pszContact;
    PWSTR pszComments;
    PWSTR pszImage;
    PWSTR pszReadmeUrl;
    PWSTR pszUpdateInfoUrl;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/ns-shappmgr-slowappinfo
struct SLOWAPPINFO
{
    ulong    ullSize;
    FILETIME ftLastUsed;
    int      iTimesUsed;
    PWSTR    pszImage;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/ns-shappmgr-pubappinfo
struct PUBAPPINFO
{
    uint       cbSize;
    uint       dwMask;
    PWSTR      pszSource;
    SYSTEMTIME stAssigned;
    SYSTEMTIME stPublished;
    SYSTEMTIME stScheduled;
    SYSTEMTIME stExpire;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/ns-credentialprovider-credential_provider_field_descriptor
struct CREDENTIAL_PROVIDER_FIELD_DESCRIPTOR
{
    uint  dwFieldID;
    CREDENTIAL_PROVIDER_FIELD_TYPE cpft;
    PWSTR pszLabel;
    GUID  guidFieldType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/ns-credentialprovider-credential_provider_credential_serialization
struct CREDENTIAL_PROVIDER_CREDENTIAL_SERIALIZATION
{
    uint   ulAuthenticationPackage;
    GUID   clsidCredentialProvider;
    uint   cbSerialization;
    ubyte* rgbSerialization;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/ns-syncmgr-syncmgr_conflict_id_info
struct SYNCMGR_CONFLICT_ID_INFO
{
    BYTE_BLOB* pblobID;
    BYTE_BLOB* pblobExtra;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/ns-syncmgr-confirm_conflict_item
struct CONFIRM_CONFLICT_ITEM
{
    IShellItem2 pShellItem;
    PWSTR       pszOriginalName;
    PWSTR       pszAlternateName;
    PWSTR       pszLocationShort;
    PWSTR       pszLocationFull;
    SYNCMGR_CONFLICT_ITEM_TYPE nType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/ns-syncmgr-confirm_conflict_result_info
struct CONFIRM_CONFLICT_RESULT_INFO
{
    PWSTR pszNewName;
    uint  iItemIndex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbcache/ns-thumbcache-wts_thumbnailid
struct WTS_THUMBNAILID
{
    ubyte[16] rgbKey;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/ns-mobsync-syncmgrprogressitem
struct SYNCMGRPROGRESSITEM
{
    uint         cbSize;
    uint         mask;
    const(PWSTR) lpcStatusText;
    uint         dwStatusType;
    int          iProgValue;
    int          iMaxValue;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/ns-mobsync-syncmgrlogerrorinfo
struct SYNCMGRLOGERRORINFO
{
    uint cbSize;
    uint mask;
    uint dwSyncMgrErrorFlags;
    GUID ErrorID;
    GUID ItemID;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/ns-mobsync-syncmgritem
struct SYNCMGRITEM
{
    uint       cbSize;
    uint       dwFlags;
    GUID       ItemID;
    uint       dwItemState;
    HICON      hIcon;
    wchar[128] wszItemName;
    FILETIME   ftLastUpdate;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/ns-mobsync-syncmgrhandlerinfo
struct SYNCMGRHANDLERINFO
{
    uint      cbSize;
    HICON     hIcon;
    uint      SyncMgrHandlerFlags;
    wchar[32] wszHandlerName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tlogstg/ns-tlogstg-windowdata
struct WINDOWDATA
{
    uint        dwWindowID;
    uint        uiCP;
    ITEMIDLIST* pidl;
    PWSTR       lpszUrl;
    PWSTR       lpszUrlLocation;
    PWSTR       lpszTitle;
}

struct HLITEM
{
    uint  uHLID;
    PWSTR pwzFriendlyName;
}

struct HLTBINFO
{
    uint uDockType;
    RECT rcTbPos;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct HLBWINFO
{
    uint     cbSize;
    uint     grfHLBWIF;
    RECT     rcFramePos;
    RECT     rcDocPos;
    HLTBINFO hltbinfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/ns-shdeprecated-basebrowserdataxp
struct BASEBROWSERDATAXP
{
    HWND              _hwnd;
    ITravelLog        _ptl;
    IHlinkFrame       _phlf;
    IWebBrowser2      _pautoWB2;
    IExpDispSupportXP _pautoEDS;
    IShellService     _pautoSS;
    int               _eSecureLockIcon;
    // Native bit field: _fCreatingViewWindow: [0]
    uint              _bitfield0;
    uint              _uActivateState;
    ITEMIDLIST*       _pidlViewState;
    IOleCommandTarget _pctView;
    ITEMIDLIST*       _pidlCur;
    IShellView        _psv;
    IShellFolder      _psf;
    HWND              _hwndView;
    PWSTR             _pszTitleCur;
    ITEMIDLIST*       _pidlPending;
    IShellView        _psvPending;
    IShellFolder      _psfPending;
    HWND              _hwndViewPending;
    PWSTR             _pszTitlePending;
    BOOL              _fIsViewMSHTML;
    BOOL              _fPrivacyImpacted;
    GUID              _clsidView;
    GUID              _clsidViewPending;
    HWND              _hwndFrame;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/ns-shdeprecated-basebrowserdatalh
struct BASEBROWSERDATALH
{
    HWND              _hwnd;
    ITravelLog        _ptl;
    IHlinkFrame       _phlf;
    IWebBrowser2      _pautoWB2;
    IExpDispSupport   _pautoEDS;
    IShellService     _pautoSS;
    int               _eSecureLockIcon;
    // Native bit field: _fCreatingViewWindow: [0]
    uint              _bitfield0;
    uint              _uActivateState;
    ITEMIDLIST*       _pidlViewState;
    IOleCommandTarget _pctView;
    ITEMIDLIST*       _pidlCur;
    IShellView        _psv;
    IShellFolder      _psf;
    HWND              _hwndView;
    PWSTR             _pszTitleCur;
    ITEMIDLIST*       _pidlPending;
    IShellView        _psvPending;
    IShellFolder      _psfPending;
    HWND              _hwndViewPending;
    PWSTR             _pszTitlePending;
    BOOL              _fIsViewMSHTML;
    BOOL              _fPrivacyImpacted;
    GUID              _clsidView;
    GUID              _clsidViewPending;
    HWND              _hwndFrame;
    int               _lPhishingFilterStatus;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/ns-shdeprecated-foldersetdata
struct FOLDERSETDATA
{
    FOLDERSETTINGS _fs;
    GUID           _vidRestore;
    uint           _dwViewPriority;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/ns-shdeprecated-toolbaritem
struct TOOLBARITEM
{
    IDockingWindow ptbar;
    RECT           rcBorderTool;
    PWSTR          pwszItem;
    BOOL           fShow;
    HMONITOR       hMon;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cpl/ns-cpl-cplinfo
struct CPLINFO
{
align (1):
    int       idIcon;
    int       idName;
    int       idInfo;
    ptrdiff_t lData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cpl/ns-cpl-newcplinfoa
struct NEWCPLINFOA
{
align (1):
    uint      dwSize;
    uint      dwFlags;
    uint      dwHelpContext;
    ptrdiff_t lData;
    HICON     hIcon;
    CHAR[32]  szName;
    CHAR[64]  szInfo;
    CHAR[128] szHelpFile;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cpl/ns-cpl-newcplinfow
struct NEWCPLINFOW
{
align (1):
    uint       dwSize;
    uint       dwFlags;
    uint       dwHelpContext;
    ptrdiff_t  lData;
    HICON      hIcon;
    wchar[32]  szName;
    wchar[64]  szInfo;
    wchar[128] szHelpFile;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/profinfo/ns-profinfo-profileinfoa
struct PROFILEINFOA
{
    uint   dwSize;
    uint   dwFlags;
    PSTR   lpUserName;
    PSTR   lpProfilePath;
    PSTR   lpDefaultPath;
    PSTR   lpServerName;
    PSTR   lpPolicyPath;
    HANDLE hProfile;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/profinfo/ns-profinfo-profileinfow
struct PROFILEINFOW
{
    uint   dwSize;
    uint   dwFlags;
    PWSTR  lpUserName;
    PWSTR  lpProfilePath;
    PWSTR  lpDefaultPath;
    PWSTR  lpServerName;
    PWSTR  lpPolicyPath;
    HANDLE hProfile;
}

struct URLINVOKECOMMANDINFOA
{
    uint        dwcbSize;
    uint        dwFlags;
    HWND        hwndParent;
    const(PSTR) pcszVerb;
}

struct URLINVOKECOMMANDINFOW
{
    uint         dwcbSize;
    uint         dwFlags;
    HWND         hwndParent;
    const(PWSTR) pcszVerb;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/fileiconinit
@DllImport("SHELL32.dll")
BOOL FileIconInit(BOOL fRestoreCache);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USERENV.dll")
BOOL LoadUserProfileA(HANDLE hToken, PROFILEINFOA* lpProfileInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USERENV.dll")
BOOL LoadUserProfileW(HANDLE hToken, PROFILEINFOW* lpProfileInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USERENV.dll")
BOOL UnloadUserProfile(HANDLE hToken, HANDLE hProfile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USERENV.dll")
BOOL GetProfilesDirectoryA(PSTR lpProfileDir, uint* lpcchSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USERENV.dll")
BOOL GetProfilesDirectoryW(PWSTR lpProfileDir, uint* lpcchSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USERENV.dll")
BOOL GetProfileType(uint* dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USERENV.dll")
BOOL DeleteProfileA(const(PSTR) lpSidString, const(PSTR) lpProfilePath, const(PSTR) lpComputerName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USERENV.dll")
BOOL DeleteProfileW(const(PWSTR) lpSidString, const(PWSTR) lpProfilePath, const(PWSTR) lpComputerName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USERENV.dll")
HRESULT CreateProfile(const(PWSTR) pszUserSid, const(PWSTR) pszUserName, PWSTR pszProfilePath, uint cchProfilePath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USERENV.dll")
BOOL GetDefaultUserProfileDirectoryA(PSTR lpProfileDir, uint* lpcchSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USERENV.dll")
BOOL GetDefaultUserProfileDirectoryW(PWSTR lpProfileDir, uint* lpcchSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USERENV.dll")
BOOL GetAllUsersProfileDirectoryA(PSTR lpProfileDir, uint* lpcchSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USERENV.dll")
BOOL GetAllUsersProfileDirectoryW(PWSTR lpProfileDir, uint* lpcchSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USERENV.dll")
BOOL GetUserProfileDirectoryA(HANDLE hToken, PSTR lpProfileDir, uint* lpcchSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USERENV.dll")
BOOL GetUserProfileDirectoryW(HANDLE hToken, PWSTR lpProfileDir, uint* lpcchSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromStrRet(STRRET* pstrret, ITEMIDLIST* pidl, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToStrRet(const(PROPVARIANT)* propvar, STRRET* pstrret);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT InitVariantFromStrRet(STRRET* pstrret, ITEMIDLIST* pidl, VARIANT* pvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToStrRet(const(VARIANT)* varIn, STRRET* pstrret);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("COMCTL32.dll")
BOOL SetWindowSubclass(HWND hWnd, SUBCLASSPROC pfnSubclass, size_t uIdSubclass, size_t dwRefData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("COMCTL32.dll")
BOOL GetWindowSubclass(HWND hWnd, SUBCLASSPROC pfnSubclass, size_t uIdSubclass, size_t* pdwRefData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("COMCTL32.dll")
BOOL RemoveWindowSubclass(HWND hWnd, SUBCLASSPROC pfnSubclass, size_t uIdSubclass);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("COMCTL32.dll")
LRESULT DefSubclassProc(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
BOOL SetWindowContextHelpId(HWND param0, uint param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
uint GetWindowContextHelpId(HWND param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
BOOL SetMenuContextHelpId(HMENU param0, uint param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
uint GetMenuContextHelpId(HMENU param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
BOOL WinHelpA(HWND hWndMain, const(PSTR) lpszHelp, uint uCommand, size_t dwData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
BOOL WinHelpW(HWND hWndMain, const(PWSTR) lpszHelp, uint uCommand, size_t dwData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
ITEMIDLIST* SHSimpleIDListFromPath(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHCreateItemFromIDList(ITEMIDLIST* pidl, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHCreateItemFromParsingName(const(PWSTR) pszPath, IBindCtx pbc, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHCreateItemWithParent(ITEMIDLIST* pidlParent, IShellFolder psfParent, ITEMIDLIST* pidl, const(GUID)* riid, 
                               void** ppvItem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHCreateItemFromRelativeName(IShellItem psiParent, const(PWSTR) pszName, IBindCtx pbc, const(GUID)* riid, 
                                     void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHCreateItemInKnownFolder(const(GUID)* kfid, 
                                  /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(KNOWN_FOLDER_FLAG))], [])*/uint dwKFFlags, 
                                  const(PWSTR) pszItem, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetIDListFromObject(IUnknown punk, ITEMIDLIST** ppidl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetItemFromObject(IUnknown punk, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetNameFromIDList(ITEMIDLIST* pidl, SIGDN sigdnName, PWSTR* ppszName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetItemFromDataObject(IDataObject pdtobj, DATAOBJ_GET_ITEM_FLAGS dwFlags, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHCreateShellItemArray(ITEMIDLIST* pidlParent, IShellFolder psf, uint cidl, ITEMIDLIST** ppidl, 
                               IShellItemArray* ppsiItemArray);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHCreateShellItemArrayFromDataObject(IDataObject pdo, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHCreateShellItemArrayFromIDLists(uint cidl, ITEMIDLIST** rgpidl, IShellItemArray* ppsiItemArray);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHCreateShellItemArrayFromShellItem(IShellItem psi, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHCreateAssociationRegistration(const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHCreateDefaultExtractIcon(const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SHELL32.dll")
HRESULT SetCurrentProcessExplicitAppUserModelID(const(PWSTR) AppID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SHELL32.dll")
HRESULT GetCurrentProcessExplicitAppUserModelID(PWSTR* AppID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetTemporaryPropertyForItem(IShellItem psi, const(PROPERTYKEY)* propkey, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHSetTemporaryPropertyForItem(IShellItem psi, const(PROPERTYKEY)* propkey, const(PROPVARIANT)* propvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SHELL32.dll")
HRESULT SHShowManageLibraryUI(IShellItem psiLibrary, HWND hwndOwner, const(PWSTR) pszTitle, 
                              const(PWSTR) pszInstruction, LIBRARYMANAGEDIALOGOPTIONS lmdOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SHELL32.dll")
HRESULT SHResolveLibrary(IShellItem psiLibrary);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHAssocEnumHandlers(const(PWSTR) pszExtra, ASSOC_FILTER afFilter, IEnumAssocHandlers* ppEnumHandler);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SHELL32.dll")
HRESULT SHAssocEnumHandlersForProtocolByApplication(const(PWSTR) protocol, const(GUID)* riid, void** enumHandlers);

@DllImport("OLE32.dll")
uint HMONITOR_UserSize(uint* param0, uint param1, HMONITOR* param2);

@DllImport("OLE32.dll")
ubyte* HMONITOR_UserMarshal(uint* param0, ubyte* param1, HMONITOR* param2);

@DllImport("OLE32.dll")
ubyte* HMONITOR_UserUnmarshal(uint* param0, ubyte* param1, HMONITOR* param2);

@DllImport("OLE32.dll")
void HMONITOR_UserFree(uint* param0, HMONITOR* param1);

@DllImport("OLE32.dll")
uint HMONITOR_UserSize64(uint* param0, uint param1, HMONITOR* param2);

@DllImport("OLE32.dll")
ubyte* HMONITOR_UserMarshal64(uint* param0, ubyte* param1, HMONITOR* param2);

@DllImport("OLE32.dll")
ubyte* HMONITOR_UserUnmarshal64(uint* param0, ubyte* param1, HMONITOR* param2);

@DllImport("OLE32.dll")
void HMONITOR_UserFree64(uint* param0, HMONITOR* param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHCreateDefaultPropertiesOp(IShellItem psi, IFileOperation* ppFileOp);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHSetDefaultProperties(HWND hwnd, IShellItem psi, uint dwFileOpFlags, IFileOperationProgressSink pfops);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetMalloc(IMalloc* ppMalloc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
void* SHAlloc(size_t cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
void SHFree(void* pv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
int SHGetIconOverlayIndexA(const(PSTR) pszIconPath, int iIconIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
int SHGetIconOverlayIndexW(const(PWSTR) pszIconPath, int iIconIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
ITEMIDLIST* ILClone(ITEMIDLIST* pidl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
ITEMIDLIST* ILCloneFirst(ITEMIDLIST* pidl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
ITEMIDLIST* ILCombine(ITEMIDLIST* pidl1, ITEMIDLIST* pidl2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
void ILFree(ITEMIDLIST* pidl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
ITEMIDLIST* ILGetNext(ITEMIDLIST* pidl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
uint ILGetSize(ITEMIDLIST* pidl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
ITEMIDLIST* ILFindChild(ITEMIDLIST* pidlParent, ITEMIDLIST* pidlChild);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
ITEMIDLIST* ILFindLastID(ITEMIDLIST* pidl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL ILRemoveLastID(ITEMIDLIST* pidl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL ILIsEqual(ITEMIDLIST* pidl1, ITEMIDLIST* pidl2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL ILIsParent(ITEMIDLIST* pidl1, ITEMIDLIST* pidl2, BOOL fImmediate);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT ILSaveToStream(IStream pstm, ITEMIDLIST* pidl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT ILLoadFromStreamEx(IStream pstm, ITEMIDLIST** pidl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
ITEMIDLIST* ILCreateFromPathA(const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
ITEMIDLIST* ILCreateFromPathW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHILCreateFromPath(const(PWSTR) pszPath, ITEMIDLIST** ppidl, uint* rgfInOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
ITEMIDLIST* ILAppendID(ITEMIDLIST* pidl, SHITEMID* pmkid, BOOL fAppend);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
BOOL SHGetPathFromIDListEx(ITEMIDLIST* pidl, PWSTR pszPath, uint cchPath, GPFIDL_FLAGS uOpts);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL SHGetPathFromIDListA(ITEMIDLIST* pidl, PSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL SHGetPathFromIDListW(ITEMIDLIST* pidl, PWSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
int SHCreateDirectory(HWND hwnd, const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
int SHCreateDirectoryExA(HWND hwnd, const(PSTR) pszPath, const(SECURITY_ATTRIBUTES)* psa);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
int SHCreateDirectoryExW(HWND hwnd, const(PWSTR) pszPath, const(SECURITY_ATTRIBUTES)* psa);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHOpenFolderAndSelectItems(ITEMIDLIST* pidlFolder, uint cidl, ITEMIDLIST** apidl, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHCreateShellItem(ITEMIDLIST* pidlParent, IShellFolder psfParent, ITEMIDLIST* pidl, IShellItem* ppsi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetSpecialFolderLocation(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HWND hwnd, 
                                   int csidl, ITEMIDLIST** ppidl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
ITEMIDLIST* SHCloneSpecialIDList(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HWND hwnd, 
                                 int csidl, BOOL fCreate);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
BOOL SHGetSpecialFolderPathA(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HWND hwnd, PSTR pszPath, 
                             int csidl, BOOL fCreate);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
BOOL SHGetSpecialFolderPathW(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HWND hwnd, 
                             PWSTR pszPath, int csidl, BOOL fCreate);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
void SHFlushSFCache();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetFolderPathA(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HWND hwnd, int csidl, 
                         HANDLE hToken, uint dwFlags, PSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetFolderPathW(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HWND hwnd, int csidl, 
                         HANDLE hToken, uint dwFlags, PWSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetFolderLocation(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HWND hwnd, int csidl, 
                            HANDLE hToken, uint dwFlags, ITEMIDLIST** ppidl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHSetFolderPathA(int csidl, HANDLE hToken, uint dwFlags, const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHSetFolderPathW(int csidl, HANDLE hToken, uint dwFlags, const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetFolderPathAndSubDirA(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HWND hwnd, 
                                  int csidl, HANDLE hToken, uint dwFlags, const(PSTR) pszSubDir, PSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetFolderPathAndSubDirW(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HWND hwnd, 
                                  int csidl, HANDLE hToken, uint dwFlags, const(PWSTR) pszSubDir, PWSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetKnownFolderIDList(const(GUID)* rfid, uint dwFlags, HANDLE hToken, ITEMIDLIST** ppidl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHSetKnownFolderPath(const(GUID)* rfid, uint dwFlags, HANDLE hToken, const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetKnownFolderPath(const(GUID)* rfid, 
                             /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(KNOWN_FOLDER_FLAG))], [])*/uint dwFlags, 
                             HANDLE hToken, 
                             /*PARAM ATTR: FreeWithAttribute : CustomAttributeSig([FixedArgSig(ElementSig(CoTaskMemFree))], [])*/PWSTR* ppszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetKnownFolderItem(const(GUID)* rfid, KNOWN_FOLDER_FLAG flags, HANDLE hToken, const(GUID)* riid, 
                             void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetSetFolderCustomSettings(SHFOLDERCUSTOMSETTINGS* pfcs, const(PWSTR) pszPath, uint dwReadWrite);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
ITEMIDLIST* SHBrowseForFolderA(BROWSEINFOA* lpbi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
ITEMIDLIST* SHBrowseForFolderW(BROWSEINFOW* lpbi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHLoadInProc(const(GUID)* rclsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetDesktopFolder(IShellFolder* ppshf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
void SHChangeNotify(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(SHCNE_ID))], [])*/int wEventId, 
                    SHCNF_FLAGS uFlags, const(void)* dwItem1, const(void)* dwItem2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
void SHAddToRecentDocs(uint uFlags, const(void)* pv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
int SHHandleUpdateImage(ITEMIDLIST* pidlExtra);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
void SHUpdateImageA(const(PSTR) pszHashItem, int iIndex, uint uFlags, int iImageIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
void SHUpdateImageW(const(PWSTR) pszHashItem, int iIndex, uint uFlags, int iImageIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
uint SHChangeNotifyRegister(HWND hwnd, SHCNRF_SOURCE fSources, int fEvents, uint wMsg, int cEntries, 
                            const(SHChangeNotifyEntry)* pshcne);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL SHChangeNotifyDeregister(uint ulID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HANDLE SHChangeNotification_Lock(HANDLE hChange, uint dwProcId, ITEMIDLIST*** pppidl, int* plEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
BOOL SHChangeNotification_Unlock(HANDLE hLock);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetRealIDL(IShellFolder psf, ITEMIDLIST* pidlSimple, ITEMIDLIST** ppidlReal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetInstanceExplorer(IUnknown* ppunk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetDataFromIDListA(IShellFolder psf, ITEMIDLIST* pidl, SHGDFIL_FORMAT nFormat, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pv, 
                             int cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetDataFromIDListW(IShellFolder psf, ITEMIDLIST* pidl, SHGDFIL_FORMAT nFormat, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pv, 
                             int cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
int RestartDialog(HWND hwnd, const(PWSTR) pszPrompt, uint dwReturn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
int RestartDialogEx(HWND hwnd, const(PWSTR) pszPrompt, uint dwReturn, uint dwReasonCode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHCoCreateInstance(const(PWSTR) pszCLSID, const(GUID)* pclsid, IUnknown pUnkOuter, const(GUID)* riid, 
                           void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHCreateDataObject(ITEMIDLIST* pidlFolder, uint cidl, ITEMIDLIST** apidl, IDataObject pdtInner, 
                           const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HRESULT CIDLData_CreateFromIDArray(ITEMIDLIST* pidlFolder, uint cidl, ITEMIDLIST** apidl, IDataObject* ppdtobj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHCreateStdEnumFmtEtc(uint cfmt, const(FORMATETC)* afmt, IEnumFORMATETC* ppenumFormatEtc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHDoDragDrop(HWND hwnd, IDataObject pdata, IDropSource pdsrc, DROPEFFECT dwEffect, DROPEFFECT* pdwEffect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
BOOL DAD_SetDragImage(HIMAGELIST him, POINT* pptOffset);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
BOOL DAD_DragEnterEx(HWND hwndTarget, const(POINT) ptStart);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
BOOL DAD_DragEnterEx2(HWND hwndTarget, const(POINT) ptStart, IDataObject pdtObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
BOOL DAD_ShowDragImage(BOOL fShow);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
BOOL DAD_DragMove(POINT pt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
BOOL DAD_DragLeave();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
BOOL DAD_AutoScroll(HWND hwnd, AUTO_SCROLL_DATA* pad, const(POINT)* pptNow);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL ReadCabinetState(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/CABINETSTATE* pcs, 
                      int cLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL WriteCabinetState(CABINETSTATE* pcs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
BOOL PathMakeUniqueName(PWSTR pszUniqueName, uint cchMax, const(PWSTR) pszTemplate, const(PWSTR) pszLongPlate, 
                        const(PWSTR) pszDir);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL PathIsExe(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
int PathCleanupSpec(const(PWSTR) pszDir, PWSTR pszSpec);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
int PathResolve(PWSTR pszPath, ushort** dirs, 
                /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(PRF_FLAGS))], [])*/uint fFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
BOOL GetFileNameFromBrowse(HWND hwnd, PWSTR pszFilePath, uint cchFilePath, const(PWSTR) pszWorkingDir, 
                           const(PWSTR) pszDefExt, const(PWSTR) pszFilters, const(PWSTR) pszTitle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
int DriveType(int iDrive);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
int RealDriveType(int iDrive, BOOL fOKToHitNet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
int IsNetDrive(int iDrive);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
uint Shell_MergeMenus(HMENU hmDst, HMENU hmSrc, uint uInsert, uint uIDAdjust, uint uIDAdjustMax, MM_FLAGS uFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL SHObjectProperties(HWND hwnd, 
                        /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(SHOP_TYPE))], [])*/uint shopObjectType, 
                        const(PWSTR) pszObjectName, const(PWSTR) pszPropertyPage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
uint SHFormatDrive(HWND hwnd, uint drive, SHFMT_ID fmtID, 
                   /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(SHFMT_OPT))], [])*/uint options);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
void SHDestroyPropSheetExtArray(HPSXA hpsxa);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
uint SHAddFromPropSheetExtArray(HPSXA hpsxa, LPFNSVADDPROPSHEETPAGE lpfnAddPage, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
uint SHReplaceFromPropSheetExtArray(HPSXA hpsxa, uint uPageID, LPFNSVADDPROPSHEETPAGE lpfnReplaceWith, 
                                    LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
IStream OpenRegStream(HKEY hkey, const(PWSTR) pszSubkey, const(PWSTR) pszValue, uint grfMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL SHFindFiles(ITEMIDLIST* pidlFolder, ITEMIDLIST* pidlSaveFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
void PathGetShortPath(PWSTR pszLongPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
BOOL PathYetAnotherMakeUniqueName(PWSTR pszUniqueName, const(PWSTR) pszPath, const(PWSTR) pszShort, 
                                  const(PWSTR) pszFileSpec);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL Win32DeleteFile(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
uint SHRestricted(RESTRICTIONS rest);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL SignalFileOpen(ITEMIDLIST* pidl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT AssocGetDetailsOfPropKey(IShellFolder psf, ITEMIDLIST* pidl, const(PROPERTYKEY)* pkey, VARIANT* pv, 
                                 BOOL* pfFoundPropKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHStartNetConnectionDialogW(HWND hwnd, const(PWSTR) pszRemoteName, uint dwType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHDefExtractIconA(const(PSTR) pszIconFile, int iIndex, uint uFlags, HICON* phiconLarge, HICON* phiconSmall, 
                          uint nIconSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHDefExtractIconW(const(PWSTR) pszIconFile, int iIndex, uint uFlags, HICON* phiconLarge, 
                          HICON* phiconSmall, uint nIconSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHOpenWithDialog(HWND hwndParent, const(OPENASINFO)* poainfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL Shell_GetImageLists(HIMAGELIST* phiml, HIMAGELIST* phimlSmall);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
int Shell_GetCachedImageIndex(const(PWSTR) pwszIconPath, int iIconIndex, uint uIconFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
int Shell_GetCachedImageIndexA(const(PSTR) pszIconPath, int iIconIndex, uint uIconFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
int Shell_GetCachedImageIndexW(const(PWSTR) pszIconPath, int iIconIndex, uint uIconFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL SHValidateUNC(HWND hwndOwner, PWSTR pszFile, 
                   /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(VALIDATEUNC_OPTION))], [])*/uint fConnect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
void SHSetInstanceExplorer(IUnknown punk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL IsUserAnAdmin();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
LRESULT SHShellFolderView_Message(HWND hwndMain, uint uMsg, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HRESULT SHCreateShellFolderView(const(SFV_CREATE)* pcsfv, IShellView* ppsv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HRESULT CDefFolderMenu_Create2(ITEMIDLIST* pidlFolder, HWND hwnd, uint cidl, ITEMIDLIST** apidl, IShellFolder psf, 
                               LPFNDFMCALLBACK pfn, uint nKeys, const(HKEY)* ahkeys, IContextMenu* ppcm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHCreateDefaultContextMenu(const(DEFCONTEXTMENU)* pdcm, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
IContextMenu SHFind_InitMenuPopup(HMENU hmenu, HWND hwndOwner, uint idCmdFirst, uint idCmdLast);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HRESULT SHCreateShellFolderViewEx(CSFV* pcsfv, IShellView* ppsv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
void SHGetSetSettings(SHELLSTATEA* lpss, SSF_MASK dwMask, BOOL bSet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
void SHGetSettings(SHELLFLAGSTATE* psfs, uint dwMask);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HRESULT SHBindToParent(ITEMIDLIST* pidl, const(GUID)* riid, void** ppv, ITEMIDLIST** ppidlLast);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHBindToFolderIDListParent(IShellFolder psfRoot, ITEMIDLIST* pidl, const(GUID)* riid, void** ppv, 
                                   ITEMIDLIST** ppidlLast);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHBindToFolderIDListParentEx(IShellFolder psfRoot, ITEMIDLIST* pidl, IBindCtx ppbc, const(GUID)* riid, 
                                     void** ppv, ITEMIDLIST** ppidlLast);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHBindToObject(IShellFolder psf, ITEMIDLIST* pidl, IBindCtx pbc, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHParseDisplayName(const(PWSTR) pszName, IBindCtx pbc, ITEMIDLIST** ppidl, uint sfgaoIn, uint* psfgaoOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HRESULT SHPathPrepareForWriteA(HWND hwnd, IUnknown punkEnableModless, const(PSTR) pszPath, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HRESULT SHPathPrepareForWriteW(HWND hwnd, IUnknown punkEnableModless, const(PWSTR) pszPath, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHCreateFileExtractIconW(const(PWSTR) pszFile, uint dwFileAttributes, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HRESULT SHLimitInputEdit(HWND hwndEdit, IShellFolder psf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetAttributesFromDataObject(IDataObject pdo, uint dwAttributeMask, uint* pdwAttributes, uint* pcItems);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
int SHMapPIDLToSystemImageListIndex(IShellFolder pshf, ITEMIDLIST* pidl, int* piIndexSel);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HRESULT SHCLSIDFromString(const(PWSTR) psz, GUID* pclsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
int PickIconDlg(HWND hwnd, PWSTR pszIconPath, uint cchIconPath, int* piIconIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SHELL32.dll")
HRESULT StgMakeUniqueName(IStorage pstgParent, const(PWSTR) pszFileSpec, uint grfMode, const(GUID)* riid, 
                          void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
void SHChangeNotifyRegisterThread(SCNRT_STATUS status);

@DllImport("SHELL32.dll")
void PathQualify(PWSTR psz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL PathIsSlowA(const(PSTR) pszFile, uint dwAttr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL PathIsSlowW(const(PWSTR) pszFile, uint dwAttr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HPSXA SHCreatePropSheetExtArray(HKEY hKey, const(PWSTR) pszSubKey, uint max_iface);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL SHOpenPropSheetW(const(PWSTR) pszCaption, HKEY* ahkeys, uint ckeys, const(GUID)* pclsidDefault, 
                      IDataObject pdtobj, IShellBrowser psb, const(PWSTR) pStartPage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHDOCVW.dll")
uint SoftwareUpdateMessageBox(HWND hWnd, const(PWSTR) pszDistUnit, uint dwFlags, SOFTDISTINFO* psdi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HRESULT SHMultiFileProperties(IDataObject pdtobj, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHCreateQueryCancelAutoPlayMoniker(IMoniker* ppmoniker);

@DllImport("SHDOCVW.dll")
BOOL ImportPrivacySettings(const(PWSTR) pszFilename, BOOL* pfParsePrivacyPreferences, BOOL* pfParsePerSiteRules);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-shcore-scaling-l1-1-0.dll")
DEVICE_SCALE_FACTOR GetScaleFactorForDevice(DISPLAY_DEVICE_TYPE deviceType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-shcore-scaling-l1-1-0.dll")
HRESULT RegisterScaleChangeNotifications(DISPLAY_DEVICE_TYPE displayDevice, HWND hwndNotify, uint uMsgNotify, 
                                         uint* pdwCookie);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-shcore-scaling-l1-1-0.dll")
HRESULT RevokeScaleChangeNotifications(DISPLAY_DEVICE_TYPE displayDevice, uint dwCookie);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("api-ms-win-shcore-scaling-l1-1-1.dll")
HRESULT GetScaleFactorForMonitor(HMONITOR hMon, DEVICE_SCALE_FACTOR* pScale);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("api-ms-win-shcore-scaling-l1-1-1.dll")
HRESULT RegisterScaleChangeEvent(HANDLE hEvent, size_t* pdwCookie);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("api-ms-win-shcore-scaling-l1-1-1.dll")
HRESULT UnregisterScaleChangeEvent(size_t dwCookie);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("api-ms-win-shcore-scaling-l1-1-2.dll")
uint GetDpiForShellUIComponent(SHELL_UI_COMPONENT param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
PWSTR* CommandLineToArgvW(const(PWSTR) lpCmdLine, int* pNumArgs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
uint DragQueryFileA(HDROP hDrop, uint iFile, PSTR lpszFile, uint cch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
uint DragQueryFileW(HDROP hDrop, uint iFile, PWSTR lpszFile, uint cch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL DragQueryPoint(HDROP hDrop, POINT* ppt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
void DragFinish(HDROP hDrop);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
void DragAcceptFiles(HWND hWnd, BOOL fAccept);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HINSTANCE ShellExecuteA(HWND hwnd, const(PSTR) lpOperation, const(PSTR) lpFile, const(PSTR) lpParameters, 
                        const(PSTR) lpDirectory, SHOW_WINDOW_CMD nShowCmd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HINSTANCE ShellExecuteW(HWND hwnd, const(PWSTR) lpOperation, const(PWSTR) lpFile, const(PWSTR) lpParameters, 
                        const(PWSTR) lpDirectory, SHOW_WINDOW_CMD nShowCmd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HINSTANCE FindExecutableA(const(PSTR) lpFile, const(PSTR) lpDirectory, PSTR lpResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HINSTANCE FindExecutableW(const(PWSTR) lpFile, const(PWSTR) lpDirectory, PWSTR lpResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
int ShellAboutA(HWND hWnd, const(PSTR) szApp, const(PSTR) szOtherStuff, HICON hIcon);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
int ShellAboutW(HWND hWnd, const(PWSTR) szApp, const(PWSTR) szOtherStuff, HICON hIcon);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HICON DuplicateIcon(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HINSTANCE hInst, HICON hIcon);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HICON ExtractAssociatedIconA(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HINSTANCE hInst, 
                             PSTR pszIconPath, ushort* piIcon);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HICON ExtractAssociatedIconW(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HINSTANCE hInst, 
                             PWSTR pszIconPath, ushort* piIcon);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HICON ExtractAssociatedIconExA(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HINSTANCE hInst, 
                               PSTR pszIconPath, ushort* piIconIndex, ushort* piIconId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HICON ExtractAssociatedIconExW(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HINSTANCE hInst, 
                               PWSTR pszIconPath, ushort* piIconIndex, ushort* piIconId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HICON ExtractIconA(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HINSTANCE hInst, 
                   const(PSTR) pszExeFileName, uint nIconIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HICON ExtractIconW(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HINSTANCE hInst, 
                   const(PWSTR) pszExeFileName, uint nIconIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
size_t SHAppBarMessage(uint dwMessage, APPBARDATA* pData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
uint DoEnvironmentSubstA(PSTR pszSrc, uint cchSrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
uint DoEnvironmentSubstW(PWSTR pszSrc, uint cchSrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
uint ExtractIconExA(const(PSTR) lpszFile, int nIconIndex, HICON* phiconLarge, HICON* phiconSmall, uint nIcons);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
uint ExtractIconExW(const(PWSTR) lpszFile, int nIconIndex, HICON* phiconLarge, HICON* phiconSmall, uint nIcons);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
int SHFileOperationA(SHFILEOPSTRUCTA* lpFileOp);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
int SHFileOperationW(SHFILEOPSTRUCTW* lpFileOp);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
void SHFreeNameMappings(HANDLE hNameMappings);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL ShellExecuteExA(SHELLEXECUTEINFOA* pExecInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL ShellExecuteExW(SHELLEXECUTEINFOW* pExecInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
BOOL SHCreateProcessAsUserW(SHCREATEPROCESSINFOW* pscpi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHEvaluateSystemCommandTemplate(const(PWSTR) pszCmdTemplate, PWSTR* ppszApplication, 
                                        PWSTR* ppszCommandLine, PWSTR* ppszParameters);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT AssocCreateForClasses(const(ASSOCIATIONELEMENT)* rgClasses, uint cClasses, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HRESULT SHQueryRecycleBinA(const(PSTR) pszRootPath, SHQUERYRBINFO* pSHQueryRBInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HRESULT SHQueryRecycleBinW(const(PWSTR) pszRootPath, SHQUERYRBINFO* pSHQueryRBInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HRESULT SHEmptyRecycleBinA(HWND hwnd, const(PSTR) pszRootPath, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HRESULT SHEmptyRecycleBinW(HWND hwnd, const(PWSTR) pszRootPath, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHQueryUserNotificationState(QUERY_USER_NOTIFICATION_STATE* pquns);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL Shell_NotifyIconA(NOTIFY_ICON_MESSAGE dwMessage, NOTIFYICONDATAA* lpData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL Shell_NotifyIconW(NOTIFY_ICON_MESSAGE dwMessage, NOTIFYICONDATAW* lpData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SHELL32.dll")
HRESULT Shell_NotifyIconGetRect(const(NOTIFYICONIDENTIFIER)* identifier, RECT* iconLocation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
size_t SHGetFileInfoA(const(PSTR) pszPath, FILE_FLAGS_AND_ATTRIBUTES dwFileAttributes, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/SHFILEINFOA* psfi, 
                      uint cbFileInfo, SHGFI_FLAGS uFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
size_t SHGetFileInfoW(const(PWSTR) pszPath, FILE_FLAGS_AND_ATTRIBUTES dwFileAttributes, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/SHFILEINFOW* psfi, 
                      uint cbFileInfo, SHGFI_FLAGS uFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetStockIconInfo(SHSTOCKICONID siid, SHGSI_FLAGS uFlags, SHSTOCKICONINFO* psii);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
BOOL SHGetDiskFreeSpaceExA(const(PSTR) pszDirectoryName, ulong* pulFreeBytesAvailableToCaller, 
                           ulong* pulTotalNumberOfBytes, ulong* pulTotalNumberOfFreeBytes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
BOOL SHGetDiskFreeSpaceExW(const(PWSTR) pszDirectoryName, ulong* pulFreeBytesAvailableToCaller, 
                           ulong* pulTotalNumberOfBytes, ulong* pulTotalNumberOfFreeBytes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
BOOL SHGetNewLinkInfoA(const(PSTR) pszLinkTo, const(PSTR) pszDir, PSTR pszName, BOOL* pfMustCopy, uint uFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
BOOL SHGetNewLinkInfoW(const(PWSTR) pszLinkTo, const(PWSTR) pszDir, PWSTR pszName, BOOL* pfMustCopy, uint uFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
BOOL SHInvokePrinterCommandA(HWND hwnd, uint uAction, const(PSTR) lpBuf1, const(PSTR) lpBuf2, BOOL fModal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
BOOL SHInvokePrinterCommandW(HWND hwnd, uint uAction, const(PWSTR) lpBuf1, const(PWSTR) lpBuf2, BOOL fModal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HRESULT SHLoadNonloadedIconOverlayIdentifiers();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHELL32.dll")
HRESULT SHIsFileAvailableOffline(const(PWSTR) pwszPath, uint* pdwStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHSetLocalizedName(const(PWSTR) pszPath, const(PWSTR) pszResModule, int idsRes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHRemoveLocalizedName(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetLocalizedName(const(PWSTR) pszPath, PWSTR pszResModule, uint cch, int* pidsRes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
int ShellMessageBoxA(HINSTANCE hAppInst, HWND hWnd, const(PSTR) lpcText, const(PSTR) lpcTitle, 
                     MESSAGEBOX_STYLE fuStyle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
int ShellMessageBoxW(HINSTANCE hAppInst, HWND hWnd, const(PWSTR) lpcText, const(PWSTR) lpcTitle, 
                     MESSAGEBOX_STYLE fuStyle);

@DllImport("SHELL32.dll")
BOOL IsLFNDriveA(const(PSTR) pszPath);

@DllImport("SHELL32.dll")
BOOL IsLFNDriveW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHEnumerateUnreadMailAccountsW(HKEY hKeyUser, uint dwIndex, PWSTR pszMailAddress, int cchMailAddress);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetUnreadMailCountW(HKEY hKeyUser, const(PWSTR) pszMailAddress, uint* pdwCount, FILETIME* pFileTime, 
                              PWSTR pszShellExecuteCommand, int cchShellExecuteCommand);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHSetUnreadMailCountW(const(PWSTR) pszMailAddress, uint dwCount, const(PWSTR) pszShellExecuteCommand);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
BOOL SHTestTokenMembership(HANDLE hToken, uint ulRID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetImageList(int iImageList, const(GUID)* riid, void** ppvObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
BOOL InitNetworkAddressControl();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetDriveMedia(const(PWSTR) pszDrive, uint* pdwMediaContent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR StrChrA(const(PSTR) pszStart, ushort wMatch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR StrChrW(const(PWSTR) pszStart, wchar wMatch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR StrChrIA(const(PSTR) pszStart, ushort wMatch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR StrChrIW(const(PWSTR) pszStart, wchar wMatch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
PWSTR StrChrNW(const(PWSTR) pszStart, wchar wMatch, uint cchMax);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHLWAPI.dll")
PWSTR StrChrNIW(const(PWSTR) pszStart, wchar wMatch, uint cchMax);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrCmpNA(const(PSTR) psz1, const(PSTR) psz2, int nChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrCmpNW(const(PWSTR) psz1, const(PWSTR) psz2, int nChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrCmpNIA(const(PSTR) psz1, const(PSTR) psz2, int nChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrCmpNIW(const(PWSTR) psz1, const(PWSTR) psz2, int nChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrCSpnA(const(PSTR) pszStr, const(PSTR) pszSet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrCSpnW(const(PWSTR) pszStr, const(PWSTR) pszSet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrCSpnIA(const(PSTR) pszStr, const(PSTR) pszSet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrCSpnIW(const(PWSTR) pszStr, const(PWSTR) pszSet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR StrDupA(const(PSTR) pszSrch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR StrDupW(const(PWSTR) pszSrch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHLWAPI.dll")
HRESULT StrFormatByteSizeEx(ulong ull, SFBS_FLAGS flags, PWSTR pszBuf, uint cchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR StrFormatByteSizeA(uint dw, PSTR pszBuf, uint cchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR StrFormatByteSize64A(long qdw, PSTR pszBuf, uint cchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR StrFormatByteSizeW(long qdw, PWSTR pszBuf, uint cchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR StrFormatKBSizeW(long qdw, PWSTR pszBuf, uint cchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR StrFormatKBSizeA(long qdw, PSTR pszBuf, uint cchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrFromTimeIntervalA(PSTR pszOut, uint cchMax, uint dwTimeMS, int digits);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrFromTimeIntervalW(PWSTR pszOut, uint cchMax, uint dwTimeMS, int digits);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL StrIsIntlEqualA(BOOL fCaseSens, const(PSTR) pszString1, const(PSTR) pszString2, int nChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL StrIsIntlEqualW(BOOL fCaseSens, const(PWSTR) pszString1, const(PWSTR) pszString2, int nChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR StrNCatA(PSTR psz1, const(PSTR) psz2, int cchMax);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR StrNCatW(PWSTR psz1, const(PWSTR) psz2, int cchMax);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR StrPBrkA(const(PSTR) psz, const(PSTR) pszSet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR StrPBrkW(const(PWSTR) psz, const(PWSTR) pszSet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR StrRChrA(const(PSTR) pszStart, const(PSTR) pszEnd, ushort wMatch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR StrRChrW(const(PWSTR) pszStart, const(PWSTR) pszEnd, wchar wMatch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR StrRChrIA(const(PSTR) pszStart, const(PSTR) pszEnd, ushort wMatch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR StrRChrIW(const(PWSTR) pszStart, const(PWSTR) pszEnd, wchar wMatch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR StrRStrIA(const(PSTR) pszSource, const(PSTR) pszLast, const(PSTR) pszSrch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR StrRStrIW(const(PWSTR) pszSource, const(PWSTR) pszLast, const(PWSTR) pszSrch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrSpnA(const(PSTR) psz, const(PSTR) pszSet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrSpnW(const(PWSTR) psz, const(PWSTR) pszSet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR StrStrA(const(PSTR) pszFirst, const(PSTR) pszSrch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR StrStrW(const(PWSTR) pszFirst, const(PWSTR) pszSrch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR StrStrIA(const(PSTR) pszFirst, const(PSTR) pszSrch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR StrStrIW(const(PWSTR) pszFirst, const(PWSTR) pszSrch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHLWAPI.dll")
PWSTR StrStrNW(const(PWSTR) pszFirst, const(PWSTR) pszSrch, uint cchMax);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHLWAPI.dll")
PWSTR StrStrNIW(const(PWSTR) pszFirst, const(PWSTR) pszSrch, uint cchMax);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrToIntA(const(PSTR) pszSrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrToIntW(const(PWSTR) pszSrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL StrToIntExA(const(PSTR) pszString, int dwFlags, int* piRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL StrToIntExW(const(PWSTR) pszString, int dwFlags, int* piRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL StrToInt64ExA(const(PSTR) pszString, int dwFlags, long* pllRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL StrToInt64ExW(const(PWSTR) pszString, int dwFlags, long* pllRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL StrTrimA(PSTR psz, const(PSTR) pszTrimChars);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL StrTrimW(PWSTR psz, const(PWSTR) pszTrimChars);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR StrCatW(PWSTR psz1, const(PWSTR) psz2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrCmpW(const(PWSTR) psz1, const(PWSTR) psz2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrCmpIW(const(PWSTR) psz1, const(PWSTR) psz2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR StrCpyW(PWSTR psz1, const(PWSTR) psz2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR StrCpyNW(PWSTR pszDst, const(PWSTR) pszSrc, int cchMax);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR StrCatBuffW(PWSTR pszDest, const(PWSTR) pszSrc, int cchDestBuffSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR StrCatBuffA(PSTR pszDest, const(PSTR) pszSrc, int cchDestBuffSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL ChrCmpIA(ushort w1, ushort w2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL ChrCmpIW(wchar w1, wchar w2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int wvnsprintfA(PSTR pszDest, int cchDest, const(PSTR) pszFmt, byte* arglist);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int wvnsprintfW(PWSTR pszDest, int cchDest, const(PWSTR) pszFmt, byte* arglist);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int wnsprintfA(PSTR pszDest, int cchDest, const(PSTR) pszFmt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int wnsprintfW(PWSTR pszDest, int cchDest, const(PWSTR) pszFmt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT StrRetToStrA(STRRET* pstr, ITEMIDLIST* pidl, PSTR* ppsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT StrRetToStrW(STRRET* pstr, ITEMIDLIST* pidl, PWSTR* ppsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT StrRetToBufA(STRRET* pstr, ITEMIDLIST* pidl, PSTR pszBuf, uint cchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT StrRetToBufW(STRRET* pstr, ITEMIDLIST* pidl, PWSTR pszBuf, uint cchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT SHStrDupA(const(PSTR) psz, PWSTR* ppwsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT SHStrDupW(const(PWSTR) psz, PWSTR* ppwsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
int StrCmpLogicalW(const(PWSTR) psz1, const(PWSTR) psz2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
uint StrCatChainW(PWSTR pszDst, uint cchDst, uint ichAt, const(PWSTR) pszSrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
HRESULT StrRetToBSTR(STRRET* pstr, ITEMIDLIST* pidl, BSTR* pbstr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
HRESULT SHLoadIndirectString(const(PWSTR) pszSource, PWSTR pszOutBuf, uint cchOutBuf, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void** ppvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL IsCharSpaceA(CHAR wch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL IsCharSpaceW(wchar wch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrCmpCA(const(PSTR) pszStr1, const(PSTR) pszStr2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrCmpCW(const(PWSTR) pszStr1, const(PWSTR) pszStr2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrCmpICA(const(PSTR) pszStr1, const(PSTR) pszStr2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrCmpICW(const(PWSTR) pszStr1, const(PWSTR) pszStr2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrCmpNCA(const(PSTR) pszStr1, const(PSTR) pszStr2, int nChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrCmpNCW(const(PWSTR) pszStr1, const(PWSTR) pszStr2, int nChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrCmpNICA(const(PSTR) pszStr1, const(PSTR) pszStr2, int nChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int StrCmpNICW(const(PWSTR) pszStr1, const(PWSTR) pszStr2, int nChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL IntlStrEqWorkerA(BOOL fCaseSens, const(PSTR) lpString1, const(PSTR) lpString2, int nChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL IntlStrEqWorkerW(BOOL fCaseSens, const(PWSTR) lpString1, const(PWSTR) lpString2, int nChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR PathAddBackslashA(PSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR PathAddBackslashW(PWSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathAddExtensionA(PSTR pszPath, const(PSTR) pszExt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathAddExtensionW(PWSTR pszPath, const(PWSTR) pszExt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathAppendA(PSTR pszPath, const(PSTR) pszMore);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathAppendW(PWSTR pszPath, const(PWSTR) pszMore);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR PathBuildRootA(PSTR pszRoot, int iDrive);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR PathBuildRootW(PWSTR pszRoot, int iDrive);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathCanonicalizeA(PSTR pszBuf, const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathCanonicalizeW(PWSTR pszBuf, const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR PathCombineA(PSTR pszDest, const(PSTR) pszDir, const(PSTR) pszFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR PathCombineW(PWSTR pszDest, const(PWSTR) pszDir, const(PWSTR) pszFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathCompactPathA(HDC hDC, PSTR pszPath, uint dx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathCompactPathW(HDC hDC, PWSTR pszPath, uint dx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathCompactPathExA(PSTR pszOut, const(PSTR) pszSrc, uint cchMax, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathCompactPathExW(PWSTR pszOut, const(PWSTR) pszSrc, uint cchMax, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int PathCommonPrefixA(const(PSTR) pszFile1, const(PSTR) pszFile2, PSTR achPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int PathCommonPrefixW(const(PWSTR) pszFile1, const(PWSTR) pszFile2, PWSTR achPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathFileExistsA(const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathFileExistsW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR PathFindExtensionA(const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR PathFindExtensionW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR PathFindFileNameA(const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR PathFindFileNameW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR PathFindNextComponentA(const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR PathFindNextComponentW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathFindOnPathA(PSTR pszPath, byte** ppszOtherDirs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathFindOnPathW(PWSTR pszPath, ushort** ppszOtherDirs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR PathFindSuffixArrayA(const(PSTR) pszPath, const(PSTR)* apszSuffix, int iArraySize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR PathFindSuffixArrayW(const(PWSTR) pszPath, const(PWSTR)* apszSuffix, int iArraySize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR PathGetArgsA(const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR PathGetArgsW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsLFNFileSpecA(const(PSTR) pszName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsLFNFileSpecW(const(PWSTR) pszName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
uint PathGetCharTypeA(ubyte ch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
uint PathGetCharTypeW(wchar ch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int PathGetDriveNumberA(const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int PathGetDriveNumberW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsDirectoryA(const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsDirectoryW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsDirectoryEmptyA(const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsDirectoryEmptyW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsFileSpecA(const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsFileSpecW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsPrefixA(const(PSTR) pszPrefix, const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsPrefixW(const(PWSTR) pszPrefix, const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsRelativeA(const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsRelativeW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsRootA(const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsRootW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsSameRootA(const(PSTR) pszPath1, const(PSTR) pszPath2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsSameRootW(const(PWSTR) pszPath1, const(PWSTR) pszPath2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsUNCA(const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsUNCW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsNetworkPathA(const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsNetworkPathW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsUNCServerA(const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsUNCServerW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsUNCServerShareA(const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsUNCServerShareW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsContentTypeA(const(PSTR) pszPath, const(PSTR) pszContentType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsContentTypeW(const(PWSTR) pszPath, const(PWSTR) pszContentType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsURLA(const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsURLW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathMakePrettyA(PSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathMakePrettyW(PWSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathMatchSpecA(const(PSTR) pszFile, const(PSTR) pszSpec);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathMatchSpecW(const(PWSTR) pszFile, const(PWSTR) pszSpec);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHLWAPI.dll")
HRESULT PathMatchSpecExA(const(PSTR) pszFile, const(PSTR) pszSpec, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHLWAPI.dll")
HRESULT PathMatchSpecExW(const(PWSTR) pszFile, const(PWSTR) pszSpec, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int PathParseIconLocationA(PSTR pszIconFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int PathParseIconLocationW(PWSTR pszIconFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathQuoteSpacesA(PSTR lpsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathQuoteSpacesW(PWSTR lpsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathRelativePathToA(PSTR pszPath, const(PSTR) pszFrom, uint dwAttrFrom, const(PSTR) pszTo, uint dwAttrTo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathRelativePathToW(PWSTR pszPath, const(PWSTR) pszFrom, uint dwAttrFrom, const(PWSTR) pszTo, uint dwAttrTo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
void PathRemoveArgsA(PSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
void PathRemoveArgsW(PWSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR PathRemoveBackslashA(PSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR PathRemoveBackslashW(PWSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
void PathRemoveBlanksA(PSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
void PathRemoveBlanksW(PWSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
void PathRemoveExtensionA(PSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
void PathRemoveExtensionW(PWSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathRemoveFileSpecA(PSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathRemoveFileSpecW(PWSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathRenameExtensionA(PSTR pszPath, const(PSTR) pszExt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathRenameExtensionW(PWSTR pszPath, const(PWSTR) pszExt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathSearchAndQualifyA(const(PSTR) pszPath, PSTR pszBuf, uint cchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathSearchAndQualifyW(const(PWSTR) pszPath, PWSTR pszBuf, uint cchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
void PathSetDlgItemPathA(HWND hDlg, int id, const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
void PathSetDlgItemPathW(HWND hDlg, int id, const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR PathSkipRootA(const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR PathSkipRootW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
void PathStripPathA(PSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
void PathStripPathW(PWSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathStripToRootA(PSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathStripToRootW(PWSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathUnquoteSpacesA(PSTR lpsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathUnquoteSpacesW(PWSTR lpsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathMakeSystemFolderA(const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathMakeSystemFolderW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathUnmakeSystemFolderA(const(PSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathUnmakeSystemFolderW(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsSystemFolderA(const(PSTR) pszPath, uint dwAttrb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathIsSystemFolderW(const(PWSTR) pszPath, uint dwAttrb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
void PathUndecorateA(PSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
void PathUndecorateW(PWSTR pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathUnExpandEnvStringsA(const(PSTR) pszPath, PSTR pszBuf, uint cchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL PathUnExpandEnvStringsW(const(PWSTR) pszPath, PWSTR pszBuf, uint cchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int UrlCompareA(const(PSTR) psz1, const(PSTR) psz2, BOOL fIgnoreSlash);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int UrlCompareW(const(PWSTR) psz1, const(PWSTR) psz2, BOOL fIgnoreSlash);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT UrlCombineA(const(PSTR) pszBase, const(PSTR) pszRelative, PSTR pszCombined, uint* pcchCombined, 
                    uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT UrlCombineW(const(PWSTR) pszBase, const(PWSTR) pszRelative, PWSTR pszCombined, uint* pcchCombined, 
                    uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT UrlCanonicalizeA(const(PSTR) pszUrl, PSTR pszCanonicalized, uint* pcchCanonicalized, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT UrlCanonicalizeW(const(PWSTR) pszUrl, PWSTR pszCanonicalized, uint* pcchCanonicalized, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL UrlIsOpaqueA(const(PSTR) pszURL);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL UrlIsOpaqueW(const(PWSTR) pszURL);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL UrlIsNoHistoryA(const(PSTR) pszURL);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL UrlIsNoHistoryW(const(PWSTR) pszURL);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL UrlIsA(const(PSTR) pszUrl, URLIS UrlIs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL UrlIsW(const(PWSTR) pszUrl, URLIS UrlIs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PSTR UrlGetLocationA(const(PSTR) pszURL);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
PWSTR UrlGetLocationW(const(PWSTR) pszURL);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT UrlUnescapeA(PSTR pszUrl, PSTR pszUnescaped, uint* pcchUnescaped, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT UrlUnescapeW(PWSTR pszUrl, PWSTR pszUnescaped, uint* pcchUnescaped, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT UrlEscapeA(const(PSTR) pszUrl, PSTR pszEscaped, uint* pcchEscaped, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT UrlEscapeW(const(PWSTR) pszUrl, PWSTR pszEscaped, uint* pcchEscaped, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT UrlCreateFromPathA(const(PSTR) pszPath, PSTR pszUrl, uint* pcchUrl, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT UrlCreateFromPathW(const(PWSTR) pszPath, PWSTR pszUrl, uint* pcchUrl, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT PathCreateFromUrlA(const(PSTR) pszUrl, PSTR pszPath, uint* pcchPath, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT PathCreateFromUrlW(const(PWSTR) pszUrl, PWSTR pszPath, uint* pcchPath, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHLWAPI.dll")
HRESULT PathCreateFromUrlAlloc(const(PWSTR) pszIn, PWSTR* ppszOut, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT UrlHashA(const(PSTR) pszUrl, 
                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pbHash, 
                 uint cbHash);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT UrlHashW(const(PWSTR) pszUrl, 
                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pbHash, 
                 uint cbHash);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT UrlGetPartW(const(PWSTR) pszIn, PWSTR pszOut, uint* pcchOut, uint dwPart, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT UrlGetPartA(const(PSTR) pszIn, PSTR pszOut, uint* pcchOut, uint dwPart, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT UrlApplySchemeA(const(PSTR) pszIn, PSTR pszOut, uint* pcchOut, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT UrlApplySchemeW(const(PWSTR) pszIn, PWSTR pszOut, uint* pcchOut, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT HashData(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pbData, 
                 uint cbData, 
                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pbHash, 
                 uint cbHash);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
HRESULT UrlFixupW(const(PWSTR) pcszUrl, PWSTR pszTranslatedUrl, uint cchMax);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHLWAPI.dll")
HRESULT ParseURLA(const(PSTR) pcszURL, PARSEDURLA* ppu);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHLWAPI.dll")
HRESULT ParseURLW(const(PWSTR) pcszURL, PARSEDURLW* ppu);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHDeleteEmptyKeyA(HKEY hkey, const(PSTR) pszSubKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHDeleteEmptyKeyW(HKEY hkey, const(PWSTR) pszSubKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHDeleteKeyA(HKEY hkey, const(PSTR) pszSubKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHDeleteKeyW(HKEY hkey, const(PWSTR) pszSubKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HKEY SHRegDuplicateHKey(HKEY hkey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHDeleteValueA(HKEY hkey, const(PSTR) pszSubKey, const(PSTR) pszValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHDeleteValueW(HKEY hkey, const(PWSTR) pszSubKey, const(PWSTR) pszValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHGetValueA(HKEY hkey, const(PSTR) pszSubKey, const(PSTR) pszValue, uint* pdwType, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvData, 
                        uint* pcbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHGetValueW(HKEY hkey, const(PWSTR) pszSubKey, const(PWSTR) pszValue, uint* pdwType, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvData, 
                        uint* pcbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int SHSetValueA(HKEY hkey, const(PSTR) pszSubKey, const(PSTR) pszValue, uint dwType, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/const(void)* pvData, 
                uint cbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int SHSetValueW(HKEY hkey, const(PWSTR) pszSubKey, const(PWSTR) pszValue, uint dwType, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/const(void)* pvData, 
                uint cbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegGetValueA(HKEY hkey, const(PSTR) pszSubKey, const(PSTR) pszValue, int srrfFlags, uint* pdwType, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* pvData, 
                           uint* pcbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegGetValueW(HKEY hkey, const(PWSTR) pszSubKey, const(PWSTR) pszValue, int srrfFlags, uint* pdwType, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* pvData, 
                           uint* pcbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegGetValueFromHKCUHKLM(const(PWSTR) pwszKey, const(PWSTR) pwszValue, int srrfFlags, uint* pdwType, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvData, 
                                      uint* pcbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHQueryValueExA(HKEY hkey, const(PSTR) pszValue, 
                            /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint* pdwReserved, 
                            uint* pdwType, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvData, 
                            uint* pcbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHQueryValueExW(HKEY hkey, const(PWSTR) pszValue, 
                            /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint* pdwReserved, 
                            uint* pdwType, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvData, 
                            uint* pcbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHEnumKeyExA(HKEY hkey, uint dwIndex, PSTR pszName, uint* pcchName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHEnumKeyExW(HKEY hkey, uint dwIndex, PWSTR pszName, uint* pcchName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHEnumValueA(HKEY hkey, uint dwIndex, PSTR pszValueName, uint* pcchValueName, uint* pdwType, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* pvData, 
                         uint* pcbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHEnumValueW(HKEY hkey, uint dwIndex, PWSTR pszValueName, uint* pcchValueName, uint* pdwType, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* pvData, 
                         uint* pcbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHQueryInfoKeyA(HKEY hkey, uint* pcSubKeys, uint* pcchMaxSubKeyLen, uint* pcValues, 
                            uint* pcchMaxValueNameLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHQueryInfoKeyW(HKEY hkey, uint* pcSubKeys, uint* pcchMaxSubKeyLen, uint* pcValues, 
                            uint* pcchMaxValueNameLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHCopyKeyA(HKEY hkeySrc, const(PSTR) pszSrcSubKey, HKEY hkeyDest, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint fReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHCopyKeyW(HKEY hkeySrc, const(PWSTR) pszSrcSubKey, HKEY hkeyDest, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint fReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegGetPathA(HKEY hKey, const(PSTR) pcszSubKey, const(PSTR) pcszValue, PSTR pszPath, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegGetPathW(HKEY hKey, const(PWSTR) pcszSubKey, const(PWSTR) pcszValue, PWSTR pszPath, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegSetPathA(HKEY hKey, const(PSTR) pcszSubKey, const(PSTR) pcszValue, const(PSTR) pcszPath, 
                          uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegSetPathW(HKEY hKey, const(PWSTR) pcszSubKey, const(PWSTR) pcszValue, const(PWSTR) pcszPath, 
                          uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegCreateUSKeyA(const(PSTR) pszPath, uint samDesired, ptrdiff_t hRelativeUSKey, 
                              ptrdiff_t* phNewUSKey, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegCreateUSKeyW(const(PWSTR) pwzPath, uint samDesired, ptrdiff_t hRelativeUSKey, 
                              ptrdiff_t* phNewUSKey, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegOpenUSKeyA(const(PSTR) pszPath, uint samDesired, ptrdiff_t hRelativeUSKey, ptrdiff_t* phNewUSKey, 
                            BOOL fIgnoreHKCU);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegOpenUSKeyW(const(PWSTR) pwzPath, uint samDesired, ptrdiff_t hRelativeUSKey, ptrdiff_t* phNewUSKey, 
                            BOOL fIgnoreHKCU);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegQueryUSValueA(ptrdiff_t hUSKey, const(PSTR) pszValue, uint* pdwType, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvData, 
                               uint* pcbData, BOOL fIgnoreHKCU, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* pvDefaultData, 
                               uint dwDefaultDataSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegQueryUSValueW(ptrdiff_t hUSKey, const(PWSTR) pszValue, uint* pdwType, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvData, 
                               uint* pcbData, BOOL fIgnoreHKCU, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* pvDefaultData, 
                               uint dwDefaultDataSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegWriteUSValueA(ptrdiff_t hUSKey, const(PSTR) pszValue, uint dwType, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(void)* pvData, 
                               uint cbData, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegWriteUSValueW(ptrdiff_t hUSKey, const(PWSTR) pwzValue, uint dwType, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(void)* pvData, 
                               uint cbData, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegDeleteUSValueA(ptrdiff_t hUSKey, const(PSTR) pszValue, SHREGDEL_FLAGS delRegFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegDeleteUSValueW(ptrdiff_t hUSKey, const(PWSTR) pwzValue, SHREGDEL_FLAGS delRegFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegDeleteEmptyUSKeyW(ptrdiff_t hUSKey, const(PWSTR) pwzSubKey, SHREGDEL_FLAGS delRegFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegDeleteEmptyUSKeyA(ptrdiff_t hUSKey, const(PSTR) pszSubKey, SHREGDEL_FLAGS delRegFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegEnumUSKeyA(ptrdiff_t hUSKey, uint dwIndex, PSTR pszName, uint* pcchName, 
                            SHREGENUM_FLAGS enumRegFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegEnumUSKeyW(ptrdiff_t hUSKey, uint dwIndex, PWSTR pwzName, uint* pcchName, 
                            SHREGENUM_FLAGS enumRegFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegEnumUSValueA(ptrdiff_t hUSkey, uint dwIndex, PSTR pszValueName, uint* pcchValueName, 
                              uint* pdwType, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* pvData, 
                              uint* pcbData, SHREGENUM_FLAGS enumRegFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegEnumUSValueW(ptrdiff_t hUSkey, uint dwIndex, PWSTR pszValueName, uint* pcchValueName, 
                              uint* pdwType, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* pvData, 
                              uint* pcbData, SHREGENUM_FLAGS enumRegFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegQueryInfoUSKeyA(ptrdiff_t hUSKey, uint* pcSubKeys, uint* pcchMaxSubKeyLen, uint* pcValues, 
                                 uint* pcchMaxValueNameLen, SHREGENUM_FLAGS enumRegFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegQueryInfoUSKeyW(ptrdiff_t hUSKey, uint* pcSubKeys, uint* pcchMaxSubKeyLen, uint* pcValues, 
                                 uint* pcchMaxValueNameLen, SHREGENUM_FLAGS enumRegFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegCloseUSKey(ptrdiff_t hUSKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegGetUSValueA(const(PSTR) pszSubKey, const(PSTR) pszValue, uint* pdwType, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvData, 
                             uint* pcbData, BOOL fIgnoreHKCU, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* pvDefaultData, 
                             uint dwDefaultDataSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegGetUSValueW(const(PWSTR) pszSubKey, const(PWSTR) pszValue, uint* pdwType, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvData, 
                             uint* pcbData, BOOL fIgnoreHKCU, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* pvDefaultData, 
                             uint dwDefaultDataSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegSetUSValueA(const(PSTR) pszSubKey, const(PSTR) pszValue, uint dwType, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(void)* pvData, 
                             uint cbData, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
WIN32_ERROR SHRegSetUSValueW(const(PWSTR) pwzSubKey, const(PWSTR) pwzValue, uint dwType, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(void)* pvData, 
                             uint cbData, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int SHRegGetIntW(HKEY hk, const(PWSTR) pwzKey, int iDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL SHRegGetBoolUSValueA(const(PSTR) pszSubKey, const(PSTR) pszValue, BOOL fIgnoreHKCU, BOOL fDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL SHRegGetBoolUSValueW(const(PWSTR) pszSubKey, const(PWSTR) pszValue, BOOL fIgnoreHKCU, BOOL fDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT AssocCreate(GUID clsid, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT AssocQueryStringA(ASSOCF flags, ASSOCSTR str, const(PSTR) pszAssoc, const(PSTR) pszExtra, PSTR pszOut, 
                          uint* pcchOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT AssocQueryStringW(ASSOCF flags, ASSOCSTR str, const(PWSTR) pszAssoc, const(PWSTR) pszExtra, PWSTR pszOut, 
                          uint* pcchOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT AssocQueryStringByKeyA(ASSOCF flags, ASSOCSTR str, HKEY hkAssoc, const(PSTR) pszExtra, PSTR pszOut, 
                               uint* pcchOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT AssocQueryStringByKeyW(ASSOCF flags, ASSOCSTR str, HKEY hkAssoc, const(PWSTR) pszExtra, PWSTR pszOut, 
                               uint* pcchOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT AssocQueryKeyA(ASSOCF flags, ASSOCKEY key, const(PSTR) pszAssoc, const(PSTR) pszExtra, HKEY* phkeyOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT AssocQueryKeyW(ASSOCF flags, ASSOCKEY key, const(PWSTR) pszAssoc, const(PWSTR) pszExtra, HKEY* phkeyOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
BOOL AssocIsDangerous(const(PWSTR) pszAssoc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
HRESULT AssocGetPerceivedType(const(PWSTR) pszExt, PERCEIVED* ptype, uint* pflag, PWSTR* ppszType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
IStream SHOpenRegStreamA(HKEY hkey, const(PSTR) pszSubkey, const(PSTR) pszValue, uint grfMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
IStream SHOpenRegStreamW(HKEY hkey, const(PWSTR) pszSubkey, const(PWSTR) pszValue, uint grfMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
IStream SHOpenRegStream2A(HKEY hkey, const(PSTR) pszSubkey, const(PSTR) pszValue, uint grfMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
IStream SHOpenRegStream2W(HKEY hkey, const(PWSTR) pszSubkey, const(PWSTR) pszValue, uint grfMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
HRESULT SHCreateStreamOnFileA(const(PSTR) pszFile, uint grfMode, IStream* ppstm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
HRESULT SHCreateStreamOnFileW(const(PWSTR) pszFile, uint grfMode, IStream* ppstm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
HRESULT SHCreateStreamOnFileEx(const(PWSTR) pszFile, uint grfMode, uint dwAttributes, BOOL fCreate, 
                               IStream pstmTemplate, IStream* ppstm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
IStream SHCreateMemStream(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(ubyte)* pInit, 
                          uint cbInit);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT GetAcceptLanguagesA(PSTR pszLanguages, uint* pcchLanguages);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT GetAcceptLanguagesW(PWSTR pszLanguages, uint* pcchLanguages);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
void IUnknown_Set(IUnknown* ppunk, IUnknown punk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
void IUnknown_AtomicRelease(void** ppunk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT IUnknown_GetWindow(IUnknown punk, HWND* phwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT IUnknown_SetSite(IUnknown punk, IUnknown punkSite);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT IUnknown_GetSite(IUnknown punk, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT IUnknown_QueryService(IUnknown punk, const(GUID)* guidService, const(GUID)* riid, void** ppvOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT IStream_Read(IStream pstm, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pv, 
                     uint cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHLWAPI.dll")
HRESULT IStream_Write(IStream pstm, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pv, 
                      uint cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT IStream_Reset(IStream pstm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT IStream_Size(IStream pstm, ulong* pui);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT ConnectToConnectionPoint(IUnknown punk, const(GUID)* riidEvent, BOOL fConnect, IUnknown punkTarget, 
                                 uint* pdwCookie, IConnectionPoint* ppcpOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHLWAPI.dll")
HRESULT IStream_ReadPidl(IStream pstm, ITEMIDLIST** ppidlOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHLWAPI.dll")
HRESULT IStream_WritePidl(IStream pstm, ITEMIDLIST* pidlWrite);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHLWAPI.dll")
HRESULT IStream_ReadStr(IStream pstm, PWSTR* ppsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHLWAPI.dll")
HRESULT IStream_WriteStr(IStream pstm, const(PWSTR) psz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHLWAPI.dll")
HRESULT IStream_Copy(IStream pstmFrom, IStream pstmTo, uint cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
HRESULT SHGetViewStatePropertyBag(ITEMIDLIST* pidl, const(PWSTR) pszBagName, uint dwFlags, const(GUID)* riid, 
                                  void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
int SHFormatDateTimeA(const(FILETIME)* pft, uint* pdwFlags, PSTR pszBuf, uint cchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
int SHFormatDateTimeW(const(FILETIME)* pft, uint* pdwFlags, PWSTR pszBuf, uint cchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int SHAnsiToUnicode(const(PSTR) pszSrc, PWSTR pwszDst, int cwchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int SHAnsiToAnsi(const(PSTR) pszSrc, PSTR pszDst, int cchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int SHUnicodeToAnsi(const(PWSTR) pwszSrc, PSTR pszDst, int cchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
int SHUnicodeToUnicode(const(PWSTR) pwzSrc, PWSTR pwzDst, int cwchBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
int SHMessageBoxCheckA(HWND hwnd, const(PSTR) pszText, const(PSTR) pszCaption, uint uType, int iDefault, 
                       const(PSTR) pszRegVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
int SHMessageBoxCheckW(HWND hwnd, const(PWSTR) pszText, const(PWSTR) pszCaption, uint uType, int iDefault, 
                       const(PWSTR) pszRegVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
LRESULT SHSendMessageBroadcastA(uint uMsg, WPARAM wParam, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
LRESULT SHSendMessageBroadcastW(uint uMsg, WPARAM wParam, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
CHAR SHStripMneumonicA(PSTR pszMenu);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
wchar SHStripMneumonicW(PWSTR pszMenu);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL IsOS(OS dwOS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SHLWAPI.dll")
int SHGlobalCounterGetValue(const(SHGLOBALCOUNTER) id);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SHLWAPI.dll")
int SHGlobalCounterIncrement(const(SHGLOBALCOUNTER) id);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SHLWAPI.dll")
int SHGlobalCounterDecrement(const(SHGLOBALCOUNTER) id);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
HANDLE SHAllocShared(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pvData, 
                     uint dwSize, uint dwProcessId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
BOOL SHFreeShared(HANDLE hData, uint dwProcessId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
void* SHLockShared(HANDLE hData, uint dwProcessId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
BOOL SHUnlockShared(void* pvData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
uint WhichPlatform();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT QISearch(void* that, QITAB* pqit, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
BOOL SHIsLowMemoryMachine(uint dwType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
int GetMenuPosFromID(HMENU hmenu, uint id);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT SHGetInverseCMAP(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pbMap, 
                         uint cbMap);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT SHAutoComplete(HWND hwndEdit, SHELL_AUTOCOMPLETE_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
HRESULT SHCreateThreadRef(int* pcRef, IUnknown* ppunk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT SHSetThreadRef(IUnknown punk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HRESULT SHGetThreadRef(IUnknown* ppunk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL SHSkipJunction(IBindCtx pbc, const(GUID)* pclsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
BOOL SHCreateThread(LPTHREAD_START_ROUTINE pfnThreadProc, void* pData, uint flags, 
                    LPTHREAD_START_ROUTINE pfnCallback);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SHLWAPI.dll")
BOOL SHCreateThreadWithHandle(LPTHREAD_START_ROUTINE pfnThreadProc, void* pData, uint flags, 
                              LPTHREAD_START_ROUTINE pfnCallback, HANDLE* pHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
HRESULT SHReleaseThreadRef();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
HPALETTE SHCreateShellPalette(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
void ColorRGBToHLS(COLORREF clrRGB, ushort* pwHue, ushort* pwLuminance, ushort* pwSaturation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
COLORREF ColorHLSToRGB(ushort wHue, ushort wLuminance, ushort wSaturation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SHLWAPI.dll")
COLORREF ColorAdjustLuma(COLORREF clrRGB, int n, BOOL fScale);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SHLWAPI.dll")
BOOL IsInternetESCEnabled();

@DllImport("hlink.dll")
HRESULT HlinkCreateFromMoniker(IMoniker pimkTrgt, const(PWSTR) pwzLocation, const(PWSTR) pwzFriendlyName, 
                               IHlinkSite pihlsite, uint dwSiteData, IUnknown piunkOuter, const(GUID)* riid, 
                               void** ppvObj);

@DllImport("hlink.dll")
HRESULT HlinkCreateFromString(const(PWSTR) pwzTarget, const(PWSTR) pwzLocation, const(PWSTR) pwzFriendlyName, 
                              IHlinkSite pihlsite, uint dwSiteData, IUnknown piunkOuter, const(GUID)* riid, 
                              void** ppvObj);

@DllImport("hlink.dll")
HRESULT HlinkCreateFromData(IDataObject piDataObj, IHlinkSite pihlsite, uint dwSiteData, IUnknown piunkOuter, 
                            const(GUID)* riid, void** ppvObj);

@DllImport("hlink.dll")
HRESULT HlinkQueryCreateFromData(IDataObject piDataObj);

@DllImport("hlink.dll")
HRESULT HlinkClone(IHlink pihl, const(GUID)* riid, IHlinkSite pihlsiteForClone, uint dwSiteData, void** ppvObj);

@DllImport("hlink.dll")
HRESULT HlinkCreateBrowseContext(IUnknown piunkOuter, const(GUID)* riid, void** ppvObj);

@DllImport("hlink.dll")
HRESULT HlinkNavigateToStringReference(const(PWSTR) pwzTarget, const(PWSTR) pwzLocation, IHlinkSite pihlsite, 
                                       uint dwSiteData, IHlinkFrame pihlframe, uint grfHLNF, IBindCtx pibc, 
                                       IBindStatusCallback pibsc, IHlinkBrowseContext pihlbc);

@DllImport("hlink.dll")
HRESULT HlinkNavigate(IHlink pihl, IHlinkFrame pihlframe, uint grfHLNF, IBindCtx pbc, IBindStatusCallback pibsc, 
                      IHlinkBrowseContext pihlbc);

@DllImport("hlink.dll")
HRESULT HlinkOnNavigate(IHlinkFrame pihlframe, IHlinkBrowseContext pihlbc, uint grfHLNF, IMoniker pimkTarget, 
                        const(PWSTR) pwzLocation, const(PWSTR) pwzFriendlyName, uint* puHLID);

@DllImport("hlink.dll")
HRESULT HlinkUpdateStackItem(IHlinkFrame pihlframe, IHlinkBrowseContext pihlbc, uint uHLID, IMoniker pimkTrgt, 
                             const(PWSTR) pwzLocation, const(PWSTR) pwzFriendlyName);

@DllImport("hlink.dll")
HRESULT HlinkOnRenameDocument(uint dwReserved, IHlinkBrowseContext pihlbc, IMoniker pimkOld, IMoniker pimkNew);

@DllImport("hlink.dll")
HRESULT HlinkResolveMonikerForData(IMoniker pimkReference, uint reserved, IBindCtx pibc, uint cFmtetc, 
                                   FORMATETC* rgFmtetc, IBindStatusCallback pibsc, IMoniker pimkBase);

@DllImport("hlink.dll")
HRESULT HlinkResolveStringForData(const(PWSTR) pwzReference, uint reserved, IBindCtx pibc, uint cFmtetc, 
                                  FORMATETC* rgFmtetc, IBindStatusCallback pibsc, IMoniker pimkBase);

@DllImport("hlink.dll")
HRESULT HlinkParseDisplayName(IBindCtx pibc, const(PWSTR) pwzDisplayName, BOOL fNoForceAbs, uint* pcchEaten, 
                              IMoniker* ppimk);

@DllImport("hlink.dll")
HRESULT HlinkCreateExtensionServices(const(PWSTR) pwzAdditionalHeaders, HWND phwnd, const(PWSTR) pszUsername, 
                                     const(PWSTR) pszPassword, IUnknown piunkOuter, const(GUID)* riid, void** ppvObj);

@DllImport("hlink.dll")
HRESULT HlinkPreprocessMoniker(IBindCtx pibc, IMoniker pimkIn, IMoniker* ppimkOut);

@DllImport("hlink.dll")
HRESULT OleSaveToStreamEx(IUnknown piunk, IStream pistm, BOOL fClearDirty);

@DllImport("hlink.dll")
HRESULT HlinkSetSpecialReference(uint uReference, const(PWSTR) pwzReference);

@DllImport("hlink.dll")
HRESULT HlinkGetSpecialReference(uint uReference, PWSTR* ppwzReference);

@DllImport("hlink.dll")
HRESULT HlinkCreateShortcut(uint grfHLSHORTCUTF, IHlink pihl, const(PWSTR) pwzDir, const(PWSTR) pwzFileName, 
                            PWSTR* ppwzShortcutFile, uint dwReserved);

@DllImport("hlink.dll")
HRESULT HlinkCreateShortcutFromMoniker(uint grfHLSHORTCUTF, IMoniker pimkTarget, const(PWSTR) pwzLocation, 
                                       const(PWSTR) pwzDir, const(PWSTR) pwzFileName, PWSTR* ppwzShortcutFile, 
                                       uint dwReserved);

@DllImport("hlink.dll")
HRESULT HlinkCreateShortcutFromString(uint grfHLSHORTCUTF, const(PWSTR) pwzTarget, const(PWSTR) pwzLocation, 
                                      const(PWSTR) pwzDir, const(PWSTR) pwzFileName, PWSTR* ppwzShortcutFile, 
                                      uint dwReserved);

@DllImport("hlink.dll")
HRESULT HlinkResolveShortcut(const(PWSTR) pwzShortcutFileName, IHlinkSite pihlsite, uint dwSiteData, 
                             IUnknown piunkOuter, const(GUID)* riid, void** ppvObj);

@DllImport("hlink.dll")
HRESULT HlinkResolveShortcutToMoniker(const(PWSTR) pwzShortcutFileName, IMoniker* ppimkTarget, PWSTR* ppwzLocation);

@DllImport("hlink.dll")
HRESULT HlinkResolveShortcutToString(const(PWSTR) pwzShortcutFileName, PWSTR* ppwzTarget, PWSTR* ppwzLocation);

@DllImport("hlink.dll")
HRESULT HlinkIsShortcut(const(PWSTR) pwzFileName);

@DllImport("hlink.dll")
HRESULT HlinkGetValueFromParams(const(PWSTR) pwzParams, const(PWSTR) pwzName, PWSTR* ppwzValue);

@DllImport("hlink.dll")
HRESULT HlinkTranslateURL(const(PWSTR) pwzURL, uint grfFlags, PWSTR* ppwzTranslatedURL);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
BOOL PathIsUNCEx(const(PWSTR) pszPath, const(PWSTR)* ppszServer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
BOOL PathCchIsRoot(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchAddBackslashEx(PWSTR pszPath, size_t cchPath, PWSTR* ppszEnd, size_t* pcchRemaining);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchAddBackslash(PWSTR pszPath, size_t cchPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchRemoveBackslashEx(PWSTR pszPath, size_t cchPath, PWSTR* ppszEnd, size_t* pcchRemaining);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchRemoveBackslash(PWSTR pszPath, size_t cchPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchSkipRoot(const(PWSTR) pszPath, const(PWSTR)* ppszRootEnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchStripToRoot(PWSTR pszPath, size_t cchPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchRemoveFileSpec(PWSTR pszPath, size_t cchPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchFindExtension(const(PWSTR) pszPath, size_t cchPath, const(PWSTR)* ppszExt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchAddExtension(PWSTR pszPath, size_t cchPath, const(PWSTR) pszExt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchRenameExtension(PWSTR pszPath, size_t cchPath, const(PWSTR) pszExt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchRemoveExtension(PWSTR pszPath, size_t cchPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchCanonicalizeEx(PWSTR pszPathOut, size_t cchPathOut, const(PWSTR) pszPathIn, PATHCCH_OPTIONS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchCanonicalize(PWSTR pszPathOut, size_t cchPathOut, const(PWSTR) pszPathIn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchCombineEx(PWSTR pszPathOut, size_t cchPathOut, const(PWSTR) pszPathIn, const(PWSTR) pszMore, 
                         PATHCCH_OPTIONS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchCombine(PWSTR pszPathOut, size_t cchPathOut, const(PWSTR) pszPathIn, const(PWSTR) pszMore);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchAppendEx(PWSTR pszPath, size_t cchPath, const(PWSTR) pszMore, PATHCCH_OPTIONS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchAppend(PWSTR pszPath, size_t cchPath, const(PWSTR) pszMore);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchStripPrefix(PWSTR pszPath, size_t cchPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathAllocCombine(const(PWSTR) pszPathIn, const(PWSTR) pszMore, PATHCCH_OPTIONS dwFlags, PWSTR* ppszPathOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathAllocCanonicalize(const(PWSTR) pszPathIn, PATHCCH_OPTIONS dwFlags, PWSTR* ppszPathOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appnotify/nf-appnotify-registerappstatechangenotification
@DllImport("api-ms-win-core-psm-appnotify-l1-1-0.dll")
uint RegisterAppStateChangeNotification(PAPPSTATE_CHANGE_ROUTINE Routine, void* Context, 
                                        PAPPSTATE_REGISTRATION* Registration);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/appnotify/nf-appnotify-unregisterappstatechangenotification
@DllImport("api-ms-win-core-psm-appnotify-l1-1-0.dll")
void UnregisterAppStateChangeNotification(PAPPSTATE_REGISTRATION Registration);

@DllImport("api-ms-win-core-psm-appnotify-l1-1-1.dll")
uint RegisterAppConstrainedChangeNotification(PAPPCONSTRAIN_CHANGE_ROUTINE Routine, void* Context, 
                                              PAPPCONSTRAIN_REGISTRATION* Registration);

@DllImport("api-ms-win-core-psm-appnotify-l1-1-1.dll")
void UnregisterAppConstrainedChangeNotification(PAPPCONSTRAIN_REGISTRATION Registration);


// Interfaces

@GUID("c2cf3110-460e-4fc1-b9d0-8a1c0c9cc4bd")
struct DesktopWallpaper;

@GUID("00021400-0000-0000-c000-000000000046")
struct ShellDesktop;

@GUID("f3364ba0-65b9-11ce-a9ba-00aa004ae837")
struct ShellFSFolder;

@GUID("208d2c60-3aea-1069-a2d7-08002b30309d")
struct NetworkPlaces;

@GUID("00021401-0000-0000-c000-000000000046")
struct ShellLink;

@GUID("94357b53-ca29-4b78-83ae-e8fe7409134f")
struct DriveSizeCategorizer;

@GUID("b0a8f3cf-4333-4bab-8873-1ccb1cada48b")
struct DriveTypeCategorizer;

@GUID("b5607793-24ac-44c7-82e2-831726aa6cb7")
struct FreeSpaceCategorizer;

@GUID("55d7b852-f6d1-42f2-aa75-8728a1b2d264")
struct SizeCategorizer;

@GUID("d912f8cf-0396-4915-884e-fb425d32943b")
struct PropertiesUI;

@GUID("0010890e-8789-413c-adbc-48f5b511b3af")
struct UserNotification;

@GUID("56fdf344-fd6d-11d0-958a-006097c9a090")
struct TaskbarList;

@GUID("9ac9fbe1-e0a2-4ad6-b4ee-e212013ea917")
struct ShellItem;

@GUID("72eb61e0-8672-4303-9175-f2e4c68b2e7c")
struct NamespaceWalker;

@GUID("3ad05575-8857-4850-9277-11b85bdb8e09")
struct FileOperation;

@GUID("dc1c5a9c-e88a-4dde-a5a1-60f82a20aef7")
struct FileOpenDialog;

@GUID("c0b4e2f3-ba21-4773-8dba-335ec946eb8b")
struct FileSaveDialog;

@GUID("4df0c730-df9d-4ae3-9153-aa6b82e9795a")
struct KnownFolderManager;

@GUID("49f371e1-8c5c-4d9c-9a3b-54a6827f513c")
struct SharingConfigurationManager;

@GUID("7007acc7-3202-11d1-aad2-00805fc1270e")
struct NetworkConnections;

@GUID("d6277990-4c6a-11cf-8d87-00aa0060f5bf")
struct ScheduledTasks;

@GUID("591209c7-767b-42b2-9fba-44ee4615f2c7")
struct ApplicationAssociationRegistration;

@GUID("14010e02-bbbd-41f0-88e3-eda371216584")
struct SearchFolderItemFactory;

@GUID("06622d85-6856-4460-8de1-a81921b41c4b")
struct OpenControlPanel;

@GUID("9e56be60-c50f-11cf-9a2c-00a0c90a90ce")
struct MailRecipient;

@GUID("f02c1a0d-be21-4350-88b0-7367fc96ef3c")
struct NetworkExplorerFolder;

@GUID("77f10cf0-3db5-4966-b520-b7c54fd35ed6")
struct DestinationList;

@GUID("38fe0cf4-6a59-4729-8e4a-2d580059ede4")
struct DestinationListBoth;

@GUID("86c14003-4d6b-4ef3-a7b4-0506663b2e68")
struct ApplicationDestinations;

@GUID("86bec222-30f2-47e0-9f25-60d11cd75c28")
struct ApplicationDocumentLists;

@GUID("de77ba04-3c92-4d11-a1a5-42352a53e0e3")
struct HomeGroup;

@GUID("d9b3211d-e57f-4426-aaef-30a806add397")
struct ShellLibrary;

@GUID("273eb5e7-88b0-4843-bfef-e2c81d43aae5")
struct AppStartupLink;

@GUID("2d3468c1-36a7-43b6-ac24-d3f02fd9607a")
struct EnumerableObjectCollection;

@GUID("d5120aa3-46ba-44c5-822d-ca8092c1fc72")
struct FrameworkInputPane;

@GUID("c63382be-7933-48d0-9ac8-85fb46be2fdd")
struct DefFolderMenu;

@GUID("7e5fe3d9-985f-4908-91f9-ee19f9fd1514")
struct AppVisibility;

@GUID("4ed3a719-cea8-4bd9-910d-e252f997afc2")
struct AppShellVerbHandler;

@GUID("e44e9428-bdbc-4987-a099-40dc8fd255e7")
struct ExecuteUnknown;

@GUID("b1aec16f-2383-4852-b0e9-8f0b1dc66b4d")
struct PackageDebugSettings;

@GUID("6b273fc5-61fd-4918-95a2-c3b5e9d7f581")
struct SuspensionDependencyManager;

@GUID("45ba127d-10a8-46ea-8ab7-56ea9078943c")
struct ApplicationActivationManager;

@GUID("958a6fb5-dcb2-4faf-aafd-7fb054ad1a3b")
struct ApplicationDesignModeSettings;

@GUID("331f1768-05a9-4ddd-b86e-dae34ddc998a")
struct QueryCancelAutoPlay;

@GUID("3bb4118f-ddfd-4d30-a348-9fb5d6bf1afe")
struct TimeCategorizer;

@GUID("3c2654c6-7372-4f6b-b310-55d6128f49d2")
struct AlphabeticalCategorizer;

@GUID("8e827c11-33e7-4bc1-b242-8cd9a1c2b304")
struct MergedCategorizer;

@GUID("7ab770c7-0e23-4d7a-8aa2-19bfad479829")
struct ImageProperties;

@GUID("fbeb8a05-beee-4442-804e-409d6c4515e9")
struct CDBurn;

@GUID("a2a9545d-a0c2-42b4-9708-a0b2badd77c8")
struct StartMenuPin;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/webwizardhost
@GUID("c827f149-55c1-4d28-935e-57e47caed973")
struct WebWizardHost;

@GUID("cc6eeffb-43f6-46c5-9619-51d571967f7d")
struct PublishDropTarget;

@GUID("6b33163c-76a5-4b6c-bf21-45de9cd503a1")
struct PublishingWizard;

@GUID("add36aa8-751a-4579-a266-d66f5202ccbb")
struct InternetPrintOrdering;

@GUID("20b1cb23-6968-4eb9-b7d4-a66d00d07cee")
struct FolderViewHost;

@GUID("71f96385-ddd6-48d3-a0c1-ae06e8b055fb")
struct ExplorerBrowser;

@GUID("6e33091c-d2f8-4740-b55e-2e11d1477a2c")
struct ImageRecompress;

@GUID("f60ad0a0-e5e1-45cb-b51a-e15b9f8b2934")
struct TrayBandSiteService;

@GUID("e6442437-6c68-4f52-94dd-2cfed267efb9")
struct TrayDeskBand;

@GUID("4125dd96-e03a-4103-8f70-e0597d803b9c")
struct AttachmentServices;

@GUID("883373c3-bf89-11d1-be35-080036b11a03")
struct DocPropShellExtension;

@GUID("d197380a-0a79-4dc8-a033-ed882c2fa14b")
struct FSCopyHandler;

@GUID("596ab062-b4d2-4215-9f74-e9109b0a8153")
struct PreviousVersions;

@GUID("ae054212-3535-4430-83ed-d501aa6680e6")
struct NamespaceTreeControl;

@GUID("ace52d03-e5cd-4b20-82ff-e71b11beae1d")
struct IENamespaceTreeControl;

@GUID("1968106d-f3b5-44cf-890e-116fcb9ecef1")
struct ApplicationAssociationRegistrationUI;

@GUID("924ccc1b-6562-4c85-8657-d177925222b6")
struct DesktopGadget;

@GUID("29ce1d46-b481-4aa0-a08a-d3ebc8aca402")
struct AccessibilityDockingService;

@GUID("11dbb47c-a525-400b-9e80-a54615a090c0")
struct ExecuteFolder;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/virtualdesktopmanager
@GUID("aa509086-5ca9-4c25-8f95-589d3c07b48a")
struct VirtualDesktopManager;

@GUID("7ccdf9f4-e576-455a-8bc7-f6ec68d6f063")
struct StorageProviderBanners;

@GUID("eab22ac3-30c1-11cf-a7eb-0000c05bae0b")
struct WebBrowser_V1;

@GUID("8856f961-340a-11d0-a96b-00c04fd705a2")
struct WebBrowser;

@GUID("0002df01-0000-0000-c000-000000000046")
struct InternetExplorer;

@GUID("d5e8041d-920f-45e9-b8fb-b1deb82c6e5e")
struct InternetExplorerMedium;

@GUID("c08afd90-f2a1-11d1-8455-00a0c91f3880")
struct ShellBrowserWindow;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/shellwindows
@GUID("9ba05972-f6a8-11cf-a442-00a0c90a8f39")
struct ShellWindows;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/shelluihelper
@GUID("64ab4bb7-111e-11d1-8f79-00c04fc2fbe1")
struct ShellUIHelper;

@GUID("55136805-b2de-11d1-b9f2-00a0c98bc547")
struct ShellNameSpace;

@GUID("efd01300-160f-11d2-bb2e-00805ff7efca")
struct CScriptErrorList;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/shellfolderviewoc-object
@GUID("9ba05971-f6a8-11cf-a442-00a0c90a8f39")
struct ShellFolderViewOC;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/shellfolderitem-object
@GUID("2fe352ea-fd1f-11d2-b1f4-00c04f8eeb3e")
struct ShellFolderItem;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/shelllinkobject-object
@GUID("11219420-1768-11d1-95be-00609797ea4f")
struct ShellLinkObject;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/shellfolderview
@GUID("62112aa1-ebe4-11cf-a5fb-0020afe7292d")
struct ShellFolderView;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/shell
@GUID("13709620-c279-11ce-a49e-444553540000")
struct Shell;

@GUID("0a89a860-d7b1-11ce-8350-444553540000")
struct ShellDispatchInproc;

@GUID("c4ee31f3-4768-11d2-be5c-00a0c9a83da1")
struct FileSearchBand;

@GUID("60b78e88-ead8-445c-9cfd-0b87f74ea6cd")
struct PasswordCredentialProvider;

@GUID("6f45dc1e-5384-457a-bc13-2cd81b0d28ed")
struct V1PasswordCredentialProvider;

@GUID("cb82ea12-9f71-446d-89e1-8d0924e1256e")
struct PINLogonCredentialProvider;

@GUID("3dd6bec0-8193-4ffe-ae25-e08e39ea4063")
struct NPCredentialProvider;

@GUID("8fd7e19c-3bf7-489b-a72c-846ab3678c96")
struct SmartcardCredentialProvider;

@GUID("8bf9a910-a8ff-457f-999f-a5ca10b4a885")
struct V1SmartcardCredentialProvider;

@GUID("94596c7e-3744-41ce-893e-bbf09122f76a")
struct SmartcardPinProvider;

@GUID("1b283861-754f-4022-ad47-a5eaaa618894")
struct SmartcardReaderSelectionProvider;

@GUID("1ee7337f-85ac-45e2-a23c-37c753209769")
struct SmartcardWinRTProvider;

@GUID("25cbb996-92ed-457e-b28c-4774084bd562")
struct GenericCredentialProvider;

@GUID("5537e283-b1e7-4ef8-9c6e-7ab0afe5056d")
struct RASProvider;

@GUID("07aa0886-cc8d-4e19-a410-1c75af686e62")
struct OnexCredentialProvider;

@GUID("33c86cd6-705f-4ba1-9adb-67070b837775")
struct OnexPlapSmartcardCredentialProvider;

@GUID("503739d0-4c5e-4cfd-b3ba-d881334f0df2")
struct VaultProvider;

@GUID("bec09223-b018-416d-a0ac-523971b639f5")
struct WinBioCredentialProvider;

@GUID("ac3ac249-e820-4343-a65b-377ac634dc09")
struct V1WinBioCredentialProvider;

@GUID("1202db60-1dac-42c5-aed5-1abdd432248e")
struct SyncMgrClient;

@GUID("1a1f4206-0688-4e7f-be03-d82ec69df9a5")
struct SyncMgrControl;

@GUID("8d8b8e30-c451-421b-8553-d2976afa648c")
struct SyncMgrScheduleWizard;

@GUID("9c73f5e5-7ae7-4e32-a8e8-8d23b85255bf")
struct SyncMgrFolder;

@GUID("2e9e59c0-b437-4981-a647-9c34b9b90891")
struct SyncSetupFolder;

@GUID("289978ac-a101-4341-a817-21eba7fd046d")
struct ConflictFolder;

@GUID("71d99464-3b6b-475c-b241-e15883207529")
struct SyncResultsFolder;

@GUID("7a0f6ab7-ed84-46b6-b47e-02aa159a152b")
struct SimpleConflictPresenter;

@GUID("2853add3-f096-4c63-a78f-7fa3ea837fb7")
struct InputPanelConfiguration;

@GUID("50ef4544-ac9f-4a8e-b21b-8a26180db13f")
struct LocalThumbnailCache;

@GUID("4db26476-6787-4046-b836-e8412a9e8a27")
struct SharedBitmap;

@GUID("66e4e4fb-f385-4dd0-8d74-a2efd1bc6178")
struct ShellImageDataFactory;

@GUID("6295df27-35ee-11d1-8707-00c04fd93327")
struct SyncMgr;

@GUID("cbe0fed3-4b91-4e90-8354-8a8c84ec6872")
struct ThumbnailStreamCache;

@GUID("8278f931-2a3e-11d2-838f-00c04fd918d0")
struct TrackShellMenu;

@GUID("17b75166-928f-417d-9685-64aa135565c1")
struct ImageTranscode;

@GUID("1f046abf-3202-4dc1-8cb5-3c67617ce1fa")
struct ShowInputPaneAnimationCoordinator;

@GUID("384742b1-2a77-4cb3-8cf8-1136f5e17e59")
struct HideInputPaneAnimationCoordinator;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/reconcil/nn-reconcil-inotifyreplica
@GUID("99180163-da16-101a-935c-444553540000")
interface INotifyReplica : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/reconcil/nf-reconcil-inotifyreplica-youareareplica
    HRESULT YouAreAReplica(uint ulcOtherReplicas, IMoniker* rgpmkOtherReplicas);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-icontextmenu
@GUID("000214e4-0000-0000-c000-000000000046")
interface IContextMenu : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT QueryContextMenu(HMENU hmenu, uint indexMenu, uint idCmdFirst, uint idCmdLast, uint uFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icontextmenu-invokecommand
    HRESULT InvokeCommand(CMINVOKECOMMANDINFO* pici);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icontextmenu-getcommandstring
    HRESULT GetCommandString(size_t idCmd, uint uType, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint* pReserved, 
                             PSTR pszName, uint cchMax);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-icontextmenu2
@GUID("000214f4-0000-0000-c000-000000000046")
interface IContextMenu2 : IContextMenu
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icontextmenu2-handlemenumsg
    HRESULT HandleMenuMsg(uint uMsg, WPARAM wParam, LPARAM lParam);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-icontextmenu3
@GUID("bcfce0a0-ec17-11d0-8d10-00a0c90f2719")
interface IContextMenu3 : IContextMenu2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icontextmenu3-handlemenumsg2
    HRESULT HandleMenuMsg2(uint uMsg, WPARAM wParam, LPARAM lParam, LRESULT* plResult);
}

@GUID("4b770da6-d111-4015-96fd-8c1c56f06c55")
interface IStaticVerbProvider : IUnknown
{
    HRESULT IsVerbSupported(const(PWSTR) verbName, BOOL* result);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iexecutecommand
@GUID("7f9185b0-cb92-43c5-80a9-92277a4f7b54")
interface IExecuteCommand : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexecutecommand-setkeystate
    HRESULT SetKeyState(uint grfKeyState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexecutecommand-setparameters
    HRESULT SetParameters(const(PWSTR) pszParameters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexecutecommand-setposition
    HRESULT SetPosition(POINT pt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexecutecommand-setshowwindow
    HRESULT SetShowWindow(int nShow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexecutecommand-setnoshowui
    HRESULT SetNoShowUI(BOOL fNoShowUI);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexecutecommand-setdirectory
    HRESULT SetDirectory(const(PWSTR) pszDirectory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexecutecommand-execute
    HRESULT Execute();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ipersistfolder
@GUID("000214ea-0000-0000-c000-000000000046")
interface IPersistFolder : IPersist
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipersistfolder-initialize
    HRESULT Initialize(ITEMIDLIST* pidl);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-irunnabletask
@GUID("85788d00-6807-11d0-b810-00c04fd706ec")
interface IRunnableTask : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-irunnabletask-run
    HRESULT Run();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-irunnabletask-kill
    HRESULT Kill(BOOL bWait);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-irunnabletask-suspend
    HRESULT Suspend();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-irunnabletask-resume
    HRESULT Resume();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-irunnabletask-isrunning
    uint    IsRunning();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishelltaskscheduler
@GUID("6ccb7be0-6807-11d0-b810-00c04fd706ec")
interface IShellTaskScheduler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelltaskscheduler-addtask
    HRESULT AddTask(IRunnableTask prt, const(GUID)* rtoid, size_t lParam, uint dwPriority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelltaskscheduler-removetasks
    HRESULT RemoveTasks(const(GUID)* rtoid, size_t lParam, BOOL bWaitIfRunning);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelltaskscheduler-counttasks
    uint    CountTasks(const(GUID)* rtoid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelltaskscheduler-status
    HRESULT Status(uint dwReleaseStatus, uint dwThreadTimeout);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ipersistfolder2
@GUID("1ac3d9f0-175c-11d1-95be-00609797ea4f")
interface IPersistFolder2 : IPersistFolder
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipersistfolder2-getcurfolder
    HRESULT GetCurFolder(ITEMIDLIST** ppidl);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ipersistfolder3
@GUID("cef04fdf-fe72-11d2-87a5-00c04f6837cf")
interface IPersistFolder3 : IPersistFolder2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipersistfolder3-initializeex
    HRESULT InitializeEx(IBindCtx pbc, ITEMIDLIST* pidlRoot, const(PERSIST_FOLDER_TARGET_INFO)* ppfti);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipersistfolder3-getfoldertargetinfo
    HRESULT GetFolderTargetInfo(PERSIST_FOLDER_TARGET_INFO* ppfti);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ipersistidlist
@GUID("1079acfc-29bd-11d3-8e0d-00c04f6837d5")
interface IPersistIDList : IPersist
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipersistidlist-setidlist
    HRESULT SetIDList(ITEMIDLIST* pidl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipersistidlist-getidlist
    HRESULT GetIDList(ITEMIDLIST** ppidl);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ienumidlist
@GUID("000214f2-0000-0000-c000-000000000046")
interface IEnumIDList : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Next(uint celt, ITEMIDLIST** rgelt, uint* pceltFetched);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Skip(uint celt);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Reset();
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Clone(IEnumIDList* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ienumfullidlist
@GUID("d0191542-7954-4908-bc06-b2360bbe45ba")
interface IEnumFullIDList : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Next(uint celt, ITEMIDLIST** rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumfullidlist-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumfullidlist-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumfullidlist-clone
    HRESULT Clone(IEnumFullIDList* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ifilesyncmergehandler
@GUID("d97b5aac-c792-433c-975d-35c4eadc7a9d")
interface IFileSyncMergeHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifilesyncmergehandler-merge
    HRESULT Merge(const(PWSTR) localFilePath, const(PWSTR) serverFilePath, MERGE_UPDATE_STATUS* updateStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifilesyncmergehandler-showresolveconflictuiasync
    HRESULT ShowResolveConflictUIAsync(const(PWSTR) localFilePath, HMONITOR monitorToDisplayOn);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iobjectwithfolderenummode
@GUID("6a9d9026-0e6e-464c-b000-42ecc07de673")
interface IObjectWithFolderEnumMode : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iobjectwithfolderenummode-setmode
    HRESULT SetMode(FOLDER_ENUM_MODE feMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iobjectwithfolderenummode-getmode
    HRESULT GetMode(FOLDER_ENUM_MODE* pfeMode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iparseandcreateitem
@GUID("67efed0e-e827-4408-b493-78f3982b685c")
interface IParseAndCreateItem : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iparseandcreateitem-setitem
    HRESULT SetItem(IShellItem psi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iparseandcreateitem-getitem
    HRESULT GetItem(const(GUID)* riid, void** ppv);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishellfolder
@GUID("000214e6-0000-0000-c000-000000000046")
interface IShellFolder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellfolder-parsedisplayname
    HRESULT ParseDisplayName(HWND hwnd, IBindCtx pbc, PWSTR pszDisplayName, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint* pchEaten, 
                             ITEMIDLIST** ppidl, uint* pdwAttributes);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT EnumObjects(HWND hwnd, uint grfFlags, IEnumIDList* ppenumIDList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellfolder-bindtoobject
    HRESULT BindToObject(ITEMIDLIST* pidl, IBindCtx pbc, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellfolder-bindtostorage
    HRESULT BindToStorage(ITEMIDLIST* pidl, IBindCtx pbc, const(GUID)* riid, void** ppv);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT CompareIDs(LPARAM lParam, ITEMIDLIST* pidl1, ITEMIDLIST* pidl2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellfolder-createviewobject
    HRESULT CreateViewObject(HWND hwndOwner, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellfolder-getattributesof
    HRESULT GetAttributesOf(uint cidl, ITEMIDLIST** apidl, uint* rgfInOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellfolder-getuiobjectof
    HRESULT GetUIObjectOf(HWND hwndOwner, uint cidl, ITEMIDLIST** apidl, const(GUID)* riid, 
                          /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint* rgfReserved, 
                          void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellfolder-getdisplaynameof
    HRESULT GetDisplayNameOf(ITEMIDLIST* pidl, SHGDNF uFlags, STRRET* pName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellfolder-setnameof
    HRESULT SetNameOf(HWND hwnd, ITEMIDLIST* pidl, const(PWSTR) pszName, SHGDNF uFlags, ITEMIDLIST** ppidlOut);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ienumextrasearch
@GUID("0e700be1-9db6-11d1-a1ce-00c04fd75d13")
interface IEnumExtraSearch : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumextrasearch-next
    HRESULT Next(uint celt, EXTRASEARCH* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumextrasearch-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumextrasearch-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumextrasearch-clone
    HRESULT Clone(IEnumExtraSearch* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishellfolder2
@GUID("93f2f68c-1d1b-11d3-a30e-00c04f79abd1")
interface IShellFolder2 : IShellFolder
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellfolder2-getdefaultsearchguid
    HRESULT GetDefaultSearchGUID(GUID* pguid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellfolder2-enumsearches
    HRESULT EnumSearches(IEnumExtraSearch* ppenum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellfolder2-getdefaultcolumn
    HRESULT GetDefaultColumn(uint dwRes, uint* pSort, uint* pDisplay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellfolder2-getdefaultcolumnstate
    HRESULT GetDefaultColumnState(uint iColumn, SHCOLSTATE* pcsFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellfolder2-getdetailsex
    HRESULT GetDetailsEx(ITEMIDLIST* pidl, const(PROPERTYKEY)* pscid, VARIANT* pv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellfolder2-getdetailsof
    HRESULT GetDetailsOf(ITEMIDLIST* pidl, uint iColumn, SHELLDETAILS* psd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellfolder2-mapcolumntoscid
    HRESULT MapColumnToSCID(uint iColumn, PROPERTYKEY* pscid);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishellview
@GUID("000214e3-0000-0000-c000-000000000046")
interface IShellView : IOleWindow
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT TranslateAccelerator(MSG* pmsg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellview-enablemodeless
    HRESULT EnableModeless(BOOL fEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellview-uiactivate
    HRESULT UIActivate(uint uState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellview-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellview-createviewwindow
    HRESULT CreateViewWindow(IShellView psvPrevious, FOLDERSETTINGS* pfs, IShellBrowser psb, RECT* prcView, 
                             HWND* phWnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellview-destroyviewwindow
    HRESULT DestroyViewWindow();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellview-getcurrentinfo
    HRESULT GetCurrentInfo(FOLDERSETTINGS* pfs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellview-addpropertysheetpages
    HRESULT AddPropertySheetPages(uint dwReserved, LPFNSVADDPROPSHEETPAGE pfn, LPARAM lparam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellview-saveviewstate
    HRESULT SaveViewState();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellview-selectitem
    HRESULT SelectItem(ITEMIDLIST* pidlItem, uint uFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellview-getitemobject
    HRESULT GetItemObject(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(_SVGIO))], [])*/uint uItem, 
                          const(GUID)* riid, void** ppv);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishellview2
@GUID("88e39e80-3578-11cf-ae69-08002b2e1262")
interface IShellView2 : IShellView
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellview2-getview
    HRESULT GetView(GUID* pvid, uint uView);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellview2-createviewwindow2
    HRESULT CreateViewWindow2(SV2CVW2_PARAMS* lpParams);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellview2-handlerename
    HRESULT HandleRename(ITEMIDLIST* pidlNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellview2-selectandpositionitem
    HRESULT SelectAndPositionItem(ITEMIDLIST* pidlItem, uint uFlags, POINT* ppt);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ifolderview
@GUID("cde725b0-ccc9-4519-917e-325d72fab4ce")
interface IFolderView : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview-getcurrentviewmode
    HRESULT GetCurrentViewMode(uint* pViewMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview-setcurrentviewmode
    HRESULT SetCurrentViewMode(uint ViewMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview-getfolder
    HRESULT GetFolder(const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview-item
    HRESULT Item(int iItemIndex, ITEMIDLIST** ppidl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview-itemcount
    HRESULT ItemCount(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(_SVGIO))], [])*/uint uFlags, 
                      int* pcItems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview-items
    HRESULT Items(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(_SVGIO))], [])*/uint uFlags, 
                  const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview-getselectionmarkeditem
    HRESULT GetSelectionMarkedItem(int* piItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview-getfocuseditem
    HRESULT GetFocusedItem(int* piItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview-getitemposition
    HRESULT GetItemPosition(ITEMIDLIST* pidl, POINT* ppt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview-getspacing
    HRESULT GetSpacing(POINT* ppt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview-getdefaultspacing
    HRESULT GetDefaultSpacing(POINT* ppt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview-getautoarrange
    HRESULT GetAutoArrange();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview-selectitem
    HRESULT SelectItem(int iItem, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview-selectandpositionitems
    HRESULT SelectAndPositionItems(uint cidl, ITEMIDLIST** apidl, POINT* apt, uint dwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ifolderview2
@GUID("1af3a467-214f-4298-908e-06b03e0b39f9")
interface IFolderView2 : IFolderView
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-setgroupby
    HRESULT SetGroupBy(const(PROPERTYKEY)* key, BOOL fAscending);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-getgroupby
    HRESULT GetGroupBy(PROPERTYKEY* pkey, BOOL* pfAscending);
    deprecated("marked as obsolete") 
    HRESULT SetViewProperty(ITEMIDLIST* pidl, const(PROPERTYKEY)* propkey, const(PROPVARIANT)* propvar);
    deprecated("marked as obsolete") 
    HRESULT GetViewProperty(ITEMIDLIST* pidl, const(PROPERTYKEY)* propkey, PROPVARIANT* ppropvar);
    deprecated("marked as obsolete") 
    HRESULT SetTileViewProperties(ITEMIDLIST* pidl, const(PWSTR) pszPropList);
    deprecated("marked as obsolete") 
    HRESULT SetExtendedTileViewProperties(ITEMIDLIST* pidl, const(PWSTR) pszPropList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-settext
    HRESULT SetText(FVTEXTTYPE iType, const(PWSTR) pwszText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-setcurrentfolderflags
    HRESULT SetCurrentFolderFlags(uint dwMask, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-getcurrentfolderflags
    HRESULT GetCurrentFolderFlags(uint* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-getsortcolumncount
    HRESULT GetSortColumnCount(int* pcColumns);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-setsortcolumns
    HRESULT SetSortColumns(const(SORTCOLUMN)* rgSortColumns, int cColumns);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-getsortcolumns
    HRESULT GetSortColumns(SORTCOLUMN* rgSortColumns, int cColumns);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-getitem
    HRESULT GetItem(int iItem, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-getvisibleitem
    HRESULT GetVisibleItem(int iStart, BOOL fPrevious, int* piItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-getselecteditem
    HRESULT GetSelectedItem(int iStart, int* piItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-getselection
    HRESULT GetSelection(BOOL fNoneImpliesFolder, IShellItemArray* ppsia);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-getselectionstate
    HRESULT GetSelectionState(ITEMIDLIST* pidl, uint* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-invokeverbonselection
    HRESULT InvokeVerbOnSelection(const(PSTR) pszVerb);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-setviewmodeandiconsize
    HRESULT SetViewModeAndIconSize(FOLDERVIEWMODE uViewMode, int iImageSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-getviewmodeandiconsize
    HRESULT GetViewModeAndIconSize(FOLDERVIEWMODE* puViewMode, int* piImageSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-setgroupsubsetcount
    HRESULT SetGroupSubsetCount(uint cVisibleRows);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-getgroupsubsetcount
    HRESULT GetGroupSubsetCount(uint* pcVisibleRows);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-setredraw
    HRESULT SetRedraw(BOOL fRedrawOn);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-ismoveinsamefolder
    HRESULT IsMoveInSameFolder();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview2-dorename
    HRESULT DoRename();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ifolderviewsettings
@GUID("ae8c987d-8797-4ed3-be72-2a47dd938db0")
interface IFolderViewSettings : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderviewsettings-getcolumnpropertylist
    HRESULT GetColumnPropertyList(const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderviewsettings-getgroupbyproperty
    HRESULT GetGroupByProperty(PROPERTYKEY* pkey, BOOL* pfGroupAscending);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderviewsettings-getviewmode
    HRESULT GetViewMode(FOLDERLOGICALVIEWMODE* plvm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderviewsettings-geticonsize
    HRESULT GetIconSize(uint* puIconSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderviewsettings-getfolderflags
    HRESULT GetFolderFlags(FOLDERFLAGS* pfolderMask, FOLDERFLAGS* pfolderFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderviewsettings-getsortcolumns
    HRESULT GetSortColumns(SORTCOLUMN* rgSortColumns, uint cColumnsIn, uint* pcColumnsOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderviewsettings-getgroupsubsetcount
    HRESULT GetGroupSubsetCount(uint* pcVisibleRows);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-iinitializenetworkfolder
@GUID("6e0f9881-42a8-4f2a-97f8-8af4e026d92d")
interface IInitializeNetworkFolder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iinitializenetworkfolder-initialize
    HRESULT Initialize(ITEMIDLIST* pidl, ITEMIDLIST* pidlTarget, uint uDisplayType, const(PWSTR) pszResName, 
                       const(PWSTR) pszProvider);
}

@GUID("ceb38218-c971-47bb-a703-f0bc99ccdb81")
interface INetworkFolderInternal : IUnknown
{
    HRESULT GetResourceDisplayType(uint* displayType);
    HRESULT GetIDList(ITEMIDLIST** idList);
    HRESULT GetProvider(uint itemIdCount, ITEMIDLIST** itemIds, uint providerMaxLength, PWSTR provider);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ipreviewhandlervisuals
@GUID("196bf9a5-b346-4ef0-aa1e-5dcdb76768b1")
interface IPreviewHandlerVisuals : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipreviewhandlervisuals-setbackgroundcolor
    HRESULT SetBackgroundColor(COLORREF color);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipreviewhandlervisuals-setfont
    HRESULT SetFont(const(LOGFONTW)* plf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipreviewhandlervisuals-settextcolor
    HRESULT SetTextColor(COLORREF color);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-icommdlgbrowser
@GUID("000214f1-0000-0000-c000-000000000046")
interface ICommDlgBrowser : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icommdlgbrowser-ondefaultcommand
    HRESULT OnDefaultCommand(IShellView ppshv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icommdlgbrowser-onstatechange
    HRESULT OnStateChange(IShellView ppshv, uint uChange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icommdlgbrowser-includeobject
    HRESULT IncludeObject(IShellView ppshv, ITEMIDLIST* pidl);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-icommdlgbrowser2
@GUID("10339516-2894-11d2-9039-00c04f8eeb3e")
interface ICommDlgBrowser2 : ICommDlgBrowser
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icommdlgbrowser2-notify
    HRESULT Notify(IShellView ppshv, uint dwNotifyType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icommdlgbrowser2-getdefaultmenutext
    HRESULT GetDefaultMenuText(IShellView ppshv, PWSTR pszText, int cchMax);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icommdlgbrowser2-getviewflags
    HRESULT GetViewFlags(uint* pdwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-icolumnmanager
@GUID("d8ec27bb-3f3b-4042-b10a-4acfd924d453")
interface IColumnManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icolumnmanager-setcolumninfo
    HRESULT SetColumnInfo(const(PROPERTYKEY)* propkey, const(CM_COLUMNINFO)* pcmci);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icolumnmanager-getcolumninfo
    HRESULT GetColumnInfo(const(PROPERTYKEY)* propkey, CM_COLUMNINFO* pcmci);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icolumnmanager-getcolumncount
    HRESULT GetColumnCount(CM_ENUM_FLAGS dwFlags, uint* puCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icolumnmanager-getcolumns
    HRESULT GetColumns(CM_ENUM_FLAGS dwFlags, PROPERTYKEY* rgkeyOrder, uint cColumns);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icolumnmanager-setcolumns
    HRESULT SetColumns(const(PROPERTYKEY)* rgkeyOrder, uint cVisible);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ifolderfiltersite
@GUID("c0a651f5-b48b-11d2-b5ed-006097c686f6")
interface IFolderFilterSite : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderfiltersite-setfilter
    HRESULT SetFilter(IUnknown punk);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ifolderfilter
@GUID("9cc22886-dc8e-11d2-b1d0-00c04f8eeb3e")
interface IFolderFilter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderfilter-shouldshow
    HRESULT ShouldShow(IShellFolder psf, ITEMIDLIST* pidlFolder, ITEMIDLIST* pidlItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderfilter-getenumflags
    HRESULT GetEnumFlags(IShellFolder psf, ITEMIDLIST* pidlFolder, HWND* phwnd, uint* pgrfFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iinputobjectsite
@GUID("f1db8392-7331-11d0-8c99-00a0c92dbfe8")
interface IInputObjectSite : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iinputobjectsite-onfocuschangeis
    HRESULT OnFocusChangeIS(IUnknown punkObj, BOOL fSetFocus);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iinputobject
@GUID("68284faa-6a48-11d0-8c78-00c04fd918b4")
interface IInputObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iinputobject-uiactivateio
    HRESULT UIActivateIO(BOOL fActivate, MSG* pMsg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iinputobject-hasfocusio
    HRESULT HasFocusIO();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iinputobject-translateacceleratorio
    HRESULT TranslateAcceleratorIO(MSG* pMsg);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iinputobject2
@GUID("6915c085-510b-44cd-94af-28dfa56cf92b")
interface IInputObject2 : IInputObject
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iinputobject2-translateacceleratorglobal
    HRESULT TranslateAcceleratorGlobal(MSG* pMsg);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishellicon
@GUID("000214e5-0000-0000-c000-000000000046")
interface IShellIcon : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellicon-geticonof
    HRESULT GetIconOf(ITEMIDLIST* pidl, uint flags, int* pIconIndex);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishellbrowser
@GUID("000214e2-0000-0000-c000-000000000046")
interface IShellBrowser : IOleWindow
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellbrowser-insertmenussb
    HRESULT InsertMenusSB(HMENU hmenuShared, OLEMENUGROUPWIDTHS* lpMenuWidths);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellbrowser-setmenusb
    HRESULT SetMenuSB(HMENU hmenuShared, ptrdiff_t holemenuRes, HWND hwndActiveObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellbrowser-removemenussb
    HRESULT RemoveMenusSB(HMENU hmenuShared);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellbrowser-setstatustextsb
    HRESULT SetStatusTextSB(const(PWSTR) pszStatusText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellbrowser-enablemodelesssb
    HRESULT EnableModelessSB(BOOL fEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellbrowser-translateacceleratorsb
    HRESULT TranslateAcceleratorSB(MSG* pmsg, ushort wID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellbrowser-browseobject
    HRESULT BrowseObject(ITEMIDLIST* pidl, uint wFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellbrowser-getviewstatestream
    HRESULT GetViewStateStream(uint grfMode, IStream* ppStrm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellbrowser-getcontrolwindow
    HRESULT GetControlWindow(uint id, HWND* phwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellbrowser-sendcontrolmsg
    HRESULT SendControlMsg(uint id, uint uMsg, WPARAM wParam, LPARAM lParam, LRESULT* pret);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellbrowser-queryactiveshellview
    HRESULT QueryActiveShellView(IShellView* ppshv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellbrowser-onviewwindowactive
    HRESULT OnViewWindowActive(IShellView pshv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellbrowser-settoolbaritems
    HRESULT SetToolbarItems(TBBUTTON* lpButtons, uint nButtons, uint uFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iprofferservice
@GUID("cb728b20-f786-11ce-92ad-00aa00a74cd0")
interface IProfferService : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iprofferservice-profferservice
    HRESULT ProfferService(const(GUID)* serviceId, IServiceProvider serviceProvider, uint* cookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iprofferservice-revokeservice
    HRESULT RevokeService(uint cookie);
}

@GUID("4a073526-6103-4e21-b7bc-f519d1524e5d")
interface IGetServiceIds : IUnknown
{
    HRESULT GetServiceIds(uint* serviceIdCount, GUID** serviceIds);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishellitem
@GUID("43826d1e-e718-42ee-bc55-a1e261c37bfe")
interface IShellItem : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitem-bindtohandler
    HRESULT BindToHandler(IBindCtx pbc, const(GUID)* bhid, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitem-getparent
    HRESULT GetParent(IShellItem* ppsi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitem-getdisplayname
    HRESULT GetDisplayName(SIGDN sigdnName, PWSTR* ppszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitem-getattributes
    HRESULT GetAttributes(SFGAO_FLAGS sfgaoMask, SFGAO_FLAGS* psfgaoAttribs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitem-compare
    HRESULT Compare(IShellItem psi, uint hint, int* piOrder);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishellitem2
@GUID("7e9fb0d3-919f-4307-ab2e-9b1860310c93")
interface IShellItem2 : IShellItem
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitem2-getpropertystore
    HRESULT GetPropertyStore(GETPROPERTYSTOREFLAGS flags, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitem2-getpropertystorewithcreateobject
    HRESULT GetPropertyStoreWithCreateObject(GETPROPERTYSTOREFLAGS flags, IUnknown punkCreateObject, 
                                             const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitem2-getpropertystoreforkeys
    HRESULT GetPropertyStoreForKeys(const(PROPERTYKEY)* rgKeys, uint cKeys, GETPROPERTYSTOREFLAGS flags, 
                                    const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitem2-getpropertydescriptionlist
    HRESULT GetPropertyDescriptionList(const(PROPERTYKEY)* keyType, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitem2-update
    HRESULT Update(IBindCtx pbc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitem2-getproperty
    HRESULT GetProperty(const(PROPERTYKEY)* key, PROPVARIANT* ppropvar);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitem2-getclsid
    HRESULT GetCLSID(const(PROPERTYKEY)* key, GUID* pclsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitem2-getfiletime
    HRESULT GetFileTime(const(PROPERTYKEY)* key, FILETIME* pft);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitem2-getint32
    HRESULT GetInt32(const(PROPERTYKEY)* key, int* pi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitem2-getstring
    HRESULT GetString(const(PROPERTYKEY)* key, PWSTR* ppsz);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitem2-getuint32
    HRESULT GetUInt32(const(PROPERTYKEY)* key, uint* pui);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitem2-getuint64
    HRESULT GetUInt64(const(PROPERTYKEY)* key, ulong* pull);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitem2-getbool
    HRESULT GetBool(const(PROPERTYKEY)* key, BOOL* pf);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishellitemimagefactory
@GUID("bcc18b79-ba16-442f-80c4-8a59c30c463b")
interface IShellItemImageFactory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitemimagefactory-getimage
    HRESULT GetImage(SIZE size, SIIGBF flags, HBITMAP* phbm);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ienumshellitems
@GUID("70629033-e363-4a28-a567-0db78006e6d7")
interface IEnumShellItems : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumshellitems-next
    HRESULT Next(uint celt, IShellItem* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumshellitems-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumshellitems-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumshellitems-clone
    HRESULT Clone(IEnumShellItems* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-itransferadvisesink
@GUID("d594d0d8-8da7-457b-b3b4-ce5dbaac0b88")
interface ITransferAdviseSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransferadvisesink-updateprogress
    HRESULT UpdateProgress(ulong ullSizeCurrent, ulong ullSizeTotal, int nFilesCurrent, int nFilesTotal, 
                           int nFoldersCurrent, int nFoldersTotal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransferadvisesink-updatetransferstate
    HRESULT UpdateTransferState(uint ts);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransferadvisesink-confirmoverwrite
    HRESULT ConfirmOverwrite(IShellItem psiSource, IShellItem psiDestParent, const(PWSTR) pszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransferadvisesink-confirmencryptionloss
    HRESULT ConfirmEncryptionLoss(IShellItem psiSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransferadvisesink-filefailure
    HRESULT FileFailure(IShellItem psi, const(PWSTR) pszItem, HRESULT hrError, PWSTR pszRename, uint cchRename);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransferadvisesink-substreamfailure
    HRESULT SubStreamFailure(IShellItem psi, const(PWSTR) pszStreamName, HRESULT hrError);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransferadvisesink-propertyfailure
    HRESULT PropertyFailure(IShellItem psi, const(PROPERTYKEY)* pkey, HRESULT hrError);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-itransfersource
@GUID("00adb003-bde9-45c6-8e29-d09f9353e108")
interface ITransferSource : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransfersource-advise
    HRESULT Advise(ITransferAdviseSink psink, uint* pdwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransfersource-unadvise
    HRESULT Unadvise(uint dwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransfersource-setproperties
    HRESULT SetProperties(IPropertyChangeArray pproparray);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransfersource-openitem
    HRESULT OpenItem(IShellItem psi, uint flags, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransfersource-moveitem
    HRESULT MoveItem(IShellItem psi, IShellItem psiParentDst, const(PWSTR) pszNameDst, uint flags, 
                     IShellItem* ppsiNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransfersource-recycleitem
    HRESULT RecycleItem(IShellItem psiSource, IShellItem psiParentDest, uint flags, IShellItem* ppsiNewDest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransfersource-removeitem
    HRESULT RemoveItem(IShellItem psiSource, uint flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransfersource-renameitem
    HRESULT RenameItem(IShellItem psiSource, const(PWSTR) pszNewName, uint flags, IShellItem* ppsiNewDest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransfersource-linkitem
    HRESULT LinkItem(IShellItem psiSource, IShellItem psiParentDest, const(PWSTR) pszNewName, uint flags, 
                     IShellItem* ppsiNewDest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransfersource-applypropertiestoitem
    HRESULT ApplyPropertiesToItem(IShellItem psiSource, IShellItem* ppsiNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransfersource-getdefaultdestinationname
    HRESULT GetDefaultDestinationName(IShellItem psiSource, IShellItem psiParentDest, PWSTR* ppszDestinationName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransfersource-enterfolder
    HRESULT EnterFolder(IShellItem psiChildFolderDest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransfersource-leavefolder
    HRESULT LeaveFolder(IShellItem psiChildFolderDest);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ienumresources
@GUID("2dd81fe3-a83c-4da9-a330-47249d345ba1")
interface IEnumResources : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumresources-next
    HRESULT Next(uint celt, SHELL_ITEM_RESOURCE* psir, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumresources-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumresources-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumresources-clone
    HRESULT Clone(IEnumResources* ppenumr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishellitemresources
@GUID("ff5693be-2ce0-4d48-b5c5-40817d1acdb9")
interface IShellItemResources : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitemresources-getattributes
    HRESULT GetAttributes(uint* pdwAttributes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitemresources-getsize
    HRESULT GetSize(ulong* pullSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitemresources-gettimes
    HRESULT GetTimes(FILETIME* pftCreation, FILETIME* pftWrite, FILETIME* pftAccess);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitemresources-settimes
    HRESULT SetTimes(const(FILETIME)* pftCreation, const(FILETIME)* pftWrite, const(FILETIME)* pftAccess);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitemresources-getresourcedescription
    HRESULT GetResourceDescription(const(SHELL_ITEM_RESOURCE)* pcsir, PWSTR* ppszDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitemresources-enumresources
    HRESULT EnumResources(IEnumResources* ppenumr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitemresources-supportsresource
    HRESULT SupportsResource(const(SHELL_ITEM_RESOURCE)* pcsir);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitemresources-openresource
    HRESULT OpenResource(const(SHELL_ITEM_RESOURCE)* pcsir, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitemresources-createresource
    HRESULT CreateResource(const(SHELL_ITEM_RESOURCE)* pcsir, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitemresources-markfordelete
    HRESULT MarkForDelete();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-itransferdestination
@GUID("48addd32-3ca5-4124-abe3-b5a72531b207")
interface ITransferDestination : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransferdestination-advise
    HRESULT Advise(ITransferAdviseSink psink, uint* pdwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransferdestination-unadvise
    HRESULT Unadvise(uint dwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itransferdestination-createitem
    HRESULT CreateItem(const(PWSTR) pszName, uint dwAttributes, ulong ullSize, uint flags, const(GUID)* riidItem, 
                       void** ppvItem, const(GUID)* riidResources, void** ppvResources);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ifileoperationprogresssink
@GUID("04b0f1a7-9490-44bc-96e1-4296a31252e2")
interface IFileOperationProgressSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperationprogresssink-startoperations
    HRESULT StartOperations();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperationprogresssink-finishoperations
    HRESULT FinishOperations(HRESULT hrResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperationprogresssink-prerenameitem
    HRESULT PreRenameItem(uint dwFlags, IShellItem psiItem, const(PWSTR) pszNewName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperationprogresssink-postrenameitem
    HRESULT PostRenameItem(uint dwFlags, IShellItem psiItem, const(PWSTR) pszNewName, HRESULT hrRename, 
                           IShellItem psiNewlyCreated);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperationprogresssink-premoveitem
    HRESULT PreMoveItem(uint dwFlags, IShellItem psiItem, IShellItem psiDestinationFolder, const(PWSTR) pszNewName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperationprogresssink-postmoveitem
    HRESULT PostMoveItem(uint dwFlags, IShellItem psiItem, IShellItem psiDestinationFolder, 
                         const(PWSTR) pszNewName, HRESULT hrMove, IShellItem psiNewlyCreated);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperationprogresssink-precopyitem
    HRESULT PreCopyItem(uint dwFlags, IShellItem psiItem, IShellItem psiDestinationFolder, const(PWSTR) pszNewName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperationprogresssink-postcopyitem
    HRESULT PostCopyItem(uint dwFlags, IShellItem psiItem, IShellItem psiDestinationFolder, 
                         const(PWSTR) pszNewName, HRESULT hrCopy, IShellItem psiNewlyCreated);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperationprogresssink-predeleteitem
    HRESULT PreDeleteItem(uint dwFlags, IShellItem psiItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperationprogresssink-postdeleteitem
    HRESULT PostDeleteItem(uint dwFlags, IShellItem psiItem, HRESULT hrDelete, IShellItem psiNewlyCreated);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperationprogresssink-prenewitem
    HRESULT PreNewItem(uint dwFlags, IShellItem psiDestinationFolder, const(PWSTR) pszNewName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperationprogresssink-postnewitem
    HRESULT PostNewItem(uint dwFlags, IShellItem psiDestinationFolder, const(PWSTR) pszNewName, 
                        const(PWSTR) pszTemplateName, uint dwFileAttributes, HRESULT hrNew, IShellItem psiNewItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperationprogresssink-updateprogress
    HRESULT UpdateProgress(uint iWorkTotal, uint iWorkSoFar);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperationprogresssink-resettimer
    HRESULT ResetTimer();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperationprogresssink-pausetimer
    HRESULT PauseTimer();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperationprogresssink-resumetimer
    HRESULT ResumeTimer();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishellitemarray
@GUID("b63ea76d-1f85-456f-a19c-48159efa858b")
interface IShellItemArray : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitemarray-bindtohandler
    HRESULT BindToHandler(IBindCtx pbc, const(GUID)* bhid, const(GUID)* riid, void** ppvOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitemarray-getpropertystore
    HRESULT GetPropertyStore(GETPROPERTYSTOREFLAGS flags, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitemarray-getpropertydescriptionlist
    HRESULT GetPropertyDescriptionList(const(PROPERTYKEY)* keyType, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitemarray-getattributes
    HRESULT GetAttributes(SIATTRIBFLAGS AttribFlags, SFGAO_FLAGS sfgaoMask, SFGAO_FLAGS* psfgaoAttribs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitemarray-getcount
    HRESULT GetCount(uint* pdwNumItems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitemarray-getitemat
    HRESULT GetItemAt(uint dwIndex, IShellItem* ppsi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitemarray-enumitems
    HRESULT EnumItems(IEnumShellItems* ppenumShellItems);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iinitializewithitem
@GUID("7f73be3f-fb79-493c-a6c7-7ee14e245841")
interface IInitializeWithItem : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iinitializewithitem-initialize
    HRESULT Initialize(IShellItem psi, uint grfMode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iobjectwithselection
@GUID("1c9cd5bb-98e9-4491-a60f-31aacc72b83c")
interface IObjectWithSelection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iobjectwithselection-setselection
    HRESULT SetSelection(IShellItemArray psia);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iobjectwithselection-getselection
    HRESULT GetSelection(const(GUID)* riid, void** ppv);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iobjectwithbackreferences
@GUID("321a6a6a-d61f-4bf3-97ae-14be2986bb36")
interface IObjectWithBackReferences : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iobjectwithbackreferences-removebackreferences
    HRESULT RemoveBackReferences();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-icategoryprovider
@GUID("9af64809-5864-4c26-a720-c1f78c086ee3")
interface ICategoryProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icategoryprovider-cancategorizeonscid
    HRESULT CanCategorizeOnSCID(const(PROPERTYKEY)* pscid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icategoryprovider-getdefaultcategory
    HRESULT GetDefaultCategory(GUID* pguid, PROPERTYKEY* pscid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icategoryprovider-getcategoryforscid
    HRESULT GetCategoryForSCID(const(PROPERTYKEY)* pscid, GUID* pguid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icategoryprovider-enumcategories
    HRESULT EnumCategories(IEnumGUID* penum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icategoryprovider-getcategoryname
    HRESULT GetCategoryName(const(GUID)* pguid, PWSTR pszName, uint cch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icategoryprovider-createcategory
    HRESULT CreateCategory(const(GUID)* pguid, const(GUID)* riid, void** ppv);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-icategorizer
@GUID("a3b14589-9174-49a8-89a3-06a1ae2b9ba7")
interface ICategorizer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icategorizer-getdescription
    HRESULT GetDescription(PWSTR pszDesc, uint cch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icategorizer-getcategory
    HRESULT GetCategory(uint cidl, ITEMIDLIST** apidl, uint* rgCategoryIds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icategorizer-getcategoryinfo
    HRESULT GetCategoryInfo(uint dwCategoryId, CATEGORY_INFO* pci);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icategorizer-comparecategory
    HRESULT CompareCategory(CATSORT_FLAGS csfFlags, uint dwCategoryId1, uint dwCategoryId2);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-idroptargethelper
@GUID("4657278b-411b-11d2-839a-00c04fd918d0")
interface IDropTargetHelper : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idroptargethelper-dragenter
    HRESULT DragEnter(HWND hwndTarget, IDataObject pDataObject, POINT* ppt, DROPEFFECT dwEffect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idroptargethelper-dragleave
    HRESULT DragLeave();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idroptargethelper-dragover
    HRESULT DragOver(POINT* ppt, DROPEFFECT dwEffect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idroptargethelper-drop
    HRESULT Drop(IDataObject pDataObject, POINT* ppt, DROPEFFECT dwEffect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idroptargethelper-show
    HRESULT Show(BOOL fShow);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-idragsourcehelper
@GUID("de5bf786-477a-11d2-839d-00c04fd918d0")
interface IDragSourceHelper : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idragsourcehelper-initializefrombitmap
    HRESULT InitializeFromBitmap(SHDRAGIMAGE* pshdi, IDataObject pDataObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idragsourcehelper-initializefromwindow
    HRESULT InitializeFromWindow(HWND hwnd, POINT* ppt, IDataObject pDataObject);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishelllinka
@GUID("000214ee-0000-0000-c000-000000000046")
interface IShellLinkA : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinka-getpath
    HRESULT GetPath(PSTR pszFile, int cch, WIN32_FIND_DATAA* pfd, uint fFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinka-getidlist
    HRESULT GetIDList(ITEMIDLIST** ppidl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinka-setidlist
    HRESULT SetIDList(ITEMIDLIST* pidl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinka-getdescription
    HRESULT GetDescription(PSTR pszName, int cch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinka-setdescription
    HRESULT SetDescription(const(PSTR) pszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinka-getworkingdirectory
    HRESULT GetWorkingDirectory(PSTR pszDir, int cch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinka-setworkingdirectory
    HRESULT SetWorkingDirectory(const(PSTR) pszDir);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinka-getarguments
    HRESULT GetArguments(PSTR pszArgs, int cch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinka-setarguments
    HRESULT SetArguments(const(PSTR) pszArgs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinka-gethotkey
    HRESULT GetHotkey(ushort* pwHotkey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinka-sethotkey
    HRESULT SetHotkey(ushort wHotkey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinka-getshowcmd
    HRESULT GetShowCmd(SHOW_WINDOW_CMD* piShowCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinka-setshowcmd
    HRESULT SetShowCmd(SHOW_WINDOW_CMD iShowCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinka-geticonlocation
    HRESULT GetIconLocation(PSTR pszIconPath, int cch, int* piIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinka-seticonlocation
    HRESULT SetIconLocation(const(PSTR) pszIconPath, int iIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinka-setrelativepath
    HRESULT SetRelativePath(const(PSTR) pszPathRel, uint dwReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinka-resolve
    HRESULT Resolve(HWND hwnd, uint fFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinka-setpath
    HRESULT SetPath(const(PSTR) pszFile);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishelllinkw
@GUID("000214f9-0000-0000-c000-000000000046")
interface IShellLinkW : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkw-getpath
    HRESULT GetPath(PWSTR pszFile, int cch, WIN32_FIND_DATAW* pfd, uint fFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkw-getidlist
    HRESULT GetIDList(ITEMIDLIST** ppidl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkw-setidlist
    HRESULT SetIDList(ITEMIDLIST* pidl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkw-getdescription
    HRESULT GetDescription(PWSTR pszName, int cch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkw-setdescription
    HRESULT SetDescription(const(PWSTR) pszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkw-getworkingdirectory
    HRESULT GetWorkingDirectory(PWSTR pszDir, int cch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkw-setworkingdirectory
    HRESULT SetWorkingDirectory(const(PWSTR) pszDir);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkw-getarguments
    HRESULT GetArguments(PWSTR pszArgs, int cch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkw-setarguments
    HRESULT SetArguments(const(PWSTR) pszArgs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkw-gethotkey
    HRESULT GetHotkey(ushort* pwHotkey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkw-sethotkey
    HRESULT SetHotkey(ushort wHotkey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkw-getshowcmd
    HRESULT GetShowCmd(SHOW_WINDOW_CMD* piShowCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkw-setshowcmd
    HRESULT SetShowCmd(SHOW_WINDOW_CMD iShowCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkw-geticonlocation
    HRESULT GetIconLocation(PWSTR pszIconPath, int cch, int* piIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkw-seticonlocation
    HRESULT SetIconLocation(const(PWSTR) pszIconPath, int iIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkw-setrelativepath
    HRESULT SetRelativePath(const(PWSTR) pszPathRel, uint dwReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkw-resolve
    HRESULT Resolve(HWND hwnd, uint fFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkw-setpath
    HRESULT SetPath(const(PWSTR) pszFile);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishelllinkdatalist
@GUID("45e2b4ae-b1c3-11d0-b92f-00a0c90312e1")
interface IShellLinkDataList : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkdatalist-adddatablock
    HRESULT AddDataBlock(void* pDataBlock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkdatalist-copydatablock
    HRESULT CopyDataBlock(uint dwSig, void** ppDataBlock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkdatalist-removedatablock
    HRESULT RemoveDataBlock(uint dwSig);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkdatalist-getflags
    HRESULT GetFlags(uint* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllinkdatalist-setflags
    HRESULT SetFlags(uint dwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iresolveshelllink
@GUID("5cd52983-9449-11d2-963a-00c04f79adf0")
interface IResolveShellLink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iresolveshelllink-resolveshelllink
    HRESULT ResolveShellLink(IUnknown punkLink, HWND hwnd, uint fFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iactionprogressdialog
@GUID("49ff1172-eadc-446d-9285-156453a6431c")
interface IActionProgressDialog : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iactionprogressdialog-initialize
    HRESULT Initialize(uint flags, const(PWSTR) pszTitle, const(PWSTR) pszCancel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iactionprogressdialog-stop
    HRESULT Stop();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iactionprogress
@GUID("49ff1173-eadc-446d-9285-156453a6431c")
interface IActionProgress : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iactionprogress-begin
    HRESULT Begin(SPACTION action, uint flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iactionprogress-updateprogress
    HRESULT UpdateProgress(ulong ulCompleted, ulong ulTotal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iactionprogress-updatetext
    HRESULT UpdateText(SPTEXT sptext, const(PWSTR) pszText, BOOL fMayCompact);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iactionprogress-querycancel
    HRESULT QueryCancel(BOOL* pfCancelled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iactionprogress-resetcancel
    HRESULT ResetCancel();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iactionprogress-end
    HRESULT End();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishellextinit
@GUID("000214e8-0000-0000-c000-000000000046")
interface IShellExtInit : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellextinit-initialize
    HRESULT Initialize(ITEMIDLIST* pidlFolder, IDataObject pdtobj, HKEY hkeyProgID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishellpropsheetext
@GUID("000214e9-0000-0000-c000-000000000046")
interface IShellPropSheetExt : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellpropsheetext-addpages
    HRESULT AddPages(LPFNSVADDPROPSHEETPAGE pfnAddPage, LPARAM lParam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellpropsheetext-replacepage
    HRESULT ReplacePage(uint uPageID, LPFNSVADDPROPSHEETPAGE pfnReplaceWith, LPARAM lParam);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iremotecomputer
@GUID("000214fe-0000-0000-c000-000000000046")
interface IRemoteComputer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iremotecomputer-initialize
    HRESULT Initialize(const(PWSTR) pszMachine, BOOL bEnumerating);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iquerycontinue
@GUID("7307055c-b24a-486b-9f25-163e597a28a9")
interface IQueryContinue : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iquerycontinue-querycontinue
    HRESULT QueryContinue();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iobjectwithcancelevent
@GUID("f279b885-0ae9-4b85-ac06-ddecf9408941")
interface IObjectWithCancelEvent : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iobjectwithcancelevent-getcancelevent
    HRESULT GetCancelEvent(HANDLE* phEvent);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iusernotification
@GUID("ba9711ba-5893-4787-a7e1-41277151550b")
interface IUserNotification : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iusernotification-setballooninfo
    HRESULT SetBalloonInfo(const(PWSTR) pszTitle, const(PWSTR) pszText, uint dwInfoFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iusernotification-setballoonretry
    HRESULT SetBalloonRetry(uint dwShowTime, uint dwInterval, uint cRetryCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iusernotification-seticoninfo
    HRESULT SetIconInfo(HICON hIcon, const(PWSTR) pszToolTip);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iusernotification-show
    HRESULT Show(IQueryContinue pqc, uint dwContinuePollInterval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iusernotification-playsound
    HRESULT PlaySound(const(PWSTR) pszSoundName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iitemnamelimits
@GUID("1df0d7f1-b267-4d28-8b10-12e23202a5c4")
interface IItemNameLimits : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iitemnamelimits-getvalidcharacters
    HRESULT GetValidCharacters(PWSTR* ppwszValidChars, PWSTR* ppwszInvalidChars);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iitemnamelimits-getmaxlength
    HRESULT GetMaxLength(const(PWSTR) pszName, int* piMaxNameLen);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-isearchfolderitemfactory
@GUID("a0ffbc28-5482-4366-be27-3e81e78e06c2")
interface ISearchFolderItemFactory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isearchfolderitemfactory-setdisplayname
    HRESULT SetDisplayName(const(PWSTR) pszDisplayName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isearchfolderitemfactory-setfoldertypeid
    HRESULT SetFolderTypeID(GUID ftid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isearchfolderitemfactory-setfolderlogicalviewmode
    HRESULT SetFolderLogicalViewMode(FOLDERLOGICALVIEWMODE flvm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isearchfolderitemfactory-seticonsize
    HRESULT SetIconSize(int iIconSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isearchfolderitemfactory-setvisiblecolumns
    HRESULT SetVisibleColumns(uint cVisibleColumns, const(PROPERTYKEY)* rgKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isearchfolderitemfactory-setsortcolumns
    HRESULT SetSortColumns(uint cSortColumns, SORTCOLUMN* rgSortColumns);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isearchfolderitemfactory-setgroupcolumn
    HRESULT SetGroupColumn(const(PROPERTYKEY)* keyGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isearchfolderitemfactory-setstacks
    HRESULT SetStacks(uint cStackKeys, PROPERTYKEY* rgStackKeys);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isearchfolderitemfactory-setscope
    HRESULT SetScope(IShellItemArray psiaScope);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isearchfolderitemfactory-setcondition
    HRESULT SetCondition(ICondition pCondition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isearchfolderitemfactory-getshellitem
    HRESULT GetShellItem(const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isearchfolderitemfactory-getidlist
    HRESULT GetIDList(ITEMIDLIST** ppidl);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iextractimage
@GUID("bb2e617c-0920-11d1-9a0b-00c04fc2d6c1")
interface IExtractImage : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iextractimage-getlocation
    HRESULT GetLocation(PWSTR pszPathBuffer, uint cch, uint* pdwPriority, const(SIZE)* prgSize, uint dwRecClrDepth, 
                        uint* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iextractimage-extract
    HRESULT Extract(HBITMAP* phBmpThumbnail);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iextractimage2
@GUID("953bb1ee-93b4-11d1-98a3-00c04fb687da")
interface IExtractImage2 : IExtractImage
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iextractimage2-getdatestamp
    HRESULT GetDateStamp(FILETIME* pDateStamp);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ithumbnailhandlerfactory
@GUID("e35b4b2e-00da-4bc1-9f13-38bc11f5d417")
interface IThumbnailHandlerFactory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ithumbnailhandlerfactory-getthumbnailhandler
    HRESULT GetThumbnailHandler(ITEMIDLIST* pidlChild, IBindCtx pbc, const(GUID)* riid, void** ppv);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iparentanditem
@GUID("b3a4b685-b685-4805-99d9-5dead2873236")
interface IParentAndItem : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iparentanditem-setparentanditem
    HRESULT SetParentAndItem(ITEMIDLIST* pidlParent, IShellFolder psf, ITEMIDLIST* pidlChild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iparentanditem-getparentanditem
    HRESULT GetParentAndItem(ITEMIDLIST** ppidlParent, IShellFolder* ppsf, ITEMIDLIST** ppidlChild);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-idockingwindow
@GUID("012dd920-7b26-11d0-8ca9-00a0c92dbfe8")
interface IDockingWindow : IOleWindow
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idockingwindow-showdw
    HRESULT ShowDW(BOOL fShow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idockingwindow-closedw
    HRESULT CloseDW(uint dwReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idockingwindow-resizeborderdw
    HRESULT ResizeBorderDW(RECT* prcBorder, IUnknown punkToolbarSite, BOOL fReserved);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ideskband
@GUID("eb0fe172-1a3a-11d0-89b3-00a0c90a90ac")
interface IDeskBand : IDockingWindow
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ideskband-getbandinfo
    HRESULT GetBandInfo(uint dwBandID, uint dwViewMode, DESKBANDINFO* pdbi);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ideskbandinfo
@GUID("77e425fc-cbf9-4307-ba6a-bb5727745661")
interface IDeskBandInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ideskbandinfo-getdefaultbandwidth
    HRESULT GetDefaultBandWidth(uint dwBandID, uint dwViewMode, int* pnWidth);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-itaskbarlist
@GUID("56fdf342-fd6d-11d0-958a-006097c9a090")
interface ITaskbarList : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itaskbarlist-hrinit
    HRESULT HrInit();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itaskbarlist-addtab
    HRESULT AddTab(HWND hwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itaskbarlist-deletetab
    HRESULT DeleteTab(HWND hwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itaskbarlist-activatetab
    HRESULT ActivateTab(HWND hwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itaskbarlist-setactivealt
    HRESULT SetActiveAlt(HWND hwnd);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-itaskbarlist2
@GUID("602d4995-b13a-429b-a66e-1935e44f4317")
interface ITaskbarList2 : ITaskbarList
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itaskbarlist2-markfullscreenwindow
    HRESULT MarkFullscreenWindow(HWND hwnd, BOOL fFullscreen);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-itaskbarlist3
@GUID("ea1afb91-9e28-4b86-90e9-9e9f8a5eefaf")
interface ITaskbarList3 : ITaskbarList2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itaskbarlist3-setprogressvalue
    HRESULT SetProgressValue(HWND hwnd, ulong ullCompleted, ulong ullTotal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itaskbarlist3-setprogressstate
    HRESULT SetProgressState(HWND hwnd, TBPFLAG tbpFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itaskbarlist3-registertab
    HRESULT RegisterTab(HWND hwndTab, HWND hwndMDI);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itaskbarlist3-unregistertab
    HRESULT UnregisterTab(HWND hwndTab);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itaskbarlist3-settaborder
    HRESULT SetTabOrder(HWND hwndTab, HWND hwndInsertBefore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itaskbarlist3-settabactive
    HRESULT SetTabActive(HWND hwndTab, HWND hwndMDI, uint dwReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itaskbarlist3-thumbbaraddbuttons
    HRESULT ThumbBarAddButtons(HWND hwnd, uint cButtons, THUMBBUTTON* pButton);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itaskbarlist3-thumbbarupdatebuttons
    HRESULT ThumbBarUpdateButtons(HWND hwnd, uint cButtons, THUMBBUTTON* pButton);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itaskbarlist3-thumbbarsetimagelist
    HRESULT ThumbBarSetImageList(HWND hwnd, HIMAGELIST himl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itaskbarlist3-setoverlayicon
    HRESULT SetOverlayIcon(HWND hwnd, HICON hIcon, const(PWSTR) pszDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itaskbarlist3-setthumbnailtooltip
    HRESULT SetThumbnailTooltip(HWND hwnd, const(PWSTR) pszTip);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itaskbarlist3-setthumbnailclip
    HRESULT SetThumbnailClip(HWND hwnd, RECT* prcClip);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-itaskbarlist4
@GUID("c43dc798-95d1-4bea-9030-bb99e2983a1a")
interface ITaskbarList4 : ITaskbarList3
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-itaskbarlist4-settabproperties
    HRESULT SetTabProperties(HWND hwndTab, STPFLAG stpFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iexplorerbrowserevents
@GUID("361bbdc7-e6ee-4e13-be58-58e2240c810f")
interface IExplorerBrowserEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerbrowserevents-onnavigationpending
    HRESULT OnNavigationPending(ITEMIDLIST* pidlFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerbrowserevents-onviewcreated
    HRESULT OnViewCreated(IShellView psv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerbrowserevents-onnavigationcomplete
    HRESULT OnNavigationComplete(ITEMIDLIST* pidlFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerbrowserevents-onnavigationfailed
    HRESULT OnNavigationFailed(ITEMIDLIST* pidlFolder);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iexplorerbrowser
@GUID("dfd3b6b5-c10c-4be9-85f6-a66969f402f6")
interface IExplorerBrowser : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerbrowser-initialize
    HRESULT Initialize(HWND hwndParent, const(RECT)* prc, const(FOLDERSETTINGS)* pfs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerbrowser-destroy
    HRESULT Destroy();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerbrowser-setrect
    HRESULT SetRect(HDWP* phdwp, RECT rcBrowser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerbrowser-setpropertybag
    HRESULT SetPropertyBag(const(PWSTR) pszPropertyBag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerbrowser-setemptytext
    HRESULT SetEmptyText(const(PWSTR) pszEmptyText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerbrowser-setfoldersettings
    HRESULT SetFolderSettings(const(FOLDERSETTINGS)* pfs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerbrowser-advise
    HRESULT Advise(IExplorerBrowserEvents psbe, uint* pdwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerbrowser-unadvise
    HRESULT Unadvise(uint dwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerbrowser-setoptions
    HRESULT SetOptions(EXPLORER_BROWSER_OPTIONS dwFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerbrowser-getoptions
    HRESULT GetOptions(EXPLORER_BROWSER_OPTIONS* pdwFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerbrowser-browsetoidlist
    HRESULT BrowseToIDList(ITEMIDLIST* pidl, uint uFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerbrowser-browsetoobject
    HRESULT BrowseToObject(IUnknown punk, uint uFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerbrowser-fillfromobject
    HRESULT FillFromObject(IUnknown punk, EXPLORER_BROWSER_FILL_FLAGS dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerbrowser-removeall
    HRESULT RemoveAll();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerbrowser-getcurrentview
    HRESULT GetCurrentView(const(GUID)* riid, void** ppv);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ienumobjects
@GUID("2c1c7e2e-2d0e-4059-831e-1e6f82335c2e")
interface IEnumObjects : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumobjects-next
    HRESULT Next(uint celt, const(GUID)* riid, void** rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumobjects-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumobjects-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumobjects-clone
    HRESULT Clone(IEnumObjects* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ioperationsprogressdialog
@GUID("0c9fb851-e5c9-43eb-a370-f0677b13874c")
interface IOperationsProgressDialog : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ioperationsprogressdialog-startprogressdialog
    HRESULT StartProgressDialog(HWND hwndOwner, uint flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ioperationsprogressdialog-stopprogressdialog
    HRESULT StopProgressDialog();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ioperationsprogressdialog-setoperation
    HRESULT SetOperation(SPACTION action);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ioperationsprogressdialog-setmode
    HRESULT SetMode(uint mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ioperationsprogressdialog-updateprogress
    HRESULT UpdateProgress(ulong ullPointsCurrent, ulong ullPointsTotal, ulong ullSizeCurrent, ulong ullSizeTotal, 
                           ulong ullItemsCurrent, ulong ullItemsTotal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ioperationsprogressdialog-updatelocations
    HRESULT UpdateLocations(IShellItem psiSource, IShellItem psiTarget, IShellItem psiItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ioperationsprogressdialog-resettimer
    HRESULT ResetTimer();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ioperationsprogressdialog-pausetimer
    HRESULT PauseTimer();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ioperationsprogressdialog-resumetimer
    HRESULT ResumeTimer();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ioperationsprogressdialog-getmilliseconds
    HRESULT GetMilliseconds(ulong* pullElapsed, ulong* pullRemaining);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ioperationsprogressdialog-getoperationstatus
    HRESULT GetOperationStatus(PDOPSTATUS* popstatus);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iiocancelinformation
@GUID("f5b0bf81-8cb5-4b1b-9449-1a159e0c733c")
interface IIOCancelInformation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iiocancelinformation-setcancelinformation
    HRESULT SetCancelInformation(uint dwThreadID, uint uMsgCancel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iiocancelinformation-getcancelinformation
    HRESULT GetCancelInformation(uint* pdwThreadID, uint* puMsgCancel);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ifileoperation
@GUID("947aab5f-0a5c-4c13-b4d6-4bf7836fc9f8")
interface IFileOperation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperation-advise
    HRESULT Advise(IFileOperationProgressSink pfops, uint* pdwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperation-unadvise
    HRESULT Unadvise(uint dwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperation-setoperationflags
    HRESULT SetOperationFlags(FILEOPERATION_FLAGS dwOperationFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperation-setprogressmessage
    HRESULT SetProgressMessage(const(PWSTR) pszMessage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperation-setprogressdialog
    HRESULT SetProgressDialog(IOperationsProgressDialog popd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperation-setproperties
    HRESULT SetProperties(IPropertyChangeArray pproparray);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperation-setownerwindow
    HRESULT SetOwnerWindow(HWND hwndOwner);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperation-applypropertiestoitem
    HRESULT ApplyPropertiesToItem(IShellItem psiItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperation-applypropertiestoitems
    HRESULT ApplyPropertiesToItems(IUnknown punkItems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperation-renameitem
    HRESULT RenameItem(IShellItem psiItem, const(PWSTR) pszNewName, IFileOperationProgressSink pfopsItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperation-renameitems
    HRESULT RenameItems(IUnknown pUnkItems, const(PWSTR) pszNewName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperation-moveitem
    HRESULT MoveItem(IShellItem psiItem, IShellItem psiDestinationFolder, const(PWSTR) pszNewName, 
                     IFileOperationProgressSink pfopsItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperation-moveitems
    HRESULT MoveItems(IUnknown punkItems, IShellItem psiDestinationFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperation-copyitem
    HRESULT CopyItem(IShellItem psiItem, IShellItem psiDestinationFolder, const(PWSTR) pszCopyName, 
                     IFileOperationProgressSink pfopsItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperation-copyitems
    HRESULT CopyItems(IUnknown punkItems, IShellItem psiDestinationFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperation-deleteitem
    HRESULT DeleteItem(IShellItem psiItem, IFileOperationProgressSink pfopsItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperation-deleteitems
    HRESULT DeleteItems(IUnknown punkItems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperation-newitem
    HRESULT NewItem(IShellItem psiDestinationFolder, uint dwFileAttributes, const(PWSTR) pszName, 
                    const(PWSTR) pszTemplateName, IFileOperationProgressSink pfopsItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperation-performoperations
    HRESULT PerformOperations();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileoperation-getanyoperationsaborted
    HRESULT GetAnyOperationsAborted(BOOL* pfAnyOperationsAborted);
}

@GUID("cd8f23c1-8f61-4916-909d-55bdd0918753")
interface IFileOperation2 : IFileOperation
{
    HRESULT SetOperationFlags2(FILE_OPERATION_FLAGS2 operationFlags2);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iobjectprovider
@GUID("a6087428-3be3-4d73-b308-7c04a540bf1a")
interface IObjectProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iobjectprovider-queryobject
    HRESULT QueryObject(const(GUID)* guidObject, const(GUID)* riid, void** ppvOut);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-inamespacewalkcb
@GUID("d92995f8-cf5e-4a76-bf59-ead39ea2b97e")
interface INamespaceWalkCB : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacewalkcb-founditem
    HRESULT FoundItem(IShellFolder psf, ITEMIDLIST* pidl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacewalkcb-enterfolder
    HRESULT EnterFolder(IShellFolder psf, ITEMIDLIST* pidl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacewalkcb-leavefolder
    HRESULT LeaveFolder(IShellFolder psf, ITEMIDLIST* pidl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacewalkcb-initializeprogressdialog
    HRESULT InitializeProgressDialog(PWSTR* ppszTitle, PWSTR* ppszCancel);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-inamespacewalkcb2
@GUID("7ac7492b-c38e-438a-87db-68737844ff70")
interface INamespaceWalkCB2 : INamespaceWalkCB
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacewalkcb2-walkcomplete
    HRESULT WalkComplete(HRESULT hr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-inamespacewalk
@GUID("57ced8a7-3f4a-432c-9350-30f24483f74f")
interface INamespaceWalk : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacewalk-walk
    HRESULT Walk(IUnknown punkToWalk, uint dwFlags, int cDepth, INamespaceWalkCB pnswcb);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacewalk-getidarrayresult
    HRESULT GetIDArrayResult(uint* pcItems, ITEMIDLIST*** prgpidl);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ibandsite
@GUID("4cf504b0-de96-11d0-8b3f-00a0c911e8e5")
interface IBandSite : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ibandsite-addband
    HRESULT AddBand(IUnknown punk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ibandsite-enumbands
    HRESULT EnumBands(uint uBand, uint* pdwBandID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ibandsite-queryband
    HRESULT QueryBand(uint dwBandID, IDeskBand* ppstb, uint* pdwState, PWSTR pszName, int cchName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ibandsite-setbandstate
    HRESULT SetBandState(uint dwBandID, uint dwMask, uint dwState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ibandsite-removeband
    HRESULT RemoveBand(uint dwBandID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ibandsite-getbandobject
    HRESULT GetBandObject(uint dwBandID, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ibandsite-setbandsiteinfo
    HRESULT SetBandSiteInfo(const(BANDSITEINFO)* pbsinfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ibandsite-getbandsiteinfo
    HRESULT GetBandSiteInfo(BANDSITEINFO* pbsinfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-imodalwindow
@GUID("b4db1657-70d7-485e-8e3e-6fcb5a5c1802")
interface IModalWindow : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-imodalwindow-show
    HRESULT Show(HWND hwndOwner);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-icontextmenusite
@GUID("0811aebe-0b87-4c54-9e72-548cf649016b")
interface IContextMenuSite : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icontextmenusite-docontextmenupopup
    HRESULT DoContextMenuPopup(IUnknown punkContextMenu, uint fFlags, POINT pt);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-imenuband
@GUID("568804cd-cbd7-11d0-9816-00c04fd91972")
interface IMenuBand : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-imenuband-ismenumessage
    HRESULT IsMenuMessage(MSG* pmsg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-imenuband-translatemenumessage
    HRESULT TranslateMenuMessage(MSG* pmsg, LRESULT* plRet);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iregtreeitem
@GUID("a9521922-0812-4d44-9ec3-7fd38c726f3d")
interface IRegTreeItem : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iregtreeitem-getcheckstate
    HRESULT GetCheckState(BOOL* pbCheck);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iregtreeitem-setcheckstate
    HRESULT SetCheckState(BOOL bCheck);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ideskbar
@GUID("eb0fe173-1a3a-11d0-89b3-00a0c90a90ac")
interface IDeskBar : IOleWindow
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ideskbar-setclient
    HRESULT SetClient(IUnknown punkClient);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ideskbar-getclient
    HRESULT GetClient(IUnknown* ppunkClient);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ideskbar-onposrectchangedb
    HRESULT OnPosRectChangeDB(RECT* prc);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-imenupopup
@GUID("d1e7afeb-6a2e-11d0-8c78-00c04fd918b4")
interface IMenuPopup : IDeskBar
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-imenupopup-popup
    HRESULT Popup(POINTL* ppt, RECTL* prcExclude, int dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-imenupopup-onselect
    HRESULT OnSelect(uint dwSelectType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-imenupopup-setsubmenu
    HRESULT SetSubMenu(IMenuPopup pmp, BOOL fSet);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ifileisinuse
@GUID("64a1cbf0-3a1a-4461-9158-376969693950")
interface IFileIsInUse : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileisinuse-getappname
    HRESULT GetAppName(PWSTR* ppszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileisinuse-getusage
    HRESULT GetUsage(FILE_USAGE_TYPE* pfut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileisinuse-getcapabilities
    HRESULT GetCapabilities(uint* pdwCapFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileisinuse-getswitchtohwnd
    HRESULT GetSwitchToHWND(HWND* phwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileisinuse-closefile
    HRESULT CloseFile();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ifiledialogevents
@GUID("973510db-7d7f-452b-8975-74a85828d354")
interface IFileDialogEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogevents-onfileok
    HRESULT OnFileOk(IFileDialog pfd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogevents-onfolderchanging
    HRESULT OnFolderChanging(IFileDialog pfd, IShellItem psiFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogevents-onfolderchange
    HRESULT OnFolderChange(IFileDialog pfd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogevents-onselectionchange
    HRESULT OnSelectionChange(IFileDialog pfd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogevents-onshareviolation
    HRESULT OnShareViolation(IFileDialog pfd, IShellItem psi, FDE_SHAREVIOLATION_RESPONSE* pResponse);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogevents-ontypechange
    HRESULT OnTypeChange(IFileDialog pfd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogevents-onoverwrite
    HRESULT OnOverwrite(IFileDialog pfd, IShellItem psi, FDE_OVERWRITE_RESPONSE* pResponse);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ifiledialog
@GUID("42f85136-db7e-439c-85f1-e4075d135fc8")
interface IFileDialog : IModalWindow
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-setfiletypes
    HRESULT SetFileTypes(uint cFileTypes, const(COMDLG_FILTERSPEC)* rgFilterSpec);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-setfiletypeindex
    HRESULT SetFileTypeIndex(uint iFileType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-getfiletypeindex
    HRESULT GetFileTypeIndex(uint* piFileType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-advise
    HRESULT Advise(IFileDialogEvents pfde, uint* pdwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-unadvise
    HRESULT Unadvise(uint dwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-setoptions
    HRESULT SetOptions(FILEOPENDIALOGOPTIONS fos);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-getoptions
    HRESULT GetOptions(FILEOPENDIALOGOPTIONS* pfos);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-setdefaultfolder
    HRESULT SetDefaultFolder(IShellItem psi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-setfolder
    HRESULT SetFolder(IShellItem psi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-getfolder
    HRESULT GetFolder(IShellItem* ppsi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-getcurrentselection
    HRESULT GetCurrentSelection(IShellItem* ppsi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-setfilename
    HRESULT SetFileName(const(PWSTR) pszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-getfilename
    HRESULT GetFileName(PWSTR* pszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-settitle
    HRESULT SetTitle(const(PWSTR) pszTitle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-setokbuttonlabel
    HRESULT SetOkButtonLabel(const(PWSTR) pszText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-setfilenamelabel
    HRESULT SetFileNameLabel(const(PWSTR) pszLabel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-getresult
    HRESULT GetResult(IShellItem* ppsi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-addplace
    HRESULT AddPlace(IShellItem psi, FDAP fdap);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-setdefaultextension
    HRESULT SetDefaultExtension(const(PWSTR) pszDefaultExtension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-close
    HRESULT Close(HRESULT hr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-setclientguid
    HRESULT SetClientGuid(const(GUID)* guid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-clearclientdata
    HRESULT ClearClientData();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialog-setfilter
    HRESULT SetFilter(IShellItemFilter pFilter);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ifilesavedialog
@GUID("84bccd23-5fde-4cdb-aea4-af64b83d78ab")
interface IFileSaveDialog : IFileDialog
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifilesavedialog-setsaveasitem
    HRESULT SetSaveAsItem(IShellItem psi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifilesavedialog-setproperties
    HRESULT SetProperties(IPropertyStore pStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifilesavedialog-setcollectedproperties
    HRESULT SetCollectedProperties(IPropertyDescriptionList pList, BOOL fAppendDefault);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifilesavedialog-getproperties
    HRESULT GetProperties(IPropertyStore* ppStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifilesavedialog-applyproperties
    HRESULT ApplyProperties(IShellItem psi, IPropertyStore pStore, HWND hwnd, IFileOperationProgressSink pSink);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ifileopendialog
@GUID("d57c7288-d4ad-4768-be02-9d969532d960")
interface IFileOpenDialog : IFileDialog
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileopendialog-getresults
    HRESULT GetResults(IShellItemArray* ppenum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifileopendialog-getselecteditems
    HRESULT GetSelectedItems(IShellItemArray* ppsai);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ifiledialogcustomize
@GUID("e6fdd21a-163f-4975-9c8c-a69f1ba37034")
interface IFileDialogCustomize : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-enableopendropdown
    HRESULT EnableOpenDropDown(uint dwIDCtl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-addmenu
    HRESULT AddMenu(uint dwIDCtl, const(PWSTR) pszLabel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-addpushbutton
    HRESULT AddPushButton(uint dwIDCtl, const(PWSTR) pszLabel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-addcombobox
    HRESULT AddComboBox(uint dwIDCtl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-addradiobuttonlist
    HRESULT AddRadioButtonList(uint dwIDCtl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-addcheckbutton
    HRESULT AddCheckButton(uint dwIDCtl, const(PWSTR) pszLabel, BOOL bChecked);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-addeditbox
    HRESULT AddEditBox(uint dwIDCtl, const(PWSTR) pszText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-addseparator
    HRESULT AddSeparator(uint dwIDCtl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-addtext
    HRESULT AddText(uint dwIDCtl, const(PWSTR) pszText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-setcontrollabel
    HRESULT SetControlLabel(uint dwIDCtl, const(PWSTR) pszLabel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-getcontrolstate
    HRESULT GetControlState(uint dwIDCtl, CDCONTROLSTATEF* pdwState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-setcontrolstate
    HRESULT SetControlState(uint dwIDCtl, CDCONTROLSTATEF dwState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-geteditboxtext
    HRESULT GetEditBoxText(uint dwIDCtl, ushort** ppszText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-seteditboxtext
    HRESULT SetEditBoxText(uint dwIDCtl, const(PWSTR) pszText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-getcheckbuttonstate
    HRESULT GetCheckButtonState(uint dwIDCtl, BOOL* pbChecked);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-setcheckbuttonstate
    HRESULT SetCheckButtonState(uint dwIDCtl, BOOL bChecked);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-addcontrolitem
    HRESULT AddControlItem(uint dwIDCtl, uint dwIDItem, const(PWSTR) pszLabel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-removecontrolitem
    HRESULT RemoveControlItem(uint dwIDCtl, uint dwIDItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-removeallcontrolitems
    HRESULT RemoveAllControlItems(uint dwIDCtl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-getcontrolitemstate
    HRESULT GetControlItemState(uint dwIDCtl, uint dwIDItem, CDCONTROLSTATEF* pdwState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-setcontrolitemstate
    HRESULT SetControlItemState(uint dwIDCtl, uint dwIDItem, CDCONTROLSTATEF dwState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-getselectedcontrolitem
    HRESULT GetSelectedControlItem(uint dwIDCtl, uint* pdwIDItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-setselectedcontrolitem
    HRESULT SetSelectedControlItem(uint dwIDCtl, uint dwIDItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-startvisualgroup
    HRESULT StartVisualGroup(uint dwIDCtl, const(PWSTR) pszLabel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-endvisualgroup
    HRESULT EndVisualGroup();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-makeprominent
    HRESULT MakeProminent(uint dwIDCtl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifiledialogcustomize-setcontrolitemtext
    HRESULT SetControlItemText(uint dwIDCtl, uint dwIDItem, const(PWSTR) pszLabel);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iapplicationassociationregistration
@GUID("4e530b0a-e611-4c77-a3ac-9031d022281b")
interface IApplicationAssociationRegistration : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationassociationregistration-querycurrentdefault
    HRESULT QueryCurrentDefault(const(PWSTR) pszQuery, ASSOCIATIONTYPE atQueryType, ASSOCIATIONLEVEL alQueryLevel, 
                                PWSTR* ppszAssociation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationassociationregistration-queryappisdefault
    HRESULT QueryAppIsDefault(const(PWSTR) pszQuery, ASSOCIATIONTYPE atQueryType, ASSOCIATIONLEVEL alQueryLevel, 
                              const(PWSTR) pszAppRegistryName, BOOL* pfDefault);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationassociationregistration-queryappisdefaultall
    HRESULT QueryAppIsDefaultAll(ASSOCIATIONLEVEL alQueryLevel, const(PWSTR) pszAppRegistryName, BOOL* pfDefault);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationassociationregistration-setappasdefault
    HRESULT SetAppAsDefault(const(PWSTR) pszAppRegistryName, const(PWSTR) pszSet, ASSOCIATIONTYPE atSetType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationassociationregistration-setappasdefaultall
    HRESULT SetAppAsDefaultAll(const(PWSTR) pszAppRegistryName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationassociationregistration-clearuserassociations
    HRESULT ClearUserAssociations();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-idelegatefolder
@GUID("add8ba80-002b-11d0-8f0f-00c04fd7d062")
interface IDelegateFolder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idelegatefolder-setitemalloc
    HRESULT SetItemAlloc(IMalloc pmalloc);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ibrowserframeoptions
@GUID("10df43c8-1dbe-11d3-8b34-006097df5bd4")
interface IBrowserFrameOptions : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ibrowserframeoptions-getframeoptions
    HRESULT GetFrameOptions(uint dwMask, uint* pdwOptions);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-inewwindowmanager
@GUID("d2bc4c84-3f72-4a52-a604-7bcbf3982cbb")
interface INewWindowManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inewwindowmanager-evaluatenewwindow
    HRESULT EvaluateNewWindow(const(PWSTR) pszUrl, const(PWSTR) pszName, const(PWSTR) pszUrlContext, 
                              const(PWSTR) pszFeatures, BOOL fReplace, uint dwFlags, uint dwUserActionTime);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iattachmentexecute
@GUID("73db1241-1e85-4581-8e4f-a81e1d0f8c57")
interface IAttachmentExecute : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iattachmentexecute-setclienttitle
    HRESULT SetClientTitle(const(PWSTR) pszTitle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iattachmentexecute-setclientguid
    HRESULT SetClientGuid(const(GUID)* guid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iattachmentexecute-setlocalpath
    HRESULT SetLocalPath(const(PWSTR) pszLocalPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iattachmentexecute-setfilename
    HRESULT SetFileName(const(PWSTR) pszFileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iattachmentexecute-setsource
    HRESULT SetSource(const(PWSTR) pszSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iattachmentexecute-setreferrer
    HRESULT SetReferrer(const(PWSTR) pszReferrer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iattachmentexecute-checkpolicy
    HRESULT CheckPolicy();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iattachmentexecute-prompt
    HRESULT Prompt(HWND hwnd, ATTACHMENT_PROMPT prompt, ATTACHMENT_ACTION* paction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iattachmentexecute-save
    HRESULT Save();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iattachmentexecute-execute
    HRESULT Execute(HWND hwnd, const(PWSTR) pszVerb, HANDLE* phProcess);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iattachmentexecute-savewithui
    HRESULT SaveWithUI(HWND hwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iattachmentexecute-clearclientstate
    HRESULT ClearClientState();
}

@GUID("4f2b781f-a608-4543-abf0-49c246ebbba9")
interface IAttachmentExecute2 : IAttachmentExecute
{
    HRESULT SaveNoVirusCheck();
    HRESULT SaveWithUINoVirusCheck(HWND hwnd);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishellmenucallback
@GUID("4ca300a1-9b8d-11d1-8b22-00c04fd918d0")
interface IShellMenuCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellmenucallback-callbacksm
    HRESULT CallbackSM(SMDATA* psmd, uint uMsg, WPARAM wParam, LPARAM lParam);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishellmenu
@GUID("ee1f7637-e138-11d1-8379-00c04fd918d0")
interface IShellMenu : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellmenu-initialize
    HRESULT Initialize(IShellMenuCallback psmc, uint uId, uint uIdAncestor, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellmenu-getmenuinfo
    HRESULT GetMenuInfo(IShellMenuCallback* ppsmc, uint* puId, uint* puIdAncestor, uint* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellmenu-setshellfolder
    HRESULT SetShellFolder(IShellFolder psf, ITEMIDLIST* pidlFolder, HKEY hKey, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellmenu-getshellfolder
    HRESULT GetShellFolder(uint* pdwFlags, ITEMIDLIST** ppidl, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellmenu-setmenu
    HRESULT SetMenu(HMENU hmenu, HWND hwnd, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellmenu-getmenu
    HRESULT GetMenu(HMENU* phmenu, HWND* phwnd, uint* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellmenu-invalidateitem
    HRESULT InvalidateItem(SMDATA* psmd, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellmenu-getstate
    HRESULT GetState(SMDATA* psmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellmenu-setmenutoolbar
    HRESULT SetMenuToolbar(IUnknown punk, uint dwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iknownfolder
@GUID("3aa7af7e-9b36-420c-a8e3-f77d4674a488")
interface IKnownFolder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iknownfolder-getid
    HRESULT GetId(GUID* pkfid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iknownfolder-getcategory
    HRESULT GetCategory(KF_CATEGORY* pCategory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iknownfolder-getshellitem
    HRESULT GetShellItem(uint dwFlags, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iknownfolder-getpath
    HRESULT GetPath(uint dwFlags, PWSTR* ppszPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iknownfolder-setpath
    HRESULT SetPath(uint dwFlags, const(PWSTR) pszPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iknownfolder-getidlist
    HRESULT GetIDList(uint dwFlags, ITEMIDLIST** ppidl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iknownfolder-getfoldertype
    HRESULT GetFolderType(GUID* pftid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iknownfolder-getredirectioncapabilities
    HRESULT GetRedirectionCapabilities(uint* pCapabilities);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iknownfolder-getfolderdefinition
    HRESULT GetFolderDefinition(KNOWNFOLDER_DEFINITION* pKFD);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iknownfoldermanager
@GUID("8be2d872-86aa-4d47-b776-32cca40c7018")
interface IKnownFolderManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iknownfoldermanager-folderidfromcsidl
    HRESULT FolderIdFromCsidl(int nCsidl, GUID* pfid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iknownfoldermanager-folderidtocsidl
    HRESULT FolderIdToCsidl(const(GUID)* rfid, int* pnCsidl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iknownfoldermanager-getfolderids
    HRESULT GetFolderIds(GUID** ppKFId, uint* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iknownfoldermanager-getfolder
    HRESULT GetFolder(const(GUID)* rfid, IKnownFolder* ppkf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iknownfoldermanager-getfolderbyname
    HRESULT GetFolderByName(const(PWSTR) pszCanonicalName, IKnownFolder* ppkf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iknownfoldermanager-registerfolder
    HRESULT RegisterFolder(const(GUID)* rfid, const(KNOWNFOLDER_DEFINITION)* pKFD);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iknownfoldermanager-unregisterfolder
    HRESULT UnregisterFolder(const(GUID)* rfid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iknownfoldermanager-findfolderfrompath
    HRESULT FindFolderFromPath(const(PWSTR) pszPath, FFFP_MODE mode, IKnownFolder* ppkf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iknownfoldermanager-findfolderfromidlist
    HRESULT FindFolderFromIDList(ITEMIDLIST* pidl, IKnownFolder* ppkf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iknownfoldermanager-redirect
    HRESULT Redirect(const(GUID)* rfid, HWND hwnd, uint flags, const(PWSTR) pszTargetPath, uint cFolders, 
                     const(GUID)* pExclusion, PWSTR* ppszError);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-isharingconfigurationmanager
@GUID("b4cd448a-9c86-4466-9201-2e62105b87ae")
interface ISharingConfigurationManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isharingconfigurationmanager-createshare
    HRESULT CreateShare(DEF_SHARE_ID dsid, SHARE_ROLE role);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isharingconfigurationmanager-deleteshare
    HRESULT DeleteShare(DEF_SHARE_ID dsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isharingconfigurationmanager-shareexists
    HRESULT ShareExists(DEF_SHARE_ID dsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isharingconfigurationmanager-getsharepermissions
    HRESULT GetSharePermissions(DEF_SHARE_ID dsid, SHARE_ROLE* pRole);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isharingconfigurationmanager-shareprinters
    HRESULT SharePrinters();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isharingconfigurationmanager-stopsharingprinters
    HRESULT StopSharingPrinters();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isharingconfigurationmanager-areprintersshared
    HRESULT ArePrintersShared();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-irelateditem
@GUID("a73ce67a-8ab1-44f1-8d43-d2fcbf6b1cd0")
interface IRelatedItem : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-irelateditem-getitemidlist
    HRESULT GetItemIDList(ITEMIDLIST** ppidl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-irelateditem-getitem
    HRESULT GetItem(IShellItem* ppsi);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iidentityname
@GUID("7d903fca-d6f9-4810-8332-946c0177e247")
interface IIdentityName : IRelatedItem
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-idelegateitem
@GUID("3c5a1c94-c951-4cb7-bb6d-3b93f30cce93")
interface IDelegateItem : IRelatedItem
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-icurrentitem
@GUID("240a7174-d653-4a1d-a6d3-d4943cfbfe3d")
interface ICurrentItem : IRelatedItem
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-itransfermediumitem
@GUID("77f295d5-2d6f-4e19-b8ae-322f3e721ab5")
interface ITransferMediumItem : IRelatedItem
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-idisplayitem
@GUID("c6fd5997-9f6b-4888-8703-94e80e8cde3f")
interface IDisplayItem : IRelatedItem
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iviewstateidentityitem
@GUID("9d264146-a94f-4195-9f9f-3bb12ce0c955")
interface IViewStateIdentityItem : IRelatedItem
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ipreviewitem
@GUID("36149969-0a8f-49c8-8b00-4aecb20222fb")
interface IPreviewItem : IRelatedItem
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-idestinationstreamfactory
@GUID("8a87781b-39a7-4a1f-aab3-a39b9c34a7d9")
interface IDestinationStreamFactory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idestinationstreamfactory-getdestinationstream
    HRESULT GetDestinationStream(IStream* ppstm);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-icreateprocessinputs
@GUID("f6ef6140-e26f-4d82-bac4-e9ba5fd239a8")
interface ICreateProcessInputs : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icreateprocessinputs-getcreateflags
    HRESULT GetCreateFlags(uint* pdwCreationFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icreateprocessinputs-setcreateflags
    HRESULT SetCreateFlags(uint dwCreationFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icreateprocessinputs-addcreateflags
    HRESULT AddCreateFlags(uint dwCreationFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icreateprocessinputs-sethotkey
    HRESULT SetHotKey(ushort wHotKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icreateprocessinputs-addstartupflags
    HRESULT AddStartupFlags(uint dwStartupInfoFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icreateprocessinputs-settitle
    HRESULT SetTitle(const(PWSTR) pszTitle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icreateprocessinputs-setenvironmentvariable
    HRESULT SetEnvironmentVariable(const(PWSTR) pszName, const(PWSTR) pszValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-icreatingprocess
@GUID("c2b937a9-3110-4398-8a56-f34c6342d244")
interface ICreatingProcess : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icreatingprocess-oncreating
    HRESULT OnCreating(ICreateProcessInputs pcpi);
}

@GUID("1791e8f6-21c7-4340-882a-a6a93e3fd73b")
interface ILaunchUIContext : IUnknown
{
    HRESULT SetAssociatedWindow(HWND value);
    HRESULT SetTabGroupingPreference(uint value);
}

@GUID("0d12c4c8-a3d9-4e24-94c1-0e20c5a956c4")
interface ILaunchUIContextProvider : IUnknown
{
    HRESULT UpdateContext(ILaunchUIContext context);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-inewmenuclient
@GUID("dcb07fdc-3bb5-451c-90be-966644fed7b0")
interface INewMenuClient : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inewmenuclient-includeitems
    HRESULT IncludeItems(int* pflags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inewmenuclient-selectandedititem
    HRESULT SelectAndEditItem(ITEMIDLIST* pidlItem, int flags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iinitializewithbindctx
@GUID("71c0d2bc-726d-45cc-a6c0-2e31c1db2159")
interface IInitializeWithBindCtx : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iinitializewithbindctx-initialize
    HRESULT Initialize(IBindCtx pbc);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishellitemfilter
@GUID("2659b475-eeb8-48b7-8f07-b378810f48cf")
interface IShellItemFilter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitemfilter-includeitem
    HRESULT IncludeItem(IShellItem psi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishellitemfilter-getenumflagsforitem
    HRESULT GetEnumFlagsForItem(IShellItem psi, uint* pgrfFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-inamespacetreecontrol
@GUID("028212a3-b627-47e9-8856-c14265554e4f")
interface INameSpaceTreeControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacetreecontrol-initialize
    HRESULT Initialize(HWND hwndParent, RECT* prc, uint nsctsFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacetreecontrol-treeadvise
    HRESULT TreeAdvise(IUnknown punk, uint* pdwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacetreecontrol-treeunadvise
    HRESULT TreeUnadvise(uint dwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacetreecontrol-appendroot
    HRESULT AppendRoot(IShellItem psiRoot, uint grfEnumFlags, uint grfRootStyle, IShellItemFilter pif);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacetreecontrol-insertroot
    HRESULT InsertRoot(int iIndex, IShellItem psiRoot, uint grfEnumFlags, uint grfRootStyle, IShellItemFilter pif);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacetreecontrol-removeroot
    HRESULT RemoveRoot(IShellItem psiRoot);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacetreecontrol-removeallroots
    HRESULT RemoveAllRoots();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacetreecontrol-getrootitems
    HRESULT GetRootItems(IShellItemArray* ppsiaRootItems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacetreecontrol-setitemstate
    HRESULT SetItemState(IShellItem psi, uint nstcisMask, uint nstcisFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacetreecontrol-getitemstate
    HRESULT GetItemState(IShellItem psi, uint nstcisMask, uint* pnstcisFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacetreecontrol-getselecteditems
    HRESULT GetSelectedItems(IShellItemArray* psiaItems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacetreecontrol-getitemcustomstate
    HRESULT GetItemCustomState(IShellItem psi, int* piStateNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacetreecontrol-setitemcustomstate
    HRESULT SetItemCustomState(IShellItem psi, int iStateNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacetreecontrol-ensureitemvisible
    HRESULT EnsureItemVisible(IShellItem psi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacetreecontrol-settheme
    HRESULT SetTheme(const(PWSTR) pszTheme);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacetreecontrol-getnextitem
    HRESULT GetNextItem(IShellItem psi, NSTCGNI nstcgi, IShellItem* ppsiNext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacetreecontrol-hittest
    HRESULT HitTest(POINT* ppt, IShellItem* ppsiOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacetreecontrol-getitemrect
    HRESULT GetItemRect(IShellItem psi, RECT* prect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacetreecontrol-collapseall
    HRESULT CollapseAll();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-inamespacetreecontrolfoldercapabilities
@GUID("e9701183-e6b3-4ff2-8568-813615fec7be")
interface INameSpaceTreeControlFolderCapabilities : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-inamespacetreecontrolfoldercapabilities-getfoldercapabilities
    HRESULT GetFolderCapabilities(NSTCFOLDERCAPABILITIES nfcMask, NSTCFOLDERCAPABILITIES* pnfcValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ipreviewhandler
@GUID("8895b1c6-b41f-4c1c-a562-0d564250836f")
interface IPreviewHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipreviewhandler-setwindow
    HRESULT SetWindow(HWND hwnd, const(RECT)* prc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipreviewhandler-setrect
    HRESULT SetRect(const(RECT)* prc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipreviewhandler-dopreview
    HRESULT DoPreview();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipreviewhandler-unload
    HRESULT Unload();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipreviewhandler-setfocus
    HRESULT SetFocus();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipreviewhandler-queryfocus
    HRESULT QueryFocus(HWND* phwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipreviewhandler-translateaccelerator
    HRESULT TranslateAccelerator(MSG* pmsg);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ipreviewhandlerframe
@GUID("fec87aaf-35f9-447a-adb7-20234491401a")
interface IPreviewHandlerFrame : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipreviewhandlerframe-getwindowcontext
    HRESULT GetWindowContext(PREVIEWHANDLERFRAMEINFO* pinfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipreviewhandlerframe-translateaccelerator
    HRESULT TranslateAccelerator(MSG* pmsg);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iexplorerpanevisibility
@GUID("e07010ec-bc17-44c0-97b0-46c7c95b9edc")
interface IExplorerPaneVisibility : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerpanevisibility-getpanestate
    HRESULT GetPaneState(const(GUID)* ep, uint* peps);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-icontextmenucb
@GUID("3409e930-5a39-11d1-83fa-00a0c90dc849")
interface IContextMenuCB : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icontextmenucb-callback
    HRESULT CallBack(IShellFolder psf, HWND hwndOwner, IDataObject pdtobj, uint uMsg, WPARAM wParam, LPARAM lParam);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-idefaultextracticoninit
@GUID("41ded17d-d6b3-4261-997d-88c60e4b1d58")
interface IDefaultExtractIconInit : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idefaultextracticoninit-setflags
    HRESULT SetFlags(uint uFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idefaultextracticoninit-setkey
    HRESULT SetKey(HKEY hkey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idefaultextracticoninit-setnormalicon
    HRESULT SetNormalIcon(const(PWSTR) pszFile, int iIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idefaultextracticoninit-setopenicon
    HRESULT SetOpenIcon(const(PWSTR) pszFile, int iIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idefaultextracticoninit-setshortcuticon
    HRESULT SetShortcutIcon(const(PWSTR) pszFile, int iIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idefaultextracticoninit-setdefaulticon
    HRESULT SetDefaultIcon(const(PWSTR) pszFile, int iIcon);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iexplorercommand
@GUID("a08ce4d0-fa25-44ab-b57c-c7b1c323e0b9")
interface IExplorerCommand : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorercommand-gettitle
    HRESULT GetTitle(IShellItemArray psiItemArray, PWSTR* ppszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorercommand-geticon
    HRESULT GetIcon(IShellItemArray psiItemArray, PWSTR* ppszIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorercommand-gettooltip
    HRESULT GetToolTip(IShellItemArray psiItemArray, PWSTR* ppszInfotip);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorercommand-getcanonicalname
    HRESULT GetCanonicalName(GUID* pguidCommandName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorercommand-getstate
    HRESULT GetState(IShellItemArray psiItemArray, BOOL fOkToBeSlow, 
                     /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(_EXPCMDSTATE))], [])*/uint* pCmdState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorercommand-invoke
    HRESULT Invoke(IShellItemArray psiItemArray, IBindCtx pbc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorercommand-getflags
    HRESULT GetFlags(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(_EXPCMDFLAGS))], [])*/uint* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorercommand-enumsubcommands
    HRESULT EnumSubCommands(IEnumExplorerCommand* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iexplorercommandstate
@GUID("bddacb60-7657-47ae-8445-d23e1acf82ae")
interface IExplorerCommandState : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorercommandstate-getstate
    HRESULT GetState(IShellItemArray psiItemArray, BOOL fOkToBeSlow, uint* pCmdState);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iinitializecommand
@GUID("85075acf-231f-40ea-9610-d26b7b58f638")
interface IInitializeCommand : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iinitializecommand-initialize
    HRESULT Initialize(const(PWSTR) pszCommandName, IPropertyBag ppb);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ienumexplorercommand
@GUID("a88826f8-186f-4987-aade-ea0cef8fbfe8")
interface IEnumExplorerCommand : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Next(uint celt, IExplorerCommand* pUICommand, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumexplorercommand-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumexplorercommand-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumexplorercommand-clone
    HRESULT Clone(IEnumExplorerCommand* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iexplorercommandprovider
@GUID("64961751-0835-43c0-8ffe-d57686530e64")
interface IExplorerCommandProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorercommandprovider-getcommands
    HRESULT GetCommands(IUnknown punkSite, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorercommandprovider-getcommand
    HRESULT GetCommand(const(GUID)* rguidCommandId, const(GUID)* riid, void** ppv);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iopencontrolpanel
@GUID("d11ad862-66de-4df4-bf6c-1f5621996af1")
interface IOpenControlPanel : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iopencontrolpanel-open
    HRESULT Open(const(PWSTR) pszName, const(PWSTR) pszPage, IUnknown punkSite);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iopencontrolpanel-getpath
    HRESULT GetPath(const(PWSTR) pszName, PWSTR pszPath, uint cchPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iopencontrolpanel-getcurrentview
    HRESULT GetCurrentView(CPVIEW* pView);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ifilesystembinddata
@GUID("01e18d10-4d8b-11d2-855d-006008059367")
interface IFileSystemBindData : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifilesystembinddata-setfinddata
    HRESULT SetFindData(const(WIN32_FIND_DATAW)* pfd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifilesystembinddata-getfinddata
    HRESULT GetFindData(WIN32_FIND_DATAW* pfd);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ifilesystembinddata2
@GUID("3acf075f-71db-4afa-81f0-3fc4fdf2a5b8")
interface IFileSystemBindData2 : IFileSystemBindData
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifilesystembinddata2-setfileid
    HRESULT SetFileID(long liFileID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifilesystembinddata2-getfileid
    HRESULT GetFileID(long* pliFileID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifilesystembinddata2-setjunctionclsid
    HRESULT SetJunctionCLSID(const(GUID)* clsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifilesystembinddata2-getjunctionclsid
    HRESULT GetJunctionCLSID(GUID* pclsid);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-icustomdestinationlist
@GUID("6332debf-87b5-4670-90c0-5e57b408a49e")
interface ICustomDestinationList : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icustomdestinationlist-setappid
    HRESULT SetAppID(const(PWSTR) pszAppID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icustomdestinationlist-beginlist
    HRESULT BeginList(uint* pcMinSlots, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icustomdestinationlist-appendcategory
    HRESULT AppendCategory(const(PWSTR) pszCategory, IObjectArray poa);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icustomdestinationlist-appendknowncategory
    HRESULT AppendKnownCategory(KNOWNDESTCATEGORY category);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icustomdestinationlist-addusertasks
    HRESULT AddUserTasks(IObjectArray poa);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icustomdestinationlist-commitlist
    HRESULT CommitList();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icustomdestinationlist-getremoveddestinations
    HRESULT GetRemovedDestinations(const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icustomdestinationlist-deletelist
    HRESULT DeleteList(const(PWSTR) pszAppID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icustomdestinationlist-abortlist
    HRESULT AbortList();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iapplicationdestinations
@GUID("12337d35-94c6-48a0-bce7-6a9c69d4d600")
interface IApplicationDestinations : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationdestinations-setappid
    HRESULT SetAppID(const(PWSTR) pszAppID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationdestinations-removedestination
    HRESULT RemoveDestination(IUnknown punk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationdestinations-removealldestinations
    HRESULT RemoveAllDestinations();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iapplicationdocumentlists
@GUID("3c594f9f-9f30-47a1-979a-c9e83d3d0a06")
interface IApplicationDocumentLists : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationdocumentlists-setappid
    HRESULT SetAppID(const(PWSTR) pszAppID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationdocumentlists-getlist
    HRESULT GetList(APPDOCLISTTYPE listtype, uint cItemsDesired, const(GUID)* riid, void** ppv);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iobjectwithappusermodelid
@GUID("36db0196-9665-46d1-9ba7-d3709eecf9ed")
interface IObjectWithAppUserModelID : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iobjectwithappusermodelid-setappid
    HRESULT SetAppID(const(PWSTR) pszAppID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iobjectwithappusermodelid-getappid
    HRESULT GetAppID(PWSTR* ppszAppID);
}

@GUID("ed2aa515-602f-469c-a130-ce69fd0fa878")
interface IObjectWithPackageFullName : IUnknown
{
    HRESULT GetPackageFullName(PWSTR* packageFullName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iobjectwithprogid
@GUID("71e806fb-8dee-46fc-bf8c-7748a8a1ae13")
interface IObjectWithProgID : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iobjectwithprogid-setprogid
    HRESULT SetProgID(const(PWSTR) pszProgID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iobjectwithprogid-getprogid
    HRESULT GetProgID(PWSTR* ppszProgID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iupdateidlist
@GUID("6589b6d2-5f8d-4b9e-b7e0-23cdd9717d8c")
interface IUpdateIDList : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iupdateidlist-update
    HRESULT Update(IBindCtx pbc, ITEMIDLIST* pidlIn, ITEMIDLIST** ppidlOut);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-idesktopwallpaper
@GUID("b92b56a9-8b55-4e14-9a89-0199bbb6f93b")
interface IDesktopWallpaper : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idesktopwallpaper-setwallpaper
    HRESULT SetWallpaper(const(PWSTR) monitorID, const(PWSTR) wallpaper);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idesktopwallpaper-getwallpaper
    HRESULT GetWallpaper(const(PWSTR) monitorID, PWSTR* wallpaper);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idesktopwallpaper-getmonitordevicepathat
    HRESULT GetMonitorDevicePathAt(uint monitorIndex, PWSTR* monitorID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idesktopwallpaper-getmonitordevicepathcount
    HRESULT GetMonitorDevicePathCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idesktopwallpaper-getmonitorrect
    HRESULT GetMonitorRECT(const(PWSTR) monitorID, RECT* displayRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idesktopwallpaper-setbackgroundcolor
    HRESULT SetBackgroundColor(COLORREF color);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idesktopwallpaper-getbackgroundcolor
    HRESULT GetBackgroundColor(COLORREF* color);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idesktopwallpaper-setposition
    HRESULT SetPosition(DESKTOP_WALLPAPER_POSITION position);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idesktopwallpaper-getposition
    HRESULT GetPosition(DESKTOP_WALLPAPER_POSITION* position);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idesktopwallpaper-setslideshow
    HRESULT SetSlideshow(IShellItemArray items);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idesktopwallpaper-getslideshow
    HRESULT GetSlideshow(IShellItemArray* items);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idesktopwallpaper-setslideshowoptions
    HRESULT SetSlideshowOptions(DESKTOP_SLIDESHOW_OPTIONS options, uint slideshowTick);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idesktopwallpaper-getslideshowoptions
    HRESULT GetSlideshowOptions(DESKTOP_SLIDESHOW_OPTIONS* options, uint* slideshowTick);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idesktopwallpaper-advanceslideshow
    HRESULT AdvanceSlideshow(const(PWSTR) monitorID, DESKTOP_SLIDESHOW_DIRECTION direction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idesktopwallpaper-getstatus
    HRESULT GetStatus(DESKTOP_SLIDESHOW_STATE* state);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idesktopwallpaper-enable
    HRESULT Enable(BOOL enable);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ihomegroup
@GUID("7a3bd1d9-35a9-4fb3-a467-f48cac35e2d0")
interface IHomeGroup : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ihomegroup-ismember
    HRESULT IsMember(BOOL* member);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ihomegroup-showsharingwizard
    HRESULT ShowSharingWizard(HWND owner, HOMEGROUPSHARINGCHOICES* sharingchoices);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iinitializewithpropertystore
@GUID("c3e12eb5-7d8d-44f8-b6dd-0e77b34d6de4")
interface IInitializeWithPropertyStore : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iinitializewithpropertystore-initialize
    HRESULT Initialize(IPropertyStore pps);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iopensearchsource
@GUID("f0ee7333-e6fc-479b-9f25-a860c234a38e")
interface IOpenSearchSource : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iopensearchsource-getresults
    HRESULT GetResults(HWND hwnd, const(PWSTR) pszQuery, uint dwStartIndex, uint dwCount, const(GUID)* riid, 
                       void** ppv);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishelllibrary
@GUID("11a66efa-382e-451a-9234-1e0e12ef3085")
interface IShellLibrary : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllibrary-loadlibraryfromitem
    HRESULT LoadLibraryFromItem(IShellItem psiLibrary, uint grfMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllibrary-loadlibraryfromknownfolder
    HRESULT LoadLibraryFromKnownFolder(const(GUID)* kfidLibrary, uint grfMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllibrary-addfolder
    HRESULT AddFolder(IShellItem psiLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllibrary-removefolder
    HRESULT RemoveFolder(IShellItem psiLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllibrary-getfolders
    HRESULT GetFolders(LIBRARYFOLDERFILTER lff, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllibrary-resolvefolder
    HRESULT ResolveFolder(IShellItem psiFolderToResolve, uint dwTimeout, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllibrary-getdefaultsavefolder
    HRESULT GetDefaultSaveFolder(DEFAULTSAVEFOLDERTYPE dsft, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllibrary-setdefaultsavefolder
    HRESULT SetDefaultSaveFolder(DEFAULTSAVEFOLDERTYPE dsft, IShellItem psi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllibrary-getoptions
    HRESULT GetOptions(LIBRARYOPTIONFLAGS* plofOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllibrary-setoptions
    HRESULT SetOptions(LIBRARYOPTIONFLAGS lofMask, LIBRARYOPTIONFLAGS lofOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllibrary-getfoldertype
    HRESULT GetFolderType(GUID* pftid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllibrary-setfoldertype
    HRESULT SetFolderType(const(GUID)* ftid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllibrary-geticon
    HRESULT GetIcon(PWSTR* ppszIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllibrary-seticon
    HRESULT SetIcon(const(PWSTR) pszIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllibrary-commit
    HRESULT Commit();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllibrary-save
    HRESULT Save(IShellItem psiFolderToSaveIn, const(PWSTR) pszLibraryName, LIBRARYSAVEFLAGS lsf, 
                 IShellItem* ppsiSavedTo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelllibrary-saveinknownfolder
    HRESULT SaveInKnownFolder(const(GUID)* kfidToSaveIn, const(PWSTR) pszLibraryName, LIBRARYSAVEFLAGS lsf, 
                              IShellItem* ppsiSavedTo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-idefaultfoldermenuinitialize
@GUID("7690aa79-f8fc-4615-a327-36f7d18f5d91")
interface IDefaultFolderMenuInitialize : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idefaultfoldermenuinitialize-initialize
    HRESULT Initialize(HWND hwnd, IContextMenuCB pcmcb, ITEMIDLIST* pidlFolder, IShellFolder psf, uint cidl, 
                       ITEMIDLIST** apidl, IUnknown punkAssociation, uint cKeys, const(HKEY)* aKeys);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idefaultfoldermenuinitialize-setmenurestrictions
    HRESULT SetMenuRestrictions(DEFAULT_FOLDER_MENU_RESTRICTIONS dfmrValues);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idefaultfoldermenuinitialize-getmenurestrictions
    HRESULT GetMenuRestrictions(DEFAULT_FOLDER_MENU_RESTRICTIONS dfmrMask, 
                                DEFAULT_FOLDER_MENU_RESTRICTIONS* pdfmrValues);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idefaultfoldermenuinitialize-sethandlerclsid
    HRESULT SetHandlerClsid(const(GUID)* rclsid);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iapplicationactivationmanager
@GUID("2e941141-7f97-4756-ba1d-9decde894a3d")
interface IApplicationActivationManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationactivationmanager-activateapplication
    HRESULT ActivateApplication(const(PWSTR) appUserModelId, const(PWSTR) arguments, ACTIVATEOPTIONS options, 
                                uint* processId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationactivationmanager-activateforfile
    HRESULT ActivateForFile(const(PWSTR) appUserModelId, IShellItemArray itemArray, const(PWSTR) verb, 
                            uint* processId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationactivationmanager-activateforprotocol
    HRESULT ActivateForProtocol(const(PWSTR) appUserModelId, IShellItemArray itemArray, uint* processId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ivirtualdesktopmanager
@GUID("a5cd92ff-29be-454c-8d04-d82879fb3f1b")
interface IVirtualDesktopManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ivirtualdesktopmanager-iswindowoncurrentvirtualdesktop
    HRESULT IsWindowOnCurrentVirtualDesktop(HWND topLevelWindow, BOOL* onCurrentDesktop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ivirtualdesktopmanager-getwindowdesktopid
    HRESULT GetWindowDesktopId(HWND topLevelWindow, GUID* desktopId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ivirtualdesktopmanager-movewindowtodesktop
    HRESULT MoveWindowToDesktop(HWND topLevelWindow, const(GUID)* desktopId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iassochandlerinvoker
@GUID("92218cab-ecaa-4335-8133-807fd234c2ee")
interface IAssocHandlerInvoker : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iassochandlerinvoker-supportsselection
    HRESULT SupportsSelection();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iassochandlerinvoker-invoke
    HRESULT Invoke();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iassochandler
@GUID("f04061ac-1659-4a3f-a954-775aa57fc083")
interface IAssocHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iassochandler-getname
    HRESULT GetName(PWSTR* ppsz);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iassochandler-getuiname
    HRESULT GetUIName(PWSTR* ppsz);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iassochandler-geticonlocation
    HRESULT GetIconLocation(PWSTR* ppszPath, int* pIndex);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT IsRecommended();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iassochandler-makedefault
    HRESULT MakeDefault(const(PWSTR) pszDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iassochandler-invoke
    HRESULT Invoke(IDataObject pdo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iassochandler-createinvoker
    HRESULT CreateInvoker(IDataObject pdo, IAssocHandlerInvoker* ppInvoker);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ienumassochandlers
@GUID("973810ae-9599-4b88-9e4d-6ee98c9552da")
interface IEnumAssocHandlers : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ienumassochandlers-next
    HRESULT Next(uint celt, IAssocHandler* rgelt, uint* pceltFetched);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-idataobjectprovider
@GUID("3d25f6d6-4b2a-433c-9184-7c33ad35d001")
interface IDataObjectProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idataobjectprovider-getdataobject
    HRESULT GetDataObject(IDataObject* dataObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idataobjectprovider-setdataobject
    HRESULT SetDataObject(IDataObject dataObject);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-idatatransfermanagerinterop
@GUID("3a3dcd6c-3eab-43dc-bcde-45671ce800c8")
interface IDataTransferManagerInterop : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idatatransfermanagerinterop-getforwindow
    HRESULT GetForWindow(HWND appWindow, const(GUID)* riid, void** dataTransferManager);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-idatatransfermanagerinterop-showshareuiforwindow
    HRESULT ShowShareUIForWindow(HWND appWindow);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iframeworkinputpanehandler
@GUID("226c537b-1e76-4d9e-a760-33db29922f18")
interface IFrameworkInputPaneHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iframeworkinputpanehandler-showing
    HRESULT Showing(RECT* prcInputPaneScreenLocation, BOOL fEnsureFocusedElementInView);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iframeworkinputpanehandler-hiding
    HRESULT Hiding(BOOL fEnsureFocusedElementInView);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iframeworkinputpane
@GUID("5752238b-24f0-495a-82f1-2fd593056796")
interface IFrameworkInputPane : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iframeworkinputpane-advise
    HRESULT Advise(IUnknown pWindow, IFrameworkInputPaneHandler pHandler, uint* pdwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iframeworkinputpane-advisewithhwnd
    HRESULT AdviseWithHWND(HWND hwnd, IFrameworkInputPaneHandler pHandler, uint* pdwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iframeworkinputpane-unadvise
    HRESULT Unadvise(uint dwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iframeworkinputpane-location
    HRESULT Location(RECT* prcInputPaneScreenLocation);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iappvisibilityevents
@GUID("6584ce6b-7d82-49c2-89c9-c6bc02ba8c38")
interface IAppVisibilityEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iappvisibilityevents-appvisibilityonmonitorchanged
    HRESULT AppVisibilityOnMonitorChanged(HMONITOR hMonitor, MONITOR_APP_VISIBILITY previousMode, 
                                          MONITOR_APP_VISIBILITY currentMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iappvisibilityevents-launchervisibilitychange
    HRESULT LauncherVisibilityChange(BOOL currentVisibleState);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iappvisibility
@GUID("2246ea2d-caea-4444-a3c4-6de827e44313")
interface IAppVisibility : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iappvisibility-getappvisibilityonmonitor
    HRESULT GetAppVisibilityOnMonitor(HMONITOR hMonitor, MONITOR_APP_VISIBILITY* pMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iappvisibility-islaunchervisible
    HRESULT IsLauncherVisible(BOOL* pfVisible);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iappvisibility-advise
    HRESULT Advise(IAppVisibilityEvents pCallback, uint* pdwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iappvisibility-unadvise
    HRESULT Unadvise(uint dwCookie);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ipackageexecutionstatechangenotification
@GUID("1bb12a62-2ad8-432b-8ccf-0c2c52afcd5b")
interface IPackageExecutionStateChangeNotification : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipackageexecutionstatechangenotification-onstatechanged
    HRESULT OnStateChanged(const(PWSTR) pszPackageFullName, PACKAGE_EXECUTION_STATE pesNewState);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ipackagedebugsettings
@GUID("f27c3930-8029-4ad1-94e3-3dba417810c1")
interface IPackageDebugSettings : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipackagedebugsettings-enabledebugging
    HRESULT EnableDebugging(const(PWSTR) packageFullName, const(PWSTR) debuggerCommandLine, 
                            /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR environment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipackagedebugsettings-disabledebugging
    HRESULT DisableDebugging(const(PWSTR) packageFullName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/WinRT/ipackagedebugsettings-suspend
    HRESULT Suspend(const(PWSTR) packageFullName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/WinRT/ipackagedebugsettings-resume
    HRESULT Resume(const(PWSTR) packageFullName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipackagedebugsettings-terminateallprocesses
    HRESULT TerminateAllProcesses(const(PWSTR) packageFullName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipackagedebugsettings-settargetsessionid
    HRESULT SetTargetSessionId(uint sessionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipackagedebugsettings-enumeratebackgroundtasks
    HRESULT EnumerateBackgroundTasks(const(PWSTR) packageFullName, uint* taskCount, GUID** taskIds, 
                                     const(PWSTR)** taskNames);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipackagedebugsettings-activatebackgroundtask
    HRESULT ActivateBackgroundTask(const(GUID)* taskId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipackagedebugsettings-startservicing
    HRESULT StartServicing(const(PWSTR) packageFullName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipackagedebugsettings-stopservicing
    HRESULT StopServicing(const(PWSTR) packageFullName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipackagedebugsettings-startsessionredirection
    HRESULT StartSessionRedirection(const(PWSTR) packageFullName, uint sessionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipackagedebugsettings-stopsessionredirection
    HRESULT StopSessionRedirection(const(PWSTR) packageFullName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipackagedebugsettings-getpackageexecutionstate
    HRESULT GetPackageExecutionState(const(PWSTR) packageFullName, PACKAGE_EXECUTION_STATE* packageExecutionState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipackagedebugsettings-registerforpackagestatechanges
    HRESULT RegisterForPackageStateChanges(const(PWSTR) packageFullName, 
                                           IPackageExecutionStateChangeNotification pPackageExecutionStateChangeNotification, 
                                           uint* pdwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipackagedebugsettings-unregisterforpackagestatechanges
    HRESULT UnregisterForPackageStateChanges(uint dwCookie);
}

@GUID("6e3194bb-ab82-4d22-93f5-fabda40e7b16")
interface IPackageDebugSettings2 : IPackageDebugSettings
{
    HRESULT EnumerateApps(const(PWSTR) packageFullName, uint* appCount, PWSTR** appUserModelIds, 
                          PWSTR** appDisplayNames);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-isuspensiondependencymanager
@GUID("52b83a42-2543-416a-81d9-c0de7969c8b3")
interface ISuspensionDependencyManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isuspensiondependencymanager-registeraschild
    HRESULT RegisterAsChild(HANDLE processHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isuspensiondependencymanager-groupchildwithparent
    HRESULT GroupChildWithParent(HANDLE childProcessHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-isuspensiondependencymanager-ungroupchildfromparent
    HRESULT UngroupChildFromParent(HANDLE childProcessHandle);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iexecutecommandapplicationhostenvironment
@GUID("18b21aa9-e184-4ff0-9f5e-f882d03771b3")
interface IExecuteCommandApplicationHostEnvironment : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexecutecommandapplicationhostenvironment-getvalue
    HRESULT GetValue(AHE_TYPE* pahe);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iexecutecommandhost
@GUID("4b6832a2-5f04-4c9d-b89d-727a15d103e7")
interface IExecuteCommandHost : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexecutecommandhost-getuimode
    HRESULT GetUIMode(EC_HOST_UI_MODE* pUIMode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iapplicationdesignmodesettings
@GUID("2a3dee9a-e31d-46d6-8508-bcc597db3557")
interface IApplicationDesignModeSettings : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationdesignmodesettings-setnativedisplaysize
    HRESULT SetNativeDisplaySize(SIZE nativeDisplaySizePixels);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationdesignmodesettings-setscalefactor
    HRESULT SetScaleFactor(DEVICE_SCALE_FACTOR scaleFactor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationdesignmodesettings-setapplicationviewstate
    HRESULT SetApplicationViewState(APPLICATION_VIEW_STATE viewState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationdesignmodesettings-computeapplicationsize
    HRESULT ComputeApplicationSize(SIZE* applicationSizePixels);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationdesignmodesettings-isapplicationviewstatesupported
    HRESULT IsApplicationViewStateSupported(APPLICATION_VIEW_STATE viewState, SIZE nativeDisplaySizePixels, 
                                            DEVICE_SCALE_FACTOR scaleFactor, BOOL* supported);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationdesignmodesettings-triggeredgegesture
    HRESULT TriggerEdgeGesture(EDGE_GESTURE_KIND edgeGestureKind);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iapplicationdesignmodesettings2
@GUID("490514e1-675a-4d6e-a58d-e54901b4ca2f")
interface IApplicationDesignModeSettings2 : IApplicationDesignModeSettings
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationdesignmodesettings2-setnativedisplayorientation
    HRESULT SetNativeDisplayOrientation(NATIVE_DISPLAY_ORIENTATION nativeDisplayOrientation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationdesignmodesettings2-setapplicationvieworientation
    HRESULT SetApplicationViewOrientation(APPLICATION_VIEW_ORIENTATION viewOrientation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationdesignmodesettings2-setadjacentdisplayedges
    HRESULT SetAdjacentDisplayEdges(ADJACENT_DISPLAY_EDGES adjacentDisplayEdges);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationdesignmodesettings2-setisonlockscreen
    HRESULT SetIsOnLockScreen(BOOL isOnLockScreen);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationdesignmodesettings2-setapplicationviewminwidth
    HRESULT SetApplicationViewMinWidth(APPLICATION_VIEW_MIN_WIDTH viewMinWidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationdesignmodesettings2-getapplicationsizebounds
    HRESULT GetApplicationSizeBounds(SIZE* minApplicationSizePixels, SIZE* maxApplicationSizePixels);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iapplicationdesignmodesettings2-getapplicationvieworientation
    HRESULT GetApplicationViewOrientation(SIZE applicationSizePixels, 
                                          APPLICATION_VIEW_ORIENTATION* viewOrientation);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ilaunchtargetmonitor
@GUID("266fbc7e-490d-46ed-a96b-2274db252003")
interface ILaunchTargetMonitor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ilaunchtargetmonitor-getmonitor
    HRESULT GetMonitor(HMONITOR* monitor);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ilaunchsourceviewsizepreference
@GUID("e5aa01f7-1fb8-4830-8720-4e6734cbd5f3")
interface ILaunchSourceViewSizePreference : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ilaunchsourceviewsizepreference-getsourceviewtoposition
    HRESULT GetSourceViewToPosition(HWND* hwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ilaunchsourceviewsizepreference-getsourceviewsizepreference
    HRESULT GetSourceViewSizePreference(APPLICATION_VIEW_SIZE_PREFERENCE* sourceSizeAfterLaunch);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ilaunchtargetviewsizepreference
@GUID("2f0666c6-12f7-4360-b511-a394a0553725")
interface ILaunchTargetViewSizePreference : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ilaunchtargetviewsizepreference-gettargetviewsizepreference
    HRESULT GetTargetViewSizePreference(APPLICATION_VIEW_SIZE_PREFERENCE* targetSizeOnLaunch);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ilaunchsourceappusermodelid
@GUID("989191ac-28ff-4cf0-9584-e0d078bc2396")
interface ILaunchSourceAppUserModelId : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ilaunchsourceappusermodelid-getappusermodelid
    HRESULT GetAppUserModelId(PWSTR* launchingApp);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-iinitializewithwindow
@GUID("3e68d4bd-7135-4d10-8018-9fb6d9f33fa1")
interface IInitializeWithWindow : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-iinitializewithwindow-initialize
    HRESULT Initialize(HWND hwnd);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ihandlerinfo
@GUID("997706ef-f880-453b-8118-39e1a2d2655a")
interface IHandlerInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ihandlerinfo-getapplicationdisplayname
    HRESULT GetApplicationDisplayName(PWSTR* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ihandlerinfo-getapplicationpublisher
    HRESULT GetApplicationPublisher(PWSTR* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ihandlerinfo-getapplicationiconreference
    HRESULT GetApplicationIconReference(PWSTR* value);
}

@GUID("31cca04c-04d3-4ea9-90de-97b15e87a532")
interface IHandlerInfo2 : IHandlerInfo
{
    HRESULT GetApplicationId(PWSTR* value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ihandleractivationhost
@GUID("35094a87-8bb1-4237-96c6-c417eebdb078")
interface IHandlerActivationHost : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ihandleractivationhost-beforecocreateinstance
    HRESULT BeforeCoCreateInstance(const(GUID)* clsidHandler, IShellItemArray itemsBeingActivated, 
                                   IHandlerInfo handlerInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ihandleractivationhost-beforecreateprocess
    HRESULT BeforeCreateProcess(const(PWSTR) applicationPath, const(PWSTR) commandLine, IHandlerInfo handlerInfo);
}

@GUID("abad189d-9fa3-4278-b3ca-8ca448a88dcb")
interface IAppActivationUIInfo : IUnknown
{
    HRESULT GetMonitor(HMONITOR* value);
    HRESULT GetInvokePoint(POINT* value);
    HRESULT GetShowCommand(int* value);
    HRESULT GetShowUI(BOOL* value);
    HRESULT GetKeyState(uint* value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-icontactmanagerinterop
@GUID("99eacba7-e073-43b6-a896-55afe48a0833")
interface IContactManagerInterop : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-icontactmanagerinterop-showcontactcardforwindow
    HRESULT ShowContactCardForWindow(HWND appWindow, IUnknown contact, const(RECT)* selection, 
                                     FLYOUT_PLACEMENT preferredPlacement);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishelliconoverlayidentifier
@GUID("0c6c4200-c589-11d0-999a-00c04fd655e1")
interface IShellIconOverlayIdentifier : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelliconoverlayidentifier-ismemberof
    HRESULT IsMemberOf(const(PWSTR) pwszPath, uint dwAttrib);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelliconoverlayidentifier-getoverlayinfo
    HRESULT GetOverlayInfo(PWSTR pwszIconFile, int cchMax, int* pIndex, uint* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ishelliconoverlayidentifier-getpriority
    HRESULT GetPriority(int* pPriority);
}

@GUID("8d7b2ba7-db05-46a8-823c-d2b6de08ee91")
interface IBannerNotificationHandler : IUnknown
{
    HRESULT OnBannerEvent(const(BANNER_NOTIFICATION)* notification);
}

@GUID("6dfc60fb-f2e9-459b-beb5-288f1a7c7d54")
interface ISortColumnArray : IUnknown
{
    HRESULT GetCount(uint* columnCount);
    HRESULT GetAt(uint index, SORTCOLUMN* sortcolumn);
    HRESULT GetSortType(SORT_ORDER_TYPE* type);
}

@GUID("75bd59aa-f23b-4963-aba4-0b355752a91b")
interface IPropertyKeyStore : IUnknown
{
    HRESULT GetKeyCount(int* keyCount);
    HRESULT GetKeyAt(int index, PROPERTYKEY* pkey);
    HRESULT AppendKey(const(PROPERTYKEY)* key);
    HRESULT DeleteKey(int index);
    HRESULT IsKeyInStore(const(PROPERTYKEY)* key);
    HRESULT RemoveKey(const(PROPERTYKEY)* key);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-iquerycodepage
@GUID("c7b236ce-ee80-11d0-985f-006008059382")
interface IQueryCodePage : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iquerycodepage-getcodepage
    HRESULT GetCodePage(uint* puiCodePage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iquerycodepage-setcodepage
    HRESULT SetCodePage(uint uiCodePage);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-ifolderviewoptions
@GUID("3cc974d2-b302-4d36-ad3e-06d93f695d3f")
interface IFolderViewOptions : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ifolderviewoptions-setfolderviewoptions
    HRESULT SetFolderViewOptions(FOLDERVIEWOPTIONS fvoMask, FOLDERVIEWOPTIONS fvoFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ifolderviewoptions-getfolderviewoptions
    HRESULT GetFolderViewOptions(FOLDERVIEWOPTIONS* pfvoFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-ishellview3
@GUID("ec39fa88-f8af-41c5-8421-38bed28f4673")
interface IShellView3 : IShellView2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ishellview3-createviewwindow3
    HRESULT CreateViewWindow3(IShellBrowser psbOwner, IShellView psvPrev, uint dwViewFlags, FOLDERFLAGS dwMask, 
                              FOLDERFLAGS dwFlags, FOLDERVIEWMODE fvMode, const(GUID)* pvid, const(RECT)* prcView, 
                              HWND* phwndView);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-isearchboxinfo
@GUID("6af6e03f-d664-4ef4-9626-f7e0ed36755e")
interface ISearchBoxInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-isearchboxinfo-getcondition
    HRESULT GetCondition(const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-isearchboxinfo-gettext
    HRESULT GetText(PWSTR* ppsz);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-ivisualproperties
@GUID("e693cf68-d967-4112-8763-99172aee5e5a")
interface IVisualProperties : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ivisualproperties-setwatermark
    HRESULT SetWatermark(HBITMAP hbmp, VPWATERMARKFLAGS vpwf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ivisualproperties-setcolor
    HRESULT SetColor(VPCOLORFLAGS vpcf, COLORREF cr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ivisualproperties-getcolor
    HRESULT GetColor(VPCOLORFLAGS vpcf, COLORREF* pcr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ivisualproperties-setitemheight
    HRESULT SetItemHeight(int cyItemInPixels);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ivisualproperties-getitemheight
    HRESULT GetItemHeight(int* cyItemInPixels);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ivisualproperties-setfont
    HRESULT SetFont(const(LOGFONTW)* plf, BOOL bRedraw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ivisualproperties-getfont
    HRESULT GetFont(LOGFONTW* plf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ivisualproperties-settheme
    HRESULT SetTheme(const(PWSTR) pszSubAppName, const(PWSTR) pszSubIdList);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-icommdlgbrowser3
@GUID("c8ad25a1-3294-41ee-8165-71174bd01c57")
interface ICommDlgBrowser3 : ICommDlgBrowser2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-icommdlgbrowser3-oncolumnclicked
    HRESULT OnColumnClicked(IShellView ppshv, int iColumn);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-icommdlgbrowser3-getcurrentfilter
    HRESULT GetCurrentFilter(PWSTR pszFileSpec, int cchFileSpec);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-icommdlgbrowser3-onpreviewcreated
    HRESULT OnPreViewCreated(IShellView ppshv);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-iuseraccountchangecallback
@GUID("a561e69a-b4b8-4113-91a5-64c6bcca3430")
interface IUserAccountChangeCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iuseraccountchangecallback-onpicturechange
    HRESULT OnPictureChange(const(PWSTR) pszUserName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-istreamasync
@GUID("fe0b6665-e0ca-49b9-a178-2b5cb48d92a5")
interface IStreamAsync : IStream
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-istreamasync-readasync
    HRESULT ReadAsync(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pv, 
                      uint cb, uint* pcbRead, OVERLAPPED* lpOverlapped);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-istreamasync-writeasync
    HRESULT WriteAsync(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* lpBuffer, 
                       uint cb, uint* pcbWritten, OVERLAPPED* lpOverlapped);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-istreamasync-overlappedresult
    HRESULT OverlappedResult(OVERLAPPED* lpOverlapped, uint* lpNumberOfBytesTransferred, BOOL bWait);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-istreamasync-cancelio
    HRESULT CancelIo();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-istreamunbufferedinfo
@GUID("8a68fdda-1fdc-4c20-8ceb-416643b5a625")
interface IStreamUnbufferedInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-istreamunbufferedinfo-getsectorsize
    HRESULT GetSectorSize(uint* pcbSectorSize);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-idragsourcehelper2
@GUID("83e07d0d-0c5f-4163-bf1a-60b274051e40")
interface IDragSourceHelper2 : IDragSourceHelper
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-idragsourcehelper2-setflags
    HRESULT SetFlags(uint dwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-ihweventhandler
@GUID("c1fb73d0-ec3a-4ba2-b512-8cdb9187b6d1")
interface IHWEventHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ihweventhandler-initialize
    HRESULT Initialize(const(PWSTR) pszParams);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ihweventhandler-handleevent
    HRESULT HandleEvent(const(PWSTR) pszDeviceID, const(PWSTR) pszAltDeviceID, const(PWSTR) pszEventType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ihweventhandler-handleeventwithcontent
    HRESULT HandleEventWithContent(const(PWSTR) pszDeviceID, const(PWSTR) pszAltDeviceID, 
                                   const(PWSTR) pszEventType, const(PWSTR) pszContentTypeHandler, 
                                   IDataObject pdataobject);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-ihweventhandler2
@GUID("cfcc809f-295d-42e8-9ffc-424b33c487e6")
interface IHWEventHandler2 : IHWEventHandler
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ihweventhandler2-handleeventwithhwnd
    HRESULT HandleEventWithHWND(const(PWSTR) pszDeviceID, const(PWSTR) pszAltDeviceID, const(PWSTR) pszEventType, 
                                HWND hwndOwner);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-iquerycancelautoplay
@GUID("ddefe873-6997-4e68-be26-39b633adbe12")
interface IQueryCancelAutoPlay : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iquerycancelautoplay-allowautoplay
    HRESULT AllowAutoPlay(const(PWSTR) pszPath, uint dwContentType, const(PWSTR) pszLabel, uint dwSerialNumber);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-idynamichwhandler
@GUID("dc2601d7-059e-42fc-a09d-2afd21b6d5f7")
interface IDynamicHWHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-idynamichwhandler-getdynamicinfo
    HRESULT GetDynamicInfo(const(PWSTR) pszDeviceID, uint dwContentType, PWSTR* ppszAction);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-iusernotificationcallback
@GUID("19108294-0441-4aff-8013-fa0a730b0bea")
interface IUserNotificationCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iusernotificationcallback-onballoonuserclick
    HRESULT OnBalloonUserClick(POINT* pt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iusernotificationcallback-onleftclick
    HRESULT OnLeftClick(POINT* pt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iusernotificationcallback-oncontextmenu
    HRESULT OnContextMenu(POINT* pt);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-iusernotification2
@GUID("215913cc-57eb-4fab-ab5a-e5fa7bea2a6c")
interface IUserNotification2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iusernotification2-setballooninfo
    HRESULT SetBalloonInfo(const(PWSTR) pszTitle, const(PWSTR) pszText, uint dwInfoFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iusernotification2-setballoonretry
    HRESULT SetBalloonRetry(uint dwShowTime, uint dwInterval, uint cRetryCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iusernotification2-seticoninfo
    HRESULT SetIconInfo(HICON hIcon, const(PWSTR) pszToolTip);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iusernotification2-show
    HRESULT Show(IQueryContinue pqc, uint dwContinuePollInterval, IUserNotificationCallback pSink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iusernotification2-playsound
    HRESULT PlaySound(const(PWSTR) pszSoundName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-ideskband2
@GUID("79d16de4-abee-4021-8d9d-9169b261d657")
interface IDeskBand2 : IDeskBand
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ideskband2-canrendercomposited
    HRESULT CanRenderComposited(BOOL* pfCanRenderComposited);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ideskband2-setcompositionstate
    HRESULT SetCompositionState(BOOL fCompositionEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ideskband2-getcompositionstate
    HRESULT GetCompositionState(BOOL* pfCompositionEnabled);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-istartmenupinnedlist
@GUID("4cd19ada-25a5-4a32-b3b7-347bee5be36b")
interface IStartMenuPinnedList : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-istartmenupinnedlist-removefromlist
    HRESULT RemoveFromList(IShellItem pitem);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-icdburn
@GUID("3d73a659-e5d0-4d42-afc0-5121ba425c8d")
interface ICDBurn : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-icdburn-getrecorderdriveletter
    HRESULT GetRecorderDriveLetter(PWSTR pszDrive, uint cch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-icdburn-burn
    HRESULT Burn(HWND hwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-icdburn-hasrecordabledrive
    HRESULT HasRecordableDrive(BOOL* pfHasRecorder);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-iwizardsite
@GUID("88960f5b-422f-4e7b-8013-73415381c3c3")
interface IWizardSite : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iwizardsite-getpreviouspage
    HRESULT GetPreviousPage(HPROPSHEETPAGE* phpage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iwizardsite-getnextpage
    HRESULT GetNextPage(HPROPSHEETPAGE* phpage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iwizardsite-getcancelledpage
    HRESULT GetCancelledPage(HPROPSHEETPAGE* phpage);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-iwizardextension
@GUID("c02ea696-86cc-491e-9b23-74394a0444a8")
interface IWizardExtension : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iwizardextension-addpages
    HRESULT AddPages(HPROPSHEETPAGE* aPages, uint cPages, uint* pnPagesAdded);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iwizardextension-getfirstpage
    HRESULT GetFirstPage(HPROPSHEETPAGE* phpage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iwizardextension-getlastpage
    HRESULT GetLastPage(HPROPSHEETPAGE* phpage);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-iwebwizardextension
@GUID("0e6b3f66-98d1-48c0-a222-fbde74e2fbc5")
interface IWebWizardExtension : IWizardExtension
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iwebwizardextension-setinitialurl
    HRESULT SetInitialURL(const(PWSTR) pszURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iwebwizardextension-seterrorurl
    HRESULT SetErrorURL(const(PWSTR) pszErrorURL);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-ipublishingwizard
@GUID("aa9198bb-ccec-472d-beed-19a4f6733f7a")
interface IPublishingWizard : IWizardExtension
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ipublishingwizard-initialize
    HRESULT Initialize(IDataObject pdo, uint dwOptions, const(PWSTR) pszServiceScope);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ipublishingwizard-gettransfermanifest
    HRESULT GetTransferManifest(HRESULT* phrFromTransfer, IXMLDOMDocument* pdocManifest);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-ifolderviewhost
@GUID("1ea58f02-d55a-411d-b09e-9e65ac21605b")
interface IFolderViewHost : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ifolderviewhost-initialize
    HRESULT Initialize(HWND hwndParent, IDataObject pdo, RECT* prc);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-iaccessibleobject
@GUID("95a391c5-9ed4-4c28-8401-ab9e06719e11")
interface IAccessibleObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iaccessibleobject-setaccessiblename
    HRESULT SetAccessibleName(const(PWSTR) pszName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-iresultsfolder
@GUID("96e5ae6d-6ae1-4b1c-900c-c6480eaa8828")
interface IResultsFolder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iresultsfolder-additem
    HRESULT AddItem(IShellItem psi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iresultsfolder-addidlist
    HRESULT AddIDList(ITEMIDLIST* pidl, ITEMIDLIST** ppidlAdded);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iresultsfolder-removeitem
    HRESULT RemoveItem(IShellItem psi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iresultsfolder-removeidlist
    HRESULT RemoveIDList(ITEMIDLIST* pidl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iresultsfolder-removeall
    HRESULT RemoveAll();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-iautocompletedropdown
@GUID("3cd141f4-3c6a-11d2-bcaa-00c04fd929db")
interface IAutoCompleteDropDown : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iautocompletedropdown-getdropdownstatus
    HRESULT GetDropDownStatus(uint* pdwFlags, PWSTR* ppwszString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iautocompletedropdown-resetenumerator
    HRESULT ResetEnumerator();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-icdburnext
@GUID("2271dcca-74fc-4414-8fb7-c56b05ace2d7")
interface ICDBurnExt : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-icdburnext-getsupportedactiontypes
    HRESULT GetSupportedActionTypes(uint* pdwActions);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-ienumreadycallback
@GUID("61e00d45-8fff-4e60-924e-6537b61612dd")
interface IEnumReadyCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ienumreadycallback-enumready
    HRESULT EnumReady();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-ienumerableview
@GUID("8c8bf236-1aec-495f-9894-91d57c3c686f")
interface IEnumerableView : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ienumerableview-setenumreadycallback
    HRESULT SetEnumReadyCallback(IEnumReadyCallback percb);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ienumerableview-createenumidlistfromcontents
    HRESULT CreateEnumIDListFromContents(ITEMIDLIST* pidlFolder, uint dwEnumFlags, IEnumIDList* ppEnumIDList);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-iinsertitem
@GUID("d2b57227-3d23-4b95-93c0-492bd454c356")
interface IInsertItem : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iinsertitem-insertitem
    HRESULT InsertItem(ITEMIDLIST* pidl);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-ifolderbandpriv
@GUID("47c01f95-e185-412c-b5c5-4f27df965aea")
interface IFolderBandPriv : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ifolderbandpriv-setcascade
    HRESULT SetCascade(BOOL fCascade);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ifolderbandpriv-setaccelerators
    HRESULT SetAccelerators(BOOL fAccelerators);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ifolderbandpriv-setnoicons
    HRESULT SetNoIcons(BOOL fNoIcons);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ifolderbandpriv-setnotext
    HRESULT SetNoText(BOOL fNoText);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-iimagerecompress
@GUID("505f1513-6b3e-4892-a272-59f8889a4d3e")
interface IImageRecompress : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iimagerecompress-recompressimage
    HRESULT RecompressImage(IShellItem psi, int cx, int cy, int iQuality, IStorage pstg, IStream* ppstrmOut);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-ifiledialogcontrolevents
@GUID("36116642-d713-4b97-9b83-7484a9d00433")
interface IFileDialogControlEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ifiledialogcontrolevents-onitemselected
    HRESULT OnItemSelected(IFileDialogCustomize pfdc, uint dwIDCtl, uint dwIDItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ifiledialogcontrolevents-onbuttonclicked
    HRESULT OnButtonClicked(IFileDialogCustomize pfdc, uint dwIDCtl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ifiledialogcontrolevents-oncheckbuttontoggled
    HRESULT OnCheckButtonToggled(IFileDialogCustomize pfdc, uint dwIDCtl, BOOL bChecked);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ifiledialogcontrolevents-oncontrolactivating
    HRESULT OnControlActivating(IFileDialogCustomize pfdc, uint dwIDCtl);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-ifiledialog2
@GUID("61744fc7-85b5-4791-a9b0-272276309b13")
interface IFileDialog2 : IFileDialog
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ifiledialog2-setcancelbuttonlabel
    HRESULT SetCancelButtonLabel(const(PWSTR) pszLabel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ifiledialog2-setnavigationroot
    HRESULT SetNavigationRoot(IShellItem psi);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-iapplicationassociationregistrationui
@GUID("1f76a169-f994-40ac-8fc8-0959e8874710")
interface IApplicationAssociationRegistrationUI : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iapplicationassociationregistrationui-launchadvancedassociationui
    HRESULT LaunchAdvancedAssociationUI(const(PWSTR) pszAppRegistryName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-ishellrundll
@GUID("fce4bde0-4b68-4b80-8e9c-7426315a7388")
interface IShellRunDll : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ishellrundll-run
    HRESULT Run(const(PWSTR) pszArgs);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-ipreviousversionsinfo
@GUID("76e54780-ad74-48e3-a695-3ba9a0aff10d")
interface IPreviousVersionsInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ipreviousversionsinfo-aresnapshotsavailable
    HRESULT AreSnapshotsAvailable(const(PWSTR) pszPath, BOOL fOkToBeSlow, BOOL* pfAvailable);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-iusetobrowseitem
@GUID("05edda5c-98a3-4717-8adb-c5e7da991eb1")
interface IUseToBrowseItem : IRelatedItem
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-inamespacetreecontrol2
@GUID("7cc7aed8-290e-49bc-8945-c1401cc9306c")
interface INameSpaceTreeControl2 : INameSpaceTreeControl
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrol2-setcontrolstyle
    HRESULT SetControlStyle(uint nstcsMask, uint nstcsStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrol2-getcontrolstyle
    HRESULT GetControlStyle(uint nstcsMask, uint* pnstcsStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrol2-setcontrolstyle2
    HRESULT SetControlStyle2(NSTCSTYLE2 nstcsMask, NSTCSTYLE2 nstcsStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrol2-getcontrolstyle2
    HRESULT GetControlStyle2(NSTCSTYLE2 nstcsMask, NSTCSTYLE2* pnstcsStyle);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-inamespacetreecontrolevents
@GUID("93d77985-b3d8-4484-8318-672cdda002ce")
interface INameSpaceTreeControlEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolevents-onitemclick
    HRESULT OnItemClick(IShellItem psi, uint nstceHitTest, uint nstceClickType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolevents-onpropertyitemcommit
    HRESULT OnPropertyItemCommit(IShellItem psi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolevents-onitemstatechanging
    HRESULT OnItemStateChanging(IShellItem psi, uint nstcisMask, uint nstcisState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolevents-onitemstatechanged
    HRESULT OnItemStateChanged(IShellItem psi, uint nstcisMask, uint nstcisState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolevents-onselectionchanged
    HRESULT OnSelectionChanged(IShellItemArray psiaSelection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolevents-onkeyboardinput
    HRESULT OnKeyboardInput(uint uMsg, WPARAM wParam, LPARAM lParam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolevents-onbeforeexpand
    HRESULT OnBeforeExpand(IShellItem psi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolevents-onafterexpand
    HRESULT OnAfterExpand(IShellItem psi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolevents-onbeginlabeledit
    HRESULT OnBeginLabelEdit(IShellItem psi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolevents-onendlabeledit
    HRESULT OnEndLabelEdit(IShellItem psi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolevents-ongettooltip
    HRESULT OnGetToolTip(IShellItem psi, PWSTR pszTip, int cchTip);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolevents-onbeforeitemdelete
    HRESULT OnBeforeItemDelete(IShellItem psi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolevents-onitemadded
    HRESULT OnItemAdded(IShellItem psi, BOOL fIsRoot);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolevents-onitemdeleted
    HRESULT OnItemDeleted(IShellItem psi, BOOL fIsRoot);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolevents-onbeforecontextmenu
    HRESULT OnBeforeContextMenu(IShellItem psi, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolevents-onaftercontextmenu
    HRESULT OnAfterContextMenu(IShellItem psi, IContextMenu pcmIn, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolevents-onbeforestateimagechange
    HRESULT OnBeforeStateImageChange(IShellItem psi);
    HRESULT OnGetDefaultIconIndex(IShellItem psi, int* piDefaultIcon, int* piOpenIcon);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-inamespacetreecontroldrophandler
@GUID("f9c665d6-c2f2-4c19-bf33-8322d7352f51")
interface INameSpaceTreeControlDropHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontroldrophandler-ondragenter
    HRESULT OnDragEnter(IShellItem psiOver, IShellItemArray psiaData, BOOL fOutsideSource, uint grfKeyState, 
                        uint* pdwEffect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontroldrophandler-ondragover
    HRESULT OnDragOver(IShellItem psiOver, IShellItemArray psiaData, uint grfKeyState, uint* pdwEffect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontroldrophandler-ondragposition
    HRESULT OnDragPosition(IShellItem psiOver, IShellItemArray psiaData, int iNewPosition, int iOldPosition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontroldrophandler-ondrop
    HRESULT OnDrop(IShellItem psiOver, IShellItemArray psiaData, int iPosition, uint grfKeyState, uint* pdwEffect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontroldrophandler-ondropposition
    HRESULT OnDropPosition(IShellItem psiOver, IShellItemArray psiaData, int iNewPosition, int iOldPosition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontroldrophandler-ondragleave
    HRESULT OnDragLeave(IShellItem psiOver);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-inamespacetreeaccessible
@GUID("71f312de-43ed-4190-8477-e9536b82350b")
interface INameSpaceTreeAccessible : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreeaccessible-ongetdefaultaccessibilityaction
    HRESULT OnGetDefaultAccessibilityAction(IShellItem psi, BSTR* pbstrDefaultAction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreeaccessible-ondodefaultaccessibilityaction
    HRESULT OnDoDefaultAccessibilityAction(IShellItem psi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreeaccessible-ongetaccessibilityrole
    HRESULT OnGetAccessibilityRole(IShellItem psi, VARIANT* pvarRole);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-inamespacetreecontrolcustomdraw
@GUID("2d3ba758-33ee-42d5-bb7b-5f3431d86c78")
interface INameSpaceTreeControlCustomDraw : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolcustomdraw-prepaint
    HRESULT PrePaint(HDC hdc, RECT* prc, LRESULT* plres);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolcustomdraw-postpaint
    HRESULT PostPaint(HDC hdc, RECT* prc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolcustomdraw-itemprepaint
    HRESULT ItemPrePaint(HDC hdc, RECT* prc, NSTCCUSTOMDRAW* pnstccdItem, COLORREF* pclrText, COLORREF* pclrTextBk, 
                         LRESULT* plres);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-inamespacetreecontrolcustomdraw-itempostpaint
    HRESULT ItemPostPaint(HDC hdc, RECT* prc, NSTCCUSTOMDRAW* pnstccdItem);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-itraydeskband
@GUID("6d67e846-5b9c-4db8-9cbc-dde12f4254f1")
interface ITrayDeskBand : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-itraydeskband-showdeskband
    HRESULT ShowDeskBand(const(GUID)* clsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-itraydeskband-hidedeskband
    HRESULT HideDeskBand(const(GUID)* clsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-itraydeskband-isdeskbandshown
    HRESULT IsDeskBandShown(const(GUID)* clsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-itraydeskband-deskbandregistrationchanged
    HRESULT DeskBandRegistrationChanged();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-ibandhost
@GUID("b9075c7c-d48e-403f-ab99-d6c77a1084ac")
interface IBandHost : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ibandhost-createband
    HRESULT CreateBand(const(GUID)* rclsidBand, BOOL fAvailable, BOOL fVisible, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ibandhost-setbandavailability
    HRESULT SetBandAvailability(const(GUID)* rclsidBand, BOOL fAvailable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-ibandhost-destroyband
    HRESULT DestroyBand(const(GUID)* rclsidBand);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-icomputerinfochangenotify
@GUID("0df60d92-6818-46d6-b358-d66170dde466")
interface IComputerInfoChangeNotify : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-icomputerinfochangenotify-computerinfochanged
    HRESULT ComputerInfoChanged();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-idesktopgadget
@GUID("c1646bc4-f298-4f91-a204-eb2dd1709d1a")
interface IDesktopGadget : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-idesktopgadget-rungadget
    HRESULT RunGadget(const(PWSTR) gadgetPath);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-iaccessibilitydockingservicecallback
@GUID("157733fd-a592-42e5-b594-248468c5a81b")
interface IAccessibilityDockingServiceCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iaccessibilitydockingservicecallback-undocked
    HRESULT Undocked(UNDOCK_REASON undockReason);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nn-shobjidl-iaccessibilitydockingservice
@GUID("8849dc22-cedf-4c95-998d-051419dd3f76")
interface IAccessibilityDockingService : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/com/iaccessibilitydockingservice-getavailablesize
    HRESULT GetAvailableSize(HMONITOR hMonitor, uint* pcxFixed, uint* pcyMax);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iaccessibilitydockingservice-dockwindow
    HRESULT DockWindow(HWND hwnd, HMONITOR hMonitor, uint cyRequested, 
                       IAccessibilityDockingServiceCallback pCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-iaccessibilitydockingservice-undockwindow
    HRESULT UndockWindow(HWND hwnd);
}

@GUID("5efb46d7-47c0-4b68-acda-ded47c90ec91")
interface IStorageProviderBanners : IUnknown
{
    HRESULT SetBanner(const(PWSTR) providerIdentity, const(PWSTR) subscriptionId, const(PWSTR) contentId);
    HRESULT ClearBanner(const(PWSTR) providerIdentity, const(PWSTR) subscriptionId);
    HRESULT ClearAllBanners(const(PWSTR) providerIdentity);
    HRESULT GetBanner(const(PWSTR) providerIdentity, const(PWSTR) subscriptionId, PWSTR* contentId);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/nn-shobjidl-istorageprovidercopyhook
@GUID("7bf992a9-af7a-4dba-b2e5-4d080b1ecbc6")
interface IStorageProviderCopyHook : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/nf-shobjidl-istorageprovidercopyhook-copycallback
    HRESULT CopyCallback(HWND hwnd, uint operation, uint flags, const(PWSTR) srcFile, uint srcAttribs, 
                         const(PWSTR) destFile, uint destAttribs, uint* result);
}

@GUID("eab22ac1-30c1-11cf-a7eb-0000c05bae0b")
interface IWebBrowser : IDispatch
{
    HRESULT GoBack();
    HRESULT GoForward();
    HRESULT GoHome();
    HRESULT GoSearch();
    HRESULT Navigate(BSTR URL, VARIANT* Flags, VARIANT* TargetFrameName, VARIANT* PostData, VARIANT* Headers);
    HRESULT Refresh();
    HRESULT Refresh2(VARIANT* Level);
    HRESULT Stop();
    HRESULT get_Application(IDispatch* ppDisp);
    HRESULT get_Parent(IDispatch* ppDisp);
    HRESULT get_Container(IDispatch* ppDisp);
    HRESULT get_Document(IDispatch* ppDisp);
    HRESULT get_TopLevelContainer(VARIANT_BOOL* pBool);
    HRESULT get_Type(BSTR* Type);
    HRESULT get_Left(int* pl);
    HRESULT put_Left(int Left);
    HRESULT get_Top(int* pl);
    HRESULT put_Top(int Top);
    HRESULT get_Width(int* pl);
    HRESULT put_Width(int Width);
    HRESULT get_Height(int* pl);
    HRESULT put_Height(int Height);
    HRESULT get_LocationName(BSTR* LocationName);
    HRESULT get_LocationURL(BSTR* LocationURL);
    HRESULT get_Busy(VARIANT_BOOL* pBool);
}

@GUID("eab22ac2-30c1-11cf-a7eb-0000c05bae0b")
interface DWebBrowserEvents : IDispatch
{
}

@GUID("0002df05-0000-0000-c000-000000000046")
interface IWebBrowserApp : IWebBrowser
{
    HRESULT Quit();
    HRESULT ClientToWindow(int* pcx, int* pcy);
    HRESULT PutProperty(BSTR Property, VARIANT vtValue);
    HRESULT GetProperty(BSTR Property, VARIANT* pvtValue);
    HRESULT get_Name(BSTR* Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/exdisp/nf-exdisp-iwebbrowserapp-get_hwnd
    HRESULT get_HWND(SHANDLE_PTR* pHWND);
    HRESULT get_FullName(BSTR* FullName);
    HRESULT get_Path(BSTR* Path);
    HRESULT get_Visible(VARIANT_BOOL* pBool);
    HRESULT put_Visible(VARIANT_BOOL Value);
    HRESULT get_StatusBar(VARIANT_BOOL* pBool);
    HRESULT put_StatusBar(VARIANT_BOOL Value);
    HRESULT get_StatusText(BSTR* StatusText);
    HRESULT put_StatusText(BSTR StatusText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/exdisp/nf-exdisp-iwebbrowserapp-get_toolbar
    HRESULT get_ToolBar(int* Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/exdisp/nf-exdisp-iwebbrowserapp-put_toolbar
    HRESULT put_ToolBar(int Value);
    HRESULT get_MenuBar(VARIANT_BOOL* Value);
    HRESULT put_MenuBar(VARIANT_BOOL Value);
    HRESULT get_FullScreen(VARIANT_BOOL* pbFullScreen);
    HRESULT put_FullScreen(VARIANT_BOOL bFullScreen);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/exdisp/nn-exdisp-iwebbrowser2
@GUID("d30c1661-cdaf-11d0-8a3e-00c04fc9e26e")
interface IWebBrowser2 : IWebBrowserApp
{
    HRESULT Navigate2(VARIANT* URL, VARIANT* Flags, VARIANT* TargetFrameName, VARIANT* PostData, VARIANT* Headers);
    HRESULT QueryStatusWB(OLECMDID cmdID, OLECMDF* pcmdf);
    HRESULT ExecWB(OLECMDID cmdID, OLECMDEXECOPT cmdexecopt, VARIANT* pvaIn, VARIANT* pvaOut);
    HRESULT ShowBrowserBar(VARIANT* pvaClsid, VARIANT* pvarShow, VARIANT* pvarSize);
    HRESULT get_ReadyState(READYSTATE* plReadyState);
    HRESULT get_Offline(VARIANT_BOOL* pbOffline);
    HRESULT put_Offline(VARIANT_BOOL bOffline);
    HRESULT get_Silent(VARIANT_BOOL* pbSilent);
    HRESULT put_Silent(VARIANT_BOOL bSilent);
    HRESULT get_RegisterAsBrowser(VARIANT_BOOL* pbRegister);
    HRESULT put_RegisterAsBrowser(VARIANT_BOOL bRegister);
    HRESULT get_RegisterAsDropTarget(VARIANT_BOOL* pbRegister);
    HRESULT put_RegisterAsDropTarget(VARIANT_BOOL bRegister);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/exdisp/nf-exdisp-iwebbrowser2-get_theatermode
    HRESULT get_TheaterMode(VARIANT_BOOL* pbRegister);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/exdisp/nf-exdisp-iwebbrowser2-put_theatermode
    HRESULT put_TheaterMode(VARIANT_BOOL bRegister);
    HRESULT get_AddressBar(VARIANT_BOOL* Value);
    HRESULT put_AddressBar(VARIANT_BOOL Value);
    HRESULT get_Resizable(VARIANT_BOOL* Value);
    HRESULT put_Resizable(VARIANT_BOOL Value);
}

@GUID("34a715a0-6587-11d0-924a-0020afc7ac4d")
interface DWebBrowserEvents2 : IDispatch
{
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/dshellwindowsevents
@GUID("fe4106e0-399a-11d0-a48c-00a0c90a8f39")
interface DShellWindowsEvents : IDispatch
{
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/exdisp/nn-exdisp-ishellwindows
@GUID("85cb6900-4d95-11cf-960c-0080c7f4ee85")
interface IShellWindows : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/exdisp/nf-exdisp-ishellwindows-get_count
    HRESULT get_Count(int* Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/exdisp/nf-exdisp-ishellwindows-item
    HRESULT Item(VARIANT index, IDispatch* Folder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/exdisp/nf-exdisp-ishellwindows-_newenum
    HRESULT _NewEnum(IUnknown* ppunk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/exdisp/nf-exdisp-ishellwindows-register
    HRESULT Register(IDispatch pid, int hwnd, ShellWindowTypeConstants swClass, int* plCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/exdisp/nf-exdisp-ishellwindows-registerpending
    HRESULT RegisterPending(int lThreadId, VARIANT* pvarloc, VARIANT* pvarlocRoot, 
                            ShellWindowTypeConstants swClass, int* plCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/exdisp/nf-exdisp-ishellwindows-revoke
    HRESULT Revoke(int lCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/exdisp/nf-exdisp-ishellwindows-onnavigate
    HRESULT OnNavigate(int lCookie, VARIANT* pvarLoc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/exdisp/nf-exdisp-ishellwindows-onactivated
    HRESULT OnActivated(int lCookie, VARIANT_BOOL fActive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/exdisp/nf-exdisp-ishellwindows-findwindowsw
    HRESULT FindWindowSW(VARIANT* pvarLoc, VARIANT* pvarLocRoot, ShellWindowTypeConstants swClass, int* phwnd, 
                         ShellWindowFindWindowOptions swfwOptions, IDispatch* ppdispOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/exdisp/nf-exdisp-ishellwindows-oncreated
    HRESULT OnCreated(int lCookie, IUnknown punk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/exdisp/nf-exdisp-ishellwindows-processattachdetach
    HRESULT ProcessAttachDetach(VARIANT_BOOL fAttach);
}

@GUID("729fe2f8-1ea8-11d1-8f85-00c04fc2fbe1")
interface IShellUIHelper : IDispatch
{
    HRESULT ResetFirstBootMode();
    HRESULT ResetSafeMode();
    HRESULT RefreshOfflineDesktop();
    HRESULT AddFavorite(BSTR URL, VARIANT* Title);
    HRESULT AddChannel(BSTR URL);
    HRESULT AddDesktopComponent(BSTR URL, BSTR Type, VARIANT* Left, VARIANT* Top, VARIANT* Width, VARIANT* Height);
    HRESULT IsSubscribed(BSTR URL, VARIANT_BOOL* pBool);
    HRESULT NavigateAndFind(BSTR URL, BSTR strQuery, VARIANT* varTargetFrame);
    HRESULT ImportExportFavorites(VARIANT_BOOL fImport, BSTR strImpExpPath);
    HRESULT AutoCompleteSaveForm(VARIANT* Form);
    HRESULT AutoScan(BSTR strSearch, BSTR strFailureUrl, VARIANT* pvarTargetFrame);
    HRESULT AutoCompleteAttach(VARIANT* Reserved);
    HRESULT ShowBrowserUI(BSTR bstrName, VARIANT* pvarIn, VARIANT* pvarOut);
}

@GUID("a7fe6eda-1932-4281-b881-87b31b8bc52c")
interface IShellUIHelper2 : IShellUIHelper
{
    HRESULT AddSearchProvider(BSTR URL);
    HRESULT RunOnceShown();
    HRESULT SkipRunOnce();
    HRESULT CustomizeSettings(VARIANT_BOOL fSQM, VARIANT_BOOL fPhishing, BSTR bstrLocale);
    HRESULT SqmEnabled(VARIANT_BOOL* pfEnabled);
    HRESULT PhishingEnabled(VARIANT_BOOL* pfEnabled);
    HRESULT BrandImageUri(BSTR* pbstrUri);
    HRESULT SkipTabsWelcome();
    HRESULT DiagnoseConnection();
    HRESULT CustomizeClearType(VARIANT_BOOL fSet);
    HRESULT IsSearchProviderInstalled(BSTR URL, uint* pdwResult);
    HRESULT IsSearchMigrated(VARIANT_BOOL* pfMigrated);
    HRESULT DefaultSearchProvider(BSTR* pbstrName);
    HRESULT RunOnceRequiredSettingsComplete(VARIANT_BOOL fComplete);
    HRESULT RunOnceHasShown(VARIANT_BOOL* pfShown);
    HRESULT SearchGuideUrl(BSTR* pbstrUrl);
}

@GUID("528df2ec-d419-40bc-9b6d-dcdbf9c1b25d")
interface IShellUIHelper3 : IShellUIHelper2
{
    HRESULT AddService(BSTR URL);
    HRESULT IsServiceInstalled(BSTR URL, BSTR Verb, uint* pdwResult);
    HRESULT InPrivateFilteringEnabled(VARIANT_BOOL* pfEnabled);
    HRESULT AddToFavoritesBar(BSTR URL, BSTR Title, VARIANT* Type);
    HRESULT BuildNewTabPage();
    HRESULT SetRecentlyClosedVisible(VARIANT_BOOL fVisible);
    HRESULT SetActivitiesVisible(VARIANT_BOOL fVisible);
    HRESULT ContentDiscoveryReset();
    HRESULT IsSuggestedSitesEnabled(VARIANT_BOOL* pfEnabled);
    HRESULT EnableSuggestedSites(VARIANT_BOOL fEnable);
    HRESULT NavigateToSuggestedSites(BSTR bstrRelativeUrl);
    HRESULT ShowTabsHelp();
    HRESULT ShowInPrivateHelp();
}

@GUID("b36e6a53-8073-499e-824c-d776330a333e")
interface IShellUIHelper4 : IShellUIHelper3
{
    HRESULT msIsSiteMode(VARIANT_BOOL* pfSiteMode);
    HRESULT msSiteModeShowThumbBar();
    HRESULT msSiteModeAddThumbBarButton(BSTR bstrIconURL, BSTR bstrTooltip, VARIANT* pvarButtonID);
    HRESULT msSiteModeUpdateThumbBarButton(VARIANT ButtonID, VARIANT_BOOL fEnabled, VARIANT_BOOL fVisible);
    HRESULT msSiteModeSetIconOverlay(BSTR IconUrl, VARIANT* pvarDescription);
    HRESULT msSiteModeClearIconOverlay();
    HRESULT msAddSiteMode();
    HRESULT msSiteModeCreateJumpList(BSTR bstrHeader);
    HRESULT msSiteModeAddJumpListItem(BSTR bstrName, BSTR bstrActionUri, BSTR bstrIconUri, VARIANT* pvarWindowType);
    HRESULT msSiteModeClearJumpList();
    HRESULT msSiteModeShowJumpList();
    HRESULT msSiteModeAddButtonStyle(VARIANT uiButtonID, BSTR bstrIconUrl, BSTR bstrTooltip, VARIANT* pvarStyleID);
    HRESULT msSiteModeShowButtonStyle(VARIANT uiButtonID, VARIANT uiStyleID);
    HRESULT msSiteModeActivate();
    HRESULT msIsSiteModeFirstRun(VARIANT_BOOL fPreserveState, VARIANT* puiFirstRun);
    HRESULT msAddTrackingProtectionList(BSTR URL, BSTR bstrFilterName);
    HRESULT msTrackingProtectionEnabled(VARIANT_BOOL* pfEnabled);
    HRESULT msActiveXFilteringEnabled(VARIANT_BOOL* pfEnabled);
}

@GUID("a2a08b09-103d-4d3f-b91c-ea455ca82efa")
interface IShellUIHelper5 : IShellUIHelper4
{
    HRESULT msProvisionNetworks(BSTR bstrProvisioningXml, VARIANT* puiResult);
    HRESULT msReportSafeUrl();
    HRESULT msSiteModeRefreshBadge();
    HRESULT msSiteModeClearBadge();
    HRESULT msDiagnoseConnectionUILess();
    HRESULT msLaunchNetworkClientHelp();
    HRESULT msChangeDefaultBrowser(VARIANT_BOOL fChange);
}

@GUID("987a573e-46ee-4e89-96ab-ddf7f8fdc98c")
interface IShellUIHelper6 : IShellUIHelper5
{
    HRESULT msStopPeriodicTileUpdate();
    HRESULT msStartPeriodicTileUpdate(VARIANT pollingUris, VARIANT startTime, VARIANT uiUpdateRecurrence);
    HRESULT msStartPeriodicTileUpdateBatch(VARIANT pollingUris, VARIANT startTime, VARIANT uiUpdateRecurrence);
    HRESULT msClearTile();
    HRESULT msEnableTileNotificationQueue(VARIANT_BOOL fChange);
    HRESULT msPinnedSiteState(VARIANT* pvarSiteState);
    HRESULT msEnableTileNotificationQueueForSquare150x150(VARIANT_BOOL fChange);
    HRESULT msEnableTileNotificationQueueForWide310x150(VARIANT_BOOL fChange);
    HRESULT msEnableTileNotificationQueueForSquare310x310(VARIANT_BOOL fChange);
    HRESULT msScheduledTileNotification(BSTR bstrNotificationXml, BSTR bstrNotificationId, 
                                        BSTR bstrNotificationTag, VARIANT startTime, VARIANT expirationTime);
    HRESULT msRemoveScheduledTileNotification(BSTR bstrNotificationId);
    HRESULT msStartPeriodicBadgeUpdate(BSTR pollingUri, VARIANT startTime, VARIANT uiUpdateRecurrence);
    HRESULT msStopPeriodicBadgeUpdate();
    HRESULT msLaunchInternetOptions();
}

@GUID("60e567c8-9573-4ab2-a264-637c6c161cb1")
interface IShellUIHelper7 : IShellUIHelper6
{
    HRESULT SetExperimentalFlag(BSTR bstrFlagString, VARIANT_BOOL vfFlag);
    HRESULT GetExperimentalFlag(BSTR bstrFlagString, VARIANT_BOOL* vfFlag);
    HRESULT SetExperimentalValue(BSTR bstrValueString, uint dwValue);
    HRESULT GetExperimentalValue(BSTR bstrValueString, uint* pdwValue);
    HRESULT ResetAllExperimentalFlagsAndValues();
    HRESULT GetNeedIEAutoLaunchFlag(BSTR bstrUrl, VARIANT_BOOL* flag);
    HRESULT SetNeedIEAutoLaunchFlag(BSTR bstrUrl, VARIANT_BOOL flag);
    HRESULT HasNeedIEAutoLaunchFlag(BSTR bstrUrl, VARIANT_BOOL* exists);
    HRESULT LaunchIE(BSTR bstrUrl, VARIANT_BOOL automated);
}

@GUID("66debcf2-05b0-4f07-b49b-b96241a65db2")
interface IShellUIHelper8 : IShellUIHelper7
{
    HRESULT GetCVListData(BSTR* pbstrResult);
    HRESULT GetCVListLocalData(BSTR* pbstrResult);
    HRESULT GetEMIEListData(BSTR* pbstrResult);
    HRESULT GetEMIEListLocalData(BSTR* pbstrResult);
    HRESULT OpenFavoritesPane();
    HRESULT OpenFavoritesSettings();
    HRESULT LaunchInHVSI(BSTR bstrUrl);
}

@GUID("6cdf73b0-7f2f-451f-bc0f-63e0f3284e54")
interface IShellUIHelper9 : IShellUIHelper8
{
    HRESULT GetOSSku(uint* pdwResult);
}

@GUID("55136806-b2de-11d1-b9f2-00a0c98bc547")
interface DShellNameSpaceEvents : IDispatch
{
}

@GUID("55136804-b2de-11d1-b9f2-00a0c98bc547")
interface IShellFavoritesNameSpace : IDispatch
{
    HRESULT MoveSelectionUp();
    HRESULT MoveSelectionDown();
    HRESULT ResetSort();
    HRESULT NewFolder();
    HRESULT Synchronize();
    HRESULT Import();
    HRESULT Export();
    HRESULT InvokeContextMenuCommand(BSTR strCommand);
    HRESULT MoveSelectionTo();
    HRESULT get_SubscriptionsEnabled(VARIANT_BOOL* pBool);
    HRESULT CreateSubscriptionForSelection(VARIANT_BOOL* pBool);
    HRESULT DeleteSubscriptionForSelection(VARIANT_BOOL* pBool);
    HRESULT SetRoot(BSTR bstrFullPath);
}

@GUID("e572d3c9-37be-4ae2-825d-d521763e3108")
interface IShellNameSpace : IShellFavoritesNameSpace
{
    HRESULT get_EnumOptions(int* pgrfEnumFlags);
    HRESULT put_EnumOptions(int lVal);
    HRESULT get_SelectedItem(IDispatch* pItem);
    HRESULT put_SelectedItem(IDispatch pItem);
    HRESULT get_Root(VARIANT* pvar);
    HRESULT put_Root(VARIANT var);
    HRESULT get_Depth(int* piDepth);
    HRESULT put_Depth(int iDepth);
    HRESULT get_Mode(uint* puMode);
    HRESULT put_Mode(uint uMode);
    HRESULT get_Flags(uint* pdwFlags);
    HRESULT put_Flags(uint dwFlags);
    HRESULT put_TVFlags(uint dwFlags);
    HRESULT get_TVFlags(uint* dwFlags);
    HRESULT get_Columns(BSTR* bstrColumns);
    HRESULT put_Columns(BSTR bstrColumns);
    HRESULT get_CountViewTypes(int* piTypes);
    HRESULT SetViewType(int iType);
    HRESULT SelectedItems(IDispatch* ppid);
    HRESULT Expand(VARIANT var, int iDepth);
    HRESULT UnselectAll();
}

@GUID("f3470f24-15fd-11d2-bb2e-00805ff7efca")
interface IScriptErrorList : IDispatch
{
    HRESULT advanceError();
    HRESULT retreatError();
    HRESULT canAdvanceError(BOOL* pfCanAdvance);
    HRESULT canRetreatError(BOOL* pfCanRetreat);
    HRESULT getErrorLine(int* plLine);
    HRESULT getErrorChar(int* plChar);
    HRESULT getErrorCode(int* plCode);
    HRESULT getErrorMsg(BSTR* pstr);
    HRESULT getErrorUrl(BSTR* pstr);
    HRESULT getAlwaysShowLockState(BOOL* pfAlwaysShowLocked);
    HRESULT getDetailsPaneOpen(BOOL* pfDetailsPaneOpen);
    HRESULT setDetailsPaneOpen(BOOL fDetailsPaneOpen);
    HRESULT getPerErrorDisplay(BOOL* pfPerErrorDisplay);
    HRESULT setPerErrorDisplay(BOOL fPerErrorDisplay);
}

@GUID("9ba05970-f6a8-11cf-a442-00a0c90a8f39")
interface IFolderViewOC : IDispatch
{
    HRESULT SetFolderView(IDispatch pdisp);
}

@GUID("62112aa2-ebe4-11cf-a5fb-0020afe7292d")
interface DShellFolderViewEvents : IDispatch
{
}

@GUID("4a3df050-23bd-11d2-939f-00a0c91eedba")
interface DFConstraint : IDispatch
{
    HRESULT get_Name(BSTR* pbs);
    HRESULT get_Value(VARIANT* pv);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folderitem
@GUID("fac32c80-cbe4-11ce-8350-444553540000")
interface FolderItem : IDispatch
{
    HRESULT get_Application(IDispatch* ppid);
    HRESULT get_Parent(IDispatch* ppid);
    HRESULT get_Name(BSTR* pbs);
    HRESULT put_Name(BSTR bs);
    HRESULT get_Path(BSTR* pbs);
    HRESULT get_GetLink(IDispatch* ppid);
    HRESULT get_GetFolder(IDispatch* ppid);
    HRESULT get_IsLink(VARIANT_BOOL* pb);
    HRESULT get_IsFolder(VARIANT_BOOL* pb);
    HRESULT get_IsFileSystem(VARIANT_BOOL* pb);
    HRESULT get_IsBrowsable(VARIANT_BOOL* pb);
    HRESULT get_ModifyDate(double* pdt);
    HRESULT put_ModifyDate(double dt);
    HRESULT get_Size(int* pul);
    HRESULT get_Type(BSTR* pbs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folderitem-verbs
    HRESULT Verbs(FolderItemVerbs* ppfic);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folderitem-invokeverb
    HRESULT InvokeVerb(VARIANT vVerb);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folderitems
@GUID("744129e0-cbe5-11ce-8350-444553540000")
interface FolderItems : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get_Application(IDispatch* ppid);
    HRESULT get_Parent(IDispatch* ppid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folderitems-item
    HRESULT Item(VARIANT index, FolderItem* ppid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folderitems--newenum
    HRESULT _NewEnum(IUnknown* ppunk);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folderitemverb
@GUID("08ec3e00-50b0-11cf-960c-0080c7f4ee85")
interface FolderItemVerb : IDispatch
{
    HRESULT get_Application(IDispatch* ppid);
    HRESULT get_Parent(IDispatch* ppid);
    HRESULT get_Name(BSTR* pbs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folderitemverb-doit
    HRESULT DoIt();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folderitemverbs
@GUID("1f8352c0-50b0-11cf-960c-0080c7f4ee85")
interface FolderItemVerbs : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get_Application(IDispatch* ppid);
    HRESULT get_Parent(IDispatch* ppid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folderitemverbs-item
    HRESULT Item(VARIANT index, FolderItemVerb* ppid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folderitemverbs--newenum
    HRESULT _NewEnum(IUnknown* ppunk);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folder
@GUID("bbcbde60-c3ff-11ce-8350-444553540000")
interface Folder : IDispatch
{
    HRESULT get_Title(BSTR* pbs);
    HRESULT get_Application(IDispatch* ppid);
    HRESULT get_Parent(IDispatch* ppid);
    HRESULT get_ParentFolder(Folder* ppsf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folder-items
    HRESULT Items(FolderItems* ppid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folder-parsename
    HRESULT ParseName(BSTR bName, FolderItem* ppid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folder-newfolder
    HRESULT NewFolder(BSTR bName, VARIANT vOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folder-movehere
    HRESULT MoveHere(VARIANT vItem, VARIANT vOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folder-copyhere
    HRESULT CopyHere(VARIANT vItem, VARIANT vOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folder-getdetailsof
    HRESULT GetDetailsOf(VARIANT vItem, int iColumn, BSTR* pbs);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folder2-object
@GUID("f0d2d8ef-3890-11d2-bf8b-00c04fb93661")
interface Folder2 : Folder
{
    HRESULT get_Self(FolderItem* ppfi);
    HRESULT get_OfflineStatus(int* pul);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folder2-synchronize
    HRESULT Synchronize();
    HRESULT get_HaveToShowWebViewBarricade(VARIANT_BOOL* pbHaveToShowWebViewBarricade);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folder2-dismissedwebviewbarricade
    HRESULT DismissedWebViewBarricade();
}

@GUID("a7ae5f64-c4d7-4d7f-9307-4d24ee54b841")
interface Folder3 : Folder2
{
    HRESULT get_ShowWebViewBarricade(VARIANT_BOOL* pbShowWebViewBarricade);
    HRESULT put_ShowWebViewBarricade(VARIANT_BOOL bShowWebViewBarricade);
}

@GUID("edc817aa-92b8-11d1-b075-00c04fc33aa5")
interface FolderItem2 : FolderItem
{
    HRESULT InvokeVerbEx(VARIANT vVerb, VARIANT vArgs);
    HRESULT ExtendedProperty(BSTR bstrPropName, VARIANT* pvRet);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folderitems2-object
@GUID("c94f0ad0-f363-11d2-a327-00c04f8eec7f")
interface FolderItems2 : FolderItems
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folderitems2-invokeverbex
    HRESULT InvokeVerbEx(VARIANT vVerb, VARIANT vArgs);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folderitems3-object
@GUID("eaa7c309-bbec-49d5-821d-64d966cb667f")
interface FolderItems3 : FolderItems2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/folderitems3-filter
    HRESULT Filter(int grfFlags, BSTR bstrFileSpec);
    HRESULT get_Verbs(FolderItemVerbs* ppfic);
}

@GUID("88a05c00-f000-11ce-8350-444553540000")
interface IShellLinkDual : IDispatch
{
    HRESULT get_Path(BSTR* pbs);
    HRESULT put_Path(BSTR bs);
    HRESULT get_Description(BSTR* pbs);
    HRESULT put_Description(BSTR bs);
    HRESULT get_WorkingDirectory(BSTR* pbs);
    HRESULT put_WorkingDirectory(BSTR bs);
    HRESULT get_Arguments(BSTR* pbs);
    HRESULT put_Arguments(BSTR bs);
    HRESULT get_Hotkey(int* piHK);
    HRESULT put_Hotkey(int iHK);
    HRESULT get_ShowCommand(int* piShowCommand);
    HRESULT put_ShowCommand(int iShowCommand);
    HRESULT Resolve(int fFlags);
    HRESULT GetIconLocation(BSTR* pbs, int* piIcon);
    HRESULT SetIconLocation(BSTR bs, int iIcon);
    HRESULT Save(VARIANT vWhere);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelllinkdual2-object
@GUID("317ee249-f12e-11d2-b1e4-00c04f8eeb3e")
interface IShellLinkDual2 : IShellLinkDual
{
    HRESULT get_Target(FolderItem* ppfi);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nn-shldisp-ishellfolderviewdual
@GUID("e7a1af80-4d96-11cf-960c-0080c7f4ee85")
interface IShellFolderViewDual : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual-get_application
    HRESULT get_Application(IDispatch* ppid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual-get_parent
    HRESULT get_Parent(IDispatch* ppid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual-get_folder
    HRESULT get_Folder(Folder* ppid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual-selecteditems
    HRESULT SelectedItems(FolderItems* ppid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual-get_focuseditem
    HRESULT get_FocusedItem(FolderItem* ppid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual-selectitem
    HRESULT SelectItem(VARIANT* pvfi, int dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual-popupitemmenu
    HRESULT PopupItemMenu(FolderItem pfi, VARIANT vx, VARIANT vy, BSTR* pbs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual-get_script
    HRESULT get_Script(IDispatch* ppDisp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual-get_viewoptions
    HRESULT get_ViewOptions(int* plViewOptions);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nn-shldisp-ishellfolderviewdual2
@GUID("31c147b6-0ade-4a3c-b514-ddf932ef6d17")
interface IShellFolderViewDual2 : IShellFolderViewDual
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual2-get_currentviewmode
    HRESULT get_CurrentViewMode(uint* pViewMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual2-put_currentviewmode
    HRESULT put_CurrentViewMode(uint ViewMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual2-selectitemrelative
    HRESULT SelectItemRelative(int iRelative);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nn-shldisp-ishellfolderviewdual3
@GUID("29ec8e6c-46d3-411f-baaa-611a6c9cac66")
interface IShellFolderViewDual3 : IShellFolderViewDual2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual3-get_groupby
    HRESULT get_GroupBy(BSTR* pbstrGroupBy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual3-put_groupby
    HRESULT put_GroupBy(BSTR bstrGroupBy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual3-get_folderflags
    HRESULT get_FolderFlags(uint* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual3-put_folderflags
    HRESULT put_FolderFlags(uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual3-get_sortcolumns
    HRESULT get_SortColumns(BSTR* pbstrSortColumns);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual3-put_sortcolumns
    HRESULT put_SortColumns(BSTR bstrSortColumns);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual3-put_iconsize
    HRESULT put_IconSize(int iIconSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual3-get_iconsize
    HRESULT get_IconSize(int* piIconSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-ishellfolderviewdual3-filterview
    HRESULT FilterView(BSTR bstrFilterText);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch
@GUID("d8f015c0-c278-11ce-a49e-444553540000")
interface IShellDispatch : IDispatch
{
    HRESULT get_Application(IDispatch* ppid);
    HRESULT get_Parent(IDispatch* ppid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-namespace
    HRESULT NameSpace(VARIANT vDir, Folder* ppsdf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-browseforfolder
    HRESULT BrowseForFolder(int Hwnd, BSTR Title, int Options, VARIANT RootFolder, Folder* ppsdf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-windows
    HRESULT Windows(IDispatch* ppid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-open
    HRESULT Open(VARIANT vDir);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-explore
    HRESULT Explore(VARIANT vDir);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-minimizeall
    HRESULT MinimizeAll();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-undominimizeall
    HRESULT UndoMinimizeALL();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-filerun
    HRESULT FileRun();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-cascadewindows
    HRESULT CascadeWindows();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-tilevertically
    HRESULT TileVertically();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-tilehorizontally
    HRESULT TileHorizontally();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-shutdownwindows
    HRESULT ShutdownWindows();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-suspend
    HRESULT Suspend();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-ejectpc
    HRESULT EjectPC();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-settime
    HRESULT SetTime();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-trayproperties
    HRESULT TrayProperties();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-help
    HRESULT Help();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-findfiles
    HRESULT FindFiles();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-findcomputer
    HRESULT FindComputer();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-refreshmenu
    HRESULT RefreshMenu();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch-controlpanelitem
    HRESULT ControlPanelItem(BSTR bstrDir);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch2-object
@GUID("a4c6892c-3ba9-11d2-9dea-00c04fb16162")
interface IShellDispatch2 : IShellDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch2-isrestricted
    HRESULT IsRestricted(BSTR Group, BSTR Restriction, int* plRestrictValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch2-shellexecute
    HRESULT ShellExecute(BSTR File, VARIANT vArgs, VARIANT vDir, VARIANT vOperation, VARIANT vShow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch2-findprinter
    HRESULT FindPrinter(BSTR name, BSTR location, BSTR model);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch2-getsysteminformation
    HRESULT GetSystemInformation(BSTR name, VARIANT* pv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch2-servicestart
    HRESULT ServiceStart(BSTR ServiceName, VARIANT Persistent, VARIANT* pSuccess);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch2-servicestop
    HRESULT ServiceStop(BSTR ServiceName, VARIANT Persistent, VARIANT* pSuccess);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch2-isservicerunning
    HRESULT IsServiceRunning(BSTR ServiceName, VARIANT* pRunning);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch2-canstartstopservice
    HRESULT CanStartStopService(BSTR ServiceName, VARIANT* pCanStartStop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch2-showbrowserbar
    HRESULT ShowBrowserBar(BSTR bstrClsid, VARIANT bShow, VARIANT* pSuccess);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch3
@GUID("177160ca-bb5a-411c-841d-bd38facdeaa0")
interface IShellDispatch3 : IShellDispatch2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch3-addtorecent
    HRESULT AddToRecent(VARIANT varFile, BSTR bstrCategory);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch4
@GUID("efd84b2d-4bcf-4298-be25-eb542a59fbda")
interface IShellDispatch4 : IShellDispatch3
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch4-windowssecurity
    HRESULT WindowsSecurity();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch4-toggledesktop
    HRESULT ToggleDesktop();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch4-explorerpolicy
    HRESULT ExplorerPolicy(BSTR bstrPolicyName, VARIANT* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch4-getsetting
    HRESULT GetSetting(int lSetting, VARIANT_BOOL* pResult);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch5
@GUID("866738b9-6cf2-4de8-8767-f794ebe74f4e")
interface IShellDispatch5 : IShellDispatch4
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch5-windowswitcher
    HRESULT WindowSwitcher();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch6
@GUID("286e6f1b-7113-4355-9562-96b7e9d64c54")
interface IShellDispatch6 : IShellDispatch5
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/shell/ishelldispatch6-searchcommand
    HRESULT SearchCommand();
}

@GUID("2d91eea1-9932-11d2-be86-00a0c9a83da1")
interface IFileSearchBand : IDispatch
{
    HRESULT SetFocus();
    HRESULT SetSearchParameters(BSTR* pbstrSearchID, VARIANT_BOOL bNavToResults, VARIANT* pvarScope, 
                                VARIANT* pvarQueryFile);
    HRESULT get_SearchID(BSTR* pbstrSearchID);
    HRESULT get_Scope(VARIANT* pvarScope);
    HRESULT get_QueryFile(VARIANT* pvarFile);
}

@GUID("18bcc359-4990-4bfb-b951-3c83702be5f9")
interface IWebWizardHost : IDispatch
{
    HRESULT FinalBack();
    HRESULT FinalNext();
    HRESULT Cancel();
    HRESULT put_Caption(BSTR bstrCaption);
    HRESULT get_Caption(BSTR* pbstrCaption);
    HRESULT put_Property(BSTR bstrPropertyName, VARIANT* pvProperty);
    HRESULT get_Property(BSTR bstrPropertyName, VARIANT* pvProperty);
    HRESULT SetWizardButtons(VARIANT_BOOL vfEnableBack, VARIANT_BOOL vfEnableNext, VARIANT_BOOL vfLastPage);
    HRESULT SetHeaderText(BSTR bstrHeaderTitle, BSTR bstrHeaderSubtitle);
}

@GUID("f9c013dc-3c23-4041-8e39-cfb402f7ea59")
interface IWebWizardHost2 : IWebWizardHost
{
    HRESULT SignString(BSTR value, BSTR* signedValue);
}

@GUID("0751c551-7568-41c9-8e5b-e22e38919236")
interface INewWDEvents : IWebWizardHost
{
    HRESULT PassportAuthenticate(BSTR bstrSignInUrl, VARIANT_BOOL* pvfAuthenitcated);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nn-shldisp-iautocomplete
@GUID("00bb2762-6a77-11d0-a535-00c04fd7d062")
interface IAutoComplete : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-iautocomplete-init
    HRESULT Init(HWND hwndEdit, IUnknown punkACL, const(PWSTR) pwszRegKeyPath, const(PWSTR) pwszQuickComplete);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-iautocomplete-enable
    HRESULT Enable(BOOL fEnable);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nn-shldisp-iautocomplete2
@GUID("eac04bc0-3791-11d2-bb95-0060977b464c")
interface IAutoComplete2 : IAutoComplete
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-iautocomplete2-setoptions
    HRESULT SetOptions(uint dwFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-iautocomplete2-getoptions
    HRESULT GetOptions(uint* pdwFlag);
}

@GUID("8e74c210-cf9d-4eaf-a403-7356428f0a5a")
interface IEnumACString : IEnumString
{
    HRESULT NextItem(PWSTR pszUrl, uint cchMax, uint* pulSortIndex);
    HRESULT SetEnumOptions(uint dwOptions);
    HRESULT GetEnumOptions(uint* pdwOptions);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nn-shldisp-idataobjectasynccapability
@GUID("3d8b0590-f691-11d2-8ea9-006097df5bd4")
interface IDataObjectAsyncCapability : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-idataobjectasynccapability-setasyncmode
    HRESULT SetAsyncMode(BOOL fDoOpAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-idataobjectasynccapability-getasyncmode
    HRESULT GetAsyncMode(BOOL* pfIsOpAsync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-idataobjectasynccapability-startoperation
    HRESULT StartOperation(IBindCtx pbcReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-idataobjectasynccapability-inoperation
    HRESULT InOperation(BOOL* pfInAsyncOp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shldisp/nf-shldisp-idataobjectasynccapability-endoperation
    HRESULT EndOperation(HRESULT hResult, IBindCtx pbcReserved, uint dwEffects);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nn-shlobj_core-iextracticona
@GUID("000214eb-0000-0000-c000-000000000046")
interface IExtractIconA : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iextracticona-geticonlocation
    HRESULT GetIconLocation(uint uFlags, PSTR pszIconFile, uint cchMax, int* piIndex, uint* pwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iextracticona-extract
    HRESULT Extract(const(PSTR) pszFile, uint nIconIndex, HICON* phiconLarge, HICON* phiconSmall, uint nIconSize);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nn-shlobj_core-iextracticonw
@GUID("000214fa-0000-0000-c000-000000000046")
interface IExtractIconW : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iextracticonw-geticonlocation
    HRESULT GetIconLocation(uint uFlags, PWSTR pszIconFile, uint cchMax, int* piIndex, uint* pwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iextracticonw-extract
    HRESULT Extract(const(PWSTR) pszFile, uint nIconIndex, HICON* phiconLarge, HICON* phiconSmall, uint nIconSize);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nn-shlobj_core-ishelliconoverlaymanager
@GUID("f10b5e34-dd3b-42a7-aa7d-2f4ec54bb09b")
interface IShellIconOverlayManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishelliconoverlaymanager-getfileoverlayinfo
    HRESULT GetFileOverlayInfo(const(PWSTR) pwszPath, uint dwAttrib, int* pIndex, uint dwflags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishelliconoverlaymanager-getreservedoverlayinfo
    HRESULT GetReservedOverlayInfo(const(PWSTR) pwszPath, uint dwAttrib, int* pIndex, uint dwflags, 
                                   int iReservedID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishelliconoverlaymanager-refreshoverlayimages
    HRESULT RefreshOverlayImages(uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishelliconoverlaymanager-loadnonloadedoverlayidentifiers
    HRESULT LoadNonloadedOverlayIdentifiers();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishelliconoverlaymanager-overlayindexfromimageindex
    HRESULT OverlayIndexFromImageIndex(int iImage, int* piIndex, BOOL fAdd);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nn-shlobj_core-ishelliconoverlay
@GUID("7d688a70-c613-11d0-999b-00c04fd655e1")
interface IShellIconOverlay : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishelliconoverlay-getoverlayindex
    HRESULT GetOverlayIndex(ITEMIDLIST* pidl, int* pIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishelliconoverlay-getoverlayiconindex
    HRESULT GetOverlayIconIndex(ITEMIDLIST* pidl, int* pIconIndex);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nn-shlobj_core-iurlsearchhook
@GUID("ac60f6a0-0fd9-11d0-99cb-00c04fd64497")
interface IURLSearchHook : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iurlsearchhook-translate
    HRESULT Translate(PWSTR pwszSearchURL, uint cchBufferSize);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nn-shlobj_core-isearchcontext
@GUID("09f656a2-41af-480c-88f7-16cc0d164615")
interface ISearchContext : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-isearchcontext-getsearchurl
    HRESULT GetSearchUrl(BSTR* pbstrSearchUrl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-isearchcontext-getsearchtext
    HRESULT GetSearchText(BSTR* pbstrSearchText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-isearchcontext-getsearchstyle
    HRESULT GetSearchStyle(uint* pdwSearchStyle);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nn-shlobj_core-iurlsearchhook2
@GUID("5ee44da4-6d32-46e3-86bc-07540dedd0e0")
interface IURLSearchHook2 : IURLSearchHook
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iurlsearchhook2-translatewithsearchcontext
    HRESULT TranslateWithSearchContext(PWSTR pwszSearchURL, uint cchBufferSize, ISearchContext pSearchContext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nn-shlobj_core-ishelldetails
@GUID("000214ec-0000-0000-c000-000000000046")
interface IShellDetails : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishelldetails-getdetailsof
    HRESULT GetDetailsOf(ITEMIDLIST* pidl, uint iColumn, SHELLDETAILS* pDetails);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishelldetails-columnclick
    HRESULT ColumnClick(uint iColumn);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nn-shlobj_core-iobjmgr
@GUID("00bb2761-6a77-11d0-a535-00c04fd7d062")
interface IObjMgr : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iobjmgr-append
    HRESULT Append(IUnknown punk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iobjmgr-remove
    HRESULT Remove(IUnknown punk);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nn-shlobj_core-iaclist
@GUID("77a130b0-94fd-11d0-a544-00c04fd7d062")
interface IACList : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iaclist-expand
    HRESULT Expand(const(PWSTR) pszExpand);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nn-shlobj_core-iaclist2
@GUID("470141a0-5186-11d2-bbb6-0060977b464c")
interface IACList2 : IACList
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iaclist2-setoptions
    HRESULT SetOptions(uint dwFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iaclist2-getoptions
    HRESULT GetOptions(uint* pdwFlag);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nn-shlobj_core-iprogressdialog
@GUID("ebbc7c04-315e-11d2-b62f-006097df5bd4")
interface IProgressDialog : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iprogressdialog-startprogressdialog
    HRESULT StartProgressDialog(HWND hwndParent, IUnknown punkEnableModless, uint dwFlags, 
                                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(void)* pvResevered);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iprogressdialog-stopprogressdialog
    HRESULT StopProgressDialog();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iprogressdialog-settitle
    HRESULT SetTitle(const(PWSTR) pwzTitle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iprogressdialog-setanimation
    HRESULT SetAnimation(HINSTANCE hInstAnimation, uint idAnimation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iprogressdialog-hasusercancelled
    BOOL    HasUserCancelled();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iprogressdialog-setprogress
    HRESULT SetProgress(uint dwCompleted, uint dwTotal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iprogressdialog-setprogress64
    HRESULT SetProgress64(ulong ullCompleted, ulong ullTotal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iprogressdialog-setline
    HRESULT SetLine(uint dwLineNum, const(PWSTR) pwzString, BOOL fCompactPath, 
                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(void)* pvResevered);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iprogressdialog-setcancelmsg
    HRESULT SetCancelMsg(const(PWSTR) pwzCancelMsg, 
                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(void)* pvResevered);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iprogressdialog-timer
    HRESULT Timer(uint dwTimerAction, 
                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(void)* pvResevered);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nn-shlobj_core-idockingwindowsite
@GUID("2a342fc2-7b26-11d0-8ca9-00a0c92dbfe8")
interface IDockingWindowSite : IOleWindow
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-idockingwindowsite-getborderdw
    HRESULT GetBorderDW(IUnknown punkObj, RECT* prcBorder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-idockingwindowsite-requestborderspacedw
    HRESULT RequestBorderSpaceDW(IUnknown punkObj, RECT* pbw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-idockingwindowsite-setborderspacedw
    HRESULT SetBorderSpaceDW(IUnknown punkObj, RECT* pbw);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nn-shlobj_core-ishellchangenotify
@GUID("d82be2b1-5764-11d0-a96e-00c04fd705a2")
interface IShellChangeNotify : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellchangenotify-onchange
    HRESULT OnChange(int lEvent, ITEMIDLIST* pidl1, ITEMIDLIST* pidl2);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nn-shlobj_core-iqueryinfo
@GUID("00021500-0000-0000-c000-000000000046")
interface IQueryInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iqueryinfo-getinfotip
    HRESULT GetInfoTip(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(QITIPF_FLAGS))], [])*/uint dwFlags, 
                       PWSTR* ppwszTip);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-iqueryinfo-getinfoflags
    HRESULT GetInfoFlags(uint* pdwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nn-shlobj_core-ishellfolderviewcb
@GUID("2047e320-f2a9-11ce-ae65-08002b2e1262")
interface IShellFolderViewCB : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderviewcb-messagesfvcb
    HRESULT MessageSFVCB(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(SFVM_MESSAGE_ID))], [])*/uint uMsg, 
                         WPARAM wParam, LPARAM lParam);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nn-shlobj_core-ishellfolderview
@GUID("37a378c0-f82d-11ce-ae65-08002b2e1262")
interface IShellFolderView : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-rearrange
    HRESULT Rearrange(LPARAM lParamSort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-getarrangeparam
    HRESULT GetArrangeParam(LPARAM* plParamSort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-arrangegrid
    HRESULT ArrangeGrid();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-autoarrange
    HRESULT AutoArrange();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-getautoarrange
    HRESULT GetAutoArrange();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-addobject
    HRESULT AddObject(ITEMIDLIST* pidl, uint* puItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-getobject
    HRESULT GetObject(ITEMIDLIST** ppidl, uint uItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-removeobject
    HRESULT RemoveObject(ITEMIDLIST* pidl, uint* puItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-getobjectcount
    HRESULT GetObjectCount(uint* puCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-setobjectcount
    HRESULT SetObjectCount(uint uCount, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-updateobject
    HRESULT UpdateObject(ITEMIDLIST* pidlOld, ITEMIDLIST* pidlNew, uint* puItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-refreshobject
    HRESULT RefreshObject(ITEMIDLIST* pidl, uint* puItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-setredraw
    HRESULT SetRedraw(BOOL bRedraw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-getselectedcount
    HRESULT GetSelectedCount(uint* puSelected);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-getselectedobjects
    HRESULT GetSelectedObjects(ITEMIDLIST*** pppidl, uint* puItems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-isdroponsource
    HRESULT IsDropOnSource(IDropTarget pDropTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-getdragpoint
    HRESULT GetDragPoint(POINT* ppt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-getdroppoint
    HRESULT GetDropPoint(POINT* ppt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-moveicons
    HRESULT MoveIcons(IDataObject pDataObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-setitempos
    HRESULT SetItemPos(ITEMIDLIST* pidl, POINT* ppt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-isbkdroptarget
    HRESULT IsBkDropTarget(IDropTarget pDropTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-setclipboard
    HRESULT SetClipboard(BOOL bMove);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-setpoints
    HRESULT SetPoints(IDataObject pDataObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-getitemspacing
    HRESULT GetItemSpacing(ITEMSPACING* pSpacing);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-setcallback
    HRESULT SetCallback(IShellFolderViewCB pNewCB, IShellFolderViewCB* ppOldCB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-select
    HRESULT Select(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(SFVS_SELECT))], [])*/uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-querysupport
    HRESULT QuerySupport(uint* pdwSupport);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-ishellfolderview-setautomationobject
    HRESULT SetAutomationObject(IDispatch pdisp);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nn-shlobj_core-inamedpropertybag
@GUID("fb700430-952c-11d1-946f-000000000000")
interface INamedPropertyBag : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-inamedpropertybag-readpropertynpb
    HRESULT ReadPropertyNPB(const(PWSTR) pszBagname, const(PWSTR) pszPropName, PROPVARIANT* pVar);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-inamedpropertybag-writepropertynpb
    HRESULT WritePropertyNPB(const(PWSTR) pszBagname, const(PWSTR) pszPropName, PROPVARIANT* pVar);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-inamedpropertybag-removepropertynpb
    HRESULT RemovePropertyNPB(const(PWSTR) pszBagname, const(PWSTR) pszPropName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nn-shlobj-inewshortcuthooka
@GUID("000214e1-0000-0000-c000-000000000046")
interface INewShortcutHookA : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-inewshortcuthooka-setreferent
    HRESULT SetReferent(const(PSTR) pcszReferent, HWND hwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-inewshortcuthooka-getreferent
    HRESULT GetReferent(PSTR pszReferent, int cchReferent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-inewshortcuthooka-setfolder
    HRESULT SetFolder(const(PSTR) pcszFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-inewshortcuthooka-getfolder
    HRESULT GetFolder(PSTR pszFolder, int cchFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-inewshortcuthooka-getname
    HRESULT GetName(PSTR pszName, int cchName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-inewshortcuthooka-getextension
    HRESULT GetExtension(PSTR pszExtension, int cchExtension);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nn-shlobj-inewshortcuthookw
@GUID("000214f7-0000-0000-c000-000000000046")
interface INewShortcutHookW : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-inewshortcuthookw-setreferent
    HRESULT SetReferent(const(PWSTR) pcszReferent, HWND hwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-inewshortcuthookw-getreferent
    HRESULT GetReferent(PWSTR pszReferent, int cchReferent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-inewshortcuthookw-setfolder
    HRESULT SetFolder(const(PWSTR) pcszFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-inewshortcuthookw-getfolder
    HRESULT GetFolder(PWSTR pszFolder, int cchFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-inewshortcuthookw-getname
    HRESULT GetName(PWSTR pszName, int cchName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-inewshortcuthookw-getextension
    HRESULT GetExtension(PWSTR pszExtension, int cchExtension);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nn-shlobj-icopyhooka
@GUID("000214ef-0000-0000-c000-000000000046")
interface ICopyHookA : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-icopyhooka-copycallback
    uint CopyCallback(HWND hwnd, uint wFunc, uint wFlags, const(PSTR) pszSrcFile, uint dwSrcAttribs, 
                      const(PSTR) pszDestFile, uint dwDestAttribs);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nn-shlobj-icopyhookw
@GUID("000214fc-0000-0000-c000-000000000046")
interface ICopyHookW : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-icopyhookw-copycallback
    uint CopyCallback(HWND hwnd, uint wFunc, uint wFlags, const(PWSTR) pszSrcFile, uint dwSrcAttribs, 
                      const(PWSTR) pszDestFile, uint dwDestAttribs);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nn-shlobj-icurrentworkingdirectory
@GUID("91956d21-9276-11d1-921a-006097df5bd4")
interface ICurrentWorkingDirectory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-icurrentworkingdirectory-getdirectory
    HRESULT GetDirectory(PWSTR pwzPath, uint cchSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-icurrentworkingdirectory-setdirectory
    HRESULT SetDirectory(const(PWSTR) pwzPath);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nn-shlobj-idockingwindowframe
@GUID("47d2657a-7b27-11d0-8ca9-00a0c92dbfe8")
interface IDockingWindowFrame : IOleWindow
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-idockingwindowframe-addtoolbar
    HRESULT AddToolbar(IUnknown punkSrc, const(PWSTR) pwszItem, uint dwAddFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-idockingwindowframe-removetoolbar
    HRESULT RemoveToolbar(IUnknown punkSrc, uint dwRemoveFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-idockingwindowframe-findtoolbar
    HRESULT FindToolbar(const(PWSTR) pwszItem, const(GUID)* riid, void** ppv);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nn-shlobj-ithumbnailcapture
@GUID("4ea39266-7211-409f-b622-f63dbd16c533")
interface IThumbnailCapture : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-ithumbnailcapture-capturethumbnail
    HRESULT CaptureThumbnail(const(SIZE)* pMaxSize, IUnknown pHTMLDoc2, HBITMAP* phbmThumbnail);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nn-shlobj-ishellfolderband
@GUID("7fe80cc8-c247-11d0-b93a-00a0c90312e1")
interface IShellFolderBand : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-ishellfolderband-initializesfb
    HRESULT InitializeSFB(IShellFolder psf, ITEMIDLIST* pidl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-ishellfolderband-setbandinfosfb
    HRESULT SetBandInfoSFB(BANDINFOSFB* pbi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-ishellfolderband-getbandinfosfb
    HRESULT GetBandInfoSFB(BANDINFOSFB* pbi);
}

@GUID("eb0fe175-1a3a-11d0-89b3-00a0c90a90ac")
interface IDeskBarClient : IOleWindow
{
    HRESULT SetDeskBarSite(IUnknown punkSite);
    HRESULT SetModeDBC(uint dwMode);
    HRESULT UIActivateDBC(uint dwState);
    HRESULT GetSize(uint dwWhich, RECT* prc);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nn-shlobj-icolumnprovider
@GUID("e8025004-1c42-11d2-be2c-00a0c9a83da1")
interface IColumnProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-icolumnprovider-initialize
    HRESULT Initialize(SHCOLUMNINIT* psci);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-icolumnprovider-getcolumninfo
    HRESULT GetColumnInfo(uint dwIndex, SHCOLUMNINFO* psci);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-icolumnprovider-getitemdata
    HRESULT GetItemData(PROPERTYKEY* pscid, SHCOLUMNDATA* pscd, VARIANT* pvarData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nn-shlobj-idocviewsite
@GUID("87d605e0-c511-11cf-89a9-00a0c9054129")
interface IDocViewSite : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlobj/nf-shlobj-idocviewsite-onsettitle
    HRESULT OnSetTitle(VARIANT* pvTitle);
}

@GUID("4622ad16-ff23-11d0-8d34-00a0c90f2719")
interface IInitializeObject : IUnknown
{
    HRESULT Initialize();
}

@GUID("596a9a94-013e-11d1-8d34-00a0c90f2719")
interface IBanneredBar : IUnknown
{
    HRESULT SetIconSize(uint iIcon);
    HRESULT GetIconSize(uint* piIcon);
    HRESULT SetBitmap(HBITMAP hBitmap);
    HRESULT GetBitmap(HBITMAP* phBitmap);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlwapi/nn-shlwapi-iqueryassociations
@GUID("c46ca590-3c3f-11d2-bee6-0000f805ca57")
interface IQueryAssociations : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlwapi/nf-shlwapi-iqueryassociations-init
    HRESULT Init(ASSOCF flags, const(PWSTR) pszAssoc, HKEY hkProgid, HWND hwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlwapi/nf-shlwapi-iqueryassociations-getstring
    HRESULT GetString(ASSOCF flags, ASSOCSTR str, const(PWSTR) pszExtra, PWSTR pszOut, uint* pcchOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlwapi/nf-shlwapi-iqueryassociations-getkey
    HRESULT GetKey(ASSOCF flags, ASSOCKEY key, const(PWSTR) pszExtra, HKEY* phkeyOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlwapi/nf-shlwapi-iqueryassociations-getdata
    HRESULT GetData(ASSOCF flags, ASSOCDATA data, const(PWSTR) pszExtra, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvOut, 
                    uint* pcbOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shlwapi/nf-shlwapi-iqueryassociations-getenum
    HRESULT GetEnum(ASSOCF flags, ASSOCENUM assocenum, const(PWSTR) pszExtra, const(GUID)* riid, void** ppvOut);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/nn-shappmgr-ishellapp
@GUID("a3e14960-935f-11d1-b8b8-006008059382")
interface IShellApp : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/nf-shappmgr-ishellapp-getappinfo
    HRESULT GetAppInfo(APPINFODATA* pai);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/nf-shappmgr-ishellapp-getpossibleactions
    HRESULT GetPossibleActions(uint* pdwActions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/nf-shappmgr-ishellapp-getslowappinfo
    HRESULT GetSlowAppInfo(SLOWAPPINFO* psaid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/nf-shappmgr-ishellapp-getcachedslowappinfo
    HRESULT GetCachedSlowAppInfo(SLOWAPPINFO* psaid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/nf-shappmgr-ishellapp-isinstalled
    HRESULT IsInstalled();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/nn-shappmgr-ipublishedapp
@GUID("1bc752e0-9046-11d1-b8b3-006008059382")
interface IPublishedApp : IShellApp
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/nf-shappmgr-ipublishedapp-install
    HRESULT Install(SYSTEMTIME* pstInstall);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/nf-shappmgr-ipublishedapp-getpublishedappinfo
    HRESULT GetPublishedAppInfo(PUBAPPINFO* ppai);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/nf-shappmgr-ipublishedapp-unschedule
    HRESULT Unschedule();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/nn-shappmgr-ipublishedapp2
@GUID("12b81347-1b3a-4a04-aa61-3f768b67fd7e")
interface IPublishedApp2 : IPublishedApp
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/nf-shappmgr-ipublishedapp2-install2
    HRESULT Install2(SYSTEMTIME* pstInstall, HWND hwndParent);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/nn-shappmgr-ienumpublishedapps
@GUID("0b124f8c-91f0-11d1-b8b5-006008059382")
interface IEnumPublishedApps : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/nf-shappmgr-ienumpublishedapps-next
    HRESULT Next(IPublishedApp* pia);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/nf-shappmgr-ienumpublishedapps-reset
    HRESULT Reset();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/nn-shappmgr-iapppublisher
@GUID("07250a10-9cf9-11d1-9076-006008059382")
interface IAppPublisher : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/nf-shappmgr-iapppublisher-getnumberofcategories
    HRESULT GetNumberOfCategories(uint* pdwCat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/nf-shappmgr-iapppublisher-getcategories
    HRESULT GetCategories(APPCATEGORYINFOLIST* pAppCategoryList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/nf-shappmgr-iapppublisher-getnumberofapps
    HRESULT GetNumberOfApps(uint* pdwApps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shappmgr/nf-shappmgr-iapppublisher-enumapps
    HRESULT EnumApps(GUID* pAppCategoryId, IEnumPublishedApps* ppepa);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nn-credentialprovider-icredentialprovidercredential
@GUID("63913a93-40c1-481a-818d-4072ff8c70cc")
interface ICredentialProviderCredential : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredential-advise
    HRESULT Advise(ICredentialProviderCredentialEvents pcpce);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredential-unadvise
    HRESULT UnAdvise();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredential-setselected
    HRESULT SetSelected(BOOL* pbAutoLogon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredential-setdeselected
    HRESULT SetDeselected();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredential-getfieldstate
    HRESULT GetFieldState(uint dwFieldID, CREDENTIAL_PROVIDER_FIELD_STATE* pcpfs, 
                          CREDENTIAL_PROVIDER_FIELD_INTERACTIVE_STATE* pcpfis);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredential-getstringvalue
    HRESULT GetStringValue(uint dwFieldID, PWSTR* ppsz);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredential-getbitmapvalue
    HRESULT GetBitmapValue(uint dwFieldID, HBITMAP* phbmp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredential-getcheckboxvalue
    HRESULT GetCheckboxValue(uint dwFieldID, BOOL* pbChecked, PWSTR* ppszLabel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredential-getsubmitbuttonvalue
    HRESULT GetSubmitButtonValue(uint dwFieldID, uint* pdwAdjacentTo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredential-getcomboboxvaluecount
    HRESULT GetComboBoxValueCount(uint dwFieldID, uint* pcItems, uint* pdwSelectedItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredential-getcomboboxvalueat
    HRESULT GetComboBoxValueAt(uint dwFieldID, uint dwItem, PWSTR* ppszItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredential-setstringvalue
    HRESULT SetStringValue(uint dwFieldID, const(PWSTR) psz);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredential-setcheckboxvalue
    HRESULT SetCheckboxValue(uint dwFieldID, BOOL bChecked);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredential-setcomboboxselectedvalue
    HRESULT SetComboBoxSelectedValue(uint dwFieldID, uint dwSelectedItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredential-commandlinkclicked
    HRESULT CommandLinkClicked(uint dwFieldID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredential-getserialization
    HRESULT GetSerialization(CREDENTIAL_PROVIDER_GET_SERIALIZATION_RESPONSE* pcpgsr, 
                             CREDENTIAL_PROVIDER_CREDENTIAL_SERIALIZATION* pcpcs, PWSTR* ppszOptionalStatusText, 
                             CREDENTIAL_PROVIDER_STATUS_ICON* pcpsiOptionalStatusIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredential-reportresult
    HRESULT ReportResult(NTSTATUS ntsStatus, NTSTATUS ntsSubstatus, PWSTR* ppszOptionalStatusText, 
                         CREDENTIAL_PROVIDER_STATUS_ICON* pcpsiOptionalStatusIcon);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nn-credentialprovider-iquerycontinuewithstatus
@GUID("9090be5b-502b-41fb-bccc-0049a6c7254b")
interface IQueryContinueWithStatus : IQueryContinue
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-iquerycontinuewithstatus-setstatusmessage
    HRESULT SetStatusMessage(const(PWSTR) psz);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nn-credentialprovider-iconnectablecredentialprovidercredential
@GUID("9387928b-ac75-4bf9-8ab2-2b93c4a55290")
interface IConnectableCredentialProviderCredential : ICredentialProviderCredential
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-iconnectablecredentialprovidercredential-connect
    HRESULT Connect(IQueryContinueWithStatus pqcws);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-iconnectablecredentialprovidercredential-disconnect
    HRESULT Disconnect();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nn-credentialprovider-icredentialprovidercredentialevents
@GUID("fa6fa76b-66b7-4b11-95f1-86171118e816")
interface ICredentialProviderCredentialEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredentialevents-setfieldstate
    HRESULT SetFieldState(ICredentialProviderCredential pcpc, uint dwFieldID, CREDENTIAL_PROVIDER_FIELD_STATE cpfs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredentialevents-setfieldinteractivestate
    HRESULT SetFieldInteractiveState(ICredentialProviderCredential pcpc, uint dwFieldID, 
                                     CREDENTIAL_PROVIDER_FIELD_INTERACTIVE_STATE cpfis);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredentialevents-setfieldstring
    HRESULT SetFieldString(ICredentialProviderCredential pcpc, uint dwFieldID, const(PWSTR) psz);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredentialevents-setfieldcheckbox
    HRESULT SetFieldCheckbox(ICredentialProviderCredential pcpc, uint dwFieldID, BOOL bChecked, 
                             const(PWSTR) pszLabel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredentialevents-setfieldbitmap
    HRESULT SetFieldBitmap(ICredentialProviderCredential pcpc, uint dwFieldID, HBITMAP hbmp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredentialevents-setfieldcomboboxselecteditem
    HRESULT SetFieldComboBoxSelectedItem(ICredentialProviderCredential pcpc, uint dwFieldID, uint dwSelectedItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredentialevents-deletefieldcomboboxitem
    HRESULT DeleteFieldComboBoxItem(ICredentialProviderCredential pcpc, uint dwFieldID, uint dwItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredentialevents-appendfieldcomboboxitem
    HRESULT AppendFieldComboBoxItem(ICredentialProviderCredential pcpc, uint dwFieldID, const(PWSTR) pszItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredentialevents-setfieldsubmitbutton
    HRESULT SetFieldSubmitButton(ICredentialProviderCredential pcpc, uint dwFieldID, uint dwAdjacentTo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredentialevents-oncreatingwindow
    HRESULT OnCreatingWindow(HWND* phwndOwner);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nn-credentialprovider-icredentialprovider
@GUID("d27c3481-5a1c-45b2-8aaa-c20ebbe8229e")
interface ICredentialProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovider-setusagescenario
    HRESULT SetUsageScenario(CREDENTIAL_PROVIDER_USAGE_SCENARIO cpus, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovider-setserialization
    HRESULT SetSerialization(const(CREDENTIAL_PROVIDER_CREDENTIAL_SERIALIZATION)* pcpcs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovider-advise
    HRESULT Advise(ICredentialProviderEvents pcpe, size_t upAdviseContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovider-unadvise
    HRESULT UnAdvise();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovider-getfielddescriptorcount
    HRESULT GetFieldDescriptorCount(uint* pdwCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovider-getfielddescriptorat
    HRESULT GetFieldDescriptorAt(uint dwIndex, CREDENTIAL_PROVIDER_FIELD_DESCRIPTOR** ppcpfd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovider-getcredentialcount
    HRESULT GetCredentialCount(uint* pdwCount, uint* pdwDefault, BOOL* pbAutoLogonWithDefault);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovider-getcredentialat
    HRESULT GetCredentialAt(uint dwIndex, ICredentialProviderCredential* ppcpc);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nn-credentialprovider-icredentialproviderevents
@GUID("34201e5a-a787-41a3-a5a4-bd6dcf2a854e")
interface ICredentialProviderEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialproviderevents-credentialschanged
    HRESULT CredentialsChanged(size_t upAdviseContext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nn-credentialprovider-icredentialproviderfilter
@GUID("a5da53f9-d475-4080-a120-910c4a739880")
interface ICredentialProviderFilter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialproviderfilter-filter
    HRESULT Filter(CREDENTIAL_PROVIDER_USAGE_SCENARIO cpus, uint dwFlags, GUID* rgclsidProviders, BOOL* rgbAllow, 
                   uint cProviders);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialproviderfilter-updateremotecredential
    HRESULT UpdateRemoteCredential(const(CREDENTIAL_PROVIDER_CREDENTIAL_SERIALIZATION)* pcpcsIn, 
                                   CREDENTIAL_PROVIDER_CREDENTIAL_SERIALIZATION* pcpcsOut);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nn-credentialprovider-icredentialprovidercredential2
@GUID("fd672c54-40ea-4d6e-9b49-cfb1a7507bd7")
interface ICredentialProviderCredential2 : ICredentialProviderCredential
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredential2-getusersid
    HRESULT GetUserSid(PWSTR* sid);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nn-credentialprovider-icredentialprovidercredentialwithfieldoptions
@GUID("dbc6fb30-c843-49e3-a645-573e6f39446a")
interface ICredentialProviderCredentialWithFieldOptions : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredentialwithfieldoptions-getfieldoptions
    HRESULT GetFieldOptions(uint fieldID, CREDENTIAL_PROVIDER_CREDENTIAL_FIELD_OPTIONS* options);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nn-credentialprovider-icredentialprovidercredentialevents2
@GUID("b53c00b6-9922-4b78-b1f4-ddfe774dc39b")
interface ICredentialProviderCredentialEvents2 : ICredentialProviderCredentialEvents
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredentialevents2-beginfieldupdates
    HRESULT BeginFieldUpdates();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredentialevents2-endfieldupdates
    HRESULT EndFieldUpdates();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidercredentialevents2-setfieldoptions
    HRESULT SetFieldOptions(ICredentialProviderCredential credential, uint fieldID, 
                            CREDENTIAL_PROVIDER_CREDENTIAL_FIELD_OPTIONS options);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nn-credentialprovider-icredentialprovideruser
@GUID("13793285-3ea6-40fd-b420-15f47da41fbb")
interface ICredentialProviderUser : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovideruser-getsid
    HRESULT GetSid(PWSTR* sid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovideruser-getproviderid
    HRESULT GetProviderID(GUID* providerID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovideruser-getstringvalue
    HRESULT GetStringValue(const(PROPERTYKEY)* key, PWSTR* stringValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovideruser-getvalue
    HRESULT GetValue(const(PROPERTYKEY)* key, PROPVARIANT* value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nn-credentialprovider-icredentialprovideruserarray
@GUID("90c119ae-0f18-4520-a1f1-114366a40fe8")
interface ICredentialProviderUserArray : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovideruserarray-setproviderfilter
    HRESULT SetProviderFilter(const(GUID)* guidProviderToFilterTo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovideruserarray-getaccountoptions
    HRESULT GetAccountOptions(CREDENTIAL_PROVIDER_ACCOUNT_OPTIONS* credentialProviderAccountOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovideruserarray-getcount
    HRESULT GetCount(uint* userCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovideruserarray-getat
    HRESULT GetAt(uint userIndex, ICredentialProviderUser* user);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nn-credentialprovider-icredentialprovidersetuserarray
@GUID("095c1484-1c0c-4388-9c6d-500e61bf84bd")
interface ICredentialProviderSetUserArray : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/credentialprovider/nf-credentialprovider-icredentialprovidersetuserarray-setuserarray
    HRESULT SetUserArray(ICredentialProviderUserArray users);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgrhandlercollection
@GUID("a7f337a3-d20b-45cb-9ed7-87d094ca5045")
interface ISyncMgrHandlerCollection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrhandlercollection-gethandlerenumerator
    HRESULT GetHandlerEnumerator(IEnumString* ppenum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrhandlercollection-bindtohandler
    HRESULT BindToHandler(const(PWSTR) pszHandlerID, const(GUID)* riid, void** ppv);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgrhandler
@GUID("04ec2e43-ac77-49f9-9b98-0307ef7a72a2")
interface ISyncMgrHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrhandler-getname
    HRESULT GetName(PWSTR* ppszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrhandler-gethandlerinfo
    HRESULT GetHandlerInfo(ISyncMgrHandlerInfo* ppHandlerInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrhandler-getobject
    HRESULT GetObject(const(GUID)* rguidObjectID, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrhandler-getcapabilities
    HRESULT GetCapabilities(SYNCMGR_HANDLER_CAPABILITIES* pmCapabilities);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrhandler-getpolicies
    HRESULT GetPolicies(SYNCMGR_HANDLER_POLICIES* pmPolicies);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrhandler-activate
    HRESULT Activate(BOOL fActivate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrhandler-enable
    HRESULT Enable(BOOL fEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrhandler-synchronize
    HRESULT Synchronize(const(PWSTR)* ppszItemIDs, uint cItems, HWND hwndOwner, 
                        ISyncMgrSessionCreator pSessionCreator, IUnknown punk);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgrhandlerinfo
@GUID("4ff1d798-ecf7-4524-aa81-1e362a0aef3a")
interface ISyncMgrHandlerInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrhandlerinfo-gettype
    HRESULT GetType(SYNCMGR_HANDLER_TYPE* pnType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrhandlerinfo-gettypelabel
    HRESULT GetTypeLabel(PWSTR* ppszTypeLabel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrhandlerinfo-getcomment
    HRESULT GetComment(PWSTR* ppszComment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrhandlerinfo-getlastsynctime
    HRESULT GetLastSyncTime(FILETIME* pftLastSync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrhandlerinfo-isactive
    HRESULT IsActive();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrhandlerinfo-isenabled
    HRESULT IsEnabled();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrhandlerinfo-isconnected
    HRESULT IsConnected();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgrsyncitemcontainer
@GUID("90701133-be32-4129-a65c-99e616cafff4")
interface ISyncMgrSyncItemContainer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsyncitemcontainer-getsyncitem
    HRESULT GetSyncItem(const(PWSTR) pszItemID, ISyncMgrSyncItem* ppItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsyncitemcontainer-getsyncitemenumerator
    HRESULT GetSyncItemEnumerator(IEnumSyncMgrSyncItems* ppenum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsyncitemcontainer-getsyncitemcount
    HRESULT GetSyncItemCount(uint* pcItems);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgrsyncitem
@GUID("b20b24ce-2593-4f04-bd8b-7ad6c45051cd")
interface ISyncMgrSyncItem : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsyncitem-getitemid
    HRESULT GetItemID(PWSTR* ppszItemID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsyncitem-getname
    HRESULT GetName(PWSTR* ppszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsyncitem-getiteminfo
    HRESULT GetItemInfo(ISyncMgrSyncItemInfo* ppItemInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsyncitem-getobject
    HRESULT GetObject(const(GUID)* rguidObjectID, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsyncitem-getcapabilities
    HRESULT GetCapabilities(SYNCMGR_ITEM_CAPABILITIES* pmCapabilities);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsyncitem-getpolicies
    HRESULT GetPolicies(SYNCMGR_ITEM_POLICIES* pmPolicies);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsyncitem-enable
    HRESULT Enable(BOOL fEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsyncitem-delete
    HRESULT Delete();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgrsynciteminfo
@GUID("e7fd9502-be0c-4464-90a1-2b5277031232")
interface ISyncMgrSyncItemInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsynciteminfo-gettypelabel
    HRESULT GetTypeLabel(PWSTR* ppszTypeLabel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsynciteminfo-getcomment
    HRESULT GetComment(PWSTR* ppszComment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsynciteminfo-getlastsynctime
    HRESULT GetLastSyncTime(FILETIME* pftLastSync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsynciteminfo-isenabled
    HRESULT IsEnabled();
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT IsConnected();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-ienumsyncmgrsyncitems
@GUID("54b3abf3-f085-4181-b546-e29c403c726b")
interface IEnumSyncMgrSyncItems : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-ienumsyncmgrsyncitems-next
    HRESULT Next(uint celt, ISyncMgrSyncItem* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-ienumsyncmgrsyncitems-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-ienumsyncmgrsyncitems-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-ienumsyncmgrsyncitems-clone
    HRESULT Clone(IEnumSyncMgrSyncItems* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgrsessioncreator
@GUID("17f48517-f305-4321-a08d-b25a834918fd")
interface ISyncMgrSessionCreator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsessioncreator-createsession
    HRESULT CreateSession(const(PWSTR) pszHandlerID, const(PWSTR)* ppszItemIDs, uint cItems, 
                          ISyncMgrSyncCallback* ppCallback);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgrsynccallback
@GUID("884ccd87-b139-4937-a4ba-4f8e19513fbe")
interface ISyncMgrSyncCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsynccallback-reportprogress
    HRESULT ReportProgress(const(PWSTR) pszItemID, const(PWSTR) pszProgressText, SYNCMGR_PROGRESS_STATUS nStatus, 
                           uint uCurrentStep, uint uMaxStep, SYNCMGR_CANCEL_REQUEST* pnCancelRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsynccallback-sethandlerprogresstext
    HRESULT SetHandlerProgressText(const(PWSTR) pszProgressText, SYNCMGR_CANCEL_REQUEST* pnCancelRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsynccallback-reportevent
    HRESULT ReportEvent(const(PWSTR) pszItemID, SYNCMGR_EVENT_LEVEL nLevel, SYNCMGR_EVENT_FLAGS nFlags, 
                        const(PWSTR) pszName, const(PWSTR) pszDescription, const(PWSTR) pszLinkText, 
                        const(PWSTR) pszLinkReference, const(PWSTR) pszContext, GUID* pguidEventID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsynccallback-cancontinue
    HRESULT CanContinue(const(PWSTR) pszItemID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsynccallback-queryforadditionalitems
    HRESULT QueryForAdditionalItems(IEnumString* ppenumItemIDs, IEnumUnknown* ppenumPunks);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsynccallback-additemtosession
    HRESULT AddItemToSession(const(PWSTR) pszItemID);
    HRESULT AddIUnknownToSession(IUnknown punk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsynccallback-proposeitem
    HRESULT ProposeItem(ISyncMgrSyncItem pNewItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsynccallback-commititem
    HRESULT CommitItem(const(PWSTR) pszItemID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsynccallback-reportmanualsync
    HRESULT ReportManualSync();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgruioperation
@GUID("fc7cfa47-dfe1-45b5-a049-8cfd82bec271")
interface ISyncMgrUIOperation : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Run(HWND hwndOwner);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgreventlinkuioperation
@GUID("64522e52-848b-4015-89ce-5a36f00b94ff")
interface ISyncMgrEventLinkUIOperation : ISyncMgrUIOperation
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgreventlinkuioperation-init
    HRESULT Init(const(GUID)* rguidEventID, ISyncMgrEvent pEvent);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgrschedulewizarduioperation
@GUID("459a6c84-21d2-4ddc-8a53-f023a46066f2")
interface ISyncMgrScheduleWizardUIOperation : ISyncMgrUIOperation
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrschedulewizarduioperation-initwizard
    HRESULT InitWizard(const(PWSTR) pszHandlerID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgrsyncresult
@GUID("2b90f17e-5a3e-4b33-bb7f-1bc48056b94d")
interface ISyncMgrSyncResult : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrsyncresult-result
    HRESULT Result(SYNCMGR_PROGRESS_STATUS nStatus, uint cError, uint cConflicts);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgrcontrol
@GUID("9b63616c-36b2-46bc-959f-c1593952d19b")
interface ISyncMgrControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrcontrol-starthandlersync
    HRESULT StartHandlerSync(const(PWSTR) pszHandlerID, HWND hwndOwner, IUnknown punk, 
                             SYNCMGR_SYNC_CONTROL_FLAGS nSyncControlFlags, ISyncMgrSyncResult pResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrcontrol-startitemsync
    HRESULT StartItemSync(const(PWSTR) pszHandlerID, const(PWSTR)* ppszItemIDs, uint cItems, HWND hwndOwner, 
                          IUnknown punk, SYNCMGR_SYNC_CONTROL_FLAGS nSyncControlFlags, ISyncMgrSyncResult pResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrcontrol-startsyncall
    HRESULT StartSyncAll(HWND hwndOwner);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrcontrol-stophandlersync
    HRESULT StopHandlerSync(const(PWSTR) pszHandlerID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrcontrol-stopitemsync
    HRESULT StopItemSync(const(PWSTR) pszHandlerID, const(PWSTR)* ppszItemIDs, uint cItems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrcontrol-stopsyncall
    HRESULT StopSyncAll();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrcontrol-updatehandlercollection
    HRESULT UpdateHandlerCollection(const(GUID)* rclsidCollectionID, SYNCMGR_CONTROL_FLAGS nControlFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrcontrol-updatehandler
    HRESULT UpdateHandler(const(PWSTR) pszHandlerID, SYNCMGR_CONTROL_FLAGS nControlFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrcontrol-updateitem
    HRESULT UpdateItem(const(PWSTR) pszHandlerID, const(PWSTR) pszItemID, SYNCMGR_CONTROL_FLAGS nControlFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrcontrol-updateevents
    HRESULT UpdateEvents(const(PWSTR) pszHandlerID, const(PWSTR) pszItemID, SYNCMGR_CONTROL_FLAGS nControlFlags);
    HRESULT UpdateConflict(const(PWSTR) pszHandlerID, const(PWSTR) pszItemID, ISyncMgrConflict pConflict, 
                           SYNCMGR_UPDATE_REASON nReason);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrcontrol-updateconflicts
    HRESULT UpdateConflicts(const(PWSTR) pszHandlerID, const(PWSTR) pszItemID, SYNCMGR_CONTROL_FLAGS nControlFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrcontrol-activatehandler
    HRESULT ActivateHandler(BOOL fActivate, const(PWSTR) pszHandlerID, HWND hwndOwner, 
                            SYNCMGR_CONTROL_FLAGS nControlFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrcontrol-enablehandler
    HRESULT EnableHandler(BOOL fEnable, const(PWSTR) pszHandlerID, HWND hwndOwner, 
                          SYNCMGR_CONTROL_FLAGS nControlFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrcontrol-enableitem
    HRESULT EnableItem(BOOL fEnable, const(PWSTR) pszHandlerID, const(PWSTR) pszItemID, HWND hwndOwner, 
                       SYNCMGR_CONTROL_FLAGS nControlFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgreventstore
@GUID("37e412f9-016e-44c2-81ff-db3add774266")
interface ISyncMgrEventStore : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgreventstore-geteventenumerator
    HRESULT GetEventEnumerator(IEnumSyncMgrEvents* ppenum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgreventstore-geteventcount
    HRESULT GetEventCount(uint* pcEvents);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgreventstore-getevent
    HRESULT GetEvent(const(GUID)* rguidEventID, ISyncMgrEvent* ppEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgreventstore-removeevent
    HRESULT RemoveEvent(GUID* pguidEventIDs, uint cEvents);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgrevent
@GUID("fee0ef8b-46bd-4db4-b7e6-ff2c687313bc")
interface ISyncMgrEvent : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrevent-geteventid
    HRESULT GetEventID(GUID* pguidEventID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrevent-gethandlerid
    HRESULT GetHandlerID(PWSTR* ppszHandlerID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrevent-getitemid
    HRESULT GetItemID(PWSTR* ppszItemID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrevent-getlevel
    HRESULT GetLevel(SYNCMGR_EVENT_LEVEL* pnLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrevent-getflags
    HRESULT GetFlags(SYNCMGR_EVENT_FLAGS* pnFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrevent-gettime
    HRESULT GetTime(FILETIME* pfCreationTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrevent-getname
    HRESULT GetName(PWSTR* ppszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrevent-getdescription
    HRESULT GetDescription(PWSTR* ppszDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrevent-getlinktext
    HRESULT GetLinkText(PWSTR* ppszLinkText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrevent-getlinkreference
    HRESULT GetLinkReference(PWSTR* ppszLinkReference);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrevent-getcontext
    HRESULT GetContext(PWSTR* ppszContext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-ienumsyncmgrevents
@GUID("c81a1d4e-8cf7-4683-80e0-bcae88d677b6")
interface IEnumSyncMgrEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-ienumsyncmgrevents-next
    HRESULT Next(uint celt, ISyncMgrEvent* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-ienumsyncmgrevents-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-ienumsyncmgrevents-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-ienumsyncmgrevents-clone
    HRESULT Clone(IEnumSyncMgrEvents* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgrconflictstore
@GUID("cf8fc579-c396-4774-85f1-d908a831156e")
interface ISyncMgrConflictStore : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflictstore-enumconflicts
    HRESULT EnumConflicts(const(PWSTR) pszHandlerID, const(PWSTR) pszItemID, IEnumSyncMgrConflict* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflictstore-bindtoconflict
    HRESULT BindToConflict(const(SYNCMGR_CONFLICT_ID_INFO)* pConflictIdInfo, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflictstore-removeconflicts
    HRESULT RemoveConflicts(const(SYNCMGR_CONFLICT_ID_INFO)* rgConflictIdInfo, uint cConflicts);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflictstore-getcount
    HRESULT GetCount(const(PWSTR) pszHandlerID, const(PWSTR) pszItemID, uint* pnConflicts);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-ienumsyncmgrconflict
@GUID("82705914-dda3-4893-ba99-49de6c8c8036")
interface IEnumSyncMgrConflict : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-ienumsyncmgrconflict-next
    HRESULT Next(uint celt, ISyncMgrConflict* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-ienumsyncmgrconflict-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-ienumsyncmgrconflict-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-ienumsyncmgrconflict-clone
    HRESULT Clone(IEnumSyncMgrConflict* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgrconflict
@GUID("9c204249-c443-4ba4-85ed-c972681db137")
interface ISyncMgrConflict : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflict-getproperty
    HRESULT GetProperty(const(PROPERTYKEY)* propkey, PROPVARIANT* ppropvar);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflict-getconflictidinfo
    HRESULT GetConflictIdInfo(SYNCMGR_CONFLICT_ID_INFO* pConflictIdInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflict-getitemsarray
    HRESULT GetItemsArray(ISyncMgrConflictItems* ppArray);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflict-resolve
    HRESULT Resolve(ISyncMgrConflictResolveInfo pResolveInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflict-getresolutionhandler
    HRESULT GetResolutionHandler(const(GUID)* riid, void** ppvResolutionHandler);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgrresolutionhandler
@GUID("40a3d052-8bff-4c4b-a338-d4a395700de9")
interface ISyncMgrResolutionHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrresolutionhandler-queryabilities
    HRESULT QueryAbilities(uint* pdwAbilities);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrresolutionhandler-keepother
    HRESULT KeepOther(IShellItem psiOther, SYNCMGR_RESOLUTION_FEEDBACK* pFeedback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrresolutionhandler-keeprecent
    HRESULT KeepRecent(SYNCMGR_RESOLUTION_FEEDBACK* pFeedback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrresolutionhandler-removefromsyncset
    HRESULT RemoveFromSyncSet(SYNCMGR_RESOLUTION_FEEDBACK* pFeedback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrresolutionhandler-keepitems
    HRESULT KeepItems(ISyncMgrConflictResolutionItems pArray, SYNCMGR_RESOLUTION_FEEDBACK* pFeedback);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgrconflictpresenter
@GUID("0b4f5353-fd2b-42cd-8763-4779f2d508a3")
interface ISyncMgrConflictPresenter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflictpresenter-presentconflict
    HRESULT PresentConflict(ISyncMgrConflict pConflict, ISyncMgrConflictResolveInfo pResolveInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgrconflictresolveinfo
@GUID("c405a219-25a2-442e-8743-b845a2cee93f")
interface ISyncMgrConflictResolveInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflictresolveinfo-getiterationinfo
    HRESULT GetIterationInfo(uint* pnCurrentConflict, uint* pcConflicts, uint* pcRemainingForApplyToAll);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflictresolveinfo-getpresenternextstep
    HRESULT GetPresenterNextStep(SYNCMGR_PRESENTER_NEXT_STEP* pnPresenterNextStep);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflictresolveinfo-getpresenterchoice
    HRESULT GetPresenterChoice(SYNCMGR_PRESENTER_CHOICE* pnPresenterChoice, BOOL* pfApplyToAll);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflictresolveinfo-getitemchoicecount
    HRESULT GetItemChoiceCount(uint* pcChoices);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflictresolveinfo-getitemchoice
    HRESULT GetItemChoice(uint iChoice, uint* piChoiceIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflictresolveinfo-setpresenternextstep
    HRESULT SetPresenterNextStep(SYNCMGR_PRESENTER_NEXT_STEP nPresenterNextStep);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflictresolveinfo-setpresenterchoice
    HRESULT SetPresenterChoice(SYNCMGR_PRESENTER_CHOICE nPresenterChoice, BOOL fApplyToAll);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflictresolveinfo-setitemchoices
    HRESULT SetItemChoices(uint* prgiConflictItemIndexes, uint cChoices);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgrconflictfolder
@GUID("59287f5e-bc81-4fca-a7f1-e5a8ecdb1d69")
interface ISyncMgrConflictFolder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflictfolder-getconflictidlist
    HRESULT GetConflictIDList(ISyncMgrConflict pConflict, ITEMIDLIST** ppidlConflict);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgrconflictitems
@GUID("9c7ead52-8023-4936-a4db-d2a9a99e436a")
interface ISyncMgrConflictItems : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflictitems-getcount
    HRESULT GetCount(uint* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflictitems-getitem
    HRESULT GetItem(uint iIndex, CONFIRM_CONFLICT_ITEM* pItemInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nn-syncmgr-isyncmgrconflictresolutionitems
@GUID("458725b9-129d-4135-a998-9ceafec27007")
interface ISyncMgrConflictResolutionItems : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflictresolutionitems-getcount
    HRESULT GetCount(uint* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/syncmgr/nf-syncmgr-isyncmgrconflictresolutionitems-getitem
    HRESULT GetItem(uint iIndex, CONFIRM_CONFLICT_RESULT_INFO* pItemInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inputpanelconfiguration/nn-inputpanelconfiguration-iinputpanelconfiguration
@GUID("41c81592-514c-48bd-a22e-e6af638521a6")
interface IInputPanelConfiguration : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inputpanelconfiguration/nf-inputpanelconfiguration-iinputpanelconfiguration-enablefocustracking
    HRESULT EnableFocusTracking();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inputpanelconfiguration/nn-inputpanelconfiguration-iinputpanelinvocationconfiguration
@GUID("a213f136-3b45-4362-a332-efb6547cd432")
interface IInputPanelInvocationConfiguration : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inputpanelconfiguration/nf-inputpanelconfiguration-iinputpanelinvocationconfiguration-requiretouchineditcontrol
    HRESULT RequireTouchInEditControl();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbcache/nn-thumbcache-isharedbitmap
@GUID("091162a4-bc96-411f-aae8-c5122cd03363")
interface ISharedBitmap : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbcache/nf-thumbcache-isharedbitmap-getsharedbitmap
    HRESULT GetSharedBitmap(HBITMAP* phbm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbcache/nf-thumbcache-isharedbitmap-getsize
    HRESULT GetSize(SIZE* pSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbcache/nf-thumbcache-isharedbitmap-getformat
    HRESULT GetFormat(WTS_ALPHATYPE* pat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbcache/nf-thumbcache-isharedbitmap-initializebitmap
    HRESULT InitializeBitmap(HBITMAP hbm, WTS_ALPHATYPE wtsAT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbcache/nf-thumbcache-isharedbitmap-detach
    HRESULT Detach(HBITMAP* phbm);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbcache/nn-thumbcache-ithumbnailcache
@GUID("f676c15d-596a-4ce2-8234-33996f445db1")
interface IThumbnailCache : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbcache/nf-thumbcache-ithumbnailcache-getthumbnail
    HRESULT GetThumbnail(IShellItem pShellItem, uint cxyRequestedThumbSize, WTS_FLAGS flags, 
                         ISharedBitmap* ppvThumb, WTS_CACHEFLAGS* pOutFlags, WTS_THUMBNAILID* pThumbnailID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbcache/nf-thumbcache-ithumbnailcache-getthumbnailbyid
    HRESULT GetThumbnailByID(WTS_THUMBNAILID thumbnailID, uint cxyRequestedThumbSize, ISharedBitmap* ppvThumb, 
                             WTS_CACHEFLAGS* pOutFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbcache/nn-thumbcache-ithumbnailprovider
@GUID("e357fccd-a995-4576-b01f-234630154e96")
interface IThumbnailProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbcache/nf-thumbcache-ithumbnailprovider-getthumbnail
    HRESULT GetThumbnail(uint cx, HBITMAP* phbmp, WTS_ALPHATYPE* pdwAlpha);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbcache/nn-thumbcache-ithumbnailsettings
@GUID("f4376f00-bef5-4d45-80f3-1e023bbf1209")
interface IThumbnailSettings : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbcache/nf-thumbcache-ithumbnailsettings-setcontext
    HRESULT SetContext(WTS_CONTEXTFLAGS dwContext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbcache/nn-thumbcache-ithumbnailcacheprimer
@GUID("0f03f8fe-2b26-46f0-965a-212aa8d66b76")
interface IThumbnailCachePrimer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbcache/nf-thumbcache-ithumbnailcacheprimer-pageinthumbnail
    HRESULT PageInThumbnail(IShellItem psi, WTS_FLAGS wtsFlags, uint cxyRequestedThumbSize);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nn-shimgdata-ishellimagedatafactory
@GUID("9be8ed5c-edab-4d75-90f3-bd5bdbb21c82")
interface IShellImageDataFactory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedatafactory-createishellimagedata
    HRESULT CreateIShellImageData(IShellImageData* ppshimg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedatafactory-createimagefromfile
    HRESULT CreateImageFromFile(const(PWSTR) pszPath, IShellImageData* ppshimg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedatafactory-createimagefromstream
    HRESULT CreateImageFromStream(IStream pStream, IShellImageData* ppshimg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedatafactory-getdataformatfrompath
    HRESULT GetDataFormatFromPath(const(PWSTR) pszPath, GUID* pDataFormat);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nn-shimgdata-ishellimagedata
@GUID("bfdeec12-8040-4403-a5ea-9e07dafcf530")
interface IShellImageData : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-decode
    HRESULT Decode(uint dwFlags, uint cxDesired, uint cyDesired);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-draw
    HRESULT Draw(HDC hdc, RECT* prcDest, RECT* prcSrc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-nextframe
    HRESULT NextFrame();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-nextpage
    HRESULT NextPage();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-prevpage
    HRESULT PrevPage();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-istransparent
    HRESULT IsTransparent();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-isanimated
    HRESULT IsAnimated();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-isvector
    HRESULT IsVector();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-ismultipage
    HRESULT IsMultipage();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-iseditable
    HRESULT IsEditable();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-isprintable
    HRESULT IsPrintable();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-isdecoded
    HRESULT IsDecoded();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-getcurrentpage
    HRESULT GetCurrentPage(uint* pnPage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-getpagecount
    HRESULT GetPageCount(uint* pcPages);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-selectpage
    HRESULT SelectPage(uint iPage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-getsize
    HRESULT GetSize(SIZE* pSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-getrawdataformat
    HRESULT GetRawDataFormat(GUID* pDataFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-getpixelformat
    HRESULT GetPixelFormat(uint* pFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-getdelay
    HRESULT GetDelay(uint* pdwDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-getproperties
    HRESULT GetProperties(uint dwMode, IPropertySetStorage* ppPropSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-rotate
    HRESULT Rotate(uint dwAngle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-scale
    HRESULT Scale(uint cx, uint cy, InterpolationMode hints);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-discardedit
    HRESULT DiscardEdit();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-setencoderparams
    HRESULT SetEncoderParams(IPropertyBag pbagEnc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-displayname
    HRESULT DisplayName(PWSTR wszName, uint cch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-getresolution
    HRESULT GetResolution(uint* puResolutionX, uint* puResolutionY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-getencoderparams
    HRESULT GetEncoderParams(GUID* pguidFmt, ubyte** ppEncParams);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-registerabort
    HRESULT RegisterAbort(IShellImageDataAbort pAbort, IShellImageDataAbort* ppAbortPrev);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-cloneframe
    HRESULT CloneFrame(ubyte** ppImg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedata-replaceframe
    HRESULT ReplaceFrame(ubyte* pImg);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nn-shimgdata-ishellimagedataabort
@GUID("53fb8e58-50c0-4003-b4aa-0c8df28e7f3a")
interface IShellImageDataAbort : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shimgdata/nf-shimgdata-ishellimagedataabort-queryabort
    HRESULT QueryAbort();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/storageprovider/nn-storageprovider-istorageproviderpropertyhandler
@GUID("301dfbe5-524c-4b0f-8b2d-21c40b3a2988")
interface IStorageProviderPropertyHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/storageprovider/nf-storageprovider-istorageproviderpropertyhandler-retrieveproperties
    HRESULT RetrieveProperties(const(PROPERTYKEY)* propertiesToRetrieve, uint propertiesToRetrieveCount, 
                               IPropertyStore* retrievedProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/storageprovider/nf-storageprovider-istorageproviderpropertyhandler-saveproperties
    HRESULT SaveProperties(IPropertyStore propertiesToSave);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/storageprovider/nn-storageprovider-istorageproviderhandler
@GUID("162c6fb5-44d3-435b-903d-e613fa093fb5")
interface IStorageProviderHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/storageprovider/nf-storageprovider-istorageproviderhandler-getpropertyhandlerfrompath
    HRESULT GetPropertyHandlerFromPath(const(PWSTR) path, IStorageProviderPropertyHandler* propertyHandler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/storageprovider/nf-storageprovider-istorageproviderhandler-getpropertyhandlerfromuri
    HRESULT GetPropertyHandlerFromUri(const(PWSTR) uri, IStorageProviderPropertyHandler* propertyHandler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/storageprovider/nf-storageprovider-istorageproviderhandler-getpropertyhandlerfromfileid
    HRESULT GetPropertyHandlerFromFileId(const(PWSTR) fileId, IStorageProviderPropertyHandler* propertyHandler);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nn-mobsync-isyncmgrsynchronizecallback
@GUID("6295df41-35ee-11d1-8707-00c04fd93327")
interface ISyncMgrSynchronizeCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronizecallback-showpropertiescompleted
    HRESULT ShowPropertiesCompleted(HRESULT hr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronizecallback-prepareforsynccompleted
    HRESULT PrepareForSyncCompleted(HRESULT hr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronizecallback-synchronizecompleted
    HRESULT SynchronizeCompleted(HRESULT hr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronizecallback-showerrorcompleted
    HRESULT ShowErrorCompleted(HRESULT hr, uint cItems, const(GUID)* pItemIDs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronizecallback-enablemodeless
    HRESULT EnableModeless(BOOL fEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronizecallback-progress
    HRESULT Progress(const(GUID)* ItemID, const(SYNCMGRPROGRESSITEM)* pSyncProgressItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronizecallback-logerror
    HRESULT LogError(uint dwErrorLevel, const(PWSTR) pszErrorText, const(SYNCMGRLOGERRORINFO)* pSyncLogError);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronizecallback-deletelogerror
    HRESULT DeleteLogError(const(GUID)* ErrorID, uint dwReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronizecallback-establishconnection
    HRESULT EstablishConnection(const(PWSTR) pwszConnection, uint dwReserved);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nn-mobsync-isyncmgrenumitems
@GUID("6295df2a-35ee-11d1-8707-00c04fd93327")
interface ISyncMgrEnumItems : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrenumitems-next
    HRESULT Next(uint celt, SYNCMGRITEM* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrenumitems-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrenumitems-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrenumitems-clone
    HRESULT Clone(ISyncMgrEnumItems* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nn-mobsync-isyncmgrsynchronize
@GUID("6295df40-35ee-11d1-8707-00c04fd93327")
interface ISyncMgrSynchronize : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronize-initialize
    HRESULT Initialize(uint dwReserved, uint dwSyncMgrFlags, uint cbCookie, const(ubyte)* lpCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronize-gethandlerinfo
    HRESULT GetHandlerInfo(SYNCMGRHANDLERINFO** ppSyncMgrHandlerInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronize-enumsyncmgritems
    HRESULT EnumSyncMgrItems(ISyncMgrEnumItems* ppSyncMgrEnumItems);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronize-getitemobject
    HRESULT GetItemObject(const(GUID)* ItemID, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronize-showproperties
    HRESULT ShowProperties(HWND hWndParent, const(GUID)* ItemID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronize-setprogresscallback
    HRESULT SetProgressCallback(ISyncMgrSynchronizeCallback lpCallBack);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronize-prepareforsync
    HRESULT PrepareForSync(uint cbNumItems, GUID* pItemIDs, HWND hWndParent, uint dwReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronize-synchronize
    HRESULT Synchronize(HWND hWndParent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronize-setitemstatus
    HRESULT SetItemStatus(const(GUID)* pItemID, uint dwSyncMgrStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronize-showerror
    HRESULT ShowError(HWND hWndParent, const(GUID)* ErrorID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nn-mobsync-isyncmgrsynchronizeinvoke
@GUID("6295df2c-35ee-11d1-8707-00c04fd93327")
interface ISyncMgrSynchronizeInvoke : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronizeinvoke-updateitems
    HRESULT UpdateItems(uint dwInvokeFlags, const(GUID)* clsid, uint cbCookie, const(ubyte)* pCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrsynchronizeinvoke-updateall
    HRESULT UpdateAll();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nn-mobsync-isyncmgrregister
@GUID("6295df42-35ee-11d1-8707-00c04fd93327")
interface ISyncMgrRegister : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrregister-registersyncmgrhandler
    HRESULT RegisterSyncMgrHandler(const(GUID)* clsidHandler, const(PWSTR) pwszDescription, 
                                   uint dwSyncMgrRegisterFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrregister-unregistersyncmgrhandler
    HRESULT UnregisterSyncMgrHandler(const(GUID)* clsidHandler, uint dwReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mobsync/nf-mobsync-isyncmgrregister-gethandlerregistrationinfo
    HRESULT GetHandlerRegistrationInfo(const(GUID)* clsidHandler, uint* pdwSyncMgrRegisterFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbnailstreamcache/nn-thumbnailstreamcache-ithumbnailstreamcache
@GUID("90e11430-9569-41d8-ae75-6d4d2ae7cca0")
interface IThumbnailStreamCache : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbnailstreamcache/nf-thumbnailstreamcache-ithumbnailstreamcache-getthumbnailstream
    HRESULT GetThumbnailStream(const(PWSTR) path, ulong cacheId, ThumbnailStreamCacheOptions options, 
                               uint requestedThumbnailSize, SIZE* thumbnailSize, IStream* thumbnailStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/thumbnailstreamcache/nf-thumbnailstreamcache-ithumbnailstreamcache-setthumbnailstream
    HRESULT SetThumbnailStream(const(PWSTR) path, ulong cacheId, SIZE thumbnailSize, IStream thumbnailStream);
}

@GUID("7ebfdd87-ad18-11d3-a4c5-00c04f72d6b8")
interface ITravelLogEntry : IUnknown
{
    HRESULT GetTitle(PWSTR* ppszTitle);
    HRESULT GetURL(PWSTR* ppszURL);
}

@GUID("241c033e-e659-43da-aa4d-4086dbc4758d")
interface ITravelLogClient : IUnknown
{
    HRESULT FindWindowByIndex(uint dwID, IUnknown* ppunk);
    HRESULT GetWindowData(IStream pStream, WINDOWDATA* pWinData);
    HRESULT LoadHistoryPosition(PWSTR pszUrlLocation, uint dwPosition);
}

@GUID("7ebfdd85-ad18-11d3-a4c5-00c04f72d6b8")
interface IEnumTravelLogEntry : IUnknown
{
    HRESULT Next(uint cElt, ITravelLogEntry* rgElt, uint* pcEltFetched);
    HRESULT Skip(uint cElt);
    HRESULT Reset();
    HRESULT Clone(IEnumTravelLogEntry* ppEnum);
}

@GUID("7ebfdd80-ad18-11d3-a4c5-00c04f72d6b8")
interface ITravelLogStg : IUnknown
{
    HRESULT CreateEntry(const(PWSTR) pszUrl, const(PWSTR) pszTitle, ITravelLogEntry ptleRelativeTo, BOOL fPrepend, 
                        ITravelLogEntry* pptle);
    HRESULT TravelTo(ITravelLogEntry ptle);
    HRESULT EnumEntries(TLENUMF flags, IEnumTravelLogEntry* ppenum);
    HRESULT FindEntries(TLENUMF flags, const(PWSTR) pszUrl, IEnumTravelLogEntry* ppenum);
    HRESULT GetCount(TLENUMF flags, uint* pcEntries);
    HRESULT RemoveEntry(ITravelLogEntry ptle);
    HRESULT GetRelativeEntry(int iOffset, ITravelLogEntry* ptle);
}

@GUID("79eac9c3-baf9-11ce-8c82-00aa004ba90b")
interface IHlink : IUnknown
{
    HRESULT SetHlinkSite(IHlinkSite pihlSite, uint dwSiteData);
    HRESULT GetHlinkSite(IHlinkSite* ppihlSite, uint* pdwSiteData);
    HRESULT SetMonikerReference(uint grfHLSETF, IMoniker pimkTarget, const(PWSTR) pwzLocation);
    HRESULT GetMonikerReference(uint dwWhichRef, IMoniker* ppimkTarget, PWSTR* ppwzLocation);
    HRESULT SetStringReference(uint grfHLSETF, const(PWSTR) pwzTarget, const(PWSTR) pwzLocation);
    HRESULT GetStringReference(uint dwWhichRef, PWSTR* ppwzTarget, PWSTR* ppwzLocation);
    HRESULT SetFriendlyName(const(PWSTR) pwzFriendlyName);
    HRESULT GetFriendlyName(uint grfHLFNAMEF, PWSTR* ppwzFriendlyName);
    HRESULT SetTargetFrameName(const(PWSTR) pwzTargetFrameName);
    HRESULT GetTargetFrameName(PWSTR* ppwzTargetFrameName);
    HRESULT GetMiscStatus(uint* pdwStatus);
    HRESULT Navigate(uint grfHLNF, IBindCtx pibc, IBindStatusCallback pibsc, IHlinkBrowseContext pihlbc);
    HRESULT SetAdditionalParams(const(PWSTR) pwzAdditionalParams);
    HRESULT GetAdditionalParams(PWSTR* ppwzAdditionalParams);
}

@GUID("79eac9c2-baf9-11ce-8c82-00aa004ba90b")
interface IHlinkSite : IUnknown
{
    HRESULT QueryService(uint dwSiteData, const(GUID)* guidService, const(GUID)* riid, IUnknown* ppiunk);
    HRESULT GetMoniker(uint dwSiteData, uint dwAssign, uint dwWhich, IMoniker* ppimk);
    HRESULT ReadyToNavigate(uint dwSiteData, uint dwReserved);
    HRESULT OnNavigationComplete(uint dwSiteData, uint dwreserved, HRESULT hrError, const(PWSTR) pwzError);
}

@GUID("79eac9c4-baf9-11ce-8c82-00aa004ba90b")
interface IHlinkTarget : IUnknown
{
    HRESULT SetBrowseContext(IHlinkBrowseContext pihlbc);
    HRESULT GetBrowseContext(IHlinkBrowseContext* ppihlbc);
    HRESULT Navigate(uint grfHLNF, const(PWSTR) pwzJumpLocation);
    HRESULT GetMoniker(const(PWSTR) pwzLocation, uint dwAssign, IMoniker* ppimkLocation);
    HRESULT GetFriendlyName(const(PWSTR) pwzLocation, PWSTR* ppwzFriendlyName);
}

@GUID("79eac9c5-baf9-11ce-8c82-00aa004ba90b")
interface IHlinkFrame : IUnknown
{
    HRESULT SetBrowseContext(IHlinkBrowseContext pihlbc);
    HRESULT GetBrowseContext(IHlinkBrowseContext* ppihlbc);
    HRESULT Navigate(uint grfHLNF, IBindCtx pbc, IBindStatusCallback pibsc, IHlink pihlNavigate);
    HRESULT OnNavigate(uint grfHLNF, IMoniker pimkTarget, const(PWSTR) pwzLocation, const(PWSTR) pwzFriendlyName, 
                       uint dwreserved);
    HRESULT UpdateHlink(uint uHLID, IMoniker pimkTarget, const(PWSTR) pwzLocation, const(PWSTR) pwzFriendlyName);
}

@GUID("79eac9c6-baf9-11ce-8c82-00aa004ba90b")
interface IEnumHLITEM : IUnknown
{
    HRESULT Next(uint celt, HLITEM* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumHLITEM* ppienumhlitem);
}

@GUID("79eac9c7-baf9-11ce-8c82-00aa004ba90b")
interface IHlinkBrowseContext : IUnknown
{
    HRESULT Register(uint reserved, IUnknown piunk, IMoniker pimk, uint* pdwRegister);
    HRESULT GetObject(IMoniker pimk, BOOL fBindIfRootRegistered, IUnknown* ppiunk);
    HRESULT Revoke(uint dwRegister);
    HRESULT SetBrowseWindowInfo(HLBWINFO* phlbwi);
    HRESULT GetBrowseWindowInfo(HLBWINFO* phlbwi);
    HRESULT SetInitialHlink(IMoniker pimkTarget, const(PWSTR) pwzLocation, const(PWSTR) pwzFriendlyName);
    HRESULT OnNavigateHlink(uint grfHLNF, IMoniker pimkTarget, const(PWSTR) pwzLocation, 
                            const(PWSTR) pwzFriendlyName, uint* puHLID);
    HRESULT UpdateHlink(uint uHLID, IMoniker pimkTarget, const(PWSTR) pwzLocation, const(PWSTR) pwzFriendlyName);
    HRESULT EnumNavigationStack(uint dwReserved, uint grfHLFNAMEF, IEnumHLITEM* ppienumhlitem);
    HRESULT QueryHlink(uint grfHLQF, uint uHLID);
    HRESULT GetHlink(uint uHLID, IHlink* ppihl);
    HRESULT SetCurrentHlink(uint uHLID);
    HRESULT Clone(IUnknown piunkOuter, const(GUID)* riid, IUnknown* ppiunkObj);
    HRESULT Close(uint reserved);
}

@GUID("79eac9cb-baf9-11ce-8c82-00aa004ba90b")
interface IExtensionServices : IUnknown
{
    HRESULT SetAdditionalHeaders(const(PWSTR) pwzAdditionalHeaders);
    HRESULT SetAuthenticateData(HWND phwnd, const(PWSTR) pwzUsername, const(PWSTR) pwzPassword);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nn-shdeprecated-itravelentry
@GUID("f46edb3b-bc2f-11d0-9412-00aa00a3ebd3")
interface ITravelEntry : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-itravelentry-invoke
    HRESULT Invoke(IUnknown punk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-itravelentry-update
    HRESULT Update(IUnknown punk, BOOL fIsLocalAnchor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-itravelentry-getpidl
    HRESULT GetPidl(ITEMIDLIST** ppidl);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nn-shdeprecated-itravellog
@GUID("66a9cb08-4802-11d2-a561-00a0c92dbfe8")
interface ITravelLog : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-itravellog-addentry
    HRESULT AddEntry(IUnknown punk, BOOL fIsLocalAnchor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-itravellog-updateentry
    HRESULT UpdateEntry(IUnknown punk, BOOL fIsLocalAnchor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-itravellog-updateexternal
    HRESULT UpdateExternal(IUnknown punk, IUnknown punkHLBrowseContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-itravellog-travel
    HRESULT Travel(IUnknown punk, int iOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-itravellog-gettravelentry
    HRESULT GetTravelEntry(IUnknown punk, int iOffset, ITravelEntry* ppte);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-itravellog-findtravelentry
    HRESULT FindTravelEntry(IUnknown punk, ITEMIDLIST* pidl, ITravelEntry* ppte);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-itravellog-gettooltiptext
    HRESULT GetToolTipText(IUnknown punk, int iOffset, int idsTemplate, PWSTR pwzText, uint cchText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-itravellog-insertmenuentries
    HRESULT InsertMenuEntries(IUnknown punk, HMENU hmenu, int nPos, int idFirst, int idLast, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-itravellog-clone
    HRESULT Clone(ITravelLog* pptl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-itravellog-countentries
    uint    CountEntries(IUnknown punk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-itravellog-revert
    HRESULT Revert();
}

interface CIE4ConnectionPoint : IConnectionPoint
{
    HRESULT DoInvokeIE4(BOOL* pf, void** ppv, int dispid, DISPPARAMS* pdispparams);
    HRESULT DoInvokePIDLIE4(int dispid, ITEMIDLIST* pidl, BOOL fCanCancel);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nn-shdeprecated-iexpdispsupportxp
@GUID("2f0dd58c-f789-4f14-99fb-9293b3c9c212")
interface IExpDispSupportXP : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-iexpdispsupportxp-findcie4connectionpoint
    HRESULT FindCIE4ConnectionPoint(const(GUID)* riid, CIE4ConnectionPoint* ppccp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-iexpdispsupportxp-ontranslateaccelerator
    HRESULT OnTranslateAccelerator(MSG* pMsg, uint grfModifiers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-iexpdispsupportxp-oninvoke
    HRESULT OnInvoke(int dispidMember, const(GUID)* iid, uint lcid, ushort wFlags, DISPPARAMS* pdispparams, 
                     VARIANT* pVarResult, EXCEPINFO* pexcepinfo, uint* puArgErr);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nn-shdeprecated-iexpdispsupport
@GUID("0d7d1d00-6fc0-11d0-a974-00c04fd705a2")
interface IExpDispSupport : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-iexpdispsupport-findconnectionpoint
    HRESULT FindConnectionPoint(const(GUID)* riid, IConnectionPoint* ppccp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-iexpdispsupport-ontranslateaccelerator
    HRESULT OnTranslateAccelerator(MSG* pMsg, uint grfModifiers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-iexpdispsupport-oninvoke
    HRESULT OnInvoke(int dispidMember, const(GUID)* iid, uint lcid, ushort wFlags, DISPPARAMS* pdispparams, 
                     VARIANT* pVarResult, EXCEPINFO* pexcepinfo, uint* puArgErr);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nn-shdeprecated-ibrowserservice
@GUID("02ba3b52-0547-11d1-b833-00c04fc9b31f")
interface IBrowserService : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-getparentsite
    HRESULT GetParentSite(IOleInPlaceSite* ppipsite);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-settitle
    HRESULT SetTitle(IShellView psv, const(PWSTR) pszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-gettitle
    HRESULT GetTitle(IShellView psv, PWSTR pszName, uint cchName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-getoleobject
    HRESULT GetOleObject(IOleObject* ppobjv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-gettravellog
    HRESULT GetTravelLog(ITravelLog* pptl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-showcontrolwindow
    HRESULT ShowControlWindow(uint id, BOOL fShow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-iscontrolwindowshown
    HRESULT IsControlWindowShown(uint id, BOOL* pfShown);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-iegetdisplayname
    HRESULT IEGetDisplayName(ITEMIDLIST* pidl, PWSTR pwszName, uint uFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-ieparsedisplayname
    HRESULT IEParseDisplayName(uint uiCP, const(PWSTR) pwszPath, ITEMIDLIST** ppidlOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-displayparseerror
    HRESULT DisplayParseError(HRESULT hres, const(PWSTR) pwszPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-navigatetopidl
    HRESULT NavigateToPidl(ITEMIDLIST* pidl, uint grfHLNF);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-setnavigatestate
    HRESULT SetNavigateState(BNSTATE bnstate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-getnavigatestate
    HRESULT GetNavigateState(BNSTATE* pbnstate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-notifyredirect
    HRESULT NotifyRedirect(IShellView psv, ITEMIDLIST* pidl, BOOL* pfDidBrowse);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-updatewindowlist
    HRESULT UpdateWindowList();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-updatebackforwardstate
    HRESULT UpdateBackForwardState();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-setflags
    HRESULT SetFlags(uint dwFlags, uint dwFlagMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-getflags
    HRESULT GetFlags(uint* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-cannavigatenow
    HRESULT CanNavigateNow();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-getpidl
    HRESULT GetPidl(ITEMIDLIST** ppidl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-setreferrer
    HRESULT SetReferrer(ITEMIDLIST* pidl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-getbrowserindex
    uint    GetBrowserIndex();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-getbrowserbyindex
    HRESULT GetBrowserByIndex(uint dwID, IUnknown* ppunk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-gethistoryobject
    HRESULT GetHistoryObject(IOleObject* ppole, IStream* pstm, IBindCtx* ppbc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-sethistoryobject
    HRESULT SetHistoryObject(IOleObject pole, BOOL fIsLocalAnchor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-cacheoleserver
    HRESULT CacheOLEServer(IOleObject pole);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-getsetcodepage
    HRESULT GetSetCodePage(VARIANT* pvarIn, VARIANT* pvarOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-onhttpequiv
    HRESULT OnHttpEquiv(IShellView psv, BOOL fDone, VARIANT* pvarargIn, VARIANT* pvarargOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-getpalette
    HRESULT GetPalette(HPALETTE* hpal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice-registerwindow
    HRESULT RegisterWindow(BOOL fForceRegister, ShellWindowTypeConstants swc);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nn-shdeprecated-ishellservice
@GUID("5836fb00-8187-11cf-a12b-00aa004ae837")
interface IShellService : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ishellservice-setowner
    HRESULT SetOwner(IUnknown punkOwner);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nn-shdeprecated-ibrowserservice2
@GUID("68bd21cc-438b-11d2-a560-00a0c92dbfe8")
interface IBrowserService2 : IBrowserService
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-wndprocbs
    LRESULT WndProcBS(HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-setasdeffoldersettings
    HRESULT SetAsDefFolderSettings();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-getviewrect
    HRESULT GetViewRect(RECT* prc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-onsize
    HRESULT OnSize(WPARAM wParam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-oncreate
    HRESULT OnCreate(CREATESTRUCTW* pcs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-oncommand
    LRESULT OnCommand(WPARAM wParam, LPARAM lParam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-ondestroy
    HRESULT OnDestroy();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-onnotify
    LRESULT OnNotify(NMHDR* pnm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-onsetfocus
    HRESULT OnSetFocus();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-onframewindowactivatebs
    HRESULT OnFrameWindowActivateBS(BOOL fActive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-releaseshellview
    HRESULT ReleaseShellView();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-activatependingview
    HRESULT ActivatePendingView();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-createviewwindow
    HRESULT CreateViewWindow(IShellView psvNew, IShellView psvOld, RECT* prcView, HWND* phwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-createbrowserpropsheetext
    HRESULT CreateBrowserPropSheetExt(const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-getviewwindow
    HRESULT GetViewWindow(HWND* phwndView);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-getbasebrowserdata
    HRESULT GetBaseBrowserData(BASEBROWSERDATALH** pbbd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-putbasebrowserdata
    BASEBROWSERDATALH* PutBaseBrowserData();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-initializetravellog
    HRESULT InitializeTravelLog(ITravelLog ptl, uint dw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-settopbrowser
    HRESULT SetTopBrowser();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-offline
    HRESULT Offline(int iCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-allowviewresize
    HRESULT AllowViewResize(BOOL f);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-setactivatestate
    HRESULT SetActivateState(uint u);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-updatesecurelockicon
    HRESULT UpdateSecureLockIcon(int eSecureLock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-initializedownloadmanager
    HRESULT InitializeDownloadManager();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-initializetransitionsite
    HRESULT InitializeTransitionSite();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_initialize
    HRESULT _Initialize(HWND hwnd, IUnknown pauto);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_cancelpendingnavigationasync
    HRESULT _CancelPendingNavigationAsync();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_cancelpendingview
    HRESULT _CancelPendingView();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_maysavechanges
    HRESULT _MaySaveChanges();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_pauseorresumeview
    HRESULT _PauseOrResumeView(BOOL fPaused);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_disablemodeless
    HRESULT _DisableModeless();
    HRESULT _NavigateToPidl2(ITEMIDLIST* pidl, uint grfHLNF, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_tryshell2rename
    HRESULT _TryShell2Rename(IShellView psv, ITEMIDLIST* pidlNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_switchactivationnow
    HRESULT _SwitchActivationNow();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_execchildren
    HRESULT _ExecChildren(IUnknown punkBar, BOOL fBroadcast, const(GUID)* pguidCmdGroup, uint nCmdID, 
                          uint nCmdexecopt, VARIANT* pvarargIn, VARIANT* pvarargOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_sendchildren
    HRESULT _SendChildren(HWND hwndBar, BOOL fBroadcast, uint uMsg, WPARAM wParam, LPARAM lParam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-getfoldersetdata
    HRESULT GetFolderSetData(FOLDERSETDATA* pfsd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_onfocuschange
    HRESULT _OnFocusChange(uint itb);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-v_showhidechildwindows
    HRESULT v_ShowHideChildWindows(BOOL fChildOnly);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_get_itblastfocus
    uint    _get_itbLastFocus();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_put_itblastfocus
    HRESULT _put_itbLastFocus(uint itbLastFocus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_uiactivateview
    HRESULT _UIActivateView(uint uState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_getviewborderrect
    HRESULT _GetViewBorderRect(RECT* prc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_updateviewrectsize
    HRESULT _UpdateViewRectSize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_resizenextborder
    HRESULT _ResizeNextBorder(uint itb);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_resizeview
    HRESULT _ResizeView();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_geteffectiveclientarea
    HRESULT _GetEffectiveClientArea(RECT* lprectBorder, HMONITOR hmon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-v_getviewstream
    IStream v_GetViewStream(ITEMIDLIST* pidl, uint grfMode, const(PWSTR) pwszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-forwardviewmsg
    LRESULT ForwardViewMsg(uint uMsg, WPARAM wParam, LPARAM lParam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-setacceleratormenu
    HRESULT SetAcceleratorMenu(HACCEL hacc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_gettoolbarcount
    int     _GetToolbarCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_gettoolbaritem
    TOOLBARITEM* _GetToolbarItem(int itb);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_savetoolbars
    HRESULT _SaveToolbars(IStream pstm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_loadtoolbars
    HRESULT _LoadToolbars(IStream pstm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_closeandreleasetoolbars
    HRESULT _CloseAndReleaseToolbars(BOOL fClose);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-v_maygetnexttoolbarfocus
    HRESULT v_MayGetNextToolbarFocus(MSG* lpMsg, uint itbNext, int citb, TOOLBARITEM** pptbi, HWND* phwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_resizenextborderhelper
    HRESULT _ResizeNextBorderHelper(uint itb, BOOL bUseHmonitor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_findtbar
    uint    _FindTBar(IUnknown punkSrc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_setfocus
    HRESULT _SetFocus(TOOLBARITEM* ptbi, HWND hwnd, MSG* lpMsg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-v_maytranslateaccelerator
    HRESULT v_MayTranslateAccelerator(MSG* pmsg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-_getborderdwhelper
    HRESULT _GetBorderDWHelper(IUnknown punkSrc, RECT* lprectBorder, BOOL bUseHmonitor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice2-v_checkzonecrossing
    HRESULT v_CheckZoneCrossing(ITEMIDLIST* pidl);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nn-shdeprecated-ibrowserservice3
@GUID("27d7ce21-762d-48f3-86f3-40e2fd3749c4")
interface IBrowserService3 : IBrowserService2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice3-_positionviewwindow
    HRESULT _PositionViewWindow(HWND hwnd, RECT* prc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice3-ieparsedisplaynameex
    HRESULT IEParseDisplayNameEx(uint uiCP, const(PWSTR) pwszPath, uint dwFlags, ITEMIDLIST** ppidlOut);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nn-shdeprecated-ibrowserservice4
@GUID("639f1bff-e135-4096-abd8-e0f504d649a4")
interface IBrowserService4 : IBrowserService3
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice4-activateview
    HRESULT ActivateView(BOOL fPendingView);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice4-saveviewstate
    HRESULT SaveViewState();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-ibrowserservice4-_resizeallborders
    HRESULT _ResizeAllBorders();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nn-shdeprecated-itrackshellmenu
@GUID("8278f932-2a3e-11d2-838f-00c04fd918d0")
interface ITrackShellMenu : IShellMenu
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-itrackshellmenu-setobscured
    HRESULT SetObscured(HWND hwndTB, IUnknown punkBand, uint dwSMSetFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/shdeprecated/nf-shdeprecated-itrackshellmenu-popup
    HRESULT Popup(HWND hwnd, POINTL* ppt, RECTL* prcExclude, int dwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/imagetranscode/nn-imagetranscode-itranscodeimage
@GUID("bae86ddd-dc11-421c-b7ab-cc55d1d65c44")
interface ITranscodeImage : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/imagetranscode/nf-imagetranscode-itranscodeimage-transcodeimage
    HRESULT TranscodeImage(IShellItem pShellItem, uint uiMaxWidth, uint uiMaxHeight, uint flags, IStream pvImage, 
                           uint* puiWidth, uint* puiHeight);
}

@GUID("fbf23b80-e3f0-101b-8488-00aa003e56f8")
interface IUniformResourceLocatorA : IUnknown
{
    HRESULT SetURL(const(PSTR) pcszURL, uint dwInFlags);
    HRESULT GetURL(PSTR* ppszURL);
    HRESULT InvokeCommand(URLINVOKECOMMANDINFOA* purlici);
}

@GUID("cabb0da0-da57-11cf-9974-0020afd79762")
interface IUniformResourceLocatorW : IUnknown
{
    HRESULT SetURL(const(PWSTR) pcszURL, uint dwInFlags);
    HRESULT GetURL(PWSTR* ppszURL);
    HRESULT InvokeCommand(URLINVOKECOMMANDINFOW* purlici);
}

@GUID("2af16ba9-2de5-4b75-82d9-01372afbffb4")
interface IInputPaneAnimationCoordinator : IUnknown
{
    HRESULT AddAnimation(IUnknown device, IDCompositionAnimation animation);
}


// GUIDs

const GUID CLSID_AccessibilityDockingService          = GUIDOF!AccessibilityDockingService;
const GUID CLSID_AlphabeticalCategorizer              = GUIDOF!AlphabeticalCategorizer;
const GUID CLSID_AppShellVerbHandler                  = GUIDOF!AppShellVerbHandler;
const GUID CLSID_AppStartupLink                       = GUIDOF!AppStartupLink;
const GUID CLSID_AppVisibility                        = GUIDOF!AppVisibility;
const GUID CLSID_ApplicationActivationManager         = GUIDOF!ApplicationActivationManager;
const GUID CLSID_ApplicationAssociationRegistration   = GUIDOF!ApplicationAssociationRegistration;
const GUID CLSID_ApplicationAssociationRegistrationUI = GUIDOF!ApplicationAssociationRegistrationUI;
const GUID CLSID_ApplicationDesignModeSettings        = GUIDOF!ApplicationDesignModeSettings;
const GUID CLSID_ApplicationDestinations              = GUIDOF!ApplicationDestinations;
const GUID CLSID_ApplicationDocumentLists             = GUIDOF!ApplicationDocumentLists;
const GUID CLSID_AttachmentServices                   = GUIDOF!AttachmentServices;
const GUID CLSID_CDBurn                               = GUIDOF!CDBurn;
const GUID CLSID_CScriptErrorList                     = GUIDOF!CScriptErrorList;
const GUID CLSID_ConflictFolder                       = GUIDOF!ConflictFolder;
const GUID CLSID_DefFolderMenu                        = GUIDOF!DefFolderMenu;
const GUID CLSID_DesktopGadget                        = GUIDOF!DesktopGadget;
const GUID CLSID_DesktopWallpaper                     = GUIDOF!DesktopWallpaper;
const GUID CLSID_DestinationList                      = GUIDOF!DestinationList;
const GUID CLSID_DestinationListBoth                  = GUIDOF!DestinationListBoth;
const GUID CLSID_DocPropShellExtension                = GUIDOF!DocPropShellExtension;
const GUID CLSID_DriveSizeCategorizer                 = GUIDOF!DriveSizeCategorizer;
const GUID CLSID_DriveTypeCategorizer                 = GUIDOF!DriveTypeCategorizer;
const GUID CLSID_EnumerableObjectCollection           = GUIDOF!EnumerableObjectCollection;
const GUID CLSID_ExecuteFolder                        = GUIDOF!ExecuteFolder;
const GUID CLSID_ExecuteUnknown                       = GUIDOF!ExecuteUnknown;
const GUID CLSID_ExplorerBrowser                      = GUIDOF!ExplorerBrowser;
const GUID CLSID_FSCopyHandler                        = GUIDOF!FSCopyHandler;
const GUID CLSID_FileOpenDialog                       = GUIDOF!FileOpenDialog;
const GUID CLSID_FileOperation                        = GUIDOF!FileOperation;
const GUID CLSID_FileSaveDialog                       = GUIDOF!FileSaveDialog;
const GUID CLSID_FileSearchBand                       = GUIDOF!FileSearchBand;
const GUID CLSID_FolderViewHost                       = GUIDOF!FolderViewHost;
const GUID CLSID_FrameworkInputPane                   = GUIDOF!FrameworkInputPane;
const GUID CLSID_FreeSpaceCategorizer                 = GUIDOF!FreeSpaceCategorizer;
const GUID CLSID_GenericCredentialProvider            = GUIDOF!GenericCredentialProvider;
const GUID CLSID_HideInputPaneAnimationCoordinator    = GUIDOF!HideInputPaneAnimationCoordinator;
const GUID CLSID_HomeGroup                            = GUIDOF!HomeGroup;
const GUID CLSID_IENamespaceTreeControl               = GUIDOF!IENamespaceTreeControl;
const GUID CLSID_ImageProperties                      = GUIDOF!ImageProperties;
const GUID CLSID_ImageRecompress                      = GUIDOF!ImageRecompress;
const GUID CLSID_ImageTranscode                       = GUIDOF!ImageTranscode;
const GUID CLSID_InputPanelConfiguration              = GUIDOF!InputPanelConfiguration;
const GUID CLSID_InternetExplorer                     = GUIDOF!InternetExplorer;
const GUID CLSID_InternetExplorerMedium               = GUIDOF!InternetExplorerMedium;
const GUID CLSID_InternetPrintOrdering                = GUIDOF!InternetPrintOrdering;
const GUID CLSID_KnownFolderManager                   = GUIDOF!KnownFolderManager;
const GUID CLSID_LocalThumbnailCache                  = GUIDOF!LocalThumbnailCache;
const GUID CLSID_MailRecipient                        = GUIDOF!MailRecipient;
const GUID CLSID_MergedCategorizer                    = GUIDOF!MergedCategorizer;
const GUID CLSID_NPCredentialProvider                 = GUIDOF!NPCredentialProvider;
const GUID CLSID_NamespaceTreeControl                 = GUIDOF!NamespaceTreeControl;
const GUID CLSID_NamespaceWalker                      = GUIDOF!NamespaceWalker;
const GUID CLSID_NetworkConnections                   = GUIDOF!NetworkConnections;
const GUID CLSID_NetworkExplorerFolder                = GUIDOF!NetworkExplorerFolder;
const GUID CLSID_NetworkPlaces                        = GUIDOF!NetworkPlaces;
const GUID CLSID_OnexCredentialProvider               = GUIDOF!OnexCredentialProvider;
const GUID CLSID_OnexPlapSmartcardCredentialProvider  = GUIDOF!OnexPlapSmartcardCredentialProvider;
const GUID CLSID_OpenControlPanel                     = GUIDOF!OpenControlPanel;
const GUID CLSID_PINLogonCredentialProvider           = GUIDOF!PINLogonCredentialProvider;
const GUID CLSID_PackageDebugSettings                 = GUIDOF!PackageDebugSettings;
const GUID CLSID_PasswordCredentialProvider           = GUIDOF!PasswordCredentialProvider;
const GUID CLSID_PreviousVersions                     = GUIDOF!PreviousVersions;
const GUID CLSID_PropertiesUI                         = GUIDOF!PropertiesUI;
const GUID CLSID_PublishDropTarget                    = GUIDOF!PublishDropTarget;
const GUID CLSID_PublishingWizard                     = GUIDOF!PublishingWizard;
const GUID CLSID_QueryCancelAutoPlay                  = GUIDOF!QueryCancelAutoPlay;
const GUID CLSID_RASProvider                          = GUIDOF!RASProvider;
const GUID CLSID_ScheduledTasks                       = GUIDOF!ScheduledTasks;
const GUID CLSID_SearchFolderItemFactory              = GUIDOF!SearchFolderItemFactory;
const GUID CLSID_SharedBitmap                         = GUIDOF!SharedBitmap;
const GUID CLSID_SharingConfigurationManager          = GUIDOF!SharingConfigurationManager;
const GUID CLSID_Shell                                = GUIDOF!Shell;
const GUID CLSID_ShellBrowserWindow                   = GUIDOF!ShellBrowserWindow;
const GUID CLSID_ShellDesktop                         = GUIDOF!ShellDesktop;
const GUID CLSID_ShellDispatchInproc                  = GUIDOF!ShellDispatchInproc;
const GUID CLSID_ShellFSFolder                        = GUIDOF!ShellFSFolder;
const GUID CLSID_ShellFolderItem                      = GUIDOF!ShellFolderItem;
const GUID CLSID_ShellFolderView                      = GUIDOF!ShellFolderView;
const GUID CLSID_ShellFolderViewOC                    = GUIDOF!ShellFolderViewOC;
const GUID CLSID_ShellImageDataFactory                = GUIDOF!ShellImageDataFactory;
const GUID CLSID_ShellItem                            = GUIDOF!ShellItem;
const GUID CLSID_ShellLibrary                         = GUIDOF!ShellLibrary;
const GUID CLSID_ShellLink                            = GUIDOF!ShellLink;
const GUID CLSID_ShellLinkObject                      = GUIDOF!ShellLinkObject;
const GUID CLSID_ShellNameSpace                       = GUIDOF!ShellNameSpace;
const GUID CLSID_ShellUIHelper                        = GUIDOF!ShellUIHelper;
const GUID CLSID_ShellWindows                         = GUIDOF!ShellWindows;
const GUID CLSID_ShowInputPaneAnimationCoordinator    = GUIDOF!ShowInputPaneAnimationCoordinator;
const GUID CLSID_SimpleConflictPresenter              = GUIDOF!SimpleConflictPresenter;
const GUID CLSID_SizeCategorizer                      = GUIDOF!SizeCategorizer;
const GUID CLSID_SmartcardCredentialProvider          = GUIDOF!SmartcardCredentialProvider;
const GUID CLSID_SmartcardPinProvider                 = GUIDOF!SmartcardPinProvider;
const GUID CLSID_SmartcardReaderSelectionProvider     = GUIDOF!SmartcardReaderSelectionProvider;
const GUID CLSID_SmartcardWinRTProvider               = GUIDOF!SmartcardWinRTProvider;
const GUID CLSID_StartMenuPin                         = GUIDOF!StartMenuPin;
const GUID CLSID_StorageProviderBanners               = GUIDOF!StorageProviderBanners;
const GUID CLSID_SuspensionDependencyManager          = GUIDOF!SuspensionDependencyManager;
const GUID CLSID_SyncMgr                              = GUIDOF!SyncMgr;
const GUID CLSID_SyncMgrClient                        = GUIDOF!SyncMgrClient;
const GUID CLSID_SyncMgrControl                       = GUIDOF!SyncMgrControl;
const GUID CLSID_SyncMgrFolder                        = GUIDOF!SyncMgrFolder;
const GUID CLSID_SyncMgrScheduleWizard                = GUIDOF!SyncMgrScheduleWizard;
const GUID CLSID_SyncResultsFolder                    = GUIDOF!SyncResultsFolder;
const GUID CLSID_SyncSetupFolder                      = GUIDOF!SyncSetupFolder;
const GUID CLSID_TaskbarList                          = GUIDOF!TaskbarList;
const GUID CLSID_ThumbnailStreamCache                 = GUIDOF!ThumbnailStreamCache;
const GUID CLSID_TimeCategorizer                      = GUIDOF!TimeCategorizer;
const GUID CLSID_TrackShellMenu                       = GUIDOF!TrackShellMenu;
const GUID CLSID_TrayBandSiteService                  = GUIDOF!TrayBandSiteService;
const GUID CLSID_TrayDeskBand                         = GUIDOF!TrayDeskBand;
const GUID CLSID_UserNotification                     = GUIDOF!UserNotification;
const GUID CLSID_V1PasswordCredentialProvider         = GUIDOF!V1PasswordCredentialProvider;
const GUID CLSID_V1SmartcardCredentialProvider        = GUIDOF!V1SmartcardCredentialProvider;
const GUID CLSID_V1WinBioCredentialProvider           = GUIDOF!V1WinBioCredentialProvider;
const GUID CLSID_VaultProvider                        = GUIDOF!VaultProvider;
const GUID CLSID_VirtualDesktopManager                = GUIDOF!VirtualDesktopManager;
const GUID CLSID_WebBrowser                           = GUIDOF!WebBrowser;
const GUID CLSID_WebBrowser_V1                        = GUIDOF!WebBrowser_V1;
const GUID CLSID_WebWizardHost                        = GUIDOF!WebWizardHost;
const GUID CLSID_WinBioCredentialProvider             = GUIDOF!WinBioCredentialProvider;

const GUID IID_DFConstraint                                  = GUIDOF!DFConstraint;
const GUID IID_DShellFolderViewEvents                        = GUIDOF!DShellFolderViewEvents;
const GUID IID_DShellNameSpaceEvents                         = GUIDOF!DShellNameSpaceEvents;
const GUID IID_DShellWindowsEvents                           = GUIDOF!DShellWindowsEvents;
const GUID IID_DWebBrowserEvents                             = GUIDOF!DWebBrowserEvents;
const GUID IID_DWebBrowserEvents2                            = GUIDOF!DWebBrowserEvents2;
const GUID IID_Folder                                        = GUIDOF!Folder;
const GUID IID_Folder2                                       = GUIDOF!Folder2;
const GUID IID_Folder3                                       = GUIDOF!Folder3;
const GUID IID_FolderItem                                    = GUIDOF!FolderItem;
const GUID IID_FolderItem2                                   = GUIDOF!FolderItem2;
const GUID IID_FolderItemVerb                                = GUIDOF!FolderItemVerb;
const GUID IID_FolderItemVerbs                               = GUIDOF!FolderItemVerbs;
const GUID IID_FolderItems                                   = GUIDOF!FolderItems;
const GUID IID_FolderItems2                                  = GUIDOF!FolderItems2;
const GUID IID_FolderItems3                                  = GUIDOF!FolderItems3;
const GUID IID_IACList                                       = GUIDOF!IACList;
const GUID IID_IACList2                                      = GUIDOF!IACList2;
const GUID IID_IAccessibilityDockingService                  = GUIDOF!IAccessibilityDockingService;
const GUID IID_IAccessibilityDockingServiceCallback          = GUIDOF!IAccessibilityDockingServiceCallback;
const GUID IID_IAccessibleObject                             = GUIDOF!IAccessibleObject;
const GUID IID_IActionProgress                               = GUIDOF!IActionProgress;
const GUID IID_IActionProgressDialog                         = GUIDOF!IActionProgressDialog;
const GUID IID_IAppActivationUIInfo                          = GUIDOF!IAppActivationUIInfo;
const GUID IID_IAppPublisher                                 = GUIDOF!IAppPublisher;
const GUID IID_IAppVisibility                                = GUIDOF!IAppVisibility;
const GUID IID_IAppVisibilityEvents                          = GUIDOF!IAppVisibilityEvents;
const GUID IID_IApplicationActivationManager                 = GUIDOF!IApplicationActivationManager;
const GUID IID_IApplicationAssociationRegistration           = GUIDOF!IApplicationAssociationRegistration;
const GUID IID_IApplicationAssociationRegistrationUI         = GUIDOF!IApplicationAssociationRegistrationUI;
const GUID IID_IApplicationDesignModeSettings                = GUIDOF!IApplicationDesignModeSettings;
const GUID IID_IApplicationDesignModeSettings2               = GUIDOF!IApplicationDesignModeSettings2;
const GUID IID_IApplicationDestinations                      = GUIDOF!IApplicationDestinations;
const GUID IID_IApplicationDocumentLists                     = GUIDOF!IApplicationDocumentLists;
const GUID IID_IAssocHandler                                 = GUIDOF!IAssocHandler;
const GUID IID_IAssocHandlerInvoker                          = GUIDOF!IAssocHandlerInvoker;
const GUID IID_IAttachmentExecute                            = GUIDOF!IAttachmentExecute;
const GUID IID_IAttachmentExecute2                           = GUIDOF!IAttachmentExecute2;
const GUID IID_IAutoComplete                                 = GUIDOF!IAutoComplete;
const GUID IID_IAutoComplete2                                = GUIDOF!IAutoComplete2;
const GUID IID_IAutoCompleteDropDown                         = GUIDOF!IAutoCompleteDropDown;
const GUID IID_IBandHost                                     = GUIDOF!IBandHost;
const GUID IID_IBandSite                                     = GUIDOF!IBandSite;
const GUID IID_IBannerNotificationHandler                    = GUIDOF!IBannerNotificationHandler;
const GUID IID_IBanneredBar                                  = GUIDOF!IBanneredBar;
const GUID IID_IBrowserFrameOptions                          = GUIDOF!IBrowserFrameOptions;
const GUID IID_IBrowserService                               = GUIDOF!IBrowserService;
const GUID IID_IBrowserService2                              = GUIDOF!IBrowserService2;
const GUID IID_IBrowserService3                              = GUIDOF!IBrowserService3;
const GUID IID_IBrowserService4                              = GUIDOF!IBrowserService4;
const GUID IID_ICDBurn                                       = GUIDOF!ICDBurn;
const GUID IID_ICDBurnExt                                    = GUIDOF!ICDBurnExt;
const GUID IID_ICategorizer                                  = GUIDOF!ICategorizer;
const GUID IID_ICategoryProvider                             = GUIDOF!ICategoryProvider;
const GUID IID_IColumnManager                                = GUIDOF!IColumnManager;
const GUID IID_IColumnProvider                               = GUIDOF!IColumnProvider;
const GUID IID_ICommDlgBrowser                               = GUIDOF!ICommDlgBrowser;
const GUID IID_ICommDlgBrowser2                              = GUIDOF!ICommDlgBrowser2;
const GUID IID_ICommDlgBrowser3                              = GUIDOF!ICommDlgBrowser3;
const GUID IID_IComputerInfoChangeNotify                     = GUIDOF!IComputerInfoChangeNotify;
const GUID IID_IConnectableCredentialProviderCredential      = GUIDOF!IConnectableCredentialProviderCredential;
const GUID IID_IContactManagerInterop                        = GUIDOF!IContactManagerInterop;
const GUID IID_IContextMenu                                  = GUIDOF!IContextMenu;
const GUID IID_IContextMenu2                                 = GUIDOF!IContextMenu2;
const GUID IID_IContextMenu3                                 = GUIDOF!IContextMenu3;
const GUID IID_IContextMenuCB                                = GUIDOF!IContextMenuCB;
const GUID IID_IContextMenuSite                              = GUIDOF!IContextMenuSite;
const GUID IID_ICopyHookA                                    = GUIDOF!ICopyHookA;
const GUID IID_ICopyHookW                                    = GUIDOF!ICopyHookW;
const GUID IID_ICreateProcessInputs                          = GUIDOF!ICreateProcessInputs;
const GUID IID_ICreatingProcess                              = GUIDOF!ICreatingProcess;
const GUID IID_ICredentialProvider                           = GUIDOF!ICredentialProvider;
const GUID IID_ICredentialProviderCredential                 = GUIDOF!ICredentialProviderCredential;
const GUID IID_ICredentialProviderCredential2                = GUIDOF!ICredentialProviderCredential2;
const GUID IID_ICredentialProviderCredentialEvents           = GUIDOF!ICredentialProviderCredentialEvents;
const GUID IID_ICredentialProviderCredentialEvents2          = GUIDOF!ICredentialProviderCredentialEvents2;
const GUID IID_ICredentialProviderCredentialWithFieldOptions = GUIDOF!ICredentialProviderCredentialWithFieldOptions;
const GUID IID_ICredentialProviderEvents                     = GUIDOF!ICredentialProviderEvents;
const GUID IID_ICredentialProviderFilter                     = GUIDOF!ICredentialProviderFilter;
const GUID IID_ICredentialProviderSetUserArray               = GUIDOF!ICredentialProviderSetUserArray;
const GUID IID_ICredentialProviderUser                       = GUIDOF!ICredentialProviderUser;
const GUID IID_ICredentialProviderUserArray                  = GUIDOF!ICredentialProviderUserArray;
const GUID IID_ICurrentItem                                  = GUIDOF!ICurrentItem;
const GUID IID_ICurrentWorkingDirectory                      = GUIDOF!ICurrentWorkingDirectory;
const GUID IID_ICustomDestinationList                        = GUIDOF!ICustomDestinationList;
const GUID IID_IDataObjectAsyncCapability                    = GUIDOF!IDataObjectAsyncCapability;
const GUID IID_IDataObjectProvider                           = GUIDOF!IDataObjectProvider;
const GUID IID_IDataTransferManagerInterop                   = GUIDOF!IDataTransferManagerInterop;
const GUID IID_IDefaultExtractIconInit                       = GUIDOF!IDefaultExtractIconInit;
const GUID IID_IDefaultFolderMenuInitialize                  = GUIDOF!IDefaultFolderMenuInitialize;
const GUID IID_IDelegateFolder                               = GUIDOF!IDelegateFolder;
const GUID IID_IDelegateItem                                 = GUIDOF!IDelegateItem;
const GUID IID_IDeskBand                                     = GUIDOF!IDeskBand;
const GUID IID_IDeskBand2                                    = GUIDOF!IDeskBand2;
const GUID IID_IDeskBandInfo                                 = GUIDOF!IDeskBandInfo;
const GUID IID_IDeskBar                                      = GUIDOF!IDeskBar;
const GUID IID_IDeskBarClient                                = GUIDOF!IDeskBarClient;
const GUID IID_IDesktopGadget                                = GUIDOF!IDesktopGadget;
const GUID IID_IDesktopWallpaper                             = GUIDOF!IDesktopWallpaper;
const GUID IID_IDestinationStreamFactory                     = GUIDOF!IDestinationStreamFactory;
const GUID IID_IDisplayItem                                  = GUIDOF!IDisplayItem;
const GUID IID_IDocViewSite                                  = GUIDOF!IDocViewSite;
const GUID IID_IDockingWindow                                = GUIDOF!IDockingWindow;
const GUID IID_IDockingWindowFrame                           = GUIDOF!IDockingWindowFrame;
const GUID IID_IDockingWindowSite                            = GUIDOF!IDockingWindowSite;
const GUID IID_IDragSourceHelper                             = GUIDOF!IDragSourceHelper;
const GUID IID_IDragSourceHelper2                            = GUIDOF!IDragSourceHelper2;
const GUID IID_IDropTargetHelper                             = GUIDOF!IDropTargetHelper;
const GUID IID_IDynamicHWHandler                             = GUIDOF!IDynamicHWHandler;
const GUID IID_IEnumACString                                 = GUIDOF!IEnumACString;
const GUID IID_IEnumAssocHandlers                            = GUIDOF!IEnumAssocHandlers;
const GUID IID_IEnumExplorerCommand                          = GUIDOF!IEnumExplorerCommand;
const GUID IID_IEnumExtraSearch                              = GUIDOF!IEnumExtraSearch;
const GUID IID_IEnumFullIDList                               = GUIDOF!IEnumFullIDList;
const GUID IID_IEnumHLITEM                                   = GUIDOF!IEnumHLITEM;
const GUID IID_IEnumIDList                                   = GUIDOF!IEnumIDList;
const GUID IID_IEnumObjects                                  = GUIDOF!IEnumObjects;
const GUID IID_IEnumPublishedApps                            = GUIDOF!IEnumPublishedApps;
const GUID IID_IEnumReadyCallback                            = GUIDOF!IEnumReadyCallback;
const GUID IID_IEnumResources                                = GUIDOF!IEnumResources;
const GUID IID_IEnumShellItems                               = GUIDOF!IEnumShellItems;
const GUID IID_IEnumSyncMgrConflict                          = GUIDOF!IEnumSyncMgrConflict;
const GUID IID_IEnumSyncMgrEvents                            = GUIDOF!IEnumSyncMgrEvents;
const GUID IID_IEnumSyncMgrSyncItems                         = GUIDOF!IEnumSyncMgrSyncItems;
const GUID IID_IEnumTravelLogEntry                           = GUIDOF!IEnumTravelLogEntry;
const GUID IID_IEnumerableView                               = GUIDOF!IEnumerableView;
const GUID IID_IExecuteCommand                               = GUIDOF!IExecuteCommand;
const GUID IID_IExecuteCommandApplicationHostEnvironment     = GUIDOF!IExecuteCommandApplicationHostEnvironment;
const GUID IID_IExecuteCommandHost                           = GUIDOF!IExecuteCommandHost;
const GUID IID_IExpDispSupport                               = GUIDOF!IExpDispSupport;
const GUID IID_IExpDispSupportXP                             = GUIDOF!IExpDispSupportXP;
const GUID IID_IExplorerBrowser                              = GUIDOF!IExplorerBrowser;
const GUID IID_IExplorerBrowserEvents                        = GUIDOF!IExplorerBrowserEvents;
const GUID IID_IExplorerCommand                              = GUIDOF!IExplorerCommand;
const GUID IID_IExplorerCommandProvider                      = GUIDOF!IExplorerCommandProvider;
const GUID IID_IExplorerCommandState                         = GUIDOF!IExplorerCommandState;
const GUID IID_IExplorerPaneVisibility                       = GUIDOF!IExplorerPaneVisibility;
const GUID IID_IExtensionServices                            = GUIDOF!IExtensionServices;
const GUID IID_IExtractIconA                                 = GUIDOF!IExtractIconA;
const GUID IID_IExtractIconW                                 = GUIDOF!IExtractIconW;
const GUID IID_IExtractImage                                 = GUIDOF!IExtractImage;
const GUID IID_IExtractImage2                                = GUIDOF!IExtractImage2;
const GUID IID_IFileDialog                                   = GUIDOF!IFileDialog;
const GUID IID_IFileDialog2                                  = GUIDOF!IFileDialog2;
const GUID IID_IFileDialogControlEvents                      = GUIDOF!IFileDialogControlEvents;
const GUID IID_IFileDialogCustomize                          = GUIDOF!IFileDialogCustomize;
const GUID IID_IFileDialogEvents                             = GUIDOF!IFileDialogEvents;
const GUID IID_IFileIsInUse                                  = GUIDOF!IFileIsInUse;
const GUID IID_IFileOpenDialog                               = GUIDOF!IFileOpenDialog;
const GUID IID_IFileOperation                                = GUIDOF!IFileOperation;
const GUID IID_IFileOperation2                               = GUIDOF!IFileOperation2;
const GUID IID_IFileOperationProgressSink                    = GUIDOF!IFileOperationProgressSink;
const GUID IID_IFileSaveDialog                               = GUIDOF!IFileSaveDialog;
const GUID IID_IFileSearchBand                               = GUIDOF!IFileSearchBand;
const GUID IID_IFileSyncMergeHandler                         = GUIDOF!IFileSyncMergeHandler;
const GUID IID_IFileSystemBindData                           = GUIDOF!IFileSystemBindData;
const GUID IID_IFileSystemBindData2                          = GUIDOF!IFileSystemBindData2;
const GUID IID_IFolderBandPriv                               = GUIDOF!IFolderBandPriv;
const GUID IID_IFolderFilter                                 = GUIDOF!IFolderFilter;
const GUID IID_IFolderFilterSite                             = GUIDOF!IFolderFilterSite;
const GUID IID_IFolderView                                   = GUIDOF!IFolderView;
const GUID IID_IFolderView2                                  = GUIDOF!IFolderView2;
const GUID IID_IFolderViewHost                               = GUIDOF!IFolderViewHost;
const GUID IID_IFolderViewOC                                 = GUIDOF!IFolderViewOC;
const GUID IID_IFolderViewOptions                            = GUIDOF!IFolderViewOptions;
const GUID IID_IFolderViewSettings                           = GUIDOF!IFolderViewSettings;
const GUID IID_IFrameworkInputPane                           = GUIDOF!IFrameworkInputPane;
const GUID IID_IFrameworkInputPaneHandler                    = GUIDOF!IFrameworkInputPaneHandler;
const GUID IID_IGetServiceIds                                = GUIDOF!IGetServiceIds;
const GUID IID_IHWEventHandler                               = GUIDOF!IHWEventHandler;
const GUID IID_IHWEventHandler2                              = GUIDOF!IHWEventHandler2;
const GUID IID_IHandlerActivationHost                        = GUIDOF!IHandlerActivationHost;
const GUID IID_IHandlerInfo                                  = GUIDOF!IHandlerInfo;
const GUID IID_IHandlerInfo2                                 = GUIDOF!IHandlerInfo2;
const GUID IID_IHlink                                        = GUIDOF!IHlink;
const GUID IID_IHlinkBrowseContext                           = GUIDOF!IHlinkBrowseContext;
const GUID IID_IHlinkFrame                                   = GUIDOF!IHlinkFrame;
const GUID IID_IHlinkSite                                    = GUIDOF!IHlinkSite;
const GUID IID_IHlinkTarget                                  = GUIDOF!IHlinkTarget;
const GUID IID_IHomeGroup                                    = GUIDOF!IHomeGroup;
const GUID IID_IIOCancelInformation                          = GUIDOF!IIOCancelInformation;
const GUID IID_IIdentityName                                 = GUIDOF!IIdentityName;
const GUID IID_IImageRecompress                              = GUIDOF!IImageRecompress;
const GUID IID_IInitializeCommand                            = GUIDOF!IInitializeCommand;
const GUID IID_IInitializeNetworkFolder                      = GUIDOF!IInitializeNetworkFolder;
const GUID IID_IInitializeObject                             = GUIDOF!IInitializeObject;
const GUID IID_IInitializeWithBindCtx                        = GUIDOF!IInitializeWithBindCtx;
const GUID IID_IInitializeWithItem                           = GUIDOF!IInitializeWithItem;
const GUID IID_IInitializeWithPropertyStore                  = GUIDOF!IInitializeWithPropertyStore;
const GUID IID_IInitializeWithWindow                         = GUIDOF!IInitializeWithWindow;
const GUID IID_IInputObject                                  = GUIDOF!IInputObject;
const GUID IID_IInputObject2                                 = GUIDOF!IInputObject2;
const GUID IID_IInputObjectSite                              = GUIDOF!IInputObjectSite;
const GUID IID_IInputPaneAnimationCoordinator                = GUIDOF!IInputPaneAnimationCoordinator;
const GUID IID_IInputPanelConfiguration                      = GUIDOF!IInputPanelConfiguration;
const GUID IID_IInputPanelInvocationConfiguration            = GUIDOF!IInputPanelInvocationConfiguration;
const GUID IID_IInsertItem                                   = GUIDOF!IInsertItem;
const GUID IID_IItemNameLimits                               = GUIDOF!IItemNameLimits;
const GUID IID_IKnownFolder                                  = GUIDOF!IKnownFolder;
const GUID IID_IKnownFolderManager                           = GUIDOF!IKnownFolderManager;
const GUID IID_ILaunchSourceAppUserModelId                   = GUIDOF!ILaunchSourceAppUserModelId;
const GUID IID_ILaunchSourceViewSizePreference               = GUIDOF!ILaunchSourceViewSizePreference;
const GUID IID_ILaunchTargetMonitor                          = GUIDOF!ILaunchTargetMonitor;
const GUID IID_ILaunchTargetViewSizePreference               = GUIDOF!ILaunchTargetViewSizePreference;
const GUID IID_ILaunchUIContext                              = GUIDOF!ILaunchUIContext;
const GUID IID_ILaunchUIContextProvider                      = GUIDOF!ILaunchUIContextProvider;
const GUID IID_IMenuBand                                     = GUIDOF!IMenuBand;
const GUID IID_IMenuPopup                                    = GUIDOF!IMenuPopup;
const GUID IID_IModalWindow                                  = GUIDOF!IModalWindow;
const GUID IID_INameSpaceTreeAccessible                      = GUIDOF!INameSpaceTreeAccessible;
const GUID IID_INameSpaceTreeControl                         = GUIDOF!INameSpaceTreeControl;
const GUID IID_INameSpaceTreeControl2                        = GUIDOF!INameSpaceTreeControl2;
const GUID IID_INameSpaceTreeControlCustomDraw               = GUIDOF!INameSpaceTreeControlCustomDraw;
const GUID IID_INameSpaceTreeControlDropHandler              = GUIDOF!INameSpaceTreeControlDropHandler;
const GUID IID_INameSpaceTreeControlEvents                   = GUIDOF!INameSpaceTreeControlEvents;
const GUID IID_INameSpaceTreeControlFolderCapabilities       = GUIDOF!INameSpaceTreeControlFolderCapabilities;
const GUID IID_INamedPropertyBag                             = GUIDOF!INamedPropertyBag;
const GUID IID_INamespaceWalk                                = GUIDOF!INamespaceWalk;
const GUID IID_INamespaceWalkCB                              = GUIDOF!INamespaceWalkCB;
const GUID IID_INamespaceWalkCB2                             = GUIDOF!INamespaceWalkCB2;
const GUID IID_INetworkFolderInternal                        = GUIDOF!INetworkFolderInternal;
const GUID IID_INewMenuClient                                = GUIDOF!INewMenuClient;
const GUID IID_INewShortcutHookA                             = GUIDOF!INewShortcutHookA;
const GUID IID_INewShortcutHookW                             = GUIDOF!INewShortcutHookW;
const GUID IID_INewWDEvents                                  = GUIDOF!INewWDEvents;
const GUID IID_INewWindowManager                             = GUIDOF!INewWindowManager;
const GUID IID_INotifyReplica                                = GUIDOF!INotifyReplica;
const GUID IID_IObjMgr                                       = GUIDOF!IObjMgr;
const GUID IID_IObjectProvider                               = GUIDOF!IObjectProvider;
const GUID IID_IObjectWithAppUserModelID                     = GUIDOF!IObjectWithAppUserModelID;
const GUID IID_IObjectWithBackReferences                     = GUIDOF!IObjectWithBackReferences;
const GUID IID_IObjectWithCancelEvent                        = GUIDOF!IObjectWithCancelEvent;
const GUID IID_IObjectWithFolderEnumMode                     = GUIDOF!IObjectWithFolderEnumMode;
const GUID IID_IObjectWithPackageFullName                    = GUIDOF!IObjectWithPackageFullName;
const GUID IID_IObjectWithProgID                             = GUIDOF!IObjectWithProgID;
const GUID IID_IObjectWithSelection                          = GUIDOF!IObjectWithSelection;
const GUID IID_IOpenControlPanel                             = GUIDOF!IOpenControlPanel;
const GUID IID_IOpenSearchSource                             = GUIDOF!IOpenSearchSource;
const GUID IID_IOperationsProgressDialog                     = GUIDOF!IOperationsProgressDialog;
const GUID IID_IPackageDebugSettings                         = GUIDOF!IPackageDebugSettings;
const GUID IID_IPackageDebugSettings2                        = GUIDOF!IPackageDebugSettings2;
const GUID IID_IPackageExecutionStateChangeNotification      = GUIDOF!IPackageExecutionStateChangeNotification;
const GUID IID_IParentAndItem                                = GUIDOF!IParentAndItem;
const GUID IID_IParseAndCreateItem                           = GUIDOF!IParseAndCreateItem;
const GUID IID_IPersistFolder                                = GUIDOF!IPersistFolder;
const GUID IID_IPersistFolder2                               = GUIDOF!IPersistFolder2;
const GUID IID_IPersistFolder3                               = GUIDOF!IPersistFolder3;
const GUID IID_IPersistIDList                                = GUIDOF!IPersistIDList;
const GUID IID_IPreviewHandler                               = GUIDOF!IPreviewHandler;
const GUID IID_IPreviewHandlerFrame                          = GUIDOF!IPreviewHandlerFrame;
const GUID IID_IPreviewHandlerVisuals                        = GUIDOF!IPreviewHandlerVisuals;
const GUID IID_IPreviewItem                                  = GUIDOF!IPreviewItem;
const GUID IID_IPreviousVersionsInfo                         = GUIDOF!IPreviousVersionsInfo;
const GUID IID_IProfferService                               = GUIDOF!IProfferService;
const GUID IID_IProgressDialog                               = GUIDOF!IProgressDialog;
const GUID IID_IPropertyKeyStore                             = GUIDOF!IPropertyKeyStore;
const GUID IID_IPublishedApp                                 = GUIDOF!IPublishedApp;
const GUID IID_IPublishedApp2                                = GUIDOF!IPublishedApp2;
const GUID IID_IPublishingWizard                             = GUIDOF!IPublishingWizard;
const GUID IID_IQueryAssociations                            = GUIDOF!IQueryAssociations;
const GUID IID_IQueryCancelAutoPlay                          = GUIDOF!IQueryCancelAutoPlay;
const GUID IID_IQueryCodePage                                = GUIDOF!IQueryCodePage;
const GUID IID_IQueryContinue                                = GUIDOF!IQueryContinue;
const GUID IID_IQueryContinueWithStatus                      = GUIDOF!IQueryContinueWithStatus;
const GUID IID_IQueryInfo                                    = GUIDOF!IQueryInfo;
const GUID IID_IRegTreeItem                                  = GUIDOF!IRegTreeItem;
const GUID IID_IRelatedItem                                  = GUIDOF!IRelatedItem;
const GUID IID_IRemoteComputer                               = GUIDOF!IRemoteComputer;
const GUID IID_IResolveShellLink                             = GUIDOF!IResolveShellLink;
const GUID IID_IResultsFolder                                = GUIDOF!IResultsFolder;
const GUID IID_IRunnableTask                                 = GUIDOF!IRunnableTask;
const GUID IID_IScriptErrorList                              = GUIDOF!IScriptErrorList;
const GUID IID_ISearchBoxInfo                                = GUIDOF!ISearchBoxInfo;
const GUID IID_ISearchContext                                = GUIDOF!ISearchContext;
const GUID IID_ISearchFolderItemFactory                      = GUIDOF!ISearchFolderItemFactory;
const GUID IID_ISharedBitmap                                 = GUIDOF!ISharedBitmap;
const GUID IID_ISharingConfigurationManager                  = GUIDOF!ISharingConfigurationManager;
const GUID IID_IShellApp                                     = GUIDOF!IShellApp;
const GUID IID_IShellBrowser                                 = GUIDOF!IShellBrowser;
const GUID IID_IShellChangeNotify                            = GUIDOF!IShellChangeNotify;
const GUID IID_IShellDetails                                 = GUIDOF!IShellDetails;
const GUID IID_IShellDispatch                                = GUIDOF!IShellDispatch;
const GUID IID_IShellDispatch2                               = GUIDOF!IShellDispatch2;
const GUID IID_IShellDispatch3                               = GUIDOF!IShellDispatch3;
const GUID IID_IShellDispatch4                               = GUIDOF!IShellDispatch4;
const GUID IID_IShellDispatch5                               = GUIDOF!IShellDispatch5;
const GUID IID_IShellDispatch6                               = GUIDOF!IShellDispatch6;
const GUID IID_IShellExtInit                                 = GUIDOF!IShellExtInit;
const GUID IID_IShellFavoritesNameSpace                      = GUIDOF!IShellFavoritesNameSpace;
const GUID IID_IShellFolder                                  = GUIDOF!IShellFolder;
const GUID IID_IShellFolder2                                 = GUIDOF!IShellFolder2;
const GUID IID_IShellFolderBand                              = GUIDOF!IShellFolderBand;
const GUID IID_IShellFolderView                              = GUIDOF!IShellFolderView;
const GUID IID_IShellFolderViewCB                            = GUIDOF!IShellFolderViewCB;
const GUID IID_IShellFolderViewDual                          = GUIDOF!IShellFolderViewDual;
const GUID IID_IShellFolderViewDual2                         = GUIDOF!IShellFolderViewDual2;
const GUID IID_IShellFolderViewDual3                         = GUIDOF!IShellFolderViewDual3;
const GUID IID_IShellIcon                                    = GUIDOF!IShellIcon;
const GUID IID_IShellIconOverlay                             = GUIDOF!IShellIconOverlay;
const GUID IID_IShellIconOverlayIdentifier                   = GUIDOF!IShellIconOverlayIdentifier;
const GUID IID_IShellIconOverlayManager                      = GUIDOF!IShellIconOverlayManager;
const GUID IID_IShellImageData                               = GUIDOF!IShellImageData;
const GUID IID_IShellImageDataAbort                          = GUIDOF!IShellImageDataAbort;
const GUID IID_IShellImageDataFactory                        = GUIDOF!IShellImageDataFactory;
const GUID IID_IShellItem                                    = GUIDOF!IShellItem;
const GUID IID_IShellItem2                                   = GUIDOF!IShellItem2;
const GUID IID_IShellItemArray                               = GUIDOF!IShellItemArray;
const GUID IID_IShellItemFilter                              = GUIDOF!IShellItemFilter;
const GUID IID_IShellItemImageFactory                        = GUIDOF!IShellItemImageFactory;
const GUID IID_IShellItemResources                           = GUIDOF!IShellItemResources;
const GUID IID_IShellLibrary                                 = GUIDOF!IShellLibrary;
const GUID IID_IShellLinkA                                   = GUIDOF!IShellLinkA;
const GUID IID_IShellLinkDataList                            = GUIDOF!IShellLinkDataList;
const GUID IID_IShellLinkDual                                = GUIDOF!IShellLinkDual;
const GUID IID_IShellLinkDual2                               = GUIDOF!IShellLinkDual2;
const GUID IID_IShellLinkW                                   = GUIDOF!IShellLinkW;
const GUID IID_IShellMenu                                    = GUIDOF!IShellMenu;
const GUID IID_IShellMenuCallback                            = GUIDOF!IShellMenuCallback;
const GUID IID_IShellNameSpace                               = GUIDOF!IShellNameSpace;
const GUID IID_IShellPropSheetExt                            = GUIDOF!IShellPropSheetExt;
const GUID IID_IShellRunDll                                  = GUIDOF!IShellRunDll;
const GUID IID_IShellService                                 = GUIDOF!IShellService;
const GUID IID_IShellTaskScheduler                           = GUIDOF!IShellTaskScheduler;
const GUID IID_IShellUIHelper                                = GUIDOF!IShellUIHelper;
const GUID IID_IShellUIHelper2                               = GUIDOF!IShellUIHelper2;
const GUID IID_IShellUIHelper3                               = GUIDOF!IShellUIHelper3;
const GUID IID_IShellUIHelper4                               = GUIDOF!IShellUIHelper4;
const GUID IID_IShellUIHelper5                               = GUIDOF!IShellUIHelper5;
const GUID IID_IShellUIHelper6                               = GUIDOF!IShellUIHelper6;
const GUID IID_IShellUIHelper7                               = GUIDOF!IShellUIHelper7;
const GUID IID_IShellUIHelper8                               = GUIDOF!IShellUIHelper8;
const GUID IID_IShellUIHelper9                               = GUIDOF!IShellUIHelper9;
const GUID IID_IShellView                                    = GUIDOF!IShellView;
const GUID IID_IShellView2                                   = GUIDOF!IShellView2;
const GUID IID_IShellView3                                   = GUIDOF!IShellView3;
const GUID IID_IShellWindows                                 = GUIDOF!IShellWindows;
const GUID IID_ISortColumnArray                              = GUIDOF!ISortColumnArray;
const GUID IID_IStartMenuPinnedList                          = GUIDOF!IStartMenuPinnedList;
const GUID IID_IStaticVerbProvider                           = GUIDOF!IStaticVerbProvider;
const GUID IID_IStorageProviderBanners                       = GUIDOF!IStorageProviderBanners;
const GUID IID_IStorageProviderCopyHook                      = GUIDOF!IStorageProviderCopyHook;
const GUID IID_IStorageProviderHandler                       = GUIDOF!IStorageProviderHandler;
const GUID IID_IStorageProviderPropertyHandler               = GUIDOF!IStorageProviderPropertyHandler;
const GUID IID_IStreamAsync                                  = GUIDOF!IStreamAsync;
const GUID IID_IStreamUnbufferedInfo                         = GUIDOF!IStreamUnbufferedInfo;
const GUID IID_ISuspensionDependencyManager                  = GUIDOF!ISuspensionDependencyManager;
const GUID IID_ISyncMgrConflict                              = GUIDOF!ISyncMgrConflict;
const GUID IID_ISyncMgrConflictFolder                        = GUIDOF!ISyncMgrConflictFolder;
const GUID IID_ISyncMgrConflictItems                         = GUIDOF!ISyncMgrConflictItems;
const GUID IID_ISyncMgrConflictPresenter                     = GUIDOF!ISyncMgrConflictPresenter;
const GUID IID_ISyncMgrConflictResolutionItems               = GUIDOF!ISyncMgrConflictResolutionItems;
const GUID IID_ISyncMgrConflictResolveInfo                   = GUIDOF!ISyncMgrConflictResolveInfo;
const GUID IID_ISyncMgrConflictStore                         = GUIDOF!ISyncMgrConflictStore;
const GUID IID_ISyncMgrControl                               = GUIDOF!ISyncMgrControl;
const GUID IID_ISyncMgrEnumItems                             = GUIDOF!ISyncMgrEnumItems;
const GUID IID_ISyncMgrEvent                                 = GUIDOF!ISyncMgrEvent;
const GUID IID_ISyncMgrEventLinkUIOperation                  = GUIDOF!ISyncMgrEventLinkUIOperation;
const GUID IID_ISyncMgrEventStore                            = GUIDOF!ISyncMgrEventStore;
const GUID IID_ISyncMgrHandler                               = GUIDOF!ISyncMgrHandler;
const GUID IID_ISyncMgrHandlerCollection                     = GUIDOF!ISyncMgrHandlerCollection;
const GUID IID_ISyncMgrHandlerInfo                           = GUIDOF!ISyncMgrHandlerInfo;
const GUID IID_ISyncMgrRegister                              = GUIDOF!ISyncMgrRegister;
const GUID IID_ISyncMgrResolutionHandler                     = GUIDOF!ISyncMgrResolutionHandler;
const GUID IID_ISyncMgrScheduleWizardUIOperation             = GUIDOF!ISyncMgrScheduleWizardUIOperation;
const GUID IID_ISyncMgrSessionCreator                        = GUIDOF!ISyncMgrSessionCreator;
const GUID IID_ISyncMgrSyncCallback                          = GUIDOF!ISyncMgrSyncCallback;
const GUID IID_ISyncMgrSyncItem                              = GUIDOF!ISyncMgrSyncItem;
const GUID IID_ISyncMgrSyncItemContainer                     = GUIDOF!ISyncMgrSyncItemContainer;
const GUID IID_ISyncMgrSyncItemInfo                          = GUIDOF!ISyncMgrSyncItemInfo;
const GUID IID_ISyncMgrSyncResult                            = GUIDOF!ISyncMgrSyncResult;
const GUID IID_ISyncMgrSynchronize                           = GUIDOF!ISyncMgrSynchronize;
const GUID IID_ISyncMgrSynchronizeCallback                   = GUIDOF!ISyncMgrSynchronizeCallback;
const GUID IID_ISyncMgrSynchronizeInvoke                     = GUIDOF!ISyncMgrSynchronizeInvoke;
const GUID IID_ISyncMgrUIOperation                           = GUIDOF!ISyncMgrUIOperation;
const GUID IID_ITaskbarList                                  = GUIDOF!ITaskbarList;
const GUID IID_ITaskbarList2                                 = GUIDOF!ITaskbarList2;
const GUID IID_ITaskbarList3                                 = GUIDOF!ITaskbarList3;
const GUID IID_ITaskbarList4                                 = GUIDOF!ITaskbarList4;
const GUID IID_IThumbnailCache                               = GUIDOF!IThumbnailCache;
const GUID IID_IThumbnailCachePrimer                         = GUIDOF!IThumbnailCachePrimer;
const GUID IID_IThumbnailCapture                             = GUIDOF!IThumbnailCapture;
const GUID IID_IThumbnailHandlerFactory                      = GUIDOF!IThumbnailHandlerFactory;
const GUID IID_IThumbnailProvider                            = GUIDOF!IThumbnailProvider;
const GUID IID_IThumbnailSettings                            = GUIDOF!IThumbnailSettings;
const GUID IID_IThumbnailStreamCache                         = GUIDOF!IThumbnailStreamCache;
const GUID IID_ITrackShellMenu                               = GUIDOF!ITrackShellMenu;
const GUID IID_ITranscodeImage                               = GUIDOF!ITranscodeImage;
const GUID IID_ITransferAdviseSink                           = GUIDOF!ITransferAdviseSink;
const GUID IID_ITransferDestination                          = GUIDOF!ITransferDestination;
const GUID IID_ITransferMediumItem                           = GUIDOF!ITransferMediumItem;
const GUID IID_ITransferSource                               = GUIDOF!ITransferSource;
const GUID IID_ITravelEntry                                  = GUIDOF!ITravelEntry;
const GUID IID_ITravelLog                                    = GUIDOF!ITravelLog;
const GUID IID_ITravelLogClient                              = GUIDOF!ITravelLogClient;
const GUID IID_ITravelLogEntry                               = GUIDOF!ITravelLogEntry;
const GUID IID_ITravelLogStg                                 = GUIDOF!ITravelLogStg;
const GUID IID_ITrayDeskBand                                 = GUIDOF!ITrayDeskBand;
const GUID IID_IURLSearchHook                                = GUIDOF!IURLSearchHook;
const GUID IID_IURLSearchHook2                               = GUIDOF!IURLSearchHook2;
const GUID IID_IUniformResourceLocatorA                      = GUIDOF!IUniformResourceLocatorA;
const GUID IID_IUniformResourceLocatorW                      = GUIDOF!IUniformResourceLocatorW;
const GUID IID_IUpdateIDList                                 = GUIDOF!IUpdateIDList;
const GUID IID_IUseToBrowseItem                              = GUIDOF!IUseToBrowseItem;
const GUID IID_IUserAccountChangeCallback                    = GUIDOF!IUserAccountChangeCallback;
const GUID IID_IUserNotification                             = GUIDOF!IUserNotification;
const GUID IID_IUserNotification2                            = GUIDOF!IUserNotification2;
const GUID IID_IUserNotificationCallback                     = GUIDOF!IUserNotificationCallback;
const GUID IID_IViewStateIdentityItem                        = GUIDOF!IViewStateIdentityItem;
const GUID IID_IVirtualDesktopManager                        = GUIDOF!IVirtualDesktopManager;
const GUID IID_IVisualProperties                             = GUIDOF!IVisualProperties;
const GUID IID_IWebBrowser                                   = GUIDOF!IWebBrowser;
const GUID IID_IWebBrowser2                                  = GUIDOF!IWebBrowser2;
const GUID IID_IWebBrowserApp                                = GUIDOF!IWebBrowserApp;
const GUID IID_IWebWizardExtension                           = GUIDOF!IWebWizardExtension;
const GUID IID_IWebWizardHost                                = GUIDOF!IWebWizardHost;
const GUID IID_IWebWizardHost2                               = GUIDOF!IWebWizardHost2;
const GUID IID_IWizardExtension                              = GUIDOF!IWizardExtension;
const GUID IID_IWizardSite                                   = GUIDOF!IWizardSite;
