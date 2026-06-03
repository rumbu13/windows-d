// Written in the D programming language.

module windows.win32.globalization;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, CHAR, HRESULT, HWND, LPARAM,
                                         PSTR, PWSTR, RECT, SIZE, SYSTEMTIME;
public import windows.win32.graphics.gdi : ABC, AXESLISTA, AXESLISTW, ETO_OPTIONS,
                                           HDC, HFONT, NEWTEXTMETRICA, NEWTEXTMETRICW;
public import windows.win32.system.com : IEnumString, IStream, IUnknown;

extern(Windows) @nogc nothrow:


// Enums


alias FOLD_STRING_MAP_FLAGS = uint;
enum : uint
{
    MAP_COMPOSITE        = 0x00000040U,
    MAP_EXPAND_LIGATURES = 0x00002000U,
    MAP_FOLDCZONE        = 0x00000010U,
    MAP_FOLDDIGITS       = 0x00000080U,
    MAP_PRECOMPOSED      = 0x00000020U,
}

alias ENUM_DATE_FORMATS_FLAGS = uint;
enum : uint
{
    DATE_SHORTDATE        = 0x00000001U,
    DATE_LONGDATE         = 0x00000002U,
    DATE_YEARMONTH        = 0x00000008U,
    DATE_MONTHDAY         = 0x00000080U,
    DATE_AUTOLAYOUT       = 0x00000040U,
    DATE_LTRREADING       = 0x00000010U,
    DATE_RTLREADING       = 0x00000020U,
    DATE_USE_ALT_CALENDAR = 0x00000004U,
}

alias TRANSLATE_CHARSET_INFO_FLAGS = uint;
enum : uint
{
    TCI_SRCCHARSET  = 0x00000001U,
    TCI_SRCCODEPAGE = 0x00000002U,
    TCI_SRCFONTSIG  = 0x00000003U,
    TCI_SRCLOCALE   = 0x00001000U,
}

alias TIME_FORMAT_FLAGS = uint;
enum : uint
{
    TIME_NOMINUTESORSECONDS = 0x00000001U,
    TIME_NOSECONDS          = 0x00000002U,
    TIME_NOTIMEMARKER       = 0x00000004U,
    TIME_FORCE24HOURFORMAT  = 0x00000008U,
}

alias ENUM_SYSTEM_LANGUAGE_GROUPS_FLAGS = uint;
enum : uint
{
    LGRPID_INSTALLED = 0x00000001U,
    LGRPID_SUPPORTED = 0x00000002U,
}

alias MULTI_BYTE_TO_WIDE_CHAR_FLAGS = uint;
enum : uint
{
    MB_COMPOSITE         = 0x00000002U,
    MB_ERR_INVALID_CHARS = 0x00000008U,
    MB_PRECOMPOSED       = 0x00000001U,
    MB_USEGLYPHCHARS     = 0x00000004U,
}

alias COMPARE_STRING_FLAGS = uint;
enum : uint
{
    LINGUISTIC_IGNORECASE      = 0x00000010U,
    LINGUISTIC_IGNOREDIACRITIC = 0x00000020U,
    NORM_IGNORECASE            = 0x00000001U,
    NORM_IGNOREKANATYPE        = 0x00010000U,
    NORM_IGNORENONSPACE        = 0x00000002U,
    NORM_IGNORESYMBOLS         = 0x00000004U,
    NORM_IGNOREWIDTH           = 0x00020000U,
    NORM_LINGUISTIC_CASING     = 0x08000000U,
    SORT_DIGITSASNUMBERS       = 0x00000008U,
    SORT_STRINGSORT            = 0x00001000U,
}

alias IS_VALID_LOCALE_FLAGS = uint;
enum : uint
{
    LCID_INSTALLED = 0x00000001U,
    LCID_SUPPORTED = 0x00000002U,
}

alias ENUM_SYSTEM_CODE_PAGES_FLAGS = uint;
enum : uint
{
    CP_INSTALLED = 0x00000001U,
    CP_SUPPORTED = 0x00000002U,
}

alias SCRIPT_IS_COMPLEX_FLAGS = uint;
enum : uint
{
    SIC_ASCIIDIGIT = 0x00000002U,
    SIC_COMPLEX    = 0x00000001U,
    SIC_NEUTRAL    = 0x00000004U,
}

alias IS_TEXT_UNICODE_RESULT = uint;
enum : uint
{
    IS_TEXT_UNICODE_ASCII16            = 0x00000001U,
    IS_TEXT_UNICODE_REVERSE_ASCII16    = 0x00000010U,
    IS_TEXT_UNICODE_STATISTICS         = 0x00000002U,
    IS_TEXT_UNICODE_REVERSE_STATISTICS = 0x00000020U,
    IS_TEXT_UNICODE_CONTROLS           = 0x00000004U,
    IS_TEXT_UNICODE_REVERSE_CONTROLS   = 0x00000040U,
    IS_TEXT_UNICODE_SIGNATURE          = 0x00000008U,
    IS_TEXT_UNICODE_REVERSE_SIGNATURE  = 0x00000080U,
    IS_TEXT_UNICODE_ILLEGAL_CHARS      = 0x00000100U,
    IS_TEXT_UNICODE_ODD_LENGTH         = 0x00000200U,
    IS_TEXT_UNICODE_NULL_BYTES         = 0x00001000U,
    IS_TEXT_UNICODE_UNICODE_MASK       = 0x0000000fU,
    IS_TEXT_UNICODE_REVERSE_MASK       = 0x000000f0U,
    IS_TEXT_UNICODE_NOT_UNICODE_MASK   = 0x00000f00U,
    IS_TEXT_UNICODE_NOT_ASCII_MASK     = 0x0000f000U,
}

alias COMPARESTRING_RESULT = int;
enum : int
{
    CSTR_LESS_THAN    = 0x00000001,
    CSTR_EQUAL        = 0x00000002,
    CSTR_GREATER_THAN = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnls/ne-winnls-sysnls_function
alias SYSNLS_FUNCTION = int;
enum : int
{
    COMPARE_STRING = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnls/ne-winnls-sysgeotype
alias SYSGEOTYPE = int;
enum : int
{
    GEO_NATION            = 0x00000001,
    GEO_LATITUDE          = 0x00000002,
    GEO_LONGITUDE         = 0x00000003,
    GEO_ISO2              = 0x00000004,
    GEO_ISO3              = 0x00000005,
    GEO_RFC1766           = 0x00000006,
    GEO_LCID              = 0x00000007,
    GEO_FRIENDLYNAME      = 0x00000008,
    GEO_OFFICIALNAME      = 0x00000009,
    GEO_TIMEZONES         = 0x0000000a,
    GEO_OFFICIALLANGUAGES = 0x0000000b,
    GEO_ISO_UN_NUMBER     = 0x0000000c,
    GEO_PARENT            = 0x0000000d,
    GEO_DIALINGCODE       = 0x0000000e,
    GEO_CURRENCYCODE      = 0x0000000f,
    GEO_CURRENCYSYMBOL    = 0x00000010,
    GEO_NAME              = 0x00000011,
    GEO_ID                = 0x00000012,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnls/ne-winnls-sysgeoclass
alias SYSGEOCLASS = int;
enum : int
{
    GEOCLASS_NATION = 0x00000010,
    GEOCLASS_REGION = 0x0000000e,
    GEOCLASS_ALL    = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnls/ne-winnls-norm_form
alias NORM_FORM = int;
enum : int
{
    NormalizationOther = 0x00000000,
    NormalizationC     = 0x00000001,
    NormalizationD     = 0x00000002,
    NormalizationKC    = 0x00000005,
    NormalizationKD    = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/ne-spellcheck-wordlist_type
alias WORDLIST_TYPE = int;
enum : int
{
    WORDLIST_TYPE_IGNORE      = 0x00000000,
    WORDLIST_TYPE_ADD         = 0x00000001,
    WORDLIST_TYPE_EXCLUDE     = 0x00000002,
    WORDLIST_TYPE_AUTOCORRECT = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/ne-spellcheck-corrective_action
alias CORRECTIVE_ACTION = int;
enum : int
{
    CORRECTIVE_ACTION_NONE            = 0x00000000,
    CORRECTIVE_ACTION_GET_SUGGESTIONS = 0x00000001,
    CORRECTIVE_ACTION_REPLACE         = 0x00000002,
    CORRECTIVE_ACTION_DELETE          = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/usp10/ne-usp10-script_justify
alias SCRIPT_JUSTIFY = int;
enum : int
{
    SCRIPT_JUSTIFY_NONE           = 0x00000000,
    SCRIPT_JUSTIFY_ARABIC_BLANK   = 0x00000001,
    SCRIPT_JUSTIFY_CHARACTER      = 0x00000002,
    SCRIPT_JUSTIFY_RESERVED1      = 0x00000003,
    SCRIPT_JUSTIFY_BLANK          = 0x00000004,
    SCRIPT_JUSTIFY_RESERVED2      = 0x00000005,
    SCRIPT_JUSTIFY_RESERVED3      = 0x00000006,
    SCRIPT_JUSTIFY_ARABIC_NORMAL  = 0x00000007,
    SCRIPT_JUSTIFY_ARABIC_KASHIDA = 0x00000008,
    SCRIPT_JUSTIFY_ARABIC_ALEF    = 0x00000009,
    SCRIPT_JUSTIFY_ARABIC_HA      = 0x0000000a,
    SCRIPT_JUSTIFY_ARABIC_RA      = 0x0000000b,
    SCRIPT_JUSTIFY_ARABIC_BA      = 0x0000000c,
    SCRIPT_JUSTIFY_ARABIC_BARA    = 0x0000000d,
    SCRIPT_JUSTIFY_ARABIC_SEEN    = 0x0000000e,
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
    U_INPUT_TOO_LONG_ERROR             = 0x0000001f,
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
    UTRACE_UDATA_START                 = 0x00003000,
    UTRACE_UDATA_RESOURCE              = 0x00003000,
    UTRACE_UDATA_BUNDLE                = 0x00003001,
    UTRACE_UDATA_DATA_FILE             = 0x00003002,
    UTRACE_UDATA_RES_FILE              = 0x00003003,
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
    USCRIPT_CHORASMIAN                   = 0x000000bd,
    USCRIPT_DIVES_AKURU                  = 0x000000be,
    USCRIPT_KHITAN_SMALL_SCRIPT          = 0x000000bf,
    USCRIPT_YEZIDI                       = 0x000000c0,
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

enum ULocAvailableType : int
{
    ULOC_AVAILABLE_DEFAULT             = 0x00000000,
    ULOC_AVAILABLE_ONLY_LEGACY_ALIASES = 0x00000001,
    ULOC_AVAILABLE_WITH_LEGACY_ALIASES = 0x00000002,
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
    UCURR_SYMBOL_NAME         = 0x00000000,
    UCURR_LONG_NAME           = 0x00000001,
    UCURR_NARROW_SYMBOL_NAME  = 0x00000002,
    UCURR_VARIANT_SYMBOL_NAME = 0x00000003,
}

enum UCurrCurrencyType : int
{
    UCURR_ALL            = 0x7fffffff,
    UCURR_COMMON         = 0x00000001,
    UCURR_UNCOMMON       = 0x00000002,
    UCURR_DEPRECATED     = 0x00000004,
    UCURR_NON_DEPRECATED = 0x00000008,
}

enum UCPMapRangeOption : int
{
    UCPMAP_RANGE_NORMAL                = 0x00000000,
    UCPMAP_RANGE_FIXED_LEAD_SURROGATES = 0x00000001,
    UCPMAP_RANGE_FIXED_ALL_SURROGATES  = 0x00000002,
}

enum UCPTrieType : int
{
    UCPTRIE_TYPE_ANY   = 0xffffffff,
    UCPTRIE_TYPE_FAST  = 0x00000000,
    UCPTRIE_TYPE_SMALL = 0x00000001,
}

enum UCPTrieValueWidth : int
{
    UCPTRIE_VALUE_BITS_ANY = 0xffffffff,
    UCPTRIE_VALUE_BITS_16  = 0x00000000,
    UCPTRIE_VALUE_BITS_32  = 0x00000001,
    UCPTRIE_VALUE_BITS_8   = 0x00000002,
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
    UBLOCK_CHORASMIAN                                     = 0x0000012d,
    UBLOCK_CJK_UNIFIED_IDEOGRAPHS_EXTENSION_G             = 0x0000012e,
    UBLOCK_DIVES_AKURU                                    = 0x0000012f,
    UBLOCK_KHITAN_SMALL_SCRIPT                            = 0x00000130,
    UBLOCK_LISU_SUPPLEMENT                                = 0x00000131,
    UBLOCK_SYMBOLS_FOR_LEGACY_COMPUTING                   = 0x00000132,
    UBLOCK_TANGUT_SUPPLEMENT                              = 0x00000133,
    UBLOCK_YEZIDI                                         = 0x00000134,
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
    U_JG_THIN_YEH                 = 0x00000066,
    U_JG_VERTICAL_TAIL            = 0x00000067,
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
    U_INPC_TOP_AND_BOTTOM_AND_LEFT  = 0x0000000f,
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

enum UTimeZoneLocalOption : int
{
    UCAL_TZ_LOCAL_FORMER          = 0x00000004,
    UCAL_TZ_LOCAL_LATTER          = 0x0000000c,
    UCAL_TZ_LOCAL_STANDARD_FORMER = 0x00000005,
    UCAL_TZ_LOCAL_STANDARD_LATTER = 0x0000000d,
    UCAL_TZ_LOCAL_DAYLIGHT_FORMER = 0x00000007,
    UCAL_TZ_LOCAL_DAYLIGHT_LATTER = 0x0000000f,
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

enum UFieldCategory : int
{
    UFIELD_CATEGORY_UNDEFINED          = 0x00000000,
    UFIELD_CATEGORY_DATE               = 0x00000001,
    UFIELD_CATEGORY_NUMBER             = 0x00000002,
    UFIELD_CATEGORY_LIST               = 0x00000003,
    UFIELD_CATEGORY_RELATIVE_DATETIME  = 0x00000004,
    UFIELD_CATEGORY_DATE_INTERVAL      = 0x00000005,
    UFIELD_CATEGORY_LIST_SPAN          = 0x00001003,
    UFIELD_CATEGORY_DATE_INTERVAL_SPAN = 0x00001005,
    UFIELD_CATEGORY_NUMBER_RANGE_SPAN  = 0x00001002,
}

enum UGender : int
{
    UGENDER_MALE   = 0x00000000,
    UGENDER_FEMALE = 0x00000001,
    UGENDER_OTHER  = 0x00000002,
}

enum UListFormatterField : int
{
    ULISTFMT_LITERAL_FIELD = 0x00000000,
    ULISTFMT_ELEMENT_FIELD = 0x00000001,
}

enum UListFormatterType : int
{
    ULISTFMT_TYPE_AND   = 0x00000000,
    ULISTFMT_TYPE_OR    = 0x00000001,
    ULISTFMT_TYPE_UNITS = 0x00000002,
}

enum UListFormatterWidth : int
{
    ULISTFMT_WIDTH_WIDE   = 0x00000000,
    ULISTFMT_WIDTH_SHORT  = 0x00000001,
    ULISTFMT_WIDTH_NARROW = 0x00000002,
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
    UNUM_ROUND_CEILING      = 0x00000000,
    UNUM_ROUND_FLOOR        = 0x00000001,
    UNUM_ROUND_DOWN         = 0x00000002,
    UNUM_ROUND_UP           = 0x00000003,
    UNUM_ROUND_HALFEVEN     = 0x00000004,
    UNUM_ROUND_HALFDOWN     = 0x00000005,
    UNUM_ROUND_HALFUP       = 0x00000006,
    UNUM_ROUND_UNNECESSARY  = 0x00000007,
    UNUM_ROUND_HALF_ODD     = 0x00000008,
    UNUM_ROUND_HALF_CEILING = 0x00000009,
    UNUM_ROUND_HALF_FLOOR   = 0x0000000a,
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
    UNUM_MEASURE_UNIT_FIELD       = 0x0000000b,
    UNUM_COMPACT_FIELD            = 0x0000000c,
}

enum UNumberFormatMinimumGroupingDigits : int
{
    UNUM_MINIMUM_GROUPING_DIGITS_AUTO = 0xfffffffe,
    UNUM_MINIMUM_GROUPING_DIGITS_MIN2 = 0xfffffffd,
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
    UNUM_MINIMUM_GROUPING_DIGITS             = 0x00000016,
    UNUM_CURRENCY_USAGE                      = 0x00000017,
    UNUM_FORMAT_FAIL_IF_MORE_THAN_MAX_DIGITS = 0x00001000,
    UNUM_PARSE_NO_EXPONENT                   = 0x00001001,
    UNUM_PARSE_DECIMAL_MARK_REQUIRED         = 0x00001002,
    UNUM_PARSE_CASE_SENSITIVE                = 0x00001003,
    UNUM_SIGN_ALWAYS_SHOWN                   = 0x00001004,
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

enum UDateFormatHourCycle : int
{
    UDAT_HOUR_CYCLE_11 = 0x00000000,
    UDAT_HOUR_CYCLE_12 = 0x00000001,
    UDAT_HOUR_CYCLE_23 = 0x00000002,
    UDAT_HOUR_CYCLE_24 = 0x00000003,
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
    UDAT_NARROW_QUARTERS             = 0x0000001c,
    UDAT_STANDALONE_NARROW_QUARTERS  = 0x0000001d,
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

enum UNumberUnitWidth : int
{
    UNUM_UNIT_WIDTH_NARROW    = 0x00000000,
    UNUM_UNIT_WIDTH_SHORT     = 0x00000001,
    UNUM_UNIT_WIDTH_FULL_NAME = 0x00000002,
    UNUM_UNIT_WIDTH_ISO_CODE  = 0x00000003,
    UNUM_UNIT_WIDTH_FORMAL    = 0x00000004,
    UNUM_UNIT_WIDTH_VARIANT   = 0x00000005,
    UNUM_UNIT_WIDTH_HIDDEN    = 0x00000006,
    UNUM_UNIT_WIDTH_COUNT     = 0x00000007,
}

enum UNumberGroupingStrategy : int
{
    UNUM_GROUPING_OFF        = 0x00000000,
    UNUM_GROUPING_MIN2       = 0x00000001,
    UNUM_GROUPING_AUTO       = 0x00000002,
    UNUM_GROUPING_ON_ALIGNED = 0x00000003,
    UNUM_GROUPING_THOUSANDS  = 0x00000004,
}

enum UNumberSignDisplay : int
{
    UNUM_SIGN_AUTO                   = 0x00000000,
    UNUM_SIGN_ALWAYS                 = 0x00000001,
    UNUM_SIGN_NEVER                  = 0x00000002,
    UNUM_SIGN_ACCOUNTING             = 0x00000003,
    UNUM_SIGN_ACCOUNTING_ALWAYS      = 0x00000004,
    UNUM_SIGN_EXCEPT_ZERO            = 0x00000005,
    UNUM_SIGN_ACCOUNTING_EXCEPT_ZERO = 0x00000006,
    UNUM_SIGN_NEGATIVE               = 0x00000007,
    UNUM_SIGN_ACCOUNTING_NEGATIVE    = 0x00000008,
    UNUM_SIGN_COUNT                  = 0x00000009,
}

enum UNumberDecimalSeparatorDisplay : int
{
    UNUM_DECIMAL_SEPARATOR_AUTO   = 0x00000000,
    UNUM_DECIMAL_SEPARATOR_ALWAYS = 0x00000001,
    UNUM_DECIMAL_SEPARATOR_COUNT  = 0x00000002,
}

enum UNumberTrailingZeroDisplay : int
{
    UNUM_TRAILING_ZERO_AUTO          = 0x00000000,
    UNUM_TRAILING_ZERO_HIDE_IF_WHOLE = 0x00000001,
}

enum UNumberRangeCollapse : int
{
    UNUM_RANGE_COLLAPSE_AUTO = 0x00000000,
    UNUM_RANGE_COLLAPSE_NONE = 0x00000001,
    UNUM_RANGE_COLLAPSE_UNIT = 0x00000002,
    UNUM_RANGE_COLLAPSE_ALL  = 0x00000003,
}

enum UNumberRangeIdentityFallback : int
{
    UNUM_IDENTITY_FALLBACK_SINGLE_VALUE                  = 0x00000000,
    UNUM_IDENTITY_FALLBACK_APPROXIMATELY_OR_SINGLE_VALUE = 0x00000001,
    UNUM_IDENTITY_FALLBACK_APPROXIMATELY                 = 0x00000002,
    UNUM_IDENTITY_FALLBACK_RANGE                         = 0x00000003,
}

enum UNumberRangeIdentityResult : int
{
    UNUM_IDENTITY_RESULT_EQUAL_BEFORE_ROUNDING = 0x00000000,
    UNUM_IDENTITY_RESULT_EQUAL_AFTER_ROUNDING  = 0x00000001,
    UNUM_IDENTITY_RESULT_NOT_EQUAL             = 0x00000002,
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

enum URelativeDateTimeFormatterField : int
{
    UDAT_REL_LITERAL_FIELD = 0x00000000,
    UDAT_REL_NUMERIC_FIELD = 0x00000001,
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
    USPOOF_HIDDEN_OVERLAY           = 0x00000100,
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

enum UStringTrieBuildOption : int
{
    USTRINGTRIE_BUILD_FAST  = 0x00000000,
    USTRINGTRIE_BUILD_SMALL = 0x00000001,
}

enum UMessagePatternApostropheMode : int
{
    UMSGPAT_APOS_DOUBLE_OPTIONAL = 0x00000000,
    UMSGPAT_APOS_DOUBLE_REQUIRED = 0x00000001,
}

enum UMessagePatternPartType : int
{
    UMSGPAT_PART_TYPE_MSG_START      = 0x00000000,
    UMSGPAT_PART_TYPE_MSG_LIMIT      = 0x00000001,
    UMSGPAT_PART_TYPE_SKIP_SYNTAX    = 0x00000002,
    UMSGPAT_PART_TYPE_INSERT_CHAR    = 0x00000003,
    UMSGPAT_PART_TYPE_REPLACE_NUMBER = 0x00000004,
    UMSGPAT_PART_TYPE_ARG_START      = 0x00000005,
    UMSGPAT_PART_TYPE_ARG_LIMIT      = 0x00000006,
    UMSGPAT_PART_TYPE_ARG_NUMBER     = 0x00000007,
    UMSGPAT_PART_TYPE_ARG_NAME       = 0x00000008,
    UMSGPAT_PART_TYPE_ARG_TYPE       = 0x00000009,
    UMSGPAT_PART_TYPE_ARG_STYLE      = 0x0000000a,
    UMSGPAT_PART_TYPE_ARG_SELECTOR   = 0x0000000b,
    UMSGPAT_PART_TYPE_ARG_INT        = 0x0000000c,
    UMSGPAT_PART_TYPE_ARG_DOUBLE     = 0x0000000d,
}

enum UMessagePatternArgType : int
{
    UMSGPAT_ARG_TYPE_NONE          = 0x00000000,
    UMSGPAT_ARG_TYPE_SIMPLE        = 0x00000001,
    UMSGPAT_ARG_TYPE_CHOICE        = 0x00000002,
    UMSGPAT_ARG_TYPE_PLURAL        = 0x00000003,
    UMSGPAT_ARG_TYPE_SELECT        = 0x00000004,
    UMSGPAT_ARG_TYPE_SELECTORDINAL = 0x00000005,
}

enum UAlphabeticIndexLabelType : int
{
    U_ALPHAINDEX_NORMAL    = 0x00000000,
    U_ALPHAINDEX_UNDERFLOW = 0x00000001,
    U_ALPHAINDEX_INFLOW    = 0x00000002,
    U_ALPHAINDEX_OVERFLOW  = 0x00000003,
}

enum UTimeZoneNameType : int
{
    UTZNM_UNKNOWN           = 0x00000000,
    UTZNM_LONG_GENERIC      = 0x00000001,
    UTZNM_LONG_STANDARD     = 0x00000002,
    UTZNM_LONG_DAYLIGHT     = 0x00000004,
    UTZNM_SHORT_GENERIC     = 0x00000008,
    UTZNM_SHORT_STANDARD    = 0x00000010,
    UTZNM_SHORT_DAYLIGHT    = 0x00000020,
    UTZNM_EXEMPLAR_LOCATION = 0x00000040,
}

enum UTimeZoneFormatStyle : int
{
    UTZFMT_STYLE_GENERIC_LOCATION         = 0x00000000,
    UTZFMT_STYLE_GENERIC_LONG             = 0x00000001,
    UTZFMT_STYLE_GENERIC_SHORT            = 0x00000002,
    UTZFMT_STYLE_SPECIFIC_LONG            = 0x00000003,
    UTZFMT_STYLE_SPECIFIC_SHORT           = 0x00000004,
    UTZFMT_STYLE_LOCALIZED_GMT            = 0x00000005,
    UTZFMT_STYLE_LOCALIZED_GMT_SHORT      = 0x00000006,
    UTZFMT_STYLE_ISO_BASIC_SHORT          = 0x00000007,
    UTZFMT_STYLE_ISO_BASIC_LOCAL_SHORT    = 0x00000008,
    UTZFMT_STYLE_ISO_BASIC_FIXED          = 0x00000009,
    UTZFMT_STYLE_ISO_BASIC_LOCAL_FIXED    = 0x0000000a,
    UTZFMT_STYLE_ISO_BASIC_FULL           = 0x0000000b,
    UTZFMT_STYLE_ISO_BASIC_LOCAL_FULL     = 0x0000000c,
    UTZFMT_STYLE_ISO_EXTENDED_FIXED       = 0x0000000d,
    UTZFMT_STYLE_ISO_EXTENDED_LOCAL_FIXED = 0x0000000e,
    UTZFMT_STYLE_ISO_EXTENDED_FULL        = 0x0000000f,
    UTZFMT_STYLE_ISO_EXTENDED_LOCAL_FULL  = 0x00000010,
    UTZFMT_STYLE_ZONE_ID                  = 0x00000011,
    UTZFMT_STYLE_ZONE_ID_SHORT            = 0x00000012,
    UTZFMT_STYLE_EXEMPLAR_LOCATION        = 0x00000013,
}

enum UTimeZoneFormatGMTOffsetPatternType : int
{
    UTZFMT_PAT_POSITIVE_HM  = 0x00000000,
    UTZFMT_PAT_POSITIVE_HMS = 0x00000001,
    UTZFMT_PAT_NEGATIVE_HM  = 0x00000002,
    UTZFMT_PAT_NEGATIVE_HMS = 0x00000003,
    UTZFMT_PAT_POSITIVE_H   = 0x00000004,
    UTZFMT_PAT_NEGATIVE_H   = 0x00000005,
    UTZFMT_PAT_COUNT        = 0x00000006,
}

enum UTimeZoneFormatTimeType : int
{
    UTZFMT_TIME_TYPE_UNKNOWN  = 0x00000000,
    UTZFMT_TIME_TYPE_STANDARD = 0x00000001,
    UTZFMT_TIME_TYPE_DAYLIGHT = 0x00000002,
}

enum UTimeZoneFormatParseOption : int
{
    UTZFMT_PARSE_OPTION_NONE                      = 0x00000000,
    UTZFMT_PARSE_OPTION_ALL_STYLES                = 0x00000001,
    UTZFMT_PARSE_OPTION_TZ_DATABASE_ABBREVIATIONS = 0x00000002,
}

enum UMeasureFormatWidth : int
{
    UMEASFMT_WIDTH_WIDE    = 0x00000000,
    UMEASFMT_WIDTH_SHORT   = 0x00000001,
    UMEASFMT_WIDTH_NARROW  = 0x00000002,
    UMEASFMT_WIDTH_NUMERIC = 0x00000003,
    UMEASFMT_WIDTH_COUNT   = 0x00000004,
}

enum UDateRelativeUnit : int
{
    UDAT_RELATIVE_SECONDS    = 0x00000000,
    UDAT_RELATIVE_MINUTES    = 0x00000001,
    UDAT_RELATIVE_HOURS      = 0x00000002,
    UDAT_RELATIVE_DAYS       = 0x00000003,
    UDAT_RELATIVE_WEEKS      = 0x00000004,
    UDAT_RELATIVE_MONTHS     = 0x00000005,
    UDAT_RELATIVE_YEARS      = 0x00000006,
    UDAT_RELATIVE_UNIT_COUNT = 0x00000007,
}

enum UDateAbsoluteUnit : int
{
    UDAT_ABSOLUTE_SUNDAY     = 0x00000000,
    UDAT_ABSOLUTE_MONDAY     = 0x00000001,
    UDAT_ABSOLUTE_TUESDAY    = 0x00000002,
    UDAT_ABSOLUTE_WEDNESDAY  = 0x00000003,
    UDAT_ABSOLUTE_THURSDAY   = 0x00000004,
    UDAT_ABSOLUTE_FRIDAY     = 0x00000005,
    UDAT_ABSOLUTE_SATURDAY   = 0x00000006,
    UDAT_ABSOLUTE_DAY        = 0x00000007,
    UDAT_ABSOLUTE_WEEK       = 0x00000008,
    UDAT_ABSOLUTE_MONTH      = 0x00000009,
    UDAT_ABSOLUTE_YEAR       = 0x0000000a,
    UDAT_ABSOLUTE_NOW        = 0x0000000b,
    UDAT_ABSOLUTE_UNIT_COUNT = 0x0000000c,
}

enum UDateDirection : int
{
    UDAT_DIRECTION_LAST_2 = 0x00000000,
    UDAT_DIRECTION_LAST   = 0x00000001,
    UDAT_DIRECTION_THIS   = 0x00000002,
    UDAT_DIRECTION_NEXT   = 0x00000003,
    UDAT_DIRECTION_NEXT_2 = 0x00000004,
    UDAT_DIRECTION_PLAIN  = 0x00000005,
    UDAT_DIRECTION_COUNT  = 0x00000006,
}

alias MIMECONTF = int;
enum : int
{
    MIMECONTF_MAILNEWS         = 0x00000001,
    MIMECONTF_BROWSER          = 0x00000002,
    MIMECONTF_MINIMAL          = 0x00000004,
    MIMECONTF_IMPORT           = 0x00000008,
    MIMECONTF_SAVABLE_MAILNEWS = 0x00000100,
    MIMECONTF_SAVABLE_BROWSER  = 0x00000200,
    MIMECONTF_EXPORT           = 0x00000400,
    MIMECONTF_PRIVCONVERTER    = 0x00010000,
    MIMECONTF_VALID            = 0x00020000,
    MIMECONTF_VALID_NLS        = 0x00040000,
    MIMECONTF_MIME_IE4         = 0x10000000,
    MIMECONTF_MIME_LATEST      = 0x20000000,
    MIMECONTF_MIME_REGISTRY    = 0x40000000,
}

alias SCRIPTCONTF = int;
enum : int
{
    sidDefault     = 0x00000000,
    sidMerge       = 0x00000001,
    sidAsciiSym    = 0x00000002,
    sidAsciiLatin  = 0x00000003,
    sidLatin       = 0x00000004,
    sidGreek       = 0x00000005,
    sidCyrillic    = 0x00000006,
    sidArmenian    = 0x00000007,
    sidHebrew      = 0x00000008,
    sidArabic      = 0x00000009,
    sidDevanagari  = 0x0000000a,
    sidBengali     = 0x0000000b,
    sidGurmukhi    = 0x0000000c,
    sidGujarati    = 0x0000000d,
    sidOriya       = 0x0000000e,
    sidTamil       = 0x0000000f,
    sidTelugu      = 0x00000010,
    sidKannada     = 0x00000011,
    sidMalayalam   = 0x00000012,
    sidThai        = 0x00000013,
    sidLao         = 0x00000014,
    sidTibetan     = 0x00000015,
    sidGeorgian    = 0x00000016,
    sidHangul      = 0x00000017,
    sidKana        = 0x00000018,
    sidBopomofo    = 0x00000019,
    sidHan         = 0x0000001a,
    sidEthiopic    = 0x0000001b,
    sidCanSyllabic = 0x0000001c,
    sidCherokee    = 0x0000001d,
    sidYi          = 0x0000001e,
    sidBraille     = 0x0000001f,
    sidRunic       = 0x00000020,
    sidOgham       = 0x00000021,
    sidSinhala     = 0x00000022,
    sidSyriac      = 0x00000023,
    sidBurmese     = 0x00000024,
    sidKhmer       = 0x00000025,
    sidThaana      = 0x00000026,
    sidMongolian   = 0x00000027,
    sidUserDefined = 0x00000028,
    sidLim         = 0x00000029,
    sidFEFirst     = 0x00000017,
    sidFELast      = 0x0000001a,
}

alias MLCONVCHAR = int;
enum : int
{
    MLCONVCHARF_AUTODETECT     = 0x00000001,
    MLCONVCHARF_ENTITIZE       = 0x00000002,
    MLCONVCHARF_NCR_ENTITIZE   = 0x00000002,
    MLCONVCHARF_NAME_ENTITIZE  = 0x00000004,
    MLCONVCHARF_USEDEFCHAR     = 0x00000008,
    MLCONVCHARF_NOBESTFITCHARS = 0x00000010,
    MLCONVCHARF_DETECTJPN      = 0x00000020,
}

alias MLCP = int;
enum : int
{
    MLDETECTF_MAILNEWS           = 0x00000001,
    MLDETECTF_BROWSER            = 0x00000002,
    MLDETECTF_VALID              = 0x00000004,
    MLDETECTF_VALID_NLS          = 0x00000008,
    MLDETECTF_PRESERVE_ORDER     = 0x00000010,
    MLDETECTF_PREFERRED_ONLY     = 0x00000020,
    MLDETECTF_FILTER_SPECIALCHAR = 0x00000040,
    MLDETECTF_EURO_UTF8          = 0x00000080,
}

alias MLDETECTCP = int;
enum : int
{
    MLDETECTCP_NONE   = 0x00000000,
    MLDETECTCP_7BIT   = 0x00000001,
    MLDETECTCP_8BIT   = 0x00000002,
    MLDETECTCP_DBCS   = 0x00000004,
    MLDETECTCP_HTML   = 0x00000008,
    MLDETECTCP_NUMBER = 0x00000010,
}

alias SCRIPTFONTCONTF = int;
enum : int
{
    SCRIPTCONTF_FIXED_FONT        = 0x00000001,
    SCRIPTCONTF_PROPORTIONAL_FONT = 0x00000002,
    SCRIPTCONTF_SCRIPT_USER       = 0x00010000,
    SCRIPTCONTF_SCRIPT_HIDE       = 0x00020000,
    SCRIPTCONTF_SCRIPT_SYSTEM     = 0x00040000,
}

alias MLSTR_FLAGS = int;
enum : int
{
    MLSTR_READ  = 0x00000001,
    MLSTR_WRITE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Intl/caldatetime-dateunit
alias CALDATETIME_DATEUNIT = int;
enum : int
{
    EraUnit    = 0x00000000,
    YearUnit   = 0x00000001,
    MonthUnit  = 0x00000002,
    WeekUnit   = 0x00000003,
    DayUnit    = 0x00000004,
    HourUnit   = 0x00000005,
    MinuteUnit = 0x00000006,
    SecondUnit = 0x00000007,
    TickUnit   = 0x00000008,
}

// Constants


enum int LANG_SYSTEM_DEFAULT = 0x00000800;
enum int LANG_USER_DEFAULT = 0x00000400;
enum uint LOCALE_SYSTEM_DEFAULT = 0x00000800U;
enum uint LOCALE_USER_DEFAULT = 0x00000400U;

enum : uint
{
    LOCALE_CUSTOM_DEFAULT     = 0x00000c00U,
    LOCALE_CUSTOM_UNSPECIFIED = 0x00001000U,
    LOCALE_CUSTOM_UI_DEFAULT  = 0x00001400U,
}

enum : uint
{
    LOCALE_NEUTRAL   = 0x00000000U,
    LOCALE_INVARIANT = 0x0000007fU,
}

enum uint ALL_SERVICE_TYPES = 0x00000000U;
enum uint HIGHLEVEL_SERVICE_TYPES = 0x00000001U;
enum uint LOWLEVEL_SERVICE_TYPES = 0x00000002U;
enum uint ALL_SERVICES = 0x00000000U;
enum uint ONLINE_SERVICES = 0x00000001U;
enum uint OFFLINE_SERVICES = 0x00000002U;
enum uint MAX_LEADBYTES = 0x0000000cU;
enum uint MAX_DEFAULTCHAR = 0x00000002U;

enum : uint
{
    HIGH_SURROGATE_START = 0x0000d800U,
    HIGH_SURROGATE_END   = 0x0000dbffU,
}

enum : uint
{
    LOW_SURROGATE_START = 0x0000dc00U,
    LOW_SURROGATE_END   = 0x0000dfffU,
}

enum uint WC_COMPOSITECHECK = 0x00000200U;
enum uint WC_DISCARDNS = 0x00000010U;
enum uint WC_SEPCHARS = 0x00000020U;
enum uint WC_DEFAULTCHAR = 0x00000040U;
enum uint WC_ERR_INVALID_CHARS = 0x00000080U;
enum uint WC_NO_BEST_FIT_CHARS = 0x00000400U;

enum : uint
{
    CT_CTYPE1 = 0x00000001U,
    CT_CTYPE2 = 0x00000002U,
    CT_CTYPE3 = 0x00000004U,
}

enum uint C1_UPPER = 0x00000001U;
enum uint C1_LOWER = 0x00000002U;
enum uint C1_DIGIT = 0x00000004U;
enum uint C1_SPACE = 0x00000008U;
enum uint C1_PUNCT = 0x00000010U;
enum uint C1_CNTRL = 0x00000020U;
enum uint C1_BLANK = 0x00000040U;
enum uint C1_XDIGIT = 0x00000080U;
enum uint C1_ALPHA = 0x00000100U;
enum uint C1_DEFINED = 0x00000200U;
enum uint C2_LEFTTORIGHT = 0x00000001U;
enum uint C2_RIGHTTOLEFT = 0x00000002U;

enum : uint
{
    C2_EUROPENUMBER     = 0x00000003U,
    C2_EUROPESEPARATOR  = 0x00000004U,
    C2_EUROPETERMINATOR = 0x00000005U,
}

enum uint C2_ARABICNUMBER = 0x00000006U;
enum uint C2_COMMONSEPARATOR = 0x00000007U;
enum uint C2_BLOCKSEPARATOR = 0x00000008U;
enum uint C2_SEGMENTSEPARATOR = 0x00000009U;
enum uint C2_WHITESPACE = 0x0000000aU;
enum uint C2_OTHERNEUTRAL = 0x0000000bU;
enum uint C2_NOTAPPLICABLE = 0x00000000U;
enum uint C3_NONSPACING = 0x00000001U;
enum uint C3_DIACRITIC = 0x00000002U;
enum uint C3_VOWELMARK = 0x00000004U;
enum uint C3_SYMBOL = 0x00000008U;
enum uint C3_KATAKANA = 0x00000010U;
enum uint C3_HIRAGANA = 0x00000020U;
enum uint C3_HALFWIDTH = 0x00000040U;
enum uint C3_FULLWIDTH = 0x00000080U;
enum uint C3_IDEOGRAPH = 0x00000100U;
enum uint C3_KASHIDA = 0x00000200U;
enum uint C3_LEXICAL = 0x00000400U;
enum uint C3_HIGHSURROGATE = 0x00000800U;
enum uint C3_LOWSURROGATE = 0x00001000U;
enum uint C3_ALPHA = 0x00008000U;
enum uint C3_NOTAPPLICABLE = 0x00000000U;
enum uint LCMAP_LOWERCASE = 0x00000100U;
enum uint LCMAP_UPPERCASE = 0x00000200U;
enum uint LCMAP_TITLECASE = 0x00000300U;

enum : uint
{
    LCMAP_SORTKEY   = 0x00000400U,
    LCMAP_BYTEREV   = 0x00000800U,
    LCMAP_HIRAGANA  = 0x00100000U,
    LCMAP_KATAKANA  = 0x00200000U,
    LCMAP_HALFWIDTH = 0x00400000U,
}

enum uint LCMAP_FULLWIDTH = 0x00800000U;
enum uint LCMAP_LINGUISTIC_CASING = 0x01000000U;
enum uint LCMAP_SIMPLIFIED_CHINESE = 0x02000000U;
enum uint LCMAP_TRADITIONAL_CHINESE = 0x04000000U;
enum uint LCMAP_SORTHANDLE = 0x20000000U;
enum uint LCMAP_HASH = 0x00040000U;
enum uint FIND_STARTSWITH = 0x00100000U;
enum uint FIND_ENDSWITH = 0x00200000U;

enum : uint
{
    FIND_FROMSTART = 0x00400000U,
    FIND_FROMEND   = 0x00800000U,
}

enum uint LCID_ALTERNATE_SORTS = 0x00000004U;

enum : uint
{
    LOCALE_ALL          = 0x00000000U,
    LOCALE_WINDOWS      = 0x00000001U,
    LOCALE_SUPPLEMENTAL = 0x00000002U,
}

enum uint LOCALE_ALTERNATE_SORTS = 0x00000004U;
enum uint LOCALE_REPLACEMENT = 0x00000008U;
enum uint LOCALE_NEUTRALDATA = 0x00000010U;
enum uint LOCALE_SPECIFICDATA = 0x00000020U;

enum : uint
{
    CP_ACP   = 0x00000000U,
    CP_OEMCP = 0x00000001U,
}

enum uint CP_MACCP = 0x00000002U;
enum uint CP_THREAD_ACP = 0x00000003U;
enum uint CP_SYMBOL = 0x0000002aU;

enum : uint
{
    CP_UTF7 = 0x0000fde8U,
    CP_UTF8 = 0x0000fde9U,
}

enum : uint
{
    CTRY_DEFAULT    = 0x00000000U,
    CTRY_ALBANIA    = 0x00000163U,
    CTRY_ALGERIA    = 0x000000d5U,
    CTRY_ARGENTINA  = 0x00000036U,
    CTRY_ARMENIA    = 0x00000176U,
    CTRY_AUSTRALIA  = 0x0000003dU,
    CTRY_AUSTRIA    = 0x0000002bU,
    CTRY_AZERBAIJAN = 0x000003e2U,
}

enum : uint
{
    CTRY_BAHRAIN           = 0x000003cdU,
    CTRY_BELARUS           = 0x00000177U,
    CTRY_BELGIUM           = 0x00000020U,
    CTRY_BELIZE            = 0x000001f5U,
    CTRY_BOLIVIA           = 0x0000024fU,
    CTRY_BRAZIL            = 0x00000037U,
    CTRY_BRUNEI_DARUSSALAM = 0x000002a1U,
}

enum uint CTRY_BULGARIA = 0x00000167U;

enum : uint
{
    CTRY_CANADA     = 0x00000002U,
    CTRY_CARIBBEAN  = 0x00000001U,
    CTRY_CHILE      = 0x00000038U,
    CTRY_COLOMBIA   = 0x00000039U,
    CTRY_COSTA_RICA = 0x000001faU,
}

enum : uint
{
    CTRY_CROATIA            = 0x00000181U,
    CTRY_CZECH              = 0x000001a4U,
    CTRY_DENMARK            = 0x0000002dU,
    CTRY_DOMINICAN_REPUBLIC = 0x00000001U,
}

enum : uint
{
    CTRY_ECUADOR     = 0x00000251U,
    CTRY_EGYPT       = 0x00000014U,
    CTRY_EL_SALVADOR = 0x000001f7U,
}

enum : uint
{
    CTRY_ESTONIA        = 0x00000174U,
    CTRY_FAEROE_ISLANDS = 0x0000012aU,
}

enum : uint
{
    CTRY_FINLAND   = 0x00000166U,
    CTRY_FRANCE    = 0x00000021U,
    CTRY_GEORGIA   = 0x000003e3U,
    CTRY_GERMANY   = 0x00000031U,
    CTRY_GREECE    = 0x0000001eU,
    CTRY_GUATEMALA = 0x000001f6U,
}

enum : uint
{
    CTRY_HONDURAS   = 0x000001f8U,
    CTRY_HONG_KONG  = 0x00000354U,
    CTRY_HUNGARY    = 0x00000024U,
    CTRY_ICELAND    = 0x00000162U,
    CTRY_INDIA      = 0x0000005bU,
    CTRY_INDONESIA  = 0x0000003eU,
    CTRY_IRAN       = 0x000003d5U,
    CTRY_IRAQ       = 0x000003c4U,
    CTRY_IRELAND    = 0x00000161U,
    CTRY_ISRAEL     = 0x000003ccU,
    CTRY_ITALY      = 0x00000027U,
    CTRY_JAMAICA    = 0x00000001U,
    CTRY_JAPAN      = 0x00000051U,
    CTRY_JORDAN     = 0x000003c2U,
    CTRY_KAZAKSTAN  = 0x00000007U,
    CTRY_KENYA      = 0x000000feU,
    CTRY_KUWAIT     = 0x000003c5U,
    CTRY_KYRGYZSTAN = 0x000003e4U,
}

enum : uint
{
    CTRY_LATVIA        = 0x00000173U,
    CTRY_LEBANON       = 0x000003c1U,
    CTRY_LIBYA         = 0x000000daU,
    CTRY_LIECHTENSTEIN = 0x00000029U,
}

enum : uint
{
    CTRY_LITHUANIA  = 0x00000172U,
    CTRY_LUXEMBOURG = 0x00000160U,
}

enum : uint
{
    CTRY_MACAU       = 0x00000355U,
    CTRY_MACEDONIA   = 0x00000185U,
    CTRY_MALAYSIA    = 0x0000003cU,
    CTRY_MALDIVES    = 0x000003c0U,
    CTRY_MEXICO      = 0x00000034U,
    CTRY_MONACO      = 0x00000021U,
    CTRY_MONGOLIA    = 0x000003d0U,
    CTRY_MOROCCO     = 0x000000d4U,
    CTRY_NETHERLANDS = 0x0000001fU,
    CTRY_NEW_ZEALAND = 0x00000040U,
}

enum : uint
{
    CTRY_NICARAGUA   = 0x000001f9U,
    CTRY_NORWAY      = 0x0000002fU,
    CTRY_OMAN        = 0x000003c8U,
    CTRY_PAKISTAN    = 0x0000005cU,
    CTRY_PANAMA      = 0x000001fbU,
    CTRY_PARAGUAY    = 0x00000253U,
    CTRY_PERU        = 0x00000033U,
    CTRY_PHILIPPINES = 0x0000003fU,
}

enum : uint
{
    CTRY_POLAND      = 0x00000030U,
    CTRY_PORTUGAL    = 0x0000015fU,
    CTRY_PRCHINA     = 0x00000056U,
    CTRY_PUERTO_RICO = 0x00000001U,
}

enum : uint
{
    CTRY_QATAR        = 0x000003ceU,
    CTRY_ROMANIA      = 0x00000028U,
    CTRY_RUSSIA       = 0x00000007U,
    CTRY_SAUDI_ARABIA = 0x000003c6U,
}

enum : uint
{
    CTRY_SERBIA       = 0x0000017dU,
    CTRY_SINGAPORE    = 0x00000041U,
    CTRY_SLOVAK       = 0x000001a5U,
    CTRY_SLOVENIA     = 0x00000182U,
    CTRY_SOUTH_AFRICA = 0x0000001bU,
    CTRY_SOUTH_KOREA  = 0x00000052U,
}

enum : uint
{
    CTRY_SPAIN       = 0x00000022U,
    CTRY_SWEDEN      = 0x0000002eU,
    CTRY_SWITZERLAND = 0x00000029U,
}

enum : uint
{
    CTRY_SYRIA             = 0x000003c3U,
    CTRY_TAIWAN            = 0x00000376U,
    CTRY_TATARSTAN         = 0x00000007U,
    CTRY_THAILAND          = 0x00000042U,
    CTRY_TRINIDAD_Y_TOBAGO = 0x00000001U,
}

enum : uint
{
    CTRY_TUNISIA        = 0x000000d8U,
    CTRY_TURKEY         = 0x0000005aU,
    CTRY_UAE            = 0x000003cbU,
    CTRY_UKRAINE        = 0x0000017cU,
    CTRY_UNITED_KINGDOM = 0x0000002cU,
    CTRY_UNITED_STATES  = 0x00000001U,
}

enum : uint
{
    CTRY_URUGUAY    = 0x00000256U,
    CTRY_UZBEKISTAN = 0x00000007U,
}

enum : uint
{
    CTRY_VENEZUELA = 0x0000003aU,
    CTRY_VIET_NAM  = 0x00000054U,
}

enum : uint
{
    CTRY_YEMEN    = 0x000003c7U,
    CTRY_ZIMBABWE = 0x00000107U,
}

enum uint LOCALE_NOUSEROVERRIDE = 0x80000000U;

enum : uint
{
    LOCALE_USE_CP_ACP            = 0x40000000U,
    LOCALE_RETURN_NUMBER         = 0x20000000U,
    LOCALE_RETURN_GENITIVE_NAMES = 0x10000000U,
}

enum uint LOCALE_ALLOW_NEUTRAL_NAMES = 0x08000000U;
enum uint LOCALE_SLOCALIZEDDISPLAYNAME = 0x00000002U;
enum uint LOCALE_SENGLISHDISPLAYNAME = 0x00000072U;
enum uint LOCALE_SNATIVEDISPLAYNAME = 0x00000073U;
enum uint LOCALE_SLOCALIZEDLANGUAGENAME = 0x0000006fU;
enum uint LOCALE_SENGLISHLANGUAGENAME = 0x00001001U;
enum uint LOCALE_SNATIVELANGUAGENAME = 0x00000004U;
enum uint LOCALE_SLOCALIZEDCOUNTRYNAME = 0x00000006U;
enum uint LOCALE_SENGLISHCOUNTRYNAME = 0x00001002U;
enum uint LOCALE_SNATIVECOUNTRYNAME = 0x00000008U;
enum uint LOCALE_IDIALINGCODE = 0x00000005U;

enum : uint
{
    LOCALE_SLIST         = 0x0000000cU,
    LOCALE_IMEASURE      = 0x0000000dU,
    LOCALE_SDECIMAL      = 0x0000000eU,
    LOCALE_STHOUSAND     = 0x0000000fU,
    LOCALE_SGROUPING     = 0x00000010U,
    LOCALE_IDIGITS       = 0x00000011U,
    LOCALE_ILZERO        = 0x00000012U,
    LOCALE_INEGNUMBER    = 0x00001010U,
    LOCALE_SNATIVEDIGITS = 0x00000013U,
}

enum : uint
{
    LOCALE_SCURRENCY       = 0x00000014U,
    LOCALE_SINTLSYMBOL     = 0x00000015U,
    LOCALE_SMONDECIMALSEP  = 0x00000016U,
    LOCALE_SMONTHOUSANDSEP = 0x00000017U,
    LOCALE_SMONGROUPING    = 0x00000018U,
}

enum : uint
{
    LOCALE_ICURRDIGITS   = 0x00000019U,
    LOCALE_ICURRENCY     = 0x0000001bU,
    LOCALE_INEGCURR      = 0x0000001cU,
    LOCALE_SSHORTDATE    = 0x0000001fU,
    LOCALE_SLONGDATE     = 0x00000020U,
    LOCALE_STIMEFORMAT   = 0x00001003U,
    LOCALE_SAM           = 0x00000028U,
    LOCALE_SPM           = 0x00000029U,
    LOCALE_ICALENDARTYPE = 0x00001009U,
}

enum uint LOCALE_IOPTIONALCALENDAR = 0x0000100bU;

enum : uint
{
    LOCALE_IFIRSTDAYOFWEEK  = 0x0000100cU,
    LOCALE_IFIRSTWEEKOFYEAR = 0x0000100dU,
}

enum : uint
{
    LOCALE_SDAYNAME1       = 0x0000002aU,
    LOCALE_SDAYNAME2       = 0x0000002bU,
    LOCALE_SDAYNAME3       = 0x0000002cU,
    LOCALE_SDAYNAME4       = 0x0000002dU,
    LOCALE_SDAYNAME5       = 0x0000002eU,
    LOCALE_SDAYNAME6       = 0x0000002fU,
    LOCALE_SDAYNAME7       = 0x00000030U,
    LOCALE_SABBREVDAYNAME1 = 0x00000031U,
    LOCALE_SABBREVDAYNAME2 = 0x00000032U,
    LOCALE_SABBREVDAYNAME3 = 0x00000033U,
    LOCALE_SABBREVDAYNAME4 = 0x00000034U,
    LOCALE_SABBREVDAYNAME5 = 0x00000035U,
    LOCALE_SABBREVDAYNAME6 = 0x00000036U,
    LOCALE_SABBREVDAYNAME7 = 0x00000037U,
}

enum : uint
{
    LOCALE_SMONTHNAME1        = 0x00000038U,
    LOCALE_SMONTHNAME2        = 0x00000039U,
    LOCALE_SMONTHNAME3        = 0x0000003aU,
    LOCALE_SMONTHNAME4        = 0x0000003bU,
    LOCALE_SMONTHNAME5        = 0x0000003cU,
    LOCALE_SMONTHNAME6        = 0x0000003dU,
    LOCALE_SMONTHNAME7        = 0x0000003eU,
    LOCALE_SMONTHNAME8        = 0x0000003fU,
    LOCALE_SMONTHNAME9        = 0x00000040U,
    LOCALE_SMONTHNAME10       = 0x00000041U,
    LOCALE_SMONTHNAME11       = 0x00000042U,
    LOCALE_SMONTHNAME12       = 0x00000043U,
    LOCALE_SMONTHNAME13       = 0x0000100eU,
    LOCALE_SABBREVMONTHNAME1  = 0x00000044U,
    LOCALE_SABBREVMONTHNAME2  = 0x00000045U,
    LOCALE_SABBREVMONTHNAME3  = 0x00000046U,
    LOCALE_SABBREVMONTHNAME4  = 0x00000047U,
    LOCALE_SABBREVMONTHNAME5  = 0x00000048U,
    LOCALE_SABBREVMONTHNAME6  = 0x00000049U,
    LOCALE_SABBREVMONTHNAME7  = 0x0000004aU,
    LOCALE_SABBREVMONTHNAME8  = 0x0000004bU,
    LOCALE_SABBREVMONTHNAME9  = 0x0000004cU,
    LOCALE_SABBREVMONTHNAME10 = 0x0000004dU,
    LOCALE_SABBREVMONTHNAME11 = 0x0000004eU,
    LOCALE_SABBREVMONTHNAME12 = 0x0000004fU,
    LOCALE_SABBREVMONTHNAME13 = 0x0000100fU,
}

enum uint LOCALE_SPOSITIVESIGN = 0x00000050U;
enum uint LOCALE_SNEGATIVESIGN = 0x00000051U;

enum : uint
{
    LOCALE_IPOSSIGNPOSN    = 0x00000052U,
    LOCALE_INEGSIGNPOSN    = 0x00000053U,
    LOCALE_IPOSSYMPRECEDES = 0x00000054U,
    LOCALE_IPOSSEPBYSPACE  = 0x00000055U,
}

enum : uint
{
    LOCALE_INEGSYMPRECEDES = 0x00000056U,
    LOCALE_INEGSEPBYSPACE  = 0x00000057U,
}

enum uint LOCALE_FONTSIGNATURE = 0x00000058U;

enum : uint
{
    LOCALE_SISO639LANGNAME  = 0x00000059U,
    LOCALE_SISO3166CTRYNAME = 0x0000005aU,
}

enum : uint
{
    LOCALE_IPAPERSIZE      = 0x0000100aU,
    LOCALE_SENGCURRNAME    = 0x00001007U,
    LOCALE_SNATIVECURRNAME = 0x00001008U,
}

enum : uint
{
    LOCALE_SYEARMONTH         = 0x00001006U,
    LOCALE_SSORTNAME          = 0x00001013U,
    LOCALE_IDIGITSUBSTITUTION = 0x00001014U,
}

enum : uint
{
    LOCALE_SNAME             = 0x0000005cU,
    LOCALE_SDURATION         = 0x0000005dU,
    LOCALE_SSHORTESTDAYNAME1 = 0x00000060U,
    LOCALE_SSHORTESTDAYNAME2 = 0x00000061U,
    LOCALE_SSHORTESTDAYNAME3 = 0x00000062U,
    LOCALE_SSHORTESTDAYNAME4 = 0x00000063U,
    LOCALE_SSHORTESTDAYNAME5 = 0x00000064U,
    LOCALE_SSHORTESTDAYNAME6 = 0x00000065U,
    LOCALE_SSHORTESTDAYNAME7 = 0x00000066U,
}

enum : uint
{
    LOCALE_SISO639LANGNAME2  = 0x00000067U,
    LOCALE_SISO3166CTRYNAME2 = 0x00000068U,
}

enum : uint
{
    LOCALE_SNAN                 = 0x00000069U,
    LOCALE_SPOSINFINITY         = 0x0000006aU,
    LOCALE_SNEGINFINITY         = 0x0000006bU,
    LOCALE_SSCRIPTS             = 0x0000006cU,
    LOCALE_SPARENT              = 0x0000006dU,
    LOCALE_SCONSOLEFALLBACKNAME = 0x0000006eU,
}

enum uint LOCALE_IREADINGLAYOUT = 0x00000070U;

enum : uint
{
    LOCALE_INEUTRAL         = 0x00000071U,
    LOCALE_INEGATIVEPERCENT = 0x00000074U,
}

enum uint LOCALE_IPOSITIVEPERCENT = 0x00000075U;

enum : uint
{
    LOCALE_SPERCENT             = 0x00000076U,
    LOCALE_SPERMILLE            = 0x00000077U,
    LOCALE_SMONTHDAY            = 0x00000078U,
    LOCALE_SSHORTTIME           = 0x00000079U,
    LOCALE_SOPENTYPELANGUAGETAG = 0x0000007aU,
}

enum : uint
{
    LOCALE_SSORTLOCALE       = 0x0000007bU,
    LOCALE_SRELATIVELONGDATE = 0x0000007cU,
}

enum uint LOCALE_ICONSTRUCTEDLOCALE = 0x0000007dU;

enum : uint
{
    LOCALE_SSHORTESTAM = 0x0000007eU,
    LOCALE_SSHORTESTPM = 0x0000007fU,
}

enum : uint
{
    LOCALE_IUSEUTF8LEGACYACP   = 0x00000666U,
    LOCALE_IUSEUTF8LEGACYOEMCP = 0x00000999U,
}

enum : uint
{
    LOCALE_IDEFAULTCODEPAGE       = 0x0000000bU,
    LOCALE_IDEFAULTANSICODEPAGE   = 0x00001004U,
    LOCALE_IDEFAULTMACCODEPAGE    = 0x00001011U,
    LOCALE_IDEFAULTEBCDICCODEPAGE = 0x00001012U,
}

enum : uint
{
    LOCALE_ILANGUAGE       = 0x00000001U,
    LOCALE_SABBREVLANGNAME = 0x00000003U,
    LOCALE_SABBREVCTRYNAME = 0x00000007U,
}

enum : uint
{
    LOCALE_IGEOID           = 0x0000005bU,
    LOCALE_IDEFAULTLANGUAGE = 0x00000009U,
    LOCALE_IDEFAULTCOUNTRY  = 0x0000000aU,
}

enum uint LOCALE_IINTLCURRDIGITS = 0x0000001aU;

enum : uint
{
    LOCALE_SDATE         = 0x0000001dU,
    LOCALE_STIME         = 0x0000001eU,
    LOCALE_IDATE         = 0x00000021U,
    LOCALE_ILDATE        = 0x00000022U,
    LOCALE_ITIME         = 0x00000023U,
    LOCALE_ITIMEMARKPOSN = 0x00001005U,
}

enum : uint
{
    LOCALE_ICENTURY            = 0x00000024U,
    LOCALE_ITLZERO             = 0x00000025U,
    LOCALE_IDAYLZERO           = 0x00000026U,
    LOCALE_IMONLZERO           = 0x00000027U,
    LOCALE_SKEYBOARDSTOINSTALL = 0x0000005eU,
}

enum : uint
{
    LOCALE_SLANGUAGE        = 0x00000002U,
    LOCALE_SLANGDISPLAYNAME = 0x0000006fU,
}

enum : uint
{
    LOCALE_SENGLANGUAGE    = 0x00001001U,
    LOCALE_SNATIVELANGNAME = 0x00000004U,
}

enum : uint
{
    LOCALE_SCOUNTRY        = 0x00000006U,
    LOCALE_SENGCOUNTRY     = 0x00001002U,
    LOCALE_SNATIVECTRYNAME = 0x00000008U,
}

enum : uint
{
    LOCALE_ICOUNTRY = 0x00000005U,
    LOCALE_S1159    = 0x00000028U,
    LOCALE_S2359    = 0x00000029U,
}

enum uint CAL_NOUSEROVERRIDE = 0x80000000U;
enum uint CAL_USE_CP_ACP = 0x40000000U;

enum : uint
{
    CAL_RETURN_NUMBER         = 0x20000000U,
    CAL_RETURN_GENITIVE_NAMES = 0x10000000U,
}

enum uint CAL_ICALINTVALUE = 0x00000001U;
enum uint CAL_SCALNAME = 0x00000002U;
enum uint CAL_IYEAROFFSETRANGE = 0x00000003U;
enum uint CAL_SERASTRING = 0x00000004U;
enum uint CAL_SSHORTDATE = 0x00000005U;
enum uint CAL_SLONGDATE = 0x00000006U;

enum : uint
{
    CAL_SDAYNAME1 = 0x00000007U,
    CAL_SDAYNAME2 = 0x00000008U,
    CAL_SDAYNAME3 = 0x00000009U,
    CAL_SDAYNAME4 = 0x0000000aU,
    CAL_SDAYNAME5 = 0x0000000bU,
    CAL_SDAYNAME6 = 0x0000000cU,
    CAL_SDAYNAME7 = 0x0000000dU,
}

enum : uint
{
    CAL_SABBREVDAYNAME1 = 0x0000000eU,
    CAL_SABBREVDAYNAME2 = 0x0000000fU,
    CAL_SABBREVDAYNAME3 = 0x00000010U,
    CAL_SABBREVDAYNAME4 = 0x00000011U,
    CAL_SABBREVDAYNAME5 = 0x00000012U,
    CAL_SABBREVDAYNAME6 = 0x00000013U,
    CAL_SABBREVDAYNAME7 = 0x00000014U,
}

enum : uint
{
    CAL_SMONTHNAME1  = 0x00000015U,
    CAL_SMONTHNAME2  = 0x00000016U,
    CAL_SMONTHNAME3  = 0x00000017U,
    CAL_SMONTHNAME4  = 0x00000018U,
    CAL_SMONTHNAME5  = 0x00000019U,
    CAL_SMONTHNAME6  = 0x0000001aU,
    CAL_SMONTHNAME7  = 0x0000001bU,
    CAL_SMONTHNAME8  = 0x0000001cU,
    CAL_SMONTHNAME9  = 0x0000001dU,
    CAL_SMONTHNAME10 = 0x0000001eU,
    CAL_SMONTHNAME11 = 0x0000001fU,
    CAL_SMONTHNAME12 = 0x00000020U,
    CAL_SMONTHNAME13 = 0x00000021U,
}

enum : uint
{
    CAL_SABBREVMONTHNAME1  = 0x00000022U,
    CAL_SABBREVMONTHNAME2  = 0x00000023U,
    CAL_SABBREVMONTHNAME3  = 0x00000024U,
    CAL_SABBREVMONTHNAME4  = 0x00000025U,
    CAL_SABBREVMONTHNAME5  = 0x00000026U,
    CAL_SABBREVMONTHNAME6  = 0x00000027U,
    CAL_SABBREVMONTHNAME7  = 0x00000028U,
    CAL_SABBREVMONTHNAME8  = 0x00000029U,
    CAL_SABBREVMONTHNAME9  = 0x0000002aU,
    CAL_SABBREVMONTHNAME10 = 0x0000002bU,
    CAL_SABBREVMONTHNAME11 = 0x0000002cU,
    CAL_SABBREVMONTHNAME12 = 0x0000002dU,
    CAL_SABBREVMONTHNAME13 = 0x0000002eU,
}

enum uint CAL_SYEARMONTH = 0x0000002fU;
enum uint CAL_ITWODIGITYEARMAX = 0x00000030U;

enum : uint
{
    CAL_SSHORTESTDAYNAME1 = 0x00000031U,
    CAL_SSHORTESTDAYNAME2 = 0x00000032U,
    CAL_SSHORTESTDAYNAME3 = 0x00000033U,
    CAL_SSHORTESTDAYNAME4 = 0x00000034U,
    CAL_SSHORTESTDAYNAME5 = 0x00000035U,
    CAL_SSHORTESTDAYNAME6 = 0x00000036U,
    CAL_SSHORTESTDAYNAME7 = 0x00000037U,
}

enum uint CAL_SMONTHDAY = 0x00000038U;
enum uint CAL_SABBREVERASTRING = 0x00000039U;
enum uint CAL_SRELATIVELONGDATE = 0x0000003aU;

enum : uint
{
    CAL_SENGLISHERANAME       = 0x0000003bU,
    CAL_SENGLISHABBREVERANAME = 0x0000003cU,
}

enum uint CAL_SJAPANESEERAFIRSTYEAR = 0x0000003dU;
enum uint ENUM_ALL_CALENDARS = 0xffffffffU;

enum : uint
{
    CAL_GREGORIAN    = 0x00000001U,
    CAL_GREGORIAN_US = 0x00000002U,
}

enum : uint
{
    CAL_JAPAN  = 0x00000003U,
    CAL_TAIWAN = 0x00000004U,
}

enum : uint
{
    CAL_KOREA  = 0x00000005U,
    CAL_HIJRI  = 0x00000006U,
    CAL_THAI   = 0x00000007U,
    CAL_HEBREW = 0x00000008U,
}

enum : uint
{
    CAL_GREGORIAN_ME_FRENCH    = 0x00000009U,
    CAL_GREGORIAN_ARABIC       = 0x0000000aU,
    CAL_GREGORIAN_XLIT_ENGLISH = 0x0000000bU,
    CAL_GREGORIAN_XLIT_FRENCH  = 0x0000000cU,
}

enum uint CAL_PERSIAN = 0x00000016U;
enum uint CAL_UMALQURA = 0x00000017U;
enum uint LGRPID_WESTERN_EUROPE = 0x00000001U;
enum uint LGRPID_CENTRAL_EUROPE = 0x00000002U;

enum : uint
{
    LGRPID_BALTIC              = 0x00000003U,
    LGRPID_GREEK               = 0x00000004U,
    LGRPID_CYRILLIC            = 0x00000005U,
    LGRPID_TURKIC              = 0x00000006U,
    LGRPID_TURKISH             = 0x00000006U,
    LGRPID_JAPANESE            = 0x00000007U,
    LGRPID_KOREAN              = 0x00000008U,
    LGRPID_TRADITIONAL_CHINESE = 0x00000009U,
}

enum uint LGRPID_SIMPLIFIED_CHINESE = 0x0000000aU;

enum : uint
{
    LGRPID_THAI       = 0x0000000bU,
    LGRPID_HEBREW     = 0x0000000cU,
    LGRPID_ARABIC     = 0x0000000dU,
    LGRPID_VIETNAMESE = 0x0000000eU,
    LGRPID_INDIC      = 0x0000000fU,
    LGRPID_GEORGIAN   = 0x00000010U,
    LGRPID_ARMENIAN   = 0x00000011U,
}

enum : uint
{
    MUI_LANGUAGE_ID   = 0x00000004U,
    MUI_LANGUAGE_NAME = 0x00000008U,
}

enum uint MUI_MERGE_SYSTEM_FALLBACK = 0x00000010U;
enum uint MUI_MERGE_USER_FALLBACK = 0x00000020U;
enum uint MUI_THREAD_LANGUAGES = 0x00000040U;
enum uint MUI_CONSOLE_FILTER = 0x00000100U;
enum uint MUI_COMPLEX_SCRIPT_FILTER = 0x00000200U;
enum uint MUI_RESET_FILTERS = 0x00000001U;
enum uint MUI_USER_PREFERRED_UI_LANGUAGES = 0x00000010U;
enum uint MUI_USE_INSTALLED_LANGUAGES = 0x00000020U;
enum uint MUI_USE_SEARCH_ALL_LANGUAGES = 0x00000040U;
enum uint MUI_LANG_NEUTRAL_PE_FILE = 0x00000100U;
enum uint MUI_NON_LANG_NEUTRAL_FILE = 0x00000200U;
enum uint MUI_MACHINE_LANGUAGE_SETTINGS = 0x00000400U;
enum uint MUI_FILETYPE_NOT_LANGUAGE_NEUTRAL = 0x00000001U;

enum : uint
{
    MUI_FILETYPE_LANGUAGE_NEUTRAL_MAIN = 0x00000002U,
    MUI_FILETYPE_LANGUAGE_NEUTRAL_MUI  = 0x00000004U,
}

enum : uint
{
    MUI_QUERY_TYPE           = 0x00000001U,
    MUI_QUERY_CHECKSUM       = 0x00000002U,
    MUI_QUERY_LANGUAGE_NAME  = 0x00000004U,
    MUI_QUERY_RESOURCE_TYPES = 0x00000008U,
}

enum uint MUI_FILEINFO_VERSION = 0x00000001U;
enum uint MUI_FULL_LANGUAGE = 0x00000001U;
enum uint MUI_PARTIAL_LANGUAGE = 0x00000002U;
enum uint MUI_LIP_LANGUAGE = 0x00000004U;

enum : uint
{
    MUI_LANGUAGE_INSTALLED = 0x00000020U,
    MUI_LANGUAGE_LICENSED  = 0x00000040U,
}

enum int GEOID_NOT_AVAILABLE = 0xffffffff;

enum : uint
{
    SORTING_PARADIGM_NLS = 0x00000000U,
    SORTING_PARADIGM_ICU = 0x01000000U,
}

enum uint IDN_ALLOW_UNASSIGNED = 0x00000001U;
enum uint IDN_USE_STD3_ASCII_RULES = 0x00000002U;
enum uint IDN_EMAIL_ADDRESS = 0x00000004U;
enum uint IDN_RAW_PUNYCODE = 0x00000008U;
enum uint VS_ALLOW_LATIN = 0x00000001U;
enum uint GSS_ALLOW_INHERITED_COMMON = 0x00000001U;

enum : uint
{
    MUI_FORMAT_REG_COMPAT = 0x00000001U,
    MUI_FORMAT_INF_COMPAT = 0x00000002U,
}

enum uint MUI_VERIFY_FILE_EXISTS = 0x00000004U;
enum uint MUI_SKIP_STRING_CACHE = 0x00000008U;
enum uint MUI_IMMUTABLE_LOOKUP = 0x00000010U;

enum : const(wchar)*
{
    LOCALE_NAME_INVARIANT      = "",
    LOCALE_NAME_SYSTEM_DEFAULT = "!x-sys-default-locale",
}

enum uint MIN_SPELLING_NTDDI = 0x06020000U;
enum uint SCRIPT_UNDEFINED = 0x00000000U;
enum HRESULT USP_E_SCRIPT_NOT_IN_FONT = HRESULT(0x80040200);
enum uint SGCM_RTL = 0x00000001U;
enum uint SSA_PASSWORD = 0x00000001U;

enum : uint
{
    SSA_TAB      = 0x00000002U,
    SSA_CLIP     = 0x00000004U,
    SSA_FIT      = 0x00000008U,
    SSA_DZWG     = 0x00000010U,
    SSA_FALLBACK = 0x00000020U,
}

enum : uint
{
    SSA_BREAK  = 0x00000040U,
    SSA_GLYPHS = 0x00000080U,
}

enum : uint
{
    SSA_RTL    = 0x00000100U,
    SSA_GCP    = 0x00000200U,
    SSA_HOTKEY = 0x00000400U,
}

enum uint SSA_METAFILE = 0x00000800U;

enum : uint
{
    SSA_LINK       = 0x00001000U,
    SSA_HIDEHOTKEY = 0x00002000U,
}

enum uint SSA_HOTKEYONLY = 0x00002400U;
enum uint SSA_FULLMEASURE = 0x04000000U;
enum uint SSA_LPKANSIFALLBACK = 0x08000000U;

enum : uint
{
    SSA_PIDX      = 0x10000000U,
    SSA_LAYOUTRTL = 0x20000000U,
}

enum uint SSA_DONTGLYPH = 0x40000000U;
enum uint SSA_NOKASHIDA = 0x80000000U;

enum : uint
{
    SCRIPT_DIGITSUBSTITUTE_CONTEXT     = 0x00000000U,
    SCRIPT_DIGITSUBSTITUTE_NONE        = 0x00000001U,
    SCRIPT_DIGITSUBSTITUTE_NATIONAL    = 0x00000002U,
    SCRIPT_DIGITSUBSTITUTE_TRADITIONAL = 0x00000003U,
}

enum uint UNISCRIBE_OPENTYPE = 0x00000100U;
enum uint SCRIPT_TAG_UNKNOWN = 0x00000000U;
enum uint MUI_LANGUAGE_EXACT = 0x00000010U;

enum : uint
{
    NLS_CP_CPINFO = 0x10000000U,
    NLS_CP_MBTOWC = 0x40000000U,
    NLS_CP_WCTOMB = 0x80000000U,
}

enum uint U_DISABLE_RENAMING = 0x00000001U;
enum uint U_SHOW_CPLUSPLUS_API = 0x00000000U;
enum uint U_DEFAULT_SHOW_DRAFT = 0x00000000U;

enum : uint
{
    U_HIDE_DRAFT_API      = 0x00000001U,
    U_HIDE_DEPRECATED_API = 0x00000001U,
}

enum uint U_HIDE_OBSOLETE_API = 0x00000001U;
enum uint U_HIDE_INTERNAL_API = 0x00000001U;
enum uint U_NO_DEFAULT_INCLUDE_UTF_HEADERS = 0x00000001U;
enum uint U_DEBUG = 0x00000001U;
enum uint UCLN_NO_AUTO_CLEANUP = 0x00000001U;
enum uint U_OVERRIDE_CXX_ALLOCATION = 0x00000001U;
enum uint U_ENABLE_TRACING = 0x00000000U;
enum uint UCONFIG_ENABLE_PLUGINS = 0x00000000U;
enum uint U_ENABLE_DYLOAD = 0x00000001U;
enum uint U_CHECK_DYLOAD = 0x00000001U;
enum uint U_HAVE_LIB_SUFFIX = 0x00000001U;
// Native encoding: ansi
enum const(wchar)* U_LIB_SUFFIX_C_NAME_STRING = "";
enum uint UCONFIG_ONLY_COLLATION = 0x00000000U;

enum : uint
{
    UCONFIG_NO_BREAK_ITERATION     = 0x00000001U,
    UCONFIG_NO_IDNA                = 0x00000001U,
    UCONFIG_NO_FORMATTING          = 0x00000001U,
    UCONFIG_NO_TRANSLITERATION     = 0x00000001U,
    UCONFIG_NO_REGULAR_EXPRESSIONS = 0x00000001U,
}

enum : uint
{
    UCONFIG_NO_FILE_IO           = 0x00000000U,
    UCONFIG_NO_CONVERSION        = 0x00000000U,
    UCONFIG_NO_LEGACY_CONVERSION = 0x00000001U,
}

enum uint UCONFIG_ONLY_HTML_CONVERSION = 0x00000000U;

enum : uint
{
    UCONFIG_NO_NORMALIZATION   = 0x00000000U,
    UCONFIG_NO_COLLATION       = 0x00000001U,
    UCONFIG_NO_SERVICE         = 0x00000000U,
    UCONFIG_HAVE_PARSEALLINPUT = 0x00000001U,
}

enum uint UCONFIG_NO_FILTERED_BREAK_ITERATION = 0x00000000U;

enum : uint
{
    U_PF_UNKNOWN               = 0x00000000U,
    U_PF_WINDOWS               = 0x000003e8U,
    U_PF_MINGW                 = 0x00000708U,
    U_PF_CYGWIN                = 0x0000076cU,
    U_PF_HPUX                  = 0x00000834U,
    U_PF_SOLARIS               = 0x00000a28U,
    U_PF_BSD                   = 0x00000bb8U,
    U_PF_AIX                   = 0x00000c1cU,
    U_PF_IRIX                  = 0x00000c80U,
    U_PF_DARWIN                = 0x00000dacU,
    U_PF_IPHONE                = 0x00000ddeU,
    U_PF_QNX                   = 0x00000e74U,
    U_PF_LINUX                 = 0x00000fa0U,
    U_PF_BROWSER_NATIVE_CLIENT = 0x00000fb4U,
}

enum : uint
{
    U_PF_ANDROID    = 0x00000fd2U,
    U_PF_FUCHSIA    = 0x00001004U,
    U_PF_EMSCRIPTEN = 0x00001392U,
}

enum : uint
{
    U_PF_OS390 = 0x00002328U,
    U_PF_OS400 = 0x000024b8U,
}

enum : uint
{
    U_PLATFORM                     = 0x00000708U,
    U_PLATFORM_USES_ONLY_WIN32_API = 0x00000001U,
}

enum : uint
{
    U_PLATFORM_HAS_WIN32_API    = 0x00000001U,
    U_PLATFORM_IMPLEMENTS_POSIX = 0x00000000U,
    U_PLATFORM_IS_LINUX_BASED   = 0x00000001U,
    U_PLATFORM_IS_DARWIN_BASED  = 0x00000001U,
}

enum : uint
{
    U_HAVE_STDINT_H   = 0x00000001U,
    U_HAVE_INTTYPES_H = 0x00000001U,
}

enum uint U_GCC_MAJOR_MINOR = 0x00000000U;
enum uint U_IS_BIG_ENDIAN = 0x00000000U;
enum uint U_HAVE_PLACEMENT_NEW = 0x00000000U;
enum uint U_HAVE_DEBUG_LOCATION_NEW = 0x00000001U;
enum uint U_CPLUSPLUS_VERSION = 0x00000000U;
enum uint U_ASCII_FAMILY = 0x00000000U;
enum uint U_EBCDIC_FAMILY = 0x00000001U;

enum : uint
{
    U_CHARSET_FAMILY  = 0x00000001U,
    U_CHARSET_IS_UTF8 = 0x00000001U,
}

enum uint U_HAVE_WCHAR_H = 0x00000000U;
enum uint U_SIZEOF_WCHAR_T = 0x00000001U;

enum : uint
{
    U_HAVE_WCSCPY   = 0x00000000U,
    U_HAVE_CHAR16_T = 0x00000001U,
}

enum uint U_DEFINE_FALSE_AND_TRUE = 0x00000001U;
enum uint U_SIZEOF_UCHAR = 0x00000002U;
enum uint U_CHAR16_IS_TYPEDEF = 0x00000001U;
enum int U_SENTINEL = 0xffffffff;

enum : const(wchar)*
{
    // Native encoding: ansi
    U8_LEAD3_T1_BITS = " 00000000000000",
    // Native encoding: ansi
    U8_LEAD4_T1_BITS = "\0\0\0\0\0\0\0\0\0\0\0\0",
}

enum uint U8_MAX_LENGTH = 0x00000004U;
enum uint U16_MAX_LENGTH = 0x00000002U;
enum uint U_HIDE_OBSOLETE_UTF_OLD_H = 0x00000000U;
enum uint UTF_SIZE = 0x00000010U;

enum : uint
{
    UTF8_ERROR_VALUE_1 = 0x00000015U,
    UTF8_ERROR_VALUE_2 = 0x0000009fU,
}

enum uint UTF_ERROR_VALUE = 0x0000ffffU;
enum uint UTF8_MAX_CHAR_LENGTH = 0x00000004U;
enum uint UTF16_MAX_CHAR_LENGTH = 0x00000002U;
enum uint UTF32_MAX_CHAR_LENGTH = 0x00000001U;
enum uint UTF_MAX_CHAR_LENGTH = 0x00000002U;
enum uint U_COPYRIGHT_STRING_LENGTH = 0x00000080U;

enum : uint
{
    U_MAX_VERSION_LENGTH        = 0x00000004U,
    U_MAX_VERSION_STRING_LENGTH = 0x00000014U,
}

enum : uint
{
    U_MILLIS_PER_SECOND = 0x000003e8U,
    U_MILLIS_PER_MINUTE = 0x0000ea60U,
    U_MILLIS_PER_HOUR   = 0x0036ee80U,
    U_MILLIS_PER_DAY    = 0x05265c00U,
}

enum uint U_COMBINED_IMPLEMENTATION = 0x00000001U;
enum uint U_SHAPE_LENGTH_GROW_SHRINK = 0x00000000U;

enum : uint
{
    U_SHAPE_LAMALEF_RESIZE           = 0x00000000U,
    U_SHAPE_LENGTH_FIXED_SPACES_NEAR = 0x00000001U,
}

enum : uint
{
    U_SHAPE_LAMALEF_NEAR               = 0x00000001U,
    U_SHAPE_LENGTH_FIXED_SPACES_AT_END = 0x00000002U,
}

enum : uint
{
    U_SHAPE_LAMALEF_END                      = 0x00000002U,
    U_SHAPE_LENGTH_FIXED_SPACES_AT_BEGINNING = 0x00000003U,
}

enum : uint
{
    U_SHAPE_LAMALEF_BEGIN = 0x00000003U,
    U_SHAPE_LAMALEF_AUTO  = 0x00010000U,
    U_SHAPE_LENGTH_MASK   = 0x00010003U,
    U_SHAPE_LAMALEF_MASK  = 0x00010003U,
}

enum : uint
{
    U_SHAPE_TEXT_DIRECTION_LOGICAL    = 0x00000000U,
    U_SHAPE_TEXT_DIRECTION_VISUAL_RTL = 0x00000000U,
    U_SHAPE_TEXT_DIRECTION_VISUAL_LTR = 0x00000004U,
    U_SHAPE_TEXT_DIRECTION_MASK       = 0x00000004U,
}

enum : uint
{
    U_SHAPE_LETTERS_NOOP                    = 0x00000000U,
    U_SHAPE_LETTERS_SHAPE                   = 0x00000008U,
    U_SHAPE_LETTERS_UNSHAPE                 = 0x00000010U,
    U_SHAPE_LETTERS_SHAPE_TASHKEEL_ISOLATED = 0x00000018U,
    U_SHAPE_LETTERS_MASK                    = 0x00000018U,
}

enum : uint
{
    U_SHAPE_DIGITS_NOOP            = 0x00000000U,
    U_SHAPE_DIGITS_EN2AN           = 0x00000020U,
    U_SHAPE_DIGITS_AN2EN           = 0x00000040U,
    U_SHAPE_DIGITS_ALEN2AN_INIT_LR = 0x00000060U,
    U_SHAPE_DIGITS_ALEN2AN_INIT_AL = 0x00000080U,
    U_SHAPE_DIGITS_RESERVED        = 0x000000a0U,
    U_SHAPE_DIGITS_MASK            = 0x000000e0U,
    U_SHAPE_DIGIT_TYPE_AN          = 0x00000000U,
    U_SHAPE_DIGIT_TYPE_AN_EXTENDED = 0x00000100U,
    U_SHAPE_DIGIT_TYPE_RESERVED    = 0x00000200U,
    U_SHAPE_DIGIT_TYPE_MASK        = 0x00000300U,
}

enum : uint
{
    U_SHAPE_AGGREGATE_TASHKEEL      = 0x00004000U,
    U_SHAPE_AGGREGATE_TASHKEEL_NOOP = 0x00000000U,
    U_SHAPE_AGGREGATE_TASHKEEL_MASK = 0x00004000U,
}

enum : uint
{
    U_SHAPE_PRESERVE_PRESENTATION      = 0x00008000U,
    U_SHAPE_PRESERVE_PRESENTATION_NOOP = 0x00000000U,
    U_SHAPE_PRESERVE_PRESENTATION_MASK = 0x00008000U,
}

enum : uint
{
    U_SHAPE_SEEN_TWOCELL_NEAR     = 0x00200000U,
    U_SHAPE_SEEN_MASK             = 0x00700000U,
    U_SHAPE_YEHHAMZA_TWOCELL_NEAR = 0x01000000U,
    U_SHAPE_YEHHAMZA_MASK         = 0x03800000U,
}

enum : uint
{
    U_SHAPE_TASHKEEL_BEGIN              = 0x00040000U,
    U_SHAPE_TASHKEEL_END                = 0x00060000U,
    U_SHAPE_TASHKEEL_RESIZE             = 0x00080000U,
    U_SHAPE_TASHKEEL_REPLACE_BY_TATWEEL = 0x000c0000U,
    U_SHAPE_TASHKEEL_MASK               = 0x000e0000U,
}

enum : uint
{
    U_SHAPE_SPACES_RELATIVE_TO_TEXT_BEGIN_END = 0x04000000U,
    U_SHAPE_SPACES_RELATIVE_TO_TEXT_MASK      = 0x04000000U,
}

enum : uint
{
    U_SHAPE_TAIL_NEW_UNICODE = 0x08000000U,
    U_SHAPE_TAIL_TYPE_MASK   = 0x08000000U,
}

enum : const(wchar)*
{
    // Native encoding: ansi
    ULOC_CHINESE  = "zh",
    // Native encoding: ansi
    ULOC_ENGLISH  = "en",
    // Native encoding: ansi
    ULOC_FRENCH   = "fr",
    // Native encoding: ansi
    ULOC_GERMAN   = "de",
    // Native encoding: ansi
    ULOC_ITALIAN  = "it",
    // Native encoding: ansi
    ULOC_JAPANESE = "ja",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    ULOC_KOREAN             = "ko",
    // Native encoding: ansi
    ULOC_SIMPLIFIED_CHINESE = "zh_CN",
}

// Native encoding: ansi
enum const(wchar)* ULOC_TRADITIONAL_CHINESE = "zh_TW";

enum : const(wchar)*
{
    // Native encoding: ansi
    ULOC_CANADA        = "en_CA",
    // Native encoding: ansi
    ULOC_CANADA_FRENCH = "fr_CA",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    ULOC_CHINA   = "zh_CN",
    // Native encoding: ansi
    ULOC_PRC     = "zh_CN",
    // Native encoding: ansi
    ULOC_FRANCE  = "fr_FR",
    // Native encoding: ansi
    ULOC_GERMANY = "de_DE",
    // Native encoding: ansi
    ULOC_ITALY   = "it_IT",
    // Native encoding: ansi
    ULOC_JAPAN   = "ja_JP",
    // Native encoding: ansi
    ULOC_KOREA   = "ko_KR",
    // Native encoding: ansi
    ULOC_TAIWAN  = "zh_TW",
    // Native encoding: ansi
    ULOC_UK      = "en_GB",
    // Native encoding: ansi
    ULOC_US      = "en_US",
}

enum uint ULOC_LANG_CAPACITY = 0x0000000cU;
enum uint ULOC_COUNTRY_CAPACITY = 0x00000004U;
enum uint ULOC_FULLNAME_CAPACITY = 0x0000009dU;
enum uint ULOC_SCRIPT_CAPACITY = 0x00000006U;

enum : uint
{
    ULOC_KEYWORDS_CAPACITY              = 0x00000060U,
    ULOC_KEYWORD_AND_VALUES_CAPACITY    = 0x00000064U,
    ULOC_KEYWORD_SEPARATOR_UNICODE      = 0x00000040U,
    ULOC_KEYWORD_ASSIGN_UNICODE         = 0x0000003dU,
    ULOC_KEYWORD_ITEM_SEPARATOR_UNICODE = 0x0000003bU,
}

// Native encoding: ansi
enum const(wchar)* UCNV_SUB_STOP_ON_ILLEGAL = "i";
// Native encoding: ansi
enum const(wchar)* UCNV_SKIP_STOP_ON_ILLEGAL = "i";

enum : const(wchar)*
{
    // Native encoding: ansi
    UCNV_ESCAPE_JAVA    = "J",
    // Native encoding: ansi
    UCNV_ESCAPE_C       = "C",
    // Native encoding: ansi
    UCNV_ESCAPE_XML_DEC = "D",
    // Native encoding: ansi
    UCNV_ESCAPE_XML_HEX = "X",
    // Native encoding: ansi
    UCNV_ESCAPE_UNICODE = "U",
    // Native encoding: ansi
    UCNV_ESCAPE_CSS2    = "S",
}

enum uint UCNV_MAX_CONVERTER_NAME_LENGTH = 0x0000003cU;

enum : uint
{
    UCNV_SI = 0x0000000fU,
    UCNV_SO = 0x0000000eU,
}

// Native encoding: ansi
enum const(wchar)* UCNV_OPTION_SEP_STRING = ",";
// Native encoding: ansi
enum const(wchar)* UCNV_VALUE_SEP_STRING = "=";
// Native encoding: ansi
enum const(wchar)* UCNV_LOCALE_OPTION_STRING = ",locale=";
// Native encoding: ansi
enum const(wchar)* UCNV_VERSION_OPTION_STRING = ",version=";
// Native encoding: ansi
enum const(wchar)* UCNV_SWAP_LFNL_OPTION_STRING = ",swaplfnl";

enum : uint
{
    U_FOLD_CASE_DEFAULT           = 0x00000000U,
    U_FOLD_CASE_EXCLUDE_SPECIAL_I = 0x00000001U,
}

enum : uint
{
    U_TITLECASE_WHOLE_STRING        = 0x00000020U,
    U_TITLECASE_SENTENCES           = 0x00000040U,
    U_TITLECASE_NO_LOWERCASE        = 0x00000100U,
    U_TITLECASE_NO_BREAK_ADJUSTMENT = 0x00000200U,
}

enum uint U_TITLECASE_ADJUST_TO_CASED = 0x00000400U;
enum uint U_EDITS_NO_RESET = 0x00002000U;
enum uint U_OMIT_UNCHANGED_TEXT = 0x00004000U;
enum uint U_COMPARE_CODE_POINT_ORDER = 0x00008000U;
enum uint U_COMPARE_IGNORE_CASE = 0x00010000U;
enum uint UNORM_INPUT_IS_FCD = 0x00020000U;

enum : uint
{
    UCHAR_MIN_VALUE = 0x00000000U,
    UCHAR_MAX_VALUE = 0x0010ffffU,
}

enum : uint
{
    UBIDI_DEFAULT_LTR = 0x000000feU,
    UBIDI_DEFAULT_RTL = 0x000000ffU,
}

enum uint UBIDI_MAX_EXPLICIT_LEVEL = 0x0000007dU;
enum uint UBIDI_LEVEL_OVERRIDE = 0x00000080U;
enum int UBIDI_MAP_NOWHERE = 0xffffffff;
enum uint UBIDI_KEEP_BASE_COMBINING = 0x00000001U;
enum uint UBIDI_DO_MIRRORING = 0x00000002U;
enum uint UBIDI_INSERT_LRM_FOR_NUMERIC = 0x00000004U;
enum uint UBIDI_REMOVE_BIDI_CONTROLS = 0x00000008U;
enum uint UBIDI_OUTPUT_REVERSE = 0x00000010U;

enum : uint
{
    USPREP_DEFAULT          = 0x00000000U,
    USPREP_ALLOW_UNASSIGNED = 0x00000001U,
}

// Native encoding: ansi
enum const(wchar)* U_ICU_VERSION_BUNDLE = "icuver";
// Native encoding: ansi
enum const(wchar)* U_ICU_DATA_KEY = "DataVersion";
// Native encoding: ansi
enum const(wchar)* UCAL_UNKNOWN_ZONE_ID = "Etc/Unknown";

enum : const(wchar)*
{
    // Native encoding: ansi
    UDAT_YEAR         = "y",
    // Native encoding: ansi
    UDAT_QUARTER      = "QQQQ",
    // Native encoding: ansi
    UDAT_ABBR_QUARTER = "QQQ",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    UDAT_YEAR_QUARTER      = "yQQQQ",
    // Native encoding: ansi
    UDAT_YEAR_ABBR_QUARTER = "yQQQ",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    UDAT_MONTH      = "MMMM",
    // Native encoding: ansi
    UDAT_ABBR_MONTH = "MMM",
}

// Native encoding: ansi
enum const(wchar)* UDAT_NUM_MONTH = "M";

enum : const(wchar)*
{
    // Native encoding: ansi
    UDAT_YEAR_MONTH      = "yMMMM",
    // Native encoding: ansi
    UDAT_YEAR_ABBR_MONTH = "yMMM",
    // Native encoding: ansi
    UDAT_YEAR_NUM_MONTH  = "yM",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    UDAT_DAY                 = "d",
    // Native encoding: ansi
    UDAT_YEAR_MONTH_DAY      = "yMMMMd",
    // Native encoding: ansi
    UDAT_YEAR_ABBR_MONTH_DAY = "yMMMd",
    // Native encoding: ansi
    UDAT_YEAR_NUM_MONTH_DAY  = "yMd",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    UDAT_WEEKDAY      = "EEEE",
    // Native encoding: ansi
    UDAT_ABBR_WEEKDAY = "E",
}

// Native encoding: ansi
enum const(wchar)* UDAT_YEAR_MONTH_WEEKDAY_DAY = "yMMMMEEEEd";
// Native encoding: ansi
enum const(wchar)* UDAT_YEAR_ABBR_MONTH_WEEKDAY_DAY = "yMMMEd";
// Native encoding: ansi
enum const(wchar)* UDAT_YEAR_NUM_MONTH_WEEKDAY_DAY = "yMEd";
// Native encoding: ansi
enum const(wchar)* UDAT_MONTH_DAY = "MMMMd";
// Native encoding: ansi
enum const(wchar)* UDAT_ABBR_MONTH_DAY = "MMMd";
// Native encoding: ansi
enum const(wchar)* UDAT_NUM_MONTH_DAY = "Md";
// Native encoding: ansi
enum const(wchar)* UDAT_MONTH_WEEKDAY_DAY = "MMMMEEEEd";
// Native encoding: ansi
enum const(wchar)* UDAT_ABBR_MONTH_WEEKDAY_DAY = "MMMEd";
// Native encoding: ansi
enum const(wchar)* UDAT_NUM_MONTH_WEEKDAY_DAY = "MEd";

enum : const(wchar)*
{
    // Native encoding: ansi
    UDAT_HOUR          = "j",
    // Native encoding: ansi
    UDAT_HOUR24        = "H",
    // Native encoding: ansi
    UDAT_MINUTE        = "m",
    // Native encoding: ansi
    UDAT_HOUR_MINUTE   = "jm",
    // Native encoding: ansi
    UDAT_HOUR24_MINUTE = "Hm",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    UDAT_SECOND             = "s",
    // Native encoding: ansi
    UDAT_HOUR_MINUTE_SECOND = "jms",
}

// Native encoding: ansi
enum const(wchar)* UDAT_HOUR24_MINUTE_SECOND = "Hms";
// Native encoding: ansi
enum const(wchar)* UDAT_MINUTE_SECOND = "ms";
// Native encoding: ansi
enum const(wchar)* UDAT_LOCATION_TZ = "VVVV";
// Native encoding: ansi
enum const(wchar)* UDAT_GENERIC_TZ = "vvvv";
// Native encoding: ansi
enum const(wchar)* UDAT_ABBR_GENERIC_TZ = "v";
// Native encoding: ansi
enum const(wchar)* UDAT_SPECIFIC_TZ = "zzzz";

enum : const(wchar)*
{
    // Native encoding: ansi
    UDAT_ABBR_SPECIFIC_TZ = "z",
    // Native encoding: ansi
    UDAT_ABBR_UTC_TZ      = "ZZZZ",
}

enum int USEARCH_DONE = 0xffffffff;
enum uint U_HAVE_STD_STRING = 0x00000000U;
enum uint UCONFIG_FORMAT_FASTPATHS_49 = 0x00000001U;
enum uint U_PLATFORM_HAS_WINUWP_API = 0x00000000U;
enum uint U_IOSTREAM_SOURCE = 0x00030c1fU;
enum uint U_HAVE_RVALUE_REFERENCES = 0x00000001U;
enum uint U_USING_ICU_NAMESPACE = 0x00000001U;
// Native encoding: ansi
enum const(wchar)* U_ICUDATA_TYPE_LETTER = "e";
// Native encoding: ansi
enum const(wchar)* U_UNICODE_VERSION = "8.0";
enum uint CANITER_SKIP_ZEROES = 0x00000001U;
enum uint NUMSYS_NAME_CAPACITY = 0x00000008U;
enum uint U_HAVE_RBNF = 0x00000000U;

enum : uint
{
    MAX_MIMECP_NAME   = 0x00000040U,
    MAX_MIMECSET_NAME = 0x00000032U,
    MAX_MIMEFACE_NAME = 0x00000020U,
}

enum uint MAX_RFC1766_NAME = 0x00000006U;
enum uint MAX_LOCALE_NAME = 0x00000020U;
enum uint MAX_SCRIPT_NAME = 0x00000030U;

enum : int
{
    CPIOD_PEEK         = 0x40000000,
    CPIOD_FORCE_PROMPT = 0x80000000,
}

enum int UITER_UNKNOWN_INDEX = 0xfffffffe;

enum : int
{
    UCPTRIE_FAST_SHIFT             = 0x00000006,
    UCPTRIE_FAST_DATA_BLOCK_LENGTH = 0x00000040,
    UCPTRIE_FAST_DATA_MASK         = 0x0000003f,
}

enum : int
{
    UCPTRIE_SMALL_MAX                   = 0x00000fff,
    UCPTRIE_ERROR_VALUE_NEG_DATA_OFFSET = 0x00000001,
}

enum int UCPTRIE_HIGH_VALUE_NEG_DATA_OFFSET = 0x00000002;

enum : int
{
    UTEXT_PROVIDER_LENGTH_IS_EXPENSIVE = 0x00000001,
    UTEXT_PROVIDER_STABLE_CHUNKS       = 0x00000002,
    UTEXT_PROVIDER_WRITABLE            = 0x00000003,
    UTEXT_PROVIDER_HAS_META_DATA       = 0x00000004,
    UTEXT_PROVIDER_OWNS_TEXT           = 0x00000005,
}

enum int UTEXT_MAGIC = 0x345ad82c;
enum int USET_IGNORE_SPACE = 0x00000001;
enum int USET_CASE_INSENSITIVE = 0x00000002;
enum int USET_ADD_CASE_MAPPINGS = 0x00000004;
enum int USET_SERIALIZED_STATIC_ARRAY_CAPACITY = 0x00000008;
enum int U_PARSE_CONTEXT_LEN = 0x00000010;

enum : int
{
    UIDNA_DEFAULT        = 0x00000000,
    UIDNA_USE_STD3_RULES = 0x00000002,
}

enum : int
{
    UIDNA_CHECK_BIDI     = 0x00000004,
    UIDNA_CHECK_CONTEXTJ = 0x00000008,
}

enum : int
{
    UIDNA_NONTRANSITIONAL_TO_ASCII   = 0x00000010,
    UIDNA_NONTRANSITIONAL_TO_UNICODE = 0x00000020,
}

enum int UIDNA_CHECK_CONTEXTO = 0x00000040;

enum : int
{
    UIDNA_ERROR_EMPTY_LABEL          = 0x00000001,
    UIDNA_ERROR_LABEL_TOO_LONG       = 0x00000002,
    UIDNA_ERROR_DOMAIN_NAME_TOO_LONG = 0x00000004,
}

enum : int
{
    UIDNA_ERROR_LEADING_HYPHEN         = 0x00000008,
    UIDNA_ERROR_TRAILING_HYPHEN        = 0x00000010,
    UIDNA_ERROR_HYPHEN_3_4             = 0x00000020,
    UIDNA_ERROR_LEADING_COMBINING_MARK = 0x00000040,
}

enum : int
{
    UIDNA_ERROR_DISALLOWED           = 0x00000080,
    UIDNA_ERROR_PUNYCODE             = 0x00000100,
    UIDNA_ERROR_LABEL_HAS_DOT        = 0x00000200,
    UIDNA_ERROR_INVALID_ACE_LABEL    = 0x00000400,
    UIDNA_ERROR_BIDI                 = 0x00000800,
    UIDNA_ERROR_CONTEXTJ             = 0x00001000,
    UIDNA_ERROR_CONTEXTO_PUNCTUATION = 0x00002000,
    UIDNA_ERROR_CONTEXTO_DIGITS      = 0x00004000,
}

enum GUID ELS_GUID_LANGUAGE_DETECTION = GUID("cf7e00b1-909b-4d95-a8f4-611f7c377702");
enum GUID ELS_GUID_SCRIPT_DETECTION = GUID("2d64b439-6caf-4f6b-b688-e5d0f4faa7d7");

enum : GUID
{
    ELS_GUID_TRANSLITERATION_HANT_TO_HANS         = GUID("a3a8333b-f4fc-42f6-a0c4-0462fe7317cb"),
    ELS_GUID_TRANSLITERATION_HANS_TO_HANT         = GUID("3caccdc8-5590-42dc-9a7b-b5a6b5b3b63b"),
    ELS_GUID_TRANSLITERATION_MALAYALAM_TO_LATIN   = GUID("d8b983b1-f8bf-4a2b-bcd5-5b5ea20613e1"),
    ELS_GUID_TRANSLITERATION_DEVANAGARI_TO_LATIN  = GUID("c4a4dcfe-2661-4d02-9835-f48187109803"),
    ELS_GUID_TRANSLITERATION_CYRILLIC_TO_LATIN    = GUID("3dd12a98-5afd-4903-a13f-e17e6c0bfe01"),
    ELS_GUID_TRANSLITERATION_BENGALI_TO_LATIN     = GUID("f4dfd825-91a4-489f-855e-9ad9bee55727"),
    ELS_GUID_TRANSLITERATION_HANGUL_DECOMPOSITION = GUID("4ba2a721-e43d-41b7-b330-536ae1e48863"),
}

enum : int
{
    UMSGPAT_ARG_NAME_NOT_NUMBER = 0xffffffff,
    UMSGPAT_ARG_NAME_NOT_VALID  = 0xfffffffe,
}

// Callbacks

alias LOCALE_ENUMPROCA = BOOL function(PSTR param0);
alias LOCALE_ENUMPROCW = BOOL function(PWSTR param0);
alias LANGUAGEGROUP_ENUMPROCA = BOOL function(uint param0, PSTR param1, PSTR param2, uint param3, ptrdiff_t param4);
alias LANGGROUPLOCALE_ENUMPROCA = BOOL function(uint param0, uint param1, PSTR param2, ptrdiff_t param3);
alias UILANGUAGE_ENUMPROCA = BOOL function(PSTR param0, ptrdiff_t param1);
alias CODEPAGE_ENUMPROCA = BOOL function(PSTR param0);
alias DATEFMT_ENUMPROCA = BOOL function(PSTR param0);
alias DATEFMT_ENUMPROCEXA = BOOL function(PSTR param0, uint param1);
alias TIMEFMT_ENUMPROCA = BOOL function(PSTR param0);
alias CALINFO_ENUMPROCA = BOOL function(PSTR param0);
alias CALINFO_ENUMPROCEXA = BOOL function(PSTR param0, uint param1);
alias LANGUAGEGROUP_ENUMPROCW = BOOL function(uint param0, PWSTR param1, PWSTR param2, uint param3, 
                                              ptrdiff_t param4);
alias LANGGROUPLOCALE_ENUMPROCW = BOOL function(uint param0, uint param1, PWSTR param2, ptrdiff_t param3);
alias UILANGUAGE_ENUMPROCW = BOOL function(PWSTR param0, ptrdiff_t param1);
alias CODEPAGE_ENUMPROCW = BOOL function(PWSTR param0);
alias DATEFMT_ENUMPROCW = BOOL function(PWSTR param0);
alias DATEFMT_ENUMPROCEXW = BOOL function(PWSTR param0, uint param1);
alias TIMEFMT_ENUMPROCW = BOOL function(PWSTR param0);
alias CALINFO_ENUMPROCW = BOOL function(PWSTR param0);
alias CALINFO_ENUMPROCEXW = BOOL function(PWSTR param0, uint param1);
alias GEO_ENUMPROC = BOOL function(int param0);
alias GEO_ENUMNAMEPROC = BOOL function(PWSTR param0, LPARAM param1);
alias CALINFO_ENUMPROCEXEX = BOOL function(PWSTR param0, uint param1, PWSTR param2, LPARAM param3);
alias DATEFMT_ENUMPROCEXEX = BOOL function(PWSTR param0, uint param1, LPARAM param2);
alias TIMEFMT_ENUMPROCEX = BOOL function(PWSTR param0, LPARAM param1);
alias LOCALE_ENUMPROCEX = BOOL function(PWSTR param0, uint param1, LPARAM param2);
alias PFN_MAPPINGCALLBACKPROC = void function(MAPPING_PROPERTY_BAG* pBag, void* data, uint dwDataSize, 
                                              HRESULT Result);
alias UTraceEntry = void function(const(void)* context, int fnNumber);
alias UTraceExit = void function(const(void)* context, int fnNumber, const(PSTR) fmt, byte* args);
alias UTraceData = void function(const(void)* context, int fnNumber, int level, const(PSTR) fmt, byte* args);
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
alias UCPMapValueFilter = uint function(const(void)* context, uint value);
alias UConverterToUCallback = void function(const(void)* context, UConverterToUnicodeArgs* args, 
                                            const(PSTR) codeUnits, int length, UConverterCallbackReason reason, 
                                            UErrorCode* pErrorCode);
alias UConverterFromUCallback = void function(const(void)* context, UConverterFromUnicodeArgs* args, 
                                              const(ushort)* codeUnits, int length, int codePoint, 
                                              UConverterCallbackReason reason, UErrorCode* pErrorCode);
alias UMemAllocFn = void* function(const(void)* context, size_t size);
alias UMemReallocFn = void* function(const(void)* context, void* mem, size_t size);
alias UMemFreeFn = void function(const(void)* context, void* mem);
alias UCharEnumTypeRange = byte function(const(void)* context, int start, int limit, UCharCategory type);
alias UEnumCharNamesFn = byte function(void* context, int code, UCharNameChoice nameChoice, const(PSTR) name, 
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
alias UStringCaseMapper = int function(const(UCaseMap)* csm, ushort* dest, int destCapacity, const(ushort)* src, 
                                       int srcLength, UErrorCode* pErrorCode);

// Structs


//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HSAVEDUILANGUAGES
{
    void* Value;
}

struct UBiDi
{
    ptrdiff_t Value;
}

struct UBiDiTransform
{
    ptrdiff_t Value;
}

struct UBreakIterator
{
    ptrdiff_t Value;
}

struct UCaseMap
{
    ptrdiff_t Value;
}

struct UCharsetDetector
{
    ptrdiff_t Value;
}

struct UCharsetMatch
{
    ptrdiff_t Value;
}

struct UCollationElements
{
    ptrdiff_t Value;
}

struct UCollator
{
    ptrdiff_t Value;
}

struct UConstrainedFieldPosition
{
    ptrdiff_t Value;
}

struct UConverter
{
    ptrdiff_t Value;
}

struct UConverterSelector
{
    ptrdiff_t Value;
}

struct UCPMap
{
    ptrdiff_t Value;
}

struct UDateFormatSymbols
{
    ptrdiff_t Value;
}

struct UDateIntervalFormat
{
    ptrdiff_t Value;
}

struct UEnumeration
{
    ptrdiff_t Value;
}

struct UFieldPositionIterator
{
    ptrdiff_t Value;
}

struct UFormattedDateInterval
{
    ptrdiff_t Value;
}

struct UFormattedList
{
    ptrdiff_t Value;
}

struct UFormattedNumber
{
    ptrdiff_t Value;
}

struct UFormattedNumberRange
{
    ptrdiff_t Value;
}

struct UFormattedRelativeDateTime
{
    ptrdiff_t Value;
}

struct UFormattedValue
{
    ptrdiff_t Value;
}

struct UGenderInfo
{
    ptrdiff_t Value;
}

struct UHashtable
{
    ptrdiff_t Value;
}

struct UIDNA
{
    ptrdiff_t Value;
}

struct UListFormatter
{
    ptrdiff_t Value;
}

struct ULocaleData
{
    ptrdiff_t Value;
}

struct ULocaleDisplayNames
{
    ptrdiff_t Value;
}

struct UMutableCPTrie
{
    ptrdiff_t Value;
}

struct UNormalizer2
{
    ptrdiff_t Value;
}

struct UNumberFormatter
{
    ptrdiff_t Value;
}

struct UNumberRangeFormatter
{
    ptrdiff_t Value;
}

struct UNumberingSystem
{
    ptrdiff_t Value;
}

struct UPluralRules
{
    ptrdiff_t Value;
}

struct URegion
{
    ptrdiff_t Value;
}

struct URegularExpression
{
    ptrdiff_t Value;
}

struct URelativeDateTimeFormatter
{
    ptrdiff_t Value;
}

struct UResourceBundle
{
    ptrdiff_t Value;
}

struct USearch
{
    ptrdiff_t Value;
}

struct USet
{
    ptrdiff_t Value;
}

struct USpoofChecker
{
    ptrdiff_t Value;
}

struct USpoofCheckResult
{
    ptrdiff_t Value;
}

struct UStringPrepProfile
{
    ptrdiff_t Value;
}

struct UStringSearch
{
    ptrdiff_t Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-fontsignature
struct FONTSIGNATURE
{
    uint[4] fsUsb;
    uint[2] fsCsb;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-charsetinfo
struct CHARSETINFO
{
    uint          ciCharset;
    uint          ciACP;
    FONTSIGNATURE fs;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-localesignature
struct LOCALESIGNATURE
{
    uint[4] lsUsb;
    uint[2] lsCsbDefault;
    uint[2] lsCsbSupported;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-newtextmetricexa
struct NEWTEXTMETRICEXA
{
    NEWTEXTMETRICA ntmTm;
    FONTSIGNATURE  ntmFontSig;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-newtextmetricexw
struct NEWTEXTMETRICEXW
{
    NEWTEXTMETRICW ntmTm;
    FONTSIGNATURE  ntmFontSig;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-enumtextmetrica
struct ENUMTEXTMETRICA
{
    NEWTEXTMETRICEXA etmNewTextMetricEx;
    AXESLISTA        etmAxesList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-enumtextmetricw
struct ENUMTEXTMETRICW
{
    NEWTEXTMETRICEXW etmNewTextMetricEx;
    AXESLISTW        etmAxesList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnls/ns-winnls-cpinfo
struct CPINFO
{
    uint      MaxCharSize;
    ubyte[2]  DefaultChar;
    ubyte[12] LeadByte;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnls/ns-winnls-cpinfoexa
struct CPINFOEXA
{
    uint      MaxCharSize;
    ubyte[2]  DefaultChar;
    ubyte[12] LeadByte;
    wchar     UnicodeDefaultChar;
    uint      CodePage;
    CHAR[260] CodePageName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnls/ns-winnls-cpinfoexw
struct CPINFOEXW
{
    uint       MaxCharSize;
    ubyte[2]   DefaultChar;
    ubyte[12]  LeadByte;
    wchar      UnicodeDefaultChar;
    uint       CodePage;
    wchar[260] CodePageName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnls/ns-winnls-numberfmta
struct NUMBERFMTA
{
    uint NumDigits;
    uint LeadingZero;
    uint Grouping;
    PSTR lpDecimalSep;
    PSTR lpThousandSep;
    uint NegativeOrder;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnls/ns-winnls-numberfmtw
struct NUMBERFMTW
{
    uint  NumDigits;
    uint  LeadingZero;
    uint  Grouping;
    PWSTR lpDecimalSep;
    PWSTR lpThousandSep;
    uint  NegativeOrder;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnls/ns-winnls-currencyfmta
struct CURRENCYFMTA
{
    uint NumDigits;
    uint LeadingZero;
    uint Grouping;
    PSTR lpDecimalSep;
    PSTR lpThousandSep;
    uint NegativeOrder;
    uint PositiveOrder;
    PSTR lpCurrencySymbol;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnls/ns-winnls-currencyfmtw
struct CURRENCYFMTW
{
    uint  NumDigits;
    uint  LeadingZero;
    uint  Grouping;
    PWSTR lpDecimalSep;
    PWSTR lpThousandSep;
    uint  NegativeOrder;
    uint  PositiveOrder;
    PWSTR lpCurrencySymbol;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnls/ns-winnls-nlsversioninfo~r1
struct NLSVERSIONINFO
{
    uint dwNLSVersionInfoSize;
    uint dwNLSVersion;
    uint dwDefinedVersion;
    uint dwEffectiveId;
    GUID guidCustomVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnls/ns-winnls-nlsversioninfoex
struct NLSVERSIONINFOEX
{
    uint dwNLSVersionInfoSize;
    uint dwNLSVersion;
    uint dwDefinedVersion;
    uint dwEffectiveId;
    GUID guidCustomVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnls/ns-winnls-filemuiinfo
struct FILEMUIINFO
{
    uint      dwSize;
    uint      dwVersion;
    uint      dwFileType;
    ubyte[16] pChecksum;
    ubyte[16] pServiceChecksum;
    uint      dwLanguageNameOffset;
    uint      dwTypeIDMainSize;
    uint      dwTypeIDMainOffset;
    uint      dwTypeNameMainOffset;
    uint      dwTypeIDMUISize;
    uint      dwTypeIDMUIOffset;
    uint      dwTypeNameMUIOffset;
    ubyte[8]  abBuffer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/elscore/ns-elscore-mapping_service_info
struct MAPPING_SERVICE_INFO
{
    size_t Size;
    PWSTR  pszCopyright;
    ushort wMajorVersion;
    ushort wMinorVersion;
    ushort wBuildVersion;
    ushort wStepVersion;
    uint   dwInputContentTypesCount;
    PWSTR* prgInputContentTypes;
    uint   dwOutputContentTypesCount;
    PWSTR* prgOutputContentTypes;
    uint   dwInputLanguagesCount;
    PWSTR* prgInputLanguages;
    uint   dwOutputLanguagesCount;
    PWSTR* prgOutputLanguages;
    uint   dwInputScriptsCount;
    PWSTR* prgInputScripts;
    uint   dwOutputScriptsCount;
    PWSTR* prgOutputScripts;
    GUID   guid;
    PWSTR  pszCategory;
    PWSTR  pszDescription;
    uint   dwPrivateDataSize;
    void*  pPrivateData;
    void*  pContext;
    // Native bit field: IsOneToOneLanguageMapping: [0], HasSubservices: [1], OnlineOnly: [2], ServiceType: [3-4]
    uint   _bitfield0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/elscore/ns-elscore-mapping_enum_options
struct MAPPING_ENUM_OPTIONS
{
    size_t Size;
    PWSTR  pszCategory;
    PWSTR  pszInputLanguage;
    PWSTR  pszOutputLanguage;
    PWSTR  pszInputScript;
    PWSTR  pszOutputScript;
    PWSTR  pszInputContentType;
    PWSTR  pszOutputContentType;
    GUID*  pGuid;
    // Native bit field: OnlineService: [0-1], ServiceType: [2-3]
    uint   _bitfield0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/elscore/ns-elscore-mapping_options
struct MAPPING_OPTIONS
{
    size_t Size;
    PWSTR  pszInputLanguage;
    PWSTR  pszOutputLanguage;
    PWSTR  pszInputScript;
    PWSTR  pszOutputScript;
    PWSTR  pszInputContentType;
    PWSTR  pszOutputContentType;
    PWSTR  pszUILanguage;
    PFN_MAPPINGCALLBACKPROC pfnRecognizeCallback;
    void*  pRecognizeCallerData;
    uint   dwRecognizeCallerDataSize;
    PFN_MAPPINGCALLBACKPROC pfnActionCallback;
    void*  pActionCallerData;
    uint   dwActionCallerDataSize;
    uint   dwServiceFlag;
    // Native bit field: GetActionDisplayName: [0]
    uint   _bitfield0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/elscore/ns-elscore-mapping_data_range
struct MAPPING_DATA_RANGE
{
    uint   dwStartIndex;
    uint   dwEndIndex;
    PWSTR  pszDescription;
    uint   dwDescriptionLength;
    void*  pData;
    uint   dwDataSize;
    PWSTR  pszContentType;
    PWSTR* prgActionIds;
    uint   dwActionsCount;
    PWSTR* prgActionDisplayNames;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/elscore/ns-elscore-mapping_property_bag
struct MAPPING_PROPERTY_BAG
{
    size_t              Size;
    MAPPING_DATA_RANGE* prgResultRanges;
    uint                dwRangesCount;
    void*               pServiceData;
    uint                dwServiceDataSize;
    void*               pCallerData;
    uint                dwCallerDataSize;
    void*               pContext;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/usp10/ns-usp10-script_control
struct SCRIPT_CONTROL
{
    // Native bit field: uDefaultLanguage: [0-15], fContextDigits: [16], fInvertPreBoundDir: [17], fInvertPostBoundDir: [18], fLinkStringBefore: [19], fLinkStringAfter: [20], fNeutralOverride: [21], fNumericOverride: [22], fLegacyBidiClass: [23], fMergeNeutralItems: [24], fUseStandardBidi: [25], fReserved: [26-31]
    uint _bitfield0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/usp10/ns-usp10-script_state
struct SCRIPT_STATE
{
    // Native bit field: uBidiLevel: [0-4], fOverrideDirection: [5], fInhibitSymSwap: [6], fCharShape: [7], fDigitSubstitute: [8], fInhibitLigate: [9], fDisplayZWG: [10], fArabicNumContext: [11], fGcpClusters: [12], fReserved: [13], fEngineReserved: [14-15]
    ushort _bitfield0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/usp10/ns-usp10-script_analysis
struct SCRIPT_ANALYSIS
{
    // Native bit field: eScript: [0-9], fRTL: [10], fLayoutRTL: [11], fLinkBefore: [12], fLinkAfter: [13], fLogicalOrder: [14], fNoGlyphIndex: [15]
    ushort       _bitfield0;
    SCRIPT_STATE s;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/usp10/ns-usp10-script_item
struct SCRIPT_ITEM
{
    int             iCharPos;
    SCRIPT_ANALYSIS a;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/usp10/ns-usp10-script_visattr
struct SCRIPT_VISATTR
{
    // Native bit field: uJustification: [0-3], fClusterStart: [4], fDiacritic: [5], fZeroWidth: [6], fReserved: [7], fShapeReserved: [8-15]
    ushort _bitfield0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/usp10/ns-usp10-goffset
struct GOFFSET
{
    int du;
    int dv;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/usp10/ns-usp10-script_logattr
struct SCRIPT_LOGATTR
{
    // Native bit field: fSoftBreak: [0], fWhiteSpace: [1], fCharStop: [2], fWordStop: [3], fInvalid: [4], fReserved: [5-7]
    ubyte _bitfield0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/usp10/ns-usp10-script_properties
struct SCRIPT_PROPERTIES
{
    // Native bit field: langid: [0-15], fNumeric: [16], fComplex: [17], fNeedsWordBreaking: [18], fNeedsCaretInfo: [19], bCharSet: [20-27], fControl: [28], fPrivateUseArea: [29], fNeedsCharacterJustify: [30], fInvalidGlyph: [31]
    uint _bitfield1;
    // Native bit field: fInvalidLogAttr: [0], fCDM: [1], fAmbiguousCharSet: [2], fClusterSizeVaries: [3], fRejectInvalid: [4]
    uint _bitfield2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/usp10/ns-usp10-script_fontproperties
struct SCRIPT_FONTPROPERTIES
{
    int    cBytes;
    ushort wgBlank;
    ushort wgDefault;
    ushort wgInvalid;
    ushort wgKashida;
    int    iKashidaWidth;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/usp10/ns-usp10-script_tabdef
struct SCRIPT_TABDEF
{
    int  cTabStops;
    int  iScale;
    int* pTabStops;
    int  iTabOrigin;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/usp10/ns-usp10-script_digitsubstitute
struct SCRIPT_DIGITSUBSTITUTE
{
    // Native bit field: NationalDigitLanguage: [0-15], TraditionalDigitLanguage: [16-31]
    uint _bitfield1;
    // Native bit field: DigitSubstitute: [0-7]
    uint _bitfield2;
    uint dwReserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/usp10/ns-usp10-opentype_feature_record
struct OPENTYPE_FEATURE_RECORD
{
    uint tagFeature;
    int  lParameter;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/usp10/ns-usp10-textrange_properties
struct TEXTRANGE_PROPERTIES
{
    OPENTYPE_FEATURE_RECORD* potfRecords;
    int cotfRecords;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/usp10/ns-usp10-script_charprop
struct SCRIPT_CHARPROP
{
    // Native bit field: fCanGlyphAlone: [0], reserved: [1-15]
    ushort _bitfield0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/usp10/ns-usp10-script_glyphprop
struct SCRIPT_GLYPHPROP
{
    SCRIPT_VISATTR sva;
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
    const(void)*         context;
    int                  length;
    int                  start;
    int                  index;
    int                  limit;
    int                  reservedField;
    UCharIteratorGetIndex getIndex;
    UCharIteratorMove    move;
    UCharIteratorHasNext hasNext;
    UCharIteratorHasPrevious hasPrevious;
    UCharIteratorCurrent current;
    UCharIteratorNext    next;
    UCharIteratorPrevious previous;
    UCharIteratorReserved reservedFn;
    UCharIteratorGetState getState;
    UCharIteratorSetState setState;
}

union UCPTrieData
{
    const(void)*   ptr0;
    const(ushort)* ptr16;
    const(uint)*   ptr32;
    const(ubyte)*  ptr8;
}

struct UCPTrie
{
    const(ushort)* index;
    UCPTrieData    data;
    int            indexLength;
    int            dataLength;
    int            highStart;
    ushort         shifted12HighStart;
    byte           type;
    byte           valueWidth;
    uint           reserved32;
    ushort         reserved16;
    ushort         index3NullOffset;
    int            dataNullOffset;
    uint           nullValue;
}

struct UConverterFromUnicodeArgs
{
    ushort         size;
    byte           flush;
    UConverter*    converter;
    const(ushort)* source;
    const(ushort)* sourceLimit;
    PSTR           target;
    const(PSTR)    targetLimit;
    int*           offsets;
}

struct UConverterToUnicodeArgs
{
    ushort         size;
    byte           flush;
    UConverter*    converter;
    const(PSTR)    source;
    const(PSTR)    sourceLimit;
    ushort*        target;
    const(ushort)* targetLimit;
    int*           offsets;
}

struct UTextFuncs
{
    int               tableSize;
    int               reserved1;
    int               reserved2;
    int               reserved3;
    UTextClone        clone;
    UTextNativeLength nativeLength;
    UTextAccess       access;
    UTextExtract      extract;
    UTextReplace      replace;
    UTextCopy         copy;
    UTextMapOffsetToNative mapOffsetToNative;
    UTextMapNativeIndexToUTF16 mapNativeIndexToUTF16;
    UTextClose        close;
    UTextClose        spare1;
    UTextClose        spare2;
    UTextClose        spare3;
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

struct UParseError
{
    int        line;
    int        offset;
    ushort[16] preContext;
    ushort[16] postContext;
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

struct UTransPosition
{
    int contextStart;
    int contextLimit;
    int start;
    int limit;
}

struct MIMECPINFO
{
    uint      dwFlags;
    uint      uiCodePage;
    uint      uiFamilyCodePage;
    wchar[64] wszDescription;
    wchar[50] wszWebCharset;
    wchar[50] wszHeaderCharset;
    wchar[50] wszBodyCharset;
    wchar[32] wszFixedWidthFont;
    wchar[32] wszProportionalFont;
    ubyte     bGDICharset;
}

struct MIMECSETINFO
{
    uint      uiCodePage;
    uint      uiInternetEncoding;
    wchar[50] wszCharset;
}

struct RFC1766INFO
{
    uint      lcid;
    wchar[6]  wszRfc1766;
    wchar[32] wszLocaleName;
}

struct SCRIPTINFO
{
    ubyte     ScriptId;
    uint      uiCodePage;
    wchar[48] wszDescription;
    wchar[32] wszFixedWidthFont;
    wchar[32] wszProportionalFont;
}

struct DetectEncodingInfo
{
    uint nLangID;
    uint nCodePage;
    int  nDocPercent;
    int  nConfidence;
}

struct SCRIPTFONTINFO
{
    long      scripts;
    wchar[32] wszFont;
}

struct UNICODERANGE
{
    wchar wcFrom;
    wchar wcTo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Intl/caldatetime
struct CALDATETIME
{
    uint CalId;
    uint Era;
    uint Year;
    uint Month;
    uint Day;
    uint DayOfWeek;
    uint Hour;
    uint Minute;
    uint Second;
    uint Tick;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
int GetTextCharset(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
int GetTextCharsetInfo(HDC hdc, FONTSIGNATURE* lpSig, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
BOOL TranslateCharsetInfo(uint* lpSrc, CHARSETINFO* lpCs, TRANSLATE_CHARSET_INFO_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int GetDateFormatA(uint Locale, uint dwFlags, const(SYSTEMTIME)* lpDate, const(PSTR) lpFormat, PSTR lpDateStr, 
                   int cchDate);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int GetDateFormatW(uint Locale, uint dwFlags, const(SYSTEMTIME)* lpDate, const(PWSTR) lpFormat, PWSTR lpDateStr, 
                   int cchDate);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int GetTimeFormatA(uint Locale, uint dwFlags, const(SYSTEMTIME)* lpTime, const(PSTR) lpFormat, PSTR lpTimeStr, 
                   int cchTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int GetTimeFormatW(uint Locale, uint dwFlags, const(SYSTEMTIME)* lpTime, const(PWSTR) lpFormat, PWSTR lpTimeStr, 
                   int cchTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
int GetTimeFormatEx(const(PWSTR) lpLocaleName, TIME_FORMAT_FLAGS dwFlags, const(SYSTEMTIME)* lpTime, 
                    const(PWSTR) lpFormat, PWSTR lpTimeStr, int cchTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
int GetDateFormatEx(const(PWSTR) lpLocaleName, ENUM_DATE_FORMATS_FLAGS dwFlags, const(SYSTEMTIME)* lpDate, 
                    const(PWSTR) lpFormat, PWSTR lpDateStr, int cchDate, const(PWSTR) lpCalendar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
int GetDurationFormatEx(const(PWSTR) lpLocaleName, uint dwFlags, const(SYSTEMTIME)* lpDuration, ulong ullDuration, 
                        const(PWSTR) lpFormat, PWSTR lpDurationStr, int cchDuration);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
COMPARESTRING_RESULT CompareStringEx(const(PWSTR) lpLocaleName, COMPARE_STRING_FLAGS dwCmpFlags, 
                                     const(PWSTR) lpString1, int cchCount1, const(PWSTR) lpString2, int cchCount2, 
                                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/NLSVERSIONINFO* lpVersionInformation, 
                                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpReserved, 
                                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
COMPARESTRING_RESULT CompareStringOrdinal(const(PWSTR) lpString1, int cchCount1, const(PWSTR) lpString2, 
                                          int cchCount2, BOOL bIgnoreCase);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
COMPARESTRING_RESULT CompareStringW(uint Locale, uint dwCmpFlags, const(PWSTR) lpString1, int cchCount1, 
                                    const(PWSTR) lpString2, int cchCount2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int FoldStringW(FOLD_STRING_MAP_FLAGS dwMapFlags, const(PWSTR) lpSrcStr, int cchSrc, PWSTR lpDestStr, int cchDest);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetStringTypeExW(uint Locale, uint dwInfoType, const(PWSTR) lpSrcStr, int cchSrc, ushort* lpCharType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetStringTypeW(uint dwInfoType, const(PWSTR) lpSrcStr, int cchSrc, ushort* lpCharType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int MultiByteToWideChar(uint CodePage, MULTI_BYTE_TO_WIDE_CHAR_FLAGS dwFlags, 
                        /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/const(PSTR) lpMultiByteStr, 
                        int cbMultiByte, PWSTR lpWideCharStr, int cchWideChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int WideCharToMultiByte(uint CodePage, uint dwFlags, const(PWSTR) lpWideCharStr, int cchWideChar, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/PSTR lpMultiByteStr, 
                        int cbMultiByte, 
                        /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/const(PSTR) lpDefaultChar, 
                        BOOL* lpUsedDefaultChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL IsValidCodePage(uint CodePage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetACP();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetOEMCP();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetCPInfo(uint CodePage, CPINFO* lpCPInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetCPInfoExA(uint CodePage, uint dwFlags, CPINFOEXA* lpCPInfoEx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetCPInfoExW(uint CodePage, uint dwFlags, CPINFOEXW* lpCPInfoEx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
COMPARESTRING_RESULT CompareStringA(uint Locale, uint dwCmpFlags, byte* lpString1, int cchCount1, byte* lpString2, 
                                    int cchCount2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
int FindNLSString(uint Locale, uint dwFindNLSStringFlags, const(PWSTR) lpStringSource, int cchSource, 
                  const(PWSTR) lpStringValue, int cchValue, int* pcchFound);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int LCMapStringW(uint Locale, uint dwMapFlags, const(PWSTR) lpSrcStr, int cchSrc, PWSTR lpDestStr, int cchDest);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int LCMapStringA(uint Locale, uint dwMapFlags, const(PSTR) lpSrcStr, int cchSrc, PSTR lpDestStr, int cchDest);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int GetLocaleInfoW(uint Locale, uint LCType, PWSTR lpLCData, int cchData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int GetLocaleInfoA(uint Locale, uint LCType, PSTR lpLCData, int cchData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL SetLocaleInfoA(uint Locale, uint LCType, const(PSTR) lpLCData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL SetLocaleInfoW(uint Locale, uint LCType, const(PWSTR) lpLCData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int GetCalendarInfoA(uint Locale, uint Calendar, uint CalType, PSTR lpCalData, int cchData, uint* lpValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int GetCalendarInfoW(uint Locale, uint Calendar, uint CalType, PWSTR lpCalData, int cchData, uint* lpValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL SetCalendarInfoA(uint Locale, uint Calendar, uint CalType, const(PSTR) lpCalData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL SetCalendarInfoW(uint Locale, uint Calendar, uint CalType, const(PWSTR) lpCalData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL IsDBCSLeadByte(ubyte TestChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL IsDBCSLeadByteEx(uint CodePage, ubyte TestChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
uint LocaleNameToLCID(const(PWSTR) lpName, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
int LCIDToLocaleName(uint Locale, PWSTR lpName, int cchName, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
int GetDurationFormat(uint Locale, uint dwFlags, const(SYSTEMTIME)* lpDuration, ulong ullDuration, 
                      const(PWSTR) lpFormat, PWSTR lpDurationStr, int cchDuration);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int GetNumberFormatA(uint Locale, uint dwFlags, const(PSTR) lpValue, const(NUMBERFMTA)* lpFormat, PSTR lpNumberStr, 
                     int cchNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int GetNumberFormatW(uint Locale, uint dwFlags, const(PWSTR) lpValue, const(NUMBERFMTW)* lpFormat, 
                     PWSTR lpNumberStr, int cchNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int GetCurrencyFormatA(uint Locale, uint dwFlags, const(PSTR) lpValue, const(CURRENCYFMTA)* lpFormat, 
                       PSTR lpCurrencyStr, int cchCurrency);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int GetCurrencyFormatW(uint Locale, uint dwFlags, const(PWSTR) lpValue, const(CURRENCYFMTW)* lpFormat, 
                       PWSTR lpCurrencyStr, int cchCurrency);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumCalendarInfoA(CALINFO_ENUMPROCA lpCalInfoEnumProc, uint Locale, uint Calendar, uint CalType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumCalendarInfoW(CALINFO_ENUMPROCW lpCalInfoEnumProc, uint Locale, uint Calendar, uint CalType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumCalendarInfoExA(CALINFO_ENUMPROCEXA lpCalInfoEnumProcEx, uint Locale, uint Calendar, uint CalType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumCalendarInfoExW(CALINFO_ENUMPROCEXW lpCalInfoEnumProcEx, uint Locale, uint Calendar, uint CalType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumTimeFormatsA(TIMEFMT_ENUMPROCA lpTimeFmtEnumProc, uint Locale, TIME_FORMAT_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumTimeFormatsW(TIMEFMT_ENUMPROCW lpTimeFmtEnumProc, uint Locale, TIME_FORMAT_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumDateFormatsA(DATEFMT_ENUMPROCA lpDateFmtEnumProc, uint Locale, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumDateFormatsW(DATEFMT_ENUMPROCW lpDateFmtEnumProc, uint Locale, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumDateFormatsExA(DATEFMT_ENUMPROCEXA lpDateFmtEnumProcEx, uint Locale, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumDateFormatsExW(DATEFMT_ENUMPROCEXW lpDateFmtEnumProcEx, uint Locale, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL IsValidLanguageGroup(uint LanguageGroup, ENUM_SYSTEM_LANGUAGE_GROUPS_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetNLSVersion(uint Function, uint Locale, NLSVERSIONINFO* lpVersionInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL IsValidLocale(uint Locale, IS_VALID_LOCALE_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
int GetGeoInfoA(int Location, SYSGEOTYPE GeoType, PSTR lpGeoData, int cchData, ushort LangId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
int GetGeoInfoW(int Location, SYSGEOTYPE GeoType, PWSTR lpGeoData, int cchData, ushort LangId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("KERNEL32.dll")
int GetGeoInfoEx(PWSTR location, SYSGEOTYPE geoType, PWSTR geoData, int geoDataCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL EnumSystemGeoID(uint GeoClass, int ParentGeoId, GEO_ENUMPROC lpGeoEnumProc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("KERNEL32.dll")
BOOL EnumSystemGeoNames(uint geoClass, GEO_ENUMNAMEPROC geoEnumProc, LPARAM data);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
int GetUserGeoID(SYSGEOCLASS GeoClass);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("KERNEL32.dll")
int GetUserDefaultGeoName(PWSTR geoName, int geoNameCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetUserGeoID(int GeoId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("KERNEL32.dll")
BOOL SetUserGeoName(PWSTR geoName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint ConvertDefaultLocale(uint Locale);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
ushort GetSystemDefaultUILanguage();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetThreadLocale();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL SetThreadLocale(uint Locale);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
ushort GetUserDefaultUILanguage();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
ushort GetUserDefaultLangID();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
ushort GetSystemDefaultLangID();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetSystemDefaultLCID();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetUserDefaultLCID();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
ushort SetThreadUILanguage(ushort LangId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
ushort GetThreadUILanguage();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
BOOL GetProcessPreferredUILanguages(uint dwFlags, uint* pulNumLanguages, 
                                    /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR pwszLanguagesBuffer, 
                                    uint* pcchLanguagesBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
BOOL SetProcessPreferredUILanguages(uint dwFlags, 
                                    /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/const(PWSTR) pwszLanguagesBuffer, 
                                    uint* pulNumLanguages);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetUserPreferredUILanguages(uint dwFlags, uint* pulNumLanguages, 
                                 /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR pwszLanguagesBuffer, 
                                 uint* pcchLanguagesBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetSystemPreferredUILanguages(uint dwFlags, uint* pulNumLanguages, 
                                   /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR pwszLanguagesBuffer, 
                                   uint* pcchLanguagesBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetThreadPreferredUILanguages(uint dwFlags, uint* pulNumLanguages, 
                                   /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR pwszLanguagesBuffer, 
                                   uint* pcchLanguagesBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL SetThreadPreferredUILanguages(uint dwFlags, 
                                   /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/const(PWSTR) pwszLanguagesBuffer, 
                                   uint* pulNumLanguages);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetFileMUIInfo(uint dwFlags, const(PWSTR) pcwszFilePath, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/FILEMUIINFO* pFileMUIInfo, 
                    uint* pcbFileMUIInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetFileMUIPath(uint dwFlags, const(PWSTR) pcwszFilePath, PWSTR pwszLanguage, uint* pcchLanguage, 
                    PWSTR pwszFileMUIPath, uint* pcchFileMUIPath, ulong* pululEnumerator);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetUILanguageInfo(uint dwFlags, 
                       /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/const(PWSTR) pwmszLanguage, 
                       /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR pwszFallbackLanguages, 
                       uint* pcchFallbackLanguages, uint* pAttributes);

@DllImport("KERNEL32.dll")
BOOL SetThreadPreferredUILanguages2(uint flags, 
                                    /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/const(PWSTR) languages, 
                                    uint* numLanguagesSet, HSAVEDUILANGUAGES* snapshot);

@DllImport("KERNEL32.dll")
void RestoreThreadPreferredUILanguages(const(HSAVEDUILANGUAGES) snapshot);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
BOOL NotifyUILanguageChange(uint dwFlags, const(PWSTR) pcwstrNewLanguage, const(PWSTR) pcwstrPreviousLanguage, 
                            /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved, 
                            uint* pdwStatusRtrn);

@DllImport("KERNEL32.dll")
BOOL GetStringTypeExA(uint Locale, uint dwInfoType, const(PSTR) lpSrcStr, int cchSrc, ushort* lpCharType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL GetStringTypeA(uint Locale, uint dwInfoType, const(PSTR) lpSrcStr, int cchSrc, ushort* lpCharType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int FoldStringA(FOLD_STRING_MAP_FLAGS dwMapFlags, const(PSTR) lpSrcStr, int cchSrc, PSTR lpDestStr, int cchDest);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumSystemLocalesA(LOCALE_ENUMPROCA lpLocaleEnumProc, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumSystemLocalesW(LOCALE_ENUMPROCW lpLocaleEnumProc, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumSystemLanguageGroupsA(LANGUAGEGROUP_ENUMPROCA lpLanguageGroupEnumProc, 
                               ENUM_SYSTEM_LANGUAGE_GROUPS_FLAGS dwFlags, ptrdiff_t lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumSystemLanguageGroupsW(LANGUAGEGROUP_ENUMPROCW lpLanguageGroupEnumProc, 
                               ENUM_SYSTEM_LANGUAGE_GROUPS_FLAGS dwFlags, ptrdiff_t lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumLanguageGroupLocalesA(LANGGROUPLOCALE_ENUMPROCA lpLangGroupLocaleEnumProc, uint LanguageGroup, 
                               uint dwFlags, ptrdiff_t lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumLanguageGroupLocalesW(LANGGROUPLOCALE_ENUMPROCW lpLangGroupLocaleEnumProc, uint LanguageGroup, 
                               uint dwFlags, ptrdiff_t lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumUILanguagesA(UILANGUAGE_ENUMPROCA lpUILanguageEnumProc, uint dwFlags, ptrdiff_t lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumUILanguagesW(UILANGUAGE_ENUMPROCW lpUILanguageEnumProc, uint dwFlags, ptrdiff_t lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumSystemCodePagesA(CODEPAGE_ENUMPROCA lpCodePageEnumProc, ENUM_SYSTEM_CODE_PAGES_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL EnumSystemCodePagesW(CODEPAGE_ENUMPROCW lpCodePageEnumProc, ENUM_SYSTEM_CODE_PAGES_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NORMALIZ.dll")
int IdnToAscii(uint dwFlags, const(PWSTR) lpUnicodeCharStr, int cchUnicodeChar, PWSTR lpASCIICharStr, 
               int cchASCIIChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NORMALIZ.dll")
int IdnToUnicode(uint dwFlags, const(PWSTR) lpASCIICharStr, int cchASCIIChar, PWSTR lpUnicodeCharStr, 
                 int cchUnicodeChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
int IdnToNameprepUnicode(uint dwFlags, const(PWSTR) lpUnicodeCharStr, int cchUnicodeChar, PWSTR lpNameprepCharStr, 
                         int cchNameprepChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
int NormalizeString(NORM_FORM NormForm, const(PWSTR) lpSrcString, int cwSrcLength, PWSTR lpDstString, 
                    int cwDstLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL IsNormalizedString(NORM_FORM NormForm, const(PWSTR) lpString, int cwLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL VerifyScripts(uint dwFlags, const(PWSTR) lpLocaleScripts, int cchLocaleScripts, const(PWSTR) lpTestScripts, 
                   int cchTestScripts);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
int GetStringScripts(uint dwFlags, const(PWSTR) lpString, int cchString, PWSTR lpScripts, int cchScripts);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
int GetLocaleInfoEx(const(PWSTR) lpLocaleName, uint LCType, PWSTR lpLCData, int cchData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
int GetCalendarInfoEx(const(PWSTR) lpLocaleName, uint Calendar, 
                      /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(PWSTR) lpReserved, 
                      uint CalType, PWSTR lpCalData, int cchData, uint* lpValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
int GetNumberFormatEx(const(PWSTR) lpLocaleName, uint dwFlags, const(PWSTR) lpValue, const(NUMBERFMTW)* lpFormat, 
                      PWSTR lpNumberStr, int cchNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int GetCurrencyFormatEx(const(PWSTR) lpLocaleName, uint dwFlags, const(PWSTR) lpValue, 
                        const(CURRENCYFMTW)* lpFormat, PWSTR lpCurrencyStr, int cchCurrency);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
int GetUserDefaultLocaleName(PWSTR lpLocaleName, int cchLocaleName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
int GetSystemDefaultLocaleName(PWSTR lpLocaleName, int cchLocaleName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL IsNLSDefinedString(uint Function, uint dwFlags, NLSVERSIONINFO* lpVersionInformation, const(PWSTR) lpString, 
                        int cchStr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL GetNLSVersionEx(uint function_, const(PWSTR) lpLocaleName, NLSVERSIONINFOEX* lpVersionInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
uint IsValidNLSVersion(uint function_, const(PWSTR) lpLocaleName, NLSVERSIONINFOEX* lpVersionInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
int FindNLSStringEx(const(PWSTR) lpLocaleName, uint dwFindNLSStringFlags, const(PWSTR) lpStringSource, 
                    int cchSource, const(PWSTR) lpStringValue, int cchValue, int* pcchFound, 
                    NLSVERSIONINFO* lpVersionInformation, 
                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpReserved, 
                    LPARAM sortHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
int LCMapStringEx(const(PWSTR) lpLocaleName, uint dwMapFlags, const(PWSTR) lpSrcStr, int cchSrc, PWSTR lpDestStr, 
                  int cchDest, NLSVERSIONINFO* lpVersionInformation, 
                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpReserved, LPARAM sortHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL IsValidLocaleName(const(PWSTR) lpLocaleName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL EnumCalendarInfoExEx(CALINFO_ENUMPROCEXEX pCalInfoEnumProcExEx, const(PWSTR) lpLocaleName, uint Calendar, 
                          /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(PWSTR) lpReserved, 
                          uint CalType, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL EnumDateFormatsExEx(DATEFMT_ENUMPROCEXEX lpDateFmtEnumProcExEx, const(PWSTR) lpLocaleName, 
                         ENUM_DATE_FORMATS_FLAGS dwFlags, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL EnumTimeFormatsEx(TIMEFMT_ENUMPROCEX lpTimeFmtEnumProcEx, const(PWSTR) lpLocaleName, uint dwFlags, 
                       LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL EnumSystemLocalesEx(LOCALE_ENUMPROCEX lpLocaleEnumProcEx, uint dwFlags, LPARAM lParam, 
                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
int ResolveLocaleName(const(PWSTR) lpNameToResolve, PWSTR lpLocaleName, int cchLocaleName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("elscore.dll")
HRESULT MappingGetServices(MAPPING_ENUM_OPTIONS* pOptions, MAPPING_SERVICE_INFO** prgServices, 
                           uint* pdwServicesCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("elscore.dll")
HRESULT MappingFreeServices(MAPPING_SERVICE_INFO* pServiceInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("elscore.dll")
HRESULT MappingRecognizeText(MAPPING_SERVICE_INFO* pServiceInfo, const(PWSTR) pszText, uint dwLength, uint dwIndex, 
                             MAPPING_OPTIONS* pOptions, MAPPING_PROPERTY_BAG* pbag);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("elscore.dll")
HRESULT MappingDoAction(MAPPING_PROPERTY_BAG* pBag, uint dwRangeIndex, const(PWSTR) pszActionId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("elscore.dll")
HRESULT MappingFreePropertyBag(MAPPING_PROPERTY_BAG* pBag);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptFreeCache(void** psc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptItemize(const(PWSTR) pwcInChars, int cInChars, int cMaxItems, const(SCRIPT_CONTROL)* psControl, 
                      const(SCRIPT_STATE)* psState, SCRIPT_ITEM* pItems, int* pcItems);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptLayout(int cRuns, const(ubyte)* pbLevel, int* piVisualToLogical, int* piLogicalToVisual);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptShape(HDC hdc, void** psc, const(PWSTR) pwcChars, int cChars, int cMaxGlyphs, SCRIPT_ANALYSIS* psa, 
                    ushort* pwOutGlyphs, ushort* pwLogClust, SCRIPT_VISATTR* psva, int* pcGlyphs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptPlace(HDC hdc, void** psc, const(ushort)* pwGlyphs, int cGlyphs, const(SCRIPT_VISATTR)* psva, 
                    SCRIPT_ANALYSIS* psa, int* piAdvance, GOFFSET* pGoffset, ABC* pABC);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptTextOut(const(HDC) hdc, void** psc, int x, int y, uint fuOptions, const(RECT)* lprc, 
                      const(SCRIPT_ANALYSIS)* psa, 
                      /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(PWSTR) pwcReserved, 
                      /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/int iReserved, 
                      const(ushort)* pwGlyphs, int cGlyphs, const(int)* piAdvance, const(int)* piJustify, 
                      const(GOFFSET)* pGoffset);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptJustify(const(SCRIPT_VISATTR)* psva, const(int)* piAdvance, int cGlyphs, int iDx, int iMinKashida, 
                      int* piJustify);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptBreak(const(PWSTR) pwcChars, int cChars, const(SCRIPT_ANALYSIS)* psa, SCRIPT_LOGATTR* psla);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptCPtoX(int iCP, BOOL fTrailing, int cChars, int cGlyphs, const(ushort)* pwLogClust, 
                    const(SCRIPT_VISATTR)* psva, const(int)* piAdvance, const(SCRIPT_ANALYSIS)* psa, int* piX);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptXtoCP(int iX, int cChars, int cGlyphs, const(ushort)* pwLogClust, const(SCRIPT_VISATTR)* psva, 
                    const(int)* piAdvance, const(SCRIPT_ANALYSIS)* psa, int* piCP, int* piTrailing);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptGetLogicalWidths(const(SCRIPT_ANALYSIS)* psa, int cChars, int cGlyphs, const(int)* piGlyphWidth, 
                               const(ushort)* pwLogClust, const(SCRIPT_VISATTR)* psva, int* piDx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptApplyLogicalWidth(const(int)* piDx, int cChars, int cGlyphs, const(ushort)* pwLogClust, 
                                const(SCRIPT_VISATTR)* psva, const(int)* piAdvance, const(SCRIPT_ANALYSIS)* psa, 
                                ABC* pABC, int* piJustify);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptGetCMap(HDC hdc, void** psc, const(PWSTR) pwcInChars, int cChars, uint dwFlags, ushort* pwOutGlyphs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptGetGlyphABCWidth(HDC hdc, void** psc, ushort wGlyph, ABC* pABC);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptGetProperties(const(SCRIPT_PROPERTIES)*** ppSp, int* piNumScripts);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptGetFontProperties(HDC hdc, void** psc, SCRIPT_FONTPROPERTIES* sfp);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptCacheGetHeight(HDC hdc, void** psc, int* tmHeight);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptStringAnalyse(HDC hdc, const(void)* pString, int cString, int cGlyphs, int iCharset, uint dwFlags, 
                            int iReqWidth, SCRIPT_CONTROL* psControl, SCRIPT_STATE* psState, const(int)* piDx, 
                            SCRIPT_TABDEF* pTabdef, const(ubyte)* pbInClass, void** pssa);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptStringFree(void** pssa);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
SIZE* ScriptString_pSize(void* ssa);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
int* ScriptString_pcOutChars(void* ssa);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
SCRIPT_LOGATTR* ScriptString_pLogAttr(void* ssa);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptStringGetOrder(void* ssa, uint* puOrder);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptStringCPtoX(void* ssa, int icp, BOOL fTrailing, int* pX);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptStringXtoCP(void* ssa, int iX, int* piCh, int* piTrailing);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptStringGetLogicalWidths(void* ssa, int* piDx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptStringValidate(void* ssa);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptStringOut(void* ssa, int iX, int iY, ETO_OPTIONS uOptions, const(RECT)* prc, int iMinSel, 
                        int iMaxSel, BOOL fDisabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptIsComplex(const(PWSTR) pwcInChars, int cInChars, SCRIPT_IS_COMPLEX_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptRecordDigitSubstitution(uint Locale, SCRIPT_DIGITSUBSTITUTE* psds);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USP10.dll")
HRESULT ScriptApplyDigitSubstitution(const(SCRIPT_DIGITSUBSTITUTE)* psds, SCRIPT_CONTROL* psc, SCRIPT_STATE* pss);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USP10.dll")
HRESULT ScriptShapeOpenType(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, 
                            int* rcRangeChars, TEXTRANGE_PROPERTIES** rpRangeProperties, int cRanges, 
                            const(PWSTR) pwcChars, int cChars, int cMaxGlyphs, ushort* pwLogClust, 
                            SCRIPT_CHARPROP* pCharProps, ushort* pwOutGlyphs, SCRIPT_GLYPHPROP* pOutGlyphProps, 
                            int* pcGlyphs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USP10.dll")
HRESULT ScriptPlaceOpenType(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, 
                            int* rcRangeChars, TEXTRANGE_PROPERTIES** rpRangeProperties, int cRanges, 
                            const(PWSTR) pwcChars, ushort* pwLogClust, SCRIPT_CHARPROP* pCharProps, int cChars, 
                            const(ushort)* pwGlyphs, const(SCRIPT_GLYPHPROP)* pGlyphProps, int cGlyphs, 
                            int* piAdvance, GOFFSET* pGoffset, ABC* pABC);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USP10.dll")
HRESULT ScriptItemizeOpenType(const(PWSTR) pwcInChars, int cInChars, int cMaxItems, 
                              const(SCRIPT_CONTROL)* psControl, const(SCRIPT_STATE)* psState, SCRIPT_ITEM* pItems, 
                              uint* pScriptTags, int* pcItems);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USP10.dll")
HRESULT ScriptGetFontScriptTags(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, int cMaxTags, uint* pScriptTags, 
                                int* pcTags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USP10.dll")
HRESULT ScriptGetFontLanguageTags(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, int cMaxTags, 
                                  uint* pLangsysTags, int* pcTags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USP10.dll")
HRESULT ScriptGetFontFeatureTags(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, 
                                 int cMaxTags, uint* pFeatureTags, int* pcTags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USP10.dll")
HRESULT ScriptGetFontAlternateGlyphs(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, 
                                     uint tagFeature, ushort wGlyphId, int cMaxAlternates, ushort* pAlternateGlyphs, 
                                     int* pcAlternates);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USP10.dll")
HRESULT ScriptSubstituteSingleGlyph(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, 
                                    uint tagFeature, int lParameter, ushort wGlyphId, ushort* pwOutGlyphId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USP10.dll")
HRESULT ScriptPositionSingleGlyph(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, 
                                  uint tagFeature, int lParameter, ushort wGlyphId, int iAdvance, GOFFSET GOffset, 
                                  int* piOutAdvance, GOFFSET* pOutGoffset);

@DllImport("icuuc.dll")
int utf8_nextCharSafeBody(const(ubyte)* s, int* pi, int length, int c, byte strict);

@DllImport("icuuc.dll")
int utf8_appendCharSafeBody(ubyte* s, int i, int length, int c, byte* pIsError);

@DllImport("icuuc.dll")
int utf8_prevCharSafeBody(const(ubyte)* s, int start, int* pi, int c, byte strict);

@DllImport("icuuc.dll")
int utf8_back1SafeBody(const(ubyte)* s, int start, int i);

@DllImport("icuuc.dll")
void u_versionFromString(ubyte* versionArray, const(PSTR) versionString);

@DllImport("icuuc.dll")
void u_versionFromUString(ubyte* versionArray, const(ushort)* versionString);

@DllImport("icuuc.dll")
void u_versionToString(const(ubyte)* versionArray, PSTR versionString);

@DllImport("icuuc.dll")
void u_getVersion(ubyte* versionArray);

@DllImport("icuuc.dll")
PSTR u_errorName(UErrorCode code);

@DllImport("icuuc.dll")
void utrace_setLevel(int traceLevel);

@DllImport("icuuc.dll")
int utrace_getLevel();

@DllImport("icuuc.dll")
void utrace_setFunctions(const(void)* context, UTraceEntry e, UTraceExit x, UTraceData d);

@DllImport("icuuc.dll")
void utrace_getFunctions(const(void)** context, UTraceEntry* e, UTraceExit* x, UTraceData* d);

@DllImport("icuuc.dll")
int utrace_vformat(PSTR outBuf, int capacity, int indent, const(PSTR) fmt, byte* args);

@DllImport("icuuc.dll")
int utrace_format(PSTR outBuf, int capacity, int indent, const(PSTR) fmt);

@DllImport("icuuc.dll")
PSTR utrace_functionName(int fnNumber);

@DllImport("icuuc.dll")
int u_shapeArabic(const(ushort)* source, int sourceLength, ushort* dest, int destSize, uint options, 
                  UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int uscript_getCode(const(PSTR) nameOrAbbrOrLocale, UScriptCode* fillIn, int capacity, UErrorCode* err);

@DllImport("icuuc.dll")
PSTR uscript_getName(UScriptCode scriptCode);

@DllImport("icuuc.dll")
PSTR uscript_getShortName(UScriptCode scriptCode);

@DllImport("icuuc.dll")
UScriptCode uscript_getScript(int codepoint, UErrorCode* err);

@DllImport("icuuc.dll")
byte uscript_hasScript(int c, UScriptCode sc);

@DllImport("icuuc.dll")
int uscript_getScriptExtensions(int c, UScriptCode* scripts, int capacity, UErrorCode* errorCode);

@DllImport("icuuc.dll")
int uscript_getSampleString(UScriptCode script, ushort* dest, int capacity, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
UScriptUsage uscript_getUsage(UScriptCode script);

@DllImport("icuuc.dll")
byte uscript_isRightToLeft(UScriptCode script);

@DllImport("icuuc.dll")
byte uscript_breaksBetweenLetters(UScriptCode script);

@DllImport("icuuc.dll")
byte uscript_isCased(UScriptCode script);

@DllImport("icuuc.dll")
int uiter_current32(UCharIterator* iter);

@DllImport("icuuc.dll")
int uiter_next32(UCharIterator* iter);

@DllImport("icuuc.dll")
int uiter_previous32(UCharIterator* iter);

@DllImport("icuuc.dll")
uint uiter_getState(const(UCharIterator)* iter);

@DllImport("icuuc.dll")
void uiter_setState(UCharIterator* iter, uint state, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
void uiter_setString(UCharIterator* iter, const(ushort)* s, int length);

@DllImport("icuuc.dll")
void uiter_setUTF16BE(UCharIterator* iter, const(PSTR) s, int length);

@DllImport("icuuc.dll")
void uiter_setUTF8(UCharIterator* iter, const(PSTR) s, int length);

@DllImport("icuuc.dll")
void uenum_close(UEnumeration* en);

@DllImport("icuuc.dll")
int uenum_count(UEnumeration* en, UErrorCode* status);

@DllImport("icuuc.dll")
ushort* uenum_unext(UEnumeration* en, int* resultLength, UErrorCode* status);

@DllImport("icuuc.dll")
PSTR uenum_next(UEnumeration* en, int* resultLength, UErrorCode* status);

@DllImport("icuuc.dll")
void uenum_reset(UEnumeration* en, UErrorCode* status);

@DllImport("icuuc.dll")
UEnumeration* uenum_openUCharStringsEnumeration(const(ushort)** strings, int count, UErrorCode* ec);

@DllImport("icuuc.dll")
UEnumeration* uenum_openCharStringsEnumeration(const(byte)** strings, int count, UErrorCode* ec);

@DllImport("icuuc.dll")
PSTR uloc_getDefault();

@DllImport("icuuc.dll")
void uloc_setDefault(const(PSTR) localeID, UErrorCode* status);

@DllImport("icuuc.dll")
int uloc_getLanguage(const(PSTR) localeID, PSTR language, int languageCapacity, UErrorCode* err);

@DllImport("icuuc.dll")
int uloc_getScript(const(PSTR) localeID, PSTR script, int scriptCapacity, UErrorCode* err);

@DllImport("icuuc.dll")
int uloc_getCountry(const(PSTR) localeID, PSTR country, int countryCapacity, UErrorCode* err);

@DllImport("icuuc.dll")
int uloc_getVariant(const(PSTR) localeID, PSTR variant, int variantCapacity, UErrorCode* err);

@DllImport("icuuc.dll")
int uloc_getName(const(PSTR) localeID, PSTR name, int nameCapacity, UErrorCode* err);

@DllImport("icuuc.dll")
int uloc_canonicalize(const(PSTR) localeID, PSTR name, int nameCapacity, UErrorCode* err);

@DllImport("icuuc.dll")
PSTR uloc_getISO3Language(const(PSTR) localeID);

@DllImport("icuuc.dll")
PSTR uloc_getISO3Country(const(PSTR) localeID);

@DllImport("icuuc.dll")
uint uloc_getLCID(const(PSTR) localeID);

@DllImport("icuuc.dll")
int uloc_getDisplayLanguage(const(PSTR) locale, const(PSTR) displayLocale, ushort* language, int languageCapacity, 
                            UErrorCode* status);

@DllImport("icuuc.dll")
int uloc_getDisplayScript(const(PSTR) locale, const(PSTR) displayLocale, ushort* script, int scriptCapacity, 
                          UErrorCode* status);

@DllImport("icuuc.dll")
int uloc_getDisplayCountry(const(PSTR) locale, const(PSTR) displayLocale, ushort* country, int countryCapacity, 
                           UErrorCode* status);

@DllImport("icuuc.dll")
int uloc_getDisplayVariant(const(PSTR) locale, const(PSTR) displayLocale, ushort* variant, int variantCapacity, 
                           UErrorCode* status);

@DllImport("icuuc.dll")
int uloc_getDisplayKeyword(const(PSTR) keyword, const(PSTR) displayLocale, ushort* dest, int destCapacity, 
                           UErrorCode* status);

@DllImport("icuuc.dll")
int uloc_getDisplayKeywordValue(const(PSTR) locale, const(PSTR) keyword, const(PSTR) displayLocale, ushort* dest, 
                                int destCapacity, UErrorCode* status);

@DllImport("icuuc.dll")
int uloc_getDisplayName(const(PSTR) localeID, const(PSTR) inLocaleID, ushort* result, int maxResultSize, 
                        UErrorCode* err);

@DllImport("icuuc.dll")
PSTR uloc_getAvailable(int n);

@DllImport("icuuc.dll")
int uloc_countAvailable();

@DllImport("icu.dll")
UEnumeration* uloc_openAvailableByType(ULocAvailableType type, UErrorCode* status);

@DllImport("icuuc.dll")
byte** uloc_getISOLanguages();

@DllImport("icuuc.dll")
byte** uloc_getISOCountries();

@DllImport("icuuc.dll")
int uloc_getParent(const(PSTR) localeID, PSTR parent, int parentCapacity, UErrorCode* err);

@DllImport("icuuc.dll")
int uloc_getBaseName(const(PSTR) localeID, PSTR name, int nameCapacity, UErrorCode* err);

@DllImport("icuuc.dll")
UEnumeration* uloc_openKeywords(const(PSTR) localeID, UErrorCode* status);

@DllImport("icuuc.dll")
int uloc_getKeywordValue(const(PSTR) localeID, const(PSTR) keywordName, PSTR buffer, int bufferCapacity, 
                         UErrorCode* status);

@DllImport("icuuc.dll")
int uloc_setKeywordValue(const(PSTR) keywordName, const(PSTR) keywordValue, PSTR buffer, int bufferCapacity, 
                         UErrorCode* status);

@DllImport("icuuc.dll")
byte uloc_isRightToLeft(const(PSTR) locale);

@DllImport("icuuc.dll")
ULayoutType uloc_getCharacterOrientation(const(PSTR) localeId, UErrorCode* status);

@DllImport("icuuc.dll")
ULayoutType uloc_getLineOrientation(const(PSTR) localeId, UErrorCode* status);

@DllImport("icuuc.dll")
int uloc_acceptLanguageFromHTTP(PSTR result, int resultAvailable, UAcceptResult* outResult, 
                                const(PSTR) httpAcceptLanguage, UEnumeration* availableLocales, UErrorCode* status);

@DllImport("icuuc.dll")
int uloc_acceptLanguage(PSTR result, int resultAvailable, UAcceptResult* outResult, const(byte)** acceptList, 
                        int acceptListCount, UEnumeration* availableLocales, UErrorCode* status);

@DllImport("icuuc.dll")
int uloc_getLocaleForLCID(uint hostID, PSTR locale, int localeCapacity, UErrorCode* status);

@DllImport("icuuc.dll")
int uloc_addLikelySubtags(const(PSTR) localeID, PSTR maximizedLocaleID, int maximizedLocaleIDCapacity, 
                          UErrorCode* err);

@DllImport("icuuc.dll")
int uloc_minimizeSubtags(const(PSTR) localeID, PSTR minimizedLocaleID, int minimizedLocaleIDCapacity, 
                         UErrorCode* err);

@DllImport("icuuc.dll")
int uloc_forLanguageTag(const(PSTR) langtag, PSTR localeID, int localeIDCapacity, int* parsedLength, 
                        UErrorCode* err);

@DllImport("icuuc.dll")
int uloc_toLanguageTag(const(PSTR) localeID, PSTR langtag, int langtagCapacity, byte strict, UErrorCode* err);

@DllImport("icuuc.dll")
PSTR uloc_toUnicodeLocaleKey(const(PSTR) keyword);

@DllImport("icuuc.dll")
PSTR uloc_toUnicodeLocaleType(const(PSTR) keyword, const(PSTR) value);

@DllImport("icuuc.dll")
PSTR uloc_toLegacyKey(const(PSTR) keyword);

@DllImport("icuuc.dll")
PSTR uloc_toLegacyType(const(PSTR) keyword, const(PSTR) value);

@DllImport("icuuc.dll")
UResourceBundle* ures_open(const(PSTR) packageName, const(PSTR) locale, UErrorCode* status);

@DllImport("icuuc.dll")
UResourceBundle* ures_openDirect(const(PSTR) packageName, const(PSTR) locale, UErrorCode* status);

@DllImport("icuuc.dll")
UResourceBundle* ures_openU(const(ushort)* packageName, const(PSTR) locale, UErrorCode* status);

@DllImport("icuuc.dll")
void ures_close(UResourceBundle* resourceBundle);

@DllImport("icuuc.dll")
void ures_getVersion(const(UResourceBundle)* resB, ubyte* versionInfo);

@DllImport("icuuc.dll")
PSTR ures_getLocaleByType(const(UResourceBundle)* resourceBundle, ULocDataLocaleType type, UErrorCode* status);

@DllImport("icuuc.dll")
ushort* ures_getString(const(UResourceBundle)* resourceBundle, int* len, UErrorCode* status);

@DllImport("icuuc.dll")
PSTR ures_getUTF8String(const(UResourceBundle)* resB, PSTR dest, int* length, byte forceCopy, UErrorCode* status);

@DllImport("icuuc.dll")
ubyte* ures_getBinary(const(UResourceBundle)* resourceBundle, int* len, UErrorCode* status);

@DllImport("icuuc.dll")
int* ures_getIntVector(const(UResourceBundle)* resourceBundle, int* len, UErrorCode* status);

@DllImport("icuuc.dll")
uint ures_getUInt(const(UResourceBundle)* resourceBundle, UErrorCode* status);

@DllImport("icuuc.dll")
int ures_getInt(const(UResourceBundle)* resourceBundle, UErrorCode* status);

@DllImport("icuuc.dll")
int ures_getSize(const(UResourceBundle)* resourceBundle);

@DllImport("icuuc.dll")
UResType ures_getType(const(UResourceBundle)* resourceBundle);

@DllImport("icuuc.dll")
PSTR ures_getKey(const(UResourceBundle)* resourceBundle);

@DllImport("icuuc.dll")
void ures_resetIterator(UResourceBundle* resourceBundle);

@DllImport("icuuc.dll")
byte ures_hasNext(const(UResourceBundle)* resourceBundle);

@DllImport("icuuc.dll")
UResourceBundle* ures_getNextResource(UResourceBundle* resourceBundle, UResourceBundle* fillIn, UErrorCode* status);

@DllImport("icuuc.dll")
ushort* ures_getNextString(UResourceBundle* resourceBundle, int* len, const(byte)** key, UErrorCode* status);

@DllImport("icuuc.dll")
UResourceBundle* ures_getByIndex(const(UResourceBundle)* resourceBundle, int indexR, UResourceBundle* fillIn, 
                                 UErrorCode* status);

@DllImport("icuuc.dll")
ushort* ures_getStringByIndex(const(UResourceBundle)* resourceBundle, int indexS, int* len, UErrorCode* status);

@DllImport("icuuc.dll")
PSTR ures_getUTF8StringByIndex(const(UResourceBundle)* resB, int stringIndex, PSTR dest, int* pLength, 
                               byte forceCopy, UErrorCode* status);

@DllImport("icuuc.dll")
UResourceBundle* ures_getByKey(const(UResourceBundle)* resourceBundle, const(PSTR) key, UResourceBundle* fillIn, 
                               UErrorCode* status);

@DllImport("icuuc.dll")
ushort* ures_getStringByKey(const(UResourceBundle)* resB, const(PSTR) key, int* len, UErrorCode* status);

@DllImport("icuuc.dll")
PSTR ures_getUTF8StringByKey(const(UResourceBundle)* resB, const(PSTR) key, PSTR dest, int* pLength, 
                             byte forceCopy, UErrorCode* status);

@DllImport("icuuc.dll")
UEnumeration* ures_openAvailableLocales(const(PSTR) packageName, UErrorCode* status);

@DllImport("icuuc.dll")
ULocaleDisplayNames* uldn_open(const(PSTR) locale, UDialectHandling dialectHandling, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
void uldn_close(ULocaleDisplayNames* ldn);

@DllImport("icuuc.dll")
PSTR uldn_getLocale(const(ULocaleDisplayNames)* ldn);

@DllImport("icuuc.dll")
UDialectHandling uldn_getDialectHandling(const(ULocaleDisplayNames)* ldn);

@DllImport("icuuc.dll")
int uldn_localeDisplayName(const(ULocaleDisplayNames)* ldn, const(PSTR) locale, ushort* result, int maxResultSize, 
                           UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int uldn_languageDisplayName(const(ULocaleDisplayNames)* ldn, const(PSTR) lang, ushort* result, int maxResultSize, 
                             UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int uldn_scriptDisplayName(const(ULocaleDisplayNames)* ldn, const(PSTR) script, ushort* result, int maxResultSize, 
                           UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int uldn_scriptCodeDisplayName(const(ULocaleDisplayNames)* ldn, UScriptCode scriptCode, ushort* result, 
                               int maxResultSize, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int uldn_regionDisplayName(const(ULocaleDisplayNames)* ldn, const(PSTR) region, ushort* result, int maxResultSize, 
                           UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int uldn_variantDisplayName(const(ULocaleDisplayNames)* ldn, const(PSTR) variant, ushort* result, 
                            int maxResultSize, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int uldn_keyDisplayName(const(ULocaleDisplayNames)* ldn, const(PSTR) key, ushort* result, int maxResultSize, 
                        UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int uldn_keyValueDisplayName(const(ULocaleDisplayNames)* ldn, const(PSTR) key, const(PSTR) value, ushort* result, 
                             int maxResultSize, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
ULocaleDisplayNames* uldn_openForContext(const(PSTR) locale, UDisplayContext* contexts, int length, 
                                         UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
UDisplayContext uldn_getContext(const(ULocaleDisplayNames)* ldn, UDisplayContextType type, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int ucurr_forLocale(const(PSTR) locale, ushort* buff, int buffCapacity, UErrorCode* ec);

@DllImport("icuuc.dll")
void* ucurr_register(const(ushort)* isoCode, const(PSTR) locale, UErrorCode* status);

@DllImport("icuuc.dll")
byte ucurr_unregister(void* key, UErrorCode* status);

@DllImport("icuuc.dll")
ushort* ucurr_getName(const(ushort)* currency, const(PSTR) locale, UCurrNameStyle nameStyle, byte* isChoiceFormat, 
                      int* len, UErrorCode* ec);

@DllImport("icuuc.dll")
ushort* ucurr_getPluralName(const(ushort)* currency, const(PSTR) locale, byte* isChoiceFormat, 
                            const(PSTR) pluralCount, int* len, UErrorCode* ec);

@DllImport("icuuc.dll")
int ucurr_getDefaultFractionDigits(const(ushort)* currency, UErrorCode* ec);

@DllImport("icuuc.dll")
int ucurr_getDefaultFractionDigitsForUsage(const(ushort)* currency, const(UCurrencyUsage) usage, UErrorCode* ec);

@DllImport("icuuc.dll")
double ucurr_getRoundingIncrement(const(ushort)* currency, UErrorCode* ec);

@DllImport("icuuc.dll")
double ucurr_getRoundingIncrementForUsage(const(ushort)* currency, const(UCurrencyUsage) usage, UErrorCode* ec);

@DllImport("icuuc.dll")
UEnumeration* ucurr_openISOCurrencies(uint currType, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
byte ucurr_isAvailable(const(ushort)* isoCode, double from, double to, UErrorCode* errorCode);

@DllImport("icuuc.dll")
int ucurr_countCurrencies(const(PSTR) locale, double date, UErrorCode* ec);

@DllImport("icuuc.dll")
int ucurr_forLocaleAndDate(const(PSTR) locale, double date, int index, ushort* buff, int buffCapacity, 
                           UErrorCode* ec);

@DllImport("icuuc.dll")
UEnumeration* ucurr_getKeywordValuesForLocale(const(PSTR) key, const(PSTR) locale, byte commonlyUsed, 
                                              UErrorCode* status);

@DllImport("icuuc.dll")
int ucurr_getNumericCode(const(ushort)* currency);

@DllImport("icu.dll")
uint ucpmap_get(const(UCPMap)* map, int c);

@DllImport("icu.dll")
int ucpmap_getRange(const(UCPMap)* map, int start, UCPMapRangeOption option, uint surrogateValue, 
                    UCPMapValueFilter* filter, const(void)* context, uint* pValue);

@DllImport("icu.dll")
UCPTrie* ucptrie_openFromBinary(UCPTrieType type, UCPTrieValueWidth valueWidth, const(void)* data, int length, 
                                int* pActualLength, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void ucptrie_close(UCPTrie* trie);

@DllImport("icu.dll")
UCPTrieType ucptrie_getType(const(UCPTrie)* trie);

@DllImport("icu.dll")
UCPTrieValueWidth ucptrie_getValueWidth(const(UCPTrie)* trie);

@DllImport("icu.dll")
uint ucptrie_get(const(UCPTrie)* trie, int c);

@DllImport("icu.dll")
int ucptrie_getRange(const(UCPTrie)* trie, int start, UCPMapRangeOption option, uint surrogateValue, 
                     UCPMapValueFilter* filter, const(void)* context, uint* pValue);

@DllImport("icu.dll")
int ucptrie_toBinary(const(UCPTrie)* trie, void* data, int capacity, UErrorCode* pErrorCode);

@DllImport("icu.dll")
int ucptrie_internalSmallIndex(const(UCPTrie)* trie, int c);

@DllImport("icu.dll")
int ucptrie_internalSmallU8Index(const(UCPTrie)* trie, int lt1, ubyte t2, ubyte t3);

@DllImport("icu.dll")
int ucptrie_internalU8PrevIndex(const(UCPTrie)* trie, int c, const(ubyte)* start, const(ubyte)* src);

@DllImport("icu.dll")
UMutableCPTrie* umutablecptrie_open(uint initialValue, uint errorValue, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UMutableCPTrie* umutablecptrie_clone(const(UMutableCPTrie)* other, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void umutablecptrie_close(UMutableCPTrie* trie);

@DllImport("icu.dll")
UMutableCPTrie* umutablecptrie_fromUCPMap(const(UCPMap)* map, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UMutableCPTrie* umutablecptrie_fromUCPTrie(const(UCPTrie)* trie, UErrorCode* pErrorCode);

@DllImport("icu.dll")
uint umutablecptrie_get(const(UMutableCPTrie)* trie, int c);

@DllImport("icu.dll")
int umutablecptrie_getRange(const(UMutableCPTrie)* trie, int start, UCPMapRangeOption option, uint surrogateValue, 
                            UCPMapValueFilter* filter, const(void)* context, uint* pValue);

@DllImport("icu.dll")
void umutablecptrie_set(UMutableCPTrie* trie, int c, uint value, UErrorCode* pErrorCode);

@DllImport("icu.dll")
void umutablecptrie_setRange(UMutableCPTrie* trie, int start, int end, uint value, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UCPTrie* umutablecptrie_buildImmutable(UMutableCPTrie* trie, UCPTrieType type, UCPTrieValueWidth valueWidth, 
                                       UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
void UCNV_FROM_U_CALLBACK_STOP(const(void)* context, UConverterFromUnicodeArgs* fromUArgs, 
                               const(ushort)* codeUnits, int length, int codePoint, UConverterCallbackReason reason, 
                               UErrorCode* err);

@DllImport("icuuc.dll")
void UCNV_TO_U_CALLBACK_STOP(const(void)* context, UConverterToUnicodeArgs* toUArgs, const(PSTR) codeUnits, 
                             int length, UConverterCallbackReason reason, UErrorCode* err);

@DllImport("icuuc.dll")
void UCNV_FROM_U_CALLBACK_SKIP(const(void)* context, UConverterFromUnicodeArgs* fromUArgs, 
                               const(ushort)* codeUnits, int length, int codePoint, UConverterCallbackReason reason, 
                               UErrorCode* err);

@DllImport("icuuc.dll")
void UCNV_FROM_U_CALLBACK_SUBSTITUTE(const(void)* context, UConverterFromUnicodeArgs* fromUArgs, 
                                     const(ushort)* codeUnits, int length, int codePoint, 
                                     UConverterCallbackReason reason, UErrorCode* err);

@DllImport("icuuc.dll")
void UCNV_FROM_U_CALLBACK_ESCAPE(const(void)* context, UConverterFromUnicodeArgs* fromUArgs, 
                                 const(ushort)* codeUnits, int length, int codePoint, 
                                 UConverterCallbackReason reason, UErrorCode* err);

@DllImport("icuuc.dll")
void UCNV_TO_U_CALLBACK_SKIP(const(void)* context, UConverterToUnicodeArgs* toUArgs, const(PSTR) codeUnits, 
                             int length, UConverterCallbackReason reason, UErrorCode* err);

@DllImport("icuuc.dll")
void UCNV_TO_U_CALLBACK_SUBSTITUTE(const(void)* context, UConverterToUnicodeArgs* toUArgs, const(PSTR) codeUnits, 
                                   int length, UConverterCallbackReason reason, UErrorCode* err);

@DllImport("icuuc.dll")
void UCNV_TO_U_CALLBACK_ESCAPE(const(void)* context, UConverterToUnicodeArgs* toUArgs, const(PSTR) codeUnits, 
                               int length, UConverterCallbackReason reason, UErrorCode* err);

@DllImport("icuuc.dll")
int ucnv_compareNames(const(PSTR) name1, const(PSTR) name2);

@DllImport("icuuc.dll")
UConverter* ucnv_open(const(PSTR) converterName, UErrorCode* err);

@DllImport("icuuc.dll")
UConverter* ucnv_openU(const(ushort)* name, UErrorCode* err);

@DllImport("icuuc.dll")
UConverter* ucnv_openCCSID(int codepage, UConverterPlatform platform, UErrorCode* err);

@DllImport("icuuc.dll")
UConverter* ucnv_openPackage(const(PSTR) packageName, const(PSTR) converterName, UErrorCode* err);

@DllImport("icuuc.dll")
UConverter* ucnv_safeClone(const(UConverter)* cnv, void* stackBuffer, int* pBufferSize, UErrorCode* status);

@DllImport("icu.dll")
UConverter* ucnv_clone(const(UConverter)* cnv, UErrorCode* status);

@DllImport("icuuc.dll")
void ucnv_close(UConverter* converter);

@DllImport("icuuc.dll")
void ucnv_getSubstChars(const(UConverter)* converter, PSTR subChars, byte* len, UErrorCode* err);

@DllImport("icuuc.dll")
void ucnv_setSubstChars(UConverter* converter, const(PSTR) subChars, byte len, UErrorCode* err);

@DllImport("icuuc.dll")
void ucnv_setSubstString(UConverter* cnv, const(ushort)* s, int length, UErrorCode* err);

@DllImport("icuuc.dll")
void ucnv_getInvalidChars(const(UConverter)* converter, PSTR errBytes, byte* len, UErrorCode* err);

@DllImport("icuuc.dll")
void ucnv_getInvalidUChars(const(UConverter)* converter, ushort* errUChars, byte* len, UErrorCode* err);

@DllImport("icuuc.dll")
void ucnv_reset(UConverter* converter);

@DllImport("icuuc.dll")
void ucnv_resetToUnicode(UConverter* converter);

@DllImport("icuuc.dll")
void ucnv_resetFromUnicode(UConverter* converter);

@DllImport("icuuc.dll")
byte ucnv_getMaxCharSize(const(UConverter)* converter);

@DllImport("icuuc.dll")
byte ucnv_getMinCharSize(const(UConverter)* converter);

@DllImport("icuuc.dll")
int ucnv_getDisplayName(const(UConverter)* converter, const(PSTR) displayLocale, ushort* displayName, 
                        int displayNameCapacity, UErrorCode* err);

@DllImport("icuuc.dll")
PSTR ucnv_getName(const(UConverter)* converter, UErrorCode* err);

@DllImport("icuuc.dll")
int ucnv_getCCSID(const(UConverter)* converter, UErrorCode* err);

@DllImport("icuuc.dll")
UConverterPlatform ucnv_getPlatform(const(UConverter)* converter, UErrorCode* err);

@DllImport("icuuc.dll")
UConverterType ucnv_getType(const(UConverter)* converter);

@DllImport("icuuc.dll")
void ucnv_getStarters(const(UConverter)* converter, byte* starters, UErrorCode* err);

@DllImport("icuuc.dll")
void ucnv_getUnicodeSet(const(UConverter)* cnv, USet* setFillIn, UConverterUnicodeSet whichSet, 
                        UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
void ucnv_getToUCallBack(const(UConverter)* converter, UConverterToUCallback* action, const(void)** context);

@DllImport("icuuc.dll")
void ucnv_getFromUCallBack(const(UConverter)* converter, UConverterFromUCallback* action, const(void)** context);

@DllImport("icuuc.dll")
void ucnv_setToUCallBack(UConverter* converter, UConverterToUCallback newAction, const(void)* newContext, 
                         UConverterToUCallback* oldAction, const(void)** oldContext, UErrorCode* err);

@DllImport("icuuc.dll")
void ucnv_setFromUCallBack(UConverter* converter, UConverterFromUCallback newAction, const(void)* newContext, 
                           UConverterFromUCallback* oldAction, const(void)** oldContext, UErrorCode* err);

@DllImport("icuuc.dll")
void ucnv_fromUnicode(UConverter* converter, byte** target, const(PSTR) targetLimit, const(ushort)** source, 
                      const(ushort)* sourceLimit, int* offsets, byte flush, UErrorCode* err);

@DllImport("icuuc.dll")
void ucnv_toUnicode(UConverter* converter, ushort** target, const(ushort)* targetLimit, const(byte)** source, 
                    const(PSTR) sourceLimit, int* offsets, byte flush, UErrorCode* err);

@DllImport("icuuc.dll")
int ucnv_fromUChars(UConverter* cnv, PSTR dest, int destCapacity, const(ushort)* src, int srcLength, 
                    UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int ucnv_toUChars(UConverter* cnv, ushort* dest, int destCapacity, const(PSTR) src, int srcLength, 
                  UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int ucnv_getNextUChar(UConverter* converter, const(byte)** source, const(PSTR) sourceLimit, UErrorCode* err);

@DllImport("icuuc.dll")
void ucnv_convertEx(UConverter* targetCnv, UConverter* sourceCnv, byte** target, const(PSTR) targetLimit, 
                    const(byte)** source, const(PSTR) sourceLimit, ushort* pivotStart, ushort** pivotSource, 
                    ushort** pivotTarget, const(ushort)* pivotLimit, byte reset, byte flush, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int ucnv_convert(const(PSTR) toConverterName, const(PSTR) fromConverterName, PSTR target, int targetCapacity, 
                 const(PSTR) source, int sourceLength, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int ucnv_toAlgorithmic(UConverterType algorithmicType, UConverter* cnv, PSTR target, int targetCapacity, 
                       const(PSTR) source, int sourceLength, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int ucnv_fromAlgorithmic(UConverter* cnv, UConverterType algorithmicType, PSTR target, int targetCapacity, 
                         const(PSTR) source, int sourceLength, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int ucnv_flushCache();

@DllImport("icuuc.dll")
int ucnv_countAvailable();

@DllImport("icuuc.dll")
PSTR ucnv_getAvailableName(int n);

@DllImport("icuuc.dll")
UEnumeration* ucnv_openAllNames(UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
ushort ucnv_countAliases(const(PSTR) alias_, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
PSTR ucnv_getAlias(const(PSTR) alias_, ushort n, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
void ucnv_getAliases(const(PSTR) alias_, const(byte)** aliases, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
UEnumeration* ucnv_openStandardNames(const(PSTR) convName, const(PSTR) standard, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
ushort ucnv_countStandards();

@DllImport("icuuc.dll")
PSTR ucnv_getStandard(ushort n, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
PSTR ucnv_getStandardName(const(PSTR) name, const(PSTR) standard, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
PSTR ucnv_getCanonicalName(const(PSTR) alias_, const(PSTR) standard, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
PSTR ucnv_getDefaultName();

@DllImport("icuuc.dll")
void ucnv_setDefaultName(const(PSTR) name);

@DllImport("icuuc.dll")
void ucnv_fixFileSeparator(const(UConverter)* cnv, ushort* source, int sourceLen);

@DllImport("icuuc.dll")
byte ucnv_isAmbiguous(const(UConverter)* cnv);

@DllImport("icuuc.dll")
void ucnv_setFallback(UConverter* cnv, byte usesFallback);

@DllImport("icuuc.dll")
byte ucnv_usesFallback(const(UConverter)* cnv);

@DllImport("icuuc.dll")
PSTR ucnv_detectUnicodeSignature(const(PSTR) source, int sourceLength, int* signatureLength, 
                                 UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int ucnv_fromUCountPending(const(UConverter)* cnv, UErrorCode* status);

@DllImport("icuuc.dll")
int ucnv_toUCountPending(const(UConverter)* cnv, UErrorCode* status);

@DllImport("icuuc.dll")
byte ucnv_isFixedWidth(UConverter* cnv, UErrorCode* status);

@DllImport("icuuc.dll")
void ucnv_cbFromUWriteBytes(UConverterFromUnicodeArgs* args, const(PSTR) source, int length, int offsetIndex, 
                            UErrorCode* err);

@DllImport("icuuc.dll")
void ucnv_cbFromUWriteSub(UConverterFromUnicodeArgs* args, int offsetIndex, UErrorCode* err);

@DllImport("icuuc.dll")
void ucnv_cbFromUWriteUChars(UConverterFromUnicodeArgs* args, const(ushort)** source, const(ushort)* sourceLimit, 
                             int offsetIndex, UErrorCode* err);

@DllImport("icuuc.dll")
void ucnv_cbToUWriteUChars(UConverterToUnicodeArgs* args, const(ushort)* source, int length, int offsetIndex, 
                           UErrorCode* err);

@DllImport("icuuc.dll")
void ucnv_cbToUWriteSub(UConverterToUnicodeArgs* args, int offsetIndex, UErrorCode* err);

@DllImport("icuuc.dll")
void u_init(UErrorCode* status);

@DllImport("icuuc.dll")
void u_cleanup();

@DllImport("icuuc.dll")
void u_setMemoryFunctions(const(void)* context, UMemAllocFn* a, UMemReallocFn* r, UMemFreeFn* f, 
                          UErrorCode* status);

@DllImport("icuuc.dll")
UResourceBundle* u_catopen(const(PSTR) name, const(PSTR) locale, UErrorCode* ec);

@DllImport("icuuc.dll")
void u_catclose(UResourceBundle* catd);

@DllImport("icuuc.dll")
ushort* u_catgets(UResourceBundle* catd, int set_num, int msg_num, const(ushort)* s, int* len, UErrorCode* ec);

@DllImport("icuuc.dll")
byte u_hasBinaryProperty(int c, UProperty which);

@DllImport("icu.dll")
byte u_stringHasBinaryProperty(const(ushort)* s, int length, UProperty which);

@DllImport("icu.dll")
USet* u_getBinaryPropertySet(UProperty property, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
byte u_isUAlphabetic(int c);

@DllImport("icuuc.dll")
byte u_isULowercase(int c);

@DllImport("icuuc.dll")
byte u_isUUppercase(int c);

@DllImport("icuuc.dll")
byte u_isUWhiteSpace(int c);

@DllImport("icuuc.dll")
int u_getIntPropertyValue(int c, UProperty which);

@DllImport("icuuc.dll")
int u_getIntPropertyMinValue(UProperty which);

@DllImport("icuuc.dll")
int u_getIntPropertyMaxValue(UProperty which);

@DllImport("icu.dll")
UCPMap* u_getIntPropertyMap(UProperty property, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
double u_getNumericValue(int c);

@DllImport("icuuc.dll")
byte u_islower(int c);

@DllImport("icuuc.dll")
byte u_isupper(int c);

@DllImport("icuuc.dll")
byte u_istitle(int c);

@DllImport("icuuc.dll")
byte u_isdigit(int c);

@DllImport("icuuc.dll")
byte u_isalpha(int c);

@DllImport("icuuc.dll")
byte u_isalnum(int c);

@DllImport("icuuc.dll")
byte u_isxdigit(int c);

@DllImport("icuuc.dll")
byte u_ispunct(int c);

@DllImport("icuuc.dll")
byte u_isgraph(int c);

@DllImport("icuuc.dll")
byte u_isblank(int c);

@DllImport("icuuc.dll")
byte u_isdefined(int c);

@DllImport("icuuc.dll")
byte u_isspace(int c);

@DllImport("icuuc.dll")
byte u_isJavaSpaceChar(int c);

@DllImport("icuuc.dll")
byte u_isWhitespace(int c);

@DllImport("icuuc.dll")
byte u_iscntrl(int c);

@DllImport("icuuc.dll")
byte u_isISOControl(int c);

@DllImport("icuuc.dll")
byte u_isprint(int c);

@DllImport("icuuc.dll")
byte u_isbase(int c);

@DllImport("icuuc.dll")
UCharDirection u_charDirection(int c);

@DllImport("icuuc.dll")
byte u_isMirrored(int c);

@DllImport("icuuc.dll")
int u_charMirror(int c);

@DllImport("icuuc.dll")
int u_getBidiPairedBracket(int c);

@DllImport("icuuc.dll")
byte u_charType(int c);

@DllImport("icuuc.dll")
void u_enumCharTypes(UCharEnumTypeRange* enumRange, const(void)* context);

@DllImport("icuuc.dll")
ubyte u_getCombiningClass(int c);

@DllImport("icuuc.dll")
int u_charDigitValue(int c);

@DllImport("icuuc.dll")
UBlockCode ublock_getCode(int c);

@DllImport("icuuc.dll")
int u_charName(int code, UCharNameChoice nameChoice, PSTR buffer, int bufferLength, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int u_charFromName(UCharNameChoice nameChoice, const(PSTR) name, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
void u_enumCharNames(int start, int limit, UEnumCharNamesFn* fn, void* context, UCharNameChoice nameChoice, 
                     UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
PSTR u_getPropertyName(UProperty property, UPropertyNameChoice nameChoice);

@DllImport("icuuc.dll")
UProperty u_getPropertyEnum(const(PSTR) alias_);

@DllImport("icuuc.dll")
PSTR u_getPropertyValueName(UProperty property, int value, UPropertyNameChoice nameChoice);

@DllImport("icuuc.dll")
int u_getPropertyValueEnum(UProperty property, const(PSTR) alias_);

@DllImport("icuuc.dll")
byte u_isIDStart(int c);

@DllImport("icuuc.dll")
byte u_isIDPart(int c);

@DllImport("icuuc.dll")
byte u_isIDIgnorable(int c);

@DllImport("icuuc.dll")
byte u_isJavaIDStart(int c);

@DllImport("icuuc.dll")
byte u_isJavaIDPart(int c);

@DllImport("icuuc.dll")
int u_tolower(int c);

@DllImport("icuuc.dll")
int u_toupper(int c);

@DllImport("icuuc.dll")
int u_totitle(int c);

@DllImport("icuuc.dll")
int u_foldCase(int c, uint options);

@DllImport("icuuc.dll")
int u_digit(int ch, byte radix);

@DllImport("icuuc.dll")
int u_forDigit(int digit, byte radix);

@DllImport("icuuc.dll")
void u_charAge(int c, ubyte* versionArray);

@DllImport("icuuc.dll")
void u_getUnicodeVersion(ubyte* versionArray);

@DllImport("icuuc.dll")
int u_getFC_NFKC_Closure(int c, ushort* dest, int destCapacity, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
UBiDi* ubidi_open();

@DllImport("icuuc.dll")
UBiDi* ubidi_openSized(int maxLength, int maxRunCount, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
void ubidi_close(UBiDi* pBiDi);

@DllImport("icuuc.dll")
void ubidi_setInverse(UBiDi* pBiDi, byte isInverse);

@DllImport("icuuc.dll")
byte ubidi_isInverse(UBiDi* pBiDi);

@DllImport("icuuc.dll")
void ubidi_orderParagraphsLTR(UBiDi* pBiDi, byte orderParagraphsLTR);

@DllImport("icuuc.dll")
byte ubidi_isOrderParagraphsLTR(UBiDi* pBiDi);

@DllImport("icuuc.dll")
void ubidi_setReorderingMode(UBiDi* pBiDi, UBiDiReorderingMode reorderingMode);

@DllImport("icuuc.dll")
UBiDiReorderingMode ubidi_getReorderingMode(UBiDi* pBiDi);

@DllImport("icuuc.dll")
void ubidi_setReorderingOptions(UBiDi* pBiDi, uint reorderingOptions);

@DllImport("icuuc.dll")
uint ubidi_getReorderingOptions(UBiDi* pBiDi);

@DllImport("icuuc.dll")
void ubidi_setContext(UBiDi* pBiDi, const(ushort)* prologue, int proLength, const(ushort)* epilogue, int epiLength, 
                      UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
void ubidi_setPara(UBiDi* pBiDi, const(ushort)* text, int length, ubyte paraLevel, ubyte* embeddingLevels, 
                   UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
void ubidi_setLine(const(UBiDi)* pParaBiDi, int start, int limit, UBiDi* pLineBiDi, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
UBiDiDirection ubidi_getDirection(const(UBiDi)* pBiDi);

@DllImport("icuuc.dll")
UBiDiDirection ubidi_getBaseDirection(const(ushort)* text, int length);

@DllImport("icuuc.dll")
ushort* ubidi_getText(const(UBiDi)* pBiDi);

@DllImport("icuuc.dll")
int ubidi_getLength(const(UBiDi)* pBiDi);

@DllImport("icuuc.dll")
ubyte ubidi_getParaLevel(const(UBiDi)* pBiDi);

@DllImport("icuuc.dll")
int ubidi_countParagraphs(UBiDi* pBiDi);

@DllImport("icuuc.dll")
int ubidi_getParagraph(const(UBiDi)* pBiDi, int charIndex, int* pParaStart, int* pParaLimit, ubyte* pParaLevel, 
                       UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
void ubidi_getParagraphByIndex(const(UBiDi)* pBiDi, int paraIndex, int* pParaStart, int* pParaLimit, 
                               ubyte* pParaLevel, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
ubyte ubidi_getLevelAt(const(UBiDi)* pBiDi, int charIndex);

@DllImport("icuuc.dll")
ubyte* ubidi_getLevels(UBiDi* pBiDi, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
void ubidi_getLogicalRun(const(UBiDi)* pBiDi, int logicalPosition, int* pLogicalLimit, ubyte* pLevel);

@DllImport("icuuc.dll")
int ubidi_countRuns(UBiDi* pBiDi, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
UBiDiDirection ubidi_getVisualRun(UBiDi* pBiDi, int runIndex, int* pLogicalStart, int* pLength);

@DllImport("icuuc.dll")
int ubidi_getVisualIndex(UBiDi* pBiDi, int logicalIndex, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int ubidi_getLogicalIndex(UBiDi* pBiDi, int visualIndex, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
void ubidi_getLogicalMap(UBiDi* pBiDi, int* indexMap, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
void ubidi_getVisualMap(UBiDi* pBiDi, int* indexMap, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
void ubidi_reorderLogical(const(ubyte)* levels, int length, int* indexMap);

@DllImport("icuuc.dll")
void ubidi_reorderVisual(const(ubyte)* levels, int length, int* indexMap);

@DllImport("icuuc.dll")
void ubidi_invertMap(const(int)* srcMap, int* destMap, int length);

@DllImport("icuuc.dll")
int ubidi_getProcessedLength(const(UBiDi)* pBiDi);

@DllImport("icuuc.dll")
int ubidi_getResultLength(const(UBiDi)* pBiDi);

@DllImport("icuuc.dll")
UCharDirection ubidi_getCustomizedClass(UBiDi* pBiDi, int c);

@DllImport("icuuc.dll")
void ubidi_setClassCallback(UBiDi* pBiDi, UBiDiClassCallback newFn, const(void)* newContext, 
                            UBiDiClassCallback* oldFn, const(void)** oldContext, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
void ubidi_getClassCallback(UBiDi* pBiDi, UBiDiClassCallback* fn, const(void)** context);

@DllImport("icuuc.dll")
int ubidi_writeReordered(UBiDi* pBiDi, ushort* dest, int destSize, ushort options, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int ubidi_writeReverse(const(ushort)* src, int srcLength, ushort* dest, int destSize, ushort options, 
                       UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
uint ubiditransform_transform(UBiDiTransform* pBiDiTransform, const(ushort)* src, int srcLength, ushort* dest, 
                              int destSize, ubyte inParaLevel, UBiDiOrder inOrder, ubyte outParaLevel, 
                              UBiDiOrder outOrder, UBiDiMirroring doMirroring, uint shapingOptions, 
                              UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
UBiDiTransform* ubiditransform_open(UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
void ubiditransform_close(UBiDiTransform* pBidiTransform);

@DllImport("icuuc.dll")
UText* utext_close(UText* ut);

@DllImport("icuuc.dll")
UText* utext_openUTF8(UText* ut, const(PSTR) s, long length, UErrorCode* status);

@DllImport("icuuc.dll")
UText* utext_openUChars(UText* ut, const(ushort)* s, long length, UErrorCode* status);

@DllImport("icuuc.dll")
UText* utext_clone(UText* dest, const(UText)* src, byte deep, byte readOnly, UErrorCode* status);

@DllImport("icuuc.dll")
byte utext_equals(const(UText)* a, const(UText)* b);

@DllImport("icuuc.dll")
long utext_nativeLength(UText* ut);

@DllImport("icuuc.dll")
byte utext_isLengthExpensive(const(UText)* ut);

@DllImport("icuuc.dll")
int utext_char32At(UText* ut, long nativeIndex);

@DllImport("icuuc.dll")
int utext_current32(UText* ut);

@DllImport("icuuc.dll")
int utext_next32(UText* ut);

@DllImport("icuuc.dll")
int utext_previous32(UText* ut);

@DllImport("icuuc.dll")
int utext_next32From(UText* ut, long nativeIndex);

@DllImport("icuuc.dll")
int utext_previous32From(UText* ut, long nativeIndex);

@DllImport("icuuc.dll")
long utext_getNativeIndex(const(UText)* ut);

@DllImport("icuuc.dll")
void utext_setNativeIndex(UText* ut, long nativeIndex);

@DllImport("icuuc.dll")
byte utext_moveIndex32(UText* ut, int delta);

@DllImport("icuuc.dll")
long utext_getPreviousNativeIndex(UText* ut);

@DllImport("icuuc.dll")
int utext_extract(UText* ut, long nativeStart, long nativeLimit, ushort* dest, int destCapacity, 
                  UErrorCode* status);

@DllImport("icuuc.dll")
byte utext_isWritable(const(UText)* ut);

@DllImport("icuuc.dll")
byte utext_hasMetaData(const(UText)* ut);

@DllImport("icuuc.dll")
int utext_replace(UText* ut, long nativeStart, long nativeLimit, const(ushort)* replacementText, 
                  int replacementLength, UErrorCode* status);

@DllImport("icuuc.dll")
void utext_copy(UText* ut, long nativeStart, long nativeLimit, long destIndex, byte move, UErrorCode* status);

@DllImport("icuuc.dll")
void utext_freeze(UText* ut);

@DllImport("icuuc.dll")
UText* utext_setup(UText* ut, int extraSpace, UErrorCode* status);

@DllImport("icuuc.dll")
USet* uset_openEmpty();

@DllImport("icuuc.dll")
USet* uset_open(int start, int end);

@DllImport("icuuc.dll")
USet* uset_openPattern(const(ushort)* pattern, int patternLength, UErrorCode* ec);

@DllImport("icuuc.dll")
USet* uset_openPatternOptions(const(ushort)* pattern, int patternLength, uint options, UErrorCode* ec);

@DllImport("icuuc.dll")
void uset_close(USet* set);

@DllImport("icuuc.dll")
USet* uset_clone(const(USet)* set);

@DllImport("icuuc.dll")
byte uset_isFrozen(const(USet)* set);

@DllImport("icuuc.dll")
void uset_freeze(USet* set);

@DllImport("icuuc.dll")
USet* uset_cloneAsThawed(const(USet)* set);

@DllImport("icuuc.dll")
void uset_set(USet* set, int start, int end);

@DllImport("icuuc.dll")
int uset_applyPattern(USet* set, const(ushort)* pattern, int patternLength, uint options, UErrorCode* status);

@DllImport("icuuc.dll")
void uset_applyIntPropertyValue(USet* set, UProperty prop, int value, UErrorCode* ec);

@DllImport("icuuc.dll")
void uset_applyPropertyAlias(USet* set, const(ushort)* prop, int propLength, const(ushort)* value, int valueLength, 
                             UErrorCode* ec);

@DllImport("icuuc.dll")
byte uset_resemblesPattern(const(ushort)* pattern, int patternLength, int pos);

@DllImport("icuuc.dll")
int uset_toPattern(const(USet)* set, ushort* result, int resultCapacity, byte escapeUnprintable, UErrorCode* ec);

@DllImport("icuuc.dll")
void uset_add(USet* set, int c);

@DllImport("icuuc.dll")
void uset_addAll(USet* set, const(USet)* additionalSet);

@DllImport("icuuc.dll")
void uset_addRange(USet* set, int start, int end);

@DllImport("icuuc.dll")
void uset_addString(USet* set, const(ushort)* str, int strLen);

@DllImport("icuuc.dll")
void uset_addAllCodePoints(USet* set, const(ushort)* str, int strLen);

@DllImport("icuuc.dll")
void uset_remove(USet* set, int c);

@DllImport("icuuc.dll")
void uset_removeRange(USet* set, int start, int end);

@DllImport("icuuc.dll")
void uset_removeString(USet* set, const(ushort)* str, int strLen);

@DllImport("icu.dll")
void uset_removeAllCodePoints(USet* set, const(ushort)* str, int length);

@DllImport("icuuc.dll")
void uset_removeAll(USet* set, const(USet)* removeSet);

@DllImport("icuuc.dll")
void uset_retain(USet* set, int start, int end);

@DllImport("icu.dll")
void uset_retainString(USet* set, const(ushort)* str, int length);

@DllImport("icu.dll")
void uset_retainAllCodePoints(USet* set, const(ushort)* str, int length);

@DllImport("icuuc.dll")
void uset_retainAll(USet* set, const(USet)* retain);

@DllImport("icuuc.dll")
void uset_compact(USet* set);

@DllImport("icuuc.dll")
void uset_complement(USet* set);

@DllImport("icu.dll")
void uset_complementRange(USet* set, int start, int end);

@DllImport("icu.dll")
void uset_complementString(USet* set, const(ushort)* str, int length);

@DllImport("icu.dll")
void uset_complementAllCodePoints(USet* set, const(ushort)* str, int length);

@DllImport("icuuc.dll")
void uset_complementAll(USet* set, const(USet)* complement);

@DllImport("icuuc.dll")
void uset_clear(USet* set);

@DllImport("icuuc.dll")
void uset_closeOver(USet* set, int attributes);

@DllImport("icuuc.dll")
void uset_removeAllStrings(USet* set);

@DllImport("icuuc.dll")
byte uset_isEmpty(const(USet)* set);

@DllImport("icu.dll")
byte uset_hasStrings(const(USet)* set);

@DllImport("icuuc.dll")
byte uset_contains(const(USet)* set, int c);

@DllImport("icuuc.dll")
byte uset_containsRange(const(USet)* set, int start, int end);

@DllImport("icuuc.dll")
byte uset_containsString(const(USet)* set, const(ushort)* str, int strLen);

@DllImport("icuuc.dll")
int uset_indexOf(const(USet)* set, int c);

@DllImport("icuuc.dll")
int uset_charAt(const(USet)* set, int charIndex);

@DllImport("icuuc.dll")
int uset_size(const(USet)* set);

@DllImport("icu.dll")
int uset_getRangeCount(const(USet)* set);

@DllImport("icuuc.dll")
int uset_getItemCount(const(USet)* set);

@DllImport("icuuc.dll")
int uset_getItem(const(USet)* set, int itemIndex, int* start, int* end, ushort* str, int strCapacity, 
                 UErrorCode* ec);

@DllImport("icuuc.dll")
byte uset_containsAll(const(USet)* set1, const(USet)* set2);

@DllImport("icuuc.dll")
byte uset_containsAllCodePoints(const(USet)* set, const(ushort)* str, int strLen);

@DllImport("icuuc.dll")
byte uset_containsNone(const(USet)* set1, const(USet)* set2);

@DllImport("icuuc.dll")
byte uset_containsSome(const(USet)* set1, const(USet)* set2);

@DllImport("icuuc.dll")
int uset_span(const(USet)* set, const(ushort)* s, int length, USetSpanCondition spanCondition);

@DllImport("icuuc.dll")
int uset_spanBack(const(USet)* set, const(ushort)* s, int length, USetSpanCondition spanCondition);

@DllImport("icuuc.dll")
int uset_spanUTF8(const(USet)* set, const(PSTR) s, int length, USetSpanCondition spanCondition);

@DllImport("icuuc.dll")
int uset_spanBackUTF8(const(USet)* set, const(PSTR) s, int length, USetSpanCondition spanCondition);

@DllImport("icuuc.dll")
byte uset_equals(const(USet)* set1, const(USet)* set2);

@DllImport("icuuc.dll")
int uset_serialize(const(USet)* set, ushort* dest, int destCapacity, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
byte uset_getSerializedSet(USerializedSet* fillSet, const(ushort)* src, int srcLength);

@DllImport("icuuc.dll")
void uset_setSerializedToOne(USerializedSet* fillSet, int c);

@DllImport("icuuc.dll")
byte uset_serializedContains(const(USerializedSet)* set, int c);

@DllImport("icuuc.dll")
int uset_getSerializedRangeCount(const(USerializedSet)* set);

@DllImport("icuuc.dll")
byte uset_getSerializedRange(const(USerializedSet)* set, int rangeIndex, int* pStart, int* pEnd);

@DllImport("icuuc.dll")
UNormalizer2* unorm2_getNFCInstance(UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
UNormalizer2* unorm2_getNFDInstance(UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
UNormalizer2* unorm2_getNFKCInstance(UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
UNormalizer2* unorm2_getNFKDInstance(UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
UNormalizer2* unorm2_getNFKCCasefoldInstance(UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
UNormalizer2* unorm2_getInstance(const(PSTR) packageName, const(PSTR) name, UNormalization2Mode mode, 
                                 UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
UNormalizer2* unorm2_openFiltered(const(UNormalizer2)* norm2, const(USet)* filterSet, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
void unorm2_close(UNormalizer2* norm2);

@DllImport("icuuc.dll")
int unorm2_normalize(const(UNormalizer2)* norm2, const(ushort)* src, int length, ushort* dest, int capacity, 
                     UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int unorm2_normalizeSecondAndAppend(const(UNormalizer2)* norm2, ushort* first, int firstLength, int firstCapacity, 
                                    const(ushort)* second, int secondLength, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int unorm2_append(const(UNormalizer2)* norm2, ushort* first, int firstLength, int firstCapacity, 
                  const(ushort)* second, int secondLength, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int unorm2_getDecomposition(const(UNormalizer2)* norm2, int c, ushort* decomposition, int capacity, 
                            UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int unorm2_getRawDecomposition(const(UNormalizer2)* norm2, int c, ushort* decomposition, int capacity, 
                               UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int unorm2_composePair(const(UNormalizer2)* norm2, int a, int b);

@DllImport("icuuc.dll")
ubyte unorm2_getCombiningClass(const(UNormalizer2)* norm2, int c);

@DllImport("icuuc.dll")
byte unorm2_isNormalized(const(UNormalizer2)* norm2, const(ushort)* s, int length, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
UNormalizationCheckResult unorm2_quickCheck(const(UNormalizer2)* norm2, const(ushort)* s, int length, 
                                            UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int unorm2_spanQuickCheckYes(const(UNormalizer2)* norm2, const(ushort)* s, int length, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
byte unorm2_hasBoundaryBefore(const(UNormalizer2)* norm2, int c);

@DllImport("icuuc.dll")
byte unorm2_hasBoundaryAfter(const(UNormalizer2)* norm2, int c);

@DllImport("icuuc.dll")
byte unorm2_isInert(const(UNormalizer2)* norm2, int c);

@DllImport("icuuc.dll")
int unorm_compare(const(ushort)* s1, int length1, const(ushort)* s2, int length2, uint options, 
                  UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
UConverterSelector* ucnvsel_open(const(byte)** converterList, int converterListSize, 
                                 const(USet)* excludedCodePoints, const(UConverterUnicodeSet) whichSet, 
                                 UErrorCode* status);

@DllImport("icuuc.dll")
void ucnvsel_close(UConverterSelector* sel);

@DllImport("icuuc.dll")
UConverterSelector* ucnvsel_openFromSerialized(const(void)* buffer, int length, UErrorCode* status);

@DllImport("icuuc.dll")
int ucnvsel_serialize(const(UConverterSelector)* sel, void* buffer, int bufferCapacity, UErrorCode* status);

@DllImport("icuuc.dll")
UEnumeration* ucnvsel_selectForString(const(UConverterSelector)* sel, const(ushort)* s, int length, 
                                      UErrorCode* status);

@DllImport("icuuc.dll")
UEnumeration* ucnvsel_selectForUTF8(const(UConverterSelector)* sel, const(PSTR) s, int length, UErrorCode* status);

@DllImport("icuuc.dll")
void u_charsToUChars(const(PSTR) cs, ushort* us, int length);

@DllImport("icuuc.dll")
void u_UCharsToChars(const(ushort)* us, PSTR cs, int length);

@DllImport("icuuc.dll")
int u_strlen(const(ushort)* s);

@DllImport("icuuc.dll")
int u_countChar32(const(ushort)* s, int length);

@DllImport("icuuc.dll")
byte u_strHasMoreChar32Than(const(ushort)* s, int length, int number);

@DllImport("icuuc.dll")
ushort* u_strcat(ushort* dst, const(ushort)* src);

@DllImport("icuuc.dll")
ushort* u_strncat(ushort* dst, const(ushort)* src, int n);

@DllImport("icuuc.dll")
ushort* u_strstr(const(ushort)* s, const(ushort)* substring);

@DllImport("icuuc.dll")
ushort* u_strFindFirst(const(ushort)* s, int length, const(ushort)* substring, int subLength);

@DllImport("icuuc.dll")
ushort* u_strchr(const(ushort)* s, ushort c);

@DllImport("icuuc.dll")
ushort* u_strchr32(const(ushort)* s, int c);

@DllImport("icuuc.dll")
ushort* u_strrstr(const(ushort)* s, const(ushort)* substring);

@DllImport("icuuc.dll")
ushort* u_strFindLast(const(ushort)* s, int length, const(ushort)* substring, int subLength);

@DllImport("icuuc.dll")
ushort* u_strrchr(const(ushort)* s, ushort c);

@DllImport("icuuc.dll")
ushort* u_strrchr32(const(ushort)* s, int c);

@DllImport("icuuc.dll")
ushort* u_strpbrk(const(ushort)* string, const(ushort)* matchSet);

@DllImport("icuuc.dll")
int u_strcspn(const(ushort)* string, const(ushort)* matchSet);

@DllImport("icuuc.dll")
int u_strspn(const(ushort)* string, const(ushort)* matchSet);

@DllImport("icuuc.dll")
ushort* u_strtok_r(ushort* src, const(ushort)* delim, ushort** saveState);

@DllImport("icuuc.dll")
int u_strcmp(const(ushort)* s1, const(ushort)* s2);

@DllImport("icuuc.dll")
int u_strcmpCodePointOrder(const(ushort)* s1, const(ushort)* s2);

@DllImport("icuuc.dll")
int u_strCompare(const(ushort)* s1, int length1, const(ushort)* s2, int length2, byte codePointOrder);

@DllImport("icuuc.dll")
int u_strCompareIter(UCharIterator* iter1, UCharIterator* iter2, byte codePointOrder);

@DllImport("icuuc.dll")
int u_strCaseCompare(const(ushort)* s1, int length1, const(ushort)* s2, int length2, uint options, 
                     UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int u_strncmp(const(ushort)* ucs1, const(ushort)* ucs2, int n);

@DllImport("icuuc.dll")
int u_strncmpCodePointOrder(const(ushort)* s1, const(ushort)* s2, int n);

@DllImport("icuuc.dll")
int u_strcasecmp(const(ushort)* s1, const(ushort)* s2, uint options);

@DllImport("icuuc.dll")
int u_strncasecmp(const(ushort)* s1, const(ushort)* s2, int n, uint options);

@DllImport("icuuc.dll")
int u_memcasecmp(const(ushort)* s1, const(ushort)* s2, int length, uint options);

@DllImport("icuuc.dll")
ushort* u_strcpy(ushort* dst, const(ushort)* src);

@DllImport("icuuc.dll")
ushort* u_strncpy(ushort* dst, const(ushort)* src, int n);

@DllImport("icuuc.dll")
ushort* u_uastrcpy(ushort* dst, const(PSTR) src);

@DllImport("icuuc.dll")
ushort* u_uastrncpy(ushort* dst, const(PSTR) src, int n);

@DllImport("icuuc.dll")
PSTR u_austrcpy(PSTR dst, const(ushort)* src);

@DllImport("icuuc.dll")
PSTR u_austrncpy(PSTR dst, const(ushort)* src, int n);

@DllImport("icuuc.dll")
ushort* u_memcpy(ushort* dest, const(ushort)* src, int count);

@DllImport("icuuc.dll")
ushort* u_memmove(ushort* dest, const(ushort)* src, int count);

@DllImport("icuuc.dll")
ushort* u_memset(ushort* dest, ushort c, int count);

@DllImport("icuuc.dll")
int u_memcmp(const(ushort)* buf1, const(ushort)* buf2, int count);

@DllImport("icuuc.dll")
int u_memcmpCodePointOrder(const(ushort)* s1, const(ushort)* s2, int count);

@DllImport("icuuc.dll")
ushort* u_memchr(const(ushort)* s, ushort c, int count);

@DllImport("icuuc.dll")
ushort* u_memchr32(const(ushort)* s, int c, int count);

@DllImport("icuuc.dll")
ushort* u_memrchr(const(ushort)* s, ushort c, int count);

@DllImport("icuuc.dll")
ushort* u_memrchr32(const(ushort)* s, int c, int count);

@DllImport("icuuc.dll")
int u_unescape(const(PSTR) src, ushort* dest, int destCapacity);

@DllImport("icuuc.dll")
int u_unescapeAt(UNESCAPE_CHAR_AT charAt, int* offset, int length, void* context);

@DllImport("icuuc.dll")
int u_strToUpper(ushort* dest, int destCapacity, const(ushort)* src, int srcLength, const(PSTR) locale, 
                 UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int u_strToLower(ushort* dest, int destCapacity, const(ushort)* src, int srcLength, const(PSTR) locale, 
                 UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int u_strToTitle(ushort* dest, int destCapacity, const(ushort)* src, int srcLength, UBreakIterator* titleIter, 
                 const(PSTR) locale, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int u_strFoldCase(ushort* dest, int destCapacity, const(ushort)* src, int srcLength, uint options, 
                  UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
PWSTR u_strToWCS(PWSTR dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, 
                 UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
ushort* u_strFromWCS(ushort* dest, int destCapacity, int* pDestLength, const(PWSTR) src, int srcLength, 
                     UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
PSTR u_strToUTF8(PSTR dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, 
                 UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
ushort* u_strFromUTF8(ushort* dest, int destCapacity, int* pDestLength, const(PSTR) src, int srcLength, 
                      UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
PSTR u_strToUTF8WithSub(PSTR dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, 
                        int subchar, int* pNumSubstitutions, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
ushort* u_strFromUTF8WithSub(ushort* dest, int destCapacity, int* pDestLength, const(PSTR) src, int srcLength, 
                             int subchar, int* pNumSubstitutions, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
ushort* u_strFromUTF8Lenient(ushort* dest, int destCapacity, int* pDestLength, const(PSTR) src, int srcLength, 
                             UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int* u_strToUTF32(int* dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, 
                  UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
ushort* u_strFromUTF32(ushort* dest, int destCapacity, int* pDestLength, const(int)* src, int srcLength, 
                       UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int* u_strToUTF32WithSub(int* dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, 
                         int subchar, int* pNumSubstitutions, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
ushort* u_strFromUTF32WithSub(ushort* dest, int destCapacity, int* pDestLength, const(int)* src, int srcLength, 
                              int subchar, int* pNumSubstitutions, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
PSTR u_strToJavaModifiedUTF8(PSTR dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, 
                             UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
ushort* u_strFromJavaModifiedUTF8WithSub(ushort* dest, int destCapacity, int* pDestLength, const(PSTR) src, 
                                         int srcLength, int subchar, int* pNumSubstitutions, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
UCaseMap* ucasemap_open(const(PSTR) locale, uint options, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
void ucasemap_close(UCaseMap* csm);

@DllImport("icuuc.dll")
PSTR ucasemap_getLocale(const(UCaseMap)* csm);

@DllImport("icuuc.dll")
uint ucasemap_getOptions(const(UCaseMap)* csm);

@DllImport("icuuc.dll")
void ucasemap_setLocale(UCaseMap* csm, const(PSTR) locale, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
void ucasemap_setOptions(UCaseMap* csm, uint options, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
UBreakIterator* ucasemap_getBreakIterator(const(UCaseMap)* csm);

@DllImport("icuuc.dll")
void ucasemap_setBreakIterator(UCaseMap* csm, UBreakIterator* iterToAdopt, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int ucasemap_toTitle(UCaseMap* csm, ushort* dest, int destCapacity, const(ushort)* src, int srcLength, 
                     UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int ucasemap_utf8ToLower(const(UCaseMap)* csm, PSTR dest, int destCapacity, const(PSTR) src, int srcLength, 
                         UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int ucasemap_utf8ToUpper(const(UCaseMap)* csm, PSTR dest, int destCapacity, const(PSTR) src, int srcLength, 
                         UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int ucasemap_utf8ToTitle(UCaseMap* csm, PSTR dest, int destCapacity, const(PSTR) src, int srcLength, 
                         UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int ucasemap_utf8FoldCase(const(UCaseMap)* csm, PSTR dest, int destCapacity, const(PSTR) src, int srcLength, 
                          UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
UStringPrepProfile* usprep_open(const(PSTR) path, const(PSTR) fileName, UErrorCode* status);

@DllImport("icuuc.dll")
UStringPrepProfile* usprep_openByType(UStringPrepProfileType type, UErrorCode* status);

@DllImport("icuuc.dll")
void usprep_close(UStringPrepProfile* profile);

@DllImport("icuuc.dll")
int usprep_prepare(const(UStringPrepProfile)* prep, const(ushort)* src, int srcLength, ushort* dest, 
                   int destCapacity, int options, UParseError* parseError, UErrorCode* status);

@DllImport("icuuc.dll")
UIDNA* uidna_openUTS46(uint options, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
void uidna_close(UIDNA* idna);

@DllImport("icuuc.dll")
int uidna_labelToASCII(const(UIDNA)* idna, const(ushort)* label, int length, ushort* dest, int capacity, 
                       UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int uidna_labelToUnicode(const(UIDNA)* idna, const(ushort)* label, int length, ushort* dest, int capacity, 
                         UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int uidna_nameToASCII(const(UIDNA)* idna, const(ushort)* name, int length, ushort* dest, int capacity, 
                      UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int uidna_nameToUnicode(const(UIDNA)* idna, const(ushort)* name, int length, ushort* dest, int capacity, 
                        UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int uidna_labelToASCII_UTF8(const(UIDNA)* idna, const(PSTR) label, int length, PSTR dest, int capacity, 
                            UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int uidna_labelToUnicodeUTF8(const(UIDNA)* idna, const(PSTR) label, int length, PSTR dest, int capacity, 
                             UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int uidna_nameToASCII_UTF8(const(UIDNA)* idna, const(PSTR) name, int length, PSTR dest, int capacity, 
                           UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
int uidna_nameToUnicodeUTF8(const(UIDNA)* idna, const(PSTR) name, int length, PSTR dest, int capacity, 
                            UIDNAInfo* pInfo, UErrorCode* pErrorCode);

@DllImport("icuuc.dll")
UBreakIterator* ubrk_open(UBreakIteratorType type, const(PSTR) locale, const(ushort)* text, int textLength, 
                          UErrorCode* status);

@DllImport("icuuc.dll")
UBreakIterator* ubrk_openRules(const(ushort)* rules, int rulesLength, const(ushort)* text, int textLength, 
                               UParseError* parseErr, UErrorCode* status);

@DllImport("icuuc.dll")
UBreakIterator* ubrk_openBinaryRules(const(ubyte)* binaryRules, int rulesLength, const(ushort)* text, 
                                     int textLength, UErrorCode* status);

@DllImport("icuuc.dll")
UBreakIterator* ubrk_safeClone(const(UBreakIterator)* bi, void* stackBuffer, int* pBufferSize, UErrorCode* status);

@DllImport("icu.dll")
UBreakIterator* ubrk_clone(const(UBreakIterator)* bi, UErrorCode* status);

@DllImport("icuuc.dll")
void ubrk_close(UBreakIterator* bi);

@DllImport("icuuc.dll")
void ubrk_setText(UBreakIterator* bi, const(ushort)* text, int textLength, UErrorCode* status);

@DllImport("icuuc.dll")
void ubrk_setUText(UBreakIterator* bi, UText* text, UErrorCode* status);

@DllImport("icuuc.dll")
int ubrk_current(const(UBreakIterator)* bi);

@DllImport("icuuc.dll")
int ubrk_next(UBreakIterator* bi);

@DllImport("icuuc.dll")
int ubrk_previous(UBreakIterator* bi);

@DllImport("icuuc.dll")
int ubrk_first(UBreakIterator* bi);

@DllImport("icuuc.dll")
int ubrk_last(UBreakIterator* bi);

@DllImport("icuuc.dll")
int ubrk_preceding(UBreakIterator* bi, int offset);

@DllImport("icuuc.dll")
int ubrk_following(UBreakIterator* bi, int offset);

@DllImport("icuuc.dll")
PSTR ubrk_getAvailable(int index);

@DllImport("icuuc.dll")
int ubrk_countAvailable();

@DllImport("icuuc.dll")
byte ubrk_isBoundary(UBreakIterator* bi, int offset);

@DllImport("icuuc.dll")
int ubrk_getRuleStatus(UBreakIterator* bi);

@DllImport("icuuc.dll")
int ubrk_getRuleStatusVec(UBreakIterator* bi, int* fillInVec, int capacity, UErrorCode* status);

@DllImport("icuuc.dll")
PSTR ubrk_getLocaleByType(const(UBreakIterator)* bi, ULocDataLocaleType type, UErrorCode* status);

@DllImport("icuuc.dll")
void ubrk_refreshUText(UBreakIterator* bi, UText* text, UErrorCode* status);

@DllImport("icuuc.dll")
int ubrk_getBinaryRules(UBreakIterator* bi, ubyte* binaryRules, int rulesCapacity, UErrorCode* status);

@DllImport("icuuc.dll")
void u_getDataVersion(ubyte* dataVersionFillin, UErrorCode* status);

@DllImport("icuin.dll")
UEnumeration* ucal_openTimeZoneIDEnumeration(USystemTimeZoneType zoneType, const(PSTR) region, 
                                             const(int)* rawOffset, UErrorCode* ec);

@DllImport("icuin.dll")
UEnumeration* ucal_openTimeZones(UErrorCode* ec);

@DllImport("icuin.dll")
UEnumeration* ucal_openCountryTimeZones(const(PSTR) country, UErrorCode* ec);

@DllImport("icuin.dll")
int ucal_getDefaultTimeZone(ushort* result, int resultCapacity, UErrorCode* ec);

@DllImport("icuin.dll")
void ucal_setDefaultTimeZone(const(ushort)* zoneID, UErrorCode* ec);

@DllImport("icu.dll")
int ucal_getHostTimeZone(ushort* result, int resultCapacity, UErrorCode* ec);

@DllImport("icuin.dll")
int ucal_getDSTSavings(const(ushort)* zoneID, UErrorCode* ec);

@DllImport("icuin.dll")
double ucal_getNow();

@DllImport("icuin.dll")
void** ucal_open(const(ushort)* zoneID, int len, const(PSTR) locale, UCalendarType type, UErrorCode* status);

@DllImport("icuin.dll")
void ucal_close(void** cal);

@DllImport("icuin.dll")
void** ucal_clone(const(void)** cal, UErrorCode* status);

@DllImport("icuin.dll")
void ucal_setTimeZone(void** cal, const(ushort)* zoneID, int len, UErrorCode* status);

@DllImport("icuin.dll")
int ucal_getTimeZoneID(const(void)** cal, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icuin.dll")
int ucal_getTimeZoneDisplayName(const(void)** cal, UCalendarDisplayNameType type, const(PSTR) locale, 
                                ushort* result, int resultLength, UErrorCode* status);

@DllImport("icuin.dll")
byte ucal_inDaylightTime(const(void)** cal, UErrorCode* status);

@DllImport("icuin.dll")
void ucal_setGregorianChange(void** cal, double date, UErrorCode* pErrorCode);

@DllImport("icuin.dll")
double ucal_getGregorianChange(const(void)** cal, UErrorCode* pErrorCode);

@DllImport("icuin.dll")
int ucal_getAttribute(const(void)** cal, UCalendarAttribute attr);

@DllImport("icuin.dll")
void ucal_setAttribute(void** cal, UCalendarAttribute attr, int newValue);

@DllImport("icuin.dll")
PSTR ucal_getAvailable(int localeIndex);

@DllImport("icuin.dll")
int ucal_countAvailable();

@DllImport("icuin.dll")
double ucal_getMillis(const(void)** cal, UErrorCode* status);

@DllImport("icuin.dll")
void ucal_setMillis(void** cal, double dateTime, UErrorCode* status);

@DllImport("icuin.dll")
void ucal_setDate(void** cal, int year, int month, int date, UErrorCode* status);

@DllImport("icuin.dll")
void ucal_setDateTime(void** cal, int year, int month, int date, int hour, int minute, int second, 
                      UErrorCode* status);

@DllImport("icuin.dll")
byte ucal_equivalentTo(const(void)** cal1, const(void)** cal2);

@DllImport("icuin.dll")
void ucal_add(void** cal, UCalendarDateFields field, int amount, UErrorCode* status);

@DllImport("icuin.dll")
void ucal_roll(void** cal, UCalendarDateFields field, int amount, UErrorCode* status);

@DllImport("icuin.dll")
int ucal_get(const(void)** cal, UCalendarDateFields field, UErrorCode* status);

@DllImport("icuin.dll")
void ucal_set(void** cal, UCalendarDateFields field, int value);

@DllImport("icuin.dll")
byte ucal_isSet(const(void)** cal, UCalendarDateFields field);

@DllImport("icuin.dll")
void ucal_clearField(void** cal, UCalendarDateFields field);

@DllImport("icuin.dll")
void ucal_clear(void** calendar);

@DllImport("icuin.dll")
int ucal_getLimit(const(void)** cal, UCalendarDateFields field, UCalendarLimitType type, UErrorCode* status);

@DllImport("icuin.dll")
PSTR ucal_getLocaleByType(const(void)** cal, ULocDataLocaleType type, UErrorCode* status);

@DllImport("icuin.dll")
PSTR ucal_getTZDataVersion(UErrorCode* status);

@DllImport("icuin.dll")
int ucal_getCanonicalTimeZoneID(const(ushort)* id, int len, ushort* result, int resultCapacity, byte* isSystemID, 
                                UErrorCode* status);

@DllImport("icuin.dll")
PSTR ucal_getType(const(void)** cal, UErrorCode* status);

@DllImport("icuin.dll")
UEnumeration* ucal_getKeywordValuesForLocale(const(PSTR) key, const(PSTR) locale, byte commonlyUsed, 
                                             UErrorCode* status);

@DllImport("icuin.dll")
UCalendarWeekdayType ucal_getDayOfWeekType(const(void)** cal, UCalendarDaysOfWeek dayOfWeek, UErrorCode* status);

@DllImport("icuin.dll")
int ucal_getWeekendTransition(const(void)** cal, UCalendarDaysOfWeek dayOfWeek, UErrorCode* status);

@DllImport("icuin.dll")
byte ucal_isWeekend(const(void)** cal, double date, UErrorCode* status);

@DllImport("icuin.dll")
int ucal_getFieldDifference(void** cal, double target, UCalendarDateFields field, UErrorCode* status);

@DllImport("icuin.dll")
byte ucal_getTimeZoneTransitionDate(const(void)** cal, UTimeZoneTransitionType type, double* transition, 
                                    UErrorCode* status);

@DllImport("icuin.dll")
int ucal_getWindowsTimeZoneID(const(ushort)* id, int len, ushort* winid, int winidCapacity, UErrorCode* status);

@DllImport("icuin.dll")
int ucal_getTimeZoneIDForWindowsID(const(ushort)* winid, int len, const(PSTR) region, ushort* id, int idCapacity, 
                                   UErrorCode* status);

@DllImport("icu.dll")
void ucal_getTimeZoneOffsetFromLocal(const(void)** cal, UTimeZoneLocalOption nonExistingTimeOpt, 
                                     UTimeZoneLocalOption duplicatedTimeOpt, int* rawOffset, int* dstOffset, 
                                     UErrorCode* status);

@DllImport("icuin.dll")
UCollator* ucol_open(const(PSTR) loc, UErrorCode* status);

@DllImport("icuin.dll")
UCollator* ucol_openRules(const(ushort)* rules, int rulesLength, UColAttributeValue normalizationMode, 
                          UColAttributeValue strength, UParseError* parseError, UErrorCode* status);

@DllImport("icuin.dll")
void ucol_getContractionsAndExpansions(const(UCollator)* coll, USet* contractions, USet* expansions, 
                                       byte addPrefixes, UErrorCode* status);

@DllImport("icuin.dll")
void ucol_close(UCollator* coll);

@DllImport("icuin.dll")
UCollationResult ucol_strcoll(const(UCollator)* coll, const(ushort)* source, int sourceLength, 
                              const(ushort)* target, int targetLength);

@DllImport("icuin.dll")
UCollationResult ucol_strcollUTF8(const(UCollator)* coll, const(PSTR) source, int sourceLength, const(PSTR) target, 
                                  int targetLength, UErrorCode* status);

@DllImport("icuin.dll")
byte ucol_greater(const(UCollator)* coll, const(ushort)* source, int sourceLength, const(ushort)* target, 
                  int targetLength);

@DllImport("icuin.dll")
byte ucol_greaterOrEqual(const(UCollator)* coll, const(ushort)* source, int sourceLength, const(ushort)* target, 
                         int targetLength);

@DllImport("icuin.dll")
byte ucol_equal(const(UCollator)* coll, const(ushort)* source, int sourceLength, const(ushort)* target, 
                int targetLength);

@DllImport("icuin.dll")
UCollationResult ucol_strcollIter(const(UCollator)* coll, UCharIterator* sIter, UCharIterator* tIter, 
                                  UErrorCode* status);

@DllImport("icuin.dll")
UColAttributeValue ucol_getStrength(const(UCollator)* coll);

@DllImport("icuin.dll")
void ucol_setStrength(UCollator* coll, UColAttributeValue strength);

@DllImport("icuin.dll")
int ucol_getReorderCodes(const(UCollator)* coll, int* dest, int destCapacity, UErrorCode* pErrorCode);

@DllImport("icuin.dll")
void ucol_setReorderCodes(UCollator* coll, const(int)* reorderCodes, int reorderCodesLength, 
                          UErrorCode* pErrorCode);

@DllImport("icuin.dll")
int ucol_getEquivalentReorderCodes(int reorderCode, int* dest, int destCapacity, UErrorCode* pErrorCode);

@DllImport("icuin.dll")
int ucol_getDisplayName(const(PSTR) objLoc, const(PSTR) dispLoc, ushort* result, int resultLength, 
                        UErrorCode* status);

@DllImport("icuin.dll")
PSTR ucol_getAvailable(int localeIndex);

@DllImport("icuin.dll")
int ucol_countAvailable();

@DllImport("icuin.dll")
UEnumeration* ucol_openAvailableLocales(UErrorCode* status);

@DllImport("icuin.dll")
UEnumeration* ucol_getKeywords(UErrorCode* status);

@DllImport("icuin.dll")
UEnumeration* ucol_getKeywordValues(const(PSTR) keyword, UErrorCode* status);

@DllImport("icuin.dll")
UEnumeration* ucol_getKeywordValuesForLocale(const(PSTR) key, const(PSTR) locale, byte commonlyUsed, 
                                             UErrorCode* status);

@DllImport("icuin.dll")
int ucol_getFunctionalEquivalent(PSTR result, int resultCapacity, const(PSTR) keyword, const(PSTR) locale, 
                                 byte* isAvailable, UErrorCode* status);

@DllImport("icuin.dll")
ushort* ucol_getRules(const(UCollator)* coll, int* length);

@DllImport("icuin.dll")
int ucol_getSortKey(const(UCollator)* coll, const(ushort)* source, int sourceLength, ubyte* result, 
                    int resultLength);

@DllImport("icuin.dll")
int ucol_nextSortKeyPart(const(UCollator)* coll, UCharIterator* iter, uint* state, ubyte* dest, int count, 
                         UErrorCode* status);

@DllImport("icuin.dll")
int ucol_getBound(const(ubyte)* source, int sourceLength, UColBoundMode boundType, uint noOfLevels, ubyte* result, 
                  int resultLength, UErrorCode* status);

@DllImport("icuin.dll")
void ucol_getVersion(const(UCollator)* coll, ubyte* info);

@DllImport("icuin.dll")
void ucol_getUCAVersion(const(UCollator)* coll, ubyte* info);

@DllImport("icuin.dll")
int ucol_mergeSortkeys(const(ubyte)* src1, int src1Length, const(ubyte)* src2, int src2Length, ubyte* dest, 
                       int destCapacity);

@DllImport("icuin.dll")
void ucol_setAttribute(UCollator* coll, UColAttribute attr, UColAttributeValue value, UErrorCode* status);

@DllImport("icuin.dll")
UColAttributeValue ucol_getAttribute(const(UCollator)* coll, UColAttribute attr, UErrorCode* status);

@DllImport("icuin.dll")
void ucol_setMaxVariable(UCollator* coll, UColReorderCode group, UErrorCode* pErrorCode);

@DllImport("icuin.dll")
UColReorderCode ucol_getMaxVariable(const(UCollator)* coll);

@DllImport("icuin.dll")
uint ucol_getVariableTop(const(UCollator)* coll, UErrorCode* status);

@DllImport("icuin.dll")
UCollator* ucol_safeClone(const(UCollator)* coll, void* stackBuffer, int* pBufferSize, UErrorCode* status);

@DllImport("icu.dll")
UCollator* ucol_clone(const(UCollator)* coll, UErrorCode* status);

@DllImport("icuin.dll")
int ucol_getRulesEx(const(UCollator)* coll, UColRuleOption delta, ushort* buffer, int bufferLen);

@DllImport("icuin.dll")
PSTR ucol_getLocaleByType(const(UCollator)* coll, ULocDataLocaleType type, UErrorCode* status);

@DllImport("icuin.dll")
USet* ucol_getTailoredSet(const(UCollator)* coll, UErrorCode* status);

@DllImport("icuin.dll")
int ucol_cloneBinary(const(UCollator)* coll, ubyte* buffer, int capacity, UErrorCode* status);

@DllImport("icuin.dll")
UCollator* ucol_openBinary(const(ubyte)* bin, int length, const(UCollator)* base, UErrorCode* status);

@DllImport("icuin.dll")
UCollationElements* ucol_openElements(const(UCollator)* coll, const(ushort)* text, int textLength, 
                                      UErrorCode* status);

@DllImport("icuin.dll")
int ucol_keyHashCode(const(ubyte)* key, int length);

@DllImport("icuin.dll")
void ucol_closeElements(UCollationElements* elems);

@DllImport("icuin.dll")
void ucol_reset(UCollationElements* elems);

@DllImport("icuin.dll")
int ucol_next(UCollationElements* elems, UErrorCode* status);

@DllImport("icuin.dll")
int ucol_previous(UCollationElements* elems, UErrorCode* status);

@DllImport("icuin.dll")
int ucol_getMaxExpansion(const(UCollationElements)* elems, int order);

@DllImport("icuin.dll")
void ucol_setText(UCollationElements* elems, const(ushort)* text, int textLength, UErrorCode* status);

@DllImport("icuin.dll")
int ucol_getOffset(const(UCollationElements)* elems);

@DllImport("icuin.dll")
void ucol_setOffset(UCollationElements* elems, int offset, UErrorCode* status);

@DllImport("icuin.dll")
int ucol_primaryOrder(int order);

@DllImport("icuin.dll")
int ucol_secondaryOrder(int order);

@DllImport("icuin.dll")
int ucol_tertiaryOrder(int order);

@DllImport("icuin.dll")
UCharsetDetector* ucsdet_open(UErrorCode* status);

@DllImport("icuin.dll")
void ucsdet_close(UCharsetDetector* ucsd);

@DllImport("icuin.dll")
void ucsdet_setText(UCharsetDetector* ucsd, const(PSTR) textIn, int len, UErrorCode* status);

@DllImport("icuin.dll")
void ucsdet_setDeclaredEncoding(UCharsetDetector* ucsd, const(PSTR) encoding, int length, UErrorCode* status);

@DllImport("icuin.dll")
UCharsetMatch* ucsdet_detect(UCharsetDetector* ucsd, UErrorCode* status);

@DllImport("icuin.dll")
UCharsetMatch** ucsdet_detectAll(UCharsetDetector* ucsd, int* matchesFound, UErrorCode* status);

@DllImport("icuin.dll")
PSTR ucsdet_getName(const(UCharsetMatch)* ucsm, UErrorCode* status);

@DllImport("icuin.dll")
int ucsdet_getConfidence(const(UCharsetMatch)* ucsm, UErrorCode* status);

@DllImport("icuin.dll")
PSTR ucsdet_getLanguage(const(UCharsetMatch)* ucsm, UErrorCode* status);

@DllImport("icuin.dll")
int ucsdet_getUChars(const(UCharsetMatch)* ucsm, ushort* buf, int cap, UErrorCode* status);

@DllImport("icuin.dll")
UEnumeration* ucsdet_getAllDetectableCharsets(const(UCharsetDetector)* ucsd, UErrorCode* status);

@DllImport("icuin.dll")
byte ucsdet_isInputFilterEnabled(const(UCharsetDetector)* ucsd);

@DllImport("icuin.dll")
byte ucsdet_enableInputFilter(UCharsetDetector* ucsd, byte filter);

@DllImport("icuin.dll")
UFieldPositionIterator* ufieldpositer_open(UErrorCode* status);

@DllImport("icuin.dll")
void ufieldpositer_close(UFieldPositionIterator* fpositer);

@DllImport("icuin.dll")
int ufieldpositer_next(UFieldPositionIterator* fpositer, int* beginIndex, int* endIndex);

@DllImport("icuin.dll")
void** ufmt_open(UErrorCode* status);

@DllImport("icuin.dll")
void ufmt_close(void** fmt);

@DllImport("icuin.dll")
UFormattableType ufmt_getType(const(void)** fmt, UErrorCode* status);

@DllImport("icuin.dll")
byte ufmt_isNumeric(const(void)** fmt);

@DllImport("icuin.dll")
double ufmt_getDate(const(void)** fmt, UErrorCode* status);

@DllImport("icuin.dll")
double ufmt_getDouble(void** fmt, UErrorCode* status);

@DllImport("icuin.dll")
int ufmt_getLong(void** fmt, UErrorCode* status);

@DllImport("icuin.dll")
long ufmt_getInt64(void** fmt, UErrorCode* status);

@DllImport("icuin.dll")
void* ufmt_getObject(const(void)** fmt, UErrorCode* status);

@DllImport("icuin.dll")
ushort* ufmt_getUChars(void** fmt, int* len, UErrorCode* status);

@DllImport("icuin.dll")
int ufmt_getArrayLength(const(void)** fmt, UErrorCode* status);

@DllImport("icuin.dll")
void** ufmt_getArrayItemByIndex(void** fmt, int n, UErrorCode* status);

@DllImport("icuin.dll")
PSTR ufmt_getDecNumChars(void** fmt, int* len, UErrorCode* status);

@DllImport("icu.dll")
UConstrainedFieldPosition* ucfpos_open(UErrorCode* ec);

@DllImport("icu.dll")
void ucfpos_reset(UConstrainedFieldPosition* ucfpos, UErrorCode* ec);

@DllImport("icu.dll")
void ucfpos_close(UConstrainedFieldPosition* ucfpos);

@DllImport("icu.dll")
void ucfpos_constrainCategory(UConstrainedFieldPosition* ucfpos, int category, UErrorCode* ec);

@DllImport("icu.dll")
void ucfpos_constrainField(UConstrainedFieldPosition* ucfpos, int category, int field, UErrorCode* ec);

@DllImport("icu.dll")
int ucfpos_getCategory(const(UConstrainedFieldPosition)* ucfpos, UErrorCode* ec);

@DllImport("icu.dll")
int ucfpos_getField(const(UConstrainedFieldPosition)* ucfpos, UErrorCode* ec);

@DllImport("icu.dll")
void ucfpos_getIndexes(const(UConstrainedFieldPosition)* ucfpos, int* pStart, int* pLimit, UErrorCode* ec);

@DllImport("icu.dll")
long ucfpos_getInt64IterationContext(const(UConstrainedFieldPosition)* ucfpos, UErrorCode* ec);

@DllImport("icu.dll")
void ucfpos_setInt64IterationContext(UConstrainedFieldPosition* ucfpos, long context, UErrorCode* ec);

@DllImport("icu.dll")
byte ucfpos_matchesField(const(UConstrainedFieldPosition)* ucfpos, int category, int field, UErrorCode* ec);

@DllImport("icu.dll")
void ucfpos_setState(UConstrainedFieldPosition* ucfpos, int category, int field, int start, int limit, 
                     UErrorCode* ec);

@DllImport("icu.dll")
ushort* ufmtval_getString(const(UFormattedValue)* ufmtval, int* pLength, UErrorCode* ec);

@DllImport("icu.dll")
byte ufmtval_nextPosition(const(UFormattedValue)* ufmtval, UConstrainedFieldPosition* ucfpos, UErrorCode* ec);

@DllImport("icuin.dll")
UDateIntervalFormat* udtitvfmt_open(const(PSTR) locale, const(ushort)* skeleton, int skeletonLength, 
                                    const(ushort)* tzID, int tzIDLength, UErrorCode* status);

@DllImport("icuin.dll")
void udtitvfmt_close(UDateIntervalFormat* formatter);

@DllImport("icu.dll")
UFormattedDateInterval* udtitvfmt_openResult(UErrorCode* ec);

@DllImport("icu.dll")
UFormattedValue* udtitvfmt_resultAsValue(const(UFormattedDateInterval)* uresult, UErrorCode* ec);

@DllImport("icu.dll")
void udtitvfmt_closeResult(UFormattedDateInterval* uresult);

@DllImport("icuin.dll")
int udtitvfmt_format(const(UDateIntervalFormat)* formatter, double fromDate, double toDate, ushort* result, 
                     int resultCapacity, UFieldPosition* position, UErrorCode* status);

@DllImport("icu.dll")
void udtitvfmt_formatToResult(const(UDateIntervalFormat)* formatter, double fromDate, double toDate, 
                              UFormattedDateInterval* result, UErrorCode* status);

@DllImport("icu.dll")
void udtitvfmt_setContext(UDateIntervalFormat* formatter, UDisplayContext value, UErrorCode* status);

@DllImport("icu.dll")
UDisplayContext udtitvfmt_getContext(const(UDateIntervalFormat)* formatter, UDisplayContextType type, 
                                     UErrorCode* status);

@DllImport("icuin.dll")
UGenderInfo* ugender_getInstance(const(PSTR) locale, UErrorCode* status);

@DllImport("icuin.dll")
UGender ugender_getListGender(const(UGenderInfo)* genderInfo, const(UGender)* genders, int size, 
                              UErrorCode* status);

@DllImport("icuuc.dll")
UListFormatter* ulistfmt_open(const(PSTR) locale, UErrorCode* status);

@DllImport("icu.dll")
UListFormatter* ulistfmt_openForType(const(PSTR) locale, UListFormatterType type, UListFormatterWidth width, 
                                     UErrorCode* status);

@DllImport("icuuc.dll")
void ulistfmt_close(UListFormatter* listfmt);

@DllImport("icu.dll")
UFormattedList* ulistfmt_openResult(UErrorCode* ec);

@DllImport("icu.dll")
UFormattedValue* ulistfmt_resultAsValue(const(UFormattedList)* uresult, UErrorCode* ec);

@DllImport("icu.dll")
void ulistfmt_closeResult(UFormattedList* uresult);

@DllImport("icuuc.dll")
int ulistfmt_format(const(UListFormatter)* listfmt, const(ushort)** strings, const(int)* stringLengths, 
                    int stringCount, ushort* result, int resultCapacity, UErrorCode* status);

@DllImport("icu.dll")
void ulistfmt_formatStringsToResult(const(UListFormatter)* listfmt, const(ushort)** strings, 
                                    const(int)* stringLengths, int stringCount, UFormattedList* uresult, 
                                    UErrorCode* status);

@DllImport("icuin.dll")
ULocaleData* ulocdata_open(const(PSTR) localeID, UErrorCode* status);

@DllImport("icuin.dll")
void ulocdata_close(ULocaleData* uld);

@DllImport("icuin.dll")
void ulocdata_setNoSubstitute(ULocaleData* uld, byte setting);

@DllImport("icuin.dll")
byte ulocdata_getNoSubstitute(ULocaleData* uld);

@DllImport("icuin.dll")
USet* ulocdata_getExemplarSet(ULocaleData* uld, USet* fillIn, uint options, ULocaleDataExemplarSetType extype, 
                              UErrorCode* status);

@DllImport("icuin.dll")
int ulocdata_getDelimiter(ULocaleData* uld, ULocaleDataDelimiterType type, ushort* result, int resultLength, 
                          UErrorCode* status);

@DllImport("icuin.dll")
UMeasurementSystem ulocdata_getMeasurementSystem(const(PSTR) localeID, UErrorCode* status);

@DllImport("icuin.dll")
void ulocdata_getPaperSize(const(PSTR) localeID, int* height, int* width, UErrorCode* status);

@DllImport("icuin.dll")
void ulocdata_getCLDRVersion(ubyte* versionArray, UErrorCode* status);

@DllImport("icuin.dll")
int ulocdata_getLocaleDisplayPattern(ULocaleData* uld, ushort* pattern, int patternCapacity, UErrorCode* status);

@DllImport("icuin.dll")
int ulocdata_getLocaleSeparator(ULocaleData* uld, ushort* separator, int separatorCapacity, UErrorCode* status);

@DllImport("icuin.dll")
int u_formatMessage(const(PSTR) locale, const(ushort)* pattern, int patternLength, ushort* result, 
                    int resultLength, UErrorCode* status);

@DllImport("icuin.dll")
int u_vformatMessage(const(PSTR) locale, const(ushort)* pattern, int patternLength, ushort* result, 
                     int resultLength, byte* ap, UErrorCode* status);

@DllImport("icuin.dll")
void u_parseMessage(const(PSTR) locale, const(ushort)* pattern, int patternLength, const(ushort)* source, 
                    int sourceLength, UErrorCode* status);

@DllImport("icuin.dll")
void u_vparseMessage(const(PSTR) locale, const(ushort)* pattern, int patternLength, const(ushort)* source, 
                     int sourceLength, byte* ap, UErrorCode* status);

@DllImport("icuin.dll")
int u_formatMessageWithError(const(PSTR) locale, const(ushort)* pattern, int patternLength, ushort* result, 
                             int resultLength, UParseError* parseError, UErrorCode* status);

@DllImport("icuin.dll")
int u_vformatMessageWithError(const(PSTR) locale, const(ushort)* pattern, int patternLength, ushort* result, 
                              int resultLength, UParseError* parseError, byte* ap, UErrorCode* status);

@DllImport("icuin.dll")
void u_parseMessageWithError(const(PSTR) locale, const(ushort)* pattern, int patternLength, const(ushort)* source, 
                             int sourceLength, UParseError* parseError, UErrorCode* status);

@DllImport("icuin.dll")
void u_vparseMessageWithError(const(PSTR) locale, const(ushort)* pattern, int patternLength, const(ushort)* source, 
                              int sourceLength, byte* ap, UParseError* parseError, UErrorCode* status);

@DllImport("icuin.dll")
void** umsg_open(const(ushort)* pattern, int patternLength, const(PSTR) locale, UParseError* parseError, 
                 UErrorCode* status);

@DllImport("icuin.dll")
void umsg_close(void** format);

@DllImport("icuin.dll")
void* umsg_clone(const(void)** fmt, UErrorCode* status);

@DllImport("icuin.dll")
void umsg_setLocale(void** fmt, const(PSTR) locale);

@DllImport("icuin.dll")
PSTR umsg_getLocale(const(void)** fmt);

@DllImport("icuin.dll")
void umsg_applyPattern(void** fmt, const(ushort)* pattern, int patternLength, UParseError* parseError, 
                       UErrorCode* status);

@DllImport("icuin.dll")
int umsg_toPattern(const(void)** fmt, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icuin.dll")
int umsg_format(const(void)** fmt, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icuin.dll")
int umsg_vformat(const(void)** fmt, ushort* result, int resultLength, byte* ap, UErrorCode* status);

@DllImport("icuin.dll")
void umsg_parse(const(void)** fmt, const(ushort)* source, int sourceLength, int* count, UErrorCode* status);

@DllImport("icuin.dll")
void umsg_vparse(const(void)** fmt, const(ushort)* source, int sourceLength, int* count, byte* ap, 
                 UErrorCode* status);

@DllImport("icuin.dll")
int umsg_autoQuoteApostrophe(const(ushort)* pattern, int patternLength, ushort* dest, int destCapacity, 
                             UErrorCode* ec);

@DllImport("icuin.dll")
void** unum_open(UNumberFormatStyle style, const(ushort)* pattern, int patternLength, const(PSTR) locale, 
                 UParseError* parseErr, UErrorCode* status);

@DllImport("icuin.dll")
void unum_close(void** fmt);

@DllImport("icuin.dll")
void** unum_clone(const(void)** fmt, UErrorCode* status);

@DllImport("icuin.dll")
int unum_format(const(void)** fmt, int number, ushort* result, int resultLength, UFieldPosition* pos, 
                UErrorCode* status);

@DllImport("icuin.dll")
int unum_formatInt64(const(void)** fmt, long number, ushort* result, int resultLength, UFieldPosition* pos, 
                     UErrorCode* status);

@DllImport("icuin.dll")
int unum_formatDouble(const(void)** fmt, double number, ushort* result, int resultLength, UFieldPosition* pos, 
                      UErrorCode* status);

@DllImport("icuin.dll")
int unum_formatDoubleForFields(const(void)** format, double number, ushort* result, int resultLength, 
                               UFieldPositionIterator* fpositer, UErrorCode* status);

@DllImport("icuin.dll")
int unum_formatDecimal(const(void)** fmt, const(PSTR) number, int length, ushort* result, int resultLength, 
                       UFieldPosition* pos, UErrorCode* status);

@DllImport("icuin.dll")
int unum_formatDoubleCurrency(const(void)** fmt, double number, ushort* currency, ushort* result, int resultLength, 
                              UFieldPosition* pos, UErrorCode* status);

@DllImport("icuin.dll")
int unum_formatUFormattable(const(void)** fmt, const(void)** number, ushort* result, int resultLength, 
                            UFieldPosition* pos, UErrorCode* status);

@DllImport("icuin.dll")
int unum_parse(const(void)** fmt, const(ushort)* text, int textLength, int* parsePos, UErrorCode* status);

@DllImport("icuin.dll")
long unum_parseInt64(const(void)** fmt, const(ushort)* text, int textLength, int* parsePos, UErrorCode* status);

@DllImport("icuin.dll")
double unum_parseDouble(const(void)** fmt, const(ushort)* text, int textLength, int* parsePos, UErrorCode* status);

@DllImport("icuin.dll")
int unum_parseDecimal(const(void)** fmt, const(ushort)* text, int textLength, int* parsePos, PSTR outBuf, 
                      int outBufLength, UErrorCode* status);

@DllImport("icuin.dll")
double unum_parseDoubleCurrency(const(void)** fmt, const(ushort)* text, int textLength, int* parsePos, 
                                ushort* currency, UErrorCode* status);

@DllImport("icuin.dll")
void** unum_parseToUFormattable(const(void)** fmt, void** result, const(ushort)* text, int textLength, 
                                int* parsePos, UErrorCode* status);

@DllImport("icuin.dll")
void unum_applyPattern(void** format, byte localized, const(ushort)* pattern, int patternLength, 
                       UParseError* parseError, UErrorCode* status);

@DllImport("icuin.dll")
PSTR unum_getAvailable(int localeIndex);

@DllImport("icuin.dll")
int unum_countAvailable();

@DllImport("icuin.dll")
int unum_getAttribute(const(void)** fmt, UNumberFormatAttribute attr);

@DllImport("icuin.dll")
void unum_setAttribute(void** fmt, UNumberFormatAttribute attr, int newValue);

@DllImport("icuin.dll")
double unum_getDoubleAttribute(const(void)** fmt, UNumberFormatAttribute attr);

@DllImport("icuin.dll")
void unum_setDoubleAttribute(void** fmt, UNumberFormatAttribute attr, double newValue);

@DllImport("icuin.dll")
int unum_getTextAttribute(const(void)** fmt, UNumberFormatTextAttribute tag, ushort* result, int resultLength, 
                          UErrorCode* status);

@DllImport("icuin.dll")
void unum_setTextAttribute(void** fmt, UNumberFormatTextAttribute tag, const(ushort)* newValue, int newValueLength, 
                           UErrorCode* status);

@DllImport("icuin.dll")
int unum_toPattern(const(void)** fmt, byte isPatternLocalized, ushort* result, int resultLength, 
                   UErrorCode* status);

@DllImport("icuin.dll")
int unum_getSymbol(const(void)** fmt, UNumberFormatSymbol symbol, ushort* buffer, int size, UErrorCode* status);

@DllImport("icuin.dll")
void unum_setSymbol(void** fmt, UNumberFormatSymbol symbol, const(ushort)* value, int length, UErrorCode* status);

@DllImport("icuin.dll")
PSTR unum_getLocaleByType(const(void)** fmt, ULocDataLocaleType type, UErrorCode* status);

@DllImport("icuin.dll")
void unum_setContext(void** fmt, UDisplayContext value, UErrorCode* status);

@DllImport("icuin.dll")
UDisplayContext unum_getContext(const(void)** fmt, UDisplayContextType type, UErrorCode* status);

@DllImport("icuin.dll")
UCalendarDateFields udat_toCalendarDateField(UDateFormatField field);

@DllImport("icuin.dll")
void** udat_open(UDateFormatStyle timeStyle, UDateFormatStyle dateStyle, const(PSTR) locale, const(ushort)* tzID, 
                 int tzIDLength, const(ushort)* pattern, int patternLength, UErrorCode* status);

@DllImport("icuin.dll")
void udat_close(void** format);

@DllImport("icuin.dll")
byte udat_getBooleanAttribute(const(void)** fmt, UDateFormatBooleanAttribute attr, UErrorCode* status);

@DllImport("icuin.dll")
void udat_setBooleanAttribute(void** fmt, UDateFormatBooleanAttribute attr, byte newValue, UErrorCode* status);

@DllImport("icuin.dll")
void** udat_clone(const(void)** fmt, UErrorCode* status);

@DllImport("icuin.dll")
int udat_format(const(void)** format, double dateToFormat, ushort* result, int resultLength, 
                UFieldPosition* position, UErrorCode* status);

@DllImport("icuin.dll")
int udat_formatCalendar(const(void)** format, void** calendar, ushort* result, int capacity, 
                        UFieldPosition* position, UErrorCode* status);

@DllImport("icuin.dll")
int udat_formatForFields(const(void)** format, double dateToFormat, ushort* result, int resultLength, 
                         UFieldPositionIterator* fpositer, UErrorCode* status);

@DllImport("icuin.dll")
int udat_formatCalendarForFields(const(void)** format, void** calendar, ushort* result, int capacity, 
                                 UFieldPositionIterator* fpositer, UErrorCode* status);

@DllImport("icuin.dll")
double udat_parse(const(void)** format, const(ushort)* text, int textLength, int* parsePos, UErrorCode* status);

@DllImport("icuin.dll")
void udat_parseCalendar(const(void)** format, void** calendar, const(ushort)* text, int textLength, int* parsePos, 
                        UErrorCode* status);

@DllImport("icuin.dll")
byte udat_isLenient(const(void)** fmt);

@DllImport("icuin.dll")
void udat_setLenient(void** fmt, byte isLenient);

@DllImport("icuin.dll")
void** udat_getCalendar(const(void)** fmt);

@DllImport("icuin.dll")
void udat_setCalendar(void** fmt, const(void)** calendarToSet);

@DllImport("icuin.dll")
void** udat_getNumberFormat(const(void)** fmt);

@DllImport("icuin.dll")
void** udat_getNumberFormatForField(const(void)** fmt, ushort field);

@DllImport("icuin.dll")
void udat_adoptNumberFormatForFields(void** fmt, const(ushort)* fields, void** numberFormatToSet, 
                                     UErrorCode* status);

@DllImport("icuin.dll")
void udat_setNumberFormat(void** fmt, const(void)** numberFormatToSet);

@DllImport("icuin.dll")
void udat_adoptNumberFormat(void** fmt, void** numberFormatToAdopt);

@DllImport("icuin.dll")
PSTR udat_getAvailable(int localeIndex);

@DllImport("icuin.dll")
int udat_countAvailable();

@DllImport("icuin.dll")
double udat_get2DigitYearStart(const(void)** fmt, UErrorCode* status);

@DllImport("icuin.dll")
void udat_set2DigitYearStart(void** fmt, double d, UErrorCode* status);

@DllImport("icuin.dll")
int udat_toPattern(const(void)** fmt, byte localized, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icuin.dll")
void udat_applyPattern(void** format, byte localized, const(ushort)* pattern, int patternLength);

@DllImport("icuin.dll")
int udat_getSymbols(const(void)** fmt, UDateFormatSymbolType type, int symbolIndex, ushort* result, 
                    int resultLength, UErrorCode* status);

@DllImport("icuin.dll")
int udat_countSymbols(const(void)** fmt, UDateFormatSymbolType type);

@DllImport("icuin.dll")
void udat_setSymbols(void** format, UDateFormatSymbolType type, int symbolIndex, ushort* value, int valueLength, 
                     UErrorCode* status);

@DllImport("icuin.dll")
PSTR udat_getLocaleByType(const(void)** fmt, ULocDataLocaleType type, UErrorCode* status);

@DllImport("icuin.dll")
void udat_setContext(void** fmt, UDisplayContext value, UErrorCode* status);

@DllImport("icuin.dll")
UDisplayContext udat_getContext(const(void)** fmt, UDisplayContextType type, UErrorCode* status);

@DllImport("icuin.dll")
void** udatpg_open(const(PSTR) locale, UErrorCode* pErrorCode);

@DllImport("icuin.dll")
void** udatpg_openEmpty(UErrorCode* pErrorCode);

@DllImport("icuin.dll")
void udatpg_close(void** dtpg);

@DllImport("icuin.dll")
void** udatpg_clone(const(void)** dtpg, UErrorCode* pErrorCode);

@DllImport("icuin.dll")
int udatpg_getBestPattern(void** dtpg, const(ushort)* skeleton, int length, ushort* bestPattern, int capacity, 
                          UErrorCode* pErrorCode);

@DllImport("icuin.dll")
int udatpg_getBestPatternWithOptions(void** dtpg, const(ushort)* skeleton, int length, 
                                     UDateTimePatternMatchOptions options, ushort* bestPattern, int capacity, 
                                     UErrorCode* pErrorCode);

@DllImport("icuin.dll")
int udatpg_getSkeleton(void** unusedDtpg, const(ushort)* pattern, int length, ushort* skeleton, int capacity, 
                       UErrorCode* pErrorCode);

@DllImport("icuin.dll")
int udatpg_getBaseSkeleton(void** unusedDtpg, const(ushort)* pattern, int length, ushort* baseSkeleton, 
                           int capacity, UErrorCode* pErrorCode);

@DllImport("icuin.dll")
UDateTimePatternConflict udatpg_addPattern(void** dtpg, const(ushort)* pattern, int patternLength, byte override_, 
                                           ushort* conflictingPattern, int capacity, int* pLength, 
                                           UErrorCode* pErrorCode);

@DllImport("icuin.dll")
void udatpg_setAppendItemFormat(void** dtpg, UDateTimePatternField field, const(ushort)* value, int length);

@DllImport("icuin.dll")
ushort* udatpg_getAppendItemFormat(const(void)** dtpg, UDateTimePatternField field, int* pLength);

@DllImport("icuin.dll")
void udatpg_setAppendItemName(void** dtpg, UDateTimePatternField field, const(ushort)* value, int length);

@DllImport("icuin.dll")
ushort* udatpg_getAppendItemName(const(void)** dtpg, UDateTimePatternField field, int* pLength);

@DllImport("icu.dll")
int udatpg_getFieldDisplayName(const(void)** dtpg, UDateTimePatternField field, UDateTimePGDisplayWidth width, 
                               ushort* fieldName, int capacity, UErrorCode* pErrorCode);

@DllImport("icuin.dll")
void udatpg_setDateTimeFormat(const(void)** dtpg, const(ushort)* dtFormat, int length);

@DllImport("icuin.dll")
ushort* udatpg_getDateTimeFormat(const(void)** dtpg, int* pLength);

@DllImport("icuin.dll")
void udatpg_setDecimal(void** dtpg, const(ushort)* decimal, int length);

@DllImport("icuin.dll")
ushort* udatpg_getDecimal(const(void)** dtpg, int* pLength);

@DllImport("icuin.dll")
int udatpg_replaceFieldTypes(void** dtpg, const(ushort)* pattern, int patternLength, const(ushort)* skeleton, 
                             int skeletonLength, ushort* dest, int destCapacity, UErrorCode* pErrorCode);

@DllImport("icuin.dll")
int udatpg_replaceFieldTypesWithOptions(void** dtpg, const(ushort)* pattern, int patternLength, 
                                        const(ushort)* skeleton, int skeletonLength, 
                                        UDateTimePatternMatchOptions options, ushort* dest, int destCapacity, 
                                        UErrorCode* pErrorCode);

@DllImport("icuin.dll")
UEnumeration* udatpg_openSkeletons(const(void)** dtpg, UErrorCode* pErrorCode);

@DllImport("icuin.dll")
UEnumeration* udatpg_openBaseSkeletons(const(void)** dtpg, UErrorCode* pErrorCode);

@DllImport("icuin.dll")
ushort* udatpg_getPatternForSkeleton(const(void)** dtpg, const(ushort)* skeleton, int skeletonLength, int* pLength);

@DllImport("icu.dll")
UDateFormatHourCycle udatpg_getDefaultHourCycle(const(void)** dtpg, UErrorCode* pErrorCode);

@DllImport("icu.dll")
UNumberFormatter* unumf_openForSkeletonAndLocale(const(ushort)* skeleton, int skeletonLen, const(PSTR) locale, 
                                                 UErrorCode* ec);

@DllImport("icu.dll")
UNumberFormatter* unumf_openForSkeletonAndLocaleWithError(const(ushort)* skeleton, int skeletonLen, 
                                                          const(PSTR) locale, UParseError* perror, UErrorCode* ec);

@DllImport("icu.dll")
UFormattedNumber* unumf_openResult(UErrorCode* ec);

@DllImport("icu.dll")
void unumf_formatInt(const(UNumberFormatter)* uformatter, long value, UFormattedNumber* uresult, UErrorCode* ec);

@DllImport("icu.dll")
void unumf_formatDouble(const(UNumberFormatter)* uformatter, double value, UFormattedNumber* uresult, 
                        UErrorCode* ec);

@DllImport("icu.dll")
void unumf_formatDecimal(const(UNumberFormatter)* uformatter, const(PSTR) value, int valueLen, 
                         UFormattedNumber* uresult, UErrorCode* ec);

@DllImport("icu.dll")
UFormattedValue* unumf_resultAsValue(const(UFormattedNumber)* uresult, UErrorCode* ec);

@DllImport("icu.dll")
int unumf_resultToString(const(UFormattedNumber)* uresult, ushort* buffer, int bufferCapacity, UErrorCode* ec);

@DllImport("icu.dll")
byte unumf_resultNextFieldPosition(const(UFormattedNumber)* uresult, UFieldPosition* ufpos, UErrorCode* ec);

@DllImport("icu.dll")
void unumf_resultGetAllFieldPositions(const(UFormattedNumber)* uresult, UFieldPositionIterator* ufpositer, 
                                      UErrorCode* ec);

@DllImport("icu.dll")
int unumf_resultToDecimalNumber(const(UFormattedNumber)* uresult, PSTR dest, int destCapacity, UErrorCode* ec);

@DllImport("icu.dll")
void unumf_close(UNumberFormatter* uformatter);

@DllImport("icu.dll")
void unumf_closeResult(UFormattedNumber* uresult);

@DllImport("icu.dll")
UNumberRangeFormatter* unumrf_openForSkeletonWithCollapseAndIdentityFallback(const(ushort)* skeleton, 
                                                                             int skeletonLen, 
                                                                             UNumberRangeCollapse collapse, 
                                                                             UNumberRangeIdentityFallback identityFallback, 
                                                                             const(PSTR) locale, UParseError* perror, 
                                                                             UErrorCode* ec);

@DllImport("icu.dll")
UFormattedNumberRange* unumrf_openResult(UErrorCode* ec);

@DllImport("icu.dll")
void unumrf_formatDoubleRange(const(UNumberRangeFormatter)* uformatter, double first, double second, 
                              UFormattedNumberRange* uresult, UErrorCode* ec);

@DllImport("icu.dll")
void unumrf_formatDecimalRange(const(UNumberRangeFormatter)* uformatter, const(PSTR) first, int firstLen, 
                               const(PSTR) second, int secondLen, UFormattedNumberRange* uresult, UErrorCode* ec);

@DllImport("icu.dll")
UFormattedValue* unumrf_resultAsValue(const(UFormattedNumberRange)* uresult, UErrorCode* ec);

@DllImport("icu.dll")
UNumberRangeIdentityResult unumrf_resultGetIdentityResult(const(UFormattedNumberRange)* uresult, UErrorCode* ec);

@DllImport("icu.dll")
int unumrf_resultGetFirstDecimalNumber(const(UFormattedNumberRange)* uresult, PSTR dest, int destCapacity, 
                                       UErrorCode* ec);

@DllImport("icu.dll")
int unumrf_resultGetSecondDecimalNumber(const(UFormattedNumberRange)* uresult, PSTR dest, int destCapacity, 
                                        UErrorCode* ec);

@DllImport("icu.dll")
void unumrf_close(UNumberRangeFormatter* uformatter);

@DllImport("icu.dll")
void unumrf_closeResult(UFormattedNumberRange* uresult);

@DllImport("icuin.dll")
UNumberingSystem* unumsys_open(const(PSTR) locale, UErrorCode* status);

@DllImport("icuin.dll")
UNumberingSystem* unumsys_openByName(const(PSTR) name, UErrorCode* status);

@DllImport("icuin.dll")
void unumsys_close(UNumberingSystem* unumsys);

@DllImport("icuin.dll")
UEnumeration* unumsys_openAvailableNames(UErrorCode* status);

@DllImport("icuin.dll")
PSTR unumsys_getName(const(UNumberingSystem)* unumsys);

@DllImport("icuin.dll")
byte unumsys_isAlgorithmic(const(UNumberingSystem)* unumsys);

@DllImport("icuin.dll")
int unumsys_getRadix(const(UNumberingSystem)* unumsys);

@DllImport("icuin.dll")
int unumsys_getDescription(const(UNumberingSystem)* unumsys, ushort* result, int resultLength, UErrorCode* status);

@DllImport("icuin.dll")
UPluralRules* uplrules_open(const(PSTR) locale, UErrorCode* status);

@DllImport("icuin.dll")
UPluralRules* uplrules_openForType(const(PSTR) locale, UPluralType type, UErrorCode* status);

@DllImport("icuin.dll")
void uplrules_close(UPluralRules* uplrules);

@DllImport("icuin.dll")
int uplrules_select(const(UPluralRules)* uplrules, double number, ushort* keyword, int capacity, 
                    UErrorCode* status);

@DllImport("icu.dll")
int uplrules_selectFormatted(const(UPluralRules)* uplrules, const(UFormattedNumber)* number, ushort* keyword, 
                             int capacity, UErrorCode* status);

@DllImport("icuin.dll")
UEnumeration* uplrules_getKeywords(const(UPluralRules)* uplrules, UErrorCode* status);

@DllImport("icuin.dll")
URegularExpression* uregex_open(const(ushort)* pattern, int patternLength, uint flags, UParseError* pe, 
                                UErrorCode* status);

@DllImport("icuin.dll")
URegularExpression* uregex_openUText(UText* pattern, uint flags, UParseError* pe, UErrorCode* status);

@DllImport("icuin.dll")
URegularExpression* uregex_openC(const(PSTR) pattern, uint flags, UParseError* pe, UErrorCode* status);

@DllImport("icuin.dll")
void uregex_close(URegularExpression* regexp);

@DllImport("icuin.dll")
URegularExpression* uregex_clone(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icuin.dll")
ushort* uregex_pattern(const(URegularExpression)* regexp, int* patLength, UErrorCode* status);

@DllImport("icuin.dll")
UText* uregex_patternUText(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icuin.dll")
int uregex_flags(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icuin.dll")
void uregex_setText(URegularExpression* regexp, const(ushort)* text, int textLength, UErrorCode* status);

@DllImport("icuin.dll")
void uregex_setUText(URegularExpression* regexp, UText* text, UErrorCode* status);

@DllImport("icuin.dll")
ushort* uregex_getText(URegularExpression* regexp, int* textLength, UErrorCode* status);

@DllImport("icuin.dll")
UText* uregex_getUText(URegularExpression* regexp, UText* dest, UErrorCode* status);

@DllImport("icuin.dll")
void uregex_refreshUText(URegularExpression* regexp, UText* text, UErrorCode* status);

@DllImport("icuin.dll")
byte uregex_matches(URegularExpression* regexp, int startIndex, UErrorCode* status);

@DllImport("icuin.dll")
byte uregex_matches64(URegularExpression* regexp, long startIndex, UErrorCode* status);

@DllImport("icuin.dll")
byte uregex_lookingAt(URegularExpression* regexp, int startIndex, UErrorCode* status);

@DllImport("icuin.dll")
byte uregex_lookingAt64(URegularExpression* regexp, long startIndex, UErrorCode* status);

@DllImport("icuin.dll")
byte uregex_find(URegularExpression* regexp, int startIndex, UErrorCode* status);

@DllImport("icuin.dll")
byte uregex_find64(URegularExpression* regexp, long startIndex, UErrorCode* status);

@DllImport("icuin.dll")
byte uregex_findNext(URegularExpression* regexp, UErrorCode* status);

@DllImport("icuin.dll")
int uregex_groupCount(URegularExpression* regexp, UErrorCode* status);

@DllImport("icuin.dll")
int uregex_groupNumberFromName(URegularExpression* regexp, const(ushort)* groupName, int nameLength, 
                               UErrorCode* status);

@DllImport("icuin.dll")
int uregex_groupNumberFromCName(URegularExpression* regexp, const(PSTR) groupName, int nameLength, 
                                UErrorCode* status);

@DllImport("icuin.dll")
int uregex_group(URegularExpression* regexp, int groupNum, ushort* dest, int destCapacity, UErrorCode* status);

@DllImport("icuin.dll")
UText* uregex_groupUText(URegularExpression* regexp, int groupNum, UText* dest, long* groupLength, 
                         UErrorCode* status);

@DllImport("icuin.dll")
int uregex_start(URegularExpression* regexp, int groupNum, UErrorCode* status);

@DllImport("icuin.dll")
long uregex_start64(URegularExpression* regexp, int groupNum, UErrorCode* status);

@DllImport("icuin.dll")
int uregex_end(URegularExpression* regexp, int groupNum, UErrorCode* status);

@DllImport("icuin.dll")
long uregex_end64(URegularExpression* regexp, int groupNum, UErrorCode* status);

@DllImport("icuin.dll")
void uregex_reset(URegularExpression* regexp, int index, UErrorCode* status);

@DllImport("icuin.dll")
void uregex_reset64(URegularExpression* regexp, long index, UErrorCode* status);

@DllImport("icuin.dll")
void uregex_setRegion(URegularExpression* regexp, int regionStart, int regionLimit, UErrorCode* status);

@DllImport("icuin.dll")
void uregex_setRegion64(URegularExpression* regexp, long regionStart, long regionLimit, UErrorCode* status);

@DllImport("icuin.dll")
void uregex_setRegionAndStart(URegularExpression* regexp, long regionStart, long regionLimit, long startIndex, 
                              UErrorCode* status);

@DllImport("icuin.dll")
int uregex_regionStart(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icuin.dll")
long uregex_regionStart64(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icuin.dll")
int uregex_regionEnd(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icuin.dll")
long uregex_regionEnd64(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icuin.dll")
byte uregex_hasTransparentBounds(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icuin.dll")
void uregex_useTransparentBounds(URegularExpression* regexp, byte b, UErrorCode* status);

@DllImport("icuin.dll")
byte uregex_hasAnchoringBounds(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icuin.dll")
void uregex_useAnchoringBounds(URegularExpression* regexp, byte b, UErrorCode* status);

@DllImport("icuin.dll")
byte uregex_hitEnd(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icuin.dll")
byte uregex_requireEnd(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icuin.dll")
int uregex_replaceAll(URegularExpression* regexp, const(ushort)* replacementText, int replacementLength, 
                      ushort* destBuf, int destCapacity, UErrorCode* status);

@DllImport("icuin.dll")
UText* uregex_replaceAllUText(URegularExpression* regexp, UText* replacement, UText* dest, UErrorCode* status);

@DllImport("icuin.dll")
int uregex_replaceFirst(URegularExpression* regexp, const(ushort)* replacementText, int replacementLength, 
                        ushort* destBuf, int destCapacity, UErrorCode* status);

@DllImport("icuin.dll")
UText* uregex_replaceFirstUText(URegularExpression* regexp, UText* replacement, UText* dest, UErrorCode* status);

@DllImport("icuin.dll")
int uregex_appendReplacement(URegularExpression* regexp, const(ushort)* replacementText, int replacementLength, 
                             ushort** destBuf, int* destCapacity, UErrorCode* status);

@DllImport("icuin.dll")
void uregex_appendReplacementUText(URegularExpression* regexp, UText* replacementText, UText* dest, 
                                   UErrorCode* status);

@DllImport("icuin.dll")
int uregex_appendTail(URegularExpression* regexp, ushort** destBuf, int* destCapacity, UErrorCode* status);

@DllImport("icuin.dll")
UText* uregex_appendTailUText(URegularExpression* regexp, UText* dest, UErrorCode* status);

@DllImport("icuin.dll")
int uregex_split(URegularExpression* regexp, ushort* destBuf, int destCapacity, int* requiredCapacity, 
                 ushort** destFields, int destFieldsCapacity, UErrorCode* status);

@DllImport("icuin.dll")
int uregex_splitUText(URegularExpression* regexp, UText** destFields, int destFieldsCapacity, UErrorCode* status);

@DllImport("icuin.dll")
void uregex_setTimeLimit(URegularExpression* regexp, int limit, UErrorCode* status);

@DllImport("icuin.dll")
int uregex_getTimeLimit(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icuin.dll")
void uregex_setStackLimit(URegularExpression* regexp, int limit, UErrorCode* status);

@DllImport("icuin.dll")
int uregex_getStackLimit(const(URegularExpression)* regexp, UErrorCode* status);

@DllImport("icuin.dll")
void uregex_setMatchCallback(URegularExpression* regexp, URegexMatchCallback callback, const(void)* context, 
                             UErrorCode* status);

@DllImport("icuin.dll")
void uregex_getMatchCallback(const(URegularExpression)* regexp, URegexMatchCallback* callback, 
                             const(void)** context, UErrorCode* status);

@DllImport("icuin.dll")
void uregex_setFindProgressCallback(URegularExpression* regexp, URegexFindProgressCallback callback, 
                                    const(void)* context, UErrorCode* status);

@DllImport("icuin.dll")
void uregex_getFindProgressCallback(const(URegularExpression)* regexp, URegexFindProgressCallback* callback, 
                                    const(void)** context, UErrorCode* status);

@DllImport("icuin.dll")
URegion* uregion_getRegionFromCode(const(PSTR) regionCode, UErrorCode* status);

@DllImport("icuin.dll")
URegion* uregion_getRegionFromNumericCode(int code, UErrorCode* status);

@DllImport("icuin.dll")
UEnumeration* uregion_getAvailable(URegionType type, UErrorCode* status);

@DllImport("icuin.dll")
byte uregion_areEqual(const(URegion)* uregion, const(URegion)* otherRegion);

@DllImport("icuin.dll")
URegion* uregion_getContainingRegion(const(URegion)* uregion);

@DllImport("icuin.dll")
URegion* uregion_getContainingRegionOfType(const(URegion)* uregion, URegionType type);

@DllImport("icuin.dll")
UEnumeration* uregion_getContainedRegions(const(URegion)* uregion, UErrorCode* status);

@DllImport("icuin.dll")
UEnumeration* uregion_getContainedRegionsOfType(const(URegion)* uregion, URegionType type, UErrorCode* status);

@DllImport("icuin.dll")
byte uregion_contains(const(URegion)* uregion, const(URegion)* otherRegion);

@DllImport("icuin.dll")
UEnumeration* uregion_getPreferredValues(const(URegion)* uregion, UErrorCode* status);

@DllImport("icuin.dll")
PSTR uregion_getRegionCode(const(URegion)* uregion);

@DllImport("icuin.dll")
int uregion_getNumericCode(const(URegion)* uregion);

@DllImport("icuin.dll")
URegionType uregion_getType(const(URegion)* uregion);

@DllImport("icuin.dll")
URelativeDateTimeFormatter* ureldatefmt_open(const(PSTR) locale, void** nfToAdopt, 
                                             UDateRelativeDateTimeFormatterStyle width, 
                                             UDisplayContext capitalizationContext, UErrorCode* status);

@DllImport("icuin.dll")
void ureldatefmt_close(URelativeDateTimeFormatter* reldatefmt);

@DllImport("icu.dll")
UFormattedRelativeDateTime* ureldatefmt_openResult(UErrorCode* ec);

@DllImport("icu.dll")
UFormattedValue* ureldatefmt_resultAsValue(const(UFormattedRelativeDateTime)* ufrdt, UErrorCode* ec);

@DllImport("icu.dll")
void ureldatefmt_closeResult(UFormattedRelativeDateTime* ufrdt);

@DllImport("icuin.dll")
int ureldatefmt_formatNumeric(const(URelativeDateTimeFormatter)* reldatefmt, double offset, 
                              URelativeDateTimeUnit unit, ushort* result, int resultCapacity, UErrorCode* status);

@DllImport("icu.dll")
void ureldatefmt_formatNumericToResult(const(URelativeDateTimeFormatter)* reldatefmt, double offset, 
                                       URelativeDateTimeUnit unit, UFormattedRelativeDateTime* result, 
                                       UErrorCode* status);

@DllImport("icuin.dll")
int ureldatefmt_format(const(URelativeDateTimeFormatter)* reldatefmt, double offset, URelativeDateTimeUnit unit, 
                       ushort* result, int resultCapacity, UErrorCode* status);

@DllImport("icu.dll")
void ureldatefmt_formatToResult(const(URelativeDateTimeFormatter)* reldatefmt, double offset, 
                                URelativeDateTimeUnit unit, UFormattedRelativeDateTime* result, UErrorCode* status);

@DllImport("icuin.dll")
int ureldatefmt_combineDateAndTime(const(URelativeDateTimeFormatter)* reldatefmt, 
                                   const(ushort)* relativeDateString, int relativeDateStringLen, 
                                   const(ushort)* timeString, int timeStringLen, ushort* result, int resultCapacity, 
                                   UErrorCode* status);

@DllImport("icuin.dll")
UStringSearch* usearch_open(const(ushort)* pattern, int patternlength, const(ushort)* text, int textlength, 
                            const(PSTR) locale, UBreakIterator* breakiter, UErrorCode* status);

@DllImport("icuin.dll")
UStringSearch* usearch_openFromCollator(const(ushort)* pattern, int patternlength, const(ushort)* text, 
                                        int textlength, const(UCollator)* collator, UBreakIterator* breakiter, 
                                        UErrorCode* status);

@DllImport("icuin.dll")
void usearch_close(UStringSearch* searchiter);

@DllImport("icuin.dll")
void usearch_setOffset(UStringSearch* strsrch, int position, UErrorCode* status);

@DllImport("icuin.dll")
int usearch_getOffset(const(UStringSearch)* strsrch);

@DllImport("icuin.dll")
void usearch_setAttribute(UStringSearch* strsrch, USearchAttribute attribute, USearchAttributeValue value, 
                          UErrorCode* status);

@DllImport("icuin.dll")
USearchAttributeValue usearch_getAttribute(const(UStringSearch)* strsrch, USearchAttribute attribute);

@DllImport("icuin.dll")
int usearch_getMatchedStart(const(UStringSearch)* strsrch);

@DllImport("icuin.dll")
int usearch_getMatchedLength(const(UStringSearch)* strsrch);

@DllImport("icuin.dll")
int usearch_getMatchedText(const(UStringSearch)* strsrch, ushort* result, int resultCapacity, UErrorCode* status);

@DllImport("icuin.dll")
void usearch_setBreakIterator(UStringSearch* strsrch, UBreakIterator* breakiter, UErrorCode* status);

@DllImport("icuin.dll")
UBreakIterator* usearch_getBreakIterator(const(UStringSearch)* strsrch);

@DllImport("icuin.dll")
void usearch_setText(UStringSearch* strsrch, const(ushort)* text, int textlength, UErrorCode* status);

@DllImport("icuin.dll")
ushort* usearch_getText(const(UStringSearch)* strsrch, int* length);

@DllImport("icuin.dll")
UCollator* usearch_getCollator(const(UStringSearch)* strsrch);

@DllImport("icuin.dll")
void usearch_setCollator(UStringSearch* strsrch, const(UCollator)* collator, UErrorCode* status);

@DllImport("icuin.dll")
void usearch_setPattern(UStringSearch* strsrch, const(ushort)* pattern, int patternlength, UErrorCode* status);

@DllImport("icuin.dll")
ushort* usearch_getPattern(const(UStringSearch)* strsrch, int* length);

@DllImport("icuin.dll")
int usearch_first(UStringSearch* strsrch, UErrorCode* status);

@DllImport("icuin.dll")
int usearch_following(UStringSearch* strsrch, int position, UErrorCode* status);

@DllImport("icuin.dll")
int usearch_last(UStringSearch* strsrch, UErrorCode* status);

@DllImport("icuin.dll")
int usearch_preceding(UStringSearch* strsrch, int position, UErrorCode* status);

@DllImport("icuin.dll")
int usearch_next(UStringSearch* strsrch, UErrorCode* status);

@DllImport("icuin.dll")
int usearch_previous(UStringSearch* strsrch, UErrorCode* status);

@DllImport("icuin.dll")
void usearch_reset(UStringSearch* strsrch);

@DllImport("icuin.dll")
USpoofChecker* uspoof_open(UErrorCode* status);

@DllImport("icuin.dll")
USpoofChecker* uspoof_openFromSerialized(const(void)* data, int length, int* pActualLength, UErrorCode* pErrorCode);

@DllImport("icuin.dll")
USpoofChecker* uspoof_openFromSource(const(PSTR) confusables, int confusablesLen, 
                                     const(PSTR) confusablesWholeScript, int confusablesWholeScriptLen, int* errType, 
                                     UParseError* pe, UErrorCode* status);

@DllImport("icuin.dll")
void uspoof_close(USpoofChecker* sc);

@DllImport("icuin.dll")
USpoofChecker* uspoof_clone(const(USpoofChecker)* sc, UErrorCode* status);

@DllImport("icuin.dll")
void uspoof_setChecks(USpoofChecker* sc, int checks, UErrorCode* status);

@DllImport("icuin.dll")
int uspoof_getChecks(const(USpoofChecker)* sc, UErrorCode* status);

@DllImport("icuin.dll")
void uspoof_setRestrictionLevel(USpoofChecker* sc, URestrictionLevel restrictionLevel);

@DllImport("icuin.dll")
URestrictionLevel uspoof_getRestrictionLevel(const(USpoofChecker)* sc);

@DllImport("icuin.dll")
void uspoof_setAllowedLocales(USpoofChecker* sc, const(PSTR) localesList, UErrorCode* status);

@DllImport("icuin.dll")
PSTR uspoof_getAllowedLocales(USpoofChecker* sc, UErrorCode* status);

@DllImport("icuin.dll")
void uspoof_setAllowedChars(USpoofChecker* sc, const(USet)* chars, UErrorCode* status);

@DllImport("icuin.dll")
USet* uspoof_getAllowedChars(const(USpoofChecker)* sc, UErrorCode* status);

@DllImport("icuin.dll")
int uspoof_check(const(USpoofChecker)* sc, const(ushort)* id, int length, int* position, UErrorCode* status);

@DllImport("icuin.dll")
int uspoof_checkUTF8(const(USpoofChecker)* sc, const(PSTR) id, int length, int* position, UErrorCode* status);

@DllImport("icuin.dll")
int uspoof_check2(const(USpoofChecker)* sc, const(ushort)* id, int length, USpoofCheckResult* checkResult, 
                  UErrorCode* status);

@DllImport("icuin.dll")
int uspoof_check2UTF8(const(USpoofChecker)* sc, const(PSTR) id, int length, USpoofCheckResult* checkResult, 
                      UErrorCode* status);

@DllImport("icuin.dll")
USpoofCheckResult* uspoof_openCheckResult(UErrorCode* status);

@DllImport("icuin.dll")
void uspoof_closeCheckResult(USpoofCheckResult* checkResult);

@DllImport("icuin.dll")
int uspoof_getCheckResultChecks(const(USpoofCheckResult)* checkResult, UErrorCode* status);

@DllImport("icuin.dll")
URestrictionLevel uspoof_getCheckResultRestrictionLevel(const(USpoofCheckResult)* checkResult, UErrorCode* status);

@DllImport("icuin.dll")
USet* uspoof_getCheckResultNumerics(const(USpoofCheckResult)* checkResult, UErrorCode* status);

@DllImport("icuin.dll")
int uspoof_areConfusable(const(USpoofChecker)* sc, const(ushort)* id1, int length1, const(ushort)* id2, 
                         int length2, UErrorCode* status);

@DllImport("icuin.dll")
int uspoof_areConfusableUTF8(const(USpoofChecker)* sc, const(PSTR) id1, int length1, const(PSTR) id2, int length2, 
                             UErrorCode* status);

@DllImport("icuin.dll")
int uspoof_getSkeleton(const(USpoofChecker)* sc, uint type, const(ushort)* id, int length, ushort* dest, 
                       int destCapacity, UErrorCode* status);

@DllImport("icuin.dll")
int uspoof_getSkeletonUTF8(const(USpoofChecker)* sc, uint type, const(PSTR) id, int length, PSTR dest, 
                           int destCapacity, UErrorCode* status);

@DllImport("icuin.dll")
USet* uspoof_getInclusionSet(UErrorCode* status);

@DllImport("icuin.dll")
USet* uspoof_getRecommendedSet(UErrorCode* status);

@DllImport("icuin.dll")
int uspoof_serialize(USpoofChecker* sc, void* data, int capacity, UErrorCode* status);

@DllImport("icuin.dll")
long utmscale_getTimeScaleValue(UDateTimeScale timeScale, UTimeScaleValue value, UErrorCode* status);

@DllImport("icuin.dll")
long utmscale_fromInt64(long otherTime, UDateTimeScale timeScale, UErrorCode* status);

@DllImport("icuin.dll")
long utmscale_toInt64(long universalTime, UDateTimeScale timeScale, UErrorCode* status);

@DllImport("icuin.dll")
void** utrans_openU(const(ushort)* id, int idLength, UTransDirection dir, const(ushort)* rules, int rulesLength, 
                    UParseError* parseError, UErrorCode* pErrorCode);

@DllImport("icuin.dll")
void** utrans_openInverse(const(void)** trans, UErrorCode* status);

@DllImport("icuin.dll")
void** utrans_clone(const(void)** trans, UErrorCode* status);

@DllImport("icuin.dll")
void utrans_close(void** trans);

@DllImport("icuin.dll")
ushort* utrans_getUnicodeID(const(void)** trans, int* resultLength);

@DllImport("icuin.dll")
void utrans_register(void** adoptedTrans, UErrorCode* status);

@DllImport("icuin.dll")
void utrans_unregisterID(const(ushort)* id, int idLength);

@DllImport("icuin.dll")
void utrans_setFilter(void** trans, const(ushort)* filterPattern, int filterPatternLen, UErrorCode* status);

@DllImport("icuin.dll")
int utrans_countAvailableIDs();

@DllImport("icuin.dll")
UEnumeration* utrans_openIDs(UErrorCode* pErrorCode);

@DllImport("icuin.dll")
void utrans_trans(const(void)** trans, void** rep, const(UReplaceableCallbacks)* repFunc, int start, int* limit, 
                  UErrorCode* status);

@DllImport("icuin.dll")
void utrans_transIncremental(const(void)** trans, void** rep, const(UReplaceableCallbacks)* repFunc, 
                             UTransPosition* pos, UErrorCode* status);

@DllImport("icuin.dll")
void utrans_transUChars(const(void)** trans, ushort* text, int* textLength, int textCapacity, int start, 
                        int* limit, UErrorCode* status);

@DllImport("icuin.dll")
void utrans_transIncrementalUChars(const(void)** trans, ushort* text, int* textLength, int textCapacity, 
                                   UTransPosition* pos, UErrorCode* status);

@DllImport("icuin.dll")
int utrans_toRules(const(void)** trans, byte escapeUnprintable, ushort* result, int resultLength, 
                   UErrorCode* status);

@DllImport("icuin.dll")
USet* utrans_getSourceSet(const(void)** trans, byte ignoreFilter, USet* fillIn, UErrorCode* status);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bcp47mrm/nf-bcp47mrm-getdistanceofclosestlanguageinlist
@DllImport("bcp47mrm.dll")
HRESULT GetDistanceOfClosestLanguageInList(const(PWSTR) pszLanguage, const(PWSTR) pszLanguagesList, 
                                           wchar wchListDelimiter, double* pClosestDistance);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bcp47mrm/nf-bcp47mrm-iswellformedtag
@DllImport("bcp47mrm.dll")
ubyte IsWellFormedTag(const(PWSTR) pszTag);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Intl/getcalendarsupporteddaterange
@DllImport("KERNEL32.dll")
BOOL GetCalendarSupportedDateRange(uint Calendar, CALDATETIME* lpCalMinDateTime, CALDATETIME* lpCalMaxDateTime);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Intl/getcalendardateformatex
@DllImport("KERNEL32.dll")
BOOL GetCalendarDateFormatEx(const(PWSTR) lpszLocale, uint dwFlags, const(CALDATETIME)* lpCalDateTime, 
                             const(PWSTR) lpFormat, PWSTR lpDateStr, int cchDate);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Intl/convertsystemtimetocaldatetime
@DllImport("KERNEL32.dll")
BOOL ConvertSystemTimeToCalDateTime(const(SYSTEMTIME)* lpSysTime, uint calId, CALDATETIME* lpCalDateTime);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Intl/updatecalendardayofweek
@DllImport("KERNEL32.dll")
BOOL UpdateCalendarDayOfWeek(CALDATETIME* lpCalDateTime);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Intl/adjustcalendardate
@DllImport("KERNEL32.dll")
BOOL AdjustCalendarDate(CALDATETIME* lpCalDateTime, CALDATETIME_DATEUNIT calUnit, int amount);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Intl/convertcaldatetimetosystemtime
@DllImport("KERNEL32.dll")
BOOL ConvertCalDateTimeToSystemTime(const(CALDATETIME)* lpCalDateTime, SYSTEMTIME* lpSysTime);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Intl/iscalendarleapyear
@DllImport("KERNEL32.dll")
BOOL IsCalendarLeapYear(uint calId, uint year, uint era);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
int FindStringOrdinal(uint dwFindStringOrdinalFlags, const(PWSTR) lpStringSource, int cchSource, 
                      const(PWSTR) lpStringValue, int cchValue, BOOL bIgnoreCase);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int lstrcmpA(const(PSTR) lpString1, const(PSTR) lpString2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int lstrcmpW(const(PWSTR) lpString1, const(PWSTR) lpString2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int lstrcmpiA(const(PSTR) lpString1, const(PSTR) lpString2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int lstrcmpiW(const(PWSTR) lpString1, const(PWSTR) lpString2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
PSTR lstrcpynA(PSTR lpString1, const(PSTR) lpString2, int iMaxLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
PWSTR lstrcpynW(PWSTR lpString1, const(PWSTR) lpString2, int iMaxLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
PSTR lstrcpyA(PSTR lpString1, const(PSTR) lpString2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
PWSTR lstrcpyW(PWSTR lpString1, const(PWSTR) lpString2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
PSTR lstrcatA(PSTR lpString1, const(PSTR) lpString2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
PWSTR lstrcatW(PWSTR lpString1, const(PWSTR) lpString2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int lstrlenA(const(PSTR) lpString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
int lstrlenW(const(PWSTR) lpString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("ADVAPI32.dll")
BOOL IsTextUnicode(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* lpv, 
                   int iSize, IS_TEXT_UNICODE_RESULT* lpiResult);


// Interfaces

@GUID("7ab36653-1796-484b-bdfa-e74f1db7c1dc")
struct SpellCheckerFactory;

@GUID("c04d65cf-b70d-11d0-b188-00aa0038c969")
struct CMLangString;

@GUID("d66d6f99-cdaa-11d0-b822-00c04fc9b31f")
struct CMLangConvertCharset;

@GUID("275c23e2-3747-11d0-9fea-00aa003f8646")
struct CMultiLanguage;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nn-spellcheck-ispellingerror
@GUID("b7c82d61-fbe8-4b47-9b27-6c0d2e0de0a3")
interface ISpellingError : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellingerror-get_startindex
    HRESULT get_StartIndex(uint* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellingerror-get_length
    HRESULT get_Length(uint* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellingerror-get_correctiveaction
    HRESULT get_CorrectiveAction(CORRECTIVE_ACTION* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellingerror-get_replacement
    HRESULT get_Replacement(/*PARAM ATTR: FreeWithAttribute : CustomAttributeSig([FixedArgSig(ElementSig(CoTaskMemFree))], [])*/PWSTR* value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nn-spellcheck-ienumspellingerror
@GUID("803e3bd4-2828-4410-8290-418d1d73c762")
interface IEnumSpellingError : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Next(ISpellingError* value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nn-spellcheck-ioptiondescription
@GUID("432e5f85-35cf-4606-a801-6f70277e1d7a")
interface IOptionDescription : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ioptiondescription-get_id
    HRESULT get_Id(PWSTR* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ioptiondescription-get_heading
    HRESULT get_Heading(PWSTR* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ioptiondescription-get_description
    HRESULT get_Description(PWSTR* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ioptiondescription-get_labels
    HRESULT get_Labels(IEnumString* value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nn-spellcheck-ispellcheckerchangedeventhandler
@GUID("0b83a5b0-792f-4eab-9799-acf52c5ed08a")
interface ISpellCheckerChangedEventHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellcheckerchangedeventhandler-invoke
    HRESULT Invoke(ISpellChecker sender);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nn-spellcheck-ispellchecker
@GUID("b6fd0b71-e2bc-4653-8d05-f197e412770b")
interface ISpellChecker : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellchecker-get_languagetag
    HRESULT get_LanguageTag(PWSTR* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellchecker-check
    HRESULT Check(const(PWSTR) text, IEnumSpellingError* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellchecker-suggest
    HRESULT Suggest(const(PWSTR) word, IEnumString* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellchecker-add
    HRESULT Add(const(PWSTR) word);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellchecker-ignore
    HRESULT Ignore(const(PWSTR) word);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellchecker-autocorrect
    HRESULT AutoCorrect(const(PWSTR) from, const(PWSTR) to);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellchecker-getoptionvalue
    HRESULT GetOptionValue(const(PWSTR) optionId, ubyte* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellchecker-get_optionids
    HRESULT get_OptionIds(IEnumString* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellchecker-get_id
    HRESULT get_Id(PWSTR* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellchecker-get_localizedname
    HRESULT get_LocalizedName(PWSTR* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellchecker-add_spellcheckerchanged
    HRESULT add_SpellCheckerChanged(ISpellCheckerChangedEventHandler handler, uint* eventCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellchecker-remove_spellcheckerchanged
    HRESULT remove_SpellCheckerChanged(uint eventCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellchecker-getoptiondescription
    HRESULT GetOptionDescription(const(PWSTR) optionId, IOptionDescription* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellchecker-comprehensivecheck
    HRESULT ComprehensiveCheck(const(PWSTR) text, IEnumSpellingError* value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nn-spellcheck-ispellchecker2
@GUID("e7ed1c71-87f7-4378-a840-c9200dacee47")
interface ISpellChecker2 : ISpellChecker
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellchecker2-remove
    HRESULT Remove(const(PWSTR) word);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nn-spellcheck-ispellcheckerfactory
@GUID("8e018a9d-2415-4677-bf08-794ea61f94bb")
interface ISpellCheckerFactory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellcheckerfactory-get_supportedlanguages
    HRESULT get_SupportedLanguages(IEnumString* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellcheckerfactory-issupported
    HRESULT IsSupported(const(PWSTR) languageTag, BOOL* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-ispellcheckerfactory-createspellchecker
    HRESULT CreateSpellChecker(const(PWSTR) languageTag, ISpellChecker* value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nn-spellcheck-iuserdictionariesregistrar
@GUID("aa176b85-0e12-4844-8e1a-eef1da77f586")
interface IUserDictionariesRegistrar : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-iuserdictionariesregistrar-registeruserdictionary
    HRESULT RegisterUserDictionary(const(PWSTR) dictionaryPath, const(PWSTR) languageTag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheck/nf-spellcheck-iuserdictionariesregistrar-unregisteruserdictionary
    HRESULT UnregisterUserDictionary(const(PWSTR) dictionaryPath, const(PWSTR) languageTag);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheckprovider/nn-spellcheckprovider-ispellcheckprovider
@GUID("73e976e0-8ed4-4eb1-80d7-1be0a16b0c38")
interface ISpellCheckProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheckprovider/nf-spellcheckprovider-ispellcheckprovider-get_languagetag
    HRESULT get_LanguageTag(PWSTR* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheckprovider/nf-spellcheckprovider-ispellcheckprovider-check
    HRESULT Check(const(PWSTR) text, IEnumSpellingError* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheckprovider/nf-spellcheckprovider-ispellcheckprovider-suggest
    HRESULT Suggest(const(PWSTR) word, IEnumString* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheckprovider/nf-spellcheckprovider-ispellcheckprovider-getoptionvalue
    HRESULT GetOptionValue(const(PWSTR) optionId, ubyte* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheckprovider/nf-spellcheckprovider-ispellcheckprovider-setoptionvalue
    HRESULT SetOptionValue(const(PWSTR) optionId, ubyte value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheckprovider/nf-spellcheckprovider-ispellcheckprovider-get_optionids
    HRESULT get_OptionIds(IEnumString* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheckprovider/nf-spellcheckprovider-ispellcheckprovider-get_id
    HRESULT get_Id(PWSTR* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheckprovider/nf-spellcheckprovider-ispellcheckprovider-get_localizedname
    HRESULT get_LocalizedName(PWSTR* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheckprovider/nf-spellcheckprovider-ispellcheckprovider-getoptiondescription
    HRESULT GetOptionDescription(const(PWSTR) optionId, IOptionDescription* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheckprovider/nf-spellcheckprovider-ispellcheckprovider-initializewordlist
    HRESULT InitializeWordlist(WORDLIST_TYPE wordlistType, IEnumString words);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheckprovider/nn-spellcheckprovider-icomprehensivespellcheckprovider
@GUID("0c58f8de-8e94-479e-9717-70c42c4ad2c3")
interface IComprehensiveSpellCheckProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Intl/icomprehensivespellcheckprovider-comprehensivecheck
    HRESULT ComprehensiveCheck(const(PWSTR) text, IEnumSpellingError* value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheckprovider/nn-spellcheckprovider-ispellcheckproviderfactory
@GUID("9f671e11-77d6-4c92-aefb-615215e3a4be")
interface ISpellCheckProviderFactory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheckprovider/nf-spellcheckprovider-ispellcheckproviderfactory-get_supportedlanguages
    HRESULT get_SupportedLanguages(IEnumString* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheckprovider/nf-spellcheckprovider-ispellcheckproviderfactory-issupported
    HRESULT IsSupported(const(PWSTR) languageTag, BOOL* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/spellcheckprovider/nf-spellcheckprovider-ispellcheckproviderfactory-createspellcheckprovider
    HRESULT CreateSpellCheckProvider(const(PWSTR) languageTag, ISpellCheckProvider* value);
}

@GUID("d24acd21-ba72-11d0-b188-00aa0038c969")
interface IMLangStringBufW : IUnknown
{
    HRESULT GetStatus(int* plFlags, int* pcchBuf);
    HRESULT LockBuf(int cchOffset, int cchMaxLock, ushort** ppszBuf, int* pcchBuf);
    HRESULT UnlockBuf(const(PWSTR) pszBuf, int cchOffset, int cchWrite);
    HRESULT Insert(int cchOffset, int cchMaxInsert, int* pcchActual);
    HRESULT Delete(int cchOffset, int cchDelete);
}

@GUID("d24acd23-ba72-11d0-b188-00aa0038c969")
interface IMLangStringBufA : IUnknown
{
    HRESULT GetStatus(int* plFlags, int* pcchBuf);
    HRESULT LockBuf(int cchOffset, int cchMaxLock, CHAR** ppszBuf, int* pcchBuf);
    HRESULT UnlockBuf(const(PSTR) pszBuf, int cchOffset, int cchWrite);
    HRESULT Insert(int cchOffset, int cchMaxInsert, int* pcchActual);
    HRESULT Delete(int cchOffset, int cchDelete);
}

@GUID("c04d65ce-b70d-11d0-b188-00aa0038c969")
interface IMLangString : IUnknown
{
    HRESULT Sync(BOOL fNoAccess);
    HRESULT GetLength(int* plLen);
    HRESULT SetMLStr(int lDestPos, int lDestLen, IUnknown pSrcMLStr, int lSrcPos, int lSrcLen);
    HRESULT GetMLStr(int lSrcPos, int lSrcLen, IUnknown pUnkOuter, uint dwClsContext, const(GUID)* piid, 
                     IUnknown* ppDestMLStr, int* plDestPos, int* plDestLen);
}

@GUID("c04d65d0-b70d-11d0-b188-00aa0038c969")
interface IMLangStringWStr : IMLangString
{
    HRESULT SetWStr(int lDestPos, int lDestLen, const(PWSTR) pszSrc, int cchSrc, int* pcchActual, int* plActualLen);
    HRESULT SetStrBufW(int lDestPos, int lDestLen, IMLangStringBufW pSrcBuf, int* pcchActual, int* plActualLen);
    HRESULT GetWStr(int lSrcPos, int lSrcLen, PWSTR pszDest, int cchDest, int* pcchActual, int* plActualLen);
    HRESULT GetStrBufW(int lSrcPos, int lSrcMaxLen, IMLangStringBufW* ppDestBuf, int* plDestLen);
    HRESULT LockWStr(int lSrcPos, int lSrcLen, int lFlags, int cchRequest, PWSTR* ppszDest, int* pcchDest, 
                     int* plDestLen);
    HRESULT UnlockWStr(const(PWSTR) pszSrc, int cchSrc, int* pcchActual, int* plActualLen);
    HRESULT SetLocale(int lDestPos, int lDestLen, uint locale);
    HRESULT GetLocale(int lSrcPos, int lSrcMaxLen, uint* plocale, int* plLocalePos, int* plLocaleLen);
}

@GUID("c04d65d2-b70d-11d0-b188-00aa0038c969")
interface IMLangStringAStr : IMLangString
{
    HRESULT SetAStr(int lDestPos, int lDestLen, uint uCodePage, const(PSTR) pszSrc, int cchSrc, int* pcchActual, 
                    int* plActualLen);
    HRESULT SetStrBufA(int lDestPos, int lDestLen, uint uCodePage, IMLangStringBufA pSrcBuf, int* pcchActual, 
                       int* plActualLen);
    HRESULT GetAStr(int lSrcPos, int lSrcLen, uint uCodePageIn, 
                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint* puCodePageOut, PSTR pszDest, 
                    int cchDest, int* pcchActual, int* plActualLen);
    HRESULT GetStrBufA(int lSrcPos, int lSrcMaxLen, uint* puDestCodePage, IMLangStringBufA* ppDestBuf, 
                       int* plDestLen);
    HRESULT LockAStr(int lSrcPos, int lSrcLen, int lFlags, uint uCodePageIn, int cchRequest, uint* puCodePageOut, 
                     PSTR* ppszDest, int* pcchDest, int* plDestLen);
    HRESULT UnlockAStr(const(PSTR) pszSrc, int cchSrc, int* pcchActual, int* plActualLen);
    HRESULT SetLocale(int lDestPos, int lDestLen, uint locale);
    HRESULT GetLocale(int lSrcPos, int lSrcMaxLen, uint* plocale, int* plLocalePos, int* plLocaleLen);
}

@GUID("f5be2ee1-bfd7-11d0-b188-00aa0038c969")
interface IMLangLineBreakConsole : IUnknown
{
    HRESULT BreakLineML(IMLangString pSrcMLStr, int lSrcPos, int lSrcLen, int cMinColumns, int cMaxColumns, 
                        int* plLineLen, int* plSkipLen);
    HRESULT BreakLineW(uint locale, const(PWSTR) pszSrc, int cchSrc, int cMaxColumns, int* pcchLine, int* pcchSkip);
    HRESULT BreakLineA(uint locale, uint uCodePage, const(PSTR) pszSrc, int cchSrc, int cMaxColumns, int* pcchLine, 
                       int* pcchSkip);
}

@GUID("275c23e3-3747-11d0-9fea-00aa003f8646")
interface IEnumCodePage : IUnknown
{
    HRESULT Clone(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/IEnumCodePage* ppEnum);
    HRESULT Next(uint celt, MIMECPINFO* rgelt, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
}

@GUID("3dc39d1d-c030-11d0-b81b-00c04fc9b31f")
interface IEnumRfc1766 : IUnknown
{
    HRESULT Clone(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/IEnumRfc1766* ppEnum);
    HRESULT Next(uint celt, RFC1766INFO* rgelt, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
}

@GUID("ae5f1430-388b-11d2-8380-00c04f8f5da1")
interface IEnumScript : IUnknown
{
    HRESULT Clone(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/IEnumScript* ppEnum);
    HRESULT Next(uint celt, SCRIPTINFO* rgelt, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
}

@GUID("d66d6f98-cdaa-11d0-b822-00c04fc9b31f")
interface IMLangConvertCharset : IUnknown
{
    HRESULT Initialize(uint uiSrcCodePage, uint uiDstCodePage, uint dwProperty);
    HRESULT GetSourceCodePage(uint* puiSrcCodePage);
    HRESULT GetDestinationCodePage(uint* puiDstCodePage);
    HRESULT GetProperty(uint* pdwProperty);
    HRESULT DoConversion(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pSrcStr, 
                         uint* pcSrcSize, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pDstStr, 
                         uint* pcDstSize);
    HRESULT DoConversionToUnicode(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PSTR pSrcStr, 
                                  uint* pcSrcSize, PWSTR pDstStr, uint* pcDstSize);
    HRESULT DoConversionFromUnicode(PWSTR pSrcStr, uint* pcSrcSize, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSTR pDstStr, 
                                    uint* pcDstSize);
}

@GUID("275c23e1-3747-11d0-9fea-00aa003f8646")
interface IMultiLanguage : IUnknown
{
    HRESULT GetNumberOfCodePageInfo(uint* pcCodePage);
    HRESULT GetCodePageInfo(uint uiCodePage, MIMECPINFO* pCodePageInfo);
    HRESULT GetFamilyCodePage(uint uiCodePage, uint* puiFamilyCodePage);
    HRESULT EnumCodePages(uint grfFlags, IEnumCodePage* ppEnumCodePage);
    HRESULT GetCharsetInfo(BSTR Charset, MIMECSETINFO* pCharsetInfo);
    HRESULT IsConvertible(uint dwSrcEncoding, uint dwDstEncoding);
    HRESULT ConvertString(uint* pdwMode, uint dwSrcEncoding, uint dwDstEncoding, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pSrcStr, 
                          uint* pcSrcSize, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* pDstStr, 
                          uint* pcDstSize);
    HRESULT ConvertStringToUnicode(uint* pdwMode, uint dwEncoding, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSTR pSrcStr, 
                                   uint* pcSrcSize, PWSTR pDstStr, uint* pcDstSize);
    HRESULT ConvertStringFromUnicode(uint* pdwMode, uint dwEncoding, PWSTR pSrcStr, uint* pcSrcSize, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/PSTR pDstStr, 
                                     uint* pcDstSize);
    HRESULT ConvertStringReset();
    HRESULT GetRfc1766FromLcid(uint Locale, BSTR* pbstrRfc1766);
    HRESULT GetLcidFromRfc1766(uint* pLocale, BSTR bstrRfc1766);
    HRESULT EnumRfc1766(IEnumRfc1766* ppEnumRfc1766);
    HRESULT GetRfc1766Info(uint Locale, RFC1766INFO* pRfc1766Info);
    HRESULT CreateConvertCharset(uint uiSrcCodePage, uint uiDstCodePage, uint dwProperty, 
                                 IMLangConvertCharset* ppMLangConvertCharset);
}

@GUID("dccfc164-2b38-11d2-b7ec-00c04f8f5d9a")
interface IMultiLanguage2 : IUnknown
{
    HRESULT GetNumberOfCodePageInfo(uint* pcCodePage);
    HRESULT GetCodePageInfo(uint uiCodePage, ushort LangId, MIMECPINFO* pCodePageInfo);
    HRESULT GetFamilyCodePage(uint uiCodePage, uint* puiFamilyCodePage);
    HRESULT EnumCodePages(uint grfFlags, ushort LangId, IEnumCodePage* ppEnumCodePage);
    HRESULT GetCharsetInfo(BSTR Charset, MIMECSETINFO* pCharsetInfo);
    HRESULT IsConvertible(uint dwSrcEncoding, uint dwDstEncoding);
    HRESULT ConvertString(uint* pdwMode, uint dwSrcEncoding, uint dwDstEncoding, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pSrcStr, 
                          uint* pcSrcSize, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* pDstStr, 
                          uint* pcDstSize);
    HRESULT ConvertStringToUnicode(uint* pdwMode, uint dwEncoding, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSTR pSrcStr, 
                                   uint* pcSrcSize, PWSTR pDstStr, uint* pcDstSize);
    HRESULT ConvertStringFromUnicode(uint* pdwMode, uint dwEncoding, PWSTR pSrcStr, uint* pcSrcSize, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/PSTR pDstStr, 
                                     uint* pcDstSize);
    HRESULT ConvertStringReset();
    HRESULT GetRfc1766FromLcid(uint Locale, BSTR* pbstrRfc1766);
    HRESULT GetLcidFromRfc1766(uint* pLocale, BSTR bstrRfc1766);
    HRESULT EnumRfc1766(ushort LangId, IEnumRfc1766* ppEnumRfc1766);
    HRESULT GetRfc1766Info(uint Locale, ushort LangId, RFC1766INFO* pRfc1766Info);
    HRESULT CreateConvertCharset(uint uiSrcCodePage, uint uiDstCodePage, uint dwProperty, 
                                 IMLangConvertCharset* ppMLangConvertCharset);
    HRESULT ConvertStringInIStream(uint* pdwMode, uint dwFlag, PWSTR lpFallBack, uint dwSrcEncoding, 
                                   uint dwDstEncoding, IStream pstmIn, IStream pstmOut);
    HRESULT ConvertStringToUnicodeEx(uint* pdwMode, uint dwEncoding, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSTR pSrcStr, 
                                     uint* pcSrcSize, PWSTR pDstStr, uint* pcDstSize, uint dwFlag, PWSTR lpFallBack);
    HRESULT ConvertStringFromUnicodeEx(uint* pdwMode, uint dwEncoding, PWSTR pSrcStr, uint* pcSrcSize, 
                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/PSTR pDstStr, 
                                       uint* pcDstSize, uint dwFlag, PWSTR lpFallBack);
    HRESULT DetectCodepageInIStream(uint dwFlag, uint dwPrefWinCodePage, IStream pstmIn, 
                                    DetectEncodingInfo* lpEncoding, int* pnScores);
    HRESULT DetectInputCodepage(uint dwFlag, uint dwPrefWinCodePage, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSTR pSrcStr, 
                                int* pcSrcSize, DetectEncodingInfo* lpEncoding, int* pnScores);
    HRESULT ValidateCodePage(uint uiCodePage, HWND hwnd);
    HRESULT GetCodePageDescription(uint uiCodePage, uint lcid, PWSTR lpWideCharStr, int cchWideChar);
    HRESULT IsCodePageInstallable(uint uiCodePage);
    HRESULT SetMimeDBSource(MIMECONTF dwSource);
    HRESULT GetNumberOfScripts(uint* pnScripts);
    HRESULT EnumScripts(uint dwFlags, ushort LangId, IEnumScript* ppEnumScript);
    HRESULT ValidateCodePageEx(uint uiCodePage, HWND hwnd, uint dwfIODControl);
}

@GUID("359f3443-bd4a-11d0-b188-00aa0038c969")
interface IMLangCodePages : IUnknown
{
    HRESULT GetCharCodePages(wchar chSrc, uint* pdwCodePages);
    HRESULT GetStrCodePages(const(PWSTR) pszSrc, int cchSrc, uint dwPriorityCodePages, uint* pdwCodePages, 
                            int* pcchCodePages);
    HRESULT CodePageToCodePages(uint uCodePage, uint* pdwCodePages);
    HRESULT CodePagesToCodePage(uint dwCodePages, uint uDefaultCodePage, uint* puCodePage);
}

@GUID("359f3441-bd4a-11d0-b188-00aa0038c969")
interface IMLangFontLink : IMLangCodePages
{
    HRESULT GetFontCodePages(HDC hDC, HFONT hFont, uint* pdwCodePages);
    HRESULT MapFont(HDC hDC, uint dwCodePages, HFONT hSrcFont, HFONT* phDestFont);
    HRESULT ReleaseFont(HFONT hFont);
    HRESULT ResetFontMapping();
}

@GUID("dccfc162-2b38-11d2-b7ec-00c04f8f5d9a")
interface IMLangFontLink2 : IMLangCodePages
{
    HRESULT GetFontCodePages(HDC hDC, HFONT hFont, uint* pdwCodePages);
    HRESULT ReleaseFont(HFONT hFont);
    HRESULT ResetFontMapping();
    HRESULT MapFont(HDC hDC, uint dwCodePages, wchar chSrc, HFONT* pFont);
    HRESULT GetFontUnicodeRanges(HDC hDC, uint* puiRanges, UNICODERANGE* pUranges);
    HRESULT GetScriptFontInfo(ubyte sid, uint dwFlags, uint* puiFonts, SCRIPTFONTINFO* pScriptFont);
    HRESULT CodePageToScriptID(uint uiCodePage, ubyte* pSid);
}

@GUID("4e5868ab-b157-4623-9acc-6a1d9caebe04")
interface IMultiLanguage3 : IMultiLanguage2
{
    HRESULT DetectOutboundCodePage(uint dwFlags, const(PWSTR) lpWideCharStr, uint cchWideChar, 
                                   const(uint)* puiPreferredCodePages, uint nPreferredCodePages, 
                                   uint* puiDetectedCodePages, uint* pnDetectedCodePages, const(PWSTR) lpSpecialChar);
    HRESULT DetectOutboundCodePageInIStream(uint dwFlags, IStream pStrIn, const(uint)* puiPreferredCodePages, 
                                            uint nPreferredCodePages, uint* puiDetectedCodePages, 
                                            uint* pnDetectedCodePages, const(PWSTR) lpSpecialChar);
}


// GUIDs

const GUID CLSID_CMLangConvertCharset = GUIDOF!CMLangConvertCharset;
const GUID CLSID_CMLangString         = GUIDOF!CMLangString;
const GUID CLSID_CMultiLanguage       = GUIDOF!CMultiLanguage;
const GUID CLSID_SpellCheckerFactory  = GUIDOF!SpellCheckerFactory;

const GUID IID_IComprehensiveSpellCheckProvider = GUIDOF!IComprehensiveSpellCheckProvider;
const GUID IID_IEnumCodePage                    = GUIDOF!IEnumCodePage;
const GUID IID_IEnumRfc1766                     = GUIDOF!IEnumRfc1766;
const GUID IID_IEnumScript                      = GUIDOF!IEnumScript;
const GUID IID_IEnumSpellingError               = GUIDOF!IEnumSpellingError;
const GUID IID_IMLangCodePages                  = GUIDOF!IMLangCodePages;
const GUID IID_IMLangConvertCharset             = GUIDOF!IMLangConvertCharset;
const GUID IID_IMLangFontLink                   = GUIDOF!IMLangFontLink;
const GUID IID_IMLangFontLink2                  = GUIDOF!IMLangFontLink2;
const GUID IID_IMLangLineBreakConsole           = GUIDOF!IMLangLineBreakConsole;
const GUID IID_IMLangString                     = GUIDOF!IMLangString;
const GUID IID_IMLangStringAStr                 = GUIDOF!IMLangStringAStr;
const GUID IID_IMLangStringBufA                 = GUIDOF!IMLangStringBufA;
const GUID IID_IMLangStringBufW                 = GUIDOF!IMLangStringBufW;
const GUID IID_IMLangStringWStr                 = GUIDOF!IMLangStringWStr;
const GUID IID_IMultiLanguage                   = GUIDOF!IMultiLanguage;
const GUID IID_IMultiLanguage2                  = GUIDOF!IMultiLanguage2;
const GUID IID_IMultiLanguage3                  = GUIDOF!IMultiLanguage3;
const GUID IID_IOptionDescription               = GUIDOF!IOptionDescription;
const GUID IID_ISpellCheckProvider              = GUIDOF!ISpellCheckProvider;
const GUID IID_ISpellCheckProviderFactory       = GUIDOF!ISpellCheckProviderFactory;
const GUID IID_ISpellChecker                    = GUIDOF!ISpellChecker;
const GUID IID_ISpellChecker2                   = GUIDOF!ISpellChecker2;
const GUID IID_ISpellCheckerChangedEventHandler = GUIDOF!ISpellCheckerChangedEventHandler;
const GUID IID_ISpellCheckerFactory             = GUIDOF!ISpellCheckerFactory;
const GUID IID_ISpellingError                   = GUIDOF!ISpellingError;
const GUID IID_IUserDictionariesRegistrar       = GUIDOF!IUserDictionariesRegistrar;
