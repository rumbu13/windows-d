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


enum WMPOpenState : int
{
    wmposUndefined               = 0x00000000,
    wmposPlaylistChanging        = 0x00000001,
    wmposPlaylistLocating        = 0x00000002,
    wmposPlaylistConnecting      = 0x00000003,
    wmposPlaylistLoading         = 0x00000004,
    wmposPlaylistOpening         = 0x00000005,
    wmposPlaylistOpenNoMedia     = 0x00000006,
    wmposPlaylistChanged         = 0x00000007,
    wmposMediaChanging           = 0x00000008,
    wmposMediaLocating           = 0x00000009,
    wmposMediaConnecting         = 0x0000000a,
    wmposMediaLoading            = 0x0000000b,
    wmposMediaOpening            = 0x0000000c,
    wmposMediaOpen               = 0x0000000d,
    wmposBeginCodecAcquisition   = 0x0000000e,
    wmposEndCodecAcquisition     = 0x0000000f,
    wmposBeginLicenseAcquisition = 0x00000010,
    wmposEndLicenseAcquisition   = 0x00000011,
    wmposBeginIndividualization  = 0x00000012,
    wmposEndIndividualization    = 0x00000013,
    wmposMediaWaiting            = 0x00000014,
    wmposOpeningUnknownURL       = 0x00000015,
}

enum WMPPlayState : int
{
    wmppsUndefined     = 0x00000000,
    wmppsStopped       = 0x00000001,
    wmppsPaused        = 0x00000002,
    wmppsPlaying       = 0x00000003,
    wmppsScanForward   = 0x00000004,
    wmppsScanReverse   = 0x00000005,
    wmppsBuffering     = 0x00000006,
    wmppsWaiting       = 0x00000007,
    wmppsMediaEnded    = 0x00000008,
    wmppsTransitioning = 0x00000009,
    wmppsReady         = 0x0000000a,
    wmppsReconnecting  = 0x0000000b,
    wmppsLast          = 0x0000000c,
}

enum WMPPlaylistChangeEventType : int
{
    wmplcUnknown    = 0x00000000,
    wmplcClear      = 0x00000001,
    wmplcInfoChange = 0x00000002,
    wmplcMove       = 0x00000003,
    wmplcDelete     = 0x00000004,
    wmplcInsert     = 0x00000005,
    wmplcAppend     = 0x00000006,
    wmplcPrivate    = 0x00000007,
    wmplcNameChange = 0x00000008,
    wmplcMorph      = 0x00000009,
    wmplcSort       = 0x0000000a,
    wmplcLast       = 0x0000000b,
}

enum WMPSyncState : int
{
    wmpssUnknown       = 0x00000000,
    wmpssSynchronizing = 0x00000001,
    wmpssStopped       = 0x00000002,
    wmpssEstimating    = 0x00000003,
    wmpssLast          = 0x00000004,
}

enum WMPDeviceStatus : int
{
    wmpdsUnknown             = 0x00000000,
    wmpdsPartnershipExists   = 0x00000001,
    wmpdsPartnershipDeclined = 0x00000002,
    wmpdsPartnershipAnother  = 0x00000003,
    wmpdsManualDevice        = 0x00000004,
    wmpdsNewDevice           = 0x00000005,
    wmpdsLast                = 0x00000006,
}

enum WMPRipState : int
{
    wmprsUnknown = 0x00000000,
    wmprsRipping = 0x00000001,
    wmprsStopped = 0x00000002,
}

enum WMPBurnFormat : int
{
    wmpbfAudioCD = 0x00000000,
    wmpbfDataCD  = 0x00000001,
}

enum WMPBurnState : int
{
    wmpbsUnknown              = 0x00000000,
    wmpbsBusy                 = 0x00000001,
    wmpbsReady                = 0x00000002,
    wmpbsWaitingForDisc       = 0x00000003,
    wmpbsRefreshStatusPending = 0x00000004,
    wmpbsPreparingToBurn      = 0x00000005,
    wmpbsBurning              = 0x00000006,
    wmpbsStopped              = 0x00000007,
    wmpbsErasing              = 0x00000008,
    wmpbsDownloading          = 0x00000009,
}

enum WMPStringCollectionChangeEventType : int
{
    wmpsccetUnknown      = 0x00000000,
    wmpsccetInsert       = 0x00000001,
    wmpsccetChange       = 0x00000002,
    wmpsccetDelete       = 0x00000003,
    wmpsccetClear        = 0x00000004,
    wmpsccetBeginUpdates = 0x00000005,
    wmpsccetEndUpdates   = 0x00000006,
}

enum WMPLibraryType : int
{
    wmpltUnknown        = 0x00000000,
    wmpltAll            = 0x00000001,
    wmpltLocal          = 0x00000002,
    wmpltRemote         = 0x00000003,
    wmpltDisc           = 0x00000004,
    wmpltPortableDevice = 0x00000005,
}

enum WMPFolderScanState : int
{
    wmpfssUnknown  = 0x00000000,
    wmpfssScanning = 0x00000001,
    wmpfssUpdating = 0x00000002,
    wmpfssStopped  = 0x00000003,
}

enum : int
{
    WMPServices_StreamState_Stop  = 0x00000000,
    WMPServices_StreamState_Pause = 0x00000001,
    WMPServices_StreamState_Play  = 0x00000002,
}
alias WMPServices_StreamState = int;

enum : int
{
    WMPPlugin_Caps_CannotConvertFormats = 0x00000001,
}
alias WMPPlugin_Caps = int;

enum : int
{
    FBSA_DISABLE = 0x00000000,
    FBSA_ENABLE  = 0x00000001,
    FBSA_RUNNOW  = 0x00000002,
}
alias FEEDS_BACKGROUNDSYNC_ACTION = int;

enum : int
{
    FBSS_DISABLED = 0x00000000,
    FBSS_ENABLED  = 0x00000001,
}
alias FEEDS_BACKGROUNDSYNC_STATUS = int;

enum : int
{
    FES_ALL                    = 0x00000000,
    FES_SELF_ONLY              = 0x00000001,
    FES_SELF_AND_CHILDREN_ONLY = 0x00000002,
}
alias FEEDS_EVENTS_SCOPE = int;

enum : int
{
    FEM_FOLDEREVENTS = 0x00000001,
    FEM_FEEDEVENTS   = 0x00000002,
}
alias FEEDS_EVENTS_MASK = int;

enum : int
{
    FXSP_NONE         = 0x00000000,
    FXSP_PUBDATE      = 0x00000001,
    FXSP_DOWNLOADTIME = 0x00000002,
}
alias FEEDS_XML_SORT_PROPERTY = int;

enum : int
{
    FXSO_NONE       = 0x00000000,
    FXSO_ASCENDING  = 0x00000001,
    FXSO_DESCENDING = 0x00000002,
}
alias FEEDS_XML_SORT_ORDER = int;

enum : int
{
    FXFF_ALL    = 0x00000000,
    FXFF_UNREAD = 0x00000001,
    FXFF_READ   = 0x00000002,
}
alias FEEDS_XML_FILTER_FLAGS = int;

