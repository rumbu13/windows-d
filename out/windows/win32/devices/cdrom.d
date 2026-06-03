// Written in the D programming language.

module windows.win32.devices.cdrom;

public import windows.core;
public import windows.win32.foundation : BOOLEAN;

extern(Windows) @nogc nothrow:


// Enums


alias TRACK_MODE_TYPE = int;
enum : int
{
    YellowMode2         = 0x00000000,
    XAForm2             = 0x00000001,
    CDDA                = 0x00000002,
    RawWithC2AndSubCode = 0x00000003,
    RawWithC2           = 0x00000004,
    RawWithSubCode      = 0x00000005,
}

alias MEDIA_BLANK_TYPE = int;
enum : int
{
    MediaBlankTypeFull               = 0x00000000,
    MediaBlankTypeMinimal            = 0x00000001,
    MediaBlankTypeIncompleteTrack    = 0x00000002,
    MediaBlankTypeUnreserveLastTrack = 0x00000003,
    MediaBlankTypeTrackTail          = 0x00000004,
    MediaBlankTypeUncloseLastSession = 0x00000005,
    MediaBlankTypeEraseLastSession   = 0x00000006,
}

alias EXCLUSIVE_ACCESS_REQUEST_TYPE = int;
enum : int
{
    ExclusiveAccessQueryState   = 0x00000000,
    ExclusiveAccessLockDevice   = 0x00000001,
    ExclusiveAccessUnlockDevice = 0x00000002,
}

alias CDROM_SPEED_REQUEST = int;
enum : int
{
    CdromSetSpeed     = 0x00000000,
    CdromSetStreaming = 0x00000001,
}

alias WRITE_ROTATION = int;
enum : int
{
    CdromDefaultRotation = 0x00000000,
    CdromCAVRotation     = 0x00000001,
}

alias STREAMING_CONTROL_REQUEST_TYPE = int;
enum : int
{
    CdromStreamingDisable            = 0x00000001,
    CdromStreamingEnableForReadOnly  = 0x00000002,
    CdromStreamingEnableForWriteOnly = 0x00000003,
    CdromStreamingEnableForReadWrite = 0x00000004,
}

alias CDROM_OPC_INFO_TYPE = int;
enum : int
{
    SimpleOpcInfo = 0x00000001,
}

alias CDROM_PERFORMANCE_REQUEST_TYPE = int;
enum : int
{
    CdromPerformanceRequest = 0x00000001,
    CdromWriteSpeedRequest  = 0x00000002,
}

alias CDROM_PERFORMANCE_TYPE = int;
enum : int
{
    CdromReadPerformance  = 0x00000001,
    CdromWritePerformance = 0x00000002,
}

alias CDROM_PERFORMANCE_EXCEPTION_TYPE = int;
enum : int
{
    CdromNominalPerformance        = 0x00000001,
    CdromEntirePerformanceList     = 0x00000002,
    CdromPerformanceExceptionsOnly = 0x00000003,
}

alias CDROM_PERFORMANCE_TOLERANCE_TYPE = int;
enum : int
{
    Cdrom10Nominal20Exceptions = 0x00000001,
}

// Constants


enum int IOCTL_CDROM_BASE = 0x00000002;

enum : uint
{
    IOCTL_CDROM_UNLOAD_DRIVER  = 0x00025008U,
    IOCTL_CDROM_READ_TOC       = 0x00024000U,
    IOCTL_CDROM_SEEK_AUDIO_MSF = 0x00024004U,
    IOCTL_CDROM_STOP_AUDIO     = 0x00024008U,
    IOCTL_CDROM_PAUSE_AUDIO    = 0x0002400cU,
    IOCTL_CDROM_RESUME_AUDIO   = 0x00024010U,
    IOCTL_CDROM_GET_VOLUME     = 0x00024014U,
    IOCTL_CDROM_PLAY_AUDIO_MSF = 0x00024018U,
    IOCTL_CDROM_SET_VOLUME     = 0x00024028U,
    IOCTL_CDROM_READ_Q_CHANNEL = 0x0002402cU,
    IOCTL_CDROM_GET_CONTROL    = 0x00024034U,
}

