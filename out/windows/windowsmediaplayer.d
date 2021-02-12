module windows.windowsmediaplayer;

public import system;
public import windows.automation;
public import windows.com;
public import windows.displaydevices;
public import windows.gdi;
public import windows.mediafoundation;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.winsock;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

const GUID CLSID_WindowsMediaPlayer = {0x6BF52A52, 0x394A, 0x11D3, [0xB1, 0x53, 0x00, 0xC0, 0x4F, 0x79, 0xFA, 0xA6]};
@GUID(0x6BF52A52, 0x394A, 0x11D3, [0xB1, 0x53, 0x00, 0xC0, 0x4F, 0x79, 0xFA, 0xA6]);
struct WindowsMediaPlayer;

enum WMPOpenState
{
    wmposUndefined = 0,
    wmposPlaylistChanging = 1,
    wmposPlaylistLocating = 2,
    wmposPlaylistConnecting = 3,
    wmposPlaylistLoading = 4,
    wmposPlaylistOpening = 5,
    wmposPlaylistOpenNoMedia = 6,
    wmposPlaylistChanged = 7,
    wmposMediaChanging = 8,
    wmposMediaLocating = 9,
    wmposMediaConnecting = 10,
    wmposMediaLoading = 11,
    wmposMediaOpening = 12,
    wmposMediaOpen = 13,
    wmposBeginCodecAcquisition = 14,
    wmposEndCodecAcquisition = 15,
    wmposBeginLicenseAcquisition = 16,
    wmposEndLicenseAcquisition = 17,
    wmposBeginIndividualization = 18,
    wmposEndIndividualization = 19,
    wmposMediaWaiting = 20,
    wmposOpeningUnknownURL = 21,
}

enum WMPPlayState
{
    wmppsUndefined = 0,
    wmppsStopped = 1,
    wmppsPaused = 2,
    wmppsPlaying = 3,
    wmppsScanForward = 4,
    wmppsScanReverse = 5,
    wmppsBuffering = 6,
    wmppsWaiting = 7,
    wmppsMediaEnded = 8,
    wmppsTransitioning = 9,
    wmppsReady = 10,
    wmppsReconnecting = 11,
    wmppsLast = 12,
}

enum WMPPlaylistChangeEventType
{
    wmplcUnknown = 0,
    wmplcClear = 1,
    wmplcInfoChange = 2,
    wmplcMove = 3,
    wmplcDelete = 4,
    wmplcInsert = 5,
    wmplcAppend = 6,
    wmplcPrivate = 7,
    wmplcNameChange = 8,
    wmplcMorph = 9,
    wmplcSort = 10,
    wmplcLast = 11,
}

const GUID IID_IWMPErrorItem = {0x3614C646, 0x3B3B, 0x4DE7, [0xA8, 0x1E, 0x93, 0x0E, 0x3F, 0x21, 0x27, 0xB3]};
@GUID(0x3614C646, 0x3B3B, 0x4DE7, [0xA8, 0x1E, 0x93, 0x0E, 0x3F, 0x21, 0x27, 0xB3]);
interface IWMPErrorItem : IDispatch
{
    HRESULT get_errorCode(int* phr);
    HRESULT get_errorDescription(BSTR* pbstrDescription);
    HRESULT get_errorContext(VARIANT* pvarContext);
    HRESULT get_remedy(int* plRemedy);
    HRESULT get_customUrl(BSTR* pbstrCustomUrl);
}

const GUID IID_IWMPError = {0xA12DCF7D, 0x14AB, 0x4C1B, [0xA8, 0xCD, 0x63, 0x90, 0x9F, 0x06, 0x02, 0x5B]};
@GUID(0xA12DCF7D, 0x14AB, 0x4C1B, [0xA8, 0xCD, 0x63, 0x90, 0x9F, 0x06, 0x02, 0x5B]);
interface IWMPError : IDispatch
{
    HRESULT clearErrorQueue();
    HRESULT get_errorCount(int* plNumErrors);
    HRESULT get_item(int dwIndex, IWMPErrorItem* ppErrorItem);
    HRESULT webHelp();
}

const GUID IID_IWMPMedia = {0x94D55E95, 0x3FAC, 0x11D3, [0xB1, 0x55, 0x00, 0xC0, 0x4F, 0x79, 0xFA, 0xA6]};
@GUID(0x94D55E95, 0x3FAC, 0x11D3, [0xB1, 0x55, 0x00, 0xC0, 0x4F, 0x79, 0xFA, 0xA6]);
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

const GUID IID_IWMPControls = {0x74C09E02, 0xF828, 0x11D2, [0xA7, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x6E]};
@GUID(0x74C09E02, 0xF828, 0x11D2, [0xA7, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0xF3, 0x6E]);
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

const GUID IID_IWMPSettings = {0x9104D1AB, 0x80C9, 0x4FED, [0xAB, 0xF0, 0x2E, 0x64, 0x17, 0xA6, 0xDF, 0x14]};
@GUID(0x9104D1AB, 0x80C9, 0x4FED, [0xAB, 0xF0, 0x2E, 0x64, 0x17, 0xA6, 0xDF, 0x14]);
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

const GUID IID_IWMPClosedCaption = {0x4F2DF574, 0xC588, 0x11D3, [0x9E, 0xD0, 0x00, 0xC0, 0x4F, 0xB6, 0xE9, 0x37]};
@GUID(0x4F2DF574, 0xC588, 0x11D3, [0x9E, 0xD0, 0x00, 0xC0, 0x4F, 0xB6, 0xE9, 0x37]);
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

const GUID IID_IWMPPlaylist = {0xD5F0F4F1, 0x130C, 0x11D3, [0xB1, 0x4E, 0x00, 0xC0, 0x4F, 0x79, 0xFA, 0xA6]};
@GUID(0xD5F0F4F1, 0x130C, 0x11D3, [0xB1, 0x4E, 0x00, 0xC0, 0x4F, 0x79, 0xFA, 0xA6]);
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

const GUID IID_IWMPCdrom = {0xCFAB6E98, 0x8730, 0x11D3, [0xB3, 0x88, 0x00, 0xC0, 0x4F, 0x68, 0x57, 0x4B]};
@GUID(0xCFAB6E98, 0x8730, 0x11D3, [0xB3, 0x88, 0x00, 0xC0, 0x4F, 0x68, 0x57, 0x4B]);
interface IWMPCdrom : IDispatch
{
    HRESULT get_driveSpecifier(BSTR* pbstrDrive);
    HRESULT get_playlist(IWMPPlaylist* ppPlaylist);
    HRESULT eject();
}

const GUID IID_IWMPCdromCollection = {0xEE4C8FE2, 0x34B2, 0x11D3, [0xA3, 0xBF, 0x00, 0x60, 0x97, 0xC9, 0xB3, 0x44]};
@GUID(0xEE4C8FE2, 0x34B2, 0x11D3, [0xA3, 0xBF, 0x00, 0x60, 0x97, 0xC9, 0xB3, 0x44]);
interface IWMPCdromCollection : IDispatch
{
    HRESULT get_count(int* plCount);
    HRESULT item(int lIndex, IWMPCdrom* ppItem);
    HRESULT getByDriveSpecifier(BSTR bstrDriveSpecifier, IWMPCdrom* ppCdrom);
}

const GUID IID_IWMPStringCollection = {0x4A976298, 0x8C0D, 0x11D3, [0xB3, 0x89, 0x00, 0xC0, 0x4F, 0x68, 0x57, 0x4B]};
@GUID(0x4A976298, 0x8C0D, 0x11D3, [0xB3, 0x89, 0x00, 0xC0, 0x4F, 0x68, 0x57, 0x4B]);
interface IWMPStringCollection : IDispatch
{
    HRESULT get_count(int* plCount);
    HRESULT item(int lIndex, BSTR* pbstrString);
}

const GUID IID_IWMPMediaCollection = {0x8363BC22, 0xB4B4, 0x4B19, [0x98, 0x9D, 0x1C, 0xD7, 0x65, 0x74, 0x9D, 0xD1]};
@GUID(0x8363BC22, 0xB4B4, 0x4B19, [0x98, 0x9D, 0x1C, 0xD7, 0x65, 0x74, 0x9D, 0xD1]);
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
    HRESULT getAttributeStringCollection(BSTR bstrAttribute, BSTR bstrMediaType, IWMPStringCollection* ppStringCollection);
    HRESULT getMediaAtom(BSTR bstrItemName, int* plAtom);
    HRESULT setDeleted(IWMPMedia pItem, short varfIsDeleted);
    HRESULT isDeleted(IWMPMedia pItem, short* pvarfIsDeleted);
}

const GUID IID_IWMPPlaylistArray = {0x679409C0, 0x99F7, 0x11D3, [0x9F, 0xB7, 0x00, 0x10, 0x5A, 0xA6, 0x20, 0xBB]};
@GUID(0x679409C0, 0x99F7, 0x11D3, [0x9F, 0xB7, 0x00, 0x10, 0x5A, 0xA6, 0x20, 0xBB]);
interface IWMPPlaylistArray : IDispatch
{
    HRESULT get_count(int* plCount);
    HRESULT item(int lIndex, IWMPPlaylist* ppItem);
}

const GUID IID_IWMPPlaylistCollection = {0x10A13217, 0x23A7, 0x439B, [0xB1, 0xC0, 0xD8, 0x47, 0xC7, 0x9B, 0x77, 0x74]};
@GUID(0x10A13217, 0x23A7, 0x439B, [0xB1, 0xC0, 0xD8, 0x47, 0xC7, 0x9B, 0x77, 0x74]);
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

const GUID IID_IWMPNetwork = {0xEC21B779, 0xEDEF, 0x462D, [0xBB, 0xA4, 0xAD, 0x9D, 0xDE, 0x2B, 0x29, 0xA7]};
@GUID(0xEC21B779, 0xEDEF, 0x462D, [0xBB, 0xA4, 0xAD, 0x9D, 0xDE, 0x2B, 0x29, 0xA7]);
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

const GUID IID_IWMPCore = {0xD84CCA99, 0xCCE2, 0x11D2, [0x9E, 0xCC, 0x00, 0x00, 0xF8, 0x08, 0x59, 0x81]};
@GUID(0xD84CCA99, 0xCCE2, 0x11D2, [0x9E, 0xCC, 0x00, 0x00, 0xF8, 0x08, 0x59, 0x81]);
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

