module windows.windowsmediaformat;

public import windows.core;
public import windows.automation : BSTR, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.directshow : AM_MEDIA_TYPE, BITMAPINFOHEADER, IAMVideoAccelerator, IPin;
public import windows.displaydevices : RECT;
public import windows.structuredstorage : IStream;
public import windows.systemservices : BOOL;
public import windows.windowsandmessaging : LPARAM;

extern(Windows):


// Enums


enum : int
{
    AM_CONFIGASFWRITER_PARAM_AUTOINDEX    = 0x00000001,
    AM_CONFIGASFWRITER_PARAM_MULTIPASS    = 0x00000002,
    AM_CONFIGASFWRITER_PARAM_DONTCOMPRESS = 0x00000003,
}
alias _AM_ASFWRITERCONFIG_PARAM = int;

enum : int
{
    WEBSTREAM_SAMPLE_TYPE_FILE   = 0x00000001,
    WEBSTREAM_SAMPLE_TYPE_RENDER = 0x00000002,
}
alias __MIDL___MIDL_itf_wmsdkidl_0000_0000_0001 = int;

enum : int
{
    WM_SF_CLEANPOINT    = 0x00000001,
    WM_SF_DISCONTINUITY = 0x00000002,
    WM_SF_DATALOSS      = 0x00000004,
}
alias __MIDL___MIDL_itf_wmsdkidl_0000_0000_0002 = int;

enum : int
{
    WM_SFEX_NOTASYNCPOINT = 0x00000002,
    WM_SFEX_DATALOSS      = 0x00000004,
}
alias __MIDL___MIDL_itf_wmsdkidl_0000_0000_0003 = int;

enum : int
{
    WMT_ERROR                       = 0x00000000,
    WMT_OPENED                      = 0x00000001,
    WMT_BUFFERING_START             = 0x00000002,
    WMT_BUFFERING_STOP              = 0x00000003,
    WMT_EOF                         = 0x00000004,
    WMT_END_OF_FILE                 = 0x00000004,
    WMT_END_OF_SEGMENT              = 0x00000005,
    WMT_END_OF_STREAMING            = 0x00000006,
    WMT_LOCATING                    = 0x00000007,
    WMT_CONNECTING                  = 0x00000008,
    WMT_NO_RIGHTS                   = 0x00000009,
    WMT_MISSING_CODEC               = 0x0000000a,
    WMT_STARTED                     = 0x0000000b,
    WMT_STOPPED                     = 0x0000000c,
    WMT_CLOSED                      = 0x0000000d,
    WMT_STRIDING                    = 0x0000000e,
    WMT_TIMER                       = 0x0000000f,
    WMT_INDEX_PROGRESS              = 0x00000010,
    WMT_SAVEAS_START                = 0x00000011,
    WMT_SAVEAS_STOP                 = 0x00000012,
    WMT_NEW_SOURCEFLAGS             = 0x00000013,
    WMT_NEW_METADATA                = 0x00000014,
    WMT_BACKUPRESTORE_BEGIN         = 0x00000015,
    WMT_SOURCE_SWITCH               = 0x00000016,
    WMT_ACQUIRE_LICENSE             = 0x00000017,
    WMT_INDIVIDUALIZE               = 0x00000018,
    WMT_NEEDS_INDIVIDUALIZATION     = 0x00000019,
    WMT_NO_RIGHTS_EX                = 0x0000001a,
    WMT_BACKUPRESTORE_END           = 0x0000001b,
    WMT_BACKUPRESTORE_CONNECTING    = 0x0000001c,
    WMT_BACKUPRESTORE_DISCONNECTING = 0x0000001d,
    WMT_ERROR_WITHURL               = 0x0000001e,
    WMT_RESTRICTED_LICENSE          = 0x0000001f,
    WMT_CLIENT_CONNECT              = 0x00000020,
    WMT_CLIENT_DISCONNECT           = 0x00000021,
    WMT_NATIVE_OUTPUT_PROPS_CHANGED = 0x00000022,
    WMT_RECONNECT_START             = 0x00000023,
    WMT_RECONNECT_END               = 0x00000024,
    WMT_CLIENT_CONNECT_EX           = 0x00000025,
    WMT_CLIENT_DISCONNECT_EX        = 0x00000026,
    WMT_SET_FEC_SPAN                = 0x00000027,
    WMT_PREROLL_READY               = 0x00000028,
    WMT_PREROLL_COMPLETE            = 0x00000029,
    WMT_CLIENT_PROPERTIES           = 0x0000002a,
    WMT_LICENSEURL_SIGNATURE_STATE  = 0x0000002b,
    WMT_INIT_PLAYLIST_BURN          = 0x0000002c,
    WMT_TRANSCRYPTOR_INIT           = 0x0000002d,
    WMT_TRANSCRYPTOR_SEEKED         = 0x0000002e,
    WMT_TRANSCRYPTOR_READ           = 0x0000002f,
    WMT_TRANSCRYPTOR_CLOSED         = 0x00000030,
    WMT_PROXIMITY_RESULT            = 0x00000031,
    WMT_PROXIMITY_COMPLETED         = 0x00000032,
    WMT_CONTENT_ENABLER             = 0x00000033,
}
alias WMT_STATUS = int;

enum : int
{
    WMT_OFF             = 0x00000000,
    WMT_CLEANPOINT_ONLY = 0x00000001,
    WMT_ON              = 0x00000002,
}
alias WMT_STREAM_SELECTION = int;

enum : int
{
    WMT_IT_NONE   = 0x00000000,
    WMT_IT_BITMAP = 0x00000001,
    WMT_IT_JPEG   = 0x00000002,
    WMT_IT_GIF    = 0x00000003,
}
alias WMT_IMAGE_TYPE = int;

enum : int
{
    WMT_TYPE_DWORD  = 0x00000000,
    WMT_TYPE_STRING = 0x00000001,
    WMT_TYPE_BINARY = 0x00000002,
    WMT_TYPE_BOOL   = 0x00000003,
    WMT_TYPE_QWORD  = 0x00000004,
    WMT_TYPE_WORD   = 0x00000005,
    WMT_TYPE_GUID   = 0x00000006,
}
alias WMT_ATTR_DATATYPE = int;

enum : int
{
    WMT_IMAGETYPE_BITMAP = 0x00000001,
    WMT_IMAGETYPE_JPEG   = 0x00000002,
    WMT_IMAGETYPE_GIF    = 0x00000003,
}
alias WMT_ATTR_IMAGETYPE = int;

enum : int
{
    WMT_VER_4_0 = 0x00040000,
    WMT_VER_7_0 = 0x00070000,
    WMT_VER_8_0 = 0x00080000,
    WMT_VER_9_0 = 0x00090000,
}
alias WMT_VERSION = int;

enum : int
{
    WMT_Storage_Format_MP3 = 0x00000000,
    WMT_Storage_Format_V1  = 0x00000001,
}
alias WMT_STORAGE_FORMAT = int;

enum : int
{
    WMT_DRMLA_UNTRUSTED = 0x00000000,
    WMT_DRMLA_TRUSTED   = 0x00000001,
    WMT_DRMLA_TAMPERED  = 0x00000002,
}
alias WMT_DRMLA_TRUST = int;

enum : int
{
    WMT_Transport_Type_Unreliable = 0x00000000,
    WMT_Transport_Type_Reliable   = 0x00000001,
}
alias WMT_TRANSPORT_TYPE = int;

enum : int
{
    WMT_PROTOCOL_HTTP = 0x00000000,
}
alias WMT_NET_PROTOCOL = int;

enum : int
{
    WMT_PLAY_MODE_AUTOSELECT = 0x00000000,
    WMT_PLAY_MODE_LOCAL      = 0x00000001,
    WMT_PLAY_MODE_DOWNLOAD   = 0x00000002,
    WMT_PLAY_MODE_STREAMING  = 0x00000003,
}
alias WMT_PLAY_MODE = int;

enum : int
{
    WMT_PROXY_SETTING_NONE    = 0x00000000,
    WMT_PROXY_SETTING_MANUAL  = 0x00000001,
    WMT_PROXY_SETTING_AUTO    = 0x00000002,
    WMT_PROXY_SETTING_BROWSER = 0x00000003,
    WMT_PROXY_SETTING_MAX     = 0x00000004,
}
alias WMT_PROXY_SETTINGS = int;

enum : int
{
    WMT_CODECINFO_AUDIO   = 0x00000000,
    WMT_CODECINFO_VIDEO   = 0x00000001,
    WMT_CODECINFO_UNKNOWN = 0xffffffff,
}
alias WMT_CODEC_INFO_TYPE = int;

enum : int
{
    WM_DM_NOTINTERLACED                          = 0x00000000,
    WM_DM_DEINTERLACE_NORMAL                     = 0x00000001,
    WM_DM_DEINTERLACE_HALFSIZE                   = 0x00000002,
    WM_DM_DEINTERLACE_HALFSIZEDOUBLERATE         = 0x00000003,
    WM_DM_DEINTERLACE_INVERSETELECINE            = 0x00000004,
    WM_DM_DEINTERLACE_VERTICALHALFSIZEDOUBLERATE = 0x00000005,
}
alias __MIDL___MIDL_itf_wmsdkidl_0000_0000_0004 = int;

enum : int
{
    WM_DM_IT_DISABLE_COHERENT_MODE            = 0x00000000,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_AA_TOP    = 0x00000001,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_BB_TOP    = 0x00000002,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_BC_TOP    = 0x00000003,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_CD_TOP    = 0x00000004,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_DD_TOP    = 0x00000005,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_AA_BOTTOM = 0x00000006,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_BB_BOTTOM = 0x00000007,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_BC_BOTTOM = 0x00000008,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_CD_BOTTOM = 0x00000009,
    WM_DM_IT_FIRST_FRAME_IN_CLIP_IS_DD_BOTTOM = 0x0000000a,
}
alias __MIDL___MIDL_itf_wmsdkidl_0000_0000_0005 = int;

enum : int
{
    WMT_OFFSET_FORMAT_100NS             = 0x00000000,
    WMT_OFFSET_FORMAT_FRAME_NUMBERS     = 0x00000001,
    WMT_OFFSET_FORMAT_PLAYLIST_OFFSET   = 0x00000002,
    WMT_OFFSET_FORMAT_TIMECODE          = 0x00000003,
    WMT_OFFSET_FORMAT_100NS_APPROXIMATE = 0x00000004,
}
alias WMT_OFFSET_FORMAT = int;

enum : int
{
    WMT_IT_PRESENTATION_TIME = 0x00000000,
    WMT_IT_FRAME_NUMBERS     = 0x00000001,
    WMT_IT_TIMECODE          = 0x00000002,
}
alias WMT_INDEXER_TYPE = int;

enum : int
{
    WMT_IT_NEAREST_DATA_UNIT   = 0x00000001,
    WMT_IT_NEAREST_OBJECT      = 0x00000002,
    WMT_IT_NEAREST_CLEAN_POINT = 0x00000003,
}
alias WMT_INDEX_TYPE = int;

enum : int
{
    WMT_FM_SINGLE_BUFFERS      = 0x00000001,
    WMT_FM_FILESINK_DATA_UNITS = 0x00000002,
    WMT_FM_FILESINK_UNBUFFERED = 0x00000004,
}
alias WMT_FILESINK_MODE = int;

enum : int
{
    WMT_MS_CLASS_MUSIC  = 0x00000000,
    WMT_MS_CLASS_SPEECH = 0x00000001,
    WMT_MS_CLASS_MIXED  = 0x00000002,
}
alias WMT_MUSICSPEECH_CLASS_MODE = int;

enum : int
{
    WMT_WMETYPE_AUDIO = 0x00000001,
    WMT_WMETYPE_VIDEO = 0x00000002,
}
alias WMT_WATERMARK_ENTRY_TYPE = int;

enum : int
{
    WM_PLAYBACK_DRC_HIGH   = 0x00000000,
    WM_PLAYBACK_DRC_MEDIUM = 0x00000001,
    WM_PLAYBACK_DRC_LOW    = 0x00000002,
}
alias __MIDL___MIDL_itf_wmsdkidl_0000_0000_0006 = int;

enum : int
{
    WMT_TIMECODE_FRAMERATE_30     = 0x00000000,
    WMT_TIMECODE_FRAMERATE_30DROP = 0x00000001,
    WMT_TIMECODE_FRAMERATE_25     = 0x00000002,
    WMT_TIMECODE_FRAMERATE_24     = 0x00000003,
}
alias __MIDL___MIDL_itf_wmsdkidl_0000_0000_0007 = int;

enum : int
{
    WMT_CREDENTIAL_SAVE       = 0x00000001,
    WMT_CREDENTIAL_DONT_CACHE = 0x00000002,
    WMT_CREDENTIAL_CLEAR_TEXT = 0x00000004,
    WMT_CREDENTIAL_PROXY      = 0x00000008,
    WMT_CREDENTIAL_ENCRYPT    = 0x00000010,
}
alias WMT_CREDENTIAL_FLAGS = int;

enum : int
{
    WM_AETYPE_INCLUDE = 0x00000069,
    WM_AETYPE_EXCLUDE = 0x00000065,
}
alias WM_AETYPE = int;

enum : int
{
    WMT_RIGHT_PLAYBACK                = 0x00000001,
    WMT_RIGHT_COPY_TO_NON_SDMI_DEVICE = 0x00000002,
    WMT_RIGHT_COPY_TO_CD              = 0x00000008,
    WMT_RIGHT_COPY_TO_SDMI_DEVICE     = 0x00000010,
    WMT_RIGHT_ONE_TIME                = 0x00000020,
    WMT_RIGHT_SAVE_STREAM_PROTECTED   = 0x00000040,
    WMT_RIGHT_COPY                    = 0x00000080,
    WMT_RIGHT_COLLABORATIVE_PLAY      = 0x00000100,
    WMT_RIGHT_SDMI_TRIGGER            = 0x00010000,
    WMT_RIGHT_SDMI_NOMORECOPIES       = 0x00020000,
}
alias WMT_RIGHTS = int;

enum : int
{
    NETSOURCE_URLCREDPOLICY_SETTING_SILENTLOGONOK  = 0x00000000,
    NETSOURCE_URLCREDPOLICY_SETTING_MUSTPROMPTUSER = 0x00000001,
    NETSOURCE_URLCREDPOLICY_SETTING_ANONYMOUSONLY  = 0x00000002,
}
alias NETSOURCE_URLCREDPOLICY_SETTINGS = int;

// Constants


enum uint g_dwWMSpecialAttributes = 0x00000014;

