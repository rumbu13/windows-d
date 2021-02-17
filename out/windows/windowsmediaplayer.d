// Written in the D programming language.

module windows.windowsmediaplayer;

public import windows.core;
public import windows.automation : BSTR, IDispatch, IEnumVARIANT, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.displaydevices : RECT, SIZE;
public import windows.gdi : HDC;
public import windows.mediafoundation : IMFActivate;
public import windows.structuredstorage : IStream;
public import windows.systemservices : BOOL, LRESULT;
public import windows.winsock : BLOB;
public import windows.windowsandmessaging : HWND, LPARAM, MSG, WPARAM;
public import windows.windowsprogramming : SYSTEMTIME;

extern(Windows):


// Enums


///The <b>WMPOpenState</b> enumeration type defines the possible operational states of Windows Media Player as it opens
///a digital media file.
enum WMPOpenState : int
{
    ///The content source is in an undefined state.
    wmposUndefined               = 0x00000000,
    ///A new playlist is about to be loaded.
    wmposPlaylistChanging        = 0x00000001,
    ///Locating the playlist.
    wmposPlaylistLocating        = 0x00000002,
    ///Connecting to the server that is hosting the playlist.
    wmposPlaylistConnecting      = 0x00000003,
    ///Loading a playlist.
    wmposPlaylistLoading         = 0x00000004,
    ///Opening a playlist.
    wmposPlaylistOpening         = 0x00000005,
    ///Playlist is open.
    wmposPlaylistOpenNoMedia     = 0x00000006,
    ///Playlist has changed.
    wmposPlaylistChanged         = 0x00000007,
    ///New media item is about to be loaded.
    wmposMediaChanging           = 0x00000008,
    ///Locating the media item.
    wmposMediaLocating           = 0x00000009,
    ///Connecting to the server that is hosting the media item.
    wmposMediaConnecting         = 0x0000000a,
    ///Loading the media item.
    wmposMediaLoading            = 0x0000000b,
    ///Opening the media item.
    wmposMediaOpening            = 0x0000000c,
    ///The media item is open.
    wmposMediaOpen               = 0x0000000d,
    ///Starting codec acquisition.
    wmposBeginCodecAcquisition   = 0x0000000e,
    ///Ending codec acquisition.
    wmposEndCodecAcquisition     = 0x0000000f,
    ///Starting license acquisition.
    wmposBeginLicenseAcquisition = 0x00000010,
    ///Ending license acquisition.
    wmposEndLicenseAcquisition   = 0x00000011,
    ///Starting individualization.
    wmposBeginIndividualization  = 0x00000012,
    ///Individualization has ended.
    wmposEndIndividualization    = 0x00000013,
    ///Waiting for the media item to open.
    wmposMediaWaiting            = 0x00000014,
    ///Opening a URL whose type is unknown.
    wmposOpeningUnknownURL       = 0x00000015,
}

///The <b>WMPPlayState</b> enumeration type defines the possible operational states of Windows Media Player as it plays
///a digital media file.
enum WMPPlayState : int
{
    ///Windows Media Player is in an undefined state.
    wmppsUndefined     = 0x00000000,
    ///Playback is stopped.
    wmppsStopped       = 0x00000001,
    ///Playback is paused.
    wmppsPaused        = 0x00000002,
    ///Stream is playing.
    wmppsPlaying       = 0x00000003,
    ///Stream is scanning forward.
    wmppsScanForward   = 0x00000004,
    ///Stream is scanning backward.
    wmppsScanReverse   = 0x00000005,
    ///Stream is being buffered.
    wmppsBuffering     = 0x00000006,
    ///Waiting for streaming data.
    wmppsWaiting       = 0x00000007,
    ///The end of the media item has been reached.
    wmppsMediaEnded    = 0x00000008,
    ///Preparing new media item.
    wmppsTransitioning = 0x00000009,
    ///Ready to begin playing.
    wmppsReady         = 0x0000000a,
    ///Trying to reconnect for streaming data.
    wmppsReconnecting  = 0x0000000b,
    ///Last enumerated value. Not a valid state.
    wmppsLast          = 0x0000000c,
}

///The <b>WMPPlaylistChangeEventType</b> enumeration type defines the types of changes that can be made to a playlist.
enum WMPPlaylistChangeEventType : int
{
    ///An unknown change has occurred.
    wmplcUnknown    = 0x00000000,
    ///The playlist has been cleared.
    wmplcClear      = 0x00000001,
    ///A playlist attribute has changed value.
    wmplcInfoChange = 0x00000002,
    ///A media item within the playlist has been moved to a new position.
    wmplcMove       = 0x00000003,
    ///A media item has been deleted from the playlist.
    wmplcDelete     = 0x00000004,
    ///A media item has been inserted into the playlist.
    wmplcInsert     = 0x00000005,
    ///A media item has been appended to the playlist.
    wmplcAppend     = 0x00000006,
    ///Not supported.
    wmplcPrivate    = 0x00000007,
    ///The name of the playlist has changed.
    wmplcNameChange = 0x00000008,
    ///Not supported.
    wmplcMorph      = 0x00000009,
    ///The playlist has been sorted.
    wmplcSort       = 0x0000000a,
    ///Last enumerated value. Not a valid change type.
    wmplcLast       = 0x0000000b,
}

///The <b>WMPSyncState</b> enumeration type defines the possible operational states of Windows Media Player as it
///synchronizes digital media to a device. To use this enumeration you must create a remoted instance of the Windows
///Media Player 10 or later control.
enum WMPSyncState : int
{
    ///Synchronization state is unknown.
    wmpssUnknown       = 0x00000000,
    ///Windows Media Player is synchronizing the device.
    wmpssSynchronizing = 0x00000001,
    ///Synchronization has stopped.
    wmpssStopped       = 0x00000002,
    ///An estimation of synchronization size is in progress. Requires Windows Media Player 12.
    wmpssEstimating    = 0x00000003,
    ///Last enumerated value. Not a valid state.
    wmpssLast          = 0x00000004,
}

///The <b>WMPDeviceStatus</b> enumeration type defines the possible values for the current status of a device. To use
///this enumeration, you must create a remoted instance of the Windows Media Player 10 or later control.
enum WMPDeviceStatus : int
{
    ///Not a valid status.
    wmpdsUnknown             = 0x00000000,
    ///A partnership between Windows Media Player and the device exists.
    wmpdsPartnershipExists   = 0x00000001,
    ///The user declined to create a partnership with the device. A device will also have this status when the
    ///partnership was deleted programmatically by calling IWMPSyncDevice::deletePartnership.
    wmpdsPartnershipDeclined = 0x00000002,
    ///A partnership exists with another computer or user. Windows Media Player 10 or later allows one partnership with
    ///one computer per device.
    wmpdsPartnershipAnother  = 0x00000003,
    ///The current device supports manual transfers only.
    wmpdsManualDevice        = 0x00000004,
    ///The device is a new device; Windows Media Player has information stored for the device.
    wmpdsNewDevice           = 0x00000005,
    ///Last enumerated value. Not a valid device state.
    wmpdsLast                = 0x00000006,
}

///The <b>WMPRipState</b> enumeration type defines the possible operational states of Windows Media Player as it rips a
///CD.
enum WMPRipState : int
{
    ///Not a valid state.
    wmprsUnknown = 0x00000000,
    ///Windows Media Player is ripping.
    wmprsRipping = 0x00000001,
    ///The ripping operation is stopped.
    wmprsStopped = 0x00000002,
}

///The <b>WMPBurnFormat</b> enumeration type defines the possible types of CDs for burning.
enum WMPBurnFormat : int
{
    ///The CD being burned is an audio CD.
    wmpbfAudioCD = 0x00000000,
    ///The CD being burned is a data CD.
    wmpbfDataCD  = 0x00000001,
}

///The <b>WMPBurnState</b> enumeration type defines the possible operational states of Windows Media Player as it burns
///a CD.
enum WMPBurnState : int
{
    ///Not a valid state.
    wmpbsUnknown              = 0x00000000,
    ///Windows Media Player is busy. Try again in a moment.
    wmpbsBusy                 = 0x00000001,
    ///Ready to begin burning a CD.
    wmpbsReady                = 0x00000002,
    ///Waiting for the disc to become available.
    wmpbsWaitingForDisc       = 0x00000003,
    ///The burn playlist has changed. Call IWMPCdromBurn::refreshStatus.
    wmpbsRefreshStatusPending = 0x00000004,
    ///Windows Media Player is preparing to burn the CD.
    wmpbsPreparingToBurn      = 0x00000005,
    ///The CD is being burned.
    wmpbsBurning              = 0x00000006,
    ///The burning operation is stopped.
    wmpbsStopped              = 0x00000007,
    ///Windows Media Player is erasing the CD.
    wmpbsErasing              = 0x00000008,
    wmpbsDownloading          = 0x00000009,
}

///The <b>WMPStringCollectionChangeEventType</b> enumeration type defines the types of changes that can occur in a
///string collection. <b>Syntax</b>
enum WMPStringCollectionChangeEventType : int
{
    ///Not a valid event type.
    wmpsccetUnknown      = 0x00000000,
    ///An item was inserted.
    wmpsccetInsert       = 0x00000001,
    ///The string collection changed.
    wmpsccetChange       = 0x00000002,
    ///An item was deleted.
    wmpsccetDelete       = 0x00000003,
    ///The string collection was cleared.
    wmpsccetClear        = 0x00000004,
    ///Bulk updates are beginning.
    wmpsccetBeginUpdates = 0x00000005,
    ///Bulk updates have ended.
    wmpsccetEndUpdates   = 0x00000006,
}

///The <b>WMPLibraryType</b> enumeration type defines the possible library types to which Windows Media Player can
///connect.
enum WMPLibraryType : int
{
    ///Not a valid library type.
    wmpltUnknown        = 0x00000000,
    ///All libraries.
    wmpltAll            = 0x00000001,
    ///The current user's library.
    wmpltLocal          = 0x00000002,
    ///A library that belongs to another user on the same computer, the home network, or the Internet. The Player
    ///control must be running in remote mode to access these libraries. For information about running the Player
    ///control in remote mode, see Remoting the Windows Media Player Control.
    wmpltRemote         = 0x00000003,
    ///Libraries on a data CD or DVD.
    wmpltDisc           = 0x00000004,
    ///Libraries on portable devices.
    wmpltPortableDevice = 0x00000005,
}

///The <b>WMPFolderScanState</b> enumeration type defines the possible operational states of Windows Media Player as it
///monitors file folders for digital media content.
enum WMPFolderScanState : int
{
    ///Not a valid state.
    wmpfssUnknown  = 0x00000000,
    ///Scanning folders.
    wmpfssScanning = 0x00000001,
    ///Updating the library.
    wmpfssUpdating = 0x00000002,
    ///Folder monitoring is stopped.
    wmpfssStopped  = 0x00000003,
}

///The <b>WMPServices_StreamState</b> enumeration indicates whether the stream is currently stopped, paused, or playing.
alias WMPServices_StreamState = int;
enum : int
{
    ///The stream is stopped.
    WMPServices_StreamState_Stop  = 0x00000000,
    ///The stream is paused.
    WMPServices_StreamState_Pause = 0x00000001,
    ///The stream is playing.
    WMPServices_StreamState_Play  = 0x00000002,
}

///The <b>WMPPlugin_Caps</b> enumeration type signals whether the plug-in can convert between input and output formats.
alias WMPPlugin_Caps = int;
enum : int
{
    ///The plug-in requires that the input format and output format be the same.
    WMPPlugin_Caps_CannotConvertFormats = 0x00000001,
}

alias FEEDS_BACKGROUNDSYNC_ACTION = int;
enum : int
{
    FBSA_DISABLE = 0x00000000,
    FBSA_ENABLE  = 0x00000001,
    FBSA_RUNNOW  = 0x00000002,
}

alias FEEDS_BACKGROUNDSYNC_STATUS = int;
enum : int
{
    FBSS_DISABLED = 0x00000000,
    FBSS_ENABLED  = 0x00000001,
}

alias FEEDS_EVENTS_SCOPE = int;
enum : int
{
    FES_ALL                    = 0x00000000,
    FES_SELF_ONLY              = 0x00000001,
    FES_SELF_AND_CHILDREN_ONLY = 0x00000002,
}

alias FEEDS_EVENTS_MASK = int;
enum : int
{
    FEM_FOLDEREVENTS = 0x00000001,
    FEM_FEEDEVENTS   = 0x00000002,
}

alias FEEDS_XML_SORT_PROPERTY = int;
enum : int
{
    FXSP_NONE         = 0x00000000,
    FXSP_PUBDATE      = 0x00000001,
    FXSP_DOWNLOADTIME = 0x00000002,
}

alias FEEDS_XML_SORT_ORDER = int;
enum : int
{
    FXSO_NONE       = 0x00000000,
    FXSO_ASCENDING  = 0x00000001,
    FXSO_DESCENDING = 0x00000002,
}

alias FEEDS_XML_FILTER_FLAGS = int;
enum : int
{
    FXFF_ALL    = 0x00000000,
    FXFF_UNREAD = 0x00000001,
    FXFF_READ   = 0x00000002,
}

alias FEEDS_XML_INCLUDE_FLAGS = int;
enum : int
{
    FXIF_NONE          = 0x00000000,
    FXIF_CF_EXTENSIONS = 0x00000001,
}

alias FEEDS_DOWNLOAD_STATUS = int;
enum : int
{
    FDS_NONE            = 0x00000000,
    FDS_PENDING         = 0x00000001,
    FDS_DOWNLOADING     = 0x00000002,
    FDS_DOWNLOADED      = 0x00000003,
    FDS_DOWNLOAD_FAILED = 0x00000004,
}

alias FEEDS_SYNC_SETTING = int;
enum : int
{
    FSS_DEFAULT   = 0x00000000,
    FSS_INTERVAL  = 0x00000001,
    FSS_MANUAL    = 0x00000002,
    FSS_SUGGESTED = 0x00000003,
}

alias FEEDS_DOWNLOAD_ERROR = int;
enum : int
{
    FDE_NONE                         = 0x00000000,
    FDE_DOWNLOAD_FAILED              = 0x00000001,
    FDE_INVALID_FEED_FORMAT          = 0x00000002,
    FDE_NORMALIZATION_FAILED         = 0x00000003,
    FDE_PERSISTENCE_FAILED           = 0x00000004,
    FDE_DOWNLOAD_BLOCKED             = 0x00000005,
    FDE_CANCELED                     = 0x00000006,
    FDE_UNSUPPORTED_AUTH             = 0x00000007,
    FDE_BACKGROUND_DOWNLOAD_DISABLED = 0x00000008,
    FDE_NOT_EXIST                    = 0x00000009,
    FDE_UNSUPPORTED_MSXML            = 0x0000000a,
    FDE_UNSUPPORTED_DTD              = 0x0000000b,
    FDE_DOWNLOAD_SIZE_LIMIT_EXCEEDED = 0x0000000c,
    FDE_ACCESS_DENIED                = 0x0000000d,
    FDE_AUTH_FAILED                  = 0x0000000e,
    FDE_INVALID_AUTH                 = 0x0000000f,
}

alias FEEDS_EVENTS_ITEM_COUNT_FLAGS = int;
enum : int
{
    FEICF_READ_ITEM_COUNT_CHANGED   = 0x00000001,
    FEICF_UNREAD_ITEM_COUNT_CHANGED = 0x00000002,
}

alias FEEDS_ERROR_CODE = int;
enum : int
{
    FEC_E_ERRORBASE                 = 0xc0040200,
    FEC_E_INVALIDMSXMLPROPERTY      = 0xc0040200,
    FEC_E_DOWNLOADSIZELIMITEXCEEDED = 0xc0040201,
}

///The <b>PlayerState</b> enumeration type provides some basic states of Windows Media Player. <table> <tr> <th>Number
///</th> <th>Description </th> </tr> <tr> <td>0</td> <td>Stop state</td> </tr> <tr> <td>1</td> <td>Pause state</td>
///</tr> <tr> <td>2</td> <td>Play state</td> </tr> </table>
enum PlayerState : int
{
    stop_state  = 0x00000000,
    pause_state = 0x00000001,
    play_state  = 0x00000002,
}

///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of this
///functionality outside the context of an online store is not supported.</div> <div> </div> The
///<b>WMPPartnerNotification</b> enumeration defines operational states of an online store.
enum WMPPartnerNotification : int
{
    ///Start background processing.
    wmpsnBackgroundProcessingBegin = 0x00000001,
    ///End background processing.
    wmpsnBackgroundProcessingEnd   = 0x00000002,
    ///The catalog download failed.
    wmpsnCatalogDownloadFailure    = 0x00000003,
    ///The catalog download completed.
    wmpsnCatalogDownloadComplete   = 0x00000004,
}

///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of this
///functionality outside the context of an online store is not supported.</div> <div> </div> The
///<b>WMPCallbackNotification</b> enumeration defines states for use by the <b>IWMPContentPartnerCallback::Notify</b>
///callback function.
enum WMPCallbackNotification : int
{
    ///The user has either signed in or signed out.
    wmpcnLoginStateChange     = 0x00000001,
    ///The notification contains the result of an authentication attempt.
    wmpcnAuthResult           = 0x00000002,
    ///A license was updated for a content item.
    wmpcnLicenseUpdated       = 0x00000003,
    ///A new catalog or update is available for download.
    wmpcnNewCatalogAvailable  = 0x00000004,
    ///A new plug-in or update is available for download.
    wmpcnNewPluginAvailable   = 0x00000005,
    ///Disable radio skipping in Windows Media Player.
    wmpcnDisableRadioSkipping = 0x00000006,
}

///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of this
///functionality outside the context of an online store is not supported.</div> <div> </div> The <b>WMPTaskType</b>
///enumeration represents Windows Media Player task panes.
enum WMPTaskType : int
{
    ///The <b>Browse</b> task pane.
    wmpttBrowse  = 0x00000001,
    ///The <b>Sync</b> task pane.
    wmpttSync    = 0x00000002,
    ///The <b>Burn</b> task pane.
    wmpttBurn    = 0x00000003,
    ///Other task pane.
    wmpttCurrent = 0x00000004,
}

///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of this
///functionality outside the context of an online store is not supported.</div> <div> </div> The
///<b>WMPTransactionType</b> enumeration represents a transaction type.
enum WMPTransactionType : int
{
    ///No transaction.
    wmpttNoTransaction = 0x00000000,
    ///A download transaction.
    wmpttDownload      = 0x00000001,
    ///A purchase transaction.
    wmpttBuy           = 0x00000002,
}

///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of this
///functionality outside the context of an online store is not supported.</div> <div> </div> The <b>WMPTemplateSize</b>
///enumeration represents HTML template sizes.
enum WMPTemplateSize : int
{
    ///Small template; height is fixed at 100 pixels.
    wmptsSmall  = 0x00000000,
    ///Medium template; height is fixed at 250 pixels.
    wmptsMedium = 0x00000001,
    ///Large template. Windows Media Player allocates as much room as possible while allowing space for the list control
    ///to display a single row of items.
    wmptsLarge  = 0x00000002,
}

///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of this
///functionality outside the context of an online store is not supported.</div> <div> </div> The <b>WMPStreamingType</b>
///enumeration specifies the type of streaming media.
enum WMPStreamingType : int
{
    ///Unknown type.
    wmpstUnknown = 0x00000000,
    ///The plug-in must return a URL for music content.
    wmpstMusic   = 0x00000001,
    ///The plug-in must return a URL for video content.
    wmpstVideo   = 0x00000002,
    ///The plug-in must return a URL for radio content.
    wmpstRadio   = 0x00000003,
}

///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of this
///functionality outside the context of an online store is not supported.</div> <div> </div> The <b>WMPAccountType</b>
///enumeration defines account types for an online store.
enum WMPAccountType : int
{
    ///The user is only authorized to purchase content.
    wmpatBuyOnly      = 0x00000001,
    ///The user has a subscription account, but content must be purchased to synchronize to a device based on Windows
    ///Media DRM for Portable Devices.
    wmpatSubscription = 0x00000002,
    ///The user has a subscription account and the subscription content can be synchronized to a device based on Windows
    ///Media DRM for Portable Devices.
    wmpatJanus        = 0x00000003,
}

///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of this
///functionality outside the context of an online store is not supported.</div> <div> </div> The
///<b>WMPSubscriptionServiceEvent</b> enumeration type defines the types of service events that may occur.
enum WMPSubscriptionServiceEvent : int
{
    ///The online store is active.
    wmpsseCurrentBegin = 0x00000001,
    ///The online store is no longer active.
    wmpsseCurrentEnd   = 0x00000002,
    ///The online store is the current active music store.
    wmpsseFullBegin    = 0x00000003,
    ///The online store is no longer the current active music store.
    wmpsseFullEnd      = 0x00000004,
}

enum WMPSubscriptionDownloadState : int
{
    wmpsdlsDownloading = 0x00000000,
    wmpsdlsPaused      = 0x00000001,
    wmpsdlsProcessing  = 0x00000002,
    wmpsdlsCompleted   = 0x00000003,
    wmpsdlsCancelled   = 0x00000004,
}

// Constants


enum : float
{
    kfltTimedLevelMaximumFrequency = 0x1.5888p+14,
    kfltTimedLevelMinimumFrequency = 0x1.4p+4,
}

enum : const(wchar)*
{
    g_szContentPartnerInfo_MediaPlayerAccountType           = "MediaPlayerAccountType",
    g_szContentPartnerInfo_AccountType                      = "AccountType",
    g_szContentPartnerInfo_HasCachedCredentials             = "HasCachedCredentials",
    g_szContentPartnerInfo_LicenseRefreshAdvanceWarning     = "LicenseRefreshAdvanceWarning",
    g_szContentPartnerInfo_PurchasedTrackRequiresReDownload = "PurchasedTrackRequiresReDownload",
    g_szContentPartnerInfo_MaximumTrackPurchasePerPurchase  = "MaximumNumberOfTracksPerPurchase",
    g_szContentPartnerInfo_AccountBalance                   = "AccountBalance",
    g_szContentPartnerInfo_UserName                         = "UserName",
}

enum : const(wchar)*
{
    g_szMediaPlayerTask_Browse = "Browse",
    g_szMediaPlayerTask_Sync   = "Sync",
}

enum const(wchar)* g_szItemInfo_AuthenticationSuccessURL = "AuthenticationSuccessURL";

enum : const(wchar)*
{
    g_szItemInfo_HTMLViewURL       = "HTMLViewURL",
    g_szItemInfo_PopupCaption      = "PopupCaption",
    g_szItemInfo_ALTLoginURL       = "ALTLoginURL",
    g_szItemInfo_ALTLoginCaption   = "ALTLoginCaption",
    g_szItemInfo_ForgetPasswordURL = "ForgotPassword",
    g_szItemInfo_CreateAccountURL  = "CreateAccount",
    g_szItemInfo_ArtistArtURL      = "ArtistArt",
    g_szItemInfo_AlbumArtURL       = "AlbumArt",
    g_szItemInfo_ListArtURL        = "ListArt",
    g_szItemInfo_GenreArtURL       = "GenreArt",
    g_szItemInfo_SubGenreArtURL    = "SubGenreArt",
    g_szItemInfo_RadioArtURL       = "RadioArt",
    g_szItemInfo_TreeListIconURL   = "CPListIDIcon",
    g_szItemInfo_ErrorDescription  = "CPErrorDescription",
    g_szItemInfo_ErrorURL          = "CPErrorURL",
    g_szItemInfo_ErrorURLLinkText  = "CPErrorURLLinkText",
}

enum const(wchar)* g_szRootLocation = "RootLocation";
enum const(wchar)* g_szOnlineStore = "OnlineStore";
enum const(wchar)* g_szVideoRoot = "VideoRoot";
enum const(wchar)* g_szAllCPListIDs = "AllCPListIDs";
enum const(wchar)* g_szAllCPTrackIDs = "AllCPTrackIDs";
enum const(wchar)* g_szAllCPArtistIDs = "AllCPArtistIDs";
enum const(wchar)* g_szAllCPAlbumIDs = "AllCPAlbumIDs";
enum const(wchar)* g_szAllCPGenreIDs = "AllCPGenreIDs";
enum const(wchar)* g_szAllCPAlbumSubGenreIDs = "AllCPAlbumSubGenreIDs";
enum const(wchar)* g_szAllReleaseDateYears = "AllReleaseDateYears";
enum const(wchar)* g_szAllCPRadioIDs = "AllCPRadioIDs";
enum const(wchar)* g_szAllAuthors = "AllAuthors";
enum const(wchar)* g_szAllWMParentalRatings = "AllWMParentalRatings";
enum const(wchar)* g_szUserEffectiveRatingStars = "UserEffectiveRatingStars";

enum : const(wchar)*
{
    g_szViewMode_Report      = "ViewModeReport",
    g_szViewMode_Details     = "ViewModeDetails",
    g_szViewMode_Icon        = "ViewModeIcon",
    g_szViewMode_Tile        = "ViewModeTile",
    g_szViewMode_OrderedList = "ViewModeOrderedList",
}

enum : const(wchar)*
{
    g_szContentPrice_CannotBuy = "PriceCannotBuy",
    g_szContentPrice_Free      = "PriceFree",
}

enum : const(wchar)*
{
    g_szRefreshLicenseBurn = "RefreshForBurn",
    g_szRefreshLicenseSync = "RefreshForSync",
}

enum : const(wchar)*
{
    g_szStationEvent_Started  = "TrackStarted",
    g_szStationEvent_Complete = "TrackComplete",
    g_szStationEvent_Skipped  = "TrackSkipped",
}

// Structs


///The <b>TimedLevel</b> structure holds data returned from the spectrum filter.
struct TimedLevel
{
    ///A stereo snapshot of the frequency spectrum of the audio data at a time specified by the Plug-in Manager. It can
    ///be used for frequency spectrum effects such as real-time analyzers. The frequency value of the first cell is 20
    ///Hz, and the frequency value of the last cell is 22050 Hz.
    ubyte[2048] frequency;
    ///A stereo snapshot of the power value of the audio data at a time specified by the Plug-in Manager as the first
    ///element; the next 1024 stereo power values fill out the rest of the array. It can be used for oscilloscope-type
    ///effects.
    ubyte[2048] waveform;
    ///One member of the PlayerState enumeration type.
    int         state;
    ///The time the snapshot took place, in a 64-bit integer. The time value is provided in 100-nanosecond units.
    long        timeStamp;
}

///The <b>WMPContextMenuInfo</b> structure contains data about a context menu command. <div class="alert"><b>Note</b>
///This section describes functionality designed for use by online stores. Use of this functionality outside the context
///of an online store is not supported.</div><div> </div>
struct WMPContextMenuInfo
{
    ///The ID of the command.
    uint dwID;
    ///The menu text to display for the command.
    BSTR bstrMenuText;
    ///The help text to display for the command.
    BSTR bstrHelpText;
}

///The <b>WMP_WMDM_METADATA_ROUND_TRIP_PC2DEVICE</b> structure is used by Windows Media Player to request accelerated
///metadata synchronization information from portable devices that do not support MTP.
struct WMP_WMDM_METADATA_ROUND_TRIP_PC2DEVICE
{
align (1):
    ///The transaction identifier supplied by the device during the previous session. This value is zero for the first
    ///session ever.
    uint dwChangesSinceTransactionID;
    ///The index of the first value to retrieve. This value is always zero for the first call of a session.
    uint dwResultSetStartingIndex;
}

///The <b>WMP_WMDM_METADATA_ROUND_TRIP_DEVICE2PC</b> structure is used by Windows Media Player to receive accelerated
///metadata synchronization information from portable devices that do not support MTP.
struct WMP_WMDM_METADATA_ROUND_TRIP_DEVICE2PC
{
align (1):
    ///The current transaction ID for the device. Windows Media Player stores this value and uses it for future
    ///requests.
    uint      dwCurrentTransactionID;
    ///The number of object path names returned in the <b>wsObjectPathnameList</b> member.
    uint      dwReturnedObjectCount;
    ///The number of objects that were changed or deleted, but that are not part of this response. A value greater than
    ///zero signals Windows Media Player to make a further request.
    uint      dwUnretrievedObjectCount;
    ///The index of the first character of the first deleted object path name. If the path name list contains only
    ///deleted objects, specify zero. If the path name list contains no deleted objects, specify the index of the last
    ///null character in the path name list. Note that this value is the number of Unicode characters to skip in
    ///<b>wsObjectPathnameList</b>, not the number of bytes.
    uint      dwDeletedObjectStartingOffset;
    ///The status information. Status is indicated in a bitwise fashion by using the following flags. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WMP_MDRT_FLAGS_UNREPORTED_DELETED_ITEMS"></a><a
    ///id="wmp_mdrt_flags_unreported_deleted_items"></a><dl> <dt><b>WMP_MDRT_FLAGS_UNREPORTED_DELETED_ITEMS</b></dt>
    ///<dt>0x1</dt> </dl> </td> <td width="60%"> Items were deleted before the first object path name being reported.
    ///This often indicates that the device was reformatted. </td> </tr> <tr> <td width="40%"><a
    ///id="WMP_MDRT_FLAGS_UNREPORTED_ADDED_ITEMS"></a><a id="wmp_mdrt_flags_unreported_added_items"></a><dl>
    ///<dt><b>WMP_MDRT_FLAGS_UNREPORTED_ADDED_ITEMS</b></dt> <dt>0x2</dt> </dl> </td> <td width="60%"> Some additional
    ///items were added that were not returned in the list of PUOIDs. </td> </tr> </table> Bits 2 through 31 are
    ///reserved for future use. These bits should be set to zero.
    uint      dwFlags;
    ///Contains a contiguous list of null terminated Unicode path name strings, terminated with an extra null character.
    ///The list must be created in the following manner: First, path name strings for all objects that have been added
    ///to the device or have had a change for the PlayCount, UserRating, or BuyNow attributes. Second, path name strings
    ///for all objects that have been deleted. The index of the first character of this part of the list is contained in
    ///the <b>dwDeletedObjectStartingOffset</b> member.
    ushort[1] wsObjectPathnameList;
}

// Interfaces

@GUID("6BF52A52-394A-11D3-B153-00C04F79FAA6")
struct WindowsMediaPlayer;

@GUID("6BF52A50-394A-11D3-B153-00C04F79FAA6")
struct WMPLib;

@GUID("DF333473-2CF7-4BE2-907F-9AAD5661364F")
struct WMPRemoteMediaServices;

@GUID("FAEB54C4-F66F-4806-83A0-805299F5E3AD")
struct FeedsManager;

@GUID("281001ED-7765-4CB0-84AF-E9B387AF01FF")
struct FeedFolderWatcher;

@GUID("18A6737B-F433-4687-89BC-A1B4DFB9F123")
struct FeedWatcher;

///The <b>IWMPErrorItem</b> interface provides a way to access error information.
@GUID("3614C646-3B3B-4DE7-A81E-930E3F2127B3")
interface IWMPErrorItem : IDispatch
{
    ///The <b>get_errorCode</b> method retrieves the current error code.
    ///Params:
    ///    phr = Pointer to a <b>long</b> containing the error code.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_errorCode(int* phr);
    ///The <b>get_errorDescription</b> method retrieves a description of the error.
    ///Params:
    ///    pbstrDescription = Pointer to a <b>BSTR</b> containing the description.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_errorDescription(BSTR* pbstrDescription);
    ///The <b>get_errorContext</b> method retrieves a value indicating the context of the error.
    ///Params:
    ///    pvarContext = Pointer to a <b>VARIANT</b> containing the error context.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_errorContext(VARIANT* pvarContext);
    ///Reserved for future use.
    ///Params:
    ///    plRemedy = Pointer to a <b>long</b> containing the remedy.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_remedy(int* plRemedy);
    ///The <b>get_customUrl</b> method retrieves the URL of a website that displays specific information about codec
    ///download failure.
    ///Params:
    ///    pbstrCustomUrl = Pointer to a <b>BSTR</b> containing the custom url.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_customUrl(BSTR* pbstrCustomUrl);
}

///The <b>IWMPError</b> interface provides methods for accessing a collection of <b>IWMPErrorItem</b> pointers.
@GUID("A12DCF7D-14AB-4C1B-A8CD-63909F06025B")
interface IWMPError : IDispatch
{
    ///The <b>clearErrorQueue</b> method clears the errors from the error queue.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT clearErrorQueue();
    ///The <b>get_errorCount</b> method retrieves the number of errors in the error queue.
    ///Params:
    ///    plNumErrors = Pointer to a <b>long</b> containing the number of errors.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_errorCount(int* plNumErrors);
    ///The <b>get_item</b> method retrieves a pointer to an <b>IWMPErrorItem</b> interface from the error queue.
    ///Params:
    ///    dwIndex = <b>long</b> containing the index of the pointer to an <b>IWMPErrorItem</b> interface.
    ///    ppErrorItem = Pointer to a pointer to an <b>IWMPErrorItem</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_item(int dwIndex, IWMPErrorItem* ppErrorItem);
    ///The <b>webHelp</b> method launches the Windows Media Player Web Help page to display further information about
    ///the first error in the error queue (index zero).
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT webHelp();
}

///Use the <b>IWMPMedia</b> interface to set and retrieve the properties of a media item.
@GUID("94D55E95-3FAC-11D3-B155-00C04F79FAA6")
interface IWMPMedia : IDispatch
{
    ///The <b>get_isIdentical</b> method retrieves a value indicating whether the specified object is the same as the
    ///current one.
    ///Params:
    ///    pIWMPMedia = Pointer to an <b>IWMPMedia</b> object that this method will compare to the current object.
    ///    pvbool = Pointer to a <b>VARIANT_BOOL</b> that indicates whether the objects were identical.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_isIdentical(IWMPMedia pIWMPMedia, short* pvbool);
    ///The <b>get_sourceURL</b> method retrieves the URL of the media item.
    ///Params:
    ///    pbstrSourceURL = Pointer to a <b>BSTR</b> containing the source URL.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_sourceURL(BSTR* pbstrSourceURL);
    ///The <b>get_name</b> method retrieves the name of the media item.
    ///Params:
    ///    pbstrName = Pointer to a <b>BSTR</b> containing the name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_name(BSTR* pbstrName);
    ///The <b>put_name</b> method specifies sets the name of the media item.
    ///Params:
    ///    bstrName = <b>BSTR</b> containing the name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_name(BSTR bstrName);
    ///The <b>get_imageSourceWidth</b> method retrieves the width of the current media item in pixels.
    ///Params:
    ///    pWidth = Pointer to a <b>long</b> that specifies the width.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_imageSourceWidth(int* pWidth);
    ///The <b>get_imageSourceHeight</b> method retrieves the height of the current media item in pixels.
    ///Params:
    ///    pHeight = Pointer to a <b>long</b> that specifies the height.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_imageSourceHeight(int* pHeight);
    ///The <b>get_markerCount</b> method retrieves the number of markers in the media item.
    ///Params:
    ///    pMarkerCount = Pointer to a <b>long</b> that contains the marker count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_markerCount(int* pMarkerCount);
    ///The <b>getMarkerTime</b> method retrieves the time of the marker at the specified index.
    ///Params:
    ///    MarkerNum = <b>long</b> specifying the marker index.
    ///    pMarkerTime = Pointer to a <b>double</b> that specifies the marker time.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getMarkerTime(int MarkerNum, double* pMarkerTime);
    ///The <b>getMarkerName</b> method retrieves the name of the marker at the specified index.
    ///Params:
    ///    MarkerNum = <b>long</b> specifying the marker index.
    ///    pbstrMarkerName = Pointer to a <b>BSTR</b> containing the marker name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getMarkerName(int MarkerNum, BSTR* pbstrMarkerName);
    ///The <b>get_duration</b> method retrieves the duration in seconds of the current media item..
    ///Params:
    ///    pDuration = Pointer to a <b>double</b> containing the duration.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_duration(double* pDuration);
    ///The <b>get_durationString</b> method retrieves a string indicating the duration of the current media item in
    ///HH:MM:SS format.
    ///Params:
    ///    pbstrDuration = Pointer to a <b>BSTR</b> containing the duration.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_durationString(BSTR* pbstrDuration);
    ///The <b>get_attributeCount</b> method retrieves the number of attributes that can be queried and/or set for the
    ///media item.
    ///Params:
    ///    plCount = Pointer to a <b>long</b> containing the count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_attributeCount(int* plCount);
    ///The <b>getAttributeName</b> method retrieves the name of the attribute corresponding to the specified index.
    ///Params:
    ///    lIndex = <b>long</b> containing the index.
    ///    pbstrItemName = Pointer to a <b>BSTR</b> containing the attribute name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getAttributeName(int lIndex, BSTR* pbstrItemName);
    ///The <b>getItemInfo</b> method retrieves the value of the specified attribute for the media item.
    ///Params:
    ///    bstrItemName = <b>BSTR</b> containing the item name.
    ///    pbstrVal = Pointer to a <b>BSTR</b> containing the returned value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getItemInfo(BSTR bstrItemName, BSTR* pbstrVal);
    ///The <b>setItemInfo</b> method sets the value of the specified attribute for the media item.
    ///Params:
    ///    bstrItemName = <b>BSTR</b> containing the attribute name.
    ///    bstrVal = <b>BSTR</b> containing the new value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT setItemInfo(BSTR bstrItemName, BSTR bstrVal);
    ///The <b>getItemInfoByAtom</b> method retrieves the value of the attribute with the specified index number.
    ///Params:
    ///    lAtom = <b>long</b> specifying the index at which a given attribute resides within the set of available attributes.
    ///    pbstrVal = Pointer to a <b>BSTR</b> containing the returned value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getItemInfoByAtom(int lAtom, BSTR* pbstrVal);
    ///The <b>isMemberOf</b> method retrieves a value indicating whether the specified media item is a member of the
    ///specified playlist.
    ///Params:
    ///    pPlaylist = Pointer to an <b>IWMPPlaylist</b> interface.
    ///    pvarfIsMemberOf = Pointer to a <b>VARIANT_BOOL</b> that indicates whether the item is a member of the playlist.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT isMemberOf(IWMPPlaylist pPlaylist, short* pvarfIsMemberOf);
    ///The <b>isReadOnlyItem</b> method retrieves a value indicating whether the attributes of the specified media item
    ///can be edited.
    ///Params:
    ///    bstrItemName = <b>BSTR</b> containing the item name.
    ///    pvarfIsReadOnly = Pointer to a <b>VARIANT_BOOL</b> that specifies whether the attributes are read-only.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT isReadOnlyItem(BSTR bstrItemName, short* pvarfIsReadOnly);
}

