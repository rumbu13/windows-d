// Written in the D programming language.

module windows.win32.web.internetexplorer;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, FILETIME, HANDLE, HINSTANCE,
                                         HRESULT, HWND, LPARAM, LUID, POINT, PSTR,
                                         PWSTR, RECT, SIZE, VARIANT_BOOL, WPARAM;
public import windows.win32.graphics.directdraw : IDirectDrawSurface;
public import windows.win32.graphics.dxgi.common : DXGI_FORMAT, DXGI_MODE_ROTATION;
public import windows.win32.graphics.gdi : HBITMAP, RGBQUAD;
public import windows.win32.security : SECURITY_ATTRIBUTES;
public import windows.win32.storage.filesystem : GET_FILEEX_INFO_LEVELS, WIN32_FIND_DATAA;
public import windows.win32.system.com : BINDINFO, IBindCtx, IBindStatusCallback,
                                         IDispatch, IMoniker, IPersist, IStream,
                                         IUnknown, IUri;
public import windows.win32.system.ole : IOleCommandTarget, IOleContainer;
public import windows.win32.system.registry : HKEY;
public import windows.win32.system.threading : PROCESS_INFORMATION;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.system.winrt : IInspectable;
public import windows.win32.ui.windowsandmessaging : HICON;
public import windows.win32.web.mshtml : IHTMLDocument2, IHTMLElement, IHTMLWindow2,
                                         VIEW_OBJECT_ALPHA_MODE, styleMsTouchAction;

extern(Windows) @nogc nothrow:


// Enums


enum ExtensionValidationContexts : int
{
    ExtensionValidationContextNone    = 0x00000000,
    ExtensionValidationContextDynamic = 0x00000001,
    ExtensionValidationContextParsed  = 0x00000002,
}

enum ExtensionValidationResults : int
{
    ExtensionValidationResultNone             = 0x00000000,
    ExtensionValidationResultDoNotInstantiate = 0x00000001,
    ExtensionValidationResultArrestPageLoad   = 0x00000002,
}

alias FINDFRAME_FLAGS = int;
enum : int
{
    FINDFRAME_NONE              = 0x00000000,
    FINDFRAME_JUSTTESTEXISTENCE = 0x00000001,
    FINDFRAME_INTERNAL          = 0x80000000,
}

alias FRAMEOPTIONS_FLAGS = int;
enum : int
{
    FRAMEOPTIONS_SCROLL_YES  = 0x00000001,
    FRAMEOPTIONS_SCROLL_NO   = 0x00000002,
    FRAMEOPTIONS_SCROLL_AUTO = 0x00000004,
    FRAMEOPTIONS_NORESIZE    = 0x00000008,
    FRAMEOPTIONS_NO3DBORDER  = 0x00000010,
    FRAMEOPTIONS_DESKTOP     = 0x00000020,
    FRAMEOPTIONS_BROWSERBAND = 0x00000040,
}

alias NAVIGATEFRAME_FLAGS = int;
enum : int
{
    NAVIGATEFRAME_FL_RECORD                   = 0x00000001,
    NAVIGATEFRAME_FL_POST                     = 0x00000002,
    NAVIGATEFRAME_FL_NO_DOC_CACHE             = 0x00000004,
    NAVIGATEFRAME_FL_NO_IMAGE_CACHE           = 0x00000008,
    NAVIGATEFRAME_FL_AUTH_FAIL_CACHE_OK       = 0x00000010,
    NAVIGATEFRAME_FL_SENDING_FROM_FORM        = 0x00000020,
    NAVIGATEFRAME_FL_REALLY_SENDING_FROM_FORM = 0x00000040,
}

alias MEDIA_ACTIVITY_NOTIFY_TYPE = int;
enum : int
{
    MediaPlayback  = 0x00000000,
    MediaRecording = 0x00000001,
    MediaCasting   = 0x00000002,
}

alias SCROLLABLECONTEXTMENU_PLACEMENT = int;
enum : int
{
    SCMP_TOP    = 0x00000000,
    SCMP_BOTTOM = 0x00000001,
    SCMP_LEFT   = 0x00000002,
    SCMP_RIGHT  = 0x00000003,
    SCMP_FULL   = 0x00000004,
}

alias INTERNETEXPLORERCONFIGURATION = int;
enum : int
{
    INTERNETEXPLORERCONFIGURATION_HOST            = 0x00000001,
    INTERNETEXPLORERCONFIGURATION_WEB_DRIVER      = 0x00000002,
    INTERNETEXPLORERCONFIGURATION_WEB_DRIVER_EDGE = 0x00000004,
}

alias IELAUNCHOPTION_FLAGS = int;
enum : int
{
    IELAUNCHOPTION_SCRIPTDEBUG  = 0x00000001,
    IELAUNCHOPTION_FORCE_COMPAT = 0x00000002,
    IELAUNCHOPTION_FORCE_EDGE   = 0x00000004,
    IELAUNCHOPTION_LOCK_ENGINE  = 0x00000008,
}

enum OpenServiceErrors : int
{
    OS_E_NOTFOUND     = 0x80030002,
    OS_E_NOTSUPPORTED = 0x80004021,
    OS_E_CANCELLED    = 0x80002ef1,
    OS_E_GPDISABLED   = 0xc00d0bdc,
}

enum OpenServiceActivityContentType : int
{
    ActivityContentNone      = 0xffffffff,
    ActivityContentDocument  = 0x00000000,
    ActivityContentSelection = 0x00000001,
    ActivityContentLink      = 0x00000002,
    ActivityContentCount     = 0x00000003,
}

alias ADDURL_FLAG = int;
enum : int
{
    ADDURL_FIRST                = 0x00000000,
    ADDURL_ADDTOHISTORYANDCACHE = 0x00000000,
    ADDURL_ADDTOCACHE           = 0x00000001,
    ADDURL_Max                  = 0x7fffffff,
}

// Constants


enum : int
{
    DISPID_AMBIENT_OFFLINEIFNOTCONNECTED = 0xffffea83,
    DISPID_AMBIENT_SILENT                = 0xffffea82,
}

enum uint DISPID_BEFORENAVIGATE = 0x00000064U;
enum uint DISPID_NAVIGATECOMPLETE = 0x00000065U;
enum uint DISPID_STATUSTEXTCHANGE = 0x00000066U;

enum : uint
{
    DISPID_QUIT             = 0x00000067U,
    DISPID_DOWNLOADCOMPLETE = 0x00000068U,
}

enum uint DISPID_COMMANDSTATECHANGE = 0x00000069U;
enum uint DISPID_DOWNLOADBEGIN = 0x0000006aU;

enum : uint
{
    DISPID_NEWWINDOW      = 0x0000006bU,
    DISPID_PROGRESSCHANGE = 0x0000006cU,
}

enum : uint
{
    DISPID_WINDOWMOVE     = 0x0000006dU,
    DISPID_WINDOWRESIZE   = 0x0000006eU,
    DISPID_WINDOWACTIVATE = 0x0000006fU,
}

enum uint DISPID_PROPERTYCHANGE = 0x00000070U;

enum : uint
{
    DISPID_TITLECHANGE     = 0x00000071U,
    DISPID_TITLEICONCHANGE = 0x00000072U,
}

enum : uint
{
    DISPID_FRAMEBEFORENAVIGATE   = 0x000000c8U,
    DISPID_FRAMENAVIGATECOMPLETE = 0x000000c9U,
    DISPID_FRAMENEWWINDOW        = 0x000000ccU,
}

enum uint DISPID_BEFORENAVIGATE2 = 0x000000faU;

enum : uint
{
    DISPID_NEWWINDOW2        = 0x000000fbU,
    DISPID_NAVIGATECOMPLETE2 = 0x000000fcU,
}

enum : uint
{
    DISPID_ONQUIT       = 0x000000fdU,
    DISPID_ONVISIBLE    = 0x000000feU,
    DISPID_ONTOOLBAR    = 0x000000ffU,
    DISPID_ONMENUBAR    = 0x00000100U,
    DISPID_ONSTATUSBAR  = 0x00000101U,
    DISPID_ONFULLSCREEN = 0x00000102U,
}

enum uint DISPID_DOCUMENTCOMPLETE = 0x00000103U;

enum : uint
{
    DISPID_ONTHEATERMODE = 0x00000104U,
    DISPID_ONADDRESSBAR  = 0x00000105U,
}

enum : uint
{
    DISPID_WINDOWSETRESIZABLE = 0x00000106U,
    DISPID_WINDOWCLOSING      = 0x00000107U,
    DISPID_WINDOWSETLEFT      = 0x00000108U,
    DISPID_WINDOWSETTOP       = 0x00000109U,
    DISPID_WINDOWSETWIDTH     = 0x0000010aU,
    DISPID_WINDOWSETHEIGHT    = 0x0000010bU,
}

enum uint DISPID_CLIENTTOHOSTWINDOW = 0x0000010cU;
enum uint DISPID_SETSECURELOCKICON = 0x0000010dU;
enum uint DISPID_FILEDOWNLOAD = 0x0000010eU;
enum uint DISPID_NAVIGATEERROR = 0x0000010fU;
enum uint DISPID_PRIVACYIMPACTEDSTATECHANGE = 0x00000110U;

enum : uint
{
    DISPID_NEWWINDOW3              = 0x00000111U,
    DISPID_VIEWUPDATE              = 0x00000119U,
    DISPID_SETPHISHINGFILTERSTATUS = 0x0000011aU,
}

enum uint DISPID_WINDOWSTATECHANGED = 0x0000011bU;

enum : uint
{
    DISPID_NEWPROCESS           = 0x0000011cU,
    DISPID_THIRDPARTYURLBLOCKED = 0x0000011dU,
}

enum uint DISPID_REDIRECTXDOMAINBLOCKED = 0x0000011eU;

enum : uint
{
    DISPID_WEBWORKERSTARTED  = 0x00000120U,
    DISPID_WEBWORKERFINISHED = 0x00000121U,
}

enum uint DISPID_BEFORESCRIPTEXECUTE = 0x00000122U;

enum : uint
{
    DISPID_PRINTTEMPLATEINSTANTIATION = 0x000000e1U,
    DISPID_PRINTTEMPLATETEARDOWN      = 0x000000e2U,
}

enum uint DISPID_UPDATEPAGESTATUS = 0x000000e3U;

enum : uint
{
    DISPID_WINDOWREGISTERED = 0x000000c8U,
    DISPID_WINDOWREVOKED    = 0x000000c9U,
}

enum : uint
{
    DISPID_RESETFIRSTBOOTMODE    = 0x00000001U,
    DISPID_RESETSAFEMODE         = 0x00000002U,
    DISPID_REFRESHOFFLINEDESKTOP = 0x00000003U,
}

enum : uint
{
    DISPID_ADDFAVORITE         = 0x00000004U,
    DISPID_ADDCHANNEL          = 0x00000005U,
    DISPID_ADDDESKTOPCOMPONENT = 0x00000006U,
}

enum uint DISPID_ISSUBSCRIBED = 0x00000007U;
enum uint DISPID_NAVIGATEANDFIND = 0x00000008U;
enum uint DISPID_IMPORTEXPORTFAVORITES = 0x00000009U;

enum : uint
{
    DISPID_AUTOCOMPLETESAVEFORM = 0x0000000aU,
    DISPID_AUTOSCAN             = 0x0000000bU,
    DISPID_AUTOCOMPLETEATTACH   = 0x0000000cU,
}

enum uint DISPID_SHOWBROWSERUI = 0x0000000dU;
enum uint DISPID_ADDSEARCHPROVIDER = 0x0000000eU;
enum uint DISPID_RUNONCESHOWN = 0x0000000fU;
enum uint DISPID_SKIPRUNONCE = 0x00000010U;
enum uint DISPID_CUSTOMIZESETTINGS = 0x00000011U;

enum : uint
{
    DISPID_SQMENABLED      = 0x00000012U,
    DISPID_PHISHINGENABLED = 0x00000013U,
}

enum uint DISPID_BRANDIMAGEURI = 0x00000014U;
enum uint DISPID_SKIPTABSWELCOME = 0x00000015U;
enum uint DISPID_DIAGNOSECONNECTION = 0x00000016U;
enum uint DISPID_CUSTOMIZECLEARTYPE = 0x00000017U;

