// Written in the D programming language.

module windows.win32.media.speech;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, FILETIME, HANDLE, HMODULE,
                                         HRESULT, HWND, LPARAM, LRESULT, PWSTR,
                                         VARIANT_BOOL, WPARAM;
public import windows.win32.media.audio : WAVEFORMATEX;
public import windows.win32.system.com : IDispatch, IServiceProvider, IStream, IUnknown;
public import windows.win32.system.com.urlmon : IInternetSecurityManager;
public import windows.win32.system.registry : HKEY;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums


alias SPDATAKEYLOCATION = int;
enum : int
{
    SPDKL_DefaultLocation = 0x00000000,
    SPDKL_CurrentUser     = 0x00000001,
    SPDKL_LocalMachine    = 0x00000002,
    SPDKL_CurrentConfig   = 0x00000005,
}

alias SPSTREAMFORMAT = int;
enum : int
{
    SPSF_Default                 = 0xffffffff,
    SPSF_NoAssignedFormat        = 0x00000000,
    SPSF_Text                    = 0x00000001,
    SPSF_NonStandardFormat       = 0x00000002,
    SPSF_ExtendedAudioFormat     = 0x00000003,
    SPSF_8kHz8BitMono            = 0x00000004,
    SPSF_8kHz8BitStereo          = 0x00000005,
    SPSF_8kHz16BitMono           = 0x00000006,
    SPSF_8kHz16BitStereo         = 0x00000007,
    SPSF_11kHz8BitMono           = 0x00000008,
    SPSF_11kHz8BitStereo         = 0x00000009,
    SPSF_11kHz16BitMono          = 0x0000000a,
    SPSF_11kHz16BitStereo        = 0x0000000b,
    SPSF_12kHz8BitMono           = 0x0000000c,
    SPSF_12kHz8BitStereo         = 0x0000000d,
    SPSF_12kHz16BitMono          = 0x0000000e,
    SPSF_12kHz16BitStereo        = 0x0000000f,
    SPSF_16kHz8BitMono           = 0x00000010,
    SPSF_16kHz8BitStereo         = 0x00000011,
    SPSF_16kHz16BitMono          = 0x00000012,
    SPSF_16kHz16BitStereo        = 0x00000013,
    SPSF_22kHz8BitMono           = 0x00000014,
    SPSF_22kHz8BitStereo         = 0x00000015,
    SPSF_22kHz16BitMono          = 0x00000016,
    SPSF_22kHz16BitStereo        = 0x00000017,
    SPSF_24kHz8BitMono           = 0x00000018,
    SPSF_24kHz8BitStereo         = 0x00000019,
    SPSF_24kHz16BitMono          = 0x0000001a,
    SPSF_24kHz16BitStereo        = 0x0000001b,
    SPSF_32kHz8BitMono           = 0x0000001c,
    SPSF_32kHz8BitStereo         = 0x0000001d,
    SPSF_32kHz16BitMono          = 0x0000001e,
    SPSF_32kHz16BitStereo        = 0x0000001f,
    SPSF_44kHz8BitMono           = 0x00000020,
    SPSF_44kHz8BitStereo         = 0x00000021,
    SPSF_44kHz16BitMono          = 0x00000022,
    SPSF_44kHz16BitStereo        = 0x00000023,
    SPSF_48kHz8BitMono           = 0x00000024,
    SPSF_48kHz8BitStereo         = 0x00000025,
    SPSF_48kHz16BitMono          = 0x00000026,
    SPSF_48kHz16BitStereo        = 0x00000027,
    SPSF_TrueSpeech_8kHz1BitMono = 0x00000028,
    SPSF_CCITT_ALaw_8kHzMono     = 0x00000029,
    SPSF_CCITT_ALaw_8kHzStereo   = 0x0000002a,
    SPSF_CCITT_ALaw_11kHzMono    = 0x0000002b,
    SPSF_CCITT_ALaw_11kHzStereo  = 0x0000002c,
    SPSF_CCITT_ALaw_22kHzMono    = 0x0000002d,
    SPSF_CCITT_ALaw_22kHzStereo  = 0x0000002e,
    SPSF_CCITT_ALaw_44kHzMono    = 0x0000002f,
    SPSF_CCITT_ALaw_44kHzStereo  = 0x00000030,
    SPSF_CCITT_uLaw_8kHzMono     = 0x00000031,
    SPSF_CCITT_uLaw_8kHzStereo   = 0x00000032,
    SPSF_CCITT_uLaw_11kHzMono    = 0x00000033,
    SPSF_CCITT_uLaw_11kHzStereo  = 0x00000034,
    SPSF_CCITT_uLaw_22kHzMono    = 0x00000035,
    SPSF_CCITT_uLaw_22kHzStereo  = 0x00000036,
    SPSF_CCITT_uLaw_44kHzMono    = 0x00000037,
    SPSF_CCITT_uLaw_44kHzStereo  = 0x00000038,
    SPSF_ADPCM_8kHzMono          = 0x00000039,
    SPSF_ADPCM_8kHzStereo        = 0x0000003a,
    SPSF_ADPCM_11kHzMono         = 0x0000003b,
    SPSF_ADPCM_11kHzStereo       = 0x0000003c,
    SPSF_ADPCM_22kHzMono         = 0x0000003d,
    SPSF_ADPCM_22kHzStereo       = 0x0000003e,
    SPSF_ADPCM_44kHzMono         = 0x0000003f,
    SPSF_ADPCM_44kHzStereo       = 0x00000040,
    SPSF_GSM610_8kHzMono         = 0x00000041,
    SPSF_GSM610_11kHzMono        = 0x00000042,
    SPSF_GSM610_22kHzMono        = 0x00000043,
    SPSF_GSM610_44kHzMono        = 0x00000044,
    SPSF_NUM_FORMATS             = 0x00000045,
}

alias SPEVENTLPARAMTYPE = int;
enum : int
{
    SPET_LPARAM_IS_UNDEFINED = 0x00000000,
    SPET_LPARAM_IS_TOKEN     = 0x00000001,
    SPET_LPARAM_IS_OBJECT    = 0x00000002,
    SPET_LPARAM_IS_POINTER   = 0x00000003,
    SPET_LPARAM_IS_STRING    = 0x00000004,
}

alias SPEVENTENUM = int;
enum : int
{
    SPEI_UNDEFINED              = 0x00000000,
    SPEI_START_INPUT_STREAM     = 0x00000001,
    SPEI_END_INPUT_STREAM       = 0x00000002,
    SPEI_VOICE_CHANGE           = 0x00000003,
    SPEI_TTS_BOOKMARK           = 0x00000004,
    SPEI_WORD_BOUNDARY          = 0x00000005,
    SPEI_PHONEME                = 0x00000006,
    SPEI_SENTENCE_BOUNDARY      = 0x00000007,
    SPEI_VISEME                 = 0x00000008,
    SPEI_TTS_AUDIO_LEVEL        = 0x00000009,
    SPEI_TTS_PRIVATE            = 0x0000000f,
    SPEI_MIN_TTS                = 0x00000001,
    SPEI_MAX_TTS                = 0x0000000f,
    SPEI_END_SR_STREAM          = 0x00000022,
    SPEI_SOUND_START            = 0x00000023,
    SPEI_SOUND_END              = 0x00000024,
    SPEI_PHRASE_START           = 0x00000025,
    SPEI_RECOGNITION            = 0x00000026,
    SPEI_HYPOTHESIS             = 0x00000027,
    SPEI_SR_BOOKMARK            = 0x00000028,
    SPEI_PROPERTY_NUM_CHANGE    = 0x00000029,
    SPEI_PROPERTY_STRING_CHANGE = 0x0000002a,
    SPEI_FALSE_RECOGNITION      = 0x0000002b,
    SPEI_INTERFERENCE           = 0x0000002c,
    SPEI_REQUEST_UI             = 0x0000002d,
    SPEI_RECO_STATE_CHANGE      = 0x0000002e,
    SPEI_ADAPTATION             = 0x0000002f,
    SPEI_START_SR_STREAM        = 0x00000030,
    SPEI_RECO_OTHER_CONTEXT     = 0x00000031,
    SPEI_SR_AUDIO_LEVEL         = 0x00000032,
    SPEI_SR_RETAINEDAUDIO       = 0x00000033,
    SPEI_SR_PRIVATE             = 0x00000034,
    SPEI_RESERVED4              = 0x00000035,
    SPEI_RESERVED5              = 0x00000036,
    SPEI_RESERVED6              = 0x00000037,
    SPEI_MIN_SR                 = 0x00000022,
    SPEI_MAX_SR                 = 0x00000037,
    SPEI_RESERVED1              = 0x0000001e,
    SPEI_RESERVED2              = 0x00000021,
    SPEI_RESERVED3              = 0x0000003f,
}

alias SPINTERFERENCE = int;
enum : int
{
    SPINTERFERENCE_NONE                   = 0x00000000,
    SPINTERFERENCE_NOISE                  = 0x00000001,
    SPINTERFERENCE_NOSIGNAL               = 0x00000002,
    SPINTERFERENCE_TOOLOUD                = 0x00000003,
    SPINTERFERENCE_TOOQUIET               = 0x00000004,
    SPINTERFERENCE_TOOFAST                = 0x00000005,
    SPINTERFERENCE_TOOSLOW                = 0x00000006,
    SPINTERFERENCE_LATENCY_WARNING        = 0x00000007,
    SPINTERFERENCE_LATENCY_TRUNCATE_BEGIN = 0x00000008,
    SPINTERFERENCE_LATENCY_TRUNCATE_END   = 0x00000009,
}

alias SPENDSRSTREAMFLAGS = int;
enum : int
{
    SPESF_NONE            = 0x00000000,
    SPESF_STREAM_RELEASED = 0x00000001,
    SPESF_EMULATED        = 0x00000002,
}

alias SPVFEATURE = int;
enum : int
{
    SPVFEATURE_STRESSED = 0x00000001,
    SPVFEATURE_EMPHASIS = 0x00000002,
}

alias SPVISEMES = int;
enum : int
{
    SP_VISEME_0  = 0x00000000,
    SP_VISEME_1  = 0x00000001,
    SP_VISEME_2  = 0x00000002,
    SP_VISEME_3  = 0x00000003,
    SP_VISEME_4  = 0x00000004,
    SP_VISEME_5  = 0x00000005,
    SP_VISEME_6  = 0x00000006,
    SP_VISEME_7  = 0x00000007,
    SP_VISEME_8  = 0x00000008,
    SP_VISEME_9  = 0x00000009,
    SP_VISEME_10 = 0x0000000a,
    SP_VISEME_11 = 0x0000000b,
    SP_VISEME_12 = 0x0000000c,
    SP_VISEME_13 = 0x0000000d,
    SP_VISEME_14 = 0x0000000e,
    SP_VISEME_15 = 0x0000000f,
    SP_VISEME_16 = 0x00000010,
    SP_VISEME_17 = 0x00000011,
    SP_VISEME_18 = 0x00000012,
    SP_VISEME_19 = 0x00000013,
    SP_VISEME_20 = 0x00000014,
    SP_VISEME_21 = 0x00000015,
}

alias SPFILEMODE = int;
enum : int
{
    SPFM_OPEN_READONLY  = 0x00000000,
    SPFM_OPEN_READWRITE = 0x00000001,
    SPFM_CREATE         = 0x00000002,
    SPFM_CREATE_ALWAYS  = 0x00000003,
    SPFM_NUM_MODES      = 0x00000004,
}

alias SPAUDIOSTATE = int;
enum : int
{
    SPAS_CLOSED = 0x00000000,
    SPAS_STOP   = 0x00000001,
    SPAS_PAUSE  = 0x00000002,
    SPAS_RUN    = 0x00000003,
}

alias SPDISPLAYATTRIBUTES = int;
enum : int
{
    SPAF_ONE_TRAILING_SPACE     = 0x00000002,
    SPAF_TWO_TRAILING_SPACES    = 0x00000004,
    SPAF_CONSUME_LEADING_SPACES = 0x00000008,
    SPAF_BUFFER_POSITION        = 0x00000010,
    SPAF_ALL                    = 0x0000001f,
    SPAF_USER_SPECIFIED         = 0x00000080,
}

alias SPPHRASEPROPERTYUNIONTYPE = int;
enum : int
{
    SPPPUT_UNUSED      = 0x00000000,
    SPPPUT_ARRAY_INDEX = 0x00000001,
}

alias SPSEMANTICFORMAT = int;
enum : int
{
    SPSMF_SAPI_PROPERTIES                 = 0x00000000,
    SPSMF_SRGS_SEMANTICINTERPRETATION_MS  = 0x00000001,
    SPSMF_SRGS_SAPIPROPERTIES             = 0x00000002,
    SPSMF_UPS                             = 0x00000004,
    SPSMF_SRGS_SEMANTICINTERPRETATION_W3C = 0x00000008,
}

alias SPVALUETYPE = int;
enum : int
{
    SPDF_PROPERTY      = 0x00000001,
    SPDF_REPLACEMENT   = 0x00000002,
    SPDF_RULE          = 0x00000004,
    SPDF_DISPLAYTEXT   = 0x00000008,
    SPDF_LEXICALFORM   = 0x00000010,
    SPDF_PRONUNCIATION = 0x00000020,
    SPDF_AUDIO         = 0x00000040,
    SPDF_ALTERNATES    = 0x00000080,
    SPDF_ALL           = 0x000000ff,
}

alias SPPHRASERNG = int;
enum : int
{
    SPPR_ALL_ELEMENTS = 0xffffffff,
}

alias SPRECOEVENTFLAGS = int;
enum : int
{
    SPREF_AutoPause        = 0x00000001,
    SPREF_Emulated         = 0x00000002,
    SPREF_SMLTimeout       = 0x00000004,
    SPREF_ExtendableParse  = 0x00000008,
    SPREF_ReSent           = 0x00000010,
    SPREF_Hypothesis       = 0x00000020,
    SPREF_FalseRecognition = 0x00000040,
}

alias SPPARTOFSPEECH = int;
enum : int
{
    SPPS_NotOverriden = 0xffffffff,
    SPPS_Unknown      = 0x00000000,
    SPPS_Noun         = 0x00001000,
    SPPS_Verb         = 0x00002000,
    SPPS_Modifier     = 0x00003000,
    SPPS_Function     = 0x00004000,
    SPPS_Interjection = 0x00005000,
    SPPS_Noncontent   = 0x00006000,
    SPPS_LMA          = 0x00007000,
    SPPS_SuppressWord = 0x0000f000,
}

alias SPLEXICONTYPE = int;
enum : int
{
    eLEXTYPE_USER          = 0x00000001,
    eLEXTYPE_APP           = 0x00000002,
    eLEXTYPE_VENDORLEXICON = 0x00000004,
    eLEXTYPE_LETTERTOSOUND = 0x00000008,
    eLEXTYPE_MORPHOLOGY    = 0x00000010,
    eLEXTYPE_RESERVED4     = 0x00000020,
    eLEXTYPE_USER_SHORTCUT = 0x00000040,
    eLEXTYPE_RESERVED6     = 0x00000080,
    eLEXTYPE_RESERVED7     = 0x00000100,
    eLEXTYPE_RESERVED8     = 0x00000200,
    eLEXTYPE_RESERVED9     = 0x00000400,
    eLEXTYPE_RESERVED10    = 0x00000800,
    eLEXTYPE_PRIVATE1      = 0x00001000,
    eLEXTYPE_PRIVATE2      = 0x00002000,
    eLEXTYPE_PRIVATE3      = 0x00004000,
    eLEXTYPE_PRIVATE4      = 0x00008000,
    eLEXTYPE_PRIVATE5      = 0x00010000,
    eLEXTYPE_PRIVATE6      = 0x00020000,
    eLEXTYPE_PRIVATE7      = 0x00040000,
    eLEXTYPE_PRIVATE8      = 0x00080000,
    eLEXTYPE_PRIVATE9      = 0x00100000,
    eLEXTYPE_PRIVATE10     = 0x00200000,
    eLEXTYPE_PRIVATE11     = 0x00400000,
    eLEXTYPE_PRIVATE12     = 0x00800000,
    eLEXTYPE_PRIVATE13     = 0x01000000,
    eLEXTYPE_PRIVATE14     = 0x02000000,
    eLEXTYPE_PRIVATE15     = 0x04000000,
    eLEXTYPE_PRIVATE16     = 0x08000000,
    eLEXTYPE_PRIVATE17     = 0x10000000,
    eLEXTYPE_PRIVATE18     = 0x20000000,
    eLEXTYPE_PRIVATE19     = 0x40000000,
    eLEXTYPE_PRIVATE20     = 0x80000000,
}

alias SPWORDTYPE = int;
enum : int
{
    eWORDTYPE_ADDED   = 0x00000001,
    eWORDTYPE_DELETED = 0x00000002,
}

alias SPPRONUNCIATIONFLAGS = int;
enum : int
{
    ePRONFLAG_USED = 0x00000001,
}

alias SPSHORTCUTTYPE = int;
enum : int
{
    SPSHT_NotOverriden = 0xffffffff,
    SPSHT_Unknown      = 0x00000000,
    SPSHT_EMAIL        = 0x00001000,
    SPSHT_OTHER        = 0x00002000,
    SPPS_RESERVED1     = 0x00003000,
    SPPS_RESERVED2     = 0x00004000,
    SPPS_RESERVED3     = 0x00005000,
    SPPS_RESERVED4     = 0x0000f000,
}

alias SPVACTIONS = int;
enum : int
{
    SPVA_Speak           = 0x00000000,
    SPVA_Silence         = 0x00000001,
    SPVA_Pronounce       = 0x00000002,
    SPVA_Bookmark        = 0x00000003,
    SPVA_SpellOut        = 0x00000004,
    SPVA_Section         = 0x00000005,
    SPVA_ParseUnknownTag = 0x00000006,
}

alias SPRUNSTATE = int;
enum : int
{
    SPRS_DONE        = 0x00000001,
    SPRS_IS_SPEAKING = 0x00000002,
}

alias SPVLIMITS = int;
enum : int
{
    SPMIN_VOLUME = 0x00000000,
    SPMAX_VOLUME = 0x00000064,
    SPMIN_RATE   = 0xfffffff6,
    SPMAX_RATE   = 0x0000000a,
}

alias SPVPRIORITY = int;
enum : int
{
    SPVPRI_NORMAL = 0x00000000,
    SPVPRI_ALERT  = 0x00000001,
    SPVPRI_OVER   = 0x00000002,
}

alias SPEAKFLAGS = int;
enum : int
{
    SPF_DEFAULT          = 0x00000000,
    SPF_ASYNC            = 0x00000001,
    SPF_PURGEBEFORESPEAK = 0x00000002,
    SPF_IS_FILENAME      = 0x00000004,
    SPF_IS_XML           = 0x00000008,
    SPF_IS_NOT_XML       = 0x00000010,
    SPF_PERSIST_XML      = 0x00000020,
    SPF_NLP_SPEAK_PUNC   = 0x00000040,
    SPF_PARSE_SAPI       = 0x00000080,
    SPF_PARSE_SSML       = 0x00000100,
    SPF_PARSE_AUTODETECT = 0x00000000,
    SPF_NLP_MASK         = 0x00000040,
    SPF_PARSE_MASK       = 0x00000180,
    SPF_VOICE_MASK       = 0x000001ff,
    SPF_UNUSED_FLAGS     = 0xfffffe00,
}

alias SPXMLRESULTOPTIONS = int;
enum : int
{
    SPXRO_SML            = 0x00000000,
    SPXRO_Alternates_SML = 0x00000001,
}

alias SPCOMMITFLAGS = int;
enum : int
{
    SPCF_NONE                = 0x00000000,
    SPCF_ADD_TO_USER_LEXICON = 0x00000001,
    SPCF_DEFINITE_CORRECTION = 0x00000002,
}

alias SPWORDPRONOUNCEABLE = int;
enum : int
{
    SPWP_UNKNOWN_WORD_UNPRONOUNCEABLE = 0x00000000,
    SPWP_UNKNOWN_WORD_PRONOUNCEABLE   = 0x00000001,
    SPWP_KNOWN_WORD_PRONOUNCEABLE     = 0x00000002,
}

alias SPGRAMMARSTATE = int;
enum : int
{
    SPGS_DISABLED  = 0x00000000,
    SPGS_ENABLED   = 0x00000001,
    SPGS_EXCLUSIVE = 0x00000003,
}

alias SPCONTEXTSTATE = int;
enum : int
{
    SPCS_DISABLED = 0x00000000,
    SPCS_ENABLED  = 0x00000001,
}

alias SPRULESTATE = int;
enum : int
{
    SPRS_INACTIVE               = 0x00000000,
    SPRS_ACTIVE                 = 0x00000001,
    SPRS_ACTIVE_WITH_AUTO_PAUSE = 0x00000003,
    SPRS_ACTIVE_USER_DELIMITED  = 0x00000004,
}

alias SPGRAMMARWORDTYPE = int;
enum : int
{
    SPWT_DISPLAY                  = 0x00000000,
    SPWT_LEXICAL                  = 0x00000001,
    SPWT_PRONUNCIATION            = 0x00000002,
    SPWT_LEXICAL_NO_SPECIAL_CHARS = 0x00000003,
}

alias SPCFGRULEATTRIBUTES = int;
enum : int
{
    SPRAF_TopLevel      = 0x00000001,
    SPRAF_Active        = 0x00000002,
    SPRAF_Export        = 0x00000004,
    SPRAF_Import        = 0x00000008,
    SPRAF_Interpreter   = 0x00000010,
    SPRAF_Dynamic       = 0x00000020,
    SPRAF_Root          = 0x00000040,
    SPRAF_AutoPause     = 0x00010000,
    SPRAF_UserDelimited = 0x00020000,
}

alias SPLOADOPTIONS = int;
enum : int
{
    SPLO_STATIC  = 0x00000000,
    SPLO_DYNAMIC = 0x00000001,
}

alias SPMATCHINGMODE = int;
enum : int
{
    AllWords                     = 0x00000000,
    Subsequence                  = 0x00000001,
    OrderedSubset                = 0x00000003,
    SubsequenceContentRequired   = 0x00000005,
    OrderedSubsetContentRequired = 0x00000007,
}

alias PHONETICALPHABET = int;
enum : int
{
    PA_Ipa  = 0x00000000,
    PA_Ups  = 0x00000001,
    PA_Sapi = 0x00000002,
}

alias SPBOOKMARKOPTIONS = int;
enum : int
{
    SPBO_NONE       = 0x00000000,
    SPBO_PAUSE      = 0x00000001,
    SPBO_AHEAD      = 0x00000002,
    SPBO_TIME_UNITS = 0x00000004,
}

alias SPAUDIOOPTIONS = int;
enum : int
{
    SPAO_NONE         = 0x00000000,
    SPAO_RETAIN_AUDIO = 0x00000001,
}

alias SPGRAMMAROPTIONS = int;
enum : int
{
    SPGO_SAPI            = 0x00000001,
    SPGO_SRGS            = 0x00000002,
    SPGO_UPS             = 0x00000004,
    SPGO_SRGS_MS_SCRIPT  = 0x00000008,
    SPGO_SRGS_W3C_SCRIPT = 0x00000100,
    SPGO_SRGS_STG_SCRIPT = 0x00000200,
    SPGO_SRGS_SCRIPT     = 0x0000030a,
    SPGO_FILE            = 0x00000010,
    SPGO_HTTP            = 0x00000020,
    SPGO_RES             = 0x00000040,
    SPGO_OBJECT          = 0x00000080,
    SPGO_DEFAULT         = 0x000003fb,
    SPGO_ALL             = 0x000003ff,
}

alias SPADAPTATIONSETTINGS = int;
enum : int
{
    SPADS_Default              = 0x00000000,
    SPADS_CurrentRecognizer    = 0x00000001,
    SPADS_RecoProfile          = 0x00000002,
    SPADS_Immediate            = 0x00000004,
    SPADS_Reset                = 0x00000008,
    SPADS_HighVolumeDataSource = 0x00000010,
}

