// Written in the D programming language.

module windows.imapi;

public import windows.core;
public import windows.automation : BSTR, IDispatch, IEnumVARIANT, SAFEARRAY;
public import windows.com : HRESULT, IUnknown;
public import windows.structuredstorage : IPropertyStorage, IStorage, IStream;

extern(Windows) @nogc nothrow:


// Enums


///Defines values for the currently known media types supported by IMAPI.
alias IMAPI_MEDIA_PHYSICAL_TYPE = int;
enum : int
{
    ///The disc recorder contains an unknown media type or the recorder is empty.
    IMAPI_MEDIA_TYPE_UNKNOWN             = 0x00000000,
    ///The drive contains CD-ROM or CD-R/RW media.
    IMAPI_MEDIA_TYPE_CDROM               = 0x00000001,
    ///The drive contains write once (CD-R) media.
    IMAPI_MEDIA_TYPE_CDR                 = 0x00000002,
    ///The drive contains rewritable (CD-RW) media.
    IMAPI_MEDIA_TYPE_CDRW                = 0x00000003,
    ///Either the DVD drive or DVD media is read-only.
    IMAPI_MEDIA_TYPE_DVDROM              = 0x00000004,
    ///The drive contains DVD-RAM media.
    IMAPI_MEDIA_TYPE_DVDRAM              = 0x00000005,
    ///The drive contains write once media that supports the DVD plus format (DVD+R) .
    IMAPI_MEDIA_TYPE_DVDPLUSR            = 0x00000006,
    ///The drive contains rewritable media that supports the DVD plus format (DVD+RW).
    IMAPI_MEDIA_TYPE_DVDPLUSRW           = 0x00000007,
    ///The drive contains write once dual layer media that supports the DVD plus format (DVD+R DL).
    IMAPI_MEDIA_TYPE_DVDPLUSR_DUALLAYER  = 0x00000008,
    ///The drive contains write once media that supports the DVD dash format (DVD-R).
    IMAPI_MEDIA_TYPE_DVDDASHR            = 0x00000009,
    ///The drive contains rewritable media that supports the DVD dash format (DVD-RW).
    IMAPI_MEDIA_TYPE_DVDDASHRW           = 0x0000000a,
    ///The drive contains write once dual layer media that supports the DVD dash format (DVD-R DL).
    IMAPI_MEDIA_TYPE_DVDDASHR_DUALLAYER  = 0x0000000b,
    ///The drive contains a media type that supports random-access writes. This media type supports hardware defect
    ///management that identifies and avoids using damaged tracks.
    IMAPI_MEDIA_TYPE_DISK                = 0x0000000c,
    ///The drive contains rewritable dual layer media that supports the DVD plus format (DVD+RW DL).
    IMAPI_MEDIA_TYPE_DVDPLUSRW_DUALLAYER = 0x0000000d,
    ///The drive contains high definition read only DVD media (HD DVD-ROM).
    IMAPI_MEDIA_TYPE_HDDVDROM            = 0x0000000e,
    ///The drive contains write once high definition media (HD DVD-R).
    IMAPI_MEDIA_TYPE_HDDVDR              = 0x0000000f,
    ///The drive contains random access high definition media (HD DVD-RAM).
    IMAPI_MEDIA_TYPE_HDDVDRAM            = 0x00000010,
    ///The drive contains read only Blu-ray media (BD-ROM).
    IMAPI_MEDIA_TYPE_BDROM               = 0x00000011,
    ///The drive contains write once Blu-ray media (BD-R).
    IMAPI_MEDIA_TYPE_BDR                 = 0x00000012,
    ///The drive contains rewritable Blu-ray media (BD-RE) media.
    IMAPI_MEDIA_TYPE_BDRE                = 0x00000013,
    ///This value is the maximum value defined in IMAPI_MEDIA_PHYSICAL_TYPE.
    IMAPI_MEDIA_TYPE_MAX                 = 0x00000013,
}

///Defines values that indicate the media write protect status. One or more write protect values can be set on a given
///drive.
alias IMAPI_MEDIA_WRITE_PROTECT_STATE = int;
enum : int
{
    ///Power to the drive needs to be cycled before allowing writes to the media.
    IMAPI_WRITEPROTECTED_UNTIL_POWERDOWN           = 0x00000001,
    ///The media is in a cartridge with the write protect tab set.
    IMAPI_WRITEPROTECTED_BY_CARTRIDGE              = 0x00000002,
    ///The drive is disallowing writes for a media-specific reason. For example: <ul> <li>The media was originally in a
    ///cartridge and was set to disallow writes when the media is not in a cartridge.</li> <li>The media has used all
    ///available spare areas for defect management and is preventing writes to protect the existing data.</li> </ul>
    IMAPI_WRITEPROTECTED_BY_MEDIA_SPECIFIC_REASON  = 0x00000004,
    ///A write-protect flag on the media is set. Various media types, such as DVD-RAM and DVD-RW, support a special area
    ///on the media to indicate the disc's write protect status.
    IMAPI_WRITEPROTECTED_BY_SOFTWARE_WRITE_PROTECT = 0x00000008,
    ///A write-protect flag in the disc control block of a DVD+RW disc is set. DVD+RW media can persistently alter the
    ///write protect state of media by writing a device control block (DCB) to the media. This value has limited
    ///usefulness because some DVD+RW drives do not recognize or honor this setting.
    IMAPI_WRITEPROTECTED_BY_DISC_CONTROL_BLOCK     = 0x00000010,
    ///The drive does not recognize write capability of the media.
    IMAPI_WRITEPROTECTED_READ_ONLY_MEDIA           = 0x00004000,
}

///Defines values that indicate how to interpret track addresses for the current disc profile of a randomly-writable,
///hardware-defect-managed media type.
alias IMAPI_READ_TRACK_ADDRESS_TYPE = int;
enum : int
{
    ///Interpret the address field as an LBA (sector address). The returned data should reflect the information for the
    ///track which contains the specified LBA.
    IMAPI_READ_TRACK_ADDRESS_TYPE_LBA     = 0x00000000,
    ///Interpret the address field as a track number. The returned data should reflect the information for the specified
    ///track. This version of the command has the greatest compatibility with legacy devices.
    IMAPI_READ_TRACK_ADDRESS_TYPE_TRACK   = 0x00000001,
    IMAPI_READ_TRACK_ADDRESS_TYPE_SESSION = 0x00000002,
}

///Defines values that indicate requests sent to a device using the MODE_SENSE10 MMC command.
alias IMAPI_MODE_PAGE_REQUEST_TYPE = int;
enum : int
{
    ///Requests current settings of the mode page. This is the most common request type, and the most commonly supported
    ///type of this command.
    IMAPI_MODE_PAGE_REQUEST_TYPE_CURRENT_VALUES    = 0x00000000,
    ///Requests a mask that indicates settings that are write enabled. A write-enabled setting has a corresponding bit
    ///that is set to one in the mask. A read-only setting has a corresponding bit that is set to zero in the mask .
    IMAPI_MODE_PAGE_REQUEST_TYPE_CHANGEABLE_VALUES = 0x00000001,
    ///Requests the power-on settings of the drive.
    IMAPI_MODE_PAGE_REQUEST_TYPE_DEFAULT_VALUES    = 0x00000002,
    IMAPI_MODE_PAGE_REQUEST_TYPE_SAVED_VALUES      = 0x00000003,
}

///Defines values for the mode pages that are supported by CD and DVD devices.
alias IMAPI_MODE_PAGE_TYPE = int;
enum : int
{
    ///The mode page specifies the error recovery parameters the drive uses during any command that performs a data read
    ///or write operation from the media.
    IMAPI_MODE_PAGE_TYPE_READ_WRITE_ERROR_RECOVERY = 0x00000001,
    ///The mode page provides a method by which the host may control the special features of a MRW CD-RW Drive.
    IMAPI_MODE_PAGE_TYPE_MRW                       = 0x00000003,
    ///The mode page provides parameters that are often needed in the execution of commands that write to the media.
    IMAPI_MODE_PAGE_TYPE_WRITE_PARAMETERS          = 0x00000005,
    ///The mode page contains parameters to enable or disable caching during read or write operations.
    IMAPI_MODE_PAGE_TYPE_CACHING                   = 0x00000008,
    ///The mode page contains parameters for exception reporting mechanisms that result in specific sense code errors
    ///when failures are predicted. This mode page is related to the S.M.A.R.T. feature.
    IMAPI_MODE_PAGE_TYPE_INFORMATIONAL_EXCEPTIONS  = 0x0000001c,
    ///The mode page contains command time-out values that are suggested by the device.
    IMAPI_MODE_PAGE_TYPE_TIMEOUT_AND_PROTECT       = 0x0000001d,
    ///The mode page contains power management settings for the drive. The parameters define how long the logical unit
    ///delays before changing its internal power state.
    IMAPI_MODE_PAGE_TYPE_POWER_CONDITION           = 0x0000001a,
    ///The mode page contains legacy device capabilities. These are superseded by the feature pages returned through the
    ///GetConfiguration command.
    IMAPI_MODE_PAGE_TYPE_LEGACY_CAPABILITIES       = 0x0000002a,
}

///Defines values for the feature that are supported by the logical unit (CD and DVD device).
alias IMAPI_FEATURE_PAGE_TYPE = int;
enum : int
{
    ///Identifies profiles supported by the logical unit.
    IMAPI_FEATURE_PAGE_TYPE_PROFILE_LIST                   = 0x00000000,
    ///Identifies a logical unit that supports functionality common to all devices.
    IMAPI_FEATURE_PAGE_TYPE_CORE                           = 0x00000001,
    ///Identifies the ability of the logical unit to notify an initiator about operational changes and accept initiator
    ///requests to prevent operational changes.
    IMAPI_FEATURE_PAGE_TYPE_MORPHING                       = 0x00000002,
    ///Identifies a logical unit that has a medium that is removable.
    IMAPI_FEATURE_PAGE_TYPE_REMOVABLE_MEDIUM               = 0x00000003,
    ///Identifies reporting capability and changing capability for write protection status of the logical unit.
    IMAPI_FEATURE_PAGE_TYPE_WRITE_PROTECT                  = 0x00000004,
    ///Identifies a logical unit that is able to read data from logical blocks specified by Logical Block Addresses.
    IMAPI_FEATURE_PAGE_TYPE_RANDOMLY_READABLE              = 0x00000010,
    ///Identifies a logical unit that conforms to the OSTA Multi-Read specification 1.00, with the exception of CD Play
    ///capability (the CD Audio Feature is not required).
    IMAPI_FEATURE_PAGE_TYPE_CD_MULTIREAD                   = 0x0000001d,
    ///Identifies a logical unit that is able to read CD specific information from the media and is able to read user
    ///data from all types of CD blocks.
    IMAPI_FEATURE_PAGE_TYPE_CD_READ                        = 0x0000001e,
    ///Identifies a logical unit that is able to read DVD specific information from the media.
    IMAPI_FEATURE_PAGE_TYPE_DVD_READ                       = 0x0000001f,
    ///Identifies a logical unit that is able to write data to logical blocks specified by Logical Block Addresses.
    IMAPI_FEATURE_PAGE_TYPE_RANDOMLY_WRITABLE              = 0x00000020,
    ///Identifies a logical unit that is able to write data to a contiguous region, and is able to append data to a
    ///limited number of locations on the media.
    IMAPI_FEATURE_PAGE_TYPE_INCREMENTAL_STREAMING_WRITABLE = 0x00000021,
    ///Identifies a logical unit that supports erasable media and media that requires an erase pass before overwrite,
    ///such as some magneto-optical technologies.
    IMAPI_FEATURE_PAGE_TYPE_SECTOR_ERASABLE                = 0x00000022,
    ///Identifies a logical unit that can format media into logical blocks.
    IMAPI_FEATURE_PAGE_TYPE_FORMATTABLE                    = 0x00000023,
    ///Identifies a logical unit that has defect management available to provide a defect-free contiguous address space.
    IMAPI_FEATURE_PAGE_TYPE_HARDWARE_DEFECT_MANAGEMENT     = 0x00000024,
    ///Identifies a logical unit that has the ability to record to any previously unrecorded logical block.
    IMAPI_FEATURE_PAGE_TYPE_WRITE_ONCE                     = 0x00000025,
    ///Identifies a logical unit that has the ability to overwrite logical blocks only in fixed sets at a time.
    IMAPI_FEATURE_PAGE_TYPE_RESTRICTED_OVERWRITE           = 0x00000026,
    ///Identifies a logical unit that has the ability to write CD-RW media that is designed for CAV recording.
    IMAPI_FEATURE_PAGE_TYPE_CDRW_CAV_WRITE                 = 0x00000027,
    ///Indicates that the logical unit is capable of reading a disc with the MRW format.
    IMAPI_FEATURE_PAGE_TYPE_MRW                            = 0x00000028,
    ///Identifies a logical unit that has the ability to perform media certification and recovered error reporting for
    ///logical unit assisted software defect management.
    IMAPI_FEATURE_PAGE_TYPE_ENHANCED_DEFECT_REPORTING      = 0x00000029,
    ///Indicates that the logical unit is capable of reading a recorded DVD+RW disc.
    IMAPI_FEATURE_PAGE_TYPE_DVD_PLUS_RW                    = 0x0000002a,
    ///Indicates that the logical unit is capable of reading a recorded DVD+R disc.
    IMAPI_FEATURE_PAGE_TYPE_DVD_PLUS_R                     = 0x0000002b,
    ///Identifies a logical unit that has the ability to perform writing only on Blocking boundaries.
    IMAPI_FEATURE_PAGE_TYPE_RIGID_RESTRICTED_OVERWRITE     = 0x0000002c,
    ///Identifies a logical unit that is able to write data to a CD track.
    IMAPI_FEATURE_PAGE_TYPE_CD_TRACK_AT_ONCE               = 0x0000002d,
    ///Identifies a logical unit that is able to write a CD in Session at Once mode or Raw mode.
    IMAPI_FEATURE_PAGE_TYPE_CD_MASTERING                   = 0x0000002e,
    ///Identifies a logical unit that has the ability to write data to DVD-R/-RW in Disc at Once mode.
    IMAPI_FEATURE_PAGE_TYPE_DVD_DASH_WRITE                 = 0x0000002f,
    ///Identifies a logical unit that has the ability to read double density CD specific information from the media.
    ///<div class="alert"><b>Note</b> This value has been deprecated.</div> <div> </div>
    IMAPI_FEATURE_PAGE_TYPE_DOUBLE_DENSITY_CD_READ         = 0x00000030,
    ///Identifies a logical unit that has the ability to write to double density CD media. <div
    ///class="alert"><b>Note</b> This value has been deprecated.</div> <div> </div>
    IMAPI_FEATURE_PAGE_TYPE_DOUBLE_DENSITY_CD_R_WRITE      = 0x00000031,
    ///Identifies a logical unit that has the ability to write to double density CD-RW media. <div
    ///class="alert"><b>Note</b> This value has been deprecated.</div> <div> </div>
    IMAPI_FEATURE_PAGE_TYPE_DOUBLE_DENSITY_CD_RW_WRITE     = 0x00000032,
    ///Identifies a drive that is able to write data to contiguous regions that are allocated on multiple layers, and is
    ///able to append data to a limited number of locations on the media.
    IMAPI_FEATURE_PAGE_TYPE_LAYER_JUMP_RECORDING           = 0x00000033,
    ///Identifies a logical unit that has the ability to perform writing CD-RW media.
    IMAPI_FEATURE_PAGE_TYPE_CD_RW_MEDIA_WRITE_SUPPORT      = 0x00000037,
    ///Identifies a drive that provides Logical Block overwrite service on BD-R discs that are formatted as SRM+POW.
    IMAPI_FEATURE_PAGE_TYPE_BD_PSEUDO_OVERWRITE            = 0x00000038,
    ///Indicates that the drive is capable of reading a recorded DVD+R Double Layer disc
    IMAPI_FEATURE_PAGE_TYPE_DVD_PLUS_R_DUAL_LAYER          = 0x0000003b,
    ///Identifies a logical unit that is able to read control structures and user data from the Blu-ray disc.
    IMAPI_FEATURE_PAGE_TYPE_BD_READ                        = 0x00000040,
    ///Identifies a drive that is able to write control structures and user data to writeable Blu-ray discs.
    IMAPI_FEATURE_PAGE_TYPE_BD_WRITE                       = 0x00000041,
    ///Identifies a drive that is able to read HD DVD specific information from the media.
    IMAPI_FEATURE_PAGE_TYPE_HD_DVD_READ                    = 0x00000050,
    ///Indicates the ability to write to HD DVD-R/-RW media.
    IMAPI_FEATURE_PAGE_TYPE_HD_DVD_WRITE                   = 0x00000051,
    ///Identifies a logical unit that is able to perform initiator and logical unit directed power management.
    IMAPI_FEATURE_PAGE_TYPE_POWER_MANAGEMENT               = 0x00000100,
    ///Identifies a logical unit that is able to perform Self-Monitoring Analysis and Reporting Technology (S.M.A.R.T.).
    IMAPI_FEATURE_PAGE_TYPE_SMART                          = 0x00000101,
    ///Identifies a logical unit that is able to move media from a storage area to a mechanism and back.
    IMAPI_FEATURE_PAGE_TYPE_EMBEDDED_CHANGER               = 0x00000102,
    ///Identifies a logical unit that is able to play CD Audio data directly to an external output.
    IMAPI_FEATURE_PAGE_TYPE_CD_ANALOG_PLAY                 = 0x00000103,
    ///Identifies a logical unit that is able to upgrade its internal microcode via the interface.
    IMAPI_FEATURE_PAGE_TYPE_MICROCODE_UPDATE               = 0x00000104,
    ///Identifies a logical unit that is able to always respond to commands within a set time period.
    IMAPI_FEATURE_PAGE_TYPE_TIMEOUT                        = 0x00000105,
    ///Identifies a logical unit that is able to perform DVD CSS/CPPM authentication and key management. This feature
    ///also indicates that the logical unit supports CSS for DVD-Video and CPPM for DVD-Audio.
    IMAPI_FEATURE_PAGE_TYPE_DVD_CSS                        = 0x00000106,
    ///Identifies a logical unit that is able to perform reading and writing within initiator specified (and logical
    ///unit verified) performance ranges. This Feature also indicates whether the logical unit supports the stream
    ///playback operation.
    IMAPI_FEATURE_PAGE_TYPE_REAL_TIME_STREAMING            = 0x00000107,
    ///Identifies a logical unit that has a unique serial number.
    IMAPI_FEATURE_PAGE_TYPE_LOGICAL_UNIT_SERIAL_NUMBER     = 0x00000108,
    ///Identifies a logical unit that is capable of reading a media serial number of the currently installed media.
    IMAPI_FEATURE_PAGE_TYPE_MEDIA_SERIAL_NUMBER            = 0x00000109,
    ///Identifies a logical unit that is able to read and/or write Disc Control Blocks from or to the media.
    IMAPI_FEATURE_PAGE_TYPE_DISC_CONTROL_BLOCKS            = 0x0000010a,
    ///Identifies a logical unit that is able to perform DVD CPRM and is able to perform CPRM authentication and key
    ///management.
    IMAPI_FEATURE_PAGE_TYPE_DVD_CPRM                       = 0x0000010b,
    ///Indicates that the logical unit provides the date and time of the creation of the current firmware revision
    ///loaded on the device.
    IMAPI_FEATURE_PAGE_TYPE_FIRMWARE_INFORMATION           = 0x0000010c,
    ///Identifies a drive that supports AACS and is able to perform AACS authentication process.
    IMAPI_FEATURE_PAGE_TYPE_AACS                           = 0x0000010d,
    ///Identifies a Drive that is able to process disc data structures that are specified in the VCPS.
    IMAPI_FEATURE_PAGE_TYPE_VCPS                           = 0x00000110,
}

///Defines values for the possible profiles of a CD and DVD device. A profile defines the type of media and features
///that the device supports.
alias IMAPI_PROFILE_TYPE = int;
enum : int
{
    ///The profile is not valid.
    IMAPI_PROFILE_TYPE_INVALID                    = 0x00000000,
    ///The hard disk it not removable.
    IMAPI_PROFILE_TYPE_NON_REMOVABLE_DISK         = 0x00000001,
    ///The hard disk is removable.
    IMAPI_PROFILE_TYPE_REMOVABLE_DISK             = 0x00000002,
    ///An Magneto-Optical Erasable drive.
    IMAPI_PROFILE_TYPE_MO_ERASABLE                = 0x00000003,
    ///A write once optical drive.
    IMAPI_PROFILE_TYPE_MO_WRITE_ONCE              = 0x00000004,
    ///An advance storage Magneto-Optical drive.
    IMAPI_PROFILE_TYPE_AS_MO                      = 0x00000005,
    ///A CD-ROM drive.
    IMAPI_PROFILE_TYPE_CDROM                      = 0x00000008,
    ///A CD-R drive.
    IMAPI_PROFILE_TYPE_CD_RECORDABLE              = 0x00000009,
    ///A CD-RW or CD+RW drive.
    IMAPI_PROFILE_TYPE_CD_REWRITABLE              = 0x0000000a,
    ///A DVD-ROM drive.
    IMAPI_PROFILE_TYPE_DVDROM                     = 0x00000010,
    ///A DVD-R sequential recording drive.
    IMAPI_PROFILE_TYPE_DVD_DASH_RECORDABLE        = 0x00000011,
    ///A DVD-RAM drive.
    IMAPI_PROFILE_TYPE_DVD_RAM                    = 0x00000012,
    ///A DVD-RW restricted overwrite drive.
    IMAPI_PROFILE_TYPE_DVD_DASH_REWRITABLE        = 0x00000013,
    ///A DVD-RW sequential recording drive.
    IMAPI_PROFILE_TYPE_DVD_DASH_RW_SEQUENTIAL     = 0x00000014,
    ///A DVD-R dual layer sequential recording drive.
    IMAPI_PROFILE_TYPE_DVD_DASH_R_DUAL_SEQUENTIAL = 0x00000015,
    ///A DVD-R dual layer jump recording drive.
    IMAPI_PROFILE_TYPE_DVD_DASH_R_DUAL_LAYER_JUMP = 0x00000016,
    ///A DVD+RW drive.
    IMAPI_PROFILE_TYPE_DVD_PLUS_RW                = 0x0000001a,
    ///A DVD+R drive.
    IMAPI_PROFILE_TYPE_DVD_PLUS_R                 = 0x0000001b,
    ///A double density CD drive. <div class="alert"><b>Note</b> This profile has been deprecated.</div> <div> </div>
    IMAPI_PROFILE_TYPE_DDCDROM                    = 0x00000020,
    ///A double density CD-R drive. <div class="alert"><b>Note</b> This profile has been deprecated.</div> <div> </div>
    IMAPI_PROFILE_TYPE_DDCD_RECORDABLE            = 0x00000021,
    ///A double density CD-RW drive. <div class="alert"><b>Note</b> This profile has been deprecated.</div> <div> </div>
    IMAPI_PROFILE_TYPE_DDCD_REWRITABLE            = 0x00000022,
    ///A DVD+RW dual layer drive.
    IMAPI_PROFILE_TYPE_DVD_PLUS_RW_DUAL           = 0x0000002a,
    ///A DVD+R dual layer drive.
    IMAPI_PROFILE_TYPE_DVD_PLUS_R_DUAL            = 0x0000002b,
    ///A Blu-ray read only drive.
    IMAPI_PROFILE_TYPE_BD_ROM                     = 0x00000040,
    ///A write once Blu-ray drive with sequential recording.
    IMAPI_PROFILE_TYPE_BD_R_SEQUENTIAL            = 0x00000041,
    ///A write once Blu-ray drive with random-access recording capability.
    IMAPI_PROFILE_TYPE_BD_R_RANDOM_RECORDING      = 0x00000042,
    ///A rewritable Blu-ray drive.
    IMAPI_PROFILE_TYPE_BD_REWRITABLE              = 0x00000043,
    ///A read only high density DVD drive.
    IMAPI_PROFILE_TYPE_HD_DVD_ROM                 = 0x00000050,
    ///A write once high density DVD drive.
    IMAPI_PROFILE_TYPE_HD_DVD_RECORDABLE          = 0x00000051,
    ///A high density DVD drive with random access positioning.
    IMAPI_PROFILE_TYPE_HD_DVD_RAM                 = 0x00000052,
    ///Nonstandard drive.
    IMAPI_PROFILE_TYPE_NON_STANDARD               = 0x0000ffff,
}

///Defines values that indicate the current state of the write operation when using the IDiscFormat2DataEventArgs
///interface.
alias IMAPI_FORMAT2_DATA_WRITE_ACTION = int;
enum : int
{
    ///Validating that the current media is supported.
    IMAPI_FORMAT2_DATA_WRITE_ACTION_VALIDATING_MEDIA      = 0x00000000,
    ///Formatting media, when required.
    IMAPI_FORMAT2_DATA_WRITE_ACTION_FORMATTING_MEDIA      = 0x00000001,
    ///Initializing the hardware, for example, setting drive write speeds.
    IMAPI_FORMAT2_DATA_WRITE_ACTION_INITIALIZING_HARDWARE = 0x00000002,
    ///Optimizing laser intensity for writing to the media.
    IMAPI_FORMAT2_DATA_WRITE_ACTION_CALIBRATING_POWER     = 0x00000003,
    ///Writing data to the media.
    IMAPI_FORMAT2_DATA_WRITE_ACTION_WRITING_DATA          = 0x00000004,
    ///Finalizing the write. This state is media dependent and can include items such as closing the track or session,
    ///or finishing background formatting.
    IMAPI_FORMAT2_DATA_WRITE_ACTION_FINALIZATION          = 0x00000005,
    ///Successfully finished the write process.
    IMAPI_FORMAT2_DATA_WRITE_ACTION_COMPLETED             = 0x00000006,
    ///Verifying the integrity of the burned media.
    IMAPI_FORMAT2_DATA_WRITE_ACTION_VERIFYING             = 0x00000007,
}

///Defines values for the possible media states.
alias IMAPI_FORMAT2_DATA_MEDIA_STATE = int;
enum : int
{
    ///Indicates that the interface does not know the media state.
    IMAPI_FORMAT2_DATA_MEDIA_STATE_UNKNOWN            = 0x00000000,
    ///Reports information (but not errors) about the media state.
    IMAPI_FORMAT2_DATA_MEDIA_STATE_INFORMATIONAL_MASK = 0x0000000f,
    ///Reports an unsupported media state.
    IMAPI_FORMAT2_DATA_MEDIA_STATE_UNSUPPORTED_MASK   = 0x0000fc00,
    ///Write operations can occur on used portions of the disc.
    IMAPI_FORMAT2_DATA_MEDIA_STATE_OVERWRITE_ONLY     = 0x00000001,
    ///Media is randomly writable. This indicates that a single session can be written to this disc. <div
    ///class="alert"><b>Note</b> This value is deprecated and superseded by
    ///<b>IMAPI_FORMAT2_DATA_MEDIA_STATE_OVERWRITE_ONLY</b>.</div> <div> </div>
    IMAPI_FORMAT2_DATA_MEDIA_STATE_RANDOMLY_WRITABLE  = 0x00000001,
    ///Media has never been used, or has been erased.
    IMAPI_FORMAT2_DATA_MEDIA_STATE_BLANK              = 0x00000002,
    ///Media is appendable (supports multiple sessions).
    IMAPI_FORMAT2_DATA_MEDIA_STATE_APPENDABLE         = 0x00000004,
    ///Media can have only one additional session added to it, or the media does not support multiple sessions.
    IMAPI_FORMAT2_DATA_MEDIA_STATE_FINAL_SESSION      = 0x00000008,
    ///Media is not usable by this interface. The media might require an erase or other recovery.
    IMAPI_FORMAT2_DATA_MEDIA_STATE_DAMAGED            = 0x00000400,
    ///Media must be erased prior to use by this interface.
    IMAPI_FORMAT2_DATA_MEDIA_STATE_ERASE_REQUIRED     = 0x00000800,
    ///Media has a partially written last session, which is not supported by this interface.
    IMAPI_FORMAT2_DATA_MEDIA_STATE_NON_EMPTY_SESSION  = 0x00001000,
    ///Media or drive is write-protected.
    IMAPI_FORMAT2_DATA_MEDIA_STATE_WRITE_PROTECTED    = 0x00002000,
    ///Media cannot be written to (finalized).
    IMAPI_FORMAT2_DATA_MEDIA_STATE_FINALIZED          = 0x00004000,
    ///Media is not supported by this interface.
    IMAPI_FORMAT2_DATA_MEDIA_STATE_UNSUPPORTED_MEDIA  = 0x00008000,
}

///Defines values that indicate the current state of the write operation when using the IDiscFormat2TrackAtOnceEventArgs
///interface.
alias IMAPI_FORMAT2_TAO_WRITE_ACTION = int;
enum : int
{
    ///Indicates an unknown state.
    IMAPI_FORMAT2_TAO_WRITE_ACTION_UNKNOWN   = 0x00000000,
    ///Preparing to write the track.
    IMAPI_FORMAT2_TAO_WRITE_ACTION_PREPARING = 0x00000001,
    ///Writing the track.
    IMAPI_FORMAT2_TAO_WRITE_ACTION_WRITING   = 0x00000002,
    ///Closing the track or closing the session.
    IMAPI_FORMAT2_TAO_WRITE_ACTION_FINISHING = 0x00000003,
    IMAPI_FORMAT2_TAO_WRITE_ACTION_VERIFYING = 0x00000004,
}

///Defines values that indicate the type of sub-channel data.
alias IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE = int;
enum : int
{
    ///The data contains P and Q sub-channel data.
    IMAPI_FORMAT2_RAW_CD_SUBCODE_PQ_ONLY   = 0x00000001,
    ///The data contains corrected and de-interleaved R-W sub-channel data.
    IMAPI_FORMAT2_RAW_CD_SUBCODE_IS_COOKED = 0x00000002,
    ///The data contains raw P-W sub-channel data that is returned in the order received from the disc surface.
    IMAPI_FORMAT2_RAW_CD_SUBCODE_IS_RAW    = 0x00000003,
}

///Defines values that indicate the current state of the write operation when using the IDiscFormat2RawCDEventArgs
///interface.
alias IMAPI_FORMAT2_RAW_CD_WRITE_ACTION = int;
enum : int
{
    ///Indicates an unknown state.
    IMAPI_FORMAT2_RAW_CD_WRITE_ACTION_UNKNOWN   = 0x00000000,
    ///Preparing to write the session.
    IMAPI_FORMAT2_RAW_CD_WRITE_ACTION_PREPARING = 0x00000001,
    ///Writing session data.
    IMAPI_FORMAT2_RAW_CD_WRITE_ACTION_WRITING   = 0x00000002,
    ///Synchronizing the drive's cache with the end of the data written to disc.
    IMAPI_FORMAT2_RAW_CD_WRITE_ACTION_FINISHING = 0x00000003,
}

///Defines the sector types that can be written to CD media.
alias IMAPI_CD_SECTOR_TYPE = int;
enum : int
{
    ///With this sector type, Audio data has 2352 bytes per sector/frame. This can be broken down into 588 contiguous
    ///samples, each sample being four bytes. The layout of a single sample matches the 16-bit stereo 44.1KHz WAV file
    ///data. This type of sector has no additional error correcting codes.
    IMAPI_CD_SECTOR_AUDIO         = 0x00000000,
    ///With this sector type, user data has 2336 bytes per sector/frame. This seldom-used sector type contains all zero
    ///data, and is almost never seen in media today.
    IMAPI_CD_SECTOR_MODE_ZERO     = 0x00000001,
    ///With this sector type, user data has 2048 bytes per sector/frame. Mode1 data is the most common data form for
    ///pressed CD-ROM media. This data type also provides the greatest level of ECC/EDC among the standard sector types.
    IMAPI_CD_SECTOR_MODE1         = 0x00000002,
    ///With this sector type, user data has 2336 bytes per sector/frame. All Mode 2 sector types are also known as
    ///"CD-ROM XA" modes, which allows mixing of audio and data tracks on a single disc. This sector type is also known
    ///as Mode 2 "Formless", is considered deprecated, and is very seldom used.
    IMAPI_CD_SECTOR_MODE2FORM0    = 0x00000003,
    ///With this sector type, user data has 2048 bytes per sector/frame. All Mode 2 sector types are also known as
    ///"CD-ROM XA" modes, which allows mixing of audio and data tracks on a single disc.
    IMAPI_CD_SECTOR_MODE2FORM1    = 0x00000004,
    ///With this sector type, user data has 2336 bytes per sector/frame, of which the final four bytes are an optional
    ///CRC code (zero if not used). All Mode 2 sector types are also known as "CD-ROM XA" modes, which allows mixing of
    ///audio and data tracks on a single disc. This sector type is most often used when writing VideoCD discs.
    IMAPI_CD_SECTOR_MODE2FORM2    = 0x00000005,
    ///With this sector type, user data has 2352 bytes per sector/frame. This is pre-processed Mode1Cooked data sectors,
    ///with sector header, ECC/EDC, and scrambling already added to the data stream.
    IMAPI_CD_SECTOR_MODE1RAW      = 0x00000006,
    ///With this sector type, user data has 2352 bytes per sector/frame. This is pre-processed Mode2Form0 data sectors,
    ///with sector header, ECC/EDC, and scrambling already added to the data stream.
    IMAPI_CD_SECTOR_MODE2FORM0RAW = 0x00000007,
    ///With this sector type, user data has 2352 bytes per sector/frame. This is pre-processed Mode2Form1 data sectors,
    ///with sector header, ECC/EDC, and scrambling already added to the data stream.
    IMAPI_CD_SECTOR_MODE2FORM1RAW = 0x00000008,
    ///With this sector type, user data has 2352 bytes per sector/frame. This is pre-processed Mode2Form2 data sectors,
    ///with sector header, ECC/EDC, and scrambling already added to the data stream.
    IMAPI_CD_SECTOR_MODE2FORM2RAW = 0x00000009,
}

///Defines the digital copy setting values available for a given track.
alias IMAPI_CD_TRACK_DIGITAL_COPY_SETTING = int;
enum : int
{
    ///Digital copies of the given track are allowed.
    IMAPI_CD_TRACK_DIGITAL_COPY_PERMITTED  = 0x00000000,
    ///Digital copies of the given track are not allowed using consumer electronics CD recorders. This condition
    ///typically has no effect on PC-based CD players.
    IMAPI_CD_TRACK_DIGITAL_COPY_PROHIBITED = 0x00000001,
    IMAPI_CD_TRACK_DIGITAL_COPY_SCMS       = 0x00000002,
}

///Defines values for the burn verification implemented by the IBurnVerification interface.
alias IMAPI_BURN_VERIFICATION_LEVEL = int;
enum : int
{
    ///No burn verification.
    IMAPI_BURN_VERIFICATION_NONE  = 0x00000000,
    ///A quick, heuristic burn verification.
    IMAPI_BURN_VERIFICATION_QUICK = 0x00000001,
    ///This verification compares the checksum to the referenced stream for either the last session or each track. A
    ///full verification includes the heuristic checks of a quick verification for both burn formats.
    IMAPI_BURN_VERIFICATION_FULL  = 0x00000002,
}

///Defines values for the file system item that was found using the IFileSystemImage::Exists method.
enum FsiItemType : int
{
    ///The specified item was not found.
    FsiItemNotFound  = 0x00000000,
    ///The specified item is a directory.
    FsiItemDirectory = 0x00000001,
    ///The specified item is a file.
    FsiItemFile      = 0x00000002,
}

