module windows.controls;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : DVTARGETDEVICE, HRESULT, IDataObject, IDropTarget, IOleClientSite, IOleInPlaceFrame,
                            IOleInPlaceUIWindow, IOleObject, IUnknown, OIFI;
public import windows.direct2d : ID2D1RenderTarget;
public import windows.displaydevices : POINT, RECT, RECTL, SIZE;
public import windows.gdi : BLENDFUNCTION, HBITMAP, HBRUSH, HCURSOR, HDC, HICON, HPALETTE, HPEN, HRGN, RGBQUAD,
                            TEXTMETRICW;
public import windows.intl : HIMC__;
public import windows.menusandresources : HMENU;
public import windows.pointerinput : POINTER_PEN_INFO, POINTER_TOUCH_INFO;
public import windows.shell : LOGFONTW;
public import windows.structuredstorage : IStorage, IStream;
public import windows.systemservices : BOOL, HANDLE, HINSTANCE, LRESULT;
public import windows.windowsaccessibility : IRawElementProviderSimple, IRawElementProviderWindowlessSite, UiaRect;
public import windows.windowsandmessaging : DLGPROC, DLGTEMPLATE, HWND, LPARAM, WINDOWPOS, WPARAM;
public import windows.windowsprogramming : HKEY, SYSTEMTIME;

extern(Windows):


// Enums


enum : int
{
    TVGIPR_BUTTON = 0x00000001,
}
alias TVITEMPART = int;

enum : int
{
    EC_ENDOFLINE_DETECTFROMCONTENT = 0x00000000,
    EC_ENDOFLINE_CRLF              = 0x00000001,
    EC_ENDOFLINE_CR                = 0x00000002,
    EC_ENDOFLINE_LF                = 0x00000003,
}
alias EC_ENDOFLINE = int;

enum : int
{
    EC_SEARCHWEB_ENTRYPOINT_EXTERNAL    = 0x00000000,
    EC_SEARCHWEB_ENTRYPOINT_CONTEXTMENU = 0x00000001,
}
alias EC_SEARCHWEB_ENTRYPOINT = int;

enum : int
{
    TDF_ENABLE_HYPERLINKS           = 0x00000001,
    TDF_USE_HICON_MAIN              = 0x00000002,
    TDF_USE_HICON_FOOTER            = 0x00000004,
    TDF_ALLOW_DIALOG_CANCELLATION   = 0x00000008,
    TDF_USE_COMMAND_LINKS           = 0x00000010,
    TDF_USE_COMMAND_LINKS_NO_ICON   = 0x00000020,
    TDF_EXPAND_FOOTER_AREA          = 0x00000040,
    TDF_EXPANDED_BY_DEFAULT         = 0x00000080,
    TDF_VERIFICATION_FLAG_CHECKED   = 0x00000100,
    TDF_SHOW_PROGRESS_BAR           = 0x00000200,
    TDF_SHOW_MARQUEE_PROGRESS_BAR   = 0x00000400,
    TDF_CALLBACK_TIMER              = 0x00000800,
    TDF_POSITION_RELATIVE_TO_WINDOW = 0x00001000,
    TDF_RTL_LAYOUT                  = 0x00002000,
    TDF_NO_DEFAULT_RADIO_BUTTON     = 0x00004000,
    TDF_CAN_BE_MINIMIZED            = 0x00008000,
    TDF_NO_SET_FOREGROUND           = 0x00010000,
    TDF_SIZE_TO_CONTENT             = 0x01000000,
}
alias _TASKDIALOG_FLAGS = int;

enum : int
{
    TDM_NAVIGATE_PAGE                       = 0x00000465,
    TDM_CLICK_BUTTON                        = 0x00000466,
    TDM_SET_MARQUEE_PROGRESS_BAR            = 0x00000467,
    TDM_SET_PROGRESS_BAR_STATE              = 0x00000468,
    TDM_SET_PROGRESS_BAR_RANGE              = 0x00000469,
    TDM_SET_PROGRESS_BAR_POS                = 0x0000046a,
    TDM_SET_PROGRESS_BAR_MARQUEE            = 0x0000046b,
    TDM_SET_ELEMENT_TEXT                    = 0x0000046c,
    TDM_CLICK_RADIO_BUTTON                  = 0x0000046e,
    TDM_ENABLE_BUTTON                       = 0x0000046f,
    TDM_ENABLE_RADIO_BUTTON                 = 0x00000470,
    TDM_CLICK_VERIFICATION                  = 0x00000471,
    TDM_UPDATE_ELEMENT_TEXT                 = 0x00000472,
    TDM_SET_BUTTON_ELEVATION_REQUIRED_STATE = 0x00000473,
    TDM_UPDATE_ICON                         = 0x00000474,
}
alias TASKDIALOG_MESSAGES = int;

enum : int
{
    TDN_CREATED                = 0x00000000,
    TDN_NAVIGATED              = 0x00000001,
    TDN_BUTTON_CLICKED         = 0x00000002,
    TDN_HYPERLINK_CLICKED      = 0x00000003,
    TDN_TIMER                  = 0x00000004,
    TDN_DESTROYED              = 0x00000005,
    TDN_RADIO_BUTTON_CLICKED   = 0x00000006,
    TDN_DIALOG_CONSTRUCTED     = 0x00000007,
    TDN_VERIFICATION_CLICKED   = 0x00000008,
    TDN_HELP                   = 0x00000009,
    TDN_EXPANDO_BUTTON_CLICKED = 0x0000000a,
}
alias TASKDIALOG_NOTIFICATIONS = int;

enum : int
{
    TDE_CONTENT              = 0x00000000,
    TDE_EXPANDED_INFORMATION = 0x00000001,
    TDE_FOOTER               = 0x00000002,
    TDE_MAIN_INSTRUCTION     = 0x00000003,
}
alias TASKDIALOG_ELEMENTS = int;

enum : int
{
    TDIE_ICON_MAIN   = 0x00000000,
    TDIE_ICON_FOOTER = 0x00000001,
}
alias TASKDIALOG_ICON_ELEMENTS = int;

enum : int
{
    TDCBF_OK_BUTTON     = 0x00000001,
    TDCBF_YES_BUTTON    = 0x00000002,
    TDCBF_NO_BUTTON     = 0x00000004,
    TDCBF_CANCEL_BUTTON = 0x00000008,
    TDCBF_RETRY_BUTTON  = 0x00000010,
    TDCBF_CLOSE_BUTTON  = 0x00000020,
}
alias _TASKDIALOG_COMMON_BUTTON_FLAGS = int;

enum : int
{
    LIM_SMALL = 0x00000000,
    LIM_LARGE = 0x00000001,
}
alias _LI_METRIC = int;

enum : int
{
    TM_PLAINTEXT       = 0x00000001,
    TM_RICHTEXT        = 0x00000002,
    TM_SINGLELEVELUNDO = 0x00000004,
    TM_MULTILEVELUNDO  = 0x00000008,
    TM_SINGLECODEPAGE  = 0x00000010,
    TM_MULTICODEPAGE   = 0x00000020,
}
alias TEXTMODE = int;

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
alias UNDONAMEID = int;

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
alias KHYPH = int;

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
alias tomConstants = int;

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
alias OBJECTTYPE = int;

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
alias MANCODE = int;

enum : int
{
    TXTBACK_TRANSPARENT = 0x00000000,
    TXTBACK_OPAQUE      = 0x00000001,
}
alias TXTBACKSTYLE = int;

enum : int
{
    TXTHITRESULT_NOHIT       = 0x00000000,
    TXTHITRESULT_TRANSPARENT = 0x00000001,
    TXTHITRESULT_CLOSE       = 0x00000002,
    TXTHITRESULT_HIT         = 0x00000003,
}
alias TXTHITRESULT = int;

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
alias TXTNATURALSIZE = int;

enum : int
{
    TXTVIEW_ACTIVE   = 0x00000000,
    TXTVIEW_INACTIVE = 0xffffffff,
}
alias TXTVIEW = int;

enum : int
{
    CN_GENERIC     = 0x00000000,
    CN_TEXTCHANGED = 0x00000001,
    CN_NEWUNDO     = 0x00000002,
    CN_NEWREDO     = 0x00000004,
}
alias CHANGETYPE = int;

enum : int
{
    CARET_NONE     = 0x00000000,
    CARET_CUSTOM   = 0x00000001,
    CARET_RTL      = 0x00000002,
    CARET_ITALIC   = 0x00000020,
    CARET_NULL     = 0x00000040,
    CARET_ROTATE90 = 0x00000080,
}
alias CARET_FLAGS = int;

enum : int
{
    TAP_FLAGS              = 0x00000000,
    TAP_TRANSFORMCOUNT     = 0x00000001,
    TAP_STAGGERDELAY       = 0x00000002,
    TAP_STAGGERDELAYCAP    = 0x00000003,
    TAP_STAGGERDELAYFACTOR = 0x00000004,
    TAP_ZORDER             = 0x00000005,
}
alias TA_PROPERTY = int;

enum : int
{
    TAPF_NONE            = 0x00000000,
    TAPF_HASSTAGGER      = 0x00000001,
    TAPF_ISRTLAWARE      = 0x00000002,
    TAPF_ALLOWCOLLECTION = 0x00000004,
    TAPF_HASBACKGROUND   = 0x00000008,
    TAPF_HASPERSPECTIVE  = 0x00000010,
}
alias TA_PROPERTY_FLAG = int;

enum : int
{
    TATT_TRANSLATE_2D = 0x00000000,
    TATT_SCALE_2D     = 0x00000001,
    TATT_OPACITY      = 0x00000002,
    TATT_CLIP         = 0x00000003,
}
alias TA_TRANSFORM_TYPE = int;

enum : int
{
    TATF_NONE              = 0x00000000,
    TATF_TARGETVALUES_USER = 0x00000001,
    TATF_HASINITIALVALUES  = 0x00000002,
    TATF_HASORIGINVALUES   = 0x00000004,
}
alias TA_TRANSFORM_FLAG = int;

enum : int
{
    TTFT_UNDEFINED    = 0x00000000,
    TTFT_CUBIC_BEZIER = 0x00000001,
}
alias TA_TIMINGFUNCTION_TYPE = int;

enum : int
{
    TS_MIN  = 0x00000000,
    TS_TRUE = 0x00000001,
    TS_DRAW = 0x00000002,
}
alias THEMESIZE = int;

enum : int
{
    PO_STATE    = 0x00000000,
    PO_PART     = 0x00000001,
    PO_CLASS    = 0x00000002,
    PO_GLOBAL   = 0x00000003,
    PO_NOTFOUND = 0x00000004,
}
alias PROPERTYORIGIN = int;

enum : int
{
    WTA_NONCLIENT = 0x00000001,
}
alias WINDOWTHEMEATTRIBUTETYPE = int;

enum : int
{
    BPBF_COMPATIBLEBITMAP = 0x00000000,
    BPBF_DIB              = 0x00000001,
    BPBF_TOPDOWNDIB       = 0x00000002,
    BPBF_TOPDOWNMONODIB   = 0x00000003,
}
alias BP_BUFFERFORMAT = int;

enum : int
{
    BPAS_NONE   = 0x00000000,
    BPAS_LINEAR = 0x00000001,
    BPAS_CUBIC  = 0x00000002,
    BPAS_SINE   = 0x00000003,
}
alias BP_ANIMATIONSTYLE = int;

enum : int
{
    POINTER_FEEDBACK_DEFAULT  = 0x00000001,
    POINTER_FEEDBACK_INDIRECT = 0x00000002,
    POINTER_FEEDBACK_NONE     = 0x00000003,
}
alias POINTER_FEEDBACK_MODE = int;

enum : int
{
    FEEDBACK_TOUCH_CONTACTVISUALIZATION = 0x00000001,
    FEEDBACK_PEN_BARRELVISUALIZATION    = 0x00000002,
    FEEDBACK_PEN_TAP                    = 0x00000003,
    FEEDBACK_PEN_DOUBLETAP              = 0x00000004,
    FEEDBACK_PEN_PRESSANDHOLD           = 0x00000005,
    FEEDBACK_PEN_RIGHTTAP               = 0x00000006,
    FEEDBACK_TOUCH_TAP                  = 0x00000007,
    FEEDBACK_TOUCH_DOUBLETAP            = 0x00000008,
    FEEDBACK_TOUCH_PRESSANDHOLD         = 0x00000009,
    FEEDBACK_TOUCH_RIGHTTAP             = 0x0000000a,
    FEEDBACK_GESTURE_PRESSANDTAP        = 0x0000000b,
    FEEDBACK_MAX                        = 0xffffffff,
}
alias FEEDBACK_TYPE = int;

enum : int
{
    POINTER_DEVICE_TYPE_INTEGRATED_PEN = 0x00000001,
    POINTER_DEVICE_TYPE_EXTERNAL_PEN   = 0x00000002,
    POINTER_DEVICE_TYPE_TOUCH          = 0x00000003,
    POINTER_DEVICE_TYPE_TOUCH_PAD      = 0x00000004,
    POINTER_DEVICE_TYPE_MAX            = 0xffffffff,
}
alias POINTER_DEVICE_TYPE = int;

enum : int
{
    POINTER_DEVICE_CURSOR_TYPE_UNKNOWN = 0x00000000,
    POINTER_DEVICE_CURSOR_TYPE_TIP     = 0x00000001,
    POINTER_DEVICE_CURSOR_TYPE_ERASER  = 0x00000002,
    POINTER_DEVICE_CURSOR_TYPE_MAX     = 0xffffffff,
}
alias POINTER_DEVICE_CURSOR_TYPE = int;

enum : int
{
    IMDT_UNAVAILABLE = 0x00000000,
    IMDT_KEYBOARD    = 0x00000001,
    IMDT_MOUSE       = 0x00000002,
    IMDT_TOUCH       = 0x00000004,
    IMDT_PEN         = 0x00000008,
    IMDT_TOUCHPAD    = 0x00000010,
}
alias INPUT_MESSAGE_DEVICE_TYPE = int;

enum : int
{
    IMO_UNAVAILABLE = 0x00000000,
    IMO_HARDWARE    = 0x00000001,
    IMO_INJECTED    = 0x00000002,
    IMO_SYSTEM      = 0x00000004,
}
alias INPUT_MESSAGE_ORIGIN_ID = int;

// Callbacks

alias LPFNPSPCALLBACKA = uint function(HWND hwnd, uint uMsg, PROPSHEETPAGEA* ppsp);
alias LPFNPSPCALLBACKW = uint function(HWND hwnd, uint uMsg, PROPSHEETPAGEW* ppsp);
alias PFNPROPSHEETCALLBACK = int function(HWND param0, uint param1, LPARAM param2);
alias LPFNADDPROPSHEETPAGE = BOOL function(HPROPSHEETPAGE param0, LPARAM param1);
alias LPFNADDPROPSHEETPAGES = BOOL function(void* param0, LPFNADDPROPSHEETPAGE param1, LPARAM param2);
alias PFNLVCOMPARE = int function(LPARAM param0, LPARAM param1, LPARAM param2);
alias PFNLVGROUPCOMPARE = int function(int param0, int param1, void* param2);
alias PFNTVCOMPARE = int function(LPARAM lParam1, LPARAM lParam2, LPARAM lParamSort);
alias PFTASKDIALOGCALLBACK = HRESULT function(HWND hwnd, uint msg, WPARAM wParam, LPARAM lParam, 
                                              ptrdiff_t lpRefData);
alias PFNDAENUMCALLBACK = int function(void* p, void* pData);
alias PFNDAENUMCALLBACKCONST = int function(const(void)* p, void* pData);
alias PFNDACOMPARE = int function(void* p1, void* p2, LPARAM lParam);
alias PFNDACOMPARECONST = int function(const(void)* p1, const(void)* p2, LPARAM lParam);
alias PFNDPASTREAM = HRESULT function(DPASTREAMINFO* pinfo, IStream pstream, void* pvInstData);
alias PFNDPAMERGE = void* function(uint uMsg, void* pvDest, void* pvSrc, LPARAM lParam);
alias PFNDPAMERGECONST = void* function(uint uMsg, const(void)* pvDest, const(void)* pvSrc, LPARAM lParam);
alias AutoCorrectProc = int function(ushort langid, const(wchar)* pszBefore, ushort* pszAfter, int cchAfter, 
                                     int* pcchReplaced);
alias EDITWORDBREAKPROCEX = int function(byte* pchText, int cchText, ubyte bCharSet, int action);
alias EDITSTREAMCALLBACK = uint function(size_t dwCookie, ubyte* pbBuff, int cb, int* pcb);
alias PCreateTextServices = HRESULT function(IUnknown punkOuter, ITextHost pITextHost, IUnknown* ppUnk);
alias PShutdownTextServices = HRESULT function(IUnknown pTextServices);
alias DTT_CALLBACK_PROC = int function(HDC hdc, const(wchar)* pszText, int cchText, RECT* prc, uint dwFlags, 
                                       LPARAM lParam);
alias EDITWORDBREAKPROCA = int function(const(char)* lpch, int ichCurrent, int cch, int code);
alias EDITWORDBREAKPROCW = int function(const(wchar)* lpch, int ichCurrent, int cch, int code);

// Structs


alias HIMAGELIST = ptrdiff_t;

alias HPROPSHEETPAGE = ptrdiff_t;

struct CRGB
{
    ubyte bRed;
    ubyte bGreen;
    ubyte bBlue;
    ubyte bExtra;
}

struct _PSP
{
}

struct PROPSHEETPAGEA_V1
{
    uint             dwSize;
    uint             dwFlags;
    HINSTANCE        hInstance;
    union
    {
        const(char)* pszTemplate;
        DLGTEMPLATE* pResource;
    }
    union
    {
        HICON        hIcon;
        const(char)* pszIcon;
    }
    const(char)*     pszTitle;
    DLGPROC          pfnDlgProc;
    LPARAM           lParam;
    LPFNPSPCALLBACKA pfnCallback;
    uint*            pcRefParent;
}

struct PROPSHEETPAGEA_V2
{
    uint             dwSize;
    uint             dwFlags;
    HINSTANCE        hInstance;
    union
    {
        const(char)* pszTemplate;
        DLGTEMPLATE* pResource;
    }
    union
    {
        HICON        hIcon;
        const(char)* pszIcon;
    }
    const(char)*     pszTitle;
    DLGPROC          pfnDlgProc;
    LPARAM           lParam;
    LPFNPSPCALLBACKA pfnCallback;
    uint*            pcRefParent;
    const(char)*     pszHeaderTitle;
    const(char)*     pszHeaderSubTitle;
}