enum : int
{
    FXIF_NONE          = 0x00000000,
    FXIF_CF_EXTENSIONS = 0x00000001,
}
alias FEEDS_XML_INCLUDE_FLAGS = int;

enum : int
{
    FDS_NONE            = 0x00000000,
    FDS_PENDING         = 0x00000001,
    FDS_DOWNLOADING     = 0x00000002,
    FDS_DOWNLOADED      = 0x00000003,
    FDS_DOWNLOAD_FAILED = 0x00000004,
}
alias FEEDS_DOWNLOAD_STATUS = int;

enum : int
{
    FSS_DEFAULT   = 0x00000000,
    FSS_INTERVAL  = 0x00000001,
    FSS_MANUAL    = 0x00000002,
    FSS_SUGGESTED = 0x00000003,
}
alias FEEDS_SYNC_SETTING = int;

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
alias FEEDS_DOWNLOAD_ERROR = int;

enum : int
{
    FEICF_READ_ITEM_COUNT_CHANGED   = 0x00000001,
    FEICF_UNREAD_ITEM_COUNT_CHANGED = 0x00000002,
}
alias FEEDS_EVENTS_ITEM_COUNT_FLAGS = int;

enum : int
{
    FEC_E_ERRORBASE                 = 0xc0040200,
    FEC_E_INVALIDMSXMLPROPERTY      = 0xc0040200,
    FEC_E_DOWNLOADSIZELIMITEXCEEDED = 0xc0040201,
}
alias FEEDS_ERROR_CODE = int;

enum PlayerState : int
{
    stop_state  = 0x00000000,
    pause_state = 0x00000001,
    play_state  = 0x00000002,
}

enum WMPPartnerNotification : int
{
    wmpsnBackgroundProcessingBegin = 0x00000001,
    wmpsnBackgroundProcessingEnd   = 0x00000002,
    wmpsnCatalogDownloadFailure    = 0x00000003,
    wmpsnCatalogDownloadComplete   = 0x00000004,
}

enum WMPCallbackNotification : int
{
    wmpcnLoginStateChange     = 0x00000001,
    wmpcnAuthResult           = 0x00000002,
    wmpcnLicenseUpdated       = 0x00000003,
    wmpcnNewCatalogAvailable  = 0x00000004,
    wmpcnNewPluginAvailable   = 0x00000005,
    wmpcnDisableRadioSkipping = 0x00000006,
}

enum WMPTaskType : int
{
    wmpttBrowse  = 0x00000001,
    wmpttSync    = 0x00000002,
    wmpttBurn    = 0x00000003,
    wmpttCurrent = 0x00000004,
}

enum WMPTransactionType : int
{
    wmpttNoTransaction = 0x00000000,
    wmpttDownload      = 0x00000001,
    wmpttBuy           = 0x00000002,
}

enum WMPTemplateSize : int
{
    wmptsSmall  = 0x00000000,
    wmptsMedium = 0x00000001,
    wmptsLarge  = 0x00000002,
}

enum WMPStreamingType : int
{
    wmpstUnknown = 0x00000000,
    wmpstMusic   = 0x00000001,
    wmpstVideo   = 0x00000002,
    wmpstRadio   = 0x00000003,
}

enum WMPAccountType : int
{
    wmpatBuyOnly      = 0x00000001,
    wmpatSubscription = 0x00000002,
    wmpatJanus        = 0x00000003,
}