///Defines values for recognized file systems.
enum FsiFileSystems : int
{
    ///The disc does not contain a recognized file system.
    FsiFileSystemNone    = 0x00000000,
    ///Standard CD file system.
    FsiFileSystemISO9660 = 0x00000001,
    ///Joliet file system.
    FsiFileSystemJoliet  = 0x00000002,
    ///UDF file system.
    FsiFileSystemUDF     = 0x00000004,
    ///The disc appears to have a file system, but the layout does not match any of the recognized types.
    FsiFileSystemUnknown = 0x40000000,
}

///Defines values for media types that the boot image is intended to emulate.
enum EmulationType : int
{
    ///No emulation. The BIOS will not emulate any device type or special sector size for the CD during boot from the
    ///CD.
    EmulationNone       = 0x00000000,
    ///Emulates a 1.2 MB floppy disk.
    Emulation12MFloppy  = 0x00000001,
    ///Emulates a 1.44 MB floppy disk.
    Emulation144MFloppy = 0x00000002,
    ///Emulates a 2.88 MB floppy disk.
    Emulation288MFloppy = 0x00000003,
    ///Emulates a hard disk.
    EmulationHardDisk   = 0x00000004,
}

///Defines values for the operating system architecture that the boot image supports
enum PlatformId : int
{
    ///Intel Pentium™ series of chip sets. This entry implies a Windows operating system.
    PlatformX86     = 0x00000000,
    ///Apple PowerPC family.
    PlatformPowerPC = 0x00000001,
    ///Apple Macintosh family.
    PlatformMac     = 0x00000002,
    ///EFI Family.
    PlatformEFI     = 0x000000ef,
}

alias MEDIA_TYPES = int;
enum : int
{
    MEDIA_CDDA_CDROM = 0x00000001,
    MEDIA_CD_ROM_XA  = 0x00000002,
    MEDIA_CD_I       = 0x00000003,
    MEDIA_CD_EXTRA   = 0x00000004,
    MEDIA_CD_OTHER   = 0x00000005,
    MEDIA_SPECIAL    = 0x00000006,
}

alias MEDIA_FLAGS = int;
enum : int
{
    MEDIA_BLANK                    = 0x00000001,
    MEDIA_RW                       = 0x00000002,
    MEDIA_WRITABLE                 = 0x00000004,
    MEDIA_FORMAT_UNUSABLE_BY_IMAPI = 0x00000008,
}

alias RECORDER_TYPES = int;
enum : int
{
    RECORDER_CDR  = 0x00000001,
    RECORDER_CDRW = 0x00000002,
}

// Constants


enum HRESULT IMAPI_S_PROPERTIESIGNORED = HRESULT(0x00040200);

enum : HRESULT
{
    IMAPI_E_NOTOPENED      = HRESULT(0x8004020b),
    IMAPI_E_NOTINITIALIZED = HRESULT(0x8004020c),
}

enum : HRESULT
{
    IMAPI_E_GENERIC            = HRESULT(0x8004020e),
    IMAPI_E_MEDIUM_NOTPRESENT  = HRESULT(0x8004020f),
    IMAPI_E_MEDIUM_INVALIDTYPE = HRESULT(0x80040210),
}

enum : HRESULT
{
    IMAPI_E_DEVICE_NOTACCESSIBLE = HRESULT(0x80040212),
    IMAPI_E_DEVICE_NOTPRESENT    = HRESULT(0x80040213),
    IMAPI_E_DEVICE_INVALIDTYPE   = HRESULT(0x80040214),
}

enum HRESULT IMAPI_E_INITIALIZE_ENDWRITE = HRESULT(0x80040216);

enum : HRESULT
{
    IMAPI_E_FILEACCESS    = HRESULT(0x80040218),
    IMAPI_E_DISCINFO      = HRESULT(0x80040219),
    IMAPI_E_TRACKNOTOPEN  = HRESULT(0x8004021a),
    IMAPI_E_TRACKOPEN     = HRESULT(0x8004021b),
    IMAPI_E_DISCFULL      = HRESULT(0x8004021c),
    IMAPI_E_BADJOLIETNAME = HRESULT(0x8004021d),
}

enum : HRESULT
{
    IMAPI_E_NOACTIVEFORMAT   = HRESULT(0x8004021f),
    IMAPI_E_NOACTIVERECORDER = HRESULT(0x80040220),
}

enum : HRESULT
{
    IMAPI_E_ALREADYOPEN         = HRESULT(0x80040222),
    IMAPI_E_WRONGDISC           = HRESULT(0x80040223),
    IMAPI_E_FILEEXISTS          = HRESULT(0x80040224),
    IMAPI_E_STASHINUSE          = HRESULT(0x80040225),
    IMAPI_E_DEVICE_STILL_IN_USE = HRESULT(0x80040226),
}

enum HRESULT IMAPI_E_COMPRESSEDSTASH = HRESULT(0x80040228);
enum HRESULT IMAPI_E_NOTENOUGHDISKFORSTASH = HRESULT(0x8004022a);
enum HRESULT IMAPI_E_CANNOT_WRITE_TO_MEDIA = HRESULT(0x8004022c);
enum HRESULT IMAPI_E_BOOTIMAGE_AND_NONBLANK_DISC = HRESULT(0x8004022e);

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

///Use this interface to enumerate the CD and DVD devices installed on the computer. To create an instance of this
///interface, call the <b>CoCreateInstance</b> function. Use__uuidof(MsftDiscMaster2) for the class identifier and
///__uuidof(IDiscMaster2) for the interface identifier.
@GUID("27354130-7F64-5B0F-8F00-5D77AFBE261E")
interface IDiscMaster2 : IDispatch
{
    ///Retrieves a list of the CD and DVD devices installed on the computer.
    ///Params:
    ///    ppunk = An <b>IEnumVariant</b> interface that you use to enumerate the CD and DVD devices installed on the computer.
    ///            The items of the enumeration are variants whose type is <b>VT_BSTR</b>. Use the <b>bstrVal</b> member to
    ///            retrieve the unique identifier of the device.
    ///Returns:
    ///    S_OK is returned when the number of requested elements (<i>celt</i>) are returned successfully or the number
    ///    of returned items (<i>pceltFetched</i>) is less than the number of requested elements. The <i>celt</i> and
    ///    <i>pceltFetched</i> parameters are defined by <b>IEnumVariant</b>. Other success codes may be returned as a
    ///    result of implementation. The following error codes are commonly returned on operation failure, but do not
    ///    represent the only possible error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value:
    ///    0x80004003 </td> </tr> </table>
    ///    
    HRESULT get__NewEnum(IEnumVARIANT* ppunk);
    ///Retrieves the unique identifier of the specified disc device.
    ///Params:
    ///    index = Zero-based index of the device whose unique identifier you want to retrieve. The index value can change
    ///            during PNP activity when devices are added or removed from the computer, or across boot sessions.
    ///    value = String that contains the unique identifier of the disc device associated with the specified index.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
    ///    </dl> </td> <td width="60%"> Failed to allocate the required memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT get_Item(int index, BSTR* value);
    ///Retrieves the number of the CD and DVD disc devices installed on the computer.
    ///Params:
    ///    value = Number of CD and DVD disc devices installed on the computer.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
    ///    <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> </table>
    ///    
    HRESULT get_Count(int* value);
    ///Retrieves a value that determines if the environment contains one or more optical devices and the execution
    ///context has permission to access the devices.
    ///Params:
    ///    value = Is VARIANT_TRUE if the environment contains one or more optical devices and the execution context has
    ///            permission to access the devices; otherwise, VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_IsSupportedEnvironment(short* value);
}

///Implement this interface to receive notification when a CD or DVD device is added to or removed from the computer.
@GUID("27354131-7F64-5B0F-8F00-5D77AFBE261E")
interface DDiscMaster2Events : IDispatch
{
    ///Receives notification when an optical media device is added to the computer.
    ///Params:
    ///    object = An IDiscMaster2 interface that you can use to enumerate the devices on the computer. This parameter is a
    ///             <b>MsftDiscMaster2</b> object in script.
    ///    uniqueId = String that contains an identifier that uniquely identifies the optical media device that was added to the
    ///               computer.
    ///Returns:
    ///    Return values are ignored.
    ///    
    HRESULT NotifyDeviceAdded(IDispatch object, BSTR uniqueId);
    ///Receives notification when an optical media device is removed from the computer.
    ///Params:
    ///    object = An IDiscMaster2 interface that you can use to enumerate the devices on the computer. This parameter is a
    ///             <b>MsftDiscMaster2</b> object in script.
    ///    uniqueId = String that contains an identifier that uniquely identifies the optical media device that was added to the
    ///               computer.
    ///Returns:
    ///    Return values are ignored.
    ///    
    HRESULT NotifyDeviceRemoved(IDispatch object, BSTR uniqueId);
}

///This interface represents a physical device. You use this interface to retrieve information about a CD and DVD device
///installed on the computer and to perform operations such as closing the tray or ejecting the media. This interface
///retrieves information not available through IDiscRecorder2 interface, and provides easier access to some of the same
///property values in <b>IDiscRecorder2</b>. To get an instance of this interface, create an instance of the
///IDiscRecorder2 interface and then call the <b>IDiscRecorder2::QueryInterface</b> method to retrieve the
///<b>IDiscRecorder2Ex</b> interface. Note that you cannot access this functionality from script.
@GUID("27354132-7F64-5B0F-8F00-5D77AFBE261E")
interface IDiscRecorder2Ex : IUnknown
{
    ///Sends a MMC command to the recording device. Use this function when no data buffer is sent to nor received from
    ///the device.
    ///Params:
    ///    Cdb = Command packet to send to the device.
    ///    CdbSize = Size, in bytes, of the command packet to send. Must be between 6 and 16 bytes.
    ///    SenseBuffer = Sense data returned by the recording device.
    ///    Timeout = Time limit, in seconds, allowed for the send command to receive a result.
    ///Returns:
    ///    S_OK or one of the following values can be returned on success, but other success codes may be returned as a
    ///    result of implementation: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_IMAPI_COMMAND_HAS_SENSE_DATA</b></dt> </dl> </td> <td width="60%"> The device fails the
    ///    command, but returns sense data. Value: 0x00AA0200 </td> </tr> </table> The following error codes are
    ///    commonly returned on operation failure, but do not represent the only possible error values: <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_GET_CONFIGURATION_NOT_SUPPORTED</b></dt> </dl> </td> <td
    ///    width="60%"> The drive does not support the GET CONFIGURATION command. Value: 0xC0AA020C </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_FEATURE</b></dt> </dl> </td> <td width="60%"> The feature
    ///    page requested is not supported by the device. Value: 0xC0AA020A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_FEATURE_IS_NOT_CURRENT</b></dt>
    ///    </dl> </td> <td width="60%"> The feature page requested is supported, but is not marked as current. Value:
    ///    0xC0AA020B </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT SendCommandNoData(ubyte* Cdb, uint CdbSize, ubyte* SenseBuffer, uint Timeout);
    ///Sends a MMC command and its associated data buffer to the recording device.
    ///Params:
    ///    Cdb = Command packet to send to the device.
    ///    CdbSize = Size, in bytes, of the command packet to send. Must be between 6 and 16 bytes.
    ///    SenseBuffer = Sense data returned by the recording device.
    ///    Timeout = Time limit, in seconds, allowed for the send command to receive a result.
    ///    Buffer = Buffer containing data associated with the send command. Must not be <b>NULL</b>.
    ///    BufferSize = Size, in bytes, of the data buffer to send. Must not be zero.
    ///Returns:
    ///    S_OK or one of the following values can be returned on success, but other success codes may be returned as a
    ///    result of implementation: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_IMAPI_COMMAND_HAS_SENSE_DATA</b></dt> </dl> </td> <td width="60%"> The device fails the
    ///    command, but returns sense data. Value: 0x00AA0200 </td> </tr> </table> The following error codes are
    ///    commonly returned on operation failure, but do not represent the only possible error values: <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_GET_CONFIGURATION_NOT_SUPPORTED</b></dt> </dl> </td> <td
    ///    width="60%"> The drive does not support the GET CONFIGURATION command. Value: 0xC0AA020C </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_FEATURE</b></dt> </dl> </td> <td width="60%"> The feature
    ///    page requested is not supported by the device. Value: 0xC0AA020A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_FEATURE_IS_NOT_CURRENT</b></dt>
    ///    </dl> </td> <td width="60%"> The feature page requested is supported, but is not marked as current. Value:
    ///    0xC0AA020B </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT SendCommandSendDataToDevice(ubyte* Cdb, uint CdbSize, ubyte* SenseBuffer, uint Timeout, ubyte* Buffer, 
                                        uint BufferSize);
    ///Sends a MMC command to the recording device requesting data from the device.
    ///Params:
    ///    Cdb = Command packet to send to the device.
    ///    CdbSize = Size, in bytes, of the command packet to send. Must be between 6 and 16 bytes.
    ///    SenseBuffer = Sense data returned by the recording device.
    ///    Timeout = Time limit, in seconds, allowed for the send command to receive a result.
    ///    Buffer = Application-allocated data buffer that will receive data associated with the send command. Must not be
    ///             <b>NULL</b>.
    ///    BufferSize = Size, in bytes, of the <i>Buffer</i> data buffer. Must not be zero.
    ///    BufferFetched = Size, in bytes, of the data returned in the <i>Buffer</i> data buffer.
    ///Returns:
    ///    S_OK or one of the following values can be returned on success, but other success codes may be returned as a
    ///    result of implementation: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_IMAPI_COMMAND_HAS_SENSE_DATA</b></dt> </dl> </td> <td width="60%"> The device fails the
    ///    command, but returns sense data. </td> </tr> </table> The following error codes are commonly returned on
    ///    operation failure, but do not represent the only possible error values: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_GET_CONFIGURATION_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The drive does
    ///    not support the GET CONFIGURATION command. Value: 0xC0AA020C </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_NO_SUCH_FEATURE</b></dt> </dl> </td> <td width="60%"> The feature page requested is
    ///    not supported by the device. Value: 0xC0AA020A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_FEATURE_IS_NOT_CURRENT</b></dt>
    ///    </dl> </td> <td width="60%"> The feature page requested is supported, but is not marked as current. Value:
    ///    0xC0AA020B </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT SendCommandGetDataFromDevice(ubyte* Cdb, uint CdbSize, ubyte* SenseBuffer, uint Timeout, ubyte* Buffer, 
                                         uint BufferSize, uint* BufferFetched);
    ///Reads a DVD structure from the media.
    ///Params:
    ///    format = Format field of the command packet. Acceptable values range from zero to 0xFF. <div class="alert"><b>Note</b>
    ///             This value is truncated to <b>UCHAR</b>.</div> <div> </div>
    ///    address = Address field of the command packet.
    ///    layer = Layer field of the command packet.
    ///    agid = Authentication grant ID (AGID) field of the command packet.
    ///    data = Data buffer that contains the DVD structure. For details of the contents of the data buffer, see the READ
    ///           DISC STRUCTURE command in the latest revision of the MMC specification at ftp://ftp.t10.org/t10/drafts/mmc5.
    ///           This method removes headers from the buffer. When done, call the <b>CoTaskMemFree</b> function to free the
    ///           memory.
    ///    count = Size, in bytes, of the data buffer.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_GET_CONFIGURATION_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The drive does
    ///    not support the GET CONFIGURATION command. Value: 0xC0AA020C </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_NO_SUCH_FEATURE</b></dt> </dl> </td> <td width="60%"> The feature page requested is
    ///    not supported by the device. Value: 0xC0AA020A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_FEATURE_IS_NOT_CURRENT</b></dt>
    ///    </dl> </td> <td width="60%"> The feature page requested is supported, but is not marked as current. Value:
    ///    0xC0AA020B </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td>
    ///    <td width="60%"> The device failed to accept the command within the timeout period. This may be caused by the
    ///    device having entered an inconsistent state, or the timeout value for the command may need to be increased.
    ///    Value: 0xC0AA020E </td> </tr> </table>
    ///    
    HRESULT ReadDvdStructure(uint format, uint address, uint layer, uint agid, ubyte** data, uint* count);
    ///Sends a DVD structure to the media.
    ///Params:
    ///    format = Format field of the command packet. Acceptable values range from zero to 0xFF.
    ///    data = Data buffer that contains the DVD structure to send to the media. Do not include a header; this method
    ///           generates and prepends a header to the DVD structure.
    ///    count = Size, in bytes, of the data buffer.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_GET_CONFIGURATION_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The drive does
    ///    not support the GET CONFIGURATION command. Value: 0xC0AA020C </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_NO_SUCH_FEATURE</b></dt> </dl> </td> <td width="60%"> The feature page requested is
    ///    not supported by the device. Value: 0xC0AA020A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_FEATURE_IS_NOT_CURRENT</b></dt>
    ///    </dl> </td> <td width="60%"> The feature page requested is supported, but is not marked as current. Value:
    ///    0xC0AA020B </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT SendDvdStructure(uint format, ubyte* data, uint count);
    ///Retrieves the adapter descriptor for the device.
    ///Params:
    ///    data = Data buffer that contains the descriptor of the storage adapter. For details of the contents of the data
    ///           buffer, see the <b>STORAGE_ADAPTER_DESCRIPTOR</b> structure in the DDK When done, call the
    ///           <b>CoTaskMemFree</b> function to free the memory.
    ///    byteSize = Size, in bytes, of the data buffer.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> </table>
    ///    
    HRESULT GetAdapterDescriptor(ubyte** data, uint* byteSize);
    ///Retrieves the device descriptor for the device.
    ///Params:
    ///    data = Data buffer that contains the descriptor of the storage device. For details of the contents of the data
    ///           buffer, see the <b>STORAGE_DEVICE_DESCRIPTOR</b> structure in the DDK When done, call the
    ///           <b>CoTaskMemFree</b> function to free the memory.
    ///    byteSize = Size, in bytes, of the data buffer.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT GetDeviceDescriptor(ubyte** data, uint* byteSize);
    ///Retrieves the disc information from the media.
    ///Params:
    ///    discInformation = Data buffer that contains disc information from the media. For details of the contents of the data buffer,
    ///                      see the READ DISC INFORMATION command in the latest revision of the MMC specification at
    ///                      ftp://ftp.t10.org/t10/drafts/mmc5. When done, call the <b>CoTaskMemFree</b> function to free the memory.
    ///    byteSize = Size, in bytes, of the data buffer.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The device failed to accept the
    ///    command within the timeout period. This may be caused by the device having entered an inconsistent state, or
    ///    the timeout value for the command may need to be increased. Value: 0xC0AA020D </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%">
    ///    The device reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media
    ///    is inserted upside down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT GetDiscInformation(ubyte** discInformation, uint* byteSize);
    ///Retrieves the track information from the media.
    ///Params:
    ///    address = Address field. The <i>addressType</i> parameter provides additional context for this parameter.
    ///    addressType = Type of address specified in the <i>address</i> parameter, for example, if this is an LBA address or a track
    ///                  number. For possible values, see the IMAPI_READ_TRACK_ADDRESS_TYPE enumeration type.
    ///    trackInformation = Data buffer that contains the track information. For details of the contents of the data buffer, see the READ
    ///                       TRACK INFORMATION command in the latest revision of the MMC specification at
    ///                       ftp://ftp.t10.org/t10/drafts/mmc5. When done, call the <b>CoTaskMemFree</b> function to free the memory.
    ///    byteSize = Size, in bytes, of the <i>trackInformation</i> data buffer.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_GET_CONFIGURATION_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The drive does
    ///    not support the GET CONFIGURATION command. Value: 0xC0AA020C </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_NO_SUCH_FEATURE</b></dt> </dl> </td> <td width="60%"> The feature page requested is
    ///    not supported by the device. Value: 0xC0AA020A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_FEATURE_IS_NOT_CURRENT</b></dt>
    ///    </dl> </td> <td width="60%"> The feature page requested is supported, but is not marked as current. Value:
    ///    0xC0AA020B </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT GetTrackInformation(uint address, IMAPI_READ_TRACK_ADDRESS_TYPE addressType, ubyte** trackInformation, 
                                uint* byteSize);
    ///Retrieves the specified feature page from the device.
    ///Params:
    ///    requestedFeature = Feature page to retrieve. For possible values, see the IMAPI_FEATURE_PAGE_TYPE enumeration type.
    ///    currentFeatureOnly = Set to True to retrieve the feature page only when it is the current feature page. Otherwise, False to
    ///                         retrieve the feature page regardless of it being the current feature page.
    ///    featureData = Data buffer that contains the feature page. For details of the contents of the data buffer, see the GET
    ///                  CONFIGURATION command in the latest revision of the MMC specification at ftp://ftp.t10.org/t10/drafts/mmc5.
    ///                  This method removes header information and other non-feature data before filling and sending this buffer.
    ///                  When done, call the <b>CoTaskMemFree</b> function to free the memory.
    ///    byteSize = Size, in bytes, of the <i>featureData</i> data buffer.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_GET_CONFIGURATION_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The drive does
    ///    not support the GET CONFIGURATION command. Value: 0xC0AA020C </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_NO_SUCH_FEATURE</b></dt> </dl> </td> <td width="60%"> The feature page requested is
    ///    not supported by the device. Value: 0xC0AA020A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_FEATURE_IS_NOT_CURRENT</b></dt>
    ///    </dl> </td> <td width="60%"> The feature page requested is supported, but is not marked as current. Value:
    ///    0xC0AA020B </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT GetFeaturePage(IMAPI_FEATURE_PAGE_TYPE requestedFeature, ubyte currentFeatureOnly, ubyte** featureData, 
                           uint* byteSize);
    ///Retrieves the specified mode page from the device.
    ///Params:
    ///    requestedModePage = Mode page to retrieve. For possible values, see the IMAPI_MODE_PAGE_TYPE enumeration type.
    ///    requestType = Type of mode page data to retrieve, for example, the current settings or the settings that are write enabled.
    ///                  For possible values, see the IMAPI_MODE_PAGE_REQUEST_TYPE enumeration type.
    ///    modePageData = Data buffer that contains the mode page. For details of the contents of the data buffer, see the MODE SENSE
    ///                   (10) command in the latest revision of the MMC specification at ftp://ftp.t10.org/t10/drafts/mmc5. This
    ///                   method removes header information and other non-page data before returning the buffer. When done, call the
    ///                   <b>CoTaskMemFree</b> function to free the memory.
    ///    byteSize = Size, in bytes, of the <i>modePageData</i> data buffer.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> </table>
    ///    
    HRESULT GetModePage(IMAPI_MODE_PAGE_TYPE requestedModePage, IMAPI_MODE_PAGE_REQUEST_TYPE requestType, 
                        ubyte** modePageData, uint* byteSize);
    ///Sets the mode page data for the device.
    ///Params:
    ///    requestType = Type of mode page data to send. For possible values, see the IMAPI_MODE_PAGE_REQUEST_TYPE enumeration type.
    ///    data = Data buffer that contains the mode page data to send to the media. Do not include a header; this method
    ///           generates and prepends a header to the mode page data. For details on specifying the fields of the mode page
    ///           data, see the MODE SELECT (10) command in the latest revision of the MMC specification at
    ///           ftp://ftp.t10.org/t10/drafts/mmc5.
    ///    byteSize = Size, in bytes, of the data buffer.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_GET_CONFIGURATION_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The drive does
    ///    not support the GET CONFIGURATION command. Value: 0xC0AA020C </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_NO_SUCH_FEATURE</b></dt> </dl> </td> <td width="60%"> The feature page requested is
    ///    not supported by the device. Value: 0xC0AA020A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_FEATURE_IS_NOT_CURRENT</b></dt>
    ///    </dl> </td> <td width="60%"> The feature page requested is supported, but is not marked as current. Value:
    ///    0xC0AA020B </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT SetModePage(IMAPI_MODE_PAGE_REQUEST_TYPE requestType, ubyte* data, uint byteSize);
    ///Retrieves the list of supported feature pages or the current feature pages of the device.
    ///Params:
    ///    currentFeatureOnly = Set to True to retrieve only current feature pages. Otherwise, False to retrieve all feature pages that the
    ///                         device supports.
    ///    featureData = Data buffer that contains one or more feature page types. For possible values, see the
    ///                  IMAPI_FEATURE_PAGE_TYPE enumeration type. To get the feature page data associated with the feature page type,
    ///                  call the IDiscRecorder2Ex::GetFeaturePage method. When done, call the <b>CoTaskMemFree</b> function to free
    ///                  the memory.
    ///    byteSize = Number of supported feature pages in the <i>featureData</i> data buffer.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_GET_CONFIGURATION_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The drive does
    ///    not support the GET CONFIGURATION command. Value: 0xC0AA020C </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_NO_SUCH_FEATURE</b></dt> </dl> </td> <td width="60%"> The feature page requested is
    ///    not supported by the device. Value: 0xC0AA020A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_FEATURE_IS_NOT_CURRENT</b></dt>
    ///    </dl> </td> <td width="60%"> The feature page requested is supported, but is not marked as current. Value:
    ///    0xC0AA020B </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT GetSupportedFeaturePages(ubyte currentFeatureOnly, IMAPI_FEATURE_PAGE_TYPE** featureData, 
                                     uint* byteSize);
    ///Retrieves the supported profiles or the current profiles of the device.
    ///Params:
    ///    currentOnly = Set to True to retrieve the current profiles. Otherwise, False to return all supported profiles of the
    ///                  device.
    ///    profileTypes = Data buffer that contains one or more profile types. For possible values, see the IMAPI_PROFILE_TYPE
    ///                   enumeration type. When done, call the <b>CoTaskMemFree</b> function to free the memory.
    ///    validProfiles = Number of supported profiles in the <i>profileTypes</i> data buffer.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_GET_CONFIGURATION_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The drive does
    ///    not support the GET CONFIGURATION command. Value: 0xC0AA020C </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_NO_SUCH_FEATURE</b></dt> </dl> </td> <td width="60%"> The feature page requested is
    ///    not supported by the device. Value: 0xC0AA020A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_FEATURE_IS_NOT_CURRENT</b></dt>
    ///    </dl> </td> <td width="60%"> The feature page requested is supported, but is not marked as current. Value:
    ///    0xC0AA020B </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT GetSupportedProfiles(ubyte currentOnly, IMAPI_PROFILE_TYPE** profileTypes, uint* validProfiles);
    ///Retrieves the supported mode pages for the device.
    ///Params:
    ///    requestType = Type of mode page data to retrieve, for example, the current settings or the settings that are write enabled.
    ///                  For possible values, see the IMAPI_MODE_PAGE_REQUEST_TYPE enumeration type.
    ///    modePageTypes = Data buffer that contains one or more mode page types. For possible values, see the IMAPI_MODE_PAGE_TYPE
    ///                    enumeration type. To get the mode page data associated with the mode page type, call the
    ///                    IDiscRecorder2Ex::GetModePage method. When done, call the <b>CoTaskMemFree</b> function to free the memory.
    ///    validPages = Number of mode pages in the data buffer.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> </table>
    ///    
    HRESULT GetSupportedModePages(IMAPI_MODE_PAGE_REQUEST_TYPE requestType, IMAPI_MODE_PAGE_TYPE** modePageTypes, 
                                  uint* validPages);
    ///Retrieves the byte alignment mask for the device.
    ///Params:
    ///    value = Byte alignment mask that you use to determine if the buffer is aligned to the correct byte boundary for the
    ///            device. The byte alignment value is always a number that is a power of 2.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> </table>
    ///    
    HRESULT GetByteAlignmentMask(uint* value);
    ///Retrieves the maximum non-page-aligned transfer size for the device.
    ///Params:
    ///    value = Maximum size, in bytes, of a non-page-aligned buffer.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> </table>
    ///    
    HRESULT GetMaximumNonPageAlignedTransferSize(uint* value);
    ///Retrieves the maximum page-aligned transfer size for the device.
    ///Params:
    ///    value = Maximum size, in bytes, of a page-aligned buffer.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> </table>
    ///    
    HRESULT GetMaximumPageAlignedTransferSize(uint* value);
}

///This interface represents a physical device. You use this interface to retrieve information about a CD and DVD device
///installed on the computer and to perform operations such as closing the tray or eject the media. To create an
///instance of this interface, call the <b>CoCreateInstance</b> function. Use__uuidof(MsftDiscRecorder2) for the class
///identifier and __uuidof(IDiscRecorder2) for the interface identifier.
@GUID("27354133-7F64-5B0F-8F00-5D77AFBE261E")
interface IDiscRecorder2 : IDispatch
{
    ///Ejects media from the device.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT EjectMedia();
    ///Closes the media tray.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT CloseTray();
    ///Acquires exclusive access to the device.
    ///Params:
    ///    force = Set to VARIANT_TRUE to gain exclusive access to the volume whether the file system volume can or cannot be
    ///            dismounted. If VARIANT_FALSE, this method gains exclusive access only when there is no file system mounted on
    ///            the volume.
    ///    __MIDL__IDiscRecorder20000 = String that contains the friendly name of the client application requesting exclusive access. Cannot be
    ///                                 <b>NULL</b> or a zero-length string. The string must conform to the restrictions for the
    ///                                 IOCTL_CDROM_EXCLUSIVE_ACCESS control code found in the DDK.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The device is currently
    ///    being used by another application. Value: 0x80070005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The device failed to accept the
    ///    command within the timeout period. This may be caused by the device having entered an inconsistent state, or
    ///    the timeout value for the command may need to be increased. Value: 0xC0AA020D </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The
    ///    specified handle is invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to fail. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT AcquireExclusiveAccess(short force, BSTR __MIDL__IDiscRecorder20000);
    ///Releases exclusive access to the device.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The device failed to accept the
    ///    command within the timeout period. This may be caused by the device having entered an inconsistent state, or
    ///    the timeout value for the command may need to be increased. Value: 0xC0AA020D </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The
    ///    specified handle is invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT ReleaseExclusiveAccess();
    ///Disables Media Change Notification (MCN) for the device.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The device failed to accept the
    ///    command within the timeout period. This may be caused by the device having entered an inconsistent state, or
    ///    the timeout value for the command may need to be increased. Value: 0xC0AA020D </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The
    ///    specified handle is invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT DisableMcn();
    ///Enables Media Change Notification (MCN) for the device.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The device failed to accept the
    ///    command within the timeout period. This may be caused by the device having entered an inconsistent state, or
    ///    the timeout value for the command may need to be increased. Value: 0xC0AA020D </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The
    ///    specified handle is invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT EnableMcn();
    ///Associates the object with the specified disc device.
    ///Params:
    ///    recorderUniqueId = String that contains the unique identifier for the device.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STRSAFE_E_INVALID_PARAMETER</b></dt> </dl> </td> <td
    ///    width="60%"> The value in cchDest is either 0 or larger than STRSAFE_MAX_CCH. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to
    ///    allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The device failed to accept the
    ///    command within the timeout period. This may be caused by the device having entered an inconsistent state, or
    ///    the timeout value for the command may need to be increased. Value: 0xC0AA020D </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%">
    ///    The device reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media
    ///    is inserted upside down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT InitializeDiscRecorder(BSTR recorderUniqueId);
    ///Retrieves the unique identifier used to initialize the disc device.
    ///Params:
    ///    value = Unique identifier for the device. This is the identifier you specified when calling
    ///            IDiscRecorder2::InitializeDiscRecorder.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One or more arguments are not valid. Value: 0x80070057 </td> </tr> </table>
    ///    
    HRESULT get_ActiveDiscRecorder(BSTR* value);
    ///Retrieves the vendor ID for the device.
    ///Params:
    ///    value = String that contains the vendor ID for the device.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT get_VendorId(BSTR* value);
    ///Retrieves the product ID of the device.
    ///Params:
    ///    value = String that contains the product ID of the device.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT get_ProductId(BSTR* value);
    ///Retrieves the product revision code of the device.
    ///Params:
    ///    value = String that contains the product revision code of the device.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT get_ProductRevision(BSTR* value);
    ///Retrieves the unique volume name associated with the device.
    ///Params:
    ///    value = String that contains the unique volume name associated with the device.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT get_VolumeName(BSTR* value);
    ///Retrieves a list of drive letters and NTFS mount points for the device.
    ///Params:
    ///    value = List of drive letters and NTFS mount points for the device. Each element of the list is a <b>VARIANT</b> of
    ///            type <b>VT_BSTR</b>. The <b>bstrVal</b> member of the variant contains the path.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT get_VolumePathNames(SAFEARRAY** value);
    ///Determines if the device can eject and subsequently reload media.
    ///Params:
    ///    value = Is VARIANT_TRUE if the device can eject and subsequently reload media. If VARIANT_FALSE, loading media must
    ///            be done manually. <div class="alert"><b>Note</b> For slim drives or laptop drives, which utilize a manual
    ///            tray-loading mechanism, this parameter can indicate an incorrect value of VARIANT_TRUE.</div> <div> </div>
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> </table>
    ///    
    HRESULT get_DeviceCanLoadMedia(short* value);
    ///Retrieves the legacy device number for a CD or DVD device.
    ///Params:
    ///    legacyDeviceNumber = Zero-based index number of the device, based on the order the device was installed on the computer. This
    ///                         value can change during PNP activity when devices are added or removed from the computer, or across boot
    ///                         sessions and should not be considered a unique identifier for the device.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> </table>
    ///    
    HRESULT get_LegacyDeviceNumber(int* legacyDeviceNumber);
    ///Retrieves the list of features that the device supports.
    ///Params:
    ///    value = List of features that the device supports. Each element of the list is a <b>VARIANT</b> of type <b>VT_I4</b>.
    ///            The <b>lVal</b> member of the variant contains the feature page type value. For possible values, see the
    ///            IMAPI_FEATURE_PAGE_TYPE enumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_GET_CONFIGURATION_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The drive does
    ///    not support the GET CONFIGURATION command. Value: 0xC0AA020C </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_NO_SUCH_FEATURE</b></dt> </dl> </td> <td width="60%"> The feature page requested is
    ///    not supported by the device. Value: 0xC0AA020A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_FEATURE_IS_NOT_CURRENT</b></dt>
    ///    </dl> </td> <td width="60%"> The feature page requested is supported, but is not marked as current. Value:
    ///    0xC0AA020B </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT get_SupportedFeaturePages(SAFEARRAY** value);
    ///Retrieves the list of feature pages of the device that are marked as current.
    ///Params:
    ///    value = List of supported feature pages that are marked as current for the device. Each element of the list is a
    ///            <b>VARIANT</b> of type <b>VT_I4</b>. The <b>lVal</b> member of the variant contains the feature page type.
    ///            For possible values, see the IMAPI_FEATURE_PAGE_TYPE enumeration.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_GET_CONFIGURATION_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The drive does
    ///    not support the GET CONFIGURATION command. Value: 0xC0AA020C </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_NO_SUCH_FEATURE</b></dt> </dl> </td> <td width="60%"> The feature page requested is
    ///    not supported by the device. Value: 0xC0AA020A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_FEATURE_IS_NOT_CURRENT</b></dt>
    ///    </dl> </td> <td width="60%"> The feature page requested is supported, but is not marked as current. Value:
    ///    0xC0AA020B </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT get_CurrentFeaturePages(SAFEARRAY** value);
    ///Retrieves the list of MMC profiles that the device supports.
    ///Params:
    ///    value = List of MMC profiles that the device supports. Each element of the list is a <b>VARIANT</b> of type
    ///            <b>VT_I4</b>. The <b>lVal</b> member of the variant contains the profile type value. For possible values, see
    ///            the IMAPI_PROFILE_TYPE enumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_GET_CONFIGURATION_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The drive does
    ///    not support the GET CONFIGURATION command. Value: 0xC0AA020C </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_NO_SUCH_FEATURE</b></dt> </dl> </td> <td width="60%"> The feature page requested is
    ///    not supported by the device. Value: 0xC0AA020A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_FEATURE_IS_NOT_CURRENT</b></dt>
    ///    </dl> </td> <td width="60%"> The feature page requested is supported, but is not marked as current. Value:
    ///    0xC0AA020B </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT get_SupportedProfiles(SAFEARRAY** value);
    ///Retrieves all MMC profiles of the device that are marked as current.
    ///Params:
    ///    value = List of supported profiles that are marked as current for the device. Each element of the list is a
    ///            <b>VARIANT</b> of type <b>VT_I4</b>. The <b>lVal</b> member of the variant contains the profile type. For
    ///            possible values, see the IMAPI_PROFILE_TYPE enumeration.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_GET_CONFIGURATION_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The drive does
    ///    not support the GET CONFIGURATION command. Value: 0xC0AA020C </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_NO_SUCH_FEATURE</b></dt> </dl> </td> <td width="60%"> The feature page requested is
    ///    not supported by the device. Value: 0xC0AA020A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_FEATURE_IS_NOT_CURRENT</b></dt>
    ///    </dl> </td> <td width="60%"> The feature page requested is supported, but is not marked as current. Value:
    ///    0xC0AA020B </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT get_CurrentProfiles(SAFEARRAY** value);
    ///Retrieves the list of MMC mode pages that the device supports.
    ///Params:
    ///    value = List of MMC mode pages that the device supports. Each element of the list is a <b>VARIANT</b> of type
    ///            <b>VT_I4</b>. The <b>lVal</b> member of the variant contains the mode page type value. For possible values,
    ///            see the IMAPI_MODE_PAGE_TYPE enumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> </table>
    ///    
    HRESULT get_SupportedModePages(SAFEARRAY** value);
    ///Retrieves the name of the client application that has exclusive access to the device.
    ///Params:
    ///    value = String that contains the name of the client application that has exclusive access to the device.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The device failed to accept the
    ///    command within the timeout period. This may be caused by the device having entered an inconsistent state, or
    ///    the timeout value for the command may need to be increased. Value: 0xC0AA020D </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The
    ///    specified handle is invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to fail. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT get_ExclusiveAccessOwner(BSTR* value);
}

