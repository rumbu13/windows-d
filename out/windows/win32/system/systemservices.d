// Written in the D programming language.

module windows.win32.system.systemservices;

public import windows.core;
public import windows.win32.foundation : BOOLEAN, CHAR, HANDLE, LUID, PSTR, PWSTR;
public import windows.win32.graphics.gdi : LOGPALETTE;
public import windows.win32.security : PSID, SECURITY_IMPERSONATION_LEVEL, SID,
                                       SID_AND_ATTRIBUTES, TOKEN_ELEVATION,
                                       TOKEN_ELEVATION_TYPE, TOKEN_TYPE, TOKEN_USER;
public import windows.win32.system.com : BYTE_BLOB, DWORD_BLOB, FLAGGED_BYTE_BLOB;
public import windows.win32.system.diagnostics.debug_ : EXCEPTION_POINTERS, IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY,
                                                        IMAGE_RUNTIME_FUNCTION_ENTRY;
public import windows.win32.system.power : SYSTEM_BATTERY_STATE;

extern(Windows) @nogc nothrow:


// Enums


alias ALERT_SYSTEM_SEV = uint;
enum : uint
{
    ALERT_SYSTEM_INFORMATIONAL = 0x00000001U,
    ALERT_SYSTEM_WARNING       = 0x00000002U,
    ALERT_SYSTEM_ERROR         = 0x00000003U,
    ALERT_SYSTEM_QUERY         = 0x00000004U,
    ALERT_SYSTEM_CRITICAL      = 0x00000005U,
}

alias APPCOMMAND_ID = uint;
enum : uint
{
    APPCOMMAND_BROWSER_BACKWARD                  = 0x00000001U,
    APPCOMMAND_BROWSER_FORWARD                   = 0x00000002U,
    APPCOMMAND_BROWSER_REFRESH                   = 0x00000003U,
    APPCOMMAND_BROWSER_STOP                      = 0x00000004U,
    APPCOMMAND_BROWSER_SEARCH                    = 0x00000005U,
    APPCOMMAND_BROWSER_FAVORITES                 = 0x00000006U,
    APPCOMMAND_BROWSER_HOME                      = 0x00000007U,
    APPCOMMAND_VOLUME_MUTE                       = 0x00000008U,
    APPCOMMAND_VOLUME_DOWN                       = 0x00000009U,
    APPCOMMAND_VOLUME_UP                         = 0x0000000aU,
    APPCOMMAND_MEDIA_NEXTTRACK                   = 0x0000000bU,
    APPCOMMAND_MEDIA_PREVIOUSTRACK               = 0x0000000cU,
    APPCOMMAND_MEDIA_STOP                        = 0x0000000dU,
    APPCOMMAND_MEDIA_PLAY_PAUSE                  = 0x0000000eU,
    APPCOMMAND_LAUNCH_MAIL                       = 0x0000000fU,
    APPCOMMAND_LAUNCH_MEDIA_SELECT               = 0x00000010U,
    APPCOMMAND_LAUNCH_APP1                       = 0x00000011U,
    APPCOMMAND_LAUNCH_APP2                       = 0x00000012U,
    APPCOMMAND_BASS_DOWN                         = 0x00000013U,
    APPCOMMAND_BASS_BOOST                        = 0x00000014U,
    APPCOMMAND_BASS_UP                           = 0x00000015U,
    APPCOMMAND_TREBLE_DOWN                       = 0x00000016U,
    APPCOMMAND_TREBLE_UP                         = 0x00000017U,
    APPCOMMAND_MICROPHONE_VOLUME_MUTE            = 0x00000018U,
    APPCOMMAND_MICROPHONE_VOLUME_DOWN            = 0x00000019U,
    APPCOMMAND_MICROPHONE_VOLUME_UP              = 0x0000001aU,
    APPCOMMAND_HELP                              = 0x0000001bU,
    APPCOMMAND_FIND                              = 0x0000001cU,
    APPCOMMAND_NEW                               = 0x0000001dU,
    APPCOMMAND_OPEN                              = 0x0000001eU,
    APPCOMMAND_CLOSE                             = 0x0000001fU,
    APPCOMMAND_SAVE                              = 0x00000020U,
    APPCOMMAND_PRINT                             = 0x00000021U,
    APPCOMMAND_UNDO                              = 0x00000022U,
    APPCOMMAND_REDO                              = 0x00000023U,
    APPCOMMAND_COPY                              = 0x00000024U,
    APPCOMMAND_CUT                               = 0x00000025U,
    APPCOMMAND_PASTE                             = 0x00000026U,
    APPCOMMAND_REPLY_TO_MAIL                     = 0x00000027U,
    APPCOMMAND_FORWARD_MAIL                      = 0x00000028U,
    APPCOMMAND_SEND_MAIL                         = 0x00000029U,
    APPCOMMAND_SPELL_CHECK                       = 0x0000002aU,
    APPCOMMAND_DICTATE_OR_COMMAND_CONTROL_TOGGLE = 0x0000002bU,
    APPCOMMAND_MIC_ON_OFF_TOGGLE                 = 0x0000002cU,
    APPCOMMAND_CORRECTION_LIST                   = 0x0000002dU,
    APPCOMMAND_MEDIA_PLAY                        = 0x0000002eU,
    APPCOMMAND_MEDIA_PAUSE                       = 0x0000002fU,
    APPCOMMAND_MEDIA_RECORD                      = 0x00000030U,
    APPCOMMAND_MEDIA_FAST_FORWARD                = 0x00000031U,
    APPCOMMAND_MEDIA_REWIND                      = 0x00000032U,
    APPCOMMAND_MEDIA_CHANNEL_UP                  = 0x00000033U,
    APPCOMMAND_MEDIA_CHANNEL_DOWN                = 0x00000034U,
    APPCOMMAND_DELETE                            = 0x00000035U,
    APPCOMMAND_DWM_FLIP3D                        = 0x00000036U,
}

alias ATF_FLAGS = uint;
enum : uint
{
    ATF_TIMEOUTON     = 0x00000001U,
    ATF_ONOFFFEEDBACK = 0x00000002U,
}

alias GESTURECONFIG_FLAGS = uint;
enum : uint
{
    GC_ALLGESTURES                         = 0x00000001U,
    GC_ZOOM                                = 0x00000001U,
    GC_PAN                                 = 0x00000001U,
    GC_PAN_WITH_SINGLE_FINGER_VERTICALLY   = 0x00000002U,
    GC_PAN_WITH_SINGLE_FINGER_HORIZONTALLY = 0x00000004U,
    GC_PAN_WITH_GUTTER                     = 0x00000008U,
    GC_PAN_WITH_INERTIA                    = 0x00000010U,
    GC_ROTATE                              = 0x00000001U,
    GC_TWOFINGERTAP                        = 0x00000001U,
    GC_PRESSANDTAP                         = 0x00000001U,
    GC_ROLLOVER                            = 0x00000001U,
}

alias CFE_UNDERLINE = uint;
enum : uint
{
    CFU_CF1UNDERLINE             = 0x000000ffU,
    CFU_INVERT                   = 0x000000feU,
    CFU_UNDERLINETHICKLONGDASH   = 0x00000012U,
    CFU_UNDERLINETHICKDOTTED     = 0x00000011U,
    CFU_UNDERLINETHICKDASHDOTDOT = 0x00000010U,
    CFU_UNDERLINETHICKDASHDOT    = 0x0000000fU,
    CFU_UNDERLINETHICKDASH       = 0x0000000eU,
    CFU_UNDERLINELONGDASH        = 0x0000000dU,
    CFU_UNDERLINEHEAVYWAVE       = 0x0000000cU,
    CFU_UNDERLINEDOUBLEWAVE      = 0x0000000bU,
    CFU_UNDERLINEHAIRLINE        = 0x0000000aU,
    CFU_UNDERLINETHICK           = 0x00000009U,
    CFU_UNDERLINEWAVE            = 0x00000008U,
    CFU_UNDERLINEDASHDOTDOT      = 0x00000007U,
    CFU_UNDERLINEDASHDOT         = 0x00000006U,
    CFU_UNDERLINEDASH            = 0x00000005U,
    CFU_UNDERLINEDOTTED          = 0x00000004U,
    CFU_UNDERLINEDOUBLE          = 0x00000003U,
    CFU_UNDERLINEWORD            = 0x00000002U,
    CFU_UNDERLINE                = 0x00000001U,
    CFU_UNDERLINENONE            = 0x00000000U,
}

alias IGP_ID = uint;
enum : uint
{
    IGP_GETIMEVERSION = 0xfffffffcU,
    IGP_PROPERTY      = 0x00000004U,
    IGP_CONVERSION    = 0x00000008U,
    IGP_SENTENCE      = 0x0000000cU,
    IGP_UI            = 0x00000010U,
    IGP_SETCOMPSTR    = 0x00000014U,
    IGP_SELECT        = 0x00000018U,
}

alias WORD_WHEEL_OPEN_FLAGS = uint;
enum : uint
{
    ITWW_OPEN_CONNECT = 0x00000000U,
}

alias TAPE_GET_DRIVE_PARAMETERS_FEATURES_HIGH = uint;
enum : uint
{
    TAPE_DRIVE_ABS_BLK_IMMED    = 0x80002000U,
    TAPE_DRIVE_ABSOLUTE_BLK     = 0x80001000U,
    TAPE_DRIVE_END_OF_DATA      = 0x80010000U,
    TAPE_DRIVE_FILEMARKS        = 0x80040000U,
    TAPE_DRIVE_LOAD_UNLOAD      = 0x80000001U,
    TAPE_DRIVE_LOAD_UNLD_IMMED  = 0x80000020U,
    TAPE_DRIVE_LOCK_UNLOCK      = 0x80000004U,
    TAPE_DRIVE_LOCK_UNLK_IMMED  = 0x80000080U,
    TAPE_DRIVE_LOG_BLK_IMMED    = 0x80008000U,
    TAPE_DRIVE_LOGICAL_BLK      = 0x80004000U,
    TAPE_DRIVE_RELATIVE_BLKS    = 0x80020000U,
    TAPE_DRIVE_REVERSE_POSITION = 0x80400000U,
    TAPE_DRIVE_REWIND_IMMEDIATE = 0x80000008U,
    TAPE_DRIVE_SEQUENTIAL_FMKS  = 0x80080000U,
    TAPE_DRIVE_SEQUENTIAL_SMKS  = 0x80200000U,
    TAPE_DRIVE_SET_BLOCK_SIZE   = 0x80000010U,
    TAPE_DRIVE_SET_COMPRESSION  = 0x80000200U,
    TAPE_DRIVE_SET_ECC          = 0x80000100U,
    TAPE_DRIVE_SET_PADDING      = 0x80000400U,
    TAPE_DRIVE_SET_REPORT_SMKS  = 0x80000800U,
    TAPE_DRIVE_SETMARKS         = 0x80100000U,
    TAPE_DRIVE_SPACE_IMMEDIATE  = 0x80800000U,
    TAPE_DRIVE_TENSION          = 0x80000002U,
    TAPE_DRIVE_TENSION_IMMED    = 0x80000040U,
    TAPE_DRIVE_WRITE_FILEMARKS  = 0x82000000U,
    TAPE_DRIVE_WRITE_LONG_FMKS  = 0x88000000U,
    TAPE_DRIVE_WRITE_MARK_IMMED = 0x90000000U,
    TAPE_DRIVE_WRITE_SETMARKS   = 0x81000000U,
    TAPE_DRIVE_WRITE_SHORT_FMKS = 0x84000000U,
}

alias MODIFIERKEYS_FLAGS = uint;
enum : uint
{
    MK_LBUTTON  = 0x00000001U,
    MK_RBUTTON  = 0x00000002U,
    MK_SHIFT    = 0x00000004U,
    MK_CONTROL  = 0x00000008U,
    MK_MBUTTON  = 0x00000010U,
    MK_XBUTTON1 = 0x00000020U,
    MK_XBUTTON2 = 0x00000040U,
}

alias STATIC_STYLES = uint;
enum : uint
{
    SS_LEFT            = 0x00000000U,
    SS_CENTER          = 0x00000001U,
    SS_RIGHT           = 0x00000002U,
    SS_ICON            = 0x00000003U,
    SS_BLACKRECT       = 0x00000004U,
    SS_GRAYRECT        = 0x00000005U,
    SS_WHITERECT       = 0x00000006U,
    SS_BLACKFRAME      = 0x00000007U,
    SS_GRAYFRAME       = 0x00000008U,
    SS_WHITEFRAME      = 0x00000009U,
    SS_USERITEM        = 0x0000000aU,
    SS_SIMPLE          = 0x0000000bU,
    SS_LEFTNOWORDWRAP  = 0x0000000cU,
    SS_OWNERDRAW       = 0x0000000dU,
    SS_BITMAP          = 0x0000000eU,
    SS_ENHMETAFILE     = 0x0000000fU,
    SS_ETCHEDHORZ      = 0x00000010U,
    SS_ETCHEDVERT      = 0x00000011U,
    SS_ETCHEDFRAME     = 0x00000012U,
    SS_TYPEMASK        = 0x0000001fU,
    SS_REALSIZECONTROL = 0x00000040U,
    SS_NOPREFIX        = 0x00000080U,
    SS_NOTIFY          = 0x00000100U,
    SS_CENTERIMAGE     = 0x00000200U,
    SS_RIGHTJUST       = 0x00000400U,
    SS_REALSIZEIMAGE   = 0x00000800U,
    SS_SUNKEN          = 0x00001000U,
    SS_EDITCONTROL     = 0x00002000U,
    SS_ENDELLIPSIS     = 0x00004000U,
    SS_PATHELLIPSIS    = 0x00008000U,
    SS_WORDELLIPSIS    = 0x0000c000U,
    SS_ELLIPSISMASK    = 0x0000c000U,
}

alias RECO_FLAGS = uint;
enum : uint
{
    RECO_PASTE = 0x00000000U,
    RECO_DROP  = 0x00000001U,
    RECO_COPY  = 0x00000002U,
    RECO_CUT   = 0x00000003U,
    RECO_DRAG  = 0x00000004U,
}

alias SFGAO_FLAGS = uint;
enum : uint
{
    SFGAO_CANCOPY         = 0x00000001U,
    SFGAO_CANMOVE         = 0x00000002U,
    SFGAO_CANLINK         = 0x00000004U,
    SFGAO_STORAGE         = 0x00000008U,
    SFGAO_CANRENAME       = 0x00000010U,
    SFGAO_CANDELETE       = 0x00000020U,
    SFGAO_HASPROPSHEET    = 0x00000040U,
    SFGAO_DROPTARGET      = 0x00000100U,
    SFGAO_CAPABILITYMASK  = 0x00000177U,
    SFGAO_PLACEHOLDER     = 0x00000800U,
    SFGAO_SYSTEM          = 0x00001000U,
    SFGAO_ENCRYPTED       = 0x00002000U,
    SFGAO_ISSLOW          = 0x00004000U,
    SFGAO_GHOSTED         = 0x00008000U,
    SFGAO_LINK            = 0x00010000U,
    SFGAO_SHARE           = 0x00020000U,
    SFGAO_READONLY        = 0x00040000U,
    SFGAO_HIDDEN          = 0x00080000U,
    SFGAO_DISPLAYATTRMASK = 0x000fc000U,
    SFGAO_FILESYSANCESTOR = 0x10000000U,
    SFGAO_FOLDER          = 0x20000000U,
    SFGAO_FILESYSTEM      = 0x40000000U,
    SFGAO_HASSUBFOLDER    = 0x80000000U,
    SFGAO_CONTENTSMASK    = 0x80000000U,
    SFGAO_VALIDATE        = 0x01000000U,
    SFGAO_REMOVABLE       = 0x02000000U,
    SFGAO_COMPRESSED      = 0x04000000U,
    SFGAO_BROWSABLE       = 0x08000000U,
    SFGAO_NONENUMERATED   = 0x00100000U,
    SFGAO_NEWCONTENT      = 0x00200000U,
    SFGAO_CANMONIKER      = 0x00400000U,
    SFGAO_HASSTORAGE      = 0x00400000U,
    SFGAO_STREAM          = 0x00400000U,
    SFGAO_STORAGEANCESTOR = 0x00800000U,
    SFGAO_STORAGECAPMASK  = 0x70c50008U,
    SFGAO_PKEYSFGAOMASK   = 0x81044000U,
}

alias ACCESS_REASON_TYPE = int;
enum : int
{
    AccessReasonNone                     = 0x00000000,
    AccessReasonAllowedAce               = 0x00010000,
    AccessReasonDeniedAce                = 0x00020000,
    AccessReasonAllowedParentAce         = 0x00030000,
    AccessReasonDeniedParentAce          = 0x00040000,
    AccessReasonNotGrantedByCape         = 0x00050000,
    AccessReasonNotGrantedByParentCape   = 0x00060000,
    AccessReasonNotGrantedToAppContainer = 0x00070000,
    AccessReasonMissingPrivilege         = 0x00100000,
    AccessReasonFromPrivilege            = 0x00200000,
    AccessReasonIntegrityLevel           = 0x00300000,
    AccessReasonOwnership                = 0x00400000,
    AccessReasonNullDacl                 = 0x00500000,
    AccessReasonEmptyDacl                = 0x00600000,
    AccessReasonNoSD                     = 0x00700000,
    AccessReasonNoGrant                  = 0x00800000,
    AccessReasonTrustLabel               = 0x00900000,
    AccessReasonFilterAce                = 0x00a00000,
}

alias SE_IMAGE_SIGNATURE_TYPE = int;
enum : int
{
    SeImageSignatureNone             = 0x00000000,
    SeImageSignatureEmbedded         = 0x00000001,
    SeImageSignatureCache            = 0x00000002,
    SeImageSignatureCatalogCached    = 0x00000003,
    SeImageSignatureCatalogNotCached = 0x00000004,
    SeImageSignatureCatalogHint      = 0x00000005,
    SeImageSignaturePackageCatalog   = 0x00000006,
    SeImageSignaturePplMitigated     = 0x00000007,
}

alias SERVERSILO_STATE = int;
enum : int
{
    SERVERSILO_INITING       = 0x00000000,
    SERVERSILO_STARTED       = 0x00000001,
    SERVERSILO_SHUTTING_DOWN = 0x00000002,
    SERVERSILO_TERMINATING   = 0x00000003,
    SERVERSILO_TERMINATED    = 0x00000004,
}

alias RUNTIME_REPORT_TYPE = int;
enum : int
{
    RuntimeReportTypeDriver = 0x00000000,
    RuntimeReportTypeMax    = 0x00000001,
}

enum SharedVirtualDiskSupportType : int
{
    SharedVirtualDisksUnsupported          = 0x00000000,
    SharedVirtualDisksSupported            = 0x00000001,
    SharedVirtualDiskSnapshotsSupported    = 0x00000003,
    SharedVirtualDiskCDPSnapshotsSupported = 0x00000007,
}

enum SharedVirtualDiskHandleState : int
{
    SharedVirtualDiskHandleStateNone         = 0x00000000,
    SharedVirtualDiskHandleStateFileShared   = 0x00000001,
    SharedVirtualDiskHandleStateHandleShared = 0x00000003,
}

alias MONITOR_DISPLAY_STATE = int;
enum : int
{
    PowerMonitorOff = 0x00000000,
    PowerMonitorOn  = 0x00000001,
    PowerMonitorDim = 0x00000002,
}

alias ENERGY_SAVER_STATUS = int;
enum : int
{
    ENERGY_SAVER_OFF          = 0x00000000,
    ENERGY_SAVER_STANDARD     = 0x00000001,
    ENERGY_SAVER_HIGH_SAVINGS = 0x00000002,
}

alias POWER_LIMIT_TYPES = int;
enum : int
{
    PowerLimitContinuous       = 0x00000000,
    PowerLimitType1            = 0x00000000,
    PowerLimitBurst            = 0x00000001,
    PowerLimitType2            = 0x00000001,
    PowerLimitRapid            = 0x00000002,
    PowerLimitType3            = 0x00000002,
    PowerLimitPreemptive       = 0x00000003,
    PowerLimitType4            = 0x00000003,
    PowerLimitPreemptiveOffset = 0x00000004,
    PowerLimitTypeMax          = 0x00000005,
}

alias HIBERFILE_BUCKET_SIZE = int;
enum : int
{
    HiberFileBucket1GB       = 0x00000000,
    HiberFileBucket2GB       = 0x00000001,
    HiberFileBucket4GB       = 0x00000002,
    HiberFileBucket8GB       = 0x00000003,
    HiberFileBucket16GB      = 0x00000004,
    HiberFileBucket32GB      = 0x00000005,
    HiberFileBucketUnlimited = 0x00000006,
    HiberFileBucketMax       = 0x00000007,
}

alias IMAGE_AUX_SYMBOL_TYPE = int;
enum : int
{
    IMAGE_AUX_SYMBOL_TYPE_TOKEN_DEF = 0x00000001,
}

alias ARM64_FNPDATA_FLAGS = int;
enum : int
{
    PdataRefToFullXdata       = 0x00000000,
    PdataPackedUnwindFunction = 0x00000001,
    PdataPackedUnwindFragment = 0x00000002,
}

alias ARM64_FNPDATA_CR = int;
enum : int
{
    PdataCrUnchained        = 0x00000000,
    PdataCrUnchainedSavedLr = 0x00000001,
    PdataCrChainedWithPac   = 0x00000002,
    PdataCrChained          = 0x00000003,
}

alias IMPORT_OBJECT_TYPE = int;
enum : int
{
    IMPORT_OBJECT_CODE  = 0x00000000,
    IMPORT_OBJECT_DATA  = 0x00000001,
    IMPORT_OBJECT_CONST = 0x00000002,
}

alias IMPORT_OBJECT_NAME_TYPE = int;
enum : int
{
    IMPORT_OBJECT_ORDINAL         = 0x00000000,
    IMPORT_OBJECT_NAME            = 0x00000001,
    IMPORT_OBJECT_NAME_NO_PREFIX  = 0x00000002,
    IMPORT_OBJECT_NAME_UNDECORATE = 0x00000003,
    IMPORT_OBJECT_NAME_EXPORTAS   = 0x00000004,
}

enum ReplacesCorHdrNumericDefines : int
{
    COMIMAGE_FLAGS_ILONLY                      = 0x00000001,
    COMIMAGE_FLAGS_32BITREQUIRED               = 0x00000002,
    COMIMAGE_FLAGS_IL_LIBRARY                  = 0x00000004,
    COMIMAGE_FLAGS_STRONGNAMESIGNED            = 0x00000008,
    COMIMAGE_FLAGS_NATIVE_ENTRYPOINT           = 0x00000010,
    COMIMAGE_FLAGS_TRACKDEBUGDATA              = 0x00010000,
    COMIMAGE_FLAGS_32BITPREFERRED              = 0x00020000,
    COR_VERSION_MAJOR_V2                       = 0x00000002,
    COR_VERSION_MAJOR                          = 0x00000002,
    COR_VERSION_MINOR                          = 0x00000005,
    COR_DELETED_NAME_LENGTH                    = 0x00000008,
    COR_VTABLEGAP_NAME_LENGTH                  = 0x00000008,
    NATIVE_TYPE_MAX_CB                         = 0x00000001,
    COR_ILMETHOD_SECT_SMALL_MAX_DATASIZE       = 0x000000ff,
    IMAGE_COR_MIH_METHODRVA                    = 0x00000001,
    IMAGE_COR_MIH_EHRVA                        = 0x00000002,
    IMAGE_COR_MIH_BASICBLOCK                   = 0x00000008,
    COR_VTABLE_32BIT                           = 0x00000001,
    COR_VTABLE_64BIT                           = 0x00000002,
    COR_VTABLE_FROM_UNMANAGED                  = 0x00000004,
    COR_VTABLE_FROM_UNMANAGED_RETAIN_APPDOMAIN = 0x00000008,
    COR_VTABLE_CALL_MOST_DERIVED               = 0x00000010,
    IMAGE_COR_EATJ_THUNK_SIZE                  = 0x00000020,
    MAX_CLASS_NAME                             = 0x00000400,
    MAX_PACKAGE_NAME                           = 0x00000400,
}

alias RTL_UMS_SCHEDULER_REASON = int;
enum : int
{
    UmsSchedulerStartup       = 0x00000000,
    UmsSchedulerThreadBlocked = 0x00000001,
    UmsSchedulerThreadYield   = 0x00000002,
}

alias IMAGE_POLICY_ENTRY_TYPE = int;
enum : int
{
    ImagePolicyEntryTypeNone          = 0x00000000,
    ImagePolicyEntryTypeBool          = 0x00000001,
    ImagePolicyEntryTypeInt8          = 0x00000002,
    ImagePolicyEntryTypeUInt8         = 0x00000003,
    ImagePolicyEntryTypeInt16         = 0x00000004,
    ImagePolicyEntryTypeUInt16        = 0x00000005,
    ImagePolicyEntryTypeInt32         = 0x00000006,
    ImagePolicyEntryTypeUInt32        = 0x00000007,
    ImagePolicyEntryTypeInt64         = 0x00000008,
    ImagePolicyEntryTypeUInt64        = 0x00000009,
    ImagePolicyEntryTypeAnsiString    = 0x0000000a,
    ImagePolicyEntryTypeUnicodeString = 0x0000000b,
    ImagePolicyEntryTypeOverride      = 0x0000000c,
    ImagePolicyEntryTypeMaximum       = 0x0000000d,
}

alias IMAGE_POLICY_ID = int;
enum : int
{
    ImagePolicyIdNone                  = 0x00000000,
    ImagePolicyIdEtw                   = 0x00000001,
    ImagePolicyIdDebug                 = 0x00000002,
    ImagePolicyIdCrashDump             = 0x00000003,
    ImagePolicyIdCrashDumpKey          = 0x00000004,
    ImagePolicyIdCrashDumpKeyGuid      = 0x00000005,
    ImagePolicyIdParentSd              = 0x00000006,
    ImagePolicyIdParentSdRev           = 0x00000007,
    ImagePolicyIdSvn                   = 0x00000008,
    ImagePolicyIdDeviceId              = 0x00000009,
    ImagePolicyIdCapability            = 0x0000000a,
    ImagePolicyIdScenarioId            = 0x0000000b,
    ImagePolicyIdCapabilityOverridable = 0x0000000c,
    ImagePolicyIdTrustletIdOverridable = 0x0000000d,
    ImagePolicyIdMaximum               = 0x0000000e,
}

alias ACTIVATION_CONTEXT_INFO_CLASS = int;
enum : int
{
    ActivationContextBasicInformation                      = 0x00000001,
    ActivationContextDetailedInformation                   = 0x00000002,
    AssemblyDetailedInformationInActivationContext         = 0x00000003,
    FileInformationInAssemblyOfAssemblyInActivationContext = 0x00000004,
    RunlevelInformationInActivationContext                 = 0x00000005,
    CompatibilityInformationInActivationContext            = 0x00000006,
    ActivationContextManifestResourceName                  = 0x00000007,
    MaxActivationContextInfoClass                          = 0x00000008,
    AssemblyDetailedInformationInActivationContxt          = 0x00000003,
    FileInformationInAssemblyOfAssemblyInActivationContxt  = 0x00000004,
}

alias SERVICE_NODE_TYPE = int;
enum : int
{
    DriverType               = 0x00000001,
    FileSystemType           = 0x00000002,
    Win32ServiceOwnProcess   = 0x00000010,
    Win32ServiceShareProcess = 0x00000020,
    AdapterType              = 0x00000004,
    RecognizerType           = 0x00000008,
}

alias SERVICE_LOAD_TYPE = int;
enum : int
{
    BootLoad    = 0x00000000,
    SystemLoad  = 0x00000001,
    AutoLoad    = 0x00000002,
    DemandLoad  = 0x00000003,
    DisableLoad = 0x00000004,
}

alias SERVICE_ERROR_TYPE = int;
enum : int
{
    IgnoreError   = 0x00000000,
    NormalError   = 0x00000001,
    SevereError   = 0x00000002,
    CriticalError = 0x00000003,
}

alias TAPE_DRIVE_PROBLEM_TYPE = int;
enum : int
{
    TapeDriveProblemNone         = 0x00000000,
    TapeDriveReadWriteWarning    = 0x00000001,
    TapeDriveReadWriteError      = 0x00000002,
    TapeDriveReadWarning         = 0x00000003,
    TapeDriveWriteWarning        = 0x00000004,
    TapeDriveReadError           = 0x00000005,
    TapeDriveWriteError          = 0x00000006,
    TapeDriveHardwareError       = 0x00000007,
    TapeDriveUnsupportedMedia    = 0x00000008,
    TapeDriveScsiConnectionError = 0x00000009,
    TapeDriveTimetoClean         = 0x0000000a,
    TapeDriveCleanDriveNow       = 0x0000000b,
    TapeDriveMediaLifeExpired    = 0x0000000c,
    TapeDriveSnappedTape         = 0x0000000d,
}

alias TRANSACTION_STATE = int;
enum : int
{
    TransactionStateNormal          = 0x00000001,
    TransactionStateIndoubt         = 0x00000002,
    TransactionStateCommittedNotify = 0x00000003,
}

alias TRANSACTION_INFORMATION_CLASS = int;
enum : int
{
    TransactionBasicInformation              = 0x00000000,
    TransactionPropertiesInformation         = 0x00000001,
    TransactionEnlistmentInformation         = 0x00000002,
    TransactionSuperiorEnlistmentInformation = 0x00000003,
    TransactionBindInformation               = 0x00000004,
    TransactionDTCPrivateInformation         = 0x00000005,
}

alias TRANSACTIONMANAGER_INFORMATION_CLASS = int;
enum : int
{
    TransactionManagerBasicInformation             = 0x00000000,
    TransactionManagerLogInformation               = 0x00000001,
    TransactionManagerLogPathInformation           = 0x00000002,
    TransactionManagerRecoveryInformation          = 0x00000004,
    TransactionManagerOnlineProbeInformation       = 0x00000003,
    TransactionManagerOldestTransactionInformation = 0x00000005,
}

alias RESOURCEMANAGER_INFORMATION_CLASS = int;
enum : int
{
    ResourceManagerBasicInformation      = 0x00000000,
    ResourceManagerCompletionInformation = 0x00000001,
}

alias ENLISTMENT_INFORMATION_CLASS = int;
enum : int
{
    EnlistmentBasicInformation    = 0x00000000,
    EnlistmentRecoveryInformation = 0x00000001,
    EnlistmentCrmInformation      = 0x00000002,
}

alias KTMOBJECT_TYPE = int;
enum : int
{
    KTMOBJECT_TRANSACTION         = 0x00000000,
    KTMOBJECT_TRANSACTION_MANAGER = 0x00000001,
    KTMOBJECT_RESOURCE_MANAGER    = 0x00000002,
    KTMOBJECT_ENLISTMENT          = 0x00000003,
    KTMOBJECT_INVALID             = 0x00000004,
}

// Constants


enum : uint
{
    _MM_HINT_T0  = 0x00000001U,
    _MM_HINT_T1  = 0x00000002U,
    _MM_HINT_T2  = 0x00000003U,
    _MM_HINT_NTA = 0x00000000U,
}

enum uint ANYSIZE_ARRAY = 0x00000001U;
enum uint MEMORY_ALLOCATION_ALIGNMENT = 0x00000010U;
enum uint X86_CACHE_ALIGNMENT_SIZE = 0x00000040U;
enum uint ARM_CACHE_ALIGNMENT_SIZE = 0x00000080U;
enum uint SYSTEM_CACHE_ALIGNMENT_SIZE = 0x00000040U;
enum uint PRAGMA_DEPRECATED_DDK = 0x00000001U;
enum uint UCSCHAR_INVALID_CHARACTER = 0xffffffffU;
enum uint MIN_UCSCHAR = 0x00000000U;
enum uint MAX_UCSCHAR = 0x0010ffffU;

enum : uint
{
    MAXIMUM_PROC_PER_GROUP = 0x00000040U,
    MAXIMUM_PROCESSORS     = 0x00000040U,
}

enum uint APPLICATION_ERROR_MASK = 0x20000000U;

enum : uint
{
    ERROR_SEVERITY_SUCCESS       = 0x00000000U,
    ERROR_SEVERITY_INFORMATIONAL = 0x40000000U,
    ERROR_SEVERITY_WARNING       = 0x80000000U,
    ERROR_SEVERITY_ERROR         = 0xc0000000U,
}

enum ulong MAXLONGLONG = 0x7fffffffffffffffUL;
enum uint UNICODE_STRING_MAX_CHARS = 0x00007fffU;
enum uint MINCHAR = 0x00000080U;
enum uint MAXCHAR = 0x0000007fU;
enum uint MINSHORT = 0x00008000U;
enum uint MAXSHORT = 0x00007fffU;
enum uint MINLONG = 0x80000000U;

enum : uint
{
    MAXLONG  = 0x7fffffffU,
    MAXBYTE  = 0x000000ffU,
    MAXWORD  = 0x0000ffffU,
    MAXDWORD = 0xffffffffU,
}

enum uint ENCLAVE_SHORT_ID_LENGTH = 0x00000010U;
enum uint ENCLAVE_LONG_ID_LENGTH = 0x00000020U;
enum uint VER_SERVER_NT = 0x80000000U;
enum uint VER_WORKSTATION_NT = 0x40000000U;

enum : uint
{
    VER_SUITE_SMALLBUSINESS            = 0x00000001U,
    VER_SUITE_ENTERPRISE               = 0x00000002U,
    VER_SUITE_BACKOFFICE               = 0x00000004U,
    VER_SUITE_COMMUNICATIONS           = 0x00000008U,
    VER_SUITE_TERMINAL                 = 0x00000010U,
    VER_SUITE_SMALLBUSINESS_RESTRICTED = 0x00000020U,
}

enum : uint
{
    VER_SUITE_EMBEDDEDNT          = 0x00000040U,
    VER_SUITE_DATACENTER          = 0x00000080U,
    VER_SUITE_SINGLEUSERTS        = 0x00000100U,
    VER_SUITE_PERSONAL            = 0x00000200U,
    VER_SUITE_BLADE               = 0x00000400U,
    VER_SUITE_EMBEDDED_RESTRICTED = 0x00000800U,
}

enum uint VER_SUITE_SECURITY_APPLIANCE = 0x00001000U;

enum : uint
{
    VER_SUITE_STORAGE_SERVER = 0x00002000U,
    VER_SUITE_COMPUTE_SERVER = 0x00004000U,
    VER_SUITE_WH_SERVER      = 0x00008000U,
    VER_SUITE_MULTIUSERTS    = 0x00020000U,
}

enum : uint
{
    LANG_NEUTRAL   = 0x00000000U,
    LANG_INVARIANT = 0x0000007fU,
}

enum : uint
{
    LANG_AFRIKAANS   = 0x00000036U,
    LANG_ALBANIAN    = 0x0000001cU,
    LANG_ALSATIAN    = 0x00000084U,
    LANG_AMHARIC     = 0x0000005eU,
    LANG_ARABIC      = 0x00000001U,
    LANG_ARMENIAN    = 0x0000002bU,
    LANG_ASSAMESE    = 0x0000004dU,
    LANG_AZERI       = 0x0000002cU,
    LANG_AZERBAIJANI = 0x0000002cU,
}