enum : uint
{
    DISPID_ISSEARCHPROVIDERINSTALLED = 0x00000018U,
    DISPID_ISSEARCHMIGRATED          = 0x00000019U,
}

enum uint DISPID_DEFAULTSEARCHPROVIDER = 0x0000001aU;
enum uint DISPID_RUNONCEREQUIREDSETTINGSCOMPLETE = 0x0000001bU;
enum uint DISPID_RUNONCEHASSHOWN = 0x0000001cU;
enum uint DISPID_SEARCHGUIDEURL = 0x0000001dU;

enum : uint
{
    DISPID_ADDSERVICE         = 0x0000001eU,
    DISPID_ISSERVICEINSTALLED = 0x0000001fU,
}

enum uint DISPID_ADDTOFAVORITESBAR = 0x00000020U;
enum uint DISPID_BUILDNEWTABPAGE = 0x00000021U;
enum uint DISPID_SETRECENTLYCLOSEDVISIBLE = 0x00000022U;
enum uint DISPID_SETACTIVITIESVISIBLE = 0x00000023U;
enum uint DISPID_CONTENTDISCOVERYRESET = 0x00000024U;
enum uint DISPID_INPRIVATEFILTERINGENABLED = 0x00000025U;
enum uint DISPID_SUGGESTEDSITESENABLED = 0x00000026U;
enum uint DISPID_ENABLESUGGESTEDSITES = 0x00000027U;
enum uint DISPID_NAVIGATETOSUGGESTEDSITES = 0x00000028U;

enum : uint
{
    DISPID_SHOWTABSHELP      = 0x00000029U,
    DISPID_SHOWINPRIVATEHELP = 0x0000002aU,
}

enum : uint
{
    DISPID_ISSITEMODE             = 0x0000002bU,
    DISPID_SETSITEMODEICONOVERLAY = 0x0000002cU,
}

enum uint DISPID_CLEARSITEMODEICONOVERLAY = 0x0000002dU;
enum uint DISPID_UPDATETHUMBNAILBUTTON = 0x0000002eU;
enum uint DISPID_SETTHUMBNAILBUTTONS = 0x0000002fU;
enum uint DISPID_ADDTHUMBNAILBUTTONS = 0x00000030U;
enum uint DISPID_ADDSITEMODE = 0x00000031U;
enum uint DISPID_SETSITEMODEPROPERTIES = 0x00000032U;

enum : uint
{
    DISPID_SITEMODECREATEJUMPLIST  = 0x00000033U,
    DISPID_SITEMODEADDJUMPLISTITEM = 0x00000034U,
    DISPID_SITEMODECLEARJUMPLIST   = 0x00000035U,
    DISPID_SITEMODEADDBUTTONSTYLE  = 0x00000036U,
    DISPID_SITEMODESHOWBUTTONSTYLE = 0x00000037U,
    DISPID_SITEMODESHOWJUMPLIST    = 0x00000038U,
}

enum uint DISPID_ADDTRACKINGPROTECTIONLIST = 0x00000039U;
enum uint DISPID_SITEMODEACTIVATE = 0x0000003aU;
enum uint DISPID_ISSITEMODEFIRSTRUN = 0x0000003bU;
enum uint DISPID_TRACKINGPROTECTIONENABLED = 0x0000003cU;
enum uint DISPID_ACTIVEXFILTERINGENABLED = 0x0000003dU;
enum uint DISPID_PROVISIONNETWORKS = 0x0000003eU;
enum uint DISPID_REPORTSAFEURL = 0x0000003fU;

enum : uint
{
    DISPID_SITEMODEREFRESHBADGE = 0x00000040U,
    DISPID_SITEMODECLEARBADGE   = 0x00000041U,
}

enum uint DISPID_DIAGNOSECONNECTIONUILESS = 0x00000042U;
enum uint DISPID_LAUNCHNETWORKCLIENTHELP = 0x00000043U;
enum uint DISPID_CHANGEDEFAULTBROWSER = 0x00000044U;
enum uint DISPID_STOPPERIODICUPDATE = 0x00000045U;
enum uint DISPID_STARTPERIODICUPDATE = 0x00000046U;
enum uint DISPID_CLEARNOTIFICATION = 0x00000047U;
enum uint DISPID_ENABLENOTIFICATIONQUEUE = 0x00000048U;
enum uint DISPID_PINNEDSITESTATE = 0x00000049U;
enum uint DISPID_LAUNCHINTERNETOPTIONS = 0x0000004aU;
enum uint DISPID_STARTPERIODICUPDATEBATCH = 0x0000004bU;

enum : uint
{
    DISPID_ENABLENOTIFICATIONQUEUESQUARE = 0x0000004cU,
    DISPID_ENABLENOTIFICATIONQUEUEWIDE   = 0x0000004dU,
    DISPID_ENABLENOTIFICATIONQUEUELARGE  = 0x0000004eU,
}

enum uint DISPID_SCHEDULEDTILENOTIFICATION = 0x0000004fU;
enum uint DISPID_REMOVESCHEDULEDTILENOTIFICATION = 0x00000050U;
enum uint DISPID_STARTBADGEUPDATE = 0x00000051U;
enum uint DISPID_STOPBADGEUPDATE = 0x00000052U;
enum uint DISPID_ISMETAREFERRERAVAILABLE = 0x00000053U;
enum uint DISPID_SETEXPERIMENTALFLAG = 0x00000054U;
enum uint DISPID_GETEXPERIMENTALFLAG = 0x00000055U;
enum uint DISPID_SETEXPERIMENTALVALUE = 0x00000056U;
enum uint DISPID_GETEXPERIMENTALVALUE = 0x00000057U;
enum uint DISPID_HASNEEDIEAUTOLAUNCHFLAG = 0x00000058U;
enum uint DISPID_GETNEEDIEAUTOLAUNCHFLAG = 0x00000059U;
enum uint DISPID_SETNEEDIEAUTOLAUNCHFLAG = 0x0000005aU;

enum : uint
{
    DISPID_LAUNCHIE               = 0x0000005bU,
    DISPID_RESETEXPERIMENTALFLAGS = 0x0000005cU,
}

enum : uint
{
    DISPID_GETCVLISTDATA      = 0x0000005dU,
    DISPID_GETCVLISTLOCALDATA = 0x0000005eU,
}

enum : uint
{
    DISPID_GETEMIELISTDATA      = 0x0000005fU,
    DISPID_GETEMIELISTLOCALDATA = 0x00000060U,
}

enum : uint
{
    DISPID_OPENFAVORITESPANE     = 0x00000061U,
    DISPID_OPENFAVORITESSETTINGS = 0x00000062U,
}

enum uint DISPID_LAUNCHINHVSI = 0x00000063U;
enum uint DISPID_GETNEEDHVSIAUTOLAUNCHFLAG = 0x00000064U;
enum uint DISPID_SETNEEDHVSIAUTOLAUNCHFLAG = 0x00000065U;
enum uint DISPID_HASNEEDHVSIAUTOLAUNCHFLAG = 0x00000066U;

enum : uint
{
    DISPID_GETOSSKU      = 0x00000067U,
    DISPID_SETMSDEFAULTS = 0x00000068U,
}

enum uint DISPID_SHELLUIHELPERLAST = 0x00000069U;
enum uint DISPID_ADVANCEERROR = 0x0000000aU;
enum uint DISPID_RETREATERROR = 0x0000000bU;

enum : uint
{
    DISPID_CANADVANCEERROR = 0x0000000cU,
    DISPID_CANRETREATERROR = 0x0000000dU,
}

enum : uint
{
    DISPID_GETERRORLINE    = 0x0000000eU,
    DISPID_GETERRORCHAR    = 0x0000000fU,
    DISPID_GETERRORCODE    = 0x00000010U,
    DISPID_GETERRORMSG     = 0x00000011U,
    DISPID_GETERRORURL     = 0x00000012U,
    DISPID_GETDETAILSSTATE = 0x00000013U,
}

enum uint DISPID_SETDETAILSSTATE = 0x00000014U;
enum uint DISPID_GETPERERRSTATE = 0x00000015U;
enum uint DISPID_SETPERERRSTATE = 0x00000016U;
enum uint DISPID_GETALWAYSSHOWLOCKSTATE = 0x00000017U;
enum uint DISPID_FAVSELECTIONCHANGE = 0x00000001U;
enum uint DISPID_SELECTIONCHANGE = 0x00000002U;
enum uint DISPID_DOUBLECLICK = 0x00000003U;
enum uint DISPID_INITIALIZED = 0x00000004U;

enum : uint
{
    DISPID_MOVESELECTIONUP   = 0x00000001U,
    DISPID_MOVESELECTIONDOWN = 0x00000002U,
}

enum : uint
{
    DISPID_RESETSORT   = 0x00000003U,
    DISPID_NEWFOLDER   = 0x00000004U,
    DISPID_SYNCHRONIZE = 0x00000005U,
}

enum : uint
{
    DISPID_IMPORT            = 0x00000006U,
    DISPID_EXPORT            = 0x00000007U,
    DISPID_INVOKECONTEXTMENU = 0x00000008U,
}

enum uint DISPID_MOVESELECTIONTO = 0x00000009U;
enum uint DISPID_SUBSCRIPTIONSENABLED = 0x0000000aU;
enum uint DISPID_CREATESUBSCRIPTION = 0x0000000bU;
enum uint DISPID_DELETESUBSCRIPTION = 0x0000000cU;

enum : uint
{
    DISPID_SETROOT     = 0x0000000dU,
    DISPID_ENUMOPTIONS = 0x0000000eU,
}

enum uint DISPID_SELECTEDITEM = 0x0000000fU;

enum : uint
{
    DISPID_ROOT           = 0x00000010U,
    DISPID_DEPTH          = 0x00000011U,
    DISPID_MODE           = 0x00000012U,
    DISPID_FLAGS          = 0x00000013U,
    DISPID_TVFLAGS        = 0x00000014U,
    DISPID_NSCOLUMNS      = 0x00000015U,
    DISPID_COUNTVIEWTYPES = 0x00000016U,
}

enum : uint
{
    DISPID_SETVIEWTYPE   = 0x00000017U,
    DISPID_SELECTEDITEMS = 0x00000018U,
}

enum : uint
{
    DISPID_EXPAND      = 0x00000019U,
    DISPID_UNSELECTALL = 0x0000001aU,
}

enum uint TF_NAVIGATE = 0x7faeabacU;
enum const(wchar)* TARGET_NOTIFY_OBJECT_NAME = "863a99a0-21bc-11d0-82b4-00a0c90c29c5";
enum const(wchar)* IEPROCESS_MODULE_NAME = "IERtUtil.dll";
// Native encoding: ansi
enum const(wchar)* IEGetProcessModule_PROC_NAME = "IEGetProcessModule";
// Native encoding: ansi
enum const(wchar)* IEGetTabWindowExports_PROC_NAME = "IEGetTabWindowExports";
enum const(wchar)* TSZMICROSOFTPATH = "Software\\Microsoft";
// Native encoding: ansi
enum const(wchar)* SZ_IE_MAIN = "Main";
enum const(wchar)* REGSTR_VAL_SMOOTHSCROLL = "SmoothScroll";
enum uint REGSTR_VAL_SMOOTHSCROLL_DEF = 0x00000001U;

enum : const(wchar)*
{
    REGSTR_VAL_SHOWTOOLBAR    = "Show_ToolBar",
    REGSTR_VAL_SHOWADDRESSBAR = "Show_URLToolBar",
    REGSTR_VAL_STARTPAGE      = "Start Page",
}

// Native encoding: ansi
enum const(wchar)* REGSTRA_VAL_STARTPAGE = "Start Page";

enum : const(wchar)*
{
    REGSTR_VAL_SEARCHPAGE         = "Search Page",
    REGSTR_VAL_LOCALPAGE          = "Local Page",
    REGSTR_VAL_USESTYLESHEETS     = "Use Stylesheets",
    REGSTR_VAL_USESTYLESHEETS_DEF = "yes",
    REGSTR_VAL_USEICM             = "UseICM",
}

enum uint REGSTR_VAL_USEICM_DEF = 0x00000000U;