enum : const(wchar)*
{
    g_wszWMBitrate        = "Bitrate",
    g_wszWMSeekable       = "Seekable",
    g_wszWMStridable      = "Stridable",
    g_wszWMBroadcast      = "Broadcast",
    g_wszWMProtected      = "Is_Protected",
    g_wszWMTrusted        = "Is_Trusted",
    g_wszWMSignature_Name = "Signature_Name",
}

enum : const(wchar)*
{
    g_wszWMHasImage       = "HasImage",
    g_wszWMHasScript      = "HasScript",
    g_wszWMHasVideo       = "HasVideo",
    g_wszWMCurrentBitrate = "CurrentBitrate",
}

enum const(wchar)* g_wszWMHasAttachedImages = "HasAttachedImages";
enum const(wchar)* g_wszWMSkipForward = "Can_Skip_Forward";

enum : const(wchar)*
{
    g_wszWMFileSize               = "FileSize",
    g_wszWMHasArbitraryDataStream = "HasArbitraryDataStream",
}

enum const(wchar)* g_wszWMContainerFormat = "WM/ContainerFormat";

enum : const(wchar)*
{
    g_wszWMTitle       = "Title",
    g_wszWMTitleSort   = "TitleSort",
    g_wszWMAuthor      = "Author",
    g_wszWMAuthorSort  = "AuthorSort",
    g_wszWMDescription = "Description",
}

enum : const(wchar)*
{
    g_wszWMCopyright        = "Copyright",
    g_wszWMUse_DRM          = "Use_DRM",
    g_wszWMDRM_Flags        = "DRM_Flags",
    g_wszWMDRM_Level        = "DRM_Level",
    g_wszWMUse_Advanced_DRM = "Use_Advanced_DRM",
}

enum : const(wchar)*
{
    g_wszWMDRM_KeyID                 = "DRM_KeyID",
    g_wszWMDRM_ContentID             = "DRM_ContentID",
    g_wszWMDRM_SourceID              = "DRM_SourceID",
    g_wszWMDRM_IndividualizedVersion = "DRM_IndividualizedVersion",
}

enum : const(wchar)*
{
    g_wszWMDRM_V1LicenseAcqURL   = "DRM_V1LicenseAcqURL",
    g_wszWMDRM_HeaderSignPrivKey = "DRM_HeaderSignPrivKey",
}

enum : const(wchar)*
{
    g_wszWMDRM_LASignatureCert       = "DRM_LASignatureCert",
    g_wszWMDRM_LASignatureLicSrvCert = "DRM_LASignatureLicSrvCert",
    g_wszWMDRM_LASignatureRootCert   = "DRM_LASignatureRootCert",
}

enum const(wchar)* g_wszWMAlbumTitleSort = "WM/AlbumTitleSort";
enum const(wchar)* g_wszWMPromotionURL = "WM/PromotionURL";

enum : const(wchar)*
{
    g_wszWMGenre        = "WM/Genre",
    g_wszWMYear         = "WM/Year",
    g_wszWMGenreID      = "WM/GenreID",
    g_wszWMMCDI         = "WM/MCDI",
    g_wszWMComposer     = "WM/Composer",
    g_wszWMComposerSort = "WM/ComposerSort",
}

enum : const(wchar)*
{
    g_wszWMTrackNumber = "WM/TrackNumber",
    g_wszWMToolName    = "WM/ToolName",
    g_wszWMToolVersion = "WM/ToolVersion",
}

enum : const(wchar)*
{
    g_wszWMAlbumArtist     = "WM/AlbumArtist",
    g_wszWMAlbumArtistSort = "WM/AlbumArtistSort",
}

enum : const(wchar)*
{
    g_wszWMBannerImageData = "BannerImageData",
    g_wszWMBannerImageURL  = "BannerImageURL",
}

enum : const(wchar)*
{
    g_wszWMAspectRatioX = "AspectRatioX",
    g_wszWMAspectRatioY = "AspectRatioY",
}

enum uint g_dwWMNSCAttributes = 0x00000005;

enum : const(wchar)*
{
    g_wszWMNSCAddress     = "NSC_Address",
    g_wszWMNSCPhone       = "NSC_Phone",
    g_wszWMNSCEmail       = "NSC_Email",
    g_wszWMNSCDescription = "NSC_Description",
}

enum : const(wchar)*
{
    g_wszWMConductor               = "WM/Conductor",
    g_wszWMProducer                = "WM/Producer",
    g_wszWMDirector                = "WM/Director",
    g_wszWMContentGroupDescription = "WM/ContentGroupDescription",
}

enum : const(wchar)*
{
    g_wszWMPartOfSet      = "WM/PartOfSet",
    g_wszWMProtectionType = "WM/ProtectionType",
}

enum : const(wchar)*
{
    g_wszWMVideoWidth     = "WM/VideoWidth",
    g_wszWMVideoFrameRate = "WM/VideoFrameRate",
}

enum const(wchar)* g_wszWMMediaClassSecondaryID = "WM/MediaClassSecondaryID";

enum : const(wchar)*
{
    g_wszWMCategory            = "WM/Category",
    g_wszWMPicture             = "WM/Picture",
    g_wszWMLyrics_Synchronised = "WM/Lyrics_Synchronised",
}

enum : const(wchar)*
{
    g_wszWMOriginalArtist      = "WM/OriginalArtist",
    g_wszWMOriginalAlbumTitle  = "WM/OriginalAlbumTitle",
    g_wszWMOriginalReleaseYear = "WM/OriginalReleaseYear",
    g_wszWMOriginalFilename    = "WM/OriginalFilename",
}

enum : const(wchar)*
{
    g_wszWMEncodedBy        = "WM/EncodedBy",
    g_wszWMEncodingSettings = "WM/EncodingSettings",
    g_wszWMEncodingTime     = "WM/EncodingTime",
}

enum : const(wchar)*
{
    g_wszWMUserWebURL     = "WM/UserWebURL",
    g_wszWMAudioFileURL   = "WM/AudioFileURL",
    g_wszWMAudioSourceURL = "WM/AudioSourceURL",
}

enum const(wchar)* g_wszWMParentalRating = "WM/ParentalRating";

enum : const(wchar)*
{
    g_wszWMInitialKey          = "WM/InitialKey",
    g_wszWMMood                = "WM/Mood",
    g_wszWMText                = "WM/Text",
    g_wszWMDVDID               = "WM/DVDID",
    g_wszWMWMContentID         = "WM/WMContentID",
    g_wszWMWMCollectionID      = "WM/WMCollectionID",
    g_wszWMWMCollectionGroupID = "WM/WMCollectionGroupID",
}

enum : const(wchar)*
{
    g_wszWMModifiedBy        = "WM/ModifiedBy",
    g_wszWMRadioStationName  = "WM/RadioStationName",
    g_wszWMRadioStationOwner = "WM/RadioStationOwner",
}

enum : const(wchar)*
{
    g_wszWMCodec          = "WM/Codec",
    g_wszWMDRM            = "WM/DRM",
    g_wszWMISRC           = "WM/ISRC",
    g_wszWMProvider       = "WM/Provider",
    g_wszWMProviderRating = "WM/ProviderRating",
    g_wszWMProviderStyle  = "WM/ProviderStyle",
}

enum const(wchar)* g_wszWMSubscriptionContentID = "WM/SubscriptionContentID";

enum : const(wchar)*
{
    g_wszWMWMADRCPeakTarget       = "WM/WMADRCPeakTarget",
    g_wszWMWMADRCAverageReference = "WM/WMADRCAverageReference",
    g_wszWMWMADRCAverageTarget    = "WM/WMADRCAverageTarget",
}

enum const(wchar)* g_wszWMPeakBitrate = "WM/PeakBitrate";
enum const(wchar)* g_wszWMASFSecurityObjectsSize = "WM/ASFSecurityObjectsSize";
enum const(wchar)* g_wszWMSubTitleDescription = "WM/SubTitleDescription";
enum const(wchar)* g_wszWMParentalRatingReason = "WM/ParentalRatingReason";

enum : const(wchar)*
{
    g_wszWMMediaStationCallSign    = "WM/MediaStationCallSign",
    g_wszWMMediaStationName        = "WM/MediaStationName",
    g_wszWMMediaNetworkAffiliation = "WM/MediaNetworkAffiliation",
}

enum const(wchar)* g_wszWMMediaOriginalBroadcastDateTime = "WM/MediaOriginalBroadcastDateTime";
enum const(wchar)* g_wszWMVideoClosedCaptioning = "WM/VideoClosedCaptioning";

enum : const(wchar)*
{
    g_wszWMMediaIsLive       = "WM/MediaIsLive",
    g_wszWMMediaIsTape       = "WM/MediaIsTape",
    g_wszWMMediaIsDelay      = "WM/MediaIsDelay",
    g_wszWMMediaIsSubtitled  = "WM/MediaIsSubtitled",
    g_wszWMMediaIsPremiere   = "WM/MediaIsPremiere",
    g_wszWMMediaIsFinale     = "WM/MediaIsFinale",
    g_wszWMMediaIsSAP        = "WM/MediaIsSAP",
    g_wszWMProviderCopyright = "WM/ProviderCopyright",
}

enum : const(wchar)*
{
    g_wszWMADID                       = "WM/ADID",
    g_wszWMWMShadowFileSourceFileType = "WM/WMShadowFileSourceFileType",
    g_wszWMWMShadowFileSourceDRMType  = "WM/WMShadowFileSourceDRMType",
}

enum const(wchar)* g_wszWMWMCPDistributorID = "WM/WMCPDistributorID";
enum const(wchar)* g_wszWMEpisodeNumber = "WM/EpisodeNumber";
enum const(wchar)* g_wszJustInTimeDecode = "JustInTimeDecode";
enum const(wchar)* g_wszSoftwareScaling = "SoftwareScaling";
enum const(wchar)* g_wszScrambledAudio = "ScrambledAudio";
enum const(wchar)* g_wszEnableDiscreteOutput = "EnableDiscreteOutput";
enum const(wchar)* g_wszDynamicRangeControl = "DynamicRangeControl";
enum const(wchar)* g_wszVideoSampleDurations = "VideoSampleDurations";
enum const(wchar)* g_wszEnableWMAProSPDIFOutput = "EnableWMAProSPDIFOutput";
enum const(wchar)* g_wszInitialPatternForInverseTelecine = "InitialPatternForInverseTelecine";

enum : const(wchar)*
{
    g_wszWatermarkCLSID  = "WatermarkCLSID",
    g_wszWatermarkConfig = "WatermarkConfig",
}

enum const(wchar)* g_wszFixedFrameRate = "FixedFrameRate";
enum const(wchar)* g_wszOriginalWaveFormat = "_ORIGINALWAVEFORMAT";
enum const(wchar)* g_wszComplexity = "_COMPLEXITYEX";
enum const(wchar)* g_wszReloadIndexOnSeek = "ReloadIndexOnSeek";
enum const(wchar)* g_wszFailSeekOnError = "FailSeekOnError";
enum const(wchar)* g_wszUsePacketAtSeekPoint = "UsePacketAtSeekPoint";
enum const(wchar)* g_wszSourceMaxBytesAtOnce = "SourceMaxBytesAtOnce";

enum : const(wchar)*
{
    g_wszVBRQuality         = "_VBRQUALITY",
    g_wszVBRBitrateMax      = "_RMAX",
    g_wszVBRBufferWindowMax = "_BMAX",
}

enum const(wchar)* g_wszBufferAverage = "Buffer Average";

enum : const(wchar)*
{
    g_wszComplexityOffline = "_COMPLEXITYEXOFFLINE",
    g_wszComplexityLive    = "_COMPLEXITYEXLIVE",
}

enum const(wchar)* g_wszNumPasses = "_PASSESUSED";
enum const(wchar)* g_wszMusicClassMode = "MusicClassMode";
enum const(wchar)* g_wszMixedClassMode = "MixedClassMode";
enum const(wchar)* g_wszPeakValue = "PeakValue";

enum : const(wchar)*
{
    g_wszFold6To2Channels3      = "Fold6To2Channels3",
    g_wszFoldToChannelsTemplate = "Fold%luTo%luChannels%lu",
}

enum const(wchar)* g_wszEnableFrameInterpolation = "EnableFrameInterpolation";
enum const(wchar)* g_wszWMIsCompilation = "WM/IsCompilation";

// Structs


struct AM_WMT_EVENT_DATA
{
    HRESULT hrStatus;
    void*   pData;
}

struct WM_STREAM_PRIORITY_RECORD
{
align (2):
    ushort wStreamNumber;
    BOOL   fMandatory;
}

struct WM_WRITER_STATISTICS
{
    ulong qwSampleCount;
    ulong qwByteCount;
    ulong qwDroppedSampleCount;
    ulong qwDroppedByteCount;
    uint  dwCurrentBitrate;
    uint  dwAverageBitrate;
    uint  dwExpectedBitrate;
    uint  dwCurrentSampleRate;
    uint  dwAverageSampleRate;
    uint  dwExpectedSampleRate;
}

struct WM_WRITER_STATISTICS_EX
{
    uint dwBitratePlusOverhead;
    uint dwCurrentSampleDropRateInQueue;
    uint dwCurrentSampleDropRateInCodec;
    uint dwCurrentSampleDropRateInMultiplexer;
    uint dwTotalSampleDropsInQueue;
    uint dwTotalSampleDropsInCodec;
    uint dwTotalSampleDropsInMultiplexer;
}

struct WM_READER_STATISTICS
{
    uint   cbSize;
    uint   dwBandwidth;
    uint   cPacketsReceived;
    uint   cPacketsRecovered;
    uint   cPacketsLost;
    ushort wQuality;
}

struct WM_READER_CLIENTINFO
{
    uint    cbSize;
    ushort* wszLang;
    ushort* wszBrowserUserAgent;
    ushort* wszBrowserWebPage;
    ulong   qwReserved;
    LPARAM* pReserved;
    ushort* wszHostExe;
    ulong   qwHostVersion;
    ushort* wszPlayerUserAgent;
}

struct WM_CLIENT_PROPERTIES
{
    uint dwIPAddress;
    uint dwPort;
}

struct WM_CLIENT_PROPERTIES_EX
{
    uint          cbSize;
    const(wchar)* pwszIPAddress;
    const(wchar)* pwszPort;
    const(wchar)* pwszDNSName;
}

struct WM_PORT_NUMBER_RANGE
{
    ushort wPortBegin;
    ushort wPortEnd;
}

struct WMT_BUFFER_SEGMENT
{
    INSSBuffer pBuffer;
    uint       cbOffset;
    uint       cbLength;
}