enum WMPSubscriptionServiceEvent : int
{
    wmpsseCurrentBegin = 0x00000001,
    wmpsseCurrentEnd   = 0x00000002,
    wmpsseFullBegin    = 0x00000003,
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


struct TimedLevel
{
    ubyte[2048] frequency;
    ubyte[2048] waveform;
    int         state;
    long        timeStamp;
}

struct WMPContextMenuInfo
{
    uint dwID;
    BSTR bstrMenuText;
    BSTR bstrHelpText;
}

struct WMP_WMDM_METADATA_ROUND_TRIP_PC2DEVICE
{
align (1):
    uint dwChangesSinceTransactionID;
    uint dwResultSetStartingIndex;
}

struct WMP_WMDM_METADATA_ROUND_TRIP_DEVICE2PC
{
align (1):
    uint      dwCurrentTransactionID;
    uint      dwReturnedObjectCount;
    uint      dwUnretrievedObjectCount;
    uint      dwDeletedObjectStartingOffset;
    uint      dwFlags;
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

@GUID("3614C646-3B3B-4DE7-A81E-930E3F2127B3")
interface IWMPErrorItem : IDispatch
{
    HRESULT get_errorCode(int* phr);
    HRESULT get_errorDescription(BSTR* pbstrDescription);
    HRESULT get_errorContext(VARIANT* pvarContext);
    HRESULT get_remedy(int* plRemedy);
    HRESULT get_customUrl(BSTR* pbstrCustomUrl);
}

@GUID("A12DCF7D-14AB-4C1B-A8CD-63909F06025B")
interface IWMPError : IDispatch
{
    HRESULT clearErrorQueue();
    HRESULT get_errorCount(int* plNumErrors);
    HRESULT get_item(int dwIndex, IWMPErrorItem* ppErrorItem);
    HRESULT webHelp();
}

@GUID("94D55E95-3FAC-11D3-B155-00C04F79FAA6")
interface IWMPMedia : IDispatch
{
    HRESULT get_isIdentical(IWMPMedia pIWMPMedia, short* pvbool);
    HRESULT get_sourceURL(BSTR* pbstrSourceURL);
    HRESULT get_name(BSTR* pbstrName);
    HRESULT put_name(BSTR bstrName);
    HRESULT get_imageSourceWidth(int* pWidth);
    HRESULT get_imageSourceHeight(int* pHeight);
    HRESULT get_markerCount(int* pMarkerCount);
    HRESULT getMarkerTime(int MarkerNum, double* pMarkerTime);
    HRESULT getMarkerName(int MarkerNum, BSTR* pbstrMarkerName);
    HRESULT get_duration(double* pDuration);
    HRESULT get_durationString(BSTR* pbstrDuration);
    HRESULT get_attributeCount(int* plCount);
    HRESULT getAttributeName(int lIndex, BSTR* pbstrItemName);
    HRESULT getItemInfo(BSTR bstrItemName, BSTR* pbstrVal);
    HRESULT setItemInfo(BSTR bstrItemName, BSTR bstrVal);
    HRESULT getItemInfoByAtom(int lAtom, BSTR* pbstrVal);
    HRESULT isMemberOf(IWMPPlaylist pPlaylist, short* pvarfIsMemberOf);
    HRESULT isReadOnlyItem(BSTR bstrItemName, short* pvarfIsReadOnly);
}

@GUID("74C09E02-F828-11D2-A74B-00A0C905F36E")
interface IWMPControls : IDispatch
{
    HRESULT get_isAvailable(BSTR bstrItem, short* pIsAvailable);
    HRESULT play();
    HRESULT stop();
    HRESULT pause();
    HRESULT fastForward();
    HRESULT fastReverse();
    HRESULT get_currentPosition(double* pdCurrentPosition);
    HRESULT put_currentPosition(double dCurrentPosition);
    HRESULT get_currentPositionString(BSTR* pbstrCurrentPosition);
    HRESULT next();
    HRESULT previous();
    HRESULT get_currentItem(IWMPMedia* ppIWMPMedia);
    HRESULT put_currentItem(IWMPMedia pIWMPMedia);
    HRESULT get_currentMarker(int* plMarker);
    HRESULT put_currentMarker(int lMarker);
    HRESULT playItem(IWMPMedia pIWMPMedia);
}

@GUID("9104D1AB-80C9-4FED-ABF0-2E6417A6DF14")
interface IWMPSettings : IDispatch
{
    HRESULT get_isAvailable(BSTR bstrItem, short* pIsAvailable);
    HRESULT get_autoStart(short* pfAutoStart);
    HRESULT put_autoStart(short fAutoStart);
    HRESULT get_baseURL(BSTR* pbstrBaseURL);
    HRESULT put_baseURL(BSTR bstrBaseURL);
    HRESULT get_defaultFrame(BSTR* pbstrDefaultFrame);
    HRESULT put_defaultFrame(BSTR bstrDefaultFrame);
    HRESULT get_invokeURLs(short* pfInvokeURLs);
    HRESULT put_invokeURLs(short fInvokeURLs);
    HRESULT get_mute(short* pfMute);
    HRESULT put_mute(short fMute);
    HRESULT get_playCount(int* plCount);
    HRESULT put_playCount(int lCount);
    HRESULT get_rate(double* pdRate);
    HRESULT put_rate(double dRate);
    HRESULT get_balance(int* plBalance);
    HRESULT put_balance(int lBalance);
    HRESULT get_volume(int* plVolume);
    HRESULT put_volume(int lVolume);
    HRESULT getMode(BSTR bstrMode, short* pvarfMode);
    HRESULT setMode(BSTR bstrMode, short varfMode);
    HRESULT get_enableErrorDialogs(short* pfEnableErrorDialogs);
    HRESULT put_enableErrorDialogs(short fEnableErrorDialogs);
}

@GUID("4F2DF574-C588-11D3-9ED0-00C04FB6E937")
interface IWMPClosedCaption : IDispatch
{
    HRESULT get_SAMIStyle(BSTR* pbstrSAMIStyle);
    HRESULT put_SAMIStyle(BSTR bstrSAMIStyle);
    HRESULT get_SAMILang(BSTR* pbstrSAMILang);
    HRESULT put_SAMILang(BSTR bstrSAMILang);
    HRESULT get_SAMIFileName(BSTR* pbstrSAMIFileName);
    HRESULT put_SAMIFileName(BSTR bstrSAMIFileName);
    HRESULT get_captioningId(BSTR* pbstrCaptioningID);
    HRESULT put_captioningId(BSTR bstrCaptioningID);
}

@GUID("D5F0F4F1-130C-11D3-B14E-00C04F79FAA6")
interface IWMPPlaylist : IDispatch
{
    HRESULT get_count(int* plCount);
    HRESULT get_name(BSTR* pbstrName);
    HRESULT put_name(BSTR bstrName);
    HRESULT get_attributeCount(int* plCount);
    HRESULT get_attributeName(int lIndex, BSTR* pbstrAttributeName);
    HRESULT get_item(int lIndex, IWMPMedia* ppIWMPMedia);
    HRESULT getItemInfo(BSTR bstrName, BSTR* pbstrVal);
    HRESULT setItemInfo(BSTR bstrName, BSTR bstrValue);
    HRESULT get_isIdentical(IWMPPlaylist pIWMPPlaylist, short* pvbool);
    HRESULT clear();
    HRESULT insertItem(int lIndex, IWMPMedia pIWMPMedia);
    HRESULT appendItem(IWMPMedia pIWMPMedia);
    HRESULT removeItem(IWMPMedia pIWMPMedia);
    HRESULT moveItem(int lIndexOld, int lIndexNew);
}

@GUID("CFAB6E98-8730-11D3-B388-00C04F68574B")
interface IWMPCdrom : IDispatch
{
    HRESULT get_driveSpecifier(BSTR* pbstrDrive);
    HRESULT get_playlist(IWMPPlaylist* ppPlaylist);
    HRESULT eject();
}

@GUID("EE4C8FE2-34B2-11D3-A3BF-006097C9B344")
interface IWMPCdromCollection : IDispatch
{
    HRESULT get_count(int* plCount);
    HRESULT item(int lIndex, IWMPCdrom* ppItem);
    HRESULT getByDriveSpecifier(BSTR bstrDriveSpecifier, IWMPCdrom* ppCdrom);
}

@GUID("4A976298-8C0D-11D3-B389-00C04F68574B")
interface IWMPStringCollection : IDispatch
{
    HRESULT get_count(int* plCount);
    HRESULT item(int lIndex, BSTR* pbstrString);
}

@GUID("8363BC22-B4B4-4B19-989D-1CD765749DD1")
interface IWMPMediaCollection : IDispatch
{
    HRESULT add(BSTR bstrURL, IWMPMedia* ppItem);
    HRESULT getAll(IWMPPlaylist* ppMediaItems);
    HRESULT getByName(BSTR bstrName, IWMPPlaylist* ppMediaItems);
    HRESULT getByGenre(BSTR bstrGenre, IWMPPlaylist* ppMediaItems);
    HRESULT getByAuthor(BSTR bstrAuthor, IWMPPlaylist* ppMediaItems);
    HRESULT getByAlbum(BSTR bstrAlbum, IWMPPlaylist* ppMediaItems);
    HRESULT getByAttribute(BSTR bstrAttribute, BSTR bstrValue, IWMPPlaylist* ppMediaItems);
    HRESULT remove(IWMPMedia pItem, short varfDeleteFile);
    HRESULT getAttributeStringCollection(BSTR bstrAttribute, BSTR bstrMediaType, 
                                         IWMPStringCollection* ppStringCollection);
    HRESULT getMediaAtom(BSTR bstrItemName, int* plAtom);
    HRESULT setDeleted(IWMPMedia pItem, short varfIsDeleted);
    HRESULT isDeleted(IWMPMedia pItem, short* pvarfIsDeleted);
}

@GUID("679409C0-99F7-11D3-9FB7-00105AA620BB")
interface IWMPPlaylistArray : IDispatch
{
    HRESULT get_count(int* plCount);
    HRESULT item(int lIndex, IWMPPlaylist* ppItem);
}

@GUID("10A13217-23A7-439B-B1C0-D847C79B7774")
interface IWMPPlaylistCollection : IDispatch
{
    HRESULT newPlaylist(BSTR bstrName, IWMPPlaylist* ppItem);
    HRESULT getAll(IWMPPlaylistArray* ppPlaylistArray);
    HRESULT getByName(BSTR bstrName, IWMPPlaylistArray* ppPlaylistArray);
    HRESULT remove(IWMPPlaylist pItem);
    HRESULT setDeleted(IWMPPlaylist pItem, short varfIsDeleted);
    HRESULT isDeleted(IWMPPlaylist pItem, short* pvarfIsDeleted);
    HRESULT importPlaylist(IWMPPlaylist pItem, IWMPPlaylist* ppImportedItem);
}

@GUID("EC21B779-EDEF-462D-BBA4-AD9DDE2B29A7")
interface IWMPNetwork : IDispatch
{
    HRESULT get_bandWidth(int* plBandwidth);
    HRESULT get_recoveredPackets(int* plRecoveredPackets);
    HRESULT get_sourceProtocol(BSTR* pbstrSourceProtocol);
    HRESULT get_receivedPackets(int* plReceivedPackets);
    HRESULT get_lostPackets(int* plLostPackets);
    HRESULT get_receptionQuality(int* plReceptionQuality);
    HRESULT get_bufferingCount(int* plBufferingCount);
    HRESULT get_bufferingProgress(int* plBufferingProgress);
    HRESULT get_bufferingTime(int* plBufferingTime);
    HRESULT put_bufferingTime(int lBufferingTime);
    HRESULT get_frameRate(int* plFrameRate);
    HRESULT get_maxBitRate(int* plBitRate);
    HRESULT get_bitRate(int* plBitRate);
    HRESULT getProxySettings(BSTR bstrProtocol, int* plProxySetting);
    HRESULT setProxySettings(BSTR bstrProtocol, int lProxySetting);
    HRESULT getProxyName(BSTR bstrProtocol, BSTR* pbstrProxyName);
    HRESULT setProxyName(BSTR bstrProtocol, BSTR bstrProxyName);
    HRESULT getProxyPort(BSTR bstrProtocol, int* lProxyPort);
    HRESULT setProxyPort(BSTR bstrProtocol, int lProxyPort);
    HRESULT getProxyExceptionList(BSTR bstrProtocol, BSTR* pbstrExceptionList);
    HRESULT setProxyExceptionList(BSTR bstrProtocol, BSTR pbstrExceptionList);
    HRESULT getProxyBypassForLocal(BSTR bstrProtocol, short* pfBypassForLocal);
    HRESULT setProxyBypassForLocal(BSTR bstrProtocol, short fBypassForLocal);
    HRESULT get_maxBandwidth(int* lMaxBandwidth);
    HRESULT put_maxBandwidth(int lMaxBandwidth);
    HRESULT get_downloadProgress(int* plDownloadProgress);
    HRESULT get_encodedFrameRate(int* plFrameRate);
    HRESULT get_framesSkipped(int* plFrames);
}

@GUID("D84CCA99-CCE2-11D2-9ECC-0000F8085981")
interface IWMPCore : IDispatch
{
    HRESULT close();
    HRESULT get_URL(BSTR* pbstrURL);
    HRESULT put_URL(BSTR bstrURL);
    HRESULT get_openState(WMPOpenState* pwmpos);
    HRESULT get_playState(WMPPlayState* pwmpps);
    HRESULT get_controls(IWMPControls* ppControl);
    HRESULT get_settings(IWMPSettings* ppSettings);
    HRESULT get_currentMedia(IWMPMedia* ppMedia);
    HRESULT put_currentMedia(IWMPMedia pMedia);
    HRESULT get_mediaCollection(IWMPMediaCollection* ppMediaCollection);
    HRESULT get_playlistCollection(IWMPPlaylistCollection* ppPlaylistCollection);
    HRESULT get_versionInfo(BSTR* pbstrVersionInfo);
    HRESULT launchURL(BSTR bstrURL);
    HRESULT get_network(IWMPNetwork* ppQNI);
    HRESULT get_currentPlaylist(IWMPPlaylist* ppPL);
    HRESULT put_currentPlaylist(IWMPPlaylist pPL);
    HRESULT get_cdromCollection(IWMPCdromCollection* ppCdromCollection);
    HRESULT get_closedCaption(IWMPClosedCaption* ppClosedCaption);
    HRESULT get_isOnline(short* pfOnline);
    HRESULT get_error(IWMPError* ppError);
    HRESULT get_status(BSTR* pbstrStatus);
}

@GUID("6BF52A4F-394A-11D3-B153-00C04F79FAA6")
interface IWMPPlayer : IWMPCore
{
    HRESULT get_enabled(short* pbEnabled);
    HRESULT put_enabled(short bEnabled);
    HRESULT get_fullScreen(short* pbFullScreen);
    HRESULT put_fullScreen(short bFullScreen);
    HRESULT get_enableContextMenu(short* pbEnableContextMenu);
    HRESULT put_enableContextMenu(short bEnableContextMenu);
    HRESULT put_uiMode(BSTR bstrMode);
    HRESULT get_uiMode(BSTR* pbstrMode);
}

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
    HRESULT get_stretchToFit(short* pbEnabled);
    HRESULT put_stretchToFit(short bEnabled);
    HRESULT get_windowlessVideo(short* pbEnabled);
    HRESULT put_windowlessVideo(short bEnabled);
}

@GUID("AB7C88BB-143E-4EA4-ACC3-E4350B2106C3")
interface IWMPMedia2 : IWMPMedia
{
    HRESULT get_error(IWMPErrorItem* ppIWMPErrorItem);
}

@GUID("6F030D25-0890-480F-9775-1F7E40AB5B8E")
interface IWMPControls2 : IWMPControls
{
    HRESULT step(int lStep);
}

@GUID("8DA61686-4668-4A5C-AE5D-803193293DBE")
interface IWMPDVD : IDispatch
{
    HRESULT get_isAvailable(BSTR bstrItem, short* pIsAvailable);
    HRESULT get_domain(BSTR* strDomain);
    HRESULT topMenu();
    HRESULT titleMenu();
    HRESULT back();
    HRESULT resume();
}

@GUID("BC17E5B7-7561-4C18-BB90-17D485775659")
interface IWMPCore2 : IWMPCore
{
    HRESULT get_dvd(IWMPDVD* ppDVD);
}

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

@GUID("F75CCEC0-C67C-475C-931E-8719870BEE7D")
interface IWMPErrorItem2 : IWMPErrorItem
{
    HRESULT get_condition(int* plCondition);
}

@GUID("CBB92747-741F-44FE-AB5B-F1A48F3B2A59")
interface IWMPRemoteMediaServices : IUnknown
{
    HRESULT GetServiceType(BSTR* pbstrType);
    HRESULT GetApplicationName(BSTR* pbstrName);
    HRESULT GetScriptableObject(BSTR* pbstrName, IDispatch* ppDispatch);
    HRESULT GetCustomUIMode(BSTR* pbstrFile);
}

@GUID("076F2FA6-ED30-448B-8CC5-3F3EF3529C7A")
interface IWMPSkinManager : IUnknown
{
    HRESULT SetVisualStyle(BSTR bstrPath);
}

@GUID("5C29BBE0-F87D-4C45-AA28-A70F0230FFA9")
interface IWMPMetadataPicture : IDispatch
{
    HRESULT get_mimeType(BSTR* pbstrMimeType);
    HRESULT get_pictureType(BSTR* pbstrPictureType);
    HRESULT get_description(BSTR* pbstrDescription);
    HRESULT get_URL(BSTR* pbstrURL);
}

@GUID("769A72DB-13D2-45E2-9C48-53CA9D5B7450")
interface IWMPMetadataText : IDispatch
{
    HRESULT get_description(BSTR* pbstrDescription);
    HRESULT get_text(BSTR* pbstrText);
}

@GUID("F118EFC7-F03A-4FB4-99C9-1C02A5C1065B")
interface IWMPMedia3 : IWMPMedia2
{
    HRESULT getAttributeCountByType(BSTR bstrType, BSTR bstrLanguage, int* plCount);
    HRESULT getItemInfoByType(BSTR bstrType, BSTR bstrLanguage, int lIndex, VARIANT* pvarValue);
}

@GUID("FDA937A4-EECE-4DA5-A0B6-39BF89ADE2C2")
interface IWMPSettings2 : IWMPSettings
{
    HRESULT get_defaultAudioLanguage(int* plLangID);
    HRESULT get_mediaAccessRights(BSTR* pbstrRights);
    HRESULT requestMediaAccessRights(BSTR bstrDesiredAccess, short* pvbAccepted);
}

@GUID("A1D1110E-D545-476A-9A78-AC3E4CB1E6BD")
interface IWMPControls3 : IWMPControls2
{
    HRESULT get_audioLanguageCount(int* plCount);
    HRESULT getAudioLanguageID(int lIndex, int* plLangID);
    HRESULT getAudioLanguageDescription(int lIndex, BSTR* pbstrLangDesc);
    HRESULT get_currentAudioLanguage(int* plLangID);
    HRESULT put_currentAudioLanguage(int lLangID);
    HRESULT get_currentAudioLanguageIndex(int* plIndex);
    HRESULT put_currentAudioLanguageIndex(int lIndex);
    HRESULT getLanguageName(int lLangID, BSTR* pbstrLangName);
    HRESULT get_currentPositionTimecode(BSTR* bstrTimecode);
    HRESULT put_currentPositionTimecode(BSTR bstrTimecode);
}

@GUID("350BA78B-6BC8-4113-A5F5-312056934EB6")
interface IWMPClosedCaption2 : IWMPClosedCaption
{
    HRESULT get_SAMILangCount(int* plCount);
    HRESULT getSAMILangName(int nIndex, BSTR* pbstrName);
    HRESULT getSAMILangID(int nIndex, int* plLangID);
    HRESULT get_SAMIStyleCount(int* plCount);
    HRESULT getSAMIStyleName(int nIndex, BSTR* pbstrName);
}

@GUID("40897764-CEAB-47BE-AD4A-8E28537F9BBF")
interface IWMPPlayerApplication : IDispatch
{
    HRESULT switchToPlayerApplication();
    HRESULT switchToControl();
    HRESULT get_playerDocked(short* pbPlayerDocked);
    HRESULT get_hasDisplay(short* pbHasDisplay);
}

@GUID("7587C667-628F-499F-88E7-6A6F4E888464")
interface IWMPCore3 : IWMPCore2
{
    HRESULT newPlaylist(BSTR bstrName, BSTR bstrURL, IWMPPlaylist* ppPlaylist);
    HRESULT newMedia(BSTR bstrURL, IWMPMedia* ppMedia);
}

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
    HRESULT get_isRemote(short* pvarfIsRemote);
    HRESULT get_playerApplication(IWMPPlayerApplication* ppIWMPPlayerApplication);
    HRESULT openPlayer(BSTR bstrURL);
}