enum : const(wchar)*
{
    REGSTR_VAL_SHOWFOCUS       = "Tabstop - MouseDown",
    REGSTR_VAL_SHOWFOCUS_DEF   = "no",
    REGSTR_VAL_LOADIMAGES      = "Display Inline Images",
    REGSTR_VAL_PLAYSOUNDS      = "Play_Background_Sounds",
    REGSTR_VAL_PLAYVIDEOS      = "Display Inline Videos",
    REGSTR_VAL_ANCHORUNDERLINE = "Anchor Underline",
    REGSTR_VAL_USEDLGCOLORS    = "Use_DlgBox_Colors",
    REGSTR_VAL_CHECKASSOC      = "Check_Associations",
    REGSTR_VAL_SHOWFULLURLS    = "Show_FullURL",
    REGSTR_VAL_AUTOSEARCH      = "Do404Search",
    REGSTR_VAL_AUTONAVIGATE    = "SearchForExtensions",
    REGSTR_VAL_HTTP_ERRORS     = "Friendly http errors",
    REGSTR_VAL_USEIBAR         = "UseBar",
}

// Native encoding: ansi
enum const(wchar)* SZ_IE_SETTINGS = "Settings";

enum : const(wchar)*
{
    REGSTR_VAL_IE_CUSTOMCOLORS    = "Custom Colors",
    REGSTR_VAL_ANCHORCOLOR        = "Anchor Color",
    REGSTR_VAL_ANCHORCOLORVISITED = "Anchor Color Visited",
}

enum : const(wchar)*
{
    REGSTR_VAL_BACKGROUNDCOLOR  = "Background Color",
    REGSTR_VAL_TEXTCOLOR        = "Text Color",
    REGSTR_VAL_ANCHORCOLORHOVER = "Anchor Color Hover",
    REGSTR_VAL_USEHOVERCOLOR    = "Use Anchor Hover Color",
}

// Native encoding: ansi
enum const(wchar)* SZ_IE_SECURITY = "Security";
enum const(wchar)* REGSTR_VAL_SAFETYWARNINGLEVEL = "Safety Warning Level";
// Native encoding: ansi
enum const(wchar)* SZ_IE_DEFAULT_HTML_EDITOR = "Default HTML Editor";

enum : const(wchar)*
{
    REGSTR_VAL_USEAUTOAPPEND   = "Append Completion",
    REGSTR_VAL_USEAUTOSUGGEST  = "AutoSuggest",
    REGSTR_VAL_USEAUTOCOMPLETE = "Use AutoComplete",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    SZ_IE_IBAR       = "Bar",
    // Native encoding: ansi
    SZ_IE_IBAR_BANDS = "Bands",
}

enum : const(wchar)*
{
    REGSTR_VAL_USERAGENT         = "User Agent",
    REGSTR_VAL_INTERNETENTRY     = "InternetProfile",
    REGSTR_VAL_INTERNETPROFILE   = "InternetProfile",
    REGSTR_VAL_INTERNETENTRYBKUP = "BackupInternetProfile",
}

enum : const(wchar)*
{
    REGSTR_VAL_CODEDOWNLOAD     = "Code Download",
    REGSTR_VAL_CODEDOWNLOAD_DEF = "yes",
}

enum const(wchar)* REGSTR_PATH_INETCPL_RESTRICTIONS = "Software\\Policies\\Microsoft\\Internet Explorer\\Control Panel";

enum : const(wchar)*
{
    REGSTR_VAL_INETCPL_GENERALTAB     = "GeneralTab",
    REGSTR_VAL_INETCPL_SECURITYTAB    = "SecurityTab",
    REGSTR_VAL_INETCPL_CONTENTTAB     = "ContentTab",
    REGSTR_VAL_INETCPL_CONNECTIONSTAB = "ConnectionsTab",
    REGSTR_VAL_INETCPL_PROGRAMSTAB    = "ProgramsTab",
    REGSTR_VAL_INETCPL_ADVANCEDTAB    = "AdvancedTab",
    REGSTR_VAL_INETCPL_PRIVACYTAB     = "PrivacyTab",
    REGSTR_VAL_INETCPL_IEAK           = "IEAKContext",
    REGSTR_VAL_DIRECTORY              = "Directory",
    REGSTR_VAL_NEWDIRECTORY           = "NewDirectory",
    REGSTR_VAL_CACHEPREFIX            = "CachePrefix",
}

// Native encoding: ansi
enum const(wchar)* SZ_IE_SEARCHSTRINGS = "UrlTemplate";
enum uint MAX_SEARCH_FORMAT_STRING = 0x000000ffU;
// Native encoding: ansi
enum const(wchar)* SZ_IE_THRESHOLDS = "ErrorThresholds";

enum : const(wchar)*
{
    REGSTR_VAL_ACCESSMEDIUM              = "AccessMedium",
    REGSTR_VAL_ACCESSTYPE                = "AccessType",
    REGSTR_VAL_AUTODIALDLLNAME           = "AutodialDllName",
    REGSTR_VAL_AUTODIALFCNNAME           = "AutodialFcnName",
    REGSTR_VAL_AUTODIAL_MONITORCLASSNAME = "MS_AutodialMonitor",
    REGSTR_VAL_AUTODIAL_TRYONLYONCE      = "TryAutodialOnce",
}

enum : const(wchar)*
{
    REGSTR_PATH_REMOTEACCESS = "RemoteAccess",
    REGSTR_PATH_REMOTEACESS  = "RemoteAccess",
}

enum : const(wchar)*
{
    REGSTR_VAL_RNAINSTALLED             = "Installed",
    REGSTR_VAL_ENABLEAUTODIAL           = "EnableAutodial",
    REGSTR_VAL_ENABLEUNATTENDED         = "EnableUnattended",
    REGSTR_VAL_NONETAUTODIAL            = "NoNetAutodial",
    REGSTR_VAL_REDIALATTEMPTS           = "RedialAttempts",
    REGSTR_VAL_REDIALINTERVAL           = "RedialWait",
    REGSTR_VAL_ENABLEAUTODIALDISCONNECT = "EnableAutodisconnect",
    REGSTR_VAL_ENABLEAUTODISCONNECT     = "EnableAutodisconnect",
    REGSTR_VAL_ENABLEEXITDISCONNECT     = "EnableExitDisconnect",
    REGSTR_VAL_ENABLESECURITYCHECK      = "EnableSecurityCheck",
}

enum : const(wchar)*
{
    REGSTR_VAL_COVEREXCLUDE       = "CoverExclude",
    REGSTR_VAL_DISCONNECTIDLETIME = "DisconnectIdleTime",
}

enum : const(wchar)*
{
    REGSTR_VAL_MOSDISCONNECT    = "DisconnectTimeout",
    REGSTR_VAL_PROXYENABLE      = "ProxyEnable",
    REGSTR_VAL_PROXYSERVER      = "ProxyServer",
    REGSTR_VAL_PROXYOVERRIDE    = "ProxyOverride",
    REGSTR_VAL_BYPASSAUTOCONFIG = "BypassAutoconfig",
}

// Native encoding: ansi
enum const(wchar)* SZTRUSTWARNLEVEL = "Trust Warning Level";

enum : const(wchar)*
{
    REGSTR_VAL_TRUSTWARNINGLEVEL_HIGH = "High",
    REGSTR_VAL_TRUSTWARNINGLEVEL_MED  = "Medium",
    REGSTR_VAL_TRUSTWARNINGLEVEL_LOW  = "No Security",
}

enum const(wchar)* REGSTR_VAL_SECURITYWARNONSEND = "WarnOnPost";
enum uint REGSTR_VAL_SECURITYWARNONSEND_DEF = 0x00000001U;
enum const(wchar)* REGSTR_VAL_SECURITYWARNONSENDALWAYS = "WarnAlwaysOnPost";
enum uint REGSTR_VAL_SECURITYWARNONSENDALWAYS_DEF = 0x00000001U;
enum const(wchar)* REGSTR_VAL_SECURITYWARNONVIEW = "WarnOnView";
enum uint REGSTR_VAL_SECURITYWARNONVIEW_DEF = 0x00000001U;
enum const(wchar)* REGSTR_VAL_SECURITYALLOWCOOKIES = "AllowCookies";
enum uint REGSTR_VAL_SECURITYALLOWCOOKIES_DEF = 0x00000001U;
enum const(wchar)* REGSTR_VAL_SECURITYWARNONZONECROSSING = "WarnOnZoneCrossing";
enum uint REGSTR_VAL_SECURITYWARNONZONECROSSING_DEF = 0x00000001U;
enum const(wchar)* REGSTR_VAL_SECURITYWARNONBADCERTVIEWING = "WarnOnBadCertRecving";
enum uint REGSTR_VAL_SECURITYWARNONBADCERTVIEWING_DEF = 0x00000001U;
enum const(wchar)* REGSTR_VAL_SECURITYWARNONBADCERTSENDING = "WarnOnBadCertSending";
enum uint REGSTR_VAL_SECURITYWARNONBADCERTSENDING_DEF = 0x00000001U;
enum const(wchar)* REGSTR_VAL_SECURITYDISABLECACHINGOFSSLPAGES = "DisableCachingOfSSLPages";
enum uint REGSTR_VAL_SECURITYDISABLECACHINGOFSSLPAGES_DEF = 0x00000000U;
enum const(wchar)* REGSTR_VAL_SECURITYACTIVEX = "Security_RunActiveXControls";
enum uint REGSTR_VAL_SECURITYACTIVEX_DEF = 0x00000001U;
enum const(wchar)* REGSTR_VAL_SECURITYACTICEXSCRIPTS = "Security_RunScripts";
enum uint REGSTR_VAL_SECURITYACTICEXSCRIPTS_DEF = 0x00000001U;
enum const(wchar)* REGSTR_VAL_SECURITYJAVA = "Security_RunJavaApplets";
enum uint REGSTR_VAL_SECURITYJAVA_DEF = 0x00000001U;
// Native encoding: ansi
enum const(wchar)* SZJAVAVMPATH = "\\Java VM";
enum const(wchar)* REGSTR_VAL_JAVAJIT = "EnableJIT";
enum uint REGSTR_VAL_JAVAJIT_DEF = 0x00000000U;
enum const(wchar)* REGSTR_VAL_JAVALOGGING = "EnableLogging";
enum uint REGSTR_VAL_JAVALOGGING_DEF = 0x00000000U;
// Native encoding: ansi
enum const(wchar)* SZTOOLBAR = "\\Toolbar";
enum const(wchar)* REGSTR_VAL_DAYSTOKEEP = "DaysToKeep";
// Native encoding: ansi
enum const(wchar)* SZNOTEXT = "NoText";
// Native encoding: ansi
enum const(wchar)* SZVISIBLE = "VisibleBands";
enum const(wchar)* REGSTR_VAL_VISIBLEBANDS = "VisibleBands";
enum uint REGSTR_VAL_VISIBLEBANDS_DEF = 0x00000007U;
enum uint TOOLSBAND = 0x00000001U;
enum uint ADDRESSBAND = 0x00000002U;
enum uint LINKSBAND = 0x00000004U;
// Native encoding: ansi
enum const(wchar)* SZBACKBITMAP = "BackBitmap";
enum const(wchar)* REGSTR_VAL_BACKBITMAP = "BackBitmap";
enum const(wchar)* REGSTR_SHIFTQUICKSUFFIX = "ShiftQuickCompleteSuffix";
enum const(wchar)* TSZSCHANNELPATH = "SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL";
enum const(wchar)* REGSTR_VAL_SCHANNELENABLEPROTOCOL = "Enabled";
enum uint REGSTR_VAL_SCHANNELENABLEPROTOCOL_DEF = 0x00000001U;
enum const(wchar)* TSZINTERNETCLIENTSPATH = "Software\\Microsoft\\Internet Explorer\\Unix";

enum : const(wchar)*
{
    REGSTR_PATH_DEFAULT = "default",
    REGSTR_PATH_CURRENT = "current",
}

enum int IE_USE_OE_PRESENT_HKEY = 0x80000002;
enum const(wchar)* IE_USE_OE_PRESENT_KEY = "Software\\Microsoft\\Windows\\CurrentVersion\\app.paths\\msimn.exe";
enum int IE_USE_OE_MAIL_HKEY = 0x80000001;

enum : const(wchar)*
{
    IE_USE_OE_MAIL_KEY   = "Software\\Microsoft\\Internet Explorer\\Mail",
    IE_USE_OE_MAIL_VALUE = "Use Outlook Express",
}