enum : uint
{
    LANG_BANGLA          = 0x00000045U,
    LANG_BASHKIR         = 0x0000006dU,
    LANG_BASQUE          = 0x0000002dU,
    LANG_BELARUSIAN      = 0x00000023U,
    LANG_BENGALI         = 0x00000045U,
    LANG_BRETON          = 0x0000007eU,
    LANG_BOSNIAN         = 0x0000001aU,
    LANG_BOSNIAN_NEUTRAL = 0x0000781aU,
}

enum uint LANG_BULGARIAN = 0x00000002U;

enum : uint
{
    LANG_CATALAN         = 0x00000003U,
    LANG_CENTRAL_KURDISH = 0x00000092U,
}

enum : uint
{
    LANG_CHEROKEE            = 0x0000005cU,
    LANG_CHINESE             = 0x00000004U,
    LANG_CHINESE_SIMPLIFIED  = 0x00000004U,
    LANG_CHINESE_TRADITIONAL = 0x00007c04U,
}

enum : uint
{
    LANG_CORSICAN = 0x00000083U,
    LANG_CROATIAN = 0x0000001aU,
    LANG_CZECH    = 0x00000005U,
    LANG_DANISH   = 0x00000006U,
    LANG_DARI     = 0x0000008cU,
    LANG_DIVEHI   = 0x00000065U,
    LANG_DUTCH    = 0x00000013U,
    LANG_ENGLISH  = 0x00000009U,
    LANG_ESTONIAN = 0x00000025U,
}

enum : uint
{
    LANG_FAEROESE    = 0x00000038U,
    LANG_FARSI       = 0x00000029U,
    LANG_FILIPINO    = 0x00000064U,
    LANG_FINNISH     = 0x0000000bU,
    LANG_FRENCH      = 0x0000000cU,
    LANG_FRISIAN     = 0x00000062U,
    LANG_FULAH       = 0x00000067U,
    LANG_GALICIAN    = 0x00000056U,
    LANG_GEORGIAN    = 0x00000037U,
    LANG_GERMAN      = 0x00000007U,
    LANG_GREEK       = 0x00000008U,
    LANG_GREENLANDIC = 0x0000006fU,
}

enum uint LANG_GUJARATI = 0x00000047U;

enum : uint
{
    LANG_HAUSA     = 0x00000068U,
    LANG_HAWAIIAN  = 0x00000075U,
    LANG_HEBREW    = 0x0000000dU,
    LANG_HINDI     = 0x00000039U,
    LANG_HUNGARIAN = 0x0000000eU,
}

enum : uint
{
    LANG_ICELANDIC  = 0x0000000fU,
    LANG_IGBO       = 0x00000070U,
    LANG_INDONESIAN = 0x00000021U,
    LANG_INUKTITUT  = 0x0000005dU,
    LANG_IRISH      = 0x0000003cU,
    LANG_ITALIAN    = 0x00000010U,
    LANG_JAPANESE   = 0x00000011U,
}

enum : uint
{
    LANG_KANNADA     = 0x0000004bU,
    LANG_KASHMIRI    = 0x00000060U,
    LANG_KAZAK       = 0x0000003fU,
    LANG_KHMER       = 0x00000053U,
    LANG_KICHE       = 0x00000086U,
    LANG_KINYARWANDA = 0x00000087U,
}

enum : uint
{
    LANG_KONKANI    = 0x00000057U,
    LANG_KOREAN     = 0x00000012U,
    LANG_KYRGYZ     = 0x00000040U,
    LANG_LAO        = 0x00000054U,
    LANG_LATVIAN    = 0x00000026U,
    LANG_LITHUANIAN = 0x00000027U,
}

enum uint LANG_LOWER_SORBIAN = 0x0000002eU;
enum uint LANG_LUXEMBOURGISH = 0x0000006eU;

enum : uint
{
    LANG_MACEDONIAN = 0x0000002fU,
    LANG_MALAY      = 0x0000003eU,
    LANG_MALAYALAM  = 0x0000004cU,
    LANG_MALTESE    = 0x0000003aU,
    LANG_MANIPURI   = 0x00000058U,
    LANG_MAORI      = 0x00000081U,
    LANG_MAPUDUNGUN = 0x0000007aU,
    LANG_MARATHI    = 0x0000004eU,
    LANG_MOHAWK     = 0x0000007cU,
    LANG_MONGOLIAN  = 0x00000050U,
}

enum : uint
{
    LANG_NEPALI    = 0x00000061U,
    LANG_NORWEGIAN = 0x00000014U,
}

enum : uint
{
    LANG_OCCITAN    = 0x00000082U,
    LANG_ODIA       = 0x00000048U,
    LANG_ORIYA      = 0x00000048U,
    LANG_PASHTO     = 0x00000063U,
    LANG_PERSIAN    = 0x00000029U,
    LANG_POLISH     = 0x00000015U,
    LANG_PORTUGUESE = 0x00000016U,
}

enum : uint
{
    LANG_PULAR           = 0x00000067U,
    LANG_PUNJABI         = 0x00000046U,
    LANG_QUECHUA         = 0x0000006bU,
    LANG_ROMANIAN        = 0x00000018U,
    LANG_ROMANSH         = 0x00000017U,
    LANG_RUSSIAN         = 0x00000019U,
    LANG_SAKHA           = 0x00000085U,
    LANG_SAMI            = 0x0000003bU,
    LANG_SANSKRIT        = 0x0000004fU,
    LANG_SCOTTISH_GAELIC = 0x00000091U,
}

enum : uint
{
    LANG_SERBIAN         = 0x0000001aU,
    LANG_SERBIAN_NEUTRAL = 0x00007c1aU,
}

enum : uint
{
    LANG_SINDHI        = 0x00000059U,
    LANG_SINHALESE     = 0x0000005bU,
    LANG_SLOVAK        = 0x0000001bU,
    LANG_SLOVENIAN     = 0x00000024U,
    LANG_SOTHO         = 0x0000006cU,
    LANG_SPANISH       = 0x0000000aU,
    LANG_SWAHILI       = 0x00000041U,
    LANG_SWEDISH       = 0x0000001dU,
    LANG_SYRIAC        = 0x0000005aU,
    LANG_TAJIK         = 0x00000028U,
    LANG_TAMAZIGHT     = 0x0000005fU,
    LANG_TAMIL         = 0x00000049U,
    LANG_TATAR         = 0x00000044U,
    LANG_TELUGU        = 0x0000004aU,
    LANG_THAI          = 0x0000001eU,
    LANG_TIBETAN       = 0x00000051U,
    LANG_TIGRIGNA      = 0x00000073U,
    LANG_TIGRINYA      = 0x00000073U,
    LANG_TSWANA        = 0x00000032U,
    LANG_TURKISH       = 0x0000001fU,
    LANG_TURKMEN       = 0x00000042U,
    LANG_UIGHUR        = 0x00000080U,
    LANG_UKRAINIAN     = 0x00000022U,
    LANG_UPPER_SORBIAN = 0x0000002eU,
}

enum : uint
{
    LANG_URDU       = 0x00000020U,
    LANG_UZBEK      = 0x00000043U,
    LANG_VALENCIAN  = 0x00000003U,
    LANG_VIETNAMESE = 0x0000002aU,
}

enum : uint
{
    LANG_WELSH  = 0x00000052U,
    LANG_WOLOF  = 0x00000088U,
    LANG_XHOSA  = 0x00000034U,
    LANG_YAKUT  = 0x00000085U,
    LANG_YI     = 0x00000078U,
    LANG_YORUBA = 0x0000006aU,
    LANG_ZULU   = 0x00000035U,
}

enum : uint
{
    SUBLANG_NEUTRAL            = 0x00000000U,
    SUBLANG_DEFAULT            = 0x00000001U,
    SUBLANG_SYS_DEFAULT        = 0x00000002U,
    SUBLANG_CUSTOM_DEFAULT     = 0x00000003U,
    SUBLANG_CUSTOM_UNSPECIFIED = 0x00000004U,
}

enum uint SUBLANG_UI_CUSTOM_DEFAULT = 0x00000005U;
enum uint SUBLANG_AFRIKAANS_SOUTH_AFRICA = 0x00000001U;

enum : uint
{
    SUBLANG_ALBANIAN_ALBANIA = 0x00000001U,
    SUBLANG_ALSATIAN_FRANCE  = 0x00000001U,
}

enum uint SUBLANG_AMHARIC_ETHIOPIA = 0x00000001U;

enum : uint
{
    SUBLANG_ARABIC_SAUDI_ARABIA = 0x00000001U,
    SUBLANG_ARABIC_IRAQ         = 0x00000002U,
    SUBLANG_ARABIC_EGYPT        = 0x00000003U,
    SUBLANG_ARABIC_LIBYA        = 0x00000004U,
    SUBLANG_ARABIC_ALGERIA      = 0x00000005U,
    SUBLANG_ARABIC_MOROCCO      = 0x00000006U,
    SUBLANG_ARABIC_TUNISIA      = 0x00000007U,
    SUBLANG_ARABIC_OMAN         = 0x00000008U,
    SUBLANG_ARABIC_YEMEN        = 0x00000009U,
    SUBLANG_ARABIC_SYRIA        = 0x0000000aU,
    SUBLANG_ARABIC_JORDAN       = 0x0000000bU,
    SUBLANG_ARABIC_LEBANON      = 0x0000000cU,
    SUBLANG_ARABIC_KUWAIT       = 0x0000000dU,
    SUBLANG_ARABIC_UAE          = 0x0000000eU,
    SUBLANG_ARABIC_BAHRAIN      = 0x0000000fU,
    SUBLANG_ARABIC_QATAR        = 0x00000010U,
    SUBLANG_ARMENIAN_ARMENIA    = 0x00000001U,
}

enum : uint
{
    SUBLANG_ASSAMESE_INDIA                  = 0x00000001U,
    SUBLANG_AZERI_LATIN                     = 0x00000001U,
    SUBLANG_AZERI_CYRILLIC                  = 0x00000002U,
    SUBLANG_AZERBAIJANI_AZERBAIJAN_LATIN    = 0x00000001U,
    SUBLANG_AZERBAIJANI_AZERBAIJAN_CYRILLIC = 0x00000002U,
}

enum : uint
{
    SUBLANG_BANGLA_INDIA      = 0x00000001U,
    SUBLANG_BANGLA_BANGLADESH = 0x00000002U,
}

enum : uint
{
    SUBLANG_BASHKIR_RUSSIA     = 0x00000001U,
    SUBLANG_BASQUE_BASQUE      = 0x00000001U,
    SUBLANG_BELARUSIAN_BELARUS = 0x00000001U,
}

enum : uint
{
    SUBLANG_BENGALI_INDIA      = 0x00000001U,
    SUBLANG_BENGALI_BANGLADESH = 0x00000002U,
}

enum : uint
{
    SUBLANG_BOSNIAN_BOSNIA_HERZEGOVINA_LATIN    = 0x00000005U,
    SUBLANG_BOSNIAN_BOSNIA_HERZEGOVINA_CYRILLIC = 0x00000008U,
}

enum : uint
{
    SUBLANG_BRETON_FRANCE      = 0x00000001U,
    SUBLANG_BULGARIAN_BULGARIA = 0x00000001U,
}

enum uint SUBLANG_CATALAN_CATALAN = 0x00000001U;
enum uint SUBLANG_CENTRAL_KURDISH_IRAQ = 0x00000001U;
enum uint SUBLANG_CHEROKEE_CHEROKEE = 0x00000001U;

enum : uint
{
    SUBLANG_CHINESE_TRADITIONAL = 0x00000001U,
    SUBLANG_CHINESE_SIMPLIFIED  = 0x00000002U,
    SUBLANG_CHINESE_HONGKONG    = 0x00000003U,
    SUBLANG_CHINESE_SINGAPORE   = 0x00000004U,
    SUBLANG_CHINESE_MACAU       = 0x00000005U,
    SUBLANG_CORSICAN_FRANCE     = 0x00000001U,
}

enum uint SUBLANG_CZECH_CZECH_REPUBLIC = 0x00000001U;

enum : uint
{
    SUBLANG_CROATIAN_CROATIA                  = 0x00000001U,
    SUBLANG_CROATIAN_BOSNIA_HERZEGOVINA_LATIN = 0x00000004U,
}

enum : uint
{
    SUBLANG_DANISH_DENMARK   = 0x00000001U,
    SUBLANG_DARI_AFGHANISTAN = 0x00000001U,
}

enum uint SUBLANG_DIVEHI_MALDIVES = 0x00000001U;

enum : uint
{
    SUBLANG_DUTCH         = 0x00000001U,
    SUBLANG_DUTCH_BELGIAN = 0x00000002U,
}

enum : uint
{
    SUBLANG_ENGLISH_US           = 0x00000001U,
    SUBLANG_ENGLISH_UK           = 0x00000002U,
    SUBLANG_ENGLISH_AUS          = 0x00000003U,
    SUBLANG_ENGLISH_CAN          = 0x00000004U,
    SUBLANG_ENGLISH_NZ           = 0x00000005U,
    SUBLANG_ENGLISH_EIRE         = 0x00000006U,
    SUBLANG_ENGLISH_SOUTH_AFRICA = 0x00000007U,
    SUBLANG_ENGLISH_JAMAICA      = 0x00000008U,
    SUBLANG_ENGLISH_CARIBBEAN    = 0x00000009U,
    SUBLANG_ENGLISH_BELIZE       = 0x0000000aU,
    SUBLANG_ENGLISH_TRINIDAD     = 0x0000000bU,
    SUBLANG_ENGLISH_ZIMBABWE     = 0x0000000cU,
    SUBLANG_ENGLISH_PHILIPPINES  = 0x0000000dU,
    SUBLANG_ENGLISH_INDIA        = 0x00000010U,
    SUBLANG_ENGLISH_MALAYSIA     = 0x00000011U,
    SUBLANG_ENGLISH_SINGAPORE    = 0x00000012U,
}

enum uint SUBLANG_ESTONIAN_ESTONIA = 0x00000001U;
enum uint SUBLANG_FAEROESE_FAROE_ISLANDS = 0x00000001U;
enum uint SUBLANG_FILIPINO_PHILIPPINES = 0x00000001U;
enum uint SUBLANG_FINNISH_FINLAND = 0x00000001U;

enum : uint
{
    SUBLANG_FRENCH              = 0x00000001U,
    SUBLANG_FRENCH_BELGIAN      = 0x00000002U,
    SUBLANG_FRENCH_CANADIAN     = 0x00000003U,
    SUBLANG_FRENCH_SWISS        = 0x00000004U,
    SUBLANG_FRENCH_LUXEMBOURG   = 0x00000005U,
    SUBLANG_FRENCH_MONACO       = 0x00000006U,
    SUBLANG_FRISIAN_NETHERLANDS = 0x00000001U,
}

enum uint SUBLANG_FULAH_SENEGAL = 0x00000002U;
enum uint SUBLANG_GALICIAN_GALICIAN = 0x00000001U;

enum : uint
{
    SUBLANG_GEORGIAN_GEORGIA     = 0x00000001U,
    SUBLANG_GERMAN               = 0x00000001U,
    SUBLANG_GERMAN_SWISS         = 0x00000002U,
    SUBLANG_GERMAN_AUSTRIAN      = 0x00000003U,
    SUBLANG_GERMAN_LUXEMBOURG    = 0x00000004U,
    SUBLANG_GERMAN_LIECHTENSTEIN = 0x00000005U,
}

enum : uint
{
    SUBLANG_GREEK_GREECE          = 0x00000001U,
    SUBLANG_GREENLANDIC_GREENLAND = 0x00000001U,
}

enum uint SUBLANG_GUJARATI_INDIA = 0x00000001U;
enum uint SUBLANG_HAUSA_NIGERIA_LATIN = 0x00000001U;

enum : uint
{
    SUBLANG_HAWAIIAN_US       = 0x00000001U,
    SUBLANG_HEBREW_ISRAEL     = 0x00000001U,
    SUBLANG_HINDI_INDIA       = 0x00000001U,
    SUBLANG_HUNGARIAN_HUNGARY = 0x00000001U,
}

enum uint SUBLANG_ICELANDIC_ICELAND = 0x00000001U;

enum : uint
{
    SUBLANG_IGBO_NIGERIA         = 0x00000001U,
    SUBLANG_INDONESIAN_INDONESIA = 0x00000001U,
}

enum : uint
{
    SUBLANG_INUKTITUT_CANADA       = 0x00000001U,
    SUBLANG_INUKTITUT_CANADA_LATIN = 0x00000002U,
}

enum : uint
{
    SUBLANG_IRISH_IRELAND = 0x00000002U,
    SUBLANG_ITALIAN       = 0x00000001U,
    SUBLANG_ITALIAN_SWISS = 0x00000002U,
}

enum uint SUBLANG_JAPANESE_JAPAN = 0x00000001U;

enum : uint
{
    SUBLANG_KANNADA_INDIA    = 0x00000001U,
    SUBLANG_KASHMIRI_SASIA   = 0x00000002U,
    SUBLANG_KASHMIRI_INDIA   = 0x00000002U,
    SUBLANG_KAZAK_KAZAKHSTAN = 0x00000001U,
}

enum : uint
{
    SUBLANG_KHMER_CAMBODIA     = 0x00000001U,
    SUBLANG_KICHE_GUATEMALA    = 0x00000001U,
    SUBLANG_KINYARWANDA_RWANDA = 0x00000001U,
}

enum : uint
{
    SUBLANG_KONKANI_INDIA     = 0x00000001U,
    SUBLANG_KOREAN            = 0x00000001U,
    SUBLANG_KYRGYZ_KYRGYZSTAN = 0x00000001U,
}

enum : uint
{
    SUBLANG_LAO_LAO               = 0x00000001U,
    SUBLANG_LATVIAN_LATVIA        = 0x00000001U,
    SUBLANG_LITHUANIAN            = 0x00000001U,
    SUBLANG_LOWER_SORBIAN_GERMANY = 0x00000002U,
}

enum uint SUBLANG_LUXEMBOURGISH_LUXEMBOURG = 0x00000001U;
enum uint SUBLANG_MACEDONIAN_MACEDONIA = 0x00000001U;

enum : uint
{
    SUBLANG_MALAY_MALAYSIA          = 0x00000001U,
    SUBLANG_MALAY_BRUNEI_DARUSSALAM = 0x00000002U,
    SUBLANG_MALAYALAM_INDIA         = 0x00000001U,
    SUBLANG_MALTESE_MALTA           = 0x00000001U,
    SUBLANG_MAORI_NEW_ZEALAND       = 0x00000001U,
}

enum : uint
{
    SUBLANG_MAPUDUNGUN_CHILE            = 0x00000001U,
    SUBLANG_MARATHI_INDIA               = 0x00000001U,
    SUBLANG_MOHAWK_MOHAWK               = 0x00000001U,
    SUBLANG_MONGOLIAN_CYRILLIC_MONGOLIA = 0x00000001U,
    SUBLANG_MONGOLIAN_PRC               = 0x00000002U,
}

enum : uint
{
    SUBLANG_NEPALI_INDIA      = 0x00000002U,
    SUBLANG_NEPALI_NEPAL      = 0x00000001U,
    SUBLANG_NORWEGIAN_BOKMAL  = 0x00000001U,
    SUBLANG_NORWEGIAN_NYNORSK = 0x00000002U,
}

enum : uint
{
    SUBLANG_OCCITAN_FRANCE     = 0x00000001U,
    SUBLANG_ODIA_INDIA         = 0x00000001U,
    SUBLANG_ORIYA_INDIA        = 0x00000001U,
    SUBLANG_PASHTO_AFGHANISTAN = 0x00000001U,
}

enum : uint
{
    SUBLANG_PERSIAN_IRAN         = 0x00000001U,
    SUBLANG_POLISH_POLAND        = 0x00000001U,
    SUBLANG_PORTUGUESE           = 0x00000002U,
    SUBLANG_PORTUGUESE_BRAZILIAN = 0x00000001U,
}

enum : uint
{
    SUBLANG_PULAR_SENEGAL    = 0x00000002U,
    SUBLANG_PUNJABI_INDIA    = 0x00000001U,
    SUBLANG_PUNJABI_PAKISTAN = 0x00000002U,
}

enum : uint
{
    SUBLANG_QUECHUA_BOLIVIA = 0x00000001U,
    SUBLANG_QUECHUA_ECUADOR = 0x00000002U,
    SUBLANG_QUECHUA_PERU    = 0x00000003U,
}

enum : uint
{
    SUBLANG_ROMANIAN_ROMANIA    = 0x00000001U,
    SUBLANG_ROMANSH_SWITZERLAND = 0x00000001U,
}

enum uint SUBLANG_RUSSIAN_RUSSIA = 0x00000001U;

enum : uint
{
    SUBLANG_SAKHA_RUSSIA          = 0x00000001U,
    SUBLANG_SAMI_NORTHERN_NORWAY  = 0x00000001U,
    SUBLANG_SAMI_NORTHERN_SWEDEN  = 0x00000002U,
    SUBLANG_SAMI_NORTHERN_FINLAND = 0x00000003U,
    SUBLANG_SAMI_LULE_NORWAY      = 0x00000004U,
    SUBLANG_SAMI_LULE_SWEDEN      = 0x00000005U,
    SUBLANG_SAMI_SOUTHERN_NORWAY  = 0x00000006U,
    SUBLANG_SAMI_SOUTHERN_SWEDEN  = 0x00000007U,
    SUBLANG_SAMI_SKOLT_FINLAND    = 0x00000008U,
    SUBLANG_SAMI_INARI_FINLAND    = 0x00000009U,
}

enum : uint
{
    SUBLANG_SANSKRIT_INDIA  = 0x00000001U,
    SUBLANG_SCOTTISH_GAELIC = 0x00000001U,
}

enum : uint
{
    SUBLANG_SERBIAN_BOSNIA_HERZEGOVINA_LATIN    = 0x00000006U,
    SUBLANG_SERBIAN_BOSNIA_HERZEGOVINA_CYRILLIC = 0x00000007U,
}

enum : uint
{
    SUBLANG_SERBIAN_MONTENEGRO_LATIN    = 0x0000000bU,
    SUBLANG_SERBIAN_MONTENEGRO_CYRILLIC = 0x0000000cU,
    SUBLANG_SERBIAN_SERBIA_LATIN        = 0x00000009U,
    SUBLANG_SERBIAN_SERBIA_CYRILLIC     = 0x0000000aU,
    SUBLANG_SERBIAN_CROATIA             = 0x00000001U,
    SUBLANG_SERBIAN_LATIN               = 0x00000002U,
    SUBLANG_SERBIAN_CYRILLIC            = 0x00000003U,
}

enum : uint
{
    SUBLANG_SINDHI_INDIA        = 0x00000001U,
    SUBLANG_SINDHI_PAKISTAN     = 0x00000002U,
    SUBLANG_SINDHI_AFGHANISTAN  = 0x00000002U,
    SUBLANG_SINHALESE_SRI_LANKA = 0x00000001U,
}

enum uint SUBLANG_SOTHO_NORTHERN_SOUTH_AFRICA = 0x00000001U;

enum : uint
{
    SUBLANG_SLOVAK_SLOVAKIA    = 0x00000001U,
    SUBLANG_SLOVENIAN_SLOVENIA = 0x00000001U,
}

enum : uint
{
    SUBLANG_SPANISH                    = 0x00000001U,
    SUBLANG_SPANISH_MEXICAN            = 0x00000002U,
    SUBLANG_SPANISH_MODERN             = 0x00000003U,
    SUBLANG_SPANISH_GUATEMALA          = 0x00000004U,
    SUBLANG_SPANISH_COSTA_RICA         = 0x00000005U,
    SUBLANG_SPANISH_PANAMA             = 0x00000006U,
    SUBLANG_SPANISH_DOMINICAN_REPUBLIC = 0x00000007U,
    SUBLANG_SPANISH_VENEZUELA          = 0x00000008U,
    SUBLANG_SPANISH_COLOMBIA           = 0x00000009U,
    SUBLANG_SPANISH_PERU               = 0x0000000aU,
    SUBLANG_SPANISH_ARGENTINA          = 0x0000000bU,
    SUBLANG_SPANISH_ECUADOR            = 0x0000000cU,
    SUBLANG_SPANISH_CHILE              = 0x0000000dU,
    SUBLANG_SPANISH_URUGUAY            = 0x0000000eU,
    SUBLANG_SPANISH_PARAGUAY           = 0x0000000fU,
    SUBLANG_SPANISH_BOLIVIA            = 0x00000010U,
    SUBLANG_SPANISH_EL_SALVADOR        = 0x00000011U,
    SUBLANG_SPANISH_HONDURAS           = 0x00000012U,
    SUBLANG_SPANISH_NICARAGUA          = 0x00000013U,
    SUBLANG_SPANISH_PUERTO_RICO        = 0x00000014U,
    SUBLANG_SPANISH_US                 = 0x00000015U,
    SUBLANG_SWAHILI_KENYA              = 0x00000001U,
    SUBLANG_SWEDISH                    = 0x00000001U,
    SUBLANG_SWEDISH_FINLAND            = 0x00000002U,
}

enum uint SUBLANG_SYRIAC_SYRIA = 0x00000001U;

enum : uint
{
    SUBLANG_TAJIK_TAJIKISTAN           = 0x00000001U,
    SUBLANG_TAMAZIGHT_ALGERIA_LATIN    = 0x00000002U,
    SUBLANG_TAMAZIGHT_MOROCCO_TIFINAGH = 0x00000004U,
}

enum : uint
{
    SUBLANG_TAMIL_INDIA       = 0x00000001U,
    SUBLANG_TAMIL_SRI_LANKA   = 0x00000002U,
    SUBLANG_TATAR_RUSSIA      = 0x00000001U,
    SUBLANG_TELUGU_INDIA      = 0x00000001U,
    SUBLANG_THAI_THAILAND     = 0x00000001U,
    SUBLANG_TIBETAN_PRC       = 0x00000001U,
    SUBLANG_TIGRIGNA_ERITREA  = 0x00000002U,
    SUBLANG_TIGRINYA_ERITREA  = 0x00000002U,
    SUBLANG_TIGRINYA_ETHIOPIA = 0x00000001U,
}

enum : uint
{
    SUBLANG_TSWANA_BOTSWANA     = 0x00000002U,
    SUBLANG_TSWANA_SOUTH_AFRICA = 0x00000001U,
}

enum : uint
{
    SUBLANG_TURKISH_TURKEY       = 0x00000001U,
    SUBLANG_TURKMEN_TURKMENISTAN = 0x00000001U,
}

enum : uint
{
    SUBLANG_UIGHUR_PRC        = 0x00000001U,
    SUBLANG_UKRAINIAN_UKRAINE = 0x00000001U,
}

enum uint SUBLANG_UPPER_SORBIAN_GERMANY = 0x00000001U;

enum : uint
{
    SUBLANG_URDU_PAKISTAN  = 0x00000001U,
    SUBLANG_URDU_INDIA     = 0x00000002U,
    SUBLANG_UZBEK_LATIN    = 0x00000001U,
    SUBLANG_UZBEK_CYRILLIC = 0x00000002U,
}

enum uint SUBLANG_VALENCIAN_VALENCIA = 0x00000002U;
enum uint SUBLANG_VIETNAMESE_VIETNAM = 0x00000001U;
enum uint SUBLANG_WELSH_UNITED_KINGDOM = 0x00000001U;
enum uint SUBLANG_WOLOF_SENEGAL = 0x00000001U;
enum uint SUBLANG_XHOSA_SOUTH_AFRICA = 0x00000001U;

enum : uint
{
    SUBLANG_YAKUT_RUSSIA   = 0x00000001U,
    SUBLANG_YI_PRC         = 0x00000001U,
    SUBLANG_YORUBA_NIGERIA = 0x00000001U,
}

enum uint SUBLANG_ZULU_SOUTH_AFRICA = 0x00000001U;

enum : uint
{
    SORT_DEFAULT        = 0x00000000U,
    SORT_INVARIANT_MATH = 0x00000001U,
}

enum : uint
{
    SORT_JAPANESE_XJIS          = 0x00000000U,
    SORT_JAPANESE_UNICODE       = 0x00000001U,
    SORT_JAPANESE_RADICALSTROKE = 0x00000004U,
}

enum : uint
{
    SORT_CHINESE_BIG5          = 0x00000000U,
    SORT_CHINESE_PRCP          = 0x00000000U,
    SORT_CHINESE_UNICODE       = 0x00000001U,
    SORT_CHINESE_PRC           = 0x00000002U,
    SORT_CHINESE_BOPOMOFO      = 0x00000003U,
    SORT_CHINESE_RADICALSTROKE = 0x00000004U,
}

enum : uint
{
    SORT_KOREAN_KSC     = 0x00000000U,
    SORT_KOREAN_UNICODE = 0x00000001U,
}

enum uint SORT_GERMAN_PHONE_BOOK = 0x00000001U;

enum : uint
{
    SORT_HUNGARIAN_DEFAULT   = 0x00000000U,
    SORT_HUNGARIAN_TECHNICAL = 0x00000001U,
}

enum : uint
{
    SORT_GEORGIAN_TRADITIONAL = 0x00000000U,
    SORT_GEORGIAN_MODERN      = 0x00000001U,
}

enum uint NLS_VALID_LOCALE_MASK = 0x000fffffU;
enum uint LOCALE_NAME_MAX_LENGTH = 0x00000055U;

enum : uint
{
    LOCALE_TRANSIENT_KEYBOARD1 = 0x00002000U,
    LOCALE_TRANSIENT_KEYBOARD2 = 0x00002400U,
    LOCALE_TRANSIENT_KEYBOARD3 = 0x00002800U,
    LOCALE_TRANSIENT_KEYBOARD4 = 0x00002c00U,
}

enum uint LOCALE_UNASSIGNED_LCID = 0x00001000U;
enum uint MAXIMUM_WAIT_OBJECTS = 0x00000040U;
enum uint MAXIMUM_SUSPEND_COUNT = 0x0000007fU;
enum uint XSTATE_CONTEXT_FLAG_LOOKASIDE = 0x00000001U;

enum : uint
{
    PF_TEMPORAL_LEVEL_1 = 0x00000001U,
    PF_TEMPORAL_LEVEL_2 = 0x00000002U,
    PF_TEMPORAL_LEVEL_3 = 0x00000003U,
}

enum uint PF_NON_TEMPORAL_LEVEL_ALL = 0x00000000U;

enum : uint
{
    EXCEPTION_READ_FAULT    = 0x00000000U,
    EXCEPTION_WRITE_FAULT   = 0x00000001U,
    EXCEPTION_EXECUTE_FAULT = 0x00000008U,
}

enum : uint
{
    INITIAL_MXCSR = 0x00001f80U,
    INITIAL_FPCSR = 0x0000027fU,
}

enum uint RUNTIME_FUNCTION_INDIRECT = 0x00000001U;
enum uint UNW_FLAG_NO_EPILOGUE = 0x80000000U;
enum uint UNWIND_CHAIN_LIMIT = 0x00000020U;
// Native encoding: ansi
enum const(wchar)* OUT_OF_PROCESS_FUNCTION_TABLE_CALLBACK_EXPORT_NAME = "OutOfProcessFunctionTableCallback";

enum : uint
{
    INITIAL_CPSR  = 0x00000010U,
    INITIAL_FPSCR = 0x00000000U,
}

enum : uint
{
    ARM_MAX_BREAKPOINTS = 0x00000008U,
    ARM_MAX_WATCHPOINTS = 0x00000001U,
}

enum : uint
{
    ARM64_PREFETCH_PLD  = 0x00000000U,
    ARM64_PREFETCH_PLI  = 0x00000008U,
    ARM64_PREFETCH_PST  = 0x00000010U,
    ARM64_PREFETCH_L1   = 0x00000000U,
    ARM64_PREFETCH_L2   = 0x00000002U,
    ARM64_PREFETCH_L3   = 0x00000004U,
    ARM64_PREFETCH_KEEP = 0x00000000U,
    ARM64_PREFETCH_STRM = 0x00000001U,
}

enum uint _ARM64_MULT_INTRINS_SUPPORTED = 0x00000000U;

enum : uint
{
    ARM64_MAX_BREAKPOINTS = 0x00000008U,
    ARM64_MAX_WATCHPOINTS = 0x00000002U,
}

enum uint NONVOL_INT_NUMREG_ARM64 = 0x0000000bU;
enum uint NONVOL_FP_NUMREG_ARM64 = 0x00000008U;
enum uint BREAK_DEBUG_BASE = 0x00080000U;
enum uint ASSERT_BREAKPOINT = 0x00080003U;
enum uint SIZE_OF_80387_REGISTERS = 0x00000050U;
enum uint MAXIMUM_SUPPORTED_EXTENSION = 0x00000200U;

enum : uint
{
    EXCEPTION_NONCONTINUABLE  = 0x00000001U,
    EXCEPTION_UNWINDING       = 0x00000002U,
    EXCEPTION_EXIT_UNWIND     = 0x00000004U,
    EXCEPTION_STACK_INVALID   = 0x00000008U,
    EXCEPTION_NESTED_CALL     = 0x00000010U,
    EXCEPTION_TARGET_UNWIND   = 0x00000020U,
    EXCEPTION_COLLIDED_UNWIND = 0x00000040U,
}

enum uint EXCEPTION_SOFTWARE_ORIGINATE = 0x00000080U;
enum uint EXCEPTION_MAXIMUM_PARAMETERS = 0x0000000fU;
enum uint ACCESS_SYSTEM_SECURITY = 0x01000000U;
enum uint MAXIMUM_ALLOWED = 0x02000000U;
enum uint SID_REVISION = 0x00000001U;
enum uint SID_MAX_SUB_AUTHORITIES = 0x0000000fU;
enum uint SID_RECOMMENDED_SUB_AUTHORITIES = 0x00000001U;
enum uint SID_HASH_SIZE = 0x00000020U;

enum : int
{
    SECURITY_NULL_RID        = 0x00000000,
    SECURITY_WORLD_RID       = 0x00000000,
    SECURITY_LOCAL_RID       = 0x00000000,
    SECURITY_LOCAL_LOGON_RID = 0x00000001,
}

enum : int
{
    SECURITY_CREATOR_OWNER_RID        = 0x00000000,
    SECURITY_CREATOR_GROUP_RID        = 0x00000001,
    SECURITY_CREATOR_OWNER_SERVER_RID = 0x00000002,
    SECURITY_CREATOR_GROUP_SERVER_RID = 0x00000003,
    SECURITY_CREATOR_OWNER_RIGHTS_RID = 0x00000004,
}

enum : int
{
    SECURITY_DIALUP_RID      = 0x00000001,
    SECURITY_NETWORK_RID     = 0x00000002,
    SECURITY_BATCH_RID       = 0x00000003,
    SECURITY_INTERACTIVE_RID = 0x00000004,
}

enum : int
{
    SECURITY_LOGON_IDS_RID       = 0x00000005,
    SECURITY_LOGON_IDS_RID_COUNT = 0x00000003,
}

enum : int
{
    SECURITY_SERVICE_RID         = 0x00000006,
    SECURITY_ANONYMOUS_LOGON_RID = 0x00000007,
}

enum : int
{
    SECURITY_PROXY_RID                  = 0x00000008,
    SECURITY_ENTERPRISE_CONTROLLERS_RID = 0x00000009,
}

enum int SECURITY_SERVER_LOGON_RID = 0x00000009;
enum int SECURITY_PRINCIPAL_SELF_RID = 0x0000000a;
enum int SECURITY_AUTHENTICATED_USER_RID = 0x0000000b;
enum int SECURITY_RESTRICTED_CODE_RID = 0x0000000c;
enum int SECURITY_TERMINAL_SERVER_RID = 0x0000000d;
enum int SECURITY_REMOTE_LOGON_RID = 0x0000000e;
enum int SECURITY_THIS_ORGANIZATION_RID = 0x0000000f;