@GUID("1D01FBDB-ADE2-4C8D-9842-C190B95C3306")
interface IWMPPlayerServices : IUnknown
{
    HRESULT activateUIPlugin(BSTR bstrPlugin);
    HRESULT setTaskPane(BSTR bstrTaskPane);
    HRESULT setTaskPaneURL(BSTR bstrTaskPane, BSTR bstrURL, BSTR bstrFriendlyName);
}

@GUID("82A2986C-0293-4FD0-B279-B21B86C058BE")
interface IWMPSyncDevice : IUnknown
{
    HRESULT get_friendlyName(BSTR* pbstrName);
    HRESULT put_friendlyName(BSTR bstrName);
    HRESULT get_deviceName(BSTR* pbstrName);
    HRESULT get_deviceId(BSTR* pbstrDeviceId);
    HRESULT get_partnershipIndex(int* plIndex);
    HRESULT get_connected(short* pvbConnected);
    HRESULT get_status(WMPDeviceStatus* pwmpds);
    HRESULT get_syncState(WMPSyncState* pwmpss);
    HRESULT get_progress(int* plProgress);
    HRESULT getItemInfo(BSTR bstrItemName, BSTR* pbstrVal);
    HRESULT createPartnership(short vbShowUI);
    HRESULT deletePartnership();
    HRESULT start();
    HRESULT stop();
    HRESULT showSettings();
    HRESULT isIdentical(IWMPSyncDevice pDevice, short* pvbool);
}

