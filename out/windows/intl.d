// Written in the D programming language.

module windows.intl;

public import windows.core;
public import windows.automation : BSTR, SAFEARRAY;
public import windows.com : HRESULT, IClassFactory, IEnumString, IUnknown;
public import windows.displaydevices : POINT, RECT, SIZE;
public import windows.gdi : ABC, HBITMAP, HDC, HICON;
public import windows.shell : LOGFONTA, LOGFONTW;
public import windows.systemservices : BOOL, LRESULT, PSTR, PWSTR;
public import windows.textservices : HKL;
public import windows.windowsandmessaging : HWND, LPARAM, WPARAM;
public import windows.windowsprogramming : SYSTEMTIME;

extern(Windows) @nogc nothrow:


// Enums


///Specifies NLS function capabilities.
alias SYSNLS_FUNCTION = int;
enum : int
{
    ///Value indicating comparison of two strings in the manner of the CompareString function or LCMapString with the
    ///LCMAP_SORTKEY flag specified.
    COMPARE_STRING = 0x00000001,
}

///Defines the type of geographical location information requested in the GetGeoInfo or GetGeoInfoEx function.
alias SYSGEOTYPE = int;
enum : int
{
    ///The geographical location identifier (GEOID) of a nation. This value is stored in a long integer. <b>Starting
    ///with Windows 10, version 1709:</b> This value is not supported for the GetGeoInfoEx function, and should not be
    ///used.
    GEO_NATION            = 0x00000001,
    ///The latitude of the location. This value is stored in a floating-point number.
    GEO_LATITUDE          = 0x00000002,
    ///The longitude of the location. This value is stored in a floating-point number.
    GEO_LONGITUDE         = 0x00000003,
    ///The ISO 2-letter country/region code. This value is stored in a string.
    GEO_ISO2              = 0x00000004,
    ///The ISO 3-letter country/region code. This value is stored in a string.
    GEO_ISO3              = 0x00000005,
    ///The name for a string, compliant with RFC 4646 (starting with Windows Vista), that is derived from the GetGeoInfo
    ///parameters <i>language</i> and <i>GeoId</i>. <b>Starting with Windows 10, version 1709:</b> This value is not
    ///supported for the GetGeoInfoEx function, and should not be used.
    GEO_RFC1766           = 0x00000006,
    ///A locale identifier derived using GetGeoInfo. <b>Starting with Windows 10, version 1709:</b> This value is not
    ///supported for the GetGeoInfoEx function, and should not be used.
    GEO_LCID              = 0x00000007,
    ///The friendly name of the nation, for example, Germany. This value is stored in a string.
    GEO_FRIENDLYNAME      = 0x00000008,
    ///The official name of the nation, for example, Federal Republic of Germany. This value is stored in a string.
    GEO_OFFICIALNAME      = 0x00000009,
    ///Not implemented.
    GEO_TIMEZONES         = 0x0000000a,
    ///Not implemented.
    GEO_OFFICIALLANGUAGES = 0x0000000b,
    ///<b>Starting with Windows 8:</b> The ISO 3-digit country/region code. This value is stored in a string.
    GEO_ISO_UN_NUMBER     = 0x0000000c,
    ///<b>Starting with Windows 8:</b> The geographical location identifier of the parent region of a country/region.
    ///This value is stored in a string.
    GEO_PARENT            = 0x0000000d,
    ///<b>Starting with Windows 10, version 1709:</b> The dialing code to use with telephone numbers in the geographic
    ///location. For example, 1 for the United States.
    GEO_DIALINGCODE       = 0x0000000e,
    ///<b>Starting with Windows 10, version 1709:</b> The three-letter code for the currency that the geographic
    ///location uses. For example, USD for United States dollars.
    GEO_CURRENCYCODE      = 0x0000000f,
    ///<b>Starting with Windows 10, version 1709:</b> The symbol for the currency that the geographic location uses. For
    ///example, the dollar sign ($).
    GEO_CURRENCYSYMBOL    = 0x00000010,
    ///<b>Starting with Windows 10, version 1709:</b> The two-letter International Organization for Standardization
    ///(ISO) 3166-1 code or numeric United Nations (UN) Series M, Number 49 (M.49) code for the geographic region. For
    ///information about two-letter ISO 3166-1 codes, see Country Codes - ISO 3166. For information about numeric UN
    ///M.49 codes, see Standard country or area codes for statistical use (M49).
    GEO_NAME              = 0x00000011,
    ///<b>Starting with Windows 10, version 1709:</b> The Windows geographical location identifiers (GEOID) for the
    ///region. This value is provided for backward compatibility. Do not use this value in new applications, but use
    ///<b>GEO_NAME</b> instead.
    GEO_ID                = 0x00000012,
}

///Specifies the geographical location class.
alias SYSGEOCLASS = int;
enum : int
{
    ///Class for nation geographical location identifiers.
    GEOCLASS_NATION = 0x00000010,
    ///Class for region geographical location identifiers.
    GEOCLASS_REGION = 0x0000000e,
    ///<b>Starting with Windows 8:</b> Class for all geographical location identifiers.
    GEOCLASS_ALL    = 0x00000000,
}

///Specifies the supported normalization forms.
alias NORM_FORM = int;
enum : int
{
    ///Not supported.
    NormalizationOther = 0x00000000,
    ///Unicode normalization form C, canonical composition. Transforms each decomposed grouping, consisting of a base
    ///character plus combining characters, to the canonical precomposed equivalent. For example, A + ¨ becomes Ä.
    NormalizationC     = 0x00000001,
    ///Unicode normalization form D, canonical decomposition. Transforms each precomposed character to its canonical
    ///decomposed equivalent. For example, Ä becomes A + ¨.
    NormalizationD     = 0x00000002,
    ///Unicode normalization form KC, compatibility composition. Transforms each base plus combining characters to the
    ///canonical precomposed equivalent and all compatibility characters to their equivalents. For example, the ligature
    ///ﬁ becomes f + i; similarly, A + ¨ + ﬁ + n becomes Ä + f + i + n.
    NormalizationKC    = 0x00000005,
    ///Unicode normalization form KD, compatibility decomposition. Transforms each precomposed character to its
    ///canonical decomposed equivalent and all compatibility characters to their equivalents. For example, Ä + ﬁ + n
    ///becomes A + ¨ + f + i + n.
    NormalizationKD    = 0x00000006,
}

///Identifies one of the types of word lists used by spell checkers.
alias WORDLIST_TYPE = int;
enum : int
{
    ///Words considered to be correctly spelled, but which are not offered as suggestions. This word list isn't saved
    ///and is specific to a spelling session. (The others types of word lists are saved in the default custom dictionary
    ///files, and are global.)
    WORDLIST_TYPE_IGNORE      = 0x00000000,
    ///Words considered to be correctly spelled and which can be offered as suggestions.
    WORDLIST_TYPE_ADD         = 0x00000001,
    ///Words considered to be incorrectly spelled.
    WORDLIST_TYPE_EXCLUDE     = 0x00000002,
    ///Word pairs of a misspelled word and the word that should replace it.
    WORDLIST_TYPE_AUTOCORRECT = 0x00000003,
}

///Identifies the type of corrective action to be taken for a spelling error.
alias CORRECTIVE_ACTION = int;
enum : int
{
    ///There are no errors.
    CORRECTIVE_ACTION_NONE            = 0x00000000,
    ///The user should be prompted with a list of suggestions as returned by ISpellChecker::Suggest.
    CORRECTIVE_ACTION_GET_SUGGESTIONS = 0x00000001,
    ///Replace the indicated erroneous text with the text provided in the suggestion. The user does not need to be
    ///prompted.
    CORRECTIVE_ACTION_REPLACE         = 0x00000002,
    ///The user should be prompted to delete the indicated erroneous text.
    CORRECTIVE_ACTION_DELETE          = 0x00000003,
}

alias IMEREG = int;
enum : int
{
    IFED_REG_HEAD = 0x00000000,
    IFED_REG_TAIL = 0x00000001,
    IFED_REG_DEL  = 0x00000002,
}

alias IMEFMT = int;
enum : int
{
    IFED_UNKNOWN                   = 0x00000000,
    IFED_MSIME2_BIN_SYSTEM         = 0x00000001,
    IFED_MSIME2_BIN_USER           = 0x00000002,
    IFED_MSIME2_TEXT_USER          = 0x00000003,
    IFED_MSIME95_BIN_SYSTEM        = 0x00000004,
    IFED_MSIME95_BIN_USER          = 0x00000005,
    IFED_MSIME95_TEXT_USER         = 0x00000006,
    IFED_MSIME97_BIN_SYSTEM        = 0x00000007,
    IFED_MSIME97_BIN_USER          = 0x00000008,
    IFED_MSIME97_TEXT_USER         = 0x00000009,
    IFED_MSIME98_BIN_SYSTEM        = 0x0000000a,
    IFED_MSIME98_BIN_USER          = 0x0000000b,
    IFED_MSIME98_TEXT_USER         = 0x0000000c,
    IFED_ACTIVE_DICT               = 0x0000000d,
    IFED_ATOK9                     = 0x0000000e,
    IFED_ATOK10                    = 0x0000000f,
    IFED_NEC_AI_                   = 0x00000010,
    IFED_WX_II                     = 0x00000011,
    IFED_WX_III                    = 0x00000012,
    IFED_VJE_20                    = 0x00000013,
    IFED_MSIME98_SYSTEM_CE         = 0x00000014,
    IFED_MSIME_BIN_SYSTEM          = 0x00000015,
    IFED_MSIME_BIN_USER            = 0x00000016,
    IFED_MSIME_TEXT_USER           = 0x00000017,
    IFED_PIME2_BIN_USER            = 0x00000018,
    IFED_PIME2_BIN_SYSTEM          = 0x00000019,
    IFED_PIME2_BIN_STANDARD_SYSTEM = 0x0000001a,
}

///Type of user comment in a IMEWRD structure.
alias IMEUCT = int;
enum : int
{
    ///No comment string is specified.
    IFED_UCT_NONE           = 0x00000000,
    ///The comment is an SJIS string.
    IFED_UCT_STRING_SJIS    = 0x00000001,
    ///The comment is a Unicode string.
    IFED_UCT_STRING_UNICODE = 0x00000002,
    ///The comment is in a user-defined format.
    IFED_UCT_USER_DEFINED   = 0x00000003,
    IFED_UCT_MAX            = 0x00000004,
}

alias IMEREL = int;
enum : int
{
    IFED_REL_NONE               = 0x00000000,
    IFED_REL_NO                 = 0x00000001,
    IFED_REL_GA                 = 0x00000002,
    IFED_REL_WO                 = 0x00000003,
    IFED_REL_NI                 = 0x00000004,
    IFED_REL_DE                 = 0x00000005,
    IFED_REL_YORI               = 0x00000006,
    IFED_REL_KARA               = 0x00000007,
    IFED_REL_MADE               = 0x00000008,
    IFED_REL_HE                 = 0x00000009,
    IFED_REL_TO                 = 0x0000000a,
    IFED_REL_IDEOM              = 0x0000000b,
    IFED_REL_FUKU_YOUGEN        = 0x0000000c,
    IFED_REL_KEIYOU_YOUGEN      = 0x0000000d,
    IFED_REL_KEIDOU1_YOUGEN     = 0x0000000e,
    IFED_REL_KEIDOU2_YOUGEN     = 0x0000000f,
    IFED_REL_TAIGEN             = 0x00000010,
    IFED_REL_YOUGEN             = 0x00000011,
    IFED_REL_RENTAI_MEI         = 0x00000012,
    IFED_REL_RENSOU             = 0x00000013,
    IFED_REL_KEIYOU_TO_YOUGEN   = 0x00000014,
    IFED_REL_KEIYOU_TARU_YOUGEN = 0x00000015,
    IFED_REL_UNKNOWN1           = 0x00000016,
    IFED_REL_UNKNOWN2           = 0x00000017,
    IFED_REL_ALL                = 0x00000018,
}

///Defines glyph characteristic information that an application needs to implement justification.
alias SCRIPT_JUSTIFY = int;
enum : int
{
    ///Justification cannot be applied at the glyph.
    SCRIPT_JUSTIFY_NONE           = 0x00000000,
    ///The glyph represents a blank in an Arabic run.
    SCRIPT_JUSTIFY_ARABIC_BLANK   = 0x00000001,
    ///An inter-character justification point follows the glyph.
    SCRIPT_JUSTIFY_CHARACTER      = 0x00000002,
    ///Reserved.
    SCRIPT_JUSTIFY_RESERVED1      = 0x00000003,
    ///The glyph represents a blank outside an Arabic run.
    SCRIPT_JUSTIFY_BLANK          = 0x00000004,
    ///Reserved.
    SCRIPT_JUSTIFY_RESERVED2      = 0x00000005,
    ///Reserved.
    SCRIPT_JUSTIFY_RESERVED3      = 0x00000006,
    ///Normal middle-of-word glyph that connects to the right (begin).
    SCRIPT_JUSTIFY_ARABIC_NORMAL  = 0x00000007,
    ///Kashida (U+0640) in the middle of the word.
    SCRIPT_JUSTIFY_ARABIC_KASHIDA = 0x00000008,
    ///Final form of an alef-like (U+0627, U+0625, U+0623, U+0622).
    SCRIPT_JUSTIFY_ARABIC_ALEF    = 0x00000009,
    ///Final form of Ha (U+0647).
    SCRIPT_JUSTIFY_ARABIC_HA      = 0x0000000a,
    ///Final form of Ra (U+0631).
    SCRIPT_JUSTIFY_ARABIC_RA      = 0x0000000b,
    ///Final form of Ba (U+0628).
    SCRIPT_JUSTIFY_ARABIC_BA      = 0x0000000c,
    ///Ligature of alike (U+0628,U+0631).
    SCRIPT_JUSTIFY_ARABIC_BARA    = 0x0000000d,
    ///Highest priority: initial shape of Seen class (U+0633).
    SCRIPT_JUSTIFY_ARABIC_SEEN    = 0x0000000e,
    ///Highest priority: medial shape of Seen class (U+0633).
    SCRIPT_JUSTIFY_ARABIC_SEEN_M  = 0x0000000f,
}

enum UErrorCode : int
{
    U_USING_FALLBACK_WARNING           = 0xffffff80,
    U_ERROR_WARNING_START              = 0xffffff80,
    U_USING_DEFAULT_WARNING            = 0xffffff81,
    U_SAFECLONE_ALLOCATED_WARNING      = 0xffffff82,
    U_STATE_OLD_WARNING                = 0xffffff83,
    U_STRING_NOT_TERMINATED_WARNING    = 0xffffff84,
    U_SORT_KEY_TOO_SHORT_WARNING       = 0xffffff85,
    U_AMBIGUOUS_ALIAS_WARNING          = 0xffffff86,
    U_DIFFERENT_UCA_VERSION            = 0xffffff87,
    U_PLUGIN_CHANGED_LEVEL_WARNING     = 0xffffff88,
    U_ZERO_ERROR                       = 0x00000000,
    U_ILLEGAL_ARGUMENT_ERROR           = 0x00000001,
    U_MISSING_RESOURCE_ERROR           = 0x00000002,
    U_INVALID_FORMAT_ERROR             = 0x00000003,
    U_FILE_ACCESS_ERROR                = 0x00000004,
    U_INTERNAL_PROGRAM_ERROR           = 0x00000005,
    U_MESSAGE_PARSE_ERROR              = 0x00000006,
    U_MEMORY_ALLOCATION_ERROR          = 0x00000007,
    U_INDEX_OUTOFBOUNDS_ERROR          = 0x00000008,
    U_PARSE_ERROR                      = 0x00000009,
    U_INVALID_CHAR_FOUND               = 0x0000000a,
    U_TRUNCATED_CHAR_FOUND             = 0x0000000b,
    U_ILLEGAL_CHAR_FOUND               = 0x0000000c,
    U_INVALID_TABLE_FORMAT             = 0x0000000d,
    U_INVALID_TABLE_FILE               = 0x0000000e,
    U_BUFFER_OVERFLOW_ERROR            = 0x0000000f,
    U_UNSUPPORTED_ERROR                = 0x00000010,
    U_RESOURCE_TYPE_MISMATCH           = 0x00000011,
    U_ILLEGAL_ESCAPE_SEQUENCE          = 0x00000012,
    U_UNSUPPORTED_ESCAPE_SEQUENCE      = 0x00000013,
    U_NO_SPACE_AVAILABLE               = 0x00000014,
    U_CE_NOT_FOUND_ERROR               = 0x00000015,
    U_PRIMARY_TOO_LONG_ERROR           = 0x00000016,
    U_STATE_TOO_OLD_ERROR              = 0x00000017,
    U_TOO_MANY_ALIASES_ERROR           = 0x00000018,
    U_ENUM_OUT_OF_SYNC_ERROR           = 0x00000019,
    U_INVARIANT_CONVERSION_ERROR       = 0x0000001a,
    U_INVALID_STATE_ERROR              = 0x0000001b,
    U_COLLATOR_VERSION_MISMATCH        = 0x0000001c,
    U_USELESS_COLLATOR_ERROR           = 0x0000001d,
    U_NO_WRITE_PERMISSION              = 0x0000001e,
    U_BAD_VARIABLE_DEFINITION          = 0x00010000,
    U_PARSE_ERROR_START                = 0x00010000,
    U_MALFORMED_RULE                   = 0x00010001,
    U_MALFORMED_SET                    = 0x00010002,
    U_MALFORMED_SYMBOL_REFERENCE       = 0x00010003,
    U_MALFORMED_UNICODE_ESCAPE         = 0x00010004,
    U_MALFORMED_VARIABLE_DEFINITION    = 0x00010005,
    U_MALFORMED_VARIABLE_REFERENCE     = 0x00010006,
    U_MISMATCHED_SEGMENT_DELIMITERS    = 0x00010007,
    U_MISPLACED_ANCHOR_START           = 0x00010008,
    U_MISPLACED_CURSOR_OFFSET          = 0x00010009,
    U_MISPLACED_QUANTIFIER             = 0x0001000a,
    U_MISSING_OPERATOR                 = 0x0001000b,
    U_MISSING_SEGMENT_CLOSE            = 0x0001000c,
    U_MULTIPLE_ANTE_CONTEXTS           = 0x0001000d,
    U_MULTIPLE_CURSORS                 = 0x0001000e,
    U_MULTIPLE_POST_CONTEXTS           = 0x0001000f,
    U_TRAILING_BACKSLASH               = 0x00010010,
    U_UNDEFINED_SEGMENT_REFERENCE      = 0x00010011,
    U_UNDEFINED_VARIABLE               = 0x00010012,
    U_UNQUOTED_SPECIAL                 = 0x00010013,
    U_UNTERMINATED_QUOTE               = 0x00010014,
    U_RULE_MASK_ERROR                  = 0x00010015,
    U_MISPLACED_COMPOUND_FILTER        = 0x00010016,
    U_MULTIPLE_COMPOUND_FILTERS        = 0x00010017,
    U_INVALID_RBT_SYNTAX               = 0x00010018,
    U_INVALID_PROPERTY_PATTERN         = 0x00010019,
    U_MALFORMED_PRAGMA                 = 0x0001001a,
    U_UNCLOSED_SEGMENT                 = 0x0001001b,
    U_ILLEGAL_CHAR_IN_SEGMENT          = 0x0001001c,
    U_VARIABLE_RANGE_EXHAUSTED         = 0x0001001d,
    U_VARIABLE_RANGE_OVERLAP           = 0x0001001e,
    U_ILLEGAL_CHARACTER                = 0x0001001f,
    U_INTERNAL_TRANSLITERATOR_ERROR    = 0x00010020,
    U_INVALID_ID                       = 0x00010021,
    U_INVALID_FUNCTION                 = 0x00010022,
    U_UNEXPECTED_TOKEN                 = 0x00010100,
    U_FMT_PARSE_ERROR_START            = 0x00010100,
    U_MULTIPLE_DECIMAL_SEPARATORS      = 0x00010101,
    U_MULTIPLE_DECIMAL_SEPERATORS      = 0x00010101,
    U_MULTIPLE_EXPONENTIAL_SYMBOLS     = 0x00010102,
    U_MALFORMED_EXPONENTIAL_PATTERN    = 0x00010103,
    U_MULTIPLE_PERCENT_SYMBOLS         = 0x00010104,
    U_MULTIPLE_PERMILL_SYMBOLS         = 0x00010105,
    U_MULTIPLE_PAD_SPECIFIERS          = 0x00010106,
    U_PATTERN_SYNTAX_ERROR             = 0x00010107,
    U_ILLEGAL_PAD_POSITION             = 0x00010108,
    U_UNMATCHED_BRACES                 = 0x00010109,
    U_UNSUPPORTED_PROPERTY             = 0x0001010a,
    U_UNSUPPORTED_ATTRIBUTE            = 0x0001010b,
    U_ARGUMENT_TYPE_MISMATCH           = 0x0001010c,
    U_DUPLICATE_KEYWORD                = 0x0001010d,
    U_UNDEFINED_KEYWORD                = 0x0001010e,
    U_DEFAULT_KEYWORD_MISSING          = 0x0001010f,
    U_DECIMAL_NUMBER_SYNTAX_ERROR      = 0x00010110,
    U_FORMAT_INEXACT_ERROR             = 0x00010111,
    U_NUMBER_ARG_OUTOFBOUNDS_ERROR     = 0x00010112,
    U_NUMBER_SKELETON_SYNTAX_ERROR     = 0x00010113,
    U_BRK_INTERNAL_ERROR               = 0x00010200,
    U_BRK_ERROR_START                  = 0x00010200,
    U_BRK_HEX_DIGITS_EXPECTED          = 0x00010201,
    U_BRK_SEMICOLON_EXPECTED           = 0x00010202,
    U_BRK_RULE_SYNTAX                  = 0x00010203,
    U_BRK_UNCLOSED_SET                 = 0x00010204,
    U_BRK_ASSIGN_ERROR                 = 0x00010205,
    U_BRK_VARIABLE_REDFINITION         = 0x00010206,
    U_BRK_MISMATCHED_PAREN             = 0x00010207,
    U_BRK_NEW_LINE_IN_QUOTED_STRING    = 0x00010208,
    U_BRK_UNDEFINED_VARIABLE           = 0x00010209,
    U_BRK_INIT_ERROR                   = 0x0001020a,
    U_BRK_RULE_EMPTY_SET               = 0x0001020b,
    U_BRK_UNRECOGNIZED_OPTION          = 0x0001020c,
    U_BRK_MALFORMED_RULE_TAG           = 0x0001020d,
    U_REGEX_INTERNAL_ERROR             = 0x00010300,
    U_REGEX_ERROR_START                = 0x00010300,
    U_REGEX_RULE_SYNTAX                = 0x00010301,
    U_REGEX_INVALID_STATE              = 0x00010302,
    U_REGEX_BAD_ESCAPE_SEQUENCE        = 0x00010303,
    U_REGEX_PROPERTY_SYNTAX            = 0x00010304,
    U_REGEX_UNIMPLEMENTED              = 0x00010305,
    U_REGEX_MISMATCHED_PAREN           = 0x00010306,
    U_REGEX_NUMBER_TOO_BIG             = 0x00010307,
    U_REGEX_BAD_INTERVAL               = 0x00010308,
    U_REGEX_MAX_LT_MIN                 = 0x00010309,
    U_REGEX_INVALID_BACK_REF           = 0x0001030a,
    U_REGEX_INVALID_FLAG               = 0x0001030b,
    U_REGEX_LOOK_BEHIND_LIMIT          = 0x0001030c,
    U_REGEX_SET_CONTAINS_STRING        = 0x0001030d,
    U_REGEX_MISSING_CLOSE_BRACKET      = 0x0001030f,
    U_REGEX_INVALID_RANGE              = 0x00010310,
    U_REGEX_STACK_OVERFLOW             = 0x00010311,
    U_REGEX_TIME_OUT                   = 0x00010312,
    U_REGEX_STOPPED_BY_CALLER          = 0x00010313,
    U_REGEX_PATTERN_TOO_BIG            = 0x00010314,
    U_REGEX_INVALID_CAPTURE_GROUP_NAME = 0x00010315,
    U_IDNA_PROHIBITED_ERROR            = 0x00010400,
    U_IDNA_ERROR_START                 = 0x00010400,
    U_IDNA_UNASSIGNED_ERROR            = 0x00010401,
    U_IDNA_CHECK_BIDI_ERROR            = 0x00010402,
    U_IDNA_STD3_ASCII_RULES_ERROR      = 0x00010403,
    U_IDNA_ACE_PREFIX_ERROR            = 0x00010404,
    U_IDNA_VERIFICATION_ERROR          = 0x00010405,
    U_IDNA_LABEL_TOO_LONG_ERROR        = 0x00010406,
    U_IDNA_ZERO_LENGTH_LABEL_ERROR     = 0x00010407,
    U_IDNA_DOMAIN_NAME_TOO_LONG_ERROR  = 0x00010408,
    U_STRINGPREP_PROHIBITED_ERROR      = 0x00010400,
    U_STRINGPREP_UNASSIGNED_ERROR      = 0x00010401,
    U_STRINGPREP_CHECK_BIDI_ERROR      = 0x00010402,
    U_PLUGIN_ERROR_START               = 0x00010500,
    U_PLUGIN_TOO_HIGH                  = 0x00010500,
    U_PLUGIN_DIDNT_SET_LEVEL           = 0x00010501,
}

enum UTraceLevel : int
{
    UTRACE_OFF        = 0xffffffff,
    UTRACE_ERROR      = 0x00000000,
    UTRACE_WARNING    = 0x00000003,
    UTRACE_OPEN_CLOSE = 0x00000005,
    UTRACE_INFO       = 0x00000007,
    UTRACE_VERBOSE    = 0x00000009,
}

enum UTraceFunctionNumber : int
{
    UTRACE_FUNCTION_START              = 0x00000000,
    UTRACE_U_INIT                      = 0x00000000,
    UTRACE_U_CLEANUP                   = 0x00000001,
    UTRACE_CONVERSION_START            = 0x00001000,
    UTRACE_UCNV_OPEN                   = 0x00001000,
    UTRACE_UCNV_OPEN_PACKAGE           = 0x00001001,
    UTRACE_UCNV_OPEN_ALGORITHMIC       = 0x00001002,
    UTRACE_UCNV_CLONE                  = 0x00001003,
    UTRACE_UCNV_CLOSE                  = 0x00001004,
    UTRACE_UCNV_FLUSH_CACHE            = 0x00001005,
    UTRACE_UCNV_LOAD                   = 0x00001006,
    UTRACE_UCNV_UNLOAD                 = 0x00001007,
    UTRACE_COLLATION_START             = 0x00002000,
    UTRACE_UCOL_OPEN                   = 0x00002000,
    UTRACE_UCOL_CLOSE                  = 0x00002001,
    UTRACE_UCOL_STRCOLL                = 0x00002002,
    UTRACE_UCOL_GET_SORTKEY            = 0x00002003,
    UTRACE_UCOL_GETLOCALE              = 0x00002004,
    UTRACE_UCOL_NEXTSORTKEYPART        = 0x00002005,
    UTRACE_UCOL_STRCOLLITER            = 0x00002006,
    UTRACE_UCOL_OPEN_FROM_SHORT_STRING = 0x00002007,
    UTRACE_UCOL_STRCOLLUTF8            = 0x00002008,
}

enum UStringTrieResult : int
{
    USTRINGTRIE_NO_MATCH           = 0x00000000,
    USTRINGTRIE_NO_VALUE           = 0x00000001,
    USTRINGTRIE_FINAL_VALUE        = 0x00000002,
    USTRINGTRIE_INTERMEDIATE_VALUE = 0x00000003,
}

enum UScriptCode : int
{
    USCRIPT_INVALID_CODE                 = 0xffffffff,
    USCRIPT_COMMON                       = 0x00000000,
    USCRIPT_INHERITED                    = 0x00000001,
    USCRIPT_ARABIC                       = 0x00000002,
    USCRIPT_ARMENIAN                     = 0x00000003,
    USCRIPT_BENGALI                      = 0x00000004,
    USCRIPT_BOPOMOFO                     = 0x00000005,
    USCRIPT_CHEROKEE                     = 0x00000006,
    USCRIPT_COPTIC                       = 0x00000007,
    USCRIPT_CYRILLIC                     = 0x00000008,
    USCRIPT_DESERET                      = 0x00000009,
    USCRIPT_DEVANAGARI                   = 0x0000000a,
    USCRIPT_ETHIOPIC                     = 0x0000000b,
    USCRIPT_GEORGIAN                     = 0x0000000c,
    USCRIPT_GOTHIC                       = 0x0000000d,
    USCRIPT_GREEK                        = 0x0000000e,
    USCRIPT_GUJARATI                     = 0x0000000f,
    USCRIPT_GURMUKHI                     = 0x00000010,
    USCRIPT_HAN                          = 0x00000011,
    USCRIPT_HANGUL                       = 0x00000012,
    USCRIPT_HEBREW                       = 0x00000013,
    USCRIPT_HIRAGANA                     = 0x00000014,
    USCRIPT_KANNADA                      = 0x00000015,
    USCRIPT_KATAKANA                     = 0x00000016,
    USCRIPT_KHMER                        = 0x00000017,
    USCRIPT_LAO                          = 0x00000018,
    USCRIPT_LATIN                        = 0x00000019,
    USCRIPT_MALAYALAM                    = 0x0000001a,
    USCRIPT_MONGOLIAN                    = 0x0000001b,
    USCRIPT_MYANMAR                      = 0x0000001c,
    USCRIPT_OGHAM                        = 0x0000001d,
    USCRIPT_OLD_ITALIC                   = 0x0000001e,
    USCRIPT_ORIYA                        = 0x0000001f,
    USCRIPT_RUNIC                        = 0x00000020,
    USCRIPT_SINHALA                      = 0x00000021,
    USCRIPT_SYRIAC                       = 0x00000022,
    USCRIPT_TAMIL                        = 0x00000023,
    USCRIPT_TELUGU                       = 0x00000024,
    USCRIPT_THAANA                       = 0x00000025,
    USCRIPT_THAI                         = 0x00000026,
    USCRIPT_TIBETAN                      = 0x00000027,
    USCRIPT_CANADIAN_ABORIGINAL          = 0x00000028,
    USCRIPT_UCAS                         = 0x00000028,
    USCRIPT_YI                           = 0x00000029,
    USCRIPT_TAGALOG                      = 0x0000002a,
    USCRIPT_HANUNOO                      = 0x0000002b,
    USCRIPT_BUHID                        = 0x0000002c,
    USCRIPT_TAGBANWA                     = 0x0000002d,
    USCRIPT_BRAILLE                      = 0x0000002e,
    USCRIPT_CYPRIOT                      = 0x0000002f,
    USCRIPT_LIMBU                        = 0x00000030,
    USCRIPT_LINEAR_B                     = 0x00000031,
    USCRIPT_OSMANYA                      = 0x00000032,
    USCRIPT_SHAVIAN                      = 0x00000033,
    USCRIPT_TAI_LE                       = 0x00000034,
    USCRIPT_UGARITIC                     = 0x00000035,
    USCRIPT_KATAKANA_OR_HIRAGANA         = 0x00000036,
    USCRIPT_BUGINESE                     = 0x00000037,
    USCRIPT_GLAGOLITIC                   = 0x00000038,
    USCRIPT_KHAROSHTHI                   = 0x00000039,
    USCRIPT_SYLOTI_NAGRI                 = 0x0000003a,
    USCRIPT_NEW_TAI_LUE                  = 0x0000003b,
    USCRIPT_TIFINAGH                     = 0x0000003c,
    USCRIPT_OLD_PERSIAN                  = 0x0000003d,
    USCRIPT_BALINESE                     = 0x0000003e,
    USCRIPT_BATAK                        = 0x0000003f,
    USCRIPT_BLISSYMBOLS                  = 0x00000040,
    USCRIPT_BRAHMI                       = 0x00000041,
    USCRIPT_CHAM                         = 0x00000042,
    USCRIPT_CIRTH                        = 0x00000043,
    USCRIPT_OLD_CHURCH_SLAVONIC_CYRILLIC = 0x00000044,
    USCRIPT_DEMOTIC_EGYPTIAN             = 0x00000045,
    USCRIPT_HIERATIC_EGYPTIAN            = 0x00000046,
    USCRIPT_EGYPTIAN_HIEROGLYPHS         = 0x00000047,
    USCRIPT_KHUTSURI                     = 0x00000048,
    USCRIPT_SIMPLIFIED_HAN               = 0x00000049,
    USCRIPT_TRADITIONAL_HAN              = 0x0000004a,
    USCRIPT_PAHAWH_HMONG                 = 0x0000004b,
    USCRIPT_OLD_HUNGARIAN                = 0x0000004c,
    USCRIPT_HARAPPAN_INDUS               = 0x0000004d,
    USCRIPT_JAVANESE                     = 0x0000004e,
    USCRIPT_KAYAH_LI                     = 0x0000004f,
    USCRIPT_LATIN_FRAKTUR                = 0x00000050,
    USCRIPT_LATIN_GAELIC                 = 0x00000051,
    USCRIPT_LEPCHA                       = 0x00000052,
    USCRIPT_LINEAR_A                     = 0x00000053,
    USCRIPT_MANDAIC                      = 0x00000054,
    USCRIPT_MANDAEAN                     = 0x00000054,
    USCRIPT_MAYAN_HIEROGLYPHS            = 0x00000055,
    USCRIPT_MEROITIC_HIEROGLYPHS         = 0x00000056,
    USCRIPT_MEROITIC                     = 0x00000056,
    USCRIPT_NKO                          = 0x00000057,
    USCRIPT_ORKHON                       = 0x00000058,
    USCRIPT_OLD_PERMIC                   = 0x00000059,
    USCRIPT_PHAGS_PA                     = 0x0000005a,
    USCRIPT_PHOENICIAN                   = 0x0000005b,
    USCRIPT_MIAO                         = 0x0000005c,
    USCRIPT_PHONETIC_POLLARD             = 0x0000005c,
    USCRIPT_RONGORONGO                   = 0x0000005d,
    USCRIPT_SARATI                       = 0x0000005e,
    USCRIPT_ESTRANGELO_SYRIAC            = 0x0000005f,
    USCRIPT_WESTERN_SYRIAC               = 0x00000060,
    USCRIPT_EASTERN_SYRIAC               = 0x00000061,
    USCRIPT_TENGWAR                      = 0x00000062,
    USCRIPT_VAI                          = 0x00000063,
    USCRIPT_VISIBLE_SPEECH               = 0x00000064,
    USCRIPT_CUNEIFORM                    = 0x00000065,
    USCRIPT_UNWRITTEN_LANGUAGES          = 0x00000066,
    USCRIPT_UNKNOWN                      = 0x00000067,
    USCRIPT_CARIAN                       = 0x00000068,
    USCRIPT_JAPANESE                     = 0x00000069,
    USCRIPT_LANNA                        = 0x0000006a,
    USCRIPT_LYCIAN                       = 0x0000006b,
    USCRIPT_LYDIAN                       = 0x0000006c,
    USCRIPT_OL_CHIKI                     = 0x0000006d,
    USCRIPT_REJANG                       = 0x0000006e,
    USCRIPT_SAURASHTRA                   = 0x0000006f,
    USCRIPT_SIGN_WRITING                 = 0x00000070,
    USCRIPT_SUNDANESE                    = 0x00000071,
    USCRIPT_MOON                         = 0x00000072,
    USCRIPT_MEITEI_MAYEK                 = 0x00000073,
    USCRIPT_IMPERIAL_ARAMAIC             = 0x00000074,
    USCRIPT_AVESTAN                      = 0x00000075,
    USCRIPT_CHAKMA                       = 0x00000076,
    USCRIPT_KOREAN                       = 0x00000077,
    USCRIPT_KAITHI                       = 0x00000078,
    USCRIPT_MANICHAEAN                   = 0x00000079,
    USCRIPT_INSCRIPTIONAL_PAHLAVI        = 0x0000007a,
    USCRIPT_PSALTER_PAHLAVI              = 0x0000007b,
    USCRIPT_BOOK_PAHLAVI                 = 0x0000007c,
    USCRIPT_INSCRIPTIONAL_PARTHIAN       = 0x0000007d,
    USCRIPT_SAMARITAN                    = 0x0000007e,
    USCRIPT_TAI_VIET                     = 0x0000007f,
    USCRIPT_MATHEMATICAL_NOTATION        = 0x00000080,
    USCRIPT_SYMBOLS                      = 0x00000081,
    USCRIPT_BAMUM                        = 0x00000082,
    USCRIPT_LISU                         = 0x00000083,
    USCRIPT_NAKHI_GEBA                   = 0x00000084,
    USCRIPT_OLD_SOUTH_ARABIAN            = 0x00000085,
    USCRIPT_BASSA_VAH                    = 0x00000086,
    USCRIPT_DUPLOYAN                     = 0x00000087,
    USCRIPT_ELBASAN                      = 0x00000088,
    USCRIPT_GRANTHA                      = 0x00000089,
    USCRIPT_KPELLE                       = 0x0000008a,
    USCRIPT_LOMA                         = 0x0000008b,
    USCRIPT_MENDE                        = 0x0000008c,
    USCRIPT_MEROITIC_CURSIVE             = 0x0000008d,
    USCRIPT_OLD_NORTH_ARABIAN            = 0x0000008e,
    USCRIPT_NABATAEAN                    = 0x0000008f,
    USCRIPT_PALMYRENE                    = 0x00000090,
    USCRIPT_KHUDAWADI                    = 0x00000091,
    USCRIPT_SINDHI                       = 0x00000091,
    USCRIPT_WARANG_CITI                  = 0x00000092,
    USCRIPT_AFAKA                        = 0x00000093,
    USCRIPT_JURCHEN                      = 0x00000094,
    USCRIPT_MRO                          = 0x00000095,
    USCRIPT_NUSHU                        = 0x00000096,
    USCRIPT_SHARADA                      = 0x00000097,
    USCRIPT_SORA_SOMPENG                 = 0x00000098,
    USCRIPT_TAKRI                        = 0x00000099,
    USCRIPT_TANGUT                       = 0x0000009a,
    USCRIPT_WOLEAI                       = 0x0000009b,
    USCRIPT_ANATOLIAN_HIEROGLYPHS        = 0x0000009c,
    USCRIPT_KHOJKI                       = 0x0000009d,
    USCRIPT_TIRHUTA                      = 0x0000009e,
    USCRIPT_CAUCASIAN_ALBANIAN           = 0x0000009f,
    USCRIPT_MAHAJANI                     = 0x000000a0,
    USCRIPT_AHOM                         = 0x000000a1,
    USCRIPT_HATRAN                       = 0x000000a2,
    USCRIPT_MODI                         = 0x000000a3,
    USCRIPT_MULTANI                      = 0x000000a4,
    USCRIPT_PAU_CIN_HAU                  = 0x000000a5,
    USCRIPT_SIDDHAM                      = 0x000000a6,
    USCRIPT_ADLAM                        = 0x000000a7,
    USCRIPT_BHAIKSUKI                    = 0x000000a8,
    USCRIPT_MARCHEN                      = 0x000000a9,
    USCRIPT_NEWA                         = 0x000000aa,
    USCRIPT_OSAGE                        = 0x000000ab,
    USCRIPT_HAN_WITH_BOPOMOFO            = 0x000000ac,
    USCRIPT_JAMO                         = 0x000000ad,
    USCRIPT_SYMBOLS_EMOJI                = 0x000000ae,
    USCRIPT_MASARAM_GONDI                = 0x000000af,
    USCRIPT_SOYOMBO                      = 0x000000b0,
    USCRIPT_ZANABAZAR_SQUARE             = 0x000000b1,
    USCRIPT_DOGRA                        = 0x000000b2,
    USCRIPT_GUNJALA_GONDI                = 0x000000b3,
    USCRIPT_MAKASAR                      = 0x000000b4,
    USCRIPT_MEDEFAIDRIN                  = 0x000000b5,
    USCRIPT_HANIFI_ROHINGYA              = 0x000000b6,
    USCRIPT_SOGDIAN                      = 0x000000b7,
    USCRIPT_OLD_SOGDIAN                  = 0x000000b8,
    USCRIPT_ELYMAIC                      = 0x000000b9,
    USCRIPT_NYIAKENG_PUACHUE_HMONG       = 0x000000ba,
    USCRIPT_NANDINAGARI                  = 0x000000bb,
    USCRIPT_WANCHO                       = 0x000000bc,
}

enum UScriptUsage : int
{
    USCRIPT_USAGE_NOT_ENCODED  = 0x00000000,
    USCRIPT_USAGE_UNKNOWN      = 0x00000001,
    USCRIPT_USAGE_EXCLUDED     = 0x00000002,
    USCRIPT_USAGE_LIMITED_USE  = 0x00000003,
    USCRIPT_USAGE_ASPIRATIONAL = 0x00000004,
    USCRIPT_USAGE_RECOMMENDED  = 0x00000005,
}

enum UCharIteratorOrigin : int
{
    UITER_START   = 0x00000000,
    UITER_CURRENT = 0x00000001,
    UITER_LIMIT   = 0x00000002,
    UITER_ZERO    = 0x00000003,
    UITER_LENGTH  = 0x00000004,
}

enum ULocDataLocaleType : int
{
    ULOC_ACTUAL_LOCALE = 0x00000000,
    ULOC_VALID_LOCALE  = 0x00000001,
}

enum ULayoutType : int
{
    ULOC_LAYOUT_LTR     = 0x00000000,
    ULOC_LAYOUT_RTL     = 0x00000001,
    ULOC_LAYOUT_TTB     = 0x00000002,
    ULOC_LAYOUT_BTT     = 0x00000003,
    ULOC_LAYOUT_UNKNOWN = 0x00000004,
}

enum UAcceptResult : int
{
    ULOC_ACCEPT_FAILED   = 0x00000000,
    ULOC_ACCEPT_VALID    = 0x00000001,
    ULOC_ACCEPT_FALLBACK = 0x00000002,
}

enum UResType : int
{
    URES_NONE       = 0xffffffff,
    URES_STRING     = 0x00000000,
    URES_BINARY     = 0x00000001,
    URES_TABLE      = 0x00000002,
    URES_ALIAS      = 0x00000003,
    URES_INT        = 0x00000007,
    URES_ARRAY      = 0x00000008,
    URES_INT_VECTOR = 0x0000000e,
}

enum UDisplayContextType : int
{
    UDISPCTX_TYPE_DIALECT_HANDLING    = 0x00000000,
    UDISPCTX_TYPE_CAPITALIZATION      = 0x00000001,
    UDISPCTX_TYPE_DISPLAY_LENGTH      = 0x00000002,
    UDISPCTX_TYPE_SUBSTITUTE_HANDLING = 0x00000003,
}

enum UDisplayContext : int
{
    UDISPCTX_STANDARD_NAMES                           = 0x00000000,
    UDISPCTX_DIALECT_NAMES                            = 0x00000001,
    UDISPCTX_CAPITALIZATION_NONE                      = 0x00000100,
    UDISPCTX_CAPITALIZATION_FOR_MIDDLE_OF_SENTENCE    = 0x00000101,
    UDISPCTX_CAPITALIZATION_FOR_BEGINNING_OF_SENTENCE = 0x00000102,
    UDISPCTX_CAPITALIZATION_FOR_UI_LIST_OR_MENU       = 0x00000103,
    UDISPCTX_CAPITALIZATION_FOR_STANDALONE            = 0x00000104,
    UDISPCTX_LENGTH_FULL                              = 0x00000200,
    UDISPCTX_LENGTH_SHORT                             = 0x00000201,
    UDISPCTX_SUBSTITUTE                               = 0x00000300,
    UDISPCTX_NO_SUBSTITUTE                            = 0x00000301,
}

enum UDialectHandling : int
{
    ULDN_STANDARD_NAMES = 0x00000000,
    ULDN_DIALECT_NAMES  = 0x00000001,
}

enum UCurrencyUsage : int
{
    UCURR_USAGE_STANDARD = 0x00000000,
    UCURR_USAGE_CASH     = 0x00000001,
}

enum UCurrNameStyle : int
{
    UCURR_SYMBOL_NAME        = 0x00000000,
    UCURR_LONG_NAME          = 0x00000001,
    UCURR_NARROW_SYMBOL_NAME = 0x00000002,
}

enum UCurrCurrencyType : int
{
    UCURR_ALL            = 0x7fffffff,
    UCURR_COMMON         = 0x00000001,
    UCURR_UNCOMMON       = 0x00000002,
    UCURR_DEPRECATED     = 0x00000004,
    UCURR_NON_DEPRECATED = 0x00000008,
}

enum UConverterCallbackReason : int
{
    UCNV_UNASSIGNED = 0x00000000,
    UCNV_ILLEGAL    = 0x00000001,
    UCNV_IRREGULAR  = 0x00000002,
    UCNV_RESET      = 0x00000003,
    UCNV_CLOSE      = 0x00000004,
    UCNV_CLONE      = 0x00000005,
}

enum UConverterType : int
{
    UCNV_UNSUPPORTED_CONVERTER               = 0xffffffff,
    UCNV_SBCS                                = 0x00000000,
    UCNV_DBCS                                = 0x00000001,
    UCNV_MBCS                                = 0x00000002,
    UCNV_LATIN_1                             = 0x00000003,
    UCNV_UTF8                                = 0x00000004,
    UCNV_UTF16_BigEndian                     = 0x00000005,
    UCNV_UTF16_LittleEndian                  = 0x00000006,
    UCNV_UTF32_BigEndian                     = 0x00000007,
    UCNV_UTF32_LittleEndian                  = 0x00000008,
    UCNV_EBCDIC_STATEFUL                     = 0x00000009,
    UCNV_ISO_2022                            = 0x0000000a,
    UCNV_LMBCS_1                             = 0x0000000b,
    UCNV_LMBCS_2                             = 0x0000000c,
    UCNV_LMBCS_3                             = 0x0000000d,
    UCNV_LMBCS_4                             = 0x0000000e,
    UCNV_LMBCS_5                             = 0x0000000f,
    UCNV_LMBCS_6                             = 0x00000010,
    UCNV_LMBCS_8                             = 0x00000011,
    UCNV_LMBCS_11                            = 0x00000012,
    UCNV_LMBCS_16                            = 0x00000013,
    UCNV_LMBCS_17                            = 0x00000014,
    UCNV_LMBCS_18                            = 0x00000015,
    UCNV_LMBCS_19                            = 0x00000016,
    UCNV_LMBCS_LAST                          = 0x00000016,
    UCNV_HZ                                  = 0x00000017,
    UCNV_SCSU                                = 0x00000018,
    UCNV_ISCII                               = 0x00000019,
    UCNV_US_ASCII                            = 0x0000001a,
    UCNV_UTF7                                = 0x0000001b,
    UCNV_BOCU1                               = 0x0000001c,
    UCNV_UTF16                               = 0x0000001d,
    UCNV_UTF32                               = 0x0000001e,
    UCNV_CESU8                               = 0x0000001f,
    UCNV_IMAP_MAILBOX                        = 0x00000020,
    UCNV_COMPOUND_TEXT                       = 0x00000021,
    UCNV_NUMBER_OF_SUPPORTED_CONVERTER_TYPES = 0x00000022,
}

enum UConverterPlatform : int
{
    UCNV_UNKNOWN = 0xffffffff,
    UCNV_IBM     = 0x00000000,
}

enum UConverterUnicodeSet : int
{
    UCNV_ROUNDTRIP_SET              = 0x00000000,
    UCNV_ROUNDTRIP_AND_FALLBACK_SET = 0x00000001,
}

enum UProperty : int
{
    UCHAR_ALPHABETIC                      = 0x00000000,
    UCHAR_BINARY_START                    = 0x00000000,
    UCHAR_ASCII_HEX_DIGIT                 = 0x00000001,
    UCHAR_BIDI_CONTROL                    = 0x00000002,
    UCHAR_BIDI_MIRRORED                   = 0x00000003,
    UCHAR_DASH                            = 0x00000004,
    UCHAR_DEFAULT_IGNORABLE_CODE_POINT    = 0x00000005,
    UCHAR_DEPRECATED                      = 0x00000006,
    UCHAR_DIACRITIC                       = 0x00000007,
    UCHAR_EXTENDER                        = 0x00000008,
    UCHAR_FULL_COMPOSITION_EXCLUSION      = 0x00000009,
    UCHAR_GRAPHEME_BASE                   = 0x0000000a,
    UCHAR_GRAPHEME_EXTEND                 = 0x0000000b,
    UCHAR_GRAPHEME_LINK                   = 0x0000000c,
    UCHAR_HEX_DIGIT                       = 0x0000000d,
    UCHAR_HYPHEN                          = 0x0000000e,
    UCHAR_ID_CONTINUE                     = 0x0000000f,
    UCHAR_ID_START                        = 0x00000010,
    UCHAR_IDEOGRAPHIC                     = 0x00000011,
    UCHAR_IDS_BINARY_OPERATOR             = 0x00000012,
    UCHAR_IDS_TRINARY_OPERATOR            = 0x00000013,
    UCHAR_JOIN_CONTROL                    = 0x00000014,
    UCHAR_LOGICAL_ORDER_EXCEPTION         = 0x00000015,
    UCHAR_LOWERCASE                       = 0x00000016,
    UCHAR_MATH                            = 0x00000017,
    UCHAR_NONCHARACTER_CODE_POINT         = 0x00000018,
    UCHAR_QUOTATION_MARK                  = 0x00000019,
    UCHAR_RADICAL                         = 0x0000001a,
    UCHAR_SOFT_DOTTED                     = 0x0000001b,
    UCHAR_TERMINAL_PUNCTUATION            = 0x0000001c,
    UCHAR_UNIFIED_IDEOGRAPH               = 0x0000001d,
    UCHAR_UPPERCASE                       = 0x0000001e,
    UCHAR_WHITE_SPACE                     = 0x0000001f,
    UCHAR_XID_CONTINUE                    = 0x00000020,
    UCHAR_XID_START                       = 0x00000021,
    UCHAR_CASE_SENSITIVE                  = 0x00000022,
    UCHAR_S_TERM                          = 0x00000023,
    UCHAR_VARIATION_SELECTOR              = 0x00000024,
    UCHAR_NFD_INERT                       = 0x00000025,
    UCHAR_NFKD_INERT                      = 0x00000026,
    UCHAR_NFC_INERT                       = 0x00000027,
    UCHAR_NFKC_INERT                      = 0x00000028,
    UCHAR_SEGMENT_STARTER                 = 0x00000029,
    UCHAR_PATTERN_SYNTAX                  = 0x0000002a,
    UCHAR_PATTERN_WHITE_SPACE             = 0x0000002b,
    UCHAR_POSIX_ALNUM                     = 0x0000002c,
    UCHAR_POSIX_BLANK                     = 0x0000002d,
    UCHAR_POSIX_GRAPH                     = 0x0000002e,
    UCHAR_POSIX_PRINT                     = 0x0000002f,
    UCHAR_POSIX_XDIGIT                    = 0x00000030,
    UCHAR_CASED                           = 0x00000031,
    UCHAR_CASE_IGNORABLE                  = 0x00000032,
    UCHAR_CHANGES_WHEN_LOWERCASED         = 0x00000033,
    UCHAR_CHANGES_WHEN_UPPERCASED         = 0x00000034,
    UCHAR_CHANGES_WHEN_TITLECASED         = 0x00000035,
    UCHAR_CHANGES_WHEN_CASEFOLDED         = 0x00000036,
    UCHAR_CHANGES_WHEN_CASEMAPPED         = 0x00000037,
    UCHAR_CHANGES_WHEN_NFKC_CASEFOLDED    = 0x00000038,
    UCHAR_EMOJI                           = 0x00000039,
    UCHAR_EMOJI_PRESENTATION              = 0x0000003a,
    UCHAR_EMOJI_MODIFIER                  = 0x0000003b,
    UCHAR_EMOJI_MODIFIER_BASE             = 0x0000003c,
    UCHAR_EMOJI_COMPONENT                 = 0x0000003d,
    UCHAR_REGIONAL_INDICATOR              = 0x0000003e,
    UCHAR_PREPENDED_CONCATENATION_MARK    = 0x0000003f,
    UCHAR_EXTENDED_PICTOGRAPHIC           = 0x00000040,
    UCHAR_BIDI_CLASS                      = 0x00001000,
    UCHAR_INT_START                       = 0x00001000,
    UCHAR_BLOCK                           = 0x00001001,
    UCHAR_CANONICAL_COMBINING_CLASS       = 0x00001002,
    UCHAR_DECOMPOSITION_TYPE              = 0x00001003,
    UCHAR_EAST_ASIAN_WIDTH                = 0x00001004,
    UCHAR_GENERAL_CATEGORY                = 0x00001005,
    UCHAR_JOINING_GROUP                   = 0x00001006,
    UCHAR_JOINING_TYPE                    = 0x00001007,
    UCHAR_LINE_BREAK                      = 0x00001008,
    UCHAR_NUMERIC_TYPE                    = 0x00001009,
    UCHAR_SCRIPT                          = 0x0000100a,
    UCHAR_HANGUL_SYLLABLE_TYPE            = 0x0000100b,
    UCHAR_NFD_QUICK_CHECK                 = 0x0000100c,
    UCHAR_NFKD_QUICK_CHECK                = 0x0000100d,
    UCHAR_NFC_QUICK_CHECK                 = 0x0000100e,
    UCHAR_NFKC_QUICK_CHECK                = 0x0000100f,
    UCHAR_LEAD_CANONICAL_COMBINING_CLASS  = 0x00001010,
    UCHAR_TRAIL_CANONICAL_COMBINING_CLASS = 0x00001011,
    UCHAR_GRAPHEME_CLUSTER_BREAK          = 0x00001012,
    UCHAR_SENTENCE_BREAK                  = 0x00001013,
    UCHAR_WORD_BREAK                      = 0x00001014,
    UCHAR_BIDI_PAIRED_BRACKET_TYPE        = 0x00001015,
    UCHAR_INDIC_POSITIONAL_CATEGORY       = 0x00001016,
    UCHAR_INDIC_SYLLABIC_CATEGORY         = 0x00001017,
    UCHAR_VERTICAL_ORIENTATION            = 0x00001018,
    UCHAR_GENERAL_CATEGORY_MASK           = 0x00002000,
    UCHAR_MASK_START                      = 0x00002000,
    UCHAR_NUMERIC_VALUE                   = 0x00003000,
    UCHAR_DOUBLE_START                    = 0x00003000,
    UCHAR_AGE                             = 0x00004000,
    UCHAR_STRING_START                    = 0x00004000,
    UCHAR_BIDI_MIRRORING_GLYPH            = 0x00004001,
    UCHAR_CASE_FOLDING                    = 0x00004002,
    UCHAR_LOWERCASE_MAPPING               = 0x00004004,
    UCHAR_NAME                            = 0x00004005,
    UCHAR_SIMPLE_CASE_FOLDING             = 0x00004006,
    UCHAR_SIMPLE_LOWERCASE_MAPPING        = 0x00004007,
    UCHAR_SIMPLE_TITLECASE_MAPPING        = 0x00004008,
    UCHAR_SIMPLE_UPPERCASE_MAPPING        = 0x00004009,
    UCHAR_TITLECASE_MAPPING               = 0x0000400a,
    UCHAR_UPPERCASE_MAPPING               = 0x0000400c,
    UCHAR_BIDI_PAIRED_BRACKET             = 0x0000400d,
    UCHAR_SCRIPT_EXTENSIONS               = 0x00007000,
    UCHAR_OTHER_PROPERTY_START            = 0x00007000,
    UCHAR_INVALID_CODE                    = 0xffffffff,
}

enum UCharCategory : int
{
    U_UNASSIGNED             = 0x00000000,
    U_GENERAL_OTHER_TYPES    = 0x00000000,
    U_UPPERCASE_LETTER       = 0x00000001,
    U_LOWERCASE_LETTER       = 0x00000002,
    U_TITLECASE_LETTER       = 0x00000003,
    U_MODIFIER_LETTER        = 0x00000004,
    U_OTHER_LETTER           = 0x00000005,
    U_NON_SPACING_MARK       = 0x00000006,
    U_ENCLOSING_MARK         = 0x00000007,
    U_COMBINING_SPACING_MARK = 0x00000008,
    U_DECIMAL_DIGIT_NUMBER   = 0x00000009,
    U_LETTER_NUMBER          = 0x0000000a,
    U_OTHER_NUMBER           = 0x0000000b,
    U_SPACE_SEPARATOR        = 0x0000000c,
    U_LINE_SEPARATOR         = 0x0000000d,
    U_PARAGRAPH_SEPARATOR    = 0x0000000e,
    U_CONTROL_CHAR           = 0x0000000f,
    U_FORMAT_CHAR            = 0x00000010,
    U_PRIVATE_USE_CHAR       = 0x00000011,
    U_SURROGATE              = 0x00000012,
    U_DASH_PUNCTUATION       = 0x00000013,
    U_START_PUNCTUATION      = 0x00000014,
    U_END_PUNCTUATION        = 0x00000015,
    U_CONNECTOR_PUNCTUATION  = 0x00000016,
    U_OTHER_PUNCTUATION      = 0x00000017,
    U_MATH_SYMBOL            = 0x00000018,
    U_CURRENCY_SYMBOL        = 0x00000019,
    U_MODIFIER_SYMBOL        = 0x0000001a,
    U_OTHER_SYMBOL           = 0x0000001b,
    U_INITIAL_PUNCTUATION    = 0x0000001c,
    U_FINAL_PUNCTUATION      = 0x0000001d,
    U_CHAR_CATEGORY_COUNT    = 0x0000001e,
}

enum UCharDirection : int
{
    U_LEFT_TO_RIGHT              = 0x00000000,
    U_RIGHT_TO_LEFT              = 0x00000001,
    U_EUROPEAN_NUMBER            = 0x00000002,
    U_EUROPEAN_NUMBER_SEPARATOR  = 0x00000003,
    U_EUROPEAN_NUMBER_TERMINATOR = 0x00000004,
    U_ARABIC_NUMBER              = 0x00000005,
    U_COMMON_NUMBER_SEPARATOR    = 0x00000006,
    U_BLOCK_SEPARATOR            = 0x00000007,
    U_SEGMENT_SEPARATOR          = 0x00000008,
    U_WHITE_SPACE_NEUTRAL        = 0x00000009,
    U_OTHER_NEUTRAL              = 0x0000000a,
    U_LEFT_TO_RIGHT_EMBEDDING    = 0x0000000b,
    U_LEFT_TO_RIGHT_OVERRIDE     = 0x0000000c,
    U_RIGHT_TO_LEFT_ARABIC       = 0x0000000d,
    U_RIGHT_TO_LEFT_EMBEDDING    = 0x0000000e,
    U_RIGHT_TO_LEFT_OVERRIDE     = 0x0000000f,
    U_POP_DIRECTIONAL_FORMAT     = 0x00000010,
    U_DIR_NON_SPACING_MARK       = 0x00000011,
    U_BOUNDARY_NEUTRAL           = 0x00000012,
    U_FIRST_STRONG_ISOLATE       = 0x00000013,
    U_LEFT_TO_RIGHT_ISOLATE      = 0x00000014,
    U_RIGHT_TO_LEFT_ISOLATE      = 0x00000015,
    U_POP_DIRECTIONAL_ISOLATE    = 0x00000016,
}

enum UBidiPairedBracketType : int
{
    U_BPT_NONE  = 0x00000000,
    U_BPT_OPEN  = 0x00000001,
    U_BPT_CLOSE = 0x00000002,
}

enum UBlockCode : int
{
    UBLOCK_NO_BLOCK                                       = 0x00000000,
    UBLOCK_BASIC_LATIN                                    = 0x00000001,
    UBLOCK_LATIN_1_SUPPLEMENT                             = 0x00000002,
    UBLOCK_LATIN_EXTENDED_A                               = 0x00000003,
    UBLOCK_LATIN_EXTENDED_B                               = 0x00000004,
    UBLOCK_IPA_EXTENSIONS                                 = 0x00000005,
    UBLOCK_SPACING_MODIFIER_LETTERS                       = 0x00000006,
    UBLOCK_COMBINING_DIACRITICAL_MARKS                    = 0x00000007,
    UBLOCK_GREEK                                          = 0x00000008,
    UBLOCK_CYRILLIC                                       = 0x00000009,
    UBLOCK_ARMENIAN                                       = 0x0000000a,
    UBLOCK_HEBREW                                         = 0x0000000b,
    UBLOCK_ARABIC                                         = 0x0000000c,
    UBLOCK_SYRIAC                                         = 0x0000000d,
    UBLOCK_THAANA                                         = 0x0000000e,
    UBLOCK_DEVANAGARI                                     = 0x0000000f,
    UBLOCK_BENGALI                                        = 0x00000010,
    UBLOCK_GURMUKHI                                       = 0x00000011,
    UBLOCK_GUJARATI                                       = 0x00000012,
    UBLOCK_ORIYA                                          = 0x00000013,
    UBLOCK_TAMIL                                          = 0x00000014,
    UBLOCK_TELUGU                                         = 0x00000015,
    UBLOCK_KANNADA                                        = 0x00000016,
    UBLOCK_MALAYALAM                                      = 0x00000017,
    UBLOCK_SINHALA                                        = 0x00000018,
    UBLOCK_THAI                                           = 0x00000019,
    UBLOCK_LAO                                            = 0x0000001a,
    UBLOCK_TIBETAN                                        = 0x0000001b,
    UBLOCK_MYANMAR                                        = 0x0000001c,
    UBLOCK_GEORGIAN                                       = 0x0000001d,
    UBLOCK_HANGUL_JAMO                                    = 0x0000001e,
    UBLOCK_ETHIOPIC                                       = 0x0000001f,
    UBLOCK_CHEROKEE                                       = 0x00000020,
    UBLOCK_UNIFIED_CANADIAN_ABORIGINAL_SYLLABICS          = 0x00000021,
    UBLOCK_OGHAM                                          = 0x00000022,
    UBLOCK_RUNIC                                          = 0x00000023,
    UBLOCK_KHMER                                          = 0x00000024,
    UBLOCK_MONGOLIAN                                      = 0x00000025,
    UBLOCK_LATIN_EXTENDED_ADDITIONAL                      = 0x00000026,
    UBLOCK_GREEK_EXTENDED                                 = 0x00000027,
    UBLOCK_GENERAL_PUNCTUATION                            = 0x00000028,
    UBLOCK_SUPERSCRIPTS_AND_SUBSCRIPTS                    = 0x00000029,
    UBLOCK_CURRENCY_SYMBOLS                               = 0x0000002a,
    UBLOCK_COMBINING_MARKS_FOR_SYMBOLS                    = 0x0000002b,
    UBLOCK_LETTERLIKE_SYMBOLS                             = 0x0000002c,
    UBLOCK_NUMBER_FORMS                                   = 0x0000002d,
    UBLOCK_ARROWS                                         = 0x0000002e,
    UBLOCK_MATHEMATICAL_OPERATORS                         = 0x0000002f,
    UBLOCK_MISCELLANEOUS_TECHNICAL                        = 0x00000030,
    UBLOCK_CONTROL_PICTURES                               = 0x00000031,
    UBLOCK_OPTICAL_CHARACTER_RECOGNITION                  = 0x00000032,
    UBLOCK_ENCLOSED_ALPHANUMERICS                         = 0x00000033,
    UBLOCK_BOX_DRAWING                                    = 0x00000034,
    UBLOCK_BLOCK_ELEMENTS                                 = 0x00000035,
    UBLOCK_GEOMETRIC_SHAPES                               = 0x00000036,
    UBLOCK_MISCELLANEOUS_SYMBOLS                          = 0x00000037,
    UBLOCK_DINGBATS                                       = 0x00000038,
    UBLOCK_BRAILLE_PATTERNS                               = 0x00000039,
    UBLOCK_CJK_RADICALS_SUPPLEMENT                        = 0x0000003a,
    UBLOCK_KANGXI_RADICALS                                = 0x0000003b,
    UBLOCK_IDEOGRAPHIC_DESCRIPTION_CHARACTERS             = 0x0000003c,
    UBLOCK_CJK_SYMBOLS_AND_PUNCTUATION                    = 0x0000003d,
    UBLOCK_HIRAGANA                                       = 0x0000003e,
    UBLOCK_KATAKANA                                       = 0x0000003f,
    UBLOCK_BOPOMOFO                                       = 0x00000040,
    UBLOCK_HANGUL_COMPATIBILITY_JAMO                      = 0x00000041,
    UBLOCK_KANBUN                                         = 0x00000042,
    UBLOCK_BOPOMOFO_EXTENDED                              = 0x00000043,
    UBLOCK_ENCLOSED_CJK_LETTERS_AND_MONTHS                = 0x00000044,
    UBLOCK_CJK_COMPATIBILITY                              = 0x00000045,
    UBLOCK_CJK_UNIFIED_IDEOGRAPHS_EXTENSION_A             = 0x00000046,
    UBLOCK_CJK_UNIFIED_IDEOGRAPHS                         = 0x00000047,
    UBLOCK_YI_SYLLABLES                                   = 0x00000048,
    UBLOCK_YI_RADICALS                                    = 0x00000049,
    UBLOCK_HANGUL_SYLLABLES                               = 0x0000004a,
    UBLOCK_HIGH_SURROGATES                                = 0x0000004b,
    UBLOCK_HIGH_PRIVATE_USE_SURROGATES                    = 0x0000004c,
    UBLOCK_LOW_SURROGATES                                 = 0x0000004d,
    UBLOCK_PRIVATE_USE_AREA                               = 0x0000004e,
    UBLOCK_PRIVATE_USE                                    = 0x0000004e,
    UBLOCK_CJK_COMPATIBILITY_IDEOGRAPHS                   = 0x0000004f,
    UBLOCK_ALPHABETIC_PRESENTATION_FORMS                  = 0x00000050,
    UBLOCK_ARABIC_PRESENTATION_FORMS_A                    = 0x00000051,
    UBLOCK_COMBINING_HALF_MARKS                           = 0x00000052,
    UBLOCK_CJK_COMPATIBILITY_FORMS                        = 0x00000053,
    UBLOCK_SMALL_FORM_VARIANTS                            = 0x00000054,
    UBLOCK_ARABIC_PRESENTATION_FORMS_B                    = 0x00000055,
    UBLOCK_SPECIALS                                       = 0x00000056,
    UBLOCK_HALFWIDTH_AND_FULLWIDTH_FORMS                  = 0x00000057,
    UBLOCK_OLD_ITALIC                                     = 0x00000058,
    UBLOCK_GOTHIC                                         = 0x00000059,
    UBLOCK_DESERET                                        = 0x0000005a,
    UBLOCK_BYZANTINE_MUSICAL_SYMBOLS                      = 0x0000005b,
    UBLOCK_MUSICAL_SYMBOLS                                = 0x0000005c,
    UBLOCK_MATHEMATICAL_ALPHANUMERIC_SYMBOLS              = 0x0000005d,
    UBLOCK_CJK_UNIFIED_IDEOGRAPHS_EXTENSION_B             = 0x0000005e,
    UBLOCK_CJK_COMPATIBILITY_IDEOGRAPHS_SUPPLEMENT        = 0x0000005f,
    UBLOCK_TAGS                                           = 0x00000060,
    UBLOCK_CYRILLIC_SUPPLEMENT                            = 0x00000061,
    UBLOCK_CYRILLIC_SUPPLEMENTARY                         = 0x00000061,
    UBLOCK_TAGALOG                                        = 0x00000062,
    UBLOCK_HANUNOO                                        = 0x00000063,
    UBLOCK_BUHID                                          = 0x00000064,
    UBLOCK_TAGBANWA                                       = 0x00000065,
    UBLOCK_MISCELLANEOUS_MATHEMATICAL_SYMBOLS_A           = 0x00000066,
    UBLOCK_SUPPLEMENTAL_ARROWS_A                          = 0x00000067,
    UBLOCK_SUPPLEMENTAL_ARROWS_B                          = 0x00000068,
    UBLOCK_MISCELLANEOUS_MATHEMATICAL_SYMBOLS_B           = 0x00000069,
    UBLOCK_SUPPLEMENTAL_MATHEMATICAL_OPERATORS            = 0x0000006a,
    UBLOCK_KATAKANA_PHONETIC_EXTENSIONS                   = 0x0000006b,
    UBLOCK_VARIATION_SELECTORS                            = 0x0000006c,
    UBLOCK_SUPPLEMENTARY_PRIVATE_USE_AREA_A               = 0x0000006d,
    UBLOCK_SUPPLEMENTARY_PRIVATE_USE_AREA_B               = 0x0000006e,
    UBLOCK_LIMBU                                          = 0x0000006f,
    UBLOCK_TAI_LE                                         = 0x00000070,
    UBLOCK_KHMER_SYMBOLS                                  = 0x00000071,
    UBLOCK_PHONETIC_EXTENSIONS                            = 0x00000072,
    UBLOCK_MISCELLANEOUS_SYMBOLS_AND_ARROWS               = 0x00000073,
    UBLOCK_YIJING_HEXAGRAM_SYMBOLS                        = 0x00000074,
    UBLOCK_LINEAR_B_SYLLABARY                             = 0x00000075,
    UBLOCK_LINEAR_B_IDEOGRAMS                             = 0x00000076,
    UBLOCK_AEGEAN_NUMBERS                                 = 0x00000077,
    UBLOCK_UGARITIC                                       = 0x00000078,
    UBLOCK_SHAVIAN                                        = 0x00000079,
    UBLOCK_OSMANYA                                        = 0x0000007a,
    UBLOCK_CYPRIOT_SYLLABARY                              = 0x0000007b,
    UBLOCK_TAI_XUAN_JING_SYMBOLS                          = 0x0000007c,
    UBLOCK_VARIATION_SELECTORS_SUPPLEMENT                 = 0x0000007d,
    UBLOCK_ANCIENT_GREEK_MUSICAL_NOTATION                 = 0x0000007e,
    UBLOCK_ANCIENT_GREEK_NUMBERS                          = 0x0000007f,
    UBLOCK_ARABIC_SUPPLEMENT                              = 0x00000080,
    UBLOCK_BUGINESE                                       = 0x00000081,
    UBLOCK_CJK_STROKES                                    = 0x00000082,
    UBLOCK_COMBINING_DIACRITICAL_MARKS_SUPPLEMENT         = 0x00000083,
    UBLOCK_COPTIC                                         = 0x00000084,
    UBLOCK_ETHIOPIC_EXTENDED                              = 0x00000085,
    UBLOCK_ETHIOPIC_SUPPLEMENT                            = 0x00000086,
    UBLOCK_GEORGIAN_SUPPLEMENT                            = 0x00000087,
    UBLOCK_GLAGOLITIC                                     = 0x00000088,
    UBLOCK_KHAROSHTHI                                     = 0x00000089,
    UBLOCK_MODIFIER_TONE_LETTERS                          = 0x0000008a,
    UBLOCK_NEW_TAI_LUE                                    = 0x0000008b,
    UBLOCK_OLD_PERSIAN                                    = 0x0000008c,
    UBLOCK_PHONETIC_EXTENSIONS_SUPPLEMENT                 = 0x0000008d,
    UBLOCK_SUPPLEMENTAL_PUNCTUATION                       = 0x0000008e,
    UBLOCK_SYLOTI_NAGRI                                   = 0x0000008f,
    UBLOCK_TIFINAGH                                       = 0x00000090,
    UBLOCK_VERTICAL_FORMS                                 = 0x00000091,
    UBLOCK_NKO                                            = 0x00000092,
    UBLOCK_BALINESE                                       = 0x00000093,
    UBLOCK_LATIN_EXTENDED_C                               = 0x00000094,
    UBLOCK_LATIN_EXTENDED_D                               = 0x00000095,
    UBLOCK_PHAGS_PA                                       = 0x00000096,
    UBLOCK_PHOENICIAN                                     = 0x00000097,
    UBLOCK_CUNEIFORM                                      = 0x00000098,
    UBLOCK_CUNEIFORM_NUMBERS_AND_PUNCTUATION              = 0x00000099,
    UBLOCK_COUNTING_ROD_NUMERALS                          = 0x0000009a,
    UBLOCK_SUNDANESE                                      = 0x0000009b,
    UBLOCK_LEPCHA                                         = 0x0000009c,
    UBLOCK_OL_CHIKI                                       = 0x0000009d,
    UBLOCK_CYRILLIC_EXTENDED_A                            = 0x0000009e,
    UBLOCK_VAI                                            = 0x0000009f,
    UBLOCK_CYRILLIC_EXTENDED_B                            = 0x000000a0,
    UBLOCK_SAURASHTRA                                     = 0x000000a1,
    UBLOCK_KAYAH_LI                                       = 0x000000a2,
    UBLOCK_REJANG                                         = 0x000000a3,
    UBLOCK_CHAM                                           = 0x000000a4,
    UBLOCK_ANCIENT_SYMBOLS                                = 0x000000a5,
    UBLOCK_PHAISTOS_DISC                                  = 0x000000a6,
    UBLOCK_LYCIAN                                         = 0x000000a7,
    UBLOCK_CARIAN                                         = 0x000000a8,
    UBLOCK_LYDIAN                                         = 0x000000a9,
    UBLOCK_MAHJONG_TILES                                  = 0x000000aa,
    UBLOCK_DOMINO_TILES                                   = 0x000000ab,
    UBLOCK_SAMARITAN                                      = 0x000000ac,
    UBLOCK_UNIFIED_CANADIAN_ABORIGINAL_SYLLABICS_EXTENDED = 0x000000ad,
    UBLOCK_TAI_THAM                                       = 0x000000ae,
    UBLOCK_VEDIC_EXTENSIONS                               = 0x000000af,
    UBLOCK_LISU                                           = 0x000000b0,
    UBLOCK_BAMUM                                          = 0x000000b1,
    UBLOCK_COMMON_INDIC_NUMBER_FORMS                      = 0x000000b2,
    UBLOCK_DEVANAGARI_EXTENDED                            = 0x000000b3,
    UBLOCK_HANGUL_JAMO_EXTENDED_A                         = 0x000000b4,
    UBLOCK_JAVANESE                                       = 0x000000b5,
    UBLOCK_MYANMAR_EXTENDED_A                             = 0x000000b6,
    UBLOCK_TAI_VIET                                       = 0x000000b7,
    UBLOCK_MEETEI_MAYEK                                   = 0x000000b8,
    UBLOCK_HANGUL_JAMO_EXTENDED_B                         = 0x000000b9,
    UBLOCK_IMPERIAL_ARAMAIC                               = 0x000000ba,
    UBLOCK_OLD_SOUTH_ARABIAN                              = 0x000000bb,
    UBLOCK_AVESTAN                                        = 0x000000bc,
    UBLOCK_INSCRIPTIONAL_PARTHIAN                         = 0x000000bd,
    UBLOCK_INSCRIPTIONAL_PAHLAVI                          = 0x000000be,
    UBLOCK_OLD_TURKIC                                     = 0x000000bf,
    UBLOCK_RUMI_NUMERAL_SYMBOLS                           = 0x000000c0,
    UBLOCK_KAITHI                                         = 0x000000c1,
    UBLOCK_EGYPTIAN_HIEROGLYPHS                           = 0x000000c2,
    UBLOCK_ENCLOSED_ALPHANUMERIC_SUPPLEMENT               = 0x000000c3,
    UBLOCK_ENCLOSED_IDEOGRAPHIC_SUPPLEMENT                = 0x000000c4,
    UBLOCK_CJK_UNIFIED_IDEOGRAPHS_EXTENSION_C             = 0x000000c5,
    UBLOCK_MANDAIC                                        = 0x000000c6,
    UBLOCK_BATAK                                          = 0x000000c7,
    UBLOCK_ETHIOPIC_EXTENDED_A                            = 0x000000c8,
    UBLOCK_BRAHMI                                         = 0x000000c9,
    UBLOCK_BAMUM_SUPPLEMENT                               = 0x000000ca,
    UBLOCK_KANA_SUPPLEMENT                                = 0x000000cb,
    UBLOCK_PLAYING_CARDS                                  = 0x000000cc,
    UBLOCK_MISCELLANEOUS_SYMBOLS_AND_PICTOGRAPHS          = 0x000000cd,
    UBLOCK_EMOTICONS                                      = 0x000000ce,
    UBLOCK_TRANSPORT_AND_MAP_SYMBOLS                      = 0x000000cf,
    UBLOCK_ALCHEMICAL_SYMBOLS                             = 0x000000d0,
    UBLOCK_CJK_UNIFIED_IDEOGRAPHS_EXTENSION_D             = 0x000000d1,
    UBLOCK_ARABIC_EXTENDED_A                              = 0x000000d2,
    UBLOCK_ARABIC_MATHEMATICAL_ALPHABETIC_SYMBOLS         = 0x000000d3,
    UBLOCK_CHAKMA                                         = 0x000000d4,
    UBLOCK_MEETEI_MAYEK_EXTENSIONS                        = 0x000000d5,
    UBLOCK_MEROITIC_CURSIVE                               = 0x000000d6,
    UBLOCK_MEROITIC_HIEROGLYPHS                           = 0x000000d7,
    UBLOCK_MIAO                                           = 0x000000d8,
    UBLOCK_SHARADA                                        = 0x000000d9,
    UBLOCK_SORA_SOMPENG                                   = 0x000000da,
    UBLOCK_SUNDANESE_SUPPLEMENT                           = 0x000000db,
    UBLOCK_TAKRI                                          = 0x000000dc,
    UBLOCK_BASSA_VAH                                      = 0x000000dd,
    UBLOCK_CAUCASIAN_ALBANIAN                             = 0x000000de,
    UBLOCK_COPTIC_EPACT_NUMBERS                           = 0x000000df,
    UBLOCK_COMBINING_DIACRITICAL_MARKS_EXTENDED           = 0x000000e0,
    UBLOCK_DUPLOYAN                                       = 0x000000e1,
    UBLOCK_ELBASAN                                        = 0x000000e2,
    UBLOCK_GEOMETRIC_SHAPES_EXTENDED                      = 0x000000e3,
    UBLOCK_GRANTHA                                        = 0x000000e4,
    UBLOCK_KHOJKI                                         = 0x000000e5,
    UBLOCK_KHUDAWADI                                      = 0x000000e6,
    UBLOCK_LATIN_EXTENDED_E                               = 0x000000e7,
    UBLOCK_LINEAR_A                                       = 0x000000e8,
    UBLOCK_MAHAJANI                                       = 0x000000e9,
    UBLOCK_MANICHAEAN                                     = 0x000000ea,
    UBLOCK_MENDE_KIKAKUI                                  = 0x000000eb,
    UBLOCK_MODI                                           = 0x000000ec,
    UBLOCK_MRO                                            = 0x000000ed,
    UBLOCK_MYANMAR_EXTENDED_B                             = 0x000000ee,
    UBLOCK_NABATAEAN                                      = 0x000000ef,
    UBLOCK_OLD_NORTH_ARABIAN                              = 0x000000f0,
    UBLOCK_OLD_PERMIC                                     = 0x000000f1,
    UBLOCK_ORNAMENTAL_DINGBATS                            = 0x000000f2,
    UBLOCK_PAHAWH_HMONG                                   = 0x000000f3,
    UBLOCK_PALMYRENE                                      = 0x000000f4,
    UBLOCK_PAU_CIN_HAU                                    = 0x000000f5,
    UBLOCK_PSALTER_PAHLAVI                                = 0x000000f6,
    UBLOCK_SHORTHAND_FORMAT_CONTROLS                      = 0x000000f7,
    UBLOCK_SIDDHAM                                        = 0x000000f8,
    UBLOCK_SINHALA_ARCHAIC_NUMBERS                        = 0x000000f9,
    UBLOCK_SUPPLEMENTAL_ARROWS_C                          = 0x000000fa,
    UBLOCK_TIRHUTA                                        = 0x000000fb,
    UBLOCK_WARANG_CITI                                    = 0x000000fc,
    UBLOCK_AHOM                                           = 0x000000fd,
    UBLOCK_ANATOLIAN_HIEROGLYPHS                          = 0x000000fe,
    UBLOCK_CHEROKEE_SUPPLEMENT                            = 0x000000ff,
    UBLOCK_CJK_UNIFIED_IDEOGRAPHS_EXTENSION_E             = 0x00000100,
    UBLOCK_EARLY_DYNASTIC_CUNEIFORM                       = 0x00000101,
    UBLOCK_HATRAN                                         = 0x00000102,
    UBLOCK_MULTANI                                        = 0x00000103,
    UBLOCK_OLD_HUNGARIAN                                  = 0x00000104,
    UBLOCK_SUPPLEMENTAL_SYMBOLS_AND_PICTOGRAPHS           = 0x00000105,
    UBLOCK_SUTTON_SIGNWRITING                             = 0x00000106,
    UBLOCK_ADLAM                                          = 0x00000107,
    UBLOCK_BHAIKSUKI                                      = 0x00000108,
    UBLOCK_CYRILLIC_EXTENDED_C                            = 0x00000109,
    UBLOCK_GLAGOLITIC_SUPPLEMENT                          = 0x0000010a,
    UBLOCK_IDEOGRAPHIC_SYMBOLS_AND_PUNCTUATION            = 0x0000010b,
    UBLOCK_MARCHEN                                        = 0x0000010c,
    UBLOCK_MONGOLIAN_SUPPLEMENT                           = 0x0000010d,
    UBLOCK_NEWA                                           = 0x0000010e,
    UBLOCK_OSAGE                                          = 0x0000010f,
    UBLOCK_TANGUT                                         = 0x00000110,
    UBLOCK_TANGUT_COMPONENTS                              = 0x00000111,
    UBLOCK_CJK_UNIFIED_IDEOGRAPHS_EXTENSION_F             = 0x00000112,
    UBLOCK_KANA_EXTENDED_A                                = 0x00000113,
    UBLOCK_MASARAM_GONDI                                  = 0x00000114,
    UBLOCK_NUSHU                                          = 0x00000115,
    UBLOCK_SOYOMBO                                        = 0x00000116,
    UBLOCK_SYRIAC_SUPPLEMENT                              = 0x00000117,
    UBLOCK_ZANABAZAR_SQUARE                               = 0x00000118,
    UBLOCK_CHESS_SYMBOLS                                  = 0x00000119,
    UBLOCK_DOGRA                                          = 0x0000011a,
    UBLOCK_GEORGIAN_EXTENDED                              = 0x0000011b,
    UBLOCK_GUNJALA_GONDI                                  = 0x0000011c,
    UBLOCK_HANIFI_ROHINGYA                                = 0x0000011d,
    UBLOCK_INDIC_SIYAQ_NUMBERS                            = 0x0000011e,
    UBLOCK_MAKASAR                                        = 0x0000011f,
    UBLOCK_MAYAN_NUMERALS                                 = 0x00000120,
    UBLOCK_MEDEFAIDRIN                                    = 0x00000121,
    UBLOCK_OLD_SOGDIAN                                    = 0x00000122,
    UBLOCK_SOGDIAN                                        = 0x00000123,
    UBLOCK_EGYPTIAN_HIEROGLYPH_FORMAT_CONTROLS            = 0x00000124,
    UBLOCK_ELYMAIC                                        = 0x00000125,
    UBLOCK_NANDINAGARI                                    = 0x00000126,
    UBLOCK_NYIAKENG_PUACHUE_HMONG                         = 0x00000127,
    UBLOCK_OTTOMAN_SIYAQ_NUMBERS                          = 0x00000128,
    UBLOCK_SMALL_KANA_EXTENSION                           = 0x00000129,
    UBLOCK_SYMBOLS_AND_PICTOGRAPHS_EXTENDED_A             = 0x0000012a,
    UBLOCK_TAMIL_SUPPLEMENT                               = 0x0000012b,
    UBLOCK_WANCHO                                         = 0x0000012c,
    UBLOCK_INVALID_CODE                                   = 0xffffffff,
}

enum UEastAsianWidth : int
{
    U_EA_NEUTRAL   = 0x00000000,
    U_EA_AMBIGUOUS = 0x00000001,
    U_EA_HALFWIDTH = 0x00000002,
    U_EA_FULLWIDTH = 0x00000003,
    U_EA_NARROW    = 0x00000004,
    U_EA_WIDE      = 0x00000005,
}

enum UCharNameChoice : int
{
    U_UNICODE_CHAR_NAME  = 0x00000000,
    U_EXTENDED_CHAR_NAME = 0x00000002,
    U_CHAR_NAME_ALIAS    = 0x00000003,
}

enum UPropertyNameChoice : int
{
    U_SHORT_PROPERTY_NAME = 0x00000000,
    U_LONG_PROPERTY_NAME  = 0x00000001,
}

enum UDecompositionType : int
{
    U_DT_NONE      = 0x00000000,
    U_DT_CANONICAL = 0x00000001,
    U_DT_COMPAT    = 0x00000002,
    U_DT_CIRCLE    = 0x00000003,
    U_DT_FINAL     = 0x00000004,
    U_DT_FONT      = 0x00000005,
    U_DT_FRACTION  = 0x00000006,
    U_DT_INITIAL   = 0x00000007,
    U_DT_ISOLATED  = 0x00000008,
    U_DT_MEDIAL    = 0x00000009,
    U_DT_NARROW    = 0x0000000a,
    U_DT_NOBREAK   = 0x0000000b,
    U_DT_SMALL     = 0x0000000c,
    U_DT_SQUARE    = 0x0000000d,
    U_DT_SUB       = 0x0000000e,
    U_DT_SUPER     = 0x0000000f,
    U_DT_VERTICAL  = 0x00000010,
    U_DT_WIDE      = 0x00000011,
}

enum UJoiningType : int
{
    U_JT_NON_JOINING   = 0x00000000,
    U_JT_JOIN_CAUSING  = 0x00000001,
    U_JT_DUAL_JOINING  = 0x00000002,
    U_JT_LEFT_JOINING  = 0x00000003,
    U_JT_RIGHT_JOINING = 0x00000004,
    U_JT_TRANSPARENT   = 0x00000005,
}

enum UJoiningGroup : int
{
    U_JG_NO_JOINING_GROUP         = 0x00000000,
    U_JG_AIN                      = 0x00000001,
    U_JG_ALAPH                    = 0x00000002,
    U_JG_ALEF                     = 0x00000003,
    U_JG_BEH                      = 0x00000004,
    U_JG_BETH                     = 0x00000005,
    U_JG_DAL                      = 0x00000006,
    U_JG_DALATH_RISH              = 0x00000007,
    U_JG_E                        = 0x00000008,
    U_JG_FEH                      = 0x00000009,
    U_JG_FINAL_SEMKATH            = 0x0000000a,
    U_JG_GAF                      = 0x0000000b,
    U_JG_GAMAL                    = 0x0000000c,
    U_JG_HAH                      = 0x0000000d,
    U_JG_TEH_MARBUTA_GOAL         = 0x0000000e,
    U_JG_HAMZA_ON_HEH_GOAL        = 0x0000000e,
    U_JG_HE                       = 0x0000000f,
    U_JG_HEH                      = 0x00000010,
    U_JG_HEH_GOAL                 = 0x00000011,
    U_JG_HETH                     = 0x00000012,
    U_JG_KAF                      = 0x00000013,
    U_JG_KAPH                     = 0x00000014,
    U_JG_KNOTTED_HEH              = 0x00000015,
    U_JG_LAM                      = 0x00000016,
    U_JG_LAMADH                   = 0x00000017,
    U_JG_MEEM                     = 0x00000018,
    U_JG_MIM                      = 0x00000019,
    U_JG_NOON                     = 0x0000001a,
    U_JG_NUN                      = 0x0000001b,
    U_JG_PE                       = 0x0000001c,
    U_JG_QAF                      = 0x0000001d,
    U_JG_QAPH                     = 0x0000001e,
    U_JG_REH                      = 0x0000001f,
    U_JG_REVERSED_PE              = 0x00000020,
    U_JG_SAD                      = 0x00000021,
    U_JG_SADHE                    = 0x00000022,
    U_JG_SEEN                     = 0x00000023,
    U_JG_SEMKATH                  = 0x00000024,
    U_JG_SHIN                     = 0x00000025,
    U_JG_SWASH_KAF                = 0x00000026,
    U_JG_SYRIAC_WAW               = 0x00000027,
    U_JG_TAH                      = 0x00000028,
    U_JG_TAW                      = 0x00000029,
    U_JG_TEH_MARBUTA              = 0x0000002a,
    U_JG_TETH                     = 0x0000002b,
    U_JG_WAW                      = 0x0000002c,
    U_JG_YEH                      = 0x0000002d,
    U_JG_YEH_BARREE               = 0x0000002e,
    U_JG_YEH_WITH_TAIL            = 0x0000002f,
    U_JG_YUDH                     = 0x00000030,
    U_JG_YUDH_HE                  = 0x00000031,
    U_JG_ZAIN                     = 0x00000032,
    U_JG_FE                       = 0x00000033,
    U_JG_KHAPH                    = 0x00000034,
    U_JG_ZHAIN                    = 0x00000035,
    U_JG_BURUSHASKI_YEH_BARREE    = 0x00000036,
    U_JG_FARSI_YEH                = 0x00000037,
    U_JG_NYA                      = 0x00000038,
    U_JG_ROHINGYA_YEH             = 0x00000039,
    U_JG_MANICHAEAN_ALEPH         = 0x0000003a,
    U_JG_MANICHAEAN_AYIN          = 0x0000003b,
    U_JG_MANICHAEAN_BETH          = 0x0000003c,
    U_JG_MANICHAEAN_DALETH        = 0x0000003d,
    U_JG_MANICHAEAN_DHAMEDH       = 0x0000003e,
    U_JG_MANICHAEAN_FIVE          = 0x0000003f,
    U_JG_MANICHAEAN_GIMEL         = 0x00000040,
    U_JG_MANICHAEAN_HETH          = 0x00000041,
    U_JG_MANICHAEAN_HUNDRED       = 0x00000042,
    U_JG_MANICHAEAN_KAPH          = 0x00000043,
    U_JG_MANICHAEAN_LAMEDH        = 0x00000044,
    U_JG_MANICHAEAN_MEM           = 0x00000045,
    U_JG_MANICHAEAN_NUN           = 0x00000046,
    U_JG_MANICHAEAN_ONE           = 0x00000047,
    U_JG_MANICHAEAN_PE            = 0x00000048,
    U_JG_MANICHAEAN_QOPH          = 0x00000049,
    U_JG_MANICHAEAN_RESH          = 0x0000004a,
    U_JG_MANICHAEAN_SADHE         = 0x0000004b,
    U_JG_MANICHAEAN_SAMEKH        = 0x0000004c,
    U_JG_MANICHAEAN_TAW           = 0x0000004d,
    U_JG_MANICHAEAN_TEN           = 0x0000004e,
    U_JG_MANICHAEAN_TETH          = 0x0000004f,
    U_JG_MANICHAEAN_THAMEDH       = 0x00000050,
    U_JG_MANICHAEAN_TWENTY        = 0x00000051,
    U_JG_MANICHAEAN_WAW           = 0x00000052,
    U_JG_MANICHAEAN_YODH          = 0x00000053,
    U_JG_MANICHAEAN_ZAYIN         = 0x00000054,
    U_JG_STRAIGHT_WAW             = 0x00000055,
    U_JG_AFRICAN_FEH              = 0x00000056,
    U_JG_AFRICAN_NOON             = 0x00000057,
    U_JG_AFRICAN_QAF              = 0x00000058,
    U_JG_MALAYALAM_BHA            = 0x00000059,
    U_JG_MALAYALAM_JA             = 0x0000005a,
    U_JG_MALAYALAM_LLA            = 0x0000005b,
    U_JG_MALAYALAM_LLLA           = 0x0000005c,
    U_JG_MALAYALAM_NGA            = 0x0000005d,
    U_JG_MALAYALAM_NNA            = 0x0000005e,
    U_JG_MALAYALAM_NNNA           = 0x0000005f,
    U_JG_MALAYALAM_NYA            = 0x00000060,
    U_JG_MALAYALAM_RA             = 0x00000061,
    U_JG_MALAYALAM_SSA            = 0x00000062,
    U_JG_MALAYALAM_TTA            = 0x00000063,
    U_JG_HANIFI_ROHINGYA_KINNA_YA = 0x00000064,
    U_JG_HANIFI_ROHINGYA_PA       = 0x00000065,
}

enum UGraphemeClusterBreak : int
{
    U_GCB_OTHER              = 0x00000000,
    U_GCB_CONTROL            = 0x00000001,
    U_GCB_CR                 = 0x00000002,
    U_GCB_EXTEND             = 0x00000003,
    U_GCB_L                  = 0x00000004,
    U_GCB_LF                 = 0x00000005,
    U_GCB_LV                 = 0x00000006,
    U_GCB_LVT                = 0x00000007,
    U_GCB_T                  = 0x00000008,
    U_GCB_V                  = 0x00000009,
    U_GCB_SPACING_MARK       = 0x0000000a,
    U_GCB_PREPEND            = 0x0000000b,
    U_GCB_REGIONAL_INDICATOR = 0x0000000c,
    U_GCB_E_BASE             = 0x0000000d,
    U_GCB_E_BASE_GAZ         = 0x0000000e,
    U_GCB_E_MODIFIER         = 0x0000000f,
    U_GCB_GLUE_AFTER_ZWJ     = 0x00000010,
    U_GCB_ZWJ                = 0x00000011,
}

enum UWordBreakValues : int
{
    U_WB_OTHER              = 0x00000000,
    U_WB_ALETTER            = 0x00000001,
    U_WB_FORMAT             = 0x00000002,
    U_WB_KATAKANA           = 0x00000003,
    U_WB_MIDLETTER          = 0x00000004,
    U_WB_MIDNUM             = 0x00000005,
    U_WB_NUMERIC            = 0x00000006,
    U_WB_EXTENDNUMLET       = 0x00000007,
    U_WB_CR                 = 0x00000008,
    U_WB_EXTEND             = 0x00000009,
    U_WB_LF                 = 0x0000000a,
    U_WB_MIDNUMLET          = 0x0000000b,
    U_WB_NEWLINE            = 0x0000000c,
    U_WB_REGIONAL_INDICATOR = 0x0000000d,
    U_WB_HEBREW_LETTER      = 0x0000000e,
    U_WB_SINGLE_QUOTE       = 0x0000000f,
    U_WB_DOUBLE_QUOTE       = 0x00000010,
    U_WB_E_BASE             = 0x00000011,
    U_WB_E_BASE_GAZ         = 0x00000012,
    U_WB_E_MODIFIER         = 0x00000013,
    U_WB_GLUE_AFTER_ZWJ     = 0x00000014,
    U_WB_ZWJ                = 0x00000015,
    U_WB_WSEGSPACE          = 0x00000016,
}

enum USentenceBreak : int
{
    U_SB_OTHER     = 0x00000000,
    U_SB_ATERM     = 0x00000001,
    U_SB_CLOSE     = 0x00000002,
    U_SB_FORMAT    = 0x00000003,
    U_SB_LOWER     = 0x00000004,
    U_SB_NUMERIC   = 0x00000005,
    U_SB_OLETTER   = 0x00000006,
    U_SB_SEP       = 0x00000007,
    U_SB_SP        = 0x00000008,
    U_SB_STERM     = 0x00000009,
    U_SB_UPPER     = 0x0000000a,
    U_SB_CR        = 0x0000000b,
    U_SB_EXTEND    = 0x0000000c,
    U_SB_LF        = 0x0000000d,
    U_SB_SCONTINUE = 0x0000000e,
}

enum ULineBreak : int
{
    U_LB_UNKNOWN                      = 0x00000000,
    U_LB_AMBIGUOUS                    = 0x00000001,
    U_LB_ALPHABETIC                   = 0x00000002,
    U_LB_BREAK_BOTH                   = 0x00000003,
    U_LB_BREAK_AFTER                  = 0x00000004,
    U_LB_BREAK_BEFORE                 = 0x00000005,
    U_LB_MANDATORY_BREAK              = 0x00000006,
    U_LB_CONTINGENT_BREAK             = 0x00000007,
    U_LB_CLOSE_PUNCTUATION            = 0x00000008,
    U_LB_COMBINING_MARK               = 0x00000009,
    U_LB_CARRIAGE_RETURN              = 0x0000000a,
    U_LB_EXCLAMATION                  = 0x0000000b,
    U_LB_GLUE                         = 0x0000000c,
    U_LB_HYPHEN                       = 0x0000000d,
    U_LB_IDEOGRAPHIC                  = 0x0000000e,
    U_LB_INSEPARABLE                  = 0x0000000f,
    U_LB_INSEPERABLE                  = 0x0000000f,
    U_LB_INFIX_NUMERIC                = 0x00000010,
    U_LB_LINE_FEED                    = 0x00000011,
    U_LB_NONSTARTER                   = 0x00000012,
    U_LB_NUMERIC                      = 0x00000013,
    U_LB_OPEN_PUNCTUATION             = 0x00000014,
    U_LB_POSTFIX_NUMERIC              = 0x00000015,
    U_LB_PREFIX_NUMERIC               = 0x00000016,
    U_LB_QUOTATION                    = 0x00000017,
    U_LB_COMPLEX_CONTEXT              = 0x00000018,
    U_LB_SURROGATE                    = 0x00000019,
    U_LB_SPACE                        = 0x0000001a,
    U_LB_BREAK_SYMBOLS                = 0x0000001b,
    U_LB_ZWSPACE                      = 0x0000001c,
    U_LB_NEXT_LINE                    = 0x0000001d,
    U_LB_WORD_JOINER                  = 0x0000001e,
    U_LB_H2                           = 0x0000001f,
    U_LB_H3                           = 0x00000020,
    U_LB_JL                           = 0x00000021,
    U_LB_JT                           = 0x00000022,
    U_LB_JV                           = 0x00000023,
    U_LB_CLOSE_PARENTHESIS            = 0x00000024,
    U_LB_CONDITIONAL_JAPANESE_STARTER = 0x00000025,
    U_LB_HEBREW_LETTER                = 0x00000026,
    U_LB_REGIONAL_INDICATOR           = 0x00000027,
    U_LB_E_BASE                       = 0x00000028,
    U_LB_E_MODIFIER                   = 0x00000029,
    U_LB_ZWJ                          = 0x0000002a,
}

enum UNumericType : int
{
    U_NT_NONE    = 0x00000000,
    U_NT_DECIMAL = 0x00000001,
    U_NT_DIGIT   = 0x00000002,
    U_NT_NUMERIC = 0x00000003,
}

enum UHangulSyllableType : int
{
    U_HST_NOT_APPLICABLE = 0x00000000,
    U_HST_LEADING_JAMO   = 0x00000001,
    U_HST_VOWEL_JAMO     = 0x00000002,
    U_HST_TRAILING_JAMO  = 0x00000003,
    U_HST_LV_SYLLABLE    = 0x00000004,
    U_HST_LVT_SYLLABLE   = 0x00000005,
}

enum UIndicPositionalCategory : int
{
    U_INPC_NA                       = 0x00000000,
    U_INPC_BOTTOM                   = 0x00000001,
    U_INPC_BOTTOM_AND_LEFT          = 0x00000002,
    U_INPC_BOTTOM_AND_RIGHT         = 0x00000003,
    U_INPC_LEFT                     = 0x00000004,
    U_INPC_LEFT_AND_RIGHT           = 0x00000005,
    U_INPC_OVERSTRUCK               = 0x00000006,
    U_INPC_RIGHT                    = 0x00000007,
    U_INPC_TOP                      = 0x00000008,
    U_INPC_TOP_AND_BOTTOM           = 0x00000009,
    U_INPC_TOP_AND_BOTTOM_AND_RIGHT = 0x0000000a,
    U_INPC_TOP_AND_LEFT             = 0x0000000b,
    U_INPC_TOP_AND_LEFT_AND_RIGHT   = 0x0000000c,
    U_INPC_TOP_AND_RIGHT            = 0x0000000d,
    U_INPC_VISUAL_ORDER_LEFT        = 0x0000000e,
}

enum UIndicSyllabicCategory : int
{
    U_INSC_OTHER                       = 0x00000000,
    U_INSC_AVAGRAHA                    = 0x00000001,
    U_INSC_BINDU                       = 0x00000002,
    U_INSC_BRAHMI_JOINING_NUMBER       = 0x00000003,
    U_INSC_CANTILLATION_MARK           = 0x00000004,
    U_INSC_CONSONANT                   = 0x00000005,
    U_INSC_CONSONANT_DEAD              = 0x00000006,
    U_INSC_CONSONANT_FINAL             = 0x00000007,
    U_INSC_CONSONANT_HEAD_LETTER       = 0x00000008,
    U_INSC_CONSONANT_INITIAL_POSTFIXED = 0x00000009,
    U_INSC_CONSONANT_KILLER            = 0x0000000a,
    U_INSC_CONSONANT_MEDIAL            = 0x0000000b,
    U_INSC_CONSONANT_PLACEHOLDER       = 0x0000000c,
    U_INSC_CONSONANT_PRECEDING_REPHA   = 0x0000000d,
    U_INSC_CONSONANT_PREFIXED          = 0x0000000e,
    U_INSC_CONSONANT_SUBJOINED         = 0x0000000f,
    U_INSC_CONSONANT_SUCCEEDING_REPHA  = 0x00000010,
    U_INSC_CONSONANT_WITH_STACKER      = 0x00000011,
    U_INSC_GEMINATION_MARK             = 0x00000012,
    U_INSC_INVISIBLE_STACKER           = 0x00000013,
    U_INSC_JOINER                      = 0x00000014,
    U_INSC_MODIFYING_LETTER            = 0x00000015,
    U_INSC_NON_JOINER                  = 0x00000016,
    U_INSC_NUKTA                       = 0x00000017,
    U_INSC_NUMBER                      = 0x00000018,
    U_INSC_NUMBER_JOINER               = 0x00000019,
    U_INSC_PURE_KILLER                 = 0x0000001a,
    U_INSC_REGISTER_SHIFTER            = 0x0000001b,
    U_INSC_SYLLABLE_MODIFIER           = 0x0000001c,
    U_INSC_TONE_LETTER                 = 0x0000001d,
    U_INSC_TONE_MARK                   = 0x0000001e,
    U_INSC_VIRAMA                      = 0x0000001f,
    U_INSC_VISARGA                     = 0x00000020,
    U_INSC_VOWEL                       = 0x00000021,
    U_INSC_VOWEL_DEPENDENT             = 0x00000022,
    U_INSC_VOWEL_INDEPENDENT           = 0x00000023,
}

enum UVerticalOrientation : int
{
    U_VO_ROTATED             = 0x00000000,
    U_VO_TRANSFORMED_ROTATED = 0x00000001,
    U_VO_TRANSFORMED_UPRIGHT = 0x00000002,
    U_VO_UPRIGHT             = 0x00000003,
}

enum UBiDiDirection : int
{
    UBIDI_LTR     = 0x00000000,
    UBIDI_RTL     = 0x00000001,
    UBIDI_MIXED   = 0x00000002,
    UBIDI_NEUTRAL = 0x00000003,
}

enum UBiDiReorderingMode : int
{
    UBIDI_REORDER_DEFAULT                     = 0x00000000,
    UBIDI_REORDER_NUMBERS_SPECIAL             = 0x00000001,
    UBIDI_REORDER_GROUP_NUMBERS_WITH_R        = 0x00000002,
    UBIDI_REORDER_RUNS_ONLY                   = 0x00000003,
    UBIDI_REORDER_INVERSE_NUMBERS_AS_L        = 0x00000004,
    UBIDI_REORDER_INVERSE_LIKE_DIRECT         = 0x00000005,
    UBIDI_REORDER_INVERSE_FOR_NUMBERS_SPECIAL = 0x00000006,
}

enum UBiDiReorderingOption : int
{
    UBIDI_OPTION_DEFAULT         = 0x00000000,
    UBIDI_OPTION_INSERT_MARKS    = 0x00000001,
    UBIDI_OPTION_REMOVE_CONTROLS = 0x00000002,
    UBIDI_OPTION_STREAMING       = 0x00000004,
}

enum UBiDiOrder : int
{
    UBIDI_LOGICAL = 0x00000000,
    UBIDI_VISUAL  = 0x00000001,
}

enum UBiDiMirroring : int
{
    UBIDI_MIRRORING_OFF = 0x00000000,
    UBIDI_MIRRORING_ON  = 0x00000001,
}

enum USetSpanCondition : int
{
    USET_SPAN_NOT_CONTAINED = 0x00000000,
    USET_SPAN_CONTAINED     = 0x00000001,
    USET_SPAN_SIMPLE        = 0x00000002,
}

enum UNormalization2Mode : int
{
    UNORM2_COMPOSE            = 0x00000000,
    UNORM2_DECOMPOSE          = 0x00000001,
    UNORM2_FCD                = 0x00000002,
    UNORM2_COMPOSE_CONTIGUOUS = 0x00000003,
}

enum UNormalizationCheckResult : int
{
    UNORM_NO    = 0x00000000,
    UNORM_YES   = 0x00000001,
    UNORM_MAYBE = 0x00000002,
}

enum UNormalizationMode : int
{
    UNORM_NONE       = 0x00000001,
    UNORM_NFD        = 0x00000002,
    UNORM_NFKD       = 0x00000003,
    UNORM_NFC        = 0x00000004,
    UNORM_DEFAULT    = 0x00000004,
    UNORM_NFKC       = 0x00000005,
    UNORM_FCD        = 0x00000006,
    UNORM_MODE_COUNT = 0x00000007,
}

enum UStringPrepProfileType : int
{
    USPREP_RFC3491_NAMEPREP               = 0x00000000,
    USPREP_RFC3530_NFS4_CS_PREP           = 0x00000001,
    USPREP_RFC3530_NFS4_CS_PREP_CI        = 0x00000002,
    USPREP_RFC3530_NFS4_CIS_PREP          = 0x00000003,
    USPREP_RFC3530_NFS4_MIXED_PREP_PREFIX = 0x00000004,
    USPREP_RFC3530_NFS4_MIXED_PREP_SUFFIX = 0x00000005,
    USPREP_RFC3722_ISCSI                  = 0x00000006,
    USPREP_RFC3920_NODEPREP               = 0x00000007,
    USPREP_RFC3920_RESOURCEPREP           = 0x00000008,
    USPREP_RFC4011_MIB                    = 0x00000009,
    USPREP_RFC4013_SASLPREP               = 0x0000000a,
    USPREP_RFC4505_TRACE                  = 0x0000000b,
    USPREP_RFC4518_LDAP                   = 0x0000000c,
    USPREP_RFC4518_LDAP_CI                = 0x0000000d,
}

enum UBreakIteratorType : int
{
    UBRK_CHARACTER = 0x00000000,
    UBRK_WORD      = 0x00000001,
    UBRK_LINE      = 0x00000002,
    UBRK_SENTENCE  = 0x00000003,
}

enum UWordBreak : int
{
    UBRK_WORD_NONE         = 0x00000000,
    UBRK_WORD_NONE_LIMIT   = 0x00000064,
    UBRK_WORD_NUMBER       = 0x00000064,
    UBRK_WORD_NUMBER_LIMIT = 0x000000c8,
    UBRK_WORD_LETTER       = 0x000000c8,
    UBRK_WORD_LETTER_LIMIT = 0x0000012c,
    UBRK_WORD_KANA         = 0x0000012c,
    UBRK_WORD_KANA_LIMIT   = 0x00000190,
    UBRK_WORD_IDEO         = 0x00000190,
    UBRK_WORD_IDEO_LIMIT   = 0x000001f4,
}

enum ULineBreakTag : int
{
    UBRK_LINE_SOFT       = 0x00000000,
    UBRK_LINE_SOFT_LIMIT = 0x00000064,
    UBRK_LINE_HARD       = 0x00000064,
    UBRK_LINE_HARD_LIMIT = 0x000000c8,
}

enum USentenceBreakTag : int
{
    UBRK_SENTENCE_TERM       = 0x00000000,
    UBRK_SENTENCE_TERM_LIMIT = 0x00000064,
    UBRK_SENTENCE_SEP        = 0x00000064,
    UBRK_SENTENCE_SEP_LIMIT  = 0x000000c8,
}

enum UCalendarType : int
{
    UCAL_TRADITIONAL = 0x00000000,
    UCAL_DEFAULT     = 0x00000000,
    UCAL_GREGORIAN   = 0x00000001,
}

enum UCalendarDateFields : int
{
    UCAL_ERA                  = 0x00000000,
    UCAL_YEAR                 = 0x00000001,
    UCAL_MONTH                = 0x00000002,
    UCAL_WEEK_OF_YEAR         = 0x00000003,
    UCAL_WEEK_OF_MONTH        = 0x00000004,
    UCAL_DATE                 = 0x00000005,
    UCAL_DAY_OF_YEAR          = 0x00000006,
    UCAL_DAY_OF_WEEK          = 0x00000007,
    UCAL_DAY_OF_WEEK_IN_MONTH = 0x00000008,
    UCAL_AM_PM                = 0x00000009,
    UCAL_HOUR                 = 0x0000000a,
    UCAL_HOUR_OF_DAY          = 0x0000000b,
    UCAL_MINUTE               = 0x0000000c,
    UCAL_SECOND               = 0x0000000d,
    UCAL_MILLISECOND          = 0x0000000e,
    UCAL_ZONE_OFFSET          = 0x0000000f,
    UCAL_DST_OFFSET           = 0x00000010,
    UCAL_YEAR_WOY             = 0x00000011,
    UCAL_DOW_LOCAL            = 0x00000012,
    UCAL_EXTENDED_YEAR        = 0x00000013,
    UCAL_JULIAN_DAY           = 0x00000014,
    UCAL_MILLISECONDS_IN_DAY  = 0x00000015,
    UCAL_IS_LEAP_MONTH        = 0x00000016,
    UCAL_FIELD_COUNT          = 0x00000017,
    UCAL_DAY_OF_MONTH         = 0x00000005,
}

enum UCalendarDaysOfWeek : int
{
    UCAL_SUNDAY    = 0x00000001,
    UCAL_MONDAY    = 0x00000002,
    UCAL_TUESDAY   = 0x00000003,
    UCAL_WEDNESDAY = 0x00000004,
    UCAL_THURSDAY  = 0x00000005,
    UCAL_FRIDAY    = 0x00000006,
    UCAL_SATURDAY  = 0x00000007,
}

enum UCalendarMonths : int
{
    UCAL_JANUARY    = 0x00000000,
    UCAL_FEBRUARY   = 0x00000001,
    UCAL_MARCH      = 0x00000002,
    UCAL_APRIL      = 0x00000003,
    UCAL_MAY        = 0x00000004,
    UCAL_JUNE       = 0x00000005,
    UCAL_JULY       = 0x00000006,
    UCAL_AUGUST     = 0x00000007,
    UCAL_SEPTEMBER  = 0x00000008,
    UCAL_OCTOBER    = 0x00000009,
    UCAL_NOVEMBER   = 0x0000000a,
    UCAL_DECEMBER   = 0x0000000b,
    UCAL_UNDECIMBER = 0x0000000c,
}

enum UCalendarAMPMs : int
{
    UCAL_AM = 0x00000000,
    UCAL_PM = 0x00000001,
}

enum USystemTimeZoneType : int
{
    UCAL_ZONE_TYPE_ANY                = 0x00000000,
    UCAL_ZONE_TYPE_CANONICAL          = 0x00000001,
    UCAL_ZONE_TYPE_CANONICAL_LOCATION = 0x00000002,
}

enum UCalendarDisplayNameType : int
{
    UCAL_STANDARD       = 0x00000000,
    UCAL_SHORT_STANDARD = 0x00000001,
    UCAL_DST            = 0x00000002,
    UCAL_SHORT_DST      = 0x00000003,
}

enum UCalendarAttribute : int
{
    UCAL_LENIENT                    = 0x00000000,
    UCAL_FIRST_DAY_OF_WEEK          = 0x00000001,
    UCAL_MINIMAL_DAYS_IN_FIRST_WEEK = 0x00000002,
    UCAL_REPEATED_WALL_TIME         = 0x00000003,
    UCAL_SKIPPED_WALL_TIME          = 0x00000004,
}

enum UCalendarWallTimeOption : int
{
    UCAL_WALLTIME_LAST       = 0x00000000,
    UCAL_WALLTIME_FIRST      = 0x00000001,
    UCAL_WALLTIME_NEXT_VALID = 0x00000002,
}

enum UCalendarLimitType : int
{
    UCAL_MINIMUM          = 0x00000000,
    UCAL_MAXIMUM          = 0x00000001,
    UCAL_GREATEST_MINIMUM = 0x00000002,
    UCAL_LEAST_MAXIMUM    = 0x00000003,
    UCAL_ACTUAL_MINIMUM   = 0x00000004,
    UCAL_ACTUAL_MAXIMUM   = 0x00000005,
}

enum UCalendarWeekdayType : int
{
    UCAL_WEEKDAY       = 0x00000000,
    UCAL_WEEKEND       = 0x00000001,
    UCAL_WEEKEND_ONSET = 0x00000002,
    UCAL_WEEKEND_CEASE = 0x00000003,
}

enum UTimeZoneTransitionType : int
{
    UCAL_TZ_TRANSITION_NEXT               = 0x00000000,
    UCAL_TZ_TRANSITION_NEXT_INCLUSIVE     = 0x00000001,
    UCAL_TZ_TRANSITION_PREVIOUS           = 0x00000002,
    UCAL_TZ_TRANSITION_PREVIOUS_INCLUSIVE = 0x00000003,
}

enum UCollationResult : int
{
    UCOL_EQUAL   = 0x00000000,
    UCOL_GREATER = 0x00000001,
    UCOL_LESS    = 0xffffffff,
}

enum UColAttributeValue : int
{
    UCOL_DEFAULT           = 0xffffffff,
    UCOL_PRIMARY           = 0x00000000,
    UCOL_SECONDARY         = 0x00000001,
    UCOL_TERTIARY          = 0x00000002,
    UCOL_DEFAULT_STRENGTH  = 0x00000002,
    UCOL_CE_STRENGTH_LIMIT = 0x00000003,
    UCOL_QUATERNARY        = 0x00000003,
    UCOL_IDENTICAL         = 0x0000000f,
    UCOL_STRENGTH_LIMIT    = 0x00000010,
    UCOL_OFF               = 0x00000010,
    UCOL_ON                = 0x00000011,
    UCOL_SHIFTED           = 0x00000014,
    UCOL_NON_IGNORABLE     = 0x00000015,
    UCOL_LOWER_FIRST       = 0x00000018,
    UCOL_UPPER_FIRST       = 0x00000019,
}

enum UColReorderCode : int
{
    UCOL_REORDER_CODE_DEFAULT     = 0xffffffff,
    UCOL_REORDER_CODE_NONE        = 0x00000067,
    UCOL_REORDER_CODE_OTHERS      = 0x00000067,
    UCOL_REORDER_CODE_SPACE       = 0x00001000,
    UCOL_REORDER_CODE_FIRST       = 0x00001000,
    UCOL_REORDER_CODE_PUNCTUATION = 0x00001001,
    UCOL_REORDER_CODE_SYMBOL      = 0x00001002,
    UCOL_REORDER_CODE_CURRENCY    = 0x00001003,
    UCOL_REORDER_CODE_DIGIT       = 0x00001004,
}

enum UColAttribute : int
{
    UCOL_FRENCH_COLLATION   = 0x00000000,
    UCOL_ALTERNATE_HANDLING = 0x00000001,
    UCOL_CASE_FIRST         = 0x00000002,
    UCOL_CASE_LEVEL         = 0x00000003,
    UCOL_NORMALIZATION_MODE = 0x00000004,
    UCOL_DECOMPOSITION_MODE = 0x00000004,
    UCOL_STRENGTH           = 0x00000005,
    UCOL_NUMERIC_COLLATION  = 0x00000007,
    UCOL_ATTRIBUTE_COUNT    = 0x00000008,
}

enum UColRuleOption : int
{
    UCOL_TAILORING_ONLY = 0x00000000,
    UCOL_FULL_RULES     = 0x00000001,
}

enum UColBoundMode : int
{
    UCOL_BOUND_LOWER      = 0x00000000,
    UCOL_BOUND_UPPER      = 0x00000001,
    UCOL_BOUND_UPPER_LONG = 0x00000002,
}

enum UDateTimePatternField : int
{
    UDATPG_ERA_FIELD                  = 0x00000000,
    UDATPG_YEAR_FIELD                 = 0x00000001,
    UDATPG_QUARTER_FIELD              = 0x00000002,
    UDATPG_MONTH_FIELD                = 0x00000003,
    UDATPG_WEEK_OF_YEAR_FIELD         = 0x00000004,
    UDATPG_WEEK_OF_MONTH_FIELD        = 0x00000005,
    UDATPG_WEEKDAY_FIELD              = 0x00000006,
    UDATPG_DAY_OF_YEAR_FIELD          = 0x00000007,
    UDATPG_DAY_OF_WEEK_IN_MONTH_FIELD = 0x00000008,
    UDATPG_DAY_FIELD                  = 0x00000009,
    UDATPG_DAYPERIOD_FIELD            = 0x0000000a,
    UDATPG_HOUR_FIELD                 = 0x0000000b,
    UDATPG_MINUTE_FIELD               = 0x0000000c,
    UDATPG_SECOND_FIELD               = 0x0000000d,
    UDATPG_FRACTIONAL_SECOND_FIELD    = 0x0000000e,
    UDATPG_ZONE_FIELD                 = 0x0000000f,
    UDATPG_FIELD_COUNT                = 0x00000010,
}

enum UDateTimePGDisplayWidth : int
{
    UDATPG_WIDE        = 0x00000000,
    UDATPG_ABBREVIATED = 0x00000001,
    UDATPG_NARROW      = 0x00000002,
}

enum UDateTimePatternMatchOptions : int
{
    UDATPG_MATCH_NO_OPTIONS        = 0x00000000,
    UDATPG_MATCH_HOUR_FIELD_LENGTH = 0x00000800,
    UDATPG_MATCH_ALL_FIELDS_LENGTH = 0x0000ffff,
}

enum UDateTimePatternConflict : int
{
    UDATPG_NO_CONFLICT   = 0x00000000,
    UDATPG_BASE_CONFLICT = 0x00000001,
    UDATPG_CONFLICT      = 0x00000002,
}

enum UFormattableType : int
{
    UFMT_DATE   = 0x00000000,
    UFMT_DOUBLE = 0x00000001,
    UFMT_LONG   = 0x00000002,
    UFMT_STRING = 0x00000003,
    UFMT_ARRAY  = 0x00000004,
    UFMT_INT64  = 0x00000005,
    UFMT_OBJECT = 0x00000006,
}

enum UGender : int
{
    UGENDER_MALE   = 0x00000000,
    UGENDER_FEMALE = 0x00000001,
    UGENDER_OTHER  = 0x00000002,
}

enum ULocaleDataExemplarSetType : int
{
    ULOCDATA_ES_STANDARD    = 0x00000000,
    ULOCDATA_ES_AUXILIARY   = 0x00000001,
    ULOCDATA_ES_INDEX       = 0x00000002,
    ULOCDATA_ES_PUNCTUATION = 0x00000003,
}

enum ULocaleDataDelimiterType : int
{
    ULOCDATA_QUOTATION_START     = 0x00000000,
    ULOCDATA_QUOTATION_END       = 0x00000001,
    ULOCDATA_ALT_QUOTATION_START = 0x00000002,
    ULOCDATA_ALT_QUOTATION_END   = 0x00000003,
}

enum UMeasurementSystem : int
{
    UMS_SI  = 0x00000000,
    UMS_US  = 0x00000001,
    UMS_UK  = 0x00000002,
}

enum UNumberFormatStyle : int
{
    UNUM_PATTERN_DECIMAL       = 0x00000000,
    UNUM_DECIMAL               = 0x00000001,
    UNUM_CURRENCY              = 0x00000002,
    UNUM_PERCENT               = 0x00000003,
    UNUM_SCIENTIFIC            = 0x00000004,
    UNUM_SPELLOUT              = 0x00000005,
    UNUM_ORDINAL               = 0x00000006,
    UNUM_DURATION              = 0x00000007,
    UNUM_NUMBERING_SYSTEM      = 0x00000008,
    UNUM_PATTERN_RULEBASED     = 0x00000009,
    UNUM_CURRENCY_ISO          = 0x0000000a,
    UNUM_CURRENCY_PLURAL       = 0x0000000b,
    UNUM_CURRENCY_ACCOUNTING   = 0x0000000c,
    UNUM_CASH_CURRENCY         = 0x0000000d,
    UNUM_DECIMAL_COMPACT_SHORT = 0x0000000e,
    UNUM_DECIMAL_COMPACT_LONG  = 0x0000000f,
    UNUM_CURRENCY_STANDARD     = 0x00000010,
    UNUM_DEFAULT               = 0x00000001,
    UNUM_IGNORE                = 0x00000000,
}

enum UNumberFormatRoundingMode : int
{
    UNUM_ROUND_CEILING     = 0x00000000,
    UNUM_ROUND_FLOOR       = 0x00000001,
    UNUM_ROUND_DOWN        = 0x00000002,
    UNUM_ROUND_UP          = 0x00000003,
    UNUM_ROUND_HALFEVEN    = 0x00000004,
    UNUM_ROUND_HALFDOWN    = 0x00000005,
    UNUM_ROUND_HALFUP      = 0x00000006,
    UNUM_ROUND_UNNECESSARY = 0x00000007,
}

enum UNumberFormatPadPosition : int
{
    UNUM_PAD_BEFORE_PREFIX = 0x00000000,
    UNUM_PAD_AFTER_PREFIX  = 0x00000001,
    UNUM_PAD_BEFORE_SUFFIX = 0x00000002,
    UNUM_PAD_AFTER_SUFFIX  = 0x00000003,
}

enum UNumberCompactStyle : int
{
    UNUM_SHORT = 0x00000000,
    UNUM_LONG  = 0x00000001,
}

enum UCurrencySpacing : int
{
    UNUM_CURRENCY_MATCH             = 0x00000000,
    UNUM_CURRENCY_SURROUNDING_MATCH = 0x00000001,
    UNUM_CURRENCY_INSERT            = 0x00000002,
    UNUM_CURRENCY_SPACING_COUNT     = 0x00000003,
}

enum UNumberFormatFields : int
{
    UNUM_INTEGER_FIELD            = 0x00000000,
    UNUM_FRACTION_FIELD           = 0x00000001,
    UNUM_DECIMAL_SEPARATOR_FIELD  = 0x00000002,
    UNUM_EXPONENT_SYMBOL_FIELD    = 0x00000003,
    UNUM_EXPONENT_SIGN_FIELD      = 0x00000004,
    UNUM_EXPONENT_FIELD           = 0x00000005,
    UNUM_GROUPING_SEPARATOR_FIELD = 0x00000006,
    UNUM_CURRENCY_FIELD           = 0x00000007,
    UNUM_PERCENT_FIELD            = 0x00000008,
    UNUM_PERMILL_FIELD            = 0x00000009,
    UNUM_SIGN_FIELD               = 0x0000000a,
}

enum UNumberFormatAttributeValue : int
{
    UNUM_FORMAT_ATTRIBUTE_VALUE_HIDDEN = 0x00000000,
}

enum UNumberFormatAttribute : int
{
    UNUM_PARSE_INT_ONLY                      = 0x00000000,
    UNUM_GROUPING_USED                       = 0x00000001,
    UNUM_DECIMAL_ALWAYS_SHOWN                = 0x00000002,
    UNUM_MAX_INTEGER_DIGITS                  = 0x00000003,
    UNUM_MIN_INTEGER_DIGITS                  = 0x00000004,
    UNUM_INTEGER_DIGITS                      = 0x00000005,
    UNUM_MAX_FRACTION_DIGITS                 = 0x00000006,
    UNUM_MIN_FRACTION_DIGITS                 = 0x00000007,
    UNUM_FRACTION_DIGITS                     = 0x00000008,
    UNUM_MULTIPLIER                          = 0x00000009,
    UNUM_GROUPING_SIZE                       = 0x0000000a,
    UNUM_ROUNDING_MODE                       = 0x0000000b,
    UNUM_ROUNDING_INCREMENT                  = 0x0000000c,
    UNUM_FORMAT_WIDTH                        = 0x0000000d,
    UNUM_PADDING_POSITION                    = 0x0000000e,
    UNUM_SECONDARY_GROUPING_SIZE             = 0x0000000f,
    UNUM_SIGNIFICANT_DIGITS_USED             = 0x00000010,
    UNUM_MIN_SIGNIFICANT_DIGITS              = 0x00000011,
    UNUM_MAX_SIGNIFICANT_DIGITS              = 0x00000012,
    UNUM_LENIENT_PARSE                       = 0x00000013,
    UNUM_PARSE_ALL_INPUT                     = 0x00000014,
    UNUM_SCALE                               = 0x00000015,
    UNUM_CURRENCY_USAGE                      = 0x00000017,
    UNUM_FORMAT_FAIL_IF_MORE_THAN_MAX_DIGITS = 0x00001000,
    UNUM_PARSE_NO_EXPONENT                   = 0x00001001,
    UNUM_PARSE_DECIMAL_MARK_REQUIRED         = 0x00001002,
}

enum UNumberFormatTextAttribute : int
{
    UNUM_POSITIVE_PREFIX   = 0x00000000,
    UNUM_POSITIVE_SUFFIX   = 0x00000001,
    UNUM_NEGATIVE_PREFIX   = 0x00000002,
    UNUM_NEGATIVE_SUFFIX   = 0x00000003,
    UNUM_PADDING_CHARACTER = 0x00000004,
    UNUM_CURRENCY_CODE     = 0x00000005,
    UNUM_DEFAULT_RULESET   = 0x00000006,
    UNUM_PUBLIC_RULESETS   = 0x00000007,
}

enum UNumberFormatSymbol : int
{
    UNUM_DECIMAL_SEPARATOR_SYMBOL           = 0x00000000,
    UNUM_GROUPING_SEPARATOR_SYMBOL          = 0x00000001,
    UNUM_PATTERN_SEPARATOR_SYMBOL           = 0x00000002,
    UNUM_PERCENT_SYMBOL                     = 0x00000003,
    UNUM_ZERO_DIGIT_SYMBOL                  = 0x00000004,
    UNUM_DIGIT_SYMBOL                       = 0x00000005,
    UNUM_MINUS_SIGN_SYMBOL                  = 0x00000006,
    UNUM_PLUS_SIGN_SYMBOL                   = 0x00000007,
    UNUM_CURRENCY_SYMBOL                    = 0x00000008,
    UNUM_INTL_CURRENCY_SYMBOL               = 0x00000009,
    UNUM_MONETARY_SEPARATOR_SYMBOL          = 0x0000000a,
    UNUM_EXPONENTIAL_SYMBOL                 = 0x0000000b,
    UNUM_PERMILL_SYMBOL                     = 0x0000000c,
    UNUM_PAD_ESCAPE_SYMBOL                  = 0x0000000d,
    UNUM_INFINITY_SYMBOL                    = 0x0000000e,
    UNUM_NAN_SYMBOL                         = 0x0000000f,
    UNUM_SIGNIFICANT_DIGIT_SYMBOL           = 0x00000010,
    UNUM_MONETARY_GROUPING_SEPARATOR_SYMBOL = 0x00000011,
    UNUM_ONE_DIGIT_SYMBOL                   = 0x00000012,
    UNUM_TWO_DIGIT_SYMBOL                   = 0x00000013,
    UNUM_THREE_DIGIT_SYMBOL                 = 0x00000014,
    UNUM_FOUR_DIGIT_SYMBOL                  = 0x00000015,
    UNUM_FIVE_DIGIT_SYMBOL                  = 0x00000016,
    UNUM_SIX_DIGIT_SYMBOL                   = 0x00000017,
    UNUM_SEVEN_DIGIT_SYMBOL                 = 0x00000018,
    UNUM_EIGHT_DIGIT_SYMBOL                 = 0x00000019,
    UNUM_NINE_DIGIT_SYMBOL                  = 0x0000001a,
    UNUM_EXPONENT_MULTIPLICATION_SYMBOL     = 0x0000001b,
}

enum UDateFormatStyle : int
{
    UDAT_FULL            = 0x00000000,
    UDAT_LONG            = 0x00000001,
    UDAT_MEDIUM          = 0x00000002,
    UDAT_SHORT           = 0x00000003,
    UDAT_DEFAULT         = 0x00000002,
    UDAT_RELATIVE        = 0x00000080,
    UDAT_FULL_RELATIVE   = 0x00000080,
    UDAT_LONG_RELATIVE   = 0x00000081,
    UDAT_MEDIUM_RELATIVE = 0x00000082,
    UDAT_SHORT_RELATIVE  = 0x00000083,
    UDAT_NONE            = 0xffffffff,
    UDAT_PATTERN         = 0xfffffffe,
}

enum UDateFormatField : int
{
    UDAT_ERA_FIELD                           = 0x00000000,
    UDAT_YEAR_FIELD                          = 0x00000001,
    UDAT_MONTH_FIELD                         = 0x00000002,
    UDAT_DATE_FIELD                          = 0x00000003,
    UDAT_HOUR_OF_DAY1_FIELD                  = 0x00000004,
    UDAT_HOUR_OF_DAY0_FIELD                  = 0x00000005,
    UDAT_MINUTE_FIELD                        = 0x00000006,
    UDAT_SECOND_FIELD                        = 0x00000007,
    UDAT_FRACTIONAL_SECOND_FIELD             = 0x00000008,
    UDAT_DAY_OF_WEEK_FIELD                   = 0x00000009,
    UDAT_DAY_OF_YEAR_FIELD                   = 0x0000000a,
    UDAT_DAY_OF_WEEK_IN_MONTH_FIELD          = 0x0000000b,
    UDAT_WEEK_OF_YEAR_FIELD                  = 0x0000000c,
    UDAT_WEEK_OF_MONTH_FIELD                 = 0x0000000d,
    UDAT_AM_PM_FIELD                         = 0x0000000e,
    UDAT_HOUR1_FIELD                         = 0x0000000f,
    UDAT_HOUR0_FIELD                         = 0x00000010,
    UDAT_TIMEZONE_FIELD                      = 0x00000011,
    UDAT_YEAR_WOY_FIELD                      = 0x00000012,
    UDAT_DOW_LOCAL_FIELD                     = 0x00000013,
    UDAT_EXTENDED_YEAR_FIELD                 = 0x00000014,
    UDAT_JULIAN_DAY_FIELD                    = 0x00000015,
    UDAT_MILLISECONDS_IN_DAY_FIELD           = 0x00000016,
    UDAT_TIMEZONE_RFC_FIELD                  = 0x00000017,
    UDAT_TIMEZONE_GENERIC_FIELD              = 0x00000018,
    UDAT_STANDALONE_DAY_FIELD                = 0x00000019,
    UDAT_STANDALONE_MONTH_FIELD              = 0x0000001a,
    UDAT_QUARTER_FIELD                       = 0x0000001b,
    UDAT_STANDALONE_QUARTER_FIELD            = 0x0000001c,
    UDAT_TIMEZONE_SPECIAL_FIELD              = 0x0000001d,
    UDAT_YEAR_NAME_FIELD                     = 0x0000001e,
    UDAT_TIMEZONE_LOCALIZED_GMT_OFFSET_FIELD = 0x0000001f,
    UDAT_TIMEZONE_ISO_FIELD                  = 0x00000020,
    UDAT_TIMEZONE_ISO_LOCAL_FIELD            = 0x00000021,
    UDAT_AM_PM_MIDNIGHT_NOON_FIELD           = 0x00000023,
    UDAT_FLEXIBLE_DAY_PERIOD_FIELD           = 0x00000024,
}

enum UDateFormatBooleanAttribute : int
{
    UDAT_PARSE_ALLOW_WHITESPACE            = 0x00000000,
    UDAT_PARSE_ALLOW_NUMERIC               = 0x00000001,
    UDAT_PARSE_PARTIAL_LITERAL_MATCH       = 0x00000002,
    UDAT_PARSE_MULTIPLE_PATTERNS_FOR_MATCH = 0x00000003,
    UDAT_BOOLEAN_ATTRIBUTE_COUNT           = 0x00000004,
}

enum UDateFormatSymbolType : int
{
    UDAT_ERAS                        = 0x00000000,
    UDAT_MONTHS                      = 0x00000001,
    UDAT_SHORT_MONTHS                = 0x00000002,
    UDAT_WEEKDAYS                    = 0x00000003,
    UDAT_SHORT_WEEKDAYS              = 0x00000004,
    UDAT_AM_PMS                      = 0x00000005,
    UDAT_LOCALIZED_CHARS             = 0x00000006,
    UDAT_ERA_NAMES                   = 0x00000007,
    UDAT_NARROW_MONTHS               = 0x00000008,
    UDAT_NARROW_WEEKDAYS             = 0x00000009,
    UDAT_STANDALONE_MONTHS           = 0x0000000a,
    UDAT_STANDALONE_SHORT_MONTHS     = 0x0000000b,
    UDAT_STANDALONE_NARROW_MONTHS    = 0x0000000c,
    UDAT_STANDALONE_WEEKDAYS         = 0x0000000d,
    UDAT_STANDALONE_SHORT_WEEKDAYS   = 0x0000000e,
    UDAT_STANDALONE_NARROW_WEEKDAYS  = 0x0000000f,
    UDAT_QUARTERS                    = 0x00000010,
    UDAT_SHORT_QUARTERS              = 0x00000011,
    UDAT_STANDALONE_QUARTERS         = 0x00000012,
    UDAT_STANDALONE_SHORT_QUARTERS   = 0x00000013,
    UDAT_SHORTER_WEEKDAYS            = 0x00000014,
    UDAT_STANDALONE_SHORTER_WEEKDAYS = 0x00000015,
    UDAT_CYCLIC_YEARS_WIDE           = 0x00000016,
    UDAT_CYCLIC_YEARS_ABBREVIATED    = 0x00000017,
    UDAT_CYCLIC_YEARS_NARROW         = 0x00000018,
    UDAT_ZODIAC_NAMES_WIDE           = 0x00000019,
    UDAT_ZODIAC_NAMES_ABBREVIATED    = 0x0000001a,
    UDAT_ZODIAC_NAMES_NARROW         = 0x0000001b,
}

enum UPluralType : int
{
    UPLURAL_TYPE_CARDINAL = 0x00000000,
    UPLURAL_TYPE_ORDINAL  = 0x00000001,
}

enum URegexpFlag : int
{
    UREGEX_CASE_INSENSITIVE         = 0x00000002,
    UREGEX_COMMENTS                 = 0x00000004,
    UREGEX_DOTALL                   = 0x00000020,
    UREGEX_LITERAL                  = 0x00000010,
    UREGEX_MULTILINE                = 0x00000008,
    UREGEX_UNIX_LINES               = 0x00000001,
    UREGEX_UWORD                    = 0x00000100,
    UREGEX_ERROR_ON_UNKNOWN_ESCAPES = 0x00000200,
}

enum URegionType : int
{
    URGN_UNKNOWN      = 0x00000000,
    URGN_TERRITORY    = 0x00000001,
    URGN_WORLD        = 0x00000002,
    URGN_CONTINENT    = 0x00000003,
    URGN_SUBCONTINENT = 0x00000004,
    URGN_GROUPING     = 0x00000005,
    URGN_DEPRECATED   = 0x00000006,
}

enum UDateRelativeDateTimeFormatterStyle : int
{
    UDAT_STYLE_LONG   = 0x00000000,
    UDAT_STYLE_SHORT  = 0x00000001,
    UDAT_STYLE_NARROW = 0x00000002,
}

enum URelativeDateTimeUnit : int
{
    UDAT_REL_UNIT_YEAR      = 0x00000000,
    UDAT_REL_UNIT_QUARTER   = 0x00000001,
    UDAT_REL_UNIT_MONTH     = 0x00000002,
    UDAT_REL_UNIT_WEEK      = 0x00000003,
    UDAT_REL_UNIT_DAY       = 0x00000004,
    UDAT_REL_UNIT_HOUR      = 0x00000005,
    UDAT_REL_UNIT_MINUTE    = 0x00000006,
    UDAT_REL_UNIT_SECOND    = 0x00000007,
    UDAT_REL_UNIT_SUNDAY    = 0x00000008,
    UDAT_REL_UNIT_MONDAY    = 0x00000009,
    UDAT_REL_UNIT_TUESDAY   = 0x0000000a,
    UDAT_REL_UNIT_WEDNESDAY = 0x0000000b,
    UDAT_REL_UNIT_THURSDAY  = 0x0000000c,
    UDAT_REL_UNIT_FRIDAY    = 0x0000000d,
    UDAT_REL_UNIT_SATURDAY  = 0x0000000e,
}

enum USearchAttribute : int
{
    USEARCH_OVERLAP            = 0x00000000,
    USEARCH_ELEMENT_COMPARISON = 0x00000002,
}

enum USearchAttributeValue : int
{
    USEARCH_DEFAULT                         = 0xffffffff,
    USEARCH_OFF                             = 0x00000000,
    USEARCH_ON                              = 0x00000001,
    USEARCH_STANDARD_ELEMENT_COMPARISON     = 0x00000002,
    USEARCH_PATTERN_BASE_WEIGHT_IS_WILDCARD = 0x00000003,
    USEARCH_ANY_BASE_WEIGHT_IS_WILDCARD     = 0x00000004,
}

enum USpoofChecks : int
{
    USPOOF_SINGLE_SCRIPT_CONFUSABLE = 0x00000001,
    USPOOF_MIXED_SCRIPT_CONFUSABLE  = 0x00000002,
    USPOOF_WHOLE_SCRIPT_CONFUSABLE  = 0x00000004,
    USPOOF_CONFUSABLE               = 0x00000007,
    USPOOF_RESTRICTION_LEVEL        = 0x00000010,
    USPOOF_INVISIBLE                = 0x00000020,
    USPOOF_CHAR_LIMIT               = 0x00000040,
    USPOOF_MIXED_NUMBERS            = 0x00000080,
    USPOOF_ALL_CHECKS               = 0x0000ffff,
    USPOOF_AUX_INFO                 = 0x40000000,
}

enum URestrictionLevel : int
{
    USPOOF_ASCII                     = 0x10000000,
    USPOOF_SINGLE_SCRIPT_RESTRICTIVE = 0x20000000,
    USPOOF_HIGHLY_RESTRICTIVE        = 0x30000000,
    USPOOF_MODERATELY_RESTRICTIVE    = 0x40000000,
    USPOOF_MINIMALLY_RESTRICTIVE     = 0x50000000,
    USPOOF_UNRESTRICTIVE             = 0x60000000,
    USPOOF_RESTRICTION_LEVEL_MASK    = 0x7f000000,
}

enum UDateTimeScale : int
{
    UDTS_JAVA_TIME              = 0x00000000,
    UDTS_UNIX_TIME              = 0x00000001,
    UDTS_ICU4C_TIME             = 0x00000002,
    UDTS_WINDOWS_FILE_TIME      = 0x00000003,
    UDTS_DOTNET_DATE_TIME       = 0x00000004,
    UDTS_MAC_OLD_TIME           = 0x00000005,
    UDTS_MAC_TIME               = 0x00000006,
    UDTS_EXCEL_TIME             = 0x00000007,
    UDTS_DB2_TIME               = 0x00000008,
    UDTS_UNIX_MICROSECONDS_TIME = 0x00000009,
}

enum UTimeScaleValue : int
{
    UTSV_UNITS_VALUE        = 0x00000000,
    UTSV_EPOCH_OFFSET_VALUE = 0x00000001,
    UTSV_FROM_MIN_VALUE     = 0x00000002,
    UTSV_FROM_MAX_VALUE     = 0x00000003,
    UTSV_TO_MIN_VALUE       = 0x00000004,
    UTSV_TO_MAX_VALUE       = 0x00000005,
}

enum UTransDirection : int
{
    UTRANS_FORWARD = 0x00000000,
    UTRANS_REVERSE = 0x00000001,
}

// Constants


enum int UITER_UNKNOWN_INDEX = 0xfffffffe;

enum : int
{
    UTEXT_PROVIDER_STABLE_CHUNKS = 0x00000002,
    UTEXT_PROVIDER_WRITABLE      = 0x00000003,
    UTEXT_PROVIDER_HAS_META_DATA = 0x00000004,
    UTEXT_PROVIDER_OWNS_TEXT     = 0x00000005,
}

enum int USET_IGNORE_SPACE = 0x00000001;
enum int USET_ADD_CASE_MAPPINGS = 0x00000004;
enum int U_PARSE_CONTEXT_LEN = 0x00000010;
enum int UIDNA_USE_STD3_RULES = 0x00000002;
enum int UIDNA_CHECK_CONTEXTJ = 0x00000008;
enum int UIDNA_NONTRANSITIONAL_TO_UNICODE = 0x00000020;

enum : int
{
    UIDNA_ERROR_EMPTY_LABEL          = 0x00000001,
    UIDNA_ERROR_LABEL_TOO_LONG       = 0x00000002,
    UIDNA_ERROR_DOMAIN_NAME_TOO_LONG = 0x00000004,
}

enum : int
{
    UIDNA_ERROR_TRAILING_HYPHEN        = 0x00000010,
    UIDNA_ERROR_HYPHEN_3_4             = 0x00000020,
    UIDNA_ERROR_LEADING_COMBINING_MARK = 0x00000040,
}

enum : int
{
    UIDNA_ERROR_PUNYCODE             = 0x00000100,
    UIDNA_ERROR_LABEL_HAS_DOT        = 0x00000200,
    UIDNA_ERROR_INVALID_ACE_LABEL    = 0x00000400,
    UIDNA_ERROR_BIDI                 = 0x00000800,
    UIDNA_ERROR_CONTEXTJ             = 0x00001000,
    UIDNA_ERROR_CONTEXTO_PUNCTUATION = 0x00002000,
    UIDNA_ERROR_CONTEXTO_DIGITS      = 0x00004000,
}

// Callbacks

alias LOCALE_ENUMPROCA = BOOL function(PSTR param0);
alias LOCALE_ENUMPROCW = BOOL function(PWSTR param0);
alias LANGUAGEGROUP_ENUMPROCA = BOOL function(uint param0, PSTR param1, PSTR param2, uint param3, ptrdiff_t param4);
///An application-defined callback function that processes enumerated language group locale information provided by the
///EnumLanguageGroupLocales function. The LANGGROUPLOCALE_ENUMPROC type defines a pointer to this callback function.
///<b>EnumLanguageGroupLocalesProc</b> is a placeholder for the application-defined function name.
///Params:
///    Arg1 = 
///    Arg2 = 
///    Arg3 = 
///    Arg4 = 
///Returns:
///    Returns <b>TRUE</b> to continue enumeration or <b>FALSE</b> otherwise.
///    
alias LANGGROUPLOCALE_ENUMPROCA = BOOL function(uint param0, uint param1, PSTR param2, ptrdiff_t param3);
///An application-defined callback function that processes enumerated user interface language information provided by
///the EnumUILanguages function. The UILANGUAGE_ENUMPROC type defines a pointer to this callback function.
///<b>EnumUILanguagesProc</b> is a placeholder for the application-defined function name.
///Params:
///    Arg1 = 
///    Arg2 = 
///Returns:
///    Returns <b>TRUE</b> to continue enumeration or <b>FALSE</b> otherwise.
///    
alias UILANGUAGE_ENUMPROCA = BOOL function(PSTR param0, ptrdiff_t param1);
alias CODEPAGE_ENUMPROCA = BOOL function(PSTR param0);
alias DATEFMT_ENUMPROCA = BOOL function(PSTR param0);
alias DATEFMT_ENUMPROCEXA = BOOL function(PSTR param0, uint param1);
alias TIMEFMT_ENUMPROCA = BOOL function(PSTR param0);
alias CALINFO_ENUMPROCA = BOOL function(PSTR param0);
alias CALINFO_ENUMPROCEXA = BOOL function(PSTR param0, uint param1);
alias LANGUAGEGROUP_ENUMPROCW = BOOL function(uint param0, PWSTR param1, PWSTR param2, uint param3, 
                                              ptrdiff_t param4);
///An application-defined callback function that processes enumerated language group locale information provided by the
///EnumLanguageGroupLocales function. The LANGGROUPLOCALE_ENUMPROC type defines a pointer to this callback function.
///<b>EnumLanguageGroupLocalesProc</b> is a placeholder for the application-defined function name.
///Params:
///    Arg1 = 
///    Arg2 = 
///    Arg3 = 
///    Arg4 = 
///Returns:
///    Returns <b>TRUE</b> to continue enumeration or <b>FALSE</b> otherwise.
///    
alias LANGGROUPLOCALE_ENUMPROCW = BOOL function(uint param0, uint param1, PWSTR param2, ptrdiff_t param3);
///An application-defined callback function that processes enumerated user interface language information provided by
///the EnumUILanguages function. The UILANGUAGE_ENUMPROC type defines a pointer to this callback function.
///<b>EnumUILanguagesProc</b> is a placeholder for the application-defined function name.
///Params:
///    Arg1 = 
///    Arg2 = 
///Returns:
///    Returns <b>TRUE</b> to continue enumeration or <b>FALSE</b> otherwise.
///    
alias UILANGUAGE_ENUMPROCW = BOOL function(PWSTR param0, ptrdiff_t param1);
alias CODEPAGE_ENUMPROCW = BOOL function(PWSTR param0);
alias DATEFMT_ENUMPROCW = BOOL function(PWSTR param0);
alias DATEFMT_ENUMPROCEXW = BOOL function(PWSTR param0, uint param1);
alias TIMEFMT_ENUMPROCW = BOOL function(PWSTR param0);
alias CALINFO_ENUMPROCW = BOOL function(PWSTR param0);
alias CALINFO_ENUMPROCEXW = BOOL function(PWSTR param0, uint param1);
alias GEO_ENUMPROC = BOOL function(int param0);
///An application-defined callback function that processes enumerated geographical location information provided by the
///EnumSystemGeoNames function. The <b>GEO_ENUMNAMEPROC</b> type defines a pointer to this callback function.
///<i>Geo_EnumNameProc</i> is a placeholder for the application-defined function name.
///Params:
///    Arg1 = 
///    Arg2 = 
///Returns:
///    Returns <b>TRUE</b> to continue enumeration or <b>FALSE</b> otherwise.
///    
alias GEO_ENUMNAMEPROC = BOOL function(PWSTR param0, LPARAM param1);
alias CALINFO_ENUMPROCEXEX = BOOL function(PWSTR param0, uint param1, PWSTR param2, LPARAM param3);
alias DATEFMT_ENUMPROCEXEX = BOOL function(PWSTR param0, uint param1, LPARAM param2);
alias TIMEFMT_ENUMPROCEX = BOOL function(PWSTR param0, LPARAM param1);
///An application-defined callback function that processes enumerated locale information provided by the
///EnumSystemLocalesEx function. The LOCALE_ENUMPROCEX type defines a pointer to this callback function.
///<b>EnumLocalesProcEx</b> is a placeholder for the application-defined function name.
///Params:
///    Arg1 = Pointer to a buffer containing a null-terminated [locale name](/windows/win32/intl/locale-names) string.
///    Arg2 = Flags defining locale information. Values for this parameter can include a binary OR of flags, but some flag
///           combinations never occur. If the application specifies[LOCALE_WINDOWS](/windows/win32/intl/locale-windows) or
///           [LOCALE_ALTERNATE_SORTS](/windows/win32/intl/locale-alternate-sorts), it can also specify
///           [LOCALE_REPLACEMENT](/windows/win32/intl/locale-replacement) so that the
///           [EnumSystemLocalesEx](./nf-winnls-enumsystemlocalesex.md) function can test to see if the locale is a
///           replacement. - [LOCALE_ALL](/windows/win32/intl/locale-all) -
///           [LOCALE_ALTERNATE_SORTS](/windows/win32/intl/locale-alternate-sorts); for more information, see <wdcml:xref
///           rid="intl.enumsystemlocalesex" targtype="function" enabled="1">EnumSystemLocalesEx</wdcml:xref></wdcml:item> -
///           [LOCALE_NEUTRALDATA](/windows/win32/intl/locale-neutraldata) -
///           [LOCALE_REPLACEMENT](/windows/win32/intl/locale-replacement) This constant is not a valid input to the *dwFlags*
///           parameter of EnumSystemLocalesEx. To enumerate replacement locales, the application should call this function
///           with the *Arg2* parameter specified as LOCALE_WINDOWS or LOCALE_ALL, then check for this constant in the callback
///           function. - [LOCALE_SUPPLEMENTAL](/windows/win32/intl/locale-supplemental) -
///           [LOCALE_WINDOWS](/windows/win32/intl/locale-windows)
///    Arg3 = An application-provided input parameter of EnumSystemLocalesEx. This value is especially useful for
///           multi-threaded applications, since it can be used to pass thread-specific data to this callback function.
///Returns:
///    Returns <b>TRUE</b> to continue enumeration or <b>FALSE</b> otherwise.
///    
alias LOCALE_ENUMPROCEX = BOOL function(PWSTR param0, uint param1, LPARAM param2);
///An application-defined callback function that processes input contexts provided by the ImmEnumInputContext function.
///The IMCENUMPROC type defines a pointer to this callback function. <b>EnumInputContext</b> is a placeholder for the
///application-defined function name.
///Params:
///    Arg1 = Handle to the input context.
///    Arg2 = Application-supplied data.
///Returns:
///    Returns a nonzero value to continue enumeration, or 0 to stop enumeration.
///    
alias IMCENUMPROC = BOOL function(HIMC__* param0, LPARAM param1);
///An application-defined callback function used with the ImmEnumRegisterWord function. It is used to process data of
///register strings. The REGISTERWORDENUMPROC type defines a pointer to this callback function.
///<b>EnumRegisterWordProc</b> is a placeholder for the application-defined function name.
///Params:
///    lpszReading = Pointer to a null-terminated string specifying the matched reading string.
///    Arg2 = The style of the register string.
///    lpszString = Pointer to a null-terminated string specifying the matched register string.
///    Arg4 = Application-supplied data.
///Returns:
///    Returns a nonzero value to continue enumeration, or 0 to stop enumeration.
///    
alias REGISTERWORDENUMPROCA = int function(const(PSTR) lpszReading, uint param1, const(PSTR) lpszString, 
                                           void* param3);
///An application-defined callback function used with the ImmEnumRegisterWord function. It is used to process data of
///register strings. The REGISTERWORDENUMPROC type defines a pointer to this callback function.
///<b>EnumRegisterWordProc</b> is a placeholder for the application-defined function name.
///Params:
///    lpszReading = Pointer to a null-terminated string specifying the matched reading string.
///    Arg2 = The style of the register string.
///    lpszString = Pointer to a null-terminated string specifying the matched register string.
///    Arg4 = Application-supplied data.
///Returns:
///    Returns a nonzero value to continue enumeration, or 0 to stop enumeration.
///    
alias REGISTERWORDENUMPROCW = int function(const(PWSTR) lpszReading, uint param1, const(PWSTR) lpszString, 
                                           void* param3);
///An application-defined callback function that asynchronously processes data produced by the MappingRecognizeText
///function. The <b>MAPPINGCALLBACKPROC</b> type defines a pointer to this callback function. <b>MappingCallbackProc</b>
///is a placeholder for the application-defined function name.
///Params:
///    pBag = Pointer to a MAPPING_PROPERTY_BAG structure containing the results of the call to MappingRecognizeText.
///    data = Pointer to private application data. This pointer is the same as that passed in the <b>pRecognizeCallerData</b>
///           member of the MAPPING_OPTIONS structure.
///    dwDataSize = Size, in bytes, of the private application data. This size is the same as that passed in the
///                 <b>dwRecognizeCallerDataSize</b> member of the MAPPING_OPTIONS structure when the application calls
///                 MappingRecognizeText asynchronuously.
///    Result = Return code from MappingRecognizeText. The return code is S_OK if the function succeeded, or an error code
///             otherwise.
alias PFN_MAPPINGCALLBACKPROC = void function(MAPPING_PROPERTY_BAG* pBag, void* data, uint dwDataSize, 
                                              HRESULT Result);
alias PFNLOG = BOOL function(IMEDP* param0, HRESULT param1);
alias fpCreateIFECommonInstanceType = HRESULT function(void** ppvObj);
alias fpCreateIFELanguageInstanceType = HRESULT function(const(GUID)* clsid, void** ppvObj);
alias fpCreateIFEDictionaryInstanceType = HRESULT function(void** ppvObj);
alias UTraceEntry = void function(const(void)* context, int fnNumber);
alias UTraceExit = void function(const(void)* context, int fnNumber, const(byte)* fmt, byte* args);
alias UTraceData = void function(const(void)* context, int fnNumber, int level, const(byte)* fmt, byte* args);
alias UCharIteratorGetIndex = int function(UCharIterator* iter, UCharIteratorOrigin origin);
alias UCharIteratorMove = int function(UCharIterator* iter, int delta, UCharIteratorOrigin origin);
alias UCharIteratorHasNext = byte function(UCharIterator* iter);
alias UCharIteratorHasPrevious = byte function(UCharIterator* iter);
alias UCharIteratorCurrent = int function(UCharIterator* iter);
alias UCharIteratorNext = int function(UCharIterator* iter);
alias UCharIteratorPrevious = int function(UCharIterator* iter);
alias UCharIteratorReserved = int function(UCharIterator* iter, int something);
alias UCharIteratorGetState = uint function(const(UCharIterator)* iter);
alias UCharIteratorSetState = void function(UCharIterator* iter, uint state, UErrorCode* pErrorCode);
alias UConverterToUCallback = void function(const(void)* context, UConverterToUnicodeArgs* args, 
                                            const(byte)* codeUnits, int length, UConverterCallbackReason reason, 
                                            UErrorCode* pErrorCode);
alias UConverterFromUCallback = void function(const(void)* context, UConverterFromUnicodeArgs* args, 
                                              const(ushort)* codeUnits, int length, int codePoint, 
                                              UConverterCallbackReason reason, UErrorCode* pErrorCode);
alias UMemAllocFn = void* function(const(void)* context, size_t size);
alias UMemReallocFn = void* function(const(void)* context, void* mem, size_t size);
alias UMemFreeFn = void function(const(void)* context, void* mem);
alias UCharEnumTypeRange = byte function(const(void)* context, int start, int limit, UCharCategory type);
alias UEnumCharNamesFn = byte function(void* context, int code, UCharNameChoice nameChoice, const(byte)* name, 
                                       int length);
alias UBiDiClassCallback = UCharDirection function(const(void)* context, int c);
alias UTextClone = UText* function(UText* dest, const(UText)* src, byte deep, UErrorCode* status);
alias UTextNativeLength = long function(UText* ut);
alias UTextAccess = byte function(UText* ut, long nativeIndex, byte forward);
alias UTextExtract = int function(UText* ut, long nativeStart, long nativeLimit, ushort* dest, int destCapacity, 
                                  UErrorCode* status);
alias UTextReplace = int function(UText* ut, long nativeStart, long nativeLimit, const(ushort)* replacementText, 
                                  int replacmentLength, UErrorCode* status);
alias UTextCopy = void function(UText* ut, long nativeStart, long nativeLimit, long nativeDest, byte move, 
                                UErrorCode* status);
alias UTextMapOffsetToNative = long function(const(UText)* ut);
alias UTextMapNativeIndexToUTF16 = int function(const(UText)* ut, long nativeIndex);
alias UTextClose = void function(UText* ut);
alias UNESCAPE_CHAR_AT = ushort function(int offset, void* context);
alias URegexMatchCallback = byte function(const(void)* context, int steps);
alias URegexFindProgressCallback = byte function(const(void)* context, long matchIndex);

// Structs


///Contains information about a code page. This structure is used by the GetCPInfo function.
struct CPINFO
{
    ///Maximum length, in bytes, of a character in the code page. The length can be 1 for a single-byte character set
    ///(SBCS), 2 for a double-byte character set (DBCS), or a value larger than 2 for other character set types. The
    ///function cannot use the size to distinguish an SBCS or a DBCS from other character sets because of other factors,
    ///for example, the use of ISCII or ISO-2022-xx code pages.
    uint      MaxCharSize;
    ///Default character used when translating character strings to the specific code page. This character is used by
    ///the WideCharToMultiByte function if an explicit default character is not specified. The default is usually the
    ///"?" character for the code page.
    ubyte[2]  DefaultChar;
    ///A fixed-length array of lead byte ranges, for which the number of lead byte ranges is variable. If the code page
    ///has no lead bytes, every element of the array is set to <b>NULL</b>. If the code page has lead bytes, the array
    ///specifies a starting value and an ending value for each range. Ranges are inclusive, and the maximum number of
    ///ranges for any code page is five. The array uses two bytes to describe each range, with two null bytes as a
    ///terminator after the last range. <div class="alert"><b>Note</b> Some code pages use lead bytes and a combination
    ///of other encoding mechanisms. This member is usually only populated for a subset of the code pages that use lead
    ///bytes in some form. For more information, see the Remarks section.</div> <div> </div>
    ubyte[12] LeadByte;
}

///Contains information about a code page. This structure is used by the GetCPInfoEx function.
struct CPINFOEXA
{
    ///Maximum length, in bytes, of a character in the code page. The length can be 1 for a single-byte character set
    ///(SBCS), 2 for a double-byte character set (DBCS), or a value larger than 2 for other character set types. The
    ///function cannot use the size to distinguish an SBCS or a DBCS from other character sets because of other factors,
    ///for example, the use of ISCII or ISO-2022-xx code pages.
    uint      MaxCharSize;
    ///Default character used when translating character strings to the specific code page. This character is used by
    ///the WideCharToMultiByte function if an explicit default character is not specified. The default is usually the
    ///"?" character for the code page.
    ubyte[2]  DefaultChar;
    ///A fixed-length array of lead byte ranges, for which the number of lead byte ranges is variable. If the code page
    ///has no lead bytes, every element of the array is set to <b>NULL</b>. If the code page has lead bytes, the array
    ///specifies a starting value and an ending value for each range. Ranges are inclusive, and the maximum number of
    ///ranges for any code page is five. The array uses two bytes to describe each range, with two null bytes as a
    ///terminator after the last range. <div class="alert"><b>Note</b> Some code pages use lead bytes and a combination
    ///of other encoding mechanisms. This member is usually only populated for a subset of the code pages that use lead
    ///bytes in some form. For more information, see the Remarks section.</div> <div> </div>
    ubyte[12] LeadByte;
    ///Unicode default character used in translations from the specific code page. The default is usually the "?"
    ///character or the katakana middle dot character. The Unicode default character is used by the MultiByteToWideChar
    ///function.
    ushort    UnicodeDefaultChar;
    ///Code page value. This value reflects the code page passed to the GetCPInfoEx function. See Code Page Identifiers
    ///for a list of ANSI and other code pages.
    uint      CodePage;
    ///Full name of the code page. Note that this name is localized and is not guaranteed for uniqueness or consistency
    ///between operating system versions or computers.
    byte[260] CodePageName;
}

///Contains information about a code page. This structure is used by the GetCPInfoEx function.
struct CPINFOEXW
{
    ///Maximum length, in bytes, of a character in the code page. The length can be 1 for a single-byte character set
    ///(SBCS), 2 for a double-byte character set (DBCS), or a value larger than 2 for other character set types. The
    ///function cannot use the size to distinguish an SBCS or a DBCS from other character sets because of other factors,
    ///for example, the use of ISCII or ISO-2022-xx code pages.
    uint        MaxCharSize;
    ///Default character used when translating character strings to the specific code page. This character is used by
    ///the WideCharToMultiByte function if an explicit default character is not specified. The default is usually the
    ///"?" character for the code page.
    ubyte[2]    DefaultChar;
    ///A fixed-length array of lead byte ranges, for which the number of lead byte ranges is variable. If the code page
    ///has no lead bytes, every element of the array is set to <b>NULL</b>. If the code page has lead bytes, the array
    ///specifies a starting value and an ending value for each range. Ranges are inclusive, and the maximum number of
    ///ranges for any code page is five. The array uses two bytes to describe each range, with two null bytes as a
    ///terminator after the last range. <div class="alert"><b>Note</b> Some code pages use lead bytes and a combination
    ///of other encoding mechanisms. This member is usually only populated for a subset of the code pages that use lead
    ///bytes in some form. For more information, see the Remarks section.</div> <div> </div>
    ubyte[12]   LeadByte;
    ///Unicode default character used in translations from the specific code page. The default is usually the "?"
    ///character or the katakana middle dot character. The Unicode default character is used by the MultiByteToWideChar
    ///function.
    ushort      UnicodeDefaultChar;
    ///Code page value. This value reflects the code page passed to the GetCPInfoEx function. See Code Page Identifiers
    ///for a list of ANSI and other code pages.
    uint        CodePage;
    ///Full name of the code page. Note that this name is localized and is not guaranteed for uniqueness or consistency
    ///between operating system versions or computers.
    ushort[260] CodePageName;
}

///Contains information that defines the format of a number string. The GetNumberFormat function uses this information
///to customize a number string for a specified locale.
struct NUMBERFMTA
{
    ///Number of fractional digits. This value is equivalent to the locale information specified by the value
    ///LOCALE_IDIGITS.
    uint NumDigits;
    ///A value indicating if leading zeros should be used in decimal fields. This value is equivalent to the locale
    ///information specified by the value LOCALE_ILZERO.
    uint LeadingZero;
    ///Number of digits in each group of numbers to the left of the decimal separator specified by <b>lpDecimalSep</b>.
    ///Values in the range 0 through 9 and 32 are valid. The most significant grouping digit indicates the number of
    ///digits in the least significant group immediately to the left of the decimal separator. Each subsequent grouping
    ///digit indicates the next significant group of digits to the left of the previous group. If the last value
    ///supplied is not 0, the remaining groups repeat the last group. Typical examples of settings for this member are:
    ///0 to group digits as in 123456789.00; 3 to group digits as in 123,456,789.00; and 32 to group digits as in
    ///12,34,56,789.00. <div class="alert"><b>Note</b> You can use settings other than the typical settings, but they
    ///will not show up in the regional and language options portion of the Control Panel. Such settings are extremely
    ///uncommon and might have unexpected results.</div> <div> </div>
    uint Grouping;
    ///Pointer to a null-terminated decimal separator string.
    PSTR lpDecimalSep;
    ///Pointer to a null-terminated thousand separator string.
    PSTR lpThousandSep;
    ///Negative number mode. This mode is equivalent to the locale information specified by the value LOCALE_INEGNUMBER.
    uint NegativeOrder;
}

///Contains information that defines the format of a number string. The GetNumberFormat function uses this information
///to customize a number string for a specified locale.
struct NUMBERFMTW
{
    ///Number of fractional digits. This value is equivalent to the locale information specified by the value
    ///LOCALE_IDIGITS.
    uint  NumDigits;
    ///A value indicating if leading zeros should be used in decimal fields. This value is equivalent to the locale
    ///information specified by the value LOCALE_ILZERO.
    uint  LeadingZero;
    ///Number of digits in each group of numbers to the left of the decimal separator specified by <b>lpDecimalSep</b>.
    ///Values in the range 0 through 9 and 32 are valid. The most significant grouping digit indicates the number of
    ///digits in the least significant group immediately to the left of the decimal separator. Each subsequent grouping
    ///digit indicates the next significant group of digits to the left of the previous group. If the last value
    ///supplied is not 0, the remaining groups repeat the last group. Typical examples of settings for this member are:
    ///0 to group digits as in 123456789.00; 3 to group digits as in 123,456,789.00; and 32 to group digits as in
    ///12,34,56,789.00. <div class="alert"><b>Note</b> You can use settings other than the typical settings, but they
    ///will not show up in the regional and language options portion of the Control Panel. Such settings are extremely
    ///uncommon and might have unexpected results.</div> <div> </div>
    uint  Grouping;
    ///Pointer to a null-terminated decimal separator string.
    PWSTR lpDecimalSep;
    ///Pointer to a null-terminated thousand separator string.
    PWSTR lpThousandSep;
    ///Negative number mode. This mode is equivalent to the locale information specified by the value LOCALE_INEGNUMBER.
    uint  NegativeOrder;
}

///Contains information that defines the format of a currency string. The GetCurrencyFormat function uses this
///information to customize a currency string for a specified locale.
struct CURRENCYFMTA
{
    ///Number of fractional digits. This number is equivalent to LOCALE_ICURRDIGITS.
    uint NumDigits;
    ///Value indicating if leading zeros should be used in decimal fields. This value is equivalent to LOCALE_ILZERO.
    uint LeadingZero;
    ///Number of digits in each group of numbers to the left of the decimal separator specified by <b>lpDecimalSep</b>.
    ///The most significant grouping digit indicates the number of digits in the least significant group immediately to
    ///the left of the decimal separator. Each subsequent grouping digit indicates the next significant group of digits
    ///to the left of the previous group. If the last value supplied is not 0, the remaining groups repeat the last
    ///group. Typical examples of settings for this member are: 0 to group digits as in 123456789.00; 3 to group digits
    ///as in 123,456,789.00; and 32 to group digits as in 12,34,56,789.00. <div class="alert"><b>Note</b> You can use
    ///settings other than the typical settings, but they will not show up in the regional and language settings portion
    ///of the Control Panel. Such settings are extremely uncommon and might have unexpected results.</div> <div> </div>
    uint Grouping;
    ///Pointer to a null-terminated decimal separator string.
    PSTR lpDecimalSep;
    ///Pointer to a null-terminated thousand separator string.
    PSTR lpThousandSep;
    ///Negative currency mode. This mode is equivalent to LOCALE_INEGCURR.
    uint NegativeOrder;
    ///Positive currency mode. This mode is equivalent to LOCALE_ICURRENCY.
    uint PositiveOrder;
    ///Pointer to a null-terminated currency symbol string.
    PSTR lpCurrencySymbol;
}

///Contains information that defines the format of a currency string. The GetCurrencyFormat function uses this
///information to customize a currency string for a specified locale.
struct CURRENCYFMTW
{
    ///Number of fractional digits. This number is equivalent to LOCALE_ICURRDIGITS.
    uint  NumDigits;
    ///Value indicating if leading zeros should be used in decimal fields. This value is equivalent to LOCALE_ILZERO.
    uint  LeadingZero;
    ///Number of digits in each group of numbers to the left of the decimal separator specified by <b>lpDecimalSep</b>.
    ///The most significant grouping digit indicates the number of digits in the least significant group immediately to
    ///the left of the decimal separator. Each subsequent grouping digit indicates the next significant group of digits
    ///to the left of the previous group. If the last value supplied is not 0, the remaining groups repeat the last
    ///group. Typical examples of settings for this member are: 0 to group digits as in 123456789.00; 3 to group digits
    ///as in 123,456,789.00; and 32 to group digits as in 12,34,56,789.00. <div class="alert"><b>Note</b> You can use
    ///settings other than the typical settings, but they will not show up in the regional and language settings portion
    ///of the Control Panel. Such settings are extremely uncommon and might have unexpected results.</div> <div> </div>
    uint  Grouping;
    ///Pointer to a null-terminated decimal separator string.
    PWSTR lpDecimalSep;
    ///Pointer to a null-terminated thousand separator string.
    PWSTR lpThousandSep;
    ///Negative currency mode. This mode is equivalent to LOCALE_INEGCURR.
    uint  NegativeOrder;
    ///Positive currency mode. This mode is equivalent to LOCALE_ICURRENCY.
    uint  PositiveOrder;
    ///Pointer to a null-terminated currency symbol string.
    PWSTR lpCurrencySymbol;
}

///Deprecated. Contains version information about an NLS capability. Starting with Windows 8, your app should use
///NLSVERSIONINFOEX instead of <b>NLSVERSIONINFO</b>.
struct NLSVERSIONINFO
{
    ///Size, in bytes, of the structure.
    uint dwNLSVersionInfoSize;
    ///NLS version. This value is used to track changes and additions to the set of code points that have the indicated
    ///capability for a particular locale. The value is locale-specific, and increments when the capability changes. For
    ///example, using the COMPARE_STRING capability defined by the SYSNLS_FUNCTION enumeration, the version changes if
    ///sorting weights are assigned to code points that previously had no weights defined for the locale.
    uint dwNLSVersion;
    ///Defined version. This value is used to track changes in the repertoire of Unicode code points. The value
    ///increments when the Unicode repertoire is extended, for example, if more characters are defined.
    uint dwDefinedVersion;
    uint dwEffectiveId;
    GUID guidCustomVersion;
}

///Contains version information about an NLS capability.
struct NLSVERSIONINFOEX
{
    ///Size, in bytes, of the structure.
    uint dwNLSVersionInfoSize;
    ///Version. This value is used to track changes and additions to the set of code points that have the indicated
    ///capability for a particular locale. The value is locale-specific, and increments when the capability changes. For
    ///example, using the COMPARE_STRING capability defined by the SYSNLS_FUNCTION enumeration, the version changes if
    ///sorting weights are assigned to code points that previously had no weights defined for the locale.
    uint dwNLSVersion;
    ///Defined version. This value is used to track changes in the repertoire of Unicode code points. The value
    ///increments when the Unicode repertoire is extended, for example, if more characters are defined. <b>Starting with
    ///Windows 8:</b> Deprecated. Use <b>dwNLSVersion</b> instead.
    uint dwDefinedVersion;
    ///Identifier of the sort order used for the input locale for the represented version. For example, for a custom
    ///locale en-Mine that uses 0409 for a sort order identifier, this member contains "0409". If this member specifies
    ///a "real" sort, <b>guidCustomVersion</b> is set to an empty GUID. <b>Starting with Windows 8:</b> Deprecated. Use
    ///<b>guidCustomVersion</b> instead.
    uint dwEffectiveId;
    ///Unique GUID for the behavior of a custom sort used by the locale for the represented version.
    GUID guidCustomVersion;
}

///Contains information about a file, related to its use with MUI. Most of this data is stored in the resource
///configuration data for the particular file. When this structure is retrieved by GetFileMUIInfo, not all fields are
///necessarily filled in. The fields used depend on the flags that the application has passed to that function. <div
///class="alert"><b>Note</b> Your MUI applications can use the MUI macros to access this structure.</div> <div> </div>
struct FILEMUIINFO
{
    ///Size of the structure, including the buffer, which can be extended past the 8 bytes declared. The minimum value
    ///allowed is <code>sizeof(FILEMUIINFO)</code>.
    uint      dwSize;
    ///Version of the structure. The current version is 0x001.
    uint      dwVersion;
    ///The file type. Possible values are: <ul> <li>MUI_FILETYPE_NOT_LANGUAGE_NEUTRAL. The input file does not have
    ///resource configuration data. This file type is typical for older executable files. If this file type is
    ///specified, the other file types will not provide useful information.</li> <li>MUI_FILETYPE_LANGUAGE_NEUTRAL_MAIN.
    ///The input file is an LN file.</li> <li>MUI_FILETYPE_LANGUAGE_NEUTRAL_MUI. The input file is a language-specific
    ///resource file.</li> </ul>
    uint      dwFileType;
    ///Pointer to a 128-bit checksum for the file, if it is either an LN file or a language-specific resource file.
    ubyte[16] pChecksum;
    ///Pointer to a 128-bit checksum for the file, used for servicing.
    ubyte[16] pServiceChecksum;
    ///Offset, in bytes, from the beginning of the structure to the language name string for a language-specific
    ///resource file, or to the ultimate fallback language name string for an LN file.
    uint      dwLanguageNameOffset;
    ///Size of the array for which the offset is indicated by <i>dwTypeIDMainOffset</i>. The size also corresponds to
    ///the number of strings in the multi-string array indicated by <i>dwTypeNameMainOffset</i>.
    uint      dwTypeIDMainSize;
    ///Offset, in bytes, from the beginning of the structure to a DWORD array enumerating the resource types contained
    ///in the LN file.
    uint      dwTypeIDMainOffset;
    ///Offset, in bytes, from the beginning of the structure to a series of null-terminated strings in a multi-string
    ///array enumerating the resource names contained in the LN file.
    uint      dwTypeNameMainOffset;
    ///Size of the array with the offset indicated by <i>dwTypeIDMUIOffset</i>. The size also corresponds to the number
    ///of strings in the series of strings indicated by <i>dwTypeNameMUIOffset</i>.
    uint      dwTypeIDMUISize;
    ///Offset, in bytes, from the beginning of the structure to a DWORD array enumerating the resource types contained
    ///in the LN file.
    uint      dwTypeIDMUIOffset;
    ///Offset, in bytes, from the beginning of the structure to a multi-string array enumerating the resource names
    ///contained in the LN file.
    uint      dwTypeNameMUIOffset;
    ///Remainder of the allocated memory for this structure. See the Remarks section for correct use of this array.
    ubyte[8]  abBuffer;
}

struct HSAVEDUILANGUAGES__
{
    int unused;
}

struct HIMC__
{
    int unused;
}

struct HIMCC__
{
    int unused;
}

///Contains style and position information for a composition window.
struct COMPOSITIONFORM
{
    ///Position style. This member can be one of the following values: <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td>CFS_DEFAULT</td> <td>Move the composition window to the default position. The IME window can
    ///display the composition window outside the client area, such as in a floating window.</td> </tr> <tr>
    ///<td>CFS_FORCE_POSITION</td> <td>Display the upper left corner of the composition window at exactly the position
    ///specified by <b>ptCurrentPos</b>. The coordinates are relative to the upper left corner of the window containing
    ///the composition window and are not subject to adjustment by the IME.</td> </tr> <tr> <td>CFS_POINT</td>
    ///<td>Display the upper left corner of the composition window at the position specified by <b>ptCurrentPos</b>. The
    ///coordinates are relative to the upper left corner of the window containing the composition window and are subject
    ///to adjustment by the IME.</td> </tr> <tr> <td>CFS_RECT</td> <td>Display the composition window at the position
    ///specified by <b>rcArea</b>. The coordinates are relative to the upper left of the window containing the
    ///composition window.</td> </tr> </table>
    uint  dwStyle;
    ///A POINT structure containing the coordinates of the upper left corner of the composition window.
    POINT ptCurrentPos;
    ///A RECT structure containing the coordinates of the upper left and lower right corners of the composition window.
    RECT  rcArea;
}

///Contains position information for the candidate window.
struct CANDIDATEFORM
{
    ///Candidate list identifier. It is 0 for the first list, 1 for the second, and so on. The maximum index is 3.
    uint  dwIndex;
    ///Position style. This member can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td>CFS_CANDIDATEPOS</td> <td>Display the upper left corner of the candidate list window at the
    ///position specified by <b>ptCurrentPos</b>. The coordinates are relative to the upper left corner of the window
    ///containing the list window, and are subject to adjustment by the system.</td> </tr> <tr> <td>CFS_EXCLUDE</td>
    ///<td>Exclude the candidate window from the area specified by <b>rcArea</b>. The <b>ptCurrentPos</b> member
    ///specifies the coordinates of the current point of interest, typically the caret position.</td> </tr> </table>
    uint  dwStyle;
    ///A POINT structure containing the coordinates of the upper left corner of the candidate window or the caret
    ///position, depending on the value of <b>dwStyle</b>.
    POINT ptCurrentPos;
    ///A RECT structure containing the coordinates of the upper left and lower right corners of the exclusion area.
    RECT  rcArea;
}

///Contains information about a candidate list.
struct CANDIDATELIST
{
    ///Size, in bytes, of the structure, the offset array, and all candidate strings.
    uint    dwSize;
    ///Candidate style values. This member can have one or more of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td>IME_CAND_UNKNOWN</td> <td>Candidates are in a style other than listed here.</td>
    ///</tr> <tr> <td>IME_CAND_READ</td> <td>Candidates are in same reading.</td> </tr> <tr> <td>IME_CAND_CODE</td>
    ///<td>Candidates are in a code range.</td> </tr> <tr> <td>IME_CAND_MEANING</td> <td>Candidates are in same
    ///meaning.</td> </tr> <tr> <td>IME_CAND_RADICAL</td> <td>Candidates use same radical character.</td> </tr> <tr>
    ///<td>IME_CAND_STROKES</td> <td>Candidates are in same number of strokes.</td> </tr> </table> For the IME_CAND_CODE
    ///style, the candidate list has a special structure depending on the value of the <b>dwCount</b> member. If
    ///<b>dwCount</b> is 1, the <b>dwOffset</b> member contains a single DBCS character rather than an offset, and no
    ///candidate string is provided. If the <b>dwCount</b> member is greater than 1, the <b>dwOffset</b> member contains
    ///valid offsets, and the candidate strings are text representations of individual DBCS character values in
    ///hexadecimal notation.
    uint    dwStyle;
    ///Number of candidate strings.
    uint    dwCount;
    ///Index of the selected candidate string.
    uint    dwSelection;
    ///Index of the first candidate string in the candidate window. This varies as the user presses the PAGE UP and PAGE
    ///DOWN keys.
    uint    dwPageStart;
    ///Number of candidate strings to be shown in one page in the candidate window. The user can move to the next page
    ///by pressing IME-defined keys, such as the PAGE UP or PAGE DOWN key. If this number is 0, an application can
    ///define a proper value by itself.
    uint    dwPageSize;
    ///Offset to the start of the first candidate string, relative to the start of this structure. The offsets for
    ///subsequent strings immediately follow this member, forming an array of 32-bit offsets.
    uint[1] dwOffset;
}

///Contains reading information or a word to register.
struct REGISTERWORDA
{
    ///Pointer to the reading information for the word to register. If the reading information is not needed, the member
    ///can be set to <b>NULL</b>.
    PSTR lpReading;
    ///Pointer to the word to register. If a word is not needed, the member can be set to <b>NULL</b>.
    PSTR lpWord;
}

///Contains reading information or a word to register.
struct REGISTERWORDW
{
    ///Pointer to the reading information for the word to register. If the reading information is not needed, the member
    ///can be set to <b>NULL</b>.
    PWSTR lpReading;
    ///Pointer to the word to register. If a word is not needed, the member can be set to <b>NULL</b>.
    PWSTR lpWord;
}

///Defines the strings for IME reconversion. It is the first item in a memory block that contains the strings for
///reconversion.
struct RECONVERTSTRING
{
    ///Size of this structure and the memory block it heads.
    uint dwSize;
    ///Version number. Must be 0.
    uint dwVersion;
    ///Length of the string that contains the composition string.
    uint dwStrLen;
    ///Offset from the start position of this structure.
    uint dwStrOffset;
    ///Length of the string that will be the composition string.
    uint dwCompStrLen;
    ///Offset of the string that will be the composition string.
    uint dwCompStrOffset;
    ///Length of the string that is related to the target clause in the composition string.
    uint dwTargetStrLen;
    ///Offset of the target string.
    uint dwTargetStrOffset;
}

///Contains the identifier and name of a style.
struct STYLEBUFA
{
    ///Style of the register string. Can be IME_REGWORD_STYLE_EUDC to indicate a string in the EUDC range.
    uint     dwStyle;
    ///Description of the style.
    byte[32] szDescription;
}

///Contains the identifier and name of a style.
struct STYLEBUFW
{
    ///Style of the register string. Can be IME_REGWORD_STYLE_EUDC to indicate a string in the EUDC range.
    uint       dwStyle;
    ///Description of the style.
    ushort[32] szDescription;
}

///Contains information about IME menu items.
struct IMEMENUITEMINFOA
{
    ///Size, in bytes, of the structure.
    uint     cbSize;
    ///Menu item type. This member can have one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td>IMFT_RADIOCCHECK</td> <td>Display checked menu items using a radio-button mark instead of a check
    ///mark if the <b>hbmpChecked</b> member is <b>NULL</b>.</td> </tr> <tr> <td>IMFT_SEPARATOR</td> <td>Menu item is a
    ///separator. A menu item separator appears as a horizontal dividing line. The <b>hbmpItem</b> and <b>szString</b>
    ///members are ignored in this case.</td> </tr> <tr> <td>IMFT_SUBMENU</td> <td>Menu item is a submenu.</td> </tr>
    ///</table>
    uint     fType;
    ///Menu item state. This member can have one or more of the following values: <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td>IMFS_CHECKED</td> <td>The menu item is checked. For more information, see the
    ///description of the <b>hbmpChecked</b> member.</td> </tr> <tr> <td>IMFS_DEFAULT</td> <td>The menu item is the
    ///default. A menu can contain only one default menu item, which is displayed in bold.</td> </tr> <tr>
    ///<td>IMFS_DISABLED</td> <td>The menu item is disabled and appears dimmed so it cannot be selected. This is
    ///equivalent to IMFS_GRAYED.</td> </tr> <tr> <td>IMFS_ENABLED</td> <td>The menu item is enabled. This is the
    ///default state.</td> </tr> <tr> <td>IMFS_GRAYED</td> <td>The menu item is disabled and appears dimmed so it cannot
    ///be selected. This is equivalent to IMFS_DISABLED.</td> </tr> <tr> <td>IMFS_HILITE</td> <td>The menu item is
    ///highlighted.</td> </tr> <tr> <td>IMFS_UNCHECKED</td> <td>The menu item is unchecked. For more information about
    ///unchecked menu items, see the description of the <b>hbmpUnchecked</b> member.</td> </tr> <tr>
    ///<td>IMFS_UNHILITE</td> <td>The menu item is not highlighted. This is the default state.</td> </tr> </table>
    uint     fState;
    ///Application-defined 16-bit value that identifies the menu item.
    uint     wID;
    ///Handle to the bitmap to display next to the item if it is checked. If this member is <b>NULL</b>, a default
    ///bitmap is used. If the IMFT_RADIOCHECK type value is specified, the default bitmap is a bullet. Otherwise, it is
    ///a check mark.
    HBITMAP  hbmpChecked;
    ///Handle to the bitmap to display next to the item if it is not checked. If this member is <b>NULL</b>, no bitmap
    ///is used.
    HBITMAP  hbmpUnchecked;
    ///Application-defined value associated with the menu item.
    uint     dwItemData;
    ///Content of the menu item. This is a null-terminated string.
    byte[80] szString;
    ///Handle to a bitmap to display.
    HBITMAP  hbmpItem;
}

///Contains information about IME menu items.
struct IMEMENUITEMINFOW
{
    ///Size, in bytes, of the structure.
    uint       cbSize;
    ///Menu item type. This member can have one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td>IMFT_RADIOCCHECK</td> <td>Display checked menu items using a radio-button mark instead of a check
    ///mark if the <b>hbmpChecked</b> member is <b>NULL</b>.</td> </tr> <tr> <td>IMFT_SEPARATOR</td> <td>Menu item is a
    ///separator. A menu item separator appears as a horizontal dividing line. The <b>hbmpItem</b> and <b>szString</b>
    ///members are ignored in this case.</td> </tr> <tr> <td>IMFT_SUBMENU</td> <td>Menu item is a submenu.</td> </tr>
    ///</table>
    uint       fType;
    ///Menu item state. This member can have one or more of the following values: <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td>IMFS_CHECKED</td> <td>The menu item is checked. For more information, see the
    ///description of the <b>hbmpChecked</b> member.</td> </tr> <tr> <td>IMFS_DEFAULT</td> <td>The menu item is the
    ///default. A menu can contain only one default menu item, which is displayed in bold.</td> </tr> <tr>
    ///<td>IMFS_DISABLED</td> <td>The menu item is disabled and appears dimmed so it cannot be selected. This is
    ///equivalent to IMFS_GRAYED.</td> </tr> <tr> <td>IMFS_ENABLED</td> <td>The menu item is enabled. This is the
    ///default state.</td> </tr> <tr> <td>IMFS_GRAYED</td> <td>The menu item is disabled and appears dimmed so it cannot
    ///be selected. This is equivalent to IMFS_DISABLED.</td> </tr> <tr> <td>IMFS_HILITE</td> <td>The menu item is
    ///highlighted.</td> </tr> <tr> <td>IMFS_UNCHECKED</td> <td>The menu item is unchecked. For more information about
    ///unchecked menu items, see the description of the <b>hbmpUnchecked</b> member.</td> </tr> <tr>
    ///<td>IMFS_UNHILITE</td> <td>The menu item is not highlighted. This is the default state.</td> </tr> </table>
    uint       fState;
    ///Application-defined 16-bit value that identifies the menu item.
    uint       wID;
    ///Handle to the bitmap to display next to the item if it is checked. If this member is <b>NULL</b>, a default
    ///bitmap is used. If the IMFT_RADIOCHECK type value is specified, the default bitmap is a bullet. Otherwise, it is
    ///a check mark.
    HBITMAP    hbmpChecked;
    ///Handle to the bitmap to display next to the item if it is not checked. If this member is <b>NULL</b>, no bitmap
    ///is used.
    HBITMAP    hbmpUnchecked;
    ///Application-defined value associated with the menu item.
    uint       dwItemData;
    ///Content of the menu item. This is a null-terminated string.
    ushort[80] szString;
    ///Handle to a bitmap to display.
    HBITMAP    hbmpItem;
}

///Contains information about the character position in the composition window.
struct IMECHARPOSITION
{
    ///Size of the structure, in bytes.
    uint  dwSize;
    ///Character offset in the composition string, in <b>TCHAR</b> values.
    uint  dwCharPos;
    ///A POINT structure containing the coordinate of the top left point of requested character in screen coordinates.
    ///The top left point is based on the character baseline in any text flow.
    POINT pt;
    ///Height of a line that contains the requested character, in pixels.
    uint  cLineHeight;
    ///A RECT structure containing the editable area for text, in screen coordinates, for the application.
    RECT  rcDocument;
}

///Contains information about an ELS service.
struct MAPPING_SERVICE_INFO
{
    ///Size of the structure, used to validate the structure version. This value is required.
    size_t Size;
    ///Pointer to copyright information about the service.
    PWSTR  pszCopyright;
    ///Major version number that is used to track changes to the service.
    ushort wMajorVersion;
    ///Minor version number that is used to track changes to the service.
    ushort wMinorVersion;
    ///Build version that is used to track changes to the service.
    ushort wBuildVersion;
    ///Step version that is used to track changes to the service.
    ushort wStepVersion;
    ///Number of content types that the service can receive.
    uint   dwInputContentTypesCount;
    ///Optional. Pointer to an array of input content types, following the format of the MIME content types, that
    ///identify the format that the service interprets when the application passes data. Examples of content types are
    ///"text/plain", "text/html" and "text/css". <div class="alert"><b>Note</b> In Windows 7, the ELS services support
    ///only the content type "text/plain". A content types specification can be found at Text Media Types.</div> <div>
    ///</div>
    PWSTR* prgInputContentTypes;
    ///Number of content types in which the service can format results.
    uint   dwOutputContentTypesCount;
    ///Optional. Pointer to an array of output content types, following the format of the MIME content types, that
    ///identify the format in which the service retrieves data.
    PWSTR* prgOutputContentTypes;
    ///Number of input languages supported by the service. This member is set to 0 if the service can accept data in any
    ///language.
    uint   dwInputLanguagesCount;
    ///Pointer to an array of the input languages, following the IETF naming convention, that the service accepts. This
    ///member is set to <b>NULL</b> if the service can work with any input language.
    PWSTR* prgInputLanguages;
    ///Number of output languages supported by the service. This member is set to 0 if the service can retrieve data in
    ///any language, or if the service ignores the output language.
    uint   dwOutputLanguagesCount;
    ///Pointer to an array of output languages, following the IETF naming convention, in which the service can retrieve
    ///results. This member is set to <b>NULL</b> if the service can retrieve results in any language, or if the service
    ///ignores the output language.
    PWSTR* prgOutputLanguages;
    ///Number of input scripts supported by the service. This member is set to 0 if the service can accept data in any
    ///script.
    uint   dwInputScriptsCount;
    ///Pointer to an array of input scripts, with Unicode standard script names, that are supported by the service. This
    ///member is set to <b>NULL</b> if the service can work with any scripts, or if the service ignores the input
    ///scripts.
    PWSTR* prgInputScripts;
    ///Number of output scripts supported by the service. This member is set to 0 if the service can retrieve data in
    ///any script, or if the service ignores the output scripts.
    uint   dwOutputScriptsCount;
    ///Pointer to an array of output scripts supported by the service. This member is set to <b>NULL</b> if the service
    ///can work with any scripts, or the service ignores the output scripts.
    PWSTR* prgOutputScripts;
    ///Globally unique identifier (GUID) for the service.
    GUID   guid;
    ///Pointer to the service category for the service, for example, "Language Detection".
    PWSTR  pszCategory;
    ///Pointer to the service description. This text can be localized.
    PWSTR  pszDescription;
    ///Size, in bytes, of the private data for the service. This member is set to 0 if there is no private data.
    uint   dwPrivateDataSize;
    ///Pointer to private data that the service can expose. This information is static and updated during installation
    ///of the service.
    void*  pPrivateData;
    ///Reserved for internal use.
    void*  pContext;
    uint   _bitfield51;
}

///Contains options used by the MappingGetServices function to enumerate ELS services.
struct MAPPING_ENUM_OPTIONS
{
    ///Size of the structure, used to validate the structure version. This value is required.
    size_t Size;
    ///Optional. Pointer to a service category, for example, "Language Detection". The application must set this member
    ///to <b>NULL</b> if the service category is not a search criterion.
    PWSTR  pszCategory;
    ///Optional. Pointer to an input language string, following the IETF naming convention, that identifies the input
    ///language that services should accept. The application can set this member to <b>NULL</b> if the supported input
    ///language is not a search criterion.
    PWSTR  pszInputLanguage;
    ///Optional. Pointer to an output language string, following the IETF naming convention, that identifies the output
    ///language that services use to retrieve results. The application can set this member to <b>NULL</b> if the output
    ///language is not a search criterion.
    PWSTR  pszOutputLanguage;
    ///Optional. Pointer to a standard Unicode script name that can be accepted by services. The application set this
    ///member to <b>NULL</b> if the input script is not a search criterion.
    PWSTR  pszInputScript;
    ///Optional. Pointer to a standard Unicode script name used by services. The application can set this member to
    ///<b>NULL</b> if the output script is not a search criterion.
    PWSTR  pszOutputScript;
    ///Optional. Pointer to a string, following the format of the MIME content types, that identifies the format that
    ///the services should be able to interpret when the application passes data. Examples of content types are
    ///"text/plain", "text/html", and "text/css". The application can set this member to <b>NULL</b> if the input
    ///content type is not a search criterion. <div class="alert"><b>Note</b> In Windows 7, the ELS services support
    ///only the content type "text/plain". A content type specification can be found at Text Media Types.</div> <div>
    ///</div>
    PWSTR  pszInputContentType;
    ///Optional. Pointer to a string, following the format of the MIME content types, that identifies the format in
    ///which the services retrieve data. The application can set this member to <b>NULL</b> if the output content type
    ///is not a search criterion.
    PWSTR  pszOutputContentType;
    ///Optional. Pointer to a globally unique identifier (GUID) structure for a specific service. The application must
    ///set this member to <b>NULL</b> if the GUID is not a search criterion.
    GUID*  pGuid;
    uint   _bitfield52;
}

///Contains options for text recognition. The values stored in this structure affect the behavior and results of
///MappingRecognizeText.
struct MAPPING_OPTIONS
{
    ///Size of the structure, used to validate the structure version. This value is required.
    size_t Size;
    ///Optional. Pointer to an input language string, following the IETF naming convention, that identifies the input
    ///language that the service should be able to accept. The application can set this member to <b>NULL</b> to
    ///indicate that the service is free to interpret the input as any input language it supports.
    PWSTR  pszInputLanguage;
    ///Optional. Pointer to an output language string, following the IETF naming convention, that identifies the output
    ///language that the service should be able to use to produce results. The application can set this member to
    ///<b>NULL</b> if the service should decide the output language.
    PWSTR  pszOutputLanguage;
    ///Optional. Pointer to a standard Unicode script name that should be accepted by the service. The application can
    ///set this member to <b>NULL</b> to let the service decide how handle the input.
    PWSTR  pszInputScript;
    ///Optional. Pointer to a standard Unicode script name that the service should use to retrieve results. The
    ///application can set this member to <b>NULL</b> to let the service decide the output script.
    PWSTR  pszOutputScript;
    ///Optional. Pointer to a string, following the format of the MIME content types, that identifies the format that
    ///the service should be able to interpret when the application passes data. Examples of content types are
    ///"text/plain", "text/html", and "text/css". The application can set this member to <b>NULL</b> to indicate the
    ///"text/plain" content type. <div class="alert"><b>Note</b> In Windows 7, the ELS services support only the content
    ///type "text/plain". A content type specification can be found at Text Media Types.</div> <div> </div>
    PWSTR  pszInputContentType;
    ///Optional. Pointer to a string, following the format of the MIME content types, that identifies the format in
    ///which the service should retrieve data. The application can set this member to <b>NULL</b> to let the service
    ///decide the output content type.
    PWSTR  pszOutputContentType;
    ///Reserved.
    PWSTR  pszUILanguage;
    ///Optional. Pointer to an application callback function to receive callbacks with the results from the
    ///MappingRecognizeText function. If a callback function is specified, text recognition is executed in asynchronous
    ///mode and the application obtains results through the callback function. The application must set this member to
    ///<b>NULL</b> if text recognition is to be synchronous.
    PFN_MAPPINGCALLBACKPROC pfnRecognizeCallback;
    ///Optional. Pointer to private application data passed to the callback function by a service after text recognition
    ///is complete. The application must set this member to <b>NULL</b> to indicate no private application data.
    void*  pRecognizeCallerData;
    ///Optional. Size, in bytes, of any private application data indicated by the <b>pRecognizeCallerData</b> member.
    uint   dwRecognizeCallerDataSize;
    ///Reserved.
    PFN_MAPPINGCALLBACKPROC pfnActionCallback;
    ///Reserved.
    void*  pActionCallerData;
    ///Reserved.
    uint   dwActionCallerDataSize;
    ///Optional. Private flag that a service provider defines to affect service behavior. Services can interpret this
    ///flag as they require. <div class="alert"><b>Note</b> For Windows 7, none of the available ELS services support
    ///flags.</div> <div> </div>
    uint   dwServiceFlag;
    uint   _bitfield53;
}

///Contains text recognition results for a recognized text subrange. An array of structures of this type is retrieved by
///an Extended Linguistic Services (ELS) service in a MAPPING_PROPERTY_BAG structure.
struct MAPPING_DATA_RANGE
{
    ///Index of the beginning of the subrange in the text, where 0 indicates the character at the pointer passed to
    ///MappingRecognizeText, instead of an offset to the index passed to the function in the <i>dwIndex</i> parameter.
    ///The value should be less than the entire length of the text.
    uint   dwStartIndex;
    ///Index of the end of the subrange in the text, where 0 indicates the character at the pointer passed to
    ///MappingRecognizeText, instead of an offset to the index passed to the function in the <i>dwIndex</i> parameter.
    ///The value should be less than the entire length of the text.
    uint   dwEndIndex;
    ///Reserved.
    PWSTR  pszDescription;
    ///Reserved.
    uint   dwDescriptionLength;
    ///Pointer to data retrieved as service output associated with the subrange. This data must be of the format
    ///indicated by the content type supplied in the <b>pszContentType</b> member.
    void*  pData;
    ///Size, in bytes, of the data specified in <b>pData</b>. Each service is required to report its output data size in
    ///bytes.
    uint   dwDataSize;
    ///Optional. Pointer to a string specifying the MIME content type of the data indicated by <b>pData</b>. Examples of
    ///content types are "text/plain", "text/html", and "text/css". <div class="alert"><b>Note</b> In Windows 7, the ELS
    ///services support only the content type "text/plain". A content type specification can be found at Text Media
    ///Types.</div> <div> </div>
    PWSTR  pszContentType;
    ///Available action Ids for this subrange. They are usable for calling MappingDoAction. <div
    ///class="alert"><b>Note</b> In Windows 7, the ELS services do not expose any actions.</div> <div> </div>
    PWSTR* prgActionIds;
    ///The number of available actions for this subrange. <div class="alert"><b>Note</b> In Windows 7, the ELS services
    ///do not expose any actions.</div> <div> </div>
    uint   dwActionsCount;
    ///Action display names for this subrange. These strings can be localized. <div class="alert"><b>Note</b> In Windows
    ///7, the ELS services do not expose any actions.</div> <div> </div>
    PWSTR* prgActionDisplayNames;
}

///Contains the text recognition data properties retrieved by MappingRecognizeText.
struct MAPPING_PROPERTY_BAG
{
    ///Size of the structure, used to verify the structure version. This value is required.
    size_t              Size;
    ///Pointer to an array of MAPPING_DATA_RANGE structures containing all recognized text range results. This member is
    ///populated by MappingRecognizeText.
    MAPPING_DATA_RANGE* prgResultRanges;
    ///Number of items in the array indicated by <b>prgResultRanges</b>. This member is populated by
    ///MappingRecognizeText.
    uint                dwRangesCount;
    ///Pointer to private service data. The service can document the format of this data so that the application can use
    ///it. The service also manages the memory for this data. This member is populated by MappingRecognizeText.
    void*               pServiceData;
    ///Size, in bytes, of the private service data specified by <b>pServiceData</b>. The size is set to 0 if there is no
    ///private data. This member is populated by MappingRecognizeText.
    uint                dwServiceDataSize;
    ///Pointer to private application data to pass to the service. The application manages the memory for this data.
    void*               pCallerData;
    ///Size, in bytes, of the private application data indicated in <b>pCallerData</b>. This member is set to 0 if there
    ///is no private data.
    uint                dwCallerDataSize;
    ///Reserved for internal use.
    void*               pContext;
}

///Used when invoking the Microsoft IME's Dictionary Tool or Word Register Dialog Window from the app.
struct IMEDLG
{
align (1):
    ///The size of this structure. You must set this value before using the structure.
    int   cbIMEDLG;
    ///The parent window handle of the Register Word Dialog.
    HWND  hwnd;
    ///<b>NULL</b>, or the string to be registered. It shows in the Word Register Dialog's "Display" field.
    PWSTR lpwstrWord;
    ///The initial tab ID, 0 or 1.
    int   nTabId;
}

struct WDD
{
align (1):
    ushort wDispPos;
union
    {
    align (1):
        ushort wReadPos;
        ushort wCompPos;
    }
    ushort cchDisp;
union
    {
    align (1):
        ushort cchRead;
        ushort cchComp;
    }
    uint   WDD_nReserve1;
    ushort nPos;
    ushort _bitfield54;
    void*  pReserved;
}

struct MORRSLT
{
align (1):
    uint    dwSize;
    PWSTR   pwchOutput;
    ushort  cchOutput;
union
    {
    align (1):
        PWSTR pwchRead;
        PWSTR pwchComp;
    }
union
    {
    align (1):
        ushort cchRead;
        ushort cchComp;
    }
    ushort* pchInputPos;
    ushort* pchOutputIdxWDD;
union
    {
    align (1):
        ushort* pchReadIdxWDD;
        ushort* pchCompIdxWDD;
    }
    ushort* paMonoRubyPos;
    WDD*    pWDD;
    int     cWDD;
    void*   pPrivate;
    ushort  BLKBuff;
}

///Contains data about a word in the Word data of the Microsoft IME dictionary.
struct IMEWRD
{
align (1):
    ///The reading string.
    PWSTR   pwchReading;
    ///The display string.
    PWSTR   pwchDisplay;
union
    {
    align (1):
        uint ulPos;
struct
        {
        align (1):
            ushort nPos1;
            ushort nPos2;
        }
    }
    ///Reserved.
    uint[2] rgulAttrs;
    ///Size of the comment, in bytes, of <b>pvComment</b>.
    int     cbComment;
    ///Type of comment. This must be one of the values of the IMEUCT enumeration.
    IMEUCT  uct;
    ///Comment string.
    void*   pvComment;
}

///The header of an opened user dictionary file. Used to get the user dictionary's properties, such as version, title,
///description, and copyright.
struct IMESHF
{
align (1):
    ///The size of this structure. You must set this value before using the structure.
    ushort    cbShf;
    ///Dictionary version.
    ushort    verDic;
    ///Dictionary title.
    byte[48]  szTitle;
    ///Dictionary description.
    byte[256] szDescription;
    ///Dictionary copyright information.
    byte[128] szCopyright;
}

///An entry in the public POS (Part of Speech) table.
struct POSTBL
{
align (1):
    ///The number of the part of speech.
    ushort nPos;
    ///The name of the part of speech.
    ubyte* szName;
}

struct IMEDP
{
align (1):
    IMEWRD wrdModifier;
    IMEWRD wrdModifiee;
    IMEREL relID;
}

struct IMEKMSINIT
{
align (1):
    int  cbSize;
    HWND hWnd;
}

struct IMEKMSKEY
{
align (1):
    uint dwStatus;
    uint dwCompStatus;
    uint dwVKEY;
union
    {
    align (1):
        uint dwControl;
        uint dwNotUsed;
    }
union
    {
    align (1):
        ushort[31] pwszDscr;
        ushort[31] pwszNoUse;
    }
}

struct IMEKMS
{
align (1):
    int        cbSize;
    HIMC__*    hIMC;
    uint       cKeyList;
    IMEKMSKEY* pKeyList;
}

struct IMEKMSNTFY
{
align (1):
    int     cbSize;
    HIMC__* hIMC;
    BOOL    fSelect;
}

struct IMEKMSKMP
{
align (1):
    int        cbSize;
    HIMC__*    hIMC;
    ushort     idLang;
    ushort     wVKStart;
    ushort     wVKEnd;
    int        cKeyList;
    IMEKMSKEY* pKeyList;
}

struct IMEKMSINVK
{
align (1):
    int     cbSize;
    HIMC__* hIMC;
    uint    dwControl;
}

struct IMEKMSFUNCDESC
{
align (1):
    int         cbSize;
    ushort      idLang;
    uint        dwControl;
    ushort[128] pwszDescription;
}

struct COMPOSITIONSTRING
{
    uint dwSize;
    uint dwCompReadAttrLen;
    uint dwCompReadAttrOffset;
    uint dwCompReadClauseLen;
    uint dwCompReadClauseOffset;
    uint dwCompReadStrLen;
    uint dwCompReadStrOffset;
    uint dwCompAttrLen;
    uint dwCompAttrOffset;
    uint dwCompClauseLen;
    uint dwCompClauseOffset;
    uint dwCompStrLen;
    uint dwCompStrOffset;
    uint dwCursorPos;
    uint dwDeltaStart;
    uint dwResultReadClauseLen;
    uint dwResultReadClauseOffset;
    uint dwResultReadStrLen;
    uint dwResultReadStrOffset;
    uint dwResultClauseLen;
    uint dwResultClauseOffset;
    uint dwResultStrLen;
    uint dwResultStrOffset;
    uint dwPrivateSize;
    uint dwPrivateOffset;
}

struct GUIDELINE
{
    uint dwSize;
    uint dwLevel;
    uint dwIndex;
    uint dwStrLen;
    uint dwStrOffset;
    uint dwPrivateSize;
    uint dwPrivateOffset;
}

struct TRANSMSG
{
    uint   message;
    WPARAM wParam;
    LPARAM lParam;
}

struct TRANSMSGLIST
{
    uint        uMsgCount;
    TRANSMSG[1] TransMsg;
}

struct CANDIDATEINFO
{
    uint     dwSize;
    uint     dwCount;
    uint[32] dwOffset;
    uint     dwPrivateSize;
    uint     dwPrivateOffset;
}

struct INPUTCONTEXT
{
    HWND             hWnd;
    BOOL             fOpen;
    POINT            ptStatusWndPos;
    POINT            ptSoftKbdPos;
    uint             fdwConversion;
    uint             fdwSentence;
union lfFont
    {
        LOGFONTA A;
        LOGFONTW W;
    }
    COMPOSITIONFORM  cfCompForm;
    CANDIDATEFORM[4] cfCandForm;
    HIMCC__*         hCompStr;
    HIMCC__*         hCandInfo;
    HIMCC__*         hGuideLine;
    HIMCC__*         hPrivate;
    uint             dwNumMsgBuf;
    HIMCC__*         hMsgBuf;
    uint             fdwInit;
    uint[3]          dwReserve;
}

struct IMEINFO
{
    uint dwPrivateDataSize;
    uint fdwProperty;
    uint fdwConversionCaps;
    uint fdwSentenceCaps;
    uint fdwUICaps;
    uint fdwSCSCaps;
    uint fdwSelectCaps;
}

struct SOFTKBDDATA
{
    uint        uCount;
    ushort[256] wCode;
}

///Specifies an IImePadApplet IID list.
struct APPLETIDLIST
{
    ///The number of the IID's implemented in this applet.
    int   count;
    GUID* pIIDList;
}

struct IMESTRINGCANDIDATE
{
    uint       uCount;
    ushort[1]* lpwstr;
}

struct IMEITEM
{
    int   cbSize;
    int   iType;
    void* lpItemData;
}

struct IMEITEMCANDIDATE
{
    uint       uCount;
    IMEITEM[1] imeItem;
}

struct tabIMESTRINGINFO
{
    uint  dwFarEastId;
    PWSTR lpwstr;
}

struct tabIMEFAREASTINFO
{
    uint    dwSize;
    uint    dwType;
    uint[1] dwData;
}

struct IMESTRINGCANDIDATEINFO
{
    uint               dwFarEastId;
    tabIMEFAREASTINFO* lpFarEastInfo;
    uint               fInfoMask;
    int                iSelIndex;
    uint               uCount;
    ushort[1]*         lpwstr;
}

///Contains information of IME's composition string in an app.
struct IMECOMPOSITIONSTRINGINFO
{
    ///Length (number of <b>WCHAR</b>s) of composition string.
    int iCompStrLen;
    ///Caret position of composition string.
    int iCaretPos;
    ///Position of composition string that is editable.
    int iEditStart;
    ///Length of composition string that is editable.
    int iEditLen;
    ///Start position of target phrase of composition string.
    int iTargetStart;
    ///Target phrase length of composition string.
    int iTargetLen;
}

struct IMECHARINFO
{
    ushort wch;
    uint   dwCharInfo;
}

///Used to specify and set applet configuration in IImePad.
struct IMEAPPLETCFG
{
    ///Combination of <b>IPACFG_*</b> flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="IPACFG_NONE"></a><a id="ipacfg_none"></a><dl> <dt><b>IPACFG_NONE</b></dt> </dl> </td> <td width="60%"></td>
    ///</tr> <tr> <td width="40%"><a id="IPACFG_PROPERTY"></a><a id="ipacfg_property"></a><dl>
    ///<dt><b>IPACFG_PROPERTY</b></dt> </dl> </td> <td width="60%"> The applet has a property Dialog. If this flag is
    ///set, IImePad calls IImePadApplet::Notify with <b>IMEPN_CFG</b>. </td> </tr> <tr> <td width="40%"><a
    ///id="IPACFG_HELP"></a><a id="ipacfg_help"></a><dl> <dt><b>IPACFG_HELP</b></dt> </dl> </td> <td width="60%"> The
    ///applet has help. If this flag is set, IImePad calls IImePadApplet::Notify with <b>IMEPN_HELP</b>. </td> </tr>
    ///<tr> <td width="40%"><a id="IPACFG_TITLE"></a><a id="ipacfg_title"></a><dl> <dt><b>IPACFG_TITLE</b></dt> </dl>
    ///</td> <td width="60%"> <b>wchTitle</b> is set. </td> </tr> <tr> <td width="40%"><a
    ///id="IPACFG_TITLEFONTFACE"></a><a id="ipacfg_titlefontface"></a><dl> <dt><b>IPACFG_TITLEFONTFACE</b></dt> </dl>
    ///</td> <td width="60%"> <b>wchTitleFontFace</b> and <b>dwCharSet</b> are set. </td> </tr> <tr> <td width="40%"><a
    ///id="IPACFG_CATEGORY"></a><a id="ipacfg_category"></a><dl> <dt><b>IPACFG_CATEGORY</b></dt> </dl> </td> <td
    ///width="60%"> <b>iCategory</b> is set. </td> </tr> <tr> <td width="40%"><a id="IPACFG_LANG"></a><a
    ///id="ipacfg_lang"></a><dl> <dt><b>IPACFG_LANG</b></dt> </dl> </td> <td width="60%"> <b>LangID</b> is set. </td>
    ///</tr> </table>
    uint       dwConfig;
    ///The applet's title, in Unicode.
    ushort[64] wchTitle;
    ///The applet title's FontFace name.
    ushort[32] wchTitleFontFace;
    ///The applet font's character set.
    uint       dwCharSet;
    ///Not used.
    int        iCategory;
    ///The icon handle for the ImePad applet's menu.
    HICON      hIcon;
    ///The applet's language ID.
    ushort     langID;
    ///Not used.
    ushort     dummy;
    ///Reserved.
    LPARAM     lReserved1;
}

///Used by IImePadApplet::CreateUI to specify applet window style.
struct IMEAPPLETUI
{
    ///Window handle created by applet window.
    HWND   hwnd;
    ///Applet window style. The style is a combination of <b>IPAWS_*</b> flags; see the Remarks of IImePad::Request for
    ///the possible <b>IPAWS_*</b> flags.
    uint   dwStyle;
    ///The applet window's initial width.
    int    width;
    ///The applet window's initial height.
    int    height;
    ///Minimum width of the applet window. Valid only when <b>IPAWS_MINWIDTHFIXED</b> style is set in <i>dwStyle</i>.
    int    minWidth;
    ///Minimum height of applet window. Valid only when <b>IPAWS_MINHEIGHTFIXED</b> is set in <i>dwStyle</i>.
    int    minHeight;
    ///Maximum width of applet window. Valid only when <b>IPAWS_MAXWIDTHFIXED</b> is set in <i>dwStyle</i>.
    int    maxWidth;
    ///Maximum height of applet window. Valid only when <b>IPAWS_MAXHEIGHTFIXED</b> is set in <i>dwStyle</i>.
    int    maxHeight;
    ///Reserved.
    LPARAM lReserved1;
    LPARAM lReserved2;
}

struct APPLYCANDEXPARAM
{
    uint  dwSize;
    PWSTR lpwstrDisplay;
    PWSTR lpwstrReading;
    uint  dwReserved;
}

///Contains script control flags for several Uniscribe functions, for example, ScriptItemize.
struct SCRIPT_CONTROL
{
    uint _bitfield55;
}

///Contains script state information.
struct SCRIPT_STATE
{
    ushort _bitfield56;
}

///Contains a portion of a Unicode string, that is, an "item".
struct SCRIPT_ANALYSIS
{
    ushort       _bitfield57;
    ///A SCRIPT_STATE structure containing a copy of the Unicode algorithm state.
    SCRIPT_STATE s;
}

///Contains a script item, including a SCRIPT_ANALYSIS structure with the string offset of the first character of the
///item.
struct SCRIPT_ITEM
{
    ///Offset from the beginning of the itemized string to the first character of the item, counted in Unicode code
    ///points (WCHAR values).
    int             iCharPos;
    ///A SCRIPT_ANALYSIS structure containing the analysis of the item.
    SCRIPT_ANALYSIS a;
}

///Contains the visual (glyph) attributes that identify clusters and justification points, as generated by ScriptShape.
struct SCRIPT_VISATTR
{
    ushort _bitfield58;
}

///Contains the x and y offsets of the combining glyph.
struct GOFFSET
{
    ///x offset, in logical units, for the combining glyph.
    int du;
    ///y offset, in logical units, for the combining glyph.
    int dv;
}

///Contains attributes of logical characters that are useful when editing and formatting text.
struct SCRIPT_LOGATTR
{
    ubyte _bitfield59;
}

///Contains information about special processing for each script.
struct SCRIPT_PROPERTIES
{
    uint _bitfield1;
    uint _bitfield2;
}

///Contains information about the properties of the current font.
struct SCRIPT_FONTPROPERTIES
{
    ///Size, in bytes, of the structure.
    int    cBytes;
    ///Glyph used to indicate a blank.
    ushort wgBlank;
    ///Glyph used to indicate Unicode characters not present in the font.
    ushort wgDefault;
    ///Glyph used to indicate invalid character combinations.
    ushort wgInvalid;
    ///Glyph used to indicate the shortest continuous kashida, with 1 indicating that the font contains no kashida.
    ushort wgKashida;
    ///Width of the shortest continuous kashida glyph in the font, indicated by the <b>wgKashida</b> member.
    int    iKashidaWidth;
}

///Contains definitions of the tab positions for ScriptStringAnalyse.
struct SCRIPT_TABDEF
{
    ///Number of entries in the array indicated by <b>pTabStops</b>. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td>0</td> <td>Tab stops occur every eight average character widths.</td> </tr> <tr> <td>1</td> <td>All tab
    ///stops are the length of the first entry in the array indicated by <b>pTabStops</b>.</td> </tr> <tr> <td>greater
    ///than 1</td> <td>The first <b>cTabStops</b> tab stops are as specified in the array indicated by <b>pTabStops</b>,
    ///and subsequent tab stops are every eight average characters.</td> </tr> </table>
    int  cTabStops;
    ///Scale factor for <b>iTabOrigin</b> and <b>pTabStops</b> values. Values are converted to device coordinates by
    ///multiplying by the value indicated by <b>iScale</b>, then dividing by 4. If values are already in device units,
    ///set <b>iScale</b> to 4. If values are in dialog units, set <b>iScale</b> to the average character width of the
    ///dialog font. If values are multiples of the average character width for the selected font, set <b>iScale</b> to
    ///0.
    int  iScale;
    ///Pointer to an array having the number of entries indicated by <b>cTabStops</b>. Each entry specifies a tab stop
    ///position. Positive values represent near-edge alignment, while negative values represent far-edge alignment. The
    ///units for the array elements are as indicated by the value of <b>iScale</b>.
    int* pTabStops;
    ///Initial offset, in logical units, for tab stops. Tabs start <b>iTabOrigin</b> logical units before the beginning
    ///of the string. This rule helps with situations in which multiple tabbed outputs occur on the same line.
    int  iTabOrigin;
}

///Contains native digit and digit substitution settings.
struct SCRIPT_DIGITSUBSTITUTE
{
    uint _bitfield1;
    uint _bitfield2;
    ///Reserved; initialize to 0.
    uint dwReserved;
}

///Contains information about a single OpenType feature to apply to a run.
struct opentype_feature_record
{
    ///OPENTYPE_TAG structure containing a registered or private OpenType feature tag. For information on feature tags,
    ///see http://www.microsoft.com/typography/otspec/featuretags.htm.
    uint tagFeature;
    ///Value indicating how to apply the feature tag. Possible values are defined in the following table. <table> <tr>
    ///<th>Value</th> <th>Description</th> </tr> <tr> <td>0</td> <td>Feature is disabled and should not be applied.</td>
    ///</tr> <tr> <td>1</td> <td>Feature is active. If the feature offers several alternatives, select the first
    ///value.</td> </tr> <tr> <td>Greater than 1</td> <td>Feature is active. Select the alternative value at this index.
    ///Should be used only when multiple alternatives are available for a feature.</td> </tr> </table>
    int  lParameter;
}

///Contains a group of OpenType features to apply to a run.
struct textrange_properties
{
    ///Pointer to an array of OPENTYPE_FEATURE_RECORD structures containing OpenType features (records) to apply to the
    ///characters in a specific range of text in a run.
    opentype_feature_record* potfRecords;
    ///Number of features in the array specified by <b>potfRecords</b>.
    int cotfRecords;
}

///Contains information about a single character in a run (input string). The information indicates if the character
///glyph is affected by surrounding letters of the run.
struct script_charprop
{
    ushort _bitfield60;
}

///Contains information about a glyph that is part of an output glyph array.
struct script_glyphprop
{
    ///A buffer of SCRIPT_VISATTR structures defining visual (glyph) attributes identifying clusters and justification
    ///points. The buffer is generated by ScriptShape or ScriptShapeOpenType.
    SCRIPT_VISATTR sva;
    ///Reserved.
    ushort         reserved;
}

struct UReplaceableCallbacks
{
    ptrdiff_t length;
    ptrdiff_t charAt;
    ptrdiff_t char32At;
    ptrdiff_t replace;
    ptrdiff_t extract;
    ptrdiff_t copy;
}

struct UFieldPosition
{
    int field;
    int beginIndex;
    int endIndex;
}

struct UCharIterator
{
    const(void)*       context;
    int                length;
    int                start;
    int                index;
    int                limit;
    int                reservedField;
    UCharIteratorGetIndex* getIndex;
    UCharIteratorMove* move;
    UCharIteratorHasNext* hasNext;
    UCharIteratorHasPrevious* hasPrevious;
    UCharIteratorCurrent* current;
    UCharIteratorNext* next;
    UCharIteratorPrevious* previous;
    UCharIteratorReserved* reservedFn;
    UCharIteratorGetState* getState;
    UCharIteratorSetState* setState;
}

struct UEnumeration
{
}

struct UResourceBundle
{
}

struct ULocaleDisplayNames
{
}

struct UConverter
{
}

struct UConverterFromUnicodeArgs
{
    ushort         size;
    byte           flush;
    UConverter*    converter;
    const(ushort)* source;
    const(ushort)* sourceLimit;
    byte*          target;
    const(byte)*   targetLimit;
    int*           offsets;
}

struct UConverterToUnicodeArgs
{
    ushort         size;
    byte           flush;
    UConverter*    converter;
    const(byte)*   source;
    const(byte)*   sourceLimit;
    ushort*        target;
    const(ushort)* targetLimit;
    int*           offsets;
}

struct USet
{
}

struct UBiDi
{
}

struct UBiDiTransform
{
}

struct UTextFuncs
{
    int                tableSize;
    int                reserved1;
    int                reserved2;
    int                reserved3;
    UTextClone*        clone;
    UTextNativeLength* nativeLength;
    UTextAccess*       access;
    UTextExtract*      extract;
    UTextReplace*      replace;
    UTextCopy*         copy;
    UTextMapOffsetToNative* mapOffsetToNative;
    UTextMapNativeIndexToUTF16* mapNativeIndexToUTF16;
    UTextClose*        close;
    UTextClose*        spare1;
    UTextClose*        spare2;
    UTextClose*        spare3;
}

struct UText
{
    uint               magic;
    int                flags;
    int                providerProperties;
    int                sizeOfStruct;
    long               chunkNativeLimit;
    int                extraSize;
    int                nativeIndexingLimit;
    long               chunkNativeStart;
    int                chunkOffset;
    int                chunkLength;
    const(ushort)*     chunkContents;
    const(UTextFuncs)* pFuncs;
    void*              pExtra;
    const(void)*       context;
    const(void)*       p;
    const(void)*       q;
    const(void)*       r;
    void*              privP;
    long               a;
    int                b;
    int                c;
    long               privA;
    int                privB;
    int                privC;
}

struct USerializedSet
{
    const(ushort)* array;
    int            bmpLength;
    int            length;
    ushort[8]      staticArray;
}

struct UNormalizer2
{
}

struct UConverterSelector
{
}

struct UBreakIterator
{
}

struct UCaseMap
{
}

struct UParseError
{
    int        line;
    int        offset;
    ushort[16] preContext;
    ushort[16] postContext;
}

struct UStringPrepProfile
{
}

struct UIDNA
{
}

struct UIDNAInfo
{
    short size;
    byte  isTransitionalDifferent;
    byte  reservedB3;
    uint  errors;
    int   reservedI2;
    int   reservedI3;
}

struct UCollator
{
}

struct UCollationElements
{
}

struct UCharsetDetector
{
}

struct UCharsetMatch
{
}

struct UFieldPositionIterator
{
}

struct UDateIntervalFormat
{
}

struct UGenderInfo
{
}

struct UListFormatter
{
}

struct ULocaleData
{
}

struct UDateFormatSymbols
{
}

struct UNumberFormatter
{
}

struct UFormattedNumber
{
}

struct UNumberingSystem
{
}

struct UPluralRules
{
}

struct URegularExpression
{
}

struct URegion
{
}

struct URelativeDateTimeFormatter
{
}

struct UStringSearch
{
}

struct USpoofChecker
{
}

struct USpoofCheckResult
{
}

struct UTransPosition
{
    int contextStart;
    int contextLimit;
    int start;
    int limit;
}

///Contains information identifying the code pages and Unicode subranges for which a given font provides glyphs.
struct FONTSIGNATURE
{
    ///A 128-bit Unicode subset bitfield (USB) identifying up to 126 Unicode subranges. Each bit, except the two most
    ///significant bits, represents a single subrange. The most significant bit is always 1 and identifies the bitfield
    ///as a font signature; the second most significant bit is reserved and must be 0. Unicode subranges are numbered in
    ///accordance with the ISO 10646 standard. For more information, see Unicode Subset Bitfields.
    uint[4] fsUsb;
    ///A 64-bit, code-page bitfield (CPB) that identifies a specific character set or code page. Code pages are in the
    ///lower 32 bits of this bitfield. The high 32 are used for non-Windows code pages. For more information, see Code
    ///Page Bitfields.
    uint[2] fsCsb;
}

///Contains information about a character set.
struct CHARSETINFO
{
    ///Character set value.
    uint          ciCharset;
    ///Windows ANSI code page identifier. For a list of identifiers, see Code Page Identifiers.
    uint          ciACP;
    ///A FONTSIGNATURE structure that identifies the Unicode subrange and the specific Windows ANSI character set/code
    ///page. Only one code page will be set when this structure is set by the function.
    FONTSIGNATURE fs;
}

///Contains extended font signature information, including two code page bitfields (CPBs) that define the default and
///supported character sets and code pages. This structure is typically used to represent the relationships between font
///coverage and locales.
struct LOCALESIGNATURE
{
    ///A 128-bit Unicode subset bitfield (USB) identifying up to 122 Unicode subranges. Each bit, except the five most
    ///significant bits, represents a single subrange. The most significant bit is always 1; the second most significant
    ///is reserved and must be 0. Unicode subsets are numbered in accordance with the OpenType font specification. For a
    ///list of possible bitfield values, see Unicode Subset Bitfields.
    uint[4] lsUsb;
    ///A code page bitfield that indicates the default OEM and ANSI code pages for a locale. The code pages can be
    ///identified by separate bits or a single bit representing a common ANSI and OEM code page. For a list of possible
    ///bitfield values, see Code Page Bitfields.
    uint[2] lsCsbDefault;
    ///A code page bitfield that indicates all the code pages in which the locale can be supported. For a list of
    ///possible bitfield values, see Code Page Bitfields.
    uint[2] lsCsbSupported;
}

// Functions

///Formats a date as a date string for a locale specified by the locale identifier. The function formats either a
///specified date or the local system date. <div class="alert"><b>Note</b> For interoperability reasons, the application
///should prefer the GetDateFormatEx function to <b>GetDateFormat</b> because Microsoft is migrating toward the use of
///locale names instead of locale identifiers for new locales. Any application that will be run only on Windows Vista
///and later should use GetDateFormatEx.</div> <div> </div>
///Params:
///    Locale = Locale identifier that specifies the locale this function formats the date string for. You can use the MAKELCID
///             macro to create a locale identifier or use one of the following predefined values. <ul> <li>
///             LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li>
///             LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul>
///    dwFlags = Flags specifying date format options. For detailed definitions, see the <i>dwFlags</i> parameter of
///              GetDateFormatEx.
///    lpDate = Pointer to a SYSTEMTIME structure that contains the date information to format. The application sets this
///             parameter to <b>NULL</b> if the function is to use the current local system date.
///    lpFormat = Pointer to a format picture string that is used to form the date. Possible values for the format picture string
///               are defined in Day, Month, Year, and Era Format Pictures. The function uses the specified locale only for
///               information not specified in the format picture string, for example, the day and month names for the locale. The
///               application can set this parameter to <b>NULL</b> to format the string according to the date format for the
///               specified locale.
///    lpDateStr = Pointer to a buffer in which this function retrieves the formatted date string.
///    cchDate = Size, in characters, of the <i>lpDateStr</i> buffer. The application can set this parameter to 0 to return the
///              buffer size required to hold the formatted date string. In this case, the buffer indicated by <i>lpDateStr</i> is
///              not used.
///Returns:
///    Returns the number of characters written to the <i>lpDateStr</i> buffer if successful. If the <i>cchDate</i>
///    parameter is set to 0, the function returns the number of characters required to hold the formatted date string,
///    including the terminating null character. The function returns 0 if it does not succeed. To get extended error
///    information, the application can call GetLastError, which can return one of the following error codes: <ul>
///    <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was incorrectly set to
///    <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int GetDateFormatA(uint Locale, uint dwFlags, const(SYSTEMTIME)* lpDate, const(PSTR) lpFormat, PSTR lpDateStr, 
                   int cchDate);

///Formats a date as a date string for a locale specified by the locale identifier. The function formats either a
///specified date or the local system date. <div class="alert"><b>Note</b> For interoperability reasons, the application
///should prefer the GetDateFormatEx function to <b>GetDateFormat</b> because Microsoft is migrating toward the use of
///locale names instead of locale identifiers for new locales. Any application that will be run only on Windows Vista
///and later should use GetDateFormatEx.</div> <div> </div>
///Params:
///    Locale = Locale identifier that specifies the locale this function formats the date string for. You can use the MAKELCID
///             macro to create a locale identifier or use one of the following predefined values. <ul> <li>
///             LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li>
///             LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul>
///    dwFlags = Flags specifying date format options. For detailed definitions, see the <i>dwFlags</i> parameter of
///              GetDateFormatEx.
///    lpDate = Pointer to a SYSTEMTIME structure that contains the date information to format. The application sets this
///             parameter to <b>NULL</b> if the function is to use the current local system date.
///    lpFormat = Pointer to a format picture string that is used to form the date. Possible values for the format picture string
///               are defined in Day, Month, Year, and Era Format Pictures. The function uses the specified locale only for
///               information not specified in the format picture string, for example, the day and month names for the locale. The
///               application can set this parameter to <b>NULL</b> to format the string according to the date format for the
///               specified locale.
///    lpDateStr = Pointer to a buffer in which this function retrieves the formatted date string.
///    cchDate = Size, in characters, of the <i>lpDateStr</i> buffer. The application can set this parameter to 0 to return the
///              buffer size required to hold the formatted date string. In this case, the buffer indicated by <i>lpDateStr</i> is
///              not used.
///Returns:
///    Returns the number of characters written to the <i>lpDateStr</i> buffer if successful. If the <i>cchDate</i>
///    parameter is set to 0, the function returns the number of characters required to hold the formatted date string,
///    including the terminating null character. The function returns 0 if it does not succeed. To get extended error
///    information, the application can call GetLastError, which can return one of the following error codes: <ul>
///    <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was incorrectly set to
///    <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int GetDateFormatW(uint Locale, uint dwFlags, const(SYSTEMTIME)* lpDate, const(PWSTR) lpFormat, PWSTR lpDateStr, 
                   int cchDate);

///Formats time as a time string for a locale specified by identifier. The function formats either a specified time or
///the local system time. <div class="alert"><b>Note</b> For interoperability reasons, the application should prefer the
///GetTimeFormatEx function to <b>GetTimeFormat</b> because Microsoft is migrating toward the use of locale names
///instead of locale identifiers for new locales. Any application that will be run only on Windows Vista and later
///should use GetTimeFormatEx.</div><div> </div>
///Params:
///    Locale = Locale identifier that specifies the locale. You can use the MAKELCID macro to create a locale identifier or use
///             one of the following predefined values. <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li>
///             <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li> LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li>
///             LOCALE_USER_DEFAULT </li> </ul>
///    dwFlags = Flags specifying time format options. For detailed definitions see the <i>dwFlags</i> parameter of
///              GetTimeFormatEx.
///    lpTime = Pointer to a SYSTEMTIME structure that contains the time information to format. The application can set this
///             parameter to <b>NULL</b> if the function is to use the current local system time.
///    lpFormat = Pointer to a format picture to use to format the time string. If the application sets this parameter to
///               <b>NULL</b>, the function formats the string according to the time format of the specified locale. If the
///               application does not set the parameter to <b>NULL</b>, the function uses the locale only for information not
///               specified in the format picture string, for example, the locale-specific time markers. For information about the
///               format picture string, see the Remarks section.
///    lpTimeStr = Pointer to a buffer in which this function retrieves the formatted time string.
///    cchTime = Size, in TCHAR values, for the time string buffer indicated by <i>lpTimeStr</i>. Alternatively, the application
///              can set this parameter to 0. In this case, the function returns the required size for the time string buffer, and
///              does not use the <i>lpTimeStr</i> parameter.
///Returns:
///    Returns the number of TCHAR values retrieved in the buffer indicated by <i>lpTimeStr</i>. If the <i>cchTime</i>
///    parameter is set to 0, the function returns the size of the buffer required to hold the formatted time string,
///    including a terminating null character. This function returns 0 if it does not succeed. To get extended error
///    information, the application can call GetLastError, which can return one of the following error codes: <ul>
///    <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was incorrectly set to
///    <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> <li>ERROR_OUTOFMEMORY. Not enough
///    storage was available to complete this operation.</li> </ul>
///    
@DllImport("KERNEL32")
int GetTimeFormatA(uint Locale, uint dwFlags, const(SYSTEMTIME)* lpTime, const(PSTR) lpFormat, PSTR lpTimeStr, 
                   int cchTime);

///Formats time as a time string for a locale specified by identifier. The function formats either a specified time or
///the local system time. <div class="alert"><b>Note</b> For interoperability reasons, the application should prefer the
///GetTimeFormatEx function to <b>GetTimeFormat</b> because Microsoft is migrating toward the use of locale names
///instead of locale identifiers for new locales. Any application that will be run only on Windows Vista and later
///should use GetTimeFormatEx.</div><div> </div>
///Params:
///    Locale = Locale identifier that specifies the locale. You can use the MAKELCID macro to create a locale identifier or use
///             one of the following predefined values. <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li>
///             <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li> LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li>
///             LOCALE_USER_DEFAULT </li> </ul>
///    dwFlags = Flags specifying time format options. For detailed definitions see the <i>dwFlags</i> parameter of
///              GetTimeFormatEx.
///    lpTime = Pointer to a SYSTEMTIME structure that contains the time information to format. The application can set this
///             parameter to <b>NULL</b> if the function is to use the current local system time.
///    lpFormat = Pointer to a format picture to use to format the time string. If the application sets this parameter to
///               <b>NULL</b>, the function formats the string according to the time format of the specified locale. If the
///               application does not set the parameter to <b>NULL</b>, the function uses the locale only for information not
///               specified in the format picture string, for example, the locale-specific time markers. For information about the
///               format picture string, see the Remarks section.
///    lpTimeStr = Pointer to a buffer in which this function retrieves the formatted time string.
///    cchTime = Size, in TCHAR values, for the time string buffer indicated by <i>lpTimeStr</i>. Alternatively, the application
///              can set this parameter to 0. In this case, the function returns the required size for the time string buffer, and
///              does not use the <i>lpTimeStr</i> parameter.
///Returns:
///    Returns the number of TCHAR values retrieved in the buffer indicated by <i>lpTimeStr</i>. If the <i>cchTime</i>
///    parameter is set to 0, the function returns the size of the buffer required to hold the formatted time string,
///    including a terminating null character. This function returns 0 if it does not succeed. To get extended error
///    information, the application can call GetLastError, which can return one of the following error codes: <ul>
///    <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was incorrectly set to
///    <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> <li>ERROR_OUTOFMEMORY. Not enough
///    storage was available to complete this operation.</li> </ul>
///    
@DllImport("KERNEL32")
int GetTimeFormatW(uint Locale, uint dwFlags, const(SYSTEMTIME)* lpTime, const(PWSTR) lpFormat, PWSTR lpTimeStr, 
                   int cchTime);

///Formats time as a time string for a locale specified by name. The function formats either a specified time or the
///local system time.<div class="alert"><b>Note</b> The application should call this function in preference to
///GetTimeFormat if designed to run only on Windows Vista and later.</div> <div> </div> <div class="alert"><b>Note</b>
///This function can format data that changes between releases, for example, due to a custom locale. If your application
///must persist or transmit data, see Using Persistent Locale Data.</div> <div> </div>
///Params:
///    lpLocaleName = Pointer to a locale name, or one of the following predefined values. <ul> <li> LOCALE_NAME_INVARIANT </li> <li>
///                   LOCALE_NAME_SYSTEM_DEFAULT </li> <li> LOCALE_NAME_USER_DEFAULT </li> </ul>
///    dwFlags = Flags specifying time format options. The application can specify a combination of the following values and
///              LOCALE_USE_CP_ACP or LOCALE_NOUSEROVERRIDE. <div class="alert"><b>Caution</b> Use of LOCALE_NOUSEROVERRIDE is
///              strongly discouraged as it disables user preferences.</div> <div> </div> <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TIME_NOMINUTESORSECONDS"></a><a
///              id="time_nominutesorseconds"></a><dl> <dt><b>TIME_NOMINUTESORSECONDS</b></dt> </dl> </td> <td width="60%"> Do not
///              use minutes or seconds. </td> </tr> <tr> <td width="40%"><a id="TIME_NOSECONDS"></a><a
///              id="time_noseconds"></a><dl> <dt><b>TIME_NOSECONDS</b></dt> </dl> </td> <td width="60%"> Do not use seconds.
///              </td> </tr> <tr> <td width="40%"><a id="TIME_NOTIMEMARKER"></a><a id="time_notimemarker"></a><dl>
///              <dt><b>TIME_NOTIMEMARKER</b></dt> </dl> </td> <td width="60%"> Do not use a time marker. </td> </tr> <tr> <td
///              width="40%"><a id="TIME_FORCE24HOURFORMAT"></a><a id="time_force24hourformat"></a><dl>
///              <dt><b>TIME_FORCE24HOURFORMAT</b></dt> </dl> </td> <td width="60%"> Always use a 24-hour time format. </td> </tr>
///              </table>
///    lpTime = Pointer to a SYSTEMTIME structure that contains the time information to format. The application can set this
///             parameter to <b>NULL</b> if the function is to use the current local system time.
///    lpFormat = Pointer to a format picture to use to format the time string. If the application sets this parameter to
///               <b>NULL</b>, the function formats the string according to the time format of the specified locale. If the
///               application does not set the parameter to <b>NULL</b>, the function uses the locale only for information not
///               specified in the format picture string, for example, the locale-specific time markers. For information about the
///               format picture string, see the Remarks section.
///    lpTimeStr = Pointer to a buffer in which this function retrieves the formatted time string.
///    cchTime = Size, in characters, for the time string buffer indicated by <i>lpTimeStr</i>. Alternatively, the application can
///              set this parameter to 0. In this case, the function returns the required size for the time string buffer, and
///              does not use the <i>lpTimeStr</i> parameter.
///Returns:
///    Returns the number of characters retrieved in the buffer indicated by <i>lpTimeStr</i>. If the <i>cchTime</i>
///    parameter is set to 0, the function returns the size of the buffer required to hold the formatted time string,
///    including a terminating null character. This function returns 0 if it does not succeed. To get extended error
///    information, the application can call GetLastError, which can return one of the following error codes: <ul>
///    <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was incorrectly set to
///    <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> <li>ERROR_OUTOFMEMORY. Not enough
///    storage was available to complete this operation.</li> </ul>
///    
@DllImport("KERNEL32")
int GetTimeFormatEx(const(PWSTR) lpLocaleName, uint dwFlags, const(SYSTEMTIME)* lpTime, const(PWSTR) lpFormat, 
                    PWSTR lpTimeStr, int cchTime);

///Formats a date as a date string for a locale specified by name. The function formats either a specified date or the
///local system date.<div class="alert"><b>Note</b> The application should call this function in preference to
///GetDateFormat if designed to run only on Windows Vista and later.</div> <div> </div> <div class="alert"><b>Note</b>
///This function can format data that changes between releases, for example, due to a custom locale. If your application
///must persist or transmit data, see Using Persistent Locale Data.</div> <div> </div>
///Params:
///    lpLocaleName = Pointer to a locale name, or one of the following predefined values. <ul> <li> LOCALE_NAME_INVARIANT </li> <li>
///                   LOCALE_NAME_SYSTEM_DEFAULT </li> <li> LOCALE_NAME_USER_DEFAULT </li> </ul>
///    dwFlags = Flags specifying various function options that can be set if <i>lpFormat</i> is set to <b>NULL</b>. The
///              application can specify a combination of the following values and LOCALE_USE_CP_ACP or LOCALE_NOUSEROVERRIDE.
///              <div class="alert"><b>Caution</b> Use of LOCALE_NOUSEROVERRIDE is strongly discouraged as it disables user
///              preferences.</div> <div> </div> <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="DATE_AUTOLAYOUT"></a><a id="date_autolayout"></a><dl> <dt><b>DATE_AUTOLAYOUT</b></dt> </dl> </td> <td
///              width="60%"> <b>Windows 7 and later:</b> Detect the need for right-to-left and left-to-right reading layout using
///              the locale and calendar information, and add marks accordingly. This value cannot be used with DATE_LTRREADING or
///              DATE_RTLREADING. DATE_AUTOLAYOUT is preferred over DATE_LTRREADING and DATE_RTLREADING because it uses the
///              locales and calendars to determine the correct addition of marks. </td> </tr> <tr> <td width="40%"><a
///              id="DATE_LONGDATE"></a><a id="date_longdate"></a><dl> <dt><b>DATE_LONGDATE</b></dt> </dl> </td> <td width="60%">
///              Use the long date format. This value cannot be used with DATE_MONTHDAY, DATE_SHORTDATE, or DATE_YEARMONTH. </td>
///              </tr> <tr> <td width="40%"><a id="DATE_LTRREADING"></a><a id="date_ltrreading"></a><dl>
///              <dt><b>DATE_LTRREADING</b></dt> </dl> </td> <td width="60%"> Add marks for left-to-right reading layout. This
///              value cannot be used with DATE_RTLREADING. </td> </tr> <tr> <td width="40%"><a id="DATE_RTLREADING"></a><a
///              id="date_rtlreading"></a><dl> <dt><b>DATE_RTLREADING</b></dt> </dl> </td> <td width="60%"> Add marks for
///              right-to-left reading layout. This value cannot be used with DATE_LTRREADING </td> </tr> <tr> <td width="40%"><a
///              id="DATE_SHORTDATE"></a><a id="date_shortdate"></a><dl> <dt><b>DATE_SHORTDATE</b></dt> </dl> </td> <td
///              width="60%"> Use the short date format. This is the default. This value cannot be used with DATE_MONTHDAY,
///              DATE_LONGDATE, or DATE_YEARMONTH. </td> </tr> <tr> <td width="40%"><a id="DATE_USE_ALT_CALENDAR"></a><a
///              id="date_use_alt_calendar"></a><dl> <dt><b>DATE_USE_ALT_CALENDAR</b></dt> </dl> </td> <td width="60%"> Use the
///              alternate calendar, if one exists, to format the date string. If this flag is set, the function uses the default
///              format for that alternate calendar, rather than using any user overrides. The user overrides will be used only in
///              the event that there is no default format for the specified alternate calendar. </td> </tr> <tr> <td
///              width="40%"><a id="DATE_YEARMONTH"></a><a id="date_yearmonth"></a><dl> <dt><b>DATE_YEARMONTH</b></dt> </dl> </td>
///              <td width="60%"> <b>Windows Vista:</b> Use the year/month format. This value cannot be used with DATE_MONTHDAY,
///              DATE_SHORTDATE, or DATE_LONGDATE. </td> </tr> <tr> <td width="40%"><a id="DATE_MONTHDAY"></a><a
///              id="date_monthday"></a><dl> <dt><b>DATE_MONTHDAY</b></dt> </dl> </td> <td width="60%"> <b>Windows 10:</b> Use the
///              combination of month and day formats appropriate for the specified locale. This value cannot be used with
///              DATE_YEARMONTH, DATE_SHORTDATE, or DATE_LONGDATE. </td> </tr> </table> If the application does not specify
///              DATE_YEARMONTH, DATE_MONTHDAY, DATE_SHORTDATE, or DATE_LONGDATE, and <i>lpFormat</i> is set to <b>NULL</b>,
///              DATE_SHORTDATE is the default.
///    lpDate = Pointer to a SYSTEMTIME structure that contains the date information to format. The application can set this
///             parameter to <b>NULL</b> if the function is to use the current local system date.
///    lpFormat = Pointer to a format picture string that is used to form the date. Possible values for the format picture string
///               are defined in Day, Month, Year, and Era Format Pictures. For example, to get the date string "Wed, Aug 31 94",
///               the application uses the picture string "ddd',' MMM dd yy". The function uses the specified locale only for
///               information not specified in the format picture string, for example, the day and month names for the locale. The
///               application can set this parameter to <b>NULL</b> to format the string according to the date format for the
///               specified locale.
///    lpDateStr = Pointer to a buffer in which this function retrieves the formatted date string.
///    cchDate = Size, in characters, of the <i>lpDateStr</i> buffer. The application can set this parameter to 0 to return the
///              buffer size required to hold the formatted date string. In this case, the buffer indicated by <i>lpDateStr</i> is
///              not used.
///    lpCalendar = Reserved; must set to <b>NULL</b>.
///Returns:
///    Returns the number of characters written to the <i>lpDateStr</i> buffer if successful. If the <i>cchDate</i>
///    parameter is set to 0, the function returns the number of characters required to hold the formatted date string,
///    including the terminating null character. This function returns 0 if it does not succeed. To get extended error
///    information, the application can call GetLastError, which can return one of the following error codes: <ul>
///    <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was incorrectly set to
///    <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int GetDateFormatEx(const(PWSTR) lpLocaleName, uint dwFlags, const(SYSTEMTIME)* lpDate, const(PWSTR) lpFormat, 
                    PWSTR lpDateStr, int cchDate, const(PWSTR) lpCalendar);

///Formats a duration of time as a time string for a locale specified by name. <div class="alert"><b>Note</b> The
///application should call this function in preference to GetDurationFormat if designed to run only on Windows Vista and
///later.</div><div> </div><div class="alert"><b>Note</b> This function can format data that changes between releases,
///for example, due to a custom locale. If your application must persist or transmit data, see Using Persistent Locale
///Data.</div><div> </div>
///Params:
///    lpLocaleName = Pointer to a locale name, or one of the following predefined values. <ul> <li> LOCALE_NAME_INVARIANT </li> <li>
///                   LOCALE_NAME_SYSTEM_DEFAULT </li> <li> LOCALE_NAME_USER_DEFAULT </li> </ul>
///    dwFlags = Flags specifying function options. If <i>lpFormat</i> is not set to <b>NULL</b>, this parameter must be set to 0.
///              If <i>lpFormat</i> is set to <b>NULL</b>, your application can specify LOCALE_NOUSEROVERRIDE to format the string
///              using the system default duration format for the specified locale. <div class="alert"><b>Caution</b> Use of
///              <b>LOCALE_NOUSEROVERRIDE</b> is strongly discouraged as it disables user preferences.</div> <div> </div>
///    lpDuration = Pointer to a SYSTEMTIME structure that contains the time duration information to format. The application sets
///                 this parameter to <b>NULL</b> if the function is to ignore it and use <i>ullDuration</i>.
///    ullDuration = 64-bit unsigned integer that represents the number of 100-nanosecond intervals in the duration. If both
///                  <i>lpDuration</i> and <i>ullDuration</i> are set, the <i>lpDuration</i> parameter takes precedence. If
///                  <i>lpDuration</i> is set to <b>NULL</b> and <i>ullDuration</i> is set to 0, the duration is 0.
///    lpFormat = Pointer to the format string with characters as shown below. The application can set this parameter to
///               <b>NULL</b> if the function is to format the string according to the duration format for the specified locale. If
///               <i>lpFormat</i> is not set to <b>NULL</b>, the function uses the locale only for information not specified in the
///               format picture string. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="d"></a><a
///               id="D"></a><dl> <dt><b>d</b></dt> </dl> </td> <td width="60%"> days </td> </tr> <tr> <td width="40%"><a
///               id="h_or_H"></a><a id="h_or_h"></a><a id="H_OR_H"></a><dl> <dt><b>h or H</b></dt> </dl> </td> <td width="60%">
///               hours </td> </tr> <tr> <td width="40%"><a id="hh_or_HH"></a><a id="hh_or_hh"></a><a id="HH_OR_HH"></a><dl>
///               <dt><b>hh or HH</b></dt> </dl> </td> <td width="60%"> hours; if less than ten, prepend a leading zero </td> </tr>
///               <tr> <td width="40%"><a id="m"></a><a id="M"></a><dl> <dt><b>m</b></dt> </dl> </td> <td width="60%"> minutes
///               </td> </tr> <tr> <td width="40%"><a id="mm"></a><a id="MM"></a><dl> <dt><b>mm</b></dt> </dl> </td> <td
///               width="60%"> minutes; if less than ten, prepend a leading zero </td> </tr> <tr> <td width="40%"><a id="s"></a><a
///               id="S"></a><dl> <dt><b>s</b></dt> </dl> </td> <td width="60%"> seconds </td> </tr> <tr> <td width="40%"><a
///               id="ss"></a><a id="SS"></a><dl> <dt><b>ss</b></dt> </dl> </td> <td width="60%"> seconds; if less than ten,
///               prepend a leading zero </td> </tr> <tr> <td width="40%"><a id="f"></a><a id="F"></a><dl> <dt><b>f</b></dt> </dl>
///               </td> <td width="60%"> fractions of a second <div class="alert"><b>Note</b> The character "f" can occur up to
///               nine consecutive times (fffffffff), although support for frequency timers is limited to 100 nanoseconds. Thus, if
///               nine characters are present, the last two digits are always 0.</div> <div> </div> </td> </tr> </table>
///    lpDurationStr = Pointer to the buffer in which the function retrieves the duration string. Alternatively, this parameter
///                    retrieves <b>NULL</b> if <i>cchDuration</i> is set to 0. In this case, the function returns the required size for
///                    the duration string buffer.
///    cchDuration = Size, in characters, of the buffer indicated by <i>lpDurationStr</i>. Alternatively, the application can set this
///                  parameter to 0. In this case, the function retrieves <b>NULL</b> in <i>lpDurationStr</i> and returns the required
///                  size for the duration string buffer.
///Returns:
///    Returns the number of characters retrieved in the buffer indicated by <i>lpDurationStr</i> if successful. If
///    <i>lpDurationStr</i> is set to <b>NULL</b> and <i>cchDuration</i> is set to 0, the function returns the required
///    size for the duration string buffer, including the terminating null character. For example, if 10 characters are
///    written to the buffer, the function returns 11 to include the terminating null character. The function returns 0
///    if it does not succeed. To get extended error information, the application can call GetLastError, which can
///    return one of the following error codes: <ul> <li><b>ERROR_INSUFFICIENT_BUFFER</b>. A supplied buffer size was
///    not large enough, or it was incorrectly set to <b>NULL</b>.</li> <li><b>ERROR_INVALID_PARAMETER</b>. Any of the
///    parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int GetDurationFormatEx(const(PWSTR) lpLocaleName, uint dwFlags, const(SYSTEMTIME)* lpDuration, ulong ullDuration, 
                        const(PWSTR) lpFormat, PWSTR lpDurationStr, int cchDuration);

///Compares two Unicode (wide character) strings, for a locale specified by name. <div class="alert"><b>Caution</b>
///Using <b>CompareStringEx</b> incorrectly can compromise the security of your application. Strings that are not
///compared correctly can produce invalid input. Test strings to make sure they are valid before using them, and provide
///error handlers. For more information, see Security Considerations: International Features.</div><div> </div><div
///class="alert"><b>Note</b> The application should call this function in preference to CompareString if designed to run
///only on Windows Vista and later.</div><div> </div>
///Params:
///    lpLocaleName = Pointer to a locale name, or one of the following predefined values. <ul> <li> LOCALE_NAME_INVARIANT </li> <li>
///                   LOCALE_NAME_SYSTEM_DEFAULT </li> <li> LOCALE_NAME_USER_DEFAULT </li> </ul>
///    dwCmpFlags = Flags that indicate how the function compares the two strings. By default, these flags are not set. This
///                 parameter can specify a combination of any of the following values, or it can be set to 0 to obtain the default
///                 behavior. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                 id="LINGUISTIC_IGNORECASE"></a><a id="linguistic_ignorecase"></a><dl> <dt><b>LINGUISTIC_IGNORECASE</b></dt> </dl>
///                 </td> <td width="60%"> Ignore case, as linguistically appropriate. </td> </tr> <tr> <td width="40%"><a
///                 id="LINGUISTIC_IGNOREDIACRITIC"></a><a id="linguistic_ignorediacritic"></a><dl>
///                 <dt><b>LINGUISTIC_IGNOREDIACRITIC</b></dt> </dl> </td> <td width="60%"> Ignore nonspacing characters, as
///                 linguistically appropriate. <div class="alert"><b>Note</b> This flag does not always produce predictable results
///                 when used with decomposed characters, that is, characters in which a base character and one or more nonspacing
///                 characters each have distinct code point values.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
///                 id="NORM_IGNORECASE"></a><a id="norm_ignorecase"></a><dl> <dt><b>NORM_IGNORECASE</b></dt> </dl> </td> <td
///                 width="60%"> Ignore case. For many scripts (notably Latin scripts), NORM_IGNORECASE coincides with
///                 LINGUISTIC_IGNORECASE. <div class="alert"><b>Note</b> NORM_IGNORECASE ignores any tertiary distinction, whether
///                 it is actually linguistic case or not. For example, in Arabic and Indic scripts, this distinguishes alternate
///                 forms of a character, but the differences do not correspond to linguistic case. LINGUISTIC_IGNORECASE causes the
///                 function to ignore only actual linguistic casing, instead of ignoring the third sorting weight.</div> <div>
///                 </div> <div class="alert"><b>Note</b> With this flag set, the function ignores the distinction between the wide
///                 and narrow forms of the CJK compatibility characters.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
///                 id="NORM_IGNOREKANATYPE"></a><a id="norm_ignorekanatype"></a><dl> <dt><b>NORM_IGNOREKANATYPE</b></dt> </dl> </td>
///                 <td width="60%"> Do not differentiate between hiragana and katakana characters. Corresponding hiragana and
///                 katakana characters compare as equal. </td> </tr> <tr> <td width="40%"><a id="NORM_IGNORENONSPACE"></a><a
///                 id="norm_ignorenonspace"></a><dl> <dt><b>NORM_IGNORENONSPACE</b></dt> </dl> </td> <td width="60%"> Ignore
///                 nonspacing characters. For many scripts (notably Latin scripts), NORM_IGNORENONSPACE coincides with
///                 LINGUISTIC_IGNOREDIACRITIC. <div class="alert"><b>Note</b> NORM_IGNORENONSPACE ignores any secondary distinction,
///                 whether it is a diacritic or not. Scripts for Korean, Japanese, Chinese, and Indic languages, among others, use
///                 this distinction for purposes other than diacritics. LINGUISTIC_IGNOREDIACRITIC causes the function to ignore
///                 only actual diacritics, instead of ignoring the second sorting weight.</div> <div> </div> <div
///                 class="alert"><b>Note</b> NORM_IGNORENONSPACE only has an effect for locales in which accented characters are
///                 sorted in a second pass from main characters. Normally all characters in the string are first compared without
///                 regard to accents and, if the strings are equal, a second pass over the strings is performed to compare accents.
///                 This flag causes the second pass to not be performed. For locales that sort accented characters in the first
///                 pass, this flag has no effect.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
///                 id="NORM_IGNORESYMBOLS"></a><a id="norm_ignoresymbols"></a><dl> <dt><b>NORM_IGNORESYMBOLS</b></dt> </dl> </td>
///                 <td width="60%"> Ignore symbols and punctuation. </td> </tr> <tr> <td width="40%"><a id="NORM_IGNOREWIDTH"></a><a
///                 id="norm_ignorewidth"></a><dl> <dt><b>NORM_IGNOREWIDTH</b></dt> </dl> </td> <td width="60%"> Ignore the
///                 difference between half-width and full-width characters, for example, C a t == cat. The full-width form is a
///                 formatting distinction used in Chinese and Japanese scripts. </td> </tr> <tr> <td width="40%"><a
///                 id="NORM_LINGUISTIC_CASING"></a><a id="norm_linguistic_casing"></a><dl> <dt><b>NORM_LINGUISTIC_CASING</b></dt>
///                 </dl> </td> <td width="60%"> Use the default linguistic rules for casing, instead of file system rules. Note that
///                 most scenarios for <b>CompareStringEx</b> use this flag. This flag does not have to be used when your application
///                 calls CompareStringOrdinal. </td> </tr> <tr> <td width="40%"><a id="SORT_DIGITSASNUMBERS"></a><a
///                 id="sort_digitsasnumbers"></a><dl> <dt><b>SORT_DIGITSASNUMBERS</b></dt> </dl> </td> <td width="60%"> <b>Windows
///                 7:</b> Treat digits as numbers during sorting, for example, sort "2" before "10". </td> </tr> <tr> <td
///                 width="40%"><a id="SORT_STRINGSORT"></a><a id="sort_stringsort"></a><dl> <dt><b>SORT_STRINGSORT</b></dt> </dl>
///                 </td> <td width="60%"> Treat punctuation the same as symbols. </td> </tr> </table>
///    lpString1 = Pointer to the first string to compare.
///    cchCount1 = Length of the string indicated by <i>lpString1</i>, excluding the terminating null character. The application can
///                supply a negative value if the string is null-terminated. In this case, the function determines the length
///                automatically.
///    lpString2 = Pointer to the second string to compare.
///    cchCount2 = Length of the string indicated by <i>lpString2</i>, excluding the terminating null character. The application can
///                supply a negative value if the string is null-terminated. In this case, the function determines the length
///                automatically.
///    lpVersionInformation = Pointer to an NLSVERSIONINFOEX structure that contains the version information about the relevant NLS capability;
///                           usually retrieved from GetNLSVersionEx. <b>Windows Vista, Windows 7:</b> Reserved; must set to <b>NULL</b>.
///    lpReserved = Reserved; must set to <b>NULL</b>.
///    lParam = Reserved; must be set to 0.
///Returns:
///    Returns one of the following values if successful. To maintain the C runtime convention of comparing strings, the
///    value 2 can be subtracted from a nonzero return value. Then, the meaning of &lt;0, ==0, and &gt;0 is consistent
///    with the C runtime. <ul> <li>CSTR_LESS_THAN. The string indicated by <i>lpString1</i> is less in lexical value
///    than the string indicated by <i>lpString2</i>.</li> <li>CSTR_EQUAL. The string indicated by <i>lpString1</i> is
///    equivalent in lexical value to the string indicated by <i>lpString2</i>. The two strings are equivalent for
///    sorting purposes, although not necessarily identical.</li> <li>CSTR_GREATER_THAN. The string indicated by
///    <i>lpString1</i> is greater in lexical value than the string indicated by <i>lpString2</i>.</li> </ul> The
///    function returns 0 if it does not succeed. To get extended error information, the application can call
///    GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_FLAGS. The values
///    supplied for flags were invalid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid. </li>
///    </ul>
///    
@DllImport("KERNEL32")
int CompareStringEx(const(PWSTR) lpLocaleName, uint dwCmpFlags, const(PWSTR) lpString1, int cchCount1, 
                    const(PWSTR) lpString2, int cchCount2, NLSVERSIONINFO* lpVersionInformation, void* lpReserved, 
                    LPARAM lParam);

///Compares two Unicode strings to test binary equivalence.
///Params:
///    lpString1 = Pointer to the first string to compare.
///    cchCount1 = Length of the string indicated by <i>lpString1</i>. The application supplies -1 if the string is null-terminated.
///                In this case, the function determines the length automatically.
///    lpString2 = Pointer to the second string to compare.
///    cchCount2 = Length of the string indicated by <i>lpString2</i>. The application supplies -1 if the string is null-terminated.
///                In this case, the function determines the length automatically.
///    bIgnoreCase = <b>TRUE</b> if the function is to perform a case-insensitive comparison, using the operating system uppercase
///                  table information. The application sets this parameter to <b>FALSE</b> if the function is to compare the strings
///                  exactly as they are passed in. Note that 1 is the only numeric value that can be used to specify a true value for
///                  this boolean parameter that does not result an invalid parameter error. Boolean values for this parameter work as
///                  expected.
///Returns:
///    Returns one of the following values if successful. To maintain the C runtime convention of comparing strings, the
///    value 2 can be subtracted from a nonzero return value. Then, the meaning of &lt;0, ==0, and &gt;0 is consistent
///    with the C runtime. <ul> <li>CSTR_LESS_THAN. The value indicated by <i>lpString1</i> is less than the value
///    indicated by <i>lpString2</i>.</li> <li>CSTR_EQUAL. The value indicated by <i>lpString1</i> equals the value
///    indicated by <i>lpString2</i>.</li> <li>CSTR_GREATER_THAN. The value indicated by <i>lpString1</i> is greater
///    than the value indicated by <i>lpString2</i>.</li> </ul> The function returns 0 if it does not succeed. To get
///    extended error information, the application can call GetLastError, which can return one of the following error
///    codes: <ul> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int CompareStringOrdinal(const(PWSTR) lpString1, int cchCount1, const(PWSTR) lpString2, int cchCount2, 
                         BOOL bIgnoreCase);

///Compares two character strings, for a locale specified by identifier. <div class="alert"><b>Caution</b> Using
///<b>CompareString</b> incorrectly can compromise the security of your application. Strings that are not compared
///correctly can produce invalid input. For example, the function can raise security issues when used for a
///non-linguistic comparison, because two strings that are distinct in their binary representation can be linguistically
///equivalent. The application should test strings for validity before using them, and should provide error handlers.
///For more information, see Security Considerations: International Features.</div><div> </div><div
///class="alert"><b>Note</b> For compatibility with Unicode, your applications should prefer CompareStringEx or the
///Unicode version of <b>CompareString</b>. Another reason for preferring CompareStringEx is that Microsoft is migrating
///toward the use of locale names instead of locale identifiers for new locales, for interoperability reasons. Any
///application that will be run only on Windows Vista and later should use CompareStringEx.</div><div> </div>
///Params:
///    Locale = Locale identifier of the locale used for the comparison. You can use the MAKELCID macro to create a locale
///             identifier or use one of the following predefined values. <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li>
///             LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li> LOCALE_INVARIANT </li> <li>
///             LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul>
///    dwCmpFlags = Flags that indicate how the function compares the two strings. For detailed definitions, see the
///                 <i>dwCmpFlags</i> parameter of CompareStringEx.
///    lpString1 = Pointer to the first string to compare.
///    cchCount1 = Length of the string indicated by <i>lpString1</i>, excluding the terminating null character. This value
///                represents bytes for the ANSI version of the function and wide characters for the Unicode version. The
///                application can supply a negative value if the string is null-terminated. In this case, the function determines
///                the length automatically.
///    lpString2 = Pointer to the second string to compare.
///    cchCount2 = Length of the string indicated by <i>lpString2</i>, excluding the terminating null character. This value
///                represents bytes for the ANSI version of the function and wide characters for the Unicode version. The
///                application can supply a negative value if the string is null-terminated. In this case, the function determines
///                the length automatically.
///Returns:
///    Returns the values described for CompareStringEx.
///    
@DllImport("KERNEL32")
int CompareStringW(uint Locale, uint dwCmpFlags, ushort* lpString1, int cchCount1, ushort* lpString2, 
                   int cchCount2);

///Maps one Unicode string to another, performing the specified transformation. For an overview of the use of the string
///functions, see Strings. <div class="alert"><b>Caution</b> Using <b>FoldString</b> incorrectly can compromise the
///security of your application. Strings that are not mapped correctly can produce invalid input. Test strings to make
///sure they are valid before using them and provide error handlers. For more information, see Security Considerations:
///International Features.</div><div> </div>
///Params:
///    dwMapFlags = Flags specifying the type of transformation to use during string mapping. This parameter can be a combination of
///                 the following values. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                 id="MAP_COMPOSITE"></a><a id="map_composite"></a><dl> <dt><b>MAP_COMPOSITE</b></dt> </dl> </td> <td width="60%">
///                 Map accented characters to decomposed characters, that is, characters in which a base character and one or more
///                 nonspacing characters each have distinct code point values. For example, Ä is represented by A + ¨: LATIN
///                 CAPITAL LETTER A (U+0041) + COMBINING DIAERESIS (U+0308). This flag is equivalent to normalization form D in
///                 Windows Vista. Note that this flag cannot be used with MB_PRECOMPOSED. </td> </tr> <tr> <td width="40%"><a
///                 id="MAP_EXPAND_LIGATURES"></a><a id="map_expand_ligatures"></a><dl> <dt><b>MAP_EXPAND_LIGATURES</b></dt> </dl>
///                 </td> <td width="60%"> Expand all ligature characters so that they are represented by their two-character
///                 equivalent. For example, the ligature "æ" (U+00e6) expands to the two characters "a" (U+0061) + "e" (U+0065).
///                 This value cannot be combined with MAP_PRECOMPOSED or MAP_COMPOSITE. </td> </tr> <tr> <td width="40%"><a
///                 id="MAP_FOLDCZONE"></a><a id="map_foldczone"></a><dl> <dt><b>MAP_FOLDCZONE</b></dt> </dl> </td> <td width="60%">
///                 Fold compatibility zone characters into standard Unicode equivalents. This flag is equivalent to normalization
///                 form KD in Windows Vista, if the MAP_COMPOSITE flag is also set. If the composite flag is not set (default), this
///                 flag is equivalent to normalization form KC in Windows Vista. </td> </tr> <tr> <td width="40%"><a
///                 id="MAP_FOLDDIGITS"></a><a id="map_folddigits"></a><dl> <dt><b>MAP_FOLDDIGITS</b></dt> </dl> </td> <td
///                 width="60%"> Map all digits to Unicode characters 0 through 9. </td> </tr> <tr> <td width="40%"><a
///                 id="MAP_PRECOMPOSED"></a><a id="map_precomposed"></a><dl> <dt><b>MAP_PRECOMPOSED</b></dt> </dl> </td> <td
///                 width="60%"> Map accented characters to precomposed characters, in which the accent and base character are
///                 combined into a single character value. This flag is equivalent to normalization form C in Windows Vista. This
///                 value cannot be combined with MAP_COMPOSITE. </td> </tr> </table>
///    lpSrcStr = Pointer to a source string that the function maps.
///    cchSrc = Size, in characters, of the source string indicated by <i>lpSrcStr</i>, excluding the terminating null character.
///             The application can set the parameter to any negative value to specify that the source string is null-terminated.
///             In this case, the function calculates the string length automatically, and null-terminates the mapped string
///             indicated by <i>lpDestStr</i>.
///    lpDestStr = Pointer to a buffer in which this function retrieves the mapped string.
///    cchDest = Size, in characters, of the destination string indicated by <i>lpDestStr</i>. If space for a terminating null
///              character is included in <i>cchSrc</i>, <i>cchDest</i> must also include space for a terminating null character.
///              The application can set <i>cchDest</i> to 0. In this case, the function does not use the <i>lpDestStr</i>
///              parameter and returns the required buffer size for the mapped string. If the MAP_FOLDDIGITS flag is specified,
///              the return value is the maximum size required, even if the actual number of characters needed is smaller than the
///              maximum size. If the maximum size is not passed, the function fails with ERROR_INSUFFICIENT_BUFFER.
///Returns:
///    Returns the number of characters in the translated string, including a terminating null character, if successful.
///    If the function succeeds and the value of <i>cchDest</i> is 0, the return value is the size of the buffer
///    required to hold the translated string, including a terminating null character. This function returns 0 if it
///    does not succeed. To get extended error information, the application can call GetLastError, which can return one
///    of the following error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or
///    it was incorrectly set to <b>NULL</b>. </li> <li>ERROR_INVALID_DATA. The data was invalid.</li>
///    <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of
///    the parameter values was invalid.</li> <li>ERROR_MOD_NOT_FOUND. The module was not found. </li>
///    <li>ERROR_OUTOFMEMORY. Not enough storage was available to complete this operation. </li>
///    <li>ERROR_PROC_NOT_FOUND. The required procedure was not found.</li> </ul>
///    
@DllImport("KERNEL32")
int FoldStringW(uint dwMapFlags, const(PWSTR) lpSrcStr, int cchSrc, PWSTR lpDestStr, int cchDest);

///Retrieves character type information for the characters in the specified source string. For each character in the
///string, the function sets one or more bits in the corresponding 16-bit element of the output array. Each bit
///identifies a given character type, for example, letter, digit, or neither. <div class="alert"><b>Caution</b> Using
///the <b>GetStringTypeEx</b> function incorrectly can compromise the security of your application. To avoid a buffer
///overflow, the application must set the output buffer size correctly. For more security information, see Security
///Considerations: Windows User Interface.</div><div> </div><div class="alert"><b>Note</b> Unlike its close relatives
///GetStringTypeA and GetStringTypeW, this function exhibits appropriate ANSI or Unicode behavior through the use of the
///#define UNICODE switch. This is the recommended function for character type retrieval.</div><div> </div>
///Params:
///    Locale = Locale identifier that specifies the locale. This value uniquely defines the ANSI code page. You can use the
///             MAKELCID macro to create a locale identifier or use one of the following predefined values. <ul> <li>
///             LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul> <b>Windows Vista and later:</b> The following
///             custom locale identifiers are also supported. <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT
///             </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> </ul>
///    dwInfoType = Flags specifying the character type information to retrieve. For possible flag values, see the <i>dwInfoType</i>
///                 parameter of GetStringTypeW. For detailed information about the character type bits, see Remarks for
///                 GetStringTypeW.
///    lpSrcStr = Pointer to the string for which to retrieve the character types. The string is assumed to be null-terminated if
///               <i>cchSrc</i> is set to any negative value.
///    cchSrc = Size, in characters, of the string indicated by <i>lpSrcStr</i>. The size refers to bytes for the ANSI version of
///             the function or wide characters for the Unicode version. If the size includes a terminating null character, the
///             function retrieves character type information for that character. If the application sets the size to any
///             negative integer, the source string is assumed to be null-terminated and the function calculates the size
///             automatically with an additional character for the null termination.
///    lpCharType = Pointer to an array of 16-bit values. The length of this array must be large enough to receive one 16-bit value
///                 for each character in the source string. If <i>cchSrc</i> is not a negative number, <i>lpCharType</i> should be
///                 an array of words with <i>cchSrc</i> elements. If <i>cchSrc</i> is set to a negative number, <i>lpCharType</i> is
///                 an array of words with <i>lpSrcStr</i> + 1 elements. When the function returns, this array contains one word
///                 corresponding to each character in the source string.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li><b>ERROR_INVALID_FLAGS</b>. The
///    values supplied for flags were not valid.</li> <li><b>ERROR_INVALID_PARAMETER</b>. Any of the parameter values
///    was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL GetStringTypeExW(uint Locale, uint dwInfoType, const(PWSTR) lpSrcStr, int cchSrc, ushort* lpCharType);

///Retrieves character type information for the characters in the specified Unicode source string. For each character in
///the string, the function sets one or more bits in the corresponding 16-bit element of the output array. Each bit
///identifies a given character type, for example, letter, digit, or neither. <div class="alert"><b>Caution</b> Using
///the <b>GetStringTypeW</b> function incorrectly can compromise the security of your application. To avoid a buffer
///overflow, the application must set the output buffer size correctly. For more security information, see Security
///Considerations: Windows User Interface.</div> <div> </div>
///Params:
///    dwInfoType = Flags specifying the character type information to retrieve. This parameter can have the following values. The
///                 character types are divided into different levels as described in the Remarks section. <table> <tr> <th>Flag</th>
///                 <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CT_CTYPE1"></a><a id="ct_ctype1"></a><dl>
///                 <dt><b>CT_CTYPE1</b></dt> </dl> </td> <td width="60%"> Retrieve character type information. </td> </tr> <tr> <td
///                 width="40%"><a id="CT_CTYPE2"></a><a id="ct_ctype2"></a><dl> <dt><b>CT_CTYPE2</b></dt> </dl> </td> <td
///                 width="60%"> Retrieve bidirectional layout information. </td> </tr> <tr> <td width="40%"><a id="CT_CTYPE3"></a><a
///                 id="ct_ctype3"></a><dl> <dt><b>CT_CTYPE3</b></dt> </dl> </td> <td width="60%"> Retrieve text processing
///                 information. </td> </tr> </table>
///    lpSrcStr = Pointer to the Unicode string for which to retrieve the character types. The string is assumed to be
///               null-terminated if <i>cchSrc</i> is set to any negative value.
///    cchSrc = Size, in characters, of the string indicated by <i>lpSrcStr</i>. If the size includes a terminating null
///             character, the function retrieves character type information for that character. If the application sets the size
///             to any negative integer, the source string is assumed to be null-terminated and the function calculates the size
///             automatically with an additional character for the null termination.
///    lpCharType = Pointer to an array of 16-bit values. The length of this array must be large enough to receive one 16-bit value
///                 for each character in the source string. If <i>cchSrc</i> is not a negative number, <i>lpCharType</i> should be
///                 an array of words with <i>cchSrc</i> elements. If <i>cchSrc</i> is set to a negative number, <i>lpCharType</i> is
///                 an array of words with <i>lpSrcStr</i> + 1 elements. When the function returns, this array contains one word
///                 corresponding to each character in the source string.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_FLAGS. The values
///    supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL GetStringTypeW(uint dwInfoType, const(PWSTR) lpSrcStr, int cchSrc, ushort* lpCharType);

///Maps a character string to a UTF-16 (wide character) string. The character string is not necessarily from a multibyte
///character set.<div class="alert"><b>Caution</b> Using the <b>MultiByteToWideChar</b> function incorrectly can
///compromise the security of your application. Calling this function can easily cause a buffer overrun because the size
///of the input buffer indicated by <i>lpMultiByteStr</i> equals the number of bytes in the string, while the size of
///the output buffer indicated by <i>lpWideCharStr</i> equals the number of characters. To avoid a buffer overrun, your
///application must specify a buffer size appropriate for the data type the buffer receives. For more information, see
///Security Considerations: International Features.</div> <div> </div> <div class="alert"><b>Note</b> The ANSI code
///pages can be different on different computers, or can be changed for a single computer, leading to data corruption.
///For the most consistent results, applications should use Unicode, such as UTF-8 or UTF-16, instead of a specific code
///page, unless legacy standards or data formats prevent the use of Unicode. If using Unicode is not possible,
///applications should tag the data stream with the appropriate encoding name when protocols allow it. HTML and XML
///files allow tagging, but text files do not.</div> <div> </div>
///Params:
///    CodePage = Code page to use in performing the conversion. This parameter can be set to the value of any code page that is
///               installed or available in the operating system. For a list of code pages, see Code Page Identifiers. Your
///               application can also specify one of the values shown in the following table. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CP_ACP"></a><a id="cp_acp"></a><dl> <dt><b>CP_ACP</b></dt>
///               </dl> </td> <td width="60%"> The system default Windows ANSI code page. <div class="alert"><b>Note</b> This value
///               can be different on different computers, even on the same network. It can be changed on the same computer,
///               leading to stored data becoming irrecoverably corrupted. This value is only intended for temporary use and
///               permanent storage should use UTF-16 or UTF-8 if possible.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
///               id="CP_MACCP"></a><a id="cp_maccp"></a><dl> <dt><b>CP_MACCP</b></dt> </dl> </td> <td width="60%"> The current
///               system Macintosh code page. <div class="alert"><b>Note</b> This value can be different on different computers,
///               even on the same network. It can be changed on the same computer, leading to stored data becoming irrecoverably
///               corrupted. This value is only intended for temporary use and permanent storage should use UTF-16 or UTF-8 if
///               possible.</div> <div> </div> <div class="alert"><b>Note</b> This value is used primarily in legacy code and
///               should not generally be needed since modern Macintosh computers use Unicode for encoding.</div> <div> </div>
///               </td> </tr> <tr> <td width="40%"><a id="CP_OEMCP"></a><a id="cp_oemcp"></a><dl> <dt><b>CP_OEMCP</b></dt> </dl>
///               </td> <td width="60%"> The current system OEM code page. <div class="alert"><b>Note</b> This value can be
///               different on different computers, even on the same network. It can be changed on the same computer, leading to
///               stored data becoming irrecoverably corrupted. This value is only intended for temporary use and permanent storage
///               should use UTF-16 or UTF-8 if possible.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
///               id="CP_SYMBOL"></a><a id="cp_symbol"></a><dl> <dt><b>CP_SYMBOL</b></dt> </dl> </td> <td width="60%"> Symbol code
///               page (42). </td> </tr> <tr> <td width="40%"><a id="CP_THREAD_ACP"></a><a id="cp_thread_acp"></a><dl>
///               <dt><b>CP_THREAD_ACP</b></dt> </dl> </td> <td width="60%"> The Windows ANSI code page for the current thread.
///               <div class="alert"><b>Note</b> This value can be different on different computers, even on the same network. It
///               can be changed on the same computer, leading to stored data becoming irrecoverably corrupted. This value is only
///               intended for temporary use and permanent storage should use UTF-16 or UTF-8 if possible.</div> <div> </div> </td>
///               </tr> <tr> <td width="40%"><a id="CP_UTF7"></a><a id="cp_utf7"></a><dl> <dt><b>CP_UTF7</b></dt> </dl> </td> <td
///               width="60%"> UTF-7. Use this value only when forced by a 7-bit transport mechanism. Use of UTF-8 is preferred.
///               </td> </tr> <tr> <td width="40%"><a id="CP_UTF8"></a><a id="cp_utf8"></a><dl> <dt><b>CP_UTF8</b></dt> </dl> </td>
///               <td width="60%"> UTF-8. </td> </tr> </table>
///    dwFlags = Flags indicating the conversion type. The application can specify a combination of the following values, with
///              MB_PRECOMPOSED being the default. MB_PRECOMPOSED and MB_COMPOSITE are mutually exclusive. MB_USEGLYPHCHARS and
///              MB_ERR_INVALID_CHARS can be set regardless of the state of the other flags. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MB_COMPOSITE"></a><a id="mb_composite"></a><dl>
///              <dt><b>MB_COMPOSITE</b></dt> </dl> </td> <td width="60%"> Always use decomposed characters, that is, characters
///              in which a base character and one or more nonspacing characters each have distinct code point values. For
///              example, Ä is represented by A + ¨: LATIN CAPITAL LETTER A (U+0041) + COMBINING DIAERESIS (U+0308). Note that
///              this flag cannot be used with MB_PRECOMPOSED. </td> </tr> <tr> <td width="40%"><a
///              id="MB_ERR_INVALID_CHARS"></a><a id="mb_err_invalid_chars"></a><dl> <dt><b>MB_ERR_INVALID_CHARS</b></dt> </dl>
///              </td> <td width="60%"> Fail if an invalid input character is encountered. Starting with Windows Vista, the
///              function does not drop illegal code points if the application does not set this flag, but instead replaces
///              illegal sequences with U+FFFD (encoded as appropriate for the specified codepage). <b>Windows 2000 with SP4 and
///              later, Windows XP: </b> If this flag is not set, the function silently drops illegal code points. A call to
///              GetLastError returns ERROR_NO_UNICODE_TRANSLATION. </td> </tr> <tr> <td width="40%"><a id="MB_PRECOMPOSED"></a><a
///              id="mb_precomposed"></a><dl> <dt><b>MB_PRECOMPOSED</b></dt> </dl> </td> <td width="60%"> Default; do not use with
///              MB_COMPOSITE. Always use precomposed characters, that is, characters having a single character value for a base
///              or nonspacing character combination. For example, in the character è, the e is the base character and the accent
///              grave mark is the nonspacing character. If a single Unicode code point is defined for a character, the
///              application should use it instead of a separate base character and a nonspacing character. For example, Ä is
///              represented by the single Unicode code point LATIN CAPITAL LETTER A WITH DIAERESIS (U+00C4). </td> </tr> <tr> <td
///              width="40%"><a id="MB_USEGLYPHCHARS"></a><a id="mb_useglyphchars"></a><dl> <dt><b>MB_USEGLYPHCHARS</b></dt> </dl>
///              </td> <td width="60%"> Use glyph characters instead of control characters. </td> </tr> </table> For the code
///              pages listed below, <i>dwFlags</i> must be set to 0. Otherwise, the function fails with ERROR_INVALID_FLAGS. <ul>
///              <li>50220 </li> <li>50221 </li> <li>50222 </li> <li>50225</li> <li>50227 </li> <li>50229 </li> <li>57002 through
///              57011</li> <li>65000 (UTF-7)</li> <li>42 (Symbol)</li> </ul> <div class="alert"><b>Note</b> For UTF-8 or code
///              page 54936 (GB18030, starting with Windows Vista), <i>dwFlags</i> must be set to either 0 or
///              MB_ERR_INVALID_CHARS. Otherwise, the function fails with ERROR_INVALID_FLAGS.</div> <div> </div>
///    lpMultiByteStr = Pointer to the character string to convert.
///    cbMultiByte = Size, in bytes, of the string indicated by the <i>lpMultiByteStr</i> parameter. Alternatively, this parameter can
///                  be set to -1 if the string is null-terminated. Note that, if <i>cbMultiByte</i> is 0, the function fails. If this
///                  parameter is -1, the function processes the entire input string, including the terminating null character.
///                  Therefore, the resulting Unicode string has a terminating null character, and the length returned by the function
///                  includes this character. If this parameter is set to a positive integer, the function processes exactly the
///                  specified number of bytes. If the provided size does not include a terminating null character, the resulting
///                  Unicode string is not null-terminated, and the returned length does not include this character.
///    lpWideCharStr = Pointer to a buffer that receives the converted string.
///    cchWideChar = Size, in characters, of the buffer indicated by <i>lpWideCharStr</i>. If this value is 0, the function returns
///                  the required buffer size, in characters, including any terminating null character, and makes no use of the
///                  <i>lpWideCharStr</i> buffer.
///Returns:
///    Returns the number of characters written to the buffer indicated by <i>lpWideCharStr</i> if successful. If the
///    function succeeds and <i>cchWideChar</i> is 0, the return value is the required size, in characters, for the
///    buffer indicated by <i>lpWideCharStr</i>. Also see <i>dwFlags</i> for info about how the MB_ERR_INVALID_CHARS
///    flag affects the return value when invalid sequences are input. The function returns 0 if it does not succeed. To
///    get extended error information, the application can call GetLastError, which can return one of the following
///    error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was
///    incorrectly set to <b>NULL</b>.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid. </li> <li>ERROR_NO_UNICODE_TRANSLATION.
///    Invalid Unicode was found in a string.</li> </ul>
///    
@DllImport("KERNEL32")
int MultiByteToWideChar(uint CodePage, uint dwFlags, const(PSTR) lpMultiByteStr, int cbMultiByte, 
                        PWSTR lpWideCharStr, int cchWideChar);

///Maps a UTF-16 (wide character) string to a new character string. The new character string is not necessarily from a
///multibyte character set. <div class="alert"><b>Caution</b> Using the <b>WideCharToMultiByte</b> function incorrectly
///can compromise the security of your application. Calling this function can easily cause a buffer overrun because the
///size of the input buffer indicated by <i>lpWideCharStr</i> equals the number of characters in the Unicode string,
///while the size of the output buffer indicated by <i>lpMultiByteStr</i> equals the number of bytes. To avoid a buffer
///overrun, your application must specify a buffer size appropriate for the data type the buffer receives. <p
///class="note">Data converted from UTF-16 to non-Unicode encodings is subject to data loss, because a code page might
///not be able to represent every character used in the specific Unicode data. For more information, see Security
///Considerations: International Features. </div> <div> </div> <div class="alert"><b>Note</b> The ANSI code pages can be
///different on different computers, or can be changed for a single computer, leading to data corruption. For the most
///consistent results, applications should use Unicode, such as UTF-8 or UTF-16, instead of a specific code page, unless
///legacy standards or data formats prevent the use of Unicode. If using Unicode is not possible, applications should
///tag the data stream with the appropriate encoding name when protocols allow it. HTML and XML files allow tagging, but
///text files do not.</div> <div> </div>
///Params:
///    CodePage = Code page to use in performing the conversion. This parameter can be set to the value of any code page that is
///               installed or available in the operating system. For a list of code pages, see Code Page Identifiers. Your
///               application can also specify one of the values shown in the following table. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CP_ACP"></a><a id="cp_acp"></a><dl> <dt><b>CP_ACP</b></dt>
///               </dl> </td> <td width="60%"> The system default Windows ANSI code page. <div class="alert"><b>Note</b> This value
///               can be different on different computers, even on the same network. It can be changed on the same computer,
///               leading to stored data becoming irrecoverably corrupted. This value is only intended for temporary use and
///               permanent storage should use UTF-16 or UTF-8 if possible.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
///               id="CP_MACCP"></a><a id="cp_maccp"></a><dl> <dt><b>CP_MACCP</b></dt> </dl> </td> <td width="60%"> The current
///               system Macintosh code page. <div class="alert"><b>Note</b> This value can be different on different computers,
///               even on the same network. It can be changed on the same computer, leading to stored data becoming irrecoverably
///               corrupted. This value is only intended for temporary use and permanent storage should use UTF-16 or UTF-8 if
///               possible.</div> <div> </div> <div class="alert"><b>Note</b> This value is used primarily in legacy code and
///               should not generally be needed since modern Macintosh computers use Unicode for encoding.</div> <div> </div>
///               </td> </tr> <tr> <td width="40%"><a id="CP_OEMCP"></a><a id="cp_oemcp"></a><dl> <dt><b>CP_OEMCP</b></dt> </dl>
///               </td> <td width="60%"> The current system OEM code page. <div class="alert"><b>Note</b> This value can be
///               different on different computers, even on the same network. It can be changed on the same computer, leading to
///               stored data becoming irrecoverably corrupted. This value is only intended for temporary use and permanent storage
///               should use UTF-16 or UTF-8 if possible.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
///               id="CP_SYMBOL"></a><a id="cp_symbol"></a><dl> <dt><b>CP_SYMBOL</b></dt> </dl> </td> <td width="60%"> <b>Windows
///               2000:</b> Symbol code page (42). </td> </tr> <tr> <td width="40%"><a id="CP_THREAD_ACP"></a><a
///               id="cp_thread_acp"></a><dl> <dt><b>CP_THREAD_ACP</b></dt> </dl> </td> <td width="60%"> <b>Windows 2000:</b> The
///               Windows ANSI code page for the current thread. <div class="alert"><b>Note</b> This value can be different on
///               different computers, even on the same network. It can be changed on the same computer, leading to stored data
///               becoming irrecoverably corrupted. This value is only intended for temporary use and permanent storage should use
///               UTF-16 or UTF-8 if possible.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="CP_UTF7"></a><a
///               id="cp_utf7"></a><dl> <dt><b>CP_UTF7</b></dt> </dl> </td> <td width="60%"> UTF-7. Use this value only when forced
///               by a 7-bit transport mechanism. Use of UTF-8 is preferred. With this value set, <i>lpDefaultChar</i> and
///               <i>lpUsedDefaultChar</i> must be set to <b>NULL</b>. </td> </tr> <tr> <td width="40%"><a id="CP_UTF8"></a><a
///               id="cp_utf8"></a><dl> <dt><b>CP_UTF8</b></dt> </dl> </td> <td width="60%"> UTF-8. With this value set,
///               <i>lpDefaultChar</i> and <i>lpUsedDefaultChar</i> must be set to <b>NULL</b>. </td> </tr> </table>
///    dwFlags = Flags indicating the conversion type. The application can specify a combination of the following values. The
///              function performs more quickly when none of these flags is set. The application should specify
///              WC_NO_BEST_FIT_CHARS and WC_COMPOSITECHECK with the specific value WC_DEFAULTCHAR to retrieve all possible
///              conversion results. If all three values are not provided, some results will be missing. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WC_COMPOSITECHECK"></a><a
///              id="wc_compositecheck"></a><dl> <dt><b>WC_COMPOSITECHECK</b></dt> </dl> </td> <td width="60%"> Convert composite
///              characters, consisting of a base character and a nonspacing character, each with different character values.
///              Translate these characters to precomposed characters, which have a single character value for a base-nonspacing
///              character combination. For example, in the character è, the e is the base character and the accent grave mark is
///              the nonspacing character.<div class="alert"><b>Note</b> Windows normally represents Unicode strings with
///              precomposed data, making the use of the WC_COMPOSITECHECK flag unnecessary.</div> <div> </div> Your application
///              can combine WC_COMPOSITECHECK with any one of the following flags, with the default being WC_SEPCHARS. These
///              flags determine the behavior of the function when no precomposed mapping for a base-nonspacing character
///              combination in a Unicode string is available. If none of these flags is supplied, the function behaves as if the
///              WC_SEPCHARS flag is set. For more information, see WC_COMPOSITECHECK and related flags in the Remarks section.
///              <table> <tr> <td>WC_DEFAULTCHAR</td> <td>Replace exceptions with the default character during conversion.</td>
///              </tr> <tr> <td>WC_DISCARDNS</td> <td>Discard nonspacing characters during conversion.</td> </tr> <tr>
///              <td>WC_SEPCHARS</td> <td>Default. Generate separate characters during conversion.</td> </tr> </table> </td> </tr>
///              <tr> <td width="40%"><a id="WC_ERR_INVALID_CHARS"></a><a id="wc_err_invalid_chars"></a><dl>
///              <dt><b>WC_ERR_INVALID_CHARS</b></dt> </dl> </td> <td width="60%"> <b>Windows Vista and later:</b> Fail (by
///              returning 0 and setting the last-error code to ERROR_NO_UNICODE_TRANSLATION) if an invalid input character is
///              encountered. You can retrieve the last-error code with a call to GetLastError. If this flag is not set, the
///              function replaces illegal sequences with U+FFFD (encoded as appropriate for the specified codepage) and succeeds
///              by returning the length of the converted string. Note that this flag only applies when <i>CodePage</i> is
///              specified as CP_UTF8 or 54936. It cannot be used with other code page values. </td> </tr> <tr> <td width="40%"><a
///              id="WC_NO_BEST_FIT_CHARS"></a><a id="wc_no_best_fit_chars"></a><dl> <dt><b>WC_NO_BEST_FIT_CHARS</b></dt> </dl>
///              </td> <td width="60%"> Translate any Unicode characters that do not translate directly to multibyte equivalents
///              to the default character specified by <i>lpDefaultChar</i>. In other words, if translating from Unicode to
///              multibyte and back to Unicode again does not yield the same Unicode character, the function uses the default
///              character. This flag can be used by itself or in combination with the other defined flags. For strings that
///              require validation, such as file, resource, and user names, the application should always use the
///              WC_NO_BEST_FIT_CHARS flag. This flag prevents the function from mapping characters to characters that appear
///              similar but have very different semantics. In some cases, the semantic change can be extreme. For example, the
///              symbol for "∞" (infinity) maps to 8 (eight) in some code pages. </td> </tr> </table> For the code pages listed
///              below, <i>dwFlags</i> must be 0. Otherwise, the function fails with ERROR_INVALID_FLAGS. <ul> <li>50220</li>
///              <li>50221</li> <li>50222</li> <li>50225</li> <li>50227</li> <li>50229</li> <li>57002 through 57011</li> <li>65000
///              (UTF-7)</li> <li>42 (Symbol)</li> </ul> <div class="alert"><b>Note</b> For the code page 65001 (UTF-8) or the
///              code page 54936 (GB18030, Windows Vista and later), <i>dwFlags</i> must be set to either 0 or
///              WC_ERR_INVALID_CHARS. Otherwise, the function fails with ERROR_INVALID_FLAGS.</div> <div> </div>
///    lpWideCharStr = Pointer to the Unicode string to convert.
///    cchWideChar = Size, in characters, of the string indicated by <i>lpWideCharStr</i>. Alternatively, this parameter can be set to
///                  -1 if the string is null-terminated. If <i>cchWideChar</i> is set to 0, the function fails. If this parameter is
///                  -1, the function processes the entire input string, including the terminating null character. Therefore, the
///                  resulting character string has a terminating null character, and the length returned by the function includes
///                  this character. If this parameter is set to a positive integer, the function processes exactly the specified
///                  number of characters. If the provided size does not include a terminating null character, the resulting character
///                  string is not null-terminated, and the returned length does not include this character.
///    lpMultiByteStr = Pointer to a buffer that receives the converted string.
///    cbMultiByte = Size, in bytes, of the buffer indicated by <i>lpMultiByteStr</i>. If this parameter is set to 0, the function
///                  returns the required buffer size for <i>lpMultiByteStr</i> and makes no use of the output parameter itself.
///    lpDefaultChar = Pointer to the character to use if a character cannot be represented in the specified code page. The application
///                    sets this parameter to <b>NULL</b> if the function is to use a system default value. To obtain the system default
///                    character, the application can call the GetCPInfo or GetCPInfoEx function. For the CP_UTF7 and CP_UTF8 settings
///                    for <i>CodePage</i>, this parameter must be set to <b>NULL</b>. Otherwise, the function fails with
///                    ERROR_INVALID_PARAMETER.
///    lpUsedDefaultChar = Pointer to a flag that indicates if the function has used a default character in the conversion. The flag is set
///                        to <b>TRUE</b> if one or more characters in the source string cannot be represented in the specified code page.
///                        Otherwise, the flag is set to <b>FALSE</b>. This parameter can be set to <b>NULL</b>. For the CP_UTF7 and CP_UTF8
///                        settings for <i>CodePage</i>, this parameter must be set to <b>NULL</b>. Otherwise, the function fails with
///                        ERROR_INVALID_PARAMETER.
///Returns:
///    If successful, returns the number of bytes written to the buffer pointed to by <i>lpMultiByteStr</i>. If the
///    function succeeds and <i>cbMultiByte</i> is 0, the return value is the required size, in bytes, for the buffer
///    indicated by <i>lpMultiByteStr</i>. Also see <i>dwFlags</i> for info about how the WC_ERR_INVALID_CHARS flag
///    affects the return value when invalid sequences are input. The function returns 0 if it does not succeed. To get
///    extended error information, the application can call GetLastError, which can return one of the following error
///    codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was incorrectly set
///    to <b>NULL</b>.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid. </li> <li>ERROR_NO_UNICODE_TRANSLATION.
///    Invalid Unicode was found in a string.</li> </ul>
///    
@DllImport("KERNEL32")
int WideCharToMultiByte(uint CodePage, uint dwFlags, const(PWSTR) lpWideCharStr, int cchWideChar, 
                        PSTR lpMultiByteStr, int cbMultiByte, const(PSTR) lpDefaultChar, int* lpUsedDefaultChar);

///Determines if a specified code page is valid.
///Params:
///    CodePage = Code page identifier for the code page to check.
///Returns:
///    Returns a nonzero value if the code page is valid, or 0 if the code page is invalid.
///    
@DllImport("KERNEL32")
BOOL IsValidCodePage(uint CodePage);

///Retrieves the current Windows ANSI code page identifier for the operating system.<div class="alert"><b>Caution</b>
///The ANSI API functions, for example, the ANSI version of TextOut, implicitly use <b>GetACP</b> to translate text to
///or from Unicode. For the Multilingual User Interface (MUI) edition of Windows, the system ACP might not cover all
///code points in the user's selected logon language identifier. For compatibility with this edition, your application
///should avoid calls that depend on <b>GetACP</b> either implicitly or explicitly, as this function can cause some
///locales to display text as question marks. Instead, the application should use the Unicode API functions directly,
///for example, the Unicode version of TextOut.</div> <div> </div>
///Returns:
///    Returns the current Windows ANSI code page (ACP) identifier for the operating system. See Code Page Identifiers
///    for a list of identifiers for Windows ANSI code pages and other code pages.
///    
@DllImport("KERNEL32")
uint GetACP();

///Returns the current original equipment manufacturer (OEM) code page identifier for the operating system. <div
///class="alert"><b>Note</b> The ANSI code pages can be different on different computers, or can be changed for a single
///computer, leading to data corruption. For the most consistent results, applications should use Unicode, such as UTF-8
///or UTF-16, instead of a specific code page.</div><div> </div>
///Returns:
///    Returns the current OEM code page identifier for the operating system.
///    
@DllImport("KERNEL32")
uint GetOEMCP();

///Retrieves information about any valid installed or available code page. <div class="alert"><b>Note</b> To obtain
///additional information about valid installed or available code pages, the application should use
///GetCPInfoEx.</div><div> </div>
///Params:
///    CodePage = Identifier for the code page for which to retrieve information. For details, see the <i>CodePage</i> parameter of
///               GetCPInfoEx.
///    lpCPInfo = Pointer to a CPINFO structure that receives information about the code page. See the Remarks section.
///Returns:
///    Returns 1 if successful, or 0 otherwise. To get extended error information, the application can call
///    GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_PARAMETER. Any of the
///    parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL GetCPInfo(uint CodePage, CPINFO* lpCPInfo);

///Retrieves information about any valid installed or available code page.
///Params:
///    CodePage = Identifier for the code page for which to retrieve information. The application can specify the code page
///               identifier for any installed or available code page, or one of the following predefined values. See Code Page
///               Identifiers for a list of identifiers for ANSI and other code pages. <table> <tr> <th>Value</th> <th>Meaning</th>
///               </tr> <tr> <td width="40%"><a id="CP_ACP"></a><a id="cp_acp"></a><dl> <dt><b>CP_ACP</b></dt> </dl> </td> <td
///               width="60%"> Use the system default Windows ANSI code page. </td> </tr> <tr> <td width="40%"><a
///               id="CP_MACCP"></a><a id="cp_maccp"></a><dl> <dt><b>CP_MACCP</b></dt> </dl> </td> <td width="60%"> Use the system
///               default Macintosh code page. </td> </tr> <tr> <td width="40%"><a id="CP_OEMCP"></a><a id="cp_oemcp"></a><dl>
///               <dt><b>CP_OEMCP</b></dt> </dl> </td> <td width="60%"> Use the system default OEM code page. </td> </tr> <tr> <td
///               width="40%"><a id="CP_THREAD_ACP"></a><a id="cp_thread_acp"></a><dl> <dt><b>CP_THREAD_ACP</b></dt> </dl> </td>
///               <td width="60%"> Use the current thread's ANSI code page. </td> </tr> </table>
///    dwFlags = Reserved; must be 0.
///    lpCPInfoEx = Pointer to a CPINFOEX structure that receives information about the code page.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_PARAMETER. Any of
///    the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL GetCPInfoExA(uint CodePage, uint dwFlags, CPINFOEXA* lpCPInfoEx);

///Retrieves information about any valid installed or available code page.
///Params:
///    CodePage = Identifier for the code page for which to retrieve information. The application can specify the code page
///               identifier for any installed or available code page, or one of the following predefined values. See Code Page
///               Identifiers for a list of identifiers for ANSI and other code pages. <table> <tr> <th>Value</th> <th>Meaning</th>
///               </tr> <tr> <td width="40%"><a id="CP_ACP"></a><a id="cp_acp"></a><dl> <dt><b>CP_ACP</b></dt> </dl> </td> <td
///               width="60%"> Use the system default Windows ANSI code page. </td> </tr> <tr> <td width="40%"><a
///               id="CP_MACCP"></a><a id="cp_maccp"></a><dl> <dt><b>CP_MACCP</b></dt> </dl> </td> <td width="60%"> Use the system
///               default Macintosh code page. </td> </tr> <tr> <td width="40%"><a id="CP_OEMCP"></a><a id="cp_oemcp"></a><dl>
///               <dt><b>CP_OEMCP</b></dt> </dl> </td> <td width="60%"> Use the system default OEM code page. </td> </tr> <tr> <td
///               width="40%"><a id="CP_THREAD_ACP"></a><a id="cp_thread_acp"></a><dl> <dt><b>CP_THREAD_ACP</b></dt> </dl> </td>
///               <td width="60%"> Use the current thread's ANSI code page. </td> </tr> </table>
///    dwFlags = Reserved; must be 0.
///    lpCPInfoEx = Pointer to a CPINFOEX structure that receives information about the code page.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_PARAMETER. Any of
///    the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL GetCPInfoExW(uint CodePage, uint dwFlags, CPINFOEXW* lpCPInfoEx);

///Compares two character strings, for a locale specified by identifier. <div class="alert"><b>Caution</b> Using
///<b>CompareString</b> incorrectly can compromise the security of your application. Strings that are not compared
///correctly can produce invalid input. For example, the function can raise security issues when used for a
///non-linguistic comparison, because two strings that are distinct in their binary representation can be linguistically
///equivalent. The application should test strings for validity before using them, and should provide error handlers.
///For more information, see Security Considerations: International Features.</div><div> </div><div
///class="alert"><b>Note</b> For compatibility with Unicode, your applications should prefer CompareStringEx or the
///Unicode version of <b>CompareString</b>. Another reason for preferring CompareStringEx is that Microsoft is migrating
///toward the use of locale names instead of locale identifiers for new locales, for interoperability reasons. Any
///application that will be run only on Windows Vista and later should use CompareStringEx.</div><div> </div>
///Params:
///    Locale = Locale identifier of the locale used for the comparison. You can use the MAKELCID macro to create a locale
///             identifier or use one of the following predefined values. <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li>
///             LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li> LOCALE_INVARIANT </li> <li>
///             LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul>
///    dwCmpFlags = Flags that indicate how the function compares the two strings. For detailed definitions, see the
///                 <i>dwCmpFlags</i> parameter of CompareStringEx.
///    lpString1 = Pointer to the first string to compare.
///    cchCount1 = Length of the string indicated by <i>lpString1</i>, excluding the terminating null character. This value
///                represents bytes for the ANSI version of the function and wide characters for the Unicode version. The
///                application can supply a negative value if the string is null-terminated. In this case, the function determines
///                the length automatically.
///    lpString2 = Pointer to the second string to compare.
///    cchCount2 = Length of the string indicated by <i>lpString2</i>, excluding the terminating null character. This value
///                represents bytes for the ANSI version of the function and wide characters for the Unicode version. The
///                application can supply a negative value if the string is null-terminated. In this case, the function determines
///                the length automatically.
///Returns:
///    Returns the values described for CompareStringEx.
///    
@DllImport("KERNEL32")
int CompareStringA(uint Locale, uint dwCmpFlags, byte* lpString1, int cchCount1, byte* lpString2, int cchCount2);

///Locates a Unicode string (wide characters) or its equivalent in another Unicode string for a locale specified by
///identifier. <div class="alert"><b>Caution</b> Because strings with very different binary representations can compare
///as identical, this function can raise certain security concerns. For more information, see the discussion of
///comparison functions in Security Considerations: International Features.</div><div> </div><div
///class="alert"><b>Note</b> For interoperability reasons, the application should prefer the FindNLSStringEx function
///because Microsoft is migrating toward the use of locale names instead of locale identifiers for new locales. Although
///<b>FindNLSString</b> supports custom locales, most applications should use FindNLSStringEx for this type of
///support.</div><div> </div>
///Params:
///    Locale = Locale identifier that specifies the locale. You can use the MAKELCID macro to create an identifier or use one of
///             the following predefined values. <ul> <li> LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li>
///             LOCALE_USER_DEFAULT </li> </ul> <b>Windows Vista and later:</b> The following custom locale identifiers are also
///             supported. <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li>
///             LOCALE_CUSTOM_UNSPECIFIED </li> </ul>
///    dwFindNLSStringFlags = Flags specifying details of the find operation. For detailed definitions, see the <i>dwFindNLSStringFlags</i>
///                           parameter of FindNLSStringEx.
///    lpStringSource = Pointer to the source string, in which the function searches for the string specified by <i>lpStringValue</i>.
///    cchSource = Size, in characters excluding the terminating null character, of the string indicated by <i>lpStringSource</i>.
///                The application cannot specify 0 or any negative number other than -1 for this parameter. The application
///                specifies -1 if the source string is null-terminated and the function should calculate the size automatically.
///    lpStringValue = Pointer to the search string, for which the function searches in the source string.
///    cchValue = Size, in characters excluding the terminating null character, of the string indicated by <i>lpStringValue</i>.
///               The application cannot specify 0 or any negative number other than -1 for this parameter. The application
///               specifies -1 if the search string is null-terminated and the function should calculate the size automatically.
///    pcchFound = Pointer to a buffer containing the length of the string that the function finds. For details, see the
///                <i>pcchFound</i> parameter of FindNLSStringEx.
///Returns:
///    Returns a 0-based index into the source string indicated by <i>lpStringSource</i> if successful. In combination
///    with the value in <i>pcchFound</i>, this index provides the exact location of the entire found string in the
///    source string. A return value of 0 is an error-free index into the source string, and the matching string is in
///    the source string at offset 0. The function returns -1 if it does not succeed. To get extended error information,
///    the application can call GetLastError, which can return one of the following error codes: <ul>
///    <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of
///    the parameter values was invalid.</li> <li>ERROR_SUCCESS. The action completed successfully but yielded no
///    results.</li> </ul>
///    
@DllImport("KERNEL32")
int FindNLSString(uint Locale, uint dwFindNLSStringFlags, const(PWSTR) lpStringSource, int cchSource, 
                  const(PWSTR) lpStringValue, int cchValue, int* pcchFound);

///For a locale specified by identifier, maps one input character string to another using a specified transformation, or
///generates a sort key for the input string. <div class="alert"><b>Note</b> For interoperability reasons, the
///application should prefer the LCMapStringEx function to <b>LCMapString</b> because Microsoft is migrating toward the
///use of locale names instead of locale identifiers for new locales. This recommendation applies especially to custom
///locales, including those created by Microsoft. Any application that will be run only on Windows Vista and later
///should use LCMapStringEx. </div> <div> </div>
///Params:
///    Locale = Locale identifier that specifies the locale. You can use the MAKELCID macro to create a locale identifier or use
///             one of the following predefined values. <ul> <li> LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li>
///             LOCALE_USER_DEFAULT </li> </ul> The following custom locale identifiers are also supported. <ul> <li>
///             LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> </ul>
///    dwMapFlags = Flags specifying the type of transformation to use during string mapping or the type of sort key to generate. For
///                 detailed definitions, see the <i>dwMapFlags</i> parameter of LCMapStringEx.
///    lpSrcStr = Pointer to a source string that the function maps or uses for sort key generation. This string cannot have a size
///               of 0.
///    cchSrc = Size, in characters, of the source string indicated by <i>lpSrcStr</i>. The size of the source string can include
///             the terminating null character, but does not have to. If the terminating null character is included, the mapping
///             behavior of the function is not greatly affected because the terminating null character is considered to be
///             unsortable and always maps to itself. The application can set the parameter to any negative value to specify that
///             the source string is null-terminated. In this case, if <b>LCMapString</b> is being used in its string-mapping
///             mode, the function calculates the string length itself, and null-terminates the mapped string indicated by
///             <i>lpDestStr</i>. The application cannot set this parameter to 0.
///    lpDestStr = Pointer to a buffer in which this function retrieves the mapped string or a sort key. When the application uses
///                this function to generate a sort key, the destination string can contain an odd number of bytes. The
///                LCMAP_BYTEREV flag only reverses an even number of bytes. The last byte (odd-positioned) in the sort key is not
///                reversed. <div class="alert"><b>Note</b> The destination string can be the same as the source string only if
///                LCMAP_UPPERCASE or LCMAP_LOWERCASE is set. Otherwise, the strings cannot be the same. If they are, the function
///                fails.</div> <div> </div> <div class="alert"><b>Note</b> Upon failure of the function, the destination buffer
///                might contain either partial results or no results at all. In this case, it is recommended for your application
///                to consider any results invalid.</div> <div> </div>
///    cchDest = Size, in characters, of the destination string indicated by <i>lpDestStr</i>. If the application is using the
///              function for string mapping, it supplies a character count for this parameter. If space for a terminating null
///              character is included in <i>cchSrc</i>, <i>cchDest</i> must also include space for a terminating null character.
///              If the application is using the function to generate a sort key, it supplies a byte count for the size. This byte
///              count must include space for the sort key 0x00 terminator. The application can set <i>cchDest</i> to 0. In this
///              case, the function does not use the <i>lpDestStr</i> parameter and returns the required buffer size for the
///              mapped string or sort key.
///Returns:
///    Returns the number of characters or bytes in the translated string or sort key, including a terminating null
///    character, if successful. If the function succeeds and the value of <i>cchDest</i> is 0, the return value is the
///    size of the buffer required to hold the translated string or sort key, including a terminating null character.
///    This function returns 0 if it does not succeed. To get extended error information, the application can call
///    GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied
///    buffer size was not large enough, or it was incorrectly set to <b>NULL</b>.</li> <li>ERROR_INVALID_FLAGS. The
///    values supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int LCMapStringW(uint Locale, uint dwMapFlags, const(PWSTR) lpSrcStr, int cchSrc, PWSTR lpDestStr, int cchDest);

///For a locale specified by identifier, maps one input character string to another using a specified transformation, or
///generates a sort key for the input string. <div class="alert"><b>Note</b> For interoperability reasons, the
///application should prefer the LCMapStringEx function to <b>LCMapString</b> because Microsoft is migrating toward the
///use of locale names instead of locale identifiers for new locales. This recommendation applies especially to custom
///locales, including those created by Microsoft. Any application that will be run only on Windows Vista and later
///should use LCMapStringEx. </div> <div> </div>
///Params:
///    Locale = Locale identifier that specifies the locale. You can use the MAKELCID macro to create a locale identifier or use
///             one of the following predefined values. <ul> <li> LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li>
///             LOCALE_USER_DEFAULT </li> </ul> The following custom locale identifiers are also supported. <ul> <li>
///             LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> </ul>
///    dwMapFlags = Flags specifying the type of transformation to use during string mapping or the type of sort key to generate. For
///                 detailed definitions, see the <i>dwMapFlags</i> parameter of LCMapStringEx.
///    lpSrcStr = Pointer to a source string that the function maps or uses for sort key generation. This string cannot have a size
///               of 0.
///    cchSrc = Size, in characters, of the source string indicated by <i>lpSrcStr</i>. The size of the source string can include
///             the terminating null character, but does not have to. If the terminating null character is included, the mapping
///             behavior of the function is not greatly affected because the terminating null character is considered to be
///             unsortable and always maps to itself. The application can set the parameter to any negative value to specify that
///             the source string is null-terminated. In this case, if <b>LCMapString</b> is being used in its string-mapping
///             mode, the function calculates the string length itself, and null-terminates the mapped string indicated by
///             <i>lpDestStr</i>. The application cannot set this parameter to 0.
///    lpDestStr = Pointer to a buffer in which this function retrieves the mapped string or a sort key. When the application uses
///                this function to generate a sort key, the destination string can contain an odd number of bytes. The
///                LCMAP_BYTEREV flag only reverses an even number of bytes. The last byte (odd-positioned) in the sort key is not
///                reversed. <div class="alert"><b>Note</b> The destination string can be the same as the source string only if
///                LCMAP_UPPERCASE or LCMAP_LOWERCASE is set. Otherwise, the strings cannot be the same. If they are, the function
///                fails.</div> <div> </div> <div class="alert"><b>Note</b> Upon failure of the function, the destination buffer
///                might contain either partial results or no results at all. In this case, it is recommended for your application
///                to consider any results invalid.</div> <div> </div>
///    cchDest = Size, in characters, of the destination string indicated by <i>lpDestStr</i>. If the application is using the
///              function for string mapping, it supplies a character count for this parameter. If space for a terminating null
///              character is included in <i>cchSrc</i>, <i>cchDest</i> must also include space for a terminating null character.
///              If the application is using the function to generate a sort key, it supplies a byte count for the size. This byte
///              count must include space for the sort key 0x00 terminator. The application can set <i>cchDest</i> to 0. In this
///              case, the function does not use the <i>lpDestStr</i> parameter and returns the required buffer size for the
///              mapped string or sort key.
///Returns:
///    Returns the number of characters or bytes in the translated string or sort key, including a terminating null
///    character, if successful. If the function succeeds and the value of <i>cchDest</i> is 0, the return value is the
///    size of the buffer required to hold the translated string or sort key, including a terminating null character.
///    This function returns 0 if it does not succeed. To get extended error information, the application can call
///    GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied
///    buffer size was not large enough, or it was incorrectly set to <b>NULL</b>.</li> <li>ERROR_INVALID_FLAGS. The
///    values supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int LCMapStringA(uint Locale, uint dwMapFlags, const(PSTR) lpSrcStr, int cchSrc, PSTR lpDestStr, int cchDest);

///Retrieves information about a locale specified by identifier. <div class="alert"><b>Note</b> For interoperability
///reasons, the application should prefer the GetLocaleInfoEx function to <b>GetLocaleInfo</b> because Microsoft is
///migrating toward the use of locale names instead of locale identifiers for new locales. Any application that runs
///only on Windows Vista and later should use GetLocaleInfoEx.</div><div> </div>
///Params:
///    Locale = Locale identifier for which to retrieve information. You can use the MAKELCID macro to create a locale identifier
///             or use one of the following predefined values. <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li>
///             LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li> LOCALE_INVARIANT </li> <li>
///             LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul>
///    LCType = The locale information to retrieve. For detailed definitions, see the <i>LCType</i> parameter of GetLocaleInfoEx.
///             <div class="alert"><b>Note</b> For <b>GetLocaleInfo</b>, the value LOCALE_USE_CP_ACP is relevant only for the
///             ANSI version.</div> <div> </div>
///    lpLCData = Pointer to a buffer in which this function retrieves the requested locale information. This pointer is not used
///               if <i>cchData</i> is set to 0. For more information, see the Remarks section.
///    cchData = Size, in TCHAR values, of the data buffer indicated by <i>lpLCData</i>. Alternatively, the application can set
///              this parameter to 0. In this case, the function does not use the <i>lpLCData</i> parameter and returns the
///              required buffer size, including the terminating null character.
///Returns:
///    Returns the number of characters retrieved in the locale data buffer if successful and <i>cchData</i> is a
///    nonzero value. If the function succeeds, <i>cchData</i> is nonzero, and LOCALE_RETURN_NUMBER is specified, the
///    return value is the size of the integer retrieved in the data buffer; that is, 2 for the Unicode version of the
///    function or 4 for the ANSI version. If the function succeeds and the value of <i>cchData</i> is 0, the return
///    value is the required size, in characters including a null character, for the locale data buffer. The function
///    returns 0 if it does not succeed. To get extended error information, the application can call GetLastError, which
///    can return one of the following error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not
///    large enough, or it was incorrectly set to <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The values supplied for
///    flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int GetLocaleInfoW(uint Locale, uint LCType, PWSTR lpLCData, int cchData);

///Retrieves information about a locale specified by identifier. <div class="alert"><b>Note</b> For interoperability
///reasons, the application should prefer the GetLocaleInfoEx function to <b>GetLocaleInfo</b> because Microsoft is
///migrating toward the use of locale names instead of locale identifiers for new locales. Any application that runs
///only on Windows Vista and later should use GetLocaleInfoEx.</div> <div class="alert"><b>Note</b> For global
///compatibility, the application should prefer the Unicode "W" API forms to the "A" forms. GetLocaleInfoA will limit
///the character data and could result in results that appear corrupted to users, particularly in globally enabled
///applications. For this API, GetLocaleInfoEx is preferred as it is Unicode and also supports modern locale name
///standards.</div> <div> </div>
///Params:
///    Locale = Locale identifier for which to retrieve information. You can use the MAKELCID macro to create a locale identifier
///             or use one of the following predefined values. <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li>
///             LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li> LOCALE_INVARIANT </li> <li>
///             LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul>
///    LCType = The locale information to retrieve. For detailed definitions, see the <i>LCType</i> parameter of GetLocaleInfoEx.
///             <div class="alert"><b>Note</b> For <b>GetLocaleInfo</b>, the value LOCALE_USE_CP_ACP is relevant only for the
///             ANSI version.</div> <div> </div>
///    lpLCData = Pointer to a buffer in which this function retrieves the requested locale information. This pointer is not used
///               if <i>cchData</i> is set to 0. For more information, see the Remarks section.
///    cchData = Size, in TCHAR values, of the data buffer indicated by <i>lpLCData</i>. Alternatively, the application can set
///              this parameter to 0. In this case, the function does not use the <i>lpLCData</i> parameter and returns the
///              required buffer size, including the terminating null character.
///Returns:
///    Returns the number of characters retrieved in the locale data buffer if successful and <i>cchData</i> is a
///    nonzero value. If the function succeeds, <i>cchData</i> is nonzero, and LOCALE_RETURN_NUMBER is specified, the
///    return value is the size of the integer retrieved in the data buffer; that is, 2 for the Unicode version of the
///    function or 4 for the ANSI version. If the function succeeds and the value of <i>cchData</i> is 0, the return
///    value is the required size, in characters including a null character, for the locale data buffer. The function
///    returns 0 if it does not succeed. To get extended error information, the application can call GetLastError, which
///    can return one of the following error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not
///    large enough, or it was incorrectly set to <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The values supplied for
///    flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int GetLocaleInfoA(uint Locale, uint LCType, PSTR lpLCData, int cchData);

///Sets an item of information in the user override portion of the current locale. This function does not set the system
///defaults. <div class="alert"><b>Caution</b> Because this function modifies values for all applications, it should
///only be called by the regional and language options functionality of Control Panel, or a similar utility. If making
///an international change to system parameters, the calling application must broadcast the WM_SETTINGCHANGE message to
///avoid causing instabilities in other applications.</div><div> </div>
///Params:
///    Locale = For the ANSI version of the function, the locale identifier of the locale with the code page used when
///             interpreting the <i>lpLCData</i> information. For the Unicode version, this parameter is ignored. You can use the
///             MAKELCID macro to create a locale identifier or use one of the following predefined values. <ul> <li>
///             LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul> The following custom
///             locale identifiers are also supported. <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li>
///             <li> LOCALE_CUSTOM_UNSPECIFIED </li> </ul>
///    LCType = Type of locale information to set. For valid constants see "Constants Used in the LCType Parameter of
///             GetLocaleInfo, GetLocaleInfoEx, and SetLocaleInfo" section of Locale Information Constants. The application can
///             specify only one value per call, but it can use the binary OR operator to combine LOCALE_USE_CP_ACP with any
///             other constant.
///    lpLCData = Pointer to a null-terminated string containing the locale information to set. The information must be in the
///               format specific to the specified constant. The application uses a Unicode string for the Unicode version of the
///               function, and an ANSI string for the ANSI version.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_ACCESS_DISABLED_BY_POLICY.
///    The group policy of the computer or the user has forbidden this operation.</li> <li>ERROR_INVALID_ACCESS. The
///    access code was invalid.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL SetLocaleInfoA(uint Locale, uint LCType, const(PSTR) lpLCData);

///Sets an item of information in the user override portion of the current locale. This function does not set the system
///defaults. <div class="alert"><b>Caution</b> Because this function modifies values for all applications, it should
///only be called by the regional and language options functionality of Control Panel, or a similar utility. If making
///an international change to system parameters, the calling application must broadcast the WM_SETTINGCHANGE message to
///avoid causing instabilities in other applications.</div><div> </div>
///Params:
///    Locale = For the ANSI version of the function, the locale identifier of the locale with the code page used when
///             interpreting the <i>lpLCData</i> information. For the Unicode version, this parameter is ignored. You can use the
///             MAKELCID macro to create a locale identifier or use one of the following predefined values. <ul> <li>
///             LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul> The following custom
///             locale identifiers are also supported. <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li>
///             <li> LOCALE_CUSTOM_UNSPECIFIED </li> </ul>
///    LCType = Type of locale information to set. For valid constants see "Constants Used in the LCType Parameter of
///             GetLocaleInfo, GetLocaleInfoEx, and SetLocaleInfo" section of Locale Information Constants. The application can
///             specify only one value per call, but it can use the binary OR operator to combine LOCALE_USE_CP_ACP with any
///             other constant.
///    lpLCData = Pointer to a null-terminated string containing the locale information to set. The information must be in the
///               format specific to the specified constant. The application uses a Unicode string for the Unicode version of the
///               function, and an ANSI string for the ANSI version.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_ACCESS_DISABLED_BY_POLICY.
///    The group policy of the computer or the user has forbidden this operation.</li> <li>ERROR_INVALID_ACCESS. The
///    access code was invalid.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL SetLocaleInfoW(uint Locale, uint LCType, const(PWSTR) lpLCData);

///Retrieves information about a calendar for a locale specified by identifier. <div class="alert"><b>Note</b> For
///interoperability reasons, the application should prefer the GetCalendarInfoEx function to <b>GetCalendarInfo</b>
///because Microsoft is migrating toward the use of locale names instead of locale identifiers for new locales. Any
///application that runs only on Windows Vista and later should use GetCalendarInfoEx.</div><div> </div>
///Params:
///    Locale = Locale identifier that specifies the locale for which to retrieve calendar information. You can use the MAKELCID
///             macro to create a locale identifier or use one of the following predefined values. <ul> <li>
///             LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li>
///             LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul>
///    Calendar = Calendar identifier.
///    CalType = Type of information to retrieve. For more information, see Calendar Type Information. <div
///              class="alert"><b>Note</b> <b>GetCalendarInfo</b> returns only one string if this parameter specifies
///              CAL_IYEAROFFSETRANGE or CAL_SERASTRING. In both cases the current era is returned.</div> <div> </div>
///              CAL_USE_CP_ACP is relevant only for the ANSI version of this function. For CAL_NOUSEROVERRIDE, the function
///              ignores any value set by SetCalendarInfo and uses the database settings for the current system default locale.
///              This type is relevant only in the combination CAL_NOUSEROVERRIDE | CAL_ITWODIGITYEARMAX. CAL_ITWODIGITYEARMAX is
///              the only value that can be set by <b>SetCalendarInfo</b>.
///    lpCalData = Pointer to a buffer in which this function retrieves the requested data as a string. If CAL_RETURN_NUMBER is
///                specified in <i>CalType</i>, this parameter must retrieve <b>NULL</b>.
///    cchData = Size, in characters, of the <i>lpCalData</i> buffer. The application can set this parameter to 0 to return the
///              required size for the calendar data buffer. In this case, the <i>lpCalData</i> parameter is not used. If
///              CAL_RETURN_NUMBER is specified for <i>CalType</i>, the value of <i>cchData</i> must be 0.
///    lpValue = Pointer to a variable that receives the requested data as a number. If CAL_RETURN_NUMBER is specified in
///              <i>CalType</i>, then <i>lpValue</i> must not be <b>NULL</b>. If CAL_RETURN_NUMBER is not specified in
///              <i>CalType</i>, then <i>lpValue</i> must be <b>NULL</b>.
///Returns:
///    Returns the number of characters retrieved in the <i>lpCalData</i> buffer, with <i>cchData</i> set to a nonzero
///    value, if successful. If the function succeeds, <i>cchData</i> is set to 0, and CAL_RETURN_NUMBER is not
///    specified, the return value is the size of the buffer required to hold the calendar information. If the function
///    succeeds, <i>cchData</i> is set 0, and CAL_RETURN_NUMBER is specified, the return value is the size of the value
///    retrieved in <i>lpValue</i>, that is, 2 for the Unicode version of the function or 4 for the ANSI version. This
///    function returns 0 if it does not succeed. To get extended error information, the application can call
///    GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied
///    buffer size was not large enough, or it was incorrectly set to <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The
///    values supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int GetCalendarInfoA(uint Locale, uint Calendar, uint CalType, PSTR lpCalData, int cchData, uint* lpValue);

///Retrieves information about a calendar for a locale specified by identifier. <div class="alert"><b>Note</b> For
///interoperability reasons, the application should prefer the GetCalendarInfoEx function to <b>GetCalendarInfo</b>
///because Microsoft is migrating toward the use of locale names instead of locale identifiers for new locales. Any
///application that runs only on Windows Vista and later should use GetCalendarInfoEx.</div><div> </div>
///Params:
///    Locale = Locale identifier that specifies the locale for which to retrieve calendar information. You can use the MAKELCID
///             macro to create a locale identifier or use one of the following predefined values. <ul> <li>
///             LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li>
///             LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul>
///    Calendar = Calendar identifier.
///    CalType = Type of information to retrieve. For more information, see Calendar Type Information. <div
///              class="alert"><b>Note</b> <b>GetCalendarInfo</b> returns only one string if this parameter specifies
///              CAL_IYEAROFFSETRANGE or CAL_SERASTRING. In both cases the current era is returned.</div> <div> </div>
///              CAL_USE_CP_ACP is relevant only for the ANSI version of this function. For CAL_NOUSEROVERRIDE, the function
///              ignores any value set by SetCalendarInfo and uses the database settings for the current system default locale.
///              This type is relevant only in the combination CAL_NOUSEROVERRIDE | CAL_ITWODIGITYEARMAX. CAL_ITWODIGITYEARMAX is
///              the only value that can be set by <b>SetCalendarInfo</b>.
///    lpCalData = Pointer to a buffer in which this function retrieves the requested data as a string. If CAL_RETURN_NUMBER is
///                specified in <i>CalType</i>, this parameter must retrieve <b>NULL</b>.
///    cchData = Size, in characters, of the <i>lpCalData</i> buffer. The application can set this parameter to 0 to return the
///              required size for the calendar data buffer. In this case, the <i>lpCalData</i> parameter is not used. If
///              CAL_RETURN_NUMBER is specified for <i>CalType</i>, the value of <i>cchData</i> must be 0.
///    lpValue = Pointer to a variable that receives the requested data as a number. If CAL_RETURN_NUMBER is specified in
///              <i>CalType</i>, then <i>lpValue</i> must not be <b>NULL</b>. If CAL_RETURN_NUMBER is not specified in
///              <i>CalType</i>, then <i>lpValue</i> must be <b>NULL</b>.
///Returns:
///    Returns the number of characters retrieved in the <i>lpCalData</i> buffer, with <i>cchData</i> set to a nonzero
///    value, if successful. If the function succeeds, <i>cchData</i> is set to 0, and CAL_RETURN_NUMBER is not
///    specified, the return value is the size of the buffer required to hold the calendar information. If the function
///    succeeds, <i>cchData</i> is set 0, and CAL_RETURN_NUMBER is specified, the return value is the size of the value
///    retrieved in <i>lpValue</i>, that is, 2 for the Unicode version of the function or 4 for the ANSI version. This
///    function returns 0 if it does not succeed. To get extended error information, the application can call
///    GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied
///    buffer size was not large enough, or it was incorrectly set to <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The
///    values supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int GetCalendarInfoW(uint Locale, uint Calendar, uint CalType, PWSTR lpCalData, int cchData, uint* lpValue);

///Sets an item of locale information for a calendar. For more information, see Date and Calendar.
///Params:
///    Locale = Locale identifier that specifies the locale. You can use the MAKELCID macro to create a locale identifier or use
///             one of the following predefined values. <ul> <li> LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li>
///             LOCALE_USER_DEFAULT </li> </ul> The following custom locale identifiers are also supported. <ul> <li>
///             LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> </ul>
///    Calendar = Calendar identifier for the calendar for which to set information.
///    CalType = Type of calendar information to set. Only the following CALTYPE values are valid for this function. The
///              CAL_USE_CP_ACP constant is only meaningful for the ANSI version of the function. <ul> <li>CAL_USE_CP_ACP</li>
///              <li>CAL_ITWODIGITYEARMAX</li> </ul> The application can specify only one calendar identifier per call to this
///              function. An exception can be made if the application uses the binary OR operator to combine CAL_USE_CP_ACP with
///              any valid CALTYPE value defined in Calendar Type Information.
///    lpCalData = Pointer to a null-terminated calendar information string. The information must be in the format of the specified
///                calendar type.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INTERNAL_ERROR. An
///    unexpected error occurred in the function.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not
///    valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL SetCalendarInfoA(uint Locale, uint Calendar, uint CalType, const(PSTR) lpCalData);

///Sets an item of locale information for a calendar. For more information, see Date and Calendar.
///Params:
///    Locale = Locale identifier that specifies the locale. You can use the MAKELCID macro to create a locale identifier or use
///             one of the following predefined values. <ul> <li> LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li>
///             LOCALE_USER_DEFAULT </li> </ul> The following custom locale identifiers are also supported. <ul> <li>
///             LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> </ul>
///    Calendar = Calendar identifier for the calendar for which to set information.
///    CalType = Type of calendar information to set. Only the following CALTYPE values are valid for this function. The
///              CAL_USE_CP_ACP constant is only meaningful for the ANSI version of the function. <ul> <li>CAL_USE_CP_ACP</li>
///              <li>CAL_ITWODIGITYEARMAX</li> </ul> The application can specify only one calendar identifier per call to this
///              function. An exception can be made if the application uses the binary OR operator to combine CAL_USE_CP_ACP with
///              any valid CALTYPE value defined in Calendar Type Information.
///    lpCalData = Pointer to a null-terminated calendar information string. The information must be in the format of the specified
///                calendar type.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INTERNAL_ERROR. An
///    unexpected error occurred in the function.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not
///    valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL SetCalendarInfoW(uint Locale, uint Calendar, uint CalType, const(PWSTR) lpCalData);

///Determines if a specified character is a lead byte for the system default Windows ANSI code page (<b>CP_ACP</b>). A
///lead byte is the first byte of a two-byte character in a double-byte character set (DBCS) for the code page. <div
///class="alert"><b>Note</b> To use a different code page, your application should use the IsDBCSLeadByteEx
///function.</div><div> </div>
///Params:
///    TestChar = The character to test.
///Returns:
///    Returns a nonzero value if the test character is potentially a lead byte. The function returns 0 if the test
///    character is not a lead byte or if it is a single-byte character. To get extended error information, the
///    application can call GetLastError.
///    
@DllImport("KERNEL32")
BOOL IsDBCSLeadByte(ubyte TestChar);

///Determines if a specified character is potentially a lead byte. A lead byte is the first byte of a two-byte character
///in a double-byte character set (DBCS) for the code page.
///Params:
///    CodePage = Identifier of the code page used to check lead byte ranges. This parameter can be one of the code page
///               identifiers defined in Unicode and Character Set Constants or one of the following predefined values. This
///               function validates lead byte values only in code pages 932, 936, 949, 950, and 1361. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CP_ACP"></a><a id="cp_acp"></a><dl> <dt><b>CP_ACP</b></dt>
///               </dl> </td> <td width="60%"> Use system default Windows ANSI code page. </td> </tr> <tr> <td width="40%"><a
///               id="CP_MACCP"></a><a id="cp_maccp"></a><dl> <dt><b>CP_MACCP</b></dt> </dl> </td> <td width="60%"> Use the system
///               default Macintosh code page. </td> </tr> <tr> <td width="40%"><a id="CP_OEMCP"></a><a id="cp_oemcp"></a><dl>
///               <dt><b>CP_OEMCP</b></dt> </dl> </td> <td width="60%"> Use system default OEM code page. </td> </tr> <tr> <td
///               width="40%"><a id="CP_THREAD_ACP"></a><a id="cp_thread_acp"></a><dl> <dt><b>CP_THREAD_ACP</b></dt> </dl> </td>
///               <td width="60%"> Use the Windows ANSI code page for the current thread. </td> </tr> </table>
///    TestChar = The character to test.
///Returns:
///    Returns a nonzero value if the byte is a lead byte. The function returns 0 if the byte is not a lead byte or if
///    the character is a single-byte character. To get extended error information, the application can call
///    GetLastError.
///    
@DllImport("KERNEL32")
BOOL IsDBCSLeadByteEx(uint CodePage, ubyte TestChar);

///Converts a locale name to a locale identifier. <div class="alert"><b>Note</b> For custom locales, including those
///created by Microsoft, your applications should prefer locale names over locale identifiers.</div> <div> </div>
///Params:
///    lpName = Pointer to a null-terminated string representing a locale name, or one of the following predefined values. <ul>
///             <li> LOCALE_NAME_INVARIANT </li> <li> LOCALE_NAME_SYSTEM_DEFAULT </li> <li> LOCALE_NAME_USER_DEFAULT </li> </ul>
///    dwFlags = <b>Prior to Windows 7:</b>Reserved; should always be 0. <b>Beginning in Windows 7:</b> Can be set to
///              LOCALE_ALLOW_NEUTRAL_NAMES to allow the return of a neutral LCID.
///Returns:
///    Returns the locale identifier corresponding to the locale name if successful. If the supplied locale name
///    corresponds to a custom locale that is the user default, this function returns LOCALE_CUSTOM_DEFAULT. If the
///    locale name corresponds to a custom locale that is not the user default, the function returns
///    LOCALE_CUSTOM_UNSPECIFIED. If the locale provided is a transient locale or a CLDR (Unicode Common Locale Data
///    Repository) locale, then the LCID returned is 0x1000. The function returns 0 if it does not succeed. To get
///    extended error information, the application can call GetLastError, which can return one of the following error
///    codes: <ul> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
uint LocaleNameToLCID(const(PWSTR) lpName, uint dwFlags);

///Converts a locale identifier to a locale name. <div class="alert"><b>Note</b> For custom locales, including those
///created by Microsoft, your applications should prefer locale names over locale identifiers.</div> <div> </div>
///Params:
///    Locale = Locale identifier to translate. You can use the MAKELCID macro to create a locale identifier or use one of the
///             following predefined values. <ul> <li> LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li>
///             LOCALE_USER_DEFAULT </li> </ul> <b>Windows Vista:</b> The following custom locale identifiers are also supported.
///             <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li>
///             </ul>
///    lpName = Pointer to a buffer in which this function retrieves the locale name, or one of the following predefined values.
///             <ul> <li> LOCALE_NAME_INVARIANT </li> <li> LOCALE_NAME_SYSTEM_DEFAULT </li> <li> LOCALE_NAME_USER_DEFAULT </li>
///             </ul>
///    cchName = Size, in characters, of the locale name buffer. The maximum possible length of a locale name, including a
///              terminating null character, is LOCALE_NAME_MAX_LENGTH. This is the recommended size to supply for this parameter.
///              Alternatively, the application can set this parameter to 0. In this case, the function returns the required size
///              for the locale name buffer.
///    dwFlags = <b>Before Windows 7:</b> Reserved; should always be 0. <b>Starting with Windows 7:</b> Can be set to
///              LOCALE_ALLOW_NEUTRAL_NAMES to allow the return of a neutral name.
///Returns:
///    Returns the count of characters, including the terminating null character, in the locale name if successful. If
///    the function succeeds and the value of <i>cchName</i> is 0, the return value is the required size, in characters
///    (including nulls), for the locale name buffer. The function returns 0 if it does not succeed. To get extended
///    error information, the application can call GetLastError, which can return one of the following error codes: <ul>
///    <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was incorrectly set to
///    <b>NULL</b>.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int LCIDToLocaleName(uint Locale, PWSTR lpName, int cchName, uint dwFlags);

///Formats a duration of time as a time string for a locale specified by identifier. <div class="alert"><b>Note</b> For
///interoperability reasons, the application should prefer the GetDurationFormatEx function to <b>GetDurationFormat</b>
///because Microsoft is migrating toward the use of locale names instead of locale identifiers for new locales. Any
///application that runs only on Windows Vista and later should use GetDurationFormatEx.</div><div> </div>
///Params:
///    Locale = Locale identifier that specifies the locale for which this function formats the duration. You can use the
///             MAKELCID macro to create a locale identifier or use one of the following predefined values. <ul> <li>
///             LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul> <b>Windows Vista and
///             later:</b> The following custom locale identifiers are also supported. <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li>
///             LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> </ul>
///    dwFlags = Flags specifying function options. If <i>lpFormat</i> is not set to <b>NULL</b>, this parameter must be set to 0.
///              If <i>lpFormat</i> is set to <b>NULL</b>, your application can specify LOCALE_NOUSEROVERRIDE to format the string
///              using the system default duration format for the specified locale. <div class="alert"><b>Caution</b> Use of
///              LOCALE_NOUSEROVERRIDE is strongly discouraged as it disables user preferences.</div> <div> </div>
///    lpDuration = Pointer to a SYSTEMTIME structure that contains the time duration information to format. If this pointer is
///                 <b>NULL</b>, the function ignores this parameter and uses <i>ullDuration</i>.
///    ullDuration = 64-bit unsigned integer that represents the number of 100-nanosecond intervals in the duration. If both
///                  <i>lpDuration</i> and <i>ullDuration</i> are present, <i>lpDuration</i> takes precedence. If <i>lpDuration</i> is
///                  set to <b>NULL</b> and <i>ullDuration</i> is set to 0, the duration is zero.
///    lpFormat = Pointer to the format string. For details, see the <i>lpFormat</i> parameter of GetDurationFormatEx.
///    lpDurationStr = Pointer to the buffer in which the function retrieves the duration string. Alternatively, this parameter can
///                    contain <b>NULL</b> if <i>cchDuration</i> is set to 0. In this case, the function returns the required size for
///                    the duration string buffer.
///    cchDuration = Size, in characters, of the buffer indicated by <i>lpDurationStr</i>. Alternatively, the application can set this
///                  parameter to 0. In this case, the function retrieves <b>NULL</b> in <i>lpDurationStr</i> and returns the required
///                  size for the duration string buffer.
///Returns:
///    Returns the number of characters retrieved in the buffer indicated by <i>lpDurationStr</i> if successful. If
///    <i>lpDurationStr</i> is set to <b>NULL</b> and <i>cchDuration</i> is set to 0, the function returns the required
///    size for the duration string buffer, including the null terminating character. For example, if 10 characters are
///    written to the buffer, the function returns 11 to include the terminating null character. The function returns 0
///    if it does not succeed. To get extended error information, the application can call GetLastError, which can
///    return one of the following error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large
///    enough, or it was incorrectly set to <b>NULL</b>. </li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values
///    was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int GetDurationFormat(uint Locale, uint dwFlags, const(SYSTEMTIME)* lpDuration, ulong ullDuration, 
                      const(PWSTR) lpFormat, PWSTR lpDurationStr, int cchDuration);

///Formats a number string as a number string customized for a locale specified by identifier. <div
///class="alert"><b>Note</b> For interoperability reasons, the application should prefer the GetNumberFormatEx function
///to <b>GetNumberFormat</b> because Microsoft is migrating toward the use of locale names instead of locale identifiers
///for new locales. Any application that runs only on Windows Vista and later should use
///<b>GetNumberFormatEx</b>.</div><div> </div>
///Params:
///    Locale = Locale identifier that specifies the locale. You can use the MAKELCID macro to create a locale identifier or use
///             one of the following predefined values. <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li>
///             <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li> LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li>
///             LOCALE_USER_DEFAULT </li> </ul>
///    dwFlags = Flags controlling the operation of the function. The application must set this parameter to 0 if <i>lpFormat</i>
///              is not set to <b>NULL</b>. In this case, the function formats the string using user overrides to the default
///              number format for the locale. If <i>lpFormat</i> is set to <b>NULL</b>, the application can specify
///              LOCALE_NOUSEROVERRIDE to format the string using the system default number format for the specified locale. <div
///              class="alert"><b>Caution</b> Use of LOCALE_NOUSEROVERRIDE is strongly discouraged as it disables user
///              preferences.</div> <div> </div>
///    lpValue = Pointer to a null-terminated string containing the number string to format. This string can only contain the
///              following characters. All other characters are invalid. The function returns an error if the string indicated by
///              <i>lpValue</i> deviates from these rules. <ul> <li>Characters "0" through "9".</li> <li>One decimal point (dot)
///              if the number is a floating-point value.</li> <li>A minus sign in the first character position if the number is a
///              negative value.</li> </ul>
///    lpFormat = Pointer to a NUMBERFMT structure that contains number formatting information, with all members set to appropriate
///               values. If this parameter does is not set to <b>NULL</b>, the function uses the locale only for formatting
///               information not specified in the structure, for example, the locale-specific string value for the negative sign.
///    lpNumberStr = Pointer to a buffer in which this function retrieves the formatted number string.
///    cchNumber = Size, in TCHAR values, for the number string buffer indicated by <i>lpNumberStr</i>. Alternatively, the
///                application can set this parameter to 0. In this case, the function returns the required size for the number
///                string buffer, and does not use the <i>lpNumberStr</i> parameter.
///Returns:
///    Returns the number of TCHAR values retrieved in the buffer indicated by <i>lpNumberStr</i> if successful. If the
///    <i>cchNumber</i> parameter is set to 0, the function returns the number of characters required to hold the
///    formatted number string, including a terminating null character. The function returns 0 if it does not succeed.
///    To get extended error information, the application can call GetLastError, which can return one of the following
///    error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was
///    incorrectly set to <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> <li>ERROR_OUTOFMEMORY. Not enough
///    storage was available to complete this operation.</li> </ul>
///    
@DllImport("KERNEL32")
int GetNumberFormatA(uint Locale, uint dwFlags, const(PSTR) lpValue, const(NUMBERFMTA)* lpFormat, PSTR lpNumberStr, 
                     int cchNumber);

///Formats a number string as a number string customized for a locale specified by identifier. <div
///class="alert"><b>Note</b> For interoperability reasons, the application should prefer the GetNumberFormatEx function
///to <b>GetNumberFormat</b> because Microsoft is migrating toward the use of locale names instead of locale identifiers
///for new locales. Any application that runs only on Windows Vista and later should use
///<b>GetNumberFormatEx</b>.</div><div> </div>
///Params:
///    Locale = Locale identifier that specifies the locale. You can use the MAKELCID macro to create a locale identifier or use
///             one of the following predefined values. <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li>
///             <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li> LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li>
///             LOCALE_USER_DEFAULT </li> </ul>
///    dwFlags = Flags controlling the operation of the function. The application must set this parameter to 0 if <i>lpFormat</i>
///              is not set to <b>NULL</b>. In this case, the function formats the string using user overrides to the default
///              number format for the locale. If <i>lpFormat</i> is set to <b>NULL</b>, the application can specify
///              LOCALE_NOUSEROVERRIDE to format the string using the system default number format for the specified locale. <div
///              class="alert"><b>Caution</b> Use of LOCALE_NOUSEROVERRIDE is strongly discouraged as it disables user
///              preferences.</div> <div> </div>
///    lpValue = Pointer to a null-terminated string containing the number string to format. This string can only contain the
///              following characters. All other characters are invalid. The function returns an error if the string indicated by
///              <i>lpValue</i> deviates from these rules. <ul> <li>Characters "0" through "9".</li> <li>One decimal point (dot)
///              if the number is a floating-point value.</li> <li>A minus sign in the first character position if the number is a
///              negative value.</li> </ul>
///    lpFormat = Pointer to a NUMBERFMT structure that contains number formatting information, with all members set to appropriate
///               values. If this parameter does is not set to <b>NULL</b>, the function uses the locale only for formatting
///               information not specified in the structure, for example, the locale-specific string value for the negative sign.
///    lpNumberStr = Pointer to a buffer in which this function retrieves the formatted number string.
///    cchNumber = Size, in TCHAR values, for the number string buffer indicated by <i>lpNumberStr</i>. Alternatively, the
///                application can set this parameter to 0. In this case, the function returns the required size for the number
///                string buffer, and does not use the <i>lpNumberStr</i> parameter.
///Returns:
///    Returns the number of TCHAR values retrieved in the buffer indicated by <i>lpNumberStr</i> if successful. If the
///    <i>cchNumber</i> parameter is set to 0, the function returns the number of characters required to hold the
///    formatted number string, including a terminating null character. The function returns 0 if it does not succeed.
///    To get extended error information, the application can call GetLastError, which can return one of the following
///    error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was
///    incorrectly set to <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> <li>ERROR_OUTOFMEMORY. Not enough
///    storage was available to complete this operation.</li> </ul>
///    
@DllImport("KERNEL32")
int GetNumberFormatW(uint Locale, uint dwFlags, const(PWSTR) lpValue, const(NUMBERFMTW)* lpFormat, 
                     PWSTR lpNumberStr, int cchNumber);

///Formats a number string as a currency string for a locale specified by identifier. <div class="alert"><b>Note</b> For
///interoperability reasons, the application should prefer the GetCurrencyFormatEx function to <b>GetCurrencyFormat</b>
///because Microsoft is migrating toward the use of locale names instead of locale identifiers for new locales. Any
///application that runs only on Windows Vista and later should use GetCurrencyFormatEx.</div><div> </div>
///Params:
///    Locale = Locale identifier that specifies the locale for which this function formats the currency string. You can use the
///             MAKELCID macro to create a locale identifier or use one of the following predefined values. <ul> <li>
///             LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li>
///             LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul>
///    dwFlags = Flags controlling currency format. The application must set this parameter to 0 if <i>lpFormat</i> is not set to
///              <b>NULL</b>. In this case, the function formats the string using user overrides to the default currency format
///              for the locale. If <i>lpFormat</i> is set to <b>NULL</b>, the application can specify LOCALE_NOUSEROVERRIDE to
///              format the string using the system default currency format for the specified locale. <div
///              class="alert"><b>Caution</b> Use of LOCALE_NOUSEROVERRIDE is strongly discouraged as it disables user
///              preferences.</div> <div> </div>
///    lpValue = For details, see the <i>lpValue</i> parameter of GetCurrencyFormatEx.
///    lpFormat = Pointer to a CURRENCYFMT structure that contains currency formatting information. All members of the structure
///               must contain appropriate values. The application can set this parameter to <b>NULL</b> if function is to use the
///               currency format of the specified locale. If this parameter is not set to <b>NULL</b>, the function uses the
///               specified locale only for formatting information not specified in the CURRENCYFMT structure, for example, the
///               string value for the negative sign used by the locale.
///    lpCurrencyStr = Pointer to a buffer in which this function retrieves the formatted currency string.
///    cchCurrency = Size, in characters, of the <i>lpCurrencyStr</i> buffer. The application sets this parameter to 0 if the function
///                  is to return the size of the buffer required to hold the formatted currency string. In this case, the
///                  <i>lpCurrencyStr</i> parameter is not used.
///Returns:
///    Returns the number of characters retrieved in the buffer indicated by <i>lpCurrencyStr</i> if successful. If the
///    <i>cchCurrency</i> parameter is set to 0, the function returns the size of the buffer required to hold the
///    formatted currency string, including a terminating null character. The function returns 0 if it does not succeed.
///    To get extended error information, the application can call GetLastError, which can return one of the following
///    error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was
///    incorrectly set to <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int GetCurrencyFormatA(uint Locale, uint dwFlags, const(PSTR) lpValue, const(CURRENCYFMTA)* lpFormat, 
                       PSTR lpCurrencyStr, int cchCurrency);

///Formats a number string as a currency string for a locale specified by identifier. <div class="alert"><b>Note</b> For
///interoperability reasons, the application should prefer the GetCurrencyFormatEx function to <b>GetCurrencyFormat</b>
///because Microsoft is migrating toward the use of locale names instead of locale identifiers for new locales. Any
///application that runs only on Windows Vista and later should use GetCurrencyFormatEx.</div><div> </div>
///Params:
///    Locale = Locale identifier that specifies the locale for which this function formats the currency string. You can use the
///             MAKELCID macro to create a locale identifier or use one of the following predefined values. <ul> <li>
///             LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li>
///             LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul>
///    dwFlags = Flags controlling currency format. The application must set this parameter to 0 if <i>lpFormat</i> is not set to
///              <b>NULL</b>. In this case, the function formats the string using user overrides to the default currency format
///              for the locale. If <i>lpFormat</i> is set to <b>NULL</b>, the application can specify LOCALE_NOUSEROVERRIDE to
///              format the string using the system default currency format for the specified locale. <div
///              class="alert"><b>Caution</b> Use of LOCALE_NOUSEROVERRIDE is strongly discouraged as it disables user
///              preferences.</div> <div> </div>
///    lpValue = For details, see the <i>lpValue</i> parameter of GetCurrencyFormatEx.
///    lpFormat = Pointer to a CURRENCYFMT structure that contains currency formatting information. All members of the structure
///               must contain appropriate values. The application can set this parameter to <b>NULL</b> if function is to use the
///               currency format of the specified locale. If this parameter is not set to <b>NULL</b>, the function uses the
///               specified locale only for formatting information not specified in the CURRENCYFMT structure, for example, the
///               string value for the negative sign used by the locale.
///    lpCurrencyStr = Pointer to a buffer in which this function retrieves the formatted currency string.
///    cchCurrency = Size, in characters, of the <i>lpCurrencyStr</i> buffer. The application sets this parameter to 0 if the function
///                  is to return the size of the buffer required to hold the formatted currency string. In this case, the
///                  <i>lpCurrencyStr</i> parameter is not used.
///Returns:
///    Returns the number of characters retrieved in the buffer indicated by <i>lpCurrencyStr</i> if successful. If the
///    <i>cchCurrency</i> parameter is set to 0, the function returns the size of the buffer required to hold the
///    formatted currency string, including a terminating null character. The function returns 0 if it does not succeed.
///    To get extended error information, the application can call GetLastError, which can return one of the following
///    error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was
///    incorrectly set to <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int GetCurrencyFormatW(uint Locale, uint dwFlags, const(PWSTR) lpValue, const(CURRENCYFMTW)* lpFormat, 
                       PWSTR lpCurrencyStr, int cchCurrency);

///Enumerates calendar information for a specified locale. <div class="alert"><b>Note</b> To receive a calendar
///identifier in addition to calendar information, the application should use the EnumCalendarInfoEx function. Another
///reason for preferring this function is that Microsoft is migrating toward the use of locale names instead of locale
///identifiers for new locales, for interoperability reasons.</div><div> </div><div class="alert"><b>Note</b> Any
///application that will be run only on Windows Vista and later should use EnumCalendarInfoExEx in preference to
///<b>EnumCalendarInfo</b>.</div><div> </div>
///Params:
///    lpCalInfoEnumProc = Pointer to an application-defined callback function. For more information, see EnumCalendarInfoProc.
///    Locale = Locale identifier that specifies the locale for which to retrieve calendar information. You can use the MAKELCID
///             macro to create a locale identifier or use one of the following predefined values. <ul> <li>
///             LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li>
///             LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul>
///    Calendar = Calendar identifier that specifies the calendar for which information is requested. Note that this identifier can
///               be ENUM_ALL_CALENDARS, to enumerate all calendars that are associated with the locale.
///    CalType = Type of calendar information. For more information, see Calendar Type Information. Only one calendar type can be
///              specified per call to this function, except where noted.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_FLAGS. The values
///    supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumCalendarInfoA(CALINFO_ENUMPROCA lpCalInfoEnumProc, uint Locale, uint Calendar, uint CalType);

///Enumerates calendar information for a specified locale. <div class="alert"><b>Note</b> To receive a calendar
///identifier in addition to calendar information, the application should use the EnumCalendarInfoEx function. Another
///reason for preferring this function is that Microsoft is migrating toward the use of locale names instead of locale
///identifiers for new locales, for interoperability reasons.</div><div> </div><div class="alert"><b>Note</b> Any
///application that will be run only on Windows Vista and later should use EnumCalendarInfoExEx in preference to
///<b>EnumCalendarInfo</b>.</div><div> </div>
///Params:
///    lpCalInfoEnumProc = Pointer to an application-defined callback function. For more information, see EnumCalendarInfoProc.
///    Locale = Locale identifier that specifies the locale for which to retrieve calendar information. You can use the MAKELCID
///             macro to create a locale identifier or use one of the following predefined values. <ul> <li>
///             LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li>
///             LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul>
///    Calendar = Calendar identifier that specifies the calendar for which information is requested. Note that this identifier can
///               be ENUM_ALL_CALENDARS, to enumerate all calendars that are associated with the locale.
///    CalType = Type of calendar information. For more information, see Calendar Type Information. Only one calendar type can be
///              specified per call to this function, except where noted.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_FLAGS. The values
///    supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumCalendarInfoW(CALINFO_ENUMPROCW lpCalInfoEnumProc, uint Locale, uint Calendar, uint CalType);

///Enumerates calendar information for a locale specified by identifier. <div class="alert"><b>Note</b> Any application
///that runs only on Windows Vista and later should use EnumCalendarInfoExEx in preference to this function.</div><div>
///</div>
///Params:
///    lpCalInfoEnumProcEx = Pointer to an application-defined callback function. For more information, see EnumCalendarInfoProcEx.
///    Locale = Locale identifier that specifies the locale for which to retrieve calendar information. You can use the MAKELCID
///             macro to create an identifier or use one of the following predefined values. <ul> <li> LOCALE_INVARIANT </li>
///             <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul> <b>Windows Vista and later:</b> The
///             following custom locale identifiers are also supported. <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li>
///             LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> </ul>
///    Calendar = Calendar identifier that specifies the calendar for which information is requested. Note that this identifier can
///               be ENUM_ALL_CALENDARS, to enumerate all calendars that are associated with the locale.
///    CalType = Type of calendar information. For more information, see Calendar Type Information. Only one calendar type can be
///              specified per call to this function, except where noted.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_FLAGS. The values
///    supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumCalendarInfoExA(CALINFO_ENUMPROCEXA lpCalInfoEnumProcEx, uint Locale, uint Calendar, uint CalType);

///Enumerates calendar information for a locale specified by identifier. <div class="alert"><b>Note</b> Any application
///that runs only on Windows Vista and later should use EnumCalendarInfoExEx in preference to this function.</div><div>
///</div>
///Params:
///    lpCalInfoEnumProcEx = Pointer to an application-defined callback function. For more information, see EnumCalendarInfoProcEx.
///    Locale = Locale identifier that specifies the locale for which to retrieve calendar information. You can use the MAKELCID
///             macro to create an identifier or use one of the following predefined values. <ul> <li> LOCALE_INVARIANT </li>
///             <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul> <b>Windows Vista and later:</b> The
///             following custom locale identifiers are also supported. <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li>
///             LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> </ul>
///    Calendar = Calendar identifier that specifies the calendar for which information is requested. Note that this identifier can
///               be ENUM_ALL_CALENDARS, to enumerate all calendars that are associated with the locale.
///    CalType = Type of calendar information. For more information, see Calendar Type Information. Only one calendar type can be
///              specified per call to this function, except where noted.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_FLAGS. The values
///    supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumCalendarInfoExW(CALINFO_ENUMPROCEXW lpCalInfoEnumProcEx, uint Locale, uint Calendar, uint CalType);

///Enumerates the time formats that are available for a locale specified by identifier. <div class="alert"><b>Note</b>
///For interoperability reasons, the application should prefer the EnumTimeFormatsEx function to <b>EnumTimeFormats</b>
///because Microsoft is migrating toward the use of locale names instead of locale identifiers for new locales. Any
///application that runs only on Windows Vista and later should use EnumTimeFormatsEx.</div><div> </div>
///Params:
///    lpTimeFmtEnumProc = Pointer to an application-defined callback function. For more information, see EnumTimeFormatsProc.
///    Locale = Locale identifier that specifies the locale for which to retrieve time format information. You can use the
///             MAKELCID macro to create a locale identifier or use one of the following predefined values. <ul> <li>
///             LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li>
///             LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul>
///    dwFlags = The time format. This parameter can specify a combination of any of the following values. <table> <tr>
///              <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///              width="60%"> Use the current user's long time format. </td> </tr> <tr> <td width="40%"><a
///              id="TIME_NOSECONDS"></a><a id="time_noseconds"></a><dl> <dt><b>TIME_NOSECONDS</b></dt> </dl> </td> <td
///              width="60%"> <b>Windows 7 and later</b>: Use the current user's short time format. <div class="alert"><b>Note</b>
///              This value will not work with the ANSI version of this function, <b>EnumTimeFormatsA</b>.</div> <div> </div>
///              </td> </tr> <tr> <td width="40%"><a id="LOCAL_USE_CP_ACP"></a><a id="local_use_cp_acp"></a><dl>
///              <dt><b>LOCAL_USE_CP_ACP</b></dt> </dl> </td> <td width="60%"> Specified with the ANSI version of this function,
///              <b>EnumTimeFormatsA</b> (not recommended), to use the system default Windows ANSI code page (ACP) instead of the
///              locale code page. </td> </tr> </table>
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_FLAGS. The values
///    supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumTimeFormatsA(TIMEFMT_ENUMPROCA lpTimeFmtEnumProc, uint Locale, uint dwFlags);

///Enumerates the time formats that are available for a locale specified by identifier. <div class="alert"><b>Note</b>
///For interoperability reasons, the application should prefer the EnumTimeFormatsEx function to <b>EnumTimeFormats</b>
///because Microsoft is migrating toward the use of locale names instead of locale identifiers for new locales. Any
///application that runs only on Windows Vista and later should use EnumTimeFormatsEx.</div><div> </div>
///Params:
///    lpTimeFmtEnumProc = Pointer to an application-defined callback function. For more information, see EnumTimeFormatsProc.
///    Locale = Locale identifier that specifies the locale for which to retrieve time format information. You can use the
///             MAKELCID macro to create a locale identifier or use one of the following predefined values. <ul> <li>
///             LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li>
///             LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul>
///    dwFlags = The time format. This parameter can specify a combination of any of the following values. <table> <tr>
///              <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
///              width="60%"> Use the current user's long time format. </td> </tr> <tr> <td width="40%"><a
///              id="TIME_NOSECONDS"></a><a id="time_noseconds"></a><dl> <dt><b>TIME_NOSECONDS</b></dt> </dl> </td> <td
///              width="60%"> <b>Windows 7 and later</b>: Use the current user's short time format. <div class="alert"><b>Note</b>
///              This value will not work with the ANSI version of this function, <b>EnumTimeFormatsA</b>.</div> <div> </div>
///              </td> </tr> <tr> <td width="40%"><a id="LOCAL_USE_CP_ACP"></a><a id="local_use_cp_acp"></a><dl>
///              <dt><b>LOCAL_USE_CP_ACP</b></dt> </dl> </td> <td width="60%"> Specified with the ANSI version of this function,
///              <b>EnumTimeFormatsA</b> (not recommended), to use the system default Windows ANSI code page (ACP) instead of the
///              locale code page. </td> </tr> </table>
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_FLAGS. The values
///    supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumTimeFormatsW(TIMEFMT_ENUMPROCW lpTimeFmtEnumProc, uint Locale, uint dwFlags);

///Enumerates the long date, short date, or year/month formats that are available for a specified locale. <div
///class="alert"><b>Note</b> To receive a calendar identifier in addition to date format information, the application
///should use the EnumDateFormatsEx function. Another reason for preferring this function is that Microsoft is migrating
///toward the use of locale names instead of locale identifiers for new locales, for interoperability
///reasons.</div><div> </div><div class="alert"><b>Note</b> Any application that will be run only on Windows Vista or
///later should use EnumDateFormatsExEx in preference to <b>EnumDateFormats</b>.</div><div> </div>
///Params:
///    lpDateFmtEnumProc = Pointer to an application-defined callback function. For more information, see EnumDateFormatsProc.
///    Locale = Locale identifier that specifies the locale for which to retrieve date format information. You can use the
///             MAKELCID macro to create an identifier or use one of the following predefined values. <ul> <li>
///             LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li>
///             LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul>
///    dwFlags = Flag specifying date formats. For detailed definitions, see the <i>dwFlags</i> parameter of EnumDateFormatsExEx.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_FLAGS. The values
///    supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumDateFormatsA(DATEFMT_ENUMPROCA lpDateFmtEnumProc, uint Locale, uint dwFlags);

///Enumerates the long date, short date, or year/month formats that are available for a specified locale. <div
///class="alert"><b>Note</b> To receive a calendar identifier in addition to date format information, the application
///should use the EnumDateFormatsEx function. Another reason for preferring this function is that Microsoft is migrating
///toward the use of locale names instead of locale identifiers for new locales, for interoperability
///reasons.</div><div> </div><div class="alert"><b>Note</b> Any application that will be run only on Windows Vista or
///later should use EnumDateFormatsExEx in preference to <b>EnumDateFormats</b>.</div><div> </div>
///Params:
///    lpDateFmtEnumProc = Pointer to an application-defined callback function. For more information, see EnumDateFormatsProc.
///    Locale = Locale identifier that specifies the locale for which to retrieve date format information. You can use the
///             MAKELCID macro to create an identifier or use one of the following predefined values. <ul> <li>
///             LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li>
///             LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul>
///    dwFlags = Flag specifying date formats. For detailed definitions, see the <i>dwFlags</i> parameter of EnumDateFormatsExEx.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_FLAGS. The values
///    supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumDateFormatsW(DATEFMT_ENUMPROCW lpDateFmtEnumProc, uint Locale, uint dwFlags);

///Enumerates the long date, short date, or year/month formats that are available for a specified locale. <div
///class="alert"><b>Note</b> Any application that runs only on Windows Vista and later should use EnumDateFormatsExEx in
///preference to this function.</div><div> </div>
///Params:
///    lpDateFmtEnumProcEx = Pointer to an application-defined callback function. For more information, see EnumDateFormatsProcEx.
///    Locale = Locale identifier that specifies the locale for which to retrieve date format information. You can use the
///             MAKELCID macro to create an identifier or use one of the following predefined values. <ul> <li> LOCALE_INVARIANT
///             </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul> <b>Windows Vista and later:</b> The
///             following custom locale identifiers are also supported. <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li>
///             LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> </ul>
///    dwFlags = Flag specifying date formats. For detailed definitions, see the <i>dwFlags</i> parameter of EnumDateFormatsExEx.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_FLAGS. The values
///    supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumDateFormatsExA(DATEFMT_ENUMPROCEXA lpDateFmtEnumProcEx, uint Locale, uint dwFlags);

///Enumerates the long date, short date, or year/month formats that are available for a specified locale. <div
///class="alert"><b>Note</b> Any application that runs only on Windows Vista and later should use EnumDateFormatsExEx in
///preference to this function.</div><div> </div>
///Params:
///    lpDateFmtEnumProcEx = Pointer to an application-defined callback function. For more information, see EnumDateFormatsProcEx.
///    Locale = Locale identifier that specifies the locale for which to retrieve date format information. You can use the
///             MAKELCID macro to create an identifier or use one of the following predefined values. <ul> <li> LOCALE_INVARIANT
///             </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li> </ul> <b>Windows Vista and later:</b> The
///             following custom locale identifiers are also supported. <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li>
///             LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> </ul>
///    dwFlags = Flag specifying date formats. For detailed definitions, see the <i>dwFlags</i> parameter of EnumDateFormatsExEx.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_FLAGS. The values
///    supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumDateFormatsExW(DATEFMT_ENUMPROCEXW lpDateFmtEnumProcEx, uint Locale, uint dwFlags);

///Determines if a language group is installed or supported on the operating system. For more information, see NLS
///Terminology.
///Params:
///    LanguageGroup = Identifier of language group to validate. This parameter can have one of the following values: <ul>
///                    <li>LGRPID_ARABIC</li> <li>LGRPID_ARMENIAN </li> <li>LGRPID_BALTIC</li> <li>LGRPID_CENTRAL_EUROPE</li>
///                    <li>LGRPID_CYRILLIC</li> <li>LGRPID_GEORGIAN </li> <li>LGRPID_GREEK</li> <li>LGRPID_HEBREW</li>
///                    <li>LGRPID_INDIC</li> <li>LGRPID_JAPANESE</li> <li>LGRPID_KOREAN </li> <li>LGRPID_SIMPLIFIED_CHINESE</li>
///                    <li>LGRPID_TRADITIONAL_CHINESE</li> <li>LGRPID_THAI</li> <li>LGRPID_TURKIC</li> <li>LGRPID_TURKISH </li>
///                    <li>LGRPID_VIETNAMESE</li> <li>LGRPID_WESTERN_EUROPE</li> </ul>
///    dwFlags = Flag specifying the validity test to apply to the language group identifier. This parameter can be set to one of
///              the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="LGRPID_INSTALLED"></a><a id="lgrpid_installed"></a><dl> <dt><b>LGRPID_INSTALLED</b></dt> </dl> </td> <td
///              width="60%"> Determine if language group identifier is both supported and installed. </td> </tr> <tr> <td
///              width="40%"><a id="LGRPID_SUPPORTED"></a><a id="lgrpid_supported"></a><dl> <dt><b>LGRPID_SUPPORTED</b></dt> </dl>
///              </td> <td width="60%"> Determine if language group identifier is supported. </td> </tr> </table>
///Returns:
///    Returns <b>TRUE</b> if the language group identifier passes the specified validity test, or <b>FALSE</b>
///    otherwise.
///    
@DllImport("KERNEL32")
BOOL IsValidLanguageGroup(uint LanguageGroup, uint dwFlags);

///Retrieves information about the current version of a specified NLS capability for a locale specified by
///identifier.<div class="alert"><b>Note</b> For interoperability reasons, the application should prefer the
///GetNLSVersionEx function to <b>GetNLSVersion</b> because Microsoft is migrating toward the use of locale names
///instead of locale identifiers for new locales. This recommendation applies especially to custom locales, for which
///<b>GetNLSVersionEx</b> retrieves enough information to determine if sort behavior has changed. Any application that
///runs only on Windows Vista and later should use GetNLSVersionEx or at least pass the NLSVERSIONINFOEX structure when
///calling <b>GetNLSVersion</b> to obtain additional sorting versioning data.</div> <div> </div>
///Params:
///    Function = The NLS capability to query. This value must be COMPARE_STRING. See the SYSNLS_FUNCTION enumeration.
///    Locale = Locale identifier that specifies the locale. You can use the MAKELCID macro to create an identifier or use one of
///             the following predefined values. <ul> <li> LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li>
///             LOCALE_USER_DEFAULT </li> </ul> <b>Windows Vista and later:</b> The following custom locale identifiers are also
///             supported. <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li>
///             LOCALE_CUSTOM_UNSPECIFIED </li> </ul>
///    lpVersionInformation = Pointer to an NLSVERSIONINFO structure. The application must initialize the <b>dwNLSVersionInfoSize</b> member to
///                           <code>sizeof(NLSVERSIONINFO)</code>. <div class="alert"><b>Note</b> On Windows Vista and later, the function can
///                           alternatively provide version information in an NLSVERSIONINFOEX structure.</div> <div> </div>
///Returns:
///    Returns <b>TRUE</b> if and only if the application has supplied valid values in <i>lpVersionInformation</i>, or
///    <b>FALSE</b> otherwise. To get extended error information, the application can call GetLastError, which can
///    return one of the following error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large
///    enough, or it was incorrectly set to <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The values supplied for flags
///    were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL GetNLSVersion(uint Function, uint Locale, NLSVERSIONINFO* lpVersionInformation);

///<p class="CCE_Message">[<b>IsValidLocale</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use IsValidLocaleName to
///determine the validity of a supplemental locale.] Determines if the specified locale is installed or supported on the
///operating system. For more information, see Locales and Languages.
///Params:
///    Locale = Locale identifier of the locale to validate. You can use the MAKELCID macro to create a locale identifier or use
///             one of the following predefined values. <ul> <li> LOCALE_CUSTOM_DEFAULT <b>Windows Server 2003, Windows XP and
///             Windows 2000: </b>This locale identifier is not supported. </li> <li> LOCALE_CUSTOM_UI_DEFAULT <b>Windows Server
///             2003, Windows XP and Windows 2000: </b>This locale identifier is not supported. </li> <li>
///             LOCALE_CUSTOM_UNSPECIFIED <b>Windows Server 2003, Windows XP and Windows 2000: </b>This locale identifier is not
///             supported. </li> <li> LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li>
///             </ul>
///    dwFlags = Flag specifying the validity test to apply to the locale identifier. This parameter can have one of the following
///              values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="LCID_INSTALLED"></a><a
///              id="lcid_installed"></a><dl> <dt><b>LCID_INSTALLED</b></dt> </dl> </td> <td width="60%"> Determine if the locale
///              identifier is both supported and installed. </td> </tr> <tr> <td width="40%"><a id="LCID_SUPPORTED"></a><a
///              id="lcid_supported"></a><dl> <dt><b>LCID_SUPPORTED</b></dt> </dl> </td> <td width="60%"> Determine if the locale
///              identifier is supported. </td> </tr> <tr> <td width="40%"> <dl> <dt>0x39</dt> </dl> </td> <td width="60%"> Do not
///              use. Instead, use LCID_INSTALLED. <b>Windows Server 2008, Windows Vista, Windows Server 2003, Windows XP and
///              Windows 2000: </b>Setting <i>dwFlags</i> to 0x39 is a special case that can behave like LCID_INSTALLED for some
///              locales on some versions of Windows. </td> </tr> </table>
///Returns:
///    Returns a nonzero value if the locale identifier passes the specified validity test. The function returns 0 if it
///    does not succeed.
///    
@DllImport("KERNEL32")
BOOL IsValidLocale(uint Locale, uint dwFlags);

///<p class="CCE_Message">[<b>GetGeoInfo</b> is available for use in the operating systems specified in the Requirements
///section. It may be altered or unavailable in subsequent versions. Instead, use GetGeoInfoEx. ] Retrieves information
///about a specified geographical location.
///Params:
///    Location = Identifier for the geographical location for which to get information. For more information, see Table of
///               Geographical Locations. You can obtain the available values by calling EnumSystemGeoID.
///    GeoType = Type of information to retrieve. Possible values are defined by the SYSGEOTYPE enumeration. If the value of
///              <i>GeoType</i> is GEO_LCID, the function retrieves a locale identifier. If the value of <i>GeoType</i> is
///              GEO_RFC1766, the function retrieves a string name that is compliant with RFC 4646 (Windows Vista). For more
///              information, see the Remarks section. <b>Windows XP:</b> When <i>GeoType</i> is set to GEO_LCID, the retrieved
///              string is an 8-digit hexadecimal value. <b>Windows Me:</b> When <i>GeoType</i> is set to GEO_LCID, the retrieved
///              string is a decimal value.
///    lpGeoData = Pointer to the buffer in which this function retrieves the information.
///    cchData = Size of the buffer indicated by <i>lpGeoData</i>. The size is the number of bytes for the ANSI version of the
///              function, or the number of words for the Unicode version. The application can set this parameter to 0 if the
///              function is to return the required size of the buffer.
///    LangId = Identifier for the language, used with the value of <i>Location</i>. The application can set this parameter to 0,
///             with GEO_RFC1766 or GEO_LCID specified for <i>GeoType</i>. This setting causes the function to retrieve the
///             language identifier by calling GetUserDefaultLangID. <div class="alert"><b>Note</b> The application must set this
///             parameter to 0 if <i>GeoType</i> has any value other than GEO_RFC1766 or GEO_LCID.</div> <div> </div>
///Returns:
///    Returns the number of bytes (ANSI) or words (Unicode) of geographical location information retrieved in the
///    output buffer. If <i>cchData</i> is set to 0, the function returns the required size for the buffer. The function
///    returns 0 if it does not succeed. To get extended error information, the application can call GetLastError, which
///    can return one of the following error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not
///    large enough, or it was incorrectly set to <b>NULL</b>. </li> <li>ERROR_INVALID_PARAMETER. Any of the parameter
///    values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int GetGeoInfoA(int Location, uint GeoType, PSTR lpGeoData, int cchData, ushort LangId);

///<p class="CCE_Message">[<b>GetGeoInfo</b> is available for use in the operating systems specified in the Requirements
///section. It may be altered or unavailable in subsequent versions. Instead, use GetGeoInfoEx. ] Retrieves information
///about a specified geographical location.
///Params:
///    Location = Identifier for the geographical location for which to get information. For more information, see Table of
///               Geographical Locations. You can obtain the available values by calling EnumSystemGeoID.
///    GeoType = Type of information to retrieve. Possible values are defined by the SYSGEOTYPE enumeration. If the value of
///              <i>GeoType</i> is GEO_LCID, the function retrieves a locale identifier. If the value of <i>GeoType</i> is
///              GEO_RFC1766, the function retrieves a string name that is compliant with RFC 4646 (Windows Vista). For more
///              information, see the Remarks section. <b>Windows XP:</b> When <i>GeoType</i> is set to GEO_LCID, the retrieved
///              string is an 8-digit hexadecimal value. <b>Windows Me:</b> When <i>GeoType</i> is set to GEO_LCID, the retrieved
///              string is a decimal value.
///    lpGeoData = Pointer to the buffer in which this function retrieves the information.
///    cchData = Size of the buffer indicated by <i>lpGeoData</i>. The size is the number of bytes for the ANSI version of the
///              function, or the number of words for the Unicode version. The application can set this parameter to 0 if the
///              function is to return the required size of the buffer.
///    LangId = Identifier for the language, used with the value of <i>Location</i>. The application can set this parameter to 0,
///             with GEO_RFC1766 or GEO_LCID specified for <i>GeoType</i>. This setting causes the function to retrieve the
///             language identifier by calling GetUserDefaultLangID. <div class="alert"><b>Note</b> The application must set this
///             parameter to 0 if <i>GeoType</i> has any value other than GEO_RFC1766 or GEO_LCID.</div> <div> </div>
///Returns:
///    Returns the number of bytes (ANSI) or words (Unicode) of geographical location information retrieved in the
///    output buffer. If <i>cchData</i> is set to 0, the function returns the required size for the buffer. The function
///    returns 0 if it does not succeed. To get extended error information, the application can call GetLastError, which
///    can return one of the following error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not
///    large enough, or it was incorrectly set to <b>NULL</b>. </li> <li>ERROR_INVALID_PARAMETER. Any of the parameter
///    values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int GetGeoInfoW(int Location, uint GeoType, PWSTR lpGeoData, int cchData, ushort LangId);

///Retrieves information about a geographic location that you specify by using a two-letter International Organization
///for Standardization (ISO) 3166-1 code or numeric United Nations (UN) Series M, Number 49 (M.49) code.
///Params:
///    location = The two-letter ISO 3166-1 or numeric UN M.49 code for the geographic location for which to get information. To
///               get the codes that are available on the operating system, call EnumSystemGeoNames.
///    geoType = The type of information you want to retrieve. Possible values are defined by the SYSGEOTYPE enumeration. The
///              following values of the <b>SYSGEOTYPE</b> enumeration should not be used with <b>GetGeoInfoEx</b>: <ul> <li>
///              <b>GEO_ID</b> This value is provided for backward compatibility. Do not use this value in new applications, but
///              use <b>GEO_NAME</b> instead. </li> <li> <b>GEO_LCID</b> This value is not supported for the <b>GetGeoInfoEx</b>
///              function. </li> <li> <b>GEO_NATION</b> This value is not supported for the <b>GetGeoInfoEx</b> function. </li>
///              <li> <b>GEO_RFC1766</b> This value is not supported for the <b>GetGeoInfoEx</b> function. </li> </ul>
///    geoData = A pointer to the buffer in which <b>GetGeoInfoEx</b> should write the requested information.
///    geoDataCount = The size of the buffer to which the <i>GeoData</i> parameter points, in characters. Set this parameter to 0 to
///                   specify that the function should only return the size of the buffer required to store the requested information
///                   without writing the requested information to the buffer.
///Returns:
///    The number of bytes of geographical location information that the function wrote the output buffer. If
///    <i>geoDataCount</i> is 0, the function returns the size of the buffer required to hold the information without
///    writing the information to the buffer. 0 indicates that the function did not succeed. To get extended error
///    information, call GetLastError, which can return one of the following error codes: <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl>
///    </td> <td width="60%"> The supplied buffer size was not large enough, or it was incorrectly set to <b>NULL</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A
///    parameter value was not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl>
///    </td> <td width="60%"> The values supplied for flags were not valid. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int GetGeoInfoEx(PWSTR location, uint geoType, PWSTR geoData, int geoDataCount);

///<p class="CCE_Message">[<b>EnumSystemGeoID</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use EnumSystemGeoNames. ]
///Enumerates the geographical location identifiers (type GEOID) that are available on the operating system.
///Params:
///    GeoClass = Geographical location class for which to enumerate the identifiers. At present, only GEOCLASS_NATION is
///               supported. This type causes the function to enumerate all geographical identifiers for nations on the operating
///               system.
///    ParentGeoId = Reserved. This parameter must be 0.
///    lpGeoEnumProc = Pointer to the application-defined callback function EnumGeoInfoProc. The <b>EnumSystemGeoID</b> function makes
///                    repeated calls to this callback function until it returns <b>FALSE</b>.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_FLAGS. The values
///    supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumSystemGeoID(uint GeoClass, int ParentGeoId, GEO_ENUMPROC lpGeoEnumProc);

///Enumerates the two-letter International Organization for Standardization (ISO) 3166-1 codes or numeric United Nations
///(UN) Series M, Number 49 (M.49) codes for geographical locations that are available on the operating system.
///Params:
///    geoClass = The geographical location class for which to enumerate the available two-letter ISO 3166-1 or numeric UN M.49
///               codes.
///    geoEnumProc = Pointer to the application-defined callback function Geo_EnumNameProc. The <b>EnumSystemGeoNames</b> function
///                  calls this callback function for each of the two-letter ISO 3166-1 or numeric UN M.49 codes for geographical
///                  locations that are available on the operating system until callback function returns <b>FALSE</b>.
///    data = Application-specific information to pass to the callback function that the <i>genEnumProc</i> parameter
///           specifies.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, call GetLastError,
///    which can return one of the following error codes: <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_FLAGS</b></dt> </dl> </td> <td width="60%"> The values supplied
///    for flags were not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> A parameter value was not valid. </td> </tr> </table>
///    
@DllImport("KERNEL32")
BOOL EnumSystemGeoNames(uint geoClass, GEO_ENUMNAMEPROC geoEnumProc, LPARAM data);

///<p class="CCE_Message">[<b>GetUserGeoID</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use GetUserDefaultGeoName. ]
///Retrieves information about the geographical location of the user. For more information, see Table of Geographical
///Locations.
///Params:
///    GeoClass = Geographical location class to return. Possible values are defined by the SYSGEOCLASS enumeration.
///Returns:
///    Returns the geographical location identifier of the user if SetUserGeoID has been called before to set the
///    identifier. If no geographical location identifier has been set for the user, the function returns
///    GEOID_NOT_AVAILABLE.
///    
@DllImport("KERNEL32")
int GetUserGeoID(uint GeoClass);

///Retrieves the two-letter International Organization for Standardization (ISO) 3166-1 code or numeric United Nations
///(UN) Series M, Number 49 (M.49) code for the default geographical location of the user.
///Params:
///    geoName = Pointer to a buffer in which this function should write the null-terminated two-letter ISO 3166-1 or numeric UN
///              M.49 code for the default geographic location of the user.
///    geoNameCount = The size of the buffer that the <i>geoName</i> parameter specifies. If this value is zero, the function only
///                   returns the number of characters that function would copy to the output buffer, but does not write the name of
///                   the default geographic location of the user to the buffer.
///Returns:
///    The number of characters the function would copy to the output buffer, if the value of the <i>geoNameCount</i>
///    parameter is zero. Otherwise, the number of characters that the function copied to the buffer that the
///    <i>geoName</i> parameter specifies. Zero indicates that the function failed. To get extended error information,
///    call GetLastError, which can return one of the following error codes: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> A parameter value was not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BADDB</b></dt>
///    </dl> </td> <td width="60%"> The function could not read information from the registry. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer that the
///    <i>geoName</i> parameter specifies is too small for the string. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int GetUserDefaultGeoName(PWSTR geoName, int geoNameCount);

///<p class="CCE_Message">[<b>SetUserGeoID</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use SetUserGeoName. ] Sets
///the geographical location identifier for the user. This identifier should have one of the values described in Table
///of Geographical Locations.
///Params:
///    GeoId = Identifier for the geographical location of the user.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise. <b>Windows XP, Windows Server 2003</b>: This
///    function does not supply extended error information. Thus it is not appropriate for an application to call
///    GetLastError after this function. If the application does call GetLastError, it can return a value set by some
///    previously called function. If this function does not succeed, the application can call GetLastError, which can
///    return one of the following error codes: <ul> <li>ERROR_ACCESS_DISABLED_BY_POLICY. The group policy of the
///    computer or the user has forbidden this operation.</li> <li>ERROR_INTERNAL_ERROR. An unexpected error occurred in
///    the function.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL SetUserGeoID(int GeoId);

///Sets the geographic location for the current user to the specified two-letter International Organization for
///Standardization (ISO) 3166-1 code or numeric United Nations (UN) Series M, Number 49 (M.49) code.
///Params:
///    geoName = The two-letter ISO 3166-1 or numeric UN M.49 code for the geographic location to set for the current user. To get
///              the codes that are available on the operating system, call EnumSystemGeoNames.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise. If this function does not succeed, call
///    GetLastError, which can return one of the following error codes: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DISABLED_BY_POLICY</b></dt> </dl> </td>
///    <td width="60%"> The group policy of the computer or the user has forbidden this operation. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INTERNAL_ERROR</b></dt> </dl> </td> <td width="60%"> An unexpected error occurred
///    in the function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> A parameter value was invalid. </td> </tr> </table>
///    
@DllImport("KERNEL32")
BOOL SetUserGeoName(PWSTR geoName);

///Converts a default locale value to an actual locale identifier. <div class="alert"><b>Note</b> This function is only
///provided for converting partial locale identifiers. Your applications should use locale names instead of identifiers.
///The LCIDToLocaleName function can be used to convert a locale identifier to a valid locale name. Your application can
///also use GetUserDefaultLocaleName to retrieve the current user locale name; GetSystemDefaultLocaleName to retrieve
///the current system locale name; and GetLocaleInfoEx with LOCALE_SNAME to retrieve the locale name for any input
///locale, including the default constants.</div><div> </div>
///Params:
///    Locale = Default locale identifier value to convert. You can use the MAKELCID macro to create a locale identifier or use
///             one of the following predefined values. <ul> <li> LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li>
///             LOCALE_USER_DEFAULT </li> </ul> <b>Windows Vista and later:</b> The following custom locale identifiers are also
///             supported. <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li>
///             LOCALE_CUSTOM_UNSPECIFIED </li> </ul>
///Returns:
///    Returns the appropriate locale identifier if successful. This function returns the value of the <i>Locale</i>
///    parameter if it does not succeed. The function fails when the <i>Locale</i> value is not one of the default
///    values listed above.
///    
@DllImport("KERNEL32")
uint ConvertDefaultLocale(uint Locale);

///Retrieves the [language identifier](/windows/desktop/Intl/language-identifiers) for the system default UI language of
///the operating system (also known as the "install language" on Windows Vista and later). For more information, see
///[User Interface Language Management](/windows/desktop/Intl/user-interface-language-management). > [!Important] > Use
///of this function is not recommended. Instead, we recommend using the [User language
///settings](/windows/win32/intl/setting-application-language-preferences) for the following reasons. > > - "Install
///language" is only set during the Out of Box Experience (OOBE) and then never changes. If the system language is
///changed, this function returns an incorrect value. > - WCOS SKUs always return an incorrect value. > - This function
///uses deprecated LANGIDs.
///Returns:
///    Returns the language identifier for the system default UI language of the operating system. For more information,
///    see the Remarks section.
///    
@DllImport("KERNEL32")
ushort GetSystemDefaultUILanguage();

///Returns the locale identifier of the current locale for the calling thread.<div class="alert"><b>Note</b> This
///function can retrieve data that changes between releases, for example, due to a custom locale. If your application
///must persist or transmit data, see Using Persistent Locale Data.</div> <div> </div>
///Returns:
///    Returns the locale identifier of the locale associated with the current thread. <b>Windows Vista</b>: This
///    function can return the identifier of a custom locale. If the current thread locale is a custom locale, the
///    function returns LOCALE_CUSTOM_DEFAULT. If the current thread locale is a supplemental custom locale, the
///    function can return LOCALE_CUSTOM_UNSPECIFIED. All supplemental locales share this locale identifier.
///    
@DllImport("KERNEL32")
uint GetThreadLocale();

///Sets the current locale of the calling thread.
///Params:
///    Locale = Locale identifier that specifies the locale. You can use the MAKELCID macro to create a locale identifier or use
///             one of the following predefined values. <ul> <li> LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li>
///             <li> LOCALE_CUSTOM_UNSPECIFIED </li> <li> LOCALE_INVARIANT </li> <li> LOCALE_SYSTEM_DEFAULT </li> <li>
///             LOCALE_USER_DEFAULT </li> </ul>
///Returns:
///    The function should return an LCID on success. This is the LCID of the previous thread locale.
///    
@DllImport("KERNEL32")
BOOL SetThreadLocale(uint Locale);

///Returns the language identifier for the user UI language for the current user. If the current user has not set a
///language, <b>GetUserDefaultUILanguage</b> returns the preferred language set for the system. If there is no preferred
///language set for the system, then the system default UI language (also known as "install language") is returned. For
///more information about the user UI language, see User Interface Language Management.
///Returns:
///    Returns the language identifier for the user UI language for the current user.
///    
@DllImport("KERNEL32")
ushort GetUserDefaultUILanguage();

///Returns the language identifier of the Region Format setting for the current user.
///Returns:
///    Returns the language identifier for the current user as set under <b>Control Panel</b> &gt; <b>Clock, Language,
///    and Region</b> &gt; <b>Change date, time, or number formats</b> &gt; <b>Formats</b> tab &gt; <b>Format</b>
///    dropdown. For more information on language identifiers, see Language Identifier Constants and Strings.
///    
@DllImport("KERNEL32")
ushort GetUserDefaultLangID();

///Returns the language identifier for the system locale.
///Returns:
///    Returns the language identifier for the system locale. This is the language used when displaying text in programs
///    that do not support Unicode. It is set by the Administrator under <b>Control Panel</b> &gt; <b>Clock, Language,
///    and Region</b> &gt; <b>Change date, time, or number formats</b> &gt; <b>Administrative</b> tab. For more
///    information on language identifiers, see Language Identifier Constants and Strings.
///    
@DllImport("KERNEL32")
ushort GetSystemDefaultLangID();

///Returns the locale identifier for the system locale.<div class="alert"><b>Note</b> Any application that runs only on
///Windows Vista and later should use GetSystemDefaultLocaleName in preference to this function.</div> <div> </div>
///Returns:
///    Returns the locale identifier for the system default locale, identified by LOCALE_SYSTEM_DEFAULT.
///    
@DllImport("KERNEL32")
uint GetSystemDefaultLCID();

///Returns the locale identifier for the user default locale. <div class="alert"><b>Caution</b> If the user default
///locale is a custom locale, an application cannot accurately tag data with the value or exchange it. In this case, the
///application should use GetUserDefaultLocaleName in preference to <b>GetUserDefaultLCID</b>.</div><div> </div><div
///class="alert"><b>Note</b> Applications that are intended to run only on Windows Vista and later should use
///GetUserDefaultLocaleName.</div><div> </div>
///Returns:
///    Returns the locale identifier for the user default locale, represented as LOCALE_USER_DEFAULT. If the user
///    default locale is a custom locale, this function always returns LOCALE_CUSTOM_DEFAULT, regardless of the custom
///    locale that is selected. For example, whether the user locale is Hawaiian (US), haw-US, or Fijiian (Fiji), fj-FJ,
///    the function returns the same value.
///    
@DllImport("KERNEL32")
uint GetUserDefaultLCID();

///Sets the user interface language for the current thread. <b>Windows Vista and later:</b> This function cannot clear
///the thread preferred UI languages list. Your MUI application should call SetThreadPreferredUILanguages to clear the
///language list. <b>Windows XP:</b> This function is limited to allowing the operating system to identify and set a
///value that is safe to use on the Windows console.
///Params:
///    LangId = Language identifier for the user interface language for the thread. <b>Windows Vista and later:</b> The
///             application can specify a language identifier of 0 or a nonzero identifier. For more information, see the Remarks
///             section. <b>Windows XP:</b> The application can only set this parameter to 0. This setting causes the function to
///             select the language that best supports the console display. For more information, see the Remarks section.
///Returns:
///    Returns the input language identifier if successful. If the input identifier is nonzero, the function returns
///    that value. If the language identifier is 0, the function always succeeds and returns the identifier of the
///    language that best supports the Windows console. See the Remarks section. If the input language identifier is
///    nonzero and the function fails, the return value differs from the input language identifier. To get extended
///    error information, the application can call GetLastError.
///    
@DllImport("KERNEL32")
ushort SetThreadUILanguage(ushort LangId);

///Returns the language identifier of the first user interface language for the current thread.
///Returns:
///    Returns the identifier for a language explicitly associated with the thread by SetThreadUILanguage or
///    SetThreadPreferredUILanguages. Alternatively, if no language has been explicitly associated with the current
///    thread, the identifier can indicate a user or system user interface language.
///    
@DllImport("KERNEL32")
ushort GetThreadUILanguage();

///Retrieves the process preferred UI languages. For more information, see User Interface Language Management.
///Params:
///    dwFlags = Flags identifying the language format to use for the process preferred UI languages. The flags are mutually
///              exclusive, and the default is MUI_LANGUAGE_NAME. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="MUI_LANGUAGE_ID"></a><a id="mui_language_id"></a><dl> <dt><b>MUI_LANGUAGE_ID</b></dt> </dl>
///              </td> <td width="60%"> Retrieve the language strings in language identifier format. </td> </tr> <tr> <td
///              width="40%"><a id="MUI_LANGUAGE_NAME"></a><a id="mui_language_name"></a><dl> <dt><b>MUI_LANGUAGE_NAME</b></dt>
///              </dl> </td> <td width="60%"> Retrieve the language strings in language name format. </td> </tr> </table>
///    pulNumLanguages = Pointer to the number of languages retrieved in <i>pwszLanguagesBuffer</i>.
///    pwszLanguagesBuffer = Optional. Pointer to a double null-terminated multi-string buffer in which the function retrieves an ordered,
///                          null-delimited list in preference order, starting with the most preferable. Alternatively if this parameter is
///                          set to <b>NULL</b> and <i>pcchLanguagesBuffer</i> is set to 0, the function retrieves the required size of the
///                          language buffer in <i>pcchLanguagesBuffer</i>. The required size includes the two null characters.
///    pcchLanguagesBuffer = Pointer to the size, in characters, for the language buffer indicated by <i>pwszLanguagesBuffer</i>. On
///                          successful return from the function, the parameter contains the size of the retrieved language buffer.
///                          Alternatively if this parameter is set to 0 and <i>pwszLanguagesBuffer</i> is set to <b>NULL</b>, the function
///                          retrieves the required size of the language buffer in <i>pcchLanguagesBuffer</i>.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise. To get extended error information, the application
///    can call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A
///    supplied buffer size was not large enough, or it was incorrectly set to <b>NULL</b>.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul> If the process preferred UI
///    language list is empty or if the languages specified for the process are not valid, the function succeeds and
///    returns an empty multistring in <i>pwszLanguagesBuffer</i> and 2 in the <i>pcchLanguagesBuffer</i> parameter.
///    
@DllImport("KERNEL32")
BOOL GetProcessPreferredUILanguages(uint dwFlags, uint* pulNumLanguages, 
                                    /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PWSTR pwszLanguagesBuffer, 
                                    uint* pcchLanguagesBuffer);

///Sets the process preferred UI languages for the application process. For more information, see User Interface
///Language Management.
///Params:
///    dwFlags = Flags identifying the language format to use for the process preferred UI languages. The flags are mutually
///              exclusive, and the default is MUI_LANGUAGE_NAME. We recommend that you use MUI_LANGUAGE_NAME instead of
///              MUI_LANGUAGE_ID. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="MUI_LANGUAGE_ID"></a><a id="mui_language_id"></a><dl> <dt><b>MUI_LANGUAGE_ID</b></dt> </dl> </td> <td
///              width="60%"> The input parameter language strings are in language identifier format. </td> </tr> <tr> <td
///              width="40%"><a id="MUI_LANGUAGE_NAME"></a><a id="mui_language_name"></a><dl> <dt><b>MUI_LANGUAGE_NAME</b></dt>
///              </dl> </td> <td width="60%"> The input parameter language strings are in language name format. </td> </tr>
///              </table>
///    pwszLanguagesBuffer = Pointer to a double null-terminated multi-string buffer that contains an ordered, null-delimited list in
///                          decreasing order of preference. If there are more than five languages in the buffer, the function only sets the
///                          first five valid languages. Alternatively, this parameter can contain <b>NULL</b> if no language list is
///                          required. In this case, the function clears the preferred UI languages for the process.
///    pulNumLanguages = Pointer to the number of languages that has been set in the process language list from the input buffer, up to a
///                      maximum of five.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise. To get extended error information, the application
///    can call GetLastError, which can return the following error code: <ul> <li>ERROR_INVALID_PARAMETER. An invalid
///    parameter is specified.</li> </ul> If the process preferred UI languages list is empty or if the languages
///    specified for the process are not valid, the function succeeds and sets 0 in the <i>pulNumLanguages</i>
///    parameter.
///    
@DllImport("KERNEL32")
BOOL SetProcessPreferredUILanguages(uint dwFlags, 
                                    /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/const(PWSTR) pwszLanguagesBuffer, 
                                    uint* pulNumLanguages);

///Retrieves information about the display language setting. For more information, see [User Interface Language
///Management](/windows/desktop/Intl/user-interface-language-management).
///Params:
///    dwFlags = Flags identifying language format and filtering. The following flags specify the language format to use for the
///              display language list. The flags are mutually exclusive, and the default is MUI_LANGUAGE_NAME. | Value | Meaning
///              | | --- | --- | | **MUI_LANGUAGE_ID** | Retrieve the language strings in [language
///              identifier](/windows/desktop/Intl/language-identifiers) | | **MUI_LANGUAGE_NAME** | Retrieve the language strings
///              in [language name](/windows/desktop/Intl/language-names) format. |
///    pulNumLanguages = Pointer to the number of languages retrieved in *pwszLanguagesBuffer*.
///    pwszLanguagesBuffer = Optional. Pointer to a buffer in which this function retrieves an ordered, null-delimited display language list,
///                          in the format specified by *dwflags*. This list ends with two null characters. Alternatively if this parameter is
///                          set to **NULL** and *pcchLanguagesBuffer* is set to 0, the function retrieves the required size of the language
///                          buffer in *pcchLanguagesBuffer*. The required size includes the two null characters.
///    pcchLanguagesBuffer = Pointer to the size, in characters, for the language buffer indicated by *pwszLanguagesBuffer*. On successful
///                          return from the function, the parameter contains the size of the retrieved language buffer. Alternatively if this
///                          parameter is set to 0 and *pwszLanguagesBuffer* is set to **NULL**, the function retrieves the required size of
///                          the language buffer in *pcchLanguagesBuffer*.
///Returns:
///    Returns **TRUE** if successful or **FALSE** otherwise. To get extended error information, the application can
///    call [GetLastError function](../errhandlingapi/nf-errhandlingapi-getlasterror.md), which can return one of the
///    following error codes: - ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was
///    incorrectly set to **NULL**. If the function fails for any other reason, the values of *pulNumLanguages* and
///    *pcchLanguagesBuffer* are undefined.
///    
@DllImport("KERNEL32")
BOOL GetUserPreferredUILanguages(uint dwFlags, uint* pulNumLanguages, 
                                 /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PWSTR pwszLanguagesBuffer, 
                                 uint* pcchLanguagesBuffer);

///Retrieves the system preferred UI languages. For more information, see User Interface Language Management.
///Params:
///    dwFlags = Flags identifying language format and filtering. The following flags specify the format to use for the system
///              preferred UI languages. The flags are mutually exclusive, and the default is MUI_LANGUAGE_NAME. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MUI_LANGUAGE_ID"></a><a
///              id="mui_language_id"></a><dl> <dt><b>MUI_LANGUAGE_ID</b></dt> </dl> </td> <td width="60%"> Retrieve the language
///              strings in language identifier format. </td> </tr> <tr> <td width="40%"><a id="MUI_LANGUAGE_NAME"></a><a
///              id="mui_language_name"></a><dl> <dt><b>MUI_LANGUAGE_NAME</b></dt> </dl> </td> <td width="60%"> Retrieve the
///              language strings in language name format. </td> </tr> </table> The following flag specifies whether the function
///              is to validate the list of languages (default) or retrieve the system preferred UI languages list exactly as it
///              is stored in the registry. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="MUI_MACHINE_LANGUAGE_SETTINGS"></a><a id="mui_machine_language_settings"></a><dl>
///              <dt><b>MUI_MACHINE_LANGUAGE_SETTINGS</b></dt> </dl> </td> <td width="60%"> Retrieve the stored system preferred
///              UI languages list, checking only to ensure that each language name corresponds to a valid NLS locale. If this
///              flag is not set, the function retrieves the system preferred UI languages in <i>pwszLanguagesBuffer</i>, as long
///              as the list is non-empty and meets the validation criteria. Otherwise, the function retrieves the system default
///              user interface language in the language buffer. </td> </tr> </table>
///    pulNumLanguages = Pointer to the number of languages retrieved in <i>pwszLanguagesBuffer</i>.
///    pwszLanguagesBuffer = Optional. Pointer to a buffer in which this function retrieves an ordered, null-delimited system preferred UI
///                          languages list, in the format specified by <i>dwFlags</i>. This list ends with two null characters. Alternatively
///                          if this parameter is set to <b>NULL</b> and <i>pcchLanguagesBuffer</i> is set to 0, the function retrieves the
///                          required size of the language buffer in <i>pcchLanguagesBuffer</i>. The required size includes the two null
///                          characters
///    pcchLanguagesBuffer = Pointer to the size, in characters, for the language buffer indicated by <i>pwszLanguagesBuffer</i>. On
///                          successful return from the function, the parameter contains the size of the retrieved language buffer.
///                          Alternatively if this parameter is set to 0 and <i>pwszLanguagesBuffer</i> is set to <b>NULL</b>, the function
///                          retrieves the required size of the language buffer in <i>pcchLanguagesBuffer</i>.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise. To get extended error information, the application
///    can call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A
///    supplied buffer size was not large enough, or it was incorrectly set to <b>NULL</b>. </li> </ul> If the function
///    fails for any other reason, the parameters <i>pulNumLanguages</i> and <i>pcchLanguagesBuffer</i> are undefined.
///    
@DllImport("KERNEL32")
BOOL GetSystemPreferredUILanguages(uint dwFlags, uint* pulNumLanguages, 
                                   /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PWSTR pwszLanguagesBuffer, 
                                   uint* pcchLanguagesBuffer);

///Retrieves the thread preferred UI languages for the current thread. For more information, see User Interface Language
///Management.
///Params:
///    dwFlags = Flags identifying language format and filtering. The following flags specify the language format to use for the
///              thread preferred UI languages. The flags are mutually exclusive, and the default is MUI_LANGUAGE_NAME. <table>
///              <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MUI_LANGUAGE_ID"></a><a
///              id="mui_language_id"></a><dl> <dt><b>MUI_LANGUAGE_ID</b></dt> </dl> </td> <td width="60%"> Retrieve the language
///              strings in language identifier format. </td> </tr> <tr> <td width="40%"><a id="MUI_LANGUAGE_NAME"></a><a
///              id="mui_language_name"></a><dl> <dt><b>MUI_LANGUAGE_NAME</b></dt> </dl> </td> <td width="60%"> Retrieve the
///              language strings in language name format. </td> </tr> </table> The following flags specify filtering for the
///              function to use in retrieving the thread preferred UI languages. The default flag is MUI_MERGE_USER_FALLBACK.
///              <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MUI_MERGE_SYSTEM_FALLBACK"></a><a
///              id="mui_merge_system_fallback"></a><dl> <dt><b>MUI_MERGE_SYSTEM_FALLBACK</b></dt> </dl> </td> <td width="60%">
///              Use the system fallback to retrieve a list that corresponds exactly to the language list used by the resource
///              loader. This flag can be used only in combination with MUI_MERGE_USER_FALLBACK. Using the flags in combination
///              alters the usual effect of MUI_MERGE_USER_FALLBACK by including fallback and neutral languages in the list. </td>
///              </tr> <tr> <td width="40%"><a id="MUI_MERGE_USER_FALLBACK"></a><a id="mui_merge_user_fallback"></a><dl>
///              <dt><b>MUI_MERGE_USER_FALLBACK</b></dt> </dl> </td> <td width="60%"> Retrieve a composite list consisting of the
///              thread preferred UI languages, followed by process preferred UI languages, followed by any user preferred UI
///              languages that are distinct from these, followed by the system default UI language, if it is not already in the
///              list. If the user preferred UI languages list is empty, the function retrieves the system preferred UI languages.
///              This flag cannot be combined with MUI_THREAD_LANGUAGES. </td> </tr> <tr> <td width="40%"><a
///              id="MUI_THREAD_LANGUAGES"></a><a id="mui_thread_languages"></a><dl> <dt><b>MUI_THREAD_LANGUAGES</b></dt> </dl>
///              </td> <td width="60%"> Retrieve only the thread preferred UI languages for the current thread, or an empty list
///              if no preferred languages are set for the current thread. This flag cannot be combined with
///              MUI_MERGE_USER_FALLBACK or MUI_MERGE_SYSTEM_FALLBACK. </td> </tr> <tr> <td width="40%"><a
///              id="MUI_UI_FALLBACK"></a><a id="mui_ui_fallback"></a><dl> <dt><b>MUI_UI_FALLBACK</b></dt> </dl> </td> <td
///              width="60%"> Retrieve a complete thread preferred UI languages list along with associated fallback and neutral
///              languages. Use of this flag is equivalent to combining MUI_MERGE_SYSTEM_FALLBACK and MUI_MERGE_USER_FALLBACK.
///              (Applicable only for Windows 7 and later). </td> </tr> </table>
///    pulNumLanguages = Pointer to the number of languages retrieved in <i>pwszLanguagesBuffer</i>.
///    pwszLanguagesBuffer = Optional. Pointer to a buffer in which this function retrieves an ordered, null-delimited thread preferred UI
///                          languages list, in the format specified by <i>dwFlags</i>. This list ends with two null characters. Alternatively
///                          if this parameter is set to <b>NULL</b> and <i>pcchLanguagesBuffer</i> is set to 0, the function retrieves the
///                          required size of the language buffer in <i>pcchLanguagesBuffer</i>. The required size includes the two null
///                          characters.
///    pcchLanguagesBuffer = Pointer to the size, in characters, for the language buffer indicated by <i>pwszLanguagesBuffer</i>. On
///                          successful return from the function, the parameter contains the size of the retrieved language buffer.
///                          Alternatively if this parameter is set to 0 and <i>pwszLanguagesBuffer</i> is set to <b>NULL</b>, the function
///                          retrieves the required size of the language buffer in <i>pcchLanguagesBuffer</i>.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise. To get extended error information, the application
///    can call GetLastError, which returns one of the following error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A
///    supplied buffer size was not large enough, or it was incorrectly set to <b>NULL</b>.</li> </ul> If the function
///    fails for any other reason, the parameters <i>pulNumLanguages</i> and <i>pcchLanguagesBuffer</i> are undefined.
///    
@DllImport("KERNEL32")
BOOL GetThreadPreferredUILanguages(uint dwFlags, uint* pulNumLanguages, 
                                   /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PWSTR pwszLanguagesBuffer, 
                                   uint* pcchLanguagesBuffer);

///Sets the thread preferred UI languages for the current thread. For more information, see User Interface Language
///Management. <div class="alert"><b>Note</b> This function is also used by the operating system to identify languages
///that are safe to use on the Windows console.</div> <div> </div>
///Params:
///    dwFlags = Flags identifying format and filtering for the languages to set. The following <i>format flags</i> specify the
///              language format to use for the thread preferred UI languages. The flags are mutually exclusive, and the default
///              is MUI_LANGUAGE_NAME. We recommend that you use MUI_LANGUAGE_NAME instead of MUI_LANGUAGE_ID. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MUI_LANGUAGE_ID"></a><a
///              id="mui_language_id"></a><dl> <dt><b>MUI_LANGUAGE_ID</b></dt> </dl> </td> <td width="60%"> The input parameter
///              language strings are in language identifier format. </td> </tr> <tr> <td width="40%"><a
///              id="MUI_LANGUAGE_NAME"></a><a id="mui_language_name"></a><dl> <dt><b>MUI_LANGUAGE_NAME</b></dt> </dl> </td> <td
///              width="60%"> The input parameter language strings are in language name format. </td> </tr> </table> The following
///              <i>filtering flags</i> specify filtering for the language list. The flags are mutually exclusive. By default,
///              neither MUI_COMPLEX_SCRIPT_FILTER nor MUI_CONSOLE_FILTER is set. For more information about the filtering flags,
///              see the Remarks section. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="MUI_COMPLEX_SCRIPT_FILTER"></a><a id="mui_complex_script_filter"></a><dl>
///              <dt><b>MUI_COMPLEX_SCRIPT_FILTER</b></dt> </dl> </td> <td width="60%"> GetThreadPreferredUILanguages should
///              replace with the appropriate fallback all languages having complex scripts. When this flag is specified,
///              <b>NULL</b> must be passed for all other parameters. </td> </tr> <tr> <td width="40%"><a
///              id="MUI_CONSOLE_FILTER"></a><a id="mui_console_filter"></a><dl> <dt><b>MUI_CONSOLE_FILTER</b></dt> </dl> </td>
///              <td width="60%"> GetThreadPreferredUILanguages should replace with the appropriate fallback all languages that
///              cannot display properly in a console window with the current operating system settings. When this flag is
///              specified, <b>NULL</b> must be passed for all other parameters. </td> </tr> <tr> <td width="40%"><a
///              id="MUI_RESET_FILTERS"></a><a id="mui_reset_filters"></a><dl> <dt><b>MUI_RESET_FILTERS</b></dt> </dl> </td> <td
///              width="60%"> Reset the filtering for the language list by removing any other filter settings. When this flag is
///              specified, <b>NULL</b> must be passed for all other parameters. After setting this flag, the application can call
///              GetThreadPreferredUILanguages to retrieve the complete unfiltered list. </td> </tr> </table>
///    pwszLanguagesBuffer = Pointer to a double null-terminated multi-string buffer that contains an ordered, null-delimited list, in the
///                          format specified by <i>dwFlags</i>. To clear the thread preferred UI languages list, an application sets this
///                          parameter to a null string or an empty double null-terminated string. If an application clears a language list,
///                          it should specify either a format flag or 0 for the <i>dwFlags</i> parameter. When the application specifies one
///                          of the filtering flags, it must set this parameter to <b>NULL</b>. In this case, the function succeeds, but does
///                          not reset the thread preferred languages.
///    pulNumLanguages = Pointer to the number of languages that the function has set in the thread preferred UI languages list. When the
///                      application specifies one of the filtering flags, the function must set this parameter to <b>NULL</b>.
///Returns:
///    Returns <b>TRUE</b> if the function succeeds or <b>FALSE</b> otherwise.
///    
@DllImport("KERNEL32")
BOOL SetThreadPreferredUILanguages(uint dwFlags, 
                                   /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/const(PWSTR) pwszLanguagesBuffer, 
                                   uint* pulNumLanguages);

///Retrieves resource-related information about a file.
///Params:
///    dwFlags = Flags specifying the information to retrieve. Any combination of the following flags is allowed. The default
///              value of the flags is MUI_QUERY_TYPE | MUI_QUERY_CHECKSUM. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///              <tr> <td width="40%"><a id="MUI_QUERY_TYPE"></a><a id="mui_query_type"></a><dl> <dt><b>MUI_QUERY_TYPE</b></dt>
///              </dl> </td> <td width="60%"> Retrieve one of the following values in the <b>dwFileType</b> member of FILEMUIINFO:
///              <ul> <li>MUI_FILETYPE_NOT_LANGUAGE_NEUTRAL: The specified input file does not have resource configuration data.
///              Thus it is neither an LN file nor a language-specific resource file. This type of file is typical for older
///              executable files. If this file type is specified, the function will not retrieve useful information for the other
///              types.</li> <li>MUI_FILETYPE_LANGUAGE_NEUTRAL_MAIN. The input file is an LN file.</li>
///              <li>MUI_FILETYPE_LANGUAGE_NEUTRAL_MUI. The input file is a language-specific resource file associated with an LN
///              file.</li> </ul> </td> </tr> <tr> <td width="40%"><a id="MUI_QUERY_CHECKSUM"></a><a
///              id="mui_query_checksum"></a><dl> <dt><b>MUI_QUERY_CHECKSUM</b></dt> </dl> </td> <td width="60%"> Retrieve the
///              resource checksum of the input file in the <b>pChecksum</b> member of FILEMUIINFO. If the input file does not
///              have resource configuration data, this member of the structure contains 0. </td> </tr> <tr> <td width="40%"><a
///              id="MUI_QUERY_LANGUAGE_NAME"></a><a id="mui_query_language_name"></a><dl> <dt><b>MUI_QUERY_LANGUAGE_NAME</b></dt>
///              </dl> </td> <td width="60%"> Retrieve the language associated with the input file. For a language-specific
///              resource file, this flag requests the associated language. For an LN file, this flag requests the language of the
///              ultimate fallback resources for the module, which can be either in the LN file or in a separate language-specific
///              resource file referenced by the resource configuration data of the LN file. For more information, see the Remarks
///              section. </td> </tr> <tr> <td width="40%"><a id="MUI_QUERY_RESOURCE_TYPES"></a><a
///              id="mui_query_resource_types"></a><dl> <dt><b>MUI_QUERY_RESOURCE_TYPES</b></dt> </dl> </td> <td width="60%">
///              Retrieve lists of resource types in the language-specific resource files and LN files as they are specified in
///              the resource configuration data. See the Remarks section for a way to access this information. </td> </tr>
///              </table>
///    pcwszFilePath = Pointer to a null-terminated string indicating the path to the file. Typically the file is either an LN file or a
///                    language-specific resource file. If it is not one of these types, the only significant value that the function
///                    retrieves is MUI_FILETYPE_NOT_LANGUAGE_NEUTRAL. The function only retrieves this value if the
///                    MUI_QUERY_RESOURCE_TYPES flag is set.
///    pFileMUIInfo = Pointer to a buffer containing file information in a FILEMUIINFO structure and possibly in data following that
///                   structure. The information buffer might have to be much larger than the size of the structure itself. Depending
///                   on flag settings, the function can store considerable information following the structure, at offsets retrieved
///                   in the structure. For more information, see the Remarks section. Alternatively, the application can set this
///                   parameter to <b>NULL</b> if <i>pcbFileMUIInfo</i> is set to 0. In this case, the function retrieves the required
///                   size for the information buffer in <i>pcbFileMUIInfo</i>. <div class="alert"><b>Note</b> If the value of
///                   <i>pFileMUIInfo</i> is not <b>NULL</b>, the <b>dwSize</b> member must be set to the size of the FILEMUIINFO
///                   structure (including the information buffer), and the <b>dwVersion</b> member must be set to the current version
///                   of 0x001.</div> <div> </div>
///    pcbFileMUIInfo = Pointer to the buffer size, in bytes, for the file information indicated by <i>pFileMUIInfo</i>. On successful
///                     return from the function, this parameter contains the size of the retrieved file information buffer and the
///                     FILEMUIINFO structure that contains it. Alternatively, the application can set this parameter to 0 if it sets
///                     <b>NULL</b> in <i>pFileMUIInfo</i>. In this case, the function retrieves the required file information buffer
///                     size in <i>pcbFileMUIInfo</i>. To allocate the correct amount of memory, this value should be added to the size
///                     of the FILEMUIINFO structure itself. <div class="alert"><b>Note</b> The value of this parameter must match the
///                     value of the <b>dwSize</b> member of FILEMUIINFO if the value of <i>pFileMUIInfo</i> is not <b>NULL</b>.</div>
///                     <div> </div>
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise. To get extended error information, the application
///    can call GetLastError.
///    
@DllImport("KERNEL32")
BOOL GetFileMUIInfo(uint dwFlags, const(PWSTR) pcwszFilePath, FILEMUIINFO* pFileMUIInfo, uint* pcbFileMUIInfo);

///Retrieves the path to all language-specific resource files associated with the supplied LN file. The application must
///call this function repeatedly to get the path for each resource file.
///Params:
///    dwFlags = Flags identifying language format and filtering. The following flags specify the format of the language indicated
///              by <i>pwszLanguage</i>. The flags are mutually exclusive, and the default is MUI_LANGUAGE_NAME. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MUI_LANGUAGE_ID"></a><a
///              id="mui_language_id"></a><dl> <dt><b>MUI_LANGUAGE_ID</b></dt> </dl> </td> <td width="60%"> Retrieve the language
///              string in language identifier format. </td> </tr> <tr> <td width="40%"><a id="MUI_LANGUAGE_NAME"></a><a
///              id="mui_language_name"></a><dl> <dt><b>MUI_LANGUAGE_NAME</b></dt> </dl> </td> <td width="60%"> Retrieve the
///              language string in language name format. </td> </tr> </table> The following flags specify the filtering for the
///              function to use in locating language-specific resource files if <i>pwszLanguage</i> is set to <b>NULL</b>. The
///              filtering flags are mutually exclusive, and the default is MUI_USER_PREFERRED_UI_LANGUAGES. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MUI_USE_SEARCH_ALL_LANGUAGES"></a><a
///              id="mui_use_search_all_languages"></a><dl> <dt><b>MUI_USE_SEARCH_ALL_LANGUAGES</b></dt> </dl> </td> <td
///              width="60%"> Retrieve all language-specific resource files for the path indicated by <i>pcwszFilePath</i>,
///              without considering file licensing. This flag is relevant only if the application supplies a null string for
///              <i>pwszLanguage</i>. </td> </tr> <tr> <td width="40%"><a id="MUI_USER_PREFERRED_UI_LANGUAGES"></a><a
///              id="mui_user_preferred_ui_languages"></a><dl> <dt><b>MUI_USER_PREFERRED_UI_LANGUAGES</b></dt> </dl> </td> <td
///              width="60%"> Retrieve only the files that implement languages in the fallback list. Successive calls enumerate
///              the successive fallbacks, in the appropriate order. The first file indicated by the output value of
///              <i>pcchFileMUIPath</i> should be the best fit. This flag is relevant only if the application supplies a null
///              string for <i>pwszLanguage</i>. </td> </tr> <tr> <td width="40%"><a id="MUI_USE_INSTALLED_LANGUAGES"></a><a
///              id="mui_use_installed_languages"></a><dl> <dt><b>MUI_USE_INSTALLED_LANGUAGES</b></dt> </dl> </td> <td
///              width="60%"> Retrieve only the files for the languages installed on the computer. This flag is relevant only if
///              the application supplies a null string for <i>pwszLanguage</i>. </td> </tr> </table> The following flags allow
///              the user to indicate the type of file that is specified by <i>pcwszFilePath</i> so that the function can
///              determine if it must add ".mui" to the file name. The flags are mutually exclusive. If the application passes
///              both flags, the function fails. If the application passes neither flag, the function checks the file in the root
///              folder to verify the file type and decide on file naming. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///              <td width="40%"><a id="MUI_LANG_NEUTRAL_PE_FILE"></a><a id="mui_lang_neutral_pe_file"></a><dl>
///              <dt><b>MUI_LANG_NEUTRAL_PE_FILE</b></dt> </dl> </td> <td width="60%"> Do not verify the file passed in
///              <i>pcwszFilePath</i> and append ".mui" to the file name before processing. For example, change Abc.exe to
///              Abc.exe.mui. </td> </tr> <tr> <td width="40%"><a id="MUI_NON_LANG_NEUTRAL_FILE"></a><a
///              id="mui_non_lang_neutral_file"></a><dl> <dt><b>MUI_NON_LANG_NEUTRAL_FILE</b></dt> </dl> </td> <td width="60%"> Do
///              not verify the file passed in <i>pcwszFilePath</i> and do not append ".mui" to the file name before processing.
///              For example, use Abc.txt or Abc.chm. </td> </tr> </table>
///    pcwszFilePath = Pointer to a null-terminated string specifying a file path. The path is either for an existing LN file or for a
///                    file such as a .txt, .inf, or .msc file. If the file is an LN file, the function looks for files containing the
///                    associated language-specific resources. For all other types of files, the function seeks files that correspond
///                    exactly to the file name and path indicated. Your application can overwrite the behavior of the file type check
///                    by using the MUI_LANG_NEUTRAL_PE_FILE or MUI_NON_LANG_NEUTRAL_FILE flag. For more information, see the Remarks
///                    section. <div class="alert"><b>Note</b> The supplied file path can be a network path: for example,
///                    "\\machinename\c$\windows\system32\notepad.exe".</div> <div> </div>
///    pwszLanguage = Pointer to a buffer containing a language string. On input, this buffer contains the language identifier or
///                   language name for which the application should find language-specific resource files, depending on the settings
///                   of <i>dwFlags</i>. On successful return from the function, this parameter contains the language of the
///                   language-specific resource file that the function has found. Alternatively, the application can set this
///                   parameter to <b>NULL</b>, with the value referenced by <i>pcchLanguage</i> set to 0. In this case, the function
///                   retrieves the required buffer size in <i>pcchLanguage</i>.
///    pcchLanguage = Pointer to the buffer size, in characters, for the language string indicated by <i>pwszLanguage</i>. If the
///                   application sets the value referenced by this parameter to 0 and passes <b>NULL</b> for <i>pwszLanguage</i>, then
///                   the required buffer size will be returned in <i>pcchLanguage</i> and the returned buffer size is always
///                   LOCALE_NAME_MAX_LENGTH, because the function is typically called multiple times in succession. The function
///                   cannot determine the exact size of the language name for all successive calls, and cannot extend the buffer on
///                   subsequent calls. Thus LOCALE_NAME_MAX_LENGTH is the only safe maximum.
///    pwszFileMUIPath = Pointer to a buffer containing the path to the language-specific resource file. It is strongly recommended to
///                      allocate this buffer to be of size MAX_PATH. Alternatively, this parameter can retrieve <b>NULL</b> if the value
///                      referenced by <i>pcchFileMUIPath</i> is set to 0. In this case, the function retrieves the required size for the
///                      file path buffer in <i>pcchFileMUIPath</i>.
///    pcchFileMUIPath = Pointer to the buffer size, in characters, for the file path indicated by <i>pwszFileMUIPath</i>. On successful
///                      return from the function, this parameter indicates the size of the retrieved file path. If the application sets
///                      the value referenced by this parameter to 0, the function retrieves <b>NULL</b> for <i>pwszFileMUIPath</i>, the
///                      required buffer size will be returned in <i>pcchFileMUIPath</i> and the returned buffer size is always MAX_PATH,
///                      because the function is typically called multiple times in succession. The function cannot determine the exact
///                      size of the path for all successive calls, and cannot extend the buffer on subsequent calls. Thus MAX_PATH is the
///                      only safe maximum.
///    pululEnumerator = Pointer to an enumeration variable. The first time this function is called, the value of the variable should be
///                      0. Between subsequent calls, the application should not change the value of this parameter. After the function
///                      retrieves all possible language-specific resource file paths, it returns <b>FALSE</b>.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise. If the function fails, the output parameters do not
///    change. To get extended error information, the application can call GetLastError, which can return the following
///    error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was
///    incorrectly set to <b>NULL</b>.</li> <li>ERROR_NO_MORE_FILES. There were no more files to process.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL GetFileMUIPath(uint dwFlags, const(PWSTR) pcwszFilePath, PWSTR pwszLanguage, uint* pcchLanguage, 
                    PWSTR pwszFileMUIPath, uint* pcchFileMUIPath, ulong* pululEnumerator);

///Retrieves a variety of information about an installed UI language: <ul> <li>Is the language installed?</li> <li>Is
///the current user licensed to use the language?</li> <li>Is the language fully localized? Partially localized? Part of
///a Language Installation Pack (LIP)?</li> <li>If it is partially localized or part of an LIP:<ul> <li>What is its
///fallback language? </li> <li>If that fallback language is a partially localized language, what is its base?</li>
///<li>What is the default fallback language?</li> </ul> </li> </ul>
///Params:
///    dwFlags = Flags defining the format of the specified language. The flags are mutually exclusive, and the default is
///              MUI_LANGUAGE_NAME. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="MUI_LANGUAGE_ID"></a><a id="mui_language_id"></a><dl> <dt><b>MUI_LANGUAGE_ID</b></dt> </dl> </td> <td
///              width="60%"> Retrieve the language strings in language identifier format. </td> </tr> <tr> <td width="40%"><a
///              id="MUI_LANGUAGE_NAME"></a><a id="mui_language_name"></a><dl> <dt><b>MUI_LANGUAGE_NAME</b></dt> </dl> </td> <td
///              width="60%"> Retrieve the language strings in language name format. </td> </tr> </table>
///    pwmszLanguage = Pointer to languages for which the function is to retrieve information. This parameter indicates an ordered,
///                    null-delimited list of language identifiers or language names, depending on the flag setting. For information on
///                    the use of this parameter, see the Remarks section.
///    pwszFallbackLanguages = Pointer to a buffer in which this function retrieves an ordered, null-delimited list of fallback languages,
///                            formatted as defined by the setting for <i>dwFlags</i>. This list ends with two null characters. Alternatively if
///                            this parameter is set to <b>NULL</b> and <i>pcchLanguagesBuffer</i> is set to 0, the function retrieves the
///                            required size of the language buffer in <i>pcchLanguagesBuffer</i>. The required size includes the two null
///                            characters.
///    pcchFallbackLanguages = Pointer to the size, in characters, for the language buffer indicated by <i>pwszFallbackLanguages</i>. On
///                            successful return from the function, the parameter contains the size of the retrieved language buffer.
///                            Alternatively if this parameter is set to 0 and <i>pwszLanguagesBuffer </i>is set to <b>NULL</b>, the function
///                            retrieves the required size of the language buffer in <i>pcchLanguagesBuffer</i>.
///    pAttributes = Pointer to flags indicating attributes of the input language list. The function always retrieves the flag
///                  characterizing the last language listed. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                  width="40%"><a id="MUI_FULL_LANGUAGE"></a><a id="mui_full_language"></a><dl> <dt><b>MUI_FULL_LANGUAGE</b></dt>
///                  </dl> </td> <td width="60%"> The language is fully localized. </td> </tr> <tr> <td width="40%"><a
///                  id="MUI_PARTIAL_LANGUAGE"></a><a id="mui_partial_language"></a><dl> <dt><b>MUI_PARTIAL_LANGUAGE</b></dt> </dl>
///                  </td> <td width="60%"> The language is partially localized. </td> </tr> <tr> <td width="40%"><a
///                  id="MUI_LIP_LANGUAGE"></a><a id="mui_lip_language"></a><dl> <dt><b>MUI_LIP_LANGUAGE</b></dt> </dl> </td> <td
///                  width="60%"> The language is an LIP language. </td> </tr> </table> In addition, <i>pdwAttributes</i> includes one
///                  or both of the following flags, as appropriate. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                  width="40%"><a id="MUI_LANGUAGE_INSTALLED"></a><a id="mui_language_installed"></a><dl>
///                  <dt><b>MUI_LANGUAGE_INSTALLED</b></dt> </dl> </td> <td width="60%"> The language is installed on this computer.
///                  </td> </tr> <tr> <td width="40%"><a id="MUI_LANGUAGE_LICENSED"></a><a id="mui_language_licensed"></a><dl>
///                  <dt><b>MUI_LANGUAGE_LICENSED</b></dt> </dl> </td> <td width="60%"> The language is appropriately licensed for the
///                  current user. </td> </tr> </table>
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise. To get extended error information, the application
///    can call GetLastError, which can return the following error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied
///    buffer size was not large enough, or it was incorrectly set to <b>NULL</b>.</li> <li>ERROR_INVALID_PARAMETER. Any
///    of the parameter values was invalid. For more information, see Remarks.</li> <li>ERROR_OBJECT_NAME_NOT_FOUND. The
///    specified object name was not found, or it was not valid, or the first language in the input list is not an
///    installed language. For more information, see Remarks. </li> </ul> If GetLastError returns any other error code,
///    the parameters <i>pcchFallbackLanguages</i> and <i>pdwAttributes</i> are undefined.
///    
@DllImport("KERNEL32")
BOOL GetUILanguageInfo(uint dwFlags, 
                       /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/const(PWSTR) pwmszLanguage, 
                       /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/PWSTR pwszFallbackLanguages, 
                       uint* pcchFallbackLanguages, uint* pAttributes);

@DllImport("KERNEL32")
BOOL SetThreadPreferredUILanguages2(uint flags, 
                                    /*PARAM ATTR: NullNullTerminated : CustomAttributeSig([], [])*/const(PWSTR) languages, 
                                    uint* numLanguagesSet, HSAVEDUILANGUAGES__** snapshot);

@DllImport("KERNEL32")
void RestoreThreadPreferredUILanguages(const(HSAVEDUILANGUAGES__)* snapshot);

///Unsupported. <b>NotifyUILanguageChange</b> may be altered or unavailable.
///Params:
///    dwFlags = Reserved.
///    pcwstrNewLanguage = The new language.
///    pcwstrPreviousLanguage = The previous language.
///    dwReserved = Reserved.
///    pdwStatusRtrn = A pointer to a <b>DWORD</b> return status.
///Returns:
///    A <b>BOOL</b> datatype.
///    
@DllImport("KERNEL32")
BOOL NotifyUILanguageChange(uint dwFlags, const(PWSTR) pcwstrNewLanguage, const(PWSTR) pcwstrPreviousLanguage, 
                            uint dwReserved, uint* pdwStatusRtrn);

@DllImport("KERNEL32")
BOOL GetStringTypeExA(uint Locale, uint dwInfoType, const(PSTR) lpSrcStr, int cchSrc, ushort* lpCharType);

///Deprecated. Retrieves character type information for the characters in the specified source string. For each
///character in the string, the function sets one or more bits in the corresponding 16-bit element of the output array.
///Each bit identifies a given character type, for example, letter, digit, or neither. <div class="alert"><b>Caution</b>
///Using the <b>GetStringTypeA</b> function incorrectly can compromise the security of your application. To avoid a
///buffer overflow, the application must set the output buffer size correctly. For more security information, see
///Security Considerations: Windows User Interface.</div> <div> </div>
///Params:
///    Locale = Locale identifier that specifies the locale. You can use the MAKELCID macro to create a locale identifier or use
///             one of the following predefined values. <ul> <li> LOCALE_SYSTEM_DEFAULT </li> <li> LOCALE_USER_DEFAULT </li>
///             </ul> <b>Windows Vista and later:</b> The following custom locale identifiers are also supported. <ul> <li>
///             LOCALE_CUSTOM_DEFAULT </li> <li> LOCALE_CUSTOM_UI_DEFAULT </li> <li> LOCALE_CUSTOM_UNSPECIFIED </li> </ul>
///    dwInfoType = Flags specifying the character type information to retrieve. For possible flag values, see the <i>dwInfoType</i>
///                 parameter of GetStringTypeW. For detailed information about the character type bits, see Remarks for
///                 GetStringTypeW.
///    lpSrcStr = Pointer to the ANSI string for which to retrieve the character types. The string can be a double-byte character
///               set (DBCS) string if the supplied locale is appropriate for DBCS. The string is assumed to be null-terminated if
///               <i>cchSrc</i> is set to any negative value.
///    cchSrc = Size, in characters, of the string indicated by <i>lpSrcStr</i>. If the size includes a terminating null
///             character, the function retrieves character type information for that character. If the application sets the size
///             to any negative integer, the source string is assumed to be null-terminated and the function calculates the size
///             automatically with an additional character for the null termination.
///    lpCharType = Pointer to an array of 16-bit values. The length of this array must be large enough to receive one 16-bit value
///                 for each character in the source string. If <i>cchSrc</i> is not a negative number, <i>lpCharType</i> should be
///                 an array of words with <i>cchSrc</i> elements. If <i>cchSrc</i> is set to a negative number, <i>lpCharType</i> is
///                 an array of words with <i>lpSrcStr</i> + 1 elements. When the function returns, this array contains one word
///                 corresponding to each character in the source string.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_FLAGS. The values
///    supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL GetStringTypeA(uint Locale, uint dwInfoType, const(PSTR) lpSrcStr, int cchSrc, ushort* lpCharType);

///Maps one Unicode string to another, performing the specified transformation. For an overview of the use of the string
///functions, see Strings. <div class="alert"><b>Caution</b> Using <b>FoldString</b> incorrectly can compromise the
///security of your application. Strings that are not mapped correctly can produce invalid input. Test strings to make
///sure they are valid before using them and provide error handlers. For more information, see Security Considerations:
///International Features.</div><div> </div>
///Params:
///    dwMapFlags = Flags specifying the type of transformation to use during string mapping. This parameter can be a combination of
///                 the following values. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                 id="MAP_COMPOSITE"></a><a id="map_composite"></a><dl> <dt><b>MAP_COMPOSITE</b></dt> </dl> </td> <td width="60%">
///                 Map accented characters to decomposed characters, that is, characters in which a base character and one or more
///                 nonspacing characters each have distinct code point values. For example, Ä is represented by A + ¨: LATIN
///                 CAPITAL LETTER A (U+0041) + COMBINING DIAERESIS (U+0308). This flag is equivalent to normalization form D in
///                 Windows Vista. Note that this flag cannot be used with MB_PRECOMPOSED. </td> </tr> <tr> <td width="40%"><a
///                 id="MAP_EXPAND_LIGATURES"></a><a id="map_expand_ligatures"></a><dl> <dt><b>MAP_EXPAND_LIGATURES</b></dt> </dl>
///                 </td> <td width="60%"> Expand all ligature characters so that they are represented by their two-character
///                 equivalent. For example, the ligature "æ" (U+00e6) expands to the two characters "a" (U+0061) + "e" (U+0065).
///                 This value cannot be combined with MAP_PRECOMPOSED or MAP_COMPOSITE. </td> </tr> <tr> <td width="40%"><a
///                 id="MAP_FOLDCZONE"></a><a id="map_foldczone"></a><dl> <dt><b>MAP_FOLDCZONE</b></dt> </dl> </td> <td width="60%">
///                 Fold compatibility zone characters into standard Unicode equivalents. This flag is equivalent to normalization
///                 form KD in Windows Vista, if the MAP_COMPOSITE flag is also set. If the composite flag is not set (default), this
///                 flag is equivalent to normalization form KC in Windows Vista. </td> </tr> <tr> <td width="40%"><a
///                 id="MAP_FOLDDIGITS"></a><a id="map_folddigits"></a><dl> <dt><b>MAP_FOLDDIGITS</b></dt> </dl> </td> <td
///                 width="60%"> Map all digits to Unicode characters 0 through 9. </td> </tr> <tr> <td width="40%"><a
///                 id="MAP_PRECOMPOSED"></a><a id="map_precomposed"></a><dl> <dt><b>MAP_PRECOMPOSED</b></dt> </dl> </td> <td
///                 width="60%"> Map accented characters to precomposed characters, in which the accent and base character are
///                 combined into a single character value. This flag is equivalent to normalization form C in Windows Vista. This
///                 value cannot be combined with MAP_COMPOSITE. </td> </tr> </table>
///    lpSrcStr = Pointer to a source string that the function maps.
///    cchSrc = Size, in characters, of the source string indicated by <i>lpSrcStr</i>, excluding the terminating null character.
///             The application can set the parameter to any negative value to specify that the source string is null-terminated.
///             In this case, the function calculates the string length automatically, and null-terminates the mapped string
///             indicated by <i>lpDestStr</i>.
///    lpDestStr = Pointer to a buffer in which this function retrieves the mapped string.
///    cchDest = Size, in characters, of the destination string indicated by <i>lpDestStr</i>. If space for a terminating null
///              character is included in <i>cchSrc</i>, <i>cchDest</i> must also include space for a terminating null character.
///              The application can set <i>cchDest</i> to 0. In this case, the function does not use the <i>lpDestStr</i>
///              parameter and returns the required buffer size for the mapped string. If the MAP_FOLDDIGITS flag is specified,
///              the return value is the maximum size required, even if the actual number of characters needed is smaller than the
///              maximum size. If the maximum size is not passed, the function fails with ERROR_INSUFFICIENT_BUFFER.
///Returns:
///    Returns the number of characters in the translated string, including a terminating null character, if successful.
///    If the function succeeds and the value of <i>cchDest</i> is 0, the return value is the size of the buffer
///    required to hold the translated string, including a terminating null character. This function returns 0 if it
///    does not succeed. To get extended error information, the application can call GetLastError, which can return one
///    of the following error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or
///    it was incorrectly set to <b>NULL</b>. </li> <li>ERROR_INVALID_DATA. The data was invalid.</li>
///    <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of
///    the parameter values was invalid.</li> <li>ERROR_MOD_NOT_FOUND. The module was not found. </li>
///    <li>ERROR_OUTOFMEMORY. Not enough storage was available to complete this operation. </li>
///    <li>ERROR_PROC_NOT_FOUND. The required procedure was not found.</li> </ul>
///    
@DllImport("KERNEL32")
int FoldStringA(uint dwMapFlags, const(PSTR) lpSrcStr, int cchSrc, PSTR lpDestStr, int cchDest);

///Enumerates the locales that are either installed on or supported by an operating system. <div
///class="alert"><b>Note</b> For interoperability reasons, the application should prefer the EnumSystemLocalesEx
///function to <b>EnumSystemLocales</b> because Microsoft is migrating toward the use of locale names instead of locale
///identifiers for new locales. Any application that will be run only on Windows Vista and later should use
///EnumSystemLocalesEx.</div><div> </div>
///Params:
///    lpLocaleEnumProc = Pointer to an application-defined callback function. For more information, see EnumLocalesProc.
///    dwFlags = Flags specifying the locale identifiers to enumerate. The flags can be used singly or combined using a binary OR.
///              If the application specifies 0 for this parameter, the function behaves as for LCID_SUPPORTED. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="LCID_INSTALLED"></a><a
///              id="lcid_installed"></a><dl> <dt><b>LCID_INSTALLED</b></dt> </dl> </td> <td width="60%"> Enumerate only installed
///              locale identifiers. This value cannot be used with LCID_SUPPORTED. </td> </tr> <tr> <td width="40%"><a
///              id="LCID_SUPPORTED"></a><a id="lcid_supported"></a><dl> <dt><b>LCID_SUPPORTED</b></dt> </dl> </td> <td
///              width="60%"> Enumerate all supported locale identifiers. This value cannot be used with LCID_INSTALLED. </td>
///              </tr> <tr> <td width="40%"><a id="LCID_ALTERNATE_SORTS"></a><a id="lcid_alternate_sorts"></a><dl>
///              <dt><b>LCID_ALTERNATE_SORTS</b></dt> </dl> </td> <td width="60%"> Enumerate only the alternate sort locale
///              identifiers. If this value is used with either LCID_INSTALLED or LCID_SUPPORTED, the installed or supported
///              locales are retrieved, as well as the alternate sort locale identifiers. </td> </tr> </table>
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_BADDB. The function could
///    not access the data. This situation should not normally occur, and typically indicates a bad installation, a disk
///    problem, or the like.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumSystemLocalesA(LOCALE_ENUMPROCA lpLocaleEnumProc, uint dwFlags);

///Enumerates the locales that are either installed on or supported by an operating system. <div
///class="alert"><b>Note</b> For interoperability reasons, the application should prefer the EnumSystemLocalesEx
///function to <b>EnumSystemLocales</b> because Microsoft is migrating toward the use of locale names instead of locale
///identifiers for new locales. Any application that will be run only on Windows Vista and later should use
///EnumSystemLocalesEx.</div><div> </div>
///Params:
///    lpLocaleEnumProc = Pointer to an application-defined callback function. For more information, see EnumLocalesProc.
///    dwFlags = Flags specifying the locale identifiers to enumerate. The flags can be used singly or combined using a binary OR.
///              If the application specifies 0 for this parameter, the function behaves as for LCID_SUPPORTED. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="LCID_INSTALLED"></a><a
///              id="lcid_installed"></a><dl> <dt><b>LCID_INSTALLED</b></dt> </dl> </td> <td width="60%"> Enumerate only installed
///              locale identifiers. This value cannot be used with LCID_SUPPORTED. </td> </tr> <tr> <td width="40%"><a
///              id="LCID_SUPPORTED"></a><a id="lcid_supported"></a><dl> <dt><b>LCID_SUPPORTED</b></dt> </dl> </td> <td
///              width="60%"> Enumerate all supported locale identifiers. This value cannot be used with LCID_INSTALLED. </td>
///              </tr> <tr> <td width="40%"><a id="LCID_ALTERNATE_SORTS"></a><a id="lcid_alternate_sorts"></a><dl>
///              <dt><b>LCID_ALTERNATE_SORTS</b></dt> </dl> </td> <td width="60%"> Enumerate only the alternate sort locale
///              identifiers. If this value is used with either LCID_INSTALLED or LCID_SUPPORTED, the installed or supported
///              locales are retrieved, as well as the alternate sort locale identifiers. </td> </tr> </table>
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_BADDB. The function could
///    not access the data. This situation should not normally occur, and typically indicates a bad installation, a disk
///    problem, or the like.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumSystemLocalesW(LOCALE_ENUMPROCW lpLocaleEnumProc, uint dwFlags);

///Enumerates the language groups that are either installed on or supported by an operating system. <div
///class="alert"><b>Note</b> For custom locales, your application should call EnumSystemLocalesEx instead of
///<b>EnumSystemLanguageGroups</b>.</div> <div> </div>
///Params:
///    lpLanguageGroupEnumProc = Pointer to an application-defined callback function. For more information, see EnumLanguageGroupsProc.
///    dwFlags = Flags specifying the language group identifiers to enumerate. This parameter can have one of the following
///              values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="LGRPID_INSTALLED"></a><a
///              id="lgrpid_installed"></a><dl> <dt><b>LGRPID_INSTALLED</b></dt> </dl> </td> <td width="60%"> Enumerate only
///              installed language group identifiers. </td> </tr> <tr> <td width="40%"><a id="LGRPID_SUPPORTED"></a><a
///              id="lgrpid_supported"></a><dl> <dt><b>LGRPID_SUPPORTED</b></dt> </dl> </td> <td width="60%"> Enumerate all
///              supported language group identifiers. </td> </tr> </table>
///    lParam = Application-defined value to pass to the callback function. This parameter can be used in error checking. It can
///             also be used to ensure thread safety in the callback function.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise. To get extended error information, the application
///    can call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_BADDB. The function
///    could not access the data. This situation should not normally occur, and typically indicates a bad installation,
///    a disk problem, or the like.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumSystemLanguageGroupsA(LANGUAGEGROUP_ENUMPROCA lpLanguageGroupEnumProc, uint dwFlags, ptrdiff_t lParam);

///Enumerates the language groups that are either installed on or supported by an operating system. <div
///class="alert"><b>Note</b> For custom locales, your application should call EnumSystemLocalesEx instead of
///<b>EnumSystemLanguageGroups</b>.</div> <div> </div>
///Params:
///    lpLanguageGroupEnumProc = Pointer to an application-defined callback function. For more information, see EnumLanguageGroupsProc.
///    dwFlags = Flags specifying the language group identifiers to enumerate. This parameter can have one of the following
///              values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="LGRPID_INSTALLED"></a><a
///              id="lgrpid_installed"></a><dl> <dt><b>LGRPID_INSTALLED</b></dt> </dl> </td> <td width="60%"> Enumerate only
///              installed language group identifiers. </td> </tr> <tr> <td width="40%"><a id="LGRPID_SUPPORTED"></a><a
///              id="lgrpid_supported"></a><dl> <dt><b>LGRPID_SUPPORTED</b></dt> </dl> </td> <td width="60%"> Enumerate all
///              supported language group identifiers. </td> </tr> </table>
///    lParam = Application-defined value to pass to the callback function. This parameter can be used in error checking. It can
///             also be used to ensure thread safety in the callback function.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise. To get extended error information, the application
///    can call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_BADDB. The function
///    could not access the data. This situation should not normally occur, and typically indicates a bad installation,
///    a disk problem, or the like.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumSystemLanguageGroupsW(LANGUAGEGROUP_ENUMPROCW lpLanguageGroupEnumProc, uint dwFlags, ptrdiff_t lParam);

///Enumerates the locales in a specified language group. <div class="alert"><b>Note</b> For custom locales, your
///application should call EnumSystemLocalesEx in preference to <b>EnumLanguageGroupLocales</b>.</div> <div> </div>
///Params:
///    lpLangGroupLocaleEnumProc = Pointer to an application-defined callback function. For more information, see EnumLanguageGroupLocalesProc.
///    LanguageGroup = Identifier of the language group for which to enumerate locales. This parameter can have one of the following
///                    values: <ul> <li>LGRPID_ARABIC </li> <li>LGRPID_ARMENIAN</li> <li>LGRPID_BALTIC </li> <li>LGRPID_CENTRAL_EUROPE
///                    </li> <li>LGRPID_CYRILLIC </li> <li>LGRPID_GEORGIAN </li> <li>LGRPID_GREEK </li> <li>LGRPID_HEBREW </li>
///                    <li>LGRPID_INDIC </li> <li>LGRPID_JAPANESE </li> <li>LGRPID_KOREAN </li> <li>LGRPID_SIMPLIFIED_CHINESE </li>
///                    <li>LGRPID_TRADITIONAL_CHINESE</li> <li>LGRPID_THAI </li> <li>LGRPID_TURKIC</li> <li>LGRPID_TURKISH </li>
///                    <li>LGRPID_VIETNAMESE </li> <li>LGRPID_WESTERN_EUROPE </li> </ul>
///    dwFlags = Reserved; must be 0.
///    lParam = An application-defined value to pass to the callback function. This value can be used for error checking. It can
///             also be used to ensure thread safety in the callback function.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_BADDB. The function could
///    not access the data. This situation should not normally occur, and typically indicates a bad installation, a disk
///    problem, or the like.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumLanguageGroupLocalesA(LANGGROUPLOCALE_ENUMPROCA lpLangGroupLocaleEnumProc, uint LanguageGroup, 
                               uint dwFlags, ptrdiff_t lParam);

///Enumerates the locales in a specified language group. <div class="alert"><b>Note</b> For custom locales, your
///application should call EnumSystemLocalesEx in preference to <b>EnumLanguageGroupLocales</b>.</div> <div> </div>
///Params:
///    lpLangGroupLocaleEnumProc = Pointer to an application-defined callback function. For more information, see EnumLanguageGroupLocalesProc.
///    LanguageGroup = Identifier of the language group for which to enumerate locales. This parameter can have one of the following
///                    values: <ul> <li>LGRPID_ARABIC </li> <li>LGRPID_ARMENIAN</li> <li>LGRPID_BALTIC </li> <li>LGRPID_CENTRAL_EUROPE
///                    </li> <li>LGRPID_CYRILLIC </li> <li>LGRPID_GEORGIAN </li> <li>LGRPID_GREEK </li> <li>LGRPID_HEBREW </li>
///                    <li>LGRPID_INDIC </li> <li>LGRPID_JAPANESE </li> <li>LGRPID_KOREAN </li> <li>LGRPID_SIMPLIFIED_CHINESE </li>
///                    <li>LGRPID_TRADITIONAL_CHINESE</li> <li>LGRPID_THAI </li> <li>LGRPID_TURKIC</li> <li>LGRPID_TURKISH </li>
///                    <li>LGRPID_VIETNAMESE </li> <li>LGRPID_WESTERN_EUROPE </li> </ul>
///    dwFlags = Reserved; must be 0.
///    lParam = An application-defined value to pass to the callback function. This value can be used for error checking. It can
///             also be used to ensure thread safety in the callback function.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_BADDB. The function could
///    not access the data. This situation should not normally occur, and typically indicates a bad installation, a disk
///    problem, or the like.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumLanguageGroupLocalesW(LANGGROUPLOCALE_ENUMPROCW lpLangGroupLocaleEnumProc, uint LanguageGroup, 
                               uint dwFlags, ptrdiff_t lParam);

///Enumerates the user interface languages that are available on the operating system and calls the callback function
///with every language in the list.
///Params:
///    lpUILanguageEnumProc = Pointer to an application-defined EnumUILanguagesProc callback function. <b>EnumUILanguages</b> calls this
///                           function repeatedly to enumerate the languages in the list.
///    dwFlags = Flags identifying language format and filtering. The following flags specify the format of the language to pass
///              to the callback function. The format flags are mutually exclusive, and MUI_LANGUAGE_ID is the default. <table>
///              <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MUI_LANGUAGE_ID"></a><a
///              id="mui_language_id"></a><dl> <dt><b>MUI_LANGUAGE_ID</b></dt> </dl> </td> <td width="60%"> Pass the language
///              identifier in the language string to the callback function. </td> </tr> <tr> <td width="40%"><a
///              id="MUI_LANGUAGE_NAME"></a><a id="mui_language_name"></a><dl> <dt><b>MUI_LANGUAGE_NAME</b></dt> </dl> </td> <td
///              width="60%"> Pass the language name in the language string to the callback function. </td> </tr> </table> The
///              following flags specify the filtering for the function to use in enumerating the languages. The filtering flags
///              are mutually exclusive, and the default is MUI_LICENSED_LANGUAGES. <table> <tr> <th>Value</th> <th>Meaning</th>
///              </tr> <tr> <td width="40%"><a id="MUI_ALL_INSTALLED_LANGUAGES"></a><a id="mui_all_installed_languages"></a><dl>
///              <dt><b>MUI_ALL_INSTALLED_LANGUAGES</b></dt> </dl> </td> <td width="60%"> Enumerate all installed languages
///              available to the operating system. </td> </tr> <tr> <td width="40%"><a id="MUI_LICENSED_LANGUAGES"></a><a
///              id="mui_licensed_languages"></a><dl> <dt><b>MUI_LICENSED_LANGUAGES</b></dt> </dl> </td> <td width="60%">
///              Enumerate all installed languages that are available and licensed for use. </td> </tr> <tr> <td width="40%"><a
///              id="MUI_GROUP_POLICY"></a><a id="mui_group_policy"></a><dl> <dt><b>MUI_GROUP_POLICY</b></dt> </dl> </td> <td
///              width="60%"> Enumerate all installed languages that are available and licensed, and that are allowed by the group
///              policy. </td> </tr> </table> <b>Windows Vista and later:</b> The application can set <i>dwFlags</i> to 0, or to
///              one or more of the specified flags. A setting of 0 causes the parameter value to default to MUI_LANGUAGE_ID |
///              MUI_LICENSED_LANGUAGES. <b>Windows 2000, Windows XP, Windows Server 2003:</b> The application must set
///              <i>dwFlags</i> to 0.
///    lParam = Application-defined value.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise. To get extended error information, the application
///    can call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_FLAGS. The
///    values supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumUILanguagesA(UILANGUAGE_ENUMPROCA lpUILanguageEnumProc, uint dwFlags, ptrdiff_t lParam);

///Enumerates the user interface languages that are available on the operating system and calls the callback function
///with every language in the list.
///Params:
///    lpUILanguageEnumProc = Pointer to an application-defined EnumUILanguagesProc callback function. <b>EnumUILanguages</b> calls this
///                           function repeatedly to enumerate the languages in the list.
///    dwFlags = Flags identifying language format and filtering. The following flags specify the format of the language to pass
///              to the callback function. The format flags are mutually exclusive, and MUI_LANGUAGE_ID is the default. <table>
///              <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MUI_LANGUAGE_ID"></a><a
///              id="mui_language_id"></a><dl> <dt><b>MUI_LANGUAGE_ID</b></dt> </dl> </td> <td width="60%"> Pass the language
///              identifier in the language string to the callback function. </td> </tr> <tr> <td width="40%"><a
///              id="MUI_LANGUAGE_NAME"></a><a id="mui_language_name"></a><dl> <dt><b>MUI_LANGUAGE_NAME</b></dt> </dl> </td> <td
///              width="60%"> Pass the language name in the language string to the callback function. </td> </tr> </table> The
///              following flags specify the filtering for the function to use in enumerating the languages. The filtering flags
///              are mutually exclusive, and the default is MUI_LICENSED_LANGUAGES. <table> <tr> <th>Value</th> <th>Meaning</th>
///              </tr> <tr> <td width="40%"><a id="MUI_ALL_INSTALLED_LANGUAGES"></a><a id="mui_all_installed_languages"></a><dl>
///              <dt><b>MUI_ALL_INSTALLED_LANGUAGES</b></dt> </dl> </td> <td width="60%"> Enumerate all installed languages
///              available to the operating system. </td> </tr> <tr> <td width="40%"><a id="MUI_LICENSED_LANGUAGES"></a><a
///              id="mui_licensed_languages"></a><dl> <dt><b>MUI_LICENSED_LANGUAGES</b></dt> </dl> </td> <td width="60%">
///              Enumerate all installed languages that are available and licensed for use. </td> </tr> <tr> <td width="40%"><a
///              id="MUI_GROUP_POLICY"></a><a id="mui_group_policy"></a><dl> <dt><b>MUI_GROUP_POLICY</b></dt> </dl> </td> <td
///              width="60%"> Enumerate all installed languages that are available and licensed, and that are allowed by the group
///              policy. </td> </tr> </table> <b>Windows Vista and later:</b> The application can set <i>dwFlags</i> to 0, or to
///              one or more of the specified flags. A setting of 0 causes the parameter value to default to MUI_LANGUAGE_ID |
///              MUI_LICENSED_LANGUAGES. <b>Windows 2000, Windows XP, Windows Server 2003:</b> The application must set
///              <i>dwFlags</i> to 0.
///    lParam = Application-defined value.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise. To get extended error information, the application
///    can call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_FLAGS. The
///    values supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumUILanguagesW(UILANGUAGE_ENUMPROCW lpUILanguageEnumProc, uint dwFlags, ptrdiff_t lParam);

///Enumerates the code pages that are either installed on or supported by an operating system.
///Params:
///    lpCodePageEnumProc = Pointer to an application-defined callback function. The <b>EnumSystemCodePages</b> function enumerates code
///                         pages by making repeated calls to this callback function. For more information, see EnumCodePagesProc.
///    dwFlags = Flag specifying the code pages to enumerate. This parameter can have one of the following values, which are
///              mutually exclusive. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="CP_INSTALLED"></a><a id="cp_installed"></a><dl> <dt><b>CP_INSTALLED</b></dt> </dl> </td> <td width="60%">
///              Enumerate only installed code pages. </td> </tr> <tr> <td width="40%"><a id="CP_SUPPORTED"></a><a
///              id="cp_supported"></a><dl> <dt><b>CP_SUPPORTED</b></dt> </dl> </td> <td width="60%"> Enumerate all supported code
///              pages. </td> </tr> </table>
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_BADDB. The function could
///    not access the data. This situation should not normally occur, and typically indicates a bad installation, a disk
///    problem, or the like.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumSystemCodePagesA(CODEPAGE_ENUMPROCA lpCodePageEnumProc, uint dwFlags);

///Enumerates the code pages that are either installed on or supported by an operating system.
///Params:
///    lpCodePageEnumProc = Pointer to an application-defined callback function. The <b>EnumSystemCodePages</b> function enumerates code
///                         pages by making repeated calls to this callback function. For more information, see EnumCodePagesProc.
///    dwFlags = Flag specifying the code pages to enumerate. This parameter can have one of the following values, which are
///              mutually exclusive. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="CP_INSTALLED"></a><a id="cp_installed"></a><dl> <dt><b>CP_INSTALLED</b></dt> </dl> </td> <td width="60%">
///              Enumerate only installed code pages. </td> </tr> <tr> <td width="40%"><a id="CP_SUPPORTED"></a><a
///              id="cp_supported"></a><dl> <dt><b>CP_SUPPORTED</b></dt> </dl> </td> <td width="60%"> Enumerate all supported code
///              pages. </td> </tr> </table>
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_BADDB. The function could
///    not access the data. This situation should not normally occur, and typically indicates a bad installation, a disk
///    problem, or the like.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumSystemCodePagesW(CODEPAGE_ENUMPROCW lpCodePageEnumProc, uint dwFlags);

///Converts an internationalized domain name (IDN) or another internationalized label to a Unicode (wide character)
///representation of the ASCII string that represents the name in the Punycode transfer encoding syntax. <div
///class="alert"><b>Caution</b> This function implements the RFC 3490: Internationalizing Domain Names in Applications
///(IDNA) standard algorithm for converting an IDN to Punycode. The standard introduces some security issues. One issue
///is that glyphs representing certain characters from different scripts might appear similar or even identical. For
///example, in many fonts, Cyrillic lowercase A ("а") is indistinguishable from Latin lowercase A ("a"). There is no
///way to tell visually that "example.com" and "exаmple.com" are two different domain names, one with a Latin lowercase
///A in the name, the other with a Cyrillic lowercase A. For more information about IDN-related security concerns, see
///Handling Internationalized Domain Names (IDNs).</div> <div> </div>
///Params:
///    dwFlags = Flags specifying conversion options. The following table lists the possible values. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IDN_ALLOW_UNASSIGNED"></a><a
///              id="idn_allow_unassigned"></a><dl> <dt><b>IDN_ALLOW_UNASSIGNED</b></dt> </dl> </td> <td width="60%"> <div
///              class="alert"><b>Note</b> An application can set this value if it is just using a query string for normal lookup,
///              as in a compare operation. However, the application should not set this value for a stored string, which is a
///              string being prepared for storage.</div> <div> </div> Allow unassigned code points to be included in the input
///              string. The default is to not allow unassigned code points, and fail with an extended error code of
///              ERROR_INVALID_NAME. This flag allows the function to process characters that are not currently legal in IDNs, but
///              might be legal in later versions of the IDNA standard. If your application encodes unassigned code points as
///              Punycode, the resulting domain names should be illegal. Security can be compromised if a later version of IDNA
///              makes these names legal or if an application filters out the illegal characters to try to create a legal domain
///              name. For more information, see Handling Internationalized Domain Names (IDNs). </td> </tr> <tr> <td
///              width="40%"><a id="IDN_USE_STD3_ASCII_RULES"></a><a id="idn_use_std3_ascii_rules"></a><dl>
///              <dt><b>IDN_USE_STD3_ASCII_RULES</b></dt> </dl> </td> <td width="60%"> Filter out ASCII characters that are not
///              allowed in STD3 names. The only ASCII characters allowed in the input Unicode string are letters, digits, and the
///              hyphen-minus. The string cannot begin or end with the hyphen-minus. The function fails if the input Unicode
///              string contains ASCII characters, such as "[", "]", or "/", that cannot occur in domain names.<div
///              class="alert"><b>Note</b> Some local networks can allow some of these characters in computer names.</div> <div>
///              </div> The function fails if the input Unicode string contains control characters (U+0001 through U+0020) or the
///              "delete" character (U+007F). In either case, this flag has no effect on the non-ASCII characters that are allowed
///              in the Unicode string. </td> </tr> <tr> <td width="40%"><a id="IDN_EMAIL_ADDRESS"></a><a
///              id="idn_email_address"></a><dl> <dt><b>IDN_EMAIL_ADDRESS</b></dt> </dl> </td> <td width="60%"> <b>Starting with
///              Windows 8:</b> Enable EAI algorithmic fallback for the local parts of email addresses (such as
///              <i>&lt;local&gt;</i>@microsoft.com). The default is for this function to fail when an email address has an
///              invalid address or syntax. An application can set this flag to enable Email Address Internationalization (EAI) to
///              return a discoverable fallback address, if possible. For more information, see the IETF Email Address
///              Internationalization (eai) Charter. </td> </tr> <tr> <td width="40%"><a id="IDN_RAW_PUNYCODE"></a><a
///              id="idn_raw_punycode"></a><dl> <dt><b>IDN_RAW_PUNYCODE</b></dt> </dl> </td> <td width="60%"> <b>Starting with
///              Windows 8:</b> Disable the validation and mapping of Punycode. </td> </tr> </table>
///    lpUnicodeCharStr = Pointer to a Unicode string representing an IDN or another internationalized label.
///    cchUnicodeChar = Count of characters in the input Unicode string indicated by <i>lpUnicodeCharStr</i>.
///    lpASCIICharStr = Pointer to a buffer that receives a Unicode string consisting only of characters in the ASCII character set. On
///                     return from this function, the buffer contains the ASCII string equivalent of the string provided in
///                     <i>lpUnicodeCharStr</i> under Punycode. Alternatively, the function can retrieve <b>NULL</b> for this parameter,
///                     if <i>cchASCIIChar</i> is set to 0. In this case, the function returns the size required for this buffer.
///    cchASCIIChar = Size of the buffer indicated by <i>lpASCIICharStr</i>. The application can set the parameter to 0 to retrieve
///                   <b>NULL</b> in <i>lpASCIICharStr</i>.
///Returns:
///    Returns the number of characters retrieved in <i>lpASCIICharStr</i> if successful. The retrieved string is
///    null-terminated only if the input Unicode string is null-terminated. If the function succeeds and the value of
///    <i>cchASCIIChar</i> is 0, the function returns the required size, in characters including a terminating null
///    character if it was part of the input buffer. The function returns 0 if it does not succeed. To get extended
///    error information, the application can call GetLastError, which can return one of the following error codes: <ul>
///    <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was incorrectly set to
///    <b>NULL</b>.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_NAME. An invalid name was supplied to the function. Note that this error code catches all
///    syntax errors. </li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li>
///    <li>ERROR_NO_UNICODE_TRANSLATION. Invalid Unicode was found in a string.</li> </ul>
///    
@DllImport("NORMALIZ")
int IdnToAscii(uint dwFlags, const(PWSTR) lpUnicodeCharStr, int cchUnicodeChar, PWSTR lpASCIICharStr, 
               int cchASCIIChar);

///Converts the Punycode form of an internationalized domain name (IDN) or another internationalized label to the normal
///Unicode UTF-16 encoding syntax. <div class="alert"><b>Caution</b> This function implements the RFC 3490:
///Internationalizing Domain Names in Applications (IDNA) standard algorithms for the Punycode encoding of Unicode. The
///standard introduces some security issues. One issue is that glyphs representing certain characters from different
///scripts might appear similar or even identical. For example, in many fonts, Cyrillic lowercase A ("а") is
///indistinguishable from Latin lowercase A ("a"). There is no way to tell visually that "example.com" and
///"exаmple.com" are two different domain names, one with a Latin lowercase A in the name, the other with a Cyrillic
///lowercase A. For more information about IDN-related security concerns, see Handling Internationalized Domain Names
///(IDNs).</div> <div> </div>
///Params:
///    dwFlags = Flags specifying conversion options. For detailed definitions, see the <i>dwFlags</i> parameter of IdnToAscii.
///    lpASCIICharStr = Pointer to a string representing the Punycode encoding of an IDN or another internationalized label. This string
///                     must consist only of ASCII characters, and can include Punycode-encoded Unicode. The function decodes Punycode
///                     values to their UTF-16 values.
///    cchASCIIChar = Count of characters in the input string indicated by <i>lpASCIICharStr</i>.
///    lpUnicodeCharStr = Pointer to a buffer that receives a normal Unicode UTF-16 encoding equivalent to the Punycode value of the input
///                       string. Alternatively, the function can retrieve <b>NULL</b> for this parameter, if <i>cchUnicodeChar</i> set to
///                       0. In this case, the function returns the size required for this buffer.
///    cchUnicodeChar = Size, in characters, of the buffer indicated by <i>lpUnicodeCharStr</i>. The application can set the size to 0 to
///                     retrieve <b>NULL</b> in <i>lpUnicodeCharStr</i> and have the function return the required buffer size.
///Returns:
///    Returns the number of characters retrieved in <i>lpUnicodeCharStr</i> if successful. The retrieved string is
///    null-terminated only if the input string is null-terminated. If the function succeeds and the value of
///    <i>cchUnicodeChar</i> is 0, the function returns the required size, in characters including a terminating null
///    character if it was part of the input buffer. The function returns 0 if it does not succeed. To get extended
///    error information, the application can call GetLastError, which can return one of the following error codes: <ul>
///    <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was incorrectly set to
///    <b>NULL</b>.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_NAME. An invalid name was supplied to the function. Note that this error code catches all
///    syntax errors. </li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li>
///    <li>ERROR_NO_UNICODE_TRANSLATION. Invalid Unicode was found in a string.</li> </ul>
///    
@DllImport("NORMALIZ")
int IdnToUnicode(uint dwFlags, const(PWSTR) lpASCIICharStr, int cchASCIIChar, PWSTR lpUnicodeCharStr, 
                 int cchUnicodeChar);

///Converts an internationalized domain name (IDN) or another internationalized label to the NamePrep form specified by
///Network Working Group RFC 3491, but does not perform the additional conversion to Punycode. For more information and
///links to related draft standards, see Handling Internationalized Domain Names (IDNs).
///Params:
///    dwFlags = Flags specifying conversion options. For detailed definitions, see the <i>dwFlags</i> parameter of IdnToAscii.
///    lpUnicodeCharStr = Pointer to a Unicode string representing an IDN or another internationalized label.
///    cchUnicodeChar = Count of Unicode characters in the input Unicode string indicated by <i>lpUnicodeCharStr</i>.
///    lpNameprepCharStr = Pointer to a buffer that receives a version of the input Unicode string converted through NamePrep processing.
///                        Alternatively, the function can retrieve <b>NULL</b> for this parameter, if <i>cchNameprepChar</i> is set to 0.
///                        In this case, the function returns the size required for this buffer.
///    cchNameprepChar = Size, in characters, of the buffer indicated by <i>lpNameprepCharStr</i>. The application can set the size to 0
///                      to retrieve <b>NULL</b> in <i>lpNameprepCharStr</i> and have the function return the required buffer size.
///Returns:
///    Returns the number of characters retrieved in <i>lpNameprepCharStr</i> if successful. The retrieved string is
///    null-terminated only if the input Unicode string is null-terminated. If the function succeeds and the value of
///    <i>cchNameprepChar</i> is 0, the function returns the required size, in characters including a terminating null
///    character if it was part of the input buffer. The function returns 0 if it does not succeed. To get extended
///    error information, the application can call GetLastError, which can return one of the following error codes: <ul>
///    <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was incorrectly set to
///    <b>NULL</b>.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_NAME. An invalid name was supplied to the function. Note that this error code catches all
///    syntax errors. </li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li>
///    <li>ERROR_NO_UNICODE_TRANSLATION. Invalid Unicode was found in a string.</li> </ul>
///    
@DllImport("KERNEL32")
int IdnToNameprepUnicode(uint dwFlags, const(PWSTR) lpUnicodeCharStr, int cchUnicodeChar, PWSTR lpNameprepCharStr, 
                         int cchNameprepChar);

///Normalizes characters of a text string according to Unicode 4.0 TR#15. For more information, see Using Unicode
///Normalization to Represent Strings.
///Params:
///    NormForm = Normalization form to use. NORM_FORM specifies the standard Unicode normalization forms.
///    lpSrcString = Pointer to the non-normalized source string.
///    cwSrcLength = Length, in characters, of the buffer containing the source string. The application can set this parameter to -1
///                  if the function should assume the string to be null-terminated and calculate the length automatically.
///    lpDstString = Pointer to a buffer in which the function retrieves the destination string. Alternatively, this parameter
///                  contains <b>NULL</b> if <i>cwDstLength</i> is set to 0. <div class="alert"><b>Note</b> The function does not
///                  null-terminate the string if the input string length is explicitly specified without a terminating null
///                  character. To null-terminate the output string, the application should specify -1 or explicitly count the
///                  terminating null character for the input string.</div> <div> </div>
///    cwDstLength = Length, in characters, of the buffer containing the destination string. Alternatively, the application can set
///                  this parameter to 0 to request the function to return the required size for the destination buffer.
///Returns:
///    Returns the length of the normalized string in the destination buffer. If <i>cwDstLength</i> is set to 0, the
///    function returns the estimated buffer length required to do the actual conversion. If the string in the input
///    buffer is null-terminated or if <i>cwSrcLength</i> is -1, the string written to the destination buffer is
///    null-terminated and the returned string length includes the terminating null character. The function returns a
///    value that is less than or equal to 0 if it does not succeed. To get extended error information, the application
///    can call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A
///    supplied buffer size was not large enough, or it was incorrectly set to <b>NULL</b>.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> <li>ERROR_NO_UNICODE_TRANSLATION.
///    Invalid Unicode was found in a string. The return value is the negative of the index of the location of the error
///    in the input string.</li> <li>ERROR_SUCCESS. The action completed successfully but yielded no results.</li> </ul>
///    
@DllImport("KERNEL32")
int NormalizeString(NORM_FORM NormForm, const(PWSTR) lpSrcString, int cwSrcLength, PWSTR lpDstString, 
                    int cwDstLength);

///Verifies that a string is normalized according to Unicode 4.0 TR#15. For more information, see Using Unicode
///Normalization to Represent Strings.
///Params:
///    NormForm = Normalization form to use. NORM_FORM specifies the standard Unicode normalization forms.
///    lpString = Pointer to the string to test.
///    cwLength = Length, in characters, of the input string, including a null terminating character. If this value is -1, the
///               function assumes the string to be null-terminated and calculates the length automatically.
///Returns:
///    Returns <b>TRUE</b> if the input string is already normalized to the appropriate form, or <b>FALSE</b> otherwise.
///    To get extended error information, the application can call GetLastError, which can return one of the following
///    error codes: <ul> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li>
///    <li>ERROR_NO_UNICODE_TRANSLATION. Invalid Unicode was found in string.</li> <li>ERROR_SUCCESS. The action
///    completed successfully but yielded no results.</li> </ul> If you need to reliably determine <b>FALSE</b> from an
///    error condition, then it must call SetLastError(ERROR_SUCCESS).
///    
@DllImport("KERNEL32")
BOOL IsNormalizedString(NORM_FORM NormForm, const(PWSTR) lpString, int cwLength);

///Compares two enumerated lists of scripts.
///Params:
///    dwFlags = Flags specifying script verification options. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="VS_ALLOW_LATIN"></a><a id="vs_allow_latin"></a><dl> <dt><b>VS_ALLOW_LATIN</b></dt> </dl> </td>
///              <td width="60%"> Allow "Latn" (Latin script) in the test list even if it is not in the locale list. </td> </tr>
///              </table>
///    lpLocaleScripts = Pointer to the locale list, the enumerated list of scripts for a given locale. This list is typically populated
///                      by calling GetLocaleInfoEx with <i>LCType</i> set to LOCALE_SSCRIPTS.
///    cchLocaleScripts = Size, in characters, of the string indicated by <i>lpLocaleScripts</i>. The application sets this parameter to -1
///                       if the string is null-terminated. If this parameter is set to 0, the function fails.
///    lpTestScripts = Pointer to the test list, a second enumerated list of scripts. This list is typically populated by calling
///                    GetStringScripts.
///    cchTestScripts = Size, in characters, of the string indicated by <i>lpTestScripts</i>. The application sets this parameter to -1
///                     if the string is null-terminated. If this parameter is set to 0, the function fails.
///Returns:
///    Returns <b>TRUE</b> if the test list is non-empty and all items in the list are also included in the locale list.
///    The function still returns <b>TRUE</b> if the locale list contains more scripts than the test list, but all the
///    test list scripts must be contained in the locale list. If VS_ALLOW_LATIN is specified in <i>dwFlags</i>, the
///    function behaves as if "Latn;" is always in the locale list. In all other cases, the function returns
///    <b>FALSE</b>. This return can indicate that the test list contains an item that is not in the locale list, or it
///    can indicate an error. To distinguish between these two cases, the application should call GetLastError, which
///    can return one of the following error codes: <ul> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not
///    valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> <li>ERROR_SUCCESS. The
///    action completed successfully but yielded no results.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL VerifyScripts(uint dwFlags, const(PWSTR) lpLocaleScripts, int cchLocaleScripts, const(PWSTR) lpTestScripts, 
                   int cchTestScripts);

///Provides a list of scripts used in the specified Unicode string.
///Params:
///    dwFlags = Flags specifying options for script retrieval. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="GSS_ALLOW_INHERITED_COMMON"></a><a id="gss_allow_inherited_common"></a><dl>
///              <dt><b>GSS_ALLOW_INHERITED_COMMON</b></dt> </dl> </td> <td width="60%"> Retrieve "Qaii" (INHERITED) and "Zyyy"
///              (COMMON) script information. This flag does not affect the processing of unassigned characters. These characters
///              in the input string always cause a "Zzzz" (UNASSIGNED script) to appear in the script string. </td> </tr>
///              </table> <div class="alert"><b>Note</b> By default, <b>GetStringScripts</b> ignores any inherited or common
///              characters in the input string indicated by <i>lpString</i>. If GSS_ALLOW_INHERITED_COMMON is not set, neither
///              "Qaii" nor "Zyyy" appears in the script string, even if the input string contains such characters. If
///              GSS_ALLOW_INHERITED_COMMON is set, and if the input string contains inherited and/or common characters, "Qaii"
///              and/or "Zyyy", respectively, appear in the script string. See the Remarks section.</div> <div> </div>
///    lpString = Pointer to the Unicode string to analyze.
///    cchString = Size, in characters, of the Unicode string indicated by <i>lpString</i>. The application sets this parameter to
///                -1 if the Unicode string is null-terminated. If the application sets this parameter to 0, the function retrieves
///                a null Unicode string (L"\0") in <i>lpScripts</i> and returns 1.
///    lpScripts = Pointer to a buffer in which this function retrieves a null-terminated string representing a list of scripts,
///                using the 4-character notation used in ISO 15924. Each script name consists of four Latin characters, and the
///                names are retrieved in alphabetical order. Each name, including the last, is followed by a semicolon.
///                Alternatively, this parameter contains <b>NULL</b> if <i>cchScripts</i> is set to 0. In this case, the function
///                returns the required size for the script buffer.
///    cchScripts = Size, in characters, of the script buffer indicated by <i>lpScripts</i>. Alternatively, the application can set
///                 this parameter to 0. In this case, the function retrieves <b>NULL</b> in <i>lpScripts</i> and returns the
///                 required size for the script buffer.
///Returns:
///    Returns the number of characters retrieved in the output buffer, including a terminating null character, if
///    successful and <i>cchScripts</i> is set to a nonzero value. The function returns 1 to indicate that no script has
///    been found, for example, when the input string only contains COMMON or INHERITED characters and
///    GSS_ALLOW_INHERITED_COMMON is not set. Given that each found script adds five characters (four characters +
///    delimiter), a simple mathematical operation provides the script count as (return_code - 1) / 5. If the function
///    succeeds and the value of <i>cchScripts</i> is 0, the function returns the required size, in characters including
///    a terminating null character, for the script buffer. The script count is as described above. This function
///    returns 0 if it does not succeed. To get extended error information, the application can call GetLastError, which
///    can return one of the following error codes: <ul> <li>ERROR_BADDB. The function could not access the data. This
///    situation should not normally occur, and typically indicates a bad installation, a disk problem, or the
///    like.</li> <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was incorrectly set
///    to <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int GetStringScripts(uint dwFlags, const(PWSTR) lpString, int cchString, PWSTR lpScripts, int cchScripts);

///Retrieves information about a locale specified by name.<div class="alert"><b>Note</b> The application should call
///this function in preference to GetLocaleInfo if designed to run only on Windows Vista and later.</div> <div> </div>
///<div class="alert"><b>Note</b> This function can retrieve data that changes between releases, for example, due to a
///custom locale. If your application must persist or transmit data, see Using Persistent Locale Data.</div> <div>
///</div>
///Params:
///    lpLocaleName = Pointer to a locale name, or one of the following predefined values. <ul> <li> LOCALE_NAME_INVARIANT </li> <li>
///                   LOCALE_NAME_SYSTEM_DEFAULT </li> <li> LOCALE_NAME_USER_DEFAULT </li> </ul>
///    LCType = The locale information to retrieve. For possible values, see the "Constants Used in the LCType Parameter of
///             GetLocaleInfo, GetLocaleInfoEx, and SetLocaleInfo" section in Locale Information Constants. Note that only one
///             piece of locale information can be specified per call. The application can use the binary OR operator to combine
///             LOCALE_RETURN_NUMBER with any other allowed constant. In this case, the function retrieves the value as a number
///             instead of a string. The buffer that receives the value must be at least the length of a DWORD value, which is 2.
///             <div class="alert"><b>Caution</b> It is also possible to combine LOCALE_NOUSEROVERRIDE with any other constant.
///             However, use of this constant is strongly discouraged. (Even without using the current user override, the data
///             can differ from computer to computer, and custom locales can change the data. For example, even month or day
///             names are subject to spelling reforms.)</div> <div> </div> If <i>LCType</i> is set to LOCALE_IOPTIONALCALENDAR,
///             the function retrieves only the first alternate calendar. <div class="alert"><b>Note</b> To get all alternate
///             calendars, the application should use EnumCalendarInfoEx.</div> <div> </div> Starting with Windows Vista, your
///             applications should not use LOCALE_ILANGUAGE in the <i>LCType</i> parameter to avoid failure or retrieval of
///             unexpected data. Instead, it is recommended for your applications to call <b>GetLocaleInfoEx</b>.
///    lpLCData = Pointer to a buffer in which this function retrieves the requested locale information. This pointer is not used
///               if <i>cchData</i> is set to 0.
///    cchData = Size, in characters, of the data buffer indicated by <i>lpLCData</i>. Alternatively, the application can set this
///              parameter to 0. In this case, the function does not use the <i>lpLCData</i> parameter and returns the required
///              buffer size, including the terminating null character.
///Returns:
///    Returns the number of characters retrieved in the locale data buffer if successful and <i>cchData</i> is a
///    nonzero value. If the function succeeds, <i>cchData</i> is nonzero, and LOCALE_RETURN_NUMBER is specified, the
///    return value is the size of the integer retrieved in the data buffer, that is, 2. If the function succeeds and
///    the value of <i>cchData</i> is 0, the return value is the required size, in characters including a null
///    character, for the locale data buffer. The function returns 0 if it does not succeed. To get extended error
///    information, the application can call GetLastError, which can return one of the following error codes: <ul>
///    <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was incorrectly set to
///    <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int GetLocaleInfoEx(const(PWSTR) lpLocaleName, uint LCType, PWSTR lpLCData, int cchData);

///Retrieves information about a calendar for a locale specified by name.<div class="alert"><b>Note</b> The application
///should call this function in preference to GetCalendarInfo if designed to run only on Windows Vista and later.</div>
///<div> </div> <div class="alert"><b>Note</b> This function can retrieve data that changes between releases, for
///example, due to a custom locale. If your application must persist or transmit data, see Using Persistent Locale
///Data.</div> <div> </div>
///Params:
///    lpLocaleName = Pointer to a locale name, or one of the following predefined values. <ul> <li> LOCALE_NAME_INVARIANT </li> <li>
///                   LOCALE_NAME_SYSTEM_DEFAULT </li> <li> LOCALE_NAME_USER_DEFAULT </li> </ul>
///    Calendar = Calendar identifier.
///    lpReserved = Reserved; must be <b>NULL</b>.
///    CalType = Type of information to retrieve. For more information, see Calendar Type Information. <div
///              class="alert"><b>Note</b> <b>GetCalendarInfoEx</b> returns only one string if this parameter specifies
///              CAL_IYEAROFFSETRANGE or CAL_SERASTRING. In both cases the current era is returned.</div> <div> </div> For
///              CAL_NOUSEROVERRIDE, the function ignores any value set by SetCalendarInfo and uses the database settings for the
///              current system default locale. This type is relevant only in the combination CAL_NOUSEROVERRIDE |
///              CAL_ITWODIGITYEARMAX. CAL_ITWODIGITYEARMAX is the only value that can be set by <b>SetCalendarInfo</b>.
///    lpCalData = Pointer to a buffer in which this function retrieves the requested data as a string. If CAL_RETURN_NUMBER is
///                specified in <i>CalType</i>, this parameter must retrieve <b>NULL</b>.
///    cchData = Size, in characters, of the <i>lpCalData</i> buffer. The application can set this parameter to 0 to return the
///              required size for the calendar data buffer. In this case, the <i>lpCalData</i> parameter is not used. If
///              CAL_RETURN_NUMBER is specified for <i>CalType</i>, the value of <i>cchData</i> must be 0.
///    lpValue = Pointer to a variable that receives the requested data as a number. If CAL_RETURN_NUMBER is specified in
///              <i>CalType</i>, then <i>lpValue</i> must not be <b>NULL</b>. If CAL_RETURN_NUMBER is not specified in
///              <i>CalType</i>, then <i>lpValue</i> must be <b>NULL</b>.
///Returns:
///    Returns the number of characters retrieved in the <i>lpCalData</i> buffer if successful. If the function
///    succeeds, <i>cchData</i> is set to 0, and CAL_RETURN_NUMBER is not specified, the return value is the size of the
///    buffer required to hold the locale information. If the function succeeds, <i>cchData</i> is set to 0, and
///    CAL_RETURN_NUMBER is specified, the return value is the size of the value written to the <i>lpValue</i>
///    parameter. This size is always 2. The function returns 0 if it does not succeed. To get extended error
///    information, the application can call GetLastError, which can return one of the following error codes: <ul>
///    <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was incorrectly set to
///    <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int GetCalendarInfoEx(const(PWSTR) lpLocaleName, uint Calendar, const(PWSTR) lpReserved, uint CalType, 
                      PWSTR lpCalData, int cchData, uint* lpValue);

///Formats a number string as a number string customized for a locale specified by name.<div class="alert"><b>Note</b>
///The application should call this function in preference to GetNumberFormat if designed to run only on Windows Vista
///and later.</div> <div> </div> <div class="alert"><b>Note</b> This function can format data that changes between
///releases, for example, due to a custom locale. If your application must persist or transmit data, see Using
///Persistent Locale Data.</div> <div> </div>
///Params:
///    lpLocaleName = Pointer to a locale name, or one of the following predefined values. <ul> <li> LOCALE_NAME_INVARIANT </li> <li>
///                   LOCALE_NAME_SYSTEM_DEFAULT </li> <li> LOCALE_NAME_USER_DEFAULT </li> </ul>
///    dwFlags = Flags controlling the operation of the function. The application must set this parameter to 0 if <i>lpFormat</i>
///              is not set to <b>NULL</b>. In this case, the function formats the string using user overrides to the default
///              number format for the locale. If <i>lpFormat</i> is set to <b>NULL</b>, the application can specify
///              LOCALE_NOUSEROVERRIDE to format the string using the system default number format for the specified locale. <div
///              class="alert"><b>Caution</b> Use of LOCALE_NOUSEROVERRIDE is strongly discouraged as it disables user
///              preferences.</div> <div> </div>
///    lpValue = Pointer to a null-terminated string containing the number string to format. This string can only contain the
///              following characters. All other characters are invalid. The function returns an error if the string indicated by
///              <i>lpValue</i> deviates from these rules. <ul> <li>Characters "0" through "9".</li> <li>One decimal point (dot)
///              if the number is a floating-point value.</li> <li>A minus sign in the first character position if the number is a
///              negative value.</li> </ul>
///    lpFormat = Pointer to a NUMBERFMT structure that contains number formatting information, with all members set to appropriate
///               values. If the application does not set this parameter to <b>NULL</b>, the function uses the locale only for
///               formatting information not specified in the structure, for example, the locale string value for the negative
///               sign.
///    lpNumberStr = Pointer to a buffer in which this function retrieves the formatted number string. Alternatively, this parameter
///                  contains <b>NULL</b> if <i>cchNumber</i> is set to 0. In this case, the function returns the required size for
///                  the number string buffer.
///    cchNumber = Size, in characters, for the number string buffer indicated by <i>lpNumberStr</i>. Alternatively, the application
///                can set this parameter to 0. In this case, the function returns the required size for the number string buffer
///                and does not use the <i>lpNumberStr</i> parameter.
///Returns:
///    Returns the number of characters retrieved in the buffer indicated by <i>lpNumberStr</i> if successful. If the
///    <i>cchNumber</i> parameter is set to 0, the function returns the number of characters required to hold the
///    formatted number string, including a terminating null character. The function returns 0 if it does not succeed.
///    To get extended error information, the application can call GetLastError, which can return one of the following
///    error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was
///    incorrectly set to <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> <li>ERROR_OUTOFMEMORY. Not enough
///    storage was available to complete this operation.</li> </ul>
///    
@DllImport("KERNEL32")
int GetNumberFormatEx(const(PWSTR) lpLocaleName, uint dwFlags, const(PWSTR) lpValue, const(NUMBERFMTW)* lpFormat, 
                      PWSTR lpNumberStr, int cchNumber);

///Formats a number string as a currency string for a locale specified by name.<div class="alert"><b>Note</b> The
///application should call this function in preference to GetCurrencyFormat if designed to run only on Windows Vista and
///later.</div> <div> </div> <div class="alert"><b>Note</b> This function can format data that changes between releases,
///for example, due to a custom locale. If your application must persist or transmit data, see Using Persistent Locale
///Data.</div> <div> </div>
///Params:
///    lpLocaleName = Pointer to a locale name or one of the following predefined values. <ul> <li> LOCALE_NAME_INVARIANT </li> <li>
///                   LOCALE_NAME_SYSTEM_DEFAULT </li> <li> LOCALE_NAME_USER_DEFAULT </li> </ul>
///    dwFlags = Flags controlling the operation of the function. The application must set this parameter to 0 if <i>lpFormat</i>
///              is not set to <b>NULL</b>. In this case, the function formats the string using user overrides to the default
///              currency format for the locale. If <i>lpFormat</i> is set to <b>NULL</b>, the application can specify
///              LOCALE_NOUSEROVERRIDE to format the string using the system default currency format for the specified locale.
///              <div class="alert"><b>Caution</b> Use of LOCALE_NOUSEROVERRIDE is strongly discouraged as it disables user
///              preferences.</div> <div> </div>
///    lpValue = Pointer to a null-terminated string containing the number string to format. This string can contain only the
///              following characters. All other characters are invalid. The function returns an error if the string deviates from
///              these rules. <ul> <li>Characters "0" through "9"</li> <li>One decimal point (dot) if the number is a
///              floating-point value</li> <li>A minus sign in the first character position if the number is a negative value</li>
///              </ul>
///    lpFormat = Pointer to a CURRENCYFMT structure that contains currency formatting information. All members of the structure
///               must contain appropriate values. The application can set this parameter to <b>NULL</b> if function is to use the
///               currency format of the specified locale. If this parameter is not set to <b>NULL</b>, the function uses the
///               specified locale only for formatting information not specified in the <b>CURRENCYFMT</b> structure, for example,
///               the string value for the negative sign used by the locale.
///    lpCurrencyStr = Pointer to a buffer in which this function retrieves the formatted currency string.
///    cchCurrency = Size, in characters, of the <i>lpCurrencyStr</i> buffer. The application can set this parameter to 0 to return
///                  the size of the buffer required to hold the formatted currency string. In this case, the buffer indicated by
///                  <i>lpCurrencyStr</i> is not used.
///Returns:
///    Returns the number of characters retrieved in the buffer indicated by <i>lpCurrencyStr</i> if successful. If the
///    <i>cchCurrency</i> parameter is 0, the function returns the size of the buffer required to hold the formatted
///    currency string, including a terminating null character. The function returns 0 if it does not succeed. To get
///    extended error information, the application can call GetLastError, which can return one of the following error
///    codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was incorrectly set
///    to <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int GetCurrencyFormatEx(const(PWSTR) lpLocaleName, uint dwFlags, const(PWSTR) lpValue, 
                        const(CURRENCYFMTW)* lpFormat, PWSTR lpCurrencyStr, int cchCurrency);

///Retrieves the user default locale name.<div class="alert"><b>Note</b> The application should call this function in
///preference to GetUserDefaultLCID if designed to run only on Windows Vista and later.</div> <div> </div>
///Params:
///    lpLocaleName = Pointer to a buffer in which this function retrieves the locale name.
///    cchLocaleName = Size, in characters, of the buffer indicated by <i>lpLocaleName</i>. The maximum possible length of a locale
///                    name, including a terminating null character, is LOCALE_NAME_MAX_LENGTH. This is the recommended size to supply
///                    in this parameter.
///Returns:
///    Returns the size of the buffer containing the locale name, including the terminating null character, if
///    successful.<div class="alert"><b>Note</b> On single-user systems, the return value is the same as that returned
///    by GetSystemDefaultLocaleName.</div> <div> </div> The function returns 0 if it does not succeed. To get extended
///    error information, the application can call GetLastError, which can return one of the following error codes: <ul>
///    <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was incorrectly set to
///    <b>NULL</b>. </li> </ul>
///    
@DllImport("KERNEL32")
int GetUserDefaultLocaleName(PWSTR lpLocaleName, int cchLocaleName);

///Retrieves the system default locale name.<div class="alert"><b>Note</b> It is recommended that applications call
///GetUserDefaultLocaleName in preference over this function. This is due to the user locale generally being more useful
///and accurate for the user than the system locale.</div> <div> </div> <div class="alert"><b>Note</b> The application
///should call this function in preference to GetSystemDefaultLCID if designed to run only on Windows Vista and
///later.</div> <div> </div>
///Params:
///    lpLocaleName = Pointer to a buffer in which this function retrieves the locale name.
///    cchLocaleName = Size, in characters, of the output buffer indicated by <i>lpLocaleName</i>. The maximum possible character length
///                    of a locale name (including a terminating null character) is the value of LOCALE_NAME_MAX_LENGTH. This is the
///                    recommended size.
///Returns:
///    Returns a value greater than 0 that indicates the length of the locale name, including the terminating null
///    character, if successful. This function returns 0 if it does not succeed. To get extended error information, the
///    application can call GetLastError, which can return one of the following error codes: <ul>
///    <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was incorrectly set to
///    <b>NULL</b>.</li> </ul>
///    
@DllImport("KERNEL32")
int GetSystemDefaultLocaleName(PWSTR lpLocaleName, int cchLocaleName);

///Determines if each character in a string has a defined result for a specified NLS capability.
///Params:
///    Function = NLS capability to query. This value must be COMPARE_STRING. See the SYSNLS_FUNCTION enumeration.
///    dwFlags = Flags defining the function. Must be 0.
///    lpVersionInformation = Pointer to an NLSVERSIONINFO structure containing version information. Typically, the information is obtained by
///                           calling GetNLSVersion. The application sets this parameter to <b>NULL</b> if the function is to use the current
///                           version.
///    lpString = Pointer to the UTF-16 string to examine.
///    cchStr = Number of UTF-16 characters in the string indicated by <i>lpString</i>. This count can include a terminating null
///             character. If the terminating null character is included in the character count, it does not affect the checking
///             behavior because the terminating null character is always defined. The application should supply -1 to indicate
///             that the string is null-terminated. In this case, the function itself calculates the string length.
///Returns:
///    Returns <b>TRUE</b> if successful, only if the input string is valid, or <b>FALSE</b> otherwise. To get extended
///    error information, the application can call GetLastError, which can return one of the following error codes: <ul>
///    <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was incorrectly set to
///    <b>NULL</b>.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL IsNLSDefinedString(uint Function, uint dwFlags, NLSVERSIONINFO* lpVersionInformation, const(PWSTR) lpString, 
                        int cchStr);

///Retrieves information about the current version of a specified NLS capability for a locale specified by name.<div
///class="alert"><b>Note</b> The application should call this function in preference to GetNLSVersion if designed to run
///only on Windows Vista and later.</div> <div> </div>
///Params:
///    function = The NLS capability to query. This value must be COMPARE_STRING. See the SYSNLS_FUNCTION enumeration.
///    lpLocaleName = Pointer to a locale name, or one of the following predefined values. <ul> <li> LOCALE_NAME_INVARIANT </li> <li>
///                   LOCALE_NAME_SYSTEM_DEFAULT </li> <li> LOCALE_NAME_USER_DEFAULT </li> </ul>
///    lpVersionInformation = Pointer to an NLSVERSIONINFOEX structure. The application must initialize the <b>dwNLSVersionInfoSize</b> member
///                           to <code> sizeof(NLSVERSIONINFOEX)</code>. <div class="alert"><b>Note</b> On Windows Vista and later, the
///                           function can alternatively provide version information in an NLSVERSIONINFO structure.</div> <div> </div>
///Returns:
///    Returns <b>TRUE</b> if and only if the application has supplied valid values in <i>lpVersionInformation</i>, or
///    <b>FALSE</b> otherwise. To get extended error information, the application can call GetLastError, which can
///    return one of the following error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large
///    enough, or it was incorrectly set to <b>NULL</b>. </li> <li>ERROR_INVALID_FLAGS. The values supplied for flags
///    were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL GetNLSVersionEx(uint function_, const(PWSTR) lpLocaleName, NLSVERSIONINFOEX* lpVersionInformation);

///Determines if the NLS version is valid for a given NLS function.
///Params:
///    function = The NLS capability to query. This value must be COMPARE_STRING. See the SYSNLS_FUNCTION enumeration.
///    lpLocaleName = Pointer to a locale name, or one of the following predefined values. <ul> <li> LOCALE_NAME_INVARIANT </li> <li>
///                   LOCALE_NAME_SYSTEM_DEFAULT </li> <li> LOCALE_NAME_USER_DEFAULT </li> </ul>
///    lpVersionInformation = Pointer to an NLSVERSIONINFOEX structure. The application must initialize the <b>dwNLSVersionInfoSize</b> member
///                           to <code> sizeof(NLSVERSIONINFOEX)</code>.
///Returns:
///    Returns a nonzero value if the NLS version is valid, or zero if the version is invalid.
///    
@DllImport("KERNEL32")
uint IsValidNLSVersion(uint function_, const(PWSTR) lpLocaleName, NLSVERSIONINFOEX* lpVersionInformation);

///Locates a Unicode string (wide characters) or its equivalent in another Unicode string for a locale specified by
///name. <div class="alert"><b>Caution</b> Because strings with very different binary representations can compare as
///identical, this function can raise certain security concerns. For more information, see the discussion of comparison
///functions in Security Considerations: International Features.</div><div> </div>
///Params:
///    lpLocaleName = Pointer to a locale name, or one of the following predefined values. <ul> <li> LOCALE_NAME_INVARIANT </li> <li>
///                   LOCALE_NAME_SYSTEM_DEFAULT </li> <li> LOCALE_NAME_USER_DEFAULT </li> </ul>
///    dwFindNLSStringFlags = Flags specifying details of the find operation. These flags are mutually exclusive, with FIND_FROMSTART being the
///                           default. The application can specify just one of the find flags with any of the filtering flags defined in the
///                           next table. If the application does not specify a flag, the function uses the default comparison for the
///                           specified locale. As discussed in Handling Sorting in Your Applications, there is no binary comparison mode.
///                           <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="FIND_FROMSTART"></a><a
///                           id="find_fromstart"></a><dl> <dt><b>FIND_FROMSTART</b></dt> </dl> </td> <td width="60%"> Search the string,
///                           starting with the first character of the string. </td> </tr> <tr> <td width="40%"><a id="FIND_FROMEND"></a><a
///                           id="find_fromend"></a><dl> <dt><b>FIND_FROMEND</b></dt> </dl> </td> <td width="60%"> Search the string in the
///                           reverse direction, starting with the last character of the string. </td> </tr> <tr> <td width="40%"><a
///                           id="FIND_STARTSWITH"></a><a id="find_startswith"></a><dl> <dt><b>FIND_STARTSWITH</b></dt> </dl> </td> <td
///                           width="60%"> Test to find out if the value specified by <i>lpStringValue</i> is the first value in the source
///                           string indicated by <i>lpStringSource</i>. </td> </tr> <tr> <td width="40%"><a id="FIND_ENDSWITH"></a><a
///                           id="find_endswith"></a><dl> <dt><b>FIND_ENDSWITH</b></dt> </dl> </td> <td width="60%"> Test to find out if the
///                           value specified by <i>lpStringValue</i> is the last value in the source string indicated by
///                           <i>lpStringSource</i>. </td> </tr> </table> The application can use the filtering flags defined below in
///                           combination with a find flag. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                           id="LINGUISTIC_IGNORECASE"></a><a id="linguistic_ignorecase"></a><dl> <dt><b>LINGUISTIC_IGNORECASE</b></dt> </dl>
///                           </td> <td width="60%"> Ignore case in the search, as linguistically appropriate. For more information, see the
///                           Remarks section. </td> </tr> <tr> <td width="40%"><a id="LINGUISTIC_IGNOREDIACRITIC"></a><a
///                           id="linguistic_ignorediacritic"></a><dl> <dt><b>LINGUISTIC_IGNOREDIACRITIC</b></dt> </dl> </td> <td width="60%">
///                           Ignore diacritics, as linguistically appropriate. For more information, see the Remarks section. <div
///                           class="alert"><b>Note</b> This flag does not always produce predictable results when used with decomposed
///                           characters, that is, characters in which a base character and one or more nonspacing characters each have
///                           distinct code point values.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="NORM_IGNORECASE"></a><a
///                           id="norm_ignorecase"></a><dl> <dt><b>NORM_IGNORECASE</b></dt> </dl> </td> <td width="60%"> Ignore case in the
///                           search. For more information, see the Remarks section. </td> </tr> <tr> <td width="40%"><a
///                           id="NORM_IGNOREKANATYPE"></a><a id="norm_ignorekanatype"></a><dl> <dt><b>NORM_IGNOREKANATYPE</b></dt> </dl> </td>
///                           <td width="60%"> Do not differentiate between hiragana and katakana characters. Corresponding hiragana and
///                           katakana characters compare as equal. </td> </tr> <tr> <td width="40%"><a id="NORM_IGNORENONSPACE"></a><a
///                           id="norm_ignorenonspace"></a><dl> <dt><b>NORM_IGNORENONSPACE</b></dt> </dl> </td> <td width="60%"> Ignore
///                           nonspacing characters. For more information, see the Remarks section. </td> </tr> <tr> <td width="40%"><a
///                           id="NORM_IGNORESYMBOLS"></a><a id="norm_ignoresymbols"></a><dl> <dt><b>NORM_IGNORESYMBOLS</b></dt> </dl> </td>
///                           <td width="60%"> Ignore symbols and punctuation. </td> </tr> <tr> <td width="40%"><a id="NORM_IGNOREWIDTH"></a><a
///                           id="norm_ignorewidth"></a><dl> <dt><b>NORM_IGNOREWIDTH</b></dt> </dl> </td> <td width="60%"> Ignore the
///                           difference between half-width and full-width characters, for example, C a t == cat. The full-width form is a
///                           formatting distinction used in Chinese and Japanese scripts. </td> </tr> <tr> <td width="40%"><a
///                           id="NORM_LINGUISTIC_CASING"></a><a id="norm_linguistic_casing"></a><dl> <dt><b>NORM_LINGUISTIC_CASING</b></dt>
///                           </dl> </td> <td width="60%"> Use linguistic rules for casing, instead of file system rules (default). For more
///                           information, see the Remarks section. </td> </tr> </table>
///    lpStringSource = Pointer to the source string, in which the function searches for the string specified by <i>lpStringValue</i>.
///    cchSource = Size, in characters excluding the terminating null character, of the string indicated by <i>lpStringSource</i>.
///                The application cannot specify 0 or any negative number other than -1 for this parameter. The application
///                specifies -1 if the source string is null-terminated and the function should calculate the size automatically.
///    lpStringValue = Pointer to the search string, for which the function searches in the source string.
///    cchValue = Size, in characters excluding the terminating null character, of the string indicated by <i>lpStringValue</i>.
///               The application cannot specify 0 or any negative number other than -1 for this parameter. The application
///               specifies -1 if the search string is null-terminated and the function should calculate the size automatically.
///    pcchFound = Pointer to a buffer containing the length of the string that the function finds. The string can be either longer
///                or shorter than the search string. If the function fails to find the search string, this parameter is not
///                modified. The function can retrieve <b>NULL</b> in this parameter. In this case, the function makes no indication
///                if the length of the found string differs from the length of the source string. Note that the value of
///                <i>pcchFound</i> is often identical to the value provided in <i>cchValue</i>, but can differ in the following
///                cases: <ul> <li>The value provided in <i>cchValue</i> is negative.</li> <li>The strings are equivalent, but have
///                different lengths. For example, "A" plus "Combining Ring" (U+0041 U+030A) is equivalent to the "A Ring"
///                (U+00c5).</li> </ul>
///    lpVersionInformation = Reserved; must be <b>NULL</b>.
///    lpReserved = Reserved; must be <b>NULL</b>.
///    sortHandle = Reserved; must be 0.
///Returns:
///    Returns a 0-based index into the source string indicated by <i>lpStringSource</i> if successful. In combination
///    with the value in <i>pcchFound</i>, this index provides the exact location of the entire found string in the
///    source string. A return value of 0 is an error-free index into the source string, and the matching string is in
///    the source string at offset 0. The function returns -1 if it does not succeed. To get extended error information,
///    the application can call GetLastError, which can return one of the following error codes: <ul>
///    <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of
///    the parameter values was invalid.</li> <li>ERROR_SUCCESS. The action completed successfully but yielded no
///    results.</li> </ul>
///    
@DllImport("KERNEL32")
int FindNLSStringEx(const(PWSTR) lpLocaleName, uint dwFindNLSStringFlags, const(PWSTR) lpStringSource, 
                    int cchSource, const(PWSTR) lpStringValue, int cchValue, int* pcchFound, 
                    NLSVERSIONINFO* lpVersionInformation, void* lpReserved, LPARAM sortHandle);

///For a locale specified by name, maps an input character string to another using a specified transformation, or
///generates a sort key for the input string.<div class="alert"><b>Note</b> The application should call this function in
///preference to LCMapString if designed to run only on Windows Vista and later.</div> <div> </div>
///Params:
///    lpLocaleName = Pointer to a locale name, or one of the following predefined values. <ul> <li> LOCALE_NAME_INVARIANT </li> <li>
///                   LOCALE_NAME_SYSTEM_DEFAULT </li> <li> LOCALE_NAME_USER_DEFAULT </li> </ul>
///    dwMapFlags = Flag specifying the type of transformation to use during string mapping or the type of sort key to generate. This
///                 parameter can have the following values. | Flag | Meaning | | --- | --- | | **LCMAP_BYTEREV**| Use byte reversal.
///                 For example, if the application passes in 0x3450 0x4822, the result is 0x5034 0x2248. | | **LCMAP_FULLWIDTH** |
///                 Use Unicode (wide) characters where applicable. This flag and LCMAP_HALFWIDTH are mutually exclusive. With this
///                 flag, the mapping may use Normalization Form C even if an input character is already full-width. For example, the
///                 string "は゛" (which is already full-width) is normalized to "ば". See [Unicode normalization
///                 forms](http://www.unicode.org/reports/tr15/). | |**LCMAP_HALFWIDTH** | Use narrow characters where applicable.
///                 This flag and LCMAP_FULLWIDTH are mutually exclusive. | | **LCMAP_HIRAGANA** | Map all katakana characters to
///                 hiragana. This flag and LCMAP_KATAKANA are mutually exclusive. | | **LCMAP_KATAKANA** | Map all hiragana
///                 characters to katakana. This flag and LCMAP_HIRAGANA are mutually exclusive. | | **LCMAP_LINGUISTIC_CASING** |
///                 Use linguistic rules for casing, instead of file system rules (default). This flag is valid with LCMAP_LOWERCASE
///                 or LCMAP_UPPERCASE only. | | **LCMAP_LOWERCASE** | For locales and scripts capable of handling uppercase and
///                 lowercase, map all characters to lowercase. | **LCMAP_HASH** | Return a hash of the raw sort weights of a
///                 string.<br> <br>Strings that appear equivalent typically return the same hash (for example, "hello" and "HELLO"
///                 with LCMAP_IGNORECASE). However, some complex cases, such as East Asian languages, can have similar strings with
///                 identical weights that compare as equal but do not return the same hash.<br> <br>LCMAP_HASH requires that the
///                 output buffer be of size sizeof(int) | | **LCMAP_SIMPLIFIED_CHINESE** | Map traditional Chinese characters to
///                 simplified Chinese characters. This flag and LCMAP_TRADITIONAL_CHINESE are mutually exclusive. | |
///                 **LCMAP_SORTHANDLE** <br> **The use of a sort handle results in minimal performance improvements and is
///                 discouraged.** | Return a token representing the resolved sort parameters for the locale (like locale name), so
///                 future calls can pass <code>NULL</code> for the sort name and pass the previously queried sort handle as the last
///                 parameter (sortHandle) in subsequent calls to
///                 [CompareStringEx](../stringapiset/nf-stringapiset-comparestringex.md) or
///                 [LCMapStringEx](nf-winnls-lcmapstringex.md).<br> <br>LCMAP_SORTHANDLE requires that the output buffer be of size
///                 sizeof(lparam) | | **LCMAP_SORTKEY** | Produce a normalized sort key. If the LCMAP_SORTKEY flag is not specified,
///                 the function performs string mapping. For details of sort key generation and string mapping, see the Remarks
///                 section. | | **LCMAP_TITLECASE** | Windows 7:</b> Map all characters to title case, in which the first letter of
///                 each major word is capitalized. | | **LCMAP_TRADITIONAL_CHINESE** | Map simplified Chinese characters to
///                 traditional Chinese characters. This flag and LCMAP_SIMPLIFIED_CHINESE are mutually exclusive. | |
///                 **LCMAP_UPPERCASE** | For locales and scripts capable of handling uppercase and lowercase, map all characters to
///                 uppercase. | The following flags can be used alone, with one another, or with the LCMAP_SORTKEY and/or
///                 LCMAP_BYTEREV flags. However, they cannot be combined with the other flags listed above. <table> <tr>
///                 <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="NORM_IGNORENONSPACE"></a><a
///                 id="norm_ignorenonspace"></a><dl> <dt><b>NORM_IGNORENONSPACE</b></dt> </dl> </td> <td width="60%"> Ignore
///                 nonspacing characters. For many scripts (notably Latin scripts), NORM_IGNORENONSPACE coincides with
///                 LINGUISTIC_IGNOREDIACRITIC. <div class="alert"><b>Note</b> NORM_IGNORENONSPACE ignores any secondary distinction,
///                 whether it is a diacritic or not. Scripts for Korean, Japanese, Chinese, and Indic languages, among others, use
///                 this distinction for purposes other than diacritics. LINGUISTIC_IGNOREDIACRITIC causes the function to ignore
///                 only actual diacritics, instead of ignoring the second sorting weight.</div> <div> </div> </td> </tr> <tr> <td
///                 width="40%"><a id="NORM_IGNORESYMBOLS"></a><a id="norm_ignoresymbols"></a><dl> <dt><b>NORM_IGNORESYMBOLS</b></dt>
///                 </dl> </td> <td width="60%"> Ignore symbols and punctuation. </td> </tr> </table> The flags listed below are used
///                 only with the LCMAP_SORTKEY flag. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                 id="LINGUISTIC_IGNORECASE"></a><a id="linguistic_ignorecase"></a><dl> <dt><b>LINGUISTIC_IGNORECASE</b></dt> </dl>
///                 </td> <td width="60%"> Ignore case, as linguistically appropriate. </td> </tr> <tr> <td width="40%"><a
///                 id="LINGUISTIC_IGNOREDIACRITIC"></a><a id="linguistic_ignorediacritic"></a><dl>
///                 <dt><b>LINGUISTIC_IGNOREDIACRITIC</b></dt> </dl> </td> <td width="60%"> Ignore nonspacing characters, as
///                 linguistically appropriate. <div class="alert"><b>Note</b> This flag does not always produce predictable results
///                 when used with decomposed characters, that is, characters in which a base character and one or more nonspacing
///                 characters each have distinct code point values.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
///                 id="NORM_IGNORECASE"></a><a id="norm_ignorecase"></a><dl> <dt><b>NORM_IGNORECASE</b></dt> </dl> </td> <td
///                 width="60%"> Ignore case. For many scripts (notably Latin scripts), NORM_IGNORECASE coincides with
///                 LINGUISTIC_IGNORECASE. <div class="alert"><b>Note</b> NORM_IGNORECASE ignores any tertiary distinction, whether
///                 it is actually linguistic case or not. For example, in Arabic and Indic scripts, this flag distinguishes
///                 alternate forms of a character, but the differences do not correspond to linguistic case. LINGUISTIC_IGNORECASE
///                 causes the function to ignore only actual linguistic casing, instead of ignoring the third sorting weight.</div>
///                 <div> </div> <div class="alert"><b>Note</b> For double-byte character set (DBCS) locales, NORM_IGNORECASE has an
///                 effect on all Unicode characters as well as narrow (one-byte) characters, including Greek and Cyrillic
///                 characters.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="NORM_IGNOREKANATYPE"></a><a
///                 id="norm_ignorekanatype"></a><dl> <dt><b>NORM_IGNOREKANATYPE</b></dt> </dl> </td> <td width="60%"> Do not
///                 differentiate between hiragana and katakana characters. Corresponding hiragana and katakana characters compare as
///                 equal. </td> </tr> <tr> <td width="40%"><a id="NORM_IGNOREWIDTH"></a><a id="norm_ignorewidth"></a><dl>
///                 <dt><b>NORM_IGNOREWIDTH</b></dt> </dl> </td> <td width="60%"> Ignore the difference between half-width and
///                 full-width characters, for example, C a t == cat. The full-width form is a formatting distinction used in Chinese
///                 and Japanese scripts. </td> </tr> <tr> <td width="40%"><a id="NORM_LINGUISTIC_CASING"></a><a
///                 id="norm_linguistic_casing"></a><dl> <dt><b>NORM_LINGUISTIC_CASING</b></dt> </dl> </td> <td width="60%"> Use
///                 linguistic rules for casing, instead of file system rules (default). </td> </tr> <tr> <td width="40%"><a
///                 id="SORT_DIGITSASNUMBERS"></a><a id="sort_digitsasnumbers"></a><dl> <dt><b>SORT_DIGITSASNUMBERS</b></dt> </dl>
///                 </td> <td width="60%"> <b>Windows 7:</b> Treat digits as numbers during sorting, for example, sort "2" before
///                 "10". </td> </tr> <tr> <td width="40%"><a id="SORT_STRINGSORT"></a><a id="sort_stringsort"></a><dl>
///                 <dt><b>SORT_STRINGSORT</b></dt> </dl> </td> <td width="60%"> Treat punctuation the same as symbols. </td> </tr>
///                 </table>
///    lpSrcStr = Pointer to a source string that the function maps or uses for sort key generation. This string cannot have a size
///               of 0.
///    cchSrc = Size, in characters, of the source string indicated by <i>lpSrcStr</i>. The size of the source string can include
///             the terminating null character, but does not have to. If the terminating null character is included, the mapping
///             behavior of the function is not greatly affected because the terminating null character is considered to be
///             unsortable and always maps to itself. The application can set this parameter to any negative value to specify
///             that the source string is null-terminated. In this case, if <b>LCMapStringEx</b> is being used in its
///             string-mapping mode, the function calculates the string length itself, and null-terminates the mapped string
///             indicated by <i>lpDestStr</i>. The application cannot set this parameter to 0.
///    lpDestStr = Pointer to a buffer in which this function retrieves the mapped string or sort key. If the application specifies
///                LCMAP_SORTKEY, the function stores a sort key in the buffer as an opaque array of byte values that can include
///                embedded 0 bytes. <div class="alert"><b>Note</b> If the function fails, the destination buffer might contain
///                either partial results or no results at all. In this case, it is recommended for your application to consider any
///                results invalid.</div> <div> </div>
///    cchDest = Size, in characters, of the buffer indicated by <i>lpDestStr</i>. If the application is using the function for
///              string mapping, it supplies a character count for this parameter. If space for a terminating null character is
///              included in <i>cchSrc</i>, <i>cchDest</i> must also include space for a terminating null character. If the
///              application is using the function to generate a sort key, it supplies a byte count for the size. This byte count
///              must include space for the sort key 0x00 terminator. The application can set <i>cchDest</i> to 0. In this case,
///              the function does not use the <i>lpDestStr</i> parameter and returns the required buffer size for the mapped
///              string or sort key.
///    lpVersionInformation = Pointer to an NLSVERSIONINFOEX structure that contains the version information about the relevant NLS capability;
///                           usually retrieved from GetNLSVersionEx. **Windows Vista, Windows 7:** Reserved; must set to NULL.
///    lpReserved = Reserved; must be NULL.
///    sortHandle = Reserved; must be 0. > [!NOTE] > [CompareStringEx](../stringapiset/nf-stringapiset-comparestringex.md) and
///                 [LCMapStringEx](nf-winnls-lcmapstringex.md) can specify a sort handle (if the locale name is null). This use is
///                 discouraged for most apps.
///Returns:
///    Returns the number of characters or bytes in the translated string or sort key, including a terminating null
///    character, if successful. If the function succeeds and the value of <i>cchDest</i> is 0, the return value is the
///    size of the buffer required to hold the translated string or sort key, including a terminating null character if
///    the input was null terminated. This function returns 0 if it does not succeed. To get extended error information,
///    the application can call GetLastError, which can return one of the following error codes: <ul>
///    <li>ERROR_INSUFFICIENT_BUFFER. A supplied buffer size was not large enough, or it was incorrectly set to
///    <b>NULL</b>.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
int LCMapStringEx(const(PWSTR) lpLocaleName, uint dwMapFlags, const(PWSTR) lpSrcStr, int cchSrc, PWSTR lpDestStr, 
                  int cchDest, NLSVERSIONINFO* lpVersionInformation, void* lpReserved, LPARAM sortHandle);

///Determines if the specified locale name is valid for a locale that is installed or supported on the operating
///system.<div class="alert"><b>Note</b> An application running only on Windows Vista and later should call this
///function in preference to IsValidLocale to determine the validity of a supplemental locale.</div> <div> </div>
///Params:
///    lpLocaleName = Pointer to the locale name to validate.
///Returns:
///    Returns a nonzero value if the locale name is valid, or returns 0 for an invalid name.
///    
@DllImport("KERNEL32")
BOOL IsValidLocaleName(const(PWSTR) lpLocaleName);

///Enumerates calendar information for a locale specified by name.<div class="alert"><b>Note</b> The application should
///call this function in preference to EnumCalendarInfo or EnumCalendarInfoEx if designed to run only on Windows Vista
///and later.</div> <div> </div> <div class="alert"><b>Note</b> This function can enumerate data that changes between
///releases, for example, due to a custom locale. If your application must persist or transmit data, see Using
///Persistent Locale Data.</div> <div> </div>
///Params:
///    pCalInfoEnumProcExEx = Pointer to an application-defined callback function. For more information, see EnumCalendarInfoProcExEx.
///    lpLocaleName = Pointer to a locale name, or one of the following predefined values. <ul> <li> LOCALE_NAME_INVARIANT </li> <li>
///                   LOCALE_NAME_SYSTEM_DEFAULT </li> <li> LOCALE_NAME_USER_DEFAULT </li> </ul>
///    Calendar = Calendar identifier that specifies the calendar for which information is requested. Note that this identifier can
///               be ENUM_ALL_CALENDARS, to enumerate all calendars that are associated with the locale.
///    lpReserved = Reserved; must be <b>NULL</b>.
///    CalType = Type of calendar information. For more information, see Calendar Type Information. Only one calendar type can be
///              specified per call to this function, except where noted.
///    lParam = Application-provided parameter to pass to the callback function. This value is especially useful for
///             multi-threaded applications.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_FLAGS. The values
///    supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumCalendarInfoExEx(CALINFO_ENUMPROCEXEX pCalInfoEnumProcExEx, const(PWSTR) lpLocaleName, uint Calendar, 
                          const(PWSTR) lpReserved, uint CalType, LPARAM lParam);

///Enumerates the long date, short date, or year/month formats that are available for a locale specified by name.<div
///class="alert"><b>Note</b> The application should call this function in preference to EnumDateFormats or
///EnumDateFormatsEx if designed to run only on Windows Vista and later.</div> <div> </div> <div
///class="alert"><b>Note</b> This function can enumerate data that changes between releases, for example, due to a
///custom locale. If your application must persist or transmit data, see Using Persistent Locale Data.</div> <div>
///</div>
///Params:
///    lpDateFmtEnumProcExEx = Pointer to an application-defined callback function. For more information, see EnumDateFormatsProcExEx.
///    lpLocaleName = Pointer to a locale name, or one of the following predefined values. <ul> <li> LOCALE_NAME_INVARIANT </li> <li>
///                   LOCALE_NAME_SYSTEM_DEFAULT </li> <li> LOCALE_NAME_USER_DEFAULT </li> </ul>
///    dwFlags = Flag specifying date formats. The application can supply one of the following values or the LOCALE_USE_CP_ACP
///              constant. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DATE_SHORTDATE"></a><a
///              id="date_shortdate"></a><dl> <dt><b>DATE_SHORTDATE</b></dt> </dl> </td> <td width="60%"> Use short date formats.
///              This value cannot be used with any of the other flag values. </td> </tr> <tr> <td width="40%"><a
///              id="DATE_LONGDATE"></a><a id="date_longdate"></a><dl> <dt><b>DATE_LONGDATE</b></dt> </dl> </td> <td width="60%">
///              Use long date formats. This value cannot be used with any of the other flag values. </td> </tr> <tr> <td
///              width="40%"><a id="DATE_YEARMONTH"></a><a id="date_yearmonth"></a><dl> <dt><b>DATE_YEARMONTH</b></dt> </dl> </td>
///              <td width="60%"> Use year/month formats. This value cannot be used with any of the other flag values. </td> </tr>
///              <tr> <td width="40%"><a id="DATE_MONTHDAY"></a><a id="date_monthday"></a><dl> <dt><b>DATE_MONTHDAY</b></dt> </dl>
///              </td> <td width="60%"> Use month/day formats. This value cannot be used with any of the other flag values. </td>
///              </tr> </table>
///    lParam = An application-provided parameter to pass to the callback function. This value is especially useful for
///             multi-threaded applications.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_BADDB. The function could
///    not access the data. This situation should not normally occur, and typically indicates a bad installation, a disk
///    problem, or the like.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumDateFormatsExEx(DATEFMT_ENUMPROCEXEX lpDateFmtEnumProcExEx, const(PWSTR) lpLocaleName, uint dwFlags, 
                         LPARAM lParam);

///Enumerates the time formats that are available for a locale specified by name. <div class="alert"><b>Note</b> The
///application should call this function in preference to EnumTimeFormats if designed to run only on Windows Vista and
///later.</div><div> </div><div class="alert"><b>Note</b> This function can enumerate data that changes between
///releases, for example, due to a custom locale. If your application must persist or transmit data, see Using
///Persistent Locale Data.</div><div> </div>
///Params:
///    lpTimeFmtEnumProcEx = Pointer to an application-defined callback function. For more information, see EnumTimeFormatsProcEx.
///    lpLocaleName = Pointer to a locale name, or one of the following predefined values. <ul> <li> LOCALE_NAME_INVARIANT </li> <li>
///                   LOCALE_NAME_SYSTEM_DEFAULT </li> <li> LOCALE_NAME_USER_DEFAULT </li> </ul>
///    dwFlags = The time format. Set to 0 to use the current user's long time format, or TIME_NOSECONDS (starting with Windows 7)
///              to use the short time format.
///    lParam = An application-provided parameter to be passed to the callback function. This is especially useful for
///             multi-threaded applications.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_FLAGS. The values
///    supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumTimeFormatsEx(TIMEFMT_ENUMPROCEX lpTimeFmtEnumProcEx, const(PWSTR) lpLocaleName, uint dwFlags, 
                       LPARAM lParam);

///Enumerates the locales that are either installed on or supported by an operating system. <div
///class="alert"><b>Note</b> The application should call this function in preference to EnumSystemLocales if designed to
///run only on Windows Vista and later.</div><div> </div>
///Params:
///    lpLocaleEnumProcEx = Pointer to an application-defined callback function. The <b>EnumSystemLocalesEx</b> function enumerates locales
///                         by making repeated calls to this callback function. For more information, see EnumLocalesProcEx.
///    dwFlags = Flags identifying the locales to enumerate. The flags can be used singly or combined using a binary OR. If the
///              application specifies 0 for this parameter, the function behaves as for LOCALE_ALL. <ul> <li> LOCALE_ALL </li>
///              <li> LOCALE_ALTERNATE_SORTS; see Remarks</li> <li> LOCALE_NEUTRALDATA </li> <li> LOCALE_SUPPLEMENTAL </li> <li>
///              LOCALE_WINDOWS </li> </ul>
///    lParam = An application-provided parameter to be passed to the callback function. This is especially useful for
///             multi-threaded applications.
///    lpReserved = Reserved; must be <b>NULL</b>.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_BADDB. The function could
///    not access the data. This situation should not normally occur, and typically indicates a bad installation, a disk
///    problem, or the like.</li> <li>ERROR_INVALID_FLAGS. The values supplied for flags were not valid.</li>
///    <li>ERROR_INVALID_PARAMETER. Any of the parameter values was invalid.</li> </ul>
///    
@DllImport("KERNEL32")
BOOL EnumSystemLocalesEx(LOCALE_ENUMPROCEX lpLocaleEnumProcEx, uint dwFlags, LPARAM lParam, void* lpReserved);

///Finds a possible locale name match for the supplied name.
///Params:
///    lpNameToResolve = Pointer to a name to resolve, for example, "en-XA" for English (Private Use).
///    lpLocaleName = Pointer to a buffer in which this function retrieves the locale name that is the match for the input name. For
///                   example, the match for the name "en-XA" is "en-US" for English (United States). <div class="alert"><b>Note</b> If
///                   the function fails, the state of the output buffer is not guaranteed to be accurate. In this case, the
///                   application should check the return value and error status set by the function to determine the correct course of
///                   action.</div> <div> </div>
///    cchLocaleName = Size, in characters, of the buffer indicated by <i>lpLocaleName</i>. The maximum possible length of a locale
///                    name, including a terminating null character, is the value of LOCALE_NAME_MAX_LENGTH. This is the recommended
///                    size to supply in this parameter.
///Returns:
///    Returns the size of the buffer containing the locale name, including the terminating null character, if
///    successful. The function returns 0 if it does not succeed. To get extended error information, the application can
///    call GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INSUFFICIENT_BUFFER. A
///    supplied buffer size was not large enough, or it was incorrectly set to <b>NULL</b>.</li> </ul>
///    
@DllImport("KERNEL32")
int ResolveLocaleName(const(PWSTR) lpNameToResolve, PWSTR lpLocaleName, int cchLocaleName);

///Installs an IME.
///Params:
///    lpszIMEFileName = Pointer to a null-terminated string that specifies the full path of the IME.
///    lpszLayoutText = Pointer to a null-terminated string that specifies the name of the IME and the associated layout text.
///Returns:
///    Returns the input locale identifier for the IME.
///    
@DllImport("IMM32")
HKL ImmInstallIMEA(const(PSTR) lpszIMEFileName, const(PSTR) lpszLayoutText);

///Installs an IME.
///Params:
///    lpszIMEFileName = Pointer to a null-terminated string that specifies the full path of the IME.
///    lpszLayoutText = Pointer to a null-terminated string that specifies the name of the IME and the associated layout text.
///Returns:
///    Returns the input locale identifier for the IME.
///    
@DllImport("IMM32")
HKL ImmInstallIMEW(const(PWSTR) lpszIMEFileName, const(PWSTR) lpszLayoutText);

///Retrieves the default window handle to the IME class.
///Params:
///    HWND = Handle to the window.
///Returns:
///    Returns the default window handle to the IME class if successful, or <b>NULL</b> otherwise.
///    
@DllImport("IMM32")
HWND ImmGetDefaultIMEWnd(HWND param0);

///Copies the description of the IME to the specified buffer.
///Params:
///    HKL = Input locale identifier.
///    lpszDescription = Pointer to a buffer in which the function retrieves the null-terminated string describing the IME.
///    uBufLen = Size, in characters, of the output buffer. The application sets this parameter to 0 if the function is to return
///              the buffer size needed for the complete description, excluding the terminating null character. <b>Windows NT,
///              Windows 2000, Windows XP:</b> The size of the buffer is in Unicode characters, each consisting of two bytes. If
///              the parameter is set to 0, the function returns the size of the buffer required in Unicode characters, excluding
///              the Unicode terminating null character.
///Returns:
///    Returns the number of characters copied to the output buffer. If the application sets the <i>uBufLen</i>
///    parameter to 0, the function returns the size of the buffer required to receive the description. Neither value
///    includes the terminating null character. For Unicode, the function returns the number of Unicode characters, not
///    including the Unicode terminating null character.
///    
@DllImport("IMM32")
uint ImmGetDescriptionA(HKL param0, PSTR lpszDescription, uint uBufLen);

///Copies the description of the IME to the specified buffer.
///Params:
///    HKL = Input locale identifier.
///    lpszDescription = Pointer to a buffer in which the function retrieves the null-terminated string describing the IME.
///    uBufLen = Size, in characters, of the output buffer. The application sets this parameter to 0 if the function is to return
///              the buffer size needed for the complete description, excluding the terminating null character. <b>Windows NT,
///              Windows 2000, Windows XP:</b> The size of the buffer is in Unicode characters, each consisting of two bytes. If
///              the parameter is set to 0, the function returns the size of the buffer required in Unicode characters, excluding
///              the Unicode terminating null character.
///Returns:
///    Returns the number of characters copied to the output buffer. If the application sets the <i>uBufLen</i>
///    parameter to 0, the function returns the size of the buffer required to receive the description. Neither value
///    includes the terminating null character. For Unicode, the function returns the number of Unicode characters, not
///    including the Unicode terminating null character.
///    
@DllImport("IMM32")
uint ImmGetDescriptionW(HKL param0, PWSTR lpszDescription, uint uBufLen);

///Retrieves the file name of the IME associated with the specified input locale.
///Params:
///    HKL = Input locale identifier.
///    lpszFileName = Pointer to a buffer in which the function retrieves the file name. This parameter contains <b>NULL</b> when
///                   <i>uBufLen</i> is set to <b>NULL</b>.
///    uBufLen = Size, in bytes, of the output buffer. The application specifies 0 if the function is to return the buffer size
///              needed to receive the file name, not including the terminating null character. For Unicode, <i>uBufLen</i>
///              specifies the size in Unicode characters, not including the terminating null character.
///Returns:
///    Returns the number of bytes in the file name copied to the output buffer. If the application sets <i>uBufLen</i>
///    to 0, the function returns the size of the buffer required for the file name. In either case, the terminating
///    null character is not included. For Unicode, the function returns the number of Unicode characters copied into
///    the output buffer, not including the Unicode terminating null character.
///    
@DllImport("IMM32")
uint ImmGetIMEFileNameA(HKL param0, PSTR lpszFileName, uint uBufLen);

///Retrieves the file name of the IME associated with the specified input locale.
///Params:
///    HKL = Input locale identifier.
///    lpszFileName = Pointer to a buffer in which the function retrieves the file name. This parameter contains <b>NULL</b> when
///                   <i>uBufLen</i> is set to <b>NULL</b>.
///    uBufLen = Size, in bytes, of the output buffer. The application specifies 0 if the function is to return the buffer size
///              needed to receive the file name, not including the terminating null character. For Unicode, <i>uBufLen</i>
///              specifies the size in Unicode characters, not including the terminating null character.
///Returns:
///    Returns the number of bytes in the file name copied to the output buffer. If the application sets <i>uBufLen</i>
///    to 0, the function returns the size of the buffer required for the file name. In either case, the terminating
///    null character is not included. For Unicode, the function returns the number of Unicode characters copied into
///    the output buffer, not including the Unicode terminating null character.
///    
@DllImport("IMM32")
uint ImmGetIMEFileNameW(HKL param0, PWSTR lpszFileName, uint uBufLen);

///Retrieves the property and capabilities of the IME associated with the specified input locale.
///Params:
///    HKL = Input locale identifier.
///    DWORD = Type of property information to retrieve. This parameter can have one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IGP_CONVERSION"></a><a
///            id="igp_conversion"></a><dl> <dt><b>IGP_CONVERSION</b></dt> </dl> </td> <td width="60%"> Conversion capabilities.
///            </td> </tr> <tr> <td width="40%"><a id="IGP_GETIMEVERSION"></a><a id="igp_getimeversion"></a><dl>
///            <dt><b>IGP_GETIMEVERSION</b></dt> </dl> </td> <td width="60%"> System version number for which the specified IME
///            was created. </td> </tr> <tr> <td width="40%"><a id="IGP_PROPERTY"></a><a id="igp_property"></a><dl>
///            <dt><b>IGP_PROPERTY</b></dt> </dl> </td> <td width="60%"> Property information. </td> </tr> <tr> <td
///            width="40%"><a id="IGP_SELECT"></a><a id="igp_select"></a><dl> <dt><b>IGP_SELECT</b></dt> </dl> </td> <td
///            width="60%"> Selection inheritance capabilities. </td> </tr> <tr> <td width="40%"><a id="IGP_SENTENCE"></a><a
///            id="igp_sentence"></a><dl> <dt><b>IGP_SENTENCE</b></dt> </dl> </td> <td width="60%"> Sentence mode capabilities.
///            </td> </tr> <tr> <td width="40%"><a id="IGP_SETCOMPSTR"></a><a id="igp_setcompstr"></a><dl>
///            <dt><b>IGP_SETCOMPSTR</b></dt> </dl> </td> <td width="60%"> Composition string capabilities. </td> </tr> <tr> <td
///            width="40%"><a id="IGP_UI"></a><a id="igp_ui"></a><dl> <dt><b>IGP_UI</b></dt> </dl> </td> <td width="60%"> User
///            interface capabilities. </td> </tr> </table>
///Returns:
///    Returns the property or capability value, depending on the value of the <i>dwIndex</i> parameter. If
///    <i>dwIndex</i> is set to IGP_PROPERTY, the function returns one or more of the following values: <table> <tr>
///    <th>Value</th> <th>Meaning</th> </tr> <tr> <td>IME_PROP_AT_CARET</td> <td>If set, conversion window is at the
///    caret position. If clear, the window is near the caret position.</td> </tr> <tr> <td>IME_PROP_SPECIAL_UI</td>
///    <td>If set, the IME has a nonstandard user interface. The application should not draw in the IME window.</td>
///    </tr> <tr> <td>IME_PROP_CANDLIST_START_FROM_1</td> <td>If set, strings in the candidate list are numbered
///    starting at 1. If clear, strings start at 0.</td> </tr> <tr> <td>IME_PROP_UNICODE</td> <td>If set, the IME is
///    viewed as a Unicode IME. The operating system and the IME communicate through the Unicode IME interface. If
///    clear, the IME uses the ANSI interface to communicate with the operating system.</td> </tr> <tr>
///    <td>IME_PROP_COMPLETE_ON_UNSELECT</td> <td>If set, the IME completes the composition string when the IME is
///    deactivated. If clear, the IME cancels the composition string when the IME is deactivated, for example, from a
///    keyboard layout change.</td> </tr> <tr> <td>IME_PROP_ACCEPT_WIDE_VKEY</td> <td>If set, the IME processes the
///    injected Unicode that came from the SendInput function by using VK_PACKET. If clear, the IME might not process
///    the injected Unicode, and might send the injected Unicode to the application directly.</td> </tr> </table> If
///    <i>dwIndex</i> is set to IGP_UI, the function returns one or more of the following values: <table> <tr>
///    <th>Value</th> <th>Meaning</th> </tr> <tr> <td>UI_CAP_2700</td> <td>Support text escapement values of 0 or 2700.
///    For more information, see the <b>lfEscapement</b> member of the LOGFONT structure.</td> </tr> <tr>
///    <td>UI_CAP_ROT90</td> <td>Support text escapement values of 0, 900, 1800, or 2700. For more information, see
///    <b>lfEscapement</b>.</td> </tr> <tr> <td>UI_CAP_ROTANY</td> <td>Support any text escapement value. For more
///    information, see <b>lfEscapement</b>.</td> </tr> </table> If <i>dwIndex</i> is set to IGP_SETCOMPSTR, the
///    function returns one or more of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///    <td>SCS_CAP_COMPSTR</td> <td>Create the composition string by calling the ImmSetCompositionString function with
///    the SCS_SETSTR value.</td> </tr> <tr> <td>SCS_CAP_MAKEREAD</td> <td>Create the reading string from corresponding
///    composition string when using the ImmSetCompositionString function with SCS_SETSTR and without setting
///    <i>lpRead</i>.</td> </tr> <tr> <td>SCS_CAP_SETRECONVERTSTRING:</td> <td>This IME can support reconversion. Use
///    ImmSetCompositionString to do reconversion.</td> </tr> </table> If <i>dwIndex</i> is set to IGP_SELECT, the
///    function returns one or more of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///    <td>SELECT_CAP_CONVMODE</td> <td>Inherit conversion mode when a new IME is selected.</td> </tr> <tr>
///    <td>SELECT_CAP_SENTENCE</td> <td>Inherit sentence mode when a new IME is selected.</td> </tr> </table> If
///    <i>dwIndex</i> is set to IGP_GETIMEVERSION, the function returns one or more of the following values: <table>
///    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>IMEVER_0310</td> <td>The IME was created for Windows
///    3.1.</td> </tr> <tr> <td>IMEVER_0400</td> <td>The IME was created for Windows Me/98/95.</td> </tr> </table>
///    
@DllImport("IMM32")
uint ImmGetProperty(HKL param0, uint param1);

///Determines if the specified input locale has an IME.
///Params:
///    HKL = Input locale identifier.
///Returns:
///    Returns a nonzero value if the specified locale has an IME, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmIsIME(HKL param0);

///Simulates the specified IME hot key, causing the same response as if the user presses the hot key in the specified
///window.
///Params:
///    HWND = Handle to the window.
///    DWORD = Identifier of the IME hot key. For more information, see IME Hot Key Identifiers.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmSimulateHotKey(HWND param0, uint param1);

///Creates a new input context, allocating memory for the context and initializing it. An application calls this
///function to prepare its own input context.
///Returns:
///    Returns the handle to the new input context if successful, or <b>NULL</b> otherwise.
///    
@DllImport("IMM32")
HIMC__* ImmCreateContext();

///Releases the input context and frees associated memory.
///Params:
///    HIMC = Handle to the input context to free.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmDestroyContext(HIMC__* param0);

///Returns the input context associated with the specified window.
///Params:
///    HWND = Handle to the window for which to retrieve the input context.
///Returns:
///    Returns the handle to the input context.
///    
@DllImport("IMM32")
HIMC__* ImmGetContext(HWND param0);

///Releases the input context and unlocks the memory associated in the input context. An application must call this
///function for each call to the ImmGetContext function.
///Params:
///    HWND = Handle to the window for which the input context was previously retrieved.
///    HIMC = Handle to the input context.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmReleaseContext(HWND param0, HIMC__* param1);

///Associates the specified input context with the specified window. By default, the operating system associates the
///default input context with each window as it is created. <div class="alert"><b>Note</b> To specify a type of
///association, the application should use the ImmAssociateContextEx function.</div><div> </div>
///Params:
///    HWND = Handle to the window to associate with the input context.
///    HIMC = Handle to the input context. If <i>hIMC</i> is <b>NULL</b>, the function removes any association the window has
///           with an input context. Thus IME cannot be used in the window.
///Returns:
///    Returns the handle to the input context previously associated with the window.
///    
@DllImport("IMM32")
HIMC__* ImmAssociateContext(HWND param0, HIMC__* param1);

///Changes the association between the input method context and the specified window or its children.
///Params:
///    arg1 = Handle to the window to associate with the input context.
///    arg2 = Handle to the input method context.
///    arg3 = Flags specifying the type of association between the window and the input method context. This parameter can have
///           one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///           id="IACE_CHILDREN"></a><a id="iace_children"></a><dl> <dt><b>IACE_CHILDREN</b></dt> </dl> </td> <td width="60%">
///           Associate the input method context to the child windows of the specified window only. </td> </tr> <tr> <td
///           width="40%"><a id="IACE_DEFAULT"></a><a id="iace_default"></a><dl> <dt><b>IACE_DEFAULT</b></dt> </dl> </td> <td
///           width="60%"> Restore the default input method context of the window. </td> </tr> <tr> <td width="40%"><a
///           id="IACE_IGNORENOCONTEXT"></a><a id="iace_ignorenocontext"></a><dl> <dt><b>IACE_IGNORENOCONTEXT</b></dt> </dl>
///           </td> <td width="60%"> Do not associate the input method context with windows that are not associated with any
///           input method context. </td> </tr> </table>
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise.
///    
@DllImport("IMM32")
BOOL ImmAssociateContextEx(HWND param0, HIMC__* param1, uint param2);

///Retrieves information about the composition string.
///Params:
///    HIMC = Handle to the input context.
///    DWORD = Index of the information to retrieve, which is one of the values specified in IME Composition String Values. For
///            each value except GCS_CURSORPOS and GCS_DELTASTART, the function copies the requested information to the output
///            buffer. The function returns the cursor and delta position values in the low 16 bits of the return value.
///    lpBuf = Pointer to a buffer in which the function retrieves the composition string information.
///    dwBufLen = Size, in bytes, of the output buffer, even if the output is a Unicode string. The application sets this parameter
///               to 0 if the function is to return the size of the required output buffer.
///Returns:
///    Returns the number of bytes copied to the output buffer. If <i>dwBufLen</i> is set to 0, the function returns the
///    buffer size, in bytes, required to receive all requested information, excluding the terminating null character.
///    The return value is always the size, in bytes, even if the requested data is a Unicode string. This function
///    returns one of the following negative error codes if it does not succeed: <ul> <li>IMM_ERROR_NODATA. Composition
///    data is not ready in the input context.</li> <li>IMM_ERROR_GENERAL. General error detected by IME.</li> </ul>
///    
@DllImport("IMM32")
int ImmGetCompositionStringA(HIMC__* param0, uint param1, void* lpBuf, uint dwBufLen);

///Retrieves information about the composition string.
///Params:
///    HIMC = Handle to the input context.
///    DWORD = Index of the information to retrieve, which is one of the values specified in IME Composition String Values. For
///            each value except GCS_CURSORPOS and GCS_DELTASTART, the function copies the requested information to the output
///            buffer. The function returns the cursor and delta position values in the low 16 bits of the return value.
///    lpBuf = Pointer to a buffer in which the function retrieves the composition string information.
///    dwBufLen = Size, in bytes, of the output buffer, even if the output is a Unicode string. The application sets this parameter
///               to 0 if the function is to return the size of the required output buffer.
///Returns:
///    Returns the number of bytes copied to the output buffer. If <i>dwBufLen</i> is set to 0, the function returns the
///    buffer size, in bytes, required to receive all requested information, excluding the terminating null character.
///    The return value is always the size, in bytes, even if the requested data is a Unicode string. This function
///    returns one of the following negative error codes if it does not succeed: <ul> <li>IMM_ERROR_NODATA. Composition
///    data is not ready in the input context.</li> <li>IMM_ERROR_GENERAL. General error detected by IME.</li> </ul>
///    
@DllImport("IMM32")
int ImmGetCompositionStringW(HIMC__* param0, uint param1, void* lpBuf, uint dwBufLen);

///Sets the characters, attributes, and clauses of the composition and reading strings.
///Params:
///    HIMC = Handle to the input context.
///    dwIndex = Type of information to set. This parameter can have one of the following values. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SCS_SETSTR"></a><a id="scs_setstr"></a><dl>
///              <dt><b>SCS_SETSTR</b></dt> </dl> </td> <td width="60%"> Set the composition string, the reading string, or both.
///              At least one of the <i>lpComp</i> and <i>lpRead</i> parameters must indicate a valid string. If either string is
///              too long, the IME truncates it. </td> </tr> <tr> <td width="40%"><a id="SCS_CHANGEATTR"></a><a
///              id="scs_changeattr"></a><dl> <dt><b>SCS_CHANGEATTR</b></dt> </dl> </td> <td width="60%"> Set attributes for the
///              composition string, the reading string, or both. At least one of the <i>lpComp</i> and <i>lpRead</i> parameters
///              must indicate a valid attribute array. </td> </tr> <tr> <td width="40%"><a id="SCS_CHANGECLAUSE"></a><a
///              id="scs_changeclause"></a><dl> <dt><b>SCS_CHANGECLAUSE</b></dt> </dl> </td> <td width="60%"> Set the clause
///              information for the composition string, the reading string, or both. At least one of the <i>lpComp</i> and
///              <i>lpRead</i> parameters must point to a valid clause information array. </td> </tr> <tr> <td width="40%"><a
///              id="SCS_SETRECONVERTSTRING"></a><a id="scs_setreconvertstring"></a><dl> <dt><b>SCS_SETRECONVERTSTRING</b></dt>
///              </dl> </td> <td width="60%"> <b>Windows Me/98, Windows 2000, Windows XP:</b> Ask IME to reconvert the string
///              using a specified RECONVERTSTRING structure. </td> </tr> <tr> <td width="40%"><a
///              id="SCS_QUERYRECONVERTSTRING"></a><a id="scs_queryreconvertstring"></a><dl>
///              <dt><b>SCS_QUERYRECONVERTSTRING</b></dt> </dl> </td> <td width="60%"> <b>Windows Me/98, Windows 2000, Windows
///              XP:</b> Ask IME to adjust the RECONVERTSTRING structure. Then the application can pass the adjusted structure
///              into this function using SCS_SETRECONVERTSTRING. IME does not generate any WM_IME_COMPOSITION messages. </td>
///              </tr> </table>
///    lpComp = Pointer to a buffer containing the information to set for the composition string, as specified by the value of
///             <i>dwIndex</i>.
///    dwCompLen = Size, in bytes, of the information buffer for the composition string, even if SCS_SETSTR is specified and the
///                buffer contains a Unicode string.
///    lpRead = Pointer to a buffer containing the information to set for the reading string, as specified by the value of
///             <i>dwIndex</i>. The application can set this parameter to <b>NULL</b>.
///    dwReadLen = Size, in bytes, of the information buffer for the reading string, even if SCS_SETSTR is specified and the buffer
///                contains a Unicode string.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmSetCompositionStringA(HIMC__* param0, uint dwIndex, void* lpComp, uint dwCompLen, void* lpRead, 
                              uint dwReadLen);

///Sets the characters, attributes, and clauses of the composition and reading strings.
///Params:
///    HIMC = Handle to the input context.
///    dwIndex = Type of information to set. This parameter can have one of the following values. <table> <tr> <th>Value</th>
///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SCS_SETSTR"></a><a id="scs_setstr"></a><dl>
///              <dt><b>SCS_SETSTR</b></dt> </dl> </td> <td width="60%"> Set the composition string, the reading string, or both.
///              At least one of the <i>lpComp</i> and <i>lpRead</i> parameters must indicate a valid string. If either string is
///              too long, the IME truncates it. </td> </tr> <tr> <td width="40%"><a id="SCS_CHANGEATTR"></a><a
///              id="scs_changeattr"></a><dl> <dt><b>SCS_CHANGEATTR</b></dt> </dl> </td> <td width="60%"> Set attributes for the
///              composition string, the reading string, or both. At least one of the <i>lpComp</i> and <i>lpRead</i> parameters
///              must indicate a valid attribute array. </td> </tr> <tr> <td width="40%"><a id="SCS_CHANGECLAUSE"></a><a
///              id="scs_changeclause"></a><dl> <dt><b>SCS_CHANGECLAUSE</b></dt> </dl> </td> <td width="60%"> Set the clause
///              information for the composition string, the reading string, or both. At least one of the <i>lpComp</i> and
///              <i>lpRead</i> parameters must point to a valid clause information array. </td> </tr> <tr> <td width="40%"><a
///              id="SCS_SETRECONVERTSTRING"></a><a id="scs_setreconvertstring"></a><dl> <dt><b>SCS_SETRECONVERTSTRING</b></dt>
///              </dl> </td> <td width="60%"> <b>Windows Me/98, Windows 2000, Windows XP:</b> Ask IME to reconvert the string
///              using a specified RECONVERTSTRING structure. </td> </tr> <tr> <td width="40%"><a
///              id="SCS_QUERYRECONVERTSTRING"></a><a id="scs_queryreconvertstring"></a><dl>
///              <dt><b>SCS_QUERYRECONVERTSTRING</b></dt> </dl> </td> <td width="60%"> <b>Windows Me/98, Windows 2000, Windows
///              XP:</b> Ask IME to adjust the RECONVERTSTRING structure. Then the application can pass the adjusted structure
///              into this function using SCS_SETRECONVERTSTRING. IME does not generate any WM_IME_COMPOSITION messages. </td>
///              </tr> </table>
///    lpComp = Pointer to a buffer containing the information to set for the composition string, as specified by the value of
///             <i>dwIndex</i>.
///    dwCompLen = Size, in bytes, of the information buffer for the composition string, even if SCS_SETSTR is specified and the
///                buffer contains a Unicode string.
///    lpRead = Pointer to a buffer containing the information to set for the reading string, as specified by the value of
///             <i>dwIndex</i>. The application can set this parameter to <b>NULL</b>.
///    dwReadLen = Size, in bytes, of the information buffer for the reading string, even if SCS_SETSTR is specified and the buffer
///                contains a Unicode string.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmSetCompositionStringW(HIMC__* param0, uint dwIndex, void* lpComp, uint dwCompLen, void* lpRead, 
                              uint dwReadLen);

///Retrieves the size of the candidate lists.
///Params:
///    HIMC = Handle to the input context.
///    lpdwListCount = Pointer to the buffer in which this function retrieves the size of the candidate lists.
///Returns:
///    Returns the number of bytes required for all candidate lists if successful, or 0 otherwise.
///    
@DllImport("IMM32")
uint ImmGetCandidateListCountA(HIMC__* param0, uint* lpdwListCount);

///Retrieves the size of the candidate lists.
///Params:
///    HIMC = Handle to the input context.
///    lpdwListCount = Pointer to the buffer in which this function retrieves the size of the candidate lists.
///Returns:
///    Returns the number of bytes required for all candidate lists if successful, or 0 otherwise.
///    
@DllImport("IMM32")
uint ImmGetCandidateListCountW(HIMC__* param0, uint* lpdwListCount);

///Retrieves a candidate list.
///Params:
///    HIMC = Handle to the input context.
///    deIndex = Zero-based index of the candidate list.
///    lpCandList = Pointer to a CANDIDATELIST structure in which the function retrieves the candidate list.
///    dwBufLen = Size, in bytes, of the buffer to receive the candidate list. The application can specify 0 for this parameter if
///               the function is to return the required size of the output buffer only.
///Returns:
///    Returns the number of bytes copied to the candidate list buffer if successful. If the application has supplied 0
///    for the <i>dwBufLen</i> parameter, the function returns the size required for the candidate list buffer. The
///    function returns 0 if it does not succeed.
///    
@DllImport("IMM32")
uint ImmGetCandidateListA(HIMC__* param0, uint deIndex, CANDIDATELIST* lpCandList, uint dwBufLen);

///Retrieves a candidate list.
///Params:
///    HIMC = Handle to the input context.
///    deIndex = Zero-based index of the candidate list.
///    lpCandList = Pointer to a CANDIDATELIST structure in which the function retrieves the candidate list.
///    dwBufLen = Size, in bytes, of the buffer to receive the candidate list. The application can specify 0 for this parameter if
///               the function is to return the required size of the output buffer only.
///Returns:
///    Returns the number of bytes copied to the candidate list buffer if successful. If the application has supplied 0
///    for the <i>dwBufLen</i> parameter, the function returns the size required for the candidate list buffer. The
///    function returns 0 if it does not succeed.
///    
@DllImport("IMM32")
uint ImmGetCandidateListW(HIMC__* param0, uint deIndex, CANDIDATELIST* lpCandList, uint dwBufLen);

///Retrieves information about errors. Applications use the information for user notifications.
///Params:
///    arg1 = Handle to the input context.
///    dwIndex = Type of guideline information to retrieve. This parameter can have one of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="GGL_LEVEL"></a><a id="ggl_level"></a><dl>
///              <dt><b>GGL_LEVEL</b></dt> </dl> </td> <td width="60%"> Return the error level. </td> </tr> <tr> <td
///              width="40%"><a id="GGL_INDEX"></a><a id="ggl_index"></a><dl> <dt><b>GGL_INDEX</b></dt> </dl> </td> <td
///              width="60%"> Return the error index. </td> </tr> <tr> <td width="40%"><a id="GGL_STRING"></a><a
///              id="ggl_string"></a><dl> <dt><b>GGL_STRING</b></dt> </dl> </td> <td width="60%"> Return the error message string.
///              </td> </tr> <tr> <td width="40%"><a id="GGL_PRIVATE"></a><a id="ggl_private"></a><dl> <dt><b>GGL_PRIVATE</b></dt>
///              </dl> </td> <td width="60%"> Return information about reverse conversion. </td> </tr> </table>
///    lpBuf = Pointer to a buffer in which the function retrieves the error message string. This parameter contains <b>NULL</b>
///            if <i>dwIndex</i> is not GGL_STRING or GGL_PRIVATE or if <i>dwBufLen</i> is set to 0.
///    dwBufLen = Size, in bytes, of the output buffer. The application sets this parameter to 0 if the function is to return the
///               buffer size needed to receive the error message string, not including the terminating null character.
///Returns:
///    Returns an error level, an error index, or the size of an error message string, depending on the value of the
///    <i>dwIndex</i> parameter. If <i>dwIndex</i> is GGL_LEVEL, the return is one of the following values. <table> <tr>
///    <th>Value</th> <th>Meaning</th> </tr> <tr> <td>GL_LEVEL_ERROR</td> <td>Error. The IME might not be able to
///    continue.</td> </tr> <tr> <td>GL_LEVEL_FATAL</td> <td>Fatal error. The IME cannot continue, and data might be
///    lost.</td> </tr> <tr> <td>GL_LEVEL_INFORMATION</td> <td>No error. Information is available for the user.</td>
///    </tr> <tr> <td>GL_LEVEL_NOGUIDELINE</td> <td>No error. Remove previous error message if still visible.</td> </tr>
///    <tr> <td>GL_LEVEL_WARNING</td> <td>Unexpected input or other result. The user should be warned, but the IME can
///    continue.</td> </tr> </table> If <i>dwIndex</i> is GGL_INDEX, the return value is one of the following values.
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>GL_ID_CANNOTSAVE</td> <td>The dictionary or the
///    statistics data cannot be saved.</td> </tr> <tr> <td>GL_ID_NOCONVERT</td> <td>The IME cannot convert any
///    more.</td> </tr> <tr> <td>GL_ID_NODICTIONARY</td> <td>The IME cannot find the dictionary, or the dictionary has
///    an unexpected format.</td> </tr> <tr> <td>GL_ID_NOMODULE</td> <td>The IME cannot find the module that is
///    needed.</td> </tr> <tr> <td>GL_ID_READINGCONFLICT</td> <td>A reading conflict occurred. For example, some vowels
///    cannot be put together to form one character.</td> </tr> <tr> <td>GL_ID_TOOMANYSTROKE</td> <td>There are too many
///    strokes for one character or one clause.</td> </tr> <tr> <td>GL_ID_TYPINGERROR</td> <td>Typing error. The IME
///    cannot handle this typing.</td> </tr> <tr> <td>GL_ID_UNKNOWN</td> <td>Unknown error. Refer to the error message
///    string.</td> </tr> <tr> <td>GL_ID_INPUTREADING</td> <td>The IME is accepting reading character input from the end
///    user.</td> </tr> <tr> <td>GL_ID_INPUTRADICAL</td> <td>The IME is accepting radical character input from the end
///    user.</td> </tr> <tr> <td>GL_ID_INPUTCODE</td> <td>The IME is accepting character code input from the end
///    user.</td> </tr> <tr> <td>GL_ID_CHOOSECANDIDATE</td> <td>The IME is accepting candidate string selection from the
///    end user.</td> </tr> <tr> <td>GL_ID_REVERSECONVERSION</td> <td>Information about reverse conversion is available
///    by calling <b>ImmGetGuideLine</b>, specifying GGL_PRIVATE. The information retrieved is in CANDIDATELIST
///    format.</td> </tr> </table> If <i>dwIndex</i> is GGL_STRING, the return value is the number of bytes of the
///    string copied to the buffer. However, if <i>dwBufLen</i> is 0, the return value is the buffer size needed to
///    receive the string, not including the terminating null character. For Unicode, if <i>dwBufLen</i> is 0, the
///    return value is the size, in bytes not including the Unicode terminating null character. If <i>dwIndex</i> is
///    GGL_PRIVATE, the return value is the number of bytes of information copied to the buffer. If <i>dwIndex</i> is
///    GGL_PRIVATE and <i>dwBufLen</i> is 0, the return value is the buffer size needed to receive the information.
///    
@DllImport("IMM32")
uint ImmGetGuideLineA(HIMC__* param0, uint dwIndex, PSTR lpBuf, uint dwBufLen);

///Retrieves information about errors. Applications use the information for user notifications.
///Params:
///    arg1 = Handle to the input context.
///    dwIndex = Type of guideline information to retrieve. This parameter can have one of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="GGL_LEVEL"></a><a id="ggl_level"></a><dl>
///              <dt><b>GGL_LEVEL</b></dt> </dl> </td> <td width="60%"> Return the error level. </td> </tr> <tr> <td
///              width="40%"><a id="GGL_INDEX"></a><a id="ggl_index"></a><dl> <dt><b>GGL_INDEX</b></dt> </dl> </td> <td
///              width="60%"> Return the error index. </td> </tr> <tr> <td width="40%"><a id="GGL_STRING"></a><a
///              id="ggl_string"></a><dl> <dt><b>GGL_STRING</b></dt> </dl> </td> <td width="60%"> Return the error message string.
///              </td> </tr> <tr> <td width="40%"><a id="GGL_PRIVATE"></a><a id="ggl_private"></a><dl> <dt><b>GGL_PRIVATE</b></dt>
///              </dl> </td> <td width="60%"> Return information about reverse conversion. </td> </tr> </table>
///    lpBuf = Pointer to a buffer in which the function retrieves the error message string. This parameter contains <b>NULL</b>
///            if <i>dwIndex</i> is not GGL_STRING or GGL_PRIVATE or if <i>dwBufLen</i> is set to 0.
///    dwBufLen = Size, in bytes, of the output buffer. The application sets this parameter to 0 if the function is to return the
///               buffer size needed to receive the error message string, not including the terminating null character.
///Returns:
///    Returns an error level, an error index, or the size of an error message string, depending on the value of the
///    <i>dwIndex</i> parameter. If <i>dwIndex</i> is GGL_LEVEL, the return is one of the following values. <table> <tr>
///    <th>Value</th> <th>Meaning</th> </tr> <tr> <td>GL_LEVEL_ERROR</td> <td>Error. The IME might not be able to
///    continue.</td> </tr> <tr> <td>GL_LEVEL_FATAL</td> <td>Fatal error. The IME cannot continue, and data might be
///    lost.</td> </tr> <tr> <td>GL_LEVEL_INFORMATION</td> <td>No error. Information is available for the user.</td>
///    </tr> <tr> <td>GL_LEVEL_NOGUIDELINE</td> <td>No error. Remove previous error message if still visible.</td> </tr>
///    <tr> <td>GL_LEVEL_WARNING</td> <td>Unexpected input or other result. The user should be warned, but the IME can
///    continue.</td> </tr> </table> If <i>dwIndex</i> is GGL_INDEX, the return value is one of the following values.
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>GL_ID_CANNOTSAVE</td> <td>The dictionary or the
///    statistics data cannot be saved.</td> </tr> <tr> <td>GL_ID_NOCONVERT</td> <td>The IME cannot convert any
///    more.</td> </tr> <tr> <td>GL_ID_NODICTIONARY</td> <td>The IME cannot find the dictionary, or the dictionary has
///    an unexpected format.</td> </tr> <tr> <td>GL_ID_NOMODULE</td> <td>The IME cannot find the module that is
///    needed.</td> </tr> <tr> <td>GL_ID_READINGCONFLICT</td> <td>A reading conflict occurred. For example, some vowels
///    cannot be put together to form one character.</td> </tr> <tr> <td>GL_ID_TOOMANYSTROKE</td> <td>There are too many
///    strokes for one character or one clause.</td> </tr> <tr> <td>GL_ID_TYPINGERROR</td> <td>Typing error. The IME
///    cannot handle this typing.</td> </tr> <tr> <td>GL_ID_UNKNOWN</td> <td>Unknown error. Refer to the error message
///    string.</td> </tr> <tr> <td>GL_ID_INPUTREADING</td> <td>The IME is accepting reading character input from the end
///    user.</td> </tr> <tr> <td>GL_ID_INPUTRADICAL</td> <td>The IME is accepting radical character input from the end
///    user.</td> </tr> <tr> <td>GL_ID_INPUTCODE</td> <td>The IME is accepting character code input from the end
///    user.</td> </tr> <tr> <td>GL_ID_CHOOSECANDIDATE</td> <td>The IME is accepting candidate string selection from the
///    end user.</td> </tr> <tr> <td>GL_ID_REVERSECONVERSION</td> <td>Information about reverse conversion is available
///    by calling <b>ImmGetGuideLine</b>, specifying GGL_PRIVATE. The information retrieved is in CANDIDATELIST
///    format.</td> </tr> </table> If <i>dwIndex</i> is GGL_STRING, the return value is the number of bytes of the
///    string copied to the buffer. However, if <i>dwBufLen</i> is 0, the return value is the buffer size needed to
///    receive the string, not including the terminating null character. For Unicode, if <i>dwBufLen</i> is 0, the
///    return value is the size, in bytes not including the Unicode terminating null character. If <i>dwIndex</i> is
///    GGL_PRIVATE, the return value is the number of bytes of information copied to the buffer. If <i>dwIndex</i> is
///    GGL_PRIVATE and <i>dwBufLen</i> is 0, the return value is the buffer size needed to receive the information.
///    
@DllImport("IMM32")
uint ImmGetGuideLineW(HIMC__* param0, uint dwIndex, PWSTR lpBuf, uint dwBufLen);

///Retrieves the current conversion status.
///Params:
///    HIMC = Handle to the input context for which to retrieve status information.
///    lpfdwConversion = Pointer to a variable in which the function retrieves a combination of conversion mode values. For more
///                      information, see IME Conversion Mode Values.
///    lpfdwSentence = Pointer to a variable in which the function retrieves a sentence mode value. For more information, see IME
///                    Sentence Mode Values.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmGetConversionStatus(HIMC__* param0, uint* lpfdwConversion, uint* lpfdwSentence);

///Sets the current conversion status.
///Params:
///    Arg1 = Handle to the input context.
///    Arg2 = Conversion mode values. For more information, see IME Conversion Mode Values.
///    Arg3 = Sentence mode values. For more information, see IME Sentence Mode Values.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmSetConversionStatus(HIMC__* param0, uint param1, uint param2);

///Determines whether the IME is open or closed.
///Params:
///    HIMC = Handle to the input context.
///Returns:
///    Returns a nonzero value if the IME is open, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmGetOpenStatus(HIMC__* param0);

///Opens or closes the IME.
///Params:
///    HIMC = Handle to the input context.
///    BOOL = <b>TRUE</b> if the IME is open, or <b>FALSE</b> if it is closed.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmSetOpenStatus(HIMC__* param0, BOOL param1);

///Retrieves information about the logical font currently used to display characters in the composition window.
///Params:
///    HIMC = Handle to the input context.
///    lplf = Pointer to a LOGFONT structure in which this function retrieves the font information.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmGetCompositionFontA(HIMC__* param0, LOGFONTA* lplf);

///Retrieves information about the logical font currently used to display characters in the composition window.
///Params:
///    HIMC = Handle to the input context.
///    lplf = Pointer to a LOGFONT structure in which this function retrieves the font information.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmGetCompositionFontW(HIMC__* param0, LOGFONTW* lplf);

///Sets the logical font to use to display characters in the composition window.
///Params:
///    HIMC = Handle to the input context.
///    lplf = Pointer to a LOGFONT structure containing the font information to set.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmSetCompositionFontA(HIMC__* param0, LOGFONTA* lplf);

///Sets the logical font to use to display characters in the composition window.
///Params:
///    HIMC = Handle to the input context.
///    lplf = Pointer to a LOGFONT structure containing the font information to set.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmSetCompositionFontW(HIMC__* param0, LOGFONTW* lplf);

///Displays the configuration dialog box for the IME of the specified input locale identifier.
///Params:
///    HKL = Input locale identifier of an IME.
///    HWND = Handle to the parent window for the dialog box.
///    DWORD = Flags specifying the type of dialog box to display. This parameter can have one of the following values. <table>
///            <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IME_CONFIG_GENERAL"></a><a
///            id="ime_config_general"></a><dl> <dt><b>IME_CONFIG_GENERAL</b></dt> </dl> </td> <td width="60%"> Display
///            general-purpose configuration dialog box. </td> </tr> <tr> <td width="40%"><a id="IME_CONFIG_REGISTERWORD"></a><a
///            id="ime_config_registerword"></a><dl> <dt><b>IME_CONFIG_REGISTERWORD</b></dt> </dl> </td> <td width="60%">
///            Display register word dialog box. </td> </tr> <tr> <td width="40%"><a id="IME_CONFIG_SELECTDICTIONARY"></a><a
///            id="ime_config_selectdictionary"></a><dl> <dt><b>IME_CONFIG_SELECTDICTIONARY</b></dt> </dl> </td> <td
///            width="60%"> Display dictionary selection dialog box. </td> </tr> </table>
///    LPVOID = Pointer to supplemental data. If <i>dwMode</i> is set to IME_CONFIG_REGISTERWORD, this parameter must indicate a
///             REGISTERWORD structure. If <i>dwMode</i> is not IME_CONFIG_REGISTERWORD, this parameter is ignored.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmConfigureIMEA(HKL param0, HWND param1, uint param2, void* param3);

///Displays the configuration dialog box for the IME of the specified input locale identifier.
///Params:
///    HKL = Input locale identifier of an IME.
///    HWND = Handle to the parent window for the dialog box.
///    DWORD = Flags specifying the type of dialog box to display. This parameter can have one of the following values. <table>
///            <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IME_CONFIG_GENERAL"></a><a
///            id="ime_config_general"></a><dl> <dt><b>IME_CONFIG_GENERAL</b></dt> </dl> </td> <td width="60%"> Display
///            general-purpose configuration dialog box. </td> </tr> <tr> <td width="40%"><a id="IME_CONFIG_REGISTERWORD"></a><a
///            id="ime_config_registerword"></a><dl> <dt><b>IME_CONFIG_REGISTERWORD</b></dt> </dl> </td> <td width="60%">
///            Display register word dialog box. </td> </tr> <tr> <td width="40%"><a id="IME_CONFIG_SELECTDICTIONARY"></a><a
///            id="ime_config_selectdictionary"></a><dl> <dt><b>IME_CONFIG_SELECTDICTIONARY</b></dt> </dl> </td> <td
///            width="60%"> Display dictionary selection dialog box. </td> </tr> </table>
///    LPVOID = Pointer to supplemental data. If <i>dwMode</i> is set to IME_CONFIG_REGISTERWORD, this parameter must indicate a
///             REGISTERWORD structure. If <i>dwMode</i> is not IME_CONFIG_REGISTERWORD, this parameter is ignored.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmConfigureIMEW(HKL param0, HWND param1, uint param2, void* param3);

///Accesses capabilities of particular IMEs that are not available through other IME API functions. This function is
///used mainly for country-specific operations.
///Params:
///    HKL = Input locale identifier.
///    HIMC = Handle to the input context.
///    UINT = Index of the operations. For more information, see IME Escapes.
///    LPVOID = Pointer to the data required for the escape specified in <i>uEscape</i>. On output, this parameter indicates the
///             result of the escape. For more information, see IME Escapes.
///Returns:
///    Returns an operation-specific value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
LRESULT ImmEscapeA(HKL param0, HIMC__* param1, uint param2, void* param3);

///Accesses capabilities of particular IMEs that are not available through other IME API functions. This function is
///used mainly for country-specific operations.
///Params:
///    HKL = Input locale identifier.
///    HIMC = Handle to the input context.
///    UINT = Index of the operations. For more information, see IME Escapes.
///    LPVOID = Pointer to the data required for the escape specified in <i>uEscape</i>. On output, this parameter indicates the
///             result of the escape. For more information, see IME Escapes.
///Returns:
///    Returns an operation-specific value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
LRESULT ImmEscapeW(HKL param0, HIMC__* param1, uint param2, void* param3);

///Retrieves the conversion result list of characters or words without generating any IME-related messages.
///Params:
///    HKL = Input locale identifier.
///    HIMC = Handle to the input context.
///    lpSrc = Pointer to a null-terminated character string specifying the source of the list.
///    lpDst = Pointer to a CANDIDATELIST structure in which the function retrieves the list.
///    dwBufLen = Size, in bytes, of the output buffer. The application sets this parameter to 0 if the function is to return the
///               buffer size required for the complete conversion result list.
///    uFlag = Action flag. This parameter can have one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///            </tr> <tr> <td width="40%"><a id="GCL_CONVERSION"></a><a id="gcl_conversion"></a><dl>
///            <dt><b>GCL_CONVERSION</b></dt> </dl> </td> <td width="60%"> Source string is the reading string. The function
///            copies the result string to the destination buffer. </td> </tr> <tr> <td width="40%"><a
///            id="GCL_REVERSECONVERSION"></a><a id="gcl_reverseconversion"></a><dl> <dt><b>GCL_REVERSECONVERSION</b></dt> </dl>
///            </td> <td width="60%"> Source string is the result string. The function copies the reading string to the
///            destination buffer. </td> </tr> <tr> <td width="40%"><a id="GCL_REVERSE_LENGTH"></a><a
///            id="gcl_reverse_length"></a><dl> <dt><b>GCL_REVERSE_LENGTH</b></dt> </dl> </td> <td width="60%"> Source string is
///            the result string. The function returns the size, in bytes, of the reading string created if
///            GCL_REVERSECONVERSION is specified. </td> </tr> </table>
///Returns:
///    Returns the number of bytes copied to the output buffer. If the application sets the <i>dwBufLen</i> parameter to
///    0, the function returns the size, in bytes, of the required output buffer.
///    
@DllImport("IMM32")
uint ImmGetConversionListA(HKL param0, HIMC__* param1, const(PSTR) lpSrc, CANDIDATELIST* lpDst, uint dwBufLen, 
                           uint uFlag);

///Retrieves the conversion result list of characters or words without generating any IME-related messages.
///Params:
///    HKL = Input locale identifier.
///    HIMC = Handle to the input context.
///    lpSrc = Pointer to a null-terminated character string specifying the source of the list.
///    lpDst = Pointer to a CANDIDATELIST structure in which the function retrieves the list.
///    dwBufLen = Size, in bytes, of the output buffer. The application sets this parameter to 0 if the function is to return the
///               buffer size required for the complete conversion result list.
///    uFlag = Action flag. This parameter can have one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///            </tr> <tr> <td width="40%"><a id="GCL_CONVERSION"></a><a id="gcl_conversion"></a><dl>
///            <dt><b>GCL_CONVERSION</b></dt> </dl> </td> <td width="60%"> Source string is the reading string. The function
///            copies the result string to the destination buffer. </td> </tr> <tr> <td width="40%"><a
///            id="GCL_REVERSECONVERSION"></a><a id="gcl_reverseconversion"></a><dl> <dt><b>GCL_REVERSECONVERSION</b></dt> </dl>
///            </td> <td width="60%"> Source string is the result string. The function copies the reading string to the
///            destination buffer. </td> </tr> <tr> <td width="40%"><a id="GCL_REVERSE_LENGTH"></a><a
///            id="gcl_reverse_length"></a><dl> <dt><b>GCL_REVERSE_LENGTH</b></dt> </dl> </td> <td width="60%"> Source string is
///            the result string. The function returns the size, in bytes, of the reading string created if
///            GCL_REVERSECONVERSION is specified. </td> </tr> </table>
///Returns:
///    Returns the number of bytes copied to the output buffer. If the application sets the <i>dwBufLen</i> parameter to
///    0, the function returns the size, in bytes, of the required output buffer.
///    
@DllImport("IMM32")
uint ImmGetConversionListW(HKL param0, HIMC__* param1, const(PWSTR) lpSrc, CANDIDATELIST* lpDst, uint dwBufLen, 
                           uint uFlag);

///Notifies the IME about changes to the status of the input context.
///Params:
///    HIMC = Handle to the input context.
///    dwAction = Notification code. This parameter can have one of the following values. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="NI_CHANGECANDIDATELIST"></a><a
///               id="ni_changecandidatelist"></a><dl> <dt><b>NI_CHANGECANDIDATELIST</b></dt> </dl> </td> <td width="60%"> An
///               application changed the current selected candidate. The <i>dwIndex</i> parameter specifies an index of a
///               candidate list to be selected and <i>dwValue</i> is not used. </td> </tr> <tr> <td width="40%"><a
///               id="NI_CLOSECANDIDATE"></a><a id="ni_closecandidate"></a><dl> <dt><b>NI_CLOSECANDIDATE</b></dt> </dl> </td> <td
///               width="60%"> An application directs the IME to close a candidate list. The <i>dwIndex</i> parameter specifies an
///               index of the list to close, and <i>dwValue</i> is not used. The IME sends a IMN_CLOSECANDIDATE command to the
///               application if it closes the list. </td> </tr> <tr> <td width="40%"><a id="NI_COMPOSITIONSTR"></a><a
///               id="ni_compositionstr"></a><dl> <dt><b>NI_COMPOSITIONSTR</b></dt> </dl> </td> <td width="60%"> An application
///               directs the IME to carry out an action on the composition string. The <i>dwIndex</i> parameter can be CPS_CANCEL,
///               CPS_COMPLETE, CPS_CONVERT, or CPS_REVERT. </td> </tr> <tr> <td width="40%"><a id="NI_IMEMENUSELECTED"></a><a
///               id="ni_imemenuselected"></a><dl> <dt><b>NI_IMEMENUSELECTED</b></dt> </dl> </td> <td width="60%"> An application
///               directs the IME to allow the application to handle the specified menu. The <i>dwIndex</i> parameter specifies the
///               ID of the menu and <i>dwValue</i> is an application-defined value for that menu item. </td> </tr> <tr> <td
///               width="40%"><a id="NI_OPENCANDIDATE"></a><a id="ni_opencandidate"></a><dl> <dt><b>NI_OPENCANDIDATE</b></dt> </dl>
///               </td> <td width="60%"> An application directs the IME to open a candidate list. The <i>dwIndex</i> parameter
///               specifies the index of the list to open, and <i>dwValue</i> is not used. The IME sends a IMN_OPENCANDIDATE
///               command to the application if it opens the list. </td> </tr> <tr> <td width="40%"><a
///               id="NI_SELECTCANDIDATESTR"></a><a id="ni_selectcandidatestr"></a><dl> <dt><b>NI_SELECTCANDIDATESTR</b></dt> </dl>
///               </td> <td width="60%"> An application has selected one of the candidates. The <i>dwIndex</i> parameter specifies
///               an index of a candidate list to be selected. The <i>dwValue</i> parameter specifies an index of a candidate
///               string in the selected candidate list. </td> </tr> <tr> <td width="40%"><a id="NI_SETCANDIDATE_PAGESIZE"></a><a
///               id="ni_setcandidate_pagesize"></a><dl> <dt><b>NI_SETCANDIDATE_PAGESIZE</b></dt> </dl> </td> <td width="60%"> The
///               application changes the page size of a candidate list. The <i>dwIndex</i> parameter specifies the candidate list
///               to be changed and must have a value in the range 0 to 3. The <i>dwValue</i> parameter specifies the new page
///               size. </td> </tr> <tr> <td width="40%"><a id="NI_SETCANDIDATE_PAGESTART"></a><a
///               id="ni_setcandidate_pagestart"></a><dl> <dt><b>NI_SETCANDIDATE_PAGESTART</b></dt> </dl> </td> <td width="60%">
///               The application changes the page starting index of a candidate list. The <i>dwIndex</i> parameter specifies the
///               candidate list to be changed and must have a value in the range 0 to 3. The <i>dwValue</i> parameter specifies
///               the new page start index. </td> </tr> </table>
///    dwIndex = Index of a candidate list. Alternatively, if <i>dwAction</i> is NI_COMPOSITIONSTR, this parameter can have one of
///              the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="CPS_CANCEL"></a><a id="cps_cancel"></a><dl> <dt><b>CPS_CANCEL</b></dt> </dl> </td> <td width="60%"> Clear the
///              composition string and set the status to no composition string. </td> </tr> <tr> <td width="40%"><a
///              id="CPS_COMPLETE"></a><a id="cps_complete"></a><dl> <dt><b>CPS_COMPLETE</b></dt> </dl> </td> <td width="60%"> Set
///              the composition string as the result string. </td> </tr> <tr> <td width="40%"><a id="CPS_CONVERT"></a><a
///              id="cps_convert"></a><dl> <dt><b>CPS_CONVERT</b></dt> </dl> </td> <td width="60%"> Convert the composition
///              string. </td> </tr> <tr> <td width="40%"><a id="CPS_REVERT"></a><a id="cps_revert"></a><dl>
///              <dt><b>CPS_REVERT</b></dt> </dl> </td> <td width="60%"> Cancel the current composition string and set the
///              composition string to be the unconverted string. </td> </tr> </table>
///    dwValue = Index of a candidate string. The application can set this parameter or ignore it, depending on the value of the
///              <i>dwAction</i> parameter.
///Returns:
///    Returns nonzero if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmNotifyIME(HIMC__* param0, uint dwAction, uint dwIndex, uint dwValue);

///Retrieves the position of the status window.
///Params:
///    HIMC = Handle to the input context.
///    lpptPos = Pointer to a POINT structure in which the function retrieves the position coordinates. These are screen
///              coordinates, relative to the upper left corner of the screen.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmGetStatusWindowPos(HIMC__* param0, POINT* lpptPos);

///Sets the position of the status window.
///Params:
///    HIMC = Handle to the input context.
///    lpptPos = Pointer to a POINT structure containing the new position of the status window, in screen coordinates relative to
///              the upper left corner of the display screen.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmSetStatusWindowPos(HIMC__* param0, POINT* lpptPos);

///Retrieves information about the composition window.
///Params:
///    HIMC = Handle to the input context.
///    lpCompForm = Pointer to a COMPOSITIONFORM structure in which the function retrieves information about the composition window.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmGetCompositionWindow(HIMC__* param0, COMPOSITIONFORM* lpCompForm);

///Sets the position of the composition window.
///Params:
///    HIMC = Handle to the input context.
///    lpCompForm = Pointer to a COMPOSITIONFORM structure that contains the new position and other related information about the
///                 composition window.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmSetCompositionWindow(HIMC__* param0, COMPOSITIONFORM* lpCompForm);

///Retrieves information about the candidates window.
///Params:
///    HIMC = Handle to the input context.
///    DWORD = Index of the candidates window.
///    lpCandidate = Pointer to a CANDIDATEFORM structure in which this function retrieves information about the candidates window.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmGetCandidateWindow(HIMC__* param0, uint param1, CANDIDATEFORM* lpCandidate);

///Sets information about the candidates window.
///Params:
///    HIMC = Handle to the input context.
///    lpCandidate = Pointer to a CANDIDATEFORM structure that contains information about the candidates window.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmSetCandidateWindow(HIMC__* param0, CANDIDATEFORM* lpCandidate);

///Checks for messages intended for the IME window and sends those messages to the window.
///Params:
///    HWND = Handle to a window belonging to the IME window class.
///    UINT = Message to check.
///    WPARAM = Message-specific parameter.
///    LPARAM = Message-specific parameter.
///Returns:
///    Returns a nonzero value if the message is processed by the IME window, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmIsUIMessageA(HWND param0, uint param1, WPARAM param2, LPARAM param3);

///Checks for messages intended for the IME window and sends those messages to the window.
///Params:
///    HWND = Handle to a window belonging to the IME window class.
///    UINT = Message to check.
///    WPARAM = Message-specific parameter.
///    LPARAM = Message-specific parameter.
///Returns:
///    Returns a nonzero value if the message is processed by the IME window, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmIsUIMessageW(HWND param0, uint param1, WPARAM param2, LPARAM param3);

///Retrieves the original virtual key value associated with a key input message that the IME has already processed.
///Params:
///    HWND = Handle to the window that receives the key message.
///Returns:
///    If TranslateMessage has been called by the application, <b>ImmGetVirtualKey</b> returns VK_PROCESSKEY; otherwise,
///    it returns the virtual key.
///    
@DllImport("IMM32")
uint ImmGetVirtualKey(HWND param0);

///Registers a string with the dictionary of the IME associated with the specified input locale.
///Params:
///    HKL = Input locale identifier.
///    lpszReading = Pointer to a null-terminated reading string associated with the string to register.
///    DWORD = Style of the string to register. This parameter can have any of the following values. <table> <tr> <th>Value</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IME_REGWORD_STYLE_EUDC"></a><a
///            id="ime_regword_style_eudc"></a><dl> <dt><b>IME_REGWORD_STYLE_EUDC</b></dt> </dl> </td> <td width="60%"> The
///            string is in the end-user-defined (EUDC) range. </td> </tr> <tr> <td width="40%"><a
///            id="Any_value_in_the_range_from_IME_REGWORD_STYLE_USER_FIRST_to_IME_REGWORD_STYLE_USER_LAST"></a><a
///            id="any_value_in_the_range_from_ime_regword_style_user_first_to_ime_regword_style_user_last"></a><a
///            id="ANY_VALUE_IN_THE_RANGE_FROM_IME_REGWORD_STYLE_USER_FIRST_TO_IME_REGWORD_STYLE_USER_LAST"></a><dl> <dt><b>Any
///            value in the range from IME_REGWORD_STYLE_USER_FIRST to IME_REGWORD_STYLE_USER_LAST</b></dt> </dl> </td> <td
///            width="60%"> The string has a private style maintained by the specified IME. See the Remarks section for more
///            details. </td> </tr> </table>
///    lpszRegister = Pointer to the null-terminated string to register.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmRegisterWordA(HKL param0, const(PSTR) lpszReading, uint param2, const(PSTR) lpszRegister);

///Registers a string with the dictionary of the IME associated with the specified input locale.
///Params:
///    HKL = Input locale identifier.
///    lpszReading = Pointer to a null-terminated reading string associated with the string to register.
///    DWORD = Style of the string to register. This parameter can have any of the following values. <table> <tr> <th>Value</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IME_REGWORD_STYLE_EUDC"></a><a
///            id="ime_regword_style_eudc"></a><dl> <dt><b>IME_REGWORD_STYLE_EUDC</b></dt> </dl> </td> <td width="60%"> The
///            string is in the end-user-defined (EUDC) range. </td> </tr> <tr> <td width="40%"><a
///            id="Any_value_in_the_range_from_IME_REGWORD_STYLE_USER_FIRST_to_IME_REGWORD_STYLE_USER_LAST"></a><a
///            id="any_value_in_the_range_from_ime_regword_style_user_first_to_ime_regword_style_user_last"></a><a
///            id="ANY_VALUE_IN_THE_RANGE_FROM_IME_REGWORD_STYLE_USER_FIRST_TO_IME_REGWORD_STYLE_USER_LAST"></a><dl> <dt><b>Any
///            value in the range from IME_REGWORD_STYLE_USER_FIRST to IME_REGWORD_STYLE_USER_LAST</b></dt> </dl> </td> <td
///            width="60%"> The string has a private style maintained by the specified IME. See the Remarks section for more
///            details. </td> </tr> </table>
///    lpszRegister = Pointer to the null-terminated string to register.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmRegisterWordW(HKL param0, const(PWSTR) lpszReading, uint param2, const(PWSTR) lpszRegister);

///Removes a register string from the dictionary of the IME associated with the specified input locale.
///Params:
///    HKL = Input locale identifier.
///    lpszReading = Pointer to a null-terminated reading string associated with the string to remove.
///    DWORD = Style of the register string. This parameter can have any of the following values. <table> <tr> <th>Value</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IME_REGWORD_STYLE_EUDC"></a><a
///            id="ime_regword_style_eudc"></a><dl> <dt><b>IME_REGWORD_STYLE_EUDC</b></dt> </dl> </td> <td width="60%"> The
///            string is in the end-user-defined character (EUDC) range. </td> </tr> <tr> <td width="40%"><a
///            id="Any_value_from_IME_REGWORD_STYLE_USER_FIRST_to_IME_REGWORD_STYLE_USER_LAST"></a><a
///            id="any_value_from_ime_regword_style_user_first_to_ime_regword_style_user_last"></a><a
///            id="ANY_VALUE_FROM_IME_REGWORD_STYLE_USER_FIRST_TO_IME_REGWORD_STYLE_USER_LAST"></a><dl> <dt><b>Any value from
///            IME_REGWORD_STYLE_USER_FIRST to IME_REGWORD_STYLE_USER_LAST</b></dt> </dl> </td> <td width="60%"> The string is
///            in a private style maintained by the specified IME. </td> </tr> </table>
///    lpszUnregister = Pointer to a null-terminated string specifying the register string to remove.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmUnregisterWordA(HKL param0, const(PSTR) lpszReading, uint param2, const(PSTR) lpszUnregister);

///Removes a register string from the dictionary of the IME associated with the specified input locale.
///Params:
///    HKL = Input locale identifier.
///    lpszReading = Pointer to a null-terminated reading string associated with the string to remove.
///    DWORD = Style of the register string. This parameter can have any of the following values. <table> <tr> <th>Value</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IME_REGWORD_STYLE_EUDC"></a><a
///            id="ime_regword_style_eudc"></a><dl> <dt><b>IME_REGWORD_STYLE_EUDC</b></dt> </dl> </td> <td width="60%"> The
///            string is in the end-user-defined character (EUDC) range. </td> </tr> <tr> <td width="40%"><a
///            id="Any_value_from_IME_REGWORD_STYLE_USER_FIRST_to_IME_REGWORD_STYLE_USER_LAST"></a><a
///            id="any_value_from_ime_regword_style_user_first_to_ime_regword_style_user_last"></a><a
///            id="ANY_VALUE_FROM_IME_REGWORD_STYLE_USER_FIRST_TO_IME_REGWORD_STYLE_USER_LAST"></a><dl> <dt><b>Any value from
///            IME_REGWORD_STYLE_USER_FIRST to IME_REGWORD_STYLE_USER_LAST</b></dt> </dl> </td> <td width="60%"> The string is
///            in a private style maintained by the specified IME. </td> </tr> </table>
///    lpszUnregister = Pointer to a null-terminated string specifying the register string to remove.
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
BOOL ImmUnregisterWordW(HKL param0, const(PWSTR) lpszReading, uint param2, const(PWSTR) lpszUnregister);

///Retrieves a list of the styles supported by the IME associated with the specified input locale.
///Params:
///    HKL = Input locale identifier.
///    nItem = Maximum number of styles that the output buffer can hold. The application sets this parameter to 0 if the
///            function is to count the number of styles available in the IME.
///    lpStyleBuf = Pointer to a STYLEBUF structure in which the function retrieves the style information.
///Returns:
///    Returns the number of styles copied to the buffer. If the application sets the <i>nItem</i> parameter to 0, the
///    return value is the number of styles available in the IME.
///    
@DllImport("IMM32")
uint ImmGetRegisterWordStyleA(HKL param0, uint nItem, STYLEBUFA* lpStyleBuf);

///Retrieves a list of the styles supported by the IME associated with the specified input locale.
///Params:
///    HKL = Input locale identifier.
///    nItem = Maximum number of styles that the output buffer can hold. The application sets this parameter to 0 if the
///            function is to count the number of styles available in the IME.
///    lpStyleBuf = Pointer to a STYLEBUF structure in which the function retrieves the style information.
///Returns:
///    Returns the number of styles copied to the buffer. If the application sets the <i>nItem</i> parameter to 0, the
///    return value is the number of styles available in the IME.
///    
@DllImport("IMM32")
uint ImmGetRegisterWordStyleW(HKL param0, uint nItem, STYLEBUFW* lpStyleBuf);

///Enumerates the register strings having the specified reading string, style, and register string.
///Params:
///    Arg1 = Input locale identifier.
///    Arg2 = Pointer to the callback function. For more information, see EnumRegisterWordProc.
///    lpszReading = Pointer to the reading string to enumerate. The application sets this parameter to <b>NULL</b> if the function is
///                  to enumerate all available reading strings that match the <i>dwStyle</i> and <i>lpszRegister</i> settings.
///    Arg4 = Style to enumerate. The application specifies 0 if the function is to enumerate all available styles that match
///           the <i>lpszReading</i> and <i>lpszRegister</i> settings.
///    lpszRegister = Pointer to the register string to enumerate. The application sets this parameter to <b>NULL</b> if the function
///                   is to enumerate all register strings that match the <i>lpszReading</i> and <i>dwStyle</i> settings.
///    Arg6 = Pointer to application-supplied data. The function passes this data to the callback function.
///Returns:
///    Returns the last value returned by the callback function, with the meaning defined by the application. The
///    function returns 0 if it cannot enumerate the register strings.
///    
@DllImport("IMM32")
uint ImmEnumRegisterWordA(HKL param0, REGISTERWORDENUMPROCA param1, const(PSTR) lpszReading, uint param3, 
                          const(PSTR) lpszRegister, void* param5);

///Enumerates the register strings having the specified reading string, style, and register string.
///Params:
///    Arg1 = Input locale identifier.
///    Arg2 = Pointer to the callback function. For more information, see EnumRegisterWordProc.
///    lpszReading = Pointer to the reading string to enumerate. The application sets this parameter to <b>NULL</b> if the function is
///                  to enumerate all available reading strings that match the <i>dwStyle</i> and <i>lpszRegister</i> settings.
///    Arg4 = Style to enumerate. The application specifies 0 if the function is to enumerate all available styles that match
///           the <i>lpszReading</i> and <i>lpszRegister</i> settings.
///    lpszRegister = Pointer to the register string to enumerate. The application sets this parameter to <b>NULL</b> if the function
///                   is to enumerate all register strings that match the <i>lpszReading</i> and <i>dwStyle</i> settings.
///    Arg6 = Pointer to application-supplied data. The function passes this data to the callback function.
///Returns:
///    Returns the last value returned by the callback function, with the meaning defined by the application. The
///    function returns 0 if it cannot enumerate the register strings.
///    
@DllImport("IMM32")
uint ImmEnumRegisterWordW(HKL param0, REGISTERWORDENUMPROCW param1, const(PWSTR) lpszReading, uint param3, 
                          const(PWSTR) lpszRegister, void* param5);

///Disables the IME for a thread or for all threads in a process.
///Params:
///    DWORD = Identifier of the thread for which to disable the IME. The thread must be in the same process as the application
///            calling this function. The application sets this parameter to 0 to disable the IME for the current thread. The
///            application specifies -1 to disable the IME for all threads in the current process.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise.
///    
@DllImport("IMM32")
BOOL ImmDisableIME(uint param0);

///Retrieves the input context for the specified thread.
///Params:
///    idThread = Identifier for the thread. This parameter can have one of the following values. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%">
///               Current thread. </td> </tr> <tr> <td width="40%"><a id="1"></a><dl> <dt><b>1</b></dt> </dl> </td> <td
///               width="60%"> Current process. </td> </tr> <tr> <td width="40%"><a id="Thread_ID"></a><a id="thread_id"></a><a
///               id="THREAD_ID"></a><dl> <dt><b>Thread ID</b></dt> </dl> </td> <td width="60%"> Identifier of the thread for which
///               to enumerate the context. This thread identifier can belong to another process. </td> </tr> </table>
///    lpfn = Pointer to the enumeration callback function. For more information, see EnumInputContext.
///    lParam = Application-supplied data. The function passes this data to the callback function.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise.
///    
@DllImport("IMM32")
BOOL ImmEnumInputContext(uint idThread, IMCENUMPROC lpfn, LPARAM lParam);

///Retrieves the menu items that are registered in the IME menu of a specified input context.
///Params:
///    Arg1 = Handle to the input context for the specified menu items.
///    Arg2 = Flag specifying menu information options. The following value is defined. <table> <tr> <th>Value</th>
///           <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IGIMIF_RIGHTMENU"></a><a id="igimif_rightmenu"></a><dl>
///           <dt><b>IGIMIF_RIGHTMENU</b></dt> </dl> </td> <td width="60%"> Retrieve the menu items for the context menu,
///           obtained by a right mouse click. </td> </tr> </table>
///    Arg3 = Type of menu to retrieve. This parameter can have one or more of the following values. <table> <tr>
///           <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IGIMII_CMODE"></a><a id="igimii_cmode"></a><dl>
///           <dt><b>IGIMII_CMODE</b></dt> </dl> </td> <td width="60%"> Retrieve the menu items that control conversion mode.
///           </td> </tr> <tr> <td width="40%"><a id="IGIMII_SMODE"></a><a id="igimii_smode"></a><dl>
///           <dt><b>IGIMII_SMODE</b></dt> </dl> </td> <td width="60%"> Retrieve the menu items that control sentence mode.
///           </td> </tr> <tr> <td width="40%"><a id="IGIMII_CONFIGURE"></a><a id="igimii_configure"></a><dl>
///           <dt><b>IGIMII_CONFIGURE</b></dt> </dl> </td> <td width="60%"> Retrieve the menu items that are related to IME
///           configuration. </td> </tr> <tr> <td width="40%"><a id="IGIMII_TOOLS"></a><a id="igimii_tools"></a><dl>
///           <dt><b>IGIMII_TOOLS</b></dt> </dl> </td> <td width="60%"> Retrieve the menu items that are related to IME tools.
///           </td> </tr> <tr> <td width="40%"><a id="IGIMII_HELP"></a><a id="igimii_help"></a><dl> <dt><b>IGIMII_HELP</b></dt>
///           </dl> </td> <td width="60%"> Retrieve the menu items that control IME Help. </td> </tr> <tr> <td width="40%"><a
///           id="IGIMII_OTHER"></a><a id="igimii_other"></a><dl> <dt><b>IGIMII_OTHER</b></dt> </dl> </td> <td width="60%">
///           Retrieve the menu items that control other IME functions. </td> </tr> <tr> <td width="40%"><a
///           id="IGIMII_INPUTTOOLS"></a><a id="igimii_inputtools"></a><dl> <dt><b>IGIMII_INPUTTOOLS</b></dt> </dl> </td> <td
///           width="60%"> Retrieve the menu items that control menu items related to IME input tools providing an extended way
///           to input characters. </td> </tr> </table>
///    lpImeParentMenu = Pointer to an IMEMENUITEMINFO structure in which the function retrieves parent menu information. To retrieve
///                      information about the submenu items of this parent menu, the application sets the <b>fType</b> member to
///                      MFT_SUBMENU. This parameter contains <b>NULL</b> if the function retrieves only top-level menu items.
///    lpImeMenu = Pointer to an array of IMEMENUITEMINFO structures in which the function retrieves information about the menu
///                items. This parameter contains <b>NULL</b> if the function retrieves the number of registered menu items.
///    dwSize = Size of the buffer to receive the IMEMENUITEMINFO structure.
///Returns:
///    Returns the number of menu items copied into <i>lpImeMenu</i>. If <i>lpImeMenu</i> specifies <b>NULL</b>, the
///    function returns the number of registered menu items in the specified input context.
///    
@DllImport("IMM32")
uint ImmGetImeMenuItemsA(HIMC__* param0, uint param1, uint param2, IMEMENUITEMINFOA* lpImeParentMenu, 
                         IMEMENUITEMINFOA* lpImeMenu, uint dwSize);

///Retrieves the menu items that are registered in the IME menu of a specified input context.
///Params:
///    Arg1 = Handle to the input context for the specified menu items.
///    Arg2 = Flag specifying menu information options. The following value is defined. <table> <tr> <th>Value</th>
///           <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IGIMIF_RIGHTMENU"></a><a id="igimif_rightmenu"></a><dl>
///           <dt><b>IGIMIF_RIGHTMENU</b></dt> </dl> </td> <td width="60%"> Retrieve the menu items for the context menu,
///           obtained by a right mouse click. </td> </tr> </table>
///    Arg3 = Type of menu to retrieve. This parameter can have one or more of the following values. <table> <tr>
///           <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IGIMII_CMODE"></a><a id="igimii_cmode"></a><dl>
///           <dt><b>IGIMII_CMODE</b></dt> </dl> </td> <td width="60%"> Retrieve the menu items that control conversion mode.
///           </td> </tr> <tr> <td width="40%"><a id="IGIMII_SMODE"></a><a id="igimii_smode"></a><dl>
///           <dt><b>IGIMII_SMODE</b></dt> </dl> </td> <td width="60%"> Retrieve the menu items that control sentence mode.
///           </td> </tr> <tr> <td width="40%"><a id="IGIMII_CONFIGURE"></a><a id="igimii_configure"></a><dl>
///           <dt><b>IGIMII_CONFIGURE</b></dt> </dl> </td> <td width="60%"> Retrieve the menu items that are related to IME
///           configuration. </td> </tr> <tr> <td width="40%"><a id="IGIMII_TOOLS"></a><a id="igimii_tools"></a><dl>
///           <dt><b>IGIMII_TOOLS</b></dt> </dl> </td> <td width="60%"> Retrieve the menu items that are related to IME tools.
///           </td> </tr> <tr> <td width="40%"><a id="IGIMII_HELP"></a><a id="igimii_help"></a><dl> <dt><b>IGIMII_HELP</b></dt>
///           </dl> </td> <td width="60%"> Retrieve the menu items that control IME Help. </td> </tr> <tr> <td width="40%"><a
///           id="IGIMII_OTHER"></a><a id="igimii_other"></a><dl> <dt><b>IGIMII_OTHER</b></dt> </dl> </td> <td width="60%">
///           Retrieve the menu items that control other IME functions. </td> </tr> <tr> <td width="40%"><a
///           id="IGIMII_INPUTTOOLS"></a><a id="igimii_inputtools"></a><dl> <dt><b>IGIMII_INPUTTOOLS</b></dt> </dl> </td> <td
///           width="60%"> Retrieve the menu items that control menu items related to IME input tools providing an extended way
///           to input characters. </td> </tr> </table>
///    lpImeParentMenu = Pointer to an IMEMENUITEMINFO structure in which the function retrieves parent menu information. To retrieve
///                      information about the submenu items of this parent menu, the application sets the <b>fType</b> member to
///                      MFT_SUBMENU. This parameter contains <b>NULL</b> if the function retrieves only top-level menu items.
///    lpImeMenu = Pointer to an array of IMEMENUITEMINFO structures in which the function retrieves information about the menu
///                items. This parameter contains <b>NULL</b> if the function retrieves the number of registered menu items.
///    dwSize = Size of the buffer to receive the IMEMENUITEMINFO structure.
///Returns:
///    Returns the number of menu items copied into <i>lpImeMenu</i>. If <i>lpImeMenu</i> specifies <b>NULL</b>, the
///    function returns the number of registered menu items in the specified input context.
///    
@DllImport("IMM32")
uint ImmGetImeMenuItemsW(HIMC__* param0, uint param1, uint param2, IMEMENUITEMINFOW* lpImeParentMenu, 
                         IMEMENUITEMINFOW* lpImeMenu, uint dwSize);

///<p class="CCE_Message">[<b>ImmDisableTextFrameService</b> is no longer available for use as of Windows Vista.
///Instead, use ImmDisableIME. ] Disables the text service for the specified thread. For details, see Text Services
///Framework (TSF).
///Params:
///    idThread = Identifier of the thread for which to disable the text service. The thread must be in the same process as the
///               application. The application sets this parameter to 0 to disable the service for the current thread. The
///               application sets the parameter to –1 to disable the service for all threads in the current process.
///Returns:
///    Returns <b>TRUE</b> if successful or <b>FALSE</b> otherwise.
///    
@DllImport("IMM32")
BOOL ImmDisableTextFrameService(uint idThread);

///Indicates that this thread is a Windows Store app UI thread.
///Returns:
///    Returns <b>TRUE</b> if successful; otherwise, <b>FALSE</b>.
///    
@DllImport("IMM32")
BOOL ImmDisableLegacyIME();

///Retrieves a list of available ELS platform-supported services, along with associated information, according to
///application-specified criteria.
///Params:
///    pOptions = Pointer to a MAPPING_ENUM_OPTIONS structure containing criteria to use during enumeration of services. The
///               application specifies <b>NULL</b> for this parameter to retrieve all installed services.
///    prgServices = Address of a pointer to an array of MAPPING_SERVICE_INFO structures containing service information matching the
///                  criteria supplied in the <i>pOptions</i> parameter.
///    pdwServicesCount = Pointer to a DWORD variable in which this function retrieves the number of retrieved services.
///Returns:
///    Returns S_OK if successful. The function returns an error HRESULT value if it does not succeed.<div
///    class="alert"><b>Note</b> The application must test for any failure before proceeding with further
///    operations.</div> <div> </div>
///    
@DllImport("elscore")
HRESULT MappingGetServices(MAPPING_ENUM_OPTIONS* pOptions, MAPPING_SERVICE_INFO** prgServices, 
                           uint* pdwServicesCount);

///Frees memory and resources allocated for the application to interact with one or more ELS services. The memory and
///resources are allocated in an application call to MappingGetServices.
///Params:
///    pServiceInfo = Pointer to an array of MAPPING_SERVICE_INFO structures containing service descriptions retrieved by a prior call
///                   to MappingGetServices. This parameter cannot be set to <b>NULL</b>.
///Returns:
///    Returns S_OK if successful. The function returns an error HRESULT value if it does not succeed.
///    
@DllImport("elscore")
HRESULT MappingFreeServices(MAPPING_SERVICE_INFO* pServiceInfo);

///Calls upon an ELS service to recognize text. For example, the Microsoft Language Detection service will attempt to
///recognize the language in which the input text is written.
///Params:
///    pServiceInfo = Pointer to a MAPPING_SERVICE_INFO structure containing information about the service to use in text recognition.
///                   The structure must be one of the structures retrieved by a previous call to MappingGetServices. This parameter
///                   cannot be set to <b>NULL</b>.
///    pszText = Pointer to the text to recognize. The text must be UTF-16, but some services have additional requirements for the
///              input format. This parameter cannot be set to <b>NULL</b>.
///    dwLength = Length, in characters, of the text specified in <i>pszText</i>.
///    dwIndex = Index inside the specified text to be used by the service. This value should be between 0 and <i>dwLength</i>-1.
///              If the application wants to process the entire text, it should set this parameter to 0.
///    pOptions = Pointer to a MAPPING_OPTIONS structure containing options that affect the result and behavior of text
///               recognition. The application does not have to specify values for all structure members. This parameter can be set
///               to <b>NULL</b> to use the default mapping options.
///    pbag = Pointer to a MAPPING_PROPERTY_BAG structure in which the service stores its results. On input, the application
///           passes a structure with only the size provided, and the other members set to 0. On output, the structure is
///           filled with information produced by the service during text recognition. This parameter cannot be set to
///           <b>NULL</b>.
///Returns:
///    Returns S_OK if successful. The function returns an error HRESULT value if it does not succeed.
///    
@DllImport("elscore")
HRESULT MappingRecognizeText(MAPPING_SERVICE_INFO* pServiceInfo, const(PWSTR) pszText, uint dwLength, uint dwIndex, 
                             MAPPING_OPTIONS* pOptions, MAPPING_PROPERTY_BAG* pbag);

///Causes an ELS service to perform an action after text recognition has occurred. For example, a phone dialer service
///first must recognize phone numbers and then can perform the "action" of dialing a number.
///Params:
///    pBag = Pointer to a MAPPING_PROPERTY_BAG structure containing the results of a previous call to MappingRecognizeText.
///           This parameter cannot be set to <b>NULL</b>.
///    dwRangeIndex = A starting index inside the text recognition results for a recognized text range. This value should be between 0
///                   and the range count.
///    pszActionId = Pointer to the identifier of the action to perform. This parameter cannot be set to <b>NULL</b>.
///Returns:
///    Returns S_OK if successful. The function returns an error HRESULT value if it does not succeed.
///    
@DllImport("elscore")
HRESULT MappingDoAction(MAPPING_PROPERTY_BAG* pBag, uint dwRangeIndex, const(PWSTR) pszActionId);

///Frees memory and resources allocated during an ELS text recognition operation.
///Params:
///    pBag = Pointer to a MAPPING_PROPERTY_BAG structure containing the properties for which to free resources. This parameter
///           cannot be set to <b>NULL</b>.
///Returns:
///    Returns S_OK if successful. The function returns an error HRESULT value if it does not succeed.
///    
@DllImport("elscore")
HRESULT MappingFreePropertyBag(MAPPING_PROPERTY_BAG* pBag);

@DllImport("IMM32")
BOOL ImmGetHotKey(uint param0, uint* lpuModifiers, uint* lpuVKey, ptrdiff_t* phKL);

@DllImport("IMM32")
BOOL ImmSetHotKey(uint param0, uint param1, uint param2, HKL param3);

@DllImport("IMM32")
BOOL ImmGenerateMessage(HIMC__* param0);

///Generates a WM_IME_REQUEST message.
///Params:
///    HIMC = Handle to the target input context.
///    WPARAM = Value of the <i>wParam</i> parameter for the WM_IME_REQUEST message.
///    LPARAM = Value of the <i>lParam</i> parameter for the WM_IME_REQUEST message.
///Returns:
///    Returns an operation-specific value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
LRESULT ImmRequestMessageA(HIMC__* param0, WPARAM param1, LPARAM param2);

///Generates a WM_IME_REQUEST message.
///Params:
///    HIMC = Handle to the target input context.
///    WPARAM = Value of the <i>wParam</i> parameter for the WM_IME_REQUEST message.
///    LPARAM = Value of the <i>lParam</i> parameter for the WM_IME_REQUEST message.
///Returns:
///    Returns an operation-specific value if successful, or 0 otherwise.
///    
@DllImport("IMM32")
LRESULT ImmRequestMessageW(HIMC__* param0, WPARAM param1, LPARAM param2);

@DllImport("IMM32")
HWND ImmCreateSoftKeyboard(uint param0, HWND param1, int param2, int param3);

@DllImport("IMM32")
BOOL ImmDestroySoftKeyboard(HWND param0);

@DllImport("IMM32")
BOOL ImmShowSoftKeyboard(HWND param0, int param1);

@DllImport("IMM32")
INPUTCONTEXT* ImmLockIMC(HIMC__* param0);

@DllImport("IMM32")
BOOL ImmUnlockIMC(HIMC__* param0);

@DllImport("IMM32")
uint ImmGetIMCLockCount(HIMC__* param0);

@DllImport("IMM32")
HIMCC__* ImmCreateIMCC(uint param0);

@DllImport("IMM32")
HIMCC__* ImmDestroyIMCC(HIMCC__* param0);

@DllImport("IMM32")
void* ImmLockIMCC(HIMCC__* param0);

@DllImport("IMM32")
BOOL ImmUnlockIMCC(HIMCC__* param0);

@DllImport("IMM32")
uint ImmGetIMCCLockCount(HIMCC__* param0);

@DllImport("IMM32")
HIMCC__* ImmReSizeIMCC(HIMCC__* param0, uint param1);

@DllImport("IMM32")
uint ImmGetIMCCSize(HIMCC__* param0);

///Frees a script cache.
///Params:
///    psc = Pointer to the SCRIPT_CACHE structure.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. The application
///    cant test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros.
///    
@DllImport("USP10")
HRESULT ScriptFreeCache(void** psc);

///Breaks a Unicode string into individually shapeable items.
///Params:
///    pwcInChars = Pointer to a Unicode string to itemize.
///    cInChars = Number of characters in <i>pwcInChars</i> to itemize.
///    cMaxItems = Maximum number of SCRIPT_ITEM structures defining items to process.
///    psControl = Pointer to a SCRIPT_CONTROL structure indicating the type of itemization to perform. Alternatively, the
///                application can set this parameter to <b>NULL</b> if no SCRIPT_CONTROL properties are needed. For more
///                information, see the Remarks section.
///    psState = Pointer to a SCRIPT_STATE structure indicating the initial bidirectional algorithm state. Alternatively, the
///              application can set this parameter to <b>NULL</b> if the script state is not needed. For more information, see
///              the Remarks section.
///    pItems = Pointer to a buffer in which the function retrieves SCRIPT_ITEM structures representing the items that have been
///             processed. The buffer should be <code>(cMaxItems + 1) * sizeof(SCRIPT_ITEM)</code> bytes in length. It is invalid
///             to call this function with a buffer to hold less than two <b>SCRIPT_ITEM</b> structures. The function always adds
///             a terminal item to the item analysis array so that the length of the item with zero-based index "i" is always
///             available as: <code>pItems[i+1].iCharPos - pItems[i].iCharPos;</code>
///    pcItems = Pointer to the number of SCRIPT_ITEM structures processed.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. The function
///    returns E_INVALIDARG if <i>pwcInChars</i> is set to <b>NULL</b>, <i>cInChars</i> is 0, <i>pItems</i> is set to
///    <b>NULL</b>, or <i>cMaxItems</i> &lt; 2. The function returns E_OUTOFMEMORY if the value of <i>cMaxItems</i> is
///    insufficient. As in all error cases, no items are fully processed and no part of the output array contains
///    defined values. If the function returns E_OUTOFMEMORY, the application can call it again with a larger
///    <i>pItems</i> buffer.
///    
@DllImport("USP10")
HRESULT ScriptItemize(const(PWSTR) pwcInChars, int cInChars, int cMaxItems, const(SCRIPT_CONTROL)* psControl, 
                      const(SCRIPT_STATE)* psState, SCRIPT_ITEM* pItems, int* pcItems);

///Converts an array of run embedding levels to a map of visual-to-logical position and/or logical-to-visual position.
///Params:
///    cRuns = Number of runs to process.
///    pbLevel = Pointer to an array, of length indicated by <i>cRuns</i>, containing run embedding levels. Embedding levels for
///              all runs on the line must be included, ordered logically. For more information, see the Remarks section.
///    piVisualToLogical = Pointer to an array, of length indicated by <i>cRuns</i>, in which this function retrieves the run embedding
///                        levels reordered to visual order. The first array element represents the run to display at the far left, and
///                        subsequent entries should be displayed progressing from left to right. The function sets this parameter to
///                        <b>NULL</b> if there is no output.
///    piLogicalToVisual = Pointer to an array, of length indicated by <i>cRuns</i>, in which this function retrieves the visual run
///                        positions. The first array element is the relative visual position where the first logical run should be
///                        displayed, the leftmost display position being 0. The function sets this parameter to <b>NULL</b> if there is no
///                        output.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. The application can
///    test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros.
///    
@DllImport("USP10")
HRESULT ScriptLayout(int cRuns, const(ubyte)* pbLevel, int* piVisualToLogical, int* piLogicalToVisual);

///Generates glyphs and visual attributes for a Unicode run.
///Params:
///    hdc = Optional. Handle to the device context. For more information, see Caching.
///    psc = Pointer to a SCRIPT_CACHE structure identifying the script cache.
///    pwcChars = Pointer to an array of Unicode characters defining the run.
///    cChars = Number of characters in the Unicode run.
///    cMaxGlyphs = Maximum number of glyphs to generate, and the length of <i>pwOutGlyphs</i>. A reasonable value is <code>(1.5 *
///                 cChars + 16)</code>, but this value might be insufficient in some circumstances. For more information, see the
///                 Remarks section.
///    psa = Pointer to the SCRIPT_ANALYSIS structure for the run, containing the results from an earlier call to
///          ScriptItemize.
///    pwOutGlyphs = Pointer to a buffer in which this function retrieves an array of glyphs with size as indicated by
///                  <i>cMaxGlyphs</i>.
///    pwLogClust = Pointer to a buffer in which this function retrieves an array of logical cluster information. Each array element
///                 corresponds to a character in the array of Unicode characters; therefore this array has the number of elements
///                 indicated by cChars. The value of each element is the offset from the first glyph in the run to the first glyph
///                 in the cluster containing the corresponding character. Note that, when the <b>fRTL</b> member is set to
///                 <b>TRUE</b> in the SCRIPT_ANALYSIS structure, the elements decrease as the array is read.
///    psva = Pointer to a buffer in which this function retrieves an array of SCRIPT_VISATTR structures containing visual
///           attribute information. Since each glyph has only one visual attribute, this array has the number of elements
///           indicated by <i>cMaxGlyphs</i>.
///    pcGlyphs = Pointer to the location in which this function retrieves the number of glyphs indicated in <i>pwOutGlyphs</i>.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. In all error cases,
///    the content of all output parameters is undefined. Error returns include: <ul> <li>E_OUTOFMEMORY. The output
///    buffer length indicated by <i>cMaxGlyphs</i> is insufficient.</li> <li>E_PENDING. The script cache specified by
///    the <i>psc</i> parameter does not contain enough information to shape the string, and the device context has been
///    passed as <b>NULL</b> so that the function is unable to complete the shaping process. The application should set
///    up a correct device context for the run, and call this function again with the appropriate value in <i>hdc</i>
///    and with all other parameters the same.</li> <li>USP_E_SCRIPT_NOT_IN_FONT. The font corresponding to the device
///    context does not support the script required by the run indicated by <i>pwcChars</i>. The application should
///    choose another font, using either ScriptGetCMap or another function to select the font.</li> </ul>
///    
@DllImport("USP10")
HRESULT ScriptShape(HDC hdc, void** psc, const(PWSTR) pwcChars, int cChars, int cMaxGlyphs, SCRIPT_ANALYSIS* psa, 
                    ushort* pwOutGlyphs, ushort* pwLogClust, SCRIPT_VISATTR* psva, int* pcGlyphs);

///Generates glyph advance width and two-dimensional offset information from the output of ScriptShape.
///Params:
///    hdc = Optional. Handle to the device context. For more information, see Caching.
///    psc = Pointer to a SCRIPT_CACHE structure identifying the script cache.
///    pwGlyphs = Pointer to a glyph buffer obtained from an earlier call to the ScriptShape function.
///    cGlyphs = Count of glyphs in the glyph buffer.
///    psva = Pointer to an array of SCRIPT_VISATTR structures indicating visual attributes.
///    psa = Pointer to a SCRIPT_ANALYSIS structure. On input, this structure is obtained from a previous call to
///          ScriptItemize. On output, this structure contains values retrieved by <b>ScriptPlace</b>.
///    piAdvance = Pointer to an array in which this function retrieves advance width information.
///    pGoffset = Optional. Pointer to an array of GOFFSET structures in which this function retrieves the x and y offsets of
///               combining glyphs. This array must be of length indicated by <i>cGlyphs</i>.
///    pABC = Pointer to an ABC structure in which this function retrieves the ABC width for the entire run.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. The application can
///    test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros. The function returns E_PENDING if the
///    script cache specified by the <i>psc</i> parameter does not contain enough information to place the glyphs, and
///    the <i>hdc</i> parameter is set to <b>NULL</b> so that the function cannot complete the placement process. The
///    application should set up a correct device context for the run, and call this function again with the appropriate
///    device context and with all other parameters the same.
///    
@DllImport("USP10")
HRESULT ScriptPlace(HDC hdc, void** psc, const(ushort)* pwGlyphs, int cGlyphs, const(SCRIPT_VISATTR)* psva, 
                    SCRIPT_ANALYSIS* psa, int* piAdvance, GOFFSET* pGoffset, ABC* pABC);

///Displays text for the specified script shape and place information.
///Params:
///    hdc = Handle to the device context. For more information, see Caching. Note that, unlike some other related Uniscribe
///          functions, this function defines the handle as mandatory.
///    psc = Pointer to a SCRIPT_CACHE structure identifying the script cache.
///    x = Value of the x coordinate of the first glyph.
///    y = Value of the y coordinate of the first glyph.
///    fuOptions = Options equivalent to the <i>fuOptions</i> parameter of ExtTextOut. This parameter can be set to either
///                ETO_CLIPPED or ETO_OPAQUE, to both values, or to neither value.
///    lprc = Pointer to a RECT structure containing the rectangle used to clip the display. The application can set this
///           parameter to <b>NULL</b>.
///    psa = Pointer to a SCRIPT_ANALYSIS structure obtained from a previous call to ScriptItemize.
///    pwcReserved = Reserved; must be set to <b>NULL</b>.
///    iReserved = Reserved; must be 0.
///    pwGlyphs = Pointer to an array of glyphs obtained from a previous call to ScriptShape.
///    cGlyphs = Count of the glyphs in the array indicated by <i>pwGlyphs</i>. The maximum number of glyphs is 65,536.
///    piAdvance = Pointer to an array of advance widths obtained from a previous call to ScriptPlace.
///    piJustify = Pointer to an array of justified advance widths (cell widths). The application can set this parameter to
///                <b>NULL</b>.
///    pGoffset = Pointer to a GOFFSET structure containing the x and y offsets for the combining glyph.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. The application can
///    test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros.
///    
@DllImport("USP10")
HRESULT ScriptTextOut(const(HDC) hdc, void** psc, int x, int y, uint fuOptions, const(RECT)* lprc, 
                      const(SCRIPT_ANALYSIS)* psa, const(PWSTR) pwcReserved, int iReserved, const(ushort)* pwGlyphs, 
                      int cGlyphs, const(int)* piAdvance, const(int)* piJustify, const(GOFFSET)* pGoffset);

///Creates an advance widths table to allow text justification when passed to the ScriptTextOut function.
///Params:
///    psva = Pointer to an array, of length indicated by <i>cGlyphs</i>, containing SCRIPT_VISATTR structures. Each structure
///           contains visual attributes for a glyph in the line to process.
///    piAdvance = Pointer to an advance widths array, of length indicated by <i>cGlyphs</i>, obtained from a previous call to
///                ScriptPlace.
///    cGlyphs = Count of glyphs for the arrays indicated by <i>psva</i> and <i>piAdvance</i>. This parameter also indicates the
///              count of glyphs for the output parameter <i>piJustify</i>.
///    iDx = Width, in pixels, of the desired change, either an increase of decrease.
///    iMinKashida = Minimum width of a kashida glyph to generate.
///    piJustify = Pointer to a buffer in which this function retrieves an array, of length indicated by <i>cGlyphs</i>, containing
///                justified advance widths. The justified widths are sometimes called "cell widths" to distinguish them from
///                unjustified advance widths.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. The application can
///    test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros.
///    
@DllImport("USP10")
HRESULT ScriptJustify(const(SCRIPT_VISATTR)* psva, const(int)* piAdvance, int cGlyphs, int iDx, int iMinKashida, 
                      int* piJustify);

///Retrieves information for determining line breaks.
///Params:
///    pwcChars = Pointer to the Unicode characters to process.
///    cChars = Number of Unicode characters to process.
///    psa = Pointer to the SCRIPT_ANALYSIS structure obtained from an earlier call to ScriptItemize.
///    psla = Pointer to a buffer in which this function retrieves the character attributes as a SCRIPT_LOGATTR structure.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. The application can
///    test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros.
///    
@DllImport("USP10")
HRESULT ScriptBreak(const(PWSTR) pwcChars, int cChars, const(SCRIPT_ANALYSIS)* psa, SCRIPT_LOGATTR* psla);

///Generates the x offset from the left end or leading edge of a run to either the leading or trailing edge of a logical
///character cluster.
///Params:
///    iCP = Logical character position in the run. This parameter corresponds to the offset of any logical character in the
///          cluster.
///    fTrailing = <b>TRUE</b> to use the trailing edge of the logical character cluster to compute the offset. This parameter is
///                set to <b>FALSE</b> to use the leading edge of the logical character cluster.
///    cChars = Number of characters in the run.
///    cGlyphs = Number of glyphs in the run.
///    pwLogClust = Pointer to the logical clusters.
///    psva = Pointer to a SCRIPT_VISATTR array of visual attributes.
///    piAdvance = Pointer to an advance widths value.
///    psa = Pointer to a SCRIPT_ANALYSIS structure. The <b>fLogicalOrder</b> member specifies the end of the run from which
///          to measure the offset. If the flag is set, the leading edge of the run is used. If the flag is not set, the left
///          end of the run is used.
///    piX = Pointer to the buffer in which the function retrieves the x position of the caret.
///Returns:
///    Returns 0 if successful. This function returns a nonzero HRESULT value if it does not succeed. The application
///    can test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros.
///    
@DllImport("USP10")
HRESULT ScriptCPtoX(int iCP, BOOL fTrailing, int cChars, int cGlyphs, const(ushort)* pwLogClust, 
                    const(SCRIPT_VISATTR)* psva, const(int)* piAdvance, const(SCRIPT_ANALYSIS)* psa, int* piX);

///Generates the leading or trailing edge of a logical character cluster from the x offset of a run.
///Params:
///    iX = Offset, in logical units, from the end of the run specified by the <b>fLogicalOrder</b> member of the
///         SCRIPT_ANALYSIS structure indicated by the <i>psa</i> parameter.
///    cChars = Count of logical code points in the run.
///    cGlyphs = Count of glyphs in the run.
///    pwLogClust = Pointer to an array of logical clusters.
///    psva = Pointer to an array of SCRIPT_VISATTR structures containing the visual attributes for the glyph.
///    piAdvance = Pointer to an array of advance widths.
///    psa = Pointer to a SCRIPT_ANALYSIS structure. The <b>fLogicalOrder</b> member indicates <b>TRUE</b> to use the leading
///          edge of the run, or <b>FALSE</b> to use the trailing edge.
///    piCP = Pointer to a buffer in which this function retrieves the character position corrresponding to the x coordinate.
///    piTrailing = Pointer to a buffer in which this function retrieves the distance, in code points, from the leading edge of the
///                 logical character to the <i>iX</i> position. If this value is 0, the <i>iX</i> position is at the leading edge of
///                 the logical character. For more information, see the Remarks section.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. The application can
///    test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros.
///    
@DllImport("USP10")
HRESULT ScriptXtoCP(int iX, int cChars, int cGlyphs, const(ushort)* pwLogClust, const(SCRIPT_VISATTR)* psva, 
                    const(int)* piAdvance, const(SCRIPT_ANALYSIS)* psa, int* piCP, int* piTrailing);

///Converts the glyph advance widths for a specific font into logical widths.
///Params:
///    psa = Pointer to a SCRIPT_ANALYSIS structure.
///    cChars = Count of the logical code points in the run.
///    cGlyphs = Count of the glyphs in the run.
///    piGlyphWidth = Pointer to an array of glyph advance widths.
///    pwLogClust = Pointer to an array of logical clusters.
///    psva = Pointer to a SCRIPT_VISATTR structure defining visual attributes.
///    piDx = Pointer to an array of logical widths.
///Returns:
///    Currently returns S_OK in all cases.
///    
@DllImport("USP10")
HRESULT ScriptGetLogicalWidths(const(SCRIPT_ANALYSIS)* psa, int cChars, int cGlyphs, const(int)* piGlyphWidth, 
                               const(ushort)* pwLogClust, const(SCRIPT_VISATTR)* psva, int* piDx);

///Takes an array of advance widths for a run and generates an array of adjusted advance glyph widths.
///Params:
///    piDx = Pointer to an array of advance widths in logical order, one per code point.
///    cChars = Count of the logical code points in the run.
///    cGlyphs = Glyph count.
///    pwLogClust = Pointer to an array of logical clusters from ScriptShape.
///    psva = Pointer to a SCRIPT_VISATTR structure from ScriptShape and updated by ScriptPlace.
///    piAdvance = Pointer to an array of glyph advance widths from ScriptPlace.
///    psa = Pointer to a SCRIPT_ANALYSIS structure from ScriptItemize and updated by ScriptShape and ScriptPlace.
///    pABC = Pointer to the overall ABC width of a run. On input, the parameter should contain the run ABC widths retrieved by
///           ScriptPlace. On output, the parameter indicates the ABC width updated to match the new widths.
///    piJustify = Pointer to an array in which the function retrieves the glyph advance widths. This array is suitable for passing
///                to the <i>piJustify</i> parameter of ScriptTextOut.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. The application can
///    test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros.
///    
@DllImport("USP10")
HRESULT ScriptApplyLogicalWidth(const(int)* piDx, int cChars, int cGlyphs, const(ushort)* pwLogClust, 
                                const(SCRIPT_VISATTR)* psva, const(int)* piAdvance, const(SCRIPT_ANALYSIS)* psa, 
                                ABC* pABC, int* piJustify);

///Retrieves the glyph indexes of the Unicode characters in a string according to either the TrueType cmap table or the
///standard cmap table implemented for old-style fonts.
///Params:
///    hdc = Optional. Handle to the device context. For more information, see Caching.
///    psc = Pointer to a SCRIPT_CACHE structure identifying the script cache.
///    pwcInChars = Pointer to a string of Unicode characters.
///    cChars = Number of Unicode characters in the string indicated by <i>pwcInChars</i>.
///    dwFlags = Flags specifying any special handling of the glyphs. By default, the glyphs are provided in logical order with no
///              special handling. This parameter can have the following value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///              <tr> <td width="40%"><a id="SGCM_RTL"></a><a id="sgcm_rtl"></a><dl> <dt><b>SGCM_RTL</b></dt> </dl> </td> <td
///              width="60%"> The glyph array indicated by <i>pwOutGlyphs</i> should contain mirrored glyphs for those glyphs that
///              have a mirrored equivalent. </td> </tr> </table>
///    pwOutGlyphs = Pointer to a buffer in which the function retrieves an array of glyph indexes. This buffer should be of the same
///                  length as the input buffer indicated by <i>pwcInChars</i>. Each code point maps to a single glyph.
///Returns:
///    Returns S_OK if all Unicode code points are present in the font. The function returns one of the nonzero HRESULT
///    values listed below if it does not succeed. <table> <tr> <th>Return value</th> <th>Meaning</th> </tr> <tr>
///    <td>E_HANDLE</td> <td>The font or the operating system does not support glyph indexes.</td> </tr> <tr>
///    <td>S_FALSE</td> <td>Some of the Unicode code points were mapped to the default glyph.</td> </tr> </table>
///    
@DllImport("USP10")
HRESULT ScriptGetCMap(HDC hdc, void** psc, const(PWSTR) pwcInChars, int cChars, uint dwFlags, ushort* pwOutGlyphs);

///Retrieves the ABC width of a given glyph.
///Params:
///    hdc = Optional. Handle to the device context. For more information, see Caching.
///    psc = Pointer to a SCRIPT_CACHE structure identifying the script cache.
///    wGlyph = Glyph to analyze.
///    pABC = Pointer to the ABC width of the specified glyph.
///Returns:
///    Returns S_OK if the ABC width of the glyph is retrieved. The function returns a nonzero HRESULT value if it does
///    not succeed. The function returns E_HANDLE if the font or operating system does not support glyph indexes.
///    
@DllImport("USP10")
HRESULT ScriptGetGlyphABCWidth(HDC hdc, void** psc, ushort wGlyph, ABC* pABC);

///Retrieves information about the current scripts.
///Params:
///    ppSp = Pointer to an array of pointers to SCRIPT_PROPERTIES structures indexed by script.
///    piNumScripts = Pointer to the number of scripts. The valid range for this value is 0 through <i>piNumScripts</i>-1.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. The application can
///    test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros.
///    
@DllImport("USP10")
HRESULT ScriptGetProperties(const(SCRIPT_PROPERTIES)*** ppSp, int* piNumScripts);

///Retrieves information from the font cache on the special glyphs used by a font.
///Params:
///    hdc = Optional. Handle to the device context. For more information, see Caching.
///    psc = Pointer to a SCRIPT_CACHE structure identifying the script cache.
///    sfp = Pointer to a SCRIPT_FONTPROPERTIES structure in which this function retrieves the information from the font
///          cache.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. The application can
///    test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros.
///    
@DllImport("USP10")
HRESULT ScriptGetFontProperties(HDC hdc, void** psc, SCRIPT_FONTPROPERTIES* sfp);

///Retrieves the height of the currently cached font.
///Params:
///    hdc = Optional. Handle to the device context. For more information, see Caching.
///    psc = Pointer to a SCRIPT_CACHE structure identifying the script cache.
///    tmHeight = Pointer to a buffer in which the function retrieves the font height.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. The application can
///    test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros.
///    
@DllImport("USP10")
HRESULT ScriptCacheGetHeight(HDC hdc, void** psc, int* tmHeight);

///Analyzes a plain text string.
///Params:
///    hdc = Handle to the device context. If <i>dwFlags</i> is set to SSA_GLYPHS, the device context handle is required. If
///          <i>dwFlags</i> is set to SSA_BREAK, the device context handle is optional. If the device context handle is
///          provided, the function inspects the current font in the device context. If the current font is a symbolic font,
///          the function treats the character string as a single neutral SCRIPT_UNDEFINED item.
///    pString = Pointer to the string to analyze. The string must have at least one character. It can be a Unicode string or use
///              the character set from a Windows ANSI code page, as specified by the <i>iCharset</i> parameter.
///    cString = Length of the string to analyze. The length is measured in characters for an ANSI string or in wide characters
///              for a Unicode string. The length must be at least 1.
///    cGlyphs = Size of the glyph buffer, in WORD values. This size is required. The recommended size is <code>(1.5 * cString +
///              16)</code>.
///    iCharset = Character set descriptor. If the input string is an ANSI string, this descriptor is set to the character set
///               identifier. If the string is a Unicode string, this descriptor is set to -1. The following character set
///               identifiers are defined:
///    dwFlags = Flags indicating the analysis that is required. This parameter can have one of the values listed in the following
///              table. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SSA_BREAK"></a><a
///              id="ssa_break"></a><dl> <dt><b>SSA_BREAK</b></dt> </dl> </td> <td width="60%"> Retrieve break flags, that is,
///              character and word stops. </td> </tr> <tr> <td width="40%"><a id="SSA_CLIP"></a><a id="ssa_clip"></a><dl>
///              <dt><b>SSA_CLIP</b></dt> </dl> </td> <td width="60%"> Clip the string at <i>iReqWidth.</i> </td> </tr> <tr> <td
///              width="40%"><a id="SSA_DZWG"></a><a id="ssa_dzwg"></a><dl> <dt><b>SSA_DZWG</b></dt> </dl> </td> <td width="60%">
///              Provide representation glyphs for control characters. </td> </tr> <tr> <td width="40%"><a
///              id="SSA_FALLBACK"></a><a id="ssa_fallback"></a><dl> <dt><b>SSA_FALLBACK</b></dt> </dl> </td> <td width="60%"> Use
///              fallback fonts. </td> </tr> <tr> <td width="40%"><a id="SSA_FIT"></a><a id="ssa_fit"></a><dl>
///              <dt><b>SSA_FIT</b></dt> </dl> </td> <td width="60%"> Justify the string to <i>iReqWidth</i>. </td> </tr> <tr> <td
///              width="40%"><a id="SSA_GCP"></a><a id="ssa_gcp"></a><dl> <dt><b>SSA_GCP</b></dt> </dl> </td> <td width="60%">
///              Retrieve missing glyphs and <i>pwLogClust</i> with GetCharacterPlacement conventions. </td> </tr> <tr> <td
///              width="40%"><a id="SSA_GLYPHS"></a><a id="ssa_glyphs"></a><dl> <dt><b>SSA_GLYPHS</b></dt> </dl> </td> <td
///              width="60%"> Generate glyphs, positions, and attributes. </td> </tr> <tr> <td width="40%"><a
///              id="SSA_HIDEHOTKEY"></a><a id="ssa_hidehotkey"></a><dl> <dt><b>SSA_HIDEHOTKEY</b></dt> </dl> </td> <td
///              width="60%"> Remove the first "&amp;" from displayed string. </td> </tr> <tr> <td width="40%"><a
///              id="SSA_HOTKEY"></a><a id="ssa_hotkey"></a><dl> <dt><b>SSA_HOTKEY</b></dt> </dl> </td> <td width="60%"> Replace
///              "&amp;" with underline on subsequent code point. </td> </tr> <tr> <td width="40%"><a id="SSA_HOTKEYONLY"></a><a
///              id="ssa_hotkeyonly"></a><dl> <dt><b>SSA_HOTKEYONLY</b></dt> </dl> </td> <td width="60%"> Display underline only.
///              The resulting bit pattern might be displayed, using an XOR mask, to toggle the visibility of the hotkey underline
///              without disturbing the text. </td> </tr> <tr> <td width="40%"><a id="SSA_LINK"></a><a id="ssa_link"></a><dl>
///              <dt><b>SSA_LINK</b></dt> </dl> </td> <td width="60%"> Apply East Asian font linking and association to noncomplex
///              text. </td> </tr> <tr> <td width="40%"><a id="SSA_METAFILE"></a><a id="ssa_metafile"></a><dl>
///              <dt><b>SSA_METAFILE</b></dt> </dl> </td> <td width="60%"> Write items with ExtTextOutW calls, not with glyphs.
///              </td> </tr> <tr> <td width="40%"><a id="SSA_PASSWORD"></a><a id="ssa_password"></a><dl>
///              <dt><b>SSA_PASSWORD</b></dt> </dl> </td> <td width="60%"> Duplicate input string containing a single character
///              <i>cString</i> times. </td> </tr> <tr> <td width="40%"><a id="SSA_RTL"></a><a id="ssa_rtl"></a><dl>
///              <dt><b>SSA_RTL</b></dt> </dl> </td> <td width="60%"> Use base embedding level 1. </td> </tr> <tr> <td
///              width="40%"><a id="SSA_TAB"></a><a id="ssa_tab"></a><dl> <dt><b>SSA_TAB</b></dt> </dl> </td> <td width="60%">
///              Expand tabs. </td> </tr> </table>
///    iReqWidth = Width required for fitting or clipping.
///    psControl = Pointer to a SCRIPT_CONTROL structure. The application can set this parameter to <b>NULL</b> to indicate that all
///                <b>SCRIPT_CONTROL</b> members are set to 0.
///    psState = Pointer to a SCRIPT_STATE structure. The application can set this parameter to <b>NULL</b> to indicate that all
///              <b>SCRIPT_STATE</b> members are set to 0. The <b>uBidiLevel</b> member of <b>SCRIPT_STATE</b> is ignored. The
///              value used is derived from the SSA_RTL flag in combination with the layout of the device context.
///    piDx = Pointer to the requested logical dx array.
///    pTabdef = Pointer to a SCRIPT_TABDEF structure. This value is only required if <i>dwFlags</i> is set to SSA_TAB.
///    pbInClass = Pointer to a BYTE value that indicates GetCharacterPlacement character classifications.
///    pssa = Pointer to a buffer in which this function retrieves a SCRIPT_STRING_ANALYSIS structure. This structure is
///           dynamically allocated on successful return from the function.
///Returns:
///    Returns S_OK if successful. The function returns a nonzero HRESULT value if it does not succeed. Error returns
///    include: <ul> <li>E_INVALIDARG. An invalid parameter is found.</li> <li>USP_E_SCRIPT_NOT_IN_FONT. SSA_FALLBACK
///    has not been specified, or a standard fallback font is missing.</li> </ul> The function can also return a system
///    error converted to an HRESULT type. An example is an error returned due to lack of memory or a GDI call using the
///    device context.
///    
@DllImport("USP10")
HRESULT ScriptStringAnalyse(HDC hdc, const(void)* pString, int cString, int cGlyphs, int iCharset, uint dwFlags, 
                            int iReqWidth, SCRIPT_CONTROL* psControl, SCRIPT_STATE* psState, const(int)* piDx, 
                            SCRIPT_TABDEF* pTabdef, const(ubyte)* pbInClass, void** pssa);

///Frees a SCRIPT_STRING_ANALYSIS structure.
///Params:
///    pssa = Pointer to a SCRIPT_STRING_ANALYSIS structure.
///Returns:
///    Returns S_OK if successful. The function returns a nonzero HRESULT value if it does not succeed. The application
///    can test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros.
///    
@DllImport("USP10")
HRESULT ScriptStringFree(void** pssa);

///Returns a pointer to a SIZE structure for an analyzed string.
///Params:
///    ssa = A SCRIPT_STRING_ANALYSIS structure for a string.
///Returns:
///    Returns a pointer to a SIZE structure containing the size (width and height) of the analyzed string if
///    successful. The function returns <b>NULL</b> if it does not succeed.
///    
@DllImport("USP10")
SIZE* ScriptString_pSize(void* ssa);

///Returns a pointer to the length of a string after clipping.
///Params:
///    ssa = A SCRIPT_STRING_ANALYSIS structure for the string.
///Returns:
///    Returns a pointer to the length of the string after clipping if successful. The length is the number of Unicode
///    code points. The function returns <b>NULL</b> if it does not succeed.
///    
@DllImport("USP10")
int* ScriptString_pcOutChars(void* ssa);

///Returns a pointer to a logical attributes buffer for an analyzed string.
///Params:
///    ssa = A SCRIPT_STRING_ANALYSIS structure for the string.
///Returns:
///    Returns a pointer to a buffer containing SCRIPT_LOGATTR structures defining logical attributes if successful. The
///    function returns <b>NULL</b> if it does not succeed.
///    
@DllImport("USP10")
SCRIPT_LOGATTR* ScriptString_pLogAttr(void* ssa);

///Creates an array that maps an original character position to a glyph position.
///Params:
///    ssa = A SCRIPT_STRING_ANALYSIS structure for the string.
///    puOrder = Pointer to a buffer in which this function retrieves an array of glyph positions, indexed by the original
///              character position. The array should have room for at least the number of integers indicated by the <i>ssa</i>
///              parameter of ScriptString_pcOutChars.
///Returns:
///    Returns S_OK if successful. The function returns a nonzero HRESULT value if it does not succeed. The application
///    can test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros.
///    
@DllImport("USP10")
HRESULT ScriptStringGetOrder(void* ssa, uint* puOrder);

///Retrieves the x coordinate for the leading or trailing edge of a character position.
///Params:
///    ssa = A SCRIPT_STRING_ANALYSIS structure for the string.
///    icp = Character position in the string.
///    fTrailing = <b>TRUE</b> to indicate the trailing edge of the character position (<i>icp</i>) that corresponds to the x
///                coordinate. This parameter is set to <b>FALSE</b> to indicate the leading edge of the character position.
///    pX = Pointer to a buffer in which this function retrieves the x coordinate corresponding to the character position.
///Returns:
///    Returns S_OK if successful. The function returns a nonzero HRESULT value if it does not succeed. The application
///    can test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros.
///    
@DllImport("USP10")
HRESULT ScriptStringCPtoX(void* ssa, int icp, BOOL fTrailing, int* pX);

///Converts an x coordinate to a character position.
///Params:
///    ssa = A SCRIPT_STRING_ANALYSIS structure for the string.
///    iX = The x coordinate.
///    piCh = Pointer to a variable in which this function retrieves the character position corresponding to the x coordinate.
///    piTrailing = Pointer to a variable in which this function retrieves a value indicating if the x coordinate is for the leading
///                 edge or the trailing edge of the character position. For more information, see the Remarks section.
///Returns:
///    Returns S_OK if successful. The function returns a nonzero HRESULT value if it does not succeed. The application
///    can test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros.
///    
@DllImport("USP10")
HRESULT ScriptStringXtoCP(void* ssa, int iX, int* piCh, int* piTrailing);

///Converts visual widths into logical widths.
///Params:
///    ssa = A SCRIPT_STRING_ANALYSIS structure for the string.
///    piDx = Pointer to a buffer in which this function retrieves logical widths. The buffer should have room for at least the
///           number of integers indicated by the <i>ssa</i> parameter of ScriptString_pcOutChars.
///Returns:
///    Returns S_OK if successful. The function returns a nonzero HRESULT value if it does not succeed. The application
///    can test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros.
///    
@DllImport("USP10")
HRESULT ScriptStringGetLogicalWidths(void* ssa, int* piDx);

///Checks a SCRIPT_STRING_ANALYSIS structure for invalid sequences.
///Params:
///    ssa = A SCRIPT_STRING_ANALYSIS structure for a string.
///Returns:
///    Returns S_OK if no invalid sequences are found. The function returns S_FALSE if one or more invalid sequences are
///    found. The function returns a nonzero HRESULT value if it does not succeed.
///    
@DllImport("USP10")
HRESULT ScriptStringValidate(void* ssa);

///Displays a string generated by a prior call to ScriptStringAnalyse and optionally adds highlighting.
///Params:
///    ssa = A SCRIPT_STRING_ANALYSIS structure for the string.
///    iX = The x-coordinate of the reference point used to position the string.
///    iY = The y-coordinate of the reference point used to position the string.
///    uOptions = Options specifying the use of the application-defined rectangle. This parameter can be set to 0 or to any of the
///               following values. The values can be combined with binary OR. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///               <tr> <td width="40%"><a id="ETO_CLIPPED"></a><a id="eto_clipped"></a><dl> <dt><b>ETO_CLIPPED</b></dt> </dl> </td>
///               <td width="60%"> Clip text to the rectangle. </td> </tr> <tr> <td width="40%"><a id="ETO_OPAQUE"></a><a
///               id="eto_opaque"></a><dl> <dt><b>ETO_OPAQUE</b></dt> </dl> </td> <td width="60%"> Use current background color to
///               fill the rectangle. </td> </tr> </table>
///    prc = Pointer to a RECT structure that defines the rectangle to use. If <i>uOptions</i> is set to ETO_OPAQUE and
///          <b>NULL</b> is provided for <i>prc</i>, the function succeeds and returns S_OK. However, if the application sets
///          <i>uOptions</i> to ETO_CLIPPING and provides <b>NULL</b> for <i>prc</i>, the function returns E_INVALIDARG. The
///          application can set this parameter to <b>NULL</b> to indicate that no option is needed.
///    iMinSel = Zero-based index specifying the starting position in the string. For no selection, the application should set
///              <i>iMinSel</i> &gt;= <i>iMaxSel</i>.
///    iMaxSel = Zero-based index specifying the ending position in the string.
///    fDisabled = <b>TRUE</b> if the operating system applies disabled-text highlighting by setting the background color to
///                COLOR_HIGHLIGHT behind all selected characters. The application can set this parameter to <b>FALSE</b> if the
///                operating system applies enabled-text highlighting by setting the background color to COLOR_HIGHLIGHT and the
///                text color to COLOR_HIGHLIGHTTEXT for each selected character.
///Returns:
///    Returns S_OK if successful. The function returns a nonzero <b>HRESULT</b> value if it does not succeed. The
///    application can't test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros.
///    
@DllImport("USP10")
HRESULT ScriptStringOut(void* ssa, int iX, int iY, uint uOptions, const(RECT)* prc, int iMinSel, int iMaxSel, 
                        BOOL fDisabled);

///Determines whether a Unicode string requires complex script processing.
///Params:
///    pwcInChars = Pointer to the string to test.
///    cInChars = Length of the input string, in characters.
///    dwFlags = Flags specifying testing details. This parameter can have one of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SIC_ASCIIDIGIT"></a><a
///              id="sic_asciidigit"></a><dl> <dt><b>SIC_ASCIIDIGIT</b></dt> </dl> </td> <td width="60%"> Treat digits U+0030 to
///              U+0039 as complex. The application sets this flag if the string is displayed with digit substitution enabled. If
///              the application is following the user's National Language Support (NLS) settings using the
///              ScriptRecordDigitSubstitution function, it can pass a SCRIPT_DIGITSUBSTITUTE structure with the
///              <b>DigitSubstitute</b> member set to SCRIPT_DIGITSUBSTITUTE_NONE. </td> </tr> <tr> <td width="40%"><a
///              id="SIC_COMPLEX"></a><a id="sic_complex"></a><dl> <dt><b>SIC_COMPLEX</b></dt> </dl> </td> <td width="60%"> Treat
///              complex script letters as complex. This flag should normally be set. </td> </tr> <tr> <td width="40%"><a
///              id="SIC_NEUTRAL"></a><a id="sic_neutral"></a><dl> <dt><b>SIC_NEUTRAL</b></dt> </dl> </td> <td width="60%"> Treat
///              neutrals as complex. The application sets this flag to display the string with right-to-left reading order. </td>
///              </tr> </table>
///Returns:
///    Returns S_OK if the string requires complex script processing. The function returns S_FALSE if the string can be
///    handled by standard API function calls, that is, it contains only characters laid out side-by-side and
///    left-to-right. The function returns a nonzero HRESULT value if it does not succeed.
///    
@DllImport("USP10")
HRESULT ScriptIsComplex(const(PWSTR) pwcInChars, int cInChars, uint dwFlags);

///Reads the National Language Support (NLS) native digit and digit substitution settings and records them in a
///SCRIPT_DIGITSUBSTITUTE structure. For more information, see Digit Shapes.
///Params:
///    Locale = Locale identifier of the locale to query. Typically, the application should set this parameter to
///             LOCALE_USER_DEFAULT. Alternatively, the setting can indicate a specific locale combined with
///             LOCALE_NOUSEROVERRIDE to obtain the default settings.
///    psds = Pointer to a SCRIPT_DIGITSUBSTITUTE structure. This structure can be passed later to
///           ScriptApplyDigitSubstitution.
///Returns:
///    Returns S_OK if successful. The function returns a nonzero HRESULT value if it does not succeed. Error returns
///    include: <ul> <li>E_INVALIDARG. The <i>Locale</i> parameter indicates a locale that is invalid or not
///    installed.</li> <li>E_POINTER. The <i>psds</i> parameter is set to <b>NULL</b>.</li> </ul>
///    
@DllImport("USP10")
HRESULT ScriptRecordDigitSubstitution(uint Locale, SCRIPT_DIGITSUBSTITUTE* psds);

///Applies the specified digit substitution settings to the specified script control and script state structures.
///Params:
///    psds = Pointer to a SCRIPT_DIGITSUBSTITUTE structure. The application sets this parameter to <b>NULL</b> if the function
///           is to call ScriptRecordDigitSubstitution with LOCALE_USER_DEFAULT.
///    psc = Pointer to a SCRIPT_CONTROL structure with the <b>fContextDigits</b> and <b>uDefaultLanguage</b> members updated.
///    pss = Pointer to a SCRIPT_STATE structure with the <b>fDigitSubstitute</b> member updated.
///Returns:
///    Returns S_OK if successful. The function returns a nonzero HRESULT value if it does not succeed. The function
///    returns E_INVALIDARG if it does not recognize the <b>DigitSubstitute</b> member of SCRIPT_DIGITSUBSTITUTE.
///    
@DllImport("USP10")
HRESULT ScriptApplyDigitSubstitution(const(SCRIPT_DIGITSUBSTITUTE)* psds, SCRIPT_CONTROL* psc, SCRIPT_STATE* pss);

///Generates glyphs and visual attributes for a Unicode run with OpenType information. Each run consists of one call to
///this function.
///Params:
///    hdc = Handle to the device context. For more information, see Caching.
///    psc = Pointer to a SCRIPT_CACHE structure identifying the script cache.
///    psa = Pointer to a SCRIPT_ANALYSIS structure obtained from a previous call to ScriptItemizeOpenType. The structure
///          identifies the shaping engine, so that glyphs can be formed correctly. Alternatively, the application can set
///          this parameter to <b>NULL</b> to receive unfiltered results.
///    tagScript = An OPENTYPE_TAG structure defining the OpenType script tag for the writing system.
///    tagLangSys = An OPENTYPE_TAG structure containing the OpenType language tag for the writing system.
///    rcRangeChars = Array of characters in each range. The number of array elements is indicated by <i>cRanges</i>. The values of the
///                   elements of this array add up to the value of <i>cChars</i>.
///    rpRangeProperties = Array of TEXTRANGE_PROPERTIES structures, each representing one OpenType feature range. The number of structures
///                        is indicated by the <i>cRanges</i> parameter. For more information on <i>rpRangeProperties</i>, see the Remarks
///                        section.
///    cRanges = The number of OpenType feature ranges.
///    pwcChars = Pointer to an array of Unicode characters containing the run.
///    cChars = Number of characters in the Unicode run.
///    cMaxGlyphs = Maximum number of glyphs to generate.
///    pwLogClust = Pointer to a buffer in which this function retrieves an array of logical cluster information. Each array element
///                 corresponds to a character in the array of Unicode characters. The value of each element is the offset from the
///                 first glyph in the run to the first glyph in the cluster containing the corresponding character. Note that, when
///                 the <b>fRTL</b> member of the SCRIPT_ANALYSIS structure is <b>TRUE</b>, the elements decrease as the array is
///                 read.
///    pCharProps = Pointer to a buffer in which this function retrieves an array of character property values, of length indicated
///                 by <i>cChars</i>.
///    pwOutGlyphs = Pointer to a buffer in which this function retrieves an array of glyphs.
///    pOutGlyphProps = Pointer to a buffer in which this function retrieves an array of attributes for each of the retrieved glyphs. The
///                     length of the values equals the value of <i>pcGlyphs</i>. Since one glyph property is indicated per glyph, the
///                     value of this parameter indicates the number of elements specified by <i>cMaxGlyphs</i>.
///    pcGlyphs = Pointer to the location in which this function retrieves the number of glyphs indicated in <i>pwOutGlyphs</i>.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. In all error cases,
///    the content of all output array values is undefined. Error returns include: <ul> <li>E_OUTOFMEMORY. The output
///    buffer length indicated by <i>cMaxGlyphs</i> is insufficient.</li> <li>E_PENDING. The script cache specified by
///    the <i>psc</i> parameter does not contain enough information to shape the string, and the device context has been
///    passed as <b>NULL</b> so that the function is unable to complete the shaping process. The application should set
///    up a correct device context for the run and call this function again with the appropriate context value in
///    <i>hdc</i> and with all other parameters the same.</li> <li>USP_E_SCRIPT_NOT_IN_FONT. The font corresponding to
///    the device context does not support the required script. The application should choose another font, using either
///    ScriptGetCMap or another method to select the font.</li> </ul>
///    
@DllImport("USP10")
HRESULT ScriptShapeOpenType(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, 
                            int* rcRangeChars, textrange_properties** rpRangeProperties, int cRanges, 
                            const(PWSTR) pwcChars, int cChars, int cMaxGlyphs, ushort* pwLogClust, 
                            script_charprop* pCharProps, ushort* pwOutGlyphs, script_glyphprop* pOutGlyphProps, 
                            int* pcGlyphs);

///Generates glyphs and visual attributes for a Unicode run with OpenType information from the output of
///ScriptShapeOpenType.
///Params:
///    hdc = Handle to the device context. For more information, see Caching.
///    psc = Pointer to a SCRIPT_CACHE structure identifying the script cache.
///    psa = Pointer to a SCRIPT_ANALYSIS structure obtained from a previous call to ScriptItemizeOpenType. This structures
///          identifies the shaping engine that governs the generated list of glyphs and their associated widths, and x and y
///          placement offsets. Alternatively, the application can set this parameter to <b>NULL</b> to receive unfiltered
///          results.
///    tagScript = An OPENTYPE_TAG structure containing the OpenType script tag for the writing system to use.
///    tagLangSys = An OPENTYPE_TAG structure containing the OpenType language tag for the writing system.
///    rcRangeChars = Array of the number of characters in each range. The number of members is indicated in the <i>cRanges</i>
///                   parameter. The total of values should equal the value of <i>cChars</i>.
///    rpRangeProperties = Array of TEXTRANGE_PROPERTIES structures defining properties for each range. The number of elements is defined by
///                        the <i>cRanges</i> parameter.
///    cRanges = The number of OpenType feature ranges.
///    pwcChars = Pointer to an array of Unicode characters containing the run. The number of elements is defined by the
///               <i>cRanges</i> parameter.
///    pwLogClust = Pointer to an array of logical cluster information. Each element in the array corresponds to a character in the
///                 array defined by <i>pwcChars</i>. The value of each element is the offset from the first glyph in the run to the
///                 first glyph in the cluster containing the corresponding character. Note that, when the <b>fRTL</b> member of the
///                 SCRIPT_ANALYSIS structure is set to <b>TRUE</b>, the elements in <i>pwLogClust</i> decrease as the array is read.
///    pCharProps = Pointer to an array of character property values in the Unicode run.
///    cChars = Number of characters in the Unicode run.
///    pwGlyphs = Pointer to a glyph buffer obtained from an earlier call to the ScriptShapeOpenType function.
///    pGlyphProps = Pointer to an array of attributes for each of the glyphs to retrieve. The number of values equals the value of
///                  <i>cGlyphs</i>. Since there is one glyph property per glyph, this parameter has the number of elements indicated
///                  by <i>cGlyphs</i>.
///    cGlyphs = Count of glyphs in a glyph array buffer.
///    piAdvance = Pointer to an array, of length indicated by <i>cGlyphs</i>, in which this function retrieves advance width
///                information.
///    pGoffset = Pointer to an array of GOFFSET structures in which this structure retrieves the x and y offsets of combining
///               glyphs. This array must be of length indicated by <i>cGlyphs</i>.
///    pABC = Pointer to an ABC structure in which this function retrieves the ABC width for the entire run.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. In all error cases,
///    the output values are undefined. The application can test the return value with the <b>SUCCEEDED</b> and
///    <b>FAILED</b> macros. The function returns E_OUTOFMEMORY if the output buffer length indicated by <i>cGlyphs</i>
///    is too small. The application can try calling again with larger buffers. The function returns E_PENDING if the
///    script cache specified by the <i>psc</i> parameter does not contain enough information to place the glyphs, and
///    the <i>hdc</i> parameter is passed as <b>NULL</b> so that the function is unable to complete the placement
///    process. The application should set up a correct device context for the run, and call this function again with
///    the appropriate value in <i>hdc</i> and with all other parameters the same.
///    
@DllImport("USP10")
HRESULT ScriptPlaceOpenType(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, 
                            int* rcRangeChars, textrange_properties** rpRangeProperties, int cRanges, 
                            const(PWSTR) pwcChars, ushort* pwLogClust, script_charprop* pCharProps, int cChars, 
                            const(ushort)* pwGlyphs, const(script_glyphprop)* pGlyphProps, int cGlyphs, 
                            int* piAdvance, GOFFSET* pGoffset, ABC* pABC);

///Breaks a Unicode string into individually shapeable items and provides an array of feature tags for each shapeable
///item for OpenType processing.
///Params:
///    pwcInChars = Pointer to a Unicode string to itemize.
///    cInChars = Number of characters in <i>pwcInChars</i> to itemize.
///    cMaxItems = Maximum number of SCRIPT_ITEM structures defining items to process.
///    psControl = Pointer to a SCRIPT_CONTROL structure indicating the type of itemization to perform. Alternatively, the
///                application can set this parameter to <b>NULL</b> if no SCRIPT_CONTROL properties are needed. For more
///                information, see the Remarks section.
///    psState = Pointer to a SCRIPT_STATE structure indicating the initial bidirectional algorithm state. Alternatively, the
///              application can set this parameter to <b>NULL</b> if the script state is not needed. For more information, see
///              the Remarks section.
///    pItems = Pointer to a buffer in which the function retrieves SCRIPT_ITEM structures representing the items that have been
///             processed. The buffer should be <code>(cMaxItems + 1) * sizeof(SCRIPT_ITEM)</code> bytes in length. It is invalid
///             to call this function with a buffer that handles less than two <b>SCRIPT_ITEM</b> structures. The function always
///             adds a terminal item to the item analysis array so that the length of the item with zero-based index "i" is
///             always available as: <code>pItems[i+1].iCharPos - pItems[i].iCharPos;</code>
///    pScriptTags = Pointer to a buffer in which the function retrieves an array of OPENTYPE_TAG structures representing script tags.
///                  The buffer should be <code>cMaxItems * sizeof(OPENTYPE_TAG)</code> bytes in length. <div
///                  class="alert"><b>Note</b> When all characters in an item are neutral, the value of this parameter is
///                  SCRIPT_TAG_UNKNOWN (0x00000000). This can happen, for example, if an item consists entirely of punctuation.</div>
///                  <div> </div>
///    pcItems = Pointer to the number of SCRIPT_ITEM structures processed.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. In all error cases,
///    no items are fully processed and no part of the output contains defined values. The application can test the
///    return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros. The function returns E_OUTOFMEMORY if the size
///    indicated by <i>cMaxItems</i> is too small. The application can try calling the function again with a larger
///    buffer. The function returns E_INVALIDARG if one or more of the following conditions occur: <ul>
///    <li><i>pwcInChars</i> is set to <b>NULL</b></li> <li><i>cInChars</i> is 0</li> <li><i>pItems</i> is set to
///    <b>NULL</b></li> <li><i>pScriptTags</i> is set to <b>NULL</b></li> <li><i>cMaxItems</i> &lt; 2</li> </ul>
///    
@DllImport("USP10")
HRESULT ScriptItemizeOpenType(const(PWSTR) pwcInChars, int cInChars, int cMaxItems, 
                              const(SCRIPT_CONTROL)* psControl, const(SCRIPT_STATE)* psState, SCRIPT_ITEM* pItems, 
                              uint* pScriptTags, int* pcItems);

///Retrieves a list of scripts available in the font for OpenType processing. Scripts comprising the list are retrieved
///from the font located in the supplied device context or from the script shaping engine that processes the font of the
///current run.
///Params:
///    hdc = Handle to the device context. For more information, see Caching.
///    psc = Pointer to a SCRIPT_CACHE structure identifying the script cache.
///    psa = Pointer to a SCRIPT_ANALYSIS structure obtained from a previous call to ScriptItemizeOpenType. This parameter
///          identifies the shaping engine, so that the appropriate font script tags can be retrieved. The application
///          supplies a non-<b>NULL</b> value for this parameter to retrieve script tags appropriate for the current run.
///          Alternatively, the application can set this parameter to <b>NULL</b> to retrieve unfiltered results.
///    cMaxTags = The length of the array specified by <i>pScriptTags</i>.
///    pScriptTags = Pointer to a buffer in which this function retrieves an array of OPENTYPE_TAG structures defining script tags
///                  from the device context or the scripting engine associated with the current run. If the value of the
///                  <b>eScript</b> member of the SCRIPT_ANALYSIS structure provided in the <i>psa</i> parameter has a definite script
///                  tag associated with it and the tag is present in the font, <i>pScriptTags</i> contains only this tag.
///    pcTags = Pointer to the number of elements in the script tag array indicated by <i>pScriptTags</i>.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. The application can
///    test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros. If the number of matching tags exceeds
///    the value of <i>cMaxTags</i>, the function fails with E_OUTOFMEMORY. The application can try calling again with
///    larger buffers.
///    
@DllImport("USP10")
HRESULT ScriptGetFontScriptTags(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, int cMaxTags, uint* pScriptTags, 
                                int* pcTags);

///Retrieves a list of language tags that are available for the specified item and are supported by a specified script
///tag for OpenType processing. The tags comprising the list are retrieved from the font in the specified device context
///or cache.
///Params:
///    hdc = Handle to the device context. For more information, see Caching.
///    psc = Pointer to a SCRIPT_CACHE structure identifying the script cache.
///    psa = Pointer to a SCRIPT_ANALYSIS structure obtained from a previous call to ScriptItemizeOpenType. This parameter
///          identifies the shaping engine, so that the font language tags for the appropriate font and scripts can be
///          retrieved. Alternately, the application can set this parameter to <b>NULL</b> to retrieve unfiltered results.
///    tagScript = An OPENTYPE_TAG structure defining the script tag for which the list of associated language tags is requested.
///    cMaxTags = The length of the array specified by <i>pLangSysTags</i>.
///    pLangsysTags = Pointer to a buffer in which this function retrieves an array of OPENTYPE_TAG structures identifying the language
///                   tags matching input criteria.
///    pcTags = Pointer to the number of elements in the language tag array.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. The application can
///    test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros. If the number of matching tags exceeds
///    <i>cMaxTags</i>, the function fails with E_OUTOFMEMORY. The application can try calling again with larger
///    buffers.
///    
@DllImport("USP10")
HRESULT ScriptGetFontLanguageTags(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, int cMaxTags, 
                                  uint* pLangsysTags, int* pcTags);

///Retrieves a list of typographic features for the defined writing system for OpenType processing. The typographic
///feature tags comprising the list are retrieved from the font in the supplied device context or cache.
///Params:
///    hdc = Handle to the device context. For more information, see Caching.
///    psc = Pointer to a SCRIPT_CACHE structure identifying the script cache.
///    psa = Pointer to a SCRIPT_ANALYSIS structure obtained from a previous call to ScriptItemizeOpenType. This parameter
///          identifies the shaping engine, so that the font feature tags for the appropriate font and scripts can be
///          retrieved. Alternatively, the application can set this parameter to <b>NULL</b> to retrieve unfiltered results.
///    tagScript = An OPENTYPE_TAG structure defining the script tag associated with the specified feature tags.
///    tagLangSys = An <b>OPENTYPE_TAG</b> structure defining the language tag associated with the specified feature tags.
///    cMaxTags = The length of the array specified by <i>pFeatureTags</i>.
///    pFeatureTags = Pointer to a buffer in which this function retrieves an array of <b>OPENTYPE_TAG</b> structures defining the
///                   typographic feature tags supported by the font in the device context or cache for the defined writing system.
///    pcTags = Pointer to the number of elements in the feature tag array.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. The application can
///    test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros. If the number of matching tags exceeds
///    the value of <i>cMaxTags</i>, the function fails with E_OUTOFMEMORY. The application can try calling again with
///    larger buffers.
///    
@DllImport("USP10")
HRESULT ScriptGetFontFeatureTags(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, 
                                 int cMaxTags, uint* pFeatureTags, int* pcTags);

///Retrieves a list of alternate glyphs for a specified character that can be accessed through a specified OpenType
///feature.
///Params:
///    hdc = Handle to the device context. For more information, see Caching.
///    psc = Pointer to a SCRIPT_CACHE structure defining the script cache.
///    psa = Pointer to a SCRIPT_ANALYSIS structure obtained from a previous call to ScriptItemizeOpenType. This parameter
///          identifies the shaping engine, so that the array of alternate glyphs can be created with the correct scope.
///          Alternatively, the application can set this parameter to <b>NULL</b> to receive unfiltered results.
///    tagScript = An OPENTYPE_TAG structure defining the script tag associated with alternate glyphs.
///    tagLangSys = An OPENTYPE_TAG structure defining the language tag associated with alternate glyphs.
///    tagFeature = An OPENTYPE_TAG structure defining the feature tag associated with alternate glyphs.
///    wGlyphId = The identifier of the original glyph mapped from the character map table.
///    cMaxAlternates = Length of the array specified by <i>pAlternateGlyphs</i>.
///    pAlternateGlyphs = Pointer to buffer in which this function retrieves an array of glyph identifiers. The array includes the original
///                       glyph, followed by alternate glyphs. The first element is always the original glyph. Alternate forms are
///                       identified by an index into the array. The index is a value greater than one and less than the value of
///                       <i>pcAlternates</i>. When the user chooses an alternate form from the user interface, the alternate glyph is
///                       applied to the corresponding character and the rendering is reformatted.
///    pcAlternates = Pointer to the number of elements in the array specified by <i>pAlternateGlyphs</i>.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. The application can
///    test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros. If the number of alternate glyphs
///    exceeds the value of <i>cMaxAlternates</i>, the function fails with E_OUTOFMEMORY. The application can try
///    calling again with larger buffers.
///    
@DllImport("USP10")
HRESULT ScriptGetFontAlternateGlyphs(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, 
                                     uint tagFeature, ushort wGlyphId, int cMaxAlternates, ushort* pAlternateGlyphs, 
                                     int* pcAlternates);

///Enables substitution of a single glyph with one alternate form of the same glyph for OpenType processing.
///Params:
///    hdc = Handle to the device context. For more information, see Caching.
///    psc = Pointer to a SCRIPT_CACHE structure indicating the script cache.
///    psa = Pointer to a SCRIPT_ANALYSIS structure obtained from a previous call to ScriptItemizeOpenType. This parameter
///          identifies the shaping engine so that the correct substitute glyph is used. Alternatively, the application can
///          set this parameter to <b>NULL</b> to retrieve unfiltered results.
///    tagScript = An OPENTYPE_TAG structure defining the script tag for shaping.
///    tagLangSys = An OPENTYPE_TAG structure defining the language tag for shaping.
///    tagFeature = An OPENTYPE_TAG structure defining the feature tag to use for shaping the alternate glyph.
///    lParameter = Reference to the alternate glyph to substitute. This reference is an index to an array that contains all the
///                 alternate glyphs defined in the feature, as illustrated for OPENTYPE_FEATURE_RECORD. The alternate glyph array is
///                 one of the items retrieved by ScriptGetFontAlternateGlyphs.
///    wGlyphId = Identifier of the original glyph.
///    pwOutGlyphId = Pointer to the location in which this function retrieves the identifier of the alternate glyph.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. The application can
///    test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros.
///    
@DllImport("USP10")
HRESULT ScriptSubstituteSingleGlyph(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, 
                                    uint tagFeature, int lParameter, ushort wGlyphId, ushort* pwOutGlyphId);

///Positions a single glyph with a single adjustment using a specified feature provided in the font for OpenType
///processing. Most often, applications use this function to align a glyph optically at the beginning or end of a line.
///Params:
///    hdc = Handle to the device context. For more information, see Caching.
///    psc = Pointer to a SCRIPT_CACHE structure identifying the script cache.
///    psa = Pointer to a SCRIPT_ANALYSIS structure obtained from a previous call to ScriptItemizeOpenType. This structure
///          identifies the shaping engine, so that the advance widths can be retrieved. Alternatively, the application can
///          set this parameter to <b>NULL</b> to retrieve unfiltered results.
///    tagScript = An OPENTYPE_TAG structure defining the script tag for shaping.
///    tagLangSys = An OPENTYPE_TAG structure defining the language tag for shaping.
///    tagFeature = An OPENTYPE_TAG structure defining the feature tag to use for shaping the alternate glyph.
///    lParameter = A flag specifying if single substitution should be applied to the identifier specified in <i>wGlyphId</i>. The
///                 application sets this parameter to 1 to apply the single substitution feature to the identifier. The application
///                 sets the parameter to 0 if the function should not apply the feature.
///    wGlyphId = The identifier of the original glyph being shaped.
///    iAdvance = The original glyph advance width.
///    GOffset = The original glyph offset. Typically, this value is an output of ScriptPlaceOpenType or ScriptPlace.
///    piOutAdvance = Pointer to the location in which this function retrieves the new advance width adjusted for the alternate glyph.
///    pOutGoffset = Pointer to the location in which this function retrieves the new glyph offset adjusted for the alternate glyph.
///Returns:
///    Returns 0 if successful. The function returns a nonzero HRESULT value if it does not succeed. The application can
///    test the return value with the <b>SUCCEEDED</b> and <b>FAILED</b> macros.
///    
@DllImport("USP10")
HRESULT ScriptPositionSingleGlyph(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, 
                                  uint tagFeature, int lParameter, ushort wGlyphId, int iAdvance, GOFFSET GOffset, 
                                  int* piOutAdvance, GOFFSET* pOutGoffset);

@DllImport("icu")
int utf8_nextCharSafeBody(const(ubyte)* s, int* pi, int length, int c, byte strict);

@DllImport("icu")
int utf8_appendCharSafeBody(ubyte* s, int i, int length, int c, byte* pIsError);

@DllImport("icu")
int utf8_prevCharSafeBody(const(ubyte)* s, int start, int* pi, int c, byte strict);

@DllImport("icu")
int utf8_back1SafeBody(const(ubyte)* s, int start, int i);

@DllImport("icu")
void u_versionFromString(ubyte* versionArray, const(byte)* versionString);

@DllImport("icu")
void u_versionFromUString(ubyte* versionArray, const(ushort)* versionString);

@DllImport("icu")
void u_versionToString(const(ubyte)* versionArray, byte* versionString);

@DllImport("icu")
void u_getVersion(ubyte* versionArray);

@DllImport("icu")
byte* u_errorName(UErrorCode code);

@DllImport("icu")
void utrace_setLevel(int traceLevel);

@DllImport("icu")
int utrace_getLevel();

@DllImport("icu")
void utrace_setFunctions(const(void)* context, UTraceEntry* e, UTraceExit* x, UTraceData* d);

@DllImport("icu")
void utrace_getFunctions(const(void)** context, UTraceEntry** e, UTraceExit** x, UTraceData** d);

@DllImport("icu")
int utrace_vformat(byte* outBuf, int capacity, int indent, const(byte)* fmt, byte* args);

@DllImport("icu")
int utrace_format(byte* outBuf, int capacity, int indent, const(byte)* fmt);

@DllImport("icu")
byte* utrace_functionName(int fnNumber);

@DllImport("icu")
int u_shapeArabic(const(ushort)* source, int sourceLength, ushort* dest, int destSize, uint options, 
                  UErrorCode* pErrorCode);

@DllImport("icu")
int uscript_getCode(const(byte)* nameOrAbbrOrLocale, UScriptCode* fillIn, int capacity, UErrorCode* err);

@DllImport("icu")
byte* uscript_getName(UScriptCode scriptCode);

@DllImport("icu")
byte* uscript_getShortName(UScriptCode scriptCode);

@DllImport("icu")
UScriptCode uscript_getScript(int codepoint, UErrorCode* err);

@DllImport("icu")
byte uscript_hasScript(int c, UScriptCode sc);

@DllImport("icu")
int uscript_getScriptExtensions(int c, UScriptCode* scripts, int capacity, UErrorCode* errorCode);

@DllImport("icu")
int uscript_getSampleString(UScriptCode script, ushort* dest, int capacity, UErrorCode* pErrorCode);

@DllImport("icu")
UScriptUsage uscript_getUsage(UScriptCode script);

@DllImport("icu")
byte uscript_isRightToLeft(UScriptCode script);

@DllImport("icu")
byte uscript_breaksBetweenLetters(UScriptCode script);

@DllImport("icu")
byte uscript_isCased(UScriptCode script);

@DllImport("icu")
int uiter_current32(UCharIterator* iter);

@DllImport("icu")
int uiter_next32(UCharIterator* iter);

@DllImport("icu")
int uiter_previous32(UCharIterator* iter);

@DllImport("icu")
uint uiter_getState(const(UCharIterator)* iter);

@DllImport("icu")
void uiter_setState(UCharIterator* iter, uint state, UErrorCode* pErrorCode);

@DllImport("icu")
void uiter_setString(UCharIterator* iter, const(ushort)* s, int length);

@DllImport("icu")
void uiter_setUTF16BE(UCharIterator* iter, const(byte)* s, int length);

@DllImport("icu")
void uiter_setUTF8(UCharIterator* iter, const(byte)* s, int length);

@DllImport("icu")
void uenum_close(UEnumeration* en);

@DllImport("icu")
int uenum_count(UEnumeration* en, UErrorCode* status);

@DllImport("icu")
ushort* uenum_unext(UEnumeration* en, int* resultLength, UErrorCode* status);

@DllImport("icu")
byte* uenum_next(UEnumeration* en, int* resultLength, UErrorCode* status);

@DllImport("icu")
void uenum_reset(UEnumeration* en, UErrorCode* status);

@DllImport("icu")
UEnumeration* uenum_openUCharStringsEnumeration(const(ushort)** strings, int count, UErrorCode* ec);

@DllImport("icu")
UEnumeration* uenum_openCharStringsEnumeration(const(byte)** strings, int count, UErrorCode* ec);

@DllImport("icu")
byte* uloc_getDefault();

@DllImport("icu")
void uloc_setDefault(const(byte)* localeID, UErrorCode* status);

@DllImport("icu")
int uloc_getLanguage(const(byte)* localeID, byte* language, int languageCapacity, UErrorCode* err);

@DllImport("icu")
int uloc_getScript(const(byte)* localeID, byte* script, int scriptCapacity, UErrorCode* err);

@DllImport("icu")
int uloc_getCountry(const(byte)* localeID, byte* country, int countryCapacity, UErrorCode* err);

@DllImport("icu")
int uloc_getVariant(const(byte)* localeID, byte* variant, int variantCapacity, UErrorCode* err);

@DllImport("icu")
int uloc_getName(const(byte)* localeID, byte* name, int nameCapacity, UErrorCode* err);

@DllImport("icu")
int uloc_canonicalize(const(byte)* localeID, byte* name, int nameCapacity, UErrorCode* err);

@DllImport("icu")
byte* uloc_getISO3Language(const(byte)* localeID);

@DllImport("icu")
byte* uloc_getISO3Country(const(byte)* localeID);

@DllImport("icu")
uint uloc_getLCID(const(byte)* localeID);

@DllImport("icu")
int uloc_getDisplayLanguage(const(byte)* locale, const(byte)* displayLocale, ushort* language, 
                            int languageCapacity, UErrorCode* status);

@DllImport("icu")
int uloc_getDisplayScript(const(byte)* locale, const(byte)* displayLocale, ushort* script, int scriptCapacity, 
                          UErrorCode* status);

@DllImport("icu")
int uloc_getDisplayCountry(const(byte)* locale, const(byte)* displayLocale, ushort* country, int countryCapacity, 
                           UErrorCode* status);

@DllImport("icu")
int uloc_getDisplayVariant(const(byte)* locale, const(byte)* displayLocale, ushort* variant, int variantCapacity, 
                           UErrorCode* status);

@DllImport("icu")
int uloc_getDisplayKeyword(const(byte)* keyword, const(byte)* displayLocale, ushort* dest, int destCapacity, 
                           UErrorCode* status);

@DllImport("icu")
int uloc_getDisplayKeywordValue(const(byte)* locale, const(byte)* keyword, const(byte)* displayLocale, 
                                ushort* dest, int destCapacity, UErrorCode* status);

@DllImport("icu")
int uloc_getDisplayName(const(byte)* localeID, const(byte)* inLocaleID, ushort* result, int maxResultSize, 
                        UErrorCode* err);

@DllImport("icu")
byte* uloc_getAvailable(int n);

@DllImport("icu")
int uloc_countAvailable();

@DllImport("icu")
byte** uloc_getISOLanguages();

@DllImport("icu")
byte** uloc_getISOCountries();

@DllImport("icu")
int uloc_getParent(const(byte)* localeID, byte* parent, int parentCapacity, UErrorCode* err);

@DllImport("icu")
int uloc_getBaseName(const(byte)* localeID, byte* name, int nameCapacity, UErrorCode* err);

@DllImport("icu")
UEnumeration* uloc_openKeywords(const(byte)* localeID, UErrorCode* status);

@DllImport("icu")
int uloc_getKeywordValue(const(byte)* localeID, const(byte)* keywordName, byte* buffer, int bufferCapacity, 
                         UErrorCode* status);

@DllImport("icu")
int uloc_setKeywordValue(const(byte)* keywordName, const(byte)* keywordValue, byte* buffer, int bufferCapacity, 
                         UErrorCode* status);

@DllImport("icu")
byte uloc_isRightToLeft(const(byte)* locale);

@DllImport("icu")
ULayoutType uloc_getCharacterOrientation(const(byte)* localeId, UErrorCode* status);

@DllImport("icu")
ULayoutType uloc_getLineOrientation(const(byte)* localeId, UErrorCode* status);

@DllImport("icu")
int uloc_acceptLanguageFromHTTP(byte* result, int resultAvailable, UAcceptResult* outResult, 
                                const(byte)* httpAcceptLanguage, UEnumeration* availableLocales, UErrorCode* status);

@DllImport("icu")
int uloc_acceptLanguage(byte* result, int resultAvailable, UAcceptResult* outResult, const(byte)** acceptList, 
                        int acceptListCount, UEnumeration* availableLocales, UErrorCode* status);

@DllImport("icu")
int uloc_getLocaleForLCID(uint hostID, byte* locale, int localeCapacity, UErrorCode* status);

@DllImport("icu")
int uloc_addLikelySubtags(const(byte)* localeID, byte* maximizedLocaleID, int maximizedLocaleIDCapacity, 
                          UErrorCode* err);

@DllImport("icu")
int uloc_minimizeSubtags(const(byte)* localeID, byte* minimizedLocaleID, int minimizedLocaleIDCapacity, 
                         UErrorCode* err);

@DllImport("icu")
int uloc_forLanguageTag(const(byte)* langtag, byte* localeID, int localeIDCapacity, int* parsedLength, 
                        UErrorCode* err);

@DllImport("icu")
int uloc_toLanguageTag(const(byte)* localeID, byte* langtag, int langtagCapacity, byte strict, UErrorCode* err);

@DllImport("icu")
byte* uloc_toUnicodeLocaleKey(const(byte)* keyword);

@DllImport("icu")
byte* uloc_toUnicodeLocaleType(const(byte)* keyword, const(byte)* value);

@DllImport("icu")
byte* uloc_toLegacyKey(const(byte)* keyword);

@DllImport("icu")
byte* uloc_toLegacyType(const(byte)* keyword, const(byte)* value);

@DllImport("icu")
UResourceBundle* ures_open(const(byte)* packageName, const(byte)* locale, UErrorCode* status);

@DllImport("icu")
UResourceBundle* ures_openDirect(const(byte)* packageName, const(byte)* locale, UErrorCode* status);

@DllImport("icu")
UResourceBundle* ures_openU(const(ushort)* packageName, const(byte)* locale, UErrorCode* status);

@DllImport("icu")
void ures_close(UResourceBundle* resourceBundle);

@DllImport("icu")
void ures_getVersion(const(UResourceBundle)* resB, ubyte* versionInfo);

@DllImport("icu")
byte* ures_getLocaleByType(const(UResourceBundle)* resourceBundle, ULocDataLocaleType type, UErrorCode* status);

@DllImport("icu")
ushort* ures_getString(const(UResourceBundle)* resourceBundle, int* len, UErrorCode* status);

@DllImport("icu")
byte* ures_getUTF8String(const(UResourceBundle)* resB, byte* dest, int* length, byte forceCopy, UErrorCode* status);

@DllImport("icu")
ubyte* ures_getBinary(const(UResourceBundle)* resourceBundle, int* len, UErrorCode* status);

@DllImport("icu")
int* ures_getIntVector(const(UResourceBundle)* resourceBundle, int* len, UErrorCode* status);

@DllImport("icu")
uint ures_getUInt(const(UResourceBundle)* resourceBundle, UErrorCode* status);

@DllImport("icu")
int ures_getInt(const(UResourceBundle)* resourceBundle, UErrorCode* status);

@DllImport("icu")
int ures_getSize(const(UResourceBundle)* resourceBundle);

@DllImport("icu")
UResType ures_getType(const(UResourceBundle)* resourceBundle);

@DllImport("icu")
byte* ures_getKey(const(UResourceBundle)* resourceBundle);

@DllImport("icu")
void ures_resetIterator(UResourceBundle* resourceBundle);

@DllImport("icu")
byte ures_hasNext(const(UResourceBundle)* resourceBundle);

@DllImport("icu")
UResourceBundle* ures_getNextResource(UResourceBundle* resourceBundle, UResourceBundle* fillIn, UErrorCode* status);

@DllImport("icu")
ushort* ures_getNextString(UResourceBundle* resourceBundle, int* len, const(byte)** key, UErrorCode* status);

@DllImport("icu")
UResourceBundle* ures_getByIndex(const(UResourceBundle)* resourceBundle, int indexR, UResourceBundle* fillIn, 
                                 UErrorCode* status);

@DllImport("icu")
ushort* ures_getStringByIndex(const(UResourceBundle)* resourceBundle, int indexS, int* len, UErrorCode* status);

@DllImport("icu")
byte* ures_getUTF8StringByIndex(const(UResourceBundle)* resB, int stringIndex, byte* dest, int* pLength, 
                                byte forceCopy, UErrorCode* status);

@DllImport("icu")
UResourceBundle* ures_getByKey(const(UResourceBundle)* resourceBundle, const(byte)* key, UResourceBundle* fillIn, 
                               UErrorCode* status);

@DllImport("icu")
ushort* ures_getStringByKey(const(UResourceBundle)* resB, const(byte)* key, int* len, UErrorCode* status);

@DllImport("icu")
byte* ures_getUTF8StringByKey(const(UResourceBundle)* resB, const(byte)* key, byte* dest, int* pLength, 
                              byte forceCopy, UErrorCode* status);

@DllImport("icu")
UEnumeration* ures_openAvailableLocales(const(byte)* packageName, UErrorCode* status);

@DllImport("icu")
ULocaleDisplayNames* uldn_open(const(byte)* locale, UDialectHandling dialectHandling, UErrorCode* pErrorCode);

@DllImport("icu")
void uldn_close(ULocaleDisplayNames* ldn);

@DllImport("icu")
byte* uldn_getLocale(const(ULocaleDisplayNames)* ldn);

@DllImport("icu")
UDialectHandling uldn_getDialectHandling(const(ULocaleDisplayNames)* ldn);

@DllImport("icu")
int uldn_localeDisplayName(const(ULocaleDisplayNames)* ldn, const(byte)* locale, ushort* result, int maxResultSize, 
                           UErrorCode* pErrorCode);

@DllImport("icu")
int uldn_languageDisplayName(const(ULocaleDisplayNames)* ldn, const(byte)* lang, ushort* result, int maxResultSize, 
                             UErrorCode* pErrorCode);

@DllImport("icu")
int uldn_scriptDisplayName(const(ULocaleDisplayNames)* ldn, const(byte)* script, ushort* result, int maxResultSize, 
                           UErrorCode* pErrorCode);

@DllImport("icu")
int uldn_scriptCodeDisplayName(const(ULocaleDisplayNames)* ldn, UScriptCode scriptCode, ushort* result, 
                               int maxResultSize, UErrorCode* pErrorCode);

@DllImport("icu")
int uldn_regionDisplayName(const(ULocaleDisplayNames)* ldn, const(byte)* region, ushort* result, int maxResultSize, 
                           UErrorCode* pErrorCode);

@DllImport("icu")
int uldn_variantDisplayName(const(ULocaleDisplayNames)* ldn, const(byte)* variant, ushort* result, 
                            int maxResultSize, UErrorCode* pErrorCode);

@DllImport("icu")
int uldn_keyDisplayName(const(ULocaleDisplayNames)* ldn, const(byte)* key, ushort* result, int maxResultSize, 
                        UErrorCode* pErrorCode);

@DllImport("icu")
int uldn_keyValueDisplayName(const(ULocaleDisplayNames)* ldn, const(byte)* key, const(byte)* value, ushort* result, 
                             int maxResultSize, UErrorCode* pErrorCode);

@DllImport("icu")
ULocaleDisplayNames* uldn_openForContext(const(byte)* locale, UDisplayContext* contexts, int length, 
                                         UErrorCode* pErrorCode);

@DllImport("icu")
UDisplayContext uldn_getContext(const(ULocaleDisplayNames)* ldn, UDisplayContextType type, UErrorCode* pErrorCode);

@DllImport("icu")
int ucurr_forLocale(const(byte)* locale, ushort* buff, int buffCapacity, UErrorCode* ec);

@DllImport("icu")
void* ucurr_register(const(ushort)* isoCode, const(byte)* locale, UErrorCode* status);

@DllImport("icu")
byte ucurr_unregister(void* key, UErrorCode* status);

@DllImport("icu")
ushort* ucurr_getName(const(ushort)* currency, const(byte)* locale, UCurrNameStyle nameStyle, byte* isChoiceFormat, 
                      int* len, UErrorCode* ec);

@DllImport("icu")
ushort* ucurr_getPluralName(const(ushort)* currency, const(byte)* locale, byte* isChoiceFormat, 
                            const(byte)* pluralCount, int* len, UErrorCode* ec);

@DllImport("icu")
int ucurr_getDefaultFractionDigits(const(ushort)* currency, UErrorCode* ec);

@DllImport("icu")
int ucurr_getDefaultFractionDigitsForUsage(const(ushort)* currency, const(UCurrencyUsage) usage, UErrorCode* ec);

@DllImport("icu")
double ucurr_getRoundingIncrement(const(ushort)* currency, UErrorCode* ec);

@DllImport("icu")
double ucurr_getRoundingIncrementForUsage(const(ushort)* currency, const(UCurrencyUsage) usage, UErrorCode* ec);

@DllImport("icu")
UEnumeration* ucurr_openISOCurrencies(uint currType, UErrorCode* pErrorCode);

@DllImport("icu")
byte ucurr_isAvailable(const(ushort)* isoCode, double from, double to, UErrorCode* errorCode);

@DllImport("icu")
int ucurr_countCurrencies(const(byte)* locale, double date, UErrorCode* ec);

@DllImport("icu")
int ucurr_forLocaleAndDate(const(byte)* locale, double date, int index, ushort* buff, int buffCapacity, 
                           UErrorCode* ec);

@DllImport("icu")
UEnumeration* ucurr_getKeywordValuesForLocale(const(byte)* key, const(byte)* locale, byte commonlyUsed, 
                                              UErrorCode* status);

@DllImport("icu")
int ucurr_getNumericCode(const(ushort)* currency);

@DllImport("icu")
void UCNV_FROM_U_CALLBACK_STOP(const(void)* context, UConverterFromUnicodeArgs* fromUArgs, 
                               const(ushort)* codeUnits, int length, int codePoint, UConverterCallbackReason reason, 
                               UErrorCode* err);

@DllImport("icu")
void UCNV_TO_U_CALLBACK_STOP(const(void)* context, UConverterToUnicodeArgs* toUArgs, const(byte)* codeUnits, 
                             int length, UConverterCallbackReason reason, UErrorCode* err);

@DllImport("icu")
void UCNV_FROM_U_CALLBACK_SKIP(const(void)* context, UConverterFromUnicodeArgs* fromUArgs, 
                               const(ushort)* codeUnits, int length, int codePoint, UConverterCallbackReason reason, 
                               UErrorCode* err);

@DllImport("icu")
void UCNV_FROM_U_CALLBACK_SUBSTITUTE(const(void)* context, UConverterFromUnicodeArgs* fromUArgs, 
                                     const(ushort)* codeUnits, int length, int codePoint, 
                                     UConverterCallbackReason reason, UErrorCode* err);

@DllImport("icu")
void UCNV_FROM_U_CALLBACK_ESCAPE(const(void)* context, UConverterFromUnicodeArgs* fromUArgs, 
                                 const(ushort)* codeUnits, int length, int codePoint, 
                                 UConverterCallbackReason reason, UErrorCode* err);

@DllImport("icu")
void UCNV_TO_U_CALLBACK_SKIP(const(void)* context, UConverterToUnicodeArgs* toUArgs, const(byte)* codeUnits, 
                             int length, UConverterCallbackReason reason, UErrorCode* err);

@DllImport("icu")
void UCNV_TO_U_CALLBACK_SUBSTITUTE(const(void)* context, UConverterToUnicodeArgs* toUArgs, const(byte)* codeUnits, 
                                   int length, UConverterCallbackReason reason, UErrorCode* err);

@DllImport("icu")
void UCNV_TO_U_CALLBACK_ESCAPE(const(void)* context, UConverterToUnicodeArgs* toUArgs, const(byte)* codeUnits, 
                               int length, UConverterCallbackReason reason, UErrorCode* err);

@DllImport("icu")
int ucnv_compareNames(const(byte)* name1, const(byte)* name2);

@DllImport("icu")
UConverter* ucnv_open(const(byte)* converterName, UErrorCode* err);

@DllImport("icu")
UConverter* ucnv_openU(const(ushort)* name, UErrorCode* err);

@DllImport("icu")
UConverter* ucnv_openCCSID(int codepage, UConverterPlatform platform, UErrorCode* err);

@DllImport("icu")
UConverter* ucnv_openPackage(const(byte)* packageName, const(byte)* converterName, UErrorCode* err);

@DllImport("icu")
UConverter* ucnv_safeClone(const(UConverter)* cnv, void* stackBuffer, int* pBufferSize, UErrorCode* status);

@DllImport("icu")
void ucnv_close(UConverter* converter);

@DllImport("icu")
void ucnv_getSubstChars(const(UConverter)* converter, byte* subChars, byte* len, UErrorCode* err);

@DllImport("icu")
void ucnv_setSubstChars(UConverter* converter, const(byte)* subChars, byte len, UErrorCode* err);

@DllImport("icu")
void ucnv_setSubstString(UConverter* cnv, const(ushort)* s, int length, UErrorCode* err);

@DllImport("icu")
void ucnv_getInvalidChars(const(UConverter)* converter, byte* errBytes, byte* len, UErrorCode* err);

@DllImport("icu")
void ucnv_getInvalidUChars(const(UConverter)* converter, ushort* errUChars, byte* len, UErrorCode* err);

@DllImport("icu")
void ucnv_reset(UConverter* converter);

@DllImport("icu")
void ucnv_resetToUnicode(UConverter* converter);

@DllImport("icu")
void ucnv_resetFromUnicode(UConverter* converter);

@DllImport("icu")
byte ucnv_getMaxCharSize(const(UConverter)* converter);

@DllImport("icu")
byte ucnv_getMinCharSize(const(UConverter)* converter);

@DllImport("icu")
int ucnv_getDisplayName(const(UConverter)* converter, const(byte)* displayLocale, ushort* displayName, 
                        int displayNameCapacity, UErrorCode* err);

@DllImport("icu")
byte* ucnv_getName(const(UConverter)* converter, UErrorCode* err);

@DllImport("icu")
int ucnv_getCCSID(const(UConverter)* converter, UErrorCode* err);

@DllImport("icu")
UConverterPlatform ucnv_getPlatform(const(UConverter)* converter, UErrorCode* err);

@DllImport("icu")
UConverterType ucnv_getType(const(UConverter)* converter);

@DllImport("icu")
void ucnv_getStarters(const(UConverter)* converter, byte* starters, UErrorCode* err);

@DllImport("icu")
void ucnv_getUnicodeSet(const(UConverter)* cnv, USet* setFillIn, UConverterUnicodeSet whichSet, 
                        UErrorCode* pErrorCode);

@DllImport("icu")
void ucnv_getToUCallBack(const(UConverter)* converter, UConverterToUCallback* action, const(void)** context);

@DllImport("icu")
void ucnv_getFromUCallBack(const(UConverter)* converter, UConverterFromUCallback* action, const(void)** context);

@DllImport("icu")
void ucnv_setToUCallBack(UConverter* converter, UConverterToUCallback newAction, const(void)* newContext, 
                         UConverterToUCallback* oldAction, const(void)** oldContext, UErrorCode* err);

@DllImport("icu")
void ucnv_setFromUCallBack(UConverter* converter, UConverterFromUCallback newAction, const(void)* newContext, 
                           UConverterFromUCallback* oldAction, const(void)** oldContext, UErrorCode* err);

@DllImport("icu")
void ucnv_fromUnicode(UConverter* converter, byte** target, const(byte)* targetLimit, const(ushort)** source, 
                      const(ushort)* sourceLimit, int* offsets, byte flush, UErrorCode* err);

@DllImport("icu")
void ucnv_toUnicode(UConverter* converter, ushort** target, const(ushort)* targetLimit, const(byte)** source, 
                    const(byte)* sourceLimit, int* offsets, byte flush, UErrorCode* err);

@DllImport("icu")
int ucnv_fromUChars(UConverter* cnv, byte* dest, int destCapacity, const(ushort)* src, int srcLength, 
                    UErrorCode* pErrorCode);

@DllImport("icu")
int ucnv_toUChars(UConverter* cnv, ushort* dest, int destCapacity, const(byte)* src, int srcLength, 
                  UErrorCode* pErrorCode);

@DllImport("icu")
int ucnv_getNextUChar(UConverter* converter, const(byte)** source, const(byte)* sourceLimit, UErrorCode* err);

@DllImport("icu")
void ucnv_convertEx(UConverter* targetCnv, UConverter* sourceCnv, byte** target, const(byte)* targetLimit, 
                    const(byte)** source, const(byte)* sourceLimit, ushort* pivotStart, ushort** pivotSource, 
                    ushort** pivotTarget, const(ushort)* pivotLimit, byte reset, byte flush, UErrorCode* pErrorCode);

@DllImport("icu")
int ucnv_convert(const(byte)* toConverterName, const(byte)* fromConverterName, byte* target, int targetCapacity, 
                 const(byte)* source, int sourceLength, UErrorCode* pErrorCode);

@DllImport("icu")
int ucnv_toAlgorithmic(UConverterType algorithmicType, UConverter* cnv, byte* target, int targetCapacity, 
                       const(byte)* source, int sourceLength, UErrorCode* pErrorCode);

@DllImport("icu")
int ucnv_fromAlgorithmic(UConverter* cnv, UConverterType algorithmicType, byte* target, int targetCapacity, 
                         const(byte)* source, int sourceLength, UErrorCode* pErrorCode);

@DllImport("icu")
int ucnv_flushCache();

@DllImport("icu")
int ucnv_countAvailable();

@DllImport("icu")
byte* ucnv_getAvailableName(int n);

@DllImport("icu")
UEnumeration* ucnv_openAllNames(UErrorCode* pErrorCode);

@DllImport("icu")
ushort ucnv_countAliases(const(byte)* alias_, UErrorCode* pErrorCode);

@DllImport("icu")
byte* ucnv_getAlias(const(byte)* alias_, ushort n, UErrorCode* pErrorCode);

@DllImport("icu")
void ucnv_getAliases(const(byte)* alias_, const(byte)** aliases, UErrorCode* pErrorCode);

@DllImport("icu")
UEnumeration* ucnv_openStandardNames(const(byte)* convName, const(byte)* standard, UErrorCode* pErrorCode);

@DllImport("icu")
ushort ucnv_countStandards();

@DllImport("icu")
byte* ucnv_getStandard(ushort n, UErrorCode* pErrorCode);

@DllImport("icu")
byte* ucnv_getStandardName(const(byte)* name, const(byte)* standard, UErrorCode* pErrorCode);

@DllImport("icu")
byte* ucnv_getCanonicalName(const(byte)* alias_, const(byte)* standard, UErrorCode* pErrorCode);

@DllImport("icu")
byte* ucnv_getDefaultName();

@DllImport("icu")
void ucnv_setDefaultName(const(byte)* name);

@DllImport("icu")
void ucnv_fixFileSeparator(const(UConverter)* cnv, ushort* source, int sourceLen);

@DllImport("icu")
byte ucnv_isAmbiguous(const(UConverter)* cnv);

@DllImport("icu")
void ucnv_setFallback(UConverter* cnv, byte usesFallback);

@DllImport("icu")
byte ucnv_usesFallback(const(UConverter)* cnv);

@DllImport("icu")
byte* ucnv_detectUnicodeSignature(const(byte)* source, int sourceLength, int* signatureLength, 
                                  UErrorCode* pErrorCode);

@DllImport("icu")
int ucnv_fromUCountPending(const(UConverter)* cnv, UErrorCode* status);

@DllImport("icu")
int ucnv_toUCountPending(const(UConverter)* cnv, UErrorCode* status);

@DllImport("icu")
byte ucnv_isFixedWidth(UConverter* cnv, UErrorCode* status);

@DllImport("icu")
void ucnv_cbFromUWriteBytes(UConverterFromUnicodeArgs* args, const(byte)* source, int length, int offsetIndex, 
                            UErrorCode* err);

@DllImport("icu")
void ucnv_cbFromUWriteSub(UConverterFromUnicodeArgs* args, int offsetIndex, UErrorCode* err);

@DllImport("icu")
void ucnv_cbFromUWriteUChars(UConverterFromUnicodeArgs* args, const(ushort)** source, const(ushort)* sourceLimit, 
                             int offsetIndex, UErrorCode* err);

@DllImport("icu")
void ucnv_cbToUWriteUChars(UConverterToUnicodeArgs* args, const(ushort)* source, int length, int offsetIndex, 
                           UErrorCode* err);

@DllImport("icu")
void ucnv_cbToUWriteSub(UConverterToUnicodeArgs* args, int offsetIndex, UErrorCode* err);

@DllImport("icu")
void u_init(UErrorCode* status);

@DllImport("icu")
void u_cleanup();

@DllImport("icu")
void u_setMemoryFunctions(const(void)* context, UMemAllocFn* a, UMemReallocFn* r, UMemFreeFn* f, 
                          UErrorCode* status);

@DllImport("icu")
UResourceBundle* u_catopen(const(byte)* name, const(byte)* locale, UErrorCode* ec);

@DllImport("icu")
void u_catclose(UResourceBundle* catd);

@DllImport("icu")
ushort* u_catgets(UResourceBundle* catd, int set_num, int msg_num, const(ushort)* s, int* len, UErrorCode* ec);

@DllImport("icu")
byte u_hasBinaryProperty(int c, UProperty which);

@DllImport("icu")
byte u_isUAlphabetic(int c);

@DllImport("icu")
byte u_isULowercase(int c);

@DllImport("icu")
byte u_isUUppercase(int c);

@DllImport("icu")
byte u_isUWhiteSpace(int c);

@DllImport("icu")
int u_getIntPropertyValue(int c, UProperty which);

@DllImport("icu")
int u_getIntPropertyMinValue(UProperty which);

@DllImport("icu")
int u_getIntPropertyMaxValue(UProperty which);

@DllImport("icu")
double u_getNumericValue(int c);

@DllImport("icu")
byte u_islower(int c);

@DllImport("icu")
byte u_isupper(int c);

@DllImport("icu")
byte u_istitle(int c);

@DllImport("icu")
byte u_isdigit(int c);

@DllImport("icu")
byte u_isalpha(int c);

@DllImport("icu")
byte u_isalnum(int c);

@DllImport("icu")
byte u_isxdigit(int c);

@DllImport("icu")
byte u_ispunct(int c);

@DllImport("icu")
byte u_isgraph(int c);

@DllImport("icu")
byte u_isblank(int c);

@DllImport("icu")
byte u_isdefined(int c);

@DllImport("icu")
byte u_isspace(int c);

@DllImport("icu")
byte u_isJavaSpaceChar(int c);

@DllImport("icu")
byte u_isWhitespace(int c);

@DllImport("icu")
byte u_iscntrl(int c);

@DllImport("icu")
byte u_isISOControl(int c);

@DllImport("icu")
byte u_isprint(int c);

@DllImport("icu")
byte u_isbase(int c);

@DllImport("icu")
UCharDirection u_charDirection(int c);

@DllImport("icu")
byte u_isMirrored(int c);

@DllImport("icu")
int u_charMirror(int c);

@DllImport("icu")
int u_getBidiPairedBracket(int c);

@DllImport("icu")
byte u_charType(int c);

@DllImport("icu")
void u_enumCharTypes(UCharEnumTypeRange* enumRange, const(void)* context);

@DllImport("icu")
ubyte u_getCombiningClass(int c);

@DllImport("icu")
int u_charDigitValue(int c);

@DllImport("icu")
UBlockCode ublock_getCode(int c);

@DllImport("icu")
int u_charName(int code, UCharNameChoice nameChoice, byte* buffer, int bufferLength, UErrorCode* pErrorCode);

@DllImport("icu")
int u_charFromName(UCharNameChoice nameChoice, const(byte)* name, UErrorCode* pErrorCode);

@DllImport("icu")
void u_enumCharNames(int start, int limit, UEnumCharNamesFn* fn, void* context, UCharNameChoice nameChoice, 
                     UErrorCode* pErrorCode);

@DllImport("icu")
byte* u_getPropertyName(UProperty property, UPropertyNameChoice nameChoice);

@DllImport("icu")
UProperty u_getPropertyEnum(const(byte)* alias_);

@DllImport("icu")
byte* u_getPropertyValueName(UProperty property, int value, UPropertyNameChoice nameChoice);

@DllImport("icu")
int u_getPropertyValueEnum(UProperty property, const(byte)* alias_);

@DllImport("icu")
byte u_isIDStart(int c);

@DllImport("icu")
byte u_isIDPart(int c);

@DllImport("icu")
byte u_isIDIgnorable(int c);

@DllImport("icu")
byte u_isJavaIDStart(int c);

@DllImport("icu")
byte u_isJavaIDPart(int c);

@DllImport("icu")
int u_tolower(int c);

@DllImport("icu")
int u_toupper(int c);

@DllImport("icu")
int u_totitle(int c);

@DllImport("icu")
int u_foldCase(int c, uint options);

@DllImport("icu")
int u_digit(int ch, byte radix);

@DllImport("icu")
int u_forDigit(int digit, byte radix);

@DllImport("icu")
void u_charAge(int c, ubyte* versionArray);

@DllImport("icu")
void u_getUnicodeVersion(ubyte* versionArray);

@DllImport("icu")
int u_getFC_NFKC_Closure(int c, ushort* dest, int destCapacity, UErrorCode* pErrorCode);

@DllImport("icu")
UBiDi* ubidi_open();

@DllImport("icu")
UBiDi* ubidi_openSized(int maxLength, int maxRunCount, UErrorCode* pErrorCode);

@DllImport("icu")
void ubidi_close(UBiDi* pBiDi);

@DllImport("icu")
void ubidi_setInverse(UBiDi* pBiDi, byte isInverse);

@DllImport("icu")
byte ubidi_isInverse(UBiDi* pBiDi);

@DllImport("icu")
void ubidi_orderParagraphsLTR(UBiDi* pBiDi, byte orderParagraphsLTR);

@DllImport("icu")
byte ubidi_isOrderParagraphsLTR(UBiDi* pBiDi);

@DllImport("icu")
void ubidi_setReorderingMode(UBiDi* pBiDi, UBiDiReorderingMode reorderingMode);

@DllImport("icu")
UBiDiReorderingMode ubidi_getReorderingMode(UBiDi* pBiDi);

@DllImport("icu")
void ubidi_setReorderingOptions(UBiDi* pBiDi, uint reorderingOptions);

@DllImport("icu")
uint ubidi_getReorderingOptions(UBiDi* pBiDi);

@DllImport("icu")
void ubidi_setContext(UBiDi* pBiDi, const(ushort)* prologue, int proLength, const(ushort)* epilogue, int epiLength, 
                      UErrorCode* pErrorCode);

@DllImport("icu")
void ubidi_setPara(UBiDi* pBiDi, const(ushort)* text, int length, ubyte paraLevel, ubyte* embeddingLevels, 
                   UErrorCode* pErrorCode);

@DllImport("icu")
void ubidi_setLine(const(UBiDi)* pParaBiDi, int start, int limit, UBiDi* pLineBiDi, UErrorCode* pErrorCode);

@DllImport("icu")
UBiDiDirection ubidi_getDirection(const(UBiDi)* pBiDi);

@DllImport("icu")
UBiDiDirection ubidi_getBaseDirection(const(ushort)* text, int length);

@DllImport("icu")
ushort* ubidi_getText(const(UBiDi)* pBiDi);

@DllImport("icu")
int ubidi_getLength(const(UBiDi)* pBiDi);

@DllImport("icu")
ubyte ubidi_getParaLevel(const(UBiDi)* pBiDi);

@DllImport("icu")
int ubidi_countParagraphs(UBiDi* pBiDi);

@DllImport("icu")
int ubidi_getParagraph(const(UBiDi)* pBiDi, int charIndex, int* pParaStart, int* pParaLimit, ubyte* pParaLevel, 
                       UErrorCode* pErrorCode);

@DllImport("icu")
void ubidi_getParagraphByIndex(const(UBiDi)* pBiDi, int paraIndex, int* pParaStart, int* pParaLimit, 
                               ubyte* pParaLevel, UErrorCode* pErrorCode);

@DllImport("icu")
ubyte ubidi_getLevelAt(const(UBiDi)* pBiDi, int charIndex);

@DllImport("icu")
ubyte* ubidi_getLevels(UBiDi* pBiDi, UErrorCode* pErrorCode);

@DllImport("icu")
void ubidi_getLogicalRun(const(UBiDi)* pBiDi, int logicalPosition, int* pLogicalLimit, ubyte* pLevel);

@DllImport("icu")
int ubidi_countRuns(UBiDi* pBiDi, UErrorCode* pErrorCode);

@DllImport("icu")
UBiDiDirection ubidi_getVisualRun(UBiDi* pBiDi, int runIndex, int* pLogicalStart, int* pLength);

@DllImport("icu")
int ubidi_getVisualIndex(UBiDi* pBiDi, int logicalIndex, UErrorCode* pErrorCode);

@DllImport("icu")
int ubidi_getLogicalIndex(UBiDi* pBiDi, int visualIndex, UErrorCode* pErrorCode);

@DllImport("icu")
void ubidi_getLogicalMap(UBiDi* pBiDi, int* indexMap, UErrorCode* pErrorCode);

@DllImport("icu")
void ubidi_getVisualMap(UBiDi* pBiDi, int* indexMap, UErrorCode* pErrorCode);

@DllImport("icu")
void ubidi_reorderLogical(const(ubyte)* levels, int length, int* indexMap);

@DllImport("icu")
void ubidi_reorderVisual(const(ubyte)* levels, int length, int* indexMap);

@DllImport("icu")
void ubidi_invertMap(const(int)* srcMap, int* destMap, int length);

@DllImport("icu")
int ubidi_getProcessedLength(const(UBiDi)* pBiDi);

@DllImport("icu")
int ubidi_getResultLength(const(UBiDi)* pBiDi);

@DllImport("icu")
UCharDirection ubidi_getCustomizedClass(UBiDi* pBiDi, int c);

@DllImport("icu")
void ubidi_setClassCallback(UBiDi* pBiDi, UBiDiClassCallback* newFn, const(void)* newContext, 
                            UBiDiClassCallback** oldFn, const(void)** oldContext, UErrorCode* pErrorCode);

@DllImport("icu")
void ubidi_getClassCallback(UBiDi* pBiDi, UBiDiClassCallback** fn, const(void)** context);

@DllImport("icu")
int ubidi_writeReordered(UBiDi* pBiDi, ushort* dest, int destSize, ushort options, UErrorCode* pErrorCode);

@DllImport("icu")
int ubidi_writeReverse(const(ushort)* src, int srcLength, ushort* dest, int destSize, ushort options, 
                       UErrorCode* pErrorCode);

@DllImport("icu")
uint ubiditransform_transform(UBiDiTransform* pBiDiTransform, const(ushort)* src, int srcLength, ushort* dest, 
                              int destSize, ubyte inParaLevel, UBiDiOrder inOrder, ubyte outParaLevel, 
                              UBiDiOrder outOrder, UBiDiMirroring doMirroring, uint shapingOptions, 
                              UErrorCode* pErrorCode);

@DllImport("icu")
UBiDiTransform* ubiditransform_open(UErrorCode* pErrorCode);

@DllImport("icu")
void ubiditransform_close(UBiDiTransform* pBidiTransform);

@DllImport("icu")
UText* utext_close(UText* ut);

@DllImport("icu")
UText* utext_openUTF8(UText* ut, const(byte)* s, long length, UErrorCode* status);

@DllImport("icu")
UText* utext_openUChars(UText* ut, const(ushort)* s, long length, UErrorCode* status);

@DllImport("icu")
UText* utext_clone(UText* dest, const(UText)* src, byte deep, byte readOnly, UErrorCode* status);

@DllImport("icu")
byte utext_equals(const(UText)* a, const(UText)* b);

@DllImport("icu")
long utext_nativeLength(UText* ut);

@DllImport("icu")
byte utext_isLengthExpensive(const(UText)* ut);

@DllImport("icu")
int utext_char32At(UText* ut, long nativeIndex);

@DllImport("icu")
int utext_current32(UText* ut);

@DllImport("icu")
int utext_next32(UText* ut);

@DllImport("icu")
int utext_previous32(UText* ut);

@DllImport("icu")
int utext_next32From(UText* ut, long nativeIndex);

@DllImport("icu")
int utext_previous32From(UText* ut, long nativeIndex);

@DllImport("icu")
long utext_getNativeIndex(const(UText)* ut);

@DllImport("icu")
void utext_setNativeIndex(UText* ut, long nativeIndex);

@DllImport("icu")
byte utext_moveIndex32(UText* ut, int delta);

@DllImport("icu")
long utext_getPreviousNativeIndex(UText* ut);

@DllImport("icu")
int utext_extract(UText* ut, long nativeStart, long nativeLimit, ushort* dest, int destCapacity, 
                  UErrorCode* status);

@DllImport("icu")
byte utext_isWritable(const(UText)* ut);

@DllImport("icu")
byte utext_hasMetaData(const(UText)* ut);

@DllImport("icu")
int utext_replace(UText* ut, long nativeStart, long nativeLimit, const(ushort)* replacementText, 
                  int replacementLength, UErrorCode* status);

@DllImport("icu")
void utext_copy(UText* ut, long nativeStart, long nativeLimit, long destIndex, byte move, UErrorCode* status);

@DllImport("icu")
void utext_freeze(UText* ut);

@DllImport("icu")
UText* utext_setup(UText* ut, int extraSpace, UErrorCode* status);

@DllImport("icu")
USet* uset_openEmpty();

@DllImport("icu")
USet* uset_open(int start, int end);

@DllImport("icu")
USet* uset_openPattern(const(ushort)* pattern, int patternLength, UErrorCode* ec);

@DllImport("icu")
USet* uset_openPatternOptions(const(ushort)* pattern, int patternLength, uint options, UErrorCode* ec);

@DllImport("icu")
void uset_close(USet* set);

@DllImport("icu")
USet* uset_clone(const(USet)* set);

@DllImport("icu")
byte uset_isFrozen(const(USet)* set);

@DllImport("icu")
void uset_freeze(USet* set);

@DllImport("icu")
USet* uset_cloneAsThawed(const(USet)* set);

@DllImport("icu")
void uset_set(USet* set, int start, int end);

@DllImport("icu")
int uset_applyPattern(USet* set, const(ushort)* pattern, int patternLength, uint options, UErrorCode* status);

@DllImport("icu")
void uset_applyIntPropertyValue(USet* set, UProperty prop, int value, UErrorCode* ec);

@DllImport("icu")
void uset_applyPropertyAlias(USet* set, const(ushort)* prop, int propLength, const(ushort)* value, int valueLength, 
                             UErrorCode* ec);

@DllImport("icu")
byte uset_resemblesPattern(const(ushort)* pattern, int patternLength, int pos);

@DllImport("icu")
int uset_toPattern(const(USet)* set, ushort* result, int resultCapacity, byte escapeUnprintable, UErrorCode* ec);

@DllImport("icu")
void uset_add(USet* set, int c);

@DllImport("icu")
void uset_addAll(USet* set, const(USet)* additionalSet);

@DllImport("icu")
void uset_addRange(USet* set, int start, int end);

@DllImport("icu")
void uset_addString(USet* set, const(ushort)* str, int strLen);

@DllImport("icu")
void uset_addAllCodePoints(USet* set, const(ushort)* str, int strLen);

@DllImport("icu")
void uset_remove(USet* set, int c);

@DllImport("icu")
void uset_removeRange(USet* set, int start, int end);

@DllImport("icu")
void uset_removeString(USet* set, const(ushort)* str, int strLen);

@DllImport("icu")
void uset_removeAll(USet* set, const(USet)* removeSet);

@DllImport("icu")
void uset_retain(USet* set, int start, int end);

@DllImport("icu")
void uset_retainAll(USet* set, const(USet)* retain);

@DllImport("icu")
void uset_compact(USet* set);

@DllImport("icu")
void uset_complement(USet* set);

@DllImport("icu")
void uset_complementAll(USet* set, const(USet)* complement);

@DllImport("icu")
void uset_clear(USet* set);

@DllImport("icu")
void uset_closeOver(USet* set, int attributes);

@DllImport("icu")
void uset_removeAllStrings(USet* set);

@DllImport("icu")
byte uset_isEmpty(const(USet)* set);

@DllImport("icu")
byte uset_contains(const(USet)* set, int c);

@DllImport("icu")
byte uset_containsRange(const(USet)* set, int start, int end);

@DllImport("icu")
byte uset_containsString(const(USet)* set, const(ushort)* str, int strLen);

@DllImport("icu")
int uset_indexOf(const(USet)* set, int c);

@DllImport("icu")
int uset_charAt(const(USet)* set, int charIndex);

@DllImport("icu")
int uset_size(const(USet)* set);

@DllImport("icu")
int uset_getItemCount(const(USet)* set);

@DllImport("icu")
int uset_getItem(const(USet)* set, int itemIndex, int* start, int* end, ushort* str, int strCapacity, 
                 UErrorCode* ec);

@DllImport("icu")
byte uset_containsAll(const(USet)* set1, const(USet)* set2);

@DllImport("icu")
byte uset_containsAllCodePoints(const(USet)* set, const(ushort)* str, int strLen);

@DllImport("icu")
byte uset_containsNone(const(USet)* set1, const(USet)* set2);

@DllImport("icu")
byte uset_containsSome(const(USet)* set1, const(USet)* set2);

@DllImport("icu")
int uset_span(const(USet)* set, const(ushort)* s, int length, USetSpanCondition spanCondition);

@DllImport("icu")
int uset_spanBack(const(USet)* set, const(ushort)* s, int length, USetSpanCondition spanCondition);

@DllImport("icu")
int uset_spanUTF8(const(USet)* set, const(byte)* s, int length, USetSpanCondition spanCondition);

@DllImport("icu")
int uset_spanBackUTF8(const(USet)* set, const(byte)* s, int length, USetSpanCondition spanCondition);

@DllImport("icu")
byte uset_equals(const(USet)* set1, const(USet)* set2);

@DllImport("icu")
int uset_serialize(const(USet)* set, ushort* dest, int destCapacity, UErrorCode* pErrorCode);

@DllImport("icu")
byte uset_getSerializedSet(USerializedSet* fillSet, const(ushort)* src, int srcLength);

@DllImport("icu")
void uset_setSerializedToOne(USerializedSet* fillSet, int c);

@DllImport("icu")
byte uset_serializedContains(const(USerializedSet)* set, int c);

@DllImport("icu")
int uset_getSerializedRangeCount(const(USerializedSet)* set);

@DllImport("icu")
byte uset_getSerializedRange(const(USerializedSet)* set, int rangeIndex, int* pStart, int* pEnd);

@DllImport("icu")
UNormalizer2* unorm2_getNFCInstance(UErrorCode* pErrorCode);

@DllImport("icu")
UNormalizer2* unorm2_getNFDInstance(UErrorCode* pErrorCode);

@DllImport("icu")
UNormalizer2* unorm2_getNFKCInstance(UErrorCode* pErrorCode);

@DllImport("icu")
UNormalizer2* unorm2_getNFKDInstance(UErrorCode* pErrorCode);

@DllImport("icu")
UNormalizer2* unorm2_getNFKCCasefoldInstance(UErrorCode* pErrorCode);

@DllImport("icu")
UNormalizer2* unorm2_getInstance(const(byte)* packageName, const(byte)* name, UNormalization2Mode mode, 
                                 UErrorCode* pErrorCode);

@DllImport("icu")
UNormalizer2* unorm2_openFiltered(const(UNormalizer2)* norm2, const(USet)* filterSet, UErrorCode* pErrorCode);

@DllImport("icu")
void unorm2_close(UNormalizer2* norm2);

@DllImport("icu")
int unorm2_normalize(const(UNormalizer2)* norm2, const(ushort)* src, int length, ushort* dest, int capacity, 
                     UErrorCode* pErrorCode);

@DllImport("icu")
int unorm2_normalizeSecondAndAppend(const(UNormalizer2)* norm2, ushort* first, int firstLength, int firstCapacity, 
                                    const(ushort)* second, int secondLength, UErrorCode* pErrorCode);

@DllImport("icu")
int unorm2_append(const(UNormalizer2)* norm2, ushort* first, int firstLength, int firstCapacity, 
                  const(ushort)* second, int secondLength, UErrorCode* pErrorCode);

@DllImport("icu")
int unorm2_getDecomposition(const(UNormalizer2)* norm2, int c, ushort* decomposition, int capacity, 
                            UErrorCode* pErrorCode);

@DllImport("icu")
int unorm2_getRawDecomposition(const(UNormalizer2)* norm2, int c, ushort* decomposition, int capacity, 
                               UErrorCode* pErrorCode);

@DllImport("icu")
int unorm2_composePair(const(UNormalizer2)* norm2, int a, int b);

@DllImport("icu")
ubyte unorm2_getCombiningClass(const(UNormalizer2)* norm2, int c);

@DllImport("icu")
byte unorm2_isNormalized(const(UNormalizer2)* norm2, const(ushort)* s, int length, UErrorCode* pErrorCode);

@DllImport("icu")
UNormalizationCheckResult unorm2_quickCheck(const(UNormalizer2)* norm2, const(ushort)* s, int length, 
                                            UErrorCode* pErrorCode);

@DllImport("icu")
int unorm2_spanQuickCheckYes(const(UNormalizer2)* norm2, const(ushort)* s, int length, UErrorCode* pErrorCode);

@DllImport("icu")
byte unorm2_hasBoundaryBefore(const(UNormalizer2)* norm2, int c);

@DllImport("icu")
byte unorm2_hasBoundaryAfter(const(UNormalizer2)* norm2, int c);

@DllImport("icu")
byte unorm2_isInert(const(UNormalizer2)* norm2, int c);

@DllImport("icu")
int unorm_compare(const(ushort)* s1, int length1, const(ushort)* s2, int length2, uint options, 
                  UErrorCode* pErrorCode);

@DllImport("icu")
UConverterSelector* ucnvsel_open(const(byte)** converterList, int converterListSize, 
                                 const(USet)* excludedCodePoints, const(UConverterUnicodeSet) whichSet, 
                                 UErrorCode* status);

@DllImport("icu")
void ucnvsel_close(UConverterSelector* sel);

@DllImport("icu")
UConverterSelector* ucnvsel_openFromSerialized(const(void)* buffer, int length, UErrorCode* status);

@DllImport("icu")
int ucnvsel_serialize(const(UConverterSelector)* sel, void* buffer, int bufferCapacity, UErrorCode* status);

@DllImport("icu")
UEnumeration* ucnvsel_selectForString(const(UConverterSelector)* sel, const(ushort)* s, int length, 
                                      UErrorCode* status);

@DllImport("icu")
UEnumeration* ucnvsel_selectForUTF8(const(UConverterSelector)* sel, const(byte)* s, int length, UErrorCode* status);

@DllImport("icu")
void u_charsToUChars(const(byte)* cs, ushort* us, int length);

@DllImport("icu")
void u_UCharsToChars(const(ushort)* us, byte* cs, int length);

@DllImport("icu")
int u_strlen(const(ushort)* s);

@DllImport("icu")
int u_countChar32(const(ushort)* s, int length);

@DllImport("icu")
byte u_strHasMoreChar32Than(const(ushort)* s, int length, int number);

@DllImport("icu")
ushort* u_strcat(ushort* dst, const(ushort)* src);

@DllImport("icu")
ushort* u_strncat(ushort* dst, const(ushort)* src, int n);

@DllImport("icu")
ushort* u_strstr(const(ushort)* s, const(ushort)* substring);

@DllImport("icu")
ushort* u_strFindFirst(const(ushort)* s, int length, const(ushort)* substring, int subLength);

@DllImport("icu")
ushort* u_strchr(const(ushort)* s, ushort c);

@DllImport("icu")
ushort* u_strchr32(const(ushort)* s, int c);

@DllImport("icu")
ushort* u_strrstr(const(ushort)* s, const(ushort)* substring);

@DllImport("icu")
ushort* u_strFindLast(const(ushort)* s, int length, const(ushort)* substring, int subLength);

@DllImport("icu")
ushort* u_strrchr(const(ushort)* s, ushort c);

@DllImport("icu")
ushort* u_strrchr32(const(ushort)* s, int c);

@DllImport("icu")
ushort* u_strpbrk(const(ushort)* string, const(ushort)* matchSet);

@DllImport("icu")
int u_strcspn(const(ushort)* string, const(ushort)* matchSet);

@DllImport("icu")
int u_strspn(const(ushort)* string, const(ushort)* matchSet);

@DllImport("icu")
ushort* u_strtok_r(ushort* src, const(ushort)* delim, ushort** saveState);

@DllImport("icu")
int u_strcmp(const(ushort)* s1, const(ushort)* s2);

@DllImport("icu")
int u_strcmpCodePointOrder(const(ushort)* s1, const(ushort)* s2);

@DllImport("icu")
int u_strCompare(const(ushort)* s1, int length1, const(ushort)* s2, int length2, byte codePointOrder);

@DllImport("icu")
int u_strCompareIter(UCharIterator* iter1, UCharIterator* iter2, byte codePointOrder);

@DllImport("icu")
int u_strCaseCompare(const(ushort)* s1, int length1, const(ushort)* s2, int length2, uint options, 
                     UErrorCode* pErrorCode);

@DllImport("icu")
int u_strncmp(const(ushort)* ucs1, const(ushort)* ucs2, int n);

@DllImport("icu")
int u_strncmpCodePointOrder(const(ushort)* s1, const(ushort)* s2, int n);

@DllImport("icu")
int u_strcasecmp(const(ushort)* s1, const(ushort)* s2, uint options);

@DllImport("icu")
int u_strncasecmp(const(ushort)* s1, const(ushort)* s2, int n, uint options);

@DllImport("icu")
int u_memcasecmp(const(ushort)* s1, const(ushort)* s2, int length, uint options);

@DllImport("icu")
ushort* u_strcpy(ushort* dst, const(ushort)* src);

@DllImport("icu")
ushort* u_strncpy(ushort* dst, const(ushort)* src, int n);

@DllImport("icu")
ushort* u_uastrcpy(ushort* dst, const(byte)* src);

@DllImport("icu")
ushort* u_uastrncpy(ushort* dst, const(byte)* src, int n);

@DllImport("icu")
byte* u_austrcpy(byte* dst, const(ushort)* src);

@DllImport("icu")
byte* u_austrncpy(byte* dst, const(ushort)* src, int n);

@DllImport("icu")
ushort* u_memcpy(ushort* dest, const(ushort)* src, int count);

@DllImport("icu")
ushort* u_memmove(ushort* dest, const(ushort)* src, int count);

@DllImport("icu")
ushort* u_memset(ushort* dest, ushort c, int count);

@DllImport("icu")
int u_memcmp(const(ushort)* buf1, const(ushort)* buf2, int count);

@DllImport("icu")
int u_memcmpCodePointOrder(const(ushort)* s1, const(ushort)* s2, int count);

@DllImport("icu")
ushort* u_memchr(const(ushort)* s, ushort c, int count);

@DllImport("icu")
ushort* u_memchr32(const(ushort)* s, int c, int count);

@DllImport("icu")
ushort* u_memrchr(const(ushort)* s, ushort c, int count);

@DllImport("icu")
ushort* u_memrchr32(const(ushort)* s, int c, int count);

@DllImport("icu")
int u_unescape(const(byte)* src, ushort* dest, int destCapacity);

@DllImport("icu")
int u_unescapeAt(UNESCAPE_CHAR_AT charAt, int* offset, int length, void* context);

@DllImport("icu")
int u_strToUpper(ushort* dest, int destCapacity, const(ushort)* src, int srcLength, const(byte)* locale, 
                 UErrorCode* pErrorCode);

@DllImport("icu")
int u_strToLower(ushort* dest, int destCapacity, const(ushort)* src, int srcLength, const(byte)* locale, 
                 UErrorCode* pErrorCode);

@DllImport("icu")
int u_strToTitle(ushort* dest, int destCapacity, const(ushort)* src, int srcLength, UBreakIterator* titleIter, 
                 const(byte)* locale, UErrorCode* pErrorCode);

@DllImport("icu")
int u_strFoldCase(ushort* dest, int destCapacity, const(ushort)* src, int srcLength, uint options, 
                  UErrorCode* pErrorCode);

@DllImport("icu")
PWSTR u_strToWCS(PWSTR dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, 
                 UErrorCode* pErrorCode);

@DllImport("icu")
ushort* u_strFromWCS(ushort* dest, int destCapacity, int* pDestLength, const(PWSTR) src, int srcLength, 
                     UErrorCode* pErrorCode);

@DllImport("icu")
byte* u_strToUTF8(byte* dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, 
                  UErrorCode* pErrorCode);

@DllImport("icu")
ushort* u_strFromUTF8(ushort* dest, int destCapacity, int* pDestLength, const(byte)* src, int srcLength, 
                      UErrorCode* pErrorCode);

@DllImport("icu")
byte* u_strToUTF8WithSub(byte* dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, 
                         int subchar, int* pNumSubstitutions, UErrorCode* pErrorCode);

@DllImport("icu")
ushort* u_strFromUTF8WithSub(ushort* dest, int destCapacity, int* pDestLength, const(byte)* src, int srcLength, 
                             int subchar, int* pNumSubstitutions, UErrorCode* pErrorCode);

@DllImport("icu")
ushort* u_strFromUTF8Lenient(ushort* dest, int destCapacity, int* pDestLength, const(byte)* src, int srcLength, 
                             UErrorCode* pErrorCode);

@DllImport("icu")
int* u_strToUTF32(int* dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, 
                  UErrorCode* pErrorCode);

@DllImport("icu")
ushort* u_strFromUTF32(ushort* dest, int destCapacity, int* pDestLength, const(int)* src, int srcLength, 
                       UErrorCode* pErrorCode);

@DllImport("icu")
int* u_strToUTF32WithSub(int* dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, 
                         int subchar, int* pNumSubstitutions, UErrorCode* pErrorCode);

@DllImport("icu")
ushort* u_strFromUTF32WithSub(ushort* dest, int destCapacity, int* pDestLength, const(int)* src, int srcLength, 
                              int subchar, int* pNumSubstitutions, UErrorCode* pErrorCode);

@DllImport("icu")
byte* u_strToJavaModifiedUTF8(byte* dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, 
                              UErrorCode* pErrorCode);

@DllImport("icu")
ushort* u_strFromJavaModifiedUTF8WithSub(ushort* dest, int destCapacity, int* pDestLength, const(byte)* src, 
                                         int srcLength, int subchar, int* pNumSubstitutions, UErrorCode* pErrorCode);

@DllImport("icu")
UCaseMap* ucasemap_open(const(byte)* locale, uint options, UErrorCode* pErrorCode);

@DllImport("icu")
void ucasemap_close(UCaseMap* csm);

@DllImport("icu")
byte* ucasemap_getLocale(const(UCaseMap)* csm);

@DllImport("icu")
uint ucasemap_getOptions(const(UCaseMap)* csm);

@DllImport("icu")
void ucasemap_setLocale(UCaseMap* csm, const(byte)* locale, UErrorCode* pErrorCode);

@DllImport("icu")
void ucasemap_setOptions(UCaseMap* csm, uint options, UErrorCode* pErrorCode);

@DllImport("icu")
UBreakIterator* ucasemap_getBreakIterator(const(UCaseMap)* csm);

@DllImport("icu")
void ucasemap_setBreakIterator(UCaseMap* csm, UBreakIterator* iterToAdopt, UErrorCode* pErrorCode);

@DllImport("icu")
int ucasemap_toTitle(UCaseMap* csm, ushort* dest, int destCapacity, const(ushort)* src, int srcLength, 
                     UErrorCode* pErrorCode);

@DllImport("icu")
int ucasemap_utf8ToLower(const(UCaseMap)* csm, byte* dest, int destCapacity, const(byte)* src, int srcLength, 
                         UErrorCode* pErrorCode);

@DllImport("icu")
int ucasemap_utf8ToUpper(const(UCaseMap)* csm, byte* dest, int destCapacity, const(byte)* src, int srcLength, 
                         UErrorCode* pErrorCode);

@DllImport("icu")
int ucasemap_utf8ToTitle(UCaseMap* csm, byte* dest, int destCapacity, const(byte)* src, int srcLength, 
                         UErrorCode* pErrorCode);

@DllImport("icu")
int ucasemap_utf8FoldCase(const(UCaseMap)* csm, byte* dest, int destCapacity, const(byte)* src, int srcLength, 
                          UErrorCode* pErrorCode);

@DllImport("icu")
UStringPrepProfile* usprep_open(const(byte)* path, const(byte)* fileName, UErrorCode* status);

@DllImport("icu")
UStringPrepProfile* usprep_openByType(UStringPrepProfileType type, UErrorCode* status);

@DllImport("icu")
void usprep_close(UStringPrepProfile* profile);

@DllImport("icu")
int usprep_prepare(const(UStringPrepProfile)* prep, const(ushort)* src, int srcLength, ushort* dest, 
                   int destCapacity, int options, UParseError* parseError, UErrorCode* status);

@DllImport("icu")
UIDNA* uidna_openUTS46(uint options, UErrorCode* pErrorCode);

@DllImport("icu")
void uidna_close(UIDNA* idna);

@DllImport("icu")
int uidna_labelToASCII(const(UIDNA)* idna, const(ushort)* label, int length, ushort* dest, int capacity, 
                       UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icu")
int uidna_labelToUnicode(const(UIDNA)* idna, const(ushort)* label, int length, ushort* dest, int capacity, 
                         UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icu")
int uidna_nameToASCII(const(UIDNA)* idna, const(ushort)* name, int length, ushort* dest, int capacity, 
                      UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icu")
int uidna_nameToUnicode(const(UIDNA)* idna, const(ushort)* name, int length, ushort* dest, int capacity, 
                        UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icu")
int uidna_labelToASCII_UTF8(const(UIDNA)* idna, const(byte)* label, int length, byte* dest, int capacity, 
                            UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icu")
int uidna_labelToUnicodeUTF8(const(UIDNA)* idna, const(byte)* label, int length, byte* dest, int capacity, 
                             UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icu")
int uidna_nameToASCII_UTF8(const(UIDNA)* idna, const(byte)* name, int length, byte* dest, int capacity, 
                           UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icu")
int uidna_nameToUnicodeUTF8(const(UIDNA)* idna, const(byte)* name, int length, byte* dest, int capacity, 
                            UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icu")
UBreakIterator* ubrk_open(UBreakIteratorType type, const(byte)* locale, const(ushort)* text, int textLength, 
                          UErrorCode* status);

@DllImport("icu")
UBreakIterator* ubrk_openRules(const(ushort)* rules, int rulesLength, const(ushort)* text, int textLength, 
                               UParseError* parseErr, UErrorCode* status);

@DllImport("icu")
UBreakIterator* ubrk_openBinaryRules(const(ubyte)* binaryRules, int rulesLength, const(ushort)* text, 
                                     int textLength, UErrorCode* status);

@DllImport("icu")
UBreakIterator* ubrk_safeClone(const(UBreakIterator)* bi, void* stackBuffer, int* pBufferSize, UErrorCode* status);

@DllImport("icu")
void ubrk_close(UBreakIterator* bi);

@DllImport("icu")
void ubrk_setText(UBreakIterator* bi, const(ushort)* text, int textLength, UErrorCode* status);

@DllImport("icu")
void ubrk_setUText(UBreakIterator* bi, UText* text, UErrorCode* status);

@DllImport("icu")
int ubrk_current(const(UBreakIterator)* bi);

@DllImport("icu")
int ubrk_next(UBreakIterator* bi);

@DllImport("icu")
int ubrk_previous(UBreakIterator* bi);

@DllImport("icu")
int ubrk_first(UBreakIterator* bi);

@DllImport("icu")
int ubrk_last(UBreakIterator* bi);

@DllImport("icu")
int ubrk_preceding(UBreakIterator* bi, int offset);

@DllImport("icu")
int ubrk_following(UBreakIterator* bi, int offset);

@DllImport("icu")
byte* ubrk_getAvailable(int index);

@DllImport("icu")
int ubrk_countAvailable();

@DllImport("icu")
byte ubrk_isBoundary(UBreakIterator* bi, int offset);

@DllImport("icu")
int ubrk_getRuleStatus(UBreakIterator* bi);

@DllImport("icu")
int ubrk_getRuleStatusVec(UBreakIterator* bi, int* fillInVec, int capacity, UErrorCode* status);

@DllImport("icu")
byte* ubrk_getLocaleByType(const(UBreakIterator)* bi, ULocDataLocaleType type, UErrorCode* status);

@DllImport("icu")
void ubrk_refreshUText(UBreakIterator* bi, UText* text, UErrorCode* status);

@DllImport("icu")
int ubrk_getBinaryRules(UBreakIterator* bi, ubyte* binaryRules, int rulesCapacity, UErrorCode* status);

@DllImport("icu")
void u_getDataVersion(ubyte* dataVersionFillin, UErrorCode* status);

@DllImport("icu")
UEnumeration* ucal_openTimeZoneIDEnumeration(USystemTimeZoneType zoneType, const(byte)* region, 
                                             const(int)* rawOffset, UErrorCode* ec);

@DllImport("icu")
UEnumeration* ucal_openTimeZones(UErrorCode* ec);

@DllImport("icu")
UEnumeration* ucal_openCountryTimeZones(const(byte)* country, UErrorCode* ec);

@DllImport("icu")
int ucal_getDefaultTimeZone(ushort* result, int resultCapacity, UErrorCode* ec);

@DllImport("icu")
void ucal_setDefaultTimeZone(const(ushort)* zoneID, UErrorCode* ec);

@DllImport("icu")
int ucal_getDSTSavings(const(ushort)* zoneID, UErrorCode* ec);

@DllImport("icu")
double ucal_getNow();

@DllImport("icu")
void** ucal_open(const(ushort)* zoneID, int len, const(byte)* locale, UCalendarType type, UErrorCode* status);

@DllImport("icu")
void ucal_close(void** cal);

@DllImport("icu")
void** ucal_clone(const(void)** cal, UErrorCode* status);

@DllImport("icu")
void ucal_setTimeZone(void** cal, const(ushort)* zoneID, int len, UErrorCode* status);

@DllImport("icu")
int ucal_getTimeZoneID(const(void)** cal, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icu")
int ucal_getTimeZoneDisplayName(const(void)** cal, UCalendarDisplayNameType type, const(byte)* locale, 
                                ushort* result, int resultLength, UErrorCode* status);

@DllImport("icu")
byte ucal_inDaylightTime(const(void)** cal, UErrorCode* status);

@DllImport("icu")
void ucal_setGregorianChange(void** cal, double date, UErrorCode* pErrorCode);

@DllImport("icu")
double ucal_getGregorianChange(const(void)** cal, UErrorCode* pErrorCode);

@DllImport("icu")
int ucal_getAttribute(const(void)** cal, UCalendarAttribute attr);

@DllImport("icu")
void ucal_setAttribute(void** cal, UCalendarAttribute attr, int newValue);

@DllImport("icu")
byte* ucal_getAvailable(int localeIndex);

@DllImport("icu")
int ucal_countAvailable();

@DllImport("icu")
double ucal_getMillis(const(void)** cal, UErrorCode* status);

@DllImport("icu")
void ucal_setMillis(void** cal, double dateTime, UErrorCode* status);

@DllImport("icu")
void ucal_setDate(void** cal, int year, int month, int date, UErrorCode* status);

@DllImport("icu")
void ucal_setDateTime(void** cal, int year, int month, int date, int hour, int minute, int second, 
                      UErrorCode* status);

@DllImport("icu")
byte ucal_equivalentTo(const(void)** cal1, const(void)** cal2);

@DllImport("icu")
void ucal_add(void** cal, UCalendarDateFields field, int amount, UErrorCode* status);

@DllImport("icu")
void ucal_roll(void** cal, UCalendarDateFields field, int amount, UErrorCode* status);

@DllImport("icu")
int ucal_get(const(void)** cal, UCalendarDateFields field, UErrorCode* status);

@DllImport("icu")
void ucal_set(void** cal, UCalendarDateFields field, int value);

@DllImport("icu")
byte ucal_isSet(const(void)** cal, UCalendarDateFields field);

@DllImport("icu")
void ucal_clearField(void** cal, UCalendarDateFields field);

@DllImport("icu")
void ucal_clear(void** calendar);

@DllImport("icu")
int ucal_getLimit(const(void)** cal, UCalendarDateFields field, UCalendarLimitType type, UErrorCode* status);

@DllImport("icu")
byte* ucal_getLocaleByType(const(void)** cal, ULocDataLocaleType type, UErrorCode* status);

@DllImport("icu")
byte* ucal_getTZDataVersion(UErrorCode* status);

@DllImport("icu")
int ucal_getCanonicalTimeZoneID(const(ushort)* id, int len, ushort* result, int resultCapacity, byte* isSystemID, 
                                UErrorCode* status);

@DllImport("icu")
byte* ucal_getType(const(void)** cal, UErrorCode* status);

@DllImport("icu")
UEnumeration* ucal_getKeywordValuesForLocale(const(byte)* key, const(byte)* locale, byte commonlyUsed, 
                                             UErrorCode* status);

@DllImport("icu")
UCalendarWeekdayType ucal_getDayOfWeekType(const(void)** cal, UCalendarDaysOfWeek dayOfWeek, UErrorCode* status);

@DllImport("icu")
int ucal_getWeekendTransition(const(void)** cal, UCalendarDaysOfWeek dayOfWeek, UErrorCode* status);

@DllImport("icu")
byte ucal_isWeekend(const(void)** cal, double date, UErrorCode* status);

@DllImport("icu")
int ucal_getFieldDifference(void** cal, double target, UCalendarDateFields field, UErrorCode* status);

@DllImport("icu")
byte ucal_getTimeZoneTransitionDate(const(void)** cal, UTimeZoneTransitionType type, double* transition, 
                                    UErrorCode* status);

@DllImport("icu")
int ucal_getWindowsTimeZoneID(const(ushort)* id, int len, ushort* winid, int winidCapacity, UErrorCode* status);

@DllImport("icu")
int ucal_getTimeZoneIDForWindowsID(const(ushort)* winid, int len, const(byte)* region, ushort* id, int idCapacity, 
                                   UErrorCode* status);

@DllImport("icu")
UCollator* ucol_open(const(byte)* loc, UErrorCode* status);

@DllImport("icu")
UCollator* ucol_openRules(const(ushort)* rules, int rulesLength, UColAttributeValue normalizationMode, 
                          UColAttributeValue strength, UParseError* parseError, UErrorCode* status);

@DllImport("icu")
void ucol_getContractionsAndExpansions(const(UCollator)* coll, USet* contractions, USet* expansions, 
                                       byte addPrefixes, UErrorCode* status);

@DllImport("icu")
void ucol_close(UCollator* coll);

@DllImport("icu")
UCollationResult ucol_strcoll(const(UCollator)* coll, const(ushort)* source, int sourceLength, 
                              const(ushort)* target, int targetLength);

@DllImport("icu")
UCollationResult ucol_strcollUTF8(const(UCollator)* coll, const(byte)* source, int sourceLength, 
                                  const(byte)* target, int targetLength, UErrorCode* status);

@DllImport("icu")
byte ucol_greater(const(UCollator)* coll, const(ushort)* source, int sourceLength, const(ushort)* target, 
                  int targetLength);

@DllImport("icu")
byte ucol_greaterOrEqual(const(UCollator)* coll, const(ushort)* source, int sourceLength, const(ushort)* target, 
                         int targetLength);

@DllImport("icu")
byte ucol_equal(const(UCollator)* coll, const(ushort)* source, int sourceLength, const(ushort)* target, 
                int targetLength);

@DllImport("icu")
UCollationResult ucol_strcollIter(const(UCollator)* coll, UCharIterator* sIter, UCharIterator* tIter, 
                                  UErrorCode* status);

@DllImport("icu")
UColAttributeValue ucol_getStrength(const(UCollator)* coll);

@DllImport("icu")
void ucol_setStrength(UCollator* coll, UColAttributeValue strength);

@DllImport("icu")
int ucol_getReorderCodes(const(UCollator)* coll, int* dest, int destCapacity, UErrorCode* pErrorCode);

@DllImport("icu")
void ucol_setReorderCodes(UCollator* coll, const(int)* reorderCodes, int reorderCodesLength, 
                          UErrorCode* pErrorCode);

@DllImport("icu")
int ucol_getEquivalentReorderCodes(int reorderCode, int* dest, int destCapacity, UErrorCode* pErrorCode);

@DllImport("icu")
int ucol_getDisplayName(const(byte)* objLoc, const(byte)* dispLoc, ushort* result, int resultLength, 
                        UErrorCode* status);

@DllImport("icu")
byte* ucol_getAvailable(int localeIndex);

@DllImport("icu")
int ucol_countAvailable();

@DllImport("icu")
UEnumeration* ucol_openAvailableLocales(UErrorCode* status);

@DllImport("icu")
UEnumeration* ucol_getKeywords(UErrorCode* status);

@DllImport("icu")
UEnumeration* ucol_getKeywordValues(const(byte)* keyword, UErrorCode* status);

@DllImport("icu")
UEnumeration* ucol_getKeywordValuesForLocale(const(byte)* key, const(byte)* locale, byte commonlyUsed, 
                                             UErrorCode* status);

@DllImport("icu")
int ucol_getFunctionalEquivalent(byte* result, int resultCapacity, const(byte)* keyword, const(byte)* locale, 
                                 byte* isAvailable, UErrorCode* status);

@DllImport("icu")
ushort* ucol_getRules(const(UCollator)* coll, int* length);

@DllImport("icu")
int ucol_getSortKey(const(UCollator)* coll, const(ushort)* source, int sourceLength, ubyte* result, 
                    int resultLength);

@DllImport("icu")
int ucol_nextSortKeyPart(const(UCollator)* coll, UCharIterator* iter, uint* state, ubyte* dest, int count, 
                         UErrorCode* status);

@DllImport("icu")
int ucol_getBound(const(ubyte)* source, int sourceLength, UColBoundMode boundType, uint noOfLevels, ubyte* result, 
                  int resultLength, UErrorCode* status);

@DllImport("icu")
void ucol_getVersion(const(UCollator)* coll, ubyte* info);

@DllImport("icu")
void ucol_getUCAVersion(const(UCollator)* coll, ubyte* info);

@DllImport("icu")
int ucol_mergeSortkeys(const(ubyte)* src1, int src1Length, const(ubyte)* src2, int src2Length, ubyte* dest, 
                       int destCapacity);

@DllImport("icu")
void ucol_setAttribute(UCollator* coll, UColAttribute attr, UColAttributeValue value, UErrorCode* status);

@DllImport("icu")
UColAttributeValue ucol_getAttribute(const(UCollator)* coll, UColAttribute attr, UErrorCode* status);

@DllImport("icu")
void ucol_setMaxVariable(UCollator* coll, UColReorderCode group, UErrorCode* pErrorCode);

@DllImport("icu")
UColReorderCode ucol_getMaxVariable(const(UCollator)* coll);

@DllImport("icu")
uint ucol_getVariableTop(const(UCollator)* coll, UErrorCode* status);

@DllImport("icu")
UCollator* ucol_safeClone(const(UCollator)* coll, void* stackBuffer, int* pBufferSize, UErrorCode* status);

@DllImport("icu")
int ucol_getRulesEx(const(UCollator)* coll, UColRuleOption delta, ushort* buffer, int bufferLen);

@DllImport("icu")
byte* ucol_getLocaleByType(const(UCollator)* coll, ULocDataLocaleType type, UErrorCode* status);

@DllImport("icu")
USet* ucol_getTailoredSet(const(UCollator)* coll, UErrorCode* status);

@DllImport("icu")
int ucol_cloneBinary(const(UCollator)* coll, ubyte* buffer, int capacity, UErrorCode* status);

@DllImport("icu")
UCollator* ucol_openBinary(const(ubyte)* bin, int length, const(UCollator)* base, UErrorCode* status);

@DllImport("icu")
UCollationElements* ucol_openElements(const(UCollator)* coll, const(ushort)* text, int textLength, 
                                      UErrorCode* status);

@DllImport("icu")
int ucol_keyHashCode(const(ubyte)* key, int length);

@DllImport("icu")
void ucol_closeElements(UCollationElements* elems);

@DllImport("icu")
void ucol_reset(UCollationElements* elems);

@DllImport("icu")
int ucol_next(UCollationElements* elems, UErrorCode* status);

@DllImport("icu")
int ucol_previous(UCollationElements* elems, UErrorCode* status);

@DllImport("icu")
int ucol_getMaxExpansion(const(UCollationElements)* elems, int order);

@DllImport("icu")
void ucol_setText(UCollationElements* elems, const(ushort)* text, int textLength, UErrorCode* status);

@DllImport("icu")
int ucol_getOffset(const(UCollationElements)* elems);

@DllImport("icu")
void ucol_setOffset(UCollationElements* elems, int offset, UErrorCode* status);

@DllImport("icu")
int ucol_primaryOrder(int order);

@DllImport("icu")
int ucol_secondaryOrder(int order);

@DllImport("icu")
int ucol_tertiaryOrder(int order);

@DllImport("icu")
UCharsetDetector* ucsdet_open(UErrorCode* status);

@DllImport("icu")
void ucsdet_close(UCharsetDetector* ucsd);

@DllImport("icu")
void ucsdet_setText(UCharsetDetector* ucsd, const(byte)* textIn, int len, UErrorCode* status);

@DllImport("icu")
void ucsdet_setDeclaredEncoding(UCharsetDetector* ucsd, const(byte)* encoding, int length, UErrorCode* status);

@DllImport("icu")
UCharsetMatch* ucsdet_detect(UCharsetDetector* ucsd, UErrorCode* status);

@DllImport("icu")
UCharsetMatch** ucsdet_detectAll(UCharsetDetector* ucsd, int* matchesFound, UErrorCode* status);

@DllImport("icu")
byte* ucsdet_getName(const(UCharsetMatch)* ucsm, UErrorCode* status);

@DllImport("icu")
int ucsdet_getConfidence(const(UCharsetMatch)* ucsm, UErrorCode* status);

@DllImport("icu")
byte* ucsdet_getLanguage(const(UCharsetMatch)* ucsm, UErrorCode* status);

@DllImport("icu")
int ucsdet_getUChars(const(UCharsetMatch)* ucsm, ushort* buf, int cap, UErrorCode* status);

@DllImport("icu")
UEnumeration* ucsdet_getAllDetectableCharsets(const(UCharsetDetector)* ucsd, UErrorCode* status);

@DllImport("icu")
byte ucsdet_isInputFilterEnabled(const(UCharsetDetector)* ucsd);

@DllImport("icu")
byte ucsdet_enableInputFilter(UCharsetDetector* ucsd, byte filter);

@DllImport("icu")
void** udatpg_open(const(byte)* locale, UErrorCode* pErrorCode);

@DllImport("icu")
void** udatpg_openEmpty(UErrorCode* pErrorCode);

@DllImport("icu")
void udatpg_close(void** dtpg);

@DllImport("icu")
void** udatpg_clone(const(void)** dtpg, UErrorCode* pErrorCode);

@DllImport("icu")
int udatpg_getBestPattern(void** dtpg, const(ushort)* skeleton, int length, ushort* bestPattern, int capacity, 
                          UErrorCode* pErrorCode);

@DllImport("icu")
int udatpg_getBestPatternWithOptions(void** dtpg, const(ushort)* skeleton, int length, 
                                     UDateTimePatternMatchOptions options, ushort* bestPattern, int capacity, 
                                     UErrorCode* pErrorCode);

@DllImport("icu")
int udatpg_getSkeleton(void** unusedDtpg, const(ushort)* pattern, int length, ushort* skeleton, int capacity, 
                       UErrorCode* pErrorCode);

@DllImport("icu")
int udatpg_getBaseSkeleton(void** unusedDtpg, const(ushort)* pattern, int length, ushort* baseSkeleton, 
                           int capacity, UErrorCode* pErrorCode);

@DllImport("icu")
UDateTimePatternConflict udatpg_addPattern(void** dtpg, const(ushort)* pattern, int patternLength, byte override_, 
                                           ushort* conflictingPattern, int capacity, int* pLength, 
                                           UErrorCode* pErrorCode);

@DllImport("icu")
void udatpg_setAppendItemFormat(void** dtpg, UDateTimePatternField field, const(ushort)* value, int length);

@DllImport("icu")
ushort* udatpg_getAppendItemFormat(const(void)** dtpg, UDateTimePatternField field, int* pLength);

@DllImport("icu")
void udatpg_setAppendItemName(void** dtpg, UDateTimePatternField field, const(ushort)* value, int length);

@DllImport("icu")
ushort* udatpg_getAppendItemName(const(void)** dtpg, UDateTimePatternField field, int* pLength);

@DllImport("icu")
int udatpg_getFieldDisplayName(const(void)** dtpg, UDateTimePatternField field, UDateTimePGDisplayWidth width, 
                               ushort* fieldName, int capacity, UErrorCode* pErrorCode);

@DllImport("icu")
void udatpg_setDateTimeFormat(const(void)** dtpg, const(ushort)* dtFormat, int length);

@DllImport("icu")
ushort* udatpg_getDateTimeFormat(const(void)** dtpg, int* pLength);

@DllImport("icu")
void udatpg_setDecimal(void** dtpg, const(ushort)* decimal, int length);

@DllImport("icu")
ushort* udatpg_getDecimal(const(void)** dtpg, int* pLength);

@DllImport("icu")
int udatpg_replaceFieldTypes(void** dtpg, const(ushort)* pattern, int patternLength, const(ushort)* skeleton, 
                             int skeletonLength, ushort* dest, int destCapacity, UErrorCode* pErrorCode);

@DllImport("icu")
int udatpg_replaceFieldTypesWithOptions(void** dtpg, const(ushort)* pattern, int patternLength, 
                                        const(ushort)* skeleton, int skeletonLength, 
                                        UDateTimePatternMatchOptions options, ushort* dest, int destCapacity, 
                                        UErrorCode* pErrorCode);

@DllImport("icu")
UEnumeration* udatpg_openSkeletons(const(void)** dtpg, UErrorCode* pErrorCode);

@DllImport("icu")
UEnumeration* udatpg_openBaseSkeletons(const(void)** dtpg, UErrorCode* pErrorCode);

@DllImport("icu")
ushort* udatpg_getPatternForSkeleton(const(void)** dtpg, const(ushort)* skeleton, int skeletonLength, int* pLength);

@DllImport("icu")
UFieldPositionIterator* ufieldpositer_open(UErrorCode* status);

@DllImport("icu")
void ufieldpositer_close(UFieldPositionIterator* fpositer);

@DllImport("icu")
int ufieldpositer_next(UFieldPositionIterator* fpositer, int* beginIndex, int* endIndex);

@DllImport("icu")
void** ufmt_open(UErrorCode* status);

@DllImport("icu")
void ufmt_close(void** fmt);

@DllImport("icu")
UFormattableType ufmt_getType(const(void)** fmt, UErrorCode* status);

@DllImport("icu")
byte ufmt_isNumeric(const(void)** fmt);

@DllImport("icu")
double ufmt_getDate(const(void)** fmt, UErrorCode* status);

@DllImport("icu")
double ufmt_getDouble(void** fmt, UErrorCode* status);

@DllImport("icu")
int ufmt_getLong(void** fmt, UErrorCode* status);

@DllImport("icu")
long ufmt_getInt64(void** fmt, UErrorCode* status);

@DllImport("icu")
void* ufmt_getObject(const(void)** fmt, UErrorCode* status);

@DllImport("icu")
ushort* ufmt_getUChars(void** fmt, int* len, UErrorCode* status);

@DllImport("icu")
int ufmt_getArrayLength(const(void)** fmt, UErrorCode* status);

@DllImport("icu")
void** ufmt_getArrayItemByIndex(void** fmt, int n, UErrorCode* status);

@DllImport("icu")
byte* ufmt_getDecNumChars(void** fmt, int* len, UErrorCode* status);

@DllImport("icu")
UDateIntervalFormat* udtitvfmt_open(const(byte)* locale, const(ushort)* skeleton, int skeletonLength, 
                                    const(ushort)* tzID, int tzIDLength, UErrorCode* status);

@DllImport("icu")
void udtitvfmt_close(UDateIntervalFormat* formatter);

@DllImport("icu")
int udtitvfmt_format(const(UDateIntervalFormat)* formatter, double fromDate, double toDate, ushort* result, 
                     int resultCapacity, UFieldPosition* position, UErrorCode* status);

@DllImport("icu")
UGenderInfo* ugender_getInstance(const(byte)* locale, UErrorCode* status);

@DllImport("icu")
UGender ugender_getListGender(const(UGenderInfo)* genderInfo, const(UGender)* genders, int size, 
                              UErrorCode* status);

@DllImport("icu")
UListFormatter* ulistfmt_open(const(byte)* locale, UErrorCode* status);

@DllImport("icu")
void ulistfmt_close(UListFormatter* listfmt);

@DllImport("icu")
int ulistfmt_format(const(UListFormatter)* listfmt, const(ushort)** strings, const(int)* stringLengths, 
                    int stringCount, ushort* result, int resultCapacity, UErrorCode* status);

@DllImport("icu")
ULocaleData* ulocdata_open(const(byte)* localeID, UErrorCode* status);

@DllImport("icu")
void ulocdata_close(ULocaleData* uld);

@DllImport("icu")
void ulocdata_setNoSubstitute(ULocaleData* uld, byte setting);

@DllImport("icu")
byte ulocdata_getNoSubstitute(ULocaleData* uld);

@DllImport("icu")
USet* ulocdata_getExemplarSet(ULocaleData* uld, USet* fillIn, uint options, ULocaleDataExemplarSetType extype, 
                              UErrorCode* status);

@DllImport("icu")
int ulocdata_getDelimiter(ULocaleData* uld, ULocaleDataDelimiterType type, ushort* result, int resultLength, 
                          UErrorCode* status);

@DllImport("icu")
UMeasurementSystem ulocdata_getMeasurementSystem(const(byte)* localeID, UErrorCode* status);

@DllImport("icu")
void ulocdata_getPaperSize(const(byte)* localeID, int* height, int* width, UErrorCode* status);

@DllImport("icu")
void ulocdata_getCLDRVersion(ubyte* versionArray, UErrorCode* status);

@DllImport("icu")
int ulocdata_getLocaleDisplayPattern(ULocaleData* uld, ushort* pattern, int patternCapacity, UErrorCode* status);

@DllImport("icu")
int ulocdata_getLocaleSeparator(ULocaleData* uld, ushort* separator, int separatorCapacity, UErrorCode* status);

@DllImport("icu")
int u_formatMessage(const(byte)* locale, const(ushort)* pattern, int patternLength, ushort* result, 
                    int resultLength, UErrorCode* status);

@DllImport("icu")
int u_vformatMessage(const(byte)* locale, const(ushort)* pattern, int patternLength, ushort* result, 
                     int resultLength, byte* ap, UErrorCode* status);

@DllImport("icu")
void u_parseMessage(const(byte)* locale, const(ushort)* pattern, int patternLength, const(ushort)* source, 
                    int sourceLength, UErrorCode* status);

@DllImport("icu")
void u_vparseMessage(const(byte)* locale, const(ushort)* pattern, int patternLength, const(ushort)* source, 
                     int sourceLength, byte* ap, UErrorCode* status);

@DllImport("icu")
int u_formatMessageWithError(const(byte)* locale, const(ushort)* pattern, int patternLength, ushort* result, 
                             int resultLength, UParseError* parseError, UErrorCode* status);

@DllImport("icu")
int u_vformatMessageWithError(const(byte)* locale, const(ushort)* pattern, int patternLength, ushort* result, 
                              int resultLength, UParseError* parseError, byte* ap, UErrorCode* status);

@DllImport("icu")
void u_parseMessageWithError(const(byte)* locale, const(ushort)* pattern, int patternLength, const(ushort)* source, 
                             int sourceLength, UParseError* parseError, UErrorCode* status);

@DllImport("icu")
void u_vparseMessageWithError(const(byte)* locale, const(ushort)* pattern, int patternLength, 
                              const(ushort)* source, int sourceLength, byte* ap, UParseError* parseError, 
                              UErrorCode* status);

@DllImport("icu")
void** umsg_open(const(ushort)* pattern, int patternLength, const(byte)* locale, UParseError* parseError, 
                 UErrorCode* status);

@DllImport("icu")
void umsg_close(void** format);

@DllImport("icu")
void* umsg_clone(const(void)** fmt, UErrorCode* status);

@DllImport("icu")
void umsg_setLocale(void** fmt, const(byte)* locale);

@DllImport("icu")
byte* umsg_getLocale(const(void)** fmt);

@DllImport("icu")
void umsg_applyPattern(void** fmt, const(ushort)* pattern, int patternLength, UParseError* parseError, 
                       UErrorCode* status);

@DllImport("icu")
int umsg_toPattern(const(void)** fmt, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icu")
int umsg_format(const(void)** fmt, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icu")
int umsg_vformat(const(void)** fmt, ushort* result, int resultLength, byte* ap, UErrorCode* status);

@DllImport("icu")
void umsg_parse(const(void)** fmt, const(ushort)* source, int sourceLength, int* count, UErrorCode* status);

@DllImport("icu")
void umsg_vparse(const(void)** fmt, const(ushort)* source, int sourceLength, int* count, byte* ap, 
                 UErrorCode* status);

@DllImport("icu")
int umsg_autoQuoteApostrophe(const(ushort)* pattern, int patternLength, ushort* dest, int destCapacity, 
                             UErrorCode* ec);

@DllImport("icu")
void** unum_open(UNumberFormatStyle style, const(ushort)* pattern, int patternLength, const(byte)* locale, 
                 UParseError* parseErr, UErrorCode* status);

@DllImport("icu")
void unum_close(void** fmt);

@DllImport("icu")
void** unum_clone(const(void)** fmt, UErrorCode* status);

@DllImport("icu")
int unum_format(const(void)** fmt, int number, ushort* result, int resultLength, UFieldPosition* pos, 
                UErrorCode* status);

@DllImport("icu")
int unum_formatInt64(const(void)** fmt, long number, ushort* result, int resultLength, UFieldPosition* pos, 
                     UErrorCode* status);

@DllImport("icu")
int unum_formatDouble(const(void)** fmt, double number, ushort* result, int resultLength, UFieldPosition* pos, 
                      UErrorCode* status);

@DllImport("icu")
int unum_formatDoubleForFields(const(void)** format, double number, ushort* result, int resultLength, 
                               UFieldPositionIterator* fpositer, UErrorCode* status);

@DllImport("icu")
int unum_formatDecimal(const(void)** fmt, const(byte)* number, int length, ushort* result, int resultLength, 
                       UFieldPosition* pos, UErrorCode* status);

@DllImport("icu")
int unum_formatDoubleCurrency(const(void)** fmt, double number, ushort* currency, ushort* result, int resultLength, 
                              UFieldPosition* pos, UErrorCode* status);

@DllImport("icu")
int unum_formatUFormattable(const(void)** fmt, const(void)** number, ushort* result, int resultLength, 
                            UFieldPosition* pos, UErrorCode* status);

@DllImport("icu")
int unum_parse(const(void)** fmt, const(ushort)* text, int textLength, int* parsePos, UErrorCode* status);

@DllImport("icu")
long unum_parseInt64(const(void)** fmt, const(ushort)* text, int textLength, int* parsePos, UErrorCode* status);

@DllImport("icu")
double unum_parseDouble(const(void)** fmt, const(ushort)* text, int textLength, int* parsePos, UErrorCode* status);

@DllImport("icu")
int unum_parseDecimal(const(void)** fmt, const(ushort)* text, int textLength, int* parsePos, byte* outBuf, 
                      int outBufLength, UErrorCode* status);

@DllImport("icu")
double unum_parseDoubleCurrency(const(void)** fmt, const(ushort)* text, int textLength, int* parsePos, 
                                ushort* currency, UErrorCode* status);

@DllImport("icu")
void** unum_parseToUFormattable(const(void)** fmt, void** result, const(ushort)* text, int textLength, 
                                int* parsePos, UErrorCode* status);

@DllImport("icu")
void unum_applyPattern(void** format, byte localized, const(ushort)* pattern, int patternLength, 
                       UParseError* parseError, UErrorCode* status);

@DllImport("icu")
byte* unum_getAvailable(int localeIndex);

@DllImport("icu")
int unum_countAvailable();

@DllImport("icu")
int unum_getAttribute(const(void)** fmt, UNumberFormatAttribute attr);

@DllImport("icu")
void unum_setAttribute(void** fmt, UNumberFormatAttribute attr, int newValue);

@DllImport("icu")
double unum_getDoubleAttribute(const(void)** fmt, UNumberFormatAttribute attr);

@DllImport("icu")
void unum_setDoubleAttribute(void** fmt, UNumberFormatAttribute attr, double newValue);

@DllImport("icu")
int unum_getTextAttribute(const(void)** fmt, UNumberFormatTextAttribute tag, ushort* result, int resultLength, 
                          UErrorCode* status);

@DllImport("icu")
void unum_setTextAttribute(void** fmt, UNumberFormatTextAttribute tag, const(ushort)* newValue, int newValueLength, 
                           UErrorCode* status);

@DllImport("icu")
int unum_toPattern(const(void)** fmt, byte isPatternLocalized, ushort* result, int resultLength, 
                   UErrorCode* status);

@DllImport("icu")
int unum_getSymbol(const(void)** fmt, UNumberFormatSymbol symbol, ushort* buffer, int size, UErrorCode* status);

@DllImport("icu")
void unum_setSymbol(void** fmt, UNumberFormatSymbol symbol, const(ushort)* value, int length, UErrorCode* status);

@DllImport("icu")
byte* unum_getLocaleByType(const(void)** fmt, ULocDataLocaleType type, UErrorCode* status);

@DllImport("icu")
void unum_setContext(void** fmt, UDisplayContext value, UErrorCode* status);

@DllImport("icu")
UDisplayContext unum_getContext(const(void)** fmt, UDisplayContextType type, UErrorCode* status);

@DllImport("icu")
UCalendarDateFields udat_toCalendarDateField(UDateFormatField field);

@DllImport("icu")
void** udat_open(UDateFormatStyle timeStyle, UDateFormatStyle dateStyle, const(byte)* locale, const(ushort)* tzID, 
                 int tzIDLength, const(ushort)* pattern, int patternLength, UErrorCode* status);

@DllImport("icu")
void udat_close(void** format);

@DllImport("icu")
byte udat_getBooleanAttribute(const(void)** fmt, UDateFormatBooleanAttribute attr, UErrorCode* status);

@DllImport("icu")
void udat_setBooleanAttribute(void** fmt, UDateFormatBooleanAttribute attr, byte newValue, UErrorCode* status);

@DllImport("icu")
void** udat_clone(const(void)** fmt, UErrorCode* status);

@DllImport("icu")
int udat_format(const(void)** format, double dateToFormat, ushort* result, int resultLength, 
                UFieldPosition* position, UErrorCode* status);

@DllImport("icu")
int udat_formatCalendar(const(void)** format, void** calendar, ushort* result, int capacity, 
                        UFieldPosition* position, UErrorCode* status);

@DllImport("icu")
int udat_formatForFields(const(void)** format, double dateToFormat, ushort* result, int resultLength, 
                         UFieldPositionIterator* fpositer, UErrorCode* status);

@DllImport("icu")
int udat_formatCalendarForFields(const(void)** format, void** calendar, ushort* result, int capacity, 
                                 UFieldPositionIterator* fpositer, UErrorCode* status);

@DllImport("icu")
double udat_parse(const(void)** format, const(ushort)* text, int textLength, int* parsePos, UErrorCode* status);

@DllImport("icu")
void udat_parseCalendar(const(void)** format, void** calendar, const(ushort)* text, int textLength, int* parsePos, 
                        UErrorCode* status);

@DllImport("icu")
byte udat_isLenient(const(void)** fmt);

@DllImport("icu")
void udat_setLenient(void** fmt, byte isLenient);

@DllImport("icu")
void** udat_getCalendar(const(void)** fmt);

@DllImport("icu")
void udat_setCalendar(void** fmt, const(void)** calendarToSet);

@DllImport("icu")
void** udat_getNumberFormat(const(void)** fmt);

@DllImport("icu")
void** udat_getNumberFormatForField(const(void)** fmt, ushort field);

@DllImport("icu")
void udat_adoptNumberFormatForFields(void** fmt, const(ushort)* fields, void** numberFormatToSet, 
                                     UErrorCode* status);

@DllImport("icu")
void udat_setNumberFormat(void** fmt, const(void)** numberFormatToSet);

@DllImport("icu")
void udat_adoptNumberFormat(void** fmt, void** numberFormatToAdopt);

@DllImport("icu")
byte* udat_getAvailable(int localeIndex);

@DllImport("icu")
int udat_countAvailable();

@DllImport("icu")
double udat_get2DigitYearStart(const(void)** fmt, UErrorCode* status);

@DllImport("icu")
void udat_set2DigitYearStart(void** fmt, double d, UErrorCode* status);

@DllImport("icu")
int udat_toPattern(const(void)** fmt, byte localized, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icu")
void udat_applyPattern(void** format, byte localized, const(ushort)* pattern, int patternLength);

@DllImport("icu")
int udat_getSymbols(const(void)** fmt, UDateFormatSymbolType type, int symbolIndex, ushort* result, 
                    int resultLength, UErrorCode* status);

@DllImport("icu")
int udat_countSymbols(const(void)** fmt, UDateFormatSymbolType type);

@DllImport("icu")
void udat_setSymbols(void** format, UDateFormatSymbolType type, int symbolIndex, ushort* value, int valueLength, 
                     UErrorCode* status);

@DllImport("icu")
byte* udat_getLocaleByType(const(void)** fmt, ULocDataLocaleType type, UErrorCode* status);

@DllImport("icu")
void udat_setContext(void** fmt, UDisplayContext value, UErrorCode* status);

@DllImport("icu")
UDisplayContext udat_getContext(const(void)** fmt, UDisplayContextType type, UErrorCode* status);

@DllImport("icu")
UNumberFormatter* unumf_openForSkeletonAndLocale(const(ushort)* skeleton, int skeletonLen, const(byte)* locale, 
                                                 UErrorCode* ec);

@DllImport("icu")
UFormattedNumber* unumf_openResult(UErrorCode* ec);

@DllImport("icu")
void unumf_formatInt(const(UNumberFormatter)* uformatter, long value, UFormattedNumber* uresult, UErrorCode* ec);

@DllImport("icu")
void unumf_formatDouble(const(UNumberFormatter)* uformatter, double value, UFormattedNumber* uresult, 
                        UErrorCode* ec);

@DllImport("icu")
void unumf_formatDecimal(const(UNumberFormatter)* uformatter, const(byte)* value, int valueLen, 
                         UFormattedNumber* uresult, UErrorCode* ec);

@DllImport("icu")
int unumf_resultToString(const(UFormattedNumber)* uresult, ushort* buffer, int bufferCapacity, UErrorCode* ec);

@DllImport("icu")
byte unumf_resultNextFieldPosition(const(UFormattedNumber)* uresult, UFieldPosition* ufpos, UErrorCode* ec);

@DllImport("icu")
void unumf_resultGetAllFieldPositions(const(UFormattedNumber)* uresult, UFieldPositionIterator* ufpositer, 
                                      UErrorCode* ec);

@DllImport("icu")
void unumf_close(UNumberFormatter* uformatter);

@DllImport("icu")
void unumf_closeResult(UFormattedNumber* uresult);

@DllImport("icu")
UNumberingSystem* unumsys_open(const(byte)* locale, UErrorCode* status);

@DllImport("icu")
UNumberingSystem* unumsys_openByName(const(byte)* name, UErrorCode* status);

@DllImport("icu")
void unumsys_close(UNumberingSystem* unumsys);

@DllImport("icu")
UEnumeration* unumsys_openAvailableNames(UErrorCode* status);

@DllImport("icu")
byte* unumsys_getName(const(UNumberingSystem)* unumsys);

@DllImport("icu")
byte unumsys_isAlgorithmic(const(UNumberingSystem)* unumsys);

@DllImport("icu")
int unumsys_getRadix(const(UNumberingSystem)* unumsys);

@DllImport("icu")
int unumsys_getDescription(const(UNumberingSystem)* unumsys, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icu")
UPluralRules* uplrules_open(const(byte)* locale, UErrorCode* status);

@DllImport("icu")
UPluralRules* uplrules_openForType(const(byte)* locale, UPluralType type, UErrorCode* status);

@DllImport("icu")
void uplrules_close(UPluralRules* uplrules);

@DllImport("icu")
int uplrules_select(const(UPluralRules)* uplrules, double number, ushort* keyword, int capacity, 
                    UErrorCode* status);

@DllImport("icu")
UEnumeration* uplrules_getKeywords(const(UPluralRules)* uplrules, UErrorCode* status);

@DllImport("icu")
URegularExpression* uregex_open(const(ushort)* pattern, int patternLength, uint flags, UParseError* pe, 
                                UErrorCode* status);

@DllImport("icu")
URegularExpression* uregex_openUText(UText* pattern, uint flags, UParseError* pe, UErrorCode* status);

@DllImport("icu")
URegularExpression* uregex_openC(const(byte)* pattern, uint flags, UParseError* pe, UErrorCode* status);

@DllImport("icu")
void uregex_close(URegularExpression* regexp);

@DllImport("icu")
URegularExpression* uregex_clone(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu")
ushort* uregex_pattern(const(URegularExpression)* regexp, int* patLength, UErrorCode* status);

@DllImport("icu")
UText* uregex_patternUText(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu")
int uregex_flags(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu")
void uregex_setText(URegularExpression* regexp, const(ushort)* text, int textLength, UErrorCode* status);

@DllImport("icu")
void uregex_setUText(URegularExpression* regexp, UText* text, UErrorCode* status);

@DllImport("icu")
ushort* uregex_getText(URegularExpression* regexp, int* textLength, UErrorCode* status);

@DllImport("icu")
UText* uregex_getUText(URegularExpression* regexp, UText* dest, UErrorCode* status);

@DllImport("icu")
void uregex_refreshUText(URegularExpression* regexp, UText* text, UErrorCode* status);

@DllImport("icu")
byte uregex_matches(URegularExpression* regexp, int startIndex, UErrorCode* status);

@DllImport("icu")
byte uregex_matches64(URegularExpression* regexp, long startIndex, UErrorCode* status);

@DllImport("icu")
byte uregex_lookingAt(URegularExpression* regexp, int startIndex, UErrorCode* status);

@DllImport("icu")
byte uregex_lookingAt64(URegularExpression* regexp, long startIndex, UErrorCode* status);

@DllImport("icu")
byte uregex_find(URegularExpression* regexp, int startIndex, UErrorCode* status);

@DllImport("icu")
byte uregex_find64(URegularExpression* regexp, long startIndex, UErrorCode* status);

@DllImport("icu")
byte uregex_findNext(URegularExpression* regexp, UErrorCode* status);

@DllImport("icu")
int uregex_groupCount(URegularExpression* regexp, UErrorCode* status);

@DllImport("icu")
int uregex_groupNumberFromName(URegularExpression* regexp, const(ushort)* groupName, int nameLength, 
                               UErrorCode* status);

@DllImport("icu")
int uregex_groupNumberFromCName(URegularExpression* regexp, const(byte)* groupName, int nameLength, 
                                UErrorCode* status);

@DllImport("icu")
int uregex_group(URegularExpression* regexp, int groupNum, ushort* dest, int destCapacity, UErrorCode* status);

@DllImport("icu")
UText* uregex_groupUText(URegularExpression* regexp, int groupNum, UText* dest, long* groupLength, 
                         UErrorCode* status);

@DllImport("icu")
int uregex_start(URegularExpression* regexp, int groupNum, UErrorCode* status);

@DllImport("icu")
long uregex_start64(URegularExpression* regexp, int groupNum, UErrorCode* status);

@DllImport("icu")
int uregex_end(URegularExpression* regexp, int groupNum, UErrorCode* status);

@DllImport("icu")
long uregex_end64(URegularExpression* regexp, int groupNum, UErrorCode* status);

@DllImport("icu")
void uregex_reset(URegularExpression* regexp, int index, UErrorCode* status);

@DllImport("icu")
void uregex_reset64(URegularExpression* regexp, long index, UErrorCode* status);

@DllImport("icu")
void uregex_setRegion(URegularExpression* regexp, int regionStart, int regionLimit, UErrorCode* status);

@DllImport("icu")
void uregex_setRegion64(URegularExpression* regexp, long regionStart, long regionLimit, UErrorCode* status);

@DllImport("icu")
void uregex_setRegionAndStart(URegularExpression* regexp, long regionStart, long regionLimit, long startIndex, 
                              UErrorCode* status);

@DllImport("icu")
int uregex_regionStart(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu")
long uregex_regionStart64(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu")
int uregex_regionEnd(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu")
long uregex_regionEnd64(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu")
byte uregex_hasTransparentBounds(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu")
void uregex_useTransparentBounds(URegularExpression* regexp, byte b, UErrorCode* status);

@DllImport("icu")
byte uregex_hasAnchoringBounds(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu")
void uregex_useAnchoringBounds(URegularExpression* regexp, byte b, UErrorCode* status);

@DllImport("icu")
byte uregex_hitEnd(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu")
byte uregex_requireEnd(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu")
int uregex_replaceAll(URegularExpression* regexp, const(ushort)* replacementText, int replacementLength, 
                      ushort* destBuf, int destCapacity, UErrorCode* status);

@DllImport("icu")
UText* uregex_replaceAllUText(URegularExpression* regexp, UText* replacement, UText* dest, UErrorCode* status);

@DllImport("icu")
int uregex_replaceFirst(URegularExpression* regexp, const(ushort)* replacementText, int replacementLength, 
                        ushort* destBuf, int destCapacity, UErrorCode* status);

@DllImport("icu")
UText* uregex_replaceFirstUText(URegularExpression* regexp, UText* replacement, UText* dest, UErrorCode* status);

@DllImport("icu")
int uregex_appendReplacement(URegularExpression* regexp, const(ushort)* replacementText, int replacementLength, 
                             ushort** destBuf, int* destCapacity, UErrorCode* status);

@DllImport("icu")
void uregex_appendReplacementUText(URegularExpression* regexp, UText* replacementText, UText* dest, 
                                   UErrorCode* status);

@DllImport("icu")
int uregex_appendTail(URegularExpression* regexp, ushort** destBuf, int* destCapacity, UErrorCode* status);

@DllImport("icu")
UText* uregex_appendTailUText(URegularExpression* regexp, UText* dest, UErrorCode* status);

@DllImport("icu")
int uregex_split(URegularExpression* regexp, ushort* destBuf, int destCapacity, int* requiredCapacity, 
                 ushort** destFields, int destFieldsCapacity, UErrorCode* status);

@DllImport("icu")
int uregex_splitUText(URegularExpression* regexp, UText** destFields, int destFieldsCapacity, UErrorCode* status);

@DllImport("icu")
void uregex_setTimeLimit(URegularExpression* regexp, int limit, UErrorCode* status);

@DllImport("icu")
int uregex_getTimeLimit(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu")
void uregex_setStackLimit(URegularExpression* regexp, int limit, UErrorCode* status);

@DllImport("icu")
int uregex_getStackLimit(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icu")
void uregex_setMatchCallback(URegularExpression* regexp, URegexMatchCallback* callback, const(void)* context, 
                             UErrorCode* status);

@DllImport("icu")
void uregex_getMatchCallback(const(URegularExpression)* regexp, URegexMatchCallback** callback, 
                             const(void)** context, UErrorCode* status);

@DllImport("icu")
void uregex_setFindProgressCallback(URegularExpression* regexp, URegexFindProgressCallback* callback, 
                                    const(void)* context, UErrorCode* status);

@DllImport("icu")
void uregex_getFindProgressCallback(const(URegularExpression)* regexp, URegexFindProgressCallback** callback, 
                                    const(void)** context, UErrorCode* status);

@DllImport("icu")
URegion* uregion_getRegionFromCode(const(byte)* regionCode, UErrorCode* status);

@DllImport("icu")
URegion* uregion_getRegionFromNumericCode(int code, UErrorCode* status);

@DllImport("icu")
UEnumeration* uregion_getAvailable(URegionType type, UErrorCode* status);

@DllImport("icu")
byte uregion_areEqual(const(URegion)* uregion, const(URegion)* otherRegion);

@DllImport("icu")
URegion* uregion_getContainingRegion(const(URegion)* uregion);

@DllImport("icu")
URegion* uregion_getContainingRegionOfType(const(URegion)* uregion, URegionType type);

@DllImport("icu")
UEnumeration* uregion_getContainedRegions(const(URegion)* uregion, UErrorCode* status);

@DllImport("icu")
UEnumeration* uregion_getContainedRegionsOfType(const(URegion)* uregion, URegionType type, UErrorCode* status);

@DllImport("icu")
byte uregion_contains(const(URegion)* uregion, const(URegion)* otherRegion);

@DllImport("icu")
UEnumeration* uregion_getPreferredValues(const(URegion)* uregion, UErrorCode* status);

@DllImport("icu")
byte* uregion_getRegionCode(const(URegion)* uregion);

@DllImport("icu")
int uregion_getNumericCode(const(URegion)* uregion);

@DllImport("icu")
URegionType uregion_getType(const(URegion)* uregion);

@DllImport("icu")
URelativeDateTimeFormatter* ureldatefmt_open(const(byte)* locale, void** nfToAdopt, 
                                             UDateRelativeDateTimeFormatterStyle width, 
                                             UDisplayContext capitalizationContext, UErrorCode* status);

@DllImport("icu")
void ureldatefmt_close(URelativeDateTimeFormatter* reldatefmt);

@DllImport("icu")
int ureldatefmt_formatNumeric(const(URelativeDateTimeFormatter)* reldatefmt, double offset, 
                              URelativeDateTimeUnit unit, ushort* result, int resultCapacity, UErrorCode* status);

@DllImport("icu")
int ureldatefmt_format(const(URelativeDateTimeFormatter)* reldatefmt, double offset, URelativeDateTimeUnit unit, 
                       ushort* result, int resultCapacity, UErrorCode* status);

@DllImport("icu")
int ureldatefmt_combineDateAndTime(const(URelativeDateTimeFormatter)* reldatefmt, 
                                   const(ushort)* relativeDateString, int relativeDateStringLen, 
                                   const(ushort)* timeString, int timeStringLen, ushort* result, int resultCapacity, 
                                   UErrorCode* status);

@DllImport("icu")
UStringSearch* usearch_open(const(ushort)* pattern, int patternlength, const(ushort)* text, int textlength, 
                            const(byte)* locale, UBreakIterator* breakiter, UErrorCode* status);

@DllImport("icu")
UStringSearch* usearch_openFromCollator(const(ushort)* pattern, int patternlength, const(ushort)* text, 
                                        int textlength, const(UCollator)* collator, UBreakIterator* breakiter, 
                                        UErrorCode* status);

@DllImport("icu")
void usearch_close(UStringSearch* searchiter);

@DllImport("icu")
void usearch_setOffset(UStringSearch* strsrch, int position, UErrorCode* status);

@DllImport("icu")
int usearch_getOffset(const(UStringSearch)* strsrch);

@DllImport("icu")
void usearch_setAttribute(UStringSearch* strsrch, USearchAttribute attribute, USearchAttributeValue value, 
                          UErrorCode* status);

@DllImport("icu")
USearchAttributeValue usearch_getAttribute(const(UStringSearch)* strsrch, USearchAttribute attribute);

@DllImport("icu")
int usearch_getMatchedStart(const(UStringSearch)* strsrch);

@DllImport("icu")
int usearch_getMatchedLength(const(UStringSearch)* strsrch);

@DllImport("icu")
int usearch_getMatchedText(const(UStringSearch)* strsrch, ushort* result, int resultCapacity, UErrorCode* status);

@DllImport("icu")
void usearch_setBreakIterator(UStringSearch* strsrch, UBreakIterator* breakiter, UErrorCode* status);

@DllImport("icu")
UBreakIterator* usearch_getBreakIterator(const(UStringSearch)* strsrch);

@DllImport("icu")
void usearch_setText(UStringSearch* strsrch, const(ushort)* text, int textlength, UErrorCode* status);

@DllImport("icu")
ushort* usearch_getText(const(UStringSearch)* strsrch, int* length);

@DllImport("icu")
UCollator* usearch_getCollator(const(UStringSearch)* strsrch);

@DllImport("icu")
void usearch_setCollator(UStringSearch* strsrch, const(UCollator)* collator, UErrorCode* status);

@DllImport("icu")
void usearch_setPattern(UStringSearch* strsrch, const(ushort)* pattern, int patternlength, UErrorCode* status);

@DllImport("icu")
ushort* usearch_getPattern(const(UStringSearch)* strsrch, int* length);

@DllImport("icu")
int usearch_first(UStringSearch* strsrch, UErrorCode* status);

@DllImport("icu")
int usearch_following(UStringSearch* strsrch, int position, UErrorCode* status);

@DllImport("icu")
int usearch_last(UStringSearch* strsrch, UErrorCode* status);

@DllImport("icu")
int usearch_preceding(UStringSearch* strsrch, int position, UErrorCode* status);

@DllImport("icu")
int usearch_next(UStringSearch* strsrch, UErrorCode* status);

@DllImport("icu")
int usearch_previous(UStringSearch* strsrch, UErrorCode* status);

@DllImport("icu")
void usearch_reset(UStringSearch* strsrch);

@DllImport("icu")
USpoofChecker* uspoof_open(UErrorCode* status);

@DllImport("icu")
USpoofChecker* uspoof_openFromSerialized(const(void)* data, int length, int* pActualLength, UErrorCode* pErrorCode);

@DllImport("icu")
USpoofChecker* uspoof_openFromSource(const(byte)* confusables, int confusablesLen, 
                                     const(byte)* confusablesWholeScript, int confusablesWholeScriptLen, 
                                     int* errType, UParseError* pe, UErrorCode* status);

@DllImport("icu")
void uspoof_close(USpoofChecker* sc);

@DllImport("icu")
USpoofChecker* uspoof_clone(const(USpoofChecker)* sc, UErrorCode* status);

@DllImport("icu")
void uspoof_setChecks(USpoofChecker* sc, int checks, UErrorCode* status);

@DllImport("icu")
int uspoof_getChecks(const(USpoofChecker)* sc, UErrorCode* status);

@DllImport("icu")
void uspoof_setRestrictionLevel(USpoofChecker* sc, URestrictionLevel restrictionLevel);

@DllImport("icu")
URestrictionLevel uspoof_getRestrictionLevel(const(USpoofChecker)* sc);

@DllImport("icu")
void uspoof_setAllowedLocales(USpoofChecker* sc, const(byte)* localesList, UErrorCode* status);

@DllImport("icu")
byte* uspoof_getAllowedLocales(USpoofChecker* sc, UErrorCode* status);

@DllImport("icu")
void uspoof_setAllowedChars(USpoofChecker* sc, const(USet)* chars, UErrorCode* status);

@DllImport("icu")
USet* uspoof_getAllowedChars(const(USpoofChecker)* sc, UErrorCode* status);

@DllImport("icu")
int uspoof_check(const(USpoofChecker)* sc, const(ushort)* id, int length, int* position, UErrorCode* status);

@DllImport("icu")
int uspoof_checkUTF8(const(USpoofChecker)* sc, const(byte)* id, int length, int* position, UErrorCode* status);

@DllImport("icu")
int uspoof_check2(const(USpoofChecker)* sc, const(ushort)* id, int length, USpoofCheckResult* checkResult, 
                  UErrorCode* status);

@DllImport("icu")
int uspoof_check2UTF8(const(USpoofChecker)* sc, const(byte)* id, int length, USpoofCheckResult* checkResult, 
                      UErrorCode* status);

@DllImport("icu")
USpoofCheckResult* uspoof_openCheckResult(UErrorCode* status);

@DllImport("icu")
void uspoof_closeCheckResult(USpoofCheckResult* checkResult);

@DllImport("icu")
int uspoof_getCheckResultChecks(const(USpoofCheckResult)* checkResult, UErrorCode* status);

@DllImport("icu")
URestrictionLevel uspoof_getCheckResultRestrictionLevel(const(USpoofCheckResult)* checkResult, UErrorCode* status);

@DllImport("icu")
USet* uspoof_getCheckResultNumerics(const(USpoofCheckResult)* checkResult, UErrorCode* status);

@DllImport("icu")
int uspoof_areConfusable(const(USpoofChecker)* sc, const(ushort)* id1, int length1, const(ushort)* id2, 
                         int length2, UErrorCode* status);

@DllImport("icu")
int uspoof_areConfusableUTF8(const(USpoofChecker)* sc, const(byte)* id1, int length1, const(byte)* id2, 
                             int length2, UErrorCode* status);

@DllImport("icu")
int uspoof_getSkeleton(const(USpoofChecker)* sc, uint type, const(ushort)* id, int length, ushort* dest, 
                       int destCapacity, UErrorCode* status);

@DllImport("icu")
int uspoof_getSkeletonUTF8(const(USpoofChecker)* sc, uint type, const(byte)* id, int length, byte* dest, 
                           int destCapacity, UErrorCode* status);

@DllImport("icu")
USet* uspoof_getInclusionSet(UErrorCode* status);

@DllImport("icu")
USet* uspoof_getRecommendedSet(UErrorCode* status);

@DllImport("icu")
int uspoof_serialize(USpoofChecker* sc, void* data, int capacity, UErrorCode* status);

@DllImport("icu")
long utmscale_getTimeScaleValue(UDateTimeScale timeScale, UTimeScaleValue value, UErrorCode* status);

@DllImport("icu")
long utmscale_fromInt64(long otherTime, UDateTimeScale timeScale, UErrorCode* status);

@DllImport("icu")
long utmscale_toInt64(long universalTime, UDateTimeScale timeScale, UErrorCode* status);

@DllImport("icu")
void** utrans_openU(const(ushort)* id, int idLength, UTransDirection dir, const(ushort)* rules, int rulesLength, 
                    UParseError* parseError, UErrorCode* pErrorCode);

@DllImport("icu")
void** utrans_openInverse(const(void)** trans, UErrorCode* status);

@DllImport("icu")
void** utrans_clone(const(void)** trans, UErrorCode* status);

@DllImport("icu")
void utrans_close(void** trans);

@DllImport("icu")
ushort* utrans_getUnicodeID(const(void)** trans, int* resultLength);

@DllImport("icu")
void utrans_register(void** adoptedTrans, UErrorCode* status);

@DllImport("icu")
void utrans_unregisterID(const(ushort)* id, int idLength);

@DllImport("icu")
void utrans_setFilter(void** trans, const(ushort)* filterPattern, int filterPatternLen, UErrorCode* status);

@DllImport("icu")
int utrans_countAvailableIDs();

@DllImport("icu")
UEnumeration* utrans_openIDs(UErrorCode* pErrorCode);

@DllImport("icu")
void utrans_trans(const(void)** trans, void** rep, const(UReplaceableCallbacks)* repFunc, int start, int* limit, 
                  UErrorCode* status);

@DllImport("icu")
void utrans_transIncremental(const(void)** trans, void** rep, const(UReplaceableCallbacks)* repFunc, 
                             UTransPosition* pos, UErrorCode* status);

@DllImport("icu")
void utrans_transUChars(const(void)** trans, ushort* text, int* textLength, int textCapacity, int start, 
                        int* limit, UErrorCode* status);

@DllImport("icu")
void utrans_transIncrementalUChars(const(void)** trans, ushort* text, int* textLength, int textCapacity, 
                                   UTransPosition* pos, UErrorCode* status);

@DllImport("icu")
int utrans_toRules(const(void)** trans, byte escapeUnprintable, ushort* result, int resultLength, 
                   UErrorCode* status);

@DllImport("icu")
USet* utrans_getSourceSet(const(void)** trans, byte ignoreFilter, USet* fillIn, UErrorCode* status);

///Locates a Unicode string (wide characters) in another Unicode string for a non-linguistic comparison.
///Params:
///    dwFindStringOrdinalFlags = Flags specifying details of the find operation. These flags are mutually exclusive, with FIND_FROMSTART being the
///                               default. The application can specify just one of the find flags. <table> <tr> <th>Value</th> <th>Meaning</th>
///                               </tr> <tr> <td width="40%"><a id="FIND_FROMSTART"></a><a id="find_fromstart"></a><dl>
///                               <dt><b>FIND_FROMSTART</b></dt> </dl> </td> <td width="60%"> Search the string, starting with the first character
///                               of the string. </td> </tr> <tr> <td width="40%"><a id="FIND_FROMEND"></a><a id="find_fromend"></a><dl>
///                               <dt><b>FIND_FROMEND</b></dt> </dl> </td> <td width="60%"> Search the string in the reverse direction, starting
///                               with the last character of the string. </td> </tr> <tr> <td width="40%"><a id="FIND_STARTSWITH"></a><a
///                               id="find_startswith"></a><dl> <dt><b>FIND_STARTSWITH</b></dt> </dl> </td> <td width="60%"> Test to find out if
///                               the value specified by <i>lpStringValue</i> is the first value in the source string indicated by
///                               <i>lpStringSource</i>. </td> </tr> <tr> <td width="40%"><a id="FIND_ENDSWITH"></a><a id="find_endswith"></a><dl>
///                               <dt><b>FIND_ENDSWITH</b></dt> </dl> </td> <td width="60%"> Test to find out if the value specified by
///                               <i>lpStringValue</i> is the last value in the source string indicated by <i>lpStringSource</i>. </td> </tr>
///                               </table>
///    lpStringSource = Pointer to the source string, in which the function searches for the string specified by <i>lpStringValue</i>.
///    cchSource = Size, in characters excluding the terminating null character, of the string indicated by <i>lpStringSource</i>.
///                The application must normally specify a positive number, or 0. The application can specify -1 if the source
///                string is null-terminated and the function should calculate the size automatically.
///    lpStringValue = Pointer to the search string for which the function searches in the source string.
///    cchValue = Size, in characters excluding the terminating null character, of the string indicated by <i>lpStringValue</i>.
///               The application must normally specify a positive number, or 0. The application can specify -1 if the string is
///               null-terminated and the function should calculate the size automatically.
///    bIgnoreCase = <b>TRUE</b> if the function is to perform a case-insensitive comparison, and <b>FALSE</b> otherwise. The
///                  comparison is not a linguistic operation and is not appropriate for all locales and languages. Its behavior is
///                  similar to that for English.
///Returns:
///    Returns a 0-based index into the source string indicated by <i>lpStringSource</i> if successful. If the function
///    succeeds, the found string is the same size as the value of <i>lpStringValue</i>. A return value of 0 indicates
///    that the function found a match at the beginning of the source string. The function returns -1 if it does not
///    succeed or if it does not find the search string. To get extended error information, the application can call
///    GetLastError, which can return one of the following error codes: <ul> <li>ERROR_INVALID_FLAGS. The values
///    supplied for flags were not valid.</li> <li>ERROR_INVALID_PARAMETER. Any of the parameter values was
///    invalid.</li> <li>ERROR_SUCCESS. The action completed successfully but yielded no results.</li> </ul>
///    
@DllImport("KERNEL32")
int FindStringOrdinal(uint dwFindStringOrdinalFlags, const(PWSTR) lpStringSource, int cchSource, 
                      const(PWSTR) lpStringValue, int cchValue, BOOL bIgnoreCase);

///Retrieves a character set identifier for the font that is currently selected into a specified device context. <div
///class="alert"><b>Note</b> A call to this function is equivalent to a call to GetTextCharsetInfo passing <b>NULL</b>
///for the data buffer.</div><div> </div>
///Params:
///    hdc = Handle to a device context. The function obtains a character set identifier for the font that is selected into
///          this device context.
///Returns:
///    If successful, returns a value identifying the character set of the font that is currently selected into the
///    specified device context. The following character set identifiers are defined: If the function fails, it returns
///    DEFAULT_CHARSET.
///    
@DllImport("GDI32")
int GetTextCharset(HDC hdc);

///Retrieves information about the character set of the font that is currently selected into a specified device context.
///Params:
///    hdc = Handle to a device context. The function obtains information about the font that is selected into this device
///          context.
///    lpSig = Pointer to a FONTSIGNATURE data structure that receives font-signature information. If a TrueType font is
///            currently selected into the device context, the FONTSIGNATURE structure receives information that identifies the
///            code page and Unicode subranges for which the font provides glyphs. If a font other than TrueType is currently
///            selected into the device context, the FONTSIGNATURE structure receives zeros. In this case, the application
///            should use the TranslateCharsetInfo function to obtain generic font-signature information for the character set.
///            The <i>lpSig</i> parameter specifies <b>NULL</b> if the application does not require the FONTSIGNATURE
///            information. In this case, the application can also call the GetTextCharset function, which is equivalent to
///            calling <b>GetTextCharsetInfo</b> with <i>lpSig</i> set to <b>NULL</b>.
///    dwFlags = Reserved; must be set to 0.
///Returns:
///    If successful, returns a value identifying the character set of the font currently selected into the specified
///    device context. The following character set identifiers are defined: If the function fails, the return value is
///    DEFAULT_CHARSET.
///    
@DllImport("GDI32")
int GetTextCharsetInfo(HDC hdc, FONTSIGNATURE* lpSig, uint dwFlags);

///Translates character set information and sets all members of a destination structure to appropriate values.
///Params:
///    lpSrc = Pointer to the <b>fsCsb</b> member of a FONTSIGNATURE structure if <i>dwFlags</i> is set to TCI_SRCFONTSIG.
///            Otherwise, this parameter is set to a DWORD value indicating the source.
///    lpCs = Pointer to a CHARSETINFO structure that receives the translated character set information.
///    dwFlags = Flags specifying how to perform the translation. This parameter can be one of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TCI_SRCCHARSET"></a><a
///              id="tci_srccharset"></a><dl> <dt><b>TCI_SRCCHARSET</b></dt> </dl> </td> <td width="60%"> Source contains the
///              character set value in the low word, and 0 in the high word. </td> </tr> <tr> <td width="40%"><a
///              id="TCI_SRCCODEPAGE"></a><a id="tci_srccodepage"></a><dl> <dt><b>TCI_SRCCODEPAGE</b></dt> </dl> </td> <td
///              width="60%"> Source is a code page identifier in the low word and 0 in the high word. </td> </tr> <tr> <td
///              width="40%"><a id="TCI_SRCFONTSIG"></a><a id="tci_srcfontsig"></a><dl> <dt><b>TCI_SRCFONTSIG</b></dt> </dl> </td>
///              <td width="60%"> Source is the code page bitfield portion of a FONTSIGNATURE structure. On input this should have
///              only one Windows code-page bit set, either for an ANSI code page value or for a common ANSI and OEM value (for
///              OEM values, bits 32-63 must be clear). On output, this has only one bit set. If the TCI_SRCFONTSIG value is
///              given, the <i>lpSrc</i> parameter must be the address of the code-page bitfield. If any other TCI_ value is
///              given, the <i>lpSrc</i> parameter must be a value not an address. </td> </tr> <tr> <td width="40%"><a
///              id="TCI_SRCLOCALE"></a><a id="tci_srclocale"></a><dl> <dt><b>TCI_SRCLOCALE</b></dt> </dl> </td> <td width="60%">
///              <b>Windows 2000:</b> Source is the locale identifier (LCID) or language identifier of the keyboard layout. If it
///              is a language identifier, the value is in the low word. </td> </tr> </table>
///Returns:
///    Returns a nonzero value if successful, or 0 otherwise. To get extended error information, the application can
///    call GetLastError.
///    
@DllImport("GDI32")
BOOL TranslateCharsetInfo(uint* lpSrc, CHARSETINFO* lpCs, uint dwFlags);

///Determines if a buffer is likely to contain a form of Unicode text.
///Params:
///    lpv = Pointer to the input buffer to examine.
///    iSize = Size, in bytes, of the input buffer indicated by <i>lpv</i>.
///    lpiResult = On input, pointer to the tests to apply to the input buffer text. On output, this parameter receives the results
///                of the specified tests: 1 if the contents of the buffer pass a test, 0 for failure. Only flags that are set upon
///                input to the function are significant upon output. If <i>lpiResult</i> is <b>NULL</b>, the function uses all
///                available tests to determine if the data in the buffer is likely to be Unicode text. This parameter can be one or
///                more of the following values. Values can be combined with binary "OR". <table> <tr> <th>Value</th>
///                <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IS_TEXT_UNICODE_ASCII16"></a><a
///                id="is_text_unicode_ascii16"></a><dl> <dt><b>IS_TEXT_UNICODE_ASCII16</b></dt> </dl> </td> <td width="60%"> The
///                text is Unicode, and contains only zero-extended ASCII values/characters. </td> </tr> <tr> <td width="40%"><a
///                id="IS_TEXT_UNICODE_REVERSE_ASCII16"></a><a id="is_text_unicode_reverse_ascii16"></a><dl>
///                <dt><b>IS_TEXT_UNICODE_REVERSE_ASCII16</b></dt> </dl> </td> <td width="60%"> Same as the preceding, except that
///                the Unicode text is byte-reversed. </td> </tr> <tr> <td width="40%"><a id="IS_TEXT_UNICODE_STATISTICS"></a><a
///                id="is_text_unicode_statistics"></a><dl> <dt><b>IS_TEXT_UNICODE_STATISTICS</b></dt> </dl> </td> <td width="60%">
///                The text is probably Unicode, with the determination made by applying statistical analysis. Absolute certainty is
///                not guaranteed. See the Remarks section. </td> </tr> <tr> <td width="40%"><a
///                id="IS_TEXT_UNICODE_REVERSE_STATISTICS"></a><a id="is_text_unicode_reverse_statistics"></a><dl>
///                <dt><b>IS_TEXT_UNICODE_REVERSE_STATISTICS</b></dt> </dl> </td> <td width="60%"> Same as the preceding, except
///                that the text that is probably Unicode is byte-reversed. </td> </tr> <tr> <td width="40%"><a
///                id="IS_TEXT_UNICODE_CONTROLS"></a><a id="is_text_unicode_controls"></a><dl>
///                <dt><b>IS_TEXT_UNICODE_CONTROLS</b></dt> </dl> </td> <td width="60%"> The text contains Unicode representations
///                of one or more of these nonprinting characters: RETURN, LINEFEED, SPACE, CJK_SPACE, TAB. </td> </tr> <tr> <td
///                width="40%"><a id="IS_TEXT_UNICODE_REVERSE_CONTROLS"></a><a id="is_text_unicode_reverse_controls"></a><dl>
///                <dt><b>IS_TEXT_UNICODE_REVERSE_CONTROLS</b></dt> </dl> </td> <td width="60%"> Same as the preceding, except that
///                the Unicode characters are byte-reversed. </td> </tr> <tr> <td width="40%"><a
///                id="IS_TEXT_UNICODE_BUFFER_TOO_SMALL"></a><a id="is_text_unicode_buffer_too_small"></a><dl>
///                <dt><b>IS_TEXT_UNICODE_BUFFER_TOO_SMALL</b></dt> </dl> </td> <td width="60%"> There are too few characters in the
///                buffer for meaningful analysis (fewer than two bytes). </td> </tr> <tr> <td width="40%"><a
///                id="IS_TEXT_UNICODE_SIGNATURE"></a><a id="is_text_unicode_signature"></a><dl>
///                <dt><b>IS_TEXT_UNICODE_SIGNATURE</b></dt> </dl> </td> <td width="60%"> The text contains the Unicode byte-order
///                mark (BOM) 0xFEFF as its first character. </td> </tr> <tr> <td width="40%"><a
///                id="IS_TEXT_UNICODE_REVERSE_SIGNATURE"></a><a id="is_text_unicode_reverse_signature"></a><dl>
///                <dt><b>IS_TEXT_UNICODE_REVERSE_SIGNATURE</b></dt> </dl> </td> <td width="60%"> The text contains the Unicode
///                byte-reversed byte-order mark (Reverse BOM) 0xFFFE as its first character. </td> </tr> <tr> <td width="40%"><a
///                id="IS_TEXT_UNICODE_ILLEGAL_CHARS"></a><a id="is_text_unicode_illegal_chars"></a><dl>
///                <dt><b>IS_TEXT_UNICODE_ILLEGAL_CHARS</b></dt> </dl> </td> <td width="60%"> The text contains one of these
///                Unicode-illegal characters: embedded Reverse BOM, UNICODE_NUL, CRLF (packed into one word), or 0xFFFF. </td>
///                </tr> <tr> <td width="40%"><a id="IS_TEXT_UNICODE_ODD_LENGTH"></a><a id="is_text_unicode_odd_length"></a><dl>
///                <dt><b>IS_TEXT_UNICODE_ODD_LENGTH</b></dt> </dl> </td> <td width="60%"> The number of characters in the string is
///                odd. A string of odd length cannot (by definition) be Unicode text. </td> </tr> <tr> <td width="40%"><a
///                id="IS_TEXT_UNICODE_NULL_BYTES"></a><a id="is_text_unicode_null_bytes"></a><dl>
///                <dt><b>IS_TEXT_UNICODE_NULL_BYTES</b></dt> </dl> </td> <td width="60%"> The text contains null bytes, which
///                indicate non-ASCII text. </td> </tr> <tr> <td width="40%"><a id="IS_TEXT_UNICODE_UNICODE_MASK"></a><a
///                id="is_text_unicode_unicode_mask"></a><dl> <dt><b>IS_TEXT_UNICODE_UNICODE_MASK</b></dt> </dl> </td> <td
///                width="60%"> The value is a combination of IS_TEXT_UNICODE_ASCII16, IS_TEXT_UNICODE_STATISTICS,
///                IS_TEXT_UNICODE_CONTROLS, IS_TEXT_UNICODE_SIGNATURE. </td> </tr> <tr> <td width="40%"><a
///                id="IS_TEXT_UNICODE_REVERSE_MASK"></a><a id="is_text_unicode_reverse_mask"></a><dl>
///                <dt><b>IS_TEXT_UNICODE_REVERSE_MASK</b></dt> </dl> </td> <td width="60%"> The value is a combination of
///                IS_TEXT_UNICODE_REVERSE_ASCII16, IS_TEXT_UNICODE_REVERSE_STATISTICS, IS_TEXT_UNICODE_REVERSE_CONTROLS,
///                IS_TEXT_UNICODE_REVERSE_SIGNATURE. </td> </tr> <tr> <td width="40%"><a
///                id="IS_TEXT_UNICODE_NOT_UNICODE_MASK"></a><a id="is_text_unicode_not_unicode_mask"></a><dl>
///                <dt><b>IS_TEXT_UNICODE_NOT_UNICODE_MASK</b></dt> </dl> </td> <td width="60%"> The value is a combination of
///                IS_TEXT_UNICODE_ILLEGAL_CHARS, IS_TEXT_UNICODE_ODD_LENGTH, and two currently unused bit flags. </td> </tr> <tr>
///                <td width="40%"><a id="IS_TEXT_UNICODE_NOT_ASCII_MASK"></a><a id="is_text_unicode_not_ascii_mask"></a><dl>
///                <dt><b>IS_TEXT_UNICODE_NOT_ASCII_MASK</b></dt> </dl> </td> <td width="60%"> The value is a combination of
///                IS_TEXT_UNICODE_NULL_BYTES and three currently unused bit flags. </td> </tr> </table>
///Returns:
///    Returns a nonzero value if the data in the buffer passes the specified tests. The function returns 0 if the data
///    in the buffer does not pass the specified tests.
///    
@DllImport("ADVAPI32")
BOOL IsTextUnicode(const(void)* lpv, int iSize, int* lpiResult);


// Interfaces

@GUID("7AB36653-1796-484B-BDFA-E74F1DB7C1DC")
struct SpellCheckerFactory;

///Provides information about a spelling error.
@GUID("B7C82D61-FBE8-4B47-9B27-6C0D2E0DE0A3")
interface ISpellingError : IUnknown
{
    ///Gets the position in the checked text where the error begins. This property is read-only.
    HRESULT get_StartIndex(uint* value);
    ///Gets the length of the erroneous text. This property is read-only.
    HRESULT get_Length(uint* value);
    ///Indicates which corrective action should be taken for the spelling error. This property is read-only.
    HRESULT get_CorrectiveAction(CORRECTIVE_ACTION* value);
    ///Gets the text to use as replacement text when the corrective action is replace. This property is read-only.
    HRESULT get_Replacement(/*PARAM ATTR: FreeWithAttribute : CustomAttributeSig([FixedArgSig(ElementSig(CoTaskMemFree))], [])*/PWSTR* value);
}

///An enumeration of the spelling errors.
@GUID("803E3BD4-2828-4410-8290-418D1D73C762")
interface IEnumSpellingError : IUnknown
{
    ///Gets the next spelling error.
    ///Params:
    ///    value = The spelling error (ISpellingError) returned.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> There is no spelling error left to
    ///    return. <i>value</i> does not point at a valid ISpellingError. </td> </tr> </table>
    ///    
    HRESULT Next(ISpellingError* value);
}

///Represents the description of a spell checker option.
@GUID("432E5F85-35CF-4606-A801-6F70277E1D7A")
interface IOptionDescription : IUnknown
{
    ///Gets the identifier of the spell checker option. This property is read-only.
    HRESULT get_Id(PWSTR* value);
    ///Gets the heading for the spell checker option. This property is read-only.
    HRESULT get_Heading(PWSTR* value);
    ///Get the description of the spell checker option. This property is read-only.
    HRESULT get_Description(PWSTR* value);
    ///Gets the label enumerator for the spell checker option. This property is read-only.
    HRESULT get_Labels(IEnumString* value);
}

///Allows the caller to create a handler for notifications that the state of the speller has changed.
@GUID("0B83A5B0-792F-4EAB-9799-ACF52C5ED08A")
interface ISpellCheckerChangedEventHandler : IUnknown
{
    ///Receives the SpellCheckerChanged event.
    ///Params:
    ///    sender = The ISpellChecker that fired the event.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Invoke(ISpellChecker sender);
}

///Represents a particular spell checker for a particular language. The <b>ISpellChecker</b> can be used to check text,
///get suggestions, update user dictionaries, and maintain options.
@GUID("B6FD0B71-E2BC-4653-8D05-F197E412770B")
interface ISpellChecker : IUnknown
{
    ///Gets the BCP47 language tag this instance of the spell checker supports. This property is read-only.
    HRESULT get_LanguageTag(PWSTR* value);
    ///Checks the spelling of the supplied text and returns a collection of spelling errors.
    ///Params:
    ///    text = The text to check.
    ///    value = The result of checking this text, returned as an IEnumSpellingError object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>text</i> is an empty string.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>text</i> is
    ///    a null pointer. </td> </tr> </table>
    ///    
    HRESULT Check(const(PWSTR) text, IEnumSpellingError* value);
    ///Retrieves spelling suggestions for the supplied text.
    ///Params:
    ///    word = The word or phrase to get suggestions for.
    ///    value = The list of suggestions, returned as an IEnumString object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> <i>word</i> is correctly spelled.
    ///    <i>value</i> contains one entry, which is the text that was passed in. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>word</i> is an empty string. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>word</i> is a null pointer.
    ///    </td> </tr> </table>
    ///    
    HRESULT Suggest(const(PWSTR) word, IEnumString* value);
    ///Treats the provided word as though it were part of the original dictionary. The word will no longer be considered
    ///misspelled, and will also be considered as a candidate for suggestions.
    ///Params:
    ///    word = The word to be added to the list of added words.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>word</i> is an empty string,
    ///    or its length is greater than <b>MAX_WORD_LENGTH</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>word</i> is a null pointer. </td> </tr> </table>
    ///    
    HRESULT Add(const(PWSTR) word);
    ///Ignores the provided word for the rest of this session. Until this ISpellChecker interface is released, the word
    ///will no longer be considered misspelled, but it will not be considered as a candidate for suggestions.
    ///Params:
    ///    word = The word to ignore.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>word</i> is an empty string,
    ///    or its length is greater than <b>MAX_WORD_LENGTH</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>word</i> is a null pointer. </td> </tr> </table>
    ///    
    HRESULT Ignore(const(PWSTR) word);
    ///Causes occurrences of one word to be replaced by another.
    ///Params:
    ///    from = The incorrectly spelled word to be autocorrected.
    ///    to = The correctly spelled word that should replace <i>from</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>from</i> or <i>to</i> is an
    ///    empty string, or the length of at least one of the parameters is greater than <b>MAX_WORD_LENGTH</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>from</i> or
    ///    <i>to</i> is a null pointer. </td> </tr> </table>
    ///    
    HRESULT AutoCorrect(const(PWSTR) from, const(PWSTR) to);
    ///Retrieves the value associated with the given option.
    ///Params:
    ///    optionId = The option identifier.
    ///    value = The value associated with <i>optionId</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>optionId</i> is an empty
    ///    string, or it is not one of the available options. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>optionId</i> is a null pointer. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetOptionValue(const(PWSTR) optionId, ubyte* value);
    ///Gets all of the declared option identifiers. This property is read-only.
    HRESULT get_OptionIds(IEnumString* value);
    ///Gets the identifier for this spell checker. This property is read-only.
    HRESULT get_Id(PWSTR* value);
    ///Gets text, suitable to display to the user, that describes this spell checker. This property is read-only.
    HRESULT get_LocalizedName(PWSTR* value);
    ///Adds an event handler (ISpellCheckerChangedEventHandler) for the SpellCheckerChanged event.
    ///Params:
    ///    handler = The handler to invoke when the spell checker changes.
    ///    eventCookie = An event cookie that uniquely identifies the added handler. This cookie must be passed to
    ///                  remove_SpellCheckerChanged to stop this handler from being invoked by spell checker changes.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT add_SpellCheckerChanged(ISpellCheckerChangedEventHandler handler, uint* eventCookie);
    ///Removes an event handler (ISpellCheckerChangedEventHandler) that has been added for the SpellCheckerChanged
    ///event.
    ///Params:
    ///    eventCookie = The event cookie that uniquely identifies the added handler. This is the <i>eventCookie</i> that was obtained
    ///                  from the call to add_SpellCheckerChanged.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT remove_SpellCheckerChanged(uint eventCookie);
    ///Retrieves the information (id, description, heading and labels) of a specific option.
    ///Params:
    ///    optionId = Identifier of the option to be retrieved.
    ///    value = IOptionDescription interface that contains the information about <i>optionId</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>optionId</i> is an empty
    ///    string, or it is not one of the available options. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>optionId</i> is a null pointer. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetOptionDescription(const(PWSTR) optionId, IOptionDescription* value);
    ///Checks the spelling of the supplied text in a more thorough manner than ISpellChecker::Check, and returns a
    ///collection of spelling errors.
    ///Params:
    ///    text = The text to check.
    ///    value = The result of checking this text, returned as an IEnumSpellingError object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>text</i> is an empty string.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>text</i> is
    ///    a null pointer. </td> </tr> </table>
    ///    
    HRESULT ComprehensiveCheck(const(PWSTR) text, IEnumSpellingError* value);
}

///Represents a particular spell checker for a particular language, with the added ability to remove words from the
///added words dictionary, or from the ignore list. The <b>ISpellChecker2</b> can also be used to check text, get
///suggestions, update user dictionaries, and maintain options, as can ISpellChecker from which it is derived.
@GUID("E7ED1C71-87F7-4378-A840-C9200DACEE47")
interface ISpellChecker2 : ISpellChecker
{
    ///Removes a word that was previously added by ISpellChecker.Add, or set by ISpellChecker.Ignore to be ignored.
    ///Params:
    ///    word = The word to be removed from the list of added words, or from the list of ignored words. If the word is not
    ///           present, nothing will be removed.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>word</i> is an empty string,
    ///    or its length is greater than <b>MAX_WORD_LENGTH</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>word</i> is a null pointer. </td> </tr> </table>
    ///    
    HRESULT Remove(const(PWSTR) word);
}

///A factory for instantiating a spell checker (ISpellChecker) as well as providing functionality for determining which
///languages are supported. <b>ISpellCheckerFactory</b> is the starting point for clients of the Spell Checking API,
///which should be created as an in-proc COM Server as shown in the example below.
@GUID("8E018A9D-2415-4677-BF08-794EA61F94BB")
interface ISpellCheckerFactory : IUnknown
{
    ///Gets the set of languages/dialects supported by any of the registered spell checkers. This property is read-only.
    HRESULT get_SupportedLanguages(IEnumString* value);
    ///Determines if the specified language is supported by a registered spell checker.
    ///Params:
    ///    languageTag = A BCP47 language tag that identifies the language for the requested spell checker.
    ///    value = <b>TRUE</b> if supported; <b>FALSE</b> if not supported.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>languageTag</i> is an empty
    ///    string. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    <i>languageTag</i> is a null pointer. </td> </tr> </table>
    ///    
    HRESULT IsSupported(const(PWSTR) languageTag, BOOL* value);
    ///Creates a spell checker that supports the specified language.
    ///Params:
    ///    languageTag = A BCP47 language tag that identifies the language for the requested spell checker.
    ///    value = The created spell checker.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>languageTag</i> is an empty
    ///    string, or there is no spell checker available for <i>languageTag</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>languageTag</i> is a null pointer. </td> </tr>
    ///    </table>
    ///    
    HRESULT CreateSpellChecker(const(PWSTR) languageTag, ISpellChecker* value);
}

///Manages the registration of user dictionaries.
@GUID("AA176B85-0E12-4844-8E1A-EEF1DA77F586")
interface IUserDictionariesRegistrar : IUnknown
{
    ///Registers a file to be used as a user dictionary for the current user, until unregistered.
    ///Params:
    ///    dictionaryPath = The path of the dictionary file to be registered.
    ///    languageTag = The language for which this dictionary should be used. If left empty, it will be used for any language.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return value</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt>S_OK</dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt>S_FALSE</dt> </dl> </td> <td width="60%"> The file is already registered for the
    ///    language. </td> </tr> <tr> <td width="40%"> <dl> <dt>E_INVALIDARG</dt> </dl> </td> <td width="60%"> The file
    ///    doesn’t exist or isn't valid, or it doesn't have a valid extension (.dic, .exc, or .acl) </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt>E_POINTER</dt> </dl> </td> <td width="60%"> <i>dictionaryPath</i> or
    ///    <i>languageTag</i> is a null pointer. </td> </tr> </table>
    ///    
    HRESULT RegisterUserDictionary(const(PWSTR) dictionaryPath, const(PWSTR) languageTag);
    ///Unregisters a previously registered user dictionary. The dictionary will no longer be used by the spell checking
    ///functionality.
    ///Params:
    ///    dictionaryPath = The path of the dictionary file to be unregistered.
    ///    languageTag = The language for which this dictionary was used. It must match the language passed to RegisterUserDictionary.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return value</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt>S_OK</dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt>E_POINTER</dt> </dl> </td> <td width="60%"> <i>dictionaryPath</i> or <i>languageTag</i>
    ///    is a null pointer. </td> </tr> </table>
    ///    
    HRESULT UnregisterUserDictionary(const(PWSTR) dictionaryPath, const(PWSTR) languageTag);
}

///Represents a particular spell checker provider for a particular language, to be used by the spell checking
///infrastructure.
@GUID("73E976E0-8ED4-4EB1-80D7-1BE0A16B0C38")
interface ISpellCheckProvider : IUnknown
{
    ///Gets the BCP47 language tag this instance of the spell checker supports. This property is read-only.
    HRESULT get_LanguageTag(PWSTR* value);
    ///Checks the spelling of the supplied text and returns a collection of spelling errors.
    ///Params:
    ///    text = The text to check.
    ///    value = The result of checking this text, returned as an IEnumSpellingError object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>text</i> is an empty string.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>text</i> is
    ///    a null pointer. </td> </tr> </table>
    ///    
    HRESULT Check(const(PWSTR) text, IEnumSpellingError* value);
    ///Retrieves spelling suggestions for the supplied text.
    ///Params:
    ///    word = The word or phrase to get suggestions for.
    ///    value = The list of suggestions, returned as an IEnumString object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> <i>word</i> is correctly spelled.
    ///    <i>value</i> contains one entry, which is the text that was passed in. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>word</i> is an empty string. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>word</i> is a null pointer.
    ///    </td> </tr> </table>
    ///    
    HRESULT Suggest(const(PWSTR) word, IEnumString* value);
    ///Retrieves the value associated with the given option.
    ///Params:
    ///    optionId = The option identifier.
    ///    value = The value associated with <i>optionId</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>optionId</i> is an empty
    ///    string, or it is not one of the available options. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>optionId</i> is a null pointer. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetOptionValue(const(PWSTR) optionId, ubyte* value);
    ///Sets the value associated with the given option.
    ///Params:
    ///    optionId = The option identifier.
    ///    value = The value to associate with <i>optionId</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>optionId</i> is an empty
    ///    string, or it is not one of the available options. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>optionId</i> is a null pointer. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetOptionValue(const(PWSTR) optionId, ubyte value);
    ///Gets all of the declared option identifiers recognized by the spell checker. This property is read-only.
    HRESULT get_OptionIds(IEnumString* value);
    ///Gets the identifier for this spell checker engine. This property is read-only.
    HRESULT get_Id(PWSTR* value);
    ///Gets text, suitable to display to the user, that describes this spell checker. This property is read-only.
    HRESULT get_LocalizedName(PWSTR* value);
    ///Retrieves the information (id, description, heading and labels) of a specific option.
    ///Params:
    ///    optionId = Identifier of the option to be retrieved.
    ///    value = IOptionDescription interface that contains the information about <i>optionId</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>optionId</i> is an empty
    ///    string, or it is not one of the available options. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>optionId</i> is a null pointer. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetOptionDescription(const(PWSTR) optionId, IOptionDescription* value);
    ///Initialize the specified word list to contain only the specified words.
    ///Params:
    ///    wordlistType = The type of word list.
    ///    words = The set of words to be included in the word list, passed as an IEnumString object..
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>wordlistType</i> is not a
    ///    valid member of the WORDLIST_TYPE enumeration. </td> </tr> </table>
    ///    
    HRESULT InitializeWordlist(WORDLIST_TYPE wordlistType, IEnumString words);
}

///Allows the provider to optionally support a more comprehensive spell checking functionality.
@GUID("0C58F8DE-8E94-479E-9717-70C42C4AD2C3")
interface IComprehensiveSpellCheckProvider : IUnknown
{
    ///Spell-check the provider text in a more thorough manner than ISpellCheckProvider::Check.
    ///Params:
    ///    text = The text to check.
    ///    value = The result of checking this text, as an enumeration of spelling errors (IEnumSpellingError), if any.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return value</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt>S_OK</dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt>E_INVALIDARG</dt> </dl> </td> <td width="60%"> <i>text</i> is an empty string. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt>E_POINTER</dt> </dl> </td> <td width="60%"> <i>text</i> is a null
    ///    pointer. </td> </tr> </table>
    ///    
    HRESULT ComprehensiveCheck(const(PWSTR) text, IEnumSpellingError* value);
}

///A factory for instantiating a spell checker (ISpellCheckProvider) as well as providing functionality for determining
///which languages are supported. This is instantiated by providers and used by the Spell Checking API.
@GUID("9F671E11-77D6-4C92-AEFB-615215E3A4BE")
interface ISpellCheckProviderFactory : IUnknown
{
    ///Gets the set of languages/dialects supported by the spell checker. This property is read-only.
    HRESULT get_SupportedLanguages(IEnumString* value);
    ///Determines if the specified language is supported by this spell checker.
    ///Params:
    ///    languageTag = A BCP47 language tag that identifies the language for the requested spell checker.
    ///    value = <b>TRUE</b> if supported; <b>FALSE</b> if not supported.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>languageTag</i> is an empty
    ///    string. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    <i>languageTag</i> is a null pointer. </td> </tr> </table>
    ///    
    HRESULT IsSupported(const(PWSTR) languageTag, BOOL* value);
    ///Creates a spell checker (implemented by a spell check provider) that supports the specified language. This
    ///interface is not used directly by clients, but by the Spell Checking API.
    ///Params:
    ///    languageTag = A BCP47 language tag that identifies the language for the requested spell checker.
    ///    value = The created spell checker.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Successful. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>languageTag</i> is an empty
    ///    string, or there is no spell checker available for <i>languageTag</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>languageTag</i> is a null pointer. </td> </tr>
    ///    </table>
    ///    
    HRESULT CreateSpellCheckProvider(const(PWSTR) languageTag, ISpellCheckProvider* value);
}

interface IFEClassFactory : IClassFactory
{
}

///The <b>IFECommon</b> interface provides IME-related services that are common for different languages.
///<b>IFECommon</b> allows the developer to control very basic functions of IMEs.
interface IFECommon : IUnknown
{
    ///Determines if the IME specified by the class ID is the default IME on a local computer. The name of the IME is
    ///obtained from the Win32 keyboard layout API.
    ///Params:
    ///    szName = The name of the IME for the specified class ID. Can be <b>NULL</b>.
    ///    cszName = The size of <i>szName</i> in bytes.
    ///Returns:
    ///    <ul> <li><b>S_OK</b> if this Microsoft IME is already the default IME.</li> <li><b>S_FALSE</b> if this
    ///    Microsoft IME is not the default IME.</li> <li>Otherwise <b>E_FAIL</b>.</li> </ul>
    ///    
    HRESULT IsDefaultIME(const(byte)* szName, int cszName);
    ///Allows the Microsoft IME to become the default IME in the keyboard layout. This method only applies when
    ///Microsoft IME uses the Input Method Manager (IMM) of the operating system.
    ///Returns:
    ///    <ul> <li><b>S_OK</b> if successful.</li> <li><b>IFEC_S_ALREADY_DEFAULT</b> if this Microsoft IME is already
    ///    the default IME.</li> <li>Otherwise <b>E_FAIL</b>.</li> </ul>
    ///    
    HRESULT SetDefaultIME();
    ///Invokes the Microsoft IME Word Register Dialog Window from the app.
    ///Params:
    ///    pimedlg = Pointer to an IMEDLG structure.
    ///Returns:
    ///    <b>S_OK</b> if successful, otherwise <b>E_FAIL</b>.
    ///    
    HRESULT InvokeWordRegDialog(IMEDLG* pimedlg);
    ///Invokes the Microsoft IME's Dictionary Tool from the app.
    ///Params:
    ///    pimedlg = Pointer to an IMEDLG structure.
    ///Returns:
    ///    <b>S_OK</b> if successful, otherwise <b>E_FAIL</b>.
    ///    
    HRESULT InvokeDictToolDialog(IMEDLG* pimedlg);
}

///The <b>IFELanguage</b> interface provides language processing services using the Microsoft IME.
interface IFELanguage : IUnknown
{
    ///Initializes the IFELanguage object. This method must be called before any use of the IFELanguage object.
    ///Returns:
    ///    <b>S_OK</b> if successful, otherwise <b>E_FAIL</b>.
    ///    
    HRESULT Open();
    ///Terminates the IFELanguage object. This method must be called after your last use of the IFELanguage object.
    ///Returns:
    ///    <b>S_OK</b> if successful, otherwise <b>E_FAIL</b>.
    ///    
    HRESULT Close();
    ///Gets morphological analysis results.
    ///Params:
    ///    dwRequest = The conversion request. It can be one of the following values: <a id="FELANG_REQ_CONV"></a> <a
    ///                id="felang_req_conv"></a>
    ///    dwCMode = Specifies the conversion output characters and conversion options. This value is a combination of one or more
    ///              of the following flags: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///              id="FELANG_CMODE_MONORUBY"></a><a id="felang_cmode_monoruby"></a><dl> <dt><b>FELANG_CMODE_MONORUBY</b></dt>
    ///              </dl> </td> <td width="60%"> Mono-ruby. </td> </tr> <tr> <td width="40%"><a
    ///              id="FELANG_CMODE_NOPRUNING"></a><a id="felang_cmode_nopruning"></a><dl>
    ///              <dt><b>FELANG_CMODE_NOPRUNING</b></dt> </dl> </td> <td width="60%"> No pruning. </td> </tr> <tr> <td
    ///              width="40%"><a id="FELANG_CMODE_KATAKANAOUT"></a><a id="felang_cmode_katakanaout"></a><dl>
    ///              <dt><b>FELANG_CMODE_KATAKANAOUT</b></dt> </dl> </td> <td width="60%"> Katakana output. </td> </tr> <tr> <td
    ///              width="40%"><a id="FELANG_CMODE_HIRAGANAOUT"></a><a id="felang_cmode_hiraganaout"></a><dl>
    ///              <dt><b>FELANG_CMODE_HIRAGANAOUT</b></dt> </dl> </td> <td width="60%"> Default output. </td> </tr> <tr> <td
    ///              width="40%"><a id="FELANG_CMODE_HALFWIDTHOUT"></a><a id="felang_cmode_halfwidthout"></a><dl>
    ///              <dt><b>FELANG_CMODE_HALFWIDTHOUT</b></dt> </dl> </td> <td width="60%"> Half-width output. </td> </tr> <tr>
    ///              <td width="40%"><a id="FELANG_CMODE_FULLWIDTHOUT"></a><a id="felang_cmode_fullwidthout"></a><dl>
    ///              <dt><b>FELANG_CMODE_FULLWIDTHOUT</b></dt> </dl> </td> <td width="60%"> Full-width output. </td> </tr> <tr>
    ///              <td width="40%"><a id="FELANG_CMODE_BOPOMOFO"></a><a id="felang_cmode_bopomofo"></a><dl>
    ///              <dt><b>FELANG_CMODE_BOPOMOFO</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"><a
    ///              id="FELANG_CMODE_HANGUL"></a><a id="felang_cmode_hangul"></a><dl> <dt><b>FELANG_CMODE_HANGUL</b></dt> </dl>
    ///              </td> <td width="60%"></td> </tr> <tr> <td width="40%"><a id="FELANG_CMODE_PINYIN"></a><a
    ///              id="felang_cmode_pinyin"></a><dl> <dt><b>FELANG_CMODE_PINYIN</b></dt> </dl> </td> <td width="60%"></td> </tr>
    ///              <tr> <td width="40%"><a id="FELANG_CMODE_PRECONV"></a><a id="felang_cmode_preconv"></a><dl>
    ///              <dt><b>FELANG_CMODE_PRECONV</b></dt> </dl> </td> <td width="60%"> Do conversion as follows: <ul> <li>Roma-ji
    ///              to kana.</li> <li>Autocorrect before conversion.</li> <li>Periods, comma, and brackets.</li> </ul> </td>
    ///              </tr> <tr> <td width="40%"><a id="FELANG_CMODE_RADICAL"></a><a id="felang_cmode_radical"></a><dl>
    ///              <dt><b>FELANG_CMODE_RADICAL</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"><a
    ///              id="FELANG_CMODE_UNKNOWNREADING"></a><a id="felang_cmode_unknownreading"></a><dl>
    ///              <dt><b>FELANG_CMODE_UNKNOWNREADING</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"><a
    ///              id="FELANG_CMODE_MERGECAND"></a><a id="felang_cmode_mergecand"></a><dl>
    ///              <dt><b>FELANG_CMODE_MERGECAND</b></dt> </dl> </td> <td width="60%"> Merge display with the same candidate.
    ///              </td> </tr> <tr> <td width="40%"><a id="FELANG_CMODE_ROMAN"></a><a id="felang_cmode_roman"></a><dl>
    ///              <dt><b>FELANG_CMODE_ROMAN</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"><a
    ///              id="FELANG_CMODE_BESTFIRST"></a><a id="felang_cmode_bestfirst"></a><dl>
    ///              <dt><b>FELANG_CMODE_BESTFIRST</b></dt> </dl> </td> <td width="60%"> Make only the first best. </td> </tr>
    ///              <tr> <td width="40%"><a id="FELANG_CMODE_USENOREVWORDS"></a><a id="felang_cmode_usenorevwords"></a><dl>
    ///              <dt><b>FELANG_CMODE_USENOREVWORDS</b></dt> </dl> </td> <td width="60%"> Use invalid revword on REV/RECONV.
    ///              </td> </tr> <tr> <td width="40%"><a id="FELANG_CMODE_NONE"></a><a id="felang_cmode_none"></a><dl>
    ///              <dt><b>FELANG_CMODE_NONE</b></dt> </dl> </td> <td width="60%"> IME_SMODE_NONE </td> </tr> <tr> <td
    ///              width="40%"><a id="FELANG_CMODE_PLAURALCLAUSE"></a><a id="felang_cmode_plauralclause"></a><dl>
    ///              <dt><b>FELANG_CMODE_PLAURALCLAUSE</b></dt> </dl> </td> <td width="60%"> IME_SMODE_PLAURALCLAUSE </td> </tr>
    ///              <tr> <td width="40%"><a id="FELANG_CMODE_SINGLECONVERT"></a><a id="felang_cmode_singleconvert"></a><dl>
    ///              <dt><b>FELANG_CMODE_SINGLECONVERT</b></dt> </dl> </td> <td width="60%"> IME_SMODE_SINGLECONVERT </td> </tr>
    ///              <tr> <td width="40%"><a id="FELANG_CMODE_AUTOMATIC"></a><a id="felang_cmode_automatic"></a><dl>
    ///              <dt><b>FELANG_CMODE_AUTOMATIC</b></dt> </dl> </td> <td width="60%"> IME_SMODE_AUTOMATIC </td> </tr> <tr> <td
    ///              width="40%"><a id="FELANG_CMODE_PHRASEPREDICT"></a><a id="felang_cmode_phrasepredict"></a><dl>
    ///              <dt><b>FELANG_CMODE_PHRASEPREDICT</b></dt> </dl> </td> <td width="60%"> IME_SMODE_PHRASEPREDICT </td> </tr>
    ///              <tr> <td width="40%"><a id="FELANG_CMODE_CONVERSATION"></a><a id="felang_cmode_conversation"></a><dl>
    ///              <dt><b>FELANG_CMODE_CONVERSATION</b></dt> </dl> </td> <td width="60%"> IME_SMODE_CONVERSATION </td> </tr>
    ///              <tr> <td width="40%"><a id="FELANG_CMODE_NAME"></a><a id="felang_cmode_name"></a><dl>
    ///              <dt><b>FELANG_CMODE_NAME</b></dt> </dl> </td> <td width="60%"> Name mode (MSKKIME). </td> </tr> <tr> <td
    ///              width="40%"><a id="FELANG_CMODE_NOINVISIBLECHAR"></a><a id="felang_cmode_noinvisiblechar"></a><dl>
    ///              <dt><b>FELANG_CMODE_NOINVISIBLECHAR</b></dt> </dl> </td> <td width="60%"> Remove invisible chars (for
    ///              example, the tone mark). </td> </tr> </table>
    ///    cwchInput = The number of characters in <i>pwchInput</i>.
    ///    pwchInput = Input characters to be converted by the morphology engine. This must be a UNICODE string. Set this parameter
    ///                to <b>NULL</b> to get the next entry for the previously input string, with the next rank. The order in which
    ///                next entries are returned is defined by the implementation.
    ///    pfCInfo = The information for each column, where each <i>pfCInfo[x]</i> corresponds to <i>pwchInput[x]</i>. Each
    ///              <b>DWORD</b> can be a combination of the flags below: <a id="FELANG_CLMN_WBREAK"></a> <a
    ///              id="felang_clmn_wbreak"></a>
    ///    ppResult = The address of a MORRSLT structure that receives the morphology result data. <b>GetJMorphResult</b> allocates
    ///               memory using the OLE task allocator for the returned data, and sets the <i>pResult</i> to point to the
    ///               memory. The application must free the memory pointed to by <i>pResult</i>, by using the CoTaskMemFree.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> More candidates exist. If you call
    ///    this function again with <i>pwchInput</i> equal to <b>NULL</b>, it will get the next best candidate for the
    ///    previous <i>pwchInput</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> No result. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOCAND</b></dt> </dl> </td> <td
    ///    width="60%"> No more candidates. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_LARGEINPUT</b></dt> </dl>
    ///    </td> <td width="60%"> input too large. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ERROR_SEM_TIMEOUT</b></dt> </dl> </td> <td width="60%"> Mutex timeout is occurred. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetJMorphResult(uint dwRequest, uint dwCMode, int cwchInput, const(PWSTR) pwchInput, uint* pfCInfo, 
                            MORRSLT** ppResult);
    ///Gets the conversion mode capability of the IFELanguage object.
    ///Params:
    ///    pdwCaps = The capabilities, represented as a combination of one or more of the following flags: <table> <tr>
    ///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="FELANG_CMODE_MONORUBY"></a><a
    ///              id="felang_cmode_monoruby"></a><dl> <dt><b>FELANG_CMODE_MONORUBY</b></dt> </dl> </td> <td width="60%">
    ///              Mono-ruby. </td> </tr> <tr> <td width="40%"><a id="FELANG_CMODE_NOPRUNING"></a><a
    ///              id="felang_cmode_nopruning"></a><dl> <dt><b>FELANG_CMODE_NOPRUNING</b></dt> </dl> </td> <td width="60%"> No
    ///              pruning. </td> </tr> <tr> <td width="40%"><a id="FELANG_CMODE_KATAKANAOUT"></a><a
    ///              id="felang_cmode_katakanaout"></a><dl> <dt><b>FELANG_CMODE_KATAKANAOUT</b></dt> </dl> </td> <td width="60%">
    ///              Katakana output. </td> </tr> <tr> <td width="40%"><a id="FELANG_CMODE_HIRAGANAOUT"></a><a
    ///              id="felang_cmode_hiraganaout"></a><dl> <dt><b>FELANG_CMODE_HIRAGANAOUT</b></dt> </dl> </td> <td width="60%">
    ///              Default output. </td> </tr> <tr> <td width="40%"><a id="FELANG_CMODE_HALFWIDTHOUT"></a><a
    ///              id="felang_cmode_halfwidthout"></a><dl> <dt><b>FELANG_CMODE_HALFWIDTHOUT</b></dt> </dl> </td> <td
    ///              width="60%"> Half-width output. </td> </tr> <tr> <td width="40%"><a id="FELANG_CMODE_FULLWIDTHOUT"></a><a
    ///              id="felang_cmode_fullwidthout"></a><dl> <dt><b>FELANG_CMODE_FULLWIDTHOUT</b></dt> </dl> </td> <td
    ///              width="60%"> Full-width output. </td> </tr> <tr> <td width="40%"><a id="FELANG_CMODE_BOPOMOFO"></a><a
    ///              id="felang_cmode_bopomofo"></a><dl> <dt><b>FELANG_CMODE_BOPOMOFO</b></dt> </dl> </td> <td width="60%"></td>
    ///              </tr> <tr> <td width="40%"><a id="FELANG_CMODE_HANGUL"></a><a id="felang_cmode_hangul"></a><dl>
    ///              <dt><b>FELANG_CMODE_HANGUL</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"><a
    ///              id="FELANG_CMODE_PINYIN"></a><a id="felang_cmode_pinyin"></a><dl> <dt><b>FELANG_CMODE_PINYIN</b></dt> </dl>
    ///              </td> <td width="60%"></td> </tr> <tr> <td width="40%"><a id="FELANG_CMODE_PRECONV"></a><a
    ///              id="felang_cmode_preconv"></a><dl> <dt><b>FELANG_CMODE_PRECONV</b></dt> </dl> </td> <td width="60%"> Do
    ///              conversion as follows: <ul> <li>Roma-ji to kana.</li> <li>Autocorrect before conversion.</li> <li>Periods,
    ///              comma, and brackets.</li> </ul> </td> </tr> <tr> <td width="40%"><a id="FELANG_CMODE_RADICAL"></a><a
    ///              id="felang_cmode_radical"></a><dl> <dt><b>FELANG_CMODE_RADICAL</b></dt> </dl> </td> <td width="60%"></td>
    ///              </tr> <tr> <td width="40%"><a id="FELANG_CMODE_UNKNOWNREADING"></a><a
    ///              id="felang_cmode_unknownreading"></a><dl> <dt><b>FELANG_CMODE_UNKNOWNREADING</b></dt> </dl> </td> <td
    ///              width="60%"></td> </tr> <tr> <td width="40%"><a id="FELANG_CMODE_MERGECAND"></a><a
    ///              id="felang_cmode_mergecand"></a><dl> <dt><b>FELANG_CMODE_MERGECAND</b></dt> </dl> </td> <td width="60%">
    ///              Merge display with the same candidate. </td> </tr> <tr> <td width="40%"><a id="FELANG_CMODE_ROMAN"></a><a
    ///              id="felang_cmode_roman"></a><dl> <dt><b>FELANG_CMODE_ROMAN</b></dt> </dl> </td> <td width="60%"></td> </tr>
    ///              <tr> <td width="40%"><a id="FELANG_CMODE_BESTFIRST"></a><a id="felang_cmode_bestfirst"></a><dl>
    ///              <dt><b>FELANG_CMODE_BESTFIRST</b></dt> </dl> </td> <td width="60%"> Make only the first best. </td> </tr>
    ///              <tr> <td width="40%"><a id="FELANG_CMODE_USENOREVWORDS"></a><a id="felang_cmode_usenorevwords"></a><dl>
    ///              <dt><b>FELANG_CMODE_USENOREVWORDS</b></dt> </dl> </td> <td width="60%"> Use invalid revword on REV/RECONV.
    ///              </td> </tr> <tr> <td width="40%"><a id="FELANG_CMODE_NONE"></a><a id="felang_cmode_none"></a><dl>
    ///              <dt><b>FELANG_CMODE_NONE</b></dt> </dl> </td> <td width="60%"> IME_SMODE_NONE </td> </tr> <tr> <td
    ///              width="40%"><a id="FELANG_CMODE_PLAURALCLAUSE"></a><a id="felang_cmode_plauralclause"></a><dl>
    ///              <dt><b>FELANG_CMODE_PLAURALCLAUSE</b></dt> </dl> </td> <td width="60%"> IME_SMODE_PLAURALCLAUSE </td> </tr>
    ///              <tr> <td width="40%"><a id="FELANG_CMODE_SINGLECONVERT"></a><a id="felang_cmode_singleconvert"></a><dl>
    ///              <dt><b>FELANG_CMODE_SINGLECONVERT</b></dt> </dl> </td> <td width="60%"> IME_SMODE_SINGLECONVERT </td> </tr>
    ///              <tr> <td width="40%"><a id="FELANG_CMODE_AUTOMATIC"></a><a id="felang_cmode_automatic"></a><dl>
    ///              <dt><b>FELANG_CMODE_AUTOMATIC</b></dt> </dl> </td> <td width="60%"> IME_SMODE_AUTOMATIC </td> </tr> <tr> <td
    ///              width="40%"><a id="FELANG_CMODE_PHRASEPREDICT"></a><a id="felang_cmode_phrasepredict"></a><dl>
    ///              <dt><b>FELANG_CMODE_PHRASEPREDICT</b></dt> </dl> </td> <td width="60%"> IME_SMODE_PHRASEPREDICT </td> </tr>
    ///              <tr> <td width="40%"><a id="FELANG_CMODE_CONVERSATION"></a><a id="felang_cmode_conversation"></a><dl>
    ///              <dt><b>FELANG_CMODE_CONVERSATION</b></dt> </dl> </td> <td width="60%"> IME_SMODE_CONVERSATION </td> </tr>
    ///              <tr> <td width="40%"><a id="FELANG_CMODE_NAME"></a><a id="felang_cmode_name"></a><dl>
    ///              <dt><b>FELANG_CMODE_NAME</b></dt> </dl> </td> <td width="60%"> Name mode (MSKKIME). </td> </tr> <tr> <td
    ///              width="40%"><a id="FELANG_CMODE_NOINVISIBLECHAR"></a><a id="felang_cmode_noinvisiblechar"></a><dl>
    ///              <dt><b>FELANG_CMODE_NOINVISIBLECHAR</b></dt> </dl> </td> <td width="60%"> Remove invisible chars (for
    ///              example, the tone mark). </td> </tr> </table>
    ///Returns:
    ///    <b>S_OK</b> if successful, otherwise <b>E_FAIL</b>.
    ///    
    HRESULT GetConversionModeCaps(uint* pdwCaps);
    HRESULT GetPhonetic(BSTR string, int start, int length, BSTR* phonetic);
    ///Converts the input string (which usually contains the Hiragana character) to converted strings.
    ///Params:
    ///    string = A string of phonetic characters to convert.
    ///    start = The starting character from which IFELanguage begins conversion. The first character of <i>string</i> is
    ///            represented by 1 (not 0).
    ///    length = The number of characters to convert. If this value is -1, all of the remaining characters from <i>start</i>
    ///             are converted.
    ///    result = The converted string. This string is allocated by SysAllocStringLen and must be freed by the client.
    ///Returns:
    ///    <b>S_OK</b> if successful, otherwise <b>E_FAIL</b>.
    ///    
    HRESULT GetConversion(BSTR string, int start, int length, BSTR* result);
}

///The <b>IFEDictionary</b> interface allows clients to access a Microsoft IME user dictionary. This API enables your
///apps to access and use the data contained in the Microsoft IME dictionaries (including personal name and geographical
///name dictionaries), or user dictionary. You can develop and sell such applications, provided that:<ul> <li>You do not
///create an application that accesses a dictionary that is not a Microsoft IME dictionary through this API.</li>
///<li>You do not dump, copy, or distribute the dictionary data contained in the Microsoft IME.</li> </ul>You must use
///this API only for the purpose of developing applications for users who already have the Microsoft IME.
interface IFEDictionary : IUnknown
{
    ///Opens a dictionary file. This method opens an existing dictionary file and associates it with this IFEDictionary
    ///object. To implement a multiple dictionary facility, multiple open and release procedures must be carried out.
    ///Params:
    ///    pchDictPath = Points to a <b>NULL</b>-terminated file name string to be opened. If <i>pchDictPath</i> is <b>NULL</b> or an
    ///                  empty string, the user dictionary opened by the IME kernel will be used. If <i>pchDictPath</i> is an empty
    ///                  string, the name of user dictionary will be copied into <i>pchDictPath</i>, in which case the size of
    ///                  <i>pchDictPath</i> must be <b>MAX_PATH</b>.
    ///    pshf = The IMESHF header of the opened file. Can be <b>NULL</b>.
    ///Returns:
    ///    One of the following: <ul> <li><b>S_OK</b></li> <li><b>JDIC_S_EMPTY_DICTIONARY</b></li>
    ///    <li><b>IFED_E_NOT_FOUND</b></li> <li><b>IFED_E_INVALID_FORMAT</b></li> <li><b>IFED_E_OPEN_FAILED</b></li>
    ///    <li><b>E_FAIL</b></li> </ul>
    ///    
    HRESULT Open(byte* pchDictPath, IMESHF* pshf);
    ///Closes a dictionary file. This method closes the file associated to this IFEDictionary object.
    ///Returns:
    ///    <b>S_OK</b> if successful, otherwise <b>E_FAIL</b>.
    ///    
    HRESULT Close();
    ///Gets a dictionary header from a dictionary file without opening the dictionary.
    ///Params:
    ///    pchDictPath = A <b>NULL</b>-terminated string containing the path and name of the dictionary file.
    ///    pshf = The IMESHF header of the file. Can be <b>NULL</b>.
    ///    pjfmt = The dictionary format. This can be one of the following values: <a id="IFED_UNKNOWN"></a> <a
    ///            id="ifed_unknown"></a>
    ///    pulType = The dictionary type. This is a combination of one or more of the following flags: <table> <tr> <th>Value</th>
    ///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IFED_TYPE_NONE"></a><a id="ifed_type_none"></a><dl>
    ///              <dt><b>IFED_TYPE_NONE</b></dt> </dl> </td> <td width="60%"> Undefined. </td> </tr> <tr> <td width="40%"><a
    ///              id="IFED_TYPE_GENERAL"></a><a id="ifed_type_general"></a><dl> <dt><b>IFED_TYPE_GENERAL</b></dt> </dl> </td>
    ///              <td width="60%"> General dictionary. </td> </tr> <tr> <td width="40%"><a id="IFED_TYPE_NAMEPLACE"></a><a
    ///              id="ifed_type_nameplace"></a><dl> <dt><b>IFED_TYPE_NAMEPLACE</b></dt> </dl> </td> <td width="60%"> Name/place
    ///              dictionary. </td> </tr> <tr> <td width="40%"><a id="IFED_TYPE_SPEECH"></a><a id="ifed_type_speech"></a><dl>
    ///              <dt><b>IFED_TYPE_SPEECH</b></dt> </dl> </td> <td width="60%"> Speech dictionary. </td> </tr> <tr> <td
    ///              width="40%"><a id="IFED_TYPE_REVERSE"></a><a id="ifed_type_reverse"></a><dl>
    ///              <dt><b>IFED_TYPE_REVERSE</b></dt> </dl> </td> <td width="60%"> Reverse dictionary. </td> </tr> <tr> <td
    ///              width="40%"><a id="IFED_TYPE_ENGLISH"></a><a id="ifed_type_english"></a><dl>
    ///              <dt><b>IFED_TYPE_ENGLISH</b></dt> </dl> </td> <td width="60%"> English dictionary. </td> </tr> <tr> <td
    ///              width="40%"><a id="IFED_TYPE_ALL"></a><a id="ifed_type_all"></a><dl> <dt><b>IFED_TYPE_ALL</b></dt> </dl>
    ///              </td> <td width="60%"> All of the above types. </td> </tr> </table>
    ///Returns:
    ///    One of the following: <ul> <li><b>S_OK</b></li> <li><b>IFED_E_INVALID_FORMAT</b></li> <li><b>E_FAIL</b></li>
    ///    </ul>
    ///    
    HRESULT GetHeader(byte* pchDictPath, IMESHF* pshf, IMEFMT* pjfmt, uint* pulType);
    ///This method is obsolete starting with Windows 8, and is no longer supported.
    ///Params:
    ///    hwnd = The parent window handle.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DisplayProperty(HWND hwnd);
    ///Obtains the public POS (Part of Speech) table.
    ///Params:
    ///    prgPosTbl = Pointer to the array of POSTBL structures.
    ///    pcPosTbl = Pointer to the number of POSTBL structures in the returned array. Can be <b>NULL</b>.
    ///Returns:
    ///    <b>S_OK</b> if successful, otherwise <b>E_FAIL</b>.
    ///    
    HRESULT GetPosTable(POSTBL** prgPosTbl, int* pcPosTbl);
    ///Gets word entries from a dictionary. The selection of a word entry can be performed by a combination of<ul> <li>A
    ///string with Japanese phonetic characters, with or without a wildcard at the end of the string.</li> <li>A word,
    ///with or without a wildcard at its end.</li> <li>A Part of Speech</li> </ul>In addition, retrievals by a string
    ///with Japanese phonetic characters can be performed by specifying a range in the Hiragana 50-on ordering.
    ///Params:
    ///    pwchFirst = A text string against which IFEDictionary entries are matched; the value must be one of the following:
    ///                <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="NULL"></a><a
    ///                id="null"></a><dl> <dt><b>NULL</b></dt> </dl> </td> <td width="60%"> Low-value. </td> </tr> <tr> <td
    ///                width="40%"></td> <td width="60%"> Hiragana string (full text to be retrieved). </td> </tr> <tr> <td
    ///                width="40%"></td> <td width="60%"> Hiragana string ending in "*" (specifying only leading characters of
    ///                text). This can be an initial text string when a range of words is to be retrieved, in which case a wildcard
    ///                must not be used. </td> </tr> </table>
    ///    pwchLast = A text string that is used to end a text string. This must contain the same value as <b>pwchReading</b> in
    ///               the IMEWRD structure when a retrieval is performed by a single value; that is, not by a range value. The
    ///               value must be one of the following: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///               width="40%"><a id="NULL"></a><a id="null"></a><dl> <dt><b>NULL</b></dt> </dl> </td> <td width="60%">
    ///               High-value. </td> </tr> <tr> <td width="40%"></td> <td width="60%"> Hiragana string (full text to be
    ///               retrieved). </td> </tr> <tr> <td width="40%"></td> <td width="60%"> Hiragana string ending in "*" (specifying
    ///               only leading characters of text). </td> </tr> </table>
    ///    pwchDisplay = A display string against which IFEDictionary entries are matched; the value must be one of the following:
    ///                  <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="NULL"></a><a
    ///                  id="null"></a><dl> <dt><b>NULL</b></dt> </dl> </td> <td width="60%"> Means "*". </td> </tr> <tr> <td
    ///                  width="40%"></td> <td width="60%"> Any Japanese string. </td> </tr> <tr> <td width="40%"></td> <td
    ///                  width="60%"> Japanese string ending in "*". </td> </tr> </table>
    ///    ulPos = Filter(s) on the Microsoft IME public Parts of Speech. This is a combination of one or more of the following
    ///            flags: <a id="IFED_POS_NONE"></a> <a id="ifed_pos_none"></a>
    ///    ulSelect = Specifies the query output of a word. This is a combination of one or more of the following flags: <a
    ///               id="IFED_SELECT_NONE"></a> <a id="ifed_select_none"></a>
    ///    ulWordSrc = Specifies the word source. When the IFEDictionary is a user dictionary, this is a combination of one or more
    ///                of the following flags: <a id="IFED_REG_NONE"></a> <a id="ifed_reg_none"></a>
    ///    pchBuffer = Buffer provided by the caller to receive the data.
    ///    cbBuffer = The size of <i>pchBuffer</i>.
    ///    pcWrd = The number of IMEWRD structures returned in <i>pchBuffer</i>. If more entries are found than <i>pchBuffer</i>
    ///            can store, <b>IFED_S_MORE_ENTRIES</b> will be returned.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IFED_S_MORE_ENTRIES</b></dt> </dl> </td> <td width="60%"> The client must call NextWords to get
    ///    additional IMEWRD structures. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IFED_E_NO_ENTRY</b></dt> </dl>
    ///    </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"></td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"></td>
    ///    </tr> </table>
    ///    
    HRESULT GetWords(const(PWSTR) pwchFirst, const(PWSTR) pwchLast, const(PWSTR) pwchDisplay, uint ulPos, 
                     uint ulSelect, uint ulWordSrc, ubyte* pchBuffer, uint cbBuffer, uint* pcWrd);
    ///Gets the next word entry from a dictionary. This method is used only after GetWords to get additional words.
    ///Params:
    ///    pchBuffer = Buffer provided by the caller to receive the data.
    ///    cbBuffer = The size of <i>pchBuffer</i>.
    ///    pcWrd = The number of IMEWRD structures returned in <i>pchBuffer</i>. If more entries are found than <i>pchBuffer</i>
    ///            can store, <b>IFED_S_MORE_ENTRIES</b> will be returned.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IFED_S_MORE_ENTRIES</b></dt> </dl> </td> <td width="60%"> The client must call NextWords to get
    ///    additional IMEWRD structures. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"></td> </tr> </table>
    ///    
    HRESULT NextWords(ubyte* pchBuffer, uint cbBuffer, uint* pcWrd);
    ///Creates a new dictionary file.
    ///Params:
    ///    pchDictPath = A <b>NULL</b>-terminated string containing the path and name for the new dictionary file to be created.
    ///    pshf = The IMESHF header for the new dictionary.
    ///Returns:
    ///    One of the following: <ul> <li><b>S_OK</b></li> <li><b>IFED_S_EMPTY_DICTIONARY</b></li>
    ///    <li><b>E_OUTOFMEMORY</b></li> <li><b>E_FAIL</b></li> </ul>
    ///    
    HRESULT Create(const(byte)* pchDictPath, IMESHF* pshf);
    ///Sets a dictionary header in a dictionary file. This method sets or modifies the dictionary header of this
    ///IFEDictionary object.
    ///Params:
    ///    pshf = The IMESHF header to set.
    ///Returns:
    ///    <b>S_OK</b> if successful, otherwise <b>E_FAIL</b>.
    ///    
    HRESULT SetHeader(IMESHF* pshf);
    ///Determines if the specified word exists in IFEDictionary.
    ///Params:
    ///    pwrd = An IMEWRD structure specifying the word to check.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The word exists. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The word does not exist. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unexpected error. </td>
    ///    </tr> </table>
    ///    
    HRESULT ExistWord(IMEWRD* pwrd);
    HRESULT ExistDependency(IMEDP* pdp);
    ///Registers a new word or deletes an existing word in the IFEDictionary.
    ///Params:
    ///    reg = Type of operation to perform. This can be one of the following values: <table> <tr> <th>Value</th>
    ///          <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IFED_REG_HEAD"></a><a id="ifed_reg_head"></a><dl>
    ///          <dt><b>IFED_REG_HEAD</b></dt> </dl> </td> <td width="60%"> Register the word at the head of the dictionary.
    ///          </td> </tr> <tr> <td width="40%"><a id="IFED_REG_TAIL"></a><a id="ifed_reg_tail"></a><dl>
    ///          <dt><b>IFED_REG_TAIL</b></dt> </dl> </td> <td width="60%"> Register the word at the tail of the dictionary.
    ///          </td> </tr> <tr> <td width="40%"><a id="IFED_REG_DEL"></a><a id="ifed_reg_del"></a><dl>
    ///          <dt><b>IFED_REG_DEL</b></dt> </dl> </td> <td width="60%"> Delete the word from the dictionary. </td> </tr>
    ///          </table>
    ///    pwrd = An IMEWRD structure specifying the word to register or delete.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method was successful. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>IFED_E_NOT_USER_DIC</b></dt> </dl> </td> <td width="60%"> This
    ///    IFEDictionary object is not a user dictionary. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IFED_S_WORD_EXISTS</b></dt> </dl> </td> <td width="60%"> The word is already registered. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>IFED_E_USER_COMMENT</b></dt> </dl> </td> <td width="60%"> Failed to insert
    ///    the user comment. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%">
    ///    Failed to register or delete the word. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> An unexpected error. </td> </tr> </table>
    ///    
    HRESULT RegisterWord(IMEREG reg, IMEWRD* pwrd);
    HRESULT RegisterDependency(IMEREG reg, IMEDP* pdp);
    HRESULT GetDependencies(const(PWSTR) pwchKakariReading, const(PWSTR) pwchKakariDisplay, uint ulKakariPos, 
                            const(PWSTR) pwchUkeReading, const(PWSTR) pwchUkeDisplay, uint ulUkePos, IMEREL jrel, 
                            uint ulWordSrc, ubyte* pchBuffer, uint cbBuffer, uint* pcdp);
    HRESULT NextDependencies(ubyte* pchBuffer, uint cbBuffer, uint* pcDp);
    HRESULT ConvertFromOldMSIME(const(byte)* pchDic, PFNLOG pfnLog, IMEREG reg);
    HRESULT ConvertFromUserToSys();
}

///The <b>IImeSpecifyApplets</b> interface specifies methods called from the IImePad interface object to emulate the
///IImePadApplet interface.
interface IImeSpecifyApplets : IUnknown
{
    ///Called from the IImePad interface to enumerate the IImePadApplet interfaces that are implemented.
    ///Params:
    ///    refiid = IID of the IImePadApplet interface. This IID is defined in Imepad.h as <b>IID_IImePadApplet</b>. This is for
    ///             <b>IImePadApplet</b>'s future enhancement
    ///    lpIIDList = Pointer to a APPLETIIDLIST structure. Sets the applet's IID list and count.
    ///Returns:
    ///    <b>S_OK</b> if successful, otherwise <b>E_FAIL</b>.
    ///    
    HRESULT GetAppletIIDList(const(GUID)* refiid, APPLETIDLIST* lpIIDList);
}

///The <b>IImePadApplet</b> interface inputs strings into apps through the IImePad interface. <b>IImePadApplet</b>
///should be implemented as a DLL inproc server. The developer can implement multiple <b>IImePadApplet</b> interfaces in
///one DLL. To specify and emulate the <b>IImePadApplet</b> interface in the applet DLL, the applet must also provide
///the IImeSpecifyApplets interface.
interface IImePadApplet : IUnknown
{
    ///Called from IImePad interface to initialize IImePadApplet.
    ///Params:
    ///    lpIImePad = Pointer to IImePad (<b>IUnknown</b> *)
    ///Returns:
    ///    <b>S_OK</b> if successful, otherwise <b>E_FAIL</b>.
    ///    
    HRESULT Initialize(IUnknown lpIImePad);
    ///Called from IImePad to terminate IImePadApplet when the IMEPad instance exits.
    ///Returns:
    ///    <b>S_OK</b> if successful, otherwise <b>E_FAIL</b>.
    ///    
    HRESULT Terminate();
    HRESULT GetAppletConfig(IMEAPPLETCFG* lpAppletCfg);
    ///Called from IImePad to get the applet's window handle, style, and size. The applet can set its window style and
    ///sizing policy.
    ///Params:
    ///    hwndParent = Window handle of the IImePad GUI. The applet can create the window as its child window.
    ///    lpImeAppletUI = Pointer to IMEAPPLETUI structure. The applet can set its window style.
    ///Returns:
    ///    <b>S_OK</b> if successful, otherwise <b>E_FAIL</b>.
    ///    
    HRESULT CreateUI(HWND hwndParent, IMEAPPLETUI* lpImeAppletUI);
    ///Called from IImePad to pass information with a notify code
    ///Params:
    ///    lpImePad = Pointer of IUnknown interface. To get the IImePad interface pointer, use QueryInterface.
    ///    notify = The IImePadApplet notify code. See Remarks for the possible codes.
    ///    wParam = Additional information specific to <i>notify</i>.
    ///    lParam = Additional information specific to <i>notify</i>.
    ///Returns:
    ///    <b>S_OK</b> if successful, otherwise <b>E_FAIL</b>.
    ///    
    HRESULT Notify(IUnknown lpImePad, int notify, WPARAM wParam, LPARAM lParam);
}

///The <b>IImePad</b> interface inserts text into apps from IMEPadApplets that implement the IImePadApplet interface.
///IMEPadApplets can insert their own strings into the current active app by calling <b>IImePad</b> and the Microsoft
///IME.
interface IImePad : IUnknown
{
    ///Called by an IImePadApplet to insert text into an app. <b>Request</b> is the only method that IImePadApplet can
    ///call. By calling this method with one of the <b>IMEPADREQ_*</b> request IDs, <b>IImePadApplet</b> can insert text
    ///into an app and can control IME's composition string in an app.
    ///Params:
    ///    pIImePadApplet = The interface pointer of the calling applet.
    ///    reqId = The type of request (the request ID). This must be set to one of the following values: <table> <tr>
    ///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IMEPADREQ_INSERTSTRING"></a><a
    ///            id="imepadreq_insertstring"></a><dl> <dt><b>IMEPADREQ_INSERTSTRING</b></dt> </dl> </td> <td width="60%">
    ///            Insert a string into the app as a composition string. <ul> <li><i>wParam</i>: Pointer to the
    ///            <b>NULL</b>-terminated string (<b>LPWSTR</b>) to be inserted into the app.</li> <li><i>lParam</i>: Not used.
    ///            Must be set to 0.</li> </ul> </td> </tr> <tr> <td width="40%"><a id="IMEPADREQ_SENDCONTROL"></a><a
    ///            id="imepadreq_sendcontrol"></a><dl> <dt><b>IMEPADREQ_SENDCONTROL</b></dt> </dl> </td> <td width="60%">
    ///            Controls composition of the string and caret in the app. <ul> <li><i>wParam</i>: Specifies the control value
    ///            (<b>IMEPADCTRL_*</b>) that requests IME to process the composition string and caret position. See Remarks for
    ///            a list of the <b>IMEPADCTRL_*</b> values.</li> <li><i>lParam</i>: Not used. Must be set to 0.</li> </ul>
    ///            </td> </tr> <tr> <td width="40%"><a id="IMEPADREQ_SETAPPLETSIZE"></a><a id="imepadreq_setappletsize"></a><dl>
    ///            <dt><b>IMEPADREQ_SETAPPLETSIZE</b></dt> </dl> </td> <td width="60%"> Set a new applet window size. <ul>
    ///            <li><i>wParam</i>: LOWORD(<i>wParam</i>) specifies the applet's width. HIWORD(<i>wParam</i>) specifies
    ///            applet's height</li> <li><i>lParam</i>: Not used. Must be set to 0.</li> </ul> </td> </tr> <tr> <td
    ///            width="40%"><a id="IMEPADREQ_GETCOMPOSITIONSTRING"></a><a id="imepadreq_getcompositionstring"></a><dl>
    ///            <dt><b>IMEPADREQ_GETCOMPOSITIONSTRING</b></dt> </dl> </td> <td width="60%"> Gets the current composition
    ///            string text. <ul> <li><i>wParam</i>: Points to the buffer (<b>LPWSTR</b>) that is to receive the current
    ///            composition string text.</li> <li><i>lParam</i>: The maximum number of characters to copy, including the
    ///            terminating null character.</li> </ul> </td> </tr> <tr> <td width="40%"><a
    ///            id="IMEPADREQ_GETCOMPOSITIONSTRINGINFO"></a><a id="imepadreq_getcompositionstringinfo"></a><dl>
    ///            <dt><b>IMEPADREQ_GETCOMPOSITIONSTRINGINFO</b></dt> </dl> </td> <td width="60%"> Gets information about the
    ///            current composition string. <ul> <li><i>wParam</i>: Pointer to a IMECOMPOSITIONSTRINGINFO structure that
    ///            receives the composition information.</li> <li><i>lParam</i>: Not used. Must be set to 0.</li> </ul> </td>
    ///            </tr> <tr> <td width="40%"><a id="IMEPADREQ_DELETESTRING"></a><a id="imepadreq_deletestring"></a><dl>
    ///            <dt><b>IMEPADREQ_DELETESTRING</b></dt> </dl> </td> <td width="60%"> Delete the composition string. <ul>
    ///            <li><i>wParam</i>: LOWORD(<i>wParam</i>) specifies the start position of the composition string to be
    ///            deleted. HIWORD(<i>wParam</i>) specifies the length of the composition string to delete. </li>
    ///            <li><i>lParam</i>: Not used. Must be set to 0.</li> </ul> </td> </tr> <tr> <td width="40%"><a
    ///            id="IMEPADREQ_CHANGESTRING"></a><a id="imepadreq_changestring"></a><dl>
    ///            <dt><b>IMEPADREQ_CHANGESTRING</b></dt> </dl> </td> <td width="60%"> Replace part of the composition string.
    ///            <ul> <li><i>wParam</i>: Pointer to the replacement string (<b>LPWSTR</b>).</li> <li><i>lParam</i>:
    ///            LOWORD(<i>lParam</i>) specifies the start position of the composition string to be replaced.
    ///            HIWORD(<i>lParam</i>) specifies the length of the composition string to be replaced.</li> </ul> </td> </tr>
    ///            <tr> <td width="40%"><a id="IMEPADREQ_GETAPPLHWND"></a><a id="imepadreq_getapplhwnd"></a><dl>
    ///            <dt><b>IMEPADREQ_GETAPPLHWND</b></dt> </dl> </td> <td width="60%"> Gets the application window handle. <ul>
    ///            <li><i>wParam</i>: The <b>HWND</b> handle address (<b>HWND</b> *) to receive the application window
    ///            handle.</li> <li><i>lParam</i>: Not used. Must be set to 0.</li> </ul> </td> </tr> <tr> <td width="40%"><a
    ///            id="IMEPADREQ_FORCEIMEPADWINDOWSHOW"></a><a id="imepadreq_forceimepadwindowshow"></a><dl>
    ///            <dt><b>IMEPADREQ_FORCEIMEPADWINDOWSHOW</b></dt> </dl> </td> <td width="60%"> Keeps the ImePad window visible.
    ///            <ul> <li><i>wParam</i>: <b>TRUE</b> to keep the IMEPad window visible.</li> <li><i>lParam</i>: Not used. Must
    ///            be set to 0.</li> </ul> </td> </tr> <tr> <td width="40%"><a id="IMEPADREQ_POSTMODALNOTIFY"></a><a
    ///            id="imepadreq_postmodalnotify"></a><dl> <dt><b>IMEPADREQ_POSTMODALNOTIFY</b></dt> </dl> </td> <td
    ///            width="60%"> Causes IImePad to call the applet's Notify method asynchronously with a specific notification Id
    ///            and user-defined data. <ul> <li><i>wParam</i>: The notify code (<b>IMEPN_*</b>). See the Remarks for
    ///            IImePadApplet::Notify for the possible <b>IMEPN_*</b> codes.</li> <li><i>lParam</i>: User-defined data</li>
    ///            </ul> </td> </tr> <tr> <td width="40%"><a id="IMEPADREQ_GETDEFAULTUILANGID"></a><a
    ///            id="imepadreq_getdefaultuilangid"></a><dl> <dt><b>IMEPADREQ_GETDEFAULTUILANGID</b></dt> </dl> </td> <td
    ///            width="60%"> Gets the recommended (default) ImePad applet UI Language. <ul> <li><i>wParam</i>: Address of
    ///            Language ID (<b>LANGID</b> *) to receive the default UI Language.</li> <li><i>lParam</i>: Not used. Must be
    ///            set to 0.</li> </ul> </td> </tr> <tr> <td width="40%"><a id="IMEPADREQ_GETCURRENTUILANG"></a><a
    ///            id="imepadreq_getcurrentuilang"></a><dl> <dt><b>IMEPADREQ_GETCURRENTUILANG</b></dt> </dl> </td> <td
    ///            width="60%"> Get the current ImePad applet UI Language. <ul> <li><i>wParam</i>: Address of Language ID
    ///            (<b>LANGID</b> *) to receive the current UI Language.</li> <li><i>lParam</i>: Not used. Must be set to
    ///            0.</li> </ul> </td> </tr> <tr> <td width="40%"><a id="IMEPADREQ_GETAPPLETUISTYLE"></a><a
    ///            id="imepadreq_getappletuistyle"></a><dl> <dt><b>IMEPADREQ_GETAPPLETUISTYLE</b></dt> </dl> </td> <td
    ///            width="60%"> Gets the applet's UI style (<b>IPAWS_*</b> flags). <ul> <li><i>wParam</i>: Address to receive
    ///            the applet UI style (<b>DWORD</b> *). The style is a combination of <b>IPAWS_*</b> flags; see Remarks for the
    ///            possible <b>IPAWS_*</b> flags.</li> <li><i>lParam</i>: Not used. Must be set to 0.</li> </ul> </td> </tr>
    ///            <tr> <td width="40%"><a id="IMEPADREQ_SETAPPLETUISTYLE"></a><a id="imepadreq_setappletuistyle"></a><dl>
    ///            <dt><b>IMEPADREQ_SETAPPLETUISTYLE</b></dt> </dl> </td> <td width="60%"> Sets the applet's UI style
    ///            (<b>IPAWS_*</b> flags). <ul> <li><i>wParam</i>: Applet UI style. The style is a combination of <b>IPAWS_*</b>
    ///            flags; see Remarks for the possible <b>IPAWS_*</b> flags.</li> <li><i>lParam</i>: Not used. Must be set to
    ///            0.</li> </ul> </td> </tr> <tr> <td width="40%"><a id="IMEPADREQ_ISAPPLETACTIVE"></a><a
    ///            id="imepadreq_isappletactive"></a><dl> <dt><b>IMEPADREQ_ISAPPLETACTIVE</b></dt> </dl> </td> <td width="60%">
    ///            Determines if the applet is active. <ul> <li><i>wParam</i>: Address to receive the value (<b>BOOL</b> *). If
    ///            it's <b>TRUE</b>, the applet is active; otherwise the applet is not active.</li> <li><i>lParam</i>: Not used.
    ///            Must be set to 0.</li> </ul> </td> </tr> <tr> <td width="40%"><a id="IMEPADREQ_ISIMEPADWINDOWVISIBLE"></a><a
    ///            id="imepadreq_isimepadwindowvisible"></a><dl> <dt><b>IMEPADREQ_ISIMEPADWINDOWVISIBLE</b></dt> </dl> </td> <td
    ///            width="60%"> Determines if ImePad is visible. <ul> <li><i>wParam</i>: Address to receive the value
    ///            (<b>BOOL</b> *). If it's <b>TRUE</b>, ImePad is visible; otherwise ImePad is not visible.</li>
    ///            <li><i>lParam</i>: Not used. Must be set to 0.</li> </ul> </td> </tr> <tr> <td width="40%"><a
    ///            id="IMEPADREQ_SETAPPLETMINMAXSIZE"></a><a id="imepadreq_setappletminmaxsize"></a><dl>
    ///            <dt><b>IMEPADREQ_SETAPPLETMINMAXSIZE</b></dt> </dl> </td> <td width="60%"> Set the minimum and maximum applet
    ///            size. <ul> <li><i>wParam</i>: LOWORD(<i>wParam</i>) specifies the applet width. HIWORD(<i>wParam</i>)
    ///            specifies the applet height.</li> <li><i>lParam</i>: <b>TRUE</b> sets the maximum size; <b>FALSE</b> to sets
    ///            the minimum size.</li> </ul> </td> </tr> <tr> <td width="40%"><a id="IMEPADREQ_GETCONVERSIONSTATUS"></a><a
    ///            id="imepadreq_getconversionstatus"></a><dl> <dt><b>IMEPADREQ_GETCONVERSIONSTATUS</b></dt> </dl> </td> <td
    ///            width="60%"> Gets the current application IME's conversion status. For a complete list of conversion and
    ///            sentence modes, see the header file Imm.h. <ul> <li><i>wParam</i>: Address to receive the conversion mode
    ///            (<b>DWORD</b> *).</li> <li><i>lParam</i>: Address to receive the sentence mode (<b>DWORD</b> *).</li> </ul>
    ///            </td> </tr> <tr> <td width="40%"><a id="IMEPADREQ_GETVERSION"></a><a id="imepadreq_getversion"></a><dl>
    ///            <dt><b>IMEPADREQ_GETVERSION</b></dt> </dl> </td> <td width="60%"> Gets IImePad's version information. <ul>
    ///            <li><i>wParam</i>: Address to receive Major version (<b>DWORD</b> *).</li> <li><i>lParam</i>: Address to
    ///            receive Minor version (<b>DWORD</b> *).</li> </ul> </td> </tr> <tr> <td width="40%"><a
    ///            id="IMEPADREQ_GETCURRENTIMEINFO"></a><a id="imepadreq_getcurrentimeinfo"></a><dl>
    ///            <dt><b>IMEPADREQ_GETCURRENTIMEINFO</b></dt> </dl> </td> <td width="60%"> Gets the IME information that
    ///            invoked ImePad. <ul> <li><i>wParam</i>: Address to receive the IME's language ID (<b>DWORD</b> *).</li>
    ///            <li><i>lParam</i>: Address to receive the IME's input ID (<b>DWORD</b> *).</li> </ul> </td> </tr> </table>
    ///    wParam = Additional information specific to <i>reqId</i>.
    ///    lParam = Additional information specific to <i>reqId</i>.
    ///Returns:
    ///    <b>S_OK</b> if successful, otherwise <b>E_FAIL</b>.
    ///    
    HRESULT Request(IImePadApplet pIImePadApplet, int reqId, WPARAM wParam, LPARAM lParam);
}

///Provides access to the list of IME plug-in dictionaries.
@GUID("98752974-B0A6-489B-8F6F-BFF3769C8EEB")
interface IImePlugInDictDictionaryList : IUnknown
{
    ///Obtains the list of Dictionay IDs (<b>GUID</b>) of the IME plug-in dictionaries which are in use by IME, with
    ///their creation dates and encryption flags.
    ///Params:
    ///    prgDictionaryGUID = Array of the dictionary IDs (<b>GUID</b>) of the IME plug-in dictionaries which are in use by IME.
    ///    prgDateCreated = Array of the dates of creation for each of the IME plug-in dictionaries returned by <i>prgDictionaryGUID</i>.
    ///    prgfEncrypted = Array of flags indicating whether each dictionary is encrypted or not for each of the IME plug-in
    ///                    dictionaries returned by <i>prgDictionaryGUID</i>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Succeeded. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Out of memory. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Other errors. </td> </tr> </table>
    ///    
    HRESULT GetDictionariesInUse(SAFEARRAY** prgDictionaryGUID, SAFEARRAY** prgDateCreated, 
                                 SAFEARRAY** prgfEncrypted);
    ///Deletes a dictionary from the IME's plug-in dictionary list.
    ///Params:
    ///    bstrDictionaryGUID = The dictionary ID (<b>GUID</b>) of the dictionary to be removed from the list.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The specified dictionary existed in
    ///    the list and was successfully removed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl>
    ///    </td> <td width="60%"> The specified dictionary does not exist in the list. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Other errors. </td> </tr> </table>
    ///    
    HRESULT DeleteDictionary(BSTR bstrDictionaryGUID);
}


// GUIDs

const GUID CLSID_SpellCheckerFactory = GUIDOF!SpellCheckerFactory;

const GUID IID_IComprehensiveSpellCheckProvider = GUIDOF!IComprehensiveSpellCheckProvider;
const GUID IID_IEnumSpellingError               = GUIDOF!IEnumSpellingError;
const GUID IID_IImePlugInDictDictionaryList     = GUIDOF!IImePlugInDictDictionaryList;
const GUID IID_IOptionDescription               = GUIDOF!IOptionDescription;
const GUID IID_ISpellCheckProvider              = GUIDOF!ISpellCheckProvider;
const GUID IID_ISpellCheckProviderFactory       = GUIDOF!ISpellCheckProviderFactory;
const GUID IID_ISpellChecker                    = GUIDOF!ISpellChecker;
const GUID IID_ISpellChecker2                   = GUIDOF!ISpellChecker2;
const GUID IID_ISpellCheckerChangedEventHandler = GUIDOF!ISpellCheckerChangedEventHandler;
const GUID IID_ISpellCheckerFactory             = GUIDOF!ISpellCheckerFactory;
const GUID IID_ISpellingError                   = GUIDOF!ISpellingError;
const GUID IID_IUserDictionariesRegistrar       = GUIDOF!IUserDictionariesRegistrar;
