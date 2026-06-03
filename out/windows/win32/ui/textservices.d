// Written in the D programming language.

module windows.win32.ui.textservices;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, COLORREF, HANDLE, HRESULT, HWND,
                                         LPARAM, POINT, PWSTR, RECT, SIZE, WPARAM;
public import windows.win32.graphics.gdi : HBITMAP;
public import windows.win32.system.com : FORMATETC, IDataObject, IEnumGUID, IEnumString,
                                         IEnumUnknown, IStream, IUnknown;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.input.keyboardandmouse : HKL;
public import windows.win32.ui.windowsandmessaging : HICON, MSG;

extern(Windows) @nogc nothrow:


// Enums


alias LANG_BAR_ITEM_ICON_MODE_FLAGS = uint;
enum : uint
{
    TF_DTLBI_NONE           = 0x00000000U,
    TF_DTLBI_USEPROFILEICON = 0x00000001U,
}

alias TEXT_STORE_TEXT_CHANGE_FLAGS = uint;
enum : uint
{
    TS_ST_NONE       = 0x00000000U,
    TS_ST_CORRECTION = 0x00000001U,
}

alias TEXT_STORE_CHANGE_FLAGS = uint;
enum : uint
{
    TS_TC_NONE       = 0x00000000U,
    TS_TC_CORRECTION = 0x00000001U,
}

alias INSERT_TEXT_AT_SELECTION_FLAGS = uint;
enum : uint
{
    TF_IAS_NOQUERY                = 0x00000001U,
    TF_IAS_QUERYONLY              = 0x00000002U,
    TF_IAS_NO_DEFAULT_COMPOSITION = 0x80000000U,
}

alias ANCHOR_CHANGE_HISTORY_FLAGS = uint;
enum : uint
{
    TS_CH_PRECEDING_DEL = 0x00000001U,
    TS_CH_FOLLOWING_DEL = 0x00000002U,
}

alias TEXT_STORE_LOCK_FLAGS = uint;
enum : uint
{
    TS_LF_READ      = 0x00000002U,
    TS_LF_READWRITE = 0x00000006U,
}

alias GET_TEXT_AND_PROPERTY_UPDATES_FLAGS = uint;
enum : uint
{
    TF_GTP_NONE      = 0x00000000U,
    TF_GTP_INCL_TEXT = 0x00000001U,
}