///The <b>IWMPControls</b> interface provides a way to manipulate the playback of a media item.
@GUID("74C09E02-F828-11D2-A74B-00A0C905F36E")
interface IWMPControls : IDispatch
{
    ///The <b>get_isAvailable</b> method indicates whether a specified type of information is available or a specified
    ///action can be performed.
    ///Params:
    ///    bstrItem = <b>BSTR</b> containing one of the following values. <table> <tr> <th>Value </th> <th>Description </th> </tr>
    ///               <tr> <td>currentItem</td> <td>Determines whether the user can set the <b>IWMPControls::put_currentItem</b>
    ///               method.</td> </tr> <tr> <td>currentMarker</td> <td>Determines whether the user can seek to a specific
    ///               marker.</td> </tr> <tr> <td>currentPosition</td> <td>Determines whether the user can seek to a specific
    ///               position in the file. Some files do not support seeking.</td> </tr> <tr> <td>fastForward</td> <td>Determines
    ///               whether the file supports fast forwarding and whether that functionality can be invoked. Many file types (or
    ///               live streams) do not support fastForward.</td> </tr> <tr> <td>fastReverse</td> <td>Determines whether the
    ///               file supports fastReverse and whether that functionality can be invoked. Many file types (or live streams) do
    ///               not support fastReverse.</td> </tr> <tr> <td>next</td> <td>Determines whether the user can seek to the next
    ///               entry in a playlist.</td> </tr> <tr> <td>pause</td> <td>Determines whether the <b>IWMPControls::pause</b>
    ///               method is available.</td> </tr> <tr> <td>play</td> <td>Determines whether the <b>IWMPControls::play</b>
    ///               method is available.</td> </tr> <tr> <td>previous</td> <td>Determines whether the user can seek to the
    ///               previous entry in a playlist.</td> </tr> <tr> <td>step</td> <td>Determines whether the
    ///               <b>IWMPControls2::step</b> method is available during playback.</td> </tr> <tr> <td>stop</td> <td>Determines
    ///               whether the <b>IWMPControls::stop</b> method is available.</td> </tr> </table>
    ///    pIsAvailable = Pointer to a <b>VARIANT_BOOL</b> indicating whether a specified type of information is available or a
    ///                   specified action can be performed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_isAvailable(BSTR bstrItem, short* pIsAvailable);
    ///The <b>play</b> method causes the current media item to start playing, or resumes play of a paused item.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT play();
    ///The <b>stop</b> method stops playback of the media item.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT stop();
    ///The <b>pause</b> method pauses playback of the media item.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT pause();
    ///The <b>fastForward</b> method starts fast play of the media item in the forward direction.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT fastForward();
    ///The <b>fastReverse</b> method starts fast play of the media item in the reverse direction.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT fastReverse();
    ///The <b>get_currentPosition</b> method retrieves the current position in the media item in seconds from the
    ///beginning.
    ///Params:
    ///    pdCurrentPosition = Pointer to a <b>double</b> containing the current position.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_currentPosition(double* pdCurrentPosition);
    ///The <b>put_currentPosition</b> method specifies the current position in the media item in seconds from the
    ///beginning.
    ///Params:
    ///    dCurrentPosition = <b>double</b> containing the current position.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_currentPosition(double dCurrentPosition);
    ///The <b>get_currentPositionString</b> method retrieves the current position in the media item as a <b>BSTR</b>
    ///formatted as HH:MM:SS (hours, minutes, and seconds).
    ///Params:
    ///    pbstrCurrentPosition = Pointer to a <b>BSTR</b> containing the current position.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_currentPositionString(BSTR* pbstrCurrentPosition);
    ///The <b>next</b> method sets the next item in the playlist as the current item.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT next();
    ///The <b>previous</b> method sets the previous item in the playlist as the current item.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT previous();
    ///The <b>get_currentItem</b> method retrieves the current media item in a playlist.
    ///Params:
    ///    ppIWMPMedia = Pointer to a pointer to an <b>IWMPMedia</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_currentItem(IWMPMedia* ppIWMPMedia);
    ///The <b>put_currentItem</b> method specifies the current media item.
    ///Params:
    ///    pIWMPMedia = Pointer to an <b>IWMPMedia</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_currentItem(IWMPMedia pIWMPMedia);
    ///The <b>get_currentMarker</b> method retrieves the current marker number.
    ///Params:
    ///    plMarker = Pointer to a <b>long</b> containing the marker.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_currentMarker(int* plMarker);
    ///The <b>put_currentMarker</b> method specifies the current marker number.
    ///Params:
    ///    lMarker = <b>long</b> containing the marker.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_currentMarker(int lMarker);
    ///The <b>playItem</b> method plays the specified media item.
    ///Params:
    ///    pIWMPMedia = Pointer to an <b>IWMPMedia</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT playItem(IWMPMedia pIWMPMedia);
}

///The <b>IWMPSettings</b> interface provides methods that get or set the values of Windows Media Player settings.
@GUID("9104D1AB-80C9-4FED-ABF0-2E6417A6DF14")
interface IWMPSettings : IDispatch
{
    ///The <b>get_isAvailable</b> method indicates whether a specified action can be performed.
    ///Params:
    ///    bstrItem = <b>BSTR</b> containing one of the following values. <table> <tr> <th>Value </th> <th>Description </th> </tr>
    ///               <tr> <td>AutoStart</td> <td>Determines whether the <b>put_autoStart</b> method can be used to specify that
    ///               Windows Media Player starts playback automatically.</td> </tr> <tr> <td>Balance</td> <td>Determines whether
    ///               the <b>put_balance</b> method can be used to set the stereo balance.</td> </tr> <tr> <td>BaseURL</td>
    ///               <td>Determines whether the <b>put_baseURL</b> method can be used to specify a base URL.</td> </tr> <tr>
    ///               <td>DefaultFrame</td> <td>Determines whether the <b>put_defaultFrame</b> method can be used to specify the
    ///               default frame.</td> </tr> <tr> <td>EnableErrorDialogs</td> <td>Determines whether the
    ///               <b>put_enableErrorDialogs</b> method can be used to enable or disable displaying error dialog boxes.</td>
    ///               </tr> <tr> <td>GetMode</td> <td>Determines whether the <b>getMode</b> method can be used to retrieve the
    ///               current loop or shuffle mode.</td> </tr> <tr> <td>InvokeURLs</td> <td>Determines whether the
    ///               <b>put_invokeURLs</b> method can be used to specify whether URL events should launch a Web browser.</td>
    ///               </tr> <tr> <td>Mute</td> <td>Determines whether the <b>put_mute</b> method can be used to specify whether the
    ///               audio output is on or off.</td> </tr> <tr> <td>PlayCount</td> <td>Determines whether the <b>put_playCount</b>
    ///               method can be used to specify the number times a media item will play.</td> </tr> <tr> <td>Rate</td>
    ///               <td>Determines whether the <b>put_rate</b> method can be used to set the playback rate.</td> </tr> <tr>
    ///               <td>SetMode</td> <td>Determines whether the <b>setMode</b> method can be used to specify the current loop or
    ///               shuffle mode.</td> </tr> <tr> <td>Volume</td> <td>Determines whether the <b>put_volume</b> method can be used
    ///               to specify the audio volume.</td> </tr> </table>
    ///    pIsAvailable = Pointer to a <b>VARIANT_BOOL</b> indicating whether the specified action can be performed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_isAvailable(BSTR bstrItem, short* pIsAvailable);
    ///The <b>get_autoStart</b> method retrieves a value indicating whether the current media item begins playing
    ///automatically.
    ///Params:
    ///    pfAutoStart = Pointer to a <b>VARIANT_BOOL</b> that indicates whether the current media item begins playing automatically.
    ///                  The default is <b>TRUE</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_autoStart(short* pfAutoStart);
    ///The <b>put_autoStart</b> method specifies a value indicating whether the current media item begins playing
    ///automatically.
    ///Params:
    ///    fAutoStart = <b>VARIANT_BOOL</b> indicating whether the current media item begins playing automatically. The default is
    ///                 <b>TRUE</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_autoStart(short fAutoStart);
    ///The <b>get_baseURL</b> method retrieves the base URL used for relative path resolution with URL script commands
    ///that are embedded in digital media content.
    ///Params:
    ///    pbstrBaseURL = Pointer to a <b>BSTR</b> containing the base URL.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_baseURL(BSTR* pbstrBaseURL);
    ///The <b>put_baseURL</b> method specifies the base URL used for relative path resolution with URL script commands
    ///that are embedded in digital media files.
    ///Params:
    ///    bstrBaseURL = <b>BSTR</b> containing the base URL.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_baseURL(BSTR bstrBaseURL);
    ///The <b>get_defaultFrame</b> method retrieves the name of the frame used to display a URL that is received in a
    ///<b>ScriptCommand</b> event.
    ///Params:
    ///    pbstrDefaultFrame = Pointer to a <b>BSTR</b> containing the value of the name attribute of the target FRAME element.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_defaultFrame(BSTR* pbstrDefaultFrame);
    ///The <b>put_defaultFrame</b> method specifies the name of the frame used to display a URL that is received in a
    ///<b>ScriptCommand</b> event.
    ///Params:
    ///    bstrDefaultFrame = <b>BSTR</b> containing the value of the name attribute of the target FRAME element.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_defaultFrame(BSTR bstrDefaultFrame);
    ///The <b>get_invokeURLs</b> method retrieves a value indicating whether URL events should launch a Web browser.
    ///Params:
    ///    pfInvokeURLs = Pointer to a <b>VARIANT_BOOL</b> indicating whether URL events should launch a Web browser. The default is
    ///                   <b>TRUE</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_invokeURLs(short* pfInvokeURLs);
    ///The <b>put_invokeURLs</b> method specifies a value indicating whether URL events should launch a Web browser.
    ///Params:
    ///    fInvokeURLs = <b>VARIANT_BOOL</b> indicating whether URL events should launch a Web browser. The default is <b>TRUE</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_invokeURLs(short fInvokeURLs);
    ///The <b>get_mute</b> method retrieves a value indicating whether audio is muted.
    ///Params:
    ///    pfMute = Pointer to a <b>VARIANT_BOOL</b> indicating whether audio is muted. The default is <b>FALSE</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_mute(short* pfMute);
    ///The <b>put_mute</b> method specifies a value indicating whether audio is muted.
    ///Params:
    ///    fMute = <b>VARIANT_BOOL</b> indicating whether audio is muted. The default is <b>FALSE</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_mute(short fMute);
    ///The <b>get_playCount</b> method retrieves the number of times a media item will play.
    ///Params:
    ///    plCount = Pointer to a <b>long</b> containing the count with a minimum value of 1 and a default value of 1.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_playCount(int* plCount);
    ///The <b>put_playCount</b> method specifies the number of times a media item will play.
    ///Params:
    ///    lCount = <b>long</b> containing the count with a minimum value of 1 and a default value of 1.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_playCount(int lCount);
    ///The <b>get_rate</b> method retrieves the current playback rate for video.
    ///Params:
    ///    pdRate = Pointer to a <b>double</b> containing the rate with a default value of 1.0.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_rate(double* pdRate);
    ///The <b>put_rate</b> method specifies the current playback rate for video.
    ///Params:
    ///    dRate = <b>double</b> containing the rate with a default value of 1.0.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_rate(double dRate);
    ///The <b>get_balance</b> method retrieves the current stereo balance.
    ///Params:
    ///    plBalance = Pointer to a <b>long</b> containing the balance. This value can range from –100 to 100. The default value
    ///                is zero.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_balance(int* plBalance);
    ///The <b>put_balance</b> method specifies the current stereo balance.
    ///Params:
    ///    lBalance = <b>long</b> containing the balance. Values range from –100 to 100. The default value is zero.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_balance(int lBalance);
    ///The <b>get_volume</b> method retrieves the current playback volume.
    ///Params:
    ///    plVolume = Pointer to a <b>long</b> containing the volume level ranging from 0 to 100.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_volume(int* plVolume);
    ///The <b>put_volume</b> method specifies the current playback volume.
    ///Params:
    ///    lVolume = <b>long</b> containing the volume level ranging from 0 to 100.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_volume(int lVolume);
    ///The <b>getMode</b> method determines whether the loop mode or shuffle mode is active.
    ///Params:
    ///    bstrMode = <b>BSTR</b> containing one of the following values. <table> <tr> <th>Value </th> <th>Description </th> </tr>
    ///               <tr> <td>autoRewind</td> <td>Tracks are restarted from the beginning after playing to the end.</td> </tr>
    ///               <tr> <td>loop</td> <td>The sequence of tracks repeats itself.</td> </tr> <tr> <td>showFrame</td> <td>The
    ///               nearest key frame is displayed when not playing. This mode is not relevant for audio tracks.</td> </tr> <tr>
    ///               <td>shuffle</td> <td>Tracks are played in random order.</td> </tr> </table>
    ///    pvarfMode = Pointer to a <b>VARIANT_BOOL</b> indicating whether the specified mode is active.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getMode(BSTR bstrMode, short* pvarfMode);
    ///The <b>setMode</b> method sets the state of playback options.
    ///Params:
    ///    bstrMode = <b>BSTR</b> containing one of the following values. <table> <tr> <th>Value </th> <th>Description </th> </tr>
    ///               <tr> <td>autoRewind</td> <td>Tracks are restarted at the beginning after playing to the end. Default state is
    ///               true.</td> </tr> <tr> <td>loop</td> <td>The sequence of tracks repeats itself. Default state is false.</td>
    ///               </tr> <tr> <td>showFrame</td> <td>The nearest video keyframe is displayed when not playing. Default state is
    ///               false. Has no effect on audio tracks.</td> </tr> <tr> <td>shuffle</td> <td>Tracks are played in random order.
    ///               Default state is false.</td> </tr> </table>
    ///    varfMode = <b>VARIANT_BOOL</b> specifying whether the specified mode is active.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT setMode(BSTR bstrMode, short varfMode);
    ///The <b>get_enableErrorDialogs</b> method retrieves a value indicating whether error dialog boxes are displayed
    ///automatically.
    ///Params:
    ///    pfEnableErrorDialogs = Pointer to a <b>VARIANT_BOOL</b> indicating whether error dialog boxes are displayed automatically. The
    ///                           default is <b>TRUE</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_enableErrorDialogs(short* pfEnableErrorDialogs);
    ///The <b>put_enableErrorDialogs</b> method specifies a value indicating whether error dialog boxes are displayed
    ///automatically.
    ///Params:
    ///    fEnableErrorDialogs = <b>VARIANT_BOOL</b> indicating whether error dialog boxes are displayed automatically. The default is
    ///                          <b>TRUE</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_enableErrorDialogs(short fEnableErrorDialogs);
}

///The <b>IWMPClosedCaption</b> interface provides a way to include captions with a digital media file. The captioning
///text is in a Synchronized Accessible Media Interchange (SAMI) file.
@GUID("4F2DF574-C588-11D3-9ED0-00C04FB6E937")
interface IWMPClosedCaption : IDispatch
{
    ///The <b>get_SAMIStyle</b> method retrieves the closed captioning style.
    ///Params:
    ///    pbstrSAMIStyle = Pointer to a <b>BSTR</b> containing the SAMI style.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_SAMIStyle(BSTR* pbstrSAMIStyle);
    ///The <b>put_SAMIStyle</b> method specifies the closed captioning style.
    ///Params:
    ///    bstrSAMIStyle = <b>BSTR</b> containing the SAMI style.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_SAMIStyle(BSTR bstrSAMIStyle);
    ///The <b>get_SAMILang</b> method retrieves the language displayed for closed captioning.
    ///Params:
    ///    pbstrSAMILang = Pointer to a <b>BSTR</b> containing the language.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_SAMILang(BSTR* pbstrSAMILang);
    ///The <b>put_SAMILang</b> method specifies the language displayed for closed captioning.
    ///Params:
    ///    bstrSAMILang = Pointer to a <b>BSTR</b> containing the language.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_SAMILang(BSTR bstrSAMILang);
    ///The <b>get_SAMIFileName</b> method retrieves the name of the file containing the information needed for closed
    ///captioning.
    ///Params:
    ///    pbstrSAMIFileName = Pointer to a <b>BSTR</b> containing the name of the Synchronized Accessible Media Interchange (SAMI) file.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_SAMIFileName(BSTR* pbstrSAMIFileName);
    ///The <b>put_SAMIFileName</b> method specifies the name of the file containing the information needed for closed
    ///captioning.
    ///Params:
    ///    bstrSAMIFileName = <b>BSTR</b> containing the SAMI file name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_SAMIFileName(BSTR bstrSAMIFileName);
    ///The <b>get_captioningId</b> method retrieves the name of the element displaying the captioning.
    ///Params:
    ///    pbstrCaptioningID = Pointer to a <b>BSTR</b> containing the captioning ID.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_captioningId(BSTR* pbstrCaptioningID);
    ///The <b>put_captioningId</b> method specifies the name of the element displaying the captioning.
    ///Params:
    ///    bstrCaptioningID = <b>BSTR</b> containing the captioning ID.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_captioningId(BSTR bstrCaptioningID);
}

///The <b>IWMPPlaylist</b> interface provides methods for manipulating lists of media items.
@GUID("D5F0F4F1-130C-11D3-B14E-00C04F79FAA6")
interface IWMPPlaylist : IDispatch
{
    ///The <b>get_count</b> method retrieves the number of items in the playlist.
    ///Params:
    ///    plCount = Pointer to a <b>long</b> containing the count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_count(int* plCount);
    ///The <b>get_name</b> method retrieves the name of the playlist.
    ///Params:
    ///    pbstrName = Pointer to a <b>BSTR</b> containing the name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_name(BSTR* pbstrName);
    ///The <b>put_name</b> method specifies the name of the playlist.
    ///Params:
    ///    bstrName = String containing the name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_name(BSTR bstrName);
    ///The <b>get_attributeCount</b> method retrieves the number of attributes associated with the playlist.
    ///Params:
    ///    plCount = Pointer to a <b>long</b> containing the count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_attributeCount(int* plCount);
    ///The <b>get_attributeName</b> method retrieves the name of an attribute specified by an index.
    ///Params:
    ///    lIndex = <b>long</b> containing the index.
    ///    pbstrAttributeName = Pointer to a <b>BSTR</b> containing the attribute name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_attributeName(int lIndex, BSTR* pbstrAttributeName);
    ///The <b>get_item</b> method retrieves the media item at the specified index.
    ///Params:
    ///    lIndex = <b>long</b> containing the index.
    ///    ppIWMPMedia = Pointer to a pointer to an <b>IWMPMedia</b> interface for the returned item.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_item(int lIndex, IWMPMedia* ppIWMPMedia);
    ///The <b>getItemInfo</b> method retrieves the value of a playlist attribute specified by name.
    ///Params:
    ///    bstrName = <b>BSTR</b> containing the name.
    ///    pbstrVal = Pointer to a <b>BSTR</b> containing the returned value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getItemInfo(BSTR bstrName, BSTR* pbstrVal);
    ///The <b>setItemInfo</b> method specifies the value of an attribute of the current playlist. .
    ///Params:
    ///    bstrName = String containing the attribute name.
    ///    bstrValue = String containing the attribute value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT setItemInfo(BSTR bstrName, BSTR bstrValue);
    ///The <b>get_isIdentical</b> method retrieves a value indicating whether the specified playlist is identical to the
    ///current playlist.
    ///Params:
    ///    pIWMPPlaylist = Pointer to an <b>IWMPPlaylist</b> interface for the playlist that this method compares to the current
    ///                    playlist.
    ///    pvbool = <b>VARIANT_BOOL</b> that specifies whether the compared playlists were identical.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_isIdentical(IWMPPlaylist pIWMPPlaylist, short* pvbool);
    ///The <b>clear</b> method is reserved for future use.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT clear();
    ///The <b>insertItem</b> method adds a media item at the specified location in the playlist.
    ///Params:
    ///    lIndex = <b>long</b> containing the index at which this method will add the item.
    ///    pIWMPMedia = Pointer to an <b>IWMPMedia</b> interface for the inserted item.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT insertItem(int lIndex, IWMPMedia pIWMPMedia);
    ///The <b>appendItem</b> method adds a media item to the end of the playlist.
    ///Params:
    ///    pIWMPMedia = Pointer to an <b>IWMPMedia</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT appendItem(IWMPMedia pIWMPMedia);
    ///The <b>removeItem</b> method removes the specified media item from the playlist.
    ///Params:
    ///    pIWMPMedia = Pointer to an <b>IWMPMedia</b> interface for the item to remove.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT removeItem(IWMPMedia pIWMPMedia);
    ///The <b>moveItem</b> method changes the location of a media item in the playlist.
    ///Params:
    ///    lIndexOld = <b>long</b> containing the original index.
    ///    lIndexNew = <b>long</b> containing the new index.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT moveItem(int lIndexOld, int lIndexNew);
}

///The <b>IWMPCdrom</b> interface provides a way to access a CD or DVD in its drive.
@GUID("CFAB6E98-8730-11D3-B388-00C04F68574B")
interface IWMPCdrom : IDispatch
{
    ///The <b>get_driveSpecifier</b> method retrieves the CD or DVD drive letter.
    ///Params:
    ///    pbstrDrive = Pointer to a <b>BSTR</b> containing the drive.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_driveSpecifier(BSTR* pbstrDrive);
    ///The <b>get_playlist</b> method retrieves a pointer to an <b>IWMPPlaylist</b> interface representing the tracks on
    ///the CD currently in the CD drive or the root-level title entries for a DVD.
    ///Params:
    ///    ppPlaylist = Pointer to a pointer to an <b>IWMPPlaylist</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_playlist(IWMPPlaylist* ppPlaylist);
    ///The <b>eject</b> method ejects the CD or DVD from the drive.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT eject();
}

///The <b>IWMPCdromCollection</b> interface provides a way to organize and access a collection of CD or DVD drives.
@GUID("EE4C8FE2-34B2-11D3-A3BF-006097C9B344")
interface IWMPCdromCollection : IDispatch
{
    ///The <b>get_count</b> method retrieves the number of available CD and DVD drives on the system.
    ///Params:
    ///    plCount = Pointer to a <b>long</b> containing the count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_count(int* plCount);
    ///The <b>item</b> method retrieves a pointer to an <b>IWMPCdrom</b> interface at the given index.
    ///Params:
    ///    lIndex = <b>long</b> containing the index.
    ///    ppItem = Pointer to a pointer to an <b>IWMPCdrom</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT item(int lIndex, IWMPCdrom* ppItem);
    ///The <b>getByDriveSpecifier</b> method retrieves a pointer to an <b>IWMPCdrom</b> interface associated with a
    ///particular drive letter.
    ///Params:
    ///    bstrDriveSpecifier = <b>BSTR</b> containing the drive letter followed by a colon (":") character.
    ///    ppCdrom = Pointer to a pointer to an <b>IWMPCdrom</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getByDriveSpecifier(BSTR bstrDriveSpecifier, IWMPCdrom* ppCdrom);
}

///The <b>IWMPStringCollection</b> interface provides methods that work with a collection of strings.
@GUID("4A976298-8C0D-11D3-B389-00C04F68574B")
interface IWMPStringCollection : IDispatch
{
    ///The <b>get_count</b> method retrieves the number of items in the string collection.
    ///Params:
    ///    plCount = Pointer to a <b>long</b> containing the count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_count(int* plCount);
    ///The <b>item</b> method retrieves the string at the given index.
    ///Params:
    ///    lIndex = <b>long</b> containing the index.
    ///    pbstrString = Pointer to a <b>BSTR</b> containing the string.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT item(int lIndex, BSTR* pbstrString);
}

///The <b>IWMPMediaCollection</b> interface provides methods that can be used to organize a large collection of media
///items.
@GUID("8363BC22-B4B4-4B19-989D-1CD765749DD1")
interface IWMPMediaCollection : IDispatch
{
    ///The <b>add</b> method adds a new media item or playlist to the library.
    ///Params:
    ///    bstrURL = String containing the URL that specifies the location of the media item or playlist.
    ///    ppItem = Pointer to a pointer to the <b>IWMPMedia</b> interface for the added item or playlist.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT add(BSTR bstrURL, IWMPMedia* ppItem);
    ///The <b>getAll</b> method retrieves a pointer to an <b>IWMPPlaylist</b> interface. This interface corresponds to
    ///the playlist that contains all media items in the library.
    ///Params:
    ///    ppMediaItems = Pointer to a pointer to an <b>IWMPPlaylist</b> interface for the playlist that contains all of the requested
    ///                   media items.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getAll(IWMPPlaylist* ppMediaItems);
    ///The <b>getByName</b> method retrieves a pointer to an <b>IWMPPlaylist</b> interface. This interface contains the
    ///media items with the specified name.
    ///Params:
    ///    bstrName = String containing the specified name.
    ///    ppMediaItems = Pointer to a pointer to an <b>IWMPPlaylist</b> interface for the retrieved media items.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getByName(BSTR bstrName, IWMPPlaylist* ppMediaItems);
    ///The <b>getByGenre</b> method retrieves a pointer to an <b>IWMPPlaylist</b> interface. This interface contains the
    ///media items with the specified genre.
    ///Params:
    ///    bstrGenre = String containing the genre.
    ///    ppMediaItems = Pointer to a pointer to an <b>IWMPPlaylist</b> interface for the retrieved media items.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getByGenre(BSTR bstrGenre, IWMPPlaylist* ppMediaItems);
    ///The <b>getByAuthor</b> method retrieves a pointer to an <b>IWMPPlaylist</b> interface. This interface contains
    ///the media items for the specified author.
    ///Params:
    ///    bstrAuthor = String containing the specified author.
    ///    ppMediaItems = Pointer to a pointer to an <b>IWMPPlaylist</b> interface for the retrieved media items.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getByAuthor(BSTR bstrAuthor, IWMPPlaylist* ppMediaItems);
    ///The <b>getByAlbum</b> method retrieves a pointer to an <b>IWMPPlaylist</b> interface. This interface contains the
    ///media items from the specified album.
    ///Params:
    ///    bstrAlbum = String containing the album.
    ///    ppMediaItems = Pointer to a pointer to an <b>IWMPPlaylist</b> interface for the retrieved media items.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getByAlbum(BSTR bstrAlbum, IWMPPlaylist* ppMediaItems);
    ///The <b>getByAttribute</b> method retrieves a pointer to an <b>IWMPPlaylist</b> interface. This interface
    ///corresponds to the specified attribute having the specified value.
    ///Params:
    ///    bstrAttribute = String containing the specified attribute.
    ///    bstrValue = String containing the specified value.
    ///    ppMediaItems = Pointer to a pointer to an <b>IWMPPlaylist</b> interface for the retrieved media items.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getByAttribute(BSTR bstrAttribute, BSTR bstrValue, IWMPPlaylist* ppMediaItems);
    ///The <b>remove</b> method removes a specified item from the media collection.
    ///Params:
    ///    pItem = Pointer to an <b>IWMPMedia</b> interface that identifies the item to remove.
    ///    varfDeleteFile = Specifies whether the method should remove the specified item.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT remove(IWMPMedia pItem, short varfDeleteFile);
    ///The <b>getAttributeStringCollection</b> method retrieves a pointer to an <b>IWMPStringCollection</b> interface.
    ///This interface represents the set of all values for a given attribute within a given media type.
    ///Params:
    ///    bstrAttribute = String containing the attribute for which the values are retrieved.
    ///    bstrMediaType = String containing the media type for which the values are retrieved.
    ///    ppStringCollection = Pointer to a pointer to an <b>IWMPStringCollection</b> interface for the retrieved values.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getAttributeStringCollection(BSTR bstrAttribute, BSTR bstrMediaType, 
                                         IWMPStringCollection* ppStringCollection);
    ///The <b>getMediaAtom</b> method retrieves the index at which a given attribute resides within the set of available
    ///attributes.
    ///Params:
    ///    bstrItemName = String containing the name of the item for which the index should be retrieved.
    ///    plAtom = Pointer to a <b>long</b> containing the index.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getMediaAtom(BSTR bstrItemName, int* plAtom);
    ///The <b>setDeleted</b> method moves the specified media item to the deleted items folder.
    ///Params:
    ///    pItem = Pointer to an <b>IWMPMedia</b> interface for the item to be moved.
    ///    varfIsDeleted = Specifies whether the item should be moved. This value must always be true.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT setDeleted(IWMPMedia pItem, short varfIsDeleted);
    HRESULT isDeleted(IWMPMedia pItem, short* pvarfIsDeleted);
}

///The <b>IWMPPlaylistArray</b> interface provides methods for accessing a collection of <b>IWMPPlaylist</b> interface
///pointers by index number.
@GUID("679409C0-99F7-11D3-9FB7-00105AA620BB")
interface IWMPPlaylistArray : IDispatch
{
    ///The <b>get_count</b> method retrieves the number of playlists in the playlist array.
    ///Params:
    ///    plCount = Pointer to a <b>long</b> containing the count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_count(int* plCount);
    ///The <b>item</b> method retrieves a pointer to an <b>IWMPPlaylist</b> interface representing the playlist at the
    ///specified index.
    ///Params:
    ///    lIndex = <b>long</b> containing the index that identifies the playlist that the method should retrieve.
    ///    ppItem = Pointer to a pointer to an <b>IWMPPlaylist</b> interface for the retrieved playlist.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT item(int lIndex, IWMPPlaylist* ppItem);
}

///The <b>IWMPPlaylistCollection</b> interface provides methods for manipulating the <b>IWMPPlaylist</b> and
///<b>IWMPPlaylistArray</b> interfaces.
@GUID("10A13217-23A7-439B-B1C0-D847C79B7774")
interface IWMPPlaylistCollection : IDispatch
{
    ///The <b>newPlaylist</b> method creates a new, empty playlist in the library.
    ///Params:
    ///    bstrName = String containing the name of the new playlist.
    ///    ppItem = Pointer to a pointer to an <b>IWMPPlaylist</b> interface for the new playlist.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT newPlaylist(BSTR bstrName, IWMPPlaylist* ppItem);
    ///The <b>getAll</b> method retrieves a pointer to an <b>IWMPPlaylistArray</b> interface representing all of the
    ///playlists in the library.
    ///Params:
    ///    ppPlaylistArray = Pointer to a pointer to an <b>IWMPPlaylistArray</b> interface for the retrieved array of playlists.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getAll(IWMPPlaylistArray* ppPlaylistArray);
    ///The <b>getByName</b> method retrieves a pointer to an <b>IWMPPlaylistArray</b> interface on an object containing
    ///playlists with the specified name, if any exist.
    ///Params:
    ///    bstrName = String containing the name.
    ///    ppPlaylistArray = Pointer to a pointer to an <b>IWMPPlaylistArray</b> interface for the retrieved array of playlists.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getByName(BSTR bstrName, IWMPPlaylistArray* ppPlaylistArray);
    ///The <b>remove</b> method removes a playlist from the library.
    ///Params:
    ///    pItem = Pointer to an <b>IWMPPlaylist</b> interface for the playlist that this method will remove.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT remove(IWMPPlaylist pItem);
    HRESULT setDeleted(IWMPPlaylist pItem, short varfIsDeleted);
    ///The <b>isDeleted</b> method retrieves a value indicating whether the specified playlist is in the deleted items
    ///folder.
    ///Params:
    ///    pItem = Pointer to an <b>IWMPPlaylist</b> interface for the queried playlist.
    ///    pvarfIsDeleted = Pointer to a <b>VARIANT_BOOL</b> that specifies whether the given playlist was deleted.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT isDeleted(IWMPPlaylist pItem, short* pvarfIsDeleted);
    ///The <b>importPlaylist</b> method adds a static playlist to the library.
    ///Params:
    ///    pItem = Pointer to an <b>IWMPPlaylist</b> interface for the playlist that this method will add.
    ///    ppImportedItem = Pointer to a pointer to an <b>IWMPPlaylist</b> interface for the added playlist.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT importPlaylist(IWMPPlaylist pItem, IWMPPlaylist* ppImportedItem);
}