const GUID IID_IWMPPlayer = {0x6BF52A4F, 0x394A, 0x11D3, [0xB1, 0x53, 0x00, 0xC0, 0x4F, 0x79, 0xFA, 0xA6]};
@GUID(0x6BF52A4F, 0x394A, 0x11D3, [0xB1, 0x53, 0x00, 0xC0, 0x4F, 0x79, 0xFA, 0xA6]);
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

const GUID IID_IWMPPlayer2 = {0x0E6B01D1, 0xD407, 0x4C85, [0xBF, 0x5F, 0x1C, 0x01, 0xF6, 0x15, 0x02, 0x80]};
@GUID(0x0E6B01D1, 0xD407, 0x4C85, [0xBF, 0x5F, 0x1C, 0x01, 0xF6, 0x15, 0x02, 0x80]);
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

const GUID IID_IWMPMedia2 = {0xAB7C88BB, 0x143E, 0x4EA4, [0xAC, 0xC3, 0xE4, 0x35, 0x0B, 0x21, 0x06, 0xC3]};
@GUID(0xAB7C88BB, 0x143E, 0x4EA4, [0xAC, 0xC3, 0xE4, 0x35, 0x0B, 0x21, 0x06, 0xC3]);
interface IWMPMedia2 : IWMPMedia
{
    HRESULT get_error(IWMPErrorItem* ppIWMPErrorItem);
}

const GUID IID_IWMPControls2 = {0x6F030D25, 0x0890, 0x480F, [0x97, 0x75, 0x1F, 0x7E, 0x40, 0xAB, 0x5B, 0x8E]};
@GUID(0x6F030D25, 0x0890, 0x480F, [0x97, 0x75, 0x1F, 0x7E, 0x40, 0xAB, 0x5B, 0x8E]);
interface IWMPControls2 : IWMPControls
{
    HRESULT step(int lStep);
}

const GUID IID_IWMPDVD = {0x8DA61686, 0x4668, 0x4A5C, [0xAE, 0x5D, 0x80, 0x31, 0x93, 0x29, 0x3D, 0xBE]};
@GUID(0x8DA61686, 0x4668, 0x4A5C, [0xAE, 0x5D, 0x80, 0x31, 0x93, 0x29, 0x3D, 0xBE]);
interface IWMPDVD : IDispatch
{
    HRESULT get_isAvailable(BSTR bstrItem, short* pIsAvailable);
    HRESULT get_domain(BSTR* strDomain);
    HRESULT topMenu();
    HRESULT titleMenu();
    HRESULT back();
    HRESULT resume();
}

const GUID IID_IWMPCore2 = {0xBC17E5B7, 0x7561, 0x4C18, [0xBB, 0x90, 0x17, 0xD4, 0x85, 0x77, 0x56, 0x59]};
@GUID(0xBC17E5B7, 0x7561, 0x4C18, [0xBB, 0x90, 0x17, 0xD4, 0x85, 0x77, 0x56, 0x59]);
interface IWMPCore2 : IWMPCore
{
    HRESULT get_dvd(IWMPDVD* ppDVD);
}

const GUID IID_IWMPPlayer3 = {0x54062B68, 0x052A, 0x4C25, [0xA3, 0x9F, 0x8B, 0x63, 0x34, 0x65, 0x11, 0xD4]};
@GUID(0x54062B68, 0x052A, 0x4C25, [0xA3, 0x9F, 0x8B, 0x63, 0x34, 0x65, 0x11, 0xD4]);
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

const GUID IID_IWMPErrorItem2 = {0xF75CCEC0, 0xC67C, 0x475C, [0x93, 0x1E, 0x87, 0x19, 0x87, 0x0B, 0xEE, 0x7D]};
@GUID(0xF75CCEC0, 0xC67C, 0x475C, [0x93, 0x1E, 0x87, 0x19, 0x87, 0x0B, 0xEE, 0x7D]);
interface IWMPErrorItem2 : IWMPErrorItem
{
    HRESULT get_condition(int* plCondition);
}

const GUID IID_IWMPRemoteMediaServices = {0xCBB92747, 0x741F, 0x44FE, [0xAB, 0x5B, 0xF1, 0xA4, 0x8F, 0x3B, 0x2A, 0x59]};
@GUID(0xCBB92747, 0x741F, 0x44FE, [0xAB, 0x5B, 0xF1, 0xA4, 0x8F, 0x3B, 0x2A, 0x59]);
interface IWMPRemoteMediaServices : IUnknown
{
    HRESULT GetServiceType(BSTR* pbstrType);
    HRESULT GetApplicationName(BSTR* pbstrName);
    HRESULT GetScriptableObject(BSTR* pbstrName, IDispatch* ppDispatch);
    HRESULT GetCustomUIMode(BSTR* pbstrFile);
}

const GUID IID_IWMPSkinManager = {0x076F2FA6, 0xED30, 0x448B, [0x8C, 0xC5, 0x3F, 0x3E, 0xF3, 0x52, 0x9C, 0x7A]};
@GUID(0x076F2FA6, 0xED30, 0x448B, [0x8C, 0xC5, 0x3F, 0x3E, 0xF3, 0x52, 0x9C, 0x7A]);
interface IWMPSkinManager : IUnknown
{
    HRESULT SetVisualStyle(BSTR bstrPath);
}

const GUID IID_IWMPMetadataPicture = {0x5C29BBE0, 0xF87D, 0x4C45, [0xAA, 0x28, 0xA7, 0x0F, 0x02, 0x30, 0xFF, 0xA9]};
@GUID(0x5C29BBE0, 0xF87D, 0x4C45, [0xAA, 0x28, 0xA7, 0x0F, 0x02, 0x30, 0xFF, 0xA9]);
interface IWMPMetadataPicture : IDispatch
{
    HRESULT get_mimeType(BSTR* pbstrMimeType);
    HRESULT get_pictureType(BSTR* pbstrPictureType);
    HRESULT get_description(BSTR* pbstrDescription);
    HRESULT get_URL(BSTR* pbstrURL);
}

const GUID IID_IWMPMetadataText = {0x769A72DB, 0x13D2, 0x45E2, [0x9C, 0x48, 0x53, 0xCA, 0x9D, 0x5B, 0x74, 0x50]};
@GUID(0x769A72DB, 0x13D2, 0x45E2, [0x9C, 0x48, 0x53, 0xCA, 0x9D, 0x5B, 0x74, 0x50]);
interface IWMPMetadataText : IDispatch
{
    HRESULT get_description(BSTR* pbstrDescription);
    HRESULT get_text(BSTR* pbstrText);
}

const GUID IID_IWMPMedia3 = {0xF118EFC7, 0xF03A, 0x4FB4, [0x99, 0xC9, 0x1C, 0x02, 0xA5, 0xC1, 0x06, 0x5B]};
@GUID(0xF118EFC7, 0xF03A, 0x4FB4, [0x99, 0xC9, 0x1C, 0x02, 0xA5, 0xC1, 0x06, 0x5B]);
interface IWMPMedia3 : IWMPMedia2
{
    HRESULT getAttributeCountByType(BSTR bstrType, BSTR bstrLanguage, int* plCount);
    HRESULT getItemInfoByType(BSTR bstrType, BSTR bstrLanguage, int lIndex, VARIANT* pvarValue);
}

const GUID IID_IWMPSettings2 = {0xFDA937A4, 0xEECE, 0x4DA5, [0xA0, 0xB6, 0x39, 0xBF, 0x89, 0xAD, 0xE2, 0xC2]};
@GUID(0xFDA937A4, 0xEECE, 0x4DA5, [0xA0, 0xB6, 0x39, 0xBF, 0x89, 0xAD, 0xE2, 0xC2]);
interface IWMPSettings2 : IWMPSettings
{
    HRESULT get_defaultAudioLanguage(int* plLangID);
    HRESULT get_mediaAccessRights(BSTR* pbstrRights);
    HRESULT requestMediaAccessRights(BSTR bstrDesiredAccess, short* pvbAccepted);
}

const GUID IID_IWMPControls3 = {0xA1D1110E, 0xD545, 0x476A, [0x9A, 0x78, 0xAC, 0x3E, 0x4C, 0xB1, 0xE6, 0xBD]};
@GUID(0xA1D1110E, 0xD545, 0x476A, [0x9A, 0x78, 0xAC, 0x3E, 0x4C, 0xB1, 0xE6, 0xBD]);
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

const GUID IID_IWMPClosedCaption2 = {0x350BA78B, 0x6BC8, 0x4113, [0xA5, 0xF5, 0x31, 0x20, 0x56, 0x93, 0x4E, 0xB6]};
@GUID(0x350BA78B, 0x6BC8, 0x4113, [0xA5, 0xF5, 0x31, 0x20, 0x56, 0x93, 0x4E, 0xB6]);
interface IWMPClosedCaption2 : IWMPClosedCaption
{
    HRESULT get_SAMILangCount(int* plCount);
    HRESULT getSAMILangName(int nIndex, BSTR* pbstrName);
    HRESULT getSAMILangID(int nIndex, int* plLangID);
    HRESULT get_SAMIStyleCount(int* plCount);
    HRESULT getSAMIStyleName(int nIndex, BSTR* pbstrName);
}

const GUID IID_IWMPPlayerApplication = {0x40897764, 0xCEAB, 0x47BE, [0xAD, 0x4A, 0x8E, 0x28, 0x53, 0x7F, 0x9B, 0xBF]};
@GUID(0x40897764, 0xCEAB, 0x47BE, [0xAD, 0x4A, 0x8E, 0x28, 0x53, 0x7F, 0x9B, 0xBF]);
interface IWMPPlayerApplication : IDispatch
{
    HRESULT switchToPlayerApplication();
    HRESULT switchToControl();
    HRESULT get_playerDocked(short* pbPlayerDocked);
    HRESULT get_hasDisplay(short* pbHasDisplay);
}

const GUID IID_IWMPCore3 = {0x7587C667, 0x628F, 0x499F, [0x88, 0xE7, 0x6A, 0x6F, 0x4E, 0x88, 0x84, 0x64]};
@GUID(0x7587C667, 0x628F, 0x499F, [0x88, 0xE7, 0x6A, 0x6F, 0x4E, 0x88, 0x84, 0x64]);
interface IWMPCore3 : IWMPCore2
{
    HRESULT newPlaylist(BSTR bstrName, BSTR bstrURL, IWMPPlaylist* ppPlaylist);
    HRESULT newMedia(BSTR bstrURL, IWMPMedia* ppMedia);
}

