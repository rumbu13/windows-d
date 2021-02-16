module windows.imapi;

public import windows.core;
public import windows.automation : BSTR, IDispatch, IEnumVARIANT, SAFEARRAY;
public import windows.com : HRESULT, IUnknown;
public import windows.structuredstorage : IPropertyStorage, IStorage, IStream;

extern(Windows):


// Enums


enum : int
{
    IMAPI_MEDIA_TYPE_UNKNOWN             = 0x00000000,
    IMAPI_MEDIA_TYPE_CDROM               = 0x00000001,
    IMAPI_MEDIA_TYPE_CDR                 = 0x00000002,
    IMAPI_MEDIA_TYPE_CDRW                = 0x00000003,
    IMAPI_MEDIA_TYPE_DVDROM              = 0x00000004,
    IMAPI_MEDIA_TYPE_DVDRAM              = 0x00000005,
    IMAPI_MEDIA_TYPE_DVDPLUSR            = 0x00000006,
    IMAPI_MEDIA_TYPE_DVDPLUSRW           = 0x00000007,
    IMAPI_MEDIA_TYPE_DVDPLUSR_DUALLAYER  = 0x00000008,
    IMAPI_MEDIA_TYPE_DVDDASHR            = 0x00000009,
    IMAPI_MEDIA_TYPE_DVDDASHRW           = 0x0000000a,
    IMAPI_MEDIA_TYPE_DVDDASHR_DUALLAYER  = 0x0000000b,
    IMAPI_MEDIA_TYPE_DISK                = 0x0000000c,
    IMAPI_MEDIA_TYPE_DVDPLUSRW_DUALLAYER = 0x0000000d,
    IMAPI_MEDIA_TYPE_HDDVDROM            = 0x0000000e,
    IMAPI_MEDIA_TYPE_HDDVDR              = 0x0000000f,
    IMAPI_MEDIA_TYPE_HDDVDRAM            = 0x00000010,
    IMAPI_MEDIA_TYPE_BDROM               = 0x00000011,
    IMAPI_MEDIA_TYPE_BDR                 = 0x00000012,
    IMAPI_MEDIA_TYPE_BDRE                = 0x00000013,
    IMAPI_MEDIA_TYPE_MAX                 = 0x00000013,
}
alias IMAPI_MEDIA_PHYSICAL_TYPE = int;

enum : int
{
    IMAPI_WRITEPROTECTED_UNTIL_POWERDOWN           = 0x00000001,
    IMAPI_WRITEPROTECTED_BY_CARTRIDGE              = 0x00000002,
    IMAPI_WRITEPROTECTED_BY_MEDIA_SPECIFIC_REASON  = 0x00000004,
    IMAPI_WRITEPROTECTED_BY_SOFTWARE_WRITE_PROTECT = 0x00000008,
    IMAPI_WRITEPROTECTED_BY_DISC_CONTROL_BLOCK     = 0x00000010,
    IMAPI_WRITEPROTECTED_READ_ONLY_MEDIA           = 0x00004000,
}
alias IMAPI_MEDIA_WRITE_PROTECT_STATE = int;

enum : int
{
    IMAPI_READ_TRACK_ADDRESS_TYPE_LBA     = 0x00000000,
    IMAPI_READ_TRACK_ADDRESS_TYPE_TRACK   = 0x00000001,
    IMAPI_READ_TRACK_ADDRESS_TYPE_SESSION = 0x00000002,
}
alias IMAPI_READ_TRACK_ADDRESS_TYPE = int;

enum : int
{
    IMAPI_MODE_PAGE_REQUEST_TYPE_CURRENT_VALUES    = 0x00000000,
    IMAPI_MODE_PAGE_REQUEST_TYPE_CHANGEABLE_VALUES = 0x00000001,
    IMAPI_MODE_PAGE_REQUEST_TYPE_DEFAULT_VALUES    = 0x00000002,
    IMAPI_MODE_PAGE_REQUEST_TYPE_SAVED_VALUES      = 0x00000003,
}
alias IMAPI_MODE_PAGE_REQUEST_TYPE = int;

enum : int
{
    IMAPI_MODE_PAGE_TYPE_READ_WRITE_ERROR_RECOVERY = 0x00000001,
    IMAPI_MODE_PAGE_TYPE_MRW                       = 0x00000003,
    IMAPI_MODE_PAGE_TYPE_WRITE_PARAMETERS          = 0x00000005,
    IMAPI_MODE_PAGE_TYPE_CACHING                   = 0x00000008,
    IMAPI_MODE_PAGE_TYPE_INFORMATIONAL_EXCEPTIONS  = 0x0000001c,
    IMAPI_MODE_PAGE_TYPE_TIMEOUT_AND_PROTECT       = 0x0000001d,
    IMAPI_MODE_PAGE_TYPE_POWER_CONDITION           = 0x0000001a,
    IMAPI_MODE_PAGE_TYPE_LEGACY_CAPABILITIES       = 0x0000002a,
}
alias IMAPI_MODE_PAGE_TYPE = int;

enum : int
{
    IMAPI_FEATURE_PAGE_TYPE_PROFILE_LIST                   = 0x00000000,
    IMAPI_FEATURE_PAGE_TYPE_CORE                           = 0x00000001,
    IMAPI_FEATURE_PAGE_TYPE_MORPHING                       = 0x00000002,
    IMAPI_FEATURE_PAGE_TYPE_REMOVABLE_MEDIUM               = 0x00000003,
    IMAPI_FEATURE_PAGE_TYPE_WRITE_PROTECT                  = 0x00000004,
    IMAPI_FEATURE_PAGE_TYPE_RANDOMLY_READABLE              = 0x00000010,
    IMAPI_FEATURE_PAGE_TYPE_CD_MULTIREAD                   = 0x0000001d,
    IMAPI_FEATURE_PAGE_TYPE_CD_READ                        = 0x0000001e,
    IMAPI_FEATURE_PAGE_TYPE_DVD_READ                       = 0x0000001f,
    IMAPI_FEATURE_PAGE_TYPE_RANDOMLY_WRITABLE              = 0x00000020,
    IMAPI_FEATURE_PAGE_TYPE_INCREMENTAL_STREAMING_WRITABLE = 0x00000021,
    IMAPI_FEATURE_PAGE_TYPE_SECTOR_ERASABLE                = 0x00000022,
    IMAPI_FEATURE_PAGE_TYPE_FORMATTABLE                    = 0x00000023,
    IMAPI_FEATURE_PAGE_TYPE_HARDWARE_DEFECT_MANAGEMENT     = 0x00000024,
    IMAPI_FEATURE_PAGE_TYPE_WRITE_ONCE                     = 0x00000025,
    IMAPI_FEATURE_PAGE_TYPE_RESTRICTED_OVERWRITE           = 0x00000026,
    IMAPI_FEATURE_PAGE_TYPE_CDRW_CAV_WRITE                 = 0x00000027,
    IMAPI_FEATURE_PAGE_TYPE_MRW                            = 0x00000028,
    IMAPI_FEATURE_PAGE_TYPE_ENHANCED_DEFECT_REPORTING      = 0x00000029,
    IMAPI_FEATURE_PAGE_TYPE_DVD_PLUS_RW                    = 0x0000002a,
    IMAPI_FEATURE_PAGE_TYPE_DVD_PLUS_R                     = 0x0000002b,
    IMAPI_FEATURE_PAGE_TYPE_RIGID_RESTRICTED_OVERWRITE     = 0x0000002c,
    IMAPI_FEATURE_PAGE_TYPE_CD_TRACK_AT_ONCE               = 0x0000002d,
    IMAPI_FEATURE_PAGE_TYPE_CD_MASTERING                   = 0x0000002e,
    IMAPI_FEATURE_PAGE_TYPE_DVD_DASH_WRITE                 = 0x0000002f,
    IMAPI_FEATURE_PAGE_TYPE_DOUBLE_DENSITY_CD_READ         = 0x00000030,
    IMAPI_FEATURE_PAGE_TYPE_DOUBLE_DENSITY_CD_R_WRITE      = 0x00000031,
    IMAPI_FEATURE_PAGE_TYPE_DOUBLE_DENSITY_CD_RW_WRITE     = 0x00000032,
    IMAPI_FEATURE_PAGE_TYPE_LAYER_JUMP_RECORDING           = 0x00000033,
    IMAPI_FEATURE_PAGE_TYPE_CD_RW_MEDIA_WRITE_SUPPORT      = 0x00000037,
    IMAPI_FEATURE_PAGE_TYPE_BD_PSEUDO_OVERWRITE            = 0x00000038,
    IMAPI_FEATURE_PAGE_TYPE_DVD_PLUS_R_DUAL_LAYER          = 0x0000003b,
    IMAPI_FEATURE_PAGE_TYPE_BD_READ                        = 0x00000040,
    IMAPI_FEATURE_PAGE_TYPE_BD_WRITE                       = 0x00000041,
    IMAPI_FEATURE_PAGE_TYPE_HD_DVD_READ                    = 0x00000050,
    IMAPI_FEATURE_PAGE_TYPE_HD_DVD_WRITE                   = 0x00000051,
    IMAPI_FEATURE_PAGE_TYPE_POWER_MANAGEMENT               = 0x00000100,
    IMAPI_FEATURE_PAGE_TYPE_SMART                          = 0x00000101,
    IMAPI_FEATURE_PAGE_TYPE_EMBEDDED_CHANGER               = 0x00000102,
    IMAPI_FEATURE_PAGE_TYPE_CD_ANALOG_PLAY                 = 0x00000103,
    IMAPI_FEATURE_PAGE_TYPE_MICROCODE_UPDATE               = 0x00000104,
    IMAPI_FEATURE_PAGE_TYPE_TIMEOUT                        = 0x00000105,
    IMAPI_FEATURE_PAGE_TYPE_DVD_CSS                        = 0x00000106,
    IMAPI_FEATURE_PAGE_TYPE_REAL_TIME_STREAMING            = 0x00000107,
    IMAPI_FEATURE_PAGE_TYPE_LOGICAL_UNIT_SERIAL_NUMBER     = 0x00000108,
    IMAPI_FEATURE_PAGE_TYPE_MEDIA_SERIAL_NUMBER            = 0x00000109,
    IMAPI_FEATURE_PAGE_TYPE_DISC_CONTROL_BLOCKS            = 0x0000010a,
    IMAPI_FEATURE_PAGE_TYPE_DVD_CPRM                       = 0x0000010b,
    IMAPI_FEATURE_PAGE_TYPE_FIRMWARE_INFORMATION           = 0x0000010c,
    IMAPI_FEATURE_PAGE_TYPE_AACS                           = 0x0000010d,
    IMAPI_FEATURE_PAGE_TYPE_VCPS                           = 0x00000110,
}
alias IMAPI_FEATURE_PAGE_TYPE = int;

