// Written in the D programming language.

module windows.win32.ui.controls.dialogs;

public import windows.core;
public import windows.win32.foundation : BOOL, COLORREF, HGLOBAL, HINSTANCE, HRESULT,
                                         HWND, LPARAM, LRESULT, POINT, PSTR,
                                         PWSTR, RECT, WPARAM;
public import windows.win32.graphics.gdi : DEVMODEA, HDC, LOGFONTA, LOGFONTW;
public import windows.win32.system.com : IUnknown;
public import windows.win32.ui.controls : HPROPSHEETPAGE, NMHDR;

extern(Windows) @nogc nothrow:


// Enums


alias COMMON_DLG_ERRORS = uint;
enum : uint
{
    CDERR_DIALOGFAILURE    = 0x0000ffffU,
    CDERR_GENERALCODES     = 0x00000000U,
    CDERR_STRUCTSIZE       = 0x00000001U,
    CDERR_INITIALIZATION   = 0x00000002U,
    CDERR_NOTEMPLATE       = 0x00000003U,
    CDERR_NOHINSTANCE      = 0x00000004U,
    CDERR_LOADSTRFAILURE   = 0x00000005U,
    CDERR_FINDRESFAILURE   = 0x00000006U,
    CDERR_LOADRESFAILURE   = 0x00000007U,
    CDERR_LOCKRESFAILURE   = 0x00000008U,
    CDERR_MEMALLOCFAILURE  = 0x00000009U,
    CDERR_MEMLOCKFAILURE   = 0x0000000aU,
    CDERR_NOHOOK           = 0x0000000bU,
    CDERR_REGISTERMSGFAIL  = 0x0000000cU,
    PDERR_PRINTERCODES     = 0x00001000U,
    PDERR_SETUPFAILURE     = 0x00001001U,
    PDERR_PARSEFAILURE     = 0x00001002U,
    PDERR_RETDEFFAILURE    = 0x00001003U,
    PDERR_LOADDRVFAILURE   = 0x00001004U,
    PDERR_GETDEVMODEFAIL   = 0x00001005U,
    PDERR_INITFAILURE      = 0x00001006U,
    PDERR_NODEVICES        = 0x00001007U,
    PDERR_NODEFAULTPRN     = 0x00001008U,
    PDERR_DNDMMISMATCH     = 0x00001009U,
    PDERR_CREATEICFAILURE  = 0x0000100aU,
    PDERR_PRINTERNOTFOUND  = 0x0000100bU,
    PDERR_DEFAULTDIFFERENT = 0x0000100cU,
    CFERR_CHOOSEFONTCODES  = 0x00002000U,
    CFERR_NOFONTS          = 0x00002001U,
    CFERR_MAXLESSTHANMIN   = 0x00002002U,
    FNERR_FILENAMECODES    = 0x00003000U,
    FNERR_SUBCLASSFAILURE  = 0x00003001U,
    FNERR_INVALIDFILENAME  = 0x00003002U,
    FNERR_BUFFERTOOSMALL   = 0x00003003U,
    FRERR_FINDREPLACECODES = 0x00004000U,
    FRERR_BUFFERLENGTHZERO = 0x00004001U,
    CCERR_CHOOSECOLORCODES = 0x00005000U,
}

alias CHOOSECOLOR_FLAGS = uint;
enum : uint
{
    CC_RGBINIT              = 0x00000001U,
    CC_FULLOPEN             = 0x00000002U,
    CC_PREVENTFULLOPEN      = 0x00000004U,
    CC_SHOWHELP             = 0x00000008U,
    CC_ENABLEHOOK           = 0x00000010U,
    CC_ENABLETEMPLATE       = 0x00000020U,
    CC_ENABLETEMPLATEHANDLE = 0x00000040U,
    CC_SOLIDCOLOR           = 0x00000080U,
    CC_ANYCOLOR             = 0x00000100U,
}

alias OPEN_FILENAME_FLAGS = uint;
enum : uint
{
    OFN_READONLY             = 0x00000001U,
    OFN_OVERWRITEPROMPT      = 0x00000002U,
    OFN_HIDEREADONLY         = 0x00000004U,
    OFN_NOCHANGEDIR          = 0x00000008U,
    OFN_SHOWHELP             = 0x00000010U,
    OFN_ENABLEHOOK           = 0x00000020U,
    OFN_ENABLETEMPLATE       = 0x00000040U,
    OFN_ENABLETEMPLATEHANDLE = 0x00000080U,
    OFN_NOVALIDATE           = 0x00000100U,
    OFN_ALLOWMULTISELECT     = 0x00000200U,
    OFN_EXTENSIONDIFFERENT   = 0x00000400U,
    OFN_PATHMUSTEXIST        = 0x00000800U,
    OFN_FILEMUSTEXIST        = 0x00001000U,
    OFN_CREATEPROMPT         = 0x00002000U,
    OFN_SHAREAWARE           = 0x00004000U,
    OFN_NOREADONLYRETURN     = 0x00008000U,
    OFN_NOTESTFILECREATE     = 0x00010000U,
    OFN_NONETWORKBUTTON      = 0x00020000U,
    OFN_NOLONGNAMES          = 0x00040000U,
    OFN_EXPLORER             = 0x00080000U,
    OFN_NODEREFERENCELINKS   = 0x00100000U,
    OFN_LONGNAMES            = 0x00200000U,
    OFN_ENABLEINCLUDENOTIFY  = 0x00400000U,
    OFN_ENABLESIZING         = 0x00800000U,
    OFN_DONTADDTORECENT      = 0x02000000U,
    OFN_FORCESHOWHIDDEN      = 0x10000000U,
}

alias OPEN_FILENAME_FLAGS_EX = uint;
enum : uint
{
    OFN_EX_NONE        = 0x00000000U,
    OFN_EX_NOPLACESBAR = 0x00000001U,
}

alias PAGESETUPDLG_FLAGS = uint;
enum : uint
{
    PSD_DEFAULTMINMARGINS             = 0x00000000U,
    PSD_DISABLEMARGINS                = 0x00000010U,
    PSD_DISABLEORIENTATION            = 0x00000100U,
    PSD_DISABLEPAGEPAINTING           = 0x00080000U,
    PSD_DISABLEPAPER                  = 0x00000200U,
    PSD_DISABLEPRINTER                = 0x00000020U,
    PSD_ENABLEPAGEPAINTHOOK           = 0x00040000U,
    PSD_ENABLEPAGESETUPHOOK           = 0x00002000U,
    PSD_ENABLEPAGESETUPTEMPLATE       = 0x00008000U,
    PSD_ENABLEPAGESETUPTEMPLATEHANDLE = 0x00020000U,
    PSD_INHUNDREDTHSOFMILLIMETERS     = 0x00000008U,
    PSD_INTHOUSANDTHSOFINCHES         = 0x00000004U,
    PSD_INWININIINTLMEASURE           = 0x00000000U,
    PSD_MARGINS                       = 0x00000002U,
    PSD_MINMARGINS                    = 0x00000001U,
    PSD_NONETWORKBUTTON               = 0x00200000U,
    PSD_NOWARNING                     = 0x00000080U,
    PSD_RETURNDEFAULT                 = 0x00000400U,
    PSD_SHOWHELP                      = 0x00000800U,
}