///Use this interface to write a data stream to a device. This interface should be used by those developing support for
///new media types or formats. Writing to media typically includes the following steps:<ol> <li>Preparing the hardware
///by setting mode pages for the media. </li> <li>Querying the hardware to verify that the media is large enough.</li>
///<li>Initializing the write, for example, by formatting the media or setting OPC. </li> <li>Performing the actual
///WRITE commands.</li> <li>Finishing the write by stopping the formatting or closing the session or track.</li>
///</ol>When developing support for new media types, you can implement steps 1, 2, 3, and 5, and use this interface to
///perform step 4. Note that all the IDiscFormat2* interfaces use this interface to perform the write operation. Most
///client applications should use the IDiscFormat2Data interface to write images to a device. To create an instance of
///this interface, call the <b>CoCreateInstance</b> function. Use__uuidof(MsftWriteEngine2) for the class identifier and
///__uuidof(IWriteEngine2) for the interface identifier.
@GUID("27354135-7F64-5B0F-8F00-5D77AFBE261E")
interface IWriteEngine2 : IDispatch
{
    ///Writes a data stream to the current recorder.
    ///Params:
    ///    data = An <b>IStream</b> interface of the data stream to write to the recorder.
    ///    startingBlockAddress = Starting logical block address (LBA) of the write operation. Negative values are supported.
    ///    numberOfBlocks = Number of blocks from the data stream to write.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One or more arguments are not valid. Value: 0x80070057 </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_REQUEST_CANCELLED</b></dt> </dl> </td> <td width="60%"> The request was
    ///    canceled. Value: 0xC0AA0002 </td> </tr> </table>
    ///    
    HRESULT WriteSection(IStream data, int startingBlockAddress, int numberOfBlocks);
    ///Cancels a write operation that is in progress.
    ///Returns:
    ///    The following values are returned on success, but other success codes may be returned as a result of
    ///    implementation: The following error codes are commonly returned on operation failure, but do not represent
    ///    the only possible error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_IMAPI_WRITE_NOT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The 'write'
    ///    operation initiated by the last call to IWriteEngine2::WriteSection has not yet begun, and cannot be
    ///    canceled. It is recommended to call IWriteEngine2::CancelWrite until a different success code is returned.
    ///    Value: 0x00AA0302L </td> </tr> </table> The following error codes are commonly returned on operation failure,
    ///    but do not represent the only possible error values: <table> <tr> <th>Return code</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure.
    ///    Value: 0x80004005 </td> </tr> </table>
    ///    
    HRESULT CancelWrite();
    ///Sets a recording device for the write operation.
    ///Params:
    ///    value = An IDiscRecorder2Ex interface that identifies the recording device to use in the write operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT put_Recorder(IDiscRecorder2Ex value);
    ///Retrieves the recording device to use in the write operation.
    ///Params:
    ///    value = An IDiscRecorder2Ex interface that identifies the recording device to use in the write operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Recorder(IDiscRecorder2Ex* value);
    ///Sets a value that indicates if the write operations use the WRITE12 or WRITE10 command.
    ///Params:
    ///    value = Set to VARIANT_TRUE to use the WRITE12 command with the streaming bit set to one when writing to disc.
    ///            Otherwise, set VARIANT_FALSE to use the WRITE10 command. The default is VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> Setting this property to VARIANT_TRUE is currently not
    ///    supported. Value: 0x80004001 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> </table>
    ///    
    HRESULT put_UseStreamingWrite12(short value);
    ///Retrieves a value that indicates if the write operations use the WRITE12 or WRITE10 command.
    ///Params:
    ///    value = If VARIANT_TRUE, the write operations use the WRITE12 command with the streaming bit set to one. Otherwise,
    ///            if VARIANT_FALSE, the write operations use the WRITE10 command.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_UseStreamingWrite12(short* value);
    ///Sets the estimated number of sectors per second that the recording device can write to the media at the start of
    ///the writing process.
    ///Params:
    ///    value = Approximate number of sectors per second that the recording device can write to the media at the start of the
    ///            writing process. The default is -1 for maximum speed.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not
    ///    valid. Value: 0x80070057 </td> </tr> </table>
    ///    
    HRESULT put_StartingSectorsPerSecond(int value);
    ///Retrieves the estimated number of sectors per second that the recording device can write to the media at the
    ///start of the writing process.
    ///Params:
    ///    value = Approximate number of sectors per second that the recording device can write to the media at the start of the
    ///            writing process. A value of -1 indicates maximum speed.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_StartingSectorsPerSecond(int* value);
    ///Sets the estimated number of sectors per second that the recording device can write to the media at the end of
    ///the writing process.
    ///Params:
    ///    value = Approximate number of sectors per second that the recording device can write to the media at the end of the
    ///            writing process. The default is -1 for maximum speed.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not
    ///    valid. Value: 0x80070057 </td> </tr> </table>
    ///    
    HRESULT put_EndingSectorsPerSecond(int value);
    ///Retrieves the estimated number of sectors per second that the recording device can write to the media at the end
    ///of the writing process.
    ///Params:
    ///    value = Approximate number of sectors per second that the recording device can write to the media at the end of the
    ///            writing process. A value of -1 indicates maximum speed.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_EndingSectorsPerSecond(int* value);
    ///Sets the number of bytes to use for each sector during writing.
    ///Params:
    ///    value = Number of bytes to use for each sector during writing. The minimum size is 1 byte and the maximum is MAXLONG
    ///            bytes. Typically, this value is 2,048 bytes for CD media, although any arbitrary size is supported (such as
    ///            2352 or 2448). This value is limited to the IDiscRecorder2Ex::GetMaximumPageAlignedTransferSize, which is
    ///            typically 65,536 (64K) bytes.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not
    ///    valid. Value: 0x80070057 </td> </tr> </table>
    ///    
    HRESULT put_BytesPerSector(int value);
    ///Retrieves the number of bytes to use for each sector during writing. The returned value indicates what the value
    ///previously set with IWriteEngine2::put_BytesPerSector, and does not return a current bytes per sector value for
    ///media.
    ///Params:
    ///    value = Number of bytes to use for each sector during writing. <div class="alert"><b>Note</b> If
    ///            IWriteEngine2::put_BytesPerSector has not been called, this parameter will indicate a value of '-1'. </div>
    ///            <div> </div>
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_BytesPerSector(int* value);
    ///Retrieves a value that indicates whether the recorder is currently writing data to the disc.
    ///Params:
    ///    value = If VARIANT_TRUE, the recorder is currently writing data to the disc. Otherwise, if VARIANT_FALSE, the
    ///            recorder is not currently writing to disc.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_WriteInProgress(short* value);
}

///Use this interface to retrieve information about the current write operation. This interface is passed to the
///DWriteEngine2Events::Update method that you implement.
@GUID("27354136-7F64-5B0F-8F00-5D77AFBE261E")
interface IWriteEngine2EventArgs : IDispatch
{
    ///Retrieves the starting logical block address (LBA) of the current write operation.
    ///Params:
    ///    value = Starting logical block address of the write operation. Negative values for LBAs are supported.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_StartLba(int* value);
    ///Retrieves the number of sectors to write to the device in the current write operation.
    ///Params:
    ///    value = The number of sectors to write in the current write operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_SectorCount(int* value);
    ///Retrieves the address of the sector most recently read from the burn image.
    ///Params:
    ///    value = Logical block address of the sector most recently read from the input data stream.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_LastReadLba(int* value);
    ///Retrieves the address of the sector most recently written to the device.
    ///Params:
    ///    value = Logical block address of the sector most recently written to the device.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_LastWrittenLba(int* value);
    ///Retrieves the size of the internal data buffer that is used for writing to disc.
    ///Params:
    ///    value = Size, in bytes, of the internal data buffer that is used for writing to disc.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_TotalSystemBuffer(int* value);
    ///Retrieves the number of used bytes in the internal data buffer that is used for writing to disc.
    ///Params:
    ///    value = Size, in bytes, of the used portion of the internal data buffer that is used for writing to disc.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_UsedSystemBuffer(int* value);
    ///Retrieves the number of unused bytes in the internal data buffer that is used for writing to disc.
    ///Params:
    ///    value = Size, in bytes, of the unused portion of the internal data buffer that is used for writing to disc.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_FreeSystemBuffer(int* value);
}

///Implement this interface to receive notifications of the current write operation.
@GUID("27354137-7F64-5B0F-8F00-5D77AFBE261E")
interface DWriteEngine2Events : IDispatch
{
    ///Implement this method to receive progress notification of the current write operation.
    ///Params:
    ///    object = The IWriteEngine2 interface that initiated the write operation. This parameter is a <b>MsftWriteEngine2</b>
    ///             object in script.
    ///    progress = An IWriteEngine2EventArgs interface that you use to determine the progress of the write operation. This
    ///               parameter is a <b>MsftWriteEngine2</b> object in script.
    ///Returns:
    ///    Return values are ignored.
    ///    
    HRESULT Update(IDispatch object, IDispatch progress);
}

///This is a base interface. Use the following interfaces which inherit this interface:<ul> <li> IDiscFormat2Data </li>
///<li> IDiscFormat2Erase </li> <li> IDiscFormat2TrackAtOnce </li> <li> IDiscFormat2RawCD </li> </ul>
@GUID("27354152-8F64-5B0F-8F00-5D77AFBE261E")
interface IDiscFormat2 : IDispatch
{
    ///Determines if the recorder supports the given format.
    ///Params:
    ///    recorder = An IDiscRecorder2 interface of the recorder to test.
    ///    value = Is VARIANT_TRUE if the recorder supports the given format; otherwise, VARIANT_FALSE.
    ///Returns:
    ///    S_OK or S_FALSE are returned on success, but other success codes may be returned as a result of
    ///    implementation. The following error codes are commonly returned on operation failure, but do not represent
    ///    the only possible error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value:
    ///    0x80004003 </td> </tr> </table>
    ///    
    HRESULT IsRecorderSupported(IDiscRecorder2 recorder, short* value);
    ///Determines if the current media in a supported recorder supports the given format.
    ///Params:
    ///    recorder = An IDiscRecorder2 interface of the recorder to test.
    ///    value = Is VARIANT_TRUE if the media in the recorder supports the given format; otherwise, VARIANT_FALSE. <div
    ///            class="alert"><b>Note</b> VARIANT_TRUE also implies that the result from IsDiscRecorderSupported is
    ///            VARIANT_TRUE. </div> <div> </div>
    ///Returns:
    ///    S_OK or S_FALSE are returned on success, but other success codes may be returned as a result of
    ///    implementation. The following error codes are commonly returned on operation failure, but do not represent
    ///    the only possible error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value:
    ///    0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td>
    ///    <td width="60%"> There is no media in the device. (HRESULT)0xC0AA0202 </td> </tr> </table> <div
    ///    class="alert"><b>Note</b> Currently, Windows Vista will return<b> S_OK</b> and <b>VARIANT_FALSE</b> when
    ///    media is not present in the device, while <b> E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b> and <b>VARIANT_FALSE</b>
    ///    are returned in Windows 7.</div> <div> </div>
    ///    
    HRESULT IsCurrentMediaSupported(IDiscRecorder2 recorder, short* value);
    ///Determines if the current media is reported as physically blank by the drive.
    ///Params:
    ///    value = Is VARIANT_TRUE if the disc is physically blank; otherwise, VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_FEATURE_IS_NOT_CURRENT</b></dt>
    ///    </dl> </td> <td width="60%"> The feature page requested is supported, but is not marked as current. Value:
    ///    0xC0AA020B </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. 0xC0AA0210 </td>
    ///    </tr> </table>
    ///    
    HRESULT get_MediaPhysicallyBlank(short* value);
    ///Attempts to determine if the media is blank using heuristics (mainly for DVD+RW and DVD-RAM media).
    ///Params:
    ///    value = Is VARIANT_TRUE if the disc is likely to be blank; otherwise; VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_FEATURE_IS_NOT_CURRENT</b></dt>
    ///    </dl> </td> <td width="60%"> The feature page requested is supported, but is not marked as current. Value:
    ///    0xC0AA020B </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. 0xC0AA0210 </td>
    ///    </tr> </table>
    ///    
    HRESULT get_MediaHeuristicallyBlank(short* value);
    ///Retrieves the media types that are supported by the current implementation of the IDiscFormat2 interface.
    ///Params:
    ///    value = List of media types supported by the current implementation of the IDiscFormat2 interface. Each element of
    ///            the array is a <b>VARIANT</b> of type <b>VT_I4</b>. The <b>lVal</b> member of <b>VARIANT</b> contains the
    ///            media type. For a list of media types, see the IMAPI_MEDIA_PHYSICAL_TYPE enumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The device failed to accept the
    ///    command within the timeout period. This may be caused by the device having entered an inconsistent state, or
    ///    the timeout value for the command may need to be increased. Value: 0xC0AA020D </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%">
    ///    The device reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media
    ///    is inserted upside down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. 0xC0AA0210 </td>
    ///    </tr> </table>
    ///    
    HRESULT get_SupportedMediaTypes(SAFEARRAY** value);
}

///Use this interface to erase data from a disc. To create an instance of this interface, call the
///<b>CoCreateInstance</b> function. Use__uuidof(MsftDiscFormat2Erase) for the class identifier and
///__uuidof(IDiscFormat2Erase) for the interface identifier.
@GUID("27354156-8F64-5B0F-8F00-5D77AFBE261E")
interface IDiscFormat2Erase : IDiscFormat2
{
    ///Sets the recording device to use in the erase operation.
    ///Params:
    ///    value = An IDiscRecorder2 interface that identifies the recording device to use in the erase operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT put_Recorder(IDiscRecorder2 value);
    ///Retrieves the recording device to use in the erase operation.
    ///Params:
    ///    value = An IDiscRecorder2 interface that identifies the recording device to use in the erase operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Recorder(IDiscRecorder2* value);
    ///Determines the quality of the disc erasure.
    ///Params:
    ///    value = Set to VARIANT_TRUE to fully erase the disc by overwriting the entire medium at least once. Set to
    ///            VARIANT_FALSE to overwrite the directory tracks, but not the entire disc. This option requires less time to
    ///            perform than the full erase option. The default is VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT put_FullErase(short value);
    ///Determines the quality of the disc erasure.
    ///Params:
    ///    value = Is VARIANT_TRUE if the erase operation fully erases the disc by overwriting the entire medium at least once.
    ///            Is VARIANT_FALSE if the erase operation overwrites the directory tracks, but not the entire disc. This option
    ///            requires less time to perform than the full erase option.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_FullErase(short* value);
    ///Retrieves the type of media in the disc device.
    ///Params:
    ///    value = Type of media in the disc device. For possible values, see the IMAPI_MEDIA_PHYSICAL_TYPEenumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_REQUIRED</b></dt> </dl> </td> <td width="60%"> The request requires a current disc
    ///    recorder to be selected. Value: 0xC0AA0003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Pointer is not valid. <div class="alert"><b>Note</b> This value does not
    ///    indicate a <b>NULL</b> pointer.</div> <div> </div> Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The device failed to accept the
    ///    command within the timeout period. This may be caused by the device having entered an inconsistent state, or
    ///    the timeout value for the command may need to be increased. Value: 0xC0AA020D </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%">
    ///    The device reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media
    ///    is inserted upside down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT get_CurrentPhysicalMediaType(IMAPI_MEDIA_PHYSICAL_TYPE* value);
    ///Sets the friendly name of the client.
    ///Params:
    ///    value = Name of the client application.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    One or more arguments are not valid. Value: 0x80070057 </td> </tr> </table>
    ///    
    HRESULT put_ClientName(BSTR value);
    ///Retrieves the friendly name of the client.
    ///Params:
    ///    value = Name of the client application.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT get_ClientName(BSTR* value);
    ///Erases the media in the active disc recorder.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The device failed to accept the
    ///    command within the timeout period. This may be caused by the device having entered an inconsistent state, or
    ///    the timeout value for the command may need to be increased. Value: 0xC0AA020D </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%">
    ///    The device reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media
    ///    is inserted upside down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_ERASE_MEDIA_IS_NOT_SUPPORTED</b></dt> </dl> </td> <td
    ///    width="60%"> The current media type is unsupported. Value: 0xC0AA0909 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_ERASE_DRIVE_FAILED_SPINUP_COMMAND</b></dt> </dl> </td> <td width="60%"> The drive returned an
    ///    error for a START UNIT (spinup) command. Manual intervention may be required. Value: 0x80AA0908 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_ERASE_TOOK_LONGER_THAN_ONE_HOUR</b></dt> </dl> </td> <td
    ///    width="60%"> The drive did not complete the erase in one hour. The drive may require a power cycle, media
    ///    removal, or other manual intervention to resume proper operation. <div class="alert"><b>Note</b> Currently,
    ///    this value will also be returned if an attempt to perform an erase on CD-RW or DVD-RW media via the
    ///    IDiscFormat2Erase interface fails as a result of the media being bad.</div> <div> </div> Value: 0x80AA0906
    ///    </td> </tr> </table>
    ///    
    HRESULT EraseMedia();
}

///Implement this interface to receive notifications of the current erase operation.
@GUID("2735413A-7F64-5B0F-8F00-5D77AFBE261E")
interface DDiscFormat2EraseEvents : IDispatch
{
    ///Implement this method to receive progress notification of the current erase operation.
    ///Params:
    ///    object = The IDiscFormat2Erase interface that initiated the erase operation. This parameter is a
    ///             <b>MsftDiscFormat2Erase</b> object in script.
    ///    elapsedSeconds = Elapsed time, in seconds, of the erase operation.
    ///    estimatedTotalSeconds = Estimated time, in seconds, to complete the erase operation.
    ///Returns:
    ///    Return values are ignored.
    ///    
    HRESULT Update(IDispatch object, int elapsedSeconds, int estimatedTotalSeconds);
}

///Use this interface to write a data stream to a disc. To create an instance of this interface, call the
///<b>CoCreateInstance</b> function. Use__uuidof(MsftDiscFormat2Data) for the class identifier and
///__uuidof(IDiscFormat2Data) for the interface identifier.
@GUID("27354153-9F64-5B0F-8F00-5D77AFBE261E")
interface IDiscFormat2Data : IDiscFormat2
{
    ///Sets the recording device to use for the write operation.
    ///Params:
    ///    value = An IDiscRecorder2 interface that identifies the recording device to use in the write operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2DATA_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> There is currently a write
    ///    operation in progress. Value: 0xC0AA0400 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2DATA_RECORDER_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This device does not
    ///    support the operations required by this disc format. Value: 0xC0AA0407 </td> </tr> </table>
    ///    
    HRESULT put_Recorder(IDiscRecorder2 value);
    ///Retrieves the recording device to use for the write operation.
    ///Params:
    ///    value = An IDiscRecorder2 interface that identifies the recording device to use in the write operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Recorder(IDiscRecorder2* value);
    ///Determines if Buffer Underrun Free recording is enabled. <div class="alert"><b>Note</b> This method is only
    ///applicable to CDR/RW and DVD+/-R media formats.</div> <div> </div>
    ///Params:
    ///    value = Set to VARIANT_TRUE to disable Buffer Underrun Free recording; otherwise, VARIANT_FALSE. The default is
    ///            VARIANT_FALSE (enabled).
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2DATA_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> There is currently a write
    ///    operation in progress. Value: 0xC0AA0400 </td> </tr> </table>
    ///    
    HRESULT put_BufferUnderrunFreeDisabled(short value);
    ///Determines if Buffer Underrun Free recording is enabled for CDR, CD-RW, and DVD-R media.
    ///Params:
    ///    value = Is VARIANT_TRUE if Buffer Underrun Free recording is disabled; otherwise, VARIANT_FALSE (enabled).
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_BufferUnderrunFreeDisabled(short* value);
    ///Determines if the data stream contains post-writing gaps.
    ///Params:
    ///    value = Set to VARIANT_TRUE if the data stream contains post-writing gaps; otherwise, VARIANT_FALSE. The default is
    ///            VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2DATA_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> There is currently a write
    ///    operation in progress. Value: 0xC0AA0400 </td> </tr> </table>
    ///    
    HRESULT put_PostgapAlreadyInImage(short value);
    ///Determines if the data stream contains post-writing gaps.
    ///Params:
    ///    value = Is VARIANT_TRUE if the data stream contains post-writing gaps; otherwise, VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_PostgapAlreadyInImage(short* value);
    ///Retrieves the current state of the media in the device.
    ///Params:
    ///    value = State of the media in the disc device. For possible values, see the IMAPI_FORMAT2_DATA_MEDIA_STATE
    ///            enumeration type. Note that more than one state can be set.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT get_CurrentMediaStatus(IMAPI_FORMAT2_DATA_MEDIA_STATE* value);
    ///Retrieves the current write protect state of the media in the device.
    ///Params:
    ///    value = The current write protect state of the media in the device. For possible values, see the
    ///            IMAPI_MEDIA_WRITE_PROTECT_STATE enumeration type. Note that more than one state can be set.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT get_WriteProtectStatus(IMAPI_MEDIA_WRITE_PROTECT_STATE* value);
    ///Retrieves the number of sectors on the media in the device.
    ///Params:
    ///    value = Number of sectors on the media in the device. The number includes free sectors, used sectors, and the boot
    ///            sector.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2DATA_INVALID_MEDIA_STATE</b></dt> </dl> </td> <td
    ///    width="60%"> The requested operation is only valid with supported media. Value: 0xC0AA0402 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_TotalSectorsOnMedia(int* value);
    ///Retrieves the number of free sectors on the disc for incremental recording (without overwriting existing
    ///data).<div class="alert"><b>Note</b> When this method is called for DVD-/+RW, DVD-RAM, and BD-RE media, the
    ///reported free sector <i>value</i> represents total capacity, rather than the current number of free sectors. To
    ///retrieve free sectors for these media types, the file system must be imported via
    ///IFileSystemImage::ImportFileSystem or IFileSystemImage::ImportSpecificFileSystem, which will allow the use of the
    ///IFileSystemImage::get_FreeMediaBlocks method to retrieve the value.</div> <div> </div>
    ///Params:
    ///    value = Number of free sectors on the media in the device.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2DATA_INVALID_MEDIA_STATE</b></dt> </dl> </td> <td
    ///    width="60%"> The requested operation is only valid with supported media. Value: 0xC0AA0402 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_FreeSectorsOnMedia(int* value);
    ///Retrieves the location for the next write operation.
    ///Params:
    ///    value = Address where the next write operation begins.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2DATA_INVALID_MEDIA_STATE</b></dt> </dl> </td> <td
    ///    width="60%"> The requested operation is only valid with supported media. Value: 0xC0AA0402 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_NextWritableAddress(int* value);
    ///Retrieves the first sector of the previous write session.
    ///Params:
    ///    value = Address where the previous write operation began. The value is -1 if the media is blank or does not support
    ///            multi-session writing (indicates that no previous session could be detected).
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2DATA_INVALID_MEDIA_STATE</b></dt> </dl> </td> <td
    ///    width="60%"> The requested operation is only valid with supported media. Value: 0xC0AA0402 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_StartAddressOfPreviousSession(int* value);
    ///Retrieves the last sector of the previous write session.
    ///Params:
    ///    value = Address where the previous write operation ended. The value is -1 if the media is blank or does not support
    ///            multi-session writing (indicates that no previous session could be detected).
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> Not implemented. Value: 0x80004001 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_LastWrittenAddressOfPreviousSession(int* value);
    ///Determines if further additions to the file system are prevented.
    ///Params:
    ///    value = Set to VARIANT_TRUE to mark the disc as closed to prohibit additional writes when the next write session
    ///            ends. Set to VARIANT_FALSE to keep the disc open for subsequent write sessions. The default is VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2DATA_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> There is currently a write
    ///    operation in progress. Value: 0xC0AA0400 </td> </tr> </table>
    ///    
    HRESULT put_ForceMediaToBeClosed(short value);
    ///Determines if further additions to the file system are prevented.
    ///Params:
    ///    value = Is VARIANT_TRUE if the next write session ends by marking the disc as closed to subsequent write sessions.
    ///            Otherwise, VARIANT_FALSE to keep the disc open for subsequent write sessions.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_ForceMediaToBeClosed(short* value);
    ///Determines if a DVD recording session includes tasks that can increase the chance that a device can play the DVD.
    ///Params:
    ///    value = Set to VARIANT_TRUE to skip the tasks that allow the disc to play on more consumer devices. Removing
    ///            compatibility reduces the recording session time and the need for less free space on disc. Set to
    ///            VARIANT_FALSE to increase the chance that a device can play the DVD. The default is VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2DATA_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> There is currently a write
    ///    operation in progress. Value: 0xC0AA0400 </td> </tr> </table>
    ///    
    HRESULT put_DisableConsumerDvdCompatibilityMode(short value);
    ///Determines if a DVD recording session includes tasks that can increase the chance that a device can play the DVD.
    ///Params:
    ///    value = Is VARIANT_TRUE if the session skips the tasks that allow the disc to play on more consumer devices Is
    ///            VARIANT_FALSE if the media will be written to maximize read compatibility with consumer devices.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_DisableConsumerDvdCompatibilityMode(short* value);
    ///Retrieves the type of media in the disc device.
    ///Params:
    ///    value = Type of media in the disc device. For possible values, see the IMAPI_MEDIA_PHYSICAL_TYPEenumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_REQUIRED</b></dt> </dl> </td> <td width="60%"> The request requires a current disc
    ///    recorder to be selected. Value: 0xC0AA0003 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. <div class="alert"><b>Note</b> This value does not indicate a <b>NULL</b>
    ///    pointer.</div> <div> </div> Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt>
    ///    </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT get_CurrentPhysicalMediaType(IMAPI_MEDIA_PHYSICAL_TYPE* value);
    ///Sets the friendly name of the client.
    ///Params:
    ///    value = Name of the client application. Cannot be <b>NULL</b> or an empty string.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2DATA_CLIENT_NAME_IS_NOT_VALID</b></dt>
    ///    </dl> </td> <td width="60%"> The client name is not valid. Value: 0xC0AA0211 </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_DF2DATA_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> There is
    ///    currently a write operation in progress. Value: 0xC0AA0500 </td> </tr> </table>
    ///    
    HRESULT put_ClientName(BSTR value);
    ///Retrieves the friendly name of the client.
    ///Params:
    ///    value = Name of the client application.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT get_ClientName(BSTR* value);
    ///Retrieves the requested write speed.
    ///Params:
    ///    value = Requested write speed measured in disc sectors per second. A value of 0xFFFFFFFF (-1) requests that the write
    ///            occurs using the fastest supported speed for the media.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_RequestedWriteSpeed(int* value);
    ///Retrieves the requested rotational-speed control type.
    ///Params:
    ///    value = Requested rotational-speed control type. Is VARIANT_TRUE for constant angular velocity (CAV) rotational-speed
    ///            control type. Otherwise, is VARIANT_FALSE for any other rotational-speed control type that the recorder
    ///            supports.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_RequestedRotationTypeIsPureCAV(short* value);
    ///Retrieves the drive's current write speed.
    ///Params:
    ///    value = The write speed of the current media, measured in sectors per second.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_REQUIRED</b></dt> </dl> </td> <td width="60%"> The request requires a current disc
    ///    recorder to be selected. Value: 0xC0AA0003 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_UNEXPECTED_RESPONSE_FROM_DEVICE</b></dt> </dl> </td>
    ///    <td width="60%"> The write failed because the drive returned error information that could not be recovered
    ///    from. Value: 0xC0AA0301 </td> </tr> </table>
    ///    
    HRESULT get_CurrentWriteSpeed(int* value);
    ///Retrieves the current rotational-speed control used by the recorder.
    ///Params:
    ///    value = Is VARIANT_TRUE if constant angular velocity (CAV) rotational-speed control is in use. Otherwise,
    ///            VARIANT_FALSE to indicate that another rotational-speed control that the recorder supports is in use.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_REQUIRED</b></dt> </dl> </td> <td width="60%"> The request requires a current disc
    ///    recorder to be selected. Value: 0xC0AA0003 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT get_CurrentRotationTypeIsPureCAV(short* value);
    ///Retrieves a list of the write speeds supported by the disc recorder and current media.
    ///Params:
    ///    supportedSpeeds = List of the write speeds supported by the disc recorder and current media. Each element of the array is a
    ///                      <b>VARIANT</b> of type <b>VT_UI4</b>. The <b>ulVal</b> member of the variant contains the number of sectors
    ///                      written per second.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_REQUIRED</b></dt> </dl> </td> <td width="60%"> The request requires a current disc
    ///    recorder to be selected. Value: 0xC0AA0003 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. <div class="alert"><b>Note</b> This value does not indicate a <b>NULL</b>
    ///    pointer.</div> <div> </div> Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt>
    ///    </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_UNEXPECTED_RESPONSE_FROM_DEVICE</b></dt> </dl> </td>
    ///    <td width="60%"> The write failed because the drive returned error information that could not be recovered
    ///    from. Value: 0xC0AA0301 </td> </tr> </table>
    ///    
    HRESULT get_SupportedWriteSpeeds(SAFEARRAY** supportedSpeeds);
    ///Retrieves a list of the detailed write configurations supported by the disc recorder and current media.
    ///Params:
    ///    supportedSpeedDescriptors = List of the detailed write configurations supported by the disc recorder and current media. Each element of
    ///                                the array is a <b>VARIANT</b> of type <b>VT_Dispatch</b>. Query the <b>pdispVal</b> member of the variant for
    ///                                the IWriteSpeedDescriptor interface, which contains the media type, write speed, rotational-speed control
    ///                                type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_REQUIRED</b></dt> </dl> </td> <td width="60%"> The request requires a current disc
    ///    recorder to be selected. Value: 0xC0AA0003 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. <div class="alert"><b>Note</b> This value does not indicate a <b>NULL</b>
    ///    pointer.</div> <div> </div> Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt>
    ///    </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_UNEXPECTED_RESPONSE_FROM_DEVICE</b></dt> </dl> </td>
    ///    <td width="60%"> The write failed because the drive returned error information that could not be recovered
    ///    from. Value: 0xC0AA0301 </td> </tr> </table>
    ///    
    HRESULT get_SupportedWriteSpeedDescriptors(SAFEARRAY** supportedSpeedDescriptors);
    ///Determines if the data writer must overwrite the disc on overwritable media types.
    ///Params:
    ///    value = Is VARIANT_TRUE if the data writer must overwrite the disc on overwritable media types; otherwise,
    ///            VARIANT_FALSE. The default is VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT put_ForceOverwrite(short value);
    ///Determines if the data writer must overwrite the disc on overwritable media types.
    ///Params:
    ///    value = Is VARIANT_TRUE if the data writer must overwrite the disc on overwritable media types; otherwise,
    ///            VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_ForceOverwrite(short* value);
    ///Retrieves a list of available multi-session interfaces.
    ///Params:
    ///    value = List of available multi-session interfaces. Each element of the array is a <b>VARIANT</b> of type
    ///            <b>VT_DISPATCH</b>. Query the <b>pdispVal</b> member of the variant for any interface that inherits from
    ///            IMultisession interface, for example, IMultisessionSequential.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> </table> <div class="alert"><b>Note</b> This method does not
    ///    return an error when called on blank optical media.</div> <div> </div>
    ///    
    HRESULT get_MultisessionInterfaces(SAFEARRAY** value);
    ///Writes the data stream to the device.<div class="alert"><b>Note</b> For write success, the size of the passed-in
    ///stream must be a multiple of the sector size, 2048. This includes operations that utilize streams associated with
    ///.iso images not created by IMAPI.</div> <div> </div>
    ///Params:
    ///    data = An <b>IStream</b> interface of the data stream to write.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The device failed to accept the
    ///    command within the timeout period. This may be caused by the device having entered an inconsistent state, or
    ///    the timeout value for the command may need to be increased. Value: 0xC0AA020D </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%">
    ///    The device reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media
    ///    is inserted upside down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_UNEXPECTED_RESPONSE_FROM_DEVICE</b></dt> </dl> </td>
    ///    <td width="60%"> The write failed because the drive returned error information that could not be recovered
    ///    from. Value: 0xC0AA0301 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_REQUIRED</b></dt>
    ///    </dl> </td> <td width="60%"> The request requires a current disc recorder to be selected. Value: 0xC0AA0003
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_IMAPI_ROTATIONADJUSTED</b></dt> </dl> </td> <td width="60%">
    ///    The requested rotation type was not supported by the drive and the rotation type was adjusted. Value:
    ///    0x00AA0005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_IMAPI_SPEEDADJUSTED</b></dt> </dl> </td> <td
    ///    width="60%"> The requested write speed was not supported by the drive and the speed was adjusted. Value:
    ///    0x00AA0004 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_IMAPI_BOTHADJUSTED</b></dt> </dl> </td> <td
    ///    width="60%"> The requested write speed and rotation type were not supported by the drive and they were both
    ///    adjusted. Value: 0x00AA0006 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2DATA_RECORDER_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This device does not
    ///    support the operations required by this disc format. Value: 0xC0AA0407 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_REQUEST_CANCELLED</b></dt> </dl> </td> <td width="60%"> The request was canceled. Value:
    ///    0xC0AA0002 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2DATA_WRITE_IN_PROGRESS</b></dt> </dl>
    ///    </td> <td width="60%"> There is currently a write operation in progress. Value: 0xC0AA0400 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_DF2DATA_STREAM_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The
    ///    size of the provided <b>IStream</b> object is invalid. The size must be a multiple of the sector size, 2048.
    ///    Value: 0xC0AA0403 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2DATA_MEDIA_IS_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The current media type is
    ///    unsupported. Value: (HRESULT)0xC0AA0406 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> One or more arguments are not valid. Value: 0x80070057 </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value:
    ///    0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%">
    ///    Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
    ///    </dl> </td> <td width="60%"> Failed to allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> Not implemented. Value: 0x80004001
    ///    </td> </tr> </table>
    ///    
    HRESULT Write(IStream data);
    ///Cancels the current write operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2DATA_WRITE_NOT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> There is no write
    ///    operation currently in progress. Value: 0xC0AA0401 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr>
    ///    </table>
    ///    
    HRESULT CancelWrite();
    ///Sets the write speed of the disc recorder.
    ///Params:
    ///    RequestedSectorsPerSecond = Requested write speed measured in disc sectors per second. A value of 0xFFFFFFFF (-1) requests that the write
    ///                                occurs using the fastest supported speed for the media. This is the default.
    ///    RotationTypeIsPureCAV = Requested rotational-speed control type. Set to VARIANT_TRUE to request constant angular velocity (CAV)
    ///                            rotational-speed control type. Set to VARIANT_FALSE to use another rotational-speed control type that the
    ///                            recorder supports. The default is VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_REQUIRED</b></dt> </dl> </td> <td width="60%"> The request requires a current disc
    ///    recorder to be selected. Value: 0xC0AA0003 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_UNEXPECTED_RESPONSE_FROM_DEVICE</b></dt> </dl> </td>
    ///    <td width="60%"> The write failed because the drive returned error information that could not be recovered
    ///    from. Value: 0xC0AA0301 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_IMAPI_ROTATIONADJUSTED</b></dt> </dl>
    ///    </td> <td width="60%"> The requested rotation type was not supported by the drive and the rotation type was
    ///    adjusted. Value: 0x00AA0005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_IMAPI_SPEEDADJUSTED</b></dt>
    ///    </dl> </td> <td width="60%"> The requested write speed was not supported by the drive and the speed was
    ///    adjusted. Value: 0x00AA0004 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_IMAPI_BOTHADJUSTED</b></dt> </dl>
    ///    </td> <td width="60%"> The requested write speed and rotation type were not supported by the drive and they
    ///    were both adjusted. Value: 0x00AA0006 </td> </tr> </table>
    ///    
    HRESULT SetWriteSpeed(int RequestedSectorsPerSecond, short RotationTypeIsPureCAV);
}