enum : int
{
    IMAPI_PROFILE_TYPE_INVALID                    = 0x00000000,
    IMAPI_PROFILE_TYPE_NON_REMOVABLE_DISK         = 0x00000001,
    IMAPI_PROFILE_TYPE_REMOVABLE_DISK             = 0x00000002,
    IMAPI_PROFILE_TYPE_MO_ERASABLE                = 0x00000003,
    IMAPI_PROFILE_TYPE_MO_WRITE_ONCE              = 0x00000004,
    IMAPI_PROFILE_TYPE_AS_MO                      = 0x00000005,
    IMAPI_PROFILE_TYPE_CDROM                      = 0x00000008,
    IMAPI_PROFILE_TYPE_CD_RECORDABLE              = 0x00000009,
    IMAPI_PROFILE_TYPE_CD_REWRITABLE              = 0x0000000a,
    IMAPI_PROFILE_TYPE_DVDROM                     = 0x00000010,
    IMAPI_PROFILE_TYPE_DVD_DASH_RECORDABLE        = 0x00000011,
    IMAPI_PROFILE_TYPE_DVD_RAM                    = 0x00000012,
    IMAPI_PROFILE_TYPE_DVD_DASH_REWRITABLE        = 0x00000013,
    IMAPI_PROFILE_TYPE_DVD_DASH_RW_SEQUENTIAL     = 0x00000014,
    IMAPI_PROFILE_TYPE_DVD_DASH_R_DUAL_SEQUENTIAL = 0x00000015,
    IMAPI_PROFILE_TYPE_DVD_DASH_R_DUAL_LAYER_JUMP = 0x00000016,
    IMAPI_PROFILE_TYPE_DVD_PLUS_RW                = 0x0000001a,
    IMAPI_PROFILE_TYPE_DVD_PLUS_R                 = 0x0000001b,
    IMAPI_PROFILE_TYPE_DDCDROM                    = 0x00000020,
    IMAPI_PROFILE_TYPE_DDCD_RECORDABLE            = 0x00000021,
    IMAPI_PROFILE_TYPE_DDCD_REWRITABLE            = 0x00000022,
    IMAPI_PROFILE_TYPE_DVD_PLUS_RW_DUAL           = 0x0000002a,
    IMAPI_PROFILE_TYPE_DVD_PLUS_R_DUAL            = 0x0000002b,
    IMAPI_PROFILE_TYPE_BD_ROM                     = 0x00000040,
    IMAPI_PROFILE_TYPE_BD_R_SEQUENTIAL            = 0x00000041,
    IMAPI_PROFILE_TYPE_BD_R_RANDOM_RECORDING      = 0x00000042,
    IMAPI_PROFILE_TYPE_BD_REWRITABLE              = 0x00000043,
    IMAPI_PROFILE_TYPE_HD_DVD_ROM                 = 0x00000050,
    IMAPI_PROFILE_TYPE_HD_DVD_RECORDABLE          = 0x00000051,
    IMAPI_PROFILE_TYPE_HD_DVD_RAM                 = 0x00000052,
    IMAPI_PROFILE_TYPE_NON_STANDARD               = 0x0000ffff,
}
alias IMAPI_PROFILE_TYPE = int;

enum : int
{
    IMAPI_FORMAT2_DATA_WRITE_ACTION_VALIDATING_MEDIA      = 0x00000000,
    IMAPI_FORMAT2_DATA_WRITE_ACTION_FORMATTING_MEDIA      = 0x00000001,
    IMAPI_FORMAT2_DATA_WRITE_ACTION_INITIALIZING_HARDWARE = 0x00000002,
    IMAPI_FORMAT2_DATA_WRITE_ACTION_CALIBRATING_POWER     = 0x00000003,
    IMAPI_FORMAT2_DATA_WRITE_ACTION_WRITING_DATA          = 0x00000004,
    IMAPI_FORMAT2_DATA_WRITE_ACTION_FINALIZATION          = 0x00000005,
    IMAPI_FORMAT2_DATA_WRITE_ACTION_COMPLETED             = 0x00000006,
    IMAPI_FORMAT2_DATA_WRITE_ACTION_VERIFYING             = 0x00000007,
}
alias IMAPI_FORMAT2_DATA_WRITE_ACTION = int;

enum : int
{
    IMAPI_FORMAT2_DATA_MEDIA_STATE_UNKNOWN            = 0x00000000,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_INFORMATIONAL_MASK = 0x0000000f,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_UNSUPPORTED_MASK   = 0x0000fc00,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_OVERWRITE_ONLY     = 0x00000001,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_RANDOMLY_WRITABLE  = 0x00000001,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_BLANK              = 0x00000002,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_APPENDABLE         = 0x00000004,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_FINAL_SESSION      = 0x00000008,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_DAMAGED            = 0x00000400,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_ERASE_REQUIRED     = 0x00000800,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_NON_EMPTY_SESSION  = 0x00001000,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_WRITE_PROTECTED    = 0x00002000,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_FINALIZED          = 0x00004000,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_UNSUPPORTED_MEDIA  = 0x00008000,
}
alias IMAPI_FORMAT2_DATA_MEDIA_STATE = int;

enum : int
{
    IMAPI_FORMAT2_TAO_WRITE_ACTION_UNKNOWN   = 0x00000000,
    IMAPI_FORMAT2_TAO_WRITE_ACTION_PREPARING = 0x00000001,
    IMAPI_FORMAT2_TAO_WRITE_ACTION_WRITING   = 0x00000002,
    IMAPI_FORMAT2_TAO_WRITE_ACTION_FINISHING = 0x00000003,
    IMAPI_FORMAT2_TAO_WRITE_ACTION_VERIFYING = 0x00000004,
}
alias IMAPI_FORMAT2_TAO_WRITE_ACTION = int;

enum : int
{
    IMAPI_FORMAT2_RAW_CD_SUBCODE_PQ_ONLY   = 0x00000001,
    IMAPI_FORMAT2_RAW_CD_SUBCODE_IS_COOKED = 0x00000002,
    IMAPI_FORMAT2_RAW_CD_SUBCODE_IS_RAW    = 0x00000003,
}
alias IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE = int;

enum : int
{
    IMAPI_FORMAT2_RAW_CD_WRITE_ACTION_UNKNOWN   = 0x00000000,
    IMAPI_FORMAT2_RAW_CD_WRITE_ACTION_PREPARING = 0x00000001,
    IMAPI_FORMAT2_RAW_CD_WRITE_ACTION_WRITING   = 0x00000002,
    IMAPI_FORMAT2_RAW_CD_WRITE_ACTION_FINISHING = 0x00000003,
}
alias IMAPI_FORMAT2_RAW_CD_WRITE_ACTION = int;

enum : int
{
    IMAPI_CD_SECTOR_AUDIO         = 0x00000000,
    IMAPI_CD_SECTOR_MODE_ZERO     = 0x00000001,
    IMAPI_CD_SECTOR_MODE1         = 0x00000002,
    IMAPI_CD_SECTOR_MODE2FORM0    = 0x00000003,
    IMAPI_CD_SECTOR_MODE2FORM1    = 0x00000004,
    IMAPI_CD_SECTOR_MODE2FORM2    = 0x00000005,
    IMAPI_CD_SECTOR_MODE1RAW      = 0x00000006,
    IMAPI_CD_SECTOR_MODE2FORM0RAW = 0x00000007,
    IMAPI_CD_SECTOR_MODE2FORM1RAW = 0x00000008,
    IMAPI_CD_SECTOR_MODE2FORM2RAW = 0x00000009,
}
alias IMAPI_CD_SECTOR_TYPE = int;