alias SPADAPTATIONRELEVANCE = int;
enum : int
{
    SPAR_Unknown = 0x00000000,
    SPAR_Low     = 0x00000001,
    SPAR_Medium  = 0x00000002,
    SPAR_High    = 0x00000003,
}

alias SPSTREAMFORMATTYPE = int;
enum : int
{
    SPWF_INPUT    = 0x00000000,
    SPWF_SRENGINE = 0x00000001,
}

alias SPRECOSTATE = int;
enum : int
{
    SPRST_INACTIVE            = 0x00000000,
    SPRST_ACTIVE              = 0x00000001,
    SPRST_ACTIVE_ALWAYS       = 0x00000002,
    SPRST_INACTIVE_WITH_PURGE = 0x00000003,
    SPRST_NUM_STATES          = 0x00000004,
}

alias DISPID_SpeechDataKey = int;
enum : int
{
    DISPID_SDKSetBinaryValue = 0x00000001,
    DISPID_SDKGetBinaryValue = 0x00000002,
    DISPID_SDKSetStringValue = 0x00000003,
    DISPID_SDKGetStringValue = 0x00000004,
    DISPID_SDKSetLongValue   = 0x00000005,
    DISPID_SDKGetlongValue   = 0x00000006,
    DISPID_SDKOpenKey        = 0x00000007,
    DISPID_SDKCreateKey      = 0x00000008,
    DISPID_SDKDeleteKey      = 0x00000009,
    DISPID_SDKDeleteValue    = 0x0000000a,
    DISPID_SDKEnumKeys       = 0x0000000b,
    DISPID_SDKEnumValues     = 0x0000000c,
}

alias DISPID_SpeechObjectToken = int;
enum : int
{
    DISPID_SOTId                    = 0x00000001,
    DISPID_SOTDataKey               = 0x00000002,
    DISPID_SOTCategory              = 0x00000003,
    DISPID_SOTGetDescription        = 0x00000004,
    DISPID_SOTSetId                 = 0x00000005,
    DISPID_SOTGetAttribute          = 0x00000006,
    DISPID_SOTCreateInstance        = 0x00000007,
    DISPID_SOTRemove                = 0x00000008,
    DISPID_SOTGetStorageFileName    = 0x00000009,
    DISPID_SOTRemoveStorageFileName = 0x0000000a,
    DISPID_SOTIsUISupported         = 0x0000000b,
    DISPID_SOTDisplayUI             = 0x0000000c,
    DISPID_SOTMatchesAttributes     = 0x0000000d,
}

enum SpeechDataKeyLocation : int
{
    SDKLDefaultLocation = 0x00000000,
    SDKLCurrentUser     = 0x00000001,
    SDKLLocalMachine    = 0x00000002,
    SDKLCurrentConfig   = 0x00000005,
}

enum SpeechTokenContext : uint
{
    STCInprocServer  = 0x00000001U,
    STCInprocHandler = 0x00000002U,
    STCLocalServer   = 0x00000004U,
    STCRemoteServer  = 0x00000010U,
    STCAll           = 0x00000017U,
}

enum SpeechTokenShellFolder : int
{
    STSF_AppData       = 0x0000001a,
    STSF_LocalAppData  = 0x0000001c,
    STSF_CommonAppData = 0x00000023,
    STSF_FlagCreate    = 0x00008000,
}

alias DISPID_SpeechObjectTokens = int;
enum : int
{
    DISPID_SOTsCount    = 0x00000001,
    DISPID_SOTsItem     = 0x00000000,
    DISPID_SOTs_NewEnum = 0xfffffffc,
}

alias DISPID_SpeechObjectTokenCategory = int;
enum : int
{
    DISPID_SOTCId              = 0x00000001,
    DISPID_SOTCDefault         = 0x00000002,
    DISPID_SOTCSetId           = 0x00000003,
    DISPID_SOTCGetDataKey      = 0x00000004,
    DISPID_SOTCEnumerateTokens = 0x00000005,
}

enum SpeechAudioFormatType : int
{
    SAFTDefault                 = 0xffffffff,
    SAFTNoAssignedFormat        = 0x00000000,
    SAFTText                    = 0x00000001,
    SAFTNonStandardFormat       = 0x00000002,
    SAFTExtendedAudioFormat     = 0x00000003,
    SAFT8kHz8BitMono            = 0x00000004,
    SAFT8kHz8BitStereo          = 0x00000005,
    SAFT8kHz16BitMono           = 0x00000006,
    SAFT8kHz16BitStereo         = 0x00000007,
    SAFT11kHz8BitMono           = 0x00000008,
    SAFT11kHz8BitStereo         = 0x00000009,
    SAFT11kHz16BitMono          = 0x0000000a,
    SAFT11kHz16BitStereo        = 0x0000000b,
    SAFT12kHz8BitMono           = 0x0000000c,
    SAFT12kHz8BitStereo         = 0x0000000d,
    SAFT12kHz16BitMono          = 0x0000000e,
    SAFT12kHz16BitStereo        = 0x0000000f,
    SAFT16kHz8BitMono           = 0x00000010,
    SAFT16kHz8BitStereo         = 0x00000011,
    SAFT16kHz16BitMono          = 0x00000012,
    SAFT16kHz16BitStereo        = 0x00000013,
    SAFT22kHz8BitMono           = 0x00000014,
    SAFT22kHz8BitStereo         = 0x00000015,
    SAFT22kHz16BitMono          = 0x00000016,
    SAFT22kHz16BitStereo        = 0x00000017,
    SAFT24kHz8BitMono           = 0x00000018,
    SAFT24kHz8BitStereo         = 0x00000019,
    SAFT24kHz16BitMono          = 0x0000001a,
    SAFT24kHz16BitStereo        = 0x0000001b,
    SAFT32kHz8BitMono           = 0x0000001c,
    SAFT32kHz8BitStereo         = 0x0000001d,
    SAFT32kHz16BitMono          = 0x0000001e,
    SAFT32kHz16BitStereo        = 0x0000001f,
    SAFT44kHz8BitMono           = 0x00000020,
    SAFT44kHz8BitStereo         = 0x00000021,
    SAFT44kHz16BitMono          = 0x00000022,
    SAFT44kHz16BitStereo        = 0x00000023,
    SAFT48kHz8BitMono           = 0x00000024,
    SAFT48kHz8BitStereo         = 0x00000025,
    SAFT48kHz16BitMono          = 0x00000026,
    SAFT48kHz16BitStereo        = 0x00000027,
    SAFTTrueSpeech_8kHz1BitMono = 0x00000028,
    SAFTCCITT_ALaw_8kHzMono     = 0x00000029,
    SAFTCCITT_ALaw_8kHzStereo   = 0x0000002a,
    SAFTCCITT_ALaw_11kHzMono    = 0x0000002b,
    SAFTCCITT_ALaw_11kHzStereo  = 0x0000002c,
    SAFTCCITT_ALaw_22kHzMono    = 0x0000002d,
    SAFTCCITT_ALaw_22kHzStereo  = 0x0000002e,
    SAFTCCITT_ALaw_44kHzMono    = 0x0000002f,
    SAFTCCITT_ALaw_44kHzStereo  = 0x00000030,
    SAFTCCITT_uLaw_8kHzMono     = 0x00000031,
    SAFTCCITT_uLaw_8kHzStereo   = 0x00000032,
    SAFTCCITT_uLaw_11kHzMono    = 0x00000033,
    SAFTCCITT_uLaw_11kHzStereo  = 0x00000034,
    SAFTCCITT_uLaw_22kHzMono    = 0x00000035,
    SAFTCCITT_uLaw_22kHzStereo  = 0x00000036,
    SAFTCCITT_uLaw_44kHzMono    = 0x00000037,
    SAFTCCITT_uLaw_44kHzStereo  = 0x00000038,
    SAFTADPCM_8kHzMono          = 0x00000039,
    SAFTADPCM_8kHzStereo        = 0x0000003a,
    SAFTADPCM_11kHzMono         = 0x0000003b,
    SAFTADPCM_11kHzStereo       = 0x0000003c,
    SAFTADPCM_22kHzMono         = 0x0000003d,
    SAFTADPCM_22kHzStereo       = 0x0000003e,
    SAFTADPCM_44kHzMono         = 0x0000003f,
    SAFTADPCM_44kHzStereo       = 0x00000040,
    SAFTGSM610_8kHzMono         = 0x00000041,
    SAFTGSM610_11kHzMono        = 0x00000042,
    SAFTGSM610_22kHzMono        = 0x00000043,
    SAFTGSM610_44kHzMono        = 0x00000044,
}

alias DISPID_SpeechAudioFormat = int;
enum : int
{
    DISPID_SAFType            = 0x00000001,
    DISPID_SAFGuid            = 0x00000002,
    DISPID_SAFGetWaveFormatEx = 0x00000003,
    DISPID_SAFSetWaveFormatEx = 0x00000004,
}

alias DISPID_SpeechBaseStream = int;
enum : int
{
    DISPID_SBSFormat = 0x00000001,
    DISPID_SBSRead   = 0x00000002,
    DISPID_SBSWrite  = 0x00000003,
    DISPID_SBSSeek   = 0x00000004,
}

enum SpeechStreamSeekPositionType : uint
{
    SSSPTRelativeToStart           = 0x00000000U,
    SSSPTRelativeToCurrentPosition = 0x00000001U,
    SSSPTRelativeToEnd             = 0x00000002U,
}

alias DISPID_SpeechAudio = int;
enum : int
{
    DISPID_SAStatus           = 0x000000c8,
    DISPID_SABufferInfo       = 0x000000c9,
    DISPID_SADefaultFormat    = 0x000000ca,
    DISPID_SAVolume           = 0x000000cb,
    DISPID_SABufferNotifySize = 0x000000cc,
    DISPID_SAEventHandle      = 0x000000cd,
    DISPID_SASetState         = 0x000000ce,
}

enum SpeechAudioState : int
{
    SASClosed = 0x00000000,
    SASStop   = 0x00000001,
    SASPause  = 0x00000002,
    SASRun    = 0x00000003,
}

alias DISPID_SpeechMMSysAudio = int;
enum : int
{
    DISPID_SMSADeviceId = 0x0000012c,
    DISPID_SMSALineId   = 0x0000012d,
    DISPID_SMSAMMHandle = 0x0000012e,
}

alias DISPID_SpeechFileStream = int;
enum : int
{
    DISPID_SFSOpen  = 0x00000064,
    DISPID_SFSClose = 0x00000065,
}

enum SpeechStreamFileMode : int
{
    SSFMOpenForRead    = 0x00000000,
    SSFMOpenReadWrite  = 0x00000001,
    SSFMCreate         = 0x00000002,
    SSFMCreateForWrite = 0x00000003,
}

alias DISPID_SpeechCustomStream = int;
enum : int
{
    DISPID_SCSBaseStream = 0x00000064,
}

alias DISPID_SpeechMemoryStream = int;
enum : int
{
    DISPID_SMSSetData = 0x00000064,
    DISPID_SMSGetData = 0x00000065,
}

alias DISPID_SpeechAudioStatus = int;
enum : int
{
    DISPID_SASFreeBufferSpace       = 0x00000001,
    DISPID_SASNonBlockingIO         = 0x00000002,
    DISPID_SASState                 = 0x00000003,
    DISPID_SASCurrentSeekPosition   = 0x00000004,
    DISPID_SASCurrentDevicePosition = 0x00000005,
}

alias DISPID_SpeechAudioBufferInfo = int;
enum : int
{
    DISPID_SABIMinNotification = 0x00000001,
    DISPID_SABIBufferSize      = 0x00000002,
    DISPID_SABIEventBias       = 0x00000003,
}

alias DISPID_SpeechWaveFormatEx = int;
enum : int
{
    DISPID_SWFEFormatTag      = 0x00000001,
    DISPID_SWFEChannels       = 0x00000002,
    DISPID_SWFESamplesPerSec  = 0x00000003,
    DISPID_SWFEAvgBytesPerSec = 0x00000004,
    DISPID_SWFEBlockAlign     = 0x00000005,
    DISPID_SWFEBitsPerSample  = 0x00000006,
    DISPID_SWFEExtraData      = 0x00000007,
}

alias DISPID_SpeechVoice = int;
enum : int
{
    DISPID_SVStatus                                = 0x00000001,
    DISPID_SVVoice                                 = 0x00000002,
    DISPID_SVAudioOutput                           = 0x00000003,
    DISPID_SVAudioOutputStream                     = 0x00000004,
    DISPID_SVRate                                  = 0x00000005,
    DISPID_SVVolume                                = 0x00000006,
    DISPID_SVAllowAudioOuputFormatChangesOnNextSet = 0x00000007,
    DISPID_SVEventInterests                        = 0x00000008,
    DISPID_SVPriority                              = 0x00000009,
    DISPID_SVAlertBoundary                         = 0x0000000a,
    DISPID_SVSyncronousSpeakTimeout                = 0x0000000b,
    DISPID_SVSpeak                                 = 0x0000000c,
    DISPID_SVSpeakStream                           = 0x0000000d,
    DISPID_SVPause                                 = 0x0000000e,
    DISPID_SVResume                                = 0x0000000f,
    DISPID_SVSkip                                  = 0x00000010,
    DISPID_SVGetVoices                             = 0x00000011,
    DISPID_SVGetAudioOutputs                       = 0x00000012,
    DISPID_SVWaitUntilDone                         = 0x00000013,
    DISPID_SVSpeakCompleteEvent                    = 0x00000014,
    DISPID_SVIsUISupported                         = 0x00000015,
    DISPID_SVDisplayUI                             = 0x00000016,
}

enum SpeechVoicePriority : int
{
    SVPNormal = 0x00000000,
    SVPAlert  = 0x00000001,
    SVPOver   = 0x00000002,
}

enum SpeechVoiceSpeakFlags : int
{
    SVSFDefault          = 0x00000000,
    SVSFlagsAsync        = 0x00000001,
    SVSFPurgeBeforeSpeak = 0x00000002,
    SVSFIsFilename       = 0x00000004,
    SVSFIsXML            = 0x00000008,
    SVSFIsNotXML         = 0x00000010,
    SVSFPersistXML       = 0x00000020,
    SVSFNLPSpeakPunc     = 0x00000040,
    SVSFParseSapi        = 0x00000080,
    SVSFParseSsml        = 0x00000100,
    SVSFParseAutodetect  = 0x00000000,
    SVSFNLPMask          = 0x00000040,
    SVSFParseMask        = 0x00000180,
    SVSFVoiceMask        = 0x000001ff,
    SVSFUnusedFlags      = 0xfffffe00,
}

enum SpeechVoiceEvents : int
{
    SVEStartInputStream = 0x00000002,
    SVEEndInputStream   = 0x00000004,
    SVEVoiceChange      = 0x00000008,
    SVEBookmark         = 0x00000010,
    SVEWordBoundary     = 0x00000020,
    SVEPhoneme          = 0x00000040,
    SVESentenceBoundary = 0x00000080,
    SVEViseme           = 0x00000100,
    SVEAudioLevel       = 0x00000200,
    SVEPrivate          = 0x00008000,
    SVEAllEvents        = 0x000083fe,
}

alias DISPID_SpeechVoiceStatus = int;
enum : int
{
    DISPID_SVSCurrentStreamNumber    = 0x00000001,
    DISPID_SVSLastStreamNumberQueued = 0x00000002,
    DISPID_SVSLastResult             = 0x00000003,
    DISPID_SVSRunningState           = 0x00000004,
    DISPID_SVSInputWordPosition      = 0x00000005,
    DISPID_SVSInputWordLength        = 0x00000006,
    DISPID_SVSInputSentencePosition  = 0x00000007,
    DISPID_SVSInputSentenceLength    = 0x00000008,
    DISPID_SVSLastBookmark           = 0x00000009,
    DISPID_SVSLastBookmarkId         = 0x0000000a,
    DISPID_SVSPhonemeId              = 0x0000000b,
    DISPID_SVSVisemeId               = 0x0000000c,
}

enum SpeechRunState : int
{
    SRSEDone       = 0x00000001,
    SRSEIsSpeaking = 0x00000002,
}

enum SpeechVisemeType : int
{
    SVP_0   = 0x00000000,
    SVP_1   = 0x00000001,
    SVP_2   = 0x00000002,
    SVP_3   = 0x00000003,
    SVP_4   = 0x00000004,
    SVP_5   = 0x00000005,
    SVP_6   = 0x00000006,
    SVP_7   = 0x00000007,
    SVP_8   = 0x00000008,
    SVP_9   = 0x00000009,
    SVP_10  = 0x0000000a,
    SVP_11  = 0x0000000b,
    SVP_12  = 0x0000000c,
    SVP_13  = 0x0000000d,
    SVP_14  = 0x0000000e,
    SVP_15  = 0x0000000f,
    SVP_16  = 0x00000010,
    SVP_17  = 0x00000011,
    SVP_18  = 0x00000012,
    SVP_19  = 0x00000013,
    SVP_20  = 0x00000014,
    SVP_21  = 0x00000015,
}

enum SpeechVisemeFeature : int
{
    SVF_None     = 0x00000000,
    SVF_Stressed = 0x00000001,
    SVF_Emphasis = 0x00000002,
}

alias DISPID_SpeechVoiceEvent = int;
enum : int
{
    DISPID_SVEStreamStart      = 0x00000001,
    DISPID_SVEStreamEnd        = 0x00000002,
    DISPID_SVEVoiceChange      = 0x00000003,
    DISPID_SVEBookmark         = 0x00000004,
    DISPID_SVEWord             = 0x00000005,
    DISPID_SVEPhoneme          = 0x00000006,
    DISPID_SVESentenceBoundary = 0x00000007,
    DISPID_SVEViseme           = 0x00000008,
    DISPID_SVEAudioLevel       = 0x00000009,
    DISPID_SVEEnginePrivate    = 0x0000000a,
}

alias DISPID_SpeechRecognizer = int;
enum : int
{
    DISPID_SRRecognizer                            = 0x00000001,
    DISPID_SRAllowAudioInputFormatChangesOnNextSet = 0x00000002,
    DISPID_SRAudioInput                            = 0x00000003,
    DISPID_SRAudioInputStream                      = 0x00000004,
    DISPID_SRIsShared                              = 0x00000005,
    DISPID_SRState                                 = 0x00000006,
    DISPID_SRStatus                                = 0x00000007,
    DISPID_SRProfile                               = 0x00000008,
    DISPID_SREmulateRecognition                    = 0x00000009,
    DISPID_SRCreateRecoContext                     = 0x0000000a,
    DISPID_SRGetFormat                             = 0x0000000b,
    DISPID_SRSetPropertyNumber                     = 0x0000000c,
    DISPID_SRGetPropertyNumber                     = 0x0000000d,
    DISPID_SRSetPropertyString                     = 0x0000000e,
    DISPID_SRGetPropertyString                     = 0x0000000f,
    DISPID_SRIsUISupported                         = 0x00000010,
    DISPID_SRDisplayUI                             = 0x00000011,
    DISPID_SRGetRecognizers                        = 0x00000012,
    DISPID_SVGetAudioInputs                        = 0x00000013,
    DISPID_SVGetProfiles                           = 0x00000014,
}

enum SpeechRecognizerState : int
{
    SRSInactive          = 0x00000000,
    SRSActive            = 0x00000001,
    SRSActiveAlways      = 0x00000002,
    SRSInactiveWithPurge = 0x00000003,
}

enum SpeechDisplayAttributes : int
{
    SDA_No_Trailing_Space      = 0x00000000,
    SDA_One_Trailing_Space     = 0x00000002,
    SDA_Two_Trailing_Spaces    = 0x00000004,
    SDA_Consume_Leading_Spaces = 0x00000008,
}

enum SpeechFormatType : int
{
    SFTInput    = 0x00000000,
    SFTSREngine = 0x00000001,
}

enum SpeechEmulationCompareFlags : int
{
    SECFIgnoreCase     = 0x00000001,
    SECFIgnoreKanaType = 0x00010000,
    SECFIgnoreWidth    = 0x00020000,
    SECFNoSpecialChars = 0x20000000,
    SECFEmulateResult  = 0x40000000,
    SECFDefault        = 0x00030001,
}

alias DISPID_SpeechRecognizerStatus = int;
enum : int
{
    DISPID_SRSAudioStatus           = 0x00000001,
    DISPID_SRSCurrentStreamPosition = 0x00000002,
    DISPID_SRSCurrentStreamNumber   = 0x00000003,
    DISPID_SRSNumberOfActiveRules   = 0x00000004,
    DISPID_SRSClsidEngine           = 0x00000005,
    DISPID_SRSSupportedLanguages    = 0x00000006,
}

alias DISPID_SpeechRecoContext = int;
enum : int
{
    DISPID_SRCRecognizer                       = 0x00000001,
    DISPID_SRCAudioInInterferenceStatus        = 0x00000002,
    DISPID_SRCRequestedUIType                  = 0x00000003,
    DISPID_SRCVoice                            = 0x00000004,
    DISPID_SRAllowVoiceFormatMatchingOnNextSet = 0x00000005,
    DISPID_SRCVoicePurgeEvent                  = 0x00000006,
    DISPID_SRCEventInterests                   = 0x00000007,
    DISPID_SRCCmdMaxAlternates                 = 0x00000008,
    DISPID_SRCState                            = 0x00000009,
    DISPID_SRCRetainedAudio                    = 0x0000000a,
    DISPID_SRCRetainedAudioFormat              = 0x0000000b,
    DISPID_SRCPause                            = 0x0000000c,
    DISPID_SRCResume                           = 0x0000000d,
    DISPID_SRCCreateGrammar                    = 0x0000000e,
    DISPID_SRCCreateResultFromMemory           = 0x0000000f,
    DISPID_SRCBookmark                         = 0x00000010,
    DISPID_SRCSetAdaptationData                = 0x00000011,
}

enum SpeechRetainedAudioOptions : int
{
    SRAONone        = 0x00000000,
    SRAORetainAudio = 0x00000001,
}

enum SpeechBookmarkOptions : int
{
    SBONone  = 0x00000000,
    SBOPause = 0x00000001,
}

enum SpeechInterference : int
{
    SINone     = 0x00000000,
    SINoise    = 0x00000001,
    SINoSignal = 0x00000002,
    SITooLoud  = 0x00000003,
    SITooQuiet = 0x00000004,
    SITooFast  = 0x00000005,
    SITooSlow  = 0x00000006,
}

enum SpeechRecoEvents : int
{
    SREStreamEnd            = 0x00000001,
    SRESoundStart           = 0x00000002,
    SRESoundEnd             = 0x00000004,
    SREPhraseStart          = 0x00000008,
    SRERecognition          = 0x00000010,
    SREHypothesis           = 0x00000020,
    SREBookmark             = 0x00000040,
    SREPropertyNumChange    = 0x00000080,
    SREPropertyStringChange = 0x00000100,
    SREFalseRecognition     = 0x00000200,
    SREInterference         = 0x00000400,
    SRERequestUI            = 0x00000800,
    SREStateChange          = 0x00001000,
    SREAdaptation           = 0x00002000,
    SREStreamStart          = 0x00004000,
    SRERecoOtherContext     = 0x00008000,
    SREAudioLevel           = 0x00010000,
    SREPrivate              = 0x00040000,
    SREAllEvents            = 0x0005ffff,
}

enum SpeechRecoContextState : int
{
    SRCS_Disabled = 0x00000000,
    SRCS_Enabled  = 0x00000001,
}