///Implement this interface to receive notifications of the current write operation.
@GUID("2735413C-7F64-5B0F-8F00-5D77AFBE261E")
interface DDiscFormat2DataEvents : IDispatch
{
    ///Implement this method to receive progress notification of the current write operation.
    ///Params:
    ///    object = The IDiscFormat2Data interface that initiated the write operation. This parameter is a
    ///             <b>MsftDiscFormat2Data</b> object in script.
    ///    progress = An IDiscFormat2DataEventArgs interface that you use to determine the progress of the write operation. This
    ///               parameter is a <b>MsftDiscFormat2Data</b> object in script.
    ///Returns:
    ///    Return values are ignored.
    ///    
    HRESULT Update(IDispatch object, IDispatch progress);
}

///Use this interface to retrieve information about the current write operation. This interface is passed to the
///DDiscFormat2DataEvents::Update method that you implement.
@GUID("2735413D-7F64-5B0F-8F00-5D77AFBE261E")
interface IDiscFormat2DataEventArgs : IWriteEngine2EventArgs
{
    ///Retrieves the total elapsed time of the write operation.
    ///Params:
    ///    value = Elapsed time, in seconds, of the write operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_ElapsedTime(int* value);
    ///Retrieves the estimated remaining time of the write operation.
    ///Params:
    ///    value = Estimated time, in seconds, needed for the remainder of the write operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_RemainingTime(int* value);
    ///Retrieves the estimated total time for write operation.
    ///Params:
    ///    value = Estimated time, in seconds, for write operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_TotalTime(int* value);
    ///Retrieves the current write action being performed.
    ///Params:
    ///    value = Current write action being performed. For a list of possible actions, see the IMAPI_FORMAT2_DATA_WRITE_ACTION
    ///            enumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_CurrentAction(IMAPI_FORMAT2_DATA_WRITE_ACTION* value);
}

///Use this interface to write audio to blank CD-R or CD-RW media in Track-At-Once mode. To create an instance of this
///interface, call the <b>CoCreateInstance</b> function. Use__uuidof(MsftDiscFormat2TrackAtOnce) for the class
///identifier and __uuidof(IDiscFormat2TrackAtOnce) for the interface identifier.
@GUID("27354154-8F64-5B0F-8F00-5D77AFBE261E")
interface IDiscFormat2TrackAtOnce : IDiscFormat2
{
    ///Locks the current media for exclusive access.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_NO_RECORDER_SPECIFIED</b></dt> </dl> </td> <td width="60%"> You cannot prepare the
    ///    media until you choose a recorder to use. Value: 0xC0AA050A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_MEDIA_IS_PREPARED</b></dt> </dl> </td> <td width="60%"> The requested operation is not
    ///    valid when media has been "prepared" but not released. Value: 0xC0AA0503 </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2TAO_MEDIA_IS_NOT_SUPPORTED</b></dt> </dl> </td> <td
    ///    width="60%"> Only blank CD-R/RW media is supported. Value: 0xC0AA0507 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_MEDIA_IS_NOT_BLANK</b></dt> </dl> </td> <td width="60%"> Only blank CD-R/RW media is
    ///    supported. Value: 0xC0AA0506 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_CLIENT_NAME_IS_NOT_VALID</b></dt> </dl> </td> <td width="60%"> The client name is not
    ///    valid. Value: 0xC0AA050F </td> </tr> </table>
    ///    
    HRESULT PrepareMedia();
    ///Writes the data stream to the current media as a new track.
    ///Params:
    ///    data = An <b>IStream</b> interface of the audio data to write as the next track on the media. The data format
    ///           contains 44.1KHz, 16-bit stereo, raw audio samples. This is the same format used by the audio samples in a
    ///           Microsoft WAV audio file (without the header).
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2TAO_MEDIA_IS_NOT_PREPARED</b></dt> </dl> </td> <td width="60%">
    ///    The requested operation is only valid when media has been "prepared". Value: 0xC0AA0502 </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_DF2TAO_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> There is
    ///    currently a write operation in progress. Value: 0xC0AA0500 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_TRACK_LIMIT_REACHED</b></dt> </dl> </td> <td width="60%"> CD-R and CD-RW media support
    ///    a maximum of 99 audio tracks. Value: 0xC0AA0508 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_STREAM_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The provided audio stream is
    ///    not valid. Value: 0xC0AA050D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_NOT_ENOUGH_SPACE</b></dt> </dl> </td> <td width="60%"> There is not enough space left
    ///    on the media to add the provided audio track. Value: 0xC0AA0509 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not
    ///    valid. Value: 0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Failed to allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The device failed to accept the
    ///    command within the timeout period. This may be caused by the device having entered an inconsistent state, or
    ///    the timeout value for the command may need to be increased. Value: 0xC0AA020D </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%">
    ///    The device reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media
    ///    is inserted upside down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_REQUEST_CANCELLED</b></dt> </dl> </td> <td width="60%">
    ///    The request was canceled. Value: 0xC0AA0002 </td> </tr> </table>
    ///    
    HRESULT AddAudioTrack(IStream data);
    ///Cancels the current write operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_WRITE_NOT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> There is no write operation
    ///    currently in progress. Value: 0xC0AA0501 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> </table>
    ///    
    HRESULT CancelAddTrack();
    ///Closes the track-writing session and releases the lock.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> A write operation is in
    ///    progress. Value: 0xC0AA0500 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_MEDIA_IS_PREPARED</b></dt> </dl> </td> <td width="60%"> The requested operation is not
    ///    valid when media has been "prepared" but not released. Value: 0xC0AA0503 </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT ReleaseMedia();
    ///Sets the write speed of the disc recorder.
    ///Params:
    ///    RequestedSectorsPerSecond = Requested write speed measured in disc sectors per second. A value of 0xFFFFFFFF (-1) requests that the write
    ///                                occurs using the fastest supported speed for the media. This is the default.
    ///    RotationTypeIsPureCAV = Requested rotational-speed control type. Set to VARIANT_TRUE to request constant angular velocity (CAV)
    ///                            rotational-speed control type. Set to VARIANT_FALSE to use another rotational-speed control type that the
    ///                            recorder supports. The default is VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_REQUIRED</b></dt> </dl> </td> <td width="60%"> The request requires a current disc
    ///    recorder to be selected. Value: 0xC0AA0003 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_UNEXPECTED_RESPONSE_FROM_DEVICE</b></dt> </dl> </td>
    ///    <td width="60%"> The write failed because the drive returned error information that could not be recovered
    ///    from. Value: 0xC0AA0301 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_IMAPI_ROTATIONADJUSTED</b></dt> </dl>
    ///    </td> <td width="60%"> The requested rotation type was not supported by the drive and the rotation type was
    ///    adjusted. Value: 0x00AA0005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_IMAPI_SPEEDADJUSTED</b></dt>
    ///    </dl> </td> <td width="60%"> The requested write speed was not supported by the drive and the speed was
    ///    adjusted. Value: 0x00AA0004 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_IMAPI_BOTHADJUSTED</b></dt> </dl>
    ///    </td> <td width="60%"> The requested write speed and rotation type were not supported by the drive and they
    ///    were both adjusted. Value: 0x00AA0006 </td> </tr> </table>
    ///    
    HRESULT SetWriteSpeed(int RequestedSectorsPerSecond, short RotationTypeIsPureCAV);
    ///Sets the recording device to use for the write operation.
    ///Params:
    ///    value = An IDiscRecorder2 interface that identifies the recording device to use in the write operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> A write operation is in
    ///    progress. Value: 0xC0AA0500 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_MEDIA_IS_PREPARED</b></dt> </dl> </td> <td width="60%"> The requested operation is not
    ///    valid when media has been "prepared" but not released. Value: 0xC0AA0503 </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_IMAPI_DF2TAO_RECORDER_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This device does not
    ///    support the operations required by this disc format. Value: 0xC0AA050E </td> </tr> </table>
    ///    
    HRESULT put_Recorder(IDiscRecorder2 value);
    ///Retrieves the recording device to use for the write operation.
    ///Params:
    ///    value = An IDiscRecorder2 interface that identifies the recording device to use in the write operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Recorder(IDiscRecorder2* value);
    ///Determines if Buffer Underrun Free Recording is enabled.
    ///Params:
    ///    value = Set to VARIANT_TRUE to disable Buffer Underrun Free Recording; otherwise, VARIANT_FALSE. The default is
    ///            VARIANT_FALSE (enabled).
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_MEDIA_IS_NOT_PREPARED</b></dt> </dl> </td> <td width="60%"> The media is not prepared
    ///    (IDiscFormat2TrackAtOnce::PrepareMedia has not been called). Value: 0xC0AA0502 </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_DF2TAO_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> A write
    ///    operation is in progress. Value: 0xC0AA0500 </td> </tr> </table>
    ///    
    HRESULT put_BufferUnderrunFreeDisabled(short value);
    ///Determines if Buffer Underrun Free recording is enabled.
    ///Params:
    ///    value = Is VARIANT_TRUE if Buffer Underrun Free recording is disabled; otherwise, VARIANT_FALSE (enabled).
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_BufferUnderrunFreeDisabled(short* value);
    ///Retrieves the number of existing audio tracks on the media.
    ///Params:
    ///    value = Number of completed tracks written to disc, not including the track currently being added.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2TAO_MEDIA_IS_NOT_PREPARED</b></dt> </dl> </td> <td width="60%">
    ///    The media is not prepared (IDiscFormat2TrackAtOnce::PrepareMedia has not been called). Value: 0xC0AA0502
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2TAO_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td
    ///    width="60%"> A write operation is in progress. Value: 0xC0AA0500 </td> </tr> </table>
    ///    
    HRESULT get_NumberOfExistingTracks(int* value);
    ///Retrieves the total sectors available on the media if writing one continuous audio track.
    ///Params:
    ///    value = Number of all sectors on the media that can be used for audio if one continuous audio track was recorded.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2TAO_MEDIA_IS_NOT_PREPARED</b></dt> </dl> </td> <td width="60%">
    ///    The media is not prepared (IDiscFormat2TrackAtOnce::PrepareMedia has not been called). Value: 0xC0AA0502
    ///    </td> </tr> </table>
    ///    
    HRESULT get_TotalSectorsOnMedia(int* value);
    ///Retrieves the number of sectors available for adding a new track to the media.
    ///Params:
    ///    value = Number of available sectors on the media that can be used for writing audio.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2TAO_MEDIA_IS_NOT_PREPARED</b></dt> </dl> </td> <td width="60%">
    ///    The media is not prepared (IDiscFormat2TrackAtOnce::PrepareMedia has not been called). Value: 0xC0AA0502
    ///    </td> </tr> </table>
    ///    
    HRESULT get_FreeSectorsOnMedia(int* value);
    ///Retrieves the total number of used sectors on the media.
    ///Params:
    ///    value = Number of used sectors on the media, including audio tracks and overhead that exists between tracks.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2TAO_MEDIA_IS_NOT_PREPARED</b></dt> </dl> </td> <td width="60%">
    ///    The media is not prepared (IDiscFormat2TrackAtOnce::PrepareMedia has not been called). Value: 0xC0AA0502
    ///    </td> </tr> </table>
    ///    
    HRESULT get_UsedSectorsOnMedia(int* value);
    ///Determines if the media is left open for writing after writing the audio track.
    ///Params:
    ///    value = Set to VARIANT_TRUE to leave the media open for writing after writing the audio track; otherwise,
    ///            VARIANT_FALSE. The default is VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> A write operation is in
    ///    progress. Value: 0xC0AA0500 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_MEDIA_IS_PREPARED</b></dt> </dl> </td> <td width="60%"> The requested operation is not
    ///    valid when media has been "prepared" but not released. Value: 0xC0AA0503 </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_IMAPI_DF2TAO_PROPERTY_FOR_BLANK_MEDIA_ONLY</b></dt> </dl> </td> <td width="60%"> The property
    ///    cannot be changed once the media has been written to. Value: 0xC0AA0504 </td> </tr> </table>
    ///    
    HRESULT put_DoNotFinalizeMedia(short value);
    ///Determines if the media is left open for writing after writing the audio track.
    ///Params:
    ///    value = Is VARIANT_TRUE if the media is left open for writing after writing the audio track; otherwise,
    ///            VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_DoNotFinalizeMedia(short* value);
    ///Retrieves the table of content for the audio tracks that were laid on the media within the track-writing session.
    ///Params:
    ///    value = Table of contents for the audio tracks that were laid on the media within the track-writing session. Each
    ///            element of the list is a <b>VARIANT</b> of type <b>VT_BYREF|VT_UI1</b>. The <b>pbVal</b> member of the
    ///            variant contains a binary blob. For details of the blob, see the READ TOC command at
    ///            ftp://ftp.t10.org/t10/drafts/mmc5/mmc5r03.pdf.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2TAO_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> A
    ///    write operation is in progress. Value: 0xC0AA0500 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_MEDIA_IS_NOT_PREPARED</b></dt> </dl> </td> <td width="60%"> The media is not prepared
    ///    (IDiscFormat2TrackAtOnce::PrepareMedia has not been called). Value: 0xC0AA0502 </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_DF2TAO_TABLE_OF_CONTENTS_EMPTY_DISC</b></dt> </dl> </td> <td width="60%">
    ///    The media is blank. Value: 0xC0AA0505 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
    ///    </dl> </td> <td width="60%"> Failed to allocate the required memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT get_ExpectedTableOfContents(SAFEARRAY** value);
    ///Retrieves the type of media in the disc device.
    ///Params:
    ///    value = Type of media in the disc device. For possible values, see the IMAPI_MEDIA_PHYSICAL_TYPEenumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_NO_RECORDER_SPECIFIED</b></dt> </dl> </td> <td width="60%"> You cannot prepare the
    ///    media until you choose a recorder to use. Value: 0xC0AA050A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT get_CurrentPhysicalMediaType(IMAPI_MEDIA_PHYSICAL_TYPE* value);
    ///Sets the friendly name of the client.
    ///Params:
    ///    value = Name of the client application.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2TAO_CLIENT_NAME_IS_NOT_VALID</b></dt>
    ///    </dl> </td> <td width="60%"> The client name is not valid. Value: 0xC0AA050F </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_DF2TAO_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> A write
    ///    operation is in progress. Value: 0xC0AA0500 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_MEDIA_IS_PREPARED</b></dt> </dl> </td> <td width="60%"> The requested operation is not
    ///    valid when media has been "prepared" but not released. Value: 0xC0AA0503 </td> </tr> </table>
    ///    
    HRESULT put_ClientName(BSTR value);
    ///Retrieves the friendly name of the client.
    ///Params:
    ///    value = Name supplied by the client application.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT get_ClientName(BSTR* value);
    ///Retrieves the requested write speed.
    ///Params:
    ///    value = Requested write speed measured in disc sectors per second. A value of 0xFFFFFFFF (-1) requests that the write
    ///            occurs using the fastest supported speed for the media.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_RequestedWriteSpeed(int* value);
    ///Retrieves the requested rotational-speed control type.
    ///Params:
    ///    value = Requested rotational-speed control type. Is VARIANT_TRUE for constant angular velocity (CAV) rotational-speed
    ///            control type. Otherwise, is VARIANT_FALSE for any other rotational-speed control type that the recorder
    ///            supports.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_RequestedRotationTypeIsPureCAV(short* value);
    ///Retrieves the drive's current write speed.
    ///Params:
    ///    value = The write speed of the current media, measured in sectors per second.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_NO_RECORDER_SPECIFIED</b></dt> </dl> </td> <td width="60%"> You cannot prepare the
    ///    media until you choose a recorder to use. Value: 0xC0AA050A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_UNEXPECTED_RESPONSE_FROM_DEVICE</b></dt> </dl> </td>
    ///    <td width="60%"> The write failed because the drive returned error information that could not be recovered
    ///    from. Value: 0xC0AA0301 </td> </tr> </table>
    ///    
    HRESULT get_CurrentWriteSpeed(int* value);
    ///Retrieves the current rotational-speed control used by the recorder.
    ///Params:
    ///    value = Is VARIANT_TRUE if constant angular velocity (CAV) rotational-speed control is in use. Otherwise,
    ///            VARIANT_FALSE to indicate that another rotational-speed control that the recorder supports is in use.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_NO_RECORDER_SPECIFIED</b></dt> </dl> </td> <td width="60%"> You cannot prepare the
    ///    media until you choose a recorder to use. Value: 0xC0AA050A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_UNEXPECTED_RESPONSE_FROM_DEVICE</b></dt> </dl> </td>
    ///    <td width="60%"> The write failed because the drive returned error information that could not be recovered
    ///    from. Value: 0xC0AA0301 </td> </tr> </table>
    ///    
    HRESULT get_CurrentRotationTypeIsPureCAV(short* value);
    ///Retrieves a list of the write speeds supported by the disc recorder and current media.
    ///Params:
    ///    supportedSpeeds = List of the write speeds supported by the disc recorder and current media. Each element of the list is a
    ///                      <b>VARIANT</b> of type <b>VT_UI4</b>. The <b>ulVal</b> member of the variant contains the number of sectors
    ///                      written per second.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_NO_RECORDER_SPECIFIED</b></dt> </dl> </td> <td width="60%"> You cannot prepare the
    ///    media until you choose a recorder to use. Value: 0xC0AA050A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_UNEXPECTED_RESPONSE_FROM_DEVICE</b></dt> </dl> </td>
    ///    <td width="60%"> The write failed because the drive returned error information that could not be recovered
    ///    from. Value: 0xC0AA0301 </td> </tr> </table>
    ///    
    HRESULT get_SupportedWriteSpeeds(SAFEARRAY** supportedSpeeds);
    ///Retrieves a list of the detailed write configurations supported by the disc recorder and current media.
    ///Params:
    ///    supportedSpeedDescriptors = List of the detailed write configurations supported by the disc recorder and current media. Each element of
    ///                                the list is a <b>VARIANT</b> of type <b>VT_Dispatch</b>. Query the <b>pdispVal</b> member of the variant for
    ///                                the IWriteSpeedDescriptor interface, which contains the media type, write speed, rotational-speed control
    ///                                type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2TAO_NO_RECORDER_SPECIFIED</b></dt> </dl> </td> <td width="60%"> You cannot prepare the
    ///    media until you choose a recorder to use. Value: 0xC0AA050A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_UNEXPECTED_RESPONSE_FROM_DEVICE</b></dt> </dl> </td>
    ///    <td width="60%"> The write failed because the drive returned error information that could not be recovered
    ///    from. Value: 0xC0AA0301 </td> </tr> </table>
    ///    
    HRESULT get_SupportedWriteSpeedDescriptors(SAFEARRAY** supportedSpeedDescriptors);
}

///Implement this interface to receive notifications of the current track-writing operation.
@GUID("2735413F-7F64-5B0F-8F00-5D77AFBE261E")
interface DDiscFormat2TrackAtOnceEvents : IDispatch
{
    ///Implement this method to receive progress notification of the current track-writing operation.
    ///Params:
    ///    object = The IDiscFormat2TrackAtOnce interface that initiated the write operation. This parameter is a
    ///             <b>MsftDiscFormat2TrackAtOnce</b> object in script.
    ///    progress = An IDiscFormat2TrackAtOnceEventArgs interface that you use to determine the progress of the write operation.
    ///               This parameter is a <b>MsftDiscFormat2TrackAtOnce</b> object in script.
    ///Returns:
    ///    Return values are ignored.
    ///    
    HRESULT Update(IDispatch object, IDispatch progress);
}

///Use this interface to retrieve information about the current write operation. This interface is passed to the
///DDiscFormat2TrackAtOnceEvents::Update method that you implement.
@GUID("27354140-7F64-5B0F-8F00-5D77AFBE261E")
interface IDiscFormat2TrackAtOnceEventArgs : IWriteEngine2EventArgs
{
    ///Retrieves the current track number being written to the media.
    ///Params:
    ///    value = Track number, ranging from 1 through 99.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_CurrentTrackNumber(int* value);
    ///Retrieves the current write action being performed.
    ///Params:
    ///    value = Current write action being performed. For a list of possible actions, see the IMAPI_FORMAT2_TAO_WRITE_ACTION
    ///            enumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_CurrentAction(IMAPI_FORMAT2_TAO_WRITE_ACTION* value);
    ///Retrieves the total elapsed time of the write operation.
    ///Params:
    ///    value = Elapsed time, in seconds, of the write operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_ElapsedTime(int* value);
    ///Retrieves the estimated remaining time of the write operation.
    ///Params:
    ///    value = Estimated time, in seconds, needed for the remainder of the write operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_RemainingTime(int* value);
}

///Use this interface to write raw images to a disc device using Disc At Once (DAO) mode (also known as uninterrupted
///recording). For information on DAO mode, see the latest revision of the MMC specification at
///ftp://ftp.t10.org/t10/drafts/mmc5. To create an instance of this interface, call the <b>CoCreateInstance</b>
///function. Use__uuidof(MsftDiscFormat2RawCD) for the class identifier and __uuidof(IDiscFormat2RawCD) for the
///interface identifier.
@GUID("27354155-8F64-5B0F-8F00-5D77AFBE261E")
interface IDiscFormat2RawCD : IDiscFormat2
{
    ///Locks the current media for exclusive access.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_NO_RECORDER_SPECIFIED</b></dt> </dl> </td> <td width="60%"> You cannot prepare the
    ///    media until you choose a recorder to use. Value: 0xC0AA060A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_MEDIA_IS_PREPARED</b></dt> </dl> </td> <td width="60%"> The requested operation is not
    ///    valid when media has been "prepared" but not released. Value: 0xC0AA0603 </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2RAW_MEDIA_IS_NOT_SUPPORTED</b></dt> </dl> </td> <td
    ///    width="60%"> Only blank CD-R/RW media is supported. Value: 0xC0AA0606 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_MEDIA_IS_NOT_BLANK</b></dt> </dl> </td> <td width="60%"> Only blank CD-R/RW media is
    ///    supported. Value: 0xC0AA0607 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_CLIENT_NAME_IS_NOT_VALID</b></dt> </dl> </td> <td width="60%"> The client name is not
    ///    valid. Value: 0xC0AA0604 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_IMAPI_ROTATIONADJUSTED</b></dt>
    ///    </dl> </td> <td width="60%"> The requested rotation type was not supported by the drive and the rotation type
    ///    was adjusted. Value: 0x00AA0005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_IMAPI_SPEEDADJUSTED</b></dt>
    ///    </dl> </td> <td width="60%"> The requested write speed was not supported by the drive and the speed was
    ///    adjusted. Value: 0x00AA0004 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_IMAPI_BOTHADJUSTED</b></dt> </dl>
    ///    </td> <td width="60%"> The requested write speed and rotation type were not supported by the drive and they
    ///    were both adjusted. Value: 0x00AA0006 </td> </tr> </table>
    ///    
    HRESULT PrepareMedia();
    ///Writes a DAO-96 raw image to the blank media using MSF 95:00:00 as the starting address.
    ///Params:
    ///    data = An <b>IStream</b> interface of the data stream to write.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2RAW_STREAM_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%">
    ///    The provided audio stream is not valid. Value: 0xC0AA060D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_MEDIA_IS_NOT_PREPARED</b></dt> </dl> </td> <td width="60%"> The requested operation is
    ///    only valid when media has been "prepared". Value: 0xC0AA0602 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> There is currently a write
    ///    operation in progress. Value: 0xC0AA0600 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_MEDIA_IS_NOT_BLANK</b></dt> </dl> </td> <td width="60%"> Only blank CD-R/RW media is
    ///    supported. Value: 0xC0AA0606 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_STREAM_LEADIN_TOO_SHORT</b></dt> </dl> </td> <td width="60%"> The stream does not
    ///    contain a sufficient number of sectors in the leadin for the current media. Value: 0xC0AA060F </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments
    ///    are not valid. Value: 0x80070057 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_NOT_ENOUGH_SPACE</b></dt> </dl> </td> <td width="60%"> There is not enough space on the
    ///    media to add the provided session. Value: 0xC0AA0609 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The device failed to accept the
    ///    command within the timeout period. This may be caused by the device having entered an inconsistent state, or
    ///    the timeout value for the command may need to be increased. Value: 0xC0AA020D </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%">
    ///    The device reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media
    ///    is inserted upside down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_REQUEST_CANCELLED</b></dt> </dl> </td> <td width="60%">
    ///    The request was canceled. Value: 0xC0AA0002 </td> </tr> </table>
    ///    
    HRESULT WriteMedia(IStream data);
    ///Writes a DAO-96 raw image to the blank media using a specified starting address.
    ///Params:
    ///    data = An <b>IStream</b> interface of the data stream to write.
    ///    streamLeadInSectors = Starting address at which to begin writing the data stream.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2RAW_STREAM_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%">
    ///    The provided audio stream is not valid. Value: 0xC0AA060D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_MEDIA_IS_NOT_PREPARED</b></dt> </dl> </td> <td width="60%"> The requested operation is
    ///    only valid when media has been "prepared". Value: 0xC0AA0602 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> There is currently a write
    ///    operation in progress. Value: 0xC0AA0600 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_MEDIA_IS_NOT_BLANK</b></dt> </dl> </td> <td width="60%"> Only blank CD-R/RW media is
    ///    supported. Value: 0xC0AA0606 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_STREAM_LEADIN_TOO_SHORT</b></dt> </dl> </td> <td width="60%"> The stream does not
    ///    contain a sufficient number of sectors in the leadin for the current media. Value: 0xC0AA060F </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments
    ///    are not valid. Value: 0x80070057 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_NOT_ENOUGH_SPACE</b></dt> </dl> </td> <td width="60%"></td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The device failed to accept the
    ///    command within the timeout period. This may be caused by the device having entered an inconsistent state, or
    ///    the timeout value for the command may need to be increased. Value: 0xC0AA020D </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%">
    ///    The device reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media
    ///    is inserted upside down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_REQUEST_CANCELLED</b></dt> </dl> </td> <td width="60%">
    ///    The request was canceled. Value: 0xC0AA0002 </td> </tr> </table>
    ///    
    HRESULT WriteMedia2(IStream data, int streamLeadInSectors);
    ///Cancels the current write operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_WRITE_NOT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> There is no write operation
    ///    currently in progress. Value: 0xC0AA0601 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> </table>
    ///    
    HRESULT CancelWrite();
    ///Closes a Disc-At-Once (DAO) writing session of a raw image and releases the lock.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_MEDIA_IS_NOT_PREPARED</b></dt> </dl> </td> <td width="60%"> The requested operation is
    ///    only valid when media has been "prepared". Value: 0xC0AA0602 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> There is currently a write
    ///    operation in progress. Value: 0xC0AA0600 </td> </tr> </table>
    ///    
    HRESULT ReleaseMedia();
    ///Sets the write speed of the disc recorder.
    ///Params:
    ///    RequestedSectorsPerSecond = Requested write speed measured in disc sectors per second. A value of 0xFFFFFFFF (-1) requests that the write
    ///                                occurs using the fastest supported speed for the media. This is the default.
    ///    RotationTypeIsPureCAV = Requested rotational-speed control type. Set to VARIANT_TRUE to request constant angular velocity (CAV)
    ///                            rotational-speed control type. Set to VARIANT_FALSE to use another rotational-speed control type that the
    ///                            recorder supports. The default is VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_REQUIRED</b></dt> </dl> </td> <td width="60%"> The request requires a current disc
    ///    recorder to be selected. Value: 0xC0AA0003 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2RAW_MEDIA_IS_NOT_SUPPORTED</b></dt> </dl> </td> <td
    ///    width="60%"> Only blank CD-R/RW media is supported. Value: 0xC0AA0606 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_MEDIA_IS_NOT_BLANK</b></dt> </dl> </td> <td width="60%"> Only blank CD-R/RW media is
    ///    supported. Value: 0xC0AA0607 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_CLIENT_NAME_IS_NOT_VALID</b></dt> </dl> </td> <td width="60%"> The client name is not
    ///    valid. Value: 0xC0AA0604 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_IMAPI_ROTATIONADJUSTED</b></dt>
    ///    </dl> </td> <td width="60%"> The requested rotation type was not supported by the drive and the rotation type
    ///    was adjusted. Value: 0x00AA0005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_IMAPI_SPEEDADJUSTED</b></dt>
    ///    </dl> </td> <td width="60%"> The requested write speed was not supported by the drive and the speed was
    ///    adjusted. Value: 0x00AA0004 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_IMAPI_BOTHADJUSTED</b></dt> </dl>
    ///    </td> <td width="60%"> The requested write speed and rotation type were not supported by the drive and they
    ///    were both adjusted. Value: 0x00AA0006 </td> </tr> </table>
    ///    
    HRESULT SetWriteSpeed(int RequestedSectorsPerSecond, short RotationTypeIsPureCAV);
    ///Sets the recording device to use for the write operation.
    ///Params:
    ///    value = An IDiscRecorder2 interface that identifies the recording device to use in the write operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> There is currently a write
    ///    operation in progress. Value: 0xC0AA0600 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_MEDIA_IS_PREPARED</b></dt> </dl> </td> <td width="60%"> The requested operation is not
    ///    valid when media has been "prepared" but not released. Value:0xC0AA0603 </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_IMAPI_DF2RAW_RECORDER_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This device does not
    ///    support the operations required by this disc format. Value: 0xC0AA050E </td> </tr> </table>
    ///    
    HRESULT put_Recorder(IDiscRecorder2 value);
    ///Retrieves the recording device to use for the write operation.
    ///Params:
    ///    value = An IDiscRecorder2 interface that identifies the recording device to use in the write operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Recorder(IDiscRecorder2* value);
    ///Determines if Buffer Underrun Free recording is enabled.
    ///Params:
    ///    value = Set to VARIANT_TRUE to disable Buffer Underrun Free recording; otherwise, VARIANT_FALSE. The default is
    ///            VARIANT_FALSE (enabled).
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_MEDIA_IS_NOT_PREPARED</b></dt> </dl> </td> <td width="60%"> The requested operation is
    ///    only valid when media has been "prepared". Value: 0xC0AA0602 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> There is currently a write
    ///    operation in progress. Value: 0xC0AA0600 </td> </tr> </table>
    ///    
    HRESULT put_BufferUnderrunFreeDisabled(short value);
    ///Determines if Buffer Underrun Free recording is enabled.
    ///Params:
    ///    value = Is VARIANT_TRUE if Buffer Underrun Free recording is disabled; otherwise, VARIANT_FALSE (enabled).
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_BufferUnderrunFreeDisabled(short* value);
    ///Retrieves the first sector of the next session.
    ///Params:
    ///    value = Sector number for the start of the next write operation. This value can be negative for blank media.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2RAW_MEDIA_IS_NOT_PREPARED</b></dt> </dl> </td> <td width="60%">
    ///    The requested operation is only valid when media has been "prepared". Value: 0xC0AA0602 </td> </tr> </table>
    ///    
    HRESULT get_StartOfNextSession(int* value);
    ///Retrieves the last possible starting position for the leadout area.
    ///Params:
    ///    value = Sector address of the starting position for the leadout area.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2RAW_MEDIA_IS_NOT_PREPARED</b></dt> </dl> </td> <td width="60%">
    ///    The requested operation is only valid when media has been "prepared". Value: 0xC0AA0602 </td> </tr> </table>
    ///    
    HRESULT get_LastPossibleStartOfLeadout(int* value);
    ///Retrieves the type of media in the disc device.
    ///Params:
    ///    value = Type of media in the disc device. For possible values, see the IMAPI_MEDIA_PHYSICAL_TYPEenumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_NO_RECORDER_SPECIFIED</b></dt> </dl> </td> <td width="60%"> You cannot prepare the
    ///    media until you choose a recorder to use. Value: 0xC0AA060A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. <div class="alert"><b>Note</b> This value does not indicate a <b>NULL</b>
    ///    pointer.</div> <div> </div> Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt>
    ///    </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT get_CurrentPhysicalMediaType(IMAPI_MEDIA_PHYSICAL_TYPE* value);
    ///Retrieves the supported data sector types for the current recorder.
    ///Params:
    ///    value = List of data sector types for the current recorder. Each element of the list is a <b>VARIANT</b> of type
    ///            <b>VT_UI4</b>. The <b>ulVal</b> member of the variant contains the data sector type. For a list of values of
    ///            supported sector types, see IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The
    ///    returned pointer is not valid. This value can also indicate that the recorder has not yet been set with
    ///    IDiscFormat2RawCD::put_Recorder. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The device failed to accept the
    ///    command within the timeout period. This may be caused by the device having entered an inconsistent state, or
    ///    the timeout value for the command may need to be increased. Value: 0xC0AA020D </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%">
    ///    The device reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media
    ///    is inserted upside down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> </table>
    ///    
    HRESULT get_SupportedSectorTypes(SAFEARRAY** value);
    ///Sets the requested data sector to use for writing the stream.
    ///Params:
    ///    value = Data sector to use for writing the stream. For possible values, see the IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE
    ///            enumeration type. The default is <b>IMAPI_FORMAT2_RAW_CD_SUBCODE_IS_COOKED</b>.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> There is currently a write
    ///    operation in progress. Value: 0xC0AA0600 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_MEDIA_IS_NOT_PREPARED</b></dt> </dl> </td> <td width="60%"> The requested operation is
    ///    only valid when media has been "prepared". Value: 0xC0AA0602 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_DATA_BLOCK_TYPE_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The requested data
    ///    block type is not supported by the current device. Value: 0xC0AA060E </td> </tr> </table>
    ///    
    HRESULT put_RequestedSectorType(IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE value);
    ///Retrieves the requested data sector to use during write of the stream.
    ///Params:
    ///    value = Requested data sector type. For possible values, see IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2RAW_MEDIA_IS_NOT_PREPARED</b></dt> </dl> </td> <td width="60%">
    ///    The requested operation is only valid when media has been "prepared". Value: 0xC0AA0602 </td> </tr> </table>
    ///    
    HRESULT get_RequestedSectorType(IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE* value);
    ///Sets the friendly name of the client.
    ///Params:
    ///    value = Name of the client application. Cannot be <b>NULL</b> or an empty string.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2RAW_CLIENT_NAME_IS_NOT_VALID</b></dt>
    ///    </dl> </td> <td width="60%"> The client name is not valid. Value: 0xC0AA0604 </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_DF2RAW_WRITE_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> There is
    ///    currently a write operation in progress. Value: 0xC0AA0600 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_MEDIA_IS_PREPARED</b></dt> </dl> </td> <td width="60%"> The requested operation is not
    ///    valid when media has been "prepared" but not released. Value: 0xC0AA0603 </td> </tr> </table>
    ///    
    HRESULT put_ClientName(BSTR value);
    ///Retrieves the friendly name of the client.
    ///Params:
    ///    value = Name supplied by the client application.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT get_ClientName(BSTR* value);
    ///Retrieves the requested write speed.
    ///Params:
    ///    value = Requested write speed measured in disc sectors per second. A value of 0xFFFFFFFF (-1) requests that the write
    ///            occurs using the fastest supported speed for the media.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_RequestedWriteSpeed(int* value);
    ///Retrieves the requested rotational-speed control type.
    ///Params:
    ///    value = Requested rotational-speed control type. Is VARIANT_TRUE for constant angular velocity (CAV) rotational-speed
    ///            control type. Otherwise, is VARIANT_FALSE for any other rotational-speed control type that the recorder
    ///            supports.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_RequestedRotationTypeIsPureCAV(short* value);
    ///Retrieves the drive's current write speed.
    ///Params:
    ///    value = The write speed of the current media, measured in sectors per second.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_NO_RECORDER_SPECIFIED</b></dt> </dl> </td> <td width="60%"> You cannot prepare the
    ///    media until you choose a recorder to use. Value: 0xC0AA060A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_UNEXPECTED_RESPONSE_FROM_DEVICE</b></dt> </dl> </td>
    ///    <td width="60%"> The write failed because the drive returned error information that could not be recovered
    ///    from. Value: 0xC0AA0301 </td> </tr> </table>
    ///    
    HRESULT get_CurrentWriteSpeed(int* value);
    ///Retrieves the current rotational-speed control used by the recorder.
    ///Params:
    ///    value = Is VARIANT_TRUE if constant angular velocity (CAV) rotational-speed control is in use. Otherwise,
    ///            VARIANT_FALSE to indicate that another rotational-speed control that the recorder supports is in use.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_NO_RECORDER_SPECIFIED</b></dt> </dl> </td> <td width="60%"> You cannot prepare the
    ///    media until you choose a recorder to use. Value: 0xC0AA060A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_UNEXPECTED_RESPONSE_FROM_DEVICE</b></dt> </dl> </td>
    ///    <td width="60%"> The write failed because the drive returned error information that could not be recovered
    ///    from. Value: 0xC0AA0301 </td> </tr> </table>
    ///    
    HRESULT get_CurrentRotationTypeIsPureCAV(short* value);
    ///Retrieves a list of the write speeds supported by the disc recorder and current media.
    ///Params:
    ///    supportedSpeeds = List of the write speeds supported by the disc recorder and current media. Each element of the list is a
    ///                      <b>VARIANT</b> of type <b>VT_UI4</b>. The <b>ulVal</b> member of the variant contains the number of sectors
    ///                      written per second.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_NO_RECORDER_SPECIFIED</b></dt> </dl> </td> <td width="60%"> You cannot prepare the
    ///    media until you choose a recorder to use. Value: 0xC0AA060A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. <div class="alert"><b>Note</b> This value does not indicate a <b>NULL</b>
    ///    pointer.</div> <div> </div> Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt>
    ///    </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_UNEXPECTED_RESPONSE_FROM_DEVICE</b></dt> </dl> </td>
    ///    <td width="60%"> The write failed because the drive returned error information that could not be recovered
    ///    from. Value: 0xC0AA0301 </td> </tr> </table>
    ///    
    HRESULT get_SupportedWriteSpeeds(SAFEARRAY** supportedSpeeds);
    ///Retrieves a list of the detailed write configurations supported by the disc recorder and current media.
    ///Params:
    ///    supportedSpeedDescriptors = List of the detailed write configurations supported by the disc recorder and current media. Each element of
    ///                                the list is a <b>VARIANT</b> of type <b>VT_Dispatch</b>. Query the <b>pdispVal</b> member of the variant for
    ///                                the IWriteSpeedDescriptor interface, which contains the media type, write speed, rotational-speed control
    ///                                type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_DF2RAW_NO_RECORDER_SPECIFIED</b></dt> </dl> </td> <td width="60%"> You cannot prepare the
    ///    media until you choose a recorder to use. Value: 0xC0AA060A </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. <div class="alert"><b>Note</b> This value does not indicate a <b>NULL</b>
    ///    pointer.</div> <div> </div> Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt>
    ///    </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_UNEXPECTED_RESPONSE_FROM_DEVICE</b></dt> </dl> </td>
    ///    <td width="60%"> The write failed because the drive returned error information that could not be recovered
    ///    from. Value: 0xC0AA0301 </td> </tr> </table>
    ///    
    HRESULT get_SupportedWriteSpeedDescriptors(SAFEARRAY** supportedSpeedDescriptors);
}