const GUID IID_IWMPPlayer4 = {0x6C497D62, 0x8919, 0x413C, [0x82, 0xDB, 0xE9, 0x35, 0xFB, 0x3E, 0xC5, 0x84]};
@GUID(0x6C497D62, 0x8919, 0x413C, [0x82, 0xDB, 0xE9, 0x35, 0xFB, 0x3E, 0xC5, 0x84]);
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

const GUID IID_IWMPPlayerServices = {0x1D01FBDB, 0xADE2, 0x4C8D, [0x98, 0x42, 0xC1, 0x90, 0xB9, 0x5C, 0x33, 0x06]};
@GUID(0x1D01FBDB, 0xADE2, 0x4C8D, [0x98, 0x42, 0xC1, 0x90, 0xB9, 0x5C, 0x33, 0x06]);
interface IWMPPlayerServices : IUnknown
{
    HRESULT activateUIPlugin(BSTR bstrPlugin);
    HRESULT setTaskPane(BSTR bstrTaskPane);
    HRESULT setTaskPaneURL(BSTR bstrTaskPane, BSTR bstrURL, BSTR bstrFriendlyName);
}

enum WMPSyncState
{
    wmpssUnknown = 0,
    wmpssSynchronizing = 1,
    wmpssStopped = 2,
    wmpssEstimating = 3,
    wmpssLast = 4,
}

enum WMPDeviceStatus
{
    wmpdsUnknown = 0,
    wmpdsPartnershipExists = 1,
    wmpdsPartnershipDeclined = 2,
    wmpdsPartnershipAnother = 3,
    wmpdsManualDevice = 4,
    wmpdsNewDevice = 5,
    wmpdsLast = 6,
}

const GUID IID_IWMPSyncDevice = {0x82A2986C, 0x0293, 0x4FD0, [0xB2, 0x79, 0xB2, 0x1B, 0x86, 0xC0, 0x58, 0xBE]};
@GUID(0x82A2986C, 0x0293, 0x4FD0, [0xB2, 0x79, 0xB2, 0x1B, 0x86, 0xC0, 0x58, 0xBE]);
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

const GUID IID_IWMPSyncServices = {0x8B5050FF, 0xE0A4, 0x4808, [0xB3, 0xA8, 0x89, 0x3A, 0x9E, 0x1E, 0xD8, 0x94]};
@GUID(0x8B5050FF, 0xE0A4, 0x4808, [0xB3, 0xA8, 0x89, 0x3A, 0x9E, 0x1E, 0xD8, 0x94]);
interface IWMPSyncServices : IUnknown
{
    HRESULT get_deviceCount(int* plCount);
    HRESULT getDevice(int lIndex, IWMPSyncDevice* ppDevice);
}

const GUID IID_IWMPPlayerServices2 = {0x1BB1592F, 0xF040, 0x418A, [0x9F, 0x71, 0x17, 0xC7, 0x51, 0x2B, 0x4D, 0x70]};
@GUID(0x1BB1592F, 0xF040, 0x418A, [0x9F, 0x71, 0x17, 0xC7, 0x51, 0x2B, 0x4D, 0x70]);
interface IWMPPlayerServices2 : IWMPPlayerServices
{
    HRESULT setBackgroundProcessingPriority(BSTR bstrPriority);
}

enum WMPRipState
{
    wmprsUnknown = 0,
    wmprsRipping = 1,
    wmprsStopped = 2,
}

enum WMPBurnFormat
{
    wmpbfAudioCD = 0,
    wmpbfDataCD = 1,
}

enum WMPBurnState
{
    wmpbsUnknown = 0,
    wmpbsBusy = 1,
    wmpbsReady = 2,
    wmpbsWaitingForDisc = 3,
    wmpbsRefreshStatusPending = 4,
    wmpbsPreparingToBurn = 5,
    wmpbsBurning = 6,
    wmpbsStopped = 7,
    wmpbsErasing = 8,
    wmpbsDownloading = 9,
}

enum WMPStringCollectionChangeEventType
{
    wmpsccetUnknown = 0,
    wmpsccetInsert = 1,
    wmpsccetChange = 2,
    wmpsccetDelete = 3,
    wmpsccetClear = 4,
    wmpsccetBeginUpdates = 5,
    wmpsccetEndUpdates = 6,
}

const GUID IID_IWMPCdromRip = {0x56E2294F, 0x69ED, 0x4629, [0xA8, 0x69, 0xAE, 0xA7, 0x2C, 0x0D, 0xCC, 0x2C]};
@GUID(0x56E2294F, 0x69ED, 0x4629, [0xA8, 0x69, 0xAE, 0xA7, 0x2C, 0x0D, 0xCC, 0x2C]);
interface IWMPCdromRip : IUnknown
{
    HRESULT get_ripState(WMPRipState* pwmprs);
    HRESULT get_ripProgress(int* plProgress);
    HRESULT startRip();
    HRESULT stopRip();
}

const GUID IID_IWMPCdromBurn = {0xBD94DBEB, 0x417F, 0x4928, [0xAA, 0x06, 0x08, 0x7D, 0x56, 0xED, 0x9B, 0x59]};
@GUID(0xBD94DBEB, 0x417F, 0x4928, [0xAA, 0x06, 0x08, 0x7D, 0x56, 0xED, 0x9B, 0x59]);
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

const GUID IID_IWMPQuery = {0xA00918F3, 0xA6B0, 0x4BFB, [0x91, 0x89, 0xFD, 0x83, 0x4C, 0x7B, 0xC5, 0xA5]};
@GUID(0xA00918F3, 0xA6B0, 0x4BFB, [0x91, 0x89, 0xFD, 0x83, 0x4C, 0x7B, 0xC5, 0xA5]);
interface IWMPQuery : IDispatch
{
    HRESULT addCondition(BSTR bstrAttribute, BSTR bstrOperator, BSTR bstrValue);
    HRESULT beginNextGroup();
}

const GUID IID_IWMPMediaCollection2 = {0x8BA957F5, 0xFD8C, 0x4791, [0xB8, 0x2D, 0xF8, 0x40, 0x40, 0x1E, 0xE4, 0x74]};
@GUID(0x8BA957F5, 0xFD8C, 0x4791, [0xB8, 0x2D, 0xF8, 0x40, 0x40, 0x1E, 0xE4, 0x74]);
interface IWMPMediaCollection2 : IWMPMediaCollection
{
    HRESULT createQuery(IWMPQuery* ppQuery);
    HRESULT getPlaylistByQuery(IWMPQuery pQuery, BSTR bstrMediaType, BSTR bstrSortAttribute, short fSortAscending, IWMPPlaylist* ppPlaylist);
    HRESULT getStringCollectionByQuery(BSTR bstrAttribute, IWMPQuery pQuery, BSTR bstrMediaType, BSTR bstrSortAttribute, short fSortAscending, IWMPStringCollection* ppStringCollection);
    HRESULT getByAttributeAndMediaType(BSTR bstrAttribute, BSTR bstrValue, BSTR bstrMediaType, IWMPPlaylist* ppMediaItems);
}

const GUID IID_IWMPStringCollection2 = {0x46AD648D, 0x53F1, 0x4A74, [0x92, 0xE2, 0x2A, 0x1B, 0x68, 0xD6, 0x3F, 0xD4]};
@GUID(0x46AD648D, 0x53F1, 0x4A74, [0x92, 0xE2, 0x2A, 0x1B, 0x68, 0xD6, 0x3F, 0xD4]);
interface IWMPStringCollection2 : IWMPStringCollection
{
    HRESULT isIdentical(IWMPStringCollection2 pIWMPStringCollection2, short* pvbool);
    HRESULT getItemInfo(int lCollectionIndex, BSTR bstrItemName, BSTR* pbstrValue);
    HRESULT getAttributeCountByType(int lCollectionIndex, BSTR bstrType, BSTR bstrLanguage, int* plCount);
    HRESULT getItemInfoByType(int lCollectionIndex, BSTR bstrType, BSTR bstrLanguage, int lAttributeIndex, VARIANT* pvarValue);
}

enum WMPLibraryType
{
    wmpltUnknown = 0,
    wmpltAll = 1,
    wmpltLocal = 2,
    wmpltRemote = 3,
    wmpltDisc = 4,
    wmpltPortableDevice = 5,
}

const GUID IID_IWMPLibrary = {0x3DF47861, 0x7DF1, 0x4C1F, [0xA8, 0x1B, 0x4C, 0x26, 0xF0, 0xF7, 0xA7, 0xC6]};
@GUID(0x3DF47861, 0x7DF1, 0x4C1F, [0xA8, 0x1B, 0x4C, 0x26, 0xF0, 0xF7, 0xA7, 0xC6]);
interface IWMPLibrary : IUnknown
{
    HRESULT get_name(BSTR* pbstrName);
    HRESULT get_type(WMPLibraryType* pwmplt);
    HRESULT get_mediaCollection(IWMPMediaCollection* ppIWMPMediaCollection);
    HRESULT isIdentical(IWMPLibrary pIWMPLibrary, short* pvbool);
}

const GUID IID_IWMPLibraryServices = {0x39C2F8D5, 0x1CF2, 0x4D5E, [0xAE, 0x09, 0xD7, 0x34, 0x92, 0xCF, 0x9E, 0xAA]};
@GUID(0x39C2F8D5, 0x1CF2, 0x4D5E, [0xAE, 0x09, 0xD7, 0x34, 0x92, 0xCF, 0x9E, 0xAA]);
interface IWMPLibraryServices : IUnknown
{
    HRESULT getCountByType(WMPLibraryType wmplt, int* plCount);
    HRESULT getLibraryByType(WMPLibraryType wmplt, int lIndex, IWMPLibrary* ppIWMPLibrary);
}

const GUID IID_IWMPLibrarySharingServices = {0x82CBA86B, 0x9F04, 0x474B, [0xA3, 0x65, 0xD6, 0xDD, 0x14, 0x66, 0xE5, 0x41]};
@GUID(0x82CBA86B, 0x9F04, 0x474B, [0xA3, 0x65, 0xD6, 0xDD, 0x14, 0x66, 0xE5, 0x41]);
interface IWMPLibrarySharingServices : IUnknown
{
    HRESULT isLibraryShared(short* pvbShared);
    HRESULT isLibrarySharingEnabled(short* pvbEnabled);
    HRESULT showLibrarySharing();
}