struct WMT_PAYLOAD_FRAGMENT
{
    uint               dwPayloadIndex;
    WMT_BUFFER_SEGMENT segmentData;
}

struct WMT_FILESINK_DATA_UNIT
{
    WMT_BUFFER_SEGMENT  packetHeaderBuffer;
    uint                cPayloads;
    WMT_BUFFER_SEGMENT* pPayloadHeaderBuffers;
    uint                cPayloadDataFragments;
    WMT_PAYLOAD_FRAGMENT* pPayloadDataFragments;
}

struct WMT_WEBSTREAM_FORMAT
{
    ushort cbSize;
    ushort cbSampleHeaderFixedData;
    ushort wVersion;
    ushort wReserved;
}

struct WMT_WEBSTREAM_SAMPLE_HEADER
{
    ushort    cbLength;
    ushort    wPart;
    ushort    cTotalParts;
    ushort    wSampleType;
    ushort[1] wszURL;
}

struct WM_ADDRESS_ACCESSENTRY
{
    uint dwIPAddress;
    uint dwMask;
}

struct WM_PICTURE
{
align (1):
    const(wchar)* pwszMIMEType;
    ubyte         bPictureType;
    const(wchar)* pwszDescription;
    uint          dwDataLen;
    ubyte*        pbData;
}

struct WM_SYNCHRONISED_LYRICS
{
align (1):
    ubyte         bTimeStampFormat;
    ubyte         bContentType;
    const(wchar)* pwszContentDescriptor;
    uint          dwLyricsLen;
    ubyte*        pbLyrics;
}

struct WM_USER_WEB_URL
{
align (1):
    const(wchar)* pwszDescription;
    const(wchar)* pwszURL;
}

struct WM_USER_TEXT
{
align (1):
    const(wchar)* pwszDescription;
    const(wchar)* pwszText;
}

struct WM_LEAKY_BUCKET_PAIR
{
align (1):
    uint dwBitrate;
    uint msBufferWindow;
}

struct WM_STREAM_TYPE_INFO
{
align (1):
    GUID guidMajorType;
    uint cbFormat;
}

struct WMT_WATERMARK_ENTRY
{
    WMT_WATERMARK_ENTRY_TYPE wmetType;
    GUID          clsid;
    uint          cbDisplayName;
    const(wchar)* pwszDisplayName;
}

struct WMT_VIDEOIMAGE_SAMPLE
{
    uint dwMagic;
    uint cbStruct;
    uint dwControlFlags;
    uint dwInputFlagsCur;
    int  lCurMotionXtoX;
    int  lCurMotionYtoX;
    int  lCurMotionXoffset;
    int  lCurMotionXtoY;
    int  lCurMotionYtoY;
    int  lCurMotionYoffset;
    int  lCurBlendCoef1;
    int  lCurBlendCoef2;
    uint dwInputFlagsPrev;
    int  lPrevMotionXtoX;
    int  lPrevMotionYtoX;
    int  lPrevMotionXoffset;
    int  lPrevMotionXtoY;
    int  lPrevMotionYtoY;
    int  lPrevMotionYoffset;
    int  lPrevBlendCoef1;
    int  lPrevBlendCoef2;
}

struct WMT_VIDEOIMAGE_SAMPLE2
{
    uint  dwMagic;
    uint  dwStructSize;
    uint  dwControlFlags;
    uint  dwViewportWidth;
    uint  dwViewportHeight;
    uint  dwCurrImageWidth;
    uint  dwCurrImageHeight;
    float fCurrRegionX0;
    float fCurrRegionY0;
    float fCurrRegionWidth;
    float fCurrRegionHeight;
    float fCurrBlendCoef;
    uint  dwPrevImageWidth;
    uint  dwPrevImageHeight;
    float fPrevRegionX0;
    float fPrevRegionY0;
    float fPrevRegionWidth;
    float fPrevRegionHeight;
    float fPrevBlendCoef;
    uint  dwEffectType;
    uint  dwNumEffectParas;
    float fEffectPara0;
    float fEffectPara1;
    float fEffectPara2;
    float fEffectPara3;
    float fEffectPara4;
    BOOL  bKeepPrevImage;
}

struct WM_MEDIA_TYPE
{
    GUID     majortype;
    GUID     subtype;
    BOOL     bFixedSizeSamples;
    BOOL     bTemporalCompression;
    uint     lSampleSize;
    GUID     formattype;
    IUnknown pUnk;
    uint     cbFormat;
    ubyte*   pbFormat;
}

struct WMVIDEOINFOHEADER
{
    RECT             rcSource;
    RECT             rcTarget;
    uint             dwBitRate;
    uint             dwBitErrorRate;
    long             AvgTimePerFrame;
    BITMAPINFOHEADER bmiHeader;
}

struct WMVIDEOINFOHEADER2
{
    RECT             rcSource;
    RECT             rcTarget;
    uint             dwBitRate;
    uint             dwBitErrorRate;
    long             AvgTimePerFrame;
    uint             dwInterlaceFlags;
    uint             dwCopyProtectFlags;
    uint             dwPictAspectRatioX;
    uint             dwPictAspectRatioY;
    uint             dwReserved1;
    uint             dwReserved2;
    BITMAPINFOHEADER bmiHeader;
}

struct WMMPEG2VIDEOINFO
{
    WMVIDEOINFOHEADER2 hdr;
    uint               dwStartTimeCode;
    uint               cbSequenceHeader;
    uint               dwProfile;
    uint               dwLevel;
    uint               dwFlags;
    uint[1]            dwSequenceHeader;
}

struct WMSCRIPTFORMAT
{
    GUID scriptType;
}

struct WMT_COLORSPACEINFO_EXTENSION_DATA
{
    ubyte ucColorPrimaries;
    ubyte ucColorTransferChar;
    ubyte ucColorMatrixCoef;
}

struct WMT_TIMECODE_EXTENSION_DATA
{
align (2):
    ushort wRange;
    uint   dwTimecode;
    uint   dwUserbits;
    uint   dwAmFlags;
}

struct DRM_VAL16
{
    ubyte[16] val;
}

struct WMDRM_IMPORT_INIT_STRUCT
{
    uint   dwVersion;
    uint   cbEncryptedSessionKeyMessage;
    ubyte* pbEncryptedSessionKeyMessage;
    uint   cbEncryptedKeyMessage;
    ubyte* pbEncryptedKeyMessage;
}

struct DRM_MINIMUM_OUTPUT_PROTECTION_LEVELS
{
    ushort wCompressedDigitalVideo;
    ushort wUncompressedDigitalVideo;
    ushort wAnalogVideo;
    ushort wCompressedDigitalAudio;
    ushort wUncompressedDigitalAudio;
}

struct DRM_OPL_OUTPUT_IDS
{
    ushort cIds;
    GUID*  rgIds;
}

struct DRM_OUTPUT_PROTECTION
{
    GUID  guidId;
    ubyte bConfigData;
}

struct DRM_VIDEO_OUTPUT_PROTECTION_IDS
{
    ushort cEntries;
    DRM_OUTPUT_PROTECTION* rgVop;
}

struct DRM_PLAY_OPL
{
    DRM_MINIMUM_OUTPUT_PROTECTION_LEVELS minOPL;
    DRM_OPL_OUTPUT_IDS oplIdReserved;
    DRM_VIDEO_OUTPUT_PROTECTION_IDS vopi;
}

struct DRM_COPY_OPL
{
    ushort             wMinimumCopyLevel;
    DRM_OPL_OUTPUT_IDS oplIdIncludes;
    DRM_OPL_OUTPUT_IDS oplIdExcludes;
}

// Functions

@DllImport("WMVCore")
HRESULT WMIsContentProtected(const(wchar)* pwszFileName, int* pfIsProtected);

@DllImport("WMVCore")
HRESULT WMCreateWriter(IUnknown pUnkCert, IWMWriter* ppWriter);

@DllImport("WMVCore")
HRESULT WMCreateReader(IUnknown pUnkCert, uint dwRights, IWMReader* ppReader);

@DllImport("WMVCore")
HRESULT WMCreateSyncReader(IUnknown pUnkCert, uint dwRights, IWMSyncReader* ppSyncReader);

@DllImport("WMVCore")
HRESULT WMCreateEditor(IWMMetadataEditor* ppEditor);

@DllImport("WMVCore")
HRESULT WMCreateIndexer(IWMIndexer* ppIndexer);

@DllImport("WMVCore")
HRESULT WMCreateBackupRestorer(IUnknown pCallback, IWMLicenseBackup* ppBackup);

@DllImport("WMVCore")
HRESULT WMCreateProfileManager(IWMProfileManager* ppProfileManager);

@DllImport("WMVCore")
HRESULT WMCreateWriterFileSink(IWMWriterFileSink* ppSink);

@DllImport("WMVCore")
HRESULT WMCreateWriterNetworkSink(IWMWriterNetworkSink* ppSink);

@DllImport("WMVCore")
HRESULT WMCreateWriterPushSink(IWMWriterPushSink* ppSink);


// Interfaces

@GUID("6DD816D7-E740-4123-9E24-2444412644D8")
interface IAMWMBufferPass : IUnknown
{
    HRESULT SetNotify(IAMWMBufferPassCallback pCallback);
}

@GUID("B25B8372-D2D2-44B2-8653-1B8DAE332489")
interface IAMWMBufferPassCallback : IUnknown
{
    HRESULT Notify(INSSBuffer3 pNSSBuffer3, IPin pPin, long* prtStart, long* prtEnd);
}

@GUID("E1CD3524-03D7-11D2-9EED-006097D2D7CF")
interface INSSBuffer : IUnknown
{
    HRESULT GetLength(uint* pdwLength);
    HRESULT SetLength(uint dwLength);
    HRESULT GetMaxLength(uint* pdwLength);
    HRESULT GetBuffer(ubyte** ppdwBuffer);
    HRESULT GetBufferAndLength(ubyte** ppdwBuffer, uint* pdwLength);
}

@GUID("4F528693-1035-43FE-B428-757561AD3A68")
interface INSSBuffer2 : INSSBuffer
{
    HRESULT GetSampleProperties(uint cbProperties, ubyte* pbProperties);
    HRESULT SetSampleProperties(uint cbProperties, ubyte* pbProperties);
}

@GUID("C87CEAAF-75BE-4BC4-84EB-AC2798507672")
interface INSSBuffer3 : INSSBuffer2
{
    HRESULT SetProperty(GUID guidBufferProperty, void* pvBufferProperty, uint dwBufferPropertySize);
    HRESULT GetProperty(GUID guidBufferProperty, void* pvBufferProperty, uint* pdwBufferPropertySize);
}

@GUID("B6B8FD5A-32E2-49D4-A910-C26CC85465ED")
interface INSSBuffer4 : INSSBuffer3
{
    HRESULT GetPropertyCount(uint* pcBufferProperties);
    HRESULT GetPropertyByIndex(uint dwBufferPropertyIndex, GUID* pguidBufferProperty, void* pvBufferProperty, 
                               uint* pdwBufferPropertySize);
}

@GUID("61103CA4-2033-11D2-9EF1-006097D2D7CF")
interface IWMSBufferAllocator : IUnknown
{
    HRESULT AllocateBuffer(uint dwMaxBufferSize, INSSBuffer* ppBuffer);
    HRESULT AllocatePageSizeBuffer(uint dwMaxBufferSize, INSSBuffer* ppBuffer);
}

@GUID("96406BCE-2B2B-11D3-B36B-00C04F6108FF")
interface IWMMediaProps : IUnknown
{
    HRESULT GetType(GUID* pguidType);
    HRESULT GetMediaType(WM_MEDIA_TYPE* pType, uint* pcbType);
    HRESULT SetMediaType(WM_MEDIA_TYPE* pType);
}

@GUID("96406BCF-2B2B-11D3-B36B-00C04F6108FF")
interface IWMVideoMediaProps : IWMMediaProps
{
    HRESULT GetMaxKeyFrameSpacing(long* pllTime);
    HRESULT SetMaxKeyFrameSpacing(long llTime);
    HRESULT GetQuality(uint* pdwQuality);
    HRESULT SetQuality(uint dwQuality);
}

@GUID("96406BD4-2B2B-11D3-B36B-00C04F6108FF")
interface IWMWriter : IUnknown
{
    HRESULT SetProfileByID(const(GUID)* guidProfile);
    HRESULT SetProfile(IWMProfile pProfile);
    HRESULT SetOutputFilename(const(wchar)* pwszFilename);
    HRESULT GetInputCount(uint* pcInputs);
    HRESULT GetInputProps(uint dwInputNum, IWMInputMediaProps* ppInput);
    HRESULT SetInputProps(uint dwInputNum, IWMInputMediaProps pInput);
    HRESULT GetInputFormatCount(uint dwInputNumber, uint* pcFormats);
    HRESULT GetInputFormat(uint dwInputNumber, uint dwFormatNumber, IWMInputMediaProps* pProps);
    HRESULT BeginWriting();
    HRESULT EndWriting();
    HRESULT AllocateSample(uint dwSampleSize, INSSBuffer* ppSample);
    HRESULT WriteSample(uint dwInputNum, ulong cnsSampleTime, uint dwFlags, INSSBuffer pSample);
    HRESULT Flush();
}

@GUID("D6EA5DD0-12A0-43F4-90AB-A3FD451E6A07")
interface IWMDRMWriter : IUnknown
{
    HRESULT GenerateKeySeed(ushort* pwszKeySeed, uint* pcwchLength);
    HRESULT GenerateKeyID(ushort* pwszKeyID, uint* pcwchLength);
    HRESULT GenerateSigningKeyPair(ushort* pwszPrivKey, uint* pcwchPrivKeyLength, ushort* pwszPubKey, 
                                   uint* pcwchPubKeyLength);
    HRESULT SetDRMAttribute(ushort wStreamNum, const(wchar)* pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, 
                            ushort cbLength);
}

@GUID("38EE7A94-40E2-4E10-AA3F-33FD3210ED5B")
interface IWMDRMWriter2 : IWMDRMWriter
{
    HRESULT SetWMDRMNetEncryption(BOOL fSamplesEncrypted, ubyte* pbKeyID, uint cbKeyID);
}

@GUID("A7184082-A4AA-4DDE-AC9C-E75DBD1117CE")
interface IWMDRMWriter3 : IWMDRMWriter2
{
    HRESULT SetProtectStreamSamples(WMDRM_IMPORT_INIT_STRUCT* pImportInitStruct);
}

@GUID("96406BD5-2B2B-11D3-B36B-00C04F6108FF")
interface IWMInputMediaProps : IWMMediaProps
{
    HRESULT GetConnectionName(ushort* pwszName, ushort* pcchName);
    HRESULT GetGroupName(ushort* pwszName, ushort* pcchName);
}

