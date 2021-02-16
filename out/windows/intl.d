module windows.intl;

public import windows.core;
public import windows.automation : BSTR, SAFEARRAY;
public import windows.com : HRESULT, IClassFactory, IEnumString, IUnknown;
public import windows.displaydevices : POINT, RECT, SIZE;
public import windows.gdi : ABC, HBITMAP, HDC, HICON;
public import windows.shell : LOGFONTA, LOGFONTW;
public import windows.systemservices : BOOL, LRESULT;
public import windows.windowsandmessaging : HWND, LPARAM, WPARAM;
public import windows.windowsprogramming : SYSTEMTIME;

extern(Windows):


// Enums


enum : int
{
    COMPARE_STRING = 0x00000001,
}
alias SYSNLS_FUNCTION = int;

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
alias SYSGEOTYPE = int;

enum : int
{
    GEOCLASS_NATION = 0x00000010,
    GEOCLASS_REGION = 0x0000000e,
    GEOCLASS_ALL    = 0x00000000,
}
alias SYSGEOCLASS = int;

enum : int
{
    NormalizationOther = 0x00000000,
    NormalizationC     = 0x00000001,
    NormalizationD     = 0x00000002,
    NormalizationKC    = 0x00000005,
    NormalizationKD    = 0x00000006,
}
alias NORM_FORM = int;

enum : int
{
    WORDLIST_TYPE_IGNORE      = 0x00000000,
    WORDLIST_TYPE_ADD         = 0x00000001,
    WORDLIST_TYPE_EXCLUDE     = 0x00000002,
    WORDLIST_TYPE_AUTOCORRECT = 0x00000003,
}
alias WORDLIST_TYPE = int;

enum : int
{
    CORRECTIVE_ACTION_NONE            = 0x00000000,
    CORRECTIVE_ACTION_GET_SUGGESTIONS = 0x00000001,
    CORRECTIVE_ACTION_REPLACE         = 0x00000002,
    CORRECTIVE_ACTION_DELETE          = 0x00000003,
}
alias CORRECTIVE_ACTION = int;

enum : int
{
    IFED_REG_HEAD = 0x00000000,
    IFED_REG_TAIL = 0x00000001,
    IFED_REG_DEL  = 0x00000002,
}
alias IMEREG = int;

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
alias IMEFMT = int;

enum : int
{
    IFED_UCT_NONE           = 0x00000000,
    IFED_UCT_STRING_SJIS    = 0x00000001,
    IFED_UCT_STRING_UNICODE = 0x00000002,
    IFED_UCT_USER_DEFINED   = 0x00000003,
    IFED_UCT_MAX            = 0x00000004,
}
alias IMEUCT = int;

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
alias IMEREL = int;

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
alias SCRIPT_JUSTIFY = int;

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

alias LOCALE_ENUMPROCA = BOOL function(const(char)* param0);
alias LOCALE_ENUMPROCW = BOOL function(const(wchar)* param0);
alias LANGUAGEGROUP_ENUMPROCA = BOOL function(uint param0, const(char)* param1, const(char)* param2, uint param3, 
                                              ptrdiff_t param4);
alias LANGGROUPLOCALE_ENUMPROCA = BOOL function(uint param0, uint param1, const(char)* param2, ptrdiff_t param3);
alias UILANGUAGE_ENUMPROCA = BOOL function(const(char)* param0, ptrdiff_t param1);
alias CODEPAGE_ENUMPROCA = BOOL function(const(char)* param0);
alias DATEFMT_ENUMPROCA = BOOL function(const(char)* param0);
alias DATEFMT_ENUMPROCEXA = BOOL function(const(char)* param0, uint param1);
alias TIMEFMT_ENUMPROCA = BOOL function(const(char)* param0);
alias CALINFO_ENUMPROCA = BOOL function(const(char)* param0);
alias CALINFO_ENUMPROCEXA = BOOL function(const(char)* param0, uint param1);
alias LANGUAGEGROUP_ENUMPROCW = BOOL function(uint param0, const(wchar)* param1, const(wchar)* param2, uint param3, 
                                              ptrdiff_t param4);
alias LANGGROUPLOCALE_ENUMPROCW = BOOL function(uint param0, uint param1, const(wchar)* param2, ptrdiff_t param3);
alias UILANGUAGE_ENUMPROCW = BOOL function(const(wchar)* param0, ptrdiff_t param1);
alias CODEPAGE_ENUMPROCW = BOOL function(const(wchar)* param0);
alias DATEFMT_ENUMPROCW = BOOL function(const(wchar)* param0);
alias DATEFMT_ENUMPROCEXW = BOOL function(const(wchar)* param0, uint param1);
alias TIMEFMT_ENUMPROCW = BOOL function(const(wchar)* param0);
alias CALINFO_ENUMPROCW = BOOL function(const(wchar)* param0);
alias CALINFO_ENUMPROCEXW = BOOL function(const(wchar)* param0, uint param1);
alias GEO_ENUMPROC = BOOL function(int param0);
alias GEO_ENUMNAMEPROC = BOOL function(const(wchar)* param0, LPARAM param1);
alias CALINFO_ENUMPROCEXEX = BOOL function(const(wchar)* param0, uint param1, const(wchar)* param2, LPARAM param3);
alias DATEFMT_ENUMPROCEXEX = BOOL function(const(wchar)* param0, uint param1, LPARAM param2);
alias TIMEFMT_ENUMPROCEX = BOOL function(const(wchar)* param0, LPARAM param1);
alias LOCALE_ENUMPROCEX = BOOL function(const(wchar)* param0, uint param1, LPARAM param2);
alias IMCENUMPROC = BOOL function(HIMC__* param0, LPARAM param1);
alias REGISTERWORDENUMPROCA = int function(const(char)* lpszReading, uint param1, const(char)* lpszString, 
                                           void* param3);
alias REGISTERWORDENUMPROCW = int function(const(wchar)* lpszReading, uint param1, const(wchar)* lpszString, 
                                           void* param3);
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


struct FONTSIGNATURE
{
    uint[4] fsUsb;
    uint[2] fsCsb;
}

struct CHARSETINFO
{
    uint          ciCharset;
    uint          ciACP;
    FONTSIGNATURE fs;
}

struct LOCALESIGNATURE
{
    uint[4] lsUsb;
    uint[2] lsCsbDefault;
    uint[2] lsCsbSupported;
}

struct CPINFO
{
    uint      MaxCharSize;
    ubyte[2]  DefaultChar;
    ubyte[12] LeadByte;
}

struct CPINFOEXA
{
    uint      MaxCharSize;
    ubyte[2]  DefaultChar;
    ubyte[12] LeadByte;
    ushort    UnicodeDefaultChar;
    uint      CodePage;
    byte[260] CodePageName;
}

struct CPINFOEXW
{
    uint        MaxCharSize;
    ubyte[2]    DefaultChar;
    ubyte[12]   LeadByte;
    ushort      UnicodeDefaultChar;
    uint        CodePage;
    ushort[260] CodePageName;
}

struct NUMBERFMTA
{
    uint         NumDigits;
    uint         LeadingZero;
    uint         Grouping;
    const(char)* lpDecimalSep;
    const(char)* lpThousandSep;
    uint         NegativeOrder;
}

struct NUMBERFMTW
{
    uint          NumDigits;
    uint          LeadingZero;
    uint          Grouping;
    const(wchar)* lpDecimalSep;
    const(wchar)* lpThousandSep;
    uint          NegativeOrder;
}

struct CURRENCYFMTA
{
    uint         NumDigits;
    uint         LeadingZero;
    uint         Grouping;
    const(char)* lpDecimalSep;
    const(char)* lpThousandSep;
    uint         NegativeOrder;
    uint         PositiveOrder;
    const(char)* lpCurrencySymbol;
}

struct CURRENCYFMTW
{
    uint          NumDigits;
    uint          LeadingZero;
    uint          Grouping;
    const(wchar)* lpDecimalSep;
    const(wchar)* lpThousandSep;
    uint          NegativeOrder;
    uint          PositiveOrder;
    const(wchar)* lpCurrencySymbol;
}

struct NLSVERSIONINFO
{
    uint dwNLSVersionInfoSize;
    uint dwNLSVersion;
    uint dwDefinedVersion;
    uint dwEffectiveId;
    GUID guidCustomVersion;
}

struct NLSVERSIONINFOEX
{
    uint dwNLSVersionInfoSize;
    uint dwNLSVersion;
    uint dwDefinedVersion;
    uint dwEffectiveId;
    GUID guidCustomVersion;
}

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