alias DISPIDSPRG = int;
enum : int
{
    DISPID_SRGId                            = 0x00000001,
    DISPID_SRGRecoContext                   = 0x00000002,
    DISPID_SRGState                         = 0x00000003,
    DISPID_SRGRules                         = 0x00000004,
    DISPID_SRGReset                         = 0x00000005,
    DISPID_SRGCommit                        = 0x00000006,
    DISPID_SRGCmdLoadFromFile               = 0x00000007,
    DISPID_SRGCmdLoadFromObject             = 0x00000008,
    DISPID_SRGCmdLoadFromResource           = 0x00000009,
    DISPID_SRGCmdLoadFromMemory             = 0x0000000a,
    DISPID_SRGCmdLoadFromProprietaryGrammar = 0x0000000b,
    DISPID_SRGCmdSetRuleState               = 0x0000000c,
    DISPID_SRGCmdSetRuleIdState             = 0x0000000d,
    DISPID_SRGDictationLoad                 = 0x0000000e,
    DISPID_SRGDictationUnload               = 0x0000000f,
    DISPID_SRGDictationSetState             = 0x00000010,
    DISPID_SRGSetWordSequenceData           = 0x00000011,
    DISPID_SRGSetTextSelection              = 0x00000012,
    DISPID_SRGIsPronounceable               = 0x00000013,
}

enum SpeechLoadOption : int
{
    SLOStatic  = 0x00000000,
    SLODynamic = 0x00000001,
}

enum SpeechWordPronounceable : int
{
    SWPUnknownWordUnpronounceable = 0x00000000,
    SWPUnknownWordPronounceable   = 0x00000001,
    SWPKnownWordPronounceable     = 0x00000002,
}

enum SpeechGrammarState : int
{
    SGSEnabled   = 0x00000001,
    SGSDisabled  = 0x00000000,
    SGSExclusive = 0x00000003,
}

enum SpeechRuleState : int
{
    SGDSInactive            = 0x00000000,
    SGDSActive              = 0x00000001,
    SGDSActiveWithAutoPause = 0x00000003,
    SGDSActiveUserDelimited = 0x00000004,
}

enum SpeechRuleAttributes : int
{
    SRATopLevel        = 0x00000001,
    SRADefaultToActive = 0x00000002,
    SRAExport          = 0x00000004,
    SRAImport          = 0x00000008,
    SRAInterpreter     = 0x00000010,
    SRADynamic         = 0x00000020,
    SRARoot            = 0x00000040,
}

enum SpeechGrammarWordType : int
{
    SGDisplay               = 0x00000000,
    SGLexical               = 0x00000001,
    SGPronounciation        = 0x00000002,
    SGLexicalNoSpecialChars = 0x00000003,
}

alias DISPID_SpeechRecoContextEvents = int;
enum : int
{
    DISPID_SRCEStartStream                = 0x00000001,
    DISPID_SRCEEndStream                  = 0x00000002,
    DISPID_SRCEBookmark                   = 0x00000003,
    DISPID_SRCESoundStart                 = 0x00000004,
    DISPID_SRCESoundEnd                   = 0x00000005,
    DISPID_SRCEPhraseStart                = 0x00000006,
    DISPID_SRCERecognition                = 0x00000007,
    DISPID_SRCEHypothesis                 = 0x00000008,
    DISPID_SRCEPropertyNumberChange       = 0x00000009,
    DISPID_SRCEPropertyStringChange       = 0x0000000a,
    DISPID_SRCEFalseRecognition           = 0x0000000b,
    DISPID_SRCEInterference               = 0x0000000c,
    DISPID_SRCERequestUI                  = 0x0000000d,
    DISPID_SRCERecognizerStateChange      = 0x0000000e,
    DISPID_SRCEAdaptation                 = 0x0000000f,
    DISPID_SRCERecognitionForOtherContext = 0x00000010,
    DISPID_SRCEAudioLevel                 = 0x00000011,
    DISPID_SRCEEnginePrivate              = 0x00000012,
}

enum SpeechRecognitionType : int
{
    SRTStandard        = 0x00000000,
    SRTAutopause       = 0x00000001,
    SRTEmulated        = 0x00000002,
    SRTSMLTimeout      = 0x00000004,
    SRTExtendableParse = 0x00000008,
    SRTReSent          = 0x00000010,
}

alias DISPID_SpeechGrammarRule = int;
enum : int
{
    DISPID_SGRAttributes   = 0x00000001,
    DISPID_SGRInitialState = 0x00000002,
    DISPID_SGRName         = 0x00000003,
    DISPID_SGRId           = 0x00000004,
    DISPID_SGRClear        = 0x00000005,
    DISPID_SGRAddResource  = 0x00000006,
    DISPID_SGRAddState     = 0x00000007,
}

alias DISPID_SpeechGrammarRules = int;
enum : int
{
    DISPID_SGRsCount         = 0x00000001,
    DISPID_SGRsDynamic       = 0x00000002,
    DISPID_SGRsAdd           = 0x00000003,
    DISPID_SGRsCommit        = 0x00000004,
    DISPID_SGRsCommitAndSave = 0x00000005,
    DISPID_SGRsFindRule      = 0x00000006,
    DISPID_SGRsItem          = 0x00000000,
    DISPID_SGRs_NewEnum      = 0xfffffffc,
}

alias DISPID_SpeechGrammarRuleState = int;
enum : int
{
    DISPID_SGRSRule                 = 0x00000001,
    DISPID_SGRSTransitions          = 0x00000002,
    DISPID_SGRSAddWordTransition    = 0x00000003,
    DISPID_SGRSAddRuleTransition    = 0x00000004,
    DISPID_SGRSAddSpecialTransition = 0x00000005,
}

enum SpeechSpecialTransitionType : int
{
    SSTTWildcard   = 0x00000001,
    SSTTDictation  = 0x00000002,
    SSTTTextBuffer = 0x00000003,
}

alias DISPID_SpeechGrammarRuleStateTransitions = int;
enum : int
{
    DISPID_SGRSTsCount    = 0x00000001,
    DISPID_SGRSTsItem     = 0x00000000,
    DISPID_SGRSTs_NewEnum = 0xfffffffc,
}

alias DISPID_SpeechGrammarRuleStateTransition = int;
enum : int
{
    DISPID_SGRSTType          = 0x00000001,
    DISPID_SGRSTText          = 0x00000002,
    DISPID_SGRSTRule          = 0x00000003,
    DISPID_SGRSTWeight        = 0x00000004,
    DISPID_SGRSTPropertyName  = 0x00000005,
    DISPID_SGRSTPropertyId    = 0x00000006,
    DISPID_SGRSTPropertyValue = 0x00000007,
    DISPID_SGRSTNextState     = 0x00000008,
}

enum SpeechGrammarRuleStateTransitionType : int
{
    SGRSTTEpsilon    = 0x00000000,
    SGRSTTWord       = 0x00000001,
    SGRSTTRule       = 0x00000002,
    SGRSTTDictation  = 0x00000003,
    SGRSTTWildcard   = 0x00000004,
    SGRSTTTextBuffer = 0x00000005,
}

alias DISPIDSPTSI = int;
enum : int
{
    DISPIDSPTSI_ActiveOffset    = 0x00000001,
    DISPIDSPTSI_ActiveLength    = 0x00000002,
    DISPIDSPTSI_SelectionOffset = 0x00000003,
    DISPIDSPTSI_SelectionLength = 0x00000004,
}

alias DISPID_SpeechRecoResult = int;
enum : int
{
    DISPID_SRRRecoContext       = 0x00000001,
    DISPID_SRRTimes             = 0x00000002,
    DISPID_SRRAudioFormat       = 0x00000003,
    DISPID_SRRPhraseInfo        = 0x00000004,
    DISPID_SRRAlternates        = 0x00000005,
    DISPID_SRRAudio             = 0x00000006,
    DISPID_SRRSpeakAudio        = 0x00000007,
    DISPID_SRRSaveToMemory      = 0x00000008,
    DISPID_SRRDiscardResultInfo = 0x00000009,
}

enum SpeechDiscardType : int
{
    SDTProperty      = 0x00000001,
    SDTReplacement   = 0x00000002,
    SDTRule          = 0x00000004,
    SDTDisplayText   = 0x00000008,
    SDTLexicalForm   = 0x00000010,
    SDTPronunciation = 0x00000020,
    SDTAudio         = 0x00000040,
    SDTAlternates    = 0x00000080,
    SDTAll           = 0x000000ff,
}

alias DISPID_SpeechXMLRecoResult = int;
enum : int
{
    DISPID_SRRGetXMLResult    = 0x0000000a,
    DISPID_SRRGetXMLErrorInfo = 0x0000000b,
}

alias DISPID_SpeechRecoResult2 = int;
enum : int
{
    DISPID_SRRSetTextFeedback = 0x0000000c,
}

alias DISPID_SpeechPhraseBuilder = int;
enum : int
{
    DISPID_SPPBRestorePhraseFromMemory = 0x00000001,
}

alias DISPID_SpeechRecoResultTimes = int;
enum : int
{
    DISPID_SRRTStreamTime      = 0x00000001,
    DISPID_SRRTLength          = 0x00000002,
    DISPID_SRRTTickCount       = 0x00000003,
    DISPID_SRRTOffsetFromStart = 0x00000004,
}

alias DISPID_SpeechPhraseAlternate = int;
enum : int
{
    DISPID_SPARecoResult               = 0x00000001,
    DISPID_SPAStartElementInResult     = 0x00000002,
    DISPID_SPANumberOfElementsInResult = 0x00000003,
    DISPID_SPAPhraseInfo               = 0x00000004,
    DISPID_SPACommit                   = 0x00000005,
}

alias DISPID_SpeechPhraseAlternates = int;
enum : int
{
    DISPID_SPAsCount    = 0x00000001,
    DISPID_SPAsItem     = 0x00000000,
    DISPID_SPAs_NewEnum = 0xfffffffc,
}

alias DISPID_SpeechPhraseInfo = int;
enum : int
{
    DISPID_SPILanguageId           = 0x00000001,
    DISPID_SPIGrammarId            = 0x00000002,
    DISPID_SPIStartTime            = 0x00000003,
    DISPID_SPIAudioStreamPosition  = 0x00000004,
    DISPID_SPIAudioSizeBytes       = 0x00000005,
    DISPID_SPIRetainedSizeBytes    = 0x00000006,
    DISPID_SPIAudioSizeTime        = 0x00000007,
    DISPID_SPIRule                 = 0x00000008,
    DISPID_SPIProperties           = 0x00000009,
    DISPID_SPIElements             = 0x0000000a,
    DISPID_SPIReplacements         = 0x0000000b,
    DISPID_SPIEngineId             = 0x0000000c,
    DISPID_SPIEnginePrivateData    = 0x0000000d,
    DISPID_SPISaveToMemory         = 0x0000000e,
    DISPID_SPIGetText              = 0x0000000f,
    DISPID_SPIGetDisplayAttributes = 0x00000010,
}

alias DISPID_SpeechPhraseElement = int;
enum : int
{
    DISPID_SPEAudioTimeOffset      = 0x00000001,
    DISPID_SPEAudioSizeTime        = 0x00000002,
    DISPID_SPEAudioStreamOffset    = 0x00000003,
    DISPID_SPEAudioSizeBytes       = 0x00000004,
    DISPID_SPERetainedStreamOffset = 0x00000005,
    DISPID_SPERetainedSizeBytes    = 0x00000006,
    DISPID_SPEDisplayText          = 0x00000007,
    DISPID_SPELexicalForm          = 0x00000008,
    DISPID_SPEPronunciation        = 0x00000009,
    DISPID_SPEDisplayAttributes    = 0x0000000a,
    DISPID_SPERequiredConfidence   = 0x0000000b,
    DISPID_SPEActualConfidence     = 0x0000000c,
    DISPID_SPEEngineConfidence     = 0x0000000d,
}

enum SpeechEngineConfidence : int
{
    SECLowConfidence    = 0xffffffff,
    SECNormalConfidence = 0x00000000,
    SECHighConfidence   = 0x00000001,
}

alias DISPID_SpeechPhraseElements = int;
enum : int
{
    DISPID_SPEsCount    = 0x00000001,
    DISPID_SPEsItem     = 0x00000000,
    DISPID_SPEs_NewEnum = 0xfffffffc,
}

alias DISPID_SpeechPhraseReplacement = int;
enum : int
{
    DISPID_SPRDisplayAttributes = 0x00000001,
    DISPID_SPRText              = 0x00000002,
    DISPID_SPRFirstElement      = 0x00000003,
    DISPID_SPRNumberOfElements  = 0x00000004,
}

alias DISPID_SpeechPhraseReplacements = int;
enum : int
{
    DISPID_SPRsCount    = 0x00000001,
    DISPID_SPRsItem     = 0x00000000,
    DISPID_SPRs_NewEnum = 0xfffffffc,
}

alias DISPID_SpeechPhraseProperty = int;
enum : int
{
    DISPID_SPPName             = 0x00000001,
    DISPID_SPPId               = 0x00000002,
    DISPID_SPPValue            = 0x00000003,
    DISPID_SPPFirstElement     = 0x00000004,
    DISPID_SPPNumberOfElements = 0x00000005,
    DISPID_SPPEngineConfidence = 0x00000006,
    DISPID_SPPConfidence       = 0x00000007,
    DISPID_SPPParent           = 0x00000008,
    DISPID_SPPChildren         = 0x00000009,
}

alias DISPID_SpeechPhraseProperties = int;
enum : int
{
    DISPID_SPPsCount    = 0x00000001,
    DISPID_SPPsItem     = 0x00000000,
    DISPID_SPPs_NewEnum = 0xfffffffc,
}

alias DISPID_SpeechPhraseRule = int;
enum : int
{
    DISPID_SPRuleName             = 0x00000001,
    DISPID_SPRuleId               = 0x00000002,
    DISPID_SPRuleFirstElement     = 0x00000003,
    DISPID_SPRuleNumberOfElements = 0x00000004,
    DISPID_SPRuleParent           = 0x00000005,
    DISPID_SPRuleChildren         = 0x00000006,
    DISPID_SPRuleConfidence       = 0x00000007,
    DISPID_SPRuleEngineConfidence = 0x00000008,
}

alias DISPID_SpeechPhraseRules = int;
enum : int
{
    DISPID_SPRulesCount    = 0x00000001,
    DISPID_SPRulesItem     = 0x00000000,
    DISPID_SPRules_NewEnum = 0xfffffffc,
}

alias DISPID_SpeechLexicon = int;
enum : int
{
    DISPID_SLGenerationId                  = 0x00000001,
    DISPID_SLGetWords                      = 0x00000002,
    DISPID_SLAddPronunciation              = 0x00000003,
    DISPID_SLAddPronunciationByPhoneIds    = 0x00000004,
    DISPID_SLRemovePronunciation           = 0x00000005,
    DISPID_SLRemovePronunciationByPhoneIds = 0x00000006,
    DISPID_SLGetPronunciations             = 0x00000007,
    DISPID_SLGetGenerationChange           = 0x00000008,
}

enum SpeechLexiconType : int
{
    SLTUser = 0x00000001,
    SLTApp  = 0x00000002,
}

enum SpeechPartOfSpeech : int
{
    SPSNotOverriden = 0xffffffff,
    SPSUnknown      = 0x00000000,
    SPSNoun         = 0x00001000,
    SPSVerb         = 0x00002000,
    SPSModifier     = 0x00003000,
    SPSFunction     = 0x00004000,
    SPSInterjection = 0x00005000,
    SPSLMA          = 0x00007000,
    SPSSuppressWord = 0x0000f000,
}

alias DISPID_SpeechLexiconWords = int;
enum : int
{
    DISPID_SLWsCount    = 0x00000001,
    DISPID_SLWsItem     = 0x00000000,
    DISPID_SLWs_NewEnum = 0xfffffffc,
}

enum SpeechWordType : int
{
    SWTAdded   = 0x00000001,
    SWTDeleted = 0x00000002,
}

alias DISPID_SpeechLexiconWord = int;
enum : int
{
    DISPID_SLWLangId         = 0x00000001,
    DISPID_SLWType           = 0x00000002,
    DISPID_SLWWord           = 0x00000003,
    DISPID_SLWPronunciations = 0x00000004,
}

alias DISPID_SpeechLexiconProns = int;
enum : int
{
    DISPID_SLPsCount    = 0x00000001,
    DISPID_SLPsItem     = 0x00000000,
    DISPID_SLPs_NewEnum = 0xfffffffc,
}

alias DISPID_SpeechLexiconPronunciation = int;
enum : int
{
    DISPID_SLPType         = 0x00000001,
    DISPID_SLPLangId       = 0x00000002,
    DISPID_SLPPartOfSpeech = 0x00000003,
    DISPID_SLPPhoneIds     = 0x00000004,
    DISPID_SLPSymbolic     = 0x00000005,
}

alias DISPID_SpeechPhoneConverter = int;
enum : int
{
    DISPID_SPCLangId    = 0x00000001,
    DISPID_SPCPhoneToId = 0x00000002,
    DISPID_SPCIdToPhone = 0x00000003,
}

alias SPVSKIPTYPE = int;
enum : int
{
    SPVST_SENTENCE = 0x00000001,
}

alias SPVESACTIONS = int;
enum : int
{
    SPVES_CONTINUE = 0x00000000,
    SPVES_ABORT    = 0x00000001,
    SPVES_SKIP     = 0x00000002,
    SPVES_RATE     = 0x00000004,
    SPVES_VOLUME   = 0x00000008,
}

alias SPTRANSITIONTYPE = int;
enum : int
{
    SPTRANSEPSILON   = 0x00000000,
    SPTRANSWORD      = 0x00000001,
    SPTRANSRULE      = 0x00000002,
    SPTRANSTEXTBUF   = 0x00000003,
    SPTRANSWILDCARD  = 0x00000004,
    SPTRANSDICTATION = 0x00000005,
}

alias SPCFGNOTIFY = int;
enum : int
{
    SPCFGN_ADD        = 0x00000000,
    SPCFGN_REMOVE     = 0x00000001,
    SPCFGN_INVALIDATE = 0x00000002,
    SPCFGN_ACTIVATE   = 0x00000003,
    SPCFGN_DEACTIVATE = 0x00000004,
}

alias SPRESULTTYPE = int;
enum : int
{
    SPRT_CFG               = 0x00000000,
    SPRT_SLM               = 0x00000001,
    SPRT_PROPRIETARY       = 0x00000002,
    SPRT_FALSE_RECOGNITION = 0x00000004,
    SPRT_TYPE_MASK         = 0x00000003,
    SPRT_EMULATED          = 0x00000008,
    SPRT_EXTENDABLE_PARSE  = 0x00000010,
}

alias SPWORDINFOOPT = int;
enum : int
{
    SPWIO_NONE      = 0x00000000,
    SPWIO_WANT_TEXT = 0x00000001,
}

alias SPRULEINFOOPT = int;
enum : int
{
    SPRIO_NONE = 0x00000000,
}

alias SPPROPSRC = int;
enum : int
{
    SPPROPSRC_RECO_INST    = 0x00000000,
    SPPROPSRC_RECO_CTX     = 0x00000001,
    SPPROPSRC_RECO_GRAMMAR = 0x00000002,
}

// Constants


enum const(wchar)* SPDUI_EngineProperties = "EngineProperties";
enum const(wchar)* SPDUI_AddRemoveWord = "AddRemoveWord";
enum const(wchar)* SPDUI_UserTraining = "UserTraining";
enum const(wchar)* SPDUI_MicTraining = "MicTraining";
enum const(wchar)* SPDUI_RecoProfileProperties = "RecoProfileProperties";

enum : const(wchar)*
{
    SPDUI_AudioProperties = "AudioProperties",
    SPDUI_AudioVolume     = "AudioVolume",
}

enum const(wchar)* SPDUI_UserEnrollment = "UserEnrollment";
enum const(wchar)* SPDUI_ShareData = "ShareData";
enum const(wchar)* SPDUI_Tutorial = "Tutorial";
enum const(wchar)* SPREG_USER_ROOT = "HKEY_CURRENT_USER\\SOFTWARE\\Microsoft\\Speech";
enum const(wchar)* SPREG_LOCAL_MACHINE_ROOT = "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Speech";

enum : const(wchar)*
{
    SPCAT_AUDIOOUT    = "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Speech\\AudioOutput",
    SPCAT_AUDIOIN     = "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Speech\\AudioInput",
    SPCAT_VOICES      = "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Speech\\Voices",
    SPCAT_RECOGNIZERS = "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Speech\\Recognizers",
}

enum const(wchar)* SPCAT_APPLEXICONS = "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Speech\\AppLexicons";
enum const(wchar)* SPCAT_PHONECONVERTERS = "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Speech\\PhoneConverters";
enum const(wchar)* SPCAT_TEXTNORMALIZERS = "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Speech\\TextNormalizers";
enum const(wchar)* SPCAT_RECOPROFILES = "HKEY_CURRENT_USER\\SOFTWARE\\Microsoft\\Speech\\RecoProfiles";

enum : const(wchar)*
{
    SPMMSYS_AUDIO_IN_TOKEN_ID  = "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Speech\\AudioInput\\TokenEnums\\MMAudioIn\\",
    SPMMSYS_AUDIO_OUT_TOKEN_ID = "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Speech\\AudioOutput\\TokenEnums\\MMAudioOut\\",
}

enum : const(wchar)*
{
    SPCURRENT_USER_LEXICON_TOKEN_ID  = "HKEY_CURRENT_USER\\SOFTWARE\\Microsoft\\Speech\\CurrentUserLexicon",
    SPCURRENT_USER_SHORTCUT_TOKEN_ID = "HKEY_CURRENT_USER\\SOFTWARE\\Microsoft\\Speech\\CurrentUserShortcut",
}

enum const(wchar)* SPTOKENVALUE_CLSID = "CLSID";

enum : const(wchar)*
{
    SPTOKENKEY_FILES                         = "Files",
    SPTOKENKEY_UI                            = "UI",
    SPTOKENKEY_ATTRIBUTES                    = "Attributes",
    SPTOKENKEY_RETAINEDAUDIO                 = "SecondsPerRetainedAudioEvent",
    SPTOKENKEY_AUDIO_LATENCY_WARNING         = "LatencyWarningThreshold",
    SPTOKENKEY_AUDIO_LATENCY_TRUNCATE        = "LatencyTruncateThreshold",
    SPTOKENKEY_AUDIO_LATENCY_UPDATE_INTERVAL = "LatencyUpdateInterval",
}

enum const(wchar)* SPVOICECATEGORY_TTSRATE = "DefaultTTSRate";
enum const(wchar)* SPPROP_RESOURCE_USAGE = "ResourceUsage";
enum const(wchar)* SPPROP_HIGH_CONFIDENCE_THRESHOLD = "HighConfidenceThreshold";
enum const(wchar)* SPPROP_NORMAL_CONFIDENCE_THRESHOLD = "NormalConfidenceThreshold";
enum const(wchar)* SPPROP_LOW_CONFIDENCE_THRESHOLD = "LowConfidenceThreshold";
enum const(wchar)* SPPROP_RESPONSE_SPEED = "ResponseSpeed";
enum const(wchar)* SPPROP_COMPLEX_RESPONSE_SPEED = "ComplexResponseSpeed";
enum const(wchar)* SPPROP_ADAPTATION_ON = "AdaptationOn";

enum : const(wchar)*
{
    SPPROP_PERSISTED_BACKGROUND_ADAPTATION     = "PersistedBackgroundAdaptation",
    SPPROP_PERSISTED_LANGUAGE_MODEL_ADAPTATION = "PersistedLanguageModelAdaptation",
}