@GUID("72995A79-5090-42A4-9C8C-D9D0B6D34BE5")
interface IWMPropertyVault : IUnknown
{
    HRESULT GetPropertyCount(uint* pdwCount);
    HRESULT GetPropertyByName(const(wchar)* pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, uint* pdwSize);
    HRESULT SetProperty(const(wchar)* pszName, WMT_ATTR_DATATYPE pType, ubyte* pValue, uint dwSize);
    HRESULT GetPropertyByIndex(uint dwIndex, const(wchar)* pszName, uint* pdwNameLen, WMT_ATTR_DATATYPE* pType, 
                               ubyte* pValue, uint* pdwSize);
    HRESULT CopyPropertiesFrom(IWMPropertyVault pIWMPropertyVault);
    HRESULT Clear();
}

@GUID("6816DAD3-2B4B-4C8E-8149-874C3483A753")
interface IWMIStreamProps : IUnknown
{
    HRESULT GetProperty(const(wchar)* pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, uint* pdwSize);
}

@GUID("96406BD6-2B2B-11D3-B36B-00C04F6108FF")
interface IWMReader : IUnknown
{
    HRESULT Open(const(wchar)* pwszURL, IWMReaderCallback pCallback, void* pvContext);
    HRESULT Close();
    HRESULT GetOutputCount(uint* pcOutputs);
    HRESULT GetOutputProps(uint dwOutputNum, IWMOutputMediaProps* ppOutput);
    HRESULT SetOutputProps(uint dwOutputNum, IWMOutputMediaProps pOutput);
    HRESULT GetOutputFormatCount(uint dwOutputNumber, uint* pcFormats);
    HRESULT GetOutputFormat(uint dwOutputNumber, uint dwFormatNumber, IWMOutputMediaProps* ppProps);
    HRESULT Start(ulong cnsStart, ulong cnsDuration, float fRate, void* pvContext);
    HRESULT Stop();
    HRESULT Pause();
    HRESULT Resume();
}

@GUID("9397F121-7705-4DC9-B049-98B698188414")
interface IWMSyncReader : IUnknown
{
    HRESULT Open(const(wchar)* pwszFilename);
    HRESULT Close();
    HRESULT SetRange(ulong cnsStartTime, long cnsDuration);
    HRESULT SetRangeByFrame(ushort wStreamNum, ulong qwFrameNumber, long cFramesToRead);
    HRESULT GetNextSample(ushort wStreamNum, INSSBuffer* ppSample, ulong* pcnsSampleTime, ulong* pcnsDuration, 
                          uint* pdwFlags, uint* pdwOutputNum, ushort* pwStreamNum);
    HRESULT SetStreamsSelected(ushort cStreamCount, ushort* pwStreamNumbers, WMT_STREAM_SELECTION* pSelections);
    HRESULT GetStreamSelected(ushort wStreamNum, WMT_STREAM_SELECTION* pSelection);
    HRESULT SetReadStreamSamples(ushort wStreamNum, BOOL fCompressed);
    HRESULT GetReadStreamSamples(ushort wStreamNum, int* pfCompressed);
    HRESULT GetOutputSetting(uint dwOutputNum, const(wchar)* pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, 
                             ushort* pcbLength);
    HRESULT SetOutputSetting(uint dwOutputNum, const(wchar)* pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, 
                             ushort cbLength);
    HRESULT GetOutputCount(uint* pcOutputs);
    HRESULT GetOutputProps(uint dwOutputNum, IWMOutputMediaProps* ppOutput);
    HRESULT SetOutputProps(uint dwOutputNum, IWMOutputMediaProps pOutput);
    HRESULT GetOutputFormatCount(uint dwOutputNum, uint* pcFormats);
    HRESULT GetOutputFormat(uint dwOutputNum, uint dwFormatNum, IWMOutputMediaProps* ppProps);
    HRESULT GetOutputNumberForStream(ushort wStreamNum, uint* pdwOutputNum);
    HRESULT GetStreamNumberForOutput(uint dwOutputNum, ushort* pwStreamNum);
    HRESULT GetMaxOutputSampleSize(uint dwOutput, uint* pcbMax);
    HRESULT GetMaxStreamSampleSize(ushort wStream, uint* pcbMax);
    HRESULT OpenStream(IStream pStream);
}

@GUID("FAED3D21-1B6B-4AF7-8CB6-3E189BBC187B")
interface IWMSyncReader2 : IWMSyncReader
{
    HRESULT SetRangeByTimecode(ushort wStreamNum, WMT_TIMECODE_EXTENSION_DATA* pStart, 
                               WMT_TIMECODE_EXTENSION_DATA* pEnd);
    HRESULT SetRangeByFrameEx(ushort wStreamNum, ulong qwFrameNumber, long cFramesToRead, ulong* pcnsStartTime);
    HRESULT SetAllocateForOutput(uint dwOutputNum, IWMReaderAllocatorEx pAllocator);
    HRESULT GetAllocateForOutput(uint dwOutputNum, IWMReaderAllocatorEx* ppAllocator);
    HRESULT SetAllocateForStream(ushort wStreamNum, IWMReaderAllocatorEx pAllocator);
    HRESULT GetAllocateForStream(ushort dwSreamNum, IWMReaderAllocatorEx* ppAllocator);
}

@GUID("96406BD7-2B2B-11D3-B36B-00C04F6108FF")
interface IWMOutputMediaProps : IWMMediaProps
{
    HRESULT GetStreamGroupName(ushort* pwszName, ushort* pcchName);
    HRESULT GetConnectionName(ushort* pwszName, ushort* pcchName);
}

@GUID("6D7CDC70-9888-11D3-8EDC-00C04F6109CF")
interface IWMStatusCallback : IUnknown
{
    HRESULT OnStatus(WMT_STATUS Status, HRESULT hr, WMT_ATTR_DATATYPE dwType, ubyte* pValue, void* pvContext);
}

@GUID("96406BD8-2B2B-11D3-B36B-00C04F6108FF")
interface IWMReaderCallback : IWMStatusCallback
{
    HRESULT OnSample(uint dwOutputNum, ulong cnsSampleTime, ulong cnsSampleDuration, uint dwFlags, 
                     INSSBuffer pSample, void* pvContext);
}

@GUID("342E0EB7-E651-450C-975B-2ACE2C90C48E")
interface IWMCredentialCallback : IUnknown
{
    HRESULT AcquireCredentials(ushort* pwszRealm, ushort* pwszSite, ushort* pwszUser, uint cchUser, 
                               ushort* pwszPassword, uint cchPassword, HRESULT hrStatus, uint* pdwFlags);
}

@GUID("96406BD9-2B2B-11D3-B36B-00C04F6108FF")
interface IWMMetadataEditor : IUnknown
{
    HRESULT Open(const(wchar)* pwszFilename);
    HRESULT Close();
    HRESULT Flush();
}

@GUID("203CFFE3-2E18-4FDF-B59D-6E71530534CF")
interface IWMMetadataEditor2 : IWMMetadataEditor
{
    HRESULT OpenEx(const(wchar)* pwszFilename, uint dwDesiredAccess, uint dwShareMode);
}

@GUID("FF130EBC-A6C3-42A6-B401-C3382C3E08B3")
interface IWMDRMEditor : IUnknown
{
    HRESULT GetDRMProperty(const(wchar)* pwstrName, WMT_ATTR_DATATYPE* pdwType, ubyte* pValue, ushort* pcbLength);
}

@GUID("96406BDA-2B2B-11D3-B36B-00C04F6108FF")
interface IWMHeaderInfo : IUnknown
{
    HRESULT GetAttributeCount(ushort wStreamNum, ushort* pcAttributes);
    HRESULT GetAttributeByIndex(ushort wIndex, ushort* pwStreamNum, ushort* pwszName, ushort* pcchNameLen, 
                                WMT_ATTR_DATATYPE* pType, ubyte* pValue, ushort* pcbLength);
    HRESULT GetAttributeByName(ushort* pwStreamNum, const(wchar)* pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, 
                               ushort* pcbLength);
    HRESULT SetAttribute(ushort wStreamNum, const(wchar)* pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, 
                         ushort cbLength);
    HRESULT GetMarkerCount(ushort* pcMarkers);
    HRESULT GetMarker(ushort wIndex, ushort* pwszMarkerName, ushort* pcchMarkerNameLen, ulong* pcnsMarkerTime);
    HRESULT AddMarker(const(wchar)* pwszMarkerName, ulong cnsMarkerTime);
    HRESULT RemoveMarker(ushort wIndex);
    HRESULT GetScriptCount(ushort* pcScripts);
    HRESULT GetScript(ushort wIndex, ushort* pwszType, ushort* pcchTypeLen, ushort* pwszCommand, 
                      ushort* pcchCommandLen, ulong* pcnsScriptTime);
    HRESULT AddScript(const(wchar)* pwszType, const(wchar)* pwszCommand, ulong cnsScriptTime);
    HRESULT RemoveScript(ushort wIndex);
}

@GUID("15CF9781-454E-482E-B393-85FAE487A810")
interface IWMHeaderInfo2 : IWMHeaderInfo
{
    HRESULT GetCodecInfoCount(uint* pcCodecInfos);
    HRESULT GetCodecInfo(uint wIndex, ushort* pcchName, ushort* pwszName, ushort* pcchDescription, 
                         ushort* pwszDescription, WMT_CODEC_INFO_TYPE* pCodecType, ushort* pcbCodecInfo, 
                         ubyte* pbCodecInfo);
}

@GUID("15CC68E3-27CC-4ECD-B222-3F5D02D80BD5")
interface IWMHeaderInfo3 : IWMHeaderInfo2
{
    HRESULT GetAttributeCountEx(ushort wStreamNum, ushort* pcAttributes);
    HRESULT GetAttributeIndices(ushort wStreamNum, const(wchar)* pwszName, ushort* pwLangIndex, ushort* pwIndices, 
                                ushort* pwCount);
    HRESULT GetAttributeByIndexEx(ushort wStreamNum, ushort wIndex, const(wchar)* pwszName, ushort* pwNameLen, 
                                  WMT_ATTR_DATATYPE* pType, ushort* pwLangIndex, ubyte* pValue, uint* pdwDataLength);
    HRESULT ModifyAttribute(ushort wStreamNum, ushort wIndex, WMT_ATTR_DATATYPE Type, ushort wLangIndex, 
                            const(ubyte)* pValue, uint dwLength);
    HRESULT AddAttribute(ushort wStreamNum, const(wchar)* pszName, ushort* pwIndex, WMT_ATTR_DATATYPE Type, 
                         ushort wLangIndex, const(ubyte)* pValue, uint dwLength);
    HRESULT DeleteAttribute(ushort wStreamNum, ushort wIndex);
    HRESULT AddCodecInfo(const(wchar)* pwszName, const(wchar)* pwszDescription, WMT_CODEC_INFO_TYPE codecType, 
                         ushort cbCodecInfo, ubyte* pbCodecInfo);
}

@GUID("D16679F2-6CA0-472D-8D31-2F5D55AEE155")
interface IWMProfileManager : IUnknown
{
    HRESULT CreateEmptyProfile(WMT_VERSION dwVersion, IWMProfile* ppProfile);
    HRESULT LoadProfileByID(const(GUID)* guidProfile, IWMProfile* ppProfile);
    HRESULT LoadProfileByData(const(wchar)* pwszProfile, IWMProfile* ppProfile);
    HRESULT SaveProfile(IWMProfile pIWMProfile, ushort* pwszProfile, uint* pdwLength);
    HRESULT GetSystemProfileCount(uint* pcProfiles);
    HRESULT LoadSystemProfile(uint dwProfileIndex, IWMProfile* ppProfile);
}

@GUID("7A924E51-73C1-494D-8019-23D37ED9B89A")
interface IWMProfileManager2 : IWMProfileManager
{
    HRESULT GetSystemProfileVersion(WMT_VERSION* pdwVersion);
    HRESULT SetSystemProfileVersion(WMT_VERSION dwVersion);
}

@GUID("BA4DCC78-7EE0-4AB8-B27A-DBCE8BC51454")
interface IWMProfileManagerLanguage : IUnknown
{
    HRESULT GetUserLanguageID(ushort* wLangID);
    HRESULT SetUserLanguageID(ushort wLangID);
}

@GUID("96406BDB-2B2B-11D3-B36B-00C04F6108FF")
interface IWMProfile : IUnknown
{
    HRESULT GetVersion(WMT_VERSION* pdwVersion);
    HRESULT GetName(ushort* pwszName, uint* pcchName);
    HRESULT SetName(const(wchar)* pwszName);
    HRESULT GetDescription(ushort* pwszDescription, uint* pcchDescription);
    HRESULT SetDescription(const(wchar)* pwszDescription);
    HRESULT GetStreamCount(uint* pcStreams);
    HRESULT GetStream(uint dwStreamIndex, IWMStreamConfig* ppConfig);
    HRESULT GetStreamByNumber(ushort wStreamNum, IWMStreamConfig* ppConfig);
    HRESULT RemoveStream(IWMStreamConfig pConfig);
    HRESULT RemoveStreamByNumber(ushort wStreamNum);
    HRESULT AddStream(IWMStreamConfig pConfig);
    HRESULT ReconfigStream(IWMStreamConfig pConfig);
    HRESULT CreateNewStream(const(GUID)* guidStreamType, IWMStreamConfig* ppConfig);
    HRESULT GetMutualExclusionCount(uint* pcME);
    HRESULT GetMutualExclusion(uint dwMEIndex, IWMMutualExclusion* ppME);
    HRESULT RemoveMutualExclusion(IWMMutualExclusion pME);
    HRESULT AddMutualExclusion(IWMMutualExclusion pME);
    HRESULT CreateNewMutualExclusion(IWMMutualExclusion* ppME);
}

@GUID("07E72D33-D94E-4BE7-8843-60AE5FF7E5F5")
interface IWMProfile2 : IWMProfile
{
    HRESULT GetProfileID(GUID* pguidID);
}

