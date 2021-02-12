module windows.multimedia;

public import system;
public import windows.com;
public import windows.direct2d;
public import windows.directshow;
public import windows.displaydevices;
public import windows.gdi;
public import windows.hid;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

@DllImport("WINMM.dll")
uint joyConfigChanged(uint dwFlags);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
LRESULT CloseDriver(int hDriver, LPARAM lParam1, LPARAM lParam2);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
int OpenDriver(const(wchar)* szDriverName, const(wchar)* szSectionName, LPARAM lParam2);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
LRESULT SendDriverMessage(int hDriver, uint message, LPARAM lParam1, LPARAM lParam2);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
int DrvGetModuleHandle(int hDriver);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
int GetDriverModuleHandle(int hDriver);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
LRESULT DefDriverProc(uint dwDriverIdentifier, int hdrvr, uint uMsg, LPARAM lParam1, LPARAM lParam2);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
BOOL DriverCallback(uint dwCallback, uint dwFlags, int hDevice, uint dwMsg, uint dwUser, uint dwParam1, uint dwParam2);

@DllImport("api-ms-win-mm-misc-l1-1-1.dll")
int sndOpenSound(const(wchar)* EventName, const(wchar)* AppName, int Flags, int* FileHandle);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
uint mmDrvInstall(int hDriver, const(wchar)* wszDrvEntry, DRIVERMSGPROC drvMessage, uint wFlags);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
uint mmioStringToFOURCCA(const(char)* sz, uint uFlags);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
uint mmioStringToFOURCCW(const(wchar)* sz, uint uFlags);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
LPMMIOPROC mmioInstallIOProcA(uint fccIOProc, LPMMIOPROC pIOProc, uint dwFlags);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
LPMMIOPROC mmioInstallIOProcW(uint fccIOProc, LPMMIOPROC pIOProc, uint dwFlags);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
HMMIO__* mmioOpenA(const(char)* pszFileName, MMIOINFO* pmmioinfo, uint fdwOpen);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
HMMIO__* mmioOpenW(const(wchar)* pszFileName, MMIOINFO* pmmioinfo, uint fdwOpen);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
uint mmioRenameA(const(char)* pszFileName, const(char)* pszNewFileName, MMIOINFO* pmmioinfo, uint fdwRename);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
uint mmioRenameW(const(wchar)* pszFileName, const(wchar)* pszNewFileName, MMIOINFO* pmmioinfo, uint fdwRename);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
uint mmioClose(HMMIO__* hmmio, uint fuClose);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
int mmioRead(HMMIO__* hmmio, char* pch, int cch);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
int mmioWrite(HMMIO__* hmmio, char* pch, int cch);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
int mmioSeek(HMMIO__* hmmio, int lOffset, int iOrigin);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
uint mmioGetInfo(HMMIO__* hmmio, MMIOINFO* pmmioinfo, uint fuInfo);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
uint mmioSetInfo(HMMIO__* hmmio, MMIOINFO* pmmioinfo, uint fuInfo);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
uint mmioSetBuffer(HMMIO__* hmmio, const(char)* pchBuffer, int cchBuffer, uint fuBuffer);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
uint mmioFlush(HMMIO__* hmmio, uint fuFlush);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
uint mmioAdvance(HMMIO__* hmmio, MMIOINFO* pmmioinfo, uint fuAdvance);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
LRESULT mmioSendMessage(HMMIO__* hmmio, uint uMsg, LPARAM lParam1, LPARAM lParam2);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
uint mmioDescend(HMMIO__* hmmio, MMCKINFO* pmmcki, const(MMCKINFO)* pmmckiParent, uint fuDescend);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
uint mmioAscend(HMMIO__* hmmio, MMCKINFO* pmmcki, uint fuAscend);

@DllImport("api-ms-win-mm-misc-l1-1-0.dll")
uint mmioCreateChunk(HMMIO__* hmmio, MMCKINFO* pmmcki, uint fuCreate);

@DllImport("WINMM.dll")
BOOL sndPlaySoundA(const(char)* pszSound, uint fuSound);

@DllImport("WINMM.dll")
BOOL sndPlaySoundW(const(wchar)* pszSound, uint fuSound);

@DllImport("WINMM.dll")
BOOL PlaySoundA(const(char)* pszSound, int hmod, uint fdwSound);

@DllImport("WINMM.dll")
BOOL PlaySoundW(const(wchar)* pszSound, int hmod, uint fdwSound);

@DllImport("WINMM.dll")
uint waveOutGetNumDevs();

@DllImport("WINMM.dll")
uint waveOutGetDevCapsA(uint uDeviceID, WAVEOUTCAPSA* pwoc, uint cbwoc);

@DllImport("WINMM.dll")
uint waveOutGetDevCapsW(uint uDeviceID, WAVEOUTCAPSW* pwoc, uint cbwoc);

@DllImport("WINMM.dll")
uint waveOutGetVolume(int hwo, uint* pdwVolume);

@DllImport("WINMM.dll")
uint waveOutSetVolume(int hwo, uint dwVolume);

@DllImport("WINMM.dll")
uint waveOutGetErrorTextA(uint mmrError, const(char)* pszText, uint cchText);

@DllImport("WINMM.dll")
uint waveOutGetErrorTextW(uint mmrError, const(wchar)* pszText, uint cchText);

@DllImport("WINMM.dll")
uint waveOutOpen(int* phwo, uint uDeviceID, WAVEFORMATEX* pwfx, uint dwCallback, uint dwInstance, uint fdwOpen);

@DllImport("WINMM.dll")
uint waveOutClose(int hwo);

@DllImport("WINMM.dll")
uint waveOutPrepareHeader(int hwo, char* pwh, uint cbwh);

@DllImport("WINMM.dll")
uint waveOutUnprepareHeader(int hwo, char* pwh, uint cbwh);

@DllImport("WINMM.dll")
uint waveOutWrite(int hwo, char* pwh, uint cbwh);

@DllImport("WINMM.dll")
uint waveOutPause(int hwo);

@DllImport("WINMM.dll")
uint waveOutRestart(int hwo);

@DllImport("WINMM.dll")
uint waveOutReset(int hwo);

@DllImport("WINMM.dll")
uint waveOutBreakLoop(int hwo);

@DllImport("WINMM.dll")
uint waveOutGetPosition(int hwo, char* pmmt, uint cbmmt);

@DllImport("WINMM.dll")
uint waveOutGetPitch(int hwo, uint* pdwPitch);

@DllImport("WINMM.dll")
uint waveOutSetPitch(int hwo, uint dwPitch);

@DllImport("WINMM.dll")
uint waveOutGetPlaybackRate(int hwo, uint* pdwRate);

@DllImport("WINMM.dll")
uint waveOutSetPlaybackRate(int hwo, uint dwRate);

@DllImport("WINMM.dll")
uint waveOutGetID(int hwo, uint* puDeviceID);

@DllImport("WINMM.dll")
uint waveOutMessage(int hwo, uint uMsg, uint dw1, uint dw2);

@DllImport("WINMM.dll")
uint waveInGetNumDevs();

@DllImport("WINMM.dll")
uint waveInGetDevCapsA(uint uDeviceID, char* pwic, uint cbwic);

@DllImport("WINMM.dll")
uint waveInGetDevCapsW(uint uDeviceID, char* pwic, uint cbwic);

@DllImport("WINMM.dll")
uint waveInGetErrorTextA(uint mmrError, const(char)* pszText, uint cchText);

@DllImport("WINMM.dll")
uint waveInGetErrorTextW(uint mmrError, const(wchar)* pszText, uint cchText);

@DllImport("WINMM.dll")
uint waveInOpen(int* phwi, uint uDeviceID, WAVEFORMATEX* pwfx, uint dwCallback, uint dwInstance, uint fdwOpen);

@DllImport("WINMM.dll")
uint waveInClose(int hwi);

@DllImport("WINMM.dll")
uint waveInPrepareHeader(int hwi, char* pwh, uint cbwh);

@DllImport("WINMM.dll")
uint waveInUnprepareHeader(int hwi, char* pwh, uint cbwh);

@DllImport("WINMM.dll")
uint waveInAddBuffer(int hwi, char* pwh, uint cbwh);

@DllImport("WINMM.dll")
uint waveInStart(int hwi);

@DllImport("WINMM.dll")
uint waveInStop(int hwi);

@DllImport("WINMM.dll")
uint waveInReset(int hwi);

@DllImport("WINMM.dll")
uint waveInGetPosition(int hwi, char* pmmt, uint cbmmt);

@DllImport("WINMM.dll")
uint waveInGetID(int hwi, uint* puDeviceID);

@DllImport("WINMM.dll")
uint waveInMessage(int hwi, uint uMsg, uint dw1, uint dw2);

@DllImport("WINMM.dll")
uint midiOutGetNumDevs();

@DllImport("WINMM.dll")
uint midiStreamOpen(int* phms, char* puDeviceID, uint cMidi, uint dwCallback, uint dwInstance, uint fdwOpen);

@DllImport("WINMM.dll")
uint midiStreamClose(int hms);

@DllImport("WINMM.dll")
uint midiStreamProperty(int hms, char* lppropdata, uint dwProperty);

@DllImport("WINMM.dll")
uint midiStreamPosition(int hms, char* lpmmt, uint cbmmt);

@DllImport("WINMM.dll")
uint midiStreamOut(int hms, char* pmh, uint cbmh);

@DllImport("WINMM.dll")
uint midiStreamPause(int hms);

@DllImport("WINMM.dll")
uint midiStreamRestart(int hms);

@DllImport("WINMM.dll")
uint midiStreamStop(int hms);

@DllImport("WINMM.dll")
uint midiConnect(int hmi, int hmo, void* pReserved);

@DllImport("WINMM.dll")
uint midiDisconnect(int hmi, int hmo, void* pReserved);

@DllImport("WINMM.dll")
uint midiOutGetDevCapsA(uint uDeviceID, char* pmoc, uint cbmoc);

@DllImport("WINMM.dll")
uint midiOutGetDevCapsW(uint uDeviceID, char* pmoc, uint cbmoc);

@DllImport("WINMM.dll")
uint midiOutGetVolume(int hmo, uint* pdwVolume);

@DllImport("WINMM.dll")
uint midiOutSetVolume(int hmo, uint dwVolume);

@DllImport("WINMM.dll")
uint midiOutGetErrorTextA(uint mmrError, const(char)* pszText, uint cchText);

@DllImport("WINMM.dll")
uint midiOutGetErrorTextW(uint mmrError, const(wchar)* pszText, uint cchText);

@DllImport("WINMM.dll")
uint midiOutOpen(int* phmo, uint uDeviceID, uint dwCallback, uint dwInstance, uint fdwOpen);

@DllImport("WINMM.dll")
uint midiOutClose(int hmo);

@DllImport("WINMM.dll")
uint midiOutPrepareHeader(int hmo, char* pmh, uint cbmh);

@DllImport("WINMM.dll")
uint midiOutUnprepareHeader(int hmo, char* pmh, uint cbmh);

@DllImport("WINMM.dll")
uint midiOutShortMsg(int hmo, uint dwMsg);

@DllImport("WINMM.dll")
uint midiOutLongMsg(int hmo, char* pmh, uint cbmh);

@DllImport("WINMM.dll")
uint midiOutReset(int hmo);

@DllImport("WINMM.dll")
uint midiOutCachePatches(int hmo, uint uBank, char* pwpa, uint fuCache);