enum : int
{
    SECURITY_IUSER_RID         = 0x00000011,
    SECURITY_LOCAL_SYSTEM_RID  = 0x00000012,
    SECURITY_LOCAL_SERVICE_RID = 0x00000013,
}

enum int SECURITY_NETWORK_SERVICE_RID = 0x00000014;

enum : int
{
    SECURITY_NT_NON_UNIQUE                = 0x00000015,
    SECURITY_NT_NON_UNIQUE_SUB_AUTH_COUNT = 0x00000003,
}

enum int SECURITY_ENTERPRISE_READONLY_CONTROLLERS_RID = 0x00000016;
enum int SECURITY_BUILTIN_DOMAIN_RID = 0x00000020;
enum int SECURITY_WRITE_RESTRICTED_CODE_RID = 0x00000021;

enum : int
{
    SECURITY_PACKAGE_BASE_RID     = 0x00000040,
    SECURITY_PACKAGE_RID_COUNT    = 0x00000002,
    SECURITY_PACKAGE_NTLM_RID     = 0x0000000a,
    SECURITY_PACKAGE_SCHANNEL_RID = 0x0000000e,
    SECURITY_PACKAGE_DIGEST_RID   = 0x00000015,
}

enum : int
{
    SECURITY_CRED_TYPE_BASE_RID          = 0x00000041,
    SECURITY_CRED_TYPE_RID_COUNT         = 0x00000002,
    SECURITY_CRED_TYPE_THIS_ORG_CERT_RID = 0x00000001,
}

enum : int
{
    SECURITY_MIN_BASE_RID         = 0x00000050,
    SECURITY_SERVICE_ID_BASE_RID  = 0x00000050,
    SECURITY_SERVICE_ID_RID_COUNT = 0x00000006,
}

enum int SECURITY_RESERVED_ID_BASE_RID = 0x00000051;

enum : int
{
    SECURITY_APPPOOL_ID_BASE_RID  = 0x00000052,
    SECURITY_APPPOOL_ID_RID_COUNT = 0x00000006,
}

enum : int
{
    SECURITY_VIRTUALSERVER_ID_BASE_RID  = 0x00000053,
    SECURITY_VIRTUALSERVER_ID_RID_COUNT = 0x00000006,
}

enum : int
{
    SECURITY_USERMODEDRIVERHOST_ID_BASE_RID  = 0x00000054,
    SECURITY_USERMODEDRIVERHOST_ID_RID_COUNT = 0x00000006,
}

enum : int
{
    SECURITY_CLOUD_INFRASTRUCTURE_SERVICES_ID_BASE_RID  = 0x00000055,
    SECURITY_CLOUD_INFRASTRUCTURE_SERVICES_ID_RID_COUNT = 0x00000006,
}

enum : int
{
    SECURITY_WMIHOST_ID_BASE_RID  = 0x00000056,
    SECURITY_WMIHOST_ID_RID_COUNT = 0x00000006,
}

enum int SECURITY_TASK_ID_BASE_RID = 0x00000057;
enum int SECURITY_NFS_ID_BASE_RID = 0x00000058;
enum int SECURITY_COM_ID_BASE_RID = 0x00000059;
enum int SECURITY_WINDOW_MANAGER_BASE_RID = 0x0000005a;
enum int SECURITY_RDV_GFX_BASE_RID = 0x0000005b;

enum : int
{
    SECURITY_DASHOST_ID_BASE_RID  = 0x0000005c,
    SECURITY_DASHOST_ID_RID_COUNT = 0x00000006,
}

enum : int
{
    SECURITY_USERMANAGER_ID_BASE_RID  = 0x0000005d,
    SECURITY_USERMANAGER_ID_RID_COUNT = 0x00000006,
}

enum : int
{
    SECURITY_WINRM_ID_BASE_RID  = 0x0000005e,
    SECURITY_WINRM_ID_RID_COUNT = 0x00000006,
}

enum int SECURITY_CCG_ID_BASE_RID = 0x0000005f;

enum : int
{
    SECURITY_UMFD_BASE_RID               = 0x00000060,
    SECURITY_UNIQUIFIED_SERVICE_BASE_RID = 0x00000061,
}

enum int SECURITY_VIRTUALACCOUNT_ID_RID_COUNT = 0x00000006;
enum int SECURITY_EDGE_CLOUD_INFRASTRUCTURE_SERVICE_ID_BASE_RID = 0x00000062;

enum : int
{
    SECURITY_RESTRICTED_SERVICES_BASE_RID  = 0x00000063,
    SECURITY_RESTRICTED_SERVICES_RID_COUNT = 0x00000006,
}

enum : int
{
    SECURITY_MAX_BASE_RID        = 0x0000006f,
    SECURITY_MAX_ALWAYS_FILTERED = 0x000003e7,
}

enum int SECURITY_MIN_NEVER_FILTERED = 0x000003e8;
enum int SECURITY_OTHER_ORGANIZATION_RID = 0x000003e8;
enum int SECURITY_WINDOWSMOBILE_ID_BASE_RID = 0x00000070;

enum : uint
{
    SECURITY_INSTALLER_GROUP_CAPABILITY_BASE      = 0x00000020U,
    SECURITY_INSTALLER_GROUP_CAPABILITY_RID_COUNT = 0x00000009U,
    SECURITY_INSTALLER_CAPABILITY_RID_COUNT       = 0x0000000aU,
}

enum : int
{
    SECURITY_LOCAL_ACCOUNT_RID           = 0x00000071,
    SECURITY_LOCAL_ACCOUNT_AND_ADMIN_RID = 0x00000072,
}

enum : int
{
    DOMAIN_GROUP_RID_AUTHORIZATION_DATA_IS_COMPOUNDED   = 0x000001f0,
    DOMAIN_GROUP_RID_AUTHORIZATION_DATA_CONTAINS_CLAIMS = 0x000001f1,
}

enum int DOMAIN_GROUP_RID_ENTERPRISE_READONLY_DOMAIN_CONTROLLERS = 0x000001f2;
enum int FOREST_USER_RID_MAX = 0x000001f3;

enum : int
{
    DOMAIN_USER_RID_ADMIN           = 0x000001f4,
    DOMAIN_USER_RID_GUEST           = 0x000001f5,
    DOMAIN_USER_RID_KRBTGT          = 0x000001f6,
    DOMAIN_USER_RID_DEFAULT_ACCOUNT = 0x000001f7,
    DOMAIN_USER_RID_WDAG_ACCOUNT    = 0x000001f8,
    DOMAIN_USER_RID_MAX             = 0x000003e7,
}

enum : int
{
    DOMAIN_GROUP_RID_ADMINS                = 0x00000200,
    DOMAIN_GROUP_RID_USERS                 = 0x00000201,
    DOMAIN_GROUP_RID_GUESTS                = 0x00000202,
    DOMAIN_GROUP_RID_COMPUTERS             = 0x00000203,
    DOMAIN_GROUP_RID_CONTROLLERS           = 0x00000204,
    DOMAIN_GROUP_RID_CERT_ADMINS           = 0x00000205,
    DOMAIN_GROUP_RID_SCHEMA_ADMINS         = 0x00000206,
    DOMAIN_GROUP_RID_ENTERPRISE_ADMINS     = 0x00000207,
    DOMAIN_GROUP_RID_POLICY_ADMINS         = 0x00000208,
    DOMAIN_GROUP_RID_READONLY_CONTROLLERS  = 0x00000209,
    DOMAIN_GROUP_RID_CLONEABLE_CONTROLLERS = 0x0000020a,
    DOMAIN_GROUP_RID_CDC_RESERVED          = 0x0000020c,
    DOMAIN_GROUP_RID_PROTECTED_USERS       = 0x0000020d,
    DOMAIN_GROUP_RID_KEY_ADMINS            = 0x0000020e,
    DOMAIN_GROUP_RID_ENTERPRISE_KEY_ADMINS = 0x0000020f,
    DOMAIN_GROUP_RID_FOREST_TRUSTS         = 0x00000210,
    DOMAIN_GROUP_RID_EXTERNAL_TRUSTS       = 0x00000211,
}

enum : int
{
    DOMAIN_ALIAS_RID_ADMINS                         = 0x00000220,
    DOMAIN_ALIAS_RID_USERS                          = 0x00000221,
    DOMAIN_ALIAS_RID_GUESTS                         = 0x00000222,
    DOMAIN_ALIAS_RID_POWER_USERS                    = 0x00000223,
    DOMAIN_ALIAS_RID_ACCOUNT_OPS                    = 0x00000224,
    DOMAIN_ALIAS_RID_SYSTEM_OPS                     = 0x00000225,
    DOMAIN_ALIAS_RID_PRINT_OPS                      = 0x00000226,
    DOMAIN_ALIAS_RID_BACKUP_OPS                     = 0x00000227,
    DOMAIN_ALIAS_RID_REPLICATOR                     = 0x00000228,
    DOMAIN_ALIAS_RID_RAS_SERVERS                    = 0x00000229,
    DOMAIN_ALIAS_RID_PREW2KCOMPACCESS               = 0x0000022a,
    DOMAIN_ALIAS_RID_REMOTE_DESKTOP_USERS           = 0x0000022b,
    DOMAIN_ALIAS_RID_NETWORK_CONFIGURATION_OPS      = 0x0000022c,
    DOMAIN_ALIAS_RID_INCOMING_FOREST_TRUST_BUILDERS = 0x0000022d,
}

enum : int
{
    DOMAIN_ALIAS_RID_MONITORING_USERS           = 0x0000022e,
    DOMAIN_ALIAS_RID_LOGGING_USERS              = 0x0000022f,
    DOMAIN_ALIAS_RID_AUTHORIZATIONACCESS        = 0x00000230,
    DOMAIN_ALIAS_RID_TS_LICENSE_SERVERS         = 0x00000231,
    DOMAIN_ALIAS_RID_DCOM_USERS                 = 0x00000232,
    DOMAIN_ALIAS_RID_IUSERS                     = 0x00000238,
    DOMAIN_ALIAS_RID_CRYPTO_OPERATORS           = 0x00000239,
    DOMAIN_ALIAS_RID_CACHEABLE_PRINCIPALS_GROUP = 0x0000023b,
}

enum int DOMAIN_ALIAS_RID_NON_CACHEABLE_PRINCIPALS_GROUP = 0x0000023c;

enum : int
{
    DOMAIN_ALIAS_RID_EVENT_LOG_READERS_GROUP       = 0x0000023d,
    DOMAIN_ALIAS_RID_CERTSVC_DCOM_ACCESS_GROUP     = 0x0000023e,
    DOMAIN_ALIAS_RID_RDS_REMOTE_ACCESS_SERVERS     = 0x0000023f,
    DOMAIN_ALIAS_RID_RDS_ENDPOINT_SERVERS          = 0x00000240,
    DOMAIN_ALIAS_RID_RDS_MANAGEMENT_SERVERS        = 0x00000241,
    DOMAIN_ALIAS_RID_HYPER_V_ADMINS                = 0x00000242,
    DOMAIN_ALIAS_RID_ACCESS_CONTROL_ASSISTANCE_OPS = 0x00000243,
}

enum : int
{
    DOMAIN_ALIAS_RID_REMOTE_MANAGEMENT_USERS      = 0x00000244,
    DOMAIN_ALIAS_RID_DEFAULT_ACCOUNT              = 0x00000245,
    DOMAIN_ALIAS_RID_STORAGE_REPLICA_ADMINS       = 0x00000246,
    DOMAIN_ALIAS_RID_DEVICE_OWNERS                = 0x00000247,
    DOMAIN_ALIAS_RID_USER_MODE_HARDWARE_OPERATORS = 0x00000248,
}

enum int DOMAIN_ALIAS_RID_OPENSSH_USERS = 0x00000249;
enum int SECURITY_APP_PACKAGE_BASE_RID = 0x00000002;
enum int SECURITY_BUILTIN_APP_PACKAGE_RID_COUNT = 0x00000002;
enum int SECURITY_APP_PACKAGE_RID_COUNT = 0x00000008;

enum : int
{
    SECURITY_CAPABILITY_BASE_RID     = 0x00000003,
    SECURITY_CAPABILITY_APP_RID      = 0x00000400,
    SECURITY_CAPABILITY_APP_SILO_RID = 0x00010000,
}

enum int SECURITY_BUILTIN_CAPABILITY_RID_COUNT = 0x00000002;
enum int SECURITY_CAPABILITY_RID_COUNT = 0x00000005;
enum int SECURITY_PARENT_PACKAGE_RID_COUNT = 0x00000008;
enum int SECURITY_CHILD_PACKAGE_RID_COUNT = 0x0000000c;

enum : int
{
    SECURITY_BUILTIN_PACKAGE_ANY_PACKAGE            = 0x00000001,
    SECURITY_BUILTIN_PACKAGE_ANY_RESTRICTED_PACKAGE = 0x00000002,
}

enum : int
{
    SECURITY_CAPABILITY_INTERNET_CLIENT               = 0x00000001,
    SECURITY_CAPABILITY_INTERNET_CLIENT_SERVER        = 0x00000002,
    SECURITY_CAPABILITY_PRIVATE_NETWORK_CLIENT_SERVER = 0x00000003,
    SECURITY_CAPABILITY_PICTURES_LIBRARY              = 0x00000004,
    SECURITY_CAPABILITY_VIDEOS_LIBRARY                = 0x00000005,
    SECURITY_CAPABILITY_MUSIC_LIBRARY                 = 0x00000006,
    SECURITY_CAPABILITY_DOCUMENTS_LIBRARY             = 0x00000007,
    SECURITY_CAPABILITY_ENTERPRISE_AUTHENTICATION     = 0x00000008,
    SECURITY_CAPABILITY_SHARED_USER_CERTIFICATES      = 0x00000009,
    SECURITY_CAPABILITY_REMOVABLE_STORAGE             = 0x0000000a,
    SECURITY_CAPABILITY_APPOINTMENTS                  = 0x0000000b,
    SECURITY_CAPABILITY_CONTACTS                      = 0x0000000c,
    SECURITY_CAPABILITY_INTERNET_EXPLORER             = 0x00001000,
}

enum : int
{
    SECURITY_MANDATORY_UNTRUSTED_RID = 0x00000000,
    SECURITY_MANDATORY_LOW_RID       = 0x00001000,
    SECURITY_MANDATORY_MEDIUM_RID    = 0x00002000,
}

enum uint SECURITY_MANDATORY_MEDIUM_PLUS_RID = 0x00002100U;

enum : int
{
    SECURITY_MANDATORY_HIGH_RID              = 0x00003000,
    SECURITY_MANDATORY_SYSTEM_RID            = 0x00004000,
    SECURITY_MANDATORY_PROTECTED_PROCESS_RID = 0x00005000,
}

enum uint SECURITY_MANDATORY_MEDIUM_PLUS_CREDUI_RID = 0x0000200aU;
enum int SECURITY_MANDATORY_MAXIMUM_USER_RID = 0x00004000;

enum : int
{
    SECURITY_AUTHENTICATION_AUTHORITY_RID_COUNT          = 0x00000001,
    SECURITY_AUTHENTICATION_AUTHORITY_ASSERTED_RID       = 0x00000001,
    SECURITY_AUTHENTICATION_SERVICE_ASSERTED_RID         = 0x00000002,
    SECURITY_AUTHENTICATION_FRESH_KEY_AUTH_RID           = 0x00000003,
    SECURITY_AUTHENTICATION_KEY_TRUST_RID                = 0x00000004,
    SECURITY_AUTHENTICATION_KEY_PROPERTY_MFA_RID         = 0x00000005,
    SECURITY_AUTHENTICATION_KEY_PROPERTY_ATTESTATION_RID = 0x00000006,
}

enum : int
{
    SECURITY_PROCESS_TRUST_AUTHORITY_RID_COUNT         = 0x00000002,
    SECURITY_PROCESS_PROTECTION_TYPE_FULL_RID          = 0x00000400,
    SECURITY_PROCESS_PROTECTION_TYPE_LITE_RID          = 0x00000200,
    SECURITY_PROCESS_PROTECTION_TYPE_NONE_RID          = 0x00000000,
    SECURITY_PROCESS_PROTECTION_LEVEL_WINTCB_RID       = 0x00002000,
    SECURITY_PROCESS_PROTECTION_LEVEL_WINDOWS_RID      = 0x00001000,
    SECURITY_PROCESS_PROTECTION_LEVEL_APP_RID          = 0x00000800,
    SECURITY_PROCESS_PROTECTION_LEVEL_ANTIMALWARE_RID  = 0x00000600,
    SECURITY_PROCESS_PROTECTION_LEVEL_AUTHENTICODE_RID = 0x00000400,
    SECURITY_PROCESS_PROTECTION_LEVEL_NONE_RID         = 0x00000000,
}

enum : uint
{
    SECURITY_TRUSTED_INSTALLER_RID1 = 0x38fb89b5U,
    SECURITY_TRUSTED_INSTALLER_RID2 = 0xcbc28419U,
    SECURITY_TRUSTED_INSTALLER_RID3 = 0x6d236c5cU,
    SECURITY_TRUSTED_INSTALLER_RID4 = 0x6e770057U,
    SECURITY_TRUSTED_INSTALLER_RID5 = 0x876402c0U,
}

enum : int
{
    SE_GROUP_MANDATORY          = 0x00000001,
    SE_GROUP_ENABLED_BY_DEFAULT = 0x00000002,
    SE_GROUP_ENABLED            = 0x00000004,
    SE_GROUP_OWNER              = 0x00000008,
    SE_GROUP_USE_FOR_DENY_ONLY  = 0x00000010,
}

enum : int
{
    SE_GROUP_INTEGRITY         = 0x00000020,
    SE_GROUP_INTEGRITY_ENABLED = 0x00000040,
}

enum : int
{
    SE_GROUP_LOGON_ID = 0xc0000000,
    SE_GROUP_RESOURCE = 0x20000000,
}

enum : uint
{
    ACL_REVISION1 = 0x00000001U,
    ACL_REVISION2 = 0x00000002U,
    ACL_REVISION3 = 0x00000003U,
    ACL_REVISION4 = 0x00000004U,
}

enum uint MAX_ACL_REVISION = 0x00000004U;
enum uint ACCESS_MIN_MS_ACE_TYPE = 0x00000000U;
enum uint ACCESS_ALLOWED_ACE_TYPE = 0x00000000U;
enum uint ACCESS_DENIED_ACE_TYPE = 0x00000001U;
enum uint SYSTEM_AUDIT_ACE_TYPE = 0x00000002U;
enum uint SYSTEM_ALARM_ACE_TYPE = 0x00000003U;
enum uint ACCESS_MAX_MS_V2_ACE_TYPE = 0x00000003U;
enum uint ACCESS_ALLOWED_COMPOUND_ACE_TYPE = 0x00000004U;
enum uint ACCESS_MAX_MS_V3_ACE_TYPE = 0x00000004U;
enum uint ACCESS_MIN_MS_OBJECT_ACE_TYPE = 0x00000005U;
enum uint ACCESS_ALLOWED_OBJECT_ACE_TYPE = 0x00000005U;
enum uint ACCESS_DENIED_OBJECT_ACE_TYPE = 0x00000006U;
enum uint SYSTEM_AUDIT_OBJECT_ACE_TYPE = 0x00000007U;
enum uint SYSTEM_ALARM_OBJECT_ACE_TYPE = 0x00000008U;

enum : uint
{
    ACCESS_MAX_MS_OBJECT_ACE_TYPE = 0x00000008U,
    ACCESS_MAX_MS_V4_ACE_TYPE     = 0x00000008U,
    ACCESS_MAX_MS_ACE_TYPE        = 0x00000008U,
}

enum uint ACCESS_ALLOWED_CALLBACK_ACE_TYPE = 0x00000009U;
enum uint ACCESS_DENIED_CALLBACK_ACE_TYPE = 0x0000000aU;
enum uint ACCESS_ALLOWED_CALLBACK_OBJECT_ACE_TYPE = 0x0000000bU;
enum uint ACCESS_DENIED_CALLBACK_OBJECT_ACE_TYPE = 0x0000000cU;
enum uint SYSTEM_AUDIT_CALLBACK_ACE_TYPE = 0x0000000dU;
enum uint SYSTEM_ALARM_CALLBACK_ACE_TYPE = 0x0000000eU;
enum uint SYSTEM_AUDIT_CALLBACK_OBJECT_ACE_TYPE = 0x0000000fU;
enum uint SYSTEM_ALARM_CALLBACK_OBJECT_ACE_TYPE = 0x00000010U;
enum uint SYSTEM_MANDATORY_LABEL_ACE_TYPE = 0x00000011U;
enum uint SYSTEM_RESOURCE_ATTRIBUTE_ACE_TYPE = 0x00000012U;
enum uint SYSTEM_SCOPED_POLICY_ID_ACE_TYPE = 0x00000013U;
enum uint SYSTEM_PROCESS_TRUST_LABEL_ACE_TYPE = 0x00000014U;
enum uint SYSTEM_ACCESS_FILTER_ACE_TYPE = 0x00000015U;
enum uint ACCESS_MAX_MS_V5_ACE_TYPE = 0x00000015U;
enum uint VALID_INHERIT_FLAGS = 0x0000001fU;
enum uint CRITICAL_ACE_FLAG = 0x00000020U;
enum uint TRUST_PROTECTED_FILTER_ACE_FLAG = 0x00000040U;

enum : uint
{
    SYSTEM_MANDATORY_LABEL_NO_WRITE_UP   = 0x00000001U,
    SYSTEM_MANDATORY_LABEL_NO_READ_UP    = 0x00000002U,
    SYSTEM_MANDATORY_LABEL_NO_EXECUTE_UP = 0x00000004U,
}

enum : uint
{
    SYSTEM_PROCESS_TRUST_LABEL_VALID_MASK  = 0x00ffffffU,
    SYSTEM_PROCESS_TRUST_NOCONSTRAINT_MASK = 0xffffffffU,
}

enum : uint
{
    SYSTEM_ACCESS_FILTER_VALID_MASK        = 0x00ffffffU,
    SYSTEM_ACCESS_FILTER_NOCONSTRAINT_MASK = 0xffffffffU,
}

enum : uint
{
    SECURITY_DESCRIPTOR_REVISION  = 0x00000001U,
    SECURITY_DESCRIPTOR_REVISION1 = 0x00000001U,
}

enum uint ACCESS_OBJECT_GUID = 0x00000000U;

enum : uint
{
    ACCESS_PROPERTY_SET_GUID = 0x00000001U,
    ACCESS_PROPERTY_GUID     = 0x00000002U,
}

enum uint ACCESS_MAX_LEVEL = 0x00000004U;
enum uint AUDIT_ALLOW_NO_PRIVILEGE = 0x00000001U;

enum : const(wchar)*
{
    // Native encoding: ansi
    ACCESS_DS_SOURCE_A           = "DS",
    ACCESS_DS_SOURCE_W           = "DS",
    // Native encoding: ansi
    ACCESS_DS_OBJECT_TYPE_NAME_A = "Directory Service Object",
    ACCESS_DS_OBJECT_TYPE_NAME_W = "Directory Service Object",
}

enum uint PRIVILEGE_SET_ALL_NECESSARY = 0x00000001U;

enum : uint
{
    ACCESS_REASON_TYPE_MASK    = 0x00ff0000U,
    ACCESS_REASON_DATA_MASK    = 0x0000ffffU,
    ACCESS_REASON_STAGING_MASK = 0x80000000U,
    ACCESS_REASON_EXDATA_MASK  = 0x7f000000U,
}

enum : uint
{
    SE_SECURITY_DESCRIPTOR_FLAG_NO_OWNER_ACE         = 0x00000001U,
    SE_SECURITY_DESCRIPTOR_FLAG_NO_LABEL_ACE         = 0x00000002U,
    SE_SECURITY_DESCRIPTOR_FLAG_NO_ACCESS_FILTER_ACE = 0x00000004U,
    SE_SECURITY_DESCRIPTOR_VALID_FLAGS               = 0x00000007U,
}

enum uint SE_ACCESS_CHECK_FLAG_NO_LEARNING_MODE_LOGGING = 0x00000008U;
enum uint SE_ACCESS_CHECK_VALID_FLAGS = 0x00000008U;
enum const(wchar)* SE_ACTIVATE_AS_USER_CAPABILITY = "activateAsUser";
enum const(wchar)* SE_CONSTRAINED_IMPERSONATION_CAPABILITY = "constrainedImpersonation";
enum const(wchar)* SE_SESSION_IMPERSONATION_CAPABILITY = "sessionImpersonation";
enum const(wchar)* SE_MUMA_CAPABILITY = "muma";
enum const(wchar)* SE_DEVELOPMENT_MODE_NETWORK_CAPABILITY = "developmentModeNetwork";
enum const(wchar)* SE_LEARNING_MODE_LOGGING_CAPABILITY = "learningModeLogging";
enum const(wchar)* SE_PERMISSIVE_LEARNING_MODE_CAPABILITY = "permissiveLearningMode";
enum const(wchar)* SE_APP_SILO_VOLUME_ROOT_MINIMAL_CAPABILITY = "isolatedWin32-volumeRootMinimal";
enum const(wchar)* SE_APP_SILO_PROFILES_ROOT_MINIMAL_CAPABILITY = "isolatedWin32-profilesRootMinimal";
enum const(wchar)* SE_APP_SILO_USER_PROFILE_MINIMAL_CAPABILITY = "isolatedWin32-userProfileMinimal";
enum const(wchar)* SE_APP_SILO_PROMPT_FOR_ACCESS_CAPABILITY = "isolatedWin32-promptForAccess";
enum const(wchar)* SE_APP_SILO_ACCESS_TO_PUBLISHER_DIRECTORY_CAPABILITY = "isolatedWin32-accessToPublisherDirectory";
enum const(wchar)* SE_APP_SILO_PRINT_CAPABILITY = "isolatedWin32-print";
enum uint POLICY_AUDIT_SUBCATEGORY_COUNT = 0x0000003cU;
enum uint TOKEN_SOURCE_LENGTH = 0x00000008U;

enum : uint
{
    CLAIM_SECURITY_ATTRIBUTE_TYPE_INVALID            = 0x00000000U,
    CLAIM_SECURITY_ATTRIBUTE_CUSTOM_FLAGS            = 0xffff0000U,
    CLAIM_SECURITY_ATTRIBUTES_INFORMATION_VERSION_V1 = 0x00000001U,
    CLAIM_SECURITY_ATTRIBUTES_INFORMATION_VERSION    = 0x00000001U,
}

enum int PROCESS_TRUST_LABEL_SECURITY_INFORMATION = 0x00000080;
enum int ACCESS_FILTER_SECURITY_INFORMATION = 0x00000100;

enum : uint
{
    SE_SIGNING_LEVEL_UNCHECKED       = 0x00000000U,
    SE_SIGNING_LEVEL_UNSIGNED        = 0x00000001U,
    SE_SIGNING_LEVEL_ENTERPRISE      = 0x00000002U,
    SE_SIGNING_LEVEL_CUSTOM_1        = 0x00000003U,
    SE_SIGNING_LEVEL_DEVELOPER       = 0x00000003U,
    SE_SIGNING_LEVEL_AUTHENTICODE    = 0x00000004U,
    SE_SIGNING_LEVEL_CUSTOM_2        = 0x00000005U,
    SE_SIGNING_LEVEL_STORE           = 0x00000006U,
    SE_SIGNING_LEVEL_CUSTOM_3        = 0x00000007U,
    SE_SIGNING_LEVEL_ANTIMALWARE     = 0x00000007U,
    SE_SIGNING_LEVEL_MICROSOFT       = 0x00000008U,
    SE_SIGNING_LEVEL_CUSTOM_4        = 0x00000009U,
    SE_SIGNING_LEVEL_CUSTOM_5        = 0x0000000aU,
    SE_SIGNING_LEVEL_DYNAMIC_CODEGEN = 0x0000000bU,
    SE_SIGNING_LEVEL_WINDOWS         = 0x0000000cU,
    SE_SIGNING_LEVEL_CUSTOM_7        = 0x0000000dU,
    SE_SIGNING_LEVEL_WINDOWS_TCB     = 0x0000000eU,
    SE_SIGNING_LEVEL_CUSTOM_6        = 0x0000000fU,
}

enum : uint
{
    JOB_OBJECT_ASSIGN_PROCESS          = 0x00000001U,
    JOB_OBJECT_SET_ATTRIBUTES          = 0x00000002U,
    JOB_OBJECT_QUERY                   = 0x00000004U,
    JOB_OBJECT_TERMINATE               = 0x00000008U,
    JOB_OBJECT_SET_SECURITY_ATTRIBUTES = 0x00000010U,
}

enum uint JOB_OBJECT_IMPERSONATE = 0x00000020U;
enum uint FLS_MAXIMUM_AVAILABLE = 0x00000ff0U;
enum uint TLS_MINIMUM_AVAILABLE = 0x00000040U;
enum uint THREAD_DYNAMIC_CODE_ALLOW = 0x00000001U;

enum : uint
{
    THREAD_BASE_PRIORITY_LOWRT = 0x0000000fU,
    THREAD_BASE_PRIORITY_MAX   = 0x00000002U,
}

enum : int
{
    THREAD_BASE_PRIORITY_MIN  = 0xfffffffe,
    THREAD_BASE_PRIORITY_IDLE = 0xfffffff1,
}

enum : uint
{
    COMPONENT_KTM         = 0x00000001U,
    COMPONENT_VALID_FLAGS = 0x00000001U,
}

enum uint MEMORY_PRIORITY_LOWEST = 0x00000000U;

enum : uint
{
    DYNAMIC_EH_CONTINUATION_TARGET_ADD       = 0x00000001U,
    DYNAMIC_EH_CONTINUATION_TARGET_PROCESSED = 0x00000002U,
}

enum : uint
{
    DYNAMIC_ENFORCED_ADDRESS_RANGE_ADD       = 0x00000001U,
    DYNAMIC_ENFORCED_ADDRESS_RANGE_PROCESSED = 0x00000002U,
}

enum uint QUOTA_LIMITS_USE_DEFAULT_LIMITS = 0x00000010U;
enum uint MAX_HW_COUNTERS = 0x00000010U;
enum uint THREAD_PROFILING_FLAG_DISPATCH = 0x00000001U;
enum uint JOB_OBJECT_NET_RATE_CONTROL_MAX_DSCP_TAG = 0x00000040U;

enum : uint
{
    JOB_OBJECT_MSG_END_OF_JOB_TIME                 = 0x00000001U,
    JOB_OBJECT_MSG_END_OF_PROCESS_TIME             = 0x00000002U,
    JOB_OBJECT_MSG_ACTIVE_PROCESS_LIMIT            = 0x00000003U,
    JOB_OBJECT_MSG_ACTIVE_PROCESS_ZERO             = 0x00000004U,
    JOB_OBJECT_MSG_NEW_PROCESS                     = 0x00000006U,
    JOB_OBJECT_MSG_EXIT_PROCESS                    = 0x00000007U,
    JOB_OBJECT_MSG_ABNORMAL_EXIT_PROCESS           = 0x00000008U,
    JOB_OBJECT_MSG_PROCESS_MEMORY_LIMIT            = 0x00000009U,
    JOB_OBJECT_MSG_JOB_MEMORY_LIMIT                = 0x0000000aU,
    JOB_OBJECT_MSG_NOTIFICATION_LIMIT              = 0x0000000bU,
    JOB_OBJECT_MSG_JOB_CYCLE_TIME_LIMIT            = 0x0000000cU,
    JOB_OBJECT_MSG_SILO_TERMINATED                 = 0x0000000dU,
    JOB_OBJECT_MSG_MINIMUM                         = 0x00000001U,
    JOB_OBJECT_MSG_MAXIMUM                         = 0x0000000dU,
    JOB_OBJECT_UILIMIT_IME                         = 0x00000100U,
    JOB_OBJECT_UILIMIT_INJECTION                   = 0x00000200U,
    JOB_OBJECT_UILIMIT_ALL                         = 0x000003ffU,
    JOB_OBJECT_UI_VALID_FLAGS                      = 0x000003ffU,
    JOB_OBJECT_CPU_RATE_CONTROL_PER_PROCESSOR_CAPS = 0x00000020U,
}

enum : uint
{
    MEMORY_PARTITION_QUERY_ACCESS  = 0x00000001U,
    MEMORY_PARTITION_MODIFY_ACCESS = 0x00000002U,
}

enum uint MUTANT_QUERY_STATE = 0x00000001U;

enum : uint
{
    TIME_ZONE_ID_UNKNOWN  = 0x00000000U,
    TIME_ZONE_ID_STANDARD = 0x00000001U,
    TIME_ZONE_ID_DAYLIGHT = 0x00000002U,
}

enum uint LTP_PC_SMT = 0x00000001U;
enum uint CACHE_FULLY_ASSOCIATIVE = 0x000000ffU;

enum : uint
{
    PROCESSOR_INTEL_386     = 0x00000182U,
    PROCESSOR_INTEL_486     = 0x000001e6U,
    PROCESSOR_INTEL_PENTIUM = 0x0000024aU,
    PROCESSOR_INTEL_IA64    = 0x00000898U,
    PROCESSOR_AMD_X8664     = 0x000021d8U,
    PROCESSOR_MIPS_R4000    = 0x00000fa0U,
    PROCESSOR_ALPHA_21064   = 0x00005248U,
    PROCESSOR_PPC_601       = 0x00000259U,
    PROCESSOR_PPC_603       = 0x0000025bU,
    PROCESSOR_PPC_604       = 0x0000025cU,
    PROCESSOR_PPC_620       = 0x0000026cU,
    PROCESSOR_HITACHI_SH3   = 0x00002713U,
    PROCESSOR_HITACHI_SH3E  = 0x00002714U,
    PROCESSOR_HITACHI_SH4   = 0x00002715U,
    PROCESSOR_MOTOROLA_821  = 0x00000335U,
    PROCESSOR_SHx_SH3       = 0x00000067U,
    PROCESSOR_SHx_SH4       = 0x00000068U,
    PROCESSOR_STRONGARM     = 0x00000a11U,
    PROCESSOR_ARM720        = 0x00000720U,
    PROCESSOR_ARM820        = 0x00000820U,
    PROCESSOR_ARM920        = 0x00000920U,
    PROCESSOR_ARM_7TDMI     = 0x00011171U,
    PROCESSOR_OPTIL         = 0x0000494fU,
}

enum : uint
{
    XSTATE_LEGACY_FLOATING_POINT = 0x00000000U,
    XSTATE_LEGACY_SSE            = 0x00000001U,
    XSTATE_GSSE                  = 0x00000002U,
    XSTATE_AVX                   = 0x00000002U,
    XSTATE_MPX_BNDREGS           = 0x00000003U,
    XSTATE_MPX_BNDCSR            = 0x00000004U,
    XSTATE_AVX512_KMASK          = 0x00000005U,
    XSTATE_AVX512_ZMM_H          = 0x00000006U,
    XSTATE_AVX512_ZMM            = 0x00000007U,
    XSTATE_IPT                   = 0x00000008U,
    XSTATE_PASID                 = 0x0000000aU,
    XSTATE_CET_U                 = 0x0000000bU,
    XSTATE_CET_S                 = 0x0000000cU,
    XSTATE_AMX_TILE_CONFIG       = 0x00000011U,
    XSTATE_AMX_TILE_DATA         = 0x00000012U,
}