@GUID("00EF96CC-A461-4546-8BCD-C9A28F0E06F5")
interface IWMProfile3 : IWMProfile2
{
    HRESULT GetStorageFormat(WMT_STORAGE_FORMAT* pnStorageFormat);
    HRESULT SetStorageFormat(WMT_STORAGE_FORMAT nStorageFormat);
    HRESULT GetBandwidthSharingCount(uint* pcBS);
    HRESULT GetBandwidthSharing(uint dwBSIndex, IWMBandwidthSharing* ppBS);
    HRESULT RemoveBandwidthSharing(IWMBandwidthSharing pBS);
    HRESULT AddBandwidthSharing(IWMBandwidthSharing pBS);
    HRESULT CreateNewBandwidthSharing(IWMBandwidthSharing* ppBS);
    HRESULT GetStreamPrioritization(IWMStreamPrioritization* ppSP);
    HRESULT SetStreamPrioritization(IWMStreamPrioritization pSP);
    HRESULT RemoveStreamPrioritization();
    HRESULT CreateNewStreamPrioritization(IWMStreamPrioritization* ppSP);
    HRESULT GetExpectedPacketCount(ulong msDuration, ulong* pcPackets);
}

@GUID("96406BDC-2B2B-11D3-B36B-00C04F6108FF")
interface IWMStreamConfig : IUnknown
{
    HRESULT GetStreamType(GUID* pguidStreamType);
    HRESULT GetStreamNumber(ushort* pwStreamNum);
    HRESULT SetStreamNumber(ushort wStreamNum);
    HRESULT GetStreamName(ushort* pwszStreamName, ushort* pcchStreamName);
    HRESULT SetStreamName(const(wchar)* pwszStreamName);
    HRESULT GetConnectionName(ushort* pwszInputName, ushort* pcchInputName);
    HRESULT SetConnectionName(const(wchar)* pwszInputName);
    HRESULT GetBitrate(uint* pdwBitrate);
    HRESULT SetBitrate(uint pdwBitrate);
    HRESULT GetBufferWindow(uint* pmsBufferWindow);
    HRESULT SetBufferWindow(uint msBufferWindow);
}

@GUID("7688D8CB-FC0D-43BD-9459-5A8DEC200CFA")
interface IWMStreamConfig2 : IWMStreamConfig
{
    HRESULT GetTransportType(WMT_TRANSPORT_TYPE* pnTransportType);
    HRESULT SetTransportType(WMT_TRANSPORT_TYPE nTransportType);
    HRESULT AddDataUnitExtension(GUID guidExtensionSystemID, ushort cbExtensionDataSize, 
                                 ubyte* pbExtensionSystemInfo, uint cbExtensionSystemInfo);
    HRESULT GetDataUnitExtensionCount(ushort* pcDataUnitExtensions);
    HRESULT GetDataUnitExtension(ushort wDataUnitExtensionNumber, GUID* pguidExtensionSystemID, 
                                 ushort* pcbExtensionDataSize, ubyte* pbExtensionSystemInfo, 
                                 uint* pcbExtensionSystemInfo);
    HRESULT RemoveAllDataUnitExtensions();
}

@GUID("CB164104-3AA9-45A7-9AC9-4DAEE131D6E1")
interface IWMStreamConfig3 : IWMStreamConfig2
{
    HRESULT GetLanguage(ushort* pwszLanguageString, ushort* pcchLanguageStringLength);
    HRESULT SetLanguage(const(wchar)* pwszLanguageString);
}

@GUID("CDFB97AB-188F-40B3-B643-5B7903975C59")
interface IWMPacketSize : IUnknown
{
    HRESULT GetMaxPacketSize(uint* pdwMaxPacketSize);
    HRESULT SetMaxPacketSize(uint dwMaxPacketSize);
}

@GUID("8BFC2B9E-B646-4233-A877-1C6A079669DC")
interface IWMPacketSize2 : IWMPacketSize
{
    HRESULT GetMinPacketSize(uint* pdwMinPacketSize);
    HRESULT SetMinPacketSize(uint dwMinPacketSize);
}

@GUID("96406BDD-2B2B-11D3-B36B-00C04F6108FF")
interface IWMStreamList : IUnknown
{
    HRESULT GetStreams(ushort* pwStreamNumArray, ushort* pcStreams);
    HRESULT AddStream(ushort wStreamNum);
    HRESULT RemoveStream(ushort wStreamNum);
}

@GUID("96406BDE-2B2B-11D3-B36B-00C04F6108FF")
interface IWMMutualExclusion : IWMStreamList
{
    HRESULT GetType(GUID* pguidType);
    HRESULT SetType(const(GUID)* guidType);
}

@GUID("0302B57D-89D1-4BA2-85C9-166F2C53EB91")
interface IWMMutualExclusion2 : IWMMutualExclusion
{
    HRESULT GetName(ushort* pwszName, ushort* pcchName);
    HRESULT SetName(const(wchar)* pwszName);
    HRESULT GetRecordCount(ushort* pwRecordCount);
    HRESULT AddRecord();
    HRESULT RemoveRecord(ushort wRecordNumber);
    HRESULT GetRecordName(ushort wRecordNumber, ushort* pwszRecordName, ushort* pcchRecordName);
    HRESULT SetRecordName(ushort wRecordNumber, const(wchar)* pwszRecordName);
    HRESULT GetStreamsForRecord(ushort wRecordNumber, ushort* pwStreamNumArray, ushort* pcStreams);
    HRESULT AddStreamForRecord(ushort wRecordNumber, ushort wStreamNumber);
    HRESULT RemoveStreamForRecord(ushort wRecordNumber, ushort wStreamNumber);
}

@GUID("AD694AF1-F8D9-42F8-BC47-70311B0C4F9E")
interface IWMBandwidthSharing : IWMStreamList
{
    HRESULT GetType(GUID* pguidType);
    HRESULT SetType(const(GUID)* guidType);
    HRESULT GetBandwidth(uint* pdwBitrate, uint* pmsBufferWindow);
    HRESULT SetBandwidth(uint dwBitrate, uint msBufferWindow);
}

@GUID("8C1C6090-F9A8-4748-8EC3-DD1108BA1E77")
interface IWMStreamPrioritization : IUnknown
{
    HRESULT GetPriorityRecords(WM_STREAM_PRIORITY_RECORD* pRecordArray, ushort* pcRecords);
    HRESULT SetPriorityRecords(WM_STREAM_PRIORITY_RECORD* pRecordArray, ushort cRecords);
}

@GUID("96406BE3-2B2B-11D3-B36B-00C04F6108FF")
interface IWMWriterAdvanced : IUnknown
{
    HRESULT GetSinkCount(uint* pcSinks);
    HRESULT GetSink(uint dwSinkNum, IWMWriterSink* ppSink);
    HRESULT AddSink(IWMWriterSink pSink);
    HRESULT RemoveSink(IWMWriterSink pSink);
    HRESULT WriteStreamSample(ushort wStreamNum, ulong cnsSampleTime, uint msSampleSendTime, 
                              ulong cnsSampleDuration, uint dwFlags, INSSBuffer pSample);
    HRESULT SetLiveSource(BOOL fIsLiveSource);
    HRESULT IsRealTime(int* pfRealTime);
    HRESULT GetWriterTime(ulong* pcnsCurrentTime);
    HRESULT GetStatistics(ushort wStreamNum, WM_WRITER_STATISTICS* pStats);
    HRESULT SetSyncTolerance(uint msWindow);
    HRESULT GetSyncTolerance(uint* pmsWindow);
}

@GUID("962DC1EC-C046-4DB8-9CC7-26CEAE500817")
interface IWMWriterAdvanced2 : IWMWriterAdvanced
{
    HRESULT GetInputSetting(uint dwInputNum, const(wchar)* pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, 
                            ushort* pcbLength);
    HRESULT SetInputSetting(uint dwInputNum, const(wchar)* pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, 
                            ushort cbLength);
}

@GUID("2CD6492D-7C37-4E76-9D3B-59261183A22E")
interface IWMWriterAdvanced3 : IWMWriterAdvanced2
{
    HRESULT GetStatisticsEx(ushort wStreamNum, WM_WRITER_STATISTICS_EX* pStats);
    HRESULT SetNonBlocking();
}

@GUID("FC54A285-38C4-45B5-AA23-85B9F7CB424B")
interface IWMWriterPreprocess : IUnknown
{
    HRESULT GetMaxPreprocessingPasses(uint dwInputNum, uint dwFlags, uint* pdwMaxNumPasses);
    HRESULT SetNumPreprocessingPasses(uint dwInputNum, uint dwFlags, uint dwNumPasses);
    HRESULT BeginPreprocessingPass(uint dwInputNum, uint dwFlags);
    HRESULT PreprocessSample(uint dwInputNum, ulong cnsSampleTime, uint dwFlags, INSSBuffer pSample);
    HRESULT EndPreprocessingPass(uint dwInputNum, uint dwFlags);
}

@GUID("D9D6549D-A193-4F24-B308-03123D9B7F8D")
interface IWMWriterPostViewCallback : IWMStatusCallback
{
    HRESULT OnPostViewSample(ushort wStreamNumber, ulong cnsSampleTime, ulong cnsSampleDuration, uint dwFlags, 
                             INSSBuffer pSample, void* pvContext);
    HRESULT AllocateForPostView(ushort wStreamNum, uint cbBuffer, INSSBuffer* ppBuffer, void* pvContext);
}

@GUID("81E20CE4-75EF-491A-8004-FC53C45BDC3E")
interface IWMWriterPostView : IUnknown
{
    HRESULT SetPostViewCallback(IWMWriterPostViewCallback pCallback, void* pvContext);
    HRESULT SetReceivePostViewSamples(ushort wStreamNum, BOOL fReceivePostViewSamples);
    HRESULT GetReceivePostViewSamples(ushort wStreamNum, int* pfReceivePostViewSamples);
    HRESULT GetPostViewProps(ushort wStreamNumber, IWMMediaProps* ppOutput);
    HRESULT SetPostViewProps(ushort wStreamNumber, IWMMediaProps pOutput);
    HRESULT GetPostViewFormatCount(ushort wStreamNumber, uint* pcFormats);
    HRESULT GetPostViewFormat(ushort wStreamNumber, uint dwFormatNumber, IWMMediaProps* ppProps);
    HRESULT SetAllocateForPostView(ushort wStreamNumber, BOOL fAllocate);
    HRESULT GetAllocateForPostView(ushort wStreamNumber, int* pfAllocate);
}

@GUID("96406BE4-2B2B-11D3-B36B-00C04F6108FF")
interface IWMWriterSink : IUnknown
{
    HRESULT OnHeader(INSSBuffer pHeader);
    HRESULT IsRealTime(int* pfRealTime);
    HRESULT AllocateDataUnit(uint cbDataUnit, INSSBuffer* ppDataUnit);
    HRESULT OnDataUnit(INSSBuffer pDataUnit);
    HRESULT OnEndWriting();
}

@GUID("CF4B1F99-4DE2-4E49-A363-252740D99BC1")
interface IWMRegisterCallback : IUnknown
{
    HRESULT Advise(IWMStatusCallback pCallback, void* pvContext);
    HRESULT Unadvise(IWMStatusCallback pCallback, void* pvContext);
}

@GUID("96406BE5-2B2B-11D3-B36B-00C04F6108FF")
interface IWMWriterFileSink : IWMWriterSink
{
    HRESULT Open(const(wchar)* pwszFilename);
}

@GUID("14282BA7-4AEF-4205-8CE5-C229035A05BC")
interface IWMWriterFileSink2 : IWMWriterFileSink
{
    HRESULT Start(ulong cnsStartTime);
    HRESULT Stop(ulong cnsStopTime);
    HRESULT IsStopped(int* pfStopped);
    HRESULT GetFileDuration(ulong* pcnsDuration);
    HRESULT GetFileSize(ulong* pcbFile);
    HRESULT Close();
    HRESULT IsClosed(int* pfClosed);
}

@GUID("3FEA4FEB-2945-47A7-A1DD-C53A8FC4C45C")
interface IWMWriterFileSink3 : IWMWriterFileSink2
{
    HRESULT SetAutoIndexing(BOOL fDoAutoIndexing);
    HRESULT GetAutoIndexing(int* pfAutoIndexing);
    HRESULT SetControlStream(ushort wStreamNumber, BOOL fShouldControlStartAndStop);
    HRESULT GetMode(uint* pdwFileSinkMode);
    HRESULT OnDataUnitEx(WMT_FILESINK_DATA_UNIT* pFileSinkDataUnit);
    HRESULT SetUnbufferedIO(BOOL fUnbufferedIO, BOOL fRestrictMemUsage);
    HRESULT GetUnbufferedIO(int* pfUnbufferedIO);
    HRESULT CompleteOperations();
}

@GUID("96406BE7-2B2B-11D3-B36B-00C04F6108FF")
interface IWMWriterNetworkSink : IWMWriterSink
{
    HRESULT SetMaximumClients(uint dwMaxClients);
    HRESULT GetMaximumClients(uint* pdwMaxClients);
    HRESULT SetNetworkProtocol(WMT_NET_PROTOCOL protocol);
    HRESULT GetNetworkProtocol(WMT_NET_PROTOCOL* pProtocol);
    HRESULT GetHostURL(ushort* pwszURL, uint* pcchURL);
    HRESULT Open(uint* pdwPortNum);
    HRESULT Disconnect();
    HRESULT Close();
}

@GUID("73C66010-A299-41DF-B1F0-CCF03B09C1C6")
interface IWMClientConnections : IUnknown
{
    HRESULT GetClientCount(uint* pcClients);
    HRESULT GetClientProperties(uint dwClientNum, WM_CLIENT_PROPERTIES* pClientProperties);
}

@GUID("4091571E-4701-4593-BB3D-D5F5F0C74246")
interface IWMClientConnections2 : IWMClientConnections
{
    HRESULT GetClientInfo(uint dwClientNum, ushort* pwszNetworkAddress, uint* pcchNetworkAddress, ushort* pwszPort, 
                          uint* pcchPort, ushort* pwszDNSName, uint* pcchDNSName);
}

@GUID("96406BEA-2B2B-11D3-B36B-00C04F6108FF")
interface IWMReaderAdvanced : IUnknown
{
    HRESULT SetUserProvidedClock(BOOL fUserClock);
    HRESULT GetUserProvidedClock(int* pfUserClock);
    HRESULT DeliverTime(ulong cnsTime);
    HRESULT SetManualStreamSelection(BOOL fSelection);
    HRESULT GetManualStreamSelection(int* pfSelection);
    HRESULT SetStreamsSelected(ushort cStreamCount, ushort* pwStreamNumbers, WMT_STREAM_SELECTION* pSelections);
    HRESULT GetStreamSelected(ushort wStreamNum, WMT_STREAM_SELECTION* pSelection);
    HRESULT SetReceiveSelectionCallbacks(BOOL fGetCallbacks);
    HRESULT GetReceiveSelectionCallbacks(int* pfGetCallbacks);
    HRESULT SetReceiveStreamSamples(ushort wStreamNum, BOOL fReceiveStreamSamples);
    HRESULT GetReceiveStreamSamples(ushort wStreamNum, int* pfReceiveStreamSamples);
    HRESULT SetAllocateForOutput(uint dwOutputNum, BOOL fAllocate);
    HRESULT GetAllocateForOutput(uint dwOutputNum, int* pfAllocate);
    HRESULT SetAllocateForStream(ushort wStreamNum, BOOL fAllocate);
    HRESULT GetAllocateForStream(ushort dwSreamNum, int* pfAllocate);
    HRESULT GetStatistics(WM_READER_STATISTICS* pStatistics);
    HRESULT SetClientInfo(WM_READER_CLIENTINFO* pClientInfo);
    HRESULT GetMaxOutputSampleSize(uint dwOutput, uint* pcbMax);
    HRESULT GetMaxStreamSampleSize(ushort wStream, uint* pcbMax);
    HRESULT NotifyLateDelivery(ulong cnsLateness);
}