enum WMPFolderScanState
{
    wmpfssUnknown = 0,
    wmpfssScanning = 1,
    wmpfssUpdating = 2,
    wmpfssStopped = 3,
}

const GUID IID_IWMPFolderMonitorServices = {0x788C8743, 0xE57F, 0x439D, [0xA4, 0x68, 0x5B, 0xC7, 0x7F, 0x2E, 0x59, 0xC6]};
@GUID(0x788C8743, 0xE57F, 0x439D, [0xA4, 0x68, 0x5B, 0xC7, 0x7F, 0x2E, 0x59, 0xC6]);
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

const GUID IID_IWMPSyncDevice2 = {0x88AFB4B2, 0x140A, 0x44D2, [0x91, 0xE6, 0x45, 0x43, 0xDA, 0x46, 0x7C, 0xD1]};
@GUID(0x88AFB4B2, 0x140A, 0x44D2, [0x91, 0xE6, 0x45, 0x43, 0xDA, 0x46, 0x7C, 0xD1]);
interface IWMPSyncDevice2 : IWMPSyncDevice
{
    HRESULT setItemInfo(BSTR bstrItemName, BSTR bstrVal);
}

const GUID IID_IWMPSyncDevice3 = {0xB22C85F9, 0x263C, 0x4372, [0xA0, 0xDA, 0xB5, 0x18, 0xDB, 0x9B, 0x40, 0x98]};
@GUID(0xB22C85F9, 0x263C, 0x4372, [0xA0, 0xDA, 0xB5, 0x18, 0xDB, 0x9B, 0x40, 0x98]);
interface IWMPSyncDevice3 : IWMPSyncDevice2
{
    HRESULT estimateSyncSize(IWMPPlaylist pNonRulePlaylist, IWMPPlaylist pRulesPlaylist);
    HRESULT cancelEstimation();
}

const GUID IID_IWMPLibrary2 = {0xDD578A4E, 0x79B1, 0x426C, [0xBF, 0x8F, 0x3A, 0xDD, 0x90, 0x72, 0x50, 0x0B]};
@GUID(0xDD578A4E, 0x79B1, 0x426C, [0xBF, 0x8F, 0x3A, 0xDD, 0x90, 0x72, 0x50, 0x0B]);
interface IWMPLibrary2 : IWMPLibrary
{
    HRESULT getItemInfo(BSTR bstrItemName, BSTR* pbstrVal);
}

const GUID CLSID_WMPLib = {0x6BF52A50, 0x394A, 0x11D3, [0xB1, 0x53, 0x00, 0xC0, 0x4F, 0x79, 0xFA, 0xA6]};
@GUID(0x6BF52A50, 0x394A, 0x11D3, [0xB1, 0x53, 0x00, 0xC0, 0x4F, 0x79, 0xFA, 0xA6]);
struct WMPLib;

const GUID CLSID_WMPRemoteMediaServices = {0xDF333473, 0x2CF7, 0x4BE2, [0x90, 0x7F, 0x9A, 0xAD, 0x56, 0x61, 0x36, 0x4F]};
@GUID(0xDF333473, 0x2CF7, 0x4BE2, [0x90, 0x7F, 0x9A, 0xAD, 0x56, 0x61, 0x36, 0x4F]);
struct WMPRemoteMediaServices;

const GUID IID_IWMPEvents = {0x19A6627B, 0xDA9E, 0x47C1, [0xBB, 0x23, 0x00, 0xB5, 0xE6, 0x68, 0x23, 0x6A]};
@GUID(0x19A6627B, 0xDA9E, 0x47C1, [0xBB, 0x23, 0x00, 0xB5, 0xE6, 0x68, 0x23, 0x6A]);
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

const GUID IID_IWMPEvents2 = {0x1E7601FA, 0x47EA, 0x4107, [0x9E, 0xA9, 0x90, 0x04, 0xED, 0x96, 0x84, 0xFF]};
@GUID(0x1E7601FA, 0x47EA, 0x4107, [0x9E, 0xA9, 0x90, 0x04, 0xED, 0x96, 0x84, 0xFF]);
interface IWMPEvents2 : IWMPEvents
{
    void DeviceConnect(IWMPSyncDevice pDevice);
    void DeviceDisconnect(IWMPSyncDevice pDevice);
    void DeviceStatusChange(IWMPSyncDevice pDevice, WMPDeviceStatus NewStatus);
    void DeviceSyncStateChange(IWMPSyncDevice pDevice, WMPSyncState NewState);
    void DeviceSyncError(IWMPSyncDevice pDevice, IDispatch pMedia);
    void CreatePartnershipComplete(IWMPSyncDevice pDevice, HRESULT hrResult);
}

const GUID IID_IWMPEvents3 = {0x1F504270, 0xA66B, 0x4223, [0x8E, 0x96, 0x26, 0xA0, 0x6C, 0x63, 0xD6, 0x9F]};
@GUID(0x1F504270, 0xA66B, 0x4223, [0x8E, 0x96, 0x26, 0xA0, 0x6C, 0x63, 0xD6, 0x9F]);
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
    void StringCollectionChange(IDispatch pdispStringCollection, WMPStringCollectionChangeEventType change, int lCollectionIndex);
    void MediaCollectionMediaAdded(IDispatch pdispMedia);
    void MediaCollectionMediaRemoved(IDispatch pdispMedia);
}

const GUID IID_IWMPEvents4 = {0x26DABCFA, 0x306B, 0x404D, [0x9A, 0x6F, 0x63, 0x0A, 0x84, 0x05, 0x04, 0x8D]};
@GUID(0x26DABCFA, 0x306B, 0x404D, [0x9A, 0x6F, 0x63, 0x0A, 0x84, 0x05, 0x04, 0x8D]);
interface IWMPEvents4 : IWMPEvents3
{
    void DeviceEstimation(IWMPSyncDevice pDevice, HRESULT hrResult, long qwEstimatedUsedSpace, long qwEstimatedSpace);
}

const GUID IID__WMPOCXEvents = {0x6BF52A51, 0x394A, 0x11D3, [0xB1, 0x53, 0x00, 0xC0, 0x4F, 0x79, 0xFA, 0xA6]};
@GUID(0x6BF52A51, 0x394A, 0x11D3, [0xB1, 0x53, 0x00, 0xC0, 0x4F, 0x79, 0xFA, 0xA6]);
interface _WMPOCXEvents : IDispatch
{
}

const GUID IID_IWMPNodeRealEstate = {0x42751198, 0x5A50, 0x4460, [0xBC, 0xB4, 0x70, 0x9F, 0x8B, 0xDC, 0x8E, 0x59]};
@GUID(0x42751198, 0x5A50, 0x4460, [0xBC, 0xB4, 0x70, 0x9F, 0x8B, 0xDC, 0x8E, 0x59]);
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

const GUID IID_IWMPNodeRealEstateHost = {0x1491087D, 0x2C6B, 0x44C8, [0xB0, 0x19, 0xB3, 0xC9, 0x29, 0xD2, 0xAD, 0xA9]};
@GUID(0x1491087D, 0x2C6B, 0x44C8, [0xB0, 0x19, 0xB3, 0xC9, 0x29, 0xD2, 0xAD, 0xA9]);
interface IWMPNodeRealEstateHost : IUnknown
{
    HRESULT OnDesiredSizeChange(SIZE* pSize);
    HRESULT OnFullScreenTransition(BOOL fFullScreen);
}

const GUID IID_IWMPNodeWindowed = {0x96740BFA, 0xC56A, 0x45D1, [0xA3, 0xA4, 0x76, 0x29, 0x14, 0xD4, 0xAD, 0xE9]};
@GUID(0x96740BFA, 0xC56A, 0x45D1, [0xA3, 0xA4, 0x76, 0x29, 0x14, 0xD4, 0xAD, 0xE9]);
interface IWMPNodeWindowed : IUnknown
{
    HRESULT SetOwnerWindow(int hwnd);
    HRESULT GetOwnerWindow(int* phwnd);
}

const GUID IID_IWMPNodeWindowedHost = {0xA300415A, 0x54AA, 0x4081, [0xAD, 0xBF, 0x3B, 0x13, 0x61, 0x0D, 0x89, 0x58]};
@GUID(0xA300415A, 0x54AA, 0x4081, [0xAD, 0xBF, 0x3B, 0x13, 0x61, 0x0D, 0x89, 0x58]);
interface IWMPNodeWindowedHost : IUnknown
{
    HRESULT OnWindowMessageFromRenderer(uint uMsg, WPARAM wparam, LPARAM lparam, LRESULT* plRet, int* pfHandled);
}

const GUID IID_IWMPWindowMessageSink = {0x3A0DAA30, 0x908D, 0x4789, [0xBA, 0x87, 0xAE, 0xD8, 0x79, 0xB5, 0xC4, 0x9B]};
@GUID(0x3A0DAA30, 0x908D, 0x4789, [0xBA, 0x87, 0xAE, 0xD8, 0x79, 0xB5, 0xC4, 0x9B]);
interface IWMPWindowMessageSink : IUnknown
{
    HRESULT OnWindowMessage(uint uMsg, WPARAM wparam, LPARAM lparam, LRESULT* plRet, int* pfHandled);
}

const GUID IID_IWMPNodeWindowless = {0x9B9199AD, 0x780C, 0x4EDA, [0xB8, 0x16, 0x26, 0x1E, 0xBA, 0x5D, 0x15, 0x75]};
@GUID(0x9B9199AD, 0x780C, 0x4EDA, [0xB8, 0x16, 0x26, 0x1E, 0xBA, 0x5D, 0x15, 0x75]);
interface IWMPNodeWindowless : IWMPWindowMessageSink
{
    HRESULT OnDraw(int hdc, const(RECT)* prcDraw);
}

const GUID IID_IWMPNodeWindowlessHost = {0xBE7017C6, 0xCE34, 0x4901, [0x81, 0x06, 0x77, 0x03, 0x81, 0xAA, 0x6E, 0x3E]};
@GUID(0xBE7017C6, 0xCE34, 0x4901, [0x81, 0x06, 0x77, 0x03, 0x81, 0xAA, 0x6E, 0x3E]);
interface IWMPNodeWindowlessHost : IUnknown
{
    HRESULT InvalidateRect(const(RECT)* prc, BOOL fErase);
}