enum uint XSTATE_LWP = 0x0000003eU;
enum uint MAXIMUM_XSTATE_FEATURES = 0x00000040U;

enum : uint
{
    XSTATE_ARM64_SVE                = 0x00000002U,
    XSTATE_FIRST_NON_LEGACY_FEATURE = 0x00000002U,
}

enum uint XSTATE_COMPACTION_ENABLE = 0x0000003fU;

enum : uint
{
    XSTATE_ALIGN_BIT                 = 0x00000001U,
    XSTATE_XFD_BIT                   = 0x00000002U,
    XSTATE_CONTROLFLAG_XSAVEOPT_MASK = 0x00000001U,
    XSTATE_CONTROLFLAG_XSAVEC_MASK   = 0x00000002U,
    XSTATE_CONTROLFLAG_XFD_MASK      = 0x00000004U,
}

enum : uint
{
    RUNTIME_REPORT_PACKAGE_MAGIC           = 0x52545250U,
    RUNTIME_REPORT_PACKAGE_VERSION_CURRENT = 0x00000001U,
}

enum : uint
{
    RUNTIME_REPORT_NONCE_SIZE                             = 0x00000020U,
    RUNTIME_REPORT_DIGEST_MAX_SIZE                        = 0x00000040U,
    RUNTIME_REPORT_SIGNATURE_SCHEME_SHA512_RSA_PSS_SHA512 = 0x00000001U,
}

enum : uint
{
    DRIVER_REPORT_DIGEST_MAX_SIZE = 0x00000040U,
    DRIVER_REPORT_NAME_MAX_LENGTH = 0x00000020U,
}

enum : uint
{
    CFG_CALL_TARGET_VALID                              = 0x00000001U,
    CFG_CALL_TARGET_PROCESSED                          = 0x00000002U,
    CFG_CALL_TARGET_CONVERT_EXPORT_SUPPRESSED_TO_VALID = 0x00000004U,
}

enum : uint
{
    CFG_CALL_TARGET_VALID_XFG          = 0x00000008U,
    CFG_CALL_TARGET_CONVERT_XFG_TO_CFG = 0x00000010U,
}

enum uint SESSION_QUERY_ACCESS = 0x00000001U;
enum uint SESSION_MODIFY_ACCESS = 0x00000002U;
enum uint MEM_TOP_DOWN = 0x00100000U;
enum uint MEM_WRITE_WATCH = 0x00200000U;
enum uint MEM_PHYSICAL = 0x00400000U;
enum uint MEM_ROTATE = 0x00800000U;
enum uint MEM_DIFFERENT_IMAGE_BASE_OK = 0x00800000U;
enum uint MEM_4MB_PAGES = 0x80000000U;
enum uint MEM_COALESCE_PLACEHOLDERS = 0x00000001U;

enum : uint
{
    MEM_EXTENDED_PARAMETER_GRAPHICS            = 0x00000001U,
    MEM_EXTENDED_PARAMETER_NONPAGED            = 0x00000002U,
    MEM_EXTENDED_PARAMETER_ZERO_PAGES_OPTIONAL = 0x00000004U,
    MEM_EXTENDED_PARAMETER_NONPAGED_LARGE      = 0x00000008U,
    MEM_EXTENDED_PARAMETER_NONPAGED_HUGE       = 0x00000010U,
    MEM_EXTENDED_PARAMETER_SOFT_FAULT_PAGES    = 0x00000020U,
    MEM_EXTENDED_PARAMETER_EC_CODE             = 0x00000040U,
    MEM_EXTENDED_PARAMETER_TYPE_BITS           = 0x00000008U,
}

enum uint SEC_HUGE_PAGES = 0x00020000U;
enum uint WRITE_WATCH_FLAG_RESET = 0x00000001U;
enum uint VM_PREFETCH_TO_WORKING_SET = 0x00000001U;

enum : uint
{
    ENCLAVE_TYPE_SGX       = 0x00000001U,
    ENCLAVE_TYPE_SGX2      = 0x00000002U,
    ENCLAVE_TYPE_VBS       = 0x00000010U,
    ENCLAVE_VBS_FLAG_DEBUG = 0x00000001U,
}

enum uint ENCLAVE_TYPE_VBS_BASIC = 0x00000011U;

enum : uint
{
    VBS_BASIC_PAGE_MEASURED_DATA     = 0x00000001U,
    VBS_BASIC_PAGE_UNMEASURED_DATA   = 0x00000002U,
    VBS_BASIC_PAGE_ZERO_FILL         = 0x00000003U,
    VBS_BASIC_PAGE_THREAD_DESCRIPTOR = 0x00000004U,
    VBS_BASIC_PAGE_SYSTEM_CALL       = 0x00000005U,
}

enum uint DEDICATED_MEMORY_CACHE_ELIGIBLE = 0x00000001U;

enum : uint
{
    TREE_CONNECT_ATTRIBUTE_PRIVACY   = 0x00004000U,
    TREE_CONNECT_ATTRIBUTE_INTEGRITY = 0x00008000U,
    TREE_CONNECT_ATTRIBUTE_GLOBAL    = 0x00000004U,
    TREE_CONNECT_ATTRIBUTE_PINNED    = 0x00000002U,
}

enum uint FILE_ATTRIBUTE_STRICTLY_SEQUENTIAL = 0x20000000U;

enum : uint
{
    MAILSLOT_NO_MESSAGE   = 0xffffffffU,
    MAILSLOT_WAIT_FOREVER = 0xffffffffU,
}

enum uint FILE_CASE_SENSITIVE_SEARCH = 0x00000001U;
enum uint FILE_CASE_PRESERVED_NAMES = 0x00000002U;
enum uint FILE_UNICODE_ON_DISK = 0x00000004U;
enum uint FILE_PERSISTENT_ACLS = 0x00000008U;
enum uint FILE_FILE_COMPRESSION = 0x00000010U;
enum uint FILE_VOLUME_QUOTAS = 0x00000020U;

enum : uint
{
    FILE_SUPPORTS_SPARSE_FILES   = 0x00000040U,
    FILE_SUPPORTS_REPARSE_POINTS = 0x00000080U,
    FILE_SUPPORTS_REMOTE_STORAGE = 0x00000100U,
}

enum uint FILE_RETURNS_CLEANUP_RESULT_INFO = 0x00000200U;

enum : uint
{
    FILE_SUPPORTS_POSIX_UNLINK_RENAME = 0x00000400U,
    FILE_SUPPORTS_BYPASS_IO           = 0x00000800U,
    FILE_SUPPORTS_STREAM_SNAPSHOTS    = 0x00001000U,
    FILE_SUPPORTS_CASE_SENSITIVE_DIRS = 0x00002000U,
}

enum uint FILE_VOLUME_IS_COMPRESSED = 0x00008000U;

enum : uint
{
    FILE_SUPPORTS_OBJECT_IDS = 0x00010000U,
    FILE_SUPPORTS_ENCRYPTION = 0x00020000U,
}

enum uint FILE_NAMED_STREAMS = 0x00040000U;
enum uint FILE_READ_ONLY_VOLUME = 0x00080000U;
enum uint FILE_SEQUENTIAL_WRITE_ONCE = 0x00100000U;

enum : uint
{
    FILE_SUPPORTS_TRANSACTIONS        = 0x00200000U,
    FILE_SUPPORTS_HARD_LINKS          = 0x00400000U,
    FILE_SUPPORTS_EXTENDED_ATTRIBUTES = 0x00800000U,
    FILE_SUPPORTS_OPEN_BY_FILE_ID     = 0x01000000U,
    FILE_SUPPORTS_USN_JOURNAL         = 0x02000000U,
    FILE_SUPPORTS_INTEGRITY_STREAMS   = 0x04000000U,
    FILE_SUPPORTS_BLOCK_REFCOUNTING   = 0x08000000U,
    FILE_SUPPORTS_SPARSE_VDL          = 0x10000000U,
}

enum uint FILE_DAX_VOLUME = 0x20000000U;
enum uint FILE_SUPPORTS_GHOSTING = 0x40000000U;

enum : uint
{
    FILE_NAME_FLAG_HARDLINK     = 0x00000000U,
    FILE_NAME_FLAG_NTFS         = 0x00000001U,
    FILE_NAME_FLAG_DOS          = 0x00000002U,
    FILE_NAME_FLAG_BOTH         = 0x00000003U,
    FILE_NAME_FLAGS_UNSPECIFIED = 0x00000080U,
}

enum : uint
{
    LX_FILE_METADATA_HAS_UID       = 0x00000001U,
    LX_FILE_METADATA_HAS_GID       = 0x00000002U,
    LX_FILE_METADATA_HAS_MODE      = 0x00000004U,
    LX_FILE_METADATA_HAS_DEVICE_ID = 0x00000008U,
}

enum uint LX_FILE_CASE_SENSITIVE_DIR = 0x00000010U;
enum uint FILE_CS_FLAG_CASE_SENSITIVE_DIR = 0x00000001U;

enum : uint
{
    FLUSH_FLAGS_FILE_DATA_ONLY      = 0x00000001U,
    FLUSH_FLAGS_NO_SYNC             = 0x00000002U,
    FLUSH_FLAGS_FILE_DATA_SYNC_ONLY = 0x00000004U,
    FLUSH_FLAGS_FLUSH_AND_PURGE     = 0x00000008U,
}

enum : uint
{
    IO_REPARSE_TAG_RESERVED_ZERO  = 0x00000000U,
    IO_REPARSE_TAG_RESERVED_ONE   = 0x00000001U,
    IO_REPARSE_TAG_RESERVED_TWO   = 0x00000002U,
    IO_REPARSE_TAG_RESERVED_RANGE = 0x00000002U,
}

enum int IO_REPARSE_TAG_RESERVED_INVALID = 0xc0008000;

enum : uint
{
    IO_REPARSE_TAG_MOUNT_POINT      = 0xa0000003U,
    IO_REPARSE_TAG_HSM              = 0xc0000004U,
    IO_REPARSE_TAG_HSM2             = 0x80000006U,
    IO_REPARSE_TAG_SIS              = 0x80000007U,
    IO_REPARSE_TAG_WIM              = 0x80000008U,
    IO_REPARSE_TAG_CSV              = 0x80000009U,
    IO_REPARSE_TAG_DFS              = 0x8000000aU,
    IO_REPARSE_TAG_SYMLINK          = 0xa000000cU,
    IO_REPARSE_TAG_DFSR             = 0x80000012U,
    IO_REPARSE_TAG_DEDUP            = 0x80000013U,
    IO_REPARSE_TAG_NFS              = 0x80000014U,
    IO_REPARSE_TAG_FILE_PLACEHOLDER = 0x80000015U,
    IO_REPARSE_TAG_WOF              = 0x80000017U,
    IO_REPARSE_TAG_WCI              = 0x80000018U,
    IO_REPARSE_TAG_WCI_1            = 0x90001018U,
    IO_REPARSE_TAG_GLOBAL_REPARSE   = 0xa0000019U,
    IO_REPARSE_TAG_CLOUD            = 0x9000001aU,
    IO_REPARSE_TAG_CLOUD_1          = 0x9000101aU,
    IO_REPARSE_TAG_CLOUD_2          = 0x9000201aU,
    IO_REPARSE_TAG_CLOUD_3          = 0x9000301aU,
    IO_REPARSE_TAG_CLOUD_4          = 0x9000401aU,
    IO_REPARSE_TAG_CLOUD_5          = 0x9000501aU,
    IO_REPARSE_TAG_CLOUD_6          = 0x9000601aU,
    IO_REPARSE_TAG_CLOUD_7          = 0x9000701aU,
    IO_REPARSE_TAG_CLOUD_8          = 0x9000801aU,
    IO_REPARSE_TAG_CLOUD_9          = 0x9000901aU,
    IO_REPARSE_TAG_CLOUD_A          = 0x9000a01aU,
    IO_REPARSE_TAG_CLOUD_B          = 0x9000b01aU,
    IO_REPARSE_TAG_CLOUD_C          = 0x9000c01aU,
    IO_REPARSE_TAG_CLOUD_D          = 0x9000d01aU,
    IO_REPARSE_TAG_CLOUD_E          = 0x9000e01aU,
    IO_REPARSE_TAG_CLOUD_F          = 0x9000f01aU,
    IO_REPARSE_TAG_CLOUD_MASK       = 0x0000f000U,
    IO_REPARSE_TAG_APPEXECLINK      = 0x8000001bU,
    IO_REPARSE_TAG_PROJFS           = 0x9000001cU,
    IO_REPARSE_TAG_STORAGE_SYNC     = 0x8000001eU,
    IO_REPARSE_TAG_WCI_TOMBSTONE    = 0xa000001fU,
    IO_REPARSE_TAG_UNHANDLED        = 0x80000020U,
    IO_REPARSE_TAG_ONEDRIVE         = 0x80000021U,
    IO_REPARSE_TAG_PROJFS_TOMBSTONE = 0xa0000022U,
    IO_REPARSE_TAG_AF_UNIX          = 0x80000023U,
}

enum int IO_REPARSE_TAG_STORAGE_SYNC_FOLDER = 0x90000027;

enum : uint
{
    IO_REPARSE_TAG_WCI_LINK     = 0xa0000027U,
    IO_REPARSE_TAG_WCI_LINK_1   = 0xa0001027U,
    IO_REPARSE_TAG_DATALESS_CIM = 0xa0000028U,
}

enum : uint
{
    SCRUB_DATA_INPUT_FLAG_RESUME                  = 0x00000001U,
    SCRUB_DATA_INPUT_FLAG_SKIP_IN_SYNC            = 0x00000002U,
    SCRUB_DATA_INPUT_FLAG_SKIP_NON_INTEGRITY_DATA = 0x00000004U,
    SCRUB_DATA_INPUT_FLAG_IGNORE_REDUNDANCY       = 0x00000008U,
    SCRUB_DATA_INPUT_FLAG_SKIP_DATA               = 0x00000010U,
    SCRUB_DATA_INPUT_FLAG_SCRUB_BY_OBJECT_ID      = 0x00000020U,
    SCRUB_DATA_INPUT_FLAG_OPLOCK_NOT_ACQUIRED     = 0x00000040U,
}

enum : uint
{
    SCRUB_DATA_OUTPUT_FLAG_INCOMPLETE                      = 0x00000001U,
    SCRUB_DATA_OUTPUT_FLAG_NON_USER_DATA_RANGE             = 0x00010000U,
    SCRUB_DATA_OUTPUT_FLAG_PARITY_EXTENT_DATA_RETURNED     = 0x00020000U,
    SCRUB_DATA_OUTPUT_FLAG_RESUME_CONTEXT_LENGTH_SPECIFIED = 0x00040000U,
}

enum uint SHUFFLE_FILE_FLAG_SKIP_INITIALIZING_NEW_CLUSTERS = 0x00000001U;
enum uint IO_COMPLETION_MODIFY_STATE = 0x00000002U;
// Native encoding: ansi
enum const(wchar)* SMB_CCF_APP_INSTANCE_EA_NAME = "ClusteredApplicationInstance";
enum uint NETWORK_APP_INSTANCE_CSV_FLAGS_VALID_ONLY_IF_CSV_COORDINATOR = 0x00000001U;
enum GUID GUID_MAX_POWER_SAVINGS = GUID("a1841308-3541-4fab-bc81-f71556f20b4a");
enum GUID GUID_MIN_POWER_SAVINGS = GUID("8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c");
enum GUID GUID_TYPICAL_POWER_SAVINGS = GUID("381b4222-f694-41f0-9685-ff5bb260df2e");
enum GUID NO_SUBGROUP_GUID = GUID("fea3413e-7e05-4911-9a71-700331f1c294");
enum GUID ALL_POWERSCHEMES_GUID = GUID("68a1e95e-13ea-41e1-8011-0c496ca490b0");
enum GUID GUID_POWERSCHEME_PERSONALITY = GUID("245d8541-3943-4422-b025-13a784f679b7");
enum GUID GUID_ACTIVE_POWERSCHEME = GUID("31f9f286-5084-42fe-b720-2b0264993763");

enum : GUID
{
    GUID_POWER_MODE_BEST_EFFICIENCY  = GUID("961cc777-2547-4f9d-8174-7d86181b8a7a"),
    GUID_POWER_MODE_NONE             = GUID("00000000-0000-0000-0000-000000000000"),
    GUID_POWER_MODE_PERFORMANCE      = GUID("3af9b8d9-7c97-431d-ad78-34a8bfea439f"),
    GUID_POWER_MODE_BEST_PERFORMANCE = GUID("ded574b5-45a0-4f42-8737-46345c09c238"),
}

enum : GUID
{
    GUID_IDLE_RESILIENCY_SUBGROUP = GUID("2e601130-5351-4d9d-8e04-252966bad054"),
    GUID_IDLE_RESILIENCY_PERIOD   = GUID("c42b79aa-aa3a-484b-a98f-2cf32aa90a28"),
}

enum : GUID
{
    GUID_DEEP_SLEEP_ENABLED        = GUID("d502f7ee-1dc7-4efd-a55d-f04b6f5c0545"),
    GUID_DEEP_SLEEP_PLATFORM_STATE = GUID("d23f2fb8-9536-4038-9c94-1ce02e5c2152"),
}

enum GUID GUID_DISK_COALESCING_POWERDOWN_TIMEOUT = GUID("c36f0eb4-2988-4a70-8eee-0884fc2c2433");
enum GUID GUID_EXECUTION_REQUIRED_REQUEST_TIMEOUT = GUID("3166bc41-7e98-4e03-b34e-ec0f5f2b218e");

enum : GUID
{
    GUID_VIDEO_SUBGROUP          = GUID("7516b95f-f776-4464-8c53-06167f40cc99"),
    GUID_VIDEO_POWERDOWN_TIMEOUT = GUID("3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e"),
}

enum : GUID
{
    GUID_VIDEO_ANNOYANCE_TIMEOUT         = GUID("82dbcf2d-cd67-40c5-bfdc-9f1a5ccd4663"),
    GUID_VIDEO_ADAPTIVE_PERCENT_INCREASE = GUID("eed904df-b142-4183-b10b-5a1197a37864"),
}

enum : GUID
{
    GUID_VIDEO_DIM_TIMEOUT        = GUID("17aaa29b-8b43-4b94-aafe-35f64daaf1ee"),
    GUID_VIDEO_ADAPTIVE_POWERDOWN = GUID("90959d22-d6a1-49b9-af93-bce885ad335b"),
}

enum GUID GUID_MONITOR_POWER_ON = GUID("02731015-4510-4526-99e6-e5a17ebd1aea");

enum : GUID
{
    GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS     = GUID("aded5e82-b909-4619-9949-f5d71dac0bcb"),
    GUID_DEVICE_POWER_POLICY_VIDEO_DIM_BRIGHTNESS = GUID("f1fbfde2-a960-4165-9f88-50667911ce96"),
}

enum GUID GUID_VIDEO_CURRENT_MONITOR_BRIGHTNESS = GUID("8ffee2c6-2d01-46be-adb9-398addc5b4ff");
enum GUID GUID_VIDEO_ADAPTIVE_DISPLAY_BRIGHTNESS = GUID("fbd9aa66-9553-4097-ba44-ed6e9d65eab8");
enum GUID GUID_CONSOLE_DISPLAY_STATE = GUID("6fe69556-704a-47a0-8f24-c28d936fda47");
enum GUID GUID_ALLOW_DISPLAY_REQUIRED = GUID("a9ceb8da-cd46-44fb-a98b-02af69de4623");
enum GUID GUID_VIDEO_CONSOLE_LOCK_TIMEOUT = GUID("8ec4b3a5-6868-48c2-be75-4f3044be88a7");
enum GUID GUID_ADVANCED_COLOR_QUALITY_BIAS = GUID("684c3e69-a4f7-4014-8754-d45179a56167");
enum GUID GUID_ADAPTIVE_POWER_BEHAVIOR_SUBGROUP = GUID("8619b916-e004-4dd8-9b66-dae86f806698");
enum GUID GUID_NON_ADAPTIVE_INPUT_TIMEOUT = GUID("5adbbfbc-074e-4da1-ba38-db8b36b2c8f3");
enum GUID GUID_ADAPTIVE_INPUT_CONTROLLER_STATE = GUID("0e98fae9-f45a-4de1-a757-6031f197f6ea");

enum : GUID
{
    GUID_DISK_SUBGROUP          = GUID("0012ee47-9041-4b5d-9b77-535fba8b1442"),
    GUID_DISK_MAX_POWER         = GUID("51dea550-bb38-4bc4-991b-eacf37be5ec8"),
    GUID_DISK_POWERDOWN_TIMEOUT = GUID("6738e2c4-e8a5-4a42-b16a-e040e769756e"),
}

enum : GUID
{
    GUID_DISK_IDLE_TIMEOUT           = GUID("58e39ba8-b8e6-4ef6-90d0-89ae32b258d6"),
    GUID_DISK_BURST_IGNORE_THRESHOLD = GUID("80e3c60e-bb94-4ad8-bbe0-0d3195efc663"),
}

enum GUID GUID_DISK_ADAPTIVE_POWERDOWN = GUID("396a32e1-499a-40b2-9124-a96afe707667");
enum GUID GUID_DISK_NVME_NOPPME = GUID("fc7372b6-ab2d-43ee-8797-15e9841f2cca");

enum : GUID
{
    GUID_SLEEP_SUBGROUP       = GUID("238c9fa8-0aad-41ed-83f4-97be242c8f20"),
    GUID_SLEEP_IDLE_THRESHOLD = GUID("81cd32e0-7833-44f3-8737-7081f38d1f70"),
}

enum GUID GUID_STANDBY_TIMEOUT = GUID("29f6c1db-86da-48c5-9fdb-f2b67b1f44da");
enum GUID GUID_UNATTEND_SLEEP_TIMEOUT = GUID("7bc4a2f9-d8fc-4469-b07b-33eb785aaca0");

enum : GUID
{
    GUID_HIBERNATE_TIMEOUT       = GUID("9d7815a6-7ee4-497e-8888-515a05f02364"),
    GUID_HIBERNATE_FASTS4_POLICY = GUID("94ac6d29-73ce-41a6-809f-6363ba21b47e"),
}

enum GUID GUID_CRITICAL_POWER_TRANSITION = GUID("b7a27025-e569-46c2-a504-2b96cad225a1");
enum GUID GUID_SYSTEM_AWAYMODE = GUID("98a7f580-01f7-48aa-9c0f-44352c29e5c0");
enum GUID GUID_ALLOW_AWAYMODE = GUID("25dfa149-5dd1-4736-b5ab-e8a37b5b8187");
enum GUID GUID_USER_PRESENCE_PREDICTION = GUID("82011705-fb95-4d46-8d35-4042b1d20def");

enum : GUID
{
    GUID_STANDBY_BUDGET_GRACE_PERIOD     = GUID("60c07fe1-0556-45cf-9903-d56e32210242"),
    GUID_STANDBY_BUDGET_PERCENT          = GUID("9fe527be-1b70-48da-930d-7bcf17b44990"),
    GUID_STANDBY_BUDGET_REFRESH_COUNT    = GUID("aca8648e-c4b1-4baa-8cce-9390ad647f8c"),
    GUID_STANDBY_BUDGET_REFRESH_INTERVAL = GUID("61f45dfe-1919-4180-bb46-8cc70e0b38f1"),
}

enum : GUID
{
    GUID_STANDBY_RESERVE_GRACE_PERIOD = GUID("c763ee92-71e8-4127-84eb-f6ed043a3e3d"),
    GUID_STANDBY_RESERVE_TIME         = GUID("468fe7e5-1158-46ec-88bc-5b96c9e44fd0"),
    GUID_STANDBY_RESET_PERCENT        = GUID("49cb11a5-56e2-4afb-9d38-3df47872e21b"),
}

enum : GUID
{
    GUID_HUPR_ADAPTIVE_AWAY_DISPLAY_TIMEOUT        = GUID("0a7d6ab6-ac83-4ad1-8282-eca5b58308f3"),
    GUID_HUPR_ADAPTIVE_INATTENTIVE_DIM_TIMEOUT     = GUID("cf8c6097-12b8-4279-bbdd-44601ee5209d"),
    GUID_HUPR_ADAPTIVE_INATTENTIVE_DISPLAY_TIMEOUT = GUID("ee16691e-6ab3-4619-bb48-1c77c9357e5a"),
    GUID_HUPR_ADAPTIVE_AWAY_DIM_TIMEOUT            = GUID("a79c8e0e-f271-482d-8f8a-5db9a18312de"),
}

enum : GUID
{
    GUID_ALLOW_STANDBY_STATES = GUID("abfc2519-3608-4c2a-94ea-171b0ed546ab"),
    GUID_ALLOW_RTC_WAKE       = GUID("bd3b718a-0680-4d9d-8ab2-e1d2b4ac806d"),
}

enum GUID GUID_LEGACY_RTC_MITIGATION = GUID("1a34bdc3-7e6b-442e-a9d0-64b6ef378e84");
enum GUID GUID_ALLOW_SYSTEM_REQUIRED = GUID("a4b195f5-8225-47d8-8012-9d41369786e2");
enum GUID GUID_POWER_SAVING_STATUS = GUID("e00958c0-c213-4ace-ac77-fecced2eeea5");

enum : GUID
{
    GUID_ENERGY_SAVER_STATUS            = GUID("550e8400-e29b-41d4-a716-446655440000"),
    GUID_ENERGY_SAVER_SUBGROUP          = GUID("de830923-a562-41af-a086-e3a2c6bad2da"),
    GUID_ENERGY_SAVER_BATTERY_THRESHOLD = GUID("e69653ca-cf7f-4f05-aa73-cb833fa90ad4"),
    GUID_ENERGY_SAVER_BRIGHTNESS        = GUID("13d09884-f74e-474a-a852-b6bde8ad03a8"),
    GUID_ENERGY_SAVER_POLICY            = GUID("5c5bb349-ad29-4ee2-9d0b-2b25270f7a81"),
}

enum GUID GUID_SYSTEM_BUTTON_SUBGROUP = GUID("4f971e89-eebd-4455-a8de-9e59040e7347");

enum : uint
{
    POWERBUTTON_ACTION_INDEX_NOTHING              = 0x00000000U,
    POWERBUTTON_ACTION_INDEX_SLEEP                = 0x00000001U,
    POWERBUTTON_ACTION_INDEX_HIBERNATE            = 0x00000002U,
    POWERBUTTON_ACTION_INDEX_SHUTDOWN             = 0x00000003U,
    POWERBUTTON_ACTION_INDEX_TURN_OFF_THE_DISPLAY = 0x00000004U,
    POWERBUTTON_ACTION_VALUE_NOTHING              = 0x00000000U,
    POWERBUTTON_ACTION_VALUE_SLEEP                = 0x00000002U,
    POWERBUTTON_ACTION_VALUE_HIBERNATE            = 0x00000003U,
    POWERBUTTON_ACTION_VALUE_SHUTDOWN             = 0x00000006U,
    POWERBUTTON_ACTION_VALUE_TURN_OFF_THE_DISPLAY = 0x00000008U,
}

enum GUID GUID_POWERBUTTON_ACTION = GUID("7648efa3-dd9c-4e3e-b566-50f929386280");
enum GUID GUID_SLEEPBUTTON_ACTION = GUID("96996bc0-ad50-47ec-923b-6f41874dd9eb");
enum GUID GUID_USERINTERFACEBUTTON_ACTION = GUID("a7066653-8d6c-40a8-910e-a1f54b84c7e5");
enum GUID GUID_LIDCLOSE_ACTION = GUID("5ca83367-6e45-459f-a27b-476b1d01c936");
enum GUID GUID_LIDOPEN_POWERSTATE = GUID("99ff10e7-23b1-4c07-a9d1-5c3206d741b4");

enum : GUID
{
    GUID_BATTERY_SUBGROUP           = GUID("e73a048d-bf27-4f12-9731-8b2076e8891f"),
    GUID_BATTERY_DISCHARGE_ACTION_0 = GUID("637ea02f-bbcb-4015-8e2c-a1c7b9c0b546"),
    GUID_BATTERY_DISCHARGE_LEVEL_0  = GUID("9a66d8d7-4ff7-4ef9-b5a2-5a326ca2a469"),
    GUID_BATTERY_DISCHARGE_FLAGS_0  = GUID("5dbb7c9f-38e9-40d2-9749-4f8a0e9f640f"),
    GUID_BATTERY_DISCHARGE_ACTION_1 = GUID("d8742dcb-3e6a-4b3c-b3fe-374623cdcf06"),
    GUID_BATTERY_DISCHARGE_LEVEL_1  = GUID("8183ba9a-e910-48da-8769-14ae6dc1170a"),
    GUID_BATTERY_DISCHARGE_FLAGS_1  = GUID("bcded951-187b-4d05-bccc-f7e51960c258"),
    GUID_BATTERY_DISCHARGE_ACTION_2 = GUID("421cba38-1a8e-4881-ac89-e33a8b04ece4"),
    GUID_BATTERY_DISCHARGE_LEVEL_2  = GUID("07a07ca2-adaf-40d7-b077-533aaded1bfa"),
    GUID_BATTERY_DISCHARGE_FLAGS_2  = GUID("7fd2f0c4-feb7-4da3-8117-e3fbedc46582"),
    GUID_BATTERY_DISCHARGE_ACTION_3 = GUID("80472613-9780-455e-b308-72d3003cf2f8"),
    GUID_BATTERY_DISCHARGE_LEVEL_3  = GUID("58afd5a6-c2dd-47d2-9fbf-ef70cc5c5965"),
    GUID_BATTERY_DISCHARGE_FLAGS_3  = GUID("73613ccf-dbfa-4279-8356-4935f6bf62f3"),
}

enum : GUID
{
    GUID_PROCESSOR_SETTINGS_SUBGROUP = GUID("54533251-82be-4824-96c1-47b60b740d00"),
    GUID_PROCESSOR_THROTTLE_POLICY   = GUID("57027304-4af6-4104-9260-e3d95248fc36"),
}

enum : uint
{
    PERFSTATE_POLICY_CHANGE_IDEAL            = 0x00000000U,
    PERFSTATE_POLICY_CHANGE_SINGLE           = 0x00000001U,
    PERFSTATE_POLICY_CHANGE_ROCKET           = 0x00000002U,
    PERFSTATE_POLICY_CHANGE_IDEAL_AGGRESSIVE = 0x00000003U,
    PERFSTATE_POLICY_CHANGE_DECREASE_MAX     = 0x00000002U,
    PERFSTATE_POLICY_CHANGE_INCREASE_MAX     = 0x00000003U,
}

enum : GUID
{
    GUID_PROCESSOR_THROTTLE_MAXIMUM   = GUID("bc5038f7-23e0-4960-96da-33abaf5935ec"),
    GUID_PROCESSOR_THROTTLE_MAXIMUM_1 = GUID("bc5038f7-23e0-4960-96da-33abaf5935ed"),
    GUID_PROCESSOR_THROTTLE_MAXIMUM_2 = GUID("bc5038f7-23e0-4960-96da-33abaf5935ee"),
    GUID_PROCESSOR_THROTTLE_MINIMUM   = GUID("893dee8e-2bef-41e0-89c6-b55d0929964c"),
    GUID_PROCESSOR_THROTTLE_MINIMUM_1 = GUID("893dee8e-2bef-41e0-89c6-b55d0929964d"),
    GUID_PROCESSOR_THROTTLE_MINIMUM_2 = GUID("893dee8e-2bef-41e0-89c6-b55d0929964e"),
    GUID_PROCESSOR_FREQUENCY_LIMIT    = GUID("75b0ae3f-bce0-45a7-8c89-c9611c25e100"),
    GUID_PROCESSOR_FREQUENCY_LIMIT_1  = GUID("75b0ae3f-bce0-45a7-8c89-c9611c25e101"),
    GUID_PROCESSOR_FREQUENCY_LIMIT_2  = GUID("75b0ae3f-bce0-45a7-8c89-c9611c25e102"),
    GUID_PROCESSOR_ALLOW_THROTTLING   = GUID("3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb"),
}

enum : uint
{
    PROCESSOR_THROTTLE_DISABLED  = 0x00000000U,
    PROCESSOR_THROTTLE_ENABLED   = 0x00000001U,
    PROCESSOR_THROTTLE_AUTOMATIC = 0x00000002U,
}

enum : GUID
{
    GUID_PROCESSOR_IDLESTATE_POLICY          = GUID("68f262a7-f621-4069-b9a5-4874169be23c"),
    GUID_PROCESSOR_PERFSTATE_POLICY          = GUID("bbdc3814-18e9-4463-8a55-d197327c45c0"),
    GUID_PROCESSOR_PERF_INCREASE_THRESHOLD   = GUID("06cadf0e-64ed-448a-8927-ce7bf90eb35d"),
    GUID_PROCESSOR_PERF_INCREASE_THRESHOLD_1 = GUID("06cadf0e-64ed-448a-8927-ce7bf90eb35e"),
    GUID_PROCESSOR_PERF_DECREASE_THRESHOLD   = GUID("12a0ab44-fe28-4fa9-b3bd-4b64f44960a6"),
    GUID_PROCESSOR_PERF_DECREASE_THRESHOLD_1 = GUID("12a0ab44-fe28-4fa9-b3bd-4b64f44960a7"),
    GUID_PROCESSOR_PERF_INCREASE_POLICY      = GUID("465e1f50-b610-473a-ab58-00d1077dc418"),
    GUID_PROCESSOR_PERF_INCREASE_POLICY_1    = GUID("465e1f50-b610-473a-ab58-00d1077dc419"),
    GUID_PROCESSOR_PERF_DECREASE_POLICY      = GUID("40fbefc7-2e9d-4d25-a185-0cfd8574bac6"),
    GUID_PROCESSOR_PERF_DECREASE_POLICY_1    = GUID("40fbefc7-2e9d-4d25-a185-0cfd8574bac7"),
    GUID_PROCESSOR_PERF_INCREASE_TIME        = GUID("984cf492-3bed-4488-a8f9-4286c97bf5aa"),
    GUID_PROCESSOR_PERF_INCREASE_TIME_1      = GUID("984cf492-3bed-4488-a8f9-4286c97bf5ab"),
    GUID_PROCESSOR_PERF_DECREASE_TIME        = GUID("d8edeb9b-95cf-4f95-a73c-b061973693c8"),
    GUID_PROCESSOR_PERF_DECREASE_TIME_1      = GUID("d8edeb9b-95cf-4f95-a73c-b061973693c9"),
    GUID_PROCESSOR_PERF_TIME_CHECK           = GUID("4d2b0152-7d5c-498b-88e2-34345392a2c5"),
    GUID_PROCESSOR_PERF_BOOST_POLICY         = GUID("45bcc044-d885-43e2-8605-ee0ec6e96b59"),
}

enum : uint
{
    PROCESSOR_PERF_BOOST_POLICY_DISABLED = 0x00000000U,
    PROCESSOR_PERF_BOOST_POLICY_MAX      = 0x00000064U,
}

enum GUID GUID_PROCESSOR_PERF_BOOST_MODE = GUID("be337238-0d82-4146-a960-4f3749d470c7");