@GUID("AE14A945-B90C-4D0D-9127-80D665F7D73E")
interface IWMReaderAdvanced2 : IWMReaderAdvanced
{
    HRESULT SetPlayMode(WMT_PLAY_MODE Mode);
    HRESULT GetPlayMode(WMT_PLAY_MODE* pMode);
    HRESULT GetBufferProgress(uint* pdwPercent, ulong* pcnsBuffering);
    HRESULT GetDownloadProgress(uint* pdwPercent, ulong* pqwBytesDownloaded, ulong* pcnsDownload);
    HRESULT GetSaveAsProgress(uint* pdwPercent);
    HRESULT SaveFileAs(const(wchar)* pwszFilename);
    HRESULT GetProtocolName(ushort* pwszProtocol, uint* pcchProtocol);
    HRESULT StartAtMarker(ushort wMarkerIndex, ulong cnsDuration, float fRate, void* pvContext);
    HRESULT GetOutputSetting(uint dwOutputNum, const(wchar)* pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, 
                             ushort* pcbLength);
    HRESULT SetOutputSetting(uint dwOutputNum, const(wchar)* pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, 
                             ushort cbLength);
    HRESULT Preroll(ulong cnsStart, ulong cnsDuration, float fRate);
    HRESULT SetLogClientID(BOOL fLogClientID);
    HRESULT GetLogClientID(int* pfLogClientID);
    HRESULT StopBuffering();
    HRESULT OpenStream(IStream pStream, IWMReaderCallback pCallback, void* pvContext);
}

@GUID("5DC0674B-F04B-4A4E-9F2A-B1AFDE2C8100")
interface IWMReaderAdvanced3 : IWMReaderAdvanced2
{
    HRESULT StopNetStreaming();
    HRESULT StartAtPosition(ushort wStreamNum, void* pvOffsetStart, void* pvDuration, 
                            WMT_OFFSET_FORMAT dwOffsetFormat, float fRate, void* pvContext);
}

@GUID("945A76A2-12AE-4D48-BD3C-CD1D90399B85")
interface IWMReaderAdvanced4 : IWMReaderAdvanced3
{
    HRESULT GetLanguageCount(uint dwOutputNum, ushort* pwLanguageCount);
    HRESULT GetLanguage(uint dwOutputNum, ushort wLanguage, ushort* pwszLanguageString, 
                        ushort* pcchLanguageStringLength);
    HRESULT GetMaxSpeedFactor(double* pdblFactor);
    HRESULT IsUsingFastCache(int* pfUsingFastCache);
    HRESULT AddLogParam(const(wchar)* wszNameSpace, const(wchar)* wszName, const(wchar)* wszValue);
    HRESULT SendLogParams();
    HRESULT CanSaveFileAs(int* pfCanSave);
    HRESULT CancelSaveFileAs();
    HRESULT GetURL(ushort* pwszURL, uint* pcchURL);
}

@GUID("24C44DB0-55D1-49AE-A5CC-F13815E36363")
interface IWMReaderAdvanced5 : IWMReaderAdvanced4
{
    HRESULT SetPlayerHook(uint dwOutputNum, IWMPlayerHook pHook);
}

@GUID("18A2E7F8-428F-4ACD-8A00-E64639BC93DE")
interface IWMReaderAdvanced6 : IWMReaderAdvanced5
{
    HRESULT SetProtectStreamSamples(ubyte* pbCertificate, uint cbCertificate, uint dwCertificateType, uint dwFlags, 
                                    ubyte* pbInitializationVector, uint* pcbInitializationVector);
}

@GUID("E5B7CA9A-0F1C-4F66-9002-74EC50D8B304")
interface IWMPlayerHook : IUnknown
{
    HRESULT PreDecode();
}

@GUID("9F762FA7-A22E-428D-93C9-AC82F3AAFE5A")
interface IWMReaderAllocatorEx : IUnknown
{
    HRESULT AllocateForStreamEx(ushort wStreamNum, uint cbBuffer, INSSBuffer* ppBuffer, uint dwFlags, 
                                ulong cnsSampleTime, ulong cnsSampleDuration, void* pvContext);
    HRESULT AllocateForOutputEx(uint dwOutputNum, uint cbBuffer, INSSBuffer* ppBuffer, uint dwFlags, 
                                ulong cnsSampleTime, ulong cnsSampleDuration, void* pvContext);
}

@GUID("FDBE5592-81A1-41EA-93BD-735CAD1ADC05")
interface IWMReaderTypeNegotiation : IUnknown
{
    HRESULT TryOutputProps(uint dwOutputNum, IWMOutputMediaProps pOutput);
}

@GUID("96406BEB-2B2B-11D3-B36B-00C04F6108FF")
interface IWMReaderCallbackAdvanced : IUnknown
{
    HRESULT OnStreamSample(ushort wStreamNum, ulong cnsSampleTime, ulong cnsSampleDuration, uint dwFlags, 
                           INSSBuffer pSample, void* pvContext);
    HRESULT OnTime(ulong cnsCurrentTime, void* pvContext);
    HRESULT OnStreamSelection(ushort wStreamCount, ushort* pStreamNumbers, WMT_STREAM_SELECTION* pSelections, 
                              void* pvContext);
    HRESULT OnOutputPropsChanged(uint dwOutputNum, WM_MEDIA_TYPE* pMediaType, void* pvContext);
    HRESULT AllocateForStream(ushort wStreamNum, uint cbBuffer, INSSBuffer* ppBuffer, void* pvContext);
    HRESULT AllocateForOutput(uint dwOutputNum, uint cbBuffer, INSSBuffer* ppBuffer, void* pvContext);
}

@GUID("D2827540-3EE7-432C-B14C-DC17F085D3B3")
interface IWMDRMReader : IUnknown
{
    HRESULT AcquireLicense(uint dwFlags);
    HRESULT CancelLicenseAcquisition();
    HRESULT Individualize(uint dwFlags);
    HRESULT CancelIndividualization();
    HRESULT MonitorLicenseAcquisition();
    HRESULT CancelMonitorLicenseAcquisition();
    HRESULT SetDRMProperty(const(wchar)* pwstrName, WMT_ATTR_DATATYPE dwType, const(ubyte)* pValue, 
                           ushort cbLength);
    HRESULT GetDRMProperty(const(wchar)* pwstrName, WMT_ATTR_DATATYPE* pdwType, ubyte* pValue, ushort* pcbLength);
}

@GUID("BEFE7A75-9F1D-4075-B9D9-A3C37BDA49A0")
interface IWMDRMReader2 : IWMDRMReader
{
    HRESULT SetEvaluateOutputLevelLicenses(BOOL fEvaluate);
    HRESULT GetPlayOutputLevels(DRM_PLAY_OPL* pPlayOPL, uint* pcbLength, uint* pdwMinAppComplianceLevel);
    HRESULT GetCopyOutputLevels(DRM_COPY_OPL* pCopyOPL, uint* pcbLength, uint* pdwMinAppComplianceLevel);
    HRESULT TryNextLicense();
}

@GUID("E08672DE-F1E7-4FF4-A0A3-FC4B08E4CAF8")
interface IWMDRMReader3 : IWMDRMReader2
{
    HRESULT GetInclusionList(GUID** ppGuids, uint* pcGuids);
}

@GUID("F28C0300-9BAA-4477-A846-1744D9CBF533")
interface IWMReaderPlaylistBurn : IUnknown
{
    HRESULT InitPlaylistBurn(uint cFiles, ushort** ppwszFilenames, IWMStatusCallback pCallback, void* pvContext);
    HRESULT GetInitResults(uint cFiles, int* phrStati);
    HRESULT Cancel();
    HRESULT EndPlaylistBurn(HRESULT hrBurnResult);
}

@GUID("96406BEC-2B2B-11D3-B36B-00C04F6108FF")
interface IWMReaderNetworkConfig : IUnknown
{
    HRESULT GetBufferingTime(ulong* pcnsBufferingTime);
    HRESULT SetBufferingTime(ulong cnsBufferingTime);
    HRESULT GetUDPPortRanges(WM_PORT_NUMBER_RANGE* pRangeArray, uint* pcRanges);
    HRESULT SetUDPPortRanges(WM_PORT_NUMBER_RANGE* pRangeArray, uint cRanges);
    HRESULT GetProxySettings(const(wchar)* pwszProtocol, WMT_PROXY_SETTINGS* pProxySetting);
    HRESULT SetProxySettings(const(wchar)* pwszProtocol, WMT_PROXY_SETTINGS ProxySetting);
    HRESULT GetProxyHostName(const(wchar)* pwszProtocol, ushort* pwszHostName, uint* pcchHostName);
    HRESULT SetProxyHostName(const(wchar)* pwszProtocol, const(wchar)* pwszHostName);
    HRESULT GetProxyPort(const(wchar)* pwszProtocol, uint* pdwPort);
    HRESULT SetProxyPort(const(wchar)* pwszProtocol, uint dwPort);
    HRESULT GetProxyExceptionList(const(wchar)* pwszProtocol, ushort* pwszExceptionList, uint* pcchExceptionList);
    HRESULT SetProxyExceptionList(const(wchar)* pwszProtocol, const(wchar)* pwszExceptionList);
    HRESULT GetProxyBypassForLocal(const(wchar)* pwszProtocol, int* pfBypassForLocal);
    HRESULT SetProxyBypassForLocal(const(wchar)* pwszProtocol, BOOL fBypassForLocal);
    HRESULT GetForceRerunAutoProxyDetection(int* pfForceRerunDetection);
    HRESULT SetForceRerunAutoProxyDetection(BOOL fForceRerunDetection);
    HRESULT GetEnableMulticast(int* pfEnableMulticast);
    HRESULT SetEnableMulticast(BOOL fEnableMulticast);
    HRESULT GetEnableHTTP(int* pfEnableHTTP);
    HRESULT SetEnableHTTP(BOOL fEnableHTTP);
    HRESULT GetEnableUDP(int* pfEnableUDP);
    HRESULT SetEnableUDP(BOOL fEnableUDP);
    HRESULT GetEnableTCP(int* pfEnableTCP);
    HRESULT SetEnableTCP(BOOL fEnableTCP);
    HRESULT ResetProtocolRollover();
    HRESULT GetConnectionBandwidth(uint* pdwConnectionBandwidth);
    HRESULT SetConnectionBandwidth(uint dwConnectionBandwidth);
    HRESULT GetNumProtocolsSupported(uint* pcProtocols);
    HRESULT GetSupportedProtocolName(uint dwProtocolNum, ushort* pwszProtocolName, uint* pcchProtocolName);
    HRESULT AddLoggingUrl(const(wchar)* pwszUrl);
    HRESULT GetLoggingUrl(uint dwIndex, const(wchar)* pwszUrl, uint* pcchUrl);
    HRESULT GetLoggingUrlCount(uint* pdwUrlCount);
    HRESULT ResetLoggingUrlList();
}

@GUID("D979A853-042B-4050-8387-C939DB22013F")
interface IWMReaderNetworkConfig2 : IWMReaderNetworkConfig
{
    HRESULT GetEnableContentCaching(int* pfEnableContentCaching);
    HRESULT SetEnableContentCaching(BOOL fEnableContentCaching);
    HRESULT GetEnableFastCache(int* pfEnableFastCache);
    HRESULT SetEnableFastCache(BOOL fEnableFastCache);
    HRESULT GetAcceleratedStreamingDuration(ulong* pcnsAccelDuration);
    HRESULT SetAcceleratedStreamingDuration(ulong cnsAccelDuration);
    HRESULT GetAutoReconnectLimit(uint* pdwAutoReconnectLimit);
    HRESULT SetAutoReconnectLimit(uint dwAutoReconnectLimit);
    HRESULT GetEnableResends(int* pfEnableResends);
    HRESULT SetEnableResends(BOOL fEnableResends);
    HRESULT GetEnableThinning(int* pfEnableThinning);
    HRESULT SetEnableThinning(BOOL fEnableThinning);
    HRESULT GetMaxNetPacketSize(uint* pdwMaxNetPacketSize);
}

@GUID("96406BED-2B2B-11D3-B36B-00C04F6108FF")
interface IWMReaderStreamClock : IUnknown
{
    HRESULT GetTime(ulong* pcnsNow);
    HRESULT SetTimer(ulong cnsWhen, void* pvParam, uint* pdwTimerId);
    HRESULT KillTimer(uint dwTimerId);
}

@GUID("6D7CDC71-9888-11D3-8EDC-00C04F6109CF")
interface IWMIndexer : IUnknown
{
    HRESULT StartIndexing(const(wchar)* pwszURL, IWMStatusCallback pCallback, void* pvContext);
    HRESULT Cancel();
}

@GUID("B70F1E42-6255-4DF0-A6B9-02B212D9E2BB")
interface IWMIndexer2 : IWMIndexer
{
    HRESULT Configure(ushort wStreamNum, WMT_INDEXER_TYPE nIndexerType, void* pvInterval, void* pvIndexType);
}

@GUID("05E5AC9F-3FB6-4508-BB43-A4067BA1EBE8")
interface IWMLicenseBackup : IUnknown
{
    HRESULT BackupLicenses(uint dwFlags, IWMStatusCallback pCallback);
    HRESULT CancelLicenseBackup();
}

@GUID("C70B6334-A22E-4EFB-A245-15E65A004A13")
interface IWMLicenseRestore : IUnknown
{
    HRESULT RestoreLicenses(uint dwFlags, IWMStatusCallback pCallback);
    HRESULT CancelLicenseRestore();
}