@DllImport("WINMM.dll")
uint midiOutCacheDrumPatches(int hmo, uint uPatch, char* pwkya, uint fuCache);

@DllImport("WINMM.dll")
uint midiOutGetID(int hmo, uint* puDeviceID);

@DllImport("WINMM.dll")
uint midiOutMessage(int hmo, uint uMsg, uint dw1, uint dw2);

@DllImport("WINMM.dll")
uint midiInGetNumDevs();

@DllImport("WINMM.dll")
uint midiInGetDevCapsA(uint uDeviceID, char* pmic, uint cbmic);

@DllImport("WINMM.dll")
uint midiInGetDevCapsW(uint uDeviceID, char* pmic, uint cbmic);

@DllImport("WINMM.dll")
uint midiInGetErrorTextA(uint mmrError, const(char)* pszText, uint cchText);

@DllImport("WINMM.dll")
uint midiInGetErrorTextW(uint mmrError, const(wchar)* pszText, uint cchText);

@DllImport("WINMM.dll")
uint midiInOpen(int* phmi, uint uDeviceID, uint dwCallback, uint dwInstance, uint fdwOpen);

@DllImport("WINMM.dll")
uint midiInClose(int hmi);

@DllImport("WINMM.dll")
uint midiInPrepareHeader(int hmi, char* pmh, uint cbmh);

@DllImport("WINMM.dll")
uint midiInUnprepareHeader(int hmi, char* pmh, uint cbmh);

@DllImport("WINMM.dll")
uint midiInAddBuffer(int hmi, char* pmh, uint cbmh);

@DllImport("WINMM.dll")
uint midiInStart(int hmi);

@DllImport("WINMM.dll")
uint midiInStop(int hmi);

@DllImport("WINMM.dll")
uint midiInReset(int hmi);

@DllImport("WINMM.dll")
uint midiInGetID(int hmi, uint* puDeviceID);

@DllImport("WINMM.dll")
uint midiInMessage(int hmi, uint uMsg, uint dw1, uint dw2);

@DllImport("WINMM.dll")
uint auxGetNumDevs();

@DllImport("WINMM.dll")
uint auxGetDevCapsA(uint uDeviceID, char* pac, uint cbac);

@DllImport("WINMM.dll")
uint auxGetDevCapsW(uint uDeviceID, char* pac, uint cbac);

@DllImport("WINMM.dll")
uint auxSetVolume(uint uDeviceID, uint dwVolume);

@DllImport("WINMM.dll")
uint auxGetVolume(uint uDeviceID, uint* pdwVolume);

@DllImport("WINMM.dll")
uint auxOutMessage(uint uDeviceID, uint uMsg, uint dw1, uint dw2);

@DllImport("WINMM.dll")
uint mixerGetNumDevs();

@DllImport("WINMM.dll")
uint mixerGetDevCapsA(uint uMxId, char* pmxcaps, uint cbmxcaps);

@DllImport("WINMM.dll")
uint mixerGetDevCapsW(uint uMxId, char* pmxcaps, uint cbmxcaps);

@DllImport("WINMM.dll")
uint mixerOpen(int* phmx, uint uMxId, uint dwCallback, uint dwInstance, uint fdwOpen);

@DllImport("WINMM.dll")
uint mixerClose(int hmx);

@DllImport("WINMM.dll")
uint mixerMessage(int hmx, uint uMsg, uint dwParam1, uint dwParam2);

@DllImport("WINMM.dll")
uint mixerGetLineInfoA(int hmxobj, MIXERLINEA* pmxl, uint fdwInfo);

@DllImport("WINMM.dll")
uint mixerGetLineInfoW(int hmxobj, MIXERLINEW* pmxl, uint fdwInfo);

@DllImport("WINMM.dll")
uint mixerGetID(int hmxobj, uint* puMxId, uint fdwId);

@DllImport("WINMM.dll")
uint mixerGetLineControlsA(int hmxobj, MIXERLINECONTROLSA* pmxlc, uint fdwControls);

@DllImport("WINMM.dll")
uint mixerGetLineControlsW(int hmxobj, MIXERLINECONTROLSW* pmxlc, uint fdwControls);

@DllImport("WINMM.dll")
uint mixerGetControlDetailsA(int hmxobj, MIXERCONTROLDETAILS* pmxcd, uint fdwDetails);

@DllImport("WINMM.dll")
uint mixerGetControlDetailsW(int hmxobj, MIXERCONTROLDETAILS* pmxcd, uint fdwDetails);

@DllImport("WINMM.dll")
uint mixerSetControlDetails(int hmxobj, MIXERCONTROLDETAILS* pmxcd, uint fdwDetails);

@DllImport("WINMM.dll")
uint timeGetSystemTime(char* pmmt, uint cbmmt);

@DllImport("WINMM.dll")
uint timeGetTime();

@DllImport("WINMM.dll")
uint timeGetDevCaps(char* ptc, uint cbtc);

@DllImport("WINMM.dll")
uint timeBeginPeriod(uint uPeriod);

@DllImport("WINMM.dll")
uint timeEndPeriod(uint uPeriod);

@DllImport("WINMM.dll")
uint joyGetPosEx(uint uJoyID, JOYINFOEX* pji);

@DllImport("WINMM.dll")
uint joyGetNumDevs();

@DllImport("WINMM.dll")
uint joyGetDevCapsA(uint uJoyID, char* pjc, uint cbjc);

@DllImport("WINMM.dll")
uint joyGetDevCapsW(uint uJoyID, char* pjc, uint cbjc);

@DllImport("WINMM.dll")
uint joyGetPos(uint uJoyID, JOYINFO* pji);

@DllImport("WINMM.dll")
uint joyGetThreshold(uint uJoyID, uint* puThreshold);

@DllImport("WINMM.dll")
uint joyReleaseCapture(uint uJoyID);

@DllImport("WINMM.dll")
uint joySetCapture(HWND hwnd, uint uJoyID, uint uPeriod, BOOL fChanged);

@DllImport("WINMM.dll")
uint joySetThreshold(uint uJoyID, uint uThreshold);

@DllImport("MSACM32.dll")
uint acmGetVersion();

@DllImport("MSACM32.dll")
uint acmMetrics(HACMOBJ__* hao, uint uMetric, void* pMetric);

@DllImport("MSACM32.dll")
uint acmDriverEnum(ACMDRIVERENUMCB fnCallback, uint dwInstance, uint fdwEnum);

@DllImport("MSACM32.dll")
uint acmDriverID(HACMOBJ__* hao, HACMDRIVERID__** phadid, uint fdwDriverID);

@DllImport("MSACM32.dll")
uint acmDriverAddA(HACMDRIVERID__** phadid, HINSTANCE hinstModule, LPARAM lParam, uint dwPriority, uint fdwAdd);

@DllImport("MSACM32.dll")
uint acmDriverAddW(HACMDRIVERID__** phadid, HINSTANCE hinstModule, LPARAM lParam, uint dwPriority, uint fdwAdd);

@DllImport("MSACM32.dll")
uint acmDriverRemove(HACMDRIVERID__* hadid, uint fdwRemove);

@DllImport("MSACM32.dll")
uint acmDriverOpen(HACMDRIVER__** phad, HACMDRIVERID__* hadid, uint fdwOpen);

@DllImport("MSACM32.dll")
uint acmDriverClose(HACMDRIVER__* had, uint fdwClose);

@DllImport("MSACM32.dll")
LRESULT acmDriverMessage(HACMDRIVER__* had, uint uMsg, LPARAM lParam1, LPARAM lParam2);

@DllImport("MSACM32.dll")
uint acmDriverPriority(HACMDRIVERID__* hadid, uint dwPriority, uint fdwPriority);

@DllImport("MSACM32.dll")
uint acmDriverDetailsA(HACMDRIVERID__* hadid, tACMDRIVERDETAILSA* padd, uint fdwDetails);

@DllImport("MSACM32.dll")
uint acmDriverDetailsW(HACMDRIVERID__* hadid, tACMDRIVERDETAILSW* padd, uint fdwDetails);

@DllImport("MSACM32.dll")
uint acmFormatTagDetailsA(HACMDRIVER__* had, tACMFORMATTAGDETAILSA* paftd, uint fdwDetails);

@DllImport("MSACM32.dll")
uint acmFormatTagDetailsW(HACMDRIVER__* had, tACMFORMATTAGDETAILSW* paftd, uint fdwDetails);

@DllImport("MSACM32.dll")
uint acmFormatTagEnumA(HACMDRIVER__* had, tACMFORMATTAGDETAILSA* paftd, ACMFORMATTAGENUMCBA fnCallback, uint dwInstance, uint fdwEnum);

@DllImport("MSACM32.dll")
uint acmFormatTagEnumW(HACMDRIVER__* had, tACMFORMATTAGDETAILSW* paftd, ACMFORMATTAGENUMCBW fnCallback, uint dwInstance, uint fdwEnum);

@DllImport("MSACM32.dll")
uint acmFormatDetailsA(HACMDRIVER__* had, tACMFORMATDETAILSA* pafd, uint fdwDetails);

@DllImport("MSACM32.dll")
uint acmFormatDetailsW(HACMDRIVER__* had, tACMFORMATDETAILSW* pafd, uint fdwDetails);

@DllImport("MSACM32.dll")
uint acmFormatEnumA(HACMDRIVER__* had, tACMFORMATDETAILSA* pafd, ACMFORMATENUMCBA fnCallback, uint dwInstance, uint fdwEnum);

@DllImport("MSACM32.dll")
uint acmFormatEnumW(HACMDRIVER__* had, tACMFORMATDETAILSW* pafd, ACMFORMATENUMCBW fnCallback, uint dwInstance, uint fdwEnum);

@DllImport("MSACM32.dll")
uint acmFormatSuggest(HACMDRIVER__* had, WAVEFORMATEX* pwfxSrc, WAVEFORMATEX* pwfxDst, uint cbwfxDst, uint fdwSuggest);

@DllImport("MSACM32.dll")
uint acmFormatChooseA(tACMFORMATCHOOSEA* pafmtc);

@DllImport("MSACM32.dll")
uint acmFormatChooseW(tACMFORMATCHOOSEW* pafmtc);

@DllImport("MSACM32.dll")
uint acmFilterTagDetailsA(HACMDRIVER__* had, tACMFILTERTAGDETAILSA* paftd, uint fdwDetails);

@DllImport("MSACM32.dll")
uint acmFilterTagDetailsW(HACMDRIVER__* had, tACMFILTERTAGDETAILSW* paftd, uint fdwDetails);

@DllImport("MSACM32.dll")
uint acmFilterTagEnumA(HACMDRIVER__* had, tACMFILTERTAGDETAILSA* paftd, ACMFILTERTAGENUMCBA fnCallback, uint dwInstance, uint fdwEnum);

@DllImport("MSACM32.dll")
uint acmFilterTagEnumW(HACMDRIVER__* had, tACMFILTERTAGDETAILSW* paftd, ACMFILTERTAGENUMCBW fnCallback, uint dwInstance, uint fdwEnum);

@DllImport("MSACM32.dll")
uint acmFilterDetailsA(HACMDRIVER__* had, tACMFILTERDETAILSA* pafd, uint fdwDetails);

@DllImport("MSACM32.dll")
uint acmFilterDetailsW(HACMDRIVER__* had, tACMFILTERDETAILSW* pafd, uint fdwDetails);