alias TF_CONTEXT_EDIT_CONTEXT_FLAGS = uint;
enum : uint
{
    TF_ES_ASYNCDONTCARE = 0x00000000U,
    TF_ES_SYNC          = 0x00000001U,
    TF_ES_READ          = 0x00000002U,
    TF_ES_READWRITE     = 0x00000006U,
    TF_ES_ASYNC         = 0x00000008U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/ne-textstor-tsactiveselend
enum TsActiveSelEnd : int
{
    TS_AE_NONE  = 0x00000000,
    TS_AE_START = 0x00000001,
    TS_AE_END   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/ne-textstor-tslayoutcode
enum TsLayoutCode : int
{
    TS_LC_CREATE  = 0x00000000,
    TS_LC_CHANGE  = 0x00000001,
    TS_LC_DESTROY = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/ne-textstor-tsruntype
enum TsRunType : int
{
    TS_RT_PLAIN  = 0x00000000,
    TS_RT_HIDDEN = 0x00000001,
    TS_RT_OPAQUE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/ne-textstor-tsgravity
enum TsGravity : int
{
    TS_GR_BACKWARD = 0x00000000,
    TS_GR_FORWARD  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/ne-textstor-tsshiftdir
enum TsShiftDir : int
{
    TS_SD_BACKWARD = 0x00000000,
    TS_SD_FORWARD  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/ne-ctfutb-tflbiclick
alias TfLBIClick = int;
enum : int
{
    TF_LBI_CLK_RIGHT = 0x00000001,
    TF_LBI_CLK_LEFT  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/ne-ctfutb-tflbballoonstyle
enum TfLBBalloonStyle : int
{
    TF_LB_BALLOON_RECO = 0x00000000,
    TF_LB_BALLOON_SHOW = 0x00000001,
    TF_LB_BALLOON_MISS = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/ne-msctf-tfanchor
enum TfAnchor : int
{
    TF_ANCHOR_START = 0x00000000,
    TF_ANCHOR_END   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/ne-msctf-tfactiveselend
enum TfActiveSelEnd : int
{
    TF_AE_NONE  = 0x00000000,
    TF_AE_START = 0x00000001,
    TF_AE_END   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/ne-msctf-tflayoutcode
enum TfLayoutCode : int
{
    TF_LC_CREATE  = 0x00000000,
    TF_LC_CHANGE  = 0x00000001,
    TF_LC_DESTROY = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/ne-msctf-tfgravity
enum TfGravity : int
{
    TF_GRAVITY_BACKWARD = 0x00000000,
    TF_GRAVITY_FORWARD  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/ne-msctf-tfshiftdir
enum TfShiftDir : int
{
    TF_SD_BACKWARD = 0x00000000,
    TF_SD_FORWARD  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/ne-msctf-tf_da_linestyle
alias TF_DA_LINESTYLE = int;
enum : int
{
    TF_LS_NONE     = 0x00000000,
    TF_LS_SOLID    = 0x00000001,
    TF_LS_DOT      = 0x00000002,
    TF_LS_DASH     = 0x00000003,
    TF_LS_SQUIGGLE = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/ne-msctf-tf_da_colortype
alias TF_DA_COLORTYPE = int;
enum : int
{
    TF_CT_NONE     = 0x00000000,
    TF_CT_SYSCOLOR = 0x00000001,
    TF_CT_COLORREF = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/ne-msctf-tf_da_attr_info
alias TF_DA_ATTR_INFO = int;
enum : int
{
    TF_ATTR_INPUT               = 0x00000000,
    TF_ATTR_TARGET_CONVERTED    = 0x00000001,
    TF_ATTR_CONVERTED           = 0x00000002,
    TF_ATTR_TARGET_NOTCONVERTED = 0x00000003,
    TF_ATTR_INPUT_ERROR         = 0x00000004,
    TF_ATTR_FIXEDCONVERTED      = 0x00000005,
    TF_ATTR_OTHER               = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/ne-ctffunc-tfcandidateresult
enum TfCandidateResult : int
{
    CAND_FINALIZED = 0x00000000,
    CAND_SELECTED  = 0x00000001,
    CAND_CANCELED  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/ne-ctffunc-tfsapiobject
enum TfSapiObject : int
{
    GETIF_RESMGR           = 0x00000000,
    GETIF_RECOCONTEXT      = 0x00000001,
    GETIF_RECOGNIZER       = 0x00000002,
    GETIF_VOICE            = 0x00000003,
    GETIF_DICTGRAM         = 0x00000004,
    GETIF_RECOGNIZERNOINIT = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/ne-ctffunc-tfintegratablecandidatelistselectionstyle
enum TfIntegratableCandidateListSelectionStyle : int
{
    STYLE_ACTIVE_SELECTION  = 0x00000000,
    STYLE_IMPLIED_SELECTION = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/ne-ctffunc-tkblayouttype
enum TKBLayoutType : int
{
    TKBLT_UNDEFINED = 0x00000000,
    TKBLT_CLASSIC   = 0x00000001,
    TKBLT_OPTIMIZED = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inputscope/ne-inputscope-inputscope
enum InputScope : int
{
    IS_DEFAULT                       = 0x00000000,
    IS_URL                           = 0x00000001,
    IS_FILE_FULLFILEPATH             = 0x00000002,
    IS_FILE_FILENAME                 = 0x00000003,
    IS_EMAIL_USERNAME                = 0x00000004,
    IS_EMAIL_SMTPEMAILADDRESS        = 0x00000005,
    IS_LOGINNAME                     = 0x00000006,
    IS_PERSONALNAME_FULLNAME         = 0x00000007,
    IS_PERSONALNAME_PREFIX           = 0x00000008,
    IS_PERSONALNAME_GIVENNAME        = 0x00000009,
    IS_PERSONALNAME_MIDDLENAME       = 0x0000000a,
    IS_PERSONALNAME_SURNAME          = 0x0000000b,
    IS_PERSONALNAME_SUFFIX           = 0x0000000c,
    IS_ADDRESS_FULLPOSTALADDRESS     = 0x0000000d,
    IS_ADDRESS_POSTALCODE            = 0x0000000e,
    IS_ADDRESS_STREET                = 0x0000000f,
    IS_ADDRESS_STATEORPROVINCE       = 0x00000010,
    IS_ADDRESS_CITY                  = 0x00000011,
    IS_ADDRESS_COUNTRYNAME           = 0x00000012,
    IS_ADDRESS_COUNTRYSHORTNAME      = 0x00000013,
    IS_CURRENCY_AMOUNTANDSYMBOL      = 0x00000014,
    IS_CURRENCY_AMOUNT               = 0x00000015,
    IS_DATE_FULLDATE                 = 0x00000016,
    IS_DATE_MONTH                    = 0x00000017,
    IS_DATE_DAY                      = 0x00000018,
    IS_DATE_YEAR                     = 0x00000019,
    IS_DATE_MONTHNAME                = 0x0000001a,
    IS_DATE_DAYNAME                  = 0x0000001b,
    IS_DIGITS                        = 0x0000001c,
    IS_NUMBER                        = 0x0000001d,
    IS_ONECHAR                       = 0x0000001e,
    IS_PASSWORD                      = 0x0000001f,
    IS_TELEPHONE_FULLTELEPHONENUMBER = 0x00000020,
    IS_TELEPHONE_COUNTRYCODE         = 0x00000021,
    IS_TELEPHONE_AREACODE            = 0x00000022,
    IS_TELEPHONE_LOCALNUMBER         = 0x00000023,
    IS_TIME_FULLTIME                 = 0x00000024,
    IS_TIME_HOUR                     = 0x00000025,
    IS_TIME_MINORSEC                 = 0x00000026,
    IS_NUMBER_FULLWIDTH              = 0x00000027,
    IS_ALPHANUMERIC_HALFWIDTH        = 0x00000028,
    IS_ALPHANUMERIC_FULLWIDTH        = 0x00000029,
    IS_CURRENCY_CHINESE              = 0x0000002a,
    IS_BOPOMOFO                      = 0x0000002b,
    IS_HIRAGANA                      = 0x0000002c,
    IS_KATAKANA_HALFWIDTH            = 0x0000002d,
    IS_KATAKANA_FULLWIDTH            = 0x0000002e,
    IS_HANJA                         = 0x0000002f,
    IS_HANGUL_HALFWIDTH              = 0x00000030,
    IS_HANGUL_FULLWIDTH              = 0x00000031,
    IS_SEARCH                        = 0x00000032,
    IS_FORMULA                       = 0x00000033,
    IS_SEARCH_INCREMENTAL            = 0x00000034,
    IS_CHINESE_HALFWIDTH             = 0x00000035,
    IS_CHINESE_FULLWIDTH             = 0x00000036,
    IS_NATIVE_SCRIPT                 = 0x00000037,
    IS_YOMI                          = 0x00000038,
    IS_TEXT                          = 0x00000039,
    IS_CHAT                          = 0x0000003a,
    IS_NAME_OR_PHONENUMBER           = 0x0000003b,
    IS_EMAILNAME_OR_ADDRESS          = 0x0000003c,
    IS_PRIVATE                       = 0x0000003d,
    IS_MAPS                          = 0x0000003e,
    IS_NUMERIC_PASSWORD              = 0x0000003f,
    IS_NUMERIC_PIN                   = 0x00000040,
    IS_ALPHANUMERIC_PIN              = 0x00000041,
    IS_ALPHANUMERIC_PIN_SET          = 0x00000042,
    IS_FORMULA_NUMBER                = 0x00000043,
    IS_CHAT_WITHOUT_EMOJI            = 0x00000044,
    IS_PHRASELIST                    = 0xffffffff,
    IS_REGULAREXPRESSION             = 0xfffffffe,
    IS_SRGS                          = 0xfffffffd,
    IS_XML                           = 0xfffffffc,
    IS_ENUMSTRING                    = 0xfffffffb,
}

// Constants


enum : GUID
{
    GUID_PROP_TEXTOWNER      = GUID("f1e2d520-0969-11d3-8df0-00105a2799b5"),
    GUID_PROP_ATTRIBUTE      = GUID("34b45670-7526-11d2-a147-00105a2799b5"),
    GUID_PROP_LANGID         = GUID("3280ce20-8032-11d2-b603-00105a2799b5"),
    GUID_PROP_READING        = GUID("5463f7c0-8e31-11d2-bf46-00105a2799b5"),
    GUID_PROP_COMPOSING      = GUID("e12ac060-af15-11d2-afc5-00105a2799b5"),
    GUID_PROP_TKB_ALTERNATES = GUID("70b2a803-968d-462e-b93b-2164c91517f7"),
}

enum GUID GUID_SYSTEM_FUNCTIONPROVIDER = GUID("9a698bb0-0f21-11d3-8df1-00105a2799b5");
enum GUID GUID_APP_FUNCTIONPROVIDER = GUID("4caef01e-12af-4b0e-9db1-a6ec5b881208");

enum : GUID
{
    GUID_TFCAT_CATEGORY_OF_TIP = GUID("534c48c1-0607-4098-a521-4fc899c73e90"),
    GUID_TFCAT_TIP_KEYBOARD    = GUID("34745c63-b2f0-4784-8b67-5e12c8701a31"),
    GUID_TFCAT_TIP_SPEECH      = GUID("b5a73cd1-8355-426b-a161-259808f26b14"),
    GUID_TFCAT_TIP_HANDWRITING = GUID("246ecb87-c2f2-4abe-905b-c8b38add2c43"),
    GUID_TFCAT_PROP_AUDIODATA  = GUID("9b7be3a9-e8ab-4d47-a8fe-254fa423436d"),
    GUID_TFCAT_PROP_INKDATA    = GUID("7c6a82ae-b0d7-4f14-a745-14f28b009d61"),
}

enum : GUID
{
    GUID_COMPARTMENT_SAPI_AUDIO            = GUID("51af2086-cc6b-457d-b5aa-8b19dc290ab4"),
    GUID_COMPARTMENT_KEYBOARD_DISABLED     = GUID("71a5b253-1951-466b-9fbc-9c8808fa84f2"),
    GUID_COMPARTMENT_KEYBOARD_OPENCLOSE    = GUID("58273aad-01bb-4164-95c6-755ba0b5162d"),
    GUID_COMPARTMENT_HANDWRITING_OPENCLOSE = GUID("f9ae2c6b-1866-4361-af72-7aa30948890e"),
    GUID_COMPARTMENT_SPEECH_DISABLED       = GUID("56c5c607-0703-4e59-8e52-cbc84e8bbe35"),
    GUID_COMPARTMENT_SPEECH_OPENCLOSE      = GUID("544d6a63-e2e8-4752-bbd1-000960bca083"),
    GUID_COMPARTMENT_SPEECH_GLOBALSTATE    = GUID("2a54fe8e-0d08-460c-a75d-87035ff436c5"),
    GUID_COMPARTMENT_CONVERSIONMODEBIAS    = GUID("5497f516-ee91-436e-b946-aa2c05f1ac5b"),
}

enum GUID GUID_PROP_MODEBIAS = GUID("372e0716-974f-40ac-a088-08cdc92ebfbc");
enum GUID GUID_COMPARTMENT_KEYBOARD_INPUTMODE = GUID("b6592511-bcee-4122-a7c4-09f4b3fa4396");

enum : GUID
{
    GUID_MODEBIAS_NONE                  = GUID("00000000-0000-0000-0000-000000000000"),
    GUID_MODEBIAS_URLHISTORY            = GUID("8b0e54d9-63f2-4c68-84d4-79aee7a59f09"),
    GUID_MODEBIAS_FILENAME              = GUID("d7f707fe-44c6-4fca-8e76-86ab50c7931b"),
    GUID_MODEBIAS_READING               = GUID("e31643a3-6466-4cbf-8d8b-0bd4d8545461"),
    GUID_MODEBIAS_DATETIME              = GUID("f2bdb372-7f61-4039-92ef-1c35599f0222"),
    GUID_MODEBIAS_NAME                  = GUID("fddc10f0-d239-49bf-b8fc-5410caaa427e"),
    GUID_MODEBIAS_CONVERSATION          = GUID("0f4ec104-1790-443b-95f1-e10f939d6546"),
    GUID_MODEBIAS_NUMERIC               = GUID("4021766c-e872-48fd-9cee-4ec5c75e16c3"),
    GUID_MODEBIAS_HIRAGANA              = GUID("d73d316e-9b91-46f1-a280-31597f52c694"),
    GUID_MODEBIAS_KATAKANA              = GUID("2e0eeddd-3a1a-499e-8543-3c7ee7949811"),
    GUID_MODEBIAS_HANGUL                = GUID("76ef0541-23b3-4d77-a074-691801ccea17"),
    GUID_MODEBIAS_CHINESE               = GUID("7add26de-4328-489b-83ae-6493750cad5c"),
    GUID_MODEBIAS_HALFWIDTHKATAKANA     = GUID("005f6b63-78d4-41cc-8859-485ca821a795"),
    GUID_MODEBIAS_FULLWIDTHALPHANUMERIC = GUID("81489fb8-b36a-473d-8146-e4a2258b24ae"),
    GUID_MODEBIAS_FULLWIDTHHANGUL       = GUID("c01ae6c9-45b5-4fd0-9cb1-9f4cebc39fea"),
}

enum : GUID
{
    GUID_TFCAT_PROPSTYLE_STATIC         = GUID("565fb8d8-6bd4-4ca1-b223-0f2ccb8f4f96"),
    GUID_TFCAT_DISPLAYATTRIBUTEPROVIDER = GUID("046b8c80-1647-40f7-9b21-b93b81aabc1b"),
    GUID_TFCAT_DISPLAYATTRIBUTEPROPERTY = GUID("b95f181b-ea4c-4af1-8056-7c321abbb091"),
}

enum : GUID
{
    GUID_COMPARTMENT_SPEECH_UI_STATUS = GUID("d92016f0-9367-4fe7-9abf-bc59dacbe0e3"),
    GUID_COMPARTMENT_EMPTYCONTEXT     = GUID("d7487dbf-804e-41c5-894d-ad96fd4eea13"),
    GUID_COMPARTMENT_TIPUISTATUS      = GUID("148ca3ec-0366-401c-8d75-ed978d85fbc9"),
    GUID_COMPARTMENT_SPEECH_CFGMENU   = GUID("fb6c5c2d-4e83-4bb6-91a2-e019bff6762d"),
}

enum GUID GUID_LBI_SAPILAYR_CFGMENUBUTTON = GUID("d02f24a1-942d-422e-8d99-b4f2addee999");

enum : GUID
{
    GUID_TFCAT_TIPCAP_SECUREMODE           = GUID("49d2f9ce-1f5e-11d7-a6d3-00065b84435c"),
    GUID_TFCAT_TIPCAP_UIELEMENTENABLED     = GUID("49d2f9cf-1f5e-11d7-a6d3-00065b84435c"),
    GUID_TFCAT_TIPCAP_INPUTMODECOMPARTMENT = GUID("ccf05dd7-4a87-11d7-a6e2-00065b84435c"),
    GUID_TFCAT_TIPCAP_COMLESS              = GUID("364215d9-75bc-11d7-a6ef-00065b84435c"),
    GUID_TFCAT_TIPCAP_WOW16                = GUID("364215da-75bc-11d7-a6ef-00065b84435c"),
    GUID_TFCAT_TIPCAP_IMMERSIVESUPPORT     = GUID("13a016df-560b-46cd-947a-4c3af1e0e35d"),
    GUID_TFCAT_TIPCAP_IMMERSIVEONLY        = GUID("3a4259ac-640d-4ad4-89f7-1eb67e7c4ee8"),
    GUID_TFCAT_TIPCAP_LOCALSERVER          = GUID("74769ee9-4a66-4f9d-90d6-bf8b7c3eb461"),
    GUID_TFCAT_TIPCAP_TSF3                 = GUID("07dcb4af-98de-4548-bef7-25bd45979a1f"),
    GUID_TFCAT_TIPCAP_DUALMODE             = GUID("3af314a2-d79f-4b1b-9992-15086d339b05"),
    GUID_TFCAT_TIPCAP_SYSTRAYSUPPORT       = GUID("25504fb4-7bab-4bc1-9c69-cf81890f0ef5"),
}

enum : GUID
{
    GUID_COMPARTMENT_KEYBOARD_INPUTMODE_CONVERSION = GUID("ccf05dd8-4a87-11d7-a6e2-00065b84435c"),
    GUID_COMPARTMENT_KEYBOARD_INPUTMODE_SENTENCE   = GUID("ccf05dd9-4a87-11d7-a6e2-00065b84435c"),
}

enum : GUID
{
    GUID_COMPARTMENT_TRANSITORYEXTENSION                 = GUID("8be347f5-c7a0-11d7-b408-00065b84435c"),
    GUID_COMPARTMENT_TRANSITORYEXTENSION_DOCUMENTMANAGER = GUID("8be347f7-c7a0-11d7-b408-00065b84435c"),
    GUID_COMPARTMENT_TRANSITORYEXTENSION_PARENT          = GUID("8be347f8-c7a0-11d7-b408-00065b84435c"),
}

enum GUID GUID_COMPARTMENT_ENABLED_PROFILES_UPDATED = GUID("92c1fd48-a9ae-4a7c-be08-4329e4723817");
enum GUID GUID_TFCAT_TRANSITORYEXTENSIONUI = GUID("6302de22-a5cf-4b02-bfe8-4d72b2bed3c6");
enum GUID GUID_LBI_INPUTMODE = GUID("2c77a81e-41cc-4178-a3a7-5f8a987568e6");

enum : GUID
{
    CLSID_TF_ThreadMgr           = GUID("529a9e6b-6587-4f23-ab9e-9c7d683e3c50"),
    CLSID_TF_LangBarMgr          = GUID("ebb08c45-6c4a-4fdc-ae53-4eb8c4c7db8e"),
    CLSID_TF_DisplayAttributeMgr = GUID("3ce74de4-53d3-4d74-8b83-431b3828ba53"),
}

enum : GUID
{
    CLSID_TF_CategoryMgr            = GUID("a4b544a1-438d-4b41-9325-869523e2d6c7"),
    CLSID_TF_InputProcessorProfiles = GUID("33c53a50-f456-4884-b049-85fd643ecfed"),
}

enum GUID CLSID_TF_LangBarItemMgr = GUID("b9931692-a2b3-4fab-bf33-9ec6f9fb96ac");
enum GUID CLSID_TF_ClassicLangBar = GUID("3318360c-1afc-4d09-a86b-9f9cb6dceb9c");
enum GUID CLSID_TF_TransitoryExtensionUIEntry = GUID("ae6be008-07fb-400d-8beb-337a64f7051f");
enum GUID CLSID_TsfServices = GUID("39aedc00-6b60-46db-8d31-3642be0e4373");
enum uint TF_DEFAULT_SELECTION = 0xffffffffU;
enum uint TS_DEFAULT_SELECTION = 0xffffffffU;

enum : GUID
{
    GUID_TS_SERVICE_DATAOBJECT = GUID("6086fbb5-e225-46ce-a770-c1bbd3e05d7b"),
    GUID_TS_SERVICE_ACCESSIBLE = GUID("f9786200-a5bf-4a0f-8c24-fb16f5d1aabb"),
    GUID_TS_SERVICE_ACTIVEX    = GUID("ea937a50-c9a6-4b7d-894a-49d99b784834"),
}

enum HRESULT TS_E_INVALIDPOS = HRESULT(0x80040200);

enum : HRESULT
{
    TS_E_NOLOCK      = HRESULT(0x80040201),
    TS_E_NOOBJECT    = HRESULT(0x80040202),
    TS_E_NOSERVICE   = HRESULT(0x80040203),
    TS_E_NOINTERFACE = HRESULT(0x80040204),
    TS_E_NOSELECTION = HRESULT(0x80040205),
    TS_E_NOLAYOUT    = HRESULT(0x80040206),
}

enum HRESULT TS_E_INVALIDPOINT = HRESULT(0x80040207);
enum HRESULT TS_E_SYNCHRONOUS = HRESULT(0x80040208);
enum HRESULT TS_E_READONLY = HRESULT(0x80040209);
enum HRESULT TS_E_FORMAT = HRESULT(0x8004020a);
enum HRESULT TS_S_ASYNC = HRESULT(0x00040300);
enum uint TS_AS_TEXT_CHANGE = 0x00000001U;
enum uint TS_AS_SEL_CHANGE = 0x00000002U;
enum uint TS_AS_LAYOUT_CHANGE = 0x00000004U;
enum uint TS_AS_ATTR_CHANGE = 0x00000008U;
enum uint TS_AS_STATUS_CHANGE = 0x00000010U;
enum uint TS_LF_SYNC = 0x00000001U;

enum : uint
{
    TS_SD_READONLY             = 0x00000001U,
    TS_SD_LOADING              = 0x00000002U,
    TS_SD_RESERVED             = 0x00000004U,
    TS_SD_TKBAUTOCORRECTENABLE = 0x00000008U,
}

enum uint TS_SD_TKBPREDICTIONENABLE = 0x00000010U;
enum uint TS_SD_UIINTEGRATIONENABLE = 0x00000020U;
enum uint TS_SD_INPUTPANEMANUALDISPLAYENABLE = 0x00000040U;

enum : uint
{
    TS_SD_EMBEDDEDHANDWRITINGVIEW_ENABLED = 0x00000080U,
    TS_SD_EMBEDDEDHANDWRITINGVIEW_VISIBLE = 0x00000100U,
}

enum uint TS_SS_DISJOINTSEL = 0x00000001U;

enum : uint
{
    TS_SS_REGIONS    = 0x00000002U,
    TS_SS_TRANSITORY = 0x00000004U,
}

enum uint TS_SS_NOHIDDENTEXT = 0x00000008U;
enum uint TS_SS_TKBAUTOCORRECTENABLE = 0x00000010U;
enum uint TS_SS_TKBPREDICTIONENABLE = 0x00000020U;
enum uint TS_SS_UWPCONTROL = 0x00000040U;

enum : uint
{
    TS_IE_CORRECTION  = 0x00000001U,
    TS_IE_COMPOSITION = 0x00000002U,
}

enum : uint
{
    TS_IAS_NOQUERY   = 0x00000001U,
    TS_IAS_QUERYONLY = 0x00000002U,
}

enum uint GXFPF_ROUND_NEAREST = 0x00000001U;
enum uint GXFPF_NEAREST = 0x00000002U;

enum : uint
{
    TS_CHAR_EMBEDDED    = 0x0000fffcU,
    TS_CHAR_REGION      = 0x00000000U,
    TS_CHAR_REPLACEMENT = 0x0000fffdU,
}

enum : uint
{
    TS_ATTR_FIND_BACKWARDS   = 0x00000001U,
    TS_ATTR_FIND_WANT_OFFSET = 0x00000002U,
    TS_ATTR_FIND_UPDATESTART = 0x00000004U,
    TS_ATTR_FIND_WANT_VALUE  = 0x00000008U,
    TS_ATTR_FIND_WANT_END    = 0x00000010U,
    TS_ATTR_FIND_HIDDEN      = 0x00000020U,
}

enum uint TS_VCOOKIE_NUL = 0xffffffffU;

enum : uint
{
    TS_SHIFT_COUNT_HIDDEN = 0x00000001U,
    TS_SHIFT_HALT_HIDDEN  = 0x00000002U,
    TS_SHIFT_HALT_VISIBLE = 0x00000004U,
    TS_SHIFT_COUNT_ONLY   = 0x00000008U,
}

enum uint TS_GTA_HIDDEN = 0x00000001U;
enum uint TS_GEA_HIDDEN = 0x00000001U;

enum : HRESULT
{
    TF_E_LOCKED    = HRESULT(0x80040500),
    TF_E_STACKFULL = HRESULT(0x80040501),
}

enum HRESULT TF_E_NOTOWNEDRANGE = HRESULT(0x80040502);
enum HRESULT TF_E_NOPROVIDER = HRESULT(0x80040503);
enum HRESULT TF_E_DISCONNECTED = HRESULT(0x80040504);
enum HRESULT TF_E_INVALIDVIEW = HRESULT(0x80040505);
enum HRESULT TF_E_ALREADY_EXISTS = HRESULT(0x80040506);
enum HRESULT TF_E_RANGE_NOT_COVERED = HRESULT(0x80040507);
enum HRESULT TF_E_COMPOSITION_REJECTED = HRESULT(0x80040508);
enum HRESULT TF_E_EMPTYCONTEXT = HRESULT(0x80040509);
enum HRESULT TF_E_INVALIDPOS = HRESULT(0x80040200);

enum : HRESULT
{
    TF_E_NOLOCK      = HRESULT(0x80040201),
    TF_E_NOOBJECT    = HRESULT(0x80040202),
    TF_E_NOSERVICE   = HRESULT(0x80040203),
    TF_E_NOINTERFACE = HRESULT(0x80040204),
    TF_E_NOSELECTION = HRESULT(0x80040205),
    TF_E_NOLAYOUT    = HRESULT(0x80040206),
}

enum HRESULT TF_E_INVALIDPOINT = HRESULT(0x80040207);
enum HRESULT TF_E_SYNCHRONOUS = HRESULT(0x80040208);
enum HRESULT TF_E_READONLY = HRESULT(0x80040209);
enum HRESULT TF_E_FORMAT = HRESULT(0x8004020a);
enum HRESULT TF_S_ASYNC = HRESULT(0x00040300);

enum : uint
{
    TF_RCM_COMLESS             = 0x00000001U,
    TF_RCM_VKEY                = 0x00000002U,
    TF_RCM_HINT_READING_LENGTH = 0x00000004U,
    TF_RCM_HINT_COLLISION      = 0x00000008U,
}

enum : uint
{
    TKB_ALTERNATES_STANDARD               = 0x00000001U,
    TKB_ALTERNATES_FOR_AUTOCORRECTION     = 0x00000002U,
    TKB_ALTERNATES_FOR_PREDICTION         = 0x00000003U,
    TKB_ALTERNATES_AUTOCORRECTION_APPLIED = 0x00000004U,
}

enum uint TF_TMAE_NOACTIVATETIP = 0x00000001U;

enum : uint
{
    TF_TMAE_SECUREMODE           = 0x00000002U,
    TF_TMAE_UIELEMENTENABLEDONLY = 0x00000004U,
}

enum : uint
{
    TF_TMAE_COMLESS                  = 0x00000008U,
    TF_TMAE_WOW16                    = 0x00000010U,
    TF_TMAE_NOACTIVATEKEYBOARDLAYOUT = 0x00000020U,
}

enum uint TF_TMAE_CONSOLE = 0x00000040U;
enum uint TF_TMF_NOACTIVATETIP = 0x00000001U;

enum : uint
{
    TF_TMF_SECUREMODE           = 0x00000002U,
    TF_TMF_UIELEMENTENABLEDONLY = 0x00000004U,
}

enum : uint
{
    TF_TMF_COMLESS       = 0x00000008U,
    TF_TMF_WOW16         = 0x00000010U,
    TF_TMF_CONSOLE       = 0x00000040U,
    TF_TMF_IMMERSIVEMODE = 0x40000000U,
}

enum uint TF_TMF_ACTIVATED = 0x80000000U;

enum : uint
{
    TF_MOD_ALT                 = 0x00000001U,
    TF_MOD_CONTROL             = 0x00000002U,
    TF_MOD_SHIFT               = 0x00000004U,
    TF_MOD_RALT                = 0x00000008U,
    TF_MOD_RCONTROL            = 0x00000010U,
    TF_MOD_RSHIFT              = 0x00000020U,
    TF_MOD_LALT                = 0x00000040U,
    TF_MOD_LCONTROL            = 0x00000080U,
    TF_MOD_LSHIFT              = 0x00000100U,
    TF_MOD_ON_KEYUP            = 0x00000200U,
    TF_MOD_IGNORE_ALL_MODIFIER = 0x00000400U,
}

enum uint TF_US_HIDETIPUI = 0x00000001U;

enum : uint
{
    TF_DISABLE_SPEECH     = 0x00000001U,
    TF_DISABLE_DICTATION  = 0x00000002U,
    TF_DISABLE_COMMANDING = 0x00000004U,
}

enum const(wchar)* TF_PROCESS_ATOM = "_CTF_PROCESS_ATOM_";
enum const(wchar)* TF_ENABLE_PROCESS_ATOM = "_CTF_ENABLE_PROCESS_ATOM_";

enum : uint
{
    TF_CLUIE_DOCUMENTMGR = 0x00000001U,
    TF_CLUIE_COUNT       = 0x00000002U,
    TF_CLUIE_SELECTION   = 0x00000004U,
    TF_CLUIE_STRING      = 0x00000008U,
    TF_CLUIE_PAGEINDEX   = 0x00000010U,
    TF_CLUIE_CURRENTPAGE = 0x00000020U,
}

enum : uint
{
    TF_RIUIE_CONTEXT                = 0x00000001U,
    TF_RIUIE_STRING                 = 0x00000002U,
    TF_RIUIE_MAXREADINGSTRINGLENGTH = 0x00000004U,
}

enum : uint
{
    TF_RIUIE_ERRORINDEX    = 0x00000008U,
    TF_RIUIE_VERTICALORDER = 0x00000010U,
}

enum : uint
{
    TF_CONVERSIONMODE_ALPHANUMERIC = 0x00000000U,
    TF_CONVERSIONMODE_NATIVE       = 0x00000001U,
    TF_CONVERSIONMODE_KATAKANA     = 0x00000002U,
    TF_CONVERSIONMODE_FULLSHAPE    = 0x00000008U,
    TF_CONVERSIONMODE_ROMAN        = 0x00000010U,
    TF_CONVERSIONMODE_CHARCODE     = 0x00000020U,
    TF_CONVERSIONMODE_SOFTKEYBOARD = 0x00000080U,
    TF_CONVERSIONMODE_NOCONVERSION = 0x00000100U,
    TF_CONVERSIONMODE_EUDC         = 0x00000200U,
    TF_CONVERSIONMODE_SYMBOL       = 0x00000400U,
    TF_CONVERSIONMODE_FIXED        = 0x00000800U,
}

enum : uint
{
    TF_SENTENCEMODE_NONE          = 0x00000000U,
    TF_SENTENCEMODE_PLAURALCLAUSE = 0x00000001U,
    TF_SENTENCEMODE_SINGLECONVERT = 0x00000002U,
    TF_SENTENCEMODE_AUTOMATIC     = 0x00000004U,
    TF_SENTENCEMODE_PHRASEPREDICT = 0x00000008U,
    TF_SENTENCEMODE_CONVERSATION  = 0x00000010U,
}

enum : uint
{
    TF_TRANSITORYEXTENSION_NONE        = 0x00000000U,
    TF_TRANSITORYEXTENSION_FLOATING    = 0x00000001U,
    TF_TRANSITORYEXTENSION_ATSELECTION = 0x00000002U,
}

enum : uint
{
    TF_PROFILETYPE_INPUTPROCESSOR = 0x00000001U,
    TF_PROFILETYPE_KEYBOARDLAYOUT = 0x00000002U,
}

enum uint TF_RIP_FLAG_FREEUNUSEDLIBRARIES = 0x00000001U;

enum : uint
{
    TF_IPP_FLAG_ACTIVE                      = 0x00000001U,
    TF_IPP_FLAG_ENABLED                     = 0x00000002U,
    TF_IPP_FLAG_SUBSTITUTEDBYINPUTPROCESSOR = 0x00000004U,
}

enum uint TF_IPP_CAPS_DISABLEONTRANSITORY = 0x00000001U;

enum : uint
{
    TF_IPP_CAPS_SECUREMODESUPPORT = 0x00000002U,
    TF_IPP_CAPS_UIELEMENTENABLED  = 0x00000004U,
    TF_IPP_CAPS_COMLESSSUPPORT    = 0x00000008U,
    TF_IPP_CAPS_WOW16SUPPORT      = 0x00000010U,
    TF_IPP_CAPS_IMMERSIVESUPPORT  = 0x00010000U,
    TF_IPP_CAPS_SYSTRAYSUPPORT    = 0x00020000U,
}

enum : uint
{
    TF_IPPMF_FORPROCESS                   = 0x10000000U,
    TF_IPPMF_FORSESSION                   = 0x20000000U,
    TF_IPPMF_FORSYSTEMALL                 = 0x40000000U,
    TF_IPPMF_ENABLEPROFILE                = 0x00000001U,
    TF_IPPMF_DISABLEPROFILE               = 0x00000002U,
    TF_IPPMF_DONTCARECURRENTINPUTLANGUAGE = 0x00000004U,
}

enum uint TF_RP_HIDDENINSETTINGUI = 0x00000002U;

enum : uint
{
    TF_RP_LOCALPROCESS = 0x00000004U,
    TF_RP_LOCALTHREAD  = 0x00000008U,
}

enum uint TF_RP_SUBITEMINSETTINGUI = 0x00000010U;
enum uint TF_URP_ALLPROFILES = 0x00000002U;

enum : uint
{
    TF_URP_LOCALPROCESS = 0x00000004U,
    TF_URP_LOCALTHREAD  = 0x00000008U,
}

enum uint TF_IPSINK_FLAG_ACTIVE = 0x00000001U;
enum uint TF_INVALID_EDIT_COOKIE = 0x00000000U;
enum uint TF_POPF_ALL = 0x00000001U;

enum : uint
{
    TF_SD_READONLY = 0x00000001U,
    TF_SD_LOADING  = 0x00000002U,
}

enum uint TF_SS_DISJOINTSEL = 0x00000001U;

enum : uint
{
    TF_SS_REGIONS              = 0x00000002U,
    TF_SS_TRANSITORY           = 0x00000004U,
    TF_SS_TKBAUTOCORRECTENABLE = 0x00000010U,
}

enum uint TF_SS_TKBPREDICTIONENABLE = 0x00000020U;
enum uint TF_CHAR_EMBEDDED = 0x0000fffcU;
enum uint TF_HF_OBJECT = 0x00000001U;
enum uint TF_TF_MOVESTART = 0x00000001U;
enum uint TF_TF_IGNOREEND = 0x00000002U;
enum uint TF_ST_CORRECTION = 0x00000001U;
enum uint TF_IE_CORRECTION = 0x00000001U;
enum uint TF_TU_CORRECTION = 0x00000001U;
enum uint TF_INVALID_COOKIE = 0xffffffffU;

enum : GUID
{
    TF_PROFILE_NEWPHONETIC = GUID("b2f9c502-1742-11d4-9790-0080c882687e"),
    TF_PROFILE_PHONETIC    = GUID("761309de-317a-11d4-9b5d-0080c882687e"),
    TF_PROFILE_NEWCHANGJIE = GUID("f3ba907a-6c7e-11d4-97fa-0080c882687e"),
    TF_PROFILE_CHANGJIE    = GUID("4bdf9f03-c7d3-11d4-b2ab-0080c882687e"),
    TF_PROFILE_NEWQUICK    = GUID("0b883ba0-c1c7-11d4-87f9-0080c882687e"),
    TF_PROFILE_QUICK       = GUID("6024b45f-5c54-11d4-b921-0080c882687e"),
    TF_PROFILE_CANTONESE   = GUID("0aec109c-7e96-11d4-b2ef-0080c882687e"),
    TF_PROFILE_PINYIN      = GUID("f3ba9077-6c7e-11d4-97fa-0080c882687e"),
    TF_PROFILE_SIMPLEFAST  = GUID("fa550b04-5ad7-411f-a5ac-ca038ec515d7"),
    TF_PROFILE_WUBI        = GUID("82590c13-f4dd-44f4-ba1d-8667246fdf8e"),
    TF_PROFILE_DAYI        = GUID("037b2c25-480c-4d7f-b027-d6ca6b69788a"),
    TF_PROFILE_ARRAY       = GUID("d38eff65-aa46-4fd5-91a7-67845fb02f5b"),
    TF_PROFILE_YI          = GUID("409c8376-007b-4357-ae8e-26316ee3fb0d"),
    TF_PROFILE_TIGRINYA    = GUID("3cab88b7-cc3e-46a6-9765-b772ad7761ff"),
}

enum HRESULT TF_E_NOCONVERSION = HRESULT(0x80040600);

enum : uint
{
    TF_DICTATION_ON      = 0x00000001U,
    TF_DICTATION_ENABLED = 0x00000002U,
}

enum : uint
{
    TF_COMMANDING_ENABLED = 0x00000004U,
    TF_COMMANDING_ON      = 0x00000008U,
}

enum uint TF_SPEECHUI_SHOWN = 0x00000010U;
enum uint TF_SHOW_BALLOON = 0x00000001U;
enum uint TF_DISABLE_BALLOON = 0x00000002U;
enum uint TF_MENUREADY = 0x00000001U;
enum uint TF_PROPUI_STATUS_SAVETOFILE = 0x00000001U;
enum GUID GUID_INTEGRATIONSTYLE_SEARCHBOX = GUID("e6d1bd11-82f7-4903-ae21-1a6397cde2eb");
enum uint TKBL_UNDEFINED = 0x00000000U;

enum : uint
{
    TKBL_CLASSIC_TRADITIONAL_CHINESE_PHONETIC = 0x00000404U,
    TKBL_CLASSIC_TRADITIONAL_CHINESE_CHANGJIE = 0x0000f042U,
    TKBL_CLASSIC_TRADITIONAL_CHINESE_DAYI     = 0x0000f043U,
}

enum : uint
{
    TKBL_OPT_JAPANESE_ABC           = 0x00000411U,
    TKBL_OPT_KOREAN_HANGUL_2_BULSIK = 0x00000412U,
}

enum uint TKBL_OPT_SIMPLIFIED_CHINESE_PINYIN = 0x00000804U;
enum uint TKBL_OPT_TRADITIONAL_CHINESE_PHONETIC = 0x00000404U;

enum : const(wchar)*
{
    TF_FLOATINGLANGBAR_WNDTITLEW = "TF_FloatingLangBar_WndTitle",
    // Native encoding: ansi
    TF_FLOATINGLANGBAR_WNDTITLEA = "TF_FloatingLangBar_WndTitle",
    TF_FLOATINGLANGBAR_WNDTITLE  = "TF_FloatingLangBar_WndTitle",
}

enum : uint
{
    TF_LBI_ICON                      = 0x00000001U,
    TF_LBI_TEXT                      = 0x00000002U,
    TF_LBI_TOOLTIP                   = 0x00000004U,
    TF_LBI_BITMAP                    = 0x00000008U,
    TF_LBI_BALLOON                   = 0x00000010U,
    TF_LBI_CUSTOMUI                  = 0x00000020U,
    TF_LBI_STATUS                    = 0x00010000U,
    TF_LBI_STYLE_HIDDENSTATUSCONTROL = 0x00000001U,
    TF_LBI_STYLE_SHOWNINTRAY         = 0x00000002U,
    TF_LBI_STYLE_HIDEONNOOTHERITEMS  = 0x00000004U,
    TF_LBI_STYLE_SHOWNINTRAYONLY     = 0x00000008U,
    TF_LBI_STYLE_HIDDENBYDEFAULT     = 0x00000010U,
    TF_LBI_STYLE_TEXTCOLORICON       = 0x00000020U,
    TF_LBI_STYLE_BTN_BUTTON          = 0x00010000U,
    TF_LBI_STYLE_BTN_MENU            = 0x00020000U,
    TF_LBI_STYLE_BTN_TOGGLE          = 0x00040000U,
}

enum : uint
{
    TF_LBI_STATUS_HIDDEN      = 0x00000001U,
    TF_LBI_STATUS_DISABLED    = 0x00000002U,
    TF_LBI_STATUS_BTN_TOGGLED = 0x00010000U,
}

enum uint TF_LBI_BMPF_VERTICAL = 0x00000001U;

enum : uint
{
    TF_SFT_SHOWNORMAL     = 0x00000001U,
    TF_SFT_DOCK           = 0x00000002U,
    TF_SFT_MINIMIZED      = 0x00000004U,
    TF_SFT_HIDDEN         = 0x00000008U,
    TF_SFT_NOTRANSPARENCY = 0x00000010U,
}

enum uint TF_SFT_LOWTRANSPARENCY = 0x00000020U;
enum uint TF_SFT_HIGHTRANSPARENCY = 0x00000040U;

enum : uint
{
    TF_SFT_LABELS                = 0x00000080U,
    TF_SFT_NOLABELS              = 0x00000100U,
    TF_SFT_EXTRAICONSONMINIMIZED = 0x00000200U,
}

enum uint TF_SFT_NOEXTRAICONSONMINIMIZED = 0x00000400U;
enum uint TF_SFT_DESKBAND = 0x00000800U;
enum uint TF_LBI_DESC_MAXLEN = 0x00000020U;

enum : uint
{
    TF_LBMENUF_CHECKED      = 0x00000001U,
    TF_LBMENUF_SUBMENU      = 0x00000002U,
    TF_LBMENUF_SEPARATOR    = 0x00000004U,
    TF_LBMENUF_RADIOCHECKED = 0x00000008U,
    TF_LBMENUF_GRAYED       = 0x00000010U,
}

enum GUID GUID_PROP_INPUTSCOPE = GUID("1713dd5a-68e7-4a5b-9af6-592a595c778d");

enum : uint
{
    DCM_FLAGS_TASKENG        = 0x00000001U,
    DCM_FLAGS_CTFMON         = 0x00000002U,
    DCM_FLAGS_LOCALTHREADTSF = 0x00000004U,
}

enum uint ILMCM_CHECKLAYOUTANDTIPENABLED = 0x00000001U;
enum uint ILMCM_LANGUAGEBAROFF = 0x00000002U;
enum GUID LIBID_MSAATEXTLib = GUID("150e2d7a-dac1-4582-947d-2a8fd78b82cd");

enum : uint
{
    TS_STRF_START = 0x00000000U,
    TS_STRF_MID   = 0x00000001U,
    TS_STRF_END   = 0x00000002U,
}

enum : GUID
{
    TSATTRID_OTHERS                                  = GUID("b3c32af9-57d0-46a9-bca8-dac238a13057"),
    TSATTRID_Font                                    = GUID("573ea825-749b-4f8a-9cfd-21c3605ca828"),
    TSATTRID_Font_FaceName                           = GUID("b536aeb6-053b-4eb8-b65a-50da1e81e72e"),
    TSATTRID_Font_SizePts                            = GUID("c8493302-a5e9-456d-af04-8005e4130f03"),
    TSATTRID_Font_Style                              = GUID("68b2a77f-6b0e-4f28-8177-571c2f3a42b1"),
    TSATTRID_Font_Style_Bold                         = GUID("48813a43-8a20-4940-8e58-97823f7b268a"),
    TSATTRID_Font_Style_Italic                       = GUID("8740682a-a765-48e1-acfc-d22222b2f810"),
    TSATTRID_Font_Style_SmallCaps                    = GUID("facb6bc6-9100-4cc6-b969-11eea45a86b4"),
    TSATTRID_Font_Style_Capitalize                   = GUID("7d85a3ba-b4fd-43b3-befc-6b985c843141"),
    TSATTRID_Font_Style_Uppercase                    = GUID("33a300e8-e340-4937-b697-8f234045cd9a"),
    TSATTRID_Font_Style_Lowercase                    = GUID("76d8ccb5-ca7b-4498-8ee9-d5c4f6f74c60"),
    TSATTRID_Font_Style_Animation                    = GUID("dcf73d22-e029-47b7-bb36-f263a3d004cc"),
    TSATTRID_Font_Style_Animation_LasVegasLights     = GUID("f40423d5-0f87-4f8f-bada-e6d60c25e152"),
    TSATTRID_Font_Style_Animation_BlinkingBackground = GUID("86e5b104-0104-4b10-b585-00f2527522b5"),
    TSATTRID_Font_Style_Animation_SparkleText        = GUID("533aad20-962c-4e9f-8c09-b42ea4749711"),
    TSATTRID_Font_Style_Animation_MarchingBlackAnts  = GUID("7644e067-f186-4902-bfc6-ec815aa20e9d"),
    TSATTRID_Font_Style_Animation_MarchingRedAnts    = GUID("78368dad-50fb-4c6f-840b-d486bb6cf781"),
    TSATTRID_Font_Style_Animation_Shimmer            = GUID("2ce31b58-5293-4c36-8809-bf8bb51a27b3"),
    TSATTRID_Font_Style_Animation_WipeDown           = GUID("5872e874-367b-4803-b160-c90ff62569d0"),
    TSATTRID_Font_Style_Animation_WipeRight          = GUID("b855cbe3-3d2c-4600-b1e9-e1c9ce02f842"),
    TSATTRID_Font_Style_Emboss                       = GUID("bd8ed742-349e-4e37-82fb-437979cb53a7"),
    TSATTRID_Font_Style_Engrave                      = GUID("9c3371de-8332-4897-be5d-89233223179a"),
    TSATTRID_Font_Style_Hidden                       = GUID("b1e28770-881c-475f-863f-887a647b1090"),
    TSATTRID_Font_Style_Kerning                      = GUID("cc26e1b4-2f9a-47c8-8bff-bf1eb7cce0dd"),
    TSATTRID_Font_Style_Outlined                     = GUID("10e6db31-db0d-4ac6-a7f5-9c9cff6f2ab4"),
    TSATTRID_Font_Style_Position                     = GUID("15cd26ab-f2fb-4062-b5a6-9a49e1a5cc0b"),
    TSATTRID_Font_Style_Protected                    = GUID("1c557cb2-14cf-4554-a574-ecb2f7e7efd4"),
    TSATTRID_Font_Style_Shadow                       = GUID("5f686d2f-c6cd-4c56-8a1a-994a4b9766be"),
    TSATTRID_Font_Style_Spacing                      = GUID("98c1200d-8f06-409a-8e49-6a554bf7c153"),
    TSATTRID_Font_Style_Weight                       = GUID("12f3189c-8bb0-461b-b1fa-eaf907047fe0"),
    TSATTRID_Font_Style_Height                       = GUID("7e937477-12e6-458b-926a-1fa44ee8f391"),
    TSATTRID_Font_Style_Underline                    = GUID("c3c9c9f3-7902-444b-9a7b-48e70f4b50f7"),
    TSATTRID_Font_Style_Underline_Single             = GUID("1b6720e5-0f73-4951-a6b3-6f19e43c9461"),
    TSATTRID_Font_Style_Underline_Double             = GUID("74d24aa6-1db3-4c69-a176-31120e7586d5"),
    TSATTRID_Font_Style_Strikethrough                = GUID("0c562193-2d08-4668-9601-ced41309d7af"),
    TSATTRID_Font_Style_Strikethrough_Single         = GUID("75d736b6-3c8f-4b97-ab78-1877cb990d31"),
    TSATTRID_Font_Style_Strikethrough_Double         = GUID("62489b31-a3e7-4f94-ac43-ebaf8fcc7a9f"),
    TSATTRID_Font_Style_Overline                     = GUID("e3989f4a-992b-4301-8ce1-a5b7c6d1f3c8"),
    TSATTRID_Font_Style_Overline_Single              = GUID("8440d94c-51ce-47b2-8d4c-15751e5f721b"),
    TSATTRID_Font_Style_Overline_Double              = GUID("dc46063a-e115-46e3-bcd8-ca6772aa95b4"),
    TSATTRID_Font_Style_Blink                        = GUID("bfb2c036-7acf-4532-b720-b416dd7765a8"),
    TSATTRID_Font_Style_Subscript                    = GUID("5774fb84-389b-43bc-a74b-1568347cf0f4"),
    TSATTRID_Font_Style_Superscript                  = GUID("2ea4993c-563c-49aa-9372-0bef09a9255b"),
    TSATTRID_Font_Style_Color                        = GUID("857a7a37-b8af-4e9a-81b4-acf700c8411b"),
    TSATTRID_Font_Style_BackgroundColor              = GUID("b50eaa4e-3091-4468-81db-d79ea190c7c7"),
}

enum : GUID
{
    TSATTRID_Text                            = GUID("7edb8e68-81f9-449d-a15a-87a8388faac0"),
    TSATTRID_Text_VerticalWriting            = GUID("6bba8195-046f-4ea9-b311-97fd66c4274b"),
    TSATTRID_Text_RightToLeft                = GUID("ca666e71-1b08-453d-bfdd-28e08c8aaf7a"),
    TSATTRID_Text_Orientation                = GUID("6bab707f-8785-4c39-8b52-96f878303ffb"),
    TSATTRID_Text_Language                   = GUID("d8c04ef1-5753-4c25-8887-85443fe5f819"),
    TSATTRID_Text_ReadOnly                   = GUID("85836617-de32-4afd-a50f-a2db110e6e4d"),
    TSATTRID_Text_EmbeddedObject             = GUID("7edb8e68-81f9-449d-a15a-87a8388faac0"),
    TSATTRID_Text_Alignment                  = GUID("139941e6-1767-456d-938e-35ba568b5cd4"),
    TSATTRID_Text_Alignment_Left             = GUID("16ae95d3-6361-43a2-8495-d00f397f1693"),
    TSATTRID_Text_Alignment_Right            = GUID("b36f0f98-1b9e-4360-8616-03fb08a78456"),
    TSATTRID_Text_Alignment_Center           = GUID("a4a95c16-53bf-4d55-8b87-4bdd8d4275fc"),
    TSATTRID_Text_Alignment_Justify          = GUID("ed350740-a0f7-42d3-8ea8-f81b6488faf0"),
    TSATTRID_Text_Link                       = GUID("47cd9051-3722-4cd8-b7c8-4e17ca1759f5"),
    TSATTRID_Text_Hyphenation                = GUID("dadf4525-618e-49eb-b1a8-3b68bd7648e3"),
    TSATTRID_Text_Para                       = GUID("5edc5822-99dc-4dd6-aec3-b62baa5b2e7c"),
    TSATTRID_Text_Para_FirstLineIndent       = GUID("07c97a13-7472-4dd8-90a9-91e3d7e4f29c"),
    TSATTRID_Text_Para_LeftIndent            = GUID("fb2848e9-7471-41c9-b6b3-8a1450e01897"),
    TSATTRID_Text_Para_RightIndent           = GUID("2c7f26f9-a5e2-48da-b98a-520cb16513bf"),
    TSATTRID_Text_Para_SpaceAfter            = GUID("7b0a3f55-22dc-425f-a411-93da1d8f9baa"),
    TSATTRID_Text_Para_SpaceBefore           = GUID("8df98589-194a-4601-b251-9865a3e906dd"),
    TSATTRID_Text_Para_LineSpacing           = GUID("699b380d-7f8c-46d6-a73b-dfe3d1538df3"),
    TSATTRID_Text_Para_LineSpacing_Single    = GUID("ed350740-a0f7-42d3-8ea8-f81b6488faf0"),
    TSATTRID_Text_Para_LineSpacing_OnePtFive = GUID("0428a021-0397-4b57-9a17-0795994cd3c5"),
    TSATTRID_Text_Para_LineSpacing_Double    = GUID("82fb1805-a6c4-4231-ac12-6260af2aba28"),
    TSATTRID_Text_Para_LineSpacing_AtLeast   = GUID("adfedf31-2d44-4434-a5ff-7f4c4990a905"),
    TSATTRID_Text_Para_LineSpacing_Exactly   = GUID("3d45ad40-23de-48d7-a6b3-765420c620cc"),
    TSATTRID_Text_Para_LineSpacing_Multiple  = GUID("910f1e3c-d6d0-4f65-8a3c-42b4b31868c5"),
}

enum : GUID
{
    TSATTRID_List                  = GUID("436d673b-26f1-4aee-9e65-8f83a4ed4884"),
    TSATTRID_List_LevelIndel       = GUID("7f7cc899-311f-487b-ad5d-e2a459e12d42"),
    TSATTRID_List_Type             = GUID("ae3e665e-4bce-49e3-a0fe-2db47d3a17ae"),
    TSATTRID_List_Type_Bullet      = GUID("bccd77c5-4c4d-4ce2-b102-559f3b2bfcea"),
    TSATTRID_List_Type_Arabic      = GUID("1338c5d6-98a3-4fa3-9bd1-7a60eef8e9e0"),
    TSATTRID_List_Type_LowerLetter = GUID("96372285-f3cf-491e-a925-3832347fd237"),
    TSATTRID_List_Type_UpperLetter = GUID("7987b7cd-ce52-428b-9b95-a357f6f10c45"),
    TSATTRID_List_Type_LowerRoman  = GUID("90466262-3980-4b8e-9368-918bd1218a41"),
    TSATTRID_List_Type_UpperRoman  = GUID("0f6ab552-4a80-467f-b2f1-127e2aa3ba9e"),
}

enum : GUID
{
    TSATTRID_App                   = GUID("a80f77df-4237-40e5-849c-b5fa51c13ac7"),
    TSATTRID_App_IncorrectSpelling = GUID("f42de43c-ef12-430d-944c-9a08970a25d2"),
    TSATTRID_App_IncorrectGrammar  = GUID("bd54e398-ad03-4b74-b6b3-5edb19996388"),
}

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/ns-textstor-ts_status
struct TS_STATUS
{
    uint dwDynamicFlags;
    uint dwStaticFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/ns-textstor-ts_textchange
struct TS_TEXTCHANGE
{
    int acpStart;
    int acpOldEnd;
    int acpNewEnd;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/ns-textstor-ts_selectionstyle
struct TS_SELECTIONSTYLE
{
    TsActiveSelEnd ase;
    BOOL           fInterimChar;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/ns-textstor-ts_selection_acp
struct TS_SELECTION_ACP
{
    int               acpStart;
    int               acpEnd;
    TS_SELECTIONSTYLE style;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/ns-textstor-ts_selection_anchor
struct TS_SELECTION_ANCHOR
{
    IAnchor           paStart;
    IAnchor           paEnd;
    TS_SELECTIONSTYLE style;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/ns-textstor-ts_attrval
struct TS_ATTRVAL
{
    GUID    idAttr;
    uint    dwOverlapId;
    VARIANT varValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/ns-textstor-ts_runinfo
struct TS_RUNINFO
{
    uint      uCount;
    TsRunType type;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/ns-ctfutb-tf_langbariteminfo
struct TF_LANGBARITEMINFO
{
    GUID      clsidService;
    GUID      guidItem;
    uint      dwStyle;
    uint      ulSort;
    wchar[32] szDescription;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/ns-ctfutb-tf_lbballooninfo
struct TF_LBBALLOONINFO
{
    TfLBBalloonStyle style;
    BSTR             bstrText;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/ns-msctf-tf_persistent_property_header_acp
struct TF_PERSISTENT_PROPERTY_HEADER_ACP
{
    GUID guidType;
    int  ichStart;
    int  cch;
    uint cb;
    uint dwPrivate;
    GUID clsidTIP;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/ns-msctf-tf_languageprofile
struct TF_LANGUAGEPROFILE
{
    GUID   clsid;
    ushort langid;
    GUID   catid;
    BOOL   fActive;
    GUID   guidProfile;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/ns-msctf-tf_selectionstyle
struct TF_SELECTIONSTYLE
{
    TfActiveSelEnd ase;
    BOOL           fInterimChar;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/ns-msctf-tf_selection
struct TF_SELECTION
{
    ITfRange          range;
    TF_SELECTIONSTYLE style;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/ns-msctf-tf_propertyval
struct TF_PROPERTYVAL
{
    GUID    guidId;
    VARIANT varValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/ns-msctf-tf_haltcond
struct TF_HALTCOND
{
    ITfRange pHaltRange;
    TfAnchor aHaltPos;
    uint     dwFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/ns-msctf-tf_inputprocessorprofile
struct TF_INPUTPROCESSORPROFILE
{
    uint   dwProfileType;
    ushort langid;
    GUID   clsid;
    GUID   guidProfile;
    GUID   catid;
    HKL    hklSubstitute;
    uint   dwCaps;
    HKL    hkl;
    uint   dwFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/ns-msctf-tf_preservedkey
struct TF_PRESERVEDKEY
{
    uint uVKey;
    uint uModifiers;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/ns-msctf-tf_da_color
struct TF_DA_COLOR
{
    TF_DA_COLORTYPE type;
    union
    {
        int      nIndex;
        COLORREF cr;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/ns-msctf-tf_displayattribute
struct TF_DISPLAYATTRIBUTE
{
    TF_DA_COLOR     crText;
    TF_DA_COLOR     crBk;
    TF_DA_LINESTYLE lsStyle;
    BOOL            fBoldLine;
    TF_DA_COLOR     crLine;
    TF_DA_ATTR_INFO bAttr;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/ns-ctffunc-tf_lmlattelement
struct TF_LMLATTELEMENT
{
    uint dwFrameStart;
    uint dwFrameLen;
    uint dwFlags;
    union
    {
        int iCost;
    }
    BSTR bstrText;
}

// Functions

@DllImport("MsCtfMonitor.dll")
BOOL DoMsCtfMonitor(uint dwFlags, HANDLE hEventForServiceStop);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("MsCtfMonitor.dll")
HRESULT InitLocalMsCtfMonitor(uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("MsCtfMonitor.dll")
HRESULT UninitLocalMsCtfMonitor();


// Interfaces

@GUID("08cd963f-7a3e-4f5c-9bd8-d692bb043c5b")
struct MSAAControl;

@GUID("5440837f-4bff-4ae5-a1b1-7722ecc6332a")
struct AccStore;

@GUID("6572ee16-5fe5-4331-bb6d-76a49c56e423")
struct AccDictionary;

@GUID("6089a37e-eb8a-482d-bd6f-f9f46904d16d")
struct AccServerDocMgr;

@GUID("fc48cc30-4f3e-4fa1-803b-ad0e196a83b1")
struct AccClientDocMgr;

@GUID("bf426f7e-7a5e-44d6-830c-a390ea9462a3")
struct DocWrap;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nn-textstor-itextstoreacp
@GUID("28888fe3-c2a0-483a-a3ea-8cb1ce51ff3d")
interface ITextStoreACP : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-advisesink
    HRESULT AdviseSink(const(GUID)* riid, IUnknown punk, uint dwMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-unadvisesink
    HRESULT UnadviseSink(IUnknown punk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-requestlock
    HRESULT RequestLock(uint dwLockFlags, HRESULT* phrSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-getstatus
    HRESULT GetStatus(TS_STATUS* pdcs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-queryinsert
    HRESULT QueryInsert(int acpTestStart, int acpTestEnd, uint cch, int* pacpResultStart, int* pacpResultEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-getselection
    HRESULT GetSelection(uint ulIndex, uint ulCount, TS_SELECTION_ACP* pSelection, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-setselection
    HRESULT SetSelection(uint ulCount, const(TS_SELECTION_ACP)* pSelection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-gettext
    HRESULT GetText(int acpStart, int acpEnd, PWSTR pchPlain, uint cchPlainReq, uint* pcchPlainRet, 
                    TS_RUNINFO* prgRunInfo, uint cRunInfoReq, uint* pcRunInfoRet, int* pacpNext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-settext
    HRESULT SetText(uint dwFlags, int acpStart, int acpEnd, const(PWSTR) pchText, uint cch, TS_TEXTCHANGE* pChange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-getformattedtext
    HRESULT GetFormattedText(int acpStart, int acpEnd, IDataObject* ppDataObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-getembedded
    HRESULT GetEmbedded(int acpPos, const(GUID)* rguidService, const(GUID)* riid, IUnknown* ppunk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-queryinsertembedded
    HRESULT QueryInsertEmbedded(const(GUID)* pguidService, const(FORMATETC)* pFormatEtc, BOOL* pfInsertable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-insertembedded
    HRESULT InsertEmbedded(uint dwFlags, int acpStart, int acpEnd, IDataObject pDataObject, TS_TEXTCHANGE* pChange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-inserttextatselection
    HRESULT InsertTextAtSelection(uint dwFlags, const(PWSTR) pchText, uint cch, int* pacpStart, int* pacpEnd, 
                                  TS_TEXTCHANGE* pChange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-insertembeddedatselection
    HRESULT InsertEmbeddedAtSelection(uint dwFlags, IDataObject pDataObject, int* pacpStart, int* pacpEnd, 
                                      TS_TEXTCHANGE* pChange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-requestsupportedattrs
    HRESULT RequestSupportedAttrs(uint dwFlags, uint cFilterAttrs, const(GUID)* paFilterAttrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-requestattrsatposition
    HRESULT RequestAttrsAtPosition(int acpPos, uint cFilterAttrs, const(GUID)* paFilterAttrs, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-requestattrstransitioningatposition
    HRESULT RequestAttrsTransitioningAtPosition(int acpPos, uint cFilterAttrs, const(GUID)* paFilterAttrs, 
                                                uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-findnextattrtransition
    HRESULT FindNextAttrTransition(int acpStart, int acpHalt, uint cFilterAttrs, const(GUID)* paFilterAttrs, 
                                   uint dwFlags, int* pacpNext, BOOL* pfFound, int* plFoundOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-retrieverequestedattrs
    HRESULT RetrieveRequestedAttrs(uint ulCount, TS_ATTRVAL* paAttrVals, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-getendacp
    HRESULT GetEndACP(int* pacp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-getactiveview
    HRESULT GetActiveView(uint* pvcView);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-getacpfrompoint
    HRESULT GetACPFromPoint(uint vcView, const(POINT)* ptScreen, uint dwFlags, int* pacp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-gettextext
    HRESULT GetTextExt(uint vcView, int acpStart, int acpEnd, RECT* prc, BOOL* pfClipped);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-getscreenext
    HRESULT GetScreenExt(uint vcView, RECT* prc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp-getwnd
    HRESULT GetWnd(uint vcView, HWND* phwnd);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nn-textstor-itextstoreacp2
@GUID("f86ad89f-5fe4-4b8d-bb9f-ef3797a84f1f")
interface ITextStoreACP2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-advisesink
    HRESULT AdviseSink(const(GUID)* riid, IUnknown punk, uint dwMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-unadvisesink
    HRESULT UnadviseSink(IUnknown punk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-requestlock
    HRESULT RequestLock(uint dwLockFlags, HRESULT* phrSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-getstatus
    HRESULT GetStatus(TS_STATUS* pdcs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-queryinsert
    HRESULT QueryInsert(int acpTestStart, int acpTestEnd, uint cch, int* pacpResultStart, int* pacpResultEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-getselection
    HRESULT GetSelection(uint ulIndex, uint ulCount, TS_SELECTION_ACP* pSelection, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-setselection
    HRESULT SetSelection(uint ulCount, const(TS_SELECTION_ACP)* pSelection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-gettext
    HRESULT GetText(int acpStart, int acpEnd, PWSTR pchPlain, uint cchPlainReq, uint* pcchPlainRet, 
                    TS_RUNINFO* prgRunInfo, uint cRunInfoReq, uint* pcRunInfoRet, int* pacpNext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-settext
    HRESULT SetText(uint dwFlags, int acpStart, int acpEnd, const(PWSTR) pchText, uint cch, TS_TEXTCHANGE* pChange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-getformattedtext
    HRESULT GetFormattedText(int acpStart, int acpEnd, IDataObject* ppDataObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-getembedded
    HRESULT GetEmbedded(int acpPos, const(GUID)* rguidService, const(GUID)* riid, IUnknown* ppunk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-queryinsertembedded
    HRESULT QueryInsertEmbedded(const(GUID)* pguidService, const(FORMATETC)* pFormatEtc, BOOL* pfInsertable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-insertembedded
    HRESULT InsertEmbedded(uint dwFlags, int acpStart, int acpEnd, IDataObject pDataObject, TS_TEXTCHANGE* pChange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-inserttextatselection
    HRESULT InsertTextAtSelection(uint dwFlags, const(PWSTR) pchText, uint cch, int* pacpStart, int* pacpEnd, 
                                  TS_TEXTCHANGE* pChange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-insertembeddedatselection
    HRESULT InsertEmbeddedAtSelection(uint dwFlags, IDataObject pDataObject, int* pacpStart, int* pacpEnd, 
                                      TS_TEXTCHANGE* pChange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-requestsupportedattrs
    HRESULT RequestSupportedAttrs(uint dwFlags, uint cFilterAttrs, const(GUID)* paFilterAttrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-requestattrsatposition
    HRESULT RequestAttrsAtPosition(int acpPos, uint cFilterAttrs, const(GUID)* paFilterAttrs, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-requestattrstransitioningatposition
    HRESULT RequestAttrsTransitioningAtPosition(int acpPos, uint cFilterAttrs, const(GUID)* paFilterAttrs, 
                                                uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-findnextattrtransition
    HRESULT FindNextAttrTransition(int acpStart, int acpHalt, uint cFilterAttrs, const(GUID)* paFilterAttrs, 
                                   uint dwFlags, int* pacpNext, BOOL* pfFound, int* plFoundOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-retrieverequestedattrs
    HRESULT RetrieveRequestedAttrs(uint ulCount, TS_ATTRVAL* paAttrVals, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-getendacp
    HRESULT GetEndACP(int* pacp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-getactiveview
    HRESULT GetActiveView(uint* pvcView);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-getacpfrompoint
    HRESULT GetACPFromPoint(uint vcView, const(POINT)* ptScreen, uint dwFlags, int* pacp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-gettextext
    HRESULT GetTextExt(uint vcView, int acpStart, int acpEnd, RECT* prc, BOOL* pfClipped);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacp2-getscreenext
    HRESULT GetScreenExt(uint vcView, RECT* prc);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nn-textstor-itextstoreacpsink
@GUID("22d44c94-a419-4542-a272-ae26093ececf")
interface ITextStoreACPSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacpsink-ontextchange
    HRESULT OnTextChange(TEXT_STORE_TEXT_CHANGE_FLAGS dwFlags, const(TS_TEXTCHANGE)* pChange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacpsink-onselectionchange
    HRESULT OnSelectionChange();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacpsink-onlayoutchange
    HRESULT OnLayoutChange(TsLayoutCode lcode, uint vcView);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacpsink-onstatuschange
    HRESULT OnStatusChange(uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacpsink-onattrschange
    HRESULT OnAttrsChange(int acpStart, int acpEnd, uint cAttrs, const(GUID)* paAttrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacpsink-onlockgranted
    HRESULT OnLockGranted(TEXT_STORE_LOCK_FLAGS dwLockFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacpsink-onstartedittransaction
    HRESULT OnStartEditTransaction();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreacpsink-onendedittransaction
    HRESULT OnEndEditTransaction();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nn-textstor-ianchor
@GUID("0feb7e34-5a60-4356-8ef7-abdec2ff7cf8")
interface IAnchor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-ianchor-setgravity
    HRESULT SetGravity(TsGravity gravity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-ianchor-getgravity
    HRESULT GetGravity(TsGravity* pgravity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-ianchor-isequal
    HRESULT IsEqual(IAnchor paWith, BOOL* pfEqual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-ianchor-compare
    HRESULT Compare(IAnchor paWith, int* plResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-ianchor-shift
    HRESULT Shift(uint dwFlags, int cchReq, int* pcch, IAnchor paHaltAnchor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-ianchor-shiftto
    HRESULT ShiftTo(IAnchor paSite);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-ianchor-shiftregion
    HRESULT ShiftRegion(uint dwFlags, TsShiftDir dir, BOOL* pfNoRegion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-ianchor-setchangehistorymask
    HRESULT SetChangeHistoryMask(uint dwMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-ianchor-getchangehistory
    HRESULT GetChangeHistory(ANCHOR_CHANGE_HISTORY_FLAGS* pdwHistory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-ianchor-clearchangehistory
    HRESULT ClearChangeHistory();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-ianchor-clone
    HRESULT Clone(IAnchor* ppaClone);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nn-textstor-itextstoreanchor
@GUID("9b2077b0-5f18-4dec-bee9-3cc722f5dfe0")
interface ITextStoreAnchor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-advisesink
    HRESULT AdviseSink(const(GUID)* riid, IUnknown punk, uint dwMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-unadvisesink
    HRESULT UnadviseSink(IUnknown punk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-requestlock
    HRESULT RequestLock(uint dwLockFlags, HRESULT* phrSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-getstatus
    HRESULT GetStatus(TS_STATUS* pdcs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-queryinsert
    HRESULT QueryInsert(IAnchor paTestStart, IAnchor paTestEnd, uint cch, IAnchor* ppaResultStart, 
                        IAnchor* ppaResultEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-getselection
    HRESULT GetSelection(uint ulIndex, uint ulCount, TS_SELECTION_ANCHOR* pSelection, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-setselection
    HRESULT SetSelection(uint ulCount, const(TS_SELECTION_ANCHOR)* pSelection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-gettext
    HRESULT GetText(uint dwFlags, IAnchor paStart, IAnchor paEnd, PWSTR pchText, uint cchReq, uint* pcch, 
                    BOOL fUpdateAnchor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-settext
    HRESULT SetText(uint dwFlags, IAnchor paStart, IAnchor paEnd, const(PWSTR) pchText, uint cch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-getformattedtext
    HRESULT GetFormattedText(IAnchor paStart, IAnchor paEnd, IDataObject* ppDataObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-getembedded
    HRESULT GetEmbedded(uint dwFlags, IAnchor paPos, const(GUID)* rguidService, const(GUID)* riid, IUnknown* ppunk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-insertembedded
    HRESULT InsertEmbedded(uint dwFlags, IAnchor paStart, IAnchor paEnd, IDataObject pDataObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-requestsupportedattrs
    HRESULT RequestSupportedAttrs(uint dwFlags, uint cFilterAttrs, const(GUID)* paFilterAttrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-requestattrsatposition
    HRESULT RequestAttrsAtPosition(IAnchor paPos, uint cFilterAttrs, const(GUID)* paFilterAttrs, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-requestattrstransitioningatposition
    HRESULT RequestAttrsTransitioningAtPosition(IAnchor paPos, uint cFilterAttrs, const(GUID)* paFilterAttrs, 
                                                uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-findnextattrtransition
    HRESULT FindNextAttrTransition(IAnchor paStart, IAnchor paHalt, uint cFilterAttrs, const(GUID)* paFilterAttrs, 
                                   uint dwFlags, BOOL* pfFound, int* plFoundOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-retrieverequestedattrs
    HRESULT RetrieveRequestedAttrs(uint ulCount, TS_ATTRVAL* paAttrVals, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-getstart
    HRESULT GetStart(IAnchor* ppaStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-getend
    HRESULT GetEnd(IAnchor* ppaEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-getactiveview
    HRESULT GetActiveView(uint* pvcView);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-getanchorfrompoint
    HRESULT GetAnchorFromPoint(uint vcView, const(POINT)* ptScreen, uint dwFlags, IAnchor* ppaSite);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-gettextext
    HRESULT GetTextExt(uint vcView, IAnchor paStart, IAnchor paEnd, RECT* prc, BOOL* pfClipped);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-getscreenext
    HRESULT GetScreenExt(uint vcView, RECT* prc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-getwnd
    HRESULT GetWnd(uint vcView, HWND* phwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-queryinsertembedded
    HRESULT QueryInsertEmbedded(const(GUID)* pguidService, const(FORMATETC)* pFormatEtc, BOOL* pfInsertable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-inserttextatselection
    HRESULT InsertTextAtSelection(uint dwFlags, const(PWSTR) pchText, uint cch, IAnchor* ppaStart, IAnchor* ppaEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchor-insertembeddedatselection
    HRESULT InsertEmbeddedAtSelection(uint dwFlags, IDataObject pDataObject, IAnchor* ppaStart, IAnchor* ppaEnd);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nn-textstor-itextstoreanchorsink
@GUID("aa80e905-2021-11d2-93e0-0060b067b86e")
interface ITextStoreAnchorSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchorsink-ontextchange
    HRESULT OnTextChange(TEXT_STORE_CHANGE_FLAGS dwFlags, IAnchor paStart, IAnchor paEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchorsink-onselectionchange
    HRESULT OnSelectionChange();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchorsink-onlayoutchange
    HRESULT OnLayoutChange(TsLayoutCode lcode, uint vcView);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchorsink-onstatuschange
    HRESULT OnStatusChange(uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchorsink-onattrschange
    HRESULT OnAttrsChange(IAnchor paStart, IAnchor paEnd, uint cAttrs, const(GUID)* paAttrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchorsink-onlockgranted
    HRESULT OnLockGranted(TEXT_STORE_LOCK_FLAGS dwLockFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchorsink-onstartedittransaction
    HRESULT OnStartEditTransaction();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/textstor/nf-textstor-itextstoreanchorsink-onendedittransaction
    HRESULT OnEndEditTransaction();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nn-ctfutb-itflangbarmgr
@GUID("87955690-e627-11d2-8ddb-00105a2799b5")
interface ITfLangBarMgr : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbarmgr-adviseeventsink
    HRESULT AdviseEventSink(ITfLangBarEventSink pSink, HWND hwnd, uint dwFlags, uint* pdwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbarmgr-unadviseeventsink
    HRESULT UnadviseEventSink(uint dwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbarmgr-getthreadmarshalinterface
    HRESULT GetThreadMarshalInterface(uint dwThreadId, uint dwType, const(GUID)* riid, IUnknown* ppunk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbarmgr-getthreadlangbaritemmgr
    HRESULT GetThreadLangBarItemMgr(uint dwThreadId, ITfLangBarItemMgr* pplbi, uint* pdwThreadid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbarmgr-getinputprocessorprofiles
    HRESULT GetInputProcessorProfiles(uint dwThreadId, ITfInputProcessorProfiles* ppaip, uint* pdwThreadid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbarmgr-restorelastfocus
    HRESULT RestoreLastFocus(uint* pdwThreadId, BOOL fPrev);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbarmgr-setmodalinput
    HRESULT SetModalInput(ITfLangBarEventSink pSink, uint dwThreadId, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbarmgr-showfloating
    HRESULT ShowFloating(uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbarmgr-getshowfloatingstatus
    HRESULT GetShowFloatingStatus(uint* pdwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nn-ctfutb-itflangbareventsink
@GUID("18a4e900-e0ae-11d2-afdd-00105a2799b5")
interface ITfLangBarEventSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbareventsink-onsetfocus
    HRESULT OnSetFocus(uint dwThreadId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbareventsink-onthreadterminate
    HRESULT OnThreadTerminate(uint dwThreadId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbareventsink-onthreaditemchange
    HRESULT OnThreadItemChange(uint dwThreadId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbareventsink-onmodalinput
    HRESULT OnModalInput(uint dwThreadId, uint uMsg, WPARAM wParam, LPARAM lParam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbareventsink-showfloating
    HRESULT ShowFloating(uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbareventsink-getitemfloatingrect
    HRESULT GetItemFloatingRect(uint dwThreadId, const(GUID)* rguid, RECT* prc);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nn-ctfutb-itflangbaritemsink
@GUID("57dbe1a0-de25-11d2-afdd-00105a2799b5")
interface ITfLangBarItemSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritemsink-onupdate
    HRESULT OnUpdate(uint dwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nn-ctfutb-ienumtflangbaritems
@GUID("583f34d0-de25-11d2-afdd-00105a2799b5")
interface IEnumTfLangBarItems : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-ienumtflangbaritems-clone
    HRESULT Clone(IEnumTfLangBarItems* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-ienumtflangbaritems-next
    HRESULT Next(uint ulCount, ITfLangBarItem* ppItem, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-ienumtflangbaritems-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-ienumtflangbaritems-skip
    HRESULT Skip(uint ulCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nn-ctfutb-itflangbaritemmgr
@GUID("ba468c55-9956-4fb1-a59d-52a7dd7cc6aa")
interface ITfLangBarItemMgr : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritemmgr-enumitems
    HRESULT EnumItems(IEnumTfLangBarItems* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritemmgr-getitem
    HRESULT GetItem(const(GUID)* rguid, ITfLangBarItem* ppItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritemmgr-additem
    HRESULT AddItem(ITfLangBarItem punk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritemmgr-removeitem
    HRESULT RemoveItem(ITfLangBarItem punk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritemmgr-adviseitemsink
    HRESULT AdviseItemSink(ITfLangBarItemSink punk, uint* pdwCookie, const(GUID)* rguidItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritemmgr-unadviseitemsink
    HRESULT UnadviseItemSink(uint dwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritemmgr-getitemfloatingrect
    HRESULT GetItemFloatingRect(uint dwThreadId, const(GUID)* rguid, RECT* prc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritemmgr-getitemsstatus
    HRESULT GetItemsStatus(uint ulCount, const(GUID)* prgguid, uint* pdwStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritemmgr-getitemnum
    HRESULT GetItemNum(uint* pulCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritemmgr-getitems
    HRESULT GetItems(uint ulCount, ITfLangBarItem* ppItem, TF_LANGBARITEMINFO* pInfo, uint* pdwStatus, 
                     uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritemmgr-adviseitemssink
    HRESULT AdviseItemsSink(uint ulCount, ITfLangBarItemSink* ppunk, const(GUID)* pguidItem, uint* pdwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritemmgr-unadviseitemssink
    HRESULT UnadviseItemsSink(uint ulCount, uint* pdwCookie);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nn-ctfutb-itflangbaritem
@GUID("73540d69-edeb-4ee9-96c9-23aa30b25916")
interface ITfLangBarItem : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritem-getinfo
    HRESULT GetInfo(TF_LANGBARITEMINFO* pInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritem-getstatus
    HRESULT GetStatus(uint* pdwStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritem-show
    HRESULT Show(BOOL fShow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritem-gettooltipstring
    HRESULT GetTooltipString(BSTR* pbstrToolTip);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nn-ctfutb-itfsystemlangbaritemsink
@GUID("1449d9ab-13cf-4687-aa3e-8d8b18574396")
interface ITfSystemLangBarItemSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itfsystemlangbaritemsink-initmenu
    HRESULT InitMenu(ITfMenu pMenu);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itfsystemlangbaritemsink-onmenuselect
    HRESULT OnMenuSelect(uint wID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nn-ctfutb-itfsystemlangbaritem
@GUID("1e13e9ec-6b33-4d4a-b5eb-8a92f029f356")
interface ITfSystemLangBarItem : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itfsystemlangbaritem-seticon
    HRESULT SetIcon(HICON hIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itfsystemlangbaritem-settooltipstring
    HRESULT SetTooltipString(PWSTR pchToolTip, uint cch);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nn-ctfutb-itfsystemlangbaritemtext
@GUID("5c4ce0e5-ba49-4b52-ac6b-3b397b4f701f")
interface ITfSystemLangBarItemText : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itfsystemlangbaritemtext-setitemtext
    HRESULT SetItemText(const(PWSTR) pch, uint cch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itfsystemlangbaritemtext-getitemtext
    HRESULT GetItemText(BSTR* pbstrText);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nn-ctfutb-itfsystemdevicetypelangbaritem
@GUID("45672eb9-9059-46a2-838d-4530355f6a77")
interface ITfSystemDeviceTypeLangBarItem : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itfsystemdevicetypelangbaritem-seticonmode
    HRESULT SetIconMode(LANG_BAR_ITEM_ICON_MODE_FLAGS dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itfsystemdevicetypelangbaritem-geticonmode
    HRESULT GetIconMode(uint* pdwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nn-ctfutb-itflangbaritembutton
@GUID("28c7f1d0-de25-11d2-afdd-00105a2799b5")
interface ITfLangBarItemButton : ITfLangBarItem
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritembutton-onclick
    HRESULT OnClick(TfLBIClick click, POINT pt, const(RECT)* prcArea);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritembutton-initmenu
    HRESULT InitMenu(ITfMenu pMenu);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritembutton-onmenuselect
    HRESULT OnMenuSelect(uint wID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritembutton-geticon
    HRESULT GetIcon(HICON* phIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritembutton-gettext
    HRESULT GetText(BSTR* pbstrText);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nn-ctfutb-itflangbaritembitmapbutton
@GUID("a26a0525-3fae-4fa0-89ee-88a964f9f1b5")
interface ITfLangBarItemBitmapButton : ITfLangBarItem
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritembitmapbutton-onclick
    HRESULT OnClick(TfLBIClick click, POINT pt, const(RECT)* prcArea);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritembitmapbutton-initmenu
    HRESULT InitMenu(ITfMenu pMenu);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritembitmapbutton-onmenuselect
    HRESULT OnMenuSelect(uint wID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritembitmapbutton-getpreferredsize
    HRESULT GetPreferredSize(const(SIZE)* pszDefault, SIZE* psz);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritembitmapbutton-drawbitmap
    HRESULT DrawBitmap(int bmWidth, int bmHeight, uint dwFlags, HBITMAP* phbmp, HBITMAP* phbmpMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritembitmapbutton-gettext
    HRESULT GetText(BSTR* pbstrText);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nn-ctfutb-itflangbaritembitmap
@GUID("73830352-d722-4179-ada5-f045c98df355")
interface ITfLangBarItemBitmap : ITfLangBarItem
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritembitmap-onclick
    HRESULT OnClick(TfLBIClick click, POINT pt, const(RECT)* prcArea);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritembitmap-getpreferredsize
    HRESULT GetPreferredSize(const(SIZE)* pszDefault, SIZE* psz);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritembitmap-drawbitmap
    HRESULT DrawBitmap(int bmWidth, int bmHeight, uint dwFlags, HBITMAP* phbmp, HBITMAP* phbmpMask);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nn-ctfutb-itflangbaritemballoon
@GUID("01c2d285-d3c7-4b7b-b5b5-d97411d0c283")
interface ITfLangBarItemBalloon : ITfLangBarItem
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritemballoon-onclick
    HRESULT OnClick(TfLBIClick click, POINT pt, const(RECT)* prcArea);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritemballoon-getpreferredsize
    HRESULT GetPreferredSize(const(SIZE)* pszDefault, SIZE* psz);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itflangbaritemballoon-getballooninfo
    HRESULT GetBalloonInfo(TF_LBBALLOONINFO* pInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nn-ctfutb-itfmenu
@GUID("6f8a98e4-aaa0-4f15-8c5b-07e0df0a3dd8")
interface ITfMenu : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfutb/nf-ctfutb-itfmenu-addmenuitem
    HRESULT AddMenuItem(uint uId, uint dwFlags, HBITMAP hbmp, HBITMAP hbmpMask, const(PWSTR) pch, uint cch, 
                        ITfMenu* ppMenu);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfthreadmgr
@GUID("aa80e801-2021-11d2-93e0-0060b067b86e")
interface ITfThreadMgr : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr-activate
    HRESULT Activate(uint* ptid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr-deactivate
    HRESULT Deactivate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr-createdocumentmgr
    HRESULT CreateDocumentMgr(ITfDocumentMgr* ppdim);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr-enumdocumentmgrs
    HRESULT EnumDocumentMgrs(IEnumTfDocumentMgrs* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr-getfocus
    HRESULT GetFocus(ITfDocumentMgr* ppdimFocus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr-setfocus
    HRESULT SetFocus(ITfDocumentMgr pdimFocus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr-associatefocus
    HRESULT AssociateFocus(HWND hwnd, ITfDocumentMgr pdimNew, ITfDocumentMgr* ppdimPrev);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr-isthreadfocus
    HRESULT IsThreadFocus(BOOL* pfThreadFocus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr-getfunctionprovider
    HRESULT GetFunctionProvider(const(GUID)* clsid, ITfFunctionProvider* ppFuncProv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr-enumfunctionproviders
    HRESULT EnumFunctionProviders(IEnumTfFunctionProviders* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr-getglobalcompartment
    HRESULT GetGlobalCompartment(ITfCompartmentMgr* ppCompMgr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfthreadmgrex
@GUID("3e90ade3-7594-4cb0-bb58-69628f5f458c")
interface ITfThreadMgrEx : ITfThreadMgr
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgrex-activateex
    HRESULT ActivateEx(uint* ptid, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgrex-getactiveflags
    HRESULT GetActiveFlags(uint* lpdwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfthreadmgr2
@GUID("0ab198ef-6477-4ee8-8812-6780edb82d5e")
interface ITfThreadMgr2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr2-activate
    HRESULT Activate(uint* ptid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr2-deactivate
    HRESULT Deactivate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr2-createdocumentmgr
    HRESULT CreateDocumentMgr(ITfDocumentMgr* ppdim);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr2-enumdocumentmgrs
    HRESULT EnumDocumentMgrs(IEnumTfDocumentMgrs* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr2-getfocus
    HRESULT GetFocus(ITfDocumentMgr* ppdimFocus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr2-setfocus
    HRESULT SetFocus(ITfDocumentMgr pdimFocus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr2-isthreadfocus
    HRESULT IsThreadFocus(BOOL* pfThreadFocus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr2-getfunctionprovider
    HRESULT GetFunctionProvider(const(GUID)* clsid, ITfFunctionProvider* ppFuncProv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr2-enumfunctionproviders
    HRESULT EnumFunctionProviders(IEnumTfFunctionProviders* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr2-getglobalcompartment
    HRESULT GetGlobalCompartment(ITfCompartmentMgr* ppCompMgr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr2-activateex
    HRESULT ActivateEx(uint* ptid, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr2-getactiveflags
    HRESULT GetActiveFlags(uint* lpdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr2-suspendkeystrokehandling
    HRESULT SuspendKeystrokeHandling();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgr2-resumekeystrokehandling
    HRESULT ResumeKeystrokeHandling();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfthreadmgreventsink
@GUID("aa80e80e-2021-11d2-93e0-0060b067b86e")
interface ITfThreadMgrEventSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgreventsink-oninitdocumentmgr
    HRESULT OnInitDocumentMgr(ITfDocumentMgr pdim);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgreventsink-onuninitdocumentmgr
    HRESULT OnUninitDocumentMgr(ITfDocumentMgr pdim);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgreventsink-onsetfocus
    HRESULT OnSetFocus(ITfDocumentMgr pdimFocus, ITfDocumentMgr pdimPrevFocus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgreventsink-onpushcontext
    HRESULT OnPushContext(ITfContext pic);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadmgreventsink-onpopcontext
    HRESULT OnPopContext(ITfContext pic);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfconfiguresystemkeystrokefeed
@GUID("0d2c969a-bc9c-437c-84ee-951c49b1a764")
interface ITfConfigureSystemKeystrokeFeed : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfconfiguresystemkeystrokefeed-disablesystemkeystrokefeed
    HRESULT DisableSystemKeystrokeFeed();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfconfiguresystemkeystrokefeed-enablesystemkeystrokefeed
    HRESULT EnableSystemKeystrokeFeed();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-ienumtfdocumentmgrs
@GUID("aa80e808-2021-11d2-93e0-0060b067b86e")
interface IEnumTfDocumentMgrs : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfdocumentmgrs-clone
    HRESULT Clone(IEnumTfDocumentMgrs* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfdocumentmgrs-next
    HRESULT Next(uint ulCount, ITfDocumentMgr* rgDocumentMgr, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfdocumentmgrs-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfdocumentmgrs-skip
    HRESULT Skip(uint ulCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfdocumentmgr
@GUID("aa80e7f4-2021-11d2-93e0-0060b067b86e")
interface ITfDocumentMgr : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfdocumentmgr-createcontext
    HRESULT CreateContext(uint tidOwner, uint dwFlags, IUnknown punk, ITfContext* ppic, uint* pecTextStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfdocumentmgr-push
    HRESULT Push(ITfContext pic);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfdocumentmgr-pop
    HRESULT Pop(uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfdocumentmgr-gettop
    HRESULT GetTop(ITfContext* ppic);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfdocumentmgr-getbase
    HRESULT GetBase(ITfContext* ppic);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfdocumentmgr-enumcontexts
    HRESULT EnumContexts(IEnumTfContexts* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-ienumtfcontexts
@GUID("8f1a7ea6-1654-4502-a86e-b2902344d507")
interface IEnumTfContexts : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfcontexts-clone
    HRESULT Clone(IEnumTfContexts* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfcontexts-next
    HRESULT Next(uint ulCount, ITfContext* rgContext, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfcontexts-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfcontexts-skip
    HRESULT Skip(uint ulCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfcompositionview
@GUID("d7540241-f9a1-4364-befc-dbcd2c4395b7")
interface ITfCompositionView : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcompositionview-getownerclsid
    HRESULT GetOwnerClsid(GUID* pclsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcompositionview-getrange
    HRESULT GetRange(ITfRange* ppRange);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-ienumitfcompositionview
@GUID("5efd22ba-7838-46cb-88e2-cadb14124f8f")
interface IEnumITfCompositionView : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumitfcompositionview-clone
    HRESULT Clone(IEnumITfCompositionView* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumitfcompositionview-next
    HRESULT Next(uint ulCount, ITfCompositionView* rgCompositionView, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumitfcompositionview-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumitfcompositionview-skip
    HRESULT Skip(uint ulCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfcomposition
@GUID("20168d64-5a8f-4a5a-b7bd-cfa29f4d0fd9")
interface ITfComposition : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcomposition-getrange
    HRESULT GetRange(ITfRange* ppRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcomposition-shiftstart
    HRESULT ShiftStart(uint ecWrite, ITfRange pNewStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcomposition-shiftend
    HRESULT ShiftEnd(uint ecWrite, ITfRange pNewEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcomposition-endcomposition
    HRESULT EndComposition(uint ecWrite);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfcompositionsink
@GUID("a781718c-579a-4b15-a280-32b8577acc5e")
interface ITfCompositionSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcompositionsink-oncompositionterminated
    HRESULT OnCompositionTerminated(uint ecWrite, ITfComposition pComposition);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfcontextcomposition
@GUID("d40c8aae-ac92-4fc7-9a11-0ee0e23aa39b")
interface ITfContextComposition : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextcomposition-startcomposition
    HRESULT StartComposition(uint ecWrite, ITfRange pCompositionRange, ITfCompositionSink pSink, 
                             ITfComposition* ppComposition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextcomposition-enumcompositions
    HRESULT EnumCompositions(IEnumITfCompositionView* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextcomposition-findcomposition
    HRESULT FindComposition(uint ecRead, ITfRange pTestRange, IEnumITfCompositionView* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextcomposition-takeownership
    HRESULT TakeOwnership(uint ecWrite, ITfCompositionView pComposition, ITfCompositionSink pSink, 
                          ITfComposition* ppComposition);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfcontextownercompositionservices
@GUID("86462810-593b-4916-9764-19c08e9ce110")
interface ITfContextOwnerCompositionServices : ITfContextComposition
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextownercompositionservices-terminatecomposition
    HRESULT TerminateComposition(ITfCompositionView pComposition);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfcontextownercompositionsink
@GUID("5f20aa40-b57a-4f34-96ab-3576f377cc79")
interface ITfContextOwnerCompositionSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextownercompositionsink-onstartcomposition
    HRESULT OnStartComposition(ITfCompositionView pComposition, BOOL* pfOk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextownercompositionsink-onupdatecomposition
    HRESULT OnUpdateComposition(ITfCompositionView pComposition, ITfRange pRangeNew);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextownercompositionsink-onendcomposition
    HRESULT OnEndComposition(ITfCompositionView pComposition);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfcontextview
@GUID("2433bf8e-0f9b-435c-ba2c-180611978c30")
interface ITfContextView : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextview-getrangefrompoint
    HRESULT GetRangeFromPoint(uint ec, const(POINT)* ppt, uint dwFlags, ITfRange* ppRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextview-gettextext
    HRESULT GetTextExt(uint ec, ITfRange pRange, RECT* prc, BOOL* pfClipped);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextview-getscreenext
    HRESULT GetScreenExt(RECT* prc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextview-getwnd
    HRESULT GetWnd(HWND* phwnd);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-ienumtfcontextviews
@GUID("f0c0f8dd-cf38-44e1-bb0f-68cf0d551c78")
interface IEnumTfContextViews : IUnknown
{
    HRESULT Clone(IEnumTfContextViews* ppEnum);
    HRESULT Next(uint ulCount, ITfContextView* rgViews, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfcontext
@GUID("aa80e7fd-2021-11d2-93e0-0060b067b86e")
interface ITfContext : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontext-requesteditsession
    HRESULT RequestEditSession(uint tid, ITfEditSession pes, TF_CONTEXT_EDIT_CONTEXT_FLAGS dwFlags, 
                               HRESULT* phrSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontext-inwritesession
    HRESULT InWriteSession(uint tid, BOOL* pfWriteSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontext-getselection
    HRESULT GetSelection(uint ec, uint ulIndex, uint ulCount, TF_SELECTION* pSelection, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontext-setselection
    HRESULT SetSelection(uint ec, uint ulCount, const(TF_SELECTION)* pSelection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontext-getstart
    HRESULT GetStart(uint ec, ITfRange* ppStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontext-getend
    HRESULT GetEnd(uint ec, ITfRange* ppEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontext-getactiveview
    HRESULT GetActiveView(ITfContextView* ppView);
    HRESULT EnumViews(IEnumTfContextViews* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontext-getstatus
    HRESULT GetStatus(TS_STATUS* pdcs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontext-getproperty
    HRESULT GetProperty(const(GUID)* guidProp, ITfProperty* ppProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontext-getappproperty
    HRESULT GetAppProperty(const(GUID)* guidProp, ITfReadOnlyProperty* ppProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontext-trackproperties
    HRESULT TrackProperties(const(GUID)** prgProp, uint cProp, const(GUID)** prgAppProp, uint cAppProp, 
                            ITfReadOnlyProperty* ppProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontext-enumproperties
    HRESULT EnumProperties(IEnumTfProperties* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontext-getdocumentmgr
    HRESULT GetDocumentMgr(ITfDocumentMgr* ppDm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontext-createrangebackup
    HRESULT CreateRangeBackup(uint ec, ITfRange pRange, ITfRangeBackup* ppBackup);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfqueryembedded
@GUID("0fab9bdb-d250-4169-84e5-6be118fdd7a8")
interface ITfQueryEmbedded : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfqueryembedded-queryinsertembedded
    HRESULT QueryInsertEmbedded(const(GUID)* pguidService, const(FORMATETC)* pFormatEtc, BOOL* pfInsertable);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfinsertatselection
@GUID("55ce16ba-3014-41c1-9ceb-fade1446ac6c")
interface ITfInsertAtSelection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinsertatselection-inserttextatselection
    HRESULT InsertTextAtSelection(uint ec, INSERT_TEXT_AT_SELECTION_FLAGS dwFlags, const(PWSTR) pchText, int cch, 
                                  ITfRange* ppRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinsertatselection-insertembeddedatselection
    HRESULT InsertEmbeddedAtSelection(uint ec, uint dwFlags, IDataObject pDataObject, ITfRange* ppRange);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfcleanupcontextsink
@GUID("01689689-7acb-4e9b-ab7c-7ea46b12b522")
interface ITfCleanupContextSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcleanupcontextsink-oncleanupcontext
    HRESULT OnCleanupContext(uint ecWrite, ITfContext pic);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfcleanupcontextdurationsink
@GUID("45c35144-154e-4797-bed8-d33ae7bf8794")
interface ITfCleanupContextDurationSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcleanupcontextdurationsink-onstartcleanupcontext
    HRESULT OnStartCleanupContext();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcleanupcontextdurationsink-onendcleanupcontext
    HRESULT OnEndCleanupContext();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfreadonlyproperty
@GUID("17d49a3d-f8b8-4b2f-b254-52319dd64c53")
interface ITfReadOnlyProperty : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfreadonlyproperty-gettype
    HRESULT GetType(GUID* pguid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfreadonlyproperty-enumranges
    HRESULT EnumRanges(uint ec, IEnumTfRanges* ppEnum, ITfRange pTargetRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfreadonlyproperty-getvalue
    HRESULT GetValue(uint ec, ITfRange pRange, VARIANT* pvarValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfreadonlyproperty-getcontext
    HRESULT GetContext(ITfContext* ppContext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-ienumtfpropertyvalue
@GUID("8ed8981b-7c10-4d7d-9fb3-ab72e9c75f72")
interface IEnumTfPropertyValue : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfpropertyvalue-clone
    HRESULT Clone(IEnumTfPropertyValue* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfpropertyvalue-next
    HRESULT Next(uint ulCount, TF_PROPERTYVAL* rgValues, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfpropertyvalue-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfpropertyvalue-skip
    HRESULT Skip(uint ulCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfmousetracker
@GUID("09d146cd-a544-4132-925b-7afa8ef322d0")
interface ITfMouseTracker : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfmousetracker-advisemousesink
    HRESULT AdviseMouseSink(ITfRange range, ITfMouseSink pSink, uint* pdwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfmousetracker-unadvisemousesink
    HRESULT UnadviseMouseSink(uint dwCookie);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfmousetrackeracp
@GUID("3bdd78e2-c16e-47fd-b883-ce6facc1a208")
interface ITfMouseTrackerACP : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfmousetrackeracp-advisemousesink
    HRESULT AdviseMouseSink(ITfRangeACP range, ITfMouseSink pSink, uint* pdwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfmousetrackeracp-unadvisemousesink
    HRESULT UnadviseMouseSink(uint dwCookie);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfmousesink
@GUID("a1adaaa2-3a24-449d-ac96-5183e7f5c217")
interface ITfMouseSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfmousesink-onmouseevent
    HRESULT OnMouseEvent(uint uEdge, uint uQuadrant, uint dwBtnStatus, BOOL* pfEaten);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfeditrecord
@GUID("42d4d099-7c1a-4a89-b836-6c6f22160df0")
interface ITfEditRecord : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfeditrecord-getselectionstatus
    HRESULT GetSelectionStatus(BOOL* pfChanged);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfeditrecord-gettextandpropertyupdates
    HRESULT GetTextAndPropertyUpdates(GET_TEXT_AND_PROPERTY_UPDATES_FLAGS dwFlags, const(GUID)** prgProperties, 
                                      uint cProperties, IEnumTfRanges* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itftexteditsink
@GUID("8127d409-ccd3-4683-967a-b43d5b482bf7")
interface ITfTextEditSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itftexteditsink-onendedit
    HRESULT OnEndEdit(ITfContext pic, uint ecReadOnly, ITfEditRecord pEditRecord);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itftextlayoutsink
@GUID("2af2d06a-dd5b-4927-a0b4-54f19c91fade")
interface ITfTextLayoutSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itftextlayoutsink-onlayoutchange
    HRESULT OnLayoutChange(ITfContext pic, TfLayoutCode lcode, ITfContextView pView);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfstatussink
@GUID("6b7d8d73-b267-4f69-b32e-1ca321ce4f45")
interface ITfStatusSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfstatussink-onstatuschange
    HRESULT OnStatusChange(ITfContext pic, uint dwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfedittransactionsink
@GUID("708fbf70-b520-416b-b06c-2c41ab44f8ba")
interface ITfEditTransactionSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfedittransactionsink-onstartedittransaction
    HRESULT OnStartEditTransaction(ITfContext pic);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfedittransactionsink-onendedittransaction
    HRESULT OnEndEditTransaction(ITfContext pic);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfcontextowner
@GUID("aa80e80c-2021-11d2-93e0-0060b067b86e")
interface ITfContextOwner : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextowner-getacpfrompoint
    HRESULT GetACPFromPoint(const(POINT)* ptScreen, uint dwFlags, int* pacp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextowner-gettextext
    HRESULT GetTextExt(int acpStart, int acpEnd, RECT* prc, BOOL* pfClipped);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextowner-getscreenext
    HRESULT GetScreenExt(RECT* prc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextowner-getstatus
    HRESULT GetStatus(TS_STATUS* pdcs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextowner-getwnd
    HRESULT GetWnd(HWND* phwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextowner-getattribute
    HRESULT GetAttribute(const(GUID)* rguidAttribute, VARIANT* pvarValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfcontextownerservices
@GUID("b23eb630-3e1c-11d3-a745-0050040ab407")
interface ITfContextOwnerServices : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextownerservices-onlayoutchange
    HRESULT OnLayoutChange();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextownerservices-onstatuschange
    HRESULT OnStatusChange(uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextownerservices-onattributechange
    HRESULT OnAttributeChange(const(GUID)* rguidAttribute);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextownerservices-serialize
    HRESULT Serialize(ITfProperty pProp, ITfRange pRange, TF_PERSISTENT_PROPERTY_HEADER_ACP* pHdr, IStream pStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextownerservices-unserialize
    HRESULT Unserialize(ITfProperty pProp, const(TF_PERSISTENT_PROPERTY_HEADER_ACP)* pHdr, IStream pStream, 
                        ITfPersistentPropertyLoaderACP pLoader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextownerservices-forceloadproperty
    HRESULT ForceLoadProperty(ITfProperty pProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextownerservices-createrange
    HRESULT CreateRange(int acpStart, int acpEnd, ITfRangeACP* ppRange);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfcontextkeyeventsink
@GUID("0552ba5d-c835-4934-bf50-846aaa67432f")
interface ITfContextKeyEventSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextkeyeventsink-onkeydown
    HRESULT OnKeyDown(WPARAM wParam, LPARAM lParam, BOOL* pfEaten);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextkeyeventsink-onkeyup
    HRESULT OnKeyUp(WPARAM wParam, LPARAM lParam, BOOL* pfEaten);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextkeyeventsink-ontestkeydown
    HRESULT OnTestKeyDown(WPARAM wParam, LPARAM lParam, BOOL* pfEaten);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcontextkeyeventsink-ontestkeyup
    HRESULT OnTestKeyUp(WPARAM wParam, LPARAM lParam, BOOL* pfEaten);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfeditsession
@GUID("aa80e803-2021-11d2-93e0-0060b067b86e")
interface ITfEditSession : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfeditsession-doeditsession
    HRESULT DoEditSession(uint ec);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfrange
@GUID("aa80e7ff-2021-11d2-93e0-0060b067b86e")
interface ITfRange : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-gettext
    HRESULT GetText(uint ec, uint dwFlags, PWSTR pchText, uint cchMax, uint* pcch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-settext
    HRESULT SetText(uint ec, uint dwFlags, const(PWSTR) pchText, int cch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-getformattedtext
    HRESULT GetFormattedText(uint ec, IDataObject* ppDataObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-getembedded
    HRESULT GetEmbedded(uint ec, const(GUID)* rguidService, const(GUID)* riid, IUnknown* ppunk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-insertembedded
    HRESULT InsertEmbedded(uint ec, uint dwFlags, IDataObject pDataObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-shiftstart
    HRESULT ShiftStart(uint ec, int cchReq, int* pcch, const(TF_HALTCOND)* pHalt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-shiftend
    HRESULT ShiftEnd(uint ec, int cchReq, int* pcch, const(TF_HALTCOND)* pHalt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-shiftstarttorange
    HRESULT ShiftStartToRange(uint ec, ITfRange pRange, TfAnchor aPos);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-shiftendtorange
    HRESULT ShiftEndToRange(uint ec, ITfRange pRange, TfAnchor aPos);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-shiftstartregion
    HRESULT ShiftStartRegion(uint ec, TfShiftDir dir, BOOL* pfNoRegion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-shiftendregion
    HRESULT ShiftEndRegion(uint ec, TfShiftDir dir, BOOL* pfNoRegion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-isempty
    HRESULT IsEmpty(uint ec, BOOL* pfEmpty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-collapse
    HRESULT Collapse(uint ec, TfAnchor aPos);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-isequalstart
    HRESULT IsEqualStart(uint ec, ITfRange pWith, TfAnchor aPos, BOOL* pfEqual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-isequalend
    HRESULT IsEqualEnd(uint ec, ITfRange pWith, TfAnchor aPos, BOOL* pfEqual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-comparestart
    HRESULT CompareStart(uint ec, ITfRange pWith, TfAnchor aPos, int* plResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-compareend
    HRESULT CompareEnd(uint ec, ITfRange pWith, TfAnchor aPos, int* plResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-adjustforinsert
    HRESULT AdjustForInsert(uint ec, uint cchInsert, BOOL* pfInsertOk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-getgravity
    HRESULT GetGravity(TfGravity* pgStart, TfGravity* pgEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-setgravity
    HRESULT SetGravity(uint ec, TfGravity gStart, TfGravity gEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-clone
    HRESULT Clone(ITfRange* ppClone);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrange-getcontext
    HRESULT GetContext(ITfContext* ppContext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfrangeacp
@GUID("057a6296-029b-4154-b79a-0d461d4ea94c")
interface ITfRangeACP : ITfRange
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrangeacp-getextent
    HRESULT GetExtent(int* pacpAnchor, int* pcch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrangeacp-setextent
    HRESULT SetExtent(int acpAnchor, int cch);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itextstoreacpservices
@GUID("aa80e901-2021-11d2-93e0-0060b067b86e")
interface ITextStoreACPServices : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itextstoreacpservices-serialize
    HRESULT Serialize(ITfProperty pProp, ITfRange pRange, TF_PERSISTENT_PROPERTY_HEADER_ACP* pHdr, IStream pStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itextstoreacpservices-unserialize
    HRESULT Unserialize(ITfProperty pProp, const(TF_PERSISTENT_PROPERTY_HEADER_ACP)* pHdr, IStream pStream, 
                        ITfPersistentPropertyLoaderACP pLoader);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itextstoreacpservices-forceloadproperty
    HRESULT ForceLoadProperty(ITfProperty pProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itextstoreacpservices-createrange
    HRESULT CreateRange(int acpStart, int acpEnd, ITfRangeACP* ppRange);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfrangebackup
@GUID("463a506d-6992-49d2-9b88-93d55e70bb16")
interface ITfRangeBackup : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfrangebackup-restore
    HRESULT Restore(uint ec, ITfRange pRange);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfpropertystore
@GUID("6834b120-88cb-11d2-bf45-00105a2799b5")
interface ITfPropertyStore : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfpropertystore-gettype
    HRESULT GetType(GUID* pguid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfpropertystore-getdatatype
    HRESULT GetDataType(uint* pdwReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfpropertystore-getdata
    HRESULT GetData(VARIANT* pvarValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfpropertystore-ontextupdated
    HRESULT OnTextUpdated(uint dwFlags, ITfRange pRangeNew, BOOL* pfAccept);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfpropertystore-shrink
    HRESULT Shrink(ITfRange pRangeNew, BOOL* pfFree);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfpropertystore-divide
    HRESULT Divide(ITfRange pRangeThis, ITfRange pRangeNew, ITfPropertyStore* ppPropStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfpropertystore-clone
    HRESULT Clone(ITfPropertyStore* pPropStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfpropertystore-getpropertyrangecreator
    HRESULT GetPropertyRangeCreator(GUID* pclsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfpropertystore-serialize
    HRESULT Serialize(IStream pStream, uint* pcb);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-ienumtfranges
@GUID("f99d3f40-8e32-11d2-bf46-00105a2799b5")
interface IEnumTfRanges : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfranges-clone
    HRESULT Clone(IEnumTfRanges* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfranges-next
    HRESULT Next(uint ulCount, ITfRange* ppRange, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfranges-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfranges-skip
    HRESULT Skip(uint ulCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfcreatepropertystore
@GUID("2463fbf0-b0af-11d2-afc5-00105a2799b5")
interface ITfCreatePropertyStore : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcreatepropertystore-isstoreserializable
    HRESULT IsStoreSerializable(const(GUID)* guidProp, ITfRange pRange, ITfPropertyStore pPropStore, 
                                BOOL* pfSerializable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcreatepropertystore-createpropertystore
    HRESULT CreatePropertyStore(const(GUID)* guidProp, ITfRange pRange, uint cb, IStream pStream, 
                                ITfPropertyStore* ppStore);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfpersistentpropertyloaderacp
@GUID("4ef89150-0807-11d3-8df0-00105a2799b5")
interface ITfPersistentPropertyLoaderACP : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfpersistentpropertyloaderacp-loadproperty
    HRESULT LoadProperty(const(TF_PERSISTENT_PROPERTY_HEADER_ACP)* pHdr, IStream* ppStream);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfproperty
@GUID("e2449660-9542-11d2-bf46-00105a2799b5")
interface ITfProperty : ITfReadOnlyProperty
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfproperty-findrange
    HRESULT FindRange(uint ec, ITfRange pRange, ITfRange* ppRange, TfAnchor aPos);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfproperty-setvaluestore
    HRESULT SetValueStore(uint ec, ITfRange pRange, ITfPropertyStore pPropStore);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfproperty-setvalue
    HRESULT SetValue(uint ec, ITfRange pRange, const(VARIANT)* pvarValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfproperty-clear
    HRESULT Clear(uint ec, ITfRange pRange);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-ienumtfproperties
@GUID("19188cb0-aca9-11d2-afc5-00105a2799b5")
interface IEnumTfProperties : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfproperties-clone
    HRESULT Clone(IEnumTfProperties* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfproperties-next
    HRESULT Next(uint ulCount, ITfProperty* ppProp, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfproperties-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfproperties-skip
    HRESULT Skip(uint ulCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfcompartment
@GUID("bb08f7a9-607a-4384-8623-056892b64371")
interface ITfCompartment : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcompartment-setvalue
    HRESULT SetValue(uint tid, const(VARIANT)* pvarValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcompartment-getvalue
    HRESULT GetValue(VARIANT* pvarValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfcompartmenteventsink
@GUID("743abd5f-f26d-48df-8cc5-238492419b64")
interface ITfCompartmentEventSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcompartmenteventsink-onchange
    HRESULT OnChange(const(GUID)* rguid);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfcompartmentmgr
@GUID("7dcf57ac-18ad-438b-824d-979bffb74b7c")
interface ITfCompartmentMgr : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcompartmentmgr-getcompartment
    HRESULT GetCompartment(const(GUID)* rguid, ITfCompartment* ppcomp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcompartmentmgr-clearcompartment
    HRESULT ClearCompartment(uint tid, const(GUID)* rguid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcompartmentmgr-enumcompartments
    HRESULT EnumCompartments(IEnumGUID* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itffunction
@GUID("db593490-098f-11d3-8df0-00105a2799b5")
interface ITfFunction : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itffunction-getdisplayname
    HRESULT GetDisplayName(BSTR* pbstrName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itffunctionprovider
@GUID("101d6610-0990-11d3-8df0-00105a2799b5")
interface ITfFunctionProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itffunctionprovider-gettype
    HRESULT GetType(GUID* pguid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itffunctionprovider-getdescription
    HRESULT GetDescription(BSTR* pbstrDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itffunctionprovider-getfunction
    HRESULT GetFunction(const(GUID)* rguid, const(GUID)* riid, IUnknown* ppunk);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-ienumtffunctionproviders
@GUID("e4b24db0-0990-11d3-8df0-00105a2799b5")
interface IEnumTfFunctionProviders : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtffunctionproviders-clone
    HRESULT Clone(IEnumTfFunctionProviders* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtffunctionproviders-next
    HRESULT Next(uint ulCount, ITfFunctionProvider* ppCmdobj, uint* pcFetch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtffunctionproviders-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtffunctionproviders-skip
    HRESULT Skip(uint ulCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfinputprocessorprofiles
@GUID("1f02b6c5-7842-4ee6-8a0b-9a24183a95ca")
interface ITfInputProcessorProfiles : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofiles-register
    HRESULT Register(const(GUID)* rclsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofiles-unregister
    HRESULT Unregister(const(GUID)* rclsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofiles-addlanguageprofile
    HRESULT AddLanguageProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, const(PWSTR) pchDesc, 
                               uint cchDesc, const(PWSTR) pchIconFile, uint cchFile, uint uIconIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofiles-removelanguageprofile
    HRESULT RemoveLanguageProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofiles-enuminputprocessorinfo
    HRESULT EnumInputProcessorInfo(IEnumGUID* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofiles-getdefaultlanguageprofile
    HRESULT GetDefaultLanguageProfile(ushort langid, const(GUID)* catid, GUID* pclsid, GUID* pguidProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofiles-setdefaultlanguageprofile
    HRESULT SetDefaultLanguageProfile(ushort langid, const(GUID)* rclsid, const(GUID)* guidProfiles);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofiles-activatelanguageprofile
    HRESULT ActivateLanguageProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfiles);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofiles-getactivelanguageprofile
    HRESULT GetActiveLanguageProfile(const(GUID)* rclsid, ushort* plangid, GUID* pguidProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofiles-getlanguageprofiledescription
    HRESULT GetLanguageProfileDescription(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, 
                                          BSTR* pbstrProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofiles-getcurrentlanguage
    HRESULT GetCurrentLanguage(ushort* plangid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofiles-changecurrentlanguage
    HRESULT ChangeCurrentLanguage(ushort langid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofiles-getlanguagelist
    HRESULT GetLanguageList(ushort** ppLangId, uint* pulCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofiles-enumlanguageprofiles
    HRESULT EnumLanguageProfiles(ushort langid, IEnumTfLanguageProfiles* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofiles-enablelanguageprofile
    HRESULT EnableLanguageProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, BOOL fEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofiles-isenabledlanguageprofile
    HRESULT IsEnabledLanguageProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, BOOL* pfEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofiles-enablelanguageprofilebydefault
    HRESULT EnableLanguageProfileByDefault(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, 
                                           BOOL fEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofiles-substitutekeyboardlayout
    HRESULT SubstituteKeyboardLayout(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, HKL hKL);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfinputprocessorprofilesex
@GUID("892f230f-fe00-4a41-a98e-fcd6de0d35ef")
interface ITfInputProcessorProfilesEx : ITfInputProcessorProfiles
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofilesex-setlanguageprofiledisplayname
    HRESULT SetLanguageProfileDisplayName(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, 
                                          const(PWSTR) pchFile, uint cchFile, uint uResId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfinputprocessorprofilesubstitutelayout
@GUID("4fd67194-1002-4513-bff2-c0ddf6258552")
interface ITfInputProcessorProfileSubstituteLayout : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofilesubstitutelayout-getsubstitutekeyboardlayout
    HRESULT GetSubstituteKeyboardLayout(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, HKL* phKL);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfactivelanguageprofilenotifysink
@GUID("b246cb75-a93e-4652-bf8c-b3fe0cfd7e57")
interface ITfActiveLanguageProfileNotifySink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfactivelanguageprofilenotifysink-onactivated
    HRESULT OnActivated(const(GUID)* clsid, const(GUID)* guidProfile, BOOL fActivated);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-ienumtflanguageprofiles
@GUID("3d61bf11-ac5f-42c8-a4cb-931bcc28c744")
interface IEnumTfLanguageProfiles : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtflanguageprofiles-clone
    HRESULT Clone(IEnumTfLanguageProfiles* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtflanguageprofiles-next
    HRESULT Next(uint ulCount, TF_LANGUAGEPROFILE* pProfile, uint* pcFetch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtflanguageprofiles-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtflanguageprofiles-skip
    HRESULT Skip(uint ulCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itflanguageprofilenotifysink
@GUID("43c9fe15-f494-4c17-9de2-b8a4ac350aa8")
interface ITfLanguageProfileNotifySink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itflanguageprofilenotifysink-onlanguagechange
    HRESULT OnLanguageChange(ushort langid, BOOL* pfAccept);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itflanguageprofilenotifysink-onlanguagechanged
    HRESULT OnLanguageChanged();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfinputprocessorprofilemgr
@GUID("71c6e74c-0f28-11d8-a82a-00065b84435c")
interface ITfInputProcessorProfileMgr : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofilemgr-activateprofile
    HRESULT ActivateProfile(uint dwProfileType, ushort langid, const(GUID)* clsid, const(GUID)* guidProfile, 
                            HKL hkl, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofilemgr-deactivateprofile
    HRESULT DeactivateProfile(uint dwProfileType, ushort langid, const(GUID)* clsid, const(GUID)* guidProfile, 
                              HKL hkl, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofilemgr-getprofile
    HRESULT GetProfile(uint dwProfileType, ushort langid, const(GUID)* clsid, const(GUID)* guidProfile, HKL hkl, 
                       TF_INPUTPROCESSORPROFILE* pProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofilemgr-enumprofiles
    HRESULT EnumProfiles(ushort langid, IEnumTfInputProcessorProfiles* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofilemgr-releaseinputprocessor
    HRESULT ReleaseInputProcessor(const(GUID)* rclsid, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofilemgr-registerprofile
    HRESULT RegisterProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, const(PWSTR) pchDesc, 
                            uint cchDesc, const(PWSTR) pchIconFile, uint cchFile, uint uIconIndex, HKL hklsubstitute, 
                            uint dwPreferredLayout, BOOL bEnabledByDefault, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofilemgr-unregisterprofile
    HRESULT UnregisterProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofilemgr-getactiveprofile
    HRESULT GetActiveProfile(const(GUID)* catid, TF_INPUTPROCESSORPROFILE* pProfile);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-ienumtfinputprocessorprofiles
@GUID("71c6e74d-0f28-11d8-a82a-00065b84435c")
interface IEnumTfInputProcessorProfiles : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfinputprocessorprofiles-clone
    HRESULT Clone(IEnumTfInputProcessorProfiles* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfinputprocessorprofiles-next
    HRESULT Next(uint ulCount, TF_INPUTPROCESSORPROFILE* pProfile, uint* pcFetch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfinputprocessorprofiles-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfinputprocessorprofiles-skip
    HRESULT Skip(uint ulCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfinputprocessorprofileactivationsink
@GUID("71c6e74e-0f28-11d8-a82a-00065b84435c")
interface ITfInputProcessorProfileActivationSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfinputprocessorprofileactivationsink-onactivated
    HRESULT OnActivated(uint dwProfileType, ushort langid, const(GUID)* clsid, const(GUID)* catid, 
                        const(GUID)* guidProfile, HKL hkl, uint dwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfkeystrokemgr
@GUID("aa80e7f0-2021-11d2-93e0-0060b067b86e")
interface ITfKeystrokeMgr : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeystrokemgr-advisekeyeventsink
    HRESULT AdviseKeyEventSink(uint tid, ITfKeyEventSink pSink, BOOL fForeground);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeystrokemgr-unadvisekeyeventsink
    HRESULT UnadviseKeyEventSink(uint tid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeystrokemgr-getforeground
    HRESULT GetForeground(GUID* pclsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeystrokemgr-testkeydown
    HRESULT TestKeyDown(WPARAM wParam, LPARAM lParam, BOOL* pfEaten);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeystrokemgr-testkeyup
    HRESULT TestKeyUp(WPARAM wParam, LPARAM lParam, BOOL* pfEaten);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeystrokemgr-keydown
    HRESULT KeyDown(WPARAM wParam, LPARAM lParam, BOOL* pfEaten);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeystrokemgr-keyup
    HRESULT KeyUp(WPARAM wParam, LPARAM lParam, BOOL* pfEaten);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeystrokemgr-getpreservedkey
    HRESULT GetPreservedKey(ITfContext pic, const(TF_PRESERVEDKEY)* pprekey, GUID* pguid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeystrokemgr-ispreservedkey
    HRESULT IsPreservedKey(const(GUID)* rguid, const(TF_PRESERVEDKEY)* pprekey, BOOL* pfRegistered);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeystrokemgr-preservekey
    HRESULT PreserveKey(uint tid, const(GUID)* rguid, const(TF_PRESERVEDKEY)* prekey, const(PWSTR) pchDesc, 
                        uint cchDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeystrokemgr-unpreservekey
    HRESULT UnpreserveKey(const(GUID)* rguid, const(TF_PRESERVEDKEY)* pprekey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeystrokemgr-setpreservedkeydescription
    HRESULT SetPreservedKeyDescription(const(GUID)* rguid, const(PWSTR) pchDesc, uint cchDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeystrokemgr-getpreservedkeydescription
    HRESULT GetPreservedKeyDescription(const(GUID)* rguid, BSTR* pbstrDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeystrokemgr-simulatepreservedkey
    HRESULT SimulatePreservedKey(ITfContext pic, const(GUID)* rguid, BOOL* pfEaten);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfkeyeventsink
@GUID("aa80e7f5-2021-11d2-93e0-0060b067b86e")
interface ITfKeyEventSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeyeventsink-onsetfocus
    HRESULT OnSetFocus(BOOL fForeground);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeyeventsink-ontestkeydown
    HRESULT OnTestKeyDown(ITfContext pic, WPARAM wParam, LPARAM lParam, BOOL* pfEaten);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeyeventsink-ontestkeyup
    HRESULT OnTestKeyUp(ITfContext pic, WPARAM wParam, LPARAM lParam, BOOL* pfEaten);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeyeventsink-onkeydown
    HRESULT OnKeyDown(ITfContext pic, WPARAM wParam, LPARAM lParam, BOOL* pfEaten);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeyeventsink-onkeyup
    HRESULT OnKeyUp(ITfContext pic, WPARAM wParam, LPARAM lParam, BOOL* pfEaten);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeyeventsink-onpreservedkey
    HRESULT OnPreservedKey(ITfContext pic, const(GUID)* rguid, BOOL* pfEaten);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfkeytraceeventsink
@GUID("1cd4c13b-1c36-4191-a70a-7f3e611f367d")
interface ITfKeyTraceEventSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeytraceeventsink-onkeytracedown
    HRESULT OnKeyTraceDown(WPARAM wParam, LPARAM lParam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfkeytraceeventsink-onkeytraceup
    HRESULT OnKeyTraceUp(WPARAM wParam, LPARAM lParam);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfpreservedkeynotifysink
@GUID("6f77c993-d2b1-446e-853e-5912efc8a286")
interface ITfPreservedKeyNotifySink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfpreservedkeynotifysink-onupdated
    HRESULT OnUpdated(const(TF_PRESERVEDKEY)* pprekey);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfmessagepump
@GUID("8f1b8ad8-0b6b-4874-90c5-bd76011e8f7c")
interface ITfMessagePump : IUnknown
{
    HRESULT PeekMessageA(MSG* pMsg, HWND hwnd, uint wMsgFilterMin, uint wMsgFilterMax, uint wRemoveMsg, 
                         BOOL* pfResult);
    HRESULT GetMessageA(MSG* pMsg, HWND hwnd, uint wMsgFilterMin, uint wMsgFilterMax, BOOL* pfResult);
    HRESULT PeekMessageW(MSG* pMsg, HWND hwnd, uint wMsgFilterMin, uint wMsgFilterMax, uint wRemoveMsg, 
                         BOOL* pfResult);
    HRESULT GetMessageW(MSG* pMsg, HWND hwnd, uint wMsgFilterMin, uint wMsgFilterMax, BOOL* pfResult);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfthreadfocussink
@GUID("c0f1db0c-3a20-405c-a303-96b6010a885f")
interface ITfThreadFocusSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadfocussink-onsetthreadfocus
    HRESULT OnSetThreadFocus();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfthreadfocussink-onkillthreadfocus
    HRESULT OnKillThreadFocus();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itftextinputprocessor
@GUID("aa80e7f7-2021-11d2-93e0-0060b067b86e")
interface ITfTextInputProcessor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itftextinputprocessor-activate
    HRESULT Activate(ITfThreadMgr ptim, uint tid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itftextinputprocessor-deactivate
    HRESULT Deactivate();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itftextinputprocessorex
@GUID("6e4e2102-f9cd-433d-b496-303ce03a6507")
interface ITfTextInputProcessorEx : ITfTextInputProcessor
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itftextinputprocessorex-activateex
    HRESULT ActivateEx(ITfThreadMgr ptim, uint tid, uint dwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfclientid
@GUID("d60a7b49-1b9f-4be2-b702-47e9dc05dec3")
interface ITfClientId : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfclientid-getclientid
    HRESULT GetClientId(const(GUID)* rclsid, uint* ptid);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfdisplayattributeinfo
@GUID("70528852-2f26-4aea-8c96-215150578932")
interface ITfDisplayAttributeInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfdisplayattributeinfo-getguid
    HRESULT GetGUID(GUID* pguid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfdisplayattributeinfo-getdescription
    HRESULT GetDescription(BSTR* pbstrDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfdisplayattributeinfo-getattributeinfo
    HRESULT GetAttributeInfo(TF_DISPLAYATTRIBUTE* pda);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfdisplayattributeinfo-setattributeinfo
    HRESULT SetAttributeInfo(const(TF_DISPLAYATTRIBUTE)* pda);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfdisplayattributeinfo-reset
    HRESULT Reset();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-ienumtfdisplayattributeinfo
@GUID("7cef04d7-cb75-4e80-a7ab-5f5bc7d332de")
interface IEnumTfDisplayAttributeInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfdisplayattributeinfo-clone
    HRESULT Clone(IEnumTfDisplayAttributeInfo* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfdisplayattributeinfo-next
    HRESULT Next(uint ulCount, ITfDisplayAttributeInfo* rgInfo, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfdisplayattributeinfo-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfdisplayattributeinfo-skip
    HRESULT Skip(uint ulCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfdisplayattributeprovider
@GUID("fee47777-163c-4769-996a-6e9c50ad8f54")
interface ITfDisplayAttributeProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfdisplayattributeprovider-enumdisplayattributeinfo
    HRESULT EnumDisplayAttributeInfo(IEnumTfDisplayAttributeInfo* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfdisplayattributeprovider-getdisplayattributeinfo
    HRESULT GetDisplayAttributeInfo(const(GUID)* guid, ITfDisplayAttributeInfo* ppInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfdisplayattributemgr
@GUID("8ded7393-5db1-475c-9e71-a39111b0ff67")
interface ITfDisplayAttributeMgr : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfdisplayattributemgr-onupdateinfo
    HRESULT OnUpdateInfo();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfdisplayattributemgr-enumdisplayattributeinfo
    HRESULT EnumDisplayAttributeInfo(IEnumTfDisplayAttributeInfo* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfdisplayattributemgr-getdisplayattributeinfo
    HRESULT GetDisplayAttributeInfo(const(GUID)* guid, ITfDisplayAttributeInfo* ppInfo, GUID* pclsidOwner);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfdisplayattributenotifysink
@GUID("ad56f402-e162-4f25-908f-7d577cf9bda9")
interface ITfDisplayAttributeNotifySink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfdisplayattributenotifysink-onupdateinfo
    HRESULT OnUpdateInfo();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfcategorymgr
@GUID("c3acefb5-f69d-4905-938f-fcadcf4be830")
interface ITfCategoryMgr : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcategorymgr-registercategory
    HRESULT RegisterCategory(const(GUID)* rclsid, const(GUID)* rcatid, const(GUID)* rguid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcategorymgr-unregistercategory
    HRESULT UnregisterCategory(const(GUID)* rclsid, const(GUID)* rcatid, const(GUID)* rguid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcategorymgr-enumcategoriesinitem
    HRESULT EnumCategoriesInItem(const(GUID)* rguid, IEnumGUID* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcategorymgr-enumitemsincategory
    HRESULT EnumItemsInCategory(const(GUID)* rcatid, IEnumGUID* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcategorymgr-findclosestcategory
    HRESULT FindClosestCategory(const(GUID)* rguid, GUID* pcatid, const(GUID)** ppcatidList, uint ulCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcategorymgr-registerguiddescription
    HRESULT RegisterGUIDDescription(const(GUID)* rclsid, const(GUID)* rguid, const(PWSTR) pchDesc, uint cch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcategorymgr-unregisterguiddescription
    HRESULT UnregisterGUIDDescription(const(GUID)* rclsid, const(GUID)* rguid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcategorymgr-getguiddescription
    HRESULT GetGUIDDescription(const(GUID)* rguid, BSTR* pbstrDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcategorymgr-registerguiddword
    HRESULT RegisterGUIDDWORD(const(GUID)* rclsid, const(GUID)* rguid, uint dw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcategorymgr-unregisterguiddword
    HRESULT UnregisterGUIDDWORD(const(GUID)* rclsid, const(GUID)* rguid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcategorymgr-getguiddword
    HRESULT GetGUIDDWORD(const(GUID)* rguid, uint* pdw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcategorymgr-registerguid
    HRESULT RegisterGUID(const(GUID)* rguid, uint* pguidatom);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcategorymgr-getguid
    HRESULT GetGUID(uint guidatom, GUID* pguid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcategorymgr-isequaltfguidatom
    HRESULT IsEqualTfGuidAtom(uint guidatom, const(GUID)* rguid, BOOL* pfEqual);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfsource
@GUID("4ea48a35-60ae-446f-8fd6-e6a8d82459f7")
interface ITfSource : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfsource-advisesink
    HRESULT AdviseSink(const(GUID)* riid, IUnknown punk, uint* pdwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfsource-unadvisesink
    HRESULT UnadviseSink(uint dwCookie);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfsourcesingle
@GUID("73131f9c-56a9-49dd-b0ee-d046633f7528")
interface ITfSourceSingle : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfsourcesingle-advisesinglesink
    HRESULT AdviseSingleSink(uint tid, const(GUID)* riid, IUnknown punk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfsourcesingle-unadvisesinglesink
    HRESULT UnadviseSingleSink(uint tid, const(GUID)* riid);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfuielementmgr
@GUID("ea1ea135-19df-11d7-a6d2-00065b84435c")
interface ITfUIElementMgr : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfuielementmgr-beginuielement
    HRESULT BeginUIElement(ITfUIElement pElement, BOOL* pbShow, uint* pdwUIElementId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfuielementmgr-updateuielement
    HRESULT UpdateUIElement(uint dwUIElementId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfuielementmgr-enduielement
    HRESULT EndUIElement(uint dwUIElementId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfuielementmgr-getuielement
    HRESULT GetUIElement(uint dwUIELementId, ITfUIElement* ppElement);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfuielementmgr-enumuielements
    HRESULT EnumUIElements(IEnumTfUIElements* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-ienumtfuielements
@GUID("887aa91e-acba-4931-84da-3c5208cf543f")
interface IEnumTfUIElements : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfuielements-clone
    HRESULT Clone(IEnumTfUIElements* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfuielements-next
    HRESULT Next(uint ulCount, ITfUIElement* ppElement, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfuielements-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-ienumtfuielements-skip
    HRESULT Skip(uint ulCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfuielementsink
@GUID("ea1ea136-19df-11d7-a6d2-00065b84435c")
interface ITfUIElementSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfuielementsink-beginuielement
    HRESULT BeginUIElement(uint dwUIElementId, BOOL* pbShow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfuielementsink-updateuielement
    HRESULT UpdateUIElement(uint dwUIElementId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfuielementsink-enduielement
    HRESULT EndUIElement(uint dwUIElementId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfuielement
@GUID("ea1ea137-19df-11d7-a6d2-00065b84435c")
interface ITfUIElement : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfuielement-getdescription
    HRESULT GetDescription(BSTR* pbstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfuielement-getguid
    HRESULT GetGUID(GUID* pguid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfuielement-show
    HRESULT Show(BOOL bShow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfuielement-isshown
    HRESULT IsShown(BOOL* pbShow);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfcandidatelistuielement
@GUID("ea1ea138-19df-11d7-a6d2-00065b84435c")
interface ITfCandidateListUIElement : ITfUIElement
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcandidatelistuielement-getupdatedflags
    HRESULT GetUpdatedFlags(uint* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcandidatelistuielement-getdocumentmgr
    HRESULT GetDocumentMgr(ITfDocumentMgr* ppdim);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcandidatelistuielement-getcount
    HRESULT GetCount(uint* puCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcandidatelistuielement-getselection
    HRESULT GetSelection(uint* puIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcandidatelistuielement-getstring
    HRESULT GetString(uint uIndex, BSTR* pstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcandidatelistuielement-getpageindex
    HRESULT GetPageIndex(uint* pIndex, uint uSize, uint* puPageCnt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcandidatelistuielement-setpageindex
    HRESULT SetPageIndex(uint* pIndex, uint uPageCnt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcandidatelistuielement-getcurrentpage
    HRESULT GetCurrentPage(uint* puPage);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfcandidatelistuielementbehavior
@GUID("85fad185-58ce-497a-9460-355366b64b9a")
interface ITfCandidateListUIElementBehavior : ITfCandidateListUIElement
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcandidatelistuielementbehavior-setselection
    HRESULT SetSelection(uint nIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcandidatelistuielementbehavior-finalize
    HRESULT Finalize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfcandidatelistuielementbehavior-abort
    HRESULT Abort();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfreadinginformationuielement
@GUID("ea1ea139-19df-11d7-a6d2-00065b84435c")
interface ITfReadingInformationUIElement : ITfUIElement
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfreadinginformationuielement-getupdatedflags
    HRESULT GetUpdatedFlags(uint* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfreadinginformationuielement-getcontext
    HRESULT GetContext(ITfContext* ppic);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfreadinginformationuielement-getstring
    HRESULT GetString(BSTR* pstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfreadinginformationuielement-getmaxreadingstringlength
    HRESULT GetMaxReadingStringLength(uint* pcchMax);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfreadinginformationuielement-geterrorindex
    HRESULT GetErrorIndex(uint* pErrorIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfreadinginformationuielement-isverticalorderpreferred
    HRESULT IsVerticalOrderPreferred(BOOL* pfVertical);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itftransitoryextensionuielement
@GUID("858f956a-972f-42a2-a2f2-0321e1abe209")
interface ITfTransitoryExtensionUIElement : ITfUIElement
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itftransitoryextensionuielement-getdocumentmgr
    HRESULT GetDocumentMgr(ITfDocumentMgr* ppdim);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itftransitoryextensionsink
@GUID("a615096f-1c57-4813-8a15-55ee6e5a839c")
interface ITfTransitoryExtensionSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itftransitoryextensionsink-ontransitoryextensionupdated
    HRESULT OnTransitoryExtensionUpdated(ITfContext pic, uint ecReadOnly, ITfRange pResultRange, 
                                         ITfRange pCompositionRange, BOOL* pfDeleteResultRange);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itftooltipuielement
@GUID("52b18b5c-555d-46b2-b00a-fa680144fbdb")
interface ITfToolTipUIElement : ITfUIElement
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itftooltipuielement-getstring
    HRESULT GetString(BSTR* pstr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfreverseconversionlist
@GUID("151d69f0-86f4-4674-b721-56911e797f47")
interface ITfReverseConversionList : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfreverseconversionlist-getlength
    HRESULT GetLength(uint* puIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfreverseconversionlist-getstring
    HRESULT GetString(uint uIndex, BSTR* pbstr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfreverseconversion
@GUID("a415e162-157d-417d-8a8c-0ab26c7d2781")
interface ITfReverseConversion : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfreverseconversion-doreverseconversion
    HRESULT DoReverseConversion(const(PWSTR) lpstr, ITfReverseConversionList* ppList);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nn-msctf-itfreverseconversionmgr
@GUID("b643c236-c493-41b6-abb3-692412775cc4")
interface ITfReverseConversionMgr : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msctf/nf-msctf-itfreverseconversionmgr-getreverseconversion
    HRESULT GetReverseConversion(ushort langid, const(GUID)* guidProfile, uint dwflag, 
                                 ITfReverseConversion* ppReverseConversion);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-itfcandidatestring
@GUID("581f317e-fd9d-443f-b972-ed00467c5d40")
interface ITfCandidateString : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itfcandidatestring-getstring
    HRESULT GetString(BSTR* pbstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itfcandidatestring-getindex
    HRESULT GetIndex(uint* pnIndex);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-ienumtfcandidates
@GUID("defb1926-6c80-4ce8-87d4-d6b72b812bde")
interface IEnumTfCandidates : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-ienumtfcandidates-clone
    HRESULT Clone(IEnumTfCandidates* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-ienumtfcandidates-next
    HRESULT Next(uint ulCount, ITfCandidateString* ppCand, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-ienumtfcandidates-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-ienumtfcandidates-skip
    HRESULT Skip(uint ulCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-itfcandidatelist
@GUID("a3ad50fb-9bdb-49e3-a843-6c76520fbf5d")
interface ITfCandidateList : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itfcandidatelist-enumcandidates
    HRESULT EnumCandidates(IEnumTfCandidates* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itfcandidatelist-getcandidate
    HRESULT GetCandidate(uint nIndex, ITfCandidateString* ppCand);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itfcandidatelist-getcandidatenum
    HRESULT GetCandidateNum(uint* pnCnt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itfcandidatelist-setresult
    HRESULT SetResult(uint nIndex, TfCandidateResult imcr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-itffnreconversion
@GUID("4cea93c0-0a58-11d3-8df0-00105a2799b5")
interface ITfFnReconversion : ITfFunction
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnreconversion-queryrange
    HRESULT QueryRange(ITfRange pRange, ITfRange* ppNewRange, BOOL* pfConvertable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnreconversion-getreconversion
    HRESULT GetReconversion(ITfRange pRange, ITfCandidateList* ppCandList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnreconversion-reconvert
    HRESULT Reconvert(ITfRange pRange);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-itffnplayback
@GUID("a3a416a4-0f64-11d3-b5b7-00c04fc324a1")
interface ITfFnPlayBack : ITfFunction
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnplayback-queryrange
    HRESULT QueryRange(ITfRange pRange, ITfRange* ppNewRange, BOOL* pfPlayable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnplayback-play
    HRESULT Play(ITfRange pRange);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-itffnlangprofileutil
@GUID("a87a8574-a6c1-4e15-99f0-3d3965f548eb")
interface ITfFnLangProfileUtil : ITfFunction
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnlangprofileutil-registeractiveprofiles
    HRESULT RegisterActiveProfiles();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnlangprofileutil-isprofileavailableforlang
    HRESULT IsProfileAvailableForLang(ushort langid, BOOL* pfAvailable);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-itffnconfigure
@GUID("88f567c6-1757-49f8-a1b2-89234c1eeff9")
interface ITfFnConfigure : ITfFunction
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnconfigure-show
    HRESULT Show(HWND hwndParent, ushort langid, const(GUID)* rguidProfile);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-itffnconfigureregisterword
@GUID("bb95808a-6d8f-4bca-8400-5390b586aedf")
interface ITfFnConfigureRegisterWord : ITfFunction
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnconfigureregisterword-show
    HRESULT Show(HWND hwndParent, ushort langid, const(GUID)* rguidProfile, BSTR bstrRegistered);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-itffnconfigureregistereudc
@GUID("b5e26ff5-d7ad-4304-913f-21a2ed95a1b0")
interface ITfFnConfigureRegisterEudc : ITfFunction
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnconfigureregistereudc-show
    HRESULT Show(HWND hwndParent, ushort langid, const(GUID)* rguidProfile, BSTR bstrRegistered);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-itffnshowhelp
@GUID("5ab1d30c-094d-4c29-8ea5-0bf59be87bf3")
interface ITfFnShowHelp : ITfFunction
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnshowhelp-show
    HRESULT Show(HWND hwndParent);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-itffnballoon
@GUID("3bab89e4-5fbe-45f4-a5bc-dca36ad225a8")
interface ITfFnBalloon : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnballoon-updateballoon
    HRESULT UpdateBalloon(TfLBBalloonStyle style, const(PWSTR) pch, uint cch);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-itffngetsapiobject
@GUID("5c0ab7ea-167d-4f59-bfb5-4693755e90ca")
interface ITfFnGetSAPIObject : ITfFunction
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffngetsapiobject-get
    HRESULT Get(TfSapiObject sObj, IUnknown* ppunk);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-itffnpropertyuistatus
@GUID("2338ac6e-2b9d-44c0-a75e-ee64f256b3bd")
interface ITfFnPropertyUIStatus : ITfFunction
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnpropertyuistatus-getstatus
    HRESULT GetStatus(const(GUID)* refguidProp, uint* pdw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnpropertyuistatus-setstatus
    HRESULT SetStatus(const(GUID)* refguidProp, uint dw);
}

@GUID("8c5dac4f-083c-4b85-a4c9-71746048adca")
interface IEnumSpeechCommands : IUnknown
{
    HRESULT Clone(IEnumSpeechCommands* ppEnum);
    HRESULT Next(uint ulCount, ushort** pSpCmds, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

@GUID("38e09d4c-586d-435a-b592-c8a86691dec6")
interface ISpeechCommandProvider : IUnknown
{
    HRESULT EnumSpeechCommands(ushort langid, IEnumSpeechCommands* ppEnum);
    HRESULT ProcessCommand(const(PWSTR) pszCommand, uint cch, ushort langid);
}

@GUID("fca6c349-a12f-43a3-8dd6-5a5a4282577b")
interface ITfFnCustomSpeechCommand : ITfFunction
{
    HRESULT SetSpeechCommandProvider(IUnknown pspcmdProvider);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-itffnlmprocessor
@GUID("7afbf8e7-ac4b-4082-b058-890899d3a010")
interface ITfFnLMProcessor : ITfFunction
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnlmprocessor-queryrange
    HRESULT QueryRange(ITfRange pRange, ITfRange* ppNewRange, BOOL* pfAccepted);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnlmprocessor-querylangid
    HRESULT QueryLangID(ushort langid, BOOL* pfAccepted);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnlmprocessor-getreconversion
    HRESULT GetReconversion(ITfRange pRange, ITfCandidateList* ppCandList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnlmprocessor-reconvert
    HRESULT Reconvert(ITfRange pRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnlmprocessor-querykey
    HRESULT QueryKey(BOOL fUp, WPARAM vKey, LPARAM lparamKeydata, BOOL* pfInterested);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnlmprocessor-invokekey
    HRESULT InvokeKey(BOOL fUp, WPARAM vKey, LPARAM lparamKeyData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnlmprocessor-invokefunc
    HRESULT InvokeFunc(ITfContext pic, const(GUID)* refguidFunc);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-itffnlminternal
@GUID("04b825b1-ac9a-4f7b-b5ad-c7168f1ee445")
interface ITfFnLMInternal : ITfFnLMProcessor
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnlminternal-processlattice
    HRESULT ProcessLattice(ITfRange pRange);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-ienumtflatticeelements
@GUID("56988052-47da-4a05-911a-e3d941f17145")
interface IEnumTfLatticeElements : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-ienumtflatticeelements-clone
    HRESULT Clone(IEnumTfLatticeElements* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-ienumtflatticeelements-next
    HRESULT Next(uint ulCount, TF_LMLATTELEMENT* rgsElements, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-ienumtflatticeelements-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-ienumtflatticeelements-skip
    HRESULT Skip(uint ulCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-itflmlattice
@GUID("d4236675-a5bf-4570-9d42-5d6d7b02d59b")
interface ITfLMLattice : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itflmlattice-querytype
    HRESULT QueryType(const(GUID)* rguidType, BOOL* pfSupported);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itflmlattice-enumlatticeelements
    HRESULT EnumLatticeElements(uint dwFrameStart, const(GUID)* rguidType, IEnumTfLatticeElements* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-itffnadvisetext
@GUID("3527268b-7d53-4dd9-92b7-7296ae461249")
interface ITfFnAdviseText : ITfFunction
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnadvisetext-ontextupdate
    HRESULT OnTextUpdate(ITfRange pRange, const(PWSTR) pchText, int cch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnadvisetext-onlatticeupdate
    HRESULT OnLatticeUpdate(ITfRange pRange, ITfLMLattice pLattice);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-itffnsearchcandidateprovider
@GUID("87a2ad8f-f27b-4920-8501-67602280175d")
interface ITfFnSearchCandidateProvider : ITfFunction
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnsearchcandidateprovider-getsearchcandidates
    HRESULT GetSearchCandidates(BSTR bstrQuery, BSTR bstrApplicationId, ITfCandidateList* pplist);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffnsearchcandidateprovider-setresult
    HRESULT SetResult(BSTR bstrQuery, BSTR bstrApplicationID, BSTR bstrResult);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-itfintegratablecandidatelistuielement
@GUID("c7a6f54f-b180-416f-b2bf-7bf2e4683d7b")
interface ITfIntegratableCandidateListUIElement : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itfintegratablecandidatelistuielement-setintegrationstyle
    HRESULT SetIntegrationStyle(GUID guidIntegrationStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itfintegratablecandidatelistuielement-getselectionstyle
    HRESULT GetSelectionStyle(TfIntegratableCandidateListSelectionStyle* ptfSelectionStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itfintegratablecandidatelistuielement-onkeydown
    HRESULT OnKeyDown(WPARAM wParam, LPARAM lParam, BOOL* pfEaten);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itfintegratablecandidatelistuielement-showcandidatenumbers
    HRESULT ShowCandidateNumbers(BOOL* pfShow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itfintegratablecandidatelistuielement-finalizeexactcompositionstring
    HRESULT FinalizeExactCompositionString();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-itffngetpreferredtouchkeyboardlayout
@GUID("5f309a41-590a-4acc-a97f-d8efff13fdfc")
interface ITfFnGetPreferredTouchKeyboardLayout : ITfFunction
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffngetpreferredtouchkeyboardlayout-getlayout
    HRESULT GetLayout(TKBLayoutType* pTKBLayoutType, ushort* pwPreferredLayoutId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-itffngetlinguisticalternates
@GUID("ea163ce2-7a65-4506-82a3-c528215da64e")
interface ITfFnGetLinguisticAlternates : ITfFunction
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-itffngetlinguisticalternates-getalternates
    HRESULT GetAlternates(ITfRange pRange, ITfCandidateList* ppCandidateList);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nn-ctffunc-iuimanagereventsink
@GUID("cd91d690-a7e8-4265-9b38-8bb3bbaba7de")
interface IUIManagerEventSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-iuimanagereventsink-onwindowopening
    HRESULT OnWindowOpening(RECT* prcBounds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-iuimanagereventsink-onwindowopened
    HRESULT OnWindowOpened(RECT* prcBounds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-iuimanagereventsink-onwindowupdating
    HRESULT OnWindowUpdating(RECT* prcUpdatedBounds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-iuimanagereventsink-onwindowupdated
    HRESULT OnWindowUpdated(RECT* prcUpdatedBounds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-iuimanagereventsink-onwindowclosing
    HRESULT OnWindowClosing();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctffunc/nf-ctffunc-iuimanagereventsink-onwindowclosed
    HRESULT OnWindowClosed();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inputscope/nn-inputscope-itfinputscope
@GUID("fde1eaee-6924-4cdf-91e7-da38cff5559d")
interface ITfInputScope : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inputscope/nf-inputscope-itfinputscope-getinputscopes
    HRESULT GetInputScopes(InputScope** pprgInputScopes, uint* pcCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inputscope/nf-inputscope-itfinputscope-getphrase
    HRESULT GetPhrase(BSTR** ppbstrPhrases, uint* pcCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inputscope/nf-inputscope-itfinputscope-getregularexpression
    HRESULT GetRegularExpression(BSTR* pbstrRegExp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inputscope/nf-inputscope-itfinputscope-getsrgs
    HRESULT GetSRGS(BSTR* pbstrSRGS);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inputscope/nf-inputscope-itfinputscope-getxml
    HRESULT GetXML(BSTR* pbstrXML);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inputscope/nn-inputscope-itfinputscope2
@GUID("5731eaa0-6bc2-4681-a532-92fbb74d7c41")
interface ITfInputScope2 : ITfInputScope
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inputscope/nf-inputscope-itfinputscope2-enumwordlist
    HRESULT EnumWordList(IEnumString* ppEnumString);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nn-msaatext-itfmsaacontrol
@GUID("b5f8fb3b-393f-4f7c-84cb-504924c2705a")
interface ITfMSAAControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-itfmsaacontrol-systemenablemsaa
    HRESULT SystemEnableMSAA();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-itfmsaacontrol-systemdisablemsaa
    HRESULT SystemDisableMSAA();
}

@GUID("e1aa6466-9db4-40ba-be03-77c38e8e60b2")
interface IInternalDocWrap : IUnknown
{
    HRESULT NotifyRevoke();
}

@GUID("a2de3bc2-3d8e-11d3-81a9-f753fbe61a00")
interface ITextStoreACPEx : IUnknown
{
    HRESULT ScrollToRect(int acpStart, int acpEnd, RECT rc, uint dwPosition);
}

@GUID("a2de3bc1-3d8e-11d3-81a9-f753fbe61a00")
interface ITextStoreAnchorEx : IUnknown
{
    HRESULT ScrollToRect(IAnchor pStart, IAnchor pEnd, RECT rc, uint dwPosition);
}

@GUID("2bdf9464-41e2-43e3-950c-a6865ba25cd4")
interface ITextStoreACPSinkEx : ITextStoreACPSink
{
    HRESULT OnDisconnect();
}

@GUID("25642426-028d-4474-977b-111bb114fe3e")
interface ITextStoreSinkAnchorEx : ITextStoreAnchorSink
{
    HRESULT OnDisconnect();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nn-msaatext-iaccdictionary
@GUID("1dc4cb5f-d737-474d-ade9-5ccfc9bc1cc9")
interface IAccDictionary : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-iaccdictionary-getlocalizedstring
    HRESULT GetLocalizedString(const(GUID)* Term, uint lcid, BSTR* pResult, uint* plcid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-iaccdictionary-getparentterm
    HRESULT GetParentTerm(const(GUID)* Term, GUID* pParentTerm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-iaccdictionary-getmnemonicstring
    HRESULT GetMnemonicString(const(GUID)* Term, BSTR* pResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-iaccdictionary-lookupmnemonicterm
    HRESULT LookupMnemonicTerm(BSTR bstrMnemonic, GUID* pTerm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-iaccdictionary-convertvaluetostring
    HRESULT ConvertValueToString(const(GUID)* Term, uint lcid, VARIANT varValue, BSTR* pbstrResult, uint* plcid);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nn-msaatext-iversioninfo
@GUID("401518ec-db00-4611-9b29-2a0e4b9afa85")
interface IVersionInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-iversioninfo-getsubcomponentcount
    HRESULT GetSubcomponentCount(uint ulSub, uint* ulCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-iversioninfo-getimplementationid
    HRESULT GetImplementationID(uint ulSub, GUID* implid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-iversioninfo-getbuildversion
    HRESULT GetBuildVersion(uint ulSub, uint* pdwMajor, uint* pdwMinor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-iversioninfo-getcomponentdescription
    HRESULT GetComponentDescription(uint ulSub, BSTR* pImplStr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-iversioninfo-getinstancedescription
    HRESULT GetInstanceDescription(uint ulSub, BSTR* pImplStr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nn-msaatext-icocreatelocally
@GUID("03de00aa-f272-41e3-99cb-03c5e8114ea0")
interface ICoCreateLocally : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-icocreatelocally-cocreatelocally
    HRESULT CoCreateLocally(const(GUID)* rclsid, uint dwClsContext, const(GUID)* riid, IUnknown* punk, 
                            const(GUID)* riidParam, IUnknown punkParam, VARIANT varParam);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nn-msaatext-icocreatedlocally
@GUID("0a53eb6c-1908-4742-8cff-2cee2e93f94c")
interface ICoCreatedLocally : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-icocreatedlocally-localinit
    HRESULT LocalInit(IUnknown punkLocalObject, const(GUID)* riidParam, IUnknown punkParam, VARIANT varParam);
}

@GUID("e2cd4a63-2b72-4d48-b739-95e4765195ba")
interface IAccStore : IUnknown
{
    HRESULT Register(const(GUID)* riid, IUnknown punk);
    HRESULT Unregister(IUnknown punk);
    HRESULT GetDocuments(IEnumUnknown* enumUnknown);
    HRESULT LookupByHWND(HWND hWnd, const(GUID)* riid, IUnknown* ppunk);
    HRESULT LookupByPoint(POINT pt, const(GUID)* riid, IUnknown* ppunk);
    HRESULT OnDocumentFocus(IUnknown punk);
    HRESULT GetFocused(const(GUID)* riid, IUnknown* ppunk);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nn-msaatext-iaccserverdocmgr
@GUID("ad7c73cf-6dd5-4855-abc2-b04bad5b9153")
interface IAccServerDocMgr : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-iaccserverdocmgr-newdocument
    HRESULT NewDocument(const(GUID)* riid, IUnknown punk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-iaccserverdocmgr-revokedocument
    HRESULT RevokeDocument(IUnknown punk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-iaccserverdocmgr-ondocumentfocus
    HRESULT OnDocumentFocus(IUnknown punk);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nn-msaatext-iaccclientdocmgr
@GUID("4c896039-7b6d-49e6-a8c1-45116a98292b")
interface IAccClientDocMgr : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-iaccclientdocmgr-getdocuments
    HRESULT GetDocuments(IEnumUnknown* enumUnknown);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-iaccclientdocmgr-lookupbyhwnd
    HRESULT LookupByHWND(HWND hWnd, const(GUID)* riid, IUnknown* ppunk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-iaccclientdocmgr-lookupbypoint
    HRESULT LookupByPoint(POINT pt, const(GUID)* riid, IUnknown* ppunk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msaatext/nf-msaatext-iaccclientdocmgr-getfocused
    HRESULT GetFocused(const(GUID)* riid, IUnknown* ppunk);
}

@GUID("dcd285fe-0be0-43bd-99c9-aaaec513c555")
interface IDocWrap : IUnknown
{
    HRESULT SetDoc(const(GUID)* riid, IUnknown punk);
    HRESULT GetWrappedDoc(const(GUID)* riid, IUnknown* ppunk);
}

@GUID("b33e75ff-e84c-4dca-a25c-33b8dc003374")
interface IClonableWrapper : IUnknown
{
    HRESULT CloneNewWrapper(const(GUID)* riid, void** ppv);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfspui/nn-ctfspui-itfspeechuiserver
@GUID("90e9a944-9244-489f-a78f-de67afc013a7")
interface ITfSpeechUIServer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfspui/nf-ctfspui-itfspeechuiserver-initialize
    HRESULT Initialize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfspui/nf-ctfspui-itfspeechuiserver-showui
    HRESULT ShowUI(BOOL fShow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ctfspui/nf-ctfspui-itfspeechuiserver-updateballoon
    HRESULT UpdateBalloon(TfLBBalloonStyle style, const(PWSTR) pch, uint cch);
}


// GUIDs

const GUID CLSID_AccClientDocMgr = GUIDOF!AccClientDocMgr;
const GUID CLSID_AccDictionary   = GUIDOF!AccDictionary;
const GUID CLSID_AccServerDocMgr = GUIDOF!AccServerDocMgr;
const GUID CLSID_AccStore        = GUIDOF!AccStore;
const GUID CLSID_DocWrap         = GUIDOF!DocWrap;
const GUID CLSID_MSAAControl     = GUIDOF!MSAAControl;

const GUID IID_IAccClientDocMgr                         = GUIDOF!IAccClientDocMgr;
const GUID IID_IAccDictionary                           = GUIDOF!IAccDictionary;
const GUID IID_IAccServerDocMgr                         = GUIDOF!IAccServerDocMgr;
const GUID IID_IAccStore                                = GUIDOF!IAccStore;
const GUID IID_IAnchor                                  = GUIDOF!IAnchor;
const GUID IID_IClonableWrapper                         = GUIDOF!IClonableWrapper;
const GUID IID_ICoCreateLocally                         = GUIDOF!ICoCreateLocally;
const GUID IID_ICoCreatedLocally                        = GUIDOF!ICoCreatedLocally;
const GUID IID_IDocWrap                                 = GUIDOF!IDocWrap;
const GUID IID_IEnumITfCompositionView                  = GUIDOF!IEnumITfCompositionView;
const GUID IID_IEnumSpeechCommands                      = GUIDOF!IEnumSpeechCommands;
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
const GUID IID_IInternalDocWrap                         = GUIDOF!IInternalDocWrap;
const GUID IID_ISpeechCommandProvider                   = GUIDOF!ISpeechCommandProvider;
const GUID IID_ITextStoreACP                            = GUIDOF!ITextStoreACP;
const GUID IID_ITextStoreACP2                           = GUIDOF!ITextStoreACP2;
const GUID IID_ITextStoreACPEx                          = GUIDOF!ITextStoreACPEx;
const GUID IID_ITextStoreACPServices                    = GUIDOF!ITextStoreACPServices;
const GUID IID_ITextStoreACPSink                        = GUIDOF!ITextStoreACPSink;
const GUID IID_ITextStoreACPSinkEx                      = GUIDOF!ITextStoreACPSinkEx;
const GUID IID_ITextStoreAnchor                         = GUIDOF!ITextStoreAnchor;
const GUID IID_ITextStoreAnchorEx                       = GUIDOF!ITextStoreAnchorEx;
const GUID IID_ITextStoreAnchorSink                     = GUIDOF!ITextStoreAnchorSink;
const GUID IID_ITextStoreSinkAnchorEx                   = GUIDOF!ITextStoreSinkAnchorEx;
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
const GUID IID_ITfFnCustomSpeechCommand                 = GUIDOF!ITfFnCustomSpeechCommand;
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
const GUID IID_IVersionInfo                             = GUIDOF!IVersionInfo;