///Implement this interface to receive notifications of the current raw-image write operation.
@GUID("27354142-7F64-5B0F-8F00-5D77AFBE261E")
interface DDiscFormat2RawCDEvents : IDispatch
{
    ///Implement this method to receive progress notification of the current raw-image write operation.
    ///Params:
    ///    object = The IDiscFormat2RawCD interface that initiated the write operation. This parameter is a
    ///             <b>MsftDiscFormat2RawCD</b> object in script.
    ///    progress = An IDiscFormat2RawCDEventArgs interface that you use to determine the progress of the write operation. This
    ///               parameter is a <b>MsftDiscFormat2RawCD</b> object in script.
    ///Returns:
    ///    Return values are ignored.
    ///    
    HRESULT Update(IDispatch object, IDispatch progress);
}

///Use this interface to retrieve information about the current write operation. This interface is passed to the
///DDiscFormat2RawCDEvents::Update method that you implement.
@GUID("27354143-7F64-5B0F-8F00-5D77AFBE261E")
interface IDiscFormat2RawCDEventArgs : IWriteEngine2EventArgs
{
    ///Retrieves the current write action being performed.
    ///Params:
    ///    value = Current write action being performed. For a list of possible actions, see the
    ///            IMAPI_FORMAT2_RAW_CD_WRITE_ACTION enumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_CurrentAction(IMAPI_FORMAT2_RAW_CD_WRITE_ACTION* value);
    ///Retrieves the total elapsed time of the write operation.
    ///Params:
    ///    value = Elapsed time, in seconds, of the write operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_ElapsedTime(int* value);
    ///Retrieves the estimated remaining time of the write operation.
    ///Params:
    ///    value = Estimated time, in seconds, needed for the remainder of the write operation.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_RemainingTime(int* value);
}

///Use this interface with IDiscFormat2Data or IDiscFormat2TrackAtOnce to get or set the Burn Verification Level
///property which dictates how burned media is verified for integrity after the write operation.
@GUID("D2FFD834-958B-426D-8470-2A13879C6A91")
interface IBurnVerification : IUnknown
{
    ///Sets the Burn Verification Level.
    ///Params:
    ///    value = Value that defines the Burn Verification Level. For possible values, see IMAPI_BURN_VERIFICATION_LEVEL.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT put_BurnVerificationLevel(IMAPI_BURN_VERIFICATION_LEVEL value);
    ///Retrieves the current Burn Verification Level.
    ///Params:
    ///    value = Pointer to an IMAPI_BURN_VERIFICATION_LEVEL enumeration that specifies the current the Burn Verification
    ///            Level.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_BurnVerificationLevel(IMAPI_BURN_VERIFICATION_LEVEL* value);
}

///Use this interface retrieve detailed write configurations supported by the disc recorder and current media, for
///example, the media type, write speed, rotational-speed control type. To get this interface, call one of the following
///methods:<ul> <li> IDiscFormat2Data::get_SupportedWriteSpeedDescriptors </li> <li>
///IDiscFormat2RawCD::get_SupportedWriteSpeedDescriptors </li> <li>
///IDiscFormat2TrackAtOnce::get_SupportedWriteSpeedDescriptors </li> </ul>
@GUID("27354144-7F64-5B0F-8F00-5D77AFBE261E")
interface IWriteSpeedDescriptor : IDispatch
{
    ///Retrieves type of media in the current drive.
    ///Params:
    ///    value = Type of media in the current drive. For possible values, see the IMAPI_MEDIA_PHYSICAL_TYPE enumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_MediaType(IMAPI_MEDIA_PHYSICAL_TYPE* value);
    ///Retrieves the supported rotational-speed control used by the recorder for the current media.
    ///Params:
    ///    value = Is VARIANT_TRUE if constant angular velocity (CAV) rotational-speed control is in use. Otherwise,
    ///            VARIANT_FALSE to indicate that another rotational-speed control that the recorder supports is in use.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_RotationTypeIsPureCAV(short* value);
    ///Retrieves the supported write speed for writing to the media.
    ///Params:
    ///    value = Write speed of the current media, measured in sectors per second.
    ///Returns:
    ///    S_OK is typically returned on success, but the return of other success values is possible. The following
    ///    error codes are commonly returned on operation failure, but do not represent the only possible error values:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_WriteSpeed(int* value);
}

///Base interface containing properties common to derived multisession interfaces. You can derive from this interface to
///implement a new multi-session mechanism that is different from IMultisessionSequential and IMultisessionRandomWrite.
///For example, you could implement a mechanism for BD-R Pseudo-Overwrite. To access media-specific properties of a
///multisession interface, use the IMultisessionSequential and IMultisessionRandomWrite interface.
@GUID("27354150-7F64-5B0F-8F00-5D77AFBE261E")
interface IMultisession : IDispatch
{
    ///Determines if the multi-session type can write to the current optical media.
    ///Params:
    ///    value = Is VARIANT_TRUE if the multi-session interface can write to the current optical media in its current state.
    ///            Otherwise, VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. <div class="alert"><b>Note</b>
    ///    This value does not indicate a <b>NULL</b> pointer.</div> <div> </div> Value: 0x80004003 </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to
    ///    allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_FEATURE_IS_NOT_CURRENT</b></dt>
    ///    </dl> </td> <td width="60%"> The feature page requested is supported, but is not marked as current. Value:
    ///    0xC0AA020B </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_REQUIRED</b></dt> </dl> </td> <td width="60%">
    ///    The request requires a current disc recorder to be selected. Value: 0xC0AA0003 </td> </tr> </table>
    ///    
    HRESULT get_IsSupportedOnCurrentMediaState(short* value);
    ///Determines if this multi-session interface is the one you should use on the current media.
    ///Params:
    ///    value = Set to VARIANT_TRUE if this multi-session interface is the one you should use to write to the current media.
    ///            Otherwise, VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT put_InUse(short value);
    ///Determines if this multi-session interface is the one you should use on the current media.
    ///Params:
    ///    value = Is VARIANT_TRUE if this multi-session interface is the one you should use to write to the current media.
    ///            Otherwise, VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_InUse(short* value);
    ///Retrieves the disc recorder to use to import one or more previous sessions.
    ///Params:
    ///    value = An IDiscRecorder2 interface that identifies the device that contains one or more session images to import.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_ImportRecorder(IDiscRecorder2* value);
}

///Use this interface to retrieve information about the previous import session on a sequentially recorded media, if the
///media contains a previous session. The following methods return a collection of IMultisession interfaces representing
///all supported multisession types. <ul> <li> IDiscFormat2Data::get_MultisessionInterfaces </li> <li>
///IFileSystemImage::get_MultisessionInterfaces </li> </ul>The <b>IMultisession::QueryInterface</b> method can be called
///on each element in the collection to query for the <b>IMultisessionSequential</b> interface.
@GUID("27354151-7F64-5B0F-8F00-5D77AFBE261E")
interface IMultisessionSequential : IMultisession
{
    ///Determines if this session is the first data session on the media.
    ///Params:
    ///    value = Is VARIANT_TRUE if the session is the first data session on the media. Otherwise, the value is VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_REQUIRED</b></dt> </dl> </td> <td width="60%"> The request requires a current disc
    ///    recorder to be selected. Value: 0xC0AA0003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value: 0x80004005 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One or more arguments are not valid. Value: 0x80070057 </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The device
    ///    failed to accept the command within the timeout period. This may be caused by the device having entered an
    ///    inconsistent state, or the timeout value for the command may need to be increased. Value: 0xC0AA020D </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td>
    ///    <td width="60%"> The device reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%">
    ///    The media is inserted upside down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The device failed to accept the command within the timeout period. This may be caused by the device having
    ///    entered an inconsistent state, or the timeout value for the command may need to be increased. Value:
    ///    0xC0AA020E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl>
    ///    </td> <td width="60%"> The device reported that the requested mode page (and type) is not present. Value:
    ///    0xC0AA0201 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt>
    ///    </dl> </td> <td width="60%"> The drive reported that the combination of parameters provided in the mode page
    ///    for a MODE SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2DATA_INVALID_MEDIA_STATE</b></dt> </dl> </td> <td
    ///    width="60%"> The requested operation is only valid with supported media. Value: 0xC0AA0402 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_IsFirstDataSession(short* value);
    ///Retrieves the first sector written in the previous session on the media.
    ///Params:
    ///    value = Sector number that identifies the starting point of the previous write session.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2DATA_INVALID_MEDIA_STATE</b></dt> </dl> </td> <td
    ///    width="60%"> The requested operation is only valid with supported media. Value: 0xC0AA0402 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_StartAddressOfPreviousSession(int* value);
    ///Retrieves the last sector written in the previous session on the media.
    ///Params:
    ///    value = Sector number that identifies the last sector written in the previous write session.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> Not implemented. Value: 0x80004001 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_LastWrittenAddressOfPreviousSession(int* value);
    ///Retrieves the next writable address on the media, including used sectors.
    ///Params:
    ///    value = Sector number that identifies the next available sector that can record data or audio.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2DATA_INVALID_MEDIA_STATE</b></dt> </dl> </td> <td
    ///    width="60%"> The requested operation is only valid with supported media. Value: 0xC0AA0402 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_NextWritableAddress(int* value);
    ///Retrieves the number of free sectors available on the media.
    ///Params:
    ///    value = Number of sectors on the disc that are available for use.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2DATA_INVALID_MEDIA_STATE</b></dt> </dl> </td> <td
    ///    width="60%"> The requested operation is only valid with supported media. Value: 0xC0AA0402 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_FreeSectorsOnMedia(int* value);
}

///Use this interface to retrieve information about the size of a writeable unit on sequentially recorded media.
@GUID("B507CA22-2204-11DD-966A-001AA01BBC58")
interface IMultisessionSequential2 : IMultisessionSequential
{
    ///Retrieves the size of a writeable unit on the media.
    ///Params:
    ///    value = The size of a writeable unit on the media in sectors.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2DATA_INVALID_MEDIA_STATE</b></dt> </dl> </td> <td
    ///    width="60%"> The requested operation is only valid with supported media. Value: 0xC0AA0402 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_WriteUnitSize(int* value);
}

///Use this interface to retrieve information about the current state of media allowing random writes and not supporting
///the concept of physical sessions. The following methods return a collection of IMultisession interfaces representing
///all supported multisession types. <ul> <li> IDiscFormat2Data::get_MultisessionInterfaces </li> <li>
///IFileSystemImage::get_MultisessionInterfaces </li> </ul> You can then call the IUnknown::QueryInterface method on
///each element in the collection to query for the <b>IMultisessionRandomWrite</b> interface.
@GUID("B507CA23-2204-11DD-966A-001AA01BBC58")
interface IMultisessionRandomWrite : IMultisession
{
    ///Retrieves the size of a writeable unit on the media.
    ///Params:
    ///    value = The size of a writeable unit on the media.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2DATA_INVALID_MEDIA_STATE</b></dt> </dl> </td> <td
    ///    width="60%"> The requested operation is only valid with supported media. Value: 0xC0AA0402 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_WriteUnitSize(int* value);
    ///Retrieves the last written address on the media.
    ///Params:
    ///    value = The last written address on the media.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"></td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to
    ///    allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2DATA_INVALID_MEDIA_STATE</b></dt> </dl> </td> <td
    ///    width="60%"> The requested operation is only valid with supported media. Value: 0xC0AA0402 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_LastWrittenAddress(int* value);
    ///Retrieves the total number of sectors on the media.
    ///Params:
    ///    value = The total number of sectors on the media.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unspecified failure. Value:
    ///    0x80004005 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_COMMAND_TIMEOUT</b></dt> </dl>
    ///    </td> <td width="60%"> The device failed to accept the command within the timeout period. This may be caused
    ///    by the device having entered an inconsistent state, or the timeout value for the command may need to be
    ///    increased. Value: 0xC0AA020D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_INVALID_RESPONSE_FROM_DEVICE</b></dt> </dl> </td> <td width="60%"> The device
    ///    reported unexpected or invalid data for a command. Value: 0xC0AA02FF </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_UPSIDE_DOWN</b></dt> </dl> </td> <td width="60%"> The media is inserted upside
    ///    down. Value: 0xC0AA0204 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_BECOMING_READY</b></dt> </dl> </td> <td width="60%"> The drive reported that it
    ///    is in the process of becoming ready. Please try the request again later. Value: 0xC0AA0205 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_NO_MEDIA</b></dt> </dl> </td> <td width="60%"> There is
    ///    no media in the device. Value: 0xC0AA0202 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_FORMAT_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The media is currently
    ///    being formatted. Please wait for the format to complete before attempting to use the media. Value: 0xC0AA0206
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_BUSY</b></dt> </dl> </td> <td
    ///    width="60%"> The drive reported that it is performing a long-running operation, such as finishing a write.
    ///    The drive may be unusable for a long period of time. Value: 0xC0AA0207 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_LOSS_OF_STREAMING</b></dt> </dl> </td> <td width="60%"> The write failed because the drive did
    ///    not receive data quickly enough to continue writing. Moving the source data to the local computer, reducing
    ///    the write speed, or enabling a "buffer underrun free" setting may resolve this issue. Value: 0xC0AA0300 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td
    ///    width="60%"> The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_DVD_STRUCTURE_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
    ///    The DVD structure is not present. This may be caused by incompatible drive/medium used. Value: 0xC0AA020E
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_NO_SUCH_MODE_PAGE</b></dt> </dl> </td> <td
    ///    width="60%"> The device reported that the requested mode page (and type) is not present. Value: 0xC0AA0201
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_INVALID_MODE_PARAMETERS</b></dt> </dl> </td>
    ///    <td width="60%"> The drive reported that the combination of parameters provided in the mode page for a MODE
    ///    SELECT command were not supported. Value: 0xC0AA0208 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_WRITE_PROTECTED</b></dt> </dl> </td> <td width="60%"> The drive reported that
    ///    the media is write protected. Value: 0xC0AA0209 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_MEDIA_SPEED_MISMATCH</b></dt> </dl> </td> <td width="60%"> The media's speed is
    ///    incompatible with the device. This may be caused by using higher or lower speed media than the range of
    ///    speeds supported by the device. Value: 0xC0AA020F </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_INVALID_HANDLE)</b></dt> </dl> </td> <td width="60%"> The specified handle is
    ///    invalid. Value: 6 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_DEV_NOT_EXIST)</b></dt> </dl> </td> <td width="60%"> The specified network
    ///    resource or device is no longer available. Value: 55 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_IMAPI_RECORDER_LOCKED</b></dt> </dl> </td> <td width="60%"> The device associated with this recorder
    ///    during the last operation has been exclusively locked, causing this operation to failed. Value: 0xC0AA0210
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_DF2DATA_INVALID_MEDIA_STATE</b></dt> </dl> </td> <td
    ///    width="60%"> The requested operation is only valid with supported media. Value: 0xC0AA0402 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_TotalSectorsOnMedia(int* value);
}

///Use this interface to generate a read-only data stream whose data is initialized with pseudo-random data (not
///cryptographically safe). You must call the <b>SetSize</b> method to set the requested size of the stream. To create
///an instance of this interface, call the <b>CoCreateInstance</b> function. Use __uuidof(MsftStreamPrng001) for the
///class identifier and __uuidof(IStreamPseudoRandomBased) for the interface identifier.
@GUID("27354145-7F64-5B0F-8F00-5D77AFBE261E")
interface IStreamPseudoRandomBased : IStream
{
    ///Sets the seed value used by the random number generator and seeks to the start of stream.
    ///Params:
    ///    value = Seed value for the random number generator.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT put_Seed(uint value);
    ///Retrieves the seed value used by the random number generator.
    ///Params:
    ///    value = Seed value for the random number generator.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Seed(uint* value);
    ///Sets a list of seed values for the random number generator and seeks to the start of stream.<div
    ///class="alert"><b>Note</b> This interface is currently not implemented.</div> <div> </div>
    ///Params:
    ///    values = Array of seed values used by the random number generator.
    ///    eCount = Number of seed values in the <i>values</i> array.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> Not implemented. Value: 0x80004001 </td> </tr>
    ///    </table>
    ///    
    HRESULT put_ExtendedSeed(uint* values, uint eCount);
    ///Retrieves an array of seed values used by the random number generator.
    ///Params:
    ///    values = Array of seed values used by the random number generator.
    ///    eCount = Number of seed values in the <i>values</i> array.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> Not implemented. Value: 0x80004001 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_ExtendedSeed(uint** values, uint* eCount);
}

///Use this interface to combine several data streams into a single stream. To create an instance of this interface,
///call the <b>CoCreateInstance</b> function. Use__uuidof(MsftStreamConcatenate) for the class identifier and
///__uuidof(IStreamConcatenate) for the interface identifier.
@GUID("27354146-7F64-5B0F-8F00-5D77AFBE261E")
interface IStreamConcatenate : IStream
{
    ///Initializes this stream from two input streams.
    ///Params:
    ///    stream1 = An <b>IStream</b> interface of the first stream to add to this stream.
    ///    stream2 = An <b>IStream</b> interface of the second stream to add to this stream.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One or more arguments are not valid. Value: 0x80070057 </td> </tr> </table>
    ///    
    HRESULT Initialize(IStream stream1, IStream stream2);
    ///Initializes this stream from an array of input streams.
    ///Params:
    ///    streams = Array of <b>IStream</b> interfaces of the streams to add to this stream.
    ///    streamCount = Number of streams in <i>streams</i>.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> This stream has already been initialized. Value: 0x80070057 </td> </tr> </table>
    ///    
    HRESULT Initialize2(IStream* streams, uint streamCount);
    ///Appends a stream to this stream.
    ///Params:
    ///    stream = An <b>IStream</b> interface of the stream to append to this stream.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> Not implemented. Value: 0x80004001 </td> </tr>
    ///    </table>
    ///    
    HRESULT Append(IStream stream);
    ///Appends an array of streams to this stream.
    ///Params:
    ///    streams = Array of <b>IStream</b> interfaces of the streams to append to this stream.
    ///    streamCount = Number of streams in <i>streams</i>.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> Not implemented. Value: 0x80004001 </td> </tr>
    ///    </table>
    ///    
    HRESULT Append2(IStream* streams, uint streamCount);
}

///Use this interface to combine several data streams into a single stream by alternately interspersing portions of
///each. You create interleaved streams when data streams need to run parallel to each other instead of sequentially.
///For example, some CD formats require user data interleaved with the subcode information. Any fixed-size interleave is
///supported. To create an instance of this interface, call the <b>CoCreateInstance</b> function.
///Use__uuidof(MsftStreamInterleave) for the class identifier and __uuidof(IStreamInterleave) for the interface
///identifier.
@GUID("27354147-7F64-5B0F-8F00-5D77AFBE261E")
interface IStreamInterleave : IStream
{
    ///Initialize this interleaved stream from an array of input streams and interleave sizes.
    ///Params:
    ///    streams = Array of <b>IStream</b> interfaces of the streams to add to this stream.
    ///    interleaveSizes = Array of interleave sizes, in bytes, with one entry per stream. The interleave size array is the number of
    ///                      contiguous bytes of a given stream to write on the disc before writing starts for the next stream.
    ///    streamCount = Number of streams in <i>streams</i>.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One or more arguments are not valid. Value: 0x80070057 </td> </tr> </table>
    ///    
    HRESULT Initialize(IStream* streams, uint* interleaveSizes, uint streamCount);
}

///Use this interface to create a RAW CD image for use in writing to CD media in Disc-at-Once (DAO) mode. Images created
///with this interface can be written to CD media using the IDiscFormat2RawCD interface. To create an instance of this
///interface, call the <b>CoCreateInstance</b> function. Use__uuidof(MsftRawCDImageCreator) for the class identifier and
///__uuidof(IRawCDImageCreator) for the interface identifier.
@GUID("25983550-9D65-49CE-B335-40630D901227")
interface IRawCDImageCreator : IDispatch
{
    ///Creates the final <b>IStream</b> object based on the current settings.
    ///Params:
    ///    resultStream = Pointer to the finalized IStream object.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT CreateResultImage(IStream* resultStream);
    ///Accepts the provided <b>IStream</b> object and saves the interface pointer as the next track in the image.
    ///Params:
    ///    dataType = A value, defined by IMAPI_CD_SECTOR_TYPE, that indicates the type of data. <b>IMAPI_CD_SECTOR_AUDIO</b> is
    ///               the only value supported by the <b>IRawCDImageCreator::AddTrack</b> method.
    ///    data = Pointer to the provided <b>IStream</b> object.
    ///    trackIndex = A <b>LONG</b> value within a 1 to 99 range that will be associated with the new track.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT AddTrack(IMAPI_CD_SECTOR_TYPE dataType, IStream data, int* trackIndex);
    ///Accepts the provided <b>IStream</b> object and saves the associated pointer to be used as data for the pre-gap
    ///for track 1.
    ///Params:
    ///    data = Pointer to the provided <b>IStream</b> object.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT AddSpecialPregap(IStream data);
    ///Allows the addition of custom R-W subcode, provided by the <b>IStream</b>. The provided object must have a size
    ///equal to the number of sectors in the raw disc image * 96 bytes when the final image is created.
    ///Params:
    ///    subcode = The subcode data (with 96 bytes per sector), where the 2 most significant bits must always be zero (as they
    ///              are the P/Q bits).
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT AddSubcodeRWGenerator(IStream subcode);
    ///Sets the value that defines the type of image file that will be generated.
    ///Params:
    ///    value = An IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE enumeration that defines the type of image file.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT put_ResultingImageType(IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE value);
    ///Retrieves the value that specifies the type of image file that will be generated.
    ///Params:
    ///    value = Pointer to an IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE enumeration that defines the current type set for the
    ///            image file.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_ResultingImageType(IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE* value);
    ///Retrieves the value that defines the LBA for the start of the Leadout. This method can be utilized to determine
    ///if the image can be written to a piece of media by comparing it against the <b>LastPossibleStartOfLeadout</b> for
    ///the media.
    ///Params:
    ///    value = Pointer to a <b>LONG</b> value that represents the LBA for the start of the Leadout.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_StartOfLeadout(int* value);
    ///Sets the <i>StartOfLeadoutLimit</i> property value. This value specifies if the resulting image is required to
    ///fit on a piece of media with a <b>StartOfLeadout</b> greater than or equal to the LBA specified.<div
    ///class="alert"><b>Note</b> The maximum supported value for this property is 398,099, which equates to MSF
    ///88:29:74. </div> <div> </div>
    ///Params:
    ///    value = Pointer to a <b>LONG</b> value that represents the current <i>StartOfLeadoutLimit</i>.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT put_StartOfLeadoutLimit(int value);
    ///Retrieves the current <i>StartOfLeadoutLimit</i> property value. This value specifies if the resulting image is
    ///required to fit on a piece of media with a <b>StartOfLeadout</b> greater than or equal to the LBA.
    ///Params:
    ///    value = Pointer to a <b>LONG</b> value that represents the current <i>StartOfLeadoutLimit</i>.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_StartOfLeadoutLimit(int* value);
    ///Sets the value that specifies if "Gapless Audio" recording is disabled. This property defaults to a value of
    ///<b>VARIANT_FALSE</b>, which disables the use of "gapless" recording between consecutive audio tracks.
    ///Params:
    ///    value = A <b>VARIANT_BOOL</b> value that specifies if "Gapless Audio" is disabled. Setting a value of
    ///            <b>VARIANT_FALSE</b> disables "Gapless Audio", while <b>VARIANT_TRUE</b> enables it.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT put_DisableGaplessAudio(short value);
    ///Retrieves the current value that specifies if "Gapless Audio" recording is disabled. This property defaults to a
    ///value of <b>VARIANT_FALSE</b>, which disables the use of "gapless" recording between consecutive audio tracks.
    ///Params:
    ///    value = A <b>VARIANT_BOOL</b> value that specifies if "Gapless Audio" is disabled. A value of <b>VARIANT_FALSE</b>
    ///            indicates that "Gapless Audio" is disabled; <b>VARIANT_TRUE</b> indicates that it is enabled.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_DisableGaplessAudio(short* value);
    ///Retrieves the Media Catalog Number (MCN) for the entire audio disc.
    ///Params:
    ///    value = A <b>BSTR</b> value that represents the MCN to associate with the audio disc.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT put_MediaCatalogNumber(BSTR value);
    ///Sets the Media Catalog Number (MCN) for the entire audio disc.
    ///Params:
    ///    value = Pointer to a <b>BSTR</b> value that represents the current MCN associated with the audio disc.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_MediaCatalogNumber(BSTR* value);
    ///Sets the starting track number.
    ///Params:
    ///    value = A <b>LONG</b> value that represents the starting track number.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT put_StartingTrackNumber(int value);
    ///Retrieves the starting track number.
    ///Params:
    ///    value = Pointer to a <b>LONG</b> value that represents the starting track number.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_StartingTrackNumber(int* value);
    ///Retrieves an indexed property, which takes a <b>LONG</b> value with a range of 1 to 99 as the index to determine
    ///which track the user is querying. The returned object is then queried/set for the particular per-track property
    ///of interest.
    ///Params:
    ///    trackIndex = A <b>LONG</b> value within a 1 to 99 range that is used to specify which track is queried.
    ///    value = A pointer to a pointer to an IRawCDImageTrackInfo object that contains information about the track associated
    ///            with the specified <i>trackInfo</i> index value.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_TrackInfo(int trackIndex, IRawCDImageTrackInfo* value);
    ///Retrieves the number of existing audio tracks on the media.
    ///Params:
    ///    value = Pointer to a <b>LONG</b> value that indicates the number of audio tracks that currently exist on the media.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_NumberOfExistingTracks(int* value);
    ///Retrieves the number of total used sectors on the current media, including any overhead between existing tracks.
    ///Params:
    ///    value = Pointer to a <b>LONG</b> value that indicates the number of total used sectors on the media.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_LastUsedUserSectorInImage(int* value);
    ///Gets the SCSI-form table of contents for the resulting disc.
    ///Params:
    ///    value = The SCSI-form table of contents for the resulting disc. Accuracy of this value depends on
    ///            <b>IRawCDImageCreator::get_ExpectedTableOfContents</b> being called after all image properties have been set.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_ExpectedTableOfContents(SAFEARRAY** value);
}

///Use this interface to track per-track properties that are applied to CD media.
@GUID("25983551-9D65-49CE-B335-40630D901227")
interface IRawCDImageTrackInfo : IDispatch
{
    ///Retrieves the LBA of the first user sectors in this track.
    ///Params:
    ///    value = The LBA of the first user sectors in this track.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_StartingLba(int* value);
    ///Retrieves the number of user sectors in this track.
    ///Params:
    ///    value = The number of user sectors in this track.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_SectorCount(int* value);
    ///Retrieves the track number for this track.
    ///Params:
    ///    value = The track number for this track.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_TrackNumber(int* value);
    ///Retrieves the type of data provided for the sectors in this track. For more detail on the possible sector types,
    ///see IMAPI_CD_SECTOR_TYPE.
    ///Params:
    ///    value = A pointer to a IMAPI_CD_SECTOR_TYPE enumeration that specifies the type of data provided for the sectors on
    ///            the track.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_SectorType(IMAPI_CD_SECTOR_TYPE* value);
    ///Retrieves the International Standard Recording Code (ISRC) currently associated with the track. This property
    ///value defaults to <b>NULL</b> (or a zero-length string) and may only be set for tracks containing audio data.
    ///Params:
    ///    value = The ISRC currently associated with the track.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_ISRC(BSTR* value);
    ///Sets the International Standard Recording Code (ISRC) currently associated with the track. This property value
    ///defaults to <b>NULL</b> (or a zero-length string) and may only be set for tracks containing audio data.
    ///Params:
    ///    value = The ISRC to associate with the track.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT put_ISRC(BSTR value);
    ///Retrieves the value for the bit that represents the current digital audio copy setting on the resulting media.
    ///Please see the IMAPI_CD_TRACK_DIGITAL_COPY_SETTING enumeration for possible values.
    ///Params:
    ///    value = The current digital audio copy setting.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_DigitalAudioCopySetting(IMAPI_CD_TRACK_DIGITAL_COPY_SETTING* value);
    ///Sets the digital audio copy "Allowed" bit to one of three values on the resulting media. Please see the
    ///IMAPI_CD_TRACK_DIGITAL_COPY_SETTING enumeration for additional information on each possible value.
    ///Params:
    ///    value = The digital audio copy setting value to assign.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT put_DigitalAudioCopySetting(IMAPI_CD_TRACK_DIGITAL_COPY_SETTING value);
    ///Retrieves the value that specifies if an audio track has an additional pre-emphasis added to the audio data.
    ///Params:
    ///    value = Value that specifies if an audio track has an additional pre-emphasis added to the audio data.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_AudioHasPreemphasis(short* value);
    ///Sets the value that specifies if an audio track has an additional pre-emphasis added to the audio data prior to
    ///being written to CD.
    ///Params:
    ///    value = Value that specifies if an audio track has an additional pre-emphasis added to the audio data.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT put_AudioHasPreemphasis(short value);
    ///Retrieves the one-based index of the tracks on the disc.
    ///Params:
    ///    value = The one-based index associated with this track.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_TrackIndexes(SAFEARRAY** value);
    HRESULT AddTrackIndex(int lbaOffset);
    HRESULT ClearTrackIndex(int lbaOffset);
}