enum : int
{
    IMAPI_CD_TRACK_DIGITAL_COPY_PERMITTED  = 0x00000000,
    IMAPI_CD_TRACK_DIGITAL_COPY_PROHIBITED = 0x00000001,
    IMAPI_CD_TRACK_DIGITAL_COPY_SCMS       = 0x00000002,
}
alias IMAPI_CD_TRACK_DIGITAL_COPY_SETTING = int;

enum : int
{
    IMAPI_BURN_VERIFICATION_NONE  = 0x00000000,
    IMAPI_BURN_VERIFICATION_QUICK = 0x00000001,
    IMAPI_BURN_VERIFICATION_FULL  = 0x00000002,
}
alias IMAPI_BURN_VERIFICATION_LEVEL = int;

enum FsiItemType : int
{
    FsiItemNotFound  = 0x00000000,
    FsiItemDirectory = 0x00000001,
    FsiItemFile      = 0x00000002,
}

enum FsiFileSystems : int
{
    FsiFileSystemNone    = 0x00000000,
    FsiFileSystemISO9660 = 0x00000001,
    FsiFileSystemJoliet  = 0x00000002,
    FsiFileSystemUDF     = 0x00000004,
    FsiFileSystemUnknown = 0x40000000,
}

enum EmulationType : int
{
    EmulationNone       = 0x00000000,
    Emulation12MFloppy  = 0x00000001,
    Emulation144MFloppy = 0x00000002,
    Emulation288MFloppy = 0x00000003,
    EmulationHardDisk   = 0x00000004,
}

enum PlatformId : int
{
    PlatformX86     = 0x00000000,
    PlatformPowerPC = 0x00000001,
    PlatformMac     = 0x00000002,
    PlatformEFI     = 0x000000ef,
}

enum : int
{
    MEDIA_CDDA_CDROM = 0x00000001,
    MEDIA_CD_ROM_XA  = 0x00000002,
    MEDIA_CD_I       = 0x00000003,
    MEDIA_CD_EXTRA   = 0x00000004,
    MEDIA_CD_OTHER   = 0x00000005,
    MEDIA_SPECIAL    = 0x00000006,
}
alias MEDIA_TYPES = int;

enum : int
{
    MEDIA_BLANK                    = 0x00000001,
    MEDIA_RW                       = 0x00000002,
    MEDIA_WRITABLE                 = 0x00000004,
    MEDIA_FORMAT_UNUSABLE_BY_IMAPI = 0x00000008,
}
alias MEDIA_FLAGS = int;

enum : int
{
    RECORDER_CDR  = 0x00000001,
    RECORDER_CDRW = 0x00000002,
}
alias RECORDER_TYPES = int;

// Constants


enum int IMAPI_S_PROPERTIESIGNORED = 0x00040200;

enum : int
{
    IMAPI_E_NOTOPENED      = 0x8004020b,
    IMAPI_E_NOTINITIALIZED = 0x8004020c,
}

enum : int
{
    IMAPI_E_GENERIC            = 0x8004020e,
    IMAPI_E_MEDIUM_NOTPRESENT  = 0x8004020f,
    IMAPI_E_MEDIUM_INVALIDTYPE = 0x80040210,
}

enum : int
{
    IMAPI_E_DEVICE_NOTACCESSIBLE = 0x80040212,
    IMAPI_E_DEVICE_NOTPRESENT    = 0x80040213,
    IMAPI_E_DEVICE_INVALIDTYPE   = 0x80040214,
}

enum int IMAPI_E_INITIALIZE_ENDWRITE = 0x80040216;

enum : int
{
    IMAPI_E_FILEACCESS    = 0x80040218,
    IMAPI_E_DISCINFO      = 0x80040219,
    IMAPI_E_TRACKNOTOPEN  = 0x8004021a,
    IMAPI_E_TRACKOPEN     = 0x8004021b,
    IMAPI_E_DISCFULL      = 0x8004021c,
    IMAPI_E_BADJOLIETNAME = 0x8004021d,
}

enum : int
{
    IMAPI_E_NOACTIVEFORMAT   = 0x8004021f,
    IMAPI_E_NOACTIVERECORDER = 0x80040220,
}

enum : int
{
    IMAPI_E_ALREADYOPEN         = 0x80040222,
    IMAPI_E_WRONGDISC           = 0x80040223,
    IMAPI_E_FILEEXISTS          = 0x80040224,
    IMAPI_E_STASHINUSE          = 0x80040225,
    IMAPI_E_DEVICE_STILL_IN_USE = 0x80040226,
}

enum int IMAPI_E_COMPRESSEDSTASH = 0x80040228;
enum int IMAPI_E_NOTENOUGHDISKFORSTASH = 0x8004022a;
enum int IMAPI_E_CANNOT_WRITE_TO_MEDIA = 0x8004022c;
enum int IMAPI_E_BOOTIMAGE_AND_NONBLANK_DISC = 0x8004022e;

// Interfaces

@GUID("2735412E-7F64-5B0F-8F00-5D77AFBE261E")
struct MsftDiscMaster2;

@GUID("2735412D-7F64-5B0F-8F00-5D77AFBE261E")
struct MsftDiscRecorder2;

@GUID("2735412C-7F64-5B0F-8F00-5D77AFBE261E")
struct MsftWriteEngine2;

@GUID("2735412B-7F64-5B0F-8F00-5D77AFBE261E")
struct MsftDiscFormat2Erase;

@GUID("2735412A-7F64-5B0F-8F00-5D77AFBE261E")
struct MsftDiscFormat2Data;

@GUID("27354129-7F64-5B0F-8F00-5D77AFBE261E")
struct MsftDiscFormat2TrackAtOnce;

@GUID("27354128-7F64-5B0F-8F00-5D77AFBE261E")
struct MsftDiscFormat2RawCD;

@GUID("27354127-7F64-5B0F-8F00-5D77AFBE261E")
struct MsftStreamZero;

@GUID("27354126-7F64-5B0F-8F00-5D77AFBE261E")
struct MsftStreamPrng001;

@GUID("27354125-7F64-5B0F-8F00-5D77AFBE261E")
struct MsftStreamConcatenate;

@GUID("27354124-7F64-5B0F-8F00-5D77AFBE261E")
struct MsftStreamInterleave;

@GUID("27354123-7F64-5B0F-8F00-5D77AFBE261E")
struct MsftWriteSpeedDescriptor;

@GUID("27354122-7F64-5B0F-8F00-5D77AFBE261E")
struct MsftMultisessionSequential;

@GUID("B507CA24-2204-11DD-966A-001AA01BBC58")
struct MsftMultisessionRandomWrite;

@GUID("25983561-9D65-49CE-B335-40630D901227")
struct MsftRawCDImageCreator;

@GUID("2C941FCE-975B-59BE-A960-9A2A262853A5")
struct BootOptions;

@GUID("2C941FCD-975B-59BE-A960-9A2A262853A5")
struct FsiStream;

@GUID("2C941FCC-975B-59BE-A960-9A2A262853A5")
struct FileSystemImageResult;

@GUID("2C941FCB-975B-59BE-A960-9A2A262853A5")
struct ProgressItem;

@GUID("2C941FCA-975B-59BE-A960-9A2A262853A5")
struct EnumProgressItems;

@GUID("2C941FC9-975B-59BE-A960-9A2A262853A5")
struct ProgressItems;

@GUID("2C941FC8-975B-59BE-A960-9A2A262853A5")
struct FsiDirectoryItem;

@GUID("2C941FC7-975B-59BE-A960-9A2A262853A5")
struct FsiFileItem;

@GUID("2C941FC6-975B-59BE-A960-9A2A262853A5")
struct EnumFsiItems;

@GUID("C6B6F8ED-6D19-44B4-B539-B159B793A32D")
struct FsiNamedStreams;

@GUID("2C941FC5-975B-59BE-A960-9A2A262853A5")
struct MsftFileSystemImage;

@GUID("CEEE3B62-8F56-4056-869B-EF16917E3EFC")
struct MsftIsoImageManager;

@GUID("B507CA27-2204-11DD-966A-001AA01BBC58")
struct BlockRange;

@GUID("B507CA28-2204-11DD-966A-001AA01BBC58")
struct BlockRangeList;

@GUID("520CCA61-51A5-11D3-9144-00104BA11C5E")
struct MSDiscRecorderObj;

@GUID("520CCA63-51A5-11D3-9144-00104BA11C5E")
struct MSDiscMasterObj;

@GUID("8A03567A-63CB-4BA8-BAF6-52119816D1EF")
struct MSEnumDiscRecordersObj;

@GUID("27354130-7F64-5B0F-8F00-5D77AFBE261E")
interface IDiscMaster2 : IDispatch
{
    HRESULT get__NewEnum(IEnumVARIANT* ppunk);
    HRESULT get_Item(int index, BSTR* value);
    HRESULT get_Count(int* value);
    HRESULT get_IsSupportedEnvironment(short* value);
}

@GUID("27354131-7F64-5B0F-8F00-5D77AFBE261E")
interface DDiscMaster2Events : IDispatch
{
    HRESULT NotifyDeviceAdded(IDispatch object, BSTR uniqueId);
    HRESULT NotifyDeviceRemoved(IDispatch object, BSTR uniqueId);
}