///The <b>IWMPNetwork</b> interface provides methods relating to the network connection used by Windows Media Player.
@GUID("EC21B779-EDEF-462D-BBA4-AD9DDE2B29A7")
interface IWMPNetwork : IDispatch
{
    ///The <b>get_bandWidth</b> method retrieves the current bandwidth of the media item.
    ///Params:
    ///    plBandwidth = Pointer to a <b>long</b> containing the bandwidth.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_bandWidth(int* plBandwidth);
    ///The <b>get_recoveredPackets</b> method retrieves the number of recovered packets.
    ///Params:
    ///    plRecoveredPackets = Pointer to a <b>long</b> containing the recovered packets.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_recoveredPackets(int* plRecoveredPackets);
    ///The <b>get_sourceProtocol</b> method retrieves the source protocol used to receive data.
    ///Params:
    ///    pbstrSourceProtocol = Pointer to a <b>BSTR</b> containing the source protocol.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_sourceProtocol(BSTR* pbstrSourceProtocol);
    ///The <b>get_receivedPackets</b> method retrieves the number of packets received.
    ///Params:
    ///    plReceivedPackets = Pointer to a <b>long</b> containing the received packets.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_receivedPackets(int* plReceivedPackets);
    ///The <b>get_lostPackets</b> method retrieves the number of packets lost.
    ///Params:
    ///    plLostPackets = Pointer to a <b>long</b> containing the lost packets.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_lostPackets(int* plLostPackets);
    ///The <b>get_receptionQuality</b> method retrieves the percentage of packets received in the last 30 seconds.
    ///Params:
    ///    plReceptionQuality = Pointer to a <b>long</b> containing the reception quality.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_receptionQuality(int* plReceptionQuality);
    ///The <b>get_bufferingCount</b> method retrieves the number of times buffering occurred during playback.
    ///Params:
    ///    plBufferingCount = Pointer to a <b>long</b> containing the buffering count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_bufferingCount(int* plBufferingCount);
    ///The <b>get_bufferingProgress</b> method retrieves the percentage of buffering completed.
    ///Params:
    ///    plBufferingProgress = Pointer to a <b>long</b> containing the buffering progress.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_bufferingProgress(int* plBufferingProgress);
    ///The <b>get_bufferingTime</b> method retrieves the amount of time in milliseconds allocated for buffering incoming
    ///data before playing begins.
    ///Params:
    ///    plBufferingTime = Pointer to a <b>long</b> containing the buffering time, which ranges from zero to 60,000 with a default value
    ///                      of 5,000.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_bufferingTime(int* plBufferingTime);
    ///The <b>put_bufferingTime</b> method specifies the amount of time in milliseconds allocated for buffering incoming
    ///data before playing begins.
    ///Params:
    ///    lBufferingTime = <b>long</b> containing the buffering time, which ranges from zero to 60,000 with a default value of 5,000.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_bufferingTime(int lBufferingTime);
    ///The <b>get_frameRate</b> method retrieves the current video frame rate.
    ///Params:
    ///    plFrameRate = Pointer to a <b>long</b> containing the frame rate.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_frameRate(int* plFrameRate);
    ///The <b>get_maxBitRate</b> method retrieves the maximum possible video bit rate.
    ///Params:
    ///    plBitRate = Pointer to a <b>long</b> containing the bit rate.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_maxBitRate(int* plBitRate);
    ///The <b>get_bitRate</b> method retrieves the current bit rate being received.
    ///Params:
    ///    plBitRate = Pointer to a <b>long</b> containing the bit rate.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_bitRate(int* plBitRate);
    ///The <b>getProxySettings</b> method retrieves the proxy setting for a given protocol.
    ///Params:
    ///    bstrProtocol = <b>BSTR</b> containing the protocol name. For a list of supported protocols, see Supported Protocols and File
    ///                   Types.
    ///    plProxySetting = Pointer to a <b>long</b> containing one of the following values. <table> <tr> <th>Value </th> <th>Description
    ///                     </th> </tr> <tr> <td>0</td> <td>A proxy server is not being used.</td> </tr> <tr> <td>1</td> <td>The proxy
    ///                     settings for the current browser are being used (only valid for HTTP).</td> </tr> <tr> <td>2</td> <td>The
    ///                     manually specified proxy settings are being used.</td> </tr> <tr> <td>3</td> <td>The proxy settings are being
    ///                     auto-detected.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getProxySettings(BSTR bstrProtocol, int* plProxySetting);
    ///The <b>setProxySettings</b> method specifies the proxy setting for a given protocol.
    ///Params:
    ///    bstrProtocol = <b>BSTR</b> containing the protocol name. For a list of supported protocols, see Supported Protocols and File
    ///                   Types.
    ///    lProxySetting = <b>long</b> containing one of the following values. <table> <tr> <th>Value </th> <th>Description </th> </tr>
    ///                    <tr> <td>0</td> <td>Do not use a proxy server.</td> </tr> <tr> <td>1</td> <td>Use the proxy settings of the
    ///                    current browser (only valid for HTTP).</td> </tr> <tr> <td>2</td> <td>Use the manually specified proxy
    ///                    settings.</td> </tr> <tr> <td>3</td> <td>Auto-detect the proxy settings.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT setProxySettings(BSTR bstrProtocol, int lProxySetting);
    ///The <b>getProxyName</b> method retrieves the name of the proxy server being used.
    ///Params:
    ///    bstrProtocol = <b>BSTR</b> containing the protocol name. For a list of supported protocols, see Supported Protocols and File
    ///                   Types.
    ///    pbstrProxyName = Pointer to a <b>BSTR</b> containing the name of the proxy server being used. The value retrieved is
    ///                     meaningful only when <b>IWMPNetwork::getProxySettings</b> retrieves a value of 2 (use manual settings).
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getProxyName(BSTR bstrProtocol, BSTR* pbstrProxyName);
    ///The <b>setProxyName</b> method specifies the name of the proxy server to use.
    ///Params:
    ///    bstrProtocol = <b>BSTR</b> containing the protocol name. For a list of supported protocols, see Supported Protocols and File
    ///                   Types.
    ///    bstrProxyName = <b>BSTR</b> containing the name of the proxy server to use.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT setProxyName(BSTR bstrProtocol, BSTR bstrProxyName);
    ///The <b>getProxyPort</b> method retrieves the proxy port being used.
    ///Params:
    ///    bstrProtocol = <b>BSTR</b> containing the protocol name. For a list of supported protocols, see Supported Protocols and File
    ///                   Types.
    ///    lProxyPort = <b>long</b> containing the proxy port being used. The value retrieved is meaningful only when
    ///                 <b>IWMPNetwork::getProxySettings</b> retrieves a value of 2 (use manual settings).
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getProxyPort(BSTR bstrProtocol, int* lProxyPort);
    ///The <b>setProxyPort</b> method specifies the proxy port to use.
    ///Params:
    ///    bstrProtocol = <b>BSTR</b> containing the protocol name. For a list of supported protocols, see Supported Protocols and File
    ///                   Types..
    ///    lProxyPort = <b>long</b> containing the proxy port to use.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT setProxyPort(BSTR bstrProtocol, int lProxyPort);
    ///The <b>getProxyExceptionList</b> method retrieves the proxy exception list.
    ///Params:
    ///    bstrProtocol = <b>BSTR</b> containing the protocol name. For a list of supported protocols, see Supported Protocols and File
    ///                   Types.
    ///    pbstrExceptionList = Pointer to a <b>BSTR</b> containing a semicolon-delimited list of hosts for which the proxy server is
    ///                         bypassed. The value retrieved is meaningful only when <b>IWMPNetwork::getProxySettings</b> retrieves a value
    ///                         of 2 (use manual settings).
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getProxyExceptionList(BSTR bstrProtocol, BSTR* pbstrExceptionList);
    ///The <b>setProxyExceptionList</b> method specifies the proxy exception list.
    ///Params:
    ///    bstrProtocol = <b>BSTR</b> containing the protocol name. For a list of supported protocols, see Supported Protocols and File
    ///                   Types.
    ///    pbstrExceptionList = <b>BSTR</b> containing a semicolon-delimited list of hosts for which the proxy server is bypassed. Leading
    ///                         and trailing spaces should not be present.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT setProxyExceptionList(BSTR bstrProtocol, BSTR pbstrExceptionList);
    ///The <b>getProxyBypassForLocal</b> method retrieves a value indicating whether the proxy server is bypassed if the
    ///origin server is on a local network.
    ///Params:
    ///    bstrProtocol = <b>BSTR</b> containing the protocol.
    ///    pfBypassForLocal = Pointer to a <b>VARIANT_BOOL</b> that indicates whether the proxy server is bypassed. The value retrieved is
    ///                       meaningful only when <b>IWMPNetwork::getProxySettings</b> retrieves a value of 2 (use manual settings).
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getProxyBypassForLocal(BSTR bstrProtocol, short* pfBypassForLocal);
    ///The <b>setProxyBypassForLocal</b> method specifies a value indicating whether the proxy server is bypassed if the
    ///origin server is on a local network.
    ///Params:
    ///    bstrProtocol = <b>BSTR</b> containing the protocol name. For a list of supported protocols, see Supported Protocols and File
    ///                   Types.
    ///    fBypassForLocal = <b>VARIANT_BOOL</b> indicating whether the proxy server is bypassed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT setProxyBypassForLocal(BSTR bstrProtocol, short fBypassForLocal);
    ///The <b>get_maxBandwidth</b> method retrieves the maximum allowed bandwidth.
    ///Params:
    ///    lMaxBandwidth = Pointer to a <b>long</b> containing the maximum bandwidth.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_maxBandwidth(int* lMaxBandwidth);
    ///The <b>put_maxBandwidth</b> method specifies the maximum allowed bandwidth.
    ///Params:
    ///    lMaxBandwidth = <b>long</b> containing the max bandwidth.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_maxBandwidth(int lMaxBandwidth);
    ///The <b>get_downloadProgress</b> method retrieves the percentage of the download completed.
    ///Params:
    ///    plDownloadProgress = Pointer to a <b>long</b> containing the download progress.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_downloadProgress(int* plDownloadProgress);
    ///The <b>get_encodedFrameRate</b> method retrieves the video frame rate specified by the content author.
    ///Params:
    ///    plFrameRate = Pointer to a <b>long</b> containing the frame rate in frames per second (fps).
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_encodedFrameRate(int* plFrameRate);
    ///The <b>get_framesSkipped</b> method retrieves the total number of frames skipped during playback.
    ///Params:
    ///    plFrames = Pointer to a <b>long</b> containing the number of frames.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_framesSkipped(int* plFrames);
}

///The <b>IWMPCore</b> interface is the root interface for the Windows Media Player control. It can be used to retrieve
///pointers to other interfaces supported by the control and to access some basic features.
@GUID("D84CCA99-CCE2-11D2-9ECC-0000F8085981")
interface IWMPCore : IDispatch
{
    ///The <b>close</b> method releases Windows Media Player resources.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT close();
    ///The <b>get_URL</b> method retrieves the name of the clip to play.
    ///Params:
    ///    pbstrURL = Pointer to a <b>BSTR</b> containing the URL.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_URL(BSTR* pbstrURL);
    ///The <b>put_URL</b> method specifies the URL of the media item to play.
    ///Params:
    ///    bstrURL = <b>BSTR</b> containing the URL.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_URL(BSTR bstrURL);
    ///The <b>get_openState</b> method retrieves an enumeration value indicating the state of the content source.
    ///Params:
    ///    pwmpos = Pointer to a <b>WMPOpenState</b> enumeration.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_openState(WMPOpenState* pwmpos);
    ///The <b>get_playState</b> method retrieves an enumeration value indicating the operating state of Windows Media
    ///Player.
    ///Params:
    ///    pwmpps = Pointer to a <b>WMPPlayState</b> enumeration.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_playState(WMPPlayState* pwmpps);
    ///The <b>get_controls</b> method retrieves a pointer to an <b>IWMPControls</b> interface.
    ///Params:
    ///    ppControl = Pointer to a pointer to an <b>IWMPControls</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_controls(IWMPControls* ppControl);
    ///The <b>get_settings</b> method retrieves a pointer to an <b>IWMPSettings</b> interface.
    ///Params:
    ///    ppSettings = Pointer to a pointer to an <b>IWMPSettings</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_settings(IWMPSettings* ppSettings);
    ///The <b>get_currentMedia</b> method retrieves a pointer to an <b>IWMPMedia</b> interface corresponding to the
    ///current media item.
    ///Params:
    ///    ppMedia = Pointer to a pointer to an <b>IWMPMedia</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_currentMedia(IWMPMedia* ppMedia);
    ///The <b>put_currentMedia</b> method specifies the <b>IWMPMedia</b> interface that corresponds to the current media
    ///item.
    ///Params:
    ///    pMedia = Pointer to an <b>IWMPMedia</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_currentMedia(IWMPMedia pMedia);
    ///The <b>get_mediaCollection</b> method retrieves a pointer to an <b>IWMPMediaCollection</b> interface.
    ///Params:
    ///    ppMediaCollection = Pointer to a pointer to an <b>IWMPMediaCollection</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_mediaCollection(IWMPMediaCollection* ppMediaCollection);
    ///The <b>get_playlistCollection</b> method retrieves a pointer to an <b>IWMPPlaylistCollection</b> interface.
    ///Params:
    ///    ppPlaylistCollection = Pointer to a pointer to an <b>IWMPPlaylistCollection</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_playlistCollection(IWMPPlaylistCollection* ppPlaylistCollection);
    ///The <b>get_versionInfo</b> method retrieves a <b>String</b> value specifying the version of Windows Media Player.
    ///Params:
    ///    pbstrVersionInfo = Pointer to a <b>BSTR</b> containing the version info.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_versionInfo(BSTR* pbstrVersionInfo);
    ///The <b>launchURL</b> method sends a URL to the user's default browser.
    ///Params:
    ///    bstrURL = <b>BSTR</b> containing the URL.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT launchURL(BSTR bstrURL);
    ///The <b>get_network</b> method retrieves a pointer to an <b>IWMPNetwork</b> interface.
    ///Params:
    ///    ppQNI = Pointer to a pointer to an <b>IWMPNetwork</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_network(IWMPNetwork* ppQNI);
    ///The <b>get_currentPlaylist</b> method retrieves a pointer to an <b>IWMPPlaylist</b> interface corresponding to
    ///the current playlist.
    ///Params:
    ///    ppPL = Pointer to a pointer to an <b>IWMPPlaylist</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_currentPlaylist(IWMPPlaylist* ppPL);
    ///The <b>put_currentPlaylist</b> method specifies the <b>IWMPPlaylist</b> interface that corresponds to the current
    ///playlist.
    ///Params:
    ///    pPL = Pointer to an <b>IWMPPlaylist</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_currentPlaylist(IWMPPlaylist pPL);
    ///The <b>get_cdromCollection</b> method retrieves a pointer to an <b>IWMPCdromCollection</b> interface.
    ///Params:
    ///    ppCdromCollection = Pointer to a pointer to an <b>IWMPCdromCollection</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_cdromCollection(IWMPCdromCollection* ppCdromCollection);
    ///The <b>get_closedCaption</b> method retrieves a pointer to an <b>IWMPClosedCaption</b> interface.
    ///Params:
    ///    ppClosedCaption = Pointer to a pointer to an <b>IWMPClosedCaption</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_closedCaption(IWMPClosedCaption* ppClosedCaption);
    ///The <b>get_isOnline</b> method retrieves a value indicating whether the user is connected to a network.
    ///Params:
    ///    pfOnline = Pointer to a <b>VARIANT_BOOL</b>, <b>true</b> indicating online.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_isOnline(short* pfOnline);
    ///The <b>get_error</b> method retrieves a pointer to an <b>IWMPError</b> interface.
    ///Params:
    ///    ppError = Pointer to a pointer to an <b>IWMPError</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_error(IWMPError* ppError);
    ///The <b>get_status</b> method retrieves the status of Windows Media Player.
    ///Params:
    ///    pbstrStatus = Pointer to a <b>BSTR</b> containing the status.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_status(BSTR* pbstrStatus);
}

///The <b>IWMPPlayer</b> interface provides methods for modifying the basic behavior of the Windows Media Player control
///user interface. These methods supplement the <b>IWMPCore</b> interface.
@GUID("6BF52A4F-394A-11D3-B153-00C04F79FAA6")
interface IWMPPlayer : IWMPCore
{
    ///The <b>get_enabled</b> method retrieves a value indicating whether the Windows Media Player control is enabled.
    ///Params:
    ///    pbEnabled = Pointer to a <b>VARIANT_BOOL</b> indicating whether the Windows Media Player control is enabled.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_enabled(short* pbEnabled);
    ///The <b>put_enabled</b> method specifies a value indicating whether the Windows Media Player control is enabled.
    ///Params:
    ///    bEnabled = <b>VARIANT_BOOL</b> indicating whether the Windows Media Player control is enabled.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_enabled(short bEnabled);
    ///The <b>get_fullScreen</b> method retrieves a value indicating whether video content is played back in full-screen
    ///mode.
    ///Params:
    ///    pbFullScreen = Pointer to a <b>VARIANT_BOOL</b> indicating whether video content is played back in full-screen mode. The
    ///                   default is <b>FALSE</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_fullScreen(short* pbFullScreen);
    ///The <b>put_fullScreen</b> method specifies a value indicating whether video content is played back in full-screen
    ///mode.
    ///Params:
    ///    bFullScreen = <b>VARIANT_BOOL</b> indicating whether video content is played back in full-screen mode. The default is
    ///                  <b>FALSE</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_fullScreen(short bFullScreen);
    ///The <b>get_enableContextMenu</b> method retrieves a value indicating whether to enable the context menu, which
    ///appears when the right mouse button is clicked.
    ///Params:
    ///    pbEnableContextMenu = Pointer to a <b>VARIANT_BOOL</b> that indicates whether to the enable context menu. The default is
    ///                          <b>TRUE</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_enableContextMenu(short* pbEnableContextMenu);
    ///The <b>put_enableContextMenu</b> method specifies a value indicating whether to enable the context menu, which
    ///appears when the right mouse button is clicked.
    ///Params:
    ///    bEnableContextMenu = <b>VARIANT_BOOL</b> that indicates whether to the enable context menu. The default is <b>TRUE</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_enableContextMenu(short bEnableContextMenu);
    ///The <b>put_uiMode</b> method specifies a value indicating which controls are shown in the user interface.
    ///Params:
    ///    bstrMode = <b>BSTR</b> containing one of the following values. <table> <tr> <th>Value </th> <th>Description </th>
    ///               <th>Audio example </th> <th>Video example </th> </tr> <tr> <td>invisible</td> <td>Windows Media Player is
    ///               embedded without any visible user interface (controls, video, or visualization window).</td> <td>(Nothing is
    ///               displayed.)</td> <td>(Nothing is displayed.)</td> </tr> <tr> <td>none</td> <td>Windows Media Player is
    ///               embedded without controls, and with only the video or visualization window displayed.</td> <td><img
    ///               alt='uiMode="none" with audio' border="0" src="./images/uimode_none_audio_v11.png"/></td> <td><img
    ///               alt='uiMode="none" with video' border="0" src="./images/uimode_none_video_v11.png"/></td> </tr> <tr>
    ///               <td>mini</td> <td>Windows Media Player is embedded with the status window, play/pause, stop, mute, and volume
    ///               controls shown in addition to the video or visualization window.</td> <td><img alt='uiMode="mini" with audio'
    ///               border="0" src="./images/uimode_mini_audio_v11.png"/></td> <td><img alt='uiMode="mini" with video' border="0"
    ///               src="./images/uimode_mini_video_v11.png"/></td> </tr> <tr> <td>full</td> <td>Default. Windows Media Player is
    ///               embedded with the status window, seek bar, play/pause, stop, mute, next, previous, fast forward, fast
    ///               reverse, and volume controls in addition to the video or visualization window.</td> <td><img
    ///               alt='uiMode="full" with audio' border="0" src="./images/uimode_full_audio_v11.png"/></td> <td><img
    ///               alt='uiMode="full" with video' border="0" src="./images/uimode_full_video_v11.png"/></td> </tr> <tr>
    ///               <td>custom</td> <td>Windows Media Player is embedded with a custom user interface. Can only be used in C++
    ///               programs.</td> <td>(Custom user interface is displayed.)</td> <td>(Custom user interface is displayed.)</td>
    ///               </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_uiMode(BSTR bstrMode);
    ///The <b>get_uiMode</b> method retrieves a value indicating which controls are shown in the user interface.
    ///Params:
    ///    pbstrMode = Pointer to a <b>BSTR</b> containing one of the following values. <table> <tr> <th>Value </th> <th>Description
    ///                </th> <th>Audio example </th> <th>Video example </th> </tr> <tr> <td>invisible</td> <td>Windows Media Player
    ///                is embedded without any visible user interface (controls, video, or visualization window).</td> <td>(Nothing
    ///                is displayed.)</td> <td>(Nothing is displayed.)</td> </tr> <tr> <td>none</td> <td>Windows Media Player is
    ///                embedded without controls, and with only the video or visualization window displayed.</td> <td><img
    ///                alt='uiMode="none" with audio' border="0" src="./images/uimode_none_audio_v11.png"/></td> <td><img
    ///                alt='uiMode="none" with video' border="0" src="./images/uimode_none_video_v11.png"/></td> </tr> <tr>
    ///                <td>mini</td> <td>Windows Media Player is embedded with the status window, play/pause, stop, mute, and volume
    ///                controls shown in addition to the video or visualization window.</td> <td><img alt='uiMode="mini" with audio'
    ///                border="0" src="./images/uimode_mini_audio_v11.png"/></td> <td><img alt='uiMode="mini" with video' border="0"
    ///                src="./images/uimode_mini_video_v11.png"/></td> </tr> <tr> <td>full</td> <td>Default. Windows Media Player is
    ///                embedded with the status window, seek bar, play/pause, stop, mute, next, previous, fast forward, fast
    ///                reverse, and volume controls in addition to the video or visualization window.</td> <td><img
    ///                alt='uiMode="full" with audio' border="0" src="./images/uimode_full_audio_v11.png"/></td> <td><img
    ///                alt='uiMode="full" with video' border="0" src="./images/uimode_full_video_v11.png"/></td> </tr> <tr>
    ///                <td>custom</td> <td>Windows Media Player is embedded with a custom user interface. Can only be used in C++
    ///                programs.</td> <td>(Custom user interface is displayed.)</td> <td>(Custom user interface is displayed.)</td>
    ///                </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_uiMode(BSTR* pbstrMode);
}

///The <b>IWMPPlayer2</b> interface provides additional methods for modifying the basic behavior of the Windows Media
///Player control user interface. These methods also supplement the <b>IWMPCore</b> interface. The <b>IWMPPlayer2</b>
///interface duplicates the methods of <b>IWMPPlayer</b>, inherits the methods of <b>IWMPCore</b>, and exposes the
///following additional methods.
@GUID("0E6B01D1-D407-4C85-BF5F-1C01F6150280")
interface IWMPPlayer2 : IWMPCore
{
    HRESULT get_enabled(short* pbEnabled);
    HRESULT put_enabled(short bEnabled);
    HRESULT get_fullScreen(short* pbFullScreen);
    HRESULT put_fullScreen(short bFullScreen);
    HRESULT get_enableContextMenu(short* pbEnableContextMenu);
    HRESULT put_enableContextMenu(short bEnableContextMenu);
    HRESULT put_uiMode(BSTR bstrMode);
    HRESULT get_uiMode(BSTR* pbstrMode);
    ///The <b>get_stretchToFit</b> method retrieves a value indicating whether video displayed by the Windows Media
    ///Player control automatically sizes to fit the video window when the video window is larger than the dimensions of
    ///the video image.
    ///Params:
    ///    pbEnabled = Pointer to a <b>VARIANT_BOOL</b> indicating whether video displayed by the Windows Media Player control
    ///                automatically resizes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_stretchToFit(short* pbEnabled);
    ///The <b>put_stretchToFit</b> method specifies a value indicating whether video displayed by the Windows Media
    ///Player control automatically sizes to fit the video window when the video window is larger than the dimensions of
    ///the video image.
    ///Params:
    ///    bEnabled = <b>VARIANT_BOOL</b> indicating whether video displayed by the Windows Media Player control automatically
    ///               resizes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_stretchToFit(short bEnabled);
    ///The <b>get_windowlessVideo</b> method retrieves a value indicating whether the Windows Media Player control
    ///renders video in windowless mode.
    ///Params:
    ///    pbEnabled = Pointer to a <b>VARIANT_BOOL</b> indicating whether the Windows Media Player control renders video in
    ///                windowless mode.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_windowlessVideo(short* pbEnabled);
    ///The <b>put_windowlessVideo</b> method specifies a value indicating whether the Windows Media Player control
    ///renders video in windowless mode.
    ///Params:
    ///    bEnabled = <b>VARIANT_BOOL</b> indicating whether the Windows Media Player control renders video in windowless mode.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_windowlessVideo(short bEnabled);
}

///The <b>IWMPMedia2</b> interface provides a method that supplements the <b>IWMPMedia</b> interface.
@GUID("AB7C88BB-143E-4EA4-ACC3-E4350B2106C3")
interface IWMPMedia2 : IWMPMedia
{
    ///The <b>get_error</b> method retrieves a pointer to an <b>IWMPErrorItem</b> interface if the media item has an
    ///error condition.
    ///Params:
    ///    ppIWMPErrorItem = Pointer to a pointer to an <b>IWMPErrorItem</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_error(IWMPErrorItem* ppIWMPErrorItem);
}

///The <b>IWMPControls2</b> interface provides a method that supplements the <b>IWMPControls</b> interface.
@GUID("6F030D25-0890-480F-9775-1F7E40AB5B8E")
interface IWMPControls2 : IWMPControls
{
    ///The <b>step</b> method causes the current video media item to freeze playback on the next frame or the previous
    ///frame.
    ///Params:
    ///    lStep = <b>long</b> indicating how many frames to step before freezing. Must be set to 1 or -1.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT step(int lStep);
}

///The <b>IWMPDVD</b> interface provides methods for working with DVDs.
@GUID("8DA61686-4668-4A5C-AE5D-803193293DBE")
interface IWMPDVD : IDispatch
{
    ///The <b>get_isAvailable</b> method indicates whether a specified type of information is available or a specified
    ///action can be performed.
    ///Params:
    ///    bstrItem = <b>BSTR</b> containing one of the following values. <table> <tr> <th>Value </th> <th>Description </th> </tr>
    ///               <tr> <td>back</td> <td>Determines whether the <b>IWMPDVD::back</b> method is available.</td> </tr> <tr>
    ///               <td>dvd</td> <td>Determines whether the DVD is loaded.</td> </tr> <tr> <td>dvdDecoder</td> <td>Determines
    ///               whether the DVD decoder is installed on system.</td> </tr> <tr> <td>resume</td> <td>Determines whether the
    ///               <b>IWMPDVD::resume</b> method is available.</td> </tr> <tr> <td>titleMenu</td> <td>Determines whether the
    ///               <b>IWMPDVD::titleMenu</b> method is available.</td> </tr> <tr> <td>topMenu</td> <td>Determines whether the
    ///               <b>IWMPDVD::topMenu</b> method is available. Commonly called the root menu.</td> </tr> </table>
    ///    pIsAvailable = Pointer to a <b>VARIANT_BOOL</b> that indicates whether the specified parameter is available.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_isAvailable(BSTR bstrItem, short* pIsAvailable);
    ///The <b>get_domain</b> method retrieves the current domain of the DVD.
    ///Params:
    ///    strDomain = Pointer to a <b>BSTR</b> that contains one of the following values. <table> <tr> <th>Value </th>
    ///                <th>Description </th> </tr> <tr> <td>firstPlay</td> <td>Performing default initialization of a DVD disc.</td>
    ///                </tr> <tr> <td>videoManagerMenu</td> <td>Displaying menus for the entire disc. Also known as topMenu for
    ///                Windows Media Player. Commonly called the title menu or the top menu.</td> </tr> <tr>
    ///                <td>videoTitleSetMenu</td> <td>Displaying menus for current title set. Also known as titleMenu for Windows
    ///                Media Player. Commonly called the root menu.</td> </tr> <tr> <td>title</td> <td>Usually displaying the
    ///                current title.</td> </tr> <tr> <td>stop</td> <td>The DVD Navigator is in the DVD Stop domain.</td> </tr> <tr>
    ///                <td>undefined</td> <td>Windows Media Player is not in any DVD domain.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_domain(BSTR* strDomain);
    ///The <b>topMenu</b> method stops playback and displays the top (or root) menu for the current title.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT topMenu();
    ///The <b>titleMenu</b> method stops playback and displays the title menu.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT titleMenu();
    ///The <b>back</b> method returns the display from a submenu to its parent menu.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT back();
    ///The <b>resume</b> method returns to playback mode from menu mode at the same title position as when the menu was
    ///invoked.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT resume();
}

///The <b>IWMPCore2</b> interface provides a method that supplements the <b>IWMPCore</b> interface.
@GUID("BC17E5B7-7561-4C18-BB90-17D485775659")
interface IWMPCore2 : IWMPCore
{
    ///The <b>get_dvd</b> method retrieves a pointer to an <b>IWMPDVD</b> interface.
    ///Params:
    ///    ppDVD = Pointer to a pointer to an <b>IWMPDVD</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_dvd(IWMPDVD* ppDVD);
}

///The <b>IWMPPlayer3</b> interface provides methods for modifying the basic behavior of the control user interface.
///These methods supplement the <b>IWMPCore2</b> interface. The <b>IWMPPlayer3</b> interface duplicates the methods of
///<b>IWMPPlayer</b> and <b>IWMPPlayer2</b> and inherits the methods of <b>IWMPCore2</b>. It is identical to
///<b>IWMPPlayer2</b> except for the inherited interface. Retrieve a pointer to an <b>IWMPPlayer3</b> interface either
///by calling the <b>QueryInterface</b> method of the <b>IWMPPlayer</b> or <b>IWMPPlayer2</b> interface, or by calling
///the COM <b>CoCreateInstance</b> method.
@GUID("54062B68-052A-4C25-A39F-8B63346511D4")
interface IWMPPlayer3 : IWMPCore2
{
    HRESULT get_enabled(short* pbEnabled);
    HRESULT put_enabled(short bEnabled);
    HRESULT get_fullScreen(short* pbFullScreen);
    HRESULT put_fullScreen(short bFullScreen);
    HRESULT get_enableContextMenu(short* pbEnableContextMenu);
    HRESULT put_enableContextMenu(short bEnableContextMenu);
    HRESULT put_uiMode(BSTR bstrMode);
    HRESULT get_uiMode(BSTR* pbstrMode);
    HRESULT get_stretchToFit(short* pbEnabled);
    HRESULT put_stretchToFit(short bEnabled);
    HRESULT get_windowlessVideo(short* pbEnabled);
    HRESULT put_windowlessVideo(short bEnabled);
}

///The <b>IWMPErrorItem2</b> interface provides a method that supplements the <b>IWMPErrorItem</b> interface.
@GUID("F75CCEC0-C67C-475C-931E-8719870BEE7D")
interface IWMPErrorItem2 : IWMPErrorItem
{
    ///The <b>get_condition</b> method retrieves a value indicating the condition for the error.
    ///Params:
    ///    plCondition = Pointer to a <b>long</b> containing the condition code.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_condition(int* plCondition);
}

///The <b>IWMPRemoteMediaServices</b> interface includes methods that provide services to Windows Media Player from a
///program that hosts the Player control. These methods are designed to be used with C++, and some methods can only be
///used with remoting.
@GUID("CBB92747-741F-44FE-AB5B-F1A48F3B2A59")
interface IWMPRemoteMediaServices : IUnknown
{
    ///The <b>GetServiceType</b> method is called by Windows Media Player to determine whether a host program wants to
    ///run its embedded control remotely.
    ///Params:
    ///    pbstrType = Pointer to a <b></b>BSTR containing one or more of the following values. <table> <tr> <th>Value </th>
    ///                <th>Description </th> </tr> <tr> <td>Local</td> <td>The Windows Media Player control is embedded in local
    ///                mode.</td> </tr> <tr> <td>NoDeviceSupport</td> <td>The Windows Media Player control is embedded in remote
    ///                mode and provides no support for device synchronization interfaces. Attempting to use device synchronization
    ///                features in code when in this mode will result in the following error code: NS_E_PDA_DEVICESUPPORTDISABLED
    ///                (0xC00D1190L). Requires Windows Media Player 10.</td> </tr> <tr> <td>NoDialogs</td> <td>Windows Media Player
    ///                10: The Windows Media Player control is embedded in remote mode and does not display dialog boxes. See
    ///                Remarks.Windows Media Player 11: The Windows Media Player control is embedded in either local or remote mode
    ///                and does not display dialog boxes. </td> </tr> <tr> <td>Remote</td> <td>The Windows Media Player control is
    ///                embedded in remote mode.</td> </tr> <tr> <td>RemoteNoDialogs</td> <td>The Windows Media Player control is
    ///                embedded in remote mode and does not display dialog boxes. Use of this value requires Windows Media Player 9
    ///                Series update 819756 or later. See Remarks.</td> </tr> <tr> <td>ExclusiveService:<i>keyname</i></td> <td>The
    ///                Windows Media Player control is embedded in remote mode, and service selector for online stores is disabled.
    ///                The only online store available to the user is the one identified by <i>keyname</i>. If this value is
    ///                combined with other values from this table, it must be the last value in the combination. Requires Windows
    ///                Media Player 11.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr> <td>S_OK</td> <td>The method
    ///    succeeded.</td> </tr> </table>
    ///    
    HRESULT GetServiceType(BSTR* pbstrType);
    ///The <b>GetApplicationName</b> method is called by Windows Media Player to retrieve the name of the program that
    ///is hosting the remoted control.
    ///Params:
    ///    pbstrName = Pointer to a <b>BSTR</b> containing the name of the host program.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr> <td>S_OK</td> <td>The method
    ///    succeeded.</td> </tr> </table>
    ///    
    HRESULT GetApplicationName(BSTR* pbstrName);
    ///The <b>GetScriptableObject</b> method is called by Windows Media Player to retrieve a name and interface pointer
    ///for an object that can be called from the script code within a skin.
    ///Params:
    ///    pbstrName = Pointer to a <b>BSTR</b> containing the name of the scriptable object.
    ///    ppDispatch = Pointer to a pointer to the <b>IDispatch</b> interface of the scriptable object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr> <td>S_OK</td> <td>The method
    ///    succeeded.</td> </tr> </table>
    ///    
    HRESULT GetScriptableObject(BSTR* pbstrName, IDispatch* ppDispatch);
    ///The <b>GetCustomUIMode</b> method is called by Windows Media Player to retrieve the location of a skin file to
    ///apply to the Windows Media Player control.
    ///Params:
    ///    pbstrFile = Pointer to a <b>BSTR</b> containing the location of the skin file.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr> <td>S_OK</td> <td>The method
    ///    succeeded.</td> </tr> </table>
    ///    
    HRESULT GetCustomUIMode(BSTR* pbstrFile);
}

///The <b>IWMPSkinManager</b> interface provides a method used to synchronize the current skin with the current desktop
///theme in Microsoft Windows XP.
@GUID("076F2FA6-ED30-448B-8CC5-3F3EF3529C7A")
interface IWMPSkinManager : IUnknown
{
    ///The <b>SetVisualStyle</b> method specifies the path to a theme file in Windows XP to which Windows Media Player
    ///synchronizes the skin.
    ///Params:
    ///    bstrPath = <b>BSTR</b> containing the path to the theme file.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr> <td>S_OK</td> <td>The method
    ///    succeeded.</td> </tr> </table>
    ///    
    HRESULT SetVisualStyle(BSTR bstrPath);
}

///The <b>IWMPMetadataPicture</b> interface provides methods for retrieving information about the WM/Picture metadata
///attribute.
@GUID("5C29BBE0-F87D-4C45-AA28-A70F0230FFA9")
interface IWMPMetadataPicture : IDispatch
{
    ///The <b>get_mimeType</b> method retrieves a pointer to a string specifying the MIME type of the metadata image.
    ///Params:
    ///    pbstrMimeType = Pointer to a <b>BSTR</b> containing the mime type.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_mimeType(BSTR* pbstrMimeType);
    ///The <b>get_pictureType</b> method retrieves a pointer to a string specifying the picture type of the metadata
    ///image.
    ///Params:
    ///    pbstrPictureType = Pointer to a <b>BSTR</b> containing the picture type.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_pictureType(BSTR* pbstrPictureType);
    ///The <b>get_description</b> method retrieves a pointer to the description of the metadata image.
    ///Params:
    ///    pbstrDescription = Pointer to a <b>BSTR</b> containing the description.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_description(BSTR* pbstrDescription);
    ///This method is for internal use only.
    ///Params:
    ///    pbstrURL = 
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_URL(BSTR* pbstrURL);
}

///The <b>IWMPMetadataText</b> interface provides methods for retrieving information about complex textual metadata
///attributes.
@GUID("769A72DB-13D2-45E2-9C48-53CA9D5B7450")
interface IWMPMetadataText : IDispatch
{
    ///The <b>get_description</b> method retrieves a description of the metadata text.
    ///Params:
    ///    pbstrDescription = Pointer to a BSTR containing the description.
    ///Returns:
    ///    The method returns an HRESULT. Possible values include, but are not limited to, those in the following table.
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_description(BSTR* pbstrDescription);
    ///The <b>get_text</b> method retrieves the metadata text.
    ///Params:
    ///    pbstrText = Pointer to a <b>BSTR</b> containing the text.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_text(BSTR* pbstrText);
}

///The <b>IWMPMedia3</b> interface provides methods that supplement the <b>IWMPMedia2</b> interface.
@GUID("F118EFC7-F03A-4FB4-99C9-1C02A5C1065B")
interface IWMPMedia3 : IWMPMedia2
{
    ///The <b>getAttributeCountByType</b> method retrieves the number of attributes associated with the specified
    ///attribute type.
    ///Params:
    ///    bstrType = <b>BSTR</b> containing the type.
    ///    bstrLanguage = <b>BSTR</b> containing the language. If the value is set to null or "" (empty string), the current locale
    ///                   string is used. Otherwise, the value must be a valid RFC 1766 language string such as "en-us".
    ///    plCount = Pointer to a <b>long</b> containing the count of attributes that are associated with the type.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getAttributeCountByType(BSTR bstrType, BSTR bstrLanguage, int* plCount);
    ///The <b>getItemInfoByType</b> method retrieves the value of the attribute corresponding to the specified attribute
    ///type and index.
    ///Params:
    ///    bstrType = <b>BSTR</b> containing the type.
    ///    bstrLanguage = <b>BSTR</b> containing the language. If the value is set to null or "" (empty string), the current locale
    ///                   string is used. Otherwise, the value must be a valid RFC 1766 language string such as "en-us".
    ///    lIndex = <b>long</b> containing the index.
    ///    pvarValue = Pointer to a <b>VARIANT</b> that contains the returned value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getItemInfoByType(BSTR bstrType, BSTR bstrLanguage, int lIndex, VARIANT* pvarValue);
}

///The <b>IWMPSettings2</b> interface provides methods that supplement the <b>IWMPSettings</b> interface.
@GUID("FDA937A4-EECE-4DA5-A0B6-39BF89ADE2C2")
interface IWMPSettings2 : IWMPSettings
{
    ///The <b>get_defaultAudioLanguage</b> method retrieves the LCID of the default audio language specified in Windows
    ///Media Player.
    ///Params:
    ///    plLangID = Pointer to a <b>long</b> containing the LCID.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_defaultAudioLanguage(int* plLangID);
    ///The <b>get_mediaAccessRights</b> method retrieves a value indicating the permissions currently granted for
    ///library access.
    ///Params:
    ///    pbstrRights = Pointer to a <b>BSTR</b> containing one of the following values. <table> <tr> <th>Value </th> <th>Description
    ///                  </th> </tr> <tr> <td>none</td> <td>Current item access rights only.</td> </tr> <tr> <td>read</td> <td>Read
    ///                  access rights only.</td> </tr> <tr> <td>full</td> <td>Read/Write access rights.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_mediaAccessRights(BSTR* pbstrRights);
    ///The <b>requestMediaAccessRights</b> method requests a specified level of access to the library.
    ///Params:
    ///    bstrDesiredAccess = <b>BSTR</b> containing the one of the following values. <table> <tr> <th>Value </th> <th>Description </th>
    ///                        </tr> <tr> <td>none</td> <td>Current item access rights only.</td> </tr> <tr> <td>read</td> <td>Read access
    ///                        rights only.</td> </tr> <tr> <td>full</td> <td>Read/Write access rights.</td> </tr> </table>
    ///    pvbAccepted = Pointer to a <b>VARIANT_BOOL</b> indicating whether the requested access rights were granted.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT requestMediaAccessRights(BSTR bstrDesiredAccess, short* pvbAccepted);
}

///The <b>IWMPControls3</b> interface provides methods that supplement the <b>IWMPControls2</b> interface.
@GUID("A1D1110E-D545-476A-9A78-AC3E4CB1E6BD")
interface IWMPControls3 : IWMPControls2
{
    ///The <b>get_audioLanguageCount</b> method retrieves the count of supported audio languages.
    ///Params:
    ///    plCount = Pointer to a <b>long</b> containing the count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_audioLanguageCount(int* plCount);
    ///The <b>getAudioLanguageID</b> method retrieves the locale identifier (LCID) for a specified audio language index.
    ///Params:
    ///    lIndex = <b>long</b> specifying the one-based index of the audio language.
    ///    plLangID = Pointer to a <b>long</b> containing the LCID.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getAudioLanguageID(int lIndex, int* plLangID);
    ///The <b>getAudioLanguageDescription</b> method retrieves the description for the audio language corresponding to
    ///the specified one-based index.
    ///Params:
    ///    lIndex = <b>long</b> specifying the one-based audio language index.
    ///    pbstrLangDesc = Pointer to a <b>BSTR</b> containing the description.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getAudioLanguageDescription(int lIndex, BSTR* pbstrLangDesc);
    ///The <b>get_currentAudioLanguage</b> method retrieves the locale identifier (LCID) of the audio language for
    ///playback.
    ///Params:
    ///    plLangID = Pointer to a <b>long</b> containing the LCID.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_currentAudioLanguage(int* plLangID);
    ///The <b>put_currentAudioLanguage</b> method specifies the locale identifier (LCID) of the audio language for
    ///playback.
    ///Params:
    ///    lLangID = <b>long</b> containing the LCID.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_currentAudioLanguage(int lLangID);
    ///The <b>get_currentAudioLanguageIndex</b> method retrieves the one-based index that corresponds to the audio
    ///language for playback.
    ///Params:
    ///    plIndex = Pointer to a <b>long</b> containing the one-based index.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_currentAudioLanguageIndex(int* plIndex);
    ///The <b>put_currentAudioLanguageIndex</b> method specifies the one-based index that corresponds to the audio
    ///language for playback.
    ///Params:
    ///    lIndex = <b>long</b> containing the one-based index.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_currentAudioLanguageIndex(int lIndex);
    ///The <b>getLanguageName</b> method retrieves the name of the audio language with the specified locale identifier
    ///(LCID).
    ///Params:
    ///    lLangID = <b>long</b> specifying the LCID.
    ///    pbstrLangName = Pointer to a <b>BSTR</b> containing the audio language name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getLanguageName(int lLangID, BSTR* pbstrLangName);
    ///The <b>get_currentPositionTimecode</b> method retrieves the current position in the current media item using a
    ///time code format. This method currently supports SMPTE time code.
    ///Params:
    ///    bstrTimecode = Pointer to a <b>BSTR</b> containing the time code.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_currentPositionTimecode(BSTR* bstrTimecode);
    ///The <b>put_currentPositionTimecode</b> method specifies the current position in the current media item using a
    ///time code format. This method currently supports SMPTE time code.
    ///Params:
    ///    bstrTimecode = <b>BSTR</b> containing the time code.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_currentPositionTimecode(BSTR bstrTimecode);
}

