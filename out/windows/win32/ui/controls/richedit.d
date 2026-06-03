// Written in the D programming language.

module windows.win32.ui.controls.richedit;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, CHAR, COLORREF, HANDLE, HGLOBAL,
                                         HRESULT, HWND, LPARAM, LRESULT, POINT,
                                         PSTR, PWSTR, RECT, RECTL, SIZE, WPARAM;
public import windows.win32.graphics.direct2d : ID2D1RenderTarget;
public import windows.win32.graphics.gdi : FONT_CHARSET, HBITMAP, HDC, HPALETTE, HRGN,
                                           SYS_COLOR_INDEX;
public import windows.win32.system.com : DVASPECT, DVTARGETDEVICE, IDataObject, IDispatch,
                                         IStream, IUnknown;
public import windows.win32.system.com.structuredstorage : IStorage;
public import windows.win32.system.ole : DROPEFFECT, IDropTarget, IOleClientSite,
                                         IOleInPlaceFrame, IOleInPlaceUIWindow,
                                         IOleObject, OLEINPLACEFRAMEINFO;
public import windows.win32.system.systemservices : MODIFIERKEYS_FLAGS, RECO_FLAGS;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.controls : NMHDR;
public import windows.win32.ui.input.ime : HIMC;
public import windows.win32.ui.windowsandmessaging : HCURSOR, HMENU, SCROLLBAR_CONSTANTS,
                                                     SCROLL_WINDOW_FLAGS;

extern(Windows) @nogc nothrow:


// Enums


alias CFM_MASK = uint;
enum : uint
{
    CFM_SUBSCRIPT     = 0x00030000U,
    CFM_SUPERSCRIPT   = 0x00030000U,
    CFM_EFFECTS       = 0x4000003fU,
    CFM_ALL           = 0xf800003fU,
    CFM_BOLD          = 0x00000001U,
    CFM_CHARSET       = 0x08000000U,
    CFM_COLOR         = 0x40000000U,
    CFM_FACE          = 0x20000000U,
    CFM_ITALIC        = 0x00000002U,
    CFM_OFFSET        = 0x10000000U,
    CFM_PROTECTED     = 0x00000010U,
    CFM_SIZE          = 0x80000000U,
    CFM_STRIKEOUT     = 0x00000008U,
    CFM_UNDERLINE     = 0x00000004U,
    CFM_LINK          = 0x00000020U,
    CFM_SMALLCAPS     = 0x00000040U,
    CFM_ALLCAPS       = 0x00000080U,
    CFM_HIDDEN        = 0x00000100U,
    CFM_OUTLINE       = 0x00000200U,
    CFM_SHADOW        = 0x00000400U,
    CFM_EMBOSS        = 0x00000800U,
    CFM_IMPRINT       = 0x00001000U,
    CFM_DISABLED      = 0x00002000U,
    CFM_REVISED       = 0x00004000U,
    CFM_REVAUTHOR     = 0x00008000U,
    CFM_ANIMATION     = 0x00040000U,
    CFM_STYLE         = 0x00080000U,
    CFM_KERNING       = 0x00100000U,
    CFM_SPACING       = 0x00200000U,
    CFM_WEIGHT        = 0x00400000U,
    CFM_UNDERLINETYPE = 0x00800000U,
    CFM_COOKIE        = 0x01000000U,
    CFM_LCID          = 0x02000000U,
    CFM_BACKCOLOR     = 0x04000000U,
    CFM_EFFECTS2      = 0x44037fffU,
    CFM_ALL2          = 0xffffffffU,
    CFM_FONTBOUND     = 0x00100000U,
    CFM_LINKPROTECTED = 0x00800000U,
    CFM_EXTENDED      = 0x02000000U,
    CFM_MATHNOBUILDUP = 0x08000000U,
    CFM_MATH          = 0x10000000U,
    CFM_MATHORDINARY  = 0x20000000U,
    CFM_ALLEFFECTS    = 0x7e137fffU,
}

alias CFE_EFFECTS = uint;
enum : uint
{
    CFE_ALLCAPS       = 0x00000080U,
    CFE_AUTOBACKCOLOR = 0x04000000U,
    CFE_DISABLED      = 0x00002000U,
    CFE_EMBOSS        = 0x00000800U,
    CFE_HIDDEN        = 0x00000100U,
    CFE_IMPRINT       = 0x00001000U,
    CFE_OUTLINE       = 0x00000200U,
    CFE_REVISED       = 0x00004000U,
    CFE_SHADOW        = 0x00000400U,
    CFE_SMALLCAPS     = 0x00000040U,
    CFE_AUTOCOLOR     = 0x40000000U,
    CFE_BOLD          = 0x00000001U,
    CFE_ITALIC        = 0x00000002U,
    CFE_STRIKEOUT     = 0x00000008U,
    CFE_UNDERLINE     = 0x00000004U,
    CFE_PROTECTED     = 0x00000010U,
    CFE_LINK          = 0x00000020U,
    CFE_SUBSCRIPT     = 0x00010000U,
    CFE_SUPERSCRIPT   = 0x00020000U,
    CFE_FONTBOUND     = 0x00100000U,
    CFE_LINKPROTECTED = 0x00800000U,
    CFE_EXTENDED      = 0x02000000U,
    CFE_MATHNOBUILDUP = 0x08000000U,
    CFE_MATH          = 0x10000000U,
    CFE_MATHORDINARY  = 0x20000000U,
}

alias PARAFORMAT_MASK = uint;
enum : uint
{
    PFM_STARTINDENT       = 0x00000001U,
    PFM_RIGHTINDENT       = 0x00000002U,
    PFM_OFFSET            = 0x00000004U,
    PFM_ALIGNMENT         = 0x00000008U,
    PFM_TABSTOPS          = 0x00000010U,
    PFM_NUMBERING         = 0x00000020U,
    PFM_OFFSETINDENT      = 0x80000000U,
    PFM_SPACEBEFORE       = 0x00000040U,
    PFM_SPACEAFTER        = 0x00000080U,
    PFM_LINESPACING       = 0x00000100U,
    PFM_STYLE             = 0x00000400U,
    PFM_BORDER            = 0x00000800U,
    PFM_SHADING           = 0x00001000U,
    PFM_NUMBERINGSTYLE    = 0x00002000U,
    PFM_NUMBERINGTAB      = 0x00004000U,
    PFM_NUMBERINGSTART    = 0x00008000U,
    PFM_RTLPARA           = 0x00010000U,
    PFM_KEEP              = 0x00020000U,
    PFM_KEEPNEXT          = 0x00040000U,
    PFM_PAGEBREAKBEFORE   = 0x00080000U,
    PFM_NOLINENUMBER      = 0x00100000U,
    PFM_NOWIDOWCONTROL    = 0x00200000U,
    PFM_DONOTHYPHEN       = 0x00400000U,
    PFM_SIDEBYSIDE        = 0x00800000U,
    PFM_COLLAPSED         = 0x01000000U,
    PFM_OUTLINELEVEL      = 0x02000000U,
    PFM_BOX               = 0x04000000U,
    PFM_RESERVED2         = 0x08000000U,
    PFM_TABLEROWDELIMITER = 0x10000000U,
    PFM_TEXTWRAPPINGBREAK = 0x20000000U,
    PFM_TABLE             = 0x40000000U,
    PFM_ALL               = 0x8001003fU,
    PFM_EFFECTS           = 0x50ff0000U,
    PFM_ALL2              = 0xd0fffdffU,
}

alias RICH_EDIT_GET_CONTEXT_MENU_SEL_TYPE = ushort;
enum : ushort
{
    SEL_EMPTY          = cast(ushort) 0x0000,
    SEL_TEXT           = cast(ushort) 0x0001,
    SEL_OBJECT         = cast(ushort) 0x0002,
    SEL_MULTICHAR      = cast(ushort) 0x0004,
    SEL_MULTIOBJECT    = cast(ushort) 0x0008,
    GCM_RIGHTMOUSEDROP = cast(ushort) 0x8000,
}

alias RICH_EDIT_GET_OBJECT_FLAGS = uint;
enum : uint
{
    REO_GETOBJ_POLEOBJ        = 0x00000001U,
    REO_GETOBJ_PSTG           = 0x00000002U,
    REO_GETOBJ_POLESITE       = 0x00000004U,
    REO_GETOBJ_NO_INTERFACES  = 0x00000000U,
    REO_GETOBJ_ALL_INTERFACES = 0x00000007U,
}

alias PARAFORMAT_BORDERS = ushort;
enum : ushort
{
    PARAFORMAT_BORDERS_LEFT      = cast(ushort) 0x0001,
    PARAFORMAT_BORDERS_RIGHT     = cast(ushort) 0x0002,
    PARAFORMAT_BORDERS_TOP       = cast(ushort) 0x0004,
    PARAFORMAT_BORDERS_BOTTOM    = cast(ushort) 0x0008,
    PARAFORMAT_BORDERS_INSIDE    = cast(ushort) 0x0010,
    PARAFORMAT_BORDERS_OUTSIDE   = cast(ushort) 0x0020,
    PARAFORMAT_BORDERS_AUTOCOLOR = cast(ushort) 0x0040,
}

alias PARAFORMAT_SHADING_STYLE = ushort;
enum : ushort
{
    PARAFORMAT_SHADING_STYLE_NONE            = cast(ushort) 0x0000,
    PARAFORMAT_SHADING_STYLE_DARK_HORIZ      = cast(ushort) 0x0001,
    PARAFORMAT_SHADING_STYLE_DARK_VERT       = cast(ushort) 0x0002,
    PARAFORMAT_SHADING_STYLE_DARK_DOWN_DIAG  = cast(ushort) 0x0003,
    PARAFORMAT_SHADING_STYLE_DARK_UP_DIAG    = cast(ushort) 0x0004,
    PARAFORMAT_SHADING_STYLE_DARK_GRID       = cast(ushort) 0x0005,
    PARAFORMAT_SHADING_STYLE_DARK_TRELLIS    = cast(ushort) 0x0006,
    PARAFORMAT_SHADING_STYLE_LIGHT_HORZ      = cast(ushort) 0x0007,
    PARAFORMAT_SHADING_STYLE_LIGHT_VERT      = cast(ushort) 0x0008,
    PARAFORMAT_SHADING_STYLE_LIGHT_DOWN_DIAG = cast(ushort) 0x0009,
    PARAFORMAT_SHADING_STYLE_LIGHT_UP_DIAG   = cast(ushort) 0x000a,
    PARAFORMAT_SHADING_STYLE_LIGHT_GRID      = cast(ushort) 0x000b,
    PARAFORMAT_SHADING_STYLE_LIGHT_TRELLIS   = cast(ushort) 0x000c,
}

alias GETTEXTEX_FLAGS = uint;
enum : uint
{
    GT_DEFAULT      = 0x00000000U,
    GT_NOHIDDENTEXT = 0x00000008U,
    GT_RAWTEXT      = 0x00000004U,
    GT_SELECTION    = 0x00000002U,
    GT_USECRLF      = 0x00000001U,
}

alias ENDCOMPOSITIONNOTIFY_CODE = uint;
enum : uint
{
    ECN_ENDCOMPOSITION = 0x00000001U,
    ECN_NEWTEXT        = 0x00000002U,
}

alias IMECOMPTEXT_FLAGS = uint;
enum : uint
{
    ICT_RESULTREADSTR = 0x00000001U,
}

alias GETTEXTLENGTHEX_FLAGS = uint;
enum : uint
{
    GTL_DEFAULT  = 0x00000000U,
    GTL_USECRLF  = 0x00000001U,
    GTL_PRECISE  = 0x00000002U,
    GTL_CLOSE    = 0x00000004U,
    GTL_NUMCHARS = 0x00000008U,
    GTL_NUMBYTES = 0x00000010U,
}

alias REOBJECT_FLAGS = uint;
enum : uint
{
    REO_ALIGNTORIGHT    = 0x00000100U,
    REO_BELOWBASELINE   = 0x00000002U,
    REO_BLANK           = 0x00000010U,
    REO_CANROTATE       = 0x00000080U,
    REO_DONTNEEDPALETTE = 0x00000020U,
    REO_DYNAMICSIZE     = 0x00000008U,
    REO_GETMETAFILE     = 0x00400000U,
    REO_HILITED         = 0x01000000U,
    REO_INPLACEACTIVE   = 0x02000000U,
    REO_INVERTEDSELECT  = 0x00000004U,
    REO_LINK            = 0x80000000U,
    REO_LINKAVAILABLE   = 0x00800000U,
    REO_OPEN            = 0x04000000U,
    REO_OWNERDRAWSELECT = 0x00000040U,
    REO_RESIZABLE       = 0x00000001U,
    REO_SELECTED        = 0x08000000U,
    REO_STATIC          = 0x40000000U,
    REO_USEASBACKGROUND = 0x00000400U,
    REO_WRAPTEXTAROUND  = 0x00000200U,
}

alias PARAFORMAT_NUMBERING_STYLE = ushort;
enum : ushort
{
    PFNS_PAREN     = cast(ushort) 0x0000,
    PFNS_PARENS    = cast(ushort) 0x0100,
    PFNS_PERIOD    = cast(ushort) 0x0200,
    PFNS_PLAIN     = cast(ushort) 0x0300,
    PFNS_NONUMBER  = cast(ushort) 0x0400,
    PFNS_NEWNUMBER = cast(ushort) 0x8000,
}

alias PARAFORMAT_ALIGNMENT = ushort;
enum : ushort
{
    PFA_LEFT             = cast(ushort) 0x0001,
    PFA_RIGHT            = cast(ushort) 0x0002,
    PFA_CENTER           = cast(ushort) 0x0003,
    PFA_JUSTIFY          = cast(ushort) 0x0004,
    PFA_FULL_INTERWORD   = cast(ushort) 0x0004,
    PFA_FULL_NEWSPAPER   = cast(ushort) 0x0005,
    PFA_FULL_INTERLETTER = cast(ushort) 0x0006,
    PFA_FULL_SCALED      = cast(ushort) 0x0007,
    PFA_FULL_GLYPHS      = cast(ushort) 0x0008,
}