@GUID("8B5050FF-E0A4-4808-B3A8-893A9E1ED894")
interface IWMPSyncServices : IUnknown
{
    HRESULT get_deviceCount(int* plCount);
    HRESULT getDevice(int lIndex, IWMPSyncDevice* ppDevice);
}

@GUID("1BB1592F-F040-418A-9F71-17C7512B4D70")
interface IWMPPlayerServices2 : IWMPPlayerServices
{
    HRESULT setBackgroundProcessingPriority(BSTR bstrPriority);
}

@GUID("56E2294F-69ED-4629-A869-AEA72C0DCC2C")
interface IWMPCdromRip : IUnknown
{
    HRESULT get_ripState(WMPRipState* pwmprs);
    HRESULT get_ripProgress(int* plProgress);
    HRESULT startRip();
    HRESULT stopRip();
}

@GUID("BD94DBEB-417F-4928-AA06-087D56ED9B59")
interface IWMPCdromBurn : IUnknown
{
    HRESULT isAvailable(BSTR bstrItem, short* pIsAvailable);
    HRESULT getItemInfo(BSTR bstrItem, BSTR* pbstrVal);
    HRESULT get_label(BSTR* pbstrLabel);
    HRESULT put_label(BSTR bstrLabel);
    HRESULT get_burnFormat(WMPBurnFormat* pwmpbf);
    HRESULT put_burnFormat(WMPBurnFormat wmpbf);
    HRESULT get_burnPlaylist(IWMPPlaylist* ppPlaylist);
    HRESULT put_burnPlaylist(IWMPPlaylist pPlaylist);
    HRESULT refreshStatus();
    HRESULT get_burnState(WMPBurnState* pwmpbs);
    HRESULT get_burnProgress(int* plProgress);
    HRESULT startBurn();
    HRESULT stopBurn();
    HRESULT erase();
}

@GUID("A00918F3-A6B0-4BFB-9189-FD834C7BC5A5")
interface IWMPQuery : IDispatch
{
    HRESULT addCondition(BSTR bstrAttribute, BSTR bstrOperator, BSTR bstrValue);
    HRESULT beginNextGroup();
}