///The <b>IWMPClosedCaption2</b> interface provides closed captioning methods that supplement the
///<b>IWMPClosedCaption</b> interface.
@GUID("350BA78B-6BC8-4113-A5F5-312056934EB6")
interface IWMPClosedCaption2 : IWMPClosedCaption
{
    ///The <b>get_SAMILangCount</b> method retrieves the number of languages supported by the current SAMI file.
    ///Params:
    ///    plCount = Pointer to a <b>long</b> containing the count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_SAMILangCount(int* plCount);
    ///The <b>getSAMILangName</b> method retrieves the name of a language supported by the current SAMI file.
    ///Params:
    ///    nIndex = <b>long</b> containing the index of the language name to retrieve.
    ///    pbstrName = Pointer to a <b>BSTR</b> containing the name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getSAMILangName(int nIndex, BSTR* pbstrName);
    ///The <b>getSAMILangID</b> method retrieves the locale identifier (LCID) of a language supported by the current
    ///SAMI file.
    ///Params:
    ///    nIndex = <b>long</b> containing the index.
    ///    plLangID = Pointer to a <b>long</b> containing the index of the LCID to retrieve.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getSAMILangID(int nIndex, int* plLangID);
    ///The <b>get_SAMIStyleCount</b> method retrieves the number of styles supported by the current SAMI file.
    ///Params:
    ///    plCount = Pointer to a <b>long</b> containing the count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_SAMIStyleCount(int* plCount);
    ///The <b>getSAMIStyleName</b> method retrieves the name of a style supported by the current SAMI file.
    ///Params:
    ///    nIndex = <b>long</b> containing the index of the style name to retrieve.
    ///    pbstrName = Pointer to a <b>BSTR</b> containing the name of the style as specified in the SAMI file.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getSAMIStyleName(int nIndex, BSTR* pbstrName);
}

///The <b>IWMPPlayerApplication</b> interface provides methods for switching between a remoted Windows Media Player
///control and the full mode of the Player. These methods can only be used with C++ programs that embed the control in
///remote mode.
@GUID("40897764-CEAB-47BE-AD4A-8E28537F9BBF")
interface IWMPPlayerApplication : IDispatch
{
    ///The <b>switchToPlayerApplication</b> method switches a remoted Windows Media Player control to the full mode of
    ///the Player.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT switchToPlayerApplication();
    ///The <b>switchToControl</b> method switches a remoted Windows Media Player control to the docked state.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT switchToControl();
    ///The <b>get_playerDocked</b> method retrieves a value indicating whether Windows Media Player is in a docked
    ///state.
    ///Params:
    ///    pbPlayerDocked = Pointer to a <b>VARIANT_BOOL</b> indicating whether Windows Media Player is in a docked state.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_playerDocked(short* pbPlayerDocked);
    ///The <b>get_hasDisplay</b> method retrieves a value indicating whether video can display through the remoted
    ///Windows Media Player control.
    ///Params:
    ///    pbHasDisplay = Pointer to a <b>VARIANT_BOOL</b> indicating whether video can display through the remoted Windows Media
    ///                   Player control.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_hasDisplay(short* pbHasDisplay);
}

///The <b>IWMPCore3</b> interface provides methods that supplement the <b>IWMPCore2</b> interface.
@GUID("7587C667-628F-499F-88E7-6A6F4E888464")
interface IWMPCore3 : IWMPCore2
{
    ///The <b>newPlaylist</b> method retrieves a pointer to an <b>IWMPPlaylist</b> interface for a new playlist.
    ///Params:
    ///    bstrName = <b>BSTR</b> containing the playlist name.
    ///    bstrURL = <b>BSTR</b> containing the playlist URL.
    ///    ppPlaylist = Pointer to a pointer to an <b>IWMPPlaylist</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT newPlaylist(BSTR bstrName, BSTR bstrURL, IWMPPlaylist* ppPlaylist);
    ///The <b>newMedia</b> method retrieves a pointer to an <b>IWMPMedia</b> interface for a new media item.
    ///Params:
    ///    bstrURL = <b>BSTR</b> containing the URL.
    ///    ppMedia = Pointer to a pointer to an <b>IWMPMedia</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT newMedia(BSTR bstrURL, IWMPMedia* ppMedia);
}

///The <b>IWMPPlayer4</b> interface provides methods for modifying the basic behavior of the Windows Media Player
///control user interface. These methods supplement the <b>IWMPCore3</b> interface. The <b>IWMPPlayer4</b> interface
///duplicates the methods of <b>IWMPPlayer</b>, <b>IWMPPlayer2</b>, and <b>IWMPPlayer3</b>, inherits the methods of
///<b>IWMPCore3</b>, and exposes the following additional methods.
@GUID("6C497D62-8919-413C-82DB-E935FB3EC584")
interface IWMPPlayer4 : IWMPCore3
{
    HRESULT get_enabled(short* pbEnabled);
    HRESULT put_enabled(short bEnabled);
    HRESULT get_fullScreen(short* pbFullScreen);
    HRESULT put_fullScreen(short bFullScreen);
    HRESULT get_enableContextMenu(short* pbEnableContextMenu);
    HRESULT put_enableContextMenu(short bEnableContextMenu);
    HRESULT put_uiMode(BSTR bstrMode);
    HRESULT get_uiMode(BSTR* pbstrMode);
    HRESULT get_stretchToFit(short* pbEnabled);
    HRESULT put_stretchToFit(short bEnabled);
    HRESULT get_windowlessVideo(short* pbEnabled);
    HRESULT put_windowlessVideo(short bEnabled);
    ///The <b>get_isRemote</b> method retrieves a value indicating whether the Windows Media Player control is running
    ///in remote mode.
    ///Params:
    ///    pvarfIsRemote = Pointer to a <b>VARIANT_BOOL</b> indicating whether the Windows Media Player control is running in remote
    ///                    mode. If the value is <b>TRUE</b>, then the control is running in remote mode. A value of <b>FALSE</b> means
    ///                    the control is running in local mode.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_isRemote(short* pvarfIsRemote);
    ///The <b>get_playerApplication</b> method retrieves a pointer to an <b>IWMPPlayerApplication</b> interface when a
    ///remoted Windows Media Player control is running.
    ///Params:
    ///    ppIWMPPlayerApplication = Pointer to a pointer to an <b>IWMPPlayerApplication</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_playerApplication(IWMPPlayerApplication* ppIWMPPlayerApplication);
    ///The <b>openPlayer</b> method opens Windows Media Player using the specified URL.
    ///Params:
    ///    bstrURL = <b>BSTR</b> containing the URL of the media item to play.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT openPlayer(BSTR bstrURL);
}

///The <b>IWMPPlayerServices</b> interface provides methods used by the host of a remoted Windows Media Player control
///to manipulate the full mode of the Player. These methods can only be used with C++.
@GUID("1D01FBDB-ADE2-4C8D-9842-C190B95C3306")
interface IWMPPlayerServices : IUnknown
{
    ///The <b>activateUIPlugin</b> method activates the specified UI plug-in in the full mode of Windows Media Player.
    ///Params:
    ///    bstrPlugin = <b>BSTR</b> containing the name of the plug-in to activate.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr> <td>S_OK</td> <td>The method
    ///    succeeded.</td> </tr> </table>
    ///    
    HRESULT activateUIPlugin(BSTR bstrPlugin);
    ///The <b>setTaskPane</b> method displays the specified task pane in the full mode of Windows Media Player.
    ///Params:
    ///    bstrTaskPane = <b>BSTR</b> containing one of the following values. <table> <tr> <th>Value </th> <th>Description </th> </tr>
    ///                   <tr> <td>NowPlaying</td> <td> Windows Media Player 9, 10, 11: Opens Windows Media Player in the<b> Now
    ///                   Playing</b> feature. Windows Media Player 12: Opens Windows Media Player in <b>Player</b> mode . </td> </tr>
    ///                   <tr> <td>MediaGuide</td> <td> Windows Media Player 9, 10, 11: Opens Windows Media Player in the <b>Media
    ///                   Guide</b> feature. Windows Media Player 12: Opens Windows Media Player in <b>Library</b> mode with the Media
    ///                   Guide displayed. </td> </tr> <tr> <td>CopyFromCD</td> <td> Windows Media Player 9: Opens Windows Media Player
    ///                   in the <b>Copy From CD</b> feature. Windows Media Player 10, 11: Opens Windows Media Player in the <b>Rip</b>
    ///                   feature. Windows Media Player 12: Opens Windows Media Player in <b>Library</b> mode. </td> </tr> <tr>
    ///                   <td>CopyFromCD?AutoCopy:<i>id</i></td> <td> Windows Media Player 9: Opens Windows Media Player in the <b>Copy
    ///                   From CD</b> feature and automatically invokes the copy functionality after switching. Windows Media Player
    ///                   10, 11: Opens Windows Media Player in the <b>Rip</b> feature and automatically invokes the rip functionality
    ///                   after switching. Windows Media Player 12: Opens Windows Media Player in <b>Library</b> mode and automatically
    ///                   invokes the rip functionality after switching. All versions: To specify a particular drive identifier, append
    ///                   a colon character (:) followed by the CD drive identifier number. If you omit the colon and the ID, the first
    ///                   CD drive is used. If the user has selected <b>Eject CD when copying is completed</b> in Windows Media Player,
    ///                   the CD will be ejected when copying is completed. </td> </tr> <tr> <td>Library</td> <td> Windows Media Player
    ///                   9, 10, 11: Opens Windows Media Player in the <b>Library</b> feature. Windows Media Player 12: Opens Windows
    ///                   Media Player in <b>Library</b> mode with the <b>Play</b> tab open. </td> </tr> <tr> <td>RadioTuner</td> <td>
    ///                   Windows Media Player 9: Opens Windows Media Player in the <b>Radio Tuner</b> feature Windows Media Player 10,
    ///                   11, 12: Opens Windows Media Player in the current active online store. </td> </tr> <tr> <td>CopyToCD</td>
    ///                   <td> Windows Media Player 9: Not supported. Windows Media Player 10, 11: Opens Windows Media Player in the
    ///                   <b>Burn</b> feature. Windows Media Player 12: Opens Windows Media Player in <b>Library</b> mode with the burn
    ///                   list open. </td> </tr> <tr> <td>CopyToCDOrDevice</td> <td> Windows Media Player 9: Opens Windows Media Player
    ///                   in the <b>Copy to CD or Device</b> feature. Windows Media Player 10, 11: Opens Windows Media Player in the
    ///                   <b>Sync</b> feature. Windows Media Player 12: Opens Windows Media Player in <b>Library</b> mode with the
    ///                   <b>Sync</b> tab open. </td> </tr> <tr> <td>Services</td> <td> Windows Media Player 9: Opens Windows Media
    ///                   Player in the <b>Premium Services</b> feature Windows Media Player 10, 11, 12: Opens Windows Media Player in
    ///                   the current active online store. </td> </tr> <tr> <td>SkinChooser</td> <td> Opens Windows Media Player in the
    ///                   <b>Skin Chooser</b> feature. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr> <td>S_OK</td> <td>The method
    ///    succeeded.</td> </tr> </table>
    ///    
    HRESULT setTaskPane(BSTR bstrTaskPane);
    ///This page documents a feature of the Windows Media Player 9 Series SDK and the Windows Media Player 10 SDK. It
    ///may be unavailable in subsequent versions. The <b>setTaskPaneURL</b> method displays the specified URL in the
    ///specified task pane of the full mode of Windows Media Player.
    ///Params:
    ///    bstrTaskPane = <b>BSTR</b> containing one of the following values. <table> <tr> <th>Value </th> <th>Description </th> </tr>
    ///                   <tr> <td>MediaGuide</td> <td>Opens Windows Media Player in the <b>MediaGuide</b> feature.</td> </tr> <tr>
    ///                   <td>RadioTuner</td> <td>Opens Windows Media Player in the <b>RadioTuner</b> feature.</td> </tr> <tr>
    ///                   <td>Services</td> <td>Opens Windows Media Player in the <b>Premium Services</b> feature.</td> </tr> </table>
    ///    bstrURL = <b>BSTR</b> containing the URL to display in the task pane.
    ///    bstrFriendlyName = <b>BSTR</b> containing the friendly name of the content at the specified URL.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr> <td>S_OK</td> <td>The method
    ///    succeeded.</td> </tr> </table>
    ///    
    HRESULT setTaskPaneURL(BSTR bstrTaskPane, BSTR bstrURL, BSTR bstrFriendlyName);
}

///The <b>IWMPSyncDevice</b> interface represents a device to which Windows Media Player 10 or later can copy digital
///media files. It provides methods used to specify and retrieve properties for the device and to manage the
///relationship between Windows Media Player and the device. To use this interface, you must create a remoted instance
///of the Windows Media Player 10 or later control.
@GUID("82A2986C-0293-4FD0-B279-B21B86C058BE")
interface IWMPSyncDevice : IUnknown
{
    ///The <b>get_friendlyName</b> method retrieves the user-defined name of the device.
    ///Params:
    ///    pbstrName = Pointer to a <b>BSTR</b> that contains the friendly name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_PDA_INITIALIZINGDEVICES (0xC00D118D)</b></dt> </dl> </td> <td width="60%"> Windows Media
    ///    Player is currently busy initializing devices. Please try again later. </td> </tr> </table>
    ///    
    HRESULT get_friendlyName(BSTR* pbstrName);
    ///The <b>put_friendlyName</b> method specifies the user-defined name of the device.
    ///Params:
    ///    bstrName = String containing the friendly name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_PDA_INITIALIZINGDEVICES (0xC00D118D)</b></dt> </dl> </td> <td width="60%"> Windows Media
    ///    Player is currently busy initializing devices. Please try again later. </td> </tr> </table>
    ///    
    HRESULT put_friendlyName(BSTR bstrName);
    ///The <b>get_deviceName</b> method retrieves the name of the device.
    ///Params:
    ///    pbstrName = Pointer to a <b>BSTR</b> that contains the name of the device.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_PDA_INITIALIZINGDEVICES (0xC00D118D)</b></dt> </dl> </td> <td width="60%"> Windows Media
    ///    Player is currently busy initializing devices. Please try again later. </td> </tr> </table>
    ///    
    HRESULT get_deviceName(BSTR* pbstrName);
    ///The <b>get_deviceId</b> method retrieves the device identifier string.
    ///Params:
    ///    pbstrDeviceId = Address of a <b>BSTR</b> variable that receives a string containing the device identifier.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_PDA_INITIALIZINGDEVICES (0xC00D118D)</b></dt> </dl> </td> <td width="60%"> Windows Media
    ///    Player is currently busy initializing devices. Please try again later. </td> </tr> </table>
    ///    
    HRESULT get_deviceId(BSTR* pbstrDeviceId);
    ///The <b>get_partnershipIndex</b> method retrieves the index of the device partnership.
    ///Params:
    ///    plIndex = Pointer to a <b>long</b> that contains the partnership index value. Possible values range from 0 to 16.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_PDA_INITIALIZINGDEVICES (0xC00D118D)</b></dt> </dl> </td> <td width="60%"> Windows Media
    ///    Player is currently busy initializing devices. Please try again later. </td> </tr> </table>
    ///    
    HRESULT get_partnershipIndex(int* plIndex);
    ///The <b>get_connected</b> method retrieves a value indicating whether the device is connected to Windows Media
    ///Player.
    ///Params:
    ///    pvbConnected = <b>VARIANT_BOOL</b> indicating whether the device is connected. The following table describes the possible
    ///                   values. <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr> <td>VARIANT_TRUE</td> <td>The device is
    ///                   connected.</td> </tr> <tr> <td>VARIANT_FALSE</td> <td>The device is not connected.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_PDA_INITIALIZINGDEVICES (0xC00D118D)</b></dt> </dl> </td> <td width="60%"> Windows Media
    ///    Player is currently busy initializing devices. Please try again later. </td> </tr> </table>
    ///    
    HRESULT get_connected(short* pvbConnected);
    ///The <b>get_status</b> method retrieves a value that indicates the status of the relationship between Windows
    ///Media Player and the device.
    ///Params:
    ///    pwmpds = Pointer to a <b>WMPDeviceStatus</b> enumeration value indicating the current status.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_PDA_INITIALIZINGDEVICES (0xC00D118D)</b></dt> </dl> </td> <td width="60%"> Windows Media
    ///    Player is currently busy initializing devices. Please try again later. </td> </tr> </table>
    ///    
    HRESULT get_status(WMPDeviceStatus* pwmpds);
    ///The <b>get_syncState</b> method retrieves a value that indicates the current synchronization state for the
    ///device.
    ///Params:
    ///    pwmpss = Pointer to a <b>WMPSyncState</b> enumeration value indicating the current synchronization state for the
    ///             device.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_PDA_INITIALIZINGDEVICES (0xC00D118D)</b></dt> </dl> </td> <td width="60%"> Windows Media
    ///    Player is currently busy initializing devices. Please try again later. </td> </tr> </table>
    ///    
    HRESULT get_syncState(WMPSyncState* pwmpss);
    ///The <b>get_progress</b> method retrieves a value that indicates the synchronization progress as percent complete.
    ///Params:
    ///    plProgress = Pointer to a <b>long</b> that indicates the progress as percent complete. Possible values are 0 to 100.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_PDA_INITIALIZINGDEVICES (0xC00D118D)</b></dt> </dl> </td> <td width="60%"> Windows Media
    ///    Player is currently busy initializing devices. Please try again later. </td> </tr> </table>
    ///    
    HRESULT get_progress(int* plProgress);
    ///The <b>getItemInfo</b> method retrieves a metadata value from the device.
    ///Params:
    ///    bstrItemName = <b>BSTR</b> containing the metadata item name. The following table lists the supported item names and
    ///                   describes the value that each retrieves. <table> <tr> <th>Name </th> <th>Retrieves </th> </tr> <tr>
    ///                   <td>AutoSyncDefaultRules</td> <td> Whether automatic synchronization is done according to default rules or
    ///                   custom rules. A value of "True" indicates default rules, and a value of "False" indicates custom rules. Use
    ///                   of this attribute is permitted only for devices that have a partnership with Windows Media Player. Requires
    ///                   Windows Media Player 12. </td> </tr> <tr> <td>BackgroundSyncState</td> <td> Whether Windows Media Player is
    ///                   allowed to perform background operations for the device. The value can be a string (<b>BSTR</b>)
    ///                   representation of a bitwise combination of one or more of the following flags. <ul> <li>1 Background
    ///                   synchronization is allowed.</li> <li>2 Background transcoding is allowed.</li> </ul> The value can also be
    ///                   one of the following strings. <ul> <li>"0" No background operations are allowed.</li> <li>"255" All
    ///                   background operations are allowed.</li> </ul> The value of this attribute lasts for the lifetime of Windows
    ///                   Media Player, but is not stored in the Windows Media Player library. Use of this attribute is permitted only
    ///                   for devices that have a partnership with Windows Media Player. Requires Windows Media Player 12. </td> </tr>
    ///                   <tr> <td>Connected</td> <td>Whether the device is currently connected to Windows Media Player. Possible
    ///                   values are "True" and "False".</td> </tr> <tr> <td>FreeSpace</td> <td>The size, in bytes, of the available
    ///                   device memory.</td> </tr> <tr> <td>FriendlyName</td> <td>The friendly name for the device.</td> </tr> <tr>
    ///                   <td>LastSyncErrorCount</td> <td>The number of synchronization errors that occurred during the most recent
    ///                   synchronization.</td> </tr> <tr> <td>LastSyncNoFitCount</td> <td>The number of media items that would not fit
    ///                   on the device during the most recent synchronization.</td> </tr> <tr> <td>LastSyncTime</td> <td>The time of
    ///                   the most recent synchronization.</td> </tr> <tr> <td>Name</td> <td>The name of the device.</td> </tr> <tr>
    ///                   <td>PercentSpaceReserved</td> <td>Limits the amount of device storage that Windows Media Player uses for file
    ///                   synchronization by specifying a portion of the storage as reserved. The value is the numeric percentage of
    ///                   total storage on the device represented by a string (<b>BSTR</b>). Supported values range from "0" to "95"
    ///                   inclusive.Use of this attribute is permitted only for devices that have a partnership with Windows Media
    ///                   Player. Requires Windows Media Player 11. </td> </tr> <tr> <td>PreferredAudio</td> <td> A string
    ///                   (<b>BSTR</b>) representation of the numeric identifier of the preferred storage for audio files on the
    ///                   device. If the device supports hints, the preferred storage is the location specified by the hint. If the
    ///                   device does not support hints, the preferred storage is the largest storage. Requires Windows Media Player
    ///                   12. </td> </tr> <tr> <td>PreferredVideo</td> <td> A string (<b>BSTR</b>) representation of the numeric
    ///                   identifier of the preferred storage for video files on the device. If the device supports hints, the
    ///                   preferred storage is the location specified by the hint. If the device does not support hints, the preferred
    ///                   storage is the largest storage. Requires Windows Media Player 12. </td> </tr> <tr> <td>PreferredPhoto</td>
    ///                   <td> A string (<b>BSTR</b>) representation of the numeric identifier of the preferred storage for picture
    ///                   files on the device. If the device supports hints, the preferred storage is the location specified by the
    ///                   hint. If the device does not support hints, the preferred storage is the largest storage. Requires Windows
    ///                   Media Player 12. </td> </tr> <tr> <td>SerialNumber</td> <td>The device serial number.</td> </tr> <tr>
    ///                   <td>SkippedFiles</td> <td> Whether the device has any skipped files. A value of "1" indicates that the device
    ///                   has skipped files. A value of "0" indicates that the device does not have any skipped files. Use of this
    ///                   attribute is permitted only for devices with which Windows Media Player has a partnership. Requires Windows
    ///                   Media Player 12. </td> </tr> <tr> <td>SupportsAudio</td> <td>Whether the device supports audio playback.
    ///                   Possible values are "True" and "False".</td> </tr> <tr> <td>SupportsPhoto</td> <td>Whether the device
    ///                   supports displaying photos. Possible values are "True" and "False".</td> </tr> <tr> <td>SupportsVideo</td>
    ///                   <td>Whether the device supports video playback. Possible values are "True" and "False".</td> </tr> <tr>
    ///                   <td>SyncFilter </td> <td> The types of files that will be synchronized during the next synchronization
    ///                   session, and an indication of whether content can be acquired from the device during that synchronization
    ///                   session. The value can be a string (<b>BSTR</b>) representation of a bitwise combination of one or more of
    ///                   the following flags. <ul> <li>"1" Music files will be synchronized.</li> <li>"2" Video files will be
    ///                   synchronized.</li> <li>"4" Picture files will be synchronized.</li> <li>"8" Content can be written to the
    ///                   device, but can not be acquired from the device.</li> </ul> For example, the string value "5" indicates that
    ///                   music and picture files will be synchronized. The value can also be one of the following strings. <ul>
    ///                   <li>"0xFF" No filter will be applied to the synchronization session. That is, files of all types will be
    ///                   synchronized, and content can be both written to the device and acquired from the device.</li> <li>"0x07"
    ///                   Files of all types will be synchronized.</li> </ul> This attribute affects only the next synchronization
    ///                   session. Use of this attribute is permitted only for devices that have a partnership with Windows Media
    ///                   Player. Requires Windows Media Player 12. </td> </tr> <tr> <td>SyncIndex</td> <td>The partnership index for
    ///                   the device. Possible values are the integers 0 through 16.</td> </tr> <tr> <td>SyncItemCount</td> <td>The
    ///                   count of items synchronized to the device.</td> </tr> <tr> <td>SyncOnConnect</td> <td> Whether Windows Media
    ///                   Player will synchronize the device when the device gets connected. A value of "True" indicates that Windows
    ///                   Media Player will synchronize the device, and a value of "False" indicates that Windows Media Player will not
    ///                   synchronize the device. Use of this attribute is permitted only for devices that have a partnership with
    ///                   Windows Media Player. Requires Windows Media Player 12. </td> </tr> <tr> <td>SyncPercentComplete</td> <td>The
    ///                   progress of synchronization as a percentage.</td> </tr> <tr> <td>SyncRelationship</td> <td>A number
    ///                   indicating how the device synchronizes with respect to the current instance of Windows Media Player. Possible
    ///                   values are:0, meaning no relationship. 1, meaning manual synchronization. 2, meaning a partnership exists
    ///                   with the current instance of Windows Media Player. 3, meaning a partnership exists with another instance of
    ///                   Windows Media Player. </td> </tr> <tr> <td>TotalSpace</td> <td>The size, in bytes, of the total memory for
    ///                   the device.</td> </tr> </table>
    ///    pbstrVal = Pointer to a <b>BSTR</b> that contains the specified metadata item name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_PDA_INITIALIZINGDEVICES (0xC00D118D)</b></dt> </dl> </td> <td width="60%"> Windows Media
    ///    Player is currently busy initializing devices. Please try again later. </td> </tr> </table>
    ///    
    HRESULT getItemInfo(BSTR bstrItemName, BSTR* pbstrVal);
    ///The <b>createPartnership</b> method creates a partnership between Windows Media Player and the device.
    ///Params:
    ///    vbShowUI = <b>VARIANT_BOOL</b> that specifies whether Windows Media Player displays the <b>Device Setup</b> dialog box.
    ///               The following table describes the behavior for each possible value. <table> <tr> <th>Value </th>
    ///               <th>Description </th> </tr> <tr> <td>VARIANT_TRUE</td> <td>The remoted instance of Windows Media Player
    ///               undocks, if necessary, and shows the device settings dialog box. If the Player is in skin mode, it returns to
    ///               full mode. If the Player is locked in skin mode by corporate policy, the call fails.When the user closes the
    ///               dialog box, Windows Media Player returns to its original docking state. Note that the events for docking and
    ///               undocking the Player will occur normally. </td> </tr> <tr> <td>VARIANT_FALSE</td> <td>Windows Media Player
    ///               attempts to create a partnership using a default set of device synchronization playlists. The Player does not
    ///               change its current visible state or mode.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded or a partnership exists. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_ABORT</b></dt> </dl> </td> <td width="60%"> The user canceled the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_NO_PDA (0xC00D1179L)</b></dt> </dl> </td> <td
    ///    width="60%"> The device is not connected. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_PDA_INITIALIZINGDEVICES (0xC00D118D)</b></dt> </dl> </td> <td width="60%"> Windows Media Player
    ///    is currently busy initializing devices. Please try again later. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_PDA_MANUALDEVICE (0xC00D1183)</b></dt> </dl> </td> <td width="60%"> The status for the current
    ///    device is wmpdsManualDevice. </td> </tr> </table>
    ///    
    HRESULT createPartnership(short vbShowUI);
    ///The <b>deletePartnership</b> method terminates the partnership between Windows Media Player and the device.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The method succeeded, but there was no partnership
    ///    to delete. This occurs when the current status is wmpdsPartnershipDeclined or wmpdsNewDevice. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>NS_E_PDA_INITIALIZINGDEVICES (0xC00D118D)</b></dt> </dl> </td> <td
    ///    width="60%"> Windows Media Player is currently busy initializing devices. Please try again later. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>NS_E_PDA_MANUALDEVICE (0xC00D1183)</b></dt> </dl> </td> <td width="60%">
    ///    The status for the current device is wmpdsManualDevice. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_PDA_PARTNERSHIPNOTEXIST (0xC00D1184)</b></dt> </dl> </td> <td width="60%"> The method failed
    ///    because the current status for the device is wmpdsPartnershipAnother. This method will only delete
    ///    partnerships that exist for the current instance of Windows Media Player. </td> </tr> </table>
    ///    
    HRESULT deletePartnership();
    ///The <b>start</b> method begins synchronization.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_PDA_INITIALIZINGDEVICES (0xC00D118D)</b></dt> </dl> </td> <td width="60%"> Windows Media
    ///    Player is currently busy initializing devices. Please try again later. </td> </tr> </table>
    ///    
    HRESULT start();
    ///The <b>stop</b> method ends synchronization.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_PDA_INITIALIZINGDEVICES (0xC00D118D)</b></dt> </dl> </td> <td width="60%"> Windows Media
    ///    Player is currently busy initializing devices. Please try again later. </td> </tr> </table>
    ///    
    HRESULT stop();
    ///The <b>showSettings</b> method displays the Windows Media Player synchronization settings dialog box.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_NO_PDA (0xC00D1179L)</b></dt> </dl> </td> <td width="60%"> The device is not connected.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_PDA_INITIALIZINGDEVICES (0xC00D118D)</b></dt> </dl> </td>
    ///    <td width="60%"> Windows Media Player is currently busy initializing devices. Please try again later. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>NS_E_PDA_MANUALDEVICE (0xC00D1183)</b></dt> </dl> </td> <td
    ///    width="60%"> The status for the current device is wmpdsManualDevice. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_PDA_PARTNERSHIPNOTEXIST</b></dt> </dl> </td> <td width="60%"> The current status for the device
    ///    is wmpdsPartnershipDeclined, wmpdsPartnershipAnother, or wmpdsNewDevice. This method only shows the settings
    ///    dialog box for devices for which a partnership exists with the current instance of Windows Media Player.
    ///    </td> </tr> </table>
    ///    
    HRESULT showSettings();
    ///The <b>isIdentical</b> method compares the current device to the specified device and retrieves a value
    ///indicating whether they are the same device.
    ///Params:
    ///    pDevice = Pointer to an <b>IWMPSyncDevice</b> interface that represents the device to which to compare the current
    ///              device.
    ///    pvbool = Pointer to a <b>VARIANT_BOOL</b> that indicates the result of the comparison.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_PDA_INITIALIZINGDEVICES (0xC00D118D)</b></dt> </dl> </td> <td width="60%"> Windows Media
    ///    Player is currently busy initializing devices. Please try again later. </td> </tr> </table>
    ///    
    HRESULT isIdentical(IWMPSyncDevice pDevice, short* pvbool);
}

///The <b>IWMPSyncServices</b> interface provides methods to enumerate available devices that can synchronize digital
///media files with Windows Media Player 10 or later. To use this interface, you must create a remoted instance of the
///Windows Media Player control.
@GUID("8B5050FF-E0A4-4808-B3A8-893A9E1ED894")
interface IWMPSyncServices : IUnknown
{
    ///The <b>get_deviceCount</b> method retrieves the number of available devices.
    ///Params:
    ///    plCount = Pointer to a <b>long</b> that contains the device count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_PDA_INITIALIZINGDEVICES (0xC00D118D)</b></dt> </dl> </td> <td width="60%"> Windows Media
    ///    Player is currently busy initializing devices. Please try again later. </td> </tr> </table>
    ///    
    HRESULT get_deviceCount(int* plCount);
    ///The <b>getDevice</b> method retrieves a pointer to a device interface.
    ///Params:
    ///    lIndex = <b>long</b> that contains the index of the device to retrieve. Device indexes are zero-based.
    ///    ppDevice = Pointer to a pointer to an <b>IWMPSyncDevice</b> interface that represents the device having the specified
    ///               index.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>NS_E_PDA_INITIALIZINGDEVICES (0xC00D118D)</b></dt> </dl> </td> <td width="60%"> Windows Media
    ///    Player is currently busy initializing devices. Please try again later. </td> </tr> </table>
    ///    
    HRESULT getDevice(int lIndex, IWMPSyncDevice* ppDevice);
}

///The <b>IWMPPlayerServices2</b> interface provides a method used by the host of a remoted Windows Media Player control
///to manipulate the full mode of the Player. In addition to the methods inherited from <b>IWMPPlayerServices</b>, the
///<b>IWMPPlayerServices2</b> interface exposes the following methods.
@GUID("1BB1592F-F040-418A-9F71-17C7512B4D70")
interface IWMPPlayerServices2 : IWMPPlayerServices
{
    ///The <b>setBackgroundProcessingPriority</b> method specifies a priority level for general background processing
    ///tasks.
    ///Params:
    ///    bstrPriority = <b>BSTR</b> containing one of the following values: "High", "Normal", "Off", or "Urgent".
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr> <td>S_OK</td> <td>The method
    ///    succeeded.</td> </tr> </table>
    ///    
    HRESULT setBackgroundProcessingPriority(BSTR bstrPriority);
}

///The <b>IWMPCdromRip</b> interface provides methods to manage copying, or <i>ripping</i>, tracks from an audio CD.
///Ripping a CD by using the <b>IWMPCdromRip</b> interface has the same effect as ripping music by using the Windows
///Media Player user interface. Ripped content is automatically added to the library according to the user's
///preferences. For more information about user preferences for CD ripping, see "Ripping music from CDs" in Windows
///Media Player Help.
@GUID("56E2294F-69ED-4629-A869-AEA72C0DCC2C")
interface IWMPCdromRip : IUnknown
{
    ///The <b>get_ripState</b> method retrieves an enumeration value that indicates the current state of the ripping
    ///process.
    ///Params:
    ///    pwmprs = Pointer to a variable that receives a value from the <b>WMPRipState</b> enumeration that indicates the
    ///             current state.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_ripState(WMPRipState* pwmprs);
    ///The <b>get_ripProgress</b> method retrieves the CD ripping progress as percent complete.
    ///Params:
    ///    plProgress = Pointer to a <b>long</b> that receives the progress value. Progress values range from 0 to 100.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_ripProgress(int* plProgress);
    ///The <b>startRip</b> method rips the CD.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT startRip();
    ///The <b>stopRip</b> method stops the CD ripping process.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT stopRip();
}

///The <b>IWMPCdromBurn</b> interface provides methods to manage creating audio CDs.
@GUID("BD94DBEB-417F-4928-AA06-087D56ED9B59")
interface IWMPCdromBurn : IUnknown
{
    ///The <b>isAvailable</b> method provides information about the CD drive and media.
    ///Params:
    ///    bstrItem = <b>BSTR</b> that contains one of the following values. <table> <tr> <th>Value </th> <th>Description </th>
    ///               </tr> <tr> <td>Burn</td> <td>The drive is a CD burner.</td> </tr> <tr> <td>Disc</td> <td>There is a CD in the
    ///               drive.</td> </tr> <tr> <td>Erase</td> <td>The CD can be erased.</td> </tr> <tr> <td>Write</td> <td>The CD can
    ///               be written to.</td> </tr> </table>
    ///    pIsAvailable = Pointer to a <b>VARIANT_BOOL</b> that indicates the result.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT isAvailable(BSTR bstrItem, short* pIsAvailable);
    ///The <b>getItemInfo</b> method retrieves the value of the specified attribute for the CD.
    ///Params:
    ///    bstrItem = <b>BSTR</b> that contains one of the following values. <table> <tr> <th>Value </th> <th>Description </th>
    ///               </tr> <tr> <td>AvailableTime</td> <td>Retrieves the time available on the CD, in seconds.</td> </tr> <tr>
    ///               <td>Blank</td> <td>Retrieves a <b>Boolean</b> (represented as a string) indicating whether the CD is
    ///               blank.</td> </tr> <tr> <td>FreeSpace</td> <td>Retrieves the free space on the CD, in bytes.</td> </tr> <tr>
    ///               <td>TotalSpace</td> <td>Retrieves the total space on the CD, in bytes.</td> </tr> </table>
    ///    pbstrVal = Pointer to a <b>BSTR</b> that receives the returned value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getItemInfo(BSTR bstrItem, BSTR* pbstrVal);
    ///The <b>get_label</b> method retrieves the CD volume label string.
    ///Params:
    ///    pbstrLabel = Pointer to a <b>BSTR</b> that contains the volume label string.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_label(BSTR* pbstrLabel);
    ///The <b>put_label</b> method specifies the label string for the CD volume.
    ///Params:
    ///    bstrLabel = <b>BSTR</b> that contains the label string for the CD volume.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_label(BSTR bstrLabel);
    ///The <b>get_burnFormat</b> method retrieves a value that indicates the type of CD to burn.
    ///Params:
    ///    pwmpbf = Pointer to a variable that receives a value from the <b>WMPBurnFormat</b> enumeration that indicates the type
    ///             of CD to burn.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_burnFormat(WMPBurnFormat* pwmpbf);
    ///The <b>put_burnFormat</b> method specifies the type of CD to burn.
    ///Params:
    ///    wmpbf = A value from the <b>WMPBurnFormat</b> enumeration that specifies the type of CD to burn.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_burnFormat(WMPBurnFormat wmpbf);
    ///The <b>get_burnPlaylist</b> method retrieves the current playlist to burn to the CD.
    ///Params:
    ///    ppPlaylist = Address of a variable that receives the <b>IWMPPlaylist</b> pointer of the playlist to burn.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_burnPlaylist(IWMPPlaylist* ppPlaylist);
    ///The <b>put_burnPlaylist</b> method specifies the playlist to burn to CD.
    ///Params:
    ///    pPlaylist = Pointer to an <b>IWMPPlaylist</b> interface for the playlist to burn.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_burnPlaylist(IWMPPlaylist pPlaylist);
    ///The <b>refreshStatus</b> method updates the status information for the current burn playlist.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT refreshStatus();
    ///The <b>get_burnState</b> method retrieves an enumeration value that indicates the current burn state.
    ///Params:
    ///    pwmpbs = Pointer to a variable that receives a value from the <b>WMPBurnState</b> enumeration that indicates the
    ///             current state.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_burnState(WMPBurnState* pwmpbs);
    ///The <b>get_burnProgress</b> method retrieves the CD burning progress as percent complete.
    ///Params:
    ///    plProgress = Pointer to a <b>long</b> that receives the progress value. Progress values range from 0 to 100.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_burnProgress(int* plProgress);
    ///The <b>startBurn</b> method burns the CD.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT startBurn();
    ///The <b>stopBurn</b> method stops the CD burning process.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT stopBurn();
    ///The <b>erase</b> method erases the current CD.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT erase();
}