enum const(wchar)* SPPROP_UX_IS_LISTENING = "UXIsListening";
enum const(wchar)* SPTOPIC_SPELLING = "Spelling";
enum const(wchar)* SPWILDCARD = "...";
enum const(wchar)* SPDICTATION = "*";
enum const(wchar)* SPINFDICTATION = "*+";
enum const(wchar)* SPREG_SAFE_USER_TOKENS = "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Speech\\UserTokens";
enum int SP_LOW_CONFIDENCE = 0xffffffff;
enum uint SP_NORMAL_CONFIDENCE = 0x00000000U;
enum uint DEFAULT_WEIGHT = 0x00000001U;
enum uint SP_MAX_WORD_LENGTH = 0x00000080U;
enum uint SP_MAX_PRON_LENGTH = 0x00000180U;
enum uint SP_EMULATE_RESULT = 0x40000000U;
enum uint SP_STREAMPOS_ASAP = 0x00000000U;
enum int SP_STREAMPOS_REALTIME = 0xffffffff;
enum uint SPRP_NORMAL = 0x00000000U;
enum uint SP_MAX_LANGIDS = 0x00000014U;
enum const(wchar)* SPRECOEXTENSION = "RecoExtension";
enum const(wchar)* SPALTERNATESCLSID = "AlternatesCLSID";
enum const(wchar)* SR_LOCALIZED_DESCRIPTION = "Description";
enum uint SAPI_ERROR_BASE = 0x00005000U;
enum float Speech_Default_Weight = 0x1p+0;

enum : int
{
    Speech_Max_Word_Length = 0x00000080,
    Speech_Max_Pron_Length = 0x00000180,
}

enum : int
{
    Speech_StreamPos_Asap     = 0x00000000,
    Speech_StreamPos_RealTime = 0xffffffff,
}

enum int SpeechAllElements = 0xffffffff;

// Callbacks

alias SPNOTIFYCALLBACK = void function(WPARAM wParam, LPARAM lParam);

// Structs


//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct SPSTATEHANDLE
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct SPWORDHANDLE
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct SPRULEHANDLE
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct SPGRAMMARHANDLE
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct SPRECOCONTEXTHANDLE
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct SPPHRASERULEHANDLE
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct SPPHRASEPROPERTYHANDLE
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct SPTRANSITIONID
{
    void* Value;
}

struct SPEVENT
{
    // Native bit field: eEventId: [0-15], elParamType: [16-31]
    int    _bitfield0;
    uint   ulStreamNum;
    ulong  ullAudioStreamOffset;
    WPARAM wParam;
    LPARAM lParam;
}

struct SPSERIALIZEDEVENT
{
    // Native bit field: eEventId: [0-15], elParamType: [16-31]
    int   _bitfield0;
    uint  ulStreamNum;
    ulong ullAudioStreamOffset;
    uint  SerializedwParam;
    int   SerializedlParam;
}

struct SPSERIALIZEDEVENT64
{
    // Native bit field: eEventId: [0-15], elParamType: [16-31]
    int   _bitfield0;
    uint  ulStreamNum;
    ulong ullAudioStreamOffset;
    ulong SerializedwParam;
    long  SerializedlParam;
}

struct SPEVENTEX
{
    // Native bit field: eEventId: [0-15], elParamType: [16-31]
    int    _bitfield0;
    uint   ulStreamNum;
    ulong  ullAudioStreamOffset;
    WPARAM wParam;
    LPARAM lParam;
    ulong  ullAudioTimeOffset;
}

struct SPEVENTSOURCEINFO
{
    ulong ullEventInterest;
    ulong ullQueuedInterest;
    uint  ulCount;
}

struct SPAUDIOSTATUS
{
    int          cbFreeBuffSpace;
    uint         cbNonBlockingIO;
    SPAUDIOSTATE State;
    ulong        CurSeekPos;
    ulong        CurDevicePos;
    uint         dwAudioLevel;
    uint         dwReserved2;
}

struct SPAUDIOBUFFERINFO
{
    uint ulMsMinNotification;
    uint ulMsBufferSize;
    uint ulMsEventBias;
}

struct SPPHRASEELEMENT
{
    uint           ulAudioTimeOffset;
    uint           ulAudioSizeTime;
    uint           ulAudioStreamOffset;
    uint           ulAudioSizeBytes;
    uint           ulRetainedStreamOffset;
    uint           ulRetainedSizeBytes;
    const(PWSTR)   pszDisplayText;
    const(PWSTR)   pszLexicalForm;
    const(ushort)* pszPronunciation;
    ubyte          bDisplayAttributes;
    byte           RequiredConfidence;
    byte           ActualConfidence;
    ubyte          Reserved;
    float          SREngineConfidence;
}

struct SPPHRASERULE
{
    const(PWSTR)         pszName;
    uint                 ulId;
    uint                 ulFirstElement;
    uint                 ulCountOfElements;
    const(SPPHRASERULE)* pNextSibling;
    const(SPPHRASERULE)* pFirstChild;
    float                SREngineConfidence;
    byte                 Confidence;
}

struct SPPHRASEPROPERTY
{
    const(PWSTR) pszName;
    union
    {
        uint ulId;
        struct
        {
            ubyte  bType;
            ubyte  bReserved;
            ushort usArrayIndex;
        }
    }
    const(PWSTR) pszValue;
    VARIANT      vValue;
    uint         ulFirstElement;
    uint         ulCountOfElements;
    const(SPPHRASEPROPERTY)* pNextSibling;
    const(SPPHRASEPROPERTY)* pFirstChild;
    float        SREngineConfidence;
    byte         Confidence;
}

struct SPPHRASEREPLACEMENT
{
    ubyte        bDisplayAttributes;
    const(PWSTR) pszReplacementText;
    uint         ulFirstElement;
    uint         ulCountOfElements;
}