enum uint OBSOLETE_IOCTL_CDROM_GET_CONTROL = 0x00024034U;

enum : uint
{
    IOCTL_CDROM_GET_LAST_SESSION      = 0x00024038U,
    IOCTL_CDROM_RAW_READ              = 0x0002403eU,
    IOCTL_CDROM_DISK_TYPE             = 0x00020040U,
    IOCTL_CDROM_GET_DRIVE_GEOMETRY    = 0x0002404cU,
    IOCTL_CDROM_GET_DRIVE_GEOMETRY_EX = 0x00024050U,
}

enum : uint
{
    IOCTL_CDROM_READ_TOC_EX          = 0x00024054U,
    IOCTL_CDROM_GET_CONFIGURATION    = 0x00024058U,
    IOCTL_CDROM_EXCLUSIVE_ACCESS     = 0x0002c05cU,
    IOCTL_CDROM_SET_SPEED            = 0x00024060U,
    IOCTL_CDROM_GET_INQUIRY_DATA     = 0x00024064U,
    IOCTL_CDROM_ENABLE_STREAMING     = 0x00024068U,
    IOCTL_CDROM_SEND_OPC_INFORMATION = 0x0002c06cU,
}

enum : uint
{
    IOCTL_CDROM_GET_PERFORMANCE  = 0x00024070U,
    IOCTL_CDROM_CHECK_VERIFY     = 0x00024800U,
    IOCTL_CDROM_MEDIA_REMOVAL    = 0x00024804U,
    IOCTL_CDROM_EJECT_MEDIA      = 0x00024808U,
    IOCTL_CDROM_LOAD_MEDIA       = 0x0002480cU,
    IOCTL_CDROM_RESERVE          = 0x00024810U,
    IOCTL_CDROM_RELEASE          = 0x00024814U,
    IOCTL_CDROM_FIND_NEW_DEVICES = 0x00024818U,
}

enum uint MINIMUM_CDROM_INQUIRY_SIZE = 0x00000024U;
enum uint MAXIMUM_CDROM_INQUIRY_SIZE = 0x00000104U;
enum uint IOCTL_CDROM_SIMBAD = 0x0002400cU;
enum uint MAXIMUM_NUMBER_TRACKS = 0x00000064U;
enum uint MAXIMUM_CDROM_SIZE = 0x00000324U;
enum uint MINIMUM_CDROM_READ_TOC_EX_SIZE = 0x00000002U;

enum : uint
{
    CDROM_READ_TOC_EX_FORMAT_TOC      = 0x00000000U,
    CDROM_READ_TOC_EX_FORMAT_SESSION  = 0x00000001U,
    CDROM_READ_TOC_EX_FORMAT_FULL_TOC = 0x00000002U,
    CDROM_READ_TOC_EX_FORMAT_PMA      = 0x00000003U,
    CDROM_READ_TOC_EX_FORMAT_ATIP     = 0x00000004U,
    CDROM_READ_TOC_EX_FORMAT_CDTEXT   = 0x00000005U,
}

enum : uint
{
    CDROM_CD_TEXT_PACK_ALBUM_NAME = 0x00000080U,
    CDROM_CD_TEXT_PACK_PERFORMER  = 0x00000081U,
    CDROM_CD_TEXT_PACK_SONGWRITER = 0x00000082U,
    CDROM_CD_TEXT_PACK_COMPOSER   = 0x00000083U,
    CDROM_CD_TEXT_PACK_ARRANGER   = 0x00000084U,
    CDROM_CD_TEXT_PACK_MESSAGES   = 0x00000085U,
    CDROM_CD_TEXT_PACK_DISC_ID    = 0x00000086U,
    CDROM_CD_TEXT_PACK_GENRE      = 0x00000087U,
    CDROM_CD_TEXT_PACK_TOC_INFO   = 0x00000088U,
    CDROM_CD_TEXT_PACK_TOC_INFO2  = 0x00000089U,
    CDROM_CD_TEXT_PACK_UPC_EAN    = 0x0000008eU,
    CDROM_CD_TEXT_PACK_SIZE_INFO  = 0x0000008fU,
}