///The <b>IWMPQuery</b> interface represents a compound query.
@GUID("A00918F3-A6B0-4BFB-9189-FD834C7BC5A5")
interface IWMPQuery : IDispatch
{
    ///The <b>addCondition</b> method adds a condition to the compound query using AND logic.
    ///Params:
    ///    bstrAttribute = String containing the attribute name.
    ///    bstrOperator = String containing the operator. See Remarks for supported values.
    ///    bstrValue = String containing the attribute value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT addCondition(BSTR bstrAttribute, BSTR bstrOperator, BSTR bstrValue);
    ///The <b>beginNextGroup</b> method begins a new condition group.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT beginNextGroup();
}

///The <b>IWMPMediaCollection2</b> interface provides methods that supplement the <b>IWMPMediaCollection</b> interface.
@GUID("8BA957F5-FD8C-4791-B82D-F840401EE474")
interface IWMPMediaCollection2 : IWMPMediaCollection
{
    ///The <b>createQuery</b> method retrieves a pointer to an <b>IWMPQuery</b> interface that represents a new query.
    ///Params:
    ///    ppQuery = Address of a variable that receives an <b>IWMPQuery</b> pointer to the new, empty query.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT createQuery(IWMPQuery* ppQuery);
    ///The <b>getPlaylistByQuery</b> method retrieves a pointer to an <b>IWMPPlaylist</b> interface. This interface
    ///represents a playlist that contains media items that match the query conditions.
    ///Params:
    ///    pQuery = Pointer to the <b>IWMPQuery</b> interface that represents the query.
    ///    bstrMediaType = String that contains the media type. Must contain one of the following values: "audio", "video", "photo",
    ///                    "playlist", or "other".
    ///    bstrSortAttribute = String that contains the attribute name used for sorting. An empty string means that no sorting is applied.
    ///    fSortAscending = <b>VARIANT_BOOL</b> that indicates whether the playlist must be sorted in ascending order.
    ///    ppPlaylist = Address of a variable that receives a pointer to an <b>IWMPPlaylist</b> interface for the retrieved playlist.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getPlaylistByQuery(IWMPQuery pQuery, BSTR bstrMediaType, BSTR bstrSortAttribute, short fSortAscending, 
                               IWMPPlaylist* ppPlaylist);
    ///The <b>getStringCollectionByQuery</b> method retrieves a pointer to an <b>IWMPStringCollection</b> interface.
    ///This interface represents a set of all string values for a specified attribute that match the query conditions.
    ///Params:
    ///    bstrAttribute = String containing the attribute name.
    ///    pQuery = Pointer to the <b>IWMPQuery</b> interface that represents the query that defines the conditions used to
    ///             retrieve the string collection.
    ///    bstrMediaType = String containing the media type. Must contain one of the following values: "audio", "video", "photo",
    ///                    "playlist", or "other".
    ///    bstrSortAttribute = String containing the attribute name used for sorting. An empty string means no sorting is applied.
    ///    fSortAscending = <b>VARIANT_BOOL</b> that indicates whether the playlist must be sorted in ascending order.
    ///    ppStringCollection = Address of a variable that receives a pointer to an <b>IWMPStringCollection</b> interface for the retrieved
    ///                         set of string values.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getStringCollectionByQuery(BSTR bstrAttribute, IWMPQuery pQuery, BSTR bstrMediaType, 
                                       BSTR bstrSortAttribute, short fSortAscending, 
                                       IWMPStringCollection* ppStringCollection);
    ///The <b>getByAttributeAndMediaType</b> method retrieves a pointer to an <b>IWMPPlaylist</b> interface. This
    ///interface represents a playlist that contains media items that have a specified attribute and media type.
    ///Params:
    ///    bstrAttribute = String that contains the specified attribute.
    ///    bstrValue = String that contains the specified value for the attribute that is specified in <i>bstrAttribute</i>.
    ///    bstrMediaType = String that contains the specified media type.
    ///    ppMediaItems = Address of a variable that receives a pointer to an <b>IWMPPlaylist</b> interface for the retrieved playlist.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getByAttributeAndMediaType(BSTR bstrAttribute, BSTR bstrValue, BSTR bstrMediaType, 
                                       IWMPPlaylist* ppMediaItems);
}

///The <b>IWMPStringCollection2</b> interface provides methods that supplement the <b>IWMPStringCollection</b>
///interface.
@GUID("46AD648D-53F1-4A74-92E2-2A1B68D63FD4")
interface IWMPStringCollection2 : IWMPStringCollection
{
    ///The <b>isIdentical</b> method retrieves a value indicating whether the supplied object is the same as the current
    ///one.
    ///Params:
    ///    pIWMPStringCollection2 = Pointer to an <b>IWMPStringCollection2</b> interface that represents the object to compare with current one.
    ///    pvbool = Pointer to a <b>VARIANT_BOOL</b> that receives the result of the comparison. VARIANT_TRUE indicates that the
    ///             objects are the same.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT isIdentical(IWMPStringCollection2 pIWMPStringCollection2, short* pvbool);
    ///The <b>getItemInfo</b> method retrieves the string corresponding to the specified string collection item index
    ///and name.
    ///Params:
    ///    lCollectionIndex = A <b>long</b> specifying the zero-based index of the string collection item from which to get the attribute.
    ///    bstrItemName = <b>BSTR</b> containing the attribute name.
    ///    pbstrValue = Pointer to a <b>BSTR</b> that receives the string. For attributes whose underlying value is <b>Boolean</b>,
    ///                 it returns the string "true" or "false".
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getItemInfo(int lCollectionIndex, BSTR bstrItemName, BSTR* pbstrValue);
    ///The <b>getAttributeCountByType</b> method retrieves the number of attributes associated with the specified string
    ///collection index, attribute name, and language.
    ///Params:
    ///    lCollectionIndex = A <b>long</b> specifying the zero-based index of the string collection item from which to get the attribute.
    ///    bstrType = <b>BSTR</b> containing the name of the attribute.
    ///    bstrLanguage = <b>BSTR</b> containing the language. If the value is set to null or "" (empty string), the current locale
    ///                   string is used. Otherwise, the value must be a valid RFC 1766 language string such as "en-us".
    ///    plCount = Pointer to a <b>long</b> that receives the count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getAttributeCountByType(int lCollectionIndex, BSTR bstrType, BSTR bstrLanguage, int* plCount);
    ///The <b>getItemInfoByType</b> method retrieves the value corresponding to the specified string collection item
    ///index, name, language, and attribute index.
    ///Params:
    ///    lCollectionIndex = A <b>long</b> specifying the zero-based index of the string collection item from which to get the attribute.
    ///    bstrType = <b>BSTR</b> containing the attribute name.
    ///    bstrLanguage = <b>BSTR</b> containing the language. If the value is set to null or "" (empty string) the current locale
    ///                   string is used. Otherwise, the value must be a valid RFC 1766 language string such as "en-us".
    ///    lAttributeIndex = A <b>long</b> containing the zero-based index of the attribute.
    ///    pvarValue = Pointer to a <b>VARIANT</b> that receives the returned value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getItemInfoByType(int lCollectionIndex, BSTR bstrType, BSTR bstrLanguage, int lAttributeIndex, 
                              VARIANT* pvarValue);
}

///The <b>IWMPLibrary</b> interface represents a library.
@GUID("3DF47861-7DF1-4C1F-A81B-4C26F0F7A7C6")
interface IWMPLibrary : IUnknown
{
    ///The <b>get_name</b> method retrieves the display name of the current library.
    ///Params:
    ///    pbstrName = Pointer to a string containing the name of the current library.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_name(BSTR* pbstrName);
    ///The <b>get_type</b> method retrieves a value that indicates the library type.
    ///Params:
    ///    pwmplt = Pointer to a variable that receives a value from the <b>WMPLibraryType</b> enumeration that indicates the
    ///             library type.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_type(WMPLibraryType* pwmplt);
    ///The <b>get_mediaCollection</b> method retrieves a pointer to the <b>IWMPMediaCollection</b> interface for the
    ///current library.
    ///Params:
    ///    ppIWMPMediaCollection = Address of a variable that receives a pointer to the <b>IWMPMediaCollection</b> interface for the current
    ///                            library.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_mediaCollection(IWMPMediaCollection* ppIWMPMediaCollection);
    ///The <b>isIdentical</b> method retrieves a value that indicates whether the supplied object is the same as the
    ///current one.
    ///Params:
    ///    pIWMPLibrary = Pointer to an <b>IWMPLibrary</b> interface that represents the object to compare with current one.
    ///    pvbool = Pointer to a <b>VARIANT_BOOL</b> that receives the result of the comparison. VARIANT_TRUE indicates that the
    ///             objects are the same.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT isIdentical(IWMPLibrary pIWMPLibrary, short* pvbool);
}

///The <b>IWMPLibraryServices</b> interface provides methods to enumerate libraries.
@GUID("39C2F8D5-1CF2-4D5E-AE09-D73492CF9EAA")
interface IWMPLibraryServices : IUnknown
{
    ///The <b>getCountByType</b> method retrieves the count of available libraries of a specified type.
    ///Params:
    ///    wmplt = WMPLibraryType enumeration value that specifies the type of library to count.
    ///    plCount = Pointer to a <b>long</b> that receives the library count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getCountByType(WMPLibraryType wmplt, int* plCount);
    ///The <b>getLibraryByType</b> method retrieves a pointer to an <b>IWMPLibrary</b> interface that represents the
    ///library that has the specified type and index.
    ///Params:
    ///    wmplt = <b>WMPLibraryType</b> enumeration value that specifies the type of library to retrieve.
    ///    lIndex = A <b>long</b> containing the index of the library to retrieve.
    ///    ppIWMPLibrary = Address of a variable that receives a pointer to the retrieved <b>IWMPLibrary</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getLibraryByType(WMPLibraryType wmplt, int lIndex, IWMPLibrary* ppIWMPLibrary);
}

///The <b>IWMPLibrarySharingServices</b> interface provides methods to manage library sharing. To use this interface,
///you must create a remoted instance of the Windows Media Player control.
@GUID("82CBA86B-9F04-474B-A365-D6DD1466E541")
interface IWMPLibrarySharingServices : IUnknown
{
    ///The <b>isLibraryShared</b> method retrieves a value indicating whether the user's library is shared.
    ///Params:
    ///    pvbShared = Pointer to a <b>VARIANT_BOOL</b> that receives the result. <b>VARIANT_TRUE</b> indicates that the user's
    ///                library is currently shared.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT isLibraryShared(short* pvbShared);
    ///The <b>isLibrarySharingEnabled</b> method retrieves a value indicating whether the user has enabled library
    ///sharing in Windows Media Player.
    ///Params:
    ///    pvbEnabled = Pointer to a <b>VARIANT_BOOL</b> that receives the result. <b>VARIANT_TRUE</b> indicates that the user has
    ///                 enabled library sharing.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT isLibrarySharingEnabled(short* pvbEnabled);
    ///The <b>showLibrarySharing</b> method displays the Windows Media Player <b>Library Sharing</b> dialog box.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT showLibrarySharing();
}

///The <b>IWMPFolderMonitorServices</b> interface is deprecated. The <b>IWMPFolderMonitorServices</b> interface provides
///methods to enumerate, scan, and modify file folders that Windows Media Player monitors for digital media content. To
///use this interface, you must create a remoted instance of the Windows Media Player 11 control. For more information
///about remoting, see Remoting the Windows Media Player Control.
@GUID("788C8743-E57F-439D-A468-5BC77F2E59C6")
interface IWMPFolderMonitorServices : IUnknown
{
    ///This method and all other methods of the IWMPFolderMonitorServices interface are deprecated. The <b>get_count</b>
    ///method retrieves the count of monitored folders.
    ///Params:
    ///    plCount = Pointer to a <b>long</b> that receives the count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_count(int* plCount);
    ///This method and all other methods of the IWMPFolderMonitorServices interface are deprecated. The <b>item</b>
    ///method retrieves the path to the folder corresponding to the specified index.
    ///Params:
    ///    lIndex = A <b>long</b> specifying the index of the folder to retrieve.
    ///    pbstrFolder = Pointer to a <b>BSTR</b> that receives the folder path string.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT item(int lIndex, BSTR* pbstrFolder);
    ///This method and all other methods of the IWMPFolderMonitorServices interface are deprecated. The <b>add</b>
    ///method adds a folder to the list of monitored folders.
    ///Params:
    ///    bstrFolder = <b>BSTR</b> containing the path to the folder.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT add(BSTR bstrFolder);
    ///This method and all other methods of the IWMPFolderMonitorServices interface are deprecated. The <b>remove</b>
    ///method removes a folder from the list of monitored folders.
    ///Params:
    ///    lIndex = A <b>long</b> specifying the index of the folder to remove from the list.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT remove(int lIndex);
    ///This method and all other methods of the IWMPFolderMonitorServices interface are deprecated. The
    ///<b>get_scanState</b> method retrieves the scan state for the current scanning operation.
    ///Params:
    ///    pwmpfss = Pointer to a variable that receives a value from the <b>WMPFolderScanState</b> enumeration that indicates the
    ///              scan state.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_scanState(WMPFolderScanState* pwmpfss);
    ///This method and all other methods of the IWMPFolderMonitorServices interface are deprecated. The
    ///<b>get_currentFolder</b> method retrieves the path of the folder currently being scanned.
    ///Params:
    ///    pbstrFolder = Pointer to a <b>BSTR</b> that receives the folder path string.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_currentFolder(BSTR* pbstrFolder);
    ///This method and all other methods of the IWMPFolderMonitorServices interface are deprecated. The
    ///<b>get_scannedFilesCount</b> method retrieves the count of files inspected during the current scanning operation.
    ///Params:
    ///    plCount = Pointer to a <b>long</b> that receives the count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_scannedFilesCount(int* plCount);
    ///This method and all other methods of the IWMPFolderMonitorServices interface are deprecated. The
    ///<b>get_addedFilesCount</b> method retrieves the count of files added to the library during the current scanning
    ///operation.
    ///Params:
    ///    plCount = Pointer to a <b>long</b> that receives the file count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_addedFilesCount(int* plCount);
    ///This method and all other methods of the IWMPFolderMonitorServices interface are deprecated. The
    ///<b>get_updateProgress</b> method retrieves the update progress as percent complete.
    ///Params:
    ///    plProgress = Pointer to a <b>long</b> that indicates the progress as percent complete. Values range from 0 to 100.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_updateProgress(int* plProgress);
    ///This method and all other methods of the IWMPFolderMonitorServices interface are deprecated. The <b>startScan</b>
    ///method starts a scanning operation.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT startScan();
    ///This method and all other methods of the IWMPFolderMonitorServices interface are deprecated. The <b>stopScan</b>
    ///method stops the scanning operation.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT stopScan();
}

///The <b>IWMPSyncDevice2</b> interface provides a method that supplements the <b>IWMPSyncDevice</b> interface. To use
///this interface, you must create a remoted instance of the Windows Media Player 10 or later control.
@GUID("88AFB4B2-140A-44D2-91E6-4543DA467CD1")
interface IWMPSyncDevice2 : IWMPSyncDevice
{
    ///The <b>setItemInfo</b> method specifies an attribute value for a device.
    ///Params:
    ///    bstrItemName = <b>BSTR</b>specifying the name of the attribute on which to set the new value. For supported attribute names,
    ///                   see Remarks.
    ///    bstrVal = <b>BSTR</b>specifying the new value. For information about supported values, see Remarks.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded or a partnership exists. </td> </tr>
    ///    </table>
    ///    
    HRESULT setItemInfo(BSTR bstrItemName, BSTR bstrVal);
}

///The <b>IWMPSyncDevice3</b> interface provides methods for estimating the size required to synchronize a playlist to a
///device. To use this interface, you must create a remoted instance of the Windows Media Player 12 control.
@GUID("B22C85F9-263C-4372-A0DA-B518DB9B4098")
interface IWMPSyncDevice3 : IWMPSyncDevice2
{
    ///The <b>estimateSyncSize</b> method initiates the estimation of the size required on the device to synchronize a
    ///specified playlist.
    ///Params:
    ///    pNonRulePlaylist = A pointer to an IWMPPlaylist interface that represents the playlist for which the size will be estimated.
    ///                       This parameter can be set to <b>NULL</b>. If this argument is specified the estimation will return the size
    ///                       of <i>pNonRulePlaylist</i> and the current sync rules, if any.
    ///    pRulesPlaylist = A pointer to an IWMPPlaylist interface that represents the playlist for which the size will be estimated.
    ///                     This parameter can be set to <b>NULL</b>. If this argument is specified then the current sync rules will be
    ///                     excluded from the estimation so that the estimation will return the size of <i>pNonRulePlaylist</i> and
    ///                     <i>pRulesPlaylist</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Windows Media Player is shutting down, or
    ///    <i>pNonRulePlaylist</i> and <i>pRulesPlaylist</i> are both <b>NULL</b>. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> A synchronization session is already in
    ///    progress for the device. </td> </tr> </table>
    ///    
    HRESULT estimateSyncSize(IWMPPlaylist pNonRulePlaylist, IWMPPlaylist pRulesPlaylist);
    ///The <b>cancelEstimation</b> method cancels an estimation that was previously initiated by estimateSyncSize.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT cancelEstimation();
}

///The <b>IWMPLibrary2</b> interface represents a media library.
@GUID("DD578A4E-79B1-426C-BF8F-3ADD9072500B")
interface IWMPLibrary2 : IWMPLibrary
{
    ///The <b>getItemInfo</b> method retrieves the value of the <b>LibraryID</b> attribute.
    ///Params:
    ///    bstrItemName = <b>BSTR</b> containing the attribute name. Set the value of this parameter to "LibraryID".
    ///    pbstrVal = Pointer to a <b>BSTR</b> that receives the value of the <b>LibraryID</b> attribute.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT getItemInfo(BSTR bstrItemName, BSTR* pbstrVal);
}

///The <b>IWMPEvents</b> interface provides events that originate from the Windows Media Player control. An embedding
///program can respond to these events. The events exposed by <b>IWMPEvents</b> are also exposed by the
///<b>_WMPOCXEvents</b> interface. In addition to the methods inherited from <b>IUnknown</b>, the <b>IWMPEvents</b>
///interface exposes the following methods. <table> <tr> <th>Method </th> <th>Description </th> </tr> <tr> <td>
///AudioLanguageChange </td> <td>Occurs when the current audio language changes.</td> </tr> <tr> <td> Buffering </td>
///<td>Occurs when the Windows Media Player control begins or ends buffering.</td> </tr> <tr> <td> CdromMediaChange
///</td> <td>Occurs when a CD or DVD is inserted into or ejected from a CD or DVD drive.</td> </tr> <tr> <td> Click
///</td> <td>Occurs when the user clicks a mouse button.</td> </tr> <tr> <td> CurrentItemChange </td> <td>Occurs when
///the <b>currentItem</b> property of the <b>IWMPControls</b> interface changes value.</td> </tr> <tr> <td>
///CurrentMediaItemAvailable </td> <td>Occurs when the current media item becomes available.</td> </tr> <tr> <td>
///CurrentPlaylistChange </td> <td>Occurs when something changes within the current playlist.</td> </tr> <tr> <td>
///CurrentPlaylistItemAvailable </td> <td>Occurs when the current playlist item becomes available.</td> </tr> <tr> <td>
///Disconnect </td> <td>Reserved for future use.</td> </tr> <tr> <td> DomainChange </td> <td>Occurs when the DVD domain
///changes.</td> </tr> <tr> <td> DoubleClick </td> <td>Occurs when the user double-clicks a mouse button.</td> </tr>
///<tr> <td> DurationUnitChange </td> <td>Reserved for future use.</td> </tr> <tr> <td> EndOfStream </td> <td>Reserved
///for future use.</td> </tr> <tr> <td> Error </td> <td>Occurs when the Windows Media Player control has an error
///condition.</td> </tr> <tr> <td> KeyDown </td> <td>Occurs when a key is pressed.</td> </tr> <tr> <td> KeyPress </td>
///<td>Occurs when a key is pressed and then released.</td> </tr> <tr> <td> KeyUp </td> <td>Occurs when a key is
///released.</td> </tr> <tr> <td> MarkerHit </td> <td>Occurs when a marker is reached.</td> </tr> <tr> <td> MediaChange
///</td> <td>Occurs when a media item changes.</td> </tr> <tr> <td> MediaCollectionAttributeStringAdded </td> <td>Occurs
///when an attribute is added to the library.</td> </tr> <tr> <td> MediaCollectionAttributeStringChanged </td>
///<td>Occurs when an attribute in the library is changed.</td> </tr> <tr> <td> MediaCollectionAttributeStringRemoved
///</td> <td>Occurs when an attribute is removed from the library.</td> </tr> <tr> <td> MediaCollectionChange </td>
///<td>Occurs when the media collection changes.</td> </tr> <tr> <td> MediaError </td> <td>Occurs when the <b>Media</b>
///object has an error condition.</td> </tr> <tr> <td> ModeChange </td> <td>Occurs when a mode of Windows Media Player
///is changed.</td> </tr> <tr> <td> MouseDown </td> <td>Occurs when a mouse button is pressed.</td> </tr> <tr> <td>
///MouseMove </td> <td>Occurs when the mouse pointer is moved.</td> </tr> <tr> <td> MouseUp </td> <td>Occurs when a
///mouse button is released.</td> </tr> <tr> <td> NewStream </td> <td>Reserved for future use.</td> </tr> <tr> <td>
///OpenPlaylistSwitch </td> <td>Occurs when a title on a DVD begins playing.</td> </tr> <tr> <td> OpenStateChange </td>
///<td>Occurs when the Windows Media Player control changes state.</td> </tr> <tr> <td> PlayerDockedStateChange </td>
///<td>Occurs when a remoted Windows Media Player control docks or undocks.</td> </tr> <tr> <td> PlayerReconnect </td>
///<td>Occurs when a remoted Windows Media Player control reconnects to the Player.</td> </tr> <tr> <td> PlaylistChange
///</td> <td>Occurs when a playlist changes.</td> </tr> <tr> <td> PlaylistCollectionChange </td> <td>Occurs when
///something changes in the playlist collection.</td> </tr> <tr> <td> PlaylistCollectionPlaylistAdded </td> <td>Occurs
///when a playlist is added to the playlist collection.</td> </tr> <tr> <td> PlaylistCollectionPlaylistRemoved </td>
///<td>Occurs when a playlist is removed from the playlist collection.</td> </tr> <tr> <td>
///PlaylistCollectionPlaylistSetAsDeleted </td> <td>Reserved for future use.</td> </tr> <tr> <td> PlayStateChange </td>
///<td>Occurs when the play state of the Windows Media Player control changes.</td> </tr> <tr> <td> PositionChange </td>
///<td>Occurs when the current position of the media has been changed.</td> </tr> <tr> <td> ScriptCommand </td>
///<td>Occurs when a synchronized command or URL is received.</td> </tr> <tr> <td> StatusChange </td> <td>Occurs when
///the <b>status</b> property changes value.</td> </tr> <tr> <td> SwitchedToControl </td> <td>Occurs when a remoted
///Windows Media Player control switches to the docked state.</td> </tr> <tr> <td> SwitchedToPlayerApplication </td>
///<td>Occurs when a remoted Windows Media Player control switches to the full mode of the Player.</td> </tr> <tr> <td>
///Warning </td> <td>Reserved for future use.</td> </tr> </table>
@GUID("19A6627B-DA9E-47C1-BB23-00B5E668236A")
interface IWMPEvents : IUnknown
{
    ///The <b>OpenStateChange</b> event occurs when the Windows Media Player control changes state.
    ///Params:
    ///    NewState = Specifies the new open state.
    void OpenStateChange(int NewState);
    ///The <b>PlayStateChange</b> event occurs when the play state of the Windows Media Player control changes.
    ///Params:
    ///    NewState = Specifies the new state.
    void PlayStateChange(int NewState);
    ///The <b>AudioLanguageChange</b> event occurs when the current audio language changes.
    ///Params:
    ///    LangID = Specifies the new language identifier.
    void AudioLanguageChange(int LangID);
    ///The <b>StatusChange</b> event occurs when the <b>status</b> property changes value.
    void StatusChange();
    ///The <b>ScriptCommand</b> event occurs when a synchronized command or URL is received.
    ///Params:
    ///    scType = Specifies the type of script command.
    ///    Param = Specifies the script command.
    void ScriptCommand(BSTR scType, BSTR Param);
    ///The <b>NewStream</b> event is reserved for future use.
    void NewStream();
    ///The <b>Disconnect</b> event is reserved for future use.
    ///Params:
    ///    Result = Not supported.
    void Disconnect(int Result);
    ///The <b>Buffering</b> event occurs when the Windows Media Player control begins or ends buffering.
    ///Params:
    ///    Start = Specifies whether buffering has begun or ended. A value of true indicates that it has begun; a value of false
    ///            indicates that it has ended.
    void Buffering(short Start);
    ///The <b>Error</b> event occurs when the Windows Media Player control has an error condition..
    void Error();
    ///The <b>Warning</b> event is reserved for future use.
    ///Params:
    ///    WarningType = Not supported.
    ///    Param = Not supported.
    ///    Description = Not supported.
    void Warning(int WarningType, int Param, BSTR Description);
    ///The <b>EndOfStream</b> event is reserved for future use.
    ///Params:
    ///    Result = Not supported.
    void EndOfStream(int Result);
    ///The <b>PositionChange</b> event occurs when the current playback position within the media item has been changed.
    ///Params:
    ///    oldPosition = Specifies the original position.
    ///    newPosition = Specifies the new position.
    void PositionChange(double oldPosition, double newPosition);
    ///The <b>MarkerHit</b> event occurs when a marker is reached.
    ///Params:
    ///    MarkerNum = Specifies the number of the marker that was hit.
    void MarkerHit(int MarkerNum);
    ///The <b>DurationUnitChange</b> event is reserved for future use.
    ///Params:
    ///    NewDurationUnit = Not supported.
    void DurationUnitChange(int NewDurationUnit);
    ///The <b>CdromMediaChange</b> event occurs when a CD or DVD is inserted into or ejected from a CD or DVD drive.
    ///Params:
    ///    CdromNum = Specifies the index of the CD or DVD drive.
    void CdromMediaChange(int CdromNum);
    ///The <b>PlaylistChange</b> event occurs when a playlist changes.
    ///Params:
    ///    Playlist = Pointer to an <b>IDispatch</b> interface for the playlist that changed.
    ///    change = A <b>WMPPlaylistChangeEventType</b> enumeration value.
    void PlaylistChange(IDispatch Playlist, WMPPlaylistChangeEventType change);
    ///The <b>CurrentPlaylistChange</b> event occurs when something changes within the current playlist.
    ///Params:
    ///    change = Specifies what type of change occurred to the playlist. See the <b>PlaylistChange</b> event for a table of
    ///             possible values.
    void CurrentPlaylistChange(WMPPlaylistChangeEventType change);
    ///The <b>CurrentPlaylistItemAvailable</b> event occurs when the current playlist item becomes available.
    ///Params:
    ///    bstrItemName = Specifies the item name.
    void CurrentPlaylistItemAvailable(BSTR bstrItemName);
    ///The <b>MediaChange</b> event occurs when a media item changes.
    ///Params:
    ///    Item = Pointer to an <b>IDispatch</b> interface that identifies the item that changed.
    void MediaChange(IDispatch Item);
    ///The <b>CurrentMediaItemAvailable</b> event occurs when the current media item becomes available.
    ///Params:
    ///    bstrItemName = Specifies the item name.
    void CurrentMediaItemAvailable(BSTR bstrItemName);
    ///The <b>CurrentItemChange</b> event occurs when the user or the <b>IWMPControls::put_CurrentItem</b> method
    ///changes the current item value.
    ///Params:
    ///    pdispMedia = Pointer to an <b>IDispatch</b> interface that identifies the new current item.
    void CurrentItemChange(IDispatch pdispMedia);
    ///The <b>MediaCollectionChange</b> event occurs when the media collection changes.
    void MediaCollectionChange();
    ///The <b>MediaCollectionAttributeStringAdded</b> event occurs when an attribute is added to the library.
    ///Params:
    ///    bstrAttribName = Specifies the attribute name. For information about the attributes supported by Windows Media Player, see the
    ///                     Windows Media Player Attribute Reference.
    ///    bstrAttribVal = Specifies the attribute value.
    void MediaCollectionAttributeStringAdded(BSTR bstrAttribName, BSTR bstrAttribVal);
    ///The <b>MediaCollectionAttributeStringRemoved</b> event occurs when an attribute is removed from the library.
    ///Params:
    ///    bstrAttribName = Specifies the name of the attribute. For information about the attributes supported by Windows Media Player,
    ///                     see the Windows Media Player Attribute Reference.
    ///    bstrAttribVal = Specifies the value of the attribute.
    void MediaCollectionAttributeStringRemoved(BSTR bstrAttribName, BSTR bstrAttribVal);
    ///The <b>MediaCollectionAttributeStringChanged</b> event occurs when an attribute value in the library is changed.
    ///Params:
    ///    bstrAttribName = Specifies the name of the attribute. For information about the attributes supported by Windows Media Player,
    ///                     see the Windows Media Player Attribute Reference.
    ///    bstrOldAttribVal = Specifies the original attribute value.
    ///    bstrNewAttribVal = Specifies the new attribute value.
    void MediaCollectionAttributeStringChanged(BSTR bstrAttribName, BSTR bstrOldAttribVal, BSTR bstrNewAttribVal);
    ///The <b>PlaylistCollectionChange</b> event occurs when something changes in the playlist collection.
    void PlaylistCollectionChange();
    ///The <b>PlaylistCollectionPlaylistAdded</b> event occurs when a playlist is added to the playlist collection.
    ///Params:
    ///    bstrPlaylistName = Specifies the name of the playlist that was added.
    void PlaylistCollectionPlaylistAdded(BSTR bstrPlaylistName);
    ///The <b>PlaylistCollectionPlaylistRemoved</b> event occurs when a playlist is removed from the playlist
    ///collection.
    ///Params:
    ///    bstrPlaylistName = Specifies the name of the playlist that was removed.
    void PlaylistCollectionPlaylistRemoved(BSTR bstrPlaylistName);
    ///The <b>PlaylistCollectionPlaylistSetAsDeleted</b> event is reserved for future use.
    ///Params:
    ///    bstrPlaylistName = Not supported.
    ///    varfIsDeleted = Not supported.
    void PlaylistCollectionPlaylistSetAsDeleted(BSTR bstrPlaylistName, short varfIsDeleted);
    ///The <b>ModeChange</b> event occurs when a mode of the player is changed.
    ///Params:
    ///    ModeName = Specifies the mode that was changed. Contains one of the following values. <table> <tr> <th>Value</th>
    ///               <th>Description</th> </tr> <tr> <td>shuffle</td> <td>Tracks are played in random order.</td> </tr> <tr>
    ///               <td>loop</td> <td>The entire sequence of tracks is played repeatedly.</td> </tr> </table>
    ///    NewValue = Indicates the new state of the specified mode.
    void ModeChange(BSTR ModeName, short NewValue);
    ///The <b>MediaError</b> event occurs when the <b>Media</b> object has an error condition.
    ///Params:
    ///    pMediaObject = Pointer to an <b>IDispatch</b> interface for the object that has an error condition.
    void MediaError(IDispatch pMediaObject);
    ///The <b>OpenPlaylistSwitch</b> event occurs when a title on a DVD begins playing.
    ///Params:
    ///    pItem = Pointer to an <b>IDispatch</b> interface for the given playlist.
    void OpenPlaylistSwitch(IDispatch pItem);
    ///The <b>DomainChange</b> event occurs when the DVD domain changes.
    ///Params:
    ///    strDomain = Specifies the new domain. It can be one of the following values: <table> <tr> <th>String</th>
    ///                <th>Description</th> </tr> <tr> <td>firstPlay</td> <td>Performing default initialization of a DVD disc.</td>
    ///                </tr> <tr> <td>videoManagerMenu</td> <td>Displaying menus for whole disc. Also known as Root Menu or
    ///                topMenu.</td> </tr> <tr> <td>videoTitleSetMenu</td> <td>Displaying menus for current title set. Also known as
    ///                titleMenu</td> </tr> <tr> <td>title</td> <td>Displaying the current title.</td> </tr> <tr> <td>stop</td>
    ///                <td>The DVD Navigator is in the DVD Stop domain.</td> </tr> </table>
    void DomainChange(BSTR strDomain);
    ///The <b>SwitchedToPlayerApplication</b> event occurs when a remoted Windows Media Player control switches to the
    ///full mode of the Player.
    void SwitchedToPlayerApplication();
    ///The <b>SwitchedToControl</b> event occurs when a remoted Windows Media Player control switches to the docked
    ///state.
    void SwitchedToControl();
    ///The <b>PlayerDockedStateChange</b> event occurs when a remoted Windows Media Player control docks or undocks.
    void PlayerDockedStateChange();
    ///The <b>PlayerReconnect</b> event occurs when a remoted Windows Media Player control reconnects to the Player.
    void PlayerReconnect();
    ///The <b>Click</b> event occurs when the user clicks a mouse button.
    ///Params:
    ///    nButton = A bitfield with bits corresponding to the left button (bit 0), right button (bit 1), and middle button (bit
    ///              2). These bits correspond to the values 1, 2, and 4, respectively. Only one of the bits is set, indicating
    ///              the button that caused the event.
    ///    nShiftState = A bitfield with the least significant bits corresponding to the SHIFT key (bit 0), the CTRL key (bit 1), and
    ///                  the ALT key (bit 2). These bits correspond to the values 1, 2, and 4, respectively. The shift argument
    ///                  indicates the state of these keys. Some, all, or none of the bits can be set, indicating that some, all, or
    ///                  none of the keys are pressed..
    ///    fX = The <i>x</i> coordinate of the mouse pointer relative to the upper-left corner of the control.
    ///    fY = The <i>y</i> coordinate of the mouse pointer relative to the upper-left corner of the control.
    void Click(short nButton, short nShiftState, int fX, int fY);
    ///The <b>DoubleClick</b> event occurs when the user double-clicks a mouse button.
    ///Params:
    ///    nButton = A bitfield with bits corresponding to the left button (bit 0), right button (bit 1), and middle button (bit
    ///              2). These bits correspond to the values 1, 2, and 4, respectively. Only one of the bits is set, indicating
    ///              the button that caused the event.
    ///    nShiftState = A bitfield with the least significant bits corresponding to the SHIFT key (bit 0), the CTRL key (bit 1), and
    ///                  the ALT key (bit 2). These bits correspond to the values 1, 2, and 4, respectively. The shift argument
    ///                  indicates the state of these keys. Some, all, or none of the bits can be set, indicating that some, all, or
    ///                  none of the keys are pressed.
    ///    fX = The x coordinate of the mouse pointer relative to the upper left-hand corner of the control.
    ///    fY = The y coordinate of the mouse pointer relative to the upper left-hand corner of the control.
    void DoubleClick(short nButton, short nShiftState, int fX, int fY);
    ///The <b>KeyDown</b> event occurs when a key is pressed.
    ///Params:
    ///    nKeyCode = Specifies which physical key is pressed. For possible values, see the Remarks section.
    ///    nShiftState = A bitfield with the least significant bits corresponding to the SHIFT key (bit 0), the CTRL key (bit 1), and
    ///                  the ALT key (bit 2). These bits correspond to the values 1, 2, and 4, respectively. The shift argument
    ///                  indicates the state of these keys. Some, all, or none of the bits can be set, indicating that some, all, or
    ///                  none of the keys are pressed.
    void KeyDown(short nKeyCode, short nShiftState);
    ///The <b>KeyPress</b> event occurs when a key is pressed and then released.
    ///Params:
    ///    nKeyAscii = Specifies the standard numeric ANSI code for the character.
    void KeyPress(short nKeyAscii);
    ///The <b>KeyUp</b> event occurs when a key is released.
    ///Params:
    ///    nKeyCode = Specifies which physical key is pressed. For possible values, see the Remarks section of the <b>KeyDown</b>
    ///               event.
    ///    nShiftState = A bitfield with the least significant bits corresponding to the SHIFT key (bit 0), the CTRL key (bit 1), and
    ///                  the ALT key (bit 2). These bits correspond to the values 1, 2, and 4, respectively. The shift argument
    ///                  indicates the state of these keys. Some, all, or none of the bits can be set, indicating that some, all, or
    ///                  none of the keys are pressed.
    void KeyUp(short nKeyCode, short nShiftState);
    ///The <b>MouseDown</b> event occurs when a mouse button is pressed.
    ///Params:
    ///    nButton = A bitfield with bits corresponding to the left button (bit 0), right button (bit 1), and middle button (bit
    ///              2). These bits correspond to the values 1, 2, and 4, respectively. Only one of the bits is set, indicating
    ///              the button that caused the event.
    ///    nShiftState = A bitfield with the least significant bits corresponding to the SHIFT key (bit 0), the CTRL key (bit 1), and
    ///                  the ALT key (bit 2). These bits correspond to the values 1, 2, and 4, respectively. The shift argument
    ///                  indicates the state of these keys. Some, all, or none of the bits can be set, indicating that some, all, or
    ///                  none of the keys are pressed.
    ///    fX = The <i>x</i> coordinate of the mouse pointer relative to the upper-left corner of the control.
    ///    fY = The <i>y</i> coordinate of the mouse pointer relative to the upper-left corner of the control.
    void MouseDown(short nButton, short nShiftState, int fX, int fY);
    ///The <b>MouseMove</b> event occurs when the mouse pointer is moved.
    ///Params:
    ///    nButton = A bitfield with bits corresponding to the left button (bit 0), right button (bit 1), and middle button (bit
    ///              2). These bits correspond to the values 1, 2, and 4, respectively. Some, all, or none of the bits can be set,
    ///              indicating that some, all, or none of the buttons are pressed.
    ///    nShiftState = A bitfield with the least significant bits corresponding to the SHIFT key (bit 0), the CTRL key (bit 1), and
    ///                  the ALT key (bit 2). These bits correspond to the values 1, 2, and 4, respectively. The shift argument
    ///                  indicates the state of these keys. Some, all, or none of the bits can be set, indicating that some, all, or
    ///                  none of the keys are pressed.
    ///    fX = The <i>x</i> coordinate of the mouse pointer relative to the upper-left corner of the control.
    ///    fY = The <i>y</i> coordinate of the mouse pointer relative to the upper-left corner of the control.
    void MouseMove(short nButton, short nShiftState, int fX, int fY);
    ///The <b>MouseUp</b> event occurs when a mouse button is released.
    ///Params:
    ///    nButton = A bitfield with bits corresponding to the left button (bit 0), right button (bit 1), and middle button (bit
    ///              2). These bits correspond to the values 1, 2, and 4, respectively. Only one of the bits is set, indicating
    ///              the button that caused the event.
    ///    nShiftState = A bitfield with the least significant bits corresponding to the SHIFT key (bit 0), the CTRL key (bit 1), and
    ///                  the ALT key (bit 2). These bits correspond to the values 1, 2, and 4, respectively. The shift argument
    ///                  indicates the state of these keys. Some, all, or none of the bits can be set, indicating that some, all, or
    ///                  none of the keys are pressed.
    ///    fX = The <i>x</i> coordinate of the mouse pointer relative to the upper-left corner of the control.
    ///    fY = The <i>y</i> coordinate of the mouse pointer relative to the upper-left corner of the control.
    void MouseUp(short nButton, short nShiftState, int fX, int fY);
}