@DllImport("MSACM32.dll")
uint acmFilterEnumA(HACMDRIVER__* had, tACMFILTERDETAILSA* pafd, ACMFILTERENUMCBA fnCallback, uint dwInstance, uint fdwEnum);

@DllImport("MSACM32.dll")
uint acmFilterEnumW(HACMDRIVER__* had, tACMFILTERDETAILSW* pafd, ACMFILTERENUMCBW fnCallback, uint dwInstance, uint fdwEnum);

@DllImport("MSACM32.dll")
uint acmFilterChooseA(tACMFILTERCHOOSEA* pafltrc);

@DllImport("MSACM32.dll")
uint acmFilterChooseW(tACMFILTERCHOOSEW* pafltrc);

@DllImport("MSACM32.dll")
uint acmStreamOpen(HACMSTREAM__** phas, HACMDRIVER__* had, WAVEFORMATEX* pwfxSrc, WAVEFORMATEX* pwfxDst, WAVEFILTER* pwfltr, uint dwCallback, uint dwInstance, uint fdwOpen);

@DllImport("MSACM32.dll")
uint acmStreamClose(HACMSTREAM__* has, uint fdwClose);

@DllImport("MSACM32.dll")
uint acmStreamSize(HACMSTREAM__* has, uint cbInput, uint* pdwOutputBytes, uint fdwSize);

@DllImport("MSACM32.dll")
uint acmStreamReset(HACMSTREAM__* has, uint fdwReset);

@DllImport("MSACM32.dll")
uint acmStreamMessage(HACMSTREAM__* has, uint uMsg, LPARAM lParam1, LPARAM lParam2);

@DllImport("MSACM32.dll")
uint acmStreamConvert(HACMSTREAM__* has, ACMSTREAMHEADER* pash, uint fdwConvert);

@DllImport("MSACM32.dll")
uint acmStreamPrepareHeader(HACMSTREAM__* has, ACMSTREAMHEADER* pash, uint fdwPrepare);

@DllImport("MSACM32.dll")
uint acmStreamUnprepareHeader(HACMSTREAM__* has, ACMSTREAMHEADER* pash, uint fdwUnprepare);

@DllImport("MSVFW32.dll")
uint VideoForWindowsVersion();

@DllImport("MSVFW32.dll")
BOOL ICInfo(uint fccType, uint fccHandler, ICINFO* lpicinfo);

@DllImport("MSVFW32.dll")
BOOL ICInstall(uint fccType, uint fccHandler, LPARAM lParam, const(char)* szDesc, uint wFlags);

@DllImport("MSVFW32.dll")
BOOL ICRemove(uint fccType, uint fccHandler, uint wFlags);

@DllImport("MSVFW32.dll")
LRESULT ICGetInfo(HIC__* hic, char* picinfo, uint cb);

@DllImport("MSVFW32.dll")
HIC__* ICOpen(uint fccType, uint fccHandler, uint wMode);

@DllImport("MSVFW32.dll")
HIC__* ICOpenFunction(uint fccType, uint fccHandler, uint wMode, FARPROC lpfnHandler);

@DllImport("MSVFW32.dll")
LRESULT ICClose(HIC__* hic);

@DllImport("MSVFW32.dll")
LRESULT ICSendMessage(HIC__* hic, uint msg, uint dw1, uint dw2);

@DllImport("MSVFW32.dll")
uint ICCompress(HIC__* hic, uint dwFlags, BITMAPINFOHEADER* lpbiOutput, char* lpData, BITMAPINFOHEADER* lpbiInput, char* lpBits, uint* lpckid, uint* lpdwFlags, int lFrameNum, uint dwFrameSize, uint dwQuality, BITMAPINFOHEADER* lpbiPrev, char* lpPrev);

@DllImport("MSVFW32.dll")
uint ICDecompress(HIC__* hic, uint dwFlags, BITMAPINFOHEADER* lpbiFormat, char* lpData, BITMAPINFOHEADER* lpbi, char* lpBits);

@DllImport("MSVFW32.dll")
uint ICDrawBegin(HIC__* hic, uint dwFlags, HPALETTE hpal, HWND hwnd, HDC hdc, int xDst, int yDst, int dxDst, int dyDst, BITMAPINFOHEADER* lpbi, int xSrc, int ySrc, int dxSrc, int dySrc, uint dwRate, uint dwScale);

@DllImport("MSVFW32.dll")
uint ICDraw(HIC__* hic, uint dwFlags, void* lpFormat, char* lpData, uint cbData, int lTime);

@DllImport("MSVFW32.dll")
HIC__* ICLocate(uint fccType, uint fccHandler, BITMAPINFOHEADER* lpbiIn, BITMAPINFOHEADER* lpbiOut, ushort wFlags);

@DllImport("MSVFW32.dll")
HIC__* ICGetDisplayFormat(HIC__* hic, BITMAPINFOHEADER* lpbiIn, BITMAPINFOHEADER* lpbiOut, int BitDepth, int dx, int dy);

@DllImport("MSVFW32.dll")
HANDLE ICImageCompress(HIC__* hic, uint uiFlags, BITMAPINFO* lpbiIn, void* lpBits, BITMAPINFO* lpbiOut, int lQuality, int* plSize);

@DllImport("MSVFW32.dll")
HANDLE ICImageDecompress(HIC__* hic, uint uiFlags, BITMAPINFO* lpbiIn, void* lpBits, BITMAPINFO* lpbiOut);

@DllImport("MSVFW32.dll")
BOOL ICCompressorChoose(HWND hwnd, uint uiFlags, void* pvIn, void* lpData, COMPVARS* pc, const(char)* lpszTitle);

@DllImport("MSVFW32.dll")
BOOL ICSeqCompressFrameStart(COMPVARS* pc, BITMAPINFO* lpbiIn);

@DllImport("MSVFW32.dll")
void ICSeqCompressFrameEnd(COMPVARS* pc);

@DllImport("MSVFW32.dll")
void* ICSeqCompressFrame(COMPVARS* pc, uint uiFlags, void* lpBits, int* pfKey, int* plSize);

@DllImport("MSVFW32.dll")
void ICCompressorFree(COMPVARS* pc);

@DllImport("MSVFW32.dll")
int DrawDibOpen();

@DllImport("MSVFW32.dll")
BOOL DrawDibClose(int hdd);

@DllImport("MSVFW32.dll")
void* DrawDibGetBuffer(int hdd, BITMAPINFOHEADER* lpbi, uint dwSize, uint dwFlags);

@DllImport("MSVFW32.dll")
HPALETTE DrawDibGetPalette(int hdd);

@DllImport("MSVFW32.dll")
BOOL DrawDibSetPalette(int hdd, HPALETTE hpal);

@DllImport("MSVFW32.dll")
BOOL DrawDibChangePalette(int hdd, int iStart, int iLen, char* lppe);

@DllImport("MSVFW32.dll")
uint DrawDibRealize(int hdd, HDC hdc, BOOL fBackground);

@DllImport("MSVFW32.dll")
BOOL DrawDibStart(int hdd, uint rate);

@DllImport("MSVFW32.dll")
BOOL DrawDibStop(int hdd);

@DllImport("MSVFW32.dll")
BOOL DrawDibBegin(int hdd, HDC hdc, int dxDst, int dyDst, BITMAPINFOHEADER* lpbi, int dxSrc, int dySrc, uint wFlags);

@DllImport("MSVFW32.dll")
BOOL DrawDibDraw(int hdd, HDC hdc, int xDst, int yDst, int dxDst, int dyDst, BITMAPINFOHEADER* lpbi, void* lpBits, int xSrc, int ySrc, int dxSrc, int dySrc, uint wFlags);

@DllImport("MSVFW32.dll")
BOOL DrawDibEnd(int hdd);

@DllImport("MSVFW32.dll")
BOOL DrawDibTime(int hdd, DRAWDIBTIME* lpddtime);

@DllImport("MSVFW32.dll")
LRESULT DrawDibProfileDisplay(BITMAPINFOHEADER* lpbi);

@DllImport("AVIFIL32.dll")
void AVIFileInit();

@DllImport("AVIFIL32.dll")
void AVIFileExit();

@DllImport("AVIFIL32.dll")
uint AVIFileAddRef(IAVIFile pfile);

@DllImport("AVIFIL32.dll")
uint AVIFileRelease(IAVIFile pfile);

@DllImport("AVIFIL32.dll")
HRESULT AVIFileOpenA(IAVIFile* ppfile, const(char)* szFile, uint uMode, Guid* lpHandler);

@DllImport("AVIFIL32.dll")
HRESULT AVIFileOpenW(IAVIFile* ppfile, const(wchar)* szFile, uint uMode, Guid* lpHandler);

@DllImport("AVIFIL32.dll")
HRESULT AVIFileInfoW(IAVIFile pfile, char* pfi, int lSize);

@DllImport("AVIFIL32.dll")
HRESULT AVIFileInfoA(IAVIFile pfile, char* pfi, int lSize);

@DllImport("AVIFIL32.dll")
HRESULT AVIFileGetStream(IAVIFile pfile, IAVIStream* ppavi, uint fccType, int lParam);

@DllImport("AVIFIL32.dll")
HRESULT AVIFileCreateStreamW(IAVIFile pfile, IAVIStream* ppavi, AVISTREAMINFOW* psi);

@DllImport("AVIFIL32.dll")
HRESULT AVIFileCreateStreamA(IAVIFile pfile, IAVIStream* ppavi, AVISTREAMINFOA* psi);

@DllImport("AVIFIL32.dll")
HRESULT AVIFileWriteData(IAVIFile pfile, uint ckid, char* lpData, int cbData);

@DllImport("AVIFIL32.dll")
HRESULT AVIFileReadData(IAVIFile pfile, uint ckid, char* lpData, int* lpcbData);

@DllImport("AVIFIL32.dll")
HRESULT AVIFileEndRecord(IAVIFile pfile);

@DllImport("AVIFIL32.dll")
uint AVIStreamAddRef(IAVIStream pavi);

@DllImport("AVIFIL32.dll")
uint AVIStreamRelease(IAVIStream pavi);

@DllImport("AVIFIL32.dll")
HRESULT AVIStreamInfoW(IAVIStream pavi, char* psi, int lSize);

@DllImport("AVIFIL32.dll")
HRESULT AVIStreamInfoA(IAVIStream pavi, char* psi, int lSize);

@DllImport("AVIFIL32.dll")
int AVIStreamFindSample(IAVIStream pavi, int lPos, int lFlags);

@DllImport("AVIFIL32.dll")
HRESULT AVIStreamReadFormat(IAVIStream pavi, int lPos, char* lpFormat, int* lpcbFormat);

@DllImport("AVIFIL32.dll")
HRESULT AVIStreamSetFormat(IAVIStream pavi, int lPos, char* lpFormat, int cbFormat);

@DllImport("AVIFIL32.dll")
HRESULT AVIStreamReadData(IAVIStream pavi, uint fcc, char* lp, int* lpcb);

@DllImport("AVIFIL32.dll")
HRESULT AVIStreamWriteData(IAVIStream pavi, uint fcc, char* lp, int cb);

@DllImport("AVIFIL32.dll")
HRESULT AVIStreamRead(IAVIStream pavi, int lStart, int lSamples, char* lpBuffer, int cbBuffer, int* plBytes, int* plSamples);