@GUID("8BA957F5-FD8C-4791-B82D-F840401EE474")
interface IWMPMediaCollection2 : IWMPMediaCollection
{
    HRESULT createQuery(IWMPQuery* ppQuery);
    HRESULT getPlaylistByQuery(IWMPQuery pQuery, BSTR bstrMediaType, BSTR bstrSortAttribute, short fSortAscending, 
                               IWMPPlaylist* ppPlaylist);
    HRESULT getStringCollectionByQuery(BSTR bstrAttribute, IWMPQuery pQuery, BSTR bstrMediaType, 
                                       BSTR bstrSortAttribute, short fSortAscending, 
                                       IWMPStringCollection* ppStringCollection);
    HRESULT getByAttributeAndMediaType(BSTR bstrAttribute, BSTR bstrValue, BSTR bstrMediaType, 
                                       IWMPPlaylist* ppMediaItems);
}

@GUID("46AD648D-53F1-4A74-92E2-2A1B68D63FD4")
interface IWMPStringCollection2 : IWMPStringCollection
{
    HRESULT isIdentical(IWMPStringCollection2 pIWMPStringCollection2, short* pvbool);
    HRESULT getItemInfo(int lCollectionIndex, BSTR bstrItemName, BSTR* pbstrValue);
    HRESULT getAttributeCountByType(int lCollectionIndex, BSTR bstrType, BSTR bstrLanguage, int* plCount);
    HRESULT getItemInfoByType(int lCollectionIndex, BSTR bstrType, BSTR bstrLanguage, int lAttributeIndex, 
                              VARIANT* pvarValue);
}

@GUID("3DF47861-7DF1-4C1F-A81B-4C26F0F7A7C6")
interface IWMPLibrary : IUnknown
{
    HRESULT get_name(BSTR* pbstrName);
    HRESULT get_type(WMPLibraryType* pwmplt);
    HRESULT get_mediaCollection(IWMPMediaCollection* ppIWMPMediaCollection);
    HRESULT isIdentical(IWMPLibrary pIWMPLibrary, short* pvbool);
}

@GUID("39C2F8D5-1CF2-4D5E-AE09-D73492CF9EAA")
interface IWMPLibraryServices : IUnknown
{
    HRESULT getCountByType(WMPLibraryType wmplt, int* plCount);
    HRESULT getLibraryByType(WMPLibraryType wmplt, int lIndex, IWMPLibrary* ppIWMPLibrary);
}

@GUID("82CBA86B-9F04-474B-A365-D6DD1466E541")
interface IWMPLibrarySharingServices : IUnknown
{
    HRESULT isLibraryShared(short* pvbShared);
    HRESULT isLibrarySharingEnabled(short* pvbEnabled);
    HRESULT showLibrarySharing();
}

@GUID("788C8743-E57F-439D-A468-5BC77F2E59C6")
interface IWMPFolderMonitorServices : IUnknown
{
    HRESULT get_count(int* plCount);
    HRESULT item(int lIndex, BSTR* pbstrFolder);
    HRESULT add(BSTR bstrFolder);
    HRESULT remove(int lIndex);
    HRESULT get_scanState(WMPFolderScanState* pwmpfss);
    HRESULT get_currentFolder(BSTR* pbstrFolder);
    HRESULT get_scannedFilesCount(int* plCount);
    HRESULT get_addedFilesCount(int* plCount);
    HRESULT get_updateProgress(int* plProgress);
    HRESULT startScan();
    HRESULT stopScan();
}

@GUID("88AFB4B2-140A-44D2-91E6-4543DA467CD1")
interface IWMPSyncDevice2 : IWMPSyncDevice
{
    HRESULT setItemInfo(BSTR bstrItemName, BSTR bstrVal);
}

@GUID("B22C85F9-263C-4372-A0DA-B518DB9B4098")
interface IWMPSyncDevice3 : IWMPSyncDevice2
{
    HRESULT estimateSyncSize(IWMPPlaylist pNonRulePlaylist, IWMPPlaylist pRulesPlaylist);
    HRESULT cancelEstimation();
}

@GUID("DD578A4E-79B1-426C-BF8F-3ADD9072500B")
interface IWMPLibrary2 : IWMPLibrary
{
    HRESULT getItemInfo(BSTR bstrItemName, BSTR* pbstrVal);
}

@GUID("19A6627B-DA9E-47C1-BB23-00B5E668236A")
interface IWMPEvents : IUnknown
{
    void OpenStateChange(int NewState);
    void PlayStateChange(int NewState);
    void AudioLanguageChange(int LangID);
    void StatusChange();
    void ScriptCommand(BSTR scType, BSTR Param);
    void NewStream();
    void Disconnect(int Result);
    void Buffering(short Start);
    void Error();
    void Warning(int WarningType, int Param, BSTR Description);
    void EndOfStream(int Result);
    void PositionChange(double oldPosition, double newPosition);
    void MarkerHit(int MarkerNum);
    void DurationUnitChange(int NewDurationUnit);
    void CdromMediaChange(int CdromNum);
    void PlaylistChange(IDispatch Playlist, WMPPlaylistChangeEventType change);
    void CurrentPlaylistChange(WMPPlaylistChangeEventType change);
    void CurrentPlaylistItemAvailable(BSTR bstrItemName);
    void MediaChange(IDispatch Item);
    void CurrentMediaItemAvailable(BSTR bstrItemName);
    void CurrentItemChange(IDispatch pdispMedia);
    void MediaCollectionChange();
    void MediaCollectionAttributeStringAdded(BSTR bstrAttribName, BSTR bstrAttribVal);
    void MediaCollectionAttributeStringRemoved(BSTR bstrAttribName, BSTR bstrAttribVal);
    void MediaCollectionAttributeStringChanged(BSTR bstrAttribName, BSTR bstrOldAttribVal, BSTR bstrNewAttribVal);
    void PlaylistCollectionChange();
    void PlaylistCollectionPlaylistAdded(BSTR bstrPlaylistName);
    void PlaylistCollectionPlaylistRemoved(BSTR bstrPlaylistName);
    void PlaylistCollectionPlaylistSetAsDeleted(BSTR bstrPlaylistName, short varfIsDeleted);
    void ModeChange(BSTR ModeName, short NewValue);
    void MediaError(IDispatch pMediaObject);
    void OpenPlaylistSwitch(IDispatch pItem);
    void DomainChange(BSTR strDomain);
    void SwitchedToPlayerApplication();
    void SwitchedToControl();
    void PlayerDockedStateChange();
    void PlayerReconnect();
    void Click(short nButton, short nShiftState, int fX, int fY);
    void DoubleClick(short nButton, short nShiftState, int fX, int fY);
    void KeyDown(short nKeyCode, short nShiftState);
    void KeyPress(short nKeyAscii);
    void KeyUp(short nKeyCode, short nShiftState);
    void MouseDown(short nButton, short nShiftState, int fX, int fY);
    void MouseMove(short nButton, short nShiftState, int fX, int fY);
    void MouseUp(short nButton, short nShiftState, int fX, int fY);
}