enum : uint
{
    CDROM_DISK_AUDIO_TRACK = 0x00000001U,
    CDROM_DISK_DATA_TRACK  = 0x00000002U,
}

enum : uint
{
    IOCTL_CDROM_SUB_Q_CHANNEL    = 0x00000000U,
    IOCTL_CDROM_CURRENT_POSITION = 0x00000001U,
    IOCTL_CDROM_MEDIA_CATALOG    = 0x00000002U,
    IOCTL_CDROM_TRACK_ISRC       = 0x00000003U,
}

enum : uint
{
    AUDIO_STATUS_NOT_SUPPORTED = 0x00000000U,
    AUDIO_STATUS_IN_PROGRESS   = 0x00000011U,
    AUDIO_STATUS_PAUSED        = 0x00000012U,
    AUDIO_STATUS_PLAY_COMPLETE = 0x00000013U,
    AUDIO_STATUS_PLAY_ERROR    = 0x00000014U,
    AUDIO_STATUS_NO_STATUS     = 0x00000015U,
}

enum uint ADR_NO_MODE_INFORMATION = 0x00000000U;

enum : uint
{
    ADR_ENCODES_CURRENT_POSITION = 0x00000001U,
    ADR_ENCODES_MEDIA_CATALOG    = 0x00000002U,
    ADR_ENCODES_ISRC             = 0x00000003U,
}

enum uint AUDIO_WITH_PREEMPHASIS = 0x00000001U;
enum uint DIGITAL_COPY_PERMITTED = 0x00000002U;
enum uint AUDIO_DATA_TRACK = 0x00000004U;
enum uint TWO_FOUR_CHANNEL_AUDIO = 0x00000008U;

enum : uint
{
    CD_RAW_READ_C2_SIZE      = 0x00000128U,
    CD_RAW_READ_SUBCODE_SIZE = 0x00000060U,
}

enum : uint
{
    CD_RAW_SECTOR_WITH_C2_SIZE      = 0x00000a58U,
    CD_RAW_SECTOR_WITH_SUBCODE_SIZE = 0x00000990U,
}

enum uint CDROM_EXCLUSIVE_CALLER_LENGTH = 0x00000040U;
enum uint CDROM_LOCK_IGNORE_VOLUME = 0x00000001U;
enum uint CDROM_NO_MEDIA_NOTIFICATIONS = 0x00000002U;
enum uint CDROM_NOT_IN_EXCLUSIVE_MODE = 0x00000000U;
enum uint CDROM_IN_EXCLUSIVE_MODE = 0x00000001U;

// Structs


struct CDROM_READ_TOC_EX
{
    // Native bit field: Format: [0-3], Reserved1: [4-6], Msf: [7]
    ubyte _bitfield0;
    ubyte SessionTrack;
    ubyte Reserved2;
    ubyte Reserved3;
}

struct TRACK_DATA
{
    ubyte    Reserved;
    // Native bit field: Control: [0-3], Adr: [4-7]
    ubyte    _bitfield0;
    ubyte    TrackNumber;
    ubyte    Reserved1;
    ubyte[4] Address;
}

struct CDROM_TOC
{
    ubyte[2]        Length;
    ubyte           FirstTrack;
    ubyte           LastTrack;
    TRACK_DATA[100] TrackData;
}

struct CDROM_TOC_SESSION_DATA
{
    ubyte[2]      Length;
    ubyte         FirstCompleteSession;
    ubyte         LastCompleteSession;
    TRACK_DATA[1] TrackData; // Flexible array
}

struct CDROM_TOC_FULL_TOC_DATA_BLOCK
{
    ubyte    SessionNumber;
    // Native bit field: Control: [0-3], Adr: [4-7]
    ubyte    _bitfield0;
    ubyte    Reserved1;
    ubyte    Point;
    ubyte[3] MsfExtra;
    ubyte    Zero;
    ubyte[3] Msf;
}