@GUID("27354132-7F64-5B0F-8F00-5D77AFBE261E")
interface IDiscRecorder2Ex : IUnknown
{
    HRESULT SendCommandNoData(char* Cdb, uint CdbSize, char* SenseBuffer, uint Timeout);
    HRESULT SendCommandSendDataToDevice(char* Cdb, uint CdbSize, char* SenseBuffer, uint Timeout, char* Buffer, 
                                        uint BufferSize);
    HRESULT SendCommandGetDataFromDevice(char* Cdb, uint CdbSize, char* SenseBuffer, uint Timeout, char* Buffer, 
                                         uint BufferSize, uint* BufferFetched);
    HRESULT ReadDvdStructure(uint format, uint address, uint layer, uint agid, char* data, uint* count);
    HRESULT SendDvdStructure(uint format, char* data, uint count);
    HRESULT GetAdapterDescriptor(char* data, uint* byteSize);
    HRESULT GetDeviceDescriptor(char* data, uint* byteSize);
    HRESULT GetDiscInformation(char* discInformation, uint* byteSize);
    HRESULT GetTrackInformation(uint address, IMAPI_READ_TRACK_ADDRESS_TYPE addressType, char* trackInformation, 
                                uint* byteSize);
    HRESULT GetFeaturePage(IMAPI_FEATURE_PAGE_TYPE requestedFeature, ubyte currentFeatureOnly, char* featureData, 
                           uint* byteSize);
    HRESULT GetModePage(IMAPI_MODE_PAGE_TYPE requestedModePage, IMAPI_MODE_PAGE_REQUEST_TYPE requestType, 
                        char* modePageData, uint* byteSize);
    HRESULT SetModePage(IMAPI_MODE_PAGE_REQUEST_TYPE requestType, char* data, uint byteSize);
    HRESULT GetSupportedFeaturePages(ubyte currentFeatureOnly, char* featureData, uint* byteSize);
    HRESULT GetSupportedProfiles(ubyte currentOnly, char* profileTypes, uint* validProfiles);
    HRESULT GetSupportedModePages(IMAPI_MODE_PAGE_REQUEST_TYPE requestType, char* modePageTypes, uint* validPages);
    HRESULT GetByteAlignmentMask(uint* value);
    HRESULT GetMaximumNonPageAlignedTransferSize(uint* value);
    HRESULT GetMaximumPageAlignedTransferSize(uint* value);
}

@GUID("27354133-7F64-5B0F-8F00-5D77AFBE261E")
interface IDiscRecorder2 : IDispatch
{
    HRESULT EjectMedia();
    HRESULT CloseTray();
    HRESULT AcquireExclusiveAccess(short force, BSTR __MIDL__IDiscRecorder20000);
    HRESULT ReleaseExclusiveAccess();
    HRESULT DisableMcn();
    HRESULT EnableMcn();
    HRESULT InitializeDiscRecorder(BSTR recorderUniqueId);
    HRESULT get_ActiveDiscRecorder(BSTR* value);
    HRESULT get_VendorId(BSTR* value);
    HRESULT get_ProductId(BSTR* value);
    HRESULT get_ProductRevision(BSTR* value);
    HRESULT get_VolumeName(BSTR* value);
    HRESULT get_VolumePathNames(SAFEARRAY** value);
    HRESULT get_DeviceCanLoadMedia(short* value);
    HRESULT get_LegacyDeviceNumber(int* legacyDeviceNumber);
    HRESULT get_SupportedFeaturePages(SAFEARRAY** value);
    HRESULT get_CurrentFeaturePages(SAFEARRAY** value);
    HRESULT get_SupportedProfiles(SAFEARRAY** value);
    HRESULT get_CurrentProfiles(SAFEARRAY** value);
    HRESULT get_SupportedModePages(SAFEARRAY** value);
    HRESULT get_ExclusiveAccessOwner(BSTR* value);
}

@GUID("27354135-7F64-5B0F-8F00-5D77AFBE261E")
interface IWriteEngine2 : IDispatch
{
    HRESULT WriteSection(IStream data, int startingBlockAddress, int numberOfBlocks);
    HRESULT CancelWrite();
    HRESULT put_Recorder(IDiscRecorder2Ex value);
    HRESULT get_Recorder(IDiscRecorder2Ex* value);
    HRESULT put_UseStreamingWrite12(short value);
    HRESULT get_UseStreamingWrite12(short* value);
    HRESULT put_StartingSectorsPerSecond(int value);
    HRESULT get_StartingSectorsPerSecond(int* value);
    HRESULT put_EndingSectorsPerSecond(int value);
    HRESULT get_EndingSectorsPerSecond(int* value);
    HRESULT put_BytesPerSector(int value);
    HRESULT get_BytesPerSector(int* value);
    HRESULT get_WriteInProgress(short* value);
}

@GUID("27354136-7F64-5B0F-8F00-5D77AFBE261E")
interface IWriteEngine2EventArgs : IDispatch
{
    HRESULT get_StartLba(int* value);
    HRESULT get_SectorCount(int* value);
    HRESULT get_LastReadLba(int* value);
    HRESULT get_LastWrittenLba(int* value);
    HRESULT get_TotalSystemBuffer(int* value);
    HRESULT get_UsedSystemBuffer(int* value);
    HRESULT get_FreeSystemBuffer(int* value);
}

@GUID("27354137-7F64-5B0F-8F00-5D77AFBE261E")
interface DWriteEngine2Events : IDispatch
{
    HRESULT Update(IDispatch object, IDispatch progress);
}

@GUID("27354152-8F64-5B0F-8F00-5D77AFBE261E")
interface IDiscFormat2 : IDispatch
{
    HRESULT IsRecorderSupported(IDiscRecorder2 recorder, short* value);
    HRESULT IsCurrentMediaSupported(IDiscRecorder2 recorder, short* value);
    HRESULT get_MediaPhysicallyBlank(short* value);
    HRESULT get_MediaHeuristicallyBlank(short* value);
    HRESULT get_SupportedMediaTypes(SAFEARRAY** value);
}

@GUID("27354156-8F64-5B0F-8F00-5D77AFBE261E")
interface IDiscFormat2Erase : IDiscFormat2
{
    HRESULT put_Recorder(IDiscRecorder2 value);
    HRESULT get_Recorder(IDiscRecorder2* value);
    HRESULT put_FullErase(short value);
    HRESULT get_FullErase(short* value);
    HRESULT get_CurrentPhysicalMediaType(IMAPI_MEDIA_PHYSICAL_TYPE* value);
    HRESULT put_ClientName(BSTR value);
    HRESULT get_ClientName(BSTR* value);
    HRESULT EraseMedia();
}

@GUID("2735413A-7F64-5B0F-8F00-5D77AFBE261E")
interface DDiscFormat2EraseEvents : IDispatch
{
    HRESULT Update(IDispatch object, int elapsedSeconds, int estimatedTotalSeconds);
}

@GUID("27354153-9F64-5B0F-8F00-5D77AFBE261E")
interface IDiscFormat2Data : IDiscFormat2
{
    HRESULT put_Recorder(IDiscRecorder2 value);
    HRESULT get_Recorder(IDiscRecorder2* value);
    HRESULT put_BufferUnderrunFreeDisabled(short value);
    HRESULT get_BufferUnderrunFreeDisabled(short* value);
    HRESULT put_PostgapAlreadyInImage(short value);
    HRESULT get_PostgapAlreadyInImage(short* value);
    HRESULT get_CurrentMediaStatus(IMAPI_FORMAT2_DATA_MEDIA_STATE* value);
    HRESULT get_WriteProtectStatus(IMAPI_MEDIA_WRITE_PROTECT_STATE* value);
    HRESULT get_TotalSectorsOnMedia(int* value);
    HRESULT get_FreeSectorsOnMedia(int* value);
    HRESULT get_NextWritableAddress(int* value);
    HRESULT get_StartAddressOfPreviousSession(int* value);
    HRESULT get_LastWrittenAddressOfPreviousSession(int* value);
    HRESULT put_ForceMediaToBeClosed(short value);
    HRESULT get_ForceMediaToBeClosed(short* value);
    HRESULT put_DisableConsumerDvdCompatibilityMode(short value);
    HRESULT get_DisableConsumerDvdCompatibilityMode(short* value);
    HRESULT get_CurrentPhysicalMediaType(IMAPI_MEDIA_PHYSICAL_TYPE* value);
    HRESULT put_ClientName(BSTR value);
    HRESULT get_ClientName(BSTR* value);
    HRESULT get_RequestedWriteSpeed(int* value);
    HRESULT get_RequestedRotationTypeIsPureCAV(short* value);
    HRESULT get_CurrentWriteSpeed(int* value);
    HRESULT get_CurrentRotationTypeIsPureCAV(short* value);
    HRESULT get_SupportedWriteSpeeds(SAFEARRAY** supportedSpeeds);
    HRESULT get_SupportedWriteSpeedDescriptors(SAFEARRAY** supportedSpeedDescriptors);
    HRESULT put_ForceOverwrite(short value);
    HRESULT get_ForceOverwrite(short* value);
    HRESULT get_MultisessionInterfaces(SAFEARRAY** value);
    HRESULT Write(IStream data);
    HRESULT CancelWrite();
    HRESULT SetWriteSpeed(int RequestedSectorsPerSecond, short RotationTypeIsPureCAV);
}