alias CHOOSEFONT_FLAGS = uint;
enum : uint
{
    CF_APPLY                = 0x00000200U,
    CF_ANSIONLY             = 0x00000400U,
    CF_BOTH                 = 0x00000003U,
    CF_EFFECTS              = 0x00000100U,
    CF_ENABLEHOOK           = 0x00000008U,
    CF_ENABLETEMPLATE       = 0x00000010U,
    CF_ENABLETEMPLATEHANDLE = 0x00000020U,
    CF_FIXEDPITCHONLY       = 0x00004000U,
    CF_FORCEFONTEXIST       = 0x00010000U,
    CF_INACTIVEFONTS        = 0x02000000U,
    CF_INITTOLOGFONTSTRUCT  = 0x00000040U,
    CF_LIMITSIZE            = 0x00002000U,
    CF_NOOEMFONTS           = 0x00000800U,
    CF_NOFACESEL            = 0x00080000U,
    CF_NOSCRIPTSEL          = 0x00800000U,
    CF_NOSIMULATIONS        = 0x00001000U,
    CF_NOSIZESEL            = 0x00200000U,
    CF_NOSTYLESEL           = 0x00100000U,
    CF_NOVECTORFONTS        = 0x00000800U,
    CF_NOVERTFONTS          = 0x01000000U,
    CF_PRINTERFONTS         = 0x00000002U,
    CF_SCALABLEONLY         = 0x00020000U,
    CF_SCREENFONTS          = 0x00000001U,
    CF_SCRIPTSONLY          = 0x00000400U,
    CF_SELECTSCRIPT         = 0x00400000U,
    CF_SHOWHELP             = 0x00000004U,
    CF_TTONLY               = 0x00040000U,
    CF_USESTYLE             = 0x00000080U,
    CF_WYSIWYG              = 0x00008000U,
}

alias FINDREPLACE_FLAGS = uint;
enum : uint
{
    FR_DOWN                 = 0x00000001U,
    FR_WHOLEWORD            = 0x00000002U,
    FR_MATCHCASE            = 0x00000004U,
    FR_FINDNEXT             = 0x00000008U,
    FR_REPLACE              = 0x00000010U,
    FR_REPLACEALL           = 0x00000020U,
    FR_DIALOGTERM           = 0x00000040U,
    FR_SHOWHELP             = 0x00000080U,
    FR_ENABLEHOOK           = 0x00000100U,
    FR_ENABLETEMPLATE       = 0x00000200U,
    FR_NOUPDOWN             = 0x00000400U,
    FR_NOMATCHCASE          = 0x00000800U,
    FR_NOWHOLEWORD          = 0x00001000U,
    FR_ENABLETEMPLATEHANDLE = 0x00002000U,
    FR_HIDEUPDOWN           = 0x00004000U,
    FR_HIDEMATCHCASE        = 0x00008000U,
    FR_HIDEWHOLEWORD        = 0x00010000U,
    FR_RAW                  = 0x00020000U,
    FR_SHOWWRAPAROUND       = 0x00040000U,
    FR_NOWRAPAROUND         = 0x00080000U,
    FR_WRAPAROUND           = 0x00100000U,
    FR_MATCHDIAC            = 0x20000000U,
    FR_MATCHKASHIDA         = 0x40000000U,
    FR_MATCHALEFHAMZA       = 0x80000000U,
}

alias PRINTDLGEX_FLAGS = uint;
enum : uint
{
    PD_ALLPAGES                   = 0x00000000U,
    PD_COLLATE                    = 0x00000010U,
    PD_CURRENTPAGE                = 0x00400000U,
    PD_DISABLEPRINTTOFILE         = 0x00080000U,
    PD_ENABLEPRINTTEMPLATE        = 0x00004000U,
    PD_ENABLEPRINTTEMPLATEHANDLE  = 0x00010000U,
    PD_EXCLUSIONFLAGS             = 0x01000000U,
    PD_HIDEPRINTTOFILE            = 0x00100000U,
    PD_NOCURRENTPAGE              = 0x00800000U,
    PD_NOPAGENUMS                 = 0x00000008U,
    PD_NOSELECTION                = 0x00000004U,
    PD_NOWARNING                  = 0x00000080U,
    PD_PAGENUMS                   = 0x00000002U,
    PD_PRINTTOFILE                = 0x00000020U,
    PD_RETURNDC                   = 0x00000100U,
    PD_RETURNDEFAULT              = 0x00000400U,
    PD_RETURNIC                   = 0x00000200U,
    PD_SELECTION                  = 0x00000001U,
    PD_USEDEVMODECOPIES           = 0x00040000U,
    PD_USEDEVMODECOPIESANDCOLLATE = 0x00040000U,
    PD_USELARGETEMPLATE           = 0x10000000U,
    PD_ENABLEPRINTHOOK            = 0x00001000U,
    PD_ENABLESETUPHOOK            = 0x00002000U,
    PD_ENABLESETUPTEMPLATE        = 0x00008000U,
    PD_ENABLESETUPTEMPLATEHANDLE  = 0x00020000U,
    PD_NONETWORKBUTTON            = 0x00200000U,
    PD_PRINTSETUP                 = 0x00000040U,
    PD_SHOWHELP                   = 0x00000800U,
}

alias CHOOSEFONT_FONT_TYPE = ushort;
enum : ushort
{
    BOLD_FONTTYPE      = cast(ushort) 0x0100,
    ITALIC_FONTTYPE    = cast(ushort) 0x0200,
    PRINTER_FONTTYPE   = cast(ushort) 0x4000,
    REGULAR_FONTTYPE   = cast(ushort) 0x0400,
    SCREEN_FONTTYPE    = cast(ushort) 0x2000,
    SIMULATED_FONTTYPE = cast(ushort) 0x8000,
}

// Constants