///The <b>IWMPEvents2</b> interface provides events originating from the Windows Media Player 10 or later control to
///which an embedding program can respond. The events exposed by <b>IWMPEvents2</b> are also exposed by the
///<b>_WMPOCXEvents</b> interface. The events provided by <b>IWMPEvents2</b> are related to device synchronization. To
///receive these events you must create a remoted instance of the Windows Media Player 10 or later control. In addition
///to the methods inherited from <b>IWMPEvents</b>, the <b>IWMPEvents2</b> interface exposes the following methods.
///<table> <tr> <th>Method </th> <th>Description </th> </tr> <tr> <td> CreatePartnershipComplete </td> <td>Occurs when
///an asynchronous call to <b>IWMPSyncDevice::createPartnership</b> completes.</td> </tr> <tr> <td> DeviceConnect </td>
///<td>Occurs when the user connects a device to the computer.</td> </tr> <tr> <td> DeviceDisconnect </td> <td>Occurs
///when the user disconnects a device from the computer.</td> </tr> <tr> <td> DeviceStatusChange </td> <td>Occurs when
///the partnership status of a device changes.</td> </tr> <tr> <td> DeviceSyncError </td> <td>Occurs when a
///synchronization error happens.</td> </tr> <tr> <td> DeviceSyncStateChange </td> <td>Occurs when the synchronization
///state of a device changes.</td> </tr> </table>
@GUID("1E7601FA-47EA-4107-9EA9-9004ED9684FF")
interface IWMPEvents2 : IWMPEvents
{
    ///The <b>DeviceConnect</b> event occurs when the user connects a device to the computer.
    ///Params:
    ///    pDevice = Address of the <b>IWMPSyncDevice</b> interface that represents the device that the user connected.
    void DeviceConnect(IWMPSyncDevice pDevice);
    ///The <b>DeviceDisconnect</b> event occurs when the user disconnects a device from the computer.
    ///Params:
    ///    pDevice = Address of the <b>IWMPSyncDevice</b> interface that represents the device that the user disconnected.
    void DeviceDisconnect(IWMPSyncDevice pDevice);
    ///The <b>DeviceStatusChange</b> event occurs when the partnership status of a device changes.
    ///Params:
    ///    pDevice = Address of the <b>IWMPSyncDevice</b> interface that represents the device for which the status changed.
    ///    NewStatus = <b>WMPDeviceStatus</b> enumeration value that represents the new status for the device specified by
    ///                <i>pDevice</i>.
    void DeviceStatusChange(IWMPSyncDevice pDevice, WMPDeviceStatus NewStatus);
    ///The <b>DeviceSyncStateChange</b> event occurs when the synchronization state of a device changes.
    ///Params:
    ///    pDevice = Address of the <b>IWMPSyncDevice</b> interface that represents the device for which the synchronization state
    ///              changed.
    ///    NewState = <b>WMPSyncState</b> enumeration value that represents the new synchronization state for the device specified
    ///               by <i>pDevice</i>.
    void DeviceSyncStateChange(IWMPSyncDevice pDevice, WMPSyncState NewState);
    ///The <b>DeviceSyncError</b> event occurs in response to a synchronization error.
    ///Params:
    ///    pDevice = Address of the <b>IWMPSyncDevice</b> interface that represents the device for which the synchronization error
    ///              occurred.
    ///    pMedia = Address of the <b>IWMPDispatch</b> interface that represents the media item for which the synchronization
    ///             error occurred.
    void DeviceSyncError(IWMPSyncDevice pDevice, IDispatch pMedia);
    ///The <b>CreatePartnershipComplete</b> event occurs when an asynchronous call to
    ///<b>IWMPSyncDevice::createPartnership</b> completes.
    ///Params:
    ///    pDevice = Address of the <b>IWMPSyncDevice</b> interface that represents the device object for which the partnership
    ///              was created.
    ///    hrResult = The success or error <b>HRESULT</b> for the create partnership operation.
    void CreatePartnershipComplete(IWMPSyncDevice pDevice, HRESULT hrResult);
}

///The IWMPEvents3 interface provides access to events originating from the Windows Media Player 11 control so that an
///application that has this control embedded in it can respond to these events.
@GUID("1F504270-A66B-4223-8E96-26A06C63D69F")
interface IWMPEvents3 : IWMPEvents2
{
    ///The <b>CdromRipStateChange</b> event occurs when a CD ripping operation changes state.
    ///Params:
    ///    pCdromRip = Pointer to the <b>IWMPCdromRip</b> interface that represents the ripping operation that raised the error.
    ///    wmprs = <b>WMPRipState</b> enumeration value that indicates the new state.
    void CdromRipStateChange(IWMPCdromRip pCdromRip, WMPRipState wmprs);
    ///The <b>CdromRipMediaError</b> event occurs when an error happens while ripping an individual track from a CD.
    ///Params:
    ///    pCdromRip = Pointer to the <b>IWMPCdromRip</b> interface that represents the ripping operation that raised the error.
    ///    pMedia = Pointer to the <b>IDispatch</b> interface that represents the media item that raised the error. Call
    ///             <b>QueryInterface</b> through this pointer to retrieve a pointer to <b>IWMPMedia</b>.
    void CdromRipMediaError(IWMPCdromRip pCdromRip, IDispatch pMedia);
    ///The <b>CdromBurnStateChange</b> event occurs when a CD burning operation changes state.
    ///Params:
    ///    pCdromBurn = Pointer to the <b>IWMPCdromBurn</b> interface that represents the burning operation that raised the event.
    ///    wmpbs = <b>WMPBurnState</b> enumeration value that indicates the new state.
    void CdromBurnStateChange(IWMPCdromBurn pCdromBurn, WMPBurnState wmpbs);
    ///The <b>CdromBurnMediaError</b> event occurs when an error happens while burning an individual media item to a CD.
    ///Params:
    ///    pCdromBurn = Pointer to the <b>IWMPCdromBurn</b> interface that represents the burning operation that raised the error.
    ///    pMedia = Pointer to the <b>IDispatch</b> interface that represents the media item that raised the error. Call
    ///             <b>QueryInterface</b> through this pointer to retrieve a pointer to <b>IWMPMedia</b>.
    void CdromBurnMediaError(IWMPCdromBurn pCdromBurn, IDispatch pMedia);
    ///The <b>CdromBurnError</b> event occurs when a generic error happens during a CD burning operation.
    ///Params:
    ///    pCdromBurn = Pointer to the <b>IWMPCdromBurn</b> interface that represents the burning operation that raised the error.
    ///    hrError = <b>HRESULT</b> for the error that raised the event.
    void CdromBurnError(IWMPCdromBurn pCdromBurn, HRESULT hrError);
    ///The <b>LibraryConnect</b> event occurs when a library becomes available.
    ///Params:
    ///    pLibrary = Pointer to the <b>IWMPLibrary</b> interface that represents the library that connected.
    void LibraryConnect(IWMPLibrary pLibrary);
    ///The <b>LibraryDisconnect</b> event occurs when a library is no longer available.
    ///Params:
    ///    pLibrary = Pointer to the <b>IWMPLibrary</b> interface that represents the library that disconnected.
    void LibraryDisconnect(IWMPLibrary pLibrary);
    ///The <b>FolderScanStateChange</b> event occurs when a folder monitoring operation changes state.
    ///Params:
    ///    wmpfss = <b>WMPFolderScanState</b> enumeration value that indicates the new state.
    void FolderScanStateChange(WMPFolderScanState wmpfss);
    ///The <b>StringCollectionChange</b> event occurs when a string collection changes.
    ///Params:
    ///    pdispStringCollection = Pointer to the <b>IDispatch</b> interface that represents the string collection that changed. Call
    ///                            <b>QueryInterface</b> to retrieve a pointer to <b>IWMPStringCollection</b>.
    ///    change = WMPStringCollectionChangeEventType value indicating the type of change that occurred.
    ///    lCollectionIndex = The index of the string collection item that changed.
    void StringCollectionChange(IDispatch pdispStringCollection, WMPStringCollectionChangeEventType change, 
                                int lCollectionIndex);
    ///The <b>MediaCollectionMediaAdded</b> event occurs when a media item is added to the local library.
    ///Params:
    ///    pdispMedia = Pointer to the <b>IDispatch</b> interface that represents the media item added to the local library. Call
    ///                 <b>QueryInterface</b> to retrieve a pointer to <b>IWMPMedia</b>.
    void MediaCollectionMediaAdded(IDispatch pdispMedia);
    ///The <b>MediaCollectionMediaRemoved</b> event occurs when a media item is removed from the local library.
    ///Params:
    ///    pdispMedia = Pointer to the <b>IDispatch</b> interface that represents the media item removed from the local library. Call
    ///                 <b>QueryInterface</b> to retrieve a pointer to <b>IWMPMedia</b>.
    void MediaCollectionMediaRemoved(IDispatch pdispMedia);
}

///The IWMPEvents4 interface provides access to an event originating from the Windows Media Player 12 control so that an
///application that has this control embedded in it can respond to the event. The event exposed by <b>IWMPEvents4</b> is
///also exposed by the _WMPOCXEvents interface.
@GUID("26DABCFA-306B-404D-9A6F-630A8405048D")
interface IWMPEvents4 : IWMPEvents3
{
    void DeviceEstimation(IWMPSyncDevice pDevice, HRESULT hrResult, long qwEstimatedUsedSpace, 
                          long qwEstimatedSpace);
}

@GUID("6BF52A51-394A-11D3-B153-00C04F79FAA6")
interface _WMPOCXEvents : IDispatch
{
}

@GUID("42751198-5A50-4460-BCB4-709F8BDC8E59")
interface IWMPNodeRealEstate : IUnknown
{
    HRESULT GetDesiredSize(SIZE* pSize);
    HRESULT SetRects(const(RECT)* pSrc, const(RECT)* pDest, const(RECT)* pClip);
    HRESULT GetRects(RECT* pSrc, RECT* pDest, RECT* pClip);
    HRESULT SetWindowless(BOOL fWindowless);
    HRESULT GetWindowless(int* pfWindowless);
    HRESULT SetFullScreen(BOOL fFullScreen);
    HRESULT GetFullScreen(int* pfFullScreen);
}

@GUID("1491087D-2C6B-44C8-B019-B3C929D2ADA9")
interface IWMPNodeRealEstateHost : IUnknown
{
    HRESULT OnDesiredSizeChange(SIZE* pSize);
    HRESULT OnFullScreenTransition(BOOL fFullScreen);
}

@GUID("96740BFA-C56A-45D1-A3A4-762914D4ADE9")
interface IWMPNodeWindowed : IUnknown
{
    HRESULT SetOwnerWindow(ptrdiff_t hwnd);
    HRESULT GetOwnerWindow(ptrdiff_t* phwnd);
}

@GUID("A300415A-54AA-4081-ADBF-3B13610D8958")
interface IWMPNodeWindowedHost : IUnknown
{
    HRESULT OnWindowMessageFromRenderer(uint uMsg, WPARAM wparam, LPARAM lparam, LRESULT* plRet, int* pfHandled);
}

@GUID("3A0DAA30-908D-4789-BA87-AED879B5C49B")
interface IWMPWindowMessageSink : IUnknown
{
    HRESULT OnWindowMessage(uint uMsg, WPARAM wparam, LPARAM lparam, LRESULT* plRet, int* pfHandled);
}

@GUID("9B9199AD-780C-4EDA-B816-261EBA5D1575")
interface IWMPNodeWindowless : IWMPWindowMessageSink
{
    HRESULT OnDraw(ptrdiff_t hdc, const(RECT)* prcDraw);
}

@GUID("BE7017C6-CE34-4901-8106-770381AA6E3E")
interface IWMPNodeWindowlessHost : IUnknown
{
    HRESULT InvalidateRect(const(RECT)* prc, BOOL fErase);
}

///The <b>IWMPVideoRenderConfig</b> interface provides a method that configures the enhanced video renderer (EVR) used
///by Windows Media Player.
@GUID("6D6CF803-1EC0-4C8D-B3CA-F18E27282074")
interface IWMPVideoRenderConfig : IUnknown
{
    ///The <b>put_presenterActivate</b> method provides Windows Media Player with an activation object for a custom
    ///video presenter.
    ///Params:
    ///    pActivate = A pointer to an <b>IMFActivate</b> interface that Windows Media Player or another Windows component will use
    ///                to activate the custom video presenter.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_presenterActivate(IMFActivate pActivate);
}

///The <b>IWMPAudioRenderConfig</b> interface provides methods for setting and retrieving the audio output device used
///by the Windows Media Player ActiveX control.
@GUID("E79C6349-5997-4CE4-917C-22A3391EC564")
interface IWMPAudioRenderConfig : IUnknown
{
    ///The <b>get_audioOutputDevice</b> method retrieves the current audio output device used by the Windows Media
    ///Player ActiveX control.
    ///Params:
    ///    pbstrOutputDevice = An MMDeviceAPI device ID that represents the currently configured audio output device.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_audioOutputDevice(BSTR* pbstrOutputDevice);
    ///The <b>put_audioOutputDevice</b> sets the current audio output device for the Windows Media Player ActiveX
    ///control.
    ///Params:
    ///    bstrOutputDevice = An MMDeviceAPI device ID that represents the device. If you pass <b>NULL</b> or an empty <b>BSTR</b> to this
    ///                       method, the Windows Media Player ActiveX control reverts to the default audio output device.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_audioOutputDevice(BSTR bstrOutputDevice);
}

///The <b>IWMPRenderConfig</b> interface provides methods to specify or retrieve a value indicating whether Media
///Foundation–based playback is restricted to the current process. <div class="alert"><b>Note</b> Using this interface
///with protected content is not supported.</div> <div> </div>
@GUID("959506C1-0314-4EC5-9E61-8528DB5E5478")
interface IWMPRenderConfig : IUnknown
{
    ///The <b>put_inProcOnly</b> method specifies a value indicating whether playback is restricted to the current
    ///process.
    ///Params:
    ///    fInProc = <b>BOOL</b>, <b>TRUE</b> specifying that playback is restricted to the current process.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT put_inProcOnly(BOOL fInProc);
    ///The <b>get_inProcOnly</b> method retrieves a value indicating whether playback is restricted to the current
    ///process.
    ///Params:
    ///    pfInProc = Pointer to a <b>BOOL</b> that receives the result. <b>TRUE</b> specifies that playback is restricted to the
    ///               current process.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT get_inProcOnly(int* pfInProc);
}

///The <b>IWMPServices</b> interface is implemented by Windows Media Player. It provides methods to retrieve the current
///stream state and current stream time.
@GUID("AFB6B76B-1E20-4198-83B3-191DB6E0B149")
interface IWMPServices : IUnknown
{
    ///The <b>IWMPServices::GetStreamTime</b> method retrieves a structure indicating the current stream time.
    ///Params:
    ///    prt = Pointer to a <b>REFERENCE_TIME</b> structure.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>.
    ///    
    HRESULT GetStreamTime(long* prt);
    ///The <b>IWMPServices::GetStreamState</b> method retrieves information about the current play state of the stream.
    ///Params:
    ///    pState = A pointer to a <b>WMPServices_StreamState</b> enumeration value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>.
    ///    
    HRESULT GetStreamState(WMPServices_StreamState* pState);
}

///The <b>IWMPMediaPluginRegistrar</b> interface manages plug-in registration.
@GUID("68E27045-05BD-40B2-9720-23088C78E390")
interface IWMPMediaPluginRegistrar : IUnknown
{
    ///The <b>IWMPMediaPluginRegistrar::WMPRegisterPlayerPlugin</b> function adds information to the registry that
    ///identifies a Windows Media Player plug-in.
    ///Params:
    ///    pwszFriendlyName = Pointer to a wide character null-terminated string containing the friendly name of the plug-in. This is also
    ///                       the name that displays to the user.
    ///    pwszDescription = Pointer to a wide character null-terminated string containing the description of the plug-in. This
    ///                      information also displays to the user.
    ///    pwszUninstallString = Pointer to a wide character null-terminated string containing the uninstall string.
    ///    dwPriority = Integer value containing the priority position of the plug-in in the chain of currently enabled plug-ins.
    ///    guidPluginType = GUID specifying plug-in type. For DSP plug-ins, specify WMP_PLUGINTYPE_DSP to register for DirectShow
    ///                     playback and WMP_PLUGINTYPE_DSP_OUTOFPROC for Media Foundation playback. See Remarks.
    ///    clsid = The class ID of the plug-in.
    ///    cMediaTypes = Count of media types supported by the plug-in.
    ///    pMediaTypes = Pointer to an array of media types that enumerates the supported media types. Media types are stored as
    ///                  type/subtype pairs.
    ///Returns:
    ///    The function returns an <b>HRESULT</b>.
    ///    
    HRESULT WMPRegisterPlayerPlugin(const(wchar)* pwszFriendlyName, const(wchar)* pwszDescription, 
                                    const(wchar)* pwszUninstallString, uint dwPriority, GUID guidPluginType, 
                                    GUID clsid, uint cMediaTypes, void* pMediaTypes);
    ///The <b>IWMPMediaPluginRegistrar::WMPUnRegisterPlayerPlugin</b> function removes information from the registry
    ///about a Windows Media Player plug-in.
    ///Params:
    ///    guidPluginType = GUID specifying plug-in type. For DSP plug-ins, specify WMP_PLUGINTYPE_DSP to register for DirectShow
    ///                     playback and WMP_PLUGINTYPE_DSP_OUTOFPROC for Media Foundation playback. See Remarks.
    ///    clsid = Specifies the class ID of the plug-in being removed.
    ///Returns:
    ///    The function returns an <b>HRESULT</b>.
    ///    
    HRESULT WMPUnRegisterPlayerPlugin(GUID guidPluginType, GUID clsid);
}

///The <b>IWMPPlugin</b> interface is implemented by the plug-in. It manages the connection to Windows Media Player.
///<div class="alert"><b>Note</b> The interface identifier GUID for this interface changed between the beta release and
///the final release.</div> <div> </div>
@GUID("F1392A70-024C-42BB-A998-73DFDFE7D5A7")
interface IWMPPlugin : IUnknown
{
    ///The <b>IWMPPlugin::Init</b> method is called when Windows Media Player initializes the plug-in.
    ///Params:
    ///    dwPlaybackContext = DWORD value that indicates the particular Windows Media Player playback engine to which the plug-in belongs.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>.
    ///    
    HRESULT Init(size_t dwPlaybackContext);
    ///The <b>IWMPPlugin::Shutdown</b> method is called when Windows Media Player shuts down the plug-in.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>.
    ///    
    HRESULT Shutdown();
    ///The <b>IWMPPlugin::GetID</b> method returns the class id of the plug-in.
    ///Params:
    ///    pGUID = Pointer to a <b>GUID</b> that represents the class id of the plug-in.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>.
    ///    
    HRESULT GetID(GUID* pGUID);
    ///The <b>IWMPPlugin::GetCaps</b> method returns a flag that specifies whether the plug-in can convert between an
    ///input format and an output format.
    ///Params:
    ///    pdwFlags = Pointer to a variable that specifies whether the plug-in can convert formats. The specified value is a
    ///               bitwise combination of zero or more flags from the <b>WMPPlugin_Caps</b> enumeration.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>.
    ///    
    HRESULT GetCaps(uint* pdwFlags);
    ///The <b>IWMPPlugin::AdviseWMPServices</b> method is implemented by the plug-in.
    ///Params:
    ///    pWMPServices = Pointer to an <b>IWMPServices</b> interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>.
    ///    
    HRESULT AdviseWMPServices(IWMPServices pWMPServices);
    ///The <b>IWMPPlugin::UnAdviseWMPServices</b> method is used to release the pointer provided by
    ///<b>AdviseWMPServices</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>.
    ///    
    HRESULT UnAdviseWMPServices();
}

///The <b>IWMPPluginEnable</b> interface is implemented by the plug-in. It sets and retrieves a value that represents
///whether the plug-in has been enabled by Windows Media Player.
@GUID("5FCA444C-7AD1-479D-A4EF-40566A5309D6")
interface IWMPPluginEnable : IUnknown
{
    ///The <b>IWMPPluginEnable::SetEnable</b> method retrieves a value indicating whether user has enabled the plug-in.
    ///Params:
    ///    fEnable = A variable that receives a value indicating whether the user has enabled the plug-in.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>.
    ///    
    HRESULT SetEnable(BOOL fEnable);
    ///The <b>IWMPPluginEnable::GetEnable</b> method returns a value indicating whether Windows Media Player has enabled
    ///the plug-in.
    ///Params:
    ///    pfEnable = Pointer to a <b>Boolean</b> value indicating whether the user has enabled the plug-in.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>.
    ///    
    HRESULT GetEnable(int* pfEnable);
}

///The <b>IWMPGraphCreation</b> interface provides methods that Windows Media Player calls to enable you to manage the
///DirectShow filter graph. It can be implemented by an application that embeds the Windows Media Player control. The
///Windows Media Player control retrieves a pointer to this interface by calling <b>IServiceProvider::QueryService</b>.
///When you implement <b>IWMPGraphCreation</b>, you must also implement <b>IServiceProvider</b> and return the correct
///pointer when <b>QueryService</b> is called with IID_IWMPGraphCreation as the value for the second parameter. This
///interface is not supported when remoting the Windows Media Player control.
@GUID("BFB377E5-C594-4369-A970-DE896D5ECE74")
interface IWMPGraphCreation : IUnknown
{
    ///The <b>GraphCreationPreRender</b> method is called by Windows Media Player before a file is rendered.
    ///Params:
    ///    pFilterGraph = Pointer to the <b>IUnknown</b> interface of the Windows Media Player control's DirectShow filter graph.
    ///    pReserved = Reserved for future use.
    ///Returns:
    ///    Return a success <b>HRESULT</b> to allow playback to continue or a failure code to terminate playback.
    ///    
    HRESULT GraphCreationPreRender(IUnknown pFilterGraph, IUnknown pReserved);
    ///The <b>GraphCreationPostRender</b> method is called by Windows Media Player after a file has been rendered.
    ///Params:
    ///    pFilterGraph = Pointer to the <b>IUnknown</b> interface of the Windows Media Player control's DirectShow filter graph.
    ///Returns:
    ///    Return a success <b>HRESULT</b> code to allow playback to continue or a failure code to terminate playback.
    ///    
    HRESULT GraphCreationPostRender(IUnknown pFilterGraph);
    ///One of the flags documented on this page is available in Windows Media Player 10 and Windows Media Player 11
    ///running on Microsoft Windows XP. It might not be available in subsequent versions. The
    ///<b>GetGraphCreationFlags</b> method is called by Windows Media Player to retrieve a value that represents the
    ///graph creation preferences.
    ///Params:
    ///    pdwFlags = Address of a <b>DWORD</b> variable that receives a value that represents one or more graph creation flags
    ///               combined by using bitwise OR operations.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr> <td>S_OK</td> <td>The method
    ///    succeeded.</td> </tr> </table>
    ///    
    HRESULT GetGraphCreationFlags(uint* pdwFlags);
}

///The <b>IWMPConvert</b> interface provides methods to enable Windows Media Player conversion plug-ins to convert
///digital media files that are created using technologies not provided by Microsoft, into Advanced Systems Format
///(ASF).
@GUID("D683162F-57D4-4108-8373-4A9676D1C2E9")
interface IWMPConvert : IUnknown
{
    ///The <b>ConvertFile</b> method is implemented by a conversion plug-in and called by Windows Media Player to enable
    ///a conversion plug-in to convert a digital media file into ASF.
    ///Params:
    ///    bstrInputFile = <b>BSTR</b> containing the path to the file to be converted.
    ///    bstrDestinationFolder = <b>BSTR</b> containing that path to the folder where the converted file must be copied.
    ///    pbstrOutputFile = Pointer to a <b>BSTR</b> that receives the path to the converted file.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. The following table lists recommended return codes. <table> <tr>
    ///    <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_WMP_CONVERT_FILE_FAILED</b></dt> <dt>0xC00D1158</dt> </dl> </td> <td width="60%"> Unspecified
    ///    failure while converting the file. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_WMP_CONVERT_NO_RIGHTS_ERRORURL</b></dt> <dt>0xC00D1159</dt> </dl> </td> <td width="60%"> The
    ///    license prohibits file conversion. <b>IWMPConvert::GetErrorURL</b> must return the URL of the webpage that
    ///    describes the issue. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_WMP_CONVERT_NO_RIGHTS_NOERRORURL</b></dt> <dt>0xC00D115A</dt> </dl> </td> <td width="60%"> The
    ///    license prohibits file conversion. There is no error URL available. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_WMP_CONVERT_FILE_CORRUPT</b></dt> <dt>0xC00D115B</dt> </dl> </td> <td width="60%"> The specified
    ///    file is corrupted. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_WMP_CONVERT_PLUGIN_UNAVAILABLE_ERRORURL</b></dt> <dt>0xC00D115C</dt> </dl> </td> <td width="60%">
    ///    There is an unspecified problem with the plug-in. <b>IWMPConvert::GetErrorURL</b> must return the URL of the
    ///    webpage where the user can reinstall the plug-in. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>NS_E_WMP_CONVERT_PLUGIN_UNAVAILABLE_NOERRORURL</b></dt> <dt>0xC00D115D</dt> </dl> </td> <td
    ///    width="60%"> There is an unspecified problem with the plug-in. There is no error URL available. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>NS_E_WMP_CONVERT_PLUGIN_UNKNOWN_FILE_OWNER</b></dt> <dt>0xC00D115E</dt>
    ///    </dl> </td> <td width="60%"> This conversion plug-in is not the correct one to convert the current file.
    ///    </td> </tr> </table>
    ///    
    HRESULT ConvertFile(BSTR bstrInputFile, BSTR bstrDestinationFolder, BSTR* pbstrOutputFile);
    ///The <b>GetErrorURL</b> method is implemented by a conversion plug-in and called by Windows Media Player to
    ///retrieve the URL of a webpage that displays information to help the user correct the condition that caused an
    ///error.
    ///Params:
    ///    pbstrURL = Pointer to a <b>BSTR</b> that receives the URL of the webpage that displays the error information.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>.
    ///    
    HRESULT GetErrorURL(BSTR* pbstrURL);
}

///The <b>IWMPTranscodePolicy</b> interface provides a method implemented by DirectShow source filters to manage
///changing the format of digital media files.
@GUID("B64CBAC3-401C-4327-A3E8-B9FEB3A8C25C")
interface IWMPTranscodePolicy : IUnknown
{
    ///The <b>allowTranscode</b> method retrieves a value specifying whether Windows Media Player is permitted to change
    ///the format of the digital media content to the Windows Media format.
    ///Params:
    ///    pvbAllow = Pointer to a <b>VARIANT_BOOL</b> that contains a value indicating whether transcoding is permitted.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr> <td>S_OK</td> <td>The method
    ///    succeeded.</td> </tr> </table>
    ///    
    HRESULT allowTranscode(short* pvbAllow);
}

///The <b>IWMPUserEventSink</b> interface receives event notifications from a custom video presenter. An application
///that embeds the Windows Media Player control, and provides a custom video presenter, can implement the
///<b>IWMPUserEventSink</b> interface. The Windows Media Player control retrieves a pointer to the application's
///<b>IWMPUserEventSink</b> interface by calling <b>IServiceProvider::QueryService</b>, passing
///__uuidof(IWMPUserEventSink) in the <i>riid</i> parameter. Therefore, an application that implements the
///<b>IWMPUserEventSink</b> interface must also implement the <b>IServiceProvider</b> interface.
@GUID("CFCCFA72-C343-48C3-A2DE-B7A4402E39F2")
interface IWMPUserEventSink : IUnknown
{
    ///The <b>NotifyUserEvent</b> method notifies an application of an event generated by a custom video presenter that
    ///the application provided to the Enhanced Video Renderer (EVR).
    ///Params:
    ///    EventCode = An event code that is meaningful only to the application and the custom video renderer. The event code must
    ///                have a value greater than or equal to WMPUE_EC_USER, which is defined in wmpservices.h.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr> <td>S_OK</td> <td>The method
    ///    succeeded.</td> </tr> </table>
    ///    
    HRESULT NotifyUserEvent(int EventCode);
}

@GUID("5357E238-FB12-4ACA-A930-CAB7832B84BF")
interface IXFeedsManager : IUnknown
{
    HRESULT RootFolder(const(GUID)* riid, void** ppv);
    HRESULT IsSubscribed(const(wchar)* pszUrl, int* pbSubscribed);
    HRESULT ExistsFeed(const(wchar)* pszPath, int* pbFeedExists);
    HRESULT GetFeed(const(wchar)* pszPath, const(GUID)* riid, void** ppv);
    HRESULT GetFeedByUrl(const(wchar)* pszUrl, const(GUID)* riid, void** ppv);
    HRESULT ExistsFolder(const(wchar)* pszPath, int* pbFolderExists);
    HRESULT GetFolder(const(wchar)* pszPath, const(GUID)* riid, void** ppv);
    HRESULT DeleteFeed(const(wchar)* pszPath);
    HRESULT DeleteFolder(const(wchar)* pszPath);
    HRESULT BackgroundSync(FEEDS_BACKGROUNDSYNC_ACTION fbsa);
    HRESULT BackgroundSyncStatus(FEEDS_BACKGROUNDSYNC_STATUS* pfbss);
    HRESULT DefaultInterval(uint* puiInterval);
    HRESULT SetDefaultInterval(uint uiInterval);
    HRESULT AsyncSyncAll();
    HRESULT Normalize(IStream pStreamIn, IStream* ppStreamOut);
    HRESULT ItemCountLimit(uint* puiItemCountLimit);
}

@GUID("DC43A9D5-5015-4301-8C96-A47434B4D658")
interface IXFeedsEnum : IUnknown
{
    HRESULT Count(uint* puiCount);
    HRESULT Item(uint uiIndex, const(GUID)* riid, void** ppv);
}

@GUID("4C963678-3A51-4B88-8531-98B90B6508F2")
interface IXFeedFolder : IUnknown
{
    HRESULT Feeds(IXFeedsEnum* ppfe);
    HRESULT Subfolders(IXFeedsEnum* ppfe);
    HRESULT CreateFeed(const(wchar)* pszName, const(wchar)* pszUrl, const(GUID)* riid, void** ppv);
    HRESULT CreateSubfolder(const(wchar)* pszName, const(GUID)* riid, void** ppv);
    HRESULT ExistsFeed(const(wchar)* pszName, int* pbFeedExists);
    HRESULT ExistsSubfolder(const(wchar)* pszName, int* pbSubfolderExists);
    HRESULT GetFeed(const(wchar)* pszName, const(GUID)* riid, void** ppv);
    HRESULT GetSubfolder(const(wchar)* pszName, const(GUID)* riid, void** ppv);
    HRESULT Delete();
    HRESULT Name(ushort** ppszName);
    HRESULT Rename(const(wchar)* pszName);
    HRESULT Path(ushort** ppszPath);
    HRESULT Move(const(wchar)* pszPath);
    HRESULT Parent(const(GUID)* riid, void** ppv);
    HRESULT IsRoot(int* pbIsRootFeedFolder);
    HRESULT GetWatcher(FEEDS_EVENTS_SCOPE scope_, FEEDS_EVENTS_MASK mask, const(GUID)* riid, void** ppv);
    HRESULT TotalUnreadItemCount(uint* puiTotalUnreadItemCount);
    HRESULT TotalItemCount(uint* puiTotalItemCount);
}

@GUID("7964B769-234A-4BB1-A5F4-90454C8AD07E")
interface IXFeedFolderEvents : IUnknown
{
    HRESULT Error();
    HRESULT FolderAdded(const(wchar)* pszPath);
    HRESULT FolderDeleted(const(wchar)* pszPath);
    HRESULT FolderRenamed(const(wchar)* pszPath, const(wchar)* pszOldPath);
    HRESULT FolderMovedFrom(const(wchar)* pszPath, const(wchar)* pszOldPath);
    HRESULT FolderMovedTo(const(wchar)* pszPath, const(wchar)* pszOldPath);
    HRESULT FolderItemCountChanged(const(wchar)* pszPath, int feicfFlags);
    HRESULT FeedAdded(const(wchar)* pszPath);
    HRESULT FeedDeleted(const(wchar)* pszPath);
    HRESULT FeedRenamed(const(wchar)* pszPath, const(wchar)* pszOldPath);
    HRESULT FeedUrlChanged(const(wchar)* pszPath);
    HRESULT FeedMovedFrom(const(wchar)* pszPath, const(wchar)* pszOldPath);
    HRESULT FeedMovedTo(const(wchar)* pszPath, const(wchar)* pszOldPath);
    HRESULT FeedDownloading(const(wchar)* pszPath);
    HRESULT FeedDownloadCompleted(const(wchar)* pszPath, FEEDS_DOWNLOAD_ERROR fde);
    HRESULT FeedItemCountChanged(const(wchar)* pszPath, int feicfFlags);
}

@GUID("A44179A4-E0F6-403B-AF8D-D080F425A451")
interface IXFeed : IUnknown
{
    HRESULT Xml(uint uiItemCount, FEEDS_XML_SORT_PROPERTY sortProperty, FEEDS_XML_SORT_ORDER sortOrder, 
                FEEDS_XML_FILTER_FLAGS filterFlags, FEEDS_XML_INCLUDE_FLAGS includeFlags, IStream* pps);
    HRESULT Name(ushort** ppszName);
    HRESULT Rename(const(wchar)* pszName);
    HRESULT Url(ushort** ppszUrl);
    HRESULT SetUrl(const(wchar)* pszUrl);
    HRESULT LocalId(GUID* pguid);
    HRESULT Path(ushort** ppszPath);
    HRESULT Move(const(wchar)* pszPath);
    HRESULT Parent(const(GUID)* riid, void** ppv);
    HRESULT LastWriteTime(SYSTEMTIME* pstLastWriteTime);
    HRESULT Delete();
    HRESULT Download();
    HRESULT AsyncDownload();
    HRESULT CancelAsyncDownload();
    HRESULT SyncSetting(FEEDS_SYNC_SETTING* pfss);
    HRESULT SetSyncSetting(FEEDS_SYNC_SETTING fss);
    HRESULT Interval(uint* puiInterval);
    HRESULT SetInterval(uint uiInterval);
    HRESULT LastDownloadTime(SYSTEMTIME* pstLastDownloadTime);
    HRESULT LocalEnclosurePath(ushort** ppszPath);
    HRESULT Items(IXFeedsEnum* ppfe);
    HRESULT GetItem(uint uiId, const(GUID)* riid, void** ppv);
    HRESULT MarkAllItemsRead();
    HRESULT MaxItemCount(uint* puiMaxItemCount);
    HRESULT SetMaxItemCount(uint uiMaxItemCount);
    HRESULT DownloadEnclosuresAutomatically(int* pbDownloadEnclosuresAutomatically);
    HRESULT SetDownloadEnclosuresAutomatically(BOOL bDownloadEnclosuresAutomatically);
    HRESULT DownloadStatus(FEEDS_DOWNLOAD_STATUS* pfds);
    HRESULT LastDownloadError(FEEDS_DOWNLOAD_ERROR* pfde);
    HRESULT Merge(IStream pStream, const(wchar)* pszUrl);
    HRESULT DownloadUrl(ushort** ppszUrl);
    HRESULT Title(ushort** ppszTitle);
    HRESULT Description(ushort** ppszDescription);
    HRESULT Link(ushort** ppszHomePage);
    HRESULT Image(ushort** ppszImageUrl);
    HRESULT LastBuildDate(SYSTEMTIME* pstLastBuildDate);
    HRESULT PubDate(SYSTEMTIME* pstPubDate);
    HRESULT Ttl(uint* puiTtl);
    HRESULT Language(ushort** ppszLanguage);
    HRESULT Copyright(ushort** ppszCopyright);
    HRESULT IsList(int* pbIsList);
    HRESULT GetWatcher(FEEDS_EVENTS_SCOPE scope_, FEEDS_EVENTS_MASK mask, const(GUID)* riid, void** ppv);
    HRESULT UnreadItemCount(uint* puiUnreadItemCount);
    HRESULT ItemCount(uint* puiItemCount);
}