struct SPSEMANTICERRORINFO
{
    uint    ulLineNumber;
    PWSTR   pszScriptLine;
    PWSTR   pszSource;
    PWSTR   pszDescription;
    HRESULT hrResultCode;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct SPPHRASE_50
{
    uint          cbSize;
    ushort        LangID;
    ushort        wHomophoneGroupId;
    ulong         ullGrammarID;
    ulong         ftStartTime;
    ulong         ullAudioStreamPosition;
    uint          ulAudioSizeBytes;
    uint          ulRetainedSizeBytes;
    uint          ulAudioSizeTime;
    SPPHRASERULE  Rule;
    const(SPPHRASEPROPERTY)* pProperties;
    const(SPPHRASEELEMENT)* pElements;
    uint          cReplacements;
    const(SPPHRASEREPLACEMENT)* pReplacements;
    GUID          SREngineID;
    uint          ulSREnginePrivateDataSize;
    const(ubyte)* pSREnginePrivateData;
}

struct SPPHRASE
{
    SPPHRASE_50          Base;
    PWSTR                pSML;
    SPSEMANTICERRORINFO* pSemanticErrorInfo;
}

struct SPSERIALIZEDPHRASE
{
    uint ulSerializedSize;
}

struct SPRULE
{
    const(PWSTR) pszRuleName;
    uint         ulRuleId;
    uint         dwAttributes;
}

struct SPBINARYGRAMMAR
{
    uint ulTotalSerializedSize;
}

struct SPWORDPRONUNCIATION
{
    SPWORDPRONUNCIATION* pNextWordPronunciation;
    SPLEXICONTYPE        eLexiconType;
    ushort               LangID;
    ushort               wPronunciationFlags;
    SPPARTOFSPEECH       ePartOfSpeech;
    ushort[1]            szPronunciation; // Flexible array
}

struct SPWORDPRONUNCIATIONLIST
{
    uint                 ulSize;
    ubyte*               pvBuffer;
    SPWORDPRONUNCIATION* pFirstWordPronunciation;
}

struct SPWORD
{
    SPWORD*              pNextWord;
    ushort               LangID;
    ushort               wReserved;
    SPWORDTYPE           eWordType;
    PWSTR                pszWord;
    SPWORDPRONUNCIATION* pFirstWordPronunciation;
}

struct SPWORDLIST
{
    uint    ulSize;
    ubyte*  pvBuffer;
    SPWORD* pFirstWord;
}

struct SPSHORTCUTPAIR
{
    SPSHORTCUTPAIR* pNextSHORTCUTPAIR;
    ushort          LangID;
    SPSHORTCUTTYPE  shType;
    PWSTR           pszDisplay;
    PWSTR           pszSpoken;
}

struct SPSHORTCUTPAIRLIST
{
    uint            ulSize;
    ubyte*          pvBuffer;
    SPSHORTCUTPAIR* pFirstShortcutPair;
}

struct SPVPITCH
{
    int MiddleAdj;
    int RangeAdj;
}

struct SPVCONTEXT
{
    const(PWSTR) pCategory;
    const(PWSTR) pBefore;
    const(PWSTR) pAfter;
}

struct SPVSTATE
{
    SPVACTIONS     eAction;
    ushort         LangID;
    ushort         wReserved;
    int            EmphAdj;
    int            RateAdj;
    uint           Volume;
    SPVPITCH       PitchAdj;
    uint           SilenceMSecs;
    ushort*        pPhoneIds;
    SPPARTOFSPEECH ePartOfSpeech;
    SPVCONTEXT     Context;
}

struct SPVOICESTATUS
{
    uint      ulCurrentStream;
    uint      ulLastStreamQueued;
    HRESULT   hrLastResult;
    uint      dwRunningState;
    uint      ulInputWordPos;
    uint      ulInputWordLen;
    uint      ulInputSentPos;
    uint      ulInputSentLen;
    int       lBookmarkId;
    ushort    PhonemeId;
    SPVISEMES VisemeId;
    uint      dwReserved1;
    uint      dwReserved2;
}

struct SPRECORESULTTIMES
{
    FILETIME ftStreamTime;
    ulong    ullLength;
    uint     dwTickCount;
    ulong    ullStart;
}

struct SPSERIALIZEDRESULT
{
    uint ulSerializedSize;
}

struct SPTEXTSELECTIONINFO
{
    uint ulStartActiveOffset;
    uint cchActiveChars;
    uint ulStartSelection;
    uint cchSelection;
}

struct SPPROPERTYINFO
{
    const(PWSTR) pszName;
    uint         ulId;
    const(PWSTR) pszValue;
    VARIANT      vValue;
}

struct SPRECOCONTEXTSTATUS
{
    SPINTERFERENCE eInterference;
    wchar[255]     szRequestTypeOfUI;
    uint           dwReserved1;
    uint           dwReserved2;
}

struct SPRECOGNIZERSTATUS
{
    SPAUDIOSTATUS AudioStatus;
    ulong         ullRecognitionStreamPos;
    uint          ulStreamNumber;
    uint          ulNumActive;
    GUID          clsidEngine;
    uint          cLangIDs;
    ushort[20]    aLangID;
    ulong         ullRecognitionStreamTime;
}

struct SPNORMALIZATIONLIST
{
    uint     ulSize;
    ushort** ppszzNormalizedList;
}

struct SPDISPLAYTOKEN
{
    const(PWSTR) pszLexical;
    const(PWSTR) pszDisplay;
    ubyte        bDisplayAttributes;
}

struct SPDISPLAYPHRASE
{
    uint            ulNumTokens;
    SPDISPLAYTOKEN* pTokens;
}

struct SPTMTHREADINFO
{
    int  lPoolSize;
    int  lPriority;
    uint ulConcurrencyLimit;
    uint ulMaxQuickAllocThreads;
}

struct SPVTEXTFRAG
{
    SPVTEXTFRAG* pNext;
    SPVSTATE     State;
    const(PWSTR) pTextStart;
    uint         ulTextLen;
    uint         ulTextSrcOffset;
}

struct SPWORDENTRY
{
    SPWORDHANDLE hWord;
    ushort       LangID;
    PWSTR        pszDisplayText;
    PWSTR        pszLexicalForm;
    ushort*      aPhoneId;
    void*        pvClientContext;
}

struct SPRULEENTRY
{
    SPRULEHANDLE  hRule;
    SPSTATEHANDLE hInitialState;
    uint          Attributes;
    void*         pvClientRuleContext;
    void*         pvClientGrammarContext;
}

struct SPTRANSITIONENTRY
{
    SPTRANSITIONID ID;
    SPSTATEHANDLE  hNextState;
    ubyte          Type;
    ubyte          RequiredConfidence;
    struct
    {
        uint fHasProperty;
    }
    float          Weight;
    union
    {
        struct
        {
            SPSTATEHANDLE hRuleInitialState;
            SPRULEHANDLE  hRule;
            void*         pvClientRuleContext;
        }
        struct
        {
            SPWORDHANDLE hWord;
            void*        pvClientWordContext;
        }
        struct
        {
            void* pvGrammarCookie;
        }
    }
}

struct SPTRANSITIONPROPERTY
{
    const(PWSTR) pszName;
    uint         ulId;
    const(PWSTR) pszValue;
    VARIANT      vValue;
}

struct SPSTATEINFO
{
    uint               cAllocatedEntries;
    SPTRANSITIONENTRY* pTransitions;
    uint               cEpsilons;
    uint               cRules;
    uint               cWords;
    uint               cSpecialTransitions;
}

struct SPPATHENTRY
{
    SPTRANSITIONID  hTransition;
    SPPHRASEELEMENT elem;
}

struct SPPHRASEALT
{
    ISpPhraseBuilder pPhrase;
    uint             ulStartElementInParent;
    uint             cElementsInParent;
    uint             cElementsInAlternate;
    void*            pvAltExtra;
    uint             cbAltExtra;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct SPRECORESULTINFO
{
    uint             cbSize;
    SPRESULTTYPE     eResultType;
    BOOL             fHypothesis;
    BOOL             fProprietaryAutoPause;
    ulong            ullStreamPosStart;
    ulong            ullStreamPosEnd;
    SPGRAMMARHANDLE  hGrammar;
    uint             ulSizeEngineData;
    void*            pvEngineData;
    ISpPhraseBuilder pPhrase;
    SPPHRASEALT*     aPhraseAlts;
    uint             ulNumAlts;
}

struct SPRECORESULTINFOEX
{
    SPRECORESULTINFO Base;
    ulong            ullStreamTimeStart;
    ulong            ullStreamTimeEnd;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct SPPARSEINFO
{
    uint          cbSize;
    SPRULEHANDLE  hRule;
    ulong         ullAudioStreamPosition;
    uint          ulAudioSize;
    uint          cTransitions;
    SPPATHENTRY*  pPath;
    GUID          SREngineID;
    uint          ulSREnginePrivateDataSize;
    const(ubyte)* pSREnginePrivateData;
    BOOL          fHypothesis;
}

struct SPPHRASEALTREQUEST
{
    uint           ulStartElement;
    uint           cElements;
    uint           ulRequestAltCount;
    void*          pvResultExtra;
    uint           cbResultExtra;
    ISpPhrase      pPhrase;
    ISpRecoContext pRecoContext;
}

// Interfaces

@GUID("e2ae5372-5d40-11d2-960e-00c04f8ee628")
struct SpNotifyTranslator;

@GUID("a910187f-0c7a-45ac-92cc-59edafb77b53")
struct SpObjectTokenCategory;

@GUID("ef411752-3736-4cb4-9c8c-8ef4ccb58efe")
struct SpObjectToken;

@GUID("96749373-3391-11d2-9ee3-00c04f797396")
struct SpResourceManager;

@GUID("7013943a-e2ec-11d2-a086-00c04f8ef9b5")
struct SpStreamFormatConverter;

@GUID("ab1890a0-e91f-11d2-bb91-00c04f8ee6c0")
struct SpMMAudioEnum;

@GUID("cf3d2e50-53f2-11d2-960c-00c04f8ee628")
struct SpMMAudioIn;

@GUID("a8c680eb-3d32-11d2-9ee7-00c04f797396")
struct SpMMAudioOut;

@GUID("715d9c59-4442-11d2-9605-00c04f8ee628")
struct SpStream;

@GUID("96749377-3391-11d2-9ee3-00c04f797396")
struct SpVoice;

@GUID("47206204-5eca-11d2-960f-00c04f8ee628")
struct SpSharedRecoContext;

@GUID("41b89b6b-9399-11d2-9623-00c04f8ee628")
struct SpInprocRecognizer;

@GUID("3bee4890-4fe9-4a37-8c1e-5e7e12791c1f")
struct SpSharedRecognizer;

@GUID("0655e396-25d0-11d3-9c26-00c04f8ef87c")
struct SpLexicon;

@GUID("c9e37c15-df92-4727-85d6-72e5eeb6995a")
struct SpUnCompressedLexicon;

@GUID("90903716-2f42-11d3-9c26-00c04f8ef87c")
struct SpCompressedLexicon;

@GUID("0d722f1a-9fcf-4e62-96d8-6df8f01a26aa")
struct SpShortcut;

@GUID("9185f743-1143-4c28-86b5-bff14f20e5c8")
struct SpPhoneConverter;

@GUID("4f414126-dfe3-4629-99ee-797978317ead")
struct SpPhoneticAlphabetConverter;

@GUID("455f24e9-7396-4a16-9715-7c0fdbe3efe3")
struct SpNullPhoneConverter;

@GUID("0f92030a-cbfd-4ab8-a164-ff5985547ff6")
struct SpTextSelectionInformation;

@GUID("c23fc28d-c55f-4720-8b32-91f73c2bd5d1")
struct SpPhraseInfoBuilder;

@GUID("9ef96870-e160-4792-820d-48cf0649e4ec")
struct SpAudioFormat;

@GUID("c79a574c-63be-44b9-801f-283f87f898be")
struct SpWaveFormatEx;

@GUID("73ad6842-ace0-45e8-a4dd-8795881a2c2a")
struct SpInProcRecoContext;

@GUID("8dbef13f-1948-4aa8-8cf0-048eebed95d8")
struct SpCustomStream;

@GUID("947812b3-2ae1-4644-ba86-9e90ded7ec91")
struct SpFileStream;

@GUID("5fb7ef7d-dff4-468a-b6b7-2fcbd188f994")
struct SpMemoryStream;

@GUID("d9f6ee60-58c9-458b-88e1-2f908fd7f87c")
struct SpDataKey;

@GUID("3918d75f-0acb-41f2-b733-92aa15bcecf6")
struct SpObjectTokenEnum;

@GUID("777b6bbd-2ff2-11d3-88fe-00c04f8ef9b5")
struct SpPhraseBuilder;

@GUID("12d73610-a1c9-11d3-bc90-00c04f72df9f")
struct SpITNProcessor;

@GUID("b1e29d59-a675-11d2-8302-00c04f8ee6c0")
struct SpGrammarCompiler;

@GUID("d2c13906-51ef-454e-bc67-a52475ff074c")
struct SpW3CGrammarCompiler;

@GUID("da93e903-c843-11d2-a084-00c04f8ef9b5")
struct SpGramCompBackend;

interface ISpNotifyCallback
{
    HRESULT NotifyCallback(WPARAM wParam, LPARAM lParam);
}

@GUID("5eff4aef-8487-11d2-961c-00c04f8ee628")
interface ISpNotifySource : IUnknown
{
    HRESULT SetNotifySink(ISpNotifySink pNotifySink);
    HRESULT SetNotifyWindowMessage(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);
    HRESULT SetNotifyCallbackFunction(SPNOTIFYCALLBACK* pfnCallback, WPARAM wParam, LPARAM lParam);
    HRESULT SetNotifyCallbackInterface(ISpNotifyCallback pSpCallback, WPARAM wParam, LPARAM lParam);
    HRESULT SetNotifyWin32Event();
    HRESULT WaitForNotifyEvent(uint dwMilliseconds);
    HANDLE  GetNotifyEventHandle();
}

@GUID("259684dc-37c3-11d2-9603-00c04f8ee628")
interface ISpNotifySink : IUnknown
{
    HRESULT Notify();
}

@GUID("aca16614-5d3d-11d2-960e-00c04f8ee628")
interface ISpNotifyTranslator : ISpNotifySink
{
    HRESULT InitWindowMessage(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);
    HRESULT InitCallback(SPNOTIFYCALLBACK* pfnCallback, WPARAM wParam, LPARAM lParam);
    HRESULT InitSpNotifyCallback(ISpNotifyCallback pSpCallback, WPARAM wParam, LPARAM lParam);
    HRESULT InitWin32Event(HANDLE hEvent, BOOL fCloseHandleOnRelease);
    HRESULT Wait(uint dwMilliseconds);
    HANDLE  GetEventHandle();
}

@GUID("14056581-e16c-11d2-bb90-00c04f8ee6c0")
interface ISpDataKey : IUnknown
{
    HRESULT SetData(const(PWSTR) pszValueName, uint cbData, const(ubyte)* pData);
    HRESULT GetData(const(PWSTR) pszValueName, uint* pcbData, ubyte* pData);
    HRESULT SetStringValue(const(PWSTR) pszValueName, const(PWSTR) pszValue);
    HRESULT GetStringValue(const(PWSTR) pszValueName, PWSTR* ppszValue);
    HRESULT SetDWORD(const(PWSTR) pszValueName, uint dwValue);
    HRESULT GetDWORD(const(PWSTR) pszValueName, uint* pdwValue);
    HRESULT OpenKey(const(PWSTR) pszSubKeyName, ISpDataKey* ppSubKey);
    HRESULT CreateKey(const(PWSTR) pszSubKey, ISpDataKey* ppSubKey);
    HRESULT DeleteKey(const(PWSTR) pszSubKey);
    HRESULT DeleteValue(const(PWSTR) pszValueName);
    HRESULT EnumKeys(uint Index, PWSTR* ppszSubKeyName);
    HRESULT EnumValues(uint Index, PWSTR* ppszValueName);
}

@GUID("92a66e2b-c830-4149-83df-6fc2ba1e7a5b")
interface ISpRegDataKey : ISpDataKey
{
    HRESULT SetKey(HKEY hkey, BOOL fReadOnly);
}

@GUID("2d3d3845-39af-4850-bbf9-40b49780011d")
interface ISpObjectTokenCategory : ISpDataKey
{
    HRESULT SetId(const(PWSTR) pszCategoryId, BOOL fCreateIfNotExist);
    HRESULT GetId(PWSTR* ppszCoMemCategoryId);
    HRESULT GetDataKey(SPDATAKEYLOCATION spdkl, ISpDataKey* ppDataKey);
    HRESULT EnumTokens(const(PWSTR) pzsReqAttribs, const(PWSTR) pszOptAttribs, IEnumSpObjectTokens* ppEnum);
    HRESULT SetDefaultTokenId(const(PWSTR) pszTokenId);
    HRESULT GetDefaultTokenId(PWSTR* ppszCoMemTokenId);
}

@GUID("14056589-e16c-11d2-bb90-00c04f8ee6c0")
interface ISpObjectToken : ISpDataKey
{
    HRESULT SetId(const(PWSTR) pszCategoryId, const(PWSTR) pszTokenId, BOOL fCreateIfNotExist);
    HRESULT GetId(PWSTR* ppszCoMemTokenId);
    HRESULT GetCategory(ISpObjectTokenCategory* ppTokenCategory);
    HRESULT CreateInstance(IUnknown pUnkOuter, uint dwClsContext, const(GUID)* riid, void** ppvObject);
    HRESULT GetStorageFileName(const(GUID)* clsidCaller, const(PWSTR) pszValueName, 
                               const(PWSTR) pszFileNameSpecifier, uint nFolder, PWSTR* ppszFilePath);
    HRESULT RemoveStorageFileName(const(GUID)* clsidCaller, const(PWSTR) pszKeyName, BOOL fDeleteFile);
    HRESULT Remove(const(GUID)* pclsidCaller);
    HRESULT IsUISupported(const(PWSTR) pszTypeOfUI, void* pvExtraData, uint cbExtraData, IUnknown punkObject, 
                          BOOL* pfSupported);
    HRESULT DisplayUI(HWND hwndParent, const(PWSTR) pszTitle, const(PWSTR) pszTypeOfUI, void* pvExtraData, 
                      uint cbExtraData, IUnknown punkObject);
    HRESULT MatchesAttributes(const(PWSTR) pszAttributes, BOOL* pfMatches);
}

@GUID("b8aab0cf-346f-49d8-9499-c8b03f161d51")
interface ISpObjectTokenInit : ISpObjectToken
{
    HRESULT InitFromDataKey(const(PWSTR) pszCategoryId, const(PWSTR) pszTokenId, ISpDataKey pDataKey);
}

@GUID("06b64f9e-7fda-11d2-b4f2-00c04f797396")
interface IEnumSpObjectTokens : IUnknown
{
    HRESULT Next(uint celt, ISpObjectToken* pelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumSpObjectTokens* ppEnum);
    HRESULT Item(uint Index, ISpObjectToken* ppToken);
    HRESULT GetCount(uint* pCount);
}

@GUID("5b559f40-e952-11d2-bb91-00c04f8ee6c0")
interface ISpObjectWithToken : IUnknown
{
    HRESULT SetObjectToken(ISpObjectToken pToken);
    HRESULT GetObjectToken(ISpObjectToken* ppToken);
}

@GUID("93384e18-5014-43d5-adbb-a78e055926bd")
interface ISpResourceManager : IServiceProvider
{
    HRESULT SetObject(const(GUID)* guidServiceId, IUnknown pUnkObject);
    HRESULT GetObject(const(GUID)* guidServiceId, const(GUID)* ObjectCLSID, const(GUID)* ObjectIID, 
                      BOOL fReleaseWhenLastExternalRefReleased, void** ppObject);
}

@GUID("be7a9cce-5f9e-11d2-960f-00c04f8ee628")
interface ISpEventSource : ISpNotifySource
{
    HRESULT SetInterest(ulong ullEventInterest, ulong ullQueuedInterest);
    HRESULT GetEvents(uint ulCount, SPEVENT* pEventArray, uint* pulFetched);
    HRESULT GetInfo(SPEVENTSOURCEINFO* pInfo);
}

@GUID("2373a435-6a4b-429e-a6ac-d4231a61975b")
interface ISpEventSource2 : ISpEventSource
{
    HRESULT GetEventsEx(uint ulCount, SPEVENTEX* pEventArray, uint* pulFetched);
}

@GUID("be7a9cc9-5f9e-11d2-960f-00c04f8ee628")
interface ISpEventSink : IUnknown
{
    HRESULT AddEvents(const(SPEVENT)* pEventArray, uint ulCount);
    HRESULT GetEventInterest(ulong* pullEventInterest);
}

@GUID("bed530be-2606-4f4d-a1c0-54c5cda5566f")
interface ISpStreamFormat : IStream
{
    HRESULT GetFormat(GUID* pguidFormatId, WAVEFORMATEX** ppCoMemWaveFormatEx);
}

@GUID("12e3cca9-7518-44c5-a5e7-ba5a79cb929e")
interface ISpStream : ISpStreamFormat
{
    HRESULT SetBaseStream(IStream pStream, const(GUID)* rguidFormat, const(WAVEFORMATEX)* pWaveFormatEx);
    HRESULT GetBaseStream(IStream* ppStream);
    HRESULT BindToFile(const(PWSTR) pszFileName, SPFILEMODE eMode, const(GUID)* pFormatId, 
                       const(WAVEFORMATEX)* pWaveFormatEx, ulong ullEventInterest);
    HRESULT Close();
}

@GUID("678a932c-ea71-4446-9b41-78fda6280a29")
interface ISpStreamFormatConverter : ISpStreamFormat
{
    HRESULT SetBaseStream(ISpStreamFormat pStream, BOOL fSetFormatToBaseStreamFormat, BOOL fWriteToBaseStream);
    HRESULT GetBaseStream(ISpStreamFormat* ppStream);
    HRESULT SetFormat(const(GUID)* rguidFormatIdOfConvertedStream, 
                      const(WAVEFORMATEX)* pWaveFormatExOfConvertedStream);
    HRESULT ResetSeekPosition();
    HRESULT ScaleConvertedToBaseOffset(ulong ullOffsetConvertedStream, ulong* pullOffsetBaseStream);
    HRESULT ScaleBaseToConvertedOffset(ulong ullOffsetBaseStream, ulong* pullOffsetConvertedStream);
}

@GUID("c05c768f-fae8-4ec2-8e07-338321c12452")
interface ISpAudio : ISpStreamFormat
{
    HRESULT SetState(SPAUDIOSTATE NewState, ulong ullReserved);
    HRESULT SetFormat(const(GUID)* rguidFmtId, const(WAVEFORMATEX)* pWaveFormatEx);
    HRESULT GetStatus(SPAUDIOSTATUS* pStatus);
    HRESULT SetBufferInfo(const(SPAUDIOBUFFERINFO)* pBuffInfo);
    HRESULT GetBufferInfo(SPAUDIOBUFFERINFO* pBuffInfo);
    HRESULT GetDefaultFormat(GUID* pFormatId, WAVEFORMATEX** ppCoMemWaveFormatEx);
    HANDLE  EventHandle();
    HRESULT GetVolumeLevel(uint* pLevel);
    HRESULT SetVolumeLevel(uint Level);
    HRESULT GetBufferNotifySize(uint* pcbSize);
    HRESULT SetBufferNotifySize(uint cbSize);
}

@GUID("15806f6e-1d70-4b48-98e6-3b1a007509ab")
interface ISpMMSysAudio : ISpAudio
{
    HRESULT GetDeviceId(uint* puDeviceId);
    HRESULT SetDeviceId(uint uDeviceId);
    HRESULT GetMMHandle(void** pHandle);
    HRESULT GetLineId(uint* puLineId);
    HRESULT SetLineId(uint uLineId);
}

@GUID("10f63bce-201a-11d3-ac70-00c04f8ee6c0")
interface ISpTranscript : IUnknown
{
    HRESULT GetTranscript(PWSTR* ppszTranscript);
    HRESULT AppendTranscript(const(PWSTR) pszTranscript);
}

@GUID("da41a7c2-5383-4db2-916b-6c1719e3db58")
interface ISpLexicon : IUnknown
{
    HRESULT GetPronunciations(const(PWSTR) pszWord, ushort LangID, uint dwFlags, 
                              SPWORDPRONUNCIATIONLIST* pWordPronunciationList);
    HRESULT AddPronunciation(const(PWSTR) pszWord, ushort LangID, SPPARTOFSPEECH ePartOfSpeech, 
                             ushort* pszPronunciation);
    HRESULT RemovePronunciation(const(PWSTR) pszWord, ushort LangID, SPPARTOFSPEECH ePartOfSpeech, 
                                ushort* pszPronunciation);
    HRESULT GetGeneration(uint* pdwGeneration);
    HRESULT GetGenerationChange(uint dwFlags, uint* pdwGeneration, SPWORDLIST* pWordList);
    HRESULT GetWords(uint dwFlags, uint* pdwGeneration, uint* pdwCookie, SPWORDLIST* pWordList);
}

@GUID("8565572f-c094-41cc-b56e-10bd9c3ff044")
interface ISpContainerLexicon : ISpLexicon
{
    HRESULT AddLexicon(ISpLexicon pAddLexicon, uint dwFlags);
}

@GUID("3df681e2-ea56-11d9-8bde-f66bad1e3f3a")
interface ISpShortcut : IUnknown
{
    HRESULT AddShortcut(const(PWSTR) pszDisplay, ushort LangID, const(PWSTR) pszSpoken, SPSHORTCUTTYPE shType);
    HRESULT RemoveShortcut(const(PWSTR) pszDisplay, ushort LangID, const(PWSTR) pszSpoken, SPSHORTCUTTYPE shType);
    HRESULT GetShortcuts(ushort LangID, SPSHORTCUTPAIRLIST* pShortcutpairList);
    HRESULT GetGeneration(uint* pdwGeneration);
    HRESULT GetWordsFromGenerationChange(uint* pdwGeneration, SPWORDLIST* pWordList);
    HRESULT GetWords(uint* pdwGeneration, uint* pdwCookie, SPWORDLIST* pWordList);
    HRESULT GetShortcutsForGeneration(uint* pdwGeneration, uint* pdwCookie, SPSHORTCUTPAIRLIST* pShortcutpairList);
    HRESULT GetGenerationChange(uint* pdwGeneration, SPSHORTCUTPAIRLIST* pShortcutpairList);
}

@GUID("8445c581-0cac-4a38-abfe-9b2ce2826455")
interface ISpPhoneConverter : ISpObjectWithToken
{
    HRESULT PhoneToId(const(PWSTR) pszPhone, ushort* pId);
    HRESULT IdToPhone(ushort* pId, PWSTR pszPhone);
}

@GUID("133adcd4-19b4-4020-9fdc-842e78253b17")
interface ISpPhoneticAlphabetConverter : IUnknown
{
    HRESULT GetLangId(ushort* pLangID);
    HRESULT SetLangId(ushort LangID);
    HRESULT SAPI2UPS(const(ushort)* pszSAPIId, ushort* pszUPSId, uint cMaxLength);
    HRESULT UPS2SAPI(const(ushort)* pszUPSId, ushort* pszSAPIId, uint cMaxLength);
    HRESULT GetMaxConvertLength(uint cSrcLength, BOOL bSAPI2UPS, uint* pcMaxDestLength);
}

@GUID("b2745efd-42ce-48ca-81f1-a96e02538a90")
interface ISpPhoneticAlphabetSelection : IUnknown
{
    HRESULT IsAlphabetUPS(BOOL* pfIsUPS);
    HRESULT SetAlphabetToUPS(BOOL fForceUPS);
}

@GUID("6c44df74-72b9-4992-a1ec-ef996e0422d4")
interface ISpVoice : ISpEventSource
{
    HRESULT SetOutput(IUnknown pUnkOutput, BOOL fAllowFormatChanges);
    HRESULT GetOutputObjectToken(ISpObjectToken* ppObjectToken);
    HRESULT GetOutputStream(ISpStreamFormat* ppStream);
    HRESULT Pause();
    HRESULT Resume();
    HRESULT SetVoice(ISpObjectToken pToken);
    HRESULT GetVoice(ISpObjectToken* ppToken);
    HRESULT Speak(const(PWSTR) pwcs, uint dwFlags, uint* pulStreamNumber);
    HRESULT SpeakStream(IStream pStream, uint dwFlags, uint* pulStreamNumber);
    HRESULT GetStatus(SPVOICESTATUS* pStatus, PWSTR* ppszLastBookmark);
    HRESULT Skip(const(PWSTR) pItemType, int lNumItems, uint* pulNumSkipped);
    HRESULT SetPriority(SPVPRIORITY ePriority);
    HRESULT GetPriority(SPVPRIORITY* pePriority);
    HRESULT SetAlertBoundary(SPEVENTENUM eBoundary);
    HRESULT GetAlertBoundary(SPEVENTENUM* peBoundary);
    HRESULT SetRate(int RateAdjust);
    HRESULT GetRate(int* pRateAdjust);
    HRESULT SetVolume(ushort usVolume);
    HRESULT GetVolume(ushort* pusVolume);
    HRESULT WaitUntilDone(uint msTimeout);
    HRESULT SetSyncSpeakTimeout(uint msTimeout);
    HRESULT GetSyncSpeakTimeout(uint* pmsTimeout);
    HANDLE  SpeakCompleteEvent();
    HRESULT IsUISupported(const(PWSTR) pszTypeOfUI, void* pvExtraData, uint cbExtraData, BOOL* pfSupported);
    HRESULT DisplayUI(HWND hwndParent, const(PWSTR) pszTitle, const(PWSTR) pszTypeOfUI, void* pvExtraData, 
                      uint cbExtraData);
}

@GUID("1a5c0354-b621-4b5a-8791-d306ed379e53")
interface ISpPhrase : IUnknown
{
    HRESULT GetPhrase(SPPHRASE** ppCoMemPhrase);
    HRESULT GetSerializedPhrase(SPSERIALIZEDPHRASE** ppCoMemPhrase);
    HRESULT GetText(uint ulStart, uint ulCount, BOOL fUseTextReplacements, PWSTR* ppszCoMemText, 
                    ubyte* pbDisplayAttributes);
    HRESULT Discard(uint dwValueTypes);
}

@GUID("8fcebc98-4e49-4067-9c6c-d86a0e092e3d")
interface ISpPhraseAlt : ISpPhrase
{
    HRESULT GetAltInfo(ISpPhrase* ppParent, uint* pulStartElementInParent, uint* pcElementsInParent, 
                       uint* pcElementsInAlt);
    HRESULT Commit();
}

@GUID("f264da52-e457-4696-b856-a737b717af79")
interface ISpPhrase2 : ISpPhrase
{
    HRESULT GetXMLResult(PWSTR* ppszCoMemXMLResult, SPXMLRESULTOPTIONS Options);
    HRESULT GetXMLErrorInfo(SPSEMANTICERRORINFO* pSemanticErrorInfo);
    HRESULT GetAudio(uint ulStartElement, uint cElements, ISpStreamFormat* ppStream);
}

@GUID("20b053be-e235-43cd-9a2a-8d17a48b7842")
interface ISpRecoResult : ISpPhrase
{
    HRESULT GetResultTimes(SPRECORESULTTIMES* pTimes);
    HRESULT GetAlternates(uint ulStartElement, uint cElements, uint ulRequestCount, ISpPhraseAlt* ppPhrases, 
                          uint* pcPhrasesReturned);
    HRESULT GetAudio(uint ulStartElement, uint cElements, ISpStreamFormat* ppStream);
    HRESULT SpeakAudio(uint ulStartElement, uint cElements, uint dwFlags, uint* pulStreamNumber);
    HRESULT Serialize(SPSERIALIZEDRESULT** ppCoMemSerializedResult);
    HRESULT ScaleAudio(const(GUID)* pAudioFormatId, const(WAVEFORMATEX)* pWaveFormatEx);
    HRESULT GetRecoContext(ISpRecoContext* ppRecoContext);
}

@GUID("27cac6c4-88f2-41f2-8817-0c95e59f1e6e")
interface ISpRecoResult2 : ISpRecoResult
{
    HRESULT CommitAlternate(ISpPhraseAlt pPhraseAlt, ISpRecoResult* ppNewResult);
    HRESULT CommitText(uint ulStartElement, uint cElements, const(PWSTR) pszCorrectedData, uint eCommitFlags);
    HRESULT SetTextFeedback(const(PWSTR) pszFeedback, BOOL fSuccessful);
}

@GUID("ae39362b-45a8-4074-9b9e-ccf49aa2d0b6")
interface ISpXMLRecoResult : ISpRecoResult
{
    HRESULT GetXMLResult(PWSTR* ppszCoMemXMLResult, SPXMLRESULTOPTIONS Options);
    HRESULT GetXMLErrorInfo(SPSEMANTICERRORINFO* pSemanticErrorInfo);
}

@GUID("8137828f-591a-4a42-be58-49ea7ebaac68")
interface ISpGrammarBuilder : IUnknown
{
    HRESULT ResetGrammar(ushort NewLanguage);
    HRESULT GetRule(const(PWSTR) pszRuleName, uint dwRuleId, uint dwAttributes, BOOL fCreateIfNotExist, 
                    SPSTATEHANDLE* phInitialState);
    HRESULT ClearRule(SPSTATEHANDLE hState);
    HRESULT CreateNewState(SPSTATEHANDLE hState, SPSTATEHANDLE* phState);
    HRESULT AddWordTransition(SPSTATEHANDLE hFromState, SPSTATEHANDLE hToState, const(PWSTR) psz, 
                              const(PWSTR) pszSeparators, SPGRAMMARWORDTYPE eWordType, float Weight, 
                              const(SPPROPERTYINFO)* pPropInfo);
    HRESULT AddRuleTransition(SPSTATEHANDLE hFromState, SPSTATEHANDLE hToState, SPSTATEHANDLE hRule, float Weight, 
                              const(SPPROPERTYINFO)* pPropInfo);
    HRESULT AddResource(SPSTATEHANDLE hRuleState, const(PWSTR) pszResourceName, const(PWSTR) pszResourceValue);
    HRESULT Commit(uint dwReserved);
}

@GUID("2177db29-7f45-47d0-8554-067e91c80502")
interface ISpRecoGrammar : ISpGrammarBuilder
{
    HRESULT GetGrammarId(ulong* pullGrammarId);
    HRESULT GetRecoContext(ISpRecoContext* ppRecoCtxt);
    HRESULT LoadCmdFromFile(const(PWSTR) pszFileName, SPLOADOPTIONS Options);
    HRESULT LoadCmdFromObject(const(GUID)* rcid, const(PWSTR) pszGrammarName, SPLOADOPTIONS Options);
    HRESULT LoadCmdFromResource(HMODULE hModule, const(PWSTR) pszResourceName, const(PWSTR) pszResourceType, 
                                ushort wLanguage, SPLOADOPTIONS Options);
    HRESULT LoadCmdFromMemory(const(SPBINARYGRAMMAR)* pGrammar, SPLOADOPTIONS Options);
    HRESULT LoadCmdFromProprietaryGrammar(const(GUID)* rguidParam, const(PWSTR) pszStringParam, 
                                          const(void)* pvDataPrarm, uint cbDataSize, SPLOADOPTIONS Options);
    HRESULT SetRuleState(const(PWSTR) pszName, void* pReserved, SPRULESTATE NewState);
    HRESULT SetRuleIdState(uint ulRuleId, SPRULESTATE NewState);
    HRESULT LoadDictation(const(PWSTR) pszTopicName, SPLOADOPTIONS Options);
    HRESULT UnloadDictation();
    HRESULT SetDictationState(SPRULESTATE NewState);
    HRESULT SetWordSequenceData(const(PWSTR) pText, uint cchText, const(SPTEXTSELECTIONINFO)* pInfo);
    HRESULT SetTextSelection(const(SPTEXTSELECTIONINFO)* pInfo);
    HRESULT IsPronounceable(const(PWSTR) pszWord, SPWORDPRONOUNCEABLE* pWordPronounceable);
    HRESULT SetGrammarState(SPGRAMMARSTATE eGrammarState);
    HRESULT SaveCmd(IStream pStream, PWSTR* ppszCoMemErrorText);
    HRESULT GetGrammarState(SPGRAMMARSTATE* peGrammarState);
}

@GUID("8ab10026-20cc-4b20-8c22-a49c9ba78f60")
interface ISpGrammarBuilder2 : IUnknown
{
    HRESULT AddTextSubset(SPSTATEHANDLE hFromState, SPSTATEHANDLE hToState, const(PWSTR) psz, 
                          SPMATCHINGMODE eMatchMode);
    HRESULT SetPhoneticAlphabet(PHONETICALPHABET phoneticALphabet);
}

@GUID("4b37bc9e-9ed6-44a3-93d3-18f022b79ec3")
interface ISpRecoGrammar2 : IUnknown
{
    HRESULT GetRules(SPRULE** ppCoMemRules, uint* puNumRules);
    HRESULT LoadCmdFromFile2(const(PWSTR) pszFileName, SPLOADOPTIONS Options, const(PWSTR) pszSharingUri, 
                             const(PWSTR) pszBaseUri);
    HRESULT LoadCmdFromMemory2(const(SPBINARYGRAMMAR)* pGrammar, SPLOADOPTIONS Options, const(PWSTR) pszSharingUri, 
                               const(PWSTR) pszBaseUri);
    HRESULT SetRulePriority(const(PWSTR) pszRuleName, uint ulRuleId, int nRulePriority);
    HRESULT SetRuleWeight(const(PWSTR) pszRuleName, uint ulRuleId, float flWeight);
    HRESULT SetDictationWeight(float flWeight);
    HRESULT SetGrammarLoader(ISpeechResourceLoader pLoader);
    HRESULT SetSMLSecurityManager(IInternetSecurityManager pSMLSecurityManager);
}

@GUID("b9ac5783-fcd0-4b21-b119-b4f8da8fd2c3")
interface ISpeechResourceLoader : IDispatch
{
    HRESULT LoadResource(BSTR bstrResourceUri, VARIANT_BOOL fAlwaysReload, IUnknown* pStream, BSTR* pbstrMIMEType, 
                         VARIANT_BOOL* pfModified, BSTR* pbstrRedirectUrl);
    HRESULT GetLocalCopy(BSTR bstrResourceUri, BSTR* pbstrLocalPath, BSTR* pbstrMIMEType, BSTR* pbstrRedirectUrl);
    HRESULT ReleaseLocalCopy(BSTR pbstrLocalPath);
}

@GUID("f740a62f-7c15-489e-8234-940a33d9272d")
interface ISpRecoContext : ISpEventSource
{
    HRESULT GetRecognizer(ISpRecognizer* ppRecognizer);
    HRESULT CreateGrammar(ulong ullGrammarId, ISpRecoGrammar* ppGrammar);
    HRESULT GetStatus(SPRECOCONTEXTSTATUS* pStatus);
    HRESULT GetMaxAlternates(uint* pcAlternates);
    HRESULT SetMaxAlternates(uint cAlternates);
    HRESULT SetAudioOptions(SPAUDIOOPTIONS Options, const(GUID)* pAudioFormatId, 
                            const(WAVEFORMATEX)* pWaveFormatEx);
    HRESULT GetAudioOptions(SPAUDIOOPTIONS* pOptions, GUID* pAudioFormatId, WAVEFORMATEX** ppCoMemWFEX);
    HRESULT DeserializeResult(const(SPSERIALIZEDRESULT)* pSerializedResult, ISpRecoResult* ppResult);
    HRESULT Bookmark(SPBOOKMARKOPTIONS Options, ulong ullStreamPosition, LPARAM lparamEvent);
    HRESULT SetAdaptationData(const(PWSTR) pAdaptationData, const(uint) cch);
    HRESULT Pause(uint dwReserved);
    HRESULT Resume(uint dwReserved);
    HRESULT SetVoice(ISpVoice pVoice, BOOL fAllowFormatChanges);
    HRESULT GetVoice(ISpVoice* ppVoice);
    HRESULT SetVoicePurgeEvent(ulong ullEventInterest);
    HRESULT GetVoicePurgeEvent(ulong* pullEventInterest);
    HRESULT SetContextState(SPCONTEXTSTATE eContextState);
    HRESULT GetContextState(SPCONTEXTSTATE* peContextState);
}

@GUID("bead311c-52ff-437f-9464-6b21054ca73d")
interface ISpRecoContext2 : IUnknown
{
    HRESULT SetGrammarOptions(uint eGrammarOptions);
    HRESULT GetGrammarOptions(uint* peGrammarOptions);
    HRESULT SetAdaptationData2(const(PWSTR) pAdaptationData, const(uint) cch, const(PWSTR) pTopicName, 
                               uint eAdaptationSettings, SPADAPTATIONRELEVANCE eRelevance);
}

@GUID("5b4fb971-b115-4de1-ad97-e482e3bf6ee4")
interface ISpProperties : IUnknown
{
    HRESULT SetPropertyNum(const(PWSTR) pName, int lValue);
    HRESULT GetPropertyNum(const(PWSTR) pName, int* plValue);
    HRESULT SetPropertyString(const(PWSTR) pName, const(PWSTR) pValue);
    HRESULT GetPropertyString(const(PWSTR) pName, PWSTR* ppCoMemValue);
}

@GUID("c2b5f241-daa0-4507-9e16-5a1eaa2b7a5c")
interface ISpRecognizer : ISpProperties
{
    HRESULT SetRecognizer(ISpObjectToken pRecognizer);
    HRESULT GetRecognizer(ISpObjectToken* ppRecognizer);
    HRESULT SetInput(IUnknown pUnkInput, BOOL fAllowFormatChanges);
    HRESULT GetInputObjectToken(ISpObjectToken* ppToken);
    HRESULT GetInputStream(ISpStreamFormat* ppStream);
    HRESULT CreateRecoContext(ISpRecoContext* ppNewCtxt);
    HRESULT GetRecoProfile(ISpObjectToken* ppToken);
    HRESULT SetRecoProfile(ISpObjectToken pToken);
    HRESULT IsSharedInstance();
    HRESULT GetRecoState(SPRECOSTATE* pState);
    HRESULT SetRecoState(SPRECOSTATE NewState);
    HRESULT GetStatus(SPRECOGNIZERSTATUS* pStatus);
    HRESULT GetFormat(SPSTREAMFORMATTYPE WaveFormatType, GUID* pFormatId, WAVEFORMATEX** ppCoMemWFEX);
    HRESULT IsUISupported(const(PWSTR) pszTypeOfUI, void* pvExtraData, uint cbExtraData, BOOL* pfSupported);
    HRESULT DisplayUI(HWND hwndParent, const(PWSTR) pszTitle, const(PWSTR) pszTypeOfUI, void* pvExtraData, 
                      uint cbExtraData);
    HRESULT EmulateRecognition(ISpPhrase pPhrase);
}

@GUID("21b501a0-0ec7-46c9-92c3-a2bc784c54b9")
interface ISpSerializeState : IUnknown
{
    HRESULT GetSerializedState(ubyte** ppbData, uint* pulSize, uint dwReserved);
    HRESULT SetSerializedState(ubyte* pbData, uint ulSize, uint dwReserved);
}

@GUID("8fc6d974-c81e-4098-93c5-0147f61ed4d3")
interface ISpRecognizer2 : IUnknown
{
    HRESULT EmulateRecognitionEx(ISpPhrase pPhrase, uint dwCompareFlags);
    HRESULT SetTrainingState(BOOL fDoingTraining, BOOL fAdaptFromTrainingData);
    HRESULT ResetAcousticModelAdaptation();
}

@GUID("c360ce4b-76d1-4214-ad68-52657d5083da")
interface ISpEnginePronunciation : IUnknown
{
    HRESULT Normalize(const(PWSTR) pszWord, const(PWSTR) pszLeftContext, const(PWSTR) pszRightContext, 
                      ushort LangID, SPNORMALIZATIONLIST* pNormalizationList);
    HRESULT GetPronunciations(const(PWSTR) pszWord, const(PWSTR) pszLeftContext, const(PWSTR) pszRightContext, 
                              ushort LangID, SPWORDPRONUNCIATIONLIST* pEnginePronunciationList);
}

@GUID("c8d7c7e2-0dde-44b7-afe3-b0c991fbeb5e")
interface ISpDisplayAlternates : IUnknown
{
    HRESULT GetDisplayAlternates(const(SPDISPLAYPHRASE)* pPhrase, uint cRequestCount, 
                                 SPDISPLAYPHRASE** ppCoMemPhrases, uint* pcPhrasesReturned);
    HRESULT SetFullStopTrailSpace(uint ulTrailSpace);
}

@GUID("ce17c09b-4efa-44d5-a4c9-59d9585ab0cd")
interface ISpeechDataKey : IDispatch
{
    HRESULT SetBinaryValue(const(BSTR) ValueName, VARIANT Value);
    HRESULT GetBinaryValue(const(BSTR) ValueName, VARIANT* Value);
    HRESULT SetStringValue(const(BSTR) ValueName, const(BSTR) Value);
    HRESULT GetStringValue(const(BSTR) ValueName, BSTR* Value);
    HRESULT SetLongValue(const(BSTR) ValueName, int Value);
    HRESULT GetLongValue(const(BSTR) ValueName, int* Value);
    HRESULT OpenKey(const(BSTR) SubKeyName, ISpeechDataKey* SubKey);
    HRESULT CreateKey(const(BSTR) SubKeyName, ISpeechDataKey* SubKey);
    HRESULT DeleteKey(const(BSTR) SubKeyName);
    HRESULT DeleteValue(const(BSTR) ValueName);
    HRESULT EnumKeys(int Index, BSTR* SubKeyName);
    HRESULT EnumValues(int Index, BSTR* ValueName);
}

@GUID("c74a3adc-b727-4500-a84a-b526721c8b8c")
interface ISpeechObjectToken : IDispatch
{
    HRESULT get_Id(BSTR* ObjectId);
    HRESULT get_DataKey(ISpeechDataKey* DataKey);
    HRESULT get_Category(ISpeechObjectTokenCategory* Category);
    HRESULT GetDescription(int Locale, BSTR* Description);
    HRESULT SetId(BSTR Id, BSTR CategoryID, VARIANT_BOOL CreateIfNotExist);
    HRESULT GetAttribute(BSTR AttributeName, BSTR* AttributeValue);
    HRESULT CreateInstance(IUnknown pUnkOuter, SpeechTokenContext ClsContext, IUnknown* Object);
    HRESULT Remove(BSTR ObjectStorageCLSID);
    HRESULT GetStorageFileName(BSTR ObjectStorageCLSID, BSTR KeyName, BSTR FileName, SpeechTokenShellFolder Folder, 
                               BSTR* FilePath);
    HRESULT RemoveStorageFileName(BSTR ObjectStorageCLSID, BSTR KeyName, VARIANT_BOOL DeleteFile);
    HRESULT IsUISupported(const(BSTR) TypeOfUI, const(VARIANT)* ExtraData, IUnknown Object, 
                          VARIANT_BOOL* Supported);
    HRESULT DisplayUI(int hWnd, BSTR Title, const(BSTR) TypeOfUI, const(VARIANT)* ExtraData, IUnknown Object);
    HRESULT MatchesAttributes(BSTR Attributes, VARIANT_BOOL* Matches);
}

@GUID("9285b776-2e7b-4bc0-b53e-580eb6fa967f")
interface ISpeechObjectTokens : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT Item(int Index, ISpeechObjectToken* Token);
    HRESULT get__NewEnum(IUnknown* ppEnumVARIANT);
}

@GUID("ca7eac50-2d01-4145-86d4-5ae7d70f4469")
interface ISpeechObjectTokenCategory : IDispatch
{
    HRESULT get_Id(BSTR* Id);
    HRESULT put_Default(const(BSTR) TokenId);
    HRESULT get_Default(BSTR* TokenId);
    HRESULT SetId(const(BSTR) Id, VARIANT_BOOL CreateIfNotExist);
    HRESULT GetDataKey(SpeechDataKeyLocation Location, ISpeechDataKey* DataKey);
    HRESULT EnumerateTokens(BSTR RequiredAttributes, BSTR OptionalAttributes, ISpeechObjectTokens* Tokens);
}

@GUID("11b103d8-1142-4edf-a093-82fb3915f8cc")
interface ISpeechAudioBufferInfo : IDispatch
{
    HRESULT get_MinNotification(int* MinNotification);
    HRESULT put_MinNotification(int MinNotification);
    HRESULT get_BufferSize(int* BufferSize);
    HRESULT put_BufferSize(int BufferSize);
    HRESULT get_EventBias(int* EventBias);
    HRESULT put_EventBias(int EventBias);
}

@GUID("c62d9c91-7458-47f6-862d-1ef86fb0b278")
interface ISpeechAudioStatus : IDispatch
{
    HRESULT get_FreeBufferSpace(int* FreeBufferSpace);
    HRESULT get_NonBlockingIO(int* NonBlockingIO);
    HRESULT get_State(SpeechAudioState* State);
    HRESULT get_CurrentSeekPosition(VARIANT* CurrentSeekPosition);
    HRESULT get_CurrentDevicePosition(VARIANT* CurrentDevicePosition);
}

@GUID("e6e9c590-3e18-40e3-8299-061f98bde7c7")
interface ISpeechAudioFormat : IDispatch
{
    HRESULT get_Type(SpeechAudioFormatType* AudioFormat);
    HRESULT put_Type(SpeechAudioFormatType AudioFormat);
    HRESULT get_Guid(BSTR* Guid);
    HRESULT put_Guid(BSTR Guid);
    HRESULT GetWaveFormatEx(ISpeechWaveFormatEx* SpeechWaveFormatEx);
    HRESULT SetWaveFormatEx(ISpeechWaveFormatEx SpeechWaveFormatEx);
}

@GUID("7a1ef0d5-1581-4741-88e4-209a49f11a10")
interface ISpeechWaveFormatEx : IDispatch
{
    HRESULT get_FormatTag(short* FormatTag);
    HRESULT put_FormatTag(short FormatTag);
    HRESULT get_Channels(short* Channels);
    HRESULT put_Channels(short Channels);
    HRESULT get_SamplesPerSec(int* SamplesPerSec);
    HRESULT put_SamplesPerSec(int SamplesPerSec);
    HRESULT get_AvgBytesPerSec(int* AvgBytesPerSec);
    HRESULT put_AvgBytesPerSec(int AvgBytesPerSec);
    HRESULT get_BlockAlign(short* BlockAlign);
    HRESULT put_BlockAlign(short BlockAlign);
    HRESULT get_BitsPerSample(short* BitsPerSample);
    HRESULT put_BitsPerSample(short BitsPerSample);
    HRESULT get_ExtraData(VARIANT* ExtraData);
    HRESULT put_ExtraData(VARIANT ExtraData);
}

@GUID("6450336f-7d49-4ced-8097-49d6dee37294")
interface ISpeechBaseStream : IDispatch
{
    HRESULT get_Format(ISpeechAudioFormat* AudioFormat);
    HRESULT putref_Format(ISpeechAudioFormat AudioFormat);
    HRESULT Read(VARIANT* Buffer, int NumberOfBytes, int* BytesRead);
    HRESULT Write(VARIANT Buffer, int* BytesWritten);
    HRESULT Seek(VARIANT Position, SpeechStreamSeekPositionType Origin, VARIANT* NewPosition);
}

@GUID("af67f125-ab39-4e93-b4a2-cc2e66e182a7")
interface ISpeechFileStream : ISpeechBaseStream
{
    HRESULT Open(BSTR FileName, SpeechStreamFileMode FileMode, VARIANT_BOOL DoEvents);
    HRESULT Close();
}

@GUID("eeb14b68-808b-4abe-a5ea-b51da7588008")
interface ISpeechMemoryStream : ISpeechBaseStream
{
    HRESULT SetData(VARIANT Data);
    HRESULT GetData(VARIANT* pData);
}

@GUID("1a9e9f4f-104f-4db8-a115-efd7fd0c97ae")
interface ISpeechCustomStream : ISpeechBaseStream
{
    HRESULT get_BaseStream(IUnknown* ppUnkStream);
    HRESULT putref_BaseStream(IUnknown pUnkStream);
}

@GUID("cff8e175-019e-11d3-a08e-00c04f8ef9b5")
interface ISpeechAudio : ISpeechBaseStream
{
    HRESULT get_Status(ISpeechAudioStatus* Status);
    HRESULT get_BufferInfo(ISpeechAudioBufferInfo* BufferInfo);
    HRESULT get_DefaultFormat(ISpeechAudioFormat* StreamFormat);
    HRESULT get_Volume(int* Volume);
    HRESULT put_Volume(int Volume);
    HRESULT get_BufferNotifySize(int* BufferNotifySize);
    HRESULT put_BufferNotifySize(int BufferNotifySize);
    HRESULT get_EventHandle(int* EventHandle);
    HRESULT SetState(SpeechAudioState State);
}

@GUID("3c76af6d-1fd7-4831-81d1-3b71d5a13c44")
interface ISpeechMMSysAudio : ISpeechAudio
{
    HRESULT get_DeviceId(int* DeviceId);
    HRESULT put_DeviceId(int DeviceId);
    HRESULT get_LineId(int* LineId);
    HRESULT put_LineId(int LineId);
    HRESULT get_MMHandle(int* Handle);
}

@GUID("269316d8-57bd-11d2-9eee-00c04f797396")
interface ISpeechVoice : IDispatch
{
    HRESULT get_Status(ISpeechVoiceStatus* Status);
    HRESULT get_Voice(ISpeechObjectToken* Voice);
    HRESULT putref_Voice(ISpeechObjectToken Voice);
    HRESULT get_AudioOutput(ISpeechObjectToken* AudioOutput);
    HRESULT putref_AudioOutput(ISpeechObjectToken AudioOutput);
    HRESULT get_AudioOutputStream(ISpeechBaseStream* AudioOutputStream);
    HRESULT putref_AudioOutputStream(ISpeechBaseStream AudioOutputStream);
    HRESULT get_Rate(int* Rate);
    HRESULT put_Rate(int Rate);
    HRESULT get_Volume(int* Volume);
    HRESULT put_Volume(int Volume);
    HRESULT put_AllowAudioOutputFormatChangesOnNextSet(VARIANT_BOOL Allow);
    HRESULT get_AllowAudioOutputFormatChangesOnNextSet(VARIANT_BOOL* Allow);
    HRESULT get_EventInterests(SpeechVoiceEvents* EventInterestFlags);
    HRESULT put_EventInterests(SpeechVoiceEvents EventInterestFlags);
    HRESULT put_Priority(SpeechVoicePriority Priority);
    HRESULT get_Priority(SpeechVoicePriority* Priority);
    HRESULT put_AlertBoundary(SpeechVoiceEvents Boundary);
    HRESULT get_AlertBoundary(SpeechVoiceEvents* Boundary);
    HRESULT put_SynchronousSpeakTimeout(int msTimeout);
    HRESULT get_SynchronousSpeakTimeout(int* msTimeout);
    HRESULT Speak(BSTR Text, SpeechVoiceSpeakFlags Flags, int* StreamNumber);
    HRESULT SpeakStream(ISpeechBaseStream Stream, SpeechVoiceSpeakFlags Flags, int* StreamNumber);
    HRESULT Pause();
    HRESULT Resume();
    HRESULT Skip(const(BSTR) Type, int NumItems, int* NumSkipped);
    HRESULT GetVoices(BSTR RequiredAttributes, BSTR OptionalAttributes, ISpeechObjectTokens* ObjectTokens);
    HRESULT GetAudioOutputs(BSTR RequiredAttributes, BSTR OptionalAttributes, ISpeechObjectTokens* ObjectTokens);
    HRESULT WaitUntilDone(int msTimeout, VARIANT_BOOL* Done);
    HRESULT SpeakCompleteEvent(int* Handle);
    HRESULT IsUISupported(const(BSTR) TypeOfUI, const(VARIANT)* ExtraData, VARIANT_BOOL* Supported);
    HRESULT DisplayUI(int hWndParent, BSTR Title, const(BSTR) TypeOfUI, const(VARIANT)* ExtraData);
}

@GUID("8be47b07-57f6-11d2-9eee-00c04f797396")
interface ISpeechVoiceStatus : IDispatch
{
    HRESULT get_CurrentStreamNumber(int* StreamNumber);
    HRESULT get_LastStreamNumberQueued(int* StreamNumber);
    HRESULT get_LastHResult(int* HResult);
    HRESULT get_RunningState(SpeechRunState* State);
    HRESULT get_InputWordPosition(int* Position);
    HRESULT get_InputWordLength(int* Length);
    HRESULT get_InputSentencePosition(int* Position);
    HRESULT get_InputSentenceLength(int* Length);
    HRESULT get_LastBookmark(BSTR* Bookmark);
    HRESULT get_LastBookmarkId(int* BookmarkId);
    HRESULT get_PhonemeId(short* PhoneId);
    HRESULT get_VisemeId(short* VisemeId);
}

@GUID("a372acd1-3bef-4bbd-8ffb-cb3e2b416af8")
interface _ISpeechVoiceEvents : IDispatch
{
}

@GUID("2d5f1c0c-bd75-4b08-9478-3b11fea2586c")
interface ISpeechRecognizer : IDispatch
{
    HRESULT putref_Recognizer(ISpeechObjectToken Recognizer);
    HRESULT get_Recognizer(ISpeechObjectToken* Recognizer);
    HRESULT put_AllowAudioInputFormatChangesOnNextSet(VARIANT_BOOL Allow);
    HRESULT get_AllowAudioInputFormatChangesOnNextSet(VARIANT_BOOL* Allow);
    HRESULT putref_AudioInput(ISpeechObjectToken AudioInput);
    HRESULT get_AudioInput(ISpeechObjectToken* AudioInput);
    HRESULT putref_AudioInputStream(ISpeechBaseStream AudioInputStream);
    HRESULT get_AudioInputStream(ISpeechBaseStream* AudioInputStream);
    HRESULT get_IsShared(VARIANT_BOOL* Shared);
    HRESULT put_State(SpeechRecognizerState State);
    HRESULT get_State(SpeechRecognizerState* State);
    HRESULT get_Status(ISpeechRecognizerStatus* Status);
    HRESULT putref_Profile(ISpeechObjectToken Profile);
    HRESULT get_Profile(ISpeechObjectToken* Profile);
    HRESULT EmulateRecognition(VARIANT TextElements, VARIANT* ElementDisplayAttributes, int LanguageId);
    HRESULT CreateRecoContext(ISpeechRecoContext* NewContext);
    HRESULT GetFormat(SpeechFormatType Type, ISpeechAudioFormat* Format);
    HRESULT SetPropertyNumber(const(BSTR) Name, int Value, VARIANT_BOOL* Supported);
    HRESULT GetPropertyNumber(const(BSTR) Name, int* Value, VARIANT_BOOL* Supported);
    HRESULT SetPropertyString(const(BSTR) Name, const(BSTR) Value, VARIANT_BOOL* Supported);
    HRESULT GetPropertyString(const(BSTR) Name, BSTR* Value, VARIANT_BOOL* Supported);
    HRESULT IsUISupported(const(BSTR) TypeOfUI, const(VARIANT)* ExtraData, VARIANT_BOOL* Supported);
    HRESULT DisplayUI(int hWndParent, BSTR Title, const(BSTR) TypeOfUI, const(VARIANT)* ExtraData);
    HRESULT GetRecognizers(BSTR RequiredAttributes, BSTR OptionalAttributes, ISpeechObjectTokens* ObjectTokens);
    HRESULT GetAudioInputs(BSTR RequiredAttributes, BSTR OptionalAttributes, ISpeechObjectTokens* ObjectTokens);
    HRESULT GetProfiles(BSTR RequiredAttributes, BSTR OptionalAttributes, ISpeechObjectTokens* ObjectTokens);
}

@GUID("bff9e781-53ec-484e-bb8a-0e1b5551e35c")
interface ISpeechRecognizerStatus : IDispatch
{
    HRESULT get_AudioStatus(ISpeechAudioStatus* AudioStatus);
    HRESULT get_CurrentStreamPosition(VARIANT* pCurrentStreamPos);
    HRESULT get_CurrentStreamNumber(int* StreamNumber);
    HRESULT get_NumberOfActiveRules(int* NumberOfActiveRules);
    HRESULT get_ClsidEngine(BSTR* ClsidEngine);
    HRESULT get_SupportedLanguages(VARIANT* SupportedLanguages);
}

@GUID("580aa49d-7e1e-4809-b8e2-57da806104b8")
interface ISpeechRecoContext : IDispatch
{
    HRESULT get_Recognizer(ISpeechRecognizer* Recognizer);
    HRESULT get_AudioInputInterferenceStatus(SpeechInterference* Interference);
    HRESULT get_RequestedUIType(BSTR* UIType);
    HRESULT putref_Voice(ISpeechVoice Voice);
    HRESULT get_Voice(ISpeechVoice* Voice);
    HRESULT put_AllowVoiceFormatMatchingOnNextSet(VARIANT_BOOL Allow);
    HRESULT get_AllowVoiceFormatMatchingOnNextSet(VARIANT_BOOL* pAllow);
    HRESULT put_VoicePurgeEvent(SpeechRecoEvents EventInterest);
    HRESULT get_VoicePurgeEvent(SpeechRecoEvents* EventInterest);
    HRESULT put_EventInterests(SpeechRecoEvents EventInterest);
    HRESULT get_EventInterests(SpeechRecoEvents* EventInterest);
    HRESULT put_CmdMaxAlternates(int MaxAlternates);
    HRESULT get_CmdMaxAlternates(int* MaxAlternates);
    HRESULT put_State(SpeechRecoContextState State);
    HRESULT get_State(SpeechRecoContextState* State);
    HRESULT put_RetainedAudio(SpeechRetainedAudioOptions Option);
    HRESULT get_RetainedAudio(SpeechRetainedAudioOptions* Option);
    HRESULT putref_RetainedAudioFormat(ISpeechAudioFormat Format);
    HRESULT get_RetainedAudioFormat(ISpeechAudioFormat* Format);
    HRESULT Pause();
    HRESULT Resume();
    HRESULT CreateGrammar(VARIANT GrammarId, ISpeechRecoGrammar* Grammar);
    HRESULT CreateResultFromMemory(VARIANT* ResultBlock, ISpeechRecoResult* Result);
    HRESULT Bookmark(SpeechBookmarkOptions Options, VARIANT StreamPos, VARIANT BookmarkId);
    HRESULT SetAdaptationData(BSTR AdaptationString);
}

@GUID("b6d6f79f-2158-4e50-b5bc-9a9ccd852a09")
interface ISpeechRecoGrammar : IDispatch
{
    HRESULT get_Id(VARIANT* Id);
    HRESULT get_RecoContext(ISpeechRecoContext* RecoContext);
    HRESULT put_State(SpeechGrammarState State);
    HRESULT get_State(SpeechGrammarState* State);
    HRESULT get_Rules(ISpeechGrammarRules* Rules);
    HRESULT Reset(int NewLanguage);
    HRESULT CmdLoadFromFile(const(BSTR) FileName, SpeechLoadOption LoadOption);
    HRESULT CmdLoadFromObject(const(BSTR) ClassId, const(BSTR) GrammarName, SpeechLoadOption LoadOption);
    HRESULT CmdLoadFromResource(int hModule, VARIANT ResourceName, VARIANT ResourceType, int LanguageId, 
                                SpeechLoadOption LoadOption);
    HRESULT CmdLoadFromMemory(VARIANT GrammarData, SpeechLoadOption LoadOption);
    HRESULT CmdLoadFromProprietaryGrammar(const(BSTR) ProprietaryGuid, const(BSTR) ProprietaryString, 
                                          VARIANT ProprietaryData, SpeechLoadOption LoadOption);
    HRESULT CmdSetRuleState(const(BSTR) Name, SpeechRuleState State);
    HRESULT CmdSetRuleIdState(int RuleId, SpeechRuleState State);
    HRESULT DictationLoad(const(BSTR) TopicName, SpeechLoadOption LoadOption);
    HRESULT DictationUnload();
    HRESULT DictationSetState(SpeechRuleState State);
    HRESULT SetWordSequenceData(const(BSTR) Text, int TextLength, ISpeechTextSelectionInformation Info);
    HRESULT SetTextSelection(ISpeechTextSelectionInformation Info);
    HRESULT IsPronounceable(const(BSTR) Word, SpeechWordPronounceable* WordPronounceable);
}

@GUID("7b8fcb42-0e9d-4f00-a048-7b04d6179d3d")
interface _ISpeechRecoContextEvents : IDispatch
{
}

@GUID("afe719cf-5dd1-44f2-999c-7a399f1cfccc")
interface ISpeechGrammarRule : IDispatch
{
    HRESULT get_Attributes(SpeechRuleAttributes* Attributes);
    HRESULT get_InitialState(ISpeechGrammarRuleState* State);
    HRESULT get_Name(BSTR* Name);
    HRESULT get_Id(int* Id);
    HRESULT Clear();
    HRESULT AddResource(const(BSTR) ResourceName, const(BSTR) ResourceValue);
    HRESULT AddState(ISpeechGrammarRuleState* State);
}

@GUID("6ffa3b44-fc2d-40d1-8afc-32911c7f1ad1")
interface ISpeechGrammarRules : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT FindRule(VARIANT RuleNameOrId, ISpeechGrammarRule* Rule);
    HRESULT Item(int Index, ISpeechGrammarRule* Rule);
    HRESULT get__NewEnum(IUnknown* EnumVARIANT);
    HRESULT get_Dynamic(VARIANT_BOOL* Dynamic);
    HRESULT Add(BSTR RuleName, SpeechRuleAttributes Attributes, int RuleId, ISpeechGrammarRule* Rule);
    HRESULT Commit();
    HRESULT CommitAndSave(BSTR* ErrorText, VARIANT* SaveStream);
}

@GUID("d4286f2c-ee67-45ae-b928-28d695362eda")
interface ISpeechGrammarRuleState : IDispatch
{
    HRESULT get_Rule(ISpeechGrammarRule* Rule);
    HRESULT get_Transitions(ISpeechGrammarRuleStateTransitions* Transitions);
    HRESULT AddWordTransition(ISpeechGrammarRuleState DestState, const(BSTR) Words, const(BSTR) Separators, 
                              SpeechGrammarWordType Type, const(BSTR) PropertyName, int PropertyId, 
                              VARIANT* PropertyValue, float Weight);
    HRESULT AddRuleTransition(ISpeechGrammarRuleState DestinationState, ISpeechGrammarRule Rule, 
                              const(BSTR) PropertyName, int PropertyId, VARIANT* PropertyValue, float Weight);
    HRESULT AddSpecialTransition(ISpeechGrammarRuleState DestinationState, SpeechSpecialTransitionType Type, 
                                 const(BSTR) PropertyName, int PropertyId, VARIANT* PropertyValue, float Weight);
}

@GUID("cafd1db1-41d1-4a06-9863-e2e81da17a9a")
interface ISpeechGrammarRuleStateTransition : IDispatch
{
    HRESULT get_Type(SpeechGrammarRuleStateTransitionType* Type);
    HRESULT get_Text(BSTR* Text);
    HRESULT get_Rule(ISpeechGrammarRule* Rule);
    HRESULT get_Weight(VARIANT* Weight);
    HRESULT get_PropertyName(BSTR* PropertyName);
    HRESULT get_PropertyId(int* PropertyId);
    HRESULT get_PropertyValue(VARIANT* PropertyValue);
    HRESULT get_NextState(ISpeechGrammarRuleState* NextState);
}

@GUID("eabce657-75bc-44a2-aa7f-c56476742963")
interface ISpeechGrammarRuleStateTransitions : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT Item(int Index, ISpeechGrammarRuleStateTransition* Transition);
    HRESULT get__NewEnum(IUnknown* EnumVARIANT);
}