@GUID("2735413C-7F64-5B0F-8F00-5D77AFBE261E")
interface DDiscFormat2DataEvents : IDispatch
{
    HRESULT Update(IDispatch object, IDispatch progress);
}

@GUID("2735413D-7F64-5B0F-8F00-5D77AFBE261E")
interface IDiscFormat2DataEventArgs : IWriteEngine2EventArgs
{
    HRESULT get_ElapsedTime(int* value);
    HRESULT get_RemainingTime(int* value);
    HRESULT get_TotalTime(int* value);
    HRESULT get_CurrentAction(IMAPI_FORMAT2_DATA_WRITE_ACTION* value);
}

@GUID("27354154-8F64-5B0F-8F00-5D77AFBE261E")
interface IDiscFormat2TrackAtOnce : IDiscFormat2
{
    HRESULT PrepareMedia();
    HRESULT AddAudioTrack(IStream data);
    HRESULT CancelAddTrack();
    HRESULT ReleaseMedia();
    HRESULT SetWriteSpeed(int RequestedSectorsPerSecond, short RotationTypeIsPureCAV);
    HRESULT put_Recorder(IDiscRecorder2 value);
    HRESULT get_Recorder(IDiscRecorder2* value);
    HRESULT put_BufferUnderrunFreeDisabled(short value);
    HRESULT get_BufferUnderrunFreeDisabled(short* value);
    HRESULT get_NumberOfExistingTracks(int* value);
    HRESULT get_TotalSectorsOnMedia(int* value);
    HRESULT get_FreeSectorsOnMedia(int* value);
    HRESULT get_UsedSectorsOnMedia(int* value);
    HRESULT put_DoNotFinalizeMedia(short value);
    HRESULT get_DoNotFinalizeMedia(short* value);
    HRESULT get_ExpectedTableOfContents(SAFEARRAY** value);
    HRESULT get_CurrentPhysicalMediaType(IMAPI_MEDIA_PHYSICAL_TYPE* value);
    HRESULT put_ClientName(BSTR value);
    HRESULT get_ClientName(BSTR* value);
    HRESULT get_RequestedWriteSpeed(int* value);
    HRESULT get_RequestedRotationTypeIsPureCAV(short* value);
    HRESULT get_CurrentWriteSpeed(int* value);
    HRESULT get_CurrentRotationTypeIsPureCAV(short* value);
    HRESULT get_SupportedWriteSpeeds(SAFEARRAY** supportedSpeeds);
    HRESULT get_SupportedWriteSpeedDescriptors(SAFEARRAY** supportedSpeedDescriptors);
}

@GUID("2735413F-7F64-5B0F-8F00-5D77AFBE261E")
interface DDiscFormat2TrackAtOnceEvents : IDispatch
{
    HRESULT Update(IDispatch object, IDispatch progress);
}

@GUID("27354140-7F64-5B0F-8F00-5D77AFBE261E")
interface IDiscFormat2TrackAtOnceEventArgs : IWriteEngine2EventArgs
{
    HRESULT get_CurrentTrackNumber(int* value);
    HRESULT get_CurrentAction(IMAPI_FORMAT2_TAO_WRITE_ACTION* value);
    HRESULT get_ElapsedTime(int* value);
    HRESULT get_RemainingTime(int* value);
}

@GUID("27354155-8F64-5B0F-8F00-5D77AFBE261E")
interface IDiscFormat2RawCD : IDiscFormat2
{
    HRESULT PrepareMedia();
    HRESULT WriteMedia(IStream data);
    HRESULT WriteMedia2(IStream data, int streamLeadInSectors);
    HRESULT CancelWrite();
    HRESULT ReleaseMedia();
    HRESULT SetWriteSpeed(int RequestedSectorsPerSecond, short RotationTypeIsPureCAV);
    HRESULT put_Recorder(IDiscRecorder2 value);
    HRESULT get_Recorder(IDiscRecorder2* value);
    HRESULT put_BufferUnderrunFreeDisabled(short value);
    HRESULT get_BufferUnderrunFreeDisabled(short* value);
    HRESULT get_StartOfNextSession(int* value);
    HRESULT get_LastPossibleStartOfLeadout(int* value);
    HRESULT get_CurrentPhysicalMediaType(IMAPI_MEDIA_PHYSICAL_TYPE* value);
    HRESULT get_SupportedSectorTypes(SAFEARRAY** value);
    HRESULT put_RequestedSectorType(IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE value);
    HRESULT get_RequestedSectorType(IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE* value);
    HRESULT put_ClientName(BSTR value);
    HRESULT get_ClientName(BSTR* value);
    HRESULT get_RequestedWriteSpeed(int* value);
    HRESULT get_RequestedRotationTypeIsPureCAV(short* value);
    HRESULT get_CurrentWriteSpeed(int* value);
    HRESULT get_CurrentRotationTypeIsPureCAV(short* value);
    HRESULT get_SupportedWriteSpeeds(SAFEARRAY** supportedSpeeds);
    HRESULT get_SupportedWriteSpeedDescriptors(SAFEARRAY** supportedSpeedDescriptors);
}

@GUID("27354142-7F64-5B0F-8F00-5D77AFBE261E")
interface DDiscFormat2RawCDEvents : IDispatch
{
    HRESULT Update(IDispatch object, IDispatch progress);
}

@GUID("27354143-7F64-5B0F-8F00-5D77AFBE261E")
interface IDiscFormat2RawCDEventArgs : IWriteEngine2EventArgs
{
    HRESULT get_CurrentAction(IMAPI_FORMAT2_RAW_CD_WRITE_ACTION* value);
    HRESULT get_ElapsedTime(int* value);
    HRESULT get_RemainingTime(int* value);
}

@GUID("D2FFD834-958B-426D-8470-2A13879C6A91")
interface IBurnVerification : IUnknown
{
    HRESULT put_BurnVerificationLevel(IMAPI_BURN_VERIFICATION_LEVEL value);
    HRESULT get_BurnVerificationLevel(IMAPI_BURN_VERIFICATION_LEVEL* value);
}

@GUID("27354144-7F64-5B0F-8F00-5D77AFBE261E")
interface IWriteSpeedDescriptor : IDispatch
{
    HRESULT get_MediaType(IMAPI_MEDIA_PHYSICAL_TYPE* value);
    HRESULT get_RotationTypeIsPureCAV(short* value);
    HRESULT get_WriteSpeed(int* value);
}

@GUID("27354150-7F64-5B0F-8F00-5D77AFBE261E")
interface IMultisession : IDispatch
{
    HRESULT get_IsSupportedOnCurrentMediaState(short* value);
    HRESULT put_InUse(short value);
    HRESULT get_InUse(short* value);
    HRESULT get_ImportRecorder(IDiscRecorder2* value);
}

@GUID("27354151-7F64-5B0F-8F00-5D77AFBE261E")
interface IMultisessionSequential : IMultisession
{
    HRESULT get_IsFirstDataSession(short* value);
    HRESULT get_StartAddressOfPreviousSession(int* value);
    HRESULT get_LastWrittenAddressOfPreviousSession(int* value);
    HRESULT get_NextWritableAddress(int* value);
    HRESULT get_FreeSectorsOnMedia(int* value);
}

@GUID("B507CA22-2204-11DD-966A-001AA01BBC58")
interface IMultisessionSequential2 : IMultisessionSequential
{
    HRESULT get_WriteUnitSize(int* value);
}

@GUID("B507CA23-2204-11DD-966A-001AA01BBC58")
interface IMultisessionRandomWrite : IMultisession
{
    HRESULT get_WriteUnitSize(int* value);
    HRESULT get_LastWrittenAddress(int* value);
    HRESULT get_TotalSectorsOnMedia(int* value);
}

@GUID("27354145-7F64-5B0F-8F00-5D77AFBE261E")
interface IStreamPseudoRandomBased : IStream
{
    HRESULT put_Seed(uint value);
    HRESULT get_Seed(uint* value);
    HRESULT put_ExtendedSeed(char* values, uint eCount);
    HRESULT get_ExtendedSeed(char* values, uint* eCount);
}

@GUID("27354146-7F64-5B0F-8F00-5D77AFBE261E")
interface IStreamConcatenate : IStream
{
    HRESULT Initialize(IStream stream1, IStream stream2);
    HRESULT Initialize2(char* streams, uint streamCount);
    HRESULT Append(IStream stream);
    HRESULT Append2(char* streams, uint streamCount);
}

@GUID("27354147-7F64-5B0F-8F00-5D77AFBE261E")
interface IStreamInterleave : IStream
{
    HRESULT Initialize(char* streams, char* interleaveSizes, uint streamCount);
}