///Use this interface to retrieve information about a single continuous range of sectors on the media. This interface is
///typically used together with the IBlockRangeList interface to describe a collection of sector ranges.
@GUID("B507CA25-2204-11DD-966A-001AA01BBC58")
interface IBlockRange : IDispatch
{
    ///Retrieves the start sector of the range described by IBlockRange.
    ///Params:
    ///    value = The start sector of the range.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> <dt>Value: 0x80004003</dt> </dl> </td> <td width="60%"> Invalid pointer. </td>
    ///    </tr> </table>
    ///    
    HRESULT get_StartLba(int* value);
    ///Retrieves the end sector of the range specified by the IBlockRange interface.
    ///Params:
    ///    value = The end sector of the range.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> <dt>Value: 0x80004003</dt> </dl> </td> <td width="60%"> Invalid pointer. </td>
    ///    </tr> </table>
    ///    
    HRESULT get_EndLba(int* value);
}

///Use this interface to retrieve a list of continuous sector ranges on the media. This interface is used to describe
///the sectors that need to be updated on a rewritable disc when a new logical session is recorded.
@GUID("B507CA26-2204-11DD-966A-001AA01BBC58")
interface IBlockRangeList : IDispatch
{
    ///Returns the list of sector ranges in the form of a safe array of variants of type VT_Dispatch.
    ///Params:
    ///    value = List of sector ranges. Each element of the list is a VARIANT of type VT_Dispatch. Query the pdispVal member
    ///            of the variant for the IBlockRange interface.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT get_BlockRanges(SAFEARRAY** value);
}

///Use this interface to specify the boot image to add to the optical disc. A boot image contains one or more sectors of
///code used to start the computer. To create an instance of this interface, call the <b>CoCreateInstance</b> function.
///Use__uuidof(BootOptions) for the class identifier and __uuidof(IBootOptions) for the interface identifier.
@GUID("2C941FD4-975B-59BE-A960-9A2A262853A5")
interface IBootOptions : IDispatch
{
    ///Retrieves a pointer to the boot image data stream.
    ///Params:
    ///    pVal = Pointer to the <b>IStream</b> interface associated with the boot image data stream.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_BootImage(IStream* pVal);
    ///Retrieves the identifier of the manufacturer of the CD.
    ///Params:
    ///    pVal = Identifier of the manufacturer of the CD.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Manufacturer(BSTR* pVal);
    ///Sets an identifier that identifies the manufacturer or developer of the CD.
    ///Params:
    ///    newVal = Identifier that identifies the manufacturer or developer of the CD. This is an ANSI string that is limited to
    ///             24 bytes. The string does not need to include a NULL character; however, you must set unused bytes to 0x00.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b> IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The provided
    ///    <i>newVal</i> parameter is not valid. Value: 0xC0AAB101 </td> </tr> </table>
    ///    
    HRESULT put_Manufacturer(BSTR newVal);
    ///Retrieves the platform identifier that identifies the operating system architecture that the boot image supports.
    ///Params:
    ///    pVal = Identifies the operating system architecture that the boot image supports. For possible values, see the
    ///           PlatformId enumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_PlatformId(PlatformId* pVal);
    ///Sets the platform identifier that identifies the operating system architecture that the boot image supports.
    ///Params:
    ///    newVal = Identifies the operating system architecture that the boot image supports. For possible values, see the
    ///             PlatformId enumeration type. The default value is <b>PlatformX86</b> for Intel x86–based platforms.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT put_PlatformId(PlatformId newVal);
    ///Retrieves the media type that the boot image is intended to emulate.
    ///Params:
    ///    pVal = Media type that the boot image is intended to emulate. For possible values, see the EmulationType enumeration
    ///           type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Emulation(EmulationType* pVal);
    ///Sets the media type that the boot image is intended to emulate.
    ///Params:
    ///    newVal = Media type that the boot image is intended to emulate. For possible values, see the EmulationType enumeration
    ///             type. The default value is <b>EmulationNone</b>, which means the BIOS will not emulate any device type or
    ///             special sector size for the CD during boot from the CD.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_BOOT_EMULATION_IMAGE_SIZE_MISMATCH</b></dt> </dl> </td> <td width="60%"> The emulation type
    ///    requested does not match the boot image size. Value: 0xC0AAB14A </td> </tr> </table>
    ///    
    HRESULT put_Emulation(EmulationType newVal);
    ///Retrieves the size of the boot image.
    ///Params:
    ///    pVal = Size, in bytes, of the boot image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_ImageSize(uint* pVal);
    ///Sets the data stream that contains the boot image.
    ///Params:
    ///    newVal = An <b>IStream</b> interface of the data stream that contains the boot image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_BOOT_IMAGE_DATA</b></dt> </dl> </td> <td width="60%"> The boot
    ///    object could not be added to the image. Value: 0xC0AAB142 </td> </tr> </table>
    ///    
    HRESULT AssignBootImage(IStream newVal);
}

///Use this interface to retrieve block information for one segment of the result file image. This can be used to
///determine the LBA ranges of files in the resulting image. This information can then be used to display to the user
///which file is currently being written to the media or used for other advanced burning functionality. To get this
///interface, call the IEnumProgressItems::Next or IEnumProgressItems::RemoteNext method.
@GUID("2C941FD5-975B-59BE-A960-9A2A262853A5")
interface IProgressItem : IDispatch
{
    ///Retrieves the description in the progress item.
    ///Params:
    ///    desc = String containing the description. The description contains the name of the file in the file system image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Description(BSTR* desc);
    ///Retrieves the first block number in this segment of the result image.
    ///Params:
    ///    block = First block number of this segment.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_FirstBlock(uint* block);
    ///Retrieves the last block in this segment of the result image.
    ///Params:
    ///    block = Number of the last block of this segment.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_LastBlock(uint* block);
    ///Retrieves the number of blocks in the progress item.
    ///Params:
    ///    blocks = Number of blocks in the segment.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_BlockCount(uint* blocks);
}

///Use this interface to enumerate a collection of progress items. To get this interface, call the
///IProgressItems::get_EnumProgressItems method.
@GUID("2C941FD6-975B-59BE-A960-9A2A262853A5")
interface IEnumProgressItems : IUnknown
{
    ///Retrieves a specified number of items in the enumeration sequence.
    ///Params:
    ///    celt = Number of items to retrieve.
    ///    rgelt = Array of IProgressItem interfaces. You must release each interface in rgelt when done.
    ///    pceltFetched = Number of elements returned in rgelt. You can set <i>pceltFetched</i> to <b>NULL</b> if <i>celt</i> is one.
    ///                   Otherwise, initialize the value of <i>pceltFetched</i> to 0 before calling this method.
    ///Returns:
    ///    S_OK is returned when the number of requested elements (<i>celt</i>) are returned successfully or the number
    ///    of returned items (<i>pceltFetched</i>) is less than the number of requested elements. Other success codes
    ///    may be returned as a result of implementation. The following error codes are commonly returned on operation
    ///    failure, but do not represent the only possible error values: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
    ///    </dl> </td> <td width="60%"> Failed to allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not
    ///    valid. Value: 0x80070057 </td> </tr> </table>
    ///    
    HRESULT Next(uint celt, IProgressItem* rgelt, uint* pceltFetched);
    ///Skips a specified number of items in the enumeration sequence.
    ///Params:
    ///    celt = Number of items to skip.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Skipped less than the number of requested elements.
    ///    </td> </tr> </table>
    ///    
    HRESULT Skip(uint celt);
    ///Resets the enumeration sequence to the beginning.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT Reset();
    ///Creates another enumerator that contains the same enumeration state as the current one.
    ///Params:
    ///    ppEnum = Receives the interface pointer to the enumeration object. If the method is unsuccessful, the value of this
    ///             output variable is undefined. You must release <i>ppEnum</i> when done.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT Clone(IEnumProgressItems* ppEnum);
}

///Use this interface to enumerate the progress items in a result image. A progress item represents a segment of the
///result image. To get this interface, call the IFileSystemImageResult::get_ProgressItems method.
@GUID("2C941FD7-975B-59BE-A960-9A2A262853A5")
interface IProgressItems : IDispatch
{
    ///Retrieves the list of progress items from the collection.
    ///Params:
    ///    NewEnum = An <b>IEnumVariant</b> interface that you use to enumerate the progress items contained within the
    ///              collection. Each item of the enumeration is a VARIANT whose type is <b>VT_DISPATCH</b>. Query the
    ///              <b>pdispVal</b> member to retrieve the IProgressItem interface.
    ///Returns:
    ///    S_OK is returned when the number of requested elements (<i>celt</i>) are returned successfully or the number
    ///    of returned items (<i>pceltFetched</i>) is less than the number of requested elements. The <i>celt</i> and
    ///    <i>pceltFetched</i> parameters are defined by <b>IEnumVariant</b>. Other success codes may be returned as a
    ///    result of implementation. The following error codes are commonly returned on operation failure, but do not
    ///    represent the only possible error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value:
    ///    0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate the required memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT get__NewEnum(IEnumVARIANT* NewEnum);
    ///Retrieves the specified progress item from the collection.
    ///Params:
    ///    Index = Zero-based index number corresponding to a progress item in the collection.
    ///    item = An IProgressItem interface associated with the specified index value.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One or more arguments are not valid. Value: 0x80070057 </td> </tr> </table>
    ///    
    HRESULT get_Item(int Index, IProgressItem* item);
    ///Retrieves the number of progress items in the collection.
    ///Params:
    ///    Count = Number of progress items in the collection.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Count(int* Count);
    ///Retrieves a progress item based on the specified block number.
    ///Params:
    ///    block = Block number of the progress item to retrieve. The method returns the progress item if the block number is in
    ///            the first and last block range of the item.
    ///    item = An IProgressItem interface associated with the specified block number.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> One or more arguments are not valid. Value: 0x80070057 </td> </tr> </table>
    ///    
    HRESULT ProgressItemFromBlock(uint block, IProgressItem* item);
    ///Retrieves a progress item based on the specified file name.
    ///Params:
    ///    description = String that contains the file name of the progress item to retrieve. The method returns the progress item if
    ///                  this string matches the value for item's description property.
    ///    item = An IProgressItem interface of the progress item associated with the specified file name.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> <i>description</i> is <b>NULL</b>. Value:0x80004005 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid.
    ///    Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Failed to allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. Value:
    ///    0x80070057 </td> </tr> </table>
    ///    
    HRESULT ProgressItemFromDescription(BSTR description, IProgressItem* item);
    ///Retrieves the list of progress items from the collection.
    ///Params:
    ///    NewEnum = An IEnumProgressItems interface that contains a collection of the progress items contained in the collection.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT get_EnumProgressItems(IEnumProgressItems* NewEnum);
}

///Use this interface to get information about the burn image, the image data stream, and progress information. To get
///this interface, call the IFileSystemImage::CreateResultImage method.
@GUID("2C941FD8-975B-59BE-A960-9A2A262853A5")
interface IFileSystemImageResult : IDispatch
{
    ///Retrieves the burn image stream.
    ///Params:
    ///    pVal = An IStream interface of the burn image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid or the <i>pstatstgis</i>
    ///    parameter of the IStream::Stat method is <b>NULL</b>. Value: 0x80004003 </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate necessary memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STG_E_INVALIDFUNCTION</b></dt> </dl> </td> <td
    ///    width="60%"> The <i>grfStateFlag</i> parameter of the IStream::Stat method is invalid. </td> </tr> </table>
    ///    
    HRESULT get_ImageStream(IStream* pVal);
    ///Retrieves the progress item block mapping collection.
    ///Params:
    ///    pVal = An IProgressItems interface that contains a collection of progress items. Each progress item identifies the
    ///           blocks written since the previous progress status was taken.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate
    ///    necessary memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT get_ProgressItems(IProgressItems* pVal);
    ///Retrieves the number of blocks in the result image.
    ///Params:
    ///    pVal = Number of blocks to burn on the disc.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_TotalBlocks(int* pVal);
    ///Retrieves the size, in bytes, of a block of data.
    ///Params:
    ///    pVal = Number of bytes in a block.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_BlockSize(int* pVal);
    ///Retrieves the disc volume name for this file system image.
    ///Params:
    ///    pVal = String that contains the volume name for this file system image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_DiscId(BSTR* pVal);
}

///The <b>IFileSystemImageResult2</b> interface allows the data recorder object to retrieve information about modified
///blocks in images created for rewritable discs. Alternatively, <b>IUnknown::QueryInterface</b> can be called on the
///object returned by IFileSystemImageResult::get_ImageStream to get the IBlockRangeList interface providing this
///information.
@GUID("B507CA29-2204-11DD-966A-001AA01BBC58")
interface IFileSystemImageResult2 : IFileSystemImageResult
{
    ///Retrieves the list of modified blocks in the result image.
    ///Params:
    ///    pVal = Pointer to an IBlockRangeList interface representing the modified block ranges in the result image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> Not implemented. Value:
    ///    0x80004001 </td> </tr> </table>
    ///    
    HRESULT get_ModifiedBlocks(IBlockRangeList* pVal);
}

///Base interface containing properties common to both file and directory items. To access the properties of this
///interface, use the IFsiFileItem or IFsiDirectoryItem interface.
@GUID("2C941FD9-975B-59BE-A960-9A2A262853A5")
interface IFsiItem : IDispatch
{
    ///Retrieves the name of the directory or file item in the file system image.
    ///Params:
    ///    pVal = String that contains the name of the file or directory item in the file system image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Name(BSTR* pVal);
    ///Retrieves the full path of the file or directory item in the file system image.
    ///Params:
    ///    pVal = String that contains the absolute path of the file or directory item in the file system image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_FullPath(BSTR* pVal);
    ///Retrieves the date and time that the directory or file item was created and added to the file system image.
    ///Params:
    ///    pVal = Date and time that the directory or file item was created and added to the file system image, according to
    ///           UTC time.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_CreationTime(double* pVal);
    ///Sets the date and time that the directory or file item was created and added to the file system image.
    ///Params:
    ///    newVal = Date and time that the directory or file item was created and added to the file system image, according to
    ///             UTC time. Defaults to the time the item was added to the image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_READONLY</b></dt> </dl> </td> <td width="60%"> FileSystemImage object is in read only mode.
    ///    Value: 0xC0AAB102 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Failed to allocate necessary memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT put_CreationTime(double newVal);
    ///Retrieves the date and time the directory or file item was last accessed in the file system image.
    ///Params:
    ///    pVal = Date and time that the item directory or file was last accessed in the file system image, according to UTC
    ///           time.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_LastAccessedTime(double* pVal);
    ///Sets the date and time that the directory or file item was last accessed in the file system image.
    ///Params:
    ///    newVal = Date and time that the directory or file item was last accessed in the file system image, according to UTC
    ///             time. Defaults to the time the item was added to the image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_READONLY</b></dt> </dl> </td> <td width="60%"> FileSystemImage object is in read only mode.
    ///    Value: 0xC0AAB102 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Failed to allocate necessary memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT put_LastAccessedTime(double newVal);
    ///Retrieves the date and time that the directory or file item was last modified in the file system image.
    ///Params:
    ///    pVal = Date and time that the directory or file item was last modified in the file system image, according to UTC
    ///           time.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_LastModifiedTime(double* pVal);
    ///Sets the date and time that the item was last modified in the file system image.
    ///Params:
    ///    newVal = Date and time that the directory or file item was last modified in the file system image, according to UTC
    ///             time. Defaults to the time the item was added to the image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_READONLY</b></dt> </dl> </td> <td width="60%"> FileSystemImage object is in read only mode.
    ///    Value: 0xC0AAB102 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Failed to allocate necessary memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT put_LastModifiedTime(double newVal);
    ///Determines if the item's hidden attribute is set in the file system image.
    ///Params:
    ///    pVal = Is VARIANT_TRUE if the hidden attribute of the item is marked in the file system image; otherwise,
    ///           VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_IsHidden(short* pVal);
    ///Determines if the item's hidden attribute is set in the file system image.
    ///Params:
    ///    newVal = Set to VARIANT_TRUE to set the hidden attribute of the item in the file system image; otherwise,
    ///             VARIANT_FALSE. The default is VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_READONLY</b></dt> </dl> </td> <td width="60%"> FileSystemImage object is in read only mode.
    ///    Value: 0xC0AAB102 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Failed to allocate necessary memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT put_IsHidden(short newVal);
    ///Retrieves the name of the item as modified to conform to the specified file system.
    ///Params:
    ///    fileSystem = File system to which the name should conform. For possible values, see the FsiFileSystems enumeration type.
    ///    pVal = String that contains the name of the item as it conforms to the specified file system. The name in the
    ///           IFsiItem::get_Name property is modified if the characters used and its length do not meet the requirements of
    ///           the specified file system type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The value
    ///    specified for parameter <i>%1!ls!</i> is not valid. Value: 0xC0AAB101 </td> </tr> </table>
    ///    
    HRESULT FileSystemName(FsiFileSystems fileSystem, BSTR* pVal);
    ///Retrieves the full path of the item as modified to conform to the specified file system.
    ///Params:
    ///    fileSystem = File system to which the path should conform. For possible values, see the FsiFileSystems enumeration type.
    ///    pVal = String that contains the full path of the item as it conforms to the specified file system. The path in the
    ///           IFsiItem::get_FullPath property is modified if the characters used and its length do not meet the
    ///           requirements of the specified file system type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The value
    ///    specified for parameter <i>%1!ls!</i> is not valid. Value: 0xC0AAB101 </td> </tr> </table>
    ///    
    HRESULT FileSystemPath(FsiFileSystems fileSystem, BSTR* pVal);
}

///Use this interface to enumerate the child directory and file items for a FsiDirectoryItem object. To get this
///interface, call the IFsiDirectoryItem::get_EnumFsiItems method.
@GUID("2C941FDA-975B-59BE-A960-9A2A262853A5")
interface IEnumFsiItems : IUnknown
{
    ///Retrieves a specified number of items in the enumeration sequence.
    ///Params:
    ///    celt = Number of items to retrieve.
    ///    rgelt = Array of IFsiItem interfaces. You must release each interface in rgelt when done.
    ///    pceltFetched = Number of elements returned in rgelt. You can set <i>pceltFetched</i> to <b>NULL</b> if <i>celt</i> is one.
    ///                   Otherwise, initialize the value of <i>pceltFetched</i> to 0 before calling this method.
    ///Returns:
    ///    S_OK is returned when the number of requested elements (<i>celt</i>) are returned successfully or the number
    ///    of returned items (<i>pceltFetched</i>) is less than the number of requested elements. Other success codes
    ///    may be returned as a result of implementation. The following error codes are commonly returned on operation
    ///    failure, but do not represent the only possible error values: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
    ///    </dl> </td> <td width="60%"> Failed to allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not
    ///    valid. Value: 0x80070057 </td> </tr> </table>
    ///    
    HRESULT Next(uint celt, IFsiItem* rgelt, uint* pceltFetched);
    ///Skips a specified number of items in the enumeration sequence.
    ///Params:
    ///    celt = Number of items to skip.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Skipped less than the number of requested elements.
    ///    </td> </tr> </table>
    ///    
    HRESULT Skip(uint celt);
    ///Resets the enumeration sequence to the beginning.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT Reset();
    ///Creates another enumerator that contains the same enumeration state as the current one.
    ///Params:
    ///    ppEnum = Receives the interface pointer to the enumeration object. If the method is unsuccessful, the value of this
    ///             output variable is undefined. You must release <i>ppEnum</i> when done.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT Clone(IEnumFsiItems* ppEnum);
}

///Use this interface to identify the file size and data stream of the file contents. To get this interface, call the
///IFileSystemImage::CreateFileItem method.
@GUID("2C941FDB-975B-59BE-A960-9A2A262853A5")
interface IFsiFileItem : IFsiItem
{
    ///Retrieves the number of bytes in the file.
    ///Params:
    ///    pVal = Size, in bytes, of the file.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_DataSize(long* pVal);
    ///Retrieves the least significant 32 bits of the IFsiFileItem::get_DataSize property.
    ///Params:
    ///    pVal = Least significant 32 bits of the IFsiFileItem::get_DataSize property.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_DataSize32BitLow(int* pVal);
    ///Retrieves the most significant 32 bits of the IFsiFileItem::get_DataSize property.
    ///Params:
    ///    pVal = Most significant 32 bits of the IFsiFileItem::get_DataSize property.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_DataSize32BitHigh(int* pVal);
    ///Retrieves the data stream of the file's content.
    ///Params:
    ///    pVal = An <b>IStream</b> interface of the contents of the file.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate
    ///    necessary memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT get_Data(IStream* pVal);
    ///Sets the data stream of the file's content.
    ///Params:
    ///    newVal = An <b>IStream</b> interface of the content of the file to add to the file system image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_READONLY</b></dt> </dl> </td> <td width="60%"> FileSystemImage
    ///    object is in read only mode. Value: 0xC0AAB102 </td> </tr> </table>
    ///    
    HRESULT put_Data(IStream newVal);
}

///Use this interface to add, remove and enumerate named streams associated with a file. This interface also provides
///access to the 'Real-Time' attribute of a file.
@GUID("199D0C19-11E1-40EB-8EC2-C8C822A07792")
interface IFsiFileItem2 : IFsiFileItem
{
    ///Retrieves a collection of named streams associated with a file in the file system image.
    ///Params:
    ///    streams = Pointer to an IFsiNamedStreams object that represents a collection of named streams associated with the file.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> <dt>Value: 0x80004003</dt> </dl> </td> <td width="60%"> Invalid pointer. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_PROPERTY_NOT_ACCESSIBLE</b></dt> <dt>Value: 0xC0AAB160L</dt>
    ///    </dl> </td> <td width="60%"> Property '<i>%1!ls!</i>' is not accessible. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> <dt>Value: 0x8007000E</dt> </dl> </td> <td width="60%"> Failed to allocate
    ///    necessary memory. </td> </tr> </table>
    ///    
    HRESULT get_FsiNamedStreams(IFsiNamedStreams* streams);
    ///Determines if the item is a named stream. Data streams for named streams contained within the file system image
    ///are read-only. Stream data can only be replaced by overwriting the existing named stream.
    ///Params:
    ///    pVal = Pointer to a value that indicates if the item is a named stream. to <b>VARIANT_TRUE</b> if an ; otherwise,
    ///           <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_IsNamedStream(short* pVal);
    ///Associates a named stream with a specific file in the file system image.
    ///Params:
    ///    name = A string represents the name of the named stream. This should not include the path and should only contain
    ///           valid characters as per file system naming conventions.
    ///    streamData = An <b>IStream</b> interface of the named stream used to write to the resultant file system image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_S_IMAGE_FEATURE_NOT_SUPPORTED</b></dt> <dt>Value: 0x00AAB15FL</dt> </dl> </td> <td width="60%">
    ///    Feature is not supported for the current file system revision, and as a result, will be created without this
    ///    feature. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> <dt>Value: 0x80004003</dt> </dl>
    ///    </td> <td width="60%"> Pointer is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PARAM</b></dt> <dt>Value: 0xC0AAB101</dt> </dl> </td> <td width="60%"> The value
    ///    specified for parameter '<i>%1!ls!</i>' is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_NOT_IN_FILE_SYSTEM</b></dt> <dt>Value: 0xC0AAB10B</dt> </dl> </td> <td width="60%">
    ///    <i>ls!'</i> is not part of the file system. It must be added to complete this operation. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>IMAPI_E_READONLY</b></dt> <dt>Value: 0xC0AAB102</dt> </dl> </td> <td width="60%">
    ///    The referenced IFileSystemImage object is in read only mode. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_FSI_INTERNAL_ERROR</b></dt> <dt>Value: 0xC0AAB100L</dt> </dl> </td> <td width="60%"> Internal
    ///    file system error has occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_DUP_NAME</b></dt>
    ///    <dt>Value: 0xC0AAB112L</dt> </dl> </td> <td width="60%"> <i>'%1!ls!'</i> name already exists. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_DATA_STREAM_READ_FAILURE</b></dt> <dt>Value: 0xC0AAB129L</dt> </dl>
    ///    </td> <td width="60%"> Cannot read data from stream supplied for file <i>'%1!ls!'</i>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>IMAPI_E_IMAGE_SIZE_LIMIT</b></dt> <dt>Value: 0xC0AAB120L</dt> </dl> </td> <td
    ///    width="60%"> Adding <i>'%1!ls!'</i> would result in a result image having a size larger than the current
    ///    configured limit. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_DATA_STREAM_INCONSISTENCY</b></dt>
    ///    <dt>Value: 0xC0AAB128L</dt> </dl> </td> <td width="60%"> The data stream supplied for the file
    ///    <i>'%1!ls!'</i> is inconsistent; expected <i>%2!I64d!</i> bytes, found <i>%3!I64d!</i> </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> <dt>Value: 0x8007000EL</dt> </dl> </td> <td width="60%">
    ///    Failed to allocate required memory. </td> </tr> </table>
    ///    
    HRESULT AddStream(BSTR name, IStream streamData);
    ///Removes a named stream association with a file.
    ///Params:
    ///    name = String that specifies the name of the named stream association to remove. This should not include the path
    ///           and should only contain valid characters as per file system naming conventions.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_S_IMAGE_FEATURE_NOT_SUPPORTED</b></dt> <dt>Value: 0x00AAB15FL</dt> </dl> </td> <td width="60%">
    ///    Feature is not supported for the current file system revision, and as a result, will be created without this
    ///    feature. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> <dt>Value: 0x80004003</dt> </dl>
    ///    </td> <td width="60%"> Pointer is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PARAM</b></dt> <dt>Value: 0xC0AAB101</dt> </dl> </td> <td width="60%"> The value
    ///    specified for parameter '<i>%1!ls!</i>' is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_NOT_IN_FILE_SYSTEM</b></dt> <dt>Value: 0xC0AAB10B</dt> </dl> </td> <td width="60%">
    ///    <i>ls!'</i> is not part of the file system. It must be added to complete this operation. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>IMAPI_E_READONLY</b></dt> <dt>Value: 0xC0AAB102</dt> </dl> </td> <td width="60%">
    ///    The referenced IFileSystemImage object is in read only mode. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_FSI_INTERNAL_ERROR</b></dt> <dt>Value: 0xC0AAB100L</dt> </dl> </td> <td width="60%"> Internal
    ///    file system error has occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_DUP_NAME</b></dt>
    ///    <dt>Value: 0xC0AAB112L</dt> </dl> </td> <td width="60%"> <i>'%1!ls!'</i> name already exists. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_DATA_STREAM_READ_FAILURE</b></dt> <dt>Value: 0xC0AAB129L</dt> </dl>
    ///    </td> <td width="60%"> Cannot read data from stream supplied for file <i>'%1!ls!'</i>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>IMAPI_E_IMAGE_SIZE_LIMIT</b></dt> <dt>Value: 0xC0AAB120L</dt> </dl> </td> <td
    ///    width="60%"> Adding <i>'%1!ls!'</i> would result in a result image having a size larger than the current
    ///    configured limit. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_DATA_STREAM_INCONSISTENCY</b></dt>
    ///    <dt>Value: 0xC0AAB128L</dt> </dl> </td> <td width="60%"> The data stream supplied for the file
    ///    <i>'%1!ls!'</i> is inconsistent; expected <i>%2!I64d!</i> bytes, found <i>%3!I64d!</i> </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> <dt>Value: 0x8007000EL</dt> </dl> </td> <td width="60%">
    ///    Failed to allocate required memory. </td> </tr> </table>
    ///    
    HRESULT RemoveStream(BSTR name);
    ///Retrieves the property value that specifies if a file item in the file system image is a 'Real-Time' or standard
    ///file.
    ///Params:
    ///    pVal = Pointer to a value that indicates if the Real-Time attribute of the file is set in the file system image. A
    ///           value of <b>VARIANT_TRUE</b>indicates the attribute is set; otherwise, <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> <dt>Value: 0x80004003</dt> </dl> </td> <td width="60%"> Pointer is not valid. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_PROPERTY_NOT_ACCESSIBLE</b></dt> <dt>Value: 0xC0AAB160L</dt>
    ///    </dl> </td> <td width="60%"> Property '<i>%1!ls!</i>' is not accessible. </td> </tr> </table>
    ///    
    HRESULT get_IsRealTime(short* pVal);
    ///Sets the 'Real-Time' attribute of a file in a file system. This attribute specifies whether or not the content
    ///requires a minimum data-transfer rate when writing or reading, for example, audio and video data.
    ///Params:
    ///    newVal = Specify <b>VARIANT_TRUE</b> to set the Real-Time attribute of a file in the file system image; otherwise,
    ///             <b>VARIANT_FALSE</b>. The default is <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_S_IMAGE_FEATURE_NOT_SUPPORTED</b></dt> <dt>Value: 0x00AAB15FL</dt> </dl> </td> <td width="60%">
    ///    Feature is not supported for the current file system revision, and as a result, the file has been marked as
    ///    Real-Time but will not appear as such in the resultant file system image unless UDF revision 2.01 or higher
    ///    is enabled in the file system object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_PROPERTY_NOT_ACCESSIBLE</b></dt> <dt>Value: 0xC0AAB160L</dt> </dl> </td> <td width="60%">
    ///    Property '<i>%1!ls!</i>' is not accessible. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PARAM</b></dt> <dt>Value: 0xC0AAB101</dt> </dl> </td> <td width="60%"> The value
    ///    specified for parameter '<i>%1!ls!</i>' is invalid. </td> </tr> </table> <div class="alert"><b>Note</b>
    ///    Currently, S_OK is returned when using this method to set a Real-Time attribute value of a file that is 'Read
    ///    Only' as a result of a successful CreateResultImage operation.</div> <div> </div>
    ///    
    HRESULT put_IsRealTime(short newVal);
}

///Use this interface to enumerate the named streams associated with a file in a file system image.
@GUID("ED79BA56-5294-4250-8D46-F9AECEE23459")
interface IFsiNamedStreams : IDispatch
{
    ///Retrieves an <b>IEnumVARIANT</b> list of the named streams associated with a file in the file system image.
    ///Params:
    ///    NewEnum = Pointer to a pointer to an <b>IEnumVariant</b> interface that is used to enumerate the named streams
    ///              associated with a file. The items of the enumeration are variants whose type is <b>VT_BSTR</b>. Use the
    ///              <b>bstrVal</b> member to retrieve the path to the named stream.
    ///Returns:
    ///    S_OK is returned when the number of requested elements (<i>celt</i>) are returned successfully or the number
    ///    of returned items (<i>pceltFetched</i>) is less than the number of requested elements. The <i>celt</i> and
    ///    <i>pceltFetched</i> parameters are defined by <b>IEnumVariant</b>. Other success codes may be returned as a
    ///    result of implementation. The following error codes are commonly returned on operation failure, but do not
    ///    represent the only possible error values: <table> <tr> <th>Return code/value</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> <dt>Value: 0x80004003</dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> <dt>Value:
    ///    0x8007000EL</dt> </dl> </td> <td width="60%"> Failed to allocate required memory. </td> </tr> </table>
    ///    
    HRESULT get__NewEnum(IEnumVARIANT* NewEnum);
    ///Retrieves a single named stream associated with a file in the file system image.
    ///Params:
    ///    index = This value indicates the position of the named stream within the collection. The index number is zero-based,
    ///            i.e. the first item is at location 0 of the collection.
    ///    item = Pointer to a pointer to an IFsiFileItem2 object representing the named stream at the position specified by
    ///           <i>index</i>. This parameter is set to <b>NULL</b> if the specified index is not within the collection
    ///           boundary.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> <dt>Value: 0x80004003</dt> </dl> </td> <td width="60%"> Pointer is not valid. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_INVALID_PARAM</b></dt> <dt>Value: 0xC0AAB101</dt> </dl> </td>
    ///    <td width="60%"> The value specified for parameter '<i>%1!ls!</i>' is invalid. </td> </tr> </table>
    ///    
    HRESULT get_Item(int index, IFsiFileItem2* item);
    ///Returns the number of the named streams associated with a file in the file system image.
    ///Params:
    ///    count = Pointer to a value indicating the total number of named streams in the collection.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> <dt>Value: 0x80004003</dt> </dl> </td> <td width="60%"> Pointer is not valid. </td>
    ///    </tr> </table>
    ///    
    HRESULT get_Count(int* count);
    ///Creates a non-variant enumerator for the collection of the named streams associated with a file in the file
    ///system image.
    ///Params:
    ///    NewEnum = Pointer to a pointer to an IEnumFsiItems object representing a collection of named streams associated with a
    ///              file.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> <dt>Value: 0x80004003</dt> </dl> </td> <td width="60%"> Pointer is not valid. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> <dt>Value: 0x8007000EL</dt> </dl> </td> <td
    ///    width="60%"> Failed to allocate required memory. </td> </tr> </table>
    ///    
    HRESULT get_EnumNamedStreams(IEnumFsiItems* NewEnum);
}