@GUID("1E7601FA-47EA-4107-9EA9-9004ED9684FF")
interface IWMPEvents2 : IWMPEvents
{
    void DeviceConnect(IWMPSyncDevice pDevice);
    void DeviceDisconnect(IWMPSyncDevice pDevice);
    void DeviceStatusChange(IWMPSyncDevice pDevice, WMPDeviceStatus NewStatus);
    void DeviceSyncStateChange(IWMPSyncDevice pDevice, WMPSyncState NewState);
    void DeviceSyncError(IWMPSyncDevice pDevice, IDispatch pMedia);
    void CreatePartnershipComplete(IWMPSyncDevice pDevice, HRESULT hrResult);
}

@GUID("1F504270-A66B-4223-8E96-26A06C63D69F")
interface IWMPEvents3 : IWMPEvents2
{
    void CdromRipStateChange(IWMPCdromRip pCdromRip, WMPRipState wmprs);
    void CdromRipMediaError(IWMPCdromRip pCdromRip, IDispatch pMedia);
    void CdromBurnStateChange(IWMPCdromBurn pCdromBurn, WMPBurnState wmpbs);
    void CdromBurnMediaError(IWMPCdromBurn pCdromBurn, IDispatch pMedia);
    void CdromBurnError(IWMPCdromBurn pCdromBurn, HRESULT hrError);
    void LibraryConnect(IWMPLibrary pLibrary);
    void LibraryDisconnect(IWMPLibrary pLibrary);
    void FolderScanStateChange(WMPFolderScanState wmpfss);
    void StringCollectionChange(IDispatch pdispStringCollection, WMPStringCollectionChangeEventType change, 
                                int lCollectionIndex);
    void MediaCollectionMediaAdded(IDispatch pdispMedia);
    void MediaCollectionMediaRemoved(IDispatch pdispMedia);
}

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

@GUID("6D6CF803-1EC0-4C8D-B3CA-F18E27282074")
interface IWMPVideoRenderConfig : IUnknown
{
    HRESULT put_presenterActivate(IMFActivate pActivate);
}

@GUID("E79C6349-5997-4CE4-917C-22A3391EC564")
interface IWMPAudioRenderConfig : IUnknown
{
    HRESULT get_audioOutputDevice(BSTR* pbstrOutputDevice);
    HRESULT put_audioOutputDevice(BSTR bstrOutputDevice);
}

@GUID("959506C1-0314-4EC5-9E61-8528DB5E5478")
interface IWMPRenderConfig : IUnknown
{
    HRESULT put_inProcOnly(BOOL fInProc);
    HRESULT get_inProcOnly(int* pfInProc);
}

@GUID("AFB6B76B-1E20-4198-83B3-191DB6E0B149")
interface IWMPServices : IUnknown
{
    HRESULT GetStreamTime(long* prt);
    HRESULT GetStreamState(WMPServices_StreamState* pState);
}

@GUID("68E27045-05BD-40B2-9720-23088C78E390")
interface IWMPMediaPluginRegistrar : IUnknown
{
    HRESULT WMPRegisterPlayerPlugin(const(wchar)* pwszFriendlyName, const(wchar)* pwszDescription, 
                                    const(wchar)* pwszUninstallString, uint dwPriority, GUID guidPluginType, 
                                    GUID clsid, uint cMediaTypes, void* pMediaTypes);
    HRESULT WMPUnRegisterPlayerPlugin(GUID guidPluginType, GUID clsid);
}

@GUID("F1392A70-024C-42BB-A998-73DFDFE7D5A7")
interface IWMPPlugin : IUnknown
{
    HRESULT Init(size_t dwPlaybackContext);
    HRESULT Shutdown();
    HRESULT GetID(GUID* pGUID);
    HRESULT GetCaps(uint* pdwFlags);
    HRESULT AdviseWMPServices(IWMPServices pWMPServices);
    HRESULT UnAdviseWMPServices();
}

@GUID("5FCA444C-7AD1-479D-A4EF-40566A5309D6")
interface IWMPPluginEnable : IUnknown
{
    HRESULT SetEnable(BOOL fEnable);
    HRESULT GetEnable(int* pfEnable);
}

@GUID("BFB377E5-C594-4369-A970-DE896D5ECE74")
interface IWMPGraphCreation : IUnknown
{
    HRESULT GraphCreationPreRender(IUnknown pFilterGraph, IUnknown pReserved);
    HRESULT GraphCreationPostRender(IUnknown pFilterGraph);
    HRESULT GetGraphCreationFlags(uint* pdwFlags);
}

@GUID("D683162F-57D4-4108-8373-4A9676D1C2E9")
interface IWMPConvert : IUnknown
{
    HRESULT ConvertFile(BSTR bstrInputFile, BSTR bstrDestinationFolder, BSTR* pbstrOutputFile);
    HRESULT GetErrorURL(BSTR* pbstrURL);
}

@GUID("B64CBAC3-401C-4327-A3E8-B9FEB3A8C25C")
interface IWMPTranscodePolicy : IUnknown
{
    HRESULT allowTranscode(short* pvbAllow);
}