@GUID("25983550-9D65-49CE-B335-40630D901227")
interface IRawCDImageCreator : IDispatch
{
    HRESULT CreateResultImage(IStream* resultStream);
    HRESULT AddTrack(IMAPI_CD_SECTOR_TYPE dataType, IStream data, int* trackIndex);
    HRESULT AddSpecialPregap(IStream data);
    HRESULT AddSubcodeRWGenerator(IStream subcode);
    HRESULT put_ResultingImageType(IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE value);
    HRESULT get_ResultingImageType(IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE* value);
    HRESULT get_StartOfLeadout(int* value);
    HRESULT put_StartOfLeadoutLimit(int value);
    HRESULT get_StartOfLeadoutLimit(int* value);
    HRESULT put_DisableGaplessAudio(short value);
    HRESULT get_DisableGaplessAudio(short* value);
    HRESULT put_MediaCatalogNumber(BSTR value);
    HRESULT get_MediaCatalogNumber(BSTR* value);
    HRESULT put_StartingTrackNumber(int value);
    HRESULT get_StartingTrackNumber(int* value);
    HRESULT get_TrackInfo(int trackIndex, IRawCDImageTrackInfo* value);
    HRESULT get_NumberOfExistingTracks(int* value);
    HRESULT get_LastUsedUserSectorInImage(int* value);
    HRESULT get_ExpectedTableOfContents(SAFEARRAY** value);
}

@GUID("25983551-9D65-49CE-B335-40630D901227")
interface IRawCDImageTrackInfo : IDispatch
{
    HRESULT get_StartingLba(int* value);
    HRESULT get_SectorCount(int* value);
    HRESULT get_TrackNumber(int* value);
    HRESULT get_SectorType(IMAPI_CD_SECTOR_TYPE* value);
    HRESULT get_ISRC(BSTR* value);
    HRESULT put_ISRC(BSTR value);
    HRESULT get_DigitalAudioCopySetting(IMAPI_CD_TRACK_DIGITAL_COPY_SETTING* value);
    HRESULT put_DigitalAudioCopySetting(IMAPI_CD_TRACK_DIGITAL_COPY_SETTING value);
    HRESULT get_AudioHasPreemphasis(short* value);
    HRESULT put_AudioHasPreemphasis(short value);
    HRESULT get_TrackIndexes(SAFEARRAY** value);
    HRESULT AddTrackIndex(int lbaOffset);
    HRESULT ClearTrackIndex(int lbaOffset);
}

@GUID("B507CA25-2204-11DD-966A-001AA01BBC58")
interface IBlockRange : IDispatch
{
    HRESULT get_StartLba(int* value);
    HRESULT get_EndLba(int* value);
}

@GUID("B507CA26-2204-11DD-966A-001AA01BBC58")
interface IBlockRangeList : IDispatch
{
    HRESULT get_BlockRanges(SAFEARRAY** value);
}

@GUID("2C941FD4-975B-59BE-A960-9A2A262853A5")
interface IBootOptions : IDispatch
{
    HRESULT get_BootImage(IStream* pVal);
    HRESULT get_Manufacturer(BSTR* pVal);
    HRESULT put_Manufacturer(BSTR newVal);
    HRESULT get_PlatformId(PlatformId* pVal);
    HRESULT put_PlatformId(PlatformId newVal);
    HRESULT get_Emulation(EmulationType* pVal);
    HRESULT put_Emulation(EmulationType newVal);
    HRESULT get_ImageSize(uint* pVal);
    HRESULT AssignBootImage(IStream newVal);
}

@GUID("2C941FD5-975B-59BE-A960-9A2A262853A5")
interface IProgressItem : IDispatch
{
    HRESULT get_Description(BSTR* desc);
    HRESULT get_FirstBlock(uint* block);
    HRESULT get_LastBlock(uint* block);
    HRESULT get_BlockCount(uint* blocks);
}

@GUID("2C941FD6-975B-59BE-A960-9A2A262853A5")
interface IEnumProgressItems : IUnknown
{
    HRESULT Next(uint celt, IProgressItem* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumProgressItems* ppEnum);
}

@GUID("2C941FD7-975B-59BE-A960-9A2A262853A5")
interface IProgressItems : IDispatch
{
    HRESULT get__NewEnum(IEnumVARIANT* NewEnum);
    HRESULT get_Item(int Index, IProgressItem* item);
    HRESULT get_Count(int* Count);
    HRESULT ProgressItemFromBlock(uint block, IProgressItem* item);
    HRESULT ProgressItemFromDescription(BSTR description, IProgressItem* item);
    HRESULT get_EnumProgressItems(IEnumProgressItems* NewEnum);
}

@GUID("2C941FD8-975B-59BE-A960-9A2A262853A5")
interface IFileSystemImageResult : IDispatch
{
    HRESULT get_ImageStream(IStream* pVal);
    HRESULT get_ProgressItems(IProgressItems* pVal);
    HRESULT get_TotalBlocks(int* pVal);
    HRESULT get_BlockSize(int* pVal);
    HRESULT get_DiscId(BSTR* pVal);
}

@GUID("B507CA29-2204-11DD-966A-001AA01BBC58")
interface IFileSystemImageResult2 : IFileSystemImageResult
{
    HRESULT get_ModifiedBlocks(IBlockRangeList* pVal);
}

@GUID("2C941FD9-975B-59BE-A960-9A2A262853A5")
interface IFsiItem : IDispatch
{
    HRESULT get_Name(BSTR* pVal);
    HRESULT get_FullPath(BSTR* pVal);
    HRESULT get_CreationTime(double* pVal);
    HRESULT put_CreationTime(double newVal);
    HRESULT get_LastAccessedTime(double* pVal);
    HRESULT put_LastAccessedTime(double newVal);
    HRESULT get_LastModifiedTime(double* pVal);
    HRESULT put_LastModifiedTime(double newVal);
    HRESULT get_IsHidden(short* pVal);
    HRESULT put_IsHidden(short newVal);
    HRESULT FileSystemName(FsiFileSystems fileSystem, BSTR* pVal);
    HRESULT FileSystemPath(FsiFileSystems fileSystem, BSTR* pVal);
}

@GUID("2C941FDA-975B-59BE-A960-9A2A262853A5")
interface IEnumFsiItems : IUnknown
{
    HRESULT Next(uint celt, IFsiItem* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumFsiItems* ppEnum);
}

@GUID("2C941FDB-975B-59BE-A960-9A2A262853A5")
interface IFsiFileItem : IFsiItem
{
    HRESULT get_DataSize(long* pVal);
    HRESULT get_DataSize32BitLow(int* pVal);
    HRESULT get_DataSize32BitHigh(int* pVal);
    HRESULT get_Data(IStream* pVal);
    HRESULT put_Data(IStream newVal);
}

@GUID("199D0C19-11E1-40EB-8EC2-C8C822A07792")
interface IFsiFileItem2 : IFsiFileItem
{
    HRESULT get_FsiNamedStreams(IFsiNamedStreams* streams);
    HRESULT get_IsNamedStream(short* pVal);
    HRESULT AddStream(BSTR name, IStream streamData);
    HRESULT RemoveStream(BSTR name);
    HRESULT get_IsRealTime(short* pVal);
    HRESULT put_IsRealTime(short newVal);
}

@GUID("ED79BA56-5294-4250-8D46-F9AECEE23459")
interface IFsiNamedStreams : IDispatch
{
    HRESULT get__NewEnum(IEnumVARIANT* NewEnum);
    HRESULT get_Item(int index, IFsiFileItem2* item);
    HRESULT get_Count(int* count);
    HRESULT get_EnumNamedStreams(IEnumFsiItems* NewEnum);
}

@GUID("2C941FDC-975B-59BE-A960-9A2A262853A5")
interface IFsiDirectoryItem : IFsiItem
{
    HRESULT get__NewEnum(IEnumVARIANT* NewEnum);
    HRESULT get_Item(BSTR path, IFsiItem* item);
    HRESULT get_Count(int* Count);
    HRESULT get_EnumFsiItems(IEnumFsiItems* NewEnum);
    HRESULT AddDirectory(BSTR path);
    HRESULT AddFile(BSTR path, IStream fileData);
    HRESULT AddTree(BSTR sourceDirectory, short includeBaseDirectory);
    HRESULT Add(IFsiItem item);
    HRESULT Remove(BSTR path);
    HRESULT RemoveTree(BSTR path);
}

@GUID("F7FB4B9B-6D96-4D7B-9115-201B144811EF")
interface IFsiDirectoryItem2 : IFsiDirectoryItem
{
    HRESULT AddTreeWithNamedStreams(BSTR sourceDirectory, short includeBaseDirectory);
}