@GUID("3b9c7e7a-6eee-4ded-9092-11657279adbe")
interface ISpeechTextSelectionInformation : IDispatch
{
    HRESULT put_ActiveOffset(int ActiveOffset);
    HRESULT get_ActiveOffset(int* ActiveOffset);
    HRESULT put_ActiveLength(int ActiveLength);
    HRESULT get_ActiveLength(int* ActiveLength);
    HRESULT put_SelectionOffset(int SelectionOffset);
    HRESULT get_SelectionOffset(int* SelectionOffset);
    HRESULT put_SelectionLength(int SelectionLength);
    HRESULT get_SelectionLength(int* SelectionLength);
}

@GUID("ed2879cf-ced9-4ee6-a534-de0191d5468d")
interface ISpeechRecoResult : IDispatch
{
    HRESULT get_RecoContext(ISpeechRecoContext* RecoContext);
    HRESULT get_Times(ISpeechRecoResultTimes* Times);
    HRESULT putref_AudioFormat(ISpeechAudioFormat Format);
    HRESULT get_AudioFormat(ISpeechAudioFormat* Format);
    HRESULT get_PhraseInfo(ISpeechPhraseInfo* PhraseInfo);
    HRESULT Alternates(int RequestCount, int StartElement, int Elements, ISpeechPhraseAlternates* Alternates);
    HRESULT Audio(int StartElement, int Elements, ISpeechMemoryStream* Stream);
    HRESULT SpeakAudio(int StartElement, int Elements, SpeechVoiceSpeakFlags Flags, int* StreamNumber);
    HRESULT SaveToMemory(VARIANT* ResultBlock);
    HRESULT DiscardResultInfo(SpeechDiscardType ValueTypes);
}