struct CDROM_TOC_FULL_TOC_DATA
{
    ubyte[2] Length;
    ubyte    FirstCompleteSession;
    ubyte    LastCompleteSession;
    CDROM_TOC_FULL_TOC_DATA_BLOCK[1] Descriptors; // Flexible array
}

struct CDROM_TOC_PMA_DATA
{
    ubyte[2] Length;
    ubyte    Reserved1;
    ubyte    Reserved2;
    CDROM_TOC_FULL_TOC_DATA_BLOCK[1] Descriptors; // Flexible array
}

struct CDROM_TOC_ATIP_DATA_BLOCK
{
    // Native bit field: CdrwReferenceSpeed: [0-2], Reserved3: [3], WritePower: [4-6], True1: [7]
    ubyte    _bitfield1;
    // Native bit field: Reserved4: [0-5], UnrestrictedUse: [6], Reserved5: [7]
    ubyte    _bitfield2;
    // Native bit field: A3Valid: [0], A2Valid: [1], A1Valid: [2], DiscSubType: [3-5], IsCdrw: [6], True2: [7]
    ubyte    _bitfield3;
    ubyte    Reserved7;
    ubyte[3] LeadInMsf;
    ubyte    Reserved8;
    ubyte[3] LeadOutMsf;
    ubyte    Reserved9;
    ubyte[3] A1Values;
    ubyte    Reserved10;
    ubyte[3] A2Values;
    ubyte    Reserved11;
    ubyte[3] A3Values;
    ubyte    Reserved12;
}

struct CDROM_TOC_ATIP_DATA
{
    ubyte[2] Length;
    ubyte    Reserved1;
    ubyte    Reserved2;
    CDROM_TOC_ATIP_DATA_BLOCK[1] Descriptors; // Flexible array
}

struct CDROM_TOC_CD_TEXT_DATA_BLOCK
{
    ubyte    PackType;
    // Native bit field: TrackNumber: [0-6], ExtensionFlag: [7]
    ubyte    _bitfield1;
    ubyte    SequenceNumber;
    // Native bit field: CharacterPosition: [0-3], BlockNumber: [4-6], Unicode: [7]
    ubyte    _bitfield2;
    union
    {
        ubyte[12] Text;
        wchar[6]  WText;
    }
    ubyte[2] CRC;
}

struct CDROM_TOC_CD_TEXT_DATA
{
    ubyte[2] Length;
    ubyte    Reserved1;
    ubyte    Reserved2;
    CDROM_TOC_CD_TEXT_DATA_BLOCK[1] Descriptors; // Flexible array
}

struct CDROM_PLAY_AUDIO_MSF
{
    ubyte StartingM;
    ubyte StartingS;
    ubyte StartingF;
    ubyte EndingM;
    ubyte EndingS;
    ubyte EndingF;
}

struct CDROM_SEEK_AUDIO_MSF
{
    ubyte M;
    ubyte S;
    ubyte F;
}

struct CDROM_DISK_DATA
{
    uint DiskData;
}

struct CDROM_SUB_Q_DATA_FORMAT
{
    ubyte Format;
    ubyte Track;
}

struct SUB_Q_HEADER
{
    ubyte    Reserved;
    ubyte    AudioStatus;
    ubyte[2] DataLength;
}

struct SUB_Q_CURRENT_POSITION
{
    SUB_Q_HEADER Header;
    ubyte        FormatCode;
    // Native bit field: Control: [0-3], ADR: [4-7]
    ubyte        _bitfield0;
    ubyte        TrackNumber;
    ubyte        IndexNumber;
    ubyte[4]     AbsoluteAddress;
    ubyte[4]     TrackRelativeAddress;
}

struct SUB_Q_MEDIA_CATALOG_NUMBER
{
    SUB_Q_HEADER Header;
    ubyte        FormatCode;
    ubyte[3]     Reserved;
    // Native bit field: Reserved1: [0-6], Mcval: [7]
    ubyte        _bitfield0;
    ubyte[15]    MediaCatalog;
}