struct PROPSHEETPAGEA_V3
{
    uint             dwSize;
    uint             dwFlags;
    HINSTANCE        hInstance;
    union
    {
        const(char)* pszTemplate;
        DLGTEMPLATE* pResource;
    }
    union
    {
        HICON        hIcon;
        const(char)* pszIcon;
    }
    const(char)*     pszTitle;
    DLGPROC          pfnDlgProc;
    LPARAM           lParam;
    LPFNPSPCALLBACKA pfnCallback;
    uint*            pcRefParent;
    const(char)*     pszHeaderTitle;
    const(char)*     pszHeaderSubTitle;
    HANDLE           hActCtx;
}

struct PROPSHEETPAGEA
{
    uint             dwSize;
    uint             dwFlags;
    HINSTANCE        hInstance;
    union
    {
        const(char)* pszTemplate;
        DLGTEMPLATE* pResource;
    }
    union
    {
        HICON        hIcon;
        const(char)* pszIcon;
    }
    const(char)*     pszTitle;
    DLGPROC          pfnDlgProc;
    LPARAM           lParam;
    LPFNPSPCALLBACKA pfnCallback;
    uint*            pcRefParent;
    const(char)*     pszHeaderTitle;
    const(char)*     pszHeaderSubTitle;
    HANDLE           hActCtx;
    union
    {
        HBITMAP      hbmHeader;
        const(char)* pszbmHeader;
    }
}

struct PROPSHEETPAGEW_V1
{
    uint             dwSize;
    uint             dwFlags;
    HINSTANCE        hInstance;
    union
    {
        const(wchar)* pszTemplate;
        DLGTEMPLATE*  pResource;
    }
    union
    {
        HICON         hIcon;
        const(wchar)* pszIcon;
    }
    const(wchar)*    pszTitle;
    DLGPROC          pfnDlgProc;
    LPARAM           lParam;
    LPFNPSPCALLBACKW pfnCallback;
    uint*            pcRefParent;
}

struct PROPSHEETPAGEW_V2
{
    uint             dwSize;
    uint             dwFlags;
    HINSTANCE        hInstance;
    union
    {
        const(wchar)* pszTemplate;
        DLGTEMPLATE*  pResource;
    }
    union
    {
        HICON         hIcon;
        const(wchar)* pszIcon;
    }
    const(wchar)*    pszTitle;
    DLGPROC          pfnDlgProc;
    LPARAM           lParam;
    LPFNPSPCALLBACKW pfnCallback;
    uint*            pcRefParent;
    const(wchar)*    pszHeaderTitle;
    const(wchar)*    pszHeaderSubTitle;
}

struct PROPSHEETPAGEW_V3
{
    uint             dwSize;
    uint             dwFlags;
    HINSTANCE        hInstance;
    union
    {
        const(wchar)* pszTemplate;
        DLGTEMPLATE*  pResource;
    }
    union
    {
        HICON         hIcon;
        const(wchar)* pszIcon;
    }
    const(wchar)*    pszTitle;
    DLGPROC          pfnDlgProc;
    LPARAM           lParam;
    LPFNPSPCALLBACKW pfnCallback;
    uint*            pcRefParent;
    const(wchar)*    pszHeaderTitle;
    const(wchar)*    pszHeaderSubTitle;
    HANDLE           hActCtx;
}

struct PROPSHEETPAGEW
{
    uint             dwSize;
    uint             dwFlags;
    HINSTANCE        hInstance;
    union
    {
        const(wchar)* pszTemplate;
        DLGTEMPLATE*  pResource;
    }
    union
    {
        HICON         hIcon;
        const(wchar)* pszIcon;
    }
    const(wchar)*    pszTitle;
    DLGPROC          pfnDlgProc;
    LPARAM           lParam;
    LPFNPSPCALLBACKW pfnCallback;
    uint*            pcRefParent;
    const(wchar)*    pszHeaderTitle;
    const(wchar)*    pszHeaderSubTitle;
    HANDLE           hActCtx;
    union
    {
        HBITMAP       hbmHeader;
        const(wchar)* pszbmHeader;
    }
}

struct PROPSHEETHEADERA_V1
{
    uint                 dwSize;
    uint                 dwFlags;
    HWND                 hwndParent;
    HINSTANCE            hInstance;
    union
    {
        HICON        hIcon;
        const(char)* pszIcon;
    }
    const(char)*         pszCaption;
    uint                 nPages;
    union
    {
        uint         nStartPage;
        const(char)* pStartPage;
    }
    union
    {
        PROPSHEETPAGEA* ppsp;
        HPROPSHEETPAGE* phpage;
    }
    PFNPROPSHEETCALLBACK pfnCallback;
}

struct PROPSHEETHEADERA_V2
{
    uint                 dwSize;
    uint                 dwFlags;
    HWND                 hwndParent;
    HINSTANCE            hInstance;
    union
    {
        HICON        hIcon;
        const(char)* pszIcon;
    }
    const(char)*         pszCaption;
    uint                 nPages;
    union
    {
        uint         nStartPage;
        const(char)* pStartPage;
    }
    union
    {
        PROPSHEETPAGEA* ppsp;
        HPROPSHEETPAGE* phpage;
    }
    PFNPROPSHEETCALLBACK pfnCallback;
    union
    {
        HBITMAP      hbmWatermark;
        const(char)* pszbmWatermark;
    }
    HPALETTE             hplWatermark;
    union
    {
        HBITMAP      hbmHeader;
        const(char)* pszbmHeader;
    }
}

struct PROPSHEETHEADERW_V1
{
    uint                 dwSize;
    uint                 dwFlags;
    HWND                 hwndParent;
    HINSTANCE            hInstance;
    union
    {
        HICON         hIcon;
        const(wchar)* pszIcon;
    }
    const(wchar)*        pszCaption;
    uint                 nPages;
    union
    {
        uint          nStartPage;
        const(wchar)* pStartPage;
    }
    union
    {
        PROPSHEETPAGEW* ppsp;
        HPROPSHEETPAGE* phpage;
    }
    PFNPROPSHEETCALLBACK pfnCallback;
}

struct PROPSHEETHEADERW_V2
{
    uint                 dwSize;
    uint                 dwFlags;
    HWND                 hwndParent;
    HINSTANCE            hInstance;
    union
    {
        HICON         hIcon;
        const(wchar)* pszIcon;
    }
    const(wchar)*        pszCaption;
    uint                 nPages;
    union
    {
        uint          nStartPage;
        const(wchar)* pStartPage;
    }
    union
    {
        PROPSHEETPAGEW* ppsp;
        HPROPSHEETPAGE* phpage;
    }
    PFNPROPSHEETCALLBACK pfnCallback;
    union
    {
        HBITMAP       hbmWatermark;
        const(wchar)* pszbmWatermark;
    }
    HPALETTE             hplWatermark;
    union
    {
        HBITMAP       hbmHeader;
        const(wchar)* pszbmHeader;
    }
}

struct PSHNOTIFY
{
    NMHDR  hdr;
    LPARAM lParam;
}

struct INITCOMMONCONTROLSEX
{
    uint dwSize;
    uint dwICC;
}

struct COLORSCHEME
{
    uint dwSize;
    uint clrBtnHighlight;
    uint clrBtnShadow;
}

struct NMTOOLTIPSCREATED
{
    NMHDR hdr;
    HWND  hwndToolTips;
}

struct NMMOUSE
{
    NMHDR  hdr;
    size_t dwItemSpec;
    size_t dwItemData;
    POINT  pt;
    LPARAM dwHitInfo;
}

struct NMOBJECTNOTIFY
{
    NMHDR        hdr;
    int          iItem;
    const(GUID)* piid;
    void*        pObject;
    HRESULT      hResult;
    uint         dwFlags;
}

struct NMKEY
{
    NMHDR hdr;
    uint  nVKey;
    uint  uFlags;
}

struct NMCHAR
{
    NMHDR hdr;
    uint  ch;
    uint  dwItemPrev;
    uint  dwItemNext;
}

struct NMCUSTOMTEXT
{
    NMHDR         hdr;
    HDC           hDC;
    const(wchar)* lpString;
    int           nCount;
    RECT*         lpRect;
    uint          uFormat;
    BOOL          fLink;
}

struct NMCUSTOMDRAW
{
    NMHDR  hdr;
    uint   dwDrawStage;
    HDC    hdc;
    RECT   rc;
    size_t dwItemSpec;
    uint   uItemState;
    LPARAM lItemlParam;
}

struct NMTTCUSTOMDRAW
{
    NMCUSTOMDRAW nmcd;
    uint         uDrawFlags;
}

struct NMCUSTOMSPLITRECTINFO
{
    NMHDR hdr;
    RECT  rcClient;
    RECT  rcButton;
    RECT  rcSplit;
}

struct _IMAGELIST
{
}

struct IMAGELISTDRAWPARAMS
{
    uint       cbSize;
    HIMAGELIST himl;
    int        i;
    HDC        hdcDst;
    int        x;
    int        y;
    int        cx;
    int        cy;
    int        xBitmap;
    int        yBitmap;
    uint       rgbBk;
    uint       rgbFg;
    uint       fStyle;
    uint       dwRop;
    uint       fState;
    uint       Frame;
    uint       crEffect;
}

struct IMAGEINFO
{
    HBITMAP hbmImage;
    HBITMAP hbmMask;
    int     Unused1;
    int     Unused2;
    RECT    rcImage;
}

struct HD_TEXTFILTERA
{
    const(char)* pszText;
    int          cchTextMax;
}

struct HD_TEXTFILTERW
{
    const(wchar)* pszText;
    int           cchTextMax;
}

struct HDITEMA
{
    uint         mask;
    int          cxy;
    const(char)* pszText;
    HBITMAP      hbm;
    int          cchTextMax;
    int          fmt;
    LPARAM       lParam;
    int          iImage;
    int          iOrder;
    uint         type;
    void*        pvFilter;
    uint         state;
}

struct HDITEMW
{
    uint          mask;
    int           cxy;
    const(wchar)* pszText;
    HBITMAP       hbm;
    int           cchTextMax;
    int           fmt;
    LPARAM        lParam;
    int           iImage;
    int           iOrder;
    uint          type;
    void*         pvFilter;
    uint          state;
}

struct HDLAYOUT
{
    RECT*      prc;
    WINDOWPOS* pwpos;
}

struct HDHITTESTINFO
{
    POINT pt;
    uint  flags;
    int   iItem;
}

struct NMHEADERA
{
    NMHDR    hdr;
    int      iItem;
    int      iButton;
    HDITEMA* pitem;
}

struct NMHEADERW
{
    NMHDR    hdr;
    int      iItem;
    int      iButton;
    HDITEMW* pitem;
}

struct NMHDDISPINFOW
{
    NMHDR         hdr;
    int           iItem;
    uint          mask;
    const(wchar)* pszText;
    int           cchTextMax;
    int           iImage;
    LPARAM        lParam;
}

struct NMHDDISPINFOA
{
    NMHDR        hdr;
    int          iItem;
    uint         mask;
    const(char)* pszText;
    int          cchTextMax;
    int          iImage;
    LPARAM       lParam;
}

struct NMHDFILTERBTNCLICK
{
    NMHDR hdr;
    int   iItem;
    RECT  rc;
}

struct TBBUTTON
{
    int       iBitmap;
    int       idCommand;
    ubyte     fsState;
    ubyte     fsStyle;
    ubyte[2]  bReserved;
    size_t    dwData;
    ptrdiff_t iString;
}

struct COLORMAP
{
    uint from;
    uint to;
}

struct NMTBCUSTOMDRAW
{
    NMCUSTOMDRAW nmcd;
    HBRUSH       hbrMonoDither;
    HBRUSH       hbrLines;
    HPEN         hpenLines;
    uint         clrText;
    uint         clrMark;
    uint         clrTextHighlight;
    uint         clrBtnFace;
    uint         clrBtnHighlight;
    uint         clrHighlightHotTrack;
    RECT         rcText;
    int          nStringBkMode;
    int          nHLStringBkMode;
    int          iListGap;
}

struct TBADDBITMAP
{
    HINSTANCE hInst;
    size_t    nID;
}

struct TBSAVEPARAMSA
{
    HKEY         hkr;
    const(char)* pszSubKey;
    const(char)* pszValueName;
}

struct TBSAVEPARAMSW
{
    HKEY          hkr;
    const(wchar)* pszSubKey;
    const(wchar)* pszValueName;
}

struct TBINSERTMARK
{
    int  iButton;
    uint dwFlags;
}

struct TBREPLACEBITMAP
{
    HINSTANCE hInstOld;
    size_t    nIDOld;
    HINSTANCE hInstNew;
    size_t    nIDNew;
    int       nButtons;
}

struct TBBUTTONINFOA
{
    uint         cbSize;
    uint         dwMask;
    int          idCommand;
    int          iImage;
    ubyte        fsState;
    ubyte        fsStyle;
    ushort       cx;
    size_t       lParam;
    const(char)* pszText;
    int          cchText;
}

struct TBBUTTONINFOW
{
    uint          cbSize;
    uint          dwMask;
    int           idCommand;
    int           iImage;
    ubyte         fsState;
    ubyte         fsStyle;
    ushort        cx;
    size_t        lParam;
    const(wchar)* pszText;
    int           cchText;
}

struct TBMETRICS
{
    uint cbSize;
    uint dwMask;
    int  cxPad;
    int  cyPad;
    int  cxBarPad;
    int  cyBarPad;
    int  cxButtonSpacing;
    int  cyButtonSpacing;
}

struct NMTBHOTITEM
{
    NMHDR hdr;
    int   idOld;
    int   idNew;
    uint  dwFlags;
}

struct NMTBSAVE
{
    NMHDR    hdr;
    uint*    pData;
    uint*    pCurrent;
    uint     cbData;
    int      iItem;
    int      cButtons;
    TBBUTTON tbButton;
}

struct NMTBRESTORE
{
    NMHDR    hdr;
    uint*    pData;
    uint*    pCurrent;
    uint     cbData;
    int      iItem;
    int      cButtons;
    int      cbBytesPerRecord;
    TBBUTTON tbButton;
}

struct NMTBGETINFOTIPA
{
    NMHDR        hdr;
    const(char)* pszText;
    int          cchTextMax;
    int          iItem;
    LPARAM       lParam;
}

struct NMTBGETINFOTIPW
{
    NMHDR         hdr;
    const(wchar)* pszText;
    int           cchTextMax;
    int           iItem;
    LPARAM        lParam;
}

struct NMTBDISPINFOA
{
    NMHDR        hdr;
    uint         dwMask;
    int          idCommand;
    size_t       lParam;
    int          iImage;
    const(char)* pszText;
    int          cchText;
}

struct NMTBDISPINFOW
{
    NMHDR         hdr;
    uint          dwMask;
    int           idCommand;
    size_t        lParam;
    int           iImage;
    const(wchar)* pszText;
    int           cchText;
}

struct NMTOOLBARA
{
    NMHDR        hdr;
    int          iItem;
    TBBUTTON     tbButton;
    int          cchText;
    const(char)* pszText;
    RECT         rcButton;
}

struct NMTOOLBARW
{
    NMHDR         hdr;
    int           iItem;
    TBBUTTON      tbButton;
    int           cchText;
    const(wchar)* pszText;
    RECT          rcButton;
}

struct REBARINFO
{
    uint       cbSize;
    uint       fMask;
    HIMAGELIST himl;
}

struct REBARBANDINFOA
{
    uint         cbSize;
    uint         fMask;
    uint         fStyle;
    uint         clrFore;
    uint         clrBack;
    const(char)* lpText;
    uint         cch;
    int          iImage;
    HWND         hwndChild;
    uint         cxMinChild;
    uint         cyMinChild;
    uint         cx;
    HBITMAP      hbmBack;
    uint         wID;
    uint         cyChild;
    uint         cyMaxChild;
    uint         cyIntegral;
    uint         cxIdeal;
    LPARAM       lParam;
    uint         cxHeader;
    RECT         rcChevronLocation;
    uint         uChevronState;
}

struct REBARBANDINFOW
{
    uint          cbSize;
    uint          fMask;
    uint          fStyle;
    uint          clrFore;
    uint          clrBack;
    const(wchar)* lpText;
    uint          cch;
    int           iImage;
    HWND          hwndChild;
    uint          cxMinChild;
    uint          cyMinChild;
    uint          cx;
    HBITMAP       hbmBack;
    uint          wID;
    uint          cyChild;
    uint          cyMaxChild;
    uint          cyIntegral;
    uint          cxIdeal;
    LPARAM        lParam;
    uint          cxHeader;
    RECT          rcChevronLocation;
    uint          uChevronState;
}

struct NMREBARCHILDSIZE
{
    NMHDR hdr;
    uint  uBand;
    uint  wID;
    RECT  rcChild;
    RECT  rcBand;
}

struct NMREBAR
{
    NMHDR  hdr;
    uint   dwMask;
    uint   uBand;
    uint   fStyle;
    uint   wID;
    LPARAM lParam;
}

struct NMRBAUTOSIZE
{
    NMHDR hdr;
    BOOL  fChanged;
    RECT  rcTarget;
    RECT  rcActual;
}

struct NMREBARCHEVRON
{
    NMHDR  hdr;
    uint   uBand;
    uint   wID;
    LPARAM lParam;
    RECT   rc;
    LPARAM lParamNM;
}

struct NMREBARSPLITTER
{
    NMHDR hdr;
    RECT  rcSizing;
}

struct NMREBARAUTOBREAK
{
    NMHDR  hdr;
    uint   uBand;
    uint   wID;
    LPARAM lParam;
    uint   uMsg;
    uint   fStyleCurrent;
    BOOL   fAutoBreak;
}

struct RBHITTESTINFO
{
    POINT pt;
    uint  flags;
    int   iBand;
}

struct TTTOOLINFOA
{
    uint         cbSize;
    uint         uFlags;
    HWND         hwnd;
    size_t       uId;
    RECT         rect;
    HINSTANCE    hinst;
    const(char)* lpszText;
    LPARAM       lParam;
    void*        lpReserved;
}

struct TTTOOLINFOW
{
    uint          cbSize;
    uint          uFlags;
    HWND          hwnd;
    size_t        uId;
    RECT          rect;
    HINSTANCE     hinst;
    const(wchar)* lpszText;
    LPARAM        lParam;
    void*         lpReserved;
}

struct TTGETTITLE
{
    uint    dwSize;
    uint    uTitleBitmap;
    uint    cch;
    ushort* pszTitle;
}