@GUID("8e0a246d-d3c8-45de-8657-04290c458c3c")
interface ISpeechRecoResult2 : ISpeechRecoResult
{
    HRESULT SetTextFeedback(BSTR Feedback, VARIANT_BOOL WasSuccessful);
}

@GUID("62b3b8fb-f6e7-41be-bdcb-056b1c29efc0")
interface ISpeechRecoResultTimes : IDispatch
{
    HRESULT get_StreamTime(VARIANT* Time);
    HRESULT get_Length(VARIANT* Length);
    HRESULT get_TickCount(int* TickCount);
    HRESULT get_OffsetFromStart(VARIANT* OffsetFromStart);
}

@GUID("27864a2a-2b9f-4cb8-92d3-0d2722fd1e73")
interface ISpeechPhraseAlternate : IDispatch
{
    HRESULT get_RecoResult(ISpeechRecoResult* RecoResult);
    HRESULT get_StartElementInResult(int* StartElement);
    HRESULT get_NumberOfElementsInResult(int* NumberOfElements);
    HRESULT get_PhraseInfo(ISpeechPhraseInfo* PhraseInfo);
    HRESULT Commit();
}

@GUID("b238b6d5-f276-4c3d-a6c1-2974801c3cc2")
interface ISpeechPhraseAlternates : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT Item(int Index, ISpeechPhraseAlternate* PhraseAlternate);
    HRESULT get__NewEnum(IUnknown* EnumVARIANT);
}

@GUID("961559cf-4e67-4662-8bf0-d93f1fcd61b3")
interface ISpeechPhraseInfo : IDispatch
{
    HRESULT get_LanguageId(int* LanguageId);
    HRESULT get_GrammarId(VARIANT* GrammarId);
    HRESULT get_StartTime(VARIANT* StartTime);
    HRESULT get_AudioStreamPosition(VARIANT* AudioStreamPosition);
    HRESULT get_AudioSizeBytes(int* pAudioSizeBytes);
    HRESULT get_RetainedSizeBytes(int* RetainedSizeBytes);
    HRESULT get_AudioSizeTime(int* AudioSizeTime);
    HRESULT get_Rule(ISpeechPhraseRule* Rule);
    HRESULT get_Properties(ISpeechPhraseProperties* Properties);
    HRESULT get_Elements(ISpeechPhraseElements* Elements);
    HRESULT get_Replacements(ISpeechPhraseReplacements* Replacements);
    HRESULT get_EngineId(BSTR* EngineIdGuid);
    HRESULT get_EnginePrivateData(VARIANT* PrivateData);
    HRESULT SaveToMemory(VARIANT* PhraseBlock);
    HRESULT GetText(int StartElement, int Elements, VARIANT_BOOL UseReplacements, BSTR* Text);
    HRESULT GetDisplayAttributes(int StartElement, int Elements, VARIANT_BOOL UseReplacements, 
                                 SpeechDisplayAttributes* DisplayAttributes);
}

@GUID("e6176f96-e373-4801-b223-3b62c068c0b4")
interface ISpeechPhraseElement : IDispatch
{
    HRESULT get_AudioTimeOffset(int* AudioTimeOffset);
    HRESULT get_AudioSizeTime(int* AudioSizeTime);
    HRESULT get_AudioStreamOffset(int* AudioStreamOffset);
    HRESULT get_AudioSizeBytes(int* AudioSizeBytes);
    HRESULT get_RetainedStreamOffset(int* RetainedStreamOffset);
    HRESULT get_RetainedSizeBytes(int* RetainedSizeBytes);
    HRESULT get_DisplayText(BSTR* DisplayText);
    HRESULT get_LexicalForm(BSTR* LexicalForm);
    HRESULT get_Pronunciation(VARIANT* Pronunciation);
    HRESULT get_DisplayAttributes(SpeechDisplayAttributes* DisplayAttributes);
    HRESULT get_RequiredConfidence(SpeechEngineConfidence* RequiredConfidence);
    HRESULT get_ActualConfidence(SpeechEngineConfidence* ActualConfidence);
    HRESULT get_EngineConfidence(float* EngineConfidence);
}

@GUID("0626b328-3478-467d-a0b3-d0853b93dda3")
interface ISpeechPhraseElements : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT Item(int Index, ISpeechPhraseElement* Element);
    HRESULT get__NewEnum(IUnknown* EnumVARIANT);
}

@GUID("2890a410-53a7-4fb5-94ec-06d4998e3d02")
interface ISpeechPhraseReplacement : IDispatch
{
    HRESULT get_DisplayAttributes(SpeechDisplayAttributes* DisplayAttributes);
    HRESULT get_Text(BSTR* Text);
    HRESULT get_FirstElement(int* FirstElement);
    HRESULT get_NumberOfElements(int* NumberOfElements);
}

@GUID("38bc662f-2257-4525-959e-2069d2596c05")
interface ISpeechPhraseReplacements : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT Item(int Index, ISpeechPhraseReplacement* Reps);
    HRESULT get__NewEnum(IUnknown* EnumVARIANT);
}

@GUID("ce563d48-961e-4732-a2e1-378a42b430be")
interface ISpeechPhraseProperty : IDispatch
{
    HRESULT get_Name(BSTR* Name);
    HRESULT get_Id(int* Id);
    HRESULT get_Value(VARIANT* Value);
    HRESULT get_FirstElement(int* FirstElement);
    HRESULT get_NumberOfElements(int* NumberOfElements);
    HRESULT get_EngineConfidence(float* Confidence);
    HRESULT get_Confidence(SpeechEngineConfidence* Confidence);
    HRESULT get_Parent(ISpeechPhraseProperty* ParentProperty);
    HRESULT get_Children(ISpeechPhraseProperties* Children);
}

@GUID("08166b47-102e-4b23-a599-bdb98dbfd1f4")
interface ISpeechPhraseProperties : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT Item(int Index, ISpeechPhraseProperty* Property);
    HRESULT get__NewEnum(IUnknown* EnumVARIANT);
}

@GUID("a7bfe112-a4a0-48d9-b602-c313843f6964")
interface ISpeechPhraseRule : IDispatch
{
    HRESULT get_Name(BSTR* Name);
    HRESULT get_Id(int* Id);
    HRESULT get_FirstElement(int* FirstElement);
    HRESULT get_NumberOfElements(int* NumberOfElements);
    HRESULT get_Parent(ISpeechPhraseRule* Parent);
    HRESULT get_Children(ISpeechPhraseRules* Children);
    HRESULT get_Confidence(SpeechEngineConfidence* ActualConfidence);
    HRESULT get_EngineConfidence(float* EngineConfidence);
}

@GUID("9047d593-01dd-4b72-81a3-e4a0ca69f407")
interface ISpeechPhraseRules : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT Item(int Index, ISpeechPhraseRule* Rule);
    HRESULT get__NewEnum(IUnknown* EnumVARIANT);
}

@GUID("3da7627a-c7ae-4b23-8708-638c50362c25")
interface ISpeechLexicon : IDispatch
{
    HRESULT get_GenerationId(int* GenerationId);
    HRESULT GetWords(SpeechLexiconType Flags, int* GenerationID, ISpeechLexiconWords* Words);
    HRESULT AddPronunciation(BSTR bstrWord, int LangId, SpeechPartOfSpeech PartOfSpeech, BSTR bstrPronunciation);
    HRESULT AddPronunciationByPhoneIds(BSTR bstrWord, int LangId, SpeechPartOfSpeech PartOfSpeech, 
                                       VARIANT* PhoneIds);
    HRESULT RemovePronunciation(BSTR bstrWord, int LangId, SpeechPartOfSpeech PartOfSpeech, BSTR bstrPronunciation);
    HRESULT RemovePronunciationByPhoneIds(BSTR bstrWord, int LangId, SpeechPartOfSpeech PartOfSpeech, 
                                          VARIANT* PhoneIds);
    HRESULT GetPronunciations(BSTR bstrWord, int LangId, SpeechLexiconType TypeFlags, 
                              ISpeechLexiconPronunciations* ppPronunciations);
    HRESULT GetGenerationChange(int* GenerationID, ISpeechLexiconWords* ppWords);
}

@GUID("8d199862-415e-47d5-ac4f-faa608b424e6")
interface ISpeechLexiconWords : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT Item(int Index, ISpeechLexiconWord* Word);
    HRESULT get__NewEnum(IUnknown* EnumVARIANT);
}

@GUID("4e5b933c-c9be-48ed-8842-1ee51bb1d4ff")
interface ISpeechLexiconWord : IDispatch
{
    HRESULT get_LangId(int* LangId);
    HRESULT get_Type(SpeechWordType* WordType);
    HRESULT get_Word(BSTR* Word);
    HRESULT get_Pronunciations(ISpeechLexiconPronunciations* Pronunciations);
}

@GUID("72829128-5682-4704-a0d4-3e2bb6f2ead3")
interface ISpeechLexiconPronunciations : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT Item(int Index, ISpeechLexiconPronunciation* Pronunciation);
    HRESULT get__NewEnum(IUnknown* EnumVARIANT);
}

@GUID("95252c5d-9e43-4f4a-9899-48ee73352f9f")
interface ISpeechLexiconPronunciation : IDispatch
{
    HRESULT get_Type(SpeechLexiconType* LexiconType);
    HRESULT get_LangId(int* LangId);
    HRESULT get_PartOfSpeech(SpeechPartOfSpeech* PartOfSpeech);
    HRESULT get_PhoneIds(VARIANT* PhoneIds);
    HRESULT get_Symbolic(BSTR* Symbolic);
}

@GUID("aaec54af-8f85-4924-944d-b79d39d72e19")
interface ISpeechXMLRecoResult : ISpeechRecoResult
{
    HRESULT GetXMLResult(SPXMLRESULTOPTIONS Options, BSTR* pResult);
    HRESULT GetXMLErrorInfo(int* LineNumber, BSTR* ScriptLine, BSTR* Source, BSTR* Description, int* ResultCode, 
                            VARIANT_BOOL* IsError);
}

@GUID("6d60eb64-aced-40a6-bbf3-4e557f71dee2")
interface ISpeechRecoResultDispatch : IDispatch
{
    HRESULT get_RecoContext(ISpeechRecoContext* RecoContext);
    HRESULT get_Times(ISpeechRecoResultTimes* Times);
    HRESULT putref_AudioFormat(ISpeechAudioFormat Format);
    HRESULT get_AudioFormat(ISpeechAudioFormat* Format);
    HRESULT get_PhraseInfo(ISpeechPhraseInfo* PhraseInfo);
    HRESULT Alternates(int RequestCount, int StartElement, int Elements, ISpeechPhraseAlternates* Alternates);
    HRESULT Audio(int StartElement, int Elements, ISpeechMemoryStream* Stream);
    HRESULT SpeakAudio(int StartElement, int Elements, SpeechVoiceSpeakFlags Flags, int* StreamNumber);
    HRESULT SaveToMemory(VARIANT* ResultBlock);
    HRESULT DiscardResultInfo(SpeechDiscardType ValueTypes);
    HRESULT GetXMLResult(SPXMLRESULTOPTIONS Options, BSTR* pResult);
    HRESULT GetXMLErrorInfo(int* LineNumber, BSTR* ScriptLine, BSTR* Source, BSTR* Description, 
                            HRESULT* ResultCode, VARIANT_BOOL* IsError);
    HRESULT SetTextFeedback(BSTR Feedback, VARIANT_BOOL WasSuccessful);
}

@GUID("3b151836-df3a-4e0a-846c-d2adc9334333")
interface ISpeechPhraseInfoBuilder : IDispatch
{
    HRESULT RestorePhraseFromMemory(VARIANT* PhraseInMemory, ISpeechPhraseInfo* PhraseInfo);
}

@GUID("c3e4f353-433f-43d6-89a1-6a62a7054c3d")
interface ISpeechPhoneConverter : IDispatch
{
    HRESULT get_LanguageId(int* LanguageId);
    HRESULT put_LanguageId(int LanguageId);
    HRESULT PhoneToId(const(BSTR) Phonemes, VARIANT* IdArray);
    HRESULT IdToPhone(const(VARIANT) IdArray, BSTR* Phonemes);
}

@GUID("f8e690f0-39cb-4843-b8d7-c84696e1119d")
interface ISpTokenUI : IUnknown
{
    HRESULT IsUISupported(const(PWSTR) pszTypeOfUI, void* pvExtraData, uint cbExtraData, IUnknown punkObject, 
                          BOOL* pfSupported);
    HRESULT DisplayUI(HWND hwndParent, const(PWSTR) pszTitle, const(PWSTR) pszTypeOfUI, void* pvExtraData, 
                      uint cbExtraData, ISpObjectToken pToken, IUnknown punkObject);
}

@GUID("06b64f9f-7fda-11d2-b4f2-00c04f797396")
interface ISpObjectTokenEnumBuilder : IEnumSpObjectTokens
{
    HRESULT SetAttribs(const(PWSTR) pszReqAttribs, const(PWSTR) pszOptAttribs);
    HRESULT AddTokens(uint cTokens, ISpObjectToken* pToken);
    HRESULT AddTokensFromDataKey(ISpDataKey pDataKey, const(PWSTR) pszSubKey, const(PWSTR) pszCategoryId);
    HRESULT AddTokensFromTokenEnum(IEnumSpObjectTokens pTokenEnum);
    HRESULT Sort(const(PWSTR) pszTokenIdToListFirst);
}

@GUID("f4711347-e608-11d2-a086-00c04f8ef9b5")
interface ISpErrorLog : IUnknown
{
    HRESULT AddError(const(int) lLineNumber, HRESULT hr, const(PWSTR) pszDescription, const(PWSTR) pszHelpFile, 
                     uint dwHelpContext);
}

@GUID("b1e29d58-a675-11d2-8302-00c04f8ee6c0")
interface ISpGrammarCompiler : IUnknown
{
    HRESULT CompileStream(IStream pSource, IStream pDest, IStream pHeader, IUnknown pReserved, 
                          ISpErrorLog pErrorLog, uint dwFlags);
}

@GUID("3ddca27c-665c-4786-9f97-8c90c3488b61")
interface ISpGramCompBackend : ISpGrammarBuilder
{
    HRESULT SetSaveObjects(IStream pStream, ISpErrorLog pErrorLog);
    HRESULT InitFromBinaryGrammar(const(SPBINARYGRAMMAR)* pBinaryData);
}

@GUID("12d7360f-a1c9-11d3-bc90-00c04f72df9f")
interface ISpITNProcessor : IUnknown
{
    HRESULT LoadITNGrammar(PWSTR pszCLSID);
    HRESULT ITNPhrase(ISpPhraseBuilder pPhrase);
}

@GUID("88a3342a-0bed-4834-922b-88d43173162f")
interface ISpPhraseBuilder : ISpPhrase
{
    HRESULT InitFromPhrase(const(SPPHRASE)* pPhrase);
    HRESULT InitFromSerializedPhrase(const(SPSERIALIZEDPHRASE)* pPhrase);
    HRESULT AddElements(uint cElements, const(SPPHRASEELEMENT)* pElement);
    HRESULT AddRules(const(SPPHRASERULEHANDLE) hParent, const(SPPHRASERULE)* pRule, SPPHRASERULEHANDLE* phNewRule);
    HRESULT AddProperties(const(SPPHRASEPROPERTYHANDLE) hParent, const(SPPHRASEPROPERTY)* pProperty, 
                          SPPHRASEPROPERTYHANDLE* phNewProperty);
    HRESULT AddReplacements(uint cReplacements, const(SPPHRASEREPLACEMENT)* pReplacements);
}

interface ISpTask
{
    HRESULT Execute(void* pvTaskData, const(int)* pfContinueProcessing);
}

interface ISpThreadTask
{
    HRESULT InitThread(void* pvTaskData, HWND hwnd);
    HRESULT ThreadProc(void* pvTaskData, HANDLE hExitThreadEvent, HANDLE hNotifyEvent, HWND hwndWorker, 
                       const(int)* pfContinueProcessing);
    LRESULT WindowMessage(void* pvTaskData, HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);
}

@GUID("a6be4d73-4403-4358-b22d-0346e23b1764")
interface ISpThreadControl : ISpNotifySink
{
    HRESULT StartThread(uint dwFlags, HWND* phwnd);
    HRESULT WaitForThreadDone(BOOL fForceStop, HRESULT* phrThreadResult, uint msTimeOut);
    HRESULT TerminateThread();
    HANDLE  ThreadHandle();
    uint    ThreadId();
    HANDLE  NotifyEvent();
    HWND    WindowHandle();
    HANDLE  ThreadCompleteEvent();
    HANDLE  ExitThreadEvent();
}

@GUID("2baeef81-2ca3-4331-98f3-26ec5abefb03")
interface ISpTaskManager : IUnknown
{
    HRESULT SetThreadPoolInfo(const(SPTMTHREADINFO)* pPoolInfo);
    HRESULT GetThreadPoolInfo(SPTMTHREADINFO* pPoolInfo);
    HRESULT QueueTask(ISpTask pTask, void* pvTaskData, HANDLE hCompEvent, uint* pdwGroupId, uint* pTaskID);
    HRESULT CreateReoccurringTask(ISpTask pTask, void* pvTaskData, HANDLE hCompEvent, ISpNotifySink* ppTaskCtrl);
    HRESULT CreateThreadControl(ISpThreadTask pTask, void* pvTaskData, int nPriority, ISpThreadControl* ppTaskCtrl);
    HRESULT TerminateTask(uint dwTaskId, uint ulWaitPeriod);
    HRESULT TerminateTaskGroup(uint dwGroupId, uint ulWaitPeriod);
}

@GUID("9880499b-cce9-11d2-b503-00c04f797396")
interface ISpTTSEngineSite : ISpEventSink
{
    uint    GetActions();
    HRESULT Write(const(void)* pBuff, uint cb, uint* pcbWritten);
    HRESULT GetRate(int* pRateAdjust);
    HRESULT GetVolume(ushort* pusVolume);
    HRESULT GetSkipInfo(SPVSKIPTYPE* peType, int* plNumItems);
    HRESULT CompleteSkip(int ulNumSkipped);
}

@GUID("a74d7c8e-4cc5-4f2f-a6eb-804dee18500e")
interface ISpTTSEngine : IUnknown
{
    HRESULT Speak(uint dwSpeakFlags, const(GUID)* rguidFormatId, const(WAVEFORMATEX)* pWaveFormatEx, 
                  const(SPVTEXTFRAG)* pTextFragList, ISpTTSEngineSite pOutputSite);
    HRESULT GetOutputFormat(const(GUID)* pTargetFmtId, const(WAVEFORMATEX)* pTargetWaveFormatEx, 
                            GUID* pOutputFormatId, WAVEFORMATEX** ppCoMemOutputWaveFormatEx);
}

@GUID("6a6ffad8-78b6-473d-b844-98152e4fb16b")
interface ISpCFGInterpreterSite : IUnknown
{
    HRESULT AddTextReplacement(SPPHRASEREPLACEMENT* pReplace);
    HRESULT AddProperty(const(SPPHRASEPROPERTY)* pProperty);
    HRESULT GetResourceValue(const(PWSTR) pszResourceName, PWSTR* ppCoMemResource);
}

@GUID("f3d3f926-11fc-11d3-bb97-00c04f8ee6c0")
interface ISpCFGInterpreter : IUnknown
{
    HRESULT InitGrammar(const(PWSTR) pszGrammarName, const(void)** pvGrammarData);
    HRESULT Interpret(ISpPhraseBuilder pPhrase, const(uint) ulFirstElement, const(uint) ulCountOfElements, 
                      ISpCFGInterpreterSite pSite);
}