enum : uint
{
    PROCESSOR_PERF_BOOST_MODE_DISABLED                           = 0x00000000U,
    PROCESSOR_PERF_BOOST_MODE_ENABLED                            = 0x00000001U,
    PROCESSOR_PERF_BOOST_MODE_AGGRESSIVE                         = 0x00000002U,
    PROCESSOR_PERF_BOOST_MODE_EFFICIENT_ENABLED                  = 0x00000003U,
    PROCESSOR_PERF_BOOST_MODE_EFFICIENT_AGGRESSIVE               = 0x00000004U,
    PROCESSOR_PERF_BOOST_MODE_AGGRESSIVE_AT_GUARANTEED           = 0x00000005U,
    PROCESSOR_PERF_BOOST_MODE_EFFICIENT_AGGRESSIVE_AT_GUARANTEED = 0x00000006U,
    PROCESSOR_PERF_BOOST_MODE_MAX                                = 0x00000006U,
}

enum GUID GUID_PROCESSOR_PERF_AUTONOMOUS_MODE = GUID("8baa4a8a-14c6-4451-8e8b-14bdbd197537");

enum : uint
{
    PROCESSOR_PERF_AUTONOMOUS_MODE_DISABLED = 0x00000000U,
    PROCESSOR_PERF_AUTONOMOUS_MODE_ENABLED  = 0x00000001U,
}

enum : GUID
{
    GUID_PROCESSOR_PERF_ENERGY_PERFORMANCE_PREFERENCE   = GUID("36687f9e-e3a5-4dbf-b1dc-15eb381c6863"),
    GUID_PROCESSOR_PERF_ENERGY_PERFORMANCE_PREFERENCE_1 = GUID("36687f9e-e3a5-4dbf-b1dc-15eb381c6864"),
    GUID_PROCESSOR_PERF_ENERGY_PERFORMANCE_PREFERENCE_2 = GUID("36687f9e-e3a5-4dbf-b1dc-15eb381c6865"),
}

enum : uint
{
    PROCESSOR_PERF_PERFORMANCE_PREFERENCE = 0x000000ffU,
    PROCESSOR_PERF_ENERGY_PREFERENCE      = 0x00000000U,
}

enum GUID GUID_PROCESSOR_PERF_AUTONOMOUS_ACTIVITY_WINDOW = GUID("cfeda3d0-7697-4566-a922-a9086cd49dfa");

enum : uint
{
    PROCESSOR_PERF_MINIMUM_ACTIVITY_WINDOW = 0x00000000U,
    PROCESSOR_PERF_MAXIMUM_ACTIVITY_WINDOW = 0x4bb2a980U,
}

enum GUID GUID_PROCESSOR_DUTY_CYCLING = GUID("4e4450b3-6179-4e91-b8f1-5bb9938f81a1");

enum : uint
{
    PROCESSOR_DUTY_CYCLING_DISABLED = 0x00000000U,
    PROCESSOR_DUTY_CYCLING_ENABLED  = 0x00000001U,
}

enum : GUID
{
    GUID_PROCESSOR_IDLE_ALLOW_SCALING              = GUID("6c2993b0-8f48-481f-bcc6-00dd2742aa06"),
    GUID_PROCESSOR_IDLE_DISABLE                    = GUID("5d76a2ca-e8c0-402f-a133-2158492d58ad"),
    GUID_PROCESSOR_IDLE_STATE_MAXIMUM              = GUID("9943e905-9a30-4ec1-9b99-44dd3b76f7a2"),
    GUID_PROCESSOR_IDLE_TIME_CHECK                 = GUID("c4581c31-89ab-4597-8e2b-9c9cab440e6b"),
    GUID_PROCESSOR_IDLE_DEMOTE_THRESHOLD           = GUID("4b92d758-5a24-4851-a470-815d78aee119"),
    GUID_PROCESSOR_IDLE_PROMOTE_THRESHOLD          = GUID("7b224883-b3cc-4d79-819f-8374152cbe7c"),
    GUID_PROCESSOR_CORE_PARKING_INCREASE_THRESHOLD = GUID("df142941-20f3-4edf-9a4a-9c83d3d717d1"),
    GUID_PROCESSOR_CORE_PARKING_DECREASE_THRESHOLD = GUID("68dd2f27-a4ce-4e11-8487-3794e4135dfa"),
    GUID_PROCESSOR_CORE_PARKING_INCREASE_POLICY    = GUID("c7be0679-2817-4d69-9d02-519a537ed0c6"),
}

enum : uint
{
    CORE_PARKING_POLICY_CHANGE_IDEAL     = 0x00000000U,
    CORE_PARKING_POLICY_CHANGE_SINGLE    = 0x00000001U,
    CORE_PARKING_POLICY_CHANGE_ROCKET    = 0x00000002U,
    CORE_PARKING_POLICY_CHANGE_MULTISTEP = 0x00000003U,
    CORE_PARKING_POLICY_CHANGE_MAX       = 0x00000003U,
}

enum : GUID
{
    GUID_PROCESSOR_CORE_PARKING_DECREASE_POLICY                          = GUID("71021b41-c749-4d21-be74-a00f335d582b"),
    GUID_PROCESSOR_CORE_PARKING_MAX_CORES                                = GUID("ea062031-0e34-4ff1-9b6d-eb1059334028"),
    GUID_PROCESSOR_CORE_PARKING_MAX_CORES_1                              = GUID("ea062031-0e34-4ff1-9b6d-eb1059334029"),
    GUID_PROCESSOR_CORE_PARKING_MIN_CORES                                = GUID("0cc5b647-c1df-4637-891a-dec35c318583"),
    GUID_PROCESSOR_CORE_PARKING_MIN_CORES_1                              = GUID("0cc5b647-c1df-4637-891a-dec35c318584"),
    GUID_PROCESSOR_CORE_PARKING_INCREASE_TIME                            = GUID("2ddd5a84-5a71-437e-912a-db0b8c788732"),
    GUID_PROCESSOR_CORE_PARKING_DECREASE_TIME                            = GUID("dfd10d17-d5eb-45dd-877a-9a34ddd15c82"),
    GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_DECREASE_FACTOR         = GUID("8f7b45e3-c393-480a-878c-f67ac3d07082"),
    GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_THRESHOLD               = GUID("5b33697b-e89d-4d38-aa46-9e7dfb7cd2f9"),
    GUID_PROCESSOR_CORE_PARKING_AFFINITY_WEIGHTING                       = GUID("e70867f1-fa2f-4f4e-aea1-4d8a0ba23b20"),
    GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_DECREASE_FACTOR = GUID("1299023c-bc28-4f0a-81ec-d3295a8d815d"),
    GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_THRESHOLD       = GUID("9ac18e92-aa3c-4e27-b307-01ae37307129"),
    GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_WEIGHTING               = GUID("8809c2d8-b155-42d4-bcda-0d345651b1db"),
    GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_THRESHOLD               = GUID("943c8cb6-6f93-4227-ad87-e9a3feec08d1"),
}

enum : GUID
{
    GUID_PROCESSOR_PARKING_CORE_OVERRIDE          = GUID("a55612aa-f624-42c6-a443-7397d064c04f"),
    GUID_PROCESSOR_PARKING_PERF_STATE             = GUID("447235c7-6a8d-4cc0-8e24-9eaf70b96e2b"),
    GUID_PROCESSOR_PARKING_PERF_STATE_1           = GUID("447235c7-6a8d-4cc0-8e24-9eaf70b96e2c"),
    GUID_PROCESSOR_PARKING_CONCURRENCY_THRESHOLD  = GUID("2430ab6f-a520-44a2-9601-f7f23b5134b1"),
    GUID_PROCESSOR_PARKING_HEADROOM_THRESHOLD     = GUID("f735a673-2066-4f80-a0c5-ddee0cf1bf5d"),
    GUID_PROCESSOR_PARKING_DISTRIBUTION_THRESHOLD = GUID("4bdaf4e9-d103-46d7-a5f0-6280121616ef"),
}

enum : GUID
{
    GUID_PROCESSOR_SOFT_PARKING_LATENCY      = GUID("97cfac41-2217-47eb-992d-618b1977c907"),
    GUID_PROCESSOR_PERF_HISTORY              = GUID("7d24baa7-0b84-480f-840c-1b0743c00f5f"),
    GUID_PROCESSOR_PERF_HISTORY_1            = GUID("7d24baa7-0b84-480f-840c-1b0743c00f60"),
    GUID_PROCESSOR_PERF_INCREASE_HISTORY     = GUID("99b3ef01-752f-46a1-80fb-7730011f2354"),
    GUID_PROCESSOR_PERF_DECREASE_HISTORY     = GUID("0300f6f8-abd6-45a9-b74f-4908691a40b5"),
    GUID_PROCESSOR_PERF_CORE_PARKING_HISTORY = GUID("77d7f282-8f1a-42cd-8537-45450a839be8"),
    GUID_PROCESSOR_PERF_LATENCY_HINT         = GUID("0822df31-9c83-441c-a079-0de4cf009c7b"),
    GUID_PROCESSOR_PERF_LATENCY_HINT_PERF    = GUID("619b7505-003b-4e82-b7a6-4dd29c300971"),
    GUID_PROCESSOR_PERF_LATENCY_HINT_PERF_1  = GUID("619b7505-003b-4e82-b7a6-4dd29c300972"),
    GUID_PROCESSOR_PERF_LATENCY_HINT_PERF_2  = GUID("619b7505-003b-4e82-b7a6-4dd29c300973"),
    GUID_PROCESSOR_PERF_LATENCY_HINT_EPP     = GUID("4b70f900-cdd9-4e66-aa26-ae8417f98173"),
    GUID_PROCESSOR_PERF_LATENCY_HINT_EPP_1   = GUID("4b70f900-cdd9-4e66-aa26-ae8417f98174"),
    GUID_PROCESSOR_PERF_LATENCY_HINT_EPP_2   = GUID("4b70f900-cdd9-4e66-aa26-ae8417f98175"),
}

enum : GUID
{
    GUID_PROCESSOR_LATENCY_HINT_MIN_UNPARK   = GUID("616cdaa5-695e-4545-97ad-97dc2d1bdd88"),
    GUID_PROCESSOR_LATENCY_HINT_MIN_UNPARK_1 = GUID("616cdaa5-695e-4545-97ad-97dc2d1bdd89"),
}

enum : GUID
{
    GUID_PROCESSOR_MODULE_PARKING_POLICY  = GUID("b0deaf6b-59c0-4523-8a45-ca7f40244114"),
    GUID_PROCESSOR_COMPLEX_PARKING_POLICY = GUID("b669a5e9-7b1d-4132-baaa-49190abcfeb6"),
}

enum : uint
{
    PARKING_TOPOLOGY_POLICY_DISABLED   = 0x00000000U,
    PARKING_TOPOLOGY_POLICY_ROUNDROBIN = 0x00000001U,
    PARKING_TOPOLOGY_POLICY_SEQUENTIAL = 0x00000002U,
}

enum GUID GUID_PROCESSOR_SMT_UNPARKING_POLICY = GUID("b28a6829-c5f7-444e-8f61-10e24e85c532");

enum : uint
{
    SMT_UNPARKING_POLICY_CORE            = 0x00000000U,
    SMT_UNPARKING_POLICY_CORE_PER_THREAD = 0x00000001U,
    SMT_UNPARKING_POLICY_LP_ROUNDROBIN   = 0x00000002U,
    SMT_UNPARKING_POLICY_LP_SEQUENTIAL   = 0x00000003U,
}

enum : GUID
{
    GUID_PROCESSOR_RESTRICTION_COUNT                                = GUID("1a98ad09-af22-42ca-8e61-f0a5802c270a"),
    GUID_PROCESSOR_DISTRIBUTE_UTILITY                               = GUID("e0007330-f589-42ed-a401-5ddb10e785d3"),
    GUID_PROCESSOR_RESOURCE_PRIORITY                                = GUID("603fe9ce-8d01-4b48-a968-1d706c28fd5c"),
    GUID_PROCESSOR_RESOURCE_PRIORITY_1                              = GUID("603fe9ce-8d01-4b48-a968-1d706c28fd5d"),
    GUID_PROCESSOR_RESOURCE_PRIORITY_2                              = GUID("603fe9ce-8d01-4b48-a968-1d706c28fd5e"),
    GUID_PROCESSOR_HETEROGENEOUS_POLICY                             = GUID("7f2f5cfa-f10c-4823-b5e1-e93ae85f46b5"),
    GUID_PROCESSOR_HETERO_DECREASE_TIME                             = GUID("7f2492b6-60b1-45e5-ae55-773f8cd5caec"),
    GUID_PROCESSOR_HETERO_INCREASE_TIME                             = GUID("4009efa7-e72d-4cba-9edf-91084ea8cbc3"),
    GUID_PROCESSOR_HETERO_CONTAINMENT_DECREASE_TIME                 = GUID("6ff13aeb-7897-4356-9999-dd9930af065f"),
    GUID_PROCESSOR_HETERO_CONTAINMENT_INCREASE_TIME                 = GUID("64fcee6b-5b1f-45a4-a76a-19b2c36ee290"),
    GUID_PROCESSOR_HETERO_CONTAINMENT_EFFICIENCY_THRESHOLD          = GUID("69439b22-221b-4830-bd34-f7bcece24583"),
    GUID_PROCESSOR_HETERO_CONTAINMENT_HYBRID_THRESHOLD              = GUID("6788488b-1b90-4d11-8fa7-973e470dff47"),
    GUID_PROCESSOR_HETERO_CONTAINMENT_POLICY                        = GUID("60fbe21b-efd9-49f2-b066-8674d8e9f423"),
    GUID_PROCESSOR_HETERO_CONTAINMENT_EFFICIENCY_IMP_UTIL_THRESHOLD = GUID("6ece9e1f-b6dd-42bf-b1b7-5a512b10c092"),
    GUID_PROCESSOR_HETERO_CONTAINMENT_HYBRID_IMP_UTIL_THRESHOLD     = GUID("12fd031f-53d2-4bf4-ac6d-c699fc9538c7"),
}

enum GUID GUID_PROCESSOR_WPS_MIN_EFFICIENCY_THRESHOLD = GUID("5ba7419a-295c-4b02-841b-66799388d6da");

enum : GUID
{
    GUID_PROCESSOR_HETERO_DECREASE_THRESHOLD   = GUID("f8861c27-95e7-475c-865b-13c0cb3f9d6b"),
    GUID_PROCESSOR_HETERO_DECREASE_THRESHOLD_1 = GUID("f8861c27-95e7-475c-865b-13c0cb3f9d6c"),
    GUID_PROCESSOR_HETERO_INCREASE_THRESHOLD   = GUID("b000397d-9b0b-483d-98c9-692a6060cfbf"),
    GUID_PROCESSOR_HETERO_INCREASE_THRESHOLD_1 = GUID("b000397d-9b0b-483d-98c9-692a6060cfc0"),
}

enum : GUID
{
    GUID_PROCESSOR_CLASS0_FLOOR_PERF        = GUID("fddc842b-8364-4edc-94cf-c17f60de1c80"),
    GUID_PROCESSOR_CLASS1_INITIAL_PERF      = GUID("1facfc65-a930-4bc5-9f38-504ec097bbc0"),
    GUID_PROCESSOR_THREAD_SCHEDULING_POLICY = GUID("93b8b6dc-0698-4d1c-9ee4-0644e900c85d"),
}

enum : GUID
{
    GUID_PROCESSOR_SHORT_THREAD_SCHEDULING_POLICY          = GUID("bae08b81-2d5e-4688-ad6a-13243356654b"),
    GUID_PROCESSOR_SHORT_THREAD_RUNTIME_THRESHOLD          = GUID("d92998c2-6a48-49ca-85d4-8cceec294570"),
    GUID_PROCESSOR_SHORT_THREAD_ARCH_CLASS_UPPER_THRESHOLD = GUID("828423eb-8662-4344-90f7-52bf15870f5a"),
    GUID_PROCESSOR_SHORT_THREAD_ARCH_CLASS_LOWER_THRESHOLD = GUID("53824d46-87bd-4739-aa1b-aa793fac36d6"),
}

enum : GUID
{
    GUID_PROCESSOR_LONG_THREAD_ARCH_CLASS_UPPER_THRESHOLD = GUID("bf903d33-9d24-49d3-a468-e65e0325046a"),
    GUID_PROCESSOR_LONG_THREAD_ARCH_CLASS_LOWER_THRESHOLD = GUID("43f278bc-0f8a-46d0-8b31-9a23e615d713"),
}

enum GUID GUID_SYSTEM_COOLING_POLICY = GUID("94d3a615-a899-4ac5-ae2b-e4d8f634367f");

enum : GUID
{
    GUID_PROCESSOR_RESPONSIVENESS_DISABLE_THRESHOLD   = GUID("38b8383d-cce0-4c79-9e3e-56a4f17cc480"),
    GUID_PROCESSOR_RESPONSIVENESS_DISABLE_THRESHOLD_1 = GUID("38b8383d-cce0-4c79-9e3e-56a4f17cc481"),
    GUID_PROCESSOR_RESPONSIVENESS_ENABLE_THRESHOLD    = GUID("3d44e256-7222-4415-a9ed-9c45fa3dd830"),
    GUID_PROCESSOR_RESPONSIVENESS_ENABLE_THRESHOLD_1  = GUID("3d44e256-7222-4415-a9ed-9c45fa3dd831"),
    GUID_PROCESSOR_RESPONSIVENESS_DISABLE_TIME        = GUID("f565999f-3fb0-411a-a226-3f0198dec130"),
    GUID_PROCESSOR_RESPONSIVENESS_DISABLE_TIME_1      = GUID("f565999f-3fb0-411a-a226-3f0198dec131"),
    GUID_PROCESSOR_RESPONSIVENESS_ENABLE_TIME         = GUID("3d915188-7830-49ae-a79a-0fb0a1e5a200"),
    GUID_PROCESSOR_RESPONSIVENESS_ENABLE_TIME_1       = GUID("3d915188-7830-49ae-a79a-0fb0a1e5a201"),
    GUID_PROCESSOR_RESPONSIVENESS_EPP_CEILING         = GUID("4427c73b-9756-4a5c-b84b-c7bda79c7320"),
    GUID_PROCESSOR_RESPONSIVENESS_EPP_CEILING_1       = GUID("4427c73b-9756-4a5c-b84b-c7bda79c7321"),
    GUID_PROCESSOR_RESPONSIVENESS_PERF_FLOOR          = GUID("ce8e92ee-6a86-4572-bfe0-20c21d03cd40"),
    GUID_PROCESSOR_RESPONSIVENESS_PERF_FLOOR_1        = GUID("ce8e92ee-6a86-4572-bfe0-20c21d03cd41"),
}

enum GUID GUID_LOCK_CONSOLE_ON_WAKE = GUID("0e796bdb-100d-47d6-a2d5-f7d2daa51f51");
enum GUID GUID_DEVICE_IDLE_POLICY = GUID("4faab71a-92e5-4726-b531-224559672d19");

enum : uint
{
    POWER_DEVICE_IDLE_POLICY_PERFORMANCE  = 0x00000000U,
    POWER_DEVICE_IDLE_POLICY_CONSERVATIVE = 0x00000001U,
}

enum GUID GUID_CONNECTIVITY_IN_STANDBY = GUID("f15576e8-98b7-4186-b944-eafa664402d9");

enum : uint
{
    POWER_CONNECTIVITY_IN_STANDBY_DISABLED       = 0x00000000U,
    POWER_CONNECTIVITY_IN_STANDBY_ENABLED        = 0x00000001U,
    POWER_CONNECTIVITY_IN_STANDBY_SYSTEM_MANAGED = 0x00000002U,
}

enum GUID GUID_DISCONNECTED_STANDBY_MODE = GUID("68afb2d9-ee95-47a8-8f50-4115088073b1");

enum : uint
{
    POWER_DISCONNECTED_STANDBY_MODE_NORMAL     = 0x00000000U,
    POWER_DISCONNECTED_STANDBY_MODE_AGGRESSIVE = 0x00000001U,
}

enum GUID GUID_ACDC_POWER_SOURCE = GUID("5d3e9a59-e9d5-4b00-a6bd-ff34ff516548");

enum : GUID
{
    GUID_LIDSWITCH_STATE_CHANGE      = GUID("ba3e0f4d-b817-4094-a2d1-d56379e6a0f3"),
    GUID_LIDSWITCH_STATE_RELIABILITY = GUID("ae4c4ff1-d361-43f4-80aa-bbb6eb03de94"),
}

enum GUID GUID_BATTERY_PERCENTAGE_REMAINING = GUID("a7ad8041-b45a-4cae-87a3-eecbb468a9e1");
enum GUID GUID_BATTERY_COUNT = GUID("7d263f15-fca4-49e5-854b-a9f2bfbd5c24");
enum GUID GUID_GLOBAL_USER_PRESENCE = GUID("786e8a1d-b427-4344-9207-09e70bdcbea9");

enum : GUID
{
    GUID_SESSION_DISPLAY_STATUS = GUID("2b84c20e-ad23-4ddf-93db-05ffbd7efca5"),
    GUID_SESSION_USER_PRESENCE  = GUID("3c0f4548-c03f-4c4d-b9f2-237ede686376"),
}

enum GUID GUID_IDLE_BACKGROUND_TASK = GUID("515c31d8-f734-163d-a0fd-11a08c91e8f1");
enum GUID GUID_BACKGROUND_TASK_NOTIFICATION = GUID("cf23f240-2a54-48d8-b114-de1518ff052e");
enum GUID GUID_APPLAUNCH_BUTTON = GUID("1a689231-7399-4e9a-8f99-b71f999db3fa");

enum : GUID
{
    GUID_PCIEXPRESS_SETTINGS_SUBGROUP = GUID("501a4d13-42af-4429-9fd1-a8218c268e20"),
    GUID_PCIEXPRESS_ASPM_POLICY       = GUID("ee12f906-d277-404b-b6da-e5fa1a576df5"),
}

enum GUID GUID_ENABLE_SWITCH_FORCED_SHUTDOWN = GUID("833a6b62-dfa4-46d1-82f8-e09e34d029d6");

enum : GUID
{
    GUID_INTSTEER_SUBGROUP              = GUID("48672f38-7a9a-4bb2-8bf8-3d85be19de4e"),
    GUID_INTSTEER_MODE                  = GUID("2bfc24f9-5ea2-4801-8213-3dbae01aa39d"),
    GUID_INTSTEER_LOAD_PER_PROC_TRIGGER = GUID("73cde64d-d720-4bb2-a860-c755afe77ef2"),
}

enum GUID GUID_INTSTEER_TIME_UNPARK_TRIGGER = GUID("d6ba4903-386f-4c2c-8adb-5c21b3328d25");
enum GUID GUID_GRAPHICS_SUBGROUP = GUID("5fb4938d-1ee8-4b0f-9a3c-5036b0ab995c");
enum GUID GUID_GPU_PREFERENCE_POLICY = GUID("dd848b2a-8a5d-4451-9ae2-39cd41658f6c");
enum GUID GUID_MIXED_REALITY_MODE = GUID("1e626b4e-cf04-4f8d-9cc7-c97c5b0f2391");
enum GUID GUID_SPR_ACTIVE_SESSION_CHANGE = GUID("0e24ce38-c393-4742-bdb1-744f4b9ee08e");
enum uint POWER_SYSTEM_MAXIMUM = 0x00000007U;

enum : uint
{
    DIAGNOSTIC_REASON_VERSION         = 0x00000000U,
    DIAGNOSTIC_REASON_SIMPLE_STRING   = 0x00000001U,
    DIAGNOSTIC_REASON_DETAILED_STRING = 0x00000002U,
    DIAGNOSTIC_REASON_NOT_SPECIFIED   = 0x80000000U,
}

enum uint POWER_REQUEST_CONTEXT_VERSION = 0x00000000U;
enum uint POWER_SETTING_VALUE_VERSION = 0x00000001U;

enum : uint
{
    PROC_IDLE_BUCKET_COUNT    = 0x00000006U,
    PROC_IDLE_BUCKET_COUNT_EX = 0x00000010U,
}

enum : uint
{
    ACPI_PPM_SOFTWARE_ALL = 0x000000fcU,
    ACPI_PPM_SOFTWARE_ANY = 0x000000fdU,
    ACPI_PPM_HARDWARE_ALL = 0x000000feU,
}

enum uint MS_PPM_SOFTWARE_ALL = 0x00000001U;

enum : uint
{
    POWER_ACTION_QUERY_ALLOWED     = 0x00000001U,
    POWER_ACTION_UI_ALLOWED        = 0x00000002U,
    POWER_ACTION_OVERRIDE_APPS     = 0x00000004U,
    POWER_ACTION_HIBERBOOT         = 0x00000008U,
    POWER_ACTION_USER_NOTIFY       = 0x00000010U,
    POWER_ACTION_DOZE_TO_HIBERNATE = 0x00000020U,
    POWER_ACTION_ACPI_CRITICAL     = 0x01000000U,
    POWER_ACTION_ACPI_USER_NOTIFY  = 0x02000000U,
    POWER_ACTION_DIRECTED_DRIPS    = 0x04000000U,
    POWER_ACTION_PSEUDO_TRANSITION = 0x08000000U,
    POWER_ACTION_LIGHTEST_FIRST    = 0x10000000U,
    POWER_ACTION_LOCK_CONSOLE      = 0x20000000U,
    POWER_ACTION_DISABLE_WAKES     = 0x40000000U,
    POWER_ACTION_CRITICAL          = 0x80000000U,
}

enum uint POWER_USER_NOTIFY_FORCED_SHUTDOWN = 0x00000020U;

enum : uint
{
    BATTERY_DISCHARGE_FLAGS_EVENTCODE_MASK = 0x00000007U,
    BATTERY_DISCHARGE_FLAGS_ENABLE         = 0x80000000U,
}

enum uint NUM_DISCHARGE_POLICIES = 0x00000004U;

enum : uint
{
    DISCHARGE_POLICY_CRITICAL = 0x00000000U,
    DISCHARGE_POLICY_LOW      = 0x00000001U,
}

enum uint PROCESSOR_IDLESTATE_POLICY_COUNT = 0x00000003U;

enum : uint
{
    PO_THROTTLE_NONE     = 0x00000000U,
    PO_THROTTLE_CONSTANT = 0x00000001U,
    PO_THROTTLE_DEGRADE  = 0x00000002U,
    PO_THROTTLE_ADAPTIVE = 0x00000003U,
    PO_THROTTLE_MAXIMUM  = 0x00000004U,
}

enum : uint
{
    HIBERFILE_TYPE_NONE    = 0x00000000U,
    HIBERFILE_TYPE_REDUCED = 0x00000001U,
    HIBERFILE_TYPE_FULL    = 0x00000002U,
    HIBERFILE_TYPE_MAX     = 0x00000003U,
}

enum ushort IMAGE_DOS_SIGNATURE = 0x5a4d;

enum : ushort
{
    IMAGE_OS2_SIGNATURE    = 0x454e,
    IMAGE_OS2_SIGNATURE_LE = 0x454c,
}

enum ushort IMAGE_VXD_SIGNATURE = 0x454c;
enum uint IMAGE_NT_SIGNATURE = 0x00004550U;
enum uint IMAGE_SIZEOF_FILE_HEADER = 0x00000014U;
enum uint IMAGE_NUMBEROF_DIRECTORY_ENTRIES = 0x00000010U;

enum : uint
{
    IMAGE_SIZEOF_SHORT_NAME     = 0x00000008U,
    IMAGE_SIZEOF_SECTION_HEADER = 0x00000028U,
    IMAGE_SIZEOF_SYMBOL         = 0x00000012U,
}

enum : uint
{
    IMAGE_SYM_SECTION_MAX            = 0x0000feffU,
    IMAGE_SYM_SECTION_MAX_EX         = 0x7fffffffU,
    IMAGE_SYM_TYPE_NULL              = 0x00000000U,
    IMAGE_SYM_TYPE_VOID              = 0x00000001U,
    IMAGE_SYM_TYPE_CHAR              = 0x00000002U,
    IMAGE_SYM_TYPE_SHORT             = 0x00000003U,
    IMAGE_SYM_TYPE_INT               = 0x00000004U,
    IMAGE_SYM_TYPE_LONG              = 0x00000005U,
    IMAGE_SYM_TYPE_FLOAT             = 0x00000006U,
    IMAGE_SYM_TYPE_DOUBLE            = 0x00000007U,
    IMAGE_SYM_TYPE_STRUCT            = 0x00000008U,
    IMAGE_SYM_TYPE_UNION             = 0x00000009U,
    IMAGE_SYM_TYPE_ENUM              = 0x0000000aU,
    IMAGE_SYM_TYPE_MOE               = 0x0000000bU,
    IMAGE_SYM_TYPE_BYTE              = 0x0000000cU,
    IMAGE_SYM_TYPE_WORD              = 0x0000000dU,
    IMAGE_SYM_TYPE_UINT              = 0x0000000eU,
    IMAGE_SYM_TYPE_DWORD             = 0x0000000fU,
    IMAGE_SYM_TYPE_PCODE             = 0x00008000U,
    IMAGE_SYM_DTYPE_NULL             = 0x00000000U,
    IMAGE_SYM_DTYPE_POINTER          = 0x00000001U,
    IMAGE_SYM_DTYPE_FUNCTION         = 0x00000002U,
    IMAGE_SYM_DTYPE_ARRAY            = 0x00000003U,
    IMAGE_SYM_CLASS_NULL             = 0x00000000U,
    IMAGE_SYM_CLASS_AUTOMATIC        = 0x00000001U,
    IMAGE_SYM_CLASS_EXTERNAL         = 0x00000002U,
    IMAGE_SYM_CLASS_STATIC           = 0x00000003U,
    IMAGE_SYM_CLASS_REGISTER         = 0x00000004U,
    IMAGE_SYM_CLASS_EXTERNAL_DEF     = 0x00000005U,
    IMAGE_SYM_CLASS_LABEL            = 0x00000006U,
    IMAGE_SYM_CLASS_UNDEFINED_LABEL  = 0x00000007U,
    IMAGE_SYM_CLASS_MEMBER_OF_STRUCT = 0x00000008U,
    IMAGE_SYM_CLASS_ARGUMENT         = 0x00000009U,
    IMAGE_SYM_CLASS_STRUCT_TAG       = 0x0000000aU,
    IMAGE_SYM_CLASS_MEMBER_OF_UNION  = 0x0000000bU,
    IMAGE_SYM_CLASS_UNION_TAG        = 0x0000000cU,
    IMAGE_SYM_CLASS_TYPE_DEFINITION  = 0x0000000dU,
    IMAGE_SYM_CLASS_UNDEFINED_STATIC = 0x0000000eU,
    IMAGE_SYM_CLASS_ENUM_TAG         = 0x0000000fU,
    IMAGE_SYM_CLASS_MEMBER_OF_ENUM   = 0x00000010U,
    IMAGE_SYM_CLASS_REGISTER_PARAM   = 0x00000011U,
    IMAGE_SYM_CLASS_BIT_FIELD        = 0x00000012U,
    IMAGE_SYM_CLASS_FAR_EXTERNAL     = 0x00000044U,
    IMAGE_SYM_CLASS_BLOCK            = 0x00000064U,
    IMAGE_SYM_CLASS_FUNCTION         = 0x00000065U,
    IMAGE_SYM_CLASS_END_OF_STRUCT    = 0x00000066U,
    IMAGE_SYM_CLASS_FILE             = 0x00000067U,
    IMAGE_SYM_CLASS_SECTION          = 0x00000068U,
    IMAGE_SYM_CLASS_WEAK_EXTERNAL    = 0x00000069U,
    IMAGE_SYM_CLASS_CLR_TOKEN        = 0x0000006bU,
}

enum uint N_BTMASK = 0x0000000fU;

enum : uint
{
    N_TMASK  = 0x00000030U,
    N_TMASK1 = 0x000000c0U,
    N_TMASK2 = 0x000000f0U,
}

enum uint N_BTSHFT = 0x00000004U;
enum uint N_TSHIFT = 0x00000002U;

enum : uint
{
    IMAGE_COMDAT_SELECT_NODUPLICATES = 0x00000001U,
    IMAGE_COMDAT_SELECT_ANY          = 0x00000002U,
    IMAGE_COMDAT_SELECT_SAME_SIZE    = 0x00000003U,
    IMAGE_COMDAT_SELECT_EXACT_MATCH  = 0x00000004U,
    IMAGE_COMDAT_SELECT_ASSOCIATIVE  = 0x00000005U,
    IMAGE_COMDAT_SELECT_LARGEST      = 0x00000006U,
    IMAGE_COMDAT_SELECT_NEWEST       = 0x00000007U,
}

enum : uint
{
    IMAGE_WEAK_EXTERN_SEARCH_NOLIBRARY = 0x00000001U,
    IMAGE_WEAK_EXTERN_SEARCH_LIBRARY   = 0x00000002U,
    IMAGE_WEAK_EXTERN_SEARCH_ALIAS     = 0x00000003U,
    IMAGE_WEAK_EXTERN_ANTI_DEPENDENCY  = 0x00000004U,
}