struct COMPOSITIONFORM
{
    uint  dwStyle;
    POINT ptCurrentPos;
    RECT  rcArea;
}

struct CANDIDATEFORM
{
    uint  dwIndex;
    uint  dwStyle;
    POINT ptCurrentPos;
    RECT  rcArea;
}

struct CANDIDATELIST
{
    uint    dwSize;
    uint    dwStyle;
    uint    dwCount;
    uint    dwSelection;
    uint    dwPageStart;
    uint    dwPageSize;
    uint[1] dwOffset;
}

struct REGISTERWORDA
{
    const(char)* lpReading;
    const(char)* lpWord;
}

struct REGISTERWORDW
{
    const(wchar)* lpReading;
    const(wchar)* lpWord;
}

struct RECONVERTSTRING
{
    uint dwSize;
    uint dwVersion;
    uint dwStrLen;
    uint dwStrOffset;
    uint dwCompStrLen;
    uint dwCompStrOffset;
    uint dwTargetStrLen;
    uint dwTargetStrOffset;
}

struct STYLEBUFA
{
    uint     dwStyle;
    byte[32] szDescription;
}

struct STYLEBUFW
{
    uint       dwStyle;
    ushort[32] szDescription;
}

struct IMEMENUITEMINFOA
{
    uint     cbSize;
    uint     fType;
    uint     fState;
    uint     wID;
    HBITMAP  hbmpChecked;
    HBITMAP  hbmpUnchecked;
    uint     dwItemData;
    byte[80] szString;
    HBITMAP  hbmpItem;
}

struct IMEMENUITEMINFOW
{
    uint       cbSize;
    uint       fType;
    uint       fState;
    uint       wID;
    HBITMAP    hbmpChecked;
    HBITMAP    hbmpUnchecked;
    uint       dwItemData;
    ushort[80] szString;
    HBITMAP    hbmpItem;
}

struct IMECHARPOSITION
{
    uint  dwSize;
    uint  dwCharPos;
    POINT pt;
    uint  cLineHeight;
    RECT  rcDocument;
}

struct MAPPING_SERVICE_INFO
{
    size_t        Size;
    const(wchar)* pszCopyright;
    ushort        wMajorVersion;
    ushort        wMinorVersion;
    ushort        wBuildVersion;
    ushort        wStepVersion;
    uint          dwInputContentTypesCount;
    ushort**      prgInputContentTypes;
    uint          dwOutputContentTypesCount;
    ushort**      prgOutputContentTypes;
    uint          dwInputLanguagesCount;
    ushort**      prgInputLanguages;
    uint          dwOutputLanguagesCount;
    ushort**      prgOutputLanguages;
    uint          dwInputScriptsCount;
    ushort**      prgInputScripts;
    uint          dwOutputScriptsCount;
    ushort**      prgOutputScripts;
    GUID          guid;
    const(wchar)* pszCategory;
    const(wchar)* pszDescription;
    uint          dwPrivateDataSize;
    void*         pPrivateData;
    void*         pContext;
    uint          _bitfield51;
}

struct MAPPING_ENUM_OPTIONS
{
    size_t        Size;
    const(wchar)* pszCategory;
    const(wchar)* pszInputLanguage;
    const(wchar)* pszOutputLanguage;
    const(wchar)* pszInputScript;
    const(wchar)* pszOutputScript;
    const(wchar)* pszInputContentType;
    const(wchar)* pszOutputContentType;
    GUID*         pGuid;
    uint          _bitfield52;
}

struct MAPPING_OPTIONS
{
    size_t        Size;
    const(wchar)* pszInputLanguage;
    const(wchar)* pszOutputLanguage;
    const(wchar)* pszInputScript;
    const(wchar)* pszOutputScript;
    const(wchar)* pszInputContentType;
    const(wchar)* pszOutputContentType;
    const(wchar)* pszUILanguage;
    PFN_MAPPINGCALLBACKPROC pfnRecognizeCallback;
    void*         pRecognizeCallerData;
    uint          dwRecognizeCallerDataSize;
    PFN_MAPPINGCALLBACKPROC pfnActionCallback;
    void*         pActionCallerData;
    uint          dwActionCallerDataSize;
    uint          dwServiceFlag;
    uint          _bitfield53;
}

struct MAPPING_DATA_RANGE
{
    uint          dwStartIndex;
    uint          dwEndIndex;
    const(wchar)* pszDescription;
    uint          dwDescriptionLength;
    void*         pData;
    uint          dwDataSize;
    const(wchar)* pszContentType;
    ushort**      prgActionIds;
    uint          dwActionsCount;
    ushort**      prgActionDisplayNames;
}

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