@DllImport("AVIFIL32.dll")
HRESULT AVIStreamWrite(IAVIStream pavi, int lStart, int lSamples, char* lpBuffer, int cbBuffer, uint dwFlags, int* plSampWritten, int* plBytesWritten);

@DllImport("AVIFIL32.dll")
int AVIStreamStart(IAVIStream pavi);

@DllImport("AVIFIL32.dll")
int AVIStreamLength(IAVIStream pavi);

@DllImport("AVIFIL32.dll")
int AVIStreamTimeToSample(IAVIStream pavi, int lTime);

@DllImport("AVIFIL32.dll")
int AVIStreamSampleToTime(IAVIStream pavi, int lSample);

@DllImport("AVIFIL32.dll")
HRESULT AVIStreamBeginStreaming(IAVIStream pavi, int lStart, int lEnd, int lRate);

@DllImport("AVIFIL32.dll")
HRESULT AVIStreamEndStreaming(IAVIStream pavi);

@DllImport("AVIFIL32.dll")
IGetFrame AVIStreamGetFrameOpen(IAVIStream pavi, BITMAPINFOHEADER* lpbiWanted);

@DllImport("AVIFIL32.dll")
void* AVIStreamGetFrame(IGetFrame pg, int lPos);

@DllImport("AVIFIL32.dll")
HRESULT AVIStreamGetFrameClose(IGetFrame pg);

@DllImport("AVIFIL32.dll")
HRESULT AVIStreamOpenFromFileA(IAVIStream* ppavi, const(char)* szFile, uint fccType, int lParam, uint mode, Guid* pclsidHandler);

@DllImport("AVIFIL32.dll")
HRESULT AVIStreamOpenFromFileW(IAVIStream* ppavi, const(wchar)* szFile, uint fccType, int lParam, uint mode, Guid* pclsidHandler);

@DllImport("AVIFIL32.dll")
HRESULT AVIStreamCreate(IAVIStream* ppavi, int lParam1, int lParam2, Guid* pclsidHandler);

@DllImport("AVIFIL32.dll")
HRESULT AVIMakeCompressedStream(IAVIStream* ppsCompressed, IAVIStream ppsSource, AVICOMPRESSOPTIONS* lpOptions, Guid* pclsidHandler);

@DllImport("AVIFIL32.dll")
HRESULT AVISaveA(const(char)* szFile, Guid* pclsidHandler, AVISAVECALLBACK lpfnCallback, int nStreams, IAVIStream pfile, AVICOMPRESSOPTIONS* lpOptions);

@DllImport("AVIFIL32.dll")
HRESULT AVISaveVA(const(char)* szFile, Guid* pclsidHandler, AVISAVECALLBACK lpfnCallback, int nStreams, char* ppavi, char* plpOptions);

@DllImport("AVIFIL32.dll")
HRESULT AVISaveW(const(wchar)* szFile, Guid* pclsidHandler, AVISAVECALLBACK lpfnCallback, int nStreams, IAVIStream pfile, AVICOMPRESSOPTIONS* lpOptions);

@DllImport("AVIFIL32.dll")
HRESULT AVISaveVW(const(wchar)* szFile, Guid* pclsidHandler, AVISAVECALLBACK lpfnCallback, int nStreams, char* ppavi, char* plpOptions);

@DllImport("AVIFIL32.dll")
int AVISaveOptions(HWND hwnd, uint uiFlags, int nStreams, char* ppavi, char* plpOptions);

@DllImport("AVIFIL32.dll")
HRESULT AVISaveOptionsFree(int nStreams, char* plpOptions);

@DllImport("AVIFIL32.dll")
HRESULT AVIBuildFilterW(const(wchar)* lpszFilter, int cbFilter, BOOL fSaving);

@DllImport("AVIFIL32.dll")
HRESULT AVIBuildFilterA(const(char)* lpszFilter, int cbFilter, BOOL fSaving);

@DllImport("AVIFIL32.dll")
HRESULT AVIMakeFileFromStreams(IAVIFile* ppfile, int nStreams, char* papStreams);

@DllImport("AVIFIL32.dll")
HRESULT AVIMakeStreamFromClipboard(uint cfFormat, HANDLE hGlobal, IAVIStream* ppstream);

@DllImport("AVIFIL32.dll")
HRESULT AVIPutFileOnClipboard(IAVIFile pf);

@DllImport("AVIFIL32.dll")
HRESULT AVIGetFromClipboard(IAVIFile* lppf);

@DllImport("AVIFIL32.dll")
HRESULT AVIClearClipboard();

@DllImport("AVIFIL32.dll")
HRESULT CreateEditableStream(IAVIStream* ppsEditable, IAVIStream psSource);

@DllImport("AVIFIL32.dll")
HRESULT EditStreamCut(IAVIStream pavi, int* plStart, int* plLength, IAVIStream* ppResult);

@DllImport("AVIFIL32.dll")
HRESULT EditStreamCopy(IAVIStream pavi, int* plStart, int* plLength, IAVIStream* ppResult);

@DllImport("AVIFIL32.dll")
HRESULT EditStreamPaste(IAVIStream pavi, int* plPos, int* plLength, IAVIStream pstream, int lStart, int lEnd);

@DllImport("AVIFIL32.dll")
HRESULT EditStreamClone(IAVIStream pavi, IAVIStream* ppResult);

@DllImport("AVIFIL32.dll")
HRESULT EditStreamSetNameA(IAVIStream pavi, const(char)* lpszName);

@DllImport("AVIFIL32.dll")
HRESULT EditStreamSetNameW(IAVIStream pavi, const(wchar)* lpszName);

@DllImport("AVIFIL32.dll")
HRESULT EditStreamSetInfoW(IAVIStream pavi, char* lpInfo, int cbInfo);

@DllImport("AVIFIL32.dll")
HRESULT EditStreamSetInfoA(IAVIStream pavi, char* lpInfo, int cbInfo);

@DllImport("MSVFW32.dll")
HWND MCIWndCreateA(HWND hwndParent, HINSTANCE hInstance, uint dwStyle, const(char)* szFile);

@DllImport("MSVFW32.dll")
HWND MCIWndCreateW(HWND hwndParent, HINSTANCE hInstance, uint dwStyle, const(wchar)* szFile);

@DllImport("MSVFW32.dll")
BOOL MCIWndRegisterClass();

@DllImport("AVICAP32.dll")
HWND capCreateCaptureWindowA(const(char)* lpszWindowName, uint dwStyle, int x, int y, int nWidth, int nHeight, HWND hwndParent, int nID);

@DllImport("AVICAP32.dll")
BOOL capGetDriverDescriptionA(uint wDriverIndex, const(char)* lpszName, int cbName, const(char)* lpszVer, int cbVer);

@DllImport("AVICAP32.dll")
HWND capCreateCaptureWindowW(const(wchar)* lpszWindowName, uint dwStyle, int x, int y, int nWidth, int nHeight, HWND hwndParent, int nID);

@DllImport("AVICAP32.dll")
BOOL capGetDriverDescriptionW(uint wDriverIndex, const(wchar)* lpszName, int cbName, const(wchar)* lpszVer, int cbVer);

@DllImport("MSVFW32.dll")
BOOL GetOpenFileNamePreviewA(OPENFILENAMEA* lpofn);

@DllImport("MSVFW32.dll")
BOOL GetSaveFileNamePreviewA(OPENFILENAMEA* lpofn);

@DllImport("MSVFW32.dll")
BOOL GetOpenFileNamePreviewW(OPENFILENAMEW* lpofn);

@DllImport("MSVFW32.dll")
BOOL GetSaveFileNamePreviewW(OPENFILENAMEW* lpofn);

@DllImport("WINMM.dll")
uint mmTaskCreate(LPTASKCALLBACK lpfn, HANDLE* lph, uint dwInst);

@DllImport("WINMM.dll")
void mmTaskBlock(uint h);

@DllImport("WINMM.dll")
BOOL mmTaskSignal(uint h);

@DllImport("WINMM.dll")
void mmTaskYield();

@DllImport("WINMM.dll")
uint mmGetCurrentTask();

struct MMTIME
{
    uint wType;
    _u_e__Union u;
}

struct HDRVR__
{
    int unused;
}

alias DRVCALLBACK = extern(Windows) void function(int hdrvr, uint uMsg, uint dwUser, uint dw1, uint dw2);
alias LPDRVCALLBACK = extern(Windows) void function();
alias PDRVCALLBACK = extern(Windows) void function();
struct DRVCONFIGINFOEX
{
    uint dwDCISize;
    const(wchar)* lpszDCISectionName;
    const(wchar)* lpszDCIAliasName;
    uint dnDevNode;
}

struct DRVCONFIGINFO
{
    uint dwDCISize;
    const(wchar)* lpszDCISectionName;
    const(wchar)* lpszDCIAliasName;
}

alias DRIVERPROC = extern(Windows) LRESULT function(uint param0, int param1, uint param2, LPARAM param3, LPARAM param4);
alias DRIVERMSGPROC = extern(Windows) uint function(uint param0, uint param1, uint param2, uint param3, uint param4);
struct HMMIO__
{
    int unused;
}

alias MMIOPROC = extern(Windows) LRESULT function(const(char)* lpmmioinfo, uint uMsg, LPARAM lParam1, LPARAM lParam2);
alias LPMMIOPROC = extern(Windows) LRESULT function();
struct MMIOINFO
{
    uint dwFlags;
    uint fccIOProc;
    LPMMIOPROC pIOProc;
    uint wErrorRet;
    int htask;
    int cchBuffer;
    byte* pchBuffer;
    byte* pchNext;
    byte* pchEndRead;
    byte* pchEndWrite;
    int lBufOffset;
    int lDiskOffset;
    uint adwInfo;
    uint dwReserved1;
    uint dwReserved2;
    HMMIO__* hmmio;
}

struct MMCKINFO
{
    uint ckid;
    uint cksize;
    uint fccType;
    uint dwDataOffset;
    uint dwFlags;
}

struct HWAVE__
{
    int unused;
}

struct HWAVEIN__
{
    int unused;
}

struct HWAVEOUT__
{
    int unused;
}

alias WAVECALLBACK = extern(Windows) void function();
alias LPWAVECALLBACK = extern(Windows) void function();
struct WAVEHDR
{
    const(char)* lpData;
    uint dwBufferLength;
    uint dwBytesRecorded;
    uint dwUser;
    uint dwFlags;
    uint dwLoops;
    WAVEHDR* lpNext;
    uint reserved;
}

struct WAVEOUTCAPSA
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    byte szPname;
    uint dwFormats;
    ushort wChannels;
    ushort wReserved1;
    uint dwSupport;
}

struct WAVEOUTCAPSW
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    ushort szPname;
    uint dwFormats;
    ushort wChannels;
    ushort wReserved1;
    uint dwSupport;
}

struct WAVEOUTCAPS2A
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    byte szPname;
    uint dwFormats;
    ushort wChannels;
    ushort wReserved1;
    uint dwSupport;
    Guid ManufacturerGuid;
    Guid ProductGuid;
    Guid NameGuid;
}

struct WAVEOUTCAPS2W
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    ushort szPname;
    uint dwFormats;
    ushort wChannels;
    ushort wReserved1;
    uint dwSupport;
    Guid ManufacturerGuid;
    Guid ProductGuid;
    Guid NameGuid;
}

struct WAVEINCAPSA
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    byte szPname;
    uint dwFormats;
    ushort wChannels;
    ushort wReserved1;
}