@GUID("3b414aec-720c-4883-b9ef-178cd394fb3a")
interface ISpSREngineSite : IUnknown
{
    HRESULT Read(void* pv, uint cb, uint* pcbRead);
    HRESULT DataAvailable(uint* pcb);
    HRESULT SetBufferNotifySize(uint cbSize);
    HRESULT ParseFromTransitions(const(SPPARSEINFO)* pParseInfo, ISpPhraseBuilder* ppNewPhrase);
    HRESULT Recognition(const(SPRECORESULTINFO)* pResultInfo);
    HRESULT AddEvent(const(SPEVENT)* pEvent, SPRECOCONTEXTHANDLE hSAPIRecoContext);
    HRESULT Synchronize(ulong ullProcessedThruPos);
    HRESULT GetWordInfo(SPWORDENTRY* pWordEntry, SPWORDINFOOPT Options);
    HRESULT SetWordClientContext(SPWORDHANDLE hWord, void* pvClientContext);
    HRESULT GetRuleInfo(SPRULEENTRY* pRuleEntry, SPRULEINFOOPT Options);
    HRESULT SetRuleClientContext(SPRULEHANDLE hRule, void* pvClientContext);
    HRESULT GetStateInfo(SPSTATEHANDLE hState, SPSTATEINFO* pStateInfo);
    HRESULT GetResource(SPRULEHANDLE hRule, const(PWSTR) pszResourceName, PWSTR* ppCoMemResource);
    HRESULT GetTransitionProperty(SPTRANSITIONID ID, SPTRANSITIONPROPERTY** ppCoMemProperty);
    HRESULT IsAlternate(SPRULEHANDLE hRule, SPRULEHANDLE hAltRule);
    HRESULT GetMaxAlternates(SPRULEHANDLE hRule, uint* pulNumAlts);
    HRESULT GetContextMaxAlternates(SPRECOCONTEXTHANDLE hContext, uint* pulNumAlts);
    HRESULT UpdateRecoPos(ulong ullCurrentRecoPos);
}

@GUID("7bc6e012-684a-493e-bdd4-2bf5fbf48cfe")
interface ISpSREngineSite2 : ISpSREngineSite
{
    HRESULT AddEventEx(const(SPEVENTEX)* pEvent, SPRECOCONTEXTHANDLE hSAPIRecoContext);
    HRESULT UpdateRecoPosEx(ulong ullCurrentRecoPos, ulong ullCurrentRecoTime);
    HRESULT GetRuleTransition(uint ulGrammarID, uint RuleIndex, SPTRANSITIONENTRY* pTrans);
    HRESULT RecognitionEx(const(SPRECORESULTINFOEX)* pResultInfo);
}

@GUID("2f472991-854b-4465-b613-fbafb3ad8ed8")
interface ISpSREngine : IUnknown
{
    HRESULT SetSite(ISpSREngineSite pSite);
    HRESULT GetInputAudioFormat(const(GUID)* pguidSourceFormatId, const(WAVEFORMATEX)* pSourceWaveFormatEx, 
                                GUID* pguidDesiredFormatId, WAVEFORMATEX** ppCoMemDesiredWaveFormatEx);
    HRESULT RecognizeStream(const(GUID)* rguidFmtId, const(WAVEFORMATEX)* pWaveFormatEx, HANDLE hRequestSync, 
                            HANDLE hDataAvailable, HANDLE hExit, BOOL fNewAudioStream, BOOL fRealTimeAudio, 
                            ISpObjectToken pAudioObjectToken);
    HRESULT SetRecoProfile(ISpObjectToken pProfile);
    HRESULT OnCreateGrammar(void* pvEngineRecoContext, SPGRAMMARHANDLE hSAPIGrammar, 
                            void** ppvEngineGrammarContext);
    HRESULT OnDeleteGrammar(void* pvEngineGrammar);
    HRESULT LoadProprietaryGrammar(void* pvEngineGrammar, const(GUID)* rguidParam, const(PWSTR) pszStringParam, 
                                   const(void)* pvDataParam, uint ulDataSize, SPLOADOPTIONS Options);
    HRESULT UnloadProprietaryGrammar(void* pvEngineGrammar);
    HRESULT SetProprietaryRuleState(void* pvEngineGrammar, const(PWSTR) pszName, void* pReserved, 
                                    SPRULESTATE NewState, uint* pcRulesChanged);
    HRESULT SetProprietaryRuleIdState(void* pvEngineGrammar, uint dwRuleId, SPRULESTATE NewState);
    HRESULT LoadSLM(void* pvEngineGrammar, const(PWSTR) pszTopicName);
    HRESULT UnloadSLM(void* pvEngineGrammar);
    HRESULT SetSLMState(void* pvEngineGrammar, SPRULESTATE NewState);
    HRESULT SetWordSequenceData(void* pvEngineGrammar, const(PWSTR) pText, uint cchText, 
                                const(SPTEXTSELECTIONINFO)* pInfo);
    HRESULT SetTextSelection(void* pvEngineGrammar, const(SPTEXTSELECTIONINFO)* pInfo);
    HRESULT IsPronounceable(void* pvEngineGrammar, const(PWSTR) pszWord, SPWORDPRONOUNCEABLE* pWordPronounceable);
    HRESULT OnCreateRecoContext(SPRECOCONTEXTHANDLE hSAPIRecoContext, void** ppvEngineContext);
    HRESULT OnDeleteRecoContext(void* pvEngineContext);
    HRESULT PrivateCall(void* pvEngineContext, void* pCallFrame, uint ulCallFrameSize);
    HRESULT SetAdaptationData(void* pvEngineContext, const(PWSTR) pAdaptationData, const(uint) cch);
    HRESULT SetPropertyNum(SPPROPSRC eSrc, void* pvSrcObj, const(PWSTR) pName, int lValue);
    HRESULT GetPropertyNum(SPPROPSRC eSrc, void* pvSrcObj, const(PWSTR) pName, int* lValue);
    HRESULT SetPropertyString(SPPROPSRC eSrc, void* pvSrcObj, const(PWSTR) pName, const(PWSTR) pValue);
    HRESULT GetPropertyString(SPPROPSRC eSrc, void* pvSrcObj, const(PWSTR) pName, PWSTR* ppCoMemValue);
    HRESULT SetGrammarState(void* pvEngineGrammar, SPGRAMMARSTATE eGrammarState);
    HRESULT WordNotify(SPCFGNOTIFY Action, uint cWords, const(SPWORDENTRY)* pWords);
    HRESULT RuleNotify(SPCFGNOTIFY Action, uint cRules, const(SPRULEENTRY)* pRules);
    HRESULT PrivateCallEx(void* pvEngineContext, const(void)* pInCallFrame, uint ulInCallFrameSize, 
                          void** ppvCoMemResponse, uint* pulResponseSize);
    HRESULT SetContextState(void* pvEngineContext, SPCONTEXTSTATE eContextState);
}

@GUID("7ba627d8-33f9-4375-90c5-9985aee5ede5")
interface ISpSREngine2 : ISpSREngine
{
    HRESULT PrivateCallImmediate(void* pvEngineContext, const(void)* pInCallFrame, uint ulInCallFrameSize, 
                                 void** ppvCoMemResponse, uint* pulResponseSize);
    HRESULT SetAdaptationData2(void* pvEngineContext, const(PWSTR) pAdaptationData, const(uint) cch, 
                               const(PWSTR) pTopicName, SPADAPTATIONSETTINGS eSettings, 
                               SPADAPTATIONRELEVANCE eRelevance);
    HRESULT SetGrammarPrefix(void* pvEngineGrammar, const(PWSTR) pszPrefix, BOOL fIsPrefixRequired);
    HRESULT SetRulePriority(SPRULEHANDLE hRule, void* pvClientRuleContext, int nRulePriority);
    HRESULT EmulateRecognition(ISpPhrase pPhrase, uint dwCompareFlags);
    HRESULT SetSLMWeight(void* pvEngineGrammar, float flWeight);
    HRESULT SetRuleWeight(SPRULEHANDLE hRule, void* pvClientRuleContext, float flWeight);
    HRESULT SetTrainingState(BOOL fDoingTraining, BOOL fAdaptFromTrainingData);
    HRESULT ResetAcousticModelAdaptation();
    HRESULT OnLoadCFG(void* pvEngineGrammar, const(SPBINARYGRAMMAR)* pGrammarData, uint ulGrammarID);
    HRESULT OnUnloadCFG(void* pvEngineGrammar, uint ulGrammarID);
}

@GUID("fece8294-2be1-408f-8e68-2de377092f0e")
interface ISpSRAlternates : IUnknown
{
    HRESULT GetAlternates(SPPHRASEALTREQUEST* pAltRequest, SPPHRASEALT** ppAlts, uint* pcAlts);
    HRESULT Commit(SPPHRASEALTREQUEST* pAltRequest, SPPHRASEALT* pAlt, void** ppvResultExtra, uint* pcbResultExtra);
}

@GUID("f338f437-cb33-4020-9cab-c71ff9ce12d3")
interface ISpSRAlternates2 : ISpSRAlternates
{
    HRESULT CommitText(SPPHRASEALTREQUEST* pAltRequest, const(PWSTR) pcszNewText, SPCOMMITFLAGS commitFlags);
}

@GUID("8e7c791e-4467-11d3-9723-00c04f72db08")
interface _ISpPrivateEngineCall : IUnknown
{
    HRESULT CallEngine(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pCallFrame, 
                       uint ulCallFrameSize);
    HRESULT CallEngineEx(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pInFrame, 
                         uint ulInFrameSize, void** ppCoMemOutFrame, uint* pulOutFrameSize);
}

@GUID("defd682a-fe0a-42b9-bfa1-56d3d6cecfaf")
interface ISpPrivateEngineCallEx : IUnknown
{
    HRESULT CallEngineSynchronize(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pInFrame, 
                                  uint ulInFrameSize, void** ppCoMemOutFrame, uint* pulOutFrameSize);
    HRESULT CallEngineImmediate(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pInFrame, 
                                uint ulInFrameSize, void** ppCoMemOutFrame, uint* pulOutFrameSize);
}


// GUIDs

const GUID CLSID_SpAudioFormat               = GUIDOF!SpAudioFormat;
const GUID CLSID_SpCompressedLexicon         = GUIDOF!SpCompressedLexicon;
const GUID CLSID_SpCustomStream              = GUIDOF!SpCustomStream;
const GUID CLSID_SpDataKey                   = GUIDOF!SpDataKey;
const GUID CLSID_SpFileStream                = GUIDOF!SpFileStream;
const GUID CLSID_SpGramCompBackend           = GUIDOF!SpGramCompBackend;
const GUID CLSID_SpGrammarCompiler           = GUIDOF!SpGrammarCompiler;
const GUID CLSID_SpITNProcessor              = GUIDOF!SpITNProcessor;
const GUID CLSID_SpInProcRecoContext         = GUIDOF!SpInProcRecoContext;
const GUID CLSID_SpInprocRecognizer          = GUIDOF!SpInprocRecognizer;
const GUID CLSID_SpLexicon                   = GUIDOF!SpLexicon;
const GUID CLSID_SpMMAudioEnum               = GUIDOF!SpMMAudioEnum;
const GUID CLSID_SpMMAudioIn                 = GUIDOF!SpMMAudioIn;
const GUID CLSID_SpMMAudioOut                = GUIDOF!SpMMAudioOut;
const GUID CLSID_SpMemoryStream              = GUIDOF!SpMemoryStream;
const GUID CLSID_SpNotifyTranslator          = GUIDOF!SpNotifyTranslator;
const GUID CLSID_SpNullPhoneConverter        = GUIDOF!SpNullPhoneConverter;
const GUID CLSID_SpObjectToken               = GUIDOF!SpObjectToken;
const GUID CLSID_SpObjectTokenCategory       = GUIDOF!SpObjectTokenCategory;
const GUID CLSID_SpObjectTokenEnum           = GUIDOF!SpObjectTokenEnum;
const GUID CLSID_SpPhoneConverter            = GUIDOF!SpPhoneConverter;
const GUID CLSID_SpPhoneticAlphabetConverter = GUIDOF!SpPhoneticAlphabetConverter;
const GUID CLSID_SpPhraseBuilder             = GUIDOF!SpPhraseBuilder;
const GUID CLSID_SpPhraseInfoBuilder         = GUIDOF!SpPhraseInfoBuilder;
const GUID CLSID_SpResourceManager           = GUIDOF!SpResourceManager;
const GUID CLSID_SpSharedRecoContext         = GUIDOF!SpSharedRecoContext;
const GUID CLSID_SpSharedRecognizer          = GUIDOF!SpSharedRecognizer;
const GUID CLSID_SpShortcut                  = GUIDOF!SpShortcut;
const GUID CLSID_SpStream                    = GUIDOF!SpStream;
const GUID CLSID_SpStreamFormatConverter     = GUIDOF!SpStreamFormatConverter;
const GUID CLSID_SpTextSelectionInformation  = GUIDOF!SpTextSelectionInformation;
const GUID CLSID_SpUnCompressedLexicon       = GUIDOF!SpUnCompressedLexicon;
const GUID CLSID_SpVoice                     = GUIDOF!SpVoice;
const GUID CLSID_SpW3CGrammarCompiler        = GUIDOF!SpW3CGrammarCompiler;
const GUID CLSID_SpWaveFormatEx              = GUIDOF!SpWaveFormatEx;

const GUID IID_IEnumSpObjectTokens                = GUIDOF!IEnumSpObjectTokens;
const GUID IID_ISpAudio                           = GUIDOF!ISpAudio;
const GUID IID_ISpCFGInterpreter                  = GUIDOF!ISpCFGInterpreter;
const GUID IID_ISpCFGInterpreterSite              = GUIDOF!ISpCFGInterpreterSite;
const GUID IID_ISpContainerLexicon                = GUIDOF!ISpContainerLexicon;
const GUID IID_ISpDataKey                         = GUIDOF!ISpDataKey;
const GUID IID_ISpDisplayAlternates               = GUIDOF!ISpDisplayAlternates;
const GUID IID_ISpEnginePronunciation             = GUIDOF!ISpEnginePronunciation;
const GUID IID_ISpErrorLog                        = GUIDOF!ISpErrorLog;
const GUID IID_ISpEventSink                       = GUIDOF!ISpEventSink;
const GUID IID_ISpEventSource                     = GUIDOF!ISpEventSource;
const GUID IID_ISpEventSource2                    = GUIDOF!ISpEventSource2;
const GUID IID_ISpGramCompBackend                 = GUIDOF!ISpGramCompBackend;
const GUID IID_ISpGrammarBuilder                  = GUIDOF!ISpGrammarBuilder;
const GUID IID_ISpGrammarBuilder2                 = GUIDOF!ISpGrammarBuilder2;
const GUID IID_ISpGrammarCompiler                 = GUIDOF!ISpGrammarCompiler;
const GUID IID_ISpITNProcessor                    = GUIDOF!ISpITNProcessor;
const GUID IID_ISpLexicon                         = GUIDOF!ISpLexicon;
const GUID IID_ISpMMSysAudio                      = GUIDOF!ISpMMSysAudio;
const GUID IID_ISpNotifySink                      = GUIDOF!ISpNotifySink;
const GUID IID_ISpNotifySource                    = GUIDOF!ISpNotifySource;
const GUID IID_ISpNotifyTranslator                = GUIDOF!ISpNotifyTranslator;
const GUID IID_ISpObjectToken                     = GUIDOF!ISpObjectToken;
const GUID IID_ISpObjectTokenCategory             = GUIDOF!ISpObjectTokenCategory;
const GUID IID_ISpObjectTokenEnumBuilder          = GUIDOF!ISpObjectTokenEnumBuilder;
const GUID IID_ISpObjectTokenInit                 = GUIDOF!ISpObjectTokenInit;
const GUID IID_ISpObjectWithToken                 = GUIDOF!ISpObjectWithToken;
const GUID IID_ISpPhoneConverter                  = GUIDOF!ISpPhoneConverter;
const GUID IID_ISpPhoneticAlphabetConverter       = GUIDOF!ISpPhoneticAlphabetConverter;
const GUID IID_ISpPhoneticAlphabetSelection       = GUIDOF!ISpPhoneticAlphabetSelection;
const GUID IID_ISpPhrase                          = GUIDOF!ISpPhrase;
const GUID IID_ISpPhrase2                         = GUIDOF!ISpPhrase2;
const GUID IID_ISpPhraseAlt                       = GUIDOF!ISpPhraseAlt;
const GUID IID_ISpPhraseBuilder                   = GUIDOF!ISpPhraseBuilder;
const GUID IID_ISpPrivateEngineCallEx             = GUIDOF!ISpPrivateEngineCallEx;
const GUID IID_ISpProperties                      = GUIDOF!ISpProperties;
const GUID IID_ISpRecoContext                     = GUIDOF!ISpRecoContext;
const GUID IID_ISpRecoContext2                    = GUIDOF!ISpRecoContext2;
const GUID IID_ISpRecoGrammar                     = GUIDOF!ISpRecoGrammar;
const GUID IID_ISpRecoGrammar2                    = GUIDOF!ISpRecoGrammar2;
const GUID IID_ISpRecoResult                      = GUIDOF!ISpRecoResult;
const GUID IID_ISpRecoResult2                     = GUIDOF!ISpRecoResult2;
const GUID IID_ISpRecognizer                      = GUIDOF!ISpRecognizer;
const GUID IID_ISpRecognizer2                     = GUIDOF!ISpRecognizer2;
const GUID IID_ISpRegDataKey                      = GUIDOF!ISpRegDataKey;
const GUID IID_ISpResourceManager                 = GUIDOF!ISpResourceManager;
const GUID IID_ISpSRAlternates                    = GUIDOF!ISpSRAlternates;
const GUID IID_ISpSRAlternates2                   = GUIDOF!ISpSRAlternates2;
const GUID IID_ISpSREngine                        = GUIDOF!ISpSREngine;
const GUID IID_ISpSREngine2                       = GUIDOF!ISpSREngine2;
const GUID IID_ISpSREngineSite                    = GUIDOF!ISpSREngineSite;
const GUID IID_ISpSREngineSite2                   = GUIDOF!ISpSREngineSite2;
const GUID IID_ISpSerializeState                  = GUIDOF!ISpSerializeState;
const GUID IID_ISpShortcut                        = GUIDOF!ISpShortcut;
const GUID IID_ISpStream                          = GUIDOF!ISpStream;
const GUID IID_ISpStreamFormat                    = GUIDOF!ISpStreamFormat;
const GUID IID_ISpStreamFormatConverter           = GUIDOF!ISpStreamFormatConverter;
const GUID IID_ISpTTSEngine                       = GUIDOF!ISpTTSEngine;
const GUID IID_ISpTTSEngineSite                   = GUIDOF!ISpTTSEngineSite;
const GUID IID_ISpTaskManager                     = GUIDOF!ISpTaskManager;
const GUID IID_ISpThreadControl                   = GUIDOF!ISpThreadControl;
const GUID IID_ISpTokenUI                         = GUIDOF!ISpTokenUI;
const GUID IID_ISpTranscript                      = GUIDOF!ISpTranscript;
const GUID IID_ISpVoice                           = GUIDOF!ISpVoice;
const GUID IID_ISpXMLRecoResult                   = GUIDOF!ISpXMLRecoResult;
const GUID IID_ISpeechAudio                       = GUIDOF!ISpeechAudio;
const GUID IID_ISpeechAudioBufferInfo             = GUIDOF!ISpeechAudioBufferInfo;
const GUID IID_ISpeechAudioFormat                 = GUIDOF!ISpeechAudioFormat;
const GUID IID_ISpeechAudioStatus                 = GUIDOF!ISpeechAudioStatus;
const GUID IID_ISpeechBaseStream                  = GUIDOF!ISpeechBaseStream;
const GUID IID_ISpeechCustomStream                = GUIDOF!ISpeechCustomStream;
const GUID IID_ISpeechDataKey                     = GUIDOF!ISpeechDataKey;
const GUID IID_ISpeechFileStream                  = GUIDOF!ISpeechFileStream;
const GUID IID_ISpeechGrammarRule                 = GUIDOF!ISpeechGrammarRule;
const GUID IID_ISpeechGrammarRuleState            = GUIDOF!ISpeechGrammarRuleState;
const GUID IID_ISpeechGrammarRuleStateTransition  = GUIDOF!ISpeechGrammarRuleStateTransition;
const GUID IID_ISpeechGrammarRuleStateTransitions = GUIDOF!ISpeechGrammarRuleStateTransitions;
const GUID IID_ISpeechGrammarRules                = GUIDOF!ISpeechGrammarRules;
const GUID IID_ISpeechLexicon                     = GUIDOF!ISpeechLexicon;
const GUID IID_ISpeechLexiconPronunciation        = GUIDOF!ISpeechLexiconPronunciation;
const GUID IID_ISpeechLexiconPronunciations       = GUIDOF!ISpeechLexiconPronunciations;
const GUID IID_ISpeechLexiconWord                 = GUIDOF!ISpeechLexiconWord;
const GUID IID_ISpeechLexiconWords                = GUIDOF!ISpeechLexiconWords;
const GUID IID_ISpeechMMSysAudio                  = GUIDOF!ISpeechMMSysAudio;
const GUID IID_ISpeechMemoryStream                = GUIDOF!ISpeechMemoryStream;
const GUID IID_ISpeechObjectToken                 = GUIDOF!ISpeechObjectToken;
const GUID IID_ISpeechObjectTokenCategory         = GUIDOF!ISpeechObjectTokenCategory;
const GUID IID_ISpeechObjectTokens                = GUIDOF!ISpeechObjectTokens;
const GUID IID_ISpeechPhoneConverter              = GUIDOF!ISpeechPhoneConverter;
const GUID IID_ISpeechPhraseAlternate             = GUIDOF!ISpeechPhraseAlternate;
const GUID IID_ISpeechPhraseAlternates            = GUIDOF!ISpeechPhraseAlternates;
const GUID IID_ISpeechPhraseElement               = GUIDOF!ISpeechPhraseElement;
const GUID IID_ISpeechPhraseElements              = GUIDOF!ISpeechPhraseElements;
const GUID IID_ISpeechPhraseInfo                  = GUIDOF!ISpeechPhraseInfo;
const GUID IID_ISpeechPhraseInfoBuilder           = GUIDOF!ISpeechPhraseInfoBuilder;
const GUID IID_ISpeechPhraseProperties            = GUIDOF!ISpeechPhraseProperties;
const GUID IID_ISpeechPhraseProperty              = GUIDOF!ISpeechPhraseProperty;
const GUID IID_ISpeechPhraseReplacement           = GUIDOF!ISpeechPhraseReplacement;
const GUID IID_ISpeechPhraseReplacements          = GUIDOF!ISpeechPhraseReplacements;
const GUID IID_ISpeechPhraseRule                  = GUIDOF!ISpeechPhraseRule;
const GUID IID_ISpeechPhraseRules                 = GUIDOF!ISpeechPhraseRules;
const GUID IID_ISpeechRecoContext                 = GUIDOF!ISpeechRecoContext;
const GUID IID_ISpeechRecoGrammar                 = GUIDOF!ISpeechRecoGrammar;
const GUID IID_ISpeechRecoResult                  = GUIDOF!ISpeechRecoResult;
const GUID IID_ISpeechRecoResult2                 = GUIDOF!ISpeechRecoResult2;
const GUID IID_ISpeechRecoResultDispatch          = GUIDOF!ISpeechRecoResultDispatch;
const GUID IID_ISpeechRecoResultTimes             = GUIDOF!ISpeechRecoResultTimes;
const GUID IID_ISpeechRecognizer                  = GUIDOF!ISpeechRecognizer;
const GUID IID_ISpeechRecognizerStatus            = GUIDOF!ISpeechRecognizerStatus;
const GUID IID_ISpeechResourceLoader              = GUIDOF!ISpeechResourceLoader;
const GUID IID_ISpeechTextSelectionInformation    = GUIDOF!ISpeechTextSelectionInformation;
const GUID IID_ISpeechVoice                       = GUIDOF!ISpeechVoice;
const GUID IID_ISpeechVoiceStatus                 = GUIDOF!ISpeechVoiceStatus;
const GUID IID_ISpeechWaveFormatEx                = GUIDOF!ISpeechWaveFormatEx;
const GUID IID_ISpeechXMLRecoResult               = GUIDOF!ISpeechXMLRecoResult;
const GUID IID__ISpPrivateEngineCall              = GUIDOF!_ISpPrivateEngineCall;
const GUID IID__ISpeechRecoContextEvents          = GUIDOF!_ISpeechRecoContextEvents;
const GUID IID__ISpeechVoiceEvents                = GUIDOF!_ISpeechVoiceEvents;