const GUID IID_IWMPVideoRenderConfig = {0x6D6CF803, 0x1EC0, 0x4C8D, [0xB3, 0xCA, 0xF1, 0x8E, 0x27, 0x28, 0x20, 0x74]};
@GUID(0x6D6CF803, 0x1EC0, 0x4C8D, [0xB3, 0xCA, 0xF1, 0x8E, 0x27, 0x28, 0x20, 0x74]);
interface IWMPVideoRenderConfig : IUnknown
{
    HRESULT put_presenterActivate(IMFActivate pActivate);
}

const GUID IID_IWMPAudioRenderConfig = {0xE79C6349, 0x5997, 0x4CE4, [0x91, 0x7C, 0x22, 0xA3, 0x39, 0x1E, 0xC5, 0x64]};
@GUID(0xE79C6349, 0x5997, 0x4CE4, [0x91, 0x7C, 0x22, 0xA3, 0x39, 0x1E, 0xC5, 0x64]);
interface IWMPAudioRenderConfig : IUnknown
{
    HRESULT get_audioOutputDevice(BSTR* pbstrOutputDevice);
    HRESULT put_audioOutputDevice(BSTR bstrOutputDevice);
}

const GUID IID_IWMPRenderConfig = {0x959506C1, 0x0314, 0x4EC5, [0x9E, 0x61, 0x85, 0x28, 0xDB, 0x5E, 0x54, 0x78]};
@GUID(0x959506C1, 0x0314, 0x4EC5, [0x9E, 0x61, 0x85, 0x28, 0xDB, 0x5E, 0x54, 0x78]);
interface IWMPRenderConfig : IUnknown
{
    HRESULT put_inProcOnly(BOOL fInProc);
    HRESULT get_inProcOnly(int* pfInProc);
}

enum WMPServices_StreamState
{
    WMPServices_StreamState_Stop = 0,
    WMPServices_StreamState_Pause = 1,
    WMPServices_StreamState_Play = 2,
}

const GUID IID_IWMPServices = {0xAFB6B76B, 0x1E20, 0x4198, [0x83, 0xB3, 0x19, 0x1D, 0xB6, 0xE0, 0xB1, 0x49]};
@GUID(0xAFB6B76B, 0x1E20, 0x4198, [0x83, 0xB3, 0x19, 0x1D, 0xB6, 0xE0, 0xB1, 0x49]);
interface IWMPServices : IUnknown
{
    HRESULT GetStreamTime(long* prt);
    HRESULT GetStreamState(WMPServices_StreamState* pState);
}

const GUID IID_IWMPMediaPluginRegistrar = {0x68E27045, 0x05BD, 0x40B2, [0x97, 0x20, 0x23, 0x08, 0x8C, 0x78, 0xE3, 0x90]};
@GUID(0x68E27045, 0x05BD, 0x40B2, [0x97, 0x20, 0x23, 0x08, 0x8C, 0x78, 0xE3, 0x90]);
interface IWMPMediaPluginRegistrar : IUnknown
{
    HRESULT WMPRegisterPlayerPlugin(const(wchar)* pwszFriendlyName, const(wchar)* pwszDescription, const(wchar)* pwszUninstallString, uint dwPriority, Guid guidPluginType, Guid clsid, uint cMediaTypes, void* pMediaTypes);
    HRESULT WMPUnRegisterPlayerPlugin(Guid guidPluginType, Guid clsid);
}

enum WMPPlugin_Caps
{
    WMPPlugin_Caps_CannotConvertFormats = 1,
}

const GUID IID_IWMPPlugin = {0xF1392A70, 0x024C, 0x42BB, [0xA9, 0x98, 0x73, 0xDF, 0xDF, 0xE7, 0xD5, 0xA7]};
@GUID(0xF1392A70, 0x024C, 0x42BB, [0xA9, 0x98, 0x73, 0xDF, 0xDF, 0xE7, 0xD5, 0xA7]);
interface IWMPPlugin : IUnknown
{
    HRESULT Init(uint dwPlaybackContext);
    HRESULT Shutdown();
    HRESULT GetID(Guid* pGUID);
    HRESULT GetCaps(uint* pdwFlags);
    HRESULT AdviseWMPServices(IWMPServices pWMPServices);
    HRESULT UnAdviseWMPServices();
}

const GUID IID_IWMPPluginEnable = {0x5FCA444C, 0x7AD1, 0x479D, [0xA4, 0xEF, 0x40, 0x56, 0x6A, 0x53, 0x09, 0xD6]};
@GUID(0x5FCA444C, 0x7AD1, 0x479D, [0xA4, 0xEF, 0x40, 0x56, 0x6A, 0x53, 0x09, 0xD6]);
interface IWMPPluginEnable : IUnknown
{
    HRESULT SetEnable(BOOL fEnable);
    HRESULT GetEnable(int* pfEnable);
}

const GUID IID_IWMPGraphCreation = {0xBFB377E5, 0xC594, 0x4369, [0xA9, 0x70, 0xDE, 0x89, 0x6D, 0x5E, 0xCE, 0x74]};
@GUID(0xBFB377E5, 0xC594, 0x4369, [0xA9, 0x70, 0xDE, 0x89, 0x6D, 0x5E, 0xCE, 0x74]);
interface IWMPGraphCreation : IUnknown
{
    HRESULT GraphCreationPreRender(IUnknown pFilterGraph, IUnknown pReserved);
    HRESULT GraphCreationPostRender(IUnknown pFilterGraph);
    HRESULT GetGraphCreationFlags(uint* pdwFlags);
}

const GUID IID_IWMPConvert = {0xD683162F, 0x57D4, 0x4108, [0x83, 0x73, 0x4A, 0x96, 0x76, 0xD1, 0xC2, 0xE9]};
@GUID(0xD683162F, 0x57D4, 0x4108, [0x83, 0x73, 0x4A, 0x96, 0x76, 0xD1, 0xC2, 0xE9]);
interface IWMPConvert : IUnknown
{
    HRESULT ConvertFile(BSTR bstrInputFile, BSTR bstrDestinationFolder, BSTR* pbstrOutputFile);
    HRESULT GetErrorURL(BSTR* pbstrURL);
}

const GUID IID_IWMPTranscodePolicy = {0xB64CBAC3, 0x401C, 0x4327, [0xA3, 0xE8, 0xB9, 0xFE, 0xB3, 0xA8, 0xC2, 0x5C]};
@GUID(0xB64CBAC3, 0x401C, 0x4327, [0xA3, 0xE8, 0xB9, 0xFE, 0xB3, 0xA8, 0xC2, 0x5C]);
interface IWMPTranscodePolicy : IUnknown
{
    HRESULT allowTranscode(short* pvbAllow);
}

const GUID IID_IWMPUserEventSink = {0xCFCCFA72, 0xC343, 0x48C3, [0xA2, 0xDE, 0xB7, 0xA4, 0x40, 0x2E, 0x39, 0xF2]};
@GUID(0xCFCCFA72, 0xC343, 0x48C3, [0xA2, 0xDE, 0xB7, 0xA4, 0x40, 0x2E, 0x39, 0xF2]);
interface IWMPUserEventSink : IUnknown
{
    HRESULT NotifyUserEvent(int EventCode);
}

const GUID CLSID_FeedsManager = {0xFAEB54C4, 0xF66F, 0x4806, [0x83, 0xA0, 0x80, 0x52, 0x99, 0xF5, 0xE3, 0xAD]};
@GUID(0xFAEB54C4, 0xF66F, 0x4806, [0x83, 0xA0, 0x80, 0x52, 0x99, 0xF5, 0xE3, 0xAD]);
struct FeedsManager;

const GUID CLSID_FeedFolderWatcher = {0x281001ED, 0x7765, 0x4CB0, [0x84, 0xAF, 0xE9, 0xB3, 0x87, 0xAF, 0x01, 0xFF]};
@GUID(0x281001ED, 0x7765, 0x4CB0, [0x84, 0xAF, 0xE9, 0xB3, 0x87, 0xAF, 0x01, 0xFF]);
struct FeedFolderWatcher;

const GUID CLSID_FeedWatcher = {0x18A6737B, 0xF433, 0x4687, [0x89, 0xBC, 0xA1, 0xB4, 0xDF, 0xB9, 0xF1, 0x23]};
@GUID(0x18A6737B, 0xF433, 0x4687, [0x89, 0xBC, 0xA1, 0xB4, 0xDF, 0xB9, 0xF1, 0x23]);
struct FeedWatcher;

enum FEEDS_BACKGROUNDSYNC_ACTION
{
    FBSA_DISABLE = 0,
    FBSA_ENABLE = 1,
    FBSA_RUNNOW = 2,
}

enum FEEDS_BACKGROUNDSYNC_STATUS
{
    FBSS_DISABLED = 0,
    FBSS_ENABLED = 1,
}

enum FEEDS_EVENTS_SCOPE
{
    FES_ALL = 0,
    FES_SELF_ONLY = 1,
    FES_SELF_AND_CHILDREN_ONLY = 2,
}

enum FEEDS_EVENTS_MASK
{
    FEM_FOLDEREVENTS = 1,
    FEM_FEEDEVENTS = 2,
}

enum FEEDS_XML_SORT_PROPERTY
{
    FXSP_NONE = 0,
    FXSP_PUBDATE = 1,
    FXSP_DOWNLOADTIME = 2,
}

enum FEEDS_XML_SORT_ORDER
{
    FXSO_NONE = 0,
    FXSO_ASCENDING = 1,
    FXSO_DESCENDING = 2,
}

enum FEEDS_XML_FILTER_FLAGS
{
    FXFF_ALL = 0,
    FXFF_UNREAD = 1,
    FXFF_READ = 2,
}

enum FEEDS_XML_INCLUDE_FLAGS
{
    FXIF_NONE = 0,
    FXIF_CF_EXTENSIONS = 1,
}

enum FEEDS_DOWNLOAD_STATUS
{
    FDS_NONE = 0,
    FDS_PENDING = 1,
    FDS_DOWNLOADING = 2,
    FDS_DOWNLOADED = 3,
    FDS_DOWNLOAD_FAILED = 4,
}

enum FEEDS_SYNC_SETTING
{
    FSS_DEFAULT = 0,
    FSS_INTERVAL = 1,
    FSS_MANUAL = 2,
    FSS_SUGGESTED = 3,
}

