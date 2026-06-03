// Written in the D programming language.

module windows.win32.system.addressbook;

public import windows.core;
public import windows.win32.foundation : BOOL, FILETIME, HINSTANCE, HRESULT, HWND,
                                         PSTR, PWSTR;
public import windows.win32.system.com : CY, IMalloc, IStream, IUnknown;
public import windows.win32.system.com.structuredstorage : IStorage;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/gender
enum Gender : int
{
    genderUnspecified = 0x00000000,
    genderFemale      = 0x00000001,
    genderMale        = 0x00000002,
}

// Constants


enum : uint
{
    PROP_ID_SECURE_MIN = 0x000067f0U,
    PROP_ID_SECURE_MAX = 0x000067ffU,
}

enum uint MAPI_DIM = 0x00000001U;
enum uint fMapiUnicode = 0x00000000U;
enum uint hrSuccess = 0x00000000U;

enum : uint
{
    MAPI_P1        = 0x10000000U,
    MAPI_SUBMITTED = 0x80000000U,
    MAPI_SHORTTERM = 0x00000080U,
}

enum uint MAPI_NOTRECIP = 0x00000040U;
enum uint MAPI_THISSESSION = 0x00000020U;

enum : uint
{
    MAPI_NOW         = 0x00000010U,
    MAPI_NOTRESERVED = 0x00000008U,
}

enum uint MAPI_COMPOUND = 0x00000080U;

enum : uint
{
    cchProfileNameMax = 0x00000040U,
    cchProfilePassMax = 0x00000040U,
}

enum uint MV_FLAG = 0x00001000U;

enum : uint
{
    PROP_ID_NULL    = 0x00000000U,
    PROP_ID_INVALID = 0x0000ffffU,
}

enum uint MV_INSTANCE = 0x00002000U;

enum : uint
{
    TABLE_CHANGED      = 0x00000001U,
    TABLE_ERROR        = 0x00000002U,
    TABLE_ROW_ADDED    = 0x00000003U,
    TABLE_ROW_DELETED  = 0x00000004U,
    TABLE_ROW_MODIFIED = 0x00000005U,
}

enum uint TABLE_SORT_DONE = 0x00000006U;
enum uint TABLE_RESTRICT_DONE = 0x00000007U;
enum uint TABLE_SETCOL_DONE = 0x00000008U;
enum uint TABLE_RELOAD = 0x00000009U;
// Native encoding: ansi
enum const(wchar)* szMAPINotificationMsg = "MAPI Notify window message";
enum int MAPI_ERROR_VERSION = 0x00000000;
enum uint MAPI_USE_DEFAULT = 0x00000040U;

enum : uint
{
    MNID_ID     = 0x00000000U,
    MNID_STRING = 0x00000001U,
}

enum uint WAB_LOCAL_CONTAINERS = 0x00100000U;
enum uint WAB_PROFILE_CONTENTS = 0x00200000U;
enum uint WAB_IGNORE_PROFILES = 0x00800000U;
enum uint MAPI_ONE_OFF_NO_RICH_INFO = 0x00000001U;
enum uint UI_SERVICE = 0x00000002U;

enum : uint
{
    SERVICE_UI_ALWAYS  = 0x00000002U,
    SERVICE_UI_ALLOWED = 0x00000010U,
}

enum uint UI_CURRENT_PROVIDER_FIRST = 0x00000004U;
enum uint WABOBJECT_LDAPURL_RETURN_MAILUSER = 0x00000001U;

enum : uint
{
    WABOBJECT_ME_NEW      = 0x00000001U,
    WABOBJECT_ME_NOCREATE = 0x00000002U,
}

enum : uint
{
    WAB_VCARD_FILE   = 0x00000000U,
    WAB_VCARD_STREAM = 0x00000001U,
}

enum uint WAB_USE_OE_SENDMAIL = 0x00000001U;
enum uint WAB_ENABLE_PROFILES = 0x00400000U;
enum uint WAB_DISPLAY_LDAPURL = 0x00000001U;
enum uint WAB_CONTEXT_ADRLIST = 0x00000002U;
enum uint WAB_DISPLAY_ISNTDS = 0x00000004U;

enum : const(wchar)*
{
    WAB_DLL_NAME     = "WAB32.DLL",
    WAB_DLL_PATH_KEY = "Software\\Microsoft\\WAB\\DLLPath",
}

enum HRESULT E_IMAPI_REQUEST_CANCELLED = HRESULT(0xc0aa0002);
enum HRESULT E_IMAPI_RECORDER_REQUIRED = HRESULT(0xc0aa0003);
enum HRESULT S_IMAPI_SPEEDADJUSTED = HRESULT(0x00aa0004);
enum HRESULT S_IMAPI_ROTATIONADJUSTED = HRESULT(0x00aa0005);
enum HRESULT S_IMAPI_BOTHADJUSTED = HRESULT(0x00aa0006);
enum HRESULT E_IMAPI_BURN_VERIFICATION_FAILED = HRESULT(0xc0aa0007);
enum HRESULT S_IMAPI_COMMAND_HAS_SENSE_DATA = HRESULT(0x00aa0200);

enum : HRESULT
{
    E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE               = HRESULT(0xc0aa0201),
    E_IMAPI_RECORDER_MEDIA_NO_MEDIA                  = HRESULT(0xc0aa0202),
    E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE              = HRESULT(0xc0aa0203),
    E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN               = HRESULT(0xc0aa0204),
    E_IMAPI_RECORDER_MEDIA_BECOMING_READY            = HRESULT(0xc0aa0205),
    E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS        = HRESULT(0xc0aa0206),
    E_IMAPI_RECORDER_MEDIA_BUSY                      = HRESULT(0xc0aa0207),
    E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS         = HRESULT(0xc0aa0208),
    E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED           = HRESULT(0xc0aa0209),
    E_IMAPI_RECORDER_NO_SUCH_FEATURE                 = HRESULT(0xc0aa020a),
    E_IMAPI_RECORDER_FEATURE_IS_NOT_CURRENT          = HRESULT(0xc0aa020b),
    E_IMAPI_RECORDER_GET_CONFIGURATION_NOT_SUPPORTED = HRESULT(0xc0aa020c),
}

enum : HRESULT
{
    E_IMAPI_RECORDER_COMMAND_TIMEOUT              = HRESULT(0xc0aa020d),
    E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT    = HRESULT(0xc0aa020e),
    E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH         = HRESULT(0xc0aa020f),
    E_IMAPI_RECORDER_LOCKED                       = HRESULT(0xc0aa0210),
    E_IMAPI_RECORDER_CLIENT_NAME_IS_NOT_VALID     = HRESULT(0xc0aa0211),
    E_IMAPI_RECORDER_MEDIA_NOT_FORMATTED          = HRESULT(0xc0aa0212),
    E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE = HRESULT(0xc0aa02ff),
}

enum HRESULT E_IMAPI_LOSS_OF_STREAMING = HRESULT(0xc0aa0300);
enum HRESULT E_IMAPI_UNEXPECTED_RESPONSE_FROM_DEVICE = HRESULT(0xc0aa0301);
enum HRESULT S_IMAPI_WRITE_NOT_IN_PROGRESS = HRESULT(0x00aa0302);

enum : HRESULT
{
    E_IMAPI_DF2DATA_WRITE_IN_PROGRESS                  = HRESULT(0xc0aa0400),
    E_IMAPI_DF2DATA_WRITE_NOT_IN_PROGRESS              = HRESULT(0xc0aa0401),
    E_IMAPI_DF2DATA_INVALID_MEDIA_STATE                = HRESULT(0xc0aa0402),
    E_IMAPI_DF2DATA_STREAM_NOT_SUPPORTED               = HRESULT(0xc0aa0403),
    E_IMAPI_DF2DATA_STREAM_TOO_LARGE_FOR_CURRENT_MEDIA = HRESULT(0xc0aa0404),
}

enum : HRESULT
{
    E_IMAPI_DF2DATA_MEDIA_NOT_BLANK          = HRESULT(0xc0aa0405),
    E_IMAPI_DF2DATA_MEDIA_IS_NOT_SUPPORTED   = HRESULT(0xc0aa0406),
    E_IMAPI_DF2DATA_RECORDER_NOT_SUPPORTED   = HRESULT(0xc0aa0407),
    E_IMAPI_DF2DATA_CLIENT_NAME_IS_NOT_VALID = HRESULT(0xc0aa0408),
}

enum : HRESULT
{
    E_IMAPI_DF2TAO_WRITE_IN_PROGRESS             = HRESULT(0xc0aa0500),
    E_IMAPI_DF2TAO_WRITE_NOT_IN_PROGRESS         = HRESULT(0xc0aa0501),
    E_IMAPI_DF2TAO_MEDIA_IS_NOT_PREPARED         = HRESULT(0xc0aa0502),
    E_IMAPI_DF2TAO_MEDIA_IS_PREPARED             = HRESULT(0xc0aa0503),
    E_IMAPI_DF2TAO_PROPERTY_FOR_BLANK_MEDIA_ONLY = HRESULT(0xc0aa0504),
}