enum int IE_USE_OE_NEWS_HKEY = 0x80000001;

enum : const(wchar)*
{
    IE_USE_OE_NEWS_KEY   = "Software\\Microsoft\\Internet Explorer\\News",
    IE_USE_OE_NEWS_VALUE = "Use Outlook Express",
}

enum const(wchar)* TSZPROTOCOLSPATH = "Protocols\\";
enum const(wchar)* TSZMAILTOPROTOCOL = "mailto";
enum const(wchar)* TSZNEWSPROTOCOL = "news";
enum const(wchar)* TSZCALLTOPROTOCOL = "callto";
enum const(wchar)* TSZLDAPPROTOCOL = "ldap";
enum const(wchar)* TSZCALENDARPROTOCOL = "unk";
enum const(wchar)* TSZVSOURCEPROTOCOL = "view source";

enum : const(wchar)*
{
    REGSTR_VAL_DEFAULT_CODEPAGE  = "Default_CodePage",
    REGSTR_VAL_DEFAULT_SCRIPT    = "Default_Script",
    REGSTR_VAL_ACCEPT_LANGUAGE   = "AcceptLanguage",
    REGSTR_VAL_FONT_SCRIPTS      = "Scripts",
    REGSTR_VAL_FONT_SCRIPT       = "Script",
    REGSTR_VAL_FONT_SCRIPT_NAME  = "Script",
    REGSTR_VAL_DEF_ENCODING      = "Default_Encoding",
    REGSTR_VAL_DEF_INETENCODING  = "Default_InternetEncoding",
    REGSTR_VAL_FIXED_FONT        = "IEFixedFontName",
    REGSTR_VAL_SCRIPT_FIXED_FONT = "IEFixedFontName",
}

enum : const(wchar)*
{
    REGSTR_VAL_PROP_FONT        = "IEPropFontName",
    REGSTR_VAL_SCRIPT_PROP_FONT = "IEPropFontName",
    REGSTR_VAL_FONT_SIZE        = "IEFontSize",
}

enum uint REGSTR_VAL_FONT_SIZE_DEF = 0x00000002U;
enum const(wchar)* REGSTR_VAL_AUTODETECT = "AutoDetect";
enum const(wchar)* REGSTR_PATH_MIME_DATABASE = "MIME\\Database";

enum : const(wchar)*
{
    REGSTR_VAL_CODEPAGE         = "CodePage",
    REGSTR_VAL_INETENCODING     = "InternetEncoding",
    REGSTR_VAL_FAMILY           = "Family",
    REGSTR_VAL_LEVEL            = "Level",
    REGSTR_VAL_ALIASTO          = "AliasForCharset",
    REGSTR_VAL_ENCODENAME       = "EncodingName",
    REGSTR_VAL_DESCRIPTION      = "Description",
    REGSTR_VAL_WEBCHARSET       = "WebCharset",
    REGSTR_VAL_BODYCHARSET      = "BodyCharset",
    REGSTR_VAL_HEADERCHARSET    = "HeaderCharset",
    REGSTR_VAL_FIXEDWIDTHFONT   = "FixedWidthFont",
    REGSTR_VAL_PROPORTIONALFONT = "ProportionalFont",
    REGSTR_VAL_PRIVCONVERTER    = "PrivConverter",
}

enum uint IECMDID_CLEAR_AUTOCOMPLETE_FOR_FORMS = 0x00000000U;
enum uint IECMDID_SETID_AUTOCOMPLETE_FOR_FORMS = 0x00000001U;

enum : uint
{
    IECMDID_BEFORENAVIGATE_GETSHELLBROWSE   = 0x00000002U,
    IECMDID_BEFORENAVIGATE_DOEXTERNALBROWSE = 0x00000003U,
    IECMDID_BEFORENAVIGATE_GETIDLIST        = 0x00000004U,
}

enum uint IECMDID_SET_INVOKE_DEFAULT_BROWSER_ON_NEW_WINDOW = 0x00000005U;
enum uint IECMDID_GET_INVOKE_DEFAULT_BROWSER_ON_NEW_WINDOW = 0x00000006U;

enum : uint
{
    IECMDID_ARG_CLEAR_FORMS_ALL               = 0x00000000U,
    IECMDID_ARG_CLEAR_FORMS_ALL_BUT_PASSWORDS = 0x00000001U,
    IECMDID_ARG_CLEAR_FORMS_PASSWORDS_ONLY    = 0x00000002U,
}

enum GUID CATID_MSOfficeAntiVirus = GUID("56ffcc30-d398-11d0-b2ae-00a0c908fa49");

enum : uint
{
    msoedmEnable   = 0x00000001U,
    msoedmDisable  = 0x00000002U,
    msoedmDontOpen = 0x00000003U,
}

enum uint msoslUndefined = 0x00000000U;

enum : uint
{
    msoslNone   = 0x00000001U,
    msoslMedium = 0x00000002U,
    msoslHigh   = 0x00000003U,
}

enum : uint
{
    msodsvNoMacros      = 0x00000000U,
    msodsvUnsigned      = 0x00000001U,
    msodsvPassedTrusted = 0x00000002U,
}

enum : uint
{
    msodsvFailed           = 0x00000003U,
    msodsvLowSecurityLevel = 0x00000004U,
}

enum uint msodsvPassedTrustedCert = 0x00000005U;

enum : uint
{
    STATURL_QUERYFLAG_ISCACHED = 0x00010000U,
    STATURL_QUERYFLAG_NOURL    = 0x00020000U,
    STATURL_QUERYFLAG_NOTITLE  = 0x00040000U,
    STATURL_QUERYFLAG_TOPLEVEL = 0x00080000U,
}

enum : uint
{
    STATURLFLAG_ISCACHED   = 0x00000001U,
    STATURLFLAG_ISTOPLEVEL = 0x00000002U,
}

enum : uint
{
    SURFACE_LOCK_EXCLUSIVE     = 0x00000001U,
    SURFACE_LOCK_ALLOW_DISCARD = 0x00000002U,
    SURFACE_LOCK_WAIT          = 0x00000004U,
}

enum : int
{
    E_SURFACE_NOSURFACE      = 0x8000c000,
    E_SURFACE_UNKNOWN_FORMAT = 0x8000c001,
    E_SURFACE_NOTMYPOINTER   = 0x8000c002,
    E_SURFACE_DISCARDED      = 0x8000c003,
    E_SURFACE_NODC           = 0x8000c004,
    E_SURFACE_NOTMYDC        = 0x8000c005,
}

enum int S_SURFACE_DISCARDED = 0x0000c003;
enum uint COLOR_NO_TRANSPARENT = 0xffffffffU;

enum : uint
{
    IMGDECODE_EVENT_PROGRESS     = 0x00000001U,
    IMGDECODE_EVENT_PALETTE      = 0x00000002U,
    IMGDECODE_EVENT_BEGINBITS    = 0x00000004U,
    IMGDECODE_EVENT_BITSCOMPLETE = 0x00000008U,
    IMGDECODE_EVENT_USEDDRAW     = 0x00000010U,
    IMGDECODE_HINT_TOPDOWN       = 0x00000001U,
    IMGDECODE_HINT_BOTTOMUP      = 0x00000002U,
    IMGDECODE_HINT_FULLWIDTH     = 0x00000004U,
}

enum : uint
{
    MAPMIME_DEFAULT        = 0x00000000U,
    MAPMIME_CLSID          = 0x00000001U,
    MAPMIME_DISABLE        = 0x00000002U,
    MAPMIME_DEFAULT_ALWAYS = 0x00000003U,
}

enum : uint
{
    TIMERMODE_NORMAL          = 0x00000000U,
    TIMERMODE_VISIBILITYAWARE = 0x00000001U,
}

// Structs