struct WAVEINCAPSW
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    ushort szPname;
    uint dwFormats;
    ushort wChannels;
    ushort wReserved1;
}

struct WAVEINCAPS2A
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    byte szPname;
    uint dwFormats;
    ushort wChannels;
    ushort wReserved1;
    Guid ManufacturerGuid;
    Guid ProductGuid;
    Guid NameGuid;
}

struct WAVEINCAPS2W
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    ushort szPname;
    uint dwFormats;
    ushort wChannels;
    ushort wReserved1;
    Guid ManufacturerGuid;
    Guid ProductGuid;
    Guid NameGuid;
}

struct WAVEFORMAT
{
    ushort wFormatTag;
    ushort nChannels;
    uint nSamplesPerSec;
    uint nAvgBytesPerSec;
    ushort nBlockAlign;
}

struct PCMWAVEFORMAT
{
    WAVEFORMAT wf;
    ushort wBitsPerSample;
}

struct WAVEFORMATEX
{
    ushort wFormatTag;
    ushort nChannels;
    uint nSamplesPerSec;
    uint nAvgBytesPerSec;
    ushort nBlockAlign;
    ushort wBitsPerSample;
    ushort cbSize;
}

struct HMIDI__
{
    int unused;
}

struct HMIDIIN__
{
    int unused;
}

struct HMIDIOUT__
{
    int unused;
}

struct HMIDISTRM__
{
    int unused;
}

alias MIDICALLBACK = extern(Windows) void function();
alias LPMIDICALLBACK = extern(Windows) void function();
struct MIDIOUTCAPSA
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    byte szPname;
    ushort wTechnology;
    ushort wVoices;
    ushort wNotes;
    ushort wChannelMask;
    uint dwSupport;
}

struct MIDIOUTCAPSW
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    ushort szPname;
    ushort wTechnology;
    ushort wVoices;
    ushort wNotes;
    ushort wChannelMask;
    uint dwSupport;
}

struct MIDIOUTCAPS2A
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    byte szPname;
    ushort wTechnology;
    ushort wVoices;
    ushort wNotes;
    ushort wChannelMask;
    uint dwSupport;
    Guid ManufacturerGuid;
    Guid ProductGuid;
    Guid NameGuid;
}

struct MIDIOUTCAPS2W
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    ushort szPname;
    ushort wTechnology;
    ushort wVoices;
    ushort wNotes;
    ushort wChannelMask;
    uint dwSupport;
    Guid ManufacturerGuid;
    Guid ProductGuid;
    Guid NameGuid;
}

struct MIDIINCAPSA
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    byte szPname;
    uint dwSupport;
}

struct MIDIINCAPSW
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    ushort szPname;
    uint dwSupport;
}

struct MIDIINCAPS2A
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    byte szPname;
    uint dwSupport;
    Guid ManufacturerGuid;
    Guid ProductGuid;
    Guid NameGuid;
}

struct MIDIINCAPS2W
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    ushort szPname;
    uint dwSupport;
    Guid ManufacturerGuid;
    Guid ProductGuid;
    Guid NameGuid;
}

struct MIDIHDR
{
    const(char)* lpData;
    uint dwBufferLength;
    uint dwBytesRecorded;
    uint dwUser;
    uint dwFlags;
    MIDIHDR* lpNext;
    uint reserved;
    uint dwOffset;
    uint dwReserved;
}

struct MIDIEVENT
{
    uint dwDeltaTime;
    uint dwStreamID;
    uint dwEvent;
    uint dwParms;
}

struct MIDISTRMBUFFVER
{
    uint dwVersion;
    uint dwMid;
    uint dwOEMVersion;
}

struct MIDIPROPTIMEDIV
{
    uint cbStruct;
    uint dwTimeDiv;
}

struct MIDIPROPTEMPO
{
    uint cbStruct;
    uint dwTempo;
}

struct AUXCAPSA
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    byte szPname;
    ushort wTechnology;
    ushort wReserved1;
    uint dwSupport;
}

struct AUXCAPSW
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    ushort szPname;
    ushort wTechnology;
    ushort wReserved1;
    uint dwSupport;
}

struct AUXCAPS2A
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    byte szPname;
    ushort wTechnology;
    ushort wReserved1;
    uint dwSupport;
    Guid ManufacturerGuid;
    Guid ProductGuid;
    Guid NameGuid;
}

struct AUXCAPS2W
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    ushort szPname;
    ushort wTechnology;
    ushort wReserved1;
    uint dwSupport;
    Guid ManufacturerGuid;
    Guid ProductGuid;
    Guid NameGuid;
}

struct HMIXEROBJ__
{
    int unused;
}

struct HMIXER__
{
    int unused;
}

struct MIXERCAPSA
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    byte szPname;
    uint fdwSupport;
    uint cDestinations;
}

struct MIXERCAPSW
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    ushort szPname;
    uint fdwSupport;
    uint cDestinations;
}

struct MIXERCAPS2A
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    byte szPname;
    uint fdwSupport;
    uint cDestinations;
    Guid ManufacturerGuid;
    Guid ProductGuid;
    Guid NameGuid;
}

struct MIXERCAPS2W
{
    ushort wMid;
    ushort wPid;
    uint vDriverVersion;
    ushort szPname;
    uint fdwSupport;
    uint cDestinations;
    Guid ManufacturerGuid;
    Guid ProductGuid;
    Guid NameGuid;
}

struct MIXERLINEA
{
    uint cbStruct;
    uint dwDestination;
    uint dwSource;
    uint dwLineID;
    uint fdwLine;
    uint dwUser;
    uint dwComponentType;
    uint cChannels;
    uint cConnections;
    uint cControls;
    byte szShortName;
    byte szName;
    _Target_e__Struct Target;
}

struct MIXERLINEW
{
    uint cbStruct;
    uint dwDestination;
    uint dwSource;
    uint dwLineID;
    uint fdwLine;
    uint dwUser;
    uint dwComponentType;
    uint cChannels;
    uint cConnections;
    uint cControls;
    ushort szShortName;
    ushort szName;
    _Target_e__Struct Target;
}

struct MIXERCONTROLA
{
    uint cbStruct;
    uint dwControlID;
    uint dwControlType;
    uint fdwControl;
    uint cMultipleItems;
    byte szShortName;
    byte szName;
    _Bounds_e__Union Bounds;
    _Metrics_e__Union Metrics;
}

struct MIXERCONTROLW
{
    uint cbStruct;
    uint dwControlID;
    uint dwControlType;
    uint fdwControl;
    uint cMultipleItems;
    ushort szShortName;
    ushort szName;
    _Bounds_e__Union Bounds;
    _Metrics_e__Union Metrics;
}

struct MIXERLINECONTROLSA
{
    uint cbStruct;
    uint dwLineID;
    _Anonymous_e__Union Anonymous;
    uint cControls;
    uint cbmxctrl;
    MIXERCONTROLA* pamxctrl;
}

struct MIXERLINECONTROLSW
{
    uint cbStruct;
    uint dwLineID;
    _Anonymous_e__Union Anonymous;
    uint cControls;
    uint cbmxctrl;
    MIXERCONTROLW* pamxctrl;
}

struct MIXERCONTROLDETAILS
{
    uint cbStruct;
    uint dwControlID;
    uint cChannels;
    _Anonymous_e__Union Anonymous;
    uint cbDetails;
    void* paDetails;
}

struct MIXERCONTROLDETAILS_LISTTEXTA
{
    uint dwParam1;
    uint dwParam2;
    byte szName;
}

struct MIXERCONTROLDETAILS_LISTTEXTW
{
    uint dwParam1;
    uint dwParam2;
    ushort szName;
}

struct MIXERCONTROLDETAILS_BOOLEAN
{
    int fValue;
}

struct MIXERCONTROLDETAILS_SIGNED
{
    int lValue;
}

struct MIXERCONTROLDETAILS_UNSIGNED
{
    uint dwValue;
}

struct TIMECAPS
{
    uint wPeriodMin;
    uint wPeriodMax;
}

struct JOYCAPSA
{
    ushort wMid;
    ushort wPid;
    byte szPname;
    uint wXmin;
    uint wXmax;
    uint wYmin;
    uint wYmax;
    uint wZmin;
    uint wZmax;
    uint wNumButtons;
    uint wPeriodMin;
    uint wPeriodMax;
    uint wRmin;
    uint wRmax;
    uint wUmin;
    uint wUmax;
    uint wVmin;
    uint wVmax;
    uint wCaps;
    uint wMaxAxes;
    uint wNumAxes;
    uint wMaxButtons;
    byte szRegKey;
    byte szOEMVxD;
}

struct JOYCAPSW
{
    ushort wMid;
    ushort wPid;
    ushort szPname;
    uint wXmin;
    uint wXmax;
    uint wYmin;
    uint wYmax;
    uint wZmin;
    uint wZmax;
    uint wNumButtons;
    uint wPeriodMin;
    uint wPeriodMax;
    uint wRmin;
    uint wRmax;
    uint wUmin;
    uint wUmax;
    uint wVmin;
    uint wVmax;
    uint wCaps;
    uint wMaxAxes;
    uint wNumAxes;
    uint wMaxButtons;
    ushort szRegKey;
    ushort szOEMVxD;
}

struct JOYCAPS2A
{
    ushort wMid;
    ushort wPid;
    byte szPname;
    uint wXmin;
    uint wXmax;
    uint wYmin;
    uint wYmax;
    uint wZmin;
    uint wZmax;
    uint wNumButtons;
    uint wPeriodMin;
    uint wPeriodMax;
    uint wRmin;
    uint wRmax;
    uint wUmin;
    uint wUmax;
    uint wVmin;
    uint wVmax;
    uint wCaps;
    uint wMaxAxes;
    uint wNumAxes;
    uint wMaxButtons;
    byte szRegKey;
    byte szOEMVxD;
    Guid ManufacturerGuid;
    Guid ProductGuid;
    Guid NameGuid;
}

struct JOYCAPS2W
{
    ushort wMid;
    ushort wPid;
    ushort szPname;
    uint wXmin;
    uint wXmax;
    uint wYmin;
    uint wYmax;
    uint wZmin;
    uint wZmax;
    uint wNumButtons;
    uint wPeriodMin;
    uint wPeriodMax;
    uint wRmin;
    uint wRmax;
    uint wUmin;
    uint wUmax;
    uint wVmin;
    uint wVmax;
    uint wCaps;
    uint wMaxAxes;
    uint wNumAxes;
    uint wMaxButtons;
    ushort szRegKey;
    ushort szOEMVxD;
    Guid ManufacturerGuid;
    Guid ProductGuid;
    Guid NameGuid;
}

struct JOYINFO
{
    uint wXpos;
    uint wYpos;
    uint wZpos;
    uint wButtons;
}

struct JOYINFOEX
{
    uint dwSize;
    uint dwFlags;
    uint dwXpos;
    uint dwYpos;
    uint dwZpos;
    uint dwRpos;
    uint dwUpos;
    uint dwVpos;
    uint dwButtons;
    uint dwButtonNumber;
    uint dwPOV;
    uint dwReserved1;
    uint dwReserved2;
}