enum HRESULT E_IMAPI_DF2TAO_TABLE_OF_CONTENTS_EMPTY_DISC = HRESULT(0xc0aa0505);

enum : HRESULT
{
    E_IMAPI_DF2TAO_MEDIA_IS_NOT_BLANK       = HRESULT(0xc0aa0506),
    E_IMAPI_DF2TAO_MEDIA_IS_NOT_SUPPORTED   = HRESULT(0xc0aa0507),
    E_IMAPI_DF2TAO_TRACK_LIMIT_REACHED      = HRESULT(0xc0aa0508),
    E_IMAPI_DF2TAO_NOT_ENOUGH_SPACE         = HRESULT(0xc0aa0509),
    E_IMAPI_DF2TAO_NO_RECORDER_SPECIFIED    = HRESULT(0xc0aa050a),
    E_IMAPI_DF2TAO_INVALID_ISRC             = HRESULT(0xc0aa050b),
    E_IMAPI_DF2TAO_INVALID_MCN              = HRESULT(0xc0aa050c),
    E_IMAPI_DF2TAO_STREAM_NOT_SUPPORTED     = HRESULT(0xc0aa050d),
    E_IMAPI_DF2TAO_RECORDER_NOT_SUPPORTED   = HRESULT(0xc0aa050e),
    E_IMAPI_DF2TAO_CLIENT_NAME_IS_NOT_VALID = HRESULT(0xc0aa050f),
}

enum : HRESULT
{
    E_IMAPI_DF2RAW_WRITE_IN_PROGRESS        = HRESULT(0xc0aa0600),
    E_IMAPI_DF2RAW_WRITE_NOT_IN_PROGRESS    = HRESULT(0xc0aa0601),
    E_IMAPI_DF2RAW_MEDIA_IS_NOT_PREPARED    = HRESULT(0xc0aa0602),
    E_IMAPI_DF2RAW_MEDIA_IS_PREPARED        = HRESULT(0xc0aa0603),
    E_IMAPI_DF2RAW_CLIENT_NAME_IS_NOT_VALID = HRESULT(0xc0aa0604),
}

enum : HRESULT
{
    E_IMAPI_DF2RAW_MEDIA_IS_NOT_BLANK            = HRESULT(0xc0aa0606),
    E_IMAPI_DF2RAW_MEDIA_IS_NOT_SUPPORTED        = HRESULT(0xc0aa0607),
    E_IMAPI_DF2RAW_NOT_ENOUGH_SPACE              = HRESULT(0xc0aa0609),
    E_IMAPI_DF2RAW_NO_RECORDER_SPECIFIED         = HRESULT(0xc0aa060a),
    E_IMAPI_DF2RAW_STREAM_NOT_SUPPORTED          = HRESULT(0xc0aa060d),
    E_IMAPI_DF2RAW_DATA_BLOCK_TYPE_NOT_SUPPORTED = HRESULT(0xc0aa060e),
}

enum HRESULT E_IMAPI_DF2RAW_STREAM_LEADIN_TOO_SHORT = HRESULT(0xc0aa060f);
enum HRESULT E_IMAPI_DF2RAW_RECORDER_NOT_SUPPORTED = HRESULT(0xc0aa0610);

enum : HRESULT
{
    E_IMAPI_ERASE_RECORDER_IN_USE             = HRESULT(0x80aa0900),
    E_IMAPI_ERASE_ONLY_ONE_RECORDER_SUPPORTED = HRESULT(0x80aa0901),
}

enum HRESULT E_IMAPI_ERASE_DISC_INFORMATION_TOO_SMALL = HRESULT(0x80aa0902);

enum : HRESULT
{
    E_IMAPI_ERASE_MODE_PAGE_2A_TOO_SMALL = HRESULT(0x80aa0903),
    E_IMAPI_ERASE_MEDIA_IS_NOT_ERASABLE  = HRESULT(0x80aa0904),
}

enum HRESULT E_IMAPI_ERASE_DRIVE_FAILED_ERASE_COMMAND = HRESULT(0x80aa0905);
enum HRESULT E_IMAPI_ERASE_TOOK_LONGER_THAN_ONE_HOUR = HRESULT(0x80aa0906);
enum HRESULT E_IMAPI_ERASE_UNEXPECTED_DRIVE_RESPONSE_DURING_ERASE = HRESULT(0x80aa0907);
enum HRESULT E_IMAPI_ERASE_DRIVE_FAILED_SPINUP_COMMAND = HRESULT(0x80aa0908);
enum HRESULT E_IMAPI_ERASE_MEDIA_IS_NOT_SUPPORTED = HRESULT(0xc0aa0909);
enum HRESULT E_IMAPI_ERASE_RECORDER_NOT_SUPPORTED = HRESULT(0xc0aa090a);
enum HRESULT E_IMAPI_ERASE_CLIENT_NAME_IS_NOT_VALID = HRESULT(0xc0aa090b);

enum : HRESULT
{
    E_IMAPI_RAW_IMAGE_IS_READ_ONLY              = HRESULT(0x80aa0a00),
    E_IMAPI_RAW_IMAGE_TOO_MANY_TRACKS           = HRESULT(0x80aa0a01),
    E_IMAPI_RAW_IMAGE_SECTOR_TYPE_NOT_SUPPORTED = HRESULT(0x80aa0a02),
    E_IMAPI_RAW_IMAGE_NO_TRACKS                 = HRESULT(0x80aa0a03),
    E_IMAPI_RAW_IMAGE_TRACKS_ALREADY_ADDED      = HRESULT(0x80aa0a04),
    E_IMAPI_RAW_IMAGE_INSUFFICIENT_SPACE        = HRESULT(0x80aa0a05),
    E_IMAPI_RAW_IMAGE_TOO_MANY_TRACK_INDEXES    = HRESULT(0x80aa0a06),
    E_IMAPI_RAW_IMAGE_TRACK_INDEX_NOT_FOUND     = HRESULT(0x80aa0a07),
}

enum HRESULT S_IMAPI_RAW_IMAGE_TRACK_INDEX_ALREADY_EXISTS = HRESULT(0x00aa0a08);

enum : HRESULT
{
    E_IMAPI_RAW_IMAGE_TRACK_INDEX_OFFSET_ZERO_CANNOT_BE_CLEARED = HRESULT(0x80aa0a09),
    E_IMAPI_RAW_IMAGE_TRACK_INDEX_TOO_CLOSE_TO_OTHER_INDEX      = HRESULT(0x80aa0a0a),
}

enum uint FACILITY_IMAPI2 = 0x000000aaU;
enum HRESULT IMAPI_E_FSI_INTERNAL_ERROR = HRESULT(0xc0aab100);
enum HRESULT IMAPI_E_INVALID_PARAM = HRESULT(0xc0aab101);

enum : HRESULT
{
    IMAPI_E_READONLY            = HRESULT(0xc0aab102),
    IMAPI_E_NO_OUTPUT           = HRESULT(0xc0aab103),
    IMAPI_E_INVALID_VOLUME_NAME = HRESULT(0xc0aab104),
    IMAPI_E_INVALID_DATE        = HRESULT(0xc0aab105),
}

enum HRESULT IMAPI_E_FILE_SYSTEM_NOT_EMPTY = HRESULT(0xc0aab106);

enum : HRESULT
{
    IMAPI_E_NOT_FILE      = HRESULT(0xc0aab108),
    IMAPI_E_NOT_DIR       = HRESULT(0xc0aab109),
    IMAPI_E_DIR_NOT_EMPTY = HRESULT(0xc0aab10a),
}

enum HRESULT IMAPI_E_NOT_IN_FILE_SYSTEM = HRESULT(0xc0aab10b);
enum HRESULT IMAPI_E_INVALID_PATH = HRESULT(0xc0aab110);
enum HRESULT IMAPI_E_RESTRICTED_NAME_VIOLATION = HRESULT(0xc0aab111);

enum : HRESULT
{
    IMAPI_E_DUP_NAME       = HRESULT(0xc0aab112),
    IMAPI_E_NO_UNIQUE_NAME = HRESULT(0xc0aab113),
}

enum HRESULT IMAPI_E_ITEM_NOT_FOUND = HRESULT(0xc0aab118);
enum HRESULT IMAPI_E_FILE_NOT_FOUND = HRESULT(0xc0aab119);
enum HRESULT IMAPI_E_DIR_NOT_FOUND = HRESULT(0xc0aab11a);

enum : HRESULT
{
    IMAPI_E_IMAGE_SIZE_LIMIT = HRESULT(0xc0aab120),
    IMAPI_E_IMAGE_TOO_BIG    = HRESULT(0xc0aab121),
}

enum : HRESULT
{
    IMAPI_E_DATA_STREAM_INCONSISTENCY  = HRESULT(0xc0aab128),
    IMAPI_E_DATA_STREAM_READ_FAILURE   = HRESULT(0xc0aab129),
    IMAPI_E_DATA_STREAM_CREATE_FAILURE = HRESULT(0xc0aab12a),
}