struct NAVIGATEDATA
{
    uint ulTarget;
    uint ulURL;
    uint ulRefURL;
    uint ulPostData;
    uint dwFlags;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct IELAUNCHURLINFO
{
    uint cbSize;
    uint dwCreationFlags;
    uint dwLaunchOptionFlags;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct STATURL
{
    uint     cbSize;
    PWSTR    pwcsUrl;
    PWSTR    pwcsTitle;
    FILETIME ftLastVisited;
    FILETIME ftLastUpdated;
    FILETIME ftExpires;
    uint     dwFlags;
}

// Functions

@DllImport("Ieframe.dll")
HRESULT IEAssociateThreadWithTab(uint dwTabThreadID, uint dwAssociatedThreadID);

@DllImport("Ieframe.dll")
HRESULT IEDisassociateThreadWithTab(uint dwTabThreadID, uint dwAssociatedThreadID);

@DllImport("Ieframe.dll")
BOOL IEIsInPrivateBrowsing();

@DllImport("Ieframe.dll")
BOOL IEInPrivateFilteringEnabled();

@DllImport("Ieframe.dll")
BOOL IETrackingProtectionEnabled();

@DllImport("Ieframe.dll")
HRESULT IESaveFile(HANDLE hState, const(PWSTR) lpwstrSourceFile);

@DllImport("Ieframe.dll")
HRESULT IECancelSaveFile(HANDLE hState);

@DllImport("Ieframe.dll")
HRESULT IEShowSaveFileDialog(HWND hwnd, const(PWSTR) lpwstrInitialFileName, const(PWSTR) lpwstrInitialDir, 
                             const(PWSTR) lpwstrFilter, const(PWSTR) lpwstrDefExt, uint dwFilterIndex, uint dwFlags, 
                             PWSTR* lppwstrDestinationFilePath, HANDLE* phState);

@DllImport("Ieframe.dll")
HRESULT IEShowOpenFileDialog(HWND hwnd, PWSTR lpwstrFileName, uint cchMaxFileName, const(PWSTR) lpwstrInitialDir, 
                             const(PWSTR) lpwstrFilter, const(PWSTR) lpwstrDefExt, uint dwFilterIndex, uint dwFlags, 
                             HANDLE* phFile);

@DllImport("Ieframe.dll")
HRESULT IEGetWriteableLowHKCU(HKEY* pHKey);

@DllImport("Ieframe.dll")
HRESULT IEGetWriteableFolderPath(const(GUID)* clsidFolderID, PWSTR* lppwstrPath);

@DllImport("Ieframe.dll")
HRESULT IEIsProtectedModeProcess(BOOL* pbResult);

@DllImport("Ieframe.dll")
HRESULT IEIsProtectedModeURL(const(PWSTR) lpwstrUrl);

@DllImport("Ieframe.dll")
HRESULT IELaunchURL(const(PWSTR) lpwstrUrl, PROCESS_INFORMATION* lpProcInfo, void* lpInfo);

@DllImport("Ieframe.dll")
HRESULT IERefreshElevationPolicy();

@DllImport("Ieframe.dll")
HRESULT IEGetProtectedModeCookie(const(PWSTR) lpszURL, const(PWSTR) lpszCookieName, PWSTR lpszCookieData, 
                                 uint* pcchCookieData, uint dwFlags);

@DllImport("Ieframe.dll")
HRESULT IESetProtectedModeCookie(const(PWSTR) lpszURL, const(PWSTR) lpszCookieName, const(PWSTR) lpszCookieData, 
                                 uint dwFlags);

@DllImport("Ieframe.dll")
HRESULT IERegisterWritableRegistryKey(GUID guid, const(PWSTR) lpSubkey, BOOL fSubkeyAllowed);

@DllImport("Ieframe.dll")
HRESULT IERegisterWritableRegistryValue(GUID guid, const(PWSTR) lpPath, const(PWSTR) lpValueName, uint dwType, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/const(ubyte)* lpData, 
                                        uint cbMaxData);

@DllImport("Ieframe.dll")
HRESULT IEUnregisterWritableRegistry(GUID guid);

@DllImport("Ieframe.dll")
HRESULT IERegCreateKeyEx(const(PWSTR) lpSubKey, uint Reserved, PWSTR lpClass, uint dwOptions, uint samDesired, 
                         SECURITY_ATTRIBUTES* lpSecurityAttributes, HKEY* phkResult, uint* lpdwDisposition);

@DllImport("Ieframe.dll")
HRESULT IERegSetValueEx(const(PWSTR) lpSubKey, const(PWSTR) lpValueName, uint Reserved, uint dwType, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/const(ubyte)* lpData, 
                        uint cbData);

@DllImport("Ieframe.dll")
HANDLE IECreateFile(const(PWSTR) lpFileName, uint dwDesiredAccess, uint dwShareMode, 
                    SECURITY_ATTRIBUTES* lpSecurityAttributes, uint dwCreationDisposition, uint dwFlagsAndAttributes, 
                    HANDLE hTemplateFile);

@DllImport("Ieframe.dll")
BOOL IEDeleteFile(const(PWSTR) lpFileName);

@DllImport("Ieframe.dll")
BOOL IERemoveDirectory(const(PWSTR) lpPathName);

@DllImport("Ieframe.dll")
BOOL IEMoveFileEx(const(PWSTR) lpExistingFileName, const(PWSTR) lpNewFileName, uint dwFlags);

@DllImport("Ieframe.dll")
BOOL IECreateDirectory(const(PWSTR) lpPathName, SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("Ieframe.dll")
BOOL IEGetFileAttributesEx(const(PWSTR) lpFileName, GET_FILEEX_INFO_LEVELS fInfoLevelId, void* lpFileInformation);

@DllImport("Ieframe.dll")
HANDLE IEFindFirstFile(const(PWSTR) lpFileName, WIN32_FIND_DATAA* lpFindFileData);

@DllImport("MSRATING.dll")
HRESULT RatingEnable(HWND hwndParent, const(PSTR) pszUsername, BOOL fEnable);

@DllImport("MSRATING.dll")
HRESULT RatingEnableW(HWND hwndParent, const(PWSTR) pszUsername, BOOL fEnable);

@DllImport("MSRATING.dll")
HRESULT RatingCheckUserAccess(const(PSTR) pszUsername, const(PSTR) pszURL, const(PSTR) pszRatingInfo, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pData, 
                              uint cbData, void** ppRatingDetails);

@DllImport("MSRATING.dll")
HRESULT RatingCheckUserAccessW(const(PWSTR) pszUsername, const(PWSTR) pszURL, const(PWSTR) pszRatingInfo, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pData, 
                               uint cbData, void** ppRatingDetails);

@DllImport("MSRATING.dll")
HRESULT RatingAccessDeniedDialog(HWND hDlg, const(PSTR) pszUsername, const(PSTR) pszContentDescription, 
                                 void* pRatingDetails);

@DllImport("MSRATING.dll")
HRESULT RatingAccessDeniedDialogW(HWND hDlg, const(PWSTR) pszUsername, const(PWSTR) pszContentDescription, 
                                  void* pRatingDetails);

@DllImport("MSRATING.dll")
HRESULT RatingAccessDeniedDialog2(HWND hDlg, const(PSTR) pszUsername, void* pRatingDetails);

@DllImport("MSRATING.dll")
HRESULT RatingAccessDeniedDialog2W(HWND hDlg, const(PWSTR) pszUsername, void* pRatingDetails);

@DllImport("MSRATING.dll")
HRESULT RatingFreeDetails(void* pRatingDetails);

@DllImport("MSRATING.dll")
HRESULT RatingObtainCancel(HANDLE hRatingObtainQuery);

@DllImport("MSRATING.dll")
HRESULT RatingObtainQuery(const(PSTR) pszTargetUrl, uint dwUserData, ptrdiff_t fCallback, 
                          HANDLE* phRatingObtainQuery);

@DllImport("MSRATING.dll")
HRESULT RatingObtainQueryW(const(PWSTR) pszTargetUrl, uint dwUserData, ptrdiff_t fCallback, 
                           HANDLE* phRatingObtainQuery);

@DllImport("MSRATING.dll")
HRESULT RatingSetupUI(HWND hDlg, const(PSTR) pszUsername);

@DllImport("MSRATING.dll")
HRESULT RatingSetupUIW(HWND hDlg, const(PWSTR) pszUsername);

@DllImport("MSRATING.dll")
HRESULT RatingAddToApprovedSites(HWND hDlg, uint cbPasswordBlob, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pbPasswordBlob, 
                                 const(PWSTR) lpszUrl, BOOL fAlwaysNever, BOOL fSitePage, 
                                 BOOL fApprovedSitesEnforced);

@DllImport("MSRATING.dll")
HRESULT RatingClickedOnPRFInternal(HWND hWndOwner, HINSTANCE param1, PSTR lpszFileName, int nShow);

@DllImport("MSRATING.dll")
HRESULT RatingClickedOnRATInternal(HWND hWndOwner, HINSTANCE param1, PSTR lpszFileName, int nShow);

@DllImport("MSRATING.dll")
HRESULT RatingEnabledQuery();

@DllImport("MSRATING.dll")
HRESULT RatingInit();

@DllImport("ImgUtil.dll")
HRESULT CreateMIMEMap(IMapMIMEToCLSID* ppMap);

@DllImport("ImgUtil.dll")
HRESULT DecodeImage(IStream pStream, IMapMIMEToCLSID pMap, IUnknown pEventSink);

@DllImport("ImgUtil.dll")
HRESULT SniffStream(IStream pInStream, uint* pnFormat, IStream* ppOutStream);

@DllImport("ImgUtil.dll")
HRESULT GetMaxMIMEIDBytes(uint* pnMaxBytes);

@DllImport("ImgUtil.dll")
HRESULT IdentifyMIMEType(const(ubyte)* pbBytes, uint nBytes, uint* pnFormat);

@DllImport("ImgUtil.dll")
HRESULT ComputeInvCMAP(const(RGBQUAD)* pRGBColors, uint nColors, ubyte* pInvTable, uint cbTable);

@DllImport("ImgUtil.dll")
HRESULT DitherTo8(ubyte* pDestBits, int nDestPitch, ubyte* pSrcBits, int nSrcPitch, const(GUID)* bfidSrc, 
                  RGBQUAD* prgbDestColors, RGBQUAD* prgbSrcColors, ubyte* pbDestInvMap, int x, int y, int cx, int cy, 
                  int lDestTrans, int lSrcTrans);

@DllImport("ImgUtil.dll")
HRESULT CreateDDrawSurfaceOnDIB(HBITMAP hbmDib, IDirectDrawSurface* ppSurface);

@DllImport("ImgUtil.dll")
HRESULT DecodeImageEx(IStream pStream, IMapMIMEToCLSID pMap, IUnknown pEventSink, const(PWSTR) pszMIMETypeParam);


// Interfaces

@GUID("374cede0-873a-4c4f-bc86-bcc8cf5116a3")
struct HomePageSetting;

@GUID("df4fcc34-067a-4e0a-8352-4a1a5095346e")
struct InternetExplorerManager;

@GUID("90314af2-5250-47b3-89d8-6295fc23bc22")
struct IEWebDriverManager;

@GUID("3050f4cf-98b5-11cf-bb82-00aa00bdce0b")
struct PeerFactory;

@GUID("613ab92e-16bf-11d2-bca5-00c04fd929db")
struct IntelliForms;

@GUID("766bf2ae-d650-11d1-9811-00c04fc31d2e")
struct HomePage;

@GUID("3050f48e-98b5-11cf-bb82-00aa00bdce0b")
struct CPersistUserData;

@GUID("3050f487-98b5-11cf-bb82-00aa00bdce0b")
struct CPersistDataPeer;

@GUID("3050f4c6-98b5-11cf-bb82-00aa00bdce0b")
struct CPersistShortcut;

@GUID("3050f4c8-98b5-11cf-bb82-00aa00bdce0b")
struct CPersistHistory;

@GUID("3050f4c9-98b5-11cf-bb82-00aa00bdce0b")
struct CPersistSnapshot;

@GUID("3050f5be-98b5-11cf-bb82-00aa00bdce0b")
struct CDownloadBehavior;

@GUID("bae31f9a-1b81-11d2-a97a-00c04f8ecb02")
struct wfolders;

@GUID("13d5413c-33b9-11d2-95a7-00c04f8ecb02")
struct AnchorClick;

@GUID("3050f664-98b5-11cf-bb82-00aa00bdce0b")
struct CLayoutRect;

@GUID("3050f6d4-98b5-11cf-bb82-00aa00bdce0b")
struct CDeviceRect;

@GUID("3050f6cd-98b5-11cf-bb82-00aa00bdce0b")
struct CHeaderFooter;

@GUID("098870b6-39ea-480b-b8b5-dd0167c4db59")
struct OpenServiceManager;

@GUID("c5efd803-50f8-43cd-9ab8-aafc1394c9e0")
struct OpenServiceActivityManager;

@GUID("a860ce50-3910-11d0-86fc-00a0c913f750")
struct CoDitherToRGB8;

@GUID("6a01fda0-30df-11d0-b724-00aa006c1a01")
struct CoSniffStream;

@GUID("30c3b080-30fb-11d0-b724-00aa006c1a01")
struct CoMapMIMEToCLSID;

@GUID("3050f801-98b5-11cf-bb82-00aa00bdce0b")
interface IDocObjectService : IUnknown
{
    HRESULT FireBeforeNavigate2(IDispatch pDispatch, const(PWSTR) lpszUrl, uint dwFlags, 
                                const(PWSTR) lpszFrameName, ubyte* pPostData, uint cbPostData, 
                                const(PWSTR) lpszHeaders, BOOL fPlayNavSound, BOOL* pfCancel);
    HRESULT FireNavigateComplete2(IHTMLWindow2 pHTMLWindow2, uint dwFlags);
    HRESULT FireDownloadBegin();
    HRESULT FireDownloadComplete();
    HRESULT FireDocumentComplete(IHTMLWindow2 pHTMLWindow, uint dwFlags);
    HRESULT UpdateDesktopComponent(IHTMLWindow2 pHTMLWindow);
    HRESULT GetPendingUrl(BSTR* pbstrPendingUrl);
    HRESULT ActiveElementChanged(IHTMLElement pHTMLElement);
    HRESULT GetUrlSearchComponent(BSTR* pbstrSearch);
    HRESULT IsErrorUrl(const(PWSTR) lpszUrl, BOOL* pfIsError);
}

@GUID("988934a4-064b-11d3-bb80-00104b35e7f9")
interface IDownloadManager : IUnknown
{
    HRESULT Download(IMoniker pmk, IBindCtx pbc, uint dwBindVerb, int grfBINDF, BINDINFO* pBindInfo, 
                     const(PWSTR) pszHeaders, const(PWSTR) pszRedir, uint uiCP);
}

@GUID("7d33f73d-8525-4e0f-87db-830288baff44")
interface IExtensionValidation : IUnknown
{
    HRESULT Validate(const(GUID)* extensionGuid, PWSTR extensionModulePath, uint extensionFileVersionMS, 
                     uint extensionFileVersionLS, IHTMLDocument2 htmlDocumentTop, 
                     IHTMLDocument2 htmlDocumentSubframe, IHTMLElement htmlElement, 
                     ExtensionValidationContexts contexts, ExtensionValidationResults* results);
    HRESULT DisplayName(PWSTR* displayName);
}

@GUID("fdfc244f-18fa-4ff2-b08e-1d618f3ffbe4")
interface IHomePageSetting : IUnknown
{
    HRESULT SetHomePage(HWND hwnd, const(PWSTR) homePageUri, const(PWSTR) brandingMessage);
    HRESULT IsHomePage(const(PWSTR) uri, BOOL* isDefault);
    HRESULT SetHomePageToBrowserDefault();
}

@GUID("863a99a0-21bc-11d0-82b4-00a0c90c29c5")
interface ITargetNotify : IUnknown
{
    HRESULT OnCreate(IUnknown pUnkDestination, uint cbCookie);
    HRESULT OnReuse(IUnknown pUnkDestination);
}

@GUID("3050f6b1-98b5-11cf-bb82-00aa00bdce0b")
interface ITargetNotify2 : ITargetNotify
{
    HRESULT GetOptionString(BSTR* pbstrOptions);
}

@GUID("86d52e11-94a8-11d0-82af-00c04fd5ae38")
interface ITargetFrame2 : IUnknown
{
    HRESULT SetFrameName(const(PWSTR) pszFrameName);
    HRESULT GetFrameName(PWSTR* ppszFrameName);
    HRESULT GetParentFrame(IUnknown* ppunkParent);
    HRESULT SetFrameSrc(const(PWSTR) pszFrameSrc);
    HRESULT GetFrameSrc(PWSTR* ppszFrameSrc);
    HRESULT GetFramesContainer(IOleContainer* ppContainer);
    HRESULT SetFrameOptions(uint dwFlags);
    HRESULT GetFrameOptions(uint* pdwFlags);
    HRESULT SetFrameMargins(uint dwWidth, uint dwHeight);
    HRESULT GetFrameMargins(uint* pdwWidth, uint* pdwHeight);
    HRESULT FindFrame(const(PWSTR) pszTargetName, uint dwFlags, IUnknown* ppunkTargetFrame);
    HRESULT GetTargetAlias(const(PWSTR) pszTargetName, PWSTR* ppszTargetAlias);
}

@GUID("7847ec01-2bec-11d0-82b4-00a0c90c29c5")
interface ITargetContainer : IUnknown
{
    HRESULT GetFrameUrl(PWSTR* ppszFrameSrc);
    HRESULT GetFramesContainer(IOleContainer* ppContainer);
}

@GUID("d5f78c80-5252-11cf-90fa-00aa0042106e")
interface ITargetFrame : IUnknown
{
    HRESULT SetFrameName(const(PWSTR) pszFrameName);
    HRESULT GetFrameName(PWSTR* ppszFrameName);
    HRESULT GetParentFrame(IUnknown* ppunkParent);
    HRESULT FindFrame(const(PWSTR) pszTargetName, IUnknown ppunkContextFrame, uint dwFlags, 
                      IUnknown* ppunkTargetFrame);
    HRESULT SetFrameSrc(const(PWSTR) pszFrameSrc);
    HRESULT GetFrameSrc(PWSTR* ppszFrameSrc);
    HRESULT GetFramesContainer(IOleContainer* ppContainer);
    HRESULT SetFrameOptions(uint dwFlags);
    HRESULT GetFrameOptions(uint* pdwFlags);
    HRESULT SetFrameMargins(uint dwWidth, uint dwHeight);
    HRESULT GetFrameMargins(uint* pdwWidth, uint* pdwHeight);
    HRESULT RemoteNavigate(uint cLength, uint* pulData);
    HRESULT OnChildFrameActivate(IUnknown pUnkChildFrame);
    HRESULT OnChildFrameDeactivate(IUnknown pUnkChildFrame);
}

@GUID("548793c0-9e74-11cf-9655-00a0c9034923")
interface ITargetEmbedding : IUnknown
{
    HRESULT GetTargetFrame(ITargetFrame* ppTargetFrame);
}

@GUID("9216e421-2bf5-11d0-82b4-00a0c90c29c5")
interface ITargetFramePriv : IUnknown
{
    HRESULT FindFrameDownwards(const(PWSTR) pszTargetName, uint dwFlags, IUnknown* ppunkTargetFrame);
    HRESULT FindFrameInContext(const(PWSTR) pszTargetName, IUnknown punkContextFrame, uint dwFlags, 
                               IUnknown* ppunkTargetFrame);
    HRESULT OnChildFrameActivate(IUnknown pUnkChildFrame);
    HRESULT OnChildFrameDeactivate(IUnknown pUnkChildFrame);
    HRESULT NavigateHack(uint grfHLNF, IBindCtx pbc, IBindStatusCallback pibsc, const(PWSTR) pszTargetName, 
                         const(PWSTR) pszUrl, const(PWSTR) pszLocation);
    HRESULT FindBrowserByIndex(uint dwID, IUnknown* ppunkBrowser);
}

@GUID("b2c867e6-69d6-46f2-a611-ded9a4bd7fef")
interface ITargetFramePriv2 : ITargetFramePriv
{
    HRESULT AggregatedNavigation2(uint grfHLNF, IBindCtx pbc, IBindStatusCallback pibsc, 
                                  const(PWSTR) pszTargetName, IUri pUri, const(PWSTR) pszLocation);
}

@GUID("e43f4a08-8bbc-4665-ac92-c55ce61fd7e7")
interface ISurfacePresenterFlipBuffer : IUnknown
{
    HRESULT BeginDraw(const(GUID)* riid, void** ppBuffer);
    HRESULT EndDraw();
}

@GUID("30510848-98b5-11cf-bb82-00aa00bdce0b")
interface ISurfacePresenterFlip : IUnknown
{
    HRESULT Present();
    HRESULT GetBuffer(uint backBufferIndex, const(GUID)* riid, void** ppBuffer);
}

@GUID("30510865-98b5-11cf-bb82-00aa00bdce0b")
interface ISurfacePresenterFlip2 : IUnknown
{
    HRESULT SetRotation(DXGI_MODE_ROTATION dxgiRotation);
}

@GUID("30510846-98b5-11cf-bb82-00aa00bdce0b")
interface IViewObjectPresentFlipSite : IUnknown
{
    HRESULT CreateSurfacePresenterFlip(IUnknown pDevice, uint width, uint height, uint backBufferCount, 
                                       DXGI_FORMAT format, VIEW_OBJECT_ALPHA_MODE mode, 
                                       ISurfacePresenterFlip* ppSPFlip);
    HRESULT GetDeviceLuid(LUID* pLuid);
    HRESULT EnterFullScreen();
    HRESULT ExitFullScreen();
    HRESULT IsFullScreen(BOOL* pfFullScreen);
    HRESULT GetBoundingRect(RECT* pRect);
    HRESULT GetMetrics(POINT* pPos, SIZE* pSize, float* pScaleX, float* pScaleY);
    HRESULT GetFullScreenSize(SIZE* pSize);
}

@GUID("aad0cbf1-e7fd-4f12-8902-c78132a8e01d")
interface IViewObjectPresentFlipSite2 : IUnknown
{
    HRESULT GetRotationForCurrentOutput(DXGI_MODE_ROTATION* pDxgiRotation);
}

@GUID("30510847-98b5-11cf-bb82-00aa00bdce0b")
interface IViewObjectPresentFlip : IUnknown
{
    HRESULT NotifyRender(BOOL fRecreatePresenter);
    HRESULT RenderObjectToBitmap(IUnknown pBitmap);
    HRESULT RenderObjectToSharedBuffer(ISurfacePresenterFlipBuffer pBuffer);
}

@GUID("30510856-98b5-11cf-bb82-00aa00bdce0b")
interface IViewObjectPresentFlip2 : IUnknown
{
    HRESULT NotifyLeavingView();
}

@GUID("7e3707b2-d087-4542-ac1f-a0d2fcd080fd")
interface IActiveXUIHandlerSite2 : IUnknown
{
    HRESULT AddSuspensionExemption(ulong* pullCookie);
    HRESULT RemoveSuspensionExemption(ulong ullCookie);
}

@GUID("58da43a2-108e-4d5b-9f75-e5f74f93fff5")
interface ICaretPositionProvider : IUnknown
{
    HRESULT GetCaretPosition(POINT* pptCaret, float* pflHeight);
}

@GUID("30510850-98b5-11cf-bb82-00aa00bdce0b")
interface ITridentTouchInput : IUnknown
{
    HRESULT OnPointerMessage(uint msg, WPARAM wParam, LPARAM lParam, BOOL* pfAllowManipulations);
}

@GUID("30510849-98b5-11cf-bb82-00aa00bdce0b")
interface ITridentTouchInputSite : IUnknown
{
    HRESULT SetManipulationMode(styleMsTouchAction msTouchAction);
    HRESULT ZoomToPoint(int x, int y);
}

@GUID("8165cfef-179d-46c2-bc71-3fa726dc1f8d")
interface IMediaActivityNotifySite : IUnknown
{
    HRESULT OnMediaActivityStarted(MEDIA_ACTIVITY_NOTIFY_TYPE mediaActivityType);
    HRESULT OnMediaActivityStopped(MEDIA_ACTIVITY_NOTIFY_TYPE mediaActivityType);
}

@GUID("d7d8b684-d02d-4517-b6b7-19e3dfe29c45")
interface IAudioSessionSite : IUnknown
{
    HRESULT GetAudioSessionGuid(GUID* audioSessionGuid);
    HRESULT OnAudioStreamCreated(const(PWSTR) endpointID);
    HRESULT OnAudioStreamDestroyed(const(PWSTR) endpointID);
}

@GUID("191cd340-cf36-44ff-bd53-d1b701799d9b")
interface IPrintTaskRequestHandler : IUnknown
{
    HRESULT HandlePrintTaskRequest(IInspectable pPrintTaskRequest);
}

@GUID("bb516745-8c34-4f8b-9605-684dcb144be5")
interface IPrintTaskRequestFactory : IUnknown
{
    HRESULT CreatePrintTaskRequest(IPrintTaskRequestHandler pPrintTaskRequestHandler);
}

@GUID("30510854-98b5-11cf-bb82-00aa00bdce0b")
interface IScrollableContextMenu : IUnknown
{
    HRESULT AddItem(const(PWSTR) itemText, uint cmdID);
    HRESULT ShowModal(int x, int y, uint* cmdID);
}

@GUID("f77e9056-8674-4936-924c-0e4a06fa634a")
interface IScrollableContextMenu2 : IScrollableContextMenu
{
    HRESULT AddSeparator();
    HRESULT SetPlacement(SCROLLABLECONTEXTMENU_PLACEMENT scmp);
}

@GUID("30510853-98b5-11cf-bb82-00aa00bdce0b")
interface IActiveXUIHandlerSite : IUnknown
{
    HRESULT CreateScrollableContextMenu(IScrollableContextMenu* scrollableContextMenu);
    HRESULT PickFileAndGetResult(IUnknown filePicker, BOOL allowMultipleSelections, IUnknown* result);
}

@GUID("7904009a-1238-47f4-901c-871375c34608")
interface IActiveXUIHandlerSite3 : IUnknown
{
    HRESULT MessageBoxW(HWND hwnd, const(PWSTR) text, const(PWSTR) caption, uint type, int* result);
}

@GUID("3caa826a-9b1f-4a79-bc81-f0430ded1648")
interface IEnumManagerFrames : IUnknown
{
    HRESULT Next(uint celt, HWND** ppWindows, uint* pceltFetched);
    HRESULT Count(uint* pcelt);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumManagerFrames* ppEnum);
}

@GUID("acc84351-04ff-44f9-b23f-655ed168c6d5")
interface IInternetExplorerManager : IUnknown
{
    HRESULT CreateObject(uint dwConfig, const(PWSTR) pszURL, const(GUID)* riid, void** ppv);
}

@GUID("dfbb5136-9259-4895-b4a7-c1934429919a")
interface IInternetExplorerManager2 : IUnknown
{
    HRESULT EnumFrameWindows(IEnumManagerFrames* ppEnum);
}

@GUID("ffb84444-453d-4fbc-9f9d-8db5c471ec75")
interface IIEWebDriverSite : IDispatch
{
    HRESULT WindowOperation(uint operationCode, uint hWnd);
    HRESULT DetachWebdriver(IUnknown pUnkWD);
    HRESULT GetCapabilityValue(IUnknown pUnkWD, PWSTR capName, VARIANT* capValue);
}

@GUID("bd1dc630-6590-4ca2-a293-6bc72b2438d8")
interface IIEWebDriverManager : IDispatch
{
    HRESULT ExecuteCommand(PWSTR command, PWSTR* response);
}

@GUID("6663f9d3-b482-11d1-89c6-00c04fb6bfc4")
interface IPeerFactory : IUnknown
{
}

@GUID("766bf2af-d650-11d1-9811-00c04fc31d2e")
interface IHomePage : IDispatch
{
    HRESULT navigateHomePage();
    HRESULT setHomePage(BSTR bstrURL);
    HRESULT isHomePage(BSTR bstrURL, VARIANT_BOOL* p);
}

@GUID("9b9f68e6-1aaa-11d2-bca5-00c04fd929db")
interface IIntelliForms : IDispatch
{
    HRESULT get_enabled(VARIANT_BOOL* pVal);
    HRESULT put_enabled(VARIANT_BOOL bVal);
}

@GUID("bae31f98-1b81-11d2-a97a-00c04f8ecb02")
interface Iwfolders : IDispatch
{
    HRESULT navigate(BSTR bstrUrl, BSTR* pbstrRetVal);
    HRESULT navigateFrame(BSTR bstrUrl, BSTR bstrTargetFrame, BSTR* pbstrRetVal);
    HRESULT navigateNoSite(BSTR bstrUrl, BSTR bstrTargetFrame, uint dwhwnd, IUnknown pwb);
}

@GUID("13d5413b-33b9-11d2-95a7-00c04f8ecb02")
interface IAnchorClick : IDispatch
{
    HRESULT ProcOnClick();
}

@GUID("3050f48f-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLUserDataOM : IDispatch
{
    HRESULT get_XMLDocument(IDispatch* p);
    HRESULT save(BSTR strName);
    HRESULT load(BSTR strName);
    HRESULT getAttribute(BSTR name, VARIANT* pValue);
    HRESULT setAttribute(BSTR name, VARIANT value);
    HRESULT removeAttribute(BSTR name);
    HRESULT put_expires(BSTR bstr);
    HRESULT get_expires(BSTR* pbstr);
}

@GUID("3050f4c0-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLPersistDataOM : IDispatch
{
    HRESULT get_XMLDocument(IDispatch* p);
    HRESULT getAttribute(BSTR name, VARIANT* pValue);
    HRESULT setAttribute(BSTR name, VARIANT value);
    HRESULT removeAttribute(BSTR name);
}

@GUID("3050f4c5-98b5-11cf-bb82-00aa00bdce0b")
interface IHTMLPersistData : IUnknown
{
    HRESULT save(IUnknown pUnk, int lType, VARIANT_BOOL* fContinueBroacast);
    HRESULT load(IUnknown pUnk, int lType, VARIANT_BOOL* fDoDefault);
    HRESULT queryType(int lType, VARIANT_BOOL* pfSupportsType);
}

@GUID("3050f5bd-98b5-11cf-bb82-00aa00bdce0b")
interface IDownloadBehavior : IDispatch
{
    HRESULT startDownload(BSTR bstrUrl, IDispatch pdispCallback);
}

@GUID("3050f665-98b5-11cf-bb82-00aa00bdce0b")
interface ILayoutRect : IDispatch
{
    HRESULT put_nextRect(BSTR bstrElementId);
    HRESULT get_nextRect(BSTR* pbstrElementId);
    HRESULT put_contentSrc(VARIANT varContentSrc);
    HRESULT get_contentSrc(VARIANT* pvarContentSrc);
    HRESULT put_honorPageBreaks(VARIANT_BOOL v);
    HRESULT get_honorPageBreaks(VARIANT_BOOL* p);
    HRESULT put_honorPageRules(VARIANT_BOOL v);
    HRESULT get_honorPageRules(VARIANT_BOOL* p);
    HRESULT put_nextRectElement(IDispatch pElem);
    HRESULT get_nextRectElement(IDispatch* ppElem);
    HRESULT get_contentDocument(IDispatch* pDoc);
}

@GUID("3050f6d5-98b5-11cf-bb82-00aa00bdce0b")
interface IDeviceRect : IDispatch
{
}

@GUID("3050f6ce-98b5-11cf-bb82-00aa00bdce0b")
interface IHeaderFooter : IDispatch
{
    HRESULT get_htmlHead(BSTR* p);
    HRESULT get_htmlFoot(BSTR* p);
    HRESULT put_textHead(BSTR v);
    HRESULT get_textHead(BSTR* p);
    HRESULT put_textFoot(BSTR v);
    HRESULT get_textFoot(BSTR* p);
    HRESULT put_page(uint v);
    HRESULT get_page(uint* p);
    HRESULT put_pageTotal(uint v);
    HRESULT get_pageTotal(uint* p);
    HRESULT put_URL(BSTR v);
    HRESULT get_URL(BSTR* p);
    HRESULT put_title(BSTR v);
    HRESULT get_title(BSTR* p);
    HRESULT put_dateShort(BSTR v);
    HRESULT get_dateShort(BSTR* p);
    HRESULT put_dateLong(BSTR v);
    HRESULT get_dateLong(BSTR* p);
    HRESULT put_timeShort(BSTR v);
    HRESULT get_timeShort(BSTR* p);
    HRESULT put_timeLong(BSTR v);
    HRESULT get_timeLong(BSTR* p);
}

@GUID("305104a5-98b5-11cf-bb82-00aa00bdce0b")
interface IHeaderFooter2 : IHeaderFooter
{
    HRESULT put_font(BSTR v);
    HRESULT get_font(BSTR* p);
}

@GUID("75cb4db9-6da0-4da3-83ce-422b6a433346")
interface IOpenServiceActivityInput : IUnknown
{
    HRESULT GetVariable(const(PWSTR) pwzVariableName, const(PWSTR) pwzVariableType, BSTR* pbstrVariableContent);
    HRESULT HasVariable(const(PWSTR) pwzVariableName, const(PWSTR) pwzVariableType, BOOL* pfHasVariable);
    HRESULT GetType(OpenServiceActivityContentType* pType);
}

@GUID("e289deab-f709-49a9-b99e-282364074571")
interface IOpenServiceActivityOutputContext : IUnknown
{
    HRESULT Navigate(const(PWSTR) pwzUri, const(PWSTR) pwzMethod, const(PWSTR) pwzHeaders, IStream pPostData);
    HRESULT CanNavigate(const(PWSTR) pwzUri, const(PWSTR) pwzMethod, const(PWSTR) pwzHeaders, IStream pPostData, 
                        BOOL* pfCanNavigate);
}

@GUID("c2952ed1-6a89-4606-925f-1ed8b4be0630")
interface IOpenService : IUnknown
{
    HRESULT IsDefault(BOOL* pfIsDefault);
    HRESULT SetDefault(BOOL fDefault, HWND hwnd);
    HRESULT GetID(BSTR* pbstrID);
}

@GUID("5664125f-4e10-4e90-98e4-e4513d955a14")
interface IOpenServiceManager : IUnknown
{
    HRESULT InstallService(const(PWSTR) pwzServiceUrl, IOpenService* ppService);
    HRESULT UninstallService(IOpenService pService);
    HRESULT GetServiceByID(const(PWSTR) pwzID, IOpenService* ppService);
}

@GUID("13645c88-221a-4905-8ed1-4f5112cfc108")
interface IOpenServiceActivity : IOpenService
{
    HRESULT Execute(IOpenServiceActivityInput pInput, IOpenServiceActivityOutputContext pOutput);
    HRESULT CanExecute(IOpenServiceActivityInput pInput, IOpenServiceActivityOutputContext pOutput, 
                       BOOL* pfCanExecute);
    HRESULT CanExecuteType(OpenServiceActivityContentType type, BOOL* pfCanExecute);
    HRESULT Preview(IOpenServiceActivityInput pInput, IOpenServiceActivityOutputContext pOutput);
    HRESULT CanPreview(IOpenServiceActivityInput pInput, IOpenServiceActivityOutputContext pOutput, 
                       BOOL* pfCanPreview);
    HRESULT CanPreviewType(OpenServiceActivityContentType type, BOOL* pfCanPreview);
    HRESULT GetStatusText(IOpenServiceActivityInput pInput, BSTR* pbstrStatusText);
    HRESULT GetHomepageUrl(BSTR* pbstrHomepageUrl);
    HRESULT GetDisplayName(BSTR* pbstrDisplayName);
    HRESULT GetDescription(BSTR* pbstrDescription);
    HRESULT GetCategoryName(BSTR* pbstrCategoryName);
    HRESULT GetIconPath(BSTR* pbstrIconPath);
    HRESULT GetIcon(BOOL fSmallIcon, HICON* phIcon);
    HRESULT GetDescriptionFilePath(BSTR* pbstrXmlPath);
    HRESULT GetDownloadUrl(BSTR* pbstrXmlUri);
    HRESULT GetInstallUrl(BSTR* pbstrInstallUri);
    HRESULT IsEnabled(BOOL* pfIsEnabled);
    HRESULT SetEnabled(BOOL fEnable);
}

@GUID("a436d7d2-17c3-4ef4-a1e8-5c86faff26c0")
interface IEnumOpenServiceActivity : IUnknown
{
    HRESULT Next(uint celt, IOpenServiceActivity* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumOpenServiceActivity* ppenum);
}

@GUID("850af9d6-7309-40b5-bdb8-786c106b2153")
interface IOpenServiceActivityCategory : IUnknown
{
    HRESULT HasDefaultActivity(BOOL* pfHasDefaultActivity);
    HRESULT GetDefaultActivity(IOpenServiceActivity* ppDefaultActivity);
    HRESULT SetDefaultActivity(IOpenServiceActivity pActivity, HWND hwnd);
    HRESULT GetName(BSTR* pbstrName);
    HRESULT GetActivityEnumerator(IOpenServiceActivityInput pInput, IOpenServiceActivityOutputContext pOutput, 
                                  IEnumOpenServiceActivity* ppEnumActivity);
}

@GUID("33627a56-8c9a-4430-8fd1-b5f5c771afb6")
interface IEnumOpenServiceActivityCategory : IUnknown
{
    HRESULT Next(uint celt, IOpenServiceActivityCategory* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumOpenServiceActivityCategory* ppenum);
}

@GUID("8a2d0a9d-e920-4bdc-a291-d30f650bc4f1")
interface IOpenServiceActivityManager : IUnknown
{
    HRESULT GetCategoryEnumerator(OpenServiceActivityContentType eType, IEnumOpenServiceActivityCategory* ppEnum);
    HRESULT GetActivityByID(const(PWSTR) pwzActivityID, IOpenServiceActivity* ppActivity);
    HRESULT GetActivityByHomepageAndCategory(const(PWSTR) pwzHomepage, const(PWSTR) pwzCategory, 
                                             IOpenServiceActivity* ppActivity);
    HRESULT GetVersionCookie(uint* pdwVersionCookie);
}

@GUID("91a565c1-e38f-11d0-94bf-00a0c9055cbf")
interface IPersistHistory : IPersist
{
    HRESULT LoadHistory(IStream pStream, IBindCtx pbc);
    HRESULT SaveHistory(IStream pStream);
    HRESULT SetPositionCookie(uint dwPositioncookie);
    HRESULT GetPositionCookie(uint* pdwPositioncookie);
}

@GUID("3c374a42-bae4-11cf-bf7d-00aa006946ee")
interface IEnumSTATURL : IUnknown
{
    HRESULT Next(uint celt, STATURL* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumSTATURL* ppenum);
    HRESULT SetFilter(const(PWSTR) poszFilter, uint dwFlags);
}

@GUID("3c374a41-bae4-11cf-bf7d-00aa006946ee")
interface IUrlHistoryStg : IUnknown
{
    HRESULT AddUrl(const(PWSTR) pocsUrl, const(PWSTR) pocsTitle, uint dwFlags);
    HRESULT DeleteUrl(const(PWSTR) pocsUrl, uint dwFlags);
    HRESULT QueryUrl(const(PWSTR) pocsUrl, uint dwFlags, STATURL* lpSTATURL);
    HRESULT BindToObject(const(PWSTR) pocsUrl, const(GUID)* riid, void** ppvOut);
    HRESULT EnumUrls(IEnumSTATURL* ppEnum);
}

@GUID("afa0dc11-c313-11d0-831a-00c04fd5ae38")
interface IUrlHistoryStg2 : IUrlHistoryStg
{
    HRESULT AddUrlAndNotify(const(PWSTR) pocsUrl, const(PWSTR) pocsTitle, uint dwFlags, BOOL fWriteHistory, 
                            IOleCommandTarget poctNotify, IUnknown punkISFolder);
    HRESULT ClearHistory();
}

@GUID("bc40bec1-c493-11d0-831b-00c04fd5ae38")
interface IUrlHistoryNotify : IOleCommandTarget
{
}

@GUID("54a8f188-9ebd-4795-ad16-9b4945119636")
interface IWebBrowserEventsService : IUnknown
{
    HRESULT FireBeforeNavigate2Event(VARIANT_BOOL* pfCancel);
    HRESULT FireNavigateComplete2Event();
    HRESULT FireDownloadBeginEvent();
    HRESULT FireDownloadCompleteEvent();
    HRESULT FireDocumentCompleteEvent();
}

@GUID("87cc5d04-eafa-4833-9820-8f986530cc00")
interface IWebBrowserEventsUrlService : IUnknown
{
    HRESULT GetUrlForEvents(BSTR* pUrl);
}

@GUID("3050f35f-98b5-11cf-bb82-00aa00bdce0b")
interface ITimerService : IUnknown
{
    HRESULT CreateTimer(ITimer pReferenceTimer, ITimer* ppNewTimer);
    HRESULT GetNamedTimer(const(GUID)* rguidName, ITimer* ppTimer);
    HRESULT SetNamedTimerReference(const(GUID)* rguidName, ITimer pReferenceTimer);
}

@GUID("3050f360-98b5-11cf-bb82-00aa00bdce0b")
interface ITimer : IUnknown
{
    HRESULT Advise(VARIANT vtimeMin, VARIANT vtimeMax, VARIANT vtimeInterval, uint dwFlags, ITimerSink pTimerSink, 
                   uint* pdwCookie);
    HRESULT Unadvise(uint dwCookie);
    HRESULT Freeze(BOOL fFreeze);
    HRESULT GetTime(VARIANT* pvtime);
}

@GUID("30510414-98b5-11cf-bb82-00aa00bdce0b")
interface ITimerEx : ITimer
{
    HRESULT SetMode(uint dwMode);
}

@GUID("3050f361-98b5-11cf-bb82-00aa00bdce0b")
interface ITimerSink : IUnknown
{
    HRESULT OnTimer(VARIANT vtimeAdvise);
}

@GUID("d9e89500-30fa-11d0-b724-00aa006c1a01")
interface IMapMIMEToCLSID : IUnknown
{
    HRESULT EnableDefaultMappings(BOOL bEnable);
    HRESULT MapMIMEToCLSID(const(PWSTR) pszMIMEType, GUID* pCLSID);
    HRESULT SetMapping(const(PWSTR) pszMIMEType, uint dwMapMode, const(GUID)* clsid);
}

@GUID("a3ccedf3-2de2-11d0-86f4-00a0c913f750")
interface IImageDecodeFilter : IUnknown
{
    HRESULT Initialize(IImageDecodeEventSink pEventSink);
    HRESULT Process(IStream pStream);
    HRESULT Terminate(HRESULT hrStatus);
}

@GUID("baa342a0-2ded-11d0-86f4-00a0c913f750")
interface IImageDecodeEventSink : IUnknown
{
    HRESULT GetSurface(int nWidth, int nHeight, const(GUID)* bfid, uint nPasses, uint dwHints, IUnknown* ppSurface);
    HRESULT OnBeginDecode(uint* pdwEvents, uint* pnFormats, GUID** ppFormats);
    HRESULT OnBitsComplete();
    HRESULT OnDecodeComplete(HRESULT hrStatus);
    HRESULT OnPalette();
    HRESULT OnProgress(RECT* pBounds, BOOL bComplete);
}

@GUID("8ebd8a57-8a96-48c9-84a6-962e2db9c931")
interface IImageDecodeEventSink2 : IImageDecodeEventSink
{
    HRESULT IsAlphaPremultRequired(BOOL* pfPremultAlpha);
}

@GUID("4ef17940-30e0-11d0-b724-00aa006c1a01")
interface ISniffStream : IUnknown
{
    HRESULT Init(IStream pStream);
    HRESULT Peek(void* pBuffer, uint nBytes, uint* pnBytesRead);
}

@GUID("7c48e840-3910-11d0-86fc-00a0c913f750")
interface IDithererImpl : IUnknown
{
    HRESULT SetDestColorTable(uint nColors, const(RGBQUAD)* prgbColors);
    HRESULT SetEventSink(IImageDecodeEventSink pEventSink);
}


// GUIDs

const GUID CLSID_AnchorClick                = GUIDOF!AnchorClick;
const GUID CLSID_CDeviceRect                = GUIDOF!CDeviceRect;
const GUID CLSID_CDownloadBehavior          = GUIDOF!CDownloadBehavior;
const GUID CLSID_CHeaderFooter              = GUIDOF!CHeaderFooter;
const GUID CLSID_CLayoutRect                = GUIDOF!CLayoutRect;
const GUID CLSID_CPersistDataPeer           = GUIDOF!CPersistDataPeer;
const GUID CLSID_CPersistHistory            = GUIDOF!CPersistHistory;
const GUID CLSID_CPersistShortcut           = GUIDOF!CPersistShortcut;
const GUID CLSID_CPersistSnapshot           = GUIDOF!CPersistSnapshot;
const GUID CLSID_CPersistUserData           = GUIDOF!CPersistUserData;
const GUID CLSID_CoDitherToRGB8             = GUIDOF!CoDitherToRGB8;
const GUID CLSID_CoMapMIMEToCLSID           = GUIDOF!CoMapMIMEToCLSID;
const GUID CLSID_CoSniffStream              = GUIDOF!CoSniffStream;
const GUID CLSID_HomePage                   = GUIDOF!HomePage;
const GUID CLSID_HomePageSetting            = GUIDOF!HomePageSetting;
const GUID CLSID_IEWebDriverManager         = GUIDOF!IEWebDriverManager;
const GUID CLSID_IntelliForms               = GUIDOF!IntelliForms;
const GUID CLSID_InternetExplorerManager    = GUIDOF!InternetExplorerManager;
const GUID CLSID_OpenServiceActivityManager = GUIDOF!OpenServiceActivityManager;
const GUID CLSID_OpenServiceManager         = GUIDOF!OpenServiceManager;
const GUID CLSID_PeerFactory                = GUIDOF!PeerFactory;
const GUID CLSID_wfolders                   = GUIDOF!wfolders;

const GUID IID_IActiveXUIHandlerSite             = GUIDOF!IActiveXUIHandlerSite;
const GUID IID_IActiveXUIHandlerSite2            = GUIDOF!IActiveXUIHandlerSite2;
const GUID IID_IActiveXUIHandlerSite3            = GUIDOF!IActiveXUIHandlerSite3;
const GUID IID_IAnchorClick                      = GUIDOF!IAnchorClick;
const GUID IID_IAudioSessionSite                 = GUIDOF!IAudioSessionSite;
const GUID IID_ICaretPositionProvider            = GUIDOF!ICaretPositionProvider;
const GUID IID_IDeviceRect                       = GUIDOF!IDeviceRect;
const GUID IID_IDithererImpl                     = GUIDOF!IDithererImpl;
const GUID IID_IDocObjectService                 = GUIDOF!IDocObjectService;
const GUID IID_IDownloadBehavior                 = GUIDOF!IDownloadBehavior;
const GUID IID_IDownloadManager                  = GUIDOF!IDownloadManager;
const GUID IID_IEnumManagerFrames                = GUIDOF!IEnumManagerFrames;
const GUID IID_IEnumOpenServiceActivity          = GUIDOF!IEnumOpenServiceActivity;
const GUID IID_IEnumOpenServiceActivityCategory  = GUIDOF!IEnumOpenServiceActivityCategory;
const GUID IID_IEnumSTATURL                      = GUIDOF!IEnumSTATURL;
const GUID IID_IExtensionValidation              = GUIDOF!IExtensionValidation;
const GUID IID_IHTMLPersistData                  = GUIDOF!IHTMLPersistData;
const GUID IID_IHTMLPersistDataOM                = GUIDOF!IHTMLPersistDataOM;
const GUID IID_IHTMLUserDataOM                   = GUIDOF!IHTMLUserDataOM;
const GUID IID_IHeaderFooter                     = GUIDOF!IHeaderFooter;
const GUID IID_IHeaderFooter2                    = GUIDOF!IHeaderFooter2;
const GUID IID_IHomePage                         = GUIDOF!IHomePage;
const GUID IID_IHomePageSetting                  = GUIDOF!IHomePageSetting;
const GUID IID_IIEWebDriverManager               = GUIDOF!IIEWebDriverManager;
const GUID IID_IIEWebDriverSite                  = GUIDOF!IIEWebDriverSite;
const GUID IID_IImageDecodeEventSink             = GUIDOF!IImageDecodeEventSink;
const GUID IID_IImageDecodeEventSink2            = GUIDOF!IImageDecodeEventSink2;
const GUID IID_IImageDecodeFilter                = GUIDOF!IImageDecodeFilter;
const GUID IID_IIntelliForms                     = GUIDOF!IIntelliForms;
const GUID IID_IInternetExplorerManager          = GUIDOF!IInternetExplorerManager;
const GUID IID_IInternetExplorerManager2         = GUIDOF!IInternetExplorerManager2;
const GUID IID_ILayoutRect                       = GUIDOF!ILayoutRect;
const GUID IID_IMapMIMEToCLSID                   = GUIDOF!IMapMIMEToCLSID;
const GUID IID_IMediaActivityNotifySite          = GUIDOF!IMediaActivityNotifySite;
const GUID IID_IOpenService                      = GUIDOF!IOpenService;
const GUID IID_IOpenServiceActivity              = GUIDOF!IOpenServiceActivity;
const GUID IID_IOpenServiceActivityCategory      = GUIDOF!IOpenServiceActivityCategory;
const GUID IID_IOpenServiceActivityInput         = GUIDOF!IOpenServiceActivityInput;
const GUID IID_IOpenServiceActivityManager       = GUIDOF!IOpenServiceActivityManager;
const GUID IID_IOpenServiceActivityOutputContext = GUIDOF!IOpenServiceActivityOutputContext;
const GUID IID_IOpenServiceManager               = GUIDOF!IOpenServiceManager;
const GUID IID_IPeerFactory                      = GUIDOF!IPeerFactory;
const GUID IID_IPersistHistory                   = GUIDOF!IPersistHistory;
const GUID IID_IPrintTaskRequestFactory          = GUIDOF!IPrintTaskRequestFactory;
const GUID IID_IPrintTaskRequestHandler          = GUIDOF!IPrintTaskRequestHandler;
const GUID IID_IScrollableContextMenu            = GUIDOF!IScrollableContextMenu;
const GUID IID_IScrollableContextMenu2           = GUIDOF!IScrollableContextMenu2;
const GUID IID_ISniffStream                      = GUIDOF!ISniffStream;
const GUID IID_ISurfacePresenterFlip             = GUIDOF!ISurfacePresenterFlip;
const GUID IID_ISurfacePresenterFlip2            = GUIDOF!ISurfacePresenterFlip2;
const GUID IID_ISurfacePresenterFlipBuffer       = GUIDOF!ISurfacePresenterFlipBuffer;
const GUID IID_ITargetContainer                  = GUIDOF!ITargetContainer;
const GUID IID_ITargetEmbedding                  = GUIDOF!ITargetEmbedding;
const GUID IID_ITargetFrame                      = GUIDOF!ITargetFrame;
const GUID IID_ITargetFrame2                     = GUIDOF!ITargetFrame2;
const GUID IID_ITargetFramePriv                  = GUIDOF!ITargetFramePriv;
const GUID IID_ITargetFramePriv2                 = GUIDOF!ITargetFramePriv2;
const GUID IID_ITargetNotify                     = GUIDOF!ITargetNotify;
const GUID IID_ITargetNotify2                    = GUIDOF!ITargetNotify2;
const GUID IID_ITimer                            = GUIDOF!ITimer;
const GUID IID_ITimerEx                          = GUIDOF!ITimerEx;
const GUID IID_ITimerService                     = GUIDOF!ITimerService;
const GUID IID_ITimerSink                        = GUIDOF!ITimerSink;
const GUID IID_ITridentTouchInput                = GUIDOF!ITridentTouchInput;
const GUID IID_ITridentTouchInputSite            = GUIDOF!ITridentTouchInputSite;
const GUID IID_IUrlHistoryNotify                 = GUIDOF!IUrlHistoryNotify;
const GUID IID_IUrlHistoryStg                    = GUIDOF!IUrlHistoryStg;
const GUID IID_IUrlHistoryStg2                   = GUIDOF!IUrlHistoryStg2;
const GUID IID_IViewObjectPresentFlip            = GUIDOF!IViewObjectPresentFlip;
const GUID IID_IViewObjectPresentFlip2           = GUIDOF!IViewObjectPresentFlip2;
const GUID IID_IViewObjectPresentFlipSite        = GUIDOF!IViewObjectPresentFlipSite;
const GUID IID_IViewObjectPresentFlipSite2       = GUIDOF!IViewObjectPresentFlipSite2;
const GUID IID_IWebBrowserEventsService          = GUIDOF!IWebBrowserEventsService;
const GUID IID_IWebBrowserEventsUrlService       = GUIDOF!IWebBrowserEventsUrlService;
const GUID IID_Iwfolders                         = GUIDOF!Iwfolders;