alias PARAFORMAT_NUMBERING = ushort;
enum : ushort
{
    PFN_BULLET   = cast(ushort) 0x0001,
    PFN_ARABIC   = cast(ushort) 0x0002,
    PFN_LCLETTER = cast(ushort) 0x0003,
    PFN_UCLETTER = cast(ushort) 0x0004,
    PFN_LCROMAN  = cast(ushort) 0x0005,
    PFN_UCROMAN  = cast(ushort) 0x0006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ne-richedit-textmode
alias TEXTMODE = int;
enum : int
{
    TM_PLAINTEXT       = 0x00000001,
    TM_RICHTEXT        = 0x00000002,
    TM_SINGLELEVELUNDO = 0x00000004,
    TM_MULTILEVELUNDO  = 0x00000008,
    TM_SINGLECODEPAGE  = 0x00000010,
    TM_MULTICODEPAGE   = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ne-richedit-undonameid
alias UNDONAMEID = int;
enum : int
{
    UID_UNKNOWN   = 0x00000000,
    UID_TYPING    = 0x00000001,
    UID_DELETE    = 0x00000002,
    UID_DRAGDROP  = 0x00000003,
    UID_CUT       = 0x00000004,
    UID_PASTE     = 0x00000005,
    UID_AUTOTABLE = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ne-richedit-khyph
alias KHYPH = int;
enum : int
{
    khyphNil          = 0x00000000,
    khyphNormal       = 0x00000001,
    khyphAddBefore    = 0x00000002,
    khyphChangeBefore = 0x00000003,
    khyphDeleteBefore = 0x00000004,
    khyphChangeAfter  = 0x00000005,
    khyphDelAndChange = 0x00000006,
}

alias TXTBACKSTYLE = int;
enum : int
{
    TXTBACK_TRANSPARENT = 0x00000000,
    TXTBACK_OPAQUE      = 0x00000001,
}

alias TXTHITRESULT = int;
enum : int
{
    TXTHITRESULT_NOHIT       = 0x00000000,
    TXTHITRESULT_TRANSPARENT = 0x00000001,
    TXTHITRESULT_CLOSE       = 0x00000002,
    TXTHITRESULT_HIT         = 0x00000003,
}

alias TXTNATURALSIZE = int;
enum : int
{
    TXTNS_FITTOCONTENT2   = 0x00000000,
    TXTNS_FITTOCONTENT    = 0x00000001,
    TXTNS_ROUNDTOLINE     = 0x00000002,
    TXTNS_FITTOCONTENT3   = 0x00000003,
    TXTNS_FITTOCONTENTWSP = 0x00000004,
    TXTNS_INCLUDELASTLINE = 0x40000000,
    TXTNS_EMU             = 0x80000000,
}

alias TXTVIEW = int;
enum : int
{
    TXTVIEW_ACTIVE   = 0x00000000,
    TXTVIEW_INACTIVE = 0xffffffff,
}

alias CHANGETYPE = int;
enum : int
{
    CN_GENERIC     = 0x00000000,
    CN_TEXTCHANGED = 0x00000001,
    CN_NEWUNDO     = 0x00000002,
    CN_NEWREDO     = 0x00000004,
}

alias CARET_FLAGS = int;
enum : int
{
    CARET_NONE     = 0x00000000,
    CARET_CUSTOM   = 0x00000001,
    CARET_RTL      = 0x00000002,
    CARET_ITALIC   = 0x00000020,
    CARET_NULL     = 0x00000040,
    CARET_ROTATE90 = 0x00000080,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/ne-tom-tomconstants
alias tomConstants = int;
enum : int
{
    tomFalse                           = 0x00000000,
    tomTrue                            = 0xffffffff,
    tomUndefined                       = 0xff676981,
    tomToggle                          = 0xff676982,
    tomAutoColor                       = 0xff676983,
    tomDefault                         = 0xff676984,
    tomSuspend                         = 0xff676985,
    tomResume                          = 0xff676986,
    tomApplyNow                        = 0x00000000,
    tomApplyLater                      = 0x00000001,
    tomTrackParms                      = 0x00000002,
    tomCacheParms                      = 0x00000003,
    tomApplyTmp                        = 0x00000004,
    tomDisableSmartFont                = 0x00000008,
    tomEnableSmartFont                 = 0x00000009,
    tomUsePoints                       = 0x0000000a,
    tomUseTwips                        = 0x0000000b,
    tomBackward                        = 0xc0000001,
    tomForward                         = 0x3fffffff,
    tomMove                            = 0x00000000,
    tomExtend                          = 0x00000001,
    tomNoSelection                     = 0x00000000,
    tomSelectionIP                     = 0x00000001,
    tomSelectionNormal                 = 0x00000002,
    tomSelectionFrame                  = 0x00000003,
    tomSelectionColumn                 = 0x00000004,
    tomSelectionRow                    = 0x00000005,
    tomSelectionBlock                  = 0x00000006,
    tomSelectionInlineShape            = 0x00000007,
    tomSelectionShape                  = 0x00000008,
    tomSelStartActive                  = 0x00000001,
    tomSelAtEOL                        = 0x00000002,
    tomSelOvertype                     = 0x00000004,
    tomSelActive                       = 0x00000008,
    tomSelReplace                      = 0x00000010,
    tomEnd                             = 0x00000000,
    tomStart                           = 0x00000020,
    tomCollapseEnd                     = 0x00000000,
    tomCollapseStart                   = 0x00000001,
    tomClientCoord                     = 0x00000100,
    tomAllowOffClient                  = 0x00000200,
    tomTransform                       = 0x00000400,
    tomObjectArg                       = 0x00000800,
    tomAtEnd                           = 0x00001000,
    tomNone                            = 0x00000000,
    tomSingle                          = 0x00000001,
    tomWords                           = 0x00000002,
    tomDouble                          = 0x00000003,
    tomDotted                          = 0x00000004,
    tomDash                            = 0x00000005,
    tomDashDot                         = 0x00000006,
    tomDashDotDot                      = 0x00000007,
    tomWave                            = 0x00000008,
    tomThick                           = 0x00000009,
    tomHair                            = 0x0000000a,
    tomDoubleWave                      = 0x0000000b,
    tomHeavyWave                       = 0x0000000c,
    tomLongDash                        = 0x0000000d,
    tomThickDash                       = 0x0000000e,
    tomThickDashDot                    = 0x0000000f,
    tomThickDashDotDot                 = 0x00000010,
    tomThickDotted                     = 0x00000011,
    tomThickLongDash                   = 0x00000012,
    tomLineSpaceSingle                 = 0x00000000,
    tomLineSpace1pt5                   = 0x00000001,
    tomLineSpaceDouble                 = 0x00000002,
    tomLineSpaceAtLeast                = 0x00000003,
    tomLineSpaceExactly                = 0x00000004,
    tomLineSpaceMultiple               = 0x00000005,
    tomLineSpacePercent                = 0x00000006,
    tomAlignLeft                       = 0x00000000,
    tomAlignCenter                     = 0x00000001,
    tomAlignRight                      = 0x00000002,
    tomAlignJustify                    = 0x00000003,
    tomAlignDecimal                    = 0x00000003,
    tomAlignBar                        = 0x00000004,
    tomDefaultTab                      = 0x00000005,
    tomAlignInterWord                  = 0x00000003,
    tomAlignNewspaper                  = 0x00000004,
    tomAlignInterLetter                = 0x00000005,
    tomAlignScaled                     = 0x00000006,
    tomSpaces                          = 0x00000000,
    tomDots                            = 0x00000001,
    tomDashes                          = 0x00000002,
    tomLines                           = 0x00000003,
    tomThickLines                      = 0x00000004,
    tomEquals                          = 0x00000005,
    tomTabBack                         = 0xfffffffd,
    tomTabNext                         = 0xfffffffe,
    tomTabHere                         = 0xffffffff,
    tomListNone                        = 0x00000000,
    tomListBullet                      = 0x00000001,
    tomListNumberAsArabic              = 0x00000002,
    tomListNumberAsLCLetter            = 0x00000003,
    tomListNumberAsUCLetter            = 0x00000004,
    tomListNumberAsLCRoman             = 0x00000005,
    tomListNumberAsUCRoman             = 0x00000006,
    tomListNumberAsSequence            = 0x00000007,
    tomListNumberedCircle              = 0x00000008,
    tomListNumberedBlackCircleWingding = 0x00000009,
    tomListNumberedWhiteCircleWingding = 0x0000000a,
    tomListNumberedArabicWide          = 0x0000000b,
    tomListNumberedChS                 = 0x0000000c,
    tomListNumberedChT                 = 0x0000000d,
    tomListNumberedJpnChS              = 0x0000000e,
    tomListNumberedJpnKor              = 0x0000000f,
    tomListNumberedArabic1             = 0x00000010,
    tomListNumberedArabic2             = 0x00000011,
    tomListNumberedHebrew              = 0x00000012,
    tomListNumberedThaiAlpha           = 0x00000013,
    tomListNumberedThaiNum             = 0x00000014,
    tomListNumberedHindiAlpha          = 0x00000015,
    tomListNumberedHindiAlpha1         = 0x00000016,
    tomListNumberedHindiNum            = 0x00000017,
    tomListParentheses                 = 0x00010000,
    tomListPeriod                      = 0x00020000,
    tomListPlain                       = 0x00030000,
    tomListNoNumber                    = 0x00040000,
    tomListMinus                       = 0x00080000,
    tomIgnoreNumberStyle               = 0x01000000,
    tomParaStyleNormal                 = 0xffffffff,
    tomParaStyleHeading1               = 0xfffffffe,
    tomParaStyleHeading2               = 0xfffffffd,
    tomParaStyleHeading3               = 0xfffffffc,
    tomParaStyleHeading4               = 0xfffffffb,
    tomParaStyleHeading5               = 0xfffffffa,
    tomParaStyleHeading6               = 0xfffffff9,
    tomParaStyleHeading7               = 0xfffffff8,
    tomParaStyleHeading8               = 0xfffffff7,
    tomParaStyleHeading9               = 0xfffffff6,
    tomCharacter                       = 0x00000001,
    tomWord                            = 0x00000002,
    tomSentence                        = 0x00000003,
    tomParagraph                       = 0x00000004,
    tomLine                            = 0x00000005,
    tomStory                           = 0x00000006,
    tomScreen                          = 0x00000007,
    tomSection                         = 0x00000008,
    tomTableColumn                     = 0x00000009,
    tomColumn                          = 0x00000009,
    tomRow                             = 0x0000000a,
    tomWindow                          = 0x0000000b,
    tomCell                            = 0x0000000c,
    tomCharFormat                      = 0x0000000d,
    tomParaFormat                      = 0x0000000e,
    tomTable                           = 0x0000000f,
    tomObject                          = 0x00000010,
    tomPage                            = 0x00000011,
    tomHardParagraph                   = 0x00000012,
    tomCluster                         = 0x00000013,
    tomInlineObject                    = 0x00000014,
    tomInlineObjectArg                 = 0x00000015,
    tomLeafLine                        = 0x00000016,
    tomLayoutColumn                    = 0x00000017,
    tomProcessId                       = 0x40000001,
    tomMatchWord                       = 0x00000002,
    tomMatchCase                       = 0x00000004,
    tomMatchPattern                    = 0x00000008,
    tomUnknownStory                    = 0x00000000,
    tomMainTextStory                   = 0x00000001,
    tomFootnotesStory                  = 0x00000002,
    tomEndnotesStory                   = 0x00000003,
    tomCommentsStory                   = 0x00000004,
    tomTextFrameStory                  = 0x00000005,
    tomEvenPagesHeaderStory            = 0x00000006,
    tomPrimaryHeaderStory              = 0x00000007,
    tomEvenPagesFooterStory            = 0x00000008,
    tomPrimaryFooterStory              = 0x00000009,
    tomFirstPageHeaderStory            = 0x0000000a,
    tomFirstPageFooterStory            = 0x0000000b,
    tomScratchStory                    = 0x0000007f,
    tomFindStory                       = 0x00000080,
    tomReplaceStory                    = 0x00000081,
    tomStoryInactive                   = 0x00000000,
    tomStoryActiveDisplay              = 0x00000001,
    tomStoryActiveUI                   = 0x00000002,
    tomStoryActiveDisplayUI            = 0x00000003,
    tomNoAnimation                     = 0x00000000,
    tomLasVegasLights                  = 0x00000001,
    tomBlinkingBackground              = 0x00000002,
    tomSparkleText                     = 0x00000003,
    tomMarchingBlackAnts               = 0x00000004,
    tomMarchingRedAnts                 = 0x00000005,
    tomShimmer                         = 0x00000006,
    tomWipeDown                        = 0x00000007,
    tomWipeRight                       = 0x00000008,
    tomAnimationMax                    = 0x00000008,
    tomLowerCase                       = 0x00000000,
    tomUpperCase                       = 0x00000001,
    tomTitleCase                       = 0x00000002,
    tomSentenceCase                    = 0x00000004,
    tomToggleCase                      = 0x00000005,
    tomReadOnly                        = 0x00000100,
    tomShareDenyRead                   = 0x00000200,
    tomShareDenyWrite                  = 0x00000400,
    tomPasteFile                       = 0x00001000,
    tomCreateNew                       = 0x00000010,
    tomCreateAlways                    = 0x00000020,
    tomOpenExisting                    = 0x00000030,
    tomOpenAlways                      = 0x00000040,
    tomTruncateExisting                = 0x00000050,
    tomRTF                             = 0x00000001,
    tomText                            = 0x00000002,
    tomHTML                            = 0x00000003,
    tomWordDocument                    = 0x00000004,
    tomBold                            = 0x80000001,
    tomItalic                          = 0x80000002,
    tomUnderline                       = 0x80000004,
    tomStrikeout                       = 0x80000008,
    tomProtected                       = 0x80000010,
    tomLink                            = 0x80000020,
    tomSmallCaps                       = 0x80000040,
    tomAllCaps                         = 0x80000080,
    tomHidden                          = 0x80000100,
    tomOutline                         = 0x80000200,
    tomShadow                          = 0x80000400,
    tomEmboss                          = 0x80000800,
    tomImprint                         = 0x80001000,
    tomDisabled                        = 0x80002000,
    tomRevised                         = 0x80004000,
    tomSubscriptCF                     = 0x80010000,
    tomSuperscriptCF                   = 0x80020000,
    tomFontBound                       = 0x80100000,
    tomLinkProtected                   = 0x80800000,
    tomInlineObjectStart               = 0x81000000,
    tomExtendedChar                    = 0x82000000,
    tomAutoBackColor                   = 0x84000000,
    tomMathZoneNoBuildUp               = 0x88000000,
    tomMathZone                        = 0x90000000,
    tomMathZoneOrdinary                = 0xa0000000,
    tomAutoTextColor                   = 0xc0000000,
    tomMathZoneDisplay                 = 0x00040000,
    tomParaEffectRTL                   = 0x00000001,
    tomParaEffectKeep                  = 0x00000002,
    tomParaEffectKeepNext              = 0x00000004,
    tomParaEffectPageBreakBefore       = 0x00000008,
    tomParaEffectNoLineNumber          = 0x00000010,
    tomParaEffectNoWidowControl        = 0x00000020,
    tomParaEffectDoNotHyphen           = 0x00000040,
    tomParaEffectSideBySide            = 0x00000080,
    tomParaEffectCollapsed             = 0x00000100,
    tomParaEffectOutlineLevel          = 0x00000200,
    tomParaEffectBox                   = 0x00000400,
    tomParaEffectTableRowDelimiter     = 0x00001000,
    tomParaEffectTable                 = 0x00004000,
    tomModWidthPairs                   = 0x00000001,
    tomModWidthSpace                   = 0x00000002,
    tomAutoSpaceAlpha                  = 0x00000004,
    tomAutoSpaceNumeric                = 0x00000008,
    tomAutoSpaceParens                 = 0x00000010,
    tomEmbeddedFont                    = 0x00000020,
    tomDoublestrike                    = 0x00000040,
    tomOverlapping                     = 0x00000080,
    tomNormalCaret                     = 0x00000000,
    tomKoreanBlockCaret                = 0x00000001,
    tomNullCaret                       = 0x00000002,
    tomIncludeInset                    = 0x00000001,
    tomUnicodeBiDi                     = 0x00000001,
    tomMathCFCheck                     = 0x00000004,
    tomUnlink                          = 0x00000008,
    tomUnhide                          = 0x00000010,
    tomCheckTextLimit                  = 0x00000020,
    tomIgnoreCurrentFont               = 0x00000000,
    tomMatchCharRep                    = 0x00000001,
    tomMatchFontSignature              = 0x00000002,
    tomMatchAscii                      = 0x00000004,
    tomGetHeightOnly                   = 0x00000008,
    tomMatchMathFont                   = 0x00000010,
    tomCharset                         = 0x80000000,
    tomCharRepFromLcid                 = 0x40000000,
    tomAnsi                            = 0x00000000,
    tomEastEurope                      = 0x00000001,
    tomCyrillic                        = 0x00000002,
    tomGreek                           = 0x00000003,
    tomTurkish                         = 0x00000004,
    tomHebrew                          = 0x00000005,
    tomArabic                          = 0x00000006,
    tomBaltic                          = 0x00000007,
    tomVietnamese                      = 0x00000008,
    tomDefaultCharRep                  = 0x00000009,
    tomSymbol                          = 0x0000000a,
    tomThai                            = 0x0000000b,
    tomShiftJIS                        = 0x0000000c,
    tomGB2312                          = 0x0000000d,
    tomHangul                          = 0x0000000e,
    tomBIG5                            = 0x0000000f,
    tomPC437                           = 0x00000010,
    tomOEM                             = 0x00000011,
    tomMac                             = 0x00000012,
    tomArmenian                        = 0x00000013,
    tomSyriac                          = 0x00000014,
    tomThaana                          = 0x00000015,
    tomDevanagari                      = 0x00000016,
    tomBengali                         = 0x00000017,
    tomGurmukhi                        = 0x00000018,
    tomGujarati                        = 0x00000019,
    tomOriya                           = 0x0000001a,
    tomTamil                           = 0x0000001b,
    tomTelugu                          = 0x0000001c,
    tomKannada                         = 0x0000001d,
    tomMalayalam                       = 0x0000001e,
    tomSinhala                         = 0x0000001f,
    tomLao                             = 0x00000020,
    tomTibetan                         = 0x00000021,
    tomMyanmar                         = 0x00000022,
    tomGeorgian                        = 0x00000023,
    tomJamo                            = 0x00000024,
    tomEthiopic                        = 0x00000025,
    tomCherokee                        = 0x00000026,
    tomAboriginal                      = 0x00000027,
    tomOgham                           = 0x00000028,
    tomRunic                           = 0x00000029,
    tomKhmer                           = 0x0000002a,
    tomMongolian                       = 0x0000002b,
    tomBraille                         = 0x0000002c,
    tomYi                              = 0x0000002d,
    tomLimbu                           = 0x0000002e,
    tomTaiLe                           = 0x0000002f,
    tomNewTaiLue                       = 0x00000030,
    tomSylotiNagri                     = 0x00000031,
    tomKharoshthi                      = 0x00000032,
    tomKayahli                         = 0x00000033,
    tomUsymbol                         = 0x00000034,
    tomEmoji                           = 0x00000035,
    tomGlagolitic                      = 0x00000036,
    tomLisu                            = 0x00000037,
    tomVai                             = 0x00000038,
    tomNKo                             = 0x00000039,
    tomOsmanya                         = 0x0000003a,
    tomPhagsPa                         = 0x0000003b,
    tomGothic                          = 0x0000003c,
    tomDeseret                         = 0x0000003d,
    tomTifinagh                        = 0x0000003e,
    tomCharRepMax                      = 0x0000003f,
    tomRE10Mode                        = 0x00000001,
    tomUseAtFont                       = 0x00000002,
    tomTextFlowMask                    = 0x0000000c,
    tomTextFlowES                      = 0x00000000,
    tomTextFlowSW                      = 0x00000004,
    tomTextFlowWN                      = 0x00000008,
    tomTextFlowNE                      = 0x0000000c,
    tomNoIME                           = 0x00080000,
    tomSelfIME                         = 0x00040000,
    tomNoUpScroll                      = 0x00010000,
    tomNoVpScroll                      = 0x00040000,
    tomNoLink                          = 0x00000000,
    tomClientLink                      = 0x00000001,
    tomFriendlyLinkName                = 0x00000002,
    tomFriendlyLinkAddress             = 0x00000003,
    tomAutoLinkURL                     = 0x00000004,
    tomAutoLinkEmail                   = 0x00000005,
    tomAutoLinkPhone                   = 0x00000006,
    tomAutoLinkPath                    = 0x00000007,
    tomCompressNone                    = 0x00000000,
    tomCompressPunctuation             = 0x00000001,
    tomCompressPunctuationAndKana      = 0x00000002,
    tomCompressMax                     = 0x00000002,
    tomUnderlinePositionAuto           = 0x00000000,
    tomUnderlinePositionBelow          = 0x00000001,
    tomUnderlinePositionAbove          = 0x00000002,
    tomUnderlinePositionMax            = 0x00000002,
    tomFontAlignmentAuto               = 0x00000000,
    tomFontAlignmentTop                = 0x00000001,
    tomFontAlignmentBaseline           = 0x00000002,
    tomFontAlignmentBottom             = 0x00000003,
    tomFontAlignmentCenter             = 0x00000004,
    tomFontAlignmentMax                = 0x00000004,
    tomRubyBelow                       = 0x00000080,
    tomRubyAlignCenter                 = 0x00000000,
    tomRubyAlign010                    = 0x00000001,
    tomRubyAlign121                    = 0x00000002,
    tomRubyAlignLeft                   = 0x00000003,
    tomRubyAlignRight                  = 0x00000004,
    tomLimitsDefault                   = 0x00000000,
    tomLimitsUnderOver                 = 0x00000001,
    tomLimitsSubSup                    = 0x00000002,
    tomUpperLimitAsSuperScript         = 0x00000003,
    tomLimitsOpposite                  = 0x00000004,
    tomShowLLimPlaceHldr               = 0x00000008,
    tomShowULimPlaceHldr               = 0x00000010,
    tomDontGrowWithContent             = 0x00000040,
    tomGrowWithContent                 = 0x00000080,
    tomSubSupAlign                     = 0x00000001,
    tomLimitAlignMask                  = 0x00000003,
    tomLimitAlignCenter                = 0x00000000,
    tomLimitAlignLeft                  = 0x00000001,
    tomLimitAlignRight                 = 0x00000002,
    tomShowDegPlaceHldr                = 0x00000008,
    tomAlignDefault                    = 0x00000000,
    tomAlignMatchAscentDescent         = 0x00000002,
    tomMathVariant                     = 0x00000020,
    tomStyleDefault                    = 0x00000000,
    tomStyleScriptScriptCramped        = 0x00000001,
    tomStyleScriptScript               = 0x00000002,
    tomStyleScriptCramped              = 0x00000003,
    tomStyleScript                     = 0x00000004,
    tomStyleTextCramped                = 0x00000005,
    tomStyleText                       = 0x00000006,
    tomStyleDisplayCramped             = 0x00000007,
    tomStyleDisplay                    = 0x00000008,
    tomMathRelSize                     = 0x00000040,
    tomDecDecSize                      = 0x000000fe,
    tomDecSize                         = 0x000000ff,
    tomIncSize                         = 0x00000041,
    tomIncIncSize                      = 0x00000042,
    tomGravityUI                       = 0x00000000,
    tomGravityBack                     = 0x00000001,
    tomGravityFore                     = 0x00000002,
    tomGravityIn                       = 0x00000003,
    tomGravityOut                      = 0x00000004,
    tomGravityBackward                 = 0x20000000,
    tomGravityForward                  = 0x40000000,
    tomAdjustCRLF                      = 0x00000001,
    tomUseCRLF                         = 0x00000002,
    tomTextize                         = 0x00000004,
    tomAllowFinalEOP                   = 0x00000008,
    tomFoldMathAlpha                   = 0x00000010,
    tomNoHidden                        = 0x00000020,
    tomIncludeNumbering                = 0x00000040,
    tomTranslateTableCell              = 0x00000080,
    tomNoMathZoneBrackets              = 0x00000100,
    tomConvertMathChar                 = 0x00000200,
    tomNoUCGreekItalic                 = 0x00000400,
    tomAllowMathBold                   = 0x00000800,
    tomLanguageTag                     = 0x00001000,
    tomConvertRTF                      = 0x00002000,
    tomApplyRtfDocProps                = 0x00004000,
    tomPhantomShow                     = 0x00000001,
    tomPhantomZeroWidth                = 0x00000002,
    tomPhantomZeroAscent               = 0x00000004,
    tomPhantomZeroDescent              = 0x00000008,
    tomPhantomTransparent              = 0x00000010,
    tomPhantomASmash                   = 0x00000005,
    tomPhantomDSmash                   = 0x00000009,
    tomPhantomHSmash                   = 0x00000003,
    tomPhantomSmash                    = 0x0000000d,
    tomPhantomHorz                     = 0x0000000c,
    tomPhantomVert                     = 0x00000002,
    tomBoxHideTop                      = 0x00000001,
    tomBoxHideBottom                   = 0x00000002,
    tomBoxHideLeft                     = 0x00000004,
    tomBoxHideRight                    = 0x00000008,
    tomBoxStrikeH                      = 0x00000010,
    tomBoxStrikeV                      = 0x00000020,
    tomBoxStrikeTLBR                   = 0x00000040,
    tomBoxStrikeBLTR                   = 0x00000080,
    tomBoxAlignCenter                  = 0x00000001,
    tomSpaceMask                       = 0x0000001c,
    tomSpaceDefault                    = 0x00000000,
    tomSpaceUnary                      = 0x00000004,
    tomSpaceBinary                     = 0x00000008,
    tomSpaceRelational                 = 0x0000000c,
    tomSpaceSkip                       = 0x00000010,
    tomSpaceOrd                        = 0x00000014,
    tomSpaceDifferential               = 0x00000018,
    tomSizeText                        = 0x00000020,
    tomSizeScript                      = 0x00000040,
    tomSizeScriptScript                = 0x00000060,
    tomNoBreak                         = 0x00000080,
    tomTransparentForPositioning       = 0x00000100,
    tomTransparentForSpacing           = 0x00000200,
    tomStretchCharBelow                = 0x00000000,
    tomStretchCharAbove                = 0x00000001,
    tomStretchBaseBelow                = 0x00000002,
    tomStretchBaseAbove                = 0x00000003,
    tomMatrixAlignMask                 = 0x00000003,
    tomMatrixAlignCenter               = 0x00000000,
    tomMatrixAlignTopRow               = 0x00000001,
    tomMatrixAlignBottomRow            = 0x00000003,
    tomShowMatPlaceHldr                = 0x00000008,
    tomEqArrayLayoutWidth              = 0x00000001,
    tomEqArrayAlignMask                = 0x0000000c,
    tomEqArrayAlignCenter              = 0x00000000,
    tomEqArrayAlignTopRow              = 0x00000004,
    tomEqArrayAlignBottomRow           = 0x0000000c,
    tomMathManualBreakMask             = 0x0000007f,
    tomMathBreakLeft                   = 0x0000007d,
    tomMathBreakCenter                 = 0x0000007e,
    tomMathBreakRight                  = 0x0000007f,
    tomMathEqAlign                     = 0x00000080,
    tomMathArgShadingStart             = 0x00000251,
    tomMathArgShadingEnd               = 0x00000252,
    tomMathObjShadingStart             = 0x00000253,
    tomMathObjShadingEnd               = 0x00000254,
    tomFunctionTypeNone                = 0x00000000,
    tomFunctionTypeTakesArg            = 0x00000001,
    tomFunctionTypeTakesLim            = 0x00000002,
    tomFunctionTypeTakesLim2           = 0x00000003,
    tomFunctionTypeIsLim               = 0x00000004,
    tomMathParaAlignDefault            = 0x00000000,
    tomMathParaAlignCenterGroup        = 0x00000001,
    tomMathParaAlignCenter             = 0x00000002,
    tomMathParaAlignLeft               = 0x00000003,
    tomMathParaAlignRight              = 0x00000004,
    tomMathDispAlignMask               = 0x00000003,
    tomMathDispAlignCenterGroup        = 0x00000000,
    tomMathDispAlignCenter             = 0x00000001,
    tomMathDispAlignLeft               = 0x00000002,
    tomMathDispAlignRight              = 0x00000003,
    tomMathDispIntUnderOver            = 0x00000004,
    tomMathDispFracTeX                 = 0x00000008,
    tomMathDispNaryGrow                = 0x00000010,
    tomMathDocEmptyArgMask             = 0x00000060,
    tomMathDocEmptyArgAuto             = 0x00000000,
    tomMathDocEmptyArgAlways           = 0x00000020,
    tomMathDocEmptyArgNever            = 0x00000040,
    tomMathDocSbSpOpUnchanged          = 0x00000080,
    tomMathDocDiffMask                 = 0x00000300,
    tomMathDocDiffDefault              = 0x00000000,
    tomMathDocDiffUpright              = 0x00000100,
    tomMathDocDiffItalic               = 0x00000200,
    tomMathDocDiffOpenItalic           = 0x00000300,
    tomMathDispNarySubSup              = 0x00000400,
    tomMathDispDef                     = 0x00000800,
    tomMathEnableRtl                   = 0x00001000,
    tomMathBrkBinMask                  = 0x00030000,
    tomMathBrkBinBefore                = 0x00000000,
    tomMathBrkBinAfter                 = 0x00010000,
    tomMathBrkBinDup                   = 0x00020000,
    tomMathBrkBinSubMask               = 0x000c0000,
    tomMathBrkBinSubMM                 = 0x00000000,
    tomMathBrkBinSubPM                 = 0x00040000,
    tomMathBrkBinSubMP                 = 0x00080000,
    tomSelRange                        = 0x00000255,
    tomHstring                         = 0x00000254,
    tomFontPropTeXStyle                = 0x0000033c,
    tomFontPropAlign                   = 0x0000033d,
    tomFontStretch                     = 0x0000033e,
    tomFontStyle                       = 0x0000033f,
    tomFontStyleUpright                = 0x00000000,
    tomFontStyleOblique                = 0x00000001,
    tomFontStyleItalic                 = 0x00000002,
    tomFontStretchDefault              = 0x00000000,
    tomFontStretchUltraCondensed       = 0x00000001,
    tomFontStretchExtraCondensed       = 0x00000002,
    tomFontStretchCondensed            = 0x00000003,
    tomFontStretchSemiCondensed        = 0x00000004,
    tomFontStretchNormal               = 0x00000005,
    tomFontStretchSemiExpanded         = 0x00000006,
    tomFontStretchExpanded             = 0x00000007,
    tomFontStretchExtraExpanded        = 0x00000008,
    tomFontStretchUltraExpanded        = 0x00000009,
    tomFontWeightDefault               = 0x00000000,
    tomFontWeightThin                  = 0x00000064,
    tomFontWeightExtraLight            = 0x000000c8,
    tomFontWeightLight                 = 0x0000012c,
    tomFontWeightNormal                = 0x00000190,
    tomFontWeightRegular               = 0x00000190,
    tomFontWeightMedium                = 0x000001f4,
    tomFontWeightSemiBold              = 0x00000258,
    tomFontWeightBold                  = 0x000002bc,
    tomFontWeightExtraBold             = 0x00000320,
    tomFontWeightBlack                 = 0x00000384,
    tomFontWeightHeavy                 = 0x00000384,
    tomFontWeightExtraBlack            = 0x000003b6,
    tomParaPropMathAlign               = 0x00000437,
    tomDocMathBuild                    = 0x00000080,
    tomMathLMargin                     = 0x00000081,
    tomMathRMargin                     = 0x00000082,
    tomMathWrapIndent                  = 0x00000083,
    tomMathWrapRight                   = 0x00000084,
    tomMathPostSpace                   = 0x00000086,
    tomMathPreSpace                    = 0x00000085,
    tomMathInterSpace                  = 0x00000087,
    tomMathIntraSpace                  = 0x00000088,
    tomCanCopy                         = 0x00000089,
    tomCanRedo                         = 0x0000008a,
    tomCanUndo                         = 0x0000008b,
    tomUndoLimit                       = 0x0000008c,
    tomDocAutoLink                     = 0x0000008d,
    tomEllipsisMode                    = 0x0000008e,
    tomEllipsisState                   = 0x0000008f,
    tomEllipsisNone                    = 0x00000000,
    tomEllipsisEnd                     = 0x00000001,
    tomEllipsisWord                    = 0x00000003,
    tomEllipsisPresent                 = 0x00000001,
    tomVTopCell                        = 0x00000001,
    tomVLowCell                        = 0x00000002,
    tomHStartCell                      = 0x00000004,
    tomHContCell                       = 0x00000008,
    tomRowUpdate                       = 0x00000001,
    tomRowApplyDefault                 = 0x00000000,
    tomCellStructureChangeOnly         = 0x00000001,
    tomRowHeightActual                 = 0x0000080b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/ne-tom-objecttype
alias OBJECTTYPE = int;
enum : int
{
    tomSimpleText       = 0x00000000,
    tomRuby             = 0x00000001,
    tomHorzVert         = 0x00000002,
    tomWarichu          = 0x00000003,
    tomEq               = 0x00000009,
    tomMath             = 0x0000000a,
    tomAccent           = 0x0000000a,
    tomBox              = 0x0000000b,
    tomBoxedFormula     = 0x0000000c,
    tomBrackets         = 0x0000000d,
    tomBracketsWithSeps = 0x0000000e,
    tomEquationArray    = 0x0000000f,
    tomFraction         = 0x00000010,
    tomFunctionApply    = 0x00000011,
    tomLeftSubSup       = 0x00000012,
    tomLowerLimit       = 0x00000013,
    tomMatrix           = 0x00000014,
    tomNary             = 0x00000015,
    tomOpChar           = 0x00000016,
    tomOverbar          = 0x00000017,
    tomPhantom          = 0x00000018,
    tomRadical          = 0x00000019,
    tomSlashedFraction  = 0x0000001a,
    tomStack            = 0x0000001b,
    tomStretchStack     = 0x0000001c,
    tomSubscript        = 0x0000001d,
    tomSubSup           = 0x0000001e,
    tomSuperscript      = 0x0000001f,
    tomUnderbar         = 0x00000020,
    tomUpperLimit       = 0x00000021,
    tomObjectMax        = 0x00000021,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/ne-tom-mancode
alias MANCODE = int;
enum : int
{
    MBOLD   = 0x00000010,
    MITAL   = 0x00000020,
    MGREEK  = 0x00000040,
    MROMN   = 0x00000000,
    MSCRP   = 0x00000001,
    MFRAK   = 0x00000002,
    MOPEN   = 0x00000003,
    MSANS   = 0x00000004,
    MMONO   = 0x00000005,
    MMATH   = 0x00000006,
    MISOL   = 0x00000007,
    MINIT   = 0x00000008,
    MTAIL   = 0x00000009,
    MSTRCH  = 0x0000000a,
    MLOOP   = 0x0000000b,
    MOPENA  = 0x0000000c,
}

// Constants


enum uint cchTextLimitDefault = 0x00007fffU;
enum const(wchar)* MSFTEDIT_CLASS = "RICHEDIT50W";

enum : const(wchar)*
{
    // Native encoding: ansi
    CERICHEDIT_CLASSA = "RichEditCEA",
    CERICHEDIT_CLASSW = "RichEditCEW",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    RICHEDIT_CLASSA   = "RichEdit20A",
    // Native encoding: ansi
    RICHEDIT_CLASS10A = "RICHEDIT",
    RICHEDIT_CLASSW   = "RichEdit20W",
    RICHEDIT_CLASS    = "RichEdit20W",
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-canpaste
enum uint EM_CANPASTE = 0x00000432U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-displayband
enum uint EM_DISPLAYBAND = 0x00000433U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-exgetsel
    EM_EXGETSEL       = 0x00000434U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-exlimittext
    EM_EXLIMITTEXT    = 0x00000435U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-exlinefromchar
    EM_EXLINEFROMCHAR = 0x00000436U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-exsetsel
enum uint EM_EXSETSEL = 0x00000437U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-findtext
enum uint EM_FINDTEXT = 0x00000438U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-formatrange
enum uint EM_FORMATRANGE = 0x00000439U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getcharformat
enum uint EM_GETCHARFORMAT = 0x0000043aU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-geteventmask
enum uint EM_GETEVENTMASK = 0x0000043bU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getoleinterface
enum uint EM_GETOLEINTERFACE = 0x0000043cU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getparaformat
enum uint EM_GETPARAFORMAT = 0x0000043dU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getseltext
enum uint EM_GETSELTEXT = 0x0000043eU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-hideselection
enum uint EM_HIDESELECTION = 0x0000043fU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-pastespecial
enum uint EM_PASTESPECIAL = 0x00000440U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-requestresize
enum uint EM_REQUESTRESIZE = 0x00000441U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-selectiontype
enum uint EM_SELECTIONTYPE = 0x00000442U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setbkgndcolor
enum uint EM_SETBKGNDCOLOR = 0x00000443U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setcharformat
enum uint EM_SETCHARFORMAT = 0x00000444U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-seteventmask
enum uint EM_SETEVENTMASK = 0x00000445U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setolecallback
enum uint EM_SETOLECALLBACK = 0x00000446U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setparaformat
enum uint EM_SETPARAFORMAT = 0x00000447U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-settargetdevice
enum uint EM_SETTARGETDEVICE = 0x00000448U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-streamin
    EM_STREAMIN  = 0x00000449U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-streamout
    EM_STREAMOUT = 0x0000044aU,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-gettextrange
enum uint EM_GETTEXTRANGE = 0x0000044bU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-findwordbreak
enum uint EM_FINDWORDBREAK = 0x0000044cU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setoptions
enum uint EM_SETOPTIONS = 0x0000044dU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getoptions
enum uint EM_GETOPTIONS = 0x0000044eU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-findtextex
enum uint EM_FINDTEXTEX = 0x0000044fU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getwordbreakprocex
enum uint EM_GETWORDBREAKPROCEX = 0x00000450U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setwordbreakprocex
enum uint EM_SETWORDBREAKPROCEX = 0x00000451U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setundolimit
enum uint EM_SETUNDOLIMIT = 0x00000452U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-redo
    EM_REDO    = 0x00000454U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-canredo
    EM_CANREDO = 0x00000455U,
}

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getundoname
    EM_GETUNDONAME = 0x00000456U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getredoname
    EM_GETREDONAME = 0x00000457U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-stopgrouptyping
enum uint EM_STOPGROUPTYPING = 0x00000458U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-settextmode
enum uint EM_SETTEXTMODE = 0x00000459U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-gettextmode
enum uint EM_GETTEXTMODE = 0x0000045aU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-autourldetect
enum uint EM_AUTOURLDETECT = 0x0000045bU;

enum : uint
{
    AURL_ENABLEURL          = 0x00000001U,
    AURL_ENABLEEMAILADDR    = 0x00000002U,
    AURL_ENABLETELNO        = 0x00000004U,
    AURL_ENABLEEAURLS       = 0x00000008U,
    AURL_ENABLEDRIVELETTERS = 0x00000010U,
}

enum uint AURL_DISABLEMIXEDLGC = 0x00000020U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getautourldetect
enum uint EM_GETAUTOURLDETECT = 0x0000045cU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setpalette
enum uint EM_SETPALETTE = 0x0000045dU;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-gettextex
    EM_GETTEXTEX       = 0x0000045eU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-gettextlengthex
    EM_GETTEXTLENGTHEX = 0x0000045fU,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-showscrollbar
enum uint EM_SHOWSCROLLBAR = 0x00000460U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-settextex
    EM_SETTEXTEX      = 0x00000461U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setpunctuation
    EM_SETPUNCTUATION = 0x00000464U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getpunctuation
enum uint EM_GETPUNCTUATION = 0x00000465U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setwordwrapmode
enum uint EM_SETWORDWRAPMODE = 0x00000466U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getwordwrapmode
enum uint EM_GETWORDWRAPMODE = 0x00000467U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setimecolor
enum uint EM_SETIMECOLOR = 0x00000468U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getimecolor
enum uint EM_GETIMECOLOR = 0x00000469U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setimeoptions
enum uint EM_SETIMEOPTIONS = 0x0000046aU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getimeoptions
enum uint EM_GETIMEOPTIONS = 0x0000046bU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-convposition
enum uint EM_CONVPOSITION = 0x0000046cU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setlangoptions
enum uint EM_SETLANGOPTIONS = 0x00000478U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getlangoptions
enum uint EM_GETLANGOPTIONS = 0x00000479U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getimecompmode
enum uint EM_GETIMECOMPMODE = 0x0000047aU;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-findtextw
    EM_FINDTEXTW   = 0x0000047bU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-findtextexw
    EM_FINDTEXTEXW = 0x0000047cU,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-reconversion
enum uint EM_RECONVERSION = 0x0000047dU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setimemodebias
enum uint EM_SETIMEMODEBIAS = 0x0000047eU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getimemodebias
enum uint EM_GETIMEMODEBIAS = 0x0000047fU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setbidioptions
enum uint EM_SETBIDIOPTIONS = 0x000004c8U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getbidioptions
enum uint EM_GETBIDIOPTIONS = 0x000004c9U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-settypographyoptions
enum uint EM_SETTYPOGRAPHYOPTIONS = 0x000004caU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-gettypographyoptions
enum uint EM_GETTYPOGRAPHYOPTIONS = 0x000004cbU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-seteditstyle
enum uint EM_SETEDITSTYLE = 0x000004ccU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-geteditstyle
enum uint EM_GETEDITSTYLE = 0x000004cdU;
enum uint SES_EMULATESYSEDIT = 0x00000001U;
enum uint SES_BEEPONMAXTEXT = 0x00000002U;
enum uint SES_EXTENDBACKCOLOR = 0x00000004U;
enum uint SES_MAPCPS = 0x00000008U;
enum uint SES_HYPERLINKTOOLTIPS = 0x00000008U;
enum uint SES_EMULATE10 = 0x00000010U;
enum uint SES_DEFAULTLATINLIGA = 0x00000010U;
enum uint SES_USECRLF = 0x00000020U;
enum uint SES_NOFOCUSLINKNOTIFY = 0x00000020U;
enum uint SES_USEAIMM = 0x00000040U;

enum : uint
{
    SES_NOIME      = 0x00000080U,
    SES_ALLOWBEEPS = 0x00000100U,
}

enum uint SES_UPPERCASE = 0x00000200U;
enum uint SES_LOWERCASE = 0x00000400U;
enum uint SES_NOINPUTSEQUENCECHK = 0x00000800U;

enum : uint
{
    SES_BIDI              = 0x00001000U,
    SES_SCROLLONKILLFOCUS = 0x00002000U,
}

enum uint SES_XLTCRCRLFTOCR = 0x00004000U;
enum uint SES_DRAFTMODE = 0x00008000U;
enum uint SES_USECTF = 0x00010000U;
enum uint SES_HIDEGRIDLINES = 0x00020000U;
enum uint SES_USEATFONT = 0x00040000U;
enum uint SES_CUSTOMLOOK = 0x00080000U;
enum uint SES_LBSCROLLNOTIFY = 0x00100000U;

enum : uint
{
    SES_CTFALLOWEMBED    = 0x00200000U,
    SES_CTFALLOWSMARTTAG = 0x00400000U,
    SES_CTFALLOWPROOFING = 0x00800000U,
}

enum uint SES_LOGICALCARET = 0x01000000U;
enum uint SES_WORDDRAGDROP = 0x02000000U;
enum uint SES_SMARTDRAGDROP = 0x04000000U;
enum uint SES_MULTISELECT = 0x08000000U;
enum uint SES_CTFNOLOCK = 0x10000000U;
enum uint SES_NOEALINEHEIGHTADJUST = 0x20000000U;
enum uint SES_MAX = 0x20000000U;

enum : uint
{
    IMF_AUTOKEYBOARD = 0x00000001U,
    IMF_AUTOFONT     = 0x00000002U,
}

enum uint IMF_IMECANCELCOMPLETE = 0x00000004U;
enum uint IMF_IMEALWAYSSENDNOTIFY = 0x00000008U;
enum uint IMF_AUTOFONTSIZEADJUST = 0x00000010U;
enum uint IMF_UIFONTS = 0x00000020U;
enum uint IMF_NOIMPLICITLANG = 0x00000040U;
enum uint IMF_DUALFONT = 0x00000080U;
enum uint IMF_NOKBDLIDFIXUP = 0x00000200U;
enum uint IMF_NORTFFONTSUBSTITUTE = 0x00000400U;
enum uint IMF_SPELLCHECKING = 0x00000800U;
enum uint IMF_TKBPREDICTION = 0x00001000U;
enum uint IMF_IMEUIINTEGRATION = 0x00002000U;
enum uint ICM_NOTOPEN = 0x00000000U;

enum : uint
{
    ICM_LEVEL3     = 0x00000001U,
    ICM_LEVEL2     = 0x00000002U,
    ICM_LEVEL2_5   = 0x00000003U,
    ICM_LEVEL2_SUI = 0x00000004U,
}

enum uint ICM_CTF = 0x00000005U;
enum uint TO_ADVANCEDTYPOGRAPHY = 0x00000001U;
enum uint TO_SIMPLELINEBREAK = 0x00000002U;
enum uint TO_DISABLECUSTOMTEXTOUT = 0x00000004U;
enum uint TO_ADVANCEDLAYOUT = 0x00000008U;
enum uint EM_OUTLINE = 0x000004dcU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getscrollpos
enum uint EM_GETSCROLLPOS = 0x000004ddU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setscrollpos
enum uint EM_SETSCROLLPOS = 0x000004deU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setfontsize
enum uint EM_SETFONTSIZE = 0x000004dfU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getzoom
enum uint EM_GETZOOM = 0x000004e0U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setzoom
enum uint EM_SETZOOM = 0x000004e1U;
enum uint EM_GETVIEWKIND = 0x000004e2U;
enum uint EM_SETVIEWKIND = 0x000004e3U;
enum uint EM_GETPAGE = 0x000004e4U;
enum uint EM_SETPAGE = 0x000004e5U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-gethyphenateinfo
enum uint EM_GETHYPHENATEINFO = 0x000004e6U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-sethyphenateinfo
enum uint EM_SETHYPHENATEINFO = 0x000004e7U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getpagerotate
enum uint EM_GETPAGEROTATE = 0x000004ebU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setpagerotate
enum uint EM_SETPAGEROTATE = 0x000004ecU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getctfmodebias
enum uint EM_GETCTFMODEBIAS = 0x000004edU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setctfmodebias
enum uint EM_SETCTFMODEBIAS = 0x000004eeU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getctfopenstatus
enum uint EM_GETCTFOPENSTATUS = 0x000004f0U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setctfopenstatus
enum uint EM_SETCTFOPENSTATUS = 0x000004f1U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getimecomptext
enum uint EM_GETIMECOMPTEXT = 0x000004f2U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-isime
enum uint EM_ISIME = 0x000004f3U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getimeproperty
enum uint EM_GETIMEPROPERTY = 0x000004f4U;
enum uint EM_GETQUERYRTFOBJ = 0x0000050dU;

enum : uint
{
    EM_SETQUERYRTFOBJ                 = 0x0000050eU,
    EM_SETQUERYCONVERTOLELINKCALLBACK = 0x00000593U,
}

enum uint EM_SETDISABLEOLELINKCONVERSION = 0x00000594U;

enum : uint
{
    EPR_0   = 0x00000000U,
    EPR_270 = 0x00000001U,
    EPR_180 = 0x00000002U,
    EPR_90  = 0x00000003U,
    EPR_SE  = 0x00000005U,
}

enum : uint
{
    CTFMODEBIAS_DEFAULT               = 0x00000000U,
    CTFMODEBIAS_FILENAME              = 0x00000001U,
    CTFMODEBIAS_NAME                  = 0x00000002U,
    CTFMODEBIAS_READING               = 0x00000003U,
    CTFMODEBIAS_DATETIME              = 0x00000004U,
    CTFMODEBIAS_CONVERSATION          = 0x00000005U,
    CTFMODEBIAS_NUMERIC               = 0x00000006U,
    CTFMODEBIAS_HIRAGANA              = 0x00000007U,
    CTFMODEBIAS_KATAKANA              = 0x00000008U,
    CTFMODEBIAS_HANGUL                = 0x00000009U,
    CTFMODEBIAS_HALFWIDTHKATAKANA     = 0x0000000aU,
    CTFMODEBIAS_FULLWIDTHALPHANUMERIC = 0x0000000bU,
}

enum uint CTFMODEBIAS_HALFWIDTHALPHANUMERIC = 0x0000000cU;

enum : uint
{
    IMF_SMODE_PLAURALCLAUSE = 0x00000001U,
    IMF_SMODE_NONE          = 0x00000002U,
}

enum : uint
{
    EMO_EXIT    = 0x00000000U,
    EMO_ENTER   = 0x00000001U,
    EMO_PROMOTE = 0x00000002U,
}

enum uint EMO_EXPAND = 0x00000003U;
enum uint EMO_MOVESELECTION = 0x00000004U;
enum uint EMO_GETVIEWMODE = 0x00000005U;

enum : uint
{
    EMO_EXPANDSELECTION = 0x00000000U,
    EMO_EXPANDDOCUMENT  = 0x00000001U,
}

enum uint VM_NORMAL = 0x00000004U;
enum uint VM_OUTLINE = 0x00000002U;
enum uint VM_PAGE = 0x00000009U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-inserttable
enum uint EM_INSERTTABLE = 0x000004e8U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getautocorrectproc
enum uint EM_GETAUTOCORRECTPROC = 0x000004e9U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setautocorrectproc
enum uint EM_SETAUTOCORRECTPROC = 0x000004eaU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-callautocorrectproc
enum uint EM_CALLAUTOCORRECTPROC = 0x000004ffU;
enum uint ATP_NOCHANGE = 0x00000000U;
enum uint ATP_CHANGE = 0x00000001U;
enum uint ATP_NODELIMITER = 0x00000002U;
enum uint ATP_REPLACEALLTEXT = 0x00000004U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-gettableparms
enum uint EM_GETTABLEPARMS = 0x00000509U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-seteditstyleex
enum uint EM_SETEDITSTYLEEX = 0x00000513U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-geteditstyleex
enum uint EM_GETEDITSTYLEEX = 0x00000514U;

enum : uint
{
    SES_EX_NOTABLE           = 0x00000004U,
    SES_EX_NOMATH            = 0x00000040U,
    SES_EX_HANDLEFRIENDLYURL = 0x00000100U,
}

enum : uint
{
    SES_EX_NOTHEMING          = 0x00080000U,
    SES_EX_NOACETATESELECTION = 0x00100000U,
}

enum uint SES_EX_USESINGLELINE = 0x00200000U;

enum : uint
{
    SES_EX_MULTITOUCH     = 0x08000000U,
    SES_EX_HIDETEMPFORMAT = 0x10000000U,
}

enum uint SES_EX_USEMOUSEWPARAM = 0x20000000U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getstorytype
enum uint EM_GETSTORYTYPE = 0x00000522U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setstorytype
enum uint EM_SETSTORYTYPE = 0x00000523U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getellipsismode
enum uint EM_GETELLIPSISMODE = 0x00000531U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setellipsismode
enum uint EM_SETELLIPSISMODE = 0x00000532U;

enum : uint
{
    ELLIPSIS_MASK = 0x00000003U,
    ELLIPSIS_NONE = 0x00000000U,
    ELLIPSIS_END  = 0x00000001U,
    ELLIPSIS_WORD = 0x00000003U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-settableparms
enum uint EM_SETTABLEPARMS = 0x00000533U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-gettouchoptions
enum uint EM_GETTOUCHOPTIONS = 0x00000536U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-settouchoptions
enum uint EM_SETTOUCHOPTIONS = 0x00000537U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-insertimage
enum uint EM_INSERTIMAGE = 0x0000053aU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-setuianame
enum uint EM_SETUIANAME = 0x00000540U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/em-getellipsisstate
enum uint EM_GETELLIPSISSTATE = 0x00000542U;
enum uint RTO_SHOWHANDLES = 0x00000001U;
enum uint RTO_DISABLEHANDLES = 0x00000002U;
enum uint RTO_READINGMODE = 0x00000003U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/en-msgfilter
enum uint EN_MSGFILTER = 0x00000700U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/en-requestresize
enum uint EN_REQUESTRESIZE = 0x00000701U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/en-selchange
enum uint EN_SELCHANGE = 0x00000702U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/en-dropfiles
enum uint EN_DROPFILES = 0x00000703U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/en-protected
enum uint EN_PROTECTED = 0x00000704U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/en-correcttext
enum uint EN_CORRECTTEXT = 0x00000705U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/en-stopnoundo
enum uint EN_STOPNOUNDO = 0x00000706U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/en-imechange
enum uint EN_IMECHANGE = 0x00000707U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/en-saveclipboard
enum uint EN_SAVECLIPBOARD = 0x00000708U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/en-oleopfailed
enum uint EN_OLEOPFAILED = 0x00000709U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/en-objectpositions
enum uint EN_OBJECTPOSITIONS = 0x0000070aU;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/en-link
    EN_LINK         = 0x0000070bU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/en-dragdropdone
    EN_DRAGDROPDONE = 0x0000070cU,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/en-paragraphexpanded
enum uint EN_PARAGRAPHEXPANDED = 0x0000070dU;
enum uint EN_PAGECHANGE = 0x0000070eU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/en-lowfirtf
enum uint EN_LOWFIRTF = 0x0000070fU;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/en-alignltr
    EN_ALIGNLTR = 0x00000710U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/en-alignrtl
    EN_ALIGNRTL = 0x00000711U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/en-clipformat
enum uint EN_CLIPFORMAT = 0x00000712U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/en-startcomposition
enum uint EN_STARTCOMPOSITION = 0x00000713U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Controls/en-endcomposition
enum uint EN_ENDCOMPOSITION = 0x00000714U;

enum : uint
{
    ENM_NONE   = 0x00000000U,
    ENM_CHANGE = 0x00000001U,
}

enum uint ENM_UPDATE = 0x00000002U;

enum : uint
{
    ENM_SCROLL       = 0x00000004U,
    ENM_SCROLLEVENTS = 0x00000008U,
}

enum uint ENM_DRAGDROPDONE = 0x00000010U;
enum uint ENM_PARAGRAPHEXPANDED = 0x00000020U;
enum uint ENM_PAGECHANGE = 0x00000040U;
enum uint ENM_CLIPFORMAT = 0x00000080U;
enum uint ENM_KEYEVENTS = 0x00010000U;
enum uint ENM_MOUSEEVENTS = 0x00020000U;
enum uint ENM_REQUESTRESIZE = 0x00040000U;
enum uint ENM_SELCHANGE = 0x00080000U;
enum uint ENM_DROPFILES = 0x00100000U;
enum uint ENM_PROTECTED = 0x00200000U;
enum uint ENM_CORRECTTEXT = 0x00400000U;
enum uint ENM_IMECHANGE = 0x00800000U;
enum uint ENM_LANGCHANGE = 0x01000000U;
enum uint ENM_OBJECTPOSITIONS = 0x02000000U;

enum : uint
{
    ENM_LINK     = 0x04000000U,
    ENM_LOWFIRTF = 0x08000000U,
}

enum uint ENM_STARTCOMPOSITION = 0x10000000U;
enum uint ENM_ENDCOMPOSITION = 0x20000000U;
enum uint ENM_GROUPTYPINGCHANGE = 0x40000000U;
enum uint ENM_HIDELINKTOOLTIP = 0x80000000U;
enum uint ES_SAVESEL = 0x00008000U;
enum uint ES_SUNKEN = 0x00004000U;
enum uint ES_DISABLENOSCROLL = 0x00002000U;
enum uint ES_SELECTIONBAR = 0x01000000U;
enum uint ES_NOOLEDRAGDROP = 0x00000008U;
enum uint ES_EX_NOCALLOLEINIT = 0x00000000U;
enum uint ES_VERTICAL = 0x00400000U;
enum uint ES_NOIME = 0x00080000U;
enum uint ES_SELFIME = 0x00040000U;
enum uint ECO_AUTOWORDSELECTION = 0x00000001U;

enum : uint
{
    ECO_AUTOVSCROLL = 0x00000040U,
    ECO_AUTOHSCROLL = 0x00000080U,
}

enum uint ECO_NOHIDESEL = 0x00000100U;
enum uint ECO_READONLY = 0x00000800U;
enum uint ECO_WANTRETURN = 0x00001000U;

enum : uint
{
    ECO_SAVESEL      = 0x00008000U,
    ECO_SELECTIONBAR = 0x01000000U,
}

enum uint ECO_VERTICAL = 0x00400000U;

enum : uint
{
    ECOOP_SET = 0x00000001U,
    ECOOP_OR  = 0x00000002U,
    ECOOP_AND = 0x00000003U,
    ECOOP_XOR = 0x00000004U,
}

enum : uint
{
    WB_MOVEWORDPREV = 0x00000004U,
    WB_MOVEWORDNEXT = 0x00000005U,
}

enum uint WB_PREVBREAK = 0x00000006U;
enum uint WB_NEXTBREAK = 0x00000007U;
enum uint PC_FOLLOWING = 0x00000001U;
enum uint PC_LEADING = 0x00000002U;
enum uint PC_OVERFLOW = 0x00000003U;
enum uint PC_DELIMITER = 0x00000004U;

enum : uint
{
    WBF_WORDWRAP  = 0x00000010U,
    WBF_WORDBREAK = 0x00000020U,
}

enum uint WBF_OVERFLOW = 0x00000040U;

enum : uint
{
    WBF_LEVEL1 = 0x00000080U,
    WBF_LEVEL2 = 0x00000100U,
}

enum uint WBF_CUSTOM = 0x00000200U;

enum : uint
{
    IMF_FORCENONE    = 0x00000001U,
    IMF_FORCEENABLE  = 0x00000002U,
    IMF_FORCEDISABLE = 0x00000004U,
}

enum uint IMF_CLOSESTATUSWINDOW = 0x00000008U;
enum uint IMF_VERTICAL = 0x00000020U;

enum : uint
{
    IMF_FORCEACTIVE   = 0x00000040U,
    IMF_FORCEINACTIVE = 0x00000080U,
    IMF_FORCEREMEMBER = 0x00000100U,
}

enum uint IMF_MULTIPLEEDIT = 0x00000400U;
enum uint yHeightCharPtsMost = 0x00000666U;
enum uint SCF_SELECTION = 0x00000001U;

enum : uint
{
    SCF_WORD    = 0x00000002U,
    SCF_DEFAULT = 0x00000000U,
}

enum : uint
{
    SCF_ALL        = 0x00000004U,
    SCF_USEUIRULES = 0x00000008U,
}

enum uint SCF_ASSOCIATEFONT = 0x00000010U;
enum uint SCF_NOKBUPDATE = 0x00000020U;
enum uint SCF_ASSOCIATEFONT2 = 0x00000040U;
enum uint SCF_SMARTFONT = 0x00000080U;
enum uint SCF_CHARREPFROMLCID = 0x00000100U;
enum uint SPF_DONTSETDEFAULT = 0x00000002U;
enum uint SPF_SETDEFAULT = 0x00000004U;

enum : uint
{
    SF_TEXT      = 0x00000001U,
    SF_RTF       = 0x00000002U,
    SF_RTFNOOBJS = 0x00000003U,
}

enum uint SF_TEXTIZED = 0x00000004U;
enum uint SF_UNICODE = 0x00000010U;
enum uint SF_USECODEPAGE = 0x00000020U;
enum uint SF_NCRFORNONASCII = 0x00000040U;
enum uint SFF_WRITEXTRAPAR = 0x00000080U;
enum uint SFF_SELECTION = 0x00008000U;

enum : uint
{
    SFF_PLAINRTF         = 0x00004000U,
    SFF_PERSISTVIEWSCALE = 0x00002000U,
}

enum uint SFF_KEEPDOCINFO = 0x00001000U;
enum uint SFF_PWD = 0x00000800U;
enum uint SF_RTFVAL = 0x00000700U;
enum uint MAX_TAB_STOPS = 0x00000020U;
enum uint lDefaultTab = 0x000002d0U;
enum uint MAX_TABLE_CELLS = 0x0000003fU;

enum : uint
{
    GCMF_GRIPPER  = 0x00000001U,
    GCMF_SPELLING = 0x00000002U,
}

enum uint GCMF_TOUCHMENU = 0x00004000U;
enum uint GCMF_MOUSEMENU = 0x00002000U;
enum uint OLEOP_DOVERB = 0x00000001U;

enum : const(wchar)*
{
    CF_RTF       = "Rich Text Format",
    CF_RTFNOOBJS = "Rich Text Format Without Objects",
}

enum const(wchar)* CF_RETEXTOBJ = "RichEdit Text and Objects";
enum uint ST_DEFAULT = 0x00000000U;
enum uint ST_KEEPUNDO = 0x00000001U;
enum uint ST_SELECTION = 0x00000002U;
enum uint ST_NEWCHARS = 0x00000004U;
enum uint ST_UNICODE = 0x00000008U;
enum uint BOM_DEFPARADIR = 0x00000001U;
enum uint BOM_PLAINTEXT = 0x00000002U;
enum uint BOM_NEUTRALOVERRIDE = 0x00000004U;

enum : uint
{
    BOM_CONTEXTREADING   = 0x00000008U,
    BOM_CONTEXTALIGNMENT = 0x00000010U,
}

enum uint BOM_LEGACYBIDICLASS = 0x00000040U;
enum uint BOM_UNICODEBIDI = 0x00000080U;
enum uint BOE_RTLDIR = 0x00000001U;
enum uint BOE_PLAINTEXT = 0x00000002U;
enum uint BOE_NEUTRALOVERRIDE = 0x00000004U;

enum : uint
{
    BOE_CONTEXTREADING   = 0x00000008U,
    BOE_CONTEXTALIGNMENT = 0x00000010U,
}

enum uint BOE_FORCERECALC = 0x00000020U;
enum uint BOE_LEGACYBIDICLASS = 0x00000040U;
enum uint BOE_UNICODEBIDI = 0x00000080U;
enum const(wchar)* RICHEDIT60_CLASS = "RICHEDIT60W";
enum uint AURL_ENABLEEA = 0x00000001U;
enum uint GCM_TOUCHMENU = 0x00004000U;
enum uint GCM_MOUSEMENU = 0x00002000U;
enum HRESULT S_MSG_KEY_IGNORED = HRESULT(0x00040201);

enum : uint
{
    TXTBIT_RICHTEXT        = 0x00000001U,
    TXTBIT_MULTILINE       = 0x00000002U,
    TXTBIT_READONLY        = 0x00000004U,
    TXTBIT_SHOWACCELERATOR = 0x00000008U,
}

enum uint TXTBIT_USEPASSWORD = 0x00000010U;
enum uint TXTBIT_HIDESELECTION = 0x00000020U;
enum uint TXTBIT_SAVESELECTION = 0x00000040U;
enum uint TXTBIT_AUTOWORDSEL = 0x00000080U;

enum : uint
{
    TXTBIT_VERTICAL     = 0x00000100U,
    TXTBIT_SELBARCHANGE = 0x00000200U,
}

enum : uint
{
    TXTBIT_WORDWRAP    = 0x00000400U,
    TXTBIT_ALLOWBEEP   = 0x00000800U,
    TXTBIT_DISABLEDRAG = 0x00001000U,
}

enum uint TXTBIT_VIEWINSETCHANGE = 0x00002000U;
enum uint TXTBIT_BACKSTYLECHANGE = 0x00004000U;
enum uint TXTBIT_MAXLENGTHCHANGE = 0x00008000U;
enum uint TXTBIT_SCROLLBARCHANGE = 0x00010000U;
enum uint TXTBIT_CHARFORMATCHANGE = 0x00020000U;
enum uint TXTBIT_PARAFORMATCHANGE = 0x00040000U;
enum uint TXTBIT_EXTENTCHANGE = 0x00080000U;
enum uint TXTBIT_CLIENTRECTCHANGE = 0x00100000U;
enum uint TXTBIT_USECURRENTBKG = 0x00200000U;
enum uint TXTBIT_NOTHREADREFCOUNT = 0x00400000U;
enum uint TXTBIT_SHOWPASSWORD = 0x00800000U;

enum : uint
{
    TXTBIT_D2DDWRITE           = 0x01000000U,
    TXTBIT_D2DSIMPLETYPOGRAPHY = 0x02000000U,
}

enum : uint
{
    TXTBIT_D2DPIXELSNAPPED  = 0x04000000U,
    TXTBIT_D2DSUBPIXELLINES = 0x08000000U,
}

enum uint TXTBIT_FLASHLASTPASSWORDCHAR = 0x10000000U;
enum uint TXTBIT_ADVANCEDINPUT = 0x20000000U;
enum uint TXES_ISDIALOG = 0x00000001U;

enum : int
{
    REO_NULL          = 0x00000000,
    REO_READWRITEMASK = 0x000007ff,
}

// Callbacks

alias AutoCorrectProc = int function(ushort langid, const(PWSTR) pszBefore, PWSTR pszAfter, int cchAfter, 
                                     int* pcchReplaced);
alias EDITWORDBREAKPROCEX = int function(PSTR pchText, int cchText, ubyte bCharSet, int action);
alias EDITSTREAMCALLBACK = uint function(size_t dwCookie, ubyte* pbBuff, int cb, int* pcb);
alias PCreateTextServices = HRESULT function(IUnknown punkOuter, ITextHost pITextHost, IUnknown* ppUnk);
alias PShutdownTextServices = HRESULT function(IUnknown pTextServices);

// Structs


version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-richedit_image_parameters
    struct RICHEDIT_IMAGE_PARAMETERS
    {
    align (4):
        int          xWidth;
        int          yHeight;
        int          Ascent;
        int          Type;
        const(PWSTR) pwszAlternateText;
        IStream      pIStream;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-richedit_image_parameters
    struct RICHEDIT_IMAGE_PARAMETERS
    {
    align (4):
        int          xWidth;
        int          yHeight;
        int          Ascent;
        int          Type;
        const(PWSTR) pwszAlternateText;
        IStream      pIStream;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-endcompositionnotify
    struct ENDCOMPOSITIONNOTIFY
    {
    align (4):
        NMHDR nmhdr;
        ENDCOMPOSITIONNOTIFY_CODE dwCode;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-endcompositionnotify
    struct ENDCOMPOSITIONNOTIFY
    {
    align (4):
        NMHDR nmhdr;
        ENDCOMPOSITIONNOTIFY_CODE dwCode;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-textrangea
    struct TEXTRANGEA
    {
    align (4):
        CHARRANGE chrg;
        PSTR      lpstrText;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-textrangea
    struct TEXTRANGEA
    {
    align (4):
        CHARRANGE chrg;
        PSTR      lpstrText;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-textrangew
    struct TEXTRANGEW
    {
    align (4):
        CHARRANGE chrg;
        PWSTR     lpstrText;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-textrangew
    struct TEXTRANGEW
    {
    align (4):
        CHARRANGE chrg;
        PWSTR     lpstrText;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-editstream
    struct EDITSTREAM
    {
    align (4):
        size_t             dwCookie;
        uint               dwError;
        EDITSTREAMCALLBACK pfnCallback;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-editstream
    struct EDITSTREAM
    {
    align (4):
        size_t             dwCookie;
        uint               dwError;
        EDITSTREAMCALLBACK pfnCallback;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-findtexta
    struct FINDTEXTA
    {
    align (4):
        CHARRANGE   chrg;
        const(PSTR) lpstrText;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-findtexta
    struct FINDTEXTA
    {
    align (4):
        CHARRANGE   chrg;
        const(PSTR) lpstrText;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-findtextw
    struct FINDTEXTW
    {
    align (4):
        CHARRANGE    chrg;
        const(PWSTR) lpstrText;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-findtextw
    struct FINDTEXTW
    {
    align (4):
        CHARRANGE    chrg;
        const(PWSTR) lpstrText;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-findtextexa
    struct FINDTEXTEXA
    {
    align (4):
        CHARRANGE   chrg;
        const(PSTR) lpstrText;
        CHARRANGE   chrgText;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-findtextexa
    struct FINDTEXTEXA
    {
    align (4):
        CHARRANGE   chrg;
        const(PSTR) lpstrText;
        CHARRANGE   chrgText;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-findtextexw
    struct FINDTEXTEXW
    {
    align (4):
        CHARRANGE    chrg;
        const(PWSTR) lpstrText;
        CHARRANGE    chrgText;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-findtextexw
    struct FINDTEXTEXW
    {
    align (4):
        CHARRANGE    chrg;
        const(PWSTR) lpstrText;
        CHARRANGE    chrgText;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-formatrange
    struct FORMATRANGE
    {
    align (4):
        HDC       hdc;
        HDC       hdcTarget;
        RECT      rc;
        RECT      rcPage;
        CHARRANGE chrg;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-formatrange
    struct FORMATRANGE
    {
    align (4):
        HDC       hdc;
        HDC       hdcTarget;
        RECT      rc;
        RECT      rcPage;
        CHARRANGE chrg;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-msgfilter
    struct MSGFILTER
    {
    align (4):
        NMHDR  nmhdr;
        uint   msg;
        WPARAM wParam;
        LPARAM lParam;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-msgfilter
    struct MSGFILTER
    {
    align (4):
        NMHDR  nmhdr;
        uint   msg;
        WPARAM wParam;
        LPARAM lParam;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-reqresize
    struct REQRESIZE
    {
    align (4):
        NMHDR nmhdr;
        RECT  rc;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-reqresize
    struct REQRESIZE
    {
    align (4):
        NMHDR nmhdr;
        RECT  rc;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-selchange
    struct SELCHANGE
    {
    align (4):
        NMHDR     nmhdr;
        CHARRANGE chrg;
        RICH_EDIT_GET_CONTEXT_MENU_SEL_TYPE seltyp;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-selchange
    struct SELCHANGE
    {
    align (4):
        NMHDR     nmhdr;
        CHARRANGE chrg;
        RICH_EDIT_GET_CONTEXT_MENU_SEL_TYPE seltyp;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-clipboardformat
    struct CLIPBOARDFORMAT
    {
    align (4):
        NMHDR  nmhdr;
        ushort cf;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-clipboardformat
    struct CLIPBOARDFORMAT
    {
    align (4):
        NMHDR  nmhdr;
        ushort cf;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-getcontextmenuex
    struct GETCONTEXTMENUEX
    {
    align (4):
        CHARRANGE chrg;
        uint      dwFlags;
        POINT     pt;
        void*     pvReserved;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-getcontextmenuex
    struct GETCONTEXTMENUEX
    {
    align (4):
        CHARRANGE chrg;
        uint      dwFlags;
        POINT     pt;
        void*     pvReserved;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-endropfiles
    struct ENDROPFILES
    {
    align (4):
        NMHDR  nmhdr;
        HANDLE hDrop;
        int    cp;
        BOOL   fProtected;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-endropfiles
    struct ENDROPFILES
    {
    align (4):
        NMHDR  nmhdr;
        HANDLE hDrop;
        int    cp;
        BOOL   fProtected;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-enprotected
    struct ENPROTECTED
    {
    align (4):
        NMHDR     nmhdr;
        uint      msg;
        WPARAM    wParam;
        LPARAM    lParam;
        CHARRANGE chrg;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-enprotected
    struct ENPROTECTED
    {
    align (4):
        NMHDR     nmhdr;
        uint      msg;
        WPARAM    wParam;
        LPARAM    lParam;
        CHARRANGE chrg;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-ensaveclipboard
    struct ENSAVECLIPBOARD
    {
    align (4):
        NMHDR nmhdr;
        int   cObjectCount;
        int   cch;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-ensaveclipboard
    struct ENSAVECLIPBOARD
    {
    align (4):
        NMHDR nmhdr;
        int   cObjectCount;
        int   cch;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-enoleopfailed
    struct ENOLEOPFAILED
    {
    align (4):
        NMHDR   nmhdr;
        int     iob;
        int     lOper;
        HRESULT hr;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-enoleopfailed
    struct ENOLEOPFAILED
    {
    align (4):
        NMHDR   nmhdr;
        int     iob;
        int     lOper;
        HRESULT hr;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-objectpositions
    struct OBJECTPOSITIONS
    {
    align (4):
        NMHDR nmhdr;
        int   cObjectCount;
        int*  pcpPositions;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-objectpositions
    struct OBJECTPOSITIONS
    {
    align (4):
        NMHDR nmhdr;
        int   cObjectCount;
        int*  pcpPositions;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-enlink
    struct ENLINK
    {
    align (4):
        NMHDR     nmhdr;
        uint      msg;
        WPARAM    wParam;
        LPARAM    lParam;
        CHARRANGE chrg;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-enlink
    struct ENLINK
    {
    align (4):
        NMHDR     nmhdr;
        uint      msg;
        WPARAM    wParam;
        LPARAM    lParam;
        CHARRANGE chrg;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-enlowfirtf
    struct ENLOWFIRTF
    {
    align (4):
        NMHDR nmhdr;
        PSTR  szControl;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-enlowfirtf
    struct ENLOWFIRTF
    {
    align (4):
        NMHDR nmhdr;
        PSTR  szControl;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-encorrecttext
    struct ENCORRECTTEXT
    {
    align (4):
        NMHDR     nmhdr;
        CHARRANGE chrg;
        RICH_EDIT_GET_CONTEXT_MENU_SEL_TYPE seltyp;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-encorrecttext
    struct ENCORRECTTEXT
    {
    align (4):
        NMHDR     nmhdr;
        CHARRANGE chrg;
        RICH_EDIT_GET_CONTEXT_MENU_SEL_TYPE seltyp;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-punctuation
    struct PUNCTUATION
    {
    align (4):
        uint iSize;
        PSTR szPunctuation;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-punctuation
    struct PUNCTUATION
    {
    align (4):
        uint iSize;
        PSTR szPunctuation;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-repastespecial
    struct REPASTESPECIAL
    {
    align (4):
        DVASPECT dwAspect;
        size_t   dwParam;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-repastespecial
    struct REPASTESPECIAL
    {
    align (4):
        DVASPECT dwAspect;
        size_t   dwParam;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-gettextex
    struct GETTEXTEX
    {
    align (4):
        uint            cb;
        GETTEXTEX_FLAGS flags;
        uint            codepage;
        const(PSTR)     lpDefaultChar;
        BOOL*           lpUsedDefChar;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-gettextex
    struct GETTEXTEX
    {
    align (4):
        uint            cb;
        GETTEXTEX_FLAGS flags;
        uint            codepage;
        const(PSTR)     lpDefaultChar;
        BOOL*           lpUsedDefChar;
    }
}

version(X86_64)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-hyphenateinfo
    struct HYPHENATEINFO
    {
    align (4):
        short     cbSize;
        short     dxHyphenateZone;
        ptrdiff_t pfnHyphenate;
    }
}

version(AArch64)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-hyphenateinfo
    struct HYPHENATEINFO
    {
    align (4):
        short     cbSize;
        short     dxHyphenateZone;
        ptrdiff_t pfnHyphenate;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-imecomptext
struct IMECOMPTEXT
{
    int               cb;
    IMECOMPTEXT_FLAGS flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-tablerowparms
struct TABLEROWPARMS
{
    ubyte cbRow;
    ubyte cbCell;
    ubyte cCell;
    ubyte cRow;
    int   dxCellMargin;
    int   dxIndent;
    int   dyHeight;
    // Native bit field: nAlignment: [0-2], fRTL: [3], fKeep: [4], fKeepFollow: [5], fWrap: [6], fIdentCells: [7]
    uint  _bitfield0;
    int   cpStartRow;
    ubyte bTableLevel;
    ubyte iCell;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-tablecellparms
struct TABLECELLPARMS
{
    int      dxWidth;
    // Native bit field: nVertAlign: [0-1], fMergeTop: [2], fMergePrev: [3], fVertical: [4], fMergeStart: [5], fMergeCont: [6]
    ushort   _bitfield0;
    ushort   wShading;
    short    dxBrdrLeft;
    short    dyBrdrTop;
    short    dxBrdrRight;
    short    dyBrdrBottom;
    COLORREF crBrdrLeft;
    COLORREF crBrdrTop;
    COLORREF crBrdrRight;
    COLORREF crBrdrBottom;
    COLORREF crBackPat;
    COLORREF crForePat;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-richedit_image_parameters
    struct RICHEDIT_IMAGE_PARAMETERS
    {
        int          xWidth;
        int          yHeight;
        int          Ascent;
        int          Type;
        const(PWSTR) pwszAlternateText;
        IStream      pIStream;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-endcompositionnotify
    struct ENDCOMPOSITIONNOTIFY
    {
        NMHDR nmhdr;
        ENDCOMPOSITIONNOTIFY_CODE dwCode;
    }
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-charformata
struct CHARFORMATA
{
    uint         cbSize;
    CFM_MASK     dwMask;
    CFE_EFFECTS  dwEffects;
    int          yHeight;
    int          yOffset;
    COLORREF     crTextColor;
    FONT_CHARSET bCharSet;
    ubyte        bPitchAndFamily;
    CHAR[32]     szFaceName;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-charformatw
struct CHARFORMATW
{
    uint         cbSize;
    CFM_MASK     dwMask;
    CFE_EFFECTS  dwEffects;
    int          yHeight;
    int          yOffset;
    COLORREF     crTextColor;
    FONT_CHARSET bCharSet;
    ubyte        bPitchAndFamily;
    wchar[32]    szFaceName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-charformat2w
struct CHARFORMAT2W
{
    CHARFORMATW Base;
    ushort      wWeight;
    short       sSpacing;
    COLORREF    crBackColor;
    uint        lcid;
    union
    {
        uint dwReserved;
        uint dwCookie;
    }
    short       sStyle;
    ushort      wKerning;
    ubyte       bUnderlineType;
    ubyte       bAnimation;
    ubyte       bRevAuthor;
    ubyte       bUnderlineColor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-charformat2a
struct CHARFORMAT2A
{
    CHARFORMATA Base;
    ushort      wWeight;
    short       sSpacing;
    COLORREF    crBackColor;
    uint        lcid;
    union
    {
        uint dwReserved;
        uint dwCookie;
    }
    short       sStyle;
    ushort      wKerning;
    ubyte       bUnderlineType;
    ubyte       bAnimation;
    ubyte       bRevAuthor;
    ubyte       bUnderlineColor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-charrange
struct CHARRANGE
{
    int cpMin;
    int cpMax;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-textrangea
    struct TEXTRANGEA
    {
        CHARRANGE chrg;
        PSTR      lpstrText;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-textrangew
    struct TEXTRANGEW
    {
        CHARRANGE chrg;
        PWSTR     lpstrText;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-editstream
    struct EDITSTREAM
    {
        size_t             dwCookie;
        uint               dwError;
        EDITSTREAMCALLBACK pfnCallback;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-findtexta
    struct FINDTEXTA
    {
        CHARRANGE   chrg;
        const(PSTR) lpstrText;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-findtextw
    struct FINDTEXTW
    {
        CHARRANGE    chrg;
        const(PWSTR) lpstrText;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-findtextexa
    struct FINDTEXTEXA
    {
        CHARRANGE   chrg;
        const(PSTR) lpstrText;
        CHARRANGE   chrgText;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-findtextexw
    struct FINDTEXTEXW
    {
        CHARRANGE    chrg;
        const(PWSTR) lpstrText;
        CHARRANGE    chrgText;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-formatrange
    struct FORMATRANGE
    {
        HDC       hdc;
        HDC       hdcTarget;
        RECT      rc;
        RECT      rcPage;
        CHARRANGE chrg;
    }
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-paraformat
struct PARAFORMAT
{
    uint                 cbSize;
    PARAFORMAT_MASK      dwMask;
    PARAFORMAT_NUMBERING wNumbering;
    union
    {
        ushort wReserved;
        ushort wEffects;
    }
    int                  dxStartIndent;
    int                  dxRightIndent;
    int                  dxOffset;
    PARAFORMAT_ALIGNMENT wAlignment;
    short                cTabCount;
    uint[32]             rgxTabs;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-paraformat2
struct PARAFORMAT2
{
    PARAFORMAT         Base;
    int                dySpaceBefore;
    int                dySpaceAfter;
    int                dyLineSpacing;
    short              sStyle;
    ubyte              bLineSpacingRule;
    ubyte              bOutlineLevel;
    ushort             wShadingWeight;
    PARAFORMAT_SHADING_STYLE wShadingStyle;
    ushort             wNumberingStart;
    PARAFORMAT_NUMBERING_STYLE wNumberingStyle;
    ushort             wNumberingTab;
    ushort             wBorderSpace;
    ushort             wBorderWidth;
    PARAFORMAT_BORDERS wBorders;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-msgfilter
    struct MSGFILTER
    {
        NMHDR  nmhdr;
        uint   msg;
        WPARAM wParam;
        LPARAM lParam;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-reqresize
    struct REQRESIZE
    {
        NMHDR nmhdr;
        RECT  rc;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-selchange
    struct SELCHANGE
    {
        NMHDR     nmhdr;
        CHARRANGE chrg;
        RICH_EDIT_GET_CONTEXT_MENU_SEL_TYPE seltyp;
    }
}

struct GROUPTYPINGCHANGE
{
align (4):
    NMHDR nmhdr;
    BOOL  fGroupTyping;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-clipboardformat
    struct CLIPBOARDFORMAT
    {
        NMHDR  nmhdr;
        ushort cf;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-getcontextmenuex
    struct GETCONTEXTMENUEX
    {
        CHARRANGE chrg;
        uint      dwFlags;
        POINT     pt;
        void*     pvReserved;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-endropfiles
    struct ENDROPFILES
    {
        NMHDR  nmhdr;
        HANDLE hDrop;
        int    cp;
        BOOL   fProtected;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-enprotected
    struct ENPROTECTED
    {
        NMHDR     nmhdr;
        uint      msg;
        WPARAM    wParam;
        LPARAM    lParam;
        CHARRANGE chrg;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-ensaveclipboard
    struct ENSAVECLIPBOARD
    {
        NMHDR nmhdr;
        int   cObjectCount;
        int   cch;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-enoleopfailed
    struct ENOLEOPFAILED
    {
        NMHDR   nmhdr;
        int     iob;
        int     lOper;
        HRESULT hr;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-objectpositions
    struct OBJECTPOSITIONS
    {
        NMHDR nmhdr;
        int   cObjectCount;
        int*  pcpPositions;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-enlink
    struct ENLINK
    {
        NMHDR     nmhdr;
        uint      msg;
        WPARAM    wParam;
        LPARAM    lParam;
        CHARRANGE chrg;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-enlowfirtf
    struct ENLOWFIRTF
    {
        NMHDR nmhdr;
        PSTR  szControl;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-encorrecttext
    struct ENCORRECTTEXT
    {
        NMHDR     nmhdr;
        CHARRANGE chrg;
        RICH_EDIT_GET_CONTEXT_MENU_SEL_TYPE seltyp;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-punctuation
    struct PUNCTUATION
    {
        uint iSize;
        PSTR szPunctuation;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-compcolor
struct COMPCOLOR
{
    COLORREF crText;
    COLORREF crBackground;
    uint     dwEffects;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-repastespecial
    struct REPASTESPECIAL
    {
        DVASPECT dwAspect;
        size_t   dwParam;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-settextex
struct SETTEXTEX
{
    uint flags;
    uint codepage;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-gettextex
    struct GETTEXTEX
    {
        uint            cb;
        GETTEXTEX_FLAGS flags;
        uint            codepage;
        const(PSTR)     lpDefaultChar;
        BOOL*           lpUsedDefChar;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-gettextlengthex
struct GETTEXTLENGTHEX
{
    GETTEXTLENGTHEX_FLAGS flags;
    uint codepage;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-bidioptions
struct BIDIOPTIONS
{
    uint   cbSize;
    ushort wMask;
    ushort wEffects;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-hyphresult
struct HYPHRESULT
{
    KHYPH khyph;
    int   ichHyph;
    wchar chHyph;
}

version(X86)
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richedit/ns-richedit-hyphenateinfo
    struct HYPHENATEINFO
    {
        short     cbSize;
        short     dxHyphenateZone;
        ptrdiff_t pfnHyphenate;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/ns-textserv-changenotify
struct CHANGENOTIFY
{
    uint  dwChangeType;
    void* pvCookieData;
}

union CARET_INFO
{
    HBITMAP     hbitmap;
    CARET_FLAGS caretFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/ns-richole-reobject
struct REOBJECT
{
    uint           cbStruct;
    int            cp;
    GUID           clsid;
    IOleObject     poleobj;
    IStorage       pstg;
    IOleClientSite polesite;
    SIZE           sizel;
    uint           dvaspect;
    REOBJECT_FLAGS dwFlags;
    uint           dwUser;
}

// Interfaces

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nl-textserv-itextservices
interface ITextServices : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txsendmessage
    HRESULT TxSendMessage(uint msg, WPARAM wparam, LPARAM lparam, LRESULT* plresult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txdraw
    HRESULT TxDraw(DVASPECT dwDrawAspect, int lindex, void* pvAspect, DVTARGETDEVICE* ptd, HDC hdcDraw, 
                   HDC hicTargetDev, RECTL* lprcBounds, RECTL* lprcWBounds, RECT* lprcUpdate, ptrdiff_t pfnContinue, 
                   uint dwContinue, int lViewId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txgethscroll
    HRESULT TxGetHScroll(int* plMin, int* plMax, int* plPos, int* plPage, BOOL* pfEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txgetvscroll
    HRESULT TxGetVScroll(int* plMin, int* plMax, int* plPos, int* plPage, BOOL* pfEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-ontxsetcursor
    HRESULT OnTxSetCursor(DVASPECT dwDrawAspect, int lindex, void* pvAspect, DVTARGETDEVICE* ptd, HDC hdcDraw, 
                          HDC hicTargetDev, RECT* lprcClient, int x, int y);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txqueryhitpoint
    HRESULT TxQueryHitPoint(DVASPECT dwDrawAspect, int lindex, void* pvAspect, DVTARGETDEVICE* ptd, HDC hdcDraw, 
                            HDC hicTargetDev, RECT* lprcClient, int x, int y, uint* pHitResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-ontxinplaceactivate
    HRESULT OnTxInPlaceActivate(RECT* prcClient);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-ontxinplacedeactivate
    HRESULT OnTxInPlaceDeactivate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-ontxuiactivate
    HRESULT OnTxUIActivate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-ontxuideactivate
    HRESULT OnTxUIDeactivate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txgettext
    HRESULT TxGetText(BSTR* pbstrText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txsettext
    HRESULT TxSetText(const(PWSTR) pszText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txgetcurtargetx
    HRESULT TxGetCurTargetX(int* param0);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txgetbaselinepos
    HRESULT TxGetBaseLinePos(int* param0);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txgetnaturalsize
    HRESULT TxGetNaturalSize(uint dwAspect, HDC hdcDraw, HDC hicTargetDev, DVTARGETDEVICE* ptd, uint dwMode, 
                             const(SIZE)* psizelExtent, int* pwidth, int* pheight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txgetdroptarget
    HRESULT TxGetDropTarget(IDropTarget* ppDropTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-ontxpropertybitschange
    HRESULT OnTxPropertyBitsChange(uint dwMask, uint dwBits);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices-txgetcachedsize
    HRESULT TxGetCachedSize(uint* pdwWidth, uint* pdwHeight);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nl-textserv-itexthost
interface ITextHost : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetdc
    HDC      TxGetDC();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txreleasedc
    int      TxReleaseDC(HDC hdc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txshowscrollbar
    BOOL     TxShowScrollBar(int fnBar, BOOL fShow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txenablescrollbar
    BOOL     TxEnableScrollBar(SCROLLBAR_CONSTANTS fuSBFlags, int fuArrowflags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txsetscrollrange
    BOOL     TxSetScrollRange(int fnBar, int nMinPos, int nMaxPos, BOOL fRedraw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txsetscrollpos
    BOOL     TxSetScrollPos(int fnBar, int nPos, BOOL fRedraw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txinvalidaterect
    void     TxInvalidateRect(RECT* prc, BOOL fMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txviewchange
    void     TxViewChange(BOOL fUpdate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txcreatecaret
    BOOL     TxCreateCaret(HBITMAP hbmp, int xWidth, int yHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txshowcaret
    BOOL     TxShowCaret(BOOL fShow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txsetcaretpos
    BOOL     TxSetCaretPos(int x, int y);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txsettimer
    BOOL     TxSetTimer(uint idTimer, uint uTimeout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txkilltimer
    void     TxKillTimer(uint idTimer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txscrollwindowex
    void     TxScrollWindowEx(int dx, int dy, RECT* lprcScroll, RECT* lprcClip, HRGN hrgnUpdate, RECT* lprcUpdate, 
                              SCROLL_WINDOW_FLAGS fuScroll);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txsetcapture
    void     TxSetCapture(BOOL fCapture);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txsetfocus
    void     TxSetFocus();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txsetcursor
    void     TxSetCursor(HCURSOR hcur, BOOL fText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txscreentoclient
    BOOL     TxScreenToClient(POINT* lppt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txclienttoscreen
    BOOL     TxClientToScreen(POINT* lppt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txactivate
    HRESULT  TxActivate(int* plOldState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txdeactivate
    HRESULT  TxDeactivate(int lNewState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetclientrect
    HRESULT  TxGetClientRect(RECT* prc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetviewinset
    HRESULT  TxGetViewInset(RECT* prc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetcharformat
    HRESULT  TxGetCharFormat(const(CHARFORMATW)** ppCF);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetparaformat
    HRESULT  TxGetParaFormat(const(PARAFORMAT)** ppPF);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetsyscolor
    COLORREF TxGetSysColor(SYS_COLOR_INDEX nIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetbackstyle
    HRESULT  TxGetBackStyle(TXTBACKSTYLE* pstyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetmaxlength
    HRESULT  TxGetMaxLength(uint* plength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetscrollbars
    HRESULT  TxGetScrollBars(uint* pdwScrollBar);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetpasswordchar
    HRESULT  TxGetPasswordChar(byte* pch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetacceleratorpos
    HRESULT  TxGetAcceleratorPos(int* pcp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetextent
    HRESULT  TxGetExtent(SIZE* lpExtent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-ontxcharformatchange
    HRESULT  OnTxCharFormatChange(const(CHARFORMATW)* pCF);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-ontxparaformatchange
    HRESULT  OnTxParaFormatChange(const(PARAFORMAT)* pPF);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetpropertybits
    HRESULT  TxGetPropertyBits(uint dwMask, uint* pdwBits);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txnotify
    HRESULT  TxNotify(uint iNotify, void* pv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-tximmgetcontext
    HIMC     TxImmGetContext();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-tximmreleasecontext
    void     TxImmReleaseContext(HIMC himc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost-txgetselectionbarwidth
    HRESULT  TxGetSelectionBarWidth(int* lSelBarWidth);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nn-textserv-irichedituiaoverrides
interface IRicheditUiaOverrides : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-irichedituiaoverrides-getpropertyoverridevalue
    HRESULT GetPropertyOverrideValue(int propertyId, VARIANT* pRetValue);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nl-textserv-itexthost2
interface ITextHost2 : ITextHost
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txisdoubleclickpending
    BOOL     TxIsDoubleClickPending();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txgetwindow
    HRESULT  TxGetWindow(HWND* phwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txsetforegroundwindow
    HRESULT  TxSetForegroundWindow();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txgetpalette
    HPALETTE TxGetPalette();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txgeteastasianflags
    HRESULT  TxGetEastAsianFlags(int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txsetcursor2
    HCURSOR  TxSetCursor2(HCURSOR hcur, BOOL bText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txfreetextservicesnotification
    void     TxFreeTextServicesNotification();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txgeteditstyle
    HRESULT  TxGetEditStyle(uint dwItem, uint* pdwData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txgetwindowstyles
    HRESULT  TxGetWindowStyles(uint* pdwStyle, uint* pdwExStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txshowdropcaret
    HRESULT  TxShowDropCaret(BOOL fShow, HDC hdc, RECT* prc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txdestroycaret
    HRESULT  TxDestroyCaret();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itexthost2-txgethorzextent
    HRESULT  TxGetHorzExtent(int* plHorzExtent);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nl-textserv-itextservices2
interface ITextServices2 : ITextServices
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices2-txgetnaturalsize2
    HRESULT TxGetNaturalSize2(uint dwAspect, HDC hdcDraw, HDC hicTargetDev, DVTARGETDEVICE* ptd, uint dwMode, 
                              const(SIZE)* psizelExtent, int* pwidth, int* pheight, int* pascent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textserv/nf-textserv-itextservices2-txdrawd2d
    HRESULT TxDrawD2D(ID2D1RenderTarget pRenderTarget, RECTL* lprcBounds, RECT* lprcUpdate, int lViewId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nn-richole-iricheditole
@GUID("00020d00-0000-0000-c000-000000000046")
interface IRichEditOle : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-getclientsite
    HRESULT GetClientSite(IOleClientSite* lplpolesite);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-getobjectcount
    int     GetObjectCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-getlinkcount
    int     GetLinkCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-getobject
    HRESULT GetObject(int iob, REOBJECT* lpreobject, RICH_EDIT_GET_OBJECT_FLAGS dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-insertobject
    HRESULT InsertObject(REOBJECT* lpreobject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-convertobject
    HRESULT ConvertObject(int iob, const(GUID)* rclsidNew, const(PSTR) lpstrUserTypeNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-activateas
    HRESULT ActivateAs(const(GUID)* rclsid, const(GUID)* rclsidAs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-sethostnames
    HRESULT SetHostNames(const(PSTR) lpstrContainerApp, const(PSTR) lpstrContainerObj);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-setlinkavailable
    HRESULT SetLinkAvailable(int iob, BOOL fAvailable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-setdvaspect
    HRESULT SetDvaspect(int iob, uint dvaspect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-handsoffstorage
    HRESULT HandsOffStorage(int iob);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-savecompleted
    HRESULT SaveCompleted(int iob, IStorage lpstg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-inplacedeactivate
    HRESULT InPlaceDeactivate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-contextsensitivehelp
    HRESULT ContextSensitiveHelp(BOOL fEnterMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-getclipboarddata
    HRESULT GetClipboardData(CHARRANGE* lpchrg, uint reco, IDataObject* lplpdataobj);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditole-importdataobject
    HRESULT ImportDataObject(IDataObject lpdataobj, ushort cf, HGLOBAL hMetaPict);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nn-richole-iricheditolecallback
@GUID("00020d03-0000-0000-c000-000000000046")
interface IRichEditOleCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditolecallback-getnewstorage
    HRESULT GetNewStorage(IStorage* lplpstg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditolecallback-getinplacecontext
    HRESULT GetInPlaceContext(IOleInPlaceFrame* lplpFrame, IOleInPlaceUIWindow* lplpDoc, 
                              OLEINPLACEFRAMEINFO* lpFrameInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditolecallback-showcontainerui
    HRESULT ShowContainerUI(BOOL fShow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditolecallback-queryinsertobject
    HRESULT QueryInsertObject(GUID* lpclsid, IStorage lpstg, int cp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditolecallback-deleteobject
    HRESULT DeleteObject(IOleObject lpoleobj);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditolecallback-queryacceptdata
    HRESULT QueryAcceptData(IDataObject lpdataobj, ushort* lpcfFormat, RECO_FLAGS reco, BOOL fReally, 
                            HGLOBAL hMetaPict);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditolecallback-contextsensitivehelp
    HRESULT ContextSensitiveHelp(BOOL fEnterMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditolecallback-getclipboarddata
    HRESULT GetClipboardData(CHARRANGE* lpchrg, uint reco, IDataObject* lplpdataobj);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditolecallback-getdragdropeffect
    HRESULT GetDragDropEffect(BOOL fDrag, MODIFIERKEYS_FLAGS grfKeyState, DROPEFFECT* pdwEffect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/richole/nf-richole-iricheditolecallback-getcontextmenu
    HRESULT GetContextMenu(RICH_EDIT_GET_CONTEXT_MENU_SEL_TYPE seltype, IOleObject lpoleobj, CHARRANGE* lpchrg, 
                           HMENU* lphmenu);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextdocument
@GUID("8cc497c0-a1df-11ce-8098-00aa0047be5d")
interface ITextDocument : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-getname
    HRESULT GetName(BSTR* pName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-getselection
    HRESULT GetSelection(ITextSelection* ppSel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-getstorycount
    HRESULT GetStoryCount(int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-getstoryranges
    HRESULT GetStoryRanges(ITextStoryRanges* ppStories);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-getsaved
    HRESULT GetSaved(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-setsaved
    HRESULT SetSaved(tomConstants Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-getdefaulttabstop
    HRESULT GetDefaultTabStop(float* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-setdefaulttabstop
    HRESULT SetDefaultTabStop(float Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-new
    HRESULT New();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-open
    HRESULT Open(VARIANT* pVar, tomConstants Flags, int CodePage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-save
    HRESULT Save(VARIANT* pVar, tomConstants Flags, int CodePage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-freeze
    HRESULT Freeze(int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-unfreeze
    HRESULT Unfreeze(int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-begineditcollection
    HRESULT BeginEditCollection();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-endeditcollection
    HRESULT EndEditCollection();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-undo
    HRESULT Undo(int Count, int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-redo
    HRESULT Redo(int Count, int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-range
    HRESULT Range(int cpActive, int cpAnchor, ITextRange* ppRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument-rangefrompoint
    HRESULT RangeFromPoint(int x, int y, ITextRange* ppRange);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextrange
@GUID("8cc497c2-a1df-11ce-8098-00aa0047be5d")
interface ITextRange : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-gettext
    HRESULT GetText(BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-settext
    HRESULT SetText(BSTR bstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getchar
    HRESULT GetChar(int* pChar);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-setchar
    HRESULT SetChar(int Char);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getduplicate
    HRESULT GetDuplicate(ITextRange* ppRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getformattedtext
    HRESULT GetFormattedText(ITextRange* ppRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-setformattedtext
    HRESULT SetFormattedText(ITextRange pRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getstart
    HRESULT GetStart(int* pcpFirst);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-setstart
    HRESULT SetStart(int cpFirst);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getend
    HRESULT GetEnd(int* pcpLim);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-setend
    HRESULT SetEnd(int cpLim);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getfont
    HRESULT GetFont(ITextFont* ppFont);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-setfont
    HRESULT SetFont(ITextFont pFont);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getpara
    HRESULT GetPara(ITextPara* ppPara);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-setpara
    HRESULT SetPara(ITextPara pPara);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getstorylength
    HRESULT GetStoryLength(int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getstorytype
    HRESULT GetStoryType(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-collapse
    HRESULT Collapse(int bStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-expand
    HRESULT Expand(int Unit, int* pDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getindex
    HRESULT GetIndex(int Unit, int* pIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-setindex
    HRESULT SetIndex(int Unit, int Index, int Extend);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-setrange
    HRESULT SetRange(int cpAnchor, int cpActive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-inrange
    HRESULT InRange(ITextRange pRange, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-instory
    HRESULT InStory(ITextRange pRange, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-isequal
    HRESULT IsEqual(ITextRange pRange, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-select
    HRESULT Select();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-startof
    HRESULT StartOf(int Unit, int Extend, int* pDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-endof
    HRESULT EndOf(int Unit, int Extend, int* pDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-move
    HRESULT Move(int Unit, int Count, int* pDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-movestart
    HRESULT MoveStart(int Unit, int Count, int* pDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-moveend
    HRESULT MoveEnd(int Unit, int Count, int* pDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-movewhile
    HRESULT MoveWhile(VARIANT* Cset, int Count, int* pDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-movestartwhile
    HRESULT MoveStartWhile(VARIANT* Cset, int Count, int* pDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-moveendwhile
    HRESULT MoveEndWhile(VARIANT* Cset, int Count, int* pDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-moveuntil
    HRESULT MoveUntil(VARIANT* Cset, int Count, int* pDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-movestartuntil
    HRESULT MoveStartUntil(VARIANT* Cset, int Count, int* pDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-moveenduntil
    HRESULT MoveEndUntil(VARIANT* Cset, int Count, int* pDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-findtext
    HRESULT FindText(BSTR bstr, int Count, tomConstants Flags, int* pLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-findtextstart
    HRESULT FindTextStart(BSTR bstr, int Count, tomConstants Flags, int* pLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-findtextend
    HRESULT FindTextEnd(BSTR bstr, int Count, tomConstants Flags, int* pLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-delete
    HRESULT Delete(int Unit, int Count, int* pDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-cut
    HRESULT Cut(VARIANT* pVar);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-copy
    HRESULT Copy(VARIANT* pVar);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-paste
    HRESULT Paste(VARIANT* pVar, int Format);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-canpaste
    HRESULT CanPaste(VARIANT* pVar, int Format, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-canedit
    HRESULT CanEdit(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-changecase
    HRESULT ChangeCase(tomConstants Type);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getpoint
    HRESULT GetPoint(tomConstants Type, int* px, int* py);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-setpoint
    HRESULT SetPoint(int x, int y, tomConstants Type, int Extend);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-scrollintoview
    HRESULT ScrollIntoView(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange-getembeddedobject
    HRESULT GetEmbeddedObject(IUnknown* ppObject);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextselection
@GUID("8cc497c1-a1df-11ce-8098-00aa0047be5d")
interface ITextSelection : ITextRange
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextselection-getflags
    HRESULT GetFlags(int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextselection-setflags
    HRESULT SetFlags(int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextselection-gettype
    HRESULT GetType(int* pType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextselection-moveleft
    HRESULT MoveLeft(int Unit, int Count, int Extend, int* pDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextselection-moveright
    HRESULT MoveRight(int Unit, int Count, int Extend, int* pDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextselection-moveup
    HRESULT MoveUp(int Unit, int Count, int Extend, int* pDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextselection-movedown
    HRESULT MoveDown(int Unit, int Count, int Extend, int* pDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextselection-homekey
    HRESULT HomeKey(tomConstants Unit, int Extend, int* pDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextselection-endkey
    HRESULT EndKey(int Unit, int Extend, int* pDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextselection-typetext
    HRESULT TypeText(BSTR bstr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextfont
@GUID("8cc497c3-a1df-11ce-8098-00aa0047be5d")
interface ITextFont : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getduplicate
    HRESULT GetDuplicate(ITextFont* ppFont);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setduplicate
    HRESULT SetDuplicate(ITextFont pFont);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-canchange
    HRESULT CanChange(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-isequal
    HRESULT IsEqual(ITextFont pFont, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-reset
    HRESULT Reset(tomConstants Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getstyle
    HRESULT GetStyle(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setstyle
    HRESULT SetStyle(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getallcaps
    HRESULT GetAllCaps(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setallcaps
    HRESULT SetAllCaps(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getanimation
    HRESULT GetAnimation(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setanimation
    HRESULT SetAnimation(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getbackcolor
    HRESULT GetBackColor(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setbackcolor
    HRESULT SetBackColor(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getbold
    HRESULT GetBold(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setbold
    HRESULT SetBold(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getemboss
    HRESULT GetEmboss(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setemboss
    HRESULT SetEmboss(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getforecolor
    HRESULT GetForeColor(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setforecolor
    HRESULT SetForeColor(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-gethidden
    HRESULT GetHidden(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-sethidden
    HRESULT SetHidden(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getengrave
    HRESULT GetEngrave(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setengrave
    HRESULT SetEngrave(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getitalic
    HRESULT GetItalic(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setitalic
    HRESULT SetItalic(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getkerning
    HRESULT GetKerning(float* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setkerning
    HRESULT SetKerning(float Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getlanguageid
    HRESULT GetLanguageID(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setlanguageid
    HRESULT SetLanguageID(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getname
    HRESULT GetName(BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setname
    HRESULT SetName(BSTR bstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getoutline
    HRESULT GetOutline(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setoutline
    HRESULT SetOutline(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getposition
    HRESULT GetPosition(float* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setposition
    HRESULT SetPosition(float Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getprotected
    HRESULT GetProtected(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setprotected
    HRESULT SetProtected(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getshadow
    HRESULT GetShadow(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setshadow
    HRESULT SetShadow(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getsize
    HRESULT GetSize(float* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setsize
    HRESULT SetSize(float Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getsmallcaps
    HRESULT GetSmallCaps(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setsmallcaps
    HRESULT SetSmallCaps(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getspacing
    HRESULT GetSpacing(float* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setspacing
    HRESULT SetSpacing(float Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getstrikethrough
    HRESULT GetStrikeThrough(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setstrikethrough
    HRESULT SetStrikeThrough(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getsubscript
    HRESULT GetSubscript(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setsubscript
    HRESULT SetSubscript(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getsuperscript
    HRESULT GetSuperscript(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setsuperscript
    HRESULT SetSuperscript(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getunderline
    HRESULT GetUnderline(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setunderline
    HRESULT SetUnderline(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-getweight
    HRESULT GetWeight(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont-setweight
    HRESULT SetWeight(int Value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextpara
@GUID("8cc497c4-a1df-11ce-8098-00aa0047be5d")
interface ITextPara : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getduplicate
    HRESULT GetDuplicate(ITextPara* ppPara);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setduplicate
    HRESULT SetDuplicate(ITextPara pPara);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-canchange
    HRESULT CanChange(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-isequal
    HRESULT IsEqual(ITextPara pPara, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-reset
    HRESULT Reset(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getstyle
    HRESULT GetStyle(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setstyle
    HRESULT SetStyle(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getalignment
    HRESULT GetAlignment(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setalignment
    HRESULT SetAlignment(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-gethyphenation
    HRESULT GetHyphenation(tomConstants* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-sethyphenation
    HRESULT SetHyphenation(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getfirstlineindent
    HRESULT GetFirstLineIndent(float* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getkeeptogether
    HRESULT GetKeepTogether(tomConstants* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setkeeptogether
    HRESULT SetKeepTogether(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getkeepwithnext
    HRESULT GetKeepWithNext(tomConstants* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setkeepwithnext
    HRESULT SetKeepWithNext(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getleftindent
    HRESULT GetLeftIndent(float* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getlinespacing
    HRESULT GetLineSpacing(float* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getlinespacingrule
    HRESULT GetLineSpacingRule(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getlistalignment
    HRESULT GetListAlignment(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setlistalignment
    HRESULT SetListAlignment(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getlistlevelindex
    HRESULT GetListLevelIndex(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setlistlevelindex
    HRESULT SetListLevelIndex(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getliststart
    HRESULT GetListStart(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setliststart
    HRESULT SetListStart(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getlisttab
    HRESULT GetListTab(float* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setlisttab
    HRESULT SetListTab(float Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getlisttype
    HRESULT GetListType(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setlisttype
    HRESULT SetListType(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getnolinenumber
    HRESULT GetNoLineNumber(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setnolinenumber
    HRESULT SetNoLineNumber(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getpagebreakbefore
    HRESULT GetPageBreakBefore(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setpagebreakbefore
    HRESULT SetPageBreakBefore(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getrightindent
    HRESULT GetRightIndent(float* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setrightindent
    HRESULT SetRightIndent(float Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setindents
    HRESULT SetIndents(float First, float Left, float Right);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setlinespacing
    HRESULT SetLineSpacing(int Rule, float Spacing);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getspaceafter
    HRESULT GetSpaceAfter(float* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setspaceafter
    HRESULT SetSpaceAfter(float Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getspacebefore
    HRESULT GetSpaceBefore(float* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setspacebefore
    HRESULT SetSpaceBefore(float Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-getwidowcontrol
    HRESULT GetWidowControl(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-setwidowcontrol
    HRESULT SetWidowControl(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-gettabcount
    HRESULT GetTabCount(int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-addtab
    HRESULT AddTab(float tbPos, int tbAlign, int tbLeader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-clearalltabs
    HRESULT ClearAllTabs();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-deletetab
    HRESULT DeleteTab(float tbPos);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara-gettab
    HRESULT GetTab(int iTab, float* ptbPos, int* ptbAlign, int* ptbLeader);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextstoryranges
@GUID("8cc497c5-a1df-11ce-8098-00aa0047be5d")
interface ITextStoryRanges : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstoryranges-_newenum
    HRESULT _NewEnum(IUnknown* ppunkEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstoryranges-item
    HRESULT Item(int Index, ITextRange* ppRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstoryranges-getcount
    HRESULT GetCount(int* pCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextdocument2
@GUID("c241f5e0-7206-11d8-a2c7-00a0d1d6c6b3")
interface ITextDocument2 : ITextDocument
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getcarettype
    HRESULT GetCaretType(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-setcarettype
    HRESULT SetCaretType(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getdisplays
    HRESULT GetDisplays(ITextDisplays* ppDisplays);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getdocumentfont
    HRESULT GetDocumentFont(ITextFont2* ppFont);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-setdocumentfont
    HRESULT SetDocumentFont(ITextFont2 pFont);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getdocumentpara
    HRESULT GetDocumentPara(ITextPara2* ppPara);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-setdocumentpara
    HRESULT SetDocumentPara(ITextPara2 pPara);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-geteastasianflags
    HRESULT GetEastAsianFlags(tomConstants* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getgenerator
    HRESULT GetGenerator(BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-setimeinprogress
    HRESULT SetIMEInProgress(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getnotificationmode
    HRESULT GetNotificationMode(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-setnotificationmode
    HRESULT SetNotificationMode(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getselection2
    HRESULT GetSelection2(ITextSelection2* ppSel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getstoryranges2
    HRESULT GetStoryRanges2(ITextStoryRanges2* ppStories);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-gettypographyoptions
    HRESULT GetTypographyOptions(int* pOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getversion
    HRESULT GetVersion(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getwindow
    HRESULT GetWindow(long* pHwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-attachmsgfilter
    HRESULT AttachMsgFilter(IUnknown pFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-checktextlimit
    HRESULT CheckTextLimit(int cch, int* pcch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getcallmanager
    HRESULT GetCallManager(IUnknown* ppVoid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getclientrect
    HRESULT GetClientRect(tomConstants Type, int* pLeft, int* pTop, int* pRight, int* pBottom);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-geteffectcolor
    HRESULT GetEffectColor(int Index, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getimmcontext
    HRESULT GetImmContext(long* pContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getpreferredfont
    HRESULT GetPreferredFont(int cp, int CharRep, int Options, int curCharRep, int curFontSize, BSTR* pbstr, 
                             int* pPitchAndFamily, int* pNewFontSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getproperty
    HRESULT GetProperty(int Type, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getstrings
    HRESULT GetStrings(ITextStrings* ppStrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-notify
    HRESULT Notify(int Notify);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-range2
    HRESULT Range2(int cpActive, int cpAnchor, ITextRange2* ppRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-rangefrompoint2
    HRESULT RangeFromPoint2(int x, int y, int Type, ITextRange2* ppRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-releasecallmanager
    HRESULT ReleaseCallManager(IUnknown pVoid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-releaseimmcontext
    HRESULT ReleaseImmContext(long Context);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-seteffectcolor
    HRESULT SetEffectColor(int Index, int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-setproperty
    HRESULT SetProperty(int Type, int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-settypographyoptions
    HRESULT SetTypographyOptions(int Options, int Mask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-sysbeep
    HRESULT SysBeep();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-update
    HRESULT Update(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-updatewindow
    HRESULT UpdateWindow();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getmathproperties
    HRESULT GetMathProperties(int* pOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-setmathproperties
    HRESULT SetMathProperties(int Options, int Mask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getactivestory
    HRESULT GetActiveStory(ITextStory* ppStory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-setactivestory
    HRESULT SetActiveStory(ITextStory pStory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getmainstory
    HRESULT GetMainStory(ITextStory* ppStory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getnewstory
    HRESULT GetNewStory(ITextStory* ppStory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextdocument2-getstory
    HRESULT GetStory(int Index, ITextStory* ppStory);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextrange2
@GUID("c241f5e2-7206-11d8-a2c7-00a0d1d6c6b3")
interface ITextRange2 : ITextSelection
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getcch
    HRESULT GetCch(int* pcch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getcells
    HRESULT GetCells(IUnknown* ppCells);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getcolumn
    HRESULT GetColumn(IUnknown* ppColumn);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getcount
    HRESULT GetCount(int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getduplicate2
    HRESULT GetDuplicate2(ITextRange2* ppRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getfont2
    HRESULT GetFont2(ITextFont2* ppFont);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-setfont2
    HRESULT SetFont2(ITextFont2 pFont);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getformattedtext2
    HRESULT GetFormattedText2(ITextRange2* ppRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-setformattedtext2
    HRESULT SetFormattedText2(ITextRange2 pRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getgravity
    HRESULT GetGravity(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-setgravity
    HRESULT SetGravity(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getpara2
    HRESULT GetPara2(ITextPara2* ppPara);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-setpara2
    HRESULT SetPara2(ITextPara2 pPara);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getrow
    HRESULT GetRow(ITextRow* ppRow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getstartpara
    HRESULT GetStartPara(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-gettable
    HRESULT GetTable(IUnknown* ppTable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-geturl
    HRESULT GetURL(BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-seturl
    HRESULT SetURL(BSTR bstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-addsubrange
    HRESULT AddSubrange(int cp1, int cp2, int Activate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-buildupmath
    HRESULT BuildUpMath(int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-deletesubrange
    HRESULT DeleteSubrange(int cpFirst, int cpLim);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-find
    HRESULT Find(ITextRange2 pRange, int Count, int Flags, int* pDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getchar2
    HRESULT GetChar2(int* pChar, int Offset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getdropcap
    HRESULT GetDropCap(int* pcLine, int* pPosition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getinlineobject
    HRESULT GetInlineObject(int* pType, int* pAlign, int* pChar, int* pChar1, int* pChar2, int* pCount, 
                            int* pTeXStyle, int* pcCol, int* pLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getproperty
    HRESULT GetProperty(int Type, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getrect
    HRESULT GetRect(int Type, int* pLeft, int* pTop, int* pRight, int* pBottom, int* pHit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getsubrange
    HRESULT GetSubrange(int iSubrange, int* pcpFirst, int* pcpLim);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-gettext2
    HRESULT GetText2(int Flags, BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-hextounicode
    HRESULT HexToUnicode();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-inserttable
    HRESULT InsertTable(int cCol, int cRow, int AutoFit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-linearize
    HRESULT Linearize(int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-setactivesubrange
    HRESULT SetActiveSubrange(int cpAnchor, int cpActive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-setdropcap
    HRESULT SetDropCap(int cLine, int Position);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-setproperty
    HRESULT SetProperty(int Type, int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-settext2
    HRESULT SetText2(int Flags, BSTR bstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-unicodetohex
    HRESULT UnicodeToHex();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-setinlineobject
    HRESULT SetInlineObject(int Type, int Align, int Char, int Char1, int Char2, int Count, int TeXStyle, int cCol);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-getmathfunctiontype
    HRESULT GetMathFunctionType(BSTR bstr, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrange2-insertimage
    HRESULT InsertImage(int width, int height, int ascent, int Type, BSTR bstrAltText, IStream pStream);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextselection2
@GUID("c241f5e1-7206-11d8-a2c7-00a0d1d6c6b3")
interface ITextSelection2 : ITextRange2
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextfont2
@GUID("c241f5e3-7206-11d8-a2c7-00a0d1d6c6b3")
interface ITextFont2 : ITextFont
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getcount
    HRESULT GetCount(int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getautoligatures
    HRESULT GetAutoLigatures(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setautoligatures
    HRESULT SetAutoLigatures(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getautospacealpha
    HRESULT GetAutospaceAlpha(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setautospacealpha
    HRESULT SetAutospaceAlpha(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getautospacenumeric
    HRESULT GetAutospaceNumeric(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setautospacenumeric
    HRESULT SetAutospaceNumeric(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getautospaceparens
    HRESULT GetAutospaceParens(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setautospaceparens
    HRESULT SetAutospaceParens(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getcharrep
    HRESULT GetCharRep(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setcharrep
    HRESULT SetCharRep(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getcompressionmode
    HRESULT GetCompressionMode(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setcompressionmode
    HRESULT SetCompressionMode(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getcookie
    HRESULT GetCookie(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setcookie
    HRESULT SetCookie(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getdoublestrike
    HRESULT GetDoubleStrike(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setdoublestrike
    HRESULT SetDoubleStrike(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getduplicate2
    HRESULT GetDuplicate2(ITextFont2* ppFont);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setduplicate2
    HRESULT SetDuplicate2(ITextFont2 pFont);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getlinktype
    HRESULT GetLinkType(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getmathzone
    HRESULT GetMathZone(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setmathzone
    HRESULT SetMathZone(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getmodwidthpairs
    HRESULT GetModWidthPairs(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setmodwidthpairs
    HRESULT SetModWidthPairs(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getmodwidthspace
    HRESULT GetModWidthSpace(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setmodwidthspace
    HRESULT SetModWidthSpace(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getoldnumbers
    HRESULT GetOldNumbers(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setoldnumbers
    HRESULT SetOldNumbers(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getoverlapping
    HRESULT GetOverlapping(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setoverlapping
    HRESULT SetOverlapping(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getpositionsubsuper
    HRESULT GetPositionSubSuper(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setpositionsubsuper
    HRESULT SetPositionSubSuper(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getscaling
    HRESULT GetScaling(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setscaling
    HRESULT SetScaling(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getspaceextension
    HRESULT GetSpaceExtension(float* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setspaceextension
    HRESULT SetSpaceExtension(float Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getunderlinepositionmode
    HRESULT GetUnderlinePositionMode(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setunderlinepositionmode
    HRESULT SetUnderlinePositionMode(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-geteffects
    HRESULT GetEffects(int* pValue, int* pMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-geteffects2
    HRESULT GetEffects2(int* pValue, int* pMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getproperty
    HRESULT GetProperty(int Type, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-getpropertyinfo
    HRESULT GetPropertyInfo(int Index, int* pType, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-isequal2
    HRESULT IsEqual2(ITextFont2 pFont, int* pB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-seteffects
    HRESULT SetEffects(int Value, int Mask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-seteffects2
    HRESULT SetEffects2(int Value, int Mask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextfont2-setproperty
    HRESULT SetProperty(int Type, int Value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextpara2
@GUID("c241f5e4-7206-11d8-a2c7-00a0d1d6c6b3")
interface ITextPara2 : ITextPara
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-getborders
    HRESULT GetBorders(IUnknown* ppBorders);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-getduplicate2
    HRESULT GetDuplicate2(ITextPara2* ppPara);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-setduplicate2
    HRESULT SetDuplicate2(ITextPara2 pPara);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-getfontalignment
    HRESULT GetFontAlignment(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-setfontalignment
    HRESULT SetFontAlignment(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-gethangingpunctuation
    HRESULT GetHangingPunctuation(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-sethangingpunctuation
    HRESULT SetHangingPunctuation(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-getsnaptogrid
    HRESULT GetSnapToGrid(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-setsnaptogrid
    HRESULT SetSnapToGrid(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-gettrimpunctuationatstart
    HRESULT GetTrimPunctuationAtStart(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-settrimpunctuationatstart
    HRESULT SetTrimPunctuationAtStart(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-geteffects
    HRESULT GetEffects(int* pValue, int* pMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-getproperty
    HRESULT GetProperty(int Type, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-isequal2
    HRESULT IsEqual2(ITextPara2 pPara, int* pB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-seteffects
    HRESULT SetEffects(int Value, int Mask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextpara2-setproperty
    HRESULT SetProperty(int Type, int Value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextstoryranges2
@GUID("c241f5e5-7206-11d8-a2c7-00a0d1d6c6b3")
interface ITextStoryRanges2 : ITextStoryRanges
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstoryranges2-item2
    HRESULT Item2(int Index, ITextRange2* ppRange);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextstory
@GUID("c241f5f3-7206-11d8-a2c7-00a0d1d6c6b3")
interface ITextStory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-getactive
    HRESULT GetActive(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-setactive
    HRESULT SetActive(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-getdisplay
    HRESULT GetDisplay(IUnknown* ppDisplay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-getindex
    HRESULT GetIndex(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-gettype
    HRESULT GetType(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-settype
    HRESULT SetType(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-getproperty
    HRESULT GetProperty(int Type, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-getrange
    HRESULT GetRange(int cpActive, int cpAnchor, ITextRange2* ppRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-gettext
    HRESULT GetText(int Flags, BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-setformattedtext
    HRESULT SetFormattedText(IUnknown pUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-setproperty
    HRESULT SetProperty(int Type, int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstory-settext
    HRESULT SetText(int Flags, BSTR bstr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextstrings
@GUID("c241f5e7-7206-11d8-a2c7-00a0d1d6c6b3")
interface ITextStrings : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-item
    HRESULT Item(int Index, ITextRange2* ppRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-getcount
    HRESULT GetCount(int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-add
    HRESULT Add(BSTR bstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-append
    HRESULT Append(ITextRange2 pRange, int iString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-cat2
    HRESULT Cat2(int iString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-cattop2
    HRESULT CatTop2(BSTR bstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-deleterange
    HRESULT DeleteRange(ITextRange2 pRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-encodefunction
    HRESULT EncodeFunction(int Type, int Align, int Char, int Char1, int Char2, int Count, int TeXStyle, int cCol, 
                           ITextRange2 pRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-getcch
    HRESULT GetCch(int iString, int* pcch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-insertnullstr
    HRESULT InsertNullStr(int iString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-moveboundary
    HRESULT MoveBoundary(int iString, int cch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-prefixtop
    HRESULT PrefixTop(BSTR bstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-remove
    HRESULT Remove(int iString, int cString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-setformattedtext
    HRESULT SetFormattedText(ITextRange2 pRangeD, ITextRange2 pRangeS);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-setopcp
    HRESULT SetOpCp(int iString, int cp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-suffixtop
    HRESULT SuffixTop(BSTR bstr, ITextRange2 pRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextstrings-swap
    HRESULT Swap();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextrow
@GUID("c241f5ef-7206-11d8-a2c7-00a0d1d6c6b3")
interface ITextRow : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getalignment
    HRESULT GetAlignment(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setalignment
    HRESULT SetAlignment(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellcount
    HRESULT GetCellCount(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellcount
    HRESULT SetCellCount(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellcountcache
    HRESULT GetCellCountCache(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellcountcache
    HRESULT SetCellCountCache(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellindex
    HRESULT GetCellIndex(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellindex
    HRESULT SetCellIndex(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellmargin
    HRESULT GetCellMargin(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellmargin
    HRESULT SetCellMargin(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getheight
    HRESULT GetHeight(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setheight
    HRESULT SetHeight(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getindent
    HRESULT GetIndent(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setindent
    HRESULT SetIndent(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getkeeptogether
    HRESULT GetKeepTogether(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setkeeptogether
    HRESULT SetKeepTogether(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getkeepwithnext
    HRESULT GetKeepWithNext(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setkeepwithnext
    HRESULT SetKeepWithNext(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getnestlevel
    HRESULT GetNestLevel(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getrtl
    HRESULT GetRTL(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setrtl
    HRESULT SetRTL(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellalignment
    HRESULT GetCellAlignment(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellalignment
    HRESULT SetCellAlignment(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellcolorback
    HRESULT GetCellColorBack(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellcolorback
    HRESULT SetCellColorBack(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellcolorfore
    HRESULT GetCellColorFore(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellcolorfore
    HRESULT SetCellColorFore(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellmergeflags
    HRESULT GetCellMergeFlags(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellmergeflags
    HRESULT SetCellMergeFlags(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellshading
    HRESULT GetCellShading(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellshading
    HRESULT SetCellShading(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellverticaltext
    HRESULT GetCellVerticalText(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellverticaltext
    HRESULT SetCellVerticalText(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellwidth
    HRESULT GetCellWidth(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellwidth
    HRESULT SetCellWidth(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellbordercolors
    HRESULT GetCellBorderColors(int* pcrLeft, int* pcrTop, int* pcrRight, int* pcrBottom);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getcellborderwidths
    HRESULT GetCellBorderWidths(int* pduLeft, int* pduTop, int* pduRight, int* pduBottom);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellbordercolors
    HRESULT SetCellBorderColors(int crLeft, int crTop, int crRight, int crBottom);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setcellborderwidths
    HRESULT SetCellBorderWidths(int duLeft, int duTop, int duRight, int duBottom);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-apply
    HRESULT Apply(int cRow, tomConstants Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-canchange
    HRESULT CanChange(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-getproperty
    HRESULT GetProperty(int Type, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-insert
    HRESULT Insert(int cRow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-isequal
    HRESULT IsEqual(ITextRow pRow, int* pB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-reset
    HRESULT Reset(int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nf-tom-itextrow-setproperty
    HRESULT SetProperty(int Type, int Value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tom/nn-tom-itextdisplays
@GUID("c241f5f2-7206-11d8-a2c7-00a0d1d6c6b3")
interface ITextDisplays : IDispatch
{
}

@GUID("01c25500-4268-11d1-883a-3c8b00c10000")
interface ITextDocument2Old : ITextDocument
{
    HRESULT AttachMsgFilter(IUnknown pFilter);
    HRESULT SetEffectColor(int Index, COLORREF cr);
    HRESULT GetEffectColor(int Index, COLORREF* pcr);
    HRESULT GetCaretType(int* pCaretType);
    HRESULT SetCaretType(int CaretType);
    HRESULT GetImmContext(long* pContext);
    HRESULT ReleaseImmContext(long Context);
    HRESULT GetPreferredFont(int cp, int CharRep, int Option, int CharRepCur, int curFontSize, BSTR* pbstr, 
                             int* pPitchAndFamily, int* pNewFontSize);
    HRESULT GetNotificationMode(int* pMode);
    HRESULT SetNotificationMode(int Mode);
    HRESULT GetClientRect(int Type, int* pLeft, int* pTop, int* pRight, int* pBottom);
    HRESULT GetSelection2(ITextSelection* ppSel);
    HRESULT GetWindow(int* phWnd);
    HRESULT GetFEFlags(int* pFlags);
    HRESULT UpdateWindow();
    HRESULT CheckTextLimit(int cch, int* pcch);
    HRESULT IMEInProgress(int Value);
    HRESULT SysBeep();
    HRESULT Update(int Mode);
    HRESULT Notify(int Notify);
    HRESULT GetDocumentFont(ITextFont* ppITextFont);
    HRESULT GetDocumentPara(ITextPara* ppITextPara);
    HRESULT GetCallManager(IUnknown* ppVoid);
    HRESULT ReleaseCallManager(IUnknown pVoid);
}


// GUIDs


const GUID IID_IRichEditOle         = GUIDOF!IRichEditOle;
const GUID IID_IRichEditOleCallback = GUIDOF!IRichEditOleCallback;
const GUID IID_ITextDisplays        = GUIDOF!ITextDisplays;
const GUID IID_ITextDocument        = GUIDOF!ITextDocument;
const GUID IID_ITextDocument2       = GUIDOF!ITextDocument2;
const GUID IID_ITextDocument2Old    = GUIDOF!ITextDocument2Old;
const GUID IID_ITextFont            = GUIDOF!ITextFont;
const GUID IID_ITextFont2           = GUIDOF!ITextFont2;
const GUID IID_ITextPara            = GUIDOF!ITextPara;
const GUID IID_ITextPara2           = GUIDOF!ITextPara2;
const GUID IID_ITextRange           = GUIDOF!ITextRange;
const GUID IID_ITextRange2          = GUIDOF!ITextRange2;
const GUID IID_ITextRow             = GUIDOF!ITextRow;
const GUID IID_ITextSelection       = GUIDOF!ITextSelection;
const GUID IID_ITextSelection2      = GUIDOF!ITextSelection2;
const GUID IID_ITextStory           = GUIDOF!ITextStory;
const GUID IID_ITextStoryRanges     = GUIDOF!ITextStoryRanges;
const GUID IID_ITextStoryRanges2    = GUIDOF!ITextStoryRanges2;
const GUID IID_ITextStrings         = GUIDOF!ITextStrings;