const GUID CLSID_KSDATAFORMAT_SUBTYPE_PCM = {0x00000001, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000001, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_PCM;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_IEEE_FLOAT = {0x00000003, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000003, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_IEEE_FLOAT;

const GUID CLSID_KSDATAFORMAT_SUBTYPE_WAVEFORMATEX = {0x00000000, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]};
@GUID(0x00000000, 0x0000, 0x0010, [0x80, 0x00, 0x00, 0xAA, 0x00, 0x38, 0x9B, 0x71]);
struct KSDATAFORMAT_SUBTYPE_WAVEFORMATEX;

struct WAVEFORMATEXTENSIBLE
{
    WAVEFORMATEX Format;
    _Samples_e__Union Samples;
    uint dwChannelMask;
    Guid SubFormat;
}

struct ADPCMCOEFSET
{
    short iCoef1;
    short iCoef2;
}

struct ADPCMWAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wSamplesPerBlock;
    ushort wNumCoef;
    ADPCMCOEFSET aCoef;
}

struct DRMWAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wReserved;
    uint ulContentId;
    WAVEFORMATEX wfxSecure;
}

struct DVIADPCMWAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wSamplesPerBlock;
}

struct IMAADPCMWAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wSamplesPerBlock;
}

struct MEDIASPACEADPCMWAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wRevision;
}

struct SIERRAADPCMWAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wRevision;
}

struct G723_ADPCMWAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort cbExtraSize;
    ushort nAuxBlockSize;
}

struct DIGISTDWAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct DIGIFIXWAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct DIALOGICOKIADPCMWAVEFORMAT
{
    WAVEFORMATEX ewf;
}

struct YAMAHA_ADPCMWAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct SONARCWAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wCompType;
}

struct TRUESPEECHWAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wRevision;
    ushort nSamplesPerBlock;
    ubyte abReserved;
}

struct ECHOSC1WAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct AUDIOFILE_AF36WAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct APTXWAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct AUDIOFILE_AF10WAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct DOLBYAC2WAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort nAuxBitsCode;
}

struct GSM610WAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wSamplesPerBlock;
}

struct ADPCMEWAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wSamplesPerBlock;
}

struct CONTRESVQLPCWAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wSamplesPerBlock;
}

struct DIGIREALWAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wSamplesPerBlock;
}

struct DIGIADPCMWAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wSamplesPerBlock;
}

struct CONTRESCR10WAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wSamplesPerBlock;
}

struct NMS_VBXADPCMWAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wSamplesPerBlock;
}

struct G721_ADPCMWAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort nAuxBlockSize;
}

struct MSAUDIO1WAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wSamplesPerBlock;
    ushort wEncodeOptions;
}

struct WMAUDIO2WAVEFORMAT
{
    WAVEFORMATEX wfx;
    uint dwSamplesPerBlock;
    ushort wEncodeOptions;
    uint dwSuperBlockAlign;
}

struct WMAUDIO3WAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wValidBitsPerSample;
    uint dwChannelMask;
    uint dwReserved1;
    uint dwReserved2;
    ushort wEncodeOptions;
    ushort wReserved3;
}

struct CREATIVEADPCMWAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wRevision;
}

struct CREATIVEFASTSPEECH8WAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wRevision;
}

struct CREATIVEFASTSPEECH10WAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wRevision;
}

struct FMTOWNS_SND_WAVEFORMAT
{
    WAVEFORMATEX wfx;
    ushort wRevision;
}

struct OLIGSMWAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct OLIADPCMWAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct OLICELPWAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct OLISBCWAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct OLIOPRWAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct CSIMAADPCMWAVEFORMAT
{
    WAVEFORMATEX wfx;
}

struct WAVEFILTER
{
    uint cbStruct;
    uint dwFilterTag;
    uint fdwFilter;
    uint dwReserved;
}

struct VOLUMEWAVEFILTER
{
    WAVEFILTER wfltr;
    uint dwVolume;
}

struct ECHOWAVEFILTER
{
    WAVEFILTER wfltr;
    uint dwVolume;
    uint dwDelay;
}

struct s_RIFFWAVE_inst
{
    ubyte bUnshiftedNote;
    byte chFineTune;
    byte chGain;
    ubyte bLowNote;
    ubyte bHighNote;
    ubyte bLowVelocity;
    ubyte bHighVelocity;
}

struct tag_s_RIFFWAVE_INST
{
}

struct EXBMINFOHEADER
{
    BITMAPINFOHEADER bmi;
    uint biExtDataOffset;
}

struct JPEGINFOHEADER
{
    uint JPEGSize;
    uint JPEGProcess;
    uint JPEGColorSpaceID;
    uint JPEGBitsPerSample;
    uint JPEGHSubSampling;
    uint JPEGVSubSampling;
}

struct MCI_DGV_RECT_PARMS
{
    uint dwCallback;
    RECT rc;
}

struct MCI_DGV_CAPTURE_PARMSA
{
    uint dwCallback;
    const(char)* lpstrFileName;
    RECT rc;
}

struct MCI_DGV_CAPTURE_PARMSW
{
    uint dwCallback;
    const(wchar)* lpstrFileName;
    RECT rc;
}

struct MCI_DGV_COPY_PARMS
{
    uint dwCallback;
    uint dwFrom;
    uint dwTo;
    RECT rc;
    uint dwAudioStream;
    uint dwVideoStream;
}

struct MCI_DGV_CUE_PARMS
{
    uint dwCallback;
    uint dwTo;
}

struct MCI_DGV_CUT_PARMS
{
    uint dwCallback;
    uint dwFrom;
    uint dwTo;
    RECT rc;
    uint dwAudioStream;
    uint dwVideoStream;
}

struct MCI_DGV_DELETE_PARMS
{
    uint dwCallback;
    uint dwFrom;
    uint dwTo;
    RECT rc;
    uint dwAudioStream;
    uint dwVideoStream;
}

struct MCI_DGV_INFO_PARMSA
{
    uint dwCallback;
    const(char)* lpstrReturn;
    uint dwRetSize;
    uint dwItem;
}

struct MCI_DGV_INFO_PARMSW
{
    uint dwCallback;
    const(wchar)* lpstrReturn;
    uint dwRetSize;
    uint dwItem;
}

struct MCI_DGV_LIST_PARMSA
{
    uint dwCallback;
    const(char)* lpstrReturn;
    uint dwLength;
    uint dwNumber;
    uint dwItem;
    const(char)* lpstrAlgorithm;
}

struct MCI_DGV_LIST_PARMSW
{
    uint dwCallback;
    const(wchar)* lpstrReturn;
    uint dwLength;
    uint dwNumber;
    uint dwItem;
    const(wchar)* lpstrAlgorithm;
}

struct MCI_DGV_MONITOR_PARMS
{
    uint dwCallback;
    uint dwSource;
    uint dwMethod;
}

struct MCI_DGV_OPEN_PARMSA
{
    uint dwCallback;
    uint wDeviceID;
    const(char)* lpstrDeviceType;
    const(char)* lpstrElementName;
    const(char)* lpstrAlias;
    uint dwStyle;
    HWND hWndParent;
}

struct MCI_DGV_OPEN_PARMSW
{
    uint dwCallback;
    uint wDeviceID;
    const(wchar)* lpstrDeviceType;
    const(wchar)* lpstrElementName;
    const(wchar)* lpstrAlias;
    uint dwStyle;
    HWND hWndParent;
}

struct MCI_DGV_PASTE_PARMS
{
    uint dwCallback;
    uint dwTo;
    RECT rc;
    uint dwAudioStream;
    uint dwVideoStream;
}

struct MCI_DGV_QUALITY_PARMSA
{
    uint dwCallback;
    uint dwItem;
    const(char)* lpstrName;
    uint lpstrAlgorithm;
    uint dwHandle;
}

struct MCI_DGV_QUALITY_PARMSW
{
    uint dwCallback;
    uint dwItem;
    const(wchar)* lpstrName;
    uint lpstrAlgorithm;
    uint dwHandle;
}

struct MCI_DGV_RECORD_PARMS
{
    uint dwCallback;
    uint dwFrom;
    uint dwTo;
    RECT rc;
    uint dwAudioStream;
    uint dwVideoStream;
}

struct MCI_DGV_RESERVE_PARMSA
{
    uint dwCallback;
    const(char)* lpstrPath;
    uint dwSize;
}

struct MCI_DGV_RESERVE_PARMSW
{
    uint dwCallback;
    const(wchar)* lpstrPath;
    uint dwSize;
}

struct MCI_DGV_RESTORE_PARMSA
{
    uint dwCallback;
    const(char)* lpstrFileName;
    RECT rc;
}

struct MCI_DGV_RESTORE_PARMSW
{
    uint dwCallback;
    const(wchar)* lpstrFileName;
    RECT rc;
}

struct MCI_DGV_SAVE_PARMSA
{
    uint dwCallback;
    const(char)* lpstrFileName;
    RECT rc;
}

struct MCI_DGV_SAVE_PARMSW
{
    uint dwCallback;
    const(wchar)* lpstrFileName;
    RECT rc;
}

struct MCI_DGV_SET_PARMS
{
    uint dwCallback;
    uint dwTimeFormat;
    uint dwAudio;
    uint dwFileFormat;
    uint dwSpeed;
}

struct MCI_DGV_SETAUDIO_PARMSA
{
    uint dwCallback;
    uint dwItem;
    uint dwValue;
    uint dwOver;
    const(char)* lpstrAlgorithm;
    const(char)* lpstrQuality;
}

struct MCI_DGV_SETAUDIO_PARMSW
{
    uint dwCallback;
    uint dwItem;
    uint dwValue;
    uint dwOver;
    const(wchar)* lpstrAlgorithm;
    const(wchar)* lpstrQuality;
}

struct MCI_DGV_SIGNAL_PARMS
{
    uint dwCallback;
    uint dwPosition;
    uint dwPeriod;
    uint dwUserParm;
}

struct MCI_DGV_SETVIDEO_PARMSA
{
    uint dwCallback;
    uint dwItem;
    uint dwValue;
    uint dwOver;
    const(char)* lpstrAlgorithm;
    const(char)* lpstrQuality;
    uint dwSourceNumber;
}

struct MCI_DGV_SETVIDEO_PARMSW
{
    uint dwCallback;
    uint dwItem;
    uint dwValue;
    uint dwOver;
    const(wchar)* lpstrAlgorithm;
    const(wchar)* lpstrQuality;
    uint dwSourceNumber;
}

struct MCI_DGV_STATUS_PARMSA
{
    uint dwCallback;
    uint dwReturn;
    uint dwItem;
    uint dwTrack;
    const(char)* lpstrDrive;
    uint dwReference;
}

struct MCI_DGV_STATUS_PARMSW
{
    uint dwCallback;
    uint dwReturn;
    uint dwItem;
    uint dwTrack;
    const(wchar)* lpstrDrive;
    uint dwReference;
}

struct MCI_DGV_STEP_PARMS
{
    uint dwCallback;
    uint dwFrames;
}

struct MCI_DGV_UPDATE_PARMS
{
    uint dwCallback;
    RECT rc;
    HDC hDC;
}

struct MCI_DGV_WINDOW_PARMSA
{
    uint dwCallback;
    HWND hWnd;
    uint nCmdShow;
    const(char)* lpstrText;
}

struct MCI_DGV_WINDOW_PARMSW
{
    uint dwCallback;
    HWND hWnd;
    uint nCmdShow;
    const(wchar)* lpstrText;
}

struct HACMDRIVERID__
{
    int unused;
}

struct HACMDRIVER__
{
    int unused;
}

