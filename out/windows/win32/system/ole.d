// Written in the D programming language.

module windows.win32.system.ole;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, CHAR, COLORREF, DECIMAL, FILETIME,
                                         HANDLE, HGLOBAL, HINSTANCE, HRESULT,
                                         HRSRC, HTASK, HWND, LPARAM, LRESULT,
                                         POINT, POINTL, PSTR, PWSTR, RECT, RECTL,
                                         SIZE, SYSTEMTIME, VARIANT_BOOL, WPARAM;
public import windows.win32.graphics.gdi : HBITMAP, HDC, HENHMETAFILE, HFONT, HMETAFILE,
                                           HPALETTE, HRGN, LOGPALETTE, TEXTMETRICW;
public import windows.win32.system.com : BYTE_SIZEDARR, CALLCONV, CUSTDATA, CY, DISPPARAMS,
                                         DVASPECT, DVTARGETDEVICE, DWORD_SIZEDARR,
                                         EXCEPINFO, FLAGGED_WORD_BLOB, FORMATETC,
                                         FUNCDESC, HYPER_SIZEDARR, IAdviseSink,
                                         IBindCtx, IBindHost, IClassFactory,
                                         IDLDESC, IDataObject, IDispatch,
                                         IEnumFORMATETC, IEnumSTATDATA, IEnumUnknown,
                                         IErrorLog, IMPLTYPEFLAGS, IMoniker,
                                         INVOKEKIND, IPersist, IPersistStream,
                                         IServiceProvider, IStream, ITypeInfo,
                                         ITypeLib, IUnknown, SAFEARRAY, SAFEARRAYBOUND,
                                         STGMEDIUM, SYSKIND;
public import windows.win32.system.com.structuredstorage : IPersistStorage, IPropertyBag, IPropertyBag2,
                                                           IStorage, OLESTREAM;
public import windows.win32.system.com : TYPEDESC, TYPEKIND, VARDESC, WORD_SIZEDARR;
public import windows.win32.system.memory : GLOBAL_ALLOC_FLAGS;
public import windows.win32.system.systemservices : MODIFIERKEYS_FLAGS;
public import windows.win32.system.variant : VARENUM, VARIANT;
public import windows.win32.ui.controls.dialogs : OPENFILENAMEA, OPENFILENAMEW;
public import windows.win32.ui.controls : PROPSHEETHEADERA_V2, PROPSHEETHEADERW_V2;
public import windows.win32.ui.windowsandmessaging : HACCEL, HCURSOR, HICON, HMENU,
                                                     MENU_ITEM_FLAGS, MSG;

extern(Windows) @nogc nothrow:


// Enums


alias CLIPBOARD_FORMAT = ushort;
enum : ushort
{
    CF_TEXT            = cast(ushort) 0x0001,
    CF_BITMAP          = cast(ushort) 0x0002,
    CF_METAFILEPICT    = cast(ushort) 0x0003,
    CF_SYLK            = cast(ushort) 0x0004,
    CF_DIF             = cast(ushort) 0x0005,
    CF_TIFF            = cast(ushort) 0x0006,
    CF_OEMTEXT         = cast(ushort) 0x0007,
    CF_DIB             = cast(ushort) 0x0008,
    CF_PALETTE         = cast(ushort) 0x0009,
    CF_PENDATA         = cast(ushort) 0x000a,
    CF_RIFF            = cast(ushort) 0x000b,
    CF_WAVE            = cast(ushort) 0x000c,
    CF_UNICODETEXT     = cast(ushort) 0x000d,
    CF_ENHMETAFILE     = cast(ushort) 0x000e,
    CF_HDROP           = cast(ushort) 0x000f,
    CF_LOCALE          = cast(ushort) 0x0010,
    CF_DIBV5           = cast(ushort) 0x0011,
    CF_MAX             = cast(ushort) 0x0012,
    CF_OWNERDISPLAY    = cast(ushort) 0x0080,
    CF_DSPTEXT         = cast(ushort) 0x0081,
    CF_DSPBITMAP       = cast(ushort) 0x0082,
    CF_DSPMETAFILEPICT = cast(ushort) 0x0083,
    CF_DSPENHMETAFILE  = cast(ushort) 0x008e,
    CF_PRIVATEFIRST    = cast(ushort) 0x0200,
    CF_PRIVATELAST     = cast(ushort) 0x02ff,
    CF_GDIOBJFIRST     = cast(ushort) 0x0300,
    CF_GDIOBJLAST      = cast(ushort) 0x03ff,
}

alias OLEIVERB = int;
enum : int
{
    OLEIVERB_PRIMARY          = 0x00000000,
    OLEIVERB_SHOW             = 0xffffffff,
    OLEIVERB_OPEN             = 0xfffffffe,
    OLEIVERB_HIDE             = 0xfffffffd,
    OLEIVERB_UIACTIVATE       = 0xfffffffc,
    OLEIVERB_INPLACEACTIVATE  = 0xfffffffb,
    OLEIVERB_DISCARDUNDOSTATE = 0xfffffffa,
}

alias UPDFCACHE_FLAGS = uint;
enum : uint
{
    UPDFCACHE_ALL                  = 0x7fffffffU,
    UPDFCACHE_ALLBUTNODATACACHE    = 0x7ffffffeU,
    UPDFCACHE_NORMALCACHE          = 0x00000008U,
    UPDFCACHE_IFBLANK              = 0x00000010U,
    UPDFCACHE_ONLYIFBLANK          = 0x80000000U,
    UPDFCACHE_NODATACACHE          = 0x00000001U,
    UPDFCACHE_ONSAVECACHE          = 0x00000002U,
    UPDFCACHE_ONSTOPCACHE          = 0x00000004U,
    UPDFCACHE_IFBLANKORONSAVECACHE = 0x00000012U,
}

alias ENUM_CONTROLS_WHICH_FLAGS = uint;
enum : uint
{
    GCW_WCH_SIBLING    = 0x00000001U,
    GC_WCH_CONTAINER   = 0x00000002U,
    GC_WCH_CONTAINED   = 0x00000003U,
    GC_WCH_ALL         = 0x00000004U,
    GC_WCH_FREVERSEDIR = 0x08000000U,
    GC_WCH_FONLYAFTER  = 0x10000000U,
    GC_WCH_FONLYBEFORE = 0x20000000U,
    GC_WCH_FSELECTED   = 0x40000000U,
}