@GUID("3C8E0DA6-996F-4FF3-A1AF-4838F9377E2E")
interface IWMBackupRestoreProps : IUnknown
{
    HRESULT GetPropCount(ushort* pcProps);
    HRESULT GetPropByIndex(ushort wIndex, ushort* pwszName, ushort* pcchNameLen, WMT_ATTR_DATATYPE* pType, 
                           ubyte* pValue, ushort* pcbLength);
    HRESULT GetPropByName(const(wchar)* pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, ushort* pcbLength);
    HRESULT SetPropA(const(wchar)* pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, ushort cbLength);
    HRESULT RemovePropA(const(wchar)* pcwszName);
    HRESULT RemoveAllProps();
}

@GUID("A970F41E-34DE-4A98-B3BA-E4B3CA7528F0")
interface IWMCodecInfo : IUnknown
{
    HRESULT GetCodecInfoCount(const(GUID)* guidType, uint* pcCodecs);
    HRESULT GetCodecFormatCount(const(GUID)* guidType, uint dwCodecIndex, uint* pcFormat);
    HRESULT GetCodecFormat(const(GUID)* guidType, uint dwCodecIndex, uint dwFormatIndex, 
                           IWMStreamConfig* ppIStreamConfig);
}

@GUID("AA65E273-B686-4056-91EC-DD768D4DF710")
interface IWMCodecInfo2 : IWMCodecInfo
{
    HRESULT GetCodecName(const(GUID)* guidType, uint dwCodecIndex, ushort* wszName, uint* pcchName);
    HRESULT GetCodecFormatDesc(const(GUID)* guidType, uint dwCodecIndex, uint dwFormatIndex, 
                               IWMStreamConfig* ppIStreamConfig, ushort* wszDesc, uint* pcchDesc);
}

@GUID("7E51F487-4D93-4F98-8AB4-27D0565ADC51")
interface IWMCodecInfo3 : IWMCodecInfo2
{
    HRESULT GetCodecFormatProp(const(GUID)* guidType, uint dwCodecIndex, uint dwFormatIndex, const(wchar)* pszName, 
                               WMT_ATTR_DATATYPE* pType, ubyte* pValue, uint* pdwSize);
    HRESULT GetCodecProp(const(GUID)* guidType, uint dwCodecIndex, const(wchar)* pszName, WMT_ATTR_DATATYPE* pType, 
                         ubyte* pValue, uint* pdwSize);
    HRESULT SetCodecEnumerationSetting(const(GUID)* guidType, uint dwCodecIndex, const(wchar)* pszName, 
                                       WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, uint dwSize);
    HRESULT GetCodecEnumerationSetting(const(GUID)* guidType, uint dwCodecIndex, const(wchar)* pszName, 
                                       WMT_ATTR_DATATYPE* pType, ubyte* pValue, uint* pdwSize);
}

@GUID("DF683F00-2D49-4D8E-92B7-FB19F6A0DC57")
interface IWMLanguageList : IUnknown
{
    HRESULT GetLanguageCount(ushort* pwCount);
    HRESULT GetLanguageDetails(ushort wIndex, ushort* pwszLanguageString, ushort* pcchLanguageStringLength);
    HRESULT AddLanguageByRFC1766String(const(wchar)* pwszLanguageString, ushort* pwIndex);
}

@GUID("DC10E6A5-072C-467D-BF57-6330A9DDE12A")
interface IWMWriterPushSink : IWMWriterSink
{
    HRESULT Connect(const(wchar)* pwszURL, const(wchar)* pwszTemplateURL, BOOL fAutoDestroy);
    HRESULT Disconnect();
    HRESULT EndSession();
}

@GUID("F6211F03-8D21-4E94-93E6-8510805F2D99")
interface IWMDeviceRegistration : IUnknown
{
    HRESULT RegisterDevice(uint dwRegisterType, ubyte* pbCertificate, uint cbCertificate, DRM_VAL16 SerialNumber, 
                           IWMRegisteredDevice* ppDevice);
    HRESULT UnregisterDevice(uint dwRegisterType, ubyte* pbCertificate, uint cbCertificate, DRM_VAL16 SerialNumber);
    HRESULT GetRegistrationStats(uint dwRegisterType, uint* pcRegisteredDevices);
    HRESULT GetFirstRegisteredDevice(uint dwRegisterType, IWMRegisteredDevice* ppDevice);
    HRESULT GetNextRegisteredDevice(IWMRegisteredDevice* ppDevice);
    HRESULT GetRegisteredDeviceByID(uint dwRegisterType, ubyte* pbCertificate, uint cbCertificate, 
                                    DRM_VAL16 SerialNumber, IWMRegisteredDevice* ppDevice);
}

@GUID("A4503BEC-5508-4148-97AC-BFA75760A70D")
interface IWMRegisteredDevice : IUnknown
{
    HRESULT GetDeviceSerialNumber(DRM_VAL16* pSerialNumber);
    HRESULT GetDeviceCertificate(INSSBuffer* ppCertificate);
    HRESULT GetDeviceType(uint* pdwType);
    HRESULT GetAttributeCount(uint* pcAttributes);
    HRESULT GetAttributeByIndex(uint dwIndex, BSTR* pbstrName, BSTR* pbstrValue);
    HRESULT GetAttributeByName(BSTR bstrName, BSTR* pbstrValue);
    HRESULT SetAttributeByName(BSTR bstrName, BSTR bstrValue);
    HRESULT Approve(BOOL fApprove);
    HRESULT IsValid(int* pfValid);
    HRESULT IsApproved(int* pfApproved);
    HRESULT IsWmdrmCompliant(int* pfCompliant);
    HRESULT IsOpened(int* pfOpened);
    HRESULT Open();
    HRESULT Close();
}

@GUID("6A9FD8EE-B651-4BF0-B849-7D4ECE79A2B1")
interface IWMProximityDetection : IUnknown
{
    HRESULT StartDetection(ubyte* pbRegistrationMsg, uint cbRegistrationMsg, ubyte* pbLocalAddress, 
                           uint cbLocalAddress, uint dwExtraPortsAllowed, INSSBuffer* ppRegistrationResponseMsg, 
                           IWMStatusCallback pCallback, void* pvContext);
}

@GUID("A73A0072-25A0-4C99-B4A5-EDE8101A6C39")
interface IWMDRMMessageParser : IUnknown
{
    HRESULT ParseRegistrationReqMsg(ubyte* pbRegistrationReqMsg, uint cbRegistrationReqMsg, 
                                    INSSBuffer* ppDeviceCert, DRM_VAL16* pDeviceSerialNumber);
    HRESULT ParseLicenseRequestMsg(ubyte* pbLicenseRequestMsg, uint cbLicenseRequestMsg, INSSBuffer* ppDeviceCert, 
                                   DRM_VAL16* pDeviceSerialNumber, BSTR* pbstrAction);
}

@GUID("69059850-6E6F-4BB2-806F-71863DDFC471")
interface IWMDRMTranscryptor : IUnknown
{
    HRESULT Initialize(BSTR bstrFileName, ubyte* pbLicenseRequestMsg, uint cbLicenseRequestMsg, 
                       INSSBuffer* ppLicenseResponseMsg, IWMStatusCallback pCallback, void* pvContext);
    HRESULT Seek(ulong hnsTime);
    HRESULT Read(ubyte* pbData, uint* pcbData);
    HRESULT Close();
}

@GUID("E0DA439F-D331-496A-BECE-18E5BAC5DD23")
interface IWMDRMTranscryptor2 : IWMDRMTranscryptor
{
    HRESULT SeekEx(ulong cnsStartTime, ulong cnsDuration, float flRate, BOOL fIncludeFileHeader);
    HRESULT ZeroAdjustTimestamps(BOOL fEnable);
    HRESULT GetSeekStartTime(ulong* pcnsTime);
    HRESULT GetDuration(ulong* pcnsDuration);
}

@GUID("B1A887B2-A4F0-407A-B02E-EFBD23BBECDF")
interface IWMDRMTranscryptionManager : IUnknown
{
    HRESULT CreateTranscryptor(IWMDRMTranscryptor* ppTranscryptor);
}

@GUID("6F497062-F2E2-4624-8EA7-9DD40D81FC8D")
interface IWMWatermarkInfo : IUnknown
{
    HRESULT GetWatermarkEntryCount(WMT_WATERMARK_ENTRY_TYPE wmetType, uint* pdwCount);
    HRESULT GetWatermarkEntry(WMT_WATERMARK_ENTRY_TYPE wmetType, uint dwEntryNum, WMT_WATERMARK_ENTRY* pEntry);
}

@GUID("BDDC4D08-944D-4D52-A612-46C3FDA07DD4")
interface IWMReaderAccelerator : IUnknown
{
    HRESULT GetCodecInterface(uint dwOutputNum, const(GUID)* riid, void** ppvCodecInterface);
    HRESULT Notify(uint dwOutputNum, WM_MEDIA_TYPE* pSubtype);
}

@GUID("F369E2F0-E081-4FE6-8450-B810B2F410D1")
interface IWMReaderTimecode : IUnknown
{
    HRESULT GetTimecodeRangeCount(ushort wStreamNum, ushort* pwRangeCount);
    HRESULT GetTimecodeRangeBounds(ushort wStreamNum, ushort wRangeNum, uint* pStartTimecode, uint* pEndTimecode);
}

@GUID("BB3C6389-1633-4E92-AF14-9F3173BA39D0")
interface IWMAddressAccess : IUnknown
{
    HRESULT GetAccessEntryCount(WM_AETYPE aeType, uint* pcEntries);
    HRESULT GetAccessEntry(WM_AETYPE aeType, uint dwEntryNum, WM_ADDRESS_ACCESSENTRY* pAddrAccessEntry);
    HRESULT AddAccessEntry(WM_AETYPE aeType, WM_ADDRESS_ACCESSENTRY* pAddrAccessEntry);
    HRESULT RemoveAccessEntry(WM_AETYPE aeType, uint dwEntryNum);
}

@GUID("65A83FC2-3E98-4D4D-81B5-2A742886B33D")
interface IWMAddressAccess2 : IWMAddressAccess
{
    HRESULT GetAccessEntryEx(WM_AETYPE aeType, uint dwEntryNum, BSTR* pbstrAddress, BSTR* pbstrMask);
    HRESULT AddAccessEntryEx(WM_AETYPE aeType, BSTR bstrAddress, BSTR bstrMask);
}

@GUID("9F0AA3B6-7267-4D89-88F2-BA915AA5C4C6")
interface IWMImageInfo : IUnknown
{
    HRESULT GetImageCount(uint* pcImages);
    HRESULT GetImage(uint wIndex, ushort* pcchMIMEType, ushort* pwszMIMEType, ushort* pcchDescription, 
                     ushort* pwszDescription, ushort* pImageType, uint* pcbImageData, ubyte* pbImageData);
}

@GUID("6967F2C9-4E26-4B57-8894-799880F7AC7B")
interface IWMLicenseRevocationAgent : IUnknown
{
    HRESULT GetLRBChallenge(ubyte* pMachineID, uint dwMachineIDLength, ubyte* pChallenge, uint dwChallengeLength, 
                            ubyte* pChallengeOutput, uint* pdwChallengeOutputLength);
    HRESULT ProcessLRB(ubyte* pSignedLRB, uint dwSignedLRBLength, ubyte* pSignedACK, uint* pdwSignedACKLength);
}

@GUID("D9B67D36-A9AD-4EB4-BAEF-DB284EF5504C")
interface IWMAuthorizer : IUnknown
{
    HRESULT GetCertCount(uint* pcCerts);
    HRESULT GetCert(uint dwIndex, ubyte** ppbCertData);
    HRESULT GetSharedData(uint dwCertIndex, const(ubyte)* pbSharedData, ubyte* pbCert, ubyte** ppbSharedData);
}

@GUID("2720598A-D0F2-4189-BD10-91C46EF0936F")
interface IWMSecureChannel : IWMAuthorizer
{
    HRESULT WMSC_AddCertificate(IWMAuthorizer pCert);
    HRESULT WMSC_AddSignature(ubyte* pbCertSig, uint cbCertSig);
    HRESULT WMSC_Connect(IWMSecureChannel pOtherSide);
    HRESULT WMSC_IsConnected(int* pfIsConnected);
    HRESULT WMSC_Disconnect();
    HRESULT WMSC_GetValidCertificate(ubyte** ppbCertificate, uint* pdwSignature);
    HRESULT WMSC_Encrypt(ubyte* pbData, uint cbData);
    HRESULT WMSC_Decrypt(ubyte* pbData, uint cbData);
    HRESULT WMSC_Lock();
    HRESULT WMSC_Unlock();
    HRESULT WMSC_SetSharedData(uint dwCertIndex, const(ubyte)* pbSharedData);
}

@GUID("94BC0598-C3D2-11D3-BEDF-00C04F612986")
interface IWMGetSecureChannel : IUnknown
{
    HRESULT GetPeerSecureChannelInterface(IWMSecureChannel* ppPeer);
}

@GUID("0C0E4080-9081-11D2-BEEC-0060082F2054")
interface INSNetSourceCreator : IUnknown
{
    HRESULT Initialize();
    HRESULT CreateNetSource(const(wchar)* pszStreamName, IUnknown pMonitor, ubyte* pData, IUnknown pUserContext, 
                            IUnknown pCallback, ulong qwContext);
    HRESULT GetNetSourceProperties(const(wchar)* pszStreamName, IUnknown* ppPropertiesNode);
    HRESULT GetNetSourceSharedNamespace(IUnknown* ppSharedNamespace);
    HRESULT GetNetSourceAdminInterface(const(wchar)* pszStreamName, VARIANT* pVal);
    HRESULT GetNumProtocolsSupported(uint* pcProtocols);
    HRESULT GetProtocolName(uint dwProtocolNum, ushort* pwszProtocolName, ushort* pcchProtocolName);
    HRESULT Shutdown();
}

@GUID("28580DDA-D98E-48D0-B7AE-69E473A02825")
interface IWMPlayerTimestampHook : IUnknown
{
    HRESULT MapTimestamp(long rtIn, long* prtOut);
}

@GUID("D98EE251-34E0-4A2D-9312-9B4C788D9FA1")
interface IWMCodecAMVideoAccelerator : IUnknown
{
    HRESULT SetAcceleratorInterface(IAMVideoAccelerator pIAMVA);
    HRESULT NegotiateConnection(AM_MEDIA_TYPE* pMediaType);
    HRESULT SetPlayerNotify(IWMPlayerTimestampHook pHook);
}

@GUID("990641B0-739F-4E94-A808-9888DA8F75AF")
interface IWMCodecVideoAccelerator : IUnknown
{
    HRESULT NegotiateConnection(IAMVideoAccelerator pIAMVA, AM_MEDIA_TYPE* pMediaType);
    HRESULT SetPlayerNotify(IWMPlayerTimestampHook pHook);
}