enum HRESULT IMAPI_E_DIRECTORY_READ_FAILURE = HRESULT(0xc0aab12b);
enum HRESULT IMAPI_E_TOO_MANY_DIRS = HRESULT(0xc0aab130);
enum HRESULT IMAPI_E_ISO9660_LEVELS = HRESULT(0xc0aab131);
enum HRESULT IMAPI_E_DATA_TOO_BIG = HRESULT(0xc0aab132);
enum HRESULT IMAPI_E_INCOMPATIBLE_PREVIOUS_SESSION = HRESULT(0xc0aab133);

enum : HRESULT
{
    IMAPI_E_STASHFILE_OPEN_FAILURE  = HRESULT(0xc0aab138),
    IMAPI_E_STASHFILE_SEEK_FAILURE  = HRESULT(0xc0aab139),
    IMAPI_E_STASHFILE_WRITE_FAILURE = HRESULT(0xc0aab13a),
    IMAPI_E_STASHFILE_READ_FAILURE  = HRESULT(0xc0aab13b),
}

enum HRESULT IMAPI_E_INVALID_WORKING_DIRECTORY = HRESULT(0xc0aab140);
enum HRESULT IMAPI_E_WORKING_DIRECTORY_SPACE = HRESULT(0xc0aab141);
enum HRESULT IMAPI_E_STASHFILE_MOVE = HRESULT(0xc0aab142);

enum : HRESULT
{
    IMAPI_E_BOOT_IMAGE_DATA                    = HRESULT(0xc0aab148),
    IMAPI_E_BOOT_OBJECT_CONFLICT               = HRESULT(0xc0aab149),
    IMAPI_E_BOOT_EMULATION_IMAGE_SIZE_MISMATCH = HRESULT(0xc0aab14a),
}

enum : HRESULT
{
    IMAPI_E_EMPTY_DISC               = HRESULT(0xc0aab150),
    IMAPI_E_NO_SUPPORTED_FILE_SYSTEM = HRESULT(0xc0aab151),
}

enum : HRESULT
{
    IMAPI_E_FILE_SYSTEM_NOT_FOUND              = HRESULT(0xc0aab152),
    IMAPI_E_FILE_SYSTEM_READ_CONSISTENCY_ERROR = HRESULT(0xc0aab153),
    IMAPI_E_FILE_SYSTEM_FEATURE_NOT_SUPPORTED  = HRESULT(0xc0aab154),
}

enum HRESULT IMAPI_E_IMPORT_TYPE_COLLISION_FILE_EXISTS_AS_DIRECTORY = HRESULT(0xc0aab155);

enum : HRESULT
{
    IMAPI_E_IMPORT_SEEK_FAILURE = HRESULT(0xc0aab156),
    IMAPI_E_IMPORT_READ_FAILURE = HRESULT(0xc0aab157),
}

enum HRESULT IMAPI_E_DISC_MISMATCH = HRESULT(0xc0aab158);
enum HRESULT IMAPI_E_IMPORT_MEDIA_NOT_ALLOWED = HRESULT(0xc0aab159);
enum HRESULT IMAPI_E_UDF_NOT_WRITE_COMPATIBLE = HRESULT(0xc0aab15a);
enum HRESULT IMAPI_E_INCOMPATIBLE_MULTISESSION_TYPE = HRESULT(0xc0aab15b);
enum HRESULT IMAPI_E_NO_COMPATIBLE_MULTISESSION_TYPE = HRESULT(0xc0aab15c);
enum HRESULT IMAPI_E_MULTISESSION_NOT_SET = HRESULT(0xc0aab15d);
enum HRESULT IMAPI_E_IMPORT_TYPE_COLLISION_DIRECTORY_EXISTS_AS_FILE = HRESULT(0xc0aab15e);
enum HRESULT IMAPI_S_IMAGE_FEATURE_NOT_SUPPORTED = HRESULT(0x00aab15f);
enum HRESULT IMAPI_E_PROPERTY_NOT_ACCESSIBLE = HRESULT(0xc0aab160);
enum HRESULT IMAPI_E_UDF_REVISION_CHANGE_NOT_ALLOWED = HRESULT(0xc0aab161);
enum HRESULT IMAPI_E_BAD_MULTISESSION_PARAMETER = HRESULT(0xc0aab162);
enum HRESULT IMAPI_E_FILE_SYSTEM_CHANGE_NOT_ALLOWED = HRESULT(0xc0aab163);

enum : HRESULT
{
    IMAPI_E_IMAGEMANAGER_IMAGE_NOT_ALIGNED = HRESULT(0xc0aab200),
    IMAPI_E_IMAGEMANAGER_NO_VALID_VD_FOUND = HRESULT(0xc0aab201),
    IMAPI_E_IMAGEMANAGER_NO_IMAGE          = HRESULT(0xc0aab202),
    IMAPI_E_IMAGEMANAGER_IMAGE_TOO_BIG     = HRESULT(0xc0aab203),
}

enum int MAPI_E_CALL_FAILED = 0x80004005;
enum int MAPI_E_NOT_ENOUGH_MEMORY = 0x8007000e;
enum int MAPI_E_INVALID_PARAMETER = 0x80070057;
enum int MAPI_E_INTERFACE_NOT_SUPPORTED = 0x80004002;
enum int MAPI_E_NO_ACCESS = 0x80070005;
enum uint TAD_ALL_ROWS = 0x00000001U;
enum int PRILOWEST = 0xffff8000;
enum uint PRIHIGHEST = 0x00007fffU;
enum uint PRIUSER = 0x00000000U;
// Native encoding: ansi
enum const(wchar)* OPENSTREAMONFILE = "OpenStreamOnFile";
// Native encoding: ansi
enum const(wchar)* szHrDispatchNotifications = "HrDispatchNotifications";
// Native encoding: ansi
enum const(wchar)* szScCreateConversationIndex = "ScCreateConversationIndex";

// Callbacks

alias LPALLOCATEBUFFER = int function(uint cbSize, void** lppBuffer);
alias LPALLOCATEMORE = int function(uint cbSize, void* lpObject, void** lppBuffer);
alias LPFREEBUFFER = uint function(void* lpBuffer);
alias LPNOTIFCALLBACK = int function(void* lpvContext, uint cNotification, NOTIFICATION* lpNotifications);
alias LPFNABSDI = BOOL function(size_t ulUIParam, void* lpvmsg);
alias LPFNDISMISS = void function(size_t ulUIParam, void* lpvContext);
alias LPFNBUTTON = int function(size_t ulUIParam, void* lpvContext, uint cbEntryID, ENTRYID* lpSelection, 
                                uint ulFlags);
alias CALLERRELEASE = void function(uint ulCallerData, ITableData lpTblData, IMAPITable lpVue);
alias PFNIDLE = BOOL function(void* param0);
alias LPOPENSTREAMONFILE = HRESULT function(LPALLOCATEBUFFER lpAllocateBuffer, LPFREEBUFFER lpFreeBuffer, 
                                            uint ulFlags, byte* lpszFileName, byte* lpszPrefix, IStream* lppStream);
alias LPDISPATCHNOTIFICATIONS = HRESULT function(uint ulFlags);
alias LPCREATECONVERSATIONINDEX = int function(uint cbParent, ubyte* lpbParent, uint* lpcbConvIndex, 
                                               ubyte** lppbConvIndex);
alias LPWABOPEN = HRESULT function(IAddrBook* lppAdrBook, IWABObject* lppWABObject, WAB_PARAM* lpWP, 
                                   uint Reserved2);
alias LPWABOPENEX = HRESULT function(IAddrBook* lppAdrBook, IWABObject* lppWABObject, WAB_PARAM* lpWP, 
                                     uint Reserved, LPALLOCATEBUFFER fnAllocateBuffer, LPALLOCATEMORE fnAllocateMore, 
                                     LPFREEBUFFER fnFreeBuffer);
alias LPWABALLOCATEBUFFER = int function(IWABObject lpWABObject, uint cbSize, void** lppBuffer);
alias LPWABALLOCATEMORE = int function(IWABObject lpWABObject, uint cbSize, void* lpObject, void** lppBuffer);
alias LPWABFREEBUFFER = uint function(IWABObject lpWABObject, void* lpBuffer);

// Structs