@GUID("CFCCFA72-C343-48C3-A2DE-B7A4402E39F2")
interface IWMPUserEventSink : IUnknown
{
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

@GUID("D3984C13-C3CB-48E2-8BE5-5168340B4F35")
interface IWMPEffects : IUnknown
{
    HRESULT Render(TimedLevel* pLevels, HDC hdc, RECT* prc);
    HRESULT MediaInfo(int lChannelCount, int lSampleRate, BSTR bstrTitle);
    HRESULT GetCapabilities(uint* pdwCapabilities);
    HRESULT GetTitle(BSTR* bstrTitle);
    HRESULT GetPresetTitle(int nPreset, BSTR* bstrPresetTitle);
    HRESULT GetPresetCount(int* pnPresetCount);
    HRESULT SetCurrentPreset(int nPreset);
    HRESULT GetCurrentPreset(int* pnPreset);
    HRESULT DisplayPropertyPage(HWND hwndOwner);
    HRESULT GoFullscreen(BOOL fFullScreen);
    HRESULT RenderFullScreen(TimedLevel* pLevels);
}

@GUID("695386EC-AA3C-4618-A5E1-DD9A8B987632")
interface IWMPEffects2 : IWMPEffects
{
    HRESULT SetCore(IWMPCore pPlayer);
    HRESULT Create(HWND hwndParent);
    HRESULT Destroy();
    HRESULT NotifyNewMedia(IWMPMedia pMedia);
    HRESULT OnWindowMessage(uint msg, WPARAM WParam, LPARAM LParam, LRESULT* plResultParam);
    HRESULT RenderWindowed(TimedLevel* pData, BOOL fRequiredRender);
}

@GUID("4C5E8F9F-AD3E-4BF9-9753-FCD30D6D38DD")
interface IWMPPluginUI : IUnknown
{
    HRESULT SetCore(IWMPCore pCore);
    HRESULT Create(HWND hwndParent, HWND* phwndWindow);
    HRESULT Destroy();
    HRESULT DisplayPropertyPage(HWND hwndParent);
    HRESULT GetProperty(const(wchar)* pwszName, VARIANT* pvarProperty);
    HRESULT SetProperty(const(wchar)* pwszName, const(VARIANT)* pvarProperty);
    HRESULT TranslateAcceleratorA(MSG* lpmsg);
}

@GUID("AD7F4D9C-1A9F-4ED2-9815-ECC0B58CB616")
interface IWMPContentContainer : IUnknown
{
    HRESULT GetID(uint* pContentID);
    HRESULT GetPrice(BSTR* pbstrPrice);
    HRESULT GetType(BSTR* pbstrType);
    HRESULT GetContentCount(uint* pcContent);
    HRESULT GetContentPrice(uint idxContent, BSTR* pbstrPrice);
    HRESULT GetContentID(uint idxContent, uint* pContentID);
}

@GUID("A9937F78-0802-4AF8-8B8D-E3F045BC8AB5")
interface IWMPContentContainerList : IUnknown
{
    HRESULT GetTransactionType(WMPTransactionType* pwmptt);
    HRESULT GetContainerCount(uint* pcContainer);
    HRESULT GetContainer(uint idxContainer, IWMPContentContainer* ppContent);
}

@GUID("9E8F7DA2-0695-403C-B697-DA10FAFAA676")
interface IWMPContentPartnerCallback : IUnknown
{
    HRESULT Notify(WMPCallbackNotification type, VARIANT* pContext);
    HRESULT BuyComplete(HRESULT hrResult, uint dwBuyCookie);
    HRESULT DownloadTrack(uint cookie, BSTR bstrTrackURL, uint dwServiceTrackID, BSTR bstrDownloadParams, 
                          HRESULT hrDownload);
    HRESULT GetCatalogVersion(uint* pdwVersion, uint* pdwSchemaVersion, uint* plcid);
    HRESULT UpdateDeviceComplete(BSTR bstrDeviceName);
    HRESULT ChangeView(BSTR bstrType, BSTR bstrID, BSTR bstrFilter);
    HRESULT AddListContents(uint dwListCookie, uint cItems, char* prgItems);
    HRESULT ListContentsComplete(uint dwListCookie, HRESULT hrSuccess);
    HRESULT SendMessageComplete(BSTR bstrMsg, BSTR bstrParam, BSTR bstrResult);
    HRESULT GetContentIDsInLibrary(uint* pcContentIDs, char* pprgIDs);
    HRESULT RefreshLicenseComplete(uint dwCookie, uint contentID, HRESULT hrRefresh);
    HRESULT ShowPopup(int lIndex, BSTR bstrParameters);
    HRESULT VerifyPermissionComplete(BSTR bstrPermission, VARIANT* pContext, HRESULT hrPermission);
}

@GUID("55455073-41B5-4E75-87B8-F13BDB291D08")
interface IWMPContentPartner : IUnknown
{
    HRESULT SetCallback(IWMPContentPartnerCallback pCallback);
    HRESULT Notify(WMPPartnerNotification type, VARIANT* pContext);
    HRESULT GetItemInfo(BSTR bstrInfoName, VARIANT* pContext, VARIANT* pData);
    HRESULT GetContentPartnerInfo(BSTR bstrInfoName, VARIANT* pData);
    HRESULT GetCommands(BSTR location, VARIANT* pLocationContext, BSTR itemLocation, uint cItemIDs, 
                        char* prgItemIDs, uint* pcItemIDs, char* pprgItems);
    HRESULT InvokeCommand(uint dwCommandID, BSTR location, VARIANT* pLocationContext, BSTR itemLocation, 
                          uint cItemIDs, char* rgItemIDs);
    HRESULT CanBuySilent(IWMPContentContainerList pInfo, BSTR* pbstrTotalPrice, short* pSilentOK);
    HRESULT Buy(IWMPContentContainerList pInfo, uint cookie);
    HRESULT GetStreamingURL(WMPStreamingType st, VARIANT* pStreamContext, BSTR* pbstrURL);
    HRESULT Download(IWMPContentContainerList pInfo, uint cookie);
    HRESULT DownloadTrackComplete(HRESULT hrResult, uint contentID, BSTR downloadTrackParam);
    HRESULT RefreshLicense(uint dwCookie, short fLocal, BSTR bstrURL, WMPStreamingType type, uint contentID, 
                           BSTR bstrRefreshReason, VARIANT* pReasonContext);
    HRESULT GetCatalogURL(uint dwCatalogVersion, uint dwCatalogSchemaVersion, uint catalogLCID, 
                          uint* pdwNewCatalogVersion, BSTR* pbstrCatalogURL, VARIANT* pExpirationDate);
    HRESULT GetTemplate(WMPTaskType task, BSTR location, VARIANT* pContext, BSTR clickLocation, 
                        VARIANT* pClickContext, BSTR bstrFilter, BSTR bstrViewParams, BSTR* pbstrTemplateURL, 
                        WMPTemplateSize* pTemplateSize);
    HRESULT UpdateDevice(BSTR bstrDeviceName);
    HRESULT GetListContents(BSTR location, VARIANT* pContext, BSTR bstrListType, BSTR bstrParams, 
                            uint dwListCookie);
    HRESULT Login(BLOB userInfo, BLOB pwdInfo, short fUsedCachedCreds, short fOkToCache);
    HRESULT Authenticate(BLOB userInfo, BLOB pwdInfo);
    HRESULT Logout();
    HRESULT SendMessageA(BSTR bstrMsg, BSTR bstrParam);
    HRESULT StationEvent(BSTR bstrStationEventType, uint StationId, uint PlaylistIndex, uint TrackID, 
                         BSTR TrackData, uint dwSecondsPlayed);
    HRESULT CompareContainerListPrices(IWMPContentContainerList pListBase, IWMPContentContainerList pListCompare, 
                                       int* pResult);
    HRESULT VerifyPermission(BSTR bstrPermission, VARIANT* pContext);
}

@GUID("376055F8-2A59-4A73-9501-DCA5273A7A10")
interface IWMPSubscriptionService : IUnknown
{
    HRESULT allowPlay(HWND hwnd, IWMPMedia pMedia, int* pfAllowPlay);
    HRESULT allowCDBurn(HWND hwnd, IWMPPlaylist pPlaylist, int* pfAllowBurn);
    HRESULT allowPDATransfer(HWND hwnd, IWMPPlaylist pPlaylist, int* pfAllowTransfer);
    HRESULT startBackgroundProcessing(HWND hwnd);
}

@GUID("DD01D127-2DC2-4C3A-876E-63312079F9B0")
interface IWMPSubscriptionServiceCallback : IUnknown
{
    HRESULT onComplete(HRESULT hrResult);
}

@GUID("A94C120E-D600-4EC6-B05E-EC9D56D84DE0")
interface IWMPSubscriptionService2 : IWMPSubscriptionService
{
    HRESULT stopBackgroundProcessing();
    HRESULT serviceEvent(WMPSubscriptionServiceEvent event);
    HRESULT deviceAvailable(BSTR bstrDeviceName, IWMPSubscriptionServiceCallback pCB);
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