@GUID("8BB23E5F-D127-4AFB-8D02-AE5B66D54C78")
interface IWMSInternalAdminNetSource : IUnknown
{
    HRESULT Initialize(IUnknown pSharedNamespace, IUnknown pNamespaceNode, INSNetSourceCreator pNetSourceCreator, 
                       BOOL fEmbeddedInServer);
    HRESULT GetNetSourceCreator(INSNetSourceCreator* ppNetSourceCreator);
    HRESULT SetCredentials(BSTR bstrRealm, BSTR bstrName, BSTR bstrPassword, BOOL fPersist, BOOL fConfirmedGood);
    HRESULT GetCredentials(BSTR bstrRealm, BSTR* pbstrName, BSTR* pbstrPassword, int* pfConfirmedGood);
    HRESULT DeleteCredentials(BSTR bstrRealm);
    HRESULT GetCredentialFlags(uint* lpdwFlags);
    HRESULT SetCredentialFlags(uint dwFlags);
    HRESULT FindProxyForURL(BSTR bstrProtocol, BSTR bstrHost, int* pfProxyEnabled, BSTR* pbstrProxyServer, 
                            uint* pdwProxyPort, uint* pdwProxyContext);
    HRESULT RegisterProxyFailure(HRESULT hrParam, uint dwProxyContext);
    HRESULT ShutdownProxyContext(uint dwProxyContext);
    HRESULT IsUsingIE(uint dwProxyContext, int* pfIsUsingIE);
}

@GUID("E74D58C3-CF77-4B51-AF17-744687C43EAE")
interface IWMSInternalAdminNetSource2 : IUnknown
{
    HRESULT SetCredentialsEx(BSTR bstrRealm, BSTR bstrUrl, BOOL fProxy, BSTR bstrName, BSTR bstrPassword, 
                             BOOL fPersist, BOOL fConfirmedGood);
    HRESULT GetCredentialsEx(BSTR bstrRealm, BSTR bstrUrl, BOOL fProxy, 
                             NETSOURCE_URLCREDPOLICY_SETTINGS* pdwUrlPolicy, BSTR* pbstrName, BSTR* pbstrPassword, 
                             int* pfConfirmedGood);
    HRESULT DeleteCredentialsEx(BSTR bstrRealm, BSTR bstrUrl, BOOL fProxy);
    HRESULT FindProxyForURLEx(BSTR bstrProtocol, BSTR bstrHost, BSTR bstrUrl, int* pfProxyEnabled, 
                              BSTR* pbstrProxyServer, uint* pdwProxyPort, uint* pdwProxyContext);
}

@GUID("6B63D08E-4590-44AF-9EB3-57FF1E73BF80")
interface IWMSInternalAdminNetSource3 : IWMSInternalAdminNetSource2
{
    HRESULT GetNetSourceCreator2(IUnknown* ppNetSourceCreator);
    HRESULT FindProxyForURLEx2(BSTR bstrProtocol, BSTR bstrHost, BSTR bstrUrl, int* pfProxyEnabled, 
                               BSTR* pbstrProxyServer, uint* pdwProxyPort, ulong* pqwProxyContext);
    HRESULT RegisterProxyFailure2(HRESULT hrParam, ulong qwProxyContext);
    HRESULT ShutdownProxyContext2(ulong qwProxyContext);
    HRESULT IsUsingIE2(ulong qwProxyContext, int* pfIsUsingIE);
    HRESULT SetCredentialsEx2(BSTR bstrRealm, BSTR bstrUrl, BOOL fProxy, BSTR bstrName, BSTR bstrPassword, 
                              BOOL fPersist, BOOL fConfirmedGood, BOOL fClearTextAuthentication);
    HRESULT GetCredentialsEx2(BSTR bstrRealm, BSTR bstrUrl, BOOL fProxy, BOOL fClearTextAuthentication, 
                              NETSOURCE_URLCREDPOLICY_SETTINGS* pdwUrlPolicy, BSTR* pbstrName, BSTR* pbstrPassword, 
                              int* pfConfirmedGood);
}


// GUIDs


const GUID IID_IAMWMBufferPass             = GUIDOF!IAMWMBufferPass;
const GUID IID_IAMWMBufferPassCallback     = GUIDOF!IAMWMBufferPassCallback;
const GUID IID_INSNetSourceCreator         = GUIDOF!INSNetSourceCreator;
const GUID IID_INSSBuffer                  = GUIDOF!INSSBuffer;
const GUID IID_INSSBuffer2                 = GUIDOF!INSSBuffer2;
const GUID IID_INSSBuffer3                 = GUIDOF!INSSBuffer3;
const GUID IID_INSSBuffer4                 = GUIDOF!INSSBuffer4;
const GUID IID_IWMAddressAccess            = GUIDOF!IWMAddressAccess;
const GUID IID_IWMAddressAccess2           = GUIDOF!IWMAddressAccess2;
const GUID IID_IWMAuthorizer               = GUIDOF!IWMAuthorizer;
const GUID IID_IWMBackupRestoreProps       = GUIDOF!IWMBackupRestoreProps;
const GUID IID_IWMBandwidthSharing         = GUIDOF!IWMBandwidthSharing;
const GUID IID_IWMClientConnections        = GUIDOF!IWMClientConnections;
const GUID IID_IWMClientConnections2       = GUIDOF!IWMClientConnections2;
const GUID IID_IWMCodecAMVideoAccelerator  = GUIDOF!IWMCodecAMVideoAccelerator;
const GUID IID_IWMCodecInfo                = GUIDOF!IWMCodecInfo;
const GUID IID_IWMCodecInfo2               = GUIDOF!IWMCodecInfo2;
const GUID IID_IWMCodecInfo3               = GUIDOF!IWMCodecInfo3;
const GUID IID_IWMCodecVideoAccelerator    = GUIDOF!IWMCodecVideoAccelerator;
const GUID IID_IWMCredentialCallback       = GUIDOF!IWMCredentialCallback;
const GUID IID_IWMDRMEditor                = GUIDOF!IWMDRMEditor;
const GUID IID_IWMDRMMessageParser         = GUIDOF!IWMDRMMessageParser;
const GUID IID_IWMDRMReader                = GUIDOF!IWMDRMReader;
const GUID IID_IWMDRMReader2               = GUIDOF!IWMDRMReader2;
const GUID IID_IWMDRMReader3               = GUIDOF!IWMDRMReader3;
const GUID IID_IWMDRMTranscryptionManager  = GUIDOF!IWMDRMTranscryptionManager;
const GUID IID_IWMDRMTranscryptor          = GUIDOF!IWMDRMTranscryptor;
const GUID IID_IWMDRMTranscryptor2         = GUIDOF!IWMDRMTranscryptor2;
const GUID IID_IWMDRMWriter                = GUIDOF!IWMDRMWriter;
const GUID IID_IWMDRMWriter2               = GUIDOF!IWMDRMWriter2;
const GUID IID_IWMDRMWriter3               = GUIDOF!IWMDRMWriter3;
const GUID IID_IWMDeviceRegistration       = GUIDOF!IWMDeviceRegistration;
const GUID IID_IWMGetSecureChannel         = GUIDOF!IWMGetSecureChannel;
const GUID IID_IWMHeaderInfo               = GUIDOF!IWMHeaderInfo;
const GUID IID_IWMHeaderInfo2              = GUIDOF!IWMHeaderInfo2;
const GUID IID_IWMHeaderInfo3              = GUIDOF!IWMHeaderInfo3;
const GUID IID_IWMIStreamProps             = GUIDOF!IWMIStreamProps;
const GUID IID_IWMImageInfo                = GUIDOF!IWMImageInfo;
const GUID IID_IWMIndexer                  = GUIDOF!IWMIndexer;
const GUID IID_IWMIndexer2                 = GUIDOF!IWMIndexer2;
const GUID IID_IWMInputMediaProps          = GUIDOF!IWMInputMediaProps;
const GUID IID_IWMLanguageList             = GUIDOF!IWMLanguageList;
const GUID IID_IWMLicenseBackup            = GUIDOF!IWMLicenseBackup;
const GUID IID_IWMLicenseRestore           = GUIDOF!IWMLicenseRestore;
const GUID IID_IWMLicenseRevocationAgent   = GUIDOF!IWMLicenseRevocationAgent;
const GUID IID_IWMMediaProps               = GUIDOF!IWMMediaProps;
const GUID IID_IWMMetadataEditor           = GUIDOF!IWMMetadataEditor;
const GUID IID_IWMMetadataEditor2          = GUIDOF!IWMMetadataEditor2;
const GUID IID_IWMMutualExclusion          = GUIDOF!IWMMutualExclusion;
const GUID IID_IWMMutualExclusion2         = GUIDOF!IWMMutualExclusion2;
const GUID IID_IWMOutputMediaProps         = GUIDOF!IWMOutputMediaProps;
const GUID IID_IWMPacketSize               = GUIDOF!IWMPacketSize;
const GUID IID_IWMPacketSize2              = GUIDOF!IWMPacketSize2;
const GUID IID_IWMPlayerHook               = GUIDOF!IWMPlayerHook;
const GUID IID_IWMPlayerTimestampHook      = GUIDOF!IWMPlayerTimestampHook;
const GUID IID_IWMProfile                  = GUIDOF!IWMProfile;
const GUID IID_IWMProfile2                 = GUIDOF!IWMProfile2;
const GUID IID_IWMProfile3                 = GUIDOF!IWMProfile3;
const GUID IID_IWMProfileManager           = GUIDOF!IWMProfileManager;
const GUID IID_IWMProfileManager2          = GUIDOF!IWMProfileManager2;
const GUID IID_IWMProfileManagerLanguage   = GUIDOF!IWMProfileManagerLanguage;
const GUID IID_IWMPropertyVault            = GUIDOF!IWMPropertyVault;
const GUID IID_IWMProximityDetection       = GUIDOF!IWMProximityDetection;
const GUID IID_IWMReader                   = GUIDOF!IWMReader;
const GUID IID_IWMReaderAccelerator        = GUIDOF!IWMReaderAccelerator;
const GUID IID_IWMReaderAdvanced           = GUIDOF!IWMReaderAdvanced;
const GUID IID_IWMReaderAdvanced2          = GUIDOF!IWMReaderAdvanced2;
const GUID IID_IWMReaderAdvanced3          = GUIDOF!IWMReaderAdvanced3;
const GUID IID_IWMReaderAdvanced4          = GUIDOF!IWMReaderAdvanced4;
const GUID IID_IWMReaderAdvanced5          = GUIDOF!IWMReaderAdvanced5;
const GUID IID_IWMReaderAdvanced6          = GUIDOF!IWMReaderAdvanced6;
const GUID IID_IWMReaderAllocatorEx        = GUIDOF!IWMReaderAllocatorEx;
const GUID IID_IWMReaderCallback           = GUIDOF!IWMReaderCallback;
const GUID IID_IWMReaderCallbackAdvanced   = GUIDOF!IWMReaderCallbackAdvanced;
const GUID IID_IWMReaderNetworkConfig      = GUIDOF!IWMReaderNetworkConfig;
const GUID IID_IWMReaderNetworkConfig2     = GUIDOF!IWMReaderNetworkConfig2;
const GUID IID_IWMReaderPlaylistBurn       = GUIDOF!IWMReaderPlaylistBurn;
const GUID IID_IWMReaderStreamClock        = GUIDOF!IWMReaderStreamClock;
const GUID IID_IWMReaderTimecode           = GUIDOF!IWMReaderTimecode;
const GUID IID_IWMReaderTypeNegotiation    = GUIDOF!IWMReaderTypeNegotiation;
const GUID IID_IWMRegisterCallback         = GUIDOF!IWMRegisterCallback;
const GUID IID_IWMRegisteredDevice         = GUIDOF!IWMRegisteredDevice;
const GUID IID_IWMSBufferAllocator         = GUIDOF!IWMSBufferAllocator;
const GUID IID_IWMSInternalAdminNetSource  = GUIDOF!IWMSInternalAdminNetSource;
const GUID IID_IWMSInternalAdminNetSource2 = GUIDOF!IWMSInternalAdminNetSource2;
const GUID IID_IWMSInternalAdminNetSource3 = GUIDOF!IWMSInternalAdminNetSource3;
const GUID IID_IWMSecureChannel            = GUIDOF!IWMSecureChannel;
const GUID IID_IWMStatusCallback           = GUIDOF!IWMStatusCallback;
const GUID IID_IWMStreamConfig             = GUIDOF!IWMStreamConfig;
const GUID IID_IWMStreamConfig2            = GUIDOF!IWMStreamConfig2;
const GUID IID_IWMStreamConfig3            = GUIDOF!IWMStreamConfig3;
const GUID IID_IWMStreamList               = GUIDOF!IWMStreamList;
const GUID IID_IWMStreamPrioritization     = GUIDOF!IWMStreamPrioritization;
const GUID IID_IWMSyncReader               = GUIDOF!IWMSyncReader;
const GUID IID_IWMSyncReader2              = GUIDOF!IWMSyncReader2;
const GUID IID_IWMVideoMediaProps          = GUIDOF!IWMVideoMediaProps;
const GUID IID_IWMWatermarkInfo            = GUIDOF!IWMWatermarkInfo;
const GUID IID_IWMWriter                   = GUIDOF!IWMWriter;
const GUID IID_IWMWriterAdvanced           = GUIDOF!IWMWriterAdvanced;
const GUID IID_IWMWriterAdvanced2          = GUIDOF!IWMWriterAdvanced2;
const GUID IID_IWMWriterAdvanced3          = GUIDOF!IWMWriterAdvanced3;
const GUID IID_IWMWriterFileSink           = GUIDOF!IWMWriterFileSink;
const GUID IID_IWMWriterFileSink2          = GUIDOF!IWMWriterFileSink2;
const GUID IID_IWMWriterFileSink3          = GUIDOF!IWMWriterFileSink3;
const GUID IID_IWMWriterNetworkSink        = GUIDOF!IWMWriterNetworkSink;
const GUID IID_IWMWriterPostView           = GUIDOF!IWMWriterPostView;
const GUID IID_IWMWriterPostViewCallback   = GUIDOF!IWMWriterPostViewCallback;
const GUID IID_IWMWriterPreprocess         = GUIDOF!IWMWriterPreprocess;
const GUID IID_IWMWriterPushSink           = GUIDOF!IWMWriterPushSink;
const GUID IID_IWMWriterSink               = GUIDOF!IWMWriterSink;