@GUID("CE528E77-3716-4EB7-956D-F5E37502E12A")
interface IXFeed2 : IXFeed
{
    HRESULT GetItemByEffectiveId(uint uiEffectiveId, const(GUID)* riid, void** ppv);
    HRESULT LastItemDownloadTime(SYSTEMTIME* pstLastItemDownloadTime);
    HRESULT Username(ushort** ppszUsername);
    HRESULT Password(ushort** ppszPassword);
    HRESULT SetCredentials(const(wchar)* pszUsername, const(wchar)* pszPassword);
    HRESULT ClearCredentials();
}

@GUID("1630852E-1263-465B-98E5-FE60FFEC4AC2")
interface IXFeedEvents : IUnknown
{
    HRESULT Error();
    HRESULT FeedDeleted(const(wchar)* pszPath);
    HRESULT FeedRenamed(const(wchar)* pszPath, const(wchar)* pszOldPath);
    HRESULT FeedUrlChanged(const(wchar)* pszPath);
    HRESULT FeedMoved(const(wchar)* pszPath, const(wchar)* pszOldPath);
    HRESULT FeedDownloading(const(wchar)* pszPath);
    HRESULT FeedDownloadCompleted(const(wchar)* pszPath, FEEDS_DOWNLOAD_ERROR fde);
    HRESULT FeedItemCountChanged(const(wchar)* pszPath, int feicfFlags);
}

@GUID("E757B2F5-E73E-434E-A1BF-2BD7C3E60FCB")
interface IXFeedItem : IUnknown
{
    HRESULT Xml(FEEDS_XML_INCLUDE_FLAGS fxif, IStream* pps);
    HRESULT Title(ushort** ppszTitle);
    HRESULT Link(ushort** ppszUrl);
    HRESULT Guid(ushort** ppszGuid);
    HRESULT Description(ushort** ppszDescription);
    HRESULT PubDate(SYSTEMTIME* pstPubDate);
    HRESULT Comments(ushort** ppszUrl);
    HRESULT Author(ushort** ppszAuthor);
    HRESULT Enclosure(const(GUID)* riid, void** ppv);
    HRESULT IsRead(int* pbIsRead);
    HRESULT SetIsRead(BOOL bIsRead);
    HRESULT LocalId(uint* puiId);
    HRESULT Parent(const(GUID)* riid, void** ppv);
    HRESULT Delete();
    HRESULT DownloadUrl(ushort** ppszUrl);
    HRESULT LastDownloadTime(SYSTEMTIME* pstLastDownloadTime);
    HRESULT Modified(SYSTEMTIME* pstModifiedTime);
}

@GUID("6CDA2DC7-9013-4522-9970-2A9DD9EAD5A3")
interface IXFeedItem2 : IXFeedItem
{
    HRESULT EffectiveId(uint* puiEffectiveId);
}

@GUID("BFBFB953-644F-4792-B69C-DFACA4CBF89A")
interface IXFeedEnclosure : IUnknown
{
    HRESULT Url(ushort** ppszUrl);
    HRESULT Type(ushort** ppszMimeType);
    HRESULT Length(uint* puiLength);
    HRESULT AsyncDownload();
    HRESULT CancelAsyncDownload();
    HRESULT DownloadStatus(FEEDS_DOWNLOAD_STATUS* pfds);
    HRESULT LastDownloadError(FEEDS_DOWNLOAD_ERROR* pfde);
    HRESULT LocalPath(ushort** ppszPath);
    HRESULT Parent(const(GUID)* riid, void** ppv);
    HRESULT DownloadUrl(ushort** ppszUrl);
    HRESULT DownloadMimeType(ushort** ppszMimeType);
    HRESULT RemoveFile();
    HRESULT SetFile(const(wchar)* pszDownloadUrl, const(wchar)* pszDownloadFilePath, 
                    const(wchar)* pszDownloadMimeType, const(wchar)* pszEnclosureFilename);
}

@GUID("A74029CC-1F1A-4906-88F0-810638D86591")
interface IFeedsManager : IDispatch
{
    HRESULT get_RootFolder(IDispatch* disp);
    HRESULT IsSubscribed(BSTR feedUrl, short* subscribed);
    HRESULT ExistsFeed(BSTR feedPath, short* exists);
    HRESULT GetFeed(BSTR feedPath, IDispatch* disp);
    HRESULT GetFeedByUrl(BSTR feedUrl, IDispatch* disp);
    HRESULT ExistsFolder(BSTR folderPath, short* exists);
    HRESULT GetFolder(BSTR folderPath, IDispatch* disp);
    HRESULT DeleteFeed(BSTR feedPath);
    HRESULT DeleteFolder(BSTR folderPath);
    HRESULT BackgroundSync(FEEDS_BACKGROUNDSYNC_ACTION action);
    HRESULT get_BackgroundSyncStatus(FEEDS_BACKGROUNDSYNC_STATUS* status);
    HRESULT get_DefaultInterval(int* minutes);
    HRESULT put_DefaultInterval(int minutes);
    HRESULT AsyncSyncAll();
    HRESULT Normalize(BSTR feedXmlIn, BSTR* feedXmlOut);
    HRESULT get_ItemCountLimit(int* itemCountLimit);
}

@GUID("E3CD0028-2EED-4C60-8FAE-A3225309A836")
interface IFeedsEnum : IDispatch
{
    HRESULT get_Count(int* count);
    HRESULT Item(int index, IDispatch* disp);
    HRESULT get__NewEnum(IEnumVARIANT* enumVar);
}

@GUID("81F04AD1-4194-4D7D-86D6-11813CEC163C")
interface IFeedFolder : IDispatch
{
    HRESULT get_Feeds(IDispatch* disp);
    HRESULT get_Subfolders(IDispatch* disp);
    HRESULT CreateFeed(BSTR feedName, BSTR feedUrl, IDispatch* disp);
    HRESULT CreateSubfolder(BSTR folderName, IDispatch* disp);
    HRESULT ExistsFeed(BSTR feedName, short* exists);
    HRESULT GetFeed(BSTR feedName, IDispatch* disp);
    HRESULT ExistsSubfolder(BSTR folderName, short* exists);
    HRESULT GetSubfolder(BSTR folderName, IDispatch* disp);
    HRESULT Delete();
    HRESULT get_Name(BSTR* folderName);
    HRESULT Rename(BSTR folderName);
    HRESULT get_Path(BSTR* folderPath);
    HRESULT Move(BSTR newParentPath);
    HRESULT get_Parent(IDispatch* disp);
    HRESULT get_IsRoot(short* isRoot);
    HRESULT get_TotalUnreadItemCount(int* count);
    HRESULT get_TotalItemCount(int* count);
    HRESULT GetWatcher(FEEDS_EVENTS_SCOPE scope_, FEEDS_EVENTS_MASK mask, IDispatch* disp);
}

@GUID("20A59FA6-A844-4630-9E98-175F70B4D55B")
interface IFeedFolderEvents : IDispatch
{
    HRESULT Error();
    HRESULT FolderAdded(const(ushort)* path);
    HRESULT FolderDeleted(const(ushort)* path);
    HRESULT FolderRenamed(const(ushort)* path, const(ushort)* oldPath);
    HRESULT FolderMovedFrom(const(ushort)* path, const(ushort)* oldPath);
    HRESULT FolderMovedTo(const(ushort)* path, const(ushort)* oldPath);
    HRESULT FolderItemCountChanged(const(ushort)* path, int itemCountType);
    HRESULT FeedAdded(const(ushort)* path);
    HRESULT FeedDeleted(const(ushort)* path);
    HRESULT FeedRenamed(const(ushort)* path, const(ushort)* oldPath);
    HRESULT FeedUrlChanged(const(ushort)* path);
    HRESULT FeedMovedFrom(const(ushort)* path, const(ushort)* oldPath);
    HRESULT FeedMovedTo(const(ushort)* path, const(ushort)* oldPath);
    HRESULT FeedDownloading(const(ushort)* path);
    HRESULT FeedDownloadCompleted(const(ushort)* path, FEEDS_DOWNLOAD_ERROR error);
    HRESULT FeedItemCountChanged(const(ushort)* path, int itemCountType);
}

@GUID("F7F915D8-2EDE-42BC-98E7-A5D05063A757")
interface IFeed : IDispatch
{
    HRESULT Xml(int count, FEEDS_XML_SORT_PROPERTY sortProperty, FEEDS_XML_SORT_ORDER sortOrder, 
                FEEDS_XML_FILTER_FLAGS filterFlags, FEEDS_XML_INCLUDE_FLAGS includeFlags, BSTR* xml);
    HRESULT get_Name(BSTR* name);
    HRESULT Rename(BSTR name);
    HRESULT get_Url(BSTR* feedUrl);
    HRESULT put_Url(BSTR feedUrl);
    HRESULT get_LocalId(BSTR* feedGuid);
    HRESULT get_Path(BSTR* path);
    HRESULT Move(BSTR newParentPath);
    HRESULT get_Parent(IDispatch* disp);
    HRESULT get_LastWriteTime(double* lastWrite);
    HRESULT Delete();
    HRESULT Download();
    HRESULT AsyncDownload();
    HRESULT CancelAsyncDownload();
    HRESULT get_SyncSetting(FEEDS_SYNC_SETTING* syncSetting);
    HRESULT put_SyncSetting(FEEDS_SYNC_SETTING syncSetting);
    HRESULT get_Interval(int* minutes);
    HRESULT put_Interval(int minutes);
    HRESULT get_LastDownloadTime(double* lastDownload);
    HRESULT get_LocalEnclosurePath(BSTR* path);
    HRESULT get_Items(IDispatch* disp);
    HRESULT GetItem(int itemId, IDispatch* disp);
    HRESULT get_Title(BSTR* title);
    HRESULT get_Description(BSTR* description);
    HRESULT get_Link(BSTR* homePage);
    HRESULT get_Image(BSTR* imageUrl);
    HRESULT get_LastBuildDate(double* lastBuildDate);
    HRESULT get_PubDate(double* lastPopulateDate);
    HRESULT get_Ttl(int* ttl);
    HRESULT get_Language(BSTR* language);
    HRESULT get_Copyright(BSTR* copyright);
    HRESULT get_MaxItemCount(int* count);
    HRESULT put_MaxItemCount(int count);
    HRESULT get_DownloadEnclosuresAutomatically(short* downloadEnclosuresAutomatically);
    HRESULT put_DownloadEnclosuresAutomatically(short downloadEnclosuresAutomatically);
    HRESULT get_DownloadStatus(FEEDS_DOWNLOAD_STATUS* status);
    HRESULT get_LastDownloadError(FEEDS_DOWNLOAD_ERROR* error);
    HRESULT Merge(BSTR feedXml, BSTR feedUrl);
    HRESULT get_DownloadUrl(BSTR* feedUrl);
    HRESULT get_IsList(short* isList);
    HRESULT MarkAllItemsRead();
    HRESULT GetWatcher(FEEDS_EVENTS_SCOPE scope_, FEEDS_EVENTS_MASK mask, IDispatch* disp);
    HRESULT get_UnreadItemCount(int* count);
    HRESULT get_ItemCount(int* count);
}

@GUID("33F2EA09-1398-4AB9-B6A4-F94B49D0A42E")
interface IFeed2 : IFeed
{
    HRESULT GetItemByEffectiveId(int itemEffectiveId, IDispatch* disp);
    HRESULT get_LastItemDownloadTime(double* lastItemDownloadTime);
    HRESULT get_Username(BSTR* username);
    HRESULT get_Password(BSTR* password);
    HRESULT SetCredentials(BSTR username, BSTR password);
    HRESULT ClearCredentials();
}

@GUID("ABF35C99-0681-47EA-9A8C-1436A375A99E")
interface IFeedEvents : IDispatch
{
    HRESULT Error();
    HRESULT FeedDeleted(const(ushort)* path);
    HRESULT FeedRenamed(const(ushort)* path, const(ushort)* oldPath);
    HRESULT FeedUrlChanged(const(ushort)* path);
    HRESULT FeedMoved(const(ushort)* path, const(ushort)* oldPath);
    HRESULT FeedDownloading(const(ushort)* path);
    HRESULT FeedDownloadCompleted(const(ushort)* path, FEEDS_DOWNLOAD_ERROR error);
    HRESULT FeedItemCountChanged(const(ushort)* path, int itemCountType);
}

@GUID("0A1E6CAD-0A47-4DA2-A13D-5BAAA5C8BD4F")
interface IFeedItem : IDispatch
{
    HRESULT Xml(FEEDS_XML_INCLUDE_FLAGS includeFlags, BSTR* xml);
    HRESULT get_Title(BSTR* title);
    HRESULT get_Link(BSTR* linkUrl);
    HRESULT get_Guid(BSTR* itemGuid);
    HRESULT get_Description(BSTR* description);
    HRESULT get_PubDate(double* pubDate);
    HRESULT get_Comments(BSTR* comments);
    HRESULT get_Author(BSTR* author);
    HRESULT get_Enclosure(IDispatch* disp);
    HRESULT get_IsRead(short* isRead);
    HRESULT put_IsRead(short isRead);
    HRESULT get_LocalId(int* itemId);
    HRESULT get_Parent(IDispatch* disp);
    HRESULT Delete();
    HRESULT get_DownloadUrl(BSTR* itemUrl);
    HRESULT get_LastDownloadTime(double* lastDownload);
    HRESULT get_Modified(double* modified);
}

@GUID("79AC9EF4-F9C1-4D2B-A50B-A7FFBA4DCF37")
interface IFeedItem2 : IFeedItem
{
    HRESULT get_EffectiveId(int* effectiveId);
}

@GUID("361C26F7-90A4-4E67-AE09-3A36A546436A")
interface IFeedEnclosure : IDispatch
{
    HRESULT get_Url(BSTR* enclosureUrl);
    HRESULT get_Type(BSTR* mimeType);
    HRESULT get_Length(int* length);
    HRESULT AsyncDownload();
    HRESULT CancelAsyncDownload();
    HRESULT get_DownloadStatus(FEEDS_DOWNLOAD_STATUS* status);
    HRESULT get_LastDownloadError(FEEDS_DOWNLOAD_ERROR* error);
    HRESULT get_LocalPath(BSTR* localPath);
    HRESULT get_Parent(IDispatch* disp);
    HRESULT get_DownloadUrl(BSTR* enclosureUrl);
    HRESULT get_DownloadMimeType(BSTR* mimeType);
    HRESULT RemoveFile();
    HRESULT SetFile(BSTR downloadUrl, BSTR downloadFilePath, BSTR downloadMimeType, BSTR enclosureFilename);
}

///The IWMPEffects interface.
@GUID("D3984C13-C3CB-48E2-8BE5-5168340B4F35")
interface IWMPEffects : IUnknown
{
    ///The <b>Render</b> method renders the visualization.
    ///Params:
    ///    pLevels = Pointer to a <b>TimedLevel</b> structure.
    ///    hdc = Specifies a handle to a device context.
    ///    prc = Specifies the rectangle the visualization is to be rendered in.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Render(TimedLevel* pLevels, HDC hdc, RECT* prc);
    ///The <b>MediaInfo</b> method sends channel and sample rate data to the visualization.
    ///Params:
    ///    lChannelCount = <b>Long</b> integer containing the number of channels (one for mono, or two for stereo).
    ///    lSampleRate = <b>Long</b> integer containing the sample rate in hertz (Hz). For example, a value of 22500 would specify a
    ///                  rate of 22.5KHz.
    ///    bstrTitle = <b>String</b> specifying the title.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT MediaInfo(int lChannelCount, int lSampleRate, BSTR bstrTitle);
    ///The <b>GetCapabilities</b> method gets the capabilities of the visualization.
    ///Params:
    ///    pdwCapabilities = <b>DWORD</b> containing the capabilities. The current values are as follows. <table> <tr> <th>Value </th>
    ///                      <th>Description </th> </tr> <tr> <td><b>EFFECT_CANGOFULLSCREEN</b> = 0x00000001;</td> <td>The visualization
    ///                      is capable of full-screen rendering.</td> </tr> <tr> <td><b>EFFECT_HASPROPERTYPAGE</b> = 0x00000002;</td>
    ///                      <td>The visualization has a property page.</td> </tr> <tr> <td><b>EFFECT_VARIABLEFREQSTEP</b> =
    ///                      0x00000004;</td> <td>The visualization will use frequency data with variable size steps. If this bit is set,
    ///                      step size is based on the media sampling frequency divided by BUFFER_SIZE. If this bit is not set and media
    ///                      is played that was sampled at a low frequency, the upper cells will be empty. For example, if an 8KHz sampled
    ///                      file is played and this bit is not set, the upper half of the frequency array (from 8KHz to 22KHz) will be
    ///                      empty. If this bit is set and an 8Khz sampled file is played, the frequency array will range from 20Hz to
    ///                      8KHz in BUFFER_SIZE steps.</td> </tr> <tr> <td><b>EFFECT_WINDOWED_ONLY</b> = 0x00000008</td> <td>The
    ///                      visualization only renders in windowed mode.</td> </tr> <tr> <td><b>EFFECT2_FULLSCREENEXCLUSIVE</b> =
    ///                      0x00000010</td> <td>The visualization uses exclusive mode when rendering full-screen. The Player will not
    ///                      resize the window to fill the screen. The visualization must create a top level window and handle resolution
    ///                      switching.</td> </tr> </table>
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCapabilities(uint* pdwCapabilities);
    ///The <b>GetTitle</b> method gets the display title of the visualization.
    ///Params:
    ///    bstrTitle = <b>String</b> containing the title.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetTitle(BSTR* bstrTitle);
    ///The <b>GetPresetTitle</b> method gets the title of the current preset.
    ///Params:
    ///    nPreset = <b>Long</b> preset number.
    ///    bstrPresetTitle = <b>BSTR</b> preset title.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetPresetTitle(int nPreset, BSTR* bstrPresetTitle);
    ///The <b>GetPresetCount</b> method gets the preset count.
    ///Params:
    ///    pnPresetCount = <b>Long</b> value specifying the preset count.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetPresetCount(int* pnPresetCount);
    ///The <b>SetCurrentPreset</b> method gets the current preset from Windows Media Player and sets it in the
    ///visualization.
    ///Params:
    ///    nPreset = <b>Long</b> value specifying the new preset index.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetCurrentPreset(int nPreset);
    ///The <b>GetCurrentPreset</b> method gets the current preset, by number, from the visualization and provides it to
    ///Windows Media Player.
    ///Params:
    ///    pnPreset = <b>Long</b> value specifying the current preset, by number.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCurrentPreset(int* pnPreset);
    ///The <b>DisplayPropertyPage</b> method displays the property page of a visualization, if it exists.
    ///Params:
    ///    hwndOwner = Handle to the dialog that will be displayed.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT DisplayPropertyPage(HWND hwndOwner);
    ///The <b>GoFullscreen</b> method instructs the visualization to switch to full-screen mode.
    ///Params:
    ///    fFullScreen = <b>Boolean</b> indicating whether to switch to full-screen mode.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If it fails, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GoFullscreen(BOOL fFullScreen);
    ///The <b>RenderFullScreen</b> method renders the visualization in full-screen mode.
    ///Params:
    ///    pLevels = Pointer to a <b>TimedLevel</b> structure.
    ///Returns:
    ///    If the method succeeds, your implementation should return S_OK. If it fails, return an <b>HRESULT</b> error
    ///    code.
    ///    
    HRESULT RenderFullScreen(TimedLevel* pLevels);
}

///The IWMPEffects2 interface.
@GUID("695386EC-AA3C-4618-A5E1-DD9A8B987632")
interface IWMPEffects2 : IWMPEffects
{
    ///The <b>SetCore</b> method is called by Windows Media Player to provide visualization access to the core Windows
    ///Media Player APIs.
    ///Params:
    ///    pPlayer = Pointer to an <b>IWMPCore</b> interface.
    ///Returns:
    ///    This method returns an <b>HRESULT</b>.
    ///    
    HRESULT SetCore(IWMPCore pPlayer);
    ///The <b>Create</b> method is called by Windows Media Player to instantiate a visualization window.
    ///Params:
    ///    hwndParent = <b>HWND</b> handle to the parent window hosting the visualization window.
    ///Returns:
    ///    This method returns an <b>HRESULT</b>.
    ///    
    HRESULT Create(HWND hwndParent);
    ///The <b>Destroy</b> method is called by Windows Media Player to destroy a visualization window instantiated in the
    ///<b>Create</b> method.
    ///Returns:
    ///    This method returns an <b>HRESULT</b>.
    ///    
    HRESULT Destroy();
    ///The <b>NotifyNewMedia</b> method is called by Windows Media Player to inform the visualization that a new media
    ///item has been loaded.
    ///Params:
    ///    pMedia = Pointer to an <b>IWMPMedia</b> interface that represents the new media item.
    ///Returns:
    ///    This method returns an <b>HRESULT</b>.
    ///    
    HRESULT NotifyNewMedia(IWMPMedia pMedia);
    ///The <b>OnWindowMessage</b> method is called by Windows Media Player to pass window messages to a visualization.
    ///Params:
    ///    msg = <b>UINT</b> that identifies the window message.
    ///    WParam = <b>WPARAM</b> specifying a window message parameter.
    ///    LParam = <b>LPARAM</b> specifying a window message parameter.
    ///    plResultParam = Pointer to an <b>LRESULT</b> specifying the result code for the window message.
    ///Returns:
    ///    This method returns an <b>HRESULT</b>.
    ///    
    HRESULT OnWindowMessage(uint msg, WPARAM WParam, LPARAM LParam, LRESULT* plResultParam);
    ///The <b>RenderWindowed</b> method is called by Windows Media Player to render a windowed visualization.
    ///Params:
    ///    pData = Pointer to a <b>TimedLevel</b> structure specifying rendering information.
    ///    fRequiredRender = <b>BOOL</b> indicating whether the visualization must paint itself.
    ///Returns:
    ///    This method returns an <b>HRESULT</b>.
    ///    
    HRESULT RenderWindowed(TimedLevel* pData, BOOL fRequiredRender);
}

///The <b>IWMPPluginUI</b> interface manages the connection to Windows Media Player.
@GUID("4C5E8F9F-AD3E-4BF9-9753-FCD30D6D38DD")
interface IWMPPluginUI : IUnknown
{
    ///The <b>SetCore</b> method is called by Windows Media Player to provide plug-in access to the core Windows Media
    ///Player APIs.
    ///Params:
    ///    pCore = Pointer to an <b>IWMPCore</b> interface.
    ///Returns:
    ///    This method returns an <b>HRESULT</b>.
    ///    
    HRESULT SetCore(IWMPCore pCore);
    ///The <b>Create</b> method is called by Windows Media Player to instantiate the plug-in user interface. This method
    ///is passed a handle to a parent window of the plug-in window. A handle to the newly created window is then passed
    ///back to the calling method.
    ///Params:
    ///    hwndParent = <b>HWND</b> handle to a parent window of the plug-in window.
    ///    phwndWindow = Pointer to an <b>HWND</b> handle to the plug-in window after the content is filled in.
    ///Returns:
    ///    This method returns an <b>HRESULT</b>.
    ///    
    HRESULT Create(HWND hwndParent, HWND* phwndWindow);
    ///The <b>Destroy</b> method is called by Windows Media Player to shut down the plug-in user interface. This occurs
    ///when the user closes a plug-in in a separate window, switches out of the <b>Now Playing</b> pane, or selects a
    ///different display, settings, or metadata area plug-in to display in the <b>Now Playing</b> pane.
    ///Returns:
    ///    This method returns an <b>HRESULT</b>.
    ///    
    HRESULT Destroy();
    ///The <b>DisplayPropertyPage</b> method is called by Windows Media Player to request that the plug-in display its
    ///property page. This method is passed a handle to a parent window of the plug-in property page dialog box.
    ///Params:
    ///    hwndParent = <b>HWND</b> handle to a parent window of the property page dialog box.
    ///Returns:
    ///    This method returns an <b>HRESULT</b>.
    ///    
    HRESULT DisplayPropertyPage(HWND hwndParent);
    ///The <b>GetProperty</b> method is called by Windows Media Player to retrieve name/value property pairs from the
    ///plug-in.
    ///Params:
    ///    pwszName = Pointer to a <b>WCHAR</b><b>NULL</b>-terminated string constant containing the name of the property. Contains
    ///               one of the following values: <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr>
    ///               <td>PLUGIN_MISC_CURRENTPRESET = L"CurrentPreset"</td> <td>The out parameter is set to a <b>Long</b>
    ///               (<b>VT_I4</b>) value containing the index of the current preset. This property is requested only for plug-ins
    ///               that have presets.</td> </tr> <tr> <td>PLUGIN_MISC_PRESETCOUNT = L"PresetCount"</td> <td>The out parameter is
    ///               set to a <b>Long</b> (<b>VT_I4</b>) value indicating the number of presets available in the plug-in. This
    ///               property is requested only for plug-ins that have presets.</td> </tr> <tr> <td>PLUGIN_MISC_PRESETNAMES =
    ///               L"PresetNames"</td> <td>The out parameter is set to an array of <b>BSTR</b> (<b>VT_ARRAY</b> | <b>BSTR</b>)
    ///               values containing the names of the presets. This property is requested only for plug-ins that have
    ///               presets.</td> </tr> <tr> <td>PLUGIN_MISC_QUERYDESTROY = L"QueryDestroy"</td> <td>The out parameter is set to
    ///               a <b>BSTR</b> (<b>VT_BSTR</b>) value that is displayed to the user when Windows Media Player attempts to
    ///               close a separate window or background plug-in that is engaged in operations that cannot be interrupted.</td>
    ///               </tr> <tr> <td>PLUGIN_SEPARATEWINDOW_DEFAULTHEIGHT = L"DefaultHeight"</td> <td>The out parameter is set to a
    ///               <b>Long</b> (<b>VT_I4</b>) value indicating the desired default opening height of the plug-in window. This
    ///               property is requested only for plug-ins in separate windows.</td> </tr> <tr>
    ///               <td>PLUGIN_SEPARATEWINDOW_DEFAULTWIDTH = L"DefaultWidth"</td> <td>The out parameter is set to a <b>Long</b>
    ///               (<b>VT_I4</b>) value indicating the desired default opening width of the plug-in window. This property is
    ///               requested only for plug-ins in separate windows.</td> </tr> <tr> <td>PLUGIN_SEPARATEWINDOW_MAXHEIGHT =
    ///               L"MaxHeight"</td> <td>The out parameter is set to a <b>Long</b> (<b>VT_I4</b>) value indicating the desired
    ///               maximum height of the plug-in window. This property is requested only for plug-ins in separate, resizable
    ///               windows.</td> </tr> <tr> <td>PLUGIN_SEPARATEWINDOW_MAXWIDTH = L"MaxWidth"</td> <td>The out parameter is set
    ///               to a <b>Long</b> (<b>VT_I4</b>) value indicating the desired maximum width of the plug-in window. This
    ///               property is requested only for plug-ins in separate, resizable windows.</td> </tr> <tr>
    ///               <td>PLUGIN_SEPARATEWINDOW_MINHEIGHT = L"MinHeight"</td> <td>The out parameter is set to a <b>Long</b>
    ///               (<b>VT_I4</b>) value indicating the desired minimum height of the plug-in window. This property is requested
    ///               only for plug-ins in separate, resizable windows.</td> </tr> <tr> <td>PLUGIN_SEPARATEWINDOW_MINWIDTH =
    ///               L"MinWidth"</td> <td>The out parameter is set to a <b>Long</b> (<b>VT_I4</b>) value indicating the desired
    ///               minimum width of the plug-in window. This property is requested only for plug-ins in separate, resizable
    ///               windows.</td> </tr> <tr> <td>PLUGIN_SEPARATEWINDOW_RESIZABLE = L"Resizable"</td> <td>The out parameter is set
    ///               to a <b>Boolean</b> (<b>VT_BOOL</b>) value that indicates whether the plug-in window is resizable. This
    ///               property is requested only for plug-ins in separate windows.</td> </tr> </table>
    ///    pvarProperty = Pointer to a <b>VARIANT</b> to contain the value of the property.
    ///Returns:
    ///    This method returns an <b>HRESULT</b>.
    ///    
    HRESULT GetProperty(const(wchar)* pwszName, VARIANT* pvarProperty);
    ///The <b>SetProperty</b> method is called by Windows Media Player to set name/value property pairs for the plug-in.
    ///Params:
    ///    pwszName = Pointer to a <b>WCHAR</b><b>NULL</b>-terminated string constant containing the name of the property. Contains
    ///               one of the following values: <table> <tr> <th>Value </th> <th>Description </th> </tr> <tr>
    ///               <td>PLUGIN_MISC_CURRENTPRESET = L"CurrentPreset"</td> <td>The <i>pvarProperty</i> parameter contains a
    ///               <b>Long</b> (<b>VT_I4</b>) value that specifies the index of the plug-in preset which is to be made
    ///               current.</td> </tr> <tr> <td>PLUGIN_ALL_MEDIASENDTO = L"MediaSendTo"</td> <td>The <i>pvarProperty</i>
    ///               parameter contains an array of <b>IUnknown</b> (<b>VT_ARRAY</b> | <b>VT_UNKNOWN</b>) pointers for
    ///               <b>Media</b> objects that are sent to the plug-in from the Playlist control.</td> </tr> <tr>
    ///               <td>PLUGIN_ALL_PLAYLISTSENDTO = L"PlaylistSendTo"</td> <td>The <i>pvarProperty</i> parameter contains an
    ///               array of <b>IUnknown</b> (<b>VT_ARRAY</b> | <b>VT_UNKNOWN</b>) pointers for <b>Playlist</b> objects that are
    ///               sent to the plug-in from the library.</td> </tr> </table>
    ///    pvarProperty = Pointer to a <b>VARIANT</b> containing the new value of the property.
    ///Returns:
    ///    This method returns an <b>HRESULT</b>.
    ///    
    HRESULT SetProperty(const(wchar)* pwszName, const(VARIANT)* pvarProperty);
    HRESULT TranslateAcceleratorA(MSG* lpmsg);
}

///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of this
///functionality outside the context of an online store is not supported.</div> <div> </div> The
///<b>IWMPContentContainer</b> interface represents a container for information about digital media content in an online
///store.
@GUID("AD7F4D9C-1A9F-4ED2-9815-ECC0B58CB616")
interface IWMPContentContainer : IUnknown
{
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The <b>GetID</b>
    ///method retrieves the ID of the album or list represented by the content container.
    ///Params:
    ///    pContentID = Pointer to a <b>ULONG</b> that receives the ID.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetID(uint* pContentID);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>GetPrice</b> method retrieves the total price of the album or list represented by the content container.
    ///Params:
    ///    pbstrPrice = Pointer to a <b>BSTR</b> that receives the price or one of the following constants. <table> <tr> <th>String
    ///                 </th> <th>Description </th> </tr> <tr> <td>g_szContentPrice_Unknown</td> <td>The price of the content is
    ///                 unknown.</td> </tr> <tr> <td>g_szContentPrice_CannotBuy</td> <td>The content cannot be purchased.</td> </tr>
    ///                 <tr> <td>g_szContentPrice_Free</td> <td>The content is free.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetPrice(BSTR* pbstrPrice);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The <b>GetType</b>
    ///method retrieves the type of the content container.
    ///Params:
    ///    pbstrType = Pointer to a <b>BSTR</b> that receives one of the following values. <table> <tr> <th>Value </th>
    ///                <th>Description </th> </tr> <tr> <td>g_szCPAlbumID</td> <td>The content container contains an album.</td>
    ///                </tr> <tr> <td>g_szCPListID</td> <td>The content container contains a list. A list, in this context, is a set
    ///                of tracks that the online store offers as a bundle. The online store provides an ID and a price for the list
    ///                as a whole.</td> </tr> <tr> <td>g_szUnknownLocation</td> <td>The content container contains a set of
    ///                individual tracks.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetType(BSTR* pbstrType);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>GetContentCount</b> method retrieves the count of digital media content items in the container.
    ///Params:
    ///    pcContent = Pointer to a <b>ULONG</b> that receives the count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetContentCount(uint* pcContent);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>GetContentPrice</b> method retrieves the price of the media item at the specified index in the content
    ///container.
    ///Params:
    ///    idxContent = Specifies the zero-based index of the media item for which to retrieve the price.
    ///    pbstrPrice = Pointer to a <b>BSTR</b> that receives the price or one of the following constants. <table> <tr> <th>String
    ///                 </th> <th>Description </th> </tr> <tr> <td>g_szContentPrice_Unknown</td> <td>The price of the content is
    ///                 unknown.</td> </tr> <tr> <td>g_szContentPrice_CannotBuy</td> <td>The content cannot be purchased.</td> </tr>
    ///                 <tr> <td>g_szContentPrice_Free</td> <td>The content is free.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetContentPrice(uint idxContent, BSTR* pbstrPrice);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>GetContentID</b> method retrieves the ID of the media item at the specified index in the content container.
    ///Params:
    ///    idxContent = Specifies the zero-based index of the media item in the container..
    ///    pContentID = Pointer to a <b>ULONG</b> that receives the ID of the media item.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetContentID(uint idxContent, uint* pContentID);
}

///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of this
///functionality outside the context of an online store is not supported.</div> <div> </div> The
///<b>IWMPContentContainerList</b> interface represents a list of one or more content containers. Content containers are
///represented by the IWMPContentContainer interface.
@GUID("A9937F78-0802-4AF8-8B8D-E3F045BC8AB5")
interface IWMPContentContainerList : IUnknown
{
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>GetTransactionType</b> method retrieves the type of the current transaction.
    ///Params:
    ///    pwmptt = Pointer to a WMPTransactionType that receives the transaction type value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetTransactionType(WMPTransactionType* pwmptt);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>GetContainerCount</b> method retrieves the count of content containers in the container list.
    ///Params:
    ///    pcContainer = Address of a <b>ULONG</b> that receives the count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetContainerCount(uint* pcContainer);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>GetContainer</b> method retrieves the content container at the specified index.
    ///Params:
    ///    idxContainer = Specifies the index of the content container to retrieve.
    ///    ppContent = Address of a variable that receives a pointer to the <b>IWMPContentContainer</b> interface at the specified
    ///                index.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetContainer(uint idxContainer, IWMPContentContainer* ppContent);
}