enum : uint
{
    OFN_SHAREFALLTHROUGH = 0x00000002U,
    OFN_SHARENOWARN      = 0x00000001U,
    OFN_SHAREWARN        = 0x00000000U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/cdn-initdone
enum uint CDN_INITDONE = 0xfffffda7U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/cdn-selchange
enum uint CDN_SELCHANGE = 0xfffffda6U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/cdn-folderchange
enum uint CDN_FOLDERCHANGE = 0xfffffda5U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/cdn-shareviolation
enum uint CDN_SHAREVIOLATION = 0xfffffda4U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/cdn-help
    CDN_HELP   = 0xfffffda3U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/cdn-fileok
    CDN_FILEOK = 0xfffffda2U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/cdn-typechange
enum uint CDN_TYPECHANGE = 0xfffffda1U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/cdn-includeitem
enum uint CDN_INCLUDEITEM = 0xfffffda0U;

enum : uint
{
    CDM_FIRST           = 0x00000464U,
    CDM_LAST            = 0x000004c8U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/cdm-getspec
    CDM_GETSPEC         = 0x00000464U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/cdm-getfilepath
    CDM_GETFILEPATH     = 0x00000465U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/cdm-getfolderpath
    CDM_GETFOLDERPATH   = 0x00000466U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/cdm-getfolderidlist
    CDM_GETFOLDERIDLIST = 0x00000467U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/cdm-setcontroltext
enum uint CDM_SETCONTROLTEXT = 0x00000468U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/cdm-hidecontrol
enum uint CDM_HIDECONTROL = 0x00000469U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/cdm-setdefext
enum uint CDM_SETDEFEXT = 0x0000046aU;

enum : uint
{
    FRM_FIRST                  = 0x00000464U,
    FRM_LAST                   = 0x000004c8U,
    FRM_SETOPERATIONRESULT     = 0x00000464U,
    FRM_SETOPERATIONRESULTTEXT = 0x00000465U,
}

enum uint PS_OPENTYPE_FONTTYPE = 0x00010000U;
enum uint TT_OPENTYPE_FONTTYPE = 0x00020000U;
enum uint TYPE1_FONTTYPE = 0x00040000U;
enum uint SYMBOL_FONTTYPE = 0x00080000U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/wm-choosefont-getlogfont
    WM_CHOOSEFONT_GETLOGFONT = 0x00000401U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/wm-choosefont-setlogfont
    WM_CHOOSEFONT_SETLOGFONT = 0x00000465U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/wm-choosefont-setflags
    WM_CHOOSEFONT_SETFLAGS   = 0x00000466U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/lbselchstring
// Native encoding: ansi
enum const(wchar)* LBSELCHSTRINGA = "commdlg_LBSelChangedNotify";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/sharevistring
// Native encoding: ansi
enum const(wchar)* SHAREVISTRINGA = "commdlg_ShareViolation";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/fileokstring
// Native encoding: ansi
enum const(wchar)* FILEOKSTRINGA = "commdlg_FileNameOK";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/colorokstring
// Native encoding: ansi
enum const(wchar)* COLOROKSTRINGA = "commdlg_ColorOK";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/setrgbstring
// Native encoding: ansi
enum const(wchar)* SETRGBSTRINGA = "commdlg_SetRGBColor";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/helpmsgstring
// Native encoding: ansi
enum const(wchar)* HELPMSGSTRINGA = "commdlg_help";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/findmsgstring
// Native encoding: ansi
enum const(wchar)* FINDMSGSTRINGA = "commdlg_FindReplace";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/lbselchstring
enum const(wchar)* LBSELCHSTRINGW = "commdlg_LBSelChangedNotify";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/sharevistring
enum const(wchar)* SHAREVISTRINGW = "commdlg_ShareViolation";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/fileokstring
enum const(wchar)* FILEOKSTRINGW = "commdlg_FileNameOK";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/colorokstring
enum const(wchar)* COLOROKSTRINGW = "commdlg_ColorOK";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/setrgbstring
enum const(wchar)* SETRGBSTRINGW = "commdlg_SetRGBColor";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/helpmsgstring
enum const(wchar)* HELPMSGSTRINGW = "commdlg_help";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/findmsgstring
enum const(wchar)* FINDMSGSTRINGW = "commdlg_FindReplace";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/lbselchstring
enum const(wchar)* LBSELCHSTRING = "commdlg_LBSelChangedNotify";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/sharevistring
enum const(wchar)* SHAREVISTRING = "commdlg_ShareViolation";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/fileokstring
enum const(wchar)* FILEOKSTRING = "commdlg_FileNameOK";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/colorokstring
enum const(wchar)* COLOROKSTRING = "commdlg_ColorOK";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/setrgbstring
enum const(wchar)* SETRGBSTRING = "commdlg_SetRGBColor";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/helpmsgstring
enum const(wchar)* HELPMSGSTRING = "commdlg_help";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/findmsgstring
enum const(wchar)* FINDMSGSTRING = "commdlg_FindReplace";
enum int CD_LBSELNOITEMS = 0xffffffff;

enum : uint
{
    CD_LBSELCHANGE = 0x00000000U,
    CD_LBSELSUB    = 0x00000001U,
    CD_LBSELADD    = 0x00000002U,
}

enum uint START_PAGE_GENERAL = 0xffffffffU;

enum : uint
{
    PD_RESULT_CANCEL = 0x00000000U,
    PD_RESULT_PRINT  = 0x00000001U,
    PD_RESULT_APPLY  = 0x00000002U,
}

enum uint DN_DEFAULTPRN = 0x00000001U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/wm-psd-fullpagerect
enum uint WM_PSD_FULLPAGERECT = 0x00000401U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/wm-psd-minmarginrect
enum uint WM_PSD_MINMARGINRECT = 0x00000402U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/wm-psd-marginrect
    WM_PSD_MARGINRECT    = 0x00000403U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/wm-psd-greektextrect
    WM_PSD_GREEKTEXTRECT = 0x00000404U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/wm-psd-envstamprect
enum uint WM_PSD_ENVSTAMPRECT = 0x00000405U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/dlgbox/wm-psd-yafullpagerect
enum uint WM_PSD_YAFULLPAGERECT = 0x00000406U;
enum uint DLG_COLOR = 0x0000000aU;
enum uint COLOR_HUESCROLL = 0x000002bcU;
enum uint COLOR_SATSCROLL = 0x000002bdU;
enum uint COLOR_LUMSCROLL = 0x000002beU;

enum : uint
{
    COLOR_HUE        = 0x000002bfU,
    COLOR_SAT        = 0x000002c0U,
    COLOR_LUM        = 0x000002c1U,
    COLOR_RED        = 0x000002c2U,
    COLOR_GREEN      = 0x000002c3U,
    COLOR_BLUE       = 0x000002c4U,
    COLOR_CURRENT    = 0x000002c5U,
    COLOR_RAINBOW    = 0x000002c6U,
    COLOR_SAVE       = 0x000002c7U,
    COLOR_ADD        = 0x000002c8U,
    COLOR_SOLID      = 0x000002c9U,
    COLOR_TUNE       = 0x000002caU,
    COLOR_SCHEMES    = 0x000002cbU,
    COLOR_ELEMENT    = 0x000002ccU,
    COLOR_SAMPLES    = 0x000002cdU,
    COLOR_PALETTE    = 0x000002ceU,
    COLOR_MIX        = 0x000002cfU,
    COLOR_BOX1       = 0x000002d0U,
    COLOR_CUSTOM1    = 0x000002d1U,
    COLOR_HUEACCEL   = 0x000002d3U,
    COLOR_SATACCEL   = 0x000002d4U,
    COLOR_LUMACCEL   = 0x000002d5U,
    COLOR_REDACCEL   = 0x000002d6U,
    COLOR_GREENACCEL = 0x000002d7U,
}

enum uint COLOR_BLUEACCEL = 0x000002d8U;

enum : uint
{
    COLOR_SOLID_LEFT  = 0x000002daU,
    COLOR_SOLID_RIGHT = 0x000002dbU,
}

enum uint NUM_BASIC_COLORS = 0x00000030U;
enum uint NUM_CUSTOM_COLORS = 0x00000010U;

// Callbacks

alias LPOFNHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPCCHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPFRHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPCFHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPPRINTHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPSETUPHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPPAGEPAINTHOOK = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPPAGESETUPHOOK = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);

// Structs


version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-openfilename_nt4a
    struct OPENFILENAME_NT4A
    {
        uint          lStructSize;
        HWND          hwndOwner;
        HINSTANCE     hInstance;
        const(PSTR)   lpstrFilter;
        PSTR          lpstrCustomFilter;
        uint          nMaxCustFilter;
        uint          nFilterIndex;
        PSTR          lpstrFile;
        uint          nMaxFile;
        PSTR          lpstrFileTitle;
        uint          nMaxFileTitle;
        const(PSTR)   lpstrInitialDir;
        const(PSTR)   lpstrTitle;
        uint          Flags;
        ushort        nFileOffset;
        ushort        nFileExtension;
        const(PSTR)   lpstrDefExt;
        LPARAM        lCustData;
        LPOFNHOOKPROC lpfnHook;
        const(PSTR)   lpTemplateName;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-openfilename_nt4a
    struct OPENFILENAME_NT4A
    {
        uint          lStructSize;
        HWND          hwndOwner;
        HINSTANCE     hInstance;
        const(PSTR)   lpstrFilter;
        PSTR          lpstrCustomFilter;
        uint          nMaxCustFilter;
        uint          nFilterIndex;
        PSTR          lpstrFile;
        uint          nMaxFile;
        PSTR          lpstrFileTitle;
        uint          nMaxFileTitle;
        const(PSTR)   lpstrInitialDir;
        const(PSTR)   lpstrTitle;
        uint          Flags;
        ushort        nFileOffset;
        ushort        nFileExtension;
        const(PSTR)   lpstrDefExt;
        LPARAM        lCustData;
        LPOFNHOOKPROC lpfnHook;
        const(PSTR)   lpTemplateName;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-openfilename_nt4w
    struct OPENFILENAME_NT4W
    {
        uint          lStructSize;
        HWND          hwndOwner;
        HINSTANCE     hInstance;
        const(PWSTR)  lpstrFilter;
        PWSTR         lpstrCustomFilter;
        uint          nMaxCustFilter;
        uint          nFilterIndex;
        PWSTR         lpstrFile;
        uint          nMaxFile;
        PWSTR         lpstrFileTitle;
        uint          nMaxFileTitle;
        const(PWSTR)  lpstrInitialDir;
        const(PWSTR)  lpstrTitle;
        uint          Flags;
        ushort        nFileOffset;
        ushort        nFileExtension;
        const(PWSTR)  lpstrDefExt;
        LPARAM        lCustData;
        LPOFNHOOKPROC lpfnHook;
        const(PWSTR)  lpTemplateName;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-openfilename_nt4w
    struct OPENFILENAME_NT4W
    {
        uint          lStructSize;
        HWND          hwndOwner;
        HINSTANCE     hInstance;
        const(PWSTR)  lpstrFilter;
        PWSTR         lpstrCustomFilter;
        uint          nMaxCustFilter;
        uint          nFilterIndex;
        PWSTR         lpstrFile;
        uint          nMaxFile;
        PWSTR         lpstrFileTitle;
        uint          nMaxFileTitle;
        const(PWSTR)  lpstrInitialDir;
        const(PWSTR)  lpstrTitle;
        uint          Flags;
        ushort        nFileOffset;
        ushort        nFileExtension;
        const(PWSTR)  lpstrDefExt;
        LPARAM        lCustData;
        LPOFNHOOKPROC lpfnHook;
        const(PWSTR)  lpTemplateName;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-openfilenamea
    struct OPENFILENAMEA
    {
        uint                lStructSize;
        HWND                hwndOwner;
        HINSTANCE           hInstance;
        const(PSTR)         lpstrFilter;
        PSTR                lpstrCustomFilter;
        uint                nMaxCustFilter;
        uint                nFilterIndex;
        PSTR                lpstrFile;
        uint                nMaxFile;
        PSTR                lpstrFileTitle;
        uint                nMaxFileTitle;
        const(PSTR)         lpstrInitialDir;
        const(PSTR)         lpstrTitle;
        OPEN_FILENAME_FLAGS Flags;
        ushort              nFileOffset;
        ushort              nFileExtension;
        const(PSTR)         lpstrDefExt;
        LPARAM              lCustData;
        LPOFNHOOKPROC       lpfnHook;
        const(PSTR)         lpTemplateName;
        void*               pvReserved;
        uint                dwReserved;
        OPEN_FILENAME_FLAGS_EX FlagsEx;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-openfilenamea
    struct OPENFILENAMEA
    {
        uint                lStructSize;
        HWND                hwndOwner;
        HINSTANCE           hInstance;
        const(PSTR)         lpstrFilter;
        PSTR                lpstrCustomFilter;
        uint                nMaxCustFilter;
        uint                nFilterIndex;
        PSTR                lpstrFile;
        uint                nMaxFile;
        PSTR                lpstrFileTitle;
        uint                nMaxFileTitle;
        const(PSTR)         lpstrInitialDir;
        const(PSTR)         lpstrTitle;
        OPEN_FILENAME_FLAGS Flags;
        ushort              nFileOffset;
        ushort              nFileExtension;
        const(PSTR)         lpstrDefExt;
        LPARAM              lCustData;
        LPOFNHOOKPROC       lpfnHook;
        const(PSTR)         lpTemplateName;
        void*               pvReserved;
        uint                dwReserved;
        OPEN_FILENAME_FLAGS_EX FlagsEx;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-openfilenamew
    struct OPENFILENAMEW
    {
        uint                lStructSize;
        HWND                hwndOwner;
        HINSTANCE           hInstance;
        const(PWSTR)        lpstrFilter;
        PWSTR               lpstrCustomFilter;
        uint                nMaxCustFilter;
        uint                nFilterIndex;
        PWSTR               lpstrFile;
        uint                nMaxFile;
        PWSTR               lpstrFileTitle;
        uint                nMaxFileTitle;
        const(PWSTR)        lpstrInitialDir;
        const(PWSTR)        lpstrTitle;
        OPEN_FILENAME_FLAGS Flags;
        ushort              nFileOffset;
        ushort              nFileExtension;
        const(PWSTR)        lpstrDefExt;
        LPARAM              lCustData;
        LPOFNHOOKPROC       lpfnHook;
        const(PWSTR)        lpTemplateName;
        void*               pvReserved;
        uint                dwReserved;
        OPEN_FILENAME_FLAGS_EX FlagsEx;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-openfilenamew
    struct OPENFILENAMEW
    {
        uint                lStructSize;
        HWND                hwndOwner;
        HINSTANCE           hInstance;
        const(PWSTR)        lpstrFilter;
        PWSTR               lpstrCustomFilter;
        uint                nMaxCustFilter;
        uint                nFilterIndex;
        PWSTR               lpstrFile;
        uint                nMaxFile;
        PWSTR               lpstrFileTitle;
        uint                nMaxFileTitle;
        const(PWSTR)        lpstrInitialDir;
        const(PWSTR)        lpstrTitle;
        OPEN_FILENAME_FLAGS Flags;
        ushort              nFileOffset;
        ushort              nFileExtension;
        const(PWSTR)        lpstrDefExt;
        LPARAM              lCustData;
        LPOFNHOOKPROC       lpfnHook;
        const(PWSTR)        lpTemplateName;
        void*               pvReserved;
        uint                dwReserved;
        OPEN_FILENAME_FLAGS_EX FlagsEx;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-ofnotifya
    struct OFNOTIFYA
    {
        NMHDR          hdr;
        OPENFILENAMEA* lpOFN;
        PSTR           pszFile;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-ofnotifya
    struct OFNOTIFYA
    {
        NMHDR          hdr;
        OPENFILENAMEA* lpOFN;
        PSTR           pszFile;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-ofnotifyw
    struct OFNOTIFYW
    {
        NMHDR          hdr;
        OPENFILENAMEW* lpOFN;
        PWSTR          pszFile;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-ofnotifyw
    struct OFNOTIFYW
    {
        NMHDR          hdr;
        OPENFILENAMEW* lpOFN;
        PWSTR          pszFile;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-ofnotifyexa
    struct OFNOTIFYEXA
    {
        NMHDR          hdr;
        OPENFILENAMEA* lpOFN;
        void*          psf;
        void*          pidl;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-ofnotifyexa
    struct OFNOTIFYEXA
    {
        NMHDR          hdr;
        OPENFILENAMEA* lpOFN;
        void*          psf;
        void*          pidl;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-ofnotifyexw
    struct OFNOTIFYEXW
    {
        NMHDR          hdr;
        OPENFILENAMEW* lpOFN;
        void*          psf;
        void*          pidl;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-ofnotifyexw
    struct OFNOTIFYEXW
    {
        NMHDR          hdr;
        OPENFILENAMEW* lpOFN;
        void*          psf;
        void*          pidl;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-choosecolora
    struct CHOOSECOLORA
    {
        uint              lStructSize;
        HWND              hwndOwner;
        HWND              hInstance;
        COLORREF          rgbResult;
        COLORREF*         lpCustColors;
        CHOOSECOLOR_FLAGS Flags;
        LPARAM            lCustData;
        LPCCHOOKPROC      lpfnHook;
        const(PSTR)       lpTemplateName;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-choosecolora
    struct CHOOSECOLORA
    {
        uint              lStructSize;
        HWND              hwndOwner;
        HWND              hInstance;
        COLORREF          rgbResult;
        COLORREF*         lpCustColors;
        CHOOSECOLOR_FLAGS Flags;
        LPARAM            lCustData;
        LPCCHOOKPROC      lpfnHook;
        const(PSTR)       lpTemplateName;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-choosecolorw
    struct CHOOSECOLORW
    {
        uint              lStructSize;
        HWND              hwndOwner;
        HWND              hInstance;
        COLORREF          rgbResult;
        COLORREF*         lpCustColors;
        CHOOSECOLOR_FLAGS Flags;
        LPARAM            lCustData;
        LPCCHOOKPROC      lpfnHook;
        const(PWSTR)      lpTemplateName;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-choosecolorw
    struct CHOOSECOLORW
    {
        uint              lStructSize;
        HWND              hwndOwner;
        HWND              hInstance;
        COLORREF          rgbResult;
        COLORREF*         lpCustColors;
        CHOOSECOLOR_FLAGS Flags;
        LPARAM            lCustData;
        LPCCHOOKPROC      lpfnHook;
        const(PWSTR)      lpTemplateName;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-findreplacea
    struct FINDREPLACEA
    {
        uint              lStructSize;
        HWND              hwndOwner;
        HINSTANCE         hInstance;
        FINDREPLACE_FLAGS Flags;
        PSTR              lpstrFindWhat;
        PSTR              lpstrReplaceWith;
        ushort            wFindWhatLen;
        ushort            wReplaceWithLen;
        LPARAM            lCustData;
        LPFRHOOKPROC      lpfnHook;
        const(PSTR)       lpTemplateName;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-findreplacea
    struct FINDREPLACEA
    {
        uint              lStructSize;
        HWND              hwndOwner;
        HINSTANCE         hInstance;
        FINDREPLACE_FLAGS Flags;
        PSTR              lpstrFindWhat;
        PSTR              lpstrReplaceWith;
        ushort            wFindWhatLen;
        ushort            wReplaceWithLen;
        LPARAM            lCustData;
        LPFRHOOKPROC      lpfnHook;
        const(PSTR)       lpTemplateName;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-findreplacew
    struct FINDREPLACEW
    {
        uint              lStructSize;
        HWND              hwndOwner;
        HINSTANCE         hInstance;
        FINDREPLACE_FLAGS Flags;
        PWSTR             lpstrFindWhat;
        PWSTR             lpstrReplaceWith;
        ushort            wFindWhatLen;
        ushort            wReplaceWithLen;
        LPARAM            lCustData;
        LPFRHOOKPROC      lpfnHook;
        const(PWSTR)      lpTemplateName;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-findreplacew
    struct FINDREPLACEW
    {
        uint              lStructSize;
        HWND              hwndOwner;
        HINSTANCE         hInstance;
        FINDREPLACE_FLAGS Flags;
        PWSTR             lpstrFindWhat;
        PWSTR             lpstrReplaceWith;
        ushort            wFindWhatLen;
        ushort            wReplaceWithLen;
        LPARAM            lCustData;
        LPFRHOOKPROC      lpfnHook;
        const(PWSTR)      lpTemplateName;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-choosefonta
    struct CHOOSEFONTA
    {
        uint                 lStructSize;
        HWND                 hwndOwner;
        HDC                  hDC;
        LOGFONTA*            lpLogFont;
        int                  iPointSize;
        CHOOSEFONT_FLAGS     Flags;
        COLORREF             rgbColors;
        LPARAM               lCustData;
        LPCFHOOKPROC         lpfnHook;
        const(PSTR)          lpTemplateName;
        HINSTANCE            hInstance;
        PSTR                 lpszStyle;
        CHOOSEFONT_FONT_TYPE nFontType;
        ushort               ___MISSING_ALIGNMENT__;
        int                  nSizeMin;
        int                  nSizeMax;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-choosefonta
    struct CHOOSEFONTA
    {
        uint                 lStructSize;
        HWND                 hwndOwner;
        HDC                  hDC;
        LOGFONTA*            lpLogFont;
        int                  iPointSize;
        CHOOSEFONT_FLAGS     Flags;
        COLORREF             rgbColors;
        LPARAM               lCustData;
        LPCFHOOKPROC         lpfnHook;
        const(PSTR)          lpTemplateName;
        HINSTANCE            hInstance;
        PSTR                 lpszStyle;
        CHOOSEFONT_FONT_TYPE nFontType;
        ushort               ___MISSING_ALIGNMENT__;
        int                  nSizeMin;
        int                  nSizeMax;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-choosefontw
    struct CHOOSEFONTW
    {
        uint                 lStructSize;
        HWND                 hwndOwner;
        HDC                  hDC;
        LOGFONTW*            lpLogFont;
        int                  iPointSize;
        CHOOSEFONT_FLAGS     Flags;
        COLORREF             rgbColors;
        LPARAM               lCustData;
        LPCFHOOKPROC         lpfnHook;
        const(PWSTR)         lpTemplateName;
        HINSTANCE            hInstance;
        PWSTR                lpszStyle;
        CHOOSEFONT_FONT_TYPE nFontType;
        ushort               ___MISSING_ALIGNMENT__;
        int                  nSizeMin;
        int                  nSizeMax;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-choosefontw
    struct CHOOSEFONTW
    {
        uint                 lStructSize;
        HWND                 hwndOwner;
        HDC                  hDC;
        LOGFONTW*            lpLogFont;
        int                  iPointSize;
        CHOOSEFONT_FLAGS     Flags;
        COLORREF             rgbColors;
        LPARAM               lCustData;
        LPCFHOOKPROC         lpfnHook;
        const(PWSTR)         lpTemplateName;
        HINSTANCE            hInstance;
        PWSTR                lpszStyle;
        CHOOSEFONT_FONT_TYPE nFontType;
        ushort               ___MISSING_ALIGNMENT__;
        int                  nSizeMin;
        int                  nSizeMax;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printdlga
    struct PRINTDLGA
    {
        uint             lStructSize;
        HWND             hwndOwner;
        HGLOBAL          hDevMode;
        HGLOBAL          hDevNames;
        HDC              hDC;
        PRINTDLGEX_FLAGS Flags;
        ushort           nFromPage;
        ushort           nToPage;
        ushort           nMinPage;
        ushort           nMaxPage;
        ushort           nCopies;
        HINSTANCE        hInstance;
        LPARAM           lCustData;
        LPPRINTHOOKPROC  lpfnPrintHook;
        LPSETUPHOOKPROC  lpfnSetupHook;
        const(PSTR)      lpPrintTemplateName;
        const(PSTR)      lpSetupTemplateName;
        HGLOBAL          hPrintTemplate;
        HGLOBAL          hSetupTemplate;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printdlga
    struct PRINTDLGA
    {
        uint             lStructSize;
        HWND             hwndOwner;
        HGLOBAL          hDevMode;
        HGLOBAL          hDevNames;
        HDC              hDC;
        PRINTDLGEX_FLAGS Flags;
        ushort           nFromPage;
        ushort           nToPage;
        ushort           nMinPage;
        ushort           nMaxPage;
        ushort           nCopies;
        HINSTANCE        hInstance;
        LPARAM           lCustData;
        LPPRINTHOOKPROC  lpfnPrintHook;
        LPSETUPHOOKPROC  lpfnSetupHook;
        const(PSTR)      lpPrintTemplateName;
        const(PSTR)      lpSetupTemplateName;
        HGLOBAL          hPrintTemplate;
        HGLOBAL          hSetupTemplate;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printdlgw
    struct PRINTDLGW
    {
        uint             lStructSize;
        HWND             hwndOwner;
        HGLOBAL          hDevMode;
        HGLOBAL          hDevNames;
        HDC              hDC;
        PRINTDLGEX_FLAGS Flags;
        ushort           nFromPage;
        ushort           nToPage;
        ushort           nMinPage;
        ushort           nMaxPage;
        ushort           nCopies;
        HINSTANCE        hInstance;
        LPARAM           lCustData;
        LPPRINTHOOKPROC  lpfnPrintHook;
        LPSETUPHOOKPROC  lpfnSetupHook;
        const(PWSTR)     lpPrintTemplateName;
        const(PWSTR)     lpSetupTemplateName;
        HGLOBAL          hPrintTemplate;
        HGLOBAL          hSetupTemplate;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printdlgw
    struct PRINTDLGW
    {
        uint             lStructSize;
        HWND             hwndOwner;
        HGLOBAL          hDevMode;
        HGLOBAL          hDevNames;
        HDC              hDC;
        PRINTDLGEX_FLAGS Flags;
        ushort           nFromPage;
        ushort           nToPage;
        ushort           nMinPage;
        ushort           nMaxPage;
        ushort           nCopies;
        HINSTANCE        hInstance;
        LPARAM           lCustData;
        LPPRINTHOOKPROC  lpfnPrintHook;
        LPSETUPHOOKPROC  lpfnSetupHook;
        const(PWSTR)     lpPrintTemplateName;
        const(PWSTR)     lpSetupTemplateName;
        HGLOBAL          hPrintTemplate;
        HGLOBAL          hSetupTemplate;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printpagerange
    struct PRINTPAGERANGE
    {
        uint nFromPage;
        uint nToPage;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printpagerange
    struct PRINTPAGERANGE
    {
        uint nFromPage;
        uint nToPage;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printdlgexa
    struct PRINTDLGEXA
    {
        uint             lStructSize;
        HWND             hwndOwner;
        HGLOBAL          hDevMode;
        HGLOBAL          hDevNames;
        HDC              hDC;
        PRINTDLGEX_FLAGS Flags;
        uint             Flags2;
        uint             ExclusionFlags;
        uint             nPageRanges;
        uint             nMaxPageRanges;
        PRINTPAGERANGE*  lpPageRanges;
        uint             nMinPage;
        uint             nMaxPage;
        uint             nCopies;
        HINSTANCE        hInstance;
        const(PSTR)      lpPrintTemplateName;
        IUnknown         lpCallback;
        uint             nPropertyPages;
        HPROPSHEETPAGE*  lphPropertyPages;
        uint             nStartPage;
        uint             dwResultAction;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printdlgexa
    struct PRINTDLGEXA
    {
        uint             lStructSize;
        HWND             hwndOwner;
        HGLOBAL          hDevMode;
        HGLOBAL          hDevNames;
        HDC              hDC;
        PRINTDLGEX_FLAGS Flags;
        uint             Flags2;
        uint             ExclusionFlags;
        uint             nPageRanges;
        uint             nMaxPageRanges;
        PRINTPAGERANGE*  lpPageRanges;
        uint             nMinPage;
        uint             nMaxPage;
        uint             nCopies;
        HINSTANCE        hInstance;
        const(PSTR)      lpPrintTemplateName;
        IUnknown         lpCallback;
        uint             nPropertyPages;
        HPROPSHEETPAGE*  lphPropertyPages;
        uint             nStartPage;
        uint             dwResultAction;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printdlgexw
    struct PRINTDLGEXW
    {
        uint             lStructSize;
        HWND             hwndOwner;
        HGLOBAL          hDevMode;
        HGLOBAL          hDevNames;
        HDC              hDC;
        PRINTDLGEX_FLAGS Flags;
        uint             Flags2;
        uint             ExclusionFlags;
        uint             nPageRanges;
        uint             nMaxPageRanges;
        PRINTPAGERANGE*  lpPageRanges;
        uint             nMinPage;
        uint             nMaxPage;
        uint             nCopies;
        HINSTANCE        hInstance;
        const(PWSTR)     lpPrintTemplateName;
        IUnknown         lpCallback;
        uint             nPropertyPages;
        HPROPSHEETPAGE*  lphPropertyPages;
        uint             nStartPage;
        uint             dwResultAction;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printdlgexw
    struct PRINTDLGEXW
    {
        uint             lStructSize;
        HWND             hwndOwner;
        HGLOBAL          hDevMode;
        HGLOBAL          hDevNames;
        HDC              hDC;
        PRINTDLGEX_FLAGS Flags;
        uint             Flags2;
        uint             ExclusionFlags;
        uint             nPageRanges;
        uint             nMaxPageRanges;
        PRINTPAGERANGE*  lpPageRanges;
        uint             nMinPage;
        uint             nMaxPage;
        uint             nCopies;
        HINSTANCE        hInstance;
        const(PWSTR)     lpPrintTemplateName;
        IUnknown         lpCallback;
        uint             nPropertyPages;
        HPROPSHEETPAGE*  lphPropertyPages;
        uint             nStartPage;
        uint             dwResultAction;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-devnames
    struct DEVNAMES
    {
        ushort wDriverOffset;
        ushort wDeviceOffset;
        ushort wOutputOffset;
        ushort wDefault;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-devnames
    struct DEVNAMES
    {
        ushort wDriverOffset;
        ushort wDeviceOffset;
        ushort wOutputOffset;
        ushort wDefault;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-pagesetupdlga
    struct PAGESETUPDLGA
    {
        uint               lStructSize;
        HWND               hwndOwner;
        HGLOBAL            hDevMode;
        HGLOBAL            hDevNames;
        PAGESETUPDLG_FLAGS Flags;
        POINT              ptPaperSize;
        RECT               rtMinMargin;
        RECT               rtMargin;
        HINSTANCE          hInstance;
        LPARAM             lCustData;
        LPPAGESETUPHOOK    lpfnPageSetupHook;
        LPPAGEPAINTHOOK    lpfnPagePaintHook;
        const(PSTR)        lpPageSetupTemplateName;
        HGLOBAL            hPageSetupTemplate;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-pagesetupdlga
    struct PAGESETUPDLGA
    {
        uint               lStructSize;
        HWND               hwndOwner;
        HGLOBAL            hDevMode;
        HGLOBAL            hDevNames;
        PAGESETUPDLG_FLAGS Flags;
        POINT              ptPaperSize;
        RECT               rtMinMargin;
        RECT               rtMargin;
        HINSTANCE          hInstance;
        LPARAM             lCustData;
        LPPAGESETUPHOOK    lpfnPageSetupHook;
        LPPAGEPAINTHOOK    lpfnPagePaintHook;
        const(PSTR)        lpPageSetupTemplateName;
        HGLOBAL            hPageSetupTemplate;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-pagesetupdlgw
    struct PAGESETUPDLGW
    {
        uint               lStructSize;
        HWND               hwndOwner;
        HGLOBAL            hDevMode;
        HGLOBAL            hDevNames;
        PAGESETUPDLG_FLAGS Flags;
        POINT              ptPaperSize;
        RECT               rtMinMargin;
        RECT               rtMargin;
        HINSTANCE          hInstance;
        LPARAM             lCustData;
        LPPAGESETUPHOOK    lpfnPageSetupHook;
        LPPAGEPAINTHOOK    lpfnPagePaintHook;
        const(PWSTR)       lpPageSetupTemplateName;
        HGLOBAL            hPageSetupTemplate;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-pagesetupdlgw
    struct PAGESETUPDLGW
    {
        uint               lStructSize;
        HWND               hwndOwner;
        HGLOBAL            hDevMode;
        HGLOBAL            hDevNames;
        PAGESETUPDLG_FLAGS Flags;
        POINT              ptPaperSize;
        RECT               rtMinMargin;
        RECT               rtMargin;
        HINSTANCE          hInstance;
        LPARAM             lCustData;
        LPPAGESETUPHOOK    lpfnPageSetupHook;
        LPPAGEPAINTHOOK    lpfnPagePaintHook;
        const(PWSTR)       lpPageSetupTemplateName;
        HGLOBAL            hPageSetupTemplate;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-openfilename_nt4a
    struct OPENFILENAME_NT4A
    {
    align (1):
        uint          lStructSize;
        HWND          hwndOwner;
        HINSTANCE     hInstance;
        const(PSTR)   lpstrFilter;
        PSTR          lpstrCustomFilter;
        uint          nMaxCustFilter;
        uint          nFilterIndex;
        PSTR          lpstrFile;
        uint          nMaxFile;
        PSTR          lpstrFileTitle;
        uint          nMaxFileTitle;
        const(PSTR)   lpstrInitialDir;
        const(PSTR)   lpstrTitle;
        uint          Flags;
        ushort        nFileOffset;
        ushort        nFileExtension;
        const(PSTR)   lpstrDefExt;
        LPARAM        lCustData;
        LPOFNHOOKPROC lpfnHook;
        const(PSTR)   lpTemplateName;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-openfilename_nt4w
    struct OPENFILENAME_NT4W
    {
    align (1):
        uint          lStructSize;
        HWND          hwndOwner;
        HINSTANCE     hInstance;
        const(PWSTR)  lpstrFilter;
        PWSTR         lpstrCustomFilter;
        uint          nMaxCustFilter;
        uint          nFilterIndex;
        PWSTR         lpstrFile;
        uint          nMaxFile;
        PWSTR         lpstrFileTitle;
        uint          nMaxFileTitle;
        const(PWSTR)  lpstrInitialDir;
        const(PWSTR)  lpstrTitle;
        uint          Flags;
        ushort        nFileOffset;
        ushort        nFileExtension;
        const(PWSTR)  lpstrDefExt;
        LPARAM        lCustData;
        LPOFNHOOKPROC lpfnHook;
        const(PWSTR)  lpTemplateName;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-openfilenamea
    struct OPENFILENAMEA
    {
    align (1):
        uint                lStructSize;
        HWND                hwndOwner;
        HINSTANCE           hInstance;
        const(PSTR)         lpstrFilter;
        PSTR                lpstrCustomFilter;
        uint                nMaxCustFilter;
        uint                nFilterIndex;
        PSTR                lpstrFile;
        uint                nMaxFile;
        PSTR                lpstrFileTitle;
        uint                nMaxFileTitle;
        const(PSTR)         lpstrInitialDir;
        const(PSTR)         lpstrTitle;
        OPEN_FILENAME_FLAGS Flags;
        ushort              nFileOffset;
        ushort              nFileExtension;
        const(PSTR)         lpstrDefExt;
        LPARAM              lCustData;
        LPOFNHOOKPROC       lpfnHook;
        const(PSTR)         lpTemplateName;
        void*               pvReserved;
        uint                dwReserved;
        OPEN_FILENAME_FLAGS_EX FlagsEx;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-openfilenamew
    struct OPENFILENAMEW
    {
    align (1):
        uint                lStructSize;
        HWND                hwndOwner;
        HINSTANCE           hInstance;
        const(PWSTR)        lpstrFilter;
        PWSTR               lpstrCustomFilter;
        uint                nMaxCustFilter;
        uint                nFilterIndex;
        PWSTR               lpstrFile;
        uint                nMaxFile;
        PWSTR               lpstrFileTitle;
        uint                nMaxFileTitle;
        const(PWSTR)        lpstrInitialDir;
        const(PWSTR)        lpstrTitle;
        OPEN_FILENAME_FLAGS Flags;
        ushort              nFileOffset;
        ushort              nFileExtension;
        const(PWSTR)        lpstrDefExt;
        LPARAM              lCustData;
        LPOFNHOOKPROC       lpfnHook;
        const(PWSTR)        lpTemplateName;
        void*               pvReserved;
        uint                dwReserved;
        OPEN_FILENAME_FLAGS_EX FlagsEx;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-ofnotifya
    struct OFNOTIFYA
    {
    align (1):
        NMHDR          hdr;
        OPENFILENAMEA* lpOFN;
        PSTR           pszFile;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-ofnotifyw
    struct OFNOTIFYW
    {
    align (1):
        NMHDR          hdr;
        OPENFILENAMEW* lpOFN;
        PWSTR          pszFile;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-ofnotifyexa
    struct OFNOTIFYEXA
    {
    align (1):
        NMHDR          hdr;
        OPENFILENAMEA* lpOFN;
        void*          psf;
        void*          pidl;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-ofnotifyexw
    struct OFNOTIFYEXW
    {
    align (1):
        NMHDR          hdr;
        OPENFILENAMEW* lpOFN;
        void*          psf;
        void*          pidl;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-choosecolora
    struct CHOOSECOLORA
    {
    align (1):
        uint              lStructSize;
        HWND              hwndOwner;
        HWND              hInstance;
        COLORREF          rgbResult;
        COLORREF*         lpCustColors;
        CHOOSECOLOR_FLAGS Flags;
        LPARAM            lCustData;
        LPCCHOOKPROC      lpfnHook;
        const(PSTR)       lpTemplateName;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-choosecolorw
    struct CHOOSECOLORW
    {
    align (1):
        uint              lStructSize;
        HWND              hwndOwner;
        HWND              hInstance;
        COLORREF          rgbResult;
        COLORREF*         lpCustColors;
        CHOOSECOLOR_FLAGS Flags;
        LPARAM            lCustData;
        LPCCHOOKPROC      lpfnHook;
        const(PWSTR)      lpTemplateName;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-findreplacea
    struct FINDREPLACEA
    {
    align (1):
        uint              lStructSize;
        HWND              hwndOwner;
        HINSTANCE         hInstance;
        FINDREPLACE_FLAGS Flags;
        PSTR              lpstrFindWhat;
        PSTR              lpstrReplaceWith;
        ushort            wFindWhatLen;
        ushort            wReplaceWithLen;
        LPARAM            lCustData;
        LPFRHOOKPROC      lpfnHook;
        const(PSTR)       lpTemplateName;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-findreplacew
    struct FINDREPLACEW
    {
    align (1):
        uint              lStructSize;
        HWND              hwndOwner;
        HINSTANCE         hInstance;
        FINDREPLACE_FLAGS Flags;
        PWSTR             lpstrFindWhat;
        PWSTR             lpstrReplaceWith;
        ushort            wFindWhatLen;
        ushort            wReplaceWithLen;
        LPARAM            lCustData;
        LPFRHOOKPROC      lpfnHook;
        const(PWSTR)      lpTemplateName;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-choosefonta
    struct CHOOSEFONTA
    {
    align (1):
        uint                 lStructSize;
        HWND                 hwndOwner;
        HDC                  hDC;
        LOGFONTA*            lpLogFont;
        int                  iPointSize;
        CHOOSEFONT_FLAGS     Flags;
        COLORREF             rgbColors;
        LPARAM               lCustData;
        LPCFHOOKPROC         lpfnHook;
        const(PSTR)          lpTemplateName;
        HINSTANCE            hInstance;
        PSTR                 lpszStyle;
        CHOOSEFONT_FONT_TYPE nFontType;
        ushort               ___MISSING_ALIGNMENT__;
        int                  nSizeMin;
        int                  nSizeMax;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-choosefontw
    struct CHOOSEFONTW
    {
    align (1):
        uint                 lStructSize;
        HWND                 hwndOwner;
        HDC                  hDC;
        LOGFONTW*            lpLogFont;
        int                  iPointSize;
        CHOOSEFONT_FLAGS     Flags;
        COLORREF             rgbColors;
        LPARAM               lCustData;
        LPCFHOOKPROC         lpfnHook;
        const(PWSTR)         lpTemplateName;
        HINSTANCE            hInstance;
        PWSTR                lpszStyle;
        CHOOSEFONT_FONT_TYPE nFontType;
        ushort               ___MISSING_ALIGNMENT__;
        int                  nSizeMin;
        int                  nSizeMax;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printdlga
    struct PRINTDLGA
    {
    align (1):
        uint             lStructSize;
        HWND             hwndOwner;
        HGLOBAL          hDevMode;
        HGLOBAL          hDevNames;
        HDC              hDC;
        PRINTDLGEX_FLAGS Flags;
        ushort           nFromPage;
        ushort           nToPage;
        ushort           nMinPage;
        ushort           nMaxPage;
        ushort           nCopies;
        HINSTANCE        hInstance;
        LPARAM           lCustData;
        LPPRINTHOOKPROC  lpfnPrintHook;
        LPSETUPHOOKPROC  lpfnSetupHook;
        const(PSTR)      lpPrintTemplateName;
        const(PSTR)      lpSetupTemplateName;
        HGLOBAL          hPrintTemplate;
        HGLOBAL          hSetupTemplate;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printdlgw
    struct PRINTDLGW
    {
    align (1):
        uint             lStructSize;
        HWND             hwndOwner;
        HGLOBAL          hDevMode;
        HGLOBAL          hDevNames;
        HDC              hDC;
        PRINTDLGEX_FLAGS Flags;
        ushort           nFromPage;
        ushort           nToPage;
        ushort           nMinPage;
        ushort           nMaxPage;
        ushort           nCopies;
        HINSTANCE        hInstance;
        LPARAM           lCustData;
        LPPRINTHOOKPROC  lpfnPrintHook;
        LPSETUPHOOKPROC  lpfnSetupHook;
        const(PWSTR)     lpPrintTemplateName;
        const(PWSTR)     lpSetupTemplateName;
        HGLOBAL          hPrintTemplate;
        HGLOBAL          hSetupTemplate;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printpagerange
    struct PRINTPAGERANGE
    {
    align (1):
        uint nFromPage;
        uint nToPage;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printdlgexa
    struct PRINTDLGEXA
    {
    align (1):
        uint             lStructSize;
        HWND             hwndOwner;
        HGLOBAL          hDevMode;
        HGLOBAL          hDevNames;
        HDC              hDC;
        PRINTDLGEX_FLAGS Flags;
        uint             Flags2;
        uint             ExclusionFlags;
        uint             nPageRanges;
        uint             nMaxPageRanges;
        PRINTPAGERANGE*  lpPageRanges;
        uint             nMinPage;
        uint             nMaxPage;
        uint             nCopies;
        HINSTANCE        hInstance;
        const(PSTR)      lpPrintTemplateName;
        IUnknown         lpCallback;
        uint             nPropertyPages;
        HPROPSHEETPAGE*  lphPropertyPages;
        uint             nStartPage;
        uint             dwResultAction;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printdlgexw
    struct PRINTDLGEXW
    {
    align (1):
        uint             lStructSize;
        HWND             hwndOwner;
        HGLOBAL          hDevMode;
        HGLOBAL          hDevNames;
        HDC              hDC;
        PRINTDLGEX_FLAGS Flags;
        uint             Flags2;
        uint             ExclusionFlags;
        uint             nPageRanges;
        uint             nMaxPageRanges;
        PRINTPAGERANGE*  lpPageRanges;
        uint             nMinPage;
        uint             nMaxPage;
        uint             nCopies;
        HINSTANCE        hInstance;
        const(PWSTR)     lpPrintTemplateName;
        IUnknown         lpCallback;
        uint             nPropertyPages;
        HPROPSHEETPAGE*  lphPropertyPages;
        uint             nStartPage;
        uint             dwResultAction;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-devnames
    struct DEVNAMES
    {
    align (1):
        ushort wDriverOffset;
        ushort wDeviceOffset;
        ushort wOutputOffset;
        ushort wDefault;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-pagesetupdlga
    struct PAGESETUPDLGA
    {
    align (1):
        uint               lStructSize;
        HWND               hwndOwner;
        HGLOBAL            hDevMode;
        HGLOBAL            hDevNames;
        PAGESETUPDLG_FLAGS Flags;
        POINT              ptPaperSize;
        RECT               rtMinMargin;
        RECT               rtMargin;
        HINSTANCE          hInstance;
        LPARAM             lCustData;
        LPPAGESETUPHOOK    lpfnPageSetupHook;
        LPPAGEPAINTHOOK    lpfnPagePaintHook;
        const(PSTR)        lpPageSetupTemplateName;
        HGLOBAL            hPageSetupTemplate;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-pagesetupdlgw
    struct PAGESETUPDLGW
    {
    align (1):
        uint               lStructSize;
        HWND               hwndOwner;
        HGLOBAL            hDevMode;
        HGLOBAL            hDevNames;
        PAGESETUPDLG_FLAGS Flags;
        POINT              ptPaperSize;
        RECT               rtMinMargin;
        RECT               rtMargin;
        HINSTANCE          hInstance;
        LPARAM             lCustData;
        LPPAGESETUPHOOK    lpfnPageSetupHook;
        LPPAGEPAINTHOOK    lpfnPagePaintHook;
        const(PWSTR)       lpPageSetupTemplateName;
        HGLOBAL            hPageSetupTemplate;
    }
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("COMDLG32.dll")
BOOL GetOpenFileNameA(OPENFILENAMEA* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("COMDLG32.dll")
BOOL GetOpenFileNameW(OPENFILENAMEW* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("COMDLG32.dll")
BOOL GetSaveFileNameA(OPENFILENAMEA* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("COMDLG32.dll")
BOOL GetSaveFileNameW(OPENFILENAMEW* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("COMDLG32.dll")
short GetFileTitleA(const(PSTR) param0, PSTR Buf, ushort cchSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("COMDLG32.dll")
short GetFileTitleW(const(PWSTR) param0, PWSTR Buf, ushort cchSize);

@DllImport("COMDLG32.dll")
BOOL ChooseColorA(CHOOSECOLORA* param0);

@DllImport("COMDLG32.dll")
BOOL ChooseColorW(CHOOSECOLORW* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("COMDLG32.dll")
HWND FindTextA(FINDREPLACEA* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("COMDLG32.dll")
HWND FindTextW(FINDREPLACEW* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("COMDLG32.dll")
HWND ReplaceTextA(FINDREPLACEA* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("COMDLG32.dll")
HWND ReplaceTextW(FINDREPLACEW* param0);

@DllImport("COMDLG32.dll")
BOOL ChooseFontA(CHOOSEFONTA* param0);

@DllImport("COMDLG32.dll")
BOOL ChooseFontW(CHOOSEFONTW* param0);

@DllImport("COMDLG32.dll")
BOOL PrintDlgA(PRINTDLGA* pPD);

@DllImport("COMDLG32.dll")
BOOL PrintDlgW(PRINTDLGW* pPD);

@DllImport("COMDLG32.dll")
HRESULT PrintDlgExA(PRINTDLGEXA* pPD);

@DllImport("COMDLG32.dll")
HRESULT PrintDlgExW(PRINTDLGEXW* pPD);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("COMDLG32.dll")
COMMON_DLG_ERRORS CommDlgExtendedError();

@DllImport("COMDLG32.dll")
BOOL PageSetupDlgA(PAGESETUPDLGA* param0);

@DllImport("COMDLG32.dll")
BOOL PageSetupDlgW(PAGESETUPDLGW* param0);


// Interfaces

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/nn-commdlg-iprintdialogcallback
@GUID("5852a2c3-6530-11d1-b6a3-0000f8757bf9")
interface IPrintDialogCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-iprintdialogcallback-initdone
    HRESULT InitDone();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-iprintdialogcallback-selectionchange
    HRESULT SelectionChange();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-iprintdialogcallback-handlemessage
    HRESULT HandleMessage(HWND hDlg, uint uMsg, WPARAM wParam, LPARAM lParam, LRESULT* pResult);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/nn-commdlg-iprintdialogservices
@GUID("509aaeda-5639-11d1-b6a1-0000f8757bf9")
interface IPrintDialogServices : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-iprintdialogservices-getcurrentdevmode
    HRESULT GetCurrentDevMode(DEVMODEA* pDevMode, uint* pcbSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-iprintdialogservices-getcurrentprintername
    HRESULT GetCurrentPrinterName(PWSTR pPrinterName, uint* pcchSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-iprintdialogservices-getcurrentportname
    HRESULT GetCurrentPortName(PWSTR pPortName, uint* pcchSize);
}


// GUIDs


const GUID IID_IPrintDialogCallback = GUIDOF!IPrintDialogCallback;
const GUID IID_IPrintDialogServices = GUIDOF!IPrintDialogServices;