struct TTHITTESTINFOA
{
    HWND        hwnd;
    POINT       pt;
    TTTOOLINFOA ti;
}

struct TTHITTESTINFOW
{
    HWND        hwnd;
    POINT       pt;
    TTTOOLINFOW ti;
}

struct NMTTDISPINFOA
{
    NMHDR        hdr;
    const(char)* lpszText;
    byte[80]     szText;
    HINSTANCE    hinst;
    uint         uFlags;
    LPARAM       lParam;
}

struct NMTTDISPINFOW
{
    NMHDR         hdr;
    const(wchar)* lpszText;
    ushort[80]    szText;
    HINSTANCE     hinst;
    uint          uFlags;
    LPARAM        lParam;
}

struct NMTRBTHUMBPOSCHANGING
{
    NMHDR hdr;
    uint  dwPos;
    int   nReason;
}

struct DRAGLISTINFO
{
    uint  uNotification;
    HWND  hWnd;
    POINT ptCursor;
}

struct UDACCEL
{
    uint nSec;
    uint nInc;
}

struct NMUPDOWN
{
    NMHDR hdr;
    int   iPos;
    int   iDelta;
}

struct PBRANGE
{
    int iLow;
    int iHigh;
}

struct LITEM
{
    uint         mask;
    int          iLink;
    uint         state;
    uint         stateMask;
    ushort[48]   szID;
    ushort[2084] szUrl;
}

struct LHITTESTINFO
{
    POINT pt;
    LITEM item;
}

struct NMLINK
{
    NMHDR hdr;
    LITEM item;
}

struct LVITEMA
{
    uint         mask;
    int          iItem;
    int          iSubItem;
    uint         state;
    uint         stateMask;
    const(char)* pszText;
    int          cchTextMax;
    int          iImage;
    LPARAM       lParam;
    int          iIndent;
    int          iGroupId;
    uint         cColumns;
    uint*        puColumns;
    int*         piColFmt;
    int          iGroup;
}

struct LVITEMW
{
    uint          mask;
    int           iItem;
    int           iSubItem;
    uint          state;
    uint          stateMask;
    const(wchar)* pszText;
    int           cchTextMax;
    int           iImage;
    LPARAM        lParam;
    int           iIndent;
    int           iGroupId;
    uint          cColumns;
    uint*         puColumns;
    int*          piColFmt;
    int           iGroup;
}

struct LVFINDINFOA
{
    uint         flags;
    const(char)* psz;
    LPARAM       lParam;
    POINT        pt;
    uint         vkDirection;
}

struct LVFINDINFOW
{
    uint          flags;
    const(wchar)* psz;
    LPARAM        lParam;
    POINT         pt;
    uint          vkDirection;
}

struct LVHITTESTINFO
{
    POINT pt;
    uint  flags;
    int   iItem;
    int   iSubItem;
    int   iGroup;
}

struct LVCOLUMNA
{
    uint         mask;
    int          fmt;
    int          cx;
    const(char)* pszText;
    int          cchTextMax;
    int          iSubItem;
    int          iImage;
    int          iOrder;
    int          cxMin;
    int          cxDefault;
    int          cxIdeal;
}

struct LVCOLUMNW
{
    uint          mask;
    int           fmt;
    int           cx;
    const(wchar)* pszText;
    int           cchTextMax;
    int           iSubItem;
    int           iImage;
    int           iOrder;
    int           cxMin;
    int           cxDefault;
    int           cxIdeal;
}

struct LVBKIMAGEA
{
    uint         ulFlags;
    HBITMAP      hbm;
    const(char)* pszImage;
    uint         cchImageMax;
    int          xOffsetPercent;
    int          yOffsetPercent;
}

struct LVBKIMAGEW
{
    uint          ulFlags;
    HBITMAP       hbm;
    const(wchar)* pszImage;
    uint          cchImageMax;
    int           xOffsetPercent;
    int           yOffsetPercent;
}

struct LVGROUP
{
    uint          cbSize;
    uint          mask;
    const(wchar)* pszHeader;
    int           cchHeader;
    const(wchar)* pszFooter;
    int           cchFooter;
    int           iGroupId;
    uint          stateMask;
    uint          state;
    uint          uAlign;
    const(wchar)* pszSubtitle;
    uint          cchSubtitle;
    const(wchar)* pszTask;
    uint          cchTask;
    const(wchar)* pszDescriptionTop;
    uint          cchDescriptionTop;
    const(wchar)* pszDescriptionBottom;
    uint          cchDescriptionBottom;
    int           iTitleImage;
    int           iExtendedImage;
    int           iFirstItem;
    uint          cItems;
    const(wchar)* pszSubsetTitle;
    uint          cchSubsetTitle;
}

struct LVGROUPMETRICS
{
    uint cbSize;
    uint mask;
    uint Left;
    uint Top;
    uint Right;
    uint Bottom;
    uint crLeft;
    uint crTop;
    uint crRight;
    uint crBottom;
    uint crHeader;
    uint crFooter;
}

struct LVINSERTGROUPSORTED
{
    PFNLVGROUPCOMPARE pfnGroupCompare;
    void*             pvData;
    LVGROUP           lvGroup;
}

struct LVTILEVIEWINFO
{
    uint cbSize;
    uint dwMask;
    uint dwFlags;
    SIZE sizeTile;
    int  cLines;
    RECT rcLabelMargin;
}

struct LVTILEINFO
{
    uint  cbSize;
    int   iItem;
    uint  cColumns;
    uint* puColumns;
    int*  piColFmt;
}

struct LVINSERTMARK
{
    uint cbSize;
    uint dwFlags;
    int  iItem;
    uint dwReserved;
}

struct LVSETINFOTIP
{
    uint          cbSize;
    uint          dwFlags;
    const(wchar)* pszText;
    int           iItem;
    int           iSubItem;
}

struct LVFOOTERINFO
{
    uint          mask;
    const(wchar)* pszText;
    int           cchTextMax;
    uint          cItems;
}

struct LVFOOTERITEM
{
    uint          mask;
    int           iItem;
    const(wchar)* pszText;
    int           cchTextMax;
    uint          state;
    uint          stateMask;
}

struct LVITEMINDEX
{
    int iItem;
    int iGroup;
}

struct NMLISTVIEW
{
    NMHDR  hdr;
    int    iItem;
    int    iSubItem;
    uint   uNewState;
    uint   uOldState;
    uint   uChanged;
    POINT  ptAction;
    LPARAM lParam;
}

struct NMITEMACTIVATE
{
    NMHDR  hdr;
    int    iItem;
    int    iSubItem;
    uint   uNewState;
    uint   uOldState;
    uint   uChanged;
    POINT  ptAction;
    LPARAM lParam;
    uint   uKeyFlags;
}

struct NMLVCUSTOMDRAW
{
    NMCUSTOMDRAW nmcd;
    uint         clrText;
    uint         clrTextBk;
    int          iSubItem;
    uint         dwItemType;
    uint         clrFace;
    int          iIconEffect;
    int          iIconPhase;
    int          iPartId;
    int          iStateId;
    RECT         rcText;
    uint         uAlign;
}

struct NMLVCACHEHINT
{
    NMHDR hdr;
    int   iFrom;
    int   iTo;
}

struct NMLVFINDITEMA
{
    NMHDR       hdr;
    int         iStart;
    LVFINDINFOA lvfi;
}

struct NMLVFINDITEMW
{
    NMHDR       hdr;
    int         iStart;
    LVFINDINFOW lvfi;
}

struct NMLVODSTATECHANGE
{
    NMHDR hdr;
    int   iFrom;
    int   iTo;
    uint  uNewState;
    uint  uOldState;
}

struct NMLVDISPINFOA
{
    NMHDR   hdr;
    LVITEMA item;
}

struct NMLVDISPINFOW
{
    NMHDR   hdr;
    LVITEMW item;
}

struct NMLVKEYDOWN
{
align (1):
    NMHDR  hdr;
    ushort wVKey;
    uint   flags;
}

struct NMLVLINK
{
    NMHDR hdr;
    LITEM link;
    int   iItem;
    int   iSubItem;
}

struct NMLVGETINFOTIPA
{
    NMHDR        hdr;
    uint         dwFlags;
    const(char)* pszText;
    int          cchTextMax;
    int          iItem;
    int          iSubItem;
    LPARAM       lParam;
}

struct NMLVGETINFOTIPW
{
    NMHDR         hdr;
    uint          dwFlags;
    const(wchar)* pszText;
    int           cchTextMax;
    int           iItem;
    int           iSubItem;
    LPARAM        lParam;
}

struct NMLVSCROLL
{
    NMHDR hdr;
    int   dx;
    int   dy;
}

struct NMLVEMPTYMARKUP
{
    NMHDR        hdr;
    uint         dwFlags;
    ushort[2084] szMarkup;
}

struct _TREEITEM
{
}

struct NMTVSTATEIMAGECHANGING
{
    NMHDR      hdr;
    _TREEITEM* hti;
    int        iOldStateImageIndex;
    int        iNewStateImageIndex;
}

struct TVITEMA
{
    uint         mask;
    _TREEITEM*   hItem;
    uint         state;
    uint         stateMask;
    const(char)* pszText;
    int          cchTextMax;
    int          iImage;
    int          iSelectedImage;
    int          cChildren;
    LPARAM       lParam;
}

struct TVITEMW
{
    uint          mask;
    _TREEITEM*    hItem;
    uint          state;
    uint          stateMask;
    const(wchar)* pszText;
    int           cchTextMax;
    int           iImage;
    int           iSelectedImage;
    int           cChildren;
    LPARAM        lParam;
}

struct TVITEMEXA
{
    uint         mask;
    _TREEITEM*   hItem;
    uint         state;
    uint         stateMask;
    const(char)* pszText;
    int          cchTextMax;
    int          iImage;
    int          iSelectedImage;
    int          cChildren;
    LPARAM       lParam;
    int          iIntegral;
    uint         uStateEx;
    HWND         hwnd;
    int          iExpandedImage;
    int          iReserved;
}

struct TVITEMEXW
{
    uint          mask;
    _TREEITEM*    hItem;
    uint          state;
    uint          stateMask;
    const(wchar)* pszText;
    int           cchTextMax;
    int           iImage;
    int           iSelectedImage;
    int           cChildren;
    LPARAM        lParam;
    int           iIntegral;
    uint          uStateEx;
    HWND          hwnd;
    int           iExpandedImage;
    int           iReserved;
}

struct TVINSERTSTRUCTA
{
    _TREEITEM* hParent;
    _TREEITEM* hInsertAfter;
    union
    {
        TVITEMEXA itemex;
        TVITEMA   item;
    }
}

struct TVINSERTSTRUCTW
{
    _TREEITEM* hParent;
    _TREEITEM* hInsertAfter;
    union
    {
        TVITEMEXW itemex;
        TVITEMW   item;
    }
}

struct TVHITTESTINFO
{
    POINT      pt;
    uint       flags;
    _TREEITEM* hItem;
}

struct TVGETITEMPARTRECTINFO
{
    _TREEITEM* hti;
    RECT*      prc;
    TVITEMPART partID;
}

struct TVSORTCB
{
    _TREEITEM*   hParent;
    PFNTVCOMPARE lpfnCompare;
    LPARAM       lParam;
}

struct NMTREEVIEWA
{
    NMHDR   hdr;
    uint    action;
    TVITEMA itemOld;
    TVITEMA itemNew;
    POINT   ptDrag;
}

struct NMTREEVIEWW
{
    NMHDR   hdr;
    uint    action;
    TVITEMW itemOld;
    TVITEMW itemNew;
    POINT   ptDrag;
}

struct NMTVDISPINFOA
{
    NMHDR   hdr;
    TVITEMA item;
}

struct NMTVDISPINFOW
{
    NMHDR   hdr;
    TVITEMW item;
}

struct NMTVDISPINFOEXA
{
    NMHDR     hdr;
    TVITEMEXA item;
}

struct NMTVDISPINFOEXW
{
    NMHDR     hdr;
    TVITEMEXW item;
}

struct NMTVKEYDOWN
{
align (1):
    NMHDR  hdr;
    ushort wVKey;
    uint   flags;
}

struct NMTVCUSTOMDRAW
{
    NMCUSTOMDRAW nmcd;
    uint         clrText;
    uint         clrTextBk;
    int          iLevel;
}

struct NMTVGETINFOTIPA
{
    NMHDR        hdr;
    const(char)* pszText;
    int          cchTextMax;
    _TREEITEM*   hItem;
    LPARAM       lParam;
}

struct NMTVGETINFOTIPW
{
    NMHDR         hdr;
    const(wchar)* pszText;
    int           cchTextMax;
    _TREEITEM*    hItem;
    LPARAM        lParam;
}

struct NMTVITEMCHANGE
{
    NMHDR      hdr;
    uint       uChanged;
    _TREEITEM* hItem;
    uint       uStateNew;
    uint       uStateOld;
    LPARAM     lParam;
}

struct NMTVASYNCDRAW
{
    NMHDR                hdr;
    IMAGELISTDRAWPARAMS* pimldp;
    HRESULT              hr;
    _TREEITEM*           hItem;
    LPARAM               lParam;
    uint                 dwRetFlags;
    int                  iRetImageIndex;
}

struct COMBOBOXEXITEMA
{
    uint         mask;
    ptrdiff_t    iItem;
    const(char)* pszText;
    int          cchTextMax;
    int          iImage;
    int          iSelectedImage;
    int          iOverlay;
    int          iIndent;
    LPARAM       lParam;
}

struct COMBOBOXEXITEMW
{
    uint          mask;
    ptrdiff_t     iItem;
    const(wchar)* pszText;
    int           cchTextMax;
    int           iImage;
    int           iSelectedImage;
    int           iOverlay;
    int           iIndent;
    LPARAM        lParam;
}

struct NMCOMBOBOXEXA
{
    NMHDR           hdr;
    COMBOBOXEXITEMA ceItem;
}

struct NMCOMBOBOXEXW
{
    NMHDR           hdr;
    COMBOBOXEXITEMW ceItem;
}

struct NMCBEDRAGBEGINW
{
    NMHDR       hdr;
    int         iItemid;
    ushort[260] szText;
}

struct NMCBEDRAGBEGINA
{
    NMHDR     hdr;
    int       iItemid;
    byte[260] szText;
}

struct NMCBEENDEDITW
{
    NMHDR       hdr;
    BOOL        fChanged;
    int         iNewSelection;
    ushort[260] szText;
    int         iWhy;
}

struct NMCBEENDEDITA
{
    NMHDR     hdr;
    BOOL      fChanged;
    int       iNewSelection;
    byte[260] szText;
    int       iWhy;
}

struct TCITEMHEADERA
{
    uint         mask;
    uint         lpReserved1;
    uint         lpReserved2;
    const(char)* pszText;
    int          cchTextMax;
    int          iImage;
}

struct TCITEMHEADERW
{
    uint          mask;
    uint          lpReserved1;
    uint          lpReserved2;
    const(wchar)* pszText;
    int           cchTextMax;
    int           iImage;
}

struct TCITEMA
{
    uint         mask;
    uint         dwState;
    uint         dwStateMask;
    const(char)* pszText;
    int          cchTextMax;
    int          iImage;
    LPARAM       lParam;
}

struct TCITEMW
{
    uint          mask;
    uint          dwState;
    uint          dwStateMask;
    const(wchar)* pszText;
    int           cchTextMax;
    int           iImage;
    LPARAM        lParam;
}

struct TCHITTESTINFO
{
    POINT pt;
    uint  flags;
}

struct NMTCKEYDOWN
{
align (1):
    NMHDR  hdr;
    ushort wVKey;
    uint   flags;
}

struct MCHITTESTINFO
{
    uint       cbSize;
    POINT      pt;
    uint       uHit;
    SYSTEMTIME st;
    RECT       rc;
    int        iOffset;
    int        iRow;
    int        iCol;
}

struct MCGRIDINFO
{
    uint          cbSize;
    uint          dwPart;
    uint          dwFlags;
    int           iCalendar;
    int           iRow;
    int           iCol;
    BOOL          bSelected;
    SYSTEMTIME    stStart;
    SYSTEMTIME    stEnd;
    RECT          rc;
    const(wchar)* pszName;
    size_t        cchName;
}

struct NMSELCHANGE
{
    NMHDR      nmhdr;
    SYSTEMTIME stSelStart;
    SYSTEMTIME stSelEnd;
}

struct NMDAYSTATE
{
    NMHDR      nmhdr;
    SYSTEMTIME stStart;
    int        cDayState;
    uint*      prgDayState;
}

struct NMVIEWCHANGE
{
    NMHDR nmhdr;
    uint  dwOldView;
    uint  dwNewView;
}

struct DATETIMEPICKERINFO
{
    uint cbSize;
    RECT rcCheck;
    uint stateCheck;
    RECT rcButton;
    uint stateButton;
    HWND hwndEdit;
    HWND hwndUD;
    HWND hwndDropDown;
}

struct NMDATETIMECHANGE
{
    NMHDR      nmhdr;
    uint       dwFlags;
    SYSTEMTIME st;
}

struct NMDATETIMESTRINGA
{
    NMHDR        nmhdr;
    const(char)* pszUserString;
    SYSTEMTIME   st;
    uint         dwFlags;
}

struct NMDATETIMESTRINGW
{
    NMHDR         nmhdr;
    const(wchar)* pszUserString;
    SYSTEMTIME    st;
    uint          dwFlags;
}

struct NMDATETIMEWMKEYDOWNA
{
    NMHDR        nmhdr;
    int          nVirtKey;
    const(char)* pszFormat;
    SYSTEMTIME   st;
}

struct NMDATETIMEWMKEYDOWNW
{
    NMHDR         nmhdr;
    int           nVirtKey;
    const(wchar)* pszFormat;
    SYSTEMTIME    st;
}

struct NMDATETIMEFORMATA
{
    NMHDR        nmhdr;
    const(char)* pszFormat;
    SYSTEMTIME   st;
    const(char)* pszDisplay;
    byte[64]     szDisplay;
}

struct NMDATETIMEFORMATW
{
    NMHDR         nmhdr;
    const(wchar)* pszFormat;
    SYSTEMTIME    st;
    const(wchar)* pszDisplay;
    ushort[64]    szDisplay;
}

struct NMDATETIMEFORMATQUERYA
{
    NMHDR        nmhdr;
    const(char)* pszFormat;
    SIZE         szMax;
}

struct NMDATETIMEFORMATQUERYW
{
    NMHDR         nmhdr;
    const(wchar)* pszFormat;
    SIZE          szMax;
}

