module windows.imapi;

public import system;
public import windows.automation;
public import windows.com;
public import windows.structuredstorage;

extern(Windows):

const GUID CLSID_MsftDiscMaster2 = {0x2735412E, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x2735412E, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
struct MsftDiscMaster2;

const GUID CLSID_MsftDiscRecorder2 = {0x2735412D, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x2735412D, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
struct MsftDiscRecorder2;

const GUID CLSID_MsftWriteEngine2 = {0x2735412C, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x2735412C, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
struct MsftWriteEngine2;

const GUID CLSID_MsftDiscFormat2Erase = {0x2735412B, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x2735412B, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
struct MsftDiscFormat2Erase;

const GUID CLSID_MsftDiscFormat2Data = {0x2735412A, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x2735412A, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
struct MsftDiscFormat2Data;

const GUID CLSID_MsftDiscFormat2TrackAtOnce = {0x27354129, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354129, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
struct MsftDiscFormat2TrackAtOnce;

const GUID CLSID_MsftDiscFormat2RawCD = {0x27354128, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354128, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
struct MsftDiscFormat2RawCD;

const GUID CLSID_MsftStreamZero = {0x27354127, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354127, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
struct MsftStreamZero;

const GUID CLSID_MsftStreamPrng001 = {0x27354126, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354126, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
struct MsftStreamPrng001;

const GUID CLSID_MsftStreamConcatenate = {0x27354125, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354125, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
struct MsftStreamConcatenate;

const GUID CLSID_MsftStreamInterleave = {0x27354124, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354124, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
struct MsftStreamInterleave;

const GUID CLSID_MsftWriteSpeedDescriptor = {0x27354123, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354123, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
struct MsftWriteSpeedDescriptor;

const GUID CLSID_MsftMultisessionSequential = {0x27354122, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354122, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
struct MsftMultisessionSequential;

const GUID CLSID_MsftMultisessionRandomWrite = {0xB507CA24, 0x2204, 0x11DD, [0x96, 0x6A, 0x00, 0x1A, 0xA0, 0x1B, 0xBC, 0x58]};
@GUID(0xB507CA24, 0x2204, 0x11DD, [0x96, 0x6A, 0x00, 0x1A, 0xA0, 0x1B, 0xBC, 0x58]);
struct MsftMultisessionRandomWrite;

const GUID CLSID_MsftRawCDImageCreator = {0x25983561, 0x9D65, 0x49CE, [0xB3, 0x35, 0x40, 0x63, 0x0D, 0x90, 0x12, 0x27]};
@GUID(0x25983561, 0x9D65, 0x49CE, [0xB3, 0x35, 0x40, 0x63, 0x0D, 0x90, 0x12, 0x27]);
struct MsftRawCDImageCreator;

enum IMAPI_MEDIA_PHYSICAL_TYPE
{
    IMAPI_MEDIA_TYPE_UNKNOWN = 0,
    IMAPI_MEDIA_TYPE_CDROM = 1,
    IMAPI_MEDIA_TYPE_CDR = 2,
    IMAPI_MEDIA_TYPE_CDRW = 3,
    IMAPI_MEDIA_TYPE_DVDROM = 4,
    IMAPI_MEDIA_TYPE_DVDRAM = 5,
    IMAPI_MEDIA_TYPE_DVDPLUSR = 6,
    IMAPI_MEDIA_TYPE_DVDPLUSRW = 7,
    IMAPI_MEDIA_TYPE_DVDPLUSR_DUALLAYER = 8,
    IMAPI_MEDIA_TYPE_DVDDASHR = 9,
    IMAPI_MEDIA_TYPE_DVDDASHRW = 10,
    IMAPI_MEDIA_TYPE_DVDDASHR_DUALLAYER = 11,
    IMAPI_MEDIA_TYPE_DISK = 12,
    IMAPI_MEDIA_TYPE_DVDPLUSRW_DUALLAYER = 13,
    IMAPI_MEDIA_TYPE_HDDVDROM = 14,
    IMAPI_MEDIA_TYPE_HDDVDR = 15,
    IMAPI_MEDIA_TYPE_HDDVDRAM = 16,
    IMAPI_MEDIA_TYPE_BDROM = 17,
    IMAPI_MEDIA_TYPE_BDR = 18,
    IMAPI_MEDIA_TYPE_BDRE = 19,
    IMAPI_MEDIA_TYPE_MAX = 19,
}

enum IMAPI_MEDIA_WRITE_PROTECT_STATE
{
    IMAPI_WRITEPROTECTED_UNTIL_POWERDOWN = 1,
    IMAPI_WRITEPROTECTED_BY_CARTRIDGE = 2,
    IMAPI_WRITEPROTECTED_BY_MEDIA_SPECIFIC_REASON = 4,
    IMAPI_WRITEPROTECTED_BY_SOFTWARE_WRITE_PROTECT = 8,
    IMAPI_WRITEPROTECTED_BY_DISC_CONTROL_BLOCK = 16,
    IMAPI_WRITEPROTECTED_READ_ONLY_MEDIA = 16384,
}

enum IMAPI_READ_TRACK_ADDRESS_TYPE
{
    IMAPI_READ_TRACK_ADDRESS_TYPE_LBA = 0,
    IMAPI_READ_TRACK_ADDRESS_TYPE_TRACK = 1,
    IMAPI_READ_TRACK_ADDRESS_TYPE_SESSION = 2,
}

enum IMAPI_MODE_PAGE_REQUEST_TYPE
{
    IMAPI_MODE_PAGE_REQUEST_TYPE_CURRENT_VALUES = 0,
    IMAPI_MODE_PAGE_REQUEST_TYPE_CHANGEABLE_VALUES = 1,
    IMAPI_MODE_PAGE_REQUEST_TYPE_DEFAULT_VALUES = 2,
    IMAPI_MODE_PAGE_REQUEST_TYPE_SAVED_VALUES = 3,
}

enum IMAPI_MODE_PAGE_TYPE
{
    IMAPI_MODE_PAGE_TYPE_READ_WRITE_ERROR_RECOVERY = 1,
    IMAPI_MODE_PAGE_TYPE_MRW = 3,
    IMAPI_MODE_PAGE_TYPE_WRITE_PARAMETERS = 5,
    IMAPI_MODE_PAGE_TYPE_CACHING = 8,
    IMAPI_MODE_PAGE_TYPE_INFORMATIONAL_EXCEPTIONS = 28,
    IMAPI_MODE_PAGE_TYPE_TIMEOUT_AND_PROTECT = 29,
    IMAPI_MODE_PAGE_TYPE_POWER_CONDITION = 26,
    IMAPI_MODE_PAGE_TYPE_LEGACY_CAPABILITIES = 42,
}

enum IMAPI_FEATURE_PAGE_TYPE
{
    IMAPI_FEATURE_PAGE_TYPE_PROFILE_LIST = 0,
    IMAPI_FEATURE_PAGE_TYPE_CORE = 1,
    IMAPI_FEATURE_PAGE_TYPE_MORPHING = 2,
    IMAPI_FEATURE_PAGE_TYPE_REMOVABLE_MEDIUM = 3,
    IMAPI_FEATURE_PAGE_TYPE_WRITE_PROTECT = 4,
    IMAPI_FEATURE_PAGE_TYPE_RANDOMLY_READABLE = 16,
    IMAPI_FEATURE_PAGE_TYPE_CD_MULTIREAD = 29,
    IMAPI_FEATURE_PAGE_TYPE_CD_READ = 30,
    IMAPI_FEATURE_PAGE_TYPE_DVD_READ = 31,
    IMAPI_FEATURE_PAGE_TYPE_RANDOMLY_WRITABLE = 32,
    IMAPI_FEATURE_PAGE_TYPE_INCREMENTAL_STREAMING_WRITABLE = 33,
    IMAPI_FEATURE_PAGE_TYPE_SECTOR_ERASABLE = 34,
    IMAPI_FEATURE_PAGE_TYPE_FORMATTABLE = 35,
    IMAPI_FEATURE_PAGE_TYPE_HARDWARE_DEFECT_MANAGEMENT = 36,
    IMAPI_FEATURE_PAGE_TYPE_WRITE_ONCE = 37,
    IMAPI_FEATURE_PAGE_TYPE_RESTRICTED_OVERWRITE = 38,
    IMAPI_FEATURE_PAGE_TYPE_CDRW_CAV_WRITE = 39,
    IMAPI_FEATURE_PAGE_TYPE_MRW = 40,
    IMAPI_FEATURE_PAGE_TYPE_ENHANCED_DEFECT_REPORTING = 41,
    IMAPI_FEATURE_PAGE_TYPE_DVD_PLUS_RW = 42,
    IMAPI_FEATURE_PAGE_TYPE_DVD_PLUS_R = 43,
    IMAPI_FEATURE_PAGE_TYPE_RIGID_RESTRICTED_OVERWRITE = 44,
    IMAPI_FEATURE_PAGE_TYPE_CD_TRACK_AT_ONCE = 45,
    IMAPI_FEATURE_PAGE_TYPE_CD_MASTERING = 46,
    IMAPI_FEATURE_PAGE_TYPE_DVD_DASH_WRITE = 47,
    IMAPI_FEATURE_PAGE_TYPE_DOUBLE_DENSITY_CD_READ = 48,
    IMAPI_FEATURE_PAGE_TYPE_DOUBLE_DENSITY_CD_R_WRITE = 49,
    IMAPI_FEATURE_PAGE_TYPE_DOUBLE_DENSITY_CD_RW_WRITE = 50,
    IMAPI_FEATURE_PAGE_TYPE_LAYER_JUMP_RECORDING = 51,
    IMAPI_FEATURE_PAGE_TYPE_CD_RW_MEDIA_WRITE_SUPPORT = 55,
    IMAPI_FEATURE_PAGE_TYPE_BD_PSEUDO_OVERWRITE = 56,
    IMAPI_FEATURE_PAGE_TYPE_DVD_PLUS_R_DUAL_LAYER = 59,
    IMAPI_FEATURE_PAGE_TYPE_BD_READ = 64,
    IMAPI_FEATURE_PAGE_TYPE_BD_WRITE = 65,
    IMAPI_FEATURE_PAGE_TYPE_HD_DVD_READ = 80,
    IMAPI_FEATURE_PAGE_TYPE_HD_DVD_WRITE = 81,
    IMAPI_FEATURE_PAGE_TYPE_POWER_MANAGEMENT = 256,
    IMAPI_FEATURE_PAGE_TYPE_SMART = 257,
    IMAPI_FEATURE_PAGE_TYPE_EMBEDDED_CHANGER = 258,
    IMAPI_FEATURE_PAGE_TYPE_CD_ANALOG_PLAY = 259,
    IMAPI_FEATURE_PAGE_TYPE_MICROCODE_UPDATE = 260,
    IMAPI_FEATURE_PAGE_TYPE_TIMEOUT = 261,
    IMAPI_FEATURE_PAGE_TYPE_DVD_CSS = 262,
    IMAPI_FEATURE_PAGE_TYPE_REAL_TIME_STREAMING = 263,
    IMAPI_FEATURE_PAGE_TYPE_LOGICAL_UNIT_SERIAL_NUMBER = 264,
    IMAPI_FEATURE_PAGE_TYPE_MEDIA_SERIAL_NUMBER = 265,
    IMAPI_FEATURE_PAGE_TYPE_DISC_CONTROL_BLOCKS = 266,
    IMAPI_FEATURE_PAGE_TYPE_DVD_CPRM = 267,
    IMAPI_FEATURE_PAGE_TYPE_FIRMWARE_INFORMATION = 268,
    IMAPI_FEATURE_PAGE_TYPE_AACS = 269,
    IMAPI_FEATURE_PAGE_TYPE_VCPS = 272,
}

enum IMAPI_PROFILE_TYPE
{
    IMAPI_PROFILE_TYPE_INVALID = 0,
    IMAPI_PROFILE_TYPE_NON_REMOVABLE_DISK = 1,
    IMAPI_PROFILE_TYPE_REMOVABLE_DISK = 2,
    IMAPI_PROFILE_TYPE_MO_ERASABLE = 3,
    IMAPI_PROFILE_TYPE_MO_WRITE_ONCE = 4,
    IMAPI_PROFILE_TYPE_AS_MO = 5,
    IMAPI_PROFILE_TYPE_CDROM = 8,
    IMAPI_PROFILE_TYPE_CD_RECORDABLE = 9,
    IMAPI_PROFILE_TYPE_CD_REWRITABLE = 10,
    IMAPI_PROFILE_TYPE_DVDROM = 16,
    IMAPI_PROFILE_TYPE_DVD_DASH_RECORDABLE = 17,
    IMAPI_PROFILE_TYPE_DVD_RAM = 18,
    IMAPI_PROFILE_TYPE_DVD_DASH_REWRITABLE = 19,
    IMAPI_PROFILE_TYPE_DVD_DASH_RW_SEQUENTIAL = 20,
    IMAPI_PROFILE_TYPE_DVD_DASH_R_DUAL_SEQUENTIAL = 21,
    IMAPI_PROFILE_TYPE_DVD_DASH_R_DUAL_LAYER_JUMP = 22,
    IMAPI_PROFILE_TYPE_DVD_PLUS_RW = 26,
    IMAPI_PROFILE_TYPE_DVD_PLUS_R = 27,
    IMAPI_PROFILE_TYPE_DDCDROM = 32,
    IMAPI_PROFILE_TYPE_DDCD_RECORDABLE = 33,
    IMAPI_PROFILE_TYPE_DDCD_REWRITABLE = 34,
    IMAPI_PROFILE_TYPE_DVD_PLUS_RW_DUAL = 42,
    IMAPI_PROFILE_TYPE_DVD_PLUS_R_DUAL = 43,
    IMAPI_PROFILE_TYPE_BD_ROM = 64,
    IMAPI_PROFILE_TYPE_BD_R_SEQUENTIAL = 65,
    IMAPI_PROFILE_TYPE_BD_R_RANDOM_RECORDING = 66,
    IMAPI_PROFILE_TYPE_BD_REWRITABLE = 67,
    IMAPI_PROFILE_TYPE_HD_DVD_ROM = 80,
    IMAPI_PROFILE_TYPE_HD_DVD_RECORDABLE = 81,
    IMAPI_PROFILE_TYPE_HD_DVD_RAM = 82,
    IMAPI_PROFILE_TYPE_NON_STANDARD = 65535,
}

enum IMAPI_FORMAT2_DATA_WRITE_ACTION
{
    IMAPI_FORMAT2_DATA_WRITE_ACTION_VALIDATING_MEDIA = 0,
    IMAPI_FORMAT2_DATA_WRITE_ACTION_FORMATTING_MEDIA = 1,
    IMAPI_FORMAT2_DATA_WRITE_ACTION_INITIALIZING_HARDWARE = 2,
    IMAPI_FORMAT2_DATA_WRITE_ACTION_CALIBRATING_POWER = 3,
    IMAPI_FORMAT2_DATA_WRITE_ACTION_WRITING_DATA = 4,
    IMAPI_FORMAT2_DATA_WRITE_ACTION_FINALIZATION = 5,
    IMAPI_FORMAT2_DATA_WRITE_ACTION_COMPLETED = 6,
    IMAPI_FORMAT2_DATA_WRITE_ACTION_VERIFYING = 7,
}

enum IMAPI_FORMAT2_DATA_MEDIA_STATE
{
    IMAPI_FORMAT2_DATA_MEDIA_STATE_UNKNOWN = 0,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_INFORMATIONAL_MASK = 15,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_UNSUPPORTED_MASK = 64512,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_OVERWRITE_ONLY = 1,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_RANDOMLY_WRITABLE = 1,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_BLANK = 2,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_APPENDABLE = 4,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_FINAL_SESSION = 8,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_DAMAGED = 1024,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_ERASE_REQUIRED = 2048,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_NON_EMPTY_SESSION = 4096,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_WRITE_PROTECTED = 8192,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_FINALIZED = 16384,
    IMAPI_FORMAT2_DATA_MEDIA_STATE_UNSUPPORTED_MEDIA = 32768,
}

enum IMAPI_FORMAT2_TAO_WRITE_ACTION
{
    IMAPI_FORMAT2_TAO_WRITE_ACTION_UNKNOWN = 0,
    IMAPI_FORMAT2_TAO_WRITE_ACTION_PREPARING = 1,
    IMAPI_FORMAT2_TAO_WRITE_ACTION_WRITING = 2,
    IMAPI_FORMAT2_TAO_WRITE_ACTION_FINISHING = 3,
    IMAPI_FORMAT2_TAO_WRITE_ACTION_VERIFYING = 4,
}

enum IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE
{
    IMAPI_FORMAT2_RAW_CD_SUBCODE_PQ_ONLY = 1,
    IMAPI_FORMAT2_RAW_CD_SUBCODE_IS_COOKED = 2,
    IMAPI_FORMAT2_RAW_CD_SUBCODE_IS_RAW = 3,
}

enum IMAPI_FORMAT2_RAW_CD_WRITE_ACTION
{
    IMAPI_FORMAT2_RAW_CD_WRITE_ACTION_UNKNOWN = 0,
    IMAPI_FORMAT2_RAW_CD_WRITE_ACTION_PREPARING = 1,
    IMAPI_FORMAT2_RAW_CD_WRITE_ACTION_WRITING = 2,
    IMAPI_FORMAT2_RAW_CD_WRITE_ACTION_FINISHING = 3,
}

enum IMAPI_CD_SECTOR_TYPE
{
    IMAPI_CD_SECTOR_AUDIO = 0,
    IMAPI_CD_SECTOR_MODE_ZERO = 1,
    IMAPI_CD_SECTOR_MODE1 = 2,
    IMAPI_CD_SECTOR_MODE2FORM0 = 3,
    IMAPI_CD_SECTOR_MODE2FORM1 = 4,
    IMAPI_CD_SECTOR_MODE2FORM2 = 5,
    IMAPI_CD_SECTOR_MODE1RAW = 6,
    IMAPI_CD_SECTOR_MODE2FORM0RAW = 7,
    IMAPI_CD_SECTOR_MODE2FORM1RAW = 8,
    IMAPI_CD_SECTOR_MODE2FORM2RAW = 9,
}

enum IMAPI_CD_TRACK_DIGITAL_COPY_SETTING
{
    IMAPI_CD_TRACK_DIGITAL_COPY_PERMITTED = 0,
    IMAPI_CD_TRACK_DIGITAL_COPY_PROHIBITED = 1,
    IMAPI_CD_TRACK_DIGITAL_COPY_SCMS = 2,
}

enum IMAPI_BURN_VERIFICATION_LEVEL
{
    IMAPI_BURN_VERIFICATION_NONE = 0,
    IMAPI_BURN_VERIFICATION_QUICK = 1,
    IMAPI_BURN_VERIFICATION_FULL = 2,
}

const GUID IID_IDiscMaster2 = {0x27354130, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354130, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
interface IDiscMaster2 : IDispatch
{
    HRESULT get__NewEnum(IEnumVARIANT* ppunk);
    HRESULT get_Item(int index, BSTR* value);
    HRESULT get_Count(int* value);
    HRESULT get_IsSupportedEnvironment(short* value);
}

const GUID IID_DDiscMaster2Events = {0x27354131, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354131, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
interface DDiscMaster2Events : IDispatch
{
    HRESULT NotifyDeviceAdded(IDispatch object, BSTR uniqueId);
    HRESULT NotifyDeviceRemoved(IDispatch object, BSTR uniqueId);
}

const GUID IID_IDiscRecorder2Ex = {0x27354132, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354132, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
interface IDiscRecorder2Ex : IUnknown
{
    HRESULT SendCommandNoData(char* Cdb, uint CdbSize, char* SenseBuffer, uint Timeout);
    HRESULT SendCommandSendDataToDevice(char* Cdb, uint CdbSize, char* SenseBuffer, uint Timeout, char* Buffer, uint BufferSize);
    HRESULT SendCommandGetDataFromDevice(char* Cdb, uint CdbSize, char* SenseBuffer, uint Timeout, char* Buffer, uint BufferSize, uint* BufferFetched);
    HRESULT ReadDvdStructure(uint format, uint address, uint layer, uint agid, char* data, uint* count);
    HRESULT SendDvdStructure(uint format, char* data, uint count);
    HRESULT GetAdapterDescriptor(char* data, uint* byteSize);
    HRESULT GetDeviceDescriptor(char* data, uint* byteSize);
    HRESULT GetDiscInformation(char* discInformation, uint* byteSize);
    HRESULT GetTrackInformation(uint address, IMAPI_READ_TRACK_ADDRESS_TYPE addressType, char* trackInformation, uint* byteSize);
    HRESULT GetFeaturePage(IMAPI_FEATURE_PAGE_TYPE requestedFeature, ubyte currentFeatureOnly, char* featureData, uint* byteSize);
    HRESULT GetModePage(IMAPI_MODE_PAGE_TYPE requestedModePage, IMAPI_MODE_PAGE_REQUEST_TYPE requestType, char* modePageData, uint* byteSize);
    HRESULT SetModePage(IMAPI_MODE_PAGE_REQUEST_TYPE requestType, char* data, uint byteSize);
    HRESULT GetSupportedFeaturePages(ubyte currentFeatureOnly, char* featureData, uint* byteSize);
    HRESULT GetSupportedProfiles(ubyte currentOnly, char* profileTypes, uint* validProfiles);
    HRESULT GetSupportedModePages(IMAPI_MODE_PAGE_REQUEST_TYPE requestType, char* modePageTypes, uint* validPages);
    HRESULT GetByteAlignmentMask(uint* value);
    HRESULT GetMaximumNonPageAlignedTransferSize(uint* value);
    HRESULT GetMaximumPageAlignedTransferSize(uint* value);
}

const GUID IID_IDiscRecorder2 = {0x27354133, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354133, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
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

const GUID IID_IWriteEngine2 = {0x27354135, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354135, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
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

const GUID IID_IWriteEngine2EventArgs = {0x27354136, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354136, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
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

const GUID IID_DWriteEngine2Events = {0x27354137, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354137, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
interface DWriteEngine2Events : IDispatch
{
    HRESULT Update(IDispatch object, IDispatch progress);
}

const GUID IID_IDiscFormat2 = {0x27354152, 0x8F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354152, 0x8F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
interface IDiscFormat2 : IDispatch
{
    HRESULT IsRecorderSupported(IDiscRecorder2 recorder, short* value);
    HRESULT IsCurrentMediaSupported(IDiscRecorder2 recorder, short* value);
    HRESULT get_MediaPhysicallyBlank(short* value);
    HRESULT get_MediaHeuristicallyBlank(short* value);
    HRESULT get_SupportedMediaTypes(SAFEARRAY** value);
}

const GUID IID_IDiscFormat2Erase = {0x27354156, 0x8F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354156, 0x8F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
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

const GUID IID_DDiscFormat2EraseEvents = {0x2735413A, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x2735413A, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
interface DDiscFormat2EraseEvents : IDispatch
{
    HRESULT Update(IDispatch object, int elapsedSeconds, int estimatedTotalSeconds);
}

const GUID IID_IDiscFormat2Data = {0x27354153, 0x9F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354153, 0x9F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
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

const GUID IID_DDiscFormat2DataEvents = {0x2735413C, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x2735413C, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
interface DDiscFormat2DataEvents : IDispatch
{
    HRESULT Update(IDispatch object, IDispatch progress);
}

const GUID IID_IDiscFormat2DataEventArgs = {0x2735413D, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x2735413D, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
interface IDiscFormat2DataEventArgs : IWriteEngine2EventArgs
{
    HRESULT get_ElapsedTime(int* value);
    HRESULT get_RemainingTime(int* value);
    HRESULT get_TotalTime(int* value);
    HRESULT get_CurrentAction(IMAPI_FORMAT2_DATA_WRITE_ACTION* value);
}

const GUID IID_IDiscFormat2TrackAtOnce = {0x27354154, 0x8F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354154, 0x8F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
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

const GUID IID_DDiscFormat2TrackAtOnceEvents = {0x2735413F, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x2735413F, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
interface DDiscFormat2TrackAtOnceEvents : IDispatch
{
    HRESULT Update(IDispatch object, IDispatch progress);
}

const GUID IID_IDiscFormat2TrackAtOnceEventArgs = {0x27354140, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354140, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
interface IDiscFormat2TrackAtOnceEventArgs : IWriteEngine2EventArgs
{
    HRESULT get_CurrentTrackNumber(int* value);
    HRESULT get_CurrentAction(IMAPI_FORMAT2_TAO_WRITE_ACTION* value);
    HRESULT get_ElapsedTime(int* value);
    HRESULT get_RemainingTime(int* value);
}

const GUID IID_IDiscFormat2RawCD = {0x27354155, 0x8F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354155, 0x8F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
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

const GUID IID_DDiscFormat2RawCDEvents = {0x27354142, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354142, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
interface DDiscFormat2RawCDEvents : IDispatch
{
    HRESULT Update(IDispatch object, IDispatch progress);
}

const GUID IID_IDiscFormat2RawCDEventArgs = {0x27354143, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354143, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
interface IDiscFormat2RawCDEventArgs : IWriteEngine2EventArgs
{
    HRESULT get_CurrentAction(IMAPI_FORMAT2_RAW_CD_WRITE_ACTION* value);
    HRESULT get_ElapsedTime(int* value);
    HRESULT get_RemainingTime(int* value);
}

const GUID IID_IBurnVerification = {0xD2FFD834, 0x958B, 0x426D, [0x84, 0x70, 0x2A, 0x13, 0x87, 0x9C, 0x6A, 0x91]};
@GUID(0xD2FFD834, 0x958B, 0x426D, [0x84, 0x70, 0x2A, 0x13, 0x87, 0x9C, 0x6A, 0x91]);
interface IBurnVerification : IUnknown
{
    HRESULT put_BurnVerificationLevel(IMAPI_BURN_VERIFICATION_LEVEL value);
    HRESULT get_BurnVerificationLevel(IMAPI_BURN_VERIFICATION_LEVEL* value);
}

const GUID IID_IWriteSpeedDescriptor = {0x27354144, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354144, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
interface IWriteSpeedDescriptor : IDispatch
{
    HRESULT get_MediaType(IMAPI_MEDIA_PHYSICAL_TYPE* value);
    HRESULT get_RotationTypeIsPureCAV(short* value);
    HRESULT get_WriteSpeed(int* value);
}

const GUID IID_IMultisession = {0x27354150, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354150, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
interface IMultisession : IDispatch
{
    HRESULT get_IsSupportedOnCurrentMediaState(short* value);
    HRESULT put_InUse(short value);
    HRESULT get_InUse(short* value);
    HRESULT get_ImportRecorder(IDiscRecorder2* value);
}

const GUID IID_IMultisessionSequential = {0x27354151, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354151, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
interface IMultisessionSequential : IMultisession
{
    HRESULT get_IsFirstDataSession(short* value);
    HRESULT get_StartAddressOfPreviousSession(int* value);
    HRESULT get_LastWrittenAddressOfPreviousSession(int* value);
    HRESULT get_NextWritableAddress(int* value);
    HRESULT get_FreeSectorsOnMedia(int* value);
}

const GUID IID_IMultisessionSequential2 = {0xB507CA22, 0x2204, 0x11DD, [0x96, 0x6A, 0x00, 0x1A, 0xA0, 0x1B, 0xBC, 0x58]};
@GUID(0xB507CA22, 0x2204, 0x11DD, [0x96, 0x6A, 0x00, 0x1A, 0xA0, 0x1B, 0xBC, 0x58]);
interface IMultisessionSequential2 : IMultisessionSequential
{
    HRESULT get_WriteUnitSize(int* value);
}

const GUID IID_IMultisessionRandomWrite = {0xB507CA23, 0x2204, 0x11DD, [0x96, 0x6A, 0x00, 0x1A, 0xA0, 0x1B, 0xBC, 0x58]};
@GUID(0xB507CA23, 0x2204, 0x11DD, [0x96, 0x6A, 0x00, 0x1A, 0xA0, 0x1B, 0xBC, 0x58]);
interface IMultisessionRandomWrite : IMultisession
{
    HRESULT get_WriteUnitSize(int* value);
    HRESULT get_LastWrittenAddress(int* value);
    HRESULT get_TotalSectorsOnMedia(int* value);
}

const GUID IID_IStreamPseudoRandomBased = {0x27354145, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354145, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
interface IStreamPseudoRandomBased : IStream
{
    HRESULT put_Seed(uint value);
    HRESULT get_Seed(uint* value);
    HRESULT put_ExtendedSeed(char* values, uint eCount);
    HRESULT get_ExtendedSeed(char* values, uint* eCount);
}

const GUID IID_IStreamConcatenate = {0x27354146, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354146, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
interface IStreamConcatenate : IStream
{
    HRESULT Initialize(IStream stream1, IStream stream2);
    HRESULT Initialize2(char* streams, uint streamCount);
    HRESULT Append(IStream stream);
    HRESULT Append2(char* streams, uint streamCount);
}

const GUID IID_IStreamInterleave = {0x27354147, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]};
@GUID(0x27354147, 0x7F64, 0x5B0F, [0x8F, 0x00, 0x5D, 0x77, 0xAF, 0xBE, 0x26, 0x1E]);
interface IStreamInterleave : IStream
{
    HRESULT Initialize(char* streams, char* interleaveSizes, uint streamCount);
}

const GUID IID_IRawCDImageCreator = {0x25983550, 0x9D65, 0x49CE, [0xB3, 0x35, 0x40, 0x63, 0x0D, 0x90, 0x12, 0x27]};
@GUID(0x25983550, 0x9D65, 0x49CE, [0xB3, 0x35, 0x40, 0x63, 0x0D, 0x90, 0x12, 0x27]);
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

const GUID IID_IRawCDImageTrackInfo = {0x25983551, 0x9D65, 0x49CE, [0xB3, 0x35, 0x40, 0x63, 0x0D, 0x90, 0x12, 0x27]};
@GUID(0x25983551, 0x9D65, 0x49CE, [0xB3, 0x35, 0x40, 0x63, 0x0D, 0x90, 0x12, 0x27]);
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

const GUID IID_IBlockRange = {0xB507CA25, 0x2204, 0x11DD, [0x96, 0x6A, 0x00, 0x1A, 0xA0, 0x1B, 0xBC, 0x58]};
@GUID(0xB507CA25, 0x2204, 0x11DD, [0x96, 0x6A, 0x00, 0x1A, 0xA0, 0x1B, 0xBC, 0x58]);
interface IBlockRange : IDispatch
{
    HRESULT get_StartLba(int* value);
    HRESULT get_EndLba(int* value);
}

const GUID IID_IBlockRangeList = {0xB507CA26, 0x2204, 0x11DD, [0x96, 0x6A, 0x00, 0x1A, 0xA0, 0x1B, 0xBC, 0x58]};
@GUID(0xB507CA26, 0x2204, 0x11DD, [0x96, 0x6A, 0x00, 0x1A, 0xA0, 0x1B, 0xBC, 0x58]);
interface IBlockRangeList : IDispatch
{
    HRESULT get_BlockRanges(SAFEARRAY** value);
}

const GUID CLSID_BootOptions = {0x2C941FCE, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FCE, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
struct BootOptions;

const GUID CLSID_FsiStream = {0x2C941FCD, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FCD, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
struct FsiStream;

const GUID CLSID_FileSystemImageResult = {0x2C941FCC, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FCC, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
struct FileSystemImageResult;

const GUID CLSID_ProgressItem = {0x2C941FCB, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FCB, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
struct ProgressItem;

const GUID CLSID_EnumProgressItems = {0x2C941FCA, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FCA, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
struct EnumProgressItems;

const GUID CLSID_ProgressItems = {0x2C941FC9, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FC9, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
struct ProgressItems;

const GUID CLSID_FsiDirectoryItem = {0x2C941FC8, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FC8, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
struct FsiDirectoryItem;

const GUID CLSID_FsiFileItem = {0x2C941FC7, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FC7, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
struct FsiFileItem;

const GUID CLSID_EnumFsiItems = {0x2C941FC6, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FC6, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
struct EnumFsiItems;

const GUID CLSID_FsiNamedStreams = {0xC6B6F8ED, 0x6D19, 0x44B4, [0xB5, 0x39, 0xB1, 0x59, 0xB7, 0x93, 0xA3, 0x2D]};
@GUID(0xC6B6F8ED, 0x6D19, 0x44B4, [0xB5, 0x39, 0xB1, 0x59, 0xB7, 0x93, 0xA3, 0x2D]);
struct FsiNamedStreams;

const GUID CLSID_MsftFileSystemImage = {0x2C941FC5, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FC5, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
struct MsftFileSystemImage;

const GUID CLSID_MsftIsoImageManager = {0xCEEE3B62, 0x8F56, 0x4056, [0x86, 0x9B, 0xEF, 0x16, 0x91, 0x7E, 0x3E, 0xFC]};
@GUID(0xCEEE3B62, 0x8F56, 0x4056, [0x86, 0x9B, 0xEF, 0x16, 0x91, 0x7E, 0x3E, 0xFC]);
struct MsftIsoImageManager;

const GUID CLSID_BlockRange = {0xB507CA27, 0x2204, 0x11DD, [0x96, 0x6A, 0x00, 0x1A, 0xA0, 0x1B, 0xBC, 0x58]};
@GUID(0xB507CA27, 0x2204, 0x11DD, [0x96, 0x6A, 0x00, 0x1A, 0xA0, 0x1B, 0xBC, 0x58]);
struct BlockRange;

const GUID CLSID_BlockRangeList = {0xB507CA28, 0x2204, 0x11DD, [0x96, 0x6A, 0x00, 0x1A, 0xA0, 0x1B, 0xBC, 0x58]};
@GUID(0xB507CA28, 0x2204, 0x11DD, [0x96, 0x6A, 0x00, 0x1A, 0xA0, 0x1B, 0xBC, 0x58]);
struct BlockRangeList;

enum FsiItemType
{
    FsiItemNotFound = 0,
    FsiItemDirectory = 1,
    FsiItemFile = 2,
}

enum FsiFileSystems
{
    FsiFileSystemNone = 0,
    FsiFileSystemISO9660 = 1,
    FsiFileSystemJoliet = 2,
    FsiFileSystemUDF = 4,
    FsiFileSystemUnknown = 1073741824,
}

enum EmulationType
{
    EmulationNone = 0,
    Emulation12MFloppy = 1,
    Emulation144MFloppy = 2,
    Emulation288MFloppy = 3,
    EmulationHardDisk = 4,
}

enum PlatformId
{
    PlatformX86 = 0,
    PlatformPowerPC = 1,
    PlatformMac = 2,
    PlatformEFI = 239,
}

const GUID IID_IBootOptions = {0x2C941FD4, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FD4, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
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

const GUID IID_IProgressItem = {0x2C941FD5, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FD5, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
interface IProgressItem : IDispatch
{
    HRESULT get_Description(BSTR* desc);
    HRESULT get_FirstBlock(uint* block);
    HRESULT get_LastBlock(uint* block);
    HRESULT get_BlockCount(uint* blocks);
}

const GUID IID_IEnumProgressItems = {0x2C941FD6, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FD6, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
interface IEnumProgressItems : IUnknown
{
    HRESULT Next(uint celt, IProgressItem* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumProgressItems* ppEnum);
}

const GUID IID_IProgressItems = {0x2C941FD7, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FD7, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
interface IProgressItems : IDispatch
{
    HRESULT get__NewEnum(IEnumVARIANT* NewEnum);
    HRESULT get_Item(int Index, IProgressItem* item);
    HRESULT get_Count(int* Count);
    HRESULT ProgressItemFromBlock(uint block, IProgressItem* item);
    HRESULT ProgressItemFromDescription(BSTR description, IProgressItem* item);
    HRESULT get_EnumProgressItems(IEnumProgressItems* NewEnum);
}

const GUID IID_IFileSystemImageResult = {0x2C941FD8, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FD8, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
interface IFileSystemImageResult : IDispatch
{
    HRESULT get_ImageStream(IStream* pVal);
    HRESULT get_ProgressItems(IProgressItems* pVal);
    HRESULT get_TotalBlocks(int* pVal);
    HRESULT get_BlockSize(int* pVal);
    HRESULT get_DiscId(BSTR* pVal);
}

const GUID IID_IFileSystemImageResult2 = {0xB507CA29, 0x2204, 0x11DD, [0x96, 0x6A, 0x00, 0x1A, 0xA0, 0x1B, 0xBC, 0x58]};
@GUID(0xB507CA29, 0x2204, 0x11DD, [0x96, 0x6A, 0x00, 0x1A, 0xA0, 0x1B, 0xBC, 0x58]);
interface IFileSystemImageResult2 : IFileSystemImageResult
{
    HRESULT get_ModifiedBlocks(IBlockRangeList* pVal);
}

const GUID IID_IFsiItem = {0x2C941FD9, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FD9, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
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

const GUID IID_IEnumFsiItems = {0x2C941FDA, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FDA, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
interface IEnumFsiItems : IUnknown
{
    HRESULT Next(uint celt, IFsiItem* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumFsiItems* ppEnum);
}

const GUID IID_IFsiFileItem = {0x2C941FDB, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FDB, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
interface IFsiFileItem : IFsiItem
{
    HRESULT get_DataSize(long* pVal);
    HRESULT get_DataSize32BitLow(int* pVal);
    HRESULT get_DataSize32BitHigh(int* pVal);
    HRESULT get_Data(IStream* pVal);
    HRESULT put_Data(IStream newVal);
}

const GUID IID_IFsiFileItem2 = {0x199D0C19, 0x11E1, 0x40EB, [0x8E, 0xC2, 0xC8, 0xC8, 0x22, 0xA0, 0x77, 0x92]};
@GUID(0x199D0C19, 0x11E1, 0x40EB, [0x8E, 0xC2, 0xC8, 0xC8, 0x22, 0xA0, 0x77, 0x92]);
interface IFsiFileItem2 : IFsiFileItem
{
    HRESULT get_FsiNamedStreams(IFsiNamedStreams* streams);
    HRESULT get_IsNamedStream(short* pVal);
    HRESULT AddStream(BSTR name, IStream streamData);
    HRESULT RemoveStream(BSTR name);
    HRESULT get_IsRealTime(short* pVal);
    HRESULT put_IsRealTime(short newVal);
}

const GUID IID_IFsiNamedStreams = {0xED79BA56, 0x5294, 0x4250, [0x8D, 0x46, 0xF9, 0xAE, 0xCE, 0xE2, 0x34, 0x59]};
@GUID(0xED79BA56, 0x5294, 0x4250, [0x8D, 0x46, 0xF9, 0xAE, 0xCE, 0xE2, 0x34, 0x59]);
interface IFsiNamedStreams : IDispatch
{
    HRESULT get__NewEnum(IEnumVARIANT* NewEnum);
    HRESULT get_Item(int index, IFsiFileItem2* item);
    HRESULT get_Count(int* count);
    HRESULT get_EnumNamedStreams(IEnumFsiItems* NewEnum);
}

const GUID IID_IFsiDirectoryItem = {0x2C941FDC, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FDC, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
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

const GUID IID_IFsiDirectoryItem2 = {0xF7FB4B9B, 0x6D96, 0x4D7B, [0x91, 0x15, 0x20, 0x1B, 0x14, 0x48, 0x11, 0xEF]};
@GUID(0xF7FB4B9B, 0x6D96, 0x4D7B, [0x91, 0x15, 0x20, 0x1B, 0x14, 0x48, 0x11, 0xEF]);
interface IFsiDirectoryItem2 : IFsiDirectoryItem
{
    HRESULT AddTreeWithNamedStreams(BSTR sourceDirectory, short includeBaseDirectory);
}

const GUID IID_IFileSystemImage = {0x2C941FE1, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FE1, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
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

const GUID IID_IFileSystemImage2 = {0xD7644B2C, 0x1537, 0x4767, [0xB6, 0x2F, 0xF1, 0x38, 0x7B, 0x02, 0xDD, 0xFD]};
@GUID(0xD7644B2C, 0x1537, 0x4767, [0xB6, 0x2F, 0xF1, 0x38, 0x7B, 0x02, 0xDD, 0xFD]);
interface IFileSystemImage2 : IFileSystemImage
{
    HRESULT get_BootImageOptionsArray(SAFEARRAY** pVal);
    HRESULT put_BootImageOptionsArray(SAFEARRAY* newVal);
}

const GUID IID_IFileSystemImage3 = {0x7CFF842C, 0x7E97, 0x4807, [0x83, 0x04, 0x91, 0x0D, 0xD8, 0xF7, 0xC0, 0x51]};
@GUID(0x7CFF842C, 0x7E97, 0x4807, [0x83, 0x04, 0x91, 0x0D, 0xD8, 0xF7, 0xC0, 0x51]);
interface IFileSystemImage3 : IFileSystemImage2
{
    HRESULT get_CreateRedundantUdfMetadataFiles(short* pVal);
    HRESULT put_CreateRedundantUdfMetadataFiles(short newVal);
    HRESULT ProbeSpecificFileSystem(FsiFileSystems fileSystemToProbe, short* isAppendable);
}

const GUID IID_DFileSystemImageEvents = {0x2C941FDF, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]};
@GUID(0x2C941FDF, 0x975B, 0x59BE, [0xA9, 0x60, 0x9A, 0x2A, 0x26, 0x28, 0x53, 0xA5]);
interface DFileSystemImageEvents : IDispatch
{
    HRESULT Update(IDispatch object, BSTR currentFile, int copiedSectors, int totalSectors);
}

const GUID IID_DFileSystemImageImportEvents = {0xD25C30F9, 0x4087, 0x4366, [0x9E, 0x24, 0xE5, 0x5B, 0xE2, 0x86, 0x42, 0x4B]};
@GUID(0xD25C30F9, 0x4087, 0x4366, [0x9E, 0x24, 0xE5, 0x5B, 0xE2, 0x86, 0x42, 0x4B]);
interface DFileSystemImageImportEvents : IDispatch
{
    HRESULT UpdateImport(IDispatch object, FsiFileSystems fileSystem, BSTR currentItem, int importedDirectoryItems, int totalDirectoryItems, int importedFileItems, int totalFileItems);
}

const GUID IID_IIsoImageManager = {0x6CA38BE5, 0xFBBB, 0x4800, [0x95, 0xA1, 0xA4, 0x38, 0x86, 0x5E, 0xB0, 0xD4]};
@GUID(0x6CA38BE5, 0xFBBB, 0x4800, [0x95, 0xA1, 0xA4, 0x38, 0x86, 0x5E, 0xB0, 0xD4]);
interface IIsoImageManager : IDispatch
{
    HRESULT get_Path(BSTR* pVal);
    HRESULT get_Stream(IStream* data);
    HRESULT SetPath(BSTR Val);
    HRESULT SetStream(IStream data);
    HRESULT Validate();
}

const GUID CLSID_MSDiscRecorderObj = {0x520CCA61, 0x51A5, 0x11D3, [0x91, 0x44, 0x00, 0x10, 0x4B, 0xA1, 0x1C, 0x5E]};
@GUID(0x520CCA61, 0x51A5, 0x11D3, [0x91, 0x44, 0x00, 0x10, 0x4B, 0xA1, 0x1C, 0x5E]);
struct MSDiscRecorderObj;

const GUID CLSID_MSDiscMasterObj = {0x520CCA63, 0x51A5, 0x11D3, [0x91, 0x44, 0x00, 0x10, 0x4B, 0xA1, 0x1C, 0x5E]};
@GUID(0x520CCA63, 0x51A5, 0x11D3, [0x91, 0x44, 0x00, 0x10, 0x4B, 0xA1, 0x1C, 0x5E]);
struct MSDiscMasterObj;

const GUID CLSID_MSEnumDiscRecordersObj = {0x8A03567A, 0x63CB, 0x4BA8, [0xBA, 0xF6, 0x52, 0x11, 0x98, 0x16, 0xD1, 0xEF]};
@GUID(0x8A03567A, 0x63CB, 0x4BA8, [0xBA, 0xF6, 0x52, 0x11, 0x98, 0x16, 0xD1, 0xEF]);
struct MSEnumDiscRecordersObj;

enum MEDIA_TYPES
{
    MEDIA_CDDA_CDROM = 1,
    MEDIA_CD_ROM_XA = 2,
    MEDIA_CD_I = 3,
    MEDIA_CD_EXTRA = 4,
    MEDIA_CD_OTHER = 5,
    MEDIA_SPECIAL = 6,
}

enum MEDIA_FLAGS
{
    MEDIA_BLANK = 1,
    MEDIA_RW = 2,
    MEDIA_WRITABLE = 4,
    MEDIA_FORMAT_UNUSABLE_BY_IMAPI = 8,
}

enum RECORDER_TYPES
{
    RECORDER_CDR = 1,
    RECORDER_CDRW = 2,
}

const GUID IID_IDiscRecorder = {0x85AC9776, 0xCA88, 0x4CF2, [0x89, 0x4E, 0x09, 0x59, 0x8C, 0x07, 0x8A, 0x41]};
@GUID(0x85AC9776, 0xCA88, 0x4CF2, [0x89, 0x4E, 0x09, 0x59, 0x8C, 0x07, 0x8A, 0x41]);
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
    HRESULT QueryMediaInfo(ubyte* pbSessions, ubyte* pbLastTrack, uint* ulStartAddress, uint* ulNextWritable, uint* ulFreeBlocks);
    HRESULT Eject();
    HRESULT Erase(ubyte bFullErase);
    HRESULT Close();
}

const GUID IID_IEnumDiscRecorders = {0x9B1921E1, 0x54AC, 0x11D3, [0x91, 0x44, 0x00, 0x10, 0x4B, 0xA1, 0x1C, 0x5E]};
@GUID(0x9B1921E1, 0x54AC, 0x11D3, [0x91, 0x44, 0x00, 0x10, 0x4B, 0xA1, 0x1C, 0x5E]);
interface IEnumDiscRecorders : IUnknown
{
    HRESULT Next(uint cRecorders, char* ppRecorder, uint* pcFetched);
    HRESULT Skip(uint cRecorders);
    HRESULT Reset();
    HRESULT Clone(IEnumDiscRecorders* ppEnum);
}

const GUID IID_IEnumDiscMasterFormats = {0xDDF445E1, 0x54BA, 0x11D3, [0x91, 0x44, 0x00, 0x10, 0x4B, 0xA1, 0x1C, 0x5E]};
@GUID(0xDDF445E1, 0x54BA, 0x11D3, [0x91, 0x44, 0x00, 0x10, 0x4B, 0xA1, 0x1C, 0x5E]);
interface IEnumDiscMasterFormats : IUnknown
{
    HRESULT Next(uint cFormats, char* lpiidFormatID, uint* pcFetched);
    HRESULT Skip(uint cFormats);
    HRESULT Reset();
    HRESULT Clone(IEnumDiscMasterFormats* ppEnum);
}

const GUID IID_IRedbookDiscMaster = {0xE3BC42CD, 0x4E5C, 0x11D3, [0x91, 0x44, 0x00, 0x10, 0x4B, 0xA1, 0x1C, 0x5E]};
@GUID(0xE3BC42CD, 0x4E5C, 0x11D3, [0x91, 0x44, 0x00, 0x10, 0x4B, 0xA1, 0x1C, 0x5E]);
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

const GUID IID_IJolietDiscMaster = {0xE3BC42CE, 0x4E5C, 0x11D3, [0x91, 0x44, 0x00, 0x10, 0x4B, 0xA1, 0x1C, 0x5E]};
@GUID(0xE3BC42CE, 0x4E5C, 0x11D3, [0x91, 0x44, 0x00, 0x10, 0x4B, 0xA1, 0x1C, 0x5E]);
interface IJolietDiscMaster : IUnknown
{
    HRESULT GetTotalDataBlocks(int* pnBlocks);
    HRESULT GetUsedDataBlocks(int* pnBlocks);
    HRESULT GetDataBlockSize(int* pnBlockBytes);
    HRESULT AddData(IStorage pStorage, int lFileOverwrite);
    HRESULT GetJolietProperties(IPropertyStorage* ppPropStg);
    HRESULT SetJolietProperties(IPropertyStorage pPropStg);
}

const GUID IID_IDiscMasterProgressEvents = {0xEC9E51C1, 0x4E5D, 0x11D3, [0x91, 0x44, 0x00, 0x10, 0x4B, 0xA1, 0x1C, 0x5E]};
@GUID(0xEC9E51C1, 0x4E5D, 0x11D3, [0x91, 0x44, 0x00, 0x10, 0x4B, 0xA1, 0x1C, 0x5E]);
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

const GUID IID_IDiscMaster = {0x520CCA62, 0x51A5, 0x11D3, [0x91, 0x44, 0x00, 0x10, 0x4B, 0xA1, 0x1C, 0x5E]};
@GUID(0x520CCA62, 0x51A5, 0x11D3, [0x91, 0x44, 0x00, 0x10, 0x4B, 0xA1, 0x1C, 0x5E]);
interface IDiscMaster : IUnknown
{
    HRESULT Open();
    HRESULT EnumDiscMasterFormats(IEnumDiscMasterFormats* ppEnum);
    HRESULT GetActiveDiscMasterFormat(Guid* lpiid);
    HRESULT SetActiveDiscMasterFormat(const(Guid)* riid, void** ppUnk);
    HRESULT EnumDiscRecorders(IEnumDiscRecorders* ppEnum);
    HRESULT GetActiveDiscRecorder(IDiscRecorder* ppRecorder);
    HRESULT SetActiveDiscRecorder(IDiscRecorder pRecorder);
    HRESULT ClearFormatContent();
    HRESULT ProgressAdvise(IDiscMasterProgressEvents pEvents, uint* pvCookie);
    HRESULT ProgressUnadvise(uint vCookie);
    HRESULT RecordDisc(ubyte bSimulate, ubyte bEjectAfterBurn);
    HRESULT Close();
}