enum FEEDS_DOWNLOAD_ERROR
{
    FDE_NONE = 0,
    FDE_DOWNLOAD_FAILED = 1,
    FDE_INVALID_FEED_FORMAT = 2,
    FDE_NORMALIZATION_FAILED = 3,
    FDE_PERSISTENCE_FAILED = 4,
    FDE_DOWNLOAD_BLOCKED = 5,
    FDE_CANCELED = 6,
    FDE_UNSUPPORTED_AUTH = 7,
    FDE_BACKGROUND_DOWNLOAD_DISABLED = 8,
    FDE_NOT_EXIST = 9,
    FDE_UNSUPPORTED_MSXML = 10,
    FDE_UNSUPPORTED_DTD = 11,
    FDE_DOWNLOAD_SIZE_LIMIT_EXCEEDED = 12,
    FDE_ACCESS_DENIED = 13,
    FDE_AUTH_FAILED = 14,
    FDE_INVALID_AUTH = 15,
}

enum FEEDS_EVENTS_ITEM_COUNT_FLAGS
{
    FEICF_READ_ITEM_COUNT_CHANGED = 1,
    FEICF_UNREAD_ITEM_COUNT_CHANGED = 2,
}

enum FEEDS_ERROR_CODE
{
    FEC_E_ERRORBASE = -1073479168,
    FEC_E_INVALIDMSXMLPROPERTY = -1073479168,
    FEC_E_DOWNLOADSIZELIMITEXCEEDED = -1073479167,
}

const GUID IID_IXFeedsManager = {0x5357E238, 0xFB12, 0x4ACA, [0xA9, 0x30, 0xCA, 0xB7, 0x83, 0x2B, 0x84, 0xBF]};
@GUID(0x5357E238, 0xFB12, 0x4ACA, [0xA9, 0x30, 0xCA, 0xB7, 0x83, 0x2B, 0x84, 0xBF]);
interface IXFeedsManager : IUnknown
{
    HRESULT RootFolder(const(Guid)* riid, void** ppv);
    HRESULT IsSubscribed(const(wchar)* pszUrl, int* pbSubscribed);
    HRESULT ExistsFeed(const(wchar)* pszPath, int* pbFeedExists);
    HRESULT GetFeed(const(wchar)* pszPath, const(Guid)* riid, void** ppv);
    HRESULT GetFeedByUrl(const(wchar)* pszUrl, const(Guid)* riid, void** ppv);
    HRESULT ExistsFolder(const(wchar)* pszPath, int* pbFolderExists);
    HRESULT GetFolder(const(wchar)* pszPath, const(Guid)* riid, void** ppv);
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

const GUID IID_IXFeedsEnum = {0xDC43A9D5, 0x5015, 0x4301, [0x8C, 0x96, 0xA4, 0x74, 0x34, 0xB4, 0xD6, 0x58]};
@GUID(0xDC43A9D5, 0x5015, 0x4301, [0x8C, 0x96, 0xA4, 0x74, 0x34, 0xB4, 0xD6, 0x58]);
interface IXFeedsEnum : IUnknown
{
    HRESULT Count(uint* puiCount);
    HRESULT Item(uint uiIndex, const(Guid)* riid, void** ppv);
}

const GUID IID_IXFeedFolder = {0x4C963678, 0x3A51, 0x4B88, [0x85, 0x31, 0x98, 0xB9, 0x0B, 0x65, 0x08, 0xF2]};
@GUID(0x4C963678, 0x3A51, 0x4B88, [0x85, 0x31, 0x98, 0xB9, 0x0B, 0x65, 0x08, 0xF2]);
interface IXFeedFolder : IUnknown
{
    HRESULT Feeds(IXFeedsEnum* ppfe);
    HRESULT Subfolders(IXFeedsEnum* ppfe);
    HRESULT CreateFeed(const(wchar)* pszName, const(wchar)* pszUrl, const(Guid)* riid, void** ppv);
    HRESULT CreateSubfolder(const(wchar)* pszName, const(Guid)* riid, void** ppv);
    HRESULT ExistsFeed(const(wchar)* pszName, int* pbFeedExists);
    HRESULT ExistsSubfolder(const(wchar)* pszName, int* pbSubfolderExists);
    HRESULT GetFeed(const(wchar)* pszName, const(Guid)* riid, void** ppv);
    HRESULT GetSubfolder(const(wchar)* pszName, const(Guid)* riid, void** ppv);
    HRESULT Delete();
    HRESULT Name(ushort** ppszName);
    HRESULT Rename(const(wchar)* pszName);
    HRESULT Path(ushort** ppszPath);
    HRESULT Move(const(wchar)* pszPath);
    HRESULT Parent(const(Guid)* riid, void** ppv);
    HRESULT IsRoot(int* pbIsRootFeedFolder);
    HRESULT GetWatcher(FEEDS_EVENTS_SCOPE scope, FEEDS_EVENTS_MASK mask, const(Guid)* riid, void** ppv);
    HRESULT TotalUnreadItemCount(uint* puiTotalUnreadItemCount);
    HRESULT TotalItemCount(uint* puiTotalItemCount);
}

const GUID IID_IXFeedFolderEvents = {0x7964B769, 0x234A, 0x4BB1, [0xA5, 0xF4, 0x90, 0x45, 0x4C, 0x8A, 0xD0, 0x7E]};
@GUID(0x7964B769, 0x234A, 0x4BB1, [0xA5, 0xF4, 0x90, 0x45, 0x4C, 0x8A, 0xD0, 0x7E]);
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

const GUID IID_IXFeed = {0xA44179A4, 0xE0F6, 0x403B, [0xAF, 0x8D, 0xD0, 0x80, 0xF4, 0x25, 0xA4, 0x51]};
@GUID(0xA44179A4, 0xE0F6, 0x403B, [0xAF, 0x8D, 0xD0, 0x80, 0xF4, 0x25, 0xA4, 0x51]);
interface IXFeed : IUnknown
{
    HRESULT Xml(uint uiItemCount, FEEDS_XML_SORT_PROPERTY sortProperty, FEEDS_XML_SORT_ORDER sortOrder, FEEDS_XML_FILTER_FLAGS filterFlags, FEEDS_XML_INCLUDE_FLAGS includeFlags, IStream* pps);
    HRESULT Name(ushort** ppszName);
    HRESULT Rename(const(wchar)* pszName);
    HRESULT Url(ushort** ppszUrl);
    HRESULT SetUrl(const(wchar)* pszUrl);
    HRESULT LocalId(Guid* pguid);
    HRESULT Path(ushort** ppszPath);
    HRESULT Move(const(wchar)* pszPath);
    HRESULT Parent(const(Guid)* riid, void** ppv);
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
    HRESULT GetItem(uint uiId, const(Guid)* riid, void** ppv);
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
    HRESULT GetWatcher(FEEDS_EVENTS_SCOPE scope, FEEDS_EVENTS_MASK mask, const(Guid)* riid, void** ppv);
    HRESULT UnreadItemCount(uint* puiUnreadItemCount);
    HRESULT ItemCount(uint* puiItemCount);
}

const GUID IID_IXFeed2 = {0xCE528E77, 0x3716, 0x4EB7, [0x95, 0x6D, 0xF5, 0xE3, 0x75, 0x02, 0xE1, 0x2A]};
@GUID(0xCE528E77, 0x3716, 0x4EB7, [0x95, 0x6D, 0xF5, 0xE3, 0x75, 0x02, 0xE1, 0x2A]);
interface IXFeed2 : IXFeed
{
    HRESULT GetItemByEffectiveId(uint uiEffectiveId, const(Guid)* riid, void** ppv);
    HRESULT LastItemDownloadTime(SYSTEMTIME* pstLastItemDownloadTime);
    HRESULT Username(ushort** ppszUsername);
    HRESULT Password(ushort** ppszPassword);
    HRESULT SetCredentials(const(wchar)* pszUsername, const(wchar)* pszPassword);
    HRESULT ClearCredentials();
}

const GUID IID_IXFeedEvents = {0x1630852E, 0x1263, 0x465B, [0x98, 0xE5, 0xFE, 0x60, 0xFF, 0xEC, 0x4A, 0xC2]};
@GUID(0x1630852E, 0x1263, 0x465B, [0x98, 0xE5, 0xFE, 0x60, 0xFF, 0xEC, 0x4A, 0xC2]);
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

const GUID IID_IXFeedItem = {0xE757B2F5, 0xE73E, 0x434E, [0xA1, 0xBF, 0x2B, 0xD7, 0xC3, 0xE6, 0x0F, 0xCB]};
@GUID(0xE757B2F5, 0xE73E, 0x434E, [0xA1, 0xBF, 0x2B, 0xD7, 0xC3, 0xE6, 0x0F, 0xCB]);
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
    HRESULT Enclosure(const(Guid)* riid, void** ppv);
    HRESULT IsRead(int* pbIsRead);
    HRESULT SetIsRead(BOOL bIsRead);
    HRESULT LocalId(uint* puiId);
    HRESULT Parent(const(Guid)* riid, void** ppv);
    HRESULT Delete();
    HRESULT DownloadUrl(ushort** ppszUrl);
    HRESULT LastDownloadTime(SYSTEMTIME* pstLastDownloadTime);
    HRESULT Modified(SYSTEMTIME* pstModifiedTime);
}

const GUID IID_IXFeedItem2 = {0x6CDA2DC7, 0x9013, 0x4522, [0x99, 0x70, 0x2A, 0x9D, 0xD9, 0xEA, 0xD5, 0xA3]};
@GUID(0x6CDA2DC7, 0x9013, 0x4522, [0x99, 0x70, 0x2A, 0x9D, 0xD9, 0xEA, 0xD5, 0xA3]);
interface IXFeedItem2 : IXFeedItem
{
    HRESULT EffectiveId(uint* puiEffectiveId);
}

const GUID IID_IXFeedEnclosure = {0xBFBFB953, 0x644F, 0x4792, [0xB6, 0x9C, 0xDF, 0xAC, 0xA4, 0xCB, 0xF8, 0x9A]};
@GUID(0xBFBFB953, 0x644F, 0x4792, [0xB6, 0x9C, 0xDF, 0xAC, 0xA4, 0xCB, 0xF8, 0x9A]);
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
    HRESULT Parent(const(Guid)* riid, void** ppv);
    HRESULT DownloadUrl(ushort** ppszUrl);
    HRESULT DownloadMimeType(ushort** ppszMimeType);
    HRESULT RemoveFile();
    HRESULT SetFile(const(wchar)* pszDownloadUrl, const(wchar)* pszDownloadFilePath, const(wchar)* pszDownloadMimeType, const(wchar)* pszEnclosureFilename);
}

