// Written in the D programming language.

module windows.textservices;

public import windows.core;
public import windows.automation : BSTR, VARIANT;
public import windows.com : FORMATETC, HRESULT, IDataObject, IEnumGUID, IEnumString,
                            IUnknown;
public import windows.displaydevices : POINT, RECT, SIZE;
public import windows.gdi : HBITMAP, HICON;
public import windows.structuredstorage : IStream;
public import windows.systemservices : BOOL;
public import windows.windowsandmessaging : HWND, LPARAM, MSG, WPARAM;

extern(Windows):


// Enums


///Elements of the <b>TsActiveSelEnd</b> enumeration specify which end of a text store selection is active.
enum TsActiveSelEnd : int
{
    ///The selection has no active end. This is typical for all selections other than the default selection.
    TS_AE_NONE  = 0x00000000,
    ///The active end of the selection is at the start of the range of text.
    TS_AE_START = 0x00000001,
    ///The active end of the selection is at the end of the range of text.
    TS_AE_END   = 0x00000002,
}

///Elements of the <b>TsLayoutCode</b> enumeration are used to specify the type of layout change in an
///ITextStoreACPSink::OnLayoutChange or ITextStoreAnchorSink::OnLayoutChange notification.
enum TsLayoutCode : int
{
    ///The view has just been created.
    TS_LC_CREATE  = 0x00000000,
    ///The view layout has changed.
    TS_LC_CHANGE  = 0x00000001,
    ///The view is about to be destroyed.
    TS_LC_DESTROY = 0x00000002,
}

///Elements of the <b>TsRunType</b> enumeration specify if a text run is visible, hidden, or is a private data type
///embedded in the text run.
enum TsRunType : int
{
    ///The text run is visible.
    TS_RT_PLAIN  = 0x00000000,
    ///The text run is hidden.
    TS_RT_HIDDEN = 0x00000001,
    ///The text run is a private data type embedded in the text run.
    TS_RT_OPAQUE = 0x00000002,
}

///Elements of the <b>TsGravity</b> enumeration specify the gravity type associated with an IAnchor object.
enum TsGravity : int
{
    ///The anchor has backward gravity. For more information about anchor gravity, see Ranges.
    TS_GR_BACKWARD = 0x00000000,
    ///The anchor has forward gravity. For more information about anchor gravity, see Ranges.
    TS_GR_FORWARD  = 0x00000001,
}

///Elements of the <b>TsShiftDir</b> enumeration specify which direction an anchor is moved.
enum TsShiftDir : int
{
    ///Specifies that the anchor will be moved to the region immediately preceding a range of text.
    TS_SD_BACKWARD = 0x00000000,
    ///Specifies that the anchor will be moved to the region immediately following a range of text.
    TS_SD_FORWARD  = 0x00000001,
}

///Elements of the <b>TfLBIClick</b> enumeration specify which mouse button was used to click a toolbar item.
alias TfLBIClick = int;
enum : int
{
    ///The user right-clicked the button.
    TF_LBI_CLK_RIGHT = 0x00000001,
    ///The user left-clicked the button.
    TF_LBI_CLK_LEFT  = 0x00000002,
}

///Elements of the <b>TfLBBalloonStyle</b> enumeration are used to specify a language bar balloon style.
enum TfLBBalloonStyle : int
{
    ///This balloon style is used to represent a reconversion operation.
    TF_LB_BALLOON_RECO = 0x00000000,
    ///This is a normal balloon style.
    TF_LB_BALLOON_SHOW = 0x00000001,
    ///This balloon style is used to indicate that a command was not recognized.
    TF_LB_BALLOON_MISS = 0x00000002,
}

///Elements of the <b>TfAnchor</b> enumeration specify the start anchor or end anchor of an ITfRange object.
enum TfAnchor : int
{
    ///Specifies the start anchor of the <b>ITfRange</b> object.
    TF_ANCHOR_START = 0x00000000,
    ///Specifies the end anchor of the <b>ITfRange</b> object.
    TF_ANCHOR_END   = 0x00000001,
}

///Elements of the <b>TfActiveSelEnd</b> enumeration specify which end of a selected range of text is active.
enum TfActiveSelEnd : int
{
    ///The selected range has no active end. This is typical for selected ranges other than the default selected range.
    TF_AE_NONE  = 0x00000000,
    ///The active end is at the start of the selected range.
    TF_AE_START = 0x00000001,
    ///The active end is at the end of the selected range.
    TF_AE_END   = 0x00000002,
}

///Elements of the <b>TfLayoutCode</b> enumeration specify the type of layout change in an
///ITfTextLayoutSink::OnLayoutChange notification.
enum TfLayoutCode : int
{
    ///The view has just been created.
    TF_LC_CREATE  = 0x00000000,
    ///The view layout has changed.
    TF_LC_CHANGE  = 0x00000001,
    ///The view is about to be destroyed.
    TF_LC_DESTROY = 0x00000002,
}

///Elements of the <b>TfGravity</b> enumeration specify the type of gravity associated with the anchor of an ITfRange
///object.
enum TfGravity : int
{
    ///The anchor has backward gravity.
    TF_GRAVITY_BACKWARD = 0x00000000,
    ///The anchor has forward gravity.
    TF_GRAVITY_FORWARD  = 0x00000001,
}

///Elements of the <b>TfShiftDir</b> enumeration specify which direction a range anchor is moved.
enum TfShiftDir : int
{
    ///Specifies that the anchor will be moved to the region immediately preceding the range.
    TF_SD_BACKWARD = 0x00000000,
    ///Specifies that the anchor will be moved to the region immediately following the range.
    TF_SD_FORWARD  = 0x00000001,
}

///Elements of the <b>TF_DA_LINESTYLE</b> enumeration specify the underline style of a display attribute in the
///TF_DA_COLOR structure.
alias TF_DA_LINESTYLE = int;
enum : int
{
    ///The text is not underlined.
    TF_LS_NONE     = 0x00000000,
    ///The text is underlined with a solid line.
    TF_LS_SOLID    = 0x00000001,
    ///The text is underlined with a dotted line.
    TF_LS_DOT      = 0x00000002,
    ///The text is underlined with a dashed line.
    TF_LS_DASH     = 0x00000003,
    ///The text is underlined with a solid wavy line.
    TF_LS_SQUIGGLE = 0x00000004,
}

///Elements of the <b>TF_DA_COLORTYPE</b> enumeration specify the format of the color contained in the TF_DA_COLOR
///structure.
alias TF_DA_COLORTYPE = int;
enum : int
{
    ///The structure contains no color data.
    TF_CT_NONE     = 0x00000000,
    ///The color is specified as a system color index. For more information about the system color indexes, see
    ///GetSysColor.
    TF_CT_SYSCOLOR = 0x00000001,
    ///The color is specified as an RGB value.
    TF_CT_COLORREF = 0x00000002,
}

///Elements of the <b>TF_DA_ATTR_INFO</b> enumeration are used to specify text conversion data in the
///TF_DISPLAYATTRIBUTE structure.
alias TF_DA_ATTR_INFO = int;
enum : int
{
    ///The text is entered by the user and has not been converted yet.
    TF_ATTR_INPUT               = 0x00000000,
    ///The user has made a character selection and the text has been converted yet.
    TF_ATTR_TARGET_CONVERTED    = 0x00000001,
    ///The text is converted.
    TF_ATTR_CONVERTED           = 0x00000002,
    ///The user made a character selection, but the text is not converted yet.
    TF_ATTR_TARGET_NOTCONVERTED = 0x00000003,
    ///The text is an error character and cannot be converted. For example, some consonants cannot be put together.
    TF_ATTR_INPUT_ERROR         = 0x00000004,
    ///The text is not converted. Theses characters will no longer be converted.
    TF_ATTR_FIXEDCONVERTED      = 0x00000005,
    ///Reserved for the system.
    TF_ATTR_OTHER               = 0xffffffff,
}

///Elements of the <b>TfCandidateResult</b> enumeration are used with the ITfCandidateList::SetResult method to specify
///the result of a reconversion operation performed on a given candidate string.
enum TfCandidateResult : int
{
    ///The candidate string has been selected and accepted. The previous text should be replaced with the specified
    ///candidate.
    CAND_FINALIZED = 0x00000000,
    ///The candidate string has been selected, but the selection is not yet final.
    CAND_SELECTED  = 0x00000001,
    ///The reconversion operation has been canceled.
    CAND_CANCELED  = 0x00000002,
}

///Elements of the <b>TfSapiObject</b> enumeration are used with the ITfFnGetSAPIObject::Get method to specify a
///specific type of Speech API (SAPI) object.
enum TfSapiObject : int
{
    ///Specifies an ISpResourceManager object.
    GETIF_RESMGR           = 0x00000000,
    ///Specifies an ISpRecoContext object.
    GETIF_RECOCONTEXT      = 0x00000001,
    ///Specifies an ISpRecognizer object.
    GETIF_RECOGNIZER       = 0x00000002,
    ///Specifies an ISpVoice object.
    GETIF_VOICE            = 0x00000003,
    ///Specifies an ISpRecoGrammar object.
    GETIF_DICTGRAM         = 0x00000004,
    ///Specifies an ISpRecognizer object. SAPI will not be initialized if it is not already.
    GETIF_RECOGNIZERNOINIT = 0x00000005,
}

///Elements of the <b>TfIntegratableCandidateListSelectionStyle</b> enumeration specify the integratable candidate list
///selection styles.
enum TfIntegratableCandidateListSelectionStyle : int
{
    ///The selection can be changed with the arrow keys.
    STYLE_ACTIVE_SELECTION  = 0x00000000,
    ///The default selection key will choose the selection.
    STYLE_IMPLIED_SELECTION = 0x00000001,
}

///Elements of the <b>TKBLayoutType</b> enumeration are passed by an IME in a call to
///ITfFnGetPreferredTouchKeyboardLayout::GetLayout to specify the type of layout.
enum TKBLayoutType : int
{
    ///Undefined. If specified, it will cause the layout to fallback to a classic layout.
    TKBLT_UNDEFINED = 0x00000000,
    ///The touch keyboard is to use a classic layout.
    TKBLT_CLASSIC   = 0x00000001,
    ///The touch keyboard is to use a touch-optimized layout.
    TKBLT_OPTIMIZED = 0x00000002,
}

///The InputScope enumeration contains values that specify which input scopes are applied to a given field.
enum InputScope : int
{
    ///Indicates the standard recognition bias. Treated as default and uses the default lexicon. If combined with
    ///another input scope, it does not force coercion on the other input scope.
    IS_DEFAULT                       = 0x00000000,
    ///Indicates a URL, File, or FTP format. Examples include the following. <ul>
    ///<li>http://www.humongousinsurance.com/</li> <li>ftp://ftp.microsoft.com</li> <li>www.microsoft.com</li>
    ///<li>file:///C:\templ.txt</li> <li>$</li> </ul>
    IS_URL                           = 0x00000001,
    ///Indicates a file path. The following conditions are enforced. <ul> <li>For server name and share name, allows all
    ///IS_ONECHAR characters except: * ? : &lt; &gt; |</li> <li>For file name, allows all IS_ONECHAR characters except:
    ///\ / : &lt; &gt; |</li> <li>Input must start with \\ or drive name or \ or ..\ or .\ or /</li> <li>Spaces are
    ///allowed.</li> </ul> Examples include the following. <ul> <li>\\servername\sharename\filename.txt</li>
    ///<li>C:\temp\current work.doc</li> <li>../images/hank.jpg</li> </ul>
    IS_FILE_FULLFILEPATH             = 0x00000002,
    ///Indicates a file name. The following conditions are enforced. <ul> <li>Accepts either extension or no
    ///extension.</li> <li>Allows all IS_ONECHAR characters except: \ / : &lt; &gt; |</li> <li>Spaces are allowed.</li>
    ///</ul> Examples include the following: <ul> <li>filename.txt</li> <li>filename</li> <li>file name.txt</li> </ul>
    IS_FILE_FILENAME                 = 0x00000003,
    ///Indicates email user names. Examples include the following. <ul> <li>jeffsm</li> <li>JeffSm</li> <li>Jsmith</li>
    ///<li>JSmith</li> <li>jeffsmith</li> </ul>
    IS_EMAIL_USERNAME                = 0x00000004,
    ///Indicates a complete SMTP email address, for example, someone@example.com.
    IS_EMAIL_SMTPEMAILADDRESS        = 0x00000005,
    ///Indicates a log-in name and domain. The following conditions are enforced. <ul> <li>Allows all IS_ONECHAR
    ///characters.</li> <li>Does not allow domain or username to start or end in a non-alphanumeric character.</li>
    ///<li>Spaces are not allowed.</li> </ul> Examples include the following. <ul> <li>CHICAGO\JSMITH</li>
    ///<li>JSMITH</li> </ul>
    IS_LOGINNAME                     = 0x00000006,
    ///Indicates a combination of first, middle, and last names. Examples include the following, formatted for English
    ///(United States). <ul> <li>Mr. Jeff A. Smith, Jr.</li> <li>Jeff Smith</li> <li>Smith, Jeff</li> <li>Smith, Jeff
    ///A</li> </ul>
    IS_PERSONALNAME_FULLNAME         = 0x00000007,
    ///Indicates a honorific or title preceding a name. Examples include the following, formatted for English (United
    ///States). <ul> <li>Mr.</li> <li>Dr.</li> <li>Miss</li> <li>Sir</li> </ul>
    IS_PERSONALNAME_PREFIX           = 0x00000008,
    ///Indicates a first name or initial. Examples include the following, formatted for English (United States). <ul>
    ///<li>Jeff</li> <li>J.</li> <li>J.A.</li> </ul>
    IS_PERSONALNAME_GIVENNAME        = 0x00000009,
    ///Indicates a middle name or initial. Examples include the following. <ul> <li>Albert</li> <li>A.</li> </ul>
    IS_PERSONALNAME_MIDDLENAME       = 0x0000000a,
    ///Indicates a last name. Examples include the following, formatted for English (United States). <ul> <li>Smith</li>
    ///<li>Smith Jones</li> <li>Smith-Jones</li> </ul>
    IS_PERSONALNAME_SURNAME          = 0x0000000b,
    ///Indicates a name suffix abbreviation or Roman numerals. Examples include the following. <ul> <li>Jr.</li>
    ///<li>III</li> </ul>
    IS_PERSONALNAME_SUFFIX           = 0x0000000c,
    ///Indicates a full address, including numbers. Examples include the following, formatted for English (United
    ///States). <ul> <li>123 Main Street, Anytown, WA 98989</li> <li>PO Box 123 Anytown, WA 98989</li> </ul>
    IS_ADDRESS_FULLPOSTALADDRESS     = 0x0000000d,
    ///Indicates an alphanumeric postal code. The value is alphanumeric to support international zip codes. Examples
    ///include the following, formatted for English (United States). <ul> <li>98989</li> <li>98989-1234</li> </ul>
    IS_ADDRESS_POSTALCODE            = 0x0000000e,
    ///Indicates a house number, street number, apartment name and number, and/or postal box. Examples include the
    ///following. <ul> <li>123 Main Street</li> <li>P.O. Box 1234</li> </ul>
    IS_ADDRESS_STREET                = 0x0000000f,
    ///Indicates a full name or abbreviation of state or province. Examples include the following, formatted for English
    ///(United States). <ul> <li>WA</li> <li>Washington</li> <li>Wa</li> </ul>
    IS_ADDRESS_STATEORPROVINCE       = 0x00000010,
    ///Indicates the name or abbreviation of a city. Examples include the following, formatted for English (United
    ///States). <ul> <li>New York</li> <li>NYC</li> </ul>
    IS_ADDRESS_CITY                  = 0x00000011,
    ///Indicates the name of a country/region. Examples include the following, formatted for English (United States).
    ///<ul> <li>Italy</li> <li>Japan</li> <li>United States of America</li> </ul>
    IS_ADDRESS_COUNTRYNAME           = 0x00000012,
    ///Indicates the abbreviation of the name of a country/region. Examples include the following, formatted for English
    ///(United States). <ul> <li>USA</li> <li>U.S.A.</li> </ul>
    IS_ADDRESS_COUNTRYSHORTNAME      = 0x00000013,
    ///Indicates currency symbols and numbers. Examples include the following, formatted for English (United States).
    ///<ul> <li>$ 2,100.25</li> <li>$.35</li> <li>$1,234.50 USD</li> </ul>
    IS_CURRENCY_AMOUNTANDSYMBOL      = 0x00000014,
    ///Indicates a numeric value for currency, excluding currency symbols. For example, 2,100.25.
    IS_CURRENCY_AMOUNT               = 0x00000015,
    ///Indicates a full date, in a variety of formats. Examples include the following, formatted for English (United
    ///States). <ul> <li>07-17-2001</li> <li>7/17/01</li> <li>7/17</li> <li>Dec. 12</li> <li>July 17</li> <li>July 17,
    ///2001</li> </ul>
    IS_DATE_FULLDATE                 = 0x00000016,
    ///Indicates a numeric representation of months, constrained to 1-12. Examples include the following. <ul>
    ///<li>7</li> <li>07</li> <li>11</li> </ul>
    IS_DATE_MONTH                    = 0x00000017,
    ///Indicates a numeric representation of days, constrained to 1-31. Examples include the following. <ul> <li>1</li>
    ///<li>04</li> <li>17</li> </ul>
    IS_DATE_DAY                      = 0x00000018,
    ///Indicates a numeric representation of years. Examples include the following. <ul> <li>1988</li> <li>2004</li>
    ///<li>88</li> <li>04</li> <li>'88</li> </ul>
    IS_DATE_YEAR                     = 0x00000019,
    ///Indicates a character representation of months. Examples include the following, formatted for English (United
    ///States). <ul> <li>December</li> <li>Dec</li> <li>Dec.</li> </ul>
    IS_DATE_MONTHNAME                = 0x0000001a,
    ///Indicates a character representation of days. Examples include the following, formatted for English (United
    ///States). <ul> <li>Wednesday</li> <li>Weds</li> <li>Weds.</li> </ul>
    IS_DATE_DAYNAME                  = 0x0000001b,
    ///Indicates positive whole numbers, constrained to 0-9.
    IS_DIGITS                        = 0x0000001c,
    ///Indicates numbers, including commas, negative sign, and decimal. For United States locations, the following
    ///conditions are enforced. <ul> <li>The thousand separator is a comma.</li> <li>The decimal separator is a
    ///period.</li> <li>Negative numbers are represented with a hyphen without a space, not with parentheses.</li> </ul>
    IS_NUMBER                        = 0x0000001d,
    ///Indicates a single ANSI character, codepage 1252. For United States locations, this includes the following
    ///characters. ABCDEFGHIJKLMNOPQRSTUVWXYZabcdEfghijklmnopqrstuvwxyz0123456789!\"
    IS_ONECHAR                       = 0x0000001e,
    ///Indicates a password. <b>IS_PASSWORD</b> is not supported and may be altered or unavailable in the future. <div
    ///class="alert"><b>Note</b> <b>IS_PASSWORD</b> only indicates the password; it doesn't provide any security around
    ///the password. All passwords fields should have text services disabled to maintain password secrecy, and therefore
    ///it is not valid to have a password field with an <b>IS_PASSWORD</b> input scope.</div> <div> </div>
    IS_PASSWORD                      = 0x0000001f,
    ///Indicates a telephone number. Alphabetical input is not allowed. Examples include the following, formatted for
    ///English (United States). <ul> <li>(206) 555-0123</li> <li>555-0123</li> <li>555.0123</li> <li>206-555-0123</li>
    ///<li>1-206-555-0123x1234</li> <li>+1 (206) 555-1234</li> </ul>
    IS_TELEPHONE_FULLTELEPHONENUMBER = 0x00000020,
    ///Indicates telephone country codes. Examples include the following, formatted for English (United States). <ul>
    ///<li>+1</li> <li>+44</li> <li>001</li> <li>00 44</li> </ul>
    IS_TELEPHONE_COUNTRYCODE         = 0x00000021,
    ///Indicates telephone area codes. Examples include the following, formatted for English (United States). <ul>
    ///<li>(206)</li> <li>206</li> </ul>
    IS_TELEPHONE_AREACODE            = 0x00000022,
    ///Indicates a telephone number, excluding country or area code. Examples include the following, formatted for
    ///English (United States). <ul> <li>555-0123</li> <li>555 0123</li> <li>555.0123</li> </ul>
    IS_TELEPHONE_LOCALNUMBER         = 0x00000023,
    ///Indicates hours, minutes, seconds, and alphabetical time abbreviations. US English uses the 12 hour clock.
    ///Leading zeros are optional for hours but required for minutes and seconds. Hours are constrained to 0-24; minutes
    ///and seconds are constrained to 0-59. Examples include the following, formatted for English (United States). <ul>
    ///<li>3:20</li> <li>04:30</li> <li>11:20:55</li> <li>11:15 am</li> <li>4:30 AM</li> </ul>
    IS_TIME_FULLTIME                 = 0x00000024,
    ///Indicates a numeric representation of hours, constrained to 0-24.
    IS_TIME_HOUR                     = 0x00000025,
    ///Indicates a numeric representation of minutes or seconds, constrained to 0-59.
    IS_TIME_MINORSEC                 = 0x00000026,
    ///Indicates full-width number, used for Japanese only. Constrained to full-width numbers and Kanji numbers.
    IS_NUMBER_FULLWIDTH              = 0x00000027,
    ///Indicates half-width alphanumeric characters for East-Asian languages, constrained to half-width alphabetical
    ///characters and numbers.
    IS_ALPHANUMERIC_HALFWIDTH        = 0x00000028,
    ///Indicates full-width alphanumeric characters for East-Asian languages, constrained to full-width alphabet
    ///characters and numbers.
    IS_ALPHANUMERIC_FULLWIDTH        = 0x00000029,
    ///Indicates Chinese currency.
    IS_CURRENCY_CHINESE              = 0x0000002a,
    ///Indicates Bopomofo characters.
    IS_BOPOMOFO                      = 0x0000002b,
    ///Indicates Hiragana characters.
    IS_HIRAGANA                      = 0x0000002c,
    ///Indicates half-width Katakana characters.
    IS_KATAKANA_HALFWIDTH            = 0x0000002d,
    ///Indicates full-width Katakana characters.
    IS_KATAKANA_FULLWIDTH            = 0x0000002e,
    ///Indicates Hanja characters.
    IS_HANJA                         = 0x0000002f,
    ///Indicates half-width Hangul characters.
    IS_HANGUL_HALFWIDTH              = 0x00000030,
    ///Indicates full-width Hangul characters.
    IS_HANGUL_FULLWIDTH              = 0x00000031,
    ///<b>Starting with Windows 8:</b> Indicates a search string.
    IS_SEARCH                        = 0x00000032,
    ///<b>Starting with Windows 8:</b> Indicates a formula control, for example, a spreadsheet field.
    IS_FORMULA                       = 0x00000033,
    ///<b>Starting with Windows 10:</b> Indicates input scope is intended for search boxes where incremental results are
    ///displayed as the user types.
    IS_SEARCH_INCREMENTAL            = 0x00000034,
    ///<b>Starting with Windows 10:</b> Indicates input scope is intended for Chinese half-width characters.
    IS_CHINESE_HALFWIDTH             = 0x00000035,
    ///<b>Starting with Windows 10:</b> Indicates input scope is intended for Chinese full-width characters.
    IS_CHINESE_FULLWIDTH             = 0x00000036,
    ///<b>Starting with Windows 10:</b> Indicates input scope is intended for native script.
    IS_NATIVE_SCRIPT                 = 0x00000037,
    ///<b>Starting with Windows 10:</b> Indicates input scope is intended for Japanese names.
    IS_YOMI                          = 0x00000038,
    ///<b>Starting with Windows 10:</b> Indicates input scope is intended for working with text.
    IS_TEXT                          = 0x00000039,
    ///<b>Starting with Windows 10:</b> Indicates input scope is intended for chat strings.
    IS_CHAT                          = 0x0000003a,
    ///<b>Starting with Windows 10:</b> Indicates input scope is intended for working with a name or telephone number.
    IS_NAME_OR_PHONENUMBER           = 0x0000003b,
    ///<b>Starting with Windows 10:</b> Indicates input scope is intended for working with an email name or full email
    ///address.
    IS_EMAILNAME_OR_ADDRESS          = 0x0000003c,
    ///<b>Starting with Windows 10:</b> Indicates input scope is intended for working with private data.
    IS_PRIVATE                       = 0x0000003d,
    ///<b>Starting with Windows 10:</b> Indicates input scope is intended for working with a map location.
    IS_MAPS                          = 0x0000003e,
    ///<b>Starting with Windows 10:</b> Indicates expected input is a numeric password, or PIN.
    IS_NUMERIC_PASSWORD              = 0x0000003f,
    ///<b>Starting with Windows 10:</b> Indicates expected input is a numeric PIN.
    IS_NUMERIC_PIN                   = 0x00000040,
    ///<b>Starting with Windows 10:</b> Indicates expected input is an alphanumeric PIN.
    IS_ALPHANUMERIC_PIN              = 0x00000041,
    ///<b>Starting with Windows 10:</b> Indicates expected input is an alphanumeric PIN for lock screen.
    IS_ALPHANUMERIC_PIN_SET          = 0x00000042,
    ///<b>Starting with Windows 10:</b> Indicates expected input is a mathematical formula.
    IS_FORMULA_NUMBER                = 0x00000043,
    ///<b>Starting with Windows 10:</b> Indicates expected input does not include emoji.
    IS_CHAT_WITHOUT_EMOJI            = 0x00000044,
    ///Indicates a phrase list.
    IS_PHRASELIST                    = 0xffffffff,
    ///Indicates a regular expression.
    IS_REGULAREXPRESSION             = 0xfffffffe,
    ///Indicates an XML string that conforms to the Speech Recognition Grammar Specification (SRGS) standard.
    ///Information on SRGS can be found at http://www.w3.org/TR/speech-grammar.
    IS_SRGS                          = 0xfffffffd,
    ///Indicates a custom xml string.
    IS_XML                           = 0xfffffffc,
    ///The scope contains the IEnumString interface pointer. The Text Input Processor (TIP) can call
    ///ITfInputScope2::EnumWordList to retrieve it.
    IS_ENUMSTRING                    = 0xfffffffb,
}

// Structs


///The <b>TS_STATUS</b> structure contains document status data.
struct TS_STATUS
{
    ///Contains a set of flags that can be changed by an app at run time. For example, an app can enable a check box for
    ///the user to reset the document status. This member can contain zero, or one or more of the following values.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>TS_SD_LOADING</td> <td>The document is loading.</td>
    ///</tr> <tr> <td>TS_SD_READONLY</td> <td>The document is read-only.</td> </tr> </table>
    uint dwDynamicFlags;
    ///Contains a set of flags that cannot be changed at run time. This member can contain zero, or one or more of the
    ///following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>TS_SS_DISJOINTSEL</td> <td>The
    ///document supports multiple selections.</td> </tr> <tr> <td>TS_SS_REGIONS</td> <td>The document can contain
    ///multiple regions.</td> </tr> <tr> <td>TS_SS_TRANSITORY</td> <td>The document is expected to have a short usage
    ///cycle.</td> </tr> <tr> <td>TS_SS_NOHIDDENTEXT</td> <td>The document will never contain hidden text.</td> </tr>
    ///<tr> <td>TS_SS_TKBAUTOCORRECTENABLE</td> <td><b>Starting with Windows 8:</b> The document supports autocorrection
    ///provided by the touch keyboard.</td> </tr> <tr> <td>TS_SS_TKBPREDICTIONENABLE</td> <td><b>Starting with Windows
    ///8:</b> The document supports text suggestions provided by the touch keyboard.</td> </tr> </table>
    uint dwStaticFlags;
}

///The <b>TS_TEXTCHANGE</b> structure contains text change data.
struct TS_TEXTCHANGE
{
    ///Contains the starting character position of the change.
    int acpStart;
    ///Contains the ending character position before the text is changed.
    int acpOldEnd;
    ///Contains the ending character position after the text is changed.
    int acpNewEnd;
}

///The <b>TS_SELECTIONSTYLE</b> structure represents the style of a selection.
struct TS_SELECTIONSTYLE
{
    ///Specifies the active end of the selection. For more information, see TsActiveSelEnd.
    TsActiveSelEnd ase;
    ///Indicates if the selection is an interim character. If this value is nonzero, then the seleciton is an interim
    ///character and <b>ase</b> will be TS_AE_NONE. If this value is zero, the selection is not an interim character.
    BOOL           fInterimChar;
}

///The <b>TS_SELECTION_ACP</b> structure contains ACP-based text selection data.
struct TS_SELECTION_ACP
{
    ///Contains the start position of the selection.
    int               acpStart;
    ///Contains the end position of the selection.
    int               acpEnd;
    ///A TS_SELECTIONSTYLE structure that contains additional selection data.
    TS_SELECTIONSTYLE style;
}

///The <b>TS_SELECTION_ANCHOR</b> structure contains anchor-based text selection data.
struct TS_SELECTION_ANCHOR
{
    ///Contains the start anchor of the selection.
    IAnchor           paStart;
    ///Contains the end anchor of the selection.
    IAnchor           paEnd;
    ///A TS_SELECTIONSTYLE structure that contains additional selection data.
    TS_SELECTIONSTYLE style;
}

///The <b>TS_ATTRVAL</b> structure contains document attribute values.
struct TS_ATTRVAL
{
    ///GUID for the attribute type.
    GUID    idAttr;
    ///A unique identifier of this attribute when overlapped with other attributes. This is a feature in Microsoft
    ///Active Accessibility. In TSF, this parameter value is zero (0). Any nonzero value is ignored.
    uint    dwOverlapId;
    ///Value of the attribute.
    VARIANT varValue;
}

///The <b>TS_RUNINFO</b> structure specifies the properties of text run data.
struct TS_RUNINFO
{
    ///Specifies the number of characters in the text run.
    uint      uCount;
    ///Specifies the text run type. If this parameter is TS_RT_PLAIN, the text run is visible. If this parameter is
    ///TS_RT_HIDDEN, the text run is hidden. If this parameter is TS_RT_OPAQUE, the text run is a private data type
    ///embedded in the text by application or text service that implements the ITextStore interface.
    TsRunType type;
}

///The <b>TF_LANGBARITEMINFO</b> structure is used to hold information about a language bar item.
struct TF_LANGBARITEMINFO
{
    ///Contains the <b>CLSID</b> of the text service that owns the language bar item. This can be CLSID_NULL if the item
    ///is not provided by a text service.
    GUID       clsidService;
    ///Contains a <b>GUID</b> value that identifies the language bar item.
    GUID       guidItem;
    ///Contains a combination of one or more of the TF_LBI_STYLE_* values.
    uint       dwStyle;
    ///Specifies the sort order of the language bar item, relative to other language bar items owned by the text
    ///service. A lower number indicates that the item will be displayed prior to an item with a higher sort number.
    ///This value is only used if <b>clsidService</b> identifies a registered text service. For more information about
    ///registering a text service, see ITfInputProcessorProfiles::Register.
    uint       ulSort;
    ///Contains the description string for the item in Unicode format. The description string is displayed in the
    ///language bar options menu for menu items. This buffer can hold up to TF_LBI_DESC_MAXLEN characters.
    ushort[32] szDescription;
}

///The <b>TF_LBBALLOONINFO</b> structure contains information about a language bar balloon item.
struct TF_LBBALLOONINFO
{
    ///Contains one of the TfLBBalloonStyle values that specify the type of balloon to display.
    TfLBBalloonStyle style;
    ///Contains a <b>BSTR</b> that contains the string for the balloon. This string must be allocated using the
    ///SysAllocString function. The caller free this buffer when it is no longer required by calling SysFreeString.
    BSTR             bstrText;
}

///The <b>TF_PERSISTENT_PROPERTY_HEADER_ACP</b> structure is used to provide property header data.
struct TF_PERSISTENT_PROPERTY_HEADER_ACP
{
    ///Contains a GUID that identifies the property.
    GUID guidType;
    ///Contains the starting character position of the property.
    int  ichStart;
    ///Contains the number of characters that the property spans.
    int  cch;
    ///Contains the size, in bytes, of the property value.
    uint cb;
    ///Contains a <b>DWORD</b> value defined by the property owner.
    uint dwPrivate;
    ///Contains the CLSID of the property owner.
    GUID clsidTIP;
}

///The <b>TF_LANGUAGEPROFILE</b> structure contains information about a language profile.
struct TF_LANGUAGEPROFILE
{
    ///Specifies the class identifier of the text service within the language profile.
    GUID   clsid;
    ///Specifies the language identifier of the profile.
    ushort langid;
    ///Specifies the identifier of the category that the text service belongs to.
    GUID   catid;
    ///A Boolean value, when <b>TRUE</b>, indicates that the language is activated.
    BOOL   fActive;
    ///Specifies the identifier of the language profile.
    GUID   guidProfile;
}

///The <b>TF_SELECTIONSTYLE</b> structure represents the style of a selection.
struct TF_SELECTIONSTYLE
{
    ///Specifies the active end of the selection. For more information, see TfActiveSelEnd.
    TfActiveSelEnd ase;
    ///Indicates if the selection is an interim character. If this value is nonzero, then the seleciton is an interim
    ///character and <b>ase</b> will be TF_AE_NONE. If this value is zero, the selection is not an interim character.
    BOOL           fInterimChar;
}

///The <b>TF_SELECTION</b> structure contains text selection data.
struct TF_SELECTION
{
    ///Pointer to an ITfRange object that specifies the selected text.
    ITfRange          range;
    ///A TF_SELECTIONSTYLE structure that contains selection data.
    TF_SELECTIONSTYLE style;
}

///The <b>TF_PROPERTYVAL</b> structure contains property value data. This structure is used with the
///IEnumTfPropertyValue::Next method.
struct TF_PROPERTYVAL
{
    ///A <b>GUID</b> that identifies the property type. This can be a custom identifier or one of the predefined
    ///property identifiers.
    GUID    guidId;
    ///A <b>VARIANT</b> that contains the value of the property specified by <b>guidId</b>. The user must know the type
    ///and format of this data.
    VARIANT varValue;
}

///The <b>TF_HALTCOND</b> structure is used to contain conditions of a range shift.
struct TF_HALTCOND
{
    ///Pointer to an ITfRange object that halts the shift. If the range shift encounters this range during the shift,
    ///the shift halts. This member can be <b>NULL</b>.
    ITfRange pHaltRange;
    ///Contains one of the TfAnchor values that specifies which anchor of <b>pHaltRange</b> the anchor will get shifted
    ///to if <b>pHaltRange</b> is encountered during the range shift. This member is ignored if <b>pHaltRange</b> is
    ///<b>NULL</b>.
    TfAnchor aHaltPos;
    ///Contains a set of flags that modify the behavior of the range shift. This can be zero or the following value.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>TF_HF_OBJECT</td> <td>The range shift halts if an
    ///embedded object is encountered.</td> </tr> </table>
    uint     dwFlags;
}

///This structure contains data for the input processor profile.
struct TF_INPUTPROCESSORPROFILE
{
    ///The type of this profile. This is one of these values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td>TF_PROFILETYPE_INPUTPROCESSOR</td> <td>This is a text service.</td> </tr> <tr>
    ///<td>TF_PROFILETYPE_KEYBOARDLAYOUT</td> <td>This is a keyboard layout.</td> </tr> </table>
    uint      dwProfileType;
    ///The language id for this profile.
    ushort    langid;
    ///The CLSID of the text service. This is CLSID_NULL if this profile is a keyboard layout.
    GUID      clsid;
    ///The guidProfile of the text services. This is GUID_NULL if this profile is a keyboard layout.
    GUID      guidProfile;
    ///The category of this text service. This category is GUID_TFCAT_TIP_KEYBOARD, GUID_TFCAT_TIP_SPEECH,
    ///GUID_TFCAT_TIP_HANDWRITING or something in GUID_TFCAT_CATEGORY_OF_TIP.
    GUID      catid;
    ///The keyboard layout handle of the substitute for this text service. This can be <b>NULL</b> if the text service
    ///does not have a substitute or this profile is a keyboard layout.
    ptrdiff_t hklSubstitute;
    ///The flag to specify the capability of text service. This is the combination of the following flags: <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td>TF_IPP_CAPS_DISABLEONTRANSITORY</td> <td>This text service profile
    ///is disabled on transitory context.</td> </tr> <tr> <td>TF_IPP_CAPS_SECUREMODESUPPORT</td> <td>This text service
    ///supports the secure mode. This is categorized in GUID_TFCAT_TIPCAP_SECUREMODE.</td> </tr> <tr>
    ///<td>TF_IPP_CAPS_UIELEMENTENABLED</td> <td>This text service supports the UIElement. This is categorized in
    ///GUID_TFCAT_TIPCAP_UIELEMENTENABLED.</td> </tr> <tr> <td>TF_IPP_CAPS_COMLESSSUPPORT</td> <td>This text service can
    ///be activated without COM. This is categorized in GUID_TFCAT_TIPCAP_COMLESS.</td> </tr> <tr>
    ///<td>TF_IPP_CAPS_WOW16SUPPORT</td> <td>This text service can be activated on 16bit task. This is categorized in
    ///GUID_TFCAT_TIPCAP_WOW16.</td> </tr> <tr> <td>TF_IPP_CAPS_IMMERSIVESUPPORT</td> <td><b>Starting with Windows
    ///8:</b> This text service has been tested to run properly in a Windows Store app.</td> </tr> <tr>
    ///<td>TF_IPP_CAPS_SYSTRAYSUPPORT</td> <td><b>Starting with Windows 8:</b> This text service supports inclusion in
    ///the System Tray. This is used for text services that do not set the TF_IPP_CAPS_IMMERSIVESUPPORT flag but are
    ///still compatible with the System Tray.</td> </tr> </table>
    uint      dwCaps;
    ///The keyboard layout handle. This is <b>NULL</b> if this profile is a text service.
    ptrdiff_t hkl;
    uint      dwFlags;
}

///The <b>TF_PRESERVEDKEY</b> structure represents a preserved key.
struct TF_PRESERVEDKEY
{
    ///Virtual key code of the keyboard shortcut.
    uint uVKey;
    ///Modifies the preserved key. This can be zero or a combination of one or more of the TF_MOD_* constants.
    uint uModifiers;
}

///The <b>TF_DA_COLOR</b> structure contains color data used in the display attributes for a range of text.
struct TF_DA_COLOR
{
    ///Specifies the color type as defined in the TF_DA_COLORTYPE enumeration.
    TF_DA_COLORTYPE type;
    union
    {
        int  nIndex;
        uint cr;
    }
}

///The <b>TF_DISPLAYATTRIBUTE</b> structure contains display attribute data for rendering text.
struct TF_DISPLAYATTRIBUTE
{
    ///Contains a TF_DA_COLOR structure that defines the text foreground color.
    TF_DA_COLOR     crText;
    ///Contains a <b>TF_DA_COLOR</b> structure that defines the text background color.
    TF_DA_COLOR     crBk;
    ///Contains a TF_DA_LINESTYLE enumeration value that defines the underline style.
    TF_DA_LINESTYLE lsStyle;
    ///A BOOL value that specifies if the underline should be bold or normal weight. If this value is nonzero, the
    ///underline should be bold. If this value is zero, the underline should be normal.
    BOOL            fBoldLine;
    ///Contains a <b>TF_DA_COLOR</b> structure that defines the color of the underline.
    TF_DA_COLOR     crLine;
    ///Contains a TF_DA_ATTR_INFO value that defines text conversion display attribute data.
    TF_DA_ATTR_INFO bAttr;
}

///The <b>TF_LMLATTELEMENT</b> structure contains information about a lattice element. A lattice element is used in
///speech recognition. This structure is used with the IEnumTfLatticeElements::Next method.
struct TF_LMLATTELEMENT
{
    ///Contains the starting offset, in 100-nanosecond units, of the element relative to the start of the phrase.
    uint dwFrameStart;
    ///Contains the length, in 100-nanosecond units, of the element.
    uint dwFrameLen;
    ///Not currently used.
    uint dwFlags;
    union
    {
        int iCost;
    }
    ///Contains the display text for the element. If the spoken word is "two", the display text will be "2". The caller
    ///must free this string using SysFreeString when it is no longer required.
    BSTR bstrText;
}

// Functions

///The <b>InitLocalMsCtfMonitor</b> function initializes TextServicesFramework on the current desktop and prepares the
///floating language bar, if necessary. This function must be called on the app's desktop.
///Params:
///    dwFlags = This is a combination of the following flags: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="ILMCM_CHECKLAYOUTANDTIPENABLED"></a><a id="ilmcm_checklayoutandtipenabled"></a><dl>
///              <dt><b>ILMCM_CHECKLAYOUTANDTIPENABLED</b></dt> </dl> </td> <td width="60%"> <b>InitLocalMsCtfMonitor</b>
///              forcefully checks the available keyboard layout or text service. If there is no secondary keyboard layout or text
///              services, it does not initialize TextServicesFramework on the desktop. </td> </tr> <tr> <td width="40%"><a
///              id="ILMCM_LANGUAGEBAROFF"></a><a id="ilmcm_languagebaroff"></a><dl> <dt><b>ILMCM_LANGUAGEBAROFF</b></dt> </dl>
///              </td> <td width="60%"> <b>Starting with Windows 8:</b> A local language bar is not started for the current
///              desktop. </td> </tr> </table>
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>S_OK</td> <td>The function was successful.</td> </tr>
///    <tr> <td>E_FAIL</td> <td>An unspecified error occurred.</td> </tr> </table>
///    
@DllImport("MsCtfMonitor")
HRESULT InitLocalMsCtfMonitor(uint dwFlags);

///The UninitLocalMsCtfMonitor function uninitializes TextServicesFramework on the current desktop.
@DllImport("MsCtfMonitor")
HRESULT UninitLocalMsCtfMonitor();


// Interfaces

///The <b>ITfMSAAControl</b> interface is used by Microsoft Active Accessibility to add or remove a document from TSF
///control, to avoid unnecessary overhead in TSF. This interface is not recommended for use by other applications. The
///interface ID is IID_ITfMSAAControl.
@GUID("B5F8FB3B-393F-4F7C-84CB-504924C2705A")
interface ITfMSAAControl : IUnknown
{
    ///Used by MSAA to request TSF support of an MSAA client.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT SystemEnableMSAA();
    ///Used by MSAA to halt TSF support of an MSAA client.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT SystemDisableMSAA();
}

///The <b>ITextStoreACP</b> interface is implemented by the application and is used by the TSF manager to manipulate
///text streams or text stores in TSF. An application can obtain an instance of this interface with a call to the
///ITfDocumentMgr::CreateContext method. The interface ID is IID_ITextStoreACP. This interface exposes text stores
///through an application character position (ACP) format. Applications that use an anchor-based format should use
///ITextStoreAnchor.
@GUID("28888FE3-C2A0-483A-A3EA-8CB1CE51FF3D")
interface ITextStoreACP : IUnknown
{
    ///The <b>ITextStoreACP::AdviseSink</b> method installs a new advise sink from the ITextStoreACPSink interface or
    ///modifies an existing advise sink. The sink interface is specified by the <i>punk</i> parameter.
    ///Params:
    ///    riid = Specifies the sink interface.
    ///    punk = Pointer to the sink interface. Cannot be <b>NULL</b>.
    ///    dwMask = Specifies the events that notify the advise sink. For more information about possible parameter values, see
    ///             TS_AS_* Constants.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>CONNECT_E_ADVISELIMIT</b></dt> </dl> </td> <td width="60%"> A sink
    ///    interface pointer could not be obtained. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> The specified sink interface is unsupported. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The specified sink object could not be
    ///    obtained. </td> </tr> </table>
    ///    
    HRESULT AdviseSink(const(GUID)* riid, IUnknown punk, uint dwMask);
    ///The <b>ITextStoreACP::UnadviseSink</b> method is called by an application to indicate that it no longer requires
    ///notifications from the TSF manager. The TSF manager will release the sink interface and stop notifications.
    ///Params:
    ///    punk = Pointer to a sink object. Cannot be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>CONNECT_E_NOCONNECTION</b></dt> </dl> </td> <td width="60%"> There is no
    ///    active sink object. </td> </tr> </table>
    ///    
    HRESULT UnadviseSink(IUnknown punk);
    ///The <b>ITextStoreACP::RequestLock</b> method is called by the TSF manager to provide a document lock in order to
    ///modify the document. This method calls the ITextStoreACPSink::OnLockGranted method to create the document lock.
    ///Params:
    ///    dwLockFlags = Specifies the type of lock requested. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///                  width="40%"><a id="TS_LF_READ"></a><a id="ts_lf_read"></a><dl> <dt><b>TS_LF_READ</b></dt> </dl> </td> <td
    ///                  width="60%"> The document has a read-only lock and cannot be modified. </td> </tr> <tr> <td width="40%"><a
    ///                  id="TS_LF_READWRITE"></a><a id="ts_lf_readwrite"></a><dl> <dt><b>TS_LF_READWRITE</b></dt> </dl> </td> <td
    ///                  width="60%"> The document has a read/write lock and can be modified. </td> </tr> <tr> <td width="40%"><a
    ///                  id="TS_LF_SYNC"></a><a id="ts_lf_sync"></a><dl> <dt><b>TS_LF_SYNC</b></dt> </dl> </td> <td width="60%"> The
    ///                  document has a synchronous-lock if this flag is combined with other flags. </td> </tr> </table>
    ///    phrSession = If the lock request is synchronous, receives an HRESULT value from the ITextStoreAnchorSink::OnLockGranted
    ///                 method that specifies the result of the lock request. If the lock request is asynchronous and the result is
    ///                 TS_S_ASYNC, the document receives an asynchronous lock. If the lock request is asynchronous and the result is
    ///                 TS_E_SYNCHRONOUS, the document cannot be locked synchronously.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT RequestLock(uint dwLockFlags, int* phrSession);
    ///The <b>ITextStoreACP::GetStatus</b> method obtains the document status. The document status is returned through
    ///the TS_STATUS structure.
    ///Params:
    ///    pdcs = Receives the <b>TS_STATUS</b> structure that contains the document status. Cannot be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The pointer to the
    ///    TS_STATUS parameter is invalid. </td> </tr> </table>
    ///    
    HRESULT GetStatus(TS_STATUS* pdcs);
    ///The <b>ITextStoreACP::QueryInsert</b> method determines whether the specified start and end character positions
    ///are valid. Use this method to adjust an edit to a document before executing the edit. The method must not return
    ///values outside the range of the document.
    ///Params:
    ///    acpTestStart = Starting application character position for inserted text.
    ///    acpTestEnd = Ending application character position for the inserted text. This value is equal to <i>acpTextStart</i> if
    ///                 the text is inserted at a point instead of replacing selected text.
    ///    cch = Length of replacement text.
    ///    pacpResultStart = Returns the new starting application character position of the inserted text. If this parameter is
    ///                      <b>NULL</b>, then text cannot be inserted at the specified position. This value cannot be outside the
    ///                      document range.
    ///    pacpResultEnd = Returns the new ending application character position of the inserted text. If this parameter is <b>NULL</b>,
    ///                    then <i>pacpResultStart</i> is set to <b>NULL</b> and text cannot be inserted at the specified position. This
    ///                    value cannot be outside the document range.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>acpTestStart</i> or <i>acpTestEnd</i> parameters are invalid. </td> </tr> </table>
    ///    
    HRESULT QueryInsert(int acpTestStart, int acpTestEnd, uint cch, int* pacpResultStart, int* pacpResultEnd);
    ///The <b>ITextStoreACP::GetSelection</b> method returns the character position of a text selection in a document.
    ///This method supports multiple text selections. The caller must have a read-only lock on the document before
    ///calling this method.
    ///Params:
    ///    ulIndex = Specifies the text selections that start the process. If the TF_DEFAULT_SELECTION constant is specified for
    ///              this parameter, the input selection starts the process.
    ///    ulCount = Specifies the maximum number of selections to return.
    ///    pSelection = Receives the style, start, and end character positions of the selected text. These values are put into the
    ///                 TS_SELECTION_ACP structure.
    ///    pcFetched = Receives the number of <i>pSelection</i> structures returned.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller does not have
    ///    a read-only lock on the document. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOSELECTION</b></dt>
    ///    </dl> </td> <td width="60%"> The document has no selection. </td> </tr> </table>
    ///    
    HRESULT GetSelection(uint ulIndex, uint ulCount, char* pSelection, uint* pcFetched);
    ///The <b>ITextStoreACP::SetSelection</b> method selects text within the document. The application must have a
    ///read/write lock on the document before calling this method.
    ///Params:
    ///    ulCount = Specifies the number of text selections in <i>pSelection</i>.
    ///    pSelection = Specifies the style, start, and end character positions of the text selected through the TS_SELECTION_ACP
    ///                 structure. When the start and end character positions are equal, the method places a caret at that character
    ///                 position. There can be only one caret at a time in the document.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_INVALIDPOS</b></dt> </dl> </td> <td width="60%"> The
    ///    character positions specified are beyond the text in the document. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller does not have a read/write lock. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetSelection(uint ulCount, char* pSelection);
    ///The <b>ITextStoreACP::GetText</b> method returns information about text at a specified character position. This
    ///method returns the visible and hidden text and indicates if embedded data is attached to the text.
    ///Params:
    ///    acpStart = Specifies the starting character position.
    ///    acpEnd = Specifies the ending character position. If this parameter is 1, then return all text in the text store.
    ///    pchPlain = Specifies the buffer to receive the plain text data. If this parameter is <b>NULL</b>, then the
    ///               <i>cchPlainReq</i> parameter must be 0.
    ///    cchPlainReq = Specifies the number of plain text characters passed to the method.
    ///    pcchPlainRet = Receives the number of characters copied into the plain text buffer. This parameter cannot be <b>NULL</b>.
    ///                   Use a parameter if values are not required.
    ///    prgRunInfo = Receives an array of TS_RUNINFO structures. May be <b>NULL</b> only if <i>cRunInfoReq</i> = 0.
    ///    cRunInfoReq = Specifies the size, in characters, of the text run buffer.
    ///    pcRunInfoRet = Receives the number of <b>TS_RUNINFO</b> structures written to the text run buffer. This parameter cannot be
    ///                   <b>NULL</b>.
    ///    pacpNext = Receives the character position of the next unread character. Cannot be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_INVALIDPOS</b></dt> </dl> </td> <td width="60%"> The <i>acpStart</i>
    ///    or <i>acpEnd</i> parameters are outside of the document text. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller does not have a read-only lock on the
    ///    document. </td> </tr> </table>
    ///    
    HRESULT GetText(int acpStart, int acpEnd, char* pchPlain, uint cchPlainReq, uint* pcchPlainRet, 
                    char* prgRunInfo, uint cRunInfoReq, uint* pcRunInfoRet, int* pacpNext);
    ///The <b>ITextStoreACP::SetText</b> method sets the text selection to the supplied character positions.
    ///Params:
    ///    dwFlags = If set to the value of TS_ST_CORRECTION, the text is a transform (correction) of existing content, and any
    ///              special text markup information (metadata) is retained, such as .wav file data or a language identifier. The
    ///              client defines the type of markup information to be retained.
    ///    acpStart = Specifies the starting character position of the text to replace.
    ///    acpEnd = Specifies the ending character position of the text to replace. This parameter is ignored if the value is 1.
    ///    pchText = Specifies the pointer to the replacement text. The text string does not have to be <b>NULL</b> terminated,
    ///              because the text character count is specified in the <i>cch</i> parameter.
    ///    cch = Specifies the number of characters in the replacement text.
    ///    pChange = Pointer to a TS_TEXTCHANGE structure with the following data. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///              </tr> <tr> <td width="40%"><a id="acpStart"></a><a id="acpstart"></a><a id="ACPSTART"></a><dl>
    ///              <dt><b>acpStart</b></dt> </dl> </td> <td width="60%"> The starting application character position before the
    ///              text is inserted into the document. </td> </tr> <tr> <td width="40%"><a id="acpOldEnd"></a><a
    ///              id="acpoldend"></a><a id="ACPOLDEND"></a><dl> <dt><b>acpOldEnd</b></dt> </dl> </td> <td width="60%"> The
    ///              ending position before the text is inserted into the document. This value is the same as <i>acpStart</i> for
    ///              an insertion point. If this value is different from <i>acpStart</i>, then text was selected prior to the text
    ///              insertion. </td> </tr> <tr> <td width="40%"><a id="acpNewEnd"></a><a id="acpnewend"></a><a
    ///              id="ACPNEWEND"></a><dl> <dt><b>acpNewEnd</b></dt> </dl> </td> <td width="60%"> The ending position after the
    ///              text insertion occurred. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TS_E_INVALIDPOS</b></dt> </dl> </td> <td width="60%"> The <i>acpStart</i>
    ///    or <i>acpEnd</i> parameter is outside of the document text. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller does not have a read/write lock. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_READONLY</b></dt> </dl> </td> <td width="60%"> The document is
    ///    read-only. Content cannot be modified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_REGION</b></dt>
    ///    </dl> </td> <td width="60%"> An attempt was made to modify text across a region boundary. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetText(uint dwFlags, int acpStart, int acpEnd, const(wchar)* pchText, uint cch, 
                    TS_TEXTCHANGE* pChange);
    ///The <b>ITextStoreACP::GetFormattedText</b> method returns formatted text data about a specified text string. The
    ///caller must have a read/write lock on the document before calling this method.
    ///Params:
    ///    acpStart = Specifies the starting character position of the text to get in the document.
    ///    acpEnd = Specifies the ending character position of the text to get in the document. This parameter is ignored if the
    ///             value is 1.
    ///    ppDataObject = Receives the pointer to the <b>IDataObject</b> object that contains the formatted text.
    HRESULT GetFormattedText(int acpStart, int acpEnd, IDataObject* ppDataObject);
    ///Gets an embedded document.
    ///Params:
    ///    acpPos = Contains the character position, within the document, from where the object is obtained.
    ///    rguidService = Contains a GUID value that defines the requested format of the obtained object. This can be one of the
    ///                   following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///                   id="GUID_TS_SERVICE_DATAOBJECT"></a><a id="guid_ts_service_dataobject"></a><dl>
    ///                   <dt><b>GUID_TS_SERVICE_DATAOBJECT</b></dt> </dl> </td> <td width="60%"> The object should be obtained as an
    ///                   IDataObject object. </td> </tr> <tr> <td width="40%"><a id="GUID_TS_SERVICE_ACCESSIBLE"></a><a
    ///                   id="guid_ts_service_accessible"></a><dl> <dt><b>GUID_TS_SERVICE_ACCESSIBLE</b></dt> </dl> </td> <td
    ///                   width="60%"> The object should be obtained as an Accessible object. </td> </tr> <tr> <td width="40%"><a
    ///                   id="GUID_TS_SERVICE_ACTIVEX"></a><a id="guid_ts_service_activex"></a><dl>
    ///                   <dt><b>GUID_TS_SERVICE_ACTIVEX</b></dt> </dl> </td> <td width="60%"> The object should be obtained as an
    ///                   ActiveX object. </td> </tr> </table>
    ///    riid = Specifies the interface type requested.
    ///    ppunk = Pointer to an <b>IUnknown</b> pointer that receives the requested interface.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%">
    ///    The application does not support embedded objects. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_INVALIDPOS</b></dt> </dl> </td> <td width="60%"> <i>acpPos</i> is not within the document. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> The requested
    ///    interface type is unsupported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td>
    ///    <td width="60%"> The caller does not have a read-only lock. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_NOOBJECT</b></dt> </dl> </td> <td width="60%"> There is no embedded object at <i>acpPos</i>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOSERVICE</b></dt> </dl> </td> <td width="60%"> The
    ///    service type specified in <i>rguidService</i> is unsupported. </td> </tr> </table>
    ///    
    HRESULT GetEmbedded(int acpPos, const(GUID)* rguidService, const(GUID)* riid, IUnknown* ppunk);
    ///Gets a value indicating whether the specified object can be inserted into the document.
    ///Params:
    ///    pguidService = Pointer to the object type. Can be <b>NULL</b>.
    ///    pFormatEtc = Pointer to the FORMATETC structure that contains format data of the object. This parameter cannot be
    ///                 <b>NULL</b> if the <i>pguidService</i> parameter is <b>NULL</b>.
    ///    pfInsertable = Receives <b>TRUE</b> if the object type can be inserted into the document or <b>FALSE</b> if the object type
    ///                   cannot be inserted into the document.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pFormatEtc</i>
    ///    parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT QueryInsertEmbedded(const(GUID)* pguidService, const(FORMATETC)* pFormatEtc, int* pfInsertable);
    ///Inserts an embedded object at the specified character.
    ///Params:
    ///    dwFlags = Must be TS_IE_CORRECTION.
    ///    acpStart = Contains the starting character position where the object is inserted.
    ///    acpEnd = Contains the ending character position where the object is inserted.
    ///    pDataObject = Pointer to an IDataObject interface that contains data about the object inserted.
    ///    pChange = Pointer to a TS_TEXTCHANGE structure that receives data about the modified text.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%">
    ///    The application does not support embedded objects. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_FORMAT</b></dt> </dl> </td> <td width="60%"> The application does not support the data type
    ///    contained in <i>pDataObject</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_INVALIDPOS</b></dt> </dl>
    ///    </td> <td width="60%"> <i>acpStart</i> and/or <i>acpEnd</i> are not within the document. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller does not have a
    ///    read/write lock. </td> </tr> </table>
    ///    
    HRESULT InsertEmbedded(uint dwFlags, int acpStart, int acpEnd, IDataObject pDataObject, TS_TEXTCHANGE* pChange);
    ///The <b>ITextStoreACP::InsertTextAtSelection</b> method inserts text at the insertion point or selection. A caller
    ///must have a read/write lock on the document before inserting text.
    ///Params:
    ///    dwFlags = Specifies whether the <i>pacpStart</i> and <i>pacpEnd</i> parameters and the TS_TEXTCHANGE structure contain
    ///              the results of the text insertion. The TF_IAS_NOQUERY and TF_IAS_QUERYONLY flags cannot be combined. <table>
    ///              <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl>
    ///              </td> <td width="60%"> Text insertion will occur, and the <i>pacpStart</i> and <i>pacpEnd</i> parameters will
    ///              contain the results of the text insertion. The <b>TS_TEXTCHANGE</b> structure must be filled with this flag.
    ///              </td> </tr> <tr> <td width="40%"><a id="TF_IAS_NOQUERY"></a><a id="tf_ias_noquery"></a><dl>
    ///              <dt><b>TF_IAS_NOQUERY</b></dt> </dl> </td> <td width="60%"> Text is inserted, the values of the
    ///              <i>pacpStart</i> and <i>pacpEnd</i> parameters can be <b>NULL</b>, and the <b>TS_TEXTCHANGE</b> structure
    ///              must be filled. Use this flag to view the results of the text insertion. </td> </tr> <tr> <td width="40%"><a
    ///              id="TF_IAS_QUERYONLY"></a><a id="tf_ias_queryonly"></a><dl> <dt><b>TF_IAS_QUERYONLY</b></dt> </dl> </td> <td
    ///              width="60%"> Text is not inserted, and the values for the <i>pacpStart</i> and <i>pacpEnd</i> parameters
    ///              contain the results of the text insertion. The values of these parameters depend on how the application
    ///              implements text insertion into a document. For more information, see the Remarks section. Use this flag to
    ///              view the results of the text insertion without actually inserting the text. It is not required that you fill
    ///              the <b>TS_TEXTCHANGE</b> structure if you use this flag. </td> </tr> </table>
    ///    pchText = Pointer to the string to insert in the document. The string can be <b>NULL</b> terminated.
    ///    cch = Specifies the text length.
    ///    pacpStart = Pointer to the starting application character position where the text insertion occurs.
    ///    pacpEnd = Pointer to the ending application character position where the text insertion occurs. This parameter value is
    ///              the same as the value of the <i>pacpStart</i> parameter for an insertion point.
    ///    pChange = Pointer to a <b>TS_TEXTCHANGE</b> structure with the following members. <table> <tr> <th>Value</th>
    ///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="acpStart"></a><a id="acpstart"></a><a
    ///              id="ACPSTART"></a><dl> <dt><b>acpStart</b></dt> </dl> </td> <td width="60%"> The starting application
    ///              character position before the text is inserted into the document. </td> </tr> <tr> <td width="40%"><a
    ///              id="acpOldEnd"></a><a id="acpoldend"></a><a id="ACPOLDEND"></a><dl> <dt><b>acpOldEnd</b></dt> </dl> </td> <td
    ///              width="60%"> The ending application character position before the text is inserted into the document. This
    ///              value is the same as <b>acpStart</b> for an insertion point. If this value is different from <b>acpStart</b>,
    ///              then text was selected prior to the text insertion. </td> </tr> <tr> <td width="40%"><a id="acpNewEnd"></a><a
    ///              id="acpnewend"></a><a id="ACPNEWEND"></a><dl> <dt><b>acpNewEnd</b></dt> </dl> </td> <td width="60%"> The end
    ///              position after the text insertion occurred. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller does not have
    ///    a lock on the document. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The <i>pchText</i> parameter is invalid. </td> </tr> </table>
    ///    
    HRESULT InsertTextAtSelection(uint dwFlags, const(wchar)* pchText, uint cch, int* pacpStart, int* pacpEnd, 
                                  TS_TEXTCHANGE* pChange);
    ///The <b>ITextStoreACP::InsertEmbeddedAtSelection</b> method inserts an IDataObject object at the insertion point
    ///or selection. The client that calls this method must have a read/write lock before inserting an
    ///<b>IDataObject</b> object into the document.
    ///Params:
    ///    dwFlags = Specifies whether the <i>pacpStart</i> and <i>pacpEnd</i> parameters and the TS_TEXTCHANGE structure will
    ///              contain the results of the object insertion. The TF_IAS_NOQUERY and TF_IAS_QUERYONLY flags cannot be
    ///              combined. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl>
    ///              <dt><b>0</b></dt> </dl> </td> <td width="60%"> Text insertion will occur, and the <i>pacpStart</i> and
    ///              <i>pacpEnd</i> parameters will contain the results of the text insertion. The <b>TS_TEXTCHANGE</b> structure
    ///              must be filled with this flag. </td> </tr> <tr> <td width="40%"><a id="TF_IAS_NOQUERY"></a><a
    ///              id="tf_ias_noquery"></a><dl> <dt><b>TF_IAS_NOQUERY</b></dt> </dl> </td> <td width="60%"> Text is inserted,
    ///              the values of the <i>pacpStart</i> and <i>pacpEnd</i> parameters can be <b>NULL</b>, and the
    ///              <b>TS_TEXTCHANGE</b> structure must be filled. Use this flag if the results of the text insertion are not
    ///              required. </td> </tr> <tr> <td width="40%"><a id="TF_IAS_QUERYONLY"></a><a id="tf_ias_queryonly"></a><dl>
    ///              <dt><b>TF_IAS_QUERYONLY</b></dt> </dl> </td> <td width="60%"> Text is not inserted, and the values for the
    ///              <i>pacpStart</i> and <i>pacpEnd</i> parameter contain the results of the text insertion. The values of these
    ///              parameters depend on how the application implements text insertion into a document. For more information, see
    ///              the Remarks section. Use this flag to view the results of the text insertion without actually inserting the
    ///              text, for example, to predict the results of collapsing or otherwise adjusting a selection. It is not
    ///              required that you fill the <b>TS_TEXTCHANGE</b> structure with this flag. </td> </tr> </table>
    ///    pDataObject = Pointer to the <b>IDataObject</b> object to be inserted.
    ///    pacpStart = Pointer to the starting application character position where the object insertion will occur.
    ///    pacpEnd = Pointer to the ending application character position where the object insertion will occur. This parameter
    ///              value will be the same as the value of the <i>pacpStart</i> parameter for an insertion point.
    ///    pChange = Pointer to a <b>TS_TEXTCHANGE</b> structure with the following members. <table> <tr> <th>Value</th>
    ///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="acpStart"></a><a id="acpstart"></a><a
    ///              id="ACPSTART"></a><dl> <dt><b>acpStart</b></dt> </dl> </td> <td width="60%"> The starting application
    ///              character position before the object is inserted into the document. </td> </tr> <tr> <td width="40%"><a
    ///              id="acpOldEnd"></a><a id="acpoldend"></a><a id="ACPOLDEND"></a><dl> <dt><b>acpOldEnd</b></dt> </dl> </td> <td
    ///              width="60%"> The ending application character position before the object is inserted into the document. This
    ///              value is the same as <b>acpStart</b> for an insertion point. If this value is different from <b>acpStart</b>,
    ///              then text was selected prior to the object insertion. </td> </tr> <tr> <td width="40%"><a
    ///              id="acpNewEnd"></a><a id="acpnewend"></a><a id="ACPNEWEND"></a><dl> <dt><b>acpNewEnd</b></dt> </dl> </td> <td
    ///              width="60%"> The ending application character position after the object insertion took place. </td> </tr>
    ///              </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pchText</i>
    ///    parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td
    ///    width="60%"> The caller does not have a lock on the document. </td> </tr> </table>
    ///    
    HRESULT InsertEmbeddedAtSelection(uint dwFlags, IDataObject pDataObject, int* pacpStart, int* pacpEnd, 
                                      TS_TEXTCHANGE* pChange);
    ///Get the attributes that are supported in the document.
    ///Params:
    ///    dwFlags = Specifies whether a subsequent call to the ITextStoreAnchor::RetrieveRequestedAttrs method will contain the
    ///              supported attributes. If the TS_ATTR_FIND_WANT_VALUE flag is specified, the default attribute values will be
    ///              those in the TS_ATTRVAL structure after the subsequent call to
    ///              <b>ITextStoreAnchor::RetrieveRequestedAttrs</b>. If any other flag is specified for this parameter, the
    ///              method only verifies that the attribute is supported and that the <b>varValue</b> member of the
    ///              <b>TS_ATTRVAL</b> structure is set to VT_EMPTY.
    ///    cFilterAttrs = Specifies the number of supported attributes to obtain.
    ///    paFilterAttrs = Pointer to the TS_ATTRID data type that specifies the attribute to verify. The method returns only the
    ///                    attributes specified by <b>TS_ATTRID</b>, even though other attributes can be supported.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method
    ///    was unable to allocate sufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT RequestSupportedAttrs(uint dwFlags, uint cFilterAttrs, char* paFilterAttrs);
    ///Gets text attributes at the specified character position.
    ///Params:
    ///    acpPos = Specifies the application character position in the document.
    ///    cFilterAttrs = Specifies the number of attributes to obtain.
    ///    paFilterAttrs = Pointer to the TS_ATTRID data type that specifies the attribute to verify.
    ///    dwFlags = Must be zero.
    ///Returns:
    ///    This method has no return values.
    ///    
    HRESULT RequestAttrsAtPosition(int acpPos, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags);
    ///Gets text attributes transitioning at the specified character position.
    ///Params:
    ///    acpPos = Specifies the application character position in the document.
    ///    cFilterAttrs = Specifies the number of attributes to obtain.
    ///    paFilterAttrs = Pointer to the TS_ATTRID data type that specifies the attribute to verify.
    ///    dwFlags = Specifies attributes for the call to the ITextStoreACP::RetrieveRequestedAttrs method. If this parameter is
    ///              not set, the method returns the attributes that start at the specified position. Other possible values for
    ///              this parameter are the following. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///              id="TS_ATTR_FIND_WANT_END"></a><a id="ts_attr_find_want_end"></a><dl> <dt><b>TS_ATTR_FIND_WANT_END</b></dt>
    ///              </dl> </td> <td width="60%"> Obtains the attributes that end at the specified application character position.
    ///              </td> </tr> <tr> <td width="40%"><a id="TS_ATTR_FIND_WANT_VALUE"></a><a id="ts_attr_find_want_value"></a><dl>
    ///              <dt><b>TS_ATTR_FIND_WANT_VALUE</b></dt> </dl> </td> <td width="60%"> Obtains the value of the attribute in
    ///              addition to the attribute. The attribute value is put into the <b>varValue</b> member of the TS_ATTRVAL
    ///              structure during the <b>ITextStoreACP::RetrieveRequestedAttrs</b> method call. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT RequestAttrsTransitioningAtPosition(int acpPos, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags);
    ///The <b>ITextStoreACP::FindNextAttrTransition</b> method determines the character position where a transition
    ///occurs in an attribute value. The specified attribute to check is application-dependent.
    ///Params:
    ///    acpStart = Specifies the character position to start the search for an attribute transition.
    ///    acpHalt = Specifies the character position to end the search for an attribute transition.
    ///    cFilterAttrs = Specifies the number of attributes to check.
    ///    paFilterAttrs = Pointer to the TS_ATTRID data type that specifies the attribute to check.
    ///    dwFlags = Specifies the direction to search for an attribute transition. By default, the method searches forward.
    ///              <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TS_ATTR_FIND_BACKWARDS"></a><a
    ///              id="ts_attr_find_backwards"></a><dl> <dt><b>TS_ATTR_FIND_BACKWARDS</b></dt> </dl> </td> <td width="60%"> The
    ///              method searches backward. </td> </tr> <tr> <td width="40%"><a id="TS_ATTR_FIND_WANT_OFFSET"></a><a
    ///              id="ts_attr_find_want_offset"></a><dl> <dt><b>TS_ATTR_FIND_WANT_OFFSET</b></dt> </dl> </td> <td width="60%">
    ///              The <i>plFoundOffset</i> parameter receives the character offset of the attribute transition from
    ///              <i>acpStart</i>. </td> </tr> </table>
    ///    pacpNext = Receives the next character position to check for an attribute transition.
    ///    pfFound = Receives a Boolean value of <b>TRUE</b> if an attribute transition was found, otherwise <b>FALSE</b> is
    ///              returned.
    ///    plFoundOffset = Receives the character position of the attribute transition (not ACP positions). If TS_ATTR_FIND_WANT_OFFSET
    ///                    flag is set in <i>dwFlags</i>, receives the character offset of the attribute transition from
    ///                    <i>acpStart</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TS_E_INVALIDPOS</b></dt> </dl> </td> <td width="60%"> The character
    ///    positions specified are beyond the text in the document. </td> </tr> </table>
    ///    
    HRESULT FindNextAttrTransition(int acpStart, int acpHalt, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags, 
                                   int* pacpNext, int* pfFound, int* plFoundOffset);
    ///Gets the attributes returned by a call to an attribute request method.
    ///Params:
    ///    ulCount = Specifies the number of supported attributes to obtain.
    ///    paAttrVals = Pointer to the TS_ATTRVAL structure that receives the supported attributes. The members of this structure
    ///                 depend upon the <i>dwFlags</i> parameter of the calling method.
    ///    pcFetched = Receives the number of supported attributes.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT RetrieveRequestedAttrs(uint ulCount, char* paAttrVals, uint* pcFetched);
    ///The <b>ITextStoreACP::GetEndACP</b> method returns the number of characters in a document.
    ///Params:
    ///    pacp = Receives the character position of the last character in the document plus one.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The application has not
    ///    implemented this method. This is usually an indication that calculating the end position requires excessive
    ///    resources. If the end position is necessary, you can use ITextStoreACP::GetText to calculate it, though this
    ///    can also be a memory-intensive operation, paging in arbitrarily large amounts of memory from disk. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller does not
    ///    have a read-only lock. </td> </tr> </table>
    ///    
    HRESULT GetEndACP(int* pacp);
    ///The <b>ITextStoreACP::GetActiveView</b> method returns a TsViewCookie data type that specifies the current active
    ///view.
    ///Params:
    ///    pvcView = Receives the <b>TsViewCookie</b> data type that specifies the current active view.
    ///Returns:
    ///    This method has no return values.
    ///    
    HRESULT GetActiveView(uint* pvcView);
    ///The <b>ITextStoreACP::GetACPFromPoint</b> method converts a point in screen coordinates to an application
    ///character position.
    ///Params:
    ///    vcView = Specifies the context view.
    ///    ptScreen = Pointer to the <b>POINT</b> structure with the screen coordinates of the point.
    ///    dwFlags = Specifies the character position to return based upon the screen coordinates of the point relative to a
    ///              character bounding box. By default, the character position returned is the character bounding box containing
    ///              the screen coordinates of the point. If the point is outside a character bounding box, the method returns
    ///              <b>NULL</b> or TF_E_INVALIDPOINT. Other bit flags for this parameter are as follows. The bit flags can be
    ///              combined. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///              id="GXFPF_ROUND_NEAREST"></a><a id="gxfpf_round_nearest"></a><dl> <dt><b>GXFPF_ROUND_NEAREST</b></dt> </dl>
    ///              </td> <td width="60%"> If the screen coordinates of the point are contained in a character bounding box, the
    ///              character position returned is the bounding edge closest to the screen coordinates of the point. </td> </tr>
    ///              <tr> <td width="40%"><a id="GXFPF_NEAREST"></a><a id="gxfpf_nearest"></a><dl> <dt><b>GXFPF_NEAREST</b></dt>
    ///              </dl> </td> <td width="60%"> If the screen coordinates of the point are not contained in a character bounding
    ///              box, the closest character position is returned. </td> </tr> </table>
    ///    pacp = Receives the character position that corresponds to the screen coordinates of the point.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TS_E_INVALIDPOINT</b></dt> </dl> </td> <td width="60%"> The <i>ptScreen</i>
    ///    parameter is not within the bounding box of any character. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_NOLAYOUT</b></dt> </dl> </td> <td width="60%"> The application has not calculated a text layout.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetACPFromPoint(uint vcView, const(POINT)* ptScreen, uint dwFlags, int* pacp);
    ///The <b>ITextStoreACP::GetTextExt</b> method returns the bounding box, in screen coordinates, of the text at a
    ///specified character position. The caller must have a read-only lock on the document before calling this method.
    ///Params:
    ///    vcView = Specifies the context view.
    ///    acpStart = Specifies the starting character position of the text to get in the document.
    ///    acpEnd = Specifies the ending character position of the text to get in the document.
    ///    prc = Receives the bounding box in screen coordinates of the text at the specified character positions.
    ///    pfClipped = Receives a Boolean value that specifies if the text in the bounding box has been clipped. If this parameter
    ///                is <b>TRUE</b>, the bounding box contains clipped text and does not include the entire requested text range.
    ///                The bounding box is clipped because the requested range is not visible.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TS_E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The specified start
    ///    and end character positions are equal. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_INVALIDPOS</b></dt>
    ///    </dl> </td> <td width="60%"> The range specified by the <i>acpStart</i> and <i>acpEnd</i> parameters extends
    ///    past the beginning or end of the document. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_NOLAYOUT</b></dt> </dl> </td> <td width="60%"> The application has not calculated a text layout.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller
    ///    does not have a read-only lock on the document. </td> </tr> </table>
    ///    
    HRESULT GetTextExt(uint vcView, int acpStart, int acpEnd, RECT* prc, int* pfClipped);
    ///The <b>ITextStoreACP::GetScreenExt</b> method returns the bounding box screen coordinates of the display surface
    ///where the text stream is rendered.
    ///Params:
    ///    vcView = Specifies the context view.
    ///    prc = Receives the bounding box screen coordinates of the display surface of the document.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The specified
    ///    <i>vcView</i> parameter is invalid. </td> </tr> </table>
    ///    
    HRESULT GetScreenExt(uint vcView, RECT* prc);
    ///The <b>ITextStoreACP::GetWnd</b> method returns the handle to a window that corresponds to the current document.
    ///Params:
    ///    vcView = Specifies the TsViewCookie data type that corresponds to the current document.
    ///    phwnd = Receives a pointer to the handle of the window that corresponds to the current document. This parameter can
    ///            be <b>NULL</b> if the document does not have the corresponding handle to the window.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <b>TsViewCookie</b>
    ///    data type is invalid. </td> </tr> </table>
    ///    
    HRESULT GetWnd(uint vcView, HWND* phwnd);
}

///The <b>ITextStoreACP2</b> interface is implemented by the application and is used by the TSF manager to manipulate
///text streams or text stores in TSF. An application can obtain an instance of this interface with a call to the
///CreateContext method. The interface ID is <b>IID_ITextStoreACP2</b>. This interface exposes text stores through an
///application character position (ACP) format. Applications that use an anchor-based format should use
///ITextStoreAnchor.
@GUID("F86AD89F-5FE4-4B8D-BB9F-EF3797A84F1F")
interface ITextStoreACP2 : IUnknown
{
    ///Installs a new advise sink from the ITextStoreACPSink interface or modifies an existing advise sink. The sink
    ///interface is specified by the <i>punk</i> parameter.
    ///Params:
    ///    riid = Specifies the sink interface.
    ///    punk = Pointer to the sink interface. Cannot be <b>NULL</b>.
    ///    dwMask = Specifies the events that notify the advise sink. For more information about possible parameter values, see
    ///             TS_AS_* Constants.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>CONNECT_E_ADVISELIMIT</b></dt> </dl> </td> <td width="60%"> A sink
    ///    interface pointer could not be obtained. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> The specified sink interface is unsupported. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The specified sink object could not be
    ///    obtained. </td> </tr> </table>
    ///    
    HRESULT AdviseSink(const(GUID)* riid, IUnknown punk, uint dwMask);
    ///Called by an application to indicate that it no longer requires notifications from the TSF manager. The TSF
    ///manager will release the sink interface and stop notifications.
    ///Params:
    ///    punk = Pointer to a sink object. Cannot be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>CONNECT_E_NOCONNECTION</b></dt> </dl> </td> <td width="60%"> There is no
    ///    active sink object. </td> </tr> </table>
    ///    
    HRESULT UnadviseSink(IUnknown punk);
    ///Called by the TSF manager to provide a document lock in order to modify the document. This method calls the
    ///OnLockGranted method to create the document lock.
    ///Params:
    ///    dwLockFlags = Specifies the type of lock requested. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///                  width="40%"><a id="TS_LF_READ"></a><a id="ts_lf_read"></a><dl> <dt><b>TS_LF_READ</b></dt> </dl> </td> <td
    ///                  width="60%"> The document has a read-only lock and cannot be modified. </td> </tr> <tr> <td width="40%"><a
    ///                  id="TS_LF_READWRITE"></a><a id="ts_lf_readwrite"></a><dl> <dt><b>TS_LF_READWRITE</b></dt> </dl> </td> <td
    ///                  width="60%"> The document has a read/write lock and can be modified. </td> </tr> <tr> <td width="40%"><a
    ///                  id="TS_LF_SYNC"></a><a id="ts_lf_sync"></a><dl> <dt><b>TS_LF_SYNC</b></dt> </dl> </td> <td width="60%"> The
    ///                  document has a synchronous-lock if this flag is combined with other flags. </td> </tr> </table>
    ///    phrSession = If the lock request is synchronous, receives an HRESULT value from the OnLockGranted method that specifies
    ///                 the result of the lock request. If the lock request is asynchronous and the result is TS_S_ASYNC, the
    ///                 document receives an asynchronous lock. If the lock request is asynchronous and the result is
    ///                 TS_E_SYNCHRONOUS, the document can't be locked synchronously.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT RequestLock(uint dwLockFlags, int* phrSession);
    ///Gets the document status. The document status is returned through the TS_STATUS structure.
    ///Params:
    ///    pdcs = Receives the TS_STATUS structure that contains the document status. Cannot be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The pointer to the
    ///    TS_STATUS parameter is invalid. </td> </tr> </table>
    ///    
    HRESULT GetStatus(TS_STATUS* pdcs);
    ///Determines whether the specified start and end character positions are valid. Use this method to adjust an edit
    ///to a document before executing the edit. The method must not return values outside the range of the document.
    ///Params:
    ///    acpTestStart = Starting application character position for inserted text.
    ///    acpTestEnd = Ending application character position for the inserted text. This value is equal to <i>acpTextStart</i> if
    ///                 the text is inserted at a point instead of replacing selected text.
    ///    cch = Length of replacement text.
    ///    pacpResultStart = Returns the new starting application character position of the inserted text. If this parameter is
    ///                      <b>NULL</b>, then text cannot be inserted at the specified position. This value cannot be outside the
    ///                      document range.
    ///    pacpResultEnd = Returns the new ending application character position of the inserted text. If this parameter is <b>NULL</b>,
    ///                    then <i>pacpResultStart</i> is set to <b>NULL</b> and text cannot be inserted at the specified position. This
    ///                    value cannot be outside the document range.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>acpTestStart</i> or <i>acpTestEnd</i> parameters are invalid. </td> </tr> </table>
    ///    
    HRESULT QueryInsert(int acpTestStart, int acpTestEnd, uint cch, int* pacpResultStart, int* pacpResultEnd);
    ///Gets the character position of a text selection in a document. This method supports multiple text selections. The
    ///caller must have a read-only lock on the document before calling this method.
    ///Params:
    ///    ulIndex = Specifies the text selections that start the process. If the TF_DEFAULT_SELECTION constant is specified for
    ///              this parameter, the input selection starts the process.
    ///    ulCount = Specifies the maximum number of selections to return.
    ///    pSelection = Receives the style, start, and end character positions of the selected text. These values are put into the
    ///                 TS_SELECTION_ACP structure.
    ///    pcFetched = Receives the number of <i>pSelection</i> structures returned.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller does not have
    ///    a read-only lock on the document. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOSELECTION</b></dt>
    ///    </dl> </td> <td width="60%"> The document has no selection. </td> </tr> </table>
    ///    
    HRESULT GetSelection(uint ulIndex, uint ulCount, char* pSelection, uint* pcFetched);
    ///Selects text within the document. The application must have a read/write lock on the document before calling this
    ///method.
    ///Params:
    ///    ulCount = Specifies the number of text selections in <i>pSelection</i>.
    ///    pSelection = Specifies the style, start, and end character positions of the text selected through the TS_SELECTION_ACP
    ///                 structure. When the start and end character positions are equal, the method places a caret at that character
    ///                 position. There can be only one caret at a time in the document.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_INVALIDPOS</b></dt> </dl> </td> <td width="60%"> The
    ///    character positions specified are beyond the text in the document. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller does not have a read/write lock. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetSelection(uint ulCount, char* pSelection);
    ///Gets info about text at a specified character position. This method returns the visible and hidden text and
    ///indicates if embedded data is attached to the text.
    ///Params:
    ///    acpStart = Specifies the starting character position.
    ///    acpEnd = Specifies the ending character position. If this parameter is 1, then return all text in the text store.
    ///    pchPlain = Specifies the buffer to receive the plain text data. If this parameter is <b>NULL</b>, then the
    ///               <i>cchPlainReq</i> parameter must be 0.
    ///    cchPlainReq = Specifies the number of plain text characters passed to the method.
    ///    pcchPlainRet = Receives the number of characters copied into the plain text buffer. This parameter cannot be <b>NULL</b>.
    ///                   Use a parameter if values are not required.
    ///    prgRunInfo = Receives an array of TS_RUNINFO structures. May be <b>NULL</b> only if <i>cRunInfoReq</i> = 0.
    ///    cRunInfoReq = Specifies the size, in characters, of the text run buffer.
    ///    pcRunInfoRet = Receives the number of <b>TS_RUNINFO</b> structures written to the text run buffer. This parameter cannot be
    ///                   <b>NULL</b>.
    ///    pacpNext = Receives the character position of the next unread character. Cannot be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_INVALIDPOS</b></dt> </dl> </td> <td width="60%"> The <i>acpStart</i>
    ///    or <i>acpEnd</i> parameters are outside of the document text. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller does not have a read-only lock on the
    ///    document. </td> </tr> </table>
    ///    
    HRESULT GetText(int acpStart, int acpEnd, char* pchPlain, uint cchPlainReq, uint* pcchPlainRet, 
                    char* prgRunInfo, uint cRunInfoReq, uint* pcRunInfoRet, int* pacpNext);
    ///Sets the text selection to the supplied character positions.
    ///Params:
    ///    dwFlags = If set to the value of <b>TS_ST_CORRECTION</b>, the text is a transform (correction) of existing content, and
    ///              any special text markup information (metadata) is retained, such as .wav file data or a language identifier.
    ///              The client defines the type of markup information to be retained.
    ///    acpStart = Specifies the starting character position of the text to replace.
    ///    acpEnd = Specifies the ending character position of the text to replace. This parameter is ignored if the value is 1.
    ///    pchText = Specifies the pointer to the replacement text. The text string does not have to be <b>NULL</b> terminated,
    ///              because the text character count is specified in the <i>cch</i> parameter.
    ///    cch = Specifies the number of characters in the replacement text.
    ///    pChange = Pointer to a TS_TEXTCHANGE structure with the following data. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///              </tr> <tr> <td width="40%"><a id="acpStart"></a><a id="acpstart"></a><a id="ACPSTART"></a><dl>
    ///              <dt><b>acpStart</b></dt> </dl> </td> <td width="60%"> The starting application character position before the
    ///              text is inserted into the document. </td> </tr> <tr> <td width="40%"><a id="acpOldEnd"></a><a
    ///              id="acpoldend"></a><a id="ACPOLDEND"></a><dl> <dt><b>acpOldEnd</b></dt> </dl> </td> <td width="60%"> The
    ///              ending position before the text is inserted into the document. This value is the same as <i>acpStart</i> for
    ///              an insertion point. If this value is different from <i>acpStart</i>, then text was selected prior to the text
    ///              insertion. </td> </tr> <tr> <td width="40%"><a id="acpNewEnd"></a><a id="acpnewend"></a><a
    ///              id="ACPNEWEND"></a><dl> <dt><b>acpNewEnd</b></dt> </dl> </td> <td width="60%"> The ending position after the
    ///              text insertion occurred. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TS_E_INVALIDPOS</b></dt> </dl> </td> <td width="60%"> The <i>acpStart</i>
    ///    or <i>acpEnd</i> parameter is outside of the document text. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller does not have a read/write lock. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_READONLY</b></dt> </dl> </td> <td width="60%"> The document is
    ///    read-only. Content cannot be modified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_REGION</b></dt>
    ///    </dl> </td> <td width="60%"> An attempt was made to modify text across a region boundary. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetText(uint dwFlags, int acpStart, int acpEnd, const(wchar)* pchText, uint cch, 
                    TS_TEXTCHANGE* pChange);
    ///Gets formatted text data about a specified text string. The caller must have a read/write lock on the document
    ///before calling this method.
    ///Params:
    ///    acpStart = Specifies the starting character position of the text to get in the document.
    ///    acpEnd = Specifies the ending character position of the text to get in the document. This parameter is ignored if the
    ///             value is 1.
    ///    ppDataObject = Receives the pointer to the IDataObject object that contains the formatted text.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller does not have
    ///    a read/write lock on the document. </td> </tr> </table>
    ///    
    HRESULT GetFormattedText(int acpStart, int acpEnd, IDataObject* ppDataObject);
    ///Gets an embedded document.
    ///Params:
    ///    acpPos = Contains the character position, within the document, from where the object is obtained.
    ///    rguidService = Contains a GUID value that defines the requested format of the obtained object. This can be one of the
    ///                   following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///                   id="GUID_TS_SERVICE_DATAOBJECT"></a><a id="guid_ts_service_dataobject"></a><dl>
    ///                   <dt><b>GUID_TS_SERVICE_DATAOBJECT</b></dt> </dl> </td> <td width="60%"> The object should be obtained as an
    ///                   IDataObject object. </td> </tr> <tr> <td width="40%"><a id="GUID_TS_SERVICE_ACCESSIBLE"></a><a
    ///                   id="guid_ts_service_accessible"></a><dl> <dt><b>GUID_TS_SERVICE_ACCESSIBLE</b></dt> </dl> </td> <td
    ///                   width="60%"> The object should be obtained as an Accessible object. </td> </tr> <tr> <td width="40%"><a
    ///                   id="GUID_TS_SERVICE_ACTIVEX"></a><a id="guid_ts_service_activex"></a><dl>
    ///                   <dt><b>GUID_TS_SERVICE_ACTIVEX</b></dt> </dl> </td> <td width="60%"> The object should be obtained as an
    ///                   ActiveX object. </td> </tr> </table>
    ///    riid = Specifies the interface type requested.
    ///    ppunk = Pointer to an <b>IUnknown</b> pointer that receives the requested interface.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%">
    ///    The application does not support embedded objects. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_INVALIDPOS</b></dt> </dl> </td> <td width="60%"> <i>acpPos</i> is not within the document. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> The requested
    ///    interface type is unsupported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td>
    ///    <td width="60%"> The caller does not have a read-only lock. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_NOOBJECT</b></dt> </dl> </td> <td width="60%"> There is no embedded object at <i>acpPos</i>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOSERVICE</b></dt> </dl> </td> <td width="60%"> The
    ///    service type specified in <i>rguidService</i> is unsupported. </td> </tr> </table>
    ///    
    HRESULT GetEmbedded(int acpPos, const(GUID)* rguidService, const(GUID)* riid, IUnknown* ppunk);
    ///Gets a value indicating whether the specified object can be inserted into the document.
    ///Params:
    ///    pguidService = Pointer to the object type. Can be <b>NULL</b>.
    ///    pFormatEtc = Pointer to the FORMATETC structure that contains format data of the object. This parameter cannot be
    ///                 <b>NULL</b> if the <i>pguidService</i> parameter is <b>NULL</b>.
    ///    pfInsertable = Receives <b>TRUE</b> if the object type can be inserted into the document or <b>FALSE</b> if the object type
    ///                   can't be inserted into the document.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pFormatEtc</i>
    ///    parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT QueryInsertEmbedded(const(GUID)* pguidService, const(FORMATETC)* pFormatEtc, int* pfInsertable);
    ///Inserts an embedded object at the specified character.
    ///Params:
    ///    dwFlags = Must be TS_IE_CORRECTION.
    ///    acpStart = Contains the starting character position where the object is inserted.
    ///    acpEnd = Contains the ending character position where the object is inserted.
    ///    pDataObject = Pointer to an IDataObject interface that contains data about the object inserted.
    ///    pChange = Pointer to a TS_TEXTCHANGE structure that receives data about the modified text.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%">
    ///    The application does not support embedded objects. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_FORMAT</b></dt> </dl> </td> <td width="60%"> The application does not support the data type
    ///    contained in <i>pDataObject</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_INVALIDPOS</b></dt> </dl>
    ///    </td> <td width="60%"> <i>acpStart</i> and/or <i>acpEnd</i> are not within the document. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller does not have a
    ///    read/write lock. </td> </tr> </table>
    ///    
    HRESULT InsertEmbedded(uint dwFlags, int acpStart, int acpEnd, IDataObject pDataObject, TS_TEXTCHANGE* pChange);
    ///Inserts text at the insertion point or selection. A caller must have a read/write lock on the document before
    ///inserting text.
    ///Params:
    ///    dwFlags = 
    ///    pchText = 
    ///    cch = 
    ///    pacpStart = 
    ///    pacpEnd = 
    ///    pChange = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT InsertTextAtSelection(uint dwFlags, const(wchar)* pchText, uint cch, int* pacpStart, int* pacpEnd, 
                                  TS_TEXTCHANGE* pChange);
    ///Inserts an IDataObject at the insertion point or selection. The client that calls this method must have a
    ///read/write lock before inserting an IDataObject object into the document.
    ///Params:
    ///    dwFlags = Specifies whether the <i>pacpStart</i> and <i>pacpEnd</i> parameters and the TS_TEXTCHANGE structure will
    ///              contain the results of the object insertion. The TF_IAS_NOQUERY and TF_IAS_QUERYONLY flags cannot be
    ///              combined. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl>
    ///              <dt><b>0</b></dt> </dl> </td> <td width="60%"> Text insertion will occur, and the <i>pacpStart</i> and
    ///              <i>pacpEnd</i> parameters will contain the results of the text insertion. The TS_TEXTCHANGE structure must be
    ///              filled with this flag. </td> </tr> <tr> <td width="40%"><a id="TF_IAS_NOQUERY"></a><a
    ///              id="tf_ias_noquery"></a><dl> <dt><b>TF_IAS_NOQUERY</b></dt> </dl> </td> <td width="60%"> Text is inserted,
    ///              the values of the <i>pacpStart</i> and <i>pacpEnd</i> parameters can be <b>NULL</b>, and the TS_TEXTCHANGE
    ///              structure must be filled. Use this flag if the results of the text insertion are not required. </td> </tr>
    ///              <tr> <td width="40%"><a id="TF_IAS_QUERYONLY"></a><a id="tf_ias_queryonly"></a><dl>
    ///              <dt><b>TF_IAS_QUERYONLY</b></dt> </dl> </td> <td width="60%"> Text is not inserted, and the values for the
    ///              <i>pacpStart</i> and <i>pacpEnd</i> parameter contain the results of the text insertion. The values of these
    ///              parameters depend on how the application implements text insertion into a document. For more information, see
    ///              the Remarks section. Use this flag to view the results of the text insertion without actually inserting the
    ///              text, for example, to predict the results of collapsing or otherwise adjusting a selection. It is not
    ///              required that you fill the TS_TEXTCHANGE structure with this flag. </td> </tr> </table>
    ///    pDataObject = Pointer to the IDataObject object to be inserted.
    ///    pacpStart = Pointer to the starting application character position where the object insertion will occur.
    ///    pacpEnd = Pointer to the ending application character position where the object insertion will occur. This parameter
    ///              value will be the same as the value of the <i>pacpStart</i> parameter for an insertion point.
    ///    pChange = Pointer to a TS_TEXTCHANGE structure with the following members. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///              </tr> <tr> <td width="40%"><a id="acpStart"></a><a id="acpstart"></a><a id="ACPSTART"></a><dl>
    ///              <dt><b>acpStart</b></dt> </dl> </td> <td width="60%"> The starting application character position before the
    ///              object is inserted into the document. </td> </tr> <tr> <td width="40%"><a id="acpOldEnd"></a><a
    ///              id="acpoldend"></a><a id="ACPOLDEND"></a><dl> <dt><b>acpOldEnd</b></dt> </dl> </td> <td width="60%"> The
    ///              ending application character position before the object is inserted into the document. This value is the same
    ///              as <b>acpStart</b> for an insertion point. If this value is different from <b>acpStart</b>, then text was
    ///              selected prior to the object insertion. </td> </tr> <tr> <td width="40%"><a id="acpNewEnd"></a><a
    ///              id="acpnewend"></a><a id="ACPNEWEND"></a><dl> <dt><b>acpNewEnd</b></dt> </dl> </td> <td width="60%"> The
    ///              ending application character position after the object insertion took place. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pchText</i>
    ///    parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td
    ///    width="60%"> The caller does not have a lock on the document. </td> </tr> </table>
    ///    
    HRESULT InsertEmbeddedAtSelection(uint dwFlags, IDataObject pDataObject, int* pacpStart, int* pacpEnd, 
                                      TS_TEXTCHANGE* pChange);
    ///Get the attributes that are supported in the document.
    ///Params:
    ///    dwFlags = Specifies whether a subsequent call to the RetrieveRequestedAttrs method will contain the supported
    ///              attributes. If the <b>TS_ATTR_FIND_WANT_VALUE</b> flag is specified, the default attribute values will be
    ///              those in the TS_ATTRVAL structure after the subsequent call to <b>RetrieveRequestedAttrs</b>. If any other
    ///              flag is specified for this parameter, the method only verifies that the attribute is supported and that the
    ///              <b>varValue</b> member of the <b>TS_ATTRVAL</b> structure is set to <b>VT_EMPTY</b>.
    ///    cFilterAttrs = Specifies the number of supported attributes to obtain.
    ///    paFilterAttrs = Pointer to the TS_ATTRID data type that specifies the attribute to verify. The method returns only the
    ///                    attributes specified by <b>TS_ATTRID</b>, even though other attributes can be supported.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method
    ///    was unable to allocate sufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT RequestSupportedAttrs(uint dwFlags, uint cFilterAttrs, char* paFilterAttrs);
    ///Gets text attributes at the specified character position.
    ///Params:
    ///    acpPos = Specifies the application character position in the document.
    ///    cFilterAttrs = Specifies the number of attributes to obtain.
    ///    paFilterAttrs = Pointer to the TS_ATTRID data type that specifies the attribute to verify.
    ///    dwFlags = Specifies attributes for the call to the RetrieveRequestedAttrs method. If this parameter is not set, the
    ///              method returns the attributes that start at the specified position. Other possible values for this parameter
    ///              are the following. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///              id="TS_ATTR_FIND_WANT_END"></a><a id="ts_attr_find_want_end"></a><dl> <dt><b>TS_ATTR_FIND_WANT_END</b></dt>
    ///              </dl> </td> <td width="60%"> Obtains the attributes that end at the specified application character position.
    ///              </td> </tr> <tr> <td width="40%"><a id="TS_ATTR_FIND_WANT_VALUE"></a><a id="ts_attr_find_want_value"></a><dl>
    ///              <dt><b>TS_ATTR_FIND_WANT_VALUE</b></dt> </dl> </td> <td width="60%"> Obtains the value of the attribute in
    ///              addition to the attribute. The attribute value is put into the <b>varValue</b> member of the TS_ATTRVAL
    ///              structure during the RetrieveRequestedAttrs method call. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT RequestAttrsAtPosition(int acpPos, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags);
    ///Gets text attributes transitioning at the specified character position.
    ///Params:
    ///    acpPos = Specifies the application character position in the document.
    ///    cFilterAttrs = Specifies the number of attributes to obtain.
    ///    paFilterAttrs = Pointer to the TS_ATTRID data type that specifies the attribute to verify.
    ///    dwFlags = Specifies attributes for the call to the RetrieveRequestedAttrs method. If this parameter is not set, the
    ///              method returns the attributes that start at the specified position. Other possible values for this parameter
    ///              are the following. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///              id="TS_ATTR_FIND_WANT_END"></a><a id="ts_attr_find_want_end"></a><dl> <dt><b>TS_ATTR_FIND_WANT_END</b></dt>
    ///              </dl> </td> <td width="60%"> Obtains the attributes that end at the specified application character position.
    ///              </td> </tr> <tr> <td width="40%"><a id="TS_ATTR_FIND_WANT_VALUE"></a><a id="ts_attr_find_want_value"></a><dl>
    ///              <dt><b>TS_ATTR_FIND_WANT_VALUE</b></dt> </dl> </td> <td width="60%"> Obtains the value of the attribute in
    ///              addition to the attribute. The attribute value is put into the <b>varValue</b> member of the TS_ATTRVAL
    ///              structure during the RetrieveRequestedAttrs method call. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT RequestAttrsTransitioningAtPosition(int acpPos, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags);
    ///Determines the character position where a transition occurs in an attribute value. The specified attribute to
    ///check is application-dependent.
    ///Params:
    ///    acpStart = Specifies the character position to start the search for an attribute transition.
    ///    acpHalt = Specifies the character position to end the search for an attribute transition.
    ///    cFilterAttrs = Specifies the number of attributes to check.
    ///    paFilterAttrs = Pointer to the TS_ATTRID data type that specifies the attribute to check.
    ///    dwFlags = Specifies the direction to search for an attribute transition. By default, the method searches forward.
    ///              <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TS_ATTR_FIND_BACKWARDS"></a><a
    ///              id="ts_attr_find_backwards"></a><dl> <dt><b>TS_ATTR_FIND_BACKWARDS</b></dt> </dl> </td> <td width="60%"> The
    ///              method searches backward. </td> </tr> <tr> <td width="40%"><a id="TS_ATTR_FIND_WANT_OFFSET"></a><a
    ///              id="ts_attr_find_want_offset"></a><dl> <dt><b>TS_ATTR_FIND_WANT_OFFSET</b></dt> </dl> </td> <td width="60%">
    ///              The <i>plFoundOffset</i> parameter receives the character offset of the attribute transition from
    ///              <i>acpStart</i>. </td> </tr> </table>
    ///    pacpNext = Receives the next character position to check for an attribute transition.
    ///    pfFound = Receives a Boolean value of <b>TRUE</b> if an attribute transition was found, otherwise <b>FALSE</b> is
    ///              returned.
    ///    plFoundOffset = Receives the character position of the attribute transition (not ACP positions). If TS_ATTR_FIND_WANT_OFFSET
    ///                    flag is set in <i>dwFlags</i>, receives the character offset of the attribute transition from
    ///                    <i>acpStart</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TS_E_INVALIDPOS</b></dt> </dl> </td> <td width="60%"> The character
    ///    positions specified are beyond the text in the document. </td> </tr> </table>
    ///    
    HRESULT FindNextAttrTransition(int acpStart, int acpHalt, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags, 
                                   int* pacpNext, int* pfFound, int* plFoundOffset);
    ///Gets the attributes returned by a call to an attribute request method.
    ///Params:
    ///    ulCount = Specifies the number of supported attributes to obtain.
    ///    paAttrVals = Pointer to the TS_ATTRVAL structure that receives the supported attributes. The members of this structure
    ///                 depend upon the <i>dwFlags</i> parameter of the calling method.
    ///    pcFetched = Receives the number of supported attributes.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT RetrieveRequestedAttrs(uint ulCount, char* paAttrVals, uint* pcFetched);
    ///Gets the number of characters in a document.
    ///Params:
    ///    pacp = Receives the character position of the last character in the document plus one.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The application has not
    ///    implemented this method. This is usually an indication that calculating the end position requires excessive
    ///    resources. If the end position is necessary, you can use GetText to calculate it, though this can also be a
    ///    memory-intensive operation, paging in arbitrarily large amounts of memory from disk. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller does not have a
    ///    read-only lock. </td> </tr> </table>
    ///    
    HRESULT GetEndACP(int* pacp);
    ///Gets a TsViewCookie that represents the current active view.
    ///Params:
    ///    pvcView = Receives the <b>TsViewCookie</b> data type that specifies the current active view.
    ///Returns:
    ///    This method has no return values.
    ///    
    HRESULT GetActiveView(uint* pvcView);
    ///Converts a point in screen coordinates to an application character position.
    ///Params:
    ///    vcView = Specifies the context view.
    ///    ptScreen = Pointer to the <b>POINT</b> structure with the screen coordinates of the point.
    ///    dwFlags = Specifies the character position to return based upon the screen coordinates of the point relative to a
    ///              character bounding box. By default, the character position returned is the character bounding box containing
    ///              the screen coordinates of the point. If the point is outside a character bounding box, the method returns
    ///              <b>NULL</b> or TF_E_INVALIDPOINT. Other bit flags for this parameter are as follows. The bit flags can be
    ///              combined. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///              id="GXFPF_ROUND_NEAREST"></a><a id="gxfpf_round_nearest"></a><dl> <dt><b>GXFPF_ROUND_NEAREST</b></dt> </dl>
    ///              </td> <td width="60%"> If the screen coordinates of the point are contained in a character bounding box, the
    ///              character position returned is the bounding edge closest to the screen coordinates of the point. </td> </tr>
    ///              <tr> <td width="40%"><a id="GXFPF_NEAREST"></a><a id="gxfpf_nearest"></a><dl> <dt><b>GXFPF_NEAREST</b></dt>
    ///              </dl> </td> <td width="60%"> If the screen coordinates of the point are not contained in a character bounding
    ///              box, the closest character position is returned. </td> </tr> </table>
    ///    pacp = Receives the character position that corresponds to the screen coordinates of the point.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TS_E_INVALIDPOINT</b></dt> </dl> </td> <td width="60%"> The <i>ptScreen</i>
    ///    parameter is not within the bounding box of any character. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_NOLAYOUT</b></dt> </dl> </td> <td width="60%"> The application has not calculated a text layout.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetACPFromPoint(uint vcView, const(POINT)* ptScreen, uint dwFlags, int* pacp);
    ///Gets the bounding box, in screen coordinates, of the text at a specified character position. The caller must have
    ///a read-only lock on the document before calling this method.
    ///Params:
    ///    vcView = Specifies the context view.
    ///    acpStart = Specifies the starting character position of the text to get in the document.
    ///    acpEnd = Specifies the ending character position of the text to get in the document.
    ///    prc = Receives the bounding box in screen coordinates of the text at the specified character positions.
    ///    pfClipped = Receives a Boolean value that specifies if the text in the bounding box has been clipped. If this parameter
    ///                is <b>TRUE</b>, the bounding box contains clipped text and does not include the entire requested text range.
    ///                The bounding box is clipped because the requested range is not visible.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TS_E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The specified start
    ///    and end character positions are equal. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_INVALIDPOS</b></dt>
    ///    </dl> </td> <td width="60%"> The range specified by the <i>acpStart</i> and <i>acpEnd</i> parameters extends
    ///    past the beginning or end of the document. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_NOLAYOUT</b></dt> </dl> </td> <td width="60%"> The application has not calculated a text layout.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller
    ///    does not have a read-only lock on the document. </td> </tr> </table>
    ///    
    HRESULT GetTextExt(uint vcView, int acpStart, int acpEnd, RECT* prc, int* pfClipped);
    ///Gets the bounding box screen coordinates of the display surface where the text stream is rendered.
    ///Params:
    ///    vcView = Specifies the context view.
    ///    prc = Receives the bounding box screen coordinates of the display surface of the document.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The specified
    ///    <i>vcView</i> parameter is invalid. </td> </tr> </table>
    ///    
    HRESULT GetScreenExt(uint vcView, RECT* prc);
}

///The <b>ITextStoreACPSink</b> interface is implemented by the TSF manager and is used by an ACP-based application to
///notify the manager when certain events occur. The manager installs this advise sink by calling
///ITextStoreACP::AdviseSink.
@GUID("22D44C94-A419-4542-A272-AE26093ECECF")
interface ITextStoreACPSink : IUnknown
{
    ///Called when the text of a document changes.
    ///Params:
    ///    dwFlags = Contains a set of flags that specify additional information about the text change. This can be one or more of
    ///              the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///              id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%"> The text has changed. </td> </tr> <tr> <td
    ///              width="40%"><a id="TS_ST_CORRECTION"></a><a id="ts_st_correction"></a><dl> <dt><b>TS_ST_CORRECTION</b></dt>
    ///              </dl> </td> <td width="60%"> The text is a transform (correction) of existing content, and any special text
    ///              markup information (metadata) is retained, such as .wav file data or a language identifier. This flag is used
    ///              for applications that need to preserve data associated with the original text. </td> </tr> </table>
    ///    pChange = Pointer to a TS_TEXTCHANGE structure that contains text change data.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pChange</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A
    ///    memory allocation failure occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl>
    ///    </td> <td width="60%"> The TSF manager holds a lock on the document. This typically indicates that the method
    ///    was called from within another ITextStoreACP method, such as ITextStoreACP::SetText. </td> </tr> </table>
    ///    
    HRESULT OnTextChange(uint dwFlags, const(TS_TEXTCHANGE)* pChange);
    ///Called when the selection within the document changes.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The manager holds a lock
    ///    on the document. </td> </tr> </table>
    ///    
    HRESULT OnSelectionChange();
    ///Called when the layout (on-screen representation) of the document changes.
    ///Params:
    ///    lcode = Contains a TsLayoutCode value that defines the type of change.
    ///    vcView = Contains an application-defined cookie that identifies the document. For more information, see
    ///             ITextStoreACP::GetActiveView.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnLayoutChange(TsLayoutCode lcode, uint vcView);
    ///Called when the status of the document changes.
    ///Params:
    ///    dwFlags = Contains a value that specifies the new status. For more information about possible values, see the
    ///              <b>dwDynamicFlags</b> member of the TS_STATUS structure.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnStatusChange(uint dwFlags);
    ///Called when the value of one or more text attribute changes.
    ///Params:
    ///    acpStart = Specifies the starting point of the attribute change.
    ///    acpEnd = Specifies the ending point of the attribute change.
    ///    cAttrs = Specifies the number of attributes in the <i>paAttrs</i> array.
    ///    paAttrs = Pointer to an array of TS_ATTRID values that identify the attributes changed.
    HRESULT OnAttrsChange(int acpStart, int acpEnd, uint cAttrs, char* paAttrs);
    ///Called to grant a document lock.
    ///Params:
    ///    dwLockFlags = Contains a set of flags that identify the type of lock requested and other lock request data. This can be one
    ///                  of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///                  id="TS_LF_READ"></a><a id="ts_lf_read"></a><dl> <dt><b>TS_LF_READ</b></dt> </dl> </td> <td width="60%"> The
    ///                  lock is read-only. </td> </tr> <tr> <td width="40%"><a id="TS_LF_READWRITE"></a><a
    ///                  id="ts_lf_readwrite"></a><dl> <dt><b>TS_LF_READWRITE</b></dt> </dl> </td> <td width="60%"> The lock is
    ///                  read/write. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>dwLockFlags</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The
    ///    wrong type of lock was granted. </td> </tr> </table>
    ///    
    HRESULT OnLockGranted(uint dwLockFlags);
    ///Called when an edit transaction is started.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnStartEditTransaction();
    ///Called when an edit transaction is terminated.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnEndEditTransaction();
}

///The <b>IAnchor</b> interface is implemented by the TSF manager. Clients of Microsoft Active Accessibility use
///<b>IAnchor</b> anchor objects to delimit a range of text within a text stream. The interface ID is IID_IAnchor.
@GUID("0FEB7E34-5A60-4356-8EF7-ABDEC2FF7CF8")
interface IAnchor : IUnknown
{
    ///Sets the gravity of the anchor.
    ///Params:
    ///    gravity = Contains a value from the TsGravity enumeration that specifies a new forward or backward gravity for the
    ///              anchor.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetGravity(TsGravity gravity);
    ///The <b>IAnchor::GetGravity</b> method retrieves the gravity of the anchor in an IAnchor object.
    ///Params:
    ///    pgravity = Pointer that receives a TsGravity value that specifies the anchor gravity.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pgravity</i>
    ///    pointer is invalid. </td> </tr> </table>
    ///    
    HRESULT GetGravity(TsGravity* pgravity);
    ///The <b>IAnchor::IsEqual</b> method evaluates two anchors within a text stream and returns a Boolean value that
    ///specifies the equality or inequality of the anchor positions.
    ///Params:
    ///    paWith = Specifies an anchor to compare to the primary anchor. Used to determine the equality of the two anchor
    ///             positions.
    ///    pfEqual = A Boolean value that specifies whether the two anchors are positioned at the same location. If set to
    ///              <b>TRUE</b>, the two anchors occupy the same location. If set to <b>FALSE</b>, the two anchors do not occupy
    ///              the same location.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pfEqual</i> is
    ///    invalid. </td> </tr> </table>
    ///    
    HRESULT IsEqual(IAnchor paWith, int* pfEqual);
    ///The <b>IAnchor::Compare</b> method compares the relative position of two anchors within a text stream.
    ///Params:
    ///    paWith = An anchor object to compare to the primary anchor. Used to determine the relative position of the two
    ///             anchors.
    ///    plResult = Result of the comparison of the positions of the two anchors. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///               </tr> <tr> <td width="40%"><a id="-1"></a><dl> <dt><b>-1</b></dt> </dl> </td> <td width="60%"> The primary
    ///               anchor is positioned earlier in the text stream than <i>paWith.</i> </td> </tr> <tr> <td width="40%"><a
    ///               id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%"> The primary anchor is positioned at the same
    ///               location as <i>paWith.</i> </td> </tr> <tr> <td width="40%"><a id="_1"></a><dl> <dt><b>+1</b></dt> </dl>
    ///               </td> <td width="60%"> The primary anchor is positioned later in the text stream than <i>paWith.</i> </td>
    ///               </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> <i>paWith</i> is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>plResult</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT Compare(IAnchor paWith, int* plResult);
    ///The <b>IAnchor::Shift</b> method shifts the anchor forward or backward within a text stream.
    ///Params:
    ///    dwFlags = Bit fields that are used to avoid anchor positioning. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///              <td width="40%"><a id="TS_SHIFT_COUNT_ONLY"></a><a id="ts_shift_count_only"></a><dl>
    ///              <dt><b>TS_SHIFT_COUNT_ONLY</b></dt> </dl> </td> <td width="60%"> The anchor is not shifted. If the flag is
    ///              not set (<i>dwFlags</i> = 0), the anchor will be shifted as specified by the other parameter settings. </td>
    ///              </tr> </table>
    ///    cchReq = The number of characters to move the anchor within the text stream.
    ///    pcch = The actual number of characters moved within the text stream. The method will set <i>pcch</i> to zero if it
    ///           fails.
    ///    paHaltAnchor = Reference to an anchor that blocks the shift. Set to <b>NULL</b> to avoid blocking the shift.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The shift failed. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An input parameter value
    ///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>dwFlags</i> parameter value is not implemented in this method. </td> </tr> </table>
    ///    
    HRESULT Shift(uint dwFlags, int cchReq, int* pcch, IAnchor paHaltAnchor);
    ///The <b>IAnchor::ShiftTo</b> method shifts the current anchor to the same position as another anchor.
    ///Params:
    ///    paSite = Anchor occupying a position that the current anchor will be moved to.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An IAnchor interface pointer
    ///    to the <i>paSite</i> anchor could not be obtained, or memory is too low to safely complete the operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>paSite</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT ShiftTo(IAnchor paSite);
    ///Shifts the anchor into an adjacent region in the text stream.
    ///Params:
    ///    dwFlags = Bitfields that are used to control anchor repositioning around hidden text, or to avoid actual repositioning
    ///              of the anchor. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///              id="TS_SHIFT_COUNT_HIDDEN"></a><a id="ts_shift_count_hidden"></a><dl> <dt><b>TS_SHIFT_COUNT_HIDDEN</b></dt>
    ///              </dl> </td> <td width="60%"> Specifies that the anchor will be shifted to the next region boundary, including
    ///              the boundary of a hidden text region. If not set, the anchor will be shifted past any adjacent hidden text
    ///              until a region of visible text is found. </td> </tr> <tr> <td width="40%"><a id="TS_SHIFT_COUNT_ONLY"></a><a
    ///              id="ts_shift_count_only"></a><dl> <dt><b>TS_SHIFT_COUNT_ONLY</b></dt> </dl> </td> <td width="60%"> The anchor
    ///              is not shifted. </td> </tr> </table>
    ///    dir = Contains one of the TsShiftDir values that specifies which adjacent region the anchor is moved to. <table>
    ///          <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TS_SD_BACKWARD"></a><a
    ///          id="ts_sd_backward"></a><dl> <dt><b>TS_SD_BACKWARD</b></dt> </dl> </td> <td width="60%"> Specifies that the
    ///          anchor will be moved to the region immediately preceding a range of text. </td> </tr> <tr> <td width="40%"><a
    ///          id="TS_SD_FORWARD"></a><a id="ts_sd_forward"></a><dl> <dt><b>TS_SD_FORWARD</b></dt> </dl> </td> <td
    ///          width="60%"> Specifies that the anchor will be moved to the region immediately following a range of text.
    ///          </td> </tr> </table>
    ///    pfNoRegion = Boolean value that specifies whether a shift of the anchor occurred. <table> <tr> <th>Value</th>
    ///                 <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl> <dt><b>TRUE</b></dt> </dl>
    ///                 </td> <td width="60%"> The shift failed, and the anchor was not repositioned. </td> </tr> <tr> <td
    ///                 width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> The
    ///                 shift succeeded. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The shift failed. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An input parameter value
    ///    is invalid. </td> </tr> </table>
    ///    
    HRESULT ShiftRegion(uint dwFlags, TsShiftDir dir, int* pfNoRegion);
    ///This method has not been implemented.
    ///Params:
    ///    dwMask = Not used.
    HRESULT SetChangeHistoryMask(uint dwMask);
    ///The <b>IAnchor::GetChangeHistory</b> method gets the history of deletions that have occurred immediately
    ///preceding or following the anchor.
    ///Params:
    ///    pdwHistory = Bit field flags that specify that deletions have occurred immediately preceding or following the anchor. One
    ///                 or both of the following values can be set. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///                 width="40%"><a id="TS_CH_PRECEDING_DEL"></a><a id="ts_ch_preceding_del"></a><dl>
    ///                 <dt><b>TS_CH_PRECEDING_DEL</b></dt> </dl> </td> <td width="60%"> Text preceding the anchor has been deleted.
    ///                 </td> </tr> <tr> <td width="40%"><a id="TS_CH_FOLLOWING_DEL"></a><a id="ts_ch_following_del"></a><dl>
    ///                 <dt><b>TS_CH_FOLLOWING_DEL</b></dt> </dl> </td> <td width="60%"> Text following the anchor has been deleted.
    ///                 </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value of
    ///    <i>pdwHistory</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT GetChangeHistory(uint* pdwHistory);
    ///The <b>IAnchor::ClearChangeHistory</b> method clears the anchor change history flags.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT ClearChangeHistory();
    ///The <b>IAnchor::Clone</b> method produces a new anchor object positioned at the same location, and with the same
    ///gravity, as the current anchor.
    ///Params:
    ///    ppaClone = A new anchor object, identical to the current anchor.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppaClone</i> is
    ///    invalid. </td> </tr> </table>
    ///    
    HRESULT Clone(IAnchor* ppaClone);
}

///The ITextStoreAnchor interface is implemented by a Microsoft Active Accessibility client and is used by the TSF
///manager to manipulate text streams. Ranges of text within a stream are delimited by anchor objects. these anchor
///objects are exposed and manipulated by the IAnchor interface. An application can obtain an instance of this interface
///with Microsoft Active Accessibility. The interface ID is IID_ITextStoreAnchor. To use the application character
///position (ACP) model for text manipulation, use ITextStoreACP instead.
@GUID("9B2077B0-5F18-4DEC-BEE9-3CC722F5DFE0")
interface ITextStoreAnchor : IUnknown
{
    ///The <b>ITextStoreAnchor::AdviseSink</b> method installs a new advise sink from the ITextStoreAnchorSink interface
    ///or modifies an existing advise sink.
    ///Params:
    ///    riid = Specifies the sink interface. The only supported value is IID_ITextStoreAnchorSink.
    ///    punk = Pointer to the sink interface to advise. Cannot be <b>NULL</b>.
    ///    dwMask = Specifies the events that notify the advise sink. For more information about possible parameter values, see
    ///             TS_AS_* Constants.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The specified sink interface
    ///    <i>riid</i> could not be obtained. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> The specified sink interface is unsupported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The specified sink object could not be obtained.
    ///    </td> </tr> </table>
    ///    
    HRESULT AdviseSink(const(GUID)* riid, IUnknown punk, uint dwMask);
    ///Called by an application to indicate that it no longer requires notifications from the TSF manager.
    ///Params:
    ///    punk = Pointer to a sink object. Cannot be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>CONNECT_E_NOCONNECTION</b></dt> </dl> </td> <td width="60%"> There is no
    ///    active sink object. </td> </tr> </table>
    ///    
    HRESULT UnadviseSink(IUnknown punk);
    ///Used by the TSF manager to provide a document lock in order to modify the text stream.
    ///Params:
    ///    dwLockFlags = Specifies the type of lock requested. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///                  width="40%"><a id="TS_LF_READ"></a><a id="ts_lf_read"></a><dl> <dt><b>TS_LF_READ</b></dt> </dl> </td> <td
    ///                  width="60%"> The document has a read-only lock and cannot be modified. </td> </tr> <tr> <td width="40%"><a
    ///                  id="TS_LF_READWRITE"></a><a id="ts_lf_readwrite"></a><dl> <dt><b>TS_LF_READWRITE</b></dt> </dl> </td> <td
    ///                  width="60%"> The document has a read/write lock and can be modified. </td> </tr> <tr> <td width="40%"><a
    ///                  id="TS_LF_SYNC"></a><a id="ts_lf_sync"></a><dl> <dt><b>TS_LF_SYNC</b></dt> </dl> </td> <td width="60%"> The
    ///                  document has a synchronous-lock if this flag is combined with other flags. </td> </tr> </table>
    ///    phrSession = If the lock request is synchronous, receives an HRESULT value from the ITextStoreAnchorSink::OnLockGranted
    ///                 method that specifies the result of the lock request. If the lock request is asynchronous and the result is
    ///                 TS_S_ASYNC, the document receives an asynchronous lock. If the lock request is asynchronous and the result is
    ///                 TS_E_SYNCHRONOUS, the document cannot be locked synchronously.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT RequestLock(uint dwLockFlags, int* phrSession);
    ///The <b>ITextStoreAnchor::GetStatus</b> method obtains the document status. The document status is returned
    ///through the TS_STATUS structure.
    ///Params:
    ///    pdcs = Receives the TS_STATUS structure that contains the document status. Cannot be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The pointer to the
    ///    TS_STATUS parameter is invalid. </td> </tr> </table>
    ///    
    HRESULT GetStatus(TS_STATUS* pdcs);
    ///The <b>ITextStoreAnchor::QueryInsert</b> method determines whether the specified start and end anchors are valid.
    ///Use this method to adjust an edit to a document before you execute the edit. The method must not return values
    ///outside the range of the document.
    ///Params:
    ///    paTestStart = Receives a pointer to a start anchor for the inserted text.
    ///    paTestEnd = Receives a pointer to an end anchor for the inserted text. This is the same as <i>paTestStart</i> if the text
    ///                is inserted at a point instead of replacing selected text.
    ///    cch = Length of replacement text.
    ///    ppaResultStart = Pointer to the new anchor object at the starting location for the inserted text. If the value of this
    ///                     parameter is <b>NULL</b>, then text cannot be inserted at the specified position. This anchor cannot be
    ///                     outside the document.
    ///    ppaResultEnd = Pointer to the new anchor object at the ending location for the inserted text. If the value of this parameter
    ///                   is <b>NULL</b>, then text cannot be inserted at the specified position. This anchor cannot be outside the
    ///                   document.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>paTestStart</i> or <i>paTestEnd</i> parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The attempt to instantiate the
    ///    <i>ppaResultStart</i> and/or <i>ppaResultEnd</i> anchors failed. </td> </tr> </table>
    ///    
    HRESULT QueryInsert(IAnchor paTestStart, IAnchor paTestEnd, uint cch, IAnchor* ppaResultStart, 
                        IAnchor* ppaResultEnd);
    ///The <b>ITextStoreAnchor::GetSelection</b> method returns the offset of a text selection in a text stream. This
    ///method supports multiple text selections. The caller must have a read-only lock on the document before calling
    ///this method.
    ///Params:
    ///    ulIndex = Specifies the text selections that start the process. If the TF_DEFAULT_SELECTION constant is specified for
    ///              this parameter, the input selection starts the process, and only a single selection (the one appropriate for
    ///              input operations) will be returned.
    ///    ulCount = Specifies the maximum number of selections to return.
    ///    pSelection = Receives the style, start, and end character positions of the selected text. These values are put into the
    ///                 TS_SELECTION_ANCHOR structure.
    ///    pcFetched = Receives the number of <i>pSelection</i> structures returned.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method was unable to load
    ///    the start or end anchor into the <b>TS_SELECTION_ANCHOR</b> structure. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate memory for the
    ///    selection. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td width="60%">
    ///    The caller does not have a read-only lock on the document. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_NOSELECTION</b></dt> </dl> </td> <td width="60%"> The document has no selection. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetSelection(uint ulIndex, uint ulCount, char* pSelection, uint* pcFetched);
    ///Selects text within the document.
    ///Params:
    ///    ulCount = Specifies the number of text selections in <i>pSelection</i>.
    ///    pSelection = Specifies the style, start, and end character positions of the text selected through the TS_SELECTION_ANCHOR
    ///                 structure. The start anchor member <b>paStart</b> of the structure must never follow the end anchor member
    ///                 <b>paEnd</b>, although they might be at the same location. When <b>paStart</b> = <b>paEnd</b>, the method
    ///                 places a caret at the anchor location. There can be only one caret at a time in the text stream.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method
    ///    was unable to allocate sufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_INVALIDPOS</b></dt> </dl> </td> <td width="60%"> The anchor locations specified are beyond the
    ///    text in the document. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td
    ///    width="60%"> The caller does not have a read/write lock. </td> </tr> </table>
    ///    
    HRESULT SetSelection(uint ulCount, char* pSelection);
    ///The <b>ITextStoreAnchor::GetText</b> method returns information about text at a specified anchor position. This
    ///method returns the visible and hidden text and indicates if embedded data is attached to the text.
    ///Params:
    ///    dwFlags = Not used; should be zero.
    ///    paStart = Specifies the starting anchor position.
    ///    paEnd = Specifies the ending anchor position. If <b>NULL</b>, it is treated as if it were an anchor positioned at the
    ///            very end of the text stream.
    ///    pchText = Specifies the buffer to receive the text. May be <b>NULL</b> only when <i>cchReq</i> = 0.
    ///    cchReq = Specifies the <i>pchText</i> buffer size in characters.
    ///    pcch = Receives the number of characters copied into the <i>pchText</i> buffer.
    ///    fUpdateAnchor = If <b>TRUE</b>, <i>paStart</i> will be repositioned just past the last character copied to <i>pchText</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method was unable to
    ///    obtain a valid interface pointer to <i>paStart</i> and/or <i>paEnd</i>. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>TF_E_INVALIDPOS</b></dt> </dl> </td> <td width="60%"> The <i>paStart</i> or <i>paEnd</i> anchors
    ///    are outside of the document text. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl>
    ///    </td> <td width="60%"> The caller does not have a read-only lock on the document. </td> </tr> </table>
    ///    
    HRESULT GetText(uint dwFlags, IAnchor paStart, IAnchor paEnd, char* pchText, uint cchReq, uint* pcch, 
                    BOOL fUpdateAnchor);
    ///The <b>ITextStoreAnchor::SetText</b> method sets the text selection between two supplied anchor locations.
    ///Params:
    ///    dwFlags = If set to the value of TS_ST_CORRECTION, the text is a transform (correction) of existing content, and any
    ///              special text markup information (metadata) is retained, such as .wav file data or a language identifier. The
    ///              client defines the type of markup information to be retained.
    ///    paStart = Pointer to the anchor at the start of the range of text to replace.
    ///    paEnd = Pointer to the anchor at the end of the range of text to replace. Must always follow or be at the same
    ///            position as <i>paStart</i>.
    ///    pchText = Pointer to the replacement text. The text string does not have to be <b>NULL</b> terminated, because the text
    ///              character count is specified in the <i>cch</i> parameter.
    ///    cch = Specifies the number of characters in the replacement text.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method could not
    ///    instantiate one of the anchors <i>paStart</i> or <i>paEnd</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_INVALIDPOS</b></dt> </dl> </td> <td width="60%"> The location of <i>paStart</i> or <i>paEnd</i>
    ///    is outside of the document text. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl>
    ///    </td> <td width="60%"> The caller does not have a read/write lock. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_READONLY</b></dt> </dl> </td> <td width="60%"> The document is read-only. Content cannot be
    ///    modified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_REGION</b></dt> </dl> </td> <td width="60%"> An
    ///    attempt was made to modify text across a region boundary. </td> </tr> </table>
    ///    
    HRESULT SetText(uint dwFlags, IAnchor paStart, IAnchor paEnd, const(wchar)* pchText, uint cch);
    ///The <b>ITextStoreAnchor::GetFormattedText</b> method returns formatted text information from a text stream.
    ///Params:
    ///    paStart = Anchor position at which to start retrieval of formatted text.
    ///    paEnd = Anchor position at which to end retrieval of formatted text.
    ///    ppDataObject = Pointer to the IDataObject object that contains the formatted text.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method was unable to
    ///    obtain a valid interface pointer to the start and/or end anchors. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> An application can return this value if the method is
    ///    not implemented. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td
    ///    width="60%"> The caller does not have a read/write lock on the document. </td> </tr> </table>
    ///    
    HRESULT GetFormattedText(IAnchor paStart, IAnchor paEnd, IDataObject* ppDataObject);
    ///The <b>ITextStoreAnchor::GetEmbedded</b> method obtains an embedded object from a text stream.
    ///Params:
    ///    dwFlags = Bit fields that specify how the method deals with hidden text. If set to TS_GEA_HIDDEN, an embedded object
    ///              can be located within hidden text. Otherwise hidden text is skipped over.
    ///    paPos = Pointer to an anchor positioned immediately in front of the embedded object, as denoted by a TS_CHAR_EMBEDDED
    ///            character.
    ///    rguidService = Contains a GUID value that defines the requested format of the obtained object. This can be one of the
    ///                   following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///                   id="GUID_TS_SERVICE_DATAOBJECT"></a><a id="guid_ts_service_dataobject"></a><dl>
    ///                   <dt><b>GUID_TS_SERVICE_DATAOBJECT</b></dt> </dl> </td> <td width="60%"> The object should be obtained as an
    ///                   IDataObject data object. </td> </tr> <tr> <td width="40%"><a id="GUID_TS_SERVICE_ACCESSIBLE"></a><a
    ///                   id="guid_ts_service_accessible"></a><dl> <dt><b>GUID_TS_SERVICE_ACCESSIBLE</b></dt> </dl> </td> <td
    ///                   width="60%"> The object should be obtained as an Accessible object. </td> </tr> <tr> <td width="40%"><a
    ///                   id="GUID_TS_SERVICE_ACTIVEX"></a><a id="guid_ts_service_activex"></a><dl>
    ///                   <dt><b>GUID_TS_SERVICE_ACTIVEX</b></dt> </dl> </td> <td width="60%"> The object should be obtained as an
    ///                   ActiveX object. </td> </tr> </table>
    ///    riid = Specifies the interface type requested.
    ///    ppunk = Pointer to an <b>IUnknown</b> pointer that receives the requested interface.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed to obtain
    ///    the requested object. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The implementing application does not expose embedded
    ///    objects in its text stream. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_INVALIDPOS</b></dt> </dl>
    ///    </td> <td width="60%"> The requested <i>paPos</i> anchor is not within the document. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TS_E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> The requested interface type
    ///    is unsupported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td
    ///    width="60%"> The caller does not have a read-only lock. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_NOOBJECT</b></dt> </dl> </td> <td width="60%"> There is no <i>paPos</i> anchor immediately in
    ///    front of a TS_CHAR_EMBEDDED character. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOSERVICE</b></dt>
    ///    </dl> </td> <td width="60%"> The service type specified in <i>rguidService</i> is unsupported. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetEmbedded(uint dwFlags, IAnchor paPos, const(GUID)* rguidService, const(GUID)* riid, IUnknown* ppunk);
    ///Inserts an IDataObject data object into a text stream.
    ///Params:
    ///    dwFlags = Must be TS_IE_CORRECTION.
    ///    paStart = Pointer to the anchor at the start of the object to be inserted.
    ///    paEnd = Pointer to the anchor at the end of the object to be inserted.
    ///    pDataObject = Pointer to an <b>IDataObject</b> data object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method was unable to
    ///    obtain a valid interface pointer to the start and/or end anchors. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more input parameters are invalid. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The application does
    ///    not support embedded objects. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_FORMAT</b></dt> </dl> </td>
    ///    <td width="60%"> The application does not support the data type contained in <i>pDataObject</i>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TS_E_INVALIDPOS</b></dt> </dl> </td> <td width="60%"> <i>paStart</i> and/or
    ///    <i>paEnd</i> are not within the document. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt>
    ///    </dl> </td> <td width="60%"> The caller does not have a read/write lock. </td> </tr> </table>
    ///    
    HRESULT InsertEmbedded(uint dwFlags, IAnchor paStart, IAnchor paEnd, IDataObject pDataObject);
    ///Obtains the supported attributes of a text stream.
    ///Params:
    ///    dwFlags = Specifies whether a subsequent call to the <b>ITextStoreAnchor::RetrieveRequestedAttrs</b> method will
    ///              contain the supported attributes. If the TS_ATTR_FIND_WANT_VALUE flag is specified, the default attribute
    ///              values will be those in the TS_ATTRVAL structure after the subsequent call to
    ///              <b>ITextStoreAnchor::RetrieveRequestedAttrs</b>. If any other flag is specified for this parameter, the
    ///              method only verifies that the attribute is supported and that the <b>varValue</b> member of the
    ///              <b>TS_ATTRVAL</b> structure is set to VT_EMPTY.
    ///    cFilterAttrs = Specifies the number of supported attributes to obtain.
    ///    paFilterAttrs = Pointer to the TS_ATTRID data type that specifies the attribute to verify. The method returns only the
    ///                    attributes specified by <b>TS_ATTRID</b>, even though other attributes might be supported.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method
    ///    was unable to allocate sufficient memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT RequestSupportedAttrs(uint dwFlags, uint cFilterAttrs, char* paFilterAttrs);
    ///Obtains a list of attributes that begin or end at the specified anchor location.
    ///Params:
    ///    paPos = Pointer to the anchor.
    ///    cFilterAttrs = Specifies the number of attributes to obtain.
    ///    paFilterAttrs = Pointer to the TS_ATTRID data type that specifies the attribute to verify.
    ///    dwFlags = Must be zero.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>paPos</i> anchor
    ///    is invalid. </td> </tr> </table>
    ///    
    HRESULT RequestAttrsAtPosition(IAnchor paPos, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags);
    ///Obtains a list of attributes that begin or end at the specified anchor location.
    ///Params:
    ///    paPos = Pointer to the anchor.
    ///    cFilterAttrs = Specifies the number of attributes to obtain.
    ///    paFilterAttrs = Pointer to the TS_ATTRID data type that specifies the attribute to verify.
    ///    dwFlags = Specifies attributes for the call to the ITextStoreAnchor::RetrieveRequestedAttrs method. If this parameter
    ///              is not set, the method returns the attributes that start at the specified anchor location. Other possible
    ///              values for this parameter are the following. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///              width="40%"><a id="TS_ATTR_FIND_WANT_END"></a><a id="ts_attr_find_want_end"></a><dl>
    ///              <dt><b>TS_ATTR_FIND_WANT_END</b></dt> </dl> </td> <td width="60%"> Obtains the attributes that end at the
    ///              specified anchor location. </td> </tr> <tr> <td width="40%"><a id="TS_ATTR_FIND_WANT_VALUE"></a><a
    ///              id="ts_attr_find_want_value"></a><dl> <dt><b>TS_ATTR_FIND_WANT_VALUE</b></dt> </dl> </td> <td width="60%">
    ///              Obtains the value of the attribute in addition to the attribute. The attribute value is put into the
    ///              <b>varValue</b> member of the TS_ATTRVAL structure during the <b>ITextStoreAnchor::RetrieveRequestedAttrs</b>
    ///              method call. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>paPos</i> is invalid.
    ///    </td> </tr> </table>
    ///    
    HRESULT RequestAttrsTransitioningAtPosition(IAnchor paPos, uint cFilterAttrs, char* paFilterAttrs, 
                                                uint dwFlags);
    ///The <b>ITextStoreAnchor::FindNextAttrTransition</b> method finds the location in the text stream where a
    ///transition occurs in an attribute value. The specified attribute to check is application-dependent.
    ///Params:
    ///    paStart = Pointer to the anchor position at the start of a range to search for an attribute transition.
    ///    paHalt = Pointer to the anchor position at the end of a range to search for an attribute transition.
    ///    cFilterAttrs = Specifies the number of attributes to check.
    ///    paFilterAttrs = Pointer to the TS_ATTRID data type that specifies the attribute to check. Pre-defined attributes are given in
    ///                    tsattrs.h.
    ///    dwFlags = Specifies the direction to search for an attribute transition. By default, the method searches forward.
    ///              <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TS_ATTR_FIND_BACKWARDS"></a><a
    ///              id="ts_attr_find_backwards"></a><dl> <dt><b>TS_ATTR_FIND_BACKWARDS</b></dt> </dl> </td> <td width="60%"> The
    ///              method searches backward in the text stream. </td> </tr> <tr> <td width="40%"><a
    ///              id="TS_ATTR_FIND_UPDATESTART"></a><a id="ts_attr_find_updatestart"></a><dl>
    ///              <dt><b>TS_ATTR_FIND_UPDATESTART</b></dt> </dl> </td> <td width="60%"> The method positions the input anchor
    ///              <i>paStart</i> at the next attribute transition, if one is found. Otherwise the input anchor is not modified.
    ///              </td> </tr> <tr> <td width="40%"><a id="TS_ATTR_FIND_WANT_OFFSET"></a><a
    ///              id="ts_attr_find_want_offset"></a><dl> <dt><b>TS_ATTR_FIND_WANT_OFFSET</b></dt> </dl> </td> <td width="60%">
    ///              The <i>plFoundOffset</i> parameter receives the character offset of the attribute transition from
    ///              <i>paStart</i>. </td> </tr> </table>
    ///    pfFound = Receives a Boolean value of <b>TRUE</b> if an attribute transition was found, otherwise <b>FALSE</b> is
    ///              returned.
    ///    plFoundOffset = Receives the character offset of the attribute transition from the start anchor <i>paStart</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>paStart</i> and/or
    ///    <i>paHalt</i> are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_INVALIDPOS</b></dt> </dl> </td>
    ///    <td width="60%"> The character positions specified are beyond the text in the document. </td> </tr> </table>
    ///    
    HRESULT FindNextAttrTransition(IAnchor paStart, IAnchor paHalt, uint cFilterAttrs, char* paFilterAttrs, 
                                   uint dwFlags, int* pfFound, int* plFoundOffset);
    ///Returns the attributes obtained by the RequestAttrsAtPosition, RequestAttrsTransitioningAtPosition, or
    ///RequestSupportedAttrs methods.
    ///Params:
    ///    ulCount = Specifies the number of supported attributes to obtain.
    ///    paAttrVals = Pointer to the TS_ATTRVAL structure that receives the supported attributes. The members of this structure
    ///                 depend upon the <i>dwFlags</i> parameter of the calling method.
    ///    pcFetched = Receives the number of supported attributes.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT RetrieveRequestedAttrs(uint ulCount, char* paAttrVals, uint* pcFetched);
    ///The <b>ITextStoreAnchor::GetStart</b> method returns an anchor positioned at the start of the text stream.
    ///Params:
    ///    ppaStart = Pointer to an anchor object located at the start of the text stream.
    HRESULT GetStart(IAnchor* ppaStart);
    ///The <b>ITextStoreAnchor::GetEnd</b> method returns an anchor positioned at the end of the text stream.
    ///Params:
    ///    ppaEnd = Pointer to an anchor object located at the very end of the text stream.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppaEnd</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The
    ///    application has not implemented this method. This is usually an indication that calculating the end position
    ///    requires excessive resources. If the end position is necessary, you can use ITextStoreAnchor::GetText to
    ///    calculate it, though this might also be a memory-intensive operation, paging in arbitrarily large amounts of
    ///    memory from disk. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> The attempt to instantiate an anchor at the end of the document failed. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller does not have a
    ///    read-only lock. </td> </tr> </table>
    ///    
    HRESULT GetEnd(IAnchor* ppaEnd);
    ///The <b>ITextStoreAnchor::GetActiveView</b> method returns a TsViewCookie data type that specifies the current
    ///active view. TSF supports only a single active view, so a given text store should always return the same
    ///<b>TsViewCookie</b> data type.
    ///Params:
    ///    pvcView = Receives the <b>TsViewCookie</b> data type that specifies the current active view.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pvcView</i> is
    ///    invalid. </td> </tr> </table>
    ///    
    HRESULT GetActiveView(uint* pvcView);
    ///The <b>ITextStoreAnchor::GetAnchorFromPoint</b> method converts a point in screen coordinates to an anchor
    ///positioned at a corresponding location.
    ///Params:
    ///    vcView = Specifies the context view.
    ///    ptScreen = Pointer to the <b>POINT</b> structure with the screen coordinates of the point.
    ///    dwFlags = Specifies the anchor position to return based upon the screen coordinates of the point relative to a
    ///              character bounding box. By default, the anchor position returned is the character bounding box containing the
    ///              screen coordinates of the point. If the point is outside a character bounding box, the method returns
    ///              <b>NULL</b> or TF_E_INVALIDPOINT. Other bit flags for this parameter are as follows. The bit flags can be
    ///              combined. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///              id="GXFPF_ROUND_NEAREST"></a><a id="gxfpf_round_nearest"></a><dl> <dt><b>GXFPF_ROUND_NEAREST</b></dt> </dl>
    ///              </td> <td width="60%"> If the screen coordinates of the point are contained in a character bounding box, an
    ///              anchor is returned at the bounding edge closest to the screen coordinates of the point. </td> </tr> <tr> <td
    ///              width="40%"><a id="GXFPF_NEAREST"></a><a id="gxfpf_nearest"></a><dl> <dt><b>GXFPF_NEAREST</b></dt> </dl>
    ///              </td> <td width="60%"> If the screen coordinates of the point are not contained in a character bounding box,
    ///              an anchor at the closest character position is returned. </td> </tr> </table>
    ///    ppaSite = Pointer to an anchor object at a location corresponding to the screen coordinates <i>ptScreen</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more input
    ///    parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> The attempt to instantiate an anchor at the specified location failed. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TS_E_INVALIDPOINT</b></dt> </dl> </td> <td width="60%"> The <i>ptScreen</i>
    ///    parameter is not within the bounding box of any character. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_NOLAYOUT</b></dt> </dl> </td> <td width="60%"> The application has not calculated a text layout
    ///    yet. </td> </tr> </table>
    ///    
    HRESULT GetAnchorFromPoint(uint vcView, const(POINT)* ptScreen, uint dwFlags, IAnchor* ppaSite);
    ///The <b>ITextStoreAnchor::GetTextExt</b> method returns the bounding box, in screen coordinates, of a range of
    ///text. The caller must have a read-only lock on the document before calling this method.
    ///Params:
    ///    vcView = Specifies the context view.
    ///    paStart = Specifies the anchor positioned at the start of the range.
    ///    paEnd = Specifies the anchor positioned at the end of the range.
    ///    prc = Receives the bounding box of the text range in screen coordinates.
    ///    pfClipped = Receives a Boolean value that specifies if the text in the bounding box has been clipped. If <b>TRUE</b>, the
    ///                bounding box contains clipped text and does not include the entire requested text range. The bounding box is
    ///                clipped because the requested range is not visible.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method was unable to
    ///    obtain a valid interface pointer to the start and/or end anchors. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the input parameters is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_INVALIDPOS</b></dt> </dl> </td> <td width="60%"> The range
    ///    specified by the <i>paStart</i> and <i>paEnd</i> parameters extends past the beginning or end of the
    ///    document. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLAYOUT</b></dt> </dl> </td> <td width="60%">
    ///    The application has not calculated a text layout. Any further calls will not succeed until the application
    ///    calls ITextStoreAnchorSink::OnLayoutChange. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller does not have a read-only lock on the
    ///    document. </td> </tr> </table>
    ///    
    HRESULT GetTextExt(uint vcView, IAnchor paStart, IAnchor paEnd, RECT* prc, int* pfClipped);
    ///The <b>ITextStoreAnchor::GetScreenExt</b> method returns the bounding box screen coordinates of the display
    ///surface where the text stream is rendered.
    ///Params:
    ///    vcView = Specifies the context view.
    ///    prc = Receives the bounding box screen coordinates of the display surface of the document.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The specified
    ///    <i>vcView</i> parameter is invalid. </td> </tr> </table>
    ///    
    HRESULT GetScreenExt(uint vcView, RECT* prc);
    ///The <b>ITextStoreAnchor::GetWnd</b> method returns the handle to a window that corresponds to the current text
    ///stream.
    ///Params:
    ///    vcView = Specifies the TsViewCookie data type that corresponds to the current document.
    ///    phwnd = Receives a pointer to the handle of the window that corresponds to the current document. This parameter can
    ///            be <b>NULL</b> if the document does not have the corresponding handle to the window.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <b>TsViewCookie</b>
    ///    data type is invalid. </td> </tr> </table>
    ///    
    HRESULT GetWnd(uint vcView, HWND* phwnd);
    ///Determines whether the document can accept an embedded object through the InsertEmbedded or
    ///InsertEmbeddedAtSelection methods.
    ///Params:
    ///    pguidService = Pointer to the object type. If <b>NULL</b>, <i>pFormatEtc</i> should be used.
    ///    pFormatEtc = Pointer to the FORMATETC structure that contains format data of the object. This parameter cannot be
    ///                 <b>NULL</b> if the <i>pguidService</i> parameter is <b>NULL</b>.
    ///    pfInsertable = Receives <b>TRUE</b> if the object type can be inserted into the document or <b>FALSE</b> if the object type
    ///                   cannot be inserted into the document.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pFormatEtc</i>
    ///    parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT QueryInsertEmbedded(const(GUID)* pguidService, const(FORMATETC)* pFormatEtc, int* pfInsertable);
    ///Inserts text at the insertion point or selection.
    ///Params:
    ///    dwFlags = Specifies whether the <i>paStart</i> and <i>paEnd</i> parameters will contain the results of the text
    ///              insertion. The TF_IAS_NOQUERY and TF_IAS_QUERYONLY flags cannot be combined. <table> <tr> <th>Value</th>
    ///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TF_IAS_NOQUERY"></a><a id="tf_ias_noquery"></a><dl>
    ///              <dt><b>TF_IAS_NOQUERY</b></dt> </dl> </td> <td width="60%"> Text is inserted, and the values of the
    ///              <i>ppaStart</i> and <i>ppaEnd</i> parameters can be <b>NULL</b>. Use this flag if the results of the text
    ///              insertion are not required. </td> </tr> <tr> <td width="40%"><a id="TF_IAS_QUERYONLY"></a><a
    ///              id="tf_ias_queryonly"></a><dl> <dt><b>TF_IAS_QUERYONLY</b></dt> </dl> </td> <td width="60%"> Text is not
    ///              inserted, and the <i>ppaStart</i> and <i>ppaEnd</i> anchors contain the results of the text insertion. The
    ///              values of these parameters depend on how the application implements text insertion into a document. Use this
    ///              flag to view the results of the text insertion without actually inserting the text. Zero-length text can be
    ///              inserted. </td> </tr> </table>
    ///    pchText = Pointer to the string to insert in the document. The string can be <b>NULL</b> terminated.
    ///    cch = Specifies the text length.
    ///    ppaStart = Pointer to the anchor object at the start of the text insertion.
    ///    ppaEnd = Pointer to the anchor object at the end of the text insertion. For an insertion point, this parameter value
    ///             will be the same as the value of the <i>ppaStart</i> parameter.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method could not
    ///    instantiate one of the anchors <i>paStart</i> or <i>paEnd</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pchText</i> parameter is invalid. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller does not
    ///    have a lock on the document. </td> </tr> </table>
    ///    
    HRESULT InsertTextAtSelection(uint dwFlags, const(wchar)* pchText, uint cch, IAnchor* ppaStart, 
                                  IAnchor* ppaEnd);
    ///The <b>ITextStoreAnchor::InsertEmbeddedAtSelection</b> method inserts an IDataObject object at the insertion
    ///point or selection. The client that calls this method must have a read/write lock before inserting an
    ///<b>IDataObject</b> into the text stream.
    ///Params:
    ///    dwFlags = Specifies whether the <i>paStart</i> and <i>paEnd</i> parameters will contain the results of the object
    ///              insertion. The TF_IAS_NOQUERY and TF_IAS_QUERYONLY flags cannot be combined. <table> <tr> <th>Value</th>
    ///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TF_IAS_NOQUERY"></a><a id="tf_ias_noquery"></a><dl>
    ///              <dt><b>TF_IAS_NOQUERY</b></dt> </dl> </td> <td width="60%"> Text is inserted, and the values of the
    ///              <i>ppaStart</i> and <i>ppaEnd</i> parameters can be <b>NULL</b>. Use this flag if the results of the text
    ///              insertion are not required. </td> </tr> <tr> <td width="40%"><a id="TF_IAS_QUERYONLY"></a><a
    ///              id="tf_ias_queryonly"></a><dl> <dt><b>TF_IAS_QUERYONLY</b></dt> </dl> </td> <td width="60%"> Text is not
    ///              inserted, and the <i>ppaStart</i> and <i>ppaEnd</i> anchors contain the results of the text insertion. The
    ///              values of these parameters depend on how the application implements text insertion into a document. Use this
    ///              flag to view the results of the text insertion without actually inserting the text, for example, to predict
    ///              the results of collapsing or otherwise adjusting a selection. </td> </tr> </table>
    ///    pDataObject = Pointer to the <b>IDataObject</b> object to be inserted.
    ///    ppaStart = Pointer to the anchor object at the start of the object insertion.
    ///    ppaEnd = Pointer to the anchor object at the end of the object insertion. For an insertion point, this parameter value
    ///             will be the same as the value of the <i>ppaStart</i> parameter.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method could not
    ///    instantiate one of the anchors <i>paStart</i> or <i>paEnd</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pchText</i> parameter is invalid. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could
    ///    not instantiate one of the anchors <i>paStart</i> or <i>paEnd</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller does not have a lock on the document.
    ///    </td> </tr> </table>
    ///    
    HRESULT InsertEmbeddedAtSelection(uint dwFlags, IDataObject pDataObject, IAnchor* ppaStart, IAnchor* ppaEnd);
}

///The <b>ITextStoreAnchorSink</b> interface is implemented by the TSF manager and is used by an anchor-based
///application to notify the manager when certain events occur. The manager installs this advise sink by calling
///ITextStoreAnchor::AdviseSink. The interface ID is IID_ITextStoreAnchorSink.
@GUID("AA80E905-2021-11D2-93E0-0060B067B86E")
interface ITextStoreAnchorSink : IUnknown
{
    ///Called when text in the text stream changes.
    ///Params:
    ///    dwFlags = Contains a set of flags that specify additional information about the text change. This can be one or more of
    ///              the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///              id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%"> The text has changed. </td> </tr> <tr> <td
    ///              width="40%"><a id="TS_TC_CORRECTION"></a><a id="ts_tc_correction"></a><dl> <dt><b>TS_TC_CORRECTION</b></dt>
    ///              </dl> </td> <td width="60%"> The text is a transform (correction) of existing content, and any special text
    ///              markup information (metadata) is retained, such as .wav file data or a language identifier. This flag is used
    ///              for applications that need to preserve data associated with the original text. </td> </tr> </table>
    ///    paStart = Pointer to an anchor located at the start of the changed text.
    ///    paEnd = Pointer to an anchor located at the end of the changed text.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method was unable to
    ///    create cloned anchors to contain the change. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>paStart</i> or <i>paEnd</i> is invalid. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory
    ///    allocation failure occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td>
    ///    <td width="60%"> The TSF manager holds a lock on the document. This typically indicates that the method was
    ///    called from within another ITextStoreAnchor method, such as ITextStoreAnchor::SetText. </td> </tr> </table>
    ///    
    HRESULT OnTextChange(uint dwFlags, IAnchor paStart, IAnchor paEnd);
    ///The <b>ITextStoreAnchorSink::OnSelectionChange</b> method is called when the selection within the text stream
    ///changes. This method should be called whenever the return value of a potential call to
    ///ITextStoreAnchor::GetSelection has changed.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The manager holds a lock
    ///    on the document. </td> </tr> </table>
    ///    
    HRESULT OnSelectionChange();
    ///The <b>ITextStoreAnchorSink::OnLayoutChange</b> method is called when the layout (on-screen representation) of
    ///the document changes.
    ///Params:
    ///    lcode = Contains a TsLayoutCode value that defines the type of change.
    ///    vcView = Contains an application-defined cookie that identifies the document. For more information, see
    ///             ITextStoreAnchor::GetActiveView.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnLayoutChange(TsLayoutCode lcode, uint vcView);
    ///Called when the text stream status changes.
    ///Params:
    ///    dwFlags = Contains a value that specifies the new status. For more information about possible values, see the
    ///              <b>dwDynamicFlags</b> member of the TS_STATUS structure.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnStatusChange(uint dwFlags);
    ///The <b>ITextStoreAnchorSink::OnAttrsChange</b> method is called when the value of one or more text attributes
    ///changes.
    ///Params:
    ///    paStart = Pointer to the start anchor of the range of text that has the attribute change.
    ///    paEnd = Pointer to the end anchor of the range of text that has the attribute change.
    ///    cAttrs = Specifies the number of attributes in the <i>paAttrs</i> array.
    ///    paAttrs = Pointer to an array of TS_ATTRID values that identify the attributes changed.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> </table>
    ///    
    HRESULT OnAttrsChange(IAnchor paStart, IAnchor paEnd, uint cAttrs, char* paAttrs);
    ///Called to grant a document lock.
    ///Params:
    ///    dwLockFlags = Contains a set of flags that identify the type of lock requested and other lock request data. This can be one
    ///                  of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///                  id="TS_LF_READ"></a><a id="ts_lf_read"></a><dl> <dt><b>TS_LF_READ</b></dt> </dl> </td> <td width="60%"> The
    ///                  lock is read-only. </td> </tr> <tr> <td width="40%"><a id="TS_LF_READWRITE"></a><a
    ///                  id="ts_lf_readwrite"></a><dl> <dt><b>TS_LF_READWRITE</b></dt> </dl> </td> <td width="60%"> The lock is
    ///                  read/write. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>dwLockFlags</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The
    ///    wrong type of lock was granted. </td> </tr> </table>
    ///    
    HRESULT OnLockGranted(uint dwLockFlags);
    ///Called when an edit transaction is started.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnStartEditTransaction();
    ///Called when an edit transaction is terminated.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The reference count of
    ///    the edit transaction is incorrect. </td> </tr> </table>
    ///    
    HRESULT OnEndEditTransaction();
}

///The <b>ITfLangBarMgr</b> interface is implemented by the TSF manager and used by text services to manage event sink
///notification and configure floating language bar display settings. The interface ID is IID_ITfLangBarMgr.
@GUID("87955690-E627-11D2-8DDB-00105A2799B5")
interface ITfLangBarMgr : IUnknown
{
    ///The <b>ITfLangBarMgr::AdviseEventSink</b> method advises a sink about a language bar event.
    ///Params:
    ///    pSink = Sink object to advise about the event.
    ///    hwnd = Reserved; must be <b>NULL</b>.
    ///    dwFlags = Reserved; must be 0.
    ///    pdwCookie = Pointer to an identifier for the connection.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pSink</i> is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified
    ///    error occurred. </td> </tr> </table>
    ///    
    HRESULT AdviseEventSink(ITfLangBarEventSink pSink, HWND hwnd, uint dwFlags, uint* pdwCookie);
    ///Uninstalls an advise event sink.
    ///Params:
    ///    dwCookie = A DWORD value that identifies the advise event sink to uninstall. This value is provided by a previous call
    ///               to ITfLangBarMgr::AdviseEventSink.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT UnadviseEventSink(uint dwCookie);
    ///Should not be used.
    ///Params:
    ///    dwThreadId = 
    ///    dwType = 
    ///    riid = 
    ///    ppunk = 
    ///Returns:
    ///    This method does not return a value.
    ///    
    HRESULT GetThreadMarshalInterface(uint dwThreadId, uint dwType, const(GUID)* riid, IUnknown* ppunk);
    ///Should not be used.
    ///Params:
    ///    dwThreadId = 
    ///    pplbi = 
    ///    pdwThreadid = 
    ///Returns:
    ///    This method does not return a value.
    ///    
    HRESULT GetThreadLangBarItemMgr(uint dwThreadId, ITfLangBarItemMgr* pplbi, uint* pdwThreadid);
    ///Should not be used.
    ///Params:
    ///    dwThreadId = 
    ///    ppaip = 
    ///    pdwThreadid = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetInputProcessorProfiles(uint dwThreadId, ITfInputProcessorProfiles* ppaip, uint* pdwThreadid);
    ///Should not be used.
    ///Params:
    ///    pdwThreadId = 
    ///    fPrev = 
    ///Returns:
    ///    This method does not return a value.
    ///    
    HRESULT RestoreLastFocus(uint* pdwThreadId, BOOL fPrev);
    ///Should not be used.
    ///Params:
    ///    pSink = 
    ///    dwThreadId = Should not be used.
    ///    dwFlags = Should not be used.
    ///Returns:
    ///    This method does not return a value.
    ///    
    HRESULT SetModalInput(ITfLangBarEventSink pSink, uint dwThreadId, uint dwFlags);
    ///Configures display settings for the floating language bar.
    ///Params:
    ///    dwFlags = Specifies language bar display settings. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///              width="40%"><a id="TF_SFT_SHOWNORMAL"></a><a id="tf_sft_shownormal"></a><dl>
    ///              <dt><b>TF_SFT_SHOWNORMAL</b></dt> </dl> </td> <td width="60%"> Display the language bar as a floating window.
    ///              This constant cannot be combined with the TF_SFT_DOCK, TF_SFT_MINIMIZED, TF_SFT_HIDDEN, or TF_SFT_DESKBAND
    ///              constants. </td> </tr> <tr> <td width="40%"><a id="TF_SFT_DOCK"></a><a id="tf_sft_dock"></a><dl>
    ///              <dt><b>TF_SFT_DOCK</b></dt> </dl> </td> <td width="60%"> Deprecated as of Windows Vista. Dock the language
    ///              bar in its own task pane. This constant cannot be combined with the TF_SFT_SHOWNORMAL, TF_SFT_MINIMIZED,
    ///              TF_SFT_HIDDEN, or TF_SFT_DESKBAND constants. Available only on Windows XP. </td> </tr> <tr> <td
    ///              width="40%"><a id="TF_SFT_MINIMIZED"></a><a id="tf_sft_minimized"></a><dl> <dt><b>TF_SFT_MINIMIZED</b></dt>
    ///              </dl> </td> <td width="60%"> Deprecated as of Windows Vista. Display the language bar as a single icon in the
    ///              system tray. This constant cannot be combined with the TF_SFT_SHOWNORMAL, TF_SFT_DOCK, TF_SFT_HIDDEN, or
    ///              TF_SFT_DESKBAND constants. </td> </tr> <tr> <td width="40%"><a id="TF_SFT_HIDDEN"></a><a
    ///              id="tf_sft_hidden"></a><dl> <dt><b>TF_SFT_HIDDEN</b></dt> </dl> </td> <td width="60%"> Hide the language bar.
    ///              This constant cannot be combined with the TF_SFT_SHOWNORMAL, TF_SFT_DOCK, TF_SFT_MINIMIZED, or
    ///              TF_SFT_DESKBAND constants. </td> </tr> <tr> <td width="40%"><a id="TF_SFT_NOTRANSPARENCY"></a><a
    ///              id="tf_sft_notransparency"></a><dl> <dt><b>TF_SFT_NOTRANSPARENCY</b></dt> </dl> </td> <td width="60%"> Make
    ///              the language bar opaque. </td> </tr> <tr> <td width="40%"><a id="TF_SFT_LOWTRANSPARENCY"></a><a
    ///              id="tf_sft_lowtransparency"></a><dl> <dt><b>TF_SFT_LOWTRANSPARENCY</b></dt> </dl> </td> <td width="60%"> Make
    ///              the language bar partially transparent. Available only on Windows 2000 or later. </td> </tr> <tr> <td
    ///              width="40%"><a id="TF_SFT_HIGHTRANSPARENCY"></a><a id="tf_sft_hightransparency"></a><dl>
    ///              <dt><b>TF_SFT_HIGHTRANSPARENCY</b></dt> </dl> </td> <td width="60%"> Make the language bar highly
    ///              transparent. Available only on Windows 2000 or later. </td> </tr> <tr> <td width="40%"><a
    ///              id="TF_SFT_LABELS"></a><a id="tf_sft_labels"></a><dl> <dt><b>TF_SFT_LABELS</b></dt> </dl> </td> <td
    ///              width="60%"> Display text labels next to language bar icons. </td> </tr> <tr> <td width="40%"><a
    ///              id="TF_SFT_NOLABELS"></a><a id="tf_sft_nolabels"></a><dl> <dt><b>TF_SFT_NOLABELS</b></dt> </dl> </td> <td
    ///              width="60%"> Hide language bar icon text labels. </td> </tr> <tr> <td width="40%"><a
    ///              id="TF_SFT_EXTRAICONSONMINIMIZED"></a><a id="tf_sft_extraiconsonminimized"></a><dl>
    ///              <dt><b>TF_SFT_EXTRAICONSONMINIMIZED</b></dt> </dl> </td> <td width="60%"> Display text service icons on the
    ///              taskbar when the language bar is minimized. </td> </tr> <tr> <td width="40%"><a
    ///              id="TF_SFT_NOEXTRAICONSONMINIMIZED"></a><a id="tf_sft_noextraiconsonminimized"></a><dl>
    ///              <dt><b>TF_SFT_NOEXTRAICONSONMINIMIZED</b></dt> </dl> </td> <td width="60%"> Hide text service icons on the
    ///              taskbar when the language bar is minimized. </td> </tr> <tr> <td width="40%"><a id="TF_SFT_DESKBAND"></a><a
    ///              id="tf_sft_deskband"></a><dl> <dt><b>TF_SFT_DESKBAND</b></dt> </dl> </td> <td width="60%"> Dock the language
    ///              bar in the system task bar. This constant cannot be combined with the TF_SFT_SHOWNORMAL, TF_SFT_DOCK,
    ///              TF_SFT_MINIMIZED, or TF_SFT_HIDDEN constants. Available only on Windows XP. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>dwFlags</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT ShowFloating(uint dwFlags);
    ///Obtains current language bar display settings.
    ///Params:
    ///    pdwFlags = Indicates current language bar display settings. For a list of bitfield values, see
    ///               ITfLangBarMgr::ShowFloating.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pdwFlags</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetShowFloatingStatus(uint* pdwFlags);
}

///The <b>ITfLangBarEventSink</b> interface is implemented by an application or text service and used by the language
///bar to supply notifications of certain events that occur in the language bar. The application or text service
///installs this event sink by calling ITfLangBarMgr::AdviseEventSink.
@GUID("18A4E900-E0AE-11D2-AFDD-00105A2799B5")
interface ITfLangBarEventSink : IUnknown
{
    ///Called when the thread the event sink was installed from receives the input focus.
    ///Params:
    ///    dwThreadId = Contains the current thread identifier. This is the same value returned from GetCurrentThreadId.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnSetFocus(uint dwThreadId);
    ///Not currently used.
    ///Params:
    ///    dwThreadId = Not currently used.
    HRESULT OnThreadTerminate(uint dwThreadId);
    ///Called when a language bar item changes.
    ///Params:
    ///    dwThreadId = Contains the current thread identifier. This is the same value returned from GetCurrentThreadId.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnThreadItemChange(uint dwThreadId);
    ///Not currently used.
    ///Params:
    ///    dwThreadId = Not currently used.
    ///    uMsg = Not currently used.
    ///    wParam = Not currently used.
    ///    lParam = Not currently used.
    HRESULT OnModalInput(uint dwThreadId, uint uMsg, WPARAM wParam, LPARAM lParam);
    ///Called when [ITfLangBarMgr::ShowFloating](nf-ctfutb-itflangbarmgr-showfloating.md) is called.
    ///Params:
    ///    dwFlags = Contains the TF_SFT_* values passed to <b>ITfLangBarMgr::ShowFloating</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ShowFloating(uint dwFlags);
    ///Not currently used.
    ///Params:
    ///    dwThreadId = Not currently used.
    ///    rguid = Not currently used.
    ///    prc = Not currently used.
    HRESULT GetItemFloatingRect(uint dwThreadId, const(GUID)* rguid, RECT* prc);
}

///The <b>ITfLangBarItemSink</b> interface is implemented by the language bar and used by a language bar item provider
///to notify the language bar of changes to a language bar item. The language bar item provider obtains an instance of
///this interface when the language bar calls the provider's ITfSource::AdviseSink with identifier
///IID_ITfLangBarItemSink.
@GUID("57DBE1A0-DE25-11D2-AFDD-00105A2799B5")
interface ITfLangBarItemSink : IUnknown
{
    ///Notifies the language bar of a change in a language bar item.
    ///Params:
    ///    dwFlags = Contains a set of flags that indicate changes in the language bar item. This can be a combination of one or
    ///              more of the TF_LBI_* values.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT OnUpdate(uint dwFlags);
}

///The <b>IEnumTfLangBarItems</b> interface is implemented by the TSF manager to provide an enumeration of langauge bar
///item objects.
@GUID("583F34D0-DE25-11D2-AFDD-00105A2799B5")
interface IEnumTfLangBarItems : IUnknown
{
    ///Creates a copy of the enumerator object.
    ///Params:
    ///    ppEnum = Pointer to an IEnumTfLangBarItems interface pointer that receives the new enumerator.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    failure occurred. </td> </tr> </table>
    ///    
    HRESULT Clone(IEnumTfLangBarItems* ppEnum);
    ///Obtains the specified number of elements in the enumeration sequence from the current position.
    ///Params:
    ///    ulCount = Specifies the number of elements to obtain.
    ///    ppItem = Pointer to an array of ITfLangBarItem interface pointers that receives the requested objects. This array must
    ///             be at least <i>ulCount</i> elements in size.
    ///    pcFetched = [in, out] Pointer to a ULONG value that receives the number of elements obtained. This value can be less than
    ///                the number of items requested. This parameter can be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements could be obtained. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppItem</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT Next(uint ulCount, char* ppItem, uint* pcFetched);
    ///Resets the enumerator object by moving the current position to the beginning of the enumeration sequence.
    HRESULT Reset();
    ///Moves the current position forward in the enumeration sequence by the specified number of elements.
    ///Params:
    ///    ulCount = Contains the number of elements to skip.
    HRESULT Skip(uint ulCount);
}

///The <b>ITfLangBarItemMgr</b> interface is implemented by the language bar and used by a text service to manage items
///in the language bar. A text service obtains an instance of this interface by calling ITfThreadMgr::QueryInterface
///with IID_ITfLangBarItemMgr. An instance of this interface can also be created by calling CoCreateInstance with
///CLSID_TF_LangBarItemMgr.
@GUID("BA468C55-9956-4FB1-A59D-52A7DD7CC6AA")
interface ITfLangBarItemMgr : IUnknown
{
    ///Obtains an enumerator that contains the items in the language bar.
    ///Params:
    ///    ppEnum = Pointer to an IEnumTfLangBarItems interface pointer that receives the enumerator object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>ppEnum</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> A memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT EnumItems(IEnumTfLangBarItems* ppEnum);
    ///Obtains the ITfLangBarItem interface for an item in the language bar.
    ///Params:
    ///    rguid = GUID that identifies the item to obtain. This is the item GUID that the item supplies in
    ///            ITfLangBarItem::GetInfo. This identifier can be a custom value or one of the predefined language bar items.
    ///    ppItem = Pointer to an ITfLangBarItem interface pointer that receives the item interface.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The item cannot be found.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>ppItem</i> parameter is invalid. </td> </tr> </table>
    ///    
    HRESULT GetItem(const(GUID)* rguid, ITfLangBarItem* ppItem);
    ///Adds an item to the language bar.
    ///Params:
    ///    punk = Pointer to the ITfLangBarItem object to add to the language bar.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>punk</i>
    ///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    A memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT AddItem(ITfLangBarItem punk);
    ///Removes an item from the language bar.
    ///Params:
    ///    punk = Pointer to the ITfLangBarItem object to remove from the language bar. The language bar will call
    ///           ITfLangBarItem::GetInfo and use the item <b>GUID</b> to identify the item to remove.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>punk</i>
    ///    is invalid. </td> </tr> </table>
    ///    
    HRESULT RemoveItem(ITfLangBarItem punk);
    ///Installs a language bar item event sink for a language bar item.
    ///Params:
    ///    punk = Pointer to the ITfLangBarItemSink object to install.
    ///    pdwCookie = Pointer to a <b>DWORD</b> that receives an advise sink identification cookie. This cookie identifies the
    ///                advise sink when it is removed with the ITfLangBarItemMgr::UnadviseItemSink or
    ///                ITfLangBarItemMgr::UnadviseItemsSink method.
    ///    rguidItem = Contains the <b>GUID</b> that identifies the item to install the advise sink for. This is the item
    ///                <b>GUID</b> that the item supplies in ITfLangBarItem::GetInfo. This can be a custom value or one of the
    ///                predefined language bar items.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>rguidItem</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> A memory allocation failure occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>punk</i> and/or <i>pdwCookie</i> is invalid. </td>
    ///    </tr> </table>
    ///    
    HRESULT AdviseItemSink(ITfLangBarItemSink punk, uint* pdwCookie, const(GUID)* rguidItem);
    ///Removes a language bar item event sink.
    ///Params:
    ///    dwCookie = Contains a <i>DWORD</i> that identifies the advise sink to remove. This cookie is obtained when the advise
    ///               sink is installed with ITfLangBarItemMgr::AdviseItemSink or ITfLangBarItemMgr::AdviseItemsSink.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT UnadviseItemSink(uint dwCookie);
    ///Obtains the bounding rectangle of an item on the language bar.
    ///Params:
    ///    dwThreadId = Not currently used. Must be zero.
    ///    rguid = Contains the <b>GUID</b> that identifies the item to obtain the bounding rectangle for. This is the item
    ///            <b>GUID</b> that the item supplies in ITfLangBarItem::GetInfo. This can be a custom value or one of the
    ///            predefined language bar items.
    ///    prc = Pointer to a <b>RECT</b> structure that receives the bounding rectangle in screen coordinates.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>prc</i>
    ///    is invalid. </td> </tr> </table>
    ///    
    HRESULT GetItemFloatingRect(uint dwThreadId, const(GUID)* rguid, RECT* prc);
    ///Obtains the status of one or more items on the language bar.
    ///Params:
    ///    ulCount = Specifies the number of items to obtain the status for.
    ///    prgguid = Pointer to an array of <b>GUID</b>s that identify the items obtain the status for. These are the item
    ///              <b>GUID</b>s that the item supplies in ITfLangBarItem::GetInfo. This array must be at least <i>ulCount</i>
    ///              elements in length.
    ///    pdwStatus = Pointer to an array of <b>DWORD</b> values that receive the status of each item. Each element in this array
    ///                receives zero or a combination of one or more of the TF_LBI_STATUS_* values. This array must be at least
    ///                <i>ulCount</i> elements in length. The index of each status value cooresponds to the index of the item
    ///                identifier in <i>prgguid</i>. For example, the element 0 in <i>pdwStatus</i> receives the for the item
    ///                identified by element 0 of <i>prgguid</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetItemsStatus(uint ulCount, char* prgguid, char* pdwStatus);
    ///Obtains the number of items in the language bar.
    ///Params:
    ///    pulCount = Pointer to a <b>ULONG</b> that receives the number of items in the language bar.
    HRESULT GetItemNum(uint* pulCount);
    ///Obtains the interface, information and status for one or more items in the language bar.
    ///Params:
    ///    ulCount = Specifies the number of items to obtain the status for.
    ///    ppItem = Pointer to an array of ITfLangBarItem interface pointers that receive the item interfaces. This array must be
    ///             at least <i>ulCount</i> elements in length.
    ///    pInfo = [in, out] Pointer to an array of TF_LANGBARITEMINFO structures that receive the information for each item.
    ///            This array must be at least <i>ulCount</i> elements in length.
    ///    pdwStatus = [in, out] Pointer to an array of <b>DWORD</b> values that receive the status of each item. Each element in
    ///                this array receives zero or a combination of one or more of the TF_LBI_STATUS_* values. This array must be at
    ///                least <i>ulCount</i> elements in length.
    ///    pcFetched = [in, out] Pointer to a ULONG that receives the number of items obtained by this method. This parameter can be
    ///                <b>NULL</b> if this information is not required.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The number of items obtained
    ///    is less than the number of items requested. If <i>pcFetched</i> is not <b>NULL</b>, <i>pcFetched</i> receives
    ///    the number of items obtained. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetItems(uint ulCount, char* ppItem, char* pInfo, char* pdwStatus, uint* pcFetched);
    ///Installs one or more language bar item event sinks for one or more language bar items.
    ///Params:
    ///    ulCount = Contains the number of advise sinks to install.
    ///    ppunk = Pointer to an array of ITfLangBarItemSink objects to install. This array must be at least <i>ulCount</i>
    ///            elements in length.
    ///    pguidItem = Pointer to an array of <b>GUID</b>s that identify the items to install the advise sinks for. These are the
    ///                item <b>GUID</b>s that the item supplies in ITfLangBarItem::GetInfo. This array must be at least
    ///                <i>ulCount</i> elements in length.
    ///    pdwCookie = Pointer to an array of <b>DWORD</b>s that receive the cooresponding advise sink identification cookies. These
    ///                cookies identify the advise sinks when they are removed with the ITfLangBarItemMgr::UnadviseItemSink or
    ///                ITfLangBarItemMgr::UnadviseItemsSink method. This array must be at least <i>ulCount</i> elements in length.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT AdviseItemsSink(uint ulCount, char* ppunk, char* pguidItem, char* pdwCookie);
    ///Removes one or more language bar item event sinks.
    ///Params:
    ///    ulCount = Contains the number of advise sinks to install.
    ///    pdwCookie = Pointer to an array of <b>DWORD</b>s that identify the advise sinks to remove. These cookies are obtained
    ///                when the advise sinks are installed with ITfLangBarItemMgr::AdviseItemSink or
    ///                ITfLangBarItemMgr::AdviseItemsSink. This array must be at least <i>ulCount</i> elements in length.
    ///Returns:
    ///    This method has no return values.
    ///    
    HRESULT UnadviseItemsSink(uint ulCount, char* pdwCookie);
}

///The <b>ITfLangBarItem</b> interface is implemented by a language bar item provider and used by the language bar
///manager to obtain detailed information about the language bar item. An instance of this interface is provided to the
///language bar manager by the ITfLangBarItemMgr::AddItem method.
@GUID("73540D69-EDEB-4EE9-96C9-23AA30B25916")
interface ITfLangBarItem : IUnknown
{
    ///Obtains information about the language bar item.
    ///Params:
    ///    pInfo = Pointer to a TF_LANGBARITEMINFO structure that receives the language bar item information.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pInfo</i> is invalid.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetInfo(TF_LANGBARITEMINFO* pInfo);
    ///Obtains the status of a language bar item.
    ///Params:
    ///    pdwStatus = Pointer to a <b>DWORD</b> that receives zero or a combination of one or more of the TF_LBI_STATUS_* values
    ///                that indicate the current status of the item.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pdwStatus</i> is
    ///    invalid. </td> </tr> </table>
    ///    
    HRESULT GetStatus(uint* pdwStatus);
    ///Called to show or hide the language bar item.
    ///Params:
    ///    fShow = Contains a <b>BOOL</b> that indicates if the item should be shown or hidden. Contains a nonzero value if the
    ///            item should be shown or zero otherwise.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The language bar item does
    ///    not support this method. </td> </tr> </table>
    ///    
    HRESULT Show(BOOL fShow);
    ///Obtains the text to be displayed in the tooltip for the language bar item.
    ///Params:
    ///    pbstrToolTip = Pointer to a <b>BSTR</b> value that receives the tooltip string for the language bar item. This string must
    ///                   be allocated using the SysAllocString function. The caller must free this buffer when it is no longer
    ///                   required by calling SysFreeString.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pbstrToolTip</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The
    ///    language bar item does not support tooltip text. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation failure occurred. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetTooltipString(BSTR* pbstrToolTip);
}

///The <b>ITfSystemLangBarItemSink</b> interface is implemented by a system language bar menu extension and used by a
///system language bar menu (host) to allow menu items to be added to an existing system language bar menu. The
///extension obtains an instance of this interface by calling QueryInterface on the ITfLangBarItem object with
///IID_ITfSystemLangBarItemSink. It can then pass the object to the host by calling ITfSource::AdviseSink.
@GUID("1449D9AB-13CF-4687-AA3E-8D8B18574396")
interface ITfSystemLangBarItemSink : IUnknown
{
    ///Called to allow a system language bar item extension to add items to a system language bar menu.
    ///Params:
    ///    pMenu = Pointer to an ITfMenu interface that the system language bar item uses to add items to the system language
    ///            bar menu.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT InitMenu(ITfMenu pMenu);
    ///Called when the user selects an item in the system menu added by the system language bar menu extension.
    ///Params:
    ///    wID = Specifies the identifier of the menu item selected. This is the value passed for <i>uId</i> in
    ///          ITfMenu::AddMenuItem.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT OnMenuSelect(uint wID);
}

///The <b>ITfSystemLangBarItem</b> interface is implemented by a system language bar menu and is used by a system
///language bar extension to modify the icon and/or tooltip string displayed for the menu. The extension can obtain an
///instance of this interface by by calling QueryInterface on the ITfLangBarItem object with IID_ITfSystemLangBarItem.
@GUID("1E13E9EC-6B33-4D4A-B5EB-8A92F029F356")
interface ITfSystemLangBarItem : IUnknown
{
    ///Modifies the icon displayed for the system language bar menu.
    ///Params:
    ///    hIcon = Contains the handle to the new icon.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The system language bar
    ///    menu does not allow its icon to be modified. </td> </tr> </table>
    ///    
    HRESULT SetIcon(HICON hIcon);
    ///Modifies the tooltip text displayed for the system language bar menu.
    ///Params:
    ///    pchToolTip = A string that appears as a tooltip.
    ///    cch = Size, in characters, of the string.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The tooltip string for the
    ///    system language bar menu cannot be modified. </td> </tr> </table>
    ///    
    HRESULT SetTooltipString(char* pchToolTip, uint cch);
}

///The <b>ITfSystemLangBarItemText</b> interface is implemented by a system language bar and is used by a system
///language bar extension to modify the description displayed for the menu. The extension can obtain an instance of this
///interface by calling the menu object QueryInterface method with IID_ITfSystemLangBarItem.
@GUID("5C4CE0E5-BA49-4B52-AC6B-3B397B4F701F")
interface ITfSystemLangBarItemText : IUnknown
{
    ///The <b>ITfSystemLangBarItemText::SetItemText</b> method modifies the text displayed for the system language bar
    ///menu.
    ///Params:
    ///    pch = [in] A string that appears as a description.
    ///    cch = [in] Size, in characters, of the string.
    HRESULT SetItemText(const(wchar)* pch, uint cch);
    ///The <b>ITfSystemLangBarItemText::GetItemText</b> method obtains the text displayed for the system language bar
    ///menu.
    ///Params:
    ///    pbstrText = [out] A pointer to BSTR that contains the current description.
    HRESULT GetItemText(BSTR* pbstrText);
}

///The <b>ITfSystemDeviceTypeLangBarItem</b> interface is implemented by a system language bar item and used by an
///application or text service to control how the system item displays its icon. The application or text service obtains
///an instance of this interface by calling QueryInterface on the ITfLangBarItem object with
///IID_ITfSystemDeviceTypeLangBarItem.
@GUID("45672EB9-9059-46A2-838D-4530355F6A77")
interface ITfSystemDeviceTypeLangBarItem : IUnknown
{
    ///Modifies the type of icon displayed for a system language bar item.
    ///Params:
    ///    dwFlags = Specifies how the system language bar item should display the icon. This can be one of the following values.
    ///              <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt>
    ///              </dl> </td> <td width="60%"> The system language bar item should display a default icon for the item. </td>
    ///              </tr> <tr> <td width="40%"><a id="TF_DTLBI_USEPROFILEICON"></a><a id="tf_dtlbi_useprofileicon"></a><dl>
    ///              <dt><b>TF_DTLBI_USEPROFILEICON</b></dt> </dl> </td> <td width="60%"> The system language bar item should
    ///              display the icon specified for the language profile. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The system language bar
    ///    item does not support this method. </td> </tr> </table>
    ///    
    HRESULT SetIconMode(uint dwFlags);
    ///Obtains the current icon display mode for a system language bar item.
    ///Params:
    ///    pdwFlags = Pointer to a <b>DWORD</b> that receives the current icon display mode for a system language bar item. For
    ///               more information about possible values, see the dwFlags parameter in
    ///               ITfSystemDeviceTypeLangBarItem::SetIconMode.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The system language bar
    ///    item does not support this method. </td> </tr> </table>
    ///    
    HRESULT GetIconMode(uint* pdwFlags);
}

///The <b>ITfLangBarItemButton</b> interface is implemented by a language bar button provider and used by the language
///bar manager to obtain information about a button item on the language bar. The language bar manager obtains an
///instance of this interface by calling QueryInterface on the ITfLangBarItem passed to ITfLangBarItemMgr::AddItem.
@GUID("28C7F1D0-DE25-11D2-AFDD-00105A2799B5")
interface ITfLangBarItemButton : ITfLangBarItem
{
    ///This method is not used if the button item does not have the TF_LBI_STYLE_BTN_BUTTON style.
    ///Params:
    ///    click = Contains one of the TfLBIClick values that indicate which mouse button was used to click the button.
    ///    pt = Pointer to a POINT structure that contains the position of the mouse cursor, in screen coordinates, at the
    ///         time of the click event.
    ///    prcArea = Pointer to a RECT structure that contains the bounding rectangle, in screen coordinates, of the button.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> </table>
    ///    
    HRESULT OnClick(TfLBIClick click, POINT pt, const(RECT)* prcArea);
    ///This method is not used if the button item does not have the TF_LBI_STYLE_BTN_MENU style.
    ///Params:
    ///    pMenu = Pointer to an ITfMenu interface that the language bar button uses to add items to the menu that the language
    ///            bar displays for the button.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT InitMenu(ITfMenu pMenu);
    ///This method is not used if the button item does not have the TF_LBI_STYLE_BTN_MENU style.
    ///Params:
    ///    wID = Specifies the identifier of the menu item selected. This is the value passed for the <i>uId</i> parameter in
    ///          ITfMenu::AddMenuItem.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT OnMenuSelect(uint wID);
    ///Obtains the icon to be displayed for the language bar button.
    ///Params:
    ///    phIcon = Pointer to an <b>HICON</b> value that receives the icon handle. Receives <b>NULL</b> if the button has no
    ///             icon. The caller must free this icon when it is no longer required by calling <b>DestroyIcon</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>phIcon</i> is
    ///    invalid. </td> </tr> </table>
    ///    
    HRESULT GetIcon(HICON* phIcon);
    ///Obtains the text to be displayed for the button in the language bar.
    ///Params:
    ///    pbstrText = Pointer to a <b>BSTR</b> that receives the string for the language bar item. This string must be allocated
    ///                using the SysAllocString function. The caller must free this buffer when it is no longer required by calling
    ///                SysFreeString.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pbstrText</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A
    ///    memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT GetText(BSTR* pbstrText);
}

///The <b>ITfLangBarItemBitmapButton</b> interface is implemented by a language bar bitmap button provider and is used
///by the language bar manager to obtain information specific to a bitmap button item on the language bar. The language
///bar manager obtains an instance of this interface by calling QueryInterface on the ITfLangBarItem passed to
///ITfLangBarItemMgr::AddItem with IID_ITfLangBarItemBitmapButton.
@GUID("A26A0525-3FAE-4FA0-89EE-88A964F9F1B5")
interface ITfLangBarItemBitmapButton : ITfLangBarItem
{
    ///This method is not used if the button item does not have the TF_LBI_STYLE_BTN_BUTTON style.
    ///Params:
    ///    click = Contains a TfLBIClick value that indicates which mouse button was used to click the button.
    ///    pt = Pointer to a POINT structure that contains the position, in screen coordinates, of the mouse cursor at the
    ///         time of the click event.
    ///    prcArea = Pointer to a RECT structure that contains the bounding rectangle, in screen coordinates, of the button.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> </table>
    ///    
    HRESULT OnClick(TfLBIClick click, POINT pt, const(RECT)* prcArea);
    ///This method is not used if the button item does not have the TF_LBI_STYLE_BTN_MENU style.
    ///Params:
    ///    pMenu = Pointer to an ITfMenu interface that the language bar bitmap button uses to add items to the menu that the
    ///            language bar displays for the button.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT InitMenu(ITfMenu pMenu);
    ///This method is not used if the button item does not have the TF_LBI_STYLE_BTN_MENU style.
    ///Params:
    ///    wID = Specifies the identifier of the menu item selected. This is the value passed for <i>uId</i> in
    ///          ITfMenu::AddMenuItem.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT OnMenuSelect(uint wID);
    ///Obtains the preferred size, in pixels, of the bitmap.
    ///Params:
    ///    pszDefault = Pointer to a SIZE structure that contains the default size, in pixels, of the bitmap.
    ///    psz = Pointer to a SIZE structure that recevies the preferred size, in pixels, of the bitmap. The <b>cy</b> member
    ///          of this structure is ignored.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetPreferredSize(const(SIZE)* pszDefault, SIZE* psz);
    ///Obtains the bitmap and mask for the bitmap button item.
    ///Params:
    ///    bmWidth = Contains the width, in pixels, of the bitmap button item.
    ///    bmHeight = Contains the height, in pixels, of the bitmap button item.
    ///    dwFlags = Not currently used.
    ///    phbmp = Pointer to an <b>HBITMAP</b> value that receives the handle of the bitmap drawn for the bitmap item.
    ///    phbmpMask = Pointer to an <b>HBITMAP</b> value that receives the handle of the mask bitmap. This is a monochrome bitmap
    ///                that functions as a mask for <i>phbmp</i>. Each black pixel in this bitmap will cause the cooresponding pixel
    ///                in <i>phbmp</i> to be displayed in its normal color. Each white pixel in this bitmap will cause the
    ///                cooresponding pixel in <i>phbmp</i> to be displayed in the inverse of its normal color. To display the bitmap
    ///                without color conversion, create a monochrome bitmap the same size as <i>phbmp</i> and set each pixel to
    ///                black (RGB(0, 0, 0)).
    HRESULT DrawBitmap(int bmWidth, int bmHeight, uint dwFlags, HBITMAP* phbmp, HBITMAP* phbmpMask);
    ///Obtains the text to be displayed for the bitmap button in the language bar.
    ///Params:
    ///    pbstrText = Pointer to a <b>BSTR</b> value that receives the string for the language bar item. This string must be
    ///                allocated using the SysAllocString function. The caller must free this buffer when it is no longer required
    ///                by calling SysFreeString.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pbstrText</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A
    ///    memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT GetText(BSTR* pbstrText);
}

///The <b>ITfLangBarItemBitmap</b> interface is implemented by an application or text service and used by the language
///bar manager to obtain information specific to a bitmap item on the language bar. The language bar manager obtains an
///instance of this interface by calling QueryInterface on the ITfLangBarItem passed to ITfLangBarItemMgr::AddItem with
///IID_ITfLangBarItemBitmap.
@GUID("73830352-D722-4179-ADA5-F045C98DF355")
interface ITfLangBarItemBitmap : ITfLangBarItem
{
    ///Not currently used.
    ///Params:
    ///    click = Contains one of the TfLBIClick values that indicate which mouse button was used to click the bitmap.
    ///    pt = Pointer to a POINT structure that contains the position of the mouse cursor, in screen coordinates, at the
    ///         time of the click event.
    ///    prcArea = Pointer to a RECT structure that contains the bounding rectangle, in screen coordinates, of the bitmap.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> </table>
    ///    
    HRESULT OnClick(TfLBIClick click, POINT pt, const(RECT)* prcArea);
    ///Obtains the preferred size, in pixels, of the bitmap.
    ///Params:
    ///    pszDefault = Pointer to a SIZE structure that contains the default size, in pixels, of the bitmap.
    ///    psz = Pointer to a <b>SIZE</b> structure that receives the preferred size, in pixels, of the bitmap. The <b>cy</b>
    ///          member of this structure is ignored.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetPreferredSize(const(SIZE)* pszDefault, SIZE* psz);
    ///Obtains the bitmap and mask for the bitmap item.
    ///Params:
    ///    bmWidth = Contains the width, in pixels, of the bitmap item.
    ///    bmHeight = Contains the height, in pixels, of the bitmap item.
    ///    dwFlags = Not currently used.
    ///    phbmp = Pointer to an <i>HBITMAP</i> value that receives the handle of the bitmap drawn for the bitmap item.
    ///    phbmpMask = Pointer to an <b>HBITMAP</b> value that receives the handle of the mask bitmap. This is a monochrome bitmap
    ///                that functions as a mask for <i>phbmp</i>. Each black pixel in this bitmap will cause the cooresponding pixel
    ///                in <i>phbmp</i> to be displayed in its normal color. Every white pixel in this bitmap will cause the
    ///                cooresponding pixel in <i>phbmp</i> to be displayed in the inverse of its normal color. To display the bitmap
    ///                without any color conversion, create a monochrome bitmap the same size as <i>phbmp</i> and set each pixel to
    ///                black (RGB(0, 0, 0)).
    HRESULT DrawBitmap(int bmWidth, int bmHeight, uint dwFlags, HBITMAP* phbmp, HBITMAP* phbmpMask);
}

///The <b>ITfLangBarItemBalloon</b> interface is implemented by an application or text service and is used by the
///language bar manager to obtain information specific to a balloon item on the language bar. The language bar manager
///obtains an instance of this interface by calling QueryInterface on the ITfLangBarItem passed to
///ITfLangBarItemMgr::AddItem with IID_ITfLangBarItemBalloon.
@GUID("01C2D285-D3C7-4B7B-B5B5-D97411D0C283")
interface ITfLangBarItemBalloon : ITfLangBarItem
{
    ///Not currently used.
    ///Params:
    ///    click = Contains one of the TfLBIClick values that indicate which mouse button was used to click the balloon.
    ///    pt = Pointer to a POINT structure that contains the position of the mouse cursor, in screen coordinates, at the
    ///         time of the click event.
    ///    prcArea = Pointer to a RECT structure that contains the bounding rectangle, in screen coordinates, of the balloon.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> </table>
    ///    
    HRESULT OnClick(TfLBIClick click, POINT pt, const(RECT)* prcArea);
    ///Obtains the preferred size,in pixels, of the balloon.
    ///Params:
    ///    pszDefault = Pointer to a SIZE structure that contains the default size, in pixels, of the balloon.
    ///    psz = Pointer to a <b>SIZE</b> structure that recevies the preferred balloon size, in pixels. The <b>cy</b> member
    ///          of this structure is ignored.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetPreferredSize(const(SIZE)* pszDefault, SIZE* psz);
    ///Obtains information about the balloon.
    ///Params:
    ///    pInfo = Pointer to a TF_LBBALLOONINFO structure that receives the information about the balloon.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pInfo</i> is invalid.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetBalloonInfo(TF_LBBALLOONINFO* pInfo);
}

///The <b>ITfMenu</b> interface is implemented by the language bar and used by a language bar button provider to add
///items to the menu that the language bar will display for the button.
@GUID("6F8A98E4-AAA0-4F15-8C5B-07E0DF0A3DD8")
interface ITfMenu : IUnknown
{
    ///Adds an item to the menu that the language bar will display for the button.
    ///Params:
    ///    uId = Contains the menu item identifier.
    ///    dwFlags = Contains zero or a combination of one or more of the TF_LBMENUF_* values that specify the type and state of
    ///              the menu item.
    ///    hbmp = Contains the handle of the bitmap drawn for the menu item. If this is <b>NULL</b>, no bitmap is displayed for
    ///           the menu item.
    ///    hbmpMask = Contains the handle of the mask bitmap. This is a monochrome bitmap that functions as a mask for <i>hbmp</i>.
    ///               Each black pixel in this bitmap will cause the corresponding pixel in <i>hbmp</i> to be displayed in its
    ///               normal color. Each white pixel in this bitmap will cause the corresponding pixel in <i>hbmp</i> to be
    ///               displayed in the inverse of its normal color. To have the bitmap displayed without any color conversion,
    ///               create a monochrome bitmap the same size as <i>hbmp</i> and set each pixel to black (RGB(0, 0, 0)). If
    ///               <i>hbmp</i> is <b>NULL</b>, this parameter is ignored.
    ///    pch = Pointer to a <b>WCHAR</b> buffer that contains the text to be displayed for the menu item. The length of the
    ///          text is specified by <i>cch</i>.
    ///    cch = Specifies the length, in <b>WCHAR</b>, of the menu item text in <i>pch</i>.
    ///    ppMenu = [in, out] Pointer to an ITfMenu interface pointer that receives the submenu object. This parameter is not
    ///             used and must be <b>NULL</b> if <i>dwFlags</i> does not contain <b>TF_LBMENUF_SUBMENU</b>. If the submenu
    ///             item is successfully created, this parameter receives an ITfMenu object that the caller uses to add items to
    ///             the submenu. If <i>dwFlags</i> contains <b>TF_LBMENUF_SUBMENU</b>, this value must be initialized to
    ///             <b>NULL</b> prior to calling this method because, in most cases, this is a marshalled call. Not initializing
    ///             this variable results in the marshaller attempting to access random memory.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory
    ///    allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT AddMenuItem(uint uId, uint dwFlags, HBITMAP hbmp, HBITMAP hbmpMask, const(wchar)* pch, uint cch, 
                        ITfMenu* ppMenu);
}

///The <b>ITfThreadMgr</b> defines the primary object implemented by the TSF manager. <b>ITfThreadMgr</b> is used by
///applications and text services to activate and deactivate text services, create document managers, and maintain the
///document context focus.
@GUID("AA80E801-2021-11D2-93E0-0060B067B86E")
interface ITfThreadMgr : IUnknown
{
    ///Activates TSF for the calling thread.
    ///Params:
    ///    ptid = Pointer to a TfClientId value that receives a client identifier.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ptid</i> is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> This method
    ///    was called while the thread was deactivating. </td> </tr> </table>
    ///    
    HRESULT Activate(uint* ptid);
    ///Deactivates TSF for the calling thread.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> This method was called
    ///    while the thread was activating or this call had no corresponding ITfThreadMgr::Activate call. </td> </tr>
    ///    </table>
    ///    
    HRESULT Deactivate();
    ///Creates a document manager object.
    ///Params:
    ///    ppdim = Pointer to an ITfDocumentMgr interface that receives the document manager object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppdim</i> is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory
    ///    allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT CreateDocumentMgr(ITfDocumentMgr* ppdim);
    ///Returns an enumerator for all the document managers within the calling thread.
    ///Params:
    ///    ppEnum = Pointer to a IEnumTfDocumentMgrs interface that receives the enumerator.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppEnum</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A
    ///    memory allocation failure occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
    ///    <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT EnumDocumentMgrs(IEnumTfDocumentMgrs* ppEnum);
    ///Returns the document manager that has the input focus.
    ///Params:
    ///    ppdimFocus = Pointer to a ITfDocumentMgr interface that receives the document manager with the current input focus.
    ///                 Receives <b>NULL</b> if no document manager has the focus.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> No document manager has
    ///    focus. <i>ppdimFocus</i> be set to <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppdimFocus</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT GetFocus(ITfDocumentMgr* ppdimFocus);
    ///Sets the input focus to the specified document manager.
    ///Params:
    ///    pdimFocus = Pointer to a ITfDocumentMgr interface that receives the input focus. This parameter cannot be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pdimFocus</i> is
    ///    invalid. </td> </tr> </table>
    ///    
    HRESULT SetFocus(ITfDocumentMgr pdimFocus);
    ///Associates the focus for a window with a document manager object.
    ///Params:
    ///    hwnd = Handle of the window to associate the focus with.
    ///    pdimNew = Pointer to the document manager to associate the focus with. The TSF manager does not increment the object
    ///              reference count. This value can be <b>NULL</b>.
    ///    ppdimPrev = Receives the document manager previously associated with the window. Receives <b>NULL</b> if there is no
    ///                previous association. This parameter cannot be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> </table>
    ///    
    HRESULT AssociateFocus(HWND hwnd, ITfDocumentMgr pdimNew, ITfDocumentMgr* ppdimPrev);
    ///Determines if the calling thread has the TSF input focus.
    ///Params:
    ///    pfThreadFocus = Pointer to a BOOL that receives a value that indicates if the calling thread has input focus. This parameter
    ///                    receives a nonzero value if the calling thread has the focus or zero otherwise.
    HRESULT IsThreadFocus(int* pfThreadFocus);
    ///Obtains the specified function provider object.
    ///Params:
    ///    clsid = CLSID of the desired function provider. This can be the CLSID of a function provider registered for the
    ///            calling thread or one of the following predefined values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///            <tr> <td width="40%"><a id="GUID_SYSTEM_FUNCTIONPROVIDER"></a><a id="guid_system_functionprovider"></a><dl>
    ///            <dt><b>GUID_SYSTEM_FUNCTIONPROVIDER</b></dt> </dl> </td> <td width="60%"> Obtains the TSF system function
    ///            provider. </td> </tr> <tr> <td width="40%"><a id="GUID_APP_FUNCTIONPROVIDER"></a><a
    ///            id="guid_app_functionprovider"></a><dl> <dt><b>GUID_APP_FUNCTIONPROVIDER</b></dt> </dl> </td> <td
    ///            width="60%"> Obtains the function provider implemented by the current application. This object is not
    ///            available if the application does not register itself as a function provider. </td> </tr> </table>
    ///    ppFuncProv = Pointer to a ITfFunctionProvider interface that receives the function provider.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_NOPROVIDER</b></dt> </dl> </td> <td width="60%"> No function provider
    ///    matching <i>clsid</i> was available. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> GUID_SYSTEM_FUNCTIONPROVIDER was requested, but cannot be obtained. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetFunctionProvider(const(GUID)* clsid, ITfFunctionProvider* ppFuncProv);
    ///Obtains an enumerator for all of the function providers registered for the calling thread.
    ///Params:
    ///    ppEnum = Address of a IEnumTfFunctionProviders interface that receives the function provider enumerator.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppEnum</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A
    ///    memory allocation failure occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
    ///    <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT EnumFunctionProviders(IEnumTfFunctionProviders* ppEnum);
    ///Obtains the global compartment manager object.
    ///Params:
    ///    ppCompMgr = Pointer to a ITfCompartmentMgr interface that receives the global compartment manager.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppCompMgr</i> is
    ///    invalid. </td> </tr> </table>
    ///    
    HRESULT GetGlobalCompartment(ITfCompartmentMgr* ppCompMgr);
}

///The <b>ITfThreadMgrEx</b> interface is used by the application to activate the textservices with some flags.
///ITfThreadMgrEx can be obtained by QI from ITfThreadMgr.
@GUID("3E90ADE3-7594-4CB0-BB58-69628F5F458C")
interface ITfThreadMgrEx : ITfThreadMgr
{
    ///The <b>ITfThreadMgrEx::ActivateEx</b> method is used by an application to initialize and activate TSF for the
    ///calling thread. Unlike ITfThreadMgr::Activate, ITfThreadMgrEx::ActivateEx can take a flag to specify how TSF is
    ///activated.
    ///Params:
    ///    ptid = [out] Pointer to a TfClientId value that receives a client identifier.
    ///    dwFlags = <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TF_TMAE_NOACTIVATETIP"></a><a
    ///              id="tf_tmae_noactivatetip"></a><dl> <dt><b>TF_TMAE_NOACTIVATETIP</b></dt> </dl> </td> <td width="60%"> Text
    ///              services will not be activated while ITfThreadMgrEx::ActivateEx is called. They will be activated when the
    ///              calling thread has focus asynchronously. </td> </tr> <tr> <td width="40%"><a id="TF_TMAE_SECUREMODE"></a><a
    ///              id="tf_tmae_securemode"></a><dl> <dt><b>TF_TMAE_SECUREMODE</b></dt> </dl> </td> <td width="60%"> TSF is
    ///              activated in secure mode. Only text services that support the secure mode will be activated. </td> </tr> <tr>
    ///              <td width="40%"><a id="TF_TMAE_UIELEMENTENABLEDONLY"></a><a id="tf_tmae_uielementenabledonly"></a><dl>
    ///              <dt><b>TF_TMAE_UIELEMENTENABLEDONLY</b></dt> </dl> </td> <td width="60%"> TSF activates only text services
    ///              that are categorized in GUID_TFCAT_TIPCAP_UIELEMENTENABLED. </td> </tr> <tr> <td width="40%"><a
    ///              id="TF_TMAE_COMLESS"></a><a id="tf_tmae_comless"></a><dl> <dt><b>TF_TMAE_COMLESS</b></dt> </dl> </td> <td
    ///              width="60%"> TSF does not use COM. TSF activate only text services that are categorized in
    ///              GUID_TFCAT_TIPCAP_COMLESS. </td> </tr> <tr> <td width="40%"><a id="TF_TMAE_NOACTIVATEKEYBOARDLAYOUT"></a><a
    ///              id="tf_tmae_noactivatekeyboardlayout"></a><dl> <dt><b>TF_TMAE_NOACTIVATEKEYBOARDLAYOUT</b></dt> </dl> </td>
    ///              <td width="60%"> TSF does not sync the current keyboard layout while ITfThreadMgrEx::ActivateEx() is called.
    ///              The keyboard layout will be adjusted when the calling thread gets focus. This flag must be used with
    ///              TF_TMAE_NOACTIVATETIP. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters are invalid. </td> </tr> </table>
    ///    
    HRESULT ActivateEx(uint* ptid, uint dwFlags);
    ///The <b>ITfThreadMgrEx::GetActiveFlags</b> method returns the flags TSF is active with.
    ///Params:
    ///    lpdwFlags = The pointer to the DWORD value to receives the active flags of TSF. <table> <tr> <th>Value</th>
    ///                <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TF_TMF_NOACTIVATETIP"></a><a
    ///                id="tf_tmf_noactivatetip"></a><dl> <dt><b>TF_TMF_NOACTIVATETIP</b></dt> </dl> </td> <td width="60%"> TSF was
    ///                activated with the TF_TMAE_NOACTIVATETIP flag. </td> </tr> <tr> <td width="40%"><a
    ///                id="TF_TMF_SECUREMODE"></a><a id="tf_tmf_securemode"></a><dl> <dt><b>TF_TMF_SECUREMODE</b></dt> </dl> </td>
    ///                <td width="60%"> TSF is running as secure mode. </td> </tr> <tr> <td width="40%"><a
    ///                id="TF_TMF_UIELEMENTENABLEDONLY"></a><a id="tf_tmf_uielementenabledonly"></a><dl>
    ///                <dt><b>TF_TMF_UIELEMENTENABLEDONLY</b></dt> </dl> </td> <td width="60%"> TSF is running with text services
    ///                that support only UIElement. </td> </tr> <tr> <td width="40%"><a id="TF_TMF_COMLESS"></a><a
    ///                id="tf_tmf_comless"></a><dl> <dt><b>TF_TMF_COMLESS</b></dt> </dl> </td> <td width="60%"> TSF is running
    ///                without COM. </td> </tr> <tr> <td width="40%"><a id="TF_TMF_WOW16"></a><a id="tf_tmf_wow16"></a><dl>
    ///                <dt><b>TF_TMF_WOW16</b></dt> </dl> </td> <td width="60%"> TSF is running in 16bit task. </td> </tr> <tr> <td
    ///                width="40%"><a id="TF_TMF_CONSOLE"></a><a id="tf_tmf_console"></a><dl> <dt><b>TF_TMF_CONSOLE</b></dt> </dl>
    ///                </td> <td width="60%"> TSF is running for console. </td> </tr> <tr> <td width="40%"><a
    ///                id="TF_TMF_ACTIVATED"></a><a id="tf_tmf_activated"></a><dl> <dt><b>TF_TMF_ACTIVATED</b></dt> </dl> </td> <td
    ///                width="60%"> TSF is active. </td> </tr> </table>
    HRESULT GetActiveFlags(uint* lpdwFlags);
}

///The <b>ITfThreadMgr2</b> defines the primary object implemented by the TSF manager. <b>ITfThreadMgr2</b> is used by
///applications and text services to activate and deactivate text services, create document managers, and maintain the
///document context focus.
@GUID("0AB198EF-6477-4EE8-8812-6780EDB82D5E")
interface ITfThreadMgr2 : IUnknown
{
    ///Activates TSF for the calling thread.
    ///Params:
    ///    ptid = Pointer to a TfClientId value that receives a client identifier.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ptid</i> is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> This method
    ///    was called while the thread was deactivated. </td> </tr> </table>
    ///    
    HRESULT Activate(uint* ptid);
    ///Deactivates TSF for the calling thread.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> This method was called
    ///    while the thread was activated or this call had no corresponding Activate call. </td> </tr> </table>
    ///    
    HRESULT Deactivate();
    ///Creates a document manager object.
    ///Params:
    ///    ppdim = Pointer to an ITfDocumentMgr interface that receives the document manager object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppdim</i> is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory
    ///    allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT CreateDocumentMgr(ITfDocumentMgr* ppdim);
    ///Returns an enumerator for all the document managers within the calling thread.
    ///Params:
    ///    ppEnum = Pointer to a IEnumTfDocumentMgrs interface that receives the enumerator.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppEnum</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A
    ///    memory allocation failure occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
    ///    <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT EnumDocumentMgrs(IEnumTfDocumentMgrs* ppEnum);
    ///Returns the document manager that has the input focus.
    ///Params:
    ///    ppdimFocus = Pointer to a ITfDocumentMgr interface that receives the document manager with the current input focus.
    ///                 Receives <b>NULL</b> if no document manager has the focus.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> No document manager has
    ///    focus. <i>ppdimFocus</i> be set to <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppdimFocus</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT GetFocus(ITfDocumentMgr* ppdimFocus);
    ///Sets the input focus to the specified document manager.
    ///Params:
    ///    pdimFocus = Pointer to a ITfDocumentMgr interface that receives the input focus. This parameter cannot be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pdimFocus</i> is
    ///    invalid. </td> </tr> </table>
    ///    
    HRESULT SetFocus(ITfDocumentMgr pdimFocus);
    ///Determines if the calling thread has the TSF input focus.
    ///Params:
    ///    pfThreadFocus = Pointer to a BOOL that receives a value that indicates if the calling thread has input focus. This parameter
    ///                    receives a nonzero value if the calling thread has the focus or zero otherwise.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pfThreadFocus</i> is
    ///    invalid. </td> </tr> </table>
    ///    
    HRESULT IsThreadFocus(int* pfThreadFocus);
    ///Obtains the specified function provider object.
    ///Params:
    ///    clsid = CLSID of the desired function provider. This can be the CLSID of a function provider registered for the
    ///            calling thread or one of the following predefined values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///            <tr> <td width="40%"><a id="GUID_SYSTEM_FUNCTIONPROVIDER"></a><a id="guid_system_functionprovider"></a><dl>
    ///            <dt><b>GUID_SYSTEM_FUNCTIONPROVIDER</b></dt> </dl> </td> <td width="60%"> Obtains the TSF system function
    ///            provider. </td> </tr> <tr> <td width="40%"><a id="GUID_APP_FUNCTIONPROVIDER"></a><a
    ///            id="guid_app_functionprovider"></a><dl> <dt><b>GUID_APP_FUNCTIONPROVIDER</b></dt> </dl> </td> <td
    ///            width="60%"> Obtains the function provider implemented by the current application. This object is not
    ///            available if the application does not register itself as a function provider. </td> </tr> </table>
    ///    ppFuncProv = Pointer to a ITfFunctionProvider interface that receives the function provider.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_NOPROVIDER</b></dt> </dl> </td> <td width="60%"> No function provider
    ///    matching <i>clsid</i> was available. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> GUID_SYSTEM_FUNCTIONPROVIDER was requested, but cannot be obtained. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetFunctionProvider(const(GUID)* clsid, ITfFunctionProvider* ppFuncProv);
    ///Obtains an enumerator for all of the function providers registered for the calling thread.
    ///Params:
    ///    ppEnum = Address of a IEnumTfFunctionProviders interface that receives the function provider enumerator.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppEnum</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A
    ///    memory allocation failure occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
    ///    <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT EnumFunctionProviders(IEnumTfFunctionProviders* ppEnum);
    ///Obtains the global compartment manager object.
    ///Params:
    ///    ppCompMgr = Pointer to a ITfCompartmentMgr interface that receives the global compartment manager.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppCompMgr</i> is
    ///    invalid. </td> </tr> </table>
    ///    
    HRESULT GetGlobalCompartment(ITfCompartmentMgr* ppCompMgr);
    ///Initializes and activates TSF for the calling thread with a flag that specifies how TSF is activated.
    ///Params:
    ///    ptid = [out] Pointer to a TfClientId value that receives a client identifier.
    ///    dwFlags = <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TF_TMAE_NOACTIVATETIP"></a><a
    ///              id="tf_tmae_noactivatetip"></a><dl> <dt><b>TF_TMAE_NOACTIVATETIP</b></dt> </dl> </td> <td width="60%"> Text
    ///              services will not be activated while this method is called. They will be activated when the calling thread
    ///              has focus asynchronously. </td> </tr> <tr> <td width="40%"><a id="TF_TMAE_SECUREMODE"></a><a
    ///              id="tf_tmae_securemode"></a><dl> <dt><b>TF_TMAE_SECUREMODE</b></dt> </dl> </td> <td width="60%"> TSF is
    ///              activated in secure mode. Only text services that support the secure mode will be activated. </td> </tr> <tr>
    ///              <td width="40%"><a id="TF_TMAE_UIELEMENTENABLEDONLY"></a><a id="tf_tmae_uielementenabledonly"></a><dl>
    ///              <dt><b>TF_TMAE_UIELEMENTENABLEDONLY</b></dt> </dl> </td> <td width="60%"> TSF activates only text services
    ///              that are categorized in GUID_TFCAT_TIPCAP_UIELEMENTENABLED. </td> </tr> <tr> <td width="40%"><a
    ///              id="TF_TMAE_COMLESS"></a><a id="tf_tmae_comless"></a><dl> <dt><b>TF_TMAE_COMLESS</b></dt> </dl> </td> <td
    ///              width="60%"> TSF does not use COM. TSF activate only text services that are categorized in
    ///              GUID_TFCAT_TIPCAP_COMLESS. </td> </tr> <tr> <td width="40%"><a id="TF_TMAE_NOACTIVATEKEYBOARDLAYOUT"></a><a
    ///              id="tf_tmae_noactivatekeyboardlayout"></a><dl> <dt><b>TF_TMAE_NOACTIVATEKEYBOARDLAYOUT</b></dt> </dl> </td>
    ///              <td width="60%"> TSF does not sync the current keyboard layout while this method is called. The keyboard
    ///              layout will be adjusted when the calling thread gets focus. This flag must be used with
    ///              TF_TMAE_NOACTIVATETIP. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters are invalid. </td> </tr> </table>
    ///    
    HRESULT ActivateEx(uint* ptid, uint dwFlags);
    ///Gets the active flags of the calling thread.
    ///Params:
    ///    lpdwFlags = The pointer to the DWORD value to receives the active flags of TSF. <table> <tr> <th>Value</th>
    ///                <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TF_TMF_NOACTIVATETIP"></a><a
    ///                id="tf_tmf_noactivatetip"></a><dl> <dt><b>TF_TMF_NOACTIVATETIP</b></dt> </dl> </td> <td width="60%"> TSF was
    ///                activated with the TF_TMAE_NOACTIVATETIP flag. </td> </tr> <tr> <td width="40%"><a
    ///                id="TF_TMF_SECUREMODE"></a><a id="tf_tmf_securemode"></a><dl> <dt><b>TF_TMF_SECUREMODE</b></dt> </dl> </td>
    ///                <td width="60%"> TSF is running as secure mode. </td> </tr> <tr> <td width="40%"><a
    ///                id="TF_TMF_UIELEMENTENABLEDONLY"></a><a id="tf_tmf_uielementenabledonly"></a><dl>
    ///                <dt><b>TF_TMF_UIELEMENTENABLEDONLY</b></dt> </dl> </td> <td width="60%"> TSF is running with text services
    ///                that support only UIElement. </td> </tr> <tr> <td width="40%"><a id="TF_TMF_COMLESS"></a><a
    ///                id="tf_tmf_comless"></a><dl> <dt><b>TF_TMF_COMLESS</b></dt> </dl> </td> <td width="60%"> TSF is running
    ///                without COM. </td> </tr> <tr> <td width="40%"><a id="TF_TMF_WOW16"></a><a id="tf_tmf_wow16"></a><dl>
    ///                <dt><b>TF_TMF_WOW16</b></dt> </dl> </td> <td width="60%"> TSF is running in 16bit task. </td> </tr> <tr> <td
    ///                width="40%"><a id="TF_TMF_CONSOLE"></a><a id="tf_tmf_console"></a><dl> <dt><b>TF_TMF_CONSOLE</b></dt> </dl>
    ///                </td> <td width="60%"> TSF is running for console. </td> </tr> <tr> <td width="40%"><a
    ///                id="TF_TMF_IMMERSIVEMODE"></a><a id="tf_tmf_immersivemode"></a><dl> <dt><b>TF_TMF_IMMERSIVEMODE</b></dt>
    ///                </dl> </td> <td width="60%"> TSF is active in a Windows Store app. </td> </tr> <tr> <td width="40%"><a
    ///                id="TF_TMF_ACTIVATED"></a><a id="tf_tmf_activated"></a><dl> <dt><b>TF_TMF_ACTIVATED</b></dt> </dl> </td> <td
    ///                width="60%"> TSF is active. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters are invalid. </td> </tr> </table>
    ///    
    HRESULT GetActiveFlags(uint* lpdwFlags);
    ///Suspends handling keystrokes.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT SuspendKeystrokeHandling();
    ///Resumes suspended keystroke handling.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT ResumeKeystrokeHandling();
}

///The <b>ITfThreadMgrEventSink</b> interface is implemented by an application or TSF text service to receive
///notifications of certain thread manager events. Call the TSF manager ITfSource::AdviseSink with
///IID_ITfThreadMgrEventSink to install this advise sink.
@GUID("AA80E80E-2021-11D2-93E0-0060B067B86E")
interface ITfThreadMgrEventSink : IUnknown
{
    ///Called when the first context is added to the context stack
    ///Params:
    ///    pdim = Pointer to the document manager object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnInitDocumentMgr(ITfDocumentMgr pdim);
    ///Called when the last context is removed from the context stack
    ///Params:
    ///    pdim = Pointer to the document manager object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnUninitDocumentMgr(ITfDocumentMgr pdim);
    ///Called when a document view receives or loses the focus
    ///Params:
    ///    pdimFocus = Pointer to the document manager receiving the input focus. If no document is receiving the focus, this will
    ///                be <b>NULL</b>.
    ///    pdimPrevFocus = Pointer to the document manager that previously had the input focus. If no document had the focus, this will
    ///                    be <b>NULL</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnSetFocus(ITfDocumentMgr pdimFocus, ITfDocumentMgr pdimPrevFocus);
    ///Called when a context is added to the context stack
    ///Params:
    ///    pic = Pointer to the context added to the stack.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnPushContext(ITfContext pic);
    ///Called when a context is removed from the context stack
    ///Params:
    ///    pic = Pointer to the context removed from the stack.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnPopContext(ITfContext pic);
}

///The <b>ITfConfigureSystemKeystrokeFeed</b> interface is implemented by the TSF manager to enable and disable the
///processing of keystrokes. This interface is obtained by calling the TSF manager's <b>ITfThreadMgr::QueryInterface</b>
///with IID_ITfConfigureSystemKeystrokeFeed.
@GUID("0D2C969A-BC9C-437C-84EE-951C49B1A764")
interface ITfConfigureSystemKeystrokeFeed : IUnknown
{
    ///Prevents the TSF manager from processing keystrokes.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT DisableSystemKeystrokeFeed();
    ///Enables the TSF manager to process keystrokes after being disabled by DisableSystemKeystrokeFeed.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> There was no
    ///    corresponding call to DisableSystemKeystrokeFeed. </td> </tr> </table>
    ///    
    HRESULT EnableSystemKeystrokeFeed();
}

///The **IEnumTfDocumentMgrs** interface is implemented by the TSF manager to provide an enumeration of document manager
///objects.
@GUID("AA80E808-2021-11D2-93E0-0060B067B86E")
interface IEnumTfDocumentMgrs : IUnknown
{
    ///Creates a copy of the enumerator object.
    ///Params:
    ///    ppEnum = Pointer to an IEnumTfDocumentMgrs interface pointer that receives the new enumerator.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    failure occurred. </td> </tr> </table>
    ///    
    HRESULT Clone(IEnumTfDocumentMgrs* ppEnum);
    ///Obtains, from the current position, the specified number of elements in the enumeration sequence.
    ///Params:
    ///    ulCount = Specifies the number of elements to obtain.
    ///    rgDocumentMgr = Pointer to an array of ITfDocumentMgr interface pointers that receives the requested objects. This array must
    ///                    be at least <i>ulCount</i> elements in size.
    ///    pcFetched = Pointer to a ULONG value that receives the number of elements actually obtained. This value can be less than
    ///                the number of items requested. This parameter can be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements were obtained. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>rgDocumentMgr</i> is invalid. </td> </tr>
    ///    </table>
    ///    
    HRESULT Next(uint ulCount, char* rgDocumentMgr, uint* pcFetched);
    ///Resets the enumerator object by moving the current position to the beginning of the enumeration sequence.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT Reset();
    ///Moves the current position forward in the enumeration sequence by the specified number of elements.
    ///Params:
    ///    ulCount = Contains the number of elements to skip.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements could be skipped. </td> </tr> </table>
    ///    
    HRESULT Skip(uint ulCount);
}

///The <b>ITfDocumentMgr</b> interface is implemented by the TSF manager and used by an application or text service to
///create and manage text contexts. To obtain an instance of this interface call ITfThreadMgr::CreateDocumentMgr.
@GUID("AA80E7F4-2021-11D2-93E0-0060B067B86E")
interface ITfDocumentMgr : IUnknown
{
    ///Creates a context object.
    ///Params:
    ///    tidOwner = The client identifier. For an application, this value is provided by a previous call to
    ///               ITfThreadMgr::Activate. For a text service, this value is provided in the text service
    ///               ITfTextInputProcessor::Activate method.
    ///    dwFlags = Reserved, must be zero.
    ///    punk = Pointer to an object that supports the ITextStoreACP or ITfContextOwnerCompositionSink interfaces. This value
    ///           can be <b>NULL</b>.
    ///    ppic = Address of an ITfContext pointer that receives the context.
    ///    pecTextStore = Pointer to a TfEditCookie value that receives an edit cookie for the new context. This value identifies the
    ///                   context in various methods.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> A memory allocation error occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT CreateContext(uint tidOwner, uint dwFlags, IUnknown punk, ITfContext* ppic, uint* pecTextStore);
    ///Adds a context to the top of the context stack.
    ///Params:
    ///    pic = Pointer to the ITfContext object to be added to the stack. This object is obtained from a previous call to
    ///          ITfDocumentMgr::CreateContext.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pic</i> is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_STACKFULL</b></dt> </dl> </td> <td width="60%"> No space
    ///    exists on the stack for the context. The context stack has a limit of two contexts. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> This method was called during an
    ///    ITfDocumentMgr::Pop call. </td> </tr> </table>
    ///    
    HRESULT Push(ITfContext pic);
    ///Removes the context from the top of the context stack.
    ///Params:
    ///    dwFlags = If this value is 0, only the context at the top of the stack is removed. If this value is TF_POPF_ALL, all of
    ///              the contexts are removed from the stack.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The stack is empty or this
    ///    method is called without the TF_POPF_ALL flag and only a single context is on the stack. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> This method was called during
    ///    another <b>ITfDocumentMgr::Pop</b> call. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> <i>dwFlags</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT Pop(uint dwFlags);
    ///Obtains the context at the top of the context stack.
    ///Params:
    ///    ppic = Address of an ITfContext pointer that receives the context.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppic</i> is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory
    ///    allocation error occurred. </td> </tr> </table>
    ///    
    HRESULT GetTop(ITfContext* ppic);
    ///Obtains the context at the base of the context stack.
    ///Params:
    ///    ppic = Address of an ITfContext pointer that receives the context.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppic</i> is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory
    ///    allocation error occurred. </td> </tr> </table>
    ///    
    HRESULT GetBase(ITfContext* ppic);
    ///Obtains a context enumerator.
    ///Params:
    ///    ppEnum = Address of an IEnumTfContexts pointer that receives the enumerator.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%">
    ///    The enumerator cannot be initialized. </td> </tr> </table>
    ///    
    HRESULT EnumContexts(IEnumTfContexts* ppEnum);
}

///The <b>IEnumTfContexts</b> interface is implemented by the TSF manager to provide an enumeration of context objects.
@GUID("8F1A7EA6-1654-4502-A86E-B2902344D507")
interface IEnumTfContexts : IUnknown
{
    ///Creates a copy of the enumerator object.
    ///Params:
    ///    ppEnum = Pointer to an IEnumTfContexts interface pointer that receives the new enumerator.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    failure occurred. </td> </tr> </table>
    ///    
    HRESULT Clone(IEnumTfContexts* ppEnum);
    ///Obtains, from the current position, the specified number of elements in the enumeration sequence.
    ///Params:
    ///    ulCount = Specifies the number of elements to obtain.
    ///    rgContext = Pointer to an array of ITfContext interface pointers that receives the requested objects. This array must be
    ///                at least <i>ulCount</i> elements in size.
    ///    pcFetched = Pointer to a ULONG value that receives the number of elements actually obtained. This value can be less than
    ///                the number of items requested. This parameter can be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements could be obtained. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>rgContext</i> is invalid. </td> </tr>
    ///    </table>
    ///    
    HRESULT Next(uint ulCount, char* rgContext, uint* pcFetched);
    ///Resets the enumerator object by moving the current position to the beginning of the enumeration sequence.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT Reset();
    ///Moves the current position forward in the enumeration sequence by the specified number of elements.
    ///Params:
    ///    ulCount = Contains the number of elements to skip.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements could be skipped. </td> </tr> </table>
    ///    
    HRESULT Skip(uint ulCount);
}

///The <b>ITfCompositionView</b> interface is implemented by the TSF manager and used by an application to obtain data
///about a composition view. An instance of this interface is provided by one of the ITfContextOwnerCompositionSink
///methods.
@GUID("D7540241-F9A1-4364-BEFC-DBCD2C4395B7")
interface ITfCompositionView : IUnknown
{
    ///Obtains the class identifier of the text service that created the composition object.
    ///Params:
    ///    pclsid = Pointer to a CLSID that receives the class identifier of the text service that owns the composition.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>pclsid</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td
    ///    width="60%"> The composition has been terminated. </td> </tr> </table>
    ///    
    HRESULT GetOwnerClsid(GUID* pclsid);
    ///Obtains a range object that contains the text covered by the composition.
    ///Params:
    ///    ppRange = Pointer to an ITfRange interface pointer that receives the range object. It is possible that the range will
    ///              have zero length.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>ppRange</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> A memory allocation failure occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The composition has already terminated. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetRange(ITfRange* ppRange);
}

///The <b>IEnumITfCompositionView</b> interface is implemented by the TSF manager to provide an enumeration of
///composition view objects.
@GUID("5EFD22BA-7838-46CB-88E2-CADB14124F8F")
interface IEnumITfCompositionView : IUnknown
{
    ///Creates a copy of the enumerator object.
    ///Params:
    ///    ppEnum = Pointer to an IEnumITfCompositionView interface pointer that receives the new enumerator.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    failure occurred. </td> </tr> </table>
    ///    
    HRESULT Clone(IEnumITfCompositionView* ppEnum);
    ///Obtains, from the current position, the specified number of elements in the enumeration sequence.
    ///Params:
    ///    ulCount = Specifies the number of elements to obtain.
    ///    rgCompositionView = Pointer to an array of ITfCompositionView interface pointers that receives the requested objects. This array
    ///                        must be at least <i>ulCount</i> elements in size.
    ///    pcFetched = Pointer to a ULONG value that receives the number of elements obtained. This value can be less than the
    ///                number of items requested. This parameter can be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements could be obtained. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>rgCompositionView</i> is invalid. </td>
    ///    </tr> </table>
    ///    
    HRESULT Next(uint ulCount, char* rgCompositionView, uint* pcFetched);
    ///Resets the enumerator object by moving the current position to the beginning of the enumeration sequence.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT Reset();
    ///Moves the current position forward in the enumeration sequence by the specified number of elements.
    ///Params:
    ///    ulCount = Contains the number of elements to skip.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements could be skipped. </td> </tr> </table>
    ///    
    HRESULT Skip(uint ulCount);
}

///The <b>ITfComposition</b> interface is implemented by the TSF manager and is used by a text service to obtain data
///about and terminate a composition. An instance of this interface is provided by the
///ITfContextComposition::StartComposition method.
@GUID("20168D64-5A8F-4A5A-B7BD-CFA29F4D0FD9")
interface ITfComposition : IUnknown
{
    ///Obtains a range object that contains the text covered by the composition.
    ///Params:
    ///    ppRange = Pointer to an ITfRange interface pointer that receives the range object. It is possible that the range will
    ///              have zero length.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>ppRange</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> A memory allocation failure occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The composition has already terminated. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetRange(ITfRange* ppRange);
    ///Moves the start anchor of a composition.
    ///Params:
    ///    ecWrite = Contains an edit cookie that identifies the edit context obtained from ITfEditSession::DoEditSession.
    ///    pNewStart = Pointer to an ITfRange object that contains the new start anchor position. The start anchor of the context
    ///                will be moved to the start anchor of this range. This method fails if the start anchor of this range is
    ///                positioned beyond the end anchor of the composition.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The start
    ///    anchor of <i>pNewStart</i> is positioned past the end anchor of the composition or <i>pNewStart</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The
    ///    composition has already terminated. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl>
    ///    </td> <td width="60%"> The edit context identified by <i>ecWrite</i> does not have a read/write lock. </td>
    ///    </tr> </table>
    ///    
    HRESULT ShiftStart(uint ecWrite, ITfRange pNewStart);
    ///Moves the end anchor of a composition.
    ///Params:
    ///    ecWrite = Contains an edit cookie that identifies the edit context obtained from ITfEditSession::DoEditSession.
    ///    pNewEnd = Pointer to an ITfRange object that contains the new end anchor position. The end anchor of the context will
    ///              be moved to the end anchor of this range. This method fails if the end anchor of this range is positioned
    ///              prior to the start anchor of the composition.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The end
    ///    anchor of <i>pNewEnd</i> is positioned prior to the start anchor of the composition or <i>pNewStart</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The
    ///    composition has already terminated. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl>
    ///    </td> <td width="60%"> The edit context identified by <i>ecWrite</i> does not have a read/write lock. </td>
    ///    </tr> </table>
    ///    
    HRESULT ShiftEnd(uint ecWrite, ITfRange pNewEnd);
    ///Terminates a composition.
    ///Params:
    ///    ecWrite = Contains an edit cookie that identifies the edit context obtained from ITfEditSession::DoEditSession.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> This value results when:
    ///    <ul> <li>The composition terminated.</li> <li>The caller is inside another composition write operation.</li>
    ///    <li>The caller does not own the composition.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The edit context identified by <i>ecWrite</i> does
    ///    not have a read/write lock. </td> </tr> </table>
    ///    
    HRESULT EndComposition(uint ecWrite);
}

///The <b>ITfCompositionSink</b> interface is implemented by a text service to receive a notification when a composition
///is terminated. This advise sink is installed by passing a pointer to this interface when the composition is started
///with the ITfContextComposition::StartComposition method.
@GUID("A781718C-579A-4B15-A280-32B8577ACC5E")
interface ITfCompositionSink : IUnknown
{
    ///Called when a composition is terminated.
    ///Params:
    ///    ecWrite = Contains a TfEditCookie value that identifies the edit context. This is the same value passed for
    ///              <i>ecWrite</i> in the call to ITfContextComposition::StartComposition.
    ///    pComposition = Pointer to the ITfComposition object terminated.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnCompositionTerminated(uint ecWrite, ITfComposition pComposition);
}

///The <b>ITfContextComposition</b> interface is implemented by the TSF manager and is used by a text service to create
///and manipulate compositions. An instance of this interface is provided by <b>ITfContext::QueryInterface</b> with
///IID_ITfContextComposition.
@GUID("D40C8AAE-AC92-4FC7-9A11-0EE0E23AA39B")
interface ITfContextComposition : IUnknown
{
    ///Creates a new composition.
    ///Params:
    ///    ecWrite = Contains an edit cookie that identifies the edit context. This is obtained from
    ///              ITfEditSession::DoEditSession.
    ///    pCompositionRange = Pointer to an ITfRange object that specifies the text that the composition initially covers.
    ///    pSink = Pointer to an ITfCompositionSink object that receives composition event notifications. This parameter is
    ///            optional and can be <b>NULL</b>. If supplied, the object is released when the composition is terminated.
    ///    ppComposition = Pointer to an ITfComposition interface pointer that receives the new composition object. This parameter
    ///                    receives <b>NULL</b> if the context owner rejects the composition.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. If the context
    ///    owner composition advise sink rejects the composition, <i>ppComposition</i> is set to <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error
    ///    occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    One or more parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
    ///    </dl> </td> <td width="60%"> The composition object cannot be created. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method was called within another composition
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_DISCONNECTED</b></dt> </dl> </td> <td
    ///    width="60%"> The context object is not on a document stack. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The edit context identified by <i>ecWrite</i> does
    ///    not have a read/write lock. </td> </tr> </table>
    ///    
    HRESULT StartComposition(uint ecWrite, ITfRange pCompositionRange, ITfCompositionSink pSink, 
                             ITfComposition* ppComposition);
    ///Creates an enumerator object that contains all compositions in the context.
    ///Params:
    ///    ppEnum = Pointer to an IEnumITfCompositionView interface pointer that receives the enumerator object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The enumerator object could
    ///    not be initialized. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>ppEnum</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
    ///    </dl> </td> <td width="60%"> The enumerator object cannot be created. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_DISCONNECTED</b></dt> </dl> </td> <td width="60%"> The context object is not on a document stack.
    ///    </td> </tr> </table>
    ///    
    HRESULT EnumCompositions(IEnumITfCompositionView* ppEnum);
    ///Creates an enumerator object that contains all compositions that intersect a specified range of text.
    ///Params:
    ///    ecRead = Contains an edit cookie that identifies the edit context. This is obtained from
    ///             ITfEditSession::DoEditSession.
    ///    pTestRange = Pointer to an ITfRange object that specifies the range to search. This parameter can be <b>NULL</b>. If this
    ///                 parameter is <b>NULL</b>, the enumerator will contain all compositions in the edit context.
    ///    ppEnum = Pointer to an IEnumITfCompositionView interface pointer that receives the enumerator object.
    ///Returns:
    ///    <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl>
    ///    </td> <td width="60%"> The method was successful. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The enumerator object cannot be initialized. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> The enumerator object cannot be created. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_DISCONNECTED</b></dt> </dl> </td> <td width="60%"> The context object is not on a document stack.
    ///    </td> </tr> </table> The edit context identified by <i>ecRead</i> does not have a read-only lock.
    ///    
    HRESULT FindComposition(uint ecRead, ITfRange pTestRange, IEnumITfCompositionView* ppEnum);
    ///Not currently implemented.
    ///Params:
    ///    ecWrite = Not used.
    ///    pComposition = Not used.
    ///    pSink = Not used.
    ///    ppComposition = Not used.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This method is not currently
    ///    implemented. </td> </tr> </table>
    ///    
    HRESULT TakeOwnership(uint ecWrite, ITfCompositionView pComposition, ITfCompositionSink pSink, 
                          ITfComposition* ppComposition);
}

///The <b>ITfContextOwnerCompositionServices</b> interface is implemented by the TSF manager and used by a context owner
///to manipulate compositions created by a text service.
@GUID("86462810-593B-4916-9764-19C08E9CE110")
interface ITfContextOwnerCompositionServices : ITfContextComposition
{
    ///Terminates a composition.
    ///Params:
    ///    pComposition = Pointer to a ITfCompositionView interface that represents the composition to terminate. If this value is
    ///                   <b>NULL</b>, all compositions in the context are terminated.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_DISCONNECTED</b></dt> </dl> </td> <td width="60%"> The context is not
    ///    on a document stack. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td
    ///    width="60%"> A text service currently holds a lock on the document. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> This method was called during another composition
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT TerminateComposition(ITfCompositionView pComposition);
}

///The <b>ITfContextOwnerCompositionSink</b> interface is implemented by an application to receive composition-related
///notifications. When the application calls ITfDocumentMgr::CreateContext, the TSF manager queries the object for this
///interface. If the object supports this interface, the advise sink is installed.
@GUID("5F20AA40-B57A-4F34-96AB-3576F377CC79")
interface ITfContextOwnerCompositionSink : IUnknown
{
    ///Called when a composition is started.
    ///Params:
    ///    pComposition = Pointer to an ITfCompositionView object that represents the new composition.
    ///    pfOk = Pointer to a <b>BOOL</b> value that receives a value that allows or denies the new composition. Receives a
    ///           nonzero value to allow the composition or zero to deny the composition.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnStartComposition(ITfCompositionView pComposition, int* pfOk);
    ///Called when an existing composition is changed.
    ///Params:
    ///    pComposition = Pointer to an ITfCompositionView object that represents the composition updated.
    ///    pRangeNew = Pointer to an ITfRange object that contains the range of text the composition will cover after the
    ///                composition is updated.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnUpdateComposition(ITfCompositionView pComposition, ITfRange pRangeNew);
    ///Called when a composition is terminated.
    ///Params:
    ///    pComposition = Pointer to an ITfCompositionView object that represents the composition terminated.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnEndComposition(ITfCompositionView pComposition);
}

///The <b>ITfContextView</b> interface is implemented by the TSF manager and used by a client (application or text
///service) to obtain information about a context view. Clients obtain this interface by calling the
///ITfContext::GetActiveView method which returns a pointer to the <b>ITfContextView</b> object.
@GUID("2433BF8E-0F9B-435C-BA2C-180611978C30")
interface ITfContextView : IUnknown
{
    ///The <b>ITfContextView::GetRangeFromPoint</b> method converts a point, in screen coordinates, to an empty range of
    ///text positioned at a corresponding location.
    ///Params:
    ///    ec = Specifies the edit cookie with read-only access.
    ///    ppt = Specifies the point in screen coordinates.
    ///    dwFlags = Specifies the range position to return based upon the screen coordinates of the point to a character bounding
    ///              box. By default, the range position returned is the character bounding box containing the screen coordinates
    ///              of the point. If the point is outside a character bounding box, the method returns <b>NULL</b> or
    ///              TF_E_INVALIDPOINT. Other bit flags for this parameter are as follows. The bit flags can be combined. <table>
    ///              <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="GXFPF_ROUND_NEAREST"></a><a
    ///              id="gxfpf_round_nearest"></a><dl> <dt><b>GXFPF_ROUND_NEAREST</b></dt> </dl> </td> <td width="60%"> If the
    ///              screen coordinates of the point are contained in a character bounding box, the range position returned is the
    ///              bounding edge closest to the screen coordinates of the point. </td> </tr> <tr> <td width="40%"><a
    ///              id="GXFPF_NEAREST"></a><a id="gxfpf_nearest"></a><dl> <dt><b>GXFPF_NEAREST</b></dt> </dl> </td> <td
    ///              width="60%"> If the screen coordinates of the point are not contained in a character bounding box, the
    ///              closest range position is returned. </td> </tr> </table>
    ///    ppRange = Receives a pointer to the ITfRange interface.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_INVALIDPOINT</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>pptScreen</i> parameter does not cover any document text. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_NOLAYOUT</b></dt> </dl> </td> <td width="60%"> The application has not calculated a text layout.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The specified
    ///    edit cookie is invalid. </td> </tr> </table>
    ///    
    HRESULT GetRangeFromPoint(uint ec, const(POINT)* ppt, uint dwFlags, ITfRange* ppRange);
    ///The <b>ITfContextView::GetTextExt</b> method returns the bounding box, in screen coordinates, of a range of text.
    ///Params:
    ///    ec = Specifies an edit cookie with read-only access.
    ///    pRange = Specifies the range to query
    ///    prc = Receives the bounding box, in screen coordinates, of the range.
    ///    pfClipped = Receives the Boolean value that specifies if the text in the bounding box has been clipped. If this parameter
    ///                is <b>TRUE</b>, the bounding box contains clipped text and does not include the entire requested range. The
    ///                bounding box is clipped because of the requested range is not visible.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLAYOUT</b></dt> </dl> </td> <td width="60%"> The text is not
    ///    rendered or the context has not calculated the text layout. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The edit cookie parameter is invalid. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetTextExt(uint ec, ITfRange pRange, RECT* prc, int* pfClipped);
    ///The <b>ITfContextView::GetScreenExt</b> method returns the bounding box, in screen coordinates, of the document
    ///display.
    ///Params:
    ///    prc = Receives the bounding box, in screen coordinates, of the display surface.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetScreenExt(RECT* prc);
    ///The <b>ITfContextView::GetWnd</b> method returns the handle to a window that corresponds to the current document.
    ///Params:
    ///    phwnd = Receives a pointer to the handle of the window that corresponds to the current document.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetWnd(HWND* phwnd);
}

///Not implemented.
@GUID("F0C0F8DD-CF38-44E1-BB0F-68CF0D551C78")
interface IEnumTfContextViews : IUnknown
{
    HRESULT Clone(IEnumTfContextViews* ppEnum);
    HRESULT Next(uint ulCount, char* rgViews, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

///The <b>ITfContext</b> interface is implemented by the TSF manager and used by applications and text services to
///access an edit context.
@GUID("AA80E7FD-2021-11D2-93E0-0060B067B86E")
interface ITfContext : IUnknown
{
    ///Obtains access to the document text and properties.
    ///Params:
    ///    tid = Contains a TfClientId value that identifies the client to establish the edit session with.
    ///    pes = Pointer to an ITfEditSession interface called to perform the edit session.
    ///    dwFlags = Contains one or more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///              width="40%"><a id="TF_ES_ASYNCDONTCARE"></a><a id="tf_es_asyncdontcare"></a><dl>
    ///              <dt><b>TF_ES_ASYNCDONTCARE</b></dt> </dl> </td> <td width="60%"> The edit session can occur synchronously or
    ///              asynchronously, at the discretion of the TSF manager. The manager will attempt to schedule a synchronous edit
    ///              session for improved performance. This value cannot be combined with the TF_ES_ASYNC or TF_ES_SYNC values.
    ///              </td> </tr> <tr> <td width="40%"><a id="TF_ES_SYNC"></a><a id="tf_es_sync"></a><dl>
    ///              <dt><b>TF_ES_SYNC</b></dt> </dl> </td> <td width="60%"> The edit session must be synchronous or the request
    ///              will fail (with TF_E_SYNCHRONOUS). This flag should only be used in documented situations (such as keystroke
    ///              handling) where it can be expected to succeed. Otherwise the call will likely fail. This value cannot be
    ///              combined with the TF_ES_ASYNCDONTCARE or TF_ES_ASYNC values. </td> </tr> <tr> <td width="40%"><a
    ///              id="TF_ES_READ"></a><a id="tf_es_read"></a><dl> <dt><b>TF_ES_READ</b></dt> </dl> </td> <td width="60%">
    ///              Requests read-only access to the context. </td> </tr> <tr> <td width="40%"><a id="TF_ES_READWRITE"></a><a
    ///              id="tf_es_readwrite"></a><dl> <dt><b>TF_ES_READWRITE</b></dt> </dl> </td> <td width="60%"> Requests
    ///              read/write access to the context. </td> </tr> <tr> <td width="40%"><a id="TF_ES_ASYNC"></a><a
    ///              id="tf_es_async"></a><dl> <dt><b>TF_ES_ASYNC</b></dt> </dl> </td> <td width="60%"> The edit session must be
    ///              asynchronous or the request fails. This value cannot be combined with the TF_ES_ASYNCDONTCARE or TF_ES_SYNC
    ///              values. </td> </tr> </table>
    ///    phrSession = Address of an <b>HRESULT</b> value that receives the result of the edit session request. The value received
    ///                 depends upon the type of edit session requested. <ul> <li>If an asynchronous edit session is requested and
    ///                 can be established, receives TF_S_ASYNC.</li> <li>If a synchronous edit session is requested and cannot be
    ///                 established, receives TF_E_SYNCHRONOUS.</li> <li>If the TF_ES_READWRITE flag is specified and the document is
    ///                 read-only, receives TS_E_READONLY.</li> <li>If a synchronous edit session is established, receives the return
    ///                 value of the ITfEditSession::DoEditSession.</li> </ul>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful.
    ///    <i>phrSession</i> contains more result data for the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_LOCKED</b></dt> </dl> </td> <td width="60%"> The caller is within the context of another text
    ///    service which already holds a lock. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_DISCONNECTED</b></dt>
    ///    </dl> </td> <td width="60%"> The context is not on a document stack. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    failure occurred. </td> </tr> </table>
    ///    
    HRESULT RequestEditSession(uint tid, ITfEditSession pes, uint dwFlags, int* phrSession);
    ///Determines if a client has a read/write lock on the context.
    ///Params:
    ///    tid = Contains a <b>TfClientID</b> value that identifies the client.
    ///    pfWriteSession = Pointer to a <b>BOOL</b> that receives a nonzero value if the client has a read/write lock on the context.
    ///                     Receives zero if the client does not have an edit session or has a read-only edit session.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pfWriteSession</i> is
    ///    invalid. </td> </tr> </table>
    ///    
    HRESULT InWriteSession(uint tid, int* pfWriteSession);
    ///Obtains the selection within the document.
    ///Params:
    ///    ec = Contains an edit cookie that identifies the edit session. This is the value passed to
    ///         ITfEditSession::DoEditSession.
    ///    ulIndex = Specifies the zero-based index of the first selection to obtain. Use TF_DEFAULT_SELECTION to obtain the
    ///              default selection. If TF_DEFAULT_SELECTION is used, only one selection is obtained.
    ///    ulCount = Specifies the maximum number of selections to obtain.
    ///    pSelection = An array of TF_SELECTION structures that receives the data for each selection. The array must be able to hold
    ///                 at least <i>ulCount</i> elements.
    ///    pcFetched = Pointer to a ULONG value that receives the number of selections obtained.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_NOSELECTION</b></dt> </dl> </td> <td width="60%"> The document has no
    ///    selection. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%">
    ///    The cookie in <i>ec</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_DISCONNECTED</b></dt>
    ///    </dl> </td> <td width="60%"> The context is not on a document stack. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    failure occurred. </td> </tr> </table>
    ///    
    HRESULT GetSelection(uint ec, uint ulIndex, uint ulCount, char* pSelection, uint* pcFetched);
    ///Sets the selection within the document.
    ///Params:
    ///    ec = Contains an edit cookie that identifies the edit session. This is the value passed to
    ///         ITfEditSession::DoEditSession.
    ///    ulCount = Specifies the number of selections in the <i>pSelection</i> array.
    ///    pSelection = An array of TF_SELECTION structures that contain the information for each selection.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_NOSELECTION</b></dt> </dl> </td> <td width="60%"> The document has no
    ///    selection. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%">
    ///    The cookie in <i>ec</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT SetSelection(uint ec, uint ulCount, char* pSelection);
    ///Obtains a range of text positioned at the beginning of the document.
    ///Params:
    ///    ec = Contains an edit cookie that identifies the edit session. This is the value passed to
    ///         ITfEditSession::DoEditSession.
    ///    ppStart = Pointer to an ITfRange interface that receives an empty range positioned at the start of the document.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The cookie in <i>ec</i>
    ///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_DISCONNECTED</b></dt> </dl> </td> <td
    ///    width="60%"> The context is not on a document stack. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The context owner does not
    ///    implement this method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> A memory allocation failure occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetStart(uint ec, ITfRange* ppStart);
    ///Obtains a range of text positioned at the end of the document.
    ///Params:
    ///    ec = Contains an edit cookie that identifies the edit session. This is the value passed to
    ///         ITfEditSession::DoEditSession.
    ///    ppEnd = Pointer to an ITfRange interface pointer that receives an empty range positioned at the end of the document.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The cookie in <i>ec</i>
    ///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_DISCONNECTED</b></dt> </dl> </td> <td
    ///    width="60%"> The context is not on a document stack. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The context owner does not
    ///    implement this method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> A memory allocation failure occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetEnd(uint ec, ITfRange* ppEnd);
    ///Obtains the active view for the context.
    ///Params:
    ///    ppView = Pointer to an ITfContextView interface pointer that receives a reference to the active view.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_DISCONNECTED</b></dt> </dl> </td> <td width="60%"> The context is not
    ///    on a document stack. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> A memory allocation failure occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetActiveView(ITfContextView* ppView);
    HRESULT EnumViews(IEnumTfContextViews* ppEnum);
    ///Obtains the document status.
    ///Params:
    ///    pdcs = Pointer to a TF_STATUS structure that receives the document status data.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_DISCONNECTED</b></dt> </dl> </td> <td width="60%"> The context is not
    ///    on a document stack. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>pdcs</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT GetStatus(TS_STATUS* pdcs);
    ///Obtains a text property.
    ///Params:
    ///    guidProp = Specifies the property identifier. This can be a custom identifier or one of the predefined property
    ///               identifiers.
    ///    ppProp = Pointer to an ITfProperty interface pointer that receives the property object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_DISCONNECTED</b></dt> </dl> </td> <td width="60%"> The context is not
    ///    on a document stack. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation failure occurred. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetProperty(const(GUID)* guidProp, ITfProperty* ppProp);
    ///Obtains an application property.
    ///Params:
    ///    guidProp = Specifies the property identifier. This can be a custom identifier or one of the predefined property
    ///               identifiers.
    ///    ppProp = Pointer to an ITfReadOnlyProperty interface pointer that receives the property object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The context owner does not
    ///    support the property. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_DISCONNECTED</b></dt> </dl> </td>
    ///    <td width="60%"> The context is not on a document stack. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    failure occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td
    ///    width="60%"> The context owner does not implement this method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetAppProperty(const(GUID)* guidProp, ITfReadOnlyProperty* ppProp);
    ///Obtains a special property that can enumerate multiple properties over multiple ranges.
    ///Params:
    ///    prgProp = Contains an array of property identifiers that specify the properties to track.
    ///    cProp = Contains the number of property identifiers in the <i>prgProp</i> array.
    ///    prgAppProp = Contains an array of application property identifiers that specify the application properties to track.
    ///    cAppProp = Contains the number of application property identifiers in the <i>prgAppProp</i> array.
    ///    ppProperty = Pointer to an ITfReadOnlyProperty interface pointer that receives the tracking property.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_DISCONNECTED</b></dt> </dl> </td> <td width="60%"> The context object
    ///    is not on a document stack. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> A memory allocation failure occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td> </tr>
    ///    </table>
    ///    
    HRESULT TrackProperties(char* prgProp, uint cProp, char* prgAppProp, uint cAppProp, 
                            ITfReadOnlyProperty* ppProperty);
    ///Obtains a document property enumerator.
    ///Params:
    ///    ppEnum = Pointer to an IEnumTfProperties interface pointer that receives the enumerator object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_DISCONNECTED</b></dt> </dl> </td> <td width="60%"> The context object
    ///    is not on a document stack. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> A memory allocation failure occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppEnum</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT EnumProperties(IEnumTfProperties* ppEnum);
    ///Obtains the document manager that contains the context.
    ///Params:
    ///    ppDm = Pointer to an ITfDocumentMgr interface pointer that receives the document manager.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The context is not contained
    ///    in any document manager. <i>ppDm</i> is set to <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppDm</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT GetDocumentMgr(ITfDocumentMgr* ppDm);
    ///Creates a backup of a range.
    ///Params:
    ///    ec = Contains an edit cookie that identifies the edit session. This is the value passed to
    ///         ITfEditSession::DoEditSession.
    ///    pRange = Pointer to the ITfRange object to be backed up.
    ///    ppBackup = Pointer to an ITfRangeBackup interface pointer that receives the backup of <i>pRange</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The cookie in <i>ec</i>
    ///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_DISCONNECTED</b></dt> </dl> </td> <td
    ///    width="60%"> The context is not on a document stack. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    failure occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%">
    ///    An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT CreateRangeBackup(uint ec, ITfRange pRange, ITfRangeBackup* ppBackup);
}

///The <b>ITfQueryEmbedded</b> interface is implemented by the TSF manager and used by a text service to determine if a
///context can accept an embedded object.
@GUID("0FAB9BDB-D250-4169-84E5-6BE118FDD7A8")
interface ITfQueryEmbedded : IUnknown
{
    ///Determines if the active context can accept an embedded object.
    ///Params:
    ///    pguidService = A GUID that identifies the service associated with the object. This value can be <b>NULL</b> if
    ///                   <i>pFormatEtc</i> is valid.
    ///    pFormatEtc = Pointer to a FORMATETC structure that contains data about the object to be embedded. This value can be
    ///                 <b>NULL</b> if <i>pguidService</i> is valid.
    ///    pfInsertable = Pointer to a Boolean value that receives the query result. This value receives a nonzero value if the object
    ///                   can be embedded, or zero otherwise.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_DISCONNECTED</b></dt> </dl> </td> <td
    ///    width="60%"> There is no active context. </td> </tr> </table>
    ///    
    HRESULT QueryInsertEmbedded(const(GUID)* pguidService, const(FORMATETC)* pFormatEtc, int* pfInsertable);
}

///The <b>ITfInsertAtSelection</b> interface is implemented by the manager and is used by a text service to insert text
///or an embedded object in a context. The text service obtains this interface by calling ITfContext::QueryInterface.
@GUID("55CE16BA-3014-41C1-9CEB-FADE1446AC6C")
interface ITfInsertAtSelection : IUnknown
{
    ///Inserts text at the selection or insertion point.
    ///Params:
    ///    ec = Identifies the edit context. This is obtained from ITfDocumentMgr::CreateContext or
    ///         ITfEditSession::DoEditSession.
    ///    dwFlags = Bit field with one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///              width="40%"><a id="TF_IAS_NOQUERY"></a><a id="tf_ias_noquery"></a><dl> <dt><b>TF_IAS_NOQUERY</b></dt> </dl>
    ///              </td> <td width="60%"> <i>ppRange</i> is <b>NULL</b>. This flag cannot be combined with the TF_IAS_QUERYONLY
    ///              flag. </td> </tr> <tr> <td width="40%"><a id="TF_IAS_QUERYONLY"></a><a id="tf_ias_queryonly"></a><dl>
    ///              <dt><b>TF_IAS_QUERYONLY</b></dt> </dl> </td> <td width="60%"> The context is not modified, but <i>ppRange</i>
    ///              is set as if the insert had occurred. Read-only access is sufficient. If this flag is not set, <i>ec</i> must
    ///              have read/write access. This flag cannot be combined with the TF_IAS_NOQUERY flag. </td> </tr> <tr> <td
    ///              width="40%"><a id="TF_IAS_NO_DEFAULT_COMPOSITION"></a><a id="tf_ias_no_default_composition"></a><dl>
    ///              <dt><b>TF_IAS_NO_DEFAULT_COMPOSITION</b></dt> </dl> </td> <td width="60%"> The manager will not create a
    ///              default composition if a composition is required. The caller must create a composition object that covers the
    ///              inserted text before releasing the context lock. </td> </tr> </table>
    ///    pchText = Specifies the text to insert.
    ///    cch = Specifies the character count of the text in <i>pchText</i>.
    ///    ppRange = Receives the position of the inserted object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The text service does not
    ///    have a document lock </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_DISCONNECTED</b></dt> </dl> </td> <td
    ///    width="60%"> Context object is not on a document stack. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_NOSELECTION</b></dt> </dl> </td> <td width="60%"> Context has no selection. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TS_E_READONLY</b></dt> </dl> </td> <td width="60%"> Selection is read-only. </td>
    ///    </tr> </table>
    ///    
    HRESULT InsertTextAtSelection(uint ec, uint dwFlags, const(wchar)* pchText, int cch, ITfRange* ppRange);
    ///The <b>ITfInsertAtSelection::InsertEmbeddedAtSelection</b> method inserts an IDataObject object at the selection
    ///or insertion point.
    ///Params:
    ///    ec = Identifies the edit context. This is obtained from ITfDocumentMgr::CreateContext or
    ///         ITfEditSession::DoEditSession.
    ///    dwFlags = Bit field with one of the following values: TF_IAS_NOQUERY The <i>ppRange</i> parameter is <b>NULL</b> on
    ///              exit. TF_IAS_QUERYONLY Context is not modified but the <i>ppRange</i> parameter is set as if the insert
    ///              occurred. Read-only access is sufficient. If this flag is not set, the <i>ec</i> parameter must have
    ///              read/write access. TF_IAS_NO_DEFAULT_COMPOSITION The TSF manager does not create a default composition if a
    ///              composition is required. The caller must create a composition object that covers the inserted text before
    ///              releasing the context lock.
    ///    pDataObject = Pointer to object to insert.
    ///    ppRange = Position of the inserted object. Optional.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The <i>ec</i> parameter
    ///    is an invalid edit cookie. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_DISCONNECTED</b></dt> </dl>
    ///    </td> <td width="60%"> Context object is not on a document stack. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_NOSELECTION</b></dt> </dl> </td> <td width="60%"> Context has no selection. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TS_E_READONLY</b></dt> </dl> </td> <td width="60%"> Selection is read-only. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_FORMAT</b></dt> </dl> </td> <td width="60%"> Context owner
    ///    cannot handle objects of the type provided by the <i>pDataObject</i> parameter. </td> </tr> </table>
    ///    
    HRESULT InsertEmbeddedAtSelection(uint ec, uint dwFlags, IDataObject pDataObject, ITfRange* ppRange);
}

///The <b>ITfCleanupContextSink</b> interface is implemented by a text service to receive notifications when a context
///cleanup operation occurs. This notification sink is installed by calling ITfSourceSingle::AdviseSingleSink with
///IID_ITfCleanupContextSink.
@GUID("01689689-7ACB-4E9B-AB7C-7EA46B12B522")
interface ITfCleanupContextSink : IUnknown
{
    ///Called during a context cleanup operation.
    ///Params:
    ///    ecWrite = Contains a TfEditCookie value that identifies the edit context cleaned up. The edit context is guaranteed to
    ///              have a read/write lock.
    ///    pic = Pointer to an ITfContext interface that represents the context cleaned up.
    ///Returns:
    ///    If this method succeeds, it returns **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT OnCleanupContext(uint ecWrite, ITfContext pic);
}

///The <b>ITfCleanupContextDurationSink</b> interface is implemented by a text service to receive notifications when a
///context cleanup operation is performed. This notification sink is installed by calling
///ITfSourceSingle::AdviseSingleSink with IID_ITfCleanupContextDurationSink.
@GUID("45C35144-154E-4797-BED8-D33AE7BF8794")
interface ITfCleanupContextDurationSink : IUnknown
{
    ///Called when a context cleanup operation is about to begin.
    ///Returns:
    ///    If this method succeeds, it returns **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT OnStartCleanupContext();
    ///Called when a context cleanup operation completes.
    ///Returns:
    ///    If this method succeeds, it returns **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT OnEndCleanupContext();
}

///The <b>ITfReadOnlyProperty</b> interface is implemented by the TSF manager and used by an application or text service
///to obtain property data.
@GUID("17D49A3D-F8B8-4B2F-B254-52319DD64C53")
interface ITfReadOnlyProperty : IUnknown
{
    ///Obtains the property identifier.
    ///Params:
    ///    pguid = Pointer to a <b>GUID</b> value that receives the property type identifier. This is the value that the
    ///            property provider passed to ITfCategoryMgr::RegisterCategory when the property was registered. This can be
    ///            one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///            id="GUID_TFCAT_PROPSTYLE_STATIC"></a><a id="guid_tfcat_propstyle_static"></a><dl>
    ///            <dt><b>GUID_TFCAT_PROPSTYLE_STATIC</b></dt> </dl> </td> <td width="60%"> The property is a static property.
    ///            </td> </tr> <tr> <td width="40%"><a id="GUID_TFCAT_PROPSTYLE_STATICCOMPACT"></a><a
    ///            id="guid_tfcat_propstyle_staticcompact"></a><dl> <dt><b>GUID_TFCAT_PROPSTYLE_STATICCOMPACT</b></dt> </dl>
    ///            </td> <td width="60%"> The property is a static-compact property. </td> </tr> <tr> <td width="40%"><a
    ///            id="GUID_TFCAT_PROPSTYLE_CUSTOM"></a><a id="guid_tfcat_propstyle_custom"></a><dl>
    ///            <dt><b>GUID_TFCAT_PROPSTYLE_CUSTOM</b></dt> </dl> </td> <td width="60%"> The property is a custom property.
    ///            </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pguid</i> is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified
    ///    error occurred. </td> </tr> </table>
    ///    
    HRESULT GetType(GUID* pguid);
    ///Obtains an enumeration of ranges that contain unique values of the property within the given range.
    ///Params:
    ///    ec = Contains an edit cookie that identifies the edit context. This is obtained from ITfDocumentMgr::CreateContext
    ///         or ITfEditSession::DoEditSession.
    ///    ppEnum = Pointer to an IEnumTfRanges interface pointer that receives the enumerator object. The caller must release
    ///             this object when it is no longer required.
    ///    pTargetRange = Pointer to an ITfRange interface that specifies the range to scan for unique property values. This parameter
    ///                   is optional and can be <b>NULL</b>. For more information, see the Remarks section.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> A memory allocation failure occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. <div
    ///    class="alert"><b>Note</b> If an application does not implement ITextStoreACP::FindNextAttrTransition,
    ///    ITfReadOnlyProperty::EnumRanges fails with E_FAIL.</div> <div> </div> </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The edit context identified by <i>ec</i> does not
    ///    have a read-only or read/write lock. </td> </tr> </table>
    ///    
    HRESULT EnumRanges(uint ec, IEnumTfRanges* ppEnum, ITfRange pTargetRange);
    ///Obtains the value of the property for a range of text.
    ///Params:
    ///    ec = Contains an edit cookie that identifies the edit context. This is obtained from ITfDocumentMgr::CreateContext
    ///         or ITfEditSession::DoEditSession.
    ///    pRange = Pointer to an ITfRange interface that specifies the range to obtain the property for.
    ///    pvarValue = Pointer to a <b>VARIANT</b> value that receives the property value. The data type and contents of this value
    ///                is defined by the property owner and must be recognized by the caller in order to use this value. The caller
    ///                must release this data, when it is no longer required, by passing this value to the <b>VariantClear</b> API.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The range is not covered by
    ///    the property or the range contains more than one property value. <i>pvarValue</i> receives a VT_EMPTY value.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The edit context identified by <i>ec</i> does not
    ///    have a read-only or read/write lock. </td> </tr> </table>
    ///    
    HRESULT GetValue(uint ec, ITfRange pRange, VARIANT* pvarValue);
    ///Obtains the context object for the property.
    ///Params:
    ///    ppContext = Pointer to an ITfContext interface pointer that receives the context object. The caller must release this
    ///                object when it is no longer required.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppContext</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetContext(ITfContext* ppContext);
}

///The <b>IEnumTfPropertyValue</b> interface is implemented by the TSF manager to provide an enumeration of property
///values.
@GUID("8ED8981B-7C10-4D7D-9FB3-AB72E9C75F72")
interface IEnumTfPropertyValue : IUnknown
{
    ///Creates a copy of the enumerator object.
    ///Params:
    ///    ppEnum = Pointer to an IEnumTfPropertyValue interface pointer that receives the new enumerator.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    failure occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td
    ///    width="60%"> The method is not implemented. </td> </tr> </table>
    ///    
    HRESULT Clone(IEnumTfPropertyValue* ppEnum);
    ///Obtains, from the current position, the specified number of elements in the enumeration sequence.
    ///Params:
    ///    ulCount = Specifies the number of elements to obtain.
    ///    rgValues = Pointer to an array of TF_PROPERTYVAL structures that receives the requested objects. This array must be at
    ///               least <i>ulCount</i> elements in size.
    ///    pcFetched = Pointer to a ULONG value that receives the number of elements actually obtained. This value can be less than
    ///                the number of items requested. This parameter can be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements could be obtained. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>rgValues</i> is invalid. </td> </tr>
    ///    </table>
    ///    
    HRESULT Next(uint ulCount, char* rgValues, uint* pcFetched);
    ///Resets the enumerator object by moving the current position to the beginning of the enumeration sequence.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT Reset();
    ///Moves the current position forward in the enumeration sequence by the specified number of elements.
    ///Params:
    ///    ulCount = Contains the number of elements to skip.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements could be skipped. </td> </tr> </table>
    ///    
    HRESULT Skip(uint ulCount);
}

///The <b>ITfMouseTracker</b> interface is implemented by the TSF manager and is used by a text service to manage mouse
///event notification sinks. An instance of this interface is obtained by querying an ITfContext object for
///IID_ITfMouseTracker.
@GUID("09D146CD-A544-4132-925B-7AFA8EF322D0")
interface ITfMouseTracker : IUnknown
{
    ///Installs a mouse event sink.
    ///Params:
    ///    range = Pointer to an ITfRange interface that specifies the range of text that the mouse sink is installed for.
    ///    pSink = Pointer to the ITfMouseSink interface.
    ///    pdwCookie = Pointer to a DWORD value that receives a cookie that identifies the mouse event sink.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_DISCONNECTED</b></dt> </dl> </td> <td
    ///    width="60%"> The context object is not on a document stack. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The context owner does not support mouse event sinks.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified
    ///    error occurred. </td> </tr> </table>
    ///    
    HRESULT AdviseMouseSink(ITfRange range, ITfMouseSink pSink, uint* pdwCookie);
    ///Uninstalls a mouse event sink.
    ///Params:
    ///    dwCookie = Specifies the mouse advise sink identifier. This value is obtained by a call to
    ///               ITfMouseTracker::AdviseMouseSink.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_DISCONNECTED</b></dt> </dl> </td> <td width="60%"> The context object
    ///    is not on a document stack. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td
    ///    width="60%"> The context owner does not support mouse event sinks. </td> </tr> </table>
    ///    
    HRESULT UnadviseMouseSink(uint dwCookie);
}

///The <b>ITfMouseTrackerACP</b> interface is implemented by an application to support mouse event sinks. This interface
///is used by the TSF manager to add and remove mouse event sinks in an ACP-based application. The TSF manager obtains
///this interface by calling the application's ITextStoreACP::QueryInterface with IID_ITfMouseTrackerACP.
@GUID("3BDD78E2-C16E-47FD-B883-CE6FACC1A208")
interface ITfMouseTrackerACP : IUnknown
{
    ///Called to install a mouse event sink.
    ///Params:
    ///    range = Pointer to an ITfRange interface that specifies the range of text that the mouse sink is installed for.
    ///    pSink = Pointer to the ITfMouseSink interface. The application must increment this object reference count and save
    ///            the interface.
    ///    pdwCookie = Pointer to a DWORD that receives a cookie that identifies the mouse event sink.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%">
    ///    The application does not support mouse event sinks. </td> </tr> </table>
    ///    
    HRESULT AdviseMouseSink(ITfRangeACP range, ITfMouseSink pSink, uint* pdwCookie);
    ///Called to remove a mouse event sink.
    ///Params:
    ///    dwCookie = Specifies the mouse advise sink identifier. This value is obtained by a call to
    ///               ITfMouseTrackerACP::AdviseMouseSink.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The application does not
    ///    support mouse event sinks. </td> </tr> </table>
    ///    
    HRESULT UnadviseMouseSink(uint dwCookie);
}

///The <b>ITfMouseSink</b> interface is implemented by a text service to receive mouse event notifications. A mouse
///event sink is installed with the ITfMouseTracker::AdviseMouseSink method of one of the ITfMouseTracker interfaces.
@GUID("A1ADAAA2-3A24-449D-AC96-5183E7F5C217")
interface ITfMouseSink : IUnknown
{
    ///Called when a mouse event occurs over a range of text.
    ///Params:
    ///    uEdge = Contains the offset, in characters, of the mouse position from the start of the range of text. For more
    ///            information, see the Remarks section.
    ///    uQuadrant = Contains the zero-based quadrant index, relative to the edge, that the mouse position lies in. For more
    ///                information, see the Remarks section.
    ///    dwBtnStatus = Indicates the mouse button state at the time of the event. See the <i>wParam</i> parameter of the
    ///                  WM_MOUSEMOVE message for possible values.
    ///    pfEaten = Pointer to a BOOL that, on exit, indicates if the mouse event was handled. If this value receives
    ///              <b>TRUE</b>, the mouse event was handled. If this value is <b>FALSE</b>, the mouse event was not handled.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnMouseEvent(uint uEdge, uint uQuadrant, uint dwBtnStatus, int* pfEaten);
}

///The <b>ITfEditRecord</b> interface is implemented by the TSF manager and is used by a text edit sink to determine
///what was changed during an edit session. An instance of this interface is passed to the text edit sink when the
///ITfTextEditSink::OnEndEdit method is called.
@GUID("42D4D099-7C1A-4A89-B836-6C6F22160DF0")
interface ITfEditRecord : IUnknown
{
    ///Determines if the selection has changed during the edit session.
    ///Params:
    ///    pfChanged = Pointer to a <b>BOOL</b> value that receives a value that indicates if the selection changed due to an edit
    ///                session. Receives a nonzero value if the selection changed or zero otherwise.
    HRESULT GetSelectionStatus(int* pfChanged);
    ///Obtains an enumerator that contains a collection of range objects that cover the specified properties and/or text
    ///that changed during the edit session.
    ///Params:
    ///    dwFlags = Contains a combination of the following values that specify the behavior of this method. <table> <tr>
    ///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td>
    ///              <td width="60%"> Specifies that the method will obtain a collection of range objects that cover the specified
    ///              properties changed during the edit session. <i>prgProperties</i> cannot be <b>NULL</b> and <i>cProperties</i>
    ///              must be greater than zero. </td> </tr> <tr> <td width="40%"><a id="TF_GTP_INCL_TEXT"></a><a
    ///              id="tf_gtp_incl_text"></a><dl> <dt><b>TF_GTP_INCL_TEXT</b></dt> </dl> </td> <td width="60%"> Specifies that
    ///              the method will obtain the collection of range objects that cover the text changed during the edit session.
    ///              </td> </tr> </table>
    ///    prgProperties = Pointer to an array of <b>GUID</b> values that identify the properties to search for changes for. This method
    ///                    searches the properties that changed during the edit session and, if the property is contained in this array,
    ///                    a range object that covers the property that changed is added to <i>ppEnum</i>. This array must be at least
    ///                    <i>cProperties</i> elements in size. This parameter is ignored if <i>dwFlags</i> contains TF_GTP_INCL_TEXT
    ///                    and <i>cProperties</i> is zero.
    ///    cProperties = Specifies the number of elements in the <i>prgProperties</i> array. This parameter can be zero if
    ///                  <i>dwFlags</i> contains TF_GTP_INCL_TEXT. This indicates that no property changes are obtained.
    ///    ppEnum = Pointer to an IEnumTfRanges interface pointer that receives the enumerator object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> A memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT GetTextAndPropertyUpdates(uint dwFlags, char* prgProperties, uint cProperties, IEnumTfRanges* ppEnum);
}

///The <b>ITfTextEditSink</b> interface supports completion of an edit session that involves read/write access. Install
///this advise sink by calling ITfSource::AdviseSink with IID_ITfTextEditSink. A text service or application can
///optionally implement this interface.
@GUID("8127D409-CCD3-4683-967A-B43D5B482BF7")
interface ITfTextEditSink : IUnknown
{
    ///Receives a notification upon completion of an ITfEditSession::DoEditSession method that has read/write access to
    ///the context.
    ///Params:
    ///    pic = Pointer to the ITfContext interface for the edited context.
    ///    ecReadOnly = Specifies a TfEditCookie value for read-only access to the context.
    ///    pEditRecord = Pointer to the ITfEditRecord interface used to access the modifications to the context.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnEndEdit(ITfContext pic, uint ecReadOnly, ITfEditRecord pEditRecord);
}

///The <b>ITfTextLayoutSink</b> interface supports the context layout change by an application. Install this advise sink
///by calling ITfSource::AdviseSink with IID_ITfTextLayoutSink. A text service can optionally implement this interface.
@GUID("2AF2D06A-DD5B-4927-A0B4-54F19C91FADE")
interface ITfTextLayoutSink : IUnknown
{
    ///Receives a notification when the layout of a context view changes.
    ///Params:
    ///    pic = Pointer to the ITfContext interface for the context that changed.
    ///    lcode = Specifies the TfLayoutCode element that describes the layout change.
    ///    pView = Pointer to the ITfContextView interface for the context view in that the layout change occurred.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnLayoutChange(ITfContext pic, TfLayoutCode lcode, ITfContextView pView);
}

///The <b>ITfStatusSink</b> interface supports changes to the global document status. This advise sink is installed by
///calling ITfSource::AdviseSink with IID_ITfStatusSink. A text service can optionally implement this interface.
@GUID("6B7D8D73-B267-4F69-B32E-1CA321CE4F45")
interface ITfStatusSink : IUnknown
{
    ///Receives a notification when one of the dynamic flags of the TF_STATUS structure changes.
    ///Params:
    ///    pic = Pointer to the ITfContext interface whose status has changed.
    ///    dwFlags = Indicates that one of the dynamic flags changed.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnStatusChange(ITfContext pic, uint dwFlags);
}

///The <b>ITfEditTransactionSink</b> interface is implemented by a text service and used by the TSF manager to support
///edit transactions. An edit transaction is a series of edits that use multiple document locks. A text service can
///optionally implement this interface. This advise sink is installed by calling ITfSource::AdviseSink with
///IID_ITfEditTransactionSink.
@GUID("708FBF70-B520-416B-B06C-2C41AB44F8BA")
interface ITfEditTransactionSink : IUnknown
{
    ///Indicates the start of an edit transaction.
    ///Params:
    ///    pic = Pointer to the ITfContext interface involved in the transaction.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnStartEditTransaction(ITfContext pic);
    ///Indicates the end of an edit transaction.
    ///Params:
    ///    pic = Pointer to the ITfContext interface involved in the transaction.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnEndEditTransaction(ITfContext pic);
}

///The <b>ITfContextOwner</b> interface is implemented by an application or a text service to receive text input without
///having a text store. An instance of this interface is obtained when the application calls the ITfSource::AdviseSink
///method.
@GUID("AA80E80C-2021-11D2-93E0-0060B067B86E")
interface ITfContextOwner : IUnknown
{
    ///The <b>ITfContextOwner::GetACPFromPoint</b> method converts a point in screen coordinates to an application
    ///character position.
    ///Params:
    ///    ptScreen = Pointer to the <b>POINT</b> structure with the screen coordinates of the point.
    ///    dwFlags = Specifies the character position to return based upon the screen coordinates of the point relative to a
    ///              character bounding box. By default, the character position returned is the character bounding box containing
    ///              the screen coordinates of the point. If the point is outside a character's bounding box, the method returns
    ///              <b>NULL</b> or TF_E_INVALIDPOINT. If the GXFPF_ROUND_NEAREST flag is specified for this parameter and the
    ///              screen coordinates of the point are contained in a character bounding box, the character position returned is
    ///              the bounding edge closest to the screen coordinates of the point. If the GXFPF_NEAREST flag is specified for
    ///              this parameter and the screen coordinates of the point are not contained in a character bounding box, the
    ///              closest character position is returned. The bit flags can be combined.
    ///    pacp = Receives the character position that corresponds to the screen coordinates of the point
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TS_E_INVALIDPOINT</b></dt> </dl> </td> <td width="60%"> The <i>ptScreen</i>
    ///    parameter is not within the bounding box of any character. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_NOLAYOUT</b></dt> </dl> </td> <td width="60%"> The application has not calculated a text layout.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetACPFromPoint(const(POINT)* ptScreen, uint dwFlags, int* pacp);
    ///The <b>ITfContextOwner::GetTextExt</b> method returns the bounding box, in screen coordinates, of the text at a
    ///specified character position. The caller must have a read-only lock on the document before calling this method.
    ///Params:
    ///    acpStart = Specifies the starting character position of the text to get in the document.
    ///    acpEnd = Specifies the ending character position of the text to get in the document.
    ///    prc = Receives the bounding box, in screen coordinates, of the text at the specified character positions.
    ///    pfClipped = Receives the Boolean value that specifies if the text in the bounding box has been clipped. If this parameter
    ///                is <b>TRUE</b>, the bounding box contains clipped text and does not include the entire requested range of
    ///                text. The bounding box is clipped because of the requested range is not visible.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TS_E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The specified start
    ///    and end character positions are equal. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_INVALIDPOS</b></dt>
    ///    </dl> </td> <td width="60%"> The range specified by the <i>acpStart</i> and <i>acpEnd</i> parameters extends
    ///    past the end of the document or the top of the document. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TS_E_NOLAYOUT</b></dt> </dl> </td> <td width="60%"> The application has not calculated a text layout.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TS_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The caller
    ///    does not have a read-only lock on the document. </td> </tr> </table>
    ///    
    HRESULT GetTextExt(int acpStart, int acpEnd, RECT* prc, int* pfClipped);
    ///The <b>ITfContextOwner::GetScreenExt</b> method returns the bounding box, in screen coordinates, of the display
    ///surface where the text stream is rendered.
    ///Params:
    ///    prc = Receives the bounding box screen coordinates of the display surface of the document.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetScreenExt(RECT* prc);
    ///The <b>ITfContextOwner::GetStatus</b> method obtains the status of a document. The document status is returned
    ///through the TS_STATUS structure.
    ///Params:
    ///    pdcs = Receives the TS_STATUS structure that contains the document status. Cannot be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetStatus(TS_STATUS* pdcs);
    ///The <b>ITfContextOwner::GetWnd</b> method returns the handle to a window that corresponds to the current
    ///document.
    ///Params:
    ///    phwnd = Receives a pointer to the handle of the window that corresponds to the current document. This parameter can
    ///            be <b>NULL</b> if the document does not have the corresponding handle to the window.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetWnd(HWND* phwnd);
    ///The <b>ITfContextOwner::GetAttribute</b> method returns the value of a supported attribute. If the attribute is
    ///unsupported, the <i>pvarValue</i> parameter is set to VT_EMPTY.
    ///Params:
    ///    rguidAttribute = Specifies the attribute GUID.
    ///    pvarValue = Receives the attribute value. If the attribute is unsupported, this parameter is set to VT_EMPTY.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetAttribute(const(GUID)* rguidAttribute, VARIANT* pvarValue);
}

///The <b>ITfContextOwnerServices</b> interface is implemented by the manager and used by a text service or application
///acting as context owners. The interface provides notification changes to sinks and other services to context owners
///that do not implement the ITextStoreACP or ITextStoreAnchor interfaces. Clients obtain this interface by calling the
///ITfContext::QueryInterface method.
@GUID("B23EB630-3E1C-11D3-A745-0050040AB407")
interface ITfContextOwnerServices : IUnknown
{
    ///The <b>ITfContextOwnerServices::OnLayoutChange</b> method is called by the context owner when the on-screen
    ///representation of the text stream is updated during a composition. Text stream updates include when the position
    ///of the window that contains the text is changed or if the screen coordinates of the text change.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnLayoutChange();
    ///The <b>ITfContextOwnerServices::OnStatusChange</b> method is called by the context owner when the
    ///<b>dwDynamicFlags</b> member of the TS_STATUS structure returned by the ITfContextOwner::GetStatus method
    ///changes.
    ///Params:
    ///    dwFlags = Specifies the dynamic status flag.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnStatusChange(uint dwFlags);
    ///Called by a context owner to generate notifications that a support attribute value changed.
    ///Params:
    ///    rguidAttribute = Specifies the GUID of the support attribute.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnAttributeChange(const(GUID)* rguidAttribute);
    ///The <b>ITfContextOwnerServices::Serialize</b> method obtains a property from a range of text and writes the
    ///property data into a stream object. This enables an application to store property data, for example, when writing
    ///the data to a file.
    ///Params:
    ///    pProp = Pointer to an ITfProperty interface that identifies the property to serialize.
    ///    pRange = Pointer to an ITfRange interface that identifies the range that the property is obtained from.
    ///    pHdr = Pointer to a TF_PERSISTENT_PROPERTY_HEADER_ACP structure that receives the header data for the property.
    ///    pStream = Pointer to an <b>IStream</b> object that the TSF manager will write the property data to.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The property cannot be
    ///    serialized. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Serialize(ITfProperty pProp, ITfRange pRange, TF_PERSISTENT_PROPERTY_HEADER_ACP* pHdr, IStream pStream);
    ///Applies previously serialized property data to a property object.
    ///Params:
    ///    pProp = Pointer to an ITfProperty object that receives the property data.
    ///    pHdr = Pointer to a TF_PERSISTENT_PROPERTY_HEADER_ACP structure that contains the header data for the property.
    ///    pStream = Pointer to an <b>IStream</b> object that contains the property data. This parameter can be <b>NULL</b> if
    ///              <i>pLoader</i> is not <b>NULL</b>. This parameter is ignored if <i>pLoader</i> is not <b>NULL</b>.
    ///    pLoader = Pointer to an ITfPersistentPropertyLoaderACP object that the TSF manager uses to obtain the property data.
    ///              This parameter can be <b>NULL</b> if <i>pStream</i> is not <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The property data is
    ///    obtained asynchronously. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_SYNCHRONOUS</b></dt> </dl> </td>
    ///    <td width="60%"> A synchronous read-only lock cannot be obtained. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Unserialize(ITfProperty pProp, const(TF_PERSISTENT_PROPERTY_HEADER_ACP)* pHdr, IStream pStream, 
                        ITfPersistentPropertyLoaderACP pLoader);
    ///Forces a property load.
    ///Params:
    ///    pProp = Pointer to an ITfProperty object that specifies the property to load.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT ForceLoadProperty(ITfProperty pProp);
    ///The <b>ITfContextOwnerServices::CreateRange</b> method creates a new ranged based upon a specified character
    ///position.
    ///Params:
    ///    acpStart = Specifies the starting character position of the range.
    ///    acpEnd = Specifies the ending character position of the range.
    ///    ppRange = Receives a pointer to the range object within the specified starting and ending character positions.
    HRESULT CreateRange(int acpStart, int acpEnd, ITfRangeACP* ppRange);
}

///The <b>ITfContextKeyEventSink</b> interface is implemented by a text service to receive keyboard event notifications
///that occur in an input context. This keyboard event sink differs from the ITfKeyEventSink keyboard event sink in that
///the keyboard events are passed to <b>ITfContextKeyEventSink</b> after having been preprocessed by the
///<b>ITfKeyEventSink</b> event sink. Preserved key events and filtered key events are not passed to the
///<b>ITfContextKeyEventSink</b> event sink. This event sink is installed by ITfSource::AdviseSink with
///IID_ITfContextKeyEventSink.
@GUID("0552BA5D-C835-4934-BF50-846AAA67432F")
interface ITfContextKeyEventSink : IUnknown
{
    ///Called when a key down event occurs.
    ///Params:
    ///    wParam = Specifies the virtual-key code of the key. For more information about this parameter, see the <i>wParam</i>
    ///             parameter in WM_KEYDOWN.
    ///    lParam = Specifies the repeat count, scan code, extended-key flag, context code, previous key-state flag, and
    ///             transition-state flag of the key. For more information about this parameter, see the <i>lParam</i> parameter
    ///             in WM_KEYDOWN.
    ///    pfEaten = Pointer to a BOOL value that, on exit, indicates if the key event is handled. If this value receives
    ///              <b>TRUE</b>, the key event is handled. If this value is <b>FALSE</b>, the key event is not handled.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnKeyDown(WPARAM wParam, LPARAM lParam, int* pfEaten);
    ///Called when a key up event occurs.
    ///Params:
    ///    wParam = Specifies the virtual-key code of the key. For more information about this parameter, see the wPa<i></i>ram
    ///             parameter in WM_KEYUP.
    ///    lParam = Specifies the repeat count, scan code, extended-key flag, context code, previous key-state flag, and
    ///             transition-state flag of the key. For more information about this parameter, see the <i>lParam</i> parameter
    ///             in WM_KEYUP.
    ///    pfEaten = Pointer to a BOOL value that, on exit, indicates if the key event is handled. If this value receives
    ///              <b>TRUE</b>, the key event is handled. If this value receives <b>FALSE</b>, the key event is not handled.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnKeyUp(WPARAM wParam, LPARAM lParam, int* pfEaten);
    ///Called to determine if a text service will handle a key down event.
    ///Params:
    ///    wParam = Specifies the virtual-key code of the key. For more information about this parameter, see the <i>wParam</i>
    ///             parameter in WM_KEYDOWN.
    ///    lParam = Specifies the repeat count, scan code, extended-key flag, context code, previous key-state flag, and
    ///             transition-state flag of the key. For more information about this parameter, see the <i>lParam</i> parameter
    ///             in WM_KEYDOWN.
    ///    pfEaten = Pointer to a BOOL value that, on exit, indicates if the key event is handled. If this value receives
    ///              <b>TRUE</b>, the key event is handled. If this value is <b>FALSE</b>, the key event is not handled.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnTestKeyDown(WPARAM wParam, LPARAM lParam, int* pfEaten);
    ///Called to determine if a text service will handle a key up event.
    ///Params:
    ///    wParam = Specifies the virtual-key code of the key. For more information about this parameter, see the <i>wParam</i>
    ///             parameter in WM_KEYUP.
    ///    lParam = Specifies the repeat count, scan code, extended-key flag, context code, previous key-state flag, and
    ///             transition-state flag of the key. For more information about this parameter, see the <i>lParam</i> parameter
    ///             in WM_KEYUP.
    ///    pfEaten = Pointer to a BOOL value that, on exit, indicates if the key event is handled. If this value receives
    ///              <b>TRUE</b>, the key event is handled. If this value receives <b>FALSE</b>, the key event would is not
    ///              handled.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnTestKeyUp(WPARAM wParam, LPARAM lParam, int* pfEaten);
}

///The <b>ITfEditSession</b> interface is implemented by a text service and used by the TSF manager to read and/or
///modify the text and properties of a context.
@GUID("AA80E803-2021-11D2-93E0-0060B067B86E")
interface ITfEditSession : IUnknown
{
    ///Called to enable a text service to read and/or modify the contents of a context.
    ///Params:
    ///    ec = Contains a TfEditCookie value that uniquely identifies the edit session. This cookie is used to access the
    ///         context with methods such as ITfRange::GetText.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT DoEditSession(uint ec);
}

///The <b>ITfRange</b> interface is used by text services and applications to reference and manipulate text within a
///given context. The interface ID is IID_ITfRange.
@GUID("AA80E7FF-2021-11D2-93E0-0060B067B86E")
interface ITfRange : IUnknown
{
    ///The <b>ITfRange::GetText</b> method obtains the content covered by this range of text.
    ///Params:
    ///    ec = Edit cookie that identifies the edit context obtained from ITfDocumentMgr::CreateContext or
    ///         ITfEditSession::DoEditSession.
    ///    dwFlags = Bit fields that specify optional behavior. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///              width="40%"><a id="TF_TF_MOVESTART"></a><a id="tf_tf_movestart"></a><dl> <dt><b>TF_TF_MOVESTART</b></dt>
    ///              </dl> </td> <td width="60%"> Start anchor of the range is advanced to the position after the last character
    ///              returned. </td> </tr> <tr> <td width="40%"><a id="TF_TF_IGNOREEND"></a><a id="tf_tf_ignoreend"></a><dl>
    ///              <dt><b>TF_TF_IGNOREEND</b></dt> </dl> </td> <td width="60%"> Method attempts to fill <i>pchText</i> with the
    ///              maximum number of characters, instead of halting the copy at the position occupied by the end anchor of the
    ///              range. </td> </tr> </table>
    ///    pchText = Pointer to a buffer to receive the text in the range.
    ///    cchMax = Maximum size of the text buffer.
    ///    pcch = Pointer to a ULONG representing the number of characters written to the <i>pchText</i> text buffer.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td
    ///    width="60%"> The value of the <i>ec</i> parameter is an invalid cookie, or the caller does not have a
    ///    read-only lock. </td> </tr> </table>
    ///    
    HRESULT GetText(uint ec, uint dwFlags, char* pchText, uint cchMax, uint* pcch);
    ///The <b>ITfRange::SetText</b> method replaces the content covered by the range of text. For an empty range object,
    ///the method results in an insertion at the location of the range. If the new content is an empty string
    ///(<i>cch</i> = 0), the method deletes the existing content within the range.
    ///Params:
    ///    ec = Identifies the edit context obtained from ITfDocumentMgr::CreateContext or ITfEditSession::DoEditSession.
    ///    dwFlags = Specifies optional behavior for correction of content. If set to the value of TF_ST_CORRECTION, then the
    ///              operation is a correction of the existing content, not a creation of new content, and original text
    ///              properties are preserved.
    ///    pchText = Pointer to a buffer that contains the text to replace the range contents.
    ///    cch = Contains the number of characters in <i>pchText</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_COMPOSITION_REJECTED</b></dt>
    ///    </dl> </td> <td width="60%"> The context owner rejected a default composition. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The value of the <i>ec</i>
    ///    parameter is an invalid cookie, or the caller does not have a read/write lock. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TF_E_RANGE_NOT_COVERED</b></dt> </dl> </td> <td width="60%"> The range is not within
    ///    the active composition of the caller. </td> </tr> </table>
    ///    
    HRESULT SetText(uint ec, uint dwFlags, const(wchar)* pchText, int cch);
    ///The <b>ITfRange::GetFormattedText</b> method obtains formatted content contained within a range of text. The
    ///content is packaged in an object that supports the IDataObject interface.
    ///Params:
    ///    ec = Edit cookie obtained from ITfDocumentMgr::CreateContext or ITfEditSession::DoEditSession.
    ///    ppDataObject = Pointer to an <b>IDataObject</b> pointer that receives an object that contains the formatted content. The
    ///                   formatted content is obtained using a STGMEDIUM global memory handle.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%">
    ///    The context owner does not support exporting formatted text as an <b>IDataObject</b> object. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The value of the <i>ec</i>
    ///    parameter is an invalid cookie, or the caller does not have a read-only lock. </td> </tr> </table>
    ///    
    HRESULT GetFormattedText(uint ec, IDataObject* ppDataObject);
    ///The <b>ITfRange::GetEmbedded</b> method obtains content that corresponds to a TS_CHAR_EMBEDDED character in the
    ///text stream. The start anchor of the range of text is positioned just before the character of interest.
    ///Params:
    ///    ec = Edit cookie obtained from ITfDocumentMgr::CreateContext or ITfEditSession::DoEditSession.
    ///    rguidService = Identifier that specifies how the embedded content is obtained. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///                   </tr> <tr> <td width="40%"><a id="GUID_TS_SERVICE_ACCESSIBLE"></a><a id="guid_ts_service_accessible"></a><dl>
    ///                   <dt><b>GUID_TS_SERVICE_ACCESSIBLE</b></dt> </dl> </td> <td width="60%"> Output should be an Accessible
    ///                   object. </td> </tr> <tr> <td width="40%"><a id="GUID_TS_SERVICE_ACTIVEX"></a><a
    ///                   id="guid_ts_service_activex"></a><dl> <dt><b>GUID_TS_SERVICE_ACTIVEX</b></dt> </dl> </td> <td width="60%">
    ///                   Caller requires a direct pointer to the object that supports the interface specified by <i>riid</i>. </td>
    ///                   </tr> <tr> <td width="40%"><a id="GUID_TS_SERVICE_DATAOBJECT"></a><a id="guid_ts_service_dataobject"></a><dl>
    ///                   <dt><b>GUID_TS_SERVICE_DATAOBJECT</b></dt> </dl> </td> <td width="60%"> Content should be obtained as an
    ///                   IDataObject data transfer object, with <i>riid</i> being IID_IDataObject. Clients should specify this option
    ///                   when a copy of the content is required. </td> </tr> <tr> <td width="40%"><a id="Caller-defined"></a><a
    ///                   id="caller-defined"></a><a id="CALLER-DEFINED"></a><dl> <dt><b>Caller-defined</b></dt> </dl> </td> <td
    ///                   width="60%"> Text services and context owners can define custom GUIDs. </td> </tr> </table>
    ///    riid = UUID of the interface of the requested object.
    ///    ppunk = Pointer to the object. It can be cast to match <i>riid</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%">
    ///    The implementing application does not expose embedded objects in its text stream. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TF_E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> The object does not support
    ///    the requested interface. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td
    ///    width="60%"> The value in the <i>ec</i> parameter is an invalid cookie, or the caller does not have a
    ///    read-only lock. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOOBJECT</b></dt> </dl> </td> <td
    ///    width="60%"> The start anchor of the range is not positioned before a TF_CHAR_EMBEDDED character. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_NOSERVICE</b></dt> </dl> </td> <td width="60%"> The content cannot be
    ///    returned to match <i>rguidService</i>. </td> </tr> </table>
    ///    
    HRESULT GetEmbedded(uint ec, const(GUID)* rguidService, const(GUID)* riid, IUnknown* ppunk);
    ///The <b>ITfRange::InsertEmbedded</b> method inserts an object at the location of the start anchor of the range of
    ///text.
    ///Params:
    ///    ec = Edit cookie obtained from ITfDocumentMgr::CreateContext or ITfEditSession::DoEditSession.
    ///    dwFlags = Bit fields that specify how insertion should occur. If TF_IE_CORRECTION is set, the operation is a
    ///              correction, so that other text services can preserve data associated with the original text.
    ///    pDataObject = Pointer to the data transfer object to be inserted.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The implementing
    ///    application does not expose embedded objects in its stream. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_COMPOSITION_REJECTED</b></dt> </dl> </td> <td width="60%"> The context owner rejected a default
    ///    composition. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_FORMAT</b></dt> </dl> </td> <td width="60%">
    ///    The context owner cannot handle the specified object type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The value of the <i>ec</i> parameter is an invalid
    ///    cookie, or the caller does not have a read-only lock. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_RANGE_NOT_COVERED</b></dt> </dl> </td> <td width="60%"> The caller already has an active
    ///    composition, but the range is positioned over text not covered by the composition. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TF_E_READONLY</b></dt> </dl> </td> <td width="60%"> The document or the location of
    ///    the range cannot be modified. </td> </tr> </table>
    ///    
    HRESULT InsertEmbedded(uint ec, uint dwFlags, IDataObject pDataObject);
    ///Moves the start anchor of the range.
    ///Params:
    ///    ec = Contains an edit cookie that identifies the edit context. This is obtained from ITfDocumentMgr::CreateContext
    ///         or ITfEditSession::DoEditSession.
    ///    cchReq = Contains the number of characters the start anchor is shifted. A negative value causes the anchor to move
    ///             backward and a positive value causes the anchor to move forward.
    ///    pcch = Pointer to a <b>LONG</b> value that receives the number of characters the anchor was shifted.
    ///    pHalt = Pointer to a TF_HALTCOND structure that contains conditions about the shift. This parameter is optional and
    ///            can be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td>
    ///    <td width="60%"> The edit context identified by <i>ec</i> does not have a read-only lock. </td> </tr>
    ///    </table>
    ///    
    HRESULT ShiftStart(uint ec, int cchReq, int* pcch, const(TF_HALTCOND)* pHalt);
    ///Moves the end anchor of the range.
    ///Params:
    ///    ec = Contains an edit cookie that identifies the edit context. This is obtained from ITfDocumentMgr::CreateContext
    ///         or ITfEditSession::DoEditSession.
    ///    cchReq = Contains the number of characters that the end anchor is shifted. A negative value causes the anchor to move
    ///             backward and a positive value causes the anchor to move forward.
    ///    pcch = Pointer to a <b>LONG</b> value that receives the number of characters the anchor shifted.
    ///    pHalt = Pointer to a TF_HALTCOND structure that contains conditions on the shift. This parameter is optional and can
    ///            be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td
    ///    width="60%"> The edit context identified by <i>ec</i> does not have a read-only lock. </td> </tr> </table>
    ///    
    HRESULT ShiftEnd(uint ec, int cchReq, int* pcch, const(TF_HALTCOND)* pHalt);
    ///Moves the start anchor of this range to an anchor within another range.
    ///Params:
    ///    ec = Contains an edit cookie that identifies the edit context obtained from ITfDocumentMgr::CreateContext or
    ///         ITfEditSession::DoEditSession.
    ///    pRange = Pointer to an ITfRange interface that contains the anchor that the start anchor is moved to.
    ///    aPos = Contains one of the TfAnchor values that specifies which anchor of <i>pRange</i> the start anchor is moved
    ///           to.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pRange</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td>
    ///    <td width="60%"> The edit context identified by <i>ec</i> does not have a read-only lock. </td> </tr>
    ///    </table>
    ///    
    HRESULT ShiftStartToRange(uint ec, ITfRange pRange, TfAnchor aPos);
    ///Moves the end anchor of this range to an anchor within another range.
    ///Params:
    ///    ec = Contains an edit cookie that identifies the edit context obtained from ITfDocumentMgr::CreateContext or
    ///         ITfEditSession::DoEditSession.
    ///    pRange = Pointer to an ITfRange interface that contains the anchor that the end anchor is moved to.
    ///    aPos = Contains one of the TfAnchor values that specify which anchor of <i>pRange</i> the end anchor will get moved
    ///           to.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pRange</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td>
    ///    <td width="60%"> The edit context identified by <i>ec</i> does not have a read-only lock. </td> </tr>
    ///    </table>
    ///    
    HRESULT ShiftEndToRange(uint ec, ITfRange pRange, TfAnchor aPos);
    ///Moves the start anchor into an adjacent region.
    ///Params:
    ///    ec = Contains an edit cookie that identifies the edit context obtained from ITfDocumentMgr::CreateContext or
    ///         ITfEditSession::DoEditSession.
    ///    dir = Contains one of the TfShiftDir values that specifies which adjacent region the start anchor is moved to.
    ///    pfNoRegion = Pointer to a <b>BOOL</b> that receives a flag that indicates if the anchor is positioned adjacent to another
    ///                 region. Receives a nonzero value if the anchor is not adjacent to another region or zero otherwise.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pfNoRegion</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The
    ///    edit context identified by <i>ec</i> does not have a read-only lock. </td> </tr> </table>
    ///    
    HRESULT ShiftStartRegion(uint ec, TfShiftDir dir, int* pfNoRegion);
    ///Moves the end anchor into an adjacent region.
    ///Params:
    ///    ec = Contains an edit cookie that identifies the edit context obtained from ITfDocumentMgr::CreateContext or
    ///         ITfEditSession::DoEditSession.
    ///    dir = Contains one of the TfShiftDir values that specify which adjacent region the end anchor is moved to.
    ///    pfNoRegion = Pointer to a <b>BOOL</b> value that receives a flag that indicates if the anchor is positioned adjacent to
    ///                 another region. Receives a nonzero value if the anchor is not adjacent to another region or zero otherwise.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pfNoRegion</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The
    ///    edit context identified by <i>ec</i> does not have a read-only lock. </td> </tr> </table>
    ///    
    HRESULT ShiftEndRegion(uint ec, TfShiftDir dir, int* pfNoRegion);
    ///The <b>ITfRange::IsEmpty</b> method verifies that the range of text is empty because the start and end anchors
    ///occupy the same position.
    ///Params:
    ///    ec = Edit cookie that identifies the edit context. It is obtained from ITfDocumentMgr::CreateContext or
    ///         ITfEditSession::DoEditSession.
    ///    pfEmpty = Pointer to a Boolean value. <b>TRUE</b> indicates the range is empty; <b>FALSE</b> indicates the range is not
    ///              empty.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td
    ///    width="60%"> The value of the <i>ec</i> parameter is an invalid cookie. </td> </tr> </table>
    ///    
    HRESULT IsEmpty(uint ec, int* pfEmpty);
    ///The <b>ITfRange::Collapse</b> method clears the range of text by moving its start anchor and end anchor to the
    ///same position.
    ///Params:
    ///    ec = Edit cookie obtained from ITfDocumentMgr::CreateContext or ITfEditSession::DoEditSession.
    ///    aPos = <a href="/windows/win32/api/msctf/ne-msctf-tfanchor">TfAnchor </a> enumeration that describes how to collapse
    ///           the range. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///           id="TF_ANCHOR_START"></a><a id="tf_anchor_start"></a><dl> <dt><b>TF_ANCHOR_START</b></dt> </dl> </td> <td
    ///           width="60%"> The end anchor is moved to the location of the start anchor. </td> </tr> <tr> <td width="40%"><a
    ///           id="TF_ANCHOR_END"></a><a id="tf_anchor_end"></a><dl> <dt><b>TF_ANCHOR_END</b></dt> </dl> </td> <td
    ///           width="60%"> The start anchor is moved to the location of the end anchor. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The object does not support
    ///    the interface, or a new range cannot be created. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>aPos</i> is invalid. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The cookie in <i>ec</i> is
    ///    invalid, or the caller does not have a read-only lock. </td> </tr> </table>
    ///    
    HRESULT Collapse(uint ec, TfAnchor aPos);
    ///The <b>ITfRange::IsEqualStart</b> method verifies that the start anchor of this range of text matches an anchor
    ///of another specified range.
    ///Params:
    ///    ec = Edit cookie obtained from ITfDocumentMgr::CreateContext or ITfEditSession::DoEditSession.
    ///    pWith = Pointer to a specified range in which an anchor is to be compared to this range start anchor.
    ///    aPos = Enumeration element that indicates which anchor of the specified <i>pWith</i> range to compare to this range
    ///           start anchor. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///           id="TF_ANCHOR_START"></a><a id="tf_anchor_start"></a><dl> <dt><b>TF_ANCHOR_START</b></dt> </dl> </td> <td
    ///           width="60%"> Compares this range start anchor with the specified range start anchor. </td> </tr> <tr> <td
    ///           width="40%"><a id="TF_ANCHOR_END"></a><a id="tf_anchor_end"></a><dl> <dt><b>TF_ANCHOR_END</b></dt> </dl>
    ///           </td> <td width="60%"> Compares this range start anchor with the specified range end anchor. </td> </tr>
    ///           </table>
    ///    pfEqual = Pointer to a Boolean value. Upon return, <b>TRUE</b> indicates that the specified <i>pWith</i> range anchor
    ///              matches this range start anchor. <b>FALSE</b> indicates otherwise.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td
    ///    width="60%"> The value of the <i>ec</i> parameter is an invalid cookie, or the caller does not have a
    ///    read-only lock. </td> </tr> </table>
    ///    
    HRESULT IsEqualStart(uint ec, ITfRange pWith, TfAnchor aPos, int* pfEqual);
    ///The ITfRange::IsEqualStart method verifies that the end anchor of this range of text matches an anchor of another
    ///specified range.
    ///Params:
    ///    ec = Edit cookie obtained from ITfDocumentMgr::CreateContext or ITfEditSession::DoEditSession.
    ///    pWith = Pointer to a specified range in which an anchor is to be compared to this range end anchor.
    ///    aPos = Enumeration element that indicates which anchor of the specified <i>pWith</i> range to compare with this
    ///           range end anchor. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///           id="TF_ANCHOR_START"></a><a id="tf_anchor_start"></a><dl> <dt><b>TF_ANCHOR_START</b></dt> </dl> </td> <td
    ///           width="60%"> Compares this range end anchor with the specified range start anchor. </td> </tr> <tr> <td
    ///           width="40%"><a id="TF_ANCHOR_END"></a><a id="tf_anchor_end"></a><dl> <dt><b>TF_ANCHOR_END</b></dt> </dl>
    ///           </td> <td width="60%"> Compares this range end anchor with the specified range end anchor. </td> </tr>
    ///           </table>
    ///    pfEqual = Pointer to a Boolean value. Upon return, <b>TRUE</b> indicates that the specified <i>pWith</i> range anchor
    ///              matches this range end anchor. <b>FALSE</b> indicates otherwise.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td
    ///    width="60%"> The value of the <i>ec</i> parameter is an invalid cookie, or the caller does not have a
    ///    read-only lock. </td> </tr> </table>
    ///    
    HRESULT IsEqualEnd(uint ec, ITfRange pWith, TfAnchor aPos, int* pfEqual);
    ///The <b>ITfRange::CompareStart</b> method compares the start anchor position of this range of text to an anchor in
    ///another range.
    ///Params:
    ///    ec = Edit cookie obtained from ITfDocumentMgr::CreateContext or ITfEditSession::DoEditSession.
    ///    pWith = Pointer to a specified range in which an anchor is to be compared to this range start anchor.
    ///    aPos = Enumeration element that indicates which anchor of the specified <i>pWith</i> range to compare to this range
    ///           start anchor. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///           id="TF_ANCHOR_START"></a><a id="tf_anchor_start"></a><dl> <dt><b>TF_ANCHOR_START</b></dt> </dl> </td> <td
    ///           width="60%"> Compare this range start anchor with the specified range start anchor. </td> </tr> <tr> <td
    ///           width="40%"><a id="TF_ANCHOR_END"></a><a id="tf_anchor_end"></a><dl> <dt><b>TF_ANCHOR_END</b></dt> </dl>
    ///           </td> <td width="60%"> Compare this range start anchor with the specified range end anchor. </td> </tr>
    ///           </table>
    ///    plResult = Pointer to the result of the comparison between this range start anchor and the specified <i>pWith</i> range
    ///               anchor. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="-1"></a><dl>
    ///               <dt><b>-1</b></dt> </dl> </td> <td width="60%"> This start anchor is behind the anchor of the specified range
    ///               (position of this start anchor &lt; position of the anchor of the specified range). </td> </tr> <tr> <td
    ///               width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%"> This start anchor is at the
    ///               same position as the anchor of the specified range. </td> </tr> <tr> <td width="40%"><a id="_1"></a><dl>
    ///               <dt><b>+1</b></dt> </dl> </td> <td width="60%"> This start anchor is ahead of the anchor of the specified
    ///               range (position of this start anchor &gt; position of the anchor of the specified range). </td> </tr>
    ///               </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td
    ///    width="60%"> The value of the <i>ec</i> parameter is an invalid cookie, or the caller does not have a
    ///    read-only lock. </td> </tr> </table>
    ///    
    HRESULT CompareStart(uint ec, ITfRange pWith, TfAnchor aPos, int* plResult);
    ///The <b>ITfRange::CompareEnd</b> method compares the end anchor position of this range of text to an anchor in
    ///another range.
    ///Params:
    ///    ec = Edit cookie obtained from ITfDocumentMgr::CreateContext or ITfEditSession::DoEditSession.
    ///    pWith = Pointer to a specified range in which an anchor is to be compared with this range end anchor.
    ///    aPos = Enumeration element that indicates which anchor of the specified <i>pWith</i> range to compare with this
    ///           range end anchor. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///           id="TF_ANCHOR_START"></a><a id="tf_anchor_start"></a><dl> <dt><b>TF_ANCHOR_START</b></dt> </dl> </td> <td
    ///           width="60%"> Compare this range end anchor with the specified range start anchor. </td> </tr> <tr> <td
    ///           width="40%"><a id="TF_ANCHOR_END"></a><a id="tf_anchor_end"></a><dl> <dt><b>TF_ANCHOR_END</b></dt> </dl>
    ///           </td> <td width="60%"> Compare this range end anchor with the specified range end anchor. </td> </tr>
    ///           </table>
    ///    plResult = Pointer to the result of the comparison between this range end anchor and the anchor of the specified
    ///               <i>pWith</i> range. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///               id="-1"></a><dl> <dt><b>-1</b></dt> </dl> </td> <td width="60%"> This end anchor is behind the anchor of the
    ///               specified range (position of this end anchor &lt; position of the anchor of the specified range). </td> </tr>
    ///               <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%"> This end anchor is at
    ///               the same position as the anchor of the specified range. </td> </tr> <tr> <td width="40%"><a id="_1"></a><dl>
    ///               <dt><b>+1</b></dt> </dl> </td> <td width="60%"> This end anchor is ahead of the anchor of the specified range
    ///               (position of this end anchor &gt; position of the anchor of the specified range). </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td
    ///    width="60%"> The value of the <i>ec</i> parameter is an invalid cookie, or the caller does not have a
    ///    read-only lock. </td> </tr> </table>
    ///    
    HRESULT CompareEnd(uint ec, ITfRange pWith, TfAnchor aPos, int* plResult);
    ///The <b>ITfRange::AdjustForInsert</b> method expands or contracts a range of text to adjust for text insertion.
    ///Params:
    ///    ec = Edit cookie obtained from ITfDocumentMgr::CreateContext or ITfEditSession::DoEditSession.
    ///    cchInsert = Character count of the inserted text. This count is used in a futurecall to ITfRange::SetText. If the
    ///                character count is unknown, 0 can be used.
    ///    pfInsertOk = Pointer to a flag that indicates whether the context owner will accept (<b>TRUE</b>) or reject (<b>FALSE</b>)
    ///                 the insertion.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%">
    ///    The application was unable to replace the selection. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The value in the <i>ec</i> parameter is an invalid
    ///    cookie, or the caller does not have a read-only lock. </td> </tr> </table>
    ///    
    HRESULT AdjustForInsert(uint ec, uint cchInsert, int* pfInsertOk);
    ///Obtains the gravity of the anchors in the object.
    ///Params:
    ///    pgStart = Pointer to a TfGravity value that receives the gravity of the start anchor.
    ///    pgEnd = Pointer to a <b>TfGravity</b> value that receives the gravity of the end anchor.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> </table>
    ///    
    HRESULT GetGravity(TfGravity* pgStart, TfGravity* pgEnd);
    ///Sets the gravity of the anchors in the object.
    ///Params:
    ///    ec = Contains an edit cookie that identifies the edit context obtained from ITfDocumentMgr::CreateContext or
    ///         ITfEditSession::DoEditSession.
    ///    gStart = Contains one of the TfGravity values that specifies the gravity of the start anchor.
    ///    gEnd = Contains one of the <b>TfGravity</b> values that specifies the gravity of the end anchor.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The cookie in
    ///    <i>ec</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT SetGravity(uint ec, TfGravity gStart, TfGravity gEnd);
    ///The <b>ITfRange::Clone</b> method duplicates this range of text.
    ///Params:
    ///    ppClone = Pointer to a new range object that references this range.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable
    ///    to generate a pointer to the new range. </td> </tr> </table>
    ///    
    HRESULT Clone(ITfRange* ppClone);
    ///Obtains the context object to which the range belongs.
    ///Params:
    ///    ppContext = Pointer to an ITfContext interface pointer that receives the context object that the range belongs to.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppContext</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetContext(ITfContext* ppContext);
}

///The <b>ITfRangeACP</b> interface is implemented by the TSF manager and is used by an application character position
///(ACP)-based application to access and manipulate range objects. This interface is derived from the ITfRange
///interface. Obtain an instance of this interface by querying an <b>ITfRange</b> object for IID_ITfRangeACP.
@GUID("057A6296-029B-4154-B79A-0D461D4EA94C")
interface ITfRangeACP : ITfRange
{
    ///Obtains the application character position and length of the range object.
    ///Params:
    ///    pacpAnchor = Pointer to a <b>LONG</b> value that receives the application character position of the range start anchor.
    ///    pcch = Pointer to a <b>LONG</b> value that receives the number of characters in the range.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetExtent(int* pacpAnchor, int* pcch);
    ///Sets the application character position and length of the range object.
    ///Params:
    ///    acpAnchor = Contains the application character position of the range start anchor.
    ///    cch = Contains the number of characters in the range.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT SetExtent(int acpAnchor, int cch);
}

///The <b>ITextStoreACPServices</b> interface is implemented by the TSF manager to provide various services to an
///ACP-based application. To obtain an instance of this interface, an application calls <b>QueryInterface</b> on the
///<i>punk</i> parameter passed to ITextStoreACP::AdviseSink with IID_ITextStoreACPServices.
@GUID("AA80E901-2021-11D2-93E0-0060B067B86E")
interface ITextStoreACPServices : IUnknown
{
    ///Obtains a property from a range of text and writes the property data into a stream object.
    ///Params:
    ///    pProp = Pointer to an ITfProperty interface that identifies the property to serialize.
    ///    pRange = Pointer to an ITfRange interface that identifies the range that the property is obtained from.
    ///    pHdr = Pointer to a TF_PERSISTENT_PROPERTY_HEADER_ACP structure that receives the header data for the property.
    ///    pStream = Pointer to an <b>IStream</b> object that the TSF manager will write the property data to.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The property cannot be
    ///    serialized. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Serialize(ITfProperty pProp, ITfRange pRange, TF_PERSISTENT_PROPERTY_HEADER_ACP* pHdr, IStream pStream);
    ///Takes previously serialized property data and applies it to a property object.
    ///Params:
    ///    pProp = Pointer to an ITfProperty object that receives the property data.
    ///    pHdr = Pointer to a TF_PERSISTENT_PROPERTY_HEADER_ACP structure that contains the header data for the property.
    ///    pStream = Pointer to an <b>IStream</b> object that contains the property data. This parameter can be <b>NULL</b> if
    ///              <i>pLoader</i> is not <b>NULL</b>. This parameter is ignored if <i>pLoader</i> is not <b>NULL</b>.
    ///    pLoader = Pointer to an ITfPersistentPropertyLoaderACP object that the TSF manager will use to obtain the property
    ///              data. This parameter can be <b>NULL</b> if <i>pStream</i> is not <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The property data will be
    ///    obtained asynchronously. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_SYNCHRONOUS</b></dt> </dl> </td>
    ///    <td width="60%"> A synchronous read-only lock cannot be obtained. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Unserialize(ITfProperty pProp, const(TF_PERSISTENT_PROPERTY_HEADER_ACP)* pHdr, IStream pStream, 
                        ITfPersistentPropertyLoaderACP pLoader);
    ///Forces all values of an asynchronously loaded property to be loaded.
    ///Params:
    ///    pProp = Pointer to an ITfProperty object that specifies the property to load.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT ForceLoadProperty(ITfProperty pProp);
    ///Creates a range object from two ACP values.
    ///Params:
    ///    acpStart = Contains the starting position of the range.
    ///    acpEnd = Contains the ending position of the range.
    ///    ppRange = Pointer to an ITfRangeACP interface pointer that receives the range object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppRange</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT CreateRange(int acpStart, int acpEnd, ITfRangeACP* ppRange);
}

///The <b>ITfRangeBackup</b> interface is implemented by the TSF manager and is used by a text service to create a
///backup copy of the data contained in a range object. This backup copy can be used later to restore the range object.
///An instance of this interface is obtained by calling ITfContext::CreateRangeBackup.
@GUID("463A506D-6992-49D2-9B88-93D55E70BB16")
interface ITfRangeBackup : IUnknown
{
    ///Restores a specified range object into the TSF context.
    ///Params:
    ///    ec = Contains an edit cookie that identifies the edit session. This is the value passed to
    ///         ITfEditSession::DoEditSession.
    ///    pRange = Pointer to an ITfRange object that receives the backup information. If this parameter is <b>NULL</b>, the
    ///             backup information is restored into a copy of the range originally backed up by
    ///             <b>ITfContext::CreateRangeBackup</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_DISCONNECTED</b></dt> </dl> </td> <td width="60%"> The context is not
    ///    on a document stack. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td
    ///    width="60%"> The edit cookie specified by <i>ec</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pRange</i> is invalid. </td>
    ///    </tr> </table>
    ///    
    HRESULT Restore(uint ec, ITfRange pRange);
}

///The <b>ITfPropertyStore</b> interface is implemented by a text service and used by the TSF manager to provide
///non-static property values. An instance of this interface is passed to ITfProperty::SetValueStore.
@GUID("6834B120-88CB-11D2-BF45-00105A2799B5")
interface ITfPropertyStore : IUnknown
{
    ///Obtains the property identifier.
    ///Params:
    ///    pguid = Pointer to a <b>GUID</b> value that receives the property identifier.
    HRESULT GetType(GUID* pguid);
    ///This method is reserved, but must be implemented.
    ///Params:
    ///    pdwReserved = Pointer to a <b>DWORD</b> value the receives the data type. This parameter is reserved and must be set to
    ///                  zero.
    HRESULT GetDataType(uint* pdwReserved);
    ///Obtains the property store data.
    ///Params:
    ///    pvarValue = Pointer to a <b>VARIANT</b> value that receives property data.
    HRESULT GetData(VARIANT* pvarValue);
    ///Called when the text that the property store applies to is modified.
    ///Params:
    ///    dwFlags = Contains a set of flags that provide additional information about the text change. This can be zero or the
    ///              following value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///              id="TF_TU_CORRECTION"></a><a id="tf_tu_correction"></a><dl> <dt><b>TF_TU_CORRECTION</b></dt> </dl> </td> <td
    ///              width="60%"> The text change is the result of a correction. This implies that the semantics of the text have
    ///              not changed. An example of this is when the spelling checker corrects a misspelled word. </td> </tr> </table>
    ///    pRangeNew = Pointer to an ITfRange interface that contains the range of text modified.
    ///    pfAccept = Pointer to a <b>BOOL</b> variable that receives a value that indicates if the property store should be
    ///               retained. Receives a nonzero value if the property store should be retained or zero if the property store
    ///               should be discarded. If the property store is discarded, the TSF manager will set the property value to
    ///               VT_EMPTY and release the property store.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnTextUpdated(uint dwFlags, ITfRange pRangeNew, int* pfAccept);
    ///Called when the text that the property store applies to is truncated.
    ///Params:
    ///    pRangeNew = Pointer to an ITfRange interface that contains the truncated range.
    ///    pfFree = Pointer to a <b>BOOL</b> variable that receives a value that indicates if the property store should be
    ///             retained. Receives a nonzero value if the property store should be retained or zero if the property store
    ///             should be discarded. If the property store is discarded, the TSF manager will set the property value to
    ///             VT_EMPTY and release the property store.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT Shrink(ITfRange pRangeNew, int* pfFree);
    ///Called when the text covered by the property is split into two ranges.
    ///Params:
    ///    pRangeThis = Pointer to an ITfRange object that contains the range that the property store now covers. This will be the
    ///                 range of text closest to the beginning of the context.
    ///    pRangeNew = Pointer to an <i>ITfRange</i> object that contains the range that the new property store will cover. This
    ///                will be the range of text closest to the end of the context.
    ///    ppPropStore = Pointer to an ITfPropertyStore interface pointer that receives a new property store object that will cover
    ///                  the range specified by <i>pRangeNew</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT Divide(ITfRange pRangeThis, ITfRange pRangeNew, ITfPropertyStore* ppPropStore);
    ///Creates an exact copy of the property store object.
    ///Params:
    ///    pPropStore = Pointer to an ITfPropertyStore interface pointer that receives the new property store object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    failure occurred. </td> </tr> </table>
    ///    
    HRESULT Clone(ITfPropertyStore* pPropStore);
    ///Obtains the class identifier of the property store owner.
    ///Params:
    ///    pclsid = Pointer to a <b>CLSID</b> that receives the class identifier of the registered text service that implements
    ///             ITfCreatePropertyStore. The method can return CLSID_NULL for this parameter if property store persistence is
    ///             unsupported.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetPropertyRangeCreator(GUID* pclsid);
    ///Called to write the property store data into a stream for serialization.
    ///Params:
    ///    pStream = Pointer to an <b>IStream</b> object that the property store data is written to.
    ///    pcb = Pointer to a <b>ULONG</b> value that receives the number of bytes written to the stream.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> </table>
    ///    
    HRESULT Serialize(IStream pStream, uint* pcb);
}

///The <b>IEnumTfRanges</b> interface is implemented by the TSF manager to provide an enumeration of range objects.
@GUID("F99D3F40-8E32-11D2-BF46-00105A2799B5")
interface IEnumTfRanges : IUnknown
{
    ///Creates a copy of the enumerator object.
    ///Params:
    ///    ppEnum = Pointer to an IEnumTfRanges interface pointer that receives the new enumerator.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    failure occurred. </td> </tr> </table>
    ///    
    HRESULT Clone(IEnumTfRanges* ppEnum);
    ///Obtains, from the current position, the specified number of elements in the enumeration sequence.
    ///Params:
    ///    ulCount = Specifies the number of elements to obtain.
    ///    ppRange = Pointer to an array of ITfRange interface pointers that receives the requested objects. This array must be at
    ///              least <i>ulCount</i> elements in size.
    ///    pcFetched = Pointer to a ULONG value that receives the number of elements actually obtained. This value can be less than
    ///                the number of items requested. This parameter can be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements could be obtained. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppRange</i> is invalid. </td> </tr>
    ///    </table>
    ///    
    HRESULT Next(uint ulCount, char* ppRange, uint* pcFetched);
    ///Resets the enumerator object by moving the current position to the beginning of the enumeration sequence.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT Reset();
    ///Moves the current position forward in the enumeration sequence by the specified number of elements.
    ///Params:
    ///    ulCount = Contains the number of elements to skip.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements could be skipped. </td> </tr> </table>
    ///    
    HRESULT Skip(uint ulCount);
}

///The <b>ITfCreatePropertyStore</b> interface is implemented by a text service to support persistence of property store
///data. The TSF manager uses this interface to determine if a property store can be serialized and to create a property
///store object for a serialized property.
@GUID("2463FBF0-B0AF-11D2-AFC5-00105A2799B5")
interface ITfCreatePropertyStore : IUnknown
{
    ///Determines if a property store can be stored as persistent data.
    ///Params:
    ///    guidProp = Contains the type identifier of the property. For more information, see ITfPropertyStore::GetType.
    ///    pRange = Pointer to an ITfRange object that contains the text covered by the property store.
    ///    pPropStore = Pointer to the ITfPropertyStore object.
    ///    pfSerializable = Pointer to a <b>BOOL</b> that receives a flag that indicates if the property store can be serialized.
    ///                     Receives nonzero if the property store can be serialized or zero otherwise.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT IsStoreSerializable(const(GUID)* guidProp, ITfRange pRange, ITfPropertyStore pPropStore, 
                                int* pfSerializable);
    ///Creates a property store object from serialized property store data.
    ///Params:
    ///    guidProp = Contains the type identifier of the property. For more information, see ITfPropertyStore::GetType.
    ///    pRange = Pointer to an ITfRange object that contains the text to be covered by the property store.
    ///    cb = Contains the size, in bytes, of the property store data contained in <i>pStream</i>.
    ///    pStream = Pointer to an <b>IStream</b> object that contains the property store data.
    ///    ppStore = Pointer to an ITfPropertyStore interface pointer that receives the property store object created by this
    ///              method.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT CreatePropertyStore(const(GUID)* guidProp, ITfRange pRange, uint cb, IStream pStream, 
                                ITfPropertyStore* ppStore);
}

///The <b>ITfPersistentPropertyLoaderACP</b> interface is implemented by an application and used by the TSF manager to
///load properties asynchronously. An application passes an instance of this interface when calling
///ITextStoreACPServices::Unserialize. When properties are loaded by a call to <b>ITextStoreACPServices::Unserialize</b>
///, this interface is used to load properties when required rather than all at once.
@GUID("4EF89150-0807-11D3-8DF0-00105A2799B5")
interface ITfPersistentPropertyLoaderACP : IUnknown
{
    ///Called to load a property.
    ///Params:
    ///    pHdr = Pointer to a TF_PERSISTENT_PROPERTY_HEADER_ACP structure that identifies the property to load. This structure
    ///           contains the same data as the structure passed to ITextStoreACPServices::Unserialize.
    ///    ppStream = Pointer to an <b>IStream</b> interface pointer that receives the stream object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> A memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT LoadProperty(const(TF_PERSISTENT_PROPERTY_HEADER_ACP)* pHdr, IStream* ppStream);
}

///The <b>ITfProperty</b> interface is implemented by the TSF manager and used by a client (application or text service)
///to modify a property value.
@GUID("E2449660-9542-11D2-BF46-00105A2799B5")
interface ITfProperty : ITfReadOnlyProperty
{
    ///Obtains a range that covers the text that contains a non-empty value for the property.
    ///Params:
    ///    ec = Contains an edit cookie that identifies the edit context. This is obtained from ITfDocumentMgr::CreateContext
    ///         or ITfEditSession::DoEditSession.
    ///    pRange = Pointer to an ITfRange interface that contains the point to obtain the property range for. The point will
    ///             either be the start anchor or end anchor of this range, based upon the value of <i>aPos</i>.
    ///    ppRange = Pointer to an <b>ITfRange</b> interface pointer that receives the requested range object.
    ///    aPos = Contains one of the TfAnchor values which specifies which anchor of <i>pRange</i> is used as the point to
    ///           obtain the property range for.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> <i>pRange</i> is not over, or
    ///    adjacent to, the property. <i>ppRange</i> receives <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters are invalid. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    failure occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%">
    ///    An unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td>
    ///    <td width="60%"> The edit context identified by <i>ec</i> does not have a read-only or read/write lock. </td>
    ///    </tr> </table>
    ///    
    HRESULT FindRange(uint ec, ITfRange pRange, ITfRange* ppRange, TfAnchor aPos);
    ///Sets the value of the property for a range of text using a property store object.
    ///Params:
    ///    ec = Contains an edit cookie that identifies the edit context. This is obtained from ITfDocumentMgr::CreateContext
    ///         or ITfEditSession::DoEditSession.
    ///    pRange = Pointer to an ITfRange interface that contains the range that the property value is set for. This parameter
    ///             cannot be <b>NULL</b>. This method fails if <i>pRange</i> is empty.
    ///    pPropStore = Pointer to an ITfPropertyStore interface that obtains the property data.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td>
    ///    <td width="60%"> The edit context identified by <i>ec</i> does not have a read/write lock. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetValueStore(uint ec, ITfRange pRange, ITfPropertyStore pPropStore);
    ///Sets the value of the property for a range.
    ///Params:
    ///    ec = Contains an edit cookie that identifies the edit context. This is obtained from ITfDocumentMgr::CreateContext
    ///         or ITfEditSession::DoEditSession.
    ///    pRange = Pointer to an ITfRange interface that contains the range that the property value is set for. This parameter
    ///             cannot be <b>NULL</b>. This method will fail if <i>pRange</i> is empty.
    ///    pvarValue = Pointer to a <b>VARIANT</b> structure that contains the new property value. Only values of type VT_I4,
    ///                VT_UNKNOWN, VT_BSTR and VT_EMPTY are supported.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> A memory allocation failure occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The edit context identified by
    ///    <i>ec</i> does not have a read/write lock. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_READONLY</b></dt> </dl> </td> <td width="60%"> The edit context is read-only. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>TF_E_NOTOWNEDRANGE</b></dt> </dl> </td> <td width="60%"> The TSF manager does
    ///    not own the range. </td> </tr> </table>
    ///    
    HRESULT SetValue(uint ec, ITfRange pRange, const(VARIANT)* pvarValue);
    ///Empties the property value over the specified range.
    ///Params:
    ///    ec = Contains an edit cookie that identifies the edit context. This is obtained from ITfDocumentMgr::CreateContext
    ///         or ITfEditSession::DoEditSession.
    ///    pRange = Pointer to an ITfRange interface that contains the range that the property is cleared for. If this parameter
    ///             is <b>NULL</b>, all values for this property over the entire edit context are cleared.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pRange</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TF_E_NOLOCK</b></dt> </dl> </td> <td width="60%"> The
    ///    edit context identified by <i>ec</i> does not have a read/write lock. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TF_E_READONLY</b></dt> </dl> </td> <td width="60%"> The edit context is read-only. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>TF_E_NOTOWNEDRANGE</b></dt> </dl> </td> <td width="60%"> The TSF manager does
    ///    not own the range. </td> </tr> </table>
    ///    
    HRESULT Clear(uint ec, ITfRange pRange);
}

///The <b>IEnumTfProperties</b> interface is implemented by the TSF manager to provide an enumeration of property
///objects.
@GUID("19188CB0-ACA9-11D2-AFC5-00105A2799B5")
interface IEnumTfProperties : IUnknown
{
    ///Creates a copy of the enumerator object.
    ///Params:
    ///    ppEnum = Pointer to an IEnumTfProperties interface pointer that receives the new enumerator.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    failure occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td
    ///    width="60%"> The method is not implemented. </td> </tr> </table>
    ///    
    HRESULT Clone(IEnumTfProperties* ppEnum);
    ///Obtains, from the current position, the specified number of elements in the enumeration sequence.
    ///Params:
    ///    ulCount = Specifies the number of elements to obtain.
    ///    ppProp = Pointer to an array of ITfProperty interface pointers that receives the requested objects. This array must be
    ///             at least <i>ulCount</i> elements in size.
    ///    pcFetched = Pointer to a ULONG that receives the number of elements obtained. This value can be less than the number of
    ///                items requested. This parameter can be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements could be obtained. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppProp</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT Next(uint ulCount, char* ppProp, uint* pcFetched);
    ///Resets the enumerator object by moving the current position to the beginning of the enumeration sequence.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT Reset();
    ///Moves the current position forward in the enumeration sequence by the specified number of elements.
    ///Params:
    ///    ulCount = Contains the number of elements to skip.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements could be skipped. </td> </tr> </table>
    ///    
    HRESULT Skip(uint ulCount);
}

///The <b>ITfCompartment</b> interface is implemented by the TSF manager and is used by clients (applications and text
///services) to obtain and set data in a TSF compartment. A client also uses this interface to obtain an ITfSource
///interface that is used to install an ITfCompartmentEventSink compartment change notification sink. The client calls
///<b>ITfCompartment::QueryInterface</b> with IID_ITfSource to obtain the <b>ITfSource</b> interface.
@GUID("BB08F7A9-607A-4384-8623-056892B64371")
interface ITfCompartment : IUnknown
{
    ///Sets the data for a compartment.
    ///Params:
    ///    tid = Contains a TfClientId value that identifies the client.
    ///    pvarValue = Pointer to a VARIANT structure that contains the data to be set. Only VT_I4, VT_UNKNOWN and VT_BSTR data
    ///                types are allowed.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>pvarValue</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td>
    ///    <td width="60%"> The compartment was cleared by a call to ITfCompartmentMgr::ClearCompartment, this method
    ///    was called during a ITfCompartmentEventSink::OnChange notification or only the owner can clear this
    ///    compartment. </td> </tr> </table>
    ///    
    HRESULT SetValue(uint tid, const(VARIANT)* pvarValue);
    ///Obtains the data for a compartment.
    ///Params:
    ///    pvarValue = Pointer to a <b>VARIANT</b> structure that receives the data. This receives VT_EMPTY if the compartment has
    ///                no value. The caller must free this data when it is no longer required by calling VariantClear.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The compartment has no value.
    ///    <i>pvarValue</i> receives VT_EMPTY. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl>
    ///    </td> <td width="60%"> The compartment has been cleared by a call to ITfCompartmentMgr::ClearCompartment.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>pvarValue</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT GetValue(VARIANT* pvarValue);
}

///The <b>ITfCompartmentEventSink</b> interface is implemented by a client (application or text service) and used by the
///TSF manager to notify the client when compartment data changes. This notification sink is installed by obtaining an
///ITfSource interface from the ITfCompartment object and calling ITfSource::AdviseSink with IID_ITfCompartmentEventSink
///and a pointer to the <b>ITfCompartmentEventSink</b> object.
@GUID("743ABD5F-F26D-48DF-8CC5-238492419B64")
interface ITfCompartmentEventSink : IUnknown
{
    ///Called when compartment data changes.
    ///Params:
    ///    rguid = Contains a GUID that identifies the compartment that changed.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnChange(const(GUID)* rguid);
}

///The <b>ITfCompartmentMgr</b> interface is implemented by the TSF manager and used by clients (applications and text
///services) to obtain and manipulate TSF compartments.
@GUID("7DCF57AC-18AD-438B-824D-979BFFB74B7C")
interface ITfCompartmentMgr : IUnknown
{
    ///Obtains the compartment object for a specified compartment.
    ///Params:
    ///    rguid = Contains a GUID that identifies the compartment.
    ///    ppcomp = Pointer to an ITfCompartment interface pointer that receives the compartment object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppcomp</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A
    ///    memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT GetCompartment(const(GUID)* rguid, ITfCompartment* ppcomp);
    ///Removes the specified compartment.
    ///Params:
    ///    tid = Contains a TfClientId value that identifies the client.
    ///    rguid = Contains a GUID that identifies the compartment.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>CONNECT_E_NOCONNECTION</b></dt> </dl> </td> <td width="60%"> The
    ///    compartment cannot be found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The owner must clear this compartment. </td> </tr>
    ///    </table>
    ///    
    HRESULT ClearCompartment(uint tid, const(GUID)* rguid);
    ///The <b>ITfCompartmentMgr::EnumCompartments</b> method obtains an enumerator that contains the GUID of the
    ///compartments within the compartment manager.
    ///Params:
    ///    ppEnum = Pointer to an <b>IEnumGUID</b> interface pointer that receives the enumerator object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>ppcEnum</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> A memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT EnumCompartments(IEnumGUID* ppEnum);
}

///The <b>ITfFunction</b> interface is the base interface for the individual function interfaces. This interface is
///implemented by the provider of the function object and used by any component to obtain the display name of the
///function object. Instances of this interface are not obtained directly. This interface is always part of a derived
///interface, such as ITfFnShowHelp.
@GUID("DB593490-098F-11D3-8DF0-00105A2799B5")
interface ITfFunction : IUnknown
{
    ///Obtains the function display name.
    ///Params:
    ///    pbstrName = Pointer to a BSTR value that receives the display name. This value must be allocated using SysAllocString.
    ///                The caller must free this memory using SysFreeString when it is no longer required.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    failure occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>pbstrName</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT GetDisplayName(BSTR* pbstrName);
}

///The <b>ITfFunctionProvider</b> interface is implemented by an application or text service to provide various function
///objects.
@GUID("101D6610-0990-11D3-8DF0-00105A2799B5")
interface ITfFunctionProvider : IUnknown
{
    ///Obtains the type identifier for the function provider.
    ///Params:
    ///    pguid = Pointer to a GUID value that receives the type identifier of the function provider.
    HRESULT GetType(GUID* pguid);
    ///Obtains the description of the function provider.
    ///Params:
    ///    pbstrDesc = Pointer to a BSTR that receives the description string. This value must be allocated using SysAllocString.
    ///                The caller must this memory using SysFreeString when it is no longer required.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    failure occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>pbstrDesc</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT GetDescription(BSTR* pbstrDesc);
    ///Obtains the specified function object.
    ///Params:
    ///    rguid = Contains a GUID value that identifies the function group that the requested function belongs to. This value
    ///            can be GUID_NULL.
    ///    riid = Contains an interface identifier that identifies the requested function within the group specified by
    ///           <i>rguid</i>. This value can be specified by the application, text service, or one of the IID_ITfFn* values.
    ///    ppunk = Pointer to an <b>IUnknown</b> interface pointer that receives the requested function interface.
    HRESULT GetFunction(const(GUID)* rguid, const(GUID)* riid, IUnknown* ppunk);
}

///The <b>IEnumTfFunctionProviders</b> interface is implemented by the TSF manager to provide an enumeration of function
///provider objects.
@GUID("E4B24DB0-0990-11D3-8DF0-00105A2799B5")
interface IEnumTfFunctionProviders : IUnknown
{
    ///Creates a copy of the enumerator object.
    ///Params:
    ///    ppEnum = Pointer to an IEnumTfFunctionProviders interface pointer that receives the new enumerator.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    failure occurred. </td> </tr> </table>
    ///    
    HRESULT Clone(IEnumTfFunctionProviders* ppEnum);
    ///Obtains, from the current position, the specified number of elements in the enumeration sequence.
    ///Params:
    ///    ulCount = Specifies the number of elements to obtain.
    ///    ppCmdobj = Pointer to an array of ITfFunctionProvider interface pointers that receives the requested objects. This array
    ///               must be at least <i>ulCount</i> elements in size.
    ///    pcFetch = Pointer to a ULONG value that receives the number of elements obtained. This value can be less than the
    ///              number of items requested. This parameter can be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements could be obtained. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppCmdobj</i> is invalid. </td> </tr>
    ///    </table>
    ///    
    HRESULT Next(uint ulCount, char* ppCmdobj, uint* pcFetch);
    ///Resets the enumerator object by moving the current position to the beginning of the enumeration sequence.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT Reset();
    ///Moves the current position forward in the enumeration sequence by the specified number of elements.
    ///Params:
    ///    ulCount = Contains the number of elements to skip.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements could be skipped. </td> </tr> </table>
    ///    
    HRESULT Skip(uint ulCount);
}

///The <b>ITfInputProcessorProfiles</b> interface is implemented by the TSF manager and used by an application or text
///service to manipulate the language profile of one or more text services.
@GUID("1F02B6C5-7842-4EE6-8A0B-9A24183A95CA")
interface ITfInputProcessorProfiles : IUnknown
{
    ///Adds a text service to Text Services Foundation (TSF).
    ///Params:
    ///    rclsid = Contains the CLSID of the text service to register.
    HRESULT Register(const(GUID)* rclsid);
    ///Removes a text service from TSF.
    ///Params:
    ///    rclsid = Contains the text service CLSID to unregister.
    HRESULT Unregister(const(GUID)* rclsid);
    ///Creates a language profile that consists of a specific text service and a specific language identifier.
    ///Params:
    ///    rclsid = Contains the text service CLSID.
    ///    langid = Contains a <b>LANGID</b> value that specifies the language identifier of the profile that the text service is
    ///             added to. If this contains -1, the text service is added to all languages.
    ///    guidProfile = Contains a GUID value that identifies the language profile. This is the value obtained by
    ///                  ITfInputProcessorProfiles::GetActiveLanguageProfile when the profile is active.
    ///    pchDesc = Pointer to a <b>WCHAR</b> buffer that contains the description string for the text service in the profile.
    ///              This is the text service name displayed in the language bar.
    ///    cchDesc = Contains the length, in characters, of the description string in <i>pchDesc</i>. If this contains -1,
    ///              <i>pchDesc</i> is assumed to be a <b>NULL</b>-terminated string.
    ///    pchIconFile = Pointer to a <b>WCHAR</b> buffer that contains the path and file name of the file that contains the icon to
    ///                  be displayed in the language bar for the text service in the profile. This file can be an executable (.exe),
    ///                  DLL (.dll) or icon (.ico) file. This parameter is optional and can be <b>NULL</b>. In this case, a default
    ///                  icon is displayed for the text service.
    ///    cchFile = Contains the length, in characters, of the icon file string in <i>pchIconFile</i>. If this contains -1,
    ///              <i>pchIconFile</i> is assumed to be a <b>NULL</b>-terminated string. This parameter is ignored if
    ///              <i>pchIconFile</i> is <b>NULL</b>.
    ///    uIconIndex = Contains the zero-based index of the icon in <i>pchIconFile</i> to be displayed in the language bar for the
    ///                 text service in the profile. This parameter is ignored if <i>pchIconFile</i> is <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>pszDesc</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT AddLanguageProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, const(wchar)* pchDesc, 
                               uint cchDesc, const(wchar)* pchIconFile, uint cchFile, uint uIconIndex);
    ///Removes a language profile.
    ///Params:
    ///    rclsid = Contains the text service CLSID.
    ///    langid = Contains a <b>LANGID</b> value that specifies the language identifier of the profile.
    ///    guidProfile = Contains a GUID value that identifies the language profile. This is the value specified in
    ///                  ITfInputProcessorProfiles::AddLanguageProfile when the profile was added.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT RemoveLanguageProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile);
    ///Obtains an enumerator that contains the class identifiers of all registered text services.
    ///Params:
    ///    ppEnum = Pointer to an <b>IEnumGUID</b> interface pointer that receives the enumerator object. The enumerator contains
    ///             the CLSID for each registered text service. The caller must release this object when it is no longer
    ///             required.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>ppEnum</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> A memory allocation error occurred. </td> </tr> </table>
    ///    
    HRESULT EnumInputProcessorInfo(IEnumGUID* ppEnum);
    ///Obtains the default profile for a specific language.
    ///Params:
    ///    langid = Contains a <b>LANGID</b> value that specifies which language to obtain the default profile for.
    ///    catid = Contains a GUID value that identifies the category that the text service is registered under. This can be a
    ///            user-defined category or one of the predefined category values.
    ///    pclsid = Pointer to a <b>CLSID</b> value that receives the class identifier of the default text service for the
    ///             language.
    ///    pguidProfile = Pointer to a <b>GUID</b> value that receives the identifier of the default profile for the language.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> No default language profile
    ///    was found for the specified language and category. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters are
    ///    invalid. </td> </tr> </table>
    ///    
    HRESULT GetDefaultLanguageProfile(ushort langid, const(GUID)* catid, GUID* pclsid, GUID* pguidProfile);
    ///Sets the default profile for a specific language.
    ///Params:
    ///    langid = Contains a LANGID value that specifies which language to set the default profile for.
    ///    rclsid = Contains the CLSID of the text service that will be the default for the language.
    ///    guidProfiles = Contains a GUID value that identifies the language profile that will be the default.
    HRESULT SetDefaultLanguageProfile(ushort langid, const(GUID)* rclsid, const(GUID)* guidProfiles);
    ///Sets the active text service for a specific language.
    ///Params:
    ///    rclsid = Contains the CLSID of the text service to make active.
    ///    langid = Contains a <b>LANGID</b> value that specifies which language to set the default profile for. This method
    ///             fails if this is not the currently active language.
    ///    guidProfiles = Contains a GUID value that identifies the language profile to make active.
    HRESULT ActivateLanguageProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfiles);
    ///Obtains the identifier of the currently active language profile for a specific text service.
    ///Params:
    ///    rclsid = Contains the text service CLSID.
    ///    plangid = Pointer to a <b>LANGID</b> value that receives the active profile language identifier.
    ///    pguidProfile = Pointer to a <b>GUID</b> value that receives the language profile identifier. This is the value specified in
    ///                   ITfInputProcessorProfiles::AddLanguageProfile when the profile was added.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The text service identified
    ///    by <i>rclsid</i> is not currently active. <i>pguidProfile</i> receives GUID_NULL. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> A memory allocation error occurred. </td> </tr> </table>
    ///    
    HRESULT GetActiveLanguageProfile(const(GUID)* rclsid, ushort* plangid, GUID* pguidProfile);
    ///Obtains the description string for a language profile.
    ///Params:
    ///    rclsid = Contains the CLSID of the text service to obtain the profile description for.
    ///    langid = Contains a <b>LANGID</b> value that specifies which language to obtain the profile description for.
    ///    guidProfile = Contains a GUID value that identifies the language to obtain the profile description for.
    ///    pbstrProfile = Pointer to a <b>BSTR</b> value that receives the description string. The caller is responsible for freeing
    ///                   this memory using SysFreeString when it is no longer required.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>pbstrProfile</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT GetLanguageProfileDescription(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, 
                                          BSTR* pbstrProfile);
    ///Obtains the identifier of the currently active language.
    ///Params:
    ///    plangid = Pointer to a <b>LANGID</b> value that receives the language identifier of the currently active language.
    HRESULT GetCurrentLanguage(ushort* plangid);
    ///Sets the currently active language.
    ///Params:
    ///    langid = Contains the <b>LANGID</b> of the language to make active.
    HRESULT ChangeCurrentLanguage(ushort langid);
    ///Obtains a list of the installed languages.
    ///Params:
    ///    ppLangId = Pointer to a <b>LANGID</b> pointer that receives the array of identifiers of the currently installed
    ///               languages. The number of identifiers placed in this array is supplied in <i>pulCount</i>. The array is
    ///               allocated by this method. The caller must free this memory when it is no longer required using CoTaskMemFree.
    ///    pulCount = Pointer to a ULONG value the receives the number of identifiers placed in the array at <i>ppLangId</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> A memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT GetLanguageList(char* ppLangId, uint* pulCount);
    ///Obtains an enumerator that contains all of the profiles for a specific langauage.
    ///Params:
    ///    langid = Contains a <b>LANGID</b> value that specifies the language to obtain an enumerator for.
    ///    ppEnum = Pointer to an IEnumTfLanguageProfiles interface pointer that receives the enumerator object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> No corresponding language
    ///    profile was found in the operating system.<div> </div>-or-<div> </div> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppEnum</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A
    ///    memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT EnumLanguageProfiles(ushort langid, IEnumTfLanguageProfiles* ppEnum);
    ///Enables or disables a language profile for the current user.
    ///Params:
    ///    rclsid = Contains the CLSID of the text service of the profile to be enabled or disabled.
    ///    langid = Contains a <b>LANGID</b> value that specifies the language of the profile to be enabled or disabled.
    ///    guidProfile = Contains a GUID value that identifies the profile to be enabled or disabled.
    ///    fEnable = Contains a <b>BOOL</b> value that specifies if the profile will be enabled or disabled. If this contains a
    ///              nonzero value, the profile will be enabled. If this contains zero, the profile will be disabled.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT EnableLanguageProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, BOOL fEnable);
    ///Determines if a specific language profile is enabled or disabled.
    ///Params:
    ///    rclsid = Contains the CLSID of the text service of the profile in question.
    ///    langid = Contains a <b>LANGID</b> value that specifies the language of the profile in question.
    ///    guidProfile = Contains a GUID value that identifies the profile in question.
    ///    pfEnable = Pointer to a <b>BOOL</b> value that receives a value that specifies if the profile is enabled or disabled. If
    ///               this receives a nonzero value, the profile is enabled. If this receives zero, the profile is disabled.
    HRESULT IsEnabledLanguageProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, int* pfEnable);
    ///Enables or disables a language profile by default for all users.
    ///Params:
    ///    rclsid = Contains the CLSID of the text service of the profile to be enabled or disabled.
    ///    langid = Contains a <b>LANGID</b> value that specifies the language of the profile to be enabled or disabled.
    ///    guidProfile = Contains a GUID value that identifies the profile to be enabled or disabled.
    ///    fEnable = Contains a <b>BOOL</b> value that specifies if the profile is enabled or disabled. If this contains a nonzero
    ///              value, the profile is enabled. If this contains zero, the profile is disabled.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT EnableLanguageProfileByDefault(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, 
                                           BOOL fEnable);
    ///Sets a substitute keyboard layout for the specified language profile.
    ///Params:
    ///    rclsid = Contains the CLSID of the text service of the profile in question.
    ///    langid = Contains a <b>LANGID</b> value that specifies the language of the profile in question.
    ///    guidProfile = Contains a GUID value that identifies the profile in question.
    ///    hKL = Contains an <b>HKL</b> value that specifies the input locale identifier for the substitute keyboard. Obtain
    ///          this value by calling LoadKeyboardLayout.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT SubstituteKeyboardLayout(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, ptrdiff_t hKL);
}

///This interface is implemented by the TSF manager and used by a text service or application to set the display
///description of the language profile. To obtain an instance of this interface, call
///<b>ITfInputProcessorProfiles::QueryInterface</b> with <b>IID_ITfInputProcessorProfilesEx</b>.
@GUID("892F230F-FE00-4A41-A98E-FCD6DE0D35EF")
interface ITfInputProcessorProfilesEx : ITfInputProcessorProfiles
{
    ///Redistributable: Requires TSF 1.0 on Windows 2000. Header: Declared in Msctf.idl and Msctf.h. Library: Included
    ///as a resource in Msctf.dll.
    ///Params:
    ///    rclsid = 
    ///    langid = 
    ///    guidProfile = 
    ///    pchFile = 
    ///    cchFile = 
    ///    uResId = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetLanguageProfileDisplayName(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, 
                                          const(wchar)* pchFile, uint cchFile, uint uResId);
}

///This interface is implemented by the TSF manager and is used by an application or text service to manipulate the
///substitute input locale identifier (keyboard layout) of a text service profile. The interface ID is
///IID_ITfInputProcessorProfileSubstituteLayout.
@GUID("4FD67194-1002-4513-BFF2-C0DDF6258552")
interface ITfInputProcessorProfileSubstituteLayout : IUnknown
{
    ///Retrieves the input locale identifier (keyboard layout).
    ///Params:
    ///    rclsid = Contains the class identifier of the text service.
    ///    langid = Specifies the language of the profile. See Language Identifiers.
    ///    guidProfile = Identifies the profile GUID.
    ///    phKL = Pointer to an <b>HKL</b> value that specifies the substitute input locale identifier.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetSubstituteKeyboardLayout(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, 
                                        ptrdiff_t* phKL);
}

///The <b>ITfActiveLanguageProfileNotifySink</b> interface is implemented by an application to receive a notification
///when the active language or text service changes. To install the advise sink, obtain an ITfSource object from an
///ITfThreadMgr object by calling <b>ITfThreadMgr::QueryInterface</b> with IID_ITfActiveLanguageProfileNotifySink. Then
///call ITfSource::AdviseSink with IID_ITfActiveLanguageProfileNotifySink.
@GUID("B246CB75-A93E-4652-BF8C-B3FE0CFD7E57")
interface ITfActiveLanguageProfileNotifySink : IUnknown
{
    ///Called when the active language or text service changes.
    ///Params:
    ///    clsid = CLSID of the TSF text service activated or deactivated. This will be **NULL** for a language change.
    ///    guidProfile = Profile GUID for the TSF text service. This is specified by the TSF text service when it is installed. This
    ///                  will be <b>NULL</b> for a language change.
    ///    fActivated = TRUE if the TSF text service is activated or FALSE if the TSF text service is deactivated.
    ///Returns:
    ///    If this method succeeds, it returns **S_OK**. Otherwise, it returns an **HRESULT** error code.
    ///    
    HRESULT OnActivated(const(GUID)* clsid, const(GUID)* guidProfile, BOOL fActivated);
}

///The <b>IEnumTfLanguageProfiles</b> interface is implemented by the TSF manager to provide an enumeration of language
///profiles.
@GUID("3D61BF11-AC5F-42C8-A4CB-931BCC28C744")
interface IEnumTfLanguageProfiles : IUnknown
{
    ///Creates a copy of the enumerator object.
    ///Params:
    ///    ppEnum = Pointer to an IEnumTfLanguageProfiles interface pointer that receives the new enumerator.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    failure occurred. </td> </tr> </table>
    ///    
    HRESULT Clone(IEnumTfLanguageProfiles* ppEnum);
    ///Obtains, from the current position, the specified number of elements in the enumeration sequence.
    ///Params:
    ///    ulCount = Specifies the number of elements to obtain.
    ///    pProfile = Pointer to an array of TF_LANGUAGEPROFILE structures that receives the requested data. This array must be at
    ///               least <i>ulCount</i> elements in size.
    ///    pcFetch = Pointer to a ULONG value that receives the number of elements obtained. This value can be less than the
    ///              number of items requested. This parameter can be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements could be obtained. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pProfile</i> is invalid. </td> </tr>
    ///    </table>
    ///    
    HRESULT Next(uint ulCount, char* pProfile, uint* pcFetch);
    ///Resets the enumerator object by moving the current position to the beginning of the enumeration sequence.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT Reset();
    ///Moves the current position forward in the enumeration sequence by the specified number of elements.
    ///Params:
    ///    ulCount = Contains the number of elements to skip.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements could be skipped. </td> </tr> </table>
    ///    
    HRESULT Skip(uint ulCount);
}

///The <b>ITfLanguageProfileNotifySink</b> interface is implemented by an application to receive notifications when the
///language profile changes. To install this advise sink, obtain an ITfSource object from an ITfInputProcessorProfiles
///object by calling <b>ITfInputProcessorProfiles::QueryInterface</b> with <b>IID_ITfSource</b>. Then call
///ITfSource::AdviseSink with <b>IID_ITfLanguageProfileNotifySink</b>.
@GUID("43C9FE15-F494-4C17-9DE2-B8A4AC350AA8")
interface ITfLanguageProfileNotifySink : IUnknown
{
    ///Called when the language profile is about to change.
    ///Params:
    ///    langid = Contains a <b>LANGID</b> value the identifies the new language profile.
    ///    pfAccept = Pointer to a <b>BOOL</b> value that receives a flag that permits or prevents the language profile change.
    ///               Receives zero to prevent the language profile change or nonzero to permit the language profile change.
    HRESULT OnLanguageChange(ushort langid, int* pfAccept);
    ///Called after the language profile has changed.
    HRESULT OnLanguageChanged();
}

///The <b>ITfInputProcessorProfileMgr</b> interface is implemented by the TSF manager and used by an application or text
///service to manipulate the language profile of one or more text services.
@GUID("71C6E74C-0F28-11D8-A82A-00065B84435C")
interface ITfInputProcessorProfileMgr : IUnknown
{
    ///The <b>ITfInputProcessorProfileMgr::ActivateProfile</b> method activates the specified text service's profile or
    ///keyboard layout.
    ///Params:
    ///    dwProfileType = [in] The type of this profile. This is one of these values. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///                    </tr> <tr> <td width="40%"><a id="TF_PROFILETYPE_INPUTPROCESSOR"></a><a
    ///                    id="tf_profiletype_inputprocessor"></a><dl> <dt><b>TF_PROFILETYPE_INPUTPROCESSOR</b></dt> </dl> </td> <td
    ///                    width="60%"> This is a text service. </td> </tr> <tr> <td width="40%"><a
    ///                    id="TF_PROFILETYPE_KEYBOARDLAYOUT"></a><a id="tf_profiletype_keyboardlayout"></a><dl>
    ///                    <dt><b>TF_PROFILETYPE_KEYBOARDLAYOUT</b></dt> </dl> </td> <td width="60%"> This is a keyboard layout. </td>
    ///                    </tr> </table>
    ///    langid = [in] The language id of the profile to be activated.
    ///    clsid = [in] The CLSID of the text service of the profile to be activated. This must be CLSID_NULL if
    ///            <i>dwProfileType</i> is TF_PROFILETYPE_KEYBOARDLAYOUT.
    ///    guidProfile = [in] The guidProfile of the profile to be activated. This must be GUID_NULL if <i>dwProfileType</i> is
    ///                  TF_PROFILETYPE_KEYBOARDLAYOUT.
    ///    hkl = [in] The handle of the keyboard layout. This must be <b>NULL</b> if dwProfileType is
    ///          TF_PROFILETYPE_INPUTPROCESSOR.
    ///    dwFlags = The combination of the following bits: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///              width="40%"><a id="TF_IPPMF_FORPROCESS"></a><a id="tf_ippmf_forprocess"></a><dl>
    ///              <dt><b>TF_IPPMF_FORPROCESS</b></dt> </dl> </td> <td width="60%"> Activate this profile for all threads in the
    ///              process. </td> </tr> <tr> <td width="40%"><a id="TF_IPPMF_FORSESSION"></a><a
    ///              id="tf_ippmf_forsession"></a><dl> <dt><b>TF_IPPMF_FORSESSION</b></dt> </dl> </td> <td width="60%"> Activate
    ///              this profile for all threads in the current desktop. </td> </tr> <tr> <td width="40%"><a
    ///              id="TF_IPPMF_ENABLEPROFILE"></a><a id="tf_ippmf_enableprofile"></a><dl>
    ///              <dt><b>TF_IPPMF_ENABLEPROFILE</b></dt> </dl> </td> <td width="60%"> Update the registry to enable this
    ///              profile for this user. </td> </tr> <tr> <td width="40%"><a id="TF_IPPMF_DISABLEPROFILE"></a><a
    ///              id="tf_ippmf_disableprofile"></a><dl> <dt><b>TF_IPPMF_DISABLEPROFILE</b></dt> </dl> </td> <td
    ///              width="60%"></td> </tr> <tr> <td width="40%"><a id="TF_IPPMF_DONTCARECURRENTINPUTLANGUAGE"></a><a
    ///              id="tf_ippmf_dontcarecurrentinputlanguage"></a><dl> <dt><b>TF_IPPMF_DONTCARECURRENTINPUTLANGUAGE</b></dt>
    ///              </dl> </td> <td width="60%"> If the current input language does not match with the requested profile's
    ///              language, TSF marks this profile to be activated when the requested input language is switched. If this flag
    ///              is off and the current input language is not matched, this method fails. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The language profile is not
    ///    enabled. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td>
    ///    <td width="60%"> One or more parameters are invalid. </td> </tr> </table>
    ///    
    HRESULT ActivateProfile(uint dwProfileType, ushort langid, const(GUID)* clsid, const(GUID)* guidProfile, 
                            ptrdiff_t hkl, uint dwFlags);
    ///The <b>ITfInputProcessorProfileMgr::DeactivateProfile</b> method deactivates the specified text service's profile
    ///or keyboard layout.
    ///Params:
    ///    dwProfileType = [in] The type of this profile. This is one of these values. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///                    </tr> <tr> <td width="40%"><a id="TF_PROFILETYPE_INPUTPROCESSOR"></a><a
    ///                    id="tf_profiletype_inputprocessor"></a><dl> <dt><b>TF_PROFILETYPE_INPUTPROCESSOR</b></dt> </dl> </td> <td
    ///                    width="60%"> This is a text service. </td> </tr> <tr> <td width="40%"><a
    ///                    id="TF_PROFILETYPE_KEYBOARDLAYOUT"></a><a id="tf_profiletype_keyboardlayout"></a><dl>
    ///                    <dt><b>TF_PROFILETYPE_KEYBOARDLAYOUT</b></dt> </dl> </td> <td width="60%"> This is a keyboard layout. </td>
    ///                    </tr> </table>
    ///    langid = [in] The language id of the profile to be activated.
    ///    clsid = [in] The CLSID of the text service of the profile to be activated. This must be CLSID_NULL if
    ///            <i>dwProfileType</i> is TF_PROFILETYPE_KEYBOARDLAYOUT.
    ///    guidProfile = [in] The guidProfile of the profile to be activated. This must be GUID_NULL if <i>dwProfileType</i> is
    ///                  TF_PROFILETYPE_KEYBOARDLAYOUT.
    ///    hkl = [in] The handle of the keyboard layout. This must be <b>NULL</b> if <i>dwProfileType</i> is
    ///          TF_PROFILETYPE_INPUTPROCESSOR.
    ///    dwFlags = The combination of the following bits: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///              width="40%"><a id="TF_IPPMF_FORPROCESS"></a><a id="tf_ippmf_forprocess"></a><dl>
    ///              <dt><b>TF_IPPMF_FORPROCESS</b></dt> </dl> </td> <td width="60%"> Deactivate this profile for all threads in
    ///              the process. </td> </tr> <tr> <td width="40%"><a id="TF_IPPMF_FORSESSION"></a><a
    ///              id="tf_ippmf_forsession"></a><dl> <dt><b>TF_IPPMF_FORSESSION</b></dt> </dl> </td> <td width="60%"> Deactivate
    ///              this profile for all threads in the current desktop. </td> </tr> <tr> <td width="40%"><a
    ///              id="TF_IPPMF_DISABLEPROFILE"></a><a id="tf_ippmf_disableprofile"></a><dl>
    ///              <dt><b>TF_IPPMF_DISABLEPROFILE</b></dt> </dl> </td> <td width="60%"></td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters are invalid. </td> </tr> </table>
    ///    
    HRESULT DeactivateProfile(uint dwProfileType, ushort langid, const(GUID)* clsid, const(GUID)* guidProfile, 
                              ptrdiff_t hkl, uint dwFlags);
    ///The <b>ITfInputProcessorProfileMgr::GetProfile</b> method returns the information of the specified text service's
    ///profile or keyboard layout in TF_INPUTPROCESSORPROFILE structure.
    ///Params:
    ///    dwProfileType = [in] The type of this profile. This is one of these values. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///                    </tr> <tr> <td width="40%"><a id="TF_PROFILETYPE_INPUTPROCESSOR"></a><a
    ///                    id="tf_profiletype_inputprocessor"></a><dl> <dt><b>TF_PROFILETYPE_INPUTPROCESSOR</b></dt> </dl> </td> <td
    ///                    width="60%"> This is a text service. </td> </tr> <tr> <td width="40%"><a
    ///                    id="TF_PROFILETYPE_KEYBOARDLAYOUT"></a><a id="tf_profiletype_keyboardlayout"></a><dl>
    ///                    <dt><b>TF_PROFILETYPE_KEYBOARDLAYOUT</b></dt> </dl> </td> <td width="60%"> This is a keyboard layout. </td>
    ///                    </tr> </table>
    ///    langid = [in] The language id of the profile to be activated.
    ///    clsid = [in] The CLSID of the text service of the profile to be activated. This must be CLSID_NULL if
    ///            <i>dwProfileType</i> is TF_PROFILETYPE_KEYBOARDLAYOUT.
    ///    guidProfile = [in] The guidProfile of the profile to be activated. This must be GUID_NULL if <i>dwProfileType</i> is
    ///                  TF_PROFILETYPE_KEYBOARDLAYOUT.
    ///    hkl = [in] The handle of the keyboard layout. This must be <b>NULL</b> if <i>dwProfileType</i> is
    ///          TF_PROFILETYPE_INPUTPROCESSOR.
    ///    pProfile = [out] The buffer to receive TF_INPUTPROCESSORPROFILE.
    HRESULT GetProfile(uint dwProfileType, ushort langid, const(GUID)* clsid, const(GUID)* guidProfile, 
                       ptrdiff_t hkl, TF_INPUTPROCESSORPROFILE* pProfile);
    ///The <b>ITfInputProcessorProfileMgr::EnumProfiles</b> method returns profiles to be enumerated.
    ///Params:
    ///    langid = [in] langid of the profiles to be enumerated. If langid is 0, all profiles will be enumerated.
    ///    ppEnum = [out] The pointer to receive a pointer of IEnumTfInputProcessorProfiles interface.
    HRESULT EnumProfiles(ushort langid, IEnumTfInputProcessorProfiles* ppEnum);
    ///The <b>ITfInputProcessorProfileMgr::ReleaseInputProcessor</b> method deactivates the profiles belonging to the
    ///text services of the specified CLSID and releases the instance of ITfTextInputProcessorEx interface.
    ///Params:
    ///    rclsid = [in] CLSID of the textservice to be released.
    ///    dwFlags = [in] <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///              id="TF_RIP_FLAG_FREEUNUSEDLIBRARIES"></a><a id="tf_rip_flag_freeunusedlibraries"></a><dl>
    ///              <dt><b>TF_RIP_FLAG_FREEUNUSEDLIBRARIES</b></dt> </dl> </td> <td width="60%"> If this bit is on, this method
    ///              calls CoFreeUnusedLibrariesEx() so the text services DLL might be freed if it does not have any more COM/DLL
    ///              reference. Warning: This flag could cause some other unrelated COM/DLL free. </td> </tr> </table>
    HRESULT ReleaseInputProcessor(const(GUID)* rclsid, uint dwFlags);
    ///The <b>ITfInputProcessorProfileMgr::RegisterProfile</b> method registers the text service and the profile.
    ///Params:
    ///    rclsid = [in] CLSID of the text service.
    ///    langid = [in] The language id of the profile.
    ///    guidProfile = [in] The GUID to identify the profile.
    ///    pchDesc = [in, size_is(cchDesc)] The description of the profile.
    ///    cchDesc = [in] The length of pchDesc.
    ///    pchIconFile = [in, size_is(cchFile] The full path of the icon file.
    ///    cchFile = [in] The length of pchIconFile.
    ///    uIconIndex = [in] The icon index of the icon file for this profile.
    ///    hklsubstitute = [in] The substitute hkl of this profile.
    ///    dwPreferredLayout = [in] Unused. this must be 0.
    ///    bEnabledByDefault = [in] True if this profile is enabled by default.
    ///    dwFlags = [in] The combination of the following bits: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///              width="40%"><a id="TF_RP_HIDDENINSETTINGUI"></a><a id="tf_rp_hiddeninsettingui"></a><dl>
    ///              <dt><b>TF_RP_HIDDENINSETTINGUI</b></dt> </dl> </td> <td width="60%"> This profile will not appear in the
    ///              setting UI. </td> </tr> <tr> <td width="40%"><a id="TF_RP_LOCALPROCESS"></a><a
    ///              id="tf_rp_localprocess"></a><dl> <dt><b>TF_RP_LOCALPROCESS</b></dt> </dl> </td> <td width="60%"> This profile
    ///              is available only on the local process. </td> </tr> <tr> <td width="40%"><a id="TF_RP_LOCALTHREAD"></a><a
    ///              id="tf_rp_localthread"></a><dl> <dt><b>TF_RP_LOCALTHREAD</b></dt> </dl> </td> <td width="60%"> This profile
    ///              is available only on the local thread. </td> </tr> </table>
    HRESULT RegisterProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, const(wchar)* pchDesc, 
                            uint cchDesc, const(wchar)* pchIconFile, uint cchFile, uint uIconIndex, 
                            ptrdiff_t hklsubstitute, uint dwPreferredLayout, BOOL bEnabledByDefault, uint dwFlags);
    ///The <b>ITfInputProcessorProfileMgr::UnregisterProfile</b> method unregisters the text service and the profile.
    ///Params:
    ///    rclsid = [in] CLSID of the text service.
    ///    langid = [in] The language id of the profile.
    ///    guidProfile = [in] The GUID to identify the profile.
    ///    dwFlags = [in] The combination of the following bits: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///              width="40%"><a id="TF_URP_ALLPROFILES"></a><a id="tf_urp_allprofiles"></a><dl>
    ///              <dt><b>TF_URP_ALLPROFILES</b></dt> </dl> </td> <td width="60%"> If this bit is on, <b>UnregistrProfile</b>
    ///              unregisters all profiles of the <i>rclsid</i> parameter. The <i>langid</i> and <i>guidProfile</i> parameters
    ///              are ignored. </td> </tr> <tr> <td width="40%"><a id="TF_URP_LOCALPROCESS"></a><a
    ///              id="tf_urp_localprocess"></a><dl> <dt><b>TF_URP_LOCALPROCESS</b></dt> </dl> </td> <td width="60%"> The
    ///              profile was registered on the local process. </td> </tr> <tr> <td width="40%"><a
    ///              id="TF_URP_LOCALTHREAD"></a><a id="tf_urp_localthread"></a><dl> <dt><b>TF_URP_LOCALTHREAD</b></dt> </dl>
    ///              </td> <td width="60%"> The profile was registered on the local thread. </td> </tr> </table>
    HRESULT UnregisterProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, uint dwFlags);
    ///This method returns the current active profile.
    ///Params:
    ///    catid = [in] The category id for the profile. This must be GUID_TFCAT_TIP_KEYBOARD. Only GUID_TFCAT_TIP_KEYBOARD is
    ///            supported.
    ///    pProfile = [out] The buffer to receive the profile information.
    HRESULT GetActiveProfile(const(GUID)* catid, TF_INPUTPROCESSORPROFILE* pProfile);
}

///The <b>IEnumTfInputProcessorProfiles</b> interface is implemented by TSF manager and used by applications or
///textservices. This interface can be retrieved by ITfInputProcessorProfileMgr::EnumProfiles and enumerates the
///registered profiles.
@GUID("71C6E74D-0F28-11D8-A82A-00065B84435C")
interface IEnumTfInputProcessorProfiles : IUnknown
{
    ///The <b>IEnumTfInputProcessorProfiles::Clone</b> method creates a copy of the enumerator object.
    ///Params:
    ///    ppEnum = [out] A pointer to an IEnumTfInputProcessorProfiles interface.
    HRESULT Clone(IEnumTfInputProcessorProfiles* ppEnum);
    ///The <b>IEnumTfInputProcessorProfiles::Next</b> method obtains, from the current position, the specified number of
    ///elements in the enumeration sequence.
    ///Params:
    ///    ulCount = [in] Specifies the number of elements to obtain.
    ///    pProfile = [out] Pointer to an array of TF_INPUTPROCESSORPROFILE structures. This array must be at least <i>ulCount</i>
    ///               elements in size.
    ///    pcFetch = [out] Pointer to a ULONG value that receives the number of elements actually obtained. This value can be less
    ///              than the number of items requested. This parameter can be <b>NULL</b>.
    HRESULT Next(uint ulCount, char* pProfile, uint* pcFetch);
    ///The IEnumTfInputProcessorProfiles::Reset method resets the enumerator object by moving the current position to
    ///the beginning of the enumeration sequence.
    HRESULT Reset();
    ///The IEnumTfInputProcessorProfiles::Skip method moves the current position forward in the enumeration sequence by
    ///the specified number of elements.
    ///Params:
    ///    ulCount = [in] Contains the number of elements to skip.
    HRESULT Skip(uint ulCount);
}

///The <b>ITfInputProcessorProfileActivationSink</b> interface is implemented by an application to receive notifications
///when the profile changes.
@GUID("71C6E74E-0F28-11D8-A82A-00065B84435C")
interface ITfInputProcessorProfileActivationSink : IUnknown
{
    ///The ITfInputProcessorProfileActivationSink::OnActivated method is a callback that is called when an input
    ///processor profile is activated or deactivated.
    ///Params:
    ///    dwProfileType = [in] The type of this profile. This is one of these values. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///                    </tr> <tr> <td width="40%"><a id="TF_PROFILETYPE_INPUTPROCESSOR"></a><a
    ///                    id="tf_profiletype_inputprocessor"></a><dl> <dt><b>TF_PROFILETYPE_INPUTPROCESSOR</b></dt> </dl> </td> <td
    ///                    width="60%"> This is a text service. </td> </tr> <tr> <td width="40%"><a
    ///                    id="TF_PROFILETYPE_KEYBOARDLAYOUT"></a><a id="tf_profiletype_keyboardlayout"></a><dl>
    ///                    <dt><b>TF_PROFILETYPE_KEYBOARDLAYOUT</b></dt> </dl> </td> <td width="60%"> This is a keyboard layout. </td>
    ///                    </tr> </table>
    ///    langid = [in] Specifies the language id of the profile.
    ///    clsid = [in] Specifies the CLSID of the text service. If <i>dwProfileType</i> is TF_PROFILETYPE_KEYBOARDLAYOUT, this
    ///            is CLSID_NULL.
    ///    catid = [in] Specifies the category of this text service. This category is GUID_TFCAT_TIP_KEYBOARD,
    ///            GUID_TFCAT_TIP_SPEECH, GUID_TFCAT_TIP_HANDWRITING or something in GUID_TFCAT_CATEGORY_OF_TIP. If
    ///            <i>dwProfileType</i> is TF_PROFILETYPE_KEYBOARDLAYOUT, this is GUID_NULL.
    ///    guidProfile = [in] Specifies the GUID to identify the profile. If <i>dwProfileType</i> is TF_PROFILETYPE_KEYBOARDLAYOUT,
    ///                  this is GUID_NULL.
    ///    hkl = [in] Specifies the keyboard layout handle of this profile. If <i>dwProfileType</i> is TF_PROFILETYPE_
    ///          INPUTPROCESSOR, this is <b>NULL</b>.
    ///    dwFlags = [in] <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///              id="TF_IPSINK_FLAG_ACTIVE"></a><a id="tf_ipsink_flag_active"></a><dl> <dt><b>TF_IPSINK_FLAG_ACTIVE</b></dt>
    ///              </dl> </td> <td width="60%"> This is on if this profile is activated. </td> </tr> </table>
    HRESULT OnActivated(uint dwProfileType, ushort langid, const(GUID)* clsid, const(GUID)* catid, 
                        const(GUID)* guidProfile, ptrdiff_t hkl, uint dwFlags);
}

///The <b>ITfKeystrokeMgr</b> interface is implemented by the TSF manager and used by applications and text services to
///interact with the keyboard manager.
@GUID("AA80E7F0-2021-11D2-93E0-0060B067B86E")
interface ITfKeystrokeMgr : IUnknown
{
    ///Installs a key event sink to receive keyboard events.
    ///Params:
    ///    tid = Identifier of the client that owns the key event sink. This value is obtained by a previous call to
    ///          ITfThreadMgr::Activate.
    ///    pSink = Pointer to a ITfKeyEventSink interface.
    ///    fForeground = Specifies if this key event sink is made the foreground key event sink. If this is <b>TRUE</b>, this key
    ///                  event sink is made the foreground key event sink. Otherwise, this key event sink does not become the
    ///                  foreground key event sink.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CONNECT_E_ADVISELIMIT</b></dt> </dl> </td> <td
    ///    width="60%"> The client identified by <i>tid</i> has a key event sink installed. </td> </tr> </table>
    ///    
    HRESULT AdviseKeyEventSink(uint tid, ITfKeyEventSink pSink, BOOL fForeground);
    ///Removes a key event sink.
    ///Params:
    ///    tid = Identifier of the client that owns the key event sink. This value was passed when the advise sink was
    ///          installed using ITfKeystrokeMgr::AdviseKeyEventSink.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>tid</i> parameter
    ///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CONNECT_E_NOCONNECTION</b></dt> </dl> </td> <td
    ///    width="60%"> The advise sink identified by <i>tid</i> was not found. </td> </tr> </table>
    ///    
    HRESULT UnadviseKeyEventSink(uint tid);
    ///Obtains the class identifier of the foreground TSF text service.
    ///Params:
    ///    pclsid = Pointer to a CLSID that receives the class identifier of the foreground TSF text service.
    HRESULT GetForeground(GUID* pclsid);
    ///Determines if the keystroke manager will handle a key down event.
    ///Params:
    ///    wParam = Specifies the virtual-key code of the key. For more information about this parameter, see the <i>wParam</i>
    ///             parameter in WM_KEYDOWN.
    ///    lParam = Specifies the repeat count, scan code, extended-key flag, context code, previous key-state flag, and
    ///             transition-state flag of the key. For more information about this parameter, see the <i>lParam</i> parameter
    ///             in WM_KEYDOWN.
    ///    pfEaten = Pointer to a BOOL that indicates if the key event would be handled. If this value receives <b>TRUE</b>, the
    ///              key event would be handled and the event should not be forwarded to the application. If this value is
    ///              <b>FALSE</b>, the key event would not be handled and the event should be forwarded to the application.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> There are no key event sinks
    ///    installed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    One or more parameters are invalid. </td> </tr> </table>
    ///    
    HRESULT TestKeyDown(WPARAM wParam, LPARAM lParam, int* pfEaten);
    ///Determines if the keystroke manager will handle a key up event.
    ///Params:
    ///    wParam = Specifies the virtual-key code of the key. For more information about this parameter, see the <i>wParam</i>
    ///             parameter in WM_KEYUP.
    ///    lParam = Specifies the repeat count, scan code, extended-key flag, context code, previous key-state flag, and
    ///             transition-state flag of the key. For more information about this parameter, see the <i>lParam</i> parameter
    ///             in WM_KEYUP.
    ///    pfEaten = Pointer to a BOOL that indicates if the key event is handled. If this value receives <b>TRUE</b>, the key
    ///              event is handled and the event should not be forwarded to the application. If this value is <b>FALSE</b>, the
    ///              key event is not handled and the event should be forwarded to the application.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> No key event sinks are
    ///    installed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    One or more parameters are invalid. </td> </tr> </table>
    ///    
    HRESULT TestKeyUp(WPARAM wParam, LPARAM lParam, int* pfEaten);
    ///Passes a key down event to the keystroke manager.
    ///Params:
    ///    wParam = Specifies the virtual-key code of the key. For more information about this parameter, see the <i>wParam</i>
    ///             parameter in WM_KEYDOWN.
    ///    lParam = Specifies the repeat count, scan code, extended-key flag, context code, previous key-state flag, and
    ///             transition-state flag of the key. For more information about this parameter, see the <i>lParam</i> parameter
    ///             in WM_KEYDOWN.
    ///    pfEaten = Pointer to a BOOL that, on exit, indicates if the key event was handled. If this value receives <b>TRUE</b>,
    ///              the key event was handled and the event should not be forwarded to the application. If this value is
    ///              <b>FALSE</b>, the key event was not handled and the event should be forwarded to the application.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> There are no key event sinks
    ///    installed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    One or more parameters are invalid. </td> </tr> </table>
    ///    
    HRESULT KeyDown(WPARAM wParam, LPARAM lParam, int* pfEaten);
    ///Passes a key up event to the keystroke manager.
    ///Params:
    ///    wParam = Specifies the virtual-key code of the key. For more information about this parameter, see the <i>wParam</i>
    ///             parameter in WM_KEYUP.
    ///    lParam = Specifies the repeat count, scan code, extended-key flag, context code, previous key-state flag, and
    ///             transition-state flag of the key. For more information about this parameter, see the <i>lParam</i> parameter
    ///             in WM_KEYUP.
    ///    pfEaten = Pointer to a BOOL that, on exit, indicates if the key event will be handled. If this value receives
    ///              <b>TRUE</b>, the key event would be handled and the event should not be forwarded to the application. If this
    ///              value is <b>FALSE</b>, the key event would not be handled and the event should be forwarded to the
    ///              application.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> No key event sinks are
    ///    installed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    One or more parameters are invalid. </td> </tr> </table>
    ///    
    HRESULT KeyUp(WPARAM wParam, LPARAM lParam, int* pfEaten);
    ///Obtains the command GUID for a preserved key.
    ///Params:
    ///    pic = Pointer to the application context. This value is returned by a previous call to
    ///          ITfDocumentMgr::CreateContext.
    ///    pprekey = Pointer to a TF_PRESERVEDKEY structure that identifies the preserved key to obtain. The <b>uVKey</b> member
    ///              contains the virtual key code and the <b>uModifiers</b> member identifies the modifiers of the preserved key.
    ///              The <b>uVKey</b> member must be less than 256.
    ///    pguid = Pointer to a GUID value that receives the command GUID of the preserved key. This is the GUID passed in the
    ///            TSF text service call to ITfKeystrokeMgr::PreserveKey. This value receives GUID_NULL if the preserved key is
    ///            not found.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful and the
    ///    preserved key was found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> The method was successful, but the preserved key was not found. <i>pguid</i> receives GUID_NULL.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetPreservedKey(ITfContext pic, const(TF_PRESERVEDKEY)* pprekey, GUID* pguid);
    ///Determines if a command GUID and key combination is a preserved key.
    ///Params:
    ///    rguid = Specifies the command GUID of the preserved key. This is the GUID passed in the text service call to
    ///            ITfKeystrokeMgr::PreserveKey.
    ///    pprekey = Pointer to a TF_PRESERVEDKEY structure that identifies the preserved key. The <b>uVKey</b> member contains
    ///              the virtual key code and the <b>uModifiers</b> member identifies the modifiers of the preserved key. The
    ///              <b>uVKey</b> member must be less than 256.
    ///    pfRegistered = Pointer to a BOOL that receives <b>TRUE</b> if the command GUID and key combination is a registered preserved
    ///                   key, or <b>FALSE</b> otherwise.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful and the
    ///    preserved key was found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> The method was successful, but the preserved key was not found. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters are
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT IsPreservedKey(const(GUID)* rguid, const(TF_PRESERVEDKEY)* pprekey, int* pfRegistered);
    ///Registers a preserved key.
    ///Params:
    ///    tid = Contains the client identifier of the TSF text service. This value is passed to the TSF text service in its
    ///          ITfTextInputProcessor::Activate method.
    ///    rguid = Contains the command GUID of the preserved key. This value is passed to the TSF text service
    ///            ITfKeyEventSink::OnPreservedKey method to identify the preserved key when the preserved key is activated.
    ///    prekey = Pointer to a TF_PRESERVEDKEY structure that specifies the preserved key. The <b>uVKey</b> member contains the
    ///             virtual key code and the <b>uModifiers</b> member identifies the modifiers of the preserved key.
    ///    pchDesc = Pointer to a Unicode string that contains the description of the preserved key. This cannot be <b>NULL</b>
    ///              unless <i>cchDesc</i> is zero.
    ///    cchDesc = Specifies the number of characters in <i>pchDesc</i>. Pass zero for this parameter if no description is
    ///              required.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>TF_E_ALREADY_EXISTS</b></dt> </dl> </td> <td width="60%"> The preserved key
    ///    is registered. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation error occurred. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT PreserveKey(uint tid, const(GUID)* rguid, const(TF_PRESERVEDKEY)* prekey, const(wchar)* pchDesc, 
                        uint cchDesc);
    ///Unregisters a preserved key.
    ///Params:
    ///    rguid = Contains the command GUID of the preserved key.
    ///    pprekey = Pointer to a TF_PRESERVEDKEY structure that specifies the preserved key. The <i>uVKey</i> member contains the
    ///              virtual key code and the <i>uModifiers</i> member identifies the modifiers of the preserved key.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>CONNECT_E_NOCONNECTION</b></dt> </dl> </td> <td width="60%"> The preserved
    ///    key is not registered. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters are invalid. </td> </tr> </table>
    ///    
    HRESULT UnpreserveKey(const(GUID)* rguid, const(TF_PRESERVEDKEY)* pprekey);
    ///Modifies the description string of an existing preserved key.
    ///Params:
    ///    rguid = Contains the command GUID of the preserved key.
    ///    pchDesc = Pointer to a Unicode string that contains the new description of the preserved key. This cannot be
    ///              <b>NULL</b> unless <i>cchDesc</i> is zero.
    ///    cchDesc = Number of characters in <i>pchDesc</i>. Pass zero for this parameter if no description is required.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid or the preserved key is not found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt>
    ///    </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT SetPreservedKeyDescription(const(GUID)* rguid, const(wchar)* pchDesc, uint cchDesc);
    ///Obtains the description string of an existing preserved key.
    ///Params:
    ///    rguid = Contains the command GUID of the preserved key.
    ///    pbstrDesc = Pointer to a BSTR value the receives the description string. The caller must free this memory using
    ///                SysFreeString.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    is invalid or the preserved key is not found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt>
    ///    </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetPreservedKeyDescription(const(GUID)* rguid, BSTR* pbstrDesc);
    ///Simulates the execution of a preserved key sequence.
    ///Params:
    ///    pic = Pointer to the application context. This value was returned by a previous call to
    ///          ITfDocumentMgr::CreateContext.
    ///    rguid = Contains the command GUID of the preserved key.
    ///    pfEaten = Pointer to a BOOL that indicates if the key event was handled. If this value receives <b>TRUE</b>, the key
    ///              event was handled. If this value is <b>FALSE</b>, the key event was not handled.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The preserved key cannot be
    ///    simulated. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    One or more parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
    ///    <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT SimulatePreservedKey(ITfContext pic, const(GUID)* rguid, int* pfEaten);
}

///The <b>ITfKeyEventSink</b> interface is implemented by a text service to receive keyboard and focus event
///notifications. To install this event sink, call ITfKeystrokeMgr::AdviseKeyEventSink.
@GUID("AA80E7F5-2021-11D2-93E0-0060B067B86E")
interface ITfKeyEventSink : IUnknown
{
    ///Called when a TSF text service receives or loses the keyboard focus.
    ///Params:
    ///    fForeground = If <b>TRUE</b>, the test service receives the focus. Otherwise the text service loses the focus.
    HRESULT OnSetFocus(BOOL fForeground);
    ///Called to determine if a text service will handle a key down event.
    ///Params:
    ///    pic = Pointer to the input context that receives the key event.
    ///    wParam = Specifies the virtual-key code of the key. For more information about this parameter, see the <i>wParam</i>
    ///             parameter in WM_KEYDOWN.
    ///    lParam = Specifies the repeat count, scan code, extended-key flag, context code, previous key-state flag, and
    ///             transition-state flag of the key. For more information about this parameter, see the <i>lParam</i> parameter
    ///             in WM_KEYDOWN.
    ///    pfEaten = Pointer to a BOOL that, on exit, indicates if the key event would be handled. If this value receives
    ///              <b>TRUE</b>, the key event would be handled. If this value is <b>FALSE</b>, the key event would not be
    ///              handled.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnTestKeyDown(ITfContext pic, WPARAM wParam, LPARAM lParam, int* pfEaten);
    ///Called to determine if a text service will handle a key up event.
    ///Params:
    ///    pic = Pointer to the input context that receives the key event.
    ///    wParam = Specifies the virtual-key code of the key. For more information about this parameter, see the <i>wParam</i>
    ///             parameter in WM_KEYUP.
    ///    lParam = Specifies the repeat count, scan code, extended-key flag, context code, previous key-state flag, and
    ///             transition-state flag of the key. For more information about this parameter, see the <i>lParam</i> parameter
    ///             in WM_KEYUP.
    ///    pfEaten = Pointer to a BOOL that, on exit, indicates if the key event would be handled. If this value receives
    ///              <b>TRUE</b>, the key event would be handled. If this value receives <b>FALSE</b>, the key event would not be
    ///              handled.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnTestKeyUp(ITfContext pic, WPARAM wParam, LPARAM lParam, int* pfEaten);
    ///Called when a key down event occurs.
    ///Params:
    ///    pic = Pointer to the input context that receives the key event.
    ///    wParam = Specifies the virtual-key code of the key. For more information about this parameter, see the <i>wParam</i>
    ///             parameter in WM_KEYDOWN.
    ///    lParam = Specifies the repeat count, scan code, extended-key flag, context code, previous key-state flag, and
    ///             transition-state flag of the key. For more information about this parameter, see the <i>lParam</i> parameter
    ///             in WM_KEYDOWN.
    ///    pfEaten = Pointer to a BOOL that, on exit, indicates if the key event was handled. If this value receives <b>TRUE</b>,
    ///              the key event was handled. If this value is <b>FALSE</b>, the key event was not handled.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnKeyDown(ITfContext pic, WPARAM wParam, LPARAM lParam, int* pfEaten);
    ///Called when a key up event occurs.
    ///Params:
    ///    pic = Pointer to the input context that receives the key event.
    ///    wParam = Specifies the virtual-key code of the key. For more information about this parameter, see the <i>wParam</i>
    ///             parameter in WM_KEYUP.
    ///    lParam = Specifies the repeat count, scan code, extended-key flag, context code, previous key-state flag, and
    ///             transition-state flag of the key. For more information about this parameter, see the <i>lParam</i> parameter
    ///             in WM_KEYUP.
    ///    pfEaten = Pointer to a BOOL that, on exit, indicates if the key event was handled. If this value receives <b>TRUE</b>,
    ///              the key event was handled. If this value receives <b>FALSE</b>, the key event was not handled.
    HRESULT OnKeyUp(ITfContext pic, WPARAM wParam, LPARAM lParam, int* pfEaten);
    ///Called when a preserved key event occurs.
    ///Params:
    ///    pic = Pointer to the input context that receives the key event.
    ///    rguid = Contains the command GUID of the preserved key.
    ///    pfEaten = Pointer to a BOOL value that, on exit, indicates if the preserved key event was handled. If this value
    ///              receives <b>TRUE</b>, the preserved key event was handled. If this value receives <b>FALSE</b>, the preserved
    ///              key event was not handled.
    HRESULT OnPreservedKey(ITfContext pic, const(GUID)* rguid, int* pfEaten);
}

///The <b>ITfKeyTraceEventSink</b> interface is implemented by an application or text service to receive key stroke
///event notifications before the event is processed by the target. This advise sink is installed by calling the thread
///manager ITfSource::AdviseSink method with IID_ITfKeyTraceEventSink.
@GUID("1CD4C13B-1C36-4191-A70A-7F3E611F367D")
interface ITfKeyTraceEventSink : IUnknown
{
    ///Called when a key down event occurs.
    ///Params:
    ///    wParam = The WPARAM of the key event. For more information about this parameter, see the <i>wParam</i> parameter in
    ///             WM_KEYDOWN.
    ///    lParam = The LPARAM of the key event. For more information about this parameter, see the <i>lParam</i> parameter in
    ///             WM_KEYDOWN.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnKeyTraceDown(WPARAM wParam, LPARAM lParam);
    ///Called when a key up event occurs.
    ///Params:
    ///    wParam = The WPARAM of the key event. For more information about this parameter, see the <i>wParam</i> parameter in
    ///             WM_KEYUP.
    ///    lParam = The LPARAM of the key event. For more information about this parameter, see the <i>lParam</i> parameter in
    ///             WM_KEYUP.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnKeyTraceUp(WPARAM wParam, LPARAM lParam);
}

///The <b>ITfPreservedKeyNotifySink</b> interface is implemented by an application or TSF text service to receive
///notifications when keys are preserved, unpreserved, or when a preserved key description changes. This advise sink is
///installed by calling the TSF manager ITfSource::AdviseSink with IID_ITfPreservedKeyNotifySink.
@GUID("6F77C993-D2B1-446E-853E-5912EFC8A286")
interface ITfPreservedKeyNotifySink : IUnknown
{
    ///Called when a key is preserved, unpreserved, or when a preserved key description changes.
    ///Params:
    ///    pprekey = Pointer to a TF_PRESERVEDKEY structure that contains data about the key.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnUpdated(const(TF_PRESERVEDKEY)* pprekey);
}

///The <b>ITfMessagePump</b> interface is implemented by the TSF manager and is used by an application to obtain
///messages from the application message queue. The methods of this interface are wrappers for the GetMessage and
///PeekMessage functions. This interface enables the TSF manager to perform any necessary pre-message or post-message
///processing.
@GUID("8F1B8AD8-0B6B-4874-90C5-BD76011E8F7C")
interface ITfMessagePump : IUnknown
{
    ///Obtains a message from the message queue and returns if no message is obtained. This is the ANSI version of this
    ///method.
    ///Params:
    ///    pMsg = Pointer to a MSG structure that receives message data.
    ///    hwnd = Handle to the window whose messages are obtained. The window must belong to the current thread. If this value
    ///           is <b>NULL</b>, this method obtains messages for any window owned by the calling thread.
    ///    wMsgFilterMin = Specifies the lowest message value to obtain.
    ///    wMsgFilterMax = Specifies the highest message value to obtain.
    ///    wRemoveMsg = Specifies how messages are handled. For more information, see the <b>PeekMessage</b> function.
    ///    pfResult = Pointer to a BOOL that receives the return value from the <b>PeekMessage</b> function.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> </table>
    ///    
    HRESULT PeekMessageA(MSG* pMsg, HWND hwnd, uint wMsgFilterMin, uint wMsgFilterMax, uint wRemoveMsg, 
                         int* pfResult);
    ///Obtains a message from the message queue and does not return until a message is obtained. This is the ANSI
    ///version of this method.
    ///Params:
    ///    pMsg = Pointer to a MSG structure that receives message data.
    ///    hwnd = Handle to the window whose messages are obtained. The window must belong to the current thread. If this value
    ///           is <b>NULL</b>, this method obtains messages for any window that belongs to the calling thread.
    ///    wMsgFilterMin = Specifies the lowest message value obtained.
    ///    wMsgFilterMax = Specifies the highest message value obtained.
    ///    pfResult = Pointer to a BOOL value that receives the return value from the <b>GetMessage</b> function.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> </table>
    ///    
    HRESULT GetMessageA(MSG* pMsg, HWND hwnd, uint wMsgFilterMin, uint wMsgFilterMax, int* pfResult);
    ///Obtains a message from the message queue and returns if no message is obtained. This is the Unicode version of
    ///this method.
    ///Params:
    ///    pMsg = Pointer to a MSG structure that receives message data.
    ///    hwnd = Handle to the window whose messages are obtained. The window must belong to the current thread. If this value
    ///           is <b>NULL</b>, this method obtains messages for any window that belongs to the calling thread.
    ///    wMsgFilterMin = Specifies the lowest message value to obtain.
    ///    wMsgFilterMax = Specifies the highest message value to obtain.
    ///    wRemoveMsg = Specifies how messages are handled. For more information, see the <b>PeekMessage</b> function.
    ///    pfResult = Pointer to a BOOL that receives the return value from the <b>PeekMessage</b> function.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> </table>
    ///    
    HRESULT PeekMessageW(MSG* pMsg, HWND hwnd, uint wMsgFilterMin, uint wMsgFilterMax, uint wRemoveMsg, 
                         int* pfResult);
    ///Obtains a message from the message queue and does not return until a message is obtained. This is the Unicode
    ///version of this method.
    ///Params:
    ///    pMsg = Pointer to a MSG structure that receives message data.
    ///    hwnd = Handle to the window whose messages are obtained. The window must belong to the current thread. If this value
    ///           is <b>NULL</b>, this method obtains messages for any window owned by the calling thread.
    ///    wMsgFilterMin = Specifies the lowest message value to obtain.
    ///    wMsgFilterMax = Specifies the highest message value to obtain.
    ///    pfResult = Pointer to a BOOL that receives the return value from the <b>GetMessage</b> function.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> </table>
    ///    
    HRESULT GetMessageW(MSG* pMsg, HWND hwnd, uint wMsgFilterMin, uint wMsgFilterMax, int* pfResult);
}

///The <b>ITfThreadFocusSink</b> interface is implemented by an application or TSF text service to receive notifications
///when the thread receives or loses the UI focus. This advise sink is installed by calling the TSF Manager's
///ITfSource::AdviseSink with IID_ITfThreadFocusSink.
@GUID("C0F1DB0C-3A20-405C-A303-96B6010A885F")
interface ITfThreadFocusSink : IUnknown
{
    ///Called when the thread receives the UI focus.
    HRESULT OnSetThreadFocus();
    ///Called when the thread loses the UI focus.
    HRESULT OnKillThreadFocus();
}

///The <b>ITfTextInputProcessor</b> interface is implemented by a text service and used by the TSF manager to activate
///and deactivate the text service. The manager obtains a pointer to this interface when it creates an instance of the
///text service for a thread with a call to CoCreateInstance.
@GUID("AA80E7F7-2021-11D2-93E0-0060B067B86E")
interface ITfTextInputProcessor : IUnknown
{
    ///Activates a text service when a user session starts.
    ///Params:
    ///    ptim = Pointer to the ITfThreadMgr interface for the thread manager that owns the text service.
    ///    tid = Specifies the client identifier for the text service.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Activate(ITfThreadMgr ptim, uint tid);
    ///Deactivates a text service when a user session ends.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Deactivate();
}

///The <b>ITfTextInputProcessorEx</b> interface is implemented by a text service and used by the TSF manager to activate
///and deactivate the text service. The manager obtains a pointer to this interface when it creates an instance of the
///text service for a thread with a call to CoCreateInstance.
@GUID("6E4E2102-F9CD-433D-B496-303CE03A6507")
interface ITfTextInputProcessorEx : ITfTextInputProcessor
{
    ///The <b>ITfTextInputProcessorEx::ActivateEx</b> method activates a text service when a user session starts. If the
    ///text service implements <b>ITfTextInputProcessorEx</b> and <b>ActivateEx</b> is called,
    ///ITfTextInputProcessor::Activate will not be called.
    ///Params:
    ///    ptim = [in] Pointer to the ITfThreadMgr interface for the thread manager that owns the text service.
    ///    tid = [in] Specifies the client identifier for the text service.
    ///    dwFlags = [in] The combination of the following bits: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///              width="40%"><a id="TF_TMAE_SECUREMODE"></a><a id="tf_tmae_securemode"></a><dl>
    ///              <dt><b>TF_TMAE_SECUREMODE</b></dt> </dl> </td> <td width="60%"> A text service is activated as secure mode. A
    ///              text service may not want to show the setting dialog box. </td> </tr> <tr> <td width="40%"><a
    ///              id="TF_TMAE_COMLESS"></a><a id="tf_tmae_comless"></a><dl> <dt><b>TF_TMAE_COMLESS</b></dt> </dl> </td> <td
    ///              width="60%"> A text service is activated as com less mode. TSF was activated without COM. COM may not be
    ///              initialized or COM may be initialized as MTA. </td> </tr> <tr> <td width="40%"><a id="TF_TMAE_WOW16"></a><a
    ///              id="tf_tmae_wow16"></a><dl> <dt><b>TF_TMAE_WOW16</b></dt> </dl> </td> <td width="60%"> The current thread is
    ///              16 bit task. </td> </tr> <tr> <td width="40%"><a id="TF_TMAE_CONSOLE"></a><a id="tf_tmae_console"></a><dl>
    ///              <dt><b>TF_TMAE_CONSOLE</b></dt> </dl> </td> <td width="60%"> A text service is activated for console usage.
    ///              </td> </tr> </table>
    HRESULT ActivateEx(ITfThreadMgr ptim, uint tid, uint dwFlags);
}

///The <b>ITfClientId</b> interface is implemented by the TSF manager. This interface is used to obtain a client
///identifier for TSF objects. An instance of this interface is obtained by querying the thread manager with
///IID_ITfClientId.
@GUID("D60A7B49-1B9F-4BE2-B702-47E9DC05DEC3")
interface ITfClientId : IUnknown
{
    ///Obtains a client identifier for a CLSID.
    ///Params:
    ///    rclsid = CLSID to obtain the client identifier for.
    ///    ptid = Pointer to a TfClientId value that receives the client identifier.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetClientId(const(GUID)* rclsid, uint* ptid);
}

///The <b>ITfDisplayAttributeInfo</b> interface is implemented by a text service to provide display attribute data. This
///interface is used by any component, most often an application, that must determine how text displays.
@GUID("70528852-2F26-4AEA-8C96-215150578932")
interface ITfDisplayAttributeInfo : IUnknown
{
    ///Obtains the GUID for the display attribute.
    ///Params:
    ///    pguid = Pointer to a GUID value that receives the GUID for the display attribute.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pguid</i> is invalid.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetGUID(GUID* pguid);
    ///Obtains the description string of the display attribute.
    ///Params:
    ///    pbstrDesc = Pointer to a BSTR value that receives the description string. This value must be allocated using
    ///                SysAllocString. The caller must free this memory using SysFreeString when it is no longer required.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pbstrDesc</i> is
    ///    invalid. </td> </tr> </table>
    ///    
    HRESULT GetDescription(BSTR* pbstrDesc);
    ///Obtains the display attribute data.
    ///Params:
    ///    pda = Pointer to a TF_DISPLAYATTRIBUTE structure that receives display attribute data.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pda</i> is invalid.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetAttributeInfo(TF_DISPLAYATTRIBUTE* pda);
    ///Sets the new attribute data.
    ///Params:
    ///    pda = Pointer to a TF_DISPLAYATTRIBUTE structure that contains the new display attribute data.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The display attribute
    ///    provider does not support attribute modification. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pda</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT SetAttributeInfo(const(TF_DISPLAYATTRIBUTE)* pda);
    ///Resets the display attribute data to its default value.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The display attribute
    ///    provider does not support attribute modification. </td> </tr> </table>
    ///    
    HRESULT Reset();
}

///The <b>IEnumTfDisplayAttributeInfo</b> interface is implemented by the TSF manager to provide an enumeration of
///display attribute information objects.
@GUID("7CEF04D7-CB75-4E80-A7AB-5F5BC7D332DE")
interface IEnumTfDisplayAttributeInfo : IUnknown
{
    ///Creates a copy of the enumerator object.
    ///Params:
    ///    ppEnum = Pointer to an IEnumTfDisplayAttributeInfo interface pointer that receives the new enumerator.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The method is not
    ///    implemented. </td> </tr> </table>
    ///    
    HRESULT Clone(IEnumTfDisplayAttributeInfo* ppEnum);
    ///Obtains, from the current position, the specified number of elements in the enumeration sequence.
    ///Params:
    ///    ulCount = Specifies the number of elements to obtain.
    ///    rgInfo = Pointer to an array of ITfDisplayAttributeInfo interface pointers that receives the requested objects. This
    ///             array must be at least <i>ulCount</i> elements in size.
    ///    pcFetched = Pointer to a ULONG value that receives the number of elements actually obtained. The number of elements can
    ///                be less than the number of items requested. This parameter can be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements were obtained. </td> </tr> </table>
    ///    
    HRESULT Next(uint ulCount, char* rgInfo, uint* pcFetched);
    ///Resets the enumerator object by moving the current position to the beginning of the enumeration sequence.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT Reset();
    ///Moves the current position forward in the enumeration sequence by the specified number of elements.
    ///Params:
    ///    ulCount = Contains the number of elements to skip.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements could be skipped. </td> </tr> </table>
    ///    
    HRESULT Skip(uint ulCount);
}

///The <b>ITfDisplayAttributeProvider</b> interface is implemented by a text service and is used by the TSF manager to
///enumerate and obtain individual display attribute information objects. The TSF manager obtains an instance of this
///interface by calling CoCreateInstance with the class identifier passed to ITfCategoryMgr::RegisterCategory with
///GUID_TFCAT_DISPLAYATTRIBUTEPROVIDER and IID_ITfDisplayAttributeProvider. For more information, see Providing Display
///Attributes.
@GUID("FEE47777-163C-4769-996A-6E9C50AD8F54")
interface ITfDisplayAttributeProvider : IUnknown
{
    ///Obtains an enumerator that contains all display attribute info objects supported by the display attribute
    ///provider.
    ///Params:
    ///    ppEnum = Pointer to an IEnumTfDisplayAttributeInfo interface pointer that receives the enumerator object. The caller
    ///             must release this interface when it is no longer required.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>ppEnum</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> A memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT EnumDisplayAttributeInfo(IEnumTfDisplayAttributeInfo* ppEnum);
    ///Obtains a display attribute provider object for a particular display attribute.
    ///Params:
    ///    guid = Contains a GUID value that identifies the display attribute to obtain the display attribute information
    ///           object for. The text service must publish these values and what they indicate. This identifier can also be
    ///           obtained by enumerating the display attributes for a range of text.
    ///    ppInfo = Pointer to an ITfDisplayAttributeInfo interface pointer that receives the display attribute information
    ///             object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> A memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT GetDisplayAttributeInfo(const(GUID)* guid, ITfDisplayAttributeInfo* ppInfo);
}

///The <b>ITfDisplayAttributeMgr</b> interface is implemented by the TSF manager and used by an application to obtain
///and enumerate display attributes. Individual display attributes are accessed through the ITfDisplayAttributeInfo
///interface.
@GUID("8DED7393-5DB1-475C-9E71-A39111B0FF67")
interface ITfDisplayAttributeMgr : IUnknown
{
    ///Called when a display attribute is changed.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnUpdateInfo();
    ///Obtains a display attribute enumerator object.
    ///Params:
    ///    ppEnum = Pointer to an IEnumTfDisplayAttributeInfo interface pointer that receives the enumerator object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppEnum</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A
    ///    memory allocation failure occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
    ///    <td width="60%"> The enumerator object cannot be initialized. </td> </tr> </table>
    ///    
    HRESULT EnumDisplayAttributeInfo(IEnumTfDisplayAttributeInfo* ppEnum);
    ///Obtains a display attribute data object.
    ///Params:
    ///    guid = Contains a GUID that identifies the display attribute data requested. This value is obtained by obtaining the
    ///           GUID_PROP_ATTRIBUTE property for the range of text. For more information, see ITfContext::GetProperty and
    ///           ITfContext::TrackProperties.
    ///    ppInfo = Pointer to an ITfDisplayAttributeInfo interface pointer that receives the object.
    ///    pclsidOwner = Pointer to a CLSID value that receives the CLSID of the display attribute provider. This parameter can be
    ///                  <b>NULL</b> if the CLSID is not required.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetDisplayAttributeInfo(const(GUID)* guid, ITfDisplayAttributeInfo* ppInfo, GUID* pclsidOwner);
}

///The <b>ITfDisplayAttributeNotifySink</b> interface is implemented by an application to receive a notification when
///display attribute information is updated. This advise sink is installed by calling the TSF manager's
///ITfSource::AdviseSink with IID_ITfDisplayAttributeNotifySink.
@GUID("AD56F402-E162-4F25-908F-7D577CF9BDA9")
interface ITfDisplayAttributeNotifySink : IUnknown
{
    ///Called when display attribute information is updated.
    HRESULT OnUpdateInfo();
}

///The <b>ITfCategoryMgr</b> interface manages categories of objects for text services. The TSF manager implements this
///interface. TSF categories help organize objects identified by a globally unique identifier ( GUID ). For example, a
///class identifier ( CLSID ) identifies a text service, and a GUID identifies the TSF compartment, TSF properties, and
///TSF display attributes. To group and organize multiple GUIDs, TSF uses category identifiers ( CATIDs). The category
///manager uses an internal table, accessed with keys called GUID atoms to cache the GUIDs. Access to GUIDs is efficient
///using these atoms. When a GUID is obtained using its atom, the GUID description and value can be obtained from the
///Windows registry.
@GUID("C3ACEFB5-F69D-4905-938F-FCADCF4BE830")
interface ITfCategoryMgr : IUnknown
{
    ///Adds a specified GUID to the specified category in the Windows registry.
    ///Params:
    ///    rclsid = Contains the CLSID of the text service that owns the item.
    ///    rcatid = Contains a GUID value that identifies the category to register the item under. This can be a user-defined
    ///             category or one of the predefined category values.
    ///    rguid = Contains a GUID value that identifies the item to register.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT RegisterCategory(const(GUID)* rclsid, const(GUID)* rcatid, const(GUID)* rguid);
    ///Removes a specified GUID from the specified category in the Windows registry.
    ///Params:
    ///    rclsid = Contains the CLSID of the text service that owns the item.
    ///    rcatid = Contains a GUID that identifies the category that the item is registered under.
    ///    rguid = Contains a GUID that identifies the item to remove.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT UnregisterCategory(const(GUID)* rclsid, const(GUID)* rcatid, const(GUID)* rguid);
    ///Obtains an IEnumGUID interface that enumerates all categories to which the specified GUID belongs.
    ///Params:
    ///    rguid = Contains a GUID value that identifies the item to enumerate the categories for.
    ///    ppEnum = Pointer to an IEnumGUID interface pointer that receives the enumerator.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>ppEnum</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> There is insufficient memory to perform the operation. </td> </tr> </table>
    ///    
    HRESULT EnumCategoriesInItem(const(GUID)* rguid, IEnumGUID* ppEnum);
    ///Obtains an IEnumGUID interface that enumerates all GUIDs included in the specified category.
    ///Params:
    ///    rcatid = Contains a GUID value that identifies the category to enumerate the items for.
    ///    ppEnum = Pointer to an IEnumGUID interface pointer that receives the enumerator.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>ppEnum</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> There is insufficient memory to perform the operation. </td> </tr> </table>
    ///    
    HRESULT EnumItemsInCategory(const(GUID)* rcatid, IEnumGUID* ppEnum);
    ///Finds the category closest to the specified GUID from a list of categories.
    ///Params:
    ///    rguid = Specifies the address of the GUID for which to find the closest category.
    ///    pcatid = Pointer to the **GUID** that receives the CATID for the closest category.
    ///    ppcatidList = Pointer to a pointer that specifies an array of CATIDs to search for the closest category.
    ///    ulCount = Specifies the number of elements in the array of the <i>ppcatidList</i> parameter.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method obtained the closest category
    ///    from the list of categories, or the method was unable to obtain a category from the list and indicates this
    ///    with a <i>pcatid</i> parameter pointer to GUID_NULL. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method was unable to find a category for the
    ///    specified GUID and signals this with a <i>pcatid</i> parameter pointer to GUID_NULL. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method cannot access the internal
    ///    table. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    specified <i>pcatid</i> parameter was <b>NULL</b> on input, or the list of categories contained a <b>NULL</b>
    ///    element when the <i>ulCount</i> parameter was nonzero. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is insufficient memory to perform the
    ///    operation. </td> </tr> </table>
    ///    
    HRESULT FindClosestCategory(const(GUID)* rguid, GUID* pcatid, const(GUID)** ppcatidList, uint ulCount);
    ///Enters a description for a GUID previously registered in the Windows registry.
    ///Params:
    ///    rclsid = Contains the CLSID of the text service that owns the GUID.
    ///    rguid = Contains the GUID that the description is registered for.
    ///    pchDesc = Pointer to a <b>WCHAR</b> buffer that contains the description for the GUID.
    ///    cch = Contains the length, in characters, of the description string.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method was unable to
    ///    register the description string. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pchDest</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT RegisterGUIDDescription(const(GUID)* rclsid, const(GUID)* rguid, const(wchar)* pchDesc, uint cch);
    ///Removes the description for a GUID from the Windows registry.
    ///Params:
    ///    rclsid = Contains the CLSID of the text service that owns the GUID.
    ///    rguid = Contains the GUID that the description is removed for.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The GUID cannot be found.
    ///    </td> </tr> </table>
    ///    
    HRESULT UnregisterGUIDDescription(const(GUID)* rclsid, const(GUID)* rguid);
    ///Obtains the description of the specified GUID from the Windows registry.
    ///Params:
    ///    rguid = Specifies the GUID to obtain the description for.
    ///    pbstrDesc = Pointer to a <b>BSTR</b> value that receives the description string. Allocate using SysAllocString. The
    ///                caller must free this memory using SysFreeString when it is no longer required. Pointer to a <b>BSTR</b>
    ///                value that receives the description string. This must be allocated using <b>SysAllocString</b>. The caller
    ///                must free this memory using <b>SysFreeString</b> when it is no longer required.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method cannot obtain the
    ///    description. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>pbstrDesc</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT GetGUIDDescription(const(GUID)* rguid, BSTR* pbstrDesc);
    ///Enters a DWORD value for a GUID previously registered in the Windows registry.
    ///Params:
    ///    rclsid = Contains the CLSID of the text service that owns the GUID.
    ///    rguid = Contains the GUID that the <b>DWORD</b> is registered for.
    ///    dw = Contains the <b>DWORD</b> value registered for the GUID.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method was unable to
    ///    register the <b>DWORD</b> value. </td> </tr> </table>
    ///    
    HRESULT RegisterGUIDDWORD(const(GUID)* rclsid, const(GUID)* rguid, uint dw);
    ///Removes the DWORD value for a GUID from the Windows registry.
    ///Params:
    ///    rclsid = Contains the CLSID of the text service that owns the GUID.
    ///    rguid = Contains the GUID that the <b>DWORD</b> is removed for.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The GUID cannot be found.
    ///    </td> </tr> </table>
    ///    
    HRESULT UnregisterGUIDDWORD(const(GUID)* rclsid, const(GUID)* rguid);
    ///Obtains the DWORD value of the specified GUID from the Windows registry.
    ///Params:
    ///    rguid = Specifies the address of the GUID for which to get the value.
    ///    pdw = Pointer to the <b>DWORD</b> variable that receives the value of the GUID.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method was unable to get
    ///    the <b>DWORD</b> value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The specified <i>pdw</i> parameter was <b>NULL</b> on input. </td> </tr> </table>
    ///    
    HRESULT GetGUIDDWORD(const(GUID)* rguid, uint* pdw);
    ///Adds a GUID to the internal table and obtains an atom for the GUID.
    ///Params:
    ///    rguid = Contains the GUID to obtain the identifier for.
    ///    pguidatom = Pointer to a TfGuidAtom value that receives the identifier of the GUID.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>pguidatom</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT RegisterGUID(const(GUID)* rguid, uint* pguidatom);
    ///Obtains a GUID from the internal table using its atom.
    ///Params:
    ///    guidatom = Contains a <b>TfGuidAtom</b> value that specifies the GUID to obtain.
    ///    pguid = Pointer to a <b>GUID</b> value that receives the <b>GUID</b> for the specified atom. Receives GUID_NULL if
    ///            the <b>GUID</b> for the atom cannot be found.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pguid</i>
    ///    is invalid. </td> </tr> </table>
    ///    
    HRESULT GetGUID(uint guidatom, GUID* pguid);
    ///Determines whether the specified atom represents the specified GUID in the internal table.
    ///Params:
    ///    guidatom = Specifies an atom that represents a GUID in the internal table.
    ///    rguid = Specifies the address of the GUID to compare with the atom in the internal table.
    ///    pfEqual = Pointer to a Boolean variable that receives an indication of whether the atom represents the GUID.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method cannot access the
    ///    internal table. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The specified <i>pfEqual</i> parameter was <b>NULL</b> on input. </td> </tr> </table>
    ///    
    HRESULT IsEqualTfGuidAtom(uint guidatom, const(GUID)* rguid, int* pfEqual);
}

///The <b>ITfSource</b> interface is implemented by the TSF manager. It is used by applications and text services to
///install and uninstall advise sinks.
@GUID("4EA48A35-60AE-446F-8FD6-E6A8D82459F7")
interface ITfSource : IUnknown
{
    ///Installs an advise sink.
    ///Params:
    ///    riid = Identifies the type of advise sink to install. This parameter can be one of the following values when the
    ///           <b>ITfSource</b> object is obtained from an ITfThreadMgr object. This parameter can be one of the following
    ///           values when the ITfSource object is obtained from an ITfContext object. <table> <tr> <th>Value</th>
    ///           <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IID_ITfActiveLanguageProfileNotifySink"></a><a
    ///           id="iid_itfactivelanguageprofilenotifysink"></a><a id="IID_ITFACTIVELANGUAGEPROFILENOTIFYSINK"></a><dl>
    ///           <dt><b>IID_ITfActiveLanguageProfileNotifySink</b></dt> </dl> </td> <td width="60%"> Installs an
    ///           ITfActiveLanguageProfileNotifySink advise sink. </td> </tr> <tr> <td width="40%"><a
    ///           id="IID_ITfDisplayAttributeNotifySink"></a><a id="iid_itfdisplayattributenotifysink"></a><a
    ///           id="IID_ITFDISPLAYATTRIBUTENOTIFYSINK"></a><dl> <dt><b>IID_ITfDisplayAttributeNotifySink</b></dt> </dl> </td>
    ///           <td width="60%"> Installs an ITfDisplayAttributeNotifySink advise sink. </td> </tr> <tr> <td width="40%"><a
    ///           id="IID_ITfKeyTraceEventSink"></a><a id="iid_itfkeytraceeventsink"></a><a
    ///           id="IID_ITFKEYTRACEEVENTSINK"></a><dl> <dt><b>IID_ITfKeyTraceEventSink</b></dt> </dl> </td> <td width="60%">
    ///           Installs an ITfKeyTraceEventSink advise sink. </td> </tr> <tr> <td width="40%"><a
    ///           id="IID_ITfPreservedKeyNotifySink"></a><a id="iid_itfpreservedkeynotifysink"></a><a
    ///           id="IID_ITFPRESERVEDKEYNOTIFYSINK"></a><dl> <dt><b>IID_ITfPreservedKeyNotifySink</b></dt> </dl> </td> <td
    ///           width="60%"> Installs an ITfPreservedKeyNotifySink advise sink. </td> </tr> <tr> <td width="40%"><a
    ///           id="IID_ITfThreadFocusSink"></a><a id="iid_itfthreadfocussink"></a><a id="IID_ITFTHREADFOCUSSINK"></a><dl>
    ///           <dt><b>IID_ITfThreadFocusSink</b></dt> </dl> </td> <td width="60%"> Installs an ITfThreadFocusSink advise
    ///           sink. </td> </tr> <tr> <td width="40%"><a id="IID_ITfThreadMgrEventSink"></a><a
    ///           id="iid_itfthreadmgreventsink"></a><a id="IID_ITFTHREADMGREVENTSINK"></a><dl>
    ///           <dt><b>IID_ITfThreadMgrEventSink</b></dt> </dl> </td> <td width="60%"> Installs an ITfThreadMgrEventSink
    ///           advise sink. </td> </tr> </table>
    ///    punk = The advise sink <b>IUnknown</b> pointer.
    ///    pdwCookie = Address of a DWORD value that receives an identifying cookie. This value is used to uninstall the advise sink
    ///                in a subsequent call to ITfSource::UnadviseSink. Receives (DWORD)-1 if a failure occurs.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CONNECT_E_CANNOTCONNECT</b></dt> </dl> </td> <td
    ///    width="60%"> The advise sink cannot be installed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>CONNECT_E_ADVISELIMIT</b></dt> </dl> </td> <td width="60%"> The maximum number of advise sinks has
    ///    been reached. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> A memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT AdviseSink(const(GUID)* riid, IUnknown punk, uint* pdwCookie);
    ///Uninstalls an advise sink.
    ///Params:
    ///    dwCookie = A DWORD that identifies the advise sink to uninstall. This value is provided by a previous call to
    ///               ITfSource::AdviseSink.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>dwCookie</i>
    ///    value is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CONNECT_E_NOCONNECTION</b></dt> </dl> </td>
    ///    <td width="60%"> The advise sink cannot be found. </td> </tr> </table>
    ///    
    HRESULT UnadviseSink(uint dwCookie);
}

///The <b>ITfSourceSingle</b> interface is implemented by the TSF manager. It is used by applications and text services
///to install and remove various advise sinks. This interface differs from ITfSource in that advise sinks installed with
///<b>ITfSourceSingle</b> only support one advise sink at a time whereas advise sinks installed with <b>ITfSource</b>
///support multiple simultaneous advise sinks.
@GUID("73131F9C-56A9-49DD-B0EE-D046633F7528")
interface ITfSourceSingle : IUnknown
{
    ///Installs an advise sink.
    ///Params:
    ///    tid = Contains a <b>TfClientId</b> value that identifies the client.
    ///    riid = Identifies the type of advise sink to install. This parameter can be one of the following values when the
    ///           ITfSourceSingle object is obtained from an ITfThreadMgr object. This parameter can be one of the following
    ///           values when the <b>ITfSourceSingle</b> object is obtained from an ITfContext object. <table> <tr>
    ///           <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IID_ITfCleanupContextDurationSink"></a><a
    ///           id="iid_itfcleanupcontextdurationsink"></a><a id="IID_ITFCLEANUPCONTEXTDURATIONSINK"></a><dl>
    ///           <dt><b>IID_ITfCleanupContextDurationSink</b></dt> </dl> </td> <td width="60%"> Installs a
    ///           ITfCleanupContextDurationSink advise sink. </td> </tr> <tr> <td width="40%"><a
    ///           id="IID_ITfFunctionProvider"></a><a id="iid_itffunctionprovider"></a><a id="IID_ITFFUNCTIONPROVIDER"></a><dl>
    ///           <dt><b>IID_ITfFunctionProvider</b></dt> </dl> </td> <td width="60%"> Registers the client as a function
    ///           provider. The <i>punk</i> parameter is an ITfFunctionProvider interface pointer. </td> </tr> </table>
    ///    punk = Pointer to the advise sink <b>IUnknown</b> pointer.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CONNECT_E_CANNOTCONNECT</b></dt> </dl> </td> <td
    ///    width="60%"> The advise sink cannot be installed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>CONNECT_E_ADVISELIMIT</b></dt> </dl> </td> <td width="60%"> The maximum number of advise sinks has
    ///    been reached. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> A memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT AdviseSingleSink(uint tid, const(GUID)* riid, IUnknown punk);
    ///Uninstalls an advise sink.
    ///Params:
    ///    tid = Contains a <b>TfClientId</b> value that identifies the client.
    ///    riid = Identifies the type of advise sink to uninstall. This can be one of the following values. <table> <tr>
    ///           <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IID_ITfCleanupContextDurationSink"></a><a
    ///           id="iid_itfcleanupcontextdurationsink"></a><a id="IID_ITFCLEANUPCONTEXTDURATIONSINK"></a><dl>
    ///           <dt><b>IID_ITfCleanupContextDurationSink</b></dt> </dl> </td> <td width="60%"> Uninstalls the
    ///           ITfCleanupContextDurationSink advise sink. Applies to: Text service </td> </tr> <tr> <td width="40%"><a
    ///           id="IID_ITfCleanupContextSink"></a><a id="iid_itfcleanupcontextsink"></a><a
    ///           id="IID_ITFCLEANUPCONTEXTSINK"></a><dl> <dt><b>IID_ITfCleanupContextSink</b></dt> </dl> </td> <td
    ///           width="60%"> Uninstalls the ITfCleanupContextSink advise sink. Applies to: Text service </td> </tr> <tr> <td
    ///           width="40%"><a id="IID_ITfFunctionProvider"></a><a id="iid_itffunctionprovider"></a><a
    ///           id="IID_ITFFUNCTIONPROVIDER"></a><dl> <dt><b>IID_ITfFunctionProvider</b></dt> </dl> </td> <td width="60%">
    ///           Unregisters the client as a function provider. Applies to: Text Service and Application </td> </tr> </table>
    HRESULT UnadviseSingleSink(uint tid, const(GUID)* riid);
}

///The <b>ITfUIElementMgr</b> interface is implemented by TSF manager and used by an application or a text service. An
///application and a text service can obtain this interface by ITfThreadMgr::QueryInterface with IID_ITfUIElementMgr.
@GUID("EA1EA135-19DF-11D7-A6D2-00065B84435C")
interface ITfUIElementMgr : IUnknown
{
    ///The <b>ITfUIElementMgr::BeginUIElement</b> method is called by a text service before showing UI. The value
    ///returned determines whether the UI for the text service should be shown or not.
    ///Params:
    ///    pElement = [in] A pointer to the ITfUIElement interface of the UIElement object.
    ///    pbShow = [in, out] If false is returned, the application may draw the UI by itself and a text service does not show
    ///             its own UI for this UI element.
    ///    pdwUIElementId = [out] A pointer to receive the ID of this UI element.
    HRESULT BeginUIElement(ITfUIElement pElement, int* pbShow, uint* pdwUIElementId);
    ///The <b>ITfUIElementMgr::UpdateUIElement</b> method is called by a text service when the UI element must be
    ///updated.
    ///Params:
    ///    dwUIElementId = [in] The element id to update the UI element.
    HRESULT UpdateUIElement(uint dwUIElementId);
    ///The <b>ITfUIElementMgr::EndUIElement</b> method is called by a text service when the element of UI is hidden.
    ///Params:
    ///    dwUIElementId = [in] The element id to hide the UI element.
    HRESULT EndUIElement(uint dwUIElementId);
    ///The <b>ITfUIElementMgr::GetUIElement</b> method gets the ITfUIElement interface of the element id.
    ///Params:
    ///    dwUIELementId = [in] The element id to get the ITfUIElement interface.
    ///    ppElement = [out] A pointer to receive ITfUIElement interface.
    HRESULT GetUIElement(uint dwUIELementId, ITfUIElement* ppElement);
    ///The <b>ITfUIElementMgr::EnumUIElements</b> method returns IEnumTfUIElements interface pointer to enumerate the
    ///ITfUIElement.
    ///Params:
    ///    ppEnum = [in] A pointer to receive the IEnumTfUIElements interface.
    HRESULT EnumUIElements(IEnumTfUIElements* ppEnum);
}

///The <b>IEnumTfUIElements</b> interface is implemented by TSF manager and used by applications or textservices. This
///interface can be retrieved by ITfUIElementMgr::EnumUIElements and enumerates the registered UI elements.
@GUID("887AA91E-ACBA-4931-84DA-3C5208CF543F")
interface IEnumTfUIElements : IUnknown
{
    ///The <b>IEnumTfUIElements::Clone</b> method creates a copy of the enumerator object.
    ///Params:
    ///    ppEnum = [out] A pointer to a IEnumTfUIElements interface.
    HRESULT Clone(IEnumTfUIElements* ppEnum);
    ///The <b>IEnumTfUIElements::Next</b> method obtains, from the current position, the specified number of elements in
    ///the enumeration sequence.
    ///Params:
    ///    ulCount = [out] Specifies the number of elements to obtain.
    ///    ppElement = [out] Pointer to an array of ITfUIElement interface pointer. This array must be at least <i>ulCount</i>
    ///                elements in size.
    ///    pcFetched = [out] Pointer to a ULONG value that receives the number of elements actually obtained. This value can be less
    ///                than the number of items requested. This parameter can be <b>NULL</b>.
    HRESULT Next(uint ulCount, ITfUIElement* ppElement, uint* pcFetched);
    ///The <b>IEnumTfUIElements::Reset</b> method resets the enumerator object by moving the current position to the
    ///beginning of the enumeration sequence.
    HRESULT Reset();
    ///The <b>IEnumTfUIElements::Skip</b> method obtains, from the current position, the specified number of elements in
    ///the enumeration sequence.
    ///Params:
    ///    ulCount = [in] Specifies the number of elements to skip.
    HRESULT Skip(uint ulCount);
}

///The <b>ITfUIElementSink</b> interface is implemented by an application to receive notifications when the UI element
///is changed.
@GUID("EA1EA136-19DF-11D7-A6D2-00065B84435C")
interface ITfUIElementSink : IUnknown
{
    ///The <b>ITfUIElementSink::BeginUIElement</b> method is called when the UIElement started. This sink can let the
    ///textservice to draw or not to draw the UI element.
    ///Params:
    ///    dwUIElementId = [in] Id of the UIElement that was started.
    ///    pbShow = [in, out] Return <b>true</b> if the application does not draw the UIElement content and the text service
    ///             draws its original UI content. Return <b>false</b> if the application draws the UIElement's content and stops
    ///             the text service from drawing it. The application can get the ITfUIElement interface by using
    ///             ITfUIElementMgr::GetUIElement and it can evaluate if it can handle the UIElement by QI with
    ///             <b>IID_ITfCandidateListUIElement</b> or with other UIElement interfaces. The application can always return
    ///             <b>FALSE</b> if it is unknown or it cannot be handled. In this case, the text service will not show any extra
    ///             UI on the screen. This is a good way for some full screen applications. Alternatively, the application can
    ///             return <b>TRUE</b> to use TextService's UI on some particular or unknown UIs.
    HRESULT BeginUIElement(uint dwUIElementId, int* pbShow);
    ///The <b>ITfUIElementSink::UpdateUIElement</b> method is called when the contents of the UIElement is updated.
    ///Params:
    ///    dwUIElementId = [in] Id of the UIElement that has had its content updated.
    HRESULT UpdateUIElement(uint dwUIElementId);
    ///The <b>ITfUIElementSink::EndUIElement</b> method is called when the UIElement is finished.
    ///Params:
    ///    dwUIElementId = [in] Id of the UIElement that is finished.
    HRESULT EndUIElement(uint dwUIElementId);
}

///The ITfUIElement interface is a base interface of the UIElement object and is implemented by a text service.
@GUID("EA1EA137-19DF-11D7-A6D2-00065B84435C")
interface ITfUIElement : IUnknown
{
    ///The <b>ITfUIElement::GetDescription</b> method returns the description of the UI element.
    ///Params:
    ///    pbstrDescription = [in] A pointer to BSTR that contains the description of the UI element.
    HRESULT GetDescription(BSTR* pbstrDescription);
    ///The <b>ITfUIElement::GetGUID</b> method returns the unique id of this UI element.
    ///Params:
    ///    pguid = [out] A pointer to receive the GUID of the UI element.
    HRESULT GetGUID(GUID* pguid);
    ///The <b>ITfUIElement::Show</b> method shows the text service's UI of this UI element.
    ///Params:
    ///    bShow = [in] <b>TRUE</b> to show the original UI of the element. <b>FALSE</b> to hide the original UI of the element.
    HRESULT Show(BOOL bShow);
    ///The <b>ITfUIElement::IsShown</b> method returns true if the UI is currently shown by a text service; otherwise
    ///false.
    ///Params:
    ///    pbShow = [out] A pointer to bool of the current show status of the original UI of this element.
    HRESULT IsShown(int* pbShow);
}

///The <b>ITfCandidateListUIElement</b> interface is implemented by a text service that has the candidate list UI.
@GUID("EA1EA138-19DF-11D7-A6D2-00065B84435C")
interface ITfCandidateListUIElement : ITfUIElement
{
    ///The <b>ITfCandidateListUIElement::GetUpdatedFlags</b> method returns the flag that tells which part of this
    ///element was updated.
    ///Params:
    ///    pdwFlags = [out] a pointer to receive the flags that is a combination of the following bits: <table> <tr> <th>Value</th>
    ///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TF_CLUIE_DOCUMENTMGR"></a><a
    ///               id="tf_cluie_documentmgr"></a><dl> <dt><b>TF_CLUIE_DOCUMENTMGR</b></dt> </dl> </td> <td width="60%"> The
    ///               target document manager was changed. </td> </tr> <tr> <td width="40%"><a id="TF_CLUIE_COUNT"></a><a
    ///               id="tf_cluie_count"></a><dl> <dt><b>TF_CLUIE_COUNT</b></dt> </dl> </td> <td width="60%"> The count of the
    ///               candidate string was changed. </td> </tr> <tr> <td width="40%"><a id="TF_CLUIE_SELECTION"></a><a
    ///               id="tf_cluie_selection"></a><dl> <dt><b>TF_CLUIE_SELECTION</b></dt> </dl> </td> <td width="60%"> The
    ///               selection of the candidate was changed. </td> </tr> <tr> <td width="40%"><a id="TF_CLUIE_STRING"></a><a
    ///               id="tf_cluie_string"></a><dl> <dt><b>TF_CLUIE_STRING</b></dt> </dl> </td> <td width="60%"> Some strings in
    ///               the list were changed. </td> </tr> <tr> <td width="40%"><a id="TF_CLUIE_PAGEINDEX"></a><a
    ///               id="tf_cluie_pageindex"></a><dl> <dt><b>TF_CLUIE_PAGEINDEX</b></dt> </dl> </td> <td width="60%"> The current
    ///               page index or some page index was changed. </td> </tr> <tr> <td width="40%"><a
    ///               id="TF_CLUIE_CURRENTPAGE"></a><a id="tf_cluie_currentpage"></a><dl> <dt><b>TF_CLUIE_CURRENTPAGE</b></dt>
    ///               </dl> </td> <td width="60%"> The page was changed. </td> </tr> </table>
    HRESULT GetUpdatedFlags(uint* pdwFlags);
    ///The <b>ITfCandidateListUIElement::GetDocumentMgr</b> method returns the target document manager of this UI.
    ///Params:
    ///    ppdim = [out] A pointer to receive ITfDocumentMgr interface pointer.
    HRESULT GetDocumentMgr(ITfDocumentMgr* ppdim);
    ///The <b>ITfCandidateListUIElement::GetCount</b> method returns the count of the candidate strings.
    ///Params:
    ///    puCount = [out] A pointer to receive a count of the candidate strings.
    HRESULT GetCount(uint* puCount);
    ///The <b>ITfCandidateListUIElement::GetSelection</b> method returns the current selection of the candidate list.
    ///Params:
    ///    puIndex = [out] A pointer to receive an index of the current selected candidate string.
    HRESULT GetSelection(uint* puIndex);
    ///The <b>ITfCandidateListUIElement::GetString</b> method returns the string of the index.
    ///Params:
    ///    uIndex = [in] An index of the string to obtain.
    ///    pstr = [out] A pointer to BSTR for the candidate string of the index.
    HRESULT GetString(uint uIndex, BSTR* pstr);
    ///The <b>ITfCandidateListUIElement::GetPageIndex</b> method returns the page index of the list.
    ///Params:
    ///    pIndex = [out] A pointer that receives an array of the indexes that each page starts from. This can be <b>NULL</b>.
    ///             The caller calls this method with <b>NULL</b> for this parameter first to get the number of pages in
    ///             <i>puPageCnt</i> and allocates the buffer to receive indexes for all pages.
    ///    uSize = [in] A buffer size of <i>pIndex</i>.
    ///    puPageCnt = [out] A pointer to receive the page count.
    HRESULT GetPageIndex(uint* pIndex, uint uSize, uint* puPageCnt);
    ///The <b>ITfCandidateListUIElement::SetPageIndex</b> method sets the page index.
    ///Params:
    ///    pIndex = [in] A pointer to an array of the indexes that each page starts from.
    ///    uPageCnt = [in] A page count. The size of the pIndex buffer.
    HRESULT SetPageIndex(uint* pIndex, uint uPageCnt);
    ///The <b>ITfCandidateListUIElement::GetCurrentPage</b> method returns the current page.
    ///Params:
    ///    puPage = [in] A pointer to receive the current page index.
    HRESULT GetCurrentPage(uint* puPage);
}

///This interface is implemented by a text service that has a candidate list UI and its UI can be controlled by the
///application. The application QI this interface from ITfUIElement and controls the candidate list behavior.
@GUID("85FAD185-58CE-497A-9460-355366B64B9A")
interface ITfCandidateListUIElementBehavior : ITfCandidateListUIElement
{
    ///The <b>ITfCandidateListUIElementBehavior::SetSelection</b> method set the selection of the candidate list.
    ///Params:
    ///    nIndex = [in] An index for the candidate string to be selected.
    HRESULT SetSelection(uint nIndex);
    ///The <b>ITfCandidateListUIElementBehavior::Finalize</b> method finalizes the current selection and close the
    ///candidate list.
    HRESULT Finalize();
    ///The <b>ITfCandidateListUIElementBehavior::Abort</b> method closes the candidate list. There is no guarantee that
    ///the current selection will be finalized.
    HRESULT Abort();
}

///The <b>ITfCandidateListUIElement</b> interface is implemented by a text service that has a UI for reading information
///UI at the near caret.
@GUID("EA1EA139-19DF-11D7-A6D2-00065B84435C")
interface ITfReadingInformationUIElement : ITfUIElement
{
    ///This method returns the flag that tells which part of this element was updated.
    ///Params:
    ///    pdwFlags = [out] A pointer to receive the flags that is a combination of the following bits: <table> <tr> <th>Value</th>
    ///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TF_RIUIE_CONTEXT"></a><a id="tf_riuie_context"></a><dl>
    ///               <dt><b>TF_RIUIE_CONTEXT</b></dt> </dl> </td> <td width="60%"> The target ITfContext was changed. </td> </tr>
    ///               <tr> <td width="40%"><a id="TF_RIUIE_STRING"></a><a id="tf_riuie_string"></a><dl>
    ///               <dt><b>TF_RIUIE_STRING</b></dt> </dl> </td> <td width="60%"> The reading information string was changed.
    ///               </td> </tr> <tr> <td width="40%"><a id="TF_RIUIE_MAXREADINGSTRINGLENGTH"></a><a
    ///               id="tf_riuie_maxreadingstringlength"></a><dl> <dt><b>TF_RIUIE_MAXREADINGSTRINGLENGTH</b></dt> </dl> </td> <td
    ///               width="60%"> The max length of the reading information string was changed. </td> </tr> <tr> <td
    ///               width="40%"><a id="TF_RIUIE_ERRORINDEX"></a><a id="tf_riuie_errorindex"></a><dl>
    ///               <dt><b>TF_RIUIE_ERRORINDEX</b></dt> </dl> </td> <td width="60%"> The error index of the reading information
    ///               string was changed. </td> </tr> <tr> <td width="40%"><a id="TF_RIUIE_VERTICALORDER"></a><a
    ///               id="tf_riuie_verticalorder"></a><dl> <dt><b>TF_RIUIE_VERTICALORDER</b></dt> </dl> </td> <td width="60%"> The
    ///               vertical order preference was changed. </td> </tr> </table>
    HRESULT GetUpdatedFlags(uint* pdwFlags);
    ///This method returns the target ITfContext of this reading information UI.
    ///Params:
    ///    ppic = [out] A pointer to receive the target ITfContext interface of this UI element.
    HRESULT GetContext(ITfContext* ppic);
    ///This method returns the string on the reading information UI.
    ///Params:
    ///    pstr = [out] A pointer to the BSTR of the reading information string.
    HRESULT GetString(BSTR* pstr);
    ///The <b>ITfReadingInformationUIElement::GetMaxReadingStringLength</b> method returns the max string count of the
    ///reading information UI.
    ///Params:
    ///    pcchMax = [out] A pointer to the max length of the reading information string.
    HRESULT GetMaxReadingStringLength(uint* pcchMax);
    ///This method returns the char index where the typing error occurs.
    ///Params:
    ///    pErrorIndex = [out] A pointer to receive the char index where the typing error occurs.
    HRESULT GetErrorIndex(uint* pErrorIndex);
    ///This method returns if the UI prefers to be shown in vertical order.
    ///Params:
    ///    pfVertical = [out] True if the UI prefers to be shown in the vertical order.
    HRESULT IsVerticalOrderPreferred(int* pfVertical);
}

///The <b>ITfTransitoryExtensionUIElement</b> interface is implemented by TSF manager which provides the UI of
///transitory extension. The application that is in UILess mode will use this interface to determine if the original UI
///should be shown or the content of this UI should be drown by the application.
@GUID("858F956A-972F-42A2-A2F2-0321E1ABE209")
interface ITfTransitoryExtensionUIElement : ITfUIElement
{
    ///The <b>ITfTransitoryExtensionUIElement::GetDocumentMgr</b> method returns the pointer of the transitory document
    ///manager.
    ///Params:
    ///    ppdim = [out] A pointer to receive the ITfDocumentMgr interface pointer. This document manager object contains a
    ///            context object that has the ITfContext interface and contains the text of the transitory extension.
    HRESULT GetDocumentMgr(ITfDocumentMgr* ppdim);
}

///The <b>ITfTransitoryExtensionSink</b> interface is implemented by the application that uses Transitory Extension dim.
///The application can track the changes that happened in the transitory extension by using this sink interface.
@GUID("A615096F-1C57-4813-8A15-55EE6E5A839C")
interface ITfTransitoryExtensionSink : IUnknown
{
    ///Transitory Document has been updated.
    ///Params:
    ///    pic = [in] A pointer of ITfContext interface. This is a context object in which the update happened.
    ///    ecReadOnly = [in] A read only edit cookie to access the <i>pic</i>. Using this edit cookie, the application can get the
    ///                 text that is contained in the context object.
    ///    pResultRange = [in] A pointer of the ITfRange interface. This is the range of the result string (determined string).
    ///    pCompositionRange = [in] A pointer of the ITfRange interface. This is the range of the current composition string.
    ///    pfDeleteResultRange = [out] A pointer to return the bool value. If it is true, TSF manager deletes the result range so only the
    ///                          current composition range remains in the transitory extension.
    HRESULT OnTransitoryExtensionUpdated(ITfContext pic, uint ecReadOnly, ITfRange pResultRange, 
                                         ITfRange pCompositionRange, int* pfDeleteResultRange);
}

///The <b>ITfToolTipUIElement</b> interface is implemented by a text service that wants to show a tooltip on its UI. A
///fullscreen application which wants to draw all UI by itself may want to draw the tooltip also or it can just hide the
///tooltip or of course it can let the text service show it. However, it does not guarantee that a text service can show
///the tooltip correctly when other UI are asked to be hidden.
@GUID("52B18B5C-555D-46B2-B00A-FA680144FBDB")
interface ITfToolTipUIElement : ITfUIElement
{
    ///Returns the string of the tooltip.
    ///Params:
    ///    pstr = [out] A pointer to receive BSTR. This is the string for the tooltip.
    HRESULT GetString(BSTR* pstr);
}

///<p class="CCE_Message">[<b>ITfReverseConversionList</b> is available for use in the operating systems specified in
///the Requirements section. It may be altered or unavailable in subsequent versions. For internal use only.] Represents
///a list of the keystroke sequences required to create a specified string.
@GUID("151D69F0-86F4-4674-B721-56911E797F47")
interface ITfReverseConversionList : IUnknown
{
    ///<p class="CCE_Message">[<b>GetLength</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For internal use only.] Retrieves
    ///the number of keystroke sequences in the list.
    ///Params:
    ///    puIndex = The number of keystroke sequences in the list.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLength(uint* puIndex);
    ///<p class="CCE_Message">[<b>GetString</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For internal use only.] Retrieves
    ///the keystroke sequence at the specified index.
    ///Params:
    ///    uIndex = The index of the keystroke sequence to retrieve.
    ///    pbstr = The keystroke sequence at the specified index.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return value</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt>S_OK</dt> </dl> </td> <td width="60%"> The keystroke sequence is stored in
    ///    <i>pbstr</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt>E_INVALIDARG</dt> </dl> </td> <td width="60%"> The
    ///    specified index is out of range. </td> </tr> <tr> <td width="40%"> <dl> <dt>E_FAIL</dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetString(uint uIndex, BSTR* pbstr);
}

///<p class="CCE_Message">[<b>ITfReverseConversion</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. For internal use only.] Performs a
///reverse conversion of a specified string.
@GUID("A415E162-157D-417D-8A8C-0AB26C7D2781")
interface ITfReverseConversion : IUnknown
{
    ///<p class="CCE_Message">[<b>DoReverseConversion</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. For internal use only.] Performs a
    ///reverse conversion of the specified string.
    ///Params:
    ///    lpstr = The string to convert.
    ///    ppList = The result of the conversion: a list of the key strokes required to create the string specied by
    ///             <i>lpstr</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return value</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt>S_OK</dt> </dl> </td> <td width="60%"> The conversion result is stored in
    ///    <i>ppList</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt>S_FALSE</dt> </dl> </td> <td width="60%"> The
    ///    conversion result, <i>ppList</i>, contains no entries. </td> </tr> <tr> <td width="40%"> <dl> <dt>E_FAIL</dt>
    ///    </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT DoReverseConversion(const(wchar)* lpstr, ITfReverseConversionList* ppList);
}

///<p class="CCE_Message">[<b>ITfReverseConversionMgr</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. For internal use only.] Provides
///access to ITfReverseConversion objects, which are used to perform reverse conversions.
@GUID("B643C236-C493-41B6-ABB3-692412775CC4")
interface ITfReverseConversionMgr : IUnknown
{
    ///<p class="CCE_Message">[<b>GetReverseConversion</b> is available for use in the operating systems specified in
    ///the Requirements section. It may be altered or unavailable in subsequent versions. For internal use only.]
    ///Retrieves an ITfReverseConversion object that can perform reverse conversions.
    ///Params:
    ///    langid = The language ID of the profile to which the target strings belong.
    ///    guidProfile = The GUID of the profile to which the target strings belong.
    ///    dwflag = <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TF_RCM_COMLESS"></a><a
    ///             id="tf_rcm_comless"></a><dl> <dt><b>TF_RCM_COMLESS</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%">
    ///             Activate the reverse conversion interface without COM. </td> </tr> <tr> <td width="40%"><a
    ///             id="TF_RCM_VKEY"></a><a id="tf_rcm_vkey"></a><dl> <dt><b>TF_RCM_VKEY</b></dt> <dt> 0x00000002</dt> </dl>
    ///             </td> <td width="60%"> The output should be an array of virtual key codes (instead of chracter key codes).
    ///             </td> </tr> <tr> <td width="40%"><a id="TF_RCM_HINT_READING_LENGTH"></a><a
    ///             id="tf_rcm_hint_reading_length"></a><dl> <dt><b>TF_RCM_HINT_READING_LENGTH</b></dt> <dt>0x00000004</dt> </dl>
    ///             </td> <td width="60%"> The reverse conversion should prioritize the order of entries in the output list based
    ///             on the length of input sequence, with the shortest sequences first. It is possible that an input sequence
    ///             with a low collision count might be much higher than an input sequence with a similar (but slightly higher)
    ///             collision count. The interpretation of this flag varies depending on the IME. </td> </tr> <tr> <td
    ///             width="40%"><a id="TF_RCM_HINT_COLLISION_"></a><a id="tf_rcm_hint_collision_"></a><dl>
    ///             <dt><b>TF_RCM_HINT_COLLISION </b></dt> <dt> 0x00000008</dt> </dl> </td> <td width="60%"> The reverse
    ///             conversion should prioritize the order of entries in the output list based on the collision count, with the
    ///             entries containing the lowest number of collisions first. If an input sequence corresponds to many more
    ///             characters than a slightly longer input sequence, it might be preferable to use the longer input sequence
    ///             instead. The IME determines whether this flag will affect the reverse conversion output. </td> </tr> </table>
    ///    ppReverseConversion = A pointer to the address of the ITfReverseConversion object that can perform the specified reverse
    ///                          conversion.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return value</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt>S_OK</dt> </dl> </td> <td width="60%"> An ITfReverseConversion for the
    ///    specified <i>langid</i> and <i>guidProfile</i> combination is available. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt>E_NOTIMPL</dt> </dl> </td> <td width="60%"> The specified <i>langid</i> and <i>guidProfile</i>
    ///    combination does not support reverse conversion. </td> </tr> <tr> <td width="40%"> <dl> <dt>E_FAIL</dt> </dl>
    ///    </td> <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetReverseConversion(ushort langid, const(GUID)* guidProfile, uint dwflag, 
                                 ITfReverseConversion* ppReverseConversion);
}

///The <b>ITfCandidateString</b> interface is implemented by a text service and is used by the TSF manager or a client
///to obtain information about a candidate string object. The TSF manager implements this interface to provide access to
///this interface to other clients. This enables the TSF manager to function as a mediator between the client and the
///text service. To obtain an instance of this interface, the TSF manager or client can call
///ITfCandidateList::GetCandidate.
@GUID("581F317E-FD9D-443F-B972-ED00467C5D40")
interface ITfCandidateString : IUnknown
{
    ///Obtains the text of the candidate string object.
    ///Params:
    ///    pbstr = Pointer to a <b>BSTR</b> value that receives the text of the candidate string object. The caller must release
    ///            this memory using SysFreeString when it is no longer required.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pbstr</i> is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory
    ///    allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT GetString(BSTR* pbstr);
    ///Params:
    ///    pnIndex = Pointer to a <b>ULONG</b> value that receives the zero-based index of the candidate string object within the
    ///              candidate list.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pnIndex</i> is
    ///    invalid. </td> </tr> </table>
    ///    
    HRESULT GetIndex(uint* pnIndex);
}

///The <b>IEnumTfCandidates</b> interface is implemented by a text service and used by the TSF manager to provide an
///enumeration of candidate string objects.
@GUID("DEFB1926-6C80-4CE8-87D4-D6B72B812BDE")
interface IEnumTfCandidates : IUnknown
{
    ///Creates a copy of the enumerator object.
    ///Params:
    ///    ppEnum = Pointer to an IEnumTfCandidates interface pointer that receives the new enumerator.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    failure occurred. </td> </tr> </table>
    ///    
    HRESULT Clone(IEnumTfCandidates* ppEnum);
    ///Obtains, from the current position, the specified number of elements in the enumeration sequence.
    ///Params:
    ///    ulCount = Specifies the number of elements to obtain.
    ///    ppCand = Pointer to an array of ITfCandidateString interface pointers that receives the requested objects. This array
    ///             must be at least <i>ulCount</i> elements in size.
    ///    pcFetched = Pointer to a ULONG value that receives the number of elements obtained. This value can be less than the
    ///                number of items requested. This parameter can be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements were obtained. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppCand</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT Next(uint ulCount, char* ppCand, uint* pcFetched);
    ///Resets the enumerator object by moving the current position to the beginning of the enumeration sequence.
    HRESULT Reset();
    ///Moves the current position forward in the enumeration sequence by the specified number of elements.
    ///Params:
    ///    ulCount = Contains the number of elements to skip.
    HRESULT Skip(uint ulCount);
}

///The <b>ITfCandidateList</b> interface is implemented by a text service and is used by the TSF manager or a client
///(application or other text service) to obtain and manipulate candidate string objects. The TSF manager implements
///this interface to provide access to this interface to other clients. This enables the TSF manager to function as a
///mediator between the client and the text service. To obtain an instance of this interface the TSF manager or client
///can call ITfFnReconversion::GetReconversion.
@GUID("A3AD50FB-9BDB-49E3-A843-6C76520FBF5D")
interface ITfCandidateList : IUnknown
{
    ///Obtains an enumerator that contains all the candidate string objects in the candidate list.
    ///Params:
    ///    ppEnum = Pointer to an IEnumTfCandidates interface pointer that receives the enumerator object. The caller must
    ///             release this interface when it is no longer required.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppEnum</i> is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A
    ///    memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT EnumCandidates(IEnumTfCandidates* ppEnum);
    ///Obtains a specific candidate string object.
    ///Params:
    ///    nIndex = Specifies the zero-based index of the candidate string to obtain.
    ///    ppCand = Pointer to an ITfCandidateString interface pointer that receives the candidate string object. The caller must
    ///             release this interface when it is no longer required.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> <i>nIndex</i> is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>ppCand</i> is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> A memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT GetCandidate(uint nIndex, ITfCandidateString* ppCand);
    ///Obtains the number of candidate string objects in the candidate list.
    ///Params:
    ///    pnCnt = Pointer to a <b>ULONG</b> value that receives the number of candidate string objects in the candidate list.
    HRESULT GetCandidateNum(uint* pnCnt);
    ///Specifies the result of a reconversion operation for s specific candidate string.
    ///Params:
    ///    nIndex = Specifies the zero-based index of the candidate string to set the result for. This parameter is ignored if
    ///             <i>imcr</i> contains CAND_CANCELED.
    ///    imcr = Contains one of the TfCandidateResult values that specifies the result of the reconversion operation.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetResult(uint nIndex, TfCandidateResult imcr);
}

///The <b>ITfFnReconversion</b> interface is implemented by a text service and is used by the TSF manager or a client to
///support reconversion of text provided by the text service. The TSF manager implements this interface to provide
///access to this interface to other clients. This allows the TSF manager to function as a mediator between the client
///and the text service. The TSF manager obtains this interface by calling the text service
///ITfFunctionProvider::GetFunction method with IID_ITfFnReconversion. An application obtains this interface by calling
///the TSF manager <b>ITfFunctionProvider::GetFunction</b> method with IID_ITfFnReconversion.
@GUID("4CEA93C0-0A58-11D3-8DF0-00105A2799B5")
interface ITfFnReconversion : ITfFunction
{
    ///The <b>ITfFnReconversion::QueryRange</b> method obtains the range of text that the reconversion applies to.
    ///Params:
    ///    pRange = Pointer to an ITfRange object that covers all or part of the text to be reconverted.
    ///    ppNewRange = [in, out] Pointer to an ITfRange pointer that receives a range object that covers all of text that can be
    ///                 reconverted. If none of the text covered by <i>pRange</i> can be reconverted, this parameters receives NULL.
    ///                 In this case, the method will return S_OK, so the caller must verify that this parameter is not NULL before
    ///                 using the pointer. When this method is implemented by a text service, this parameter is optional and can be
    ///                 NULL. In this case, the range is not required. When the TSF manager implementation of this method is called,
    ///                 this parameter is not optional and cannot be NULL.
    ///    pfConvertable = Pointer to a <b>BOOL</b> value that receives zero if none of the text covered by <i>pRange</i> can be
    ///                    reconverted or nonzero otherwise.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> A memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT QueryRange(ITfRange pRange, ITfRange* ppNewRange, int* pfConvertable);
    ///Obtains an ITfCandidateList object for a range of text.
    ///Params:
    ///    pRange = Pointer to an ITfRange object that covers the text to be reconverted. This range object is obtained by
    ///             calling ITfFnReconversion::QueryRange.
    ///    ppCandList = Pointer to an <b>ITfCandidateList</b> pointer that receives the candidate list object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> A memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT GetReconversion(ITfRange pRange, ITfCandidateList* ppCandList);
    ///Invokes the reconversion process for a range of text.
    ///Params:
    ///    pRange = Pointer to an ITfRange object that covers the text to be reconverted. To obtain this range object call
    ///             ITfFnReconversion::QueryRange.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> A memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT Reconvert(ITfRange pRange);
}

///The <b>ITfFnPlayBack</b> interface is implemented by the Speech API (SAPI) text service. This interface is used by
///the TSF manager or a client (application or other text service) to control the audio data for speech input text. Each
///spoken word or phrase has audio data stored with the text. This interface is used to obtain the range that covers the
///spoken text and to play back the audio data. A client obtains an instance of this interface by obtaining the
///ITfFunctionProvider for the SAPI text service and calling ITfFunctionProvider::GetFunction with IID_ITfFnPlayBack.
@GUID("A3A416A4-0F64-11D3-B5B7-00C04FC324A1")
interface ITfFnPlayBack : ITfFunction
{
    ///Obtains the range of text for a word or phrase that contains audio data.
    ///Params:
    ///    pRange = Pointer to an ITfRange object that covers all or part of the text that contains audio data.
    ///    ppNewRange = Pointer to an ITfRange pointer that receives a range object that covers all of the text that contains audio
    ///                 data. If there is no audio data for the text covered by <i>pRange</i>, this parameters receives <b>NULL</b>.
    ///                 In this case, the method returns S_OK, so the caller must verify that this parameter is not <b>NULL</b>
    ///                 before using the pointer.
    ///    pfPlayable = Pointer to a <b>BOOL</b> that receives zero if none of the text covered by <i>pRange</i> has any audio data
    ///                 or nonzero otherwise.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> A memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT QueryRange(ITfRange pRange, ITfRange* ppNewRange, int* pfPlayable);
    ///Causes the audio data for a range of text to be played.
    ///Params:
    ///    pRange = Pointer to an ITfRange object that covers the text to play the audio data for. This range object is obtained
    ///             by calling ITfFnPlayBack::QueryRange. If the range has zero length, the range played is expanded to cover the
    ///             entire spoken phrase. If the range has a nonzero length, the range played is expanded to include the entire
    ///             word, or words, that the range partially covers.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory
    ///    allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT Play(ITfRange pRange);
}

///The <b>ITfFnLangProfileUtil</b> interface is implemented by the speech text service and used to provide utility
///methods for the speech text service. A text service can create an instance of this interface by calling
///CoCreateInstance with CLSID_SapiLayr and IID_ITfFnLangProfileUtil.
@GUID("A87A8574-A6C1-4E15-99F0-3D3965F548EB")
interface ITfFnLangProfileUtil : ITfFunction
{
    ///Causes the speech text service to register its active profiles.
    HRESULT RegisterActiveProfiles();
    ///Determines if the speech text service has a profile available for a specific language.
    ///Params:
    ///    langid = Contains a <b>LANGID</b> that specifies the language that the query applies to.
    ///    pfAvailable = Pointer to a <b>BOOL</b> that receives nonzero if a profile is available for the language identified by
    ///                  langid or zero otherwise.
    HRESULT IsProfileAvailableForLang(ushort langid, int* pfAvailable);
}

///The <b>ITfFnConfigure</b> interface is implemented by a text service to enable the Text Services control panel
///application to allow the text service to display a configuration dialog box. The Text Services control panel
///application obtains an instance of this interface by calling CoCreateInstance with the class identifier passed to
///ITfInputProcessorProfiles::Register and IID_ITfFnConfigure.
@GUID("88F567C6-1757-49F8-A1B2-89234C1EEFF9")
interface ITfFnConfigure : ITfFunction
{
    ///Called when the user opens the Text Services control panel application, selects the text service from the list
    ///and presses the Properties pushbutton.
    ///Params:
    ///    hwndParent = Handle of the parent window. The text service typically uses this as the parent or owner window when creating
    ///                 a dialog box.
    ///    langid = Contains a <b>LANGID</b> value that specifies the identifier of the language selected in the Text Services
    ///             control panel application.
    ///    rguidProfile = Contains a GUID value that specifies the language profile identifier that the text service is under. This is
    ///                   the value specified in ITfInputProcessorProfiles::AddLanguageProfile when the profile was added.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Show(HWND hwndParent, ushort langid, const(GUID)* rguidProfile);
}

///The <b>ITfFnConfigureRegisterWord</b> interface is implemented by a text service to enable the Active Input Method
///Editor (IME) to cause the text service to display a word registration dialog box. To obtain an instance of this
///interface the IME can call ITfFunctionProvider::GetFunction with IID_ITfFnConfigureRegisterWord.
@GUID("BB95808A-6D8F-4BCA-8400-5390B586AEDF")
interface ITfFnConfigureRegisterWord : ITfFunction
{
    ///Called to cause the text service to display a dialog box to register a word with the text service.
    ///Params:
    ///    hwndParent = Handle of the parent window. The text service typically uses this as the parent or owner window when creating
    ///                 the dialog box.
    ///    langid = Contains a <b>LANGID</b> that specifies the identifier of the language currently used by the Input Method
    ///             Editor (IME).
    ///    rguidProfile = Contains a GUID that specifies the language profile identifier that the text service is under. This is the
    ///                   value specified in ITfInputProcessorProfiles::AddLanguageProfile when the profile was added.
    ///    bstrRegistered = Contains a <b>BSTR</b> that contains the word to be registered with the text service. This is optional and
    ///                     can be NULL. If NULL, the text service should display a default register word dialog box.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The text service does not
    ///    implement this method. </td> </tr> </table>
    ///    
    HRESULT Show(HWND hwndParent, ushort langid, const(GUID)* rguidProfile, BSTR bstrRegistered);
}

///The <b>ITfFnConfigureRegisterEudc</b> interface is implemented by a text service to provide the UI to register the
///key sequence for the given EUDC.
@GUID("B5E26FF5-D7AD-4304-913F-21A2ED95A1B0")
interface ITfFnConfigureRegisterEudc : ITfFunction
{
    ///The ITfFnConfigureRegisterEudc::Show method shows the EUDC key sequence register UI.
    ///Params:
    ///    hwndParent = [in] Handle of the parent window. The text service typically uses this as the parent or owner window when
    ///                 creating a dialog box.
    ///    langid = [in] Contains a LANGID value that specifies the identifier of the language.
    ///    rguidProfile = [in] Contains a GUID value that specifies the language profile identifier that the text service is under.
    ///    bstrRegistered = [in, unique] Contains a BSTR that contains the EUDC to be registered with the text service. This is optional
    ///                     and can be <b>NULL</b>. If <b>NULL</b>, the text service should display a default register EUDC dialog box.
    HRESULT Show(HWND hwndParent, ushort langid, const(GUID)* rguidProfile, BSTR bstrRegistered);
}

///The <b>ITfFnShowHelp</b> interface is implemented by a text service to enable the language bar to place a help
///command for the text service in the language bar help menu.
@GUID("5AB1D30C-094D-4C29-8EA5-0BF59BE87BF3")
interface ITfFnShowHelp : ITfFunction
{
    ///Called when the user selects a text service help menu item.
    ///Params:
    ///    hwndParent = Handle of the parent window. This value can be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT Show(HWND hwndParent);
}

///The <b>ITfFnBalloon</b> interface is implemented by a text service and is used by an application or other text
///service to update the balloon item that the text service adds to the language bar. An application or text service
///obtains an instance of this interface by calling ITfThreadMgr::GetFunctionProvider with the class identifier of the
///text service and then calling ITfFunctionProvider::GetFunction with GUID_NULL and IID_ITfFnBalloon.
@GUID("3BAB89E4-5FBE-45F4-A5BC-DCA36AD225A8")
interface ITfFnBalloon : IUnknown
{
    ///Changes the style and text of a language bar balloon item.
    ///Params:
    ///    style = Contains one of the TfLBBalloonStyle values that specifies the new balloon style.
    ///    pch = Pointer to a <b>WCHAR</b> buffer that contains the new text for the balloon.
    ///    cch = Contains the number of characters of the new text in <i>pch</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> </table>
    ///    
    HRESULT UpdateBalloon(TfLBBalloonStyle style, const(wchar)* pch, uint cch);
}

///The <b>ITfFnGetSAPIObject</b> interface is implemented by the Speech API (SAPI) text service. This interface is used
///by the TSF manager or a client (application or other text service) to obtain various SAPI objects. A client obtains
///an instance of this interface by obtaining the ITfFunctionProvider for the SAPI text service and calling
///ITfFunctionProvider::GetFunction with IID_ITfFnGetSAPIObject.
@GUID("5C0AB7EA-167D-4F59-BFB5-4693755E90CA")
interface ITfFnGetSAPIObject : ITfFunction
{
    ///Obtains a specified SAPI object.
    ///Params:
    ///    sObj = Contains a TfSapiObject value that specifies the SAPI object to obtain.
    ///    ppunk = Pointer to an <b>IUnknown</b> interface pointer that receives the requested SAPI object. The caller must
    ///            release this interface when it is no longer required.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The requested object cannot
    ///    be obtained. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%">
    ///    The requested object is not implemented. </td> </tr> </table>
    ///    
    HRESULT Get(TfSapiObject sObj, IUnknown* ppunk);
}

///The <b>ITfFnPropertyUIStatus</b> interface is implemented by a text service and used by an application or text
///service to obtain and set the status of the text service property UI. An application or text service obtains an
///instance of this interface by obtaining the ITfFunctionProvider for the text service and calling
///ITfFunctionProvider::GetFunction with IID_ITfFnPropertyUIStatus.
@GUID("2338AC6E-2B9D-44C0-A75E-EE64F256B3BD")
interface ITfFnPropertyUIStatus : ITfFunction
{
    ///Obtains the status of a text service property UI.
    ///Params:
    ///    refguidProp = Specifies the property identifier. This can be a custom identifier or one of the predefined property
    ///                  identifiers.
    ///    pdw = Pointer to a <b>DWORD</b> that recevies the property UI status. This can be zero or the following value.
    ///          <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///          id="TF_PROPUI_STATUS_SAVETOFILE"></a><a id="tf_propui_status_savetofile"></a><dl>
    ///          <dt><b>TF_PROPUI_STATUS_SAVETOFILE</b></dt> </dl> </td> <td width="60%"> The property can be serialized. If
    ///          this value is not present, the property cannot be serialized. </td> </tr> </table>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pdw</i> is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The text
    ///    service does not support this method. </td> </tr> </table>
    ///    
    HRESULT GetStatus(const(GUID)* refguidProp, uint* pdw);
    ///Modifies the status of a text service property UI.
    ///Params:
    ///    refguidProp = Specifies the property identifier. This can be a custom identifier or one of the predefined property
    ///                  identifiers.
    ///    dw = Contains the new property UI status. See the <i>pdw</i> parameter of ITfFnPropertyUIStatus::GetStatus for
    ///         possible values.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The text service does not
    ///    support this method. </td> </tr> </table>
    ///    
    HRESULT SetStatus(const(GUID)* refguidProp, uint dw);
}

///The <b>ITfFnLMProcessor</b> interface is implemented by the language model text service and is used by an application
///or text service to enable alternate language model processing. The application or text service obtains this interface
///from a thread manager object by calling ITfThreadMgr::GetFunctionProvider with GUID_MASTERLM_FUNCTIONPROVIDER and
///then calling ITfFunctionProvider::GetFunction interface with IID_ITfFnLMProcessor. If
///<b>ITfThreadMgr::GetFunctionProvider</b> fails, then no language model processor is installed.
@GUID("7AFBF8E7-AC4B-4082-B058-890899D3A010")
interface ITfFnLMProcessor : ITfFunction
{
    ///Obtains the range of text that a reconversion applies to.
    ///Params:
    ///    pRange = Pointer to an ITfRange object that covers all or part of the text to be reconverted.
    ///    ppNewRange = Pointer to an ITfRange pointer that receives a range object that covers all of the text that can be
    ///                 reconverted. If none of the text covered by <i>pRange</i> can be reconverted, this parameters receives
    ///                 <b>NULL</b>. In this case, the method will return S_OK; the caller must verify that this parameter is not
    ///                 <b>NULL</b> before using the pointer. This parameter is optional and can be <b>NULL</b>. In this case, the
    ///                 range is not required.
    ///    pfAccepted = Pointer to a <b>BOOL</b> value that receives zero if none of the text covered by <i>pRange</i> can be
    ///                 reconverted or nonzero otherwise.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> A memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT QueryRange(ITfRange pRange, ITfRange* ppNewRange, int* pfAccepted);
    ///Determines if the language model text service supports a particular language.
    ///Params:
    ///    langid = Contains a <b>LANGID</b> that specifies the identifier of the language that the query applies to.
    ///    pfAccepted = Pointer to a <b>BOOL</b> value that receives nonzero if the language model text service supports the language
    ///                 identified by <i>langid</i> or zero otherwise.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pfAccepted</i> is
    ///    invalid. </td> </tr> </table>
    ///    
    HRESULT QueryLangID(ushort langid, int* pfAccepted);
    ///Obtains an ITfCandidateList object for a range from the language model text service.
    ///Params:
    ///    pRange = Pointer to an ITfRange object that covers the text to be reconverted. To obtain this range object, call
    ///             ITfFnReconversion::QueryRange.
    ///    ppCandList = Pointer to an <b>ITfCandidateList</b> pointer that receives the candidate list object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
    ///    parameters are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> A memory allocation failure occurred. </td> </tr> </table>
    ///    
    HRESULT GetReconversion(ITfRange pRange, ITfCandidateList* ppCandList);
    ///Invokes the reconversion process in the language model text service for a range.
    ///Params:
    ///    pRange = Pointer to an ITfRange object that covers the text to reconvert.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>pRange</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT Reconvert(ITfRange pRange);
    ///Called to determine if the language model text service handles a key event.
    ///Params:
    ///    fUp = Contains a <b>BOOL</b> that specifies if this is a key-down or a key-up event. Contains zero if this is a
    ///          key-down event or nonzero otherwise.
    ///    vKey = Contains the virtual-key code of the key. For more information about this parameter, see the <i>wParam</i>
    ///           parameter in WM_KEYDOWN.
    ///    lparamKeydata = Specifies the repeat count, scan code, extended-key flag, context code, previous key-state flag, and
    ///                    transition-state flag of the key. For more information about this parameter, see the <i>lParam</i> parameter
    ///                    in WM_KEYDOWN.
    ///    pfInterested = Pointer to a <b>BOOL</b> that receives nonzero if the language model text service will handle the key event
    ///                   or zero otherwise.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT QueryKey(BOOL fUp, WPARAM vKey, LPARAM lparamKeydata, int* pfInterested);
    ///Called to enable the language model text service to process a key event.
    ///Params:
    ///    fUp = Contains a <b>BOOL</b> that specifies if this is a key-down or a key-up event. Contains zero if this is a
    ///          key-down event or nonzero otherwise.
    ///    vKey = Contains the virtual-key code of the key. For more information about this parameter, see the <i>wParam</i>
    ///           parameter in WM_KEYDOWN.
    ///    lparamKeyData = Specifies the repeat count, scan code, extended-key flag, context code, previous key-state flag, and
    ///                    transition-state flag of the key. For more information about this parameter, see the <i>lParam</i> parameter
    ///                    in WM_KEYDOWN.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT InvokeKey(BOOL fUp, WPARAM vKey, LPARAM lparamKeyData);
    ///Invokes a function of the language model text service.
    ///Params:
    ///    pic = Pointer to an ITfContext interface that represents context to perform the function on.
    ///    refguidFunc = Contains a GUID that specifies the function to invoke. Possible values for this parameter are defined by the
    ///                  language model text service provider.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT InvokeFunc(ITfContext pic, const(GUID)* refguidFunc);
}

///The <b>ITfFnLMInternal</b> interface is not used.
@GUID("04B825B1-AC9A-4F7B-B5AD-C7168F1EE445")
interface ITfFnLMInternal : ITfFnLMProcessor
{
    ///Not used.
    ///Params:
    ///    pRange = Not used.
    HRESULT ProcessLattice(ITfRange pRange);
}

///The <b>IEnumTfLatticeElements</b> interface is implemented by the TSF manager to provide an enumeration of lattice
///elements.
@GUID("56988052-47DA-4A05-911A-E3D941F17145")
interface IEnumTfLatticeElements : IUnknown
{
    ///Creates a copy of the enumerator object.
    ///Params:
    ///    ppEnum = Pointer to an IEnumTfLatticeElements interface pointer that receives the new enumerator.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    failure occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td
    ///    width="60%"> The method is not implemented. </td> </tr> </table>
    ///    
    HRESULT Clone(IEnumTfLatticeElements* ppEnum);
    ///Obtains the specified number of elements in the enumeration sequence from the current position.
    ///Params:
    ///    ulCount = Specifies the number of elements to obtain.
    ///    rgsElements = Pointer to an array of TF_LMLATTELEMENT structures that receives the requested data. This array must be at
    ///                  least <i>ulCount</i> elements in size. The caller must free the <b>bstrText</b> member of every structure
    ///                  obtained using SysFreeString when it is no longer required.
    ///    pcFetched = Pointer to a ULONG value that receives the number of elements actually obtained. This value can be less than
    ///                the number of items requested. This parameter can be <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method reached the end of
    ///    the enumeration before the specified number of elements could be obtained. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>rgsElements</i> is invalid. </td> </tr>
    ///    </table>
    ///    
    HRESULT Next(uint ulCount, char* rgsElements, uint* pcFetched);
    ///Resets the enumerator object by moving the current position to the beginning of the enumeration sequence.
    HRESULT Reset();
    ///Moves the current position forward in the enumeration sequence by the specified number of elements.
    ///Params:
    ///    ulCount = Contains the number of elements to skip.
    HRESULT Skip(uint ulCount);
}

///The <b>ITfLMLattice</b> interface is implemented by the speech text service to provide information about lattice
///element properties and is used by a client (application or other text service). A client obtains this interface from
///the GUID_PROP_LMLATTICE property by calling ITfReadOnlyProperty::GetValue. For more information, see Predefined
///Properties.
@GUID("D4236675-A5BF-4570-9D42-5D6D7B02D59B")
interface ITfLMLattice : IUnknown
{
    ///Determines if a specific lattice element type is supported by the lattice property.
    ///Params:
    ///    rguidType = Specifies the lattice type identifier. This can be one of the Lattice Type values.
    ///    pfSupported = Pointer to a <b>BOOL</b> that receives a value that indicates if the lattice type is supported. If the
    ///                  lattice type is supported, this parameter receives a nonzero value and the method returns S_OK. If the
    ///                  lattice type is unsupported, this parameter receives zero and the method returns E_INVALIDARG.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The specified lattice type is supported.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Either
    ///    <i>pfSupported</i> is invalid or the specified lattice type is not supported. </td> </tr> </table>
    ///    
    HRESULT QueryType(const(GUID)* rguidType, int* pfSupported);
    ///Obtains an enumerator that contains all lattice elements contained in the lattice property that start at or after
    ///a specific offset from the start of the frame.
    ///Params:
    ///    dwFrameStart = Specifies the offset, in 100-nanosecond units, relative to the start of the phrase, of the first element to
    ///                   obtain.
    ///    rguidType = Specifies the lattice type identifier. This can be one of the Lattice Type values.
    ///    ppEnum = Pointer to an IEnumTfLatticeElements interface pointer that receives the enumerator object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>rguidType</i> is unsupported by the lattice property. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation failure occurred. </td> </tr>
    ///    </table>
    ///    
    HRESULT EnumLatticeElements(uint dwFrameStart, const(GUID)* rguidType, IEnumTfLatticeElements* ppEnum);
}

///The <b>ITfFnAdviseText</b> interface is implemented by a text service and used by the TSF manager to supply
///notifications when the text or lattice element in a context changes. The manager obtains this interface from the text
///service by calling the text service ITfFunctionProvider::GetFunction interface with IID_ITfFnAdviseText.
@GUID("3527268B-7D53-4DD9-92B7-7296AE461249")
interface ITfFnAdviseText : ITfFunction
{
    ///Called when the text within a context changes.
    ///Params:
    ///    pRange = Pointer to an ITfRange object that represents the range of text that has changed.
    ///    pchText = Pointer to a <b>WCHAR</b> buffer that contains the new text for the range.
    ///    cch = Specifies the number of characters contained in <i>pchText</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> </table>
    ///    
    HRESULT OnTextUpdate(ITfRange pRange, const(wchar)* pchText, int cch);
    ///Called when a lattice element within a context changes.
    ///Params:
    ///    pRange = Pointer to an ITfRange object that represents the range of text that changed.
    ///    pLattice = Pointer to an ITfLMLattice object that represents the new lattice element.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters
    ///    are invalid. </td> </tr> </table>
    ///    
    HRESULT OnLatticeUpdate(ITfRange pRange, ITfLMLattice pLattice);
}

///Enables an integrated search experience in an Input Method Editor (IME).
@GUID("87A2AD8F-F27B-4920-8501-67602280175D")
interface ITfFnSearchCandidateProvider : ITfFunction
{
    ///Gets a list of conversion candidates for a given string without generating any IME-related messages or events.
    ///Params:
    ///    bstrQuery = A string that specifies the reading string that the text service attempts to convert.
    ///    bstrApplicationId = App-specified string that enables a text service to optionally provide different candidates to different apps
    ///                        or contexts based on input history. You can pass an empty <b>BSTR</b>, L””, for a generic context.
    ///    pplist = An ITfCandidateList that receives the requested candidate data.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> No candidates could be
    ///    returned for the input string, <i>pplist</i> may be <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetSearchCandidates(BSTR bstrQuery, BSTR bstrApplicationId, ITfCandidateList* pplist);
    ///Provides a text Service or IME with history data when a candidate is chosen by the user.
    ///Params:
    ///    bstrQuery = The reading string for the text service or IME to convert.
    ///    bstrApplicationID = App-specified string that enables a text service or IME to optionally provide different candidates to
    ///                        different apps or contexts based on input history. You can pass an empty <b>BSTR</b>, L””, for a generic
    ///                        context.
    ///    bstrResult = A string that represents the candidate string chosen by the user. It should be one of the candidate string
    ///                 values returned by the GetSearchCandidates method.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetResult(BSTR bstrQuery, BSTR bstrApplicationID, BSTR bstrResult);
}

///Enables text services and Input Method Editors (IMEs) to adjust UI-less mode behavior.
@GUID("C7A6F54F-B180-416F-B2BF-7BF2E4683D7B")
interface ITfIntegratableCandidateListUIElement : IUnknown
{
    ///Sets the integration style.
    ///Params:
    ///    guidIntegrationStyle = The desired type of keyboard integration experience.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The text service supports the integration
    ///    style. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The text
    ///    service does not support the integration style. </td> </tr> </table>
    ///    
    HRESULT SetIntegrationStyle(GUID guidIntegrationStyle);
    ///Retrieves the selection style.
    ///Params:
    ///    ptfSelectionStyle = A value that specifies the selection style.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetSelectionStyle(TfIntegratableCandidateListSelectionStyle* ptfSelectionStyle);
    ///Processes a key press.
    ///Params:
    ///    wParam = Specifies the virtual-key code of the key. For more information about this parameter, see the <i>wParam</i>
    ///             parameter in WM_KEYDOWN.
    ///    lParam = Specifies the repeat count, scan code, extended-key flag, context code, previous key-state flag, and
    ///             transition-state flag of the key. For more information about this parameter, see the <i>lParam</i> parameter
    ///             in WM_KEYDOWN.
    ///    pfEaten = <b>TRUE</b> if the key event was handled; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT OnKeyDown(WPARAM wParam, LPARAM lParam, int* pfEaten);
    ///Specifies whether candidate numbers should be shown.
    ///Params:
    ///    pfShow = <b>TRUE</b> if candidate numbers should be shown; otherwise <b>FALSE</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT ShowCandidateNumbers(int* pfShow);
    ///Finalizes the current composition with the value currently shown to the user.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT FinalizeExactCompositionString();
}

///The <b>ITfFnGetPreferredTouchKeyboardLayout</b> interface is implemented by a text service to specify the use of a
///particular keyboard layout supported by the inbox Windows 8 touch keyboard. When an IME is active the touch keyboard
///will use ITfFunctionProvider::GetFunction with <b>IID_ITfFnGetPreferredTouchKeyboardLayout</b> to query the IME for
///this function. If the function is not supported by the IME, then the touch keyboard will show the default layout for
///the language.
@GUID("5F309A41-590A-4ACC-A97F-D8EFFF13FDFC")
interface ITfFnGetPreferredTouchKeyboardLayout : ITfFunction
{
    ///Obtains the touch keyboard layout identifier of the layout that the IME directs the touch keyboard to show while
    ///the IME is active.
    ///Params:
    ///    pTKBLayoutType = Pointer to a TKBLayoutType enumeration that receives the layout type.
    ///    pwPreferredLayoutId = Pointer to a <b>WORD</b> value that receives the layout identifier.
    ///Returns:
    ///    The touch keyboard always expects S_OK.
    ///    
    HRESULT GetLayout(TKBLayoutType* pTKBLayoutType, ushort* pwPreferredLayoutId);
}

///The <b>ITfFnGetLinguisticAlternates</b> interface is implemented by a text service and/or by the TSF manager to
///provide linguistic alternates for the text within a given range passed as a parameter. Apps can use this interface to
///obtain IME alternates for a text range; therefore the interface <b>ITfFnGetLinguisticAlternates</b>, along with
///ITfFnSearchCandidateProvider, provides a TSF-based replacement for the ImmGetConversionList function. Typically IMEs
///implement either <b>ITfFnGetLinguisticAlternates</b> or <b>ITfFnSearchCandidateProvider</b> (or neither). An app
///obtains a pointer to this interface by calling TSF manager ITfFunctionProvider::GetFunction method with
///<b>IID_ITfFnGetLinguisticAlternates</b>. <div class="alert"><b>Note</b> This interface may not be supported for all
///IMEs. There may be differences in support between IMEs on the Desktop and IMEs in the new Windows UI on Windows 8.1.
///Some IMEs instead implement the related interface ITfFnSearchCandidateProvider that can be used as a substitute for
///this API. Suggested app usage is to check for this interface first, and if it's not available then check if
///<b>ITfFnSearchCandidateProvider</b> is supported instead. IMEs that wish to maintain compatibility with Windows 8
///should implement <b>ITfFnSearchCandidateProvider</b> instead.</div> <div> </div>
@GUID("EA163CE2-7A65-4506-82A3-C528215DA64E")
interface ITfFnGetLinguisticAlternates : ITfFunction
{
    ///Returns a list of alternate strings for a given text range.
    ///Params:
    ///    pRange = Pointer to an ITfRange object that covers the text to return alternates for.
    ///    ppCandidateList = Pointer to an ITfCandidateList pointer that receives the list object containing alternate strings.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred
    ///    or no alternates could be generated for the range. *<i>ppCandidateList</i> is returned as null. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation
    ///    failure occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more parameters are invalid. </td> </tr> </table>
    ///    
    HRESULT GetAlternates(ITfRange pRange, ITfCandidateList* ppCandidateList);
}

///The <b>IUIManagerEventSink</b> interface is implemented by an app supporting IME UI integration to receive
///notifications of IME UI appearance. This enables the app to rearrange its UI layout to avoid having the app's UI
///elements overlapped by the IME UI. Call the TSF manager ITfSource::AdviseSink with <b>IID_IUIManagerEventSink</b> to
///install this sink. <div class="alert"><b>Note</b> This interface may not be supported for all IMEs. There may be
///differences in support between IME on the Desktop and IME in the new Windows UI on Windows 8.1.</div><div> </div>
@GUID("CD91D690-A7E8-4265-9B38-8BB3BBABA7DE")
interface IUIManagerEventSink : IUnknown
{
    ///Called by the TSF before opening an IME UI.
    ///Params:
    ///    prcBounds = Pointer to a <b>RECT</b> structure defining the affected area (in screen coordinates).
    ///Returns:
    ///    Ignored.
    ///    
    HRESULT OnWindowOpening(RECT* prcBounds);
    ///Called by the TSF after opening an IME UI.
    ///Params:
    ///    prcBounds = Pointer to a <b>RECT</b> structure defining the affected area (in screen coordinates).
    ///Returns:
    ///    Ignored.
    ///    
    HRESULT OnWindowOpened(RECT* prcBounds);
    ///Called by the TSF before resizing and/or relocating the opened IME UI.
    ///Params:
    ///    prcUpdatedBounds = Pointer to a <b>RECT</b> structure defining the affected area (in screen coordinates).
    ///Returns:
    ///    Ignored.
    ///    
    HRESULT OnWindowUpdating(RECT* prcUpdatedBounds);
    ///Called by the TSF after resizing and/or relocating the opened IME UI.
    ///Params:
    ///    prcUpdatedBounds = Pointer to a <b>RECT</b> structure defining the affected area (in screen coordinates).
    ///Returns:
    ///    Ignored.
    ///    
    HRESULT OnWindowUpdated(RECT* prcUpdatedBounds);
    ///Called by the TSF before closing the IME UI.
    ///Returns:
    ///    Ignored.
    ///    
    HRESULT OnWindowClosing();
    ///Called by the TSF after closing the IME UI.
    ///Returns:
    ///    Ignored.
    ///    
    HRESULT OnWindowClosed();
}

///The <b>ITfInputScope</b> interface is used by the text input processors to get the InputScope value that represents a
///document context associated with a window. The input scope provides rules to help speech and handwriting recognition.
///For instance, if a text box on a form is used to enter an address, the input scope for that text box can be set to
///recognize and accept only those characters that are valid for an address. The interface ID is IID_ITfInputScope. The
///document context is used by the speech and handwriting recognition engine and is set by a text input processor by
///calling the SetInputScope method. A TSF-aware application does not call <b>SetInputScope</b> directly, but rather
///implements either ITextStoreACP or ITfContextOwner to get a pointer to <b>ITfInputScope</b>. To get the pointer to
///the <b>ITfInputScope</b> interface, the text input processor or TSF-aware application calls
///ITfContext::GetAppProperty, passing in <b>GUID_PROP_INPUTSCOPE</b> and a pointer to the ITFReadOnlyProperty
///interface, as in the following example. ```cpp extern const GUID GUID_PROP_INPUTSCOPE; // // The TIP can call this to
///get the input scope of the document mgr. // HRESULT GetInputScope(ITfContext *pic, ITfRange *pRange, TfEditCookie ec,
///ITfInutScope **ppiscope){ ITFReadOnlyProperty *prop; HRESULT hr; If (SUCCEEDED(hr =
///pic->GetAppProperty(GUID_PROP_INPUTSCOPE, &prop)) { VARIANT var; If (SUCCEEDED(hr = prop->GetValue(ec, pRange,
///&var))) { hr = var.punkVal->QueryInterface(IID_ITfInputScope, (void **)ppiscope); } prop->Release(); } return hr }
///```
@GUID("FDE1EAEE-6924-4CDF-91E7-DA38CFF5559D")
interface ITfInputScope : IUnknown
{
    ///Gets the input scopes that are associated with this context.
    ///Params:
    ///    pprgInputScopes = Pointer to an array of pointers to the input scopes. The calling function must call <b>CoTaskMemFree()</b> to
    ///                      free the buffer.
    ///    pcCount = Pointer to the number of input scopes returned.
    HRESULT GetInputScopes(char* pprgInputScopes, uint* pcCount);
    ///Gets the phrase list set to this context.
    ///Params:
    ///    ppbstrPhrases = Pointer to an array of pointers to strings containing phrases. The calling function must call
    ///                    <b>SystFreeString()</b> to free the memory allocated to the strings and <b>CoTaskMemFree</b> to free the
    ///                    buffer.
    ///    pcCount = Pointer to the number of phrases returned.
    HRESULT GetPhrase(char* ppbstrPhrases, uint* pcCount);
    ///Gets the regular expression string to be rssecognized.
    ///Params:
    ///    pbstrRegExp = Pointer to a string containing the regular expression. The calling function must call <b>SystFreeString()</b>
    ///                  to free the memory allocated to the strings.
    HRESULT GetRegularExpression(BSTR* pbstrRegExp);
    ///Gets the Speech Recognition Grammar Specification (SRGS) string to be recognized.
    ///Params:
    ///    pbstrSRGS = The xml string. The calling function must call <b>SysFreeString()</b> to free the buffer.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetSRGS(BSTR* pbstrSRGS);
    ///Gets the custom XML string to be recognized.
    ///Params:
    ///    pbstrXML = Pointer to a string containing the xml string. The calling function must call <b>SysFreeString()</b> to free
    ///               the buffer.
    HRESULT GetXML(BSTR* pbstrXML);
}

///The <b>ITfInputScope2</b> interface is used by the text input processors to get the IEnumString interface pointer and
///this IEnumString interface enumerates the word list that the application specified for this context.
@GUID("5731EAA0-6BC2-4681-A532-92FBB74D7C41")
interface ITfInputScope2 : ITfInputScope
{
    ///Return a pointer to obtain the IEnumString interface pointer.
    ///Params:
    ///    ppEnumString = A pointer to obtain the IEnumString interface pointer.
    HRESULT EnumWordList(IEnumString* ppEnumString);
}

///The <b>ITfSpeechUIServer</b> interface manages the speech-related user interface on the TSF language bar.
@GUID("90E9A944-9244-489F-A78F-DE67AFC013A7")
interface ITfSpeechUIServer : IUnknown
{
    ///Initializes the speech-related user interface elements on the TSF language bar.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT Initialize();
    ///Sets the visibility state of the speech-related user interface elements on the TSF language bar.
    ///Params:
    ///    fShow = Specifies whether to show (TRUE) or not show (FALSE) the speech-related user interface elements.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT ShowUI(BOOL fShow);
    ///Sets the style and text of the speech balloon on the TSF language bar.
    ///Params:
    ///    style = Contains a TfLBBalloonStyle element that specifies the balloon style.
    ///    pch = Pointer to a zero-terminated Unicode string that contains the text to show in the balloon.
    ///    cch = Specifies the number of characters in the string of the <i>pch</i> parameter.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td> </tr>
    ///    </table>
    ///    
    HRESULT UpdateBalloon(TfLBBalloonStyle style, const(wchar)* pch, uint cch);
}


// GUIDs


const GUID IID_IAnchor                                  = GUIDOF!IAnchor;
const GUID IID_IEnumITfCompositionView                  = GUIDOF!IEnumITfCompositionView;
const GUID IID_IEnumTfCandidates                        = GUIDOF!IEnumTfCandidates;
const GUID IID_IEnumTfContextViews                      = GUIDOF!IEnumTfContextViews;
const GUID IID_IEnumTfContexts                          = GUIDOF!IEnumTfContexts;
const GUID IID_IEnumTfDisplayAttributeInfo              = GUIDOF!IEnumTfDisplayAttributeInfo;
const GUID IID_IEnumTfDocumentMgrs                      = GUIDOF!IEnumTfDocumentMgrs;
const GUID IID_IEnumTfFunctionProviders                 = GUIDOF!IEnumTfFunctionProviders;
const GUID IID_IEnumTfInputProcessorProfiles            = GUIDOF!IEnumTfInputProcessorProfiles;
const GUID IID_IEnumTfLangBarItems                      = GUIDOF!IEnumTfLangBarItems;
const GUID IID_IEnumTfLanguageProfiles                  = GUIDOF!IEnumTfLanguageProfiles;
const GUID IID_IEnumTfLatticeElements                   = GUIDOF!IEnumTfLatticeElements;
const GUID IID_IEnumTfProperties                        = GUIDOF!IEnumTfProperties;
const GUID IID_IEnumTfPropertyValue                     = GUIDOF!IEnumTfPropertyValue;
const GUID IID_IEnumTfRanges                            = GUIDOF!IEnumTfRanges;
const GUID IID_IEnumTfUIElements                        = GUIDOF!IEnumTfUIElements;
const GUID IID_ITextStoreACP                            = GUIDOF!ITextStoreACP;
const GUID IID_ITextStoreACP2                           = GUIDOF!ITextStoreACP2;
const GUID IID_ITextStoreACPServices                    = GUIDOF!ITextStoreACPServices;
const GUID IID_ITextStoreACPSink                        = GUIDOF!ITextStoreACPSink;
const GUID IID_ITextStoreAnchor                         = GUIDOF!ITextStoreAnchor;
const GUID IID_ITextStoreAnchorSink                     = GUIDOF!ITextStoreAnchorSink;
const GUID IID_ITfActiveLanguageProfileNotifySink       = GUIDOF!ITfActiveLanguageProfileNotifySink;
const GUID IID_ITfCandidateList                         = GUIDOF!ITfCandidateList;
const GUID IID_ITfCandidateListUIElement                = GUIDOF!ITfCandidateListUIElement;
const GUID IID_ITfCandidateListUIElementBehavior        = GUIDOF!ITfCandidateListUIElementBehavior;
const GUID IID_ITfCandidateString                       = GUIDOF!ITfCandidateString;
const GUID IID_ITfCategoryMgr                           = GUIDOF!ITfCategoryMgr;
const GUID IID_ITfCleanupContextDurationSink            = GUIDOF!ITfCleanupContextDurationSink;
const GUID IID_ITfCleanupContextSink                    = GUIDOF!ITfCleanupContextSink;
const GUID IID_ITfClientId                              = GUIDOF!ITfClientId;
const GUID IID_ITfCompartment                           = GUIDOF!ITfCompartment;
const GUID IID_ITfCompartmentEventSink                  = GUIDOF!ITfCompartmentEventSink;
const GUID IID_ITfCompartmentMgr                        = GUIDOF!ITfCompartmentMgr;
const GUID IID_ITfComposition                           = GUIDOF!ITfComposition;
const GUID IID_ITfCompositionSink                       = GUIDOF!ITfCompositionSink;
const GUID IID_ITfCompositionView                       = GUIDOF!ITfCompositionView;
const GUID IID_ITfConfigureSystemKeystrokeFeed          = GUIDOF!ITfConfigureSystemKeystrokeFeed;
const GUID IID_ITfContext                               = GUIDOF!ITfContext;
const GUID IID_ITfContextComposition                    = GUIDOF!ITfContextComposition;
const GUID IID_ITfContextKeyEventSink                   = GUIDOF!ITfContextKeyEventSink;
const GUID IID_ITfContextOwner                          = GUIDOF!ITfContextOwner;
const GUID IID_ITfContextOwnerCompositionServices       = GUIDOF!ITfContextOwnerCompositionServices;
const GUID IID_ITfContextOwnerCompositionSink           = GUIDOF!ITfContextOwnerCompositionSink;
const GUID IID_ITfContextOwnerServices                  = GUIDOF!ITfContextOwnerServices;
const GUID IID_ITfContextView                           = GUIDOF!ITfContextView;
const GUID IID_ITfCreatePropertyStore                   = GUIDOF!ITfCreatePropertyStore;
const GUID IID_ITfDisplayAttributeInfo                  = GUIDOF!ITfDisplayAttributeInfo;
const GUID IID_ITfDisplayAttributeMgr                   = GUIDOF!ITfDisplayAttributeMgr;
const GUID IID_ITfDisplayAttributeNotifySink            = GUIDOF!ITfDisplayAttributeNotifySink;
const GUID IID_ITfDisplayAttributeProvider              = GUIDOF!ITfDisplayAttributeProvider;
const GUID IID_ITfDocumentMgr                           = GUIDOF!ITfDocumentMgr;
const GUID IID_ITfEditRecord                            = GUIDOF!ITfEditRecord;
const GUID IID_ITfEditSession                           = GUIDOF!ITfEditSession;
const GUID IID_ITfEditTransactionSink                   = GUIDOF!ITfEditTransactionSink;
const GUID IID_ITfFnAdviseText                          = GUIDOF!ITfFnAdviseText;
const GUID IID_ITfFnBalloon                             = GUIDOF!ITfFnBalloon;
const GUID IID_ITfFnConfigure                           = GUIDOF!ITfFnConfigure;
const GUID IID_ITfFnConfigureRegisterEudc               = GUIDOF!ITfFnConfigureRegisterEudc;
const GUID IID_ITfFnConfigureRegisterWord               = GUIDOF!ITfFnConfigureRegisterWord;
const GUID IID_ITfFnGetLinguisticAlternates             = GUIDOF!ITfFnGetLinguisticAlternates;
const GUID IID_ITfFnGetPreferredTouchKeyboardLayout     = GUIDOF!ITfFnGetPreferredTouchKeyboardLayout;
const GUID IID_ITfFnGetSAPIObject                       = GUIDOF!ITfFnGetSAPIObject;
const GUID IID_ITfFnLMInternal                          = GUIDOF!ITfFnLMInternal;
const GUID IID_ITfFnLMProcessor                         = GUIDOF!ITfFnLMProcessor;
const GUID IID_ITfFnLangProfileUtil                     = GUIDOF!ITfFnLangProfileUtil;
const GUID IID_ITfFnPlayBack                            = GUIDOF!ITfFnPlayBack;
const GUID IID_ITfFnPropertyUIStatus                    = GUIDOF!ITfFnPropertyUIStatus;
const GUID IID_ITfFnReconversion                        = GUIDOF!ITfFnReconversion;
const GUID IID_ITfFnSearchCandidateProvider             = GUIDOF!ITfFnSearchCandidateProvider;
const GUID IID_ITfFnShowHelp                            = GUIDOF!ITfFnShowHelp;
const GUID IID_ITfFunction                              = GUIDOF!ITfFunction;
const GUID IID_ITfFunctionProvider                      = GUIDOF!ITfFunctionProvider;
const GUID IID_ITfInputProcessorProfileActivationSink   = GUIDOF!ITfInputProcessorProfileActivationSink;
const GUID IID_ITfInputProcessorProfileMgr              = GUIDOF!ITfInputProcessorProfileMgr;
const GUID IID_ITfInputProcessorProfileSubstituteLayout = GUIDOF!ITfInputProcessorProfileSubstituteLayout;
const GUID IID_ITfInputProcessorProfiles                = GUIDOF!ITfInputProcessorProfiles;
const GUID IID_ITfInputProcessorProfilesEx              = GUIDOF!ITfInputProcessorProfilesEx;
const GUID IID_ITfInputScope                            = GUIDOF!ITfInputScope;
const GUID IID_ITfInputScope2                           = GUIDOF!ITfInputScope2;
const GUID IID_ITfInsertAtSelection                     = GUIDOF!ITfInsertAtSelection;
const GUID IID_ITfIntegratableCandidateListUIElement    = GUIDOF!ITfIntegratableCandidateListUIElement;
const GUID IID_ITfKeyEventSink                          = GUIDOF!ITfKeyEventSink;
const GUID IID_ITfKeyTraceEventSink                     = GUIDOF!ITfKeyTraceEventSink;
const GUID IID_ITfKeystrokeMgr                          = GUIDOF!ITfKeystrokeMgr;
const GUID IID_ITfLMLattice                             = GUIDOF!ITfLMLattice;
const GUID IID_ITfLangBarEventSink                      = GUIDOF!ITfLangBarEventSink;
const GUID IID_ITfLangBarItem                           = GUIDOF!ITfLangBarItem;
const GUID IID_ITfLangBarItemBalloon                    = GUIDOF!ITfLangBarItemBalloon;
const GUID IID_ITfLangBarItemBitmap                     = GUIDOF!ITfLangBarItemBitmap;
const GUID IID_ITfLangBarItemBitmapButton               = GUIDOF!ITfLangBarItemBitmapButton;
const GUID IID_ITfLangBarItemButton                     = GUIDOF!ITfLangBarItemButton;
const GUID IID_ITfLangBarItemMgr                        = GUIDOF!ITfLangBarItemMgr;
const GUID IID_ITfLangBarItemSink                       = GUIDOF!ITfLangBarItemSink;
const GUID IID_ITfLangBarMgr                            = GUIDOF!ITfLangBarMgr;
const GUID IID_ITfLanguageProfileNotifySink             = GUIDOF!ITfLanguageProfileNotifySink;
const GUID IID_ITfMSAAControl                           = GUIDOF!ITfMSAAControl;
const GUID IID_ITfMenu                                  = GUIDOF!ITfMenu;
const GUID IID_ITfMessagePump                           = GUIDOF!ITfMessagePump;
const GUID IID_ITfMouseSink                             = GUIDOF!ITfMouseSink;
const GUID IID_ITfMouseTracker                          = GUIDOF!ITfMouseTracker;
const GUID IID_ITfMouseTrackerACP                       = GUIDOF!ITfMouseTrackerACP;
const GUID IID_ITfPersistentPropertyLoaderACP           = GUIDOF!ITfPersistentPropertyLoaderACP;
const GUID IID_ITfPreservedKeyNotifySink                = GUIDOF!ITfPreservedKeyNotifySink;
const GUID IID_ITfProperty                              = GUIDOF!ITfProperty;
const GUID IID_ITfPropertyStore                         = GUIDOF!ITfPropertyStore;
const GUID IID_ITfQueryEmbedded                         = GUIDOF!ITfQueryEmbedded;
const GUID IID_ITfRange                                 = GUIDOF!ITfRange;
const GUID IID_ITfRangeACP                              = GUIDOF!ITfRangeACP;
const GUID IID_ITfRangeBackup                           = GUIDOF!ITfRangeBackup;
const GUID IID_ITfReadOnlyProperty                      = GUIDOF!ITfReadOnlyProperty;
const GUID IID_ITfReadingInformationUIElement           = GUIDOF!ITfReadingInformationUIElement;
const GUID IID_ITfReverseConversion                     = GUIDOF!ITfReverseConversion;
const GUID IID_ITfReverseConversionList                 = GUIDOF!ITfReverseConversionList;
const GUID IID_ITfReverseConversionMgr                  = GUIDOF!ITfReverseConversionMgr;
const GUID IID_ITfSource                                = GUIDOF!ITfSource;
const GUID IID_ITfSourceSingle                          = GUIDOF!ITfSourceSingle;
const GUID IID_ITfSpeechUIServer                        = GUIDOF!ITfSpeechUIServer;
const GUID IID_ITfStatusSink                            = GUIDOF!ITfStatusSink;
const GUID IID_ITfSystemDeviceTypeLangBarItem           = GUIDOF!ITfSystemDeviceTypeLangBarItem;
const GUID IID_ITfSystemLangBarItem                     = GUIDOF!ITfSystemLangBarItem;
const GUID IID_ITfSystemLangBarItemSink                 = GUIDOF!ITfSystemLangBarItemSink;
const GUID IID_ITfSystemLangBarItemText                 = GUIDOF!ITfSystemLangBarItemText;
const GUID IID_ITfTextEditSink                          = GUIDOF!ITfTextEditSink;
const GUID IID_ITfTextInputProcessor                    = GUIDOF!ITfTextInputProcessor;
const GUID IID_ITfTextInputProcessorEx                  = GUIDOF!ITfTextInputProcessorEx;
const GUID IID_ITfTextLayoutSink                        = GUIDOF!ITfTextLayoutSink;
const GUID IID_ITfThreadFocusSink                       = GUIDOF!ITfThreadFocusSink;
const GUID IID_ITfThreadMgr                             = GUIDOF!ITfThreadMgr;
const GUID IID_ITfThreadMgr2                            = GUIDOF!ITfThreadMgr2;
const GUID IID_ITfThreadMgrEventSink                    = GUIDOF!ITfThreadMgrEventSink;
const GUID IID_ITfThreadMgrEx                           = GUIDOF!ITfThreadMgrEx;
const GUID IID_ITfToolTipUIElement                      = GUIDOF!ITfToolTipUIElement;
const GUID IID_ITfTransitoryExtensionSink               = GUIDOF!ITfTransitoryExtensionSink;
const GUID IID_ITfTransitoryExtensionUIElement          = GUIDOF!ITfTransitoryExtensionUIElement;
const GUID IID_ITfUIElement                             = GUIDOF!ITfUIElement;
const GUID IID_ITfUIElementMgr                          = GUIDOF!ITfUIElementMgr;
const GUID IID_ITfUIElementSink                         = GUIDOF!ITfUIElementSink;
const GUID IID_IUIManagerEventSink                      = GUIDOF!IUIManagerEventSink;