///Use this interface to add items to or remove items from the file-system image. To get this interface, call the
///IFileSystemImage::CreateDirectoryItem method.
@GUID("2C941FDC-975B-59BE-A960-9A2A262853A5")
interface IFsiDirectoryItem : IFsiItem
{
    ///Retrieves a list of child items contained within the directory in the file system image.
    ///Params:
    ///    NewEnum = An <b>IEnumVariant</b> interface that you use to enumerate the child items contained within the directory.
    ///              The items of the enumeration are variants whose type is <b>VT_BSTR</b>. Use the <b>bstrVal</b> member to
    ///              retrieve the path to the child item.
    ///Returns:
    ///    S_OK is returned when the number of requested elements (<i>celt</i>) are returned successfully or the number
    ///    of returned items (<i>pceltFetched</i>) is less than the number of requested elements. The <i>celt</i> and
    ///    <i>pceltFetched</i> parameters are defined by <b>IEnumVariant</b>. Other success codes may be returned as a
    ///    result of implementation. The following error codes are commonly returned on operation failure, but do not
    ///    represent the only possible error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value:
    ///    0x80004003 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Failed to allocate necessary memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT get__NewEnum(IEnumVARIANT* NewEnum);
    ///Retrieves the specified directory or file item from file system image.
    ///Params:
    ///    path = String that contains the path to the item to retrieve.
    ///    item = An IFsiItem interface of the requested directory or file item.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PATH</b></dt> </dl> </td> <td width="60%"> Path '%1!s!' is badly formed or contains
    ///    invalid characters. Value: 0xC0AAB110 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The value specified for parameter
    ///    <i>%1!ls!</i> is not valid. Value: 0xC0AAB101 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_ITEM_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> Cannot find item <i>%1!ls!</i> in
    ///    FileSystemImage hierarchy. Value: 0xC0AAB118 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate necessary memory. Value:
    ///    0x8007000E </td> </tr> </table>
    ///    
    HRESULT get_Item(BSTR path, IFsiItem* item);
    ///Number of child items in the enumeration.
    ///Params:
    ///    Count = Number of directory and file items within the directory in the file system image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_Count(int* Count);
    ///Retrieves a list of child items contained within the directory in the file system image.
    ///Params:
    ///    NewEnum = An IEnumFsiItems interface that contains a collection of the child directory and file items contained within
    ///              the directory.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate
    ///    necessary memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT get_EnumFsiItems(IEnumFsiItems* NewEnum);
    ///Adds a directory to the file system image.
    ///Params:
    ///    path = String that contains the relative path of directory to create. Specify the full path when calling this method
    ///           from the root directory item.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PATH</b></dt> </dl> </td> <td width="60%"> Path '%1!s!' is badly formed or contains
    ///    invalid characters. Value: 0xC0AAB110 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The value specified for parameter
    ///    <i>%1!ls!</i> is not valid. Value: 0xC0AAB101 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>
    ///    IMAPI_E_NOT_IN_FILE_SYSTEM</b></dt> </dl> </td> <td width="60%"> <i>ls!'</i> is not part of the file system.
    ///    It must be added to complete this operation. Value: 0xC0AAB10B </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_READONLY</b></dt> </dl> </td> <td width="60%"> FileSystemImage object is in read only mode.
    ///    Value: 0xC0AAB102 </td> </tr> </table>
    ///    
    HRESULT AddDirectory(BSTR path);
    ///Adds a file to the file system image.
    ///Params:
    ///    path = String that contains the relative path of the directory to contain the new file. Specify the full path when
    ///           calling this method from the root directory item.
    ///    fileData = An <b>IStream</b> interface of the file (data stream) to write to the media.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PATH</b></dt> </dl> </td> <td width="60%"> Path '%1!s!' is badly formed or contains
    ///    invalid characters. Value: 0xC0AAB110 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The value specified for parameter
    ///    <i>%1!ls!</i> is not valid. Value: 0xC0AAB101 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>
    ///    IMAPI_E_NOT_IN_FILE_SYSTEM</b></dt> </dl> </td> <td width="60%"> <i>ls!'</i> is not part of the file system.
    ///    It must be added to complete this operation. Value: 0xC0AAB10B </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_READONLY</b></dt> </dl> </td> <td width="60%"> FileSystemImage object is in read only mode.
    ///    Value: 0xC0AAB102 </td> </tr> </table>
    ///    
    HRESULT AddFile(BSTR path, IStream fileData);
    ///Adds the contents of a directory tree to the file system image.
    ///Params:
    ///    sourceDirectory = String that contains the relative path of the directory tree to create. Specify the full path when calling
    ///                      this method from the root directory item.
    ///    includeBaseDirectory = Set to VARIANT_TRUE to include the directory in <i>sourceDirectory</i> as a subdirectory in the file system
    ///                           image. Otherwise, VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    Pointer is not valid. Value: 0x80004003 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_DIRECTORY_READ_FAILURE</b></dt> </dl> </td> <td width="60%"> Failure enumerating files in the
    ///    directory tree is inaccessible due to permissions. Value: 0xC0AAB12BL </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_DATA_STREAM_CREATE_FAILURE</b></dt> </dl> </td> <td width="60%"> One or more of the files in
    ///    the directory tree is inaccessible due to permissions. Value: 0xC0AAB12A </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>IMAPI_E_DATA_STREAM_READ_FAILURE</b></dt> </dl> </td> <td width="60%"> Cannot read data from
    ///    stream supplied for file '%1!ls!'. Value: 0xC0AAB129 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The value specified for parameter
    ///    <i>%1!ls!</i> is not valid. Value: 0xC0AAB101 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>
    ///    IMAPI_E_NOT_IN_FILE_SYSTEM</b></dt> </dl> </td> <td width="60%"> <i>ls!'</i> is not part of the file system.
    ///    It must be added to complete this operation. Value: 0xC0AAB10B </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_READONLY</b></dt> </dl> </td> <td width="60%"> FileSystemImage object is in read only mode.
    ///    Value: 0xC0AAB102 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_IMAGE_SIZE_LIMIT </b></dt> </dl>
    ///    </td> <td width="60%"> Adding this file or directory would result in a result image having a size larger than
    ///    the current configured limit. Value: 0xC0AAB120 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PATH</b></dt> </dl> </td> <td width="60%"> Path '%1!s!' is badly formed or contains
    ///    invalid characters. Value: 0xC0AAB110 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_DUP_NAME</b></dt>
    ///    </dl> </td> <td width="60%"> ls!' name already exists. Value: 0xC0AAB112 </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>IMAPI_E_NO_UNIQUE_NAME</b></dt> </dl> </td> <td width="60%"> Attempt to add '%1!ls!' failed:
    ///    cannot create a file-system-specific unique name for the %2!ls! file system. Value: 0xC0AAB113 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_ISO9660_LEVELS</b></dt> </dl> </td> <td width="60%"> ISO9660 is
    ///    limited to 8 levels of directories. Value: 0xC0AAB131 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_TOO_MANY_DIRS</b></dt> </dl> </td> <td width="60%"> This file system image has too many
    ///    directories for the %1!ls! file system. Value: 0xC0AAB130 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_DIR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The directory '%1!s!' not found in
    ///    FileSystemImage hierarchy. Value: 0xC0AAB11A </td> </tr> </table> <div class="alert"><b>Note</b> Values
    ///    returned by the GetFileAttributesEx and FindFirstFile functions may also be returned here.</div> <div> </div>
    ///    
    HRESULT AddTree(BSTR sourceDirectory, short includeBaseDirectory);
    ///Adds a file or directory described by the IFsiItem object to the file system image.
    ///Params:
    ///    item = An IFsiItem interface of the IFsiFileItemor IFsiDirectoryItem to add to the file system image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_INVALID_PATH</b></dt> </dl> </td> <td width="60%"> Path '%1!s!' is
    ///    badly formed or contains invalid characters. Value: 0xC0AAB110 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_DATA_STREAM_READ_FAILURE</b></dt> </dl> </td> <td width="60%"> Cannot read data from stream
    ///    supplied for file '%1!ls!'. Value: 0xC0AAB129 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_DUP_NAME</b></dt> </dl> </td> <td width="60%"> ls!' name already exists. Value: 0xC0AAB112
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_NO_UNIQUE_NAME</b></dt> </dl> </td> <td width="60%">
    ///    Attempt to add '%1!ls!' failed: cannot create a file-system-specific unique name for the %2!ls! file system.
    ///    Value: 0xC0AAB113 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_IMAGE_SIZE_LIMIT</b></dt> </dl> </td>
    ///    <td width="60%"> Adding '%1!ls!' would result in a result image having a size larger than the current
    ///    configured limit. Value: 0xC0AAB120 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_ISO9660_LEVELS</b></dt> </dl> </td> <td width="60%"> ISO9660 is limited to 8 levels of
    ///    directories. Value: 0xC0AAB131 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_TOO_MANY_DIRS</b></dt>
    ///    </dl> </td> <td width="60%"> This file system image has too many directories for the %1!ls! file system.
    ///    Value: 0xC0AAB130 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_DIR_NOT_FOUND</b></dt> </dl> </td>
    ///    <td width="60%"> The directory '%1!s!' not found in FileSystemImage hierarchy. Value: 0xC0AAB11A </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b> IMAPI_E_NOT_IN_FILE_SYSTEM</b></dt> </dl> </td> <td width="60%"> This file
    ///    or directory is not part of the file system. It must be added to complete this operation. Value: 0xC0AAB10B
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_READONLY</b></dt> </dl> </td> <td width="60%">
    ///    FileSystemImage object is in read only mode. Value: 0xC0AAB102 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_IMAGE_SIZE_LIMIT </b></dt> </dl> </td> <td width="60%"> Adding this file or directory would
    ///    result in a result image having a size larger than the current configured limit. Value: 0xC0AAB120 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to
    ///    allocate the required memory. Value: 0x8007000E </td> </tr> </table> <div class="alert"><b>Note</b> Values
    ///    returned by the IUnknown::QueryInterface method may also be returned here.</div> <div> </div>
    ///    
    HRESULT Add(IFsiItem item);
    ///Removes the specified item from the file system image.
    ///Params:
    ///    path = String that contains the relative path of the item to remove. The path is relative to current directory item.
    ///           Specify the full path when calling this method from the root directory item.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PATH</b></dt> </dl> </td> <td width="60%"> Path '%1!s!' is badly formed or contains
    ///    invalid characters. Value: 0xC0AAB110 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
    ///    </dl> </td> <td width="60%"> Failed to allocate necessary memory. Value: 0x8007000E </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The value specified for
    ///    parameter <i>%1!ls!</i> is not valid. Value: 0xC0AAB101 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>
    ///    IMAPI_E_NOT_IN_FILE_SYSTEM</b></dt> </dl> </td> <td width="60%"> <i>ls!'</i> is not part of the file system.
    ///    It must be added to complete this operation. Value: 0xC0AAB10B </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_READONLY</b></dt> </dl> </td> <td width="60%"> FileSystemImage object is in read only mode.
    ///    Value: 0xC0AAB102 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_DIR_NOT_EMPTY</b></dt> </dl> </td>
    ///    <td width="60%"> The directory <i>%1!s!</i> is not empty. Value: 0xC0AAB10A </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>IMAPI_E_FSI_INTERNAL_ERROR</b></dt> </dl> </td> <td width="60%"> Internal error occurred:
    ///    <i>%1!ls!</i>. Value: 0xC0AAB100 </td> </tr> </table>
    ///    
    HRESULT Remove(BSTR path);
    ///Remove the specified directory tree from the file system image.
    ///Params:
    ///    path = String that contains the name of directory to remove. The path is relative to current directory item.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>path</i> parameter is not a valid pointer.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The
    ///    value specified for parameter <i>%1!ls!</i> is not valid. Value: 0xC0AAB101 </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>IMAPI_E_INVALID_PATH</b></dt> </dl> </td> <td width="60%"> Path '%1!s!' is badly formed or
    ///    contains invalid characters. Value: 0xC0AAB110 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>
    ///    IMAPI_E_NOT_IN_FILE_SYSTEM</b></dt> </dl> </td> <td width="60%"> <i>ls!'</i> is not part of the file system.
    ///    It must be added to complete this operation. Value: 0xC0AAB10B </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_READONLY</b></dt> </dl> </td> <td width="60%"> FileSystemImage object is in read only mode.
    ///    Value: 0xC0AAB102 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_DIR_NOT_FOUND</b></dt> </dl> </td>
    ///    <td width="60%"> The specified directory does not exist. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_DIR_NOT_EMPTY</b></dt> </dl> </td> <td width="60%"> The directory <i>%1!s!</i> is not empty.
    ///    Value: 0xC0AAB10A </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_FSI_INTERNAL_ERROR</b></dt> </dl>
    ///    </td> <td width="60%"> Internal error occurred: <i>%1!ls!</i>. Value: 0xC0AAB100 </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>IMAPI_E_NOT_DIR</b></dt> </dl> </td> <td width="60%"> Specified path <i>%1!ls!</i>
    ///    does not identify a directory. Value: 0xC0AAB109 </td> </tr> </table>
    ///    
    HRESULT RemoveTree(BSTR path);
}

///Use this interface to add a directory tree, which includes all sub-directories, files, and associated named streams
///to a file system image.
@GUID("F7FB4B9B-6D96-4D7B-9115-201B144811EF")
interface IFsiDirectoryItem2 : IFsiDirectoryItem
{
    ///Adds the contents of a directory tree along with named streams associated with all files to the file system
    ///image.
    ///Params:
    ///    sourceDirectory = String that contains the relative path of the directory tree to create. The path should contain only valid
    ///                      characters as per file system naming conventions. This parameter cannot be <b>NULL</b>. <div
    ///                      class="alert"><b>Note</b> You must specify the full path when calling this method from the root directory
    ///                      item.</div> <div> </div>
    ///    includeBaseDirectory = Set to <b>VARIANT_TRUE</b> to include the directory in <i>sourceDirectory</i> as a subdirectory in the file
    ///                           system image. Otherwise, <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_S_IMAGE_FEATURE_NOT_SUPPORTED</b></dt> <dt>Value: 0x00AAB15FL</dt> </dl> </td> <td width="60%">
    ///    Feature is not supported for the current file system revision, and as a result, will be created without this
    ///    feature. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_INVALID_PARAM</b></dt> <dt>Value:
    ///    0xC0AAB101</dt> </dl> </td> <td width="60%"> The value specified for parameter '<i>%1!ls!</i>' is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_NOT_IN_FILE_SYSTEM</b></dt> <dt>Value: 0xC0AAB10B</dt>
    ///    </dl> </td> <td width="60%"> <i>ls!'</i> is not part of the file system. It must be added to complete this
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_DATA_STREAM_CREATE_FAILURE</b></dt>
    ///    <dt>Value: Value: 0xC0AAB12AL</dt> </dl> </td> <td width="60%"> Error occurred while creating data stream for
    ///    <i>'%1!ls!'</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_DATA_STREAM_READ_FAILURE</b></dt>
    ///    <dt>Value: 0xC0AAB129L</dt> </dl> </td> <td width="60%"> Cannot read data from stream supplied for file
    ///    <i>'%1!ls!'</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_READONLY</b></dt> <dt>Value:
    ///    0xC0AAB102</dt> </dl> </td> <td width="60%"> The referenced IFileSystemImage object is in read only mode.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_DUP_NAME</b></dt> <dt>Value: 0xC0AAB112L</dt> </dl>
    ///    </td> <td width="60%"> <i>'%1!ls!'</i> name already exists. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_IMAGE_SIZE_LIMIT</b></dt> <dt>Value: 0xC0AAB120L</dt> </dl> </td> <td width="60%"> Adding
    ///    <i>'%1!ls!'</i> would result in a result image having a size larger than the current configured limit. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_DATA_STREAM_INCONSISTENCY</b></dt> <dt>Value:
    ///    0xC0AAB128L</dt> </dl> </td> <td width="60%"> The data stream supplied for the file <i>'%1!ls!'</i> is
    ///    inconsistent; expected <i>%2!I64d!</i> bytes, found <i>%3!I64d!</i> </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> <dt>Value: 0x8007000EL</dt> </dl> </td> <td width="60%"> Failed to allocate
    ///    required memory. </td> </tr> </table>
    ///    
    HRESULT AddTreeWithNamedStreams(BSTR sourceDirectory, short includeBaseDirectory);
}

///Use this interface to build a file system image, set session parameter, and import or export an image. The file
///system directory hierarchy is built by adding directories and files to the root or child directories. To create an
///instance of this interface, call the <b>CoCreateInstance</b> function. Use__uuidof(MsftFileSystemImage) for the class
///identifier and __uuidof(IFileSystemImage) for the interface identifier.
@GUID("2C941FE1-975B-59BE-A960-9A2A262853A5")
interface IFileSystemImage : IDispatch
{
    ///Retrieves the root directory item.
    ///Params:
    ///    pVal = An IFsiDirectoryItem interface of the root directory item.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT get_Root(IFsiDirectoryItem* pVal);
    ///Retrieves the starting block address for the recording session.
    ///Params:
    ///    pVal = Starting block address for the recording session.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_SessionStartBlock(int* pVal);
    ///Sets the starting block address for the recording session.
    ///Params:
    ///    newVal = Block number of the new recording session.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT put_SessionStartBlock(int newVal);
    ///Retrieves the maximum number of blocks available for the image.
    ///Params:
    ///    pVal = Number of blocks to use in creating the file system image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_FreeMediaBlocks(int* pVal);
    ///Sets the maximum number of blocks available for the image.
    ///Params:
    ///    newVal = Number of blocks to use in creating the file system image. By default, 332,800 blocks are used to create the
    ///             file system image. This value assumes a capacity of 74 minutes of audio per 650MB disc. To specify an
    ///             infinite number of block, set <i>newVal</i> to zero.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_IMAGE_TOO_BIG</b></dt> </dl> </td> <td width="60%"> Value specified for FreeMediaBlocks
    ///    property is too small for estimated image size based on current data. Value: 0xC0AAB121 </td> </tr> </table>
    ///    
    HRESULT put_FreeMediaBlocks(int newVal);
    ///Set maximum number of blocks available based on the capabilities of the recorder.
    ///Params:
    ///    discRecorder = An IDiscRecorder2 interface that identifies the recording device from which you want to set the maximum
    ///                   number of blocks available.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_FSI_INTERNAL_ERROR</b></dt> </dl> </td> <td width="60%"> Internal
    ///    error occurred: <i>%1!ls!</i>. </td> </tr> </table>
    ///    
    HRESULT SetMaxMediaBlocksFromDevice(IDiscRecorder2 discRecorder);
    ///Retrieves the number of blocks in use.
    ///Params:
    ///    pVal = Estimated number of blocks used in the file-system image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_UsedBlocks(int* pVal);
    ///Retrieves the volume name for this file system image.
    ///Params:
    ///    pVal = String that contains the volume name for this file system image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_VolumeName(BSTR* pVal);
    ///Sets the volume name for this file system image.
    ///Params:
    ///    newVal = String that contains the volume name for this file system image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_VOLUME_NAME</b></dt> </dl> </td> <td width="60%"> The value specified for parameter
    ///    <i>%1!ls!</i> is not valid. Value: 0xC0AAB101 </td> </tr> </table>
    ///    
    HRESULT put_VolumeName(BSTR newVal);
    ///Retrieves the volume name provided from an imported file system.
    ///Params:
    ///    pVal = String that contains the volume name provided from an imported file system. Is <b>NULL</b> until a file
    ///           system is imported.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_ImportedVolumeName(BSTR* pVal);
    ///Retrieves the boot image that you want to add to the file system image.
    ///Params:
    ///    pVal = An IBootOptions interface of the boot image to add to the disc. Is <b>NULL</b> if a boot image has not been
    ///           specified.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_BOOT_OBJECT_CONFLICT</b></dt> </dl> </td> <td width="60%"> A boot
    ///    object can only be included in an initial disc image. Value: 0xC0AAB149 </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>IMAPI_E_BOOT_IMAGE_DATA</b></dt> </dl> </td> <td width="60%"> The boot object could not be added
    ///    to the image. Value: 0xC0AAB148 </td> </tr> </table>
    ///    
    HRESULT get_BootImageOptions(IBootOptions* pVal);
    ///Sets the boot image that you want to add to the file-system image. This method creates a complete copy of the
    ///passed-in boot options by copying the stream from the supplied IBootOptions interface.
    ///Params:
    ///    newVal = An IBootOptions interface of the boot image that you want to add to the file-system image. Can be
    ///             <b>NULL</b>.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_BOOT_OBJECT_CONFLICT</b></dt> </dl> </td> <td width="60%"> A boot object can only be included
    ///    in an initial disc image. Value: 0xC0AAB149 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_BOOT_IMAGE_DATA</b></dt> </dl> </td> <td width="60%"> The boot object could not be added to
    ///    the image. Value: 0xC0AAB148 </td> </tr> </table>
    ///    
    HRESULT put_BootImageOptions(IBootOptions newVal);
    ///Retrieves the number of files in the file system image.
    ///Params:
    ///    pVal = Number of files in the file system image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_FileCount(int* pVal);
    ///Retrieves the number of directories in the file system image.
    ///Params:
    ///    pVal = Number of directories in the file system image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_DirectoryCount(int* pVal);
    ///Retrieves the temporary directory in which stash files are built.
    ///Params:
    ///    pVal = String that contains the path to the temporary directory.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_WorkingDirectory(BSTR* pVal);
    ///Sets the temporary directory in which stash files are built.
    ///Params:
    ///    newVal = String that contains the path to the temporary working directory. The default is the current temp directory.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The value specified for parameter
    ///    <i>%1!ls!</i> is not valid. Value: 0xC0AAB101 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_WORKING_DIRECTORY</b></dt> </dl> </td> <td width="60%"> The working directory
    ///    <i>%1!ls!</i> is not valid. Value: 0xC0AAB140 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_WORKING_DIRECTORY_SPACE</b></dt> </dl> </td> <td width="60%"> Cannot set working directory to
    ///    <i>%1!ls!</i>. Space available is <i>%2!I64d!</i> bytes, approximately <i>%3!I64d!</i> bytes required. Value:
    ///    0xC0AAB141 </td> </tr> </table>
    ///    
    HRESULT put_WorkingDirectory(BSTR newVal);
    ///Retrieves the change point identifier.
    ///Params:
    ///    pVal = Change point identifier. The identifier is a count of the changes to the file system image since its
    ///           inception.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_ChangePoint(int* pVal);
    ///Determines the compliance level for creating and developing the file-system image.
    ///Params:
    ///    pVal = Is VARIANT_TRUE if the file system images are created in strict compliance with applicable standards. Is
    ///           VARIANT_FALSE if the compliance standards are relaxed to be compatible with IMAPI version 1.0.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_StrictFileSystemCompliance(short* pVal);
    ///Determines the compliance level for creating and developing the file-system image.
    ///Params:
    ///    newVal = Set to VARIANT_TRUE to create the file system images in strict compliance with applicable standards. You can
    ///             specify VARIANT_TRUE only when the file system image is empty. Set to VARIANT_FALSE to relax the compliance
    ///             standards to be compatible with IMAPI version 1.0. The default is VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT put_StrictFileSystemCompliance(short newVal);
    ///Determines if the file and directory names use a restricted character.
    ///Params:
    ///    pVal = Is VARIANT_TRUE if the file and directory names to add to the file system image must consist of characters
    ///           that map directly to CP_ANSI (code points 32 through 127). Otherwise, VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_UseRestrictedCharacterSet(short* pVal);
    ///Determines if file and directory names should be restricted to using only CP_ANSI characters. <div
    ///class="alert"><b>Note</b> <b>IFileSystemImage::put_UseRestrictedCharacterSet</b> has been deprecated.
    ///Implementing this method is not recommended.</div> <div> </div>
    ///Params:
    ///    newVal = Set to VARIANT_TRUE to restrict file and directory names to use only CP_ANSI characters. Otherwise,
    ///             VARIANT_FALSE. The default is VARIANT_FALSE.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT put_UseRestrictedCharacterSet(short newVal);
    ///Retrieves the types of file systems to create when generating the result stream.
    ///Params:
    ///    pVal = One or more file system types to create when generating the result stream. For possible values, see the
    ///           FsiFileSystems enumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_FileSystemsToCreate(FsiFileSystems* pVal);
    ///Sets the file systems to create when generating the result stream.
    ///Params:
    ///    newVal = One or more file systems to create when generating the result stream. For possible values, see the
    ///             FsiFileSystems enumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The value specified for parameter
    ///    <i>%1!ls!</i> is not valid. Value: 0xC0AAB101 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_TOO_MANY_DIRS</b></dt> </dl> </td> <td width="60%"> This file system image has too many
    ///    directories for the <i>%1!ls!</i> file system. Value: 0xC0AAB130 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_FILE_SYSTEM_CHANGE_NOT_ALLOWED</b></dt> </dl> </td> <td width="60%"> You cannot change the
    ///    file system specified for creation, because the file system in the imported session and the one in the new
    ///    session do not match. Value: 0xC0AAB163L </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_ISO9660_LEVELS</b></dt> </dl> </td> <td width="60%"> ISO9660 is limited to 8 levels of
    ///    directories. Value: 0xC0AAB131 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INCOMPATIBLE_PREVIOUS_SESSION</b></dt> </dl> </td> <td width="60%"> You cannot change the file
    ///    system specified for creation, because the file system from the imported session and the file system in the
    ///    current session do not match. Value: 0xC0AAB133 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_S_IMAGE_FEATURE_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This feature is not
    ///    supported for the current file system revision. The image will be created without this feature. Value:
    ///    0x00AAB15FL </td> </tr> </table>
    ///    
    HRESULT put_FileSystemsToCreate(FsiFileSystems newVal);
    ///Retrieves the list of file system types that a client can use to build a file system image.
    ///Params:
    ///    pVal = One or more file system types that a client can use to build a file system image. For possible values, see
    ///           the FsiFileSystems enumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_FileSystemsSupported(FsiFileSystems* pVal);
    ///Sets the UDF revision level of the file system image.
    ///Params:
    ///    newVal = A hexadecimal number representing the UDF revision level.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The value specified for parameter
    ///    <i>%1!ls!</i> is not valid. Value: 0xC0AAB101 </td> </tr> </table>
    ///    
    HRESULT put_UDFRevision(int newVal);
    ///Retrieves the UDF revision level of the imported file system image.
    ///Params:
    ///    pVal = UDF revision level of the imported file system image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_UDFRevision(int* pVal);
    ///Retrieves a list of supported UDF revision levels.
    ///Params:
    ///    pVal = List of supported UDF revision levels. Each element of the list is VARIANT. The variant type is <b>VT_I4</b>.
    ///           The <b>lVal</b> member of the variant contains the revision level.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_UDFRevisionsSupported(SAFEARRAY** pVal);
    ///Sets the default file system types and the image size based on the current media.
    ///Params:
    ///    discRecorder = An IDiscRecorder2 the identifies the device that contains the current media.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_IMAPI_RECORDER_MEDIA_INCOMPATIBLE</b></dt> </dl> </td> <td width="60%">
    ///    The media is not compatible or of unknown physical format. Value: 0xC0AA0203 </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>IMAPI_E_IMAGE_TOO_BIG</b></dt> </dl> </td> <td width="60%"> Value specified for
    ///    FreeMediaBlocks property is too small for estimated image size based on current data. Value: 0xC0AAB121 </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_NO_SUPPORTED_FILE_SYSTEM</b></dt> </dl> </td> <td
    ///    width="60%"> The specified disc does not contain one of the supported file systems. Value: 0xC0AAB151 </td>
    ///    </tr> </table>
    ///    
    HRESULT ChooseImageDefaults(IDiscRecorder2 discRecorder);
    ///Sets the default file system types and the image size based on the specified media type.
    ///Params:
    ///    value = Identifies the physical media type that will receive the burn image. For possible values, see the
    ///            IMAPI_MEDIA_PHYSICAL_TYPE enumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The value specified for parameter
    ///    <i>%1!ls!</i> is not valid. Value: 0xC0AAB101 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_IMAGE_TOO_BIG</b></dt> </dl> </td> <td width="60%"> Value specified for FreeMediaBlocks
    ///    property is too small for estimated image size based on current data. Value: 0xC0AAB121 </td> </tr> </table>
    ///    
    HRESULT ChooseImageDefaultsForMediaType(IMAPI_MEDIA_PHYSICAL_TYPE value);
    ///Sets the ISO9660 compatibility level of the file system image.
    ///Params:
    ///    newVal = ISO9660 compatibility level of the file system image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The value specified for parameter
    ///    <i>%1!ls!</i> is not valid. Value: 0xC0AAB101 </td> </tr> </table>
    ///    
    HRESULT put_ISO9660InterchangeLevel(int newVal);
    ///Retrieves the ISO9660 compatibility level to use when creating the result image.
    ///Params:
    ///    pVal = Identifies the interchange level of the ISO9660 file system.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_ISO9660InterchangeLevel(int* pVal);
    ///Retrieves the supported ISO9660 compatibility levels.
    ///Params:
    ///    pVal = List of supported ISO9660 compatibility levels. Each item in the list is a VARIANT that identifies one
    ///           supported interchange level. The variant type is <b>VT_UI4</b>. The <b>ulVal</b> member of the variant
    ///           contains the compatibility level.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_ISO9660InterchangeLevelsSupported(SAFEARRAY** pVal);
    ///Create the result object that contains the file system and file data.
    ///Params:
    ///    resultStream = An IFileSystemImageResult interface of the image result. Client applications can stream the image to media or
    ///                   other long-term storage devices, such as disk drives.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The value specified for parameter
    ///    <i>%1!ls!</i> is not valid. Value: 0xC0AAB101 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> </table>
    ///    
    HRESULT CreateResultImage(IFileSystemImageResult* resultStream);
    ///Checks for the existence of a given file or directory.
    ///Params:
    ///    fullPath = String that contains the fully qualified path of the directory or file to check.
    ///    itemType = Indicates if the item is a file, a directory, or does not exist. For possible values, see the FsiItemType
    ///               enumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The value
    ///    specified for parameter <i>%1!ls!</i> is not valid. Value: 0xC0AAB101 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PATH</b></dt> </dl> </td> <td width="60%"> The specified path is not fully qualified.
    ///    The path must begin with '\\' or '/' to indicate the image root, or the images position within a directory
    ///    structure. Value: 0xC0AAB110 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_DIR_NOT_FOUND</b></dt>
    ///    </dl> </td> <td width="60%"> The directory '%1!s!' not found in FileSystemImage hierarchy. Value: 0xC0AAB11A
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> The object
    ///    doesn't support this interface. Value: 0x80004002 </td> </tr> </table>
    ///    
    HRESULT Exists(BSTR fullPath, FsiItemType* itemType);
    ///Retrieves a string that identifies a disc and the sessions recorded on the disc.
    ///Params:
    ///    discIdentifier = String that contains a signature that identifies the disc and the sessions on it. This string is not
    ///                     guaranteed to be unique between discs.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_MULTISESSION_NOT_SET</b></dt> </dl> </td> <td width="60%">
    ///    MultisessionInterfaces property must be set prior calling this method. Value: 0xC0AAB15D </td> </tr> </table>
    ///    
    HRESULT CalculateDiscIdentifier(BSTR* discIdentifier);
    ///Retrieves a list of the different types of file systems on the optical media.
    ///Params:
    ///    discRecorder = An IDiscRecorder2 interface that identifies the recording device that contains the media. If this parameter
    ///                   is <b>NULL</b>, the <i>discRecorder</i> specified in IMultisession will be used.
    ///    fileSystems = One or more files systems on the disc. For possible values, see FsiFileSystems enumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT IdentifyFileSystemsOnDisc(IDiscRecorder2 discRecorder, FsiFileSystems* fileSystems);
    ///Retrieves the file system to import by default.
    ///Params:
    ///    fileSystems = One or more file system values. For possible values, see the FsiFileSystems enumeration type.
    ///    importDefault = A single file system value that identifies the default file system. The value is one of the file systems
    ///                    specified in <i>fileSystems</i>
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The value
    ///    specified for parameter <i>%1!ls!</i> is not valid. Value: 0xC0AAB101 </td> </tr> </table>
    ///    
    HRESULT GetDefaultFileSystemForImport(FsiFileSystems fileSystems, FsiFileSystems* importDefault);
    ///Imports the default file system on the current disc.
    ///Params:
    ///    importedFileSystem = Identifies the imported file system. For possible values, see the FsiFileSystems enumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_MULTISESSION_NOT_SET</b></dt> </dl> </td> <td width="60%">
    ///    MultisessionInterfaces property must be set prior calling this method. Value: 0xC0AAB15D </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>IMAPI_E_EMPTY_DISC</b></dt> </dl> </td> <td width="60%"> Optical media is empty.
    ///    Value: 0xC0AAB150 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_NO_SUPPORTED_FILE_SYSTEM</b></dt>
    ///    </dl> </td> <td width="60%"> The specified disc does not contain one of the supported file systems. Value:
    ///    0xC0AAB151 <div class="alert"><b>Note</b> The file systems are likely supported for the operation, but at the
    ///    low levels, IMAPI2 when calling ImportFileSystem, it has generic exception/error handling and reports back
    ///    error 0xC0AAB151. If the disc is not acquired for exclusive access or otherwise access denied, this error
    ///    won't be reported. </div> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_BOOT_OBJECT_CONFLICT</b></dt>
    ///    </dl> </td> <td width="60%"> A boot object can only be included in an initial disc image. Value: 0xC0AAB149
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to
    ///    allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_IMAGE_TOO_BIG</b></dt> </dl> </td> <td width="60%"> Value specified for FreeMediaBlocks
    ///    property is too small for estimated image size based on current data. Value: 0xC0AAB121 </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The value specified for
    ///    parameter <i>%1!ls!</i> is not valid. Value: 0xC0AAB101 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_NO_COMPATIBLE_MULTISESSION_TYPE</b></dt> </dl> </td> <td width="60%"> IMAPI supports none of
    ///    the multisession type(s) provided on the current media. Value: 0xC0AAB15C <div class="alert"><b>Note</b>
    ///    IFileSystemImage::ImportFileSystem method returns this error if there is no media in the recording
    ///    device.</div> <div> </div> </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INCOMPATIBLE_PREVIOUS_SESSION</b></dt> </dl> </td> <td width="60%"> Operation failed because
    ///    of incompatible layout of the previous session imported from the medium. Value: 0xC0AAB133 </td> </tr>
    ///    </table>
    ///    
    HRESULT ImportFileSystem(FsiFileSystems* importedFileSystem);
    ///Import a specific file system from disc.
    ///Params:
    ///    fileSystemToUse = Identifies the file system to import. For possible values, see the FsiFileSystems enumeration type.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The value specified for parameter
    ///    <i>%1!ls!</i> is not valid. Value: 0xC0AAB101 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_MULTISESSION_NOT_SET</b></dt> </dl> </td> <td width="60%"> MultisessionInterfaces property
    ///    must be set prior calling this method. Value: 0xC0AAB15D </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_BOOT_OBJECT_CONFLICT</b></dt> </dl> </td> <td width="60%"> A boot object can only be included
    ///    in an initial disc image. Value: 0xC0AAB149 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_EMPTY_DISC</b></dt> </dl> </td> <td width="60%"> Optical media is empty. Value: 0xC0AAB150
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to
    ///    allocate the required memory. Value: 0x8007000E </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_NO_COMPATIBLE_MULTISESSION_TYPE</b></dt> </dl> </td> <td width="60%"> IMAPI supports none of
    ///    the multisession type(s) provided on the current media. Value: 0xC0AAB15C <div class="alert"><b>Note</b>
    ///    IFileSystemImage::ImportFileSystem method returns this error if there is no media in the recording
    ///    device.</div> <div> </div> </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INCOMPATIBLE_PREVIOUS_SESSION</b></dt> </dl> </td> <td width="60%"> Operation failed because
    ///    of incompatible layout of the previous session imported from the medium. Value: 0xC0AAB133 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>IMAPI_E_FILE_SYSTEM_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The
    ///    specified disc does not contain a '%1!ls!' file system. Value: 0xC0AAB152 </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>IMAPI_E_INVALID_PATH</b></dt> </dl> </td> <td width="60%"> The file system specified for import
    ///    contains an invalid file name. Value: 0xC0AAB110 </td> </tr> </table>
    ///    
    HRESULT ImportSpecificFileSystem(FsiFileSystems fileSystemToUse);
    ///Reverts the image back to the specified change point.
    ///Params:
    ///    changePoint = Change point that identifies the target state for rollback.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_TOO_MANY_DIRS</b></dt> </dl> </td> <td width="60%"> This file system image has too many
    ///    directories for the <i>%1!ls!</i> file system. Value: 0xC0AAB130 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_ISO9660_LEVELS</b></dt> </dl> </td> <td width="60%"> ISO9660 is limited to 8 levels of
    ///    directories. Value: 0xC0AAB131 </td> </tr> </table>
    ///    
    HRESULT RollbackToChangePoint(int changePoint);
    ///Locks the file system information at the current change-point level.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_FSI_INTERNAL_ERROR</b></dt> </dl> </td> <td width="60%"> Internal error occurred:
    ///    <i>%1!ls!</i>. </td> </tr> </table>
    ///    
    HRESULT LockInChangePoint();
    ///Create a directory item with the specified name.
    ///Params:
    ///    name = String that contains the name of the directory item to create.
    ///    newItem = An IFsiDirectoryItem interface of the new directory item. When done, call the
    ///              <b>IFsiDirectoryItem::Release</b> method to release the interface.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The value
    ///    specified for parameter <i>%1!ls!</i> is not valid. Value: 0xC0AAB101 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> </table>
    ///    
    HRESULT CreateDirectoryItem(BSTR name, IFsiDirectoryItem* newItem);
    ///Create a file item with the specified name.
    ///Params:
    ///    name = String that contains the name of the file item to create.
    ///    newItem = An IFsiFileItem interface of the new file item. When done, call the <b>IFsiFileItem::Release</b> method to
    ///              release the interface.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_INVALID_PARAM</b></dt> </dl> </td> <td width="60%"> The provided
    ///    <i>name</i> is not valid. Value: 0xC0AAB101 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the required memory. Value:
    ///    0x8007000E </td> </tr> </table>
    ///    
    HRESULT CreateFileItem(BSTR name, IFsiFileItem* newItem);
    ///Retrieves the volume name for the UDF system image.
    ///Params:
    ///    pVal = String that contains the volume name for the UDF system image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_VolumeNameUDF(BSTR* pVal);
    ///Retrieves the volume name for the Joliet system image.
    ///Params:
    ///    pVal = String that contains the volume name for the Joliet system image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_VolumeNameJoliet(BSTR* pVal);
    ///Retrieves the volume name for the ISO9660 system image.
    ///Params:
    ///    pVal = String that contains the volume name for the ISO9660 system image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_VolumeNameISO9660(BSTR* pVal);
    ///Indicates if the files being added to the file system image should be staged before the burn.
    ///Params:
    ///    pVal = <b>VARIANT_TRUE</b> if the files being added to the file system image are required to be stageded in one or
    ///           more stage files before burning. Otherwise, <b>VARIANT_FALSE</b> is returned if IMAPI is permitted to
    ///           optimize the image creation process by not staging the files being added to the file system image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    </table>
    ///    
    HRESULT get_StageFiles(short* pVal);
    ///Determines if the files being added to the file system image should be staged before the burn.
    ///Params:
    ///    newVal = Set to VARIANT_TRUE to force files added to the file system image to be staged in one or more stage files
    ///             before burning. Otherwise, set to VARIANT_FALSE if staging is not required and higher performance is desired.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> Not implemented. Value: 0x80004001 </td> </tr>
    ///    </table>
    ///    
    HRESULT put_StageFiles(short newVal);
    ///Retrieves the list of multi-session interfaces for the optical media.
    ///Params:
    ///    pVal = List of multi-session interfaces for the optical media. Each element of the list is a <b>VARIANT</b> of type
    ///           <b>VT_Dispatch</b>. Query the <b>pdispVal</b> member of the variant for the IMultisession interface.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Failed to allocate the
    ///    required memory. Value: 0x8007000E </td> </tr> </table>
    ///    
    HRESULT get_MultisessionInterfaces(SAFEARRAY** pVal);
    ///Sets the list of multi-session interfaces for the optical media.
    ///Params:
    ///    newVal = List of multi-session interfaces for the optical media. Each element of the list is a VARIANT whose type is
    ///             <b>VT_DISPATCH</b>. Query the multi-session interface for its <b>IDispatch</b> interface and set the
    ///             <b>pdispVal</b> member of the variant to the <b>IDispatch</b> interface.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_INCOMPATIBLE_MULTISESSION_TYPE</b></dt> </dl> </td> <td
    ///    width="60%"> IMAPI does not support the multisession type requested. Value: 0xC0AAB15B </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>IMAPI_E_IMPORT_MEDIA_NOT_ALLOWED</b></dt> </dl> </td> <td width="60%"> IMAPI does
    ///    not allow multi-session with the current media type. Value: 0xC0AAB159 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_NO_COMPATIBLE_MULTISESSION_TYPE</b></dt> </dl> </td> <td width="60%"> IMAPI supports none of
    ///    the multisession type(s) provided on the current media. Value: 0xC0AAB15C </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>IMAPI_E_BAD_MULTISESSION_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of multisession
    ///    parameters cannot be retrieved or has a wrong value. Value: 0xC0AAB162 </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_FSI_INTERNAL_ERROR</b></dt> </dl> </td> <td width="60%"> Internal error occurred: %1!ls!.
    ///    Value: 0xC0AAB100 </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_IMPORT_SEEK_FAILURE</b></dt> </dl>
    ///    </td> <td width="60%"> Cannot seek to block %1!I64d! on source disc. This value is also returned if the
    ///    optical media is blank. Value: 0xC0AAB156 </td> </tr> </table> <div class="alert"><b>Note</b> Values returned
    ///    by the IUnknown::QueryInterface method may also be returned here.</div> <div> </div>
    ///    
    HRESULT put_MultisessionInterfaces(SAFEARRAY* newVal);
}