enum : uint
{
    IMAGE_REL_I386_ABSOLUTE                    = 0x00000000U,
    IMAGE_REL_I386_DIR16                       = 0x00000001U,
    IMAGE_REL_I386_REL16                       = 0x00000002U,
    IMAGE_REL_I386_DIR32                       = 0x00000006U,
    IMAGE_REL_I386_DIR32NB                     = 0x00000007U,
    IMAGE_REL_I386_SEG12                       = 0x00000009U,
    IMAGE_REL_I386_SECTION                     = 0x0000000aU,
    IMAGE_REL_I386_SECREL                      = 0x0000000bU,
    IMAGE_REL_I386_TOKEN                       = 0x0000000cU,
    IMAGE_REL_I386_SECREL7                     = 0x0000000dU,
    IMAGE_REL_I386_REL32                       = 0x00000014U,
    IMAGE_REL_MIPS_ABSOLUTE                    = 0x00000000U,
    IMAGE_REL_MIPS_REFHALF                     = 0x00000001U,
    IMAGE_REL_MIPS_REFWORD                     = 0x00000002U,
    IMAGE_REL_MIPS_JMPADDR                     = 0x00000003U,
    IMAGE_REL_MIPS_REFHI                       = 0x00000004U,
    IMAGE_REL_MIPS_REFLO                       = 0x00000005U,
    IMAGE_REL_MIPS_GPREL                       = 0x00000006U,
    IMAGE_REL_MIPS_LITERAL                     = 0x00000007U,
    IMAGE_REL_MIPS_SECTION                     = 0x0000000aU,
    IMAGE_REL_MIPS_SECREL                      = 0x0000000bU,
    IMAGE_REL_MIPS_SECRELLO                    = 0x0000000cU,
    IMAGE_REL_MIPS_SECRELHI                    = 0x0000000dU,
    IMAGE_REL_MIPS_TOKEN                       = 0x0000000eU,
    IMAGE_REL_MIPS_JMPADDR16                   = 0x00000010U,
    IMAGE_REL_MIPS_REFWORDNB                   = 0x00000022U,
    IMAGE_REL_MIPS_PAIR                        = 0x00000025U,
    IMAGE_REL_ALPHA_ABSOLUTE                   = 0x00000000U,
    IMAGE_REL_ALPHA_REFLONG                    = 0x00000001U,
    IMAGE_REL_ALPHA_REFQUAD                    = 0x00000002U,
    IMAGE_REL_ALPHA_GPREL32                    = 0x00000003U,
    IMAGE_REL_ALPHA_LITERAL                    = 0x00000004U,
    IMAGE_REL_ALPHA_LITUSE                     = 0x00000005U,
    IMAGE_REL_ALPHA_GPDISP                     = 0x00000006U,
    IMAGE_REL_ALPHA_BRADDR                     = 0x00000007U,
    IMAGE_REL_ALPHA_HINT                       = 0x00000008U,
    IMAGE_REL_ALPHA_INLINE_REFLONG             = 0x00000009U,
    IMAGE_REL_ALPHA_REFHI                      = 0x0000000aU,
    IMAGE_REL_ALPHA_REFLO                      = 0x0000000bU,
    IMAGE_REL_ALPHA_PAIR                       = 0x0000000cU,
    IMAGE_REL_ALPHA_MATCH                      = 0x0000000dU,
    IMAGE_REL_ALPHA_SECTION                    = 0x0000000eU,
    IMAGE_REL_ALPHA_SECREL                     = 0x0000000fU,
    IMAGE_REL_ALPHA_REFLONGNB                  = 0x00000010U,
    IMAGE_REL_ALPHA_SECRELLO                   = 0x00000011U,
    IMAGE_REL_ALPHA_SECRELHI                   = 0x00000012U,
    IMAGE_REL_ALPHA_REFQ3                      = 0x00000013U,
    IMAGE_REL_ALPHA_REFQ2                      = 0x00000014U,
    IMAGE_REL_ALPHA_REFQ1                      = 0x00000015U,
    IMAGE_REL_ALPHA_GPRELLO                    = 0x00000016U,
    IMAGE_REL_ALPHA_GPRELHI                    = 0x00000017U,
    IMAGE_REL_PPC_ABSOLUTE                     = 0x00000000U,
    IMAGE_REL_PPC_ADDR64                       = 0x00000001U,
    IMAGE_REL_PPC_ADDR32                       = 0x00000002U,
    IMAGE_REL_PPC_ADDR24                       = 0x00000003U,
    IMAGE_REL_PPC_ADDR16                       = 0x00000004U,
    IMAGE_REL_PPC_ADDR14                       = 0x00000005U,
    IMAGE_REL_PPC_REL24                        = 0x00000006U,
    IMAGE_REL_PPC_REL14                        = 0x00000007U,
    IMAGE_REL_PPC_TOCREL16                     = 0x00000008U,
    IMAGE_REL_PPC_TOCREL14                     = 0x00000009U,
    IMAGE_REL_PPC_ADDR32NB                     = 0x0000000aU,
    IMAGE_REL_PPC_SECREL                       = 0x0000000bU,
    IMAGE_REL_PPC_SECTION                      = 0x0000000cU,
    IMAGE_REL_PPC_IFGLUE                       = 0x0000000dU,
    IMAGE_REL_PPC_IMGLUE                       = 0x0000000eU,
    IMAGE_REL_PPC_SECREL16                     = 0x0000000fU,
    IMAGE_REL_PPC_REFHI                        = 0x00000010U,
    IMAGE_REL_PPC_REFLO                        = 0x00000011U,
    IMAGE_REL_PPC_PAIR                         = 0x00000012U,
    IMAGE_REL_PPC_SECRELLO                     = 0x00000013U,
    IMAGE_REL_PPC_SECRELHI                     = 0x00000014U,
    IMAGE_REL_PPC_GPREL                        = 0x00000015U,
    IMAGE_REL_PPC_TOKEN                        = 0x00000016U,
    IMAGE_REL_PPC_TYPEMASK                     = 0x000000ffU,
    IMAGE_REL_PPC_NEG                          = 0x00000100U,
    IMAGE_REL_PPC_BRTAKEN                      = 0x00000200U,
    IMAGE_REL_PPC_BRNTAKEN                     = 0x00000400U,
    IMAGE_REL_PPC_TOCDEFN                      = 0x00000800U,
    IMAGE_REL_SH3_ABSOLUTE                     = 0x00000000U,
    IMAGE_REL_SH3_DIRECT16                     = 0x00000001U,
    IMAGE_REL_SH3_DIRECT32                     = 0x00000002U,
    IMAGE_REL_SH3_DIRECT8                      = 0x00000003U,
    IMAGE_REL_SH3_DIRECT8_WORD                 = 0x00000004U,
    IMAGE_REL_SH3_DIRECT8_LONG                 = 0x00000005U,
    IMAGE_REL_SH3_DIRECT4                      = 0x00000006U,
    IMAGE_REL_SH3_DIRECT4_WORD                 = 0x00000007U,
    IMAGE_REL_SH3_DIRECT4_LONG                 = 0x00000008U,
    IMAGE_REL_SH3_PCREL8_WORD                  = 0x00000009U,
    IMAGE_REL_SH3_PCREL8_LONG                  = 0x0000000aU,
    IMAGE_REL_SH3_PCREL12_WORD                 = 0x0000000bU,
    IMAGE_REL_SH3_STARTOF_SECTION              = 0x0000000cU,
    IMAGE_REL_SH3_SIZEOF_SECTION               = 0x0000000dU,
    IMAGE_REL_SH3_SECTION                      = 0x0000000eU,
    IMAGE_REL_SH3_SECREL                       = 0x0000000fU,
    IMAGE_REL_SH3_DIRECT32_NB                  = 0x00000010U,
    IMAGE_REL_SH3_GPREL4_LONG                  = 0x00000011U,
    IMAGE_REL_SH3_TOKEN                        = 0x00000012U,
    IMAGE_REL_SHM_PCRELPT                      = 0x00000013U,
    IMAGE_REL_SHM_REFLO                        = 0x00000014U,
    IMAGE_REL_SHM_REFHALF                      = 0x00000015U,
    IMAGE_REL_SHM_RELLO                        = 0x00000016U,
    IMAGE_REL_SHM_RELHALF                      = 0x00000017U,
    IMAGE_REL_SHM_PAIR                         = 0x00000018U,
    IMAGE_REL_SH_NOMODE                        = 0x00008000U,
    IMAGE_REL_ARM_ABSOLUTE                     = 0x00000000U,
    IMAGE_REL_ARM_ADDR32                       = 0x00000001U,
    IMAGE_REL_ARM_ADDR32NB                     = 0x00000002U,
    IMAGE_REL_ARM_BRANCH24                     = 0x00000003U,
    IMAGE_REL_ARM_BRANCH11                     = 0x00000004U,
    IMAGE_REL_ARM_TOKEN                        = 0x00000005U,
    IMAGE_REL_ARM_GPREL12                      = 0x00000006U,
    IMAGE_REL_ARM_GPREL7                       = 0x00000007U,
    IMAGE_REL_ARM_BLX24                        = 0x00000008U,
    IMAGE_REL_ARM_BLX11                        = 0x00000009U,
    IMAGE_REL_ARM_SECTION                      = 0x0000000eU,
    IMAGE_REL_ARM_SECREL                       = 0x0000000fU,
    IMAGE_REL_ARM_MOV32A                       = 0x00000010U,
    IMAGE_REL_ARM_MOV32                        = 0x00000010U,
    IMAGE_REL_ARM_MOV32T                       = 0x00000011U,
    IMAGE_REL_THUMB_MOV32                      = 0x00000011U,
    IMAGE_REL_ARM_BRANCH20T                    = 0x00000012U,
    IMAGE_REL_THUMB_BRANCH20                   = 0x00000012U,
    IMAGE_REL_ARM_BRANCH24T                    = 0x00000014U,
    IMAGE_REL_THUMB_BRANCH24                   = 0x00000014U,
    IMAGE_REL_ARM_BLX23T                       = 0x00000015U,
    IMAGE_REL_THUMB_BLX23                      = 0x00000015U,
    IMAGE_REL_AM_ABSOLUTE                      = 0x00000000U,
    IMAGE_REL_AM_ADDR32                        = 0x00000001U,
    IMAGE_REL_AM_ADDR32NB                      = 0x00000002U,
    IMAGE_REL_AM_CALL32                        = 0x00000003U,
    IMAGE_REL_AM_FUNCINFO                      = 0x00000004U,
    IMAGE_REL_AM_REL32_1                       = 0x00000005U,
    IMAGE_REL_AM_REL32_2                       = 0x00000006U,
    IMAGE_REL_AM_SECREL                        = 0x00000007U,
    IMAGE_REL_AM_SECTION                       = 0x00000008U,
    IMAGE_REL_AM_TOKEN                         = 0x00000009U,
    IMAGE_REL_ARM64_ABSOLUTE                   = 0x00000000U,
    IMAGE_REL_ARM64_ADDR32                     = 0x00000001U,
    IMAGE_REL_ARM64_ADDR32NB                   = 0x00000002U,
    IMAGE_REL_ARM64_BRANCH26                   = 0x00000003U,
    IMAGE_REL_ARM64_PAGEBASE_REL21             = 0x00000004U,
    IMAGE_REL_ARM64_REL21                      = 0x00000005U,
    IMAGE_REL_ARM64_PAGEOFFSET_12A             = 0x00000006U,
    IMAGE_REL_ARM64_PAGEOFFSET_12L             = 0x00000007U,
    IMAGE_REL_ARM64_SECREL                     = 0x00000008U,
    IMAGE_REL_ARM64_SECREL_LOW12A              = 0x00000009U,
    IMAGE_REL_ARM64_SECREL_HIGH12A             = 0x0000000aU,
    IMAGE_REL_ARM64_SECREL_LOW12L              = 0x0000000bU,
    IMAGE_REL_ARM64_TOKEN                      = 0x0000000cU,
    IMAGE_REL_ARM64_SECTION                    = 0x0000000dU,
    IMAGE_REL_ARM64_ADDR64                     = 0x0000000eU,
    IMAGE_REL_ARM64_BRANCH19                   = 0x0000000fU,
    IMAGE_REL_AMD64_ABSOLUTE                   = 0x00000000U,
    IMAGE_REL_AMD64_ADDR64                     = 0x00000001U,
    IMAGE_REL_AMD64_ADDR32                     = 0x00000002U,
    IMAGE_REL_AMD64_ADDR32NB                   = 0x00000003U,
    IMAGE_REL_AMD64_REL32                      = 0x00000004U,
    IMAGE_REL_AMD64_REL32_1                    = 0x00000005U,
    IMAGE_REL_AMD64_REL32_2                    = 0x00000006U,
    IMAGE_REL_AMD64_REL32_3                    = 0x00000007U,
    IMAGE_REL_AMD64_REL32_4                    = 0x00000008U,
    IMAGE_REL_AMD64_REL32_5                    = 0x00000009U,
    IMAGE_REL_AMD64_SECTION                    = 0x0000000aU,
    IMAGE_REL_AMD64_SECREL                     = 0x0000000bU,
    IMAGE_REL_AMD64_SECREL7                    = 0x0000000cU,
    IMAGE_REL_AMD64_TOKEN                      = 0x0000000dU,
    IMAGE_REL_AMD64_SREL32                     = 0x0000000eU,
    IMAGE_REL_AMD64_PAIR                       = 0x0000000fU,
    IMAGE_REL_AMD64_SSPAN32                    = 0x00000010U,
    IMAGE_REL_AMD64_EHANDLER                   = 0x00000011U,
    IMAGE_REL_AMD64_IMPORT_BR                  = 0x00000012U,
    IMAGE_REL_AMD64_IMPORT_CALL                = 0x00000013U,
    IMAGE_REL_AMD64_CFG_BR                     = 0x00000014U,
    IMAGE_REL_AMD64_CFG_BR_REX                 = 0x00000015U,
    IMAGE_REL_AMD64_CFG_CALL                   = 0x00000016U,
    IMAGE_REL_AMD64_INDIR_BR                   = 0x00000017U,
    IMAGE_REL_AMD64_INDIR_BR_REX               = 0x00000018U,
    IMAGE_REL_AMD64_INDIR_CALL                 = 0x00000019U,
    IMAGE_REL_AMD64_INDIR_BR_SWITCHTABLE_FIRST = 0x00000020U,
    IMAGE_REL_AMD64_INDIR_BR_SWITCHTABLE_LAST  = 0x0000002fU,
}

enum : uint
{
    IMAGE_REL_IA64_ABSOLUTE   = 0x00000000U,
    IMAGE_REL_IA64_IMM14      = 0x00000001U,
    IMAGE_REL_IA64_IMM22      = 0x00000002U,
    IMAGE_REL_IA64_IMM64      = 0x00000003U,
    IMAGE_REL_IA64_DIR32      = 0x00000004U,
    IMAGE_REL_IA64_DIR64      = 0x00000005U,
    IMAGE_REL_IA64_PCREL21B   = 0x00000006U,
    IMAGE_REL_IA64_PCREL21M   = 0x00000007U,
    IMAGE_REL_IA64_PCREL21F   = 0x00000008U,
    IMAGE_REL_IA64_GPREL22    = 0x00000009U,
    IMAGE_REL_IA64_LTOFF22    = 0x0000000aU,
    IMAGE_REL_IA64_SECTION    = 0x0000000bU,
    IMAGE_REL_IA64_SECREL22   = 0x0000000cU,
    IMAGE_REL_IA64_SECREL64I  = 0x0000000dU,
    IMAGE_REL_IA64_SECREL32   = 0x0000000eU,
    IMAGE_REL_IA64_DIR32NB    = 0x00000010U,
    IMAGE_REL_IA64_SREL14     = 0x00000011U,
    IMAGE_REL_IA64_SREL22     = 0x00000012U,
    IMAGE_REL_IA64_SREL32     = 0x00000013U,
    IMAGE_REL_IA64_UREL32     = 0x00000014U,
    IMAGE_REL_IA64_PCREL60X   = 0x00000015U,
    IMAGE_REL_IA64_PCREL60B   = 0x00000016U,
    IMAGE_REL_IA64_PCREL60F   = 0x00000017U,
    IMAGE_REL_IA64_PCREL60I   = 0x00000018U,
    IMAGE_REL_IA64_PCREL60M   = 0x00000019U,
    IMAGE_REL_IA64_IMMGPREL64 = 0x0000001aU,
    IMAGE_REL_IA64_TOKEN      = 0x0000001bU,
    IMAGE_REL_IA64_GPREL32    = 0x0000001cU,
    IMAGE_REL_IA64_ADDEND     = 0x0000001fU,
    IMAGE_REL_CEF_ABSOLUTE    = 0x00000000U,
    IMAGE_REL_CEF_ADDR32      = 0x00000001U,
    IMAGE_REL_CEF_ADDR64      = 0x00000002U,
    IMAGE_REL_CEF_ADDR32NB    = 0x00000003U,
    IMAGE_REL_CEF_SECTION     = 0x00000004U,
    IMAGE_REL_CEF_SECREL      = 0x00000005U,
    IMAGE_REL_CEF_TOKEN       = 0x00000006U,
    IMAGE_REL_CEE_ABSOLUTE    = 0x00000000U,
    IMAGE_REL_CEE_ADDR32      = 0x00000001U,
    IMAGE_REL_CEE_ADDR64      = 0x00000002U,
    IMAGE_REL_CEE_ADDR32NB    = 0x00000003U,
    IMAGE_REL_CEE_SECTION     = 0x00000004U,
    IMAGE_REL_CEE_SECREL      = 0x00000005U,
    IMAGE_REL_CEE_TOKEN       = 0x00000006U,
    IMAGE_REL_M32R_ABSOLUTE   = 0x00000000U,
    IMAGE_REL_M32R_ADDR32     = 0x00000001U,
    IMAGE_REL_M32R_ADDR32NB   = 0x00000002U,
    IMAGE_REL_M32R_ADDR24     = 0x00000003U,
    IMAGE_REL_M32R_GPREL16    = 0x00000004U,
    IMAGE_REL_M32R_PCREL24    = 0x00000005U,
    IMAGE_REL_M32R_PCREL16    = 0x00000006U,
    IMAGE_REL_M32R_PCREL8     = 0x00000007U,
    IMAGE_REL_M32R_REFHALF    = 0x00000008U,
    IMAGE_REL_M32R_REFHI      = 0x00000009U,
    IMAGE_REL_M32R_REFLO      = 0x0000000aU,
    IMAGE_REL_M32R_PAIR       = 0x0000000bU,
    IMAGE_REL_M32R_SECTION    = 0x0000000cU,
    IMAGE_REL_M32R_SECREL32   = 0x0000000dU,
    IMAGE_REL_M32R_TOKEN      = 0x0000000eU,
    IMAGE_REL_EBC_ABSOLUTE    = 0x00000000U,
    IMAGE_REL_EBC_ADDR32NB    = 0x00000001U,
    IMAGE_REL_EBC_REL32       = 0x00000002U,
    IMAGE_REL_EBC_SECTION     = 0x00000003U,
    IMAGE_REL_EBC_SECREL      = 0x00000004U,
}

enum : uint
{
    EMARCH_ENC_I17_IMM7B_INST_WORD_X      = 0x00000003U,
    EMARCH_ENC_I17_IMM7B_SIZE_X           = 0x00000007U,
    EMARCH_ENC_I17_IMM7B_INST_WORD_POS_X  = 0x00000004U,
    EMARCH_ENC_I17_IMM7B_VAL_POS_X        = 0x00000000U,
    EMARCH_ENC_I17_IMM9D_INST_WORD_X      = 0x00000003U,
    EMARCH_ENC_I17_IMM9D_SIZE_X           = 0x00000009U,
    EMARCH_ENC_I17_IMM9D_INST_WORD_POS_X  = 0x00000012U,
    EMARCH_ENC_I17_IMM9D_VAL_POS_X        = 0x00000007U,
    EMARCH_ENC_I17_IMM5C_INST_WORD_X      = 0x00000003U,
    EMARCH_ENC_I17_IMM5C_SIZE_X           = 0x00000005U,
    EMARCH_ENC_I17_IMM5C_INST_WORD_POS_X  = 0x0000000dU,
    EMARCH_ENC_I17_IMM5C_VAL_POS_X        = 0x00000010U,
    EMARCH_ENC_I17_IC_INST_WORD_X         = 0x00000003U,
    EMARCH_ENC_I17_IC_SIZE_X              = 0x00000001U,
    EMARCH_ENC_I17_IC_INST_WORD_POS_X     = 0x0000000cU,
    EMARCH_ENC_I17_IC_VAL_POS_X           = 0x00000015U,
    EMARCH_ENC_I17_IMM41a_INST_WORD_X     = 0x00000001U,
    EMARCH_ENC_I17_IMM41a_SIZE_X          = 0x0000000aU,
    EMARCH_ENC_I17_IMM41a_INST_WORD_POS_X = 0x0000000eU,
    EMARCH_ENC_I17_IMM41a_VAL_POS_X       = 0x00000016U,
    EMARCH_ENC_I17_IMM41b_INST_WORD_X     = 0x00000001U,
    EMARCH_ENC_I17_IMM41b_SIZE_X          = 0x00000008U,
    EMARCH_ENC_I17_IMM41b_INST_WORD_POS_X = 0x00000018U,
    EMARCH_ENC_I17_IMM41b_VAL_POS_X       = 0x00000020U,
    EMARCH_ENC_I17_IMM41c_INST_WORD_X     = 0x00000002U,
    EMARCH_ENC_I17_IMM41c_SIZE_X          = 0x00000017U,
    EMARCH_ENC_I17_IMM41c_INST_WORD_POS_X = 0x00000000U,
    EMARCH_ENC_I17_IMM41c_VAL_POS_X       = 0x00000028U,
    EMARCH_ENC_I17_SIGN_INST_WORD_X       = 0x00000003U,
    EMARCH_ENC_I17_SIGN_SIZE_X            = 0x00000001U,
    EMARCH_ENC_I17_SIGN_INST_WORD_POS_X   = 0x0000001bU,
    EMARCH_ENC_I17_SIGN_VAL_POS_X         = 0x0000003fU,
}

enum : uint
{
    X3_OPCODE_INST_WORD_X     = 0x00000003U,
    X3_OPCODE_SIZE_X          = 0x00000004U,
    X3_OPCODE_INST_WORD_POS_X = 0x0000001cU,
}

enum uint X3_OPCODE_SIGN_VAL_POS_X = 0x00000000U;
enum uint X3_I_INST_WORD_X = 0x00000003U;

enum : uint
{
    X3_I_SIZE_X          = 0x00000001U,
    X3_I_INST_WORD_POS_X = 0x0000001bU,
}

enum uint X3_I_SIGN_VAL_POS_X = 0x0000003bU;

enum : uint
{
    X3_D_WH_INST_WORD_X     = 0x00000003U,
    X3_D_WH_SIZE_X          = 0x00000003U,
    X3_D_WH_INST_WORD_POS_X = 0x00000018U,
}

enum uint X3_D_WH_SIGN_VAL_POS_X = 0x00000000U;

enum : uint
{
    X3_IMM20_INST_WORD_X     = 0x00000003U,
    X3_IMM20_SIZE_X          = 0x00000014U,
    X3_IMM20_INST_WORD_POS_X = 0x00000004U,
}

enum uint X3_IMM20_SIGN_VAL_POS_X = 0x00000000U;

enum : uint
{
    X3_IMM39_1_INST_WORD_X     = 0x00000002U,
    X3_IMM39_1_SIZE_X          = 0x00000017U,
    X3_IMM39_1_INST_WORD_POS_X = 0x00000000U,
    X3_IMM39_1_SIGN_VAL_POS_X  = 0x00000024U,
}

enum : uint
{
    X3_IMM39_2_INST_WORD_X     = 0x00000001U,
    X3_IMM39_2_SIZE_X          = 0x00000010U,
    X3_IMM39_2_INST_WORD_POS_X = 0x00000010U,
    X3_IMM39_2_SIGN_VAL_POS_X  = 0x00000014U,
}

enum uint X3_P_INST_WORD_X = 0x00000003U;

enum : uint
{
    X3_P_SIZE_X          = 0x00000004U,
    X3_P_INST_WORD_POS_X = 0x00000000U,
}

enum uint X3_P_SIGN_VAL_POS_X = 0x00000000U;

enum : uint
{
    X3_TMPLT_INST_WORD_X     = 0x00000000U,
    X3_TMPLT_SIZE_X          = 0x00000004U,
    X3_TMPLT_INST_WORD_POS_X = 0x00000000U,
}

enum uint X3_TMPLT_SIGN_VAL_POS_X = 0x00000000U;

enum : uint
{
    X3_BTYPE_QP_INST_WORD_X     = 0x00000002U,
    X3_BTYPE_QP_SIZE_X          = 0x00000009U,
    X3_BTYPE_QP_INST_WORD_POS_X = 0x00000017U,
    X3_BTYPE_QP_INST_VAL_POS_X  = 0x00000000U,
}

enum : uint
{
    X3_EMPTY_INST_WORD_X     = 0x00000001U,
    X3_EMPTY_SIZE_X          = 0x00000002U,
    X3_EMPTY_INST_WORD_POS_X = 0x0000000eU,
    X3_EMPTY_INST_VAL_POS_X  = 0x00000000U,
}

enum : uint
{
    IMAGE_REL_BASED_ABSOLUTE           = 0x00000000U,
    IMAGE_REL_BASED_HIGH               = 0x00000001U,
    IMAGE_REL_BASED_LOW                = 0x00000002U,
    IMAGE_REL_BASED_HIGHLOW            = 0x00000003U,
    IMAGE_REL_BASED_HIGHADJ            = 0x00000004U,
    IMAGE_REL_BASED_MACHINE_SPECIFIC_5 = 0x00000005U,
    IMAGE_REL_BASED_RESERVED           = 0x00000006U,
    IMAGE_REL_BASED_MACHINE_SPECIFIC_7 = 0x00000007U,
    IMAGE_REL_BASED_MACHINE_SPECIFIC_8 = 0x00000008U,
    IMAGE_REL_BASED_MACHINE_SPECIFIC_9 = 0x00000009U,
    IMAGE_REL_BASED_DIR64              = 0x0000000aU,
    IMAGE_REL_BASED_IA64_IMM64         = 0x00000009U,
    IMAGE_REL_BASED_MIPS_JMPADDR       = 0x00000005U,
    IMAGE_REL_BASED_MIPS_JMPADDR16     = 0x00000009U,
    IMAGE_REL_BASED_ARM_MOV32          = 0x00000005U,
    IMAGE_REL_BASED_THUMB_MOV32        = 0x00000007U,
}

enum uint IMAGE_ARCHIVE_START_SIZE = 0x00000008U;

enum : const(wchar)*
{
    // Native encoding: ansi
    IMAGE_ARCHIVE_START            = "!<arch>
",
    // Native encoding: ansi
    IMAGE_ARCHIVE_END              = "`
",
    // Native encoding: ansi
    IMAGE_ARCHIVE_PAD              = "
",
    // Native encoding: ansi
    IMAGE_ARCHIVE_LINKER_MEMBER    = "/               ",
    // Native encoding: ansi
    IMAGE_ARCHIVE_LONGNAMES_MEMBER = "//              ",
    // Native encoding: ansi
    IMAGE_ARCHIVE_HYBRIDMAP_MEMBER = "/<HYBRIDMAP>/   ",
}

enum uint IMAGE_SIZEOF_ARCHIVE_MEMBER_HDR = 0x0000003cU;
enum ulong IMAGE_ORDINAL_FLAG64 = 0x8000000000000000UL;
enum uint IMAGE_ORDINAL_FLAG32 = 0x80000000U;

enum : uint
{
    IMAGE_RESOURCE_NAME_IS_STRING    = 0x80000000U,
    IMAGE_RESOURCE_DATA_IS_DIRECTORY = 0x80000000U,
}

enum : uint
{
    IMAGE_DYNAMIC_RELOCATION_GUARD_RF_PROLOGUE                 = 0x00000001U,
    IMAGE_DYNAMIC_RELOCATION_GUARD_RF_EPILOGUE                 = 0x00000002U,
    IMAGE_DYNAMIC_RELOCATION_GUARD_IMPORT_CONTROL_TRANSFER     = 0x00000003U,
    IMAGE_DYNAMIC_RELOCATION_GUARD_INDIR_CONTROL_TRANSFER      = 0x00000004U,
    IMAGE_DYNAMIC_RELOCATION_GUARD_SWITCHTABLE_BRANCH          = 0x00000005U,
    IMAGE_DYNAMIC_RELOCATION_FUNCTION_OVERRIDE                 = 0x00000007U,
    IMAGE_DYNAMIC_RELOCATION_ARM64_KERNEL_IMPORT_CALL_TRANSFER = 0x00000008U,
    IMAGE_DYNAMIC_RELOCATION_IMPORT_CONTROL_TRANSFER           = 0x00000003U,
}

enum : uint
{
    IMAGE_FUNCTION_OVERRIDE_INVALID        = 0x00000000U,
    IMAGE_FUNCTION_OVERRIDE_X64_REL32      = 0x00000001U,
    IMAGE_FUNCTION_OVERRIDE_ARM64_BRANCH26 = 0x00000002U,
    IMAGE_FUNCTION_OVERRIDE_ARM64_THUNK    = 0x00000003U,
}

enum : uint
{
    IMAGE_HOT_PATCH_INFO_FLAG_PATCHORDERCRITICAL = 0x00000001U,
    IMAGE_HOT_PATCH_INFO_FLAG_HOTSWAP            = 0x00000002U,
    IMAGE_HOT_PATCH_BASE_OBLIGATORY              = 0x00000001U,
    IMAGE_HOT_PATCH_BASE_CAN_ROLL_BACK           = 0x00000002U,
    IMAGE_HOT_PATCH_BASE_MACHINE_I386            = 0x00000004U,
    IMAGE_HOT_PATCH_BASE_MACHINE_ARM64           = 0x00000008U,
    IMAGE_HOT_PATCH_BASE_MACHINE_AMD64           = 0x00000010U,
    IMAGE_HOT_PATCH_CHUNK_INVERSE                = 0x80000000U,
    IMAGE_HOT_PATCH_CHUNK_OBLIGATORY             = 0x40000000U,
    IMAGE_HOT_PATCH_CHUNK_RESERVED               = 0x3ff03000U,
    IMAGE_HOT_PATCH_CHUNK_TYPE                   = 0x000fc000U,
    IMAGE_HOT_PATCH_CHUNK_SOURCE_RVA             = 0x00008000U,
    IMAGE_HOT_PATCH_CHUNK_TARGET_RVA             = 0x00004000U,
    IMAGE_HOT_PATCH_CHUNK_SIZE                   = 0x00000fffU,
    IMAGE_HOT_PATCH_NONE                         = 0x00000000U,
    IMAGE_HOT_PATCH_FUNCTION                     = 0x0001c000U,
    IMAGE_HOT_PATCH_ABSOLUTE                     = 0x0002c000U,
    IMAGE_HOT_PATCH_REL32                        = 0x0003c000U,
    IMAGE_HOT_PATCH_CALL_TARGET                  = 0x00044000U,
    IMAGE_HOT_PATCH_INDIRECT                     = 0x0005c000U,
    IMAGE_HOT_PATCH_NO_CALL_TARGET               = 0x00064000U,
    IMAGE_HOT_PATCH_DYNAMIC_VALUE                = 0x00078000U,
}

enum : uint
{
    IMAGE_GUARD_CF_INSTRUMENTED           = 0x00000100U,
    IMAGE_GUARD_CFW_INSTRUMENTED          = 0x00000200U,
    IMAGE_GUARD_CF_FUNCTION_TABLE_PRESENT = 0x00000400U,
}

enum uint IMAGE_GUARD_SECURITY_COOKIE_UNUSED = 0x00000800U;
enum uint IMAGE_GUARD_PROTECT_DELAYLOAD_IAT = 0x00001000U;
enum uint IMAGE_GUARD_DELAYLOAD_IAT_IN_ITS_OWN_SECTION = 0x00002000U;
enum uint IMAGE_GUARD_CF_EXPORT_SUPPRESSION_INFO_PRESENT = 0x00004000U;
enum uint IMAGE_GUARD_CF_ENABLE_EXPORT_SUPPRESSION = 0x00008000U;
enum uint IMAGE_GUARD_CF_LONGJUMP_TABLE_PRESENT = 0x00010000U;

enum : uint
{
    IMAGE_GUARD_RF_INSTRUMENTED               = 0x00020000U,
    IMAGE_GUARD_RF_ENABLE                     = 0x00040000U,
    IMAGE_GUARD_RF_STRICT                     = 0x00080000U,
    IMAGE_GUARD_RETPOLINE_PRESENT             = 0x00100000U,
    IMAGE_GUARD_EH_CONTINUATION_TABLE_PRESENT = 0x00400000U,
}

enum : uint
{
    IMAGE_GUARD_XFG_ENABLED                  = 0x00800000U,
    IMAGE_GUARD_CASTGUARD_PRESENT            = 0x01000000U,
    IMAGE_GUARD_MEMCPY_PRESENT               = 0x02000000U,
    IMAGE_GUARD_CF_FUNCTION_TABLE_SIZE_MASK  = 0xf0000000U,
    IMAGE_GUARD_CF_FUNCTION_TABLE_SIZE_SHIFT = 0x0000001cU,
}

enum : uint
{
    IMAGE_GUARD_FLAG_FID_SUPPRESSED       = 0x00000001U,
    IMAGE_GUARD_FLAG_EXPORT_SUPPRESSED    = 0x00000002U,
    IMAGE_GUARD_FLAG_FID_LANGEXCPTHANDLER = 0x00000004U,
    IMAGE_GUARD_FLAG_FID_XFG              = 0x00000008U,
}

enum : uint
{
    IMAGE_ENCLAVE_LONG_ID_LENGTH         = 0x00000020U,
    IMAGE_ENCLAVE_SHORT_ID_LENGTH        = 0x00000010U,
    IMAGE_ENCLAVE_POLICY_DEBUGGABLE      = 0x00000001U,
    IMAGE_ENCLAVE_POLICY_STRICT_MEMORY   = 0x00000002U,
    IMAGE_ENCLAVE_FLAG_PRIMARY_IMAGE     = 0x00000001U,
    IMAGE_ENCLAVE_IMPORT_MATCH_NONE      = 0x00000000U,
    IMAGE_ENCLAVE_IMPORT_MATCH_UNIQUE_ID = 0x00000001U,
    IMAGE_ENCLAVE_IMPORT_MATCH_AUTHOR_ID = 0x00000002U,
    IMAGE_ENCLAVE_IMPORT_MATCH_FAMILY_ID = 0x00000003U,
    IMAGE_ENCLAVE_IMPORT_MATCH_IMAGE_ID  = 0x00000004U,
}

enum : uint
{
    IMAGE_DEBUG_TYPE_OMAP_TO_SRC           = 0x00000007U,
    IMAGE_DEBUG_TYPE_OMAP_FROM_SRC         = 0x00000008U,
    IMAGE_DEBUG_TYPE_RESERVED10            = 0x0000000aU,
    IMAGE_DEBUG_TYPE_BBT                   = 0x0000000aU,
    IMAGE_DEBUG_TYPE_CLSID                 = 0x0000000bU,
    IMAGE_DEBUG_TYPE_VC_FEATURE            = 0x0000000cU,
    IMAGE_DEBUG_TYPE_POGO                  = 0x0000000dU,
    IMAGE_DEBUG_TYPE_ILTCG                 = 0x0000000eU,
    IMAGE_DEBUG_TYPE_MPX                   = 0x0000000fU,
    IMAGE_DEBUG_TYPE_REPRO                 = 0x00000010U,
    IMAGE_DEBUG_TYPE_SPGO                  = 0x00000012U,
    IMAGE_DEBUG_TYPE_EX_DLLCHARACTERISTICS = 0x00000014U,
}

enum : uint
{
    FRAME_FPO    = 0x00000000U,
    FRAME_TRAP   = 0x00000001U,
    FRAME_TSS    = 0x00000002U,
    FRAME_NONFPO = 0x00000003U,
}

enum uint SIZEOF_RFPO_DATA = 0x00000010U;
enum uint IMAGE_DEBUG_MISC_EXENAME = 0x00000001U;
enum uint IMAGE_SEPARATE_DEBUG_SIGNATURE = 0x00004944U;
enum uint NON_PAGED_DEBUG_SIGNATURE = 0x0000494eU;

enum : uint
{
    IMAGE_SEPARATE_DEBUG_FLAGS_MASK = 0x00008000U,
    IMAGE_SEPARATE_DEBUG_MISMATCH   = 0x00008000U,
}

enum uint IMPORT_OBJECT_HDR_SIG2 = 0x0000ffffU;
enum uint UNWIND_HISTORY_TABLE_SIZE = 0x0000000cU;
enum uint FAST_FAIL_LEGACY_GS_VIOLATION = 0x00000000U;
enum uint FAST_FAIL_VTGUARD_CHECK_FAILURE = 0x00000001U;
enum uint FAST_FAIL_STACK_COOKIE_CHECK_FAILURE = 0x00000002U;
enum uint FAST_FAIL_CORRUPT_LIST_ENTRY = 0x00000003U;

enum : uint
{
    FAST_FAIL_INCORRECT_STACK     = 0x00000004U,
    FAST_FAIL_INVALID_ARG         = 0x00000005U,
    FAST_FAIL_GS_COOKIE_INIT      = 0x00000006U,
    FAST_FAIL_FATAL_APP_EXIT      = 0x00000007U,
    FAST_FAIL_RANGE_CHECK_FAILURE = 0x00000008U,
}

enum uint FAST_FAIL_UNSAFE_REGISTRY_ACCESS = 0x00000009U;