struct NMIPADDRESS
{
    NMHDR hdr;
    int   iField;
    int   iValue;
}

struct NMPGSCROLL
{
align (1):
    NMHDR  hdr;
    ushort fwKeys;
    RECT   rcParent;
    int    iDir;
    int    iXpos;
    int    iYpos;
    int    iScroll;
}

struct NMPGCALCSIZE
{
    NMHDR hdr;
    uint  dwFlag;
    int   iWidth;
    int   iHeight;
}

struct NMPGHOTITEM
{
    NMHDR hdr;
    int   idOld;
    int   idNew;
    uint  dwFlags;
}

struct BUTTON_IMAGELIST
{
    HIMAGELIST himl;
    RECT       margin;
    uint       uAlign;
}

struct NMBCHOTITEM
{
    NMHDR hdr;
    uint  dwFlags;
}

struct BUTTON_SPLITINFO
{
    uint       mask;
    HIMAGELIST himlGlyph;
    uint       uSplitStyle;
    SIZE       size;
}

struct NMBCDROPDOWN
{
    NMHDR hdr;
    RECT  rcButton;
}

struct EDITBALLOONTIP
{
    uint          cbStruct;
    const(wchar)* pszTitle;
    const(wchar)* pszText;
    int           ttiIcon;
}

struct NMSEARCHWEB
{
    NMHDR hdr;
    EC_SEARCHWEB_ENTRYPOINT entrypoint;
    BOOL  hasQueryText;
    BOOL  invokeSucceeded;
}

struct TASKDIALOG_BUTTON
{
align (1):
    int           nButtonID;
    const(wchar)* pszButtonText;
}

struct TASKDIALOGCONFIG
{
align (1):
    uint                 cbSize;
    HWND                 hwndParent;
    HINSTANCE            hInstance;
    int                  dwFlags;
    int                  dwCommonButtons;
    const(wchar)*        pszWindowTitle;
    union
    {
    align (1):
        HICON         hMainIcon;
        const(wchar)* pszMainIcon;
    }
    const(wchar)*        pszMainInstruction;
    const(wchar)*        pszContent;
    uint                 cButtons;
    const(TASKDIALOG_BUTTON)* pButtons;
    int                  nDefaultButton;
    uint                 cRadioButtons;
    const(TASKDIALOG_BUTTON)* pRadioButtons;
    int                  nDefaultRadioButton;
    const(wchar)*        pszVerificationText;
    const(wchar)*        pszExpandedInformation;
    const(wchar)*        pszExpandedControlText;
    const(wchar)*        pszCollapsedControlText;
    union
    {
    align (1):
        HICON         hFooterIcon;
        const(wchar)* pszFooterIcon;
    }
    const(wchar)*        pszFooter;
    PFTASKDIALOGCALLBACK pfCallback;
    ptrdiff_t            lpCallbackData;
    uint                 cxWidth;
}

struct _DSA
{
}

struct _DPA
{
}

struct DPASTREAMINFO
{
    int   iPos;
    void* pvItem;
}

struct IMAGELISTSTATS
{
    uint cbSize;
    int  cAlloc;
    int  cUsed;
    int  cStandby;
}

struct IMECOMPTEXT
{
    int  cb;
    uint flags;
}

struct TABLEROWPARMS
{
    ubyte cbRow;
    ubyte cbCell;
    ubyte cCell;
    ubyte cRow;
    int   dxCellMargin;
    int   dxIndent;
    int   dyHeight;
    uint  _bitfield0;
    int   cpStartRow;
    ubyte bTableLevel;
    ubyte iCell;
}

struct TABLECELLPARMS
{
    int    dxWidth;
    ushort _bitfield1;
    ushort wShading;
    short  dxBrdrLeft;
    short  dyBrdrTop;
    short  dxBrdrRight;
    short  dyBrdrBottom;
    uint   crBrdrLeft;
    uint   crBrdrTop;
    uint   crBrdrRight;
    uint   crBrdrBottom;
    uint   crBackPat;
    uint   crForePat;
}

struct RICHEDIT_IMAGE_PARAMETERS
{
    int           xWidth;
    int           yHeight;
    int           Ascent;
    int           Type;
    const(wchar)* pwszAlternateText;
    IStream       pIStream;
}

struct ENDCOMPOSITIONNOTIFY
{
    NMHDR nmhdr;
    uint  dwCode;
}

struct CHARFORMATA
{
    uint     cbSize;
    uint     dwMask;
    uint     dwEffects;
    int      yHeight;
    int      yOffset;
    uint     crTextColor;
    ubyte    bCharSet;
    ubyte    bPitchAndFamily;
    byte[32] szFaceName;
}

struct CHARFORMATW
{
    uint       cbSize;
    uint       dwMask;
    uint       dwEffects;
    int        yHeight;
    int        yOffset;
    uint       crTextColor;
    ubyte      bCharSet;
    ubyte      bPitchAndFamily;
    ushort[32] szFaceName;
}