///Use this interface to write multiple boot entries or boot images required for the EFI/UEFI support. For example, boot
///media with boot straps for both Windows XP and Windows Vista.<div class="alert"><b>Note</b> The
///<b>IFileSystemImage2</b> interface is currently only available with Windows Vista with Service Pack 1 (SP1) and
///Windows Server 2008.</div> <div> </div>
@GUID("D7644B2C-1537-4767-B62F-F1387B02DDFD")
interface IFileSystemImage2 : IFileSystemImage
{
    ///Retrieves the boot option array that will be utilized to generate the file system image.
    ///Params:
    ///    pVal = Pointer to a boot option array that contains a list of IBootOptions interfaces of boot images used to
    ///           generate the file system image. Each element of the list is a <b>VARIANT</b> of type <b>VT_DISPATCH</b>.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer is not valid. Value: 0x80004003 </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_BOOT_OBJECT_CONFLICT</b></dt> </dl> </td> <td width="60%"> A boot
    ///    object can only be included in an initial disc image. Value: 0xC0AAB149 </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>IMAPI_E_BOOT_IMAGE_DATA</b></dt> </dl> </td> <td width="60%"> The boot object could not be added
    ///    to the image. Value: 0xC0AAB148 </td> </tr> </table>
    ///    
    HRESULT get_BootImageOptionsArray(SAFEARRAY** pVal);
    ///Sets the boot option array that will be utilized to generate the file system image. Unlike
    ///IFileSystemImage::put_BootImageOptions, this method will not create a complete copy of each boot options array
    ///element, but instead use references to each element.
    ///Params:
    ///    newVal = List of IBootOptions interfaces of the boot images that will be utilized to generate the file system image.
    ///             Each element of the list is a <b>VARIANT</b> of the type <b>VT_DISPATCH</b>.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> No such interface supported. Value: 0x80004002
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IMAPI_E_BOOT_OBJECT_CONFLICT</b></dt> </dl> </td> <td
    ///    width="60%"> A boot object can only be included in an initial disc image. Value: 0xC0AAB149 </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>IMAPI_E_BOOT_IMAGE_DATA</b></dt> </dl> </td> <td width="60%"> The boot object
    ///    could not be added to the image. Value: 0xC0AAB148 </td> </tr> </table>
    ///    
    HRESULT put_BootImageOptionsArray(SAFEARRAY* newVal);
}

///Use this interface to set or check the metadata and metadata mirror files in a UDF file system (rev 2.50 and later)
///to determine redundancy.
@GUID("7CFF842C-7E97-4807-8304-910DD8F7C051")
interface IFileSystemImage3 : IFileSystemImage2
{
    ///Retrieves a property value that specifies if the UDF Metadata will be redundant in the file system image.
    ///Params:
    ///    pVal = Pointer to a value that specifies if the UDF metadata is redundant in the resultant file system image. A
    ///           value of <b>VARIANT_TRUE</b> indicates that UDF metadata will be redundant; otherwise, <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> <dt>(HRESULT) 0x80004003L</dt> </dl> </td> <td width="60%"> Invalid pointer. </td>
    ///    </tr> </table>
    ///    
    HRESULT get_CreateRedundantUdfMetadataFiles(short* pVal);
    ///Sets the property that specifies if the UDF Metadata will be redundant in the file system image.
    ///Params:
    ///    newVal = Specifies if the UDF metadata is redundant in the resultant file system image or not. A value of
    ///             <b>VARIANT_TRUE</b> indicates that UDF metadata will be redundant; otherwise, <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values: <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_S_IMAGE_FEATURE_NOT_SUPPORTED</b></dt> <dt>Value: 0x00AAB15FL</dt> </dl> </td> <td width="60%">
    ///    Option changed, but the feature is not supported for the implemented file system revision, and the image will
    ///    be created without this feature. </td> </tr> </table>
    ///    
    HRESULT put_CreateRedundantUdfMetadataFiles(short newVal);
    ///Determines if a specific file system on the current media is appendable through the IMAPI.
    ///Params:
    ///    fileSystemToProbe = The file system on the current media to probe.
    ///    isAppendable = A <b>VARIANT_BOOL</b> value specifying if the specified file system is appendable.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT ProbeSpecificFileSystem(FsiFileSystems fileSystemToProbe, short* isAppendable);
}

///Implement this interface to receive notifications of the current write operation.
@GUID("2C941FDF-975B-59BE-A960-9A2A262853A5")
interface DFileSystemImageEvents : IDispatch
{
    ///Implement this method to receive progress notification of the current write operation. The notifications are sent
    ///when copying the content of a file or while adding directories or files to the file system image.
    ///Params:
    ///    object = An IFileSystemImage interface of the file system image that is being written. This parameter is a
    ///             <b>CFileSystemImage</b> object in a script.
    ///    currentFile = String that contains the full path of the file being written.
    ///    copiedSectors = Number of sectors copied.
    ///    totalSectors = Total number of sectors in the file.
    ///Returns:
    ///    Return values are ignored.
    ///    
    HRESULT Update(IDispatch object, BSTR currentFile, int copiedSectors, int totalSectors);
}

///Use this interface to receives notifications regarding the current file system import operation.
@GUID("D25C30F9-4087-4366-9E24-E55BE286424B")
interface DFileSystemImageImportEvents : IDispatch
{
    ///Receives import notification for every file and directory item imported from an optical medium.
    ///Params:
    ///    object = Pointer to an IFilesystemImage3 interface of a file system image object to which data is being imported.
    ///    fileSystem = Type of the file system currently being imported. For possible values, see the FsiFileSystems enumeration
    ///                 type.
    ///    currentItem = A string containing the name of the file or directory being imported at the moment.
    ///    importedDirectoryItems = The number of directories imported so far.
    ///    totalDirectoryItems = The total number of directories to be imported from the optical medium.
    ///    importedFileItems = The number of files imported so far.
    ///    totalFileItems = The total number of files to be imported from the optical medium.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT UpdateImport(IDispatch object, FsiFileSystems fileSystem, BSTR currentItem, int importedDirectoryItems, 
                         int totalDirectoryItems, int importedFileItems, int totalFileItems);
}

///Use this interface to verify if an existing .iso file contains a valid file system for burning.
@GUID("6CA38BE5-FBBB-4800-95A1-A438865EB0D4")
interface IIsoImageManager : IDispatch
{
    ///Retrives the logical path to an .iso image.
    ///Params:
    ///    pVal = Pointer to the logical path to an .iso image. For example, "c:\\path\\file.iso".
    HRESULT get_Path(BSTR* pVal);
    ///Retrieves the <b>IStream</b> object associated with the .iso image.
    ///Params:
    ///    data = The <b>IStream</b> object associated with the .iso image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT get_Stream(IStream* data);
    ///Sets the <b>Path</b> property value with a logical path to an .iso image.
    ///Params:
    ///    Val = The logical path to the .iso image. For example, "c:\\path\\file.iso".
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. <table>
    ///    <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_INVALID_PATH</b></dt> </dl> </td> <td width="60%"> Path '%1!s!' is badly formed or contains
    ///    invalid characters. Value: 0xC0AAB110 </td> </tr> </table>
    ///    
    HRESULT SetPath(BSTR Val);
    ///Sets the <b>Stream</b> property with the <b>IStream</b> object associated with the .iso image.
    ///Params:
    ///    data = The <b>IStream</b> object associated with the .iso image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
    HRESULT SetStream(IStream data);
    ///Determines if the provided .iso image is valid.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>IMAPI_E_IMAGEMANAGER_IMAGE_NOT_ALIGNED</b></dt> </dl> </td> <td width="60%"> The
    ///    image is not aligned on a 2kb sector boundary. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_IMAGEMANAGER_NO_VALID_VD_FOUND</b></dt> </dl> </td> <td width="60%"> The image does not
    ///    contain a valid volume descriptor. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_IMAGEMANAGER_NO_IMAGE</b></dt> </dl> </td> <td width="60%"> The image has not been set using
    ///    the SetPath or SetStream method prior to calling this method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>IMAPI_E_IMAGEMANAGER_IMAGE_TOO_BIG</b></dt> </dl> </td> <td width="60%"> The provided image is too
    ///    large to be validated as the size exceeds MAXLONG. </td> </tr> </table>
    ///    
    HRESULT Validate();
}

///The <b>IDiscRecorder</b> interface enables access to a single disc recorder device, labeled the active disc recorder.
///An IMAPI object such as <b>MSDiscMasterObj</b> maintains an active disc recorder. An <b>IDiscRecorder</b> object
///represents a single hardware device, but there can be multiple instances of <b>IDiscRecorder</b> all referencing the
///same hardware device. In this case, use OpenExclusive to access that device.
@GUID("85AC9776-CA88-4CF2-894E-09598C078A41")
interface IDiscRecorder : IUnknown
{
    HRESULT Init(ubyte* pbyUniqueID, uint nulIDSize, uint nulDriveNumber);
    ///Retrieves the GUID of the physical disc recorder currently associated with the recorder object.
    ///Params:
    ///    pbyUniqueID = Pointer to a GUID buffer to be filled in with this recorder's current GUID information. To query the required
    ///                  buffer size, use <b>NULL</b>.
    ///    ulBufferSize = Size of the GUID buffer. If <i>pbyUniqueID</i> is <b>NULL</b>, this parameter must be zero.
    ///    pulReturnSizeRequired = Size of the GUID information.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT GetRecorderGUID(ubyte* pbyUniqueID, uint ulBufferSize, uint* pulReturnSizeRequired);
    ///Determines whether the disc recorder is a CD-R or CD-RW type device. This does not indicate the type of media
    ///that is currently inserted in the device.
    ///Params:
    ///    fTypeCode = One of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///                id="RECORDER_CDR"></a><a id="recorder_cdr"></a><dl> <dt><b>RECORDER_CDR</b></dt> </dl> </td> <td width="60%">
    ///                0x1 </td> </tr> <tr> <td width="40%"><a id="RECORDER_CDRW"></a><a id="recorder_cdrw"></a><dl>
    ///                <dt><b>RECORDER_CDRW</b></dt> </dl> </td> <td width="60%"> 0x2 </td> </tr> </table>
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT GetRecorderType(int* fTypeCode);
    ///Retrieves a formatted name for the recorder that can be displayed. The name consists of the manufacturer and
    ///product identifier of the device.
    ///Params:
    ///    pbstrVendorID = Vendor of the disc recorder. This parameter can be <b>NULL</b>.
    ///    pbstrProductID = Product name of the disc recorder. This parameter can be <b>NULL</b>.
    ///    pbstrRevision = Revision of the disc recorder. This is typically the revision of the recorder firmware, but it can be a
    ///                    revision for the entire device. This parameter can be <b>NULL</b>.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT GetDisplayNames(BSTR* pbstrVendorID, BSTR* pbstrProductID, BSTR* pbstrRevision);
    ///Retrieves a base PnP string that can be used to consistently identify a specific class of device by make and
    ///model. The string can be used by applications to customize their behavior according to the specific recorder
    ///type.
    ///Params:
    ///    pbstrBasePnPID = Base PnP ID string. The string is a concatenation of a recorder's manufacturer, product ID, and revision
    ///                     information (if available).
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT GetBasePnPID(BSTR* pbstrBasePnPID);
    ///Retrieves a path to the device within the operating system. This path should be used in conjunction with the
    ///display name to completely identify an available disc recorder.
    ///Params:
    ///    pbstrPath = Path to the disc recorder. This path may be of the form \Device\CdRom<i>X</i>, but you should not rely on the
    ///                path following this convention.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT GetPath(BSTR* pbstrPath);
    ///Retrieves a pointer to an IPropertyStorage interface.
    ///Params:
    ///    ppPropStg = Pointer to an IPropertyStorage interface to the property set with all current properties defined.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT GetRecorderProperties(IPropertyStorage* ppPropStg);
    ///Accepts an IPropertyStorage pointer for an object with all the properties that the application wishes to change.
    ///Sparse settings are supported. It is recommended, however, to query for a property set using
    ///GetRecorderProperties, modify only those settings of interest, and then call <b>SetRecorderProperties</b> to
    ///change all values simultaneously.
    ///Params:
    ///    pPropStg = Pointer to the IPropertyStorage interface that the disc recorder can use to retrieve new settings on various
    ///               properties.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT SetRecorderProperties(IPropertyStorage pPropStg);
    ///Retrieves the disc recorder state.
    ///Params:
    ///    pulDevStateFlags = One of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///                       id="RECORDER_BURNING"></a><a id="recorder_burning"></a><dl> <dt><b>RECORDER_BURNING</b></dt> </dl> </td> <td
    ///                       width="60%"> 0x2 </td> </tr> <tr> <td width="40%"><a id="RECORDER_DOING_NOTHING"></a><a
    ///                       id="recorder_doing_nothing"></a><dl> <dt><b>RECORDER_DOING_NOTHING</b></dt> </dl> </td> <td width="60%"> 0x0
    ///                       </td> </tr> <tr> <td width="40%"><a id="RECORDER_OPENED"></a><a id="recorder_opened"></a><dl>
    ///                       <dt><b>RECORDER_OPENED</b></dt> </dl> </td> <td width="60%"> 0x1 </td> </tr> </table>
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT GetRecorderState(uint* pulDevStateFlags);
    ///Opens a disc recorder for exclusive access.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT OpenExclusive();
    ///Detects the type of media currently inserted in the recorder, if any.
    ///Params:
    ///    fMediaType = If there is no media, both <i>fMediaType</i> and <i>fMediaFlags</i> are zero. If there is media,
    ///                 <i>fMediaType</i> contains one or more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///                 </tr> <tr> <td width="40%"><a id="MEDIA_CD_EXTRA"></a><a id="media_cd_extra"></a><dl>
    ///                 <dt><b>MEDIA_CD_EXTRA</b></dt> </dl> </td> <td width="60%"> 4 </td> </tr> <tr> <td width="40%"><a
    ///                 id="MEDIA_CD_I"></a><a id="media_cd_i"></a><dl> <dt><b>MEDIA_CD_I</b></dt> </dl> </td> <td width="60%"> 3
    ///                 </td> </tr> <tr> <td width="40%"><a id="MEDIA_CD_OTHER"></a><a id="media_cd_other"></a><dl>
    ///                 <dt><b>MEDIA_CD_OTHER</b></dt> </dl> </td> <td width="60%"> 5 </td> </tr> <tr> <td width="40%"><a
    ///                 id="MEDIA_CD_ROM_XA"></a><a id="media_cd_rom_xa"></a><dl> <dt><b>MEDIA_CD_ROM_XA</b></dt> </dl> </td> <td
    ///                 width="60%"> 2 </td> </tr> <tr> <td width="40%"><a id="MEDIA_CDDA_CDROM"></a><a
    ///                 id="media_cdda_cdrom"></a><dl> <dt><b>MEDIA_CDDA_CDROM</b></dt> </dl> </td> <td width="60%"> 1 </td> </tr>
    ///                 <tr> <td width="40%"><a id="MEDIA_SPECIAL"></a><a id="media_special"></a><dl> <dt><b>MEDIA_SPECIAL</b></dt>
    ///                 </dl> </td> <td width="60%"> 6 </td> </tr> </table>
    ///    fMediaFlags = If there is media, this parameter contains one or more of the following values. <table> <tr> <th>Value</th>
    ///                  <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MEDIA_BLANK"></a><a id="media_blank"></a><dl>
    ///                  <dt><b>MEDIA_BLANK</b></dt> </dl> </td> <td width="60%"> 0x1 </td> </tr> <tr> <td width="40%"><a
    ///                  id="MEDIA_RW"></a><a id="media_rw"></a><dl> <dt><b>MEDIA_RW</b></dt> </dl> </td> <td width="60%"> 0x2 </td>
    ///                  </tr> <tr> <td width="40%"><a id="MEDIA_WRITABLE"></a><a id="media_writable"></a><dl>
    ///                  <dt><b>MEDIA_WRITABLE</b></dt> </dl> </td> <td width="60%"> 0x4 </td> </tr> </table>
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT QueryMediaType(int* fMediaType, int* fMediaFlags);
    ///Retrieves information about the currently mounted media, such as the total number of blocks used on the media.
    ///Params:
    ///    pbSessions = Number of sessions on the disc.
    ///    pbLastTrack = Track number of the last track of the previous session.
    ///    ulStartAddress = Start address of the last track of the previous session.
    ///    ulNextWritable = Address at which writing is to begin.
    ///    ulFreeBlocks = Number of blocks available for writing.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT QueryMediaInfo(ubyte* pbSessions, ubyte* pbLastTrack, uint* ulStartAddress, uint* ulNextWritable, 
                           uint* ulFreeBlocks);
    ///Unlocks and ejects the tray of the disc recorder, if possible.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT Eject();
    ///Attempts to erase the CD-RW media if this is a CD-RW disc recorder. Both full and quick erases are supported.
    ///Params:
    ///    bFullErase = Indicates the erase type. If this parameter is <b>FALSE</b>, a quick erase is performed. If this parameter is
    ///                 <b>TRUE</b>, a full erase is performed.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT Erase(ubyte bFullErase);
    ///Releases exclusive access to a disc recorder. This restores file system access to the drive.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT Close();
}

@GUID("9B1921E1-54AC-11D3-9144-00104BA11C5E")
interface IEnumDiscRecorders : IUnknown
{
    HRESULT Next(uint cRecorders, IDiscRecorder* ppRecorder, uint* pcFetched);
    HRESULT Skip(uint cRecorders);
    HRESULT Reset();
    HRESULT Clone(IEnumDiscRecorders* ppEnum);
}

@GUID("DDF445E1-54BA-11D3-9144-00104BA11C5E")
interface IEnumDiscMasterFormats : IUnknown
{
    HRESULT Next(uint cFormats, GUID* lpiidFormatID, uint* pcFetched);
    HRESULT Skip(uint cFormats);
    HRESULT Reset();
    HRESULT Clone(IEnumDiscMasterFormats* ppEnum);
}

///The <b>IRedbookDiscMaster</b> interface enables the staging of an audio CD image. It represents one of the formats
///supported by <b>MSDiscMasterObj</b>, and it allows the creation of multi-track audio discs in Track-at-Once mode
///(fixed-size audio gaps). Tracks are created in the stash file, data is added to them, and then they are closed. Only
///one track is staged at a time; this is called the <i>open track</i>. The remaining tracks are closed and committed to
///the image, while the open track has available to it all the blocks that are not in use by closed tracks.
@GUID("E3BC42CD-4E5C-11D3-9144-00104BA11C5E")
interface IRedbookDiscMaster : IUnknown
{
    ///Retrieves the total number of tracks that have either been staged or are being staged.
    ///Params:
    ///    pnTracks = Total number of closed and open tracks.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT GetTotalAudioTracks(int* pnTracks);
    ///Retrieves the total number of blocks available for staging audio tracks. The total includes all block types,
    ///including blocks that may need to be allocated for track gaps.
    ///Params:
    ///    pnBlocks = Total number of audio blocks available on a disc.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT GetTotalAudioBlocks(int* pnBlocks);
    ///Retrieves the total number of audio blocks in use.
    ///Params:
    ///    pnBlocks = Total number of blocks in use, in both closed and open tracks.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT GetUsedAudioBlocks(int* pnBlocks);
    ///Retrieves the current number of blocks that can be added to the track before an additional add will cause a
    ///failure for lack of space.
    ///Params:
    ///    pnBlocks = Number of audio blocks that can be added to the open track before it must be closed.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT GetAvailableAudioTrackBlocks(int* pnBlocks);
    ///Retrieves the size, in bytes, of an audio block.
    ///Params:
    ///    pnBlockBytes = Total size, in bytes, of a single audio block.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT GetAudioBlockSize(int* pnBlockBytes);
    ///Begins staging a new audio track. It can be called only when there are no open audio tracks in the image.
    ///Params:
    ///    nBlocks = Number of audio blocks to be added to this track. You can create up to 99 tracks, and the open track may
    ///              consume all remaining available audio blocks. The <i>nBlocks</i> parameter is advisory only. It does not
    ///              force the track length to this size.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT CreateAudioTrack(int nBlocks);
    ///Adds blocks of audio data to the currently open track. This method can be called repeatedly until there is no
    ///space available or the track is full.
    ///Params:
    ///    pby = Pointer to an array of track blocks. The format is 44.1 KHz 16-bit stereo RAW audio samples, in the same
    ///          format as used by WAV in the data section.
    ///    cb = Size of the array, in bytes. This count must be a multiple of the audio block size.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT AddAudioTrackBlocks(ubyte* pby, int cb);
    ///Closes a currently open audio track. All audio tracks must be closed before the IDiscMaster::RecordDisc method
    ///can be called.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT CloseAudioTrack();
}

///The <b>IJolietDiscMaster</b> interface enables the staging of a CD data disc. It represents one of the formats
///supported by <b>MSDiscMasterObj</b>, and it allows the creation of a single Track-at-Once data disc. The data is
///written to the disc with the Joliet and ISO-9660 file systems. A temporary folder is constructed and added to the
///image. This can be repeated multiple times with the directory and file structures overlapping. The overlapping file
///structures appear seamlessly when read back. When the overwrite option is used, overlapping paths cause the last file
///added to show up in the directory, while the earlier files with conflicting names are still present on the disc but
///now not readable by normal means.
@GUID("E3BC42CE-4E5C-11D3-9144-00104BA11C5E")
interface IJolietDiscMaster : IUnknown
{
    ///Retrieves the total number of blocks available for staging a Joliet data disc. The data returned from this method
    ///is valid only after a SetActiveDiscRecorder call, especially in a multi-session burn.
    ///Params:
    ///    pnBlocks = Total number of data blocks available on a disc.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT GetTotalDataBlocks(int* pnBlocks);
    ///Retrieves the total number of data blocks that are in use. The data returned from this method is valid only after
    ///a SetActiveDiscRecorder call, especially in a multi-session burn.
    ///Params:
    ///    pnBlocks = Total number of data blocks in use in the staged image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT GetUsedDataBlocks(int* pnBlocks);
    ///Retrieves the size of a data block.
    ///Params:
    ///    pnBlockBytes = Total size of a single data block, in bytes.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT GetDataBlockSize(int* pnBlockBytes);
    ///Adds the contents of a root storage to the staged image file. This storage will be enumerated to place all
    ///substorages and streams in the root file system of the stage image file. Substorages become folders and streams
    ///become files. Multiple calls to this method can be repeated to slowly stage an image file without wasting undue
    ///amounts of hard drive space building up a storage file.
    ///Params:
    ///    pStorage = Path to the storage whose subitems are to be added to the root of the staged image file.
    ///    lFileOverwrite = If this parameter is nonzero, overwrite existing files with the same name. Otherwise, the last file added
    ///                     appears in the directory.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT AddData(IStorage pStorage, int lFileOverwrite);
    ///Retrieves a pointer to an IPropertyStorage interface that contains the Joliet properties.
    ///Params:
    ///    ppPropStg = Address of a pointer to an IPropertyStorage interface for the Joliet property set with all current properties
    ///                defined.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT GetJolietProperties(IPropertyStorage* ppPropStg);
    ///Sets the Joliet properties.
    ///Params:
    ///    pPropStg = Pointer to the IPropertyStorage interface that the Joliet interface can use to retrieve new settings on
    ///               various properties.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT SetJolietProperties(IPropertyStorage pPropStg);
}

///The <b>IDiscMasterProgressEvents</b> interface provides a single interface for all callbacks that can be made from
///IMAPI to an application. An application implements this interface on one of its objects and then registers it using
///IDiscMaster::ProgressAdvise. All but one of the methods in this interface are related to progress during staging or
///burns. Even if an application is not interested in a particular callback, it must implement the callback function and
///return E_NOTIMPL on the call.
@GUID("EC9E51C1-4E5D-11D3-9144-00104BA11C5E")
interface IDiscMasterProgressEvents : IUnknown
{
    ///Checks whether an AddData, AddAudioTrackBlocks, or RecordDisc operation should be canceled.
    ///Params:
    ///    pbCancel = If this parameter is <b>TRUE</b>, cancel the burn. If this parameter is <b>FALSE</b>, continue the burn.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT QueryCancel(ubyte* pbCancel);
    ///Notifies the application that there is a change to the list of valid disc recorders. (For example, a USB CD-R
    ///driver is removed from the system.)
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT NotifyPnPActivity();
    ///Notifies an application of its progress in response to calls to IRedbookDiscMaster::AddAudioTrackBlocks or
    ///IJolietDiscMaster::AddData. Notifications are sent for the first and last steps, and at points in between.
    ///Params:
    ///    nCompletedSteps = Number of arbitrary steps that have been completed in adding audio or data to a staged image.
    ///    nTotalSteps = Total number of arbitrary steps that must be taken to add a full set of audio or data to the staged image.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT NotifyAddProgress(int nCompletedSteps, int nTotalSteps);
    ///Notifies an application of its progress in burning a disc on the active recorder. Notifications are sent for the
    ///first and last blocks, and at points in between.
    ///Params:
    ///    nCompleted = Number of blocks that have been burned onto a disc or track so far.
    ///    nTotal = Total number of blocks to be burned to finish a disc or track.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT NotifyBlockProgress(int nCompleted, int nTotal);
    ///Notifies an application that a track has started or finished during the burn of an audio disc.
    ///Params:
    ///    nCurrentTrack = Number of tracks that have been completely burned.
    ///    nTotalTracks = Total number of tracks that must be burned.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT NotifyTrackProgress(int nCurrentTrack, int nTotalTracks);
    ///Notifies the application that it is preparing to burn a disc. No further notifications are sent until the burn
    ///starts.
    ///Params:
    ///    nEstimatedSeconds = Number of seconds from notification that IMAPI estimates it will take to prepare to burn the disc.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT NotifyPreparingBurn(int nEstimatedSeconds);
    ///Notifies the application that it is has started closing the disc. No further notifications are sent until the
    ///burn is finished.
    ///Params:
    ///    nEstimatedSeconds = Number of seconds from notification that IMAPI estimates it will take to close the disc.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT NotifyClosingDisc(int nEstimatedSeconds);
    ///Notifies an application that a call to IDiscMaster::RecordDisc has finished.
    ///Params:
    ///    status = Status code to be returned from IDiscMaster::RecordDisc.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT NotifyBurnComplete(HRESULT status);
    ///Notifies an application that a call to IDiscRecorder::Erase has finished.
    ///Params:
    ///    status = Status code to be returned from IDiscRecorder::Erase.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT NotifyEraseComplete(HRESULT status);
}

///The <b>IDiscMaster</b> interface allows an application to reserve an image mastering API, enumerate disc mastering
///formats and disc recorders supported by an image mastering object, and start a simulated or actual burn of a disc.
///Although an image mastering object can support several formats, it may not be possible to access all formats through
///a specific recorder. For this reason, you must select a recorder with SetActiveDiscRecorder after selecting a format
///with SetActiveDiscMasterFormat.
@GUID("520CCA62-51A5-11D3-9144-00104BA11C5E")
interface IDiscMaster : IUnknown
{
    ///Opens an upper-level IMAPI object for access by a client application.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT Open();
    ///Retrieves an enumerator for all disc mastering formats supported by this disc master object. A disc master format
    ///specifies the structure of the content in a staged image file (data/audio) and the interface that manages the
    ///staged image.
    ///Params:
    ///    ppEnum = Address of a pointer to the <b>IEnumDiscMasterFormats</b> enumerator.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT EnumDiscMasterFormats(IEnumDiscMasterFormats* ppEnum);
    ///Retrieves the active disc recorder format. The active format specifies both the structure of the staged image
    ///file content (audio/data) and the COM interface that must be used to manipulate that staged image.
    ///Params:
    ///    lpiid = IID of the currently active format.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT GetActiveDiscMasterFormat(GUID* lpiid);
    ///Sets the currently active disc recorder format. The active format specifies both the structure of the staged
    ///image file content (audio/data) and the COM interface that must be used to manipulate that staged image.
    ///Params:
    ///    riid = IID of the currently active format.
    ///    ppUnk = Pointer to the COM interface for the new disc format.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT SetActiveDiscMasterFormat(const(GUID)* riid, void** ppUnk);
    ///Retrieves an enumerator for all disc recorders supported by the active disc master format.
    ///Params:
    ///    ppEnum = Address of a pointer to the <b>IEnumDiscRecorders</b> enumerator.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT EnumDiscRecorders(IEnumDiscRecorders* ppEnum);
    ///Retrieves an interface pointer to the active disc recorder. The active disc recorder is the recorder where a burn
    ///will occur when RecordDisc is called.
    ///Params:
    ///    ppRecorder = Pointer to the IDiscRecorder interface of the currently selected disc recorder.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT GetActiveDiscRecorder(IDiscRecorder* ppRecorder);
    ///Selects an active disc recorder. The active disc recorder is the recorder where a burn will occur when RecordDisc
    ///is called.
    ///Params:
    ///    pRecorder = Pointer to the IDiscRecorder interface of a disc recorder object. This pointer should have been returned by a
    ///                previous call to EnumDiscRecorders.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT SetActiveDiscRecorder(IDiscRecorder pRecorder);
    ///Clears the contents of an unburned image (the current stash file).
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT ClearFormatContent();
    ///Registers an application for progress notifications.
    ///Params:
    ///    pEvents = Pointer to an IDiscMasterProgressEvents interface that receives the progress notifications.
    ///    pvCookie = Uniquely identifies this registration. Save this value because it will be needed by the ProgressUnadvise
    ///               method.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT ProgressAdvise(IDiscMasterProgressEvents pEvents, size_t* pvCookie);
    ///Cancels progress notifications for an application.
    ///Params:
    ///    vCookie = Value returned by a previous call to the ProgressAdvise method.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT ProgressUnadvise(size_t vCookie);
    ///Burns the staged image to media in the active disc recorder.
    ///Params:
    ///    bSimulate = Indicates whether the media is burned. If this parameter is <b>TRUE</b>, media in the active disc recorder is
    ///                not actually burned. Instead, a simulated burn is performed. The simulation is a good test of a disc
    ///                recorder, because most of the operations are performed as in a real burn. If this parameter is <b>FALSE</b>,
    ///                then the media in the recorder is actually burned.
    ///    bEjectAfterBurn = Indicates whether to eject the media after the burn. If this parameter is <b>TRUE</b>, the media is ejected.
    ///                      If this parameter is <b>FALSE</b>, the media is not ejected.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation. The
    ///    following error codes are commonly returned on operation failure, but do not represent the only possible
    ///    error values:
    ///    
    HRESULT RecordDisc(ubyte bSimulate, ubyte bEjectAfterBurn);
    ///Closes the interface so other applications can use it.
    ///Returns:
    ///    S_OK is returned on success, but other success codes may be returned as a result of implementation.
    ///    
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