enum : uint
{
    FAST_FAIL_GUARD_ICALL_CHECK_FAILURE = 0x0000000aU,
    FAST_FAIL_GUARD_WRITE_CHECK_FAILURE = 0x0000000bU,
}

enum : uint
{
    FAST_FAIL_INVALID_FIBER_SWITCH    = 0x0000000cU,
    FAST_FAIL_INVALID_SET_OF_CONTEXT  = 0x0000000dU,
    FAST_FAIL_INVALID_REFERENCE_COUNT = 0x0000000eU,
    FAST_FAIL_INVALID_JUMP_BUFFER     = 0x00000012U,
}

enum uint FAST_FAIL_MRDATA_MODIFIED = 0x00000013U;
enum uint FAST_FAIL_CERTIFICATION_FAILURE = 0x00000014U;
enum uint FAST_FAIL_INVALID_EXCEPTION_CHAIN = 0x00000015U;

enum : uint
{
    FAST_FAIL_CRYPTO_LIBRARY              = 0x00000016U,
    FAST_FAIL_INVALID_CALL_IN_DLL_CALLOUT = 0x00000017U,
    FAST_FAIL_INVALID_IMAGE_BASE          = 0x00000018U,
}

enum uint FAST_FAIL_DLOAD_PROTECTION_FAILURE = 0x00000019U;
enum uint FAST_FAIL_UNSAFE_EXTENSION_CALL = 0x0000001aU;
enum uint FAST_FAIL_DEPRECATED_SERVICE_INVOKED = 0x0000001bU;

enum : uint
{
    FAST_FAIL_INVALID_BUFFER_ACCESS = 0x0000001cU,
    FAST_FAIL_INVALID_BALANCED_TREE = 0x0000001dU,
    FAST_FAIL_INVALID_NEXT_THREAD   = 0x0000001eU,
}

enum uint FAST_FAIL_GUARD_ICALL_CHECK_SUPPRESSED = 0x0000001fU;

enum : uint
{
    FAST_FAIL_APCS_DISABLED      = 0x00000020U,
    FAST_FAIL_INVALID_IDLE_STATE = 0x00000021U,
}

enum uint FAST_FAIL_MRDATA_PROTECTION_FAILURE = 0x00000022U;
enum uint FAST_FAIL_UNEXPECTED_HEAP_EXCEPTION = 0x00000023U;
enum uint FAST_FAIL_INVALID_LOCK_STATE = 0x00000024U;
enum uint FAST_FAIL_GUARD_JUMPTABLE = 0x00000025U;

enum : uint
{
    FAST_FAIL_INVALID_LONGJUMP_TARGET  = 0x00000026U,
    FAST_FAIL_INVALID_DISPATCH_CONTEXT = 0x00000027U,
    FAST_FAIL_INVALID_THREAD           = 0x00000028U,
    FAST_FAIL_INVALID_SYSCALL_NUMBER   = 0x00000029U,
    FAST_FAIL_INVALID_FILE_OPERATION   = 0x0000002aU,
}

enum uint FAST_FAIL_LPAC_ACCESS_DENIED = 0x0000002bU;
enum uint FAST_FAIL_GUARD_SS_FAILURE = 0x0000002cU;
enum uint FAST_FAIL_LOADER_CONTINUITY_FAILURE = 0x0000002dU;
enum uint FAST_FAIL_GUARD_EXPORT_SUPPRESSION_FAILURE = 0x0000002eU;
enum uint FAST_FAIL_INVALID_CONTROL_STACK = 0x0000002fU;
enum uint FAST_FAIL_SET_CONTEXT_DENIED = 0x00000030U;

enum : uint
{
    FAST_FAIL_INVALID_IAT              = 0x00000031U,
    FAST_FAIL_HEAP_METADATA_CORRUPTION = 0x00000032U,
}

enum uint FAST_FAIL_PAYLOAD_RESTRICTION_VIOLATION = 0x00000033U;
enum uint FAST_FAIL_LOW_LABEL_ACCESS_DENIED = 0x00000034U;
enum uint FAST_FAIL_ENCLAVE_CALL_FAILURE = 0x00000035U;
enum uint FAST_FAIL_UNHANDLED_LSS_EXCEPTON = 0x00000036U;
enum uint FAST_FAIL_ADMINLESS_ACCESS_DENIED = 0x00000037U;
enum uint FAST_FAIL_UNEXPECTED_CALL = 0x00000038U;
enum uint FAST_FAIL_CONTROL_INVALID_RETURN_ADDRESS = 0x00000039U;
enum uint FAST_FAIL_UNEXPECTED_HOST_BEHAVIOR = 0x0000003aU;
enum uint FAST_FAIL_FLAGS_CORRUPTION = 0x0000003bU;

enum : uint
{
    FAST_FAIL_VEH_CORRUPTION                = 0x0000003cU,
    FAST_FAIL_ETW_CORRUPTION                = 0x0000003dU,
    FAST_FAIL_RIO_ABORT                     = 0x0000003eU,
    FAST_FAIL_INVALID_PFN                   = 0x0000003fU,
    FAST_FAIL_GUARD_ICALL_CHECK_FAILURE_XFG = 0x00000040U,
}

enum : uint
{
    FAST_FAIL_CAST_GUARD             = 0x00000041U,
    FAST_FAIL_HOST_VISIBILITY_CHANGE = 0x00000042U,
}

enum uint FAST_FAIL_KERNEL_CET_SHADOW_STACK_ASSIST = 0x00000043U;
enum uint FAST_FAIL_PATCH_CALLBACK_FAILED = 0x00000044U;
enum uint FAST_FAIL_NTDLL_PATCH_FAILED = 0x00000045U;
enum uint FAST_FAIL_INVALID_FLS_DATA = 0x00000046U;

enum : uint
{
    FAST_FAIL_ASAN_ERROR        = 0x00000047U,
    FAST_FAIL_CLR_EXCEPTION_AOT = 0x00000048U,
}

enum uint FAST_FAIL_POINTER_AUTH_INVALID_RETURN_ADDRESS = 0x00000049U;
enum uint FAST_FAIL_INVALID_THREAD_STATE = 0x0000004aU;
enum uint FAST_FAIL_CORRUPT_WOW64_STATE = 0x0000004bU;
enum uint FAST_FAIL_INVALID_EXTENDED_STATE = 0x0000004cU;
enum uint FAST_FAIL_KERNEL_POINTER_EXPECTED = 0x0000004dU;
enum uint FAST_FAIL_INVALID_FAST_FAIL_CODE = 0xffffffffU;

enum : uint
{
    IS_TEXT_UNICODE_DBCS_LEADBYTE = 0x00000400U,
    IS_TEXT_UNICODE_UTF8          = 0x00000800U,
}

enum : uint
{
    COMPRESSION_ENGINE_STANDARD = 0x00000000U,
    COMPRESSION_ENGINE_MAXIMUM  = 0x00000100U,
    COMPRESSION_ENGINE_HIBER    = 0x00000200U,
}

enum uint SEF_AI_USE_EXTRA_PARAMS = 0x00000800U;
enum uint SEF_FORCE_USER_MODE = 0x00002000U;
enum uint SEF_NORMALIZE_OUTPUT_DESCRIPTOR = 0x00004000U;

enum : uint
{
    MESSAGE_RESOURCE_UNICODE = 0x00000001U,
    MESSAGE_RESOURCE_UTF8    = 0x00000002U,
}

enum : uint
{
    VER_EQUAL         = 0x00000001U,
    VER_GREATER       = 0x00000002U,
    VER_GREATER_EQUAL = 0x00000003U,
}

enum : uint
{
    VER_LESS       = 0x00000004U,
    VER_LESS_EQUAL = 0x00000005U,
}

enum : uint
{
    VER_AND            = 0x00000006U,
    VER_OR             = 0x00000007U,
    VER_CONDITION_MASK = 0x00000007U,
}

enum uint VER_NUM_BITS_PER_CONDITION_MASK = 0x00000003U;
enum uint VER_NT_WORKSTATION = 0x00000001U;
enum uint VER_NT_DOMAIN_CONTROLLER = 0x00000002U;
enum uint VER_NT_SERVER = 0x00000003U;
enum uint RTL_UMS_VERSION = 0x00000100U;
enum uint VRL_PREDEFINED_CLASS_BEGIN = 0x00000001U;
enum uint VRL_CUSTOM_CLASS_BEGIN = 0x00000100U;
enum uint VRL_ENABLE_KERNEL_BREAKS = 0x80000000U;

enum : uint
{
    CTMF_INCLUDE_APPCONTAINER = 0x00000001U,
    CTMF_INCLUDE_LPAC         = 0x00000002U,
}

enum uint FLUSH_NV_MEMORY_IN_FLAG_NO_DRAIN = 0x00000001U;

enum : uint
{
    WRITE_NV_MEMORY_FLAG_FLUSH        = 0x00000001U,
    WRITE_NV_MEMORY_FLAG_NON_TEMPORAL = 0x00000002U,
    WRITE_NV_MEMORY_FLAG_NO_DRAIN     = 0x00000100U,
}

enum : uint
{
    FILL_NV_MEMORY_FLAG_FLUSH        = 0x00000001U,
    FILL_NV_MEMORY_FLAG_NON_TEMPORAL = 0x00000002U,
    FILL_NV_MEMORY_FLAG_NO_DRAIN     = 0x00000100U,
}

enum uint IMAGE_POLICY_METADATA_VERSION = 0x00000001U;
// Native encoding: ansi
enum const(wchar)* IMAGE_POLICY_SECTION_NAME = ".tPolicy";
enum uint RTL_VIRTUAL_UNWIND2_VALIDATE_PAC = 0x00000001U;
enum uint HEAP_OPTIMIZE_RESOURCES_CURRENT_VERSION = 0x00000001U;

enum : uint
{
    WT_EXECUTEINUITHREAD           = 0x00000002U,
    WT_EXECUTEINPERSISTENTIOTHREAD = 0x00000040U,
}

enum : uint
{
    WT_EXECUTEINLONGTHREAD = 0x00000010U,
    WT_EXECUTEDELETEWAIT   = 0x00000008U,
}

enum : uint
{
    ACTIVATION_CONTEXT_PATH_TYPE_NONE        = 0x00000001U,
    ACTIVATION_CONTEXT_PATH_TYPE_WIN32_FILE  = 0x00000002U,
    ACTIVATION_CONTEXT_PATH_TYPE_URL         = 0x00000003U,
    ACTIVATION_CONTEXT_PATH_TYPE_ASSEMBLYREF = 0x00000004U,
}

enum uint CREATE_BOUNDARY_DESCRIPTOR_ADD_APPCONTAINER_SID = 0x00000001U;
enum uint PERFORMANCE_DATA_VERSION = 0x00000001U;

enum : uint
{
    READ_THREAD_PROFILING_FLAG_DISPATCHING       = 0x00000001U,
    READ_THREAD_PROFILING_FLAG_HARDWARE_COUNTERS = 0x00000002U,
}

enum : const(wchar)*
{
    UNIFIEDBUILDREVISION_KEY   = "\\Registry\\Machine\\Software\\Microsoft\\Windows NT\\CurrentVersion",
    UNIFIEDBUILDREVISION_VALUE = "UBR",
}

enum uint UNIFIEDBUILDREVISION_MIN = 0x00000000U;

enum : const(wchar)*
{
    DEVICEFAMILYDEVICEFORM_KEY   = "\\Registry\\Machine\\Software\\Microsoft\\Windows NT\\CurrentVersion\\OEM",
    DEVICEFAMILYDEVICEFORM_VALUE = "DeviceForm",
}

enum uint DLL_PROCESS_ATTACH = 0x00000001U;

enum : uint
{
    DLL_THREAD_ATTACH = 0x00000002U,
    DLL_THREAD_DETACH = 0x00000003U,
}

enum uint DLL_PROCESS_DETACH = 0x00000000U;
enum uint EVENTLOG_START_PAIRED_EVENT = 0x00000001U;

enum : uint
{
    EVENTLOG_END_PAIRED_EVENT      = 0x00000002U,
    EVENTLOG_END_ALL_PAIRED_EVENTS = 0x00000004U,
}

enum : uint
{
    EVENTLOG_PAIRED_EVENT_ACTIVE   = 0x00000008U,
    EVENTLOG_PAIRED_EVENT_INACTIVE = 0x00000010U,
}

enum uint MAXLOGICALLOGNAMESIZE = 0x00000100U;
enum int REG_REFRESH_HIVE = 0x00000002;
enum int REG_NO_LAZY_FLUSH = 0x00000004;
enum int REG_APP_HIVE = 0x00000010;
enum int REG_PROCESS_PRIVATE = 0x00000020;
enum int REG_START_JOURNAL = 0x00000040;
enum int REG_HIVE_EXACT_FILE_GROWTH = 0x00000080;

enum : int
{
    REG_HIVE_NO_RM      = 0x00000100,
    REG_HIVE_SINGLE_LOG = 0x00000200,
}

enum int REG_BOOT_HIVE = 0x00000400;
enum int REG_LOAD_HIVE_OPEN_HANDLE = 0x00000800;
enum int REG_FLUSH_HIVE_FILE_GROWTH = 0x00001000;
enum int REG_OPEN_READ_ONLY = 0x00002000;
enum int REG_IMMUTABLE = 0x00004000;
enum int REG_NO_IMPERSONATION_FALLBACK = 0x00008000;
enum int REG_APP_HIVE_OPEN_READ_ONLY = 0x00002000;
enum uint REG_FORCE_UNLOAD = 0x00000001U;
enum uint REG_UNLOAD_LEGAL_FLAGS = 0x00000001U;

enum : uint
{
    SERVICE_USER_SERVICE         = 0x00000040U,
    SERVICE_USERSERVICE_INSTANCE = 0x00000080U,
}

enum uint SERVICE_INTERACTIVE_PROCESS = 0x00000100U;
enum uint SERVICE_PKG_SERVICE = 0x00000200U;
enum uint CM_SERVICE_NETWORK_BOOT_LOAD = 0x00000001U;
enum uint CM_SERVICE_VIRTUAL_DISK_BOOT_LOAD = 0x00000002U;
enum uint CM_SERVICE_USB_DISK_BOOT_LOAD = 0x00000004U;
enum uint CM_SERVICE_SD_DISK_BOOT_LOAD = 0x00000008U;
enum uint CM_SERVICE_USB3_DISK_BOOT_LOAD = 0x00000010U;
enum uint CM_SERVICE_MEASURED_BOOT_LOAD = 0x00000020U;
enum uint CM_SERVICE_VERIFIER_BOOT_LOAD = 0x00000040U;

enum : uint
{
    CM_SERVICE_WINPE_BOOT_LOAD    = 0x00000080U,
    CM_SERVICE_RAM_DISK_BOOT_LOAD = 0x00000100U,
}

enum : int
{
    TAPE_PSEUDO_LOGICAL_POSITION = 0x00000002,
    TAPE_PSEUDO_LOGICAL_BLOCK    = 0x00000003,
}

enum : uint
{
    TAPE_DRIVE_FIXED            = 0x00000001U,
    TAPE_DRIVE_SELECT           = 0x00000002U,
    TAPE_DRIVE_INITIATOR        = 0x00000004U,
    TAPE_DRIVE_ERASE_SHORT      = 0x00000010U,
    TAPE_DRIVE_ERASE_LONG       = 0x00000020U,
    TAPE_DRIVE_ERASE_BOP_ONLY   = 0x00000040U,
    TAPE_DRIVE_ERASE_IMMEDIATE  = 0x00000080U,
    TAPE_DRIVE_TAPE_CAPACITY    = 0x00000100U,
    TAPE_DRIVE_TAPE_REMAINING   = 0x00000200U,
    TAPE_DRIVE_FIXED_BLOCK      = 0x00000400U,
    TAPE_DRIVE_VARIABLE_BLOCK   = 0x00000800U,
    TAPE_DRIVE_WRITE_PROTECT    = 0x00001000U,
    TAPE_DRIVE_EOT_WZ_SIZE      = 0x00002000U,
    TAPE_DRIVE_ECC              = 0x00010000U,
    TAPE_DRIVE_COMPRESSION      = 0x00020000U,
    TAPE_DRIVE_PADDING          = 0x00040000U,
    TAPE_DRIVE_REPORT_SMKS      = 0x00080000U,
    TAPE_DRIVE_GET_ABSOLUTE_BLK = 0x00100000U,
    TAPE_DRIVE_GET_LOGICAL_BLK  = 0x00200000U,
    TAPE_DRIVE_SET_EOT_WZ_SIZE  = 0x00400000U,
    TAPE_DRIVE_EJECT_MEDIA      = 0x01000000U,
    TAPE_DRIVE_CLEAN_REQUESTS   = 0x02000000U,
    TAPE_DRIVE_SET_CMP_BOP_ONLY = 0x04000000U,
    TAPE_DRIVE_RESERVED_BIT     = 0x80000000U,
    TAPE_DRIVE_FORMAT           = 0xa0000000U,
    TAPE_DRIVE_FORMAT_IMMEDIATE = 0xc0000000U,
    TAPE_DRIVE_HIGH_FEATURES    = 0x80000000U,
}

enum : int
{
    TAPE_QUERY_DRIVE_PARAMETERS = 0x00000000,
    TAPE_QUERY_MEDIA_CAPACITY   = 0x00000001,
}

enum int TAPE_CHECK_FOR_DRIVE_PROBLEM = 0x00000002;

enum : int
{
    TAPE_QUERY_IO_ERROR_DATA     = 0x00000003,
    TAPE_QUERY_DEVICE_ERROR_DATA = 0x00000004,
}

enum : uint
{
    TRANSACTIONMANAGER_QUERY_INFORMATION = 0x00000001U,
    TRANSACTIONMANAGER_SET_INFORMATION   = 0x00000002U,
    TRANSACTIONMANAGER_RECOVER           = 0x00000004U,
    TRANSACTIONMANAGER_RENAME            = 0x00000008U,
    TRANSACTIONMANAGER_CREATE_RM         = 0x00000010U,
    TRANSACTIONMANAGER_BIND_TRANSACTION  = 0x00000020U,
}

enum : uint
{
    TRANSACTION_QUERY_INFORMATION = 0x00000001U,
    TRANSACTION_SET_INFORMATION   = 0x00000002U,
    TRANSACTION_ENLIST            = 0x00000004U,
    TRANSACTION_COMMIT            = 0x00000008U,
    TRANSACTION_ROLLBACK          = 0x00000010U,
    TRANSACTION_PROPAGATE         = 0x00000020U,
    TRANSACTION_RIGHT_RESERVED1   = 0x00000040U,
}

enum : uint
{
    RESOURCEMANAGER_QUERY_INFORMATION    = 0x00000001U,
    RESOURCEMANAGER_SET_INFORMATION      = 0x00000002U,
    RESOURCEMANAGER_RECOVER              = 0x00000004U,
    RESOURCEMANAGER_ENLIST               = 0x00000008U,
    RESOURCEMANAGER_GET_NOTIFICATION     = 0x00000010U,
    RESOURCEMANAGER_REGISTER_PROTOCOL    = 0x00000020U,
    RESOURCEMANAGER_COMPLETE_PROPAGATION = 0x00000040U,
}

enum uint ENLISTMENT_QUERY_INFORMATION = 0x00000001U;

enum : uint
{
    ENLISTMENT_SET_INFORMATION    = 0x00000002U,
    ENLISTMENT_RECOVER            = 0x00000004U,
    ENLISTMENT_SUBORDINATE_RIGHTS = 0x00000008U,
    ENLISTMENT_SUPERIOR_RIGHTS    = 0x00000010U,
}

enum uint PcTeb = 0x00000018U;

enum : uint
{
    ACTIVATION_CONTEXT_SECTION_ASSEMBLY_INFORMATION         = 0x00000001U,
    ACTIVATION_CONTEXT_SECTION_DLL_REDIRECTION              = 0x00000002U,
    ACTIVATION_CONTEXT_SECTION_WINDOW_CLASS_REDIRECTION     = 0x00000003U,
    ACTIVATION_CONTEXT_SECTION_COM_SERVER_REDIRECTION       = 0x00000004U,
    ACTIVATION_CONTEXT_SECTION_COM_INTERFACE_REDIRECTION    = 0x00000005U,
    ACTIVATION_CONTEXT_SECTION_COM_TYPE_LIBRARY_REDIRECTION = 0x00000006U,
    ACTIVATION_CONTEXT_SECTION_COM_PROGID_REDIRECTION       = 0x00000007U,
    ACTIVATION_CONTEXT_SECTION_GLOBAL_OBJECT_RENAME_TABLE   = 0x00000008U,
    ACTIVATION_CONTEXT_SECTION_CLR_SURROGATES               = 0x00000009U,
    ACTIVATION_CONTEXT_SECTION_APPLICATION_SETTINGS         = 0x0000000aU,
    ACTIVATION_CONTEXT_SECTION_COMPATIBILITY_INFO           = 0x0000000bU,
    ACTIVATION_CONTEXT_SECTION_WINRT_ACTIVATABLE_CLASSES    = 0x0000000cU,
}

enum uint ROT_COMPARE_MAX = 0x00000800U;
enum uint WDT_INPROC_CALL = 0x48746457U;
enum uint WDT_REMOTE_CALL = 0x52746457U;
enum uint WDT_INPROC64_CALL = 0x50746457U;
enum ubyte DECIMAL_NEG = 0x80;

enum : uint
{
    PROCESS_HEAP_REGION            = 0x00000001U,
    PROCESS_HEAP_UNCOMMITTED_RANGE = 0x00000002U,
    PROCESS_HEAP_ENTRY_BUSY        = 0x00000004U,
    PROCESS_HEAP_SEG_ALLOC         = 0x00000008U,
    PROCESS_HEAP_ENTRY_MOVEABLE    = 0x00000010U,
    PROCESS_HEAP_ENTRY_DDESHARE    = 0x00000020U,
}

enum : uint
{
    LMEM_NOCOMPACT = 0x00000010U,
    LMEM_NODISCARD = 0x00000020U,
}

enum : uint
{
    LMEM_MODIFY      = 0x00000080U,
    LMEM_DISCARDABLE = 0x00000f00U,
}

enum uint LMEM_VALID_FLAGS = 0x00000f72U;
enum uint LMEM_INVALID_HANDLE = 0x00008000U;
enum uint LMEM_DISCARDED = 0x00004000U;
enum uint LMEM_LOCKCOUNT = 0x000000ffU;
enum uint NUMA_NO_PREFERRED_NODE = 0xffffffffU;
enum uint REDBOOK_DIGITAL_AUDIO_EXTRACTION_INFO_VERSION = 0x00000001U;

// Callbacks

alias PUMS_SCHEDULER_ENTRY_POINT = void function(RTL_UMS_SCHEDULER_REASON Reason, size_t ActivationPayload, 
                                                 void* SchedulerParam);

version(AArch64)
{
    alias PTERMINATION_HANDLER = void function(BOOLEAN _abnormal_termination, ulong EstablisherFrame);
}

version(AArch64)
{
    alias POUT_OF_PROCESS_FUNCTION_TABLE_CALLBACK = uint function(HANDLE Process, void* TableAddress, uint* Entries, 
                                                              IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY** Functions);
}

version(X86_64)
{
    alias POUT_OF_PROCESS_FUNCTION_TABLE_CALLBACK = uint function(HANDLE Process, void* TableAddress, uint* Entries, 
                                                              IMAGE_RUNTIME_FUNCTION_ENTRY** Functions);
}

version(X86_64)
{
    alias PEXCEPTION_FILTER = int function(EXCEPTION_POINTERS* ExceptionPointers, void* EstablisherFrame);
}

version(AArch64)
{
    alias PEXCEPTION_FILTER = int function(EXCEPTION_POINTERS* ExceptionPointers, void* EstablisherFrame);
}

version(X86_64)
{
    alias PTERMINATION_HANDLER = void function(BOOLEAN _abnormal_termination, void* EstablisherFrame);
}
alias PIMAGE_TLS_CALLBACK = void function(void* DllHandle, uint Reason, void* Reserved);

// Structs


struct RemHGLOBAL
{
    int      fNullHGlobal;
    uint     cbData;
    ubyte[1] data; // Flexible array
}

struct RemHMETAFILEPICT
{
    int      mm;
    int      xExt;
    int      yExt;
    uint     cbData;
    ubyte[1] data; // Flexible array
}

struct RemHENHMETAFILE
{
    uint     cbData;
    ubyte[1] data; // Flexible array
}

struct RemHBITMAP
{
    uint     cbData;
    ubyte[1] data; // Flexible array
}

struct RemHPALETTE
{
    uint     cbData;
    ubyte[1] data; // Flexible array
}

struct RemHBRUSH
{
    uint     cbData;
    ubyte[1] data; // Flexible array
}

struct userCLIPFORMAT
{
    int fContext;
    union u
    {
        uint  dwValue;
        PWSTR pwszName;
    }
}

struct GDI_NONREMOTE
{
    int fContext;
    union u
    {
        int         hInproc;
        DWORD_BLOB* hRemote;
    }
}

struct userHGLOBAL
{
    int fContext;
    union u
    {
        int                hInproc;
        FLAGGED_BYTE_BLOB* hRemote;
        long               hInproc64;
    }
}

struct userHMETAFILE
{
    int fContext;
    union u
    {
        int        hInproc;
        BYTE_BLOB* hRemote;
        long       hInproc64;
    }
}

struct remoteMETAFILEPICT
{
    int            mm;
    int            xExt;
    int            yExt;
    userHMETAFILE* hMF;
}

struct userHMETAFILEPICT
{
    int fContext;
    union u
    {
        int                 hInproc;
        remoteMETAFILEPICT* hRemote;
        long                hInproc64;
    }
}

struct userHENHMETAFILE
{
    int fContext;
    union u
    {
        int        hInproc;
        BYTE_BLOB* hRemote;
        long       hInproc64;
    }
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct userBITMAP
{
    int      bmType;
    int      bmWidth;
    int      bmHeight;
    int      bmWidthBytes;
    ushort   bmPlanes;
    ushort   bmBitsPixel;
    uint     cbSize;
    ubyte[1] pBuffer; // Flexible array
}

struct userHBITMAP
{
    int fContext;
    union u
    {
        int         hInproc;
        userBITMAP* hRemote;
        long        hInproc64;
    }
}

struct userHPALETTE
{
    int fContext;
    union u
    {
        int         hInproc;
        LOGPALETTE* hRemote;
        long        hInproc64;
    }
}

struct RemotableHandle
{
    int fContext;
    union u
    {
        int hInproc;
        int hRemote;
    }
}

struct REDBOOK_DIGITAL_AUDIO_EXTRACTION_INFO
{
    uint Version;
    uint Accurate;
    uint Supported;
    uint AccurateMask0;
}

version(X86_64)
{
    struct REARRANGE_FILE_DATA32
    {
        ulong SourceStartingOffset;
        ulong TargetOffset;
        uint  SourceFileHandle;
        uint  Length;
        uint  Flags;
    }
}

version(AArch64)
{
    struct REARRANGE_FILE_DATA32
    {
        ulong SourceStartingOffset;
        ulong TargetOffset;
        uint  SourceFileHandle;
        uint  Length;
        uint  Flags;
    }
}

struct XSAVE_CET_U_FORMAT
{
    ulong Ia32CetUMsr;
    ulong Ia32Pl3SspMsr;
}

struct XSAVE_ARM64_SVE_HEADER
{
    uint    VectorLength;
    uint    VectorRegisterOffset;
    uint    PredicateRegisterOffset;
    uint[5] Reserved;
}

struct KERNEL_CET_CONTEXT
{
    ulong     Ssp;
    ulong     Rip;
    ushort    SegCs;
    union
    {
        ushort AllFlags;
        struct
        {
            // Native bit field: UseWrss: [0], PopShadowStackOne: [1], Unused: [2-15]
            ushort _bitfield0;
        }
    }
    ushort[2] Fill;
}

struct SCOPE_TABLE_AMD64
{
    uint Count;
    struct
    {
        uint BeginAddress;
        uint EndAddress;
        uint HandlerAddress;
        uint JumpTarget;
    }
}

struct SCOPE_TABLE_ARM
{
    uint Count;
    struct
    {
        uint BeginAddress;
        uint EndAddress;
        uint HandlerAddress;
        uint JumpTarget;
    }
}

struct SCOPE_TABLE_ARM64
{
    uint Count;
    struct
    {
        uint BeginAddress;
        uint EndAddress;
        uint HandlerAddress;
        uint JumpTarget;
    }
}

union DISPATCHER_CONTEXT_NONVOLREG_ARM64
{
    ubyte[152] Buffer;
    struct
    {
        ulong[11] GpNvRegs;
        double[8] FpNvRegs;
    }
}

struct ATTRIBUTES_AND_SID
{
    uint Attributes;
    uint SidStart;
}

struct SECURITY_OBJECT_AI_PARAMS
{
    uint Size;
    uint ConstraintMask;
}

struct SE_TOKEN_USER
{
    union
    {
        TOKEN_USER         TokenUser;
        SID_AND_ATTRIBUTES User;
    }
    union
    {
        SID       Sid;
        ubyte[68] Buffer;
    }
}

struct TOKEN_LOGGING_INFORMATION
{
    TOKEN_TYPE           TokenType;
    TOKEN_ELEVATION      TokenElevation;
    TOKEN_ELEVATION_TYPE TokenElevationType;
    SECURITY_IMPERSONATION_LEVEL ImpersonationLevel;
    uint                 IntegrityLevel;
    SID_AND_ATTRIBUTES   User;
    PSID                 TrustLevelSid;
    uint                 SessionId;
    uint                 AppContainerNumber;
    LUID                 AuthenticationId;
    uint                 GroupCount;
    uint                 GroupsLength;
    SID_AND_ATTRIBUTES*  Groups;
}

struct TOKEN_SID_INFORMATION
{
    PSID Sid;
}

struct TOKEN_BNO_ISOLATION_INFORMATION
{
    PWSTR   IsolationPrefix;
    BOOLEAN IsolationEnabled;
}

struct NT_TIB32
{
    uint ExceptionList;
    uint StackBase;
    uint StackLimit;
    uint SubSystemTib;
    union
    {
        uint FiberData;
        uint Version;
    }
    uint ArbitraryUserPointer;
    uint Self;
}

struct NT_TIB64
{
    ulong ExceptionList;
    ulong StackBase;
    ulong StackLimit;
    ulong SubSystemTib;
    union
    {
        ulong FiberData;
        uint  Version;
    }
    ulong ArbitraryUserPointer;
    ulong Self;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-ums_create_thread_attributes
struct UMS_CREATE_THREAD_ATTRIBUTES
{
    uint  UmsVersion;
    void* UmsContext;
    void* UmsCompletionList;
}

struct COMPONENT_FILTER
{
    uint ComponentFlags;
}

union RATE_QUOTA_LIMIT
{
    uint RateData;
    struct
    {
        // Native bit field: RatePercent: [0-6], Reserved0: [7-31]
        uint _bitfield0;
    }
}

struct QUOTA_LIMITS_EX
{
    size_t           PagedPoolLimit;
    size_t           NonPagedPoolLimit;
    size_t           MinimumWorkingSetSize;
    size_t           MaximumWorkingSetSize;
    size_t           PagefileLimit;
    long             TimeLimit;
    size_t           WorkingSetLimit;
    size_t           Reserved2;
    size_t           Reserved3;
    size_t           Reserved4;
    uint             Flags;
    RATE_QUOTA_LIMIT CpuRateLimit;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_aslr_policy
struct PROCESS_MITIGATION_ASLR_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            // Native bit field: EnableBottomUpRandomization: [0], EnableForceRelocateImages: [1], EnableHighEntropy: [2], DisallowStrippedImages: [3], ReservedFlags: [4-31]
            uint _bitfield0;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_dep_policy
struct PROCESS_MITIGATION_DEP_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            // Native bit field: Enable: [0], DisableAtlThunkEmulation: [1], ReservedFlags: [2-31]
            uint _bitfield0;
        }
    }
    BOOLEAN Permanent;
}

struct PROCESS_MITIGATION_SEHOP_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            // Native bit field: EnableSehop: [0], ReservedFlags: [1-31]
            uint _bitfield0;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_strict_handle_check_policy
struct PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            // Native bit field: RaiseExceptionOnInvalidHandleReference: [0], HandleExceptionsPermanentlyEnabled: [1], ReservedFlags: [2-31]
            uint _bitfield0;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_system_call_disable_policy
struct PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            // Native bit field: DisallowWin32kSystemCalls: [0], AuditDisallowWin32kSystemCalls: [1], DisallowFsctlSystemCalls: [2], AuditDisallowFsctlSystemCalls: [3], ReservedFlags: [4-31]
            uint _bitfield0;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_extension_point_disable_policy
struct PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            // Native bit field: DisableExtensionPoints: [0], ReservedFlags: [1-31]
            uint _bitfield0;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_dynamic_code_policy
struct PROCESS_MITIGATION_DYNAMIC_CODE_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            // Native bit field: ProhibitDynamicCode: [0], AllowThreadOptOut: [1], AllowRemoteDowngrade: [2], AuditProhibitDynamicCode: [3], ReservedFlags: [4-31]
            uint _bitfield0;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_control_flow_guard_policy
struct PROCESS_MITIGATION_CONTROL_FLOW_GUARD_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            // Native bit field: EnableControlFlowGuard: [0], EnableExportSuppression: [1], StrictMode: [2], EnableXfg: [3], EnableXfgAuditMode: [4], ReservedFlags: [5-31]
            uint _bitfield0;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_binary_signature_policy
struct PROCESS_MITIGATION_BINARY_SIGNATURE_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            // Native bit field: MicrosoftSignedOnly: [0], StoreSignedOnly: [1], MitigationOptIn: [2], AuditMicrosoftSignedOnly: [3], AuditStoreSignedOnly: [4], ReservedFlags: [5-31]
            uint _bitfield0;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_font_disable_policy
struct PROCESS_MITIGATION_FONT_DISABLE_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            // Native bit field: DisableNonSystemFonts: [0], AuditNonSystemFontLoading: [1], ReservedFlags: [2-31]
            uint _bitfield0;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_image_load_policy
struct PROCESS_MITIGATION_IMAGE_LOAD_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            // Native bit field: NoRemoteImages: [0], NoLowMandatoryLabelImages: [1], PreferSystem32Images: [2], AuditNoRemoteImages: [3], AuditNoLowMandatoryLabelImages: [4], ReservedFlags: [5-31]
            uint _bitfield0;
        }
    }
}

struct PROCESS_MITIGATION_SYSTEM_CALL_FILTER_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            // Native bit field: FilterId: [0-3], ReservedFlags: [4-31]
            uint _bitfield0;
        }
    }
}

struct PROCESS_MITIGATION_PAYLOAD_RESTRICTION_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            // Native bit field: EnableExportAddressFilter: [0], AuditExportAddressFilter: [1], EnableExportAddressFilterPlus: [2], AuditExportAddressFilterPlus: [3], EnableImportAddressFilter: [4], AuditImportAddressFilter: [5], EnableRopStackPivot: [6], AuditRopStackPivot: [7], EnableRopCallerCheck: [8], AuditRopCallerCheck: [9], EnableRopSimExec: [10], AuditRopSimExec: [11], ReservedFlags: [12-31]
            uint _bitfield0;
        }
    }
}

struct PROCESS_MITIGATION_CHILD_PROCESS_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            // Native bit field: NoChildProcessCreation: [0], AuditNoChildProcessCreation: [1], AllowSecureProcessCreation: [2], ReservedFlags: [3-31]
            uint _bitfield0;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_side_channel_isolation_policy