alias MULTICLASSINFO_FLAGS = uint;
enum : uint
{
    MULTICLASSINFO_GETTYPEINFO           = 0x00000001U,
    MULTICLASSINFO_GETNUMRESERVEDDISPIDS = 0x00000002U,
    MULTICLASSINFO_GETIIDPRIMARY         = 0x00000004U,
    MULTICLASSINFO_GETIIDSOURCE          = 0x00000008U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/com/dropeffect-constants
alias DROPEFFECT = uint;
enum : uint
{
    DROPEFFECT_NONE   = 0x00000000U,
    DROPEFFECT_COPY   = 0x00000001U,
    DROPEFFECT_MOVE   = 0x00000002U,
    DROPEFFECT_LINK   = 0x00000004U,
    DROPEFFECT_SCROLL = 0x80000000U,
}

alias KEYMODIFIERS = uint;
enum : uint
{
    KEYMOD_SHIFT   = 0x00000001U,
    KEYMOD_CONTROL = 0x00000002U,
    KEYMOD_ALT     = 0x00000004U,
}

alias ACTIVEOBJECT_FLAGS = uint;
enum : uint
{
    ACTIVEOBJECT_STRONG = 0x00000000U,
    ACTIVEOBJECT_WEAK   = 0x00000001U,
}

alias BUSY_DIALOG_FLAGS = uint;
enum : uint
{
    BZ_DISABLECANCELBUTTON   = 0x00000001U,
    BZ_DISABLESWITCHTOBUTTON = 0x00000002U,
    BZ_DISABLERETRYBUTTON    = 0x00000004U,
    BZ_NOTRESPONDINGDIALOG   = 0x00000008U,
}

alias UI_CONVERT_FLAGS = uint;
enum : uint
{
    CF_SHOWHELPBUTTON       = 0x00000001U,
    CF_SETCONVERTDEFAULT    = 0x00000002U,
    CF_SETACTIVATEDEFAULT   = 0x00000004U,
    CF_SELECTCONVERTTO      = 0x00000008U,
    CF_SELECTACTIVATEAS     = 0x00000010U,
    CF_DISABLEDISPLAYASICON = 0x00000020U,
    CF_DISABLEACTIVATEAS    = 0x00000040U,
    CF_HIDECHANGEICON       = 0x00000080U,
    CF_CONVERTONLY          = 0x00000100U,
}

alias CHANGE_ICON_FLAGS = uint;
enum : uint
{
    CIF_SHOWHELP       = 0x00000001U,
    CIF_SELECTCURRENT  = 0x00000002U,
    CIF_SELECTDEFAULT  = 0x00000004U,
    CIF_SELECTFROMFILE = 0x00000008U,
    CIF_USEICONEXE     = 0x00000010U,
}

alias CHANGE_SOURCE_FLAGS = uint;
enum : uint
{
    CSF_SHOWHELP      = 0x00000001U,
    CSF_VALIDSOURCE   = 0x00000002U,
    CSF_ONLYGETSOURCE = 0x00000004U,
    CSF_EXPLORER      = 0x00000008U,
}

alias EDIT_LINKS_FLAGS = uint;
enum : uint
{
    ELF_SHOWHELP            = 0x00000001U,
    ELF_DISABLEUPDATENOW    = 0x00000002U,
    ELF_DISABLEOPENSOURCE   = 0x00000004U,
    ELF_DISABLECHANGESOURCE = 0x00000008U,
    ELF_DISABLECANCELLINK   = 0x00000010U,
}

alias INSERT_OBJECT_FLAGS = uint;
enum : uint
{
    IOF_SHOWHELP             = 0x00000001U,
    IOF_SELECTCREATENEW      = 0x00000002U,
    IOF_SELECTCREATEFROMFILE = 0x00000004U,
    IOF_CHECKLINK            = 0x00000008U,
    IOF_CHECKDISPLAYASICON   = 0x00000010U,
    IOF_CREATENEWOBJECT      = 0x00000020U,
    IOF_CREATEFILEOBJECT     = 0x00000040U,
    IOF_CREATELINKOBJECT     = 0x00000080U,
    IOF_DISABLELINK          = 0x00000100U,
    IOF_VERIFYSERVERSEXIST   = 0x00000200U,
    IOF_DISABLEDISPLAYASICON = 0x00000400U,
    IOF_HIDECHANGEICON       = 0x00000800U,
    IOF_SHOWINSERTCONTROL    = 0x00001000U,
    IOF_SELECTCREATECONTROL  = 0x00002000U,
}

alias OBJECT_PROPERTIES_FLAGS = uint;
enum : uint
{
    OPF_OBJECTISLINK   = 0x00000001U,
    OPF_NOFILLDEFAULT  = 0x00000002U,
    OPF_SHOWHELP       = 0x00000004U,
    OPF_DISABLECONVERT = 0x00000008U,
}

alias VIEW_OBJECT_PROPERTIES_FLAGS = uint;
enum : uint
{
    VPF_SELECTRELATIVE  = 0x00000001U,
    VPF_DISABLERELATIVE = 0x00000002U,
    VPF_DISABLESCALE    = 0x00000004U,
}

alias PARAMFLAGS = ushort;
enum : ushort
{
    PARAMFLAG_NONE         = cast(ushort) 0x0000,
    PARAMFLAG_FIN          = cast(ushort) 0x0001,
    PARAMFLAG_FOUT         = cast(ushort) 0x0002,
    PARAMFLAG_FLCID        = cast(ushort) 0x0004,
    PARAMFLAG_FRETVAL      = cast(ushort) 0x0008,
    PARAMFLAG_FOPT         = cast(ushort) 0x0010,
    PARAMFLAG_FHASDEFAULT  = cast(ushort) 0x0020,
    PARAMFLAG_FHASCUSTDATA = cast(ushort) 0x0040,
}

alias NUMPARSE_FLAGS = uint;
enum : uint
{
    NUMPRS_LEADING_WHITE  = 0x00000001U,
    NUMPRS_TRAILING_WHITE = 0x00000002U,
    NUMPRS_LEADING_PLUS   = 0x00000004U,
    NUMPRS_TRAILING_PLUS  = 0x00000008U,
    NUMPRS_LEADING_MINUS  = 0x00000010U,
    NUMPRS_TRAILING_MINUS = 0x00000020U,
    NUMPRS_HEX_OCT        = 0x00000040U,
    NUMPRS_PARENS         = 0x00000080U,
    NUMPRS_DECIMAL        = 0x00000100U,
    NUMPRS_THOUSANDS      = 0x00000200U,
    NUMPRS_CURRENCY       = 0x00000400U,
    NUMPRS_EXPONENT       = 0x00000800U,
    NUMPRS_USE_ALL        = 0x00001000U,
    NUMPRS_STD            = 0x00001fffU,
    NUMPRS_NEG            = 0x00010000U,
    NUMPRS_INEXACT        = 0x00020000U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/com/pictype-constants
alias PICTYPE = short;
enum : short
{
    PICTYPE_UNINITIALIZED = cast(short) 0xffff,
    PICTYPE_NONE          = cast(short) 0x0000,
    PICTYPE_BITMAP        = cast(short) 0x0001,
    PICTYPE_METAFILE      = cast(short) 0x0002,
    PICTYPE_ICON          = cast(short) 0x0003,
    PICTYPE_ENHMETAFILE   = cast(short) 0x0004,
}

alias VARCMP = uint;
enum : uint
{
    VARCMP_LT   = 0x00000000U,
    VARCMP_EQ   = 0x00000001U,
    VARCMP_GT   = 0x00000002U,
    VARCMP_NULL = 0x00000003U,
}

alias PASTE_SPECIAL_FLAGS = uint;
enum : uint
{
    PSF_SHOWHELP              = 0x00000001U,
    PSF_SELECTPASTE           = 0x00000002U,
    PSF_SELECTPASTELINK       = 0x00000004U,
    PSF_CHECKDISPLAYASICON    = 0x00000008U,
    PSF_DISABLEDISPLAYASICON  = 0x00000010U,
    PSF_HIDECHANGEICON        = 0x00000020U,
    PSF_STAYONCLIPBOARDCHANGE = 0x00000040U,
    PSF_NOREFRESHDATAOBJECT   = 0x00000080U,
}

alias EMBDHLP_FLAGS = uint;
enum : uint
{
    EMBDHLP_INPROC_HANDLER = 0x00000000U,
    EMBDHLP_INPROC_SERVER  = 0x00000001U,
    EMBDHLP_CREATENOW      = 0x00000000U,
    EMBDHLP_DELAYCREATE    = 0x00010000U,
}

alias FDEX_PROP_FLAGS = uint;
enum : uint
{
    fdexPropCanGet             = 0x00000001U,
    fdexPropCannotGet          = 0x00000002U,
    fdexPropCanPut             = 0x00000004U,
    fdexPropCannotPut          = 0x00000008U,
    fdexPropCanPutRef          = 0x00000010U,
    fdexPropCannotPutRef       = 0x00000020U,
    fdexPropNoSideEffects      = 0x00000040U,
    fdexPropDynamicType        = 0x00000080U,
    fdexPropCanCall            = 0x00000100U,
    fdexPropCannotCall         = 0x00000200U,
    fdexPropCanConstruct       = 0x00000400U,
    fdexPropCannotConstruct    = 0x00000800U,
    fdexPropCanSourceEvents    = 0x00001000U,
    fdexPropCannotSourceEvents = 0x00002000U,
}

alias LOAD_PICTURE_FLAGS = uint;
enum : uint
{
    LP_DEFAULT    = 0x00000000U,
    LP_MONOCHROME = 0x00000001U,
    LP_VGACOLOR   = 0x00000002U,
    LP_COLOR      = 0x00000004U,
}

alias OLECREATE = uint;
enum : uint
{
    OLECREATE_ZERO         = 0x00000000U,
    OLECREATE_LEAVERUNNING = 0x00000001U,
}

alias VARFORMAT_FIRST_DAY = int;
enum : int
{
    VARFORMAT_FIRST_DAY_SYSTEMDEFAULT = 0x00000000,
    VARFORMAT_FIRST_DAY_MONDAY        = 0x00000001,
    VARFORMAT_FIRST_DAY_TUESDAY       = 0x00000002,
    VARFORMAT_FIRST_DAY_WEDNESDAY     = 0x00000003,
    VARFORMAT_FIRST_DAY_THURSDAY      = 0x00000004,
    VARFORMAT_FIRST_DAY_FRIDAY        = 0x00000005,
    VARFORMAT_FIRST_DAY_SATURDAY      = 0x00000006,
    VARFORMAT_FIRST_DAY_SUNDAY        = 0x00000007,
}

alias VARFORMAT_FIRST_WEEK = int;
enum : int
{
    VARFORMAT_FIRST_WEEK_SYSTEMDEFAULT               = 0x00000000,
    VARFORMAT_FIRST_WEEK_CONTAINS_JANUARY_FIRST      = 0x00000001,
    VARFORMAT_FIRST_WEEK_LARGER_HALF_IN_CURRENT_YEAR = 0x00000002,
    VARFORMAT_FIRST_WEEK_HAS_SEVEN_DAYS              = 0x00000003,
}

alias VARFORMAT_NAMED_FORMAT = int;
enum : int
{
    VARFORMAT_NAMED_FORMAT_GENERALDATE = 0x00000000,
    VARFORMAT_NAMED_FORMAT_LONGDATE    = 0x00000001,
    VARFORMAT_NAMED_FORMAT_SHORTDATE   = 0x00000002,
    VARFORMAT_NAMED_FORMAT_LONGTIME    = 0x00000003,
    VARFORMAT_NAMED_FORMAT_SHORTTIME   = 0x00000004,
}

alias VARFORMAT_LEADING_DIGIT = int;
enum : int
{
    VARFORMAT_LEADING_DIGIT_SYSTEMDEFAULT = 0xfffffffe,
    VARFORMAT_LEADING_DIGIT_INCLUDED      = 0xffffffff,
    VARFORMAT_LEADING_DIGIT_NOTINCLUDED   = 0x00000000,
}

alias VARFORMAT_PARENTHESES = int;
enum : int
{
    VARFORMAT_PARENTHESES_SYSTEMDEFAULT = 0xfffffffe,
    VARFORMAT_PARENTHESES_USED          = 0xffffffff,
    VARFORMAT_PARENTHESES_NOTUSED       = 0x00000000,
}

alias VARFORMAT_GROUP = int;
enum : int
{
    VARFORMAT_GROUP_SYSTEMDEFAULT = 0xfffffffe,
    VARFORMAT_GROUP_THOUSANDS     = 0xffffffff,
    VARFORMAT_GROUP_NOTTHOUSANDS  = 0x00000000,
}

alias SF_TYPE = int;
enum : int
{
    SF_ERROR    = 0x0000000a,
    SF_I1       = 0x00000010,
    SF_I2       = 0x00000002,
    SF_I4       = 0x00000003,
    SF_I8       = 0x00000014,
    SF_BSTR     = 0x00000008,
    SF_UNKNOWN  = 0x0000000d,
    SF_DISPATCH = 0x00000009,
    SF_VARIANT  = 0x0000000c,
    SF_RECORD   = 0x00000024,
    SF_HAVEIID  = 0x0000800d,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/ne-oaidl-typeflags
alias TYPEFLAGS = int;
enum : int
{
    TYPEFLAG_FAPPOBJECT     = 0x00000001,
    TYPEFLAG_FCANCREATE     = 0x00000002,
    TYPEFLAG_FLICENSED      = 0x00000004,
    TYPEFLAG_FPREDECLID     = 0x00000008,
    TYPEFLAG_FHIDDEN        = 0x00000010,
    TYPEFLAG_FCONTROL       = 0x00000020,
    TYPEFLAG_FDUAL          = 0x00000040,
    TYPEFLAG_FNONEXTENSIBLE = 0x00000080,
    TYPEFLAG_FOLEAUTOMATION = 0x00000100,
    TYPEFLAG_FRESTRICTED    = 0x00000200,
    TYPEFLAG_FAGGREGATABLE  = 0x00000400,
    TYPEFLAG_FREPLACEABLE   = 0x00000800,
    TYPEFLAG_FDISPATCHABLE  = 0x00001000,
    TYPEFLAG_FREVERSEBIND   = 0x00002000,
    TYPEFLAG_FPROXY         = 0x00004000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/ne-oaidl-libflags
alias LIBFLAGS = int;
enum : int
{
    LIBFLAG_FRESTRICTED   = 0x00000001,
    LIBFLAG_FCONTROL      = 0x00000002,
    LIBFLAG_FHIDDEN       = 0x00000004,
    LIBFLAG_FHASDISKIMAGE = 0x00000008,
}

alias CHANGEKIND = int;
enum : int
{
    CHANGEKIND_ADDMEMBER        = 0x00000000,
    CHANGEKIND_DELETEMEMBER     = 0x00000001,
    CHANGEKIND_SETNAMES         = 0x00000002,
    CHANGEKIND_SETDOCUMENTATION = 0x00000003,
    CHANGEKIND_GENERAL          = 0x00000004,
    CHANGEKIND_INVALIDATE       = 0x00000005,
    CHANGEKIND_CHANGEFAILED     = 0x00000006,
    CHANGEKIND_MAX              = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/ne-oleidl-discardcache
alias DISCARDCACHE = int;
enum : int
{
    DISCARDCACHE_SAVEIFDIRTY = 0x00000000,
    DISCARDCACHE_NOSAVE      = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/ne-oleidl-olegetmoniker
alias OLEGETMONIKER = int;
enum : int
{
    OLEGETMONIKER_ONLYIFTHERE = 0x00000001,
    OLEGETMONIKER_FORCEASSIGN = 0x00000002,
    OLEGETMONIKER_UNASSIGN    = 0x00000003,
    OLEGETMONIKER_TEMPFORUSER = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/ne-oleidl-olewhichmk
alias OLEWHICHMK = int;
enum : int
{
    OLEWHICHMK_CONTAINER = 0x00000001,
    OLEWHICHMK_OBJREL    = 0x00000002,
    OLEWHICHMK_OBJFULL   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/ne-oleidl-userclasstype
alias USERCLASSTYPE = int;
enum : int
{
    USERCLASSTYPE_FULL    = 0x00000001,
    USERCLASSTYPE_SHORT   = 0x00000002,
    USERCLASSTYPE_APPNAME = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/ne-oleidl-olemisc
alias OLEMISC = int;
enum : int
{
    OLEMISC_RECOMPOSEONRESIZE            = 0x00000001,
    OLEMISC_ONLYICONIC                   = 0x00000002,
    OLEMISC_INSERTNOTREPLACE             = 0x00000004,
    OLEMISC_STATIC                       = 0x00000008,
    OLEMISC_CANTLINKINSIDE               = 0x00000010,
    OLEMISC_CANLINKBYOLE1                = 0x00000020,
    OLEMISC_ISLINKOBJECT                 = 0x00000040,
    OLEMISC_INSIDEOUT                    = 0x00000080,
    OLEMISC_ACTIVATEWHENVISIBLE          = 0x00000100,
    OLEMISC_RENDERINGISDEVICEINDEPENDENT = 0x00000200,
    OLEMISC_INVISIBLEATRUNTIME           = 0x00000400,
    OLEMISC_ALWAYSRUN                    = 0x00000800,
    OLEMISC_ACTSLIKEBUTTON               = 0x00001000,
    OLEMISC_ACTSLIKELABEL                = 0x00002000,
    OLEMISC_NOUIACTIVATE                 = 0x00004000,
    OLEMISC_ALIGNABLE                    = 0x00008000,
    OLEMISC_SIMPLEFRAME                  = 0x00010000,
    OLEMISC_SETCLIENTSITEFIRST           = 0x00020000,
    OLEMISC_IMEMODE                      = 0x00040000,
    OLEMISC_IGNOREACTIVATEWHENVISIBLE    = 0x00080000,
    OLEMISC_WANTSTOMENUMERGE             = 0x00100000,
    OLEMISC_SUPPORTSMULTILEVELUNDO       = 0x00200000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/ne-oleidl-oleclose
alias OLECLOSE = int;
enum : int
{
    OLECLOSE_SAVEIFDIRTY = 0x00000000,
    OLECLOSE_NOSAVE      = 0x00000001,
    OLECLOSE_PROMPTSAVE  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/ne-oleidl-olerender
alias OLERENDER = int;
enum : int
{
    OLERENDER_NONE   = 0x00000000,
    OLERENDER_DRAW   = 0x00000001,
    OLERENDER_FORMAT = 0x00000002,
    OLERENDER_ASIS   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/ne-oleidl-oleupdate
alias OLEUPDATE = int;
enum : int
{
    OLEUPDATE_ALWAYS = 0x00000001,
    OLEUPDATE_ONCALL = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/ne-oleidl-olelinkbind
alias OLELINKBIND = int;
enum : int
{
    OLELINKBIND_EVENIFCLASSDIFF = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/ne-oleidl-bindspeed
alias BINDSPEED = int;
enum : int
{
    BINDSPEED_INDEFINITE = 0x00000001,
    BINDSPEED_MODERATE   = 0x00000002,
    BINDSPEED_IMMEDIATE  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/ne-oleidl-olecontf
alias OLECONTF = int;
enum : int
{
    OLECONTF_EMBEDDINGS    = 0x00000001,
    OLECONTF_LINKS         = 0x00000002,
    OLECONTF_OTHERS        = 0x00000004,
    OLECONTF_ONLYUSER      = 0x00000008,
    OLECONTF_ONLYIFRUNNING = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/ne-oleidl-oleverbattrib
alias OLEVERBATTRIB = int;
enum : int
{
    OLEVERBATTRIB_NEVERDIRTIES    = 0x00000001,
    OLEVERBATTRIB_ONCONTAINERMENU = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/ne-oleauto-regkind
alias REGKIND = int;
enum : int
{
    REGKIND_DEFAULT  = 0x00000000,
    REGKIND_REGISTER = 0x00000001,
    REGKIND_NONE     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ne-ocidl-uasflags
alias UASFLAGS = int;
enum : int
{
    UAS_NORMAL         = 0x00000000,
    UAS_BLOCKED        = 0x00000001,
    UAS_NOPARENTENABLE = 0x00000002,
    UAS_MASK           = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ne-ocidl-readystate
alias READYSTATE = int;
enum : int
{
    READYSTATE_UNINITIALIZED = 0x00000000,
    READYSTATE_LOADING       = 0x00000001,
    READYSTATE_LOADED        = 0x00000002,
    READYSTATE_INTERACTIVE   = 0x00000003,
    READYSTATE_COMPLETE      = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ne-ocidl-guidkind
alias GUIDKIND = int;
enum : int
{
    GUIDKIND_DEFAULT_SOURCE_DISP_IID = 0x00000001,
}

alias CTRLINFO = int;
enum : int
{
    CTRLINFO_EATS_RETURN = 0x00000001,
    CTRLINFO_EATS_ESCAPE = 0x00000002,
}

alias XFORMCOORDS = int;
enum : int
{
    XFORMCOORDS_POSITION            = 0x00000001,
    XFORMCOORDS_SIZE                = 0x00000002,
    XFORMCOORDS_HIMETRICTOCONTAINER = 0x00000004,
    XFORMCOORDS_CONTAINERTOHIMETRIC = 0x00000008,
    XFORMCOORDS_EVENTCOMPAT         = 0x00000010,
}

alias PROPPAGESTATUS = int;
enum : int
{
    PROPPAGESTATUS_DIRTY    = 0x00000001,
    PROPPAGESTATUS_VALIDATE = 0x00000002,
    PROPPAGESTATUS_CLEAN    = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ne-ocidl-pictureattributes
alias PICTUREATTRIBUTES = int;
enum : int
{
    PICTURE_SCALABLE    = 0x00000001,
    PICTURE_TRANSPARENT = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ne-ocidl-activateflags
alias ACTIVATEFLAGS = int;
enum : int
{
    ACTIVATE_WINDOWLESS = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ne-ocidl-oledcflags
alias OLEDCFLAGS = int;
enum : int
{
    OLEDC_NODRAW     = 0x00000001,
    OLEDC_PAINTBKGND = 0x00000002,
    OLEDC_OFFSCREEN  = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ne-ocidl-viewstatus
alias VIEWSTATUS = int;
enum : int
{
    VIEWSTATUS_OPAQUE              = 0x00000001,
    VIEWSTATUS_SOLIDBKGND          = 0x00000002,
    VIEWSTATUS_DVASPECTOPAQUE      = 0x00000004,
    VIEWSTATUS_DVASPECTTRANSPARENT = 0x00000008,
    VIEWSTATUS_SURFACE             = 0x00000010,
    VIEWSTATUS_3DSURFACE           = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ne-ocidl-hitresult
alias HITRESULT = int;
enum : int
{
    HITRESULT_OUTSIDE     = 0x00000000,
    HITRESULT_TRANSPARENT = 0x00000001,
    HITRESULT_CLOSE       = 0x00000002,
    HITRESULT_HIT         = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ne-ocidl-dvextentmode
alias DVEXTENTMODE = int;
enum : int
{
    DVEXTENT_CONTENT  = 0x00000000,
    DVEXTENT_INTEGRAL = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ne-ocidl-dvaspectinfoflag
alias DVASPECTINFOFLAG = int;
enum : int
{
    DVASPECTINFOFLAG_CANOPTIMIZE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ne-ocidl-pointerinactive
alias POINTERINACTIVE = int;
enum : int
{
    POINTERINACTIVE_ACTIVATEONENTRY   = 0x00000001,
    POINTERINACTIVE_DEACTIVATEONLEAVE = 0x00000002,
    POINTERINACTIVE_ACTIVATEONDRAG    = 0x00000004,
}

alias PROPBAG2_TYPE = int;
enum : int
{
    PROPBAG2_TYPE_UNDEFINED = 0x00000000,
    PROPBAG2_TYPE_DATA      = 0x00000001,
    PROPBAG2_TYPE_URL       = 0x00000002,
    PROPBAG2_TYPE_OBJECT    = 0x00000003,
    PROPBAG2_TYPE_STREAM    = 0x00000004,
    PROPBAG2_TYPE_STORAGE   = 0x00000005,
    PROPBAG2_TYPE_MONIKER   = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ne-ocidl-qacontainerflags
alias QACONTAINERFLAGS = int;
enum : int
{
    QACONTAINER_SHOWHATCHING      = 0x00000001,
    QACONTAINER_SHOWGRABHANDLES   = 0x00000002,
    QACONTAINER_USERMODE          = 0x00000004,
    QACONTAINER_DISPLAYASDEFAULT  = 0x00000008,
    QACONTAINER_UIDEAD            = 0x00000010,
    QACONTAINER_AUTOCLIP          = 0x00000020,
    QACONTAINER_MESSAGEREFLECT    = 0x00000040,
    QACONTAINER_SUPPORTSMNEMONICS = 0x00000080,
}

alias OLE_TRISTATE = int;
enum : int
{
    triUnchecked = 0x00000000,
    triChecked   = 0x00000001,
    triGray      = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/ne-docobj-docmisc
alias DOCMISC = int;
enum : int
{
    DOCMISC_CANCREATEMULTIPLEVIEWS   = 0x00000001,
    DOCMISC_SUPPORTCOMPLEXRECTANGLES = 0x00000002,
    DOCMISC_CANTOPENEDIT             = 0x00000004,
    DOCMISC_NOFILESUPPORT            = 0x00000008,
}

alias PRINTFLAG = int;
enum : int
{
    PRINTFLAG_MAYBOTHERUSER        = 0x00000001,
    PRINTFLAG_PROMPTUSER           = 0x00000002,
    PRINTFLAG_USERMAYCHANGEPRINTER = 0x00000004,
    PRINTFLAG_RECOMPOSETODEVICE    = 0x00000008,
    PRINTFLAG_DONTACTUALLYPRINT    = 0x00000010,
    PRINTFLAG_FORCEPROPERTIES      = 0x00000020,
    PRINTFLAG_PRINTTOFILE          = 0x00000040,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/ne-docobj-olecmdf
alias OLECMDF = int;
enum : int
{
    OLECMDF_SUPPORTED         = 0x00000001,
    OLECMDF_ENABLED           = 0x00000002,
    OLECMDF_LATCHED           = 0x00000004,
    OLECMDF_NINCHED           = 0x00000008,
    OLECMDF_INVISIBLE         = 0x00000010,
    OLECMDF_DEFHIDEONCTXTMENU = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/ne-docobj-olecmdtextf
alias OLECMDTEXTF = int;
enum : int
{
    OLECMDTEXTF_NONE   = 0x00000000,
    OLECMDTEXTF_NAME   = 0x00000001,
    OLECMDTEXTF_STATUS = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/ne-docobj-olecmdexecopt
alias OLECMDEXECOPT = int;
enum : int
{
    OLECMDEXECOPT_DODEFAULT      = 0x00000000,
    OLECMDEXECOPT_PROMPTUSER     = 0x00000001,
    OLECMDEXECOPT_DONTPROMPTUSER = 0x00000002,
    OLECMDEXECOPT_SHOWHELP       = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/ne-docobj-olecmdid
alias OLECMDID = int;
enum : int
{
    OLECMDID_OPEN                           = 0x00000001,
    OLECMDID_NEW                            = 0x00000002,
    OLECMDID_SAVE                           = 0x00000003,
    OLECMDID_SAVEAS                         = 0x00000004,
    OLECMDID_SAVECOPYAS                     = 0x00000005,
    OLECMDID_PRINT                          = 0x00000006,
    OLECMDID_PRINTPREVIEW                   = 0x00000007,
    OLECMDID_PAGESETUP                      = 0x00000008,
    OLECMDID_SPELL                          = 0x00000009,
    OLECMDID_PROPERTIES                     = 0x0000000a,
    OLECMDID_CUT                            = 0x0000000b,
    OLECMDID_COPY                           = 0x0000000c,
    OLECMDID_PASTE                          = 0x0000000d,
    OLECMDID_PASTESPECIAL                   = 0x0000000e,
    OLECMDID_UNDO                           = 0x0000000f,
    OLECMDID_REDO                           = 0x00000010,
    OLECMDID_SELECTALL                      = 0x00000011,
    OLECMDID_CLEARSELECTION                 = 0x00000012,
    OLECMDID_ZOOM                           = 0x00000013,
    OLECMDID_GETZOOMRANGE                   = 0x00000014,
    OLECMDID_UPDATECOMMANDS                 = 0x00000015,
    OLECMDID_REFRESH                        = 0x00000016,
    OLECMDID_STOP                           = 0x00000017,
    OLECMDID_HIDETOOLBARS                   = 0x00000018,
    OLECMDID_SETPROGRESSMAX                 = 0x00000019,
    OLECMDID_SETPROGRESSPOS                 = 0x0000001a,
    OLECMDID_SETPROGRESSTEXT                = 0x0000001b,
    OLECMDID_SETTITLE                       = 0x0000001c,
    OLECMDID_SETDOWNLOADSTATE               = 0x0000001d,
    OLECMDID_STOPDOWNLOAD                   = 0x0000001e,
    OLECMDID_ONTOOLBARACTIVATED             = 0x0000001f,
    OLECMDID_FIND                           = 0x00000020,
    OLECMDID_DELETE                         = 0x00000021,
    OLECMDID_HTTPEQUIV                      = 0x00000022,
    OLECMDID_HTTPEQUIV_DONE                 = 0x00000023,
    OLECMDID_ENABLE_INTERACTION             = 0x00000024,
    OLECMDID_ONUNLOAD                       = 0x00000025,
    OLECMDID_PROPERTYBAG2                   = 0x00000026,
    OLECMDID_PREREFRESH                     = 0x00000027,
    OLECMDID_SHOWSCRIPTERROR                = 0x00000028,
    OLECMDID_SHOWMESSAGE                    = 0x00000029,
    OLECMDID_SHOWFIND                       = 0x0000002a,
    OLECMDID_SHOWPAGESETUP                  = 0x0000002b,
    OLECMDID_SHOWPRINT                      = 0x0000002c,
    OLECMDID_CLOSE                          = 0x0000002d,
    OLECMDID_ALLOWUILESSSAVEAS              = 0x0000002e,
    OLECMDID_DONTDOWNLOADCSS                = 0x0000002f,
    OLECMDID_UPDATEPAGESTATUS               = 0x00000030,
    OLECMDID_PRINT2                         = 0x00000031,
    OLECMDID_PRINTPREVIEW2                  = 0x00000032,
    OLECMDID_SETPRINTTEMPLATE               = 0x00000033,
    OLECMDID_GETPRINTTEMPLATE               = 0x00000034,
    OLECMDID_PAGEACTIONBLOCKED              = 0x00000037,
    OLECMDID_PAGEACTIONUIQUERY              = 0x00000038,
    OLECMDID_FOCUSVIEWCONTROLS              = 0x00000039,
    OLECMDID_FOCUSVIEWCONTROLSQUERY         = 0x0000003a,
    OLECMDID_SHOWPAGEACTIONMENU             = 0x0000003b,
    OLECMDID_ADDTRAVELENTRY                 = 0x0000003c,
    OLECMDID_UPDATETRAVELENTRY              = 0x0000003d,
    OLECMDID_UPDATEBACKFORWARDSTATE         = 0x0000003e,
    OLECMDID_OPTICAL_ZOOM                   = 0x0000003f,
    OLECMDID_OPTICAL_GETZOOMRANGE           = 0x00000040,
    OLECMDID_WINDOWSTATECHANGED             = 0x00000041,
    OLECMDID_ACTIVEXINSTALLSCOPE            = 0x00000042,
    OLECMDID_UPDATETRAVELENTRY_DATARECOVERY = 0x00000043,
    OLECMDID_SHOWTASKDLG                    = 0x00000044,
    OLECMDID_POPSTATEEVENT                  = 0x00000045,
    OLECMDID_VIEWPORT_MODE                  = 0x00000046,
    OLECMDID_LAYOUT_VIEWPORT_WIDTH          = 0x00000047,
    OLECMDID_VISUAL_VIEWPORT_EXCLUDE_BOTTOM = 0x00000048,
    OLECMDID_USER_OPTICAL_ZOOM              = 0x00000049,
    OLECMDID_PAGEAVAILABLE                  = 0x0000004a,
    OLECMDID_GETUSERSCALABLE                = 0x0000004b,
    OLECMDID_UPDATE_CARET                   = 0x0000004c,
    OLECMDID_ENABLE_VISIBILITY              = 0x0000004d,
    OLECMDID_MEDIA_PLAYBACK                 = 0x0000004e,
    OLECMDID_SETFAVICON                     = 0x0000004f,
    OLECMDID_SET_HOST_FULLSCREENMODE        = 0x00000050,
    OLECMDID_EXITFULLSCREEN                 = 0x00000051,
    OLECMDID_SCROLLCOMPLETE                 = 0x00000052,
    OLECMDID_ONBEFOREUNLOAD                 = 0x00000053,
    OLECMDID_SHOWMESSAGE_BLOCKABLE          = 0x00000054,
    OLECMDID_SHOWTASKDLG_BLOCKABLE          = 0x00000055,
}

alias MEDIAPLAYBACK_STATE = int;
enum : int
{
    MEDIAPLAYBACK_RESUME              = 0x00000000,
    MEDIAPLAYBACK_PAUSE               = 0x00000001,
    MEDIAPLAYBACK_PAUSE_AND_SUSPEND   = 0x00000002,
    MEDIAPLAYBACK_RESUME_FROM_SUSPEND = 0x00000003,
}

alias IGNOREMIME = int;
enum : int
{
    IGNOREMIME_PROMPT = 0x00000001,
    IGNOREMIME_TEXT   = 0x00000002,
}

alias WPCSETTING = int;
enum : int
{
    WPCSETTING_LOGGING_ENABLED      = 0x00000001,
    WPCSETTING_FILEDOWNLOAD_BLOCKED = 0x00000002,
}

alias OLECMDID_REFRESHFLAG = int;
enum : int
{
    OLECMDIDF_REFRESH_NORMAL                              = 0x00000000,
    OLECMDIDF_REFRESH_IFEXPIRED                           = 0x00000001,
    OLECMDIDF_REFRESH_CONTINUE                            = 0x00000002,
    OLECMDIDF_REFRESH_COMPLETELY                          = 0x00000003,
    OLECMDIDF_REFRESH_NO_CACHE                            = 0x00000004,
    OLECMDIDF_REFRESH_RELOAD                              = 0x00000005,
    OLECMDIDF_REFRESH_LEVELMASK                           = 0x000000ff,
    OLECMDIDF_REFRESH_CLEARUSERINPUT                      = 0x00001000,
    OLECMDIDF_REFRESH_PROMPTIFOFFLINE                     = 0x00002000,
    OLECMDIDF_REFRESH_THROUGHSCRIPT                       = 0x00004000,
    OLECMDIDF_REFRESH_SKIPBEFOREUNLOADEVENT               = 0x00008000,
    OLECMDIDF_REFRESH_PAGEACTION_ACTIVEXINSTALL           = 0x00010000,
    OLECMDIDF_REFRESH_PAGEACTION_FILEDOWNLOAD             = 0x00020000,
    OLECMDIDF_REFRESH_PAGEACTION_LOCALMACHINE             = 0x00040000,
    OLECMDIDF_REFRESH_PAGEACTION_POPUPWINDOW              = 0x00080000,
    OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNLOCALMACHINE = 0x00100000,
    OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNTRUSTED      = 0x00200000,
    OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNINTRANET     = 0x00400000,
    OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNINTERNET     = 0x00800000,
    OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNRESTRICTED   = 0x01000000,
    OLECMDIDF_REFRESH_PAGEACTION_MIXEDCONTENT             = 0x02000000,
    OLECMDIDF_REFRESH_PAGEACTION_INVALID_CERT             = 0x04000000,
    OLECMDIDF_REFRESH_PAGEACTION_ALLOW_VERSION            = 0x08000000,
}

alias OLECMDID_PAGEACTIONFLAG = int;
enum : int
{
    OLECMDIDF_PAGEACTION_FILEDOWNLOAD                       = 0x00000001,
    OLECMDIDF_PAGEACTION_ACTIVEXINSTALL                     = 0x00000002,
    OLECMDIDF_PAGEACTION_ACTIVEXTRUSTFAIL                   = 0x00000004,
    OLECMDIDF_PAGEACTION_ACTIVEXUSERDISABLE                 = 0x00000008,
    OLECMDIDF_PAGEACTION_ACTIVEXDISALLOW                    = 0x00000010,
    OLECMDIDF_PAGEACTION_ACTIVEXUNSAFE                      = 0x00000020,
    OLECMDIDF_PAGEACTION_POPUPWINDOW                        = 0x00000040,
    OLECMDIDF_PAGEACTION_LOCALMACHINE                       = 0x00000080,
    OLECMDIDF_PAGEACTION_MIMETEXTPLAIN                      = 0x00000100,
    OLECMDIDF_PAGEACTION_SCRIPTNAVIGATE                     = 0x00000200,
    OLECMDIDF_PAGEACTION_SCRIPTNAVIGATE_ACTIVEXINSTALL      = 0x00000200,
    OLECMDIDF_PAGEACTION_PROTLOCKDOWNLOCALMACHINE           = 0x00000400,
    OLECMDIDF_PAGEACTION_PROTLOCKDOWNTRUSTED                = 0x00000800,
    OLECMDIDF_PAGEACTION_PROTLOCKDOWNINTRANET               = 0x00001000,
    OLECMDIDF_PAGEACTION_PROTLOCKDOWNINTERNET               = 0x00002000,
    OLECMDIDF_PAGEACTION_PROTLOCKDOWNRESTRICTED             = 0x00004000,
    OLECMDIDF_PAGEACTION_PROTLOCKDOWNDENY                   = 0x00008000,
    OLECMDIDF_PAGEACTION_POPUPALLOWED                       = 0x00010000,
    OLECMDIDF_PAGEACTION_SCRIPTPROMPT                       = 0x00020000,
    OLECMDIDF_PAGEACTION_ACTIVEXUSERAPPROVAL                = 0x00040000,
    OLECMDIDF_PAGEACTION_MIXEDCONTENT                       = 0x00080000,
    OLECMDIDF_PAGEACTION_INVALID_CERT                       = 0x00100000,
    OLECMDIDF_PAGEACTION_INTRANETZONEREQUEST                = 0x00200000,
    OLECMDIDF_PAGEACTION_XSSFILTERED                        = 0x00400000,
    OLECMDIDF_PAGEACTION_SPOOFABLEIDNHOST                   = 0x00800000,
    OLECMDIDF_PAGEACTION_ACTIVEX_EPM_INCOMPATIBLE           = 0x01000000,
    OLECMDIDF_PAGEACTION_SCRIPTNAVIGATE_ACTIVEXUSERAPPROVAL = 0x02000000,
    OLECMDIDF_PAGEACTION_WPCBLOCKED                         = 0x04000000,
    OLECMDIDF_PAGEACTION_WPCBLOCKED_ACTIVEX                 = 0x08000000,
    OLECMDIDF_PAGEACTION_EXTENSION_COMPAT_BLOCKED           = 0x10000000,
    OLECMDIDF_PAGEACTION_NORESETACTIVEX                     = 0x20000000,
    OLECMDIDF_PAGEACTION_GENERIC_STATE                      = 0x40000000,
    OLECMDIDF_PAGEACTION_RESET                              = 0x80000000,
}

alias OLECMDID_BROWSERSTATEFLAG = int;
enum : int
{
    OLECMDIDF_BROWSERSTATE_EXTENSIONSOFF     = 0x00000001,
    OLECMDIDF_BROWSERSTATE_IESECURITY        = 0x00000002,
    OLECMDIDF_BROWSERSTATE_PROTECTEDMODE_OFF = 0x00000004,
    OLECMDIDF_BROWSERSTATE_RESET             = 0x00000008,
    OLECMDIDF_BROWSERSTATE_REQUIRESACTIVEX   = 0x00000010,
    OLECMDIDF_BROWSERSTATE_DESKTOPHTMLDIALOG = 0x00000020,
    OLECMDIDF_BROWSERSTATE_BLOCKEDVERSION    = 0x00000040,
}

alias OLECMDID_OPTICAL_ZOOMFLAG = int;
enum : int
{
    OLECMDIDF_OPTICAL_ZOOM_NOPERSIST       = 0x00000001,
    OLECMDIDF_OPTICAL_ZOOM_NOLAYOUT        = 0x00000010,
    OLECMDIDF_OPTICAL_ZOOM_NOTRANSIENT     = 0x00000020,
    OLECMDIDF_OPTICAL_ZOOM_RELOADFORNEWTAB = 0x00000040,
}

alias PAGEACTION_UI = int;
enum : int
{
    PAGEACTION_UI_DEFAULT  = 0x00000000,
    PAGEACTION_UI_MODAL    = 0x00000001,
    PAGEACTION_UI_MODELESS = 0x00000002,
    PAGEACTION_UI_SILENT   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/ne-docobj-olecmdid_windowstate_flag
alias OLECMDID_WINDOWSTATE_FLAG = int;
enum : int
{
    OLECMDIDF_WINDOWSTATE_USERVISIBLE       = 0x00000001,
    OLECMDIDF_WINDOWSTATE_ENABLED           = 0x00000002,
    OLECMDIDF_WINDOWSTATE_USERVISIBLE_VALID = 0x00010000,
    OLECMDIDF_WINDOWSTATE_ENABLED_VALID     = 0x00020000,
}

alias OLECMDID_VIEWPORT_MODE_FLAG = int;
enum : int
{
    OLECMDIDF_VIEWPORTMODE_FIXED_LAYOUT_WIDTH          = 0x00000001,
    OLECMDIDF_VIEWPORTMODE_EXCLUDE_VISUAL_BOTTOM       = 0x00000002,
    OLECMDIDF_VIEWPORTMODE_FIXED_LAYOUT_WIDTH_VALID    = 0x00010000,
    OLECMDIDF_VIEWPORTMODE_EXCLUDE_VISUAL_BOTTOM_VALID = 0x00020000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ne-oledlg-oleuipasteflag
alias OLEUIPASTEFLAG = int;
enum : int
{
    OLEUIPASTE_ENABLEICON  = 0x00000800,
    OLEUIPASTE_PASTEONLY   = 0x00000000,
    OLEUIPASTE_PASTE       = 0x00000200,
    OLEUIPASTE_LINKANYTYPE = 0x00000400,
    OLEUIPASTE_LINKTYPE1   = 0x00000001,
    OLEUIPASTE_LINKTYPE2   = 0x00000002,
    OLEUIPASTE_LINKTYPE3   = 0x00000004,
    OLEUIPASTE_LINKTYPE4   = 0x00000008,
    OLEUIPASTE_LINKTYPE5   = 0x00000010,
    OLEUIPASTE_LINKTYPE6   = 0x00000020,
    OLEUIPASTE_LINKTYPE7   = 0x00000040,
    OLEUIPASTE_LINKTYPE8   = 0x00000080,
}

// Constants


enum int CTL_E_ILLEGALFUNCTIONCALL = 0x800a0005;
enum int CONNECT_E_FIRST = 0x80040200;
enum int SELFREG_E_FIRST = 0x80040200;
enum int PERPROP_E_FIRST = 0x80040200;

enum : HRESULT
{
    OLECMDERR_E_FIRST        = HRESULT(0x80040100),
    OLECMDERR_E_DISABLED     = HRESULT(0x80040101),
    OLECMDERR_E_NOHELP       = HRESULT(0x80040102),
    OLECMDERR_E_CANCELED     = HRESULT(0x80040103),
    OLECMDERR_E_UNKNOWNGROUP = HRESULT(0x80040104),
}

enum : HRESULT
{
    CONNECT_E_NOCONNECTION  = HRESULT(0x80040200),
    CONNECT_E_ADVISELIMIT   = HRESULT(0x80040201),
    CONNECT_E_CANNOTCONNECT = HRESULT(0x80040202),
    CONNECT_E_OVERRIDDEN    = HRESULT(0x80040203),
}

enum : HRESULT
{
    SELFREG_E_TYPELIB = HRESULT(0x80040200),
    SELFREG_E_CLASS   = HRESULT(0x80040201),
}

enum HRESULT PERPROP_E_NOPAGEAVAILABLE = HRESULT(0x80040200);
enum GUID CLSID_CFontPropPage = GUID("0be35200-8f91-11ce-9de3-00aa004bb851");
enum GUID CLSID_CColorPropPage = GUID("0be35201-8f91-11ce-9de3-00aa004bb851");
enum GUID CLSID_CPicturePropPage = GUID("0be35202-8f91-11ce-9de3-00aa004bb851");
enum GUID CLSID_PersistPropset = GUID("fb8f0821-0164-101b-84ed-08002b2ec713");
enum GUID CLSID_ConvertVBX = GUID("fb8f0822-0164-101b-84ed-08002b2ec713");

enum : GUID
{
    CLSID_StdFont    = GUID("0be35203-8f91-11ce-9de3-00aa004bb851"),
    CLSID_StdPicture = GUID("0be35204-8f91-11ce-9de3-00aa004bb851"),
}

enum GUID GUID_HIMETRIC = GUID("66504300-be0f-101a-8bbb-00aa00300cab");

enum : GUID
{
    GUID_COLOR     = GUID("66504301-be0f-101a-8bbb-00aa00300cab"),
    GUID_XPOSPIXEL = GUID("66504302-be0f-101a-8bbb-00aa00300cab"),
}

enum GUID GUID_YPOSPIXEL = GUID("66504303-be0f-101a-8bbb-00aa00300cab");
enum GUID GUID_XSIZEPIXEL = GUID("66504304-be0f-101a-8bbb-00aa00300cab");
enum GUID GUID_YSIZEPIXEL = GUID("66504305-be0f-101a-8bbb-00aa00300cab");

enum : GUID
{
    GUID_XPOS     = GUID("66504306-be0f-101a-8bbb-00aa00300cab"),
    GUID_YPOS     = GUID("66504307-be0f-101a-8bbb-00aa00300cab"),
    GUID_XSIZE    = GUID("66504308-be0f-101a-8bbb-00aa00300cab"),
    GUID_YSIZE    = GUID("66504309-be0f-101a-8bbb-00aa00300cab"),
    GUID_TRISTATE = GUID("6650430a-be0f-101a-8bbb-00aa00300cab"),
}

enum GUID GUID_OPTIONVALUEEXCLUSIVE = GUID("6650430b-be0f-101a-8bbb-00aa00300cab");
enum GUID GUID_CHECKVALUEEXCLUSIVE = GUID("6650430c-be0f-101a-8bbb-00aa00300cab");

enum : GUID
{
    GUID_FONTNAME          = GUID("6650430d-be0f-101a-8bbb-00aa00300cab"),
    GUID_FONTSIZE          = GUID("6650430e-be0f-101a-8bbb-00aa00300cab"),
    GUID_FONTBOLD          = GUID("6650430f-be0f-101a-8bbb-00aa00300cab"),
    GUID_FONTITALIC        = GUID("66504310-be0f-101a-8bbb-00aa00300cab"),
    GUID_FONTUNDERSCORE    = GUID("66504311-be0f-101a-8bbb-00aa00300cab"),
    GUID_FONTSTRIKETHROUGH = GUID("66504312-be0f-101a-8bbb-00aa00300cab"),
}

enum GUID GUID_HANDLE = GUID("66504313-be0f-101a-8bbb-00aa00300cab");

enum : HRESULT
{
    CONNECT_E_LAST  = HRESULT(0x8004020f),
    CONNECT_S_FIRST = HRESULT(0x00040200),
    CONNECT_S_LAST  = HRESULT(0x0004020f),
}

enum : HRESULT
{
    SELFREG_E_LAST  = HRESULT(0x8004020f),
    SELFREG_S_FIRST = HRESULT(0x00040200),
    SELFREG_S_LAST  = HRESULT(0x0004020f),
}

enum : HRESULT
{
    PERPROP_E_LAST  = HRESULT(0x8004020f),
    PERPROP_S_FIRST = HRESULT(0x00040200),
    PERPROP_S_LAST  = HRESULT(0x0004020f),
}

enum int OLEIVERB_PROPERTIES = 0xfffffff9;
enum uint VT_STREAMED_PROPSET = 0x00000049U;
enum uint VT_STORED_PROPSET = 0x0000004aU;
enum uint VT_BLOB_PROPSET = 0x0000004bU;
enum uint VT_VERBOSE_ENUM = 0x0000004cU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/winmsg/ocm--base
enum uint OCM__BASE = 0x00002000U;

enum : int
{
    DISPID_AUTOSIZE    = 0xfffffe0c,
    DISPID_BACKCOLOR   = 0xfffffe0b,
    DISPID_BACKSTYLE   = 0xfffffe0a,
    DISPID_BORDERCOLOR = 0xfffffe09,
    DISPID_BORDERSTYLE = 0xfffffe08,
    DISPID_BORDERWIDTH = 0xfffffe07,
}

enum : int
{
    DISPID_DRAWMODE      = 0xfffffe05,
    DISPID_DRAWSTYLE     = 0xfffffe04,
    DISPID_DRAWWIDTH     = 0xfffffe03,
    DISPID_FILLCOLOR     = 0xfffffe02,
    DISPID_FILLSTYLE     = 0xfffffe01,
    DISPID_FONT          = 0xfffffe00,
    DISPID_FORECOLOR     = 0xfffffdff,
    DISPID_ENABLED       = 0xfffffdfe,
    DISPID_HWND          = 0xfffffdfd,
    DISPID_TABSTOP       = 0xfffffdfc,
    DISPID_TEXT          = 0xfffffdfb,
    DISPID_CAPTION       = 0xfffffdfa,
    DISPID_BORDERVISIBLE = 0xfffffdf9,
}

enum : int
{
    DISPID_APPEARANCE   = 0xfffffdf8,
    DISPID_MOUSEPOINTER = 0xfffffdf7,
    DISPID_MOUSEICON    = 0xfffffdf6,
    DISPID_PICTURE      = 0xfffffdf5,
    DISPID_VALID        = 0xfffffdf4,
    DISPID_READYSTATE   = 0xfffffdf3,
    DISPID_LISTINDEX    = 0xfffffdf2,
    DISPID_SELECTED     = 0xfffffdf1,
    DISPID_LIST         = 0xfffffdf0,
    DISPID_COLUMN       = 0xfffffdef,
    DISPID_LISTCOUNT    = 0xfffffded,
    DISPID_MULTISELECT  = 0xfffffdec,
    DISPID_MAXLENGTH    = 0xfffffdeb,
    DISPID_PASSWORDCHAR = 0xfffffdea,
}

enum : int
{
    DISPID_SCROLLBARS      = 0xfffffde9,
    DISPID_WORDWRAP        = 0xfffffde8,
    DISPID_MULTILINE       = 0xfffffde7,
    DISPID_NUMBEROFROWS    = 0xfffffde6,
    DISPID_NUMBEROFCOLUMNS = 0xfffffde5,
}

enum int DISPID_DISPLAYSTYLE = 0xfffffde4;

enum : int
{
    DISPID_GROUPNAME   = 0xfffffde3,
    DISPID_IMEMODE     = 0xfffffde2,
    DISPID_ACCELERATOR = 0xfffffde1,
}

enum int DISPID_ENTERKEYBEHAVIOR = 0xfffffde0;
enum int DISPID_TABKEYBEHAVIOR = 0xfffffddf;

enum : int
{
    DISPID_SELTEXT          = 0xfffffdde,
    DISPID_SELSTART         = 0xfffffddd,
    DISPID_SELLENGTH        = 0xfffffddc,
    DISPID_REFRESH          = 0xfffffdda,
    DISPID_DOCLICK          = 0xfffffdd9,
    DISPID_ABOUTBOX         = 0xfffffdd8,
    DISPID_ADDITEM          = 0xfffffdd7,
    DISPID_CLEAR            = 0xfffffdd6,
    DISPID_REMOVEITEM       = 0xfffffdd5,
    DISPID_CLICK            = 0xfffffda8,
    DISPID_DBLCLICK         = 0xfffffda7,
    DISPID_KEYDOWN          = 0xfffffda6,
    DISPID_KEYPRESS         = 0xfffffda5,
    DISPID_KEYUP            = 0xfffffda4,
    DISPID_MOUSEDOWN        = 0xfffffda3,
    DISPID_MOUSEMOVE        = 0xfffffda2,
    DISPID_MOUSEUP          = 0xfffffda1,
    DISPID_ERROREVENT       = 0xfffffda0,
    DISPID_READYSTATECHANGE = 0xfffffd9f,
}

enum int DISPID_CLICK_VALUE = 0xfffffd9e;
enum int DISPID_RIGHTTOLEFT = 0xfffffd9d;

enum : int
{
    DISPID_TOPTOBOTTOM               = 0xfffffd9c,
    DISPID_THIS                      = 0xfffffd9b,
    DISPID_AMBIENT_BACKCOLOR         = 0xfffffd43,
    DISPID_AMBIENT_DISPLAYNAME       = 0xfffffd42,
    DISPID_AMBIENT_FONT              = 0xfffffd41,
    DISPID_AMBIENT_FORECOLOR         = 0xfffffd40,
    DISPID_AMBIENT_LOCALEID          = 0xfffffd3f,
    DISPID_AMBIENT_MESSAGEREFLECT    = 0xfffffd3e,
    DISPID_AMBIENT_SCALEUNITS        = 0xfffffd3d,
    DISPID_AMBIENT_TEXTALIGN         = 0xfffffd3c,
    DISPID_AMBIENT_USERMODE          = 0xfffffd3b,
    DISPID_AMBIENT_UIDEAD            = 0xfffffd3a,
    DISPID_AMBIENT_SHOWGRABHANDLES   = 0xfffffd39,
    DISPID_AMBIENT_SHOWHATCHING      = 0xfffffd38,
    DISPID_AMBIENT_DISPLAYASDEFAULT  = 0xfffffd37,
    DISPID_AMBIENT_SUPPORTSMNEMONICS = 0xfffffd36,
    DISPID_AMBIENT_AUTOCLIP          = 0xfffffd35,
    DISPID_AMBIENT_APPEARANCE        = 0xfffffd34,
    DISPID_AMBIENT_CODEPAGE          = 0xfffffd2b,
    DISPID_AMBIENT_PALETTE           = 0xfffffd2a,
    DISPID_AMBIENT_CHARSET           = 0xfffffd29,
    DISPID_AMBIENT_TRANSFERPRIORITY  = 0xfffffd28,
    DISPID_AMBIENT_RIGHTTOLEFT       = 0xfffffd24,
    DISPID_AMBIENT_TOPTOBOTTOM       = 0xfffffd23,
}

enum : int
{
    DISPID_Name   = 0xfffffce0,
    DISPID_Delete = 0xfffffcdf,
    DISPID_Object = 0xfffffcde,
    DISPID_Parent = 0xfffffcdd,
}

enum : uint
{
    DISPID_FONT_NAME    = 0x00000000U,
    DISPID_FONT_SIZE    = 0x00000002U,
    DISPID_FONT_BOLD    = 0x00000003U,
    DISPID_FONT_ITALIC  = 0x00000004U,
    DISPID_FONT_UNDER   = 0x00000005U,
    DISPID_FONT_STRIKE  = 0x00000006U,
    DISPID_FONT_WEIGHT  = 0x00000007U,
    DISPID_FONT_CHARSET = 0x00000008U,
    DISPID_FONT_CHANGED = 0x00000009U,
}

enum : uint
{
    DISPID_PICT_HANDLE = 0x00000000U,
    DISPID_PICT_HPAL   = 0x00000002U,
    DISPID_PICT_TYPE   = 0x00000003U,
    DISPID_PICT_WIDTH  = 0x00000004U,
    DISPID_PICT_HEIGHT = 0x00000005U,
    DISPID_PICT_RENDER = 0x00000006U,
}

// Native encoding: ansi
enum const(wchar)* STDOLE_TLB = "stdole2.tlb";
// Native encoding: ansi
enum const(wchar)* STDTYPE_TLB = "stdole2.tlb";
enum int GC_WCH_SIBLING = 0x00000001;
enum uint TIFLAGS_EXTENDDISPATCHONLY = 0x00000001U;
enum int OLECMDERR_E_NOTSUPPORTED = 0x80040100;

enum : int
{
    MSOCMDERR_E_FIRST        = 0x80040100,
    MSOCMDERR_E_NOTSUPPORTED = 0x80040100,
    MSOCMDERR_E_DISABLED     = 0x80040101,
    MSOCMDERR_E_NOHELP       = 0x80040102,
    MSOCMDERR_E_CANCELED     = 0x80040103,
    MSOCMDERR_E_UNKNOWNGROUP = 0x80040104,
}

enum uint OLECMD_TASKDLGID_ONBEFOREUNLOAD = 0x00000001U;

enum : uint
{
    OLECMDARGINDEX_SHOWPAGEACTIONMENU_HWND     = 0x00000000U,
    OLECMDARGINDEX_SHOWPAGEACTIONMENU_X        = 0x00000001U,
    OLECMDARGINDEX_SHOWPAGEACTIONMENU_Y        = 0x00000002U,
    OLECMDARGINDEX_ACTIVEXINSTALL_PUBLISHER    = 0x00000000U,
    OLECMDARGINDEX_ACTIVEXINSTALL_DISPLAYNAME  = 0x00000001U,
    OLECMDARGINDEX_ACTIVEXINSTALL_CLSID        = 0x00000002U,
    OLECMDARGINDEX_ACTIVEXINSTALL_INSTALLSCOPE = 0x00000003U,
    OLECMDARGINDEX_ACTIVEXINSTALL_SOURCEURL    = 0x00000004U,
}

enum : uint
{
    INSTALL_SCOPE_INVALID = 0x00000000U,
    INSTALL_SCOPE_MACHINE = 0x00000001U,
    INSTALL_SCOPE_USER    = 0x00000002U,
}

enum uint MK_ALT = 0x00000020U;

enum : uint
{
    DD_DEFSCROLLINSET    = 0x0000000bU,
    DD_DEFSCROLLDELAY    = 0x00000032U,
    DD_DEFSCROLLINTERVAL = 0x00000032U,
}

enum : uint
{
    DD_DEFDRAGDELAY   = 0x000000c8U,
    DD_DEFDRAGMINDIST = 0x00000002U,
}

enum : int
{
    OT_LINK     = 0x00000001,
    OT_EMBEDDED = 0x00000002,
}

enum int OT_STATIC = 0x00000003;
enum uint OLEVERB_PRIMARY = 0x00000000U;

enum : uint
{
    OF_SET     = 0x00000001U,
    OF_GET     = 0x00000002U,
    OF_HANDLER = 0x00000004U,
}

enum uint WIN32 = 0x00000064U;

enum : int
{
    OLESTREAM_CONVERSION_DEFAULT        = 0x00000000,
    OLESTREAM_CONVERSION_DISABLEOLELINK = 0x00000001,
}

enum uint IDC_OLEUIHELP = 0x00000063U;

enum : uint
{
    IDC_IO_CREATENEW      = 0x00000834U,
    IDC_IO_CREATEFROMFILE = 0x00000835U,
}

enum : uint
{
    IDC_IO_LINKFILE       = 0x00000836U,
    IDC_IO_OBJECTTYPELIST = 0x00000837U,
}

enum uint IDC_IO_DISPLAYASICON = 0x00000838U;

enum : uint
{
    IDC_IO_CHANGEICON  = 0x00000839U,
    IDC_IO_FILE        = 0x0000083aU,
    IDC_IO_FILEDISPLAY = 0x0000083bU,
}

enum : uint
{
    IDC_IO_RESULTIMAGE = 0x0000083cU,
    IDC_IO_RESULTTEXT  = 0x0000083dU,
    IDC_IO_ICONDISPLAY = 0x0000083eU,
}

enum uint IDC_IO_OBJECTTYPETEXT = 0x0000083fU;

enum : uint
{
    IDC_IO_FILETEXT      = 0x00000840U,
    IDC_IO_FILETYPE      = 0x00000841U,
    IDC_IO_INSERTCONTROL = 0x00000842U,
}

enum : uint
{
    IDC_IO_ADDCONTROL      = 0x00000843U,
    IDC_IO_CONTROLTYPELIST = 0x00000844U,
}

enum : uint
{
    IDC_PS_PASTE         = 0x000001f4U,
    IDC_PS_PASTELINK     = 0x000001f5U,
    IDC_PS_SOURCETEXT    = 0x000001f6U,
    IDC_PS_PASTELIST     = 0x000001f7U,
    IDC_PS_PASTELINKLIST = 0x000001f8U,
}

enum : uint
{
    IDC_PS_DISPLAYLIST   = 0x000001f9U,
    IDC_PS_DISPLAYASICON = 0x000001faU,
}

enum uint IDC_PS_ICONDISPLAY = 0x000001fbU;

enum : uint
{
    IDC_PS_CHANGEICON  = 0x000001fcU,
    IDC_PS_RESULTIMAGE = 0x000001fdU,
    IDC_PS_RESULTTEXT  = 0x000001feU,
}

enum : uint
{
    IDC_CI_GROUP       = 0x00000078U,
    IDC_CI_CURRENT     = 0x00000079U,
    IDC_CI_CURRENTICON = 0x0000007aU,
}

enum : uint
{
    IDC_CI_DEFAULT     = 0x0000007bU,
    IDC_CI_DEFAULTICON = 0x0000007cU,
}

enum : uint
{
    IDC_CI_FROMFILE     = 0x0000007dU,
    IDC_CI_FROMFILEEDIT = 0x0000007eU,
}

enum : uint
{
    IDC_CI_ICONLIST    = 0x0000007fU,
    IDC_CI_LABEL       = 0x00000080U,
    IDC_CI_LABELEDIT   = 0x00000081U,
    IDC_CI_BROWSE      = 0x00000082U,
    IDC_CI_ICONDISPLAY = 0x00000083U,
}

enum : uint
{
    IDC_CV_OBJECTTYPE    = 0x00000096U,
    IDC_CV_DISPLAYASICON = 0x00000098U,
}

enum : uint
{
    IDC_CV_CHANGEICON   = 0x00000099U,
    IDC_CV_ACTIVATELIST = 0x0000009aU,
}

enum : uint
{
    IDC_CV_CONVERTTO   = 0x0000009bU,
    IDC_CV_ACTIVATEAS  = 0x0000009cU,
    IDC_CV_RESULTTEXT  = 0x0000009dU,
    IDC_CV_CONVERTLIST = 0x0000009eU,
}

enum uint IDC_CV_ICONDISPLAY = 0x000000a5U;
enum uint IDC_EL_CHANGESOURCE = 0x000000c9U;

enum : uint
{
    IDC_EL_AUTOMATIC    = 0x000000caU,
    IDC_EL_CANCELLINK   = 0x000000d1U,
    IDC_EL_UPDATENOW    = 0x000000d2U,
    IDC_EL_OPENSOURCE   = 0x000000d3U,
    IDC_EL_MANUAL       = 0x000000d4U,
    IDC_EL_LINKSOURCE   = 0x000000d8U,
    IDC_EL_LINKTYPE     = 0x000000d9U,
    IDC_EL_LINKSLISTBOX = 0x000000ceU,
}

enum : uint
{
    IDC_EL_COL1 = 0x000000dcU,
    IDC_EL_COL2 = 0x000000ddU,
    IDC_EL_COL3 = 0x000000deU,
}

enum : uint
{
    IDC_BZ_RETRY    = 0x00000258U,
    IDC_BZ_ICON     = 0x00000259U,
    IDC_BZ_MESSAGE1 = 0x0000025aU,
    IDC_BZ_SWITCHTO = 0x0000025cU,
}

enum : uint
{
    IDC_UL_METER    = 0x00000405U,
    IDC_UL_STOP     = 0x00000406U,
    IDC_UL_PERCENT  = 0x00000407U,
    IDC_UL_PROGRESS = 0x00000408U,
}

enum : uint
{
    IDC_PU_LINKS   = 0x00000384U,
    IDC_PU_TEXT    = 0x00000385U,
    IDC_PU_CONVERT = 0x00000386U,
    IDC_PU_ICON    = 0x0000038cU,
}

enum : uint
{
    IDC_GP_OBJECTNAME     = 0x000003f1U,
    IDC_GP_OBJECTTYPE     = 0x000003f2U,
    IDC_GP_OBJECTSIZE     = 0x000003f3U,
    IDC_GP_CONVERT        = 0x000003f5U,
    IDC_GP_OBJECTICON     = 0x000003f6U,
    IDC_GP_OBJECTLOCATION = 0x000003feU,
}

enum : uint
{
    IDC_VP_PERCENT     = 0x000003e8U,
    IDC_VP_CHANGEICON  = 0x000003e9U,
    IDC_VP_EDITABLE    = 0x000003eaU,
    IDC_VP_ASICON      = 0x000003ebU,
    IDC_VP_RELATIVE    = 0x000003edU,
    IDC_VP_SPIN        = 0x000003eeU,
    IDC_VP_SCALETXT    = 0x0000040aU,
    IDC_VP_ICONDISPLAY = 0x000003fdU,
}

enum uint IDC_VP_RESULTIMAGE = 0x00000409U;

enum : uint
{
    IDC_LP_OPENSOURCE   = 0x000003eeU,
    IDC_LP_UPDATENOW    = 0x000003efU,
    IDC_LP_BREAKLINK    = 0x000003f0U,
    IDC_LP_LINKSOURCE   = 0x000003f4U,
    IDC_LP_CHANGESOURCE = 0x000003f7U,
}

enum : uint
{
    IDC_LP_AUTOMATIC = 0x000003f8U,
    IDC_LP_MANUAL    = 0x000003f9U,
    IDC_LP_DATE      = 0x000003faU,
    IDC_LP_TIME      = 0x000003fbU,
}

enum uint IDD_INSERTOBJECT = 0x000003e8U;
enum uint IDD_CHANGEICON = 0x000003e9U;
enum uint IDD_CONVERT = 0x000003eaU;
enum uint IDD_PASTESPECIAL = 0x000003ebU;
enum uint IDD_EDITLINKS = 0x000003ecU;

enum : uint
{
    IDD_BUSY        = 0x000003eeU,
    IDD_UPDATELINKS = 0x000003efU,
}

enum uint IDD_CHANGESOURCE = 0x000003f1U;
enum uint IDD_INSERTFILEBROWSE = 0x000003f2U;
enum uint IDD_CHANGEICONBROWSE = 0x000003f3U;
enum uint IDD_CONVERTONLY = 0x000003f4U;
enum uint IDD_CHANGESOURCE4 = 0x000003f5U;
enum uint IDD_GNRLPROPS = 0x0000044cU;
enum uint IDD_VIEWPROPS = 0x0000044dU;
enum uint IDD_LINKPROPS = 0x0000044eU;

enum : uint
{
    IDD_CONVERT4     = 0x0000044fU,
    IDD_CONVERTONLY4 = 0x00000450U,
}

enum uint IDD_EDITLINKS4 = 0x00000451U;
enum uint IDD_GNRLPROPS4 = 0x00000452U;
enum uint IDD_LINKPROPS4 = 0x00000453U;
enum uint IDD_PASTESPECIAL4 = 0x00000454U;
enum uint IDD_CANNOTUPDATELINK = 0x000003f0U;
enum uint IDD_LINKSOURCEUNAVAILABLE = 0x000003fcU;
enum uint IDD_SERVERNOTFOUND = 0x000003ffU;
enum uint IDD_OUTOFMEMORY = 0x00000400U;
enum uint IDD_SERVERNOTREGW = 0x000003fdU;
enum uint IDD_LINKTYPECHANGEDW = 0x000003feU;
enum uint IDD_SERVERNOTREGA = 0x00000401U;
enum uint IDD_LINKTYPECHANGEDA = 0x00000402U;
enum uint IDD_SERVERNOTREG = 0x000003fdU;
enum uint IDD_LINKTYPECHANGED = 0x000003feU;
enum const(wchar)* OLESTDDELIM = "\\";

enum : const(wchar)*
{
    SZOLEUI_MSG_HELP            = "OLEUI_MSG_HELP",
    SZOLEUI_MSG_ENDDIALOG       = "OLEUI_MSG_ENDDIALOG",
    SZOLEUI_MSG_BROWSE          = "OLEUI_MSG_BROWSE",
    SZOLEUI_MSG_CHANGEICON      = "OLEUI_MSG_CHANGEICON",
    SZOLEUI_MSG_CLOSEBUSYDIALOG = "OLEUI_MSG_CLOSEBUSYDIALOG",
    SZOLEUI_MSG_CONVERT         = "OLEUI_MSG_CONVERT",
    SZOLEUI_MSG_CHANGESOURCE    = "OLEUI_MSG_CHANGESOURCE",
    SZOLEUI_MSG_ADDCONTROL      = "OLEUI_MSG_ADDCONTROL",
    SZOLEUI_MSG_BROWSE_OFN      = "OLEUI_MSG_BROWSE_OFN",
}

enum : uint
{
    ID_BROWSE_CHANGEICON   = 0x00000001U,
    ID_BROWSE_INSERTFILE   = 0x00000002U,
    ID_BROWSE_ADDCONTROL   = 0x00000003U,
    ID_BROWSE_CHANGESOURCE = 0x00000004U,
}

enum : uint
{
    OLEUI_FALSE                = 0x00000000U,
    OLEUI_SUCCESS              = 0x00000001U,
    OLEUI_OK                   = 0x00000001U,
    OLEUI_CANCEL               = 0x00000002U,
    OLEUI_ERR_STANDARDMIN      = 0x00000064U,
    OLEUI_ERR_OLEMEMALLOC      = 0x00000064U,
    OLEUI_ERR_STRUCTURENULL    = 0x00000065U,
    OLEUI_ERR_STRUCTUREINVALID = 0x00000066U,
}

enum uint OLEUI_ERR_CBSTRUCTINCORRECT = 0x00000067U;
enum uint OLEUI_ERR_HWNDOWNERINVALID = 0x00000068U;

enum : uint
{
    OLEUI_ERR_LPSZCAPTIONINVALID = 0x00000069U,
    OLEUI_ERR_LPFNHOOKINVALID    = 0x0000006aU,
}

enum uint OLEUI_ERR_HINSTANCEINVALID = 0x0000006bU;
enum uint OLEUI_ERR_LPSZTEMPLATEINVALID = 0x0000006cU;
enum uint OLEUI_ERR_HRESOURCEINVALID = 0x0000006dU;
enum uint OLEUI_ERR_FINDTEMPLATEFAILURE = 0x0000006eU;
enum uint OLEUI_ERR_LOADTEMPLATEFAILURE = 0x0000006fU;

enum : uint
{
    OLEUI_ERR_DIALOGFAILURE  = 0x00000070U,
    OLEUI_ERR_LOCALMEMALLOC  = 0x00000071U,
    OLEUI_ERR_GLOBALMEMALLOC = 0x00000072U,
    OLEUI_ERR_LOADSTRING     = 0x00000073U,
    OLEUI_ERR_STANDARDMAX    = 0x00000074U,
}

enum : uint
{
    OLEUI_IOERR_LPSZFILEINVALID    = 0x00000074U,
    OLEUI_IOERR_LPSZLABELINVALID   = 0x00000075U,
    OLEUI_IOERR_HICONINVALID       = 0x00000076U,
    OLEUI_IOERR_LPFORMATETCINVALID = 0x00000077U,
}

enum : uint
{
    OLEUI_IOERR_PPVOBJINVALID           = 0x00000078U,
    OLEUI_IOERR_LPIOLECLIENTSITEINVALID = 0x00000079U,
    OLEUI_IOERR_LPISTORAGEINVALID       = 0x0000007aU,
    OLEUI_IOERR_SCODEHASERROR           = 0x0000007bU,
    OLEUI_IOERR_LPCLSIDEXCLUDEINVALID   = 0x0000007cU,
}

enum uint OLEUI_IOERR_CCHFILEINVALID = 0x0000007dU;
enum uint PS_MAXLINKTYPES = 0x00000008U;
enum uint OLEUI_IOERR_SRCDATAOBJECTINVALID = 0x00000074U;

enum : uint
{
    OLEUI_IOERR_ARRPASTEENTRIESINVALID = 0x00000075U,
    OLEUI_IOERR_ARRLINKTYPESINVALID    = 0x00000076U,
}

enum : uint
{
    OLEUI_PSERR_CLIPBOARDCHANGED   = 0x00000077U,
    OLEUI_PSERR_GETCLIPBOARDFAILED = 0x00000078U,
}

enum : uint
{
    OLEUI_ELERR_LINKCNTRNULL    = 0x00000074U,
    OLEUI_ELERR_LINKCNTRINVALID = 0x00000075U,
}

enum : uint
{
    OLEUI_CIERR_MUSTHAVECLSID           = 0x00000074U,
    OLEUI_CIERR_MUSTHAVECURRENTMETAFILE = 0x00000075U,
}

enum uint OLEUI_CIERR_SZICONEXEINVALID = 0x00000076U;
enum const(wchar)* PROP_HWND_CHGICONDLG = "HWND_CIDLG";

enum : uint
{
    OLEUI_CTERR_CLASSIDINVALID   = 0x00000075U,
    OLEUI_CTERR_DVASPECTINVALID  = 0x00000076U,
    OLEUI_CTERR_CBFORMATINVALID  = 0x00000077U,
    OLEUI_CTERR_HMETAPICTINVALID = 0x00000078U,
    OLEUI_CTERR_STRINGINVALID    = 0x00000079U,
}

enum uint OLEUI_BZERR_HTASKINVALID = 0x00000074U;
enum uint OLEUI_BZ_SWITCHTOSELECTED = 0x00000075U;

enum : uint
{
    OLEUI_BZ_RETRYSELECTED = 0x00000076U,
    OLEUI_BZ_CALLUNBLOCKED = 0x00000077U,
}

enum : uint
{
    OLEUI_CSERR_LINKCNTRNULL     = 0x00000074U,
    OLEUI_CSERR_LINKCNTRINVALID  = 0x00000075U,
    OLEUI_CSERR_FROMNOTNULL      = 0x00000076U,
    OLEUI_CSERR_TONOTNULL        = 0x00000077U,
    OLEUI_CSERR_SOURCENULL       = 0x00000078U,
    OLEUI_CSERR_SOURCEINVALID    = 0x00000079U,
    OLEUI_CSERR_SOURCEPARSERROR  = 0x0000007aU,
    OLEUI_CSERR_SOURCEPARSEERROR = 0x0000007aU,
}

enum : uint
{
    OLEUI_OPERR_SUBPROPNULL      = 0x00000074U,
    OLEUI_OPERR_SUBPROPINVALID   = 0x00000075U,
    OLEUI_OPERR_PROPSHEETNULL    = 0x00000076U,
    OLEUI_OPERR_PROPSHEETINVALID = 0x00000077U,
    OLEUI_OPERR_SUPPROP          = 0x00000078U,
    OLEUI_OPERR_PROPSINVALID     = 0x00000079U,
    OLEUI_OPERR_PAGESINCORRECT   = 0x0000007aU,
    OLEUI_OPERR_INVALIDPAGES     = 0x0000007bU,
    OLEUI_OPERR_NOTSUPPORTED     = 0x0000007cU,
    OLEUI_OPERR_DLGPROCNOTNULL   = 0x0000007dU,
    OLEUI_OPERR_LPARAMNOTZERO    = 0x0000007eU,
}

enum : uint
{
    OLEUI_GPERR_STRINGINVALID         = 0x0000007fU,
    OLEUI_GPERR_CLASSIDINVALID        = 0x00000080U,
    OLEUI_GPERR_LPCLSIDEXCLUDEINVALID = 0x00000081U,
}

enum uint OLEUI_GPERR_CBFORMATINVALID = 0x00000082U;

enum : uint
{
    OLEUI_VPERR_METAPICTINVALID = 0x00000083U,
    OLEUI_VPERR_DVASPECTINVALID = 0x00000084U,
}

enum : uint
{
    OLEUI_LPERR_LINKCNTRNULL    = 0x00000085U,
    OLEUI_LPERR_LINKCNTRINVALID = 0x00000086U,
}

enum : uint
{
    OLEUI_OPERR_PROPERTYSHEET   = 0x00000087U,
    OLEUI_OPERR_OBJINFOINVALID  = 0x00000088U,
    OLEUI_OPERR_LINKINFOINVALID = 0x00000089U,
}

enum : uint
{
    OLEUI_QUERY_GETCLASSID = 0x0000ff00U,
    OLEUI_QUERY_LINKBROKEN = 0x0000ff01U,
}

enum int DISPID_UNKNOWN = 0xffffffff;
enum uint DISPID_VALUE = 0x00000000U;
enum int DISPID_PROPERTYPUT = 0xfffffffd;

enum : int
{
    DISPID_NEWENUM     = 0xfffffffc,
    DISPID_EVALUATE    = 0xfffffffb,
    DISPID_CONSTRUCTOR = 0xfffffffa,
}

enum : int
{
    DISPID_DESTRUCTOR = 0xfffffff9,
    DISPID_COLLECT    = 0xfffffff8,
}

enum : uint
{
    STDOLE_MAJORVERNUM = 0x00000001U,
    STDOLE_MINORVERNUM = 0x00000000U,
}

enum : uint
{
    STDOLE_LCID         = 0x00000000U,
    STDOLE2_MAJORVERNUM = 0x00000002U,
    STDOLE2_MINORVERNUM = 0x00000000U,
    STDOLE2_LCID        = 0x00000000U,
}

enum uint VAR_TIMEVALUEONLY = 0x00000001U;
enum uint VAR_DATEVALUEONLY = 0x00000002U;
enum uint VAR_VALIDDATE = 0x00000004U;
enum uint VAR_CALENDAR_HIJRI = 0x00000008U;
enum uint VAR_LOCALBOOL = 0x00000010U;
enum uint VAR_FORMAT_NOSUBSTITUTE = 0x00000020U;
enum uint VAR_FOURDIGITYEARS = 0x00000040U;
enum uint LOCALE_USE_NLS = 0x10000000U;

enum : uint
{
    VAR_CALENDAR_THAI      = 0x00000080U,
    VAR_CALENDAR_GREGORIAN = 0x00000100U,
}

enum uint VTDATEGRE_MAX = 0x002d2481U;
enum int VTDATEGRE_MIN = 0xfff5f7e6;
enum int MEMBERID_NIL = 0xffffffff;
enum int ID_DEFAULTINST = 0xfffffffe;

enum : uint
{
    LOAD_TLB_AS_32BIT = 0x00000020U,
    LOAD_TLB_AS_64BIT = 0x00000040U,
}

enum int fdexNameCaseSensitive = 0x00000001;

enum : int
{
    fdexNameEnsure          = 0x00000002,
    fdexNameImplicit        = 0x00000004,
    fdexNameCaseInsensitive = 0x00000008,
}

enum : int
{
    fdexNameInternal            = 0x00000010,
    fdexNameNoDynamicProperties = 0x00000020,
}

enum : int
{
    fdexEnumDefault = 0x00000001,
    fdexEnumAll     = 0x00000002,
}

enum uint DISPATCH_CONSTRUCT = 0x00004000U;
enum int DISPID_STARTENUM = 0xffffffff;
enum GUID SID_VariantConversion = GUID("1f101481-bccd-11d0-9336-00a0c90dcaa9");
enum GUID SID_GetCaller = GUID("4717cc40-bcb9-11d0-9336-00a0c90dcaa9");
enum GUID SID_ProvideRuntimeContext = GUID("74a5040c-dd0c-48f0-ac85-194c3259180a");

// Callbacks

alias OLESTREAMQUERYCONVERTOLELINKCALLBACK = HRESULT function(GUID* pClsid, PWSTR szClass, PWSTR szTopicName, 
                                                              PWSTR szItemName, PWSTR szUNCName, 
                                                              uint linkUpdatingOption, void* pvContext);
alias LPFNOLEUIHOOK = uint function(HWND param0, uint param1, WPARAM param2, LPARAM param3);

// Structs


//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct OLE_HANDLE
{
    uint Value;
}

struct SAFEARR_BSTR
{
    uint                Size;
    FLAGGED_WORD_BLOB** aBstr;
}

struct SAFEARR_UNKNOWN
{
    uint      Size;
    IUnknown* apUnknown;
}

struct SAFEARR_DISPATCH
{
    uint       Size;
    IDispatch* apDispatch;
}

struct SAFEARR_VARIANT
{
    uint           Size;
    _wireVARIANT** aVariant;
}

struct SAFEARR_BRECORD
{
    uint           Size;
    _wireBRECORD** aRecord;
}

struct SAFEARR_HAVEIID
{
    uint      Size;
    IUnknown* apUnknown;
    GUID      iid;
}

struct SAFEARRAYUNION
{
    uint sfType;
    union u
    {
        SAFEARR_BSTR     BstrStr;
        SAFEARR_UNKNOWN  UnknownStr;
        SAFEARR_DISPATCH DispatchStr;
        SAFEARR_VARIANT  VariantStr;
        SAFEARR_BRECORD  RecordStr;
        SAFEARR_HAVEIID  HaveIidStr;
        BYTE_SIZEDARR    ByteStr;
        WORD_SIZEDARR    WordStr;
        DWORD_SIZEDARR   LongStr;
        HYPER_SIZEDARR   HyperStr;
    }
}

struct _wireSAFEARRAY
{
    ushort            cDims;
    ushort            fFeatures;
    uint              cbElements;
    uint              cLocks;
    SAFEARRAYUNION    uArrayStructs;
    SAFEARRAYBOUND[1] rgsabound; // Flexible array
}

struct _wireBRECORD
{
    uint        fFlags;
    uint        clSize;
    IRecordInfo pRecInfo;
    ubyte*      pRecord;
}

struct _wireVARIANT
{
    uint   clSize;
    uint   rpcReserved;
    ushort vt;
    ushort wReserved1;
    ushort wReserved2;
    ushort wReserved3;
    union
    {
        long                llVal;
        int                 lVal;
        ubyte               bVal;
        short               iVal;
        float               fltVal;
        double              dblVal;
        VARIANT_BOOL        boolVal;
        int                 scode;
        CY                  cyVal;
        double              date;
        FLAGGED_WORD_BLOB*  bstrVal;
        IUnknown            punkVal;
        IDispatch           pdispVal;
        _wireSAFEARRAY**    parray;
        _wireBRECORD*       brecVal;
        ubyte*              pbVal;
        short*              piVal;
        int*                plVal;
        long*               pllVal;
        float*              pfltVal;
        double*             pdblVal;
        VARIANT_BOOL*       pboolVal;
        int*                pscode;
        CY*                 pcyVal;
        double*             pdate;
        FLAGGED_WORD_BLOB** pbstrVal;
        IUnknown*           ppunkVal;
        IDispatch*          ppdispVal;
        _wireSAFEARRAY***   pparray;
        _wireVARIANT**      pvarVal;
        CHAR                cVal;
        ushort              uiVal;
        uint                ulVal;
        ulong               ullVal;
        int                 intVal;
        uint                uintVal;
        DECIMAL             decVal;
        DECIMAL*            pdecVal;
        PSTR                pcVal;
        ushort*             puiVal;
        uint*               pulVal;
        ulong*              pullVal;
        int*                pintVal;
        uint*               puintVal;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/ns-oaidl-arraydesc
struct ARRAYDESC
{
    TYPEDESC          tdescElem;
    ushort            cDims;
    SAFEARRAYBOUND[1] rgbounds; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/ns-oaidl-paramdescex
struct PARAMDESCEX
{
    uint    cBytes;
    VARIANT varDefaultValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/ns-oaidl-paramdesc
struct PARAMDESC
{
    PARAMDESCEX* pparamdescex;
    PARAMFLAGS   wParamFlags;
}

struct CLEANLOCALSTORAGE
{
    IUnknown pInterface;
    void*    pStorage;
    uint     flags;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/ns-oleidl-objectdescriptor
struct OBJECTDESCRIPTOR
{
    uint   cbSize;
    GUID   clsid;
    uint   dwDrawAspect;
    SIZE   sizel;
    POINTL pointl;
    uint   dwStatus;
    uint   dwFullUserTypeName;
    uint   dwSrcOfCopy;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/ns-oleidl-oleinplaceframeinfo
struct OLEINPLACEFRAMEINFO
{
    uint   cb;
    BOOL   fMDIApp;
    HWND   hwndFrame;
    HACCEL haccel;
    uint   cAccelEntries;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/ns-oleidl-olemenugroupwidths
struct OLEMENUGROUPWIDTHS
{
    int[6] width;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/ns-oleidl-oleverb
struct OLEVERB
{
    OLEIVERB        lVerb;
    PWSTR           lpszVerbName;
    MENU_ITEM_FLAGS fuFlags;
    uint            grfAttribs;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/ns-oleauto-numparse
struct NUMPARSE
{
    int            cDig;
    NUMPARSE_FLAGS dwInFlags;
    NUMPARSE_FLAGS dwOutFlags;
    int            cchUsed;
    int            nBaseShift;
    int            nPwr10;
}

struct UDATE
{
    SYSTEMTIME st;
    ushort     wDayOfYear;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/ns-oleauto-paramdata
struct PARAMDATA
{
    PWSTR   szName;
    VARENUM vt;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/ns-oleauto-methoddata
struct METHODDATA
{
    PWSTR      szName;
    PARAMDATA* ppdata;
    int        dispid;
    uint       iMeth;
    CALLCONV   cc;
    uint       cArgs;
    ushort     wFlags;
    VARENUM    vtReturn;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/ns-oleauto-interfacedata
struct INTERFACEDATA
{
    METHODDATA* pmethdata;
    uint        cMembers;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ns-ocidl-licinfo
struct LICINFO
{
    int  cbLicInfo;
    BOOL fRuntimeKeyAvail;
    BOOL fLicVerified;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ns-ocidl-controlinfo
struct CONTROLINFO
{
    uint   cb;
    HACCEL hAccel;
    ushort cAccel;
    uint   dwFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ns-ocidl-pointf
struct POINTF
{
    float x;
    float y;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ns-ocidl-proppageinfo
struct PROPPAGEINFO
{
    uint  cb;
    PWSTR pszTitle;
    SIZE  size;
    PWSTR pszDocString;
    PWSTR pszHelpFile;
    uint  dwHelpContext;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ns-ocidl-cauuid
struct CAUUID
{
    uint  cElems;
    GUID* pElems;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ns-ocidl-dvextentinfo
struct DVEXTENTINFO
{
    uint cb;
    uint dwExtentMode;
    SIZE sizelProposed;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ns-ocidl-dvaspectinfo
struct DVASPECTINFO
{
    uint cb;
    uint dwFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ns-ocidl-calpolestr
struct CALPOLESTR
{
    uint   cElems;
    PWSTR* pElems;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ns-ocidl-cadword
struct CADWORD
{
    uint  cElems;
    uint* pElems;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ns-ocidl-qacontainer
struct QACONTAINER
{
    uint                cbSize;
    IOleClientSite      pClientSite;
    IAdviseSinkEx       pAdviseSink;
    IPropertyNotifySink pPropertyNotifySink;
    IUnknown            pUnkEventSink;
    uint                dwAmbientFlags;
    uint                colorFore;
    uint                colorBack;
    IFont               pFont;
    IOleUndoManager     pUndoMgr;
    uint                dwAppearance;
    int                 lcid;
    HPALETTE            hpal;
    IBindHost           pBindHost;
    IOleControlSite     pOleControlSite;
    IServiceProvider    pServiceProvider;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/ns-ocidl-qacontrol
struct QACONTROL
{
    uint cbSize;
    uint dwMiscStatus;
    uint dwViewStatus;
    uint dwEventCookie;
    uint dwPropNotifyCookie;
    uint dwPointerActivationPolicy;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/olectl/ns-olectl-ocpfiparams
struct OCPFIPARAMS
{
    uint         cbStructSize;
    HWND         hWndOwner;
    int          x;
    int          y;
    const(PWSTR) lpszCaption;
    uint         cObjects;
    IUnknown*    lplpUnk;
    uint         cPages;
    GUID*        lpPages;
    uint         lcid;
    int          dispidInitialProperty;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/olectl/ns-olectl-fontdesc
struct FONTDESC
{
    uint  cbSizeofstruct;
    PWSTR lpstrName;
    CY    cySize;
    short sWeight;
    short sCharset;
    BOOL  fItalic;
    BOOL  fUnderline;
    BOOL  fStrikethrough;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/olectl/ns-olectl-pictdesc
struct PICTDESC
{
    uint cbSizeofstruct;
    uint picType;
    union
    {
        struct bmp
        {
            HBITMAP  hbitmap;
            HPALETTE hpal;
        }
        struct wmf
        {
            HMETAFILE hmeta;
            int       xExt;
            int       yExt;
        }
        struct icon
        {
            HICON hicon;
        }
        struct emf
        {
            HENHMETAFILE hemf;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/ns-docobj-pagerange
struct PAGERANGE
{
    int nFromPage;
    int nToPage;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/ns-docobj-pageset
struct PAGESET
{
    uint         cbStruct;
    BOOL         fOddPages;
    BOOL         fEvenPages;
    uint         cPageRange;
    PAGERANGE[1] rgPages; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/ns-docobj-olecmd
struct OLECMD
{
    uint cmdID;
    uint cmdf;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/ns-docobj-olecmdtext
struct OLECMDTEXT
{
    uint     cmdtextf;
    uint     cwActual;
    uint     cwBuf;
    wchar[1] rgwz; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuiinsertobjectw
struct OLEUIINSERTOBJECTW
{
    uint                cbStruct;
    INSERT_OBJECT_FLAGS dwFlags;
    HWND                hWndOwner;
    const(PWSTR)        lpszCaption;
    LPFNOLEUIHOOK       lpfnHook;
    LPARAM              lCustData;
    HINSTANCE           hInstance;
    const(PWSTR)        lpszTemplate;
    HRSRC               hResource;
    GUID                clsid;
    PWSTR               lpszFile;
    uint                cchFile;
    uint                cClsidExclude;
    GUID*               lpClsidExclude;
    GUID                iid;
    uint                oleRender;
    FORMATETC*          lpFormatEtc;
    IOleClientSite      lpIOleClientSite;
    IStorage            lpIStorage;
    void**              ppvObj;
    int                 sc;
    HGLOBAL             hMetaPict;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuiinsertobjecta
struct OLEUIINSERTOBJECTA
{
    uint                cbStruct;
    INSERT_OBJECT_FLAGS dwFlags;
    HWND                hWndOwner;
    const(PSTR)         lpszCaption;
    LPFNOLEUIHOOK       lpfnHook;
    LPARAM              lCustData;
    HINSTANCE           hInstance;
    const(PSTR)         lpszTemplate;
    HRSRC               hResource;
    GUID                clsid;
    PSTR                lpszFile;
    uint                cchFile;
    uint                cClsidExclude;
    GUID*               lpClsidExclude;
    GUID                iid;
    uint                oleRender;
    FORMATETC*          lpFormatEtc;
    IOleClientSite      lpIOleClientSite;
    IStorage            lpIStorage;
    void**              ppvObj;
    int                 sc;
    HGLOBAL             hMetaPict;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuipasteentryw
struct OLEUIPASTEENTRYW
{
    FORMATETC    fmtetc;
    const(PWSTR) lpstrFormatName;
    const(PWSTR) lpstrResultText;
    uint         dwFlags;
    uint         dwScratchSpace;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuipasteentrya
struct OLEUIPASTEENTRYA
{
    FORMATETC   fmtetc;
    const(PSTR) lpstrFormatName;
    const(PSTR) lpstrResultText;
    uint        dwFlags;
    uint        dwScratchSpace;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuipastespecialw
struct OLEUIPASTESPECIALW
{
    uint                cbStruct;
    PASTE_SPECIAL_FLAGS dwFlags;
    HWND                hWndOwner;
    const(PWSTR)        lpszCaption;
    LPFNOLEUIHOOK       lpfnHook;
    LPARAM              lCustData;
    HINSTANCE           hInstance;
    const(PWSTR)        lpszTemplate;
    HRSRC               hResource;
    IDataObject         lpSrcDataObj;
    OLEUIPASTEENTRYW*   arrPasteEntries;
    int                 cPasteEntries;
    uint*               arrLinkTypes;
    int                 cLinkTypes;
    uint                cClsidExclude;
    GUID*               lpClsidExclude;
    int                 nSelectedIndex;
    BOOL                fLink;
    HGLOBAL             hMetaPict;
    SIZE                sizel;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuipastespeciala
struct OLEUIPASTESPECIALA
{
    uint                cbStruct;
    PASTE_SPECIAL_FLAGS dwFlags;
    HWND                hWndOwner;
    const(PSTR)         lpszCaption;
    LPFNOLEUIHOOK       lpfnHook;
    LPARAM              lCustData;
    HINSTANCE           hInstance;
    const(PSTR)         lpszTemplate;
    HRSRC               hResource;
    IDataObject         lpSrcDataObj;
    OLEUIPASTEENTRYA*   arrPasteEntries;
    int                 cPasteEntries;
    uint*               arrLinkTypes;
    int                 cLinkTypes;
    uint                cClsidExclude;
    GUID*               lpClsidExclude;
    int                 nSelectedIndex;
    BOOL                fLink;
    HGLOBAL             hMetaPict;
    SIZE                sizel;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuieditlinksw
struct OLEUIEDITLINKSW
{
    uint                 cbStruct;
    EDIT_LINKS_FLAGS     dwFlags;
    HWND                 hWndOwner;
    const(PWSTR)         lpszCaption;
    LPFNOLEUIHOOK        lpfnHook;
    LPARAM               lCustData;
    HINSTANCE            hInstance;
    const(PWSTR)         lpszTemplate;
    HRSRC                hResource;
    IOleUILinkContainerW lpOleUILinkContainer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuieditlinksa
struct OLEUIEDITLINKSA
{
    uint                 cbStruct;
    EDIT_LINKS_FLAGS     dwFlags;
    HWND                 hWndOwner;
    const(PSTR)          lpszCaption;
    LPFNOLEUIHOOK        lpfnHook;
    LPARAM               lCustData;
    HINSTANCE            hInstance;
    const(PSTR)          lpszTemplate;
    HRSRC                hResource;
    IOleUILinkContainerA lpOleUILinkContainer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuichangeiconw
struct OLEUICHANGEICONW
{
    uint              cbStruct;
    CHANGE_ICON_FLAGS dwFlags;
    HWND              hWndOwner;
    const(PWSTR)      lpszCaption;
    LPFNOLEUIHOOK     lpfnHook;
    LPARAM            lCustData;
    HINSTANCE         hInstance;
    const(PWSTR)      lpszTemplate;
    HRSRC             hResource;
    HGLOBAL           hMetaPict;
    GUID              clsid;
    wchar[260]        szIconExe;
    int               cchIconExe;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuichangeicona
struct OLEUICHANGEICONA
{
    uint              cbStruct;
    CHANGE_ICON_FLAGS dwFlags;
    HWND              hWndOwner;
    const(PSTR)       lpszCaption;
    LPFNOLEUIHOOK     lpfnHook;
    LPARAM            lCustData;
    HINSTANCE         hInstance;
    const(PSTR)       lpszTemplate;
    HRSRC             hResource;
    HGLOBAL           hMetaPict;
    GUID              clsid;
    CHAR[260]         szIconExe;
    int               cchIconExe;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuiconvertw
struct OLEUICONVERTW
{
    uint             cbStruct;
    UI_CONVERT_FLAGS dwFlags;
    HWND             hWndOwner;
    const(PWSTR)     lpszCaption;
    LPFNOLEUIHOOK    lpfnHook;
    LPARAM           lCustData;
    HINSTANCE        hInstance;
    const(PWSTR)     lpszTemplate;
    HRSRC            hResource;
    GUID             clsid;
    GUID             clsidConvertDefault;
    GUID             clsidActivateDefault;
    GUID             clsidNew;
    uint             dvAspect;
    ushort           wFormat;
    BOOL             fIsLinkedObject;
    HGLOBAL          hMetaPict;
    PWSTR            lpszUserType;
    BOOL             fObjectsIconChanged;
    PWSTR            lpszDefLabel;
    uint             cClsidExclude;
    GUID*            lpClsidExclude;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuiconverta
struct OLEUICONVERTA
{
    uint             cbStruct;
    UI_CONVERT_FLAGS dwFlags;
    HWND             hWndOwner;
    const(PSTR)      lpszCaption;
    LPFNOLEUIHOOK    lpfnHook;
    LPARAM           lCustData;
    HINSTANCE        hInstance;
    const(PSTR)      lpszTemplate;
    HRSRC            hResource;
    GUID             clsid;
    GUID             clsidConvertDefault;
    GUID             clsidActivateDefault;
    GUID             clsidNew;
    uint             dvAspect;
    ushort           wFormat;
    BOOL             fIsLinkedObject;
    HGLOBAL          hMetaPict;
    PSTR             lpszUserType;
    BOOL             fObjectsIconChanged;
    PSTR             lpszDefLabel;
    uint             cClsidExclude;
    GUID*            lpClsidExclude;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuibusyw
struct OLEUIBUSYW
{
    uint              cbStruct;
    BUSY_DIALOG_FLAGS dwFlags;
    HWND              hWndOwner;
    const(PWSTR)      lpszCaption;
    LPFNOLEUIHOOK     lpfnHook;
    LPARAM            lCustData;
    HINSTANCE         hInstance;
    const(PWSTR)      lpszTemplate;
    HRSRC             hResource;
    HTASK             hTask;
    HWND*             lphWndDialog;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuibusya
struct OLEUIBUSYA
{
    uint              cbStruct;
    BUSY_DIALOG_FLAGS dwFlags;
    HWND              hWndOwner;
    const(PSTR)       lpszCaption;
    LPFNOLEUIHOOK     lpfnHook;
    LPARAM            lCustData;
    HINSTANCE         hInstance;
    const(PSTR)       lpszTemplate;
    HRSRC             hResource;
    HTASK             hTask;
    HWND*             lphWndDialog;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuichangesourcew
struct OLEUICHANGESOURCEW
{
    uint                 cbStruct;
    CHANGE_SOURCE_FLAGS  dwFlags;
    HWND                 hWndOwner;
    const(PWSTR)         lpszCaption;
    LPFNOLEUIHOOK        lpfnHook;
    LPARAM               lCustData;
    HINSTANCE            hInstance;
    const(PWSTR)         lpszTemplate;
    HRSRC                hResource;
    OPENFILENAMEW*       lpOFN;
    uint[4]              dwReserved1;
    IOleUILinkContainerW lpOleUILinkContainer;
    uint                 dwLink;
    PWSTR                lpszDisplayName;
    uint                 nFileLength;
    PWSTR                lpszFrom;
    PWSTR                lpszTo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuichangesourcea
struct OLEUICHANGESOURCEA
{
    uint                 cbStruct;
    CHANGE_SOURCE_FLAGS  dwFlags;
    HWND                 hWndOwner;
    const(PSTR)          lpszCaption;
    LPFNOLEUIHOOK        lpfnHook;
    LPARAM               lCustData;
    HINSTANCE            hInstance;
    const(PSTR)          lpszTemplate;
    HRSRC                hResource;
    OPENFILENAMEA*       lpOFN;
    uint[4]              dwReserved1;
    IOleUILinkContainerA lpOleUILinkContainer;
    uint                 dwLink;
    PSTR                 lpszDisplayName;
    uint                 nFileLength;
    PSTR                 lpszFrom;
    PSTR                 lpszTo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuignrlpropsw
struct OLEUIGNRLPROPSW
{
    uint               cbStruct;
    uint               dwFlags;
    uint[2]            dwReserved1;
    LPFNOLEUIHOOK      lpfnHook;
    LPARAM             lCustData;
    uint[3]            dwReserved2;
    OLEUIOBJECTPROPSW* lpOP;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuignrlpropsa
struct OLEUIGNRLPROPSA
{
    uint               cbStruct;
    uint               dwFlags;
    uint[2]            dwReserved1;
    LPFNOLEUIHOOK      lpfnHook;
    LPARAM             lCustData;
    uint[3]            dwReserved2;
    OLEUIOBJECTPROPSA* lpOP;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuiviewpropsw
struct OLEUIVIEWPROPSW
{
    uint               cbStruct;
    VIEW_OBJECT_PROPERTIES_FLAGS dwFlags;
    uint[2]            dwReserved1;
    LPFNOLEUIHOOK      lpfnHook;
    LPARAM             lCustData;
    uint[3]            dwReserved2;
    OLEUIOBJECTPROPSW* lpOP;
    int                nScaleMin;
    int                nScaleMax;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuiviewpropsa
struct OLEUIVIEWPROPSA
{
    uint               cbStruct;
    VIEW_OBJECT_PROPERTIES_FLAGS dwFlags;
    uint[2]            dwReserved1;
    LPFNOLEUIHOOK      lpfnHook;
    LPARAM             lCustData;
    uint[3]            dwReserved2;
    OLEUIOBJECTPROPSA* lpOP;
    int                nScaleMin;
    int                nScaleMax;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuilinkpropsw
struct OLEUILINKPROPSW
{
    uint               cbStruct;
    uint               dwFlags;
    uint[2]            dwReserved1;
    LPFNOLEUIHOOK      lpfnHook;
    LPARAM             lCustData;
    uint[3]            dwReserved2;
    OLEUIOBJECTPROPSW* lpOP;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuilinkpropsa
struct OLEUILINKPROPSA
{
    uint               cbStruct;
    uint               dwFlags;
    uint[2]            dwReserved1;
    LPFNOLEUIHOOK      lpfnHook;
    LPARAM             lCustData;
    uint[3]            dwReserved2;
    OLEUIOBJECTPROPSA* lpOP;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuiobjectpropsw
struct OLEUIOBJECTPROPSW
{
    uint                 cbStruct;
    OBJECT_PROPERTIES_FLAGS dwFlags;
    PROPSHEETHEADERW_V2* lpPS;
    uint                 dwObject;
    IOleUIObjInfoW       lpObjInfo;
    uint                 dwLink;
    IOleUILinkInfoW      lpLinkInfo;
    OLEUIGNRLPROPSW*     lpGP;
    OLEUIVIEWPROPSW*     lpVP;
    OLEUILINKPROPSW*     lpLP;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/ns-oledlg-oleuiobjectpropsa
struct OLEUIOBJECTPROPSA
{
    uint                 cbStruct;
    OBJECT_PROPERTIES_FLAGS dwFlags;
    PROPSHEETHEADERA_V2* lpPS;
    uint                 dwObject;
    IOleUIObjInfoA       lpObjInfo;
    uint                 dwLink;
    IOleUILinkInfoA      lpLinkInfo;
    OLEUIGNRLPROPSA*     lpGP;
    OLEUIVIEWPROPSA*     lpVP;
    OLEUILINKPROPSA*     lpLP;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearrayallocdescriptor
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayAllocDescriptor(uint cDims, SAFEARRAY** ppsaOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearrayallocdescriptorex
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayAllocDescriptorEx(VARENUM vt, uint cDims, SAFEARRAY** ppsaOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearrayallocdata
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayAllocData(SAFEARRAY* psa);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearraycreate
@DllImport("OLEAUT32.dll")
SAFEARRAY* SafeArrayCreate(VARENUM vt, uint cDims, SAFEARRAYBOUND* rgsabound);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearraycreateex
@DllImport("OLEAUT32.dll")
SAFEARRAY* SafeArrayCreateEx(VARENUM vt, uint cDims, SAFEARRAYBOUND* rgsabound, void* pvExtra);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearraycopydata
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayCopyData(SAFEARRAY* psaSource, SAFEARRAY* psaTarget);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("OLEAUT32.dll")
void SafeArrayReleaseDescriptor(SAFEARRAY* psa);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearraydestroydescriptor
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayDestroyDescriptor(SAFEARRAY* psa);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("OLEAUT32.dll")
void SafeArrayReleaseData(void* pData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearraydestroydata
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayDestroyData(SAFEARRAY* psa);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayAddRef(SAFEARRAY* psa, void** ppDataToRelease);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearraydestroy
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayDestroy(SAFEARRAY* psa);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearrayredim
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayRedim(SAFEARRAY* psa, SAFEARRAYBOUND* psaboundNew);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearraygetdim
@DllImport("OLEAUT32.dll")
uint SafeArrayGetDim(SAFEARRAY* psa);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearraygetelemsize
@DllImport("OLEAUT32.dll")
uint SafeArrayGetElemsize(SAFEARRAY* psa);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearraygetubound
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayGetUBound(SAFEARRAY* psa, uint nDim, int* plUbound);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearraygetlbound
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayGetLBound(SAFEARRAY* psa, uint nDim, int* plLbound);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearraylock
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayLock(SAFEARRAY* psa);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearrayunlock
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayUnlock(SAFEARRAY* psa);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearrayaccessdata
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayAccessData(SAFEARRAY* psa, void** ppvData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearrayunaccessdata
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayUnaccessData(SAFEARRAY* psa);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearraygetelement
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayGetElement(SAFEARRAY* psa, int* rgIndices, void* pv);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearrayputelement
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayPutElement(SAFEARRAY* psa, int* rgIndices, void* pv);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearraycopy
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayCopy(SAFEARRAY* psa, SAFEARRAY** ppsaOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearrayptrofindex
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayPtrOfIndex(SAFEARRAY* psa, int* rgIndices, void** ppvData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearraysetrecordinfo
@DllImport("OLEAUT32.dll")
HRESULT SafeArraySetRecordInfo(SAFEARRAY* psa, IRecordInfo prinfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearraygetrecordinfo
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayGetRecordInfo(SAFEARRAY* psa, IRecordInfo* prinfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearraysetiid
@DllImport("OLEAUT32.dll")
HRESULT SafeArraySetIID(SAFEARRAY* psa, const(GUID)* guid);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearraygetiid
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayGetIID(SAFEARRAY* psa, GUID* pguid);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearraygetvartype
@DllImport("OLEAUT32.dll")
HRESULT SafeArrayGetVartype(SAFEARRAY* psa, VARENUM* pvt);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearraycreatevector
@DllImport("OLEAUT32.dll")
SAFEARRAY* SafeArrayCreateVector(VARENUM vt, int lLbound, uint cElements);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-safearraycreatevectorex
@DllImport("OLEAUT32.dll")
SAFEARRAY* SafeArrayCreateVectorEx(VARENUM vt, int lLbound, uint cElements, void* pvExtra);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vectorfrombstr
@DllImport("OLEAUT32.dll")
HRESULT VectorFromBstr(BSTR bstr, SAFEARRAY** ppsa);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-bstrfromvector
@DllImport("OLEAUT32.dll")
HRESULT BstrFromVector(SAFEARRAY* psa, BSTR* pbstr);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui1fromi2
@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromI2(short sIn, ubyte* pbOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui1fromi4
@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromI4(int lIn, ubyte* pbOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui1fromi8
@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromI8(long i64In, ubyte* pbOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui1fromr4
@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromR4(float fltIn, ubyte* pbOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui1fromr8
@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromR8(double dblIn, ubyte* pbOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui1fromcy
@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromCy(CY cyIn, ubyte* pbOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui1fromdate
@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromDate(double dateIn, ubyte* pbOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui1fromstr
@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromStr(const(PWSTR) strIn, uint lcid, uint dwFlags, ubyte* pbOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui1fromdisp
@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromDisp(IDispatch pdispIn, uint lcid, ubyte* pbOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui1frombool
@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromBool(VARIANT_BOOL boolIn, ubyte* pbOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui1fromi1
@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromI1(CHAR cIn, ubyte* pbOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui1fromui2
@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromUI2(ushort uiIn, ubyte* pbOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui1fromui4
@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromUI4(uint ulIn, ubyte* pbOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui1fromui8
@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromUI8(ulong ui64In, ubyte* pbOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui1fromdec
@DllImport("OLEAUT32.dll")
HRESULT VarUI1FromDec(const(DECIMAL)* pdecIn, ubyte* pbOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari2fromui1
@DllImport("OLEAUT32.dll")
HRESULT VarI2FromUI1(ubyte bIn, short* psOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari2fromi4
@DllImport("OLEAUT32.dll")
HRESULT VarI2FromI4(int lIn, short* psOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari2fromi8
@DllImport("OLEAUT32.dll")
HRESULT VarI2FromI8(long i64In, short* psOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari2fromr4
@DllImport("OLEAUT32.dll")
HRESULT VarI2FromR4(float fltIn, short* psOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari2fromr8
@DllImport("OLEAUT32.dll")
HRESULT VarI2FromR8(double dblIn, short* psOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari2fromcy
@DllImport("OLEAUT32.dll")
HRESULT VarI2FromCy(CY cyIn, short* psOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari2fromdate
@DllImport("OLEAUT32.dll")
HRESULT VarI2FromDate(double dateIn, short* psOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari2fromstr
@DllImport("OLEAUT32.dll")
HRESULT VarI2FromStr(const(PWSTR) strIn, uint lcid, uint dwFlags, short* psOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari2fromdisp
@DllImport("OLEAUT32.dll")
HRESULT VarI2FromDisp(IDispatch pdispIn, uint lcid, short* psOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari2frombool
@DllImport("OLEAUT32.dll")
HRESULT VarI2FromBool(VARIANT_BOOL boolIn, short* psOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari2fromi1
@DllImport("OLEAUT32.dll")
HRESULT VarI2FromI1(CHAR cIn, short* psOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari2fromui2
@DllImport("OLEAUT32.dll")
HRESULT VarI2FromUI2(ushort uiIn, short* psOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari2fromui4
@DllImport("OLEAUT32.dll")
HRESULT VarI2FromUI4(uint ulIn, short* psOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari2fromui8
@DllImport("OLEAUT32.dll")
HRESULT VarI2FromUI8(ulong ui64In, short* psOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari2fromdec
@DllImport("OLEAUT32.dll")
HRESULT VarI2FromDec(const(DECIMAL)* pdecIn, short* psOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari4fromui1
@DllImport("OLEAUT32.dll")
HRESULT VarI4FromUI1(ubyte bIn, int* plOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari4fromi2
@DllImport("OLEAUT32.dll")
HRESULT VarI4FromI2(short sIn, int* plOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari4fromi8
@DllImport("OLEAUT32.dll")
HRESULT VarI4FromI8(long i64In, int* plOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari4fromr4
@DllImport("OLEAUT32.dll")
HRESULT VarI4FromR4(float fltIn, int* plOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari4fromr8
@DllImport("OLEAUT32.dll")
HRESULT VarI4FromR8(double dblIn, int* plOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari4fromcy
@DllImport("OLEAUT32.dll")
HRESULT VarI4FromCy(CY cyIn, int* plOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari4fromdate
@DllImport("OLEAUT32.dll")
HRESULT VarI4FromDate(double dateIn, int* plOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari4fromstr
@DllImport("OLEAUT32.dll")
HRESULT VarI4FromStr(const(PWSTR) strIn, uint lcid, uint dwFlags, int* plOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari4fromdisp
@DllImport("OLEAUT32.dll")
HRESULT VarI4FromDisp(IDispatch pdispIn, uint lcid, int* plOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari4frombool
@DllImport("OLEAUT32.dll")
HRESULT VarI4FromBool(VARIANT_BOOL boolIn, int* plOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari4fromi1
@DllImport("OLEAUT32.dll")
HRESULT VarI4FromI1(CHAR cIn, int* plOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari4fromui2
@DllImport("OLEAUT32.dll")
HRESULT VarI4FromUI2(ushort uiIn, int* plOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari4fromui4
@DllImport("OLEAUT32.dll")
HRESULT VarI4FromUI4(uint ulIn, int* plOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari4fromui8
@DllImport("OLEAUT32.dll")
HRESULT VarI4FromUI8(ulong ui64In, int* plOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari4fromdec
@DllImport("OLEAUT32.dll")
HRESULT VarI4FromDec(const(DECIMAL)* pdecIn, int* plOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari8fromui1
@DllImport("OLEAUT32.dll")
HRESULT VarI8FromUI1(ubyte bIn, long* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari8fromi2
@DllImport("OLEAUT32.dll")
HRESULT VarI8FromI2(short sIn, long* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari8fromr4
@DllImport("OLEAUT32.dll")
HRESULT VarI8FromR4(float fltIn, long* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari8fromr8
@DllImport("OLEAUT32.dll")
HRESULT VarI8FromR8(double dblIn, long* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari8fromcy
@DllImport("OLEAUT32.dll")
HRESULT VarI8FromCy(CY cyIn, long* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari8fromdate
@DllImport("OLEAUT32.dll")
HRESULT VarI8FromDate(double dateIn, long* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari8fromstr
@DllImport("OLEAUT32.dll")
HRESULT VarI8FromStr(const(PWSTR) strIn, uint lcid, uint dwFlags, long* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari8fromdisp
@DllImport("OLEAUT32.dll")
HRESULT VarI8FromDisp(IDispatch pdispIn, uint lcid, long* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari8frombool
@DllImport("OLEAUT32.dll")
HRESULT VarI8FromBool(VARIANT_BOOL boolIn, long* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari8fromi1
@DllImport("OLEAUT32.dll")
HRESULT VarI8FromI1(CHAR cIn, long* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari8fromui2
@DllImport("OLEAUT32.dll")
HRESULT VarI8FromUI2(ushort uiIn, long* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari8fromui4
@DllImport("OLEAUT32.dll")
HRESULT VarI8FromUI4(uint ulIn, long* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari8fromui8
@DllImport("OLEAUT32.dll")
HRESULT VarI8FromUI8(ulong ui64In, long* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari8fromdec
@DllImport("OLEAUT32.dll")
HRESULT VarI8FromDec(const(DECIMAL)* pdecIn, long* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr4fromui1
@DllImport("OLEAUT32.dll")
HRESULT VarR4FromUI1(ubyte bIn, float* pfltOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr4fromi2
@DllImport("OLEAUT32.dll")
HRESULT VarR4FromI2(short sIn, float* pfltOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr4fromi4
@DllImport("OLEAUT32.dll")
HRESULT VarR4FromI4(int lIn, float* pfltOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr4fromi8
@DllImport("OLEAUT32.dll")
HRESULT VarR4FromI8(long i64In, float* pfltOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr4fromr8
@DllImport("OLEAUT32.dll")
HRESULT VarR4FromR8(double dblIn, float* pfltOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr4fromcy
@DllImport("OLEAUT32.dll")
HRESULT VarR4FromCy(CY cyIn, float* pfltOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr4fromdate
@DllImport("OLEAUT32.dll")
HRESULT VarR4FromDate(double dateIn, float* pfltOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr4fromstr
@DllImport("OLEAUT32.dll")
HRESULT VarR4FromStr(const(PWSTR) strIn, uint lcid, uint dwFlags, float* pfltOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr4fromdisp
@DllImport("OLEAUT32.dll")
HRESULT VarR4FromDisp(IDispatch pdispIn, uint lcid, float* pfltOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr4frombool
@DllImport("OLEAUT32.dll")
HRESULT VarR4FromBool(VARIANT_BOOL boolIn, float* pfltOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr4fromi1
@DllImport("OLEAUT32.dll")
HRESULT VarR4FromI1(CHAR cIn, float* pfltOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr4fromui2
@DllImport("OLEAUT32.dll")
HRESULT VarR4FromUI2(ushort uiIn, float* pfltOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr4fromui4
@DllImport("OLEAUT32.dll")
HRESULT VarR4FromUI4(uint ulIn, float* pfltOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr4fromui8
@DllImport("OLEAUT32.dll")
HRESULT VarR4FromUI8(ulong ui64In, float* pfltOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr4fromdec
@DllImport("OLEAUT32.dll")
HRESULT VarR4FromDec(const(DECIMAL)* pdecIn, float* pfltOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr8fromui1
@DllImport("OLEAUT32.dll")
HRESULT VarR8FromUI1(ubyte bIn, double* pdblOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr8fromi2
@DllImport("OLEAUT32.dll")
HRESULT VarR8FromI2(short sIn, double* pdblOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr8fromi4
@DllImport("OLEAUT32.dll")
HRESULT VarR8FromI4(int lIn, double* pdblOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr8fromi8
@DllImport("OLEAUT32.dll")
HRESULT VarR8FromI8(long i64In, double* pdblOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr8fromr4
@DllImport("OLEAUT32.dll")
HRESULT VarR8FromR4(float fltIn, double* pdblOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr8fromcy
@DllImport("OLEAUT32.dll")
HRESULT VarR8FromCy(CY cyIn, double* pdblOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr8fromdate
@DllImport("OLEAUT32.dll")
HRESULT VarR8FromDate(double dateIn, double* pdblOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr8fromstr
@DllImport("OLEAUT32.dll")
HRESULT VarR8FromStr(const(PWSTR) strIn, uint lcid, uint dwFlags, double* pdblOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr8fromdisp
@DllImport("OLEAUT32.dll")
HRESULT VarR8FromDisp(IDispatch pdispIn, uint lcid, double* pdblOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr8frombool
@DllImport("OLEAUT32.dll")
HRESULT VarR8FromBool(VARIANT_BOOL boolIn, double* pdblOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr8fromi1
@DllImport("OLEAUT32.dll")
HRESULT VarR8FromI1(CHAR cIn, double* pdblOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr8fromui2
@DllImport("OLEAUT32.dll")
HRESULT VarR8FromUI2(ushort uiIn, double* pdblOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr8fromui4
@DllImport("OLEAUT32.dll")
HRESULT VarR8FromUI4(uint ulIn, double* pdblOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr8fromui8
@DllImport("OLEAUT32.dll")
HRESULT VarR8FromUI8(ulong ui64In, double* pdblOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr8fromdec
@DllImport("OLEAUT32.dll")
HRESULT VarR8FromDec(const(DECIMAL)* pdecIn, double* pdblOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardatefromui1
@DllImport("OLEAUT32.dll")
HRESULT VarDateFromUI1(ubyte bIn, double* pdateOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardatefromi2
@DllImport("OLEAUT32.dll")
HRESULT VarDateFromI2(short sIn, double* pdateOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardatefromi4
@DllImport("OLEAUT32.dll")
HRESULT VarDateFromI4(int lIn, double* pdateOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardatefromi8
@DllImport("OLEAUT32.dll")
HRESULT VarDateFromI8(long i64In, double* pdateOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardatefromr4
@DllImport("OLEAUT32.dll")
HRESULT VarDateFromR4(float fltIn, double* pdateOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardatefromr8
@DllImport("OLEAUT32.dll")
HRESULT VarDateFromR8(double dblIn, double* pdateOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardatefromcy
@DllImport("OLEAUT32.dll")
HRESULT VarDateFromCy(CY cyIn, double* pdateOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardatefromstr
@DllImport("OLEAUT32.dll")
HRESULT VarDateFromStr(const(PWSTR) strIn, uint lcid, uint dwFlags, double* pdateOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardatefromdisp
@DllImport("OLEAUT32.dll")
HRESULT VarDateFromDisp(IDispatch pdispIn, uint lcid, double* pdateOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardatefrombool
@DllImport("OLEAUT32.dll")
HRESULT VarDateFromBool(VARIANT_BOOL boolIn, double* pdateOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardatefromi1
@DllImport("OLEAUT32.dll")
HRESULT VarDateFromI1(CHAR cIn, double* pdateOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardatefromui2
@DllImport("OLEAUT32.dll")
HRESULT VarDateFromUI2(ushort uiIn, double* pdateOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardatefromui4
@DllImport("OLEAUT32.dll")
HRESULT VarDateFromUI4(uint ulIn, double* pdateOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardatefromui8
@DllImport("OLEAUT32.dll")
HRESULT VarDateFromUI8(ulong ui64In, double* pdateOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardatefromdec
@DllImport("OLEAUT32.dll")
HRESULT VarDateFromDec(const(DECIMAL)* pdecIn, double* pdateOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyfromui1
@DllImport("OLEAUT32.dll")
HRESULT VarCyFromUI1(ubyte bIn, CY* pcyOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyfromi2
@DllImport("OLEAUT32.dll")
HRESULT VarCyFromI2(short sIn, CY* pcyOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyfromi4
@DllImport("OLEAUT32.dll")
HRESULT VarCyFromI4(int lIn, CY* pcyOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyfromi8
@DllImport("OLEAUT32.dll")
HRESULT VarCyFromI8(long i64In, CY* pcyOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyfromr4
@DllImport("OLEAUT32.dll")
HRESULT VarCyFromR4(float fltIn, CY* pcyOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyfromr8
@DllImport("OLEAUT32.dll")
HRESULT VarCyFromR8(double dblIn, CY* pcyOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyfromdate
@DllImport("OLEAUT32.dll")
HRESULT VarCyFromDate(double dateIn, CY* pcyOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyfromstr
@DllImport("OLEAUT32.dll")
HRESULT VarCyFromStr(const(PWSTR) strIn, uint lcid, uint dwFlags, CY* pcyOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyfromdisp
@DllImport("OLEAUT32.dll")
HRESULT VarCyFromDisp(IDispatch pdispIn, uint lcid, CY* pcyOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyfrombool
@DllImport("OLEAUT32.dll")
HRESULT VarCyFromBool(VARIANT_BOOL boolIn, CY* pcyOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyfromi1
@DllImport("OLEAUT32.dll")
HRESULT VarCyFromI1(CHAR cIn, CY* pcyOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyfromui2
@DllImport("OLEAUT32.dll")
HRESULT VarCyFromUI2(ushort uiIn, CY* pcyOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyfromui4
@DllImport("OLEAUT32.dll")
HRESULT VarCyFromUI4(uint ulIn, CY* pcyOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyfromui8
@DllImport("OLEAUT32.dll")
HRESULT VarCyFromUI8(ulong ui64In, CY* pcyOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyfromdec
@DllImport("OLEAUT32.dll")
HRESULT VarCyFromDec(const(DECIMAL)* pdecIn, CY* pcyOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varbstrfromui1
@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromUI1(ubyte bVal, uint lcid, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varbstrfromi2
@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromI2(short iVal, uint lcid, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varbstrfromi4
@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromI4(int lIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varbstrfromi8
@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromI8(long i64In, uint lcid, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varbstrfromr4
@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromR4(float fltIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varbstrfromr8
@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromR8(double dblIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varbstrfromcy
@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromCy(CY cyIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varbstrfromdate
@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromDate(double dateIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varbstrfromdisp
@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromDisp(IDispatch pdispIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varbstrfrombool
@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromBool(VARIANT_BOOL boolIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varbstrfromi1
@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromI1(CHAR cIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varbstrfromui2
@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromUI2(ushort uiIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varbstrfromui4
@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromUI4(uint ulIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varbstrfromui8
@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromUI8(ulong ui64In, uint lcid, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varbstrfromdec
@DllImport("OLEAUT32.dll")
HRESULT VarBstrFromDec(const(DECIMAL)* pdecIn, uint lcid, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varboolfromui1
@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromUI1(ubyte bIn, VARIANT_BOOL* pboolOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varboolfromi2
@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromI2(short sIn, VARIANT_BOOL* pboolOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varboolfromi4
@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromI4(int lIn, VARIANT_BOOL* pboolOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varboolfromi8
@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromI8(long i64In, VARIANT_BOOL* pboolOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varboolfromr4
@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromR4(float fltIn, VARIANT_BOOL* pboolOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varboolfromr8
@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromR8(double dblIn, VARIANT_BOOL* pboolOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varboolfromdate
@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromDate(double dateIn, VARIANT_BOOL* pboolOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varboolfromcy
@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromCy(CY cyIn, VARIANT_BOOL* pboolOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varboolfromstr
@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromStr(const(PWSTR) strIn, uint lcid, uint dwFlags, VARIANT_BOOL* pboolOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varboolfromdisp
@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromDisp(IDispatch pdispIn, uint lcid, VARIANT_BOOL* pboolOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varboolfromi1
@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromI1(CHAR cIn, VARIANT_BOOL* pboolOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varboolfromui2
@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromUI2(ushort uiIn, VARIANT_BOOL* pboolOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varboolfromui4
@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromUI4(uint ulIn, VARIANT_BOOL* pboolOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varboolfromui8
@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromUI8(ulong i64In, VARIANT_BOOL* pboolOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varboolfromdec
@DllImport("OLEAUT32.dll")
HRESULT VarBoolFromDec(const(DECIMAL)* pdecIn, VARIANT_BOOL* pboolOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari1fromui1
@DllImport("OLEAUT32.dll")
HRESULT VarI1FromUI1(ubyte bIn, PSTR pcOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari1fromi2
@DllImport("OLEAUT32.dll")
HRESULT VarI1FromI2(short uiIn, PSTR pcOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari1fromi4
@DllImport("OLEAUT32.dll")
HRESULT VarI1FromI4(int lIn, PSTR pcOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari1fromi8
@DllImport("OLEAUT32.dll")
HRESULT VarI1FromI8(long i64In, PSTR pcOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari1fromr4
@DllImport("OLEAUT32.dll")
HRESULT VarI1FromR4(float fltIn, PSTR pcOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari1fromr8
@DllImport("OLEAUT32.dll")
HRESULT VarI1FromR8(double dblIn, PSTR pcOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari1fromdate
@DllImport("OLEAUT32.dll")
HRESULT VarI1FromDate(double dateIn, PSTR pcOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari1fromcy
@DllImport("OLEAUT32.dll")
HRESULT VarI1FromCy(CY cyIn, PSTR pcOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari1fromstr
@DllImport("OLEAUT32.dll")
HRESULT VarI1FromStr(const(PWSTR) strIn, uint lcid, uint dwFlags, PSTR pcOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari1fromdisp
@DllImport("OLEAUT32.dll")
HRESULT VarI1FromDisp(IDispatch pdispIn, uint lcid, PSTR pcOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari1frombool
@DllImport("OLEAUT32.dll")
HRESULT VarI1FromBool(VARIANT_BOOL boolIn, PSTR pcOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari1fromui2
@DllImport("OLEAUT32.dll")
HRESULT VarI1FromUI2(ushort uiIn, PSTR pcOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari1fromui4
@DllImport("OLEAUT32.dll")
HRESULT VarI1FromUI4(uint ulIn, PSTR pcOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari1fromui8
@DllImport("OLEAUT32.dll")
HRESULT VarI1FromUI8(ulong i64In, PSTR pcOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vari1fromdec
@DllImport("OLEAUT32.dll")
HRESULT VarI1FromDec(const(DECIMAL)* pdecIn, PSTR pcOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui2fromui1
@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromUI1(ubyte bIn, ushort* puiOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui2fromi2
@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromI2(short uiIn, ushort* puiOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui2fromi4
@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromI4(int lIn, ushort* puiOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui2fromi8
@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromI8(long i64In, ushort* puiOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui2fromr4
@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromR4(float fltIn, ushort* puiOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui2fromr8
@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromR8(double dblIn, ushort* puiOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui2fromdate
@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromDate(double dateIn, ushort* puiOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui2fromcy
@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromCy(CY cyIn, ushort* puiOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui2fromstr
@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromStr(const(PWSTR) strIn, uint lcid, uint dwFlags, ushort* puiOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui2fromdisp
@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromDisp(IDispatch pdispIn, uint lcid, ushort* puiOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui2frombool
@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromBool(VARIANT_BOOL boolIn, ushort* puiOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui2fromi1
@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromI1(CHAR cIn, ushort* puiOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui2fromui4
@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromUI4(uint ulIn, ushort* puiOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui2fromui8
@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromUI8(ulong i64In, ushort* puiOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui2fromdec
@DllImport("OLEAUT32.dll")
HRESULT VarUI2FromDec(const(DECIMAL)* pdecIn, ushort* puiOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui4fromui1
@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromUI1(ubyte bIn, uint* pulOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui4fromi2
@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromI2(short uiIn, uint* pulOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui4fromi4
@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromI4(int lIn, uint* pulOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui4fromi8
@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromI8(long i64In, uint* plOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui4fromr4
@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromR4(float fltIn, uint* pulOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui4fromr8
@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromR8(double dblIn, uint* pulOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui4fromdate
@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromDate(double dateIn, uint* pulOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui4fromcy
@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromCy(CY cyIn, uint* pulOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui4fromstr
@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromStr(const(PWSTR) strIn, uint lcid, uint dwFlags, uint* pulOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui4fromdisp
@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromDisp(IDispatch pdispIn, uint lcid, uint* pulOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui4frombool
@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromBool(VARIANT_BOOL boolIn, uint* pulOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui4fromi1
@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromI1(CHAR cIn, uint* pulOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui4fromui2
@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromUI2(ushort uiIn, uint* pulOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui4fromui8
@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromUI8(ulong ui64In, uint* plOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui4fromdec
@DllImport("OLEAUT32.dll")
HRESULT VarUI4FromDec(const(DECIMAL)* pdecIn, uint* pulOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui8fromui1
@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromUI1(ubyte bIn, ulong* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui8fromi2
@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromI2(short sIn, ulong* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui8fromi8
@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromI8(long ui64In, ulong* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui8fromr4
@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromR4(float fltIn, ulong* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui8fromr8
@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromR8(double dblIn, ulong* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui8fromcy
@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromCy(CY cyIn, ulong* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui8fromdate
@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromDate(double dateIn, ulong* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui8fromstr
@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromStr(const(PWSTR) strIn, uint lcid, uint dwFlags, ulong* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui8fromdisp
@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromDisp(IDispatch pdispIn, uint lcid, ulong* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui8frombool
@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromBool(VARIANT_BOOL boolIn, ulong* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui8fromi1
@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromI1(CHAR cIn, ulong* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui8fromui2
@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromUI2(ushort uiIn, ulong* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui8fromui4
@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromUI4(uint ulIn, ulong* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varui8fromdec
@DllImport("OLEAUT32.dll")
HRESULT VarUI8FromDec(const(DECIMAL)* pdecIn, ulong* pi64Out);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecfromui1
@DllImport("OLEAUT32.dll")
HRESULT VarDecFromUI1(ubyte bIn, DECIMAL* pdecOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecfromi2
@DllImport("OLEAUT32.dll")
HRESULT VarDecFromI2(short uiIn, DECIMAL* pdecOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecfromi4
@DllImport("OLEAUT32.dll")
HRESULT VarDecFromI4(int lIn, DECIMAL* pdecOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecfromi8
@DllImport("OLEAUT32.dll")
HRESULT VarDecFromI8(long i64In, DECIMAL* pdecOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecfromr4
@DllImport("OLEAUT32.dll")
HRESULT VarDecFromR4(float fltIn, DECIMAL* pdecOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecfromr8
@DllImport("OLEAUT32.dll")
HRESULT VarDecFromR8(double dblIn, DECIMAL* pdecOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecfromdate
@DllImport("OLEAUT32.dll")
HRESULT VarDecFromDate(double dateIn, DECIMAL* pdecOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecfromcy
@DllImport("OLEAUT32.dll")
HRESULT VarDecFromCy(CY cyIn, DECIMAL* pdecOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecfromstr
@DllImport("OLEAUT32.dll")
HRESULT VarDecFromStr(const(PWSTR) strIn, uint lcid, uint dwFlags, DECIMAL* pdecOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecfromdisp
@DllImport("OLEAUT32.dll")
HRESULT VarDecFromDisp(IDispatch pdispIn, uint lcid, DECIMAL* pdecOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecfrombool
@DllImport("OLEAUT32.dll")
HRESULT VarDecFromBool(VARIANT_BOOL boolIn, DECIMAL* pdecOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecfromi1
@DllImport("OLEAUT32.dll")
HRESULT VarDecFromI1(CHAR cIn, DECIMAL* pdecOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecfromui2
@DllImport("OLEAUT32.dll")
HRESULT VarDecFromUI2(ushort uiIn, DECIMAL* pdecOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecfromui4
@DllImport("OLEAUT32.dll")
HRESULT VarDecFromUI4(uint ulIn, DECIMAL* pdecOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecfromui8
@DllImport("OLEAUT32.dll")
HRESULT VarDecFromUI8(ulong ui64In, DECIMAL* pdecOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varparsenumfromstr
@DllImport("OLEAUT32.dll")
HRESULT VarParseNumFromStr(const(PWSTR) strIn, uint lcid, uint dwFlags, NUMPARSE* pnumprs, ubyte* rgbDig);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varnumfromparsenum
@DllImport("OLEAUT32.dll")
HRESULT VarNumFromParseNum(NUMPARSE* pnumprs, ubyte* rgbDig, uint dwVtBits, VARIANT* pvar);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varadd
@DllImport("OLEAUT32.dll")
HRESULT VarAdd(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varand
@DllImport("OLEAUT32.dll")
HRESULT VarAnd(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcat
@DllImport("OLEAUT32.dll")
HRESULT VarCat(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardiv
@DllImport("OLEAUT32.dll")
HRESULT VarDiv(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vareqv
@DllImport("OLEAUT32.dll")
HRESULT VarEqv(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varidiv
@DllImport("OLEAUT32.dll")
HRESULT VarIdiv(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varimp
@DllImport("OLEAUT32.dll")
HRESULT VarImp(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varmod
@DllImport("OLEAUT32.dll")
HRESULT VarMod(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varmul
@DllImport("OLEAUT32.dll")
HRESULT VarMul(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varor
@DllImport("OLEAUT32.dll")
HRESULT VarOr(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varpow
@DllImport("OLEAUT32.dll")
HRESULT VarPow(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varsub
@DllImport("OLEAUT32.dll")
HRESULT VarSub(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varxor
@DllImport("OLEAUT32.dll")
HRESULT VarXor(VARIANT* pvarLeft, VARIANT* pvarRight, VARIANT* pvarResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varabs
@DllImport("OLEAUT32.dll")
HRESULT VarAbs(VARIANT* pvarIn, VARIANT* pvarResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varfix
@DllImport("OLEAUT32.dll")
HRESULT VarFix(VARIANT* pvarIn, VARIANT* pvarResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varint
@DllImport("OLEAUT32.dll")
HRESULT VarInt(VARIANT* pvarIn, VARIANT* pvarResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varneg
@DllImport("OLEAUT32.dll")
HRESULT VarNeg(VARIANT* pvarIn, VARIANT* pvarResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varnot
@DllImport("OLEAUT32.dll")
HRESULT VarNot(VARIANT* pvarIn, VARIANT* pvarResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varround
@DllImport("OLEAUT32.dll")
HRESULT VarRound(VARIANT* pvarIn, int cDecimals, VARIANT* pvarResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcmp
@DllImport("OLEAUT32.dll")
VARCMP VarCmp(VARIANT* pvarLeft, VARIANT* pvarRight, uint lcid, uint dwFlags);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecadd
@DllImport("OLEAUT32.dll")
HRESULT VarDecAdd(DECIMAL* pdecLeft, DECIMAL* pdecRight, DECIMAL* pdecResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecdiv
@DllImport("OLEAUT32.dll")
HRESULT VarDecDiv(DECIMAL* pdecLeft, DECIMAL* pdecRight, DECIMAL* pdecResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecmul
@DllImport("OLEAUT32.dll")
HRESULT VarDecMul(DECIMAL* pdecLeft, DECIMAL* pdecRight, DECIMAL* pdecResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecsub
@DllImport("OLEAUT32.dll")
HRESULT VarDecSub(DECIMAL* pdecLeft, DECIMAL* pdecRight, DECIMAL* pdecResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecabs
@DllImport("OLEAUT32.dll")
HRESULT VarDecAbs(DECIMAL* pdecIn, DECIMAL* pdecResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecfix
@DllImport("OLEAUT32.dll")
HRESULT VarDecFix(DECIMAL* pdecIn, DECIMAL* pdecResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecint
@DllImport("OLEAUT32.dll")
HRESULT VarDecInt(DECIMAL* pdecIn, DECIMAL* pdecResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecneg
@DllImport("OLEAUT32.dll")
HRESULT VarDecNeg(DECIMAL* pdecIn, DECIMAL* pdecResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardecround
@DllImport("OLEAUT32.dll")
HRESULT VarDecRound(DECIMAL* pdecIn, int cDecimals, DECIMAL* pdecResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardeccmp
@DllImport("OLEAUT32.dll")
VARCMP VarDecCmp(DECIMAL* pdecLeft, DECIMAL* pdecRight);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardeccmpr8
@DllImport("OLEAUT32.dll")
VARCMP VarDecCmpR8(DECIMAL* pdecLeft, double dblRight);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyadd
@DllImport("OLEAUT32.dll")
HRESULT VarCyAdd(CY cyLeft, CY cyRight, CY* pcyResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcymul
@DllImport("OLEAUT32.dll")
HRESULT VarCyMul(CY cyLeft, CY cyRight, CY* pcyResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcymuli4
@DllImport("OLEAUT32.dll")
HRESULT VarCyMulI4(CY cyLeft, int lRight, CY* pcyResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcymuli8
@DllImport("OLEAUT32.dll")
HRESULT VarCyMulI8(CY cyLeft, long lRight, CY* pcyResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcysub
@DllImport("OLEAUT32.dll")
HRESULT VarCySub(CY cyLeft, CY cyRight, CY* pcyResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyabs
@DllImport("OLEAUT32.dll")
HRESULT VarCyAbs(CY cyIn, CY* pcyResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyfix
@DllImport("OLEAUT32.dll")
HRESULT VarCyFix(CY cyIn, CY* pcyResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyint
@DllImport("OLEAUT32.dll")
HRESULT VarCyInt(CY cyIn, CY* pcyResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyneg
@DllImport("OLEAUT32.dll")
HRESULT VarCyNeg(CY cyIn, CY* pcyResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcyround
@DllImport("OLEAUT32.dll")
HRESULT VarCyRound(CY cyIn, int cDecimals, CY* pcyResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcycmp
@DllImport("OLEAUT32.dll")
VARCMP VarCyCmp(CY cyLeft, CY cyRight);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varcycmpr8
@DllImport("OLEAUT32.dll")
VARCMP VarCyCmpR8(CY cyLeft, double dblRight);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varbstrcat
@DllImport("OLEAUT32.dll")
HRESULT VarBstrCat(BSTR bstrLeft, BSTR bstrRight, BSTR* pbstrResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varbstrcmp
@DllImport("OLEAUT32.dll")
HRESULT VarBstrCmp(BSTR bstrLeft, BSTR bstrRight, uint lcid, uint dwFlags);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr8pow
@DllImport("OLEAUT32.dll")
HRESULT VarR8Pow(double dblLeft, double dblRight, double* pdblResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr4cmpr8
@DllImport("OLEAUT32.dll")
VARCMP VarR4CmpR8(float fltLeft, double dblRight);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varr8round
@DllImport("OLEAUT32.dll")
HRESULT VarR8Round(double dblIn, int cDecimals, double* pdblResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardatefromudate
@DllImport("OLEAUT32.dll")
HRESULT VarDateFromUdate(UDATE* pudateIn, uint dwFlags, double* pdateOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vardatefromudateex
@DllImport("OLEAUT32.dll")
HRESULT VarDateFromUdateEx(UDATE* pudateIn, uint lcid, uint dwFlags, double* pdateOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varudatefromdate
@DllImport("OLEAUT32.dll")
HRESULT VarUdateFromDate(double dateIn, uint dwFlags, UDATE* pudateOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-getaltmonthnames
@DllImport("OLEAUT32.dll")
HRESULT GetAltMonthNames(uint lcid, PWSTR** prgp);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varformat
@DllImport("OLEAUT32.dll")
HRESULT VarFormat(VARIANT* pvarIn, PWSTR pstrFormat, VARFORMAT_FIRST_DAY iFirstDay, 
                  VARFORMAT_FIRST_WEEK iFirstWeek, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varformatdatetime
@DllImport("OLEAUT32.dll")
HRESULT VarFormatDateTime(VARIANT* pvarIn, VARFORMAT_NAMED_FORMAT iNamedFormat, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varformatnumber
@DllImport("OLEAUT32.dll")
HRESULT VarFormatNumber(VARIANT* pvarIn, int iNumDig, VARFORMAT_LEADING_DIGIT iIncLead, 
                        VARFORMAT_PARENTHESES iUseParens, VARFORMAT_GROUP iGroup, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varformatpercent
@DllImport("OLEAUT32.dll")
HRESULT VarFormatPercent(VARIANT* pvarIn, int iNumDig, VARFORMAT_LEADING_DIGIT iIncLead, 
                         VARFORMAT_PARENTHESES iUseParens, VARFORMAT_GROUP iGroup, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varformatcurrency
@DllImport("OLEAUT32.dll")
HRESULT VarFormatCurrency(VARIANT* pvarIn, int iNumDig, int iIncLead, int iUseParens, int iGroup, uint dwFlags, 
                          BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varweekdayname
@DllImport("OLEAUT32.dll")
HRESULT VarWeekdayName(int iWeekday, int fAbbrev, int iFirstDay, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varmonthname
@DllImport("OLEAUT32.dll")
HRESULT VarMonthName(int iMonth, int fAbbrev, uint dwFlags, BSTR* pbstrOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-varformatfromtokens
@DllImport("OLEAUT32.dll")
HRESULT VarFormatFromTokens(VARIANT* pvarIn, PWSTR pstrFormat, ubyte* pbTokCur, uint dwFlags, BSTR* pbstrOut, 
                            uint lcid);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-vartokenizeformatstring
@DllImport("OLEAUT32.dll")
HRESULT VarTokenizeFormatString(PWSTR pstrFormat, ubyte* rgbTok, int cbTok, VARFORMAT_FIRST_DAY iFirstDay, 
                                VARFORMAT_FIRST_WEEK iFirstWeek, uint lcid, int* pcbActual);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-lhashvalofnamesysa
@DllImport("OLEAUT32.dll")
uint LHashValOfNameSysA(SYSKIND syskind, uint lcid, const(PSTR) szName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-lhashvalofnamesys
@DllImport("OLEAUT32.dll")
uint LHashValOfNameSys(SYSKIND syskind, uint lcid, const(PWSTR) szName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-loadtypelib
@DllImport("OLEAUT32.dll")
HRESULT LoadTypeLib(const(PWSTR) szFile, ITypeLib* pptlib);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-loadtypelibex
@DllImport("OLEAUT32.dll")
HRESULT LoadTypeLibEx(const(PWSTR) szFile, REGKIND regkind, ITypeLib* pptlib);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-loadregtypelib
@DllImport("OLEAUT32.dll")
HRESULT LoadRegTypeLib(const(GUID)* rguid, ushort wVerMajor, ushort wVerMinor, uint lcid, ITypeLib* pptlib);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-querypathofregtypelib
@DllImport("OLEAUT32.dll")
HRESULT QueryPathOfRegTypeLib(const(GUID)* guid, ushort wMaj, ushort wMin, uint lcid, BSTR* lpbstrPathName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-registertypelib
@DllImport("OLEAUT32.dll")
HRESULT RegisterTypeLib(ITypeLib ptlib, const(PWSTR) szFullPath, const(PWSTR) szHelpDir);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-unregistertypelib
@DllImport("OLEAUT32.dll")
HRESULT UnRegisterTypeLib(const(GUID)* libID, ushort wVerMajor, ushort wVerMinor, uint lcid, SYSKIND syskind);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-registertypelibforuser
@DllImport("OLEAUT32.dll")
HRESULT RegisterTypeLibForUser(ITypeLib ptlib, PWSTR szFullPath, PWSTR szHelpDir);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-unregistertypelibforuser
@DllImport("OLEAUT32.dll")
HRESULT UnRegisterTypeLibForUser(const(GUID)* libID, ushort wMajorVerNum, ushort wMinorVerNum, uint lcid, 
                                 SYSKIND syskind);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-createtypelib
@DllImport("OLEAUT32.dll")
HRESULT CreateTypeLib(SYSKIND syskind, const(PWSTR) szFile, ICreateTypeLib* ppctlib);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-createtypelib2
@DllImport("OLEAUT32.dll")
HRESULT CreateTypeLib2(SYSKIND syskind, const(PWSTR) szFile, ICreateTypeLib2* ppctlib);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-dispgetparam
@DllImport("OLEAUT32.dll")
HRESULT DispGetParam(DISPPARAMS* pdispparams, uint position, VARENUM vtTarg, VARIANT* pvarResult, uint* puArgErr);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-dispgetidsofnames
@DllImport("OLEAUT32.dll")
HRESULT DispGetIDsOfNames(ITypeInfo ptinfo, PWSTR* rgszNames, uint cNames, int* rgdispid);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-dispinvoke
@DllImport("OLEAUT32.dll")
HRESULT DispInvoke(void* _this, ITypeInfo ptinfo, int dispidMember, ushort wFlags, DISPPARAMS* pparams, 
                   VARIANT* pvarResult, EXCEPINFO* pexcepinfo, uint* puArgErr);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-createdisptypeinfo
@DllImport("OLEAUT32.dll")
HRESULT CreateDispTypeInfo(INTERFACEDATA* pidata, uint lcid, ITypeInfo* pptinfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-createstddispatch
@DllImport("OLEAUT32.dll")
HRESULT CreateStdDispatch(IUnknown punkOuter, void* pvThis, ITypeInfo ptinfo, IUnknown* ppunkStdDisp);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-dispcallfunc
@DllImport("OLEAUT32.dll")
HRESULT DispCallFunc(void* pvInstance, size_t oVft, CALLCONV cc, VARENUM vtReturn, uint cActuals, ushort* prgvt, 
                     VARIANT** prgpvarg, VARIANT* pvargResult);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-registeractiveobject
@DllImport("OLEAUT32.dll")
HRESULT RegisterActiveObject(IUnknown punk, const(GUID)* rclsid, ACTIVEOBJECT_FLAGS dwFlags, uint* pdwRegister);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-revokeactiveobject
@DllImport("OLEAUT32.dll")
HRESULT RevokeActiveObject(uint dwRegister, 
                           /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-getactiveobject
@DllImport("OLEAUT32.dll")
HRESULT GetActiveObject(const(GUID)* rclsid, 
                        /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved, 
                        IUnknown* ppunk);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-createerrorinfo
@DllImport("OLEAUT32.dll")
HRESULT CreateErrorInfo(ICreateErrorInfo* pperrinfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-getrecordinfofromtypeinfo
@DllImport("OLEAUT32.dll")
HRESULT GetRecordInfoFromTypeInfo(ITypeInfo pTypeInfo, IRecordInfo* ppRecInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-getrecordinfofromguids
@DllImport("OLEAUT32.dll")
HRESULT GetRecordInfoFromGuids(const(GUID)* rGuidTypeLib, uint uVerMajor, uint uVerMinor, uint lcid, 
                               const(GUID)* rGuidTypeInfo, IRecordInfo* ppRecInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-oabuildversion
@DllImport("OLEAUT32.dll")
uint OaBuildVersion();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-clearcustdata
@DllImport("OLEAUT32.dll")
void ClearCustData(CUSTDATA* pCustData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-oaenableperusertlibregistration
@DllImport("OLEAUT32.dll")
void OaEnablePerUserTLibRegistration();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ole2/nf-ole2-olebuildversion
@DllImport("ole32.dll")
uint OleBuildVersion();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleInitialize(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
void OleUninitialize();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleQueryLinkFromData(IDataObject pSrcDataObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleQueryCreateFromData(IDataObject pSrcDataObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleCreate(const(GUID)* rclsid, const(GUID)* riid, 
                  /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLERENDER))], [])*/uint renderopt, 
                  FORMATETC* pFormatEtc, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
HRESULT OleCreateEx(const(GUID)* rclsid, const(GUID)* riid, OLECREATE dwFlags, 
                    /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLERENDER))], [])*/uint renderopt, 
                    uint cFormats, uint* rgAdvf, FORMATETC* rgFormatEtc, IAdviseSink lpAdviseSink, 
                    uint* rgdwConnection, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleCreateFromData(IDataObject pSrcDataObj, const(GUID)* riid, 
                          /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLERENDER))], [])*/uint renderopt, 
                          FORMATETC* pFormatEtc, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
HRESULT OleCreateFromDataEx(IDataObject pSrcDataObj, const(GUID)* riid, OLECREATE dwFlags, 
                            /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLERENDER))], [])*/uint renderopt, 
                            uint cFormats, uint* rgAdvf, FORMATETC* rgFormatEtc, IAdviseSink lpAdviseSink, 
                            uint* rgdwConnection, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleCreateLinkFromData(IDataObject pSrcDataObj, const(GUID)* riid, 
                              /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLERENDER))], [])*/uint renderopt, 
                              FORMATETC* pFormatEtc, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
HRESULT OleCreateLinkFromDataEx(IDataObject pSrcDataObj, const(GUID)* riid, OLECREATE dwFlags, 
                                /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLERENDER))], [])*/uint renderopt, 
                                uint cFormats, uint* rgAdvf, FORMATETC* rgFormatEtc, IAdviseSink lpAdviseSink, 
                                uint* rgdwConnection, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleCreateStaticFromData(IDataObject pSrcDataObj, const(GUID)* iid, 
                                /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLERENDER))], [])*/uint renderopt, 
                                FORMATETC* pFormatEtc, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
HRESULT OleCreateLink(IMoniker pmkLinkSrc, const(GUID)* riid, 
                      /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLERENDER))], [])*/uint renderopt, 
                      FORMATETC* lpFormatEtc, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
HRESULT OleCreateLinkEx(IMoniker pmkLinkSrc, const(GUID)* riid, OLECREATE dwFlags, 
                        /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLERENDER))], [])*/uint renderopt, 
                        uint cFormats, uint* rgAdvf, FORMATETC* rgFormatEtc, IAdviseSink lpAdviseSink, 
                        uint* rgdwConnection, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleCreateLinkToFile(const(PWSTR) lpszFileName, const(GUID)* riid, 
                            /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLERENDER))], [])*/uint renderopt, 
                            FORMATETC* lpFormatEtc, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
HRESULT OleCreateLinkToFileEx(const(PWSTR) lpszFileName, const(GUID)* riid, OLECREATE dwFlags, 
                              /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLERENDER))], [])*/uint renderopt, 
                              uint cFormats, uint* rgAdvf, FORMATETC* rgFormatEtc, IAdviseSink lpAdviseSink, 
                              uint* rgdwConnection, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleCreateFromFile(const(GUID)* rclsid, const(PWSTR) lpszFileName, const(GUID)* riid, 
                          /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLERENDER))], [])*/uint renderopt, 
                          FORMATETC* lpFormatEtc, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
HRESULT OleCreateFromFileEx(const(GUID)* rclsid, const(PWSTR) lpszFileName, const(GUID)* riid, OLECREATE dwFlags, 
                            /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLERENDER))], [])*/uint renderopt, 
                            uint cFormats, uint* rgAdvf, FORMATETC* rgFormatEtc, IAdviseSink lpAdviseSink, 
                            uint* rgdwConnection, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleLoad(IStorage pStg, const(GUID)* riid, IOleClientSite pClientSite, void** ppvObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleSave(IPersistStorage pPS, IStorage pStg, BOOL fSameAsLoad);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleLoadFromStream(IStream pStm, const(GUID)* iidInterface, void** ppvObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleSaveToStream(IPersistStream pPStm, IStream pStm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleSetContainedObject(IUnknown pUnknown, BOOL fContained);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
HRESULT OleNoteObjectVisible(IUnknown pUnknown, BOOL fVisible);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT RegisterDragDrop(HWND hwnd, IDropTarget pDropTarget);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT RevokeDragDrop(HWND hwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT DoDragDrop(IDataObject pDataObj, IDropSource pDropSource, DROPEFFECT dwOKEffects, DROPEFFECT* pdwEffect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleSetClipboard(IDataObject pDataObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleGetClipboard(IDataObject* ppDataObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("ole32.dll")
HRESULT OleGetClipboardWithEnterpriseInfo(IDataObject* dataObject, PWSTR* dataEnterpriseId, 
                                          PWSTR* sourceDescription, PWSTR* targetDescription, PWSTR* dataDescription);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleFlushClipboard();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleIsCurrentClipboard(IDataObject pDataObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
ptrdiff_t OleCreateMenuDescriptor(HMENU hmenuCombined, OLEMENUGROUPWIDTHS* lpMenuWidths);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleSetMenuDescriptor(ptrdiff_t holemenu, HWND hwndFrame, HWND hwndActiveObject, IOleInPlaceFrame lpFrame, 
                             IOleInPlaceActiveObject lpActiveObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleDestroyMenuDescriptor(ptrdiff_t holemenu);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleTranslateAccelerator(IOleInPlaceFrame lpFrame, OLEINPLACEFRAMEINFO* lpFrameInfo, MSG* lpmsg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HANDLE OleDuplicateData(HANDLE hSrc, CLIPBOARD_FORMAT cfFormat, GLOBAL_ALLOC_FLAGS uiFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleDraw(IUnknown pUnknown, uint dwAspect, HDC hdcDraw, RECT* lprcBounds);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleRun(IUnknown pUnknown);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
BOOL OleIsRunning(IOleObject pObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleLockRunning(IUnknown pUnknown, BOOL fLock, BOOL fLastUnlockCloses);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
void ReleaseStgMedium(STGMEDIUM* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT CreateOleAdviseHolder(IOleAdviseHolder* ppOAHolder);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
HRESULT OleCreateDefaultHandler(const(GUID)* clsid, IUnknown pUnkOuter, const(GUID)* riid, void** lplpObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleCreateEmbeddingHelper(const(GUID)* clsid, IUnknown pUnkOuter, EMBDHLP_FLAGS flags, IClassFactory pCF, 
                                 const(GUID)* riid, void** lplpObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
BOOL IsAccelerator(HACCEL hAccel, int cAccelEntries, MSG* lpMsg, ushort* lpwCmd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
HGLOBAL OleGetIconOfFile(PWSTR lpszPath, BOOL fUseFileAsLabel);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HGLOBAL OleGetIconOfClass(const(GUID)* rclsid, PWSTR lpszLabel, BOOL fUseTypeAsLabel);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
HGLOBAL OleMetafilePictFromIconAndLabel(HICON hIcon, PWSTR lpszLabel, PWSTR lpszSourceFile, uint iIconIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleRegGetUserType(const(GUID)* clsid, 
                          /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(USERCLASSTYPE))], [])*/uint dwFormOfType, 
                          PWSTR* pszUserType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleRegGetMiscStatus(const(GUID)* clsid, uint dwAspect, uint* pdwStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
HRESULT OleRegEnumFormatEtc(const(GUID)* clsid, uint dwDirection, IEnumFORMATETC* ppenum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleRegEnumVerbs(const(GUID)* clsid, IEnumOLEVERB* ppenum);

@DllImport("ole32.dll")
HRESULT OleConvertOLESTREAMToIStorage2(OLESTREAM* lpolestream, IStorage pstg, const(DVTARGETDEVICE)* ptd, uint opt, 
                                       void* pvCallbackContext, 
                                       OLESTREAMQUERYCONVERTOLELINKCALLBACK pQueryConvertOLELinkCallback);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
HRESULT OleDoAutoConvert(IStorage pStg, GUID* pClsidNew);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLE32.dll")
HRESULT OleGetAutoConvert(const(GUID)* clsidOld, GUID* pClsidNew);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ole32.dll")
HRESULT OleSetAutoConvert(const(GUID)* clsidOld, const(GUID)* clsidNew);

@DllImport("ole32.dll")
HRESULT OleConvertOLESTREAMToIStorageEx2(OLESTREAM* polestm, IStorage pstg, ushort* pcfFormat, int* plwWidth, 
                                         int* plHeight, uint* pdwSize, STGMEDIUM* pmedium, uint opt, 
                                         void* pvCallbackContext, 
                                         OLESTREAMQUERYCONVERTOLELINKCALLBACK pQueryConvertOLELinkCallback);

@DllImport("OLE32.dll")
uint HRGN_UserSize(uint* param0, uint param1, HRGN* param2);

@DllImport("OLE32.dll")
ubyte* HRGN_UserMarshal(uint* param0, ubyte* param1, HRGN* param2);

@DllImport("OLE32.dll")
ubyte* HRGN_UserUnmarshal(uint* param0, ubyte* param1, HRGN* param2);

@DllImport("OLE32.dll")
void HRGN_UserFree(uint* param0, HRGN* param1);

@DllImport("api-ms-win-core-marshal-l1-1-0.dll")
uint HRGN_UserSize64(uint* param0, uint param1, HRGN* param2);

@DllImport("api-ms-win-core-marshal-l1-1-0.dll")
ubyte* HRGN_UserMarshal64(uint* param0, ubyte* param1, HRGN* param2);

@DllImport("api-ms-win-core-marshal-l1-1-0.dll")
ubyte* HRGN_UserUnmarshal64(uint* param0, ubyte* param1, HRGN* param2);

@DllImport("api-ms-win-core-marshal-l1-1-0.dll")
void HRGN_UserFree64(uint* param0, HRGN* param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEAUT32.dll")
HRESULT OleCreatePropertyFrame(HWND hwndOwner, uint x, uint y, const(PWSTR) lpszCaption, uint cObjects, 
                               IUnknown* ppUnk, uint cPages, GUID* pPageClsID, uint lcid, 
                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved, 
                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEAUT32.dll")
HRESULT OleCreatePropertyFrameIndirect(OCPFIPARAMS* lpParams);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEAUT32.dll")
HRESULT OleTranslateColor(uint clr, HPALETTE hpal, COLORREF* lpcolorref);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEAUT32.dll")
HRESULT OleCreateFontIndirect(FONTDESC* lpFontDesc, const(GUID)* riid, void** lplpvObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEAUT32.dll")
HRESULT OleCreatePictureIndirect(PICTDESC* lpPictDesc, const(GUID)* riid, BOOL fOwn, void** lplpvObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEAUT32.dll")
HRESULT OleLoadPicture(IStream lpstream, int lSize, BOOL fRunmode, const(GUID)* riid, void** lplpvObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEAUT32.dll")
HRESULT OleLoadPictureEx(IStream lpstream, int lSize, BOOL fRunmode, const(GUID)* riid, uint xSizeDesired, 
                         uint ySizeDesired, LOAD_PICTURE_FLAGS dwFlags, void** lplpvObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEAUT32.dll")
HRESULT OleLoadPicturePath(PWSTR szURLorPath, IUnknown punkCaller, 
                           /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved, 
                           uint clrReserved, const(GUID)* riid, void** ppvRet);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/olectl/nf-olectl-oleloadpicturefile
@DllImport("OLEAUT32.dll")
HRESULT OleLoadPictureFile(VARIANT varFileName, IDispatch* lplpdispPicture);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/olectl/nf-olectl-oleloadpicturefileex
@DllImport("OLEAUT32.dll")
HRESULT OleLoadPictureFileEx(VARIANT varFileName, uint xSizeDesired, uint ySizeDesired, LOAD_PICTURE_FLAGS dwFlags, 
                             IDispatch* lplpdispPicture);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/olectl/nf-olectl-olesavepicturefile
@DllImport("OLEAUT32.dll")
HRESULT OleSavePictureFile(IDispatch lpdispPicture, BSTR bstrFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("OLEAUT32.dll")
HCURSOR OleIconToCursor(HINSTANCE hinstExe, HICON hIcon);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
BOOL OleUIAddVerbMenuW(IOleObject lpOleObj, const(PWSTR) lpszShortType, HMENU hMenu, uint uPos, uint uIDVerbMin, 
                       uint uIDVerbMax, BOOL bAddConvert, uint idConvert, HMENU* lphMenu);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
BOOL OleUIAddVerbMenuA(IOleObject lpOleObj, const(PSTR) lpszShortType, HMENU hMenu, uint uPos, uint uIDVerbMin, 
                       uint uIDVerbMax, BOOL bAddConvert, uint idConvert, HMENU* lphMenu);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
uint OleUIInsertObjectW(OLEUIINSERTOBJECTW* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
uint OleUIInsertObjectA(OLEUIINSERTOBJECTA* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
uint OleUIPasteSpecialW(OLEUIPASTESPECIALW* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
uint OleUIPasteSpecialA(OLEUIPASTESPECIALA* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
uint OleUIEditLinksW(OLEUIEDITLINKSW* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
uint OleUIEditLinksA(OLEUIEDITLINKSA* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
uint OleUIChangeIconW(OLEUICHANGEICONW* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
uint OleUIChangeIconA(OLEUICHANGEICONA* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
uint OleUIConvertW(OLEUICONVERTW* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
uint OleUIConvertA(OLEUICONVERTA* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
BOOL OleUICanConvertOrActivateAs(const(GUID)* rClsid, BOOL fIsLinkedObject, ushort wFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
uint OleUIBusyW(OLEUIBUSYW* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
uint OleUIBusyA(OLEUIBUSYA* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
uint OleUIChangeSourceW(OLEUICHANGESOURCEW* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
uint OleUIChangeSourceA(OLEUICHANGESOURCEA* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
uint OleUIObjectPropertiesW(OLEUIOBJECTPROPSW* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
uint OleUIObjectPropertiesA(OLEUIOBJECTPROPSA* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
int OleUIPromptUserW(int nTemplate, HWND hwndParent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
int OleUIPromptUserA(int nTemplate, HWND hwndParent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
BOOL OleUIUpdateLinksW(IOleUILinkContainerW lpOleUILinkCntr, HWND hwndParent, PWSTR lpszTitle, int cLinks);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("oledlg.dll")
BOOL OleUIUpdateLinksA(IOleUILinkContainerA lpOleUILinkCntr, HWND hwndParent, PSTR lpszTitle, int cLinks);


// Interfaces

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nn-oaidl-icreatetypeinfo
@GUID("00020405-0000-0000-c000-000000000046")
interface ICreateTypeInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-setguid
    HRESULT SetGuid(const(GUID)* guid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-settypeflags
    HRESULT SetTypeFlags(uint uTypeFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-setdocstring
    HRESULT SetDocString(PWSTR pStrDoc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-sethelpcontext
    HRESULT SetHelpContext(uint dwHelpContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-setversion
    HRESULT SetVersion(ushort wMajorVerNum, ushort wMinorVerNum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-addreftypeinfo
    HRESULT AddRefTypeInfo(ITypeInfo pTInfo, uint* phRefType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-addfuncdesc
    HRESULT AddFuncDesc(uint index, FUNCDESC* pFuncDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-addimpltype
    HRESULT AddImplType(uint index, uint hRefType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-setimpltypeflags
    HRESULT SetImplTypeFlags(uint index, IMPLTYPEFLAGS implTypeFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-setalignment
    HRESULT SetAlignment(ushort cbAlignment);
    HRESULT SetSchema(PWSTR pStrSchema);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-addvardesc
    HRESULT AddVarDesc(uint index, VARDESC* pVarDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-setfuncandparamnames
    HRESULT SetFuncAndParamNames(uint index, PWSTR* rgszNames, uint cNames);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-setvarname
    HRESULT SetVarName(uint index, PWSTR szName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-settypedescalias
    HRESULT SetTypeDescAlias(TYPEDESC* pTDescAlias);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-definefuncasdllentry
    HRESULT DefineFuncAsDllEntry(uint index, PWSTR szDllName, PWSTR szProcName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-setfuncdocstring
    HRESULT SetFuncDocString(uint index, PWSTR szDocString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-setvardocstring
    HRESULT SetVarDocString(uint index, PWSTR szDocString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-setfunchelpcontext
    HRESULT SetFuncHelpContext(uint index, uint dwHelpContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-setvarhelpcontext
    HRESULT SetVarHelpContext(uint index, uint dwHelpContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-setmops
    HRESULT SetMops(uint index, BSTR bstrMops);
    HRESULT SetTypeIdldesc(IDLDESC* pIdlDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo-layout
    HRESULT LayOut();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nn-oaidl-icreatetypeinfo2
@GUID("0002040e-0000-0000-c000-000000000046")
interface ICreateTypeInfo2 : ICreateTypeInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo2-deletefuncdesc
    HRESULT DeleteFuncDesc(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo2-deletefuncdescbymemid
    HRESULT DeleteFuncDescByMemId(int memid, INVOKEKIND invKind);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo2-deletevardesc
    HRESULT DeleteVarDesc(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo2-deletevardescbymemid
    HRESULT DeleteVarDescByMemId(int memid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo2-deleteimpltype
    HRESULT DeleteImplType(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo2-setcustdata
    HRESULT SetCustData(const(GUID)* guid, VARIANT* pVarVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo2-setfunccustdata
    HRESULT SetFuncCustData(uint index, const(GUID)* guid, VARIANT* pVarVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo2-setparamcustdata
    HRESULT SetParamCustData(uint indexFunc, uint indexParam, const(GUID)* guid, VARIANT* pVarVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo2-setvarcustdata
    HRESULT SetVarCustData(uint index, const(GUID)* guid, VARIANT* pVarVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo2-setimpltypecustdata
    HRESULT SetImplTypeCustData(uint index, const(GUID)* guid, VARIANT* pVarVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo2-sethelpstringcontext
    HRESULT SetHelpStringContext(uint dwHelpStringContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo2-setfunchelpstringcontext
    HRESULT SetFuncHelpStringContext(uint index, uint dwHelpStringContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo2-setvarhelpstringcontext
    HRESULT SetVarHelpStringContext(uint index, uint dwHelpStringContext);
    HRESULT Invalidate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypeinfo2-setname
    HRESULT SetName(PWSTR szName);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nn-oaidl-icreatetypelib
@GUID("00020406-0000-0000-c000-000000000046")
interface ICreateTypeLib : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypelib-createtypeinfo
    HRESULT CreateTypeInfo(PWSTR szName, TYPEKIND tkind, ICreateTypeInfo* ppCTInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypelib-setname
    HRESULT SetName(PWSTR szName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypelib-setversion
    HRESULT SetVersion(ushort wMajorVerNum, ushort wMinorVerNum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypelib-setguid
    HRESULT SetGuid(const(GUID)* guid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypelib-setdocstring
    HRESULT SetDocString(PWSTR szDoc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypelib-sethelpfilename
    HRESULT SetHelpFileName(PWSTR szHelpFileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypelib-sethelpcontext
    HRESULT SetHelpContext(uint dwHelpContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypelib-setlcid
    HRESULT SetLcid(uint lcid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypelib-setlibflags
    HRESULT SetLibFlags(uint uLibFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypelib-saveallchanges
    HRESULT SaveAllChanges();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nn-oaidl-icreatetypelib2
@GUID("0002040f-0000-0000-c000-000000000046")
interface ICreateTypeLib2 : ICreateTypeLib
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypelib2-deletetypeinfo
    HRESULT DeleteTypeInfo(PWSTR szName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypelib2-setcustdata
    HRESULT SetCustData(const(GUID)* guid, VARIANT* pVarVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypelib2-sethelpstringcontext
    HRESULT SetHelpStringContext(uint dwHelpStringContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreatetypelib2-sethelpstringdll
    HRESULT SetHelpStringDll(PWSTR szFileName);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nn-oaidl-ienumvariant
@GUID("00020404-0000-0000-c000-000000000046")
interface IEnumVARIANT : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Next(uint celt, VARIANT* rgVar, uint* pCeltFetched);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-ienumvariant-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-ienumvariant-clone
    HRESULT Clone(IEnumVARIANT* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nn-oaidl-itypechangeevents
@GUID("00020410-0000-0000-c000-000000000046")
interface ITypeChangeEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypechangeevents-requesttypechange
    HRESULT RequestTypeChange(CHANGEKIND changeKind, ITypeInfo pTInfoBefore, PWSTR pStrName, int* pfCancel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypechangeevents-aftertypechange
    HRESULT AfterTypeChange(CHANGEKIND changeKind, ITypeInfo pTInfoAfter, PWSTR pStrName);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nn-oaidl-icreateerrorinfo
@GUID("22f03340-547d-101b-8e65-08002b2bd119")
interface ICreateErrorInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreateerrorinfo-setguid
    HRESULT SetGUID(const(GUID)* rguid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreateerrorinfo-setsource
    HRESULT SetSource(PWSTR szSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreateerrorinfo-setdescription
    HRESULT SetDescription(PWSTR szDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreateerrorinfo-sethelpfile
    HRESULT SetHelpFile(PWSTR szHelpFile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-icreateerrorinfo-sethelpcontext
    HRESULT SetHelpContext(uint dwHelpContext);
}

@GUID("0000002e-0000-0000-c000-000000000046")
interface ITypeFactory : IUnknown
{
    HRESULT CreateFromTypeInfo(ITypeInfo pTypeInfo, const(GUID)* riid, IUnknown* ppv);
}

@GUID("0000002d-0000-0000-c000-000000000046")
interface ITypeMarshal : IUnknown
{
    HRESULT Size(void* pvType, uint dwDestContext, void* pvDestContext, uint* pSize);
    HRESULT Marshal(void* pvType, uint dwDestContext, void* pvDestContext, uint cbBufferLength, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pBuffer, 
                    uint* pcbWritten);
    HRESULT Unmarshal(void* pvType, uint dwFlags, uint cbBufferLength, ubyte* pBuffer, uint* pcbRead);
    HRESULT Free(void* pvType);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nn-oaidl-irecordinfo
@GUID("0000002f-0000-0000-c000-000000000046")
interface IRecordInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-irecordinfo-recordinit
    HRESULT RecordInit(void* pvNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-irecordinfo-recordclear
    HRESULT RecordClear(void* pvExisting);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-irecordinfo-recordcopy
    HRESULT RecordCopy(void* pvExisting, void* pvNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-irecordinfo-getguid
    HRESULT GetGuid(GUID* pguid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-irecordinfo-getname
    HRESULT GetName(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-irecordinfo-getsize
    HRESULT GetSize(uint* pcbSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-irecordinfo-gettypeinfo
    HRESULT GetTypeInfo(ITypeInfo* ppTypeInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-irecordinfo-getfield
    HRESULT GetField(void* pvData, const(PWSTR) szFieldName, VARIANT* pvarField);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-irecordinfo-getfieldnocopy
    HRESULT GetFieldNoCopy(void* pvData, const(PWSTR) szFieldName, VARIANT* pvarField, void** ppvDataCArray);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-irecordinfo-putfield
    HRESULT PutField(uint wFlags, void* pvData, const(PWSTR) szFieldName, VARIANT* pvarField);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-irecordinfo-putfieldnocopy
    HRESULT PutFieldNoCopy(uint wFlags, void* pvData, const(PWSTR) szFieldName, VARIANT* pvarField);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-irecordinfo-getfieldnames
    HRESULT GetFieldNames(uint* pcNames, BSTR* rgBstrNames);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-irecordinfo-ismatchingtype
    BOOL    IsMatchingType(IRecordInfo pRecordInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-irecordinfo-recordcreate
    void*   RecordCreate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-irecordinfo-recordcreatecopy
    HRESULT RecordCreateCopy(void* pvSource, void** ppvDest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-irecordinfo-recorddestroy
    HRESULT RecordDestroy(void* pvRecord);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-ioleadviseholder
@GUID("00000111-0000-0000-c000-000000000046")
interface IOleAdviseHolder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleadviseholder-advise
    HRESULT Advise(IAdviseSink pAdvise, uint* pdwConnection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleadviseholder-unadvise
    HRESULT Unadvise(uint dwConnection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleadviseholder-enumadvise
    HRESULT EnumAdvise(IEnumSTATDATA* ppenumAdvise);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleadviseholder-sendonrename
    HRESULT SendOnRename(IMoniker pmk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleadviseholder-sendonsave
    HRESULT SendOnSave();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleadviseholder-sendonclose
    HRESULT SendOnClose();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-iolecache
@GUID("0000011e-0000-0000-c000-000000000046")
interface IOleCache : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolecache-cache
    HRESULT Cache(FORMATETC* pformatetc, uint advf, uint* pdwConnection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolecache-uncache
    HRESULT Uncache(uint dwConnection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolecache-enumcache
    HRESULT EnumCache(IEnumSTATDATA* ppenumSTATDATA);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolecache-initcache
    HRESULT InitCache(IDataObject pDataObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolecache-setdata
    HRESULT SetData(FORMATETC* pformatetc, STGMEDIUM* pmedium, BOOL fRelease);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-iolecache2
@GUID("00000128-0000-0000-c000-000000000046")
interface IOleCache2 : IOleCache
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolecache2-updatecache
    HRESULT UpdateCache(IDataObject pDataObject, UPDFCACHE_FLAGS grfUpdf, 
                        /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolecache2-discardcache
    HRESULT DiscardCache(uint dwDiscardOptions);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-iolecachecontrol
@GUID("00000129-0000-0000-c000-000000000046")
interface IOleCacheControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolecachecontrol-onrun
    HRESULT OnRun(IDataObject pDataObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolecachecontrol-onstop
    HRESULT OnStop();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-iparsedisplayname
@GUID("0000011a-0000-0000-c000-000000000046")
interface IParseDisplayName : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iparsedisplayname-parsedisplayname
    HRESULT ParseDisplayName(IBindCtx pbc, PWSTR pszDisplayName, uint* pchEaten, IMoniker* ppmkOut);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-iolecontainer
@GUID("0000011b-0000-0000-c000-000000000046")
interface IOleContainer : IParseDisplayName
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolecontainer-enumobjects
    HRESULT EnumObjects(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLECONTF))], [])*/uint grfFlags, 
                        IEnumUnknown* ppenum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolecontainer-lockcontainer
    HRESULT LockContainer(BOOL fLock);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-ioleclientsite
@GUID("00000118-0000-0000-c000-000000000046")
interface IOleClientSite : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleclientsite-saveobject
    HRESULT SaveObject();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleclientsite-getmoniker
    HRESULT GetMoniker(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLEGETMONIKER))], [])*/uint dwAssign, 
                       /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLEWHICHMK))], [])*/uint dwWhichMoniker, 
                       IMoniker* ppmk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleclientsite-getcontainer
    HRESULT GetContainer(IOleContainer* ppContainer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleclientsite-showobject
    HRESULT ShowObject();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleclientsite-onshowwindow
    HRESULT OnShowWindow(BOOL fShow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleclientsite-requestnewobjectlayout
    HRESULT RequestNewObjectLayout();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-ioleobject
@GUID("00000112-0000-0000-c000-000000000046")
interface IOleObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-setclientsite
    HRESULT SetClientSite(IOleClientSite pClientSite);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-getclientsite
    HRESULT GetClientSite(IOleClientSite* ppClientSite);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-sethostnames
    HRESULT SetHostNames(const(PWSTR) szContainerApp, const(PWSTR) szContainerObj);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-close
    HRESULT Close(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLECLOSE))], [])*/uint dwSaveOption);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-setmoniker
    HRESULT SetMoniker(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLEWHICHMK))], [])*/uint dwWhichMoniker, 
                       IMoniker pmk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-getmoniker
    HRESULT GetMoniker(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLEGETMONIKER))], [])*/uint dwAssign, 
                       /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLEWHICHMK))], [])*/uint dwWhichMoniker, 
                       IMoniker* ppmk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-initfromdata
    HRESULT InitFromData(IDataObject pDataObject, BOOL fCreation, uint dwReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-getclipboarddata
    HRESULT GetClipboardData(uint dwReserved, IDataObject* ppDataObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-doverb
    HRESULT DoVerb(int iVerb, MSG* lpmsg, IOleClientSite pActiveSite, int lindex, HWND hwndParent, 
                   RECT* lprcPosRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-enumverbs
    HRESULT EnumVerbs(IEnumOLEVERB* ppEnumOleVerb);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-update
    HRESULT Update();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-isuptodate
    HRESULT IsUpToDate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-getuserclassid
    HRESULT GetUserClassID(GUID* pClsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-getusertype
    HRESULT GetUserType(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(USERCLASSTYPE))], [])*/uint dwFormOfType, 
                        PWSTR* pszUserType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-setextent
    HRESULT SetExtent(DVASPECT dwDrawAspect, SIZE* psizel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-getextent
    HRESULT GetExtent(DVASPECT dwDrawAspect, SIZE* psizel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-advise
    HRESULT Advise(IAdviseSink pAdvSink, uint* pdwConnection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-unadvise
    HRESULT Unadvise(uint dwConnection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-enumadvise
    HRESULT EnumAdvise(IEnumSTATDATA* ppenumAdvise);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-getmiscstatus
    HRESULT GetMiscStatus(DVASPECT dwAspect, OLEMISC* pdwStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleobject-setcolorscheme
    HRESULT SetColorScheme(LOGPALETTE* pLogpal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-iolewindow
@GUID("00000114-0000-0000-c000-000000000046")
interface IOleWindow : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolewindow-getwindow
    HRESULT GetWindow(HWND* phwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolewindow-contextsensitivehelp
    HRESULT ContextSensitiveHelp(BOOL fEnterMode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-iolelink
@GUID("0000011d-0000-0000-c000-000000000046")
interface IOleLink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolelink-setupdateoptions
    HRESULT SetUpdateOptions(uint dwUpdateOpt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolelink-getupdateoptions
    HRESULT GetUpdateOptions(uint* pdwUpdateOpt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolelink-setsourcemoniker
    HRESULT SetSourceMoniker(IMoniker pmk, const(GUID)* rclsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolelink-getsourcemoniker
    HRESULT GetSourceMoniker(IMoniker* ppmk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolelink-setsourcedisplayname
    HRESULT SetSourceDisplayName(const(PWSTR) pszStatusText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolelink-getsourcedisplayname
    HRESULT GetSourceDisplayName(PWSTR* ppszDisplayName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolelink-bindtosource
    HRESULT BindToSource(uint bindflags, IBindCtx pbc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolelink-bindifrunning
    HRESULT BindIfRunning();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolelink-getboundsource
    HRESULT GetBoundSource(IUnknown* ppunk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolelink-unbindsource
    HRESULT UnbindSource();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iolelink-update
    HRESULT Update(IBindCtx pbc);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-ioleitemcontainer
@GUID("0000011c-0000-0000-c000-000000000046")
interface IOleItemContainer : IOleContainer
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleitemcontainer-getobject
    HRESULT GetObject(PWSTR pszItem, uint dwSpeedNeeded, IBindCtx pbc, const(GUID)* riid, void** ppvObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleitemcontainer-getobjectstorage
    HRESULT GetObjectStorage(PWSTR pszItem, IBindCtx pbc, const(GUID)* riid, void** ppvStorage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleitemcontainer-isrunning
    HRESULT IsRunning(PWSTR pszItem);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-ioleinplaceuiwindow
@GUID("00000115-0000-0000-c000-000000000046")
interface IOleInPlaceUIWindow : IOleWindow
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplaceuiwindow-getborder
    HRESULT GetBorder(RECT* lprectBorder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplaceuiwindow-requestborderspace
    HRESULT RequestBorderSpace(RECT* pborderwidths);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplaceuiwindow-setborderspace
    HRESULT SetBorderSpace(RECT* pborderwidths);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplaceuiwindow-setactiveobject
    HRESULT SetActiveObject(IOleInPlaceActiveObject pActiveObject, const(PWSTR) pszObjName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-ioleinplaceactiveobject
@GUID("00000117-0000-0000-c000-000000000046")
interface IOleInPlaceActiveObject : IOleWindow
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplaceactiveobject-translateaccelerator
    HRESULT TranslateAccelerator(MSG* lpmsg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplaceactiveobject-onframewindowactivate
    HRESULT OnFrameWindowActivate(BOOL fActivate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplaceactiveobject-ondocwindowactivate
    HRESULT OnDocWindowActivate(BOOL fActivate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplaceactiveobject-resizeborder
    HRESULT ResizeBorder(RECT* prcBorder, IOleInPlaceUIWindow pUIWindow, BOOL fFrameWindow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplaceactiveobject-enablemodeless
    HRESULT EnableModeless(BOOL fEnable);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-ioleinplaceframe
@GUID("00000116-0000-0000-c000-000000000046")
interface IOleInPlaceFrame : IOleInPlaceUIWindow
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplaceframe-insertmenus
    HRESULT InsertMenus(HMENU hmenuShared, OLEMENUGROUPWIDTHS* lpMenuWidths);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplaceframe-setmenu
    HRESULT SetMenu(HMENU hmenuShared, ptrdiff_t holemenu, HWND hwndActiveObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplaceframe-removemenus
    HRESULT RemoveMenus(HMENU hmenuShared);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplaceframe-setstatustext
    HRESULT SetStatusText(const(PWSTR) pszStatusText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplaceframe-enablemodeless
    HRESULT EnableModeless(BOOL fEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplaceframe-translateaccelerator
    HRESULT TranslateAccelerator(MSG* lpmsg, ushort wID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-ioleinplaceobject
@GUID("00000113-0000-0000-c000-000000000046")
interface IOleInPlaceObject : IOleWindow
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplaceobject-inplacedeactivate
    HRESULT InPlaceDeactivate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplaceobject-uideactivate
    HRESULT UIDeactivate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplaceobject-setobjectrects
    HRESULT SetObjectRects(RECT* lprcPosRect, RECT* lprcClipRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplaceobject-reactivateandundo
    HRESULT ReactivateAndUndo();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-ioleinplacesite
@GUID("00000119-0000-0000-c000-000000000046")
interface IOleInPlaceSite : IOleWindow
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplacesite-caninplaceactivate
    HRESULT CanInPlaceActivate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplacesite-oninplaceactivate
    HRESULT OnInPlaceActivate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplacesite-onuiactivate
    HRESULT OnUIActivate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplacesite-getwindowcontext
    HRESULT GetWindowContext(IOleInPlaceFrame* ppFrame, IOleInPlaceUIWindow* ppDoc, RECT* lprcPosRect, 
                             RECT* lprcClipRect, OLEINPLACEFRAMEINFO* lpFrameInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplacesite-scroll
    HRESULT Scroll(SIZE scrollExtant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplacesite-onuideactivate
    HRESULT OnUIDeactivate(BOOL fUndoable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplacesite-oninplacedeactivate
    HRESULT OnInPlaceDeactivate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplacesite-discardundostate
    HRESULT DiscardUndoState();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplacesite-deactivateandundo
    HRESULT DeactivateAndUndo();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ioleinplacesite-onposrectchange
    HRESULT OnPosRectChange(RECT* lprcPosRect);
}

@GUID("0000012a-0000-0000-c000-000000000046")
interface IContinue : IUnknown
{
    HRESULT FContinue();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-iviewobject
@GUID("0000010d-0000-0000-c000-000000000046")
interface IViewObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iviewobject-draw
    HRESULT Draw(DVASPECT dwDrawAspect, int lindex, void* pvAspect, DVTARGETDEVICE* ptd, HDC hdcTargetDev, 
                 HDC hdcDraw, RECTL* lprcBounds, RECTL* lprcWBounds, ptrdiff_t pfnContinue, size_t dwContinue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iviewobject-getcolorset
    HRESULT GetColorSet(DVASPECT dwDrawAspect, int lindex, void* pvAspect, DVTARGETDEVICE* ptd, HDC hicTargetDev, 
                        LOGPALETTE** ppColorSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iviewobject-freeze
    HRESULT Freeze(DVASPECT dwDrawAspect, int lindex, void* pvAspect, uint* pdwFreeze);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iviewobject-unfreeze
    HRESULT Unfreeze(uint dwFreeze);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iviewobject-setadvise
    HRESULT SetAdvise(DVASPECT aspects, uint advf, IAdviseSink pAdvSink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iviewobject-getadvise
    HRESULT GetAdvise(uint* pAspects, uint* pAdvf, IAdviseSink* ppAdvSink);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-iviewobject2
@GUID("00000127-0000-0000-c000-000000000046")
interface IViewObject2 : IViewObject
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-iviewobject2-getextent
    HRESULT GetExtent(DVASPECT dwDrawAspect, int lindex, DVTARGETDEVICE* ptd, SIZE* lpsizel);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-idropsource
@GUID("00000121-0000-0000-c000-000000000046")
interface IDropSource : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT QueryContinueDrag(BOOL fEscapePressed, MODIFIERKEYS_FLAGS grfKeyState);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT GiveFeedback(DROPEFFECT dwEffect);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-idroptarget
@GUID("00000122-0000-0000-c000-000000000046")
interface IDropTarget : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-idroptarget-dragenter
    HRESULT DragEnter(IDataObject pDataObj, MODIFIERKEYS_FLAGS grfKeyState, POINTL pt, DROPEFFECT* pdwEffect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-idroptarget-dragover
    HRESULT DragOver(MODIFIERKEYS_FLAGS grfKeyState, POINTL pt, DROPEFFECT* pdwEffect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-idroptarget-dragleave
    HRESULT DragLeave();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-idroptarget-drop
    HRESULT Drop(IDataObject pDataObj, MODIFIERKEYS_FLAGS grfKeyState, POINTL pt, DROPEFFECT* pdwEffect);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-idropsourcenotify
@GUID("0000012b-0000-0000-c000-000000000046")
interface IDropSourceNotify : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-idropsourcenotify-dragentertarget
    HRESULT DragEnterTarget(HWND hwndTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-idropsourcenotify-dragleavetarget
    HRESULT DragLeaveTarget();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-ienterprisedroptarget
@GUID("390e3878-fd55-4e18-819d-4682081c0cfd")
interface IEnterpriseDropTarget : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ienterprisedroptarget-setdropsourceenterpriseid
    HRESULT SetDropSourceEnterpriseId(const(PWSTR) identity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ienterprisedroptarget-isevaluatingedppolicy
    HRESULT IsEvaluatingEdpPolicy(BOOL* value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nn-oleidl-ienumoleverb
@GUID("00000104-0000-0000-c000-000000000046")
interface IEnumOLEVERB : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ienumoleverb-next
    HRESULT Next(uint celt, OLEVERB* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ienumoleverb-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ienumoleverb-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oleidl/nf-oleidl-ienumoleverb-clone
    HRESULT Clone(IEnumOLEVERB* ppenum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-iclassfactory2
@GUID("b196b28f-bab4-101a-b69c-00aa00341d07")
interface IClassFactory2 : IClassFactory
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iclassfactory2-getlicinfo
    HRESULT GetLicInfo(LICINFO* pLicInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iclassfactory2-requestlickey
    HRESULT RequestLicKey(uint dwReserved, BSTR* pBstrKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iclassfactory2-createinstancelic
    HRESULT CreateInstanceLic(IUnknown pUnkOuter, 
                              /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/IUnknown pUnkReserved, 
                              const(GUID)* riid, BSTR bstrKey, void** ppvObj);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-iprovideclassinfo
@GUID("b196b283-bab4-101a-b69c-00aa00341d07")
interface IProvideClassInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iprovideclassinfo-getclassinfo
    HRESULT GetClassInfo(ITypeInfo* ppTI);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-iprovideclassinfo2
@GUID("a6bc3ac0-dbaa-11ce-9de3-00aa004bb851")
interface IProvideClassInfo2 : IProvideClassInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iprovideclassinfo2-getguid
    HRESULT GetGUID(uint dwGuidKind, GUID* pGUID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-iprovidemultipleclassinfo
@GUID("a7aba9c1-8983-11cf-8f20-00805f2cd064")
interface IProvideMultipleClassInfo : IProvideClassInfo2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iprovidemultipleclassinfo-getmultitypeinfocount
    HRESULT GetMultiTypeInfoCount(uint* pcti);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iprovidemultipleclassinfo-getinfoofindex
    HRESULT GetInfoOfIndex(uint iti, MULTICLASSINFO_FLAGS dwFlags, ITypeInfo* pptiCoClass, uint* pdwTIFlags, 
                           uint* pcdispidReserved, GUID* piidPrimary, GUID* piidSource);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-iolecontrol
@GUID("b196b288-bab4-101a-b69c-00aa00341d07")
interface IOleControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iolecontrol-getcontrolinfo
    HRESULT GetControlInfo(CONTROLINFO* pCI);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iolecontrol-onmnemonic
    HRESULT OnMnemonic(MSG* pMsg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iolecontrol-onambientpropertychange
    HRESULT OnAmbientPropertyChange(int dispID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iolecontrol-freezeevents
    HRESULT FreezeEvents(BOOL bFreeze);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-iolecontrolsite
@GUID("b196b289-bab4-101a-b69c-00aa00341d07")
interface IOleControlSite : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iolecontrolsite-oncontrolinfochanged
    HRESULT OnControlInfoChanged();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iolecontrolsite-lockinplaceactive
    HRESULT LockInPlaceActive(BOOL fLock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iolecontrolsite-getextendedcontrol
    HRESULT GetExtendedControl(IDispatch* ppDisp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iolecontrolsite-transformcoords
    HRESULT TransformCoords(POINTL* pPtlHimetric, POINTF* pPtfContainer, 
                            /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(XFORMCOORDS))], [])*/uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iolecontrolsite-translateaccelerator
    HRESULT TranslateAccelerator(MSG* pMsg, KEYMODIFIERS grfModifiers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iolecontrolsite-onfocus
    HRESULT OnFocus(BOOL fGotFocus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iolecontrolsite-showpropertyframe
    HRESULT ShowPropertyFrame();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ipropertypage
@GUID("b196b28d-bab4-101a-b69c-00aa00341d07")
interface IPropertyPage : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipropertypage-setpagesite
    HRESULT SetPageSite(IPropertyPageSite pPageSite);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipropertypage-activate
    HRESULT Activate(HWND hWndParent, RECT* pRect, BOOL bModal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipropertypage-deactivate
    HRESULT Deactivate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipropertypage-getpageinfo
    HRESULT GetPageInfo(PROPPAGEINFO* pPageInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipropertypage-setobjects
    HRESULT SetObjects(uint cObjects, IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipropertypage-show
    HRESULT Show(uint nCmdShow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipropertypage-move
    HRESULT Move(RECT* pRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipropertypage-ispagedirty
    HRESULT IsPageDirty();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipropertypage-apply
    HRESULT Apply();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipropertypage-help
    HRESULT Help(const(PWSTR) pszHelpDir);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipropertypage-translateaccelerator
    HRESULT TranslateAccelerator(MSG* pMsg);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ipropertypage2
@GUID("01e44665-24ac-101b-84ed-08002b2ec713")
interface IPropertyPage2 : IPropertyPage
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipropertypage2-editproperty
    HRESULT EditProperty(int dispID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ipropertypagesite
@GUID("b196b28c-bab4-101a-b69c-00aa00341d07")
interface IPropertyPageSite : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipropertypagesite-onstatuschange
    HRESULT OnStatusChange(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(PROPPAGESTATUS))], [])*/uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipropertypagesite-getlocaleid
    HRESULT GetLocaleID(uint* pLocaleID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipropertypagesite-getpagecontainer
    HRESULT GetPageContainer(IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipropertypagesite-translateaccelerator
    HRESULT TranslateAccelerator(MSG* pMsg);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ipropertynotifysink
@GUID("9bfbbc02-eff1-101a-84ed-00aa00341d07")
interface IPropertyNotifySink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipropertynotifysink-onchanged
    HRESULT OnChanged(int dispID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipropertynotifysink-onrequestedit
    HRESULT OnRequestEdit(int dispID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ispecifypropertypages
@GUID("b196b28b-bab4-101a-b69c-00aa00341d07")
interface ISpecifyPropertyPages : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ispecifypropertypages-getpages
    HRESULT GetPages(CAUUID* pPages);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ipersistpropertybag
@GUID("37d84f60-42cb-11ce-8135-00aa004bb851")
interface IPersistPropertyBag : IPersist
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipersistpropertybag-initnew
    HRESULT InitNew();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipersistpropertybag-load
    HRESULT Load(IPropertyBag pPropBag, IErrorLog pErrorLog);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipersistpropertybag-save
    HRESULT Save(IPropertyBag pPropBag, BOOL fClearDirty, BOOL fSaveAllProperties);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-isimpleframesite
@GUID("742b0e01-14e6-101b-914e-00aa00300cab")
interface ISimpleFrameSite : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-isimpleframesite-premessagefilter
    HRESULT PreMessageFilter(HWND hWnd, uint msg, WPARAM wp, LPARAM lp, LRESULT* plResult, uint* pdwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-isimpleframesite-postmessagefilter
    HRESULT PostMessageFilter(HWND hWnd, uint msg, WPARAM wp, LPARAM lp, LRESULT* plResult, uint dwCookie);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ifont
@GUID("bef6e002-a874-101a-8bba-00aa00300cab")
interface IFont : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-get_name
    HRESULT get_Name(BSTR* pName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-put_name
    HRESULT put_Name(BSTR name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-get_size
    HRESULT get_Size(CY* pSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-put_size
    HRESULT put_Size(CY size);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-get_bold
    HRESULT get_Bold(BOOL* pBold);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-put_bold
    HRESULT put_Bold(BOOL bold);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-get_italic
    HRESULT get_Italic(BOOL* pItalic);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-put_italic
    HRESULT put_Italic(BOOL italic);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-get_underline
    HRESULT get_Underline(BOOL* pUnderline);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-put_underline
    HRESULT put_Underline(BOOL underline);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-get_strikethrough
    HRESULT get_Strikethrough(BOOL* pStrikethrough);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-put_strikethrough
    HRESULT put_Strikethrough(BOOL strikethrough);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-get_weight
    HRESULT get_Weight(short* pWeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-put_weight
    HRESULT put_Weight(short weight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-get_charset
    HRESULT get_Charset(short* pCharset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-put_charset
    HRESULT put_Charset(short charset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-get_hfont
    HRESULT get_hFont(HFONT* phFont);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-clone
    HRESULT Clone(IFont* ppFont);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-isequal
    HRESULT IsEqual(IFont pFontOther);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-setratio
    HRESULT SetRatio(int cyLogical, int cyHimetric);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-querytextmetrics
    HRESULT QueryTextMetrics(TEXTMETRICW* pTM);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-addrefhfont
    HRESULT AddRefHfont(HFONT hFont);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-releasehfont
    HRESULT ReleaseHfont(HFONT hFont);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ifont-sethdc
    HRESULT SetHdc(HDC hDC);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ipicture
@GUID("7bf80980-bf32-101a-8bbb-00aa00300cab")
interface IPicture : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipicture-get_handle
    HRESULT get_Handle(OLE_HANDLE* pHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipicture-get_hpal
    HRESULT get_hPal(OLE_HANDLE* phPal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipicture-get_type
    HRESULT get_Type(PICTYPE* pType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipicture-get_width
    HRESULT get_Width(int* pWidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipicture-get_height
    HRESULT get_Height(int* pHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipicture-render
    HRESULT Render(HDC hDC, int x, int y, int cx, int cy, int xSrc, int ySrc, int cxSrc, int cySrc, 
                   RECT* pRcWBounds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipicture-set_hpal
    HRESULT set_hPal(OLE_HANDLE hPal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipicture-get_curdc
    HRESULT get_CurDC(HDC* phDC);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipicture-selectpicture
    HRESULT SelectPicture(HDC hDCIn, HDC* phDCOut, OLE_HANDLE* phBmpOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipicture-get_keeporiginalformat
    HRESULT get_KeepOriginalFormat(BOOL* pKeep);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipicture-put_keeporiginalformat
    HRESULT put_KeepOriginalFormat(BOOL keep);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipicture-picturechanged
    HRESULT PictureChanged();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipicture-saveasfile
    HRESULT SaveAsFile(IStream pStream, BOOL fSaveMemCopy, int* pCbSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipicture-get_attributes
    HRESULT get_Attributes(uint* pDwAttr);
}

@GUID("f5185dd8-2012-4b0b-aad9-f052c6bd482b")
interface IPicture2 : IUnknown
{
    HRESULT get_Handle(size_t* pHandle);
    HRESULT get_hPal(size_t* phPal);
    HRESULT get_Type(short* pType);
    HRESULT get_Width(int* pWidth);
    HRESULT get_Height(int* pHeight);
    HRESULT Render(HDC hDC, int x, int y, int cx, int cy, int xSrc, int ySrc, int cxSrc, int cySrc, 
                   RECT* pRcWBounds);
    HRESULT set_hPal(size_t hPal);
    HRESULT get_CurDC(HDC* phDC);
    HRESULT SelectPicture(HDC hDCIn, HDC* phDCOut, size_t* phBmpOut);
    HRESULT get_KeepOriginalFormat(BOOL* pKeep);
    HRESULT put_KeepOriginalFormat(BOOL keep);
    HRESULT PictureChanged();
    HRESULT SaveAsFile(IStream pStream, BOOL fSaveMemCopy, int* pCbSize);
    HRESULT get_Attributes(uint* pDwAttr);
}

@GUID("4ef6100a-af88-11d0-9846-00c04fc29993")
interface IFontEventsDisp : IDispatch
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ifontdisp
@GUID("bef6e003-a874-101a-8bba-00aa00300cab")
interface IFontDisp : IDispatch
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ipicturedisp
@GUID("7bf80981-bf32-101a-8bbb-00aa00300cab")
interface IPictureDisp : IDispatch
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ioleinplaceobjectwindowless
@GUID("1c2056cc-5ef4-101b-8bc8-00aa003e3b29")
interface IOleInPlaceObjectWindowless : IOleInPlaceObject
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleinplaceobjectwindowless-onwindowmessage
    HRESULT OnWindowMessage(uint msg, WPARAM wParam, LPARAM lParam, LRESULT* plResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleinplaceobjectwindowless-getdroptarget
    HRESULT GetDropTarget(IDropTarget* ppDropTarget);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ioleinplacesiteex
@GUID("9c2cad80-3424-11cf-b670-00aa004cd6d8")
interface IOleInPlaceSiteEx : IOleInPlaceSite
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleinplacesiteex-oninplaceactivateex
    HRESULT OnInPlaceActivateEx(BOOL* pfNoRedraw, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleinplacesiteex-oninplacedeactivateex
    HRESULT OnInPlaceDeactivateEx(BOOL fNoRedraw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleinplacesiteex-requestuiactivate
    HRESULT RequestUIActivate();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ioleinplacesitewindowless
@GUID("922eada0-3424-11cf-b670-00aa004cd6d8")
interface IOleInPlaceSiteWindowless : IOleInPlaceSiteEx
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleinplacesitewindowless-canwindowlessactivate
    HRESULT CanWindowlessActivate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleinplacesitewindowless-getcapture
    HRESULT GetCapture();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleinplacesitewindowless-setcapture
    HRESULT SetCapture(BOOL fCapture);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleinplacesitewindowless-getfocus
    HRESULT GetFocus();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleinplacesitewindowless-setfocus
    HRESULT SetFocus(BOOL fFocus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleinplacesitewindowless-getdc
    HRESULT GetDC(RECT* pRect, uint grfFlags, HDC* phDC);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleinplacesitewindowless-releasedc
    HRESULT ReleaseDC(HDC hDC);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleinplacesitewindowless-invalidaterect
    HRESULT InvalidateRect(RECT* pRect, BOOL fErase);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleinplacesitewindowless-invalidatergn
    HRESULT InvalidateRgn(HRGN hRGN, BOOL fErase);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleinplacesitewindowless-scrollrect
    HRESULT ScrollRect(int dx, int dy, RECT* pRectScroll, RECT* pRectClip);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleinplacesitewindowless-adjustrect
    HRESULT AdjustRect(RECT* prc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleinplacesitewindowless-ondefwindowmessage
    HRESULT OnDefWindowMessage(uint msg, WPARAM wParam, LPARAM lParam, LRESULT* plResult);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-iviewobjectex
@GUID("3af24292-0c96-11ce-a0cf-00aa00600ab8")
interface IViewObjectEx : IViewObject2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iviewobjectex-getrect
    HRESULT GetRect(uint dwAspect, RECTL* pRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iviewobjectex-getviewstatus
    HRESULT GetViewStatus(uint* pdwStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iviewobjectex-queryhitpoint
    HRESULT QueryHitPoint(uint dwAspect, RECT* pRectBounds, POINT ptlLoc, int lCloseHint, uint* pHitResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iviewobjectex-queryhitrect
    HRESULT QueryHitRect(uint dwAspect, RECT* pRectBounds, RECT* pRectLoc, int lCloseHint, uint* pHitResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iviewobjectex-getnaturalextent
    HRESULT GetNaturalExtent(DVASPECT dwAspect, int lindex, DVTARGETDEVICE* ptd, HDC hicTargetDev, 
                             DVEXTENTINFO* pExtentInfo, SIZE* pSizel);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ioleundounit
@GUID("894ad3b0-ef97-11ce-9bc9-00aa00608e01")
interface IOleUndoUnit : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleundounit-do
    HRESULT Do(IOleUndoManager pUndoManager);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleundounit-getdescription
    HRESULT GetDescription(BSTR* pBstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleundounit-getunittype
    HRESULT GetUnitType(GUID* pClsid, int* plID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleundounit-onnextadd
    HRESULT OnNextAdd();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ioleparentundounit
@GUID("a1faf330-ef97-11ce-9bc9-00aa00608e01")
interface IOleParentUndoUnit : IOleUndoUnit
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleparentundounit-open
    HRESULT Open(IOleParentUndoUnit pPUU);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleparentundounit-close
    HRESULT Close(IOleParentUndoUnit pPUU, BOOL fCommit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleparentundounit-add
    HRESULT Add(IOleUndoUnit pUU);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleparentundounit-findunit
    HRESULT FindUnit(IOleUndoUnit pUU);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleparentundounit-getparentstate
    HRESULT GetParentState(uint* pdwState);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ienumoleundounits
@GUID("b3e7c340-ef97-11ce-9bc9-00aa00608e01")
interface IEnumOleUndoUnits : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Next(uint cElt, IOleUndoUnit* rgElt, uint* pcEltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ienumoleundounits-skip
    HRESULT Skip(uint cElt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ienumoleundounits-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ienumoleundounits-clone
    HRESULT Clone(IEnumOleUndoUnits* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ioleundomanager
@GUID("d001f200-ef97-11ce-9bc9-00aa00608e01")
interface IOleUndoManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleundomanager-open
    HRESULT Open(IOleParentUndoUnit pPUU);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Close(IOleParentUndoUnit pPUU, BOOL fCommit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleundomanager-add
    HRESULT Add(IOleUndoUnit pUU);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleundomanager-getopenparentstate
    HRESULT GetOpenParentState(uint* pdwState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleundomanager-discardfrom
    HRESULT DiscardFrom(IOleUndoUnit pUU);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleundomanager-undoto
    HRESULT UndoTo(IOleUndoUnit pUU);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleundomanager-redoto
    HRESULT RedoTo(IOleUndoUnit pUU);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleundomanager-enumundoable
    HRESULT EnumUndoable(IEnumOleUndoUnits* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleundomanager-enumredoable
    HRESULT EnumRedoable(IEnumOleUndoUnits* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleundomanager-getlastundodescription
    HRESULT GetLastUndoDescription(BSTR* pBstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleundomanager-getlastredodescription
    HRESULT GetLastRedoDescription(BSTR* pBstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ioleundomanager-enable
    HRESULT Enable(BOOL fEnable);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ipointerinactive
@GUID("55980ba0-35aa-11cf-b671-00aa004cd6d8")
interface IPointerInactive : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipointerinactive-getactivationpolicy
    HRESULT GetActivationPolicy(POINTERINACTIVE* pdwPolicy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipointerinactive-oninactivemousemove
    HRESULT OnInactiveMouseMove(RECT* pRectBounds, int x, int y, uint grfKeyState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipointerinactive-oninactivesetcursor
    HRESULT OnInactiveSetCursor(RECT* pRectBounds, int x, int y, uint dwMouseMsg, BOOL fSetAlways);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-iobjectwithsite
@GUID("fc4801a3-2ba9-11cf-a229-00aa003d7352")
interface IObjectWithSite : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iobjectwithsite-setsite
    HRESULT SetSite(IUnknown pUnkSite);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iobjectwithsite-getsite
    HRESULT GetSite(const(GUID)* riid, void** ppvSite);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-iperpropertybrowsing
@GUID("376bd3aa-3845-101b-84ed-08002b2ec713")
interface IPerPropertyBrowsing : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iperpropertybrowsing-getdisplaystring
    HRESULT GetDisplayString(int dispID, BSTR* pBstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iperpropertybrowsing-mappropertytopage
    HRESULT MapPropertyToPage(int dispID, GUID* pClsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iperpropertybrowsing-getpredefinedstrings
    HRESULT GetPredefinedStrings(int dispID, CALPOLESTR* pCaStringsOut, CADWORD* pCaCookiesOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iperpropertybrowsing-getpredefinedvalue
    HRESULT GetPredefinedValue(int dispID, uint dwCookie, VARIANT* pVarOut);
}

@GUID("22f55881-280b-11d0-a8a9-00a0c90c2004")
interface IPersistPropertyBag2 : IPersist
{
    HRESULT InitNew();
    HRESULT Load(IPropertyBag2 pPropBag, IErrorLog pErrLog);
    HRESULT Save(IPropertyBag2 pPropBag, BOOL fClearDirty, BOOL fSaveAllProperties);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT IsDirty();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-iadvisesinkex
@GUID("3af24290-0c96-11ce-a0cf-00aa00600ab8")
interface IAdviseSinkEx : IAdviseSink
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iadvisesinkex-onviewstatuschange
    void OnViewStatusChange(uint dwViewStatus);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-iquickactivate
@GUID("cf51ed10-62fe-11cf-bf86-00a0c9034836")
interface IQuickActivate : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iquickactivate-quickactivate
    HRESULT QuickActivate(QACONTAINER* pQaContainer, QACONTROL* pQaControl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iquickactivate-setcontentextent
    HRESULT SetContentExtent(SIZE* pSizel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iquickactivate-getcontentextent
    HRESULT GetContentExtent(SIZE* pSizel);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vbinterf/nn-vbinterf-ivbgetcontrol
@GUID("40a050a0-3c31-101b-a82e-08002b2b2337")
interface IVBGetControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vbinterf/nf-vbinterf-ivbgetcontrol-enumcontrols
    HRESULT EnumControls(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OLECONTF))], [])*/uint dwOleContF, 
                         ENUM_CONTROLS_WHICH_FLAGS dwWhich, IEnumUnknown* ppenumUnk);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vbinterf/nn-vbinterf-igetoleobject
@GUID("8a701da0-4feb-101b-a82e-08002b2b2337")
interface IGetOleObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vbinterf/nf-vbinterf-igetoleobject-getoleobject
    HRESULT GetOleObject(const(GUID)* riid, void** ppvObj);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vbinterf/nn-vbinterf-ivbformat
@GUID("9849fd60-3768-101b-8d72-ae6164ffe3cf")
interface IVBFormat : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vbinterf/nf-vbinterf-ivbformat-format
    HRESULT Format(VARIANT* vData, BSTR bstrFormat, void* lpBuffer, ushort cb, int lcid, short sFirstDayOfWeek, 
                   ushort sFirstWeekOfYear, ushort* rcb);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vbinterf/nn-vbinterf-igetvbaobject
@GUID("91733a60-3f4c-101b-a3f6-00aa0034e4e9")
interface IGetVBAObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vbinterf/nf-vbinterf-igetvbaobject-getobject
    HRESULT GetObject(const(GUID)* riid, void** ppvObj, uint dwReserved);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nn-docobj-ioledocument
@GUID("b722bcc5-4e68-101b-a2bc-00aa00404770")
interface IOleDocument : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ioledocument-createview
    HRESULT CreateView(IOleInPlaceSite pIPSite, IStream pstm, uint dwReserved, IOleDocumentView* ppView);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ioledocument-getdocmiscstatus
    HRESULT GetDocMiscStatus(uint* pdwStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ioledocument-enumviews
    HRESULT EnumViews(IEnumOleDocumentViews* ppEnum, IOleDocumentView* ppView);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nn-docobj-ioledocumentsite
@GUID("b722bcc7-4e68-101b-a2bc-00aa00404770")
interface IOleDocumentSite : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ioledocumentsite-activateme
    HRESULT ActivateMe(IOleDocumentView pViewToActivate);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nn-docobj-ioledocumentview
@GUID("b722bcc6-4e68-101b-a2bc-00aa00404770")
interface IOleDocumentView : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ioledocumentview-setinplacesite
    HRESULT SetInPlaceSite(IOleInPlaceSite pIPSite);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ioledocumentview-getinplacesite
    HRESULT GetInPlaceSite(IOleInPlaceSite* ppIPSite);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ioledocumentview-getdocument
    HRESULT GetDocument(IUnknown* ppunk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ioledocumentview-setrect
    HRESULT SetRect(RECT* prcView);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ioledocumentview-getrect
    HRESULT GetRect(RECT* prcView);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ioledocumentview-setrectcomplex
    HRESULT SetRectComplex(RECT* prcView, RECT* prcHScroll, RECT* prcVScroll, RECT* prcSizeBox);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ioledocumentview-show
    HRESULT Show(BOOL fShow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ioledocumentview-uiactivate
    HRESULT UIActivate(BOOL fUIActivate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ioledocumentview-open
    HRESULT Open();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ioledocumentview-closeview
    HRESULT CloseView(uint dwReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ioledocumentview-saveviewstate
    HRESULT SaveViewState(IStream pstm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ioledocumentview-applyviewstate
    HRESULT ApplyViewState(IStream pstm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ioledocumentview-clone
    HRESULT Clone(IOleInPlaceSite pIPSiteNew, IOleDocumentView* ppViewNew);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nn-docobj-ienumoledocumentviews
@GUID("b722bcc8-4e68-101b-a2bc-00aa00404770")
interface IEnumOleDocumentViews : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ienumoledocumentviews-next
    HRESULT Next(uint cViews, IOleDocumentView* rgpView, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ienumoledocumentviews-skip
    HRESULT Skip(uint cViews);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ienumoledocumentviews-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-ienumoledocumentviews-clone
    HRESULT Clone(IEnumOleDocumentViews* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nn-docobj-icontinuecallback
@GUID("b722bcca-4e68-101b-a2bc-00aa00404770")
interface IContinueCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-icontinuecallback-fcontinue
    HRESULT FContinue();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-icontinuecallback-fcontinueprinting
    HRESULT FContinuePrinting(int nCntPrinted, int nCurPage, PWSTR pwszPrintStatus);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nn-docobj-iprint
@GUID("b722bcc9-4e68-101b-a2bc-00aa00404770")
interface IPrint : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-iprint-setinitialpagenum
    HRESULT SetInitialPageNum(int nFirstPage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-iprint-getpageinfo
    HRESULT GetPageInfo(int* pnFirstPage, int* pcPages);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-iprint-print
    HRESULT Print(uint grfFlags, DVTARGETDEVICE** pptd, PAGESET** ppPageSet, STGMEDIUM* pstgmOptions, 
                  IContinueCallback pcallback, int nFirstPage, int* pcPagesPrinted, int* pnLastPage);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nn-docobj-iolecommandtarget
@GUID("b722bccb-4e68-101b-a2bc-00aa00404770")
interface IOleCommandTarget : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-iolecommandtarget-querystatus
    HRESULT QueryStatus(const(GUID)* pguidCmdGroup, uint cCmds, OLECMD* prgCmds, OLECMDTEXT* pCmdText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/docobj/nf-docobj-iolecommandtarget-exec
    HRESULT Exec(const(GUID)* pguidCmdGroup, uint nCmdID, uint nCmdexecopt, VARIANT* pvaIn, VARIANT* pvaOut);
}

@GUID("41b68150-904c-4e17-a0ba-a438182e359d")
interface IZoomEvents : IUnknown
{
    HRESULT OnZoomPercentChanged(uint ulZoomPercent);
}

@GUID("d81f90a3-8156-44f7-ad28-5abb87003274")
interface IProtectFocus : IUnknown
{
    HRESULT AllowFocusChange(BOOL* pfAllow);
}

@GUID("73c105ee-9dff-4a07-b83c-7eff290c266e")
interface IProtectedModeMenuServices : IUnknown
{
    HRESULT CreateMenu(HMENU* phMenu);
    HRESULT LoadMenu(const(PWSTR) pszModuleName, const(PWSTR) pszMenuName, HMENU* phMenu);
    HRESULT LoadMenuID(const(PWSTR) pszModuleName, ushort wResourceID, HMENU* phMenu);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nn-oledlg-ioleuilinkcontainerw
interface IOleUILinkContainerW : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuilinkcontainerw-getnextlink
    uint    GetNextLink(uint dwLink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuilinkcontainerw-setlinkupdateoptions
    HRESULT SetLinkUpdateOptions(uint dwLink, uint dwUpdateOpt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuilinkcontainerw-getlinkupdateoptions
    HRESULT GetLinkUpdateOptions(uint dwLink, uint* lpdwUpdateOpt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuilinkcontainerw-setlinksource
    HRESULT SetLinkSource(uint dwLink, PWSTR lpszDisplayName, uint lenFileName, uint* pchEaten, 
                          BOOL fValidateSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuilinkcontainerw-getlinksource
    HRESULT GetLinkSource(uint dwLink, PWSTR* lplpszDisplayName, uint* lplenFileName, PWSTR* lplpszFullLinkType, 
                          PWSTR* lplpszShortLinkType, BOOL* lpfSourceAvailable, BOOL* lpfIsSelected);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuilinkcontainerw-openlinksource
    HRESULT OpenLinkSource(uint dwLink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuilinkcontainerw-updatelink
    HRESULT UpdateLink(uint dwLink, BOOL fErrorMessage, BOOL fReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuilinkcontainerw-cancellink
    HRESULT CancelLink(uint dwLink);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nn-oledlg-ioleuilinkcontainera
interface IOleUILinkContainerA : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuilinkcontainera-getnextlink
    uint    GetNextLink(uint dwLink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuilinkcontainera-setlinkupdateoptions
    HRESULT SetLinkUpdateOptions(uint dwLink, uint dwUpdateOpt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuilinkcontainera-getlinkupdateoptions
    HRESULT GetLinkUpdateOptions(uint dwLink, uint* lpdwUpdateOpt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuilinkcontainera-setlinksource
    HRESULT SetLinkSource(uint dwLink, PSTR lpszDisplayName, uint lenFileName, uint* pchEaten, 
                          BOOL fValidateSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuilinkcontainera-getlinksource
    HRESULT GetLinkSource(uint dwLink, PSTR* lplpszDisplayName, uint* lplenFileName, PSTR* lplpszFullLinkType, 
                          PSTR* lplpszShortLinkType, BOOL* lpfSourceAvailable, BOOL* lpfIsSelected);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuilinkcontainera-openlinksource
    HRESULT OpenLinkSource(uint dwLink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuilinkcontainera-updatelink
    HRESULT UpdateLink(uint dwLink, BOOL fErrorMessage, BOOL fReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuilinkcontainera-cancellink
    HRESULT CancelLink(uint dwLink);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nn-oledlg-ioleuiobjinfow
interface IOleUIObjInfoW : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuiobjinfow-getobjectinfo
    HRESULT GetObjectInfo(uint dwObject, uint* lpdwObjSize, PWSTR* lplpszLabel, PWSTR* lplpszType, 
                          PWSTR* lplpszShortType, PWSTR* lplpszLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuiobjinfow-getconvertinfo
    HRESULT GetConvertInfo(uint dwObject, GUID* lpClassID, ushort* lpwFormat, GUID* lpConvertDefaultClassID, 
                           GUID** lplpClsidExclude, uint* lpcClsidExclude);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuiobjinfow-convertobject
    HRESULT ConvertObject(uint dwObject, const(GUID)* clsidNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuiobjinfow-getviewinfo
    HRESULT GetViewInfo(uint dwObject, HGLOBAL* phMetaPict, uint* pdvAspect, int* pnCurrentScale);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuiobjinfow-setviewinfo
    HRESULT SetViewInfo(uint dwObject, HGLOBAL hMetaPict, uint dvAspect, int nCurrentScale, BOOL bRelativeToOrig);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nn-oledlg-ioleuiobjinfoa
interface IOleUIObjInfoA : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuiobjinfoa-getobjectinfo
    HRESULT GetObjectInfo(uint dwObject, uint* lpdwObjSize, PSTR* lplpszLabel, PSTR* lplpszType, 
                          PSTR* lplpszShortType, PSTR* lplpszLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuiobjinfoa-getconvertinfo
    HRESULT GetConvertInfo(uint dwObject, GUID* lpClassID, ushort* lpwFormat, GUID* lpConvertDefaultClassID, 
                           GUID** lplpClsidExclude, uint* lpcClsidExclude);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuiobjinfoa-convertobject
    HRESULT ConvertObject(uint dwObject, const(GUID)* clsidNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuiobjinfoa-getviewinfo
    HRESULT GetViewInfo(uint dwObject, HGLOBAL* phMetaPict, uint* pdvAspect, int* pnCurrentScale);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuiobjinfoa-setviewinfo
    HRESULT SetViewInfo(uint dwObject, HGLOBAL hMetaPict, uint dvAspect, int nCurrentScale, BOOL bRelativeToOrig);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nn-oledlg-ioleuilinkinfow
interface IOleUILinkInfoW : IOleUILinkContainerW
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuilinkinfow-getlastupdate
    HRESULT GetLastUpdate(uint dwLink, FILETIME* lpLastUpdate);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nn-oledlg-ioleuilinkinfoa
interface IOleUILinkInfoA : IOleUILinkContainerA
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/oledlg/nf-oledlg-ioleuilinkinfoa-getlastupdate
    HRESULT GetLastUpdate(uint dwLink, FILETIME* lpLastUpdate);
}

@GUID("a6ef9860-c720-11d0-9337-00a0c90dcaa9")
interface IDispatchEx : IDispatch
{
    HRESULT GetDispID(BSTR bstrName, uint grfdex, int* pid);
    HRESULT InvokeEx(int id, uint lcid, ushort wFlags, DISPPARAMS* pdp, VARIANT* pvarRes, EXCEPINFO* pei, 
                     IServiceProvider pspCaller);
    HRESULT DeleteMemberByName(BSTR bstrName, uint grfdex);
    HRESULT DeleteMemberByDispID(int id);
    HRESULT GetMemberProperties(int id, uint grfdexFetch, FDEX_PROP_FLAGS* pgrfdex);
    HRESULT GetMemberName(int id, BSTR* pbstrName);
    HRESULT GetNextDispID(uint grfdex, int id, int* pid);
    HRESULT GetNameSpaceParent(IUnknown* ppunk);
}

@GUID("a6ef9861-c720-11d0-9337-00a0c90dcaa9")
interface IDispError : IUnknown
{
    HRESULT QueryErrorInfo(GUID guidErrorType, IDispError* ppde);
    HRESULT GetNext(IDispError* ppde);
    HRESULT GetHresult(HRESULT* phr);
    HRESULT GetSource(BSTR* pbstrSource);
    HRESULT GetHelpInfo(BSTR* pbstrFileName, uint* pdwContext);
    HRESULT GetDescription(BSTR* pbstrDescription);
}

@GUID("a6ef9862-c720-11d0-9337-00a0c90dcaa9")
interface IVariantChangeType : IUnknown
{
    HRESULT ChangeType(VARIANT* pvarDst, VARIANT* pvarSrc, uint lcid, VARENUM vtNew);
}

@GUID("ca04b7e6-0d21-11d1-8cc5-00c04fc2b085")
interface IObjectIdentity : IUnknown
{
    HRESULT IsEqualObject(IUnknown punk);
}

@GUID("c5598e60-b307-11d1-b27d-006008c3fbfb")
interface ICanHandleException : IUnknown
{
    HRESULT CanHandleException(EXCEPINFO* pExcepInfo, VARIANT* pvar);
}

@GUID("10e2414a-ec59-49d2-bc51-5add2c36febc")
interface IProvideRuntimeContext : IUnknown
{
    HRESULT GetCurrentSourceContext(size_t* pdwContext, VARIANT_BOOL* pfExecutingGlobalCode);
}


// GUIDs


const GUID IID_IAdviseSinkEx               = GUIDOF!IAdviseSinkEx;
const GUID IID_ICanHandleException         = GUIDOF!ICanHandleException;
const GUID IID_IClassFactory2              = GUIDOF!IClassFactory2;
const GUID IID_IContinue                   = GUIDOF!IContinue;
const GUID IID_IContinueCallback           = GUIDOF!IContinueCallback;
const GUID IID_ICreateErrorInfo            = GUIDOF!ICreateErrorInfo;
const GUID IID_ICreateTypeInfo             = GUIDOF!ICreateTypeInfo;
const GUID IID_ICreateTypeInfo2            = GUIDOF!ICreateTypeInfo2;
const GUID IID_ICreateTypeLib              = GUIDOF!ICreateTypeLib;
const GUID IID_ICreateTypeLib2             = GUIDOF!ICreateTypeLib2;
const GUID IID_IDispError                  = GUIDOF!IDispError;
const GUID IID_IDispatchEx                 = GUIDOF!IDispatchEx;
const GUID IID_IDropSource                 = GUIDOF!IDropSource;
const GUID IID_IDropSourceNotify           = GUIDOF!IDropSourceNotify;
const GUID IID_IDropTarget                 = GUIDOF!IDropTarget;
const GUID IID_IEnterpriseDropTarget       = GUIDOF!IEnterpriseDropTarget;
const GUID IID_IEnumOLEVERB                = GUIDOF!IEnumOLEVERB;
const GUID IID_IEnumOleDocumentViews       = GUIDOF!IEnumOleDocumentViews;
const GUID IID_IEnumOleUndoUnits           = GUIDOF!IEnumOleUndoUnits;
const GUID IID_IEnumVARIANT                = GUIDOF!IEnumVARIANT;
const GUID IID_IFont                       = GUIDOF!IFont;
const GUID IID_IFontDisp                   = GUIDOF!IFontDisp;
const GUID IID_IFontEventsDisp             = GUIDOF!IFontEventsDisp;
const GUID IID_IGetOleObject               = GUIDOF!IGetOleObject;
const GUID IID_IGetVBAObject               = GUIDOF!IGetVBAObject;
const GUID IID_IObjectIdentity             = GUIDOF!IObjectIdentity;
const GUID IID_IObjectWithSite             = GUIDOF!IObjectWithSite;
const GUID IID_IOleAdviseHolder            = GUIDOF!IOleAdviseHolder;
const GUID IID_IOleCache                   = GUIDOF!IOleCache;
const GUID IID_IOleCache2                  = GUIDOF!IOleCache2;
const GUID IID_IOleCacheControl            = GUIDOF!IOleCacheControl;
const GUID IID_IOleClientSite              = GUIDOF!IOleClientSite;
const GUID IID_IOleCommandTarget           = GUIDOF!IOleCommandTarget;
const GUID IID_IOleContainer               = GUIDOF!IOleContainer;
const GUID IID_IOleControl                 = GUIDOF!IOleControl;
const GUID IID_IOleControlSite             = GUIDOF!IOleControlSite;
const GUID IID_IOleDocument                = GUIDOF!IOleDocument;
const GUID IID_IOleDocumentSite            = GUIDOF!IOleDocumentSite;
const GUID IID_IOleDocumentView            = GUIDOF!IOleDocumentView;
const GUID IID_IOleInPlaceActiveObject     = GUIDOF!IOleInPlaceActiveObject;
const GUID IID_IOleInPlaceFrame            = GUIDOF!IOleInPlaceFrame;
const GUID IID_IOleInPlaceObject           = GUIDOF!IOleInPlaceObject;
const GUID IID_IOleInPlaceObjectWindowless = GUIDOF!IOleInPlaceObjectWindowless;
const GUID IID_IOleInPlaceSite             = GUIDOF!IOleInPlaceSite;
const GUID IID_IOleInPlaceSiteEx           = GUIDOF!IOleInPlaceSiteEx;
const GUID IID_IOleInPlaceSiteWindowless   = GUIDOF!IOleInPlaceSiteWindowless;
const GUID IID_IOleInPlaceUIWindow         = GUIDOF!IOleInPlaceUIWindow;
const GUID IID_IOleItemContainer           = GUIDOF!IOleItemContainer;
const GUID IID_IOleLink                    = GUIDOF!IOleLink;
const GUID IID_IOleObject                  = GUIDOF!IOleObject;
const GUID IID_IOleParentUndoUnit          = GUIDOF!IOleParentUndoUnit;
const GUID IID_IOleUndoManager             = GUIDOF!IOleUndoManager;
const GUID IID_IOleUndoUnit                = GUIDOF!IOleUndoUnit;
const GUID IID_IOleWindow                  = GUIDOF!IOleWindow;
const GUID IID_IParseDisplayName           = GUIDOF!IParseDisplayName;
const GUID IID_IPerPropertyBrowsing        = GUIDOF!IPerPropertyBrowsing;
const GUID IID_IPersistPropertyBag         = GUIDOF!IPersistPropertyBag;
const GUID IID_IPersistPropertyBag2        = GUIDOF!IPersistPropertyBag2;
const GUID IID_IPicture                    = GUIDOF!IPicture;
const GUID IID_IPicture2                   = GUIDOF!IPicture2;
const GUID IID_IPictureDisp                = GUIDOF!IPictureDisp;
const GUID IID_IPointerInactive            = GUIDOF!IPointerInactive;
const GUID IID_IPrint                      = GUIDOF!IPrint;
const GUID IID_IPropertyNotifySink         = GUIDOF!IPropertyNotifySink;
const GUID IID_IPropertyPage               = GUIDOF!IPropertyPage;
const GUID IID_IPropertyPage2              = GUIDOF!IPropertyPage2;
const GUID IID_IPropertyPageSite           = GUIDOF!IPropertyPageSite;
const GUID IID_IProtectFocus               = GUIDOF!IProtectFocus;
const GUID IID_IProtectedModeMenuServices  = GUIDOF!IProtectedModeMenuServices;
const GUID IID_IProvideClassInfo           = GUIDOF!IProvideClassInfo;
const GUID IID_IProvideClassInfo2          = GUIDOF!IProvideClassInfo2;
const GUID IID_IProvideMultipleClassInfo   = GUIDOF!IProvideMultipleClassInfo;
const GUID IID_IProvideRuntimeContext      = GUIDOF!IProvideRuntimeContext;
const GUID IID_IQuickActivate              = GUIDOF!IQuickActivate;
const GUID IID_IRecordInfo                 = GUIDOF!IRecordInfo;
const GUID IID_ISimpleFrameSite            = GUIDOF!ISimpleFrameSite;
const GUID IID_ISpecifyPropertyPages       = GUIDOF!ISpecifyPropertyPages;
const GUID IID_ITypeChangeEvents           = GUIDOF!ITypeChangeEvents;
const GUID IID_ITypeFactory                = GUIDOF!ITypeFactory;
const GUID IID_ITypeMarshal                = GUIDOF!ITypeMarshal;
const GUID IID_IVBFormat                   = GUIDOF!IVBFormat;
const GUID IID_IVBGetControl               = GUIDOF!IVBGetControl;
const GUID IID_IVariantChangeType          = GUIDOF!IVariantChangeType;
const GUID IID_IViewObject                 = GUIDOF!IViewObject;
const GUID IID_IViewObject2                = GUIDOF!IViewObject2;
const GUID IID_IViewObjectEx               = GUIDOF!IViewObjectEx;
const GUID IID_IZoomEvents                 = GUIDOF!IZoomEvents;