struct CHARFORMAT2W
{
    CHARFORMATW __AnonymousBase_richedit_L711_C23;
    ushort      wWeight;
    short       sSpacing;
    uint        crBackColor;
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

struct CHARFORMAT2A
{
    CHARFORMATA __AnonymousBase_richedit_L736_C23;
    ushort      wWeight;
    short       sSpacing;
    uint        crBackColor;
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

struct CHARRANGE
{
    int cpMin;
    int cpMax;
}

struct TEXTRANGEA
{
    CHARRANGE    chrg;
    const(char)* lpstrText;
}

struct TEXTRANGEW
{
    CHARRANGE     chrg;
    const(wchar)* lpstrText;
}

struct EDITSTREAM
{
    size_t             dwCookie;
    uint               dwError;
    EDITSTREAMCALLBACK pfnCallback;
}

struct FINDTEXTA
{
    CHARRANGE    chrg;
    const(char)* lpstrText;
}

struct FINDTEXTW
{
    CHARRANGE     chrg;
    const(wchar)* lpstrText;
}

struct FINDTEXTEXA
{
    CHARRANGE    chrg;
    const(char)* lpstrText;
    CHARRANGE    chrgText;
}

struct FINDTEXTEXW
{
    CHARRANGE     chrg;
    const(wchar)* lpstrText;
    CHARRANGE     chrgText;
}

struct FORMATRANGE
{
    HDC       hdc;
    HDC       hdcTarget;
    RECT      rc;
    RECT      rcPage;
    CHARRANGE chrg;
}

struct PARAFORMAT
{
    uint    cbSize;
    uint    dwMask;
    ushort  wNumbering;
    union
    {
        ushort wReserved;
        ushort wEffects;
    }
    int     dxStartIndent;
    int     dxRightIndent;
    int     dxOffset;
    ushort  wAlignment;
    short   cTabCount;
    int[32] rgxTabs;
}

struct PARAFORMAT2
{
    PARAFORMAT __AnonymousBase_richedit_L1149_C22;
    int        dySpaceBefore;
    int        dySpaceAfter;
    int        dyLineSpacing;
    short      sStyle;
    ubyte      bLineSpacingRule;
    ubyte      bOutlineLevel;
    ushort     wShadingWeight;
    ushort     wShadingStyle;
    ushort     wNumberingStart;
    ushort     wNumberingStyle;
    ushort     wNumberingTab;
    ushort     wBorderSpace;
    ushort     wBorderWidth;
    ushort     wBorders;
}

struct MSGFILTER
{
    NMHDR  nmhdr;
    uint   msg;
    WPARAM wParam;
    LPARAM lParam;
}

struct REQRESIZE
{
    NMHDR nmhdr;
    RECT  rc;
}

struct SELCHANGE
{
    NMHDR     nmhdr;
    CHARRANGE chrg;
    ushort    seltyp;
}

struct _grouptypingchange
{
    NMHDR nmhdr;
    BOOL  fGroupTyping;
}

struct CLIPBOARDFORMAT
{
    NMHDR  nmhdr;
    ushort cf;
}

struct GETCONTEXTMENUEX
{
    CHARRANGE chrg;
    uint      dwFlags;
    POINT     pt;
    void*     pvReserved;
}

struct ENDROPFILES
{
    NMHDR  nmhdr;
    HANDLE hDrop;
    int    cp;
    BOOL   fProtected;
}

struct ENPROTECTED
{
    NMHDR     nmhdr;
    uint      msg;
    WPARAM    wParam;
    LPARAM    lParam;
    CHARRANGE chrg;
}

struct ENSAVECLIPBOARD
{
    NMHDR nmhdr;
    int   cObjectCount;
    int   cch;
}

struct ENOLEOPFAILED
{
    NMHDR   nmhdr;
    int     iob;
    int     lOper;
    HRESULT hr;
}

struct OBJECTPOSITIONS
{
    NMHDR nmhdr;
    int   cObjectCount;
    int*  pcpPositions;
}

struct ENLINK
{
    NMHDR     nmhdr;
    uint      msg;
    WPARAM    wParam;
    LPARAM    lParam;
    CHARRANGE chrg;
}

struct ENLOWFIRTF
{
    NMHDR nmhdr;
    byte* szControl;
}

struct ENCORRECTTEXT
{
    NMHDR     nmhdr;
    CHARRANGE chrg;
    ushort    seltyp;
}

struct PUNCTUATION
{
    uint         iSize;
    const(char)* szPunctuation;
}

struct COMPCOLOR
{
    uint crText;
    uint crBackground;
    uint dwEffects;
}

struct REPASTESPECIAL
{
    uint   dwAspect;
    size_t dwParam;
}

struct SETTEXTEX
{
    uint flags;
    uint codepage;
}

struct GETTEXTEX
{
    uint         cb;
    uint         flags;
    uint         codepage;
    const(char)* lpDefaultChar;
    int*         lpUsedDefChar;
}

struct GETTEXTLENGTHEX
{
    uint flags;
    uint codepage;
}

struct BIDIOPTIONS
{
    uint   cbSize;
    ushort wMask;
    ushort wEffects;
}

struct hyphresult
{
    KHYPH  khyph;
    int    ichHyph;
    ushort chHyph;
}

struct HYPHENATEINFO
{
    short     cbSize;
    short     dxHyphenateZone;
    ptrdiff_t pfnHyphenate;
}

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
    uint           dwFlags;
    uint           dwUser;
}

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

struct TA_TRANSFORM
{
    TA_TRANSFORM_TYPE eTransformType;
    uint              dwTimingFunctionId;
    uint              dwStartTime;
    uint              dwDurationTime;
    TA_TRANSFORM_FLAG eFlags;
}

struct TA_TRANSFORM_2D
{
    TA_TRANSFORM header;
    float        rX;
    float        rY;
    float        rInitialX;
    float        rInitialY;
    float        rOriginX;
    float        rOriginY;
}

struct TA_TRANSFORM_OPACITY
{
    TA_TRANSFORM header;
    float        rOpacity;
    float        rInitialOpacity;
}

struct TA_TRANSFORM_CLIP
{
    TA_TRANSFORM header;
    float        rLeft;
    float        rTop;
    float        rRight;
    float        rBottom;
    float        rInitialLeft;
    float        rInitialTop;
    float        rInitialRight;
    float        rInitialBottom;
}

struct TA_TIMINGFUNCTION
{
    TA_TIMINGFUNCTION_TYPE eTimingFunctionType;
}

struct TA_CUBIC_BEZIER
{
    TA_TIMINGFUNCTION header;
    float             rX0;
    float             rY0;
    float             rX1;
    float             rY1;
}

struct DTBGOPTS
{
    uint dwSize;
    uint dwFlags;
    RECT rcClip;
}

struct MARGINS
{
    int cxLeftWidth;
    int cxRightWidth;
    int cyTopHeight;
    int cyBottomHeight;
}

struct INTLIST
{
    int      iValueCount;
    int[402] iValues;
}

struct WTA_OPTIONS
{
    uint dwFlags;
    uint dwMask;
}

struct DTTOPTS
{
    uint              dwSize;
    uint              dwFlags;
    uint              crText;
    uint              crBorder;
    uint              crShadow;
    int               iTextShadowType;
    POINT             ptShadowOffset;
    int               iBorderSize;
    int               iFontPropId;
    int               iColorPropId;
    int               iStateId;
    BOOL              fApplyOverlay;
    int               iGlowSize;
    DTT_CALLBACK_PROC pfnDrawTextCallback;
    LPARAM            lParam;
}

struct BP_ANIMATIONPARAMS
{
    uint              cbSize;
    uint              dwFlags;
    BP_ANIMATIONSTYLE style;
    uint              dwDuration;
}

struct BP_PAINTPARAMS
{
    uint         cbSize;
    uint         dwFlags;
    const(RECT)* prcExclude;
    const(BLENDFUNCTION)* pBlendFunction;
}

struct NMHDR
{
    HWND   hwndFrom;
    size_t idFrom;
    uint   code;
}

struct MEASUREITEMSTRUCT
{
    uint   CtlType;
    uint   CtlID;
    uint   itemID;
    uint   itemWidth;
    uint   itemHeight;
    size_t itemData;
}

struct DRAWITEMSTRUCT
{
    uint   CtlType;
    uint   CtlID;
    uint   itemID;
    uint   itemAction;
    uint   itemState;
    HWND   hwndItem;
    HDC    hDC;
    RECT   rcItem;
    size_t itemData;
}

struct DELETEITEMSTRUCT
{
    uint   CtlType;
    uint   CtlID;
    uint   itemID;
    HWND   hwndItem;
    size_t itemData;
}

struct COMPAREITEMSTRUCT
{
    uint   CtlType;
    uint   CtlID;
    HWND   hwndItem;
    uint   itemID1;
    size_t itemData1;
    uint   itemID2;
    size_t itemData2;
    uint   dwLocaleId;
}

struct USAGE_PROPERTIES
{
    ushort level;
    ushort page;
    ushort usage;
    int    logicalMinimum;
    int    logicalMaximum;
    ushort unit;
    ushort exponent;
    ubyte  count;
    int    physicalMinimum;
    int    physicalMaximum;
}

struct POINTER_TYPE_INFO
{
    uint type;
    union
    {
        POINTER_TOUCH_INFO touchInfo;
        POINTER_PEN_INFO   penInfo;
    }
}

struct INPUT_INJECTION_VALUE
{
    ushort page;
    ushort usage;
    int    value;
    ushort index;
}

struct TOUCH_HIT_TESTING_PROXIMITY_EVALUATION
{
    ushort score;
    POINT  adjustedPoint;
}

struct TOUCH_HIT_TESTING_INPUT
{
    uint  pointerId;
    POINT point;
    RECT  boundingBox;
    RECT  nonOccludedBoundingBox;
    uint  orientation;
}

struct SCROLLINFO
{
    uint cbSize;
    uint fMask;
    int  nMin;
    int  nMax;
    uint nPage;
    int  nPos;
    int  nTrackPos;
}

struct SCROLLBARINFO
{
    uint    cbSize;
    RECT    rcScrollBar;
    int     dxyLineButton;
    int     xyThumbTop;
    int     xyThumbBottom;
    int     reserved;
    uint[6] rgstate;
}

struct COMBOBOXINFO
{
    uint cbSize;
    RECT rcItem;
    RECT rcButton;
    uint stateButton;
    HWND hwndCombo;
    HWND hwndItem;
    HWND hwndList;
}

struct POINTER_DEVICE_INFO
{
    uint                displayOrientation;
    HANDLE              device;
    POINTER_DEVICE_TYPE pointerDeviceType;
    ptrdiff_t           monitor;
    uint                startingCursorId;
    ushort              maxActiveContacts;
    ushort[520]         productString;
}

struct POINTER_DEVICE_PROPERTY
{
    int    logicalMin;
    int    logicalMax;
    int    physicalMin;
    int    physicalMax;
    uint   unit;
    uint   unitExponent;
    ushort usagePageId;
    ushort usageId;
}

struct POINTER_DEVICE_CURSOR_INFO
{
    uint cursorId;
    POINTER_DEVICE_CURSOR_TYPE cursor;
}

struct INPUT_MESSAGE_SOURCE
{
    INPUT_MESSAGE_DEVICE_TYPE deviceType;
    INPUT_MESSAGE_ORIGIN_ID originId;
}

// Functions

@DllImport("COMCTL32")
HPROPSHEETPAGE CreatePropertySheetPageA(PROPSHEETPAGEA* constPropSheetPagePointer);

@DllImport("COMCTL32")
HPROPSHEETPAGE CreatePropertySheetPageW(PROPSHEETPAGEW* constPropSheetPagePointer);

@DllImport("COMCTL32")
BOOL DestroyPropertySheetPage(HPROPSHEETPAGE param0);

@DllImport("COMCTL32")
ptrdiff_t PropertySheetA(PROPSHEETHEADERA_V2* param0);

@DllImport("COMCTL32")
ptrdiff_t PropertySheetW(PROPSHEETHEADERW_V2* param0);

@DllImport("COMCTL32")
void InitCommonControls();

@DllImport("COMCTL32")
BOOL InitCommonControlsEx(const(INITCOMMONCONTROLSEX)* picce);

@DllImport("COMCTL32")
HIMAGELIST ImageList_Create(int cx, int cy, uint flags, int cInitial, int cGrow);

@DllImport("COMCTL32")
BOOL ImageList_Destroy(HIMAGELIST himl);

@DllImport("COMCTL32")
int ImageList_GetImageCount(HIMAGELIST himl);

@DllImport("COMCTL32")
BOOL ImageList_SetImageCount(HIMAGELIST himl, uint uNewCount);

@DllImport("COMCTL32")
int ImageList_Add(HIMAGELIST himl, HBITMAP hbmImage, HBITMAP hbmMask);

@DllImport("COMCTL32")
int ImageList_ReplaceIcon(HIMAGELIST himl, int i, HICON hicon);

@DllImport("COMCTL32")
uint ImageList_SetBkColor(HIMAGELIST himl, uint clrBk);

@DllImport("COMCTL32")
uint ImageList_GetBkColor(HIMAGELIST himl);

@DllImport("COMCTL32")
BOOL ImageList_SetOverlayImage(HIMAGELIST himl, int iImage, int iOverlay);

@DllImport("COMCTL32")
BOOL ImageList_Draw(HIMAGELIST himl, int i, HDC hdcDst, int x, int y, uint fStyle);

@DllImport("COMCTL32")
BOOL ImageList_Replace(HIMAGELIST himl, int i, HBITMAP hbmImage, HBITMAP hbmMask);

@DllImport("COMCTL32")
int ImageList_AddMasked(HIMAGELIST himl, HBITMAP hbmImage, uint crMask);

@DllImport("COMCTL32")
BOOL ImageList_DrawEx(HIMAGELIST himl, int i, HDC hdcDst, int x, int y, int dx, int dy, uint rgbBk, uint rgbFg, 
                      uint fStyle);

@DllImport("COMCTL32")
BOOL ImageList_DrawIndirect(IMAGELISTDRAWPARAMS* pimldp);

@DllImport("COMCTL32")
BOOL ImageList_Remove(HIMAGELIST himl, int i);

@DllImport("COMCTL32")
HICON ImageList_GetIcon(HIMAGELIST himl, int i, uint flags);

@DllImport("COMCTL32")
HIMAGELIST ImageList_LoadImageA(HINSTANCE hi, const(char)* lpbmp, int cx, int cGrow, uint crMask, uint uType, 
                                uint uFlags);

@DllImport("COMCTL32")
HIMAGELIST ImageList_LoadImageW(HINSTANCE hi, const(wchar)* lpbmp, int cx, int cGrow, uint crMask, uint uType, 
                                uint uFlags);

@DllImport("COMCTL32")
BOOL ImageList_Copy(HIMAGELIST himlDst, int iDst, HIMAGELIST himlSrc, int iSrc, uint uFlags);

@DllImport("COMCTL32")
BOOL ImageList_BeginDrag(HIMAGELIST himlTrack, int iTrack, int dxHotspot, int dyHotspot);

@DllImport("COMCTL32")
void ImageList_EndDrag();

@DllImport("COMCTL32")
BOOL ImageList_DragEnter(HWND hwndLock, int x, int y);

@DllImport("COMCTL32")
BOOL ImageList_DragLeave(HWND hwndLock);

@DllImport("COMCTL32")
BOOL ImageList_DragMove(int x, int y);

@DllImport("COMCTL32")
BOOL ImageList_SetDragCursorImage(HIMAGELIST himlDrag, int iDrag, int dxHotspot, int dyHotspot);

@DllImport("COMCTL32")
BOOL ImageList_DragShowNolock(BOOL fShow);

@DllImport("COMCTL32")
HIMAGELIST ImageList_GetDragImage(POINT* ppt, POINT* pptHotspot);

@DllImport("COMCTL32")
HIMAGELIST ImageList_Read(IStream pstm);

@DllImport("COMCTL32")
BOOL ImageList_Write(HIMAGELIST himl, IStream pstm);

@DllImport("COMCTL32")
HRESULT ImageList_ReadEx(uint dwFlags, IStream pstm, const(GUID)* riid, void** ppv);

@DllImport("COMCTL32")
HRESULT ImageList_WriteEx(HIMAGELIST himl, uint dwFlags, IStream pstm);

@DllImport("COMCTL32")
BOOL ImageList_GetIconSize(HIMAGELIST himl, int* cx, int* cy);

@DllImport("COMCTL32")
BOOL ImageList_SetIconSize(HIMAGELIST himl, int cx, int cy);

@DllImport("COMCTL32")
BOOL ImageList_GetImageInfo(HIMAGELIST himl, int i, IMAGEINFO* pImageInfo);

@DllImport("COMCTL32")
HIMAGELIST ImageList_Merge(HIMAGELIST himl1, int i1, HIMAGELIST himl2, int i2, int dx, int dy);

@DllImport("COMCTL32")
HIMAGELIST ImageList_Duplicate(HIMAGELIST himl);

@DllImport("COMCTL32")
HRESULT HIMAGELIST_QueryInterface(HIMAGELIST himl, const(GUID)* riid, void** ppv);

@DllImport("COMCTL32")
HWND CreateToolbarEx(HWND hwnd, uint ws, uint wID, int nBitmaps, HINSTANCE hBMInst, size_t wBMID, 
                     TBBUTTON* lpButtons, int iNumButtons, int dxButton, int dyButton, int dxBitmap, int dyBitmap, 
                     uint uStructSize);

@DllImport("COMCTL32")
HBITMAP CreateMappedBitmap(HINSTANCE hInstance, ptrdiff_t idBitmap, uint wFlags, COLORMAP* lpColorMap, 
                           int iNumMaps);

@DllImport("COMCTL32")
void DrawStatusTextA(HDC hDC, RECT* lprc, const(char)* pszText, uint uFlags);

@DllImport("COMCTL32")
void DrawStatusTextW(HDC hDC, RECT* lprc, const(wchar)* pszText, uint uFlags);

@DllImport("COMCTL32")
HWND CreateStatusWindowA(int style, const(char)* lpszText, HWND hwndParent, uint wID);

@DllImport("COMCTL32")
HWND CreateStatusWindowW(int style, const(wchar)* lpszText, HWND hwndParent, uint wID);

@DllImport("COMCTL32")
void MenuHelp(uint uMsg, WPARAM wParam, LPARAM lParam, HMENU hMainMenu, HINSTANCE hInst, HWND hwndStatus, 
              uint* lpwIDs);

@DllImport("COMCTL32")
BOOL ShowHideMenuCtl(HWND hWnd, size_t uFlags, int* lpInfo);

@DllImport("COMCTL32")
void GetEffectiveClientRect(HWND hWnd, RECT* lprc, const(int)* lpInfo);

@DllImport("COMCTL32")
BOOL MakeDragList(HWND hLB);

@DllImport("COMCTL32")
void DrawInsert(HWND handParent, HWND hLB, int nItem);

@DllImport("COMCTL32")
int LBItemFromPt(HWND hLB, POINT pt, BOOL bAutoScroll);

@DllImport("COMCTL32")
HWND CreateUpDownControl(uint dwStyle, int x, int y, int cx, int cy, HWND hParent, int nID, HINSTANCE hInst, 
                         HWND hBuddy, int nUpper, int nLower, int nPos);

@DllImport("COMCTL32")
HRESULT TaskDialogIndirect(const(TASKDIALOGCONFIG)* pTaskConfig, int* pnButton, int* pnRadioButton, 
                           int* pfVerificationFlagChecked);

@DllImport("COMCTL32")
HRESULT TaskDialog(HWND hwndOwner, HINSTANCE hInstance, const(wchar)* pszWindowTitle, 
                   const(wchar)* pszMainInstruction, const(wchar)* pszContent, int dwCommonButtons, 
                   const(wchar)* pszIcon, int* pnButton);

@DllImport("COMCTL32")
void InitMUILanguage(ushort uiLang);

@DllImport("COMCTL32")
ushort GetMUILanguage();

@DllImport("COMCTL32")
_DSA* DSA_Create(int cbItem, int cItemGrow);

@DllImport("COMCTL32")
BOOL DSA_Destroy(_DSA* hdsa);

@DllImport("COMCTL32")
void DSA_DestroyCallback(_DSA* hdsa, PFNDAENUMCALLBACK pfnCB, void* pData);

@DllImport("COMCTL32")
BOOL DSA_DeleteItem(_DSA* hdsa, int i);

@DllImport("COMCTL32")
BOOL DSA_DeleteAllItems(_DSA* hdsa);

@DllImport("COMCTL32")
void DSA_EnumCallback(_DSA* hdsa, PFNDAENUMCALLBACK pfnCB, void* pData);

@DllImport("COMCTL32")
int DSA_InsertItem(_DSA* hdsa, int i, const(void)* pitem);

@DllImport("COMCTL32")
void* DSA_GetItemPtr(_DSA* hdsa, int i);

@DllImport("COMCTL32")
BOOL DSA_GetItem(_DSA* hdsa, int i, char* pitem);

@DllImport("COMCTL32")
BOOL DSA_SetItem(_DSA* hdsa, int i, const(void)* pitem);

@DllImport("COMCTL32")
_DSA* DSA_Clone(_DSA* hdsa);

@DllImport("COMCTL32")
ulong DSA_GetSize(_DSA* hdsa);

@DllImport("COMCTL32")
BOOL DSA_Sort(_DSA* pdsa, PFNDACOMPARE pfnCompare, LPARAM lParam);

@DllImport("COMCTL32")
_DPA* DPA_Create(int cItemGrow);

@DllImport("COMCTL32")
_DPA* DPA_CreateEx(int cpGrow, HANDLE hheap);

@DllImport("COMCTL32")
_DPA* DPA_Clone(const(_DPA)* hdpa, _DPA* hdpaNew);

@DllImport("COMCTL32")
BOOL DPA_Destroy(_DPA* hdpa);

@DllImport("COMCTL32")
void DPA_DestroyCallback(_DPA* hdpa, PFNDAENUMCALLBACK pfnCB, void* pData);

@DllImport("COMCTL32")
void* DPA_DeletePtr(_DPA* hdpa, int i);

@DllImport("COMCTL32")
BOOL DPA_DeleteAllPtrs(_DPA* hdpa);

@DllImport("COMCTL32")
void DPA_EnumCallback(_DPA* hdpa, PFNDAENUMCALLBACK pfnCB, void* pData);

@DllImport("COMCTL32")
BOOL DPA_Grow(_DPA* pdpa, int cp);

@DllImport("COMCTL32")
int DPA_InsertPtr(_DPA* hdpa, int i, void* p);

@DllImport("COMCTL32")
BOOL DPA_SetPtr(_DPA* hdpa, int i, void* p);

@DllImport("COMCTL32")
void* DPA_GetPtr(_DPA* hdpa, ptrdiff_t i);

@DllImport("COMCTL32")
int DPA_GetPtrIndex(_DPA* hdpa, const(void)* p);

@DllImport("COMCTL32")
ulong DPA_GetSize(_DPA* hdpa);

@DllImport("COMCTL32")
BOOL DPA_Sort(_DPA* hdpa, PFNDACOMPARE pfnCompare, LPARAM lParam);

@DllImport("COMCTL32")
HRESULT DPA_LoadStream(_DPA** phdpa, PFNDPASTREAM pfn, IStream pstream, void* pvInstData);

@DllImport("COMCTL32")
HRESULT DPA_SaveStream(_DPA* hdpa, PFNDPASTREAM pfn, IStream pstream, void* pvInstData);

@DllImport("COMCTL32")
BOOL DPA_Merge(_DPA* hdpaDest, _DPA* hdpaSrc, uint dwFlags, PFNDACOMPARE pfnCompare, PFNDPAMERGE pfnMerge, 
               LPARAM lParam);

@DllImport("COMCTL32")
int DPA_Search(_DPA* hdpa, void* pFind, int iStart, PFNDACOMPARE pfnCompare, LPARAM lParam, uint options);

@DllImport("COMCTL32")
BOOL Str_SetPtrW(ushort** ppsz, const(wchar)* psz);

@DllImport("COMCTL32")
BOOL FlatSB_EnableScrollBar(HWND param0, int param1, uint param2);

@DllImport("COMCTL32")
BOOL FlatSB_ShowScrollBar(HWND param0, int code, BOOL param2);

@DllImport("COMCTL32")
BOOL FlatSB_GetScrollRange(HWND param0, int code, int* param2, int* param3);

@DllImport("COMCTL32")
BOOL FlatSB_GetScrollInfo(HWND param0, int code, SCROLLINFO* param2);

@DllImport("COMCTL32")
int FlatSB_GetScrollPos(HWND param0, int code);

@DllImport("COMCTL32")
BOOL FlatSB_GetScrollProp(HWND param0, int propIndex, int* param2);

@DllImport("COMCTL32")
int FlatSB_SetScrollPos(HWND param0, int code, int pos, BOOL fRedraw);

@DllImport("COMCTL32")
int FlatSB_SetScrollInfo(HWND param0, int code, SCROLLINFO* psi, BOOL fRedraw);

@DllImport("COMCTL32")
int FlatSB_SetScrollRange(HWND param0, int code, int min, int max, BOOL fRedraw);

@DllImport("COMCTL32")
BOOL FlatSB_SetScrollProp(HWND param0, uint index, ptrdiff_t newValue, BOOL param3);

@DllImport("COMCTL32")
BOOL InitializeFlatSB(HWND param0);

@DllImport("COMCTL32")
HRESULT UninitializeFlatSB(HWND param0);

@DllImport("COMCTL32")
HRESULT LoadIconMetric(HINSTANCE hinst, const(wchar)* pszName, int lims, HICON* phico);

@DllImport("COMCTL32")
HRESULT LoadIconWithScaleDown(HINSTANCE hinst, const(wchar)* pszName, int cx, int cy, HICON* phico);

@DllImport("COMCTL32")
int DrawShadowText(HDC hdc, const(wchar)* pszText, uint cch, RECT* prc, uint dwFlags, uint crText, uint crShadow, 
                   int ixOffset, int iyOffset);

@DllImport("COMCTL32")
HRESULT ImageList_CoCreateInstance(const(GUID)* rclsid, const(IUnknown) punkOuter, const(GUID)* riid, void** ppv);

@DllImport("UXTHEME")
HRESULT GetThemeAnimationProperty(ptrdiff_t hTheme, int iStoryboardId, int iTargetId, TA_PROPERTY eProperty, 
                                  char* pvProperty, uint cbSize, uint* pcbSizeOut);

@DllImport("UXTHEME")
HRESULT GetThemeAnimationTransform(ptrdiff_t hTheme, int iStoryboardId, int iTargetId, uint dwTransformIndex, 
                                   char* pTransform, uint cbSize, uint* pcbSizeOut);

@DllImport("UXTHEME")
HRESULT GetThemeTimingFunction(ptrdiff_t hTheme, int iTimingFunctionId, char* pTimingFunction, uint cbSize, 
                               uint* pcbSizeOut);

@DllImport("UXTHEME")
ptrdiff_t OpenThemeData(HWND hwnd, const(wchar)* pszClassList);

@DllImport("UXTHEME")
ptrdiff_t OpenThemeDataEx(HWND hwnd, const(wchar)* pszClassList, uint dwFlags);

@DllImport("UXTHEME")
HRESULT CloseThemeData(ptrdiff_t hTheme);

@DllImport("UXTHEME")
HRESULT DrawThemeBackground(ptrdiff_t hTheme, HDC hdc, int iPartId, int iStateId, RECT* pRect, RECT* pClipRect);

@DllImport("UXTHEME")
HRESULT DrawThemeBackgroundEx(ptrdiff_t hTheme, HDC hdc, int iPartId, int iStateId, RECT* pRect, 
                              const(DTBGOPTS)* pOptions);

@DllImport("UxTheme")
HRESULT DrawThemeText(ptrdiff_t hTheme, HDC hdc, int iPartId, int iStateId, const(wchar)* pszText, int cchText, 
                      uint dwTextFlags, uint dwTextFlags2, RECT* pRect);

@DllImport("UXTHEME")
HRESULT GetThemeBackgroundContentRect(ptrdiff_t hTheme, HDC hdc, int iPartId, int iStateId, RECT* pBoundingRect, 
                                      RECT* pContentRect);

@DllImport("UXTHEME")
HRESULT GetThemeBackgroundExtent(ptrdiff_t hTheme, HDC hdc, int iPartId, int iStateId, RECT* pContentRect, 
                                 RECT* pExtentRect);

@DllImport("UxTheme")
HRESULT GetThemeBackgroundRegion(ptrdiff_t hTheme, HDC hdc, int iPartId, int iStateId, RECT* pRect, HRGN* pRegion);

@DllImport("UXTHEME")
HRESULT GetThemePartSize(ptrdiff_t hTheme, HDC hdc, int iPartId, int iStateId, RECT* prc, THEMESIZE eSize, 
                         SIZE* psz);

@DllImport("UxTheme")
HRESULT GetThemeTextExtent(ptrdiff_t hTheme, HDC hdc, int iPartId, int iStateId, const(wchar)* pszText, 
                           int cchCharCount, uint dwTextFlags, RECT* pBoundingRect, RECT* pExtentRect);

@DllImport("UxTheme")
HRESULT GetThemeTextMetrics(ptrdiff_t hTheme, HDC hdc, int iPartId, int iStateId, TEXTMETRICW* ptm);

@DllImport("UxTheme")
HRESULT HitTestThemeBackground(ptrdiff_t hTheme, HDC hdc, int iPartId, int iStateId, uint dwOptions, RECT* pRect, 
                               HRGN hrgn, POINT ptTest, ushort* pwHitTestCode);

@DllImport("UxTheme")
HRESULT DrawThemeEdge(ptrdiff_t hTheme, HDC hdc, int iPartId, int iStateId, RECT* pDestRect, uint uEdge, 
                      uint uFlags, RECT* pContentRect);

@DllImport("UxTheme")
HRESULT DrawThemeIcon(ptrdiff_t hTheme, HDC hdc, int iPartId, int iStateId, RECT* pRect, HIMAGELIST himl, 
                      int iImageIndex);

@DllImport("UXTHEME")
BOOL IsThemePartDefined(ptrdiff_t hTheme, int iPartId, int iStateId);

@DllImport("UxTheme")
BOOL IsThemeBackgroundPartiallyTransparent(ptrdiff_t hTheme, int iPartId, int iStateId);

@DllImport("UXTHEME")
HRESULT GetThemeColor(ptrdiff_t hTheme, int iPartId, int iStateId, int iPropId, uint* pColor);

@DllImport("UXTHEME")
HRESULT GetThemeMetric(ptrdiff_t hTheme, HDC hdc, int iPartId, int iStateId, int iPropId, int* piVal);

@DllImport("UxTheme")
HRESULT GetThemeString(ptrdiff_t hTheme, int iPartId, int iStateId, int iPropId, const(wchar)* pszBuff, 
                       int cchMaxBuffChars);

@DllImport("UxTheme")
HRESULT GetThemeBool(ptrdiff_t hTheme, int iPartId, int iStateId, int iPropId, int* pfVal);

@DllImport("UXTHEME")
HRESULT GetThemeInt(ptrdiff_t hTheme, int iPartId, int iStateId, int iPropId, int* piVal);

@DllImport("UXTHEME")
HRESULT GetThemeEnumValue(ptrdiff_t hTheme, int iPartId, int iStateId, int iPropId, int* piVal);

@DllImport("UXTHEME")
HRESULT GetThemePosition(ptrdiff_t hTheme, int iPartId, int iStateId, int iPropId, POINT* pPoint);

@DllImport("UXTHEME")
HRESULT GetThemeFont(ptrdiff_t hTheme, HDC hdc, int iPartId, int iStateId, int iPropId, LOGFONTW* pFont);

@DllImport("UXTHEME")
HRESULT GetThemeRect(ptrdiff_t hTheme, int iPartId, int iStateId, int iPropId, RECT* pRect);

@DllImport("UXTHEME")
HRESULT GetThemeMargins(ptrdiff_t hTheme, HDC hdc, int iPartId, int iStateId, int iPropId, RECT* prc, 
                        MARGINS* pMargins);

@DllImport("UxTheme")
HRESULT GetThemeIntList(ptrdiff_t hTheme, int iPartId, int iStateId, int iPropId, INTLIST* pIntList);

@DllImport("UxTheme")
HRESULT GetThemePropertyOrigin(ptrdiff_t hTheme, int iPartId, int iStateId, int iPropId, PROPERTYORIGIN* pOrigin);

@DllImport("UXTHEME")
HRESULT SetWindowTheme(HWND hwnd, const(wchar)* pszSubAppName, const(wchar)* pszSubIdList);

@DllImport("UxTheme")
HRESULT GetThemeFilename(ptrdiff_t hTheme, int iPartId, int iStateId, int iPropId, const(wchar)* pszThemeFileName, 
                         int cchMaxBuffChars);

@DllImport("UxTheme")
uint GetThemeSysColor(ptrdiff_t hTheme, int iColorId);

@DllImport("UxTheme")
HBRUSH GetThemeSysColorBrush(ptrdiff_t hTheme, int iColorId);

@DllImport("UxTheme")
BOOL GetThemeSysBool(ptrdiff_t hTheme, int iBoolId);

@DllImport("UxTheme")
int GetThemeSysSize(ptrdiff_t hTheme, int iSizeId);

@DllImport("UxTheme")
HRESULT GetThemeSysFont(ptrdiff_t hTheme, int iFontId, LOGFONTW* plf);

@DllImport("UxTheme")
HRESULT GetThemeSysString(ptrdiff_t hTheme, int iStringId, const(wchar)* pszStringBuff, int cchMaxStringChars);

@DllImport("UxTheme")
HRESULT GetThemeSysInt(ptrdiff_t hTheme, int iIntId, int* piValue);

@DllImport("UXTHEME")
BOOL IsThemeActive();

@DllImport("UXTHEME")
BOOL IsAppThemed();

@DllImport("UXTHEME")
ptrdiff_t GetWindowTheme(HWND hwnd);

@DllImport("UxTheme")
HRESULT EnableThemeDialogTexture(HWND hwnd, uint dwFlags);

@DllImport("UxTheme")
BOOL IsThemeDialogTextureEnabled(HWND hwnd);

@DllImport("UXTHEME")
uint GetThemeAppProperties();

@DllImport("UxTheme")
void SetThemeAppProperties(uint dwFlags);

@DllImport("UXTHEME")
HRESULT GetCurrentThemeName(const(wchar)* pszThemeFileName, int cchMaxNameChars, const(wchar)* pszColorBuff, 
                            int cchMaxColorChars, const(wchar)* pszSizeBuff, int cchMaxSizeChars);

@DllImport("UxTheme")
HRESULT GetThemeDocumentationProperty(const(wchar)* pszThemeName, const(wchar)* pszPropertyName, 
                                      const(wchar)* pszValueBuff, int cchMaxValChars);

@DllImport("UXTHEME")
HRESULT DrawThemeParentBackground(HWND hwnd, HDC hdc, const(RECT)* prc);

@DllImport("UxTheme")
HRESULT EnableTheming(BOOL fEnable);

@DllImport("UxTheme")
HRESULT DrawThemeParentBackgroundEx(HWND hwnd, HDC hdc, uint dwFlags, const(RECT)* prc);

@DllImport("UXTHEME")
HRESULT SetWindowThemeAttribute(HWND hwnd, WINDOWTHEMEATTRIBUTETYPE eAttribute, char* pvAttribute, 
                                uint cbAttribute);

@DllImport("UXTHEME")
HRESULT DrawThemeTextEx(ptrdiff_t hTheme, HDC hdc, int iPartId, int iStateId, const(wchar)* pszText, int cchText, 
                        uint dwTextFlags, RECT* pRect, const(DTTOPTS)* pOptions);

@DllImport("UXTHEME")
HRESULT GetThemeBitmap(ptrdiff_t hTheme, int iPartId, int iStateId, int iPropId, uint dwFlags, HBITMAP* phBitmap);

@DllImport("UXTHEME")
HRESULT GetThemeStream(ptrdiff_t hTheme, int iPartId, int iStateId, int iPropId, void** ppvStream, uint* pcbStream, 
                       HINSTANCE hInst);

@DllImport("UXTHEME")
HRESULT BufferedPaintInit();

@DllImport("UXTHEME")
HRESULT BufferedPaintUnInit();

@DllImport("UXTHEME")
ptrdiff_t BeginBufferedPaint(HDC hdcTarget, const(RECT)* prcTarget, BP_BUFFERFORMAT dwFormat, 
                             BP_PAINTPARAMS* pPaintParams, HDC* phdc);

@DllImport("UXTHEME")
HRESULT EndBufferedPaint(ptrdiff_t hBufferedPaint, BOOL fUpdateTarget);

@DllImport("UxTheme")
HRESULT GetBufferedPaintTargetRect(ptrdiff_t hBufferedPaint, RECT* prc);

@DllImport("UxTheme")
HDC GetBufferedPaintTargetDC(ptrdiff_t hBufferedPaint);

@DllImport("UxTheme")
HDC GetBufferedPaintDC(ptrdiff_t hBufferedPaint);

@DllImport("UXTHEME")
HRESULT GetBufferedPaintBits(ptrdiff_t hBufferedPaint, RGBQUAD** ppbBuffer, int* pcxRow);

@DllImport("UXTHEME")
HRESULT BufferedPaintClear(ptrdiff_t hBufferedPaint, const(RECT)* prc);

@DllImport("UxTheme")
HRESULT BufferedPaintSetAlpha(ptrdiff_t hBufferedPaint, const(RECT)* prc, ubyte alpha);

@DllImport("UXTHEME")
HRESULT BufferedPaintStopAllAnimations(HWND hwnd);

@DllImport("UxTheme")
ptrdiff_t BeginBufferedAnimation(HWND hwnd, HDC hdcTarget, const(RECT)* prcTarget, BP_BUFFERFORMAT dwFormat, 
                                 BP_PAINTPARAMS* pPaintParams, BP_ANIMATIONPARAMS* pAnimationParams, HDC* phdcFrom, 
                                 HDC* phdcTo);

@DllImport("UxTheme")
HRESULT EndBufferedAnimation(ptrdiff_t hbpAnimation, BOOL fUpdateTarget);

@DllImport("UxTheme")
BOOL BufferedPaintRenderAnimation(HWND hwnd, HDC hdcTarget);

@DllImport("UXTHEME")
BOOL IsCompositionActive();

@DllImport("UxTheme")
HRESULT GetThemeTransitionDuration(ptrdiff_t hTheme, int iPartId, int iStateIdFrom, int iStateIdTo, int iPropId, 
                                   uint* pdwDuration);

@DllImport("USER32")
BOOL CheckDlgButton(HWND hDlg, int nIDButton, uint uCheck);

@DllImport("USER32")
BOOL CheckRadioButton(HWND hDlg, int nIDFirstButton, int nIDLastButton, int nIDCheckButton);

@DllImport("USER32")
uint IsDlgButtonChecked(HWND hDlg, int nIDButton);

@DllImport("USER32")
BOOL IsCharLowerW(ushort ch);

@DllImport("USER32")
BOOL InitializeTouchInjection(uint maxCount, uint dwMode);

@DllImport("USER32")
BOOL InjectTouchInput(uint count, char* contacts);

@DllImport("USER32")
ptrdiff_t CreateSyntheticPointerDevice(uint pointerType, uint maxCount, POINTER_FEEDBACK_MODE mode);

@DllImport("USER32")
BOOL InjectSyntheticPointerInput(ptrdiff_t device, char* pointerInfo, uint count);

@DllImport("USER32")
void DestroySyntheticPointerDevice(ptrdiff_t device);

@DllImport("USER32")
BOOL RegisterTouchHitTestingWindow(HWND hwnd, uint value);

@DllImport("USER32")
BOOL EvaluateProximityToRect(const(RECT)* controlBoundingBox, const(TOUCH_HIT_TESTING_INPUT)* pHitTestingInput, 
                             TOUCH_HIT_TESTING_PROXIMITY_EVALUATION* pProximityEval);

@DllImport("USER32")
BOOL EvaluateProximityToPolygon(uint numVertices, char* controlPolygon, 
                                const(TOUCH_HIT_TESTING_INPUT)* pHitTestingInput, 
                                TOUCH_HIT_TESTING_PROXIMITY_EVALUATION* pProximityEval);

@DllImport("USER32")
LRESULT PackTouchHitTestingProximityEvaluation(const(TOUCH_HIT_TESTING_INPUT)* pHitTestingInput, 
                                               const(TOUCH_HIT_TESTING_PROXIMITY_EVALUATION)* pProximityEval);

@DllImport("USER32")
BOOL GetWindowFeedbackSetting(HWND hwnd, FEEDBACK_TYPE feedback, uint dwFlags, uint* pSize, char* config);

@DllImport("USER32")
BOOL SetWindowFeedbackSetting(HWND hwnd, FEEDBACK_TYPE feedback, uint dwFlags, uint size, char* configuration);

@DllImport("USER32")
BOOL ScrollWindow(HWND hWnd, int XAmount, int YAmount, const(RECT)* lpRect, const(RECT)* lpClipRect);

@DllImport("USER32")
BOOL ScrollDC(HDC hDC, int dx, int dy, const(RECT)* lprcScroll, const(RECT)* lprcClip, HRGN hrgnUpdate, 
              RECT* lprcUpdate);

@DllImport("USER32")
int ScrollWindowEx(HWND hWnd, int dx, int dy, const(RECT)* prcScroll, const(RECT)* prcClip, HRGN hrgnUpdate, 
                   RECT* prcUpdate, uint flags);

@DllImport("USER32")
int SetScrollPos(HWND hWnd, int nBar, int nPos, BOOL bRedraw);

@DllImport("USER32")
int GetScrollPos(HWND hWnd, int nBar);

@DllImport("USER32")
BOOL SetScrollRange(HWND hWnd, int nBar, int nMinPos, int nMaxPos, BOOL bRedraw);

@DllImport("USER32")
BOOL GetScrollRange(HWND hWnd, int nBar, int* lpMinPos, int* lpMaxPos);

@DllImport("USER32")
BOOL ShowScrollBar(HWND hWnd, int wBar, BOOL bShow);

@DllImport("USER32")
BOOL EnableScrollBar(HWND hWnd, uint wSBflags, uint wArrows);

@DllImport("USER32")
int DlgDirListA(HWND hDlg, const(char)* lpPathSpec, int nIDListBox, int nIDStaticPath, uint uFileType);

@DllImport("USER32")
int DlgDirListW(HWND hDlg, const(wchar)* lpPathSpec, int nIDListBox, int nIDStaticPath, uint uFileType);

@DllImport("USER32")
BOOL DlgDirSelectExA(HWND hwndDlg, const(char)* lpString, int chCount, int idListBox);

@DllImport("USER32")
BOOL DlgDirSelectExW(HWND hwndDlg, const(wchar)* lpString, int chCount, int idListBox);

@DllImport("USER32")
int DlgDirListComboBoxA(HWND hDlg, const(char)* lpPathSpec, int nIDComboBox, int nIDStaticPath, uint uFiletype);

@DllImport("USER32")
int DlgDirListComboBoxW(HWND hDlg, const(wchar)* lpPathSpec, int nIDComboBox, int nIDStaticPath, uint uFiletype);

@DllImport("USER32")
BOOL DlgDirSelectComboBoxExA(HWND hwndDlg, const(char)* lpString, int cchOut, int idComboBox);

@DllImport("USER32")
BOOL DlgDirSelectComboBoxExW(HWND hwndDlg, const(wchar)* lpString, int cchOut, int idComboBox);

@DllImport("USER32")
int SetScrollInfo(HWND hwnd, int nBar, SCROLLINFO* lpsi, BOOL redraw);

@DllImport("USER32")
BOOL GetScrollInfo(HWND hwnd, int nBar, SCROLLINFO* lpsi);

@DllImport("USER32")
BOOL GetScrollBarInfo(HWND hwnd, int idObject, SCROLLBARINFO* psbi);

@DllImport("USER32")
BOOL GetComboBoxInfo(HWND hwndCombo, COMBOBOXINFO* pcbi);

@DllImport("USER32")
uint GetListBoxInfo(HWND hwnd);

@DllImport("USER32")
BOOL GetPointerDevices(uint* deviceCount, char* pointerDevices);

@DllImport("USER32")
BOOL GetPointerDevice(HANDLE device, POINTER_DEVICE_INFO* pointerDevice);

@DllImport("USER32")
BOOL GetPointerDeviceProperties(HANDLE device, uint* propertyCount, char* pointerProperties);

@DllImport("USER32")
BOOL RegisterPointerDeviceNotifications(HWND window, BOOL notifyRange);

@DllImport("USER32")
BOOL GetPointerDeviceRects(HANDLE device, RECT* pointerDeviceRect, RECT* displayRect);

@DllImport("USER32")
BOOL GetPointerDeviceCursors(HANDLE device, uint* cursorCount, char* deviceCursors);

@DllImport("USER32")
BOOL GetRawPointerDeviceData(uint pointerId, uint historyCount, uint propertiesCount, char* pProperties, 
                             char* pValues);

@DllImport("USER32")
BOOL GetCurrentInputMessageSource(INPUT_MESSAGE_SOURCE* inputMessageSource);

@DllImport("USER32")
BOOL GetCIMSSM(INPUT_MESSAGE_SOURCE* inputMessageSource);


// Interfaces

@GUID("7C476BA2-02B1-48F4-8048-B24619DDC058")
struct ImageList;

@GUID("46EB5926-582E-4017-9FDF-E8998DAA0950")
interface IImageList : IUnknown
{
    HRESULT Add(HBITMAP hbmImage, HBITMAP hbmMask, int* pi);
    HRESULT ReplaceIcon(int i, HICON hicon, int* pi);
    HRESULT SetOverlayImage(int iImage, int iOverlay);
    HRESULT Replace(int i, HBITMAP hbmImage, HBITMAP hbmMask);
    HRESULT AddMasked(HBITMAP hbmImage, uint crMask, int* pi);
    HRESULT Draw(IMAGELISTDRAWPARAMS* pimldp);
    HRESULT Remove(int i);
    HRESULT GetIcon(int i, uint flags, HICON* picon);
    HRESULT GetImageInfo(int i, IMAGEINFO* pImageInfo);
    HRESULT Copy(int iDst, IUnknown punkSrc, int iSrc, uint uFlags);
    HRESULT Merge(int i1, IUnknown punk2, int i2, int dx, int dy, const(GUID)* riid, void** ppv);
    HRESULT Clone(const(GUID)* riid, void** ppv);
    HRESULT GetImageRect(int i, RECT* prc);
    HRESULT GetIconSize(int* cx, int* cy);
    HRESULT SetIconSize(int cx, int cy);
    HRESULT GetImageCount(int* pi);
    HRESULT SetImageCount(uint uNewCount);
    HRESULT SetBkColor(uint clrBk, uint* pclr);
    HRESULT GetBkColor(uint* pclr);
    HRESULT BeginDrag(int iTrack, int dxHotspot, int dyHotspot);
    HRESULT EndDrag();
    HRESULT DragEnter(HWND hwndLock, int x, int y);
    HRESULT DragLeave(HWND hwndLock);
    HRESULT DragMove(int x, int y);
    HRESULT SetDragCursorImage(IUnknown punk, int iDrag, int dxHotspot, int dyHotspot);
    HRESULT DragShowNolock(BOOL fShow);
    HRESULT GetDragImage(POINT* ppt, POINT* pptHotspot, const(GUID)* riid, void** ppv);
    HRESULT GetItemFlags(int i, uint* dwFlags);
    HRESULT GetOverlayImage(int iOverlay, int* piIndex);
}

@GUID("192B9D83-50FC-457B-90A0-2B82A8B5DAE1")
interface IImageList2 : IImageList
{
    HRESULT SetOverlayImage(int iImage, int iOverlay);
    HRESULT Replace(int i, HBITMAP hbmImage, HBITMAP hbmMask);
    HRESULT AddMasked(HBITMAP hbmImage, uint crMask, int* pi);
    HRESULT Draw(IMAGELISTDRAWPARAMS* pimldp);
    HRESULT Remove(int i);
    HRESULT GetIcon(int i, uint flags, HICON* picon);
    HRESULT GetImageInfo(int i, IMAGEINFO* pImageInfo);
    HRESULT Copy(int iDst, IUnknown punkSrc, int iSrc, uint uFlags);
    HRESULT Merge(int i1, IUnknown punk2, int i2, int dx, int dy, const(GUID)* riid, void** ppv);
    HRESULT Clone(const(GUID)* riid, void** ppv);
    HRESULT GetImageRect(int i, RECT* prc);
    HRESULT GetIconSize(int* cx, int* cy);
    HRESULT SetIconSize(int cx, int cy);
    HRESULT GetImageCount(int* pi);
    HRESULT SetImageCount(uint uNewCount);
    HRESULT SetBkColor(uint clrBk, uint* pclr);
    HRESULT GetBkColor(uint* pclr);
    HRESULT BeginDrag(int iTrack, int dxHotspot, int dyHotspot);
    HRESULT EndDrag();
    HRESULT DragEnter(HWND hwndLock, int x, int y);
    HRESULT DragLeave(HWND hwndLock);
    HRESULT DragMove(int x, int y);
    HRESULT SetDragCursorImage(IUnknown punk, int iDrag, int dxHotspot, int dyHotspot);
    HRESULT DragShowNolock(BOOL fShow);
    HRESULT GetDragImage(POINT* ppt, POINT* pptHotspot, const(GUID)* riid, void** ppv);
    HRESULT GetItemFlags(int i, uint* dwFlags);
    HRESULT GetOverlayImage(int iOverlay, int* piIndex);
    HRESULT Resize(int cxNewIconSize, int cyNewIconSize);
    HRESULT GetOriginalSize(int iImage, uint dwFlags, int* pcx, int* pcy);
    HRESULT SetOriginalSize(int iImage, int cx, int cy);
    HRESULT SetCallback(IUnknown punk);
    HRESULT GetCallback(const(GUID)* riid, void** ppv);
    HRESULT ForceImagePresent(int iImage, uint dwFlags);
    HRESULT DiscardImages(int iFirstImage, int iLastImage, uint dwFlags);
    HRESULT PreloadImages(IMAGELISTDRAWPARAMS* pimldp);
    HRESULT GetStatistics(IMAGELISTSTATS* pils);
    HRESULT Initialize(int cx, int cy, uint flags, int cInitial, int cGrow);
    HRESULT Replace2(int i, HBITMAP hbmImage, HBITMAP hbmMask, IUnknown punk, uint dwFlags);
    HRESULT ReplaceFromImageList(int i, IImageList pil, int iSrc, IUnknown punk, uint dwFlags);
}

@GUID("8CC497C0-A1DF-11CE-8098-00AA0047BE5D")
interface ITextDocument : IDispatch
{
    HRESULT GetName(BSTR* pName);
    HRESULT GetSelection(ITextSelection* ppSel);
    HRESULT GetStoryCount(int* pCount);
    HRESULT GetStoryRanges(ITextStoryRanges* ppStories);
    HRESULT GetSaved(int* pValue);
    HRESULT SetSaved(int Value);
    HRESULT GetDefaultTabStop(float* pValue);
    HRESULT SetDefaultTabStop(float Value);
    HRESULT New();
    HRESULT Open(VARIANT* pVar, int Flags, int CodePage);
    HRESULT Save(VARIANT* pVar, int Flags, int CodePage);
    HRESULT Freeze(int* pCount);
    HRESULT Unfreeze(int* pCount);
    HRESULT BeginEditCollection();
    HRESULT EndEditCollection();
    HRESULT Undo(int Count, int* pCount);
    HRESULT Redo(int Count, int* pCount);
    HRESULT Range(int cpActive, int cpAnchor, ITextRange* ppRange);
    HRESULT RangeFromPoint(int x, int y, ITextRange* ppRange);
}

@GUID("8CC497C2-A1DF-11CE-8098-00AA0047BE5D")
interface ITextRange : IDispatch
{
    HRESULT GetText(BSTR* pbstr);
    HRESULT SetText(BSTR bstr);
    HRESULT GetChar(int* pChar);
    HRESULT SetChar(int Char);
    HRESULT GetDuplicate(ITextRange* ppRange);
    HRESULT GetFormattedText(ITextRange* ppRange);
    HRESULT SetFormattedText(ITextRange pRange);
    HRESULT GetStart(int* pcpFirst);
    HRESULT SetStart(int cpFirst);
    HRESULT GetEnd(int* pcpLim);
    HRESULT SetEnd(int cpLim);
    HRESULT GetFont(ITextFont* ppFont);
    HRESULT SetFont(ITextFont pFont);
    HRESULT GetPara(ITextPara* ppPara);
    HRESULT SetPara(ITextPara pPara);
    HRESULT GetStoryLength(int* pCount);
    HRESULT GetStoryType(int* pValue);
    HRESULT Collapse(int bStart);
    HRESULT Expand(int Unit, int* pDelta);
    HRESULT GetIndex(int Unit, int* pIndex);
    HRESULT SetIndex(int Unit, int Index, int Extend);
    HRESULT SetRange(int cpAnchor, int cpActive);
    HRESULT InRange(ITextRange pRange, int* pValue);
    HRESULT InStory(ITextRange pRange, int* pValue);
    HRESULT IsEqual(ITextRange pRange, int* pValue);
    HRESULT Select();
    HRESULT StartOf(int Unit, int Extend, int* pDelta);
    HRESULT EndOf(int Unit, int Extend, int* pDelta);
    HRESULT Move(int Unit, int Count, int* pDelta);
    HRESULT MoveStart(int Unit, int Count, int* pDelta);
    HRESULT MoveEnd(int Unit, int Count, int* pDelta);
    HRESULT MoveWhile(VARIANT* Cset, int Count, int* pDelta);
    HRESULT MoveStartWhile(VARIANT* Cset, int Count, int* pDelta);
    HRESULT MoveEndWhile(VARIANT* Cset, int Count, int* pDelta);
    HRESULT MoveUntil(VARIANT* Cset, int Count, int* pDelta);
    HRESULT MoveStartUntil(VARIANT* Cset, int Count, int* pDelta);
    HRESULT MoveEndUntil(VARIANT* Cset, int Count, int* pDelta);
    HRESULT FindTextA(BSTR bstr, int Count, int Flags, int* pLength);
    HRESULT FindTextStart(BSTR bstr, int Count, int Flags, int* pLength);
    HRESULT FindTextEnd(BSTR bstr, int Count, int Flags, int* pLength);
    HRESULT Delete(int Unit, int Count, int* pDelta);
    HRESULT Cut(VARIANT* pVar);
    HRESULT Copy(VARIANT* pVar);
    HRESULT Paste(VARIANT* pVar, int Format);
    HRESULT CanPaste(VARIANT* pVar, int Format, int* pValue);
    HRESULT CanEdit(int* pValue);
    HRESULT ChangeCase(int Type);
    HRESULT GetPoint(int Type, int* px, int* py);
    HRESULT SetPoint(int x, int y, int Type, int Extend);
    HRESULT ScrollIntoView(int Value);
    HRESULT GetEmbeddedObject(IUnknown* ppObject);
}

@GUID("8CC497C1-A1DF-11CE-8098-00AA0047BE5D")
interface ITextSelection : ITextRange
{
    HRESULT GetFlags(int* pFlags);
    HRESULT SetFlags(int Flags);
    HRESULT GetType(int* pType);
    HRESULT MoveLeft(int Unit, int Count, int Extend, int* pDelta);
    HRESULT MoveRight(int Unit, int Count, int Extend, int* pDelta);
    HRESULT MoveUp(int Unit, int Count, int Extend, int* pDelta);
    HRESULT MoveDown(int Unit, int Count, int Extend, int* pDelta);
    HRESULT HomeKey(int Unit, int Extend, int* pDelta);
    HRESULT EndKey(int Unit, int Extend, int* pDelta);
    HRESULT TypeText(BSTR bstr);
}

@GUID("8CC497C3-A1DF-11CE-8098-00AA0047BE5D")
interface ITextFont : IDispatch
{
    HRESULT GetDuplicate(ITextFont* ppFont);
    HRESULT SetDuplicate(ITextFont pFont);
    HRESULT CanChange(int* pValue);
    HRESULT IsEqual(ITextFont pFont, int* pValue);
    HRESULT Reset(int Value);
    HRESULT GetStyle(int* pValue);
    HRESULT SetStyle(int Value);
    HRESULT GetAllCaps(int* pValue);
    HRESULT SetAllCaps(int Value);
    HRESULT GetAnimation(int* pValue);
    HRESULT SetAnimation(int Value);
    HRESULT GetBackColor(int* pValue);
    HRESULT SetBackColor(int Value);
    HRESULT GetBold(int* pValue);
    HRESULT SetBold(int Value);
    HRESULT GetEmboss(int* pValue);
    HRESULT SetEmboss(int Value);
    HRESULT GetForeColor(int* pValue);
    HRESULT SetForeColor(int Value);
    HRESULT GetHidden(int* pValue);
    HRESULT SetHidden(int Value);
    HRESULT GetEngrave(int* pValue);
    HRESULT SetEngrave(int Value);
    HRESULT GetItalic(int* pValue);
    HRESULT SetItalic(int Value);
    HRESULT GetKerning(float* pValue);
    HRESULT SetKerning(float Value);
    HRESULT GetLanguageID(int* pValue);
    HRESULT SetLanguageID(int Value);
    HRESULT GetName(BSTR* pbstr);
    HRESULT SetName(BSTR bstr);
    HRESULT GetOutline(int* pValue);
    HRESULT SetOutline(int Value);
    HRESULT GetPosition(float* pValue);
    HRESULT SetPosition(float Value);
    HRESULT GetProtected(int* pValue);
    HRESULT SetProtected(int Value);
    HRESULT GetShadow(int* pValue);
    HRESULT SetShadow(int Value);
    HRESULT GetSize(float* pValue);
    HRESULT SetSize(float Value);
    HRESULT GetSmallCaps(int* pValue);
    HRESULT SetSmallCaps(int Value);
    HRESULT GetSpacing(float* pValue);
    HRESULT SetSpacing(float Value);
    HRESULT GetStrikeThrough(int* pValue);
    HRESULT SetStrikeThrough(int Value);
    HRESULT GetSubscript(int* pValue);
    HRESULT SetSubscript(int Value);
    HRESULT GetSuperscript(int* pValue);
    HRESULT SetSuperscript(int Value);
    HRESULT GetUnderline(int* pValue);
    HRESULT SetUnderline(int Value);
    HRESULT GetWeight(int* pValue);
    HRESULT SetWeight(int Value);
}

@GUID("8CC497C4-A1DF-11CE-8098-00AA0047BE5D")
interface ITextPara : IDispatch
{
    HRESULT GetDuplicate(ITextPara* ppPara);
    HRESULT SetDuplicate(ITextPara pPara);
    HRESULT CanChange(int* pValue);
    HRESULT IsEqual(ITextPara pPara, int* pValue);
    HRESULT Reset(int Value);
    HRESULT GetStyle(int* pValue);
    HRESULT SetStyle(int Value);
    HRESULT GetAlignment(int* pValue);
    HRESULT SetAlignment(int Value);
    HRESULT GetHyphenation(int* pValue);
    HRESULT SetHyphenation(int Value);
    HRESULT GetFirstLineIndent(float* pValue);
    HRESULT GetKeepTogether(int* pValue);
    HRESULT SetKeepTogether(int Value);
    HRESULT GetKeepWithNext(int* pValue);
    HRESULT SetKeepWithNext(int Value);
    HRESULT GetLeftIndent(float* pValue);
    HRESULT GetLineSpacing(float* pValue);
    HRESULT GetLineSpacingRule(int* pValue);
    HRESULT GetListAlignment(int* pValue);
    HRESULT SetListAlignment(int Value);
    HRESULT GetListLevelIndex(int* pValue);
    HRESULT SetListLevelIndex(int Value);
    HRESULT GetListStart(int* pValue);
    HRESULT SetListStart(int Value);
    HRESULT GetListTab(float* pValue);
    HRESULT SetListTab(float Value);
    HRESULT GetListType(int* pValue);
    HRESULT SetListType(int Value);
    HRESULT GetNoLineNumber(int* pValue);
    HRESULT SetNoLineNumber(int Value);
    HRESULT GetPageBreakBefore(int* pValue);
    HRESULT SetPageBreakBefore(int Value);
    HRESULT GetRightIndent(float* pValue);
    HRESULT SetRightIndent(float Value);
    HRESULT SetIndents(float First, float Left, float Right);
    HRESULT SetLineSpacing(int Rule, float Spacing);
    HRESULT GetSpaceAfter(float* pValue);
    HRESULT SetSpaceAfter(float Value);
    HRESULT GetSpaceBefore(float* pValue);
    HRESULT SetSpaceBefore(float Value);
    HRESULT GetWidowControl(int* pValue);
    HRESULT SetWidowControl(int Value);
    HRESULT GetTabCount(int* pCount);
    HRESULT AddTab(float tbPos, int tbAlign, int tbLeader);
    HRESULT ClearAllTabs();
    HRESULT DeleteTab(float tbPos);
    HRESULT GetTab(int iTab, float* ptbPos, int* ptbAlign, int* ptbLeader);
}

@GUID("8CC497C5-A1DF-11CE-8098-00AA0047BE5D")
interface ITextStoryRanges : IDispatch
{
    HRESULT _NewEnum(IUnknown* ppunkEnum);
    HRESULT Item(int Index, ITextRange* ppRange);
    HRESULT GetCount(int* pCount);
}

@GUID("C241F5E0-7206-11D8-A2C7-00A0D1D6C6B3")
interface ITextDocument2 : ITextDocument
{
    HRESULT GetCaretType(int* pValue);
    HRESULT SetCaretType(int Value);
    HRESULT GetDisplays(ITextDisplays* ppDisplays);
    HRESULT GetDocumentFont(ITextFont2* ppFont);
    HRESULT SetDocumentFont(ITextFont2 pFont);
    HRESULT GetDocumentPara(ITextPara2* ppPara);
    HRESULT SetDocumentPara(ITextPara2 pPara);
    HRESULT GetEastAsianFlags(int* pFlags);
    HRESULT GetGenerator(BSTR* pbstr);
    HRESULT SetIMEInProgress(int Value);
    HRESULT GetNotificationMode(int* pValue);
    HRESULT SetNotificationMode(int Value);
    HRESULT GetSelection2(ITextSelection2* ppSel);
    HRESULT GetStoryRanges2(ITextStoryRanges2* ppStories);
    HRESULT GetTypographyOptions(int* pOptions);
    HRESULT GetVersion(int* pValue);
    HRESULT GetWindow(long* pHwnd);
    HRESULT AttachMsgFilter(IUnknown pFilter);
    HRESULT CheckTextLimit(int cch, int* pcch);
    HRESULT GetCallManager(IUnknown* ppVoid);
    HRESULT GetClientRect(int Type, int* pLeft, int* pTop, int* pRight, int* pBottom);
    HRESULT GetEffectColor(int Index, int* pValue);
    HRESULT GetImmContext(long* pContext);
    HRESULT GetPreferredFont(int cp, int CharRep, int Options, int curCharRep, int curFontSize, BSTR* pbstr, 
                             int* pPitchAndFamily, int* pNewFontSize);
    HRESULT GetProperty(int Type, int* pValue);
    HRESULT GetStrings(ITextStrings* ppStrs);
    HRESULT Notify(int Notify);
    HRESULT Range2(int cpActive, int cpAnchor, ITextRange2* ppRange);
    HRESULT RangeFromPoint2(int x, int y, int Type, ITextRange2* ppRange);
    HRESULT ReleaseCallManager(IUnknown pVoid);
    HRESULT ReleaseImmContext(long Context);
    HRESULT SetEffectColor(int Index, int Value);
    HRESULT SetProperty(int Type, int Value);
    HRESULT SetTypographyOptions(int Options, int Mask);
    HRESULT SysBeep();
    HRESULT Update(int Value);
    HRESULT UpdateWindow();
    HRESULT GetMathProperties(int* pOptions);
    HRESULT SetMathProperties(int Options, int Mask);
    HRESULT GetActiveStory(ITextStory* ppStory);
    HRESULT SetActiveStory(ITextStory pStory);
    HRESULT GetMainStory(ITextStory* ppStory);
    HRESULT GetNewStory(ITextStory* ppStory);
    HRESULT GetStory(int Index, ITextStory* ppStory);
}

@GUID("C241F5E2-7206-11D8-A2C7-00A0D1D6C6B3")
interface ITextRange2 : ITextSelection
{
    HRESULT GetCch(int* pcch);
    HRESULT GetCells(IUnknown* ppCells);
    HRESULT GetColumn(IUnknown* ppColumn);
    HRESULT GetCount(int* pCount);
    HRESULT GetDuplicate2(ITextRange2* ppRange);
    HRESULT GetFont2(ITextFont2* ppFont);
    HRESULT SetFont2(ITextFont2 pFont);
    HRESULT GetFormattedText2(ITextRange2* ppRange);
    HRESULT SetFormattedText2(ITextRange2 pRange);
    HRESULT GetGravity(int* pValue);
    HRESULT SetGravity(int Value);
    HRESULT GetPara2(ITextPara2* ppPara);
    HRESULT SetPara2(ITextPara2 pPara);
    HRESULT GetRow(ITextRow* ppRow);
    HRESULT GetStartPara(int* pValue);
    HRESULT GetTable(IUnknown* ppTable);
    HRESULT GetURL(BSTR* pbstr);
    HRESULT SetURL(BSTR bstr);
    HRESULT AddSubrange(int cp1, int cp2, int Activate);
    HRESULT BuildUpMath(int Flags);
    HRESULT DeleteSubrange(int cpFirst, int cpLim);
    HRESULT Find(ITextRange2 pRange, int Count, int Flags, int* pDelta);
    HRESULT GetChar2(int* pChar, int Offset);
    HRESULT GetDropCap(int* pcLine, int* pPosition);
    HRESULT GetInlineObject(int* pType, int* pAlign, int* pChar, int* pChar1, int* pChar2, int* pCount, 
                            int* pTeXStyle, int* pcCol, int* pLevel);
    HRESULT GetProperty(int Type, int* pValue);
    HRESULT GetRect(int Type, int* pLeft, int* pTop, int* pRight, int* pBottom, int* pHit);
    HRESULT GetSubrange(int iSubrange, int* pcpFirst, int* pcpLim);
    HRESULT GetText2(int Flags, BSTR* pbstr);
    HRESULT HexToUnicode();
    HRESULT InsertTable(int cCol, int cRow, int AutoFit);
    HRESULT Linearize(int Flags);
    HRESULT SetActiveSubrange(int cpAnchor, int cpActive);
    HRESULT SetDropCap(int cLine, int Position);
    HRESULT SetProperty(int Type, int Value);
    HRESULT SetText2(int Flags, BSTR bstr);
    HRESULT UnicodeToHex();
    HRESULT SetInlineObject(int Type, int Align, int Char, int Char1, int Char2, int Count, int TeXStyle, int cCol);
    HRESULT GetMathFunctionType(BSTR bstr, int* pValue);
    HRESULT InsertImage(int width, int height, int ascent, int Type, BSTR bstrAltText, IStream pStream);
}

@GUID("C241F5E1-7206-11D8-A2C7-00A0D1D6C6B3")
interface ITextSelection2 : ITextRange2
{
}

@GUID("C241F5E3-7206-11D8-A2C7-00A0D1D6C6B3")
interface ITextFont2 : ITextFont
{
    HRESULT GetCount(int* pCount);
    HRESULT GetAutoLigatures(int* pValue);
    HRESULT SetAutoLigatures(int Value);
    HRESULT GetAutospaceAlpha(int* pValue);
    HRESULT SetAutospaceAlpha(int Value);
    HRESULT GetAutospaceNumeric(int* pValue);
    HRESULT SetAutospaceNumeric(int Value);
    HRESULT GetAutospaceParens(int* pValue);
    HRESULT SetAutospaceParens(int Value);
    HRESULT GetCharRep(int* pValue);
    HRESULT SetCharRep(int Value);
    HRESULT GetCompressionMode(int* pValue);
    HRESULT SetCompressionMode(int Value);
    HRESULT GetCookie(int* pValue);
    HRESULT SetCookie(int Value);
    HRESULT GetDoubleStrike(int* pValue);
    HRESULT SetDoubleStrike(int Value);
    HRESULT GetDuplicate2(ITextFont2* ppFont);
    HRESULT SetDuplicate2(ITextFont2 pFont);
    HRESULT GetLinkType(int* pValue);
    HRESULT GetMathZone(int* pValue);
    HRESULT SetMathZone(int Value);
    HRESULT GetModWidthPairs(int* pValue);
    HRESULT SetModWidthPairs(int Value);
    HRESULT GetModWidthSpace(int* pValue);
    HRESULT SetModWidthSpace(int Value);
    HRESULT GetOldNumbers(int* pValue);
    HRESULT SetOldNumbers(int Value);
    HRESULT GetOverlapping(int* pValue);
    HRESULT SetOverlapping(int Value);
    HRESULT GetPositionSubSuper(int* pValue);
    HRESULT SetPositionSubSuper(int Value);
    HRESULT GetScaling(int* pValue);
    HRESULT SetScaling(int Value);
    HRESULT GetSpaceExtension(float* pValue);
    HRESULT SetSpaceExtension(float Value);
    HRESULT GetUnderlinePositionMode(int* pValue);
    HRESULT SetUnderlinePositionMode(int Value);
    HRESULT GetEffects(int* pValue, int* pMask);
    HRESULT GetEffects2(int* pValue, int* pMask);
    HRESULT GetProperty(int Type, int* pValue);
    HRESULT GetPropertyInfo(int Index, int* pType, int* pValue);
    HRESULT IsEqual2(ITextFont2 pFont, int* pB);
    HRESULT SetEffects(int Value, int Mask);
    HRESULT SetEffects2(int Value, int Mask);
    HRESULT SetProperty(int Type, int Value);
}

@GUID("C241F5E4-7206-11D8-A2C7-00A0D1D6C6B3")
interface ITextPara2 : ITextPara
{
    HRESULT GetBorders(IUnknown* ppBorders);
    HRESULT GetDuplicate2(ITextPara2* ppPara);
    HRESULT SetDuplicate2(ITextPara2 pPara);
    HRESULT GetFontAlignment(int* pValue);
    HRESULT SetFontAlignment(int Value);
    HRESULT GetHangingPunctuation(int* pValue);
    HRESULT SetHangingPunctuation(int Value);
    HRESULT GetSnapToGrid(int* pValue);
    HRESULT SetSnapToGrid(int Value);
    HRESULT GetTrimPunctuationAtStart(int* pValue);
    HRESULT SetTrimPunctuationAtStart(int Value);
    HRESULT GetEffects(int* pValue, int* pMask);
    HRESULT GetProperty(int Type, int* pValue);
    HRESULT IsEqual2(ITextPara2 pPara, int* pB);
    HRESULT SetEffects(int Value, int Mask);
    HRESULT SetProperty(int Type, int Value);
}

@GUID("C241F5E5-7206-11D8-A2C7-00A0D1D6C6B3")
interface ITextStoryRanges2 : ITextStoryRanges
{
    HRESULT Item2(int Index, ITextRange2* ppRange);
}

@GUID("C241F5F3-7206-11D8-A2C7-00A0D1D6C6B3")
interface ITextStory : IUnknown
{
    HRESULT GetActive(int* pValue);
    HRESULT SetActive(int Value);
    HRESULT GetDisplay(IUnknown* ppDisplay);
    HRESULT GetIndex(int* pValue);
    HRESULT GetType(int* pValue);
    HRESULT SetType(int Value);
    HRESULT GetProperty(int Type, int* pValue);
    HRESULT GetRange(int cpActive, int cpAnchor, ITextRange2* ppRange);
    HRESULT GetText(int Flags, BSTR* pbstr);
    HRESULT SetFormattedText(IUnknown pUnk);
    HRESULT SetProperty(int Type, int Value);
    HRESULT SetText(int Flags, BSTR bstr);
}

@GUID("C241F5E7-7206-11D8-A2C7-00A0D1D6C6B3")
interface ITextStrings : IDispatch
{
    HRESULT Item(int Index, ITextRange2* ppRange);
    HRESULT GetCount(int* pCount);
    HRESULT Add(BSTR bstr);
    HRESULT Append(ITextRange2 pRange, int iString);
    HRESULT Cat2(int iString);
    HRESULT CatTop2(BSTR bstr);
    HRESULT DeleteRange(ITextRange2 pRange);
    HRESULT EncodeFunction(int Type, int Align, int Char, int Char1, int Char2, int Count, int TeXStyle, int cCol, 
                           ITextRange2 pRange);
    HRESULT GetCch(int iString, int* pcch);
    HRESULT InsertNullStr(int iString);
    HRESULT MoveBoundary(int iString, int cch);
    HRESULT PrefixTop(BSTR bstr);
    HRESULT Remove(int iString, int cString);
    HRESULT SetFormattedText(ITextRange2 pRangeD, ITextRange2 pRangeS);
    HRESULT SetOpCp(int iString, int cp);
    HRESULT SuffixTop(BSTR bstr, ITextRange2 pRange);
    HRESULT Swap();
}

@GUID("C241F5EF-7206-11D8-A2C7-00A0D1D6C6B3")
interface ITextRow : IDispatch
{
    HRESULT GetAlignment(int* pValue);
    HRESULT SetAlignment(int Value);
    HRESULT GetCellCount(int* pValue);
    HRESULT SetCellCount(int Value);
    HRESULT GetCellCountCache(int* pValue);
    HRESULT SetCellCountCache(int Value);
    HRESULT GetCellIndex(int* pValue);
    HRESULT SetCellIndex(int Value);
    HRESULT GetCellMargin(int* pValue);
    HRESULT SetCellMargin(int Value);
    HRESULT GetHeight(int* pValue);
    HRESULT SetHeight(int Value);
    HRESULT GetIndent(int* pValue);
    HRESULT SetIndent(int Value);
    HRESULT GetKeepTogether(int* pValue);
    HRESULT SetKeepTogether(int Value);
    HRESULT GetKeepWithNext(int* pValue);
    HRESULT SetKeepWithNext(int Value);
    HRESULT GetNestLevel(int* pValue);
    HRESULT GetRTL(int* pValue);
    HRESULT SetRTL(int Value);
    HRESULT GetCellAlignment(int* pValue);
    HRESULT SetCellAlignment(int Value);
    HRESULT GetCellColorBack(int* pValue);
    HRESULT SetCellColorBack(int Value);
    HRESULT GetCellColorFore(int* pValue);
    HRESULT SetCellColorFore(int Value);
    HRESULT GetCellMergeFlags(int* pValue);
    HRESULT SetCellMergeFlags(int Value);
    HRESULT GetCellShading(int* pValue);
    HRESULT SetCellShading(int Value);
    HRESULT GetCellVerticalText(int* pValue);
    HRESULT SetCellVerticalText(int Value);
    HRESULT GetCellWidth(int* pValue);
    HRESULT SetCellWidth(int Value);
    HRESULT GetCellBorderColors(int* pcrLeft, int* pcrTop, int* pcrRight, int* pcrBottom);
    HRESULT GetCellBorderWidths(int* pduLeft, int* pduTop, int* pduRight, int* pduBottom);
    HRESULT SetCellBorderColors(int crLeft, int crTop, int crRight, int crBottom);
    HRESULT SetCellBorderWidths(int duLeft, int duTop, int duRight, int duBottom);
    HRESULT Apply(int cRow, int Flags);
    HRESULT CanChange(int* pValue);
    HRESULT GetProperty(int Type, int* pValue);
    HRESULT Insert(int cRow);
    HRESULT IsEqual(ITextRow pRow, int* pB);
    HRESULT Reset(int Value);
    HRESULT SetProperty(int Type, int Value);
}

@GUID("C241F5F2-7206-11D8-A2C7-00A0D1D6C6B3")
interface ITextDisplays : IDispatch
{
}

@GUID("01C25500-4268-11D1-883A-3C8B00C10000")
interface ITextDocument2Old : ITextDocument
{
    HRESULT AttachMsgFilter(IUnknown pFilter);
    HRESULT SetEffectColor(int Index, uint cr);
    HRESULT GetEffectColor(int Index, uint* pcr);
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

interface IRichEditOle : IUnknown
{
    HRESULT GetClientSite(IOleClientSite* lplpolesite);
    int     GetObjectCount();
    int     GetLinkCount();
    HRESULT GetObjectA(int iob, REOBJECT* lpreobject, uint dwFlags);
    HRESULT InsertObject(REOBJECT* lpreobject);
    HRESULT ConvertObject(int iob, const(GUID)* rclsidNew, const(char)* lpstrUserTypeNew);
    HRESULT ActivateAs(const(GUID)* rclsid, const(GUID)* rclsidAs);
    HRESULT SetHostNames(const(char)* lpstrContainerApp, const(char)* lpstrContainerObj);
    HRESULT SetLinkAvailable(int iob, BOOL fAvailable);
    HRESULT SetDvaspect(int iob, uint dvaspect);
    HRESULT HandsOffStorage(int iob);
    HRESULT SaveCompleted(int iob, IStorage lpstg);
    HRESULT InPlaceDeactivate();
    HRESULT ContextSensitiveHelp(BOOL fEnterMode);
    HRESULT GetClipboardData(CHARRANGE* lpchrg, uint reco, IDataObject* lplpdataobj);
    HRESULT ImportDataObject(IDataObject lpdataobj, ushort cf, ptrdiff_t hMetaPict);
}

interface IRichEditOleCallback : IUnknown
{
    HRESULT GetNewStorage(IStorage* lplpstg);
    HRESULT GetInPlaceContext(IOleInPlaceFrame* lplpFrame, IOleInPlaceUIWindow* lplpDoc, OIFI* lpFrameInfo);
    HRESULT ShowContainerUI(BOOL fShow);
    HRESULT QueryInsertObject(GUID* lpclsid, IStorage lpstg, int cp);
    HRESULT DeleteObject(IOleObject lpoleobj);
    HRESULT QueryAcceptData(IDataObject lpdataobj, ushort* lpcfFormat, uint reco, BOOL fReally, 
                            ptrdiff_t hMetaPict);
    HRESULT ContextSensitiveHelp(BOOL fEnterMode);
    HRESULT GetClipboardData(CHARRANGE* lpchrg, uint reco, IDataObject* lplpdataobj);
    HRESULT GetDragDropEffect(BOOL fDrag, uint grfKeyState, uint* pdwEffect);
    HRESULT GetContextMenu(ushort seltype, IOleObject lpoleobj, CHARRANGE* lpchrg, HMENU* lphmenu);
}

interface ITextServices : IUnknown
{
    HRESULT TxSendMessage(uint msg, WPARAM wparam, LPARAM lparam, LRESULT* plresult);
    HRESULT TxDraw(uint dwDrawAspect, int lindex, void* pvAspect, DVTARGETDEVICE* ptd, HDC hdcDraw, 
                   HDC hicTargetDev, RECTL* lprcBounds, RECTL* lprcWBounds, RECT* lprcUpdate, 
                   BOOL********** pfnContinue, uint dwContinue, int lViewId);
    HRESULT TxGetHScroll(int* plMin, int* plMax, int* plPos, int* plPage, int* pfEnabled);
    HRESULT TxGetVScroll(int* plMin, int* plMax, int* plPos, int* plPage, int* pfEnabled);
    HRESULT OnTxSetCursor(uint dwDrawAspect, int lindex, void* pvAspect, DVTARGETDEVICE* ptd, HDC hdcDraw, 
                          HDC hicTargetDev, RECT* lprcClient, int x, int y);
    HRESULT TxQueryHitPoint(uint dwDrawAspect, int lindex, void* pvAspect, DVTARGETDEVICE* ptd, HDC hdcDraw, 
                            HDC hicTargetDev, RECT* lprcClient, int x, int y, uint* pHitResult);
    HRESULT OnTxInPlaceActivate(RECT* prcClient);
    HRESULT OnTxInPlaceDeactivate();
    HRESULT OnTxUIActivate();
    HRESULT OnTxUIDeactivate();
    HRESULT TxGetText(BSTR* pbstrText);
    HRESULT TxSetText(const(wchar)* pszText);
    HRESULT TxGetCurTargetX(int* param0);
    HRESULT TxGetBaseLinePos(int* param0);
    HRESULT TxGetNaturalSize(uint dwAspect, HDC hdcDraw, HDC hicTargetDev, DVTARGETDEVICE* ptd, uint dwMode, 
                             const(SIZE)* psizelExtent, int* pwidth, int* pheight);
    HRESULT TxGetDropTarget(IDropTarget* ppDropTarget);
    HRESULT OnTxPropertyBitsChange(uint dwMask, uint dwBits);
    HRESULT TxGetCachedSize(uint* pdwWidth, uint* pdwHeight);
}

interface ITextHost : IUnknown
{
    HDC     TxGetDC();
    int     TxReleaseDC(HDC hdc);
    BOOL    TxShowScrollBar(int fnBar, BOOL fShow);
    BOOL    TxEnableScrollBar(int fuSBFlags, int fuArrowflags);
    BOOL    TxSetScrollRange(int fnBar, int nMinPos, int nMaxPos, BOOL fRedraw);
    BOOL    TxSetScrollPos(int fnBar, int nPos, BOOL fRedraw);
    void    TxInvalidateRect(RECT* prc, BOOL fMode);
    void    TxViewChange(BOOL fUpdate);
    BOOL    TxCreateCaret(HBITMAP hbmp, int xWidth, int yHeight);
    BOOL    TxShowCaret(BOOL fShow);
    BOOL    TxSetCaretPos(int x, int y);
    BOOL    TxSetTimer(uint idTimer, uint uTimeout);
    void    TxKillTimer(uint idTimer);
    void    TxScrollWindowEx(int dx, int dy, RECT* lprcScroll, RECT* lprcClip, HRGN hrgnUpdate, RECT* lprcUpdate, 
                             uint fuScroll);
    void    TxSetCapture(BOOL fCapture);
    void    TxSetFocus();
    void    TxSetCursor(HCURSOR hcur, BOOL fText);
    BOOL    TxScreenToClient(POINT* lppt);
    BOOL    TxClientToScreen(POINT* lppt);
    HRESULT TxActivate(int* plOldState);
    HRESULT TxDeactivate(int lNewState);
    HRESULT TxGetClientRect(RECT* prc);
    HRESULT TxGetViewInset(RECT* prc);
    HRESULT TxGetCharFormat(const(CHARFORMATW)** ppCF);
    HRESULT TxGetParaFormat(const(PARAFORMAT)** ppPF);
    uint    TxGetSysColor(int nIndex);
    HRESULT TxGetBackStyle(TXTBACKSTYLE* pstyle);
    HRESULT TxGetMaxLength(uint* plength);
    HRESULT TxGetScrollBars(uint* pdwScrollBar);
    HRESULT TxGetPasswordChar(byte* pch);
    HRESULT TxGetAcceleratorPos(int* pcp);
    HRESULT TxGetExtent(SIZE* lpExtent);
    HRESULT OnTxCharFormatChange(const(CHARFORMATW)* pCF);
    HRESULT OnTxParaFormatChange(const(PARAFORMAT)* pPF);
    HRESULT TxGetPropertyBits(uint dwMask, uint* pdwBits);
    HRESULT TxNotify(uint iNotify, void* pv);
    HIMC__* TxImmGetContext();
    void    TxImmReleaseContext(HIMC__* himc);
    HRESULT TxGetSelectionBarWidth(int* lSelBarWidth);
}

interface IRicheditWindowlessAccessibility : IUnknown
{
    HRESULT CreateProvider(IRawElementProviderWindowlessSite pSite, IRawElementProviderSimple* ppProvider);
}

interface IRichEditUiaInformation : IUnknown
{
    HRESULT GetBoundaryRectangle(UiaRect* pUiaRect);
    HRESULT IsVisible();
}

interface IRicheditUiaOverrides : IUnknown
{
    HRESULT GetPropertyOverrideValue(int propertyId, VARIANT* pRetValue);
}

interface ITextHost2 : ITextHost
{
    BOOL     TxIsDoubleClickPending();
    HRESULT  TxGetWindow(HWND* phwnd);
    HRESULT  TxSetForegroundWindow();
    HPALETTE TxGetPalette();
    HRESULT  TxGetEastAsianFlags(int* pFlags);
    HCURSOR  TxSetCursor2(HCURSOR hcur, BOOL bText);
    void     TxFreeTextServicesNotification();
    HRESULT  TxGetEditStyle(uint dwItem, uint* pdwData);
    HRESULT  TxGetWindowStyles(uint* pdwStyle, uint* pdwExStyle);
    HRESULT  TxShowDropCaret(BOOL fShow, HDC hdc, RECT* prc);
    HRESULT  TxDestroyCaret();
    HRESULT  TxGetHorzExtent(int* plHorzExtent);
}

interface ITextServices2 : ITextServices
{
    HRESULT TxGetNaturalSize2(uint dwAspect, HDC hdcDraw, HDC hicTargetDev, DVTARGETDEVICE* ptd, uint dwMode, 
                              const(SIZE)* psizelExtent, int* pwidth, int* pheight, int* pascent);
    HRESULT TxDrawD2D(ID2D1RenderTarget pRenderTarget, RECTL* lprcBounds, RECT* lprcUpdate, int lViewId);
}


// GUIDs

const GUID CLSID_ImageList = GUIDOF!ImageList;

const GUID IID_IImageList        = GUIDOF!IImageList;
const GUID IID_IImageList2       = GUIDOF!IImageList2;
const GUID IID_ITextDisplays     = GUIDOF!ITextDisplays;
const GUID IID_ITextDocument     = GUIDOF!ITextDocument;
const GUID IID_ITextDocument2    = GUIDOF!ITextDocument2;
const GUID IID_ITextDocument2Old = GUIDOF!ITextDocument2Old;
const GUID IID_ITextFont         = GUIDOF!ITextFont;
const GUID IID_ITextFont2        = GUIDOF!ITextFont2;
const GUID IID_ITextPara         = GUIDOF!ITextPara;
const GUID IID_ITextPara2        = GUIDOF!ITextPara2;
const GUID IID_ITextRange        = GUIDOF!ITextRange;
const GUID IID_ITextRange2       = GUIDOF!ITextRange2;
const GUID IID_ITextRow          = GUIDOF!ITextRow;
const GUID IID_ITextSelection    = GUIDOF!ITextSelection;
const GUID IID_ITextSelection2   = GUIDOF!ITextSelection2;
const GUID IID_ITextStory        = GUIDOF!ITextStory;
const GUID IID_ITextStoryRanges  = GUIDOF!ITextStoryRanges;
const GUID IID_ITextStoryRanges2 = GUIDOF!ITextStoryRanges2;
const GUID IID_ITextStrings      = GUIDOF!ITextStrings;
