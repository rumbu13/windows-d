// Written in the D programming language.

module windows.windowsmediaformat;

public import windows.core;
public import windows.automation : BSTR, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.directshow : AM_MEDIA_TYPE, BITMAPINFOHEADER, IAMVideoAccelerator,
                                   IPin;
public import windows.displaydevices : RECT;
public import windows.structuredstorage : IStream;
public import windows.systemservices : BOOL, PWSTR;
public import windows.windowsandmessaging : LPARAM;

extern(Windows) @nogc nothrow:


// Enums


alias _AM_ASFWRITERCONFIG_PARAM = int;
enum : int
{
    AM_CONFIGASFWRITER_PARAM_AUTOINDEX    = 0x00000001,
    AM_CONFIGASFWRITER_PARAM_MULTIPASS    = 0x00000002,
    AM_CONFIGASFWRITER_PARAM_DONTCOMPRESS = 0x00000003,
}

alias __MIDL___MIDL_itf_wmsdkidl_0000_0000_0001 = int;
enum : int
{
    WEBSTREAM_SAMPLE_TYPE_FILE   = 0x00000001,
    WEBSTREAM_SAMPLE_TYPE_RENDER = 0x00000002,
}

alias __MIDL___MIDL_itf_wmsdkidl_0000_0000_0002 = int;
enum : int
{
    WM_SF_CLEANPOINT    = 0x00000001,
    WM_SF_DISCONTINUITY = 0x00000002,
    WM_SF_DATALOSS      = 0x00000004,
}

alias __MIDL___MIDL_itf_wmsdkidl_0000_0000_0003 = int;
enum : int
{
    WM_SFEX_NOTASYNCPOINT = 0x00000002,
    WM_SFEX_DATALOSS      = 0x00000004,
}

///The <b>WMT_STATUS</b> enumeration type defines a range of file status information. Members of <b>WMT_STATUS</b> are
///passed to the common callback function, IWMStatusCallback::OnStatus, so that the application can respond to the
///changing status of the objects being used.
alias WMT_STATUS = int;
enum : int
{
    ///An error occurred.
    WMT_ERROR                       = 0x00000000,
    ///A file was opened.
    WMT_OPENED                      = 0x00000001,
    ///The reader object is beginning to buffer content.
    WMT_BUFFERING_START             = 0x00000002,
    ///The reader object has finished buffering content.
    WMT_BUFFERING_STOP              = 0x00000003,
    ///The end of the file has been reached. Both this member and the next one, <b>WMT_END_OF_FILE</b>, have the value
    ///4.
    WMT_EOF                         = 0x00000004,
    ///The end of the file has been reached. Both this member and the previous one, <b>WMT_EOF</b>, have the value 4.
    WMT_END_OF_FILE                 = 0x00000004,
    ///The end of a segment has been encountered.
    WMT_END_OF_SEGMENT              = 0x00000005,
    ///The end of a server-side playlist has been reached.
    WMT_END_OF_STREAMING            = 0x00000006,
    ///The reader object is locating requested data.
    WMT_LOCATING                    = 0x00000007,
    ///A reporting object is connecting to server.
    WMT_CONNECTING                  = 0x00000008,
    ///There is no license and the content is protected by version 1 digital rights management.
    WMT_NO_RIGHTS                   = 0x00000009,
    ///The file loaded in the reader object contains compressed data for which no codec could be found. The
    ///<i>pValue</i> parameter in <b>OnStatus</b> contains a GUID. The first DWORD of this GUID contains the FOURCC or
    ///the format tag of the missing codec. The remaining bytes of the GUID can be ignored. The <i>hr</i> parameter in
    ///<b>OnStatus</b> may equal S_OK, although a missing codec would normally be considered an error. Also, this event
    ///may be followed by WMT_STARTED with <i>hr</i> equal to S_OK, even if codecs are missing for every stream in the
    ///file. In that case, however, the application will not receive any decoded samples, and should stop the reader
    ///object.
    WMT_MISSING_CODEC               = 0x0000000a,
    ///A reporting object has begun operations.
    WMT_STARTED                     = 0x0000000b,
    ///A reporting object has ceased operations.
    WMT_STOPPED                     = 0x0000000c,
    ///A file was closed.
    WMT_CLOSED                      = 0x0000000d,
    ///The reader object is playing content at above normal speed, or in reverse.
    WMT_STRIDING                    = 0x0000000e,
    ///Timer event.
    WMT_TIMER                       = 0x0000000f,
    ///Progress update from the indexer object.
    WMT_INDEX_PROGRESS              = 0x00000010,
    ///The reader object has begun saving a file from a server.
    WMT_SAVEAS_START                = 0x00000011,
    ///The reader has stopped saving a file from a server.
    WMT_SAVEAS_STOP                 = 0x00000012,
    ///The current file's header object contains certain attributes that are different from those of the previous file.
    ///This event is sent when playing a server-side playlist. Use the IWMHeaderInfo interface to query for any of the
    ///following attributes in a new file: Stridable, Broadcast, Seekable, and HasImage.
    WMT_NEW_SOURCEFLAGS             = 0x00000013,
    ///The current file's header object contains metadata attributes that are different from those of the previous file.
    ///This event is sent when playing a server-side playlist. Use the IWMHeaderInfo interface to query for any metadata
    ///attribute you are interested in.
    WMT_NEW_METADATA                = 0x00000014,
    ///A license backup or restore has started.
    WMT_BACKUPRESTORE_BEGIN         = 0x00000015,
    ///The next source in the playlist was opened.
    WMT_SOURCE_SWITCH               = 0x00000016,
    ///The license acquisition process has completed. The <i>pValue</i> parameter in <b>OnStatus</b> contains a
    ///WM_GET_LICENSE_DATA structure. The <b>hr</b> member of this structure indicates whether the license was
    ///successfully acquired.
    WMT_ACQUIRE_LICENSE             = 0x00000017,
    ///Individualization status message.
    WMT_INDIVIDUALIZE               = 0x00000018,
    ///The file loaded in the reader object cannot be played without a security update.
    WMT_NEEDS_INDIVIDUALIZATION     = 0x00000019,
    ///There is no license and the content is protected by version 7 digital rights management.
    WMT_NO_RIGHTS_EX                = 0x0000001a,
    ///A license backup or restore has finished.
    WMT_BACKUPRESTORE_END           = 0x0000001b,
    ///The backup restorer object is connecting to a server.
    WMT_BACKUPRESTORE_CONNECTING    = 0x0000001c,
    ///The backup restorer object is disconnecting from a server.
    WMT_BACKUPRESTORE_DISCONNECTING = 0x0000001d,
    ///Error relating to the URL.
    WMT_ERROR_WITHURL               = 0x0000001e,
    ///The backup restorer object cannot back up one or more licenses because the right has been disallowed by the
    ///content owner.
    WMT_RESTRICTED_LICENSE          = 0x0000001f,
    ///Sent when a client (a playing application or server) connects to a writer network sink object. The <i>pValue</i>
    ///parameter of the IWMStatusCallback::OnStatus callback is set to a WM_CLIENT_PROPERTIES structure. New
    ///applications should wait for <b>WMT_CLIENT_CONNECT_EX</b> instead.
    WMT_CLIENT_CONNECT              = 0x00000020,
    ///Sent when a client (a playing application or server) disconnects from a writer network sink object. The
    ///<i>pValue</i> parameter of the IWMStatusCallback::OnStatus callback is set to a WM_CLIENT_PROPERTIES structure.
    ///The values in this structure are identical to those sent on connection. New applications should wait for
    ///<b>WMT_CLIENT_DISCONNECT_EX</b> instead.
    WMT_CLIENT_DISCONNECT           = 0x00000021,
    ///Change in output properties.
    WMT_NATIVE_OUTPUT_PROPS_CHANGED = 0x00000022,
    ///Start of automatic reconnection to a server.
    WMT_RECONNECT_START             = 0x00000023,
    ///End of automatic reconnection to a server.
    WMT_RECONNECT_END               = 0x00000024,
    ///Sent when a client (a playing application or server) connects to a writer network sink object. The <i>pValue</i>
    ///parameter of the IWMStatusCallback::OnStatus callback is set to a WM_CLIENT_PROPERTIES_EX structure.
    WMT_CLIENT_CONNECT_EX           = 0x00000025,
    ///Sent when a client (a playing application or server) disconnects from a writer network sink object. The
    ///<i>pValue</i> parameter of the IWMStatusCallback::OnStatus callback is set to a WM_CLIENT_PROPERTIES_EX
    ///structure. The client properties are identical to those sent on connection except for the <b>pwszDNSName</b>
    ///member, which may have changed.
    WMT_CLIENT_DISCONNECT_EX        = 0x00000026,
    ///Change to the forward error correction span.
    WMT_SET_FEC_SPAN                = 0x00000027,
    ///The reader is ready to begin buffering content.
    WMT_PREROLL_READY               = 0x00000028,
    ///The reader is finished buffering.
    WMT_PREROLL_COMPLETE            = 0x00000029,
    ///Sent by a writer network sink when one or more properties of a connected client changes. The <i>pValue</i>
    ///parameter of the IWMStatusCallback::OnStatus callback is set to a WM_CLIENT_PROPERTIES_EX structure. This usually
    ///means that a DNS name is present for a client for which none was available at connection.
    WMT_CLIENT_PROPERTIES           = 0x0000002a,
    ///Sent before a <b>WMT_NO_RIGHTS</b> or <b>WMT_NO_RIGHTS_EX</b> status message. The <i>pValue</i> parameter is set
    ///to one of the WMT_DRMLA_TRUST constants indicating whether the license acquisition URL is completely trusted.
    WMT_LICENSEURL_SIGNATURE_STATE  = 0x0000002b,
    ///Sent when the IWMReaderPlaylistBurn::InitPlaylistBurn method returns.
    WMT_INIT_PLAYLIST_BURN          = 0x0000002c,
    ///Sent when the DRM transcryptor object is initialized with a file.
    WMT_TRANSCRYPTOR_INIT           = 0x0000002d,
    ///Sent when the DRM transcryptor object seeks to a point in a file.
    WMT_TRANSCRYPTOR_SEEKED         = 0x0000002e,
    ///Sent when the DRM transcryptor object delivers Windows Media DRM 10 for Network Devices data from a DRM-protected
    ///file.
    WMT_TRANSCRYPTOR_READ           = 0x0000002f,
    ///Sent when the DRM transcryptor object is closed. After receiving this message, you can release the interface.
    WMT_TRANSCRYPTOR_CLOSED         = 0x00000030,
    ///Sent when the proximity detection protocol has finished.
    WMT_PROXIMITY_RESULT            = 0x00000031,
    ///Sent when proximity detection thread has stopped running. The application must not release the
    ///IWMProximityDetection interface until this message is received. Once launched, the thread runs for two minutes;
    ///there is no way to terminate the thread before two minutes have elapsed.
    WMT_PROXIMITY_COMPLETED         = 0x00000032,
    ///Sent when a content enabler is required.
    WMT_CONTENT_ENABLER             = 0x00000033,
}

///The <b>WMT_STREAM_SELECTION</b> enumeration type defines the playback status of a stream.
alias WMT_STREAM_SELECTION = int;
enum : int
{
    ///No samples will be delivered for the stream.
    WMT_OFF             = 0x00000000,
    ///Only samples with cleanpoints will be delivered for the stream.
    WMT_CLEANPOINT_ONLY = 0x00000001,
    ///All samples will be delivered for the stream.
    WMT_ON              = 0x00000002,
}

///The <b>WMT_IMAGE_TYPE</b> enumeration type defines the types of images that can be used for banner ads. This type is
///used as the value of the BannerImageType attribute.
alias WMT_IMAGE_TYPE = int;
enum : int
{
    ///There is no image. If a BannerImageData attribute in the file, it will be ignored.
    WMT_IT_NONE   = 0x00000000,
    ///The banner image is an uncompressed bitmap.
    WMT_IT_BITMAP = 0x00000001,
    ///The banner image uses JPEG encoding.
    WMT_IT_JPEG   = 0x00000002,
    ///The banner image uses GIF encoding.
    WMT_IT_GIF    = 0x00000003,
}

///The <b>WMT_ATTR_DATATYPE</b> enumeration defines the data type for a variably typed property.
alias WMT_ATTR_DATATYPE = int;
enum : int
{
    ///The property is a 4-byte <b>DWORD</b> value.
    WMT_TYPE_DWORD  = 0x00000000,
    ///The property is a null-terminated Unicode string.
    WMT_TYPE_STRING = 0x00000001,
    ///The property is an array of bytes.
    WMT_TYPE_BINARY = 0x00000002,
    ///The property is a 4-byte Boolean value.
    WMT_TYPE_BOOL   = 0x00000003,
    ///The property is an 8-byte <b>QWORD</b> value.
    WMT_TYPE_QWORD  = 0x00000004,
    ///The property is a 2-byte <b>WORD</b> value.
    WMT_TYPE_WORD   = 0x00000005,
    ///The property is a 128-bit (6-byte) GUID.
    WMT_TYPE_GUID   = 0x00000006,
}

///The <b>WMT_ATTR_IMAGETYPE</b> enumeration type lists image types that can be stored in the header of an ASF file.
alias WMT_ATTR_IMAGETYPE = int;
enum : int
{
    ///The image is a device-independent bitmap.
    WMT_IMAGETYPE_BITMAP = 0x00000001,
    ///The image is in JPEG format.
    WMT_IMAGETYPE_JPEG   = 0x00000002,
    ///The image is in GIF format.
    WMT_IMAGETYPE_GIF    = 0x00000003,
}

///The <b>WMT_VERSION</b> enumeration type defines the versions of the Windows Media Format SDK. Every profile you
///create will have an associated version identified by one of these enumerations. The version associated with a profile
///dictates the types of data allowed. For example, data unit extensions were introduced with version 8. A profile
///defined as version 7 cannot include data unit extensions. Under most circumstances, you will create profiles for the
///most current version.
alias WMT_VERSION = int;
enum : int
{
    ///Compatible with version 4 of the Windows Media Format SDK.
    WMT_VER_4_0 = 0x00040000,
    ///Compatible with the Windows Media Format 7 SDK.
    WMT_VER_7_0 = 0x00070000,
    ///Compatible with the Windows Media Format 8.2 SDK.
    WMT_VER_8_0 = 0x00080000,
    ///Compatible with the Windows Media Format 9 Series SDK, and with the Windows Media Format 9.5 SDK.
    WMT_VER_9_0 = 0x00090000,
}

///The <b>WMT_STORAGE_FORMAT</b> enumeration type defines the file types that can be manipulated with this SDK.
alias WMT_STORAGE_FORMAT = int;
enum : int
{
    ///The file is encoded in MP3 format.
    WMT_Storage_Format_MP3 = 0x00000000,
    ///The file is encoded in Windows Media Format.
    WMT_Storage_Format_V1  = 0x00000001,
}

///Defines the trust state of a DRM license acquisition URL.
alias WMT_DRMLA_TRUST = int;
enum : int
{
    ///Indicates that the validity of the license acquisition URL cannot be guaranteed because it is not signed. All
    ///protected content created prior to Windows Media 9 Series will cause this value to be returned.
    WMT_DRMLA_UNTRUSTED = 0x00000000,
    ///Indicates that the license acquisition URL is the original one provided with the content.
    WMT_DRMLA_TRUSTED   = 0x00000001,
    ///Indicates that the license acquisition URL was originally signed and has been tampered with.
    WMT_DRMLA_TAMPERED  = 0x00000002,
}

///The <b>WMT_TRANSPORT_TYPE</b> enumeration type defines the transport types supported by this SDK.
alias WMT_TRANSPORT_TYPE = int;
enum : int
{
    ///The transport type is not reliable.
    WMT_Transport_Type_Unreliable = 0x00000000,
    ///The transport type is reliable.
    WMT_Transport_Type_Reliable   = 0x00000001,
}

///The <b>WMT_STREAM_SELECTION</b> enumeration type defines the types of protocols that the network sink supports.
alias WMT_NET_PROTOCOL = int;
enum : int
{
    ///The network sink supports hypertext transfer protocol (HTTP).
    WMT_PROTOCOL_HTTP = 0x00000000,
}

///The <b>WMT_PLAY_MODE</b> enumeration type defines the playback options of the reader.
alias WMT_PLAY_MODE = int;
enum : int
{
    ///The reader will select the most appropriate play mode based on the location of the content.
    WMT_PLAY_MODE_AUTOSELECT = 0x00000000,
    ///The reader will read files from a local storage location.
    WMT_PLAY_MODE_LOCAL      = 0x00000001,
    ///The reader will download files from network locations.
    WMT_PLAY_MODE_DOWNLOAD   = 0x00000002,
    ///The reader will stream files from network locations.
    WMT_PLAY_MODE_STREAMING  = 0x00000003,
}

///The <b>WMT_PROXY_SETTINGS</b> enumeration type defines network proxy settings for use with a reader object.
alias WMT_PROXY_SETTINGS = int;
enum : int
{
    ///No proxy settings will be used.
    WMT_PROXY_SETTING_NONE    = 0x00000000,
    ///Proxy settings will be explicitly set.
    WMT_PROXY_SETTING_MANUAL  = 0x00000001,
    ///Proxy settings will be automatically negotiated.
    WMT_PROXY_SETTING_AUTO    = 0x00000002,
    ///The browser will negotiate the proxy settings. This applies only when using HTTP.
    WMT_PROXY_SETTING_BROWSER = 0x00000003,
    WMT_PROXY_SETTING_MAX     = 0x00000004,
}

///The <b>WMT_CODEC_INFO_TYPE</b> enumeration type defines the broad categories of codecs supported by this SDK.
alias WMT_CODEC_INFO_TYPE = int;
enum : int
{
    ///Audio codec.
    WMT_CODECINFO_AUDIO   = 0x00000000,
    ///Video codec.
    WMT_CODECINFO_VIDEO   = 0x00000001,
    ///Codec of an unknown type.
    WMT_CODECINFO_UNKNOWN = 0xffffffff,
}

alias __MIDL___MIDL_itf_wmsdkidl_0000_0000_0004 = int;
enum : int
{
    WM_DM_NOTINTERLACED                          = 0x00000000,
    WM_DM_DEINTERLACE_NORMAL                     = 0x00000001,
    WM_DM_DEINTERLACE_HALFSIZE                   = 0x00000002,
    WM_DM_DEINTERLACE_HALFSIZEDOUBLERATE         = 0x00000003,
    WM_DM_DEINTERLACE_INVERSETELECINE            = 0x00000004,
    WM_DM_DEINTERLACE_VERTICALHALFSIZEDOUBLERATE = 0x00000005,
}

alias __MIDL___MIDL_itf_wmsdkidl_0000_0000_0005 = int;
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

///The <b>WMT_OFFSET_FORMAT</b> enumeration type defines the types of offsets used in this SDK.
alias WMT_OFFSET_FORMAT = int;
enum : int
{
    ///An offset into a file is specified by presentation time in 100-nanosecond units.
    WMT_OFFSET_FORMAT_100NS             = 0x00000000,
    ///An offset into a file is specified by frame number.
    WMT_OFFSET_FORMAT_FRAME_NUMBERS     = 0x00000001,
    ///An offset of playlist entries.
    WMT_OFFSET_FORMAT_PLAYLIST_OFFSET   = 0x00000002,
    ///An offset into a file is specified by presentation time as identified by SMTPE time codes.
    WMT_OFFSET_FORMAT_TIMECODE          = 0x00000003,
    ///Used to specify approximate seeking. This type of offset seeks to the closest key frame prior to the time
    ///specified.
    WMT_OFFSET_FORMAT_100NS_APPROXIMATE = 0x00000004,
}

///The <b>WMT_INDEXER_TYPE</b> enumeration type defines the types of indexing supported by the indexer.
alias WMT_INDEXER_TYPE = int;
enum : int
{
    ///The indexer will construct an index using presentation times as indexes.
    WMT_IT_PRESENTATION_TIME = 0x00000000,
    ///The indexer will construct an index using frame numbers as indexes.
    WMT_IT_FRAME_NUMBERS     = 0x00000001,
    ///The indexer will construct an index using SMPTE time codes as indexes.
    WMT_IT_TIMECODE          = 0x00000002,
}

///The <b>WMT_INDEX_TYPE</b> enumeration type defines the type of object that will be associated with an index. Because
///the time specified by an index will not usually correspond exactly with an object in the file, the indexer must
///associate the index with an object in the bit stream close to the specified time.
alias WMT_INDEX_TYPE = int;
enum : int
{
    ///The index will associate indexes with the nearest data unit, or packet, in the Windows Media file.
    WMT_IT_NEAREST_DATA_UNIT   = 0x00000001,
    ///The index will associate indexes with the nearest data object, or compressed sample, in the Windows Media file.
    WMT_IT_NEAREST_OBJECT      = 0x00000002,
    ///The index will associate indexes with the nearest cleanpoint, or video key frame, in the Windows Media file. This
    ///is the default index type.
    WMT_IT_NEAREST_CLEAN_POINT = 0x00000003,
}

///The <b>WMT_FILESINK_MODE</b> enumeration type defines the types of input accepted by the file sink.
alias WMT_FILESINK_MODE = int;
enum : int
{
    ///The file sink accepts normal buffers through calls to IWMWriterSink::OnDataUnit. This is the default behavior.
    WMT_FM_SINGLE_BUFFERS      = 0x00000001,
    ///The file sink accepts data as WMT_FILESINK_DATA_UNIT structures delivered by IWMWriterFileSink3::OnDataUnitEx.
    WMT_FM_FILESINK_DATA_UNITS = 0x00000002,
    ///The file sink accepts unbuffered data. A call to IWMWriterFileSink3::SetUnbufferedIO will succeed.
    WMT_FM_FILESINK_UNBUFFERED = 0x00000004,
}

///The <b>WMT_MUSICSPEECH_CLASS_MODE</b> enumeration type defines the types of compression supported by the Windows
///Media Audio 9 Voice codec.
alias WMT_MUSICSPEECH_CLASS_MODE = int;
enum : int
{
    ///Not currently supported. Do not use.
    WMT_MS_CLASS_MUSIC  = 0x00000000,
    ///Compression optimized for speech.
    WMT_MS_CLASS_SPEECH = 0x00000001,
    ///Compression optimized for a mixture of music and speech.
    WMT_MS_CLASS_MIXED  = 0x00000002,
}

///The <b>WMT_WATERMARK_ENTRY_TYPE</b> enumeration type identifies the types of watermarking systems. Each watermarking
///system is a DirectX media object (DMO) that embeds some sort of digital watermark in digital media content.
alias WMT_WATERMARK_ENTRY_TYPE = int;
enum : int
{
    ///Identifies a watermarking DMO for audio.
    WMT_WMETYPE_AUDIO = 0x00000001,
    ///Identifies a watermarking DMO for video.
    WMT_WMETYPE_VIDEO = 0x00000002,
}

alias __MIDL___MIDL_itf_wmsdkidl_0000_0000_0006 = int;
enum : int
{
    WM_PLAYBACK_DRC_HIGH   = 0x00000000,
    WM_PLAYBACK_DRC_MEDIUM = 0x00000001,
    WM_PLAYBACK_DRC_LOW    = 0x00000002,
}

alias __MIDL___MIDL_itf_wmsdkidl_0000_0000_0007 = int;
enum : int
{
    WMT_TIMECODE_FRAMERATE_30     = 0x00000000,
    WMT_TIMECODE_FRAMERATE_30DROP = 0x00000001,
    WMT_TIMECODE_FRAMERATE_25     = 0x00000002,
    WMT_TIMECODE_FRAMERATE_24     = 0x00000003,
}

///The <b>WMT_CREDENTIAL_FLAGS</b> enumeration type contains values used in the
///IWMCredentialCallback::AcquireCredentials method.
alias WMT_CREDENTIAL_FLAGS = int;
enum : int
{
    ///The application can set this flag to indicate that the caller should save the credentials in a persistent manner.
    WMT_CREDENTIAL_SAVE       = 0x00000001,
    ///The application can set this flag to indicate that the caller should not cache the credentials in memory.
    WMT_CREDENTIAL_DONT_CACHE = 0x00000002,
    ///If this flag is set when the <b>AcquireCredentials</b> method is called, it indicates that the credentials will
    ///be sent over the network unencrypted. Applications should not set this flag.
    WMT_CREDENTIAL_CLEAR_TEXT = 0x00000004,
    ///If this flag is set when the <b>AcquireCredentials</b> method is called, it indicates that the credentials are
    ///for a proxy server. Applications should not set this flag.
    WMT_CREDENTIAL_PROXY      = 0x00000008,
    ///If this flag is set when the <b>AcquireCredentials</b> method is called, it indicates that the caller can handle
    ///encrypted credentials. When this flag is set, the application has the option of encrypting the credentials. To
    ///encrypt the credentials, use the <b>CryptProtectData</b> function, which is described in the Platform SDK
    ///documentation. The application can also return the credentials in plain text. In that case, the caller
    ///automatically encrypts the credentials, unless the WMT_CREDENTIAL_CLEAR_TEXT flag was set when the
    ///<b>AcquireCredentials</b> method was called. If the application encrypts the credentials, it must set the
    ///WMT_CREDENTIAL_ENCRYPT flag before the method returns. If the application returns the credentials in clear text,
    ///clear this flag before the method returns.
    WMT_CREDENTIAL_ENCRYPT    = 0x00000010,
}

///The <b>WM_AETYPE </b>enumeration specifies the permissions for an entry in an IP address access list.
alias WM_AETYPE = int;
enum : int
{
    ///IP addresses that match the access entry are allowed to connect to the network sink.
    WM_AETYPE_INCLUDE = 0x00000069,
    ///IP addresses that match the access entry are not allowed to connect to the network sink.
    WM_AETYPE_EXCLUDE = 0x00000065,
}

///The <b>WMT_RIGHTS</b> enumeration type defines the rights that may be specified in a DRM license.
alias WMT_RIGHTS = int;
enum : int
{
    ///Specifies the right to play content without restriction.
    WMT_RIGHT_PLAYBACK                = 0x00000001,
    ///Specifies the right to copy content to a device not compliant with the Secure Digital Music Initiative (SDMI).
    WMT_RIGHT_COPY_TO_NON_SDMI_DEVICE = 0x00000002,
    ///Specifies the right to copy content to a CD.
    WMT_RIGHT_COPY_TO_CD              = 0x00000008,
    ///Specifies the right to copy content to a device compliant with the Secure Digital Music Initiative (SDMI).
    WMT_RIGHT_COPY_TO_SDMI_DEVICE     = 0x00000010,
    ///Specifies the right to play content one time only.
    WMT_RIGHT_ONE_TIME                = 0x00000020,
    ///Specifies the right to save content from a server.
    WMT_RIGHT_SAVE_STREAM_PROTECTED   = 0x00000040,
    ///Specifies the right to copy content. Windows Media DRM 10 regulates the devices to which the content can be
    ///copied by using output protection levels (OPLs).
    WMT_RIGHT_COPY                    = 0x00000080,
    ///Specifies the right to play content as part of an online scenario where multiple participants can contribute
    ///songs from their collection to a shared playlist.
    WMT_RIGHT_COLLABORATIVE_PLAY      = 0x00000100,
    ///Reserved for future use. Do not use.
    WMT_RIGHT_SDMI_TRIGGER            = 0x00010000,
    ///Reserved for future use. Do not use.
    WMT_RIGHT_SDMI_NOMORECOPIES       = 0x00020000,
}

///The <b>NETSOURCE_URLCREDPOLICY_SETTINGS</b> enumeration type is used for an output parameter of
///IWMSInternalAdminNetSource2::GetCredentialsEx. It specifies possible security policy settings that can exist on a
///client computer. When you retrieve credentials, you must proceed as dictated by the user's security preferences. For
///more information, see <b>GetCredentialsEx</b>.
alias NETSOURCE_URLCREDPOLICY_SETTINGS = int;
enum : int
{
    ///Specifies that your application can log on to servers for which passwords are cached without informing the user.
    NETSOURCE_URLCREDPOLICY_SETTING_SILENTLOGONOK  = 0x00000000,
    ///Specifies that your application must notify the user when your application needs to log on to a server. You
    ///application can fill in the fields of a password dialog, but must get confirmation.
    NETSOURCE_URLCREDPOLICY_SETTING_MUSTPROMPTUSER = 0x00000001,
    ///Specifies that your application can never log on to network servers for the user. Your application can still
    ///navigate servers that do not require passwords.
    NETSOURCE_URLCREDPOLICY_SETTING_ANONYMOUSONLY  = 0x00000002,
}

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

enum : GUID
{
    WMMEDIATYPE_Video          = GUID("73646976-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_RGB1        = GUID("e436eb78-524f-11ce-9f53-0020af0ba770"),
    WMMEDIASUBTYPE_RGB4        = GUID("e436eb79-524f-11ce-9f53-0020af0ba770"),
    WMMEDIASUBTYPE_RGB8        = GUID("e436eb7a-524f-11ce-9f53-0020af0ba770"),
    WMMEDIASUBTYPE_RGB565      = GUID("e436eb7b-524f-11ce-9f53-0020af0ba770"),
    WMMEDIASUBTYPE_RGB555      = GUID("e436eb7c-524f-11ce-9f53-0020af0ba770"),
    WMMEDIASUBTYPE_RGB24       = GUID("e436eb7d-524f-11ce-9f53-0020af0ba770"),
    WMMEDIASUBTYPE_RGB32       = GUID("e436eb7e-524f-11ce-9f53-0020af0ba770"),
    WMMEDIASUBTYPE_I420        = GUID("30323449-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_IYUV        = GUID("56555949-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_YV12        = GUID("32315659-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_YUY2        = GUID("32595559-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_P422        = GUID("32323450-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_UYVY        = GUID("59565955-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_YVYU        = GUID("55595659-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_YVU9        = GUID("39555659-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_VIDEOIMAGE  = GUID("1d4a45f2-e5f6-4b44-8388-f0ae5c0e0c37"),
    WMMEDIASUBTYPE_MP43        = GUID("3334504d-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_MP4S        = GUID("5334504d-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_M4S2        = GUID("3253344d-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMV1        = GUID("31564d57-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMV2        = GUID("32564d57-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_MSS1        = GUID("3153534d-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_MPEG2_VIDEO = GUID("e06d8026-db46-11cf-b4d1-00805f6cbbea"),
}

enum : GUID
{
    WMMEDIASUBTYPE_PCM              = GUID("00000001-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_DRM              = GUID("00000009-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMAudioV9        = GUID("00000162-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMAudio_Lossless = GUID("00000163-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_MSS2             = GUID("3253534d-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMSP1            = GUID("0000000a-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMSP2            = GUID("0000000b-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMV3             = GUID("33564d57-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMVP             = GUID("50564d57-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WVP2             = GUID("32505657-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMVA             = GUID("41564d57-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WVC1             = GUID("31435657-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMAudioV8        = GUID("00000161-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMAudioV7        = GUID("00000161-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WMAudioV2        = GUID("00000161-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_ACELPnet         = GUID("00000130-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_MP3              = GUID("00000055-0000-0010-8000-00aa00389b71"),
    WMMEDIASUBTYPE_WebStream        = GUID("776257d4-c627-41cb-8f81-7ac7ff1c40cc"),
}

enum : GUID
{
    WMMEDIATYPE_Image        = GUID("34a50fd8-8aa5-4386-81fe-a0efe0488e31"),
    WMMEDIATYPE_FileTransfer = GUID("d9e47579-930e-4427-adfc-ad80f290e470"),
    WMMEDIATYPE_Text         = GUID("9bba1ea7-5ab2-4829-ba57-0940209bcf3e"),
}

enum : GUID
{
    WMFORMAT_MPEG2Video   = GUID("e06d80e3-db46-11cf-b4d1-00805f6cbbea"),
    WMFORMAT_WaveFormatEx = GUID("05589f81-c356-11ce-bf01-00aa0055595a"),
    WMFORMAT_Script       = GUID("5c8510f2-debe-4ca7-bba5-f07a104f8dff"),
    WMFORMAT_WebStream    = GUID("da1e6b13-8359-4050-b398-388e965bf00c"),
}

enum : GUID
{
    WM_SampleExtensionGUID_OutputCleanPoint     = GUID("f72a3c6f-6eb4-4ebc-b192-09ad9759e828"),
    WM_SampleExtensionGUID_Timecode             = GUID("399595ec-8667-4e2d-8fdb-98814ce76c1e"),
    WM_SampleExtensionGUID_ChromaLocation       = GUID("4c5acca0-9276-4b2c-9e4c-a0edefdd217e"),
    WM_SampleExtensionGUID_ColorSpaceInfo       = GUID("f79ada56-30eb-4f2b-9f7a-f24b139a1157"),
    WM_SampleExtensionGUID_UserDataInfo         = GUID("732bb4fa-78be-4549-99bd-02db1a55b7a8"),
    WM_SampleExtensionGUID_FileName             = GUID("e165ec0e-19ed-45d7-b4a7-25cbd1e28e9b"),
    WM_SampleExtensionGUID_ContentType          = GUID("d590dc20-07bc-436c-9cf7-f3bbfbf1a4dc"),
    WM_SampleExtensionGUID_PixelAspectRatio     = GUID("1b1ee554-f9ea-4bc8-821a-376b74e4c4b8"),
    WM_SampleExtensionGUID_SampleDuration       = GUID("c6bd9450-867f-4907-83a3-c77921b733ad"),
    WM_SampleExtensionGUID_SampleProtectionSalt = GUID("5403deee-b9ee-438f-aa83-3804997e569d"),
}

enum : GUID
{
    CLSID_WMMUTEX_Bitrate      = GUID("d6e22a01-35da-11d1-9034-00a0c90349be"),
    CLSID_WMMUTEX_Presentation = GUID("d6e22a02-35da-11d1-9034-00a0c90349be"),
    CLSID_WMMUTEX_Unknown      = GUID("d6e22a03-35da-11d1-9034-00a0c90349be"),
}

enum GUID CLSID_WMBandwidthSharing_Partial = GUID("af6060ab-5197-11d2-b6af-00c04fd908e9");
enum GUID WMT_DMOCATEGORY_VIDEO_WATERMARK = GUID("187cc922-8efc-4404-9daf-63f4830df1bc");

// Structs


///The <b>AM_WMT_EVENT_DATA</b> structure contains information pertaining to an EC_WMT_EVENT and the associated status
///code returned by the Windows Media Format SDK.
struct AM_WMT_EVENT_DATA
{
    ///The status code returned by the Windows Media Format SDK.
    HRESULT hrStatus;
    ///Pointer whose data is dependent on the value of the <b>WMT_STATUS</b> message in <i>lParam1</i> of the
    ///<b>EC_WMT_EVENT</b> event. For more information, see EC_WMT_EVENT.
    void*   pData;
}

///The <b>WM_STREAM_PRIORITY_RECORD</b> structure contains a stream number and specifies whether delivery of that stream
///is mandatory.
struct WM_STREAM_PRIORITY_RECORD
{
align (2):
    ///<b>WORD</b> containing the stream number.
    ushort wStreamNumber;
    ///Flag indicating whether the listed stream is mandatory. Mandatory streams will not be dropped regardless of their
    ///position in the priority list.
    BOOL   fMandatory;
}

///The <b>WM_WRITER_STATISTICS</b> structure describes the performance of a writing operation.
struct WM_WRITER_STATISTICS
{
    ///<b>QWORD</b> containing the sample count.
    ulong qwSampleCount;
    ///<b>QWORD</b> containing the byte count.
    ulong qwByteCount;
    ///<b>QWORD</b> containing the dropped sample count.
    ulong qwDroppedSampleCount;
    ///<b>QWORD</b> containing the dropped byte count.
    ulong qwDroppedByteCount;
    ///<b>DWORD</b> containing the current bit rate.
    uint  dwCurrentBitrate;
    ///<b>DWORD</b> containing the average bit rate.
    uint  dwAverageBitrate;
    ///<b>DWORD</b> containing the expected bit rate.
    uint  dwExpectedBitrate;
    ///<b>DWORD</b> containing the current sample rate.
    uint  dwCurrentSampleRate;
    ///<b>DWORD</b> containing the average sample rate.
    uint  dwAverageSampleRate;
    ///<b>DWORD</b> containing the expected sample rate.
    uint  dwExpectedSampleRate;
}

///The <b>WM_WRITER_STATISTICS_EX</b> structure is used by IWMWriterAdvanced3::GetStatisticsEx to obtain extended writer
///statistics.
struct WM_WRITER_STATISTICS_EX
{
    ///<b>DWORD</b> containing the bit rate plus any overhead.
    uint dwBitratePlusOverhead;
    ///<b>DWORD</b> containing the current rate at which samples are dropped in the queue in order to reduce demands on
    ///the CPU.
    uint dwCurrentSampleDropRateInQueue;
    ///<b>DWORD</b> containing the current rate at which samples are dropped in the codec. Samples can be dropped when
    ///they contain little new data. To prevent this from happening, call IWMWriterAdvanced2::SetInputSetting to set the
    ///g_wszFixedFrameRate setting to <b>TRUE</b>.
    uint dwCurrentSampleDropRateInCodec;
    ///<b>DWORD</b> containing the current rate at which samples are dropped in the multiplexer because they arrived
    ///late or overflowed the buffer window.
    uint dwCurrentSampleDropRateInMultiplexer;
    ///<b>DWORD</b> containing the total number of samples dropped in the queue.
    uint dwTotalSampleDropsInQueue;
    ///<b>DWORD</b> containing the total number of samples dropped in the codec.
    uint dwTotalSampleDropsInCodec;
    ///<b>DWORD</b> containing the total number of samples dropped in the multiplexer.
    uint dwTotalSampleDropsInMultiplexer;
}

///The <b>WM_READER_STATISTICS</b> structure describes the performance of a reading operation.
struct WM_READER_STATISTICS
{
    ///The size of the <b>WM_READER_STATISTICS</b> structure, in bytes.
    uint   cbSize;
    ///<b>DWORD</b> containing the bandwidth, in bits per second.
    uint   dwBandwidth;
    ///Count of packets received.
    uint   cPacketsReceived;
    ///Count of lost packets which were recovered. This value is only relevant during network playback.
    uint   cPacketsRecovered;
    ///Count of lost packets which were not recovered. This value is only relevant during network playback.
    uint   cPacketsLost;
    ///<b>WORD</b> containing the quality, which is the percentage of total packets that were received.
    ushort wQuality;
}

///The <b>WM_READER_CLIENTINFO</b> structure describes the client reader (player) accessing the media stream.
struct WM_READER_CLIENTINFO
{
    ///Size of the structure in bytes.
    uint    cbSize;
    ///Two-letter or three-letter language code.
    PWSTR   wszLang;
    ///The browser's user-agent string.
    PWSTR   wszBrowserUserAgent;
    ///Web page that contains the plug-in.
    PWSTR   wszBrowserWebPage;
    ///Reserved.
    ulong   qwReserved;
    ///Unused. See Remarks.
    LPARAM* pReserved;
    ///Host application's .exe file; for example, Iexplore.exe.
    PWSTR   wszHostExe;
    ///Version number of the host application. The value is four unsigned <b>WORD</b> values packed into a 64-bit
    ///integer. When the client information is logged, each <b>WORD</b> value is unpacked and translated into its
    ///decimal equivalent. For example, if the value is 0x0001000200030004, the version number is logged as "1.2.3.4".
    ulong   qwHostVersion;
    ///String identifying the player application. For example, "WMPlayer/9.0.0.0" identifies version 9 of the Windows
    ///Media Player.
    PWSTR   wszPlayerUserAgent;
}

///The <b>WM_CLIENT_PROPERTIES </b>structure records information about the client.
struct WM_CLIENT_PROPERTIES
{
    ///<b>DWORD</b> containing the IP address.
    uint dwIPAddress;
    ///<b>DWORD</b> containing the port number.
    uint dwPort;
}

///The <b>WM_CLIENT_PROPERTIES_EX </b>structure holds extended client information.
struct WM_CLIENT_PROPERTIES_EX
{
    ///<b>DWORD</b> containing the size of the structure.
    uint         cbSize;
    ///String containing the client's IP address in dot notation (for example, "192.168.10.2").
    const(PWSTR) pwszIPAddress;
    ///String containing the client's port number.
    const(PWSTR) pwszPort;
    ///String containing the client's name on the domain name server (DNS), if known.
    const(PWSTR) pwszDNSName;
}

///The <b>WM_PORT_NUMBER_RANGE</b> structure describes the range of port numbers used by the
///<b>IWMReaderNetworkConfig</b> interface.
struct WM_PORT_NUMBER_RANGE
{
    ///<b>WORD</b> containing the lowest port number.
    ushort wPortBegin;
    ///<b>WORD</b> containing the highest port number.
    ushort wPortEnd;
}

///The <b>WMT_BUFFER_SEGMENT</b> structure contains the information needed to specify a segment in a buffer. It is used
///as a member of the WMT_FILESINK_DATA_UNIT and WMT_PAYLOAD_FRAGMENT structures to specify segments of a packet.
struct WMT_BUFFER_SEGMENT
{
    ///Pointer to a buffer object containing the buffer segment.
    INSSBuffer pBuffer;
    ///The offset, in bytes, from the start of the buffer to the buffer segment.
    uint       cbOffset;
    ///The length, in bytes, of the buffer segment.
    uint       cbLength;
}

///The <b>WMT_PAYLOAD_FRAGMENT</b> structure contains the information needed to extract a payload fragment from a buffer
///and identifies the payload to which the fragment belongs. An array of <b>WMT_PAYLOAD_FRAGMENT</b> structures is used
///as a member of the <b>WMT_FILESINK_DATA_UNIT</b> structure to provide access to each payload fragment in a packet.
struct WMT_PAYLOAD_FRAGMENT
{
    ///<b>DWORD</b> containing the payload index. This identifies the payload item to which this fragment belongs.
    uint               dwPayloadIndex;
    ///A <b>WMT_BUFFER_SEGMENT</b> structure specifying the buffer segment containing the payload fragment.
    WMT_BUFFER_SEGMENT segmentData;
}

///The <b>WMT_FILESINK_DATA_UNIT</b> structure is used by <b>IWMWriterFileSink3::OnDataUnitEx</b> to deliver information
///about a packet.
struct WMT_FILESINK_DATA_UNIT
{
    ///A WMT_BUFFER_SEGMENT structure specifying the buffer segment that contains the packet header.
    WMT_BUFFER_SEGMENT  packetHeaderBuffer;
    ///Count of payloads in this packet. This is also the number of elements in the array specified in
    ///<b>pPayloadHeaderBuffers</b>.
    uint                cPayloads;
    ///Pointer to an array of <b>WMT_BUFFER_SEGMENT</b> structures. Each element specifies a buffer segment that
    ///contains a payload header. The number of elements is specified by <b>cPayloads</b>.
    WMT_BUFFER_SEGMENT* pPayloadHeaderBuffers;
    ///Count of payload data fragments in this packet. This is also the number of elements in the array pointed to by
    ///<b>pPayloadDataFragments</b>.
    uint                cPayloadDataFragments;
    ///Pointer to an array of WMT_PAYLOAD_FRAGMENT structures. Each element specifies a buffer segment that contains a
    ///payload fragment. The number of elements is specified by <b>cPayloadDataFragments</b>.
    WMT_PAYLOAD_FRAGMENT* pPayloadDataFragments;
}

///The <b>WMT_WEBSTREAM_FORMAT</b> structure contains information about a Web stream. This structure is used as the
///<b>pbFormat</b> member of the WM_MEDIA_TYPE structure for Web streams.
struct WMT_WEBSTREAM_FORMAT
{
    ///<b>WORD</b> containing the size of the structure, in bytes.
    ushort cbSize;
    ///<b>WORD</b> containing the size of Web stream sample header, in bytes.
    ushort cbSampleHeaderFixedData;
    ///<b>WORD</b> containing the version number. Set to 1 for streams created with the Windows Media Format 9 Series
    ///SDK.
    ushort wVersion;
    ///<b>WORD</b>. Reserved.
    ushort wReserved;
}

///The <b>WMT_WEBSTREAM_SAMPLE_HEADER</b> structure is used as a variable-sized header for each Web stream sample.
struct WMT_WEBSTREAM_SAMPLE_HEADER
{
    ///<b>WORD</b> containing the size of <b>wszURL</b> in wide characters.
    ushort    cbLength;
    ///<b>WORD</b> containing the zero-based part number to which the sample applies. When the last part is received,
    ///<b>wPart</b> equals <b>cTotalParts</b>– 1.
    ushort    wPart;
    ///<b>WORD</b> containing the total number of parts in the Web stream.
    ushort    cTotalParts;
    ///<b>WORD</b> containing the type of Web stream, either WEBSTREAM_SAMPLE_TYPE_FILE (0x1) or
    ///WEBSTREAM_SAMPLE_TYPE_RENDER (0x2). See Remarks.
    ushort    wSampleType;
    ///Wide-character null-terminated string specifying the local URL.
    ushort[1] wszURL;
}

///The <b>WM_ADDRESS_ACCESSENTRY </b>structure specifies an entry in an IP address access list.
struct WM_ADDRESS_ACCESSENTRY
{
    ///An IPv4 address, in network byte order.
    uint dwIPAddress;
    ///An IPv4 address, in network byte order, to use as a bitmask. The bitmask defines which bits in the
    ///<b>dwIPAddress</b> field are matched against. For example, if the IP address is 206.73.118.1 and the mask is
    ///255.255.255.0, only the first 24 bits of the address are examined. Thus, any IP addresses in the range
    ///206.73.118.<i>XXX</i> would match this entry.
    uint dwMask;
}

///The <b>WM_PICTURE</b> structure is used as the data item for the WM/Picture complex metadata attribute.
struct WM_PICTURE
{
align (1):
    ///Pointer to a wide-character null-terminated string containing the multipurpose Internet mail extension (MIME)
    ///type of the picture.
    PWSTR  pwszMIMEType;
    ///<b>BYTE</b> value containing one of the following values.<table> <tr> <th>Value</th> <th>Description</th> </tr>
    ///<tr> <td>0</td> <td>Picture of a type not specifically listed in this table</td> </tr> <tr> <td>1</td> <td>32
    ///pixel by 32 pixel file icon. Use only with portable network graphics (PNG) format</td> </tr> <tr> <td>2</td>
    ///<td>File icon not conforming to type 1 above</td> </tr> <tr> <td>3</td> <td>Front album cover</td> </tr> <tr>
    ///<td>4</td> <td>Back album cover</td> </tr> <tr> <td>5</td> <td>Leaflet page</td> </tr> <tr> <td>6</td> <td>Media.
    ///Typically this type of image is of the label side of a CD</td> </tr> <tr> <td>7</td> <td>Picture of the lead
    ///artist, lead performer, or soloist</td> </tr> <tr> <td>8</td> <td>Picture of one of the artists or
    ///performers</td> </tr> <tr> <td>9</td> <td>Picture of the conductor</td> </tr> <tr> <td>10</td> <td>Picture of the
    ///band or orchestra</td> </tr> <tr> <td>11</td> <td>Picture of the composer</td> </tr> <tr> <td>12</td> <td>Picture
    ///of the lyricist or writer</td> </tr> <tr> <td>13</td> <td>Picture of the recording studio or location</td> </tr>
    ///<tr> <td>14</td> <td>Picture taken during a recording session</td> </tr> <tr> <td>15</td> <td>Picture taken
    ///during a performance</td> </tr> <tr> <td>16</td> <td>Screen capture from a movie or video</td> </tr> <tr>
    ///<td>17</td> <td>A bright colored fish</td> </tr> <tr> <td>18</td> <td>Illustration</td> </tr> <tr> <td>19</td>
    ///<td>Logo of the band or artist</td> </tr> <tr> <td>20</td> <td>Logo of the publisher or studio</td> </tr>
    ///</table>
    ubyte  bPictureType;
    ///Pointer to a wide-character null-terminated string containing a description of the picture.
    PWSTR  pwszDescription;
    ///<b>DWORD</b> value containing the size, in bytes, of the picture data pointed to by <b>pbData</b>.
    uint   dwDataLen;
    ///Pointer to a <b>BYTE</b> array containing the picture data.
    ubyte* pbData;
}

///The <b>WM_SYNCHRONISED_LYRICS</b> structure is used as the data item for the WM/Lyrics_Synchronised complex metadata
///attribute.
struct WM_SYNCHRONISED_LYRICS
{
align (1):
    ///<b>BYTE</b> specifying the format of time stamps in the lyrics. Set to one of the following values.<table> <tr>
    ///<th>Value</th> <th>Description</th> </tr> <tr> <td>1</td> <td>Time stamps are 32-bit values containing the
    ///absolute time of the lyric in frame numbers.</td> </tr> <tr> <td>2</td> <td>Time stamps are 32-bit values
    ///containing the absolute time of the lyric in milliseconds.</td> </tr> </table>
    ubyte  bTimeStampFormat;
    ///<b>BYTE</b> specifying the type of synchronized strings that are in the lyrics data. Set to one of the following
    ///values.<table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td>0</td> <td>Synchronized strings other than
    ///the types listed in this table</td> </tr> <tr> <td>1</td> <td>Song lyrics</td> </tr> <tr> <td>2</td> <td>Text
    ///transcription</td> </tr> <tr> <td>3</td> <td>Names of parts of the content. For example, movements of classical
    ///pieces, like "Adagio"</td> </tr> <tr> <td>4</td> <td>Events, such as stage directions in operas</td> </tr> <tr>
    ///<td>5</td> <td>Chord notations</td> </tr> <tr> <td>6</td> <td>Trivia information</td> </tr> <tr> <td>7</td>
    ///<td>URLs to Web pages</td> </tr> <tr> <td>8</td> <td>URLs to images</td> </tr> </table>
    ubyte  bContentType;
    ///Pointer to a wide-character null-terminated string containing data from the encoding application. An individual
    ///application can use this member in any way desired.
    PWSTR  pwszContentDescriptor;
    ///<b>DWORD</b> containing the length, in bytes, of the lyric data pointed to by <b>pbLyrics</b>.
    uint   dwLyricsLen;
    ///Pointer to a <b>BYTE</b> array containing the lyrics. You can break the lyrics into syllables, or divide them in
    ///some other way that suits the needs of your application. Each syllable or part is included as a null-terminated,
    ///wide-character string followed by a 32-bit time stamp. The unit of measurement for the time stamp is determined
    ///by the value of <b>bTimeStampFormat</b>.
    ubyte* pbLyrics;
}

///The <b>WM_USER_WEB_URL</b> structure is used as the data item for the WM/UserWebURL complex metadata attribute.
struct WM_USER_WEB_URL
{
align (1):
    ///Pointer to a wide-character null-terminated string containing the description of the Web site pointed to by the
    ///URL.
    PWSTR pwszDescription;
    ///Pointer to a wide-character null-terminated string containing the URL.
    PWSTR pwszURL;
}

///The <b>WM_USER_TEXT</b> structure is used as the data item for the WM/Text complex metadata attribute.
struct WM_USER_TEXT
{
align (1):
    ///Pointer to a wide-character null-terminated string containing the description of the text entry.
    PWSTR pwszDescription;
    ///Pointer to a wide-character null-terminated string containing the text.
    PWSTR pwszText;
}

///The <b>WM_LEAKY_BUCKET_PAIR </b>structure describes the buffering requirements for a VBR file. This structure is used
///with the ASFLeakyBucketPairs attribute.
struct WM_LEAKY_BUCKET_PAIR
{
align (1):
    ///Bit rate, in bits per second.
    uint dwBitrate;
    ///Size of the buffer window, in milliseconds.
    uint msBufferWindow;
}

///The <b>WM_STREAM_TYPE_INFO</b> structure is used as the data item for the WM/StreamTypeInfo complex metadata
///attribute. It stores the major type and the size of the associated format data.
struct WM_STREAM_TYPE_INFO
{
align (1):
    ///The major type of the stream.
    GUID guidMajorType;
    ///The size of format in bytes.
    uint cbFormat;
}

///The <b>WMT_WATERMARK_ENTRY</b> structure contains information describing a watermarking system.
struct WMT_WATERMARK_ENTRY
{
    ///A value from the <b>WMT_WATERMARK_ENTRY_TYPE</b> enumeration type specifying the type of watermarking system.
    WMT_WATERMARK_ENTRY_TYPE wmetType;
    ///GUID value identifying the watermarking system.
    GUID  clsid;
    ///The size of display name in wide characters.
    uint  cbDisplayName;
    ///Pointer to a wide-character null-terminated string containing the display name.
    PWSTR pwszDisplayName;
}

///<p class="CCE_Message">[This structure is no longer available for use as of the Windows Media Video 9 Image v2 codec.
///Instead, use WMT_VIDEOIMAGE_SAMPLE2.] The <b>WMT_VIDEOIMAGE_SAMPLE</b> structure describes a sample for a Video Image
///stream that uses the Windows Media Video 9 Image codec.
struct WMT_VIDEOIMAGE_SAMPLE
{
    ///Reserved value. Always set to WMT_VIDEOIMAGE_MAGIC_NUMBER.
    uint dwMagic;
    ///Size of the structure. Always set to <b>sizeof</b>(<b>WMT_VIDEOIMAGE_SAMPLE</b>).
    uint cbStruct;
    ///One or more of the following values.<table> <tr> <th>Value</th> <th>Description</th> </tr> <tr>
    ///<td>WMT_VIDEOIMAGE_SAMPLE_INPUT_FRAME</td> <td>Indicates that the sample contains an input image. The image data
    ///must immediately follow the structure in the sample and must conform to the values set in the input properties
    ///for the stream.</td> </tr> <tr> <td>WMT_VIDEOIMAGE_SAMPLE_OUTPUT_FRAME</td> <td>Indicates that the sample should
    ///result in a unique frame in the stream. If this flag is not set, the remainder of the members of the structure
    ///are ignored and the frame in the stream will be identical to the last output stream.</td> </tr> <tr>
    ///<td>WMT_VIDEOIMAGE_SAMPLE_USES_CURRENT_INPUT_FRAME</td> <td>Indicates that the sample is based, either solely or
    ///in part, on the current image. If this flag is set, the first set of value members will be used. This flag cannot
    ///be set if the sample is input only.</td> </tr> <tr> <td>WMT_VIDEOIMAGE_SAMPLE_USES_PREVIOUS_INPUT_FRAME</td>
    ///<td>Indicates that the sample is based, either solely or in part, on the previous image. If this flag is set, the
    ///second set of value members will be used. This flag cannot be set if the sample is input only.</td> </tr>
    ///</table>
    uint dwControlFlags;
    ///One or more flags indicating the operation to perform on the current image. The following flags are
    ///available.<table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td>WMT_VIDEOIMAGE_SAMPLE_ADV_BLENDING</td>
    ///<td>Indicates that the sample uses advanced blending. This feature is not supported in the current version.</td>
    ///</tr> <tr> <td>WMT_VIDEOIMAGE_SAMPLE_BLENDING</td> <td>Indicates that the sample contains blending. If this flag
    ///is set, the sum of the values of <b>lCurBlendCoef1</b> and <b>lPrevBlendCoef1 </b>(before multiplying by the
    ///denominator) must equal 1.</td> </tr> <tr> <td>WMT_VIDEOIMAGE_SAMPLE_MOTION</td> <td>Indicates that the sample
    ///uses pan and/or zoom.</td> </tr> <tr> <td>WMT_VIDEOIMAGE_SAMPLE_ROTATION</td> <td>Indicates that the sample uses
    ///rotation. This feature is not supported in the current version.</td> </tr> </table>
    uint dwInputFlagsCur;
    ///<b>LONG</b> value containing the horizontal scaling factor of the current image. A scaling factor of 1 means no
    ///horizontal scaling will be performed for this sample. This value must be multiplied by
    ///WMT_VIDEOIMAGE_INTEGER_DENOMINATOR before being set in the structure.
    int  lCurMotionXtoX;
    ///Not used.
    int  lCurMotionYtoX;
    ///<b>LONG</b> value containing the horizontal offset for the current image, in pixels, in relation to the last
    ///output sample. An offset of 0 means that no panning will be performed for this sample. This value must be
    ///multiplied by WMT_VIDEOIMAGE_INTEGER_DENOMINATOR before being set in the structure.
    int  lCurMotionXoffset;
    ///Not used.
    int  lCurMotionXtoY;
    ///<b>LONG</b> value containing the vertical scaling factor of the current image. A scaling factor of 1 means no
    ///vertical scaling will be performed for this sample. This value must be multiplied by
    ///WMT_VIDEOIMAGE_INTEGER_DENOMINATOR before being set in the structure.
    int  lCurMotionYtoY;
    ///<b>LONG</b> value containing the vertical offset for the current image, in pixels, in relation to the last output
    ///sample. An offset of 0 means that no panning will be performed for this sample. This value must be multiplied by
    ///WMT_VIDEOIMAGE_INTEGER_DENOMINATOR before being set in the structure.
    int  lCurMotionYoffset;
    ///<b>LONG</b> value containing the blend coefficient for the current image when combined with the previous image
    ///for an output. This coefficient and the coefficient for the previous image must total 1. This value must be
    ///multiplied by WMT_VIDEOIMAGE_INTEGER_DENOMINATOR before being set in the structure.
    int  lCurBlendCoef1;
    ///Not used.
    int  lCurBlendCoef2;
    ///One or more flags indicating the operation to perform on the previous image. The following flags are
    ///available.<table> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td>WMT_VIDEOIMAGE_SAMPLE_ADV_BLENDING</td>
    ///<td>Indicates that the sample uses advanced blending. This feature is not supported in the current version.</td>
    ///</tr> <tr> <td>WMT_VIDEOIMAGE_SAMPLE_BLENDING</td> <td>Indicates that the sample contains blending. If this flag
    ///is set, the sum of the values of <b>lCurBlendCoef1</b> and <b>lPrevBlendCoef1 </b>(before multiplying by the
    ///denominator) must equal 1.</td> </tr> <tr> <td>WMT_VIDEOIMAGE_SAMPLE_MOTION</td> <td>Indicates that the sample
    ///uses pan and/or zoom.</td> </tr> <tr> <td>WMT_VIDEOIMAGE_SAMPLE_ROTATION</td> <td>Indicates that the sample uses
    ///rotation. This feature is not supported in the current version.</td> </tr> </table>
    uint dwInputFlagsPrev;
    ///<b>LONG</b> value containing the horizontal scaling factor of the previous image. A scaling factor of 1 means no
    ///horizontal scaling will be performed for this sample. This value must be multiplied by
    ///WMT_VIDEOIMAGE_INTEGER_DENOMINATOR before being set in the structure.
    int  lPrevMotionXtoX;
    ///Not used.
    int  lPrevMotionYtoX;
    ///<b>LONG</b> value containing the horizontal offset for the previous image, in pixels, in relation to the last
    ///output sample. An offset of 0 means that no panning will be performed for this sample. This value must be
    ///multiplied by WMT_VIDEOIMAGE_INTEGER_DENOMINATOR before being set in the structure.
    int  lPrevMotionXoffset;
    ///Not used.
    int  lPrevMotionXtoY;
    ///<b>LONG</b> value containing the vertical scaling factor of the previous image. A scaling factor of 1 means no
    ///vertical scaling will be performed for this sample. This value must be multiplied by
    ///WMT_VIDEOIMAGE_INTEGER_DENOMINATOR before being set in the structure.
    int  lPrevMotionYtoY;
    ///<b>LONG</b> value containing the vertical offset for the previous image, in pixels, in relation to the last
    ///output sample. An offset of 0 means that no panning will be performed for this sample. This value must be
    ///multiplied by WMT_VIDEOIMAGE_INTEGER_DENOMINATOR before being set in the structure.
    int  lPrevMotionYoffset;
    ///<b>LONG</b> value containing the blend coefficient for the previous image when combined with the current image
    ///for an output. This coefficient and the coefficient for the current image must total 1. This value must be
    ///multiplied by WMT_VIDEOIMAGE_INTEGER_DENOMINATOR before being set in the structure.
    int  lPrevBlendCoef1;
    ///Not used.
    int  lPrevBlendCoef2;
}

///The <b>WMT_VIDEOIMAGE_SAMPLE2</b> structure describes a sample for a Video Image stream. This structure must be used,
///either alone or with an accompanying image, in each sample passed to the writer for a Video Image stream. For more
///information, see Writing Video Image Samples.
struct WMT_VIDEOIMAGE_SAMPLE2
{
    ///Reserved. You must set this member to WMT_VIDEOIMAGE_MAGIC_NUMBER_2.
    uint  dwMagic;
    ///Size of the structure. Set to <code>sizeof(WMT_VIDEOIMAGE_SAMPLE2)</code>.
    uint  dwStructSize;
    ///Specifies the type of sample. Use one or more of the flags in the following table, combined with the bitwise
    ///<b>OR</b> operator (|):<table> <tr> <th>Flag</th> <th>Description</th> </tr> <tr>
    ///<td>WMT_VIDEOIMAGE_SAMPLE_INPUT_FRAME</td> <td>Indicates that the sample contains an input image. The image data
    ///must be included in the sample immediately following the structure. The format of the image must conform to the
    ///values set in the input properties for the stream.</td> </tr> <tr> <td>WMT_VIDEOIMAGE_SAMPLE_OUTPUT_FRAME</td>
    ///<td>Indicates that the sample should result in a unique output frame in the stream. If this flag is not set, the
    ///remainder of the members of the structure are ignored and the frame in the stream will be a duplicate of the
    ///previous frame.</td> </tr> <tr> <td>WMT_VIDEOIMAGE_SAMPLE_USES_CURRENT_INPUT_FRAME</td> <td>Indicates that the
    ///sample is based, either solely or in part, on the current image. If this flag is set, the first set of value
    ///members will be used (those with names containing the string "Curr"). This flag is not valid unless used in
    ///combination with WMT_VIDEOIMAGE_SAMPLE_OUTPUT_FRAME. </td> </tr> <tr>
    ///<td>WMT_VIDEOIMAGE_SAMPLE_USES_PREVIOUS_INPUT_FRAME</td> <td>Indicates that the sample is based, either solely or
    ///in part, on the previous image. If this flag is set, the second set of value members will be used (those with
    ///names containing the string "Prev"). This flag is not valid unless used in combination with
    ///WMT_VIDEOIMAGE_SAMPLE_OUTPUT_FRAME. </td> </tr> </table>
    uint  dwControlFlags;
    ///Width of the output frame.
    uint  dwViewportWidth;
    ///Height of the output frame.
    uint  dwViewportHeight;
    ///Width of the current image.
    uint  dwCurrImageWidth;
    ///Height of the current image.
    uint  dwCurrImageHeight;
    ///X component of the origin point of the region of interest in the current image.
    float fCurrRegionX0;
    ///Y component of the origin point of the region of interest in the current image.
    float fCurrRegionY0;
    ///Width of the region of interest in the current image. The specified region of interest will be sized to match the
    ///size of the output frame.
    float fCurrRegionWidth;
    ///Height of the region of interest in the current image. The specified region of interest will be sized to match
    ///the size of the output frame.
    float fCurrRegionHeight;
    ///Blending coefficient for the current image. This value specifies the transparency of the current image relative
    ///to the previous image. The blending coefficients of the two images must total 1.0.
    float fCurrBlendCoef;
    ///Width of the previous image.
    uint  dwPrevImageWidth;
    ///Height of the previous image.
    uint  dwPrevImageHeight;
    ///X component of the origin point of the region of interest in the previous image.
    float fPrevRegionX0;
    ///Y component of the origin point of the region of interest in the previous image.
    float fPrevRegionY0;
    ///Width of the region of interest in the previous image. The specified region of interest will be sized to match
    ///the size of the output frame.
    float fPrevRegionWidth;
    ///Height of the region of interest in the previous image. The specified region of interest will be sized to match
    ///the size of the output frame.
    float fPrevRegionHeight;
    ///Blending coefficient for the previous image. This value specifies the transparency of the previous image relative
    ///to the current image. The blending coefficients of the two images must total 1.0.
    float fPrevBlendCoef;
    ///The effect identifier of the transition between the previous image and the current image. For more information,
    ///see Video Image Transitions.
    uint  dwEffectType;
    ///The number of effect parameters relevant to the current effect. The final five members of this structure contain
    ///the values of effect parameters. This member specifies how many of those parameters contain valid information.
    uint  dwNumEffectParas;
    ///Effect parameter. The uses of this parameter and the other four parameters in this structure are determined by
    ///the effect used, as specified by the value of the <b>dwEffectType</b> member.
    float fEffectPara0;
    ///Effect parameter. The uses of this parameter and the other four parameters in this structure are determined by
    ///the effect used, as specified by the value of the <b>dwEffectType</b> member.
    float fEffectPara1;
    ///Effect parameter. The uses of this parameter and the other four parameters in this structure are determined by
    ///the effect used, as specified by the value of the <b>dwEffectType</b> member.
    float fEffectPara2;
    ///Effect parameter. The uses of this parameter and the other four parameters in this structure are determined by
    ///the effect used, as specified by the value of the <b>dwEffectType</b> member.
    float fEffectPara3;
    ///Effect parameter. The uses of this parameter and the other four parameters in this structure are determined by
    ///the effect used, as specified by the value of the <b>dwEffectType</b> member.
    float fEffectPara4;
    ///For input samples, <b>TRUE</b> indicates that the new image should replace the current image and that the current
    ///image should be discarded. The default behavior, indicated by setting this member to <b>FALSE</b>, is for the
    ///current image to become the previous image and the new image to become the current image.
    BOOL  bKeepPrevImage;
}

///The <b>WM_MEDIA_TYPE </b>structure is the primary structure used to describe media formats for the objects of the
///Windows Media Format SDK. For more information about media formats and what they are used for, see Formats.
struct WM_MEDIA_TYPE
{
    ///Major type of the media sample. For example, WMMEDIATYPE_Video specifies a video stream. For a list of possible
    ///major media types, see Media Types.
    GUID     majortype;
    ///Subtype of the media sample. The subtype defines a specific format (usually an encoding scheme) within a major
    ///media type. For example, WMMEDIASUBTYPE_WMV3 specifies a video stream encoded with the Windows Media Video 9
    ///codec. Subtypes can be uncompressed or compressed. For lists of possible media subtypes, see Uncompressed Media
    ///Subtypes and Compressed Media Subtypes.
    GUID     subtype;
    ///Set to true if the samples are of a fixed size. Compressed audio samples are of a fixed size while video samples
    ///are not.
    BOOL     bFixedSizeSamples;
    ///Set to true if the samples are temporally compressed. Temporal compression is compression where some samples
    ///describe the changes in content from the previous sample, instead of describing the sample in its entirety. Only
    ///compressed video can be temporally compressed. By definition, no media type can use both fixed sized samples and
    ///temporal compression.
    BOOL     bTemporalCompression;
    ///Long integer containing the size of the sample, in bytes. This member is used only if <b>bFixedSizeSamples</b> is
    ///true.
    uint     lSampleSize;
    ///GUID of the format type. The format type specifies the additional structure used to identify the media format.
    ///This structure is pointed to by <b>pbFormat</b>.
    GUID     formattype;
    ///Not used. Should be <b>NULL</b>.
    IUnknown pUnk;
    ///Size, in bytes, of the structure pointed to by pbFormat.
    uint     cbFormat;
    ///Pointer to the format structure of the media type. The structure referenced is determined by the format type
    ///<b>GUID</b>. Format types include:<table> <tr> <th>Media Type</th> <th>Structure</th> </tr> <tr>
    ///<td>WMFORMAT_VideoInfo</td> <td> WMVIDEOINFOHEADER </td> </tr> <tr> <td>WMFORMAT_WaveFormatEx</td> <td>
    ///WAVEFORMATEX </td> </tr> <tr> <td>WMFORMAT_MPEG2Video</td> <td> WMMPEG2VIDEOINFO </td> </tr> <tr>
    ///<td>WMFORMAT_WebStream</td> <td> WMT_WEBSTREAM_FORMAT </td> </tr> <tr> <td>WMFORMAT_Script</td> <td>
    ///WMSCRIPTFORMAT </td> </tr> </table>
    ubyte*   pbFormat;
}

///The <b>WMVIDEOINFOHEADER</b> structure describes the bitmap and color information for a video image.
struct WMVIDEOINFOHEADER
{
    ///<b>RECT</b> structure that specifies the source video window.
    RECT             rcSource;
    ///<b>RECT</b> structure that specifies the destination video window.
    RECT             rcTarget;
    ///<b>DWORD</b> containing the approximate bit rate, in bits per second.
    uint             dwBitRate;
    ///<b>DWORD</b> containing the error rate for this stream, in bits per second.
    uint             dwBitErrorRate;
    ///When writing an ASF file, this member specifies the desired average time per frame in 100-nanosecond units. When
    ///reading an ASF file, this member is always zero.
    long             AvgTimePerFrame;
    ///<b>BITMAPINFOHEADER</b> structure that contains color and dimension information for the video image bitmap.
    ///<b>BITMAPINFOHEADER</b> is a Windows GDI structure.
    BITMAPINFOHEADER bmiHeader;
}

///The <b>WMVIDEOINFOHEADER2</b> structure describes the bitmap and color information for a video image, including
///interlace, copy protection, and aspect ratio.
struct WMVIDEOINFOHEADER2
{
    ///<b>RECT</b> structure that specifies what part of the source stream should be used to fill the destination
    ///buffer. Renderers can use this field to ask the decoders to stretch or clip.
    RECT             rcSource;
    ///<b>RECT</b> structure that specifies that specifies what part of the destination buffer should be used
    RECT             rcTarget;
    ///Approximate data rate of the video stream, in bits per second.
    uint             dwBitRate;
    ///Data error rate of the video stream, in bits per second.
    uint             dwBitErrorRate;
    ///The video frame's average display time, in 100-nanosecond units.
    long             AvgTimePerFrame;
    ///Bit-wise combination of zero or more flags that describe interlacing behavior. The flags are defined in
    ///Dvdmedia.h in the DirectX SDK. Undefined bits must be set to zero or else the connection will be rejected.
    uint             dwInterlaceFlags;
    ///Flag set with the AMCOPYPROTECT_RestrictDuplication value (0x00000001) to indicate that the duplication of the
    ///stream should be restricted. Undefined bits must be set to zero or else the connection will be rejected.
    uint             dwCopyProtectFlags;
    ///The X dimension of the video rectangle's aspect ratio. For example, 16 for a 16:9 rectangle.
    uint             dwPictAspectRatioX;
    ///The Y dimension of the video rectangle's aspect ratio. For example, 9 for a 16:9 rectangle.
    uint             dwPictAspectRatioY;
    ///Reserved for future use. Must be zero. (Note: this is different from the corresponding member of the
    ///<b>VIDEOINFOHEADER2</b> structure used in DirectShow.
    uint             dwReserved1;
    ///Reserved for future use. Must be zero.
    uint             dwReserved2;
    ///<b>BITMAPINFOHEADER</b> structure that contains color and dimension information for the video image bitmap.
    BITMAPINFOHEADER bmiHeader;
}

///The <b>WMMPEG2VIDEOINFO</b> structure describes an MPEG-2 video stream.
struct WMMPEG2VIDEOINFO
{
    ///WMVIDEOINFOHEADER2 structure giving header information.
    WMVIDEOINFOHEADER2 hdr;
    ///25-bit group-of-pictures (GOP) time code at start of data. This field is not used for DVD.
    uint               dwStartTimeCode;
    ///Length of the sequence header, in bytes. For DVD, set this field to zero. The sequence header is given in the
    ///<b>dwSequenceHeader</b> field.
    uint               cbSequenceHeader;
    ///<b>AM_MPEG2Profile</b> enumeration type that specifies the MPEG-2 profile.
    uint               dwProfile;
    ///<b>AM_MPEG2Level</b> enumeration type that specifies the MPEG-2 level.
    uint               dwLevel;
    ///Flag indicating preferences. Flags are defined in Dvdmedia.h. Set undefined bits to zero or the connection will
    ///be rejected.
    uint               dwFlags;
    ///Address of a buffer that contains the sequence header, including quantization matrices and the sequence
    ///extension, if required. This field is typed as a <b>DWORD</b> array to preserve the 32-bit alignment.
    uint[1]            dwSequenceHeader;
}

///The <b>WMSCRIPTFORMAT</b> structure describes the type of script data used in a script stream.
struct WMSCRIPTFORMAT
{
    ///GUID identifying the type of script commands in a script stream. Always set to WMSCRIPTTYPE_TwoStrings.
    GUID scriptType;
}

///The <b>WMT_COLORSPACEINFO_EXTENSION_DATA</b> structure contains information about the color format of output video
///samples. It is used as the value for the WM_SampleExtensionGUID_ColorSpaceInfo data unit extension.
struct WMT_COLORSPACEINFO_EXTENSION_DATA
{
    ///Specifies the chromaticity coordinates of the color primaries.
    ubyte ucColorPrimaries;
    ///Specifies the opto-electronic transfer characteristics of the source picture.
    ubyte ucColorTransferChar;
    ///Specifies the matrix coefficients used to derive Y, Cb, and Cr signals from the color primaries.
    ubyte ucColorMatrixCoef;
}

///The <b>WMT_TIMECODE_EXTENSION_DATA</b> structure contains information needed for a single SMPTE time code sample
///extension. One of these structures will be attached to every video frame that requires a SMPTE time code.
struct WMT_TIMECODE_EXTENSION_DATA
{
align (2):
    ///<b>WORD</b> specifying the range to which the time code belongs. See Remarks.
    ushort wRange;
    uint   dwTimecode;
    ///<b>DWORD</b> containing any information that the user desires. Typically, this member is used to store shot or
    ///take numbers, or other information pertinent to the production process.
    uint   dwUserbits;
    ///<b>DWORD</b> provided for maintaining any AM_TIMECODE flags that are present in source material. These flags are
    ///not used by any of the objects in the Windows Media Format SDK. For more information about AM_TIMECODE flags,
    ///refer to the SMPTE time code specification.
    uint   dwAmFlags;
}

///The <b>DRM_VAL16</b> structure is used by some DRM-related methods for passing 128-bit device identification values.
struct DRM_VAL16
{
    ///Array of <b>BYTE</b> values that contains a 128-bit value. Data is stored with the high-order byte in the lowest
    ///address (big-endian).
    ubyte[16] val;
}

///The <b>WMDRM_IMPORT_INIT_STRUCT</b> structure holds the encrypted session key and content key used in importing
///protected content.
struct WMDRM_IMPORT_INIT_STRUCT
{
    ///Version.
    uint   dwVersion;
    ///Size of the encrypted session key message in bytes.
    uint   cbEncryptedSessionKeyMessage;
    ///Address of a buffer containing the encrypted session key message. This message is contained in a field of a
    ///WMDRM_IMPORT_SESSION_KEY structure. The message and its associated key data are both encrypted with the Windows
    ///Media DRM machine public key.
    ubyte* pbEncryptedSessionKeyMessage;
    ///Size of the encrypted key message in bytes.
    uint   cbEncryptedKeyMessage;
    ///Address of a buffer containing the encrypted key message. This message is contained in a field of a
    ///WMDRM_IMPORT_CONTENT_KEY structure. The message and its associated key data are both encrypted with the Windows
    ///Media DRM machine public key.
    ubyte* pbEncryptedKeyMessage;
}

///The <b>DRM_MINIMUM_OUTPUT_PROTECTION_LEVELS</b> structure holds the minimum output protection levels (OPL) for
///playback of various types of content. A device must support the minimum OPL for a type of data to receive that type
///of data from the reader.
struct DRM_MINIMUM_OUTPUT_PROTECTION_LEVELS
{
    ///Minimum OPL required to receive compressed digital video.
    ushort wCompressedDigitalVideo;
    ///Minimum OPL required to receive uncompressed digital video.
    ushort wUncompressedDigitalVideo;
    ///Minimum OPL required to receive analog video.
    ushort wAnalogVideo;
    ///Minimum OPL required to receive compressed digital audio.
    ushort wCompressedDigitalAudio;
    ///Minimum OPL required to receive uncompressed digital audio.
    ushort wUncompressedDigitalAudio;
}

///The <b>DRM_OPL_OUTPUT_IDS</b> structure holds a number of output protection level (OPL) output identifiers.
struct DRM_OPL_OUTPUT_IDS
{
    ///Number of identifiers in the array referenced by <b>rgIds</b>.
    ushort cIds;
    ///Address of an array of GUIDs. Each member of the array contains an OPL output identifier.
    GUID*  rgIds;
}

///The <b>DRM_VIDEO_OUTPUT_PROTECTION</b> structure holds a video output technology identifier and the configuration
///data required by that technology.
struct DRM_OUTPUT_PROTECTION
{
    ///Technology identifier.
    GUID  guidId;
    ///Configuration data required by the technology identified by <b>guidId</b>.
    ubyte bConfigData;
}

///The <b>DRM_VIDEO_OUTPUT_PROTECTION_IDS</b> structure holds an array of DRM_VIDEO_OUTPUT_PROTECTION structures.
struct DRM_VIDEO_OUTPUT_PROTECTION_IDS
{
    ///Number of elements in the array referenced by <b>rgVop</b>.
    ushort cEntries;
    ///Address of an array of <b>DRM_VIDEO_OUTPUT_PROTECTION</b> structures.
    DRM_OUTPUT_PROTECTION* rgVop;
}

///The <b>DRM_PLAY_OPL</b> structure holds information about the output protection levels (OPL) specified in a license
///for play actions.
struct DRM_PLAY_OPL
{
    ///DRM_MINIMUM_OUTPUT_PROTECTION_LEVELS structure containing the minimum OPL required to play content in different
    ///formats.
    DRM_MINIMUM_OUTPUT_PROTECTION_LEVELS minOPL;
    ///Reserved for future use.
    DRM_OPL_OUTPUT_IDS oplIdReserved;
    ///DRM_VIDEO_OUTPUT_PROTECTION_IDS structure containing the video output protection identifiers that apply to
    ///playback of the content.
    DRM_VIDEO_OUTPUT_PROTECTION_IDS vopi;
}

///The <b>DRM_COPY_OPL</b> structure holds information about the output protection levels specified in a license for
///copy actions.
struct DRM_COPY_OPL
{
    ///Minimum output protection level for copy actions.
    ushort             wMinimumCopyLevel;
    ///DRM_OPL_OUTPUT_IDS structure containing the identifiers of technologies to allow. This member is used for output
    ///technologies that are assigned OPLs lower than the minimum copy level, but to which the content may be copied.
    DRM_OPL_OUTPUT_IDS oplIdIncludes;
    ///DRM_OPL_OUTPUT_IDS structure containing the output identifiers of technologies to restrict. This member is used
    ///for output technologies that are assigned OPLs that exceed the minimum copy level, but that the license issuer
    ///does not grant rights for copying to.
    DRM_OPL_OUTPUT_IDS oplIdExcludes;
}

// Functions

///The <b>WMIsContentProtected</b> function checks a file for DRM-protected content. This function is a shortcut so that
///your application can quickly identify protected files.
///Params:
///    pwszFileName = Pointer to a wide-character <b>null</b>-terminated string containing the name of the file to check for
///                   DRM-protected content.
///    pfIsProtected = Pointer to a Boolean value that is set to True on function return if the file contains DRM-protected content.
///Returns:
///    The function returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or both of the parameters are <b>NULL</b>. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The content is unprotected.
///    </td> </tr> </table>
///    
@DllImport("WMVCore")
HRESULT WMIsContentProtected(const(PWSTR) pwszFileName, BOOL* pfIsProtected);

///The <b>WMCreateWriter</b> function creates a writer object.
///Params:
///    pUnkCert = Pointer to an <b>IUnknown</b> interface. This value is not used and should be set to <b>NULL</b>.
///    ppWriter = Pointer to a pointer to the IWMWriter interface of the newly created writer object.
///Returns:
///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The function is unable to allocate memory for the new
///    object. </td> </tr> </table>
///    
@DllImport("WMVCore")
HRESULT WMCreateWriter(IUnknown pUnkCert, IWMWriter* ppWriter);

///The <b>WMCreateReader</b> function creates a reader object.
///Params:
///    pUnkCert = This value must be set to <b>NULL</b>.
///    dwRights = <b>DWORD</b> indicating the desired operation. Set to one of the values from the WMT_RIGHTS enumeration type,
///               indicating the operation that is performed on this file. If multiple operations are being performed,
///               <i>dwRights</i> must consist of multiple values from <b>WMT_RIGHTS</b> combined by using the bitwise <b>OR</b>
///               operator.
///    ppReader = Pointer to a pointer to the IWMReader interface of the newly created reader object.
///Returns:
///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The function is unable to allocate memory for the new
///    object. </td> </tr> </table>
///    
@DllImport("WMVCore")
HRESULT WMCreateReader(IUnknown pUnkCert, uint dwRights, IWMReader* ppReader);

///The <b>WMCreateSyncReader</b> function creates a synchronous reader object.
///Params:
///    pUnkCert = Pointer to an <b>IUnknown</b> interface. This value must be set to <b>NULL</b>.
///    dwRights = <b>DWORD</b> specifying the desired operation. When playing back non-DRM content, or for an application that does
///               not have DRM rights, this value can be set to zero. Otherwise, this value must be one of the values from the
///               WMT_RIGHTS enumeration type, indicating the operation that is performed on this file. If multiple operations are
///               being performed, <b>dwRights</b> must consist of multiple values from <b>WMT_RIGHTS</b> combined by using the
///               bitwise <b>OR</b> operator.
///    ppSyncReader = Pointer to a pointer to the IWMSyncReader interface of the newly created synchronous reader object.
///Returns:
///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The function is unable to allocate memory for the new
///    object. </td> </tr> </table>
///    
@DllImport("WMVCore")
HRESULT WMCreateSyncReader(IUnknown pUnkCert, uint dwRights, IWMSyncReader* ppSyncReader);

///The <b>WMCreateEditor</b> function creates a metadata editor object.
///Params:
///    ppEditor = Pointer to a pointer to the IWMMetadataEditor interface of the newly created metadata editor object.
///Returns:
///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The function is unable to allocate memory for the new
///    object. </td> </tr> </table>
///    
@DllImport("WMVCore")
HRESULT WMCreateEditor(IWMMetadataEditor* ppEditor);

///The <b>WMCreateIndexer</b> function creates an indexer object.
///Params:
///    ppIndexer = Pointer to a pointer to the IWMIndexer interface of the newly created indexer object.
///Returns:
///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The function is unable to allocate memory for the new
///    object. </td> </tr> </table>
///    
@DllImport("WMVCore")
HRESULT WMCreateIndexer(IWMIndexer* ppIndexer);

///The <b>WMCreateBackupRestorer</b> function creates a backup restorer object.
///Params:
///    pCallback = Pointer to an IWMStatusCallback interface containing the <b>OnStatus</b> callback method to be used by the new
///                backup restorer object.
///    ppBackup = Pointer to a pointer to the IWMLicenseBackup interface of the newly created backup restorer object.
///Returns:
///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The function is unable to allocate memory for the new
///    object. </td> </tr> </table>
///    
@DllImport("WMVCore")
HRESULT WMCreateBackupRestorer(IUnknown pCallback, IWMLicenseBackup* ppBackup);

///The <b>WMCreateProfileManager</b> function creates a profile manager object.
///Params:
///    ppProfileManager = Pointer to a pointer to the IWMProfileManager interface of the newly created profile manager object.
///Returns:
///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The function is unable to allocate memory for the new
///    object. </td> </tr> </table>
///    
@DllImport("WMVCore")
HRESULT WMCreateProfileManager(IWMProfileManager* ppProfileManager);

///The <b>WMCreateWriterFileSink</b> function creates a writer file sink object.
///Params:
///    ppSink = Pointer to a pointer to the IWMWriterFileSink interface of the newly created writer file sink object.
///Returns:
///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The function is unable to allocate memory for the new
///    object. </td> </tr> </table>
///    
@DllImport("WMVCore")
HRESULT WMCreateWriterFileSink(IWMWriterFileSink* ppSink);

///The <b>WMCreateWriterNetworkSink</b> function creates a writer network sink object.
///Params:
///    ppSink = Pointer to a pointer to the IWMWriterNetworkSink interface of the newly created writer network sink object.
///Returns:
///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The function is unable to allocate memory for the new
///    object. </td> </tr> </table>
///    
@DllImport("WMVCore")
HRESULT WMCreateWriterNetworkSink(IWMWriterNetworkSink* ppSink);

///The <b>WMCreateWriterPushSink</b> function creates a writer push sink object. Push sinks are used to deliver
///streaming content to other media servers for distribution.
///Params:
///    ppSink = Pointer to a pointer to the IWMWriterPushSink interface of the newly created writer push sink object.
///Returns:
///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The function succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The function is unable to allocate memory for the new
///    object. </td> </tr> </table>
///    
@DllImport("WMVCore")
HRESULT WMCreateWriterPushSink(IWMWriterPushSink* ppSink);


// Interfaces

///The <b>IAMWMBufferPass</b> interface is implemented on the output pins of the WM ASF Reader and the input pins of the
///WM ASF Writer. Applications use it to give the pin a pointer to the IAMWMBufferPassCallback interface on an
///application-defined object that gets and sets properties and data unit extensions on individual samples in a stream.
///One common use for this interface is to force key-frame insertion in a variable bit rate video stream during file
///writing. To do this, you must set the cleanpoint property on individual <b>INSSBuffer3</b> samples.
@GUID("6DD816D7-E740-4123-9E24-2444412644D8")
interface IAMWMBufferPass : IUnknown
{
    ///The <b>SetNotify</b> method is used by applications to provide the WM ASF Writer or WM ASF Reader filter with a
    ///pointer to the application's IAMWMBufferPassCallback interface.
    ///Params:
    ///    pCallback = Pointer to the application's <b>IAMWMBufferPassCallback</b> interface.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetNotify(IAMWMBufferPassCallback pCallback);
}

///The <b>IAMWMBufferPassCallback</b> interface is provided for advanced scenarios in which applications need access to
///an <b>INSSBuffer3</b> sample before it is passed downstream for further processing. Use this technique to set or
///retrieve data unit extensions such as the SMPTE time code for each sample. One common use for this interface is to
///force key-frame insertion in a variable bit rate video stream during file writing. To do this, you must set the
///cleanpoint property on individual <b>INSSBuffer3</b> samples. This interface is implemented by applications and
///called by the WM ASF Writer or WM ASF Reader filter each time a new sample is delivered to the filter.
@GUID("B25B8372-D2D2-44B2-8653-1B8DAE332489")
interface IAMWMBufferPassCallback : IUnknown
{
    ///The <b>Notify</b> method is called by the pin for each buffer that is delivered during streaming.
    ///Params:
    ///    pNSSBuffer3 = Pointer to the INSSBuffer3 interface exposed on the media sample.
    ///    pPin = Pointer to the pin associated with the media stream that the sample belongs to.
    ///    prtStart = Start time of the sample.
    ///    prtEnd = End time of the sample.
    ///Returns:
    ///    No particular return value is specified. The calling pin ignores the <b>HRESULT</b>.
    ///    
    HRESULT Notify(INSSBuffer3 pNSSBuffer3, IPin pPin, long* prtStart, long* prtEnd);
}

///The <b>INSSBuffer</b> interface is the basic interface of a buffer object. A buffer object is a wrapper around a
///memory buffer. The methods exposed by this interface are used to manipulate the buffer. In both writing and reading
///ASF files, buffer objects are used to contain samples. Depending upon where you use a sample, you will obtain a
///reference to the <b>INSSBuffer</b> interface in one of three ways: <ul> <li>When passing samples to the writer, you
///can obtain buffer objects by calling IWMWriter::AllocateSample.</li> <li>When you are receiving samples from the
///asynchronous reader, buffer objects are created automatically, and references to an <b>INSSBuffer</b> interface are
///passed with every call the reader makes to the IWMReaderCallback::OnSample callback method.</li> <li>When you are
///receiving samples from the synchronous reader, a reference to an <b>INSSBuffer</b> interface is set with every call
///you make to IWMSyncReader::GetNextSample.</li> </ul> The following interfaces can be obtained by using the
///QueryInterface method of this interface. <table> <tr> <th>Interface</th> <th>IID</th> </tr> <tr> <td> INSSBuffer2
///</td> <td>IID_INSSBuffer2</td> </tr> <tr> <td> INSSBuffer3 </td> <td>IID_INSSBuffer3</td> </tr> <tr> <td> INSSBuffer4
///</td> <td>IID_INSSBuffer4</td> </tr> </table>
@GUID("E1CD3524-03D7-11D2-9EED-006097D2D7CF")
interface INSSBuffer : IUnknown
{
    ///The <b>GetLength</b> method retrieves the size of the used portion of the buffer controlled by the buffer object.
    ///Params:
    ///    pdwLength = Pointer to a <b>DWORD</b> containing the length of the buffer, in bytes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pdwLength</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetLength(uint* pdwLength);
    ///The <b>SetLength</b> method specifies the size of the used portion of the buffer. If you are storing a sample in
    ///the buffer, call INSSBuffer::GetBuffer to retrieve the address of the buffer. Then copy your data to that address
    ///and use this method to set the length of the used portion of the buffer.
    ///Params:
    ///    dwLength = <b>DWORD</b> containing the size of the used portion, in bytes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>dwLength</i> is greater than the buffer
    ///    size. </td> </tr> </table>
    ///    
    HRESULT SetLength(uint dwLength);
    ///The <b>GetMaxLength</b> method retrieves the maximum size to which a buffer can be set. The maximum value is set
    ///when the sample is created. If you are using IWMWriter::AllocateSample, the size you specify becomes the maximum
    ///buffer length. The actual amount of the buffer that is used can be retrieved by calling INSSBuffer::GetLength.
    ///Params:
    ///    pdwLength = Pointer to a <b>DWORD</b> containing the maximum length, in bytes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pdwLength</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetMaxLength(uint* pdwLength);
    ///The <b>GetBuffer</b> method retrieves the location of the buffer controlled by the buffer object. Buffers are
    ///used to store samples. When passing samples to the writer, you need the location of the buffer so you can copy
    ///your samples into it. When you copy data to the address returned by this call, you must call
    ///INSSBuffer::SetLength to specify how much of the buffer actually contains data. When receiving samples from the
    ///reader or synchronous reader, retrieve the size of the buffer at the same time as the location by calling
    ///INSSBuffer::GetBufferAndLength.
    ///Params:
    ///    ppdwBuffer = Pointer to a pointer to the buffer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>ppdwBuffer</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetBuffer(ubyte** ppdwBuffer);
    ///The <b>GetBufferAndLength</b> method retrieves the location and size of the used portion of the buffer controlled
    ///by the buffer object. Buffers are used to store samples. When reading ASF files, you can use the location and
    ///length to copy a sample from a buffer delivered by the reader or synchronous reader.
    ///Params:
    ///    ppdwBuffer = Pointer to a pointer to the buffer.
    ///    pdwLength = Pointer to a <b>DWORD</b> containing the length of the buffer, in bytes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>ppdwBuffer</i> or <i>pdwLength</i>
    ///    parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetBufferAndLength(ubyte** ppdwBuffer, uint* pdwLength);
}

///The <b>INSSBuffer2</b> interface inherits from INSSBuffer and defines two additional methods. Currently, neither of
///these methods is implemented. The following interfaces can be obtained by using the QueryInterface method of this
///interface. <table> <tr> <th>Interface</th> <th>IID</th> </tr> <tr> <td> INSSBuffer </td> <td>IID_INSSBuffer</td>
///</tr> <tr> <td> INSSBuffer3 </td> <td>IID_INSSBuffer3</td> </tr> <tr> <td> INSSBuffer4 </td> <td>IID_INSSBuffer4</td>
///</tr> </table>
@GUID("4F528693-1035-43FE-B428-757561AD3A68")
interface INSSBuffer2 : INSSBuffer
{
    HRESULT GetSampleProperties(uint cbProperties, ubyte* pbProperties);
    HRESULT SetSampleProperties(uint cbProperties, ubyte* pbProperties);
}

///The <b>INSSBuffer3</b> interface enhances the INSSBuffer interface by adding the ability to set and retrieve single
///properties for a sample. This interface inherits its functionality from the <b>INSSBuffer2</b> interface, which
///inherits functionality from <b>INSSBuffer</b>. <b>INSSBuffer2</b> is not documented separately in this documentation
///because the two methods it exposes are not implemented at this time. To obtain a pointer to the <b>INSSBuffer3</b>
///interface of an existing buffer object, call <b>INSSBuffer::QueryInterface</b>. The following interfaces can be
///obtained by using the QueryInterface method of this interface. <table> <tr> <th>Interface</th> <th>IID</th> </tr>
///<tr> <td> INSSBuffer </td> <td>IID_INSSBuffer</td> </tr> <tr> <td> INSSBuffer2 </td> <td>IID_INSSBuffer2</td> </tr>
///<tr> <td> INSSBuffer4 </td> <td>IID_INSSBuffer4</td> </tr> </table>
@GUID("C87CEAAF-75BE-4BC4-84EB-AC2798507672")
interface INSSBuffer3 : INSSBuffer2
{
    ///The <b>SetProperty</b> method is used to specify a property for the sample in the buffer. Buffer properties are
    ///used to pass information along with the sample to the writer object when writing ASF files. Sample properties are
    ///GUID values.
    ///Params:
    ///    guidBufferProperty = <b>GUID</b> value identifying the property you want to set. The predefined buffer properties are described in
    ///                         the Sample Extension Types section of this documentation. You can also define your own sample extension
    ///                         schemes using your own GUID values.
    ///    pvBufferProperty = Pointer to a buffer containing the property value.
    ///    dwBufferPropertySize = <b>DWORD</b> value containing the size of the buffer pointed to by <i>pvBufferProperty</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate memory for
    ///    the new property. </td> </tr> </table>
    ///    
    HRESULT SetProperty(GUID guidBufferProperty, void* pvBufferProperty, uint dwBufferPropertySize);
    ///The <b>GetProperty</b> method is used to retrieve a property of the sample in the buffer. Buffer properties are
    ///used to pass information along with the sample to the writer object when writing ASF files. Sample properties are
    ///GUID values.
    ///Params:
    ///    guidBufferProperty = <b>GUID</b> value identifying the property to retrieve. The predefined buffer properties are described in the
    ///                         Sample Extension Types section of this documentation. You can also define your own sample extension schemes
    ///                         using your own GUID values.
    ///    pvBufferProperty = Pointer to a buffer that will receive the value of the property specified by <i>guidBufferProperty</i>.
    ///    pdwBufferPropertySize = Pointer to a <b>DWORD</b> value containing the size of the buffer pointed to by <i>pvBufferProperty</i>. If
    ///                            you pass <b>NULL</b> for <i>pvBufferProperty</i>, the method sets the value pointed to by this parameter to
    ///                            the size required to hold the property value. If you pass a non-<b>NULL</b> value for
    ///                            <i>pvBufferProperty</i>, the value pointed to by this parameter must equal the size of the buffer pointed to
    ///                            by <i>pvBufferProperty</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pdwBufferPropertySize</i> is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_UNSUPPORTED_PROPERTY</b></dt> </dl> </td> <td width="60%">
    ///    The property specified as <i>guidBufferProperty</i> is not set in this buffer object. </td> </tr> </table>
    ///    
    HRESULT GetProperty(GUID guidBufferProperty, void* pvBufferProperty, uint* pdwBufferPropertySize);
}

///The <b>INSSBuffer4</b> interface provides methods to enumerate buffer properties. These methods are important when
///reading files that may have properties of which you are not aware. An <b>INSSBuffer4</b> interface exists for every
///buffer object. To retrieve a pointer to an instance of <b>INSSBuffer4</b>, call the <b>QueryInterface</b> method of
///one of the other interfaces in the buffer object, typically INSSBuffer. The following interfaces can be obtained by
///using the QueryInterface method of this interface. <table> <tr> <th>Interface</th> <th>IID</th> </tr> <tr> <td>
///INSSBuffer </td> <td>IID_INSSBuffer</td> </tr> <tr> <td> INSSBuffer2 </td> <td>IID_INSSBuffer2</td> </tr> <tr> <td>
///INSSBuffer3 </td> <td>IID_INSSBuffer3</td> </tr> </table>
@GUID("B6B8FD5A-32E2-49D4-A910-C26CC85465ED")
interface INSSBuffer4 : INSSBuffer3
{
    ///The <b>GetPropertyCount</b> method retrieves the total number of buffer properties, also called data unit
    ///extensions, associated with the sample contained in the buffer object. When using INSSBuffer4::GetPropertyByIndex
    ///to retrieve properties, the index used is between zero and the number specified by this method.
    ///Params:
    ///    pcBufferProperties = Pointer to the size of buffer properties.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetPropertyCount(uint* pcBufferProperties);
    ///The <b>GetPropertyByIndex</b> method retrieves a buffer property, also called a data unit extension, that was set
    ///using INSSBuffer3::SetProperty. This method differs from INSSBuffer3::GetProperty in that, instead of accessing
    ///the property by name, it uses an index ranging from zero to one less than the total number of properties
    ///associated with the sample.
    ///Params:
    ///    dwBufferPropertyIndex = <b>DWORD</b> containing the buffer property index. This value will be between zero and one less than the
    ///                            total number of properties associated with the sample. You can retrieve the total number of properties by
    ///                            calling INSSBuffer4::GetPropertyCount.
    ///    pguidBufferProperty = Pointer to a GUID specifying the type of buffer property.
    ///    pvBufferProperty = Void pointer containing the value of the buffer property.
    ///    pdwBufferPropertySize = Pointer to a <b>DWORD</b> containing the size of the value pointed to by <i>pvBufferProperty</i>. If you set
    ///                            <i>pvBufferProperty</i> to <b>NULL</b>, this value will be set to the required size in bytes of the buffer
    ///                            needed to store the property value.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetPropertyByIndex(uint dwBufferPropertyIndex, GUID* pguidBufferProperty, void* pvBufferProperty, 
                               uint* pdwBufferPropertySize);
}

///The <b>IWMSSBufferAllocator</b> interface provides methods for allocating a buffer. This method is implemented by the
///server object in Microsoft Windows Media Services 9 Series. For more information, see the Windows Media Services 9
///Series SDK documentation. <div class="alert"><b>Note</b> This interface is available only on Windows Server 2003,
///Enterprise Edition, and Windows Server 2003, Datacenter Edition.</div> <div> </div>
@GUID("61103CA4-2033-11D2-9EF1-006097D2D7CF")
interface IWMSBufferAllocator : IUnknown
{
    ///The <b>AllocateBuffer</b> method initializes a buffer.
    ///Params:
    ///    dwMaxBufferSize = <b>DWORD</b> containing the maximum size of the buffer in bytes.
    ///    ppBuffer = Address of a variable that receives a pointer to the INSSBuffer interface.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT AllocateBuffer(uint dwMaxBufferSize, INSSBuffer* ppBuffer);
    ///The <b>AllocatePageSizeBuffer</b> method initializes a buffer that can be used to perform page-aligned reads.
    ///Params:
    ///    dwMaxBufferSize = <b>DWORD</b> containing the size of the buffer in bytes.
    ///    ppBuffer = Address of a variable that receives a pointer to the INSSBuffer interface.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT AllocatePageSizeBuffer(uint dwMaxBufferSize, INSSBuffer* ppBuffer);
}

///The <b>IWMMediaProps</b> interface sets and retrieves the WM_MEDIA_TYPE structure for an input, stream, or output. In
///the case of inputs and streams, the contents of the media type structure determine what actions the writer object
///will perform on the input data when writing the file. Typically, the input media type is an uncompressed type and the
///stream is a compressed type, so that the contents of their respective media type structures will determine the
///settings passed by the writer to the codec that will compress the stream. In the case of outputs, the media type
///structure determines the settings used to decompress the contents of a stream. The Windows Media codecs are capable
///of delivering output content in a variety of formats. The methods of <b>IWMMediaProps</b> are inherited by
///IWMVideoMediaProps, which provides access to additional settings for specifying video media types. The methods are
///also inherited by IWMInputMediaProps and IWMOutputMediaProps. An instance of the <b>IWMMediaProps</b> interface
///exists for every stream configuration object, input media properties object, and output media properties object. You
///can retrieve a pointer to this interface by calling the <b>QueryInterface</b> method of any other interface in one of
///those objects.
@GUID("96406BCE-2B2B-11D3-B36B-00C04F6108FF")
interface IWMMediaProps : IUnknown
{
    ///The <b>GetType</b> method retrieves the major type of the media in the stream, input, or output described by the
    ///object to which the current <b>IWMMediaProps</b> interface belongs.
    ///Params:
    ///    pguidType = Pointer to a GUID specifying the media type.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pguidType</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetType(GUID* pguidType);
    ///The <b>GetMediaType</b> method retrieves a structure describing the media type.
    ///Params:
    ///    pType = Pointer to a WM_MEDIA_TYPE structure. If this parameter is set to <b>NULL</b>, this method returns the size
    ///            of the buffer required in the <i>pcbType</i> parameter.
    ///    pcbType = On input, the size of the <i>pType</i> buffer. On output, if <i>pType</i> is set to <b>NULL</b>, the value
    ///              this points to is set to the size of the buffer needed to hold the media type structure.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pcbType</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>pcbType</i> parameter is not large enough. </td> </tr> </table>
    ///    
    HRESULT GetMediaType(WM_MEDIA_TYPE* pType, uint* pcbType);
    ///The <b>SetMediaType</b> method specifies the media type.
    ///Params:
    ///    pType = Pointer to the WM_MEDIA_TYPE structure describing the input, stream, or output.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pType</i> parameter is <b>NULL</b>,
    ///    cbFormat is 0 or too large, or pbFormat is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough available memory. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetMediaType(WM_MEDIA_TYPE* pType);
}

///With this interface, the application can specify additional video-specific parameters not available on the
///IWMMediaProps interface. To get access to the methods of this interface, call <b>QueryInterface</b> on a stream
///configuration object. For more information, see IWMStreamConfig Interface).
@GUID("96406BCF-2B2B-11D3-B36B-00C04F6108FF")
interface IWMVideoMediaProps : IWMMediaProps
{
    ///The <b>GetMaxKeyFrameSpacing</b> method retrieves the maximum interval between key frames.
    ///Params:
    ///    pllTime = Pointer to a variable that receives the interval in 100-nanosecond units.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pllTime</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetMaxKeyFrameSpacing(long* pllTime);
    ///The <b>SetMaxKeyFrameSpacing</b> method specifies the maximum interval between key frames.
    ///Params:
    ///    llTime = Maximum key-frame spacing in 100-nanosecond units.
    ///Returns:
    ///    This method always returns S_OK.
    ///    
    HRESULT SetMaxKeyFrameSpacing(long llTime);
    ///The <b>GetQuality</b> method retrieves the quality setting for the video stream.
    ///Params:
    ///    pdwQuality = Pointer to a <b>DWORD</b> containing the quality setting.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pdwQuality</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetQuality(uint* pdwQuality);
    ///The <b>SetQuality</b> method specifies the quality setting for the video stream.
    ///Params:
    ///    dwQuality = <b>DWORD</b> specifying the quality setting, in the range from zero (maximum frame rate) to 100 (maximum
    ///                image quality).
    ///Returns:
    ///    This method always returns S_OK.
    ///    
    HRESULT SetQuality(uint dwQuality);
}

///The <b>IWMWriter</b> interface is used to write ASF files. It includes methods for allocating buffers, setting and
///retrieving input properties, and setting profiles and output file names. The writer object exposes this interface. To
///create the writer object, call the WMCreateWriter function.
@GUID("96406BD4-2B2B-11D3-B36B-00C04F6108FF")
interface IWMWriter : IUnknown
{
    ///The <b>SetProfileByID</b> method specifies the profile to use for the current writing task, identifying the
    ///profile by its GUID.
    ///Params:
    ///    guidProfile = GUID of the profile.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetProfileByID(const(GUID)* guidProfile);
    ///The <b>SetProfile</b> method specifies the profile to use for the current writing task.
    ///Params:
    ///    pProfile = Pointer to an IWMProfile interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>ASF_E_STREAMNUMBERINUSE</b></dt> </dl> </td> <td width="60%"> More than one stream in the profile
    ///    has the same stream number. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALIDPROFILE</b></dt> </dl>
    ///    </td> <td width="60%"> The profile has zero streams. The bit rate was specified as zero for a CBR-encoding
    ///    mode. More than one script stream was specified. The bandwidth-sharing information is incorrect or
    ///    inconsistent. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_STATE</b></dt> </dl> </td> <td
    ///    width="60%"> The writer is not in a configurable state. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_INVALID_STREAM</b></dt> </dl> </td> <td width="60%"> For any stream: <ul> <li>A buffer window
    ///    greater than 100,000 was specified.</li> <li>A stream number was specified as less than one or greater than
    ///    63.</li> </ul> For audio streams: <ul> <li>The <b>formattype</b> is not <b>WMFORMAT_WaveFormatEx</b>.</li>
    ///    <li>The <b>wformatTag</b> is not WAVE_FORMAT_PCM and <b>nAvgBytesPerSec</b> is zero.</li> <li>The FOURCC
    ///    derived from the subtype <b>GUID</b> does not match the <b>dwFormatTag</b>.</li> <li>For PCM audio,
    ///    <b>nAvgBytesPerSec</b> is not equal to (<b>nSamplesPerSec</b> * <b>nBlockAlign</b>).</li> <li>For PCM audio,
    ///    <b>nBlockAlign</b> is not equal to (<b>nChannels</b> * <b>wBitsPerSample</b> / 8).</li> </ul> For video
    ///    streams: <ul> <li>The <b>formattype</b> is not <b>WMFORMAT_VideoInfo</b>.</li> <li><b>cbFormat</b> is not
    ///    equal to sizeof(<b>WMVIDEOINFOHEADER</b>).</li> <li>The bit rate specified through <b>IWMStreamConfig</b> is
    ///    not equal to the value of <b>dwBitrate</b> in the <b>VIDEOINFOHEADER</b>. (Does not apply if
    ///    IWMStreamConfig::SetBitrate was used to set a bit rate of zero.)</li> <li>On uncompressed video streams,
    ///    <b>bmiHeader.biSizeImage</b> has been specified incorrectly.</li> <li>The rectangle width or height specified
    ///    in the <b>bmiHeader</b> is not valid for the compression type. (Some types require two- or four-byte
    ///    alignment.)</li> <li>Any member of the <b>rcSource</b> or <b>rcTarget</b> rectangles is negative.</li>
    ///    <li>The FOURCC derived from the subtype <b>GUID</b> does not match <b>bmiHeader.biCompression</b>.</li>
    ///    <li>The <b>bmiHeader.biCompression</b> member is BI_BITFIELDS, but <b>cbFormat</b> is incorrect.</li>
    ///    <li>When <b>bmiHeader.biCompression</b> = BI_RGB or BI_BITFIELDS, the <b>biBitCount</b>, <b>biClrUsed</b>, or
    ///    <b>cbFormat</b> values are inconsistent or invalid. (Remember that the size of the format block is larger if
    ///    the <b>BITMAPINFOHEADER</b> contains an index of palette values.)</li> </ul> For script streams: <ul> <li>The
    ///    <b>formattype</b> is not specified as <b>WMFORMAT_Script</b>.</li> <li>The subtype is not specified as
    ///    <b>GUID_NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_SDK_BUFFERTOOSMALL</b></dt>
    ///    </dl> </td> <td width="60%"> The size specified for a language string in an audio stream is too small. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetProfile(IWMProfile pProfile);
    ///The <b>SetOutputFilename</b> method specifies the name of the file to be written.
    ///Params:
    ///    pwszFilename = Pointer to a wide-character null-terminated string containing the file name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The
    ///    writer is not in a configurable state. </td> </tr> </table>
    ///    
    HRESULT SetOutputFilename(const(PWSTR) pwszFilename);
    ///The <b>GetInputCount</b> method retrieves the number of uncompressed input streams.
    ///Params:
    ///    pcInputs = Pointer to a count of inputs.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pcInputs</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetInputCount(uint* pcInputs);
    ///The <b>GetInputProps</b> method retrieves the current media properties of a specified input stream.
    ///Params:
    ///    dwInputNum = <b>DWORD</b> containing the input index number.
    ///    ppInput = Pointer to a pointer to an IWMInputMediaProps object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>dwInputNum</i> value is greater than
    ///    the highest index number. </td> </tr> </table>
    ///    
    HRESULT GetInputProps(uint dwInputNum, IWMInputMediaProps* ppInput);
    ///The <b>SetInputProps</b> method specifies the media properties of an input stream.
    ///Params:
    ///    dwInputNum = <b>DWORD</b> containing the input number.
    ///    pInput = Pointer to an IWMInputMediaProps interface. See Remarks.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>dwInputNum</i> is greater than the highest
    ///    index number. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> There is not enough available memory. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetInputProps(uint dwInputNum, IWMInputMediaProps pInput);
    ///The <b>GetInputFormatCount</b> method retrieves the number of media format types supported by this input on the
    ///writer.
    ///Params:
    ///    dwInputNumber = <b>DWORD</b> containing the input number.
    ///    pcFormats = Pointer to a count of formats.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pcFormats</i> parameter is <b>NULL</b>.
    ///    OR <i>dwInputNumber</i> is too large. </td> </tr> </table>
    ///    
    HRESULT GetInputFormatCount(uint dwInputNumber, uint* pcFormats);
    ///The <b>GetInputFormat</b> method retrieves possible media formats for the specified input.
    ///Params:
    ///    dwInputNumber = <b>DWORD</b> containing the input number.
    ///    dwFormatNumber = <b>DWORD</b> containing the format number.
    ///    pProps = Pointer to a pointer to an IWMInputMediaProps interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>dwInputNumber</i> is too large. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetInputFormat(uint dwInputNumber, uint dwFormatNumber, IWMInputMediaProps* pProps);
    ///The <b>BeginWriting</b> method initializes the writing process.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough available memory. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed
    ///    for an unspecified reason. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_AUDIO_CODEC_ERROR</b></dt>
    ///    </dl> </td> <td width="60%"> An error occurred in the audio codec. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_AUDIO_CODEC_NOT_INSTALLED</b></dt> </dl> </td> <td width="60%"> The required audio codec is not
    ///    available. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_DRM_RIV_TOO_SMALL</b></dt> </dl> </td> <td
    ///    width="60%"> A more recent content revocation list is needed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_INVALID_OUTPUT_FORMAT</b></dt> </dl> </td> <td width="60%"> The output format is not valid. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_VIDEO_CODEC_ERROR</b></dt> </dl> </td> <td width="60%"> An error
    ///    occurred in the video codec. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_VIDEO_CODEC_NOT_INSTALLED</b></dt> </dl> </td> <td width="60%"> The required video codec is not
    ///    available. </td> </tr> </table>
    ///    
    HRESULT BeginWriting();
    ///The <b>EndWriting</b> method performs tasks required at the end of a writing session. This method flushes the
    ///buffers, updates indices and headers, and closes the file. You must call <b>EndWriting</b> when you have finished
    ///sending samples to the writer to encode an ASF file.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The writer cannot currently be run.
    ///    </td> </tr> </table>
    ///    
    HRESULT EndWriting();
    ///The <b>AllocateSample</b> method allocates a buffer that can be used to provide samples to the writer.
    ///Params:
    ///    dwSampleSize = <b>DWORD</b> containing the sample size, in bytes.
    ///    ppSample = Pointer to a pointer to an INSSBuffer interface to an object containing the sample.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> The writer is not currently running.
    ///    </td> </tr> </table>
    ///    
    HRESULT AllocateSample(uint dwSampleSize, INSSBuffer* ppSample);
    ///The <b>WriteSample</b> method passes in uncompressed data to be compressed and appended to the file that is being
    ///created.
    ///Params:
    ///    dwInputNum = <b>DWORD</b> containing the input number.
    ///    cnsSampleTime = <b>QWORD</b> containing the sample time, in 100-nanosecond units.
    ///    dwFlags = <b>DWORD</b> containing one or more of the following flags. <table> <tr> <th>Flag </th> <th>Description </th>
    ///              </tr> <tr> <td>No flag set</td> <td>None of the conditions for the other flags applies. For example, a delta
    ///              frame in most cases would not have any flags set for it.</td> </tr> <tr> <td>WM_SF_CLEANPOINT</td> <td>Forces
    ///              the sample to be written as a key frame. Setting this flag for audio inputs will have no effect, as all audio
    ///              samples are cleanpoints.</td> </tr> <tr> <td>WM_SF_DISCONTINUITY</td> <td>For audio inputs, this flag helps
    ///              to deal with gaps that may appear between samples. You should set this flag for the first sample after a
    ///              gap.</td> </tr> <tr> <td>WM_SF_DATALOSS</td> <td>This flag is not used by the writer object.</td> </tr>
    ///              </table>
    ///    pSample = Pointer to an INSSBuffer interface representing a sample.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>dwInputNum</i> value is greater than
    ///    the highest index number. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed for an unspecified reason. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The writer is not running. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>NS_E_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> The sample is not valid.
    ///    This can occur when an input script stream contains a script sample that is not valid. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>NS_E_INVALID_NUM_PASSES</b></dt> </dl> </td> <td width="60%"> The wrong number of
    ///    preprocessing passes was used for the stream's output type. Typically, this error will be returned if the
    ///    stream configuration requires a preprocessing pass and a sample is passed without first configuring
    ///    preprocessing. You can check for this error to determine whether a stream requires a preprocessing pass.
    ///    Preprocessing passes are required only for bit-rate-based VBR. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_LATE_OPERATION</b></dt> </dl> </td> <td width="60%"> The writer has received samples whose
    ///    presentation times differ by an amount greater than the maximum synchronization tolerance. You can set the
    ///    synchronization tolerance by calling IWMWriterAdvanced::SetSyncTolerance. This error can occur when there is
    ///    more than one stream, and the application sends samples for one stream at a faster rate than the other
    ///    stream. At some point, the second stream will lag too far behind the first, and the writer will return this
    ///    error code. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_TOO_MUCH_DATA</b></dt> </dl> </td> <td
    ///    width="60%"> Samples from a real-time source are arriving faster than expected. This error is returned only
    ///    if IWMWriterAdvanced::SetLiveSource has been called to indicate a live source. </td> </tr> </table>
    ///    
    HRESULT WriteSample(uint dwInputNum, ulong cnsSampleTime, uint dwFlags, INSSBuffer pSample);
    ///The functionality of the <b>Flush</b> method has been removed, because IWMWriter::EndWriting performs the needed
    ///checks internally. For compatibility with older applications, calls to flush will always return S_OK even though
    ///the call does nothing.
    ///Returns:
    ///    This method always returns S_OK.
    ///    
    HRESULT Flush();
}

///<p class="CCE_Message">[<b>IWMDRMWriter</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady. ]
///The <b>IWMDRMWriter</b> interface provides support for applying DRM protection to content in ASF files. You can use
///this interface to set various DRM file attributes and run-time properties, and to generate DRM keys for encrypting
///the content and the DRM header, without needing to call functions external to the Windows Media Format SDK. Prior to
///Windows Media 9 Series, it was necessary to use the Windows Media Rights Manager SDK to apply protection to files.
///The ability to protect files "on the fly" as you write them enables scenarios such as "Live DRM" in which live
///streaming content, such as a pay-per-view sports event or concert, can be delivered over the Internet. An
///<b>IWMDRMWriter</b> interface exists for every writer object. You can obtain a pointer to an instance of this
///interface by calling the <b>QueryInterface</b> method of any interface in a writer object.
@GUID("D6EA5DD0-12A0-43F4-90AB-A3FD451E6A07")
interface IWMDRMWriter : IUnknown
{
    ///<p class="CCE_Message">[<b>GenerateKeySeed</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>GenerateKeySeed</b> method generates a DRM key seed.
    ///Params:
    ///    pwszKeySeed = Pointer to a wide-character <b>null</b>-terminated string containing the key seed. Set to <b>NULL</b> to
    ///                  retrieve the size of the string, which is returned in <i>pcwchLength</i>.
    ///    pcwchLength = Pointer to a <b>DWORD</b> containing the size, in wide characters, of <i>pwszKeySeed</i>. This size includes
    ///                  the terminating <b>null</b> character.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GenerateKeySeed(PWSTR pwszKeySeed, uint* pcwchLength);
    ///<p class="CCE_Message">[<b>GenerateKeyID</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>GenerateKeyID</b> method generates a DRM key ID.
    ///Params:
    ///    pwszKeyID = Pointer to a wide-character <b>null</b>-terminated string containing the key identifier. Set to <b>NULL</b>
    ///                to retrieve the size of the string, which is returned in <i>pcwchLength</i>.
    ///    pcwchLength = Pointer to a <b>DWORD</b> containing the size, in wide characters, of <i>pwszKeyID</i>. This size includes
    ///                  the terminating <b>null</b> character.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GenerateKeyID(PWSTR pwszKeyID, uint* pcwchLength);
    ///<p class="CCE_Message">[<b>GenerateSigningKeyPair</b> is available for use in the operating systems specified in
    ///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft
    ///PlayReady. ] The <b>GenerateSigningKeyPair</b> method generates a public and private key pair that are used to
    ///sign the DRM header object.
    ///Params:
    ///    pwszPrivKey = Pointer to a wide-character <b>null</b>-terminated string containing the private key. Set to <b>NULL</b> to
    ///                  retrieve the size of the string, which is returned in <i>pcwchPrivKeyLength</i>. Use this key to set the
    ///                  DRM_HeaderSignPrivKey property.
    ///    pcwchPrivKeyLength = Pointer to a <b>DWORD</b> containing the size, in wide characters, of <i>pwszPrivKey</i>. This size includes
    ///                         the terminating <b>null</b> character.
    ///    pwszPubKey = Pointer to a wide-character <b>null</b>-terminated string containing the public key. Set to <b>NULL</b> to
    ///                 retrieve the size of the string, which is returned in <i>pcwchPubKeyLength</i>. This key is shared only with
    ///                 the license server; it enables the license server to verify the signature of the DRM header object when users
    ///                 attempt to obtain a content license for a file.
    ///    pcwchPubKeyLength = Pointer to a <b>DWORD</b> containing the size, in wide characters, of <i>pwsPubKey</i>. This size includes
    ///                        the terminating <b>null</b> character.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GenerateSigningKeyPair(PWSTR pwszPrivKey, uint* pcwchPrivKeyLength, PWSTR pwszPubKey, 
                                   uint* pcwchPubKeyLength);
    ///<p class="CCE_Message">[<b>SetDRMAttribute</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>SetDRMAttribute</b> method sets DRM-header attributes as well as other DRM run-time properties.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number to which the attribute applies.
    ///    pszName = Pointer to a null-terminated string containing the attribute name. See Remarks for supported attributes.
    ///    Type = A value from the WMT_ATTR_DATATYPE enumeration type specifying the data type of the attribute data.
    ///    pValue = Pointer to an array of bytes containing the attribute data.
    ///    cbLength = The size, in bytes, of the attribute data pointed to by <i>pValue</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetDRMAttribute(ushort wStreamNum, const(PWSTR) pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, 
                            ushort cbLength);
}

///<p class="CCE_Message">[<b>IWMDRMWriter2</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady. ]
///The <b>IWMDRMWriter2</b> interface provides a method that enables you to write content encrypted with Windows Media
///DRM 10 for Network Devices. An <b>IWMDRMWriter2</b> interface exists for every writer object. You can obtain a
///pointer to an instance of this interface by calling the <b>QueryInterface</b> method of any interface of a writer
///object.
@GUID("38EE7A94-40E2-4E10-AA3F-33FD3210ED5B")
interface IWMDRMWriter2 : IWMDRMWriter
{
    ///<p class="CCE_Message">[<b>SetWMDRMNetEncryption</b> is available for use in the operating systems specified in
    ///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft
    ///PlayReady. ] The <b>SetWMDRMNetEncryption</b> method configures the writer to receive input samples encoded with
    ///Windows Media DRM 10 for Network Devices.
    ///Params:
    ///    fSamplesEncrypted = Flag that specifies whether the samples sent to the writer will be encoded for Windows Media DRM 10 for
    ///                        Network Devices protocol.
    ///    pbKeyID = Address of the key identification in memory.
    ///    cbKeyID = The size of the key identification in bytes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetWMDRMNetEncryption(BOOL fSamplesEncrypted, ubyte* pbKeyID, uint cbKeyID);
}

///<p class="CCE_Message">[<b>IWMDRMWriter3</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady. ]
///The <b>IWMDRMWriter3</b> interface enables writing of encrypted stream samples for importing protected content. An
///<b>IWMDRMWriter3</b> interface exists for every writer object when linking to WMStubDRM.lib. You can obtain a pointer
///to an instance of this interface by calling the <b>QueryInterface</b> method of any interface of a writer object.
@GUID("A7184082-A4AA-4DDE-AC9C-E75DBD1117CE")
interface IWMDRMWriter3 : IWMDRMWriter2
{
    ///<p class="CCE_Message">[<b>SetProtectStreamSamples</b> is available for use in the operating systems specified in
    ///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft
    ///PlayReady. ] The <b>SetProtectStreamSamples</b> method configures the writer to accept encrypted stream samples.
    ///This method is used as part of the process of importing protected content from a third party content protection
    ///scheme (CPS) into Windows Media DRM.
    ///Params:
    ///    pImportInitStruct = Address of a WMDRM_IMPORT_INIT_STRUCT structure containing initialization information needed to import
    ///                        protected content.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_DRM_RIV_TOO_SMALL</b></dt> </dl> </td> <td width="60%"> An updated content revocation list is
    ///    needed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method
    ///    succeeded. </td> </tr> </table>
    ///    
    HRESULT SetProtectStreamSamples(WMDRM_IMPORT_INIT_STRUCT* pImportInitStruct);
}

///The <b>IWMInputMediaProps</b> interface is used to retrieve the properties of digital media that will be passed to
///the writer. An input media properties object is created by a call to either the IWMWriter::GetInputProps or
///IWMWriter::GetInputFormat method.
@GUID("96406BD5-2B2B-11D3-B36B-00C04F6108FF")
interface IWMInputMediaProps : IWMMediaProps
{
    ///The <b>GetConnectionName</b> method retrieves the connection name specified in the profile.
    ///Params:
    ///    pwszName = Pointer to a wide-character <b>null</b>-terminated string containing the connection name. Pass <b>NULL</b> to
    ///               retrieve the length required for the name.
    ///    pcchName = On input, a pointer to a variable containing the length of the <i>pwszName</i> array in wide characters (2
    ///               bytes). On output, if the method succeeds, the variable contains the length of the name, including the
    ///               terminating <b>null</b> character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pcchName</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>pwszName</i> parameter is not large enough. </td> </tr> </table>
    ///    
    HRESULT GetConnectionName(PWSTR pwszName, ushort* pcchName);
    ///The <b>GetGroupName</b> method is not implemented, and returns an empty string.
    ///Params:
    ///    pwszName = Pointer to a wide-character <b>null</b>-terminated string containing the name. Pass <b>NULL</b> to retrieve
    ///               the length required for the name.
    ///    pcchName = On input, a pointer to a variable containing the length of the <i>pwszName</i> array in wide characters (2
    ///               bytes). On output, if the method succeeds, the variable contains the length of the name, including the
    ///               terminating <b>null</b> character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pcchName</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>pwszName</i> parameter is not large enough. </td> </tr> </table>
    ///    
    HRESULT GetGroupName(PWSTR pwszName, ushort* pcchName);
}

///The <b>IWMPropertyVault</b> interface provides methods to store and retrieve properties. Currently, you can use this
///interface to set properties associated with variable bit rate (VBR) encoding. The generic nature of
///<b>IWMPropertyVault</b> allows for its use in other situations in future versions of the Format SDK.
///<b>IWMPropertyVault</b> is exposed by stream configuration objects. To obtain a pointer to <b>IWMPropertyVault</b>,
///you must call the <b>QueryInterface</b> method of one of the other interfaces of an existing stream configuration
///object.
@GUID("72995A79-5090-42A4-9C8C-D9D0B6D34BE5")
interface IWMPropertyVault : IUnknown
{
    ///The <b>GetPropertyCount</b> method retrieves a count of all the properties in the property vault.
    ///Params:
    ///    pdwCount = Pointer to a <b>DWORD</b> that will receive the property count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> pdwCount is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetPropertyCount(uint* pdwCount);
    ///The <b>GetPropertyByName</b> method retrieves a property from the vault by its name.
    ///Params:
    ///    pszName = Pointer to a <b>null</b>-terminated string containing the name of the property to be retrieved.
    ///    pType = Pointer to a member of the WMT_ATTR_DATATYPE enumeration type. This parameter specifies the type of data
    ///            pointed to by <i>pValue</i>.
    ///    pValue = Pointer to a data buffer containing the value of the property. This value can be one of several types. The
    ///             type of data that the buffer contains on output is specified by the value of <i>pType</i>.
    ///    pdwSize = Pointer to a <b>DWORD</b> containing the size, in bytes, of the data at <i>pValue</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pszName</i> or <i>pdwSize</i> or
    ///    <i>pType</i> is <b>NULL</b>. OR <i>pszName</i> contains an invalid property name. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> <i>pdwSize</i> specifies
    ///    a size for <i>pValue</i> that is not large enough to hold the data. </td> </tr> </table>
    ///    
    HRESULT GetPropertyByName(const(PWSTR) pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, uint* pdwSize);
    ///The <b>SetProperty</b> method sets the values for a property. If the property named already exists in the
    ///property vault, <b>SetProperty</b> changes its value as specified. If the property named does not exist,
    ///<b>SetProperty</b> adds it to the property vault.
    ///Params:
    ///    pszName = Pointer to a <b>null</b>-terminated string containing the name of the property to set. The following table
    ///              lists the property names supported by the <b>IWMPropertyVault</b> interface. The property used dictates the
    ///              data type and meaning of the data pointed to by <i>pValue</i>; these values are also in the table. All of
    ///              these values apply to stream configuration objects. <table> <tr> <th>Global constant </th> <th>Data type
    ///              </th> <th>Description </th> </tr> <tr> <td>g_wszOriginalSourceFormatTag</td> <td><b>WMT_TYPE_WORD </b></td>
    ///              <td>When transcoding with smart recompression, set to the <b>WAVEFORMATEX.wFormatTag</b> used in the original
    ///              encoding.This value is now obsolete, use g_wszOriginalWaveFormat instead. </td> </tr> <tr>
    ///              <td>g_wszOriginalWaveFormat</td> <td><b>WMT_TYPE_BINARY </b></td> <td>When transcoding with smart
    ///              recompression, set to the WAVEFORMATEX structure used in the original encoding.</td> </tr> <tr>
    ///              <td>g_wszEDL</td> <td><b>WMT_TYPE_STRING </b></td> <td>For Windows Media Audio 9 Voice streams, use to
    ///              manually specify sections of the stream that contain music. This property should only be used if the
    ///              automatic selection by the codec is creating a poor quality stream.</td> </tr> <tr> <td>g_wszComplexity</td>
    ///              <td><b>WMT_TYPE_WORD </b></td> <td>Set to the complexity setting desired. You can find the complexity levels
    ///              supported by a codec by calling IWMCodecInfo3::GetCodecProp.</td> </tr> <tr>
    ///              <td>g_wszDecoderComplexityRequested</td> <td><b>WMT_TYPE_STRING </b></td> <td>Set to the string value of the
    ///              device conformance template that you would like the stream to be encoded to. For audio there is only one
    ///              string value, for video, us the two-letter designation before the ampersand. For more information, see Device
    ///              Conformance Template Parameters.</td> </tr> <tr> <td>g_wszPeakValue</td> <td><b>WMT_TYPE_DWORD </b></td>
    ///              <td>Set to the peak volume level by the audio codec. Used for normalization. Do not manually set.</td> </tr>
    ///              <tr> <td>g_wszAverageLevel</td> <td><b>WMT_TYPE_DWORD </b></td> <td>Set to the average volume level by the
    ///              audio codec. Used for normalization. Do not manually set.</td> </tr> <tr> <td>g_wszFold6To2Channels3</td>
    ///              <td><b>WMT_TYPE_STRING </b></td> <td>Set to the value for 6 to 2 channel fold down. Use for multichannel
    ///              audio.</td> </tr> <tr> <td>g_wszFoldToChannelsTemplate</td> <td><b>WMT_TYPE_STRING </b></td> <td>Template
    ///              string to create other fold down values.</td> </tr> <tr> <td>g_wszMusicSpeechClassMode</td>
    ///              <td><b>WMT_TYPE_STRING </b></td> <td>Set to the type of encoding you want to use with the Windows Media Audio
    ///              9 Voice codec. Can be set to:g_wszMusicClassMode g_wszSpeechClassMode g_wszMixedClassMode </td> </tr>
    ///              </table> In addition to the values in the table, the settings for variable bit rate encoding are set using
    ///              this method. For more information, see Configuring VBR Streams.
    ///    pType = Pointer to a member of the WMT_ATTR_DATATYPE enumeration type. This parameter specifies the type of data
    ///            pointed to by <i>pValue</i>.
    ///    pValue = Pointer to a data buffer containing the value of the property. This value can be one of several types. The
    ///             type of data that the buffer contains on output is specified by the value of <i>pType</i>.
    ///    dwSize = <b>DWORD</b> containing the size, in bytes, of the data at <i>pValue</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pszName</i> is <b>NULL</b> or points to a
    ///    zero length string. OR The type specified at <i>pValue</i> does not agree with the size in bytes specified by
    ///    <i>dwSize</i>. OR You are trying to delete a property that does not exist in the property vault. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method cannot
    ///    allocate memory for a new property. OR The method cannot allocate memory for a new value. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetProperty(const(PWSTR) pszName, WMT_ATTR_DATATYPE pType, ubyte* pValue, uint dwSize);
    ///The <b>GetPropertyByIndex</b> method retrieves a property from the vault by its index value.
    ///Params:
    ///    dwIndex = <b>DWORD</b> containing the property index.
    ///    pszName = Pointer to a wide-character <b>null</b>-terminated string containing the name of the property.
    ///    pdwNameLen = On input, a pointer to a <b>DWORD</b> containing the length, in wide characters, of the string at
    ///                 <i>pszName</i>. On output, specifies the number of characters, including the terminating <b>null</b>
    ///                 character, required to hold the property name.
    ///    pType = Pointer to a member of the WMT_ATTR_DATATYPE enumeration type. This parameter specifies the type of data
    ///            pointed to by <i>pValue</i>.
    ///    pValue = Pointer to a data buffer containing the value of the property. This value can be one of several types. The
    ///             type of data that the buffer contains on output is specified by the value of <i>pType</i>.
    ///    pdwSize = Pointer to a <b>DWORD</b> containing the size, in bytes, of the data at <i>pValue</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pdwNameLen</i> or <i>pdwSize</i> or
    ///    <i>pType</i> is <b>NULL</b>. OR The index specified is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> One of the buffers (<i>pszName</i> or
    ///    <i>pValue</i>) is not big enough to hold the property information. </td> </tr> </table>
    ///    
    HRESULT GetPropertyByIndex(uint dwIndex, PWSTR pszName, uint* pdwNameLen, WMT_ATTR_DATATYPE* pType, 
                               ubyte* pValue, uint* pdwSize);
    ///The <b>CopyPropertiesFrom</b> method copies all of the properties from another property vault to this one.
    ///Params:
    ///    pIWMPropertyVault = Pointer to an <b>IWMPropertyVault</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to allocate memory
    ///    needed to copy. </td> </tr> </table>
    ///    
    HRESULT CopyPropertiesFrom(IWMPropertyVault pIWMPropertyVault);
    ///The <b>Clear</b> method removes all items from the property vault.
    ///Returns:
    ///    This method always returns S_OK.
    ///    
    HRESULT Clear();
}

///The <b>IWMIStreamProps</b> interface provides access to the properties of an <b>IStream</b> object. To obtain a
///pointer to an <b>IWMIStreamProps</b> interface, call <b>IStream::QueryInterface</b>.
@GUID("6816DAD3-2B4B-4C8E-8149-874C3483A753")
interface IWMIStreamProps : IUnknown
{
    ///The <b>GetProperty</b> method retrieves a named property from the <b>IStream</b>.
    ///Params:
    ///    pszName = Pointer to a <b>null</b>-terminated string containing the name of the property to retrieve. You should use
    ///              the global identifier to refer to properties so that any error will appear at compile time. The following
    ///              table lists the available <b>IStream</b> properties. <table> <tr> <th>Property name </th> <th>Global
    ///              identifier </th> </tr> <tr> <td><b>ReloadIndexOnSeek</b></td> <td>g_wszReloadIndexOnSeek</td> </tr> <tr>
    ///              <td><b>StreamNumIndexObjects</b></td> <td>g_wszStreamNumIndexObjects</td> </tr> <tr>
    ///              <td><b>FailSeekOnError</b></td> <td>g_wszFailSeekOnError</td> </tr> <tr>
    ///              <td><b>PermitSeeksBeyondEndOfStream</b></td> <td>g_wszPermitSeeksBeyondEndOfStream</td> </tr> <tr>
    ///              <td><b>UsePacketAtSeekPoint</b></td> <td>g_wszUsePacketAtSeekPoint</td> </tr> <tr>
    ///              <td><b>SourceBufferTime</b></td> <td>g_wszSourceBufferTime</td> </tr> <tr>
    ///              <td><b>SourceMaxBytesAtOnce</b></td> <td>g_wszSourceMaxBytesAtOnce</td> </tr> </table>
    ///    pType = Pointer to a variable that will receive one member of the WMT_ATTR_DATATYPE enumeration type. This value
    ///            indicates the type of data in the buffer at <i>pValue</i>.
    ///    pValue = Pointer to a byte buffer that will receive the property value. The type of data returned to the buffer is
    ///             indicated by the value pointed to by <i>pType</i>.
    ///    pdwSize = Pointer to a <b>DWORD</b> containing the size of the buffer at <i>pValue</i>. On return, this value will be
    ///              set to the correct size of the property value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pType</i>, <i>pValue</i>, or <i>pdwSize</i>
    ///    is <b>NULL</b>. OR The buffer is not big enough to hold the requested value. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> <i>pszName</i> specifies an invalid
    ///    property name. </td> </tr> </table>
    ///    
    HRESULT GetProperty(const(PWSTR) pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, uint* pdwSize);
}

///The <b>IWMReader</b> interface is used to open, close, start, pause, resume, and unlock the <b>WMReader</b> object.
///It is also used to stop reading files, and to get and set the output properties. Many of the methods in this
///interface are asynchronous and send status notifications to the application through an IWMStatusCallback::OnStatus
///method implemented in the application.
@GUID("96406BD6-2B2B-11D3-B36B-00C04F6108FF")
interface IWMReader : IUnknown
{
    ///The <b>Open</b> method opens an ASF file for reading.
    ///Params:
    ///    pwszURL = Pointer to a wide-character <b>null</b>-terminated string containing the path and name of the file to be
    ///              opened. This method accepts a path to a folder on a local machine, a path to a network share, or a uniform
    ///              resource locator (URL).
    ///    pCallback = Pointer to the object that implements the IWMReaderCallback interface.
    ///    pvContext = Generic pointer, for use by the application. This is passed to the application in calls to <b>OnStatus</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pCallback</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is
    ///    not enough available memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td>
    ///    <td width="60%"> The method failed for an unspecified reason. </td> </tr> </table>
    ///    
    HRESULT Open(const(PWSTR) pwszURL, IWMReaderCallback pCallback, void* pvContext);
    ///The <b>Close</b> method deletes all outputs on the reader and releases the file resources.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> The file is already closed </td> </tr>
    ///    </table>
    ///    
    HRESULT Close();
    ///The <b>GetOutputCount</b> method retrieves the number of uncompressed media streams that will be delivered for
    ///the file loaded in the reader.
    ///Params:
    ///    pcOutputs = Pointer to a count of outputs.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pcOutputs</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method
    ///    failed for an unspecified reason. </td> </tr> </table>
    ///    
    HRESULT GetOutputCount(uint* pcOutputs);
    ///The <b>GetOutputProps</b> method retrieves the current properties of an uncompressed output stream.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the output number.
    ///    ppOutput = Pointer to a pointer to an IWMOutputMediaProps interface. This interface belongs to an output media
    ///               properties object created by a successful call to this method. Any changes made to the output media
    ///               properties object will have no effect on the output of the reader unless you pass this interface in a call to
    ///               IWMReader::SetOutputProps.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>ppOutput</i> parameter is <b>NULL</b>, or
    ///    the <i>dwOutputNum</i> parameter is greater than the number of outputs. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetOutputProps(uint dwOutputNum, IWMOutputMediaProps* ppOutput);
    ///The <b>SetOutputProps</b> method specifies the media properties of an uncompressed output stream.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the output number.
    ///    pOutput = Pointer to an IWMOutputMediaProps interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>dwOutputNum</i> parameter is greater
    ///    than the number of output streams. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl>
    ///    </td> <td width="60%"> The method failed for an unspecified reason. </td> </tr> </table>
    ///    
    HRESULT SetOutputProps(uint dwOutputNum, IWMOutputMediaProps pOutput);
    ///The <b>GetOutputFormatCount</b> method is used for determining all possible format types supported by this output
    ///media stream on the reader.
    ///Params:
    ///    dwOutputNumber = <b>DWORD</b> containing the output number.
    ///    pcFormats = Pointer to a count of formats.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetOutputFormatCount(uint dwOutputNumber, uint* pcFormats);
    ///The <b>GetOutputFormat</b> method retrieves the supported formats for a specified output media stream.
    ///Params:
    ///    dwOutputNumber = <b>DWORD</b> containing the output number.
    ///    dwFormatNumber = <b>DWORD</b> containing the format number.
    ///    ppProps = Pointer to a pointer to an IWMOutputMediaProps interface. This interface belongs to an output media
    ///              properties object created by a successful call to this method. The properties exposed by this interface
    ///              represent formats than can be supported by the specified output; the current properties set for the output
    ///              can be obtained by calling IWMReader::GetOutputProps.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetOutputFormat(uint dwOutputNumber, uint dwFormatNumber, IWMOutputMediaProps* ppProps);
    ///The <b>Start</b> method causes the reader object to start reading from the specified starting time offset. As
    ///data is read, it is passed to the application through the application's IWMReaderCallback::OnSample callback
    ///method.
    ///Params:
    ///    cnsStart = Time within the file at which to start reading, in 100-nanosecond units. If <i>cnsStart</i> is set to
    ///               WM_START_CURRENTPOSITION, playback starts from the current position.
    ///    cnsDuration = Duration of the read in 100-nanosecond units, or zero to read to the end of the file.
    ///    fRate = Playback speed. Normal speed is 1.0. Higher numbers cause faster playback, and numbers less than zero
    ///            indicate reverse rate (rewinding). The valid ranges are 1.0 through 10.0, and -1.0 through -10.0.
    ///    pvContext = Generic pointer, for use by the application. This pointer is passed back to the <b>OnSample</b> method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough available memory. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> The value
    ///    for <i>fRate</i> is not within the valid ranges, or the file is not seekable and a non-zero start position
    ///    has been specified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed for an unspecified reason. </td> </tr> </table>
    ///    
    HRESULT Start(ulong cnsStart, ulong cnsDuration, float fRate, void* pvContext);
    ///The <b>Stop</b> method stops reading the file.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough available memory. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed
    ///    for an unspecified reason. </td> </tr> </table>
    ///    
    HRESULT Stop();
    ///The <b>Pause</b> method pauses the current read operation.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough available memory. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed
    ///    for an unspecified reason. </td> </tr> </table>
    ///    
    HRESULT Pause();
    ///The <b>Resume</b> method starts the reader from the current position, after a <b>Pause</b> method call.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Resume();
}

///The <b>IWMSyncReader</b> interface provides the ability to read ASF files using synchronous calls. This is in
///contrast to many of the methods in <b>IWMReader</b>, which are called asynchronously. You get a pointer to an
///<b>IWMSyncReader</b> interface when you create a new synchronous reader object with a call to WMCreateSyncReader. In
///addition to enabling synchronous reading, the methods of <b>IWMSyncReader</b> are tailored to meet the demands of
///editing applications. Default playback from <b>IWMSyncReader</b> delivers uncompressed samples for the default
///streams of all outputs. However, you can manipulate the selected streams during streaming without having to enable
///manual stream selection. You can also receive compressed or uncompressed samples, though you cannot change between
///them during streaming. Samples are delivered by either output number or stream number, so you can receive
///uncompressed samples from mutually exclusive streams. Many of the methods in this interface are almost identical to
///corresponding methods in the asynchronous reader. Use of this interface, as well as the implementation of an
///<b>IStream</b> COM object that passes data to this object, is demonstrated in the WMSyncReader SDK sample.
@GUID("9397F121-7705-4DC9-B049-98B698188414")
interface IWMSyncReader : IUnknown
{
    ///The <b>Open</b> method opens a file for reading. Unlike IWMReader::Open, this method is a synchronous call.
    ///Params:
    ///    pwszFilename = Pointer to a wide-character null-terminated string containing the file name to open. This must be a valid
    ///                   file name with an ASF file extension or an MP3 file name.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Open(const(PWSTR) pwszFilename);
    ///The <b>Close</b> method removes a file from the synchronous reader.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Close();
    ///The <b>SetRange</b> method enables you to specify a start time and duration for playback by the synchronous
    ///reader.
    ///Params:
    ///    cnsStartTime = Offset into the file at which to start playback. This value is measured in 100-nanosecond units.
    ///    cnsDuration = Duration in 100-nanosecond units, or zero to continue playback to the end of the file.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>cnsDuration</i> parameter is negative.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method
    ///    is unable to allocate memory for an internal object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> No file is loaded in the synchronous reader. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetRange(ulong cnsStartTime, long cnsDuration);
    ///The <b>SetRangeByFrame</b> method configures the synchronous reader to read a portion of the file specified by a
    ///starting video frame number and a number of frames to read.
    ///Params:
    ///    wStreamNum = Stream number.
    ///    qwFrameNumber = Frame number at which to begin playback. The first frame in a file is number 1.
    ///    cFramesToRead = Count of frames to read. Pass 0 to continue playback to the end of the file.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>cFramesToRead</i> contains a negative
    ///    number. </td> </tr> </table>
    ///    
    HRESULT SetRangeByFrame(ushort wStreamNum, ulong qwFrameNumber, long cFramesToRead);
    ///The <b>GetNextSample</b> method retrieves the next sample from the file.
    ///Params:
    ///    wStreamNum = <b>WORD </b>containing the stream number for which you would like a sample. If you pass zero, the next sample
    ///                 in the file is returned, regardless of stream number.
    ///    ppSample = Pointer to a buffer that receives the sample. Set to <b>NULL</b> to retrieve the sample time without getting
    ///               the sample. If set to <b>NULL</b>, <i>pcnsDuration</i> and <i>pdwFlags</i> must both be set to <b>NULL</b> as
    ///               well.
    ///    pcnsSampleTime = Pointer to a <b>QWORD</b> variable that receives the sample time in 100-nanosecond units.
    ///    pcnsDuration = Pointer to <b>QWORD</b> variable that receives the duration of the sample in 100-nanosecond units.
    ///    pdwFlags = Pointer to a <b>DWORD</b> containing one or more of the following flags. <table> <tr> <th>Flag </th>
    ///               <th>Description </th> </tr> <tr> <td>No flag set</td> <td>None of the conditions for the other flags applies.
    ///               For example, a delta frame in most cases would not have any flags set for it.</td> </tr> <tr>
    ///               <td>WM_SF_CLEANPOINT</td> <td>Indicates that the sample does not require any other samples to be
    ///               decompressed. All audio samples and all video samples that are key frames are cleanpoints.</td> </tr> <tr>
    ///               <td>WM_SF_DISCONTINUITY</td> <td>The data stream has a gap in it, which could be due to a seek, a network
    ///               loss, or other reason. This can be useful extra information for an application such as a codec or renderer.
    ///               The flag is set on the first piece of data following the gap.</td> </tr> <tr> <td>WM_SF_DATALOSS</td>
    ///               <td>Some data has been lost between the previous sample and the sample with this flag set.</td> </tr>
    ///               </table>
    ///    pdwOutputNum = Pointer to a <b>DWORD</b> that receives the output number.
    ///    pwStreamNum = Pointer to a <b>WORD</b> that receives the stream number.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_NO_MORE_SAMPLES</b></dt> </dl> </td> <td width="60%"> All the samples in the file have been
    ///    read. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> A
    ///    problem occurred with a call within the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>wStreamNum</i> specifies a stream number that is
    ///    not valid. OR <i>pcnsSampleTime</i> is <b>NULL</b> OR <i>ppSample</i>, <i>pcnsDuration</i>, or
    ///    <i>pdwFlags</i> is <b>NULL</b>, but one or both of the others are not. OR <i>wStreamNum</i> is 0 and both
    ///    <i>pdwOutputNum</i> and <i>pwStreamNum</i> are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> No file is open and ready for reading by
    ///    the synchronous reader. OR <i>wStreamNum</i> specifies a stream number that is turned off (not selected for
    ///    reading). </td> </tr> </table>
    ///    
    HRESULT GetNextSample(ushort wStreamNum, INSSBuffer* ppSample, ulong* pcnsSampleTime, ulong* pcnsDuration, 
                          uint* pdwFlags, uint* pdwOutputNum, ushort* pwStreamNum);
    ///The <b>SetStreamsSelected</b> method configures the samples to be delivered from a list of streams. Each stream
    ///can be set to deliver all samples, no samples, or only cleanpoint samples.
    ///Params:
    ///    cStreamCount = Count of streams listed at <i>pwStreamNumbers</i>.
    ///    pwStreamNumbers = Pointer to an array of <b>WORD</b> values containing the stream numbers.
    ///    pSelections = Pointer to an array of WMT_STREAM_SELECTION enumeration values. These values correspond with the stream
    ///                  numbers listed at <i>pwStreamNumbers</i>. Each value specifies the samples to deliver for the appropriate
    ///                  stream.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pwStreamNumbers</i> or <i>pSelections</i>
    ///    is <b>NULL</b>. OR <i>cStreamCount</i> is zero. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> No file is loaded in the synchronous
    ///    reader. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The
    ///    method is unable to allocate memory for an internal object. </td> </tr> </table>
    ///    
    HRESULT SetStreamsSelected(ushort cStreamCount, ushort* pwStreamNumbers, WMT_STREAM_SELECTION* pSelections);
    ///The <b>GetStreamSelected</b> method retrieves a flag indicating whether a particular stream is currently
    ///selected.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number.
    ///    pSelection = Pointer to a variable that receives one member of the WMT_STREAM_SELECTION enumeration type on output. This
    ///                 value specifies the selection status for the specified stream.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>pSelection</i> parameter is <b>NULL</b>, or the stream number is invalid. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> No file is open in the
    ///    synchronous reader. </td> </tr> </table>
    ///    
    HRESULT GetStreamSelected(ushort wStreamNum, WMT_STREAM_SELECTION* pSelection);
    ///The <b>SetReadStreamSamples</b> method specifies whether samples from a stream will be delivered compressed or
    ///uncompressed.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number.
    ///    fCompressed = Boolean value that is True if samples will be compressed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> No file is open in the synchronous reader.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_PROTECTED_CONTENT</b></dt> </dl> </td> <td width="60%">
    ///    The stream is protected and not configured to deliver compressed samples. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>wStreamNum</i> specifies an invalid stream
    ///    number. </td> </tr> </table>
    ///    
    HRESULT SetReadStreamSamples(ushort wStreamNum, BOOL fCompressed);
    ///The <b>GetReadStreamSamples</b> method ascertains whether a stream is configured to deliver compressed samples.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number.
    ///    pfCompressed = Pointer to a flag that receives the status of compressed delivery for the stream specified.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pfCompressed</i> is <b>NULL</b>. OR
    ///    <i>wStreamNum</i> specifies an invalid stream number. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> No file is open in the synchronous reader. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetReadStreamSamples(ushort wStreamNum, BOOL* pfCompressed);
    ///The <b>GetOutputSetting</b> method retrieves a setting for a particular output by name.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the output number.
    ///    pszName = Pointer to a wide-character <b>null</b>-terminated string containing the name of the setting for which you
    ///              want the value. For a list of global constants representing setting names, see Output Settings.
    ///    pType = Pointer to a variable that receives one value from the WMT_ATTR_DATATYPE enumeration type. The value received
    ///            specifies the type of data in <i>pValue</i>.
    ///    pValue = Pointer to a byte buffer containing the value. Pass <b>NULL</b> to retrieve the length of the buffer
    ///             required.
    ///    pcbLength = On input, pointer to a variable containing the length of <i>pValue</i>. On output, the variable contains the
    ///                number of bytes in <i>pValue</i> used.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>dwOutputNum</i> specifies an invalid output
    ///    number. OR <i>pszName</i> or <i>pType</i> or <i>pcbLength</i> is <b>NULL</b>. OR <i>pszName</i> specifies an
    ///    invalid setting name. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td
    ///    width="60%"> No file is open in the synchronous reader. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The buffer size passed as <i>pcbLength</i>
    ///    is not large enough to contain the setting value. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> <i>pszName</i> specifies an unsupported
    ///    setting. </td> </tr> </table>
    ///    
    HRESULT GetOutputSetting(uint dwOutputNum, const(PWSTR) pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, 
                             ushort* pcbLength);
    ///The <b>SetOutputSetting</b> method specifies a named setting for a particular output.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the output number.
    ///    pszName = Pointer to a <b>null</b>-terminated string containing the name of the setting. For a list of global constants
    ///              representing setting names, see Output Settings.
    ///    Type = Member of the WMT_ATTR_DATATYPE enumeration type. This value specifies the type of data in the buffer at
    ///           <i>pValue</i>.
    ///    pValue = Pointer to a byte array containing the value of the setting. The type of data stored in this buffer is
    ///             specified by <i>Type</i>.
    ///    cbLength = Size of <i>pValue</i> in bytes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pszName</i> or <i>pValue</i> is
    ///    <b>NULL</b>. OR <i>dwOutputNum</i> specifies an invalid output number. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> No file is open in the synchronous reader. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%">
    ///    <i>pszName</i> specifies an unsupported setting. </td> </tr> </table>
    ///    
    HRESULT SetOutputSetting(uint dwOutputNum, const(PWSTR) pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, 
                             ushort cbLength);
    ///The <b>GetOutputCount</b> method retrieves the number of outputs that exist for the file open in the synchronous
    ///reader.
    ///Params:
    ///    pcOutputs = Pointer to a <b>DWORD</b> that receives the number of outputs in the file.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pcOutputs</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method
    ///    failed for an unspecified reason. </td> </tr> </table>
    ///    
    HRESULT GetOutputCount(uint* pcOutputs);
    ///The <b>GetOutputProps</b> method retrieves the current properties of an uncompressed output stream.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the output number.
    ///    ppOutput = Pointer to a pointer to an IWMOutputMediaProps interface, which is created by a successful call to this
    ///               method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>ppOutput</i> parameter is <b>NULL</b>, or
    ///    the <i>dwOutputNum</i> parameter is greater than or equal to the number of outputs. Output numbers begin with
    ///    zero. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed for an unspecified reason. </td> </tr> </table>
    ///    
    HRESULT GetOutputProps(uint dwOutputNum, IWMOutputMediaProps* ppOutput);
    ///The <b>SetOutputProps</b> method specifies the media properties of an uncompressed output stream.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the output number.
    ///    pOutput = Pointer to an IWMOutputMediaProps interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>dwOutputNum</i> parameter is greater
    ///    than or equal to the number of outputs. Output numbers begin with zero. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetOutputProps(uint dwOutputNum, IWMOutputMediaProps pOutput);
    ///The <b>GetOutputFormatCount</b> method is used to determine all possible format types supported by this output on
    ///the synchronous reader.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the output number for which you want to determine the number of supported formats.
    ///    pcFormats = Pointer to a <b>DWORD</b> that receives the number of supported formats.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pcFormats</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> There is no file loaded in
    ///    the synchronous reader. </td> </tr> </table>
    ///    
    HRESULT GetOutputFormatCount(uint dwOutputNum, uint* pcFormats);
    ///The <b>GetOutputFormat</b> method retrieves the supported formats for a specified output media stream.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the output number.
    ///    dwFormatNum = <b>DWORD</b> containing the format number.
    ///    ppProps = Pointer to a pointer to an IWMOutputMediaProps interface. This object is created by a successful call to this
    ///              method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>ppProps</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> No file is open in the
    ///    synchronous reader. </td> </tr> </table>
    ///    
    HRESULT GetOutputFormat(uint dwOutputNum, uint dwFormatNum, IWMOutputMediaProps* ppProps);
    ///The <b>GetOutputNumberForStream</b> method retrieves the output number that corresponds with the specified
    ///stream.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number for which you want to retrieve the corresponding output number.
    ///    pdwOutputNum = Pointer to a <b>DWORD</b> that will receive the output number that corresponds to the stream number specified
    ///                   in <i>wStreamNum</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> <i>wStreamNum</i> specifies an invalid
    ///    stream number. </td> </tr> </table>
    ///    
    HRESULT GetOutputNumberForStream(ushort wStreamNum, uint* pdwOutputNum);
    ///The <b>GetStreamNumberForOutput</b> method retrieves the stream number that corresponds with the specified
    ///output.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> value specifying the output number for which you want to retrieve a stream number.
    ///    pwStreamNum = Pointer to a <b>WORD</b> value that receives the stream number that corresponds to the output specified by
    ///                  <i>dwOutput</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> <i>dwOutput</i> specifies an invalid
    ///    output number. </td> </tr> </table>
    ///    
    HRESULT GetStreamNumberForOutput(uint dwOutputNum, ushort* pwStreamNum);
    ///The <b>GetMaxOutputSampleSize</b> method retrieves the maximum sample size for a specified output of the file
    ///open in the synchronous reader.
    ///Params:
    ///    dwOutput = <b>DWORD</b> containing the output number for which you want to retrieve the maximum sample size.
    ///    pcbMax = Pointer to a <b>DWORD</b> value that receives the maximum sample size, in bytes, for the output specified in
    ///             <i>dwOutput</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pcbMax</i> is <b>NULL</b>. OR
    ///    <i>dwOutput</i> specifies an invalid output number. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ASF_E_INVALIDSTATE</b></dt> </dl> </td> <td width="60%"> No file is opened in the synchronous reader.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_NOT_CONFIGURED</b></dt> </dl> </td> <td width="60%"> The
    ///    specified output is not currently configured for playback. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The synchronous reader failed to initialize an
    ///    internal object. </td> </tr> </table>
    ///    
    HRESULT GetMaxOutputSampleSize(uint dwOutput, uint* pcbMax);
    ///The <b>GetMaxStreamSampleSize</b> method retrieves the maximum sample size for a specified stream in the file
    ///that is open in the synchronous reader.
    ///Params:
    ///    wStream = <b>WORD</b> containing the stream number for which you want to retrieve the maximum sample size.
    ///    pcbMax = Pointer to a <b>DWORD</b> value that receives the maximum sample size, in bytes, for the stream specified in
    ///             <i>wStream</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pcbMax</i> is <b>NULL</b>. OR
    ///    <i>wStream</i> specifies an invalid stream number. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ASF_E_INVALIDSTATE</b></dt> </dl> </td> <td width="60%"> No file is open in the synchronous reader.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetMaxStreamSampleSize(ushort wStream, uint* pcbMax);
    ///The <b>OpenStream</b> method opens a stream for reading.
    ///Params:
    ///    pStream = Pointer to an <b>IStream</b> interface.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT OpenStream(IStream pStream);
}

///The <b>IWMSyncReader2</b> interface provides advanced features for the synchronous reader. It contains methods for
///allocating samples manually and for seeking to SMPTE time codes. An <b>IWMSyncReader2</b> interface exists for every
///synchronous reader object. You can obtain a pointer to an instance of this interface by calling the
///<b>QueryInterface</b> method of any other interface of the synchronous reader object.
@GUID("FAED3D21-1B6B-4AF7-8CB6-3E189BBC187B")
interface IWMSyncReader2 : IWMSyncReader
{
    ///The <b>SetRangeByTimecode</b> method sets a starting and ending time, based on SMPTE time codes, for playback of
    ///a file.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number.
    ///    pStart = Pointer to a WMT_TIMECODE_EXTENSION_DATA structure containing the starting time code.
    ///    pEnd = Pointer to a <b>WMT_TIMECODE_EXTENSION_DATA</b> structure containing the ending time code.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetRangeByTimecode(ushort wStreamNum, WMT_TIMECODE_EXTENSION_DATA* pStart, 
                               WMT_TIMECODE_EXTENSION_DATA* pEnd);
    ///The <b>SetRangeByFrameEx</b> method configures the synchronous reader to read a portion of the file specified by
    ///a starting video frame number and a number of frames to read. This method also retrieves the presentation time of
    ///the requested frame number.
    ///Params:
    ///    wStreamNum = Stream number.
    ///    qwFrameNumber = Frame number at which to begin playback. The first frame in a file is number 1.
    ///    cFramesToRead = Count of frames to read. Pass 0 to continue playback to the end of the file.
    ///    pcnsStartTime = Start time in 100-nanosecond units.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetRangeByFrameEx(ushort wStreamNum, ulong qwFrameNumber, long cFramesToRead, ulong* pcnsStartTime);
    ///The <b>SetAllocateForOutput</b> method sets a sample allocation callback interface for allocating output samples.
    ///This method enables you to use your own buffers for reading samples. Once set, the synchronous reader will call
    ///the IWMReaderAllocatorEx::AllocateForOutputEx method every time it needs a buffer to hold an output sample.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the output number.
    ///    pAllocator = Pointer to an IWMReaderAllocatorEx interface implemented in your application.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAllocateForOutput(uint dwOutputNum, IWMReaderAllocatorEx pAllocator);
    ///The <b>GetAllocateForOutput</b> method retrieves an interface for allocating output samples.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the output number.
    ///    ppAllocator = Pointer to a pointer to an IWMReaderAllocatorEx interface.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAllocateForOutput(uint dwOutputNum, IWMReaderAllocatorEx* ppAllocator);
    ///The <b>SetAllocateForStream</b> method sets a sample allocation callback interface for allocating stream samples.
    ///This method enables you to use your own buffers for reading samples. Once set, the synchronous reader will call
    ///the IWMReaderAllocatorEx::AllocateForStreamEx method every time it needs a buffer to hold a stream sample.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number.
    ///    pAllocator = Pointer to an IWMReaderAllocatorEx interface implemented in your application.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAllocateForStream(ushort wStreamNum, IWMReaderAllocatorEx pAllocator);
    ///The <b>GetAllocateForStream</b> method retrieves an interface for allocating stream samples.
    ///Params:
    ///    dwSreamNum = <b>DWORD</b> containing the stream number.
    ///    ppAllocator = Pointer to a pointer to an IWMReaderAllocatorEx interface.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAllocateForStream(ushort dwSreamNum, IWMReaderAllocatorEx* ppAllocator);
}

///The <b>IWMOutputMediaProps</b> interface is used to retrieve the properties of an output stream. An
///<b>IWMOutputMediaProps</b> object is created by a call to IWMReader::GetOutputFormat or IWMReader::GetOutputProps.
@GUID("96406BD7-2B2B-11D3-B36B-00C04F6108FF")
interface IWMOutputMediaProps : IWMMediaProps
{
    ///The <b>GetStreamGroupName</b> method is not implemented in this release, and returns the empty string.
    ///Params:
    ///    pwszName = Pointer to a wide-character <b>null</b>-terminated string containing the name. Pass <b>NULL</b> to retrieve
    ///               the length of the name.
    ///    pcchName = On input, a pointer to a variable containing the length of the <i>pwszName</i> array in wide characters (2
    ///               bytes). On output, and if the method succeeds, the variable contains the length of the name, including the
    ///               terminating <b>null</b> character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pcchName</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The
    ///    buffer pointed to by the <i>pwszName</i> parameter is not large enough. </td> </tr> </table>
    ///    
    HRESULT GetStreamGroupName(PWSTR pwszName, ushort* pcchName);
    ///The <b>GetConnectionName</b> method retrieves the name of the connection to be used for output.
    ///Params:
    ///    pwszName = Pointer to a wide-character <b>null</b>-terminated string containing the name. Pass <b>NULL</b> to retrieve
    ///               the length of the name.
    ///    pcchName = On input, a pointer to a variable containing the length of the <i>pwszName</i> array in wide characters. On
    ///               output, if the method succeeds, it specifies a pointer to the length of the connection name, including the
    ///               terminating <b>null</b> character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pwszName</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The
    ///    buffer pointed to by <i>pcchName</i> is not large enough for the requested name. </td> </tr> </table>
    ///    
    HRESULT GetConnectionName(PWSTR pwszName, ushort* pcchName);
}

///The <b>IWMStatusCallback</b> interface is implemented by the application to receive status information from various
///objects.
@GUID("6D7CDC70-9888-11D3-8EDC-00C04F6109CF")
interface IWMStatusCallback : IUnknown
{
    ///The <b>OnStatus</b> method is called when status information must be communicated to the application.
    ///Params:
    ///    Status = One member of the WMT_STATUS enumeration type. For a description of possible <b>WMT_STATUS</b> values, see
    ///             the tables in the Remarks section.
    ///    hr = <b>HRESULT</b> error code. If this indicates failure, you should not process the status as normal, as some
    ///         error has occurred. Use <code>if (FAILED(hr))</code> to check for a failed value. See the topic Error Codes
    ///         for a list of possible results.
    ///    dwType = Member of the WMT_ATTR_DATATYPE enumeration type. This value specifies the type of data in the buffer at
    ///             <i>pValue</i>.
    ///    pValue = Pointer to a byte array containing the value. The contents of this array depend on the value of <i>Status</i>
    ///             and the value of <i>dwType</i>.
    ///    pvContext = Generic pointer provided by the application, for its own use. This pointer matches the context pointer given
    ///                to the IWMReader::Open, IWMIndexer::StartIndexing, and other methods. The SDK makes no assumptions about the
    ///                use of this pointer; it is simply provided by the application and passed back to the application when a
    ///                callback is made.
    ///Returns:
    ///    This method is implemented by the application. It should always return S_OK.
    ///    
    HRESULT OnStatus(WMT_STATUS Status, HRESULT hr, WMT_ATTR_DATATYPE dwType, ubyte* pValue, void* pvContext);
}

///The <b>IWMReaderCallback</b> is implemented by the application to handle data being read from a file. A pointer to
///the interface is passed to IWMReader::Open.
@GUID("96406BD8-2B2B-11D3-B36B-00C04F6108FF")
interface IWMReaderCallback : IWMStatusCallback
{
    ///The <b>OnSample</b> method is called during the reading of a file (due to a Start call) indicating that new data
    ///is available.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the number of the output to which the sample belongs.
    ///    cnsSampleTime = <b>QWORD</b> containing the sample time, in 100-nanosecond units.
    ///    cnsSampleDuration = <b>QWORD</b> containing the sample duration, in 100-nanosecond units. For video streams, if the
    ///                        SampleDuration data unit extension was set on this sample when the file was created, then this parameter will
    ///                        contain that value. For more information on SampleDuration , see INSSBuffer3::GetProperty.
    ///    dwFlags = The flags that can be specified in <i>dwFlags</i> have the following uses. <table> <tr> <th>Flag </th>
    ///              <th>Description </th> </tr> <tr> <td>No flag set</td> <td>None of the conditions for the other flags applies.
    ///              For example, a delta frame in most cases would not have any flags set for it.</td> </tr> <tr>
    ///              <td>WM_SF_CLEANPOINT</td> <td>This is the same as a key frame. It indicates a good point to go to during a
    ///              seek, for example.</td> </tr> <tr> <td>WM_SF_DISCONTINUITY</td> <td>The data stream has a gap in it, which
    ///              could be due to a seek, a network loss, or other reason. This can be useful extra information for an
    ///              application such as a codec or renderer. The flag is set on the first piece of data following the gap.</td>
    ///              </tr> <tr> <td>WM_SF_DATALOSS</td> <td>Some data has been lost between the previous sample and the sample
    ///              with this flag set.</td> </tr> </table>
    ///    pSample = Pointer to the INSSBuffer interface of an object containing the sample. The reader calls <b>SAFE_RELEASE</b>
    ///              on this pointer after your <b>OnSample</b> method returns. You can call <b>AddRef</b> on this pointer if you
    ///              need to keep a reference count on the buffer. Do not call <b>Release</b> on this pointer unless you have
    ///              called <b>AddRef</b>.
    ///    pvContext = Generic pointer, for use by the application. This pointer is the context pointer given to the
    ///                IWMReader::Start method.
    ///Returns:
    ///    To use this method, you must implement it in your application. The method should always return S_OK.
    ///    
    HRESULT OnSample(uint dwOutputNum, ulong cnsSampleTime, ulong cnsSampleDuration, uint dwFlags, 
                     INSSBuffer pSample, void* pvContext);
}

///The <b>IWMCredentialCallback</b> interface is a callback interface used by the reader object to acquire user
///credentials. When the reader object receives an authentication challenge from the server, it calls the application's
///<b>AcquireCredentials</b> method to get the credentials of the user, in order to access the remote site. This
///interface is implemented by the application.
@GUID("342E0EB7-E651-450C-975B-2ACE2C90C48E")
interface IWMCredentialCallback : IUnknown
{
    ///The <b>AcquireCredentials</b> method acquires the credentials of the user, to verify that the user has permission
    ///to access a remote site.
    ///Params:
    ///    pwszRealm = Pointer to a wide-character null-terminated string that contains the name of the realm.
    ///    pwszSite = Pointer to a wide-character null-terminated string containing the name of the site. The site is the name of
    ///               the remote server.
    ///    pwszUser = Pointer to a buffer for the user name. The application should copy the user name into this buffer. When this
    ///               method is first called, the buffer is empty. If the method is called again — for example, if the user typed
    ///               his or her credentials incorrectly — the buffer may contain the name from the previous invocation.
    ///    cchUser = Specifies the size of the <i>pwszUser</i> buffer, in number of wide characters.
    ///    pwszPassword = Pointer to a buffer for the password. The application should copy the user's password into this buffer.
    ///    cchPassword = Specifies the size of the <i>pwszPassword</i> buffer, in number of wide characters.
    ///    hrStatus = Specifies an <b>HRESULT</b> return code.
    ///    pdwFlags = Pointer to a <b>DWORD</b> containing a bitwise <b>OR</b> of zero or more flags from the WMT_CREDENTIAL_FLAGS
    ///               enumeration type. On input, the caller sets whichever flags are relevant. On output, the application should
    ///               clear the flags that were set by the caller, and set any additional flags, as appropriate. For details, see
    ///               <b>WMT_CREDENTIAL_FLAGS</b>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT AcquireCredentials(PWSTR pwszRealm, PWSTR pwszSite, PWSTR pwszUser, uint cchUser, PWSTR pwszPassword, 
                               uint cchPassword, HRESULT hrStatus, uint* pdwFlags);
}

///The <b>IWMMetadataEditor</b> interface is used to edit metadata information in ASF file headers. It is obtained by
///calling the WMCreateEditor function.
@GUID("96406BD9-2B2B-11D3-B36B-00C04F6108FF")
interface IWMMetadataEditor : IUnknown
{
    ///The <b>Open</b> method opens an ASF file.
    ///Params:
    ///    pwszFilename = Pointer to a wide-character <b>null</b>-terminated string containing the file name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_FILE_OPEN_FAILED</b></dt> </dl> </td> <td width="60%"> The method failed to open the
    ///    specified file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    The <i>pwszFilename</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough available memory. </td> </tr>
    ///    </table>
    ///    
    HRESULT Open(const(PWSTR) pwszFilename);
    ///The <b>Close</b> method closes the open file without saving any changes.
    ///Returns:
    ///    This method always returns S_OK.
    ///    
    HRESULT Close();
    ///The <b>Flush</b> method closes the open file, saving any changes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>ASF_E_INVALIDSTATE</b></dt> </dl> </td> <td width="60%"> No file has been opened. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>NS_E_FILE_WRITE</b></dt> </dl> </td> <td width="60%"> Read-only file. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> There is not
    ///    enough available memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> There is not enough available memory. </td> </tr> </table>
    ///    
    HRESULT Flush();
}

///The <b>IWMMetadataEditor2</b> interface provides an improved method for opening files for metadata operations. This
///interface is implemented as part of the metadata editor object. To obtain a pointer to <b>IWMMetadataEditor2</b>,
///call the <b>QueryInterface</b> method of any other interface in an existing metadata editor object.
@GUID("203CFFE3-2E18-4FDF-B59D-6E71530534CF")
interface IWMMetadataEditor2 : IWMMetadataEditor
{
    ///The <b>OpenEx</b> method opens a file for use by the metadata editor object. <b>OpenEx</b> opens ASF files and
    ///MP3 files, though the metadata editor has limited capabilities when working with MP3 files.
    ///Params:
    ///    pwszFilename = Pointer to a wide-character null-terminated string containing the file name.
    ///    dwDesiredAccess = <b>DWORD</b> containing the desired access type. This can be set to GENERIC_READ or GENERIC_WRITE. For
    ///                      read/write access, pass both values combined with a bitwise <b>OR</b>. When using GENERIC_READ, you must also
    ///                      pass a valid sharing mode as <i>dwShareMode</i>. Failure to do so will result in an error.
    ///    dwShareMode = <b>DWORD</b> containing the sharing mode. This can be one of the values in the following table or a
    ///                  combination of the two using a bitwise <b>OR</b>. A value of zero indicates no sharing. Sharing is not
    ///                  supported when requesting read/write access. If you request read/write access and pass any value other than
    ///                  zero for the share mode, an error is returned. <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr>
    ///                  <td>FILE_SHARE_READ</td> <td>Subsequent open operations on the file will succeed only if read access is
    ///                  requested.</td> </tr> <tr> <td>FILE_SHARE_DELETE</td> <td>(NTFS only) Subsequent open operations on the file
    ///                  will succeed only if it is being deleted.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Read/write access has been requested using
    ///    file sharing. OR Read access has been requested without indicating read-and-delete file sharing. OR The
    ///    access mode requested is not available with this method. </td> </tr> </table>
    ///    
    HRESULT OpenEx(const(PWSTR) pwszFilename, uint dwDesiredAccess, uint dwShareMode);
}

///<p class="CCE_Message">[<b>IWMDRMEditor</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady. ]
///The <b>IWMDRMEditor</b> interface is exposed on the metadata editor object. It can be obtained by calling
///<b>QueryInterface</b> from IWMMetadataEditor. The <b>IWMDRMEditor</b> interface enables applications to examine the
///DRM attributes of an ASF file, for example to query the number of times a file is allowed to be played, without
///having the wmstubdrm.lib static library. The IWMDRMReader interface contains a similar method, but the application
///must be linked to a valid wmstubdrm.lib library in order to use that interface.
@GUID("FF130EBC-A6C3-42A6-B401-C3382C3E08B3")
interface IWMDRMEditor : IUnknown
{
    ///<p class="CCE_Message">[<b>GetDRMProperty</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>GetDRMProperty</b> method retrieves the specified DRM property.
    ///Params:
    ///    pwstrName = Specifies the DRM file attribute to retrieve.
    ///    pdwType = Pointer that receives the data type of the returned value.
    ///    pValue = Pointer to the value requested in <i>pwstrName</i>.
    ///    pcbLength = Length of <i>pValue</i> in bytes.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetDRMProperty(const(PWSTR) pwstrName, WMT_ATTR_DATATYPE* pdwType, ubyte* pValue, ushort* pcbLength);
}

///The <b>IWMHeaderInfo</b> interface sets and retrieves information in the header section of an ASF file. You can
///manipulate three types of header information by using the methods of this interface: metadata attributes, markers,
///and script commands. Metadata attributes are name/value pairs that describe or relate to the contents of the file.
///Typical metadata attributes contain information about the artist, title, and performance details of the content. The
///Windows Media Format SDK includes a large selection of predefined metadata attributes that you can use in your files.
///See Attributes for a complete listing of predefined attributes. Additionally, you can create your own attributes. The
///methods of <b>IWMHeaderInfo</b> that deal with metadata are somewhat limited. They cannot be used to create or access
///attributes containing more than 64 kilobytes of data. They are also limited to simple data types. Much more robust
///metadata support is provided through the IWMHeaderInfo3 interface, which should be used for all new files. Markers
///enable you to name specific locations in the file for easy access. Typically, markers are used to create a table of
///contents for a file, such as a list of scenes in a video file. Script commands are name/value pairs containing
///information that your reading application will respond to programmatically. There are no script commands that are
///directly supported by the reader or the synchronous reader, but there are a few standard script commands supported by
///Windows Media Player. For more information about script commands, see the Using Script Commands section of this
///documentation. The <b>IWMHeaderInfo</b> interface is implemented by the metadata editor object, the writer object,
///the reader object, and the synchronous reader object. To obtain a pointer to an instance, call the
///<b>QueryInterface</b> method of any other interface in the desired object.
@GUID("96406BDA-2B2B-11D3-B36B-00C04F6108FF")
interface IWMHeaderInfo : IUnknown
{
    ///The <b>GetAttributeCount</b> method returns the number of attributes defined in the header section of the ASF
    ///file. This method is replaced by IWMHeaderInfo3::GetAttributeCountEx and IWMHeaderInfo3::GetAttributeIndices, and
    ///should no longer be used.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number. Pass zero for file-level attributes.
    ///    pcAttributes = Pointer to a count of the attributes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> The object is not in a configurable
    ///    state, or no profile has been set. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> <i>wStreamNum</i> is not a valid stream number, or <i>pcAttributes</i> is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    <i>pcAttributes</i> is not a valid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetAttributeCount(ushort wStreamNum, ushort* pcAttributes);
    ///The <b>GetAttributeByIndex</b> method returns a descriptive attribute that is stored in the header section of the
    ///ASF file. This method is replaced by IWMHeaderInfo3::GetAttributeByIndexEx and should not be used.
    ///Params:
    ///    wIndex = <b>WORD</b> containing the index.
    ///    pwStreamNum = Pointer to a <b>WORD</b> containing the stream number. Although this parameter is a pointer, the method will
    ///                  not change the value. For file-level attributes, use zero for the stream number.
    ///    pwszName = Pointer to a wide-character <b>null</b>-terminated string containing the name. Pass <b>NULL</b> to this
    ///               parameter to retrieve the required length for the name. Attribute names are limited to 1024 wide characters.
    ///    pcchNameLen = On input, a pointer to a variable containing the length of the <i>pwszName</i> array in wide characters (2
    ///                  bytes). On output, if the method succeeds, the variable contains the actual length of the name, including the
    ///                  terminating <b>null</b> character.
    ///    pType = Pointer to a variable containing one value from the <b>WMT_ATTR_DATATYPE</b> enumeration type.
    ///    pValue = Pointer to a byte array containing the value. Pass <b>NULL</b> to this parameter to retrieve the required
    ///             length for the value.
    ///    pcbLength = On input, a pointer to a variable containing the length of the <i>pValue</i> array, in bytes. On output, if
    ///                the method succeeds, the variable contains the actual number of bytes written to <i>pValue</i> by the method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The object is not in a valid state, or
    ///    no profile has been set. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>pwStreamNum</i> does not point to a valid stream number, or no data type was supplied. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A pointer supplied in
    ///    a parameter was not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td>
    ///    <td width="60%"> The method failed for an unspecified reason. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The <i>pValue</i> array is too small to
    ///    contain the attribute value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ASF_E_NOTFOUND</b></dt> </dl>
    ///    </td> <td width="60%"> There is no attribute at <i>wIndex</i>. </td> </tr> </table>
    ///    
    HRESULT GetAttributeByIndex(ushort wIndex, ushort* pwStreamNum, PWSTR pwszName, ushort* pcchNameLen, 
                                WMT_ATTR_DATATYPE* pType, ubyte* pValue, ushort* pcbLength);
    ///The <b>GetAttributeByName</b> method returns a descriptive attribute that is stored in the header section of the
    ///ASF file. Now that attribute names can be duplicated in a file, this method is obsolete. To find attributes of a
    ///particular name, use IWMHeaderInfo3::GetAttributeIndices.
    ///Params:
    ///    pwStreamNum = Pointer to a <b>WORD</b> containing the stream number, or zero to indicate any stream. Although this
    ///                  parameter is a pointer, the method does not change the value.
    ///    pszName = Pointer to a <b>null</b>-terminated string containing the name of the attribute. Attribute names are limited
    ///              to 1024 wide characters.
    ///    pType = Pointer to a variable that receives a value from the WMT_ATTR_DATATYPE enumeration type. The returned value
    ///            specifies the data type of the attribute.
    ///    pValue = Pointer to a byte array that receives the value of the attribute. The caller must allocate the array. To
    ///             determine the required array size, set this parameter to <b>NULL</b> and check the value returned in the
    ///             <i>pcbLength</i> parameter.
    ///    pcbLength = On input, the length of the <i>pValue</i> array, in bytes. On output, if the method succeeds, the actual
    ///                number of bytes that were written to <i>pValue</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>ASF_E_NOTFOUND</b></dt> </dl> </td> <td width="60%"> The specified attribute is not defined in
    ///    this file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>pwStreamNum</i> is not a valid stream number, <i>pszName</i> does not point to a wide-character string, or
    ///    another parameter does not contain a valid value. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter is not a valid pointer. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an
    ///    unspecified reason. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_STATE</b></dt> </dl> </td> <td
    ///    width="60%"> The object is not in a configurable state, or no profile has been set. </td> </tr> </table>
    ///    
    HRESULT GetAttributeByName(ushort* pwStreamNum, const(PWSTR) pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, 
                               ushort* pcbLength);
    ///The <b>SetAttribute</b> method sets a descriptive attribute that is stored in the header section of the ASF file.
    ///This method is replaced by IWMHeaderInfo3::AddAttribute, and should not be used.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number. To set a file-level attribute, pass zero.
    ///    pszName = Pointer to a wide-character null-terminated string containing the name of the attribute. Attribute names are
    ///              limited to 1024 wide characters.
    ///    Type = A value from the <b>WMT_ATTR_DATATYPE</b> enumeration type.
    ///    pValue = Pointer to a byte array containing the value of the attribute.
    ///    cbLength = The size of <i>pValue</i>, in bytes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A parameter does not contain a valid value.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> Not
    ///    implemented. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%">
    ///    The method failed for an unspecified reason. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The object is not in a configurable state, or
    ///    no profile has been set. </td> </tr> </table>
    ///    
    HRESULT SetAttribute(ushort wStreamNum, const(PWSTR) pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, 
                         ushort cbLength);
    ///The <b>GetMarkerCount</b> method returns the number of markers currently in the header section of the ASF file.
    ///Params:
    ///    pcMarkers = Pointer to a count of markers.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The object is not in a configurable
    ///    state. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The
    ///    method failed for an unspecified reason. </td> </tr> </table>
    ///    
    HRESULT GetMarkerCount(ushort* pcMarkers);
    ///The <b>GetMarker</b> method returns the name and time of a marker.
    ///Params:
    ///    wIndex = <b>WORD</b> containing the index.
    ///    pwszMarkerName = Pointer to a wide-character <b>null</b>-terminated string containing the marker name.
    ///    pcchMarkerNameLen = On input, a pointer to a variable containing the length of the <i>pwszMarkerName</i> array in wide characters
    ///                        (2 bytes). On output, if the method succeeds, the variable contains the actual length of the name, including
    ///                        the terminating <b>null</b> character. To retrieve the length of the name, you must set this to zero and set
    ///                        <i>pwszMarkerName</i> and <i>pcnsMarkerTime</i> to <b>NULL</b>.
    ///    pcnsMarkerTime = Pointer to a variable specifying the marker time in 100-nanosecond increments.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The size specified by
    ///    <i>pcchMarkerNameLen</i> is too small to receive the name. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The object is not in a configurable state.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>pcchMarkerNameLen</i> is <b>NULL</b>, or another parameter does not contain a valid value. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an
    ///    unspecified reason. </td> </tr> </table>
    ///    
    HRESULT GetMarker(ushort wIndex, PWSTR pwszMarkerName, ushort* pcchMarkerNameLen, ulong* pcnsMarkerTime);
    ///The <b>AddMarker</b> method adds a marker, consisting of a name and a specific time, to the header section of the
    ///ASF file.
    ///Params:
    ///    pwszMarkerName = Pointer to a wide-character null-terminated string containing the marker name. Marker names are limited to
    ///                     5120 wide characters.
    ///    cnsMarkerTime = The marker time in 100-nanosecond increments.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The object cannot currently be
    ///    configured. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    <i>pwszMarkerName</i> is not a valid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason. </td>
    ///    </tr> </table>
    ///    
    HRESULT AddMarker(PWSTR pwszMarkerName, ulong cnsMarkerTime);
    ///The <b>RemoveMarker</b> method removes a marker from the header section of the ASF file.
    ///Params:
    ///    wIndex = <b>WORD</b> containing the index of the marker.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>ASF_E_NOTFOUND</b></dt> </dl> </td> <td width="60%"> There is no marker at <i>wIndex</i>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The object
    ///    is not in a configurable state. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl>
    ///    </td> <td width="60%"> The method failed for an unspecified reason. </td> </tr> </table>
    ///    
    HRESULT RemoveMarker(ushort wIndex);
    ///The <b>GetScriptCount</b> method returns the number of scripts currently in the header section of the ASF file.
    ///Params:
    ///    pcScripts = Pointer to a count of scripts.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The object is not in a configurable
    ///    state. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>pcScripts</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
    ///    <td width="60%"> <i>pcScripts</i> is not a valid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetScriptCount(ushort* pcScripts);
    ///The <b>GetScript</b> method returns the type and command strings, and the presentation time, of a script.
    ///Params:
    ///    wIndex = <b>WORD</b>that contains the index.
    ///    pwszType = Pointer to a wide-character <b>null</b>-terminated string buffer into which the type is copied.
    ///    pcchTypeLen = On input, a pointer to a variable that contains the length of the <i>pwszType</i> array in wide characters (2
    ///                  bytes). On output, if the method succeeds, the variable contains the actual length of the string loaded into
    ///                  <i>pwszType</i>.This includes the terminating <b>null</b> character. To retrieve the length of the type, you
    ///                  must set this to zero and set <i>pwszType</i> to <b>NULL</b>.
    ///    pwszCommand = Pointer to a wide-character <b>null</b>-terminated string buffer into which the command is copied.
    ///    pcchCommandLen = On input, a pointer to a variable that contains the length of the <i>pwszCommand</i> array in wide characters
    ///                     (2 bytes). On output, if the method succeeds, the variable contains the actual length of the command string.
    ///                     This includes the terminating <b>null</b> character. To retrieve the length of the command, you must set this
    ///                     to zero and set <i>pwszCommand</i> to <b>NULL</b>.
    ///    pcnsScriptTime = Pointer to a <b>QWORD</b>that specifies the presentation time of this script command in 100-nanosecond
    ///                     increments.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The size specified by
    ///    <i>pcchCommandLen</i> or <i>pcchTypeLen</i> is not large enough to receive the value. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>ASF_E_NOTFOUND</b></dt> </dl> </td> <td width="60%"> A script command that matches
    ///    was not found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_STATE</b></dt> </dl> </td> <td
    ///    width="60%"> The object is not in a configurable state. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A pointer is <b>NULL</b> where a value is required.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A pointer
    ///    variable does not contain a valid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetScript(ushort wIndex, PWSTR pwszType, ushort* pcchTypeLen, PWSTR pwszCommand, 
                      ushort* pcchCommandLen, ulong* pcnsScriptTime);
    ///The <b>AddScript</b> method adds a script, consisting of type and command strings, and a specific time, to the
    ///header section of the ASF file.
    ///Params:
    ///    pwszType = Pointer to a wide-character null-terminated string containing the type. Script types are limited to 1024 wide
    ///               characters.
    ///    pwszCommand = Pointer to a wide-character null-terminated string containing the command. Script commands are limited to
    ///                  10240 wide characters.
    ///    cnsScriptTime = The script time in 100-nanosecond increments.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The object is not in a configurable
    ///    state. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> No
    ///    value was supplied in <i>pwszType</i> or <i>pwszCommand</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A pointer parameter does not contain a valid pointer.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method
    ///    failed for an unspecified reason. </td> </tr> </table>
    ///    
    HRESULT AddScript(PWSTR pwszType, PWSTR pwszCommand, ulong cnsScriptTime);
    ///The <b>RemoveScript</b> method enables the object to remove a script from the header section of the ASF file.
    ///Params:
    ///    wIndex = <b>WORD</b> containing the index of the script.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The object cannot be currently
    ///    configured. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%">
    ///    The method failed for an unspecified reason. </td> </tr> </table>
    ///    
    HRESULT RemoveScript(ushort wIndex);
}

///The <b>IWMHeaderInfo2</b> interface exposes information about the codecs used to create the content in a file. The
///<b>IWMHeaderInfo2</b> interface is implemented by the metadata editor object, the writer object, the reader object,
///and the synchronous reader object. To obtain a pointer to an instance, call the <b>QueryInterface</b> method of any
///other interface in the desired object.
@GUID("15CF9781-454E-482E-B393-85FAE487A810")
interface IWMHeaderInfo2 : IWMHeaderInfo
{
    ///The <b>GetCodecInfoCount</b> method retrieves the number of codecs for which information is available. The codecs
    ///counted are those that were used to encode the streams of the file loaded in the metadata editor, reader, or
    ///synchronous reader object to which the <b>IWMHeaderInfo2</b> interface belongs.
    ///Params:
    ///    pcCodecInfos = Pointer to a count of codecs for which information is available.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCodecInfoCount(uint* pcCodecInfos);
    ///The <b>GetCodecInfo</b> method retrieves information about a codec that is used to create the content of a file.
    ///Params:
    ///    wIndex = <b>DWORD</b>that contains the zero-based codec index.
    ///    pcchName = On input, pointer to the length of <i>pwszName</i> in wide characters. On output, pointer to a count of the
    ///               characters that are used in <i>pwszName</i>.This includes the terminating <b>null</b> character.
    ///    pwszName = Pointer to a wide-character <b>null</b>-terminated string buffer into which the name of the codec is copied.
    ///    pcchDescription = On input, pointer to the length of <i>pwszDescription</i> in wide characters. On output, pointer to a count
    ///                      of the characters that are used in <i>pwszDescription</i>. This includes the terminating <b>null</b>
    ///                      character.
    ///    pwszDescription = Pointer to a wide-character <b>null</b>-terminated string buffer into which the description of the codec is
    ///                      copied.
    ///    pCodecType = Pointer to one member of the WMT_CODEC_INFO_TYPE enumeration type.
    ///    pcbCodecInfo = On input, pointer to the length of <i>pbCodecInfo</i>, in bytes. On output, pointer to a count of the bytes
    ///                   used in <i>pbCodecInfo</i>.
    ///    pbCodecInfo = Pointer to a byte array.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCodecInfo(uint wIndex, ushort* pcchName, PWSTR pwszName, ushort* pcchDescription, 
                         PWSTR pwszDescription, WMT_CODEC_INFO_TYPE* pCodecType, ushort* pcbCodecInfo, 
                         ubyte* pbCodecInfo);
}

///The <b>IWMHeaderInfo3</b> interface supports the following new metadata features: <ul> <li>Attribute data in excess
///of 64 kilobytes.</li> <li>Multiple attributes with the same name.</li> <li>Attributes in multiple languages.</li>
///</ul> Because the attributes created using this interface can have duplicate names, the methods of this interface use
///index values to identify attributes. The <b>IWMHeaderInfo3</b> interface is implemented by the metadata editor
///object, the writer object, the reader object, and the synchronous reader object. To obtain a pointer to an instance,
///call the <b>QueryInterface</b> method of any other interface in the desired object.
@GUID("15CC68E3-27CC-4ECD-B222-3F5D02D80BD5")
interface IWMHeaderInfo3 : IWMHeaderInfo2
{
    ///The <b>GetAttributeCountEx</b> method retrieves the total number of attributes associated with a specified stream
    ///number. You can also use this method to get the number of attributes not associated with a specific stream
    ///(file-level attributes), or to get the total number of attributes in the file, regardless of stream number.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number for which to retrieve the attribute count. Pass zero to retrieve the
    ///                 count of attributes that apply to the file rather than a specific stream. Pass 0xFFFF to retrieve the total
    ///                 count of all attributes in the file, both stream-specific and file-level.
    ///    pcAttributes = Pointer to a <b>WORD</b> containing the number of attributes that exist for the specified stream.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pcAttributes</i> is not a valid pointer. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALIDREQUEST</b></dt> </dl> </td> <td width="60%">
    ///    <i>wStreamNum</i> is not a valid stream number. </td> </tr> </table>
    ///    
    HRESULT GetAttributeCountEx(ushort wStreamNum, ushort* pcAttributes);
    ///The <b>GetAttributeIndices</b> method retrieves a list of valid attribute indices within specified parameters.
    ///You can retrieve indices for all attributes with the same name or for all attributes in a specified language. The
    ///indices found are for a single specific stream. Alternatively, you can retrieve the specified indices for the
    ///entire file.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number for which to retrieve attribute indices. Passing zero retrieves
    ///                 indices for file-level attributes. Passing 0xFFFF retrieves indices for all appropriate attributes,
    ///                 regardless of their association to streams.
    ///    pwszName = Pointer to a wide-character null-terminated string containing the attribute name for which you want to
    ///               retrieve indices. Pass NULL to retrieve indices for attributes based on language. Attribute names are limited
    ///               to 1024 wide characters.
    ///    pwLangIndex = Pointer to a <b>WORD</b> containing the language index of the language for which to retrieve attribute
    ///                  indices. Pass NULL to retrieve indices for attributes by name.
    ///    pwIndices = Pointer to a <b>WORD</b> array containing the indices that meet the criteria described by the input
    ///                parameters. Pass NULL to retrieve the size of the array, which will be returned in <i>pwCount</i>.
    ///    pwCount = On output, pointer to a <b>WORD</b> containing the number of elements in the <i>pwIndices</i> array.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_SDK_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The size specified in
    ///    <i>pwCount</i> is too small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt>
    ///    </dl> </td> <td width="60%"> <i>wStreamNum</i> is not a valid stream number, <i>pwLangIndex</i> is not a
    ///    valid language index, or <i>pwszName</i> is not a valid name. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A pointer is not valid. </td> </tr> </table>
    ///    
    HRESULT GetAttributeIndices(ushort wStreamNum, const(PWSTR) pwszName, ushort* pwLangIndex, ushort* pwIndices, 
                                ushort* pwCount);
    ///The <b>GetAttributeByIndexEx</b> method retrieves the value of an attribute specified by the attribute index. You
    ///can use this method in conjunction with the GetAttributeCountEx method to retrieve all of the attributes
    ///associated with a particular stream number.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number to which the attribute applies. Set to zero to retrieve a file-level
    ///                 attribute.
    ///    wIndex = <b>WORD</b> containing the index of the attribute to be retrieved.
    ///    pwszName = Pointer to a wide-character <b>null</b>-terminated string containing the attribute name. Pass <b>NULL</b> to
    ///               retrieve the size of the string, which will be returned in <i>pwNameLen</i>.
    ///    pwNameLen = Pointer to a <b>WORD</b> containing the size of <i>pwszName</i>, in wide characters. This size includes the
    ///                terminating <b>null</b> character. Attribute names are limited to 1024 wide characters.
    ///    pType = Type of data used for the attribute. For more information about the types of data supported, see
    ///            WMT_ATTR_DATATYPE.
    ///    pwLangIndex = Pointer to a <b>WORD</b> containing the language index of the language associated with the attribute. This is
    ///                  the index of the language in the language list for the file.
    ///    pValue = Pointer to an array of bytes containing the attribute value. Pass <b>NULL</b> to retrieve the size of the
    ///             attribute value, which will be returned in <i>pdwDataLength</i>.
    ///    pdwDataLength = Pointer to a <b>DWORD</b> containing the length, in bytes, of the attribute value pointed to by
    ///                    <i>pValue</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_SDK_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The size specified for the name or
    ///    value is too small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td>
    ///    <td width="60%"> <i>wStreamNum</i> is not a valid stream number, or there is no attribute at <i>wIndex</i>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A pointer is
    ///    not valid. </td> </tr> </table>
    ///    
    HRESULT GetAttributeByIndexEx(ushort wStreamNum, ushort wIndex, PWSTR pwszName, ushort* pwNameLen, 
                                  WMT_ATTR_DATATYPE* pType, ushort* pwLangIndex, ubyte* pValue, uint* pdwDataLength);
    ///The <b>ModifyAttribute</b> method modifies the settings of an existing attribute.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number to which the attribute applies. Pass zero for file-level attributes.
    ///    wIndex = <b>WORD</b> containing the index of the attribute to change.
    ///    Type = Type of data used for the new attribute value. For more information about the types of data supported, see
    ///           WMT_ATTR_DATATYPE.
    ///    wLangIndex = <b>WORD</b> containing the language index of the language to be associated with the new attribute. This is
    ///                 the index of the language in the language list for the file.
    ///    pValue = Pointer to an array of bytes containing the attribute value.
    ///    dwLength = <b>DWORD</b> containing the length of the attribute value, in bytes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An illegal parameter combination, data type,
    ///    or attribute name was used. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td
    ///    width="60%"> The method is not implemented on a reader object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A pointer is not valid. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>NS_E_ATTRIBUTE_READ_ONLY</b></dt> </dl> </td> <td width="60%"> The attribute cannot
    ///    be changed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td
    ///    width="60%"> <i>wStreamNum</i> is not a valid stream number, or there is no attribute at <i>wIndex</i>. </td>
    ///    </tr> </table>
    ///    
    HRESULT ModifyAttribute(ushort wStreamNum, ushort wIndex, WMT_ATTR_DATATYPE Type, ushort wLangIndex, 
                            const(ubyte)* pValue, uint dwLength);
    ///The <b>AddAttribute</b> method adds a metadata attribute. To change the value of an existing attribute, use the
    ///IWMHeaderInfo3::ModifyAttribute method.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number of the stream to which the attribute applies. Setting this value to
    ///                 zero indicates an attribute that applies to the entire file.
    ///    pszName = Pointer to a wide-character null-terminated string containing the name of the attribute. Attribute names are
    ///              limited to 1024 wide characters.
    ///    pwIndex = Pointer to a <b>WORD</b>. On successful completion of the method, this value is set to the index assigned to
    ///              the new attribute.
    ///    Type = Type of data used for the new attribute. For more information about the types of data supported, see
    ///           WMT_ATTR_DATATYPE.
    ///    wLangIndex = <b>WORD</b> containing the language index of the language to be associated with the new attribute. This is
    ///                 the index of the language in the language list for the file. Setting this value to zero indicates that the
    ///                 default language will be used. A default language is created and set according to the regional settings on
    ///                 the computer running your application.
    ///    pValue = Pointer to an array of bytes containing the attribute value.
    ///    dwLength = <b>DWORD</b> containing the length of the attribute value, in bytes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An illegal parameter combination, data type,
    ///    or attribute name was used. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td
    ///    width="60%"> The method is not implemented on a reader object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A pointer is not valid. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>NS_E_SDK_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The size specified by
    ///    <i>dwLength</i> is too small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt>
    ///    </dl> </td> <td width="60%"> <i>wStreamNum</i> is not a valid stream number. </td> </tr> </table>
    ///    
    HRESULT AddAttribute(ushort wStreamNum, const(PWSTR) pszName, ushort* pwIndex, WMT_ATTR_DATATYPE Type, 
                         ushort wLangIndex, const(ubyte)* pValue, uint dwLength);
    ///The <b>DeleteAttribute</b> method removes an attribute from the file header.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number for which the attribute applies. Setting this value to zero
    ///                 indicates a file-level attribute.
    ///    wIndex = <b>WORD</b> containing the index of the attribute to be deleted.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The method is not implemented on a reader object.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALIDREQUEST</b></dt> </dl> </td> <td width="60%">
    ///    <i>wStreamNum</i> is not a valid stream number, or there is not an attribute at <i>wIndex</i>. </td> </tr>
    ///    </table>
    ///    
    HRESULT DeleteAttribute(ushort wStreamNum, ushort wIndex);
    ///The <b>AddCodecInfo</b> method adds codec information to a file. When you copy a compressed stream from one file
    ///to another, use this method to include the information about the encoding codec in the file header.
    ///Params:
    ///    pwszName = Pointer to a wide-character null-terminated string containing the name.
    ///    pwszDescription = Pointer to a wide-character null-terminated string containing the description.
    ///    codecType = A value from the WMT_CODEC_INFO_TYPE enumeration specifying the codec type.
    ///    cbCodecInfo = The size of the codec information, in bytes.
    ///    pbCodecInfo = Pointer to an array of bytes that contains the codec information.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT AddCodecInfo(PWSTR pwszName, PWSTR pwszDescription, WMT_CODEC_INFO_TYPE codecType, ushort cbCodecInfo, 
                         ubyte* pbCodecInfo);
}

///The <b>IWMProfileManager</b> interface is used to create profiles, load existing profiles, and save profiles. It can
///be used with both system profiles and application-defined custom profiles. To make changes to a profile, you must
///load it into a profile object using one of the loading methods of this interface. You can then access the profile
///data through the use of the interfaces of the profile object. <b>IWMProfileManager</b> is the default interface of a
///profile manager object. When you create a new profile manager object using the WMCreateProfileManager function, you
///obtain a pointer to <b>IWMProfileManager</b>. <div class="alert"><b>Note</b> When a profile manager object is created
///it parses all of the system profiles. Creating and releasing a profile manager every time you need to use it will
///adversely affect performance. You should create a profile manager once in your application and release it only when
///you no longer need to use it.</div> <div> </div>
@GUID("D16679F2-6CA0-472D-8D31-2F5D55AEE155")
interface IWMProfileManager : IUnknown
{
    ///The <b>CreateEmptyProfile</b> method creates an empty profile object. You can use the interfaces of the profile
    ///object to configure the profile. When you are done configuring the profile, you can save it to a string using
    ///IWMProfileManager::SaveProfile.
    ///Params:
    ///    dwVersion = <b>DWORD</b> containing one member of the WMT_VERSION enumeration type.
    ///    ppProfile = Pointer to a pointer to an IWMProfile interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough available memory. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>ppProfile</i> parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT CreateEmptyProfile(WMT_VERSION dwVersion, IWMProfile* ppProfile);
    ///The <b>LoadProfileByID</b> method loads a system profile identified by its globally unique identifier. To load a
    ///custom profile, use IWMProfileManager::LoadProfileByData.
    ///Params:
    ///    guidProfile = <b>GUID</b> identifying the profile. For more information, see the table of defined constants in Using System
    ///                  Profiles.
    ///    ppProfile = Pointer to a pointer to an IWMProfile interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough available memory. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>ppProfile</i> parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT LoadProfileByID(const(GUID)* guidProfile, IWMProfile* ppProfile);
    ///The <b>LoadProfileByData</b> method creates a profile object and populates it with data from a stored string. You
    ///must use this method to manipulate custom profiles. System profiles should be accessed using either
    ///LoadProfileByID or LoadSystemProfile.
    ///Params:
    ///    pwszProfile = Pointer to a wide-character <b>null</b>-terminated string containing the profile. Profile strings are limited
    ///                  to 153600 wide characters.
    ///    ppProfile = Pointer to a pointer to an IWMProfile interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough available memory. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Either the
    ///    <i>ppProfile</i> or <i>pwszProfile</i> parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT LoadProfileByData(const(PWSTR) pwszProfile, IWMProfile* ppProfile);
    ///The <b>SaveProfile</b> method saves a profile into an XML-formatted string.
    ///Params:
    ///    pIWMProfile = Pointer to the IWMProfile interface of the object containing the profile data to be saved.
    ///    pwszProfile = Pointer to a wide-character <b>null</b>-terminated string containing the profile. Set this to <b>NULL</b> to
    ///                  retrieve the length of string required.
    ///    pdwLength = On input, specifies the length of the <i>pwszProfile</i> string. On output, if the method succeeds, specifies
    ///                a pointer to a <b>DWORD</b> containing the number of characters, including the terminating <b>null</b>
    ///                character, required to hold the profile.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough available memory. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Either the
    ///    <i>pIWMProfile</i> or <i>pdwLength</i> parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT SaveProfile(IWMProfile pIWMProfile, PWSTR pwszProfile, uint* pdwLength);
    ///The <b>GetSystemProfileCount</b> method retrieves the number of system profiles.
    ///Params:
    ///    pcProfiles = Pointer to a count of the system profiles.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough available memory. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>pcProfiles</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_INVALIDPROFILE</b></dt> </dl> </td> <td width="60%"> The system profiles could not be found.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetSystemProfileCount(uint* pcProfiles);
    ///The <b>LoadSystemProfile</b> method loads a system profile identified by its index. If you do not know the index
    ///of the desired system profile, you must use IWMProfileManager::LoadProfileByID. To load a custom profile, use
    ///IWMProfileManager::LoadProfileByData.
    ///Params:
    ///    dwProfileIndex = <b>DWORD</b> containing the profile index.
    ///    ppProfile = Pointer to a pointer to an IWMProfile interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough available memory. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>ppProfile</i> parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT LoadSystemProfile(uint dwProfileIndex, IWMProfile* ppProfile);
}

///The <b>IWMProfileManager2</b> interface adds methods to specify and retrieve the version number of the system
///profiles enumerated by the profile manager. Most applications should set the value to the latest version unless they
///need to be backward-compatible with another application that was written using an earlier version of this SDK.
@GUID("7A924E51-73C1-494D-8019-23D37ED9B89A")
interface IWMProfileManager2 : IWMProfileManager
{
    ///The <b>GetSystemProfileVersion</b> method retrieves the version number of the system profiles that the profile
    ///manager enumerates.
    ///Params:
    ///    pdwVersion = Pointer to one member of the WMT_VERSION enumeration type.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetSystemProfileVersion(WMT_VERSION* pdwVersion);
    ///The <b>SetSystemProfileVersion</b> method specifies the version number of the system profiles that the profile
    ///manager enumerates.
    ///Params:
    ///    dwVersion = One member of the WMT_VERSION enumeration type.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetSystemProfileVersion(WMT_VERSION dwVersion);
}

///The <b>IWMProfileManagerLanguage</b> interface controls the language of the system profiles parsed by the profile
///manager. An <b>IWMProfileManagerLanguage</b> interface exists for every profile manager object. You can obtain a
///pointer to an instance of this method by calling the <b>QueryInterface</b> method of any other interface of the
///profile manager object.
@GUID("BA4DCC78-7EE0-4AB8-B27A-DBCE8BC51454")
interface IWMProfileManagerLanguage : IUnknown
{
    ///The <b>GetUserLanguageID</b> method retrieves the language identifier for the system profiles loaded by the
    ///profile manager object.
    ///Params:
    ///    wLangID = Pointer to a <b>WORD</b> that receives the language identifier (LANGID) of the language set in the profile
    ///              manager.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetUserLanguageID(ushort* wLangID);
    ///The <b>SetUserLanguageID</b> method sets the language of the system profiles that will be parsed by the profile
    ///manager object.
    ///Params:
    ///    wLangID = <b>WORD</b> containing the language identifier (LANGID) of the language you want to use.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_NOMATCHING_ELEMENT</b></dt> </dl> </td> <td width="60%"> The specified LANGID represents a
    ///    locality not supported by a localized set of system profiles. </td> </tr> </table>
    ///    
    HRESULT SetUserLanguageID(ushort wLangID);
}

///The <b>IWMProfile</b> interface is the primary interface for a profile object. A profile object is used to configure
///custom profiles. You can use <b>IWMProfile</b> to create, delete, or modify stream configuration objects and mutual
///exclusion objects. You can also set and retrieve general information about the profile. To access all the features of
///the profile object, you should use IWMProfile3, which inherits from <b>IWMProfile</b> and IWMProfile2.
///<b>IWMProfile</b> is also accessible through the reader object, where you can use it to get information about the
///streams of a file that is loaded in the reader. When accessing <b>IWMProfile</b> from the reader, you can make
///changes to the profile, but none of the changes can be saved to the file. It is often handy to use the profile of an
///existing file as the foundation of a new profile. The synchronous reader supports <b>IWMProfile</b> in the same way
///as the reader. The profile information obtained through the reader or synchronous reader does not come from a .prx
///file. The reader uses the information in the ASF file to assemble the stream configurations. Thus certain profile
///information, like the name and description, are not available through the reader. There are several ways to obtain a
///pointer to an <b>IWMProfile</b> interface. The profile manager has methods to create a new profile and to access
///existing profiles. All of these methods set an <b>IWMProfile</b> pointer. When reading a file, a pointer to
///<b>IWMProfile</b> can be obtained by calling the <b>QueryInterface</b> method of any reader interface. Likewise, any
///interface of the synchronous reader object can obtain a pointer with a call to <b>QueryInterface</b>IWMProfile3.
@GUID("96406BDB-2B2B-11D3-B36B-00C04F6108FF")
interface IWMProfile : IUnknown
{
    ///The <b>GetVersion</b> method retrieves the version number of the Windows Media Format SDK used to create the
    ///profile.
    ///Params:
    ///    pdwVersion = Pointer to a <b>DWORD</b> containing one member of the WMT_VERSION enumeration type. This value specifies the
    ///                 version of the Windows Media Format SDK that was used to create the profile.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pdwVersion</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetVersion(WMT_VERSION* pdwVersion);
    ///The <b>GetName</b> method retrieves the name of a profile.
    ///Params:
    ///    pwszName = Pointer to a wide-character <b>null</b>-terminated string containing the name. Pass <b>NULL</b> to retrieve
    ///               the length of the name.
    ///    pcchName = On input, specifies the length of the <i>pwszName</i> buffer. On output, if the method succeeds, specifies a
    ///               pointer to the length of the name, including the terminating <b>null</b> character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pcchName</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>pwszName</i> parameter is not large enough. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetName(PWSTR pwszName, uint* pcchName);
    ///The <b>SetName</b> method specifies the name of a profile.
    ///Params:
    ///    pwszName = Pointer to a wide-character <b>null</b>-terminated string containing the name. Profile names are limited to
    ///               256 wide characters.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pwszName</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetName(const(PWSTR) pwszName);
    ///The <b>GetDescription</b> method retrieves the profile description. The description is a string that contains an
    ///explanation of what the profile should be used for.
    ///Params:
    ///    pwszDescription = Pointer to a wide-character <b>null</b>-terminated string containing the description. Pass <b>NULL</b> to
    ///                      retrieve the required length for the description.
    ///    pcchDescription = On input, specifies the length of the <i>pwszDescription</i> string. On output, if the method succeeds,
    ///                      specifies a pointer to a count of the number of characters in the name, including the terminating <b>null</b>
    ///                      character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pcchName</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The
    ///    buffer pointed to by the <i>pwszDescription</i> parameter is not large enough. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an
    ///    unspecified reason. </td> </tr> </table>
    ///    
    HRESULT GetDescription(PWSTR pwszDescription, uint* pcchDescription);
    ///The <b>SetDescription</b> method specifies the description of a profile. The description is a string that
    ///contains an explanation of what the profile should be used for.
    ///Params:
    ///    pwszDescription = Pointer to a wide-character <b>null</b>-terminated string containing the description. Profile descriptions
    ///                      are limited to 1024 wide characters.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pwszDescription</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT SetDescription(const(PWSTR) pwszDescription);
    ///The <b>GetStreamCount</b> method retrieves the number of streams in a profile.
    ///Params:
    ///    pcStreams = Pointer to a count of streams.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pcStreams</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetStreamCount(uint* pcStreams);
    ///The <b>GetStream</b> method retrieves a stream from the profile.
    ///Params:
    ///    dwStreamIndex = <b>DWORD</b> containing the stream index.
    ///    ppConfig = Pointer to a pointer to the IWMStreamConfig interface of the stream configuration object that describes the
    ///               specified stream.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>ppConfig</i> or <i>dwStreamIndex</i> parameter is not valid. </td> </tr> </table>
    ///    
    HRESULT GetStream(uint dwStreamIndex, IWMStreamConfig* ppConfig);
    ///The <b>GetStreamByNumber</b> method retrieves a stream from the profile.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number.
    ///    ppConfig = Pointer to a pointer to the IWMStreamConfig interface of the stream configuration object that describes the
    ///               specified stream.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>ppConfig</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_NO_STREAM</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>wStreamNum</i> parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> The method failed for an unspecified reason. </td> </tr> </table>
    ///    
    HRESULT GetStreamByNumber(ushort wStreamNum, IWMStreamConfig* ppConfig);
    ///The <b>RemoveStream</b> method removes a stream from the profile.
    ///Params:
    ///    pConfig = Pointer to the IWMStreamConfig interface of the stream configuration object that describes the stream you
    ///              want to remove.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>pConfig</i> parameter is <b>NULL</b> or not valid. </td> </tr> </table>
    ///    
    HRESULT RemoveStream(IWMStreamConfig pConfig);
    ///The <b>RemoveStreamByNumber</b> method removes a stream from the profile.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_NO_STREAM</b></dt> </dl> </td> <td width="60%"> No stream was
    ///    found to match <i>wStreamNum</i> value. </td> </tr> </table>
    ///    
    HRESULT RemoveStreamByNumber(ushort wStreamNum);
    ///The <b>AddStream</b> method adds a stream to the profile by copying the stream configuration details into the
    ///profile. Use <b>AddStream</b> only to include a stream that is new to the profile. New streams can be created by
    ///calling IWMProfile::CreateNewStream, but will not be added to the profile until <b>AddStream</b> is called. If
    ///you edit an existing stream using IWMProfile::GetStream or IWMProfile::GetStreamByNumber, you should not call
    ///<b>AddStream</b> to include the changes. To include changes made to an existing stream, call
    ///IWMProfile::ReconfigStream.
    ///Params:
    ///    pConfig = Pointer to the IWMStreamConfig interface of the stream configuration object to be added to the profile. The
    ///              stream must be configured by using the methods of the <b>IWMStreamConfig</b> interface before this method is
    ///              used to add the stream to the profile.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pConfig</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is
    ///    not enough available memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method failed for an unspecified reason. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_INVALID_STREAM</b></dt> </dl> </td> <td width="60%"> The stream is not valid, possibly because it
    ///    does not have a valid stream number. </td> </tr> </table>
    ///    
    HRESULT AddStream(IWMStreamConfig pConfig);
    ///The <b>ReconfigStream</b> method enables changes made to a stream configuration to be included in the profile.
    ///Use this method when you have made changes to a stream that has already been included in the profile.
    ///Params:
    ///    pConfig = Pointer to the IWMStreamConfig interface of the stream configuration object for the stream you want to
    ///              reconfigure.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_STREAM</b></dt> </dl> </td> <td width="60%"> The
    ///    method is working on a stream that is <b>NULL</b> or not valid. </td> </tr> </table>
    ///    
    HRESULT ReconfigStream(IWMStreamConfig pConfig);
    ///The <b>CreateNewStream</b> method creates a stream configuration object. You can use a stream configuration
    ///object to define the characteristics of a media stream.
    ///Params:
    ///    guidStreamType = GUID object specifying the major media type for the stream to be created (for example, WMMEDIATYPE_Video).
    ///                     The supported major types are listed in Media Types.
    ///    ppConfig = Pointer to a pointer to the IWMStreamConfig interface of the created stream configuration object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>ppConfig</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is
    ///    not enough available memory. </td> </tr> </table>
    ///    
    HRESULT CreateNewStream(const(GUID)* guidStreamType, IWMStreamConfig* ppConfig);
    ///The <b>GetMutualExclusionCount</b> method retrieves the number of mutual exclusion objects in the profile.
    ///Params:
    ///    pcME = Pointer to a count of mutual exclusions.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pcME</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetMutualExclusionCount(uint* pcME);
    ///The <b>GetMutualExclusion</b> method retrieves a mutual exclusion object from the profile.
    ///Params:
    ///    dwMEIndex = <b>DWORD</b> containing the index of the mutual exclusion object.
    ///    ppME = Pointer to a pointer to the IWMMutualExclusion interface of the mutual exclusion object specified by the
    ///           index passed as <i>dwMEIndex</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory for this operation. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppME</i> is
    ///    <b>NULL</b>, or <i>dwMEIndex</i> is outside the range of indexes available. </td> </tr> </table>
    ///    
    HRESULT GetMutualExclusion(uint dwMEIndex, IWMMutualExclusion* ppME);
    ///The <b>RemoveMutualExclusion</b> method removes a mutual exclusion object from the profile.
    ///Params:
    ///    pME = Pointer to the IWMMutualExclusion interface of the mutual exclusion object you want to remove.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pcME</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT RemoveMutualExclusion(IWMMutualExclusion pME);
    ///The <b>AddMutualExclusion</b> method adds a mutual exclusion object to the profile. Mutual exclusion objects are
    ///used to specify a set of streams, only one of which can be output at a time.
    ///Params:
    ///    pME = Pointer to the IWMMutualExclusion interface of the mutual exclusion object to include in the profile. You
    ///          must configure the mutual exclusion object by using the methods of the <b>IWMMutualExclusion</b> interface
    ///          prior to using this method to add the mutual exclusion object to the profile.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The parameter <i>pME</i> is <b>NULL</b>, or
    ///    the mutual exclusion type is not CLSID_WMMUTEX_Bitrate. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough available memory to complete
    ///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_STREAM</b></dt> </dl> </td> <td
    ///    width="60%"> A stream number in the mutual exclusion object being added is not part of the profile. </td>
    ///    </tr> </table>
    ///    
    HRESULT AddMutualExclusion(IWMMutualExclusion pME);
    ///The <b>CreateNewMutualExclusion</b> method creates a mutual exclusion object. Mutual exclusion objects are used
    ///to specify a set of streams, only one of which can be output at a time.
    ///Params:
    ///    ppME = Pointer to a pointer to the IWMMutualExclusion interface of the new mutual exclusion object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>ppME</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT CreateNewMutualExclusion(IWMMutualExclusion* ppME);
}

///The <b>IWMProfile2</b> interface exposes the globally unique identifier for a system profile. System profiles have
///associated identifiers, but custom profiles do not. As with IWMProfile, <b>IWMProfile2</b> is included in profile
///objects as well as in reader and synchronous reader objects. To obtain a pointer to an <b>IWMProfile2</b> interface,
///call the <b>QueryInterface</b> method of any interface in one of these objects. For more information, see
///<b>IWMProfile Interface</b>.
@GUID("07E72D33-D94E-4BE7-8843-60AE5FF7E5F5")
interface IWMProfile2 : IWMProfile
{
    ///The <b>GetProfileID</b> method retrieves the globally unique identifier of a system profile.
    ///Params:
    ///    pguidID = Pointer to a GUID specifying the ID of the profile. It the profile is not a system profile, this is set to
    ///              GUID_NULL.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetProfileID(GUID* pguidID);
}

///The <b>IWMProfile3</b> interface provides enhanced features for profiles. This includes the ability to create two new
///types of objects: bandwidth sharing objects and stream prioritization objects. An <b>IWMProfile3</b> interface is
///created for each profile object created. You can retrieve a pointer to an <b>IWMProfile3</b> interface by calling the
///<b>QueryInterface</b> method of any other interface of the profile. You can also access <b>IWMProfile3</b> from a
///reader or synchronous reader object by calling the <b>QueryInterface</b> method of an existing interface in the
///object. For more information, see IWMProfile Interface.
@GUID("00EF96CC-A461-4546-8BCD-C9A28F0E06F5")
interface IWMProfile3 : IWMProfile2
{
    ///The <b>GetStorageFormat</b> method is not implemented.
    ///Params:
    ///    pnStorageFormat = Storage format.
    ///Returns:
    ///    The method returns E_NOTIMPL.
    ///    
    HRESULT GetStorageFormat(WMT_STORAGE_FORMAT* pnStorageFormat);
    ///The <b>SetStorageFormat</b> method is not implemented.
    ///Params:
    ///    nStorageFormat = Storage format.
    ///Returns:
    ///    The method returns E_NOTIMPL.
    ///    
    HRESULT SetStorageFormat(WMT_STORAGE_FORMAT nStorageFormat);
    ///The <b>GetBandwidthSharingCount</b> method retrieves the total number of bandwidth sharing objects that have been
    ///added to the profile.
    ///Params:
    ///    pcBS = Pointer to receive the total number of bandwidth sharing objects.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pcBS</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetBandwidthSharingCount(uint* pcBS);
    ///The <b>GetBandwidthSharing</b> method retrieves a bandwidth sharing object from a profile.
    ///Params:
    ///    dwBSIndex = <b>DWORD</b> containing the index number of the bandwidth sharing object you want to retrieve.
    ///    ppBS = Pointer to receive the address of the IWMBandwidthSharing interface of the object requested.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppBS</i> is <b>NULL</b>. OR
    ///    <i>dwBSIndex</i> refers to an invalid index number. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to allocate memory for the
    ///    bandwidth sharing object. </td> </tr> </table>
    ///    
    HRESULT GetBandwidthSharing(uint dwBSIndex, IWMBandwidthSharing* ppBS);
    ///The <b>RemoveBandwidthSharing</b> method removes a bandwidth sharing object from the profile. If you do not
    ///already have a pointer to the IWMBandwidthSharing interface of the object you want to remove, you must obtain one
    ///with a call to IWMProfile3::GetBandwidthSharing.
    ///Params:
    ///    pBS = Pointer to a bandwidth sharing object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pBS</i> is <b>NULL</b>. OR The bandwidth
    ///    sharing object pointed to by <i>pBS</i> is not part of the profile. </td> </tr> </table>
    ///    
    HRESULT RemoveBandwidthSharing(IWMBandwidthSharing pBS);
    ///The <b>AddBandwidthSharing</b> method adds an existing bandwidth sharing object to the profile. Bandwidth sharing
    ///objects are created with a call to CreateNewBandwidthSharing. You must configure the bandwidth sharing object
    ///before adding it to the profile.
    ///Params:
    ///    pBS = Pointer to the IWMBandwidthSharing interface of a bandwidth sharing object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pBS</i> is <b>NULL</b>. OR The bandwidth
    ///    sharing object has a bandwidth sharing type value that is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> An unknown error occurred while adding the
    ///    bandwidth sharing object to the internal collection in the profile. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate memory. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_NO_STREAM</b></dt> </dl> </td> <td width="60%"> The bandwidth
    ///    sharing object contains no streams. </td> </tr> </table>
    ///    
    HRESULT AddBandwidthSharing(IWMBandwidthSharing pBS);
    ///The <b>CreateNewBandwidthSharing</b> method creates a new bandwidth sharing object.
    ///Params:
    ///    ppBS = Pointer to a variable that receives the address of the IWMBandwidthSharing interface of the new object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppBS</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to
    ///    allocate memory for the new object. </td> </tr> </table>
    ///    
    HRESULT CreateNewBandwidthSharing(IWMBandwidthSharing* ppBS);
    ///The <b>GetStreamPrioritization</b> method retrieves the stream prioritization that exists in the profile.
    ///Params:
    ///    ppSP = Pointer to receive the address of the IWMStreamPrioritization interface of the stream prioritization object
    ///           in the profile.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>ppSP</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to
    ///    allocate memory for the stream prioritization object </td> </tr> </table>
    ///    
    HRESULT GetStreamPrioritization(IWMStreamPrioritization* ppSP);
    ///The <b>SetStreamPrioritization</b> method assigns a stream prioritization object to the profile. A profile can
    ///contain only one stream prioritization object at a time.
    ///Params:
    ///    pSP = Pointer to the IWMStreamPrioritization interface of the stream prioritization object you want to assign to
    ///          the profile.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> <i>pSP</i> is <b>NULL</b>. OR The method was
    ///    unable to validate the stream prioritization object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate memory in the
    ///    profile for the object. </td> </tr> </table>
    ///    
    HRESULT SetStreamPrioritization(IWMStreamPrioritization pSP);
    ///The <b>RemoveStreamPrioritization</b> method removes the stream prioritization object from the profile.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>ASF_E_NOTFOUND</b></dt> </dl> </td> <td width="60%"> No stream prioritization object exists in
    ///    the profile. </td> </tr> </table>
    ///    
    HRESULT RemoveStreamPrioritization();
    ///The <b>CreateNewStreamPrioritization</b> method creates a new stream prioritization object. After you create a
    ///stream prioritization object, use the methods of the IWMStreamPrioritization interface to configure it. The
    ///configured stream prioritization object can then be assigned to the profile with a call to
    ///SetStreamPrioritization.
    ///Params:
    ///    ppSP = Pointer to receive the address of the <b>IWMStreamPrioritization</b> interface of the new object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL was passed as <i>ppSP</i>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to
    ///    allocate memory for the new object. </td> </tr> </table>
    ///    
    HRESULT CreateNewStreamPrioritization(IWMStreamPrioritization* ppSP);
    ///The <b>GetExpectedPacketCount</b> method calculates the expected packet count for the specified duration. The
    ///packet count returned is only an estimate, and it is based upon the settings of the profile at the time this call
    ///is made.
    ///Params:
    ///    msDuration = Specifies the duration in milliseconds.
    ///    pcPackets = Pointer to receive the count of packets expected for <i>msDuration</i> milliseconds.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pcPackets</i> is <b>NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> One of the internal
    ///    objects required by the method could not be initialized. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The profile in the profile object is not compatible
    ///    with this method. </td> </tr> </table>
    ///    
    HRESULT GetExpectedPacketCount(ulong msDuration, ulong* pcPackets);
}

///The <b>IWMStreamConfig</b> interface is the primary interface of a stream configuration object. It provides methods
///to configure basic properties for streams to be used in a profile. Every profile contains one or more stream
///configuration objects. You can get the <b>IWMStreamConfig</b> interface of a stream configuration object by calling
///the IWMProfile::GetStream method or the IWMProfile::GetStreamByNumber method. The difference between these two
///methods is that <b>GetStream</b> retrieves the stream using an index ranging from zero to one less than the total
///stream count, and <b>GetStreamByNumber</b> retrieves the stream using the assigned stream number. You can also
///retrieve a stream configuration object using the IWMProfile::CreateNewStream method. All of the methods that create
///stream configuration objects set a pointer to this interface. <div class="alert"><b>Important</b> After calling one
///or more of the <b>IWMStreamConfig::Set...</b> methods, you must call IWMProfile::ReconfigStream for all the changes
///to take effect in the profile.</div> <div> </div>
@GUID("96406BDC-2B2B-11D3-B36B-00C04F6108FF")
interface IWMStreamConfig : IUnknown
{
    ///The <b>GetStreamType</b> method retrieves the major type of the stream (audio, video, or script).
    ///Params:
    ///    pguidStreamType = Pointer to a GUID object specifying the major type of the stream.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pguidStreamType</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>GUID_NULL</b></dt> </dl> </td> <td width="60%">
    ///    The <i>pMediaType</i> parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetStreamType(GUID* pguidStreamType);
    ///The <b>GetStreamNumber</b> method retrieves the stream number.
    ///Params:
    ///    pwStreamNum = Pointer to a <b>WORD</b> containing the stream number. Stream numbers must be in the range of 1 through 63.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pwStreamNum</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetStreamNumber(ushort* pwStreamNum);
    ///The <b>SetStreamNumber</b> method specifies the stream number.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number. Stream numbers must be in the range of 1 through 63.
    ///Returns:
    ///    This method always returns S_OK.
    ///    
    HRESULT SetStreamNumber(ushort wStreamNum);
    ///The <b>GetStreamName</b> method retrieves the stream name.
    ///Params:
    ///    pwszStreamName = Pointer to a wide-character <b>null</b>-terminated string containing the stream name. Pass <b>NULL</b> to
    ///                     retrieve the length of the name.
    ///    pcchStreamName = On input, a pointer to a variable containing the length of the <i>pwszStreamName</i> array in wide characters
    ///                     (2 bytes). On output, if the method succeeds, the variable contains the actual length of the name, including
    ///                     the terminating <b>null</b> character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pcchStreamName</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td
    ///    width="60%"> The name value contained in the <i>pcchStreamName</i> parameter is too large for the
    ///    <i>pwszStreamName</i> array. </td> </tr> </table>
    ///    
    HRESULT GetStreamName(PWSTR pwszStreamName, ushort* pcchStreamName);
    ///The <b>SetStreamName</b> method assigns a name to the stream represented by the stream configuration object.
    ///Params:
    ///    pwszStreamName = Pointer to a wide-character <b>null</b>-terminated string containing the stream name. Stream names are
    ///                     limited to 256 wide characters.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pwszStreamName</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT SetStreamName(PWSTR pwszStreamName);
    ///The <b>GetConnectionName</b> method retrieves the input name given to the stream.
    ///Params:
    ///    pwszInputName = Pointer to a wide-character <b>null</b>-terminated string containing the input name. Pass <b>NULL</b> to
    ///                    retrieve the length of the name.
    ///    pcchInputName = On input, a pointer to a variable containing the length of the <i>pwszInputName</i> array in wide characters
    ///                    (2 bytes). On output, if the method succeeds, the variable contains the length of the name, including the
    ///                    terminating <b>null</b> character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pcchInputName</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td
    ///    width="60%"> The name value contained in the <i>pcchInputName</i> parameter is too large for the
    ///    <i>pwszInputName</i> array. </td> </tr> </table>
    ///    
    HRESULT GetConnectionName(PWSTR pwszInputName, ushort* pcchInputName);
    ///The <b>SetConnectionName</b> method specifies a name for an input. If the profile you are creating contains
    ///multiple bit rate mutual exclusion, each of the mutually exclusive streams must have the same connection name.
    ///Params:
    ///    pwszInputName = Pointer to a wide-character <b>null</b>-terminated string containing the input name. Connection names are
    ///                    limited to 256 wide characters.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pwszInputName</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT SetConnectionName(PWSTR pwszInputName);
    ///The <b>GetBitrate</b> method retrieves the bit rate for the stream.
    ///Params:
    ///    pdwBitrate = Pointer to a <b>DWORD</b> containing the bit rate, in bits per second.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pdwbitrate</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetBitrate(uint* pdwBitrate);
    ///The <b>SetBitrate</b> method specifies the bit rate for the stream.
    ///Params:
    ///    pdwBitrate = <b>DWORD</b> containing the bit rate, in bits per second.
    ///Returns:
    ///    This method always returns S_OK.
    ///    
    HRESULT SetBitrate(uint pdwBitrate);
    ///The <b>GetBufferWindow</b> method retrieves the maximum latency between when a stream is received and when it
    ///begins to be displayed.
    ///Params:
    ///    pmsBufferWindow = Pointer to a variable specifying the buffer window, in milliseconds.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pmsBufferWindow</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetBufferWindow(uint* pmsBufferWindow);
    ///The <b>SetBufferWindow</b> method specifies the maximum latency between when a stream is received and when it
    ///begins to be displayed.
    ///Params:
    ///    msBufferWindow = Buffer window, in milliseconds.
    ///Returns:
    ///    This method always returns S_OK.
    ///    
    HRESULT SetBufferWindow(uint msBufferWindow);
}

///The <b>IWMStreamConfig2</b> interface manages the data unit extensions associated with a stream.
///<b>IWMStreamConfig2</b> inherits from IWMStreamConfig. To obtain a pointer to <b>IWMStreamConfig2</b>, call the
///<b>QueryInterface</b> method of the <b>IWMStreamConfig</b> interface.
@GUID("7688D8CB-FC0D-43BD-9459-5A8DEC200CFA")
interface IWMStreamConfig2 : IWMStreamConfig
{
    ///The <b>GetTransportType</b> method retrieves the type of data communication protocol (reliable or unreliable)
    ///used for the stream.
    ///Params:
    ///    pnTransportType = Pointer to a variable that receives one member of the WMT_TRANSPORT_TYPE enumeration type.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pnTransportType</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetTransportType(WMT_TRANSPORT_TYPE* pnTransportType);
    ///The <b>SetTransportType</b> method sets the type of data communication protocol (reliable or unreliable) used for
    ///the stream.
    ///Params:
    ///    nTransportType = One member of the WMT_TRANSPORT_TYPE enumeration type specifying the transport type for the stream.
    ///Returns:
    ///    The method always returns S_OK.
    ///    
    HRESULT SetTransportType(WMT_TRANSPORT_TYPE nTransportType);
    ///The <b>AddDataUnitExtension</b> method adds a data unit extension system to the stream. You can use data unit
    ///extension systems to attach custom data to samples in an output file.
    ///Params:
    ///    guidExtensionSystemID = A GUID that identifies the data unit extension system. This can be one of the predefined GUIDs listed in
    ///                            INSSBuffer3::SetProperty, or a GUID whose value is understood by a custom player application.
    ///    cbExtensionDataSize = Size, in bytes, of the data unit extensions that will be attached to the packets in the stream. Set to 0xFFFF
    ///                          to specify data unit extensions of variable size. Each individual data unit extension can then be set to any
    ///                          size ranging from 0 to 65534.
    ///    pbExtensionSystemInfo = Pointer to a byte buffer containing information about the data unit extension system. If you have no
    ///                            information, you can pass <b>NULL</b>. When passing <b>NULL</b>, <i>cbExtensionSystemInfo</i> must be zero.
    ///    cbExtensionSystemInfo = Count of bytes in the buffer at <i>pbExtensionSystemInfo</i>. If you have no data unit extension system
    ///                            information, you can pass zero. When passing zero, <i>pbExtensionSystemInfo</i> must be <b>NULL</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>cbExtensionSystemInfo</i> specifies a
    ///    non-zero value, but <i>pbExtensionSystemInfo</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method cannot allocate memory to hold the new
    ///    data unit extension. </td> </tr> </table>
    ///    
    HRESULT AddDataUnitExtension(GUID guidExtensionSystemID, ushort cbExtensionDataSize, 
                                 ubyte* pbExtensionSystemInfo, uint cbExtensionSystemInfo);
    ///The <b>GetDataUnitExtensionCount</b> method retrieves the total number of data unit extension systems that have
    ///been added to the stream.
    ///Params:
    ///    pcDataUnitExtensions = Pointer to a <b>WORD</b> that receives the count of data unit extensions.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pcDataUnitExtensions</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetDataUnitExtensionCount(ushort* pcDataUnitExtensions);
    ///The <b>GetDataUnitExtension</b> method retrieves information about an existing data unit extension system.
    ///Params:
    ///    wDataUnitExtensionNumber = <b>WORD</b> containing the data unit extension number. This number is assigned to a data unit extension
    ///                               system when it is added to the stream.
    ///    pguidExtensionSystemID = Pointer to a GUID that receives the identifier of the data unit extension system.
    ///    pcbExtensionDataSize = Pointer to the size, in bytes, of the data unit extensions that will be attached to the packets in the
    ///                           stream. If this value is 0xFFFF, the system uses data unit extensions of variable size. Each individual data
    ///                           unit extension can then be set to any size ranging from 0 to 65534.
    ///    pbExtensionSystemInfo = Pointer to a byte buffer that receives information about the data unit extension system.
    ///    pcbExtensionSystemInfo = Pointer to the size, in bytes, of the data stored at <i>pbExtensionSystemInfo</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pguidExtensionSystemID</i> or
    ///    <i>pcbExtensionDataSize</i> is <b>NULL</b>. OR <i>wDataUnitExtensionNumber</i> specifies an invalid data unit
    ///    extension number. </td> </tr> </table>
    ///    
    HRESULT GetDataUnitExtension(ushort wDataUnitExtensionNumber, GUID* pguidExtensionSystemID, 
                                 ushort* pcbExtensionDataSize, ubyte* pbExtensionSystemInfo, 
                                 uint* pcbExtensionSystemInfo);
    ///The <b>RemoveAllDataUnitExtensions</b> method removes all data unit extension systems that are associated with
    ///the stream.
    ///Returns:
    ///    The method always returns S_OK.
    ///    
    HRESULT RemoveAllDataUnitExtensions();
}

///The <b>IWMStreamConfig3</b> interface controls language settings for a stream. An <b>IWMStreamConfig3</b> interface
///exists for every stream configuration object. You can obtain a pointer to an <b>IWMStreamConfig3</b> interface by
///calling the <b>QueryInterface</b> method of any other interface of the stream configuration object.
@GUID("CB164104-3AA9-45A7-9AC9-4DAEE131D6E1")
interface IWMStreamConfig3 : IWMStreamConfig2
{
    ///The <b>GetLanguage</b> method retrieves the RFC1766-compliant language string for the stream.
    ///Params:
    ///    pwszLanguageString = Pointer to a wide-character <b>null</b>-terminated string containing the language string. Pass <b>NULL</b> to
    ///                         retrieve the size of the string, which is returned in <i>pcchLanguageStringLength</i>.
    ///    pcchLanguageStringLength = Pointer to a <b>WORD</b> containing the size of the language string in wide characters. This size includes
    ///                               the terminating <b>null</b> character.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetLanguage(PWSTR pwszLanguageString, ushort* pcchLanguageStringLength);
    ///The <b>SetLanguage</b> method sets the language for a stream using an RFC1766-compliant string.
    ///Params:
    ///    pwszLanguageString = Pointer to a wide-character null-terminated string containing the language string.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetLanguage(PWSTR pwszLanguageString);
}

///The <b>IWMPacketSize</b> interface controls the maximum size of packets in an ASF file. Its methods are used to
///control the size of UDP datagrams when the content, live or on-demand, is streamed across a network. An
///<b>IWMPacketSize</b> interface can be obtained for either a profile object, a reader object, or a synchronous reader
///object. You can obtain a pointer to <b>IWMPacketSize</b> by calling the <b>QueryInterface</b> method of any of the
///other interfaces in one of the supported objects.
@GUID("CDFB97AB-188F-40B3-B643-5B7903975C59")
interface IWMPacketSize : IUnknown
{
    ///The <b>GetMaxPacketSize</b> method retrieves the maximum size of a packet in an ASF file.
    ///Params:
    ///    pdwMaxPacketSize = Pointer to a <b>DWORD</b> containing the maximum packet size, in bytes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pdwMaxPacketSize</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetMaxPacketSize(uint* pdwMaxPacketSize);
    ///The <b>SetMaxPacketSize</b> method specifies the maximum size of a packet in an ASF file.
    ///Params:
    ///    dwMaxPacketSize = <b>DWORD</b> containing the maximum packet size, in bytes. Set this to zero if the writer is to generate
    ///                      packets of various sizes. Otherwise, it must be a value between 100 bytes and 64 kilobytes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>dwMaxPacketSize</i> parameter contains
    ///    an invalid value for the maximum packet size. </td> </tr> </table>
    ///    
    HRESULT SetMaxPacketSize(uint dwMaxPacketSize);
}

///The <b>IWMPacketSize2</b> interface provides methods to set and retrieve the minimum packet size for a profile. An
///<b>IWMPacketSize2</b> interface can be obtained for either a profile object, a reader object, or a synchronous reader
///object. You can obtain a pointer to <b>IWMPacketSize2</b> by calling the <b>QueryInterface</b> method of any of the
///other interfaces in one of the supported objects.
@GUID("8BFC2B9E-B646-4233-A877-1C6A079669DC")
interface IWMPacketSize2 : IWMPacketSize
{
    ///The <b>GetMinPacketSize</b> method retrieves the minimum packet size for files created with the profile. If you
    ///use this method from an interface belonging to a reader or synchronous reader object, the retrieved minimum
    ///packet size will always be zero.
    ///Params:
    ///    pdwMinPacketSize = Pointer to a <b>DWORD</b> that will receive the minimum packet size.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL pointer argument. </td> </tr> </table>
    ///    
    HRESULT GetMinPacketSize(uint* pdwMinPacketSize);
    ///The <b>SetMinPacketSize</b> method sets the minimum packet size for files created with the profile. This method
    ///cannot be called from an interface belonging to a reader or synchronous reader object.
    ///Params:
    ///    dwMinPacketSize = <b>DWORD</b> specifying the new minimum packet size for files created with the profile.
    ///Returns:
    ///    This method always returns S_OK.
    ///    
    HRESULT SetMinPacketSize(uint dwMinPacketSize);
}

///The <b>IWMStreamList</b> interface is used by mutual exclusion objects and bandwidth sharing objects to maintain
///lists of streams. The IWMMutualExclusion and IWMBandwidthSharing interfaces each inherit from <b>IWMStreamList</b>.
///These are the only uses of this interface in the SDK. You never need to deal with interface pointers for
///<b>IWMStreamList</b> directly.
@GUID("96406BDD-2B2B-11D3-B36B-00C04F6108FF")
interface IWMStreamList : IUnknown
{
    ///The <b>GetStreams</b> method retrieves an array of stream numbers that make up the list.
    ///Params:
    ///    pwStreamNumArray = Pointer to a <b>WORD</b> array containing the stream numbers. Pass <b>NULL</b> to retrieve the required size
    ///                       of the array.
    ///    pcStreams = On input, a pointer to a variable containing the size of the <i>pwStreamNumArray</i> array. On output, if the
    ///                method succeeds, this variable contains the number of stream numbers entered into <i>pwStreamNumArray</i> by
    ///                the method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pcStreams</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The
    ///    input value of <i>pcStreams</i> is not large enough. </td> </tr> </table>
    ///    
    HRESULT GetStreams(ushort* pwStreamNumArray, ushort* pcStreams);
    ///The <b>AddStream</b> method adds a stream to the list.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number. Stream numbers are in the range of 1 through 63.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough available memory. </td>
    ///    </tr> </table>
    ///    
    HRESULT AddStream(ushort wStreamNum);
    ///The <b>RemoveStream</b> method removes a stream from the list.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number. Stream numbers are in the range of 1 through 63.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_NOMATCHING_ELEMENT</b></dt> </dl> </td> <td width="60%"> The <i>wStreamNum</i> parameter is
    ///    not valid. </td> </tr> </table>
    ///    
    HRESULT RemoveStream(ushort wStreamNum);
}

///The <b>IWMMutualExclusion</b> interface represents a group of streams, of which only one at a time can be played.
///<b>IWMMutualExclusion</b> is the base interface for mutual exclusion objects. You can create a mutual exclusion
///object only as part of a profile. Never use COM functions, such as <b>CoCreateInstance</b>, to create a mutual
///exclusion object. Instead, you must already have a profile opened and make a call to its
///IWMProfile::CreateNewMutualExclusion method. After a mutual exclusion object has been created, you can change the
///type of mutual exclusion by using the methods in this interface. You can manage the streams in a mutual exclusion
///object using the methods of the IWMStreamList interface. <b>IWMMutualExclusion</b> inherits from
///<b>IWMStreamList</b>, so those methods are directly available in this interface.
@GUID("96406BDE-2B2B-11D3-B36B-00C04F6108FF")
interface IWMMutualExclusion : IWMStreamList
{
    ///The <b>GetType</b> method retrieves the GUID of the type of mutual exclusion required.
    ///Params:
    ///    pguidType = Pointer to a GUID that specifies the type of mutual exclusion.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pguidType</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetType(GUID* pguidType);
    ///The <b>SetType</b> method specifies the GUID of the type of mutual exclusion required.
    ///Params:
    ///    guidType = GUID specifying the type of mutual exclusion. For a list of values, see IWMMutualExclusion::GetType
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid type. </td> </tr> </table>
    ///    
    HRESULT SetType(const(GUID)* guidType);
}

///The <b>IWMMutualExclusion2</b> interface provides advanced configuration features for mutual exclusion objects. This
///interface supports both multiple languages and advanced mutual exclusion. An <b>IWMMutualExclusion2</b> interface is
///created for each mutual exclusion object created. To retrieve a pointer to an <b>IWMMutualExclusion2</b> interface,
///call the <b>QueryInterface</b> method of the IWMMutualExclusion interface returned by
///IWMProfile::CreateNewMutualExclusion.
@GUID("0302B57D-89D1-4BA2-85C9-166F2C53EB91")
interface IWMMutualExclusion2 : IWMMutualExclusion
{
    ///The <b>GetName</b> method retrieves the name of the current mutual exclusion object. A mutual exclusion object
    ///has a name only if a name has been assigned using the IWMMutualExclusion2::SetName method.
    ///Params:
    ///    pwszName = Pointer to a wide-character <b>null</b>-terminated string containing the name of the mutual exclusion object.
    ///               Pass <b>NULL</b> to retrieve the length of the name.
    ///    pcchName = On input, a pointer to a variable containing the length of the <i>pwszName</i> array in wide characters (2
    ///               bytes). On output, if the method succeeds, the variable contains the length of the name, including the
    ///               terminating <b>null</b> character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pcchName</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetName(PWSTR pwszName, ushort* pcchName);
    ///The <b>SetName</b> method assigns a name to a mutual exclusion object.
    ///Params:
    ///    pwszName = Pointer to a wide-character null-terminated string containing the name you want to assign.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate memory to
    ///    hold the name. </td> </tr> </table>
    ///    
    HRESULT SetName(PWSTR pwszName);
    ///The <b>GetRecordCount</b> method retrieves the number of records present in the mutual exclusion object.
    ///Params:
    ///    pwRecordCount = Pointer to a <b>WORD</b> containing the number of records that exist in the mutual exclusion object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pwRecordCount</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetRecordCount(ushort* pwRecordCount);
    ///The <b>AddRecord</b> method adds a record to the mutual exclusion object. Records can hold groups of streams. You
    ///can add streams with calls to IWMMutualExclusion2::AddStreamForRecord. You can assign a name to a record with a
    ///call to IWMMutualExclusion2::SetName.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate memory for
    ///    the new record. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%">
    ///    There was a problem adding the new record to the collection of records for this mutual exclusion object.
    ///    </td> </tr> </table>
    ///    
    HRESULT AddRecord();
    ///The <b>RemoveRecord</b> method removes a record from the mutual exclusion object.
    ///Params:
    ///    wRecordNumber = <b>WORD</b> containing the number of the record to remove.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>wRecordNumber</i> parameter does not
    ///    contain a valid record number. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method is unable to access the record for an unspecified reason. </td> </tr> </table>
    ///    
    HRESULT RemoveRecord(ushort wRecordNumber);
    ///The <b>GetRecordName</b> method retrieves the name of the specified record. A record has a name only if a name
    ///has been assigned using the IWMMutualExclusion2::SetRecordName method.
    ///Params:
    ///    wRecordNumber = <b>WORD</b> containing the number of the record for which you want to get the name.
    ///    pwszRecordName = Pointer to a wide-character <b>null</b>-terminated string containing the record name. Pass <b>NULL</b> to
    ///                     retrieve the length of the name.
    ///    pcchRecordName = On input, a pointer to a variable containing the length of the <i>pwszRecordName</i> array in wide characters
    ///                     (2 bytes). On output, if the method succeeds, the variable contains the length of the name, including the
    ///                     terminating <b>null</b> character. However, if you pass <b>NULL</b> as <i>pwszRecordName</i>, this will be
    ///                     set to the required length on output.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>wRecordNumber</i> does not contain a valid
    ///    record number. OR <i>pcchRecordName</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method is unable to access the record for an
    ///    unspecified reason. </td> </tr> </table>
    ///    
    HRESULT GetRecordName(ushort wRecordNumber, PWSTR pwszRecordName, ushort* pcchRecordName);
    ///The <b>SetRecordName</b> method assigns a name to a record. You should assign a name to every record so that you
    ///can easily identify the records in the future.
    ///Params:
    ///    wRecordNumber = <b>WORD</b> containing the record number to which you want to assign a name.
    ///    pwszRecordName = Pointer to a wide-character null-terminated string containing the name you want to assign to the record.
    ///                     Record names are limited to 256 wide characters.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method was unable to allocate memory for
    ///    the name. </td> </tr> </table>
    ///    
    HRESULT SetRecordName(ushort wRecordNumber, PWSTR pwszRecordName);
    ///The <b>GetStreamsForRecord</b> method retrieves the list of streams that are present in a record.
    ///Params:
    ///    wRecordNumber = <b>WORD</b> containing the record number for which to retrieve the streams.
    ///    pwStreamNumArray = Pointer to an array that will receive the stream numbers. If it is <b>NULL</b>, <b>GetStreamsForRecord</b>
    ///                       will return the number of streams to <i>pcStreams</i>.
    ///    pcStreams = Pointer to a <b>WORD</b> containing the number of streams in the record.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pcStreams</i> is <b>NULL</b>. OR
    ///    <i>wRecordNumber</i> does not contain a valid record number. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The value passed as <i>pcStreams</i> is
    ///    smaller than the number of streams in the record. On exit with this error code, the value at <i>pcStreams</i>
    ///    will contain the correct number of streams. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt>
    ///    </dl> </td> <td width="60%"> The method is unable to access the record for an unspecified reason. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetStreamsForRecord(ushort wRecordNumber, ushort* pwStreamNumArray, ushort* pcStreams);
    ///The <b>AddStreamForRecord</b> method adds a stream to a record created with IWMMutualExclusion2::AddRecord.
    ///Params:
    ///    wRecordNumber = <b>WORD</b> containing the number of the record to which to add the stream.
    ///    wStreamNumber = <b>WORD</b> containing the stream number you want to add.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to allocate memory for
    ///    the new stream number. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>wRecordNumber</i> contains an invalid record number. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method is unable to access the record for an
    ///    unspecified reason. </td> </tr> </table>
    ///    
    HRESULT AddStreamForRecord(ushort wRecordNumber, ushort wStreamNumber);
    ///The <b>RemoveStreamForRecord</b> method removes a stream from a record's list.
    ///Params:
    ///    wRecordNumber = <b>WORD</b> containing the record number from which you want to remove a stream.
    ///    wStreamNumber = <b>WORD</b> containing the stream number you want to remove from the record.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_NOMATCHING_ELEMENT</b></dt> </dl> </td> <td width="60%"> The stream specified by
    ///    <i>wStreamNumber</i> does not appear in the record specified by <i>wRecordNumber</i>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>wRecordNumber</i> does not
    ///    contain a valid record number. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> The method is unable to access the record for an unspecified reason. </td> </tr> </table>
    ///    
    HRESULT RemoveStreamForRecord(ushort wRecordNumber, ushort wStreamNumber);
}

///The <b>IWMBandwidthSharing</b> interface contains methods to manage the properties of combined streams. The list of
///streams that share bandwidth is stored in the bandwidth sharing object. The streams can be manipulated using the
///methods of the IWMStreamList interface. <b>IWMBandwidthSharing</b> inherits from <b>IWMStreamList</b>, so the stream
///list manipulation methods are always exposed through this interface. The information in a bandwidth sharing object is
///purely informational. Nothing in the SDK seeks to enforce or check the accuracy of the bandwidth specified. You might
///want to use bandwidth sharing so that a reading application can make adjustments based on the information contained
///in the bandwidth sharing object. An <b>IWMBandwidthSharing</b> interface is exposed for each bandwidth sharing object
///upon creation. Bandwidth sharing objects are created using the IWMProfile3::CreateNewBandwidthSharing method.
@GUID("AD694AF1-F8D9-42F8-BC47-70311B0C4F9E")
interface IWMBandwidthSharing : IWMStreamList
{
    ///The <b>GetType</b> method retrieves the type of sharing for the bandwidth sharing object.
    ///Params:
    ///    pguidType = Pointer to a globally unique identifier specifying the type of combined stream to be used. This will be one
    ///                of the following values. <table> <tr> <th>Bandwidth sharing type </th> <th>Description </th> </tr> <tr>
    ///                <td>CLSID_WMBandwidthSharing_Exclusive</td> <td>Only one of the constituent streams can be active at any
    ///                given time.</td> </tr> <tr> <td>CLSID_WMBandwidthSharing_Partial</td> <td>The constituent streams can be
    ///                active simultaneously.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The pointer passed is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetType(GUID* pguidType);
    ///The <b>SetType</b> method sets the type of sharing (exclusive or partial) for the bandwidth sharing object.
    ///Params:
    ///    guidType = Globally unique identifier specifying the type of combined stream to be used. The only valid GUIDs are those
    ///               in the following table. <table> <tr> <th>Bandwidth sharing type </th> <th>Description </th> </tr> <tr>
    ///               <td>CLSID_WMBandwidthSharing_Exclusive</td> <td>Only one of the constituent streams can be active at any
    ///               given time.</td> </tr> <tr> <td>CLSID_WMBandwidthSharing_Partial</td> <td>The constituent streams can be
    ///               active simultaneously.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The GUID passed in <i>guidType</i> is any
    ///    value other than CLSID_BandwidthSharingExclusive or CLSID_BandwidthSharingPartial. </td> </tr> </table>
    ///    
    HRESULT SetType(const(GUID)* guidType);
    ///The <b>GetBandwidth</b> method retrieves the bandwidth and maximum buffer size of a combined stream.
    ///Params:
    ///    pdwBitrate = Pointer to a <b>DWORD</b> containing the bit rate in bits per second. The combined bandwidths of the streams
    ///                 cannot exceed this value.
    ///    pmsBufferWindow = Pointer to <b>DWORD</b> containing the buffer window in milliseconds. The combined buffer sizes of the
    ///                      streams cannot exceed this value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or both of the parameters are <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetBandwidth(uint* pdwBitrate, uint* pmsBufferWindow);
    ///The <b>SetBandwidth</b> method sets the bandwidth and maximum buffer size for a combined stream.
    ///Params:
    ///    dwBitrate = <b>DWORD</b> containing the bit rate in bits per second. The combined bandwidths of the streams cannot exceed
    ///                this value.
    ///    msBufferWindow = Specifies the buffer window in milliseconds. The combined buffer sizes of the streams cannot exceed this
    ///                     value.
    ///Returns:
    ///    This method always returns S_OK.
    ///    
    HRESULT SetBandwidth(uint dwBitrate, uint msBufferWindow);
}

///The <b>IWMStreamPrioritization</b> interface provides methods to set and read priority records for a file. Stream
///prioritization allows content creators to specify the priority of the streams in an ASF file. The streams assigned
///the lowest priority will be dropped first in the case of insufficient bit rate during playback. Only one stream
///prioritization object can exist for a profile. You can check to see if one is present with a call to
///IWMProfile3::GetStreamPrioritization, which will retrieve a pointer to one if it exists. You can create a new stream
///prioritization object with a call to IWMProfile3::CreateNewStreamPrioritization. You will then receive a pointer to
///<b>IWMStreamPrioritization</b> for the new object. This will erase the existing stream prioritization, if there is
///one.
@GUID("8C1C6090-F9A8-4748-8EC3-DD1108BA1E77")
interface IWMStreamPrioritization : IUnknown
{
    ///The <b>GetPriorityRecords</b> method retrieves the list of streams and their priorities from the profile.
    ///Params:
    ///    pRecordArray = Pointer to an array of <b>WM_STREAM_PRIORITY_RECORD</b> structures. This array will receive the current
    ///                   stream priority data.
    ///    pcRecords = Pointer to a <b>WORD</b> that receives the count of records.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pcRecords</i> is <b>NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> <i>pcRecords</i>
    ///    specifies fewer records than exist in the stream prioritization object. </td> </tr> </table>
    ///    
    HRESULT GetPriorityRecords(WM_STREAM_PRIORITY_RECORD* pRecordArray, ushort* pcRecords);
    ///The <b>SetPriorityRecords</b> method assigns the members of an array as the stream priority list in the stream
    ///prioritization object.
    ///Params:
    ///    pRecordArray = Pointer to an array of WM_STREAM_PRIORITY_RECORD structures.
    ///    cRecords = Count of records.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>cRecords</i> specifies a record count
    ///    greater than zero, but <i>pRecordArray</i> is <b>NULL</b>. OR One of the array rules has been broken (see the
    ///    Remarks section). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> The method is unable to allocate the memory required to store the array in the stream
    ///    prioritization object. </td> </tr> </table>
    ///    
    HRESULT SetPriorityRecords(WM_STREAM_PRIORITY_RECORD* pRecordArray, ushort cRecords);
}

///The <b>IWMWriterAdvanced</b> interface provides advanced writing functionality. This interface exists for every
///instance of the writer object. To obtain a pointer to this interface, call <b>QueryInterface</b> on the writer
///object.
@GUID("96406BE3-2B2B-11D3-B36B-00C04F6108FF")
interface IWMWriterAdvanced : IUnknown
{
    ///The <b>GetSinkCount</b> method retrieves the number of writer sinks associated with the writer object. To obtain
    ///a pointer to an interface of an individual sink, call IWMWriterAdvanced::GetSink using a sink number between 0
    ///and one less than the count returned by this method.
    ///Params:
    ///    pcSinks = DWORD indicating the total number of sinks associated with the writer object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pcSinks</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetSinkCount(uint* pcSinks);
    ///The <b>GetSink</b> method retrieves a writer sink object. Used in conjunction with
    ///IWMWriterAdvanced::GetSinkCount, this method can be used to enumerate the sinks associated with a writer object.
    ///Params:
    ///    dwSinkNum = <b>DWORD</b> containing the sink number (its index). This is a number between 0 and one less than the total
    ///                number of sinks associated with the file as obtained with <b>IWMWriterAdvanced::GetSinkCount</b>.
    ///    ppSink = Pointer to a pointer to an IWMWriterSink interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Either the <i>ppSink</i> parameter is
    ///    <b>NULL</b>, or the <i>dwSinkNum</i> parameter is greater than the number of sinks. </td> </tr> </table>
    ///    
    HRESULT GetSink(uint dwSinkNum, IWMWriterSink* ppSink);
    ///The <b>AddSink</b> method adds a writer sink to receive writer output. The Windows Media Format SDK supports
    ///<i>file sinks</i>, which create ASF files on disk; <i>network sinks</i>, which stream ASF content across a
    ///network; and <i>push sinks</i>, which deliver ASF content to other media servers. To create a sink object, call
    ///one of the following functions: <table> <tr> <th>Sink </th> <th>Function </th> </tr> <tr> <td>File sink</td> <td>
    ///WMCreateWriterFileSink </td> </tr> <tr> <td>Network sink</td> <td> WMCreateWriterNetworkSink </td> </tr> <tr>
    ///<td>Push sink</td> <td> WMCreateWriterPushSink </td> </tr> </table> New sinks must be added to the writer with
    ///this method before they can be used.
    ///Params:
    ///    pSink = Pointer to an IWMWriterSink interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pSink</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The
    ///    writer is not in a configurable state. </td> </tr> </table>
    ///    
    HRESULT AddSink(IWMWriterSink pSink);
    ///The <b>RemoveSink</b> method removes a writer sink object.
    ///Params:
    ///    pSink = Pointer to the IWMWriterSink interface of the sink object to remove, or <b>NULL</b> to remove all sinks.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Could not remove the specified sink. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The writer is not
    ///    in a configurable state. </td> </tr> </table>
    ///    
    HRESULT RemoveSink(IWMWriterSink pSink);
    ///The <b>WriteStreamSample</b> method writes a stream sample directly into an ASF file, bypassing the normal
    ///compression procedures. Use this method when writing a compressed stream if you already have the compressed
    ///samples. The most common use of <b>WriteStreamSample</b> is in copying streams from one file to another.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number. Stream numbers are in the range of 1 through 63.
    ///    cnsSampleTime = <b>QWORD</b> containing the sample time, in 100-nanosecond units.
    ///    msSampleSendTime = <b>DWORD</b> containing the sample send time, in milliseconds. This parameter is not used.
    ///    cnsSampleDuration = <b>QWORD</b> containing the sample duration, in 100-nanosecond units. This parameter is not used.
    ///    dwFlags = <b>DWORD</b> containing one or more of the following flags. <table> <tr> <th>Flag </th> <th>Description </th>
    ///              </tr> <tr> <td>No flag set</td> <td>None of the conditions for the other flags applies. For example, a delta
    ///              frame in most cases would not have any flags set for it.</td> </tr> <tr> <td>WM_SF_CLEANPOINT</td>
    ///              <td>Indicates the sample is a key frame. Set this flag if and only if the compressed input sample is a key
    ///              frame.</td> </tr> <tr> <td>WM_SF_DISCONTINUITY</td> <td>For audio inputs, this flag helps to deal with gaps
    ///              that may appear between samples. You should set this flag for the first sample after a gap.</td> </tr> <tr>
    ///              <td>WM_SF_DATALOSS</td> <td>This flag is not used by the writer object.</td> </tr> </table>
    ///    pSample = Pointer to an INSSBuffer interface representing the sample.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The writer cannot currently be run.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> The
    ///    sample is not valid. This can occur when an input script stream contains a script sample that is not valid.
    ///    </td> </tr> </table>
    ///    
    HRESULT WriteStreamSample(ushort wStreamNum, ulong cnsSampleTime, uint msSampleSendTime, 
                              ulong cnsSampleDuration, uint dwFlags, INSSBuffer pSample);
    ///The <b>SetLiveSource</b> method sets a flag indicating whether the source is live.
    ///Params:
    ///    fIsLiveSource = Boolean value that is True if the source is live.
    ///Returns:
    ///    This method always returns S_OK.
    ///    
    HRESULT SetLiveSource(BOOL fIsLiveSource);
    ///The <b>IsRealTime</b> method ascertains whether the writer is running in real time.
    ///Params:
    ///    pfRealTime = Pointer to a Boolean value that is True if the writer is running in real time.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pfRealTime</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT IsRealTime(BOOL* pfRealTime);
    ///The <b>GetWriterTime</b> method retrieves the clock time that the writer is working to.
    ///Params:
    ///    pcnsCurrentTime = Pointer to a variable containing the current time in 100-nanosecond units.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pcnsCurrentTime</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetWriterTime(ulong* pcnsCurrentTime);
    ///The <b>GetStatistics</b> method retrieves statistics describing the current writing operation.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number. Stream numbers must be in the range of 1 through 63. A value of 0
    ///                 retrieves statistics for the file as a whole.
    ///    pStats = Pointer to a WM_WRITER_STATISTICS structure that receives the statistics.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pStats</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetStatistics(ushort wStreamNum, WM_WRITER_STATISTICS* pStats);
    ///The <b>SetSyncTolerance</b> method sets the amount of time that the inputs can fall out of synchronization before
    ///the samples are discarded.
    ///Params:
    ///    msWindow = Amount of time that the inputs can be out of synchronization, in milliseconds. Note that this parameter is in
    ///               milliseconds and not 100-nanosecond units.
    ///Returns:
    ///    This method always returns S_OK.
    ///    
    HRESULT SetSyncTolerance(uint msWindow);
    ///The <b>GetSyncTolerance</b> method retrieves the amount of time during which the inputs can fall out of
    ///synchronization before the samples are discarded.
    ///Params:
    ///    pmsWindow = Pointer to the limit of the number of milliseconds that the inputs can be out of synchronization. Note that
    ///                this parameter is in milliseconds and not 100-nanosecond units.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pmsWindow</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetSyncTolerance(uint* pmsWindow);
}

///The <b>IWMWriterAdvanced2</b> interface provides the ability to set and retrieve named settings for an input.
///<b>IWMWriterAdvanced2</b> exists for every instance of the writer object. To obtain a pointer to this interface, call
///<b>QueryInterface</b> on the writer object.
@GUID("962DC1EC-C046-4DB8-9CC7-26CEAE500817")
interface IWMWriterAdvanced2 : IWMWriterAdvanced
{
    ///The <b>GetInputSetting</b> method retrieves a setting for a particular input by name.
    ///Params:
    ///    dwInputNum = <b>DWORD</b> containing the input number.
    ///    pszName = Pointer to a wide-character <b>null</b>-terminated string containing the setting name. For a list of valid
    ///              settings, see Input Settings.
    ///    pType = Pointer to a value from the WMT_ATTR_DATATYPE enumeration type.
    ///    pValue = Pointer to a byte array containing the setting. The type of date is determined by <i>pType</i>. Pass
    ///             <b>NULL</b> to retrieve the size of array required.
    ///    pcbLength = On input, pointer to the length of <i>pValue</i>. On output, pointer to a count of the bytes in <i>pValue</i>
    ///                filled in by this method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_NOT_CONFIGURED</b></dt> </dl> </td> <td width="60%"> The input profile has not yet been set.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>dwInputNum</i> is larger than the number of existing inputs OR <i>pType</i>, <i>pcbLength</i>, or
    ///    <i>pszName</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetInputSetting(uint dwInputNum, const(PWSTR) pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, 
                            ushort* pcbLength);
    ///The <b>SetInputSetting</b> method specifies a named setting for a particular input.
    ///Params:
    ///    dwInputNum = <b>DWORD</b> containing the input number.
    ///    pszName = Pointer to a wide-character <b>null</b>-terminated string containing the setting name. For a list of valid
    ///              settings, see Input Settings.
    ///    Type = Pointer to a value from the WMT_ATTR_DATATYPE enumeration type.
    ///    pValue = Pointer to a byte array containing the setting.
    ///    cbLength = Size of <i>pValue</i>, in bytes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_NOT_CONFIGURED</b></dt> </dl> </td> <td width="60%"> The input profile has not yet been set.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>dwInputNum</i> is larger than the number of existing inputs OR <i>pValue</i> or <i>pszName</i> is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td
    ///    width="60%"> This setting cannot be changed while the writer is running. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unspecified error. </td> </tr> </table>
    ///    
    HRESULT SetInputSetting(uint dwInputNum, const(PWSTR) pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, 
                            ushort cbLength);
}

///The <b>IWMWriterAdvanced3</b> interface provides additional functionality for the writer object.
///<b>IWMWriterAdvanced3</b> exists for every instance of the writer object. To obtain a pointer to this interface, call
///<b>QueryInterface</b> on the writer object.
@GUID("2CD6492D-7C37-4E76-9D3B-59261183A22E")
interface IWMWriterAdvanced3 : IWMWriterAdvanced2
{
    ///The <b>GetStatisticsEx</b> method retrieves extended statistics for the writer.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number for which you want to get statistics. You can pass 0 to obtain
    ///                 extended statistics for the entire file. Stream numbers are in the range of 1 through 63.
    ///    pStats = Pointer to the WM_WRITER_STATISTICS_EX structure that receives the statistics.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> The writer is in the configuration
    ///    state, during which this method cannot be called. </td> </tr> </table>
    ///    
    HRESULT GetStatisticsEx(ushort wStreamNum, WM_WRITER_STATISTICS_EX* pStats);
    ///The <b>SetNonBlocking</b> method configures the writer so that the calling thread is not blocked while writing
    ///samples.
    ///Returns:
    ///    The method always returns S_OK.
    ///    
    HRESULT SetNonBlocking();
}

///The <b>IWMWriterPreprocess</b> interface handles multi-pass encoding. By making more than one pass, the writer can
///obtain better quality with better compression. An <b>IWMWriterPreprocess</b> interface exists for every instance of
///the writer object. You can obtain a pointer to <b>IWMWriterPreprocess</b> with a call to the <b>QueryInterface</b>
///method of any other interface in the writer object.
@GUID("FC54A285-38C4-45B5-AA23-85B9F7CB424B")
interface IWMWriterPreprocess : IUnknown
{
    ///The <b>GetMaxPreprocessingPasses</b> method retrieves the maximum number of preprocessing passes for a specified
    ///input stream.
    ///Params:
    ///    dwInputNum = <b>DWORD</b> containing the input number for which you want to get the maximum number of preprocessing
    ///                 passes.
    ///    dwFlags = Reserved. Set to zero.
    ///    pdwMaxNumPasses = Pointer to a <b>DWORD</b> that will receive the maximum number of preprocessing passes. If the codec supports
    ///                      two-pass encoding, this value is 1, as the final pass is not counted.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pdwMaxNumPasses</i> is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>dwInputNum</i>
    ///    specifies an invalid input stream number. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> The writer is not running. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetMaxPreprocessingPasses(uint dwInputNum, uint dwFlags, uint* pdwMaxNumPasses);
    ///The <b>SetNumPreprocessingPasses</b> method sets the number of passes to perform on an input.
    ///Params:
    ///    dwInputNum = <b>DWORD</b> containing the input number for which you want to set the number of passes.
    ///    dwFlags = Reserved. Set to zero.
    ///    dwNumPasses = <b>DWORD</b> containing the number of preprocessing passes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>dwNumPasses</i> is zero. OR
    ///    <i>dwInputNum</i> specifies an invalid input stream. OR <i>dwNumPasses</i> is greater than the maximum number
    ///    of passes allowed for the specified input. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> The writer is not running. OR The
    ///    preprocessor has already been configured. </td> </tr> </table>
    ///    
    HRESULT SetNumPreprocessingPasses(uint dwInputNum, uint dwFlags, uint dwNumPasses);
    ///The <b>BeginPreprocessingPass</b> method prepares the writer to begin preprocessing samples for the specified
    ///input stream.
    ///Params:
    ///    dwInputNum = <b>DWORD</b> containing the input number that you want to preprocess.
    ///    dwFlags = Reserved. Set to zero.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>dwInputNum</i> specifies an invalid input
    ///    number. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td
    ///    width="60%"> The writer is not running. OR The preprocessor is neither waiting to be run nor stopped in the
    ///    middle of a pass. OR The preprocessor has already made as many passes as specified by
    ///    SetNumPreprocessingPasses. OR The input specified is not supported for preprocessing. </td> </tr> </table>
    ///    
    HRESULT BeginPreprocessingPass(uint dwInputNum, uint dwFlags);
    ///The <b>PreprocessSample</b> method delivers a sample to the writer for preprocessing.
    ///Params:
    ///    dwInputNum = <b>DWORD</b> containing the input number of the sample.
    ///    cnsSampleTime = Specifies the presentation time of the sample in 100-nanosecond units.
    ///    dwFlags = Reserved. Set to zero.
    ///    pSample = Pointer to an INSSBuffer interface on an object that contains the sample.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>dwInputNum</i> specifies an invalid input
    ///    stream. OR <i>pSample</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> The writer is not running. OR The
    ///    preprocessor is neither waiting to be run nor stopped in the middle of a pass. OR The preprocessor has
    ///    already made as many passes as specified by SetNumPreprocessingPasses. OR The input specified is not
    ///    supported for preprocessing. </td> </tr> </table>
    ///    
    HRESULT PreprocessSample(uint dwInputNum, ulong cnsSampleTime, uint dwFlags, INSSBuffer pSample);
    ///The <b>EndPreprocessingPass</b> method ends a preprocessing pass started with a call to
    ///IWMWriterPreprocess::BeginPreprocessingPass.
    ///Params:
    ///    dwInputNum = <b>DWORD</b> containing the input number for which you want to halt preprocessing.
    ///    dwFlags = Reserved. Set to zero.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>dwInputNum</i> specifies an invalid input
    ///    number. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td
    ///    width="60%"> The writer is not running. OR The preprocessor is not started for the specified stream. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> There was an error
    ///    ending the preprocessing path. </td> </tr> </table>
    ///    
    HRESULT EndPreprocessingPass(uint dwInputNum, uint dwFlags);
}

///The <b>IWMWriterPostViewCallback</b> interface manages the receiving of uncompressed samples from the writer.
///Postview can be used only for video streams. This interface must be implemented by the application and passed to
///IWMWriterPostView::SetPostViewCallback.
@GUID("D9D6549D-A193-4F24-B308-03123D9B7F8D")
interface IWMWriterPostViewCallback : IWMStatusCallback
{
    ///The <b>OnPostViewSample</b> method is called when new postview data is available. The application implements this
    ///method.
    ///Params:
    ///    wStreamNumber = <b>WORD</b> containing the stream number.
    ///    cnsSampleTime = Sample time, in 100-nanosecond units.
    ///    cnsSampleDuration = Sample duration, in 100-nanosecond units. This will usually be 10000 (1 millisecond).
    ///    dwFlags = <b>DWORD</b> containing none, one, or more of the following flags. <table> <tr> <th>Flag </th>
    ///              <th>Description </th> </tr> <tr> <td>No flag set</td> <td>None of the conditions for the other flags applies.
    ///              For example, a delta frame in most cases would not have any flags set for it.</td> </tr> <tr>
    ///              <td>WM_SF_CLEANPOINT</td> <td>This is basically the same as a key frame. It indicates a good point to go to
    ///              during a seek, for example.</td> </tr> <tr> <td>WM_SF_DISCONTINUITY</td> <td>The data stream has a gap in it,
    ///              which could be due to a seek, a network loss, or some other reason. This can be useful extra information for
    ///              an application such as a codec or renderer. The flag is set on the first piece of data following the
    ///              gap.</td> </tr> <tr> <td>WM_SF_DATALOSS</td> <td>Some data has been lost between the previous sample and the
    ///              sample with this flag set.</td> </tr> </table>
    ///    pSample = Pointer to an INSSBuffer interface on an object that contains the sample.
    ///    pvContext = Generic pointer, for use by the application.
    ///Returns:
    ///    This method is implemented by the application. It should return S_OK.
    ///    
    HRESULT OnPostViewSample(ushort wStreamNumber, ulong cnsSampleTime, ulong cnsSampleDuration, uint dwFlags, 
                             INSSBuffer pSample, void* pvContext);
    ///The <b>AllocateForPostView</b> method allocates a buffer for use in postviewing operations. The application
    ///implements this method.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number.
    ///    cbBuffer = Size of <i>ppBuffer</i>, in bytes.
    ///    ppBuffer = Pointer to a pointer to an INSSBuffer interface.
    ///    pvContext = Generic pointer, for use by the application.
    ///Returns:
    ///    This method is implemented by the application. It should return S_OK.
    ///    
    HRESULT AllocateForPostView(ushort wStreamNum, uint cbBuffer, INSSBuffer* ppBuffer, void* pvContext);
}

///The <b>IWMWriterPostView</b> interface manages advanced writing functionality related to the postviewing of samples.
///Postviewing displays the media samples as a viewer of the ASF file would see them, and is often used after encoding
///to check the output. Postviewing is supported only for video. This interface can be obtained from any interface on
///the writer object by calling <b>QueryInterface</b>.
@GUID("81E20CE4-75EF-491A-8004-FC53C45BDC3E")
interface IWMWriterPostView : IUnknown
{
    ///The <b>SetPostViewCallback</b> method specifies the callback interface to use for receiving postview samples.
    ///Params:
    ///    pCallback = Pointer to an IWMWriterPostViewCallback interface.
    ///    pvContext = Generic pointer, for use by the application.
    ///Returns:
    ///    This method always returns S_OK.
    ///    
    HRESULT SetPostViewCallback(IWMWriterPostViewCallback pCallback, void* pvContext);
    ///The <b>SetReceivePostViewSamples</b> method enables or disables delivery of postview samples for the specified
    ///stream.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number.
    ///    fReceivePostViewSamples = Boolean value that is True if postview samples must be delivered.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>wStreamNum</i> is less than 1 or greater
    ///    than the maximum number of streams. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_INVALID_STREAM</b></dt> </dl> </td> <td width="60%"> Could not get the output for that stream.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%">
    ///    Stream does not support postview. </td> </tr> </table>
    ///    
    HRESULT SetReceivePostViewSamples(ushort wStreamNum, BOOL fReceivePostViewSamples);
    ///The <b>GetReceivePostViewSamples</b> method retrieves a flag indicating whether delivery of postview samples has
    ///been turned on for the specified stream.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number.
    ///    pfReceivePostViewSamples = Pointer to a flag; True indicates that postview samples are to be delivered.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL value passed to
    ///    <i>pfReceivePostViewSamples</i>. </td> </tr> </table>
    ///    
    HRESULT GetReceivePostViewSamples(ushort wStreamNum, BOOL* pfReceivePostViewSamples);
    ///The <b>GetPostViewProps</b> method retrieves the properties for the specified output stream.
    ///Params:
    ///    wStreamNumber = <b>WORD</b> containing the stream number.
    ///    ppOutput = Pointer to a pointer to an IWMMediaProps interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL value passed in to <i>ppOutput</i>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetPostViewProps(ushort wStreamNumber, IWMMediaProps* ppOutput);
    ///The <b>SetPostViewProps</b> method specifies the format for the specified output stream.
    ///Params:
    ///    wStreamNumber = <b>WORD</b> containing the stream number.
    ///    pOutput = Pointer to an IWMMediaProps interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_STREAM</b></dt> </dl> </td> <td width="60%"> The stream number specified by
    ///    <i>wStreamNumber</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
    ///    </td> <td width="60%"> The method was unable to create an internal structure. </td> </tr> </table>
    ///    
    HRESULT SetPostViewProps(ushort wStreamNumber, IWMMediaProps pOutput);
    ///The <b>GetPostViewFormatCount</b> method is used for ascertaining all possible format types supported for the
    ///specified stream.
    ///Params:
    ///    wStreamNumber = <b>WORD</b> containing the stream number.
    ///    pcFormats = Pointer to a count of the output formats.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL value passed in to <i>pcFormats</i>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetPostViewFormatCount(ushort wStreamNumber, uint* pcFormats);
    ///The <b>GetPostViewFormat</b> method retrieves the media properties for the specified output stream and output
    ///format.
    ///Params:
    ///    wStreamNumber = <b>WORD</b> containing the stream number.
    ///    dwFormatNumber = <b>DWORD</b> containing the format number.
    ///    ppProps = Pointer to a pointer to an IWMMediaProps interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL value passed in to <i>ppProps</i>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory
    ///    to complete the task. </td> </tr> </table>
    ///    
    HRESULT GetPostViewFormat(ushort wStreamNumber, uint dwFormatNumber, IWMMediaProps* ppProps);
    ///The <b>SetAllocateForPostView</b> method specifies whether the application, and not the writer, must supply the
    ///buffers.
    ///Params:
    ///    wStreamNumber = <b>WORD</b> containing the stream number.
    ///    fAllocate = Boolean value. Set to True if the application allocates buffers, and False if this is left to the reader.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_STREAM</b></dt> </dl> </td> <td width="60%"> The stream number specified by
    ///    <i>wStreamNumber</i> is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
    ///    </td> <td width="60%"> The method was unable to create an internal structure. </td> </tr> </table>
    ///    
    HRESULT SetAllocateForPostView(ushort wStreamNumber, BOOL fAllocate);
    ///The <b>GetAllocateForPostView</b> method ascertains whether the application, and not the writer, must supply the
    ///buffers.
    ///Params:
    ///    wStreamNumber = <b>WORD</b> containing the stream number.
    ///    pfAllocate = Pointer to Boolean value that is True if the application allocates buffers, and False if this is left to the
    ///                 writer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL value passed in to <i>pfAllocate</i>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetAllocateForPostView(ushort wStreamNumber, BOOL* pfAllocate);
}

///The <b>IWMWriterSink</b> interface is the basic interface of all writer sinks, including the file, network, and push
///sinks defined in the Windows Media Format SDK, and custom sinks. If you are using one of the defined writer sinks,
///you never need to deal with the methods of this interface. If you are creating your own custom writer sink, you must
///implement these methods in your application. This interface exists on the writer file sink object, the writer network
///sink object, and the writer push sink object. You should never obtain a pointer to this interface from one of these
///objects, however, as its methods are called internally by the writer sink objects and the writer object. You can
///create a class in your application that inherits from this interface to make your own sink.
@GUID("96406BE4-2B2B-11D3-B36B-00C04F6108FF")
interface IWMWriterSink : IUnknown
{
    ///The <b>OnHeader</b> method is called by the writer when the ASF header is ready for the sink.
    ///Params:
    ///    pHeader = Pointer to an INSSBuffer interface on an object containing the ASF header.
    ///Returns:
    ///    This method is implemented by the application. It should always return S_OK.
    ///    
    HRESULT OnHeader(INSSBuffer pHeader);
    ///The <b>IsRealTime</b> is called by the writer to determine whether the sink needs data units to be delivered in
    ///real time. It is up to you to decide whether your custom sink requires real-time delivery.
    ///Params:
    ///    pfRealTime = Pointer to a Boolean value that is True if the sink requires real time data unit delivery.
    ///Returns:
    ///    This method is implemented by the application. It should always return S_OK.
    ///    
    HRESULT IsRealTime(BOOL* pfRealTime);
    ///The <b>AllocateDataUnit</b> method is called by the writer object when it needs a buffer to deliver a data unit.
    ///Your implementation of this method returns a buffer of at least the size passed in. You can manage buffers
    ///internally in any way that you like. The simplest method is to create a new buffer object for each call, but
    ///doing so is quite inefficient. Instead, most sinks maintain several buffers that are reused.
    ///Params:
    ///    cbDataUnit = Size of the data unit that the writer needs to deliver, in bytes. The buffer you assign to <i>ppDataUnit</i>
    ///                 must be this size or bigger.
    ///    ppDataUnit = On return, set to a pointer to the INSSBuffer interface of a buffer object.
    ///Returns:
    ///    This method is implemented by the application. It should always return S_OK.
    ///    
    HRESULT AllocateDataUnit(uint cbDataUnit, INSSBuffer* ppDataUnit);
    ///The <b>OnDataUnit</b> method is called by the writer when a data unit is ready for the sink. How your application
    ///handles the data unit depends upon the destination of the content.
    ///Params:
    ///    pDataUnit = Pointer to an INSSBuffer interface on an object containing the data unit.
    ///Returns:
    ///    This method is implemented by the application. It should always return S_OK.
    ///    
    HRESULT OnDataUnit(INSSBuffer pDataUnit);
    ///The <b>OnEndWriting</b> method is called by the writer when writing is complete. This method should conclude
    ///operations for your sink. For example, the writer file sink closes and indexes the file.
    ///Returns:
    ///    This method is implemented by the application. It should always return S_OK.
    ///    
    HRESULT OnEndWriting();
}

///The <b>IWMRegisterCallback</b> interface enables the application to get status messages from a sink object. By
///default, the writer object does not send the application any status messages from the sink object. To get status
///messages from a sink object, the application must query the sink object for the <b>IWMRegisterCallback</b> interface
///and call the <b>Advise</b> method. The file sink object, the network sink object, and the push sink object all expose
///this interface. To obtain a pointer to this interface for a sink, call <b>QueryInterface</b> on any of these sink
///objects.
@GUID("CF4B1F99-4DE2-4E49-A363-252740D99BC1")
interface IWMRegisterCallback : IUnknown
{
    ///The <b>Advise</b> method registers the application to receive status messages from the sink object.
    ///Params:
    ///    pCallback = Pointer to the application's IWMStatusCallback interface. The application must implement this interface.
    ///    pvContext = Generic pointer, for use by the application. This is passed to the application in calls to <b>OnStatus</b>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Advise(IWMStatusCallback pCallback, void* pvContext);
    ///The <b>Unadvise</b> method unregisters the application's <b>IWMStatusCallback</b> callback interface. Call this
    ///method when the application has finished using the sink object. It notifies the object to stop sending status
    ///events to the application.
    ///Params:
    ///    pCallback = Pointer to the IWMStatusCallback interface of an object.
    ///    pvContext = Generic pointer, for use by the application.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Unadvise(IWMStatusCallback pCallback, void* pvContext);
}

///The <b>IWMWriterFileSink</b> interface is used to open a file to which the writer can write data. The file sink
///object exposes this interface. To create the file sink object, call the WMCreateWriterFileSink function.
@GUID("96406BE5-2B2B-11D3-B36B-00C04F6108FF")
interface IWMWriterFileSink : IWMWriterSink
{
    ///The <b>Open</b> method opens a file that acts as the writer sink.
    ///Params:
    ///    pwszFilename = Pointer to a wide-character <b>null</b>-terminated string containing the file name. URLs are not supported.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pwszFilename</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT Open(const(PWSTR) pwszFilename);
}

///The <b>IWMWriterFileSink2</b> interface provides extended management of a file sink. This interface can be obtained
///by calling the <b>QueryInterface</b> method of an <b>IWMWriterFileSink</b> interface.
@GUID("14282BA7-4AEF-4205-8CE5-C229035A05BC")
interface IWMWriterFileSink2 : IWMWriterFileSink
{
    ///The <b>Start</b> method starts recording at the specified time.
    ///Params:
    ///    cnsStartTime = Start time in 100-nanosecond units.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> The requested start time precedes the
    ///    last stop time. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Not enough memory to complete the task. </td> </tr> </table>
    ///    
    HRESULT Start(ulong cnsStartTime);
    ///The <b>Stop</b> method stops recording at the specified time.
    ///Params:
    ///    cnsStopTime = Stop time in 100-nanosecond units.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Stop(ulong cnsStopTime);
    ///The <b>IsStopped</b> method ascertains whether the file sink has stopped writing.
    ///Params:
    ///    pfStopped = Pointer to a Boolean value that is set to True if writing has stopped.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pfStopped</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT IsStopped(BOOL* pfStopped);
    ///The <b>GetFileDuration</b> method retrieves the duration of the portion of the file that has been written.
    ///Params:
    ///    pcnsDuration = Pointer to variable specifying the duration, in 100-nanosecond units.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pcnsDuration</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetFileDuration(ulong* pcnsDuration);
    ///The <b>GetFileSize</b> method retrieves the size of the file.
    ///Params:
    ///    pcbFile = Pointer to a count of the bytes in the file.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pcbFile</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetFileSize(ulong* pcbFile);
    ///The <b>Close</b> method closes the sink.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Close();
    ///The <b>IsClosed</b> method ascertains whether the file sink has been closed.
    ///Params:
    ///    pfClosed = Pointer to a Boolean value that is set to True if the file sink has been closed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pfClosed</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT IsClosed(BOOL* pfClosed);
}

///The <b>IWMWriterFileSink3</b> interface provides additional functionality to the file sink object. To obtain a
///pointer to this interface, call <b>QueryInterface</b> on the file sink object.
@GUID("3FEA4FEB-2945-47A7-A1DD-C53A8FC4C45C")
interface IWMWriterFileSink3 : IWMWriterFileSink2
{
    ///The <b>SetAutoIndexing</b> method enables or disables automatic indexing of the file.
    ///Params:
    ///    fDoAutoIndexing = Boolean value that is True to automatically index the file.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> The header has already been received
    ///    </td> </tr> </table>
    ///    
    HRESULT SetAutoIndexing(BOOL fDoAutoIndexing);
    ///The <b>GetAutoIndexing</b> method retrieves the current state of automatic indexing for the file. The writer
    ///object creates a time-based index for all new files by default. If you generate an ASF file using bit-rate mutual
    ///exclusion for audio content (multiple bit-rate audio), the resulting indexed file will not work with Windows
    ///Media Services version 4.1. If you want to stream your file using Windows Media Services 4.1, you must make sure
    ///that automatic indexing has been disabled before writing the file.
    ///Params:
    ///    pfAutoIndexing = Pointer to a Boolean value that is True if automatic indexing is enabled for the file.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pfAutoIndexing</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetAutoIndexing(BOOL* pfAutoIndexing);
    ///The <b>SetControlStream</b> method enables you to specify that a stream should be used as a control stream. You
    ///can also use this method to indicate that a previously specified control stream should no longer be used as a
    ///control stream.
    ///Params:
    ///    wStreamNumber = A <b>WORD</b> specifying the stream number to configure. Stream numbers must be in the range of 1 through 63.
    ///    fShouldControlStartAndStop = A BOOL specifying whether or not the stream should be used as a control stream.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The stream number specified by
    ///    <i>wStreamNumber</i> is greater than the maximum. </td> </tr> </table>
    ///    
    HRESULT SetControlStream(ushort wStreamNumber, BOOL fShouldControlStartAndStop);
    ///The <b>GetMode</b> method retrieves the supported file sink mode. More than one mode can be supported.
    ///Params:
    ///    pdwFileSinkMode = Pointer to a <b>DWORD</b> containing a value from the WMT_FILESINK_MODE enumeration type or multiple values
    ///                      combined with a bitwise <b>OR</b> operator.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pdwFileSinkMode</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetMode(uint* pdwFileSinkMode);
    ///The <b>OnDataUnitEx</b> method is called when the writer has finished sending a data unit. <b>OnDataUnitEx</b> is
    ///an enhanced version of IWMWriterSink::OnDataUnit. The difference between these two methods is that
    ///<b>OnDataUnitEx</b> delivers very granular data unit information. You can examine individual payload headers,
    ///payload data fragments, and the packet header.
    ///Params:
    ///    pFileSinkDataUnit = Pointer to a WMT_FILESINK_DATA_UNIT structure containing the data unit information.
    ///Returns:
    ///    This method always returns S_OK.
    ///    
    HRESULT OnDataUnitEx(WMT_FILESINK_DATA_UNIT* pFileSinkDataUnit);
    ///The <b>SetUnbufferedIO</b> method specifies whether unbuffered I/O is used for the file sink. You can improve
    ///performance by using unbuffered I/O for writer sessions with a high bit rate and a long running time.
    ///Params:
    ///    fUnbufferedIO = A <b>BOOL</b> that specifies whether to use unbuffered I/O.
    ///    fRestrictMemUsage = A <b>BOOL</b> that specifies whether memory usage should be restricted. Passing True for this parameter
    ///                        severely limits the size of the buffers used to prepare data for unbuffered writing. This limitation usually
    ///                        counteracts any performance gains from using unbuffered I/O.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> The header has already been written.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetUnbufferedIO(BOOL fUnbufferedIO, BOOL fRestrictMemUsage);
    ///The <b>GetUnbufferedIO</b> method ascertains whether unbuffered I/O is used for the file sink.
    ///Params:
    ///    pfUnbufferedIO = Pointer to a Boolean value that is set to True if unbuffered I/O is used with this file sink.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pfUnbuffered</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetUnbufferedIO(BOOL* pfUnbufferedIO);
    ///The <b>CompleteOperations</b> method stops the writer sink after completing all operations in progress. This
    ///method is used with unbuffered I/O.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT CompleteOperations();
}

///The <b>IWMWriterNetworkSink</b> interface is used to deliver streams to the network. It inherits all the methods of
///<b>IWMWriterSink</b>, and adds methods to configure the network sink. The network sink object exposes this interface.
///To create the network sink object, call the WMCreateWriterNetworkSink function.
@GUID("96406BE7-2B2B-11D3-B36B-00C04F6108FF")
interface IWMWriterNetworkSink : IWMWriterSink
{
    ///The <b>SetMaximumClients</b> method sets the maximum number of clients that can connect to this sink. Call this
    ///method before streaming begins.
    ///Params:
    ///    dwMaxClients = Specifies the maximum number of clients. The value must be from 0 to 50, inclusive. The default value is 5.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, the values shown in
    ///    the following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> Streaming has already begun, or the
    ///    value of <i>dwMaxClients</i> is invalid. </td> </tr> </table>
    ///    
    HRESULT SetMaximumClients(uint dwMaxClients);
    ///The <b>GetMaximumClients</b> method retrieves the maximum number of clients that can connect to this sink.
    ///Params:
    ///    pdwMaxClients = Pointer to a variable that receives the maximum number of clients. The default value is 5.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, the values shown in
    ///    the following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pdwMaxClients</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetMaximumClients(uint* pdwMaxClients);
    ///The <b>SetNetworkProtocol</b> method sets the network protocol that the network sink uses. Currently, HTTP is the
    ///only protocol supported by the network sink.
    ///Params:
    ///    protocol = Specifies the procotcol, as a value from the WMT_NET_PROTOCOL enumeration type.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, the values shown in
    ///    the following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid argument. </td> </tr> </table>
    ///    
    HRESULT SetNetworkProtocol(WMT_NET_PROTOCOL protocol);
    ///The <b>GetNetworkProtocol</b> method retrieves the network protocol that the network sink uses. Currently, HTTP
    ///is the only protocol the network sink supports.
    ///Params:
    ///    pProtocol = Pointer to a variable that receives a member of the WMT_NET_PROTOCOL enumeration type.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, the values shown in
    ///    the following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pProtocol</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetNetworkProtocol(WMT_NET_PROTOCOL* pProtocol);
    ///The <b>GetHostURL</b> method retrieves the URL from which the stream is broadcast. Clients will access the stream
    ///from this URL.
    ///Params:
    ///    pwszURL = Pointer to buffer that receives a string containing the URL. To retrieve the length of the string, set this
    ///              parameter to <b>NULL</b>.
    ///    pcchURL = On input, pointer to the size of <i>pwszURL</i>, in characters. On output, this parameter receives the length
    ///              of the URL in characters, including the terminating <b>null</b> character.
    ///Returns:
    ///    The method returns an HRESULT. Possible values include, but are not limited to, the values shown in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The buffer is too small. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid argument;
    ///    <i>pcchURL</i> cannot be <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> The network sink is not connected. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetHostURL(PWSTR pwszURL, uint* pcchURL);
    ///The <b>Open</b> method opens a network port, and starts listening for network connections.
    ///Params:
    ///    pdwPortNum = On input, pointer to a variable that specifies the port number. Set this value to zero if you want the
    ///                 network sink to select a suitable port. On output, the variable receives the port number that was used.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, the values shown in
    ///    the following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pdwPortNum</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td
    ///    width="60%"> The network sink is already open. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_NETWORK_RESOURCE_FAILURE</b></dt> </dl> </td> <td width="60%"> The port number specified is
    ///    already in use. </td> </tr> </table>
    ///    
    HRESULT Open(uint* pdwPortNum);
    ///The <b>Disconnect</b> method disconnects all clients from the network sink.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, the values shown in
    ///    the following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Disconnect();
    ///The <b>Close</b> method disconnects all clients from the network sink, and releases the port.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, the values shown in
    ///    the following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> The network sink is not connected.
    ///    </td> </tr> </table>
    ///    
    HRESULT Close();
}

///The <b>IWMClientConnections</b> interface manages the collecting of information about clients connected to a writer
///network sink object. The writer network sink object exposes this interface. You can retrieve a pointer to this
///interface by calling the <b>QueryInterface</b> method of any other interface on a writer network sink object.
@GUID("73C66010-A299-41DF-B1F0-CCF03B09C1C6")
interface IWMClientConnections : IUnknown
{
    ///The <b>GetClientCount</b> method retrieves the number of connected clients.
    ///Params:
    ///    pcClients = Pointer to a count of the clients that are connected.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> Streaming has not yet begun. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pcClients</i>
    ///    has been passed a null value. </td> </tr> </table>
    ///    
    HRESULT GetClientCount(uint* pcClients);
    ///The <b>GetClientProperties</b> method retrieves information, including the IP address and protocol, about a
    ///connected client.
    ///Params:
    ///    dwClientNum = <b>DWORD</b> containing the client's index number.
    ///    pClientProperties = Pointer to a WM_CLIENT_PROPERTIES structure.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> Streaming has not yet begun. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>pcClientProperties</i> has been passed a null value. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_INVALID_CLIENT</b></dt> </dl> </td> <td width="60%"> A client number larger than the number of
    ///    clients has been passed in. OR Failed to get client information for unspecified reason. </td> </tr> </table>
    ///    
    HRESULT GetClientProperties(uint dwClientNum, WM_CLIENT_PROPERTIES* pClientProperties);
}

///The <b>IWMClientConnections2</b> interface retrieves advanced client information. The writer network sink object
///exposes this interface. You can retrieve a pointer to this interface by calling the <b>QueryInterface</b> method of
///any other interface on a writer network sink object. The following interfaces can be obtained by using the
///QueryInterface method of this interface. <table> <tr> <th>Interface</th> <th>IID</th> </tr> <tr> <td>
///IWMClientConnections </td> <td>IID_IWMClientConnections</td> </tr> <tr> <td> IWMRegisterCallback </td>
///<td>IID_IWMRegisterCallback</td> </tr> <tr> <td> IWMWriterNetworkSink </td> <td>IID_IWMWriterNetworkSink</td> </tr>
///<tr> <td> IWMWriterSink </td> <td>IID_IWMWriterSink</td> </tr> </table>
@GUID("4091571E-4701-4593-BB3D-D5F5F0C74246")
interface IWMClientConnections2 : IWMClientConnections
{
    ///The <b>GetClientInfo</b> method retrieves information about a client attached to a writer network sink.
    ///Params:
    ///    dwClientNum = <b>DWORD</b> containing the client number.
    ///    pwszNetworkAddress = Pointer to a wide-character <b>null</b>-terminated string containing the network address of the client. Pass
    ///                         <b>NULL</b> to retrieve the size of the string, which is returned in <i>pcchNetworkAddress</i>.
    ///    pcchNetworkAddress = Pointer to a <b>DWORD</b> containing the size of <i>pwszNetworkAddress</i>, in wide characters. This size
    ///                         includes the terminating <b>null</b> character.
    ///    pwszPort = Pointer to a wide-character <b>null</b>-terminated string containing the network port of the client. Pass
    ///               <b>NULL</b> to retrieve the size of the string, which is returned in <i>pcchPort</i>.
    ///    pcchPort = Pointer to a <b>DWORD</b> containing the size of <i>pwszPort</i>, in wide characters. This size includes the
    ///               terminating <b>null</b> character.
    ///    pwszDNSName = Pointer to a wide-character <b>null</b>-terminated string containing the name of the domain name server
    ///                  supporting the client. Pass <b>NULL</b> to retrieve the size of the string, which is returned in
    ///                  <i>pcchDNSName</i>.
    ///    pcchDNSName = Pointer to a <b>DWORD</b> containing the size of <i>pwszDNSName</i>, in wide characters. This size includes
    ///                  the terminating <b>null</b> character.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetClientInfo(uint dwClientNum, PWSTR pwszNetworkAddress, uint* pcchNetworkAddress, PWSTR pwszPort, 
                          uint* pcchPort, PWSTR pwszDNSName, uint* pcchDNSName);
}

///A call to <b>QueryInterface</b> from a reader object exposes the advanced functionality described in this section.
@GUID("96406BEA-2B2B-11D3-B36B-00C04F6108FF")
interface IWMReaderAdvanced : IUnknown
{
    ///The <b>SetUserProvidedClock</b> method specifies whether a clock provided by the application is to be used.
    ///Params:
    ///    fUserClock = Boolean value that is True if an application-provided clock is to be used.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> The reader is not properly configured
    ///    to handle this request. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> The method was unable to allocate memory. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Unable to set an internal event. </td> </tr> </table>
    ///    
    HRESULT SetUserProvidedClock(BOOL fUserClock);
    ///The <b>GetUserProvidedClock</b> method ascertains whether a user-provided clock has been specified.
    ///Params:
    ///    pfUserClock = Pointer to a Boolean value that is set to True if a user-provided clock has been specified.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pfUserClock</i> parameter is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetUserProvidedClock(BOOL* pfUserClock);
    ///The <b>DeliverTime</b> method provides the reader with a clock time. Use this method only when the application is
    ///providing the clock.
    ///Params:
    ///    cnsTime = The time, in 100-nanosecond units.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason.
    ///    </td> </tr> </table>
    ///    
    HRESULT DeliverTime(ulong cnsTime);
    ///The <b>SetManualStreamSelection</b> method specifies whether stream selection is to be controlled manually.
    ///Stream selection applies to outputs associated with mutually exclusive streams. Under normal circumstances, the
    ///reader will select the most appropriate stream for an output at time of playback.
    ///Params:
    ///    fSelection = Boolean value that is True if manual selection is specified.
    ///Returns:
    ///    This method always returns S_OK.
    ///    
    HRESULT SetManualStreamSelection(BOOL fSelection);
    ///The <b>GetManualStreamSelection</b> method ascertains whether manual stream selection has been specified.
    ///Params:
    ///    pfSelection = Pointer to a Boolean value that is True if manual selection has been specified.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pfSelection</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> The
    ///    reader object has not opened a file yet. </td> </tr> </table>
    ///    
    HRESULT GetManualStreamSelection(BOOL* pfSelection);
    ///The <b>SetStreamsSelected</b> method specifies which streams are selected when manual stream selection is
    ///enabled.
    ///Params:
    ///    cStreamCount = <b>WORD</b> containing the count of stream numbers in the <i>pwStreamNumbers</i> array.
    ///    pwStreamNumbers = Pointer to an array containing the stream numbers. Stream numbers are in the range of 1 through 63.
    ///    pSelections = Pointer to an array, of equal length to <i>pwStreamNumbers</i>, with each entry containing one member of the
    ///                  WMT_STREAM_SELECTION enumeration type.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetStreamsSelected(ushort cStreamCount, ushort* pwStreamNumbers, WMT_STREAM_SELECTION* pSelections);
    ///The <b>GetStreamSelected</b> method ascertains whether a particular stream is currently selected. This method can
    ///be used only when manual stream selection has been specified.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number. Stream numbers are in the range of 1 through 63.
    ///    pSelection = Pointer to one member of the WMT_STREAM_SELECTION enumeration type.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pSelection</i> parameter is
    ///    <b>NULL</b>, or the stream number is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> The reader
    ///    object has not opened a file yet. </td> </tr> </table>
    ///    
    HRESULT GetStreamSelected(ushort wStreamNum, WMT_STREAM_SELECTION* pSelection);
    ///The <b>SetReceiveSelectionCallbacks</b> method specifies whether stream selection notifications must be sent to
    ///IWMReaderCallbackAdvanced::OnStreamSelection.
    ///Params:
    ///    fGetCallbacks = Boolean value that is True if stream selections must generate callbacks.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> No callback interface has been specified.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetReceiveSelectionCallbacks(BOOL fGetCallbacks);
    ///The <b>GetReceiveSelectionCallbacks</b> method ascertains whether the option to receive stream selection
    ///notifications has been enabled.
    ///Params:
    ///    pfGetCallbacks = Pointer to a Boolean value that is set to True if stream selection notifications are sent to
    ///                     IWMReaderCallbackAdvanced::OnStreamSelection.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pfGetCallbacks</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetReceiveSelectionCallbacks(BOOL* pfGetCallbacks);
    ///The <b>SetReceiveStreamSamples</b> method specifies whether stream samples are delivered to the
    ///IWMReaderCallbackAdvanced::OnStreamSample callback.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number. Stream numbers are in the range of 1 through 63.
    ///    fReceiveStreamSamples = Boolean value that is True if stream samples are delivered.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> No callback
    ///    interface has been specified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_PROTECTED_CONTENT</b></dt>
    ///    </dl> </td> <td width="60%"> Attempted read on a file protected by DRM. </td> </tr> </table>
    ///    
    HRESULT SetReceiveStreamSamples(ushort wStreamNum, BOOL fReceiveStreamSamples);
    ///The <b>GetReceiveStreamSamples</b> method ascertains whether stream samples are delivered to the
    ///IWMReaderCallbackAdvanced::OnStreamSample call.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number. Stream numbers are in the range of 1 through 63.
    ///    pfReceiveStreamSamples = Pointer to a Boolean value that is set to True if stream samples are delivered to <b>OnStreamSample</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pfReceiveStreamSamples</i> parameter is
    ///    <b>NULL</b>, or the stream number is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetReceiveStreamSamples(ushort wStreamNum, BOOL* pfReceiveStreamSamples);
    ///The <b>SetAllocateForOutput</b> method specifies whether the reader allocates its own buffers for output samples
    ///or gets buffers from your application.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the output number.
    ///    fAllocate = Boolean value that is True if the reader gets buffers from your application.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAllocateForOutput(uint dwOutputNum, BOOL fAllocate);
    ///The <b>GetAllocateForOutput</b> method ascertains whether the reader is configured to use the
    ///IWMReaderCallbackAdvanced interface to allocate samples delivered by the IWMReaderCallback::OnSample callback.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the identifying number of the output media stream.
    ///    pfAllocate = Pointer to a Boolean value that is set to True if the reader uses <b>IWMReaderCallbackAdvanced</b> to
    ///                 allocate samples.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAllocateForOutput(uint dwOutputNum, BOOL* pfAllocate);
    ///The <b>SetAllocateForStream</b> method specifies whether the reader uses
    ///IWMReaderCallbackAdvanced::AllocateForStream to allocate buffers for stream samples.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number. Stream numbers are in the range of 1 through 63.
    ///    fAllocate = Boolean value that is True if the reader uses <b>IWMReaderCallbackAdvanced</b> to allocate streams.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAllocateForStream(ushort wStreamNum, BOOL fAllocate);
    ///The <b>GetAllocateForStream</b> method ascertains whether the reader is configured to use
    ///IWMReaderCallbackAdvanced to allocate stream samples delivered by the IWMReaderCallbackAdvanced::OnStreamSample
    ///callback.
    ///Params:
    ///    dwSreamNum = <b>WORD</b> containing the stream number.
    ///    pfAllocate = Pointer to a Boolean value that is set to True if the reader uses <b>IWMReaderCallbackAdvanced</b> to
    ///                 allocate samples.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAllocateForStream(ushort dwSreamNum, BOOL* pfAllocate);
    ///The <b>GetStatistics</b> method retrieves the current reader statistics.
    ///Params:
    ///    pStatistics = Pointer to a WM_READER_STATISTICS structure.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pStatistics</i> is <b>NULL</b>, or the
    ///    <b>cbSize</b> member of <i>pStatistics</i> is not set to the size of <b>WM_READER_STATISTICS</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to
    ///    allocate memory for an internal object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> The reader object has not opened a file
    ///    yet. </td> </tr> </table>
    ///    
    HRESULT GetStatistics(WM_READER_STATISTICS* pStatistics);
    ///The <b>SetClientInfo</b> method sets client-side information used for logging. Use this method to specify
    ///information about the client that the reader object sends to the server for logging. If the application does not
    ///call this method, the reader object uses default values.
    ///Params:
    ///    pClientInfo = Pointer to a WM_READER_CLIENTINFO structure allocated by the caller, which contains information about the
    ///                  client.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid argument. The <b>cbSize</b> member
    ///    must be set, and the string values must not exceed 1024 characters. </td> </tr> </table>
    ///    
    HRESULT SetClientInfo(WM_READER_CLIENTINFO* pClientInfo);
    ///The <b>GetMaxOutputSampleSize</b> method retrieves the maximum buffer size to be allocated for output samples for
    ///a specified media stream.
    ///Params:
    ///    dwOutput = <b>DWORD</b> specifying the output media stream.
    ///    pcbMax = Pointer to the maximum buffer size to be allocated.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>ASF_E_INVALIDSTATE</b></dt> </dl> </td> <td width="60%"> No file has been opened for the sample.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>dwOutput</i> specifies the wrong output or <i>pcbMax</i> is a <b>NULL</b> pointer. </td> </tr> </table>
    ///    
    HRESULT GetMaxOutputSampleSize(uint dwOutput, uint* pcbMax);
    ///The <b>GetMaxStreamSampleSize</b> method retrieves the maximum buffer size to be allocated for stream samples for
    ///a specified media stream.
    ///Params:
    ///    wStream = Stream number.
    ///    pcbMax = Pointer to the maximum buffer size to be allocated.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>ASF_E_INVALIDSTATE</b></dt> </dl> </td> <td width="60%"> No file open for stream sample. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>wStream</i>
    ///    specifies the wrong stream or <i>pcbMax</i> is a <b>NULL</b> pointer. </td> </tr> </table>
    ///    
    HRESULT GetMaxStreamSampleSize(ushort wStream, uint* pcbMax);
    ///The <b>NotifyLateDelivery</b> method is used to notify the reader that it is delivering data to the application
    ///too slowly.
    ///Params:
    ///    cnsLateness = <b>QWORD</b> indicating how late the data is, in 100-nanosecond units.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT NotifyLateDelivery(ulong cnsLateness);
}

///The <b>IWMReaderAdvanced2</b> interface provides additional advanced methods for a reader object.
@GUID("AE14A945-B90C-4D0D-9127-80D665F7D73E")
interface IWMReaderAdvanced2 : IWMReaderAdvanced
{
    ///The <b>SetPlayMode</b> method specifies the play mode.
    ///Params:
    ///    Mode = Variable containing one member of the WMT_PLAY_MODE enumeration type.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetPlayMode(WMT_PLAY_MODE Mode);
    ///The <b>GetPlayMode</b> method retrieves the current play mode.
    ///Params:
    ///    pMode = Pointer to a variable that receives a member of the WMT_PLAY_MODE enumeration type.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetPlayMode(WMT_PLAY_MODE* pMode);
    ///The <b>GetBufferProgress</b> method retrieves the percentage of data that has been buffered, and the time
    ///remaining to completion.
    ///Params:
    ///    pdwPercent = Pointer to a <b>DWORD</b> containing the percentage of data that has been buffered.
    ///    pcnsBuffering = Pointer to variable specifying the time remaining, in 100-nanosecond units, until all the buffering is
    ///                    completed.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetBufferProgress(uint* pdwPercent, ulong* pcnsBuffering);
    ///The <b>GetDownloadProgress</b> method retrieves the percentage and amount of data that has been downloaded, and
    ///the time remaining to completion.
    ///Params:
    ///    pdwPercent = Pointer to a <b>DWORD</b> containing the percentage of data that has been downloaded.
    ///    pqwBytesDownloaded = Pointer to a <b>QWORD</b> containing the number of bytes of data downloaded.
    ///    pcnsDownload = Pointer to variable specifying the time remaining, in 100-nanosecond units, for data to be downloaded.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetDownloadProgress(uint* pdwPercent, ulong* pqwBytesDownloaded, ulong* pcnsDownload);
    ///The <b>GetSaveAsProgress</b> method retrieves the percentage of data that has been saved.
    ///Params:
    ///    pdwPercent = Pointer to a <b>DWORD</b> containing the percentage of data that has been saved.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetSaveAsProgress(uint* pdwPercent);
    ///The <b>SaveFileAs</b> method saves the current file.
    ///Params:
    ///    pwszFilename = Pointer to a wide-character null-terminated string containing the file name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>ERROR_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%"> The file was closed before the
    ///    operation completed. A WMT_SAVEAS_STOP event is also generated in this case. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>ASF_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The call to this method
    ///    has been made before an <b>Open</b> call. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_BUSY</b></dt>
    ///    </dl> </td> <td width="60%"> A previous <b>SaveFileAs</b> operation has not yet been completed. Saving files
    ///    is sequential. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td
    ///    width="60%"> The play mode is not WMT_PLAY_MODE_DOWNLOAD. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>STG_E_MEDIUMFULL</b></dt> </dl> </td> <td width="60%"> There is not enough free disk space. See the
    ///    note in the Remarks below. </td> </tr> </table>
    ///    
    HRESULT SaveFileAs(const(PWSTR) pwszFilename);
    ///The <b>GetProtocolName</b> method retrieves the name of the protocol that is being used.
    ///Params:
    ///    pwszProtocol = Pointer to a buffer that receives a string containing the protocol name. Pass <b>NULL</b> to retrieve the
    ///                   length of the name.
    ///    pcchProtocol = On input, pointer to a variable containing the length of <i>pwszProtocol</i>, in characters. On output, the
    ///                   variable contains the length of the name, including the terminating <b>null</b> character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The buffer is too small. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>ASF_E_INVALIDSTATE</b></dt> </dl> </td> <td width="60%"> The protocol has
    ///    not been determined, or no file is open. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> The <i>pcchProtocol</i> parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetProtocolName(PWSTR pwszProtocol, uint* pcchProtocol);
    ///The <b>StartAtMarker</b> method starts the reader from a specified marker.
    ///Params:
    ///    wMarkerIndex = <b>WORD</b> containing the marker index.
    ///    cnsDuration = Specifies the duration, in 100-nanosecond units.
    ///    fRate = Floating point number indicating rate. Normal-speed playback is 1.0; higher numbers cause faster playback.
    ///            Numbers less than zero indicate reverse rate (rewinding). The valid range is 1.0 through 10.0, and -1.0
    ///            through -10.0.
    ///    pvContext = Generic pointer, for use by the application.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is not enough available memory. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> The value
    ///    for <i>fRate</i> is not within the valid ranges. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The method failed for an unspecified reason. </td>
    ///    </tr> </table>
    ///    
    HRESULT StartAtMarker(ushort wMarkerIndex, ulong cnsDuration, float fRate, void* pvContext);
    ///The <b>GetOutputSetting</b> method retrieves a setting for a particular output by name.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the output number.
    ///    pszName = Pointer to a wide-character <b>null</b>-terminated string containing the setting name. For a list of global
    ///              constants representing setting names, see Output Settings.
    ///    pType = Pointer to a member of the WMT_ATTR_DATATYPE enumeration type that specifies the type of the value.
    ///    pValue = Pointer to a byte buffer containing the value. Pass <b>NULL</b> to retrieve the length of the buffer
    ///             required.
    ///    pcbLength = On input, pointer to a variable containing the length of <i>pValue</i>. On output, the variable contains the
    ///                number of bytes in <i>pValue</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetOutputSetting(uint dwOutputNum, const(PWSTR) pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, 
                             ushort* pcbLength);
    ///The <b>SetOutputSetting</b> method specifies a named setting for a particular output.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the output number.
    ///    pszName = Pointer to a wide-character null-terminated string containing the name. For a list of global constants that
    ///              represent setting names, see Output Settings.
    ///    Type = Member of the WMT_ATTR_DATATYPE enumeration type that specifies the type of the value.
    ///    pValue = Pointer to a byte array containing the value.
    ///    cbLength = Size of <i>pValue</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetOutputSetting(uint dwOutputNum, const(PWSTR) pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, 
                             ushort cbLength);
    ///The <b>Preroll</b> method is used to begin prerolling (buffering data) for the reader.
    ///Params:
    ///    cnsStart = Specifies the start time in 100-nanosecond units.
    ///    cnsDuration = Specifies the duration in 100-nanosecond units.
    ///    fRate = Specifies the data rate.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Preroll(ulong cnsStart, ulong cnsDuration, float fRate);
    ///The <b>SetLogClientID</b> method specifies whether the reader logs the client's unique ID or an anonymous session
    ///ID.
    ///Params:
    ///    fLogClientID = Specify one of the following values: <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr>
    ///                   <td>TRUE</td> <td>Send the client's unique ID.</td> </tr> <tr> <td>FALSE</td> <td>Send an anonymous session
    ///                   ID.</td> </tr> </table>
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetLogClientID(BOOL fLogClientID);
    ///The <b>GetLogClientID</b> method queries whether the reader logs the client's unique ID or an anonymous session
    ///ID.
    ///Params:
    ///    pfLogClientID = Pointer Boolean value that is set to True if the client's log ID must be sent to the server.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> or invalid argument was passed
    ///    in. </td> </tr> </table>
    ///    
    HRESULT GetLogClientID(BOOL* pfLogClientID);
    ///The <b>StopBuffering</b> method requests that the reader send the WMT_BUFFERING_STOP message as soon as possible.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT StopBuffering();
    ///The <b>OpenStream</b> method opens a Windows Media stream for reading.
    ///Params:
    ///    pStream = Pointer to an <b>IStream</b> interface (see the Remarks section below).
    ///    pCallback = Pointer to an IWMReaderCallback interface.
    ///    pvContext = Generic pointer, for use by the application. This is passed to the application in calls to
    ///                <b>IWMReaderCallback::OnStatus</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pCallback</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is
    ///    not enough available memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td>
    ///    <td width="60%"> The method failed for an unspecified reason. </td> </tr> </table>
    ///    
    HRESULT OpenStream(IStream pStream, IWMReaderCallback pCallback, void* pvContext);
}

///The <b>IWMReaderAdvanced3</b> interface provides additional functionality to the reader object. It contains methods
///that enhance the ability to playback a file. <b>IWMReaderAdvanced3</b> exists for each instance of the reader objects
///created with the <b>WMCreateReader</b> function.
@GUID("5DC0674B-F04B-4A4E-9F2A-B1AFDE2C8100")
interface IWMReaderAdvanced3 : IWMReaderAdvanced2
{
    ///The <b>StopNetStreaming</b> method halts network streaming. Any samples that have already been received from the
    ///network are delivered as usual.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT StopNetStreaming();
    ///The <b>StartAtPosition</b> method enables you to specify a starting position for a file using one of several
    ///offset formats. This method is very similar to IWMReader::Start, except that the starting position and duration
    ///can be given for time, video frame number, SMPTE time code, or playlist position. If you only need to seek on
    ///presentation time, use <b>Start</b>.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number for which <i>pvOffsetStart</i> and <i>pvDuration</i> apply. Passing
    ///                 zero signifies that the offset start and duration apply for all streams in the file. If you pass zero, the
    ///                 only valid values for <i>dwOffsetFormat</i> are WMT_OFFSET_FORMAT_100NS and
    ///                 WMT_OFFSET_FORMAT_PLAYLIST_OFFSET.
    ///    pvOffsetStart = Void pointer to the address containing the offset start. The unit of measurement for the offset is determined
    ///                    by <i>dwOffsetFormat</i>. The unit of measurement also dictates the size of the variable pointed to. The
    ///                    possible variable types are listed according to offset format in the following table. <table> <tr> <th>Offset
    ///                    format </th> <th><i>pvOffsetStart</i> data type </th> </tr> <tr> <td>WMT_OFFSET_FORMAT_100NS</td>
    ///                    <td><b>QWORD</b></td> </tr> <tr> <td>WMT_OFFSET_FORMAT_FRAME_NUMBERS</td> <td><b>QWORD</b></td> </tr> <tr>
    ///                    <td>WMT_OFFSET_FORMAT_PLAYLIST_OFFSET</td> <td><b>LONG</b></td> </tr> <tr>
    ///                    <td>WMT_OFFSET_FORMAT_TIMECODE</td> <td> WMT_TIMECODE_EXTENSION_DATA </td> </tr> <tr>
    ///                    <td>WMT_OFFSET_FORMAT_APPROXIMATE</td> <td><b>QWORD</b></td> </tr> </table>
    ///    pvDuration = Void pointer to the address containing the duration of playback. If zero is passed, playback will continue
    ///                 until the end of the file. The unit of measurement for the duration is determined by <i>dwOffsetFormat</i>.
    ///                 The unit of measurement also dictates the size of the variable pointed to. The possible variable types are
    ///                 listed according to offset format in the following table. <table> <tr> <th>Offset format </th>
    ///                 <th><i>pvDuration</i> data type </th> </tr> <tr> <td>WMT_OFFSET_FORMAT_100NS</td> <td><b>QWORD</b></td> </tr>
    ///                 <tr> <td>WMT_OFFSET_FORMAT_FRAME_NUMBERS</td> <td><b>QWORD</b></td> </tr> <tr>
    ///                 <td>WMT_OFFSET_FORMAT_PLAYLIST_OFFSET</td> <td><b>QWORD</b></td> </tr> <tr>
    ///                 <td>WMT_OFFSET_FORMAT_TIMECODE</td> <td> WMT_TIMECODE_EXTENSION_DATA </td> </tr> <tr>
    ///                 <td>WMT_OFFSET_FORMAT_APPROXIMATE</td> <td><b>QWORD</b></td> </tr> </table>
    ///    dwOffsetFormat = <b>DWORD</b> containing one member of the WMT_OFFSET_FORMAT enumeration type. Valid values and their meanings
    ///                     are as follows. <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr>
    ///                     <td>WMT_OFFSET_FORMAT_100NS</td> <td>The offset and duration are specified in 100-nanosecond units. This is
    ///                     the same offset format that is supported by the <b>IWMReader::Start</b> method.</td> </tr> <tr>
    ///                     <td>WMT_OFFSET_FORMAT_FRAME_NUMBERS</td> <td>The offset is specified by the video frame number at which to
    ///                     start playback. The duration is a number of video frames.</td> </tr> <tr>
    ///                     <td>WMT_OFFSET_FORMAT_PLAYLIST_OFFSET</td> <td>The offset is specified by an offset into a playlist. The
    ///                     duration is specified in 100-nanosecond units.</td> </tr> <tr> <td>WMT_OFFSET_FORMAT_TIMECODE</td> <td>The
    ///                     offset is specified by a SMPTE time code value. The duration is not a count, but another SMPTE time code
    ///                     value.</td> </tr> <tr> <td>WMT_OFFSET_FORMAT_APPROXIMATE</td> <td>The offset and duration are specified in
    ///                     100-nanosecond units. When this format is used, playback begins with the closest clean point prior to the
    ///                     time provided. This format is intended to decrease seeking time when the exact sample is not required, such
    ///                     as in a player application's seek bar.</td> </tr> </table>
    ///    fRate = Floating point number indicating playback rate. Normal-speed playback is 1.0; higher numbers cause faster
    ///            playback, and lower numbers cause slower playback. Numbers less than zero indicate reverse rate (rewinding).
    ///            The valid range is 1.0 through 10.0, and -1.0 through -10.0.
    ///    pvContext = Generic pointer, for use by the application. This pointer is passed back to the application on calls to
    ///                IWMReaderCallback.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> <i>dwOffsetFormat</i> is
    ///    WMT_OFFSET_FORMAT_FRAME_NUMBERS and <i>wStreamNum</i> is zero. OR <i>pvOffsetStart</i> is <b>NULL</b>,
    ///    signifying a resume, and the reader is in stop mode. You cannot resume playback when the player has been
    ///    stopped. OR <i>pvOffsetStart</i> is <b>NULL</b>, signifying a resume, and <i>pvDuration</i> is not
    ///    <b>NULL</b>. You cannot specify a duration for a resume. OR No file is open in the reader. OR <i>fRate</i> is
    ///    out of bounds. OR The reader receiving broadcast streams. You cannot seek from a broadcasting source. OR
    ///    <i>fRate</i> is negative, indicating a rewind, and the duration would rewind to before the beginning of the
    ///    file. OR <i>dwOffsetFormat</i> is WMT_OFFSET_FORMAT_FRAME_NUMBERS and the file is not indexed and/or is not
    ///    indexed by frame. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> The method is unable to allocate memory for a message structure required internally. </td> </tr>
    ///    </table>
    ///    
    HRESULT StartAtPosition(ushort wStreamNum, void* pvOffsetStart, void* pvDuration, 
                            WMT_OFFSET_FORMAT dwOffsetFormat, float fRate, void* pvContext);
}

///The <b>IWMReaderAdvanced4</b> interface provides additional functionality to the reader. An <b>IWMReaderAdvanced4</b>
///interface exists for every reader object. You can obtain a pointer to an instance of this interface by calling the
///<b>QueryInterface</b> method of any other interface in the reader object.
@GUID("945A76A2-12AE-4D48-BD3C-CD1D90399B85")
interface IWMReaderAdvanced4 : IWMReaderAdvanced3
{
    ///The <b>GetLanguageCount</b> method retrieves the total number of languages supported by an output. Only outputs
    ///associated with streams mutually exclusive by language will have more than one supported language.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the output number.
    ///    pwLanguageCount = Pointer to a <b>WORD</b> containing the language count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetLanguageCount(uint dwOutputNum, ushort* pwLanguageCount);
    ///The <b>GetLanguage</b> method retrieves information about a language supported by an output. You must specify an
    ///output number and a language index, and this method will supply the RFC1766-compliant language string.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the output number for which you want to identify the language.
    ///    wLanguage = <b>WORD</b> containing the language index of the supported language for which you want the details.
    ///    pwszLanguageString = Pointer to a wide-character <b>null</b>-terminated string containing the RFC1766-compliant language string.
    ///                         Pass <b>NULL</b> to retrieve the size of the string, which will be returned in
    ///                         <i>pcbLanguageStringLength</i>.
    ///    pcchLanguageStringLength = Pointer to a <b>WORD</b> containing the size of <i>pwszLanguageString</i> in wide characters. This size
    ///                               includes the terminating <b>null</b> character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetLanguage(uint dwOutputNum, ushort wLanguage, PWSTR pwszLanguageString, 
                        ushort* pcchLanguageStringLength);
    ///The <b>GetMaxSpeedFactor</b> method retrieves the maximum playback rate that can be delivered by the source. For
    ///network content, this value reflects the available bandwidth relative to the maximum bit rate of the content.
    ///Params:
    ///    pdblFactor = Pointer to a variable that receives the maximum playback rate.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL pointer argument. </td> </tr> </table>
    ///    
    HRESULT GetMaxSpeedFactor(double* pdblFactor);
    ///The <b>IsUsingFastCache</b> method queries whether the reader is using Fast Cache streaming.
    ///Params:
    ///    pfUsingFastCache = Pointer to a variable that receives a Boolean value. The value is True if the reader is currently using Fast
    ///                       Cache streaming, or False otherwise.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL pointer argument. </td> </tr> </table>
    ///    
    HRESULT IsUsingFastCache(BOOL* pfUsingFastCache);
    ///The <b>AddLogParam</b> method adds a named value to the logging information that the reader object will send to
    ///the sever.
    ///Params:
    ///    wszNameSpace = Optional wide-character string that contains the namespace for the log entry. This parameter can be
    ///                   <b>NULL</b>. Namespace names are limited to 1024 wide characters.
    ///    wszName = Wide-character string that contains the name of the log entry. Log entry names are limited to 1024 wide
    ///              characters.
    ///    wszValue = Wide-character string that contains the value of the log entry. Log entry values are limited to 1024 wide
    ///               characters.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters exceeded the allowed
    ///    string length. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Insufficient memory. </td> </tr> </table>
    ///    
    HRESULT AddLogParam(const(PWSTR) wszNameSpace, const(PWSTR) wszName, const(PWSTR) wszValue);
    ///The <b>SendLogParams</b> method sends log entries to the originating server. Call this method after calling
    ///<b>AddLogParam</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The reader is not streaming content from a remote
    ///    server. </td> </tr> </table>
    ///    
    HRESULT SendLogParams();
    ///The <b>CanSaveFileAs</b> method ascertains whether the content being played by the reader can be saved using the
    ///IWMReaderAdvanced2::SaveFileAs method.
    ///Params:
    ///    pfCanSave = Pointer to a Boolean value that is set to True if that the content being read can be saved.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT CanSaveFileAs(BOOL* pfCanSave);
    ///The <b>CancelSaveFileAs</b> method cancels a file save resulting from a call to IWMReaderAdvanced2::SaveFileAs.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT CancelSaveFileAs();
    ///The <b>GetURL</b> method retrieves the URL of the file being read. This URL might be different from the URL that
    ///was passed to IWMReader::Open, because the reader might have been redirected.
    ///Params:
    ///    pwszURL = [ out ] Pointer to a wide-character <b>null</b>-terminated string containing the URL of the file.
    ///    pcchURL = [ in, out ] Pointer to a variable containing the number of wide characters in <i>pwszURL</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <b>NULL</b> pointer argument. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetURL(PWSTR pwszURL, uint* pcchURL);
}

///The <b>IWMReaderAdvanced5</b> interface enables you to associate a player-hook callback interface with the reader
///object. An <b>IWMReaderAdvanced5</b> interface exists for every reader object. You can obtain a pointer to an
///instance of this interface by calling the <b>QueryInterface</b> method of any other interface in the reader object.
@GUID("24C44DB0-55D1-49AE-A5CC-F13815E36363")
interface IWMReaderAdvanced5 : IWMReaderAdvanced4
{
    ///The <b>SetPlayerHook</b> method assigns a player-hook callback to the reader. The reader calls the callback
    ///method before sending each sample to the graphics processor for decompression.
    ///Params:
    ///    dwOutputNum = The output number to which the player-hook callback applies.
    ///    pHook = Pointer to the implementation of the IWMPlayerHook interface that will be used in association with the
    ///            specified output.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetPlayerHook(uint dwOutputNum, IWMPlayerHook pHook);
}

///The <b>IWMReaderAdvanced6</b> interface enables sample protection. An <b>IWMReaderAdvanced6</b> interface exists for
///every reader object. You can obtain a pointer to an instance of this interface by calling the <b>QueryInterface</b>
///method of any other interface in the reader object.
@GUID("18A2E7F8-428F-4ACD-8A00-E64639BC93DE")
interface IWMReaderAdvanced6 : IWMReaderAdvanced5
{
    ///The <b>SetProtectStreamSamples</b> method configures sample protection.
    ///Params:
    ///    pbCertificate = Buffer containing the certificate to use for protection.
    ///    cbCertificate = Size of the certificate in bytes.
    ///    dwCertificateType = Type of certificate passed in <i>pbCertificate</i>. The only supported type is WMDRM_CERTIFICATE_TYPE_XML.
    ///    dwFlags = The type of session protection to use for re-encoding. The only supported type is WMDRM_PROTECTION_TYPE_RC4.
    ///    pbInitializationVector = Receives the initialization vector. The initialization vector is OEAP-encrypted with the RSA public key found
    ///                             in the certificate. Set to <b>NULL</b> to receive the required buffer size in pcbInitializationVector.
    ///    pcbInitializationVector = On input, the size of the buffer passed as <i>pbInitializationVector</i>. On output, the size of the used
    ///                              portion of the buffer. If you pass <b>NULL</b> for <i>pbInitializationVector</i>, this value is set to the
    ///                              required buffer size on output.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_DRM_RIV_TOO_SMALL</b></dt> </dl> </td> <td width="60%"> An updated content revocation list is
    ///    needed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method
    ///    succeeded. </td> </tr> </table>
    ///    
    HRESULT SetProtectStreamSamples(ubyte* pbCertificate, uint cbCertificate, uint dwCertificateType, uint dwFlags, 
                                    ubyte* pbInitializationVector, uint* pcbInitializationVector);
}

///The <b>IWMPlayerHook</b> interface can be implemented by a player application that uses DirectX Video Acceleration
///(DirectX VA). This interface enables application-specific processing to be performed when samples from a video stream
///are passed to the DirectX VA enabled video card for decompression.
@GUID("E5B7CA9A-0F1C-4F66-9002-74EC50D8B304")
interface IWMPlayerHook : IUnknown
{
    ///The <b>PreDecode</b> method is called by the reader object before a sample from the output to which the
    ///<b>IWMPlayerHook</b> interface is assigned is passed to the video processor for decoding.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. You should return S_OK.
    ///    
    HRESULT PreDecode();
}

///The <b>IWMReaderAllocatorEx</b> interface provides expanded alternatives to the AllocateForOutput and
///AllocateForStream methods of the IWMReaderCallbackAdvanced interface. This interface is implemented by the
///application, which passes this interface pointer to the synchronous reader object by calling
///IWMSyncReader2::SetAllocateForStream or SetAllocateForOutput.
@GUID("9F762FA7-A22E-428D-93C9-AC82F3AAFE5A")
interface IWMReaderAllocatorEx : IUnknown
{
    ///The <b>AllocateForStreamEx</b> method allocates a user-created buffer for samples delivered to the
    ///IWMReaderCallbackAdvanced::OnStreamSample method.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number.
    ///    cbBuffer = Size of <i>ppBuffer</i>, in bytes.
    ///    ppBuffer = Pointer to a pointer to an <b>INSSBuffer</b> object.
    ///    dwFlags = <b>DWORD</b> containing the relevant flags. <table> <tr> <th>Flag </th> <th>Description </th> </tr> <tr>
    ///              <td>WM_SFEX_NOTASYNCPOINT</td> <td>This flag is the opposite of the WM_SF_CLEANPOINT flag used in other
    ///              methods of this SDK. It indicates that the point is not a key frame, or is not a good point to go to during a
    ///              seek. This inverse definition is used for compatibility with Direct Show.</td> </tr> <tr>
    ///              <td>WM_SFEX_DATALOSS</td> <td>Some data has been lost between the previous sample and the sample with the
    ///              flag set.</td> </tr> </table>
    ///    cnsSampleTime = Specifies the sample time, in 100-nanosecond units.
    ///    cnsSampleDuration = Specifies the sample duration, in 100-nanosecond units.
    ///    pvContext = Generic pointer, for use by the application. This pointer is the context pointer given to the
    ///                IWMReader::Start method.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT AllocateForStreamEx(ushort wStreamNum, uint cbBuffer, INSSBuffer* ppBuffer, uint dwFlags, 
                                ulong cnsSampleTime, ulong cnsSampleDuration, void* pvContext);
    ///The <b>AllocateForOutputEx</b> method allocates a user-created buffer for samples delivered to the
    ///IWMReaderCallback::OnSample method.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the output number.
    ///    cbBuffer = Size of <i>ppBuffer</i>, in bytes.
    ///    ppBuffer = Pointer to a pointer to an <b>INSSBuffer</b> object.
    ///    dwFlags = <b>DWORD</b> containing the relevant flags. <table> <tr> <th>Flag </th> <th>Description </th> </tr> <tr>
    ///              <td>WM_SFEX_NOTASYNCPOINT</td> <td>This flag is the opposite of the WM_SF_CLEANPOINT flag used in other
    ///              methods of this SDK. It indicates that the point is not a key frame, or is not a good point to go to during a
    ///              seek. This inverse definition is used for compatibility with DirectShow.</td> </tr> <tr>
    ///              <td>WM_SFEX_DATALOSS</td> <td>Some data has been lost between the previous sample and the sample with the
    ///              flag set.</td> </tr> </table>
    ///    cnsSampleTime = Specifies the sample time, in 100-nanosecond units.
    ///    cnsSampleDuration = Specifies the sample duration, in 100-nanosecond units.
    ///    pvContext = Generic pointer, for use by the application. This pointer is the context pointer given to the
    ///                IWMReader::Start method.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT AllocateForOutputEx(uint dwOutputNum, uint cbBuffer, INSSBuffer* ppBuffer, uint dwFlags, 
                                ulong cnsSampleTime, ulong cnsSampleDuration, void* pvContext);
}

///The <b>IWMReaderTypeNegotiation</b> interface provides a single method that can be used to test certain changes to
///the output properties of a stream. An <b>IWMReaderTypeNegotiation</b> interface exists for every reader object. You
///can obtain a pointer to an instance of this interface by calling the <b>QueryInterface</b> method of any other
///interface of the reader object.
@GUID("FDBE5592-81A1-41EA-93BD-735CAD1ADC05")
interface IWMReaderTypeNegotiation : IUnknown
{
    ///The <b>TryOutputProps</b> method ascertains whether certain changes to the properties of an output are possible.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the output number.
    ///    pOutput = Pointer to the IWMOutputMediaProps interface of an output media properties object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>dwOutputNumber</i> is too large. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unspecified error.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_OUTPUT_FORMAT</b></dt> </dl> </td> <td
    ///    width="60%"> Media type of object is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory to complete the task. </td>
    ///    </tr> </table>
    ///    
    HRESULT TryOutputProps(uint dwOutputNum, IWMOutputMediaProps pOutput);
}

///The <b>IWMReaderCallback</b> interface is implemented by the application to handle data being read from a file.
@GUID("96406BEB-2B2B-11D3-B36B-00C04F6108FF")
interface IWMReaderCallbackAdvanced : IUnknown
{
    ///The <b>OnStreamSample</b> method delivers stream samples from the source file without decompressing them first.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number.
    ///    cnsSampleTime = <b>QWORD</b> containing the sample time, in 100-nanosecond units.
    ///    cnsSampleDuration = <b>QWORD</b> containing the sample duration, in 100-nanosecond units.
    ///    dwFlags = The flags that can be specified have the following uses. <table> <tr> <th>Flag </th> <th>Description </th>
    ///              </tr> <tr> <td>No flag set</td> <td>None of the conditions for the other flags applies. For example, a delta
    ///              frame in most cases would not have any flags set for it.</td> </tr> <tr> <td>WM_SF_CLEANPOINT</td> <td>This
    ///              is the same as a key frame. It indicates a good point to go to during a seek, for example.</td> </tr> <tr>
    ///              <td>WM_SF_DISCONTINUITY</td> <td>The data stream has a gap in it, which could be due to a seek, a network
    ///              loss, or other reason. This can be useful extra information for an application such as a codec or renderer.
    ///              The flag is set on the first piece of data following the gap.</td> </tr> <tr> <td>WM_SF_DATALOSS</td>
    ///              <td>Some data has been lost between the previous sample, and the sample with this flag set.</td> </tr>
    ///              </table>
    ///    pSample = Pointer to a sample stored in an INSSBuffer interface. The reader calls <b>SAFE_RELEASE</b> on this pointer
    ///              after your <b>OnStreamSample</b> method returns. You can call <b>AddRef</b> on this pointer if you need to
    ///              keep a reference count on the buffer. Do not call <b>Release</b> on this pointer unless you have called
    ///              <b>AddRef</b>.
    ///    pvContext = Generic pointer, for use by the application.
    ///Returns:
    ///    To use this method, you must implement it in your application. You can return whatever <b>HRESULT</b> error
    ///    codes are appropriate to your implementation. For more information about the <b>HRESULT</b> error codes
    ///    included for use by the Windows Media Format SDK, see Error Codes.
    ///    
    HRESULT OnStreamSample(ushort wStreamNum, ulong cnsSampleTime, ulong cnsSampleDuration, uint dwFlags, 
                           INSSBuffer pSample, void* pvContext);
    ///The <b>OnTime</b> method notifies the application of the clock time the reader is working to. This method is used
    ///when a user-provided clock has been specified.
    ///Params:
    ///    cnsCurrentTime = <b>QWORD</b> containing the current time in 100-nanosecond units.
    ///    pvContext = Generic pointer, for use by the application. This pointer is the context pointer given to the
    ///                IWMReader::Start method.
    ///Returns:
    ///    To use this method, you must implement it in your application. You can return whatever <b>HRESULT</b> error
    ///    codes are appropriate to your implementation. For more information about the <b>HRESULT</b> error codes
    ///    included for use by the Windows Media Format SDK, see Error Codes.
    ///    
    HRESULT OnTime(ulong cnsCurrentTime, void* pvContext);
    ///The <b>OnStreamSelection</b> method notifies the application of stream changes made due to bandwidth
    ///restrictions. To have this method called, call IWMReaderAdvanced::SetReceiveSelectionCallbacks.
    ///Params:
    ///    wStreamCount = <b>WORD</b> containing the number of entries in the <i>pStreamNumbers</i> array.
    ///    pStreamNumbers = Pointer to an array of stream numbers.
    ///    pSelections = Pointer to an array of members of the WMT_STREAM_SELECTION enumeration type. Each element in this array
    ///                  corresponds to the stream number contained in the corresponding element of the array pointed to by
    ///                  <i>pStreamNumbers</i>.
    ///    pvContext = Generic pointer, for use by the application. This pointer is the context pointer given to the
    ///                IWMReader::Start method.
    ///Returns:
    ///    To use this method, you must implement it in your application. You can return whatever <b>HRESULT</b> error
    ///    codes are appropriate to your implementation. For more information about the <b>HRESULT</b> error codes
    ///    included for use by the Windows Media Format SDK, see Error Codes.
    ///    
    HRESULT OnStreamSelection(ushort wStreamCount, ushort* pStreamNumbers, WMT_STREAM_SELECTION* pSelections, 
                              void* pvContext);
    ///The <b>OnOutputPropsChanged</b> method indicates that the media properties for the specified output have changed.
    ///This change occurs as a result of a call to the IWMReader::SetOutputProps method.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the output number.
    ///    pMediaType = Pointer to a WM_MEDIA_TYPE structure.
    ///    pvContext = Generic pointer, for use by the application. This pointer is the context pointer given to the
    ///                <b>IWMReader::Start</b> method.
    ///Returns:
    ///    To use this method, you must implement it in your application. You can return whatever <b>HRESULT</b> error
    ///    codes are appropriate to your implementation. For more information about the <b>HRESULT</b> error codes
    ///    included for use by the Windows Media Format SDK, see Error Codes.
    ///    
    HRESULT OnOutputPropsChanged(uint dwOutputNum, WM_MEDIA_TYPE* pMediaType, void* pvContext);
    ///The <b>AllocateForStream</b> method allocates user-created buffers for stream samples delivered to
    ///IWMReaderCallbackAdvanced::OnStreamSample. For more information about allocating your own buffers, see User
    ///Allocated Sample Support.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number.
    ///    cbBuffer = Size of the buffer, in bytes.
    ///    ppBuffer = If the method succeeds, returns a pointer to a pointer to an INSSBuffer interface.
    ///    pvContext = Generic pointer, for use by the application. This pointer is the context pointer given to the
    ///                IWMReader::Start method.
    ///Returns:
    ///    To use this method, you must implement it in your application. You can return whatever <b>HRESULT</b> error
    ///    codes are appropriate to your implementation. For more information about the <b>HRESULT</b> error codes
    ///    included for use by the Windows Media Format SDK, see Error Codes.
    ///    
    HRESULT AllocateForStream(ushort wStreamNum, uint cbBuffer, INSSBuffer* ppBuffer, void* pvContext);
    ///The <b>AllocateForOutput</b> method allocates user-created buffers for samples delivered to
    ///IWMReaderCallback::OnSample. For more information about allocating your own buffers, see User Allocated Sample
    ///Support.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the output number.
    ///    cbBuffer = Size of the buffer, in bytes.
    ///    ppBuffer = If the method succeeds, returns a pointer to a pointer to an INSSBuffer interface.
    ///    pvContext = Generic pointer, for use by the application. This pointer is the context pointer given to the
    ///                IWMReader::Start method.
    ///Returns:
    ///    To use this method, you must implement it in your application. You can return whatever <b>HRESULT</b> error
    ///    codes are appropriate to your implementation. For more information about the <b>HRESULT</b> error codes
    ///    included for use by the Windows Media Format SDK, see Error Codes.
    ///    
    HRESULT AllocateForOutput(uint dwOutputNum, uint cbBuffer, INSSBuffer* ppBuffer, void* pvContext);
}

///<p class="CCE_Message">[<b>IWMDRMReader</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady. ]
///The <b>IWMDRMReader</b> interface provides methods to configure the DRM component and to manage DRM license
///acquisition and individualization of client applications. It is used only for content protected using DRM version 7,
///not the earlier DRM version 1. This interface can be obtained from a reader object.
@GUID("D2827540-3EE7-432C-B14C-DC17F085D3B3")
interface IWMDRMReader : IUnknown
{
    ///<p class="CCE_Message">[<b>AcquireLicense</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>AcquireLicense</b> method begins the license acquisition process.
    ///Params:
    ///    dwFlags = <b>DWORD</b> containing the relevant flags. <table> <tr> <th>Flag </th> <th>Description </th> </tr> <tr>
    ///              <td>0x1</td> <td>Indicates that the method will attempt to acquire the license silently.</td> </tr> <tr>
    ///              <td>0x0</td> <td>Indicates that the <b>OnStatus</b> callback will return a URL to use on the Web to acquire a
    ///              license.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory to complete the task. </td>
    ///    </tr> </table>
    ///    
    HRESULT AcquireLicense(uint dwFlags);
    ///<p class="CCE_Message">[<b>CancelLicenseAcquisition</b> is available for use in the operating systems specified
    ///in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft
    ///PlayReady. ] The <b>CancelLicenseAcquisition</b> method cancels a current call to the AcquireLicense method.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT CancelLicenseAcquisition();
    ///<p class="CCE_Message">[<b>Individualize</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>Individualize</b> method individualizes the client by updating their DRM system components.
    ///Params:
    ///    dwFlags = <b>DWORD</b> containing the relevant flags. <table> <tr> <th>Flag </th> <th>Description </th> </tr> <tr>
    ///              <td>0x0</td> <td>Indicates that the client can be individualized again.</td> </tr> <tr> <td>0x1</td>
    ///              <td>Indicates that the client will not be individualized again.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A null or invalid argument has been passed in.
    ///    </td> </tr> </table>
    ///    
    HRESULT Individualize(uint dwFlags);
    ///<p class="CCE_Message">[<b>CancelIndividualization</b> is available for use in the operating systems specified in
    ///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft
    ///PlayReady. ] The <b>CancelIndividualization</b> method cancels a current call to the Individualize method.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT CancelIndividualization();
    ///<p class="CCE_Message">[<b>MonitorLicenseAcquisition</b> is available for use in the operating systems specified
    ///in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft
    ///PlayReady. ] The <b>MonitorLicenseAcquisition</b> method, in nonsilent license acquisition, informs the
    ///application when a license has been successfully acquired.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT MonitorLicenseAcquisition();
    ///<p class="CCE_Message">[<b>CancelMonitorLicenseAcquisition</b> is available for use in the operating systems
    ///specified in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///Microsoft PlayReady. ] The <b>CancelMonitorLicenseAcquisition</b> method cancels a current call to the
    ///MonitorLicenseAcquisition method.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT CancelMonitorLicenseAcquisition();
    ///<p class="CCE_Message">[<b>SetDRMProperty</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>SetDRMProperty</b> method on the reader object is used to set a DRM property, such as the DRM_Rights
    ///property.
    ///Params:
    ///    pwstrName = Specifies the name of the property to set.
    ///    dwType = One member of the WMT_ATTR_DATATYPE enumeration type. The only supported value for this method is
    ///             <b>WMT_TYPE_STRING</b>.
    ///    pValue = Pointer to a byte array containing the attribute value.
    ///    cbLength = Size of <i>pValue</i>, in bytes.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetDRMProperty(const(PWSTR) pwstrName, WMT_ATTR_DATATYPE dwType, const(ubyte)* pValue, ushort cbLength);
    ///<p class="CCE_Message">[<b>GetDRMProperty</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>GetDRMProperty</b> method retrieves DRM-specific file attributes and run-time properties.
    ///Params:
    ///    pwstrName = Specifies the property or file attribute to retrieve.
    ///    pdwType = Pointer that receives the data type of the returned value.
    ///    pValue = Pointer to the value requested in <i>pwstrName</i>.
    ///    pcbLength = Size of <i>pValue</i>, in bytes.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetDRMProperty(const(PWSTR) pwstrName, WMT_ATTR_DATATYPE* pdwType, ubyte* pValue, ushort* pcbLength);
}

///<p class="CCE_Message">[<b>IWMDRMReader2</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady. ]
///The <b>IWMDRMReader2</b> interface provides methods for examining the rights granted by DRM version 10 licenses. An
///<b>IWMDRMReader2</b> interface exists for every instance of the reader object. You can get a pointer to this method
///by calling the <b>QueryInterface</b> method of any other interface of the reader object.
@GUID("BEFE7A75-9F1D-4075-B9D9-A3C37BDA49A0")
interface IWMDRMReader2 : IWMDRMReader
{
    ///<p class="CCE_Message">[<b>SetEvaluateOutputLevelLicenses</b> is available for use in the operating systems
    ///specified in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///Microsoft PlayReady. ] The <b>SetEvaluateOutputLevelLicenses</b> method sets the reader to evaluate licenses that
    ///use output protection levels (OPLs).
    ///Params:
    ///    fEvaluate = Flag specifying whether to handle files with licenses that use output protection levels.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetEvaluateOutputLevelLicenses(BOOL fEvaluate);
    ///<p class="CCE_Message">[<b>GetPlayOutputLevels</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>GetPlayOutputLevels</b> method retrieves the output protection levels (OPLs) that apply to the play
    ///action in the license of the file loaded in the reader.
    ///Params:
    ///    pPlayOPL = Address of a DRM_PLAY_OPL structure that receives the output levels that apply to playing content. Additional
    ///               data is appended to the structure. If you pass <b>NULL</b>, the method returns the size of the structure in
    ///               <i>pcbLength</i>.
    ///    pcbLength = Address of a variable that contains the size of the <b>DRM_PLAY_OPL</b> structure in bytes. On input set to
    ///                the size of the allocated buffer. On return the method sets this value to the size of the structure and any
    ///                appended data.
    ///    pdwMinAppComplianceLevel = Address of a variable that receives the minimum application compliance level.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetPlayOutputLevels(DRM_PLAY_OPL* pPlayOPL, uint* pcbLength, uint* pdwMinAppComplianceLevel);
    ///<p class="CCE_Message">[<b>GetCopyOutputLevels</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>GetCopyOutputLevels</b> method retrieves the output protection levels (OPLs) that apply to the copy
    ///action in the license of the file loaded in the reader.
    ///Params:
    ///    pCopyOPL = Address of a DRM_COPY_OPL structure that receives the output protection levels that apply to copying content.
    ///               Additional data is appended to the structure. If you pass <b>NULL</b>, the method returns the size of the
    ///               structure in <i>pcbLength</i>.
    ///    pcbLength = Address of a variable that contains the size of the <b>DRM_COPY_OPL</b> structure in bytes. On input set to
    ///                the size of the allocated buffer. On return the method sets this value to the size of the structure and any
    ///                appended data.
    ///    pdwMinAppComplianceLevel = Address of a variable that receives the minimum application compliance level.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetCopyOutputLevels(DRM_COPY_OPL* pCopyOPL, uint* pcbLength, uint* pdwMinAppComplianceLevel);
    ///<p class="CCE_Message">[<b>TryNextLicense</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>TryNextLicense</b> method sets the reader to evaluate the next applicable license (if present) for the
    ///file loaded in the reader.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>DRM_S_FALSE</b></dt> </dl> </td> <td width="60%"> There are no more licenses for this content.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> No
    ///    file is opened in the reader. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_DRM_RIV_TOO_SMALL</b></dt>
    ///    </dl> </td> <td width="60%"> An updated content revocation list is needed. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_DRM_UNSUPPORTED_PROPERTY</b></dt> </dl> </td> <td width="60%"> The file opened in the reader
    ///    is not protected. </td> </tr> </table>
    ///    
    HRESULT TryNextLicense();
}

///<p class="CCE_Message">[<b>IWMDRMReader3</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady. ]
///The <b>IWMDRMReader3</b> interface enables content transcription by providing a method to get protection systems
///approved by a license.
@GUID("E08672DE-F1E7-4FF4-A0A3-FC4B08E4CAF8")
interface IWMDRMReader3 : IWMDRMReader2
{
    ///<p class="CCE_Message">[<b>GetInclusionList</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>GetInclusionList</b> method retrieves a list of identifiers specifying approved protection systems.
    ///Params:
    ///    ppGuids = Address of a variable that receives a pointer to an array of identifiers. The array is allocated by using
    ///              <b>CoTaskMemAlloc</b>. When finished with the list, release the memory by calling <b>CoTaskMemFree</b>.
    ///    pcGuids = Number of elements in the array received by the <i>ppGuids</i> parameter.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetInclusionList(GUID** ppGuids, uint* pcGuids);
}

///The <b>IWMReaderPlaylistBurn</b> interface verifies that the files in a playlist can be copied to CD, in the order in
///which they are specified. If any of the files in the list are DRM-protected, the licenses are checked. DRM version 10
///licenses track the number of times files are copied to CD as part of a playlist. The methods of this interface are
///intended to support applications that copy entire playlists to compact disc. An <b>IWMReaderPlaylistBurn</b>
///interface exists for every instance of the reader object or synchronous reader object. You can get a pointer to the
///<b>IWMReaderPlaylistBurn</b> interface by calling the <b>QueryInterface</b> method of any other interface on one of
///those objects.
@GUID("F28C0300-9BAA-4477-A846-1744D9CBF533")
interface IWMReaderPlaylistBurn : IUnknown
{
    ///The <b>InitPlaylistBurn</b> method initiates the playlist burning process, by checking the files in the playlist
    ///to ensure that they are licensed for copying as part of a playlist.
    ///Params:
    ///    cFiles = Number of files in the playlist. This is also the number of members in the array of file names referenced by
    ///             <i>pwszFilenames</i>.
    ///    ppwszFilenames = Address of an array of <b>WCHAR</b> strings. Each string contains the name of a file in the playlist. You
    ///                     must maintain the file order exactly as it exists in the playlist.
    ///    pCallback = Address of the <b>IWMStatusCallback</b> implementation that will receive the WMT_INIT_PLAYLIST_BURN status
    ///                message.
    ///    pvContext = Generic pointer, for use by the application. This is passed to the application in calls to the
    ///                IWMStatusCallback::OnStatus callback. You can use this parameter to differentiate between messages from
    ///                different objects when sharing a single status callback.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT InitPlaylistBurn(uint cFiles, PWSTR* ppwszFilenames, IWMStatusCallback pCallback, void* pvContext);
    ///The <b>GetInitResults</b> method retrieves the results of the playlist file check.
    ///Params:
    ///    cFiles = Number of files in the playlist. This is also the number of members in the array referenced by
    ///             <i>phrStati</i>. This value must be the same as the number of files specified in the original call to
    ///             InitPlaylistBurn.
    ///    phrStati = Address of an array of <b>HRESULT</b> values. The members of this array correspond to the file names passed
    ///               in the original call to <b>InitPlaylistBurn</b>. On output, each member is set to S_OK if the corresponding
    ///               file is approved for copying as part of the playlist. If a file in the playlist is not licensed for copying,
    ///               or if an error is encountered, the corresponding member of this array is set to the appropriate
    ///               <b>HRESULT</b> return code.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetInitResults(uint cFiles, HRESULT* phrStati);
    ///The <b>Cancel</b> method cancels an initiated playlist burn before initialization is finished.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Cancel();
    ///The <b>EndPlaylistBurn</b> method completes the playlist burn process. This includes releasing resources and
    ///adjusting counts associated with rights in DRM licenses.
    ///Params:
    ///    hrBurnResult = Result of the playlist burn. Set to S_OK if the files in the playlist were successfully copied to CD.
    ///                   Otherwise, set to an appropriate <b>HRESULT</b> error code.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT EndPlaylistBurn(HRESULT hrBurnResult);
}

///The <b>IWMReaderNetworkConfig</b> interface is used to set and test network configuration settings. By using this
///interface, the application can configure which protocols must be used to receive the stream as well as other advanced
///network settings, such as proxy specification and buffering time. An <b>IWMReaderNetworkConfig</b> interface exists
///for every reader object. You can obtain a pointer to an instance of this interface by calling the
///<b>QueryInterface</b> method of any other interface of the reader object.
@GUID("96406BEC-2B2B-11D3-B36B-00C04F6108FF")
interface IWMReaderNetworkConfig : IUnknown
{
    ///The <b>GetBufferingTime</b> method retrieves the amount of time that the network source buffers data before
    ///rendering it.
    ///Params:
    ///    pcnsBufferingTime = Pointer to a variable that receives the buffering time, in 100-nanosecond units.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL passed in to <i>pcnsBufferingTime</i>
    ///    </td> </tr> </table>
    ///    
    HRESULT GetBufferingTime(ulong* pcnsBufferingTime);
    ///The <b>SetBufferingTime</b> method specifies how long the network source buffers data before rendering it.
    ///Params:
    ///    cnsBufferingTime = Specifies the amount of time in to buffer content before starting playback, in 100-nanosecond units.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>cnsBufferingTime</i> is larger than the
    ///    maximum or smaller than the minimum. </td> </tr> </table>
    ///    
    HRESULT SetBufferingTime(ulong cnsBufferingTime);
    ///The <b>GetUDPPortRanges</b> method retrieves the UDP port number ranges used for receiving data.
    ///Params:
    ///    pRangeArray = Pointer to an array of WM_PORT_NUMBER_RANGE structures allocated by the caller. Pass <b>NULL</b> to get the
    ///                  size of the array.
    ///    pcRanges = On input, pointer to a <b>DWORD</b> containing the length of the array passed in <i>pRangeArray</i>. On
    ///               output, pointer to the required array size.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The buffer is too small. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pcRanges</i>
    ///    parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetUDPPortRanges(WM_PORT_NUMBER_RANGE* pRangeArray, uint* pcRanges);
    ///The <b>SetUDPPortRanges</b> method specifies the UDP port number ranges that are used for receiving data.
    ///Params:
    ///    pRangeArray = Pointer to an array of <b>WM_PORT_NUMBER_RANGE</b> structures.
    ///    cRanges = A value indicating the length of the array passed in <i>pRangeArray</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL or invalid argument passed in. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetUDPPortRanges(WM_PORT_NUMBER_RANGE* pRangeArray, uint cRanges);
    ///The <b>GetProxySettings</b> method retrieves the current proxy settings.
    ///Params:
    ///    pwszProtocol = Pointer to a wide-character null-terminated string containing the protocol.
    ///    pProxySetting = Pointer to one member of the WMT_PROXY_SETTINGS enumeration type.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL or invalid argument passed in. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetProxySettings(const(PWSTR) pwszProtocol, WMT_PROXY_SETTINGS* pProxySetting);
    ///The <b>SetProxySettings</b> method specifies the proxy settings.
    ///Params:
    ///    pwszProtocol = Pointer to a wide-character null-terminated string containing the protocol name. Supported names are HTTP and
    ///                   MMS.
    ///    ProxySetting = A value from the WMT_PROXY_SETTINGS enumeration type.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL or invalid argument passed in. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetProxySettings(const(PWSTR) pwszProtocol, WMT_PROXY_SETTINGS ProxySetting);
    ///The <b>GetProxyHostName</b> method retrieves the name of the host to use as the proxy.
    ///Params:
    ///    pwszProtocol = Pointer to a string that contains a protocol name, such as "http" or "mms". The string is not case-sensitive.
    ///    pwszHostName = Pointer to a buffer that receives the name of the proxy server host. The returned value applies only to the
    ///                   protocol specified in <i>pwszProtocol</i>; the reader object supports separate settings for each protocol.
    ///    pcchHostName = On input, pointer to a variable specifying the size of <i>pwszHostName</i>, in characters. On output, the
    ///                   variable contains the length of the string, including the terminating <b>null</b> character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The size of the buffer passed in is
    ///    not large enough to hold the return string. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <b>NULL</b> or invalid argument passed in. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetProxyHostName(const(PWSTR) pwszProtocol, PWSTR pwszHostName, uint* pcchHostName);
    ///The <b>SetProxyHostName</b> method specifies the proxy host name.
    ///Params:
    ///    pwszProtocol = Pointer to a wide-character <b>null</b>-terminated string containing the protocol.
    ///    pwszHostName = Pointer to a wide-character <b>null</b>-terminated string containing the host name. Host names are limited to
    ///                   1024 wide characters.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <b>NULL</b> or invalid argument passed in.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetProxyHostName(const(PWSTR) pwszProtocol, const(PWSTR) pwszHostName);
    ///The <b>GetProxyPort</b> method retrieves the port number of the proxy server.
    ///Params:
    ///    pwszProtocol = Pointer to a string that contains a protocol name, such as "http" or "mms". The string is not case-sensitive.
    ///    pdwPort = Pointer to a variable that receives the port number. The returned value applies only to the protocol
    ///              specified in <i>pwszProtocol</i>; the reader object supports separate settings for each protocol.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The size of the buffer passed in is
    ///    not large enough to hold the return string. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL or invalid argument passed in. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetProxyPort(const(PWSTR) pwszProtocol, uint* pdwPort);
    ///The <b>SetProxyPort</b> method specifies the proxy port.
    ///Params:
    ///    pwszProtocol = Pointer to a wide-character null-terminated string containing the protocol.
    ///    dwPort = <b>DWORD</b> containing the name of the port.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL or invalid argument passed in. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetProxyPort(const(PWSTR) pwszProtocol, uint dwPort);
    ///The <b>GetProxyExceptionList</b> method retrieves the list of computers, domains, or addresses for which the
    ///reader object bypasses the proxy server.
    ///Params:
    ///    pwszProtocol = Pointer to a string that contains a protocol name, such as "http" or "mms". The string is not case-sensitive.
    ///    pwszExceptionList = Pointer to a buffer that receives a string containing the exception list. The returned string is a
    ///                        comma-separated list. For more information, see SetProxyExceptionList. The list applies only to the protocol
    ///                        specified in <i>pwszProtocol</i>; the reader object supports separate settings for each protocol.
    ///    pcchExceptionList = On input, pointer to a variable specifying the size of the <i>pwszExceptionList</i> buffer, in characters. On
    ///                        output, the variable contains the length of the string, including the terminating <b>null</b> character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <b>NULL</b> or invalid argument passed in.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> The
    ///    size of the buffer passed in is not large enough to hold the return string. </td> </tr> </table>
    ///    
    HRESULT GetProxyExceptionList(const(PWSTR) pwszProtocol, PWSTR pwszExceptionList, uint* pcchExceptionList);
    ///The <b>SetProxyExceptionList</b> method specifies the proxy exception list.
    ///Params:
    ///    pwszProtocol = Pointer to a wide-character null-terminated string containing the protocol.
    ///    pwszExceptionList = Pointer to a wide-character null-terminated string containing the exception list. The list must be a
    ///                        comma-separated list of hosts. Exception lists are limited to 1024 wide characters.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL or invalid argument passed in. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetProxyExceptionList(const(PWSTR) pwszProtocol, const(PWSTR) pwszExceptionList);
    ///The <b>GetProxyBypassForLocal</b> method queries whether the reader object bypasses the proxy server for local
    ///URLs.
    ///Params:
    ///    pwszProtocol = Pointer to a string that contains a protocol name, such as "http" or "mms". The string is not case-sensitive.
    ///    pfBypassForLocal = Pointer to a variable that receives a Boolean value. If the value is <b>TRUE</b>, the reader bypasses the
    ///                       proxy server when it retrieves a URL from a local host. If the value is <b>FALSE</b>, the reader always goes
    ///                       through the proxy server (if any). The returned value applies only to the protocol specified in
    ///                       <i>pwszProtocol</i>; the reader object supports separate settings for each protocol.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <b>NULL</b> or invalid argument passed in.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Insufficient memory to complete task </td> </tr> </table>
    ///    
    HRESULT GetProxyBypassForLocal(const(PWSTR) pwszProtocol, BOOL* pfBypassForLocal);
    ///The <b>SetProxyBypassForLocal</b> method specifies the configuration setting for bypassing the proxy for local
    ///hosts.
    ///Params:
    ///    pwszProtocol = Pointer to a wide-character null-terminated string containing the protocol.
    ///    fBypassForLocal = Boolean value that is True if bypassing the proxy for local hosts is to be enabled (implying that the origin
    ///                      server is on the local network).
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL or invalid argument passed in. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetProxyBypassForLocal(const(PWSTR) pwszProtocol, BOOL fBypassForLocal);
    ///The <b>GetForceRerunAutoProxyDetection</b> method ascertains whether forced rerun detection is enabled.
    ///Params:
    ///    pfForceRerunDetection = Pointer to a Boolean value that is set to True if forced rerun detection has been enabled.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL or invalid argument passed in. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetForceRerunAutoProxyDetection(BOOL* pfForceRerunDetection);
    ///The <b>SetForceRerunAutoProxyDetection</b> method enables or disables forced rerun detection.
    ///Params:
    ///    fForceRerunDetection = Boolean value that is True if forced rerun detection is to be enabled.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL or invalid argument passed in. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetForceRerunAutoProxyDetection(BOOL fForceRerunDetection);
    ///The <b>GetEnableMulticast</b> method ascertains whether multicast is enabled.
    ///Params:
    ///    pfEnableMulticast = Pointer to a Boolean value that is set to True if multicast has been enabled.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL or invalid argument passed in. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetEnableMulticast(BOOL* pfEnableMulticast);
    ///The <b>SetEnableMulticast</b> method enables or disables multicasting.
    ///Params:
    ///    fEnableMulticast = Boolean value that is True if multicasting is to be enabled.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL or invalid argument passed in. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetEnableMulticast(BOOL fEnableMulticast);
    ///The <b>GetEnableHTTP</b> method queries whether HTTP is enabled for protocol rollover.
    ///Params:
    ///    pfEnableHTTP = Pointer to a variable that receives a Boolean value. If the value is <b>TRUE</b>, the reader object includes
    ///                   HTTP when it performs protocol rollover. If the value is <b>FALSE</b>, the reader does not use HTTP for
    ///                   protocol rollover. However, the reader will still use HTTP if it is explicitly specified in the URL.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL or invalid argument passed in. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetEnableHTTP(BOOL* pfEnableHTTP);
    ///The <b>SetEnableHTTP</b> method enables or disables HTTP.
    ///Params:
    ///    fEnableHTTP = Boolean value that is True if HTTP is to be enabled. Set this value to true if the reader can use HTTP when
    ///                  selecting a protocol for streaming.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL or invalid argument passed in. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetEnableHTTP(BOOL fEnableHTTP);
    ///The <b>GetEnableUDP</b> method queries whether UDP is enabled for protocol rollover.
    ///Params:
    ///    pfEnableUDP = Pointer to a variable that receives a Boolean value. If the value is <b>TRUE</b>, the reader object includes
    ///                  UDP when it performs protocol rollover. If the value is FASLE, the reader does not use UDP for protocol
    ///                  rollover. However, the reader will still use UDP if the URL explicitly specifies a UDP-based protocol, such
    ///                  as MMSU or RTSPU.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL or invalid argument passed in. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetEnableUDP(BOOL* pfEnableUDP);
    ///The <b>SetEnableUDP</b> method enables or disables UDP.
    ///Params:
    ///    fEnableUDP = Boolean value that is True if UDP is to be enabled. Set this to true if the reader can use UDP-based MMS
    ///                 streaming when selecting a protocol for streaming.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL or invalid argument passed in. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetEnableUDP(BOOL fEnableUDP);
    ///The <b>GetEnableTCP</b> method queries whether TCP is enabled for protocol rollover.
    ///Params:
    ///    pfEnableTCP = Pointer to a variable that receives a Boolean value. If the value is <b>TRUE</b>, the reader object includes
    ///                  TCP when it performs protocol rollover. If the value is <b>FALSE</b>, the reader does not use TCP for
    ///                  protocol rollover. However, the reader will still use TCP if the URL explicitly specifies a TCP-based
    ///                  protocol, such as MMST or RTSPT.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL or invalid argument passed in. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetEnableTCP(BOOL* pfEnableTCP);
    ///The <b>SetEnableTCP</b> method enables or disables TCP.
    ///Params:
    ///    fEnableTCP = Boolean value that is True if TCP is to be enabled. Set this to true if the SDK can use TCP-based MMS
    ///                 streaming when selecting a protocol for streaming.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL or invalid argument passed in. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetEnableTCP(BOOL fEnableTCP);
    ///The <b>ResetProtocolRollover</b> method forces the reader object to use the normal protocol rollover algorithm.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT ResetProtocolRollover();
    ///The <b>GetConnectionBandwidth</b> method retrieves the connection bandwidth for the client.
    ///Params:
    ///    pdwConnectionBandwidth = Pointer to a <b>DWORD</b> containing the connection bandwidth, in bits per second.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL or invalid argument passed in. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetConnectionBandwidth(uint* pdwConnectionBandwidth);
    ///The <b>SetConnectionBandwidth</b> method specifies the connection bandwidth for the client.
    ///Params:
    ///    dwConnectionBandwidth = Specifies the maximum bandwidth for the connection, in bits per second. Specify zero for the reader to
    ///                            automatically detect the bandwidth
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL or invalid argument passed in. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetConnectionBandwidth(uint dwConnectionBandwidth);
    ///The <b>GetNumProtocolsSupported</b> method retrieves the number of supported protocols.
    ///Params:
    ///    pcProtocols = Pointer to a count of the protocols.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL or invalid argument passed in. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetNumProtocolsSupported(uint* pcProtocols);
    ///The <b>GetSupportedProtocolName</b> method retrieves a protocol name by index.
    ///Params:
    ///    dwProtocolNum = Specifies protocol name to retrieve, indexed from zero. To get the number of supported protocols, call the
    ///                    IWMReaderNetworkConfig::GetNumProtocolsSupported method.
    ///    pwszProtocolName = Pointer to a wide-character <b>null</b>-terminated string containing the protocol name. Pass <b>NULL</b> to
    ///                       retrieve the length of the name.
    ///    pcchProtocolName = On input, pointer to a <b>DWORD</b> containing the length of the <i>pwszProtocolName</i>, in characters. On
    ///                       output, pointer to the length of the protocol name, including the terminating <b>null</b> character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <b>NULL</b> or invalid argument passed in.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetSupportedProtocolName(uint dwProtocolNum, PWSTR pwszProtocolName, uint* pcchProtocolName);
    ///The <b>AddLoggingUrl</b> method specifies a server that receive logging information from the reader object.
    ///Params:
    ///    pwszUrl = Specifies a string containing the URL.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Null value passed in to <i>pwszUrl</i> </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Unable to create
    ///    or add the URL. </td> </tr> </table>
    ///    
    HRESULT AddLoggingUrl(const(PWSTR) pwszUrl);
    ///The <b>GetLoggingUrl</b> method retrieves a URL from the list of servers that receive logging information from
    ///the reader object. Use the <b>IWMReaderNetworkConfig::GetLoggingUrl</b> method to add servers to the list.
    ///Params:
    ///    dwIndex = Specifies which URL to retrieve, indexed from zero. To get the number of URLs, call the
    ///              IWMReaderNetworkConfig::GetLoggingUrlCount method.
    ///    pwszUrl = Pointer to a buffer that receives a string containing the URL. The caller must allocate the buffer.
    ///    pcchUrl = On input, specifies the length of the <i>pwszUrl</i> buffer, in characters. On output, receives the length of
    ///              the URL, including the terminating <b>null</b> character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <b>NULL</b> or invalid argument passed in.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td> <td width="60%"> Size
    ///    passed in to <i>pcchUrl</i> is too small. </td> </tr> </table>
    ///    
    HRESULT GetLoggingUrl(uint dwIndex, PWSTR pwszUrl, uint* pcchUrl);
    ///The <b>GetLoggingUrlCount</b> method retrieves the number of URLs in the current list of logging URLs.
    ///Params:
    ///    pdwUrlCount = Pointer to a <b>DWORD</b> containing the URL count.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetLoggingUrlCount(uint* pdwUrlCount);
    ///The <b>ResetLoggingUrlList</b> method clears the list of servers that receive logging data.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT ResetLoggingUrlList();
}

///The <b>IWMReaderNetworkConfig2</b> interface provides advanced networking functionality. An
///<b>IWMReaderNetworkConfig2</b> interface exists for every reader object. You can obtain a pointer to an instance of
///this interface by calling the <b>QueryInterface</b> method of any other interface of the reader object.
@GUID("D979A853-042B-4050-8387-C939DB22013F")
interface IWMReaderNetworkConfig2 : IWMReaderNetworkConfig
{
    ///The <b>GetEnableContentCaching</b> method queries whether content caching is enabled. If content caching is
    ///enabled, streaming content can be cached locally.
    ///Params:
    ///    pfEnableContentCaching = Pointer to a Boolean value that is True if content caching is enabled.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL pointer argument. </td> </tr> </table>
    ///    
    HRESULT GetEnableContentCaching(BOOL* pfEnableContentCaching);
    ///The <b>SetEnableContentCaching</b> method enables or disables content caching. If content caching is enabled,
    ///content that is being streamed can be cached locally.
    ///Params:
    ///    fEnableContentCaching = Boolean value that is True to enable content caching.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetEnableContentCaching(BOOL fEnableContentCaching);
    ///The <b>GetEnableFastCache</b> method queries whether Fast Cache streaming is enabled. Fast Cache streaming
    ///enables network content to be streamed faster than the playback rate, if bandwidth allows.
    ///Params:
    ///    pfEnableFastCache = Pointer to a variable that receives a Boolean value. The value is True if Fast Cache streaming is enabled, or
    ///                        False otherwise.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL pointer argument. </td> </tr> </table>
    ///    
    HRESULT GetEnableFastCache(BOOL* pfEnableFastCache);
    ///The <b>SetEnableFastCache</b> method enables or disables Fast Cache streaming. Fast Cache streaming enables
    ///network content to be streamed faster than the playback rate, if bandwidth allows.
    ///Params:
    ///    fEnableFastCache = Specifies whether to enable or disable Fast Cache streaming. The value True enables Fast Cache, and the value
    ///                       False disables it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetEnableFastCache(BOOL fEnableFastCache);
    ///The <b>GetAcceleratedStreamingDuration</b> method retrieves the current accelerated streaming duration. This
    ///duration applies to the Fast Start feature of Windows Media Services, which enables content to be played quickly
    ///without waiting for lengthy initial buffering.
    ///Params:
    ///    pcnsAccelDuration = Pointer to a <b>QWORD</b> that receives the accelerated streaming duration, in 100-nanosecond units. This is
    ///                        the amount of data at the beginning of the content that is streamed at an accelerated rate. The default value
    ///                        is twice the buffering duration.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL pointer argument. </td> </tr> </table>
    ///    
    HRESULT GetAcceleratedStreamingDuration(ulong* pcnsAccelDuration);
    ///The <b>SetAcceleratedStreamingDuration</b> method sets the accelerated streaming duration. This duration applies
    ///to the Fast Start feature of Windows Media Services, which enables content to be played quickly without waiting
    ///for lengthy initial buffering.
    ///Params:
    ///    cnsAccelDuration = Specifies the accelerated streaming duration, in 100-nanosecond units. The maximum value is 1,200,000,000.
    ///                       This is the amount of data at the beginning of the content that is streamed at an accelerated rate.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetAcceleratedStreamingDuration(ulong cnsAccelDuration);
    ///The <b>GetAutoReconnectLimit</b> method retrieves the maximum number of times the reader will attempt to
    ///reconnect to the server in the case of an unexpected disconnection. This feature, called Fast Reconnect, applies
    ///only to content being streamed from a server running Windows Media Services.
    ///Params:
    ///    pdwAutoReconnectLimit = Pointer to a <b>DWORD</b> containing the automatic reconnection limit.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL pointer argument. </td> </tr> </table>
    ///    
    HRESULT GetAutoReconnectLimit(uint* pdwAutoReconnectLimit);
    ///The <b>SetAutoReconnectLimit</b> method sets the maximum number of times the reader will attempt to reconnect to
    ///the server in the case of an unexpected disconnection. This feature, called Fast Reconnect, applies only to
    ///content being streamed from a server running Windows Media Services.
    ///Params:
    ///    dwAutoReconnectLimit = Specifies the maximum number of times the reader object will attempt to reconnect. To disable automatic
    ///                           reconnection, set this value to zero.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetAutoReconnectLimit(uint dwAutoReconnectLimit);
    ///The <b>GetEnableResends</b> method ascertains whether resending is enabled.
    ///Params:
    ///    pfEnableResends = Pointer to a Boolean value that is set to True if resending is enabled.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL pointer argument. </td> </tr> </table>
    ///    
    HRESULT GetEnableResends(BOOL* pfEnableResends);
    ///The <b>SetEnableResends</b> method enables or disables resends.
    ///Params:
    ///    fEnableResends = Pointer to a Boolean value that is True to enable resends.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetEnableResends(BOOL fEnableResends);
    ///The <b>GetEnableThinning</b> method ascertains whether Intelligent Streaming is enabled. Intelligent Streaming is
    ///the communication between the reader and the streaming server that enables the server to change the content sent
    ///based on available bandwidth.
    ///Params:
    ///    pfEnableThinning = Pointer to a variable that receives a Boolean value. The value is <b>TRUE</b> if thinning is enabled, or
    ///                       <b>FALSE</b> if thinning is disabled.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL pointer argument. </td> </tr> </table>
    ///    
    HRESULT GetEnableThinning(BOOL* pfEnableThinning);
    ///The <b>SetEnableThinning</b> method enables or disables Intelligent Streaming. Intelligent Streaming is the
    ///communication between the reader and the streaming server that enables the server to change the content sent
    ///based on available bandwidth.
    ///Params:
    ///    fEnableThinning = Specify <b>True</b> to enable thinning, or <b>False</b> to disable thinning.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetEnableThinning(BOOL fEnableThinning);
    ///The <b>GetMaxNetPacketSize</b> method retrieves the maximum size of packets being streamed over a network.
    ///Params:
    ///    pdwMaxNetPacketSize = Pointer to a <b>DWORD</b> containing the maximum net packet size, in bytes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL pointer argument. </td> </tr> </table>
    ///    
    HRESULT GetMaxNetPacketSize(uint* pdwMaxNetPacketSize);
}

///The <b>IWMReaderStreamClock</b> interface provides access to the clock used by the reader. This interface exists for
///every reader object. You can obtain a pointer to an instance of this interface by calling the <b>QueryInterface</b>
///method of any other interface of the reader object.
@GUID("96406BED-2B2B-11D3-B36B-00C04F6108FF")
interface IWMReaderStreamClock : IUnknown
{
    ///The <b>GetTime</b> method retrieves the current value of the stream clock.
    ///Params:
    ///    pcnsNow = Pointer to the current time of the stream clock, in 100-nanosecond units.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pcnsNow</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetTime(ulong* pcnsNow);
    ///The <b>SetTimer</b> method sets a timer on the clock.
    ///Params:
    ///    cnsWhen = Specifies the time at which the reader notifies the OnStatus callback, in 100-nanosecond units.
    ///    pvParam = Specifies a pointer to the timer context parameters that are returned in the <b>OnStatus</b> callback.
    ///    pdwTimerId = Pointer to a <b>DWORD</b> containing the timer identifier.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pdwTimerId</i> is <b>NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough available
    ///    memory. </td> </tr> </table>
    ///    
    HRESULT SetTimer(ulong cnsWhen, void* pvParam, uint* pdwTimerId);
    ///The <b>KillTimer</b> method cancels a timer that has been set on the clock.
    ///Params:
    ///    dwTimerId = <b>DWORD</b> containing the timer identifier.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT KillTimer(uint dwTimerId);
}

///The <b>IWMIndexer</b> interface is used to create an index for ASF files to enable seeking. An index is created only
///for a file that contains video, although the indexer can safely be used on files that do not contain any video. An
///index is an object in the ASF file that equates video samples with presentation times. This is important because the
///timing of video frames is not necessarily easily computed from the frame rate. In addition to the standard temporal
///index, the indexer object can create indexes based on video frame number and SMPTE time code. For more information
///about creating these indexes, see IWMIndexer2::Configure. This interface can be obtained by using the WMCreateIndexer
///function.
@GUID("6D7CDC71-9888-11D3-8EDC-00C04F6109CF")
interface IWMIndexer : IUnknown
{
    ///The <b>StartIndexing</b> method initiates indexing. If you configure the indexer using the IWMIndexer2::Configure
    ///method, <b>StartIndexing</b> creates an index based upon your configuration. When you use <b>StartIndexing</b>
    ///without first calling <b>Configure</b>, the indexer creates a default temporal index.
    ///Params:
    ///    pwszURL = Pointer to a wide-character <b>null</b>-terminated string containing the URL or file name.
    ///    pCallback = Pointer to an IWMStatusCallback interface.
    ///    pvContext = Generic pointer, for use by the application.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The parameter <i>pwszURL</i> or
    ///    <i>pCallback</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_BUSY</b></dt> </dl> </td>
    ///    <td width="60%"> The method cannot start indexing in the current state. </td> </tr> </table>
    ///    
    HRESULT StartIndexing(const(PWSTR) pwszURL, IWMStatusCallback pCallback, void* pvContext);
    ///The <b>Cancel</b> method cancels the current indexing operation.
    ///Returns:
    ///    This method always returns S_OK.
    ///    
    HRESULT Cancel();
}

///The <b>IWMIndexer2</b> interface enables you to change the settings of the indexer object to suit your needs. This
///interface is implemented as part of the indexer object. To obtain a pointer to <b>IWMIndexer2</b>, call the
///<b>QueryInterface</b> method of the <b>IWMIndexer</b> interface.
@GUID("B70F1E42-6255-4DF0-A6B9-02B212D9E2BB")
interface IWMIndexer2 : IWMIndexer
{
    ///The <b>Configure</b> method changes the internal settings of the indexer object. You can use <b>Configure</b> to
    ///activate frame-based indexing or SMPTE time code indexing. <b>Configure</b> does not create an index, it just
    ///configures the indexer object. After you have changed the desired settings, you must call
    ///IWMIndexer::StartIndexing to create the index.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number for which an index is to be made. If you pass 0, all streams will be
    ///                 indexed.
    ///    nIndexerType = A variable containing one member of the WMT_INDEXER_TYPE enumeration type.
    ///    pvInterval = This void pointer must point to a <b>DWORD</b> containing the desired indexing interval. Intervals for
    ///                 temporal indexing are in milliseconds. Frame-based index intervals are specified in frames. If you pass
    ///                 <b>NULL</b>, <b>Configure</b> will use the default value. For temporal indexes, the default value is 3000
    ///                 milliseconds, for frame-based indexes it is 10 frames.
    ///    pvIndexType = This void pointer must point to a <b>WORD</b> value containing one member of the WMT_INDEX_TYPE enumeration
    ///                  type. If you pass <b>NULL</b>, <b>Configure</b> will use the default value. The default value is
    ///                  WMT_IT_NEAREST_CLEAN_POINT. Using another index type degrades seeking performance.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method is unable to add the stream number
    ///    to its internal list. </td> </tr> </table>
    ///    
    HRESULT Configure(ushort wStreamNum, WMT_INDEXER_TYPE nIndexerType, void* pvInterval, void* pvIndexType);
}

///<p class="CCE_Message">[<b>IWMLicenseBackup</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady. ]
///The <b>IWMLicenseBackup</b> interface manages the backing up of licenses, typically so that they can be restored onto
///another computer. This interface is obtained by using the WMCreateBackupRestorer function.
@GUID("05E5AC9F-3FB6-4508-BB43-A4067BA1EBE8")
interface IWMLicenseBackup : IUnknown
{
    ///<p class="CCE_Message">[<b>BackupLicenses</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>BackupLicenses</b> method saves copies of the licenses.
    ///Params:
    ///    dwFlags = <b>DWORD</b> containing the flags. <table> <tr> <th>Flag </th> <th>Description </th> </tr> <tr>
    ///              <td>WM_BACKUP_OVERWRITE</td> <td>Indicates that any existing backup file should be overwritten. If this is
    ///              not set, and a backup file exists, the NS_E_DRM_BACKUP_EXISTS error code is returned.</td> </tr> </table>
    ///    pCallback = Pointer to an object that implements the IWMStatusCallback interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pCallback</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough
    ///    memory available to perform the task. </td> </tr> </table>
    ///    
    HRESULT BackupLicenses(uint dwFlags, IWMStatusCallback pCallback);
    ///<p class="CCE_Message">[<b>CancelLicenseBackup</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>CancelLicenseBackup</b> method cancels a current backup operation.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT CancelLicenseBackup();
}

///<p class="CCE_Message">[<b>IWMLicenseRestore</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady. ]
///The <b>IWMLicenseRestore</b> interface manages the restoring of licenses. This interface is obtained from another
///interface on the backup restorer object.
@GUID("C70B6334-A22E-4EFB-A245-15E65A004A13")
interface IWMLicenseRestore : IUnknown
{
    ///<p class="CCE_Message">[<b>RestoreLicenses</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>RestoreLicenses</b> method restores licenses that were previously backed up.
    ///Params:
    ///    dwFlags = <b>DWORD</b> containing the flags. <table> <tr> <th>Flag </th> <th>Description </th> </tr> <tr>
    ///              <td>WM_RESTORE_INDIVIDUALIZE</td> <td>Indicates that the application has received permission from the user to
    ///              individualize their computer. (See Individualizing DRM Applications section.)</td> </tr> </table>
    ///    pCallback = Pointer to an IWMStatusCallback interface.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RestoreLicenses(uint dwFlags, IWMStatusCallback pCallback);
    ///<p class="CCE_Message">[<b>CancelLicenseRestore</b> is available for use in the operating systems specified in
    ///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft
    ///PlayReady. ] The <b>CancelLicenseRestore</b> method cancels a current restore operation.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT CancelLicenseRestore();
}

///<p class="CCE_Message">[<b>IWMBackupRestoreProps</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady. ]
///The <b>IWMBackupRestoreProps</b> interface sets and retrieves properties required by the IWMLicenseBackup and
///IWMLicenseRestore interfaces. This interface can be obtained from the backup restorer object.
@GUID("3C8E0DA6-996F-4FF3-A1AF-4838F9377E2E")
interface IWMBackupRestoreProps : IUnknown
{
    ///<p class="CCE_Message">[<b>GetPropCount</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>GetPropCount</b> method retrieves the number of properties. This method is not implemented.
    ///Params:
    ///    pcProps = Pointer to a count of the properties.
    ///Returns:
    ///    The method returns E_NOTIMPL.
    ///    
    HRESULT GetPropCount(ushort* pcProps);
    ///<p class="CCE_Message">[<b>GetPropByIndex</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>GetPropByIndex</b> method retrieves the name and value of a property by index. This method is not
    ///implemented.
    ///Params:
    ///    wIndex = <b>WORD</b> containing the index of the property.
    ///    pwszName = Pointer to a wide-character <b>null</b>-terminated string containing the name.
    ///    pcchNameLen = On input, contains the length of <i>pwszName</i>. On output, points to a variable containing the number of
    ///                  characters in <i>pwszName</i>, including the terminating <b>null</b> character.
    ///    pType = Pointer to a variable containing one member of the WMT_ATTR_DATATYPE enumeration type.
    ///    pValue = Pointer to a byte array containing the value of the property.
    ///    pcbLength = On input, contains the length of <i>pValue</i>. On output, points to a count of the bytes in <i>pValue</i>
    ///                that are used.
    ///Returns:
    ///    The method returns E_NOTIMPL.
    ///    
    HRESULT GetPropByIndex(ushort wIndex, PWSTR pwszName, ushort* pcchNameLen, WMT_ATTR_DATATYPE* pType, 
                           ubyte* pValue, ushort* pcbLength);
    ///<p class="CCE_Message">[<b>GetPropByName</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>GetPropByName</b> method retrieves the value of a property by name. This method is not implemented.
    ///Params:
    ///    pszName = Pointer to a wide-character <b>null</b>-terminated string containing the name.
    ///    pType = Pointer to a variable containing one member of the <b>WMT_ATTR_DATATYPE</b> enumeration type.
    ///    pValue = Pointer to a byte array containing the value of the property.
    ///    pcbLength = On input, contains the length of <i>pValue</i>. On output, points to a count of the bytes in <i>pValue</i>
    ///                that are used.
    ///Returns:
    ///    The method returns E_NOTIMPL.
    ///    
    HRESULT GetPropByName(const(PWSTR) pszName, WMT_ATTR_DATATYPE* pType, ubyte* pValue, ushort* pcbLength);
    HRESULT SetPropA(const(PWSTR) pszName, WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, ushort cbLength);
    HRESULT RemovePropA(const(PWSTR) pcwszName);
    ///<p class="CCE_Message">[<b>RemoveAllProps</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>RemoveAllProps</b> method removes all properties.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RemoveAllProps();
}

///The <b>IWMCodecInfo</b> interface retrieves the number and types of codecs available. You can use this interface to
///get information about supported compressed data formats for creating custom profiles. Individual codec formats exist
///only for audio codecs. The characteristics of compressed video will vary based upon the frame size and color depth of
///the original digital media and, therefore, cannot be predicted until the time of encoding. An <b>IWMCodecInfo</b>
///interface exists for each profile manager object. You can obtain a pointer to an instance of this interface by
///calling the <b>QueryInterface</b> method of any other interface in the profile manager object, typically
///<b>IWMProfileManager</b>. The methods of the <b>IWMCodecInfo</b> interface are inherited by <b>IWMCodecInfo2</b> and
///<b>IWMCodecInfo3</b>.
@GUID("A970F41E-34DE-4A98-B3BA-E4B3CA7528F0")
interface IWMCodecInfo : IUnknown
{
    ///The <b>GetCodecInfoCount</b> method retrieves the number of supported codecs for a specified major type of
    ///digital media (audio or video).
    ///Params:
    ///    guidType = <b>GUID</b> identifying the major type of digital media. This must be one of the following constants. <table>
    ///               <tr> <th>Constant </th> <th>Description </th> </tr> <tr> <td>WMMEDIATYPE_Video</td> <td>Specifies a video
    ///               codec.</td> </tr> <tr> <td>WMMEDIATYPE_Audio</td> <td>Specifies an audio codec.</td> </tr> </table>
    ///    pcCodecs = Pointer to a count of supported codecs.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pcCodecs</i> has been passed a null value.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>guidType</i> is not a type for which codecs are used. </td> </tr> </table>
    ///    
    HRESULT GetCodecInfoCount(const(GUID)* guidType, uint* pcCodecs);
    ///The <b>GetCodecFormatCount</b> method retrieves the number of formats supported by the specified codec. Each
    ///codec format is a stream configuration that is valid for use with the codec.
    ///Params:
    ///    guidType = <b>GUID</b> identifying the major type of digital media. This must be one of the following constants. <table>
    ///               <tr> <th>Constant </th> <th>Description </th> </tr> <tr> <td>WMMEDIATYPE_Video</td> <td>Specifies a video
    ///               codec.</td> </tr> <tr> <td>WMMEDIATYPE_Audio</td> <td>Specifies an audio codec.</td> </tr> </table>
    ///    dwCodecIndex = <b>DWORD</b> containing the codec index ranging from zero to one less than the number of supported codecs of
    ///                   the type specified by <i>guidType</i>. To retrieve the number of individual codecs supporting a major media
    ///                   type, use the IWMCodecInfo::GetCodecInfoCount method.
    ///    pcFormat = Pointer to a count of the formats supported by the codec.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pcFormat</i> has been passed a null value.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Other
    ///    unspecified failure. </td> </tr> </table>
    ///    
    HRESULT GetCodecFormatCount(const(GUID)* guidType, uint dwCodecIndex, uint* pcFormat);
    ///The <b>GetCodecFormat</b> method retrieves one format supported by a specified codec. This method retrieves a
    ///pointer to the IWMStreamConfig interface of a stream configuration object containing the stream settings for the
    ///supported format.
    ///Params:
    ///    guidType = <b>GUID</b> identifying the major type of digital media. This must be one of the following constants. <table>
    ///               <tr> <th>Constant </th> <th>Description </th> </tr> <tr> <td>WMMEDIATYPE_Video</td> <td>Specifies a video
    ///               codec.</td> </tr> <tr> <td>WMMEDIATYPE_Audio</td> <td>Specifies an audio codec.</td> </tr> </table>
    ///    dwCodecIndex = <b>DWORD</b> containing the codec index ranging from zero to one less than the number of supported codecs of
    ///                   the type specified by <i>guidType</i>. To retrieve the number of individual codecs supporting a major type,
    ///                   use the IWMCodecInfo::GetCodecInfoCount method.
    ///    dwFormatIndex = <b>DWORD</b> containing the format index ranging from zero to one less than the number of supported formats.
    ///                    To retrieve the number of individual formats supported by a codec, use the IWMCodecInfo::GetCodecFormatCount
    ///                    method.
    ///    ppIStreamConfig = Pointer to a pointer to the IWMStreamConfig interface of a stream configuration object containing the
    ///                      settings of the specified format.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An invalid or null value has been passed in.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetCodecFormat(const(GUID)* guidType, uint dwCodecIndex, uint dwFormatIndex, 
                           IWMStreamConfig* ppIStreamConfig);
}

///The <b>IWMCodecInfo2</b> interface manages the retrieval of information about codecs. To access it, call
///<b>QueryInterface</b> on a profile manager object.
@GUID("AA65E273-B686-4056-91EC-DD768D4DF710")
interface IWMCodecInfo2 : IWMCodecInfo
{
    ///The <b>GetCodecName</b> method retrieves the name of a specified codec.
    ///Params:
    ///    guidType = GUID identifying the major type of digital media. This must be one of the following constants. <table> <tr>
    ///               <th>Constant </th> <th>Description </th> </tr> <tr> <td>WMMEDIATYPE_Video</td> <td>Specifies a video
    ///               codec.</td> </tr> <tr> <td>WMMEDIATYPE_Audio</td> <td>Specifies an audio codec.</td> </tr> </table>
    ///    dwCodecIndex = <b>DWORD</b> containing the codec index ranging from zero to one less than the number of supported codecs of
    ///                   the type specified by <i>guidType</i>. To retrieve the number of individual codecs supporting a major type,
    ///                   use the IWMCodecInfo::GetCodecInfoCount method.
    ///    wszName = Pointer to a wide-character <b>null</b>-terminated string that receives the codec name.
    ///    pcchName = On input, pointer to a <b>DWORD</b> containing the size, in wide characters, of the buffer <i>wszName</i>. On
    ///               output, pointer to a variable containing the number of characters in <i>wszName</i>, including the
    ///               terminating <b>null</b> character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An invalid or <b>null</b> value has been
    ///    passed in. </td> </tr> </table>
    ///    
    HRESULT GetCodecName(const(GUID)* guidType, uint dwCodecIndex, PWSTR wszName, uint* pcchName);
    ///The <b>GetCodecFormatDesc</b> method retrieves a description of a specified codec format. This method also
    ///retrieves a stream configuration object containing the settings for the codec format.
    ///Params:
    ///    guidType = GUID identifying the major type of digital media. This must be one of the following constants. <table> <tr>
    ///               <th>Constant </th> <th>Description </th> </tr> <tr> <td>WMMEDIATYPE_Video</td> <td>Specifies a video
    ///               codec.</td> </tr> <tr> <td>WMMEDIATYPE_Audio</td> <td>Specifies an audio codec.</td> </tr> </table>
    ///    dwCodecIndex = <b>DWORD</b> containing the codec index ranging from zero to one less than the number of supported codecs of
    ///                   the type specified by <i>guidType</i>. To retrieve the number of individual codecs supporting a major type,
    ///                   use the IWMCodecInfo::GetCodecInfoCount method.
    ///    dwFormatIndex = <b>DWORD</b> containing the format index ranging from zero to one less than the number of supported formats.
    ///                    To retrieve the number of individual formats supported by a codec, use the IWMCodecInfo::GetCodecFormatCount
    ///                    method.
    ///    ppIStreamConfig = Pointer to a pointer to the IWMStreamConfig interface of a stream configuration object containing the
    ///                      settings of the specified format. When calling <b>GetCodecFormatDesc</b> to retrieve the size of the
    ///                      description string, pass <b>NULL</b> for this parameter.
    ///    wszDesc = Pointer to a wide-character <b>null</b>-terminated string containing the codec format description.
    ///    pcchDesc = On input, a pointer to the length of the <i>wszDesc</i> buffer. On output, a pointer to the length of the
    ///               codec format description string, including the terminating <b>null</b> character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An invalid or <b>null</b> value has been
    ///    passed in. </td> </tr> </table>
    ///    
    HRESULT GetCodecFormatDesc(const(GUID)* guidType, uint dwCodecIndex, uint dwFormatIndex, 
                               IWMStreamConfig* ppIStreamConfig, PWSTR wszDesc, uint* pcchDesc);
}

///The <b>IWMCodecInfo3</b> interface retrieves properties from a codec. You can retrieve a pointer to
///<b>IWMCodecInfo3</b> with a call to the <b>QueryInterface</b> method of any other interface of the profile manager
///object.
@GUID("7E51F487-4D93-4F98-8AB4-27D0565ADC51")
interface IWMCodecInfo3 : IWMCodecInfo2
{
    ///The <b>GetCodecFormatProp</b> method retrieves a property from one format of a codec.
    ///Params:
    ///    guidType = GUID identifying the major type of digital media. This must be one of the following constants. <table> <tr>
    ///               <th>Constant </th> <th>Description </th> </tr> <tr> <td>WMMEDIATYPE_Video</td> <td>Specifies a video
    ///               codec.</td> </tr> <tr> <td>WMMEDIATYPE_Audio</td> <td>Specifies an audio codec.</td> </tr> </table>
    ///    dwCodecIndex = <b>DWORD</b> containing the codec index ranging from zero to one less than the number of supported codecs of
    ///                   the type specified by <i>guidType</i>. To retrieve the number of individual codecs supporting a major type,
    ///                   use the IWMCodecInfo::GetCodecInfoCount method.
    ///    dwFormatIndex = <b>DWORD</b> containing the format index ranging from zero to one less than the number of supported formats.
    ///                    To retrieve the number of individual formats supported by a codec, use the IWMCodecInfo::GetCodecFormatCount
    ///                    method.
    ///    pszName = Pointer to a wide-character <b>null</b>-terminated string containing the name of the property to retrieve.
    ///              Currently only one codec format property is supported; it is listed in the following table. The format
    ///              property determines the data type and value of the property; this information is included in the table.
    ///              <table> <tr> <th>Global constant </th> <th>Data type </th> <th>Description </th> </tr> <tr>
    ///              <td>g_wszSpeechCaps</td> <td><b>WMT_TYPE_DWORD</b></td> <td>The value is one from the
    ///              WMT_MUSICSPEECH_CLASS_MODE enumeration type indicating the supported mode of the format. This property
    ///              applies only to the Windows Media Audio 9 Voice codec.</td> </tr> </table>
    ///    pType = Pointer to a variable that will receive a member of the <b>WMT_ATTR_DATATYPE</b> enumeration type. This value
    ///            specifies the type of information returned to the buffer pointed to by <i>pValue</i>.
    ///    pValue = Pointer to a buffer that will receive the value of the property. The data returned is of a type specified by
    ///             <i>pType</i>.
    ///    pdwSize = Pointer to a <b>DWORD</b> value specifying the length of the buffer pointed to by <i>pValue</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pszName</i> or <i>pType</i> or
    ///    <i>pdwSize</i> is <b>NULL</b>. OR <i>guidType</i> specifies an invalid input type. OR <i>pszName</i>
    ///    specifies an invalid property name. </td> </tr> </table>
    ///    
    HRESULT GetCodecFormatProp(const(GUID)* guidType, uint dwCodecIndex, uint dwFormatIndex, const(PWSTR) pszName, 
                               WMT_ATTR_DATATYPE* pType, ubyte* pValue, uint* pdwSize);
    ///The <b>GetCodecProp</b> method retrieves a codec property.
    ///Params:
    ///    guidType = GUID identifying the major type of digital media. This must be one of the following constants. <table> <tr>
    ///               <th>Constant </th> <th>Description </th> </tr> <tr> <td>WMMEDIATYPE_Video</td> <td>Specifies a video
    ///               codec.</td> </tr> <tr> <td>WMMEDIATYPE_Audio</td> <td>Specifies an audio codec.</td> </tr> </table>
    ///    dwCodecIndex = <b>DWORD</b> containing the codec index ranging from zero to one less than the number of supported codecs of
    ///                   the type specified by <i>guidType</i>. To retrieve the number of individual codecs supporting a major type,
    ///                   use the IWMCodecInfo::GetCodecInfoCount method.
    ///    pszName = Pointer to a <b>null</b>-terminated string containing the name of the property to retrieve. The following
    ///              table lists the codec properties you can retrieve. The property dictates the data type and value; this
    ///              information is also included in the table. <table> <tr> <th>Global constant </th> <th>Data type </th>
    ///              <th>Description </th> </tr> <tr> <td>g_wszComplexityMax</td> <td><b>WMT_TYPE_DWORD</b></td> <td>The value is
    ///              the maximum complexity value for the codec. Codec complexity applies only to video codecs. The range of
    ///              complexity values is from 0 to this value.</td> </tr> <tr> <td>g_wszComplexityOffline</td>
    ///              <td><b>WMT_TYPE_DWORD</b></td> <td>The value is the suggested complexity value for the codec when encoding
    ///              files for local playback. Codec complexity applies only to video codecs. The range of complexity values is
    ///              from 0 to the value retrieved with g_wszComplexityMax.</td> </tr> <tr> <td>g_wszComplexityLive</td>
    ///              <td><b>WMT_TYPE_DWORD</b></td> <td>The value is the suggested complexity value for the codec when encoding
    ///              files for streaming playback. Codec complexity applies only to video codecs. The range of complexity values
    ///              is from 0 to the value retrieved with g_wszComplexityMax.</td> </tr> <tr> <td>g_wszIsVBRSupported</td>
    ///              <td><b>WMT_TYPE_BOOL</b></td> <td>The value indicates whether the codec supports VBR.</td> </tr> </table>
    ///    pType = Pointer to a variable that will receive a member of the <b>WMT_ATTR_DATATYPE</b> enumeration type. This value
    ///            specifies the type of information returned to the buffer at <i>pValue</i>.
    ///    pValue = Pointer to a buffer that will receive the value of the property. The data returned is of a type specified by
    ///             <i>pType</i>.
    ///    pdwSize = Pointer to a <b>DWORD</b> value specifying the length of the buffer at <i>pValue</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>pszName</i> or <i>pType</i> or
    ///    <i>pdwSize</i> is <b>NULL</b>. OR <i>guidType</i> specifies an invalid input type. OR <i>pszName</i>
    ///    specifies an invalid property name. </td> </tr> </table>
    ///    
    HRESULT GetCodecProp(const(GUID)* guidType, uint dwCodecIndex, const(PWSTR) pszName, WMT_ATTR_DATATYPE* pType, 
                         ubyte* pValue, uint* pdwSize);
    ///The <b>SetCodecEnumerationSetting</b> method sets the value of one codec enumeration setting. Codec enumeration
    ///settings dictate the codec formats that can be enumerated by the methods of IWMCodecInfo.
    ///Params:
    ///    guidType = GUID identifying the major type of digital media. This must be one of the following constants. <table> <tr>
    ///               <th>Constant </th> <th>Description </th> </tr> <tr> <td>WMMEDIATYPE_Video</td> <td>Specifies a video
    ///               codec.</td> </tr> <tr> <td>WMMEDIATYPE_Audio</td> <td>Specifies an audio codec.</td> </tr> </table>
    ///    dwCodecIndex = <b>DWORD</b> containing the codec index ranging from zero to one less than the number of supported codecs of
    ///                   the type specified by <i>guidType</i>. To retrieve the number of individual codecs supporting a major type,
    ///                   use the IWMCodecInfo::GetCodecInfoCount method.
    ///    pszName = Pointer to a wide-character null-terminated string containing the name of the enumeration setting. Use one of
    ///              the following constants. <table> <tr> <th>Constant </th> <th>Description </th> </tr> <tr>
    ///              <td>g_wszVBREnabled</td> <td>Use to enumerate the supported codec formats that use variable bit rate (VBR)
    ///              encoding.The value returned in <i>pValue</i> is a <b>BOOL</b>. </td> </tr> <tr> <td>g_wszNumPasses</td>
    ///              <td>Use to enumerate the supported codec formats that use a number of passes equal to the value in
    ///              <i>pValue</i>.The value returned in <i>pValue</i> is a <b>DWORD</b> specifying the number of passes. </td>
    ///              </tr> </table>
    ///    Type = A WMT_ATTR_DATATYPE value specifying the data type of the value in <i>pValue</i>.
    ///    pValue = A pointer to a <b>BYTE</b> array containing the setting value.
    ///    dwSize = <b>DWORD</b> containing the size of the <i>pValue</i> <b>BYTE</b> array.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded; the feature is supported by the
    ///    codec. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_UNSUPPORTED_PROPERTY</b></dt> </dl> </td> <td
    ///    width="60%"> The enumeration setting specified is not valid for the codec. </td> </tr> </table>
    ///    
    HRESULT SetCodecEnumerationSetting(const(GUID)* guidType, uint dwCodecIndex, const(PWSTR) pszName, 
                                       WMT_ATTR_DATATYPE Type, const(ubyte)* pValue, uint dwSize);
    ///The <b>GetCodecEnumerationSetting</b> method retrieves the current value for one codec enumeration setting. Codec
    ///enumeration settings dictate the codec formats that can be enumerated by the methods of IWMCodecInfo. You can
    ///change codec enumeration settings in order to retrieve codec formats supporting specific features by calling
    ///IWMCodecInfo3::SetCodecEnumerationSetting.
    ///Params:
    ///    guidType = GUID identifying the major type of digital media. This must be one of the following constants. <table> <tr>
    ///               <th>Constant </th> <th>Description </th> </tr> <tr> <td>WMMEDIATYPE_Video</td> <td>Specifies a video
    ///               codec.</td> </tr> <tr> <td>WMMEDIATYPE_Audio</td> <td>Specifies an audio codec.</td> </tr> </table>
    ///    dwCodecIndex = <b>DWORD</b> containing the codec index ranging from zero to one less than the number of supported codecs of
    ///                   the type specified by <i>guidType</i>. To retrieve the number of individual codecs supporting a major type,
    ///                   use the IWMCodecInfo::GetCodecInfoCount method.
    ///    pszName = Pointer to a wide-character <b>null</b>-terminated string containing the name of the enumeration setting. Use
    ///              one of the following constants. <table> <tr> <th>Constant </th> <th>Description </th> </tr> <tr>
    ///              <td>g_wszVBREnabled</td> <td>Use to enumerate the supported codec formats that use variable bit rate (VBR)
    ///              encoding.The value returned in <i>pValue</i> is a <b></b>BOOL. </td> </tr> <tr> <td>g_wszNumPasses</td>
    ///              <td>Use to enumerate the supported codec formats that use a number of passes equal to the value in
    ///              <i>pValue</i>.The value returned in <i>pValue</i> is a <b>DWORD</b> specifying the number of passes. </td>
    ///              </tr> </table>
    ///    pType = Pointer to a WMT_ATTR_DATATYPE enumeration value specifying the data type of the value returned in
    ///            <i>pValue</i>.
    ///    pValue = Pointer to a <b>BYTE</b> array containing the codec enumeration data. The data type and meaning of the data
    ///             returned in this array depends on the setting specified by <i>pszName</i>. You can set this value to
    ///             <b>NULL</b> to retrieve the required size of the array in <i>pdwSize</i>.
    ///    pdwSize = Pointer to a <b>DWORD</b> containing the size of the setting value in bytes. If you set <i>pValue</i> to
    ///              <b>NULL</b>, this value will be set to the size required to hold the setting value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_UNSUPPORTED_PROPERTY</b></dt> </dl> </td> <td width="60%"> The enumeration setting specified
    ///    is not valid for the codec. </td> </tr> </table>
    ///    
    HRESULT GetCodecEnumerationSetting(const(GUID)* guidType, uint dwCodecIndex, const(PWSTR) pszName, 
                                       WMT_ATTR_DATATYPE* pType, ubyte* pValue, uint* pdwSize);
}

///The <b>IWMLanguageList</b> interface manages a list of languages supported by an ASF file. This interface supports
///both content and metadata in multiple languages. The <b>IWMLanguageList</b> interface is supported in the profile,
///writer, metadata editor, reader, and synchronous reader objects. A pointer to an instance of <b>IWMLanguageList</b>
///can be obtained by calling the <b>QueryInterface</b> method of any interface in one of the listed objects. <div
///class="alert"><b>Important</b> Do not use this interface before opening the reader object.</div> <div> </div>
@GUID("DF683F00-2D49-4D8E-92B7-FB19F6A0DC57")
interface IWMLanguageList : IUnknown
{
    ///The <b>GetLanguageCount</b> method retrieves the total number of supported languages in the language list.
    ///Params:
    ///    pwCount = Pointer to a <b>WORD</b> containing the total number of languages present in the language list.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetLanguageCount(ushort* pwCount);
    ///The <b>GetLanguageDetails</b> method retrieves the RFC 1766-compliant language tag for an entry in the list of
    ///supported languages.
    ///Params:
    ///    wIndex = <b>WORD</b> containing the index in the language list.
    ///    pwszLanguageString = Pointer to the RFC 1766-compliant language tag of the language list entry specified by <i>wIndex</i>. Pass
    ///                         <b>NULL</b> to retrieve the length of the string, which will be returned in <i>pcbLanguageStringLength</i>.
    ///    pcchLanguageStringLength = Pointer to a <b>WORD</b> containing the length of the language string, in wide characters. This length
    ///                               includes the terminating <b>null</b> character.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetLanguageDetails(ushort wIndex, PWSTR pwszLanguageString, ushort* pcchLanguageStringLength);
    ///The <b>AddLanguageByRFC1766String</b> method adds an entry to the list of supported languages for a file based
    ///upon a language tag compliant with RFC 1766.
    ///Params:
    ///    pwszLanguageString = Pointer to a wide-character null-terminated string containing an RFC 1766-compliant language tag.
    ///    pwIndex = Pointer to a <b>WORD</b>. On output, this will be set to the index assigned to the added language entry.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT AddLanguageByRFC1766String(PWSTR pwszLanguageString, ushort* pwIndex);
}

///The <b>IWMWriterPushSink</b> interface enables the application to send ASF files to a publishing point on a Windows
///Media server. The writer push sink object exposes this interface. To create an instance of the writer push sink, call
///the WMCreateWriterPushSink function.
@GUID("DC10E6A5-072C-467D-BF57-6330A9DDE12A")
interface IWMWriterPushSink : IWMWriterSink
{
    ///The <b>Connect</b> method connects to a publishing point on a Windows Media server.
    ///Params:
    ///    pwszURL = Wide-character string that contains the URL of the publishing point on the Windows Media server. For example,
    ///              if the URL is "http://MyServer/MyPublishingPoint", the push sink connects to the publishing point named
    ///              MyPublishingPoint on the server named MyServer. The default port number is 80. If the server is using a
    ///              different port, specify the port number in the URL. For example, "http://MyServer:8080/MyPublishingPoint"
    ///              specifies port number 8080.
    ///    pwszTemplateURL = Optional wide-character string that contains the URL of an existing publishing point to use as a template.
    ///                      This parameter can be <b>NULL</b>.
    ///    fAutoDestroy = Boolean value that specifies whether to remove the publishing point after the push sink disconnects from the
    ///                   server.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid argument; <i>pwszURL</i> cannot be
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Insufficient memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_INVALID_NAME</b></dt>
    ///    </dl> </td> <td width="60%"> Host name is not valid. </td> </tr> </table>
    ///    
    HRESULT Connect(const(PWSTR) pwszURL, const(PWSTR) pwszTemplateURL, BOOL fAutoDestroy);
    ///The <b>Disconnect</b> method disconnects the push sink from the server.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Disconnect();
    ///The <b>EndSession</b> method ends the push distribution session. This method sends an end-of-stream message to
    ///the server, and then shuts down the data path on the server.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_CONNECTION_FAILURE</b></dt> </dl> </td> <td width="60%"> A connection failure occurred.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_NOCONNECTION</b></dt> </dl> </td> <td width="60%"> There
    ///    is no connection to the server. (Possibly this method was called before any connection was made.) </td> </tr>
    ///    </table>
    ///    
    HRESULT EndSession();
}

///<p class="CCE_Message">[<b>IWMDeviceRegistration</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady. ]
///The <b>IWMDeviceRegistration</b> interface registers playback devices for secure data delivery. You can create a
///device registration object and retrieve a pointer to its <b>IWMDeviceRegistration</b> interface by calling the
///WMCreateDeviceRegistration function.
@GUID("F6211F03-8D21-4E94-93E6-8510805F2D99")
interface IWMDeviceRegistration : IUnknown
{
    ///<p class="CCE_Message">[<b>RegisterDevice</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>RegisterDevice</b> method adds a device to the device list.
    ///Params:
    ///    dwRegisterType = The type of the device to register. Devices that support Windows Media DRM 10 for Network Devices use
    ///                     DRM_DEVICE_REGISTER_TYPE_STREAMING. To register a device that does not use Windows Media DRM 10 for Network
    ///                     Devices, set this parameter to 0.
    ///    pbCertificate = Address of the device certificate in memory.
    ///    cbCertificate = The size of the certificate data in bytes.
    ///    SerialNumber = 128-bit device identifier, stored in a DRM_VAL16 structure.
    ///    ppDevice = Address of a variable that receives a pointer to the IWMRegisteredDevice interface of the newly registered
    ///               device.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pbCertificate</i> parameter is
    ///    <b>NULL</b>, but the <i>cbCertificate</i> parameter is greater than zero. OR The <i>dwRegisterType</i>
    ///    parameter is set to DRM_DEVICE_REGISTER_TYPE_STREAMING, but no certificate is provided. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate
    ///    memory for an internal variable. </td> </tr> </table>
    ///    
    HRESULT RegisterDevice(uint dwRegisterType, ubyte* pbCertificate, uint cbCertificate, DRM_VAL16 SerialNumber, 
                           IWMRegisteredDevice* ppDevice);
    ///<p class="CCE_Message">[<b>UnregisterDevice</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>UnregisterDevice</b> method removes a device from the device registration database.
    ///Params:
    ///    dwRegisterType = <b>DWORD</b> containing the type of the device to remove. Devices that support Windows Media DRM 10 for
    ///                     Network Devices use the DRM_DEVICE_REGISTER_TYPE_STREAMING register type.
    ///    pbCertificate = Address of the device certificate in memory.
    ///    cbCertificate = The size of the certificate data in bytes.
    ///    SerialNumber = 128-bit device identifier, stored in a DRM_VAL16 structure.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pbCertificate</i> parameter is
    ///    <b>NULL</b>, but the <i>cbCertificate</i> parameter is greater than zero. </td> </tr> </table>
    ///    
    HRESULT UnregisterDevice(uint dwRegisterType, ubyte* pbCertificate, uint cbCertificate, DRM_VAL16 SerialNumber);
    ///<p class="CCE_Message">[<b>GetRegistrationStats</b> is available for use in the operating systems specified in
    ///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft
    ///PlayReady. ] The <b>GetRegistrationStats</b> method retrieves the number of devices in the device registration
    ///database that have a specified type.
    ///Params:
    ///    dwRegisterType = The type of the device for which to retrieve the count. Devices that support Windows Media DRM 10 for Network
    ///                     Devices use the DRM_DEVICE_REGISTER_TYPE_STREAMING register type.
    ///    pcRegisteredDevices = Address of a variable that receives the number of registered devices of the specified type.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pcRegisteredDevices</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetRegistrationStats(uint dwRegisterType, uint* pcRegisteredDevices);
    ///<p class="CCE_Message">[<b>GetFirstRegisteredDevice</b> is available for use in the operating systems specified
    ///in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft
    ///PlayReady. ] The <b>GetFirstRegisteredDevice</b> method retrieves information about the first device of a
    ///specified type that is in the device registration database.
    ///Params:
    ///    dwRegisterType = The type of device for which to retrieve information. Devices that support Windows Media DRM 10 for Network
    ///                     Devices use the DRM_DEVICE_REGISTER_TYPE_STREAMING register type.
    ///    ppDevice = Address of a variable that receives a pointer to an IWMRegisteredDevice interface. This interface provides
    ///               access to information about the first registered device in the database that matches the type specified by
    ///               <i>dwRegisterType</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>ppDevice</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> There are no
    ///    registered devices to enumerate. When this value is returned, the address pointed to by <i>ppDevice</i> is
    ///    set to <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetFirstRegisteredDevice(uint dwRegisterType, IWMRegisteredDevice* ppDevice);
    ///<p class="CCE_Message">[<b>GetNextRegisteredDevice</b> is available for use in the operating systems specified in
    ///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft
    ///PlayReady. ] The <b>GetNextRegisteredDevice</b> method enumerates the registered devices of a specified type.
    ///Params:
    ///    ppDevice = Address of a variable that receives a pointer to an IWMRegisteredDevice interface. This interface provides
    ///               access to information about a registered device in the database that matches the type specified by the
    ///               <i>dwRegisterType</i> parameter used in the call to GetFirstRegisteredDevice. The information applies to the
    ///               next device in the list (after the device retrieved previously).
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> There are no more devices of the specified type in
    ///    the list. When this value is returned, the address pointed to by <i>ppDevice</i> is set to <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>ppDevice</i> parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetNextRegisteredDevice(IWMRegisteredDevice* ppDevice);
    ///<p class="CCE_Message">[<b>GetRegisteredDeviceByID</b> is available for use in the operating systems specified in
    ///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft
    ///PlayReady. ] The <b>GetRegisteredDeviceByID</b> method retrieves information about a registered device by the
    ///device identifier.
    ///Params:
    ///    dwRegisterType = The type of the device for which to retrieve information. Devices that support Windows Media DRM 10 for
    ///                     Network Devices use the DRM_DEVICE_REGISTER_TYPE_STREAMING register type.
    ///    pbCertificate = Address of the device certificate in memory.
    ///    cbCertificate = The size of the certificate data in bytes.
    ///    SerialNumber = 128-bit device identifier, stored in a DRM_VAL16 structure.
    ///    ppDevice = Address of a variable that receives a pointer to an IWMRegisteredDevice interface. This interface provides
    ///               access to information about the registered device in the list that matches the other identifying parameters.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>ppDevice</i> parameter is <b>NULL</b>.
    ///    OR The <i>pbCertificate</i> parameter is <b>NULL</b>, but the <i>cbCertificate</i> parameter is greater than
    ///    zero. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_DRM_DEVICE_NOT_REGISTERED</b></dt> </dl> </td> <td
    ///    width="60%"> The specified device is not registered. </td> </tr> </table>
    ///    
    HRESULT GetRegisteredDeviceByID(uint dwRegisterType, ubyte* pbCertificate, uint cbCertificate, 
                                    DRM_VAL16 SerialNumber, IWMRegisteredDevice* ppDevice);
}

///The <b>IWMRegisteredDevice</b> interface is the primary interface of the registered device object. It provides access
///to information about a playback device in the device registration database.
@GUID("A4503BEC-5508-4148-97AC-BFA75760A70D")
interface IWMRegisteredDevice : IUnknown
{
    ///The <b>GetDeviceID</b> method retrieves the 128-bit value that identifies the device.
    ///Params:
    ///    pSerialNumber = Address of a DRM_VAL16 structure that receives the device serial number.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetDeviceSerialNumber(DRM_VAL16* pSerialNumber);
    ///The <b>GetDeviceCertificate</b> method retrieves the certificate of the device.
    ///Params:
    ///    ppCertificate = Address of a variable that receives a pointer to the INSSBuffer interface of the buffer object that contains
    ///                    the certificate data.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetDeviceCertificate(INSSBuffer* ppCertificate);
    ///The <b>GetDeviceType</b> method retrieves the device type associated with the device.
    ///Params:
    ///    pdwType = Address of a variable that receives the device type.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetDeviceType(uint* pdwType);
    ///The <b>GetAttributeCount</b> method retrieves the total number of attributes associated with the device.
    ///Params:
    ///    pcAttributes = Address of a variable that receives the number of attributes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetAttributeCount(uint* pcAttributes);
    ///The <b>GetAttributeByIndex</b> method retrieves an attribute associated with the device. This method uses the
    ///attribute index to specify the attribute to retrieve.
    ///Params:
    ///    dwIndex = Attribute index. Valid indexes range from zero to one less than the number of attributes returned by
    ///              GetAttributeCount.
    ///    pbstrName = Address of a variable that receives the attribute name.
    ///    pbstrValue = Address of a variable that receives the attribute value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetAttributeByIndex(uint dwIndex, BSTR* pbstrName, BSTR* pbstrValue);
    ///The <b>GetAttributeByName</b> method retrieves an attribute associated with the device. This method uses an
    ///attribute name to specify the attribute to retrieve.
    ///Params:
    ///    bstrName = Name of the attribute to retrieve.
    ///    pbstrValue = Address of a variable that receives the attribute value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetAttributeByName(BSTR bstrName, BSTR* pbstrValue);
    ///The <b>SetAttributeByName</b> method sets a device attribute.
    ///Params:
    ///    bstrName = Name of the attribute to set.
    ///    bstrValue = Value of the attribute.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetAttributeByName(BSTR bstrName, BSTR bstrValue);
    ///The <b>Approve</b> method sets the approval state of the device for receiving media data.
    ///Params:
    ///    fApprove = Set to <b>TRUE</b> to approve the device for receiving media data; set to <b>FALSE</b> to indicate that the
    ///               device is not approved.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Approve(BOOL fApprove);
    ///The <b>IsValid</b> method retrieves the validation status of the device.
    ///Params:
    ///    pfValid = Address of a variable that receives the validation status of the device. <b>TRUE</b> indicates that the
    ///              device is valid. <b>FALSE</b> indicates that the device is not valid and needs to be revalidated before it
    ///              can be used.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT IsValid(BOOL* pfValid);
    ///The <b>IsApproved</b> method retrieves the approval status of the device. Approved devices are able to receive
    ///and play media data.
    ///Params:
    ///    pfApproved = Address of a variable that receives the device approval status. <b>TRUE</b> indicates approval.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT IsApproved(BOOL* pfApproved);
    ///The <b>IsWmdrmCompliant</b> method retrieves the DRM compliance status of the device. Compliant devices can
    ///receive data using the Windows Media DRM 10 for Network Devices protocol.
    ///Params:
    ///    pfCompliant = Address of a variable that receives the device DRM compliance status. <b>TRUE</b> indicates that Windows
    ///                  Media DRM 10 for Network Devices is supported.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT IsWmdrmCompliant(BOOL* pfCompliant);
    ///The <b>IsOpened</b> method retrieves the open status of the device. An open device is ready to receive media
    ///data.
    ///Params:
    ///    pfOpened = Address of a variable that receives the open status of the device. <b>TRUE</b> indicates that the device is
    ///               open.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT IsOpened(BOOL* pfOpened);
    ///The <b>Open</b> method opens the device so that it can receive media data.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_DRM_DEVICE_LIMIT_REACHED</b></dt> </dl> </td> <td width="60%"> The client computer already
    ///    has the maximum number of devices opened. </td> </tr> </table>
    ///    
    HRESULT Open();
    ///The <b>Close</b> method closes the device, if it is open. It also releases all resources associated with the
    ///device.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Close();
}

///<p class="CCE_Message">[<b>IWMProximityDetection</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady. ]
///The <b>IWMProximityDetection</b> interface validates a playback device for receiving media data. The validation
///process confirms that the device is "near" enough on the network to receive media through the Windows Media DRM 10
///for Network Devices protocol. An <b>IWMProximityDetection</b> interface exists for every device registration object.
///You can obtain a pointer to this interface by calling the <b>QueryInterface</b> method of the IWMDeviceRegistration
///interface.
@GUID("6A9FD8EE-B651-4BF0-B849-7D4ECE79A2B1")
interface IWMProximityDetection : IUnknown
{
    ///<p class="CCE_Message">[<b>StartDetection</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>StartDetection</b> method begins the proximity detection process. After calling this method, do not
    ///release the IWMProximityDetection until you recieve the WMT_PROXIMITY_COMPLETED message.
    ///Params:
    ///    pbRegistrationMsg = Address of the registration message in memory. This message is received by your application from the device.
    ///    cbRegistrationMsg = Size of registration message in bytes.
    ///    pbLocalAddress = Address of a <b>SOCKADDR_STORAGE</b> structure that contains the address of the local network interface to be
    ///                     used during proximity detection. If the <i>dwExtraPortsAllowed</i> parameter is not 0, the port number
    ///                     specified in the SOCKADDR_STORAGE structure identifies the beginning of the range of ports that will be
    ///                     tried.
    ///    cbLocalAddress = Size of the structure pointed to by <i>pbLocalAddress</i>. Set to <code>sizeof(SOCKADDR_STORAGE)</code>.
    ///    dwExtraPortsAllowed = Specifies the number of additional ports that the method will attempt to use if the previous ports were not
    ///                          successfully used. The method always attempts to use the port specified in the <i>pbLocalAddress</i>
    ///                          parameter first. If that attempt fails, then the method makes a number of additional attempts up to the value
    ///                          of this parameter. On each subsequent attempt, the port number is incremented. So if the port number in
    ///                          <i>pbLocalAddress</i> is 5000, and <i>dwExtraPortsAllowed</i> is set to 20, the method will start with port
    ///                          5000 and, if necessary, try ports 5001 through 5020.
    ///    ppRegistrationResponseMsg = Address of a variable that receives the address of the INSSBuffer interface on the buffer object containing
    ///                                the registration response message. You must send this message data to the device.
    ///    pCallback = Address of the IWMStatusCallback interface that will receive proximity detection status messages.
    ///    pvContext = Generic pointer, for use by the application. This is passed to the application in calls to the
    ///                IWMStatusCallback::OnStatus callback. You can use this parameter to differentiate between messages from
    ///                different objects when sharing a single status callback.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT StartDetection(ubyte* pbRegistrationMsg, uint cbRegistrationMsg, ubyte* pbLocalAddress, 
                           uint cbLocalAddress, uint dwExtraPortsAllowed, INSSBuffer* ppRegistrationResponseMsg, 
                           IWMStatusCallback pCallback, void* pvContext);
}

///<p class="CCE_Message">[<b>IWMDRMMessageParser</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady. ]
///The <b>IWMDRMMessageParser</b> interface parses pertinent information from messages received from a device. An
///<b>IWMDRMMessageParser</b> interface exists for every device registration object. You can obtain a pointer to this
///interface by calling the <b>QueryInterface</b> method of the IWMDeviceRegistration interface, or any other interface
///of the device registration object.
@GUID("A73A0072-25A0-4C99-B4A5-EDE8101A6C39")
interface IWMDRMMessageParser : IUnknown
{
    ///<p class="CCE_Message">[<b>ParseRegistrationReqMsg</b> is available for use in the operating systems specified in
    ///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft
    ///PlayReady. ] The <b>ParseRegistrationReqMsg</b> method extracts the device certificate and identifier from a
    ///registration message sent by a device.
    ///Params:
    ///    pbRegistrationReqMsg = Address of the registration message in memory. This is a message received by your application from a device.
    ///    cbRegistrationReqMsg = The size of registration message in bytes.
    ///    ppDeviceCert = Address of a variable that receives the address of the INSSBuffer interface of the buffer object that
    ///                   contains the device certificate.
    ///    pDeviceSerialNumber = Address of a DRM_VAL16 structure that receives the device identifier.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pbRegistrationMsg</i> parameter is
    ///    <b>NULL</b>, or the <i>cbRegistrationMsg</i> parameter is 0. </td> </tr> </table>
    ///    
    HRESULT ParseRegistrationReqMsg(ubyte* pbRegistrationReqMsg, uint cbRegistrationReqMsg, 
                                    INSSBuffer* ppDeviceCert, DRM_VAL16* pDeviceSerialNumber);
    ///<p class="CCE_Message">[<b>ParseLicenseRequestMsg</b> is available for use in the operating systems specified in
    ///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft
    ///PlayReady. ] The <b>ParseLicenseRequestMsg</b> method extracts the device identification and requested action
    ///from a policy request message.
    ///Params:
    ///    pbLicenseRequestMsg = Address of the license request message in memory. This is a message received by your application from a
    ///                          device.
    ///    cbLicenseRequestMsg = The size of license request message in bytes.
    ///    ppDeviceCert = Address of a variable that receives the address of the INSSBuffer interface of the buffer object that
    ///                   contains the device certificate.
    ///    pDeviceSerialNumber = Address of a DRM_VAL16 structure that receives the device identifier.
    ///    pbstrAction = Address of a variable that receives the string containing the requested action. The supported actions
    ///                  correspond to rights associates with DRM licenses. The only action string currently supported is "Play".
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pbLicenseRequestMsg</i> parameter is
    ///    <b>NULL</b>, or the <i>cbLicenseRequestMsg</i> parameter is 0. </td> </tr> </table>
    ///    
    HRESULT ParseLicenseRequestMsg(ubyte* pbLicenseRequestMsg, uint cbLicenseRequestMsg, INSSBuffer* ppDeviceCert, 
                                   DRM_VAL16* pDeviceSerialNumber, BSTR* pbstrAction);
}

///<p class="CCE_Message">[<b>IWMDRMTranscryptor</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady. ]
///The <b>IWMDRMTranscryptor</b> interface transforms a DRM-protected ASF file into a secure data stream conforming to
///the Windows Media DRM 10 for Network Devices protocol. The resulting stream can be sent to devices that support
///Windows Media DRM 10 for Network Devices. <b>IWMDRMTranscryptor</b> is the primary interface of the DRM transcryptor
///object. You can obtain a pointer to an instance of this interface by calling the WMCreateDRMTranscryptor function.
@GUID("69059850-6E6F-4BB2-806F-71863DDFC471")
interface IWMDRMTranscryptor : IUnknown
{
    ///<p class="CCE_Message">[<b>Initialize</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>Initialize</b> method loads a file into the DRM transcryptor. A file must be loaded before the
    ///transcryptor can process any data.
    ///Params:
    ///    bstrFileName = Name of the file to load. This should be a DRM-encrypted ASF file.
    ///    pbLicenseRequestMsg = Address of the license request message in memory. This message is sent to your application by a device.
    ///    cbLicenseRequestMsg = The size of the license request message in bytes.
    ///    ppLicenseResponseMsg = Address of a variable that receives the address of the license response message. Your application must send
    ///                           this message to the device before sending any encrypted data.
    ///    pCallback = Address of the IWMStatusCallback implementation that will receive status messages from the transcryptor.
    ///    pvContext = Generic pointer, for use by the application. This is passed to the application in calls to the
    ///                IWMStatusCallback::OnStatus callback. You can use this parameter to differentiate between messages from
    ///                different objects when sharing a single status callback. This parameter can be <b>NULL</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the pointer parameters is
    ///    <b>NULL</b>. OR The <i>cbPolicyRequestMsg</i> parameter is 0. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> Another transcription is in progress. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could
    ///    not allocate memory for an internal object. </td> </tr> </table>
    ///    
    HRESULT Initialize(BSTR bstrFileName, ubyte* pbLicenseRequestMsg, uint cbLicenseRequestMsg, 
                       INSSBuffer* ppLicenseResponseMsg, IWMStatusCallback pCallback, void* pvContext);
    ///<p class="CCE_Message">[<b>Seek</b> is available for use in the operating systems specified in the Requirements
    ///section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady. ] The
    ///<b>Seek</b> method sets the DRM transcryptor to read from the specified point in the data stream of the loaded
    ///file. Subsequent Read calls generate data beginning at that point.
    ///Params:
    ///    hnsTime = Seek time in 100-nanosecond units.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> There is no file loaded in the
    ///    transcryptor. </td> </tr> </table>
    ///    
    HRESULT Seek(ulong hnsTime);
    ///<p class="CCE_Message">[<b>Read</b> is available for use in the operating systems specified in the Requirements
    ///section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady. ] The
    ///<b>Read</b> method reads data from the file loaded in the transcryptor and encrypts it for streaming to devices
    ///that support Windows Media DRM 10 for Network Devices.
    ///Params:
    ///    pbData = Address of a buffer that receives the data.
    ///    pcbData = Address of a variable containing the size of the data buffer pointed to by <i>pbData</i>. On input, set to
    ///              the size of the buffer.On output, the value is changed to the number of bytes actually read.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_INVALID_REQUEST</b></dt> </dl> </td> <td width="60%"> The transcryptor is not ready for
    ///    reading. OR Another read is in progress. </td> </tr> </table>
    ///    
    HRESULT Read(ubyte* pbData, uint* pcbData);
    ///<p class="CCE_Message">[<b>Close</b> is available for use in the operating systems specified in the Requirements
    ///section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady. ] The
    ///<b>Close</b> method unloads the file from the DRM transcryptor and releases all associated resources.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
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
    ///Creates a DRM transcryptor object.
    ///Params:
    ///    ppTranscryptor = Address of a pointer to the IWMDRMTranscryptor interface of the newly created DRM transcryptor object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateTranscryptor(IWMDRMTranscryptor* ppTranscryptor);
}

///The <b>IWMWatermarkInfo</b> interface retrieves information about available watermarking systems. Watermarking
///systems are implemented in DirectX Media Objects that are registered for use with the Windows Media Formats SDK. An
///<b>IWMWatermarkInfo</b> interface exists for every writer object. To obtain a pointer to this interface, call
///<b>QueryInterface</b> on any other interface of the writer object.
@GUID("6F497062-F2E2-4624-8EA7-9DD40D81FC8D")
interface IWMWatermarkInfo : IUnknown
{
    ///The <b>GetWatermarkEntryCount</b> method retrieves the total number of installed watermarking systems of a
    ///specified type. Use this method in conjunction with IWMWatermarkInfo::GetWatermarkEntry to enumerate the
    ///installed watermarking DMOs.
    ///Params:
    ///    wmetType = A value from the WMT_WATERMARK_ENTRY_TYPE enumeration type specifying the type of watermarking system..
    ///    pdwCount = Pointer to a <b>DWORD</b> containing the number of watermark entries.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetWatermarkEntryCount(WMT_WATERMARK_ENTRY_TYPE wmetType, uint* pdwCount);
    ///The <b>GetWatermarkEntry</b> method retrieves information about one available watermarking system.
    ///Params:
    ///    wmetType = A value from the WMT_WATERMARK_ENTRY_TYPE enumeration type specifying the type of watermarking system.
    ///    dwEntryNum = <b>DWORD</b> containing the watermark entry number. This number is between zero and one less than the number
    ///                 of watermark entries returned by IWMWatermarkInfo::GetWatermarkEntryCount.
    ///    pEntry = Pointer to a WMT_WATERMARK_ENTRY structure containing information about the specified watermarking system.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetWatermarkEntry(WMT_WATERMARK_ENTRY_TYPE wmetType, uint dwEntryNum, WMT_WATERMARK_ENTRY* pEntry);
}

///The <b>IWMReaderAccelerator</b> interface is implemented on the reader object only when it is in decoding mode. It is
///called by a player or a player source filter to obtain interfaces from the decoder DMO.
@GUID("BDDC4D08-944D-4D52-A612-46C3FDA07DD4")
interface IWMReaderAccelerator : IUnknown
{
    ///The <b>GetCodecInterface</b> method is used to retrieve a pointer to the IWMCodecAMVideoAccelerator interface
    ///exposed on the decoder DMO.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> containing the output number.
    ///    riid = Reference to the IID of the interface to obtain. The value must be IID_IWMCodecAMVideoAccelerator.
    ///    ppvCodecInterface = Address of a pointer that receives the interface specified by <i>riid</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The WM Reader has no pointer to the codec.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetCodecInterface(uint dwOutputNum, const(GUID)* riid, void** ppvCodecInterface);
    ///The <b>Notify</b> method is called by the source filter to pass in the negotiated media type.
    ///Params:
    ///    dwOutputNum = <b>DWORD</b> that specifies the stream associated with the notification.
    ///    pSubtype = Pointer to a media type that describes the current connection parameters for the stream.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code .
    ///    
    HRESULT Notify(uint dwOutputNum, WM_MEDIA_TYPE* pSubtype);
}

///The <b>IWMReaderTimecode</b> interface provides access to information about SMPTE (Society of Motion Picture and
///Television Engineers) time code ranges. A range of SMPTE time code is a series of samples with time codes that are
///contiguous and in increasing order. An individual video stream can contain more than one range. An
///<b>IWMReaderTimecode</b> interface exists for every reader object. You can obtain a pointer to an instance of this
///interface by calling the <b>QueryInterface</b> method of any other interface of the reader object.
@GUID("F369E2F0-E081-4FE6-8450-B810B2F410D1")
interface IWMReaderTimecode : IUnknown
{
    ///The <b>GetTimecodeRangeCount</b> method retrieves the total number of SMTPE time code ranges in a specified
    ///stream.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number. This stream must be indexed by time code.
    ///    pwRangeCount = Pointer to a <b>WORD</b> containing the number of ranges. If this parameter is 0 on method return, no SMPTE
    ///                   ranges exist in the stream.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetTimecodeRangeCount(ushort wStreamNum, ushort* pwRangeCount);
    ///The <b>GetTimecodeRangeBounds</b> method retrieves the starting and ending time codes for a specified SMPTE time
    ///code range.
    ///Params:
    ///    wStreamNum = <b>WORD</b> containing the stream number.
    ///    wRangeNum = <b>WORD</b> containing the range number.
    ///    pStartTimecode = Pointer to a <b>DWORD</b> containing the first time code in the range.
    ///    pEndTimecode = Pointer to a <b>DWORD</b> containing the last time code in the range.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetTimecodeRangeBounds(ushort wStreamNum, ushort wRangeNum, uint* pStartTimecode, uint* pEndTimecode);
}

///The <b>IWMAddressAccess</b> interface controls IP access lists on the writer network sink object. Applications can
///use this interface to exclude specific IP addresses, or ranges of IP addresses, from connecting to the network sink.
///To obtain this interface, call <b>QueryInterface</b> on another interface of the writer network sink object. This
///interface supports only Internet Protocol version 4 (IPv4) addresses. The IWMAddressAccess2 interface inherits
///<b>IWMAddressAccess</b> and adds support for IPv6 addresses. The following interfaces can be obtained by using the
///QueryInterface method of this interface. <table> <tr> <th>Interface</th> <th>IID</th> </tr> <tr> <td>
///IWMAddressAccess2 </td> <td> IID_IWMAddressAccess2 </td> </tr> <tr> <td> IWMClientConnections </td>
///<td>IID_IWMClientConnections</td> </tr> <tr> <td> IWMClientConnections2 </td> <td>IID_IWMClientConnections2</td>
///</tr> <tr> <td> IWMWriterNetworkSink </td> <td>IID_IWMWriterNetworkSink</td> </tr> <tr> <td> IWMWriterSink </td>
///<td>IID_IWMWriterSink</td> </tr> </table>
@GUID("BB3C6389-1633-4E92-AF14-9F3173BA39D0")
interface IWMAddressAccess : IUnknown
{
    ///The <b>GetAccessEntryCount</b> method retrieves the number of entries in the IP address access list.
    ///Params:
    ///    aeType = A member of the WM_AETYPE enumeration specifying the type of entry (exclusion or inclusion).
    ///    pcEntries = Pointer to a variable that receives the number of entries of the type specified in <i>aeType</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAccessEntryCount(WM_AETYPE aeType, uint* pcEntries);
    ///The <b>GetAccessEntry</b> method retrieves an entry from the IP address access list.
    ///Params:
    ///    aeType = A member of the WM_AETYPE enumeration specifying the type of entry to retrieve (exclusion or inclusion).
    ///    dwEntryNum = Specifies the zero-based index of the entry. Use the IWMAddressAccess::GetAccessEntryCount method to get the
    ///                 number of entries.
    ///    pAddrAccessEntry = Pointer to a WM_ADDRESS_ACCESSENTRY structure that receives the access entry.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL pointer argument. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>NS_E_INVALID_INDEX</b></dt> </dl> </td> <td width="60%"> Invalid index number. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetAccessEntry(WM_AETYPE aeType, uint dwEntryNum, WM_ADDRESS_ACCESSENTRY* pAddrAccessEntry);
    ///The <b>AddAccessEntry</b> method adds an entry to the IP address access list.
    ///Params:
    ///    aeType = A member of the WM_AETYPE enumeration specifying the access permissions (exclusion or inclusion).
    ///    pAddrAccessEntry = Pointer to a WM_ADDRESS_ACCESSENTRY structure that specifies the IP address or range of addresses.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT AddAccessEntry(WM_AETYPE aeType, WM_ADDRESS_ACCESSENTRY* pAddrAccessEntry);
    ///The <b>RemoveAccessEntry</b> method removes an access entry.
    ///Params:
    ///    aeType = A member of the WM_AETYPE enumeration specifying the type of entry to remove (exclusion or inclusion).
    ///    dwEntryNum = Zero-based index of the access entry to remove. Use the IWMAddressAccess::GetAccessEntryCount method to get
    ///                 the number of entries.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> NULL pointer argument. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>NS_E_INVALID_INDEX</b></dt> </dl> </td> <td width="60%"> Invalid index number. </td>
    ///    </tr> </table>
    ///    
    HRESULT RemoveAccessEntry(WM_AETYPE aeType, uint dwEntryNum);
}

///The <b>IWMAddressAccess2</b> interface controls IP access lists on the writer network sink object. Applications can
///use this interface to exclude specific IP addresses, or ranges of IP addresses, from connecting to the network sink.
///To obtain this interface, call <b>QueryInterface</b> on another interface of the writer network sink object. This
///interface extends the <b>IWMAddressAccess</b> interface by adding support for Internet Protocol version 6 (IPv6)
///addresses. The following interfaces can be obtained by using the QueryInterface method of this interface. <table>
///<tr> <th>Interface</th> <th>IID</th> </tr> <tr> <td> IWMAddressAccess </td> <td> IID_IWMAddressAccess </td> </tr>
///<tr> <td> IWMClientConnections </td> <td>IID_IWMClientConnections</td> </tr> <tr> <td> IWMClientConnections2 </td>
///<td>IID_IWMClientConnections2</td> </tr> <tr> <td> IWMWriterNetworkSink </td> <td>IID_IWMWriterNetworkSink</td> </tr>
///<tr> <td> IWMWriterSink </td> <td>IID_IWMWriterSink</td> </tr> </table>
@GUID("65A83FC2-3E98-4D4D-81B5-2A742886B33D")
interface IWMAddressAccess2 : IWMAddressAccess
{
    ///The <b>GetAccessEntryEx</b> method retrieves an entry from the IP address access list.
    ///Params:
    ///    aeType = A member of the WM_AETYPE enumeration specifying the type of entry to retrieve (exclusion or inclusion).
    ///    dwEntryNum = Zero-based index of the entry. Use the IWMAddressAccess::GetAccessEntryCount method to get the number of
    ///                 entries.
    ///    pbstrAddress = Pointer to a variable that receives the IP address.
    ///    pbstrMask = Pointer to a variable that receives the bit mask.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAccessEntryEx(WM_AETYPE aeType, uint dwEntryNum, BSTR* pbstrAddress, BSTR* pbstrMask);
    ///The <b>AddAccessEntryEx</b> method adds an entry to the IP address access list.
    ///Params:
    ///    aeType = A member of the WM_AETYPE enumeration specifying the specifying the access permissions (exclusion or
    ///             inclusion).
    ///    bstrAddress = Specifies an IP address as a <b>BSTR</b>, using standard "dot" notation. Both IPv4 and IPv6 addresses are
    ///                  supported. For example, <code>206.73.118.1</code> is an IPv4 address and <code>fe80::201:3ff:fee8:5058</code>
    ///                  is an IPv6 address.
    ///    bstrMask = Bit mask that defines which bits in the IP address are matched against. For example, if the IP address is
    ///               <code>206.73.118.1</code> and the mask is <code>255.255.255.0</code>, only the first 24 bits of the address
    ///               are examined. Thus, any IP addresses in the range 206.73.118.<i>XXX</i> would match this entry.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT AddAccessEntryEx(WM_AETYPE aeType, BSTR bstrAddress, BSTR bstrMask);
}

///The <b>IWMImageInfo</b> interface retrieves images stored in ID3v2 "APIC" (attached picture) frames in a file. The
///methods of this interface are superseded in the Windows Media Format 9 Series SDK by the WM/Picture metadata
///attribute, which is supported by the methods of the new IWMHeaderInfo3 interface. If you are using the Windows Media
///Format 9 Series SDK, you should avoid using this interface. An <b>IWMImageInfo</b> interface exists for every reader,
///synchronous reader, and metadata editor object. You can obtain a pointer to this interface by calling the
///<b>QueryInterface</b> method of any other interface in one of these objects.
@GUID("9F0AA3B6-7267-4D89-88F2-BA915AA5C4C6")
interface IWMImageInfo : IUnknown
{
    ///The <b>GetImageCount</b> method retrieves the number of images stored in a file using ID3v2 "APIC" frames. Images
    ///stored in the file using attributes in the Windows Media namespace, or any images stored in custom attributes,
    ///are not included in this count.
    ///Params:
    ///    pcImages = Pointer to the number of images.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pcImages</i> parameter is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> One of the
    ///    ID3 frames that should be in the file cannot be accessed. </td> </tr> </table>
    ///    
    HRESULT GetImageCount(uint* pcImages);
    ///The <b>GetImage</b> method retrieves an image stored in a file as an ID3v2 "APIC" metadata frame.
    ///Params:
    ///    wIndex = <b>WORD</b> containing the image index. This is a number between zero, and one less than the image count
    ///             retrieved by IWMImageInfo::GetImageCount.
    ///    pcchMIMEType = Pointer to a <b>WORD</b> containing the length, in wide characters, of <i>pwszMIMEType</i>, including the
    ///                   terminating <b>NULL</b> character. On the first call to this method, pass <b>NULL</b> as <i>pwszMIMEType</i>
    ///                   to retrieve the required number of characters.
    ///    pwszMIMEType = Pointer to a wide-character <b>null</b>-terminated string containing the MIME Type associated with the image.
    ///                   Set to <b>NULL</b> on the first call and <i>pcchMIMEType</i> will be set to the number of wide characters,
    ///                   including the terminating <b>NULL</b>, in this string.
    ///    pcchDescription = Pointer to a <b>WORD</b> containing the length, in wide characters, of <i>pwszDescription</i>, including the
    ///                      terminating <b>NULL</b> character. On the first call to this method, pass <b>NULL</b> as
    ///                      <i>pwszDescription</i> to retrieve the required number of characters.
    ///    pwszDescription = Pointer to a wide-character <b>null</b>-terminated string containing the image description. Set to
    ///                      <b>NULL</b> on the first call and <i>pcchDescription</i> will be set to the number of wide characters,
    ///                      including the terminating <b>NULL</b>, in this string.
    ///    pImageType = Pointer to a <b>WORD</b> value containing the image type, as defined by the ID3v2 specification. This will be
    ///                 one of the following values. <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr> <td>0</td>
    ///                 <td>Picture of a type not specifically listed in this table</td> </tr> <tr> <td>1</td>
    ///                 <td>32-pixel-by-32-pixel file icon. Use only with portable network graphics (PNG) format.</td> </tr> <tr>
    ///                 <td>2</td> <td>File icon not conforming to type 1 above.</td> </tr> <tr> <td>3</td> <td>Front album
    ///                 cover.</td> </tr> <tr> <td>4</td> <td>Back album cover.</td> </tr> <tr> <td>5</td> <td>Leaflet page.</td>
    ///                 </tr> <tr> <td>6</td> <td>Media. Typically this type of image is of the label side of a CD.</td> </tr> <tr>
    ///                 <td>7</td> <td>Picture of the lead artist, lead performer, or soloist.</td> </tr> <tr> <td>8</td> <td>Picture
    ///                 of one of the involved artists or performers.</td> </tr> <tr> <td>9</td> <td>Picture of the conductor.</td>
    ///                 </tr> <tr> <td>10</td> <td>Picture of the band or orchestra.</td> </tr> <tr> <td>11</td> <td>Picture of the
    ///                 composer.</td> </tr> <tr> <td>12</td> <td>Picture of the lyricist or writer.</td> </tr> <tr> <td>13</td>
    ///                 <td>Picture of the recording studio or location.</td> </tr> <tr> <td>14</td> <td>Picture taken during a
    ///                 recording session.</td> </tr> <tr> <td>15</td> <td>Picture taken during a performance.</td> </tr> <tr>
    ///                 <td>16</td> <td>Screen capture from a movie or video.</td> </tr> <tr> <td>17</td> <td>A bright colored
    ///                 fish.</td> </tr> <tr> <td>18</td> <td>Illustration.</td> </tr> <tr> <td>19</td> <td>Logo of the band or
    ///                 artist.</td> </tr> <tr> <td>20</td> <td>Logo of the publisher or studio.</td> </tr> </table>
    ///    pcbImageData = Pointer to a <b>DWORD</b> containing the length, in bytes, of the image pointed to by <i>pbImageData</i>. On
    ///                   the first call to this method, pass <b>NULL</b> as <i>pbImageData</i> to retrieve the required number of
    ///                   bytes.
    ///    pbImageData = Pointer to a <b>BYTE</b> buffer containing the image data. Set to <b>NULL</b> on the first call and
    ///                  <i>pcbImageData</i> will be set to the number of bytes in the buffer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the following parameters is
    ///    <b>NULL</b>. <i>pcchMIMEType</i> <b><i></i></b> <i>pcbImageData</i> </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> One of the ID3 frames that should be in the file
    ///    cannot be accessed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ASF_E_BUFFERTOOSMALL</b></dt> </dl> </td>
    ///    <td width="60%"> The value referenced by one of the following parameters is less than the required buffer
    ///    size for the corresponding output parameter. <i>pcchMIMEType</i> <i>pcchDescription</i> <i>pcbImageData</i>
    ///    </td> </tr> </table>
    ///    
    HRESULT GetImage(uint wIndex, ushort* pcchMIMEType, PWSTR pwszMIMEType, ushort* pcchDescription, 
                     PWSTR pwszDescription, ushort* pImageType, uint* pcbImageData, ubyte* pbImageData);
}

///The <b>IWMLicenseRevocationAgent</b> interface handles messages from a DRM license server that involve license
///revocation. <b>IWMLicenseRevocationAgent</b> is the primary interface of the license revocation agent object. You can
///create an instance of the object and retrieve a pointer to its <b>IWMLicenseRevocationAgent</b> interface by calling
///the WMCreateLicenseRevocationAgent function.
@GUID("6967F2C9-4E26-4B57-8894-799880F7AC7B")
interface IWMLicenseRevocationAgent : IUnknown
{
    ///The <b>GetLRBChallenge</b> method generates a response to a license revocation challenge message. Your
    ///application must send the response to the license server.
    ///Params:
    ///    pMachineID = Address of the machine identifier in memory. The format of the machine identifier is determined by the
    ///                 service that issued the license.
    ///    dwMachineIDLength = Size of the machine identifier in bytes.
    ///    pChallenge = Address of the challenge message in memory. This message is generated by a component created by the license
    ///                 issuer.
    ///    dwChallengeLength = Size of the challenge message in bytes.
    ///    pChallengeOutput = Address of a buffer that receives the challenge response message.
    ///    pdwChallengeOutputLength = Address of a variable that receives the size of the challenge response message in bytes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetLRBChallenge(ubyte* pMachineID, uint dwMachineIDLength, ubyte* pChallenge, uint dwChallengeLength, 
                            ubyte* pChallengeOutput, uint* pdwChallengeOutputLength);
    ///The <b>ProcessLRB</b> method removes licenses from the license store on the client computer.
    ///Params:
    ///    pSignedLRB = Address of the signed license revocation blob in memory. This blob is sent to your application by the license
    ///                 server.
    ///    dwSignedLRBLength = Size of the license revocation blob in bytes.
    ///    pSignedACK = Address of a buffer that receives the signed acknowledgement of license revocation. Your application must
    ///                 send the acknowledgement to the license server.
    ///    pdwSignedACKLength = Size of the acknowledgement in bytes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT ProcessLRB(ubyte* pSignedLRB, uint dwSignedLRBLength, ubyte* pSignedACK, uint* pdwSignedACKLength);
}

///<p class="CCE_Message">[<b>IWMAuthorizer</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady. ]
///Provides access to certificates.
@GUID("D9B67D36-A9AD-4EB4-BAEF-DB284EF5504C")
interface IWMAuthorizer : IUnknown
{
    ///<p class="CCE_Message">[<b>GetCertCount</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] Get the number of certificates.
    ///Params:
    ///    pcCerts = Receives a pointer to a count of certs.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCertCount(uint* pcCerts);
    ///<p class="CCE_Message">[<b>GetCert</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] Retrieves the specified certificate.
    ///Params:
    ///    dwIndex = The index of the certification to retrieve.
    ///    ppbCertData = An address of a pointer to certification data. <i>ppbCertData</i> is allocated with CoTaskMemAlloc and must
    ///                  be released by the user.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCert(uint dwIndex, ubyte** ppbCertData);
    ///<p class="CCE_Message">[<b>GetSharedData</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] Retrieves shared data for the specified certificate.
    ///Params:
    ///    dwCertIndex = 
    ///    pbSharedData = 
    ///    pbCert = 
    ///    ppbSharedData = An address of a pointer to certification data. <i>ppbCertData</i> is allocated with CoTaskMemAlloc and must
    ///                    be released by the user.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSharedData(uint dwCertIndex, const(ubyte)* pbSharedData, ubyte* pbCert, ubyte** ppbSharedData);
}

///<p class="CCE_Message">[<b>IWMSecureChannel</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady. ]
///The <b>IWMSecureChannel</b> interface provides methods that allow two DLLs to validate each other and perform secure
///communication.
@GUID("2720598A-D0F2-4189-BD10-91C46EF0936F")
interface IWMSecureChannel : IWMAuthorizer
{
    ///<p class="CCE_Message">[<b>WMSC_AddCertificate</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>WMSC_AddCertificate</b> method adds certificates that this object can present to other secure channel
    ///objects. If no certs are added, then this object can only connect to objects with no signatures.
    ///Params:
    ///    pCert = A pointer to an authorizer object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WMSC_AddCertificate(IWMAuthorizer pCert);
    ///<p class="CCE_Message">[<b>WMSC_AddSignature</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>WMSC_AddSignature</b> method adds signatures that this object will look for when trying to connect. If
    ///no signatures are added, then this object will connect to any other object.
    ///Params:
    ///    pbCertSig = 
    ///    cbCertSig = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WMSC_AddSignature(ubyte* pbCertSig, uint cbCertSig);
    ///<p class="CCE_Message">[<b>WMSC_Connect</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>WMSC_Connect</b> method initializes the secure connection.
    ///Params:
    ///    pOtherSide = Pointer to a secure channel object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WMSC_Connect(IWMSecureChannel pOtherSide);
    ///<p class="CCE_Message">[<b>WMSC_IsConnected</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>WMSC_IsConnected</b> method checks to see if the secure connection is valid.
    ///Params:
    ///    pfIsConnected = A pointer to value that indicates if the secure connection is valid.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WMSC_IsConnected(BOOL* pfIsConnected);
    ///<p class="CCE_Message">[<b>WMSC_Disconnect</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>WMSC_Disconnect</b> method destroys the secure connection.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WMSC_Disconnect();
    ///<p class="CCE_Message">[<b>WMSC_GetValidCertificate</b> is available for use in the operating systems specified
    ///in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft
    ///PlayReady. ] The <b>WMSC_GetValidCertificate</b> method returns a copy of the certificate that was used provided
    ///by the other side of the connection. Also returns the index of the signature that validated that certificate.
    ///Params:
    ///    ppbCertificate = <i>ppbCertificate</i> must be released with CoTaskMemFree by the user. <i>ppbCertificate</i> can be
    ///                     <b>NULL</b> if no certificate was provided. If no connection was made, this function returns E_FAIL
    ///    pdwSignature = <i>pdwSignature</i>can be 0xFFFFFFFF if no signature was used to validate the cert.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WMSC_GetValidCertificate(ubyte** ppbCertificate, uint* pdwSignature);
    ///<p class="CCE_Message">[<b>WMSC_Encrypt</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>WMSC_Encrypt</b> method encrypts data across DLL boundaries.
    ///Params:
    ///    pbData = 
    ///    cbData = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WMSC_Encrypt(ubyte* pbData, uint cbData);
    ///<p class="CCE_Message">[<b>WMSC_Decrypt</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>WMSC_Decrypt</b> method decrypts data across DLL boundaries
    ///Params:
    ///    pbData = 
    ///    cbData = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WMSC_Decrypt(ubyte* pbData, uint cbData);
    ///<p class="CCE_Message">[<b>WMSC_Lock</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>WMSC_Lock</b> method locks access to the secure connection.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WMSC_Lock();
    ///<p class="CCE_Message">[<b>WMSC_Unlock</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>WMSC_Unlock</b> method unlocks access to the secure connection.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WMSC_Unlock();
    ///<p class="CCE_Message">[<b>WMSC_SetSharedData</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady.
    ///] The <b>WMSC_SetSharedData</b> method is used during the connection negotiation process.
    ///Params:
    ///    dwCertIndex = 
    ///    pbSharedData = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WMSC_SetSharedData(uint dwCertIndex, const(ubyte)* pbSharedData);
}

///<p class="CCE_Message">[<b>IWMGetSecureChannel</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use Microsoft PlayReady. ]
///The <b>IWMGetSecureChannel</b> interface is used by one communication party to get the other party's IWMSecureChannel
///interface.
@GUID("94BC0598-C3D2-11D3-BEDF-00C04F612986")
interface IWMGetSecureChannel : IUnknown
{
    ///<p class="CCE_Message">[<b>GetPeerSecureChannelInterface</b> is available for use in the operating systems
    ///specified in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///Microsoft PlayReady. ] The <b>GetPeerSecureChannelInterface</b> method gets the IWMSecureChannel interface from
    ///the other communication party.
    ///Params:
    ///    ppPeer = An address of a pointer to the other communication party's IWMSecureChannel object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPeerSecureChannelInterface(IWMSecureChannel* ppPeer);
}

///The <b>INSNetSourceCreator</b> interface creates an administrative network source plug-in. You can use an
///administrative network source plug-in to cache passwords and to locate the appropriate proxy server to use for
///Internet operations. To get a pointer to the <b>INSNetSourceCreator</b> interface, call CoCreateInstance with
///<b>CLSID_ClientNetManager</b> as the <i>REFCLSID</i> parameter.
@GUID("0C0E4080-9081-11D2-BEEC-0060082F2054")
interface INSNetSourceCreator : IUnknown
{
    ///The <b>Initialize</b> method prepares the network source creator for operations. You must call this method before
    ///calling any of the other methods in the <b>INSNetSourceCreator</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The method could not allocate memory for an
    ///    internal resource. </td> </tr> </table>
    ///    
    HRESULT Initialize();
    HRESULT CreateNetSource(const(PWSTR) pszStreamName, IUnknown pMonitor, ubyte* pData, IUnknown pUserContext, 
                            IUnknown pCallback, ulong qwContext);
    HRESULT GetNetSourceProperties(const(PWSTR) pszStreamName, IUnknown* ppPropertiesNode);
    HRESULT GetNetSourceSharedNamespace(IUnknown* ppSharedNamespace);
    ///The <b>GetNetSourceAdminInterface</b> method retrieves a pointer to the <b>IDispatch</b> interface of the
    ///administrative network source object.
    ///Params:
    ///    pszStreamName = Pointer to a wide-character <b>null</b>-terminated string containing the desired network protocol. Typically,
    ///                    this value is either "http\0" or "mms\0".
    ///    pVal = Pointer to a <b>VARIANT</b> that receives the address of the <b>IDispatch</b> interface on successful return.
    ///           Use this interface pointer to obtain the interface pointer of the desired network admin interface:
    ///           IWMSInternalAdminNetSource, IWMSInternalAdminNetSource2, or IWMSInternalAdminNetSource3.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or both of the parameters are <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Unable to
    ///    allocate memory for an internal resource. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_UNKNOWN_PROTOCOL</b></dt> </dl> </td> <td width="60%"> The protocol specified by
    ///    <i>pwszStreamName</i> is not supported. </td> </tr> </table>
    ///    
    HRESULT GetNetSourceAdminInterface(const(PWSTR) pszStreamName, VARIANT* pVal);
    HRESULT GetNumProtocolsSupported(uint* pcProtocols);
    HRESULT GetProtocolName(uint dwProtocolNum, PWSTR pwszProtocolName, ushort* pcchProtocolName);
    ///The <b>Shutdown</b> method properly disposes of all allocated memory used by the network source creator. You must
    ///call this method when you are finished using the network source creator, to ensure that all resources are
    ///released.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Shutdown();
}

///The <b>IWMPlayerTimestampHook</b> interface is implemented on a player's source filter. It enables the filter to
///modify the time stamps on the samples before sending them to the renderer. This method is provided to provide the
///filter with a greater degree of control over the streaming process than would otherwise be possible. Specifically,
///the method enables changing video time stamps to allow playback at higher rates than normal. When DirectX video
///acceleration is enabled, the <b>OnSample</b> method is never called. Therefore, if you plan to play video on a
///different timeline than a media timeline, this is the only chance to update the time stamp on the media sample to
///match the timeline.
@GUID("28580DDA-D98E-48D0-B7AE-69E473A02825")
interface IWMPlayerTimestampHook : IUnknown
{
    ///The <b>MapTimestamp</b> method is called by the WMV Decoder DMO to enable the source filter to provide the
    ///decoder with a time stamp. The decoder applies the time stamp to the sample before delivering the sample to the
    ///video renderer.
    ///Params:
    ///    rtIn = Time stamp previously applied by the DMO.
    ///    prtOut = Time stamp to be applied to the sample.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code .
    ///    
    HRESULT MapTimestamp(long rtIn, long* prtOut);
}

///This interface is exposed by the Windows Media Decoder DMO and is called by a media player source filter to set up
///the various connections required to enable DirectX® video acceleration (VA) for decoding of Windows Media-based
///video content. A player obtains this interface by calling the IWMReaderAccelerator::GetCodecInterface method, which
///is exposed on the reader object.
@GUID("D98EE251-34E0-4A2D-9312-9B4C788D9FA1")
interface IWMCodecAMVideoAccelerator : IUnknown
{
    ///The <b>SetAcceleratorInterface</b> method is called by the output pin on the player's source filter to pass the
    ///<b>IAMVideoAccelerator</b> interface on the Video Mixing Renderer (VMR) to the decoder DMO.
    ///Params:
    ///    pIAMVA = Pointer to the <b>IAMVideoAccelerator</b> interface on the VMR.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAcceleratorInterface(IAMVideoAccelerator pIAMVA);
    ///The <b>NegotiateConnection</b> method is called by the output pin on the player's source filter during the
    ///connection process when it has been given a DirectX VA media type.
    ///Params:
    ///    pMediaType = Pointer to the media type structure that represents the media type being proposed for the connection.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>DMO_E_TYPE_NOT_SET</b></dt> </dl> </td> <td width="60%"> No input type has been set on the
    ///    decoder. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The
    ///    decoder has no valid <b>IAMVideoAccelerator</b> interface pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pMediaType</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT NegotiateConnection(AM_MEDIA_TYPE* pMediaType);
    ///The <b>SetPlayerNotify</b> method is called by the output pin on the source filter to provide the decoder DMO
    ///with the source filter's <b>IWMPlayerTimestampHook</b> interface to enable the source filter to update the time
    ///stamps on the samples before they are delivered to the renderer.
    ///Params:
    ///    pHook = Pointer to the <b>IWMPlayerTimestampHook</b> interface exposed on the player.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code
    ///    
    HRESULT SetPlayerNotify(IWMPlayerTimestampHook pHook);
}

@GUID("990641B0-739F-4E94-A808-9888DA8F75AF")
interface IWMCodecVideoAccelerator : IUnknown
{
    HRESULT NegotiateConnection(IAMVideoAccelerator pIAMVA, AM_MEDIA_TYPE* pMediaType);
    HRESULT SetPlayerNotify(IWMPlayerTimestampHook pHook);
}

///The <b>IWMSInternalAdminNetSource</b> interface manages cached passwords and finds proxy servers. To obtain a pointer
///to an instance of this interface, call the <b>QueryInterface</b> method of the <b>IDispatch</b> interface retrieved
///by INSNetSourceCreator::GetNetSourceAdminInterface.
@GUID("8BB23E5F-D127-4AFB-8D02-AE5B66D54C78")
interface IWMSInternalAdminNetSource : IUnknown
{
    HRESULT Initialize(IUnknown pSharedNamespace, IUnknown pNamespaceNode, INSNetSourceCreator pNetSourceCreator, 
                       BOOL fEmbeddedInServer);
    HRESULT GetNetSourceCreator(INSNetSourceCreator* ppNetSourceCreator);
    ///The <b>SetCredentials</b> method adds a password to the cache. This method has been superseded by
    ///IWMSInternalAdminNetSource3::SetCredentialsEx2. The methods of <b>IWMSInternalAdminNetSource3</b> are much more
    ///secure than the password caching methods in <b>IWMSInternalAdminNetSource</b> and should be used if available.
    ///Params:
    ///    bstrRealm = String containing the realm name. Realm names are supplied by servers to distinguish different levels of
    ///                access to their files. Not all servers have realm names, in which case the DNS name should be used.
    ///    bstrName = String containing the user name.
    ///    bstrPassword = String containing the password.
    ///    fPersist = Boolean value that is True if these credentials should be permanently saved. If you set this to False, the
    ///               credentials will be saved only for the current session.
    ///    fConfirmedGood = Boolean value that is True if the server has confirmed the password as correct. You can cache the password
    ///                     before receiving verification from the server, in which case you should set this to False.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetCredentials(BSTR bstrRealm, BSTR bstrName, BSTR bstrPassword, BOOL fPersist, BOOL fConfirmedGood);
    ///The <b>GetCredentials</b> method retrieves a cached password. This method has been superseded by
    ///IWMSInternalAdminNetSource3::GetCredentialsEx2. The methods of <b>IWMSInternalAdminNetSource3</b> are much more
    ///secure than the password caching methods in <b>IWMSInternalAdminNetSource</b> and should be used if available.
    ///Params:
    ///    bstrRealm = String containing the realm name. Realm names are supplied by servers to distinguish different levels of
    ///                access to their files. Not all servers have realm names, in which case the DNS name is used.
    ///    pbstrName = Pointer to a string containing the user name.
    ///    pbstrPassword = Pointer to a string containing the password.
    ///    pfConfirmedGood = Pointer to a Boolean value that is set to True if the password was cached after it was confirmed as correct
    ///                      by the server.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCredentials(BSTR bstrRealm, BSTR* pbstrName, BSTR* pbstrPassword, BOOL* pfConfirmedGood);
    ///The <b>DeleteCredentials</b> method removes a password from the cache. This method has been superseded by
    ///IWMSInternalAdminNetSource2::DeleteCredentialsEx. The methods of <b>IWMSInternalAdminNetSource2</b> are much more
    ///secure than the password caching methods in <b>IWMSInternalAdminNetSource</b> and should be used if available.
    ///Params:
    ///    bstrRealm = String containing the realm name. Realm names are supplied by servers to distinguish different levels of
    ///                access to their files. Not all servers will have realm names, in which case the DNS name is used.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT DeleteCredentials(BSTR bstrRealm);
    ///The <b>GetCredentialFlags</b> method can be used in conjunction with
    ///IWMSInternalAdminNetSource::SetCredentialFlags to determine whether the user wants passwords saved as a default
    ///behavior. This method retrieves any flags previously set.
    ///Params:
    ///    lpdwFlags = <b>DWORD</b> containing credential flags. At this time, the only supported flag is 0x1, which signifies that
    ///                the user has stated a preference that passwords should be saved automatically.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCredentialFlags(uint* lpdwFlags);
    ///The <b>SetCredentialFlags</b> method is used to set the user preference for automatic password caching. When your
    ///application prompts the user for a password, you can include a checkbox on the dialog box that the user can
    ///select to always have passwords saved. You can then set a flag to maintain that preference.
    ///Params:
    ///    dwFlags = <b>DWORD</b> containing the credential flags. At this time, the only supported flag is 0x1, which signifies
    ///              that the user has stated a preference that passwords should be saved automatically.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetCredentialFlags(uint dwFlags);
    ///The <b>FindProxyForURL</b> method finds a proxy server name and port to use for the client.
    ///Params:
    ///    bstrProtocol = String containing the protocol for which to find the proxy server. Typically, this is either "http" or "mms".
    ///    bstrHost = String containing the DNS name or IP address of the server with which you want to communicate. Depending upon
    ///               the server, the proxy might be different.
    ///    pfProxyEnabled = Pointer to a Boolean value that is True if the user has enabled a proxy that applies to the specified
    ///                     protocol and host.
    ///    pbstrProxyServer = Pointer to a string containing the proxy server DNS name.
    ///    pdwProxyPort = Pointer to a <b>DWORD</b> containing the proxy port number.
    ///    pdwProxyContext = <b>DWORD</b> representing the proxy server returned. You can make multiple calls to <b>FindProxyForURL</b> to
    ///                      find all configured proxy servers. On your first call, set the context to zero. When the call returns, the
    ///                      context is set to a value representing the proxy for which information was returned. On the next call, set
    ///                      the context to the context value retrieved on the first call. Continue this process until the call returns
    ///                      S_FALSE. This method has internal algorithms that determine how it looks for proxy servers. You can override
    ///                      this and make it find the proxy server set by the client's Web browser, by setting the context to 3.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> When calling this method multiple times to find all
    ///    proxies configured, this value is returned when there are no more configured proxy servers. </td> </tr>
    ///    </table>
    ///    
    HRESULT FindProxyForURL(BSTR bstrProtocol, BSTR bstrHost, BOOL* pfProxyEnabled, BSTR* pbstrProxyServer, 
                            uint* pdwProxyPort, uint* pdwProxyContext);
    ///Registers a proxy failure.
    ///Params:
    ///    hrParam = The <b>HRESULT</b> code of the failure.
    ///    dwProxyContext = Represents the proxy server.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RegisterProxyFailure(HRESULT hrParam, uint dwProxyContext);
    ///The <b>ShutdownProxyContext</b> method releases the internal resources used by
    ///IWMSInternalAdminNetSource::FindProxyForURL. To avoid memory leaks, you must call this method after you are
    ///finished making calls to <b>FindProxyForURL</b>.
    ///Params:
    ///    dwProxyContext = <b>DWORD</b> containing the proxy context. Set this to the last proxy context received from
    ///                     <b>FindProxyForURL</b>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT ShutdownProxyContext(uint dwProxyContext);
    HRESULT IsUsingIE(uint dwProxyContext, BOOL* pfIsUsingIE);
}

///The <b>IWMSInternalAdminNetSource2</b> interface provides improved methods for password caching. These methods should
///be used in preference to their counterparts in IWMSInternalAdminNetSource because the older methods are vulnerable to
///spoofing and are therefore not secure. To obtain a pointer to an instance of this interface, call the
///<b>QueryInterface</b> method of the <b>IDispatch</b> method retrieved by
///INSNetSourceCreator::GetNetSourceAdminInterface.
@GUID("E74D58C3-CF77-4B51-AF17-744687C43EAE")
interface IWMSInternalAdminNetSource2 : IUnknown
{
    ///The <b>SetCredentialsEx</b> method adds a password to the cache. This improved version of
    ///IWMSInternalAdminNetSource::SetCredentials uses the combination of realm, URL, and proxy use to identify the
    ///credentials. This is an improvement over using the realm by itself, which can easily be spoofed by malicious
    ///code. This method has been superseded by IWMSInternalAdminNetSource3::SetCredentialsEx2.
    ///Params:
    ///    bstrRealm = String containing the realm name. Realm names are supplied by servers to distinguish different levels of
    ///                access to their files. Not all servers have realm names, in which case the DNS name should be used. If
    ///                <i>fProxy</i> is False, this realm refers to the host server. If <i>fProxy</i> is True, this realm refers to
    ///                the proxy server.
    ///    bstrUrl = String containing the URL to which the credentials apply.
    ///    fProxy = Boolean value that is True if the password applies when using a proxy server to access the site specified by
    ///             <i>bstrUrl</i>.
    ///    bstrName = String containing the user name.
    ///    bstrPassword = String containing the password.
    ///    fPersist = Boolean value that is True if these credentials should be permanently saved. If you set this to False, the
    ///               credentials will only be persisted for the current session.
    ///    fConfirmedGood = Boolean value that is True if the server has confirmed the password as correct. You can cache the password
    ///                     before receiving verification from the server, in which case you should set this to False.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetCredentialsEx(BSTR bstrRealm, BSTR bstrUrl, BOOL fProxy, BSTR bstrName, BSTR bstrPassword, 
                             BOOL fPersist, BOOL fConfirmedGood);
    ///The <b>GetCredentialsEx</b> method retrieves a cached password. This improved version of
    ///IWMSInternalAdminNetSource::GetCredentials uses the combination of realm, URL, and proxy use to identify the
    ///credentials. This is an improvement over using the realm by itself, which can easily be spoofed by malicious
    ///code. This method has been superseded by IWMSInternalAdminNetSource3::GetCredentialsEx2.
    ///Params:
    ///    bstrRealm = String containing the realm name. Realm names are supplied by servers to distinguish different levels of
    ///                access to their files. Not all servers have realm names, in which case the DNS name is used. If <i>fProxy</i>
    ///                is False, this realm refers to the host server. If <i>fProxy</i> is True, this realm refers to the proxy
    ///                server.
    ///    bstrUrl = String containing the URL to which the credentials apply.
    ///    fProxy = Boolean value that is True if the password applies when using a proxy server to access the site specified by
    ///             <i>bstrUrl</i>.
    ///    pdwUrlPolicy = Pointer to a <b>DWORD</b> containing one member of the NETSOURCE_URLCREDPOLICY_SETTINGS enumeration type.
    ///                   This value is based on the user's network security settings and determines whether your application can
    ///                   automatically log in to sites for the user if you have credentials cached.
    ///    pbstrName = Pointer to a string containing the user name.
    ///    pbstrPassword = Pointer to a string containing the password.
    ///    pfConfirmedGood = Boolean value that is True if the password was cached after it was confirmed as correct by the server.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCredentialsEx(BSTR bstrRealm, BSTR bstrUrl, BOOL fProxy, 
                             NETSOURCE_URLCREDPOLICY_SETTINGS* pdwUrlPolicy, BSTR* pbstrName, BSTR* pbstrPassword, 
                             BOOL* pfConfirmedGood);
    ///The <b>DeleteCredentialsEx</b> method removes a password from the cache. This improved version of
    ///IWMSInternalAdminNetSource::DeleteCredentials uses the combination of realm, URL, and proxy use to identify the
    ///credentials. This is an improvement over using the realm by itself, which can easily be spoofed by malicious
    ///code.
    ///Params:
    ///    bstrRealm = String containing the realm name. Realm names are supplied by servers to distinguish different levels of
    ///                access to their files. Not all servers will have realm names, in which case the DNS name is used.
    ///    bstrUrl = String containing the URL to which the credentials apply.
    ///    fProxy = Boolean value that is True if the password applies when using a proxy server to access the site specified by
    ///             <i>bstrUrl</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT DeleteCredentialsEx(BSTR bstrRealm, BSTR bstrUrl, BOOL fProxy);
    HRESULT FindProxyForURLEx(BSTR bstrProtocol, BSTR bstrHost, BSTR bstrUrl, BOOL* pfProxyEnabled, 
                              BSTR* pbstrProxyServer, uint* pdwProxyPort, uint* pdwProxyContext);
}

///The <b>IWMSInternalAdminNetSource3</b> interface provides improved methods to find proxy servers. To obtain a pointer
///to an instance of this interface, call the <b>QueryInterface</b> method of the <b>IDispatch</b> method retrieved by
///INSNetSourceCreator::GetNetSourceAdminInterface.
@GUID("6B63D08E-4590-44AF-9EB3-57FF1E73BF80")
interface IWMSInternalAdminNetSource3 : IWMSInternalAdminNetSource2
{
    HRESULT GetNetSourceCreator2(IUnknown* ppNetSourceCreator);
    ///The <b>FindProxyForURLEx2</b> method finds a proxy server name and port to use for the user.
    ///Params:
    ///    bstrProtocol = String containing the protocol for which to find the proxy server. Typically, this is either "http" or "mms".
    ///    bstrHost = String containing the DNS name, or IP address, of the server with which you want to communicate. Depending
    ///               upon the server, the proxy might be different.
    ///    bstrUrl = String containing the full URL of the site to which you want to connect.
    ///    pfProxyEnabled = Pointer to a Boolean value that is set to True if the user has enabled a proxy that applies to the specified
    ///                     protocol, host, and site.
    ///    pbstrProxyServer = Pointer to a string containing the proxy server DNS name.
    ///    pdwProxyPort = Pointer to a <b>DWORD</b> containing the proxy port number.
    ///    pqwProxyContext = <b>QWORD</b> representing the proxy server returned. You can make multiple calls to <b>FindProxyForURL</b> to
    ///                      find all configured proxy servers. On your first call, set the context to zero. When the call returns, the
    ///                      context is set to a value representing the proxy for which information was returned. On the next call, set
    ///                      the context to the context value retrieved on the first call. Continue this process until the call returns
    ///                      S_FALSE. This method has internal algorithms that determine how it looks for proxy servers. You can override
    ///                      this and make it find the proxy server set by the client's Web browser, by setting the context to 3.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> When calling this method multiple times to find all
    ///    proxies configured, this value is returned when there are no more configured proxy servers. </td> </tr>
    ///    </table>
    ///    
    HRESULT FindProxyForURLEx2(BSTR bstrProtocol, BSTR bstrHost, BSTR bstrUrl, BOOL* pfProxyEnabled, 
                               BSTR* pbstrProxyServer, uint* pdwProxyPort, ulong* pqwProxyContext);
    HRESULT RegisterProxyFailure2(HRESULT hrParam, ulong qwProxyContext);
    ///The <b>ShutdownProxyContext2</b> method releases the internal resources used by
    ///IWMSInternalAdminNetSource3::FindProxyForURLEx2. To avoid memory leaks, you must call this method after you are
    ///finished making calls to <b>FindProxyForURLEx2</b>.
    ///Params:
    ///    qwProxyContext = <b>QWORD</b> containing the proxy context. Set this to the last proxy context received from
    ///                     <b>FindProxyForURLEx2</b>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT ShutdownProxyContext2(ulong qwProxyContext);
    HRESULT IsUsingIE2(ulong qwProxyContext, BOOL* pfIsUsingIE);
    ///The <b>SetCredentialsEx2</b> method adds a password to the cache. This improved version of
    ///<b>IWMSInternalAdminNetSource2::SetCredentialsEx</b> adds a flag (<i>fClearTextAuthentication</i>) that indicates
    ///whether credentials were sent in unencrypted form over the network.
    ///Params:
    ///    bstrRealm = String containing the realm name. Realm names are supplied by servers to distinguish different levels of
    ///                access to their files. Not all servers have realm names, in which case the DNS name should be used. If
    ///                <i>fProxy</i> is False, this realm refers to the host server. If <i>fProxy</i> is True, this realm refers to
    ///                the proxy server.
    ///    bstrUrl = String containing the URL to which the credentials apply.
    ///    fProxy = Boolean value that is True if the password applies when using a proxy server to access the site specified by
    ///             <i>bstrUrl</i>.
    ///    bstrName = String containing the user name.
    ///    bstrPassword = String containing the password.
    ///    fPersist = Boolean value that is True if these credentials should be permanently saved. If you set this to False, the
    ///               credentials will only be persisted for the current session.
    ///    fConfirmedGood = Boolean value that is True if the server has confirmed the password as correct. You can cache the password
    ///                     before receiving verification from the server, in which case you should set this to False.
    ///    fClearTextAuthentication = Boolean value that is True if the credentials were obtained using an authentication scheme where credentials
    ///                               are sent over the network in an unencrypted form (such as HTTP Basic authentication).
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetCredentialsEx2(BSTR bstrRealm, BSTR bstrUrl, BOOL fProxy, BSTR bstrName, BSTR bstrPassword, 
                              BOOL fPersist, BOOL fConfirmedGood, BOOL fClearTextAuthentication);
    ///The <b>GetCredentialsEx2</b> method retrieves a cached password. This improved version of
    ///<b>IWMSInternalAdminNetSource2::GetCredentialsEx</b> adds a flag (<i>fClearTextAuthentication</i>) that indicates
    ///whether credentials were sent in unencrypted form over the network.
    ///Params:
    ///    bstrRealm = String containing the realm name. Realm names are supplied by servers to distinguish different levels of
    ///                access to their files. Not all servers have realm names, in which case the DNS name is used. If <i>fProxy</i>
    ///                is False, this realm refers to the host server. If <i>fProxy</i> is True, this realm refers to the proxy
    ///                server.
    ///    bstrUrl = String containing the URL to which the credentials apply.
    ///    fProxy = Boolean value that is True if the password applies when using a proxy server to access the site specified by
    ///             <i>bstrUrl</i>.
    ///    fClearTextAuthentication = Boolean value that is True if the cached credentials were previously sent over the network in an unencrypted
    ///                               form.
    ///    pdwUrlPolicy = Pointer to a <b>DWORD</b> containing one member of the NETSOURCE_URLCREDPOLICY_SETTINGS enumeration type.
    ///                   This value is based on the user's network security settings and determines whether your application can
    ///                   automatically log in to sites for the user if you have credentials cached.
    ///    pbstrName = Pointer to a string containing the user name.
    ///    pbstrPassword = Pointer to a string containing the password.
    ///    pfConfirmedGood = Boolean value that is True if the password was cached after it was confirmed as correct by the server.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCredentialsEx2(BSTR bstrRealm, BSTR bstrUrl, BOOL fProxy, BOOL fClearTextAuthentication, 
                              NETSOURCE_URLCREDPOLICY_SETTINGS* pdwUrlPolicy, BSTR* pbstrName, BSTR* pbstrPassword, 
                              BOOL* pfConfirmedGood);
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