const GUID IID_IFeedsManager = {0xA74029CC, 0x1F1A, 0x4906, [0x88, 0xF0, 0x81, 0x06, 0x38, 0xD8, 0x65, 0x91]};
@GUID(0xA74029CC, 0x1F1A, 0x4906, [0x88, 0xF0, 0x81, 0x06, 0x38, 0xD8, 0x65, 0x91]);
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

const GUID IID_IFeedsEnum = {0xE3CD0028, 0x2EED, 0x4C60, [0x8F, 0xAE, 0xA3, 0x22, 0x53, 0x09, 0xA8, 0x36]};
@GUID(0xE3CD0028, 0x2EED, 0x4C60, [0x8F, 0xAE, 0xA3, 0x22, 0x53, 0x09, 0xA8, 0x36]);
interface IFeedsEnum : IDispatch
{
    HRESULT get_Count(int* count);
    HRESULT Item(int index, IDispatch* disp);
    HRESULT get__NewEnum(IEnumVARIANT* enumVar);
}

const GUID IID_IFeedFolder = {0x81F04AD1, 0x4194, 0x4D7D, [0x86, 0xD6, 0x11, 0x81, 0x3C, 0xEC, 0x16, 0x3C]};
@GUID(0x81F04AD1, 0x4194, 0x4D7D, [0x86, 0xD6, 0x11, 0x81, 0x3C, 0xEC, 0x16, 0x3C]);
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
    HRESULT GetWatcher(FEEDS_EVENTS_SCOPE scope, FEEDS_EVENTS_MASK mask, IDispatch* disp);
}

const GUID IID_IFeedFolderEvents = {0x20A59FA6, 0xA844, 0x4630, [0x9E, 0x98, 0x17, 0x5F, 0x70, 0xB4, 0xD5, 0x5B]};
@GUID(0x20A59FA6, 0xA844, 0x4630, [0x9E, 0x98, 0x17, 0x5F, 0x70, 0xB4, 0xD5, 0x5B]);
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

const GUID IID_IFeed = {0xF7F915D8, 0x2EDE, 0x42BC, [0x98, 0xE7, 0xA5, 0xD0, 0x50, 0x63, 0xA7, 0x57]};
@GUID(0xF7F915D8, 0x2EDE, 0x42BC, [0x98, 0xE7, 0xA5, 0xD0, 0x50, 0x63, 0xA7, 0x57]);
interface IFeed : IDispatch
{
    HRESULT Xml(int count, FEEDS_XML_SORT_PROPERTY sortProperty, FEEDS_XML_SORT_ORDER sortOrder, FEEDS_XML_FILTER_FLAGS filterFlags, FEEDS_XML_INCLUDE_FLAGS includeFlags, BSTR* xml);
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
    HRESULT GetWatcher(FEEDS_EVENTS_SCOPE scope, FEEDS_EVENTS_MASK mask, IDispatch* disp);
    HRESULT get_UnreadItemCount(int* count);
    HRESULT get_ItemCount(int* count);
}

const GUID IID_IFeed2 = {0x33F2EA09, 0x1398, 0x4AB9, [0xB6, 0xA4, 0xF9, 0x4B, 0x49, 0xD0, 0xA4, 0x2E]};
@GUID(0x33F2EA09, 0x1398, 0x4AB9, [0xB6, 0xA4, 0xF9, 0x4B, 0x49, 0xD0, 0xA4, 0x2E]);
interface IFeed2 : IFeed
{
    HRESULT GetItemByEffectiveId(int itemEffectiveId, IDispatch* disp);
    HRESULT get_LastItemDownloadTime(double* lastItemDownloadTime);
    HRESULT get_Username(BSTR* username);
    HRESULT get_Password(BSTR* password);
    HRESULT SetCredentials(BSTR username, BSTR password);
    HRESULT ClearCredentials();
}

const GUID IID_IFeedEvents = {0xABF35C99, 0x0681, 0x47EA, [0x9A, 0x8C, 0x14, 0x36, 0xA3, 0x75, 0xA9, 0x9E]};
@GUID(0xABF35C99, 0x0681, 0x47EA, [0x9A, 0x8C, 0x14, 0x36, 0xA3, 0x75, 0xA9, 0x9E]);
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

const GUID IID_IFeedItem = {0x0A1E6CAD, 0x0A47, 0x4DA2, [0xA1, 0x3D, 0x5B, 0xAA, 0xA5, 0xC8, 0xBD, 0x4F]};
@GUID(0x0A1E6CAD, 0x0A47, 0x4DA2, [0xA1, 0x3D, 0x5B, 0xAA, 0xA5, 0xC8, 0xBD, 0x4F]);
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

const GUID IID_IFeedItem2 = {0x79AC9EF4, 0xF9C1, 0x4D2B, [0xA5, 0x0B, 0xA7, 0xFF, 0xBA, 0x4D, 0xCF, 0x37]};
@GUID(0x79AC9EF4, 0xF9C1, 0x4D2B, [0xA5, 0x0B, 0xA7, 0xFF, 0xBA, 0x4D, 0xCF, 0x37]);
interface IFeedItem2 : IFeedItem
{
    HRESULT get_EffectiveId(int* effectiveId);
}

const GUID IID_IFeedEnclosure = {0x361C26F7, 0x90A4, 0x4E67, [0xAE, 0x09, 0x3A, 0x36, 0xA5, 0x46, 0x43, 0x6A]};
@GUID(0x361C26F7, 0x90A4, 0x4E67, [0xAE, 0x09, 0x3A, 0x36, 0xA5, 0x46, 0x43, 0x6A]);
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

enum PlayerState
{
    stop_state = 0,
    pause_state = 1,
    play_state = 2,
}

struct TimedLevel
{
    ubyte frequency;
    ubyte waveform;
    int state;
    long timeStamp;
}

const GUID IID_IWMPEffects = {0xD3984C13, 0xC3CB, 0x48E2, [0x8B, 0xE5, 0x51, 0x68, 0x34, 0x0B, 0x4F, 0x35]};
@GUID(0xD3984C13, 0xC3CB, 0x48E2, [0x8B, 0xE5, 0x51, 0x68, 0x34, 0x0B, 0x4F, 0x35]);
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

const GUID IID_IWMPEffects2 = {0x695386EC, 0xAA3C, 0x4618, [0xA5, 0xE1, 0xDD, 0x9A, 0x8B, 0x98, 0x76, 0x32]};
@GUID(0x695386EC, 0xAA3C, 0x4618, [0xA5, 0xE1, 0xDD, 0x9A, 0x8B, 0x98, 0x76, 0x32]);
interface IWMPEffects2 : IWMPEffects
{
    HRESULT SetCore(IWMPCore pPlayer);
    HRESULT Create(HWND hwndParent);
    HRESULT Destroy();
    HRESULT NotifyNewMedia(IWMPMedia pMedia);
    HRESULT OnWindowMessage(uint msg, WPARAM WParam, LPARAM LParam, LRESULT* plResultParam);
    HRESULT RenderWindowed(TimedLevel* pData, BOOL fRequiredRender);
}

const GUID IID_IWMPPluginUI = {0x4C5E8F9F, 0xAD3E, 0x4BF9, [0x97, 0x53, 0xFC, 0xD3, 0x0D, 0x6D, 0x38, 0xDD]};
@GUID(0x4C5E8F9F, 0xAD3E, 0x4BF9, [0x97, 0x53, 0xFC, 0xD3, 0x0D, 0x6D, 0x38, 0xDD]);
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

enum WMPPartnerNotification
{
    wmpsnBackgroundProcessingBegin = 1,
    wmpsnBackgroundProcessingEnd = 2,
    wmpsnCatalogDownloadFailure = 3,
    wmpsnCatalogDownloadComplete = 4,
}

enum WMPCallbackNotification
{
    wmpcnLoginStateChange = 1,
    wmpcnAuthResult = 2,
    wmpcnLicenseUpdated = 3,
    wmpcnNewCatalogAvailable = 4,
    wmpcnNewPluginAvailable = 5,
    wmpcnDisableRadioSkipping = 6,
}

enum WMPTaskType
{
    wmpttBrowse = 1,
    wmpttSync = 2,
    wmpttBurn = 3,
    wmpttCurrent = 4,
}

struct WMPContextMenuInfo
{
    uint dwID;
    BSTR bstrMenuText;
    BSTR bstrHelpText;
}

const GUID IID_IWMPContentContainer = {0xAD7F4D9C, 0x1A9F, 0x4ED2, [0x98, 0x15, 0xEC, 0xC0, 0xB5, 0x8C, 0xB6, 0x16]};
@GUID(0xAD7F4D9C, 0x1A9F, 0x4ED2, [0x98, 0x15, 0xEC, 0xC0, 0xB5, 0x8C, 0xB6, 0x16]);
interface IWMPContentContainer : IUnknown
{
    HRESULT GetID(uint* pContentID);
    HRESULT GetPrice(BSTR* pbstrPrice);
    HRESULT GetType(BSTR* pbstrType);
    HRESULT GetContentCount(uint* pcContent);
    HRESULT GetContentPrice(uint idxContent, BSTR* pbstrPrice);
    HRESULT GetContentID(uint idxContent, uint* pContentID);
}

enum WMPTransactionType
{
    wmpttNoTransaction = 0,
    wmpttDownload = 1,
    wmpttBuy = 2,
}

const GUID IID_IWMPContentContainerList = {0xA9937F78, 0x0802, 0x4AF8, [0x8B, 0x8D, 0xE3, 0xF0, 0x45, 0xBC, 0x8A, 0xB5]};
@GUID(0xA9937F78, 0x0802, 0x4AF8, [0x8B, 0x8D, 0xE3, 0xF0, 0x45, 0xBC, 0x8A, 0xB5]);
interface IWMPContentContainerList : IUnknown
{
    HRESULT GetTransactionType(WMPTransactionType* pwmptt);
    HRESULT GetContainerCount(uint* pcContainer);
    HRESULT GetContainer(uint idxContainer, IWMPContentContainer* ppContent);
}