struct IMEDLG
{
align (1):
    int           cbIMEDLG;
    HWND          hwnd;
    const(wchar)* lpwstrWord;
    int           nTabId;
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
    ushort* pwchOutput;
    ushort  cchOutput;
    union
    {
    align (1):
        ushort* pwchRead;
        ushort* pwchComp;
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

struct IMEWRD
{
align (1):
    ushort* pwchReading;
    ushort* pwchDisplay;
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
    uint[2] rgulAttrs;
    int     cbComment;
    IMEUCT  uct;
    void*   pvComment;
}

struct IMESHF
{
align (1):
    ushort    cbShf;
    ushort    verDic;
    byte[48]  szTitle;
    byte[256] szDescription;
    byte[128] szCopyright;
}

struct POSTBL
{
align (1):
    ushort nPos;
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

struct APPLETIDLIST
{
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
    uint          dwFarEastId;
    const(wchar)* lpwstr;
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

struct IMECOMPOSITIONSTRINGINFO
{
    int iCompStrLen;
    int iCaretPos;
    int iEditStart;
    int iEditLen;
    int iTargetStart;
    int iTargetLen;
}

struct IMECHARINFO
{
    ushort wch;
    uint   dwCharInfo;
}

struct IMEAPPLETCFG
{
    uint       dwConfig;
    ushort[64] wchTitle;
    ushort[32] wchTitleFontFace;
    uint       dwCharSet;
    int        iCategory;
    HICON      hIcon;
    ushort     langID;
    ushort     dummy;
    LPARAM     lReserved1;
}

struct IMEAPPLETUI
{
    HWND   hwnd;
    uint   dwStyle;
    int    width;
    int    height;
    int    minWidth;
    int    minHeight;
    int    maxWidth;
    int    maxHeight;
    LPARAM lReserved1;
    LPARAM lReserved2;
}

struct APPLYCANDEXPARAM
{
    uint          dwSize;
    const(wchar)* lpwstrDisplay;
    const(wchar)* lpwstrReading;
    uint          dwReserved;
}

struct SCRIPT_CONTROL
{
    uint _bitfield55;
}

struct SCRIPT_STATE
{
    ushort _bitfield56;
}

struct SCRIPT_ANALYSIS
{
    ushort       _bitfield57;
    SCRIPT_STATE s;
}

struct SCRIPT_ITEM
{
    int             iCharPos;
    SCRIPT_ANALYSIS a;
}

struct SCRIPT_VISATTR
{
    ushort _bitfield58;
}

struct GOFFSET
{
    int du;
    int dv;
}

struct SCRIPT_LOGATTR
{
    ubyte _bitfield59;
}

struct SCRIPT_PROPERTIES
{
    uint _bitfield1;
    uint _bitfield2;
}

struct SCRIPT_FONTPROPERTIES
{
    int    cBytes;
    ushort wgBlank;
    ushort wgDefault;
    ushort wgInvalid;
    ushort wgKashida;
    int    iKashidaWidth;
}

struct SCRIPT_TABDEF
{
    int  cTabStops;
    int  iScale;
    int* pTabStops;
    int  iTabOrigin;
}

struct SCRIPT_DIGITSUBSTITUTE
{
    uint _bitfield1;
    uint _bitfield2;
    uint dwReserved;
}

struct opentype_feature_record
{
    uint tagFeature;
    int  lParameter;
}

struct textrange_properties
{
    opentype_feature_record* potfRecords;
    int cotfRecords;
}

struct script_charprop
{
    ushort _bitfield60;
}

struct script_glyphprop
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

// Functions

@DllImport("GDI32")
int GetTextCharset(HDC hdc);

@DllImport("GDI32")
int GetTextCharsetInfo(HDC hdc, FONTSIGNATURE* lpSig, uint dwFlags);

@DllImport("GDI32")
BOOL TranslateCharsetInfo(uint* lpSrc, CHARSETINFO* lpCs, uint dwFlags);

@DllImport("KERNEL32")
int GetDateFormatA(uint Locale, uint dwFlags, const(SYSTEMTIME)* lpDate, const(char)* lpFormat, 
                   const(char)* lpDateStr, int cchDate);

@DllImport("KERNEL32")
int GetDateFormatW(uint Locale, uint dwFlags, const(SYSTEMTIME)* lpDate, const(wchar)* lpFormat, 
                   const(wchar)* lpDateStr, int cchDate);

@DllImport("KERNEL32")
int GetTimeFormatA(uint Locale, uint dwFlags, const(SYSTEMTIME)* lpTime, const(char)* lpFormat, 
                   const(char)* lpTimeStr, int cchTime);

@DllImport("KERNEL32")
int GetTimeFormatW(uint Locale, uint dwFlags, const(SYSTEMTIME)* lpTime, const(wchar)* lpFormat, 
                   const(wchar)* lpTimeStr, int cchTime);

@DllImport("KERNEL32")
int GetTimeFormatEx(const(wchar)* lpLocaleName, uint dwFlags, const(SYSTEMTIME)* lpTime, const(wchar)* lpFormat, 
                    const(wchar)* lpTimeStr, int cchTime);

@DllImport("KERNEL32")
int GetDateFormatEx(const(wchar)* lpLocaleName, uint dwFlags, const(SYSTEMTIME)* lpDate, const(wchar)* lpFormat, 
                    const(wchar)* lpDateStr, int cchDate, const(wchar)* lpCalendar);

@DllImport("KERNEL32")
int GetDurationFormatEx(const(wchar)* lpLocaleName, uint dwFlags, const(SYSTEMTIME)* lpDuration, ulong ullDuration, 
                        const(wchar)* lpFormat, const(wchar)* lpDurationStr, int cchDuration);

@DllImport("KERNEL32")
int CompareStringEx(const(wchar)* lpLocaleName, uint dwCmpFlags, const(wchar)* lpString1, int cchCount1, 
                    const(wchar)* lpString2, int cchCount2, NLSVERSIONINFO* lpVersionInformation, void* lpReserved, 
                    LPARAM lParam);

@DllImport("KERNEL32")
int CompareStringOrdinal(const(wchar)* lpString1, int cchCount1, const(wchar)* lpString2, int cchCount2, 
                         BOOL bIgnoreCase);

@DllImport("KERNEL32")
int CompareStringW(uint Locale, uint dwCmpFlags, char* lpString1, int cchCount1, char* lpString2, int cchCount2);

@DllImport("KERNEL32")
int FoldStringW(uint dwMapFlags, const(wchar)* lpSrcStr, int cchSrc, const(wchar)* lpDestStr, int cchDest);

@DllImport("KERNEL32")
BOOL GetStringTypeExW(uint Locale, uint dwInfoType, const(wchar)* lpSrcStr, int cchSrc, char* lpCharType);

@DllImport("KERNEL32")
BOOL GetStringTypeW(uint dwInfoType, const(wchar)* lpSrcStr, int cchSrc, ushort* lpCharType);

@DllImport("KERNEL32")
int MultiByteToWideChar(uint CodePage, uint dwFlags, const(char)* lpMultiByteStr, int cbMultiByte, 
                        const(wchar)* lpWideCharStr, int cchWideChar);

@DllImport("KERNEL32")
int WideCharToMultiByte(uint CodePage, uint dwFlags, const(wchar)* lpWideCharStr, int cchWideChar, 
                        const(char)* lpMultiByteStr, int cbMultiByte, const(char)* lpDefaultChar, 
                        int* lpUsedDefaultChar);

@DllImport("KERNEL32")
BOOL IsValidCodePage(uint CodePage);

@DllImport("KERNEL32")
uint GetACP();

@DllImport("KERNEL32")
uint GetOEMCP();

@DllImport("KERNEL32")
BOOL GetCPInfo(uint CodePage, CPINFO* lpCPInfo);

@DllImport("KERNEL32")
BOOL GetCPInfoExA(uint CodePage, uint dwFlags, CPINFOEXA* lpCPInfoEx);

@DllImport("KERNEL32")
BOOL GetCPInfoExW(uint CodePage, uint dwFlags, CPINFOEXW* lpCPInfoEx);

@DllImport("KERNEL32")
int CompareStringA(uint Locale, uint dwCmpFlags, char* lpString1, int cchCount1, char* lpString2, int cchCount2);

@DllImport("KERNEL32")
int FindNLSString(uint Locale, uint dwFindNLSStringFlags, const(wchar)* lpStringSource, int cchSource, 
                  const(wchar)* lpStringValue, int cchValue, int* pcchFound);

@DllImport("KERNEL32")
int LCMapStringW(uint Locale, uint dwMapFlags, const(wchar)* lpSrcStr, int cchSrc, const(wchar)* lpDestStr, 
                 int cchDest);

@DllImport("KERNEL32")
int LCMapStringA(uint Locale, uint dwMapFlags, const(char)* lpSrcStr, int cchSrc, const(char)* lpDestStr, 
                 int cchDest);

@DllImport("KERNEL32")
int GetLocaleInfoW(uint Locale, uint LCType, const(wchar)* lpLCData, int cchData);

@DllImport("KERNEL32")
int GetLocaleInfoA(uint Locale, uint LCType, const(char)* lpLCData, int cchData);

@DllImport("KERNEL32")
BOOL SetLocaleInfoA(uint Locale, uint LCType, const(char)* lpLCData);

@DllImport("KERNEL32")
BOOL SetLocaleInfoW(uint Locale, uint LCType, const(wchar)* lpLCData);

@DllImport("KERNEL32")
int GetCalendarInfoA(uint Locale, uint Calendar, uint CalType, const(char)* lpCalData, int cchData, uint* lpValue);

@DllImport("KERNEL32")
int GetCalendarInfoW(uint Locale, uint Calendar, uint CalType, const(wchar)* lpCalData, int cchData, uint* lpValue);

@DllImport("KERNEL32")
BOOL SetCalendarInfoA(uint Locale, uint Calendar, uint CalType, const(char)* lpCalData);

@DllImport("KERNEL32")
BOOL SetCalendarInfoW(uint Locale, uint Calendar, uint CalType, const(wchar)* lpCalData);

@DllImport("KERNEL32")
BOOL IsDBCSLeadByte(ubyte TestChar);

@DllImport("KERNEL32")
BOOL IsDBCSLeadByteEx(uint CodePage, ubyte TestChar);

@DllImport("KERNEL32")
uint LocaleNameToLCID(const(wchar)* lpName, uint dwFlags);

@DllImport("KERNEL32")
int LCIDToLocaleName(uint Locale, const(wchar)* lpName, int cchName, uint dwFlags);

@DllImport("KERNEL32")
int GetDurationFormat(uint Locale, uint dwFlags, const(SYSTEMTIME)* lpDuration, ulong ullDuration, 
                      const(wchar)* lpFormat, const(wchar)* lpDurationStr, int cchDuration);

@DllImport("KERNEL32")
int GetNumberFormatA(uint Locale, uint dwFlags, const(char)* lpValue, const(NUMBERFMTA)* lpFormat, 
                     const(char)* lpNumberStr, int cchNumber);

@DllImport("KERNEL32")
int GetNumberFormatW(uint Locale, uint dwFlags, const(wchar)* lpValue, const(NUMBERFMTW)* lpFormat, 
                     const(wchar)* lpNumberStr, int cchNumber);

@DllImport("KERNEL32")
int GetCurrencyFormatA(uint Locale, uint dwFlags, const(char)* lpValue, const(CURRENCYFMTA)* lpFormat, 
                       const(char)* lpCurrencyStr, int cchCurrency);

@DllImport("KERNEL32")
int GetCurrencyFormatW(uint Locale, uint dwFlags, const(wchar)* lpValue, const(CURRENCYFMTW)* lpFormat, 
                       const(wchar)* lpCurrencyStr, int cchCurrency);

@DllImport("KERNEL32")
BOOL EnumCalendarInfoA(CALINFO_ENUMPROCA lpCalInfoEnumProc, uint Locale, uint Calendar, uint CalType);

@DllImport("KERNEL32")
BOOL EnumCalendarInfoW(CALINFO_ENUMPROCW lpCalInfoEnumProc, uint Locale, uint Calendar, uint CalType);

@DllImport("KERNEL32")
BOOL EnumCalendarInfoExA(CALINFO_ENUMPROCEXA lpCalInfoEnumProcEx, uint Locale, uint Calendar, uint CalType);

@DllImport("KERNEL32")
BOOL EnumCalendarInfoExW(CALINFO_ENUMPROCEXW lpCalInfoEnumProcEx, uint Locale, uint Calendar, uint CalType);

@DllImport("KERNEL32")
BOOL EnumTimeFormatsA(TIMEFMT_ENUMPROCA lpTimeFmtEnumProc, uint Locale, uint dwFlags);

@DllImport("KERNEL32")
BOOL EnumTimeFormatsW(TIMEFMT_ENUMPROCW lpTimeFmtEnumProc, uint Locale, uint dwFlags);

@DllImport("KERNEL32")
BOOL EnumDateFormatsA(DATEFMT_ENUMPROCA lpDateFmtEnumProc, uint Locale, uint dwFlags);

@DllImport("KERNEL32")
BOOL EnumDateFormatsW(DATEFMT_ENUMPROCW lpDateFmtEnumProc, uint Locale, uint dwFlags);

@DllImport("KERNEL32")
BOOL EnumDateFormatsExA(DATEFMT_ENUMPROCEXA lpDateFmtEnumProcEx, uint Locale, uint dwFlags);

@DllImport("KERNEL32")
BOOL EnumDateFormatsExW(DATEFMT_ENUMPROCEXW lpDateFmtEnumProcEx, uint Locale, uint dwFlags);

@DllImport("KERNEL32")
BOOL IsValidLanguageGroup(uint LanguageGroup, uint dwFlags);

@DllImport("KERNEL32")
BOOL GetNLSVersion(uint Function, uint Locale, NLSVERSIONINFO* lpVersionInformation);

@DllImport("KERNEL32")
BOOL IsValidLocale(uint Locale, uint dwFlags);

@DllImport("KERNEL32")
int GetGeoInfoA(int Location, uint GeoType, const(char)* lpGeoData, int cchData, ushort LangId);

@DllImport("KERNEL32")
int GetGeoInfoW(int Location, uint GeoType, const(wchar)* lpGeoData, int cchData, ushort LangId);

@DllImport("KERNEL32")
int GetGeoInfoEx(const(wchar)* location, uint geoType, const(wchar)* geoData, int geoDataCount);

@DllImport("KERNEL32")
BOOL EnumSystemGeoID(uint GeoClass, int ParentGeoId, GEO_ENUMPROC lpGeoEnumProc);

@DllImport("KERNEL32")
BOOL EnumSystemGeoNames(uint geoClass, GEO_ENUMNAMEPROC geoEnumProc, LPARAM data);

@DllImport("KERNEL32")
int GetUserGeoID(uint GeoClass);

@DllImport("KERNEL32")
int GetUserDefaultGeoName(const(wchar)* geoName, int geoNameCount);

@DllImport("KERNEL32")
BOOL SetUserGeoID(int GeoId);

@DllImport("KERNEL32")
BOOL SetUserGeoName(const(wchar)* geoName);

@DllImport("KERNEL32")
uint ConvertDefaultLocale(uint Locale);

@DllImport("KERNEL32")
ushort GetSystemDefaultUILanguage();

@DllImport("KERNEL32")
uint GetThreadLocale();

@DllImport("KERNEL32")
BOOL SetThreadLocale(uint Locale);

@DllImport("KERNEL32")
ushort GetUserDefaultUILanguage();

@DllImport("KERNEL32")
ushort GetUserDefaultLangID();

@DllImport("KERNEL32")
ushort GetSystemDefaultLangID();

@DllImport("KERNEL32")
uint GetSystemDefaultLCID();

@DllImport("KERNEL32")
uint GetUserDefaultLCID();

@DllImport("KERNEL32")
ushort SetThreadUILanguage(ushort LangId);

@DllImport("KERNEL32")
ushort GetThreadUILanguage();

@DllImport("KERNEL32")
BOOL GetProcessPreferredUILanguages(uint dwFlags, uint* pulNumLanguages, const(wchar)* pwszLanguagesBuffer, 
                                    uint* pcchLanguagesBuffer);

@DllImport("KERNEL32")
BOOL SetProcessPreferredUILanguages(uint dwFlags, const(wchar)* pwszLanguagesBuffer, uint* pulNumLanguages);

@DllImport("KERNEL32")
BOOL GetUserPreferredUILanguages(uint dwFlags, uint* pulNumLanguages, const(wchar)* pwszLanguagesBuffer, 
                                 uint* pcchLanguagesBuffer);

@DllImport("KERNEL32")
BOOL GetSystemPreferredUILanguages(uint dwFlags, uint* pulNumLanguages, const(wchar)* pwszLanguagesBuffer, 
                                   uint* pcchLanguagesBuffer);

@DllImport("KERNEL32")
BOOL GetThreadPreferredUILanguages(uint dwFlags, uint* pulNumLanguages, const(wchar)* pwszLanguagesBuffer, 
                                   uint* pcchLanguagesBuffer);

@DllImport("KERNEL32")
BOOL SetThreadPreferredUILanguages(uint dwFlags, const(wchar)* pwszLanguagesBuffer, uint* pulNumLanguages);

@DllImport("KERNEL32")
BOOL GetFileMUIInfo(uint dwFlags, const(wchar)* pcwszFilePath, char* pFileMUIInfo, uint* pcbFileMUIInfo);

@DllImport("KERNEL32")
BOOL GetFileMUIPath(uint dwFlags, const(wchar)* pcwszFilePath, const(wchar)* pwszLanguage, uint* pcchLanguage, 
                    const(wchar)* pwszFileMUIPath, uint* pcchFileMUIPath, ulong* pululEnumerator);

@DllImport("KERNEL32")
BOOL GetUILanguageInfo(uint dwFlags, const(wchar)* pwmszLanguage, const(wchar)* pwszFallbackLanguages, 
                       uint* pcchFallbackLanguages, uint* pAttributes);

@DllImport("KERNEL32")
BOOL SetThreadPreferredUILanguages2(uint flags, const(wchar)* languages, uint* numLanguagesSet, 
                                    HSAVEDUILANGUAGES__** snapshot);

@DllImport("KERNEL32")
void RestoreThreadPreferredUILanguages(const(HSAVEDUILANGUAGES__)* snapshot);

@DllImport("KERNEL32")
BOOL NotifyUILanguageChange(uint dwFlags, const(wchar)* pcwstrNewLanguage, const(wchar)* pcwstrPreviousLanguage, 
                            uint dwReserved, uint* pdwStatusRtrn);

@DllImport("KERNEL32")
BOOL GetStringTypeExA(uint Locale, uint dwInfoType, const(char)* lpSrcStr, int cchSrc, char* lpCharType);

@DllImport("KERNEL32")
BOOL GetStringTypeA(uint Locale, uint dwInfoType, const(char)* lpSrcStr, int cchSrc, ushort* lpCharType);

@DllImport("KERNEL32")
int FoldStringA(uint dwMapFlags, const(char)* lpSrcStr, int cchSrc, const(char)* lpDestStr, int cchDest);

@DllImport("KERNEL32")
BOOL EnumSystemLocalesA(LOCALE_ENUMPROCA lpLocaleEnumProc, uint dwFlags);

@DllImport("KERNEL32")
BOOL EnumSystemLocalesW(LOCALE_ENUMPROCW lpLocaleEnumProc, uint dwFlags);

@DllImport("KERNEL32")
BOOL EnumSystemLanguageGroupsA(LANGUAGEGROUP_ENUMPROCA lpLanguageGroupEnumProc, uint dwFlags, ptrdiff_t lParam);

@DllImport("KERNEL32")
BOOL EnumSystemLanguageGroupsW(LANGUAGEGROUP_ENUMPROCW lpLanguageGroupEnumProc, uint dwFlags, ptrdiff_t lParam);

@DllImport("KERNEL32")
BOOL EnumLanguageGroupLocalesA(LANGGROUPLOCALE_ENUMPROCA lpLangGroupLocaleEnumProc, uint LanguageGroup, 
                               uint dwFlags, ptrdiff_t lParam);

@DllImport("KERNEL32")
BOOL EnumLanguageGroupLocalesW(LANGGROUPLOCALE_ENUMPROCW lpLangGroupLocaleEnumProc, uint LanguageGroup, 
                               uint dwFlags, ptrdiff_t lParam);

@DllImport("KERNEL32")
BOOL EnumUILanguagesA(UILANGUAGE_ENUMPROCA lpUILanguageEnumProc, uint dwFlags, ptrdiff_t lParam);

@DllImport("KERNEL32")
BOOL EnumUILanguagesW(UILANGUAGE_ENUMPROCW lpUILanguageEnumProc, uint dwFlags, ptrdiff_t lParam);

@DllImport("KERNEL32")
BOOL EnumSystemCodePagesA(CODEPAGE_ENUMPROCA lpCodePageEnumProc, uint dwFlags);

@DllImport("KERNEL32")
BOOL EnumSystemCodePagesW(CODEPAGE_ENUMPROCW lpCodePageEnumProc, uint dwFlags);

@DllImport("NORMALIZ")
int IdnToAscii(uint dwFlags, const(wchar)* lpUnicodeCharStr, int cchUnicodeChar, const(wchar)* lpASCIICharStr, 
               int cchASCIIChar);

@DllImport("NORMALIZ")
int IdnToUnicode(uint dwFlags, const(wchar)* lpASCIICharStr, int cchASCIIChar, const(wchar)* lpUnicodeCharStr, 
                 int cchUnicodeChar);

@DllImport("KERNEL32")
int IdnToNameprepUnicode(uint dwFlags, const(wchar)* lpUnicodeCharStr, int cchUnicodeChar, 
                         const(wchar)* lpNameprepCharStr, int cchNameprepChar);

@DllImport("KERNEL32")
int NormalizeString(NORM_FORM NormForm, const(wchar)* lpSrcString, int cwSrcLength, const(wchar)* lpDstString, 
                    int cwDstLength);

@DllImport("KERNEL32")
BOOL IsNormalizedString(NORM_FORM NormForm, const(wchar)* lpString, int cwLength);

@DllImport("KERNEL32")
BOOL VerifyScripts(uint dwFlags, const(wchar)* lpLocaleScripts, int cchLocaleScripts, const(wchar)* lpTestScripts, 
                   int cchTestScripts);

@DllImport("KERNEL32")
int GetStringScripts(uint dwFlags, const(wchar)* lpString, int cchString, const(wchar)* lpScripts, int cchScripts);

@DllImport("KERNEL32")
int GetLocaleInfoEx(const(wchar)* lpLocaleName, uint LCType, const(wchar)* lpLCData, int cchData);

@DllImport("KERNEL32")
int GetCalendarInfoEx(const(wchar)* lpLocaleName, uint Calendar, const(wchar)* lpReserved, uint CalType, 
                      const(wchar)* lpCalData, int cchData, uint* lpValue);

@DllImport("KERNEL32")
int GetNumberFormatEx(const(wchar)* lpLocaleName, uint dwFlags, const(wchar)* lpValue, const(NUMBERFMTW)* lpFormat, 
                      const(wchar)* lpNumberStr, int cchNumber);

@DllImport("KERNEL32")
int GetCurrencyFormatEx(const(wchar)* lpLocaleName, uint dwFlags, const(wchar)* lpValue, 
                        const(CURRENCYFMTW)* lpFormat, const(wchar)* lpCurrencyStr, int cchCurrency);

@DllImport("KERNEL32")
int GetUserDefaultLocaleName(const(wchar)* lpLocaleName, int cchLocaleName);

@DllImport("KERNEL32")
int GetSystemDefaultLocaleName(const(wchar)* lpLocaleName, int cchLocaleName);

@DllImport("KERNEL32")
BOOL IsNLSDefinedString(uint Function, uint dwFlags, NLSVERSIONINFO* lpVersionInformation, const(wchar)* lpString, 
                        int cchStr);

@DllImport("KERNEL32")
BOOL GetNLSVersionEx(uint function_, const(wchar)* lpLocaleName, NLSVERSIONINFOEX* lpVersionInformation);

@DllImport("KERNEL32")
uint IsValidNLSVersion(uint function_, const(wchar)* lpLocaleName, NLSVERSIONINFOEX* lpVersionInformation);

@DllImport("KERNEL32")
int FindNLSStringEx(const(wchar)* lpLocaleName, uint dwFindNLSStringFlags, const(wchar)* lpStringSource, 
                    int cchSource, const(wchar)* lpStringValue, int cchValue, int* pcchFound, 
                    NLSVERSIONINFO* lpVersionInformation, void* lpReserved, LPARAM sortHandle);

@DllImport("KERNEL32")
int LCMapStringEx(const(wchar)* lpLocaleName, uint dwMapFlags, const(wchar)* lpSrcStr, int cchSrc, 
                  const(wchar)* lpDestStr, int cchDest, NLSVERSIONINFO* lpVersionInformation, void* lpReserved, 
                  LPARAM sortHandle);

@DllImport("KERNEL32")
BOOL IsValidLocaleName(const(wchar)* lpLocaleName);

@DllImport("KERNEL32")
BOOL EnumCalendarInfoExEx(CALINFO_ENUMPROCEXEX pCalInfoEnumProcExEx, const(wchar)* lpLocaleName, uint Calendar, 
                          const(wchar)* lpReserved, uint CalType, LPARAM lParam);

@DllImport("KERNEL32")
BOOL EnumDateFormatsExEx(DATEFMT_ENUMPROCEXEX lpDateFmtEnumProcExEx, const(wchar)* lpLocaleName, uint dwFlags, 
                         LPARAM lParam);

@DllImport("KERNEL32")
BOOL EnumTimeFormatsEx(TIMEFMT_ENUMPROCEX lpTimeFmtEnumProcEx, const(wchar)* lpLocaleName, uint dwFlags, 
                       LPARAM lParam);

@DllImport("KERNEL32")
BOOL EnumSystemLocalesEx(LOCALE_ENUMPROCEX lpLocaleEnumProcEx, uint dwFlags, LPARAM lParam, void* lpReserved);

@DllImport("KERNEL32")
int ResolveLocaleName(const(wchar)* lpNameToResolve, const(wchar)* lpLocaleName, int cchLocaleName);

@DllImport("IMM32")
ptrdiff_t ImmInstallIMEA(const(char)* lpszIMEFileName, const(char)* lpszLayoutText);

@DllImport("IMM32")
ptrdiff_t ImmInstallIMEW(const(wchar)* lpszIMEFileName, const(wchar)* lpszLayoutText);

@DllImport("IMM32")
HWND ImmGetDefaultIMEWnd(HWND param0);

@DllImport("IMM32")
uint ImmGetDescriptionA(ptrdiff_t param0, const(char)* lpszDescription, uint uBufLen);

@DllImport("IMM32")
uint ImmGetDescriptionW(ptrdiff_t param0, const(wchar)* lpszDescription, uint uBufLen);

@DllImport("IMM32")
uint ImmGetIMEFileNameA(ptrdiff_t param0, const(char)* lpszFileName, uint uBufLen);

@DllImport("IMM32")
uint ImmGetIMEFileNameW(ptrdiff_t param0, const(wchar)* lpszFileName, uint uBufLen);

@DllImport("IMM32")
uint ImmGetProperty(ptrdiff_t param0, uint param1);

@DllImport("IMM32")
BOOL ImmIsIME(ptrdiff_t param0);

@DllImport("IMM32")
BOOL ImmSimulateHotKey(HWND param0, uint param1);

@DllImport("IMM32")
HIMC__* ImmCreateContext();

@DllImport("IMM32")
BOOL ImmDestroyContext(HIMC__* param0);

@DllImport("IMM32")
HIMC__* ImmGetContext(HWND param0);

@DllImport("IMM32")
BOOL ImmReleaseContext(HWND param0, HIMC__* param1);

@DllImport("IMM32")
HIMC__* ImmAssociateContext(HWND param0, HIMC__* param1);

@DllImport("IMM32")
BOOL ImmAssociateContextEx(HWND param0, HIMC__* param1, uint param2);

@DllImport("IMM32")
int ImmGetCompositionStringA(HIMC__* param0, uint param1, char* lpBuf, uint dwBufLen);

@DllImport("IMM32")
int ImmGetCompositionStringW(HIMC__* param0, uint param1, char* lpBuf, uint dwBufLen);

@DllImport("IMM32")
BOOL ImmSetCompositionStringA(HIMC__* param0, uint dwIndex, char* lpComp, uint dwCompLen, char* lpRead, 
                              uint dwReadLen);

@DllImport("IMM32")
BOOL ImmSetCompositionStringW(HIMC__* param0, uint dwIndex, char* lpComp, uint dwCompLen, char* lpRead, 
                              uint dwReadLen);

@DllImport("IMM32")
uint ImmGetCandidateListCountA(HIMC__* param0, uint* lpdwListCount);

@DllImport("IMM32")
uint ImmGetCandidateListCountW(HIMC__* param0, uint* lpdwListCount);

@DllImport("IMM32")
uint ImmGetCandidateListA(HIMC__* param0, uint deIndex, char* lpCandList, uint dwBufLen);

@DllImport("IMM32")
uint ImmGetCandidateListW(HIMC__* param0, uint deIndex, char* lpCandList, uint dwBufLen);

@DllImport("IMM32")
uint ImmGetGuideLineA(HIMC__* param0, uint dwIndex, const(char)* lpBuf, uint dwBufLen);

@DllImport("IMM32")
uint ImmGetGuideLineW(HIMC__* param0, uint dwIndex, const(wchar)* lpBuf, uint dwBufLen);

@DllImport("IMM32")
BOOL ImmGetConversionStatus(HIMC__* param0, uint* lpfdwConversion, uint* lpfdwSentence);

@DllImport("IMM32")
BOOL ImmSetConversionStatus(HIMC__* param0, uint param1, uint param2);

@DllImport("IMM32")
BOOL ImmGetOpenStatus(HIMC__* param0);

@DllImport("IMM32")
BOOL ImmSetOpenStatus(HIMC__* param0, BOOL param1);

@DllImport("IMM32")
BOOL ImmGetCompositionFontA(HIMC__* param0, LOGFONTA* lplf);

@DllImport("IMM32")
BOOL ImmGetCompositionFontW(HIMC__* param0, LOGFONTW* lplf);

@DllImport("IMM32")
BOOL ImmSetCompositionFontA(HIMC__* param0, LOGFONTA* lplf);

@DllImport("IMM32")
BOOL ImmSetCompositionFontW(HIMC__* param0, LOGFONTW* lplf);

@DllImport("IMM32")
BOOL ImmConfigureIMEA(ptrdiff_t param0, HWND param1, uint param2, void* param3);

@DllImport("IMM32")
BOOL ImmConfigureIMEW(ptrdiff_t param0, HWND param1, uint param2, void* param3);

@DllImport("IMM32")
LRESULT ImmEscapeA(ptrdiff_t param0, HIMC__* param1, uint param2, void* param3);

@DllImport("IMM32")
LRESULT ImmEscapeW(ptrdiff_t param0, HIMC__* param1, uint param2, void* param3);

@DllImport("IMM32")
uint ImmGetConversionListA(ptrdiff_t param0, HIMC__* param1, const(char)* lpSrc, char* lpDst, uint dwBufLen, 
                           uint uFlag);

@DllImport("IMM32")
uint ImmGetConversionListW(ptrdiff_t param0, HIMC__* param1, const(wchar)* lpSrc, char* lpDst, uint dwBufLen, 
                           uint uFlag);

@DllImport("IMM32")
BOOL ImmNotifyIME(HIMC__* param0, uint dwAction, uint dwIndex, uint dwValue);

@DllImport("IMM32")
BOOL ImmGetStatusWindowPos(HIMC__* param0, POINT* lpptPos);

@DllImport("IMM32")
BOOL ImmSetStatusWindowPos(HIMC__* param0, POINT* lpptPos);

@DllImport("IMM32")
BOOL ImmGetCompositionWindow(HIMC__* param0, COMPOSITIONFORM* lpCompForm);

@DllImport("IMM32")
BOOL ImmSetCompositionWindow(HIMC__* param0, COMPOSITIONFORM* lpCompForm);

@DllImport("IMM32")
BOOL ImmGetCandidateWindow(HIMC__* param0, uint param1, CANDIDATEFORM* lpCandidate);

@DllImport("IMM32")
BOOL ImmSetCandidateWindow(HIMC__* param0, CANDIDATEFORM* lpCandidate);

@DllImport("IMM32")
BOOL ImmIsUIMessageA(HWND param0, uint param1, WPARAM param2, LPARAM param3);

@DllImport("IMM32")
BOOL ImmIsUIMessageW(HWND param0, uint param1, WPARAM param2, LPARAM param3);

@DllImport("IMM32")
uint ImmGetVirtualKey(HWND param0);

@DllImport("IMM32")
BOOL ImmRegisterWordA(ptrdiff_t param0, const(char)* lpszReading, uint param2, const(char)* lpszRegister);

@DllImport("IMM32")
BOOL ImmRegisterWordW(ptrdiff_t param0, const(wchar)* lpszReading, uint param2, const(wchar)* lpszRegister);

@DllImport("IMM32")
BOOL ImmUnregisterWordA(ptrdiff_t param0, const(char)* lpszReading, uint param2, const(char)* lpszUnregister);

@DllImport("IMM32")
BOOL ImmUnregisterWordW(ptrdiff_t param0, const(wchar)* lpszReading, uint param2, const(wchar)* lpszUnregister);

@DllImport("IMM32")
uint ImmGetRegisterWordStyleA(ptrdiff_t param0, uint nItem, char* lpStyleBuf);

@DllImport("IMM32")
uint ImmGetRegisterWordStyleW(ptrdiff_t param0, uint nItem, char* lpStyleBuf);

@DllImport("IMM32")
uint ImmEnumRegisterWordA(ptrdiff_t param0, REGISTERWORDENUMPROCA param1, const(char)* lpszReading, uint param3, 
                          const(char)* lpszRegister, void* param5);

@DllImport("IMM32")
uint ImmEnumRegisterWordW(ptrdiff_t param0, REGISTERWORDENUMPROCW param1, const(wchar)* lpszReading, uint param3, 
                          const(wchar)* lpszRegister, void* param5);

@DllImport("IMM32")
BOOL ImmDisableIME(uint param0);

@DllImport("IMM32")
BOOL ImmEnumInputContext(uint idThread, IMCENUMPROC lpfn, LPARAM lParam);

@DllImport("IMM32")
uint ImmGetImeMenuItemsA(HIMC__* param0, uint param1, uint param2, IMEMENUITEMINFOA* lpImeParentMenu, 
                         char* lpImeMenu, uint dwSize);

@DllImport("IMM32")
uint ImmGetImeMenuItemsW(HIMC__* param0, uint param1, uint param2, IMEMENUITEMINFOW* lpImeParentMenu, 
                         char* lpImeMenu, uint dwSize);

@DllImport("IMM32")
BOOL ImmDisableTextFrameService(uint idThread);

@DllImport("IMM32")
BOOL ImmDisableLegacyIME();

@DllImport("elscore")
HRESULT MappingGetServices(MAPPING_ENUM_OPTIONS* pOptions, MAPPING_SERVICE_INFO** prgServices, 
                           uint* pdwServicesCount);

@DllImport("elscore")
HRESULT MappingFreeServices(MAPPING_SERVICE_INFO* pServiceInfo);

@DllImport("elscore")
HRESULT MappingRecognizeText(MAPPING_SERVICE_INFO* pServiceInfo, const(wchar)* pszText, uint dwLength, 
                             uint dwIndex, MAPPING_OPTIONS* pOptions, MAPPING_PROPERTY_BAG* pbag);

@DllImport("elscore")
HRESULT MappingDoAction(MAPPING_PROPERTY_BAG* pBag, uint dwRangeIndex, const(wchar)* pszActionId);

@DllImport("elscore")
HRESULT MappingFreePropertyBag(MAPPING_PROPERTY_BAG* pBag);

@DllImport("IMM32")
BOOL ImmGetHotKey(uint param0, uint* lpuModifiers, uint* lpuVKey, ptrdiff_t* phKL);

@DllImport("IMM32")
BOOL ImmSetHotKey(uint param0, uint param1, uint param2, ptrdiff_t param3);

@DllImport("IMM32")
BOOL ImmGenerateMessage(HIMC__* param0);

@DllImport("IMM32")
LRESULT ImmRequestMessageA(HIMC__* param0, WPARAM param1, LPARAM param2);

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

@DllImport("USP10")
HRESULT ScriptFreeCache(void** psc);

@DllImport("USP10")
HRESULT ScriptItemize(const(wchar)* pwcInChars, int cInChars, int cMaxItems, const(SCRIPT_CONTROL)* psControl, 
                      const(SCRIPT_STATE)* psState, char* pItems, int* pcItems);

@DllImport("USP10")
HRESULT ScriptLayout(int cRuns, char* pbLevel, char* piVisualToLogical, char* piLogicalToVisual);

@DllImport("USP10")
HRESULT ScriptShape(HDC hdc, void** psc, const(wchar)* pwcChars, int cChars, int cMaxGlyphs, SCRIPT_ANALYSIS* psa, 
                    char* pwOutGlyphs, char* pwLogClust, char* psva, int* pcGlyphs);

@DllImport("USP10")
HRESULT ScriptPlace(HDC hdc, void** psc, char* pwGlyphs, int cGlyphs, char* psva, SCRIPT_ANALYSIS* psa, 
                    char* piAdvance, char* pGoffset, ABC* pABC);

@DllImport("USP10")
HRESULT ScriptTextOut(const(ptrdiff_t) hdc, void** psc, int x, int y, uint fuOptions, const(RECT)* lprc, 
                      const(SCRIPT_ANALYSIS)* psa, const(wchar)* pwcReserved, int iReserved, char* pwGlyphs, 
                      int cGlyphs, char* piAdvance, char* piJustify, char* pGoffset);

@DllImport("USP10")
HRESULT ScriptJustify(char* psva, char* piAdvance, int cGlyphs, int iDx, int iMinKashida, char* piJustify);

@DllImport("USP10")
HRESULT ScriptBreak(const(wchar)* pwcChars, int cChars, const(SCRIPT_ANALYSIS)* psa, char* psla);

@DllImport("USP10")
HRESULT ScriptCPtoX(int iCP, BOOL fTrailing, int cChars, int cGlyphs, char* pwLogClust, char* psva, 
                    char* piAdvance, const(SCRIPT_ANALYSIS)* psa, int* piX);

@DllImport("USP10")
HRESULT ScriptXtoCP(int iX, int cChars, int cGlyphs, char* pwLogClust, char* psva, char* piAdvance, 
                    const(SCRIPT_ANALYSIS)* psa, int* piCP, int* piTrailing);

@DllImport("USP10")
HRESULT ScriptGetLogicalWidths(const(SCRIPT_ANALYSIS)* psa, int cChars, int cGlyphs, char* piGlyphWidth, 
                               char* pwLogClust, char* psva, char* piDx);

@DllImport("USP10")
HRESULT ScriptApplyLogicalWidth(char* piDx, int cChars, int cGlyphs, char* pwLogClust, char* psva, char* piAdvance, 
                                const(SCRIPT_ANALYSIS)* psa, ABC* pABC, char* piJustify);

@DllImport("USP10")
HRESULT ScriptGetCMap(HDC hdc, void** psc, const(wchar)* pwcInChars, int cChars, uint dwFlags, char* pwOutGlyphs);

@DllImport("USP10")
HRESULT ScriptGetGlyphABCWidth(HDC hdc, void** psc, ushort wGlyph, ABC* pABC);

@DllImport("USP10")
HRESULT ScriptGetProperties(const(SCRIPT_PROPERTIES)*** ppSp, int* piNumScripts);

@DllImport("USP10")
HRESULT ScriptGetFontProperties(HDC hdc, void** psc, SCRIPT_FONTPROPERTIES* sfp);

@DllImport("USP10")
HRESULT ScriptCacheGetHeight(HDC hdc, void** psc, int* tmHeight);

@DllImport("USP10")
HRESULT ScriptStringAnalyse(HDC hdc, const(void)* pString, int cString, int cGlyphs, int iCharset, uint dwFlags, 
                            int iReqWidth, SCRIPT_CONTROL* psControl, SCRIPT_STATE* psState, char* piDx, 
                            SCRIPT_TABDEF* pTabdef, const(ubyte)* pbInClass, void** pssa);

@DllImport("USP10")
HRESULT ScriptStringFree(void** pssa);

@DllImport("USP10")
SIZE* ScriptString_pSize(void* ssa);

@DllImport("USP10")
int* ScriptString_pcOutChars(void* ssa);

@DllImport("USP10")
SCRIPT_LOGATTR* ScriptString_pLogAttr(void* ssa);

@DllImport("USP10")
HRESULT ScriptStringGetOrder(void* ssa, uint* puOrder);

@DllImport("USP10")
HRESULT ScriptStringCPtoX(void* ssa, int icp, BOOL fTrailing, int* pX);

@DllImport("USP10")
HRESULT ScriptStringXtoCP(void* ssa, int iX, int* piCh, int* piTrailing);

@DllImport("USP10")
HRESULT ScriptStringGetLogicalWidths(void* ssa, int* piDx);

@DllImport("USP10")
HRESULT ScriptStringValidate(void* ssa);

@DllImport("USP10")
HRESULT ScriptStringOut(void* ssa, int iX, int iY, uint uOptions, const(RECT)* prc, int iMinSel, int iMaxSel, 
                        BOOL fDisabled);

@DllImport("USP10")
HRESULT ScriptIsComplex(const(wchar)* pwcInChars, int cInChars, uint dwFlags);

@DllImport("USP10")
HRESULT ScriptRecordDigitSubstitution(uint Locale, SCRIPT_DIGITSUBSTITUTE* psds);

@DllImport("USP10")
HRESULT ScriptApplyDigitSubstitution(const(SCRIPT_DIGITSUBSTITUTE)* psds, SCRIPT_CONTROL* psc, SCRIPT_STATE* pss);

@DllImport("USP10")
HRESULT ScriptShapeOpenType(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, 
                            char* rcRangeChars, char* rpRangeProperties, int cRanges, const(wchar)* pwcChars, 
                            int cChars, int cMaxGlyphs, char* pwLogClust, char* pCharProps, char* pwOutGlyphs, 
                            char* pOutGlyphProps, int* pcGlyphs);

@DllImport("USP10")
HRESULT ScriptPlaceOpenType(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, 
                            char* rcRangeChars, char* rpRangeProperties, int cRanges, const(wchar)* pwcChars, 
                            char* pwLogClust, char* pCharProps, int cChars, char* pwGlyphs, char* pGlyphProps, 
                            int cGlyphs, char* piAdvance, char* pGoffset, ABC* pABC);

@DllImport("USP10")
HRESULT ScriptItemizeOpenType(const(wchar)* pwcInChars, int cInChars, int cMaxItems, 
                              const(SCRIPT_CONTROL)* psControl, const(SCRIPT_STATE)* psState, char* pItems, 
                              char* pScriptTags, int* pcItems);

@DllImport("USP10")
HRESULT ScriptGetFontScriptTags(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, int cMaxTags, char* pScriptTags, 
                                int* pcTags);

@DllImport("USP10")
HRESULT ScriptGetFontLanguageTags(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, int cMaxTags, 
                                  char* pLangsysTags, int* pcTags);

@DllImport("USP10")
HRESULT ScriptGetFontFeatureTags(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, 
                                 int cMaxTags, char* pFeatureTags, int* pcTags);

@DllImport("USP10")
HRESULT ScriptGetFontAlternateGlyphs(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, 
                                     uint tagFeature, ushort wGlyphId, int cMaxAlternates, char* pAlternateGlyphs, 
                                     int* pcAlternates);

@DllImport("USP10")
HRESULT ScriptSubstituteSingleGlyph(HDC hdc, void** psc, SCRIPT_ANALYSIS* psa, uint tagScript, uint tagLangSys, 
                                    uint tagFeature, int lParameter, ushort wGlyphId, ushort* pwOutGlyphId);

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
ushort* u_strToWCS(ushort* dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, 
                   UErrorCode* pErrorCode);

@DllImport("icu")
ushort* u_strFromWCS(ushort* dest, int destCapacity, int* pDestLength, const(ushort)* src, int srcLength, 
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

@DllImport("KERNEL32")
int FindStringOrdinal(uint dwFindStringOrdinalFlags, const(wchar)* lpStringSource, int cchSource, 
                      const(wchar)* lpStringValue, int cchValue, BOOL bIgnoreCase);

@DllImport("ADVAPI32")
BOOL IsTextUnicode(char* lpv, int iSize, int* lpiResult);


// Interfaces

@GUID("7AB36653-1796-484B-BDFA-E74F1DB7C1DC")
struct SpellCheckerFactory;

@GUID("B7C82D61-FBE8-4B47-9B27-6C0D2E0DE0A3")
interface ISpellingError : IUnknown
{
    HRESULT get_StartIndex(uint* value);
    HRESULT get_Length(uint* value);
    HRESULT get_CorrectiveAction(CORRECTIVE_ACTION* value);
    HRESULT get_Replacement(ushort** value);
}

@GUID("803E3BD4-2828-4410-8290-418D1D73C762")
interface IEnumSpellingError : IUnknown
{
    HRESULT Next(ISpellingError* value);
}

@GUID("432E5F85-35CF-4606-A801-6F70277E1D7A")
interface IOptionDescription : IUnknown
{
    HRESULT get_Id(ushort** value);
    HRESULT get_Heading(ushort** value);
    HRESULT get_Description(ushort** value);
    HRESULT get_Labels(IEnumString* value);
}

@GUID("0B83A5B0-792F-4EAB-9799-ACF52C5ED08A")
interface ISpellCheckerChangedEventHandler : IUnknown
{
    HRESULT Invoke(ISpellChecker sender);
}

@GUID("B6FD0B71-E2BC-4653-8D05-F197E412770B")
interface ISpellChecker : IUnknown
{
    HRESULT get_LanguageTag(ushort** value);
    HRESULT Check(const(wchar)* text, IEnumSpellingError* value);
    HRESULT Suggest(const(wchar)* word, IEnumString* value);
    HRESULT Add(const(wchar)* word);
    HRESULT Ignore(const(wchar)* word);
    HRESULT AutoCorrect(const(wchar)* from, const(wchar)* to);
    HRESULT GetOptionValue(const(wchar)* optionId, ubyte* value);
    HRESULT get_OptionIds(IEnumString* value);
    HRESULT get_Id(ushort** value);
    HRESULT get_LocalizedName(ushort** value);
    HRESULT add_SpellCheckerChanged(ISpellCheckerChangedEventHandler handler, uint* eventCookie);
    HRESULT remove_SpellCheckerChanged(uint eventCookie);
    HRESULT GetOptionDescription(const(wchar)* optionId, IOptionDescription* value);
    HRESULT ComprehensiveCheck(const(wchar)* text, IEnumSpellingError* value);
}

@GUID("E7ED1C71-87F7-4378-A840-C9200DACEE47")
interface ISpellChecker2 : ISpellChecker
{
    HRESULT Remove(const(wchar)* word);
}

@GUID("8E018A9D-2415-4677-BF08-794EA61F94BB")
interface ISpellCheckerFactory : IUnknown
{
    HRESULT get_SupportedLanguages(IEnumString* value);
    HRESULT IsSupported(const(wchar)* languageTag, int* value);
    HRESULT CreateSpellChecker(const(wchar)* languageTag, ISpellChecker* value);
}

@GUID("AA176B85-0E12-4844-8E1A-EEF1DA77F586")
interface IUserDictionariesRegistrar : IUnknown
{
    HRESULT RegisterUserDictionary(const(wchar)* dictionaryPath, const(wchar)* languageTag);
    HRESULT UnregisterUserDictionary(const(wchar)* dictionaryPath, const(wchar)* languageTag);
}

@GUID("73E976E0-8ED4-4EB1-80D7-1BE0A16B0C38")
interface ISpellCheckProvider : IUnknown
{
    HRESULT get_LanguageTag(ushort** value);
    HRESULT Check(const(wchar)* text, IEnumSpellingError* value);
    HRESULT Suggest(const(wchar)* word, IEnumString* value);
    HRESULT GetOptionValue(const(wchar)* optionId, ubyte* value);
    HRESULT SetOptionValue(const(wchar)* optionId, ubyte value);
    HRESULT get_OptionIds(IEnumString* value);
    HRESULT get_Id(ushort** value);
    HRESULT get_LocalizedName(ushort** value);
    HRESULT GetOptionDescription(const(wchar)* optionId, IOptionDescription* value);
    HRESULT InitializeWordlist(WORDLIST_TYPE wordlistType, IEnumString words);
}

@GUID("0C58F8DE-8E94-479E-9717-70C42C4AD2C3")
interface IComprehensiveSpellCheckProvider : IUnknown
{
    HRESULT ComprehensiveCheck(const(wchar)* text, IEnumSpellingError* value);
}

@GUID("9F671E11-77D6-4C92-AEFB-615215E3A4BE")
interface ISpellCheckProviderFactory : IUnknown
{
    HRESULT get_SupportedLanguages(IEnumString* value);
    HRESULT IsSupported(const(wchar)* languageTag, int* value);
    HRESULT CreateSpellCheckProvider(const(wchar)* languageTag, ISpellCheckProvider* value);
}

interface IFEClassFactory : IClassFactory
{
}

interface IFECommon : IUnknown
{
    HRESULT IsDefaultIME(char* szName, int cszName);
    HRESULT SetDefaultIME();
    HRESULT InvokeWordRegDialog(IMEDLG* pimedlg);
    HRESULT InvokeDictToolDialog(IMEDLG* pimedlg);
}

interface IFELanguage : IUnknown
{
    HRESULT Open();
    HRESULT Close();
    HRESULT GetJMorphResult(uint dwRequest, uint dwCMode, int cwchInput, const(wchar)* pwchInput, uint* pfCInfo, 
                            MORRSLT** ppResult);
    HRESULT GetConversionModeCaps(uint* pdwCaps);
    HRESULT GetPhonetic(BSTR string, int start, int length, BSTR* phonetic);
    HRESULT GetConversion(BSTR string, int start, int length, BSTR* result);
}

interface IFEDictionary : IUnknown
{
    HRESULT Open(char* pchDictPath, IMESHF* pshf);
    HRESULT Close();
    HRESULT GetHeader(char* pchDictPath, IMESHF* pshf, IMEFMT* pjfmt, uint* pulType);
    HRESULT DisplayProperty(HWND hwnd);
    HRESULT GetPosTable(POSTBL** prgPosTbl, int* pcPosTbl);
    HRESULT GetWords(const(wchar)* pwchFirst, const(wchar)* pwchLast, const(wchar)* pwchDisplay, uint ulPos, 
                     uint ulSelect, uint ulWordSrc, ubyte* pchBuffer, uint cbBuffer, uint* pcWrd);
    HRESULT NextWords(ubyte* pchBuffer, uint cbBuffer, uint* pcWrd);
    HRESULT Create(const(byte)* pchDictPath, IMESHF* pshf);
    HRESULT SetHeader(IMESHF* pshf);
    HRESULT ExistWord(IMEWRD* pwrd);
    HRESULT ExistDependency(IMEDP* pdp);
    HRESULT RegisterWord(IMEREG reg, IMEWRD* pwrd);
    HRESULT RegisterDependency(IMEREG reg, IMEDP* pdp);
    HRESULT GetDependencies(const(wchar)* pwchKakariReading, const(wchar)* pwchKakariDisplay, uint ulKakariPos, 
                            const(wchar)* pwchUkeReading, const(wchar)* pwchUkeDisplay, uint ulUkePos, IMEREL jrel, 
                            uint ulWordSrc, ubyte* pchBuffer, uint cbBuffer, uint* pcdp);
    HRESULT NextDependencies(ubyte* pchBuffer, uint cbBuffer, uint* pcDp);
    HRESULT ConvertFromOldMSIME(const(byte)* pchDic, PFNLOG pfnLog, IMEREG reg);
    HRESULT ConvertFromUserToSys();
}

interface IImeSpecifyApplets : IUnknown
{
    HRESULT GetAppletIIDList(const(GUID)* refiid, APPLETIDLIST* lpIIDList);
}

interface IImePadApplet : IUnknown
{
    HRESULT Initialize(IUnknown lpIImePad);
    HRESULT Terminate();
    HRESULT GetAppletConfig(IMEAPPLETCFG* lpAppletCfg);
    HRESULT CreateUI(HWND hwndParent, IMEAPPLETUI* lpImeAppletUI);
    HRESULT Notify(IUnknown lpImePad, int notify, WPARAM wParam, LPARAM lParam);
}

interface IImePad : IUnknown
{
    HRESULT Request(IImePadApplet pIImePadApplet, int reqId, WPARAM wParam, LPARAM lParam);
}

@GUID("98752974-B0A6-489B-8F6F-BFF3769C8EEB")
interface IImePlugInDictDictionaryList : IUnknown
{
    HRESULT GetDictionariesInUse(SAFEARRAY** prgDictionaryGUID, SAFEARRAY** prgDateCreated, 
                                 SAFEARRAY** prgfEncrypted);
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