struct LPWABACTIONITEM
{
    ptrdiff_t Value;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/entryid
struct ENTRYID
{
    ubyte[4] abFlags;
    ubyte[1] ab; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/mapiuid
struct MAPIUID
{
    ubyte[16] ab;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/sproptagarray
struct SPropTagArray
{
    uint    cValues;
    uint[1] aulPropTag; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/sbinary
struct SBinary
{
    uint   cb;
    ubyte* lpb;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/sshortarray
struct SShortArray
{
    uint   cValues;
    short* lpi;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/sguidarray
struct SGuidArray
{
    uint  cValues;
    GUID* lpguid;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/srealarray
struct SRealArray
{
    uint   cValues;
    float* lpflt;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/slongarray
struct SLongArray
{
    uint cValues;
    int* lpl;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/slargeintegerarray
struct SLargeIntegerArray
{
    uint  cValues;
    long* lpli;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/sdatetimearray
struct SDateTimeArray
{
    uint      cValues;
    FILETIME* lpft;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/sapptimearray
struct SAppTimeArray
{
    uint    cValues;
    double* lpat;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/scurrencyarray
struct SCurrencyArray
{
    uint cValues;
    CY*  lpcur;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/sbinaryarray
struct SBinaryArray
{
    uint     cValues;
    SBinary* lpbin;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/sdoublearray
struct SDoubleArray
{
    uint    cValues;
    double* lpdbl;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/swstringarray
struct SWStringArray
{
    uint   cValues;
    PWSTR* lppszW;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/slpstrarray
struct SLPSTRArray
{
    uint  cValues;
    PSTR* lppszA;
}

union __UPV
{
    short              i;
    int                l;
    uint               ul;
    float              flt;
    double             dbl;
    ushort             b;
    CY                 cur;
    double             at;
    FILETIME           ft;
    PSTR               lpszA;
    SBinary            bin;
    PWSTR              lpszW;
    GUID*              lpguid;
    long               li;
    SShortArray        MVi;
    SLongArray         MVl;
    SRealArray         MVflt;
    SDoubleArray       MVdbl;
    SCurrencyArray     MVcur;
    SAppTimeArray      MVat;
    SDateTimeArray     MVft;
    SBinaryArray       MVbin;
    SLPSTRArray        MVszA;
    SWStringArray      MVszW;
    SGuidArray         MVguid;
    SLargeIntegerArray MVli;
    int                err;
    int                x;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/spropvalue
struct SPropValue
{
    uint  ulPropTag;
    uint  dwAlignPad;
    __UPV Value;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/spropproblem
struct SPropProblem
{
    uint ulIndex;
    uint ulPropTag;
    int  scode;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/spropproblemarray
struct SPropProblemArray
{
    uint            cProblem;
    SPropProblem[1] aProblem; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/flatentry
struct FLATENTRY
{
    uint     cb;
    ubyte[1] abEntry; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/flatentrylist
struct FLATENTRYLIST
{
    uint     cEntries;
    uint     cbEntries;
    ubyte[1] abEntries; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/mtsid
struct MTSID
{
    uint     cb;
    ubyte[1] ab; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/flatmtsidlist
struct FLATMTSIDLIST
{
    uint     cMTSIDs;
    uint     cbMTSIDs;
    ubyte[1] abMTSIDs; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/adrentry
struct ADRENTRY
{
    uint        ulReserved1;
    uint        cValues;
    SPropValue* rgPropVals;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/adrlist
struct ADRLIST
{
    uint        cEntries;
    ADRENTRY[1] aEntries; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/srow
struct SRow
{
    uint        ulAdrEntryPad;
    uint        cValues;
    SPropValue* lpProps;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/srowset
struct SRowSet
{
    uint    cRows;
    SRow[1] aRow; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/mapierror
struct MAPIERROR
{
    uint  ulVersion;
    byte* lpszError;
    byte* lpszComponent;
    uint  ulLowLevelError;
    uint  ulContext;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/error_notification
struct ERROR_NOTIFICATION
{
    uint       cbEntryID;
    ENTRYID*   lpEntryID;
    int        scode;
    uint       ulFlags;
    MAPIERROR* lpMAPIError;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/newmail_notification
struct NEWMAIL_NOTIFICATION
{
    uint     cbEntryID;
    ENTRYID* lpEntryID;
    uint     cbParentID;
    ENTRYID* lpParentID;
    uint     ulFlags;
    byte*    lpszMessageClass;
    uint     ulMessageFlags;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/object_notification
struct OBJECT_NOTIFICATION
{
    uint           cbEntryID;
    ENTRYID*       lpEntryID;
    uint           ulObjType;
    uint           cbParentID;
    ENTRYID*       lpParentID;
    uint           cbOldID;
    ENTRYID*       lpOldID;
    uint           cbOldParentID;
    ENTRYID*       lpOldParentID;
    SPropTagArray* lpPropTagArray;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/table_notification
struct TABLE_NOTIFICATION
{
    uint       ulTableEvent;
    HRESULT    hResult;
    SPropValue propIndex;
    SPropValue propPrior;
    SRow       row;
    uint       ulPad;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/extended_notification
struct EXTENDED_NOTIFICATION
{
    uint   ulEvent;
    uint   cb;
    ubyte* pbEventParameters;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/status_object_notification
struct STATUS_OBJECT_NOTIFICATION
{
    uint        cbEntryID;
    ENTRYID*    lpEntryID;
    uint        cValues;
    SPropValue* lpPropVals;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/notification
struct NOTIFICATION
{
    uint ulEventType;
    uint ulAlignPad;
    union info
    {
        ERROR_NOTIFICATION   err;
        NEWMAIL_NOTIFICATION newmail;
        OBJECT_NOTIFICATION  obj;
        TABLE_NOTIFICATION   tab;
        EXTENDED_NOTIFICATION ext;
        STATUS_OBJECT_NOTIFICATION statobj;
    }
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/mapinameid
struct MAPINAMEID
{
    GUID* lpguid;
    uint  ulKind;
    union Kind
    {
        int   lID;
        PWSTR lpwstrName;
    }
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/ssortorder
struct SSortOrder
{
    uint ulPropTag;
    uint ulOrder;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/ssortorderset
struct SSortOrderSet
{
    uint          cSorts;
    uint          cCategories;
    uint          cExpanded;
    SSortOrder[1] aSort; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/sandrestriction
struct SAndRestriction
{
    uint          cRes;
    SRestriction* lpRes;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/sorrestriction
struct SOrRestriction
{
    uint          cRes;
    SRestriction* lpRes;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/snotrestriction
struct SNotRestriction
{
    uint          ulReserved;
    SRestriction* lpRes;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/scontentrestriction
struct SContentRestriction
{
    uint        ulFuzzyLevel;
    uint        ulPropTag;
    SPropValue* lpProp;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/sbitmaskrestriction
struct SBitMaskRestriction
{
    uint relBMR;
    uint ulPropTag;
    uint ulMask;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/spropertyrestriction
struct SPropertyRestriction
{
    uint        relop;
    uint        ulPropTag;
    SPropValue* lpProp;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/scomparepropsrestriction
struct SComparePropsRestriction
{
    uint relop;
    uint ulPropTag1;
    uint ulPropTag2;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/ssizerestriction
struct SSizeRestriction
{
    uint relop;
    uint ulPropTag;
    uint cb;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/sexistrestriction
struct SExistRestriction
{
    uint ulReserved1;
    uint ulPropTag;
    uint ulReserved2;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/ssubrestriction
struct SSubRestriction
{
    uint          ulSubObject;
    SRestriction* lpRes;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/scommentrestriction
struct SCommentRestriction
{
    uint          cValues;
    SRestriction* lpRes;
    SPropValue*   lpProp;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/srestriction
struct SRestriction
{
    uint rt;
    union res
    {
        SComparePropsRestriction resCompareProps;
        SAndRestriction      resAnd;
        SOrRestriction       resOr;
        SNotRestriction      resNot;
        SContentRestriction  resContent;
        SPropertyRestriction resProperty;
        SBitMaskRestriction  resBitMask;
        SSizeRestriction     resSize;
        SExistRestriction    resExist;
        SSubRestriction      resSub;
        SCommentRestriction  resComment;
    }
}

struct FlagList
{
    uint    cFlags;
    uint[1] ulFlag; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/adrparm
struct ADRPARM
{
    uint          cbABContEntryID;
    ENTRYID*      lpABContEntryID;
    uint          ulFlags;
    void*         lpReserved;
    uint          ulHelpContext;
    byte*         lpszHelpFileName;
    LPFNABSDI     lpfnABSDI;
    LPFNDISMISS   lpfnDismiss;
    void*         lpvDismissContext;
    byte*         lpszCaption;
    byte*         lpszNewEntryTitle;
    byte*         lpszDestWellsTitle;
    uint          cDestFields;
    uint          nDestFieldFocus;
    byte**        lppszDestTitles;
    uint*         lpulDestComps;
    SRestriction* lpContRestriction;
    SRestriction* lpHierRestriction;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/dtbllabel
struct DTBLLABEL
{
    uint ulbLpszLabelName;
    uint ulFlags;
}

struct DTBLEDIT
{
    uint ulbLpszCharsAllowed;
    uint ulFlags;
    uint ulNumCharsAllowed;
    uint ulPropTag;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/dtbllbx
struct DTBLLBX
{
    uint ulFlags;
    uint ulPRSetProperty;
    uint ulPRTableName;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/dtblcombobox
struct DTBLCOMBOBOX
{
    uint ulbLpszCharsAllowed;
    uint ulFlags;
    uint ulNumCharsAllowed;
    uint ulPRPropertyName;
    uint ulPRTableName;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/dtblddlbx
struct DTBLDDLBX
{
    uint ulFlags;
    uint ulPRDisplayProperty;
    uint ulPRSetProperty;
    uint ulPRTableName;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/dtblcheckbox
struct DTBLCHECKBOX
{
    uint ulbLpszLabel;
    uint ulFlags;
    uint ulPRPropertyName;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/dtblgroupbox
struct DTBLGROUPBOX
{
    uint ulbLpszLabel;
    uint ulFlags;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/dtblbutton
struct DTBLBUTTON
{
    uint ulbLpszLabel;
    uint ulFlags;
    uint ulPRControl;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/dtblpage
struct DTBLPAGE
{
    uint ulbLpszLabel;
    uint ulFlags;
    uint ulbLpszComponent;
    uint ulContext;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/dtblradiobutton
struct DTBLRADIOBUTTON
{
    uint ulbLpszLabel;
    uint ulFlags;
    uint ulcButtons;
    uint ulPropTag;
    int  lReturnValue;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/dtblmvlistbox
struct DTBLMVLISTBOX
{
    uint ulFlags;
    uint ulMVPropTag;
}

struct DTBLMVDDLBX
{
    uint ulFlags;
    uint ulMVPropTag;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/dtctl
struct DTCTL
{
    uint   ulCtlType;
    uint   ulCtlFlags;
    ubyte* lpbNotif;
    uint   cbNotif;
    byte*  lpszFilter;
    uint   ulItemID;
    union ctl
    {
        void*            lpv;
        DTBLLABEL*       lplabel;
        DTBLEDIT*        lpedit;
        DTBLLBX*         lplbx;
        DTBLCOMBOBOX*    lpcombobox;
        DTBLDDLBX*       lpddlbx;
        DTBLCHECKBOX*    lpcheckbox;
        DTBLGROUPBOX*    lpgroupbox;
        DTBLBUTTON*      lpbutton;
        DTBLRADIOBUTTON* lpradiobutton;
        DTBLMVLISTBOX*   lpmvlbx;
        DTBLMVDDLBX*     lpmvddlbx;
        DTBLPAGE*        lppage;
    }
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/dtpage
struct DTPAGE
{
    uint   cctl;
    byte*  lpszResourceName;
    union
    {
        byte* lpszComponent;
        uint  ulItemID;
    }
    DTCTL* lpctl;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabapi/ns-wabapi-wab_param
struct WAB_PARAM
{
    uint cbSize;
    HWND hwnd;
    PSTR szFileName;
    uint ulFlags;
    GUID guidPSExt;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabapi/ns-wabapi-wabimportparam
struct WABIMPORTPARAM
{
    uint      cbSize;
    IAddrBook lpAdrBook;
    HWND      hWnd;
    uint      ulFlags;
    PSTR      lpszFileName;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabapi/ns-wabapi-wabextdisplay
struct WABEXTDISPLAY
{
    uint       cbSize;
    IWABObject lpWABObject;
    IAddrBook  lpAdrBook;
    IMAPIProp  lpPropObj;
    BOOL       fReadOnly;
    BOOL       fDataChanged;
    uint       ulFlags;
    void*      lpv;
    byte*      lpsz;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/notifkey
struct NOTIFKEY
{
    uint     cb;
    ubyte[1] ab; // Flexible array
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/createtable
@DllImport("rtm.dll")
int CreateTable(GUID* lpInterface, LPALLOCATEBUFFER lpAllocateBuffer, LPALLOCATEMORE lpAllocateMore, 
                LPFREEBUFFER lpFreeBuffer, void* lpvReserved, uint ulTableType, uint ulPropTagIndexColumn, 
                SPropTagArray* lpSPropTagArrayColumns, ITableData* lppTableData);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/createiprop
@DllImport("MAPI32.dll")
int CreateIProp(GUID* lpInterface, LPALLOCATEBUFFER lpAllocateBuffer, LPALLOCATEMORE lpAllocateMore, 
                LPFREEBUFFER lpFreeBuffer, void* lpvReserved, IPropData* lppPropData);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/mapiinitidle
@DllImport("MAPI32.dll")
int MAPIInitIdle(void* lpvReserved);

@DllImport("MAPI32.dll")
void MAPIDeinitIdle();

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/ftgregisteridleroutine
@DllImport("MAPI32.dll")
void* FtgRegisterIdleRoutine(PFNIDLE lpfnIdle, void* lpvIdleParam, short priIdle, uint csecIdle, ushort iroIdle);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/deregisteridleroutine
@DllImport("MAPI32.dll")
void DeregisterIdleRoutine(void* ftg);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/enableidleroutine
@DllImport("MAPI32.dll")
void EnableIdleRoutine(void* ftg, BOOL fEnable);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/changeidleroutine
@DllImport("MAPI32.dll")
void ChangeIdleRoutine(void* ftg, PFNIDLE lpfnIdle, void* lpvIdleParam, short priIdle, uint csecIdle, 
                       ushort iroIdle, ushort ircIdle);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/mapigetdefaultmalloc
@DllImport("MAPI32.dll")
IMalloc MAPIGetDefaultMalloc();

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/openstreamonfile
@DllImport("MAPI32.dll")
HRESULT OpenStreamOnFile(LPALLOCATEBUFFER lpAllocateBuffer, LPFREEBUFFER lpFreeBuffer, uint ulFlags, 
                         byte* lpszFileName, byte* lpszPrefix, IStream* lppStream);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/propcopymore
@DllImport("MAPI32.dll")
int PropCopyMore(SPropValue* lpSPropValueDest, SPropValue* lpSPropValueSrc, LPALLOCATEMORE lpfAllocMore, 
                 void* lpvObject);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/ulpropsize
@DllImport("MAPI32.dll")
uint UlPropSize(SPropValue* lpSPropValue);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/fequalnames
@DllImport("MAPI32.dll")
BOOL FEqualNames(MAPINAMEID* lpName1, MAPINAMEID* lpName2);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/fpropcontainsprop
@DllImport("MAPI32.dll")
BOOL FPropContainsProp(SPropValue* lpSPropValueDst, SPropValue* lpSPropValueSrc, uint ulFuzzyLevel);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/fpropcompareprop
@DllImport("MAPI32.dll")
BOOL FPropCompareProp(SPropValue* lpSPropValue1, uint ulRelOp, SPropValue* lpSPropValue2);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/lpropcompareprop
@DllImport("MAPI32.dll")
int LPropCompareProp(SPropValue* lpSPropValueA, SPropValue* lpSPropValueB);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/hraddcolumns
@DllImport("MAPI32.dll")
HRESULT HrAddColumns(IMAPITable lptbl, SPropTagArray* lpproptagColumnsNew, LPALLOCATEBUFFER lpAllocateBuffer, 
                     LPFREEBUFFER lpFreeBuffer);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/hraddcolumnsex
@DllImport("MAPI32.dll")
HRESULT HrAddColumnsEx(IMAPITable lptbl, SPropTagArray* lpproptagColumnsNew, LPALLOCATEBUFFER lpAllocateBuffer, 
                       LPFREEBUFFER lpFreeBuffer, ptrdiff_t lpfnFilterColumns);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/hrallocadvisesink
@DllImport("MAPI32.dll")
HRESULT HrAllocAdviseSink(LPNOTIFCALLBACK lpfnCallback, void* lpvContext, IMAPIAdviseSink* lppAdviseSink);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/hrthisthreadadvisesink
@DllImport("MAPI32.dll")
HRESULT HrThisThreadAdviseSink(IMAPIAdviseSink lpAdviseSink, IMAPIAdviseSink* lppAdviseSink);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/hrdispatchnotifications
@DllImport("MAPI32.dll")
HRESULT HrDispatchNotifications(uint ulFlags);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/builddisplaytable
@DllImport("MAPI32.dll")
HRESULT BuildDisplayTable(LPALLOCATEBUFFER lpAllocateBuffer, LPALLOCATEMORE lpAllocateMore, 
                          LPFREEBUFFER lpFreeBuffer, IMalloc lpMalloc, HINSTANCE hInstance, uint cPages, 
                          DTPAGE* lpPage, uint ulFlags, IMAPITable* lppTable, ITableData* lppTblData);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/sccountnotifications
@DllImport("MAPI32.dll")
int ScCountNotifications(int cNotifications, NOTIFICATION* lpNotifications, uint* lpcb);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/sccopynotifications
@DllImport("MAPI32.dll")
int ScCopyNotifications(int cNotification, NOTIFICATION* lpNotifications, void* lpvDst, uint* lpcb);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/screlocnotifications
@DllImport("MAPI32.dll")
int ScRelocNotifications(int cNotification, NOTIFICATION* lpNotifications, void* lpvBaseOld, void* lpvBaseNew, 
                         uint* lpcb);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/sccountprops
@DllImport("MAPI32.dll")
int ScCountProps(int cValues, SPropValue* lpPropArray, uint* lpcb);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/lpvalfindprop
@DllImport("MAPI32.dll")
SPropValue* LpValFindProp(uint ulPropTag, uint cValues, SPropValue* lpPropArray);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/sccopyprops
@DllImport("MAPI32.dll")
int ScCopyProps(int cValues, SPropValue* lpPropArray, void* lpvDst, uint* lpcb);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/screlocprops
@DllImport("MAPI32.dll")
int ScRelocProps(int cValues, SPropValue* lpPropArray, void* lpvBaseOld, void* lpvBaseNew, uint* lpcb);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/scduppropset
@DllImport("MAPI32.dll")
int ScDupPropset(int cValues, SPropValue* lpPropArray, LPALLOCATEBUFFER lpAllocateBuffer, 
                 SPropValue** lppPropArray);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/uladdref
@DllImport("MAPI32.dll")
uint UlAddRef(void* lpunk);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/ulrelease
@DllImport("MAPI32.dll")
uint UlRelease(void* lpunk);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/hrgetoneprop
@DllImport("MAPI32.dll")
HRESULT HrGetOneProp(IMAPIProp lpMapiProp, uint ulPropTag, SPropValue** lppProp);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/hrsetoneprop
@DllImport("MAPI32.dll")
HRESULT HrSetOneProp(IMAPIProp lpMapiProp, SPropValue* lpProp);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/fpropexists
@DllImport("MAPI32.dll")
BOOL FPropExists(IMAPIProp lpMapiProp, uint ulPropTag);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/ppropfindprop
@DllImport("MAPI32.dll")
SPropValue* PpropFindProp(SPropValue* lpPropArray, uint cValues, uint ulPropTag);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/freepadrlist
@DllImport("MAPI32.dll")
void FreePadrlist(ADRLIST* lpAdrlist);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/freeprows
@DllImport("MAPI32.dll")
void FreeProws(SRowSet* lpRows);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/hrqueryallrows
@DllImport("MAPI32.dll")
HRESULT HrQueryAllRows(IMAPITable lpTable, SPropTagArray* lpPropTags, SRestriction* lpRestriction, 
                       SSortOrderSet* lpSortOrderSet, int crowsMax, SRowSet** lppRows);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/szfindch
@DllImport("MAPI32.dll")
byte* SzFindCh(byte* lpsz, ushort ch);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/szfindlastch
@DllImport("MAPI32.dll")
byte* SzFindLastCh(byte* lpsz, ushort ch);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/szfindsz
@DllImport("MAPI32.dll")
byte* SzFindSz(byte* lpsz, byte* lpszKey);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/ufromsz
@DllImport("MAPI32.dll")
uint UFromSz(byte* lpsz);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/scuncfromlocalpath
@DllImport("MAPI32.dll")
int ScUNCFromLocalPath(PSTR lpszLocal, PSTR lpszUNC, uint cchUNC);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/sclocalpathfromunc
@DllImport("MAPI32.dll")
int ScLocalPathFromUNC(PSTR lpszUNC, PSTR lpszLocal, uint cchLocal);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/ftaddft
@DllImport("MAPI32.dll")
FILETIME FtAddFt(FILETIME ftAddend1, FILETIME ftAddend2);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/ftmuldwdw
@DllImport("MAPI32.dll")
FILETIME FtMulDwDw(uint ftMultiplicand, uint ftMultiplier);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/ftmuldw
@DllImport("MAPI32.dll")
FILETIME FtMulDw(uint ftMultiplier, FILETIME ftMultiplicand);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/ftsubft
@DllImport("MAPI32.dll")
FILETIME FtSubFt(FILETIME ftMinuend, FILETIME ftSubtrahend);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/ftnegft
@DllImport("MAPI32.dll")
FILETIME FtNegFt(FILETIME ft);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/sccreateconversationindex
@DllImport("MAPI32.dll")
int ScCreateConversationIndex(uint cbParent, ubyte* lpbParent, uint* lpcbConvIndex, ubyte** lppbConvIndex);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/wrapstoreentryid
@DllImport("MAPI32.dll")
HRESULT WrapStoreEntryID(uint ulFlags, byte* lpszDLLName, uint cbOrigEntry, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ENTRYID* lpOrigEntry, 
                         uint* lpcbWrappedEntry, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ENTRYID** lppWrappedEntry);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/rtfsync
@DllImport("MAPI32.dll")
HRESULT RTFSync(IMessage lpMessage, uint ulFlags, BOOL* lpfMessageUpdated);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/wrapcompressedrtfstream
@DllImport("MAPI32.dll")
HRESULT WrapCompressedRTFStream(IStream lpCompressedRTFStream, uint ulFlags, IStream* lpUncompressedRTFStream);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/hristoragefromstream
@DllImport("MAPI32.dll")
HRESULT HrIStorageFromStream(IUnknown lpUnkIn, GUID* lpInterface, uint ulFlags, IStorage* lppStorageOut);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/scinitmapiutil
@DllImport("MAPI32.dll")
int ScInitMapiUtil(uint ulFlags);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/deinitmapiutil
@DllImport("MAPI32.dll")
void DeinitMapiUtil();


// Interfaces

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapiadvisesinkiunknown
interface IMAPIAdviseSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapiadvisesink-onnotify
    uint OnNotify(uint cNotif, NOTIFICATION* lpNotifications);
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapiprogressiunknown
interface IMAPIProgress : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapiprogress-progress
    HRESULT Progress(uint ulValue, uint ulCount, uint ulTotal);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapiprogress-getflags
    HRESULT GetFlags(uint* lpulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapiprogress-getmax
    HRESULT GetMax(uint* lpulMax);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapiprogress-getmin
    HRESULT GetMin(uint* lpulMin);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapiprogress-setlimits
    HRESULT SetLimits(uint* lpulMin, uint* lpulMax, uint* lpulFlags);
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapipropiunknown
interface IMAPIProp : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapiprop-getlasterror
    HRESULT GetLastError(HRESULT hResult, uint ulFlags, MAPIERROR** lppMAPIError);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapiprop-savechanges
    HRESULT SaveChanges(uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapiprop-getprops
    HRESULT GetProps(SPropTagArray* lpPropTagArray, uint ulFlags, uint* lpcValues, SPropValue** lppPropArray);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapiprop-getproplist
    HRESULT GetPropList(uint ulFlags, SPropTagArray** lppPropTagArray);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapiprop-openproperty
    HRESULT OpenProperty(uint ulPropTag, GUID* lpiid, uint ulInterfaceOptions, uint ulFlags, IUnknown* lppUnk);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapiprop-setprops
    HRESULT SetProps(uint cValues, SPropValue* lpPropArray, SPropProblemArray** lppProblems);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapiprop-deleteprops
    HRESULT DeleteProps(SPropTagArray* lpPropTagArray, SPropProblemArray** lppProblems);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapiprop-copyto
    HRESULT CopyTo(uint ciidExclude, GUID* rgiidExclude, SPropTagArray* lpExcludeProps, size_t ulUIParam, 
                   IMAPIProgress lpProgress, GUID* lpInterface, void* lpDestObj, uint ulFlags, 
                   SPropProblemArray** lppProblems);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapiprop-copyprops
    HRESULT CopyProps(SPropTagArray* lpIncludeProps, size_t ulUIParam, IMAPIProgress lpProgress, GUID* lpInterface, 
                      void* lpDestObj, uint ulFlags, SPropProblemArray** lppProblems);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapiprop-getnamesfromids
    HRESULT GetNamesFromIDs(SPropTagArray** lppPropTags, GUID* lpPropSetGuid, uint ulFlags, uint* lpcPropNames, 
                            MAPINAMEID*** lpppPropNames);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapiprop-getidsfromnames
    HRESULT GetIDsFromNames(uint cPropNames, MAPINAMEID** lppPropNames, uint ulFlags, SPropTagArray** lppPropTags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabdefs/nn-wabdefs-imapitable
interface IMAPITable : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-getlasterror
    HRESULT GetLastError(HRESULT hResult, uint ulFlags, MAPIERROR** lppMAPIError);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-advise
    HRESULT Advise(uint ulEventMask, IMAPIAdviseSink lpAdviseSink, uint* lpulConnection);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-unadvise
    HRESULT Unadvise(uint ulConnection);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-getstatus
    HRESULT GetStatus(uint* lpulTableStatus, uint* lpulTableType);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-setcolumns
    HRESULT SetColumns(SPropTagArray* lpPropTagArray, uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-querycolumns
    HRESULT QueryColumns(uint ulFlags, SPropTagArray** lpPropTagArray);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-getrowcount
    HRESULT GetRowCount(uint ulFlags, uint* lpulCount);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-seekrow
    HRESULT SeekRow(uint bkOrigin, int lRowCount, int* lplRowsSought);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-seekrowapprox
    HRESULT SeekRowApprox(uint ulNumerator, uint ulDenominator);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-queryposition
    HRESULT QueryPosition(uint* lpulRow, uint* lpulNumerator, uint* lpulDenominator);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-findrow
    HRESULT FindRow(SRestriction* lpRestriction, uint bkOrigin, uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-restrict
    HRESULT Restrict(SRestriction* lpRestriction, uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-createbookmark
    HRESULT CreateBookmark(uint* lpbkPosition);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-freebookmark
    HRESULT FreeBookmark(uint bkPosition);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-sorttable
    HRESULT SortTable(SSortOrderSet* lpSortCriteria, uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-querysortorder
    HRESULT QuerySortOrder(SSortOrderSet** lppSortCriteria);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-queryrows
    HRESULT QueryRows(int lRowCount, uint ulFlags, SRowSet** lppRows);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-abort
    HRESULT Abort();
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-expandrow
    HRESULT ExpandRow(uint cbInstanceKey, ubyte* pbInstanceKey, uint ulRowCount, uint ulFlags, SRowSet** lppRows, 
                      uint* lpulMoreRows);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-collapserow
    HRESULT CollapseRow(uint cbInstanceKey, ubyte* pbInstanceKey, uint ulFlags, uint* lpulRowCount);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-waitforcompletion
    HRESULT WaitForCompletion(uint ulFlags, uint ulTimeout, uint* lpulTableStatus);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-getcollapsestate
    HRESULT GetCollapseState(uint ulFlags, uint cbInstanceKey, ubyte* lpbInstanceKey, uint* lpcbCollapseState, 
                             ubyte** lppbCollapseState);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapitable-setcollapsestate
    HRESULT SetCollapseState(uint ulFlags, uint cbCollapseState, ubyte* pbCollapseState, uint* lpbkLocation);
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iprofsectimapiprop
interface IProfSect : IMAPIProp
{
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapistatusimapiprop
interface IMAPIStatus : IMAPIProp
{
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapistatus-validatestate
    HRESULT ValidateState(size_t ulUIParam, uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapistatus-settingsdialog
    HRESULT SettingsDialog(size_t ulUIParam, uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapistatus-changepassword
    HRESULT ChangePassword(byte* lpOldPass, byte* lpNewPass, uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapistatus-flushqueues
    HRESULT FlushQueues(size_t ulUIParam, uint cbTargetTransport, ENTRYID* lpTargetTransport, uint ulFlags);
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapicontainerimapiprop
interface IMAPIContainer : IMAPIProp
{
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapicontainer-getcontentstable
    HRESULT GetContentsTable(uint ulFlags, IMAPITable* lppTable);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapicontainer-gethierarchytable
    HRESULT GetHierarchyTable(uint ulFlags, IMAPITable* lppTable);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapicontainer-openentry
    HRESULT OpenEntry(uint cbEntryID, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/ENTRYID* lpEntryID, 
                      GUID* lpInterface, uint ulFlags, uint* lpulObjType, IUnknown* lppUnk);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapicontainer-setsearchcriteria
    HRESULT SetSearchCriteria(SRestriction* lpRestriction, SBinaryArray* lpContainerList, uint ulSearchFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapicontainer-getsearchcriteria
    HRESULT GetSearchCriteria(uint ulFlags, SRestriction** lppRestriction, SBinaryArray** lppContainerList, 
                              uint* lpulSearchState);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabdefs/nn-wabdefs-iabcontainer
interface IABContainer : IMAPIContainer
{
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iabcontainer-createentry
    HRESULT CreateEntry(uint cbEntryID, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/ENTRYID* lpEntryID, 
                        uint ulCreateFlags, IMAPIProp* lppMAPIPropEntry);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iabcontainer-copyentries
    HRESULT CopyEntries(SBinaryArray* lpEntries, size_t ulUIParam, IMAPIProgress lpProgress, uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iabcontainer-deleteentries
    HRESULT DeleteEntries(SBinaryArray* lpEntries, uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iabcontainer-resolvenames
    HRESULT ResolveNames(SPropTagArray* lpPropTagArray, uint ulFlags, ADRLIST* lpAdrList, FlagList* lpFlagList);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabdefs/nn-wabdefs-imailuser
interface IMailUser : IMAPIProp
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabdefs/nn-wabdefs-idistlist
interface IDistList : IMAPIContainer
{
    HRESULT CreateEntry(uint cbEntryID, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/ENTRYID* lpEntryID, 
                        uint ulCreateFlags, IMAPIProp* lppMAPIPropEntry);
    HRESULT CopyEntries(SBinaryArray* lpEntries, size_t ulUIParam, IMAPIProgress lpProgress, uint ulFlags);
    HRESULT DeleteEntries(SBinaryArray* lpEntries, uint ulFlags);
    HRESULT ResolveNames(SPropTagArray* lpPropTagArray, uint ulFlags, ADRLIST* lpAdrList, FlagList* lpFlagList);
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapifolderimapicontainer
interface IMAPIFolder : IMAPIContainer
{
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapifolder-createmessage
    HRESULT CreateMessage(GUID* lpInterface, uint ulFlags, IMessage* lppMessage);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapifolder-copymessages
    HRESULT CopyMessages(SBinaryArray* lpMsgList, GUID* lpInterface, void* lpDestFolder, size_t ulUIParam, 
                         IMAPIProgress lpProgress, uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapifolder-deletemessages
    HRESULT DeleteMessages(SBinaryArray* lpMsgList, size_t ulUIParam, IMAPIProgress lpProgress, uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapifolder-createfolder
    HRESULT CreateFolder(uint ulFolderType, byte* lpszFolderName, byte* lpszFolderComment, GUID* lpInterface, 
                         uint ulFlags, IMAPIFolder* lppFolder);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapifolder-copyfolder
    HRESULT CopyFolder(uint cbEntryID, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/ENTRYID* lpEntryID, 
                       GUID* lpInterface, void* lpDestFolder, byte* lpszNewFolderName, size_t ulUIParam, 
                       IMAPIProgress lpProgress, uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapifolder-deletefolder
    HRESULT DeleteFolder(uint cbEntryID, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/ENTRYID* lpEntryID, 
                         size_t ulUIParam, IMAPIProgress lpProgress, uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapifolder-setreadflags
    HRESULT SetReadFlags(SBinaryArray* lpMsgList, size_t ulUIParam, IMAPIProgress lpProgress, uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapifolder-getmessagestatus
    HRESULT GetMessageStatus(uint cbEntryID, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/ENTRYID* lpEntryID, 
                             uint ulFlags, uint* lpulMessageStatus);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapifolder-setmessagestatus
    HRESULT SetMessageStatus(uint cbEntryID, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/ENTRYID* lpEntryID, 
                             uint ulNewStatus, uint ulNewStatusMask, uint* lpulOldStatus);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapifolder-savecontentssort
    HRESULT SaveContentsSort(SSortOrderSet* lpSortCriteria, uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapifolder-emptyfolder
    HRESULT EmptyFolder(size_t ulUIParam, IMAPIProgress lpProgress, uint ulFlags);
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imsgstoreimapiprop
interface IMsgStore : IMAPIProp
{
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imsgstore-advise
    HRESULT Advise(uint cbEntryID, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/ENTRYID* lpEntryID, 
                   uint ulEventMask, IMAPIAdviseSink lpAdviseSink, uint* lpulConnection);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imsgstore-unadvise
    HRESULT Unadvise(uint ulConnection);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imsgstore-compareentryids
    HRESULT CompareEntryIDs(uint cbEntryID1, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/ENTRYID* lpEntryID1, 
                            uint cbEntryID2, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ENTRYID* lpEntryID2, 
                            uint ulFlags, uint* lpulResult);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imsgstore-openentry
    HRESULT OpenEntry(uint cbEntryID, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/ENTRYID* lpEntryID, 
                      GUID* lpInterface, uint ulFlags, uint* lpulObjType, IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imsgstore-setreceivefolder
    HRESULT SetReceiveFolder(byte* lpszMessageClass, uint ulFlags, uint cbEntryID, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ENTRYID* lpEntryID);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imsgstore-getreceivefolder
    HRESULT GetReceiveFolder(byte* lpszMessageClass, uint ulFlags, uint* lpcbEntryID, ENTRYID** lppEntryID, 
                             byte** lppszExplicitClass);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imsgstore-getreceivefoldertable
    HRESULT GetReceiveFolderTable(uint ulFlags, IMAPITable* lppTable);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imsgstore-storelogoff
    HRESULT StoreLogoff(uint* lpulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imsgstore-abortsubmit
    HRESULT AbortSubmit(uint cbEntryID, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/ENTRYID* lpEntryID, 
                        uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imsgstore-getoutgoingqueue
    HRESULT GetOutgoingQueue(uint ulFlags, IMAPITable* lppTable);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imsgstore-setlockstate
    HRESULT SetLockState(IMessage lpMessage, uint ulLockState);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imsgstore-finishedmsg
    HRESULT FinishedMsg(uint ulFlags, uint cbEntryID, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ENTRYID* lpEntryID);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imsgstore-notifynewmail
    HRESULT NotifyNewMail(NOTIFICATION* lpNotification);
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imessageimapiprop
interface IMessage : IMAPIProp
{
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imessage-getattachmenttable
    HRESULT GetAttachmentTable(uint ulFlags, IMAPITable* lppTable);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imessage-openattach
    HRESULT OpenAttach(uint ulAttachmentNum, GUID* lpInterface, uint ulFlags, IAttach* lppAttach);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imessage-createattach
    HRESULT CreateAttach(GUID* lpInterface, uint ulFlags, uint* lpulAttachmentNum, IAttach* lppAttach);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imessage-deleteattach
    HRESULT DeleteAttach(uint ulAttachmentNum, size_t ulUIParam, IMAPIProgress lpProgress, uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imessage-getrecipienttable
    HRESULT GetRecipientTable(uint ulFlags, IMAPITable* lppTable);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imessage-modifyrecipients
    HRESULT ModifyRecipients(uint ulFlags, ADRLIST* lpMods);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imessage-submitmessage
    HRESULT SubmitMessage(uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imessage-setreadflag
    HRESULT SetReadFlag(uint ulFlags);
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iattachimapiprop
interface IAttach : IMAPIProp
{
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapicontroliunknown
interface IMAPIControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapicontrol-getlasterror
    HRESULT GetLastError(HRESULT hResult, uint ulFlags, MAPIERROR** lppMAPIError);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapicontrol-activate
    HRESULT Activate(uint ulFlags, size_t ulUIParam);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/imapicontrol-getstate
    HRESULT GetState(uint ulFlags, uint* lpulState);
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iprovideradminiunknown
interface IProviderAdmin : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iprovideradmin-getlasterror
    HRESULT GetLastError(HRESULT hResult, uint ulFlags, MAPIERROR** lppMAPIError);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iprovideradmin-getprovidertable
    HRESULT GetProviderTable(uint ulFlags, IMAPITable* lppTable);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iprovideradmin-createprovider
    HRESULT CreateProvider(byte* lpszProvider, uint cValues, SPropValue* lpProps, size_t ulUIParam, uint ulFlags, 
                           MAPIUID* lpUID);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iprovideradmin-deleteprovider
    HRESULT DeleteProvider(MAPIUID* lpUID);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iprovideradmin-openprofilesection
    HRESULT OpenProfileSection(MAPIUID* lpUID, GUID* lpInterface, uint ulFlags, IProfSect* lppProfSect);
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/itabledataiunknown
interface ITableData : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/itabledata-hrgetview
    HRESULT HrGetView(SSortOrderSet* lpSSortOrderSet, CALLERRELEASE* lpfCallerRelease, uint ulCallerData, 
                      IMAPITable* lppMAPITable);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/itabledata-hrmodifyrow
    HRESULT HrModifyRow(SRow* param0);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/itabledata-hrdeleterow
    HRESULT HrDeleteRow(SPropValue* lpSPropValue);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/itabledata-hrqueryrow
    HRESULT HrQueryRow(SPropValue* lpsPropValue, SRow** lppSRow, uint* lpuliRow);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/itabledata-hrenumrow
    HRESULT HrEnumRow(uint ulRowNumber, SRow** lppSRow);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/itabledata-hrnotify
    HRESULT HrNotify(uint ulFlags, uint cValues, SPropValue* lpSPropValue);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/itabledata-hrinsertrow
    HRESULT HrInsertRow(uint uliRow, SRow* lpSRow);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/itabledata-hrmodifyrows
    HRESULT HrModifyRows(uint ulFlags, SRowSet* lpSRowSet);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/itabledata-hrdeleterows
    HRESULT HrDeleteRows(uint ulFlags, SRowSet* lprowsetToDelete, uint* cRowsDeleted);
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/ipropdataimapiprop
interface IPropData : IMAPIProp
{
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/ipropdata-hrsetobjaccess
    HRESULT HrSetObjAccess(uint ulAccess);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/ipropdata-hrsetpropaccess
    HRESULT HrSetPropAccess(SPropTagArray* lpPropTagArray, uint* rgulAccess);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/ipropdata-hrgetpropaccess
    HRESULT HrGetPropAccess(SPropTagArray** lppPropTagArray, uint** lprgulAccess);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/ipropdata-hraddobjprops
    HRESULT HrAddObjProps(SPropTagArray* lppPropTagArray, SPropProblemArray** lprgulAccess);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabiab/nn-wabiab-iaddrbook
interface IAddrBook : IMAPIProp
{
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iaddrbook-openentry
    HRESULT OpenEntry(uint cbEntryID, ENTRYID* lpEntryID, GUID* lpInterface, uint ulFlags, uint* lpulObjType, 
                      IUnknown* lppUnk);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iaddrbook-compareentryids
    HRESULT CompareEntryIDs(uint cbEntryID1, ENTRYID* lpEntryID1, uint cbEntryID2, ENTRYID* lpEntryID2, 
                            uint ulFlags, uint* lpulResult);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iaddrbook-advise
    HRESULT Advise(uint cbEntryID, ENTRYID* lpEntryID, uint ulEventMask, IMAPIAdviseSink lpAdviseSink, 
                   uint* lpulConnection);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iaddrbook-unadvise
    HRESULT Unadvise(uint ulConnection);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iaddrbook-createoneoff
    HRESULT CreateOneOff(byte* lpszName, byte* lpszAdrType, byte* lpszAddress, uint ulFlags, uint* lpcbEntryID, 
                         ENTRYID** lppEntryID);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iaddrbook-newentry
    HRESULT NewEntry(uint ulUIParam, uint ulFlags, uint cbEIDContainer, ENTRYID* lpEIDContainer, 
                     uint cbEIDNewEntryTpl, ENTRYID* lpEIDNewEntryTpl, uint* lpcbEIDNewEntry, 
                     ENTRYID** lppEIDNewEntry);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iaddrbook-resolvename
    HRESULT ResolveName(size_t ulUIParam, uint ulFlags, byte* lpszNewEntryTitle, ADRLIST* lpAdrList);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iaddrbook-address
    HRESULT Address(uint* lpulUIParam, ADRPARM* lpAdrParms, ADRLIST** lppAdrList);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iaddrbook-details
    HRESULT Details(size_t* lpulUIParam, LPFNDISMISS lpfnDismiss, void* lpvDismissContext, uint cbEntryID, 
                    ENTRYID* lpEntryID, LPFNBUTTON lpfButtonCallback, void* lpvButtonContext, byte* lpszButtonText, 
                    uint ulFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabiab/nf-wabiab-iaddrbook-recipoptions
    HRESULT RecipOptions(uint ulUIParam, uint ulFlags, ADRENTRY* lpRecip);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabiab/nf-wabiab-iaddrbook-querydefaultrecipopt
    HRESULT QueryDefaultRecipOpt(byte* lpszAdrType, uint ulFlags, uint* lpcValues, SPropValue** lppOptions);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iaddrbook-getpab
    HRESULT GetPAB(uint* lpcbEntryID, ENTRYID** lppEntryID);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iaddrbook-setpab
    HRESULT SetPAB(uint cbEntryID, ENTRYID* lpEntryID);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iaddrbook-getdefaultdir
    HRESULT GetDefaultDir(uint* lpcbEntryID, ENTRYID** lppEntryID);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iaddrbook-setdefaultdir
    HRESULT SetDefaultDir(uint cbEntryID, ENTRYID* lpEntryID);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iaddrbook-getsearchpath
    HRESULT GetSearchPath(uint ulFlags, SRowSet** lppSearchPath);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iaddrbook-setsearchpath
    HRESULT SetSearchPath(uint ulFlags, SRowSet* lpSearchPath);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/iaddrbook-preparerecips
    HRESULT PrepareRecips(uint ulFlags, SPropTagArray* lpPropTagArray, ADRLIST* lpRecipList);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabapi/nn-wabapi-iwabobject
interface IWABObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabapi/nf-wabapi-iwabobject-getlasterror
    HRESULT GetLastError(HRESULT hResult, uint ulFlags, MAPIERROR** lppMAPIError);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabapi/nf-wabapi-iwabobject-allocatebuffer
    HRESULT AllocateBuffer(uint cbSize, void** lppBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabapi/nf-wabapi-iwabobject-allocatemore
    HRESULT AllocateMore(uint cbSize, void* lpObject, void** lppBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabapi/nf-wabapi-iwabobject-freebuffer
    HRESULT FreeBuffer(void* lpBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabapi/nf-wabapi-iwabobject-backup
    HRESULT Backup(PSTR lpFileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabapi/nf-wabapi-iwabobject-import
    HRESULT Import(PSTR lpWIP);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabapi/nf-wabapi-iwabobject-find
    HRESULT Find(IAddrBook lpIAB, HWND hWnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabapi/nf-wabapi-iwabobject-vcarddisplay
    HRESULT VCardDisplay(IAddrBook lpIAB, HWND hWnd, PSTR lpszFileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabapi/nf-wabapi-iwabobject-ldapurl
    HRESULT LDAPUrl(IAddrBook lpIAB, HWND hWnd, uint ulFlags, PSTR lpszURL, IMailUser* lppMailUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabapi/nf-wabapi-iwabobject-vcardcreate
    HRESULT VCardCreate(IAddrBook lpIAB, uint ulFlags, PSTR lpszVCard, IMailUser lpMailUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabapi/nf-wabapi-iwabobject-vcardretrieve
    HRESULT VCardRetrieve(IAddrBook lpIAB, uint ulFlags, PSTR lpszVCard, IMailUser* lppMailUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabapi/nf-wabapi-iwabobject-getme
    HRESULT GetMe(IAddrBook lpIAB, uint ulFlags, uint* lpdwAction, SBinary* lpsbEID, HWND hwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabapi/nf-wabapi-iwabobject-setme
    HRESULT SetMe(IAddrBook lpIAB, uint ulFlags, SBinary sbEID, HWND hwnd);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wabapi/nn-wabapi-iwabextinit
@GUID("ea22ebf0-87a4-11d1-9acf-00a0c91f9c8b")
interface IWABExtInit : IUnknown
{
    HRESULT Initialize(WABEXTDISPLAY* lpWABExtDisplay);
}


// GUIDs


const GUID IID_IWABExtInit = GUIDOF!IWABExtInit;