struct SUB_Q_TRACK_ISRC
{
    SUB_Q_HEADER Header;
    ubyte        FormatCode;
    ubyte        Reserved0;
    ubyte        Track;
    ubyte        Reserved1;
    // Native bit field: Reserved2: [0-6], Tcval: [7]
    ubyte        _bitfield0;
    ubyte[15]    TrackIsrc;
}

union SUB_Q_CHANNEL_DATA
{
    SUB_Q_CURRENT_POSITION CurrentPosition;
    SUB_Q_MEDIA_CATALOG_NUMBER MediaCatalog;
    SUB_Q_TRACK_ISRC TrackIsrc;
}

struct VOLUME_CONTROL
{
    ubyte[4] PortVolume;
}

struct RAW_READ_INFO
{
    long            DiskOffset;
    uint            SectorCount;
    TRACK_MODE_TYPE TrackMode;
}

struct CDROM_EXCLUSIVE_ACCESS
{
    EXCLUSIVE_ACCESS_REQUEST_TYPE RequestType;
    uint Flags;
}

struct CDROM_EXCLUSIVE_LOCK
{
    CDROM_EXCLUSIVE_ACCESS Access;
    ubyte[64] CallerName;
}

struct CDROM_EXCLUSIVE_LOCK_STATE
{
    BOOLEAN   LockState;
    ubyte[64] CallerName;
}

struct CDROM_SET_SPEED
{
    CDROM_SPEED_REQUEST RequestType;
    ushort              ReadSpeed;
    ushort              WriteSpeed;
    WRITE_ROTATION      RotationControl;
}

struct CDROM_SET_STREAMING
{
    CDROM_SPEED_REQUEST RequestType;
    uint                ReadSize;
    uint                ReadTime;
    uint                WriteSize;
    uint                WriteTime;
    uint                StartLba;
    uint                EndLba;
    WRITE_ROTATION      RotationControl;
    BOOLEAN             RestoreDefaults;
    BOOLEAN             SetExact;
    BOOLEAN             RandomAccess;
    BOOLEAN             Persistent;
}

struct CDROM_STREAMING_CONTROL
{
    STREAMING_CONTROL_REQUEST_TYPE RequestType;
}

struct CDROM_SIMPLE_OPC_INFO
{
    CDROM_OPC_INFO_TYPE RequestType;
    BOOLEAN             Exclude0;
    BOOLEAN             Exclude1;
}

struct CDROM_PERFORMANCE_REQUEST
{
    CDROM_PERFORMANCE_REQUEST_TYPE RequestType;
    CDROM_PERFORMANCE_TYPE PerformanceType;
    CDROM_PERFORMANCE_EXCEPTION_TYPE Exceptions;
    CDROM_PERFORMANCE_TOLERANCE_TYPE Tolerance;
    uint StaringLba;
}

struct CDROM_WRITE_SPEED_REQUEST
{
    CDROM_PERFORMANCE_REQUEST_TYPE RequestType;
}

struct CDROM_PERFORMANCE_HEADER
{
    ubyte[4] DataLength;
    // Native bit field: Except: [0], Write: [1], Reserved1: [2-7]
    ubyte    _bitfield0;
    ubyte[3] Reserved2;
    ubyte[1] Data; // Flexible array
}

struct CDROM_NOMINAL_PERFORMANCE_DESCRIPTOR
{
    ubyte[4] StartLba;
    ubyte[4] StartPerformance;
    ubyte[4] EndLba;
    ubyte[4] EndPerformance;
}

struct CDROM_EXCEPTION_PERFORMANCE_DESCRIPTOR
{
    ubyte[4] Lba;
    ubyte[2] Time;
}

struct CDROM_WRITE_SPEED_DESCRIPTOR
{
    // Native bit field: MixedReadWrite: [0], Exact: [1], Reserved1: [2], WriteRotationControl: [3-4], Reserved2: [5-7]
    ubyte    _bitfield0;
    ubyte[3] Reserved3;
    ubyte[4] EndLba;
    ubyte[4] ReadSpeed;
    ubyte[4] WriteSpeed;
}