@GUID("2C941FE1-975B-59BE-A960-9A2A262853A5")
interface IFileSystemImage : IDispatch
{
    HRESULT get_Root(IFsiDirectoryItem* pVal);
    HRESULT get_SessionStartBlock(int* pVal);
    HRESULT put_SessionStartBlock(int newVal);
    HRESULT get_FreeMediaBlocks(int* pVal);
    HRESULT put_FreeMediaBlocks(int newVal);
    HRESULT SetMaxMediaBlocksFromDevice(IDiscRecorder2 discRecorder);
    HRESULT get_UsedBlocks(int* pVal);
    HRESULT get_VolumeName(BSTR* pVal);
    HRESULT put_VolumeName(BSTR newVal);
    HRESULT get_ImportedVolumeName(BSTR* pVal);
    HRESULT get_BootImageOptions(IBootOptions* pVal);
    HRESULT put_BootImageOptions(IBootOptions newVal);
    HRESULT get_FileCount(int* pVal);
    HRESULT get_DirectoryCount(int* pVal);
    HRESULT get_WorkingDirectory(BSTR* pVal);
    HRESULT put_WorkingDirectory(BSTR newVal);
    HRESULT get_ChangePoint(int* pVal);
    HRESULT get_StrictFileSystemCompliance(short* pVal);
    HRESULT put_StrictFileSystemCompliance(short newVal);
    HRESULT get_UseRestrictedCharacterSet(short* pVal);
    HRESULT put_UseRestrictedCharacterSet(short newVal);
    HRESULT get_FileSystemsToCreate(FsiFileSystems* pVal);
    HRESULT put_FileSystemsToCreate(FsiFileSystems newVal);
    HRESULT get_FileSystemsSupported(FsiFileSystems* pVal);
    HRESULT put_UDFRevision(int newVal);
    HRESULT get_UDFRevision(int* pVal);
    HRESULT get_UDFRevisionsSupported(SAFEARRAY** pVal);
    HRESULT ChooseImageDefaults(IDiscRecorder2 discRecorder);
    HRESULT ChooseImageDefaultsForMediaType(IMAPI_MEDIA_PHYSICAL_TYPE value);
    HRESULT put_ISO9660InterchangeLevel(int newVal);
    HRESULT get_ISO9660InterchangeLevel(int* pVal);
    HRESULT get_ISO9660InterchangeLevelsSupported(SAFEARRAY** pVal);
    HRESULT CreateResultImage(IFileSystemImageResult* resultStream);
    HRESULT Exists(BSTR fullPath, FsiItemType* itemType);
    HRESULT CalculateDiscIdentifier(BSTR* discIdentifier);
    HRESULT IdentifyFileSystemsOnDisc(IDiscRecorder2 discRecorder, FsiFileSystems* fileSystems);
    HRESULT GetDefaultFileSystemForImport(FsiFileSystems fileSystems, FsiFileSystems* importDefault);
    HRESULT ImportFileSystem(FsiFileSystems* importedFileSystem);
    HRESULT ImportSpecificFileSystem(FsiFileSystems fileSystemToUse);
    HRESULT RollbackToChangePoint(int changePoint);
    HRESULT LockInChangePoint();
    HRESULT CreateDirectoryItem(BSTR name, IFsiDirectoryItem* newItem);
    HRESULT CreateFileItem(BSTR name, IFsiFileItem* newItem);
    HRESULT get_VolumeNameUDF(BSTR* pVal);
    HRESULT get_VolumeNameJoliet(BSTR* pVal);
    HRESULT get_VolumeNameISO9660(BSTR* pVal);
    HRESULT get_StageFiles(short* pVal);
    HRESULT put_StageFiles(short newVal);
    HRESULT get_MultisessionInterfaces(SAFEARRAY** pVal);
    HRESULT put_MultisessionInterfaces(SAFEARRAY* newVal);
}

@GUID("D7644B2C-1537-4767-B62F-F1387B02DDFD")
interface IFileSystemImage2 : IFileSystemImage
{
    HRESULT get_BootImageOptionsArray(SAFEARRAY** pVal);
    HRESULT put_BootImageOptionsArray(SAFEARRAY* newVal);
}

@GUID("7CFF842C-7E97-4807-8304-910DD8F7C051")
interface IFileSystemImage3 : IFileSystemImage2
{
    HRESULT get_CreateRedundantUdfMetadataFiles(short* pVal);
    HRESULT put_CreateRedundantUdfMetadataFiles(short newVal);
    HRESULT ProbeSpecificFileSystem(FsiFileSystems fileSystemToProbe, short* isAppendable);
}

@GUID("2C941FDF-975B-59BE-A960-9A2A262853A5")
interface DFileSystemImageEvents : IDispatch
{
    HRESULT Update(IDispatch object, BSTR currentFile, int copiedSectors, int totalSectors);
}

@GUID("D25C30F9-4087-4366-9E24-E55BE286424B")
interface DFileSystemImageImportEvents : IDispatch
{
    HRESULT UpdateImport(IDispatch object, FsiFileSystems fileSystem, BSTR currentItem, int importedDirectoryItems, 
                         int totalDirectoryItems, int importedFileItems, int totalFileItems);
}

@GUID("6CA38BE5-FBBB-4800-95A1-A438865EB0D4")
interface IIsoImageManager : IDispatch
{
    HRESULT get_Path(BSTR* pVal);
    HRESULT get_Stream(IStream* data);
    HRESULT SetPath(BSTR Val);
    HRESULT SetStream(IStream data);
    HRESULT Validate();
}

@GUID("85AC9776-CA88-4CF2-894E-09598C078A41")
interface IDiscRecorder : IUnknown
{
    HRESULT Init(char* pbyUniqueID, uint nulIDSize, uint nulDriveNumber);
    HRESULT GetRecorderGUID(char* pbyUniqueID, uint ulBufferSize, uint* pulReturnSizeRequired);
    HRESULT GetRecorderType(int* fTypeCode);
    HRESULT GetDisplayNames(BSTR* pbstrVendorID, BSTR* pbstrProductID, BSTR* pbstrRevision);
    HRESULT GetBasePnPID(BSTR* pbstrBasePnPID);
    HRESULT GetPath(BSTR* pbstrPath);
    HRESULT GetRecorderProperties(IPropertyStorage* ppPropStg);
    HRESULT SetRecorderProperties(IPropertyStorage pPropStg);
    HRESULT GetRecorderState(uint* pulDevStateFlags);
    HRESULT OpenExclusive();
    HRESULT QueryMediaType(int* fMediaType, int* fMediaFlags);
    HRESULT QueryMediaInfo(ubyte* pbSessions, ubyte* pbLastTrack, uint* ulStartAddress, uint* ulNextWritable, 
                           uint* ulFreeBlocks);
    HRESULT Eject();
    HRESULT Erase(ubyte bFullErase);
    HRESULT Close();
}

@GUID("9B1921E1-54AC-11D3-9144-00104BA11C5E")
interface IEnumDiscRecorders : IUnknown
{
    HRESULT Next(uint cRecorders, char* ppRecorder, uint* pcFetched);
    HRESULT Skip(uint cRecorders);
    HRESULT Reset();
    HRESULT Clone(IEnumDiscRecorders* ppEnum);
}

@GUID("DDF445E1-54BA-11D3-9144-00104BA11C5E")
interface IEnumDiscMasterFormats : IUnknown
{
    HRESULT Next(uint cFormats, char* lpiidFormatID, uint* pcFetched);
    HRESULT Skip(uint cFormats);
    HRESULT Reset();
    HRESULT Clone(IEnumDiscMasterFormats* ppEnum);
}

@GUID("E3BC42CD-4E5C-11D3-9144-00104BA11C5E")
interface IRedbookDiscMaster : IUnknown
{
    HRESULT GetTotalAudioTracks(int* pnTracks);
    HRESULT GetTotalAudioBlocks(int* pnBlocks);
    HRESULT GetUsedAudioBlocks(int* pnBlocks);
    HRESULT GetAvailableAudioTrackBlocks(int* pnBlocks);
    HRESULT GetAudioBlockSize(int* pnBlockBytes);
    HRESULT CreateAudioTrack(int nBlocks);
    HRESULT AddAudioTrackBlocks(char* pby, int cb);
    HRESULT CloseAudioTrack();
}

@GUID("E3BC42CE-4E5C-11D3-9144-00104BA11C5E")
interface IJolietDiscMaster : IUnknown
{
    HRESULT GetTotalDataBlocks(int* pnBlocks);
    HRESULT GetUsedDataBlocks(int* pnBlocks);
    HRESULT GetDataBlockSize(int* pnBlockBytes);
    HRESULT AddData(IStorage pStorage, int lFileOverwrite);
    HRESULT GetJolietProperties(IPropertyStorage* ppPropStg);
    HRESULT SetJolietProperties(IPropertyStorage pPropStg);
}

@GUID("EC9E51C1-4E5D-11D3-9144-00104BA11C5E")
interface IDiscMasterProgressEvents : IUnknown
{
    HRESULT QueryCancel(ubyte* pbCancel);
    HRESULT NotifyPnPActivity();
    HRESULT NotifyAddProgress(int nCompletedSteps, int nTotalSteps);
    HRESULT NotifyBlockProgress(int nCompleted, int nTotal);
    HRESULT NotifyTrackProgress(int nCurrentTrack, int nTotalTracks);
    HRESULT NotifyPreparingBurn(int nEstimatedSeconds);
    HRESULT NotifyClosingDisc(int nEstimatedSeconds);
    HRESULT NotifyBurnComplete(HRESULT status);
    HRESULT NotifyEraseComplete(HRESULT status);
}

@GUID("520CCA62-51A5-11D3-9144-00104BA11C5E")
interface IDiscMaster : IUnknown
{
    HRESULT Open();
    HRESULT EnumDiscMasterFormats(IEnumDiscMasterFormats* ppEnum);
    HRESULT GetActiveDiscMasterFormat(GUID* lpiid);
    HRESULT SetActiveDiscMasterFormat(const(GUID)* riid, void** ppUnk);
    HRESULT EnumDiscRecorders(IEnumDiscRecorders* ppEnum);
    HRESULT GetActiveDiscRecorder(IDiscRecorder* ppRecorder);
    HRESULT SetActiveDiscRecorder(IDiscRecorder pRecorder);
    HRESULT ClearFormatContent();
    HRESULT ProgressAdvise(IDiscMasterProgressEvents pEvents, size_t* pvCookie);
    HRESULT ProgressUnadvise(size_t vCookie);
    HRESULT RecordDisc(ubyte bSimulate, ubyte bEjectAfterBurn);
    HRESULT Close();
}