struct HACMSTREAM__
{
    int unused;
}

struct HACMOBJ__
{
    int unused;
}

alias ACMDRIVERENUMCB = extern(Windows) BOOL function(HACMDRIVERID__* hadid, uint dwInstance, uint fdwSupport);
alias ACMDRIVERPROC = extern(Windows) LRESULT function(uint param0, HACMDRIVERID__* param1, uint param2, LPARAM param3, LPARAM param4);
alias LPACMDRIVERPROC = extern(Windows) LRESULT function();
struct tACMDRIVERDETAILSA
{
    uint cbStruct;
    uint fccType;
    uint fccComp;
    ushort wMid;
    ushort wPid;
    uint vdwACM;
    uint vdwDriver;
    uint fdwSupport;
    uint cFormatTags;
    uint cFilterTags;
    HICON hicon;
    byte szShortName;
    byte szLongName;
    byte szCopyright;
    byte szLicensing;
    byte szFeatures;
}

struct tACMDRIVERDETAILSW
{
    uint cbStruct;
    uint fccType;
    uint fccComp;
    ushort wMid;
    ushort wPid;
    uint vdwACM;
    uint vdwDriver;
    uint fdwSupport;
    uint cFormatTags;
    uint cFilterTags;
    HICON hicon;
    ushort szShortName;
    ushort szLongName;
    ushort szCopyright;
    ushort szLicensing;
    ushort szFeatures;
}

struct tACMFORMATTAGDETAILSA
{
    uint cbStruct;
    uint dwFormatTagIndex;
    uint dwFormatTag;
    uint cbFormatSize;
    uint fdwSupport;
    uint cStandardFormats;
    byte szFormatTag;
}

struct tACMFORMATTAGDETAILSW
{
    uint cbStruct;
    uint dwFormatTagIndex;
    uint dwFormatTag;
    uint cbFormatSize;
    uint fdwSupport;
    uint cStandardFormats;
    ushort szFormatTag;
}

alias ACMFORMATTAGENUMCBA = extern(Windows) BOOL function(HACMDRIVERID__* hadid, tACMFORMATTAGDETAILSA* paftd, uint dwInstance, uint fdwSupport);
alias ACMFORMATTAGENUMCBW = extern(Windows) BOOL function(HACMDRIVERID__* hadid, tACMFORMATTAGDETAILSW* paftd, uint dwInstance, uint fdwSupport);
struct tACMFORMATDETAILSA
{
    uint cbStruct;
    uint dwFormatIndex;
    uint dwFormatTag;
    uint fdwSupport;
    WAVEFORMATEX* pwfx;
    uint cbwfx;
    byte szFormat;
}

struct tACMFORMATDETAILSW
{
    uint cbStruct;
    uint dwFormatIndex;
    uint dwFormatTag;
    uint fdwSupport;
    WAVEFORMATEX* pwfx;
    uint cbwfx;
    ushort szFormat;
}