///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of this
///functionality outside the context of an online store is not supported.</div> <div> </div> The
///<b>IWMPContentPartnerCallback</b> interface provides methods, implemented by Windows Media Player, that a content
///partner plug-in calls to integrate its catalog and services with the Windows Media Player user interface.
@GUID("9E8F7DA2-0695-403C-B697-DA10FAFAA676")
interface IWMPContentPartnerCallback : IUnknown
{
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The <b>Notify</b>
    ///method provides notifications from the content partner plug-in to Windows Media Player.
    ///Params:
    ///    type = The type of notification being made, specified as a member of the WMPCallbackNotification enumeration.
    ///    pContext = Context-specific data for the notification. See Remarks.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Notify(WMPCallbackNotification type, VARIANT* pContext);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>BuyComplete</b> method notifies Windows Media Player that a purchase transaction has been completed.
    ///Params:
    ///    hrResult = <b>HRESULT</b> return code indicating the success or failure of the transaction.
    ///    dwBuyCookie = The cookie that represents the purchase transaction. This value was provided when the Player called
    ///                  IWMPContentPartner::Buy.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT BuyComplete(HRESULT hrResult, uint dwBuyCookie);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>DownloadTrack</b> method instructs Windows Media Player to download or not to download a particular media
    ///item.
    ///Params:
    ///    cookie = A cookie that identifies a download session. Windows Media Player previously supplied this cookie to the
    ///             content partner plug-in by calling IWMPContentPartner::Download.
    ///    bstrTrackURL = The URL of the track to download.
    ///    dwServiceTrackID = The ID of the track in question.
    ///    bstrDownloadParams = Data that the online store wants to associate with the track in question. Windows Media Player does not
    ///                         interpret this data; it is meaningful only to the online store. Windows Media player passes this data back to
    ///                         the online store when it calls IWMPContentPartner::DownloadTrackComplete.
    ///    hrDownload = An <b>HRESULT</b> that specifies whether to download the track. Any success code specifies that the Player
    ///                 should download the track. Any failure code specifies that the Player should not download the track.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT DownloadTrack(uint cookie, BSTR bstrTrackURL, uint dwServiceTrackID, BSTR bstrDownloadParams, 
                          HRESULT hrDownload);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>GetCatalogVersion</b> method retrieves the version information for the online store catalog currently in use
    ///by Windows Media Player.
    ///Params:
    ///    pdwVersion = Address of a <b>DWORD</b> that receives the catalog version.
    ///    pdwSchemaVersion = Address of a <b>DWORD</b> that receives the schema version.
    ///    plcid = Address of an <b>LCID</b> that receives the locale ID for the catalog.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetCatalogVersion(uint* pdwVersion, uint* pdwSchemaVersion, uint* plcid);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>UpdateDeviceComplete</b> method notifies Windows Media Player that the online store has finished processing a
    ///call to IWMPContentPartner::UpdateDevice.
    ///Params:
    ///    bstrDeviceName = String containing the device name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT UpdateDeviceComplete(BSTR bstrDeviceName);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>ChangeView</b> method changes the view in Windows Media Player.
    ///Params:
    ///    bstrType = A library location constant that specifies the type of the new library view. For example, the constant
    ///               g_szGenreID specifies that the new view will show a particular genre.
    ///    bstrID = The ID of the specific item to show in the new view. For example, if <i>bstrType</i> is g_szGenreID, then
    ///             this parameter specifies the ID of the particular genre to show in the new view.
    ///    bstrFilter = The filter for the new view. The view will be filtered as if the user had entered this text in the Player's
    ///                 word wheel control.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT ChangeView(BSTR bstrType, BSTR bstrID, BSTR bstrFilter);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>AddListContents</b> method adds a set of media items to a list.
    ///Params:
    ///    dwListCookie = A cookie that identifies a list retrieval session. Windows Media Player previously supplied this cookie to
    ///                   the content partner plug-in by calling IWMPContentPartner::GetListContents.
    ///    cItems = Count of items to be added to the list. This is the number of elements in the <i>prgItems</i> array.
    ///    prgItems = Pointer to an array of media item IDs. These are the IDs of the media items that are to be added to the list.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT AddListContents(uint dwListCookie, uint cItems, char* prgItems);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>ListContentsComplete</b> method notifies Windows Media Player that the content partner plug-in is finished
    ///adding content to a list.
    ///Params:
    ///    dwListCookie = A cookie that identifies a list retrieval session. Windows Media Player previously supplied this cookie to
    ///                   the content partner plug-in by calling IWMPContentPartner::GetListContents.
    ///    hrSuccess = An <b>HRESULT</b> that indicates whether the overall transfer of list contents succeeded. Any success code
    ///                indicates that the transfer succeeded; any error code indicates that the transfer failed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT ListContentsComplete(uint dwListCookie, HRESULT hrSuccess);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>SendMessageComplete</b> method notifies Windows Media Player that the online store has finished processing a
    ///message.
    ///Params:
    ///    bstrMsg = <b>BSTR</b> containing the message. See Remarks.
    ///    bstrParam = <b>BSTR</b> containing the message parameters.
    ///    bstrResult = <b>BSTR</b> containing the result.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SendMessageComplete(BSTR bstrMsg, BSTR bstrParam, BSTR bstrResult);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>GetContentIDsInLibrary</b> method retrieves an array of content IDs that represent the music tracks in the
    ///library.
    ///Params:
    ///    pcContentIDs = Receives the number of elements in the <i>pprgIDs</i> array.
    ///    pprgIDs = Receives a pointer to an array of content IDs.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetContentIDsInLibrary(uint* pcContentIDs, char* pprgIDs);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>RefreshLicenseComplete</b> method notifies Windows Media Player that the online store has finished processing
    ///a request to update the license for a media file.
    ///Params:
    ///    dwCookie = A cookie that represents a request to update a license for a media file. Windows Media Player previously
    ///               supplied this cookie to the online store's plug-in by calling IWMPContentPartner::RefreshLicense.
    ///    contentID = The content ID of the media file for which the license update was requested.
    ///    hrRefresh = An <b>HRESULT</b> that indicates whether the license update was successful. Any success code indicates that
    ///                the update succeeded. Any failure code indicates that the update failed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT RefreshLicenseComplete(uint dwCookie, uint contentID, HRESULT hrRefresh);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>ShowPopup</b> method instructs Windows Media Player to display an HTML-based dialog box that hosts a webpage
    ///provided by the online store.
    ///Params:
    ///    lIndex = Index, meaningful only to the online store, of the webpage to display in the dialog box.
    ///    bstrParameters = Parameters associated with the dialog box.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT ShowPopup(int lIndex, BSTR bstrParameters);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>VerifyPermissionComplete</b> method notifies Windows Media Player that the online store has finished
    ///processing a call to IWMPContentPartner::VerifyPermission.
    ///Params:
    ///    bstrPermission = A <b>BSTR</b> that specifies the action for which permission was requested. Windows Media Player previously
    ///                     requested permission to perform this action by calling IWMPContentPartner::VerifyPermission. See Remarks for
    ///                     a list of possible values.
    ///    pContext = A pointer to a <b>VARIANT</b> that contains information related to the notification. See Remarks.
    ///    hrPermission = An <b>HRESULT</b> that indicates whether permission is granted. Any success code indicates that permission is
    ///                   granted. Any failure code indicates that permission is denied.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT VerifyPermissionComplete(BSTR bstrPermission, VARIANT* pContext, HRESULT hrPermission);
}

///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of this
///functionality outside the context of an online store is not supported.</div> <div> </div> The
///<b>IWMPContentPartner</b> interface provides methods that Windows Media Player calls to integrate its user interface
///with an online store's catalog and services. This interface is implemented by a content partner plug-in, which is
///provided by the online store.
@GUID("55455073-41B5-4E75-87B8-F13BDB291D08")
interface IWMPContentPartner : IUnknown
{
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>SetCallback</b> method provides the plug-in with a pointer for calling Windows Media Player methods.
    ///Params:
    ///    pCallback = Pointer to the IWMPContentPartnerCallback interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetCallback(IWMPContentPartnerCallback pCallback);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The <b>Notify</b>
    ///method provides the content partner plug-in with event notifications from Windows Media Player.
    ///Params:
    ///    type = The notification type, specified as a member of the WMPPartnerNotification enumeration.
    ///    pContext = Pointer to a <b>VARIANT</b> that contains notification data.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Notify(WMPPartnerNotification type, VARIANT* pContext);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>GetItemInfo</b> method retrieves information (for example, a URL or a caption) related to an item owned by an
    ///online store.
    ///Params:
    ///    bstrInfoName = <b>BSTR</b> specifying the item for which information will be retrieved. See Remarks for possible values.
    ///    pContext = Pointer to a <b>VARIANT</b> that supplies contextual information for the requested information.
    ///    pData = Pointer to a <b>VARIANT</b> that receives the information.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetItemInfo(BSTR bstrInfoName, VARIANT* pContext, VARIANT* pData);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>GetContentPartnerInfo</b> method retrieves specific information about the online store.
    ///Params:
    ///    bstrInfoName = A <b>BSTR</b> that specifies the type of information to retrieve. See Remarks for a list of possible values.
    ///    pData = Address of a <b>VARIANT</b> that receives the information.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetContentPartnerInfo(BSTR bstrInfoName, VARIANT* pData);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>GetCommands</b> method retrieves context menu commands.
    ///Params:
    ///    location = A library location constant that specifies the type of library view where the user right-clicked. For
    ///               example, the constant g_szCPGenreID indicates that the user right-clicked in the view of a particular genre
    ///    pLocationContext = The ID of the specific view where the user right-clicked. For example, if <i>location</i> is g_szCPGenreID,
    ///                       this parameter is the ID of the particular genre the user was viewing when he or she right-clicked.
    ///    itemLocation = A library location constant that indicates the type of the media item or items that were selected when the
    ///                   user right-clicked. For example, the constant g_szCPAlbumID specifies that the user right-clicked when one or
    ///                   more albums were selected.
    ///    cItemIDs = The number of items that were selected when the user right-clicked. This is the number of elements in the
    ///               prgIte<i></i>mIDs array.
    ///    prgItemIDs = An array that contains the IDs of the media items that were selected when the user right-clicked.
    ///    pcItemIDs = The number of elements in the <i>pprgItems</i> array.
    ///    pprgItems = Address of a variable that receives a pointer to an array of WMPContextMenuInfo structures.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetCommands(BSTR location, VARIANT* pLocationContext, BSTR itemLocation, uint cItemIDs, 
                        char* prgItemIDs, uint* pcItemIDs, char* pprgItems);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>InvokeCommand</b> method invokes a context menu command.
    ///Params:
    ///    dwCommandID = ID of the command to invoke. Windows Media Player previously obtained this command ID from the content
    ///                  partner plug-in by calling IWMPContentPartner::GetCommands.
    ///    location = A library location constant that specifies the type of library view where the user right-clicked. For
    ///               example, the constant g_szCPGenreID specifies that the user right-clicked in the view of a particular genre.
    ///    pLocationContext = TheID of the specific view where the user right-clicked. For example, if <i>location</i> is g_szCPGenreID,
    ///                       then this parameter is the ID of the particular genre the user was viewing when he or she right-clicked.
    ///    itemLocation = A library location constant that specifies the type of the media item or items that were selected when the
    ///                   user right-clicked. For example, the constant g_szCPAlbumID specifies that the user right-clicked when one or
    ///                   more albums were selected.
    ///    cItemIDs = The number of items that were selected when the user right-clicked. This is the number of elements in the
    ///               <i>rgItemIDs</i> array.
    ///    rgItemIDs = An array that contains the IDs of the media items that were selected when the user right-clicked.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT InvokeCommand(uint dwCommandID, BSTR location, VARIANT* pLocationContext, BSTR itemLocation, 
                          uint cItemIDs, char* rgItemIDs);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>CanBuySilent</b> method calculates the total price of a purchase and determines whether the purchase can
    ///proceed without displaying a dialog box.
    ///Params:
    ///    pInfo = Pointer to a content container list that represents the content to be purchased.
    ///    pbstrTotalPrice = Pointer to a <b>BSTR</b> that receives the total price.
    ///    pSilentOK = Receives VARIANT_TRUE if the purchase can proceed silently; that is, without displaying a dialog box.
    ///                Otherwise it receives VARIANT_FALSE.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT CanBuySilent(IWMPContentContainerList pInfo, BSTR* pbstrTotalPrice, short* pSilentOK);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The <b>Buy</b>
    ///method initiates the purchase of digital media content.
    ///Params:
    ///    pInfo = Pointer to a content container list that represents the content to be purchased.
    ///    cookie = A cookie used to identify the transaction. You must store this value and pass it to
    ///             IWMPContentPartnerCallback::BuyComplete when the purchase transaction is finished.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Buy(IWMPContentContainerList pInfo, uint cookie);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>GetStreamingURL</b> method retrieves the streaming URL of a track.
    ///Params:
    ///    st = A member of the WMPStreamingType enumeration that specifies the type (music, video, or radio) of the media
    ///         item to be streamed.
    ///    pStreamContext = Pointer to a <b>VARIANT</b> that contains the ID of the media item to be streamed. The ID is in the
    ///                     <b>ulVal</b> member of the <b>VARIANT</b>, which has a type of <b>VT_UI4</b>.
    ///    pbstrURL = Address of a <b>BSTR</b> that receives the URL of the track.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetStreamingURL(WMPStreamingType st, VARIANT* pStreamContext, BSTR* pbstrURL);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>Download</b> method initiates the download of a set of media items.
    ///Params:
    ///    pInfo = Pointer to an IWMPContentContainerList interface that describes the content to download.
    ///    cookie = A cookie that represents the download request.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Download(IWMPContentContainerList pInfo, uint cookie);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>DownloadTrackComplete</b> method notifies the content partner plug-in that Windows Media Player has finished
    ///downloading a track or that the download attempt failed.
    ///Params:
    ///    hrResult = <b>HRESULT</b> indicating success or failure of the download. Any success code indicates that the Player
    ///               successfully downloaded the track. Any failure code indicates that the Player failed to download the track.
    ///    contentID = Content ID of the track in question.
    ///    downloadTrackParam = Parameter that the plug-in previously passed to IWMPContentPartnerCallback::DownloadTrack. This parameter is
    ///                         meaningful only to the online store; it is not interpreted by Windows Media Player.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT DownloadTrackComplete(HRESULT hrResult, uint contentID, BSTR downloadTrackParam);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>RefreshLicense</b> method initiates the update of a license for the specified media file.
    ///Params:
    ///    dwCookie = A cookie that identifies the update request. When the online store has finished updating the license, it
    ///               passes this cookie to IWMPContentPartnerCallback::RefreshLicenseComplete.
    ///    fLocal = <b>VARIANT_BOOL</b> that specifies whether the media file is located on the user's computer.
    ///             <b>VARIANT_TRUE</b> specifies that the file is on the user's computer. <b>VARIANT_FALSE</b> specifies that
    ///             the file is not currently on the user's computer, but is available from the online store's servers.
    ///    bstrURL = <b>BSTR</b> containing the URL of the media file on the user's computer. This is <b>NULL</b> if the media
    ///              file is not on the user's computer.
    ///    type = A member of the WMPStreamingType enumeration that specifies the type (music, video, or radio) of the media
    ///           file.
    ///    contentID = Content ID of the media file for which the updated license is being requested.
    ///    bstrRefreshReason = Reason for refreshing the license. The caller (Windows Media Player) sets this parameter to one of the
    ///                        following values: <p class="indent">g_szRefreshLicensePlay <p class="indent">g_szRefreshLicenseBurn <p
    ///                        class="indent">g_szRefreshLicenseSync
    ///    pReasonContext = If refreshing the license for synchronization to a device, this parameter has type <b>VT_BSTR</b> and
    ///                     contains the device name. Otherwise, this parameter has type <b>VT_EMPTY</b> and supplies no information.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT RefreshLicense(uint dwCookie, short fLocal, BSTR bstrURL, WMPStreamingType type, uint contentID, 
                           BSTR bstrRefreshReason, VARIANT* pReasonContext);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>GetCatalogURL</b> method retrieves the URL from which to retrieve an update to the online store's current
    ///catalog.
    ///Params:
    ///    dwCatalogVersion = <b>DWORD</b> containing the current catalog version.
    ///    dwCatalogSchemaVersion = <b>DWORD</b> containing the current catalog schema version.
    ///    catalogLCID = The locale ID (LCID) for the catalog.
    ///    pdwNewCatalogVersion = Address of a <b>DWORD</b> that receives the new catalog version.
    ///    pbstrCatalogURL = Address of a <b>BSTR</b> that receives the URL.
    ///    pExpirationDate = Address of a <b>VARIANT</b> (<b>VT_DATE</b>) that receives the expiration date of the catalog update.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetCatalogURL(uint dwCatalogVersion, uint dwCatalogSchemaVersion, uint catalogLCID, 
                          uint* pdwNewCatalogVersion, BSTR* pbstrCatalogURL, VARIANT* pExpirationDate);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>GetTemplate</b> method retrieves the URL of the discovery page to be displayed when the library view changes
    ///in Windows Media Player.
    ///Params:
    ///    task = A member of the WMPTaskType enumeration that specifies the active task pane.
    ///    location = A library location constant that specifies the type of library view the user is currently seeing. For
    ///               example, the constant g_szCPListID specifies that the user is viewing a pane that shows a particular
    ///               playlist.
    ///    pContext = The ID of the specific item the user is currently seeing. For example, if <i>location</i> is g_szCPListID,
    ///               then this parameter specifies the ID of the particular playlist that the user is seeing.
    ///    clickLocation = A library location constant that specifies the type of item the user has selected. For example, the constant
    ///                    g_szCPTrackID specifies that the user has selected a particular music track.
    ///    pClickContext = The ID of the particular item the user has selected. For example, if <i>clickLocation</i> is g_szCPTrackID,
    ///                    then this parameter specifies the ID of the particular track that the user has selected.
    ///    bstrFilter = The filter for the current library view. This is the text that the user entered in the Player's word wheel
    ///                 control.
    ///    bstrViewParams = Parameters, meaningful only to the online store, associated with the new library location. See Remarks.
    ///    pbstrTemplateURL = Pointer to a <b>BSTR</b> that receives the URL of the discovery page to display.
    ///    pTemplateSize = Receives a member of the WMPTemplateSize enumeration that indicates the size of the template in which the
    ///                    Player will display the discovery page.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetTemplate(WMPTaskType task, BSTR location, VARIANT* pContext, BSTR clickLocation, 
                        VARIANT* pClickContext, BSTR bstrFilter, BSTR bstrViewParams, BSTR* pbstrTemplateURL, 
                        WMPTemplateSize* pTemplateSize);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>UpdateDevice</b> method notifies the content partner plug-in that a portable device is being synchronized.
    ///Params:
    ///    bstrDeviceName = <b>BSTR</b> containing the device name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT UpdateDevice(BSTR bstrDeviceName);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>GetListContents</b> method initiates the retrieval of a dynamic list.
    ///Params:
    ///    location = A library location constant that specifies the type of library view that will have its list retrieved. For
    ///               example, the constant g_szCPListID specifies that a particular list will be retrieved.
    ///    pContext = The ID of the specific item that will have its list retrieved. For example, if <i>location</i> is
    ///               g_szCPListID, then this parameter is the ID of the list that will be retrieved.
    ///    bstrListType = A library location constant that specifies the type of an individual list item. For example, the constant
    ///                   g_szCPAlbumID specifies that the items in the list are albums.
    ///    bstrParams = Parameters, meaningful only to the online store, associated with the retrieved list. See Remarks.
    ///    dwListCookie = A cookie used to identify the list retrieval operation. (The plug-in passes this cookie to
    ///                   IWMPContentPartnerCallback::AddListContents and IWMPContentPartnerCallback::ListContentsComplete.)
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetListContents(BSTR location, VARIANT* pContext, BSTR bstrListType, BSTR bstrParams, 
                            uint dwListCookie);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The <b>Login</b>
    ///method logs the user in to the online store.
    ///Params:
    ///    userInfo = Encrypted <b>BLOB</b> containing the user name.
    ///    pwdInfo = Encrypted <b>BLOB</b> containing the user password.
    ///    fUsedCachedCreds = <b>VARIANT_BOOL</b> indicating whether the plug-in should try to use cached credentials.
    ///    fOkToCache = <b>VARIANT_BOOL</b> indicating whether the plug-in is permitted to cache the supplied credentials.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Login(BLOB userInfo, BLOB pwdInfo, short fUsedCachedCreds, short fOkToCache);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>Authenticate</b> method initiates an attempt to authenticate the user.
    ///Params:
    ///    userInfo = <b>BLOB</b> that contains encrypted user information.
    ///    pwdInfo = <b>BLOB</b> that contains encrypted password information.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Authenticate(BLOB userInfo, BLOB pwdInfo);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The <b>Logout</b>
    ///method ends the user's online store session.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Logout();
    HRESULT SendMessageA(BSTR bstrMsg, BSTR bstrParam);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>StationEvent</b> method notifies the plug-in of events during playback of a Windows Media metafile playlist
    ///(ASX file).
    ///Params:
    ///    bstrStationEventType = <b>BSTR</b> containing the event type. The caller (Windows Media Player) sets this parameter to one of the
    ///                           following values. <table> <tr> <th>String </th> <th>Description </th> </tr> <tr>
    ///                           <td>g_szStationEvent_Started</td> <td>A track started playing.</td> </tr> <tr>
    ///                           <td>g_szStationEvent_Complete</td> <td>A track finished playing.</td> </tr> <tr>
    ///                           <td>g_szStationEvent_Skipped</td> <td>A track was skipped.</td> </tr> </table>
    ///    StationId = The station ID.
    ///    PlaylistIndex = The playlist index.
    ///    TrackID = The track ID.
    ///    TrackData = <b>BSTR</b> containing track data.
    ///    dwSecondsPlayed = Number of seconds that the playlist was played.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT StationEvent(BSTR bstrStationEventType, uint StationId, uint PlaylistIndex, uint TrackID, 
                         BSTR TrackData, uint dwSecondsPlayed);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>CompareContainerListPrices</b> method compares the price of two content container lists.
    ///Params:
    ///    pListBase = Pointer to the <b>IWMPContentContainerList</b> interface representing the base content container list.
    ///    pListCompare = Pointer to the <b>IWMPContentContainerList</b> interface representing the comparison content container list.
    ///    pResult = Address of a <b>long</b> that receives the result of the comparison. Return less than 0 when the base price
    ///              is less than the comparison price; return 0 when the base and comparison lists have equal prices; return
    ///              greater than 0 when the base price is greater than the comparison price.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT CompareContainerListPrices(IWMPContentContainerList pListBase, IWMPContentContainerList pListCompare, 
                                       int* pResult);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>VerifyPermission</b> method initiates the process of verifying permission for Windows Media Player to perform
    ///an action.
    ///Params:
    ///    bstrPermission = A <b>BSTR</b> that specifies the action for which permission is being requested. See Remarks for a list of
    ///                     possible values.
    ///    pContext = A pointer to a <b>VARIANT</b> that contains information related to the request. See Remarks.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT VerifyPermission(BSTR bstrPermission, VARIANT* pContext);
}

///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of this
///functionality outside the context of an online store is not supported.</div> <div> </div> The
///<b>IWMPSubscriptionService</b> interface provides methods to augment digital rights management (DRM) and initiate
///background processes when Windows Media Player opens premium content. These methods are implemented by the online
///store and called by Windows Media Player 9 Series or later.
@GUID("376055F8-2A59-4A73-9501-DCA5273A7A10")
interface IWMPSubscriptionService : IUnknown
{
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>allowPlay</b> method is implemented by the online store's plug-in to manage permission for Windows Media
    ///Player to play content.
    ///Params:
    ///    hwnd = A handle to a window in which the plug-in can display a user interface.
    ///    pMedia = Pointer to the media object Windows Media Player is attempting to play.
    ///    pfAllowPlay = Pointer to a <b>BOOL</b>. If <b>true</b>, playback is allowed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>.
    ///    
    HRESULT allowPlay(HWND hwnd, IWMPMedia pMedia, int* pfAllowPlay);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>allowCDBurn</b> method is implemented by the online store's plug-in to manage permission for Windows Media
    ///Player to copy content to a CD.
    ///Params:
    ///    hwnd = A handle to a window in which the plug-in can display a user interface.
    ///    pPlaylist = Pointer to a playlist object. The plug-in must remove from the playlist any media item that does not have a
    ///                current license that includes burn rights.
    ///    pfAllowBurn = Pointer to a <b>BOOL</b>. If true, copying to CD is allowed for the media items that remain in the playlist.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>.
    ///    
    HRESULT allowCDBurn(HWND hwnd, IWMPPlaylist pPlaylist, int* pfAllowBurn);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>allowPDATransfer</b> method is implemented by the online store's plug-in to manage permission for Windows
    ///Media Player to synchronize content with a device.
    ///Params:
    ///    hwnd = A handle to a window in which the plug-in can display a user interface.
    ///    pPlaylist = Pointer to a playlist object.
    ///    pfAllowTransfer = Pointer to a <b>BOOL</b>. If true, copying to a device is allowed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>.
    ///    
    HRESULT allowPDATransfer(HWND hwnd, IWMPPlaylist pPlaylist, int* pfAllowTransfer);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>startBackgroundProcessing</b> method is implemented by the online store to initiate background processing
    ///tasks.
    ///Params:
    ///    hwnd = A handle to a window in which the plug-in can display a user interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>.
    ///    
    HRESULT startBackgroundProcessing(HWND hwnd);
}

///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of this
///functionality outside the context of an online store is not supported.</div> <div> </div> The
///<b>IWMPSubscriptionServicesCallback</b> interface defines a method that online stores use to notify Windows Media
///Player when a background process has completed.
@GUID("DD01D127-2DC2-4C3A-876E-63312079F9B0")
interface IWMPSubscriptionServiceCallback : IUnknown
{
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>onComplete</b> method notifies Windows Media Player when a background process is completed.
    ///Params:
    ///    hrResult = <b>HRESULT</b> success or error code.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT onComplete(HRESULT hrResult);
}

///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of this
///functionality outside the context of an online store is not supported.</div> <div> </div> The
///<b>IWMPSubscriptionService2</b> interface extends <b>IWMPSubscriptionService</b>. It provides methods to initiate
///background processes, to provide notifications about online store activity, and to provide a pointer to the Windows
///Media Player core interface. These methods are implemented by the online store and called by Windows Media Player 10
///or later.
@GUID("A94C120E-D600-4EC6-B05E-EC9D56D84DE0")
interface IWMPSubscriptionService2 : IWMPSubscriptionService
{
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>stopBackgroundProcessing</b> method is implemented by the online store to terminate background processing
    ///tasks.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT stopBackgroundProcessing();
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>serviceEvent</b> method is called when the online store is activated or deactivated.
    ///Params:
    ///    event = A WMPSubscriptionServiceEvent enumeration value indicating whether the service is activated or deactivated.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT serviceEvent(WMPSubscriptionServiceEvent event);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>deviceAvailable</b> method is implemented by the online store to initiate device-specific processing tasks.
    ///Params:
    ///    bstrDeviceName = String containing the device name.
    ///    pCB = Pointer to an <b>IWMPSubscriptionServiceCallback</b> interface. The online store uses this pointer to notify
    ///          Windows Media Player that device-specific processing is complete.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT deviceAvailable(BSTR bstrDeviceName, IWMPSubscriptionServiceCallback pCB);
    ///<div class="alert"><b>Note</b> This section describes functionality designed for use by online stores. Use of
    ///this functionality outside the context of an online store is not supported.</div> <div> </div> The
    ///<b>prepareForSync</b> method is implemented by the online store and called by Windows Media Player just before
    ///synchronization happens. Use this method to perform tasks related to synchronizing a digital media file to a
    ///device.
    ///Params:
    ///    bstrFilename = String containing the name of the digital media file being synchronized.
    ///    bstrDeviceName = String containing the canonical name of the device.
    ///    pCB = Pointer to an IWMPSubscriptionServiceCallback interface. The online store uses this pointer to notify Windows
    ///          Media Player that preparation for synchronization is complete.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT prepareForSync(BSTR bstrFilename, BSTR bstrDeviceName, IWMPSubscriptionServiceCallback pCB);
}

@GUID("C9470E8E-3F6B-46A9-A0A9-452815C34297")
interface IWMPDownloadItem : IDispatch
{
    HRESULT get_sourceURL(BSTR* pbstrURL);
    HRESULT get_size(int* plSize);
    HRESULT get_type(BSTR* pbstrType);
    HRESULT get_progress(int* plProgress);
    HRESULT get_downloadState(WMPSubscriptionDownloadState* pwmpsdls);
    HRESULT pause();
    HRESULT resume();
    HRESULT cancel();
}

@GUID("9FBB3336-6DA3-479D-B8FF-67D46E20A987")
interface IWMPDownloadItem2 : IWMPDownloadItem
{
    HRESULT getItemInfo(BSTR bstrItemName, BSTR* pbstrVal);
}

@GUID("0A319C7F-85F9-436C-B88E-82FD88000E1C")
interface IWMPDownloadCollection : IDispatch
{
    HRESULT get_id(int* plId);
    HRESULT get_count(int* plCount);
    HRESULT item(int lItem, IWMPDownloadItem2* ppDownload);
    HRESULT startDownload(BSTR bstrSourceURL, BSTR bstrType, IWMPDownloadItem2* ppDownload);
    HRESULT removeItem(int lItem);
    HRESULT Clear();
}

@GUID("E15E9AD1-8F20-4CC4-9EC7-1A328CA86A0D")
interface IWMPDownloadManager : IDispatch
{
    HRESULT getDownloadCollection(int lCollectionId, IWMPDownloadCollection* ppCollection);
    HRESULT createDownloadCollection(IWMPDownloadCollection* ppCollection);
}


// GUIDs

const GUID CLSID_FeedFolderWatcher      = GUIDOF!FeedFolderWatcher;
const GUID CLSID_FeedWatcher            = GUIDOF!FeedWatcher;
const GUID CLSID_FeedsManager           = GUIDOF!FeedsManager;
const GUID CLSID_WMPLib                 = GUIDOF!WMPLib;
const GUID CLSID_WMPRemoteMediaServices = GUIDOF!WMPRemoteMediaServices;
const GUID CLSID_WindowsMediaPlayer     = GUIDOF!WindowsMediaPlayer;

const GUID IID_IFeed                           = GUIDOF!IFeed;
const GUID IID_IFeed2                          = GUIDOF!IFeed2;
const GUID IID_IFeedEnclosure                  = GUIDOF!IFeedEnclosure;
const GUID IID_IFeedEvents                     = GUIDOF!IFeedEvents;
const GUID IID_IFeedFolder                     = GUIDOF!IFeedFolder;
const GUID IID_IFeedFolderEvents               = GUIDOF!IFeedFolderEvents;
const GUID IID_IFeedItem                       = GUIDOF!IFeedItem;
const GUID IID_IFeedItem2                      = GUIDOF!IFeedItem2;
const GUID IID_IFeedsEnum                      = GUIDOF!IFeedsEnum;
const GUID IID_IFeedsManager                   = GUIDOF!IFeedsManager;
const GUID IID_IWMPAudioRenderConfig           = GUIDOF!IWMPAudioRenderConfig;
const GUID IID_IWMPCdrom                       = GUIDOF!IWMPCdrom;
const GUID IID_IWMPCdromBurn                   = GUIDOF!IWMPCdromBurn;
const GUID IID_IWMPCdromCollection             = GUIDOF!IWMPCdromCollection;
const GUID IID_IWMPCdromRip                    = GUIDOF!IWMPCdromRip;
const GUID IID_IWMPClosedCaption               = GUIDOF!IWMPClosedCaption;
const GUID IID_IWMPClosedCaption2              = GUIDOF!IWMPClosedCaption2;
const GUID IID_IWMPContentContainer            = GUIDOF!IWMPContentContainer;
const GUID IID_IWMPContentContainerList        = GUIDOF!IWMPContentContainerList;
const GUID IID_IWMPContentPartner              = GUIDOF!IWMPContentPartner;
const GUID IID_IWMPContentPartnerCallback      = GUIDOF!IWMPContentPartnerCallback;
const GUID IID_IWMPControls                    = GUIDOF!IWMPControls;
const GUID IID_IWMPControls2                   = GUIDOF!IWMPControls2;
const GUID IID_IWMPControls3                   = GUIDOF!IWMPControls3;
const GUID IID_IWMPConvert                     = GUIDOF!IWMPConvert;
const GUID IID_IWMPCore                        = GUIDOF!IWMPCore;
const GUID IID_IWMPCore2                       = GUIDOF!IWMPCore2;
const GUID IID_IWMPCore3                       = GUIDOF!IWMPCore3;
const GUID IID_IWMPDVD                         = GUIDOF!IWMPDVD;
const GUID IID_IWMPDownloadCollection          = GUIDOF!IWMPDownloadCollection;
const GUID IID_IWMPDownloadItem                = GUIDOF!IWMPDownloadItem;
const GUID IID_IWMPDownloadItem2               = GUIDOF!IWMPDownloadItem2;
const GUID IID_IWMPDownloadManager             = GUIDOF!IWMPDownloadManager;
const GUID IID_IWMPEffects                     = GUIDOF!IWMPEffects;
const GUID IID_IWMPEffects2                    = GUIDOF!IWMPEffects2;
const GUID IID_IWMPError                       = GUIDOF!IWMPError;
const GUID IID_IWMPErrorItem                   = GUIDOF!IWMPErrorItem;
const GUID IID_IWMPErrorItem2                  = GUIDOF!IWMPErrorItem2;
const GUID IID_IWMPEvents                      = GUIDOF!IWMPEvents;
const GUID IID_IWMPEvents2                     = GUIDOF!IWMPEvents2;
const GUID IID_IWMPEvents3                     = GUIDOF!IWMPEvents3;
const GUID IID_IWMPEvents4                     = GUIDOF!IWMPEvents4;
const GUID IID_IWMPFolderMonitorServices       = GUIDOF!IWMPFolderMonitorServices;
const GUID IID_IWMPGraphCreation               = GUIDOF!IWMPGraphCreation;
const GUID IID_IWMPLibrary                     = GUIDOF!IWMPLibrary;
const GUID IID_IWMPLibrary2                    = GUIDOF!IWMPLibrary2;
const GUID IID_IWMPLibraryServices             = GUIDOF!IWMPLibraryServices;
const GUID IID_IWMPLibrarySharingServices      = GUIDOF!IWMPLibrarySharingServices;
const GUID IID_IWMPMedia                       = GUIDOF!IWMPMedia;
const GUID IID_IWMPMedia2                      = GUIDOF!IWMPMedia2;
const GUID IID_IWMPMedia3                      = GUIDOF!IWMPMedia3;
const GUID IID_IWMPMediaCollection             = GUIDOF!IWMPMediaCollection;
const GUID IID_IWMPMediaCollection2            = GUIDOF!IWMPMediaCollection2;
const GUID IID_IWMPMediaPluginRegistrar        = GUIDOF!IWMPMediaPluginRegistrar;
const GUID IID_IWMPMetadataPicture             = GUIDOF!IWMPMetadataPicture;
const GUID IID_IWMPMetadataText                = GUIDOF!IWMPMetadataText;
const GUID IID_IWMPNetwork                     = GUIDOF!IWMPNetwork;
const GUID IID_IWMPNodeRealEstate              = GUIDOF!IWMPNodeRealEstate;
const GUID IID_IWMPNodeRealEstateHost          = GUIDOF!IWMPNodeRealEstateHost;
const GUID IID_IWMPNodeWindowed                = GUIDOF!IWMPNodeWindowed;
const GUID IID_IWMPNodeWindowedHost            = GUIDOF!IWMPNodeWindowedHost;
const GUID IID_IWMPNodeWindowless              = GUIDOF!IWMPNodeWindowless;
const GUID IID_IWMPNodeWindowlessHost          = GUIDOF!IWMPNodeWindowlessHost;
const GUID IID_IWMPPlayer                      = GUIDOF!IWMPPlayer;
const GUID IID_IWMPPlayer2                     = GUIDOF!IWMPPlayer2;
const GUID IID_IWMPPlayer3                     = GUIDOF!IWMPPlayer3;
const GUID IID_IWMPPlayer4                     = GUIDOF!IWMPPlayer4;
const GUID IID_IWMPPlayerApplication           = GUIDOF!IWMPPlayerApplication;
const GUID IID_IWMPPlayerServices              = GUIDOF!IWMPPlayerServices;
const GUID IID_IWMPPlayerServices2             = GUIDOF!IWMPPlayerServices2;
const GUID IID_IWMPPlaylist                    = GUIDOF!IWMPPlaylist;
const GUID IID_IWMPPlaylistArray               = GUIDOF!IWMPPlaylistArray;
const GUID IID_IWMPPlaylistCollection          = GUIDOF!IWMPPlaylistCollection;
const GUID IID_IWMPPlugin                      = GUIDOF!IWMPPlugin;
const GUID IID_IWMPPluginEnable                = GUIDOF!IWMPPluginEnable;
const GUID IID_IWMPPluginUI                    = GUIDOF!IWMPPluginUI;
const GUID IID_IWMPQuery                       = GUIDOF!IWMPQuery;
const GUID IID_IWMPRemoteMediaServices         = GUIDOF!IWMPRemoteMediaServices;
const GUID IID_IWMPRenderConfig                = GUIDOF!IWMPRenderConfig;
const GUID IID_IWMPServices                    = GUIDOF!IWMPServices;
const GUID IID_IWMPSettings                    = GUIDOF!IWMPSettings;
const GUID IID_IWMPSettings2                   = GUIDOF!IWMPSettings2;
const GUID IID_IWMPSkinManager                 = GUIDOF!IWMPSkinManager;
const GUID IID_IWMPStringCollection            = GUIDOF!IWMPStringCollection;
const GUID IID_IWMPStringCollection2           = GUIDOF!IWMPStringCollection2;
const GUID IID_IWMPSubscriptionService         = GUIDOF!IWMPSubscriptionService;
const GUID IID_IWMPSubscriptionService2        = GUIDOF!IWMPSubscriptionService2;
const GUID IID_IWMPSubscriptionServiceCallback = GUIDOF!IWMPSubscriptionServiceCallback;
const GUID IID_IWMPSyncDevice                  = GUIDOF!IWMPSyncDevice;
const GUID IID_IWMPSyncDevice2                 = GUIDOF!IWMPSyncDevice2;
const GUID IID_IWMPSyncDevice3                 = GUIDOF!IWMPSyncDevice3;
const GUID IID_IWMPSyncServices                = GUIDOF!IWMPSyncServices;
const GUID IID_IWMPTranscodePolicy             = GUIDOF!IWMPTranscodePolicy;
const GUID IID_IWMPUserEventSink               = GUIDOF!IWMPUserEventSink;
const GUID IID_IWMPVideoRenderConfig           = GUIDOF!IWMPVideoRenderConfig;
const GUID IID_IWMPWindowMessageSink           = GUIDOF!IWMPWindowMessageSink;
const GUID IID_IXFeed                          = GUIDOF!IXFeed;
const GUID IID_IXFeed2                         = GUIDOF!IXFeed2;
const GUID IID_IXFeedEnclosure                 = GUIDOF!IXFeedEnclosure;
const GUID IID_IXFeedEvents                    = GUIDOF!IXFeedEvents;
const GUID IID_IXFeedFolder                    = GUIDOF!IXFeedFolder;
const GUID IID_IXFeedFolderEvents              = GUIDOF!IXFeedFolderEvents;
const GUID IID_IXFeedItem                      = GUIDOF!IXFeedItem;
const GUID IID_IXFeedItem2                     = GUIDOF!IXFeedItem2;
const GUID IID_IXFeedsEnum                     = GUIDOF!IXFeedsEnum;
const GUID IID_IXFeedsManager                  = GUIDOF!IXFeedsManager;
const GUID IID__WMPOCXEvents                   = GUIDOF!_WMPOCXEvents;