// GUIDs

const GUID CLSID_BlockRange                  = GUIDOF!BlockRange;
const GUID CLSID_BlockRangeList              = GUIDOF!BlockRangeList;
const GUID CLSID_BootOptions                 = GUIDOF!BootOptions;
const GUID CLSID_EnumFsiItems                = GUIDOF!EnumFsiItems;
const GUID CLSID_EnumProgressItems           = GUIDOF!EnumProgressItems;
const GUID CLSID_FileSystemImageResult       = GUIDOF!FileSystemImageResult;
const GUID CLSID_FsiDirectoryItem            = GUIDOF!FsiDirectoryItem;
const GUID CLSID_FsiFileItem                 = GUIDOF!FsiFileItem;
const GUID CLSID_FsiNamedStreams             = GUIDOF!FsiNamedStreams;
const GUID CLSID_FsiStream                   = GUIDOF!FsiStream;
const GUID CLSID_MSDiscMasterObj             = GUIDOF!MSDiscMasterObj;
const GUID CLSID_MSDiscRecorderObj           = GUIDOF!MSDiscRecorderObj;
const GUID CLSID_MSEnumDiscRecordersObj      = GUIDOF!MSEnumDiscRecordersObj;
const GUID CLSID_MsftDiscFormat2Data         = GUIDOF!MsftDiscFormat2Data;
const GUID CLSID_MsftDiscFormat2Erase        = GUIDOF!MsftDiscFormat2Erase;
const GUID CLSID_MsftDiscFormat2RawCD        = GUIDOF!MsftDiscFormat2RawCD;
const GUID CLSID_MsftDiscFormat2TrackAtOnce  = GUIDOF!MsftDiscFormat2TrackAtOnce;
const GUID CLSID_MsftDiscMaster2             = GUIDOF!MsftDiscMaster2;
const GUID CLSID_MsftDiscRecorder2           = GUIDOF!MsftDiscRecorder2;
const GUID CLSID_MsftFileSystemImage         = GUIDOF!MsftFileSystemImage;
const GUID CLSID_MsftIsoImageManager         = GUIDOF!MsftIsoImageManager;
const GUID CLSID_MsftMultisessionRandomWrite = GUIDOF!MsftMultisessionRandomWrite;
const GUID CLSID_MsftMultisessionSequential  = GUIDOF!MsftMultisessionSequential;
const GUID CLSID_MsftRawCDImageCreator       = GUIDOF!MsftRawCDImageCreator;
const GUID CLSID_MsftStreamConcatenate       = GUIDOF!MsftStreamConcatenate;
const GUID CLSID_MsftStreamInterleave        = GUIDOF!MsftStreamInterleave;
const GUID CLSID_MsftStreamPrng001           = GUIDOF!MsftStreamPrng001;
const GUID CLSID_MsftStreamZero              = GUIDOF!MsftStreamZero;
const GUID CLSID_MsftWriteEngine2            = GUIDOF!MsftWriteEngine2;
const GUID CLSID_MsftWriteSpeedDescriptor    = GUIDOF!MsftWriteSpeedDescriptor;
const GUID CLSID_ProgressItem                = GUIDOF!ProgressItem;
const GUID CLSID_ProgressItems               = GUIDOF!ProgressItems;

const GUID IID_DDiscFormat2DataEvents           = GUIDOF!DDiscFormat2DataEvents;
const GUID IID_DDiscFormat2EraseEvents          = GUIDOF!DDiscFormat2EraseEvents;
const GUID IID_DDiscFormat2RawCDEvents          = GUIDOF!DDiscFormat2RawCDEvents;
const GUID IID_DDiscFormat2TrackAtOnceEvents    = GUIDOF!DDiscFormat2TrackAtOnceEvents;
const GUID IID_DDiscMaster2Events               = GUIDOF!DDiscMaster2Events;
const GUID IID_DFileSystemImageEvents           = GUIDOF!DFileSystemImageEvents;
const GUID IID_DFileSystemImageImportEvents     = GUIDOF!DFileSystemImageImportEvents;
const GUID IID_DWriteEngine2Events              = GUIDOF!DWriteEngine2Events;
const GUID IID_IBlockRange                      = GUIDOF!IBlockRange;
const GUID IID_IBlockRangeList                  = GUIDOF!IBlockRangeList;
const GUID IID_IBootOptions                     = GUIDOF!IBootOptions;
const GUID IID_IBurnVerification                = GUIDOF!IBurnVerification;
const GUID IID_IDiscFormat2                     = GUIDOF!IDiscFormat2;
const GUID IID_IDiscFormat2Data                 = GUIDOF!IDiscFormat2Data;
const GUID IID_IDiscFormat2DataEventArgs        = GUIDOF!IDiscFormat2DataEventArgs;
const GUID IID_IDiscFormat2Erase                = GUIDOF!IDiscFormat2Erase;
const GUID IID_IDiscFormat2RawCD                = GUIDOF!IDiscFormat2RawCD;
const GUID IID_IDiscFormat2RawCDEventArgs       = GUIDOF!IDiscFormat2RawCDEventArgs;
const GUID IID_IDiscFormat2TrackAtOnce          = GUIDOF!IDiscFormat2TrackAtOnce;
const GUID IID_IDiscFormat2TrackAtOnceEventArgs = GUIDOF!IDiscFormat2TrackAtOnceEventArgs;
const GUID IID_IDiscMaster                      = GUIDOF!IDiscMaster;
const GUID IID_IDiscMaster2                     = GUIDOF!IDiscMaster2;
const GUID IID_IDiscMasterProgressEvents        = GUIDOF!IDiscMasterProgressEvents;
const GUID IID_IDiscRecorder                    = GUIDOF!IDiscRecorder;
const GUID IID_IDiscRecorder2                   = GUIDOF!IDiscRecorder2;
const GUID IID_IDiscRecorder2Ex                 = GUIDOF!IDiscRecorder2Ex;
const GUID IID_IEnumDiscMasterFormats           = GUIDOF!IEnumDiscMasterFormats;
const GUID IID_IEnumDiscRecorders               = GUIDOF!IEnumDiscRecorders;
const GUID IID_IEnumFsiItems                    = GUIDOF!IEnumFsiItems;
const GUID IID_IEnumProgressItems               = GUIDOF!IEnumProgressItems;
const GUID IID_IFileSystemImage                 = GUIDOF!IFileSystemImage;
const GUID IID_IFileSystemImage2                = GUIDOF!IFileSystemImage2;
const GUID IID_IFileSystemImage3                = GUIDOF!IFileSystemImage3;
const GUID IID_IFileSystemImageResult           = GUIDOF!IFileSystemImageResult;
const GUID IID_IFileSystemImageResult2          = GUIDOF!IFileSystemImageResult2;
const GUID IID_IFsiDirectoryItem                = GUIDOF!IFsiDirectoryItem;
const GUID IID_IFsiDirectoryItem2               = GUIDOF!IFsiDirectoryItem2;
const GUID IID_IFsiFileItem                     = GUIDOF!IFsiFileItem;
const GUID IID_IFsiFileItem2                    = GUIDOF!IFsiFileItem2;
const GUID IID_IFsiItem                         = GUIDOF!IFsiItem;
const GUID IID_IFsiNamedStreams                 = GUIDOF!IFsiNamedStreams;
const GUID IID_IIsoImageManager                 = GUIDOF!IIsoImageManager;
const GUID IID_IJolietDiscMaster                = GUIDOF!IJolietDiscMaster;
const GUID IID_IMultisession                    = GUIDOF!IMultisession;
const GUID IID_IMultisessionRandomWrite         = GUIDOF!IMultisessionRandomWrite;
const GUID IID_IMultisessionSequential          = GUIDOF!IMultisessionSequential;
const GUID IID_IMultisessionSequential2         = GUIDOF!IMultisessionSequential2;
const GUID IID_IProgressItem                    = GUIDOF!IProgressItem;
const GUID IID_IProgressItems                   = GUIDOF!IProgressItems;
const GUID IID_IRawCDImageCreator               = GUIDOF!IRawCDImageCreator;
const GUID IID_IRawCDImageTrackInfo             = GUIDOF!IRawCDImageTrackInfo;
const GUID IID_IRedbookDiscMaster               = GUIDOF!IRedbookDiscMaster;
const GUID IID_IStreamConcatenate               = GUIDOF!IStreamConcatenate;
const GUID IID_IStreamInterleave                = GUIDOF!IStreamInterleave;
const GUID IID_IStreamPseudoRandomBased         = GUIDOF!IStreamPseudoRandomBased;
const GUID IID_IWriteEngine2                    = GUIDOF!IWriteEngine2;
const GUID IID_IWriteEngine2EventArgs           = GUIDOF!IWriteEngine2EventArgs;
const GUID IID_IWriteSpeedDescriptor            = GUIDOF!IWriteSpeedDescriptor;