alias ACMFORMATENUMCBA = extern(Windows) BOOL function(HACMDRIVERID__* hadid, tACMFORMATDETAILSA* pafd, uint dwInstance, uint fdwSupport);
alias ACMFORMATENUMCBW = extern(Windows) BOOL function(HACMDRIVERID__* hadid, tACMFORMATDETAILSW* pafd, uint dwInstance, uint fdwSupport);
alias ACMFORMATCHOOSEHOOKPROCA = extern(Windows) uint function(HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
alias ACMFORMATCHOOSEHOOKPROCW = extern(Windows) uint function(HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
struct tACMFORMATCHOOSEA
{
    uint cbStruct;
    uint fdwStyle;
    HWND hwndOwner;
    WAVEFORMATEX* pwfx;
    uint cbwfx;
    const(char)* pszTitle;
    byte szFormatTag;
    byte szFormat;
    const(char)* pszName;
    uint cchName;
    uint fdwEnum;
    WAVEFORMATEX* pwfxEnum;
    HINSTANCE hInstance;
    const(char)* pszTemplateName;
    LPARAM lCustData;
    ACMFORMATCHOOSEHOOKPROCA pfnHook;
}

struct tACMFORMATCHOOSEW
{
    uint cbStruct;
    uint fdwStyle;
    HWND hwndOwner;
    WAVEFORMATEX* pwfx;
    uint cbwfx;
    const(wchar)* pszTitle;
    ushort szFormatTag;
    ushort szFormat;
    const(wchar)* pszName;
    uint cchName;
    uint fdwEnum;
    WAVEFORMATEX* pwfxEnum;
    HINSTANCE hInstance;
    const(wchar)* pszTemplateName;
    LPARAM lCustData;
    ACMFORMATCHOOSEHOOKPROCW pfnHook;
}

struct tACMFILTERTAGDETAILSA
{
    uint cbStruct;
    uint dwFilterTagIndex;
    uint dwFilterTag;
    uint cbFilterSize;
    uint fdwSupport;
    uint cStandardFilters;
    byte szFilterTag;
}

struct tACMFILTERTAGDETAILSW
{
    uint cbStruct;
    uint dwFilterTagIndex;
    uint dwFilterTag;
    uint cbFilterSize;
    uint fdwSupport;
    uint cStandardFilters;
    ushort szFilterTag;
}

alias ACMFILTERTAGENUMCBA = extern(Windows) BOOL function(HACMDRIVERID__* hadid, tACMFILTERTAGDETAILSA* paftd, uint dwInstance, uint fdwSupport);
alias ACMFILTERTAGENUMCBW = extern(Windows) BOOL function(HACMDRIVERID__* hadid, tACMFILTERTAGDETAILSW* paftd, uint dwInstance, uint fdwSupport);
struct tACMFILTERDETAILSA
{
    uint cbStruct;
    uint dwFilterIndex;
    uint dwFilterTag;
    uint fdwSupport;
    WAVEFILTER* pwfltr;
    uint cbwfltr;
    byte szFilter;
}

struct tACMFILTERDETAILSW
{
    uint cbStruct;
    uint dwFilterIndex;
    uint dwFilterTag;
    uint fdwSupport;
    WAVEFILTER* pwfltr;
    uint cbwfltr;
    ushort szFilter;
}

alias ACMFILTERENUMCBA = extern(Windows) BOOL function(HACMDRIVERID__* hadid, tACMFILTERDETAILSA* pafd, uint dwInstance, uint fdwSupport);
alias ACMFILTERENUMCBW = extern(Windows) BOOL function(HACMDRIVERID__* hadid, tACMFILTERDETAILSW* pafd, uint dwInstance, uint fdwSupport);
alias ACMFILTERCHOOSEHOOKPROCA = extern(Windows) uint function(HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
alias ACMFILTERCHOOSEHOOKPROCW = extern(Windows) uint function(HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
struct tACMFILTERCHOOSEA
{
    uint cbStruct;
    uint fdwStyle;
    HWND hwndOwner;
    WAVEFILTER* pwfltr;
    uint cbwfltr;
    const(char)* pszTitle;
    byte szFilterTag;
    byte szFilter;
    const(char)* pszName;
    uint cchName;
    uint fdwEnum;
    WAVEFILTER* pwfltrEnum;
    HINSTANCE hInstance;
    const(char)* pszTemplateName;
    LPARAM lCustData;
    ACMFILTERCHOOSEHOOKPROCA pfnHook;
}

struct tACMFILTERCHOOSEW
{
    uint cbStruct;
    uint fdwStyle;
    HWND hwndOwner;
    WAVEFILTER* pwfltr;
    uint cbwfltr;
    const(wchar)* pszTitle;
    ushort szFilterTag;
    ushort szFilter;
    const(wchar)* pszName;
    uint cchName;
    uint fdwEnum;
    WAVEFILTER* pwfltrEnum;
    HINSTANCE hInstance;
    const(wchar)* pszTemplateName;
    LPARAM lCustData;
    ACMFILTERCHOOSEHOOKPROCW pfnHook;
}

struct ACMSTREAMHEADER
{
    uint cbStruct;
    uint fdwStatus;
    uint dwUser;
    ubyte* pbSrc;
    uint cbSrcLength;
    uint cbSrcLengthUsed;
    uint dwSrcUser;
    ubyte* pbDst;
    uint cbDstLength;
    uint cbDstLengthUsed;
    uint dwDstUser;
    uint dwReservedDriver;
}

struct HIC__
{
    int unused;
}

struct ICOPEN
{
    uint dwSize;
    uint fccType;
    uint fccHandler;
    uint dwVersion;
    uint dwFlags;
    LRESULT dwError;
    void* pV1Reserved;
    void* pV2Reserved;
    uint dnDevNode;
}

struct ICINFO
{
    uint dwSize;
    uint fccType;
    uint fccHandler;
    uint dwFlags;
    uint dwVersion;
    uint dwVersionICM;
    ushort szName;
    ushort szDescription;
    ushort szDriver;
}

struct ICCOMPRESS
{
    uint dwFlags;
    BITMAPINFOHEADER* lpbiOutput;
    void* lpOutput;
    BITMAPINFOHEADER* lpbiInput;
    void* lpInput;
    uint* lpckid;
    uint* lpdwFlags;
    int lFrameNum;
    uint dwFrameSize;
    uint dwQuality;
    BITMAPINFOHEADER* lpbiPrev;
    void* lpPrev;
}

struct ICCOMPRESSFRAMES
{
    uint dwFlags;
    BITMAPINFOHEADER* lpbiOutput;
    LPARAM lOutput;
    BITMAPINFOHEADER* lpbiInput;
    LPARAM lInput;
    int lStartFrame;
    int lFrameCount;
    int lQuality;
    int lDataRate;
    int lKeyRate;
    uint dwRate;
    uint dwScale;
    uint dwOverheadPerFrame;
    uint dwReserved2;
    int GetData;
    int PutData;
}

struct ICSETSTATUSPROC
{
    uint dwFlags;
    LPARAM lParam;
    int Status;
}

struct ICDECOMPRESS
{
    uint dwFlags;
    BITMAPINFOHEADER* lpbiInput;
    void* lpInput;
    BITMAPINFOHEADER* lpbiOutput;
    void* lpOutput;
    uint ckid;
}

struct ICDECOMPRESSEX
{
    uint dwFlags;
    BITMAPINFOHEADER* lpbiSrc;
    void* lpSrc;
    BITMAPINFOHEADER* lpbiDst;
    void* lpDst;
    int xDst;
    int yDst;
    int dxDst;
    int dyDst;
    int xSrc;
    int ySrc;
    int dxSrc;
    int dySrc;
}

struct ICDRAWBEGIN
{
    uint dwFlags;
    HPALETTE hpal;
    HWND hwnd;
    HDC hdc;
    int xDst;
    int yDst;
    int dxDst;
    int dyDst;
    BITMAPINFOHEADER* lpbi;
    int xSrc;
    int ySrc;
    int dxSrc;
    int dySrc;
    uint dwRate;
    uint dwScale;
}

struct ICDRAW
{
    uint dwFlags;
    void* lpFormat;
    void* lpData;
    uint cbData;
    int lTime;
}

struct ICDRAWSUGGEST
{
    BITMAPINFOHEADER* lpbiIn;
    BITMAPINFOHEADER* lpbiSuggest;
    int dxSrc;
    int dySrc;
    int dxDst;
    int dyDst;
    HIC__* hicDecompressor;
}

struct ICPALETTE
{
    uint dwFlags;
    int iStart;
    int iLen;
    PALETTEENTRY* lppe;
}

struct COMPVARS
{
    int cbSize;
    uint dwFlags;
    HIC__* hic;
    uint fccType;
    uint fccHandler;
    BITMAPINFO* lpbiIn;
    BITMAPINFO* lpbiOut;
    void* lpBitsOut;
    void* lpBitsPrev;
    int lFrame;
    int lKey;
    int lDataRate;
    int lQ;
    int lKeyCount;
    void* lpState;
    int cbState;
}

struct DRAWDIBTIME
{
    int timeCount;
    int timeDraw;
    int timeDecompress;
    int timeDither;
    int timeStretch;
    int timeBlt;
    int timeSetDIBits;
}

struct AVISTREAMINFOW
{
    uint fccType;
    uint fccHandler;
    uint dwFlags;
    uint dwCaps;
    ushort wPriority;
    ushort wLanguage;
    uint dwScale;
    uint dwRate;
    uint dwStart;
    uint dwLength;
    uint dwInitialFrames;
    uint dwSuggestedBufferSize;
    uint dwQuality;
    uint dwSampleSize;
    RECT rcFrame;
    uint dwEditCount;
    uint dwFormatChangeCount;
    ushort szName;
}

struct AVISTREAMINFOA
{
    uint fccType;
    uint fccHandler;
    uint dwFlags;
    uint dwCaps;
    ushort wPriority;
    ushort wLanguage;
    uint dwScale;
    uint dwRate;
    uint dwStart;
    uint dwLength;
    uint dwInitialFrames;
    uint dwSuggestedBufferSize;
    uint dwQuality;
    uint dwSampleSize;
    RECT rcFrame;
    uint dwEditCount;
    uint dwFormatChangeCount;
    byte szName;
}

struct AVIFILEINFOW
{
    uint dwMaxBytesPerSec;
    uint dwFlags;
    uint dwCaps;
    uint dwStreams;
    uint dwSuggestedBufferSize;
    uint dwWidth;
    uint dwHeight;
    uint dwScale;
    uint dwRate;
    uint dwLength;
    uint dwEditCount;
    ushort szFileType;
}

struct AVIFILEINFOA
{
    uint dwMaxBytesPerSec;
    uint dwFlags;
    uint dwCaps;
    uint dwStreams;
    uint dwSuggestedBufferSize;
    uint dwWidth;
    uint dwHeight;
    uint dwScale;
    uint dwRate;
    uint dwLength;
    uint dwEditCount;
    byte szFileType;
}

alias AVISAVECALLBACK = extern(Windows) BOOL function(int param0);
struct AVICOMPRESSOPTIONS
{
    uint fccType;
    uint fccHandler;
    uint dwKeyFrameEvery;
    uint dwQuality;
    uint dwBytesPerSecond;
    uint dwFlags;
    void* lpFormat;
    uint cbFormat;
    void* lpParms;
    uint cbParms;
    uint dwInterleaveEvery;
}

interface IAVIStream : IUnknown
{
    HRESULT Create(LPARAM lParam1, LPARAM lParam2);
    HRESULT Info(char* psi, int lSize);
    int FindSample(int lPos, int lFlags);
    HRESULT ReadFormat(int lPos, char* lpFormat, int* lpcbFormat);
    HRESULT SetFormat(int lPos, char* lpFormat, int cbFormat);
    HRESULT Read(int lStart, int lSamples, char* lpBuffer, int cbBuffer, int* plBytes, int* plSamples);
    HRESULT Write(int lStart, int lSamples, char* lpBuffer, int cbBuffer, uint dwFlags, int* plSampWritten, int* plBytesWritten);
    HRESULT Delete(int lStart, int lSamples);
    HRESULT ReadData(uint fcc, char* lp, int* lpcb);
    HRESULT WriteData(uint fcc, char* lp, int cb);
    HRESULT SetInfo(char* lpInfo, int cbInfo);
}

interface IAVIStreaming : IUnknown
{
    HRESULT Begin(int lStart, int lEnd, int lRate);
    HRESULT End();
}

interface IAVIEditStream : IUnknown
{
    HRESULT Cut(int* plStart, int* plLength, IAVIStream* ppResult);
    HRESULT Copy(int* plStart, int* plLength, IAVIStream* ppResult);
    HRESULT Paste(int* plPos, int* plLength, IAVIStream pstream, int lStart, int lEnd);
    HRESULT Clone(IAVIStream* ppResult);
    HRESULT SetInfo(char* lpInfo, int cbInfo);
}

interface IAVIPersistFile : IPersistFile
{
    HRESULT Reserved1();
}

interface IAVIFile : IUnknown
{
    HRESULT Info(char* pfi, int lSize);
    HRESULT GetStream(IAVIStream* ppStream, uint fccType, int lParam);
    HRESULT CreateStream(IAVIStream* ppStream, AVISTREAMINFOW* psi);
    HRESULT WriteData(uint ckid, char* lpData, int cbData);
    HRESULT ReadData(uint ckid, char* lpData, int* lpcbData);
    HRESULT EndRecord();
    HRESULT DeleteStream(uint fccType, int lParam);
}

interface IGetFrame : IUnknown
{
    void* GetFrame(int lPos);
    HRESULT Begin(int lStart, int lEnd, int lRate);
    HRESULT End();
    HRESULT SetFormat(BITMAPINFOHEADER* lpbi, void* lpBits, int x, int y, int dx, int dy);
}

struct HVIDEO__
{
    int unused;
}

struct VIDEOHDR
{
    ubyte* lpData;
    uint dwBufferLength;
    uint dwBytesUsed;
    uint dwTimeCaptured;
    uint dwUser;
    uint dwFlags;
    uint dwReserved;
}

struct channel_caps_tag
{
    uint dwFlags;
    uint dwSrcRectXMod;
    uint dwSrcRectYMod;
    uint dwSrcRectWidthMod;
    uint dwSrcRectHeightMod;
    uint dwDstRectXMod;
    uint dwDstRectYMod;
    uint dwDstRectWidthMod;
    uint dwDstRectHeightMod;
}

struct CAPDRIVERCAPS
{
    uint wDeviceIndex;
    BOOL fHasOverlay;
    BOOL fHasDlgVideoSource;
    BOOL fHasDlgVideoFormat;
    BOOL fHasDlgVideoDisplay;
    BOOL fCaptureInitialized;
    BOOL fDriverSuppliesPalettes;
    HANDLE hVideoIn;
    HANDLE hVideoOut;
    HANDLE hVideoExtIn;
    HANDLE hVideoExtOut;
}

struct CAPSTATUS
{
    uint uiImageWidth;
    uint uiImageHeight;
    BOOL fLiveWindow;
    BOOL fOverlayWindow;
    BOOL fScale;
    POINT ptScroll;
    BOOL fUsingDefaultPalette;
    BOOL fAudioHardware;
    BOOL fCapFileExists;
    uint dwCurrentVideoFrame;
    uint dwCurrentVideoFramesDropped;
    uint dwCurrentWaveSamples;
    uint dwCurrentTimeElapsedMS;
    HPALETTE hPalCurrent;
    BOOL fCapturingNow;
    uint dwReturn;
    uint wNumVideoAllocated;
    uint wNumAudioAllocated;
}

struct CAPTUREPARMS
{
    uint dwRequestMicroSecPerFrame;
    BOOL fMakeUserHitOKToCapture;
    uint wPercentDropForError;
    BOOL fYield;
    uint dwIndexSize;
    uint wChunkGranularity;
    BOOL fUsingDOSMemory;
    uint wNumVideoRequested;
    BOOL fCaptureAudio;
    uint wNumAudioRequested;
    uint vKeyAbort;
    BOOL fAbortLeftMouse;
    BOOL fAbortRightMouse;
    BOOL fLimitEnabled;
    uint wTimeLimit;
    BOOL fMCIControl;
    BOOL fStepMCIDevice;
    uint dwMCIStartTime;
    uint dwMCIStopTime;
    BOOL fStepCaptureAt2x;
    uint wStepCaptureAverageFrames;
    uint dwAudioBufferSize;
    BOOL fDisableWriteCache;
    uint AVStreamMaster;
}

struct CAPINFOCHUNK
{
    uint fccInfoID;
    void* lpData;
    int cbData;
}

alias CAPYIELDCALLBACK = extern(Windows) LRESULT function(HWND hWnd);
alias CAPSTATUSCALLBACKW = extern(Windows) LRESULT function(HWND hWnd, int nID, const(wchar)* lpsz);
alias CAPERRORCALLBACKW = extern(Windows) LRESULT function(HWND hWnd, int nID, const(wchar)* lpsz);
alias CAPSTATUSCALLBACKA = extern(Windows) LRESULT function(HWND hWnd, int nID, const(char)* lpsz);
alias CAPERRORCALLBACKA = extern(Windows) LRESULT function(HWND hWnd, int nID, const(char)* lpsz);
alias CAPVIDEOCALLBACK = extern(Windows) LRESULT function(HWND hWnd, VIDEOHDR* lpVHdr);
alias CAPWAVECALLBACK = extern(Windows) LRESULT function(HWND hWnd, WAVEHDR* lpWHdr);
alias CAPCONTROLCALLBACK = extern(Windows) LRESULT function(HWND hWnd, int nState);
struct DRVM_IOCTL_DATA
{
    uint dwSize;
    uint dwCmd;
}

struct waveopendesc_tag
{
    int hWave;
    WAVEFORMAT* lpFormat;
    uint dwCallback;
    uint dwInstance;
    uint uMappedDeviceID;
    uint dnDevNode;
}

struct midiopenstrmid_tag
{
    uint dwStreamID;
    uint uDeviceID;
}

struct tMIXEROPENDESC
{
    int hmx;
    void* pReserved0;
    uint dwCallback;
    uint dwInstance;
    uint dnDevNode;
}

struct timerevent_tag
{
    ushort wDelay;
    ushort wResolution;
    LPTIMECALLBACK lpFunction;
    uint dwUser;
    ushort wFlags;
    ushort wReserved1;
}

struct joypos_tag
{
    uint dwX;
    uint dwY;
    uint dwZ;
    uint dwR;
    uint dwU;
    uint dwV;
}

struct joyrange_tag
{
    joypos_tag jpMin;
    joypos_tag jpMax;
    joypos_tag jpCenter;
}

struct joyreguservalues_tag
{
    uint dwTimeOut;
    joyrange_tag jrvRanges;
    joypos_tag jpDeadZone;
}

struct joyreghwsettings_tag
{
    uint dwFlags;
    uint dwNumButtons;
}

struct joyreghwconfig_tag
{
    joyreghwsettings_tag hws;
    uint dwUsageSettings;
    JOYREGHWVALUES hwv;
    uint dwType;
    uint dwReserved;
}

struct joycalibrate_tag
{
    ushort wXbase;
    ushort wXdelta;
    ushort wYbase;
    ushort wYdelta;
    ushort wZbase;
    ushort wZdelta;
}

alias JOYDEVMSGPROC = extern(Windows) uint function(uint param0, uint param1, int param2, int param3);
alias LPJOYDEVMSGPROC = extern(Windows) uint function();
struct MCI_OPEN_DRIVER_PARMS
{
    uint wDeviceID;
    const(wchar)* lpstrParams;
    uint wCustomCommandTable;
    uint wType;
}

alias TASKCALLBACK = extern(Windows) void function(uint dwInst);
alias LPTASKCALLBACK = extern(Windows) void function();