enum WMPTemplateSize
{
    wmptsSmall = 0,
    wmptsMedium = 1,
    wmptsLarge = 2,
}

enum WMPStreamingType
{
    wmpstUnknown = 0,
    wmpstMusic = 1,
    wmpstVideo = 2,
    wmpstRadio = 3,
}

enum WMPAccountType
{
    wmpatBuyOnly = 1,
    wmpatSubscription = 2,
    wmpatJanus = 3,
}

const GUID IID_IWMPContentPartnerCallback = {0x9E8F7DA2, 0x0695, 0x403C, [0xB6, 0x97, 0xDA, 0x10, 0xFA, 0xFA, 0xA6, 0x76]};
@GUID(0x9E8F7DA2, 0x0695, 0x403C, [0xB6, 0x97, 0xDA, 0x10, 0xFA, 0xFA, 0xA6, 0x76]);
interface IWMPContentPartnerCallback : IUnknown
{
    HRESULT Notify(WMPCallbackNotification type, VARIANT* pContext);
    HRESULT BuyComplete(HRESULT hrResult, uint dwBuyCookie);
    HRESULT DownloadTrack(uint cookie, BSTR bstrTrackURL, uint dwServiceTrackID, BSTR bstrDownloadParams, HRESULT hrDownload);
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

const GUID IID_IWMPContentPartner = {0x55455073, 0x41B5, 0x4E75, [0x87, 0xB8, 0xF1, 0x3B, 0xDB, 0x29, 0x1D, 0x08]};
@GUID(0x55455073, 0x41B5, 0x4E75, [0x87, 0xB8, 0xF1, 0x3B, 0xDB, 0x29, 0x1D, 0x08]);
interface IWMPContentPartner : IUnknown
{
    HRESULT SetCallback(IWMPContentPartnerCallback pCallback);
    HRESULT Notify(WMPPartnerNotification type, VARIANT* pContext);
    HRESULT GetItemInfo(BSTR bstrInfoName, VARIANT* pContext, VARIANT* pData);
    HRESULT GetContentPartnerInfo(BSTR bstrInfoName, VARIANT* pData);
    HRESULT GetCommands(BSTR location, VARIANT* pLocationContext, BSTR itemLocation, uint cItemIDs, char* prgItemIDs, uint* pcItemIDs, char* pprgItems);
    HRESULT InvokeCommand(uint dwCommandID, BSTR location, VARIANT* pLocationContext, BSTR itemLocation, uint cItemIDs, char* rgItemIDs);
    HRESULT CanBuySilent(IWMPContentContainerList pInfo, BSTR* pbstrTotalPrice, short* pSilentOK);
    HRESULT Buy(IWMPContentContainerList pInfo, uint cookie);
    HRESULT GetStreamingURL(WMPStreamingType st, VARIANT* pStreamContext, BSTR* pbstrURL);
    HRESULT Download(IWMPContentContainerList pInfo, uint cookie);
    HRESULT DownloadTrackComplete(HRESULT hrResult, uint contentID, BSTR downloadTrackParam);
    HRESULT RefreshLicense(uint dwCookie, short fLocal, BSTR bstrURL, WMPStreamingType type, uint contentID, BSTR bstrRefreshReason, VARIANT* pReasonContext);
    HRESULT GetCatalogURL(uint dwCatalogVersion, uint dwCatalogSchemaVersion, uint catalogLCID, uint* pdwNewCatalogVersion, BSTR* pbstrCatalogURL, VARIANT* pExpirationDate);
    HRESULT GetTemplate(WMPTaskType task, BSTR location, VARIANT* pContext, BSTR clickLocation, VARIANT* pClickContext, BSTR bstrFilter, BSTR bstrViewParams, BSTR* pbstrTemplateURL, WMPTemplateSize* pTemplateSize);
    HRESULT UpdateDevice(BSTR bstrDeviceName);
    HRESULT GetListContents(BSTR location, VARIANT* pContext, BSTR bstrListType, BSTR bstrParams, uint dwListCookie);
    HRESULT Login(BLOB userInfo, BLOB pwdInfo, short fUsedCachedCreds, short fOkToCache);
    HRESULT Authenticate(BLOB userInfo, BLOB pwdInfo);
    HRESULT Logout();
    HRESULT SendMessageA(BSTR bstrMsg, BSTR bstrParam);
    HRESULT StationEvent(BSTR bstrStationEventType, uint StationId, uint PlaylistIndex, uint TrackID, BSTR TrackData, uint dwSecondsPlayed);
    HRESULT CompareContainerListPrices(IWMPContentContainerList pListBase, IWMPContentContainerList pListCompare, int* pResult);
    HRESULT VerifyPermission(BSTR bstrPermission, VARIANT* pContext);
}

enum WMPSubscriptionServiceEvent
{
    wmpsseCurrentBegin = 1,
    wmpsseCurrentEnd = 2,
    wmpsseFullBegin = 3,
    wmpsseFullEnd = 4,
}

const GUID IID_IWMPSubscriptionService = {0x376055F8, 0x2A59, 0x4A73, [0x95, 0x01, 0xDC, 0xA5, 0x27, 0x3A, 0x7A, 0x10]};
@GUID(0x376055F8, 0x2A59, 0x4A73, [0x95, 0x01, 0xDC, 0xA5, 0x27, 0x3A, 0x7A, 0x10]);
interface IWMPSubscriptionService : IUnknown
{
    HRESULT allowPlay(HWND hwnd, IWMPMedia pMedia, int* pfAllowPlay);
    HRESULT allowCDBurn(HWND hwnd, IWMPPlaylist pPlaylist, int* pfAllowBurn);
    HRESULT allowPDATransfer(HWND hwnd, IWMPPlaylist pPlaylist, int* pfAllowTransfer);
    HRESULT startBackgroundProcessing(HWND hwnd);
}

const GUID IID_IWMPSubscriptionServiceCallback = {0xDD01D127, 0x2DC2, 0x4C3A, [0x87, 0x6E, 0x63, 0x31, 0x20, 0x79, 0xF9, 0xB0]};
@GUID(0xDD01D127, 0x2DC2, 0x4C3A, [0x87, 0x6E, 0x63, 0x31, 0x20, 0x79, 0xF9, 0xB0]);
interface IWMPSubscriptionServiceCallback : IUnknown
{
    HRESULT onComplete(HRESULT hrResult);
}

const GUID IID_IWMPSubscriptionService2 = {0xA94C120E, 0xD600, 0x4EC6, [0xB0, 0x5E, 0xEC, 0x9D, 0x56, 0xD8, 0x4D, 0xE0]};
@GUID(0xA94C120E, 0xD600, 0x4EC6, [0xB0, 0x5E, 0xEC, 0x9D, 0x56, 0xD8, 0x4D, 0xE0]);
interface IWMPSubscriptionService2 : IWMPSubscriptionService
{
    HRESULT stopBackgroundProcessing();
    HRESULT serviceEvent(WMPSubscriptionServiceEvent event);
    HRESULT deviceAvailable(BSTR bstrDeviceName, IWMPSubscriptionServiceCallback pCB);
    HRESULT prepareForSync(BSTR bstrFilename, BSTR bstrDeviceName, IWMPSubscriptionServiceCallback pCB);
}

enum WMPSubscriptionDownloadState
{
    wmpsdlsDownloading = 0,
    wmpsdlsPaused = 1,
    wmpsdlsProcessing = 2,
    wmpsdlsCompleted = 3,
    wmpsdlsCancelled = 4,
}

const GUID IID_IWMPDownloadItem = {0xC9470E8E, 0x3F6B, 0x46A9, [0xA0, 0xA9, 0x45, 0x28, 0x15, 0xC3, 0x42, 0x97]};
@GUID(0xC9470E8E, 0x3F6B, 0x46A9, [0xA0, 0xA9, 0x45, 0x28, 0x15, 0xC3, 0x42, 0x97]);
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

const GUID IID_IWMPDownloadItem2 = {0x9FBB3336, 0x6DA3, 0x479D, [0xB8, 0xFF, 0x67, 0xD4, 0x6E, 0x20, 0xA9, 0x87]};
@GUID(0x9FBB3336, 0x6DA3, 0x479D, [0xB8, 0xFF, 0x67, 0xD4, 0x6E, 0x20, 0xA9, 0x87]);
interface IWMPDownloadItem2 : IWMPDownloadItem
{
    HRESULT getItemInfo(BSTR bstrItemName, BSTR* pbstrVal);
}

const GUID IID_IWMPDownloadCollection = {0x0A319C7F, 0x85F9, 0x436C, [0xB8, 0x8E, 0x82, 0xFD, 0x88, 0x00, 0x0E, 0x1C]};
@GUID(0x0A319C7F, 0x85F9, 0x436C, [0xB8, 0x8E, 0x82, 0xFD, 0x88, 0x00, 0x0E, 0x1C]);
interface IWMPDownloadCollection : IDispatch
{
    HRESULT get_id(int* plId);
    HRESULT get_count(int* plCount);
    HRESULT item(int lItem, IWMPDownloadItem2* ppDownload);
    HRESULT startDownload(BSTR bstrSourceURL, BSTR bstrType, IWMPDownloadItem2* ppDownload);
    HRESULT removeItem(int lItem);
    HRESULT Clear();
}

const GUID IID_IWMPDownloadManager = {0xE15E9AD1, 0x8F20, 0x4CC4, [0x9E, 0xC7, 0x1A, 0x32, 0x8C, 0xA8, 0x6A, 0x0D]};
@GUID(0xE15E9AD1, 0x8F20, 0x4CC4, [0x9E, 0xC7, 0x1A, 0x32, 0x8C, 0xA8, 0x6A, 0x0D]);
interface IWMPDownloadManager : IDispatch
{
    HRESULT getDownloadCollection(int lCollectionId, IWMPDownloadCollection* ppCollection);
    HRESULT createDownloadCollection(IWMPDownloadCollection* ppCollection);
}

struct WMP_WMDM_METADATA_ROUND_TRIP_PC2DEVICE
{
    uint dwChangesSinceTransactionID;
    uint dwResultSetStartingIndex;
}

struct WMP_WMDM_METADATA_ROUND_TRIP_DEVICE2PC
{
    uint dwCurrentTransactionID;
    uint dwReturnedObjectCount;
    uint dwUnretrievedObjectCount;
    uint dwDeletedObjectStartingOffset;
    uint dwFlags;
    ushort wsObjectPathnameList;
}