struct PROCESS_MITIGATION_SIDE_CHANNEL_ISOLATION_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            // Native bit field: SmtBranchTargetIsolation: [0], IsolateSecurityDomain: [1], DisablePageCombine: [2], SpeculativeStoreBypassDisable: [3], RestrictCoreSharing: [4], ReservedFlags: [5-31]
            uint _bitfield0;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_user_shadow_stack_policy
struct PROCESS_MITIGATION_USER_SHADOW_STACK_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            // Native bit field: EnableUserShadowStack: [0], AuditUserShadowStack: [1], SetContextIpValidation: [2], AuditSetContextIpValidation: [3], EnableUserShadowStackStrictMode: [4], BlockNonCetBinaries: [5], BlockNonCetBinariesNonEhcont: [6], AuditBlockNonCetBinaries: [7], CetDynamicApisOutOfProcOnly: [8], SetContextIpValidationRelaxedMode: [9], ReservedFlags: [10-31]
            uint _bitfield0;
        }
    }
}

struct PROCESS_MITIGATION_USER_POINTER_AUTH_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            // Native bit field: EnablePointerAuthUserIp: [0], ReservedFlags: [1-31]
            uint _bitfield0;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process-mitigation-redirection-trust-policy
struct PROCESS_MITIGATION_REDIRECTION_TRUST_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            // Native bit field: EnforceRedirectionTrust: [0], AuditRedirectionTrust: [1], ReservedFlags: [2-31]
            uint _bitfield0;
        }
    }
}

struct PROCESS_NETWORK_COUNTERS
{
    ulong BytesIn;
    ulong BytesOut;
}

struct JOBOBJECT_NETWORK_ACCOUNTING_INFORMATION
{
    ulong DataBytesIn;
    ulong DataBytesOut;
}

struct SILOOBJECT_BASIC_INFORMATION
{
    uint     SiloId;
    uint     SiloParentId;
    uint     NumberOfProcesses;
    BOOLEAN  IsInServerSilo;
    ubyte[3] Reserved;
}

struct SERVERSILO_BASIC_INFORMATION
{
    uint             ServiceSessionId;
    SERVERSILO_STATE State;
    uint             ExitStatus;
    BOOLEAN          Reserved;
    void*            ApiSetSchema;
    void*            HostApiSetSchema;
    uint             ContainerBuildNumber;
    uint             HostBuildNumber;
}

struct SERVERSILO_DIAGNOSTIC_INFORMATION
{
    GUID      ReportId;
    uint      ExitStatus;
    wchar[15] CriticalProcessName;
}

struct RUNTIME_REPORT_PACKAGE_HEADER
{
    uint   Magic;
    ushort PackageVersion;
    ushort NumberOfReports;
    ulong  ReportTypesBitmap;
    uint   PackageSize;
    ushort ReportDigestType;
    ushort TotalReportDigestsSize;
    ushort Reserved;
    ushort SignatureScheme;
    uint   SignatureSize;
    uint   TotalAuthenticatedReportsSize;
}

struct RUNTIME_REPORT_DIGEST_HEADER
{
    ushort    ReportType;
    ushort    Reserved;
    ubyte[64] ReportDigest;
}

struct RUNTIME_REPORT_HEADER
{
    ushort ReportType;
    ushort Reserved;
    uint   ReportSize;
}

struct DRIVER_INFO_ENTRY
{
    CHAR[32] InternalName;
    ushort   ImageHashAlgorithm;
    ushort   PublisherThumbprintHashAlgorithm;
    uint     ImageHashOffset;
    uint     PublisherThumbprintOffset;
    ushort   LoadCount;
    ushort   OemNameSize;
    uint     OemNameOffset;
    union Flags
    {
        struct
        {
            // Native bit field: Unloaded: [0], BootDriver: [1], HotPatch: [2], Reserved: [3-15]
            ushort _bitfield0;
        }
        ushort AsUInt16;
    }
    ushort   Padding;
}

struct DRIVER_RUNTIME_REPORT
{
    RUNTIME_REPORT_HEADER Header;
    ushort               NumberOfDrivers;
    union Flags
    {
        struct
        {
            // Native bit field: ReportOverflowed: [0], PartialReport: [1], IncludeBootDrivers: [2], Reserved: [3-15]
            ushort _bitfield0;
        }
        ushort AsUInt16;
    }
    DRIVER_INFO_ENTRY[1] DriverEntries; // Flexible array
}

struct FILE_NOTIFY_FULL_INFORMATION
{
    uint     NextEntryOffset;
    uint     Action;
    long     CreationTime;
    long     LastModificationTime;
    long     LastChangeTime;
    long     LastAccessTime;
    long     AllocatedLength;
    long     FileSize;
    uint     FileAttributes;
    union
    {
        uint ReparsePointTag;
        uint EaSize;
    }
    long     FileId;
    long     ParentFileId;
    ushort   FileNameLength;
    ubyte    FileNameFlags;
    ubyte    Reserved;
    wchar[1] FileName; // Flexible array
}

struct FILE_STAT_INFORMATION
{
    long FileId;
    long CreationTime;
    long LastAccessTime;
    long LastWriteTime;
    long ChangeTime;
    long AllocationSize;
    long EndOfFile;
    uint FileAttributes;
    uint ReparseTag;
    uint NumberOfLinks;
    uint EffectiveAccess;
}

struct FILE_STAT_LX_INFORMATION
{
    long FileId;
    long CreationTime;
    long LastAccessTime;
    long LastWriteTime;
    long ChangeTime;
    long AllocationSize;
    long EndOfFile;
    uint FileAttributes;
    uint ReparseTag;
    uint NumberOfLinks;
    uint EffectiveAccess;
    uint LxFlags;
    uint LxUid;
    uint LxGid;
    uint LxMode;
    uint LxDeviceIdMajor;
    uint LxDeviceIdMinor;
}

struct FILE_CASE_SENSITIVE_INFORMATION
{
    uint Flags;
}

struct SCRUB_DATA_INPUT
{
    uint        Size;
    uint        Flags;
    uint        MaximumIos;
    uint[4]     ObjectId;
    ulong       StartingByteOffset;
    ulong       ByteCount;
    uint[36]    Reserved;
    ubyte[1040] ResumeContext;
}

struct SCRUB_PARITY_EXTENT
{
    long  Offset;
    ulong Length;
}

struct SCRUB_PARITY_EXTENT_DATA
{
    ushort Size;
    ushort Flags;
    ushort NumberOfParityExtents;
    ushort MaximumNumberOfParityExtents;
    SCRUB_PARITY_EXTENT[1] ParityExtents; // Flexible array
}

struct SCRUB_DATA_OUTPUT
{
    uint        Size;
    uint        Flags;
    uint        Status;
    ulong       ErrorFileOffset;
    ulong       ErrorLength;
    ulong       NumberOfBytesRepaired;
    ulong       NumberOfBytesFailed;
    ulong       InternalFileReference;
    ushort      ResumeContextLength;
    ushort      ParityExtentDataOffset;
    ulong       NextStartingByteOffset;
    ulong       ValidDataLength;
    uint[4]     Reserved;
    ulong       NumberOfMetadataBytesProcessed;
    ulong       NumberOfDataBytesProcessed;
    ulong       TotalNumberOfMetadataBytesInUse;
    ulong       TotalNumberOfDataBytesInUse;
    ulong       DataBytesSkippedDueToNoAllocation;
    ulong       DataBytesSkippedDueToInvalidRun;
    ulong       DataBytesSkippedDueToIntegrityStream;
    ulong       DataBytesSkippedDueToRegionBeingClean;
    ulong       DataBytesSkippedDueToLockConflict;
    ulong       DataBytesSkippedDueToNoScrubDataFlag;
    ulong       DataBytesSkippedDueToNoScrubNonIntegrityStreamFlag;
    ulong       DataBytesScrubbed;
    ubyte[1040] ResumeContext;
}

struct SHARED_VIRTUAL_DISK_SUPPORT
{
    SharedVirtualDiskSupportType SharedVirtualDiskSupport;
    SharedVirtualDiskHandleState HandleState;
}

struct REARRANGE_FILE_DATA
{
    ulong  SourceStartingOffset;
    ulong  TargetOffset;
    HANDLE SourceFileHandle;
    uint   Length;
    uint   Flags;
}

struct SHUFFLE_FILE_DATA
{
    long StartingOffset;
    long Length;
    uint Flags;
}

struct NETWORK_APP_INSTANCE_EA
{
    GUID AppInstanceID;
    uint CsvFlags;
}

struct POWER_LIMIT_ATTRIBUTES
{
    POWER_LIMIT_TYPES Type;
    uint              DomainId;
    uint              MaxValue;
    uint              MinValue;
    uint              MinTimeParameter;
    uint              MaxTimeParameter;
    uint              DefaultACValue;
    uint              DefaultDCValue;
    union Flags
    {
        struct
        {
            // Native bit field: SupportTimeParameter: [0], Reserved: [1-31]
            uint _bitfield0;
        }
        uint AsUlong;
    }
}

struct POWER_LIMIT_VALUE
{
    POWER_LIMIT_TYPES Type;
    uint              DomainId;
    uint              TargetValue;
    uint              TimeParameter;
}

struct NOTIFY_USER_POWER_SETTING
{
    GUID Guid;
}

struct APPLICATIONLAUNCH_SETTING_VALUE
{
    long ActivationTime;
    uint Flags;
    uint ButtonInstanceID;
}

struct PROCESSOR_IDLESTATE_INFO
{
    uint     TimeCheck;
    ubyte    DemotePercent;
    ubyte    PromotePercent;
    ubyte[2] Spare;
}

struct PROCESSOR_IDLESTATE_POLICY
{
    ushort Revision;
    union Flags
    {
        ushort AsWORD;
        struct
        {
            // Native bit field: AllowScaling: [0], Disabled: [1], Reserved: [2-15]
            ushort _bitfield0;
        }
    }
    uint   PolicyCount;
    PROCESSOR_IDLESTATE_INFO[3] Policy;
}

struct PROCESSOR_PERFSTATE_POLICY
{
    uint  Revision;
    ubyte MaxThrottle;
    ubyte MinThrottle;
    ubyte BusyAdjThreshold;
    union
    {
        ubyte Spare;
        union Flags
        {
            ubyte AsBYTE;
            struct
            {
                // Native bit field: NoDomainAccounting: [0], IncreasePolicy: [1-2], DecreasePolicy: [3-4], Reserved: [5-7]
                ubyte _bitfield0;
            }
        }
    }
    uint  TimeCheck;
    uint  IncreaseTime;
    uint  DecreaseTime;
    uint  IncreasePercent;
    uint  DecreasePercent;
}

struct HIBERFILE_BUCKET
{
    ulong   MaxPhysicalMemory;
    uint[3] PhysicalMemoryPercent;
}

struct SYSTEM_POWER_SOURCE_STATE
{
    SYSTEM_BATTERY_STATE BatteryState;
    uint                 InstantaneousPeakPower;
    uint                 InstantaneousPeakPeriod;
    uint                 SustainablePeakPower;
    uint                 SustainablePeakPeriod;
    uint                 PeakPower;
    uint                 MaxOutputPower;
    uint                 MaxInputPower;
    int                  BatteryRateInCurrent;
    uint                 BatteryVoltage;
}

struct IMAGE_DOS_HEADER
{
align (2):
    ushort     e_magic;
    ushort     e_cblp;
    ushort     e_cp;
    ushort     e_crlc;
    ushort     e_cparhdr;
    ushort     e_minalloc;
    ushort     e_maxalloc;
    ushort     e_ss;
    ushort     e_sp;
    ushort     e_csum;
    ushort     e_ip;
    ushort     e_cs;
    ushort     e_lfarlc;
    ushort     e_ovno;
    ushort[4]  e_res;
    ushort     e_oemid;
    ushort     e_oeminfo;
    ushort[10] e_res2;
    int        e_lfanew;
}

struct IMAGE_OS2_HEADER
{
align (2):
    ushort ne_magic;
    CHAR   ne_ver;
    CHAR   ne_rev;
    ushort ne_enttab;
    ushort ne_cbenttab;
    int    ne_crc;
    ushort ne_flags;
    ushort ne_autodata;
    ushort ne_heap;
    ushort ne_stack;
    int    ne_csip;
    int    ne_sssp;
    ushort ne_cseg;
    ushort ne_cmod;
    ushort ne_cbnrestab;
    ushort ne_segtab;
    ushort ne_rsrctab;
    ushort ne_restab;
    ushort ne_modtab;
    ushort ne_imptab;
    int    ne_nrestab;
    ushort ne_cmovent;
    ushort ne_align;
    ushort ne_cres;
    ubyte  ne_exetyp;
    ubyte  ne_flagsothers;
    ushort ne_pretthunks;
    ushort ne_psegrefbytes;
    ushort ne_swaparea;
    ushort ne_expver;
}

struct IMAGE_VXD_HEADER
{
align (2):
    ushort    e32_magic;
    ubyte     e32_border;
    ubyte     e32_worder;
    uint      e32_level;
    ushort    e32_cpu;
    ushort    e32_os;
    uint      e32_ver;
    uint      e32_mflags;
    uint      e32_mpages;
    uint      e32_startobj;
    uint      e32_eip;
    uint      e32_stackobj;
    uint      e32_esp;
    uint      e32_pagesize;
    uint      e32_lastpagesize;
    uint      e32_fixupsize;
    uint      e32_fixupsum;
    uint      e32_ldrsize;
    uint      e32_ldrsum;
    uint      e32_objtab;
    uint      e32_objcnt;
    uint      e32_objmap;
    uint      e32_itermap;
    uint      e32_rsrctab;
    uint      e32_rsrccnt;
    uint      e32_restab;
    uint      e32_enttab;
    uint      e32_dirtab;
    uint      e32_dircnt;
    uint      e32_fpagetab;
    uint      e32_frectab;
    uint      e32_impmod;
    uint      e32_impmodcnt;
    uint      e32_impproc;
    uint      e32_pagesum;
    uint      e32_datapage;
    uint      e32_preload;
    uint      e32_nrestab;
    uint      e32_cbnrestab;
    uint      e32_nressum;
    uint      e32_autodata;
    uint      e32_debuginfo;
    uint      e32_debuglen;
    uint      e32_instpreload;
    uint      e32_instdemand;
    uint      e32_heapsize;
    ubyte[12] e32_res3;
    uint      e32_winresoff;
    uint      e32_winreslen;
    ushort    e32_devid;
    ushort    e32_ddkver;
}

struct ANON_OBJECT_HEADER
{
    ushort Sig1;
    ushort Sig2;
    ushort Version;
    ushort Machine;
    uint   TimeDateStamp;
    GUID   ClassID;
    uint   SizeOfData;
}

struct ANON_OBJECT_HEADER_V2
{
    ushort Sig1;
    ushort Sig2;
    ushort Version;
    ushort Machine;
    uint   TimeDateStamp;
    GUID   ClassID;
    uint   SizeOfData;
    uint   Flags;
    uint   MetaDataSize;
    uint   MetaDataOffset;
}

struct ANON_OBJECT_HEADER_BIGOBJ
{
    ushort Sig1;
    ushort Sig2;
    ushort Version;
    ushort Machine;
    uint   TimeDateStamp;
    GUID   ClassID;
    uint   SizeOfData;
    uint   Flags;
    uint   MetaDataSize;
    uint   MetaDataOffset;
    uint   NumberOfSections;
    uint   PointerToSymbolTable;
    uint   NumberOfSymbols;
}

struct IMAGE_SYMBOL
{
align (2):
    union N
    {
    align (2):
        ubyte[8] ShortName;
        struct Name
        {
        align (2):
            uint Short;
            uint Long;
        }
        uint[2]  LongName;
    }
    uint   Value;
    short  SectionNumber;
    ushort Type;
    ubyte  StorageClass;
    ubyte  NumberOfAuxSymbols;
}

struct IMAGE_SYMBOL_EX
{
align (2):
    union N
    {
    align (2):
        ubyte[8] ShortName;
        struct Name
        {
        align (2):
            uint Short;
            uint Long;
        }
        uint[2]  LongName;
    }
    uint   Value;
    int    SectionNumber;
    ushort Type;
    ubyte  StorageClass;
    ubyte  NumberOfAuxSymbols;
}

struct IMAGE_AUX_SYMBOL_TOKEN_DEF
{
align (2):
    ubyte     bAuxType;
    ubyte     bReserved;
    uint      SymbolTableIndex;
    ubyte[12] rgbReserved;
}

union IMAGE_AUX_SYMBOL
{
    struct Sym
    {
    align (2):
        uint   TagIndex;
        union Misc
        {
        align (2):
            struct LnSz
            {
                ushort Linenumber;
                ushort Size;
            }
            uint TotalSize;
        }
        union FcnAry
        {
            struct Function
            {
            align (2):
                uint PointerToLinenumber;
                uint PointerToNextFunction;
            }
            struct Array
            {
                ushort[4] Dimension;
            }
        }
        ushort TvIndex;
    }
    struct File
    {
        ubyte[18] Name;
    }
    struct Section
    {
    align (2):
        uint   Length;
        ushort NumberOfRelocations;
        ushort NumberOfLinenumbers;
        uint   CheckSum;
        short  Number;
        ubyte  Selection;
        ubyte  bReserved;
        short  HighNumber;
    }
    IMAGE_AUX_SYMBOL_TOKEN_DEF TokenDef;
    struct CRC
    {
    align (2):
        uint      crc;
        ubyte[14] rgbReserved;
    }
}

union IMAGE_AUX_SYMBOL_EX
{
    struct Sym
    {
    align (2):
        uint      WeakDefaultSymIndex;
        uint      WeakSearchType;
        ubyte[12] rgbReserved;
    }
    struct File
    {
        ubyte[20] Name;
    }
    struct Section
    {
    align (2):
        uint     Length;
        ushort   NumberOfRelocations;
        ushort   NumberOfLinenumbers;
        uint     CheckSum;
        short    Number;
        ubyte    Selection;
        ubyte    bReserved;
        short    HighNumber;
        ubyte[2] rgbReserved;
    }
    struct
    {
        IMAGE_AUX_SYMBOL_TOKEN_DEF TokenDef;
        ubyte[2] rgbReserved;
    }
    struct CRC
    {
    align (2):
        uint      crc;
        ubyte[16] rgbReserved;
    }
}

struct IMAGE_RELOCATION
{
align (2):
    union
    {
    align (2):
        uint VirtualAddress;
        uint RelocCount;
    }
    uint   SymbolTableIndex;
    ushort Type;
}

struct IMAGE_LINENUMBER
{
    union Type
    {
    align (2):
        uint SymbolTableIndex;
        uint VirtualAddress;
    }
    ushort Linenumber;
}

struct IMAGE_BASE_RELOCATION
{
    uint VirtualAddress;
    uint SizeOfBlock;
}

struct IMAGE_ARCHIVE_MEMBER_HEADER
{
    ubyte[16] Name;
    ubyte[12] Date;
    ubyte[6]  UserID;
    ubyte[6]  GroupID;
    ubyte[8]  Mode;
    ubyte[10] Size;
    ubyte[2]  EndHeader;
}

struct IMAGE_EXPORT_DIRECTORY
{
    uint   Characteristics;
    uint   TimeDateStamp;
    ushort MajorVersion;
    ushort MinorVersion;
    uint   Name;
    uint   Base;
    uint   NumberOfFunctions;
    uint   NumberOfNames;
    uint   AddressOfFunctions;
    uint   AddressOfNames;
    uint   AddressOfNameOrdinals;
}

struct IMAGE_IMPORT_BY_NAME
{
    ushort  Hint;
    CHAR[1] Name; // Flexible array
}

struct IMAGE_TLS_DIRECTORY64
{
align (4):
    ulong StartAddressOfRawData;
    ulong EndAddressOfRawData;
    ulong AddressOfIndex;
    ulong AddressOfCallBacks;
    uint  SizeOfZeroFill;
    union
    {
        uint Characteristics;
        struct
        {
            // Native bit field: Reserved0: [0-19], Alignment: [20-23], Reserved1: [24-31]
            uint _bitfield0;
        }
    }
}

struct IMAGE_TLS_DIRECTORY32
{
    uint StartAddressOfRawData;
    uint EndAddressOfRawData;
    uint AddressOfIndex;
    uint AddressOfCallBacks;
    uint SizeOfZeroFill;
    union
    {
        uint Characteristics;
        struct
        {
            // Native bit field: Reserved0: [0-19], Alignment: [20-23], Reserved1: [24-31]
            uint _bitfield0;
        }
    }
}

struct IMAGE_IMPORT_DESCRIPTOR
{
    union
    {
        uint Characteristics;
        uint OriginalFirstThunk;
    }
    uint TimeDateStamp;
    uint ForwarderChain;
    uint Name;
    uint FirstThunk;
}

struct IMAGE_BOUND_IMPORT_DESCRIPTOR
{
    uint   TimeDateStamp;
    ushort OffsetModuleName;
    ushort NumberOfModuleForwarderRefs;
}

struct IMAGE_BOUND_FORWARDER_REF
{
    uint   TimeDateStamp;
    ushort OffsetModuleName;
    ushort Reserved;
}

struct IMAGE_RESOURCE_DIRECTORY
{
    uint   Characteristics;
    uint   TimeDateStamp;
    ushort MajorVersion;
    ushort MinorVersion;
    ushort NumberOfNamedEntries;
    ushort NumberOfIdEntries;
}

struct IMAGE_RESOURCE_DIRECTORY_ENTRY
{
    union
    {
        struct
        {
            // Native bit field: NameOffset: [0-30], NameIsString: [31]
            uint _bitfield0;
        }
        uint   Name;
        ushort Id;
    }
    union
    {
        uint OffsetToData;
        struct
        {
            // Native bit field: OffsetToDirectory: [0-30], DataIsDirectory: [31]
            uint _bitfield1;
        }
    }
}

struct IMAGE_RESOURCE_DIRECTORY_STRING
{
    ushort  Length;
    CHAR[1] NameString; // Flexible array
}

struct IMAGE_RESOURCE_DIR_STRING_U
{
    ushort   Length;
    wchar[1] NameString; // Flexible array
}

struct IMAGE_RESOURCE_DATA_ENTRY
{
    uint OffsetToData;
    uint Size;
    uint CodePage;
    uint Reserved;
}

struct IMAGE_DYNAMIC_RELOCATION_TABLE
{
    uint Version;
    uint Size;
}

struct IMAGE_DYNAMIC_RELOCATION32
{
align (1):
    uint Symbol;
    uint BaseRelocSize;
}

struct IMAGE_DYNAMIC_RELOCATION64
{
align (1):
    ulong Symbol;
    uint  BaseRelocSize;
}

struct IMAGE_DYNAMIC_RELOCATION32_V2
{
align (1):
    uint HeaderSize;
    uint FixupInfoSize;
    uint Symbol;
    uint SymbolGroup;
    uint Flags;
}

struct IMAGE_DYNAMIC_RELOCATION64_V2
{
align (1):
    uint  HeaderSize;
    uint  FixupInfoSize;
    ulong Symbol;
    uint  SymbolGroup;
    uint  Flags;
}

struct IMAGE_PROLOGUE_DYNAMIC_RELOCATION_HEADER
{
    ubyte PrologueByteCount;
}

struct IMAGE_EPILOGUE_DYNAMIC_RELOCATION_HEADER
{
align (1):
    uint   EpilogueCount;
    ubyte  EpilogueByteCount;
    ubyte  BranchDescriptorElementSize;
    ushort BranchDescriptorCount;
}

struct IMAGE_IMPORT_CONTROL_TRANSFER_DYNAMIC_RELOCATION
{
align (1):
    // Native bit field: PageRelativeOffset: [0-11], IndirectCall: [12], IATIndex: [13-31]
    uint _bitfield0;
}

struct IMAGE_IMPORT_CONTROL_TRANSFER_ARM64_RELOCATION
{
align (1):
    // Native bit field: PageRelativeOffset: [0-9], IndirectCall: [10], RegisterIndex: [11-15], ImportType: [16], IATIndex: [17-31]
    uint _bitfield0;
}

struct IMAGE_INDIR_CONTROL_TRANSFER_DYNAMIC_RELOCATION
{
align (1):
    // Native bit field: PageRelativeOffset: [0-11], IndirectCall: [12], RexWPrefix: [13], CfgCheck: [14], Reserved: [15]
    ushort _bitfield0;
}

struct IMAGE_SWITCHTABLE_BRANCH_DYNAMIC_RELOCATION
{
align (1):
    // Native bit field: PageRelativeOffset: [0-11], RegisterNumber: [12-15]
    ushort _bitfield0;
}

struct IMAGE_FUNCTION_OVERRIDE_HEADER
{
align (1):
    uint FuncOverrideSize;
}

struct IMAGE_FUNCTION_OVERRIDE_DYNAMIC_RELOCATION
{
align (1):
    uint OriginalRva;
    uint BDDOffset;
    uint RvaSize;
    uint BaseRelocSize;
}

struct IMAGE_BDD_INFO
{
align (1):
    uint Version;
    uint BDDSize;
}

struct IMAGE_BDD_DYNAMIC_RELOCATION
{
align (1):
    ushort Left;
    ushort Right;
    uint   Value;
}

struct IMAGE_HOT_PATCH_INFO
{
    uint Version;
    uint Size;
    uint SequenceNumber;
    uint BaseImageList;
    uint BaseImageCount;
    uint BufferOffset;
    uint ExtraPatchSize;
    uint MinSequenceNumber;
    uint Flags;
}

struct IMAGE_HOT_PATCH_BASE
{
    uint SequenceNumber;
    uint Flags;
    uint OriginalTimeDateStamp;
    uint OriginalCheckSum;
    uint CodeIntegrityInfo;
    uint CodeIntegritySize;
    uint PatchTable;
    uint BufferOffset;
}

struct IMAGE_HOT_PATCH_MACHINE
{
    struct
    {
        // Native bit field: _x86: [0], Amd64: [1], Arm64: [2], Amd64EC: [3]
        uint _bitfield0;
    }
}

struct IMAGE_HOT_PATCH_HASHES
{
    ubyte[32] SHA256;
    ubyte[20] SHA1;
}

struct IMAGE_CE_RUNTIME_FUNCTION_ENTRY
{
    uint FuncStart;
    // Native bit field: PrologLen: [0-7], FuncLen: [8-29], ThirtyTwoBit: [30], ExceptionFlag: [31]
    uint _bitfield0;
}

struct IMAGE_ARM_RUNTIME_FUNCTION_ENTRY
{
    uint BeginAddress;
    union
    {
        uint UnwindData;
        struct
        {
            // Native bit field: Flag: [0-1], FunctionLength: [2-12], Ret: [13-14], H: [15], Reg: [16-18], R: [19], L: [20], C: [21], StackAdjust: [22-31]
            uint _bitfield0;
        }
    }
}

union IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY_XDATA
{
    uint HeaderData;
    struct
    {
        // Native bit field: FunctionLength: [0-17], Version: [18-19], ExceptionDataPresent: [20], EpilogInHeader: [21], EpilogCount: [22-26], CodeWords: [27-31]
        uint _bitfield0;
    }
}

union IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY_XDATA_EXTENDED
{
    uint ExtendedHeaderData;
    struct
    {
        // Native bit field: ExtendedEpilogCount: [0-15], ExtendedCodeWords: [16-23]
        uint _bitfield0;
    }
}

union IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY_XDATA_EPILOG_SCOPE
{
    uint EpilogScopeData;
    struct
    {
        // Native bit field: EpilogStartOffset: [0-17], Res0: [18-21], EpilogStartIndex: [22-31]
        uint _bitfield0;
    }
}

struct IMAGE_ALPHA64_RUNTIME_FUNCTION_ENTRY
{
align (4):
    ulong BeginAddress;
    ulong EndAddress;
    ulong ExceptionHandler;
    ulong HandlerData;
    ulong PrologEndAddress;
}

struct IMAGE_ALPHA_RUNTIME_FUNCTION_ENTRY
{
    uint BeginAddress;
    uint EndAddress;
    uint ExceptionHandler;
    uint HandlerData;
    uint PrologEndAddress;
}

struct IMAGE_DEBUG_MISC
{
    uint     DataType;
    uint     Length;
    BOOLEAN  Unicode;
    ubyte[3] Reserved;
    ubyte[1] Data; // Flexible array
}

struct IMAGE_SEPARATE_DEBUG_HEADER
{
    ushort  Signature;
    ushort  Flags;
    ushort  Machine;
    ushort  Characteristics;
    uint    TimeDateStamp;
    uint    CheckSum;
    uint    ImageBase;
    uint    SizeOfImage;
    uint    NumberOfSections;
    uint    ExportedNamesSize;
    uint    DebugDirectorySize;
    uint    SectionAlignment;
    uint[2] Reserved;
}

struct NON_PAGED_DEBUG_INFO
{
align (4):
    ushort Signature;
    ushort Flags;
    uint   Size;
    ushort Machine;
    ushort Characteristics;
    uint   TimeDateStamp;
    uint   CheckSum;
    uint   SizeOfImage;
    ulong  ImageBase;
}

struct IMAGE_ARCHITECTURE_HEADER
{
    // Native bit field: AmaskValue: [0], Anonymous1: [1-7], AmaskShift: [8-15], Anonymous2: [16-31]
    uint _bitfield0;
    uint FirstEntryRVA;
}

struct IMAGE_ARCHITECTURE_ENTRY
{
    uint FixupInstRVA;
    uint NewInst;
}

struct IMPORT_OBJECT_HEADER
{
    ushort Sig1;
    ushort Sig2;
    ushort Version;
    ushort Machine;
    uint   TimeDateStamp;
    uint   SizeOfData;
    union
    {
        ushort Ordinal;
        ushort Hint;
    }
    // Native bit field: Type: [0-1], NameType: [2-4], Reserved: [5-15]
    ushort _bitfield0;
}

struct IMAGE_POLICY_ENTRY
{
    IMAGE_POLICY_ENTRY_TYPE Type;
    IMAGE_POLICY_ID PolicyId;
    union u
    {
        const(void)* None;
        BOOLEAN      BoolValue;
        byte         Int8Value;
        ubyte        UInt8Value;
        short        Int16Value;
        ushort       UInt16Value;
        int          Int32Value;
        uint         UInt32Value;
        long         Int64Value;
        ulong        UInt64Value;
        const(PSTR)  AnsiStringValue;
        const(PWSTR) UnicodeStringValue;
    }
}

struct IMAGE_POLICY_METADATA
{
    ubyte    Version;
    ubyte[7] Reserved0;
    ulong    ApplicationId;
    IMAGE_POLICY_ENTRY[1] Policies;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-heap_optimize_resources_information
struct HEAP_OPTIMIZE_RESOURCES_INFORMATION
{
    uint Version;
    uint Flags;
}

struct SUPPORTED_OS_INFO
{
    ushort MajorVersion;
    ushort MinorVersion;
}

struct MAXVERSIONTESTED_INFO
{
    ulong MaxVersionTested;
}

deprecated("struct PACKEDEVENTINFO is deprecated and might not work on all platforms. For more info, see MSDN.") 
struct PACKEDEVENTINFO
{
    uint    ulSize;
    uint    ulNumEventsForLogFile;
    uint[1] ulOffsets;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-tape_get_drive_parameters
struct TAPE_GET_DRIVE_PARAMETERS
{
    BOOLEAN ECC;
    BOOLEAN Compression;
    BOOLEAN DataPadding;
    BOOLEAN ReportSetmarks;
    uint    DefaultBlockSize;
    uint    MaximumBlockSize;
    uint    MinimumBlockSize;
    uint    MaximumPartitionCount;
    uint    FeaturesLow;
    TAPE_GET_DRIVE_PARAMETERS_FEATURES_HIGH FeaturesHigh;
    uint    EOTWarningZoneSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-tape_set_drive_parameters
struct TAPE_SET_DRIVE_PARAMETERS
{
    BOOLEAN ECC;
    BOOLEAN Compression;
    BOOLEAN DataPadding;
    BOOLEAN ReportSetmarks;
    uint    EOTWarningZoneSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-tape_get_media_parameters
struct TAPE_GET_MEDIA_PARAMETERS
{
    long    Capacity;
    long    Remaining;
    uint    BlockSize;
    uint    PartitionCount;
    BOOLEAN WriteProtected;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-tape_set_media_parameters
struct TAPE_SET_MEDIA_PARAMETERS
{
    uint BlockSize;
}

struct TAPE_CREATE_PARTITION
{
    uint Method;
    uint Count;
    uint Size;
}

struct TAPE_WMI_OPERATIONS
{
    uint  Method;
    uint  DataBufferSize;
    void* DataBuffer;
}

struct TRANSACTION_BASIC_INFORMATION
{
    GUID TransactionId;
    uint State;
    uint Outcome;
}

struct TRANSACTIONMANAGER_BASIC_INFORMATION
{
    GUID TmIdentity;
    long VirtualClock;
}

struct TRANSACTIONMANAGER_LOG_INFORMATION
{
    GUID LogIdentity;
}

struct TRANSACTIONMANAGER_LOGPATH_INFORMATION
{
    uint     LogPathLength;
    wchar[1] LogPath; // Flexible array
}

struct TRANSACTIONMANAGER_RECOVERY_INFORMATION
{
    ulong LastRecoveredLsn;
}

struct TRANSACTIONMANAGER_OLDEST_INFORMATION
{
    GUID OldestTransactionGuid;
}

struct TRANSACTION_PROPERTIES_INFORMATION
{
    uint     IsolationLevel;
    uint     IsolationFlags;
    long     Timeout;
    uint     Outcome;
    uint     DescriptionLength;
    wchar[1] Description; // Flexible array
}

struct TRANSACTION_BIND_INFORMATION
{
    HANDLE TmHandle;
}

struct TRANSACTION_ENLISTMENT_PAIR
{
    GUID EnlistmentId;
    GUID ResourceManagerId;
}

struct TRANSACTION_ENLISTMENTS_INFORMATION
{
    uint NumberOfEnlistments;
    TRANSACTION_ENLISTMENT_PAIR[1] EnlistmentPair; // Flexible array
}

struct TRANSACTION_SUPERIOR_ENLISTMENT_INFORMATION
{
    TRANSACTION_ENLISTMENT_PAIR SuperiorEnlistmentPair;
}

struct RESOURCEMANAGER_BASIC_INFORMATION
{
    GUID     ResourceManagerId;
    uint     DescriptionLength;
    wchar[1] Description; // Flexible array
}

struct RESOURCEMANAGER_COMPLETION_INFORMATION
{
    HANDLE IoCompletionPortHandle;
    size_t CompletionKey;
}

struct ENLISTMENT_BASIC_INFORMATION
{
    GUID EnlistmentId;
    GUID TransactionId;
    GUID ResourceManagerId;
}

struct ENLISTMENT_CRM_INFORMATION
{
    GUID CrmTransactionManagerId;
    GUID CrmResourceManagerId;
    GUID CrmEnlistmentId;
}

struct TRANSACTION_LIST_ENTRY
{
    GUID UOW;
}

struct TRANSACTION_LIST_INFORMATION
{
    uint NumberOfTransactions;
    TRANSACTION_LIST_ENTRY[1] TransactionInformation; // Flexible array
}

struct KTMOBJECT_CURSOR
{
    GUID    LastQuery;
    uint    ObjectIdCount;
    GUID[1] ObjectIds; // Flexible array
}

