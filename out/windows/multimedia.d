module windows.multimedia;

public import windows.core;
public import windows.com : HRESULT, IPersistFile, IUnknown;
public import windows.direct2d : PALETTEENTRY;
public import windows.directshow : BITMAPINFOHEADER;
public import windows.displaydevices : POINT, RECT;
public import windows.gdi : BITMAPINFO, HDC, HICON, HPALETTE;
public import windows.hid : JOYREGHWVALUES;
public import windows.systemservices : BOOL, FARPROC, HANDLE, HINSTANCE, LPTIMECALLBACK, LRESULT;
public import windows.windowsandmessaging : HWND, LPARAM, OPENFILENAMEA, OPENFILENAMEW, WPARAM;

extern(Windows):


// Callbacks

alias DRVCALLBACK = void function(ptrdiff_t hdrvr, uint uMsg, size_t dwUser, size_t dw1, size_t dw2);
alias LPDRVCALLBACK = void function();
alias PDRVCALLBACK = void function();
alias DRIVERPROC = LRESULT function(size_t param0, ptrdiff_t param1, uint param2, LPARAM param3, LPARAM param4);
alias DRIVERMSGPROC = uint function(uint param0, uint param1, size_t param2, size_t param3, size_t param4);
alias MMIOPROC = LRESULT function(const(char)* lpmmioinfo, uint uMsg, LPARAM lParam1, LPARAM lParam2);
alias LPMMIOPROC = LRESULT function();
alias WAVECALLBACK = void function();
alias LPWAVECALLBACK = void function();
alias MIDICALLBACK = void function();
alias LPMIDICALLBACK = void function();
alias ACMDRIVERENUMCB = BOOL function(HACMDRIVERID__* hadid, size_t dwInstance, uint fdwSupport);
alias ACMDRIVERPROC = LRESULT function(size_t param0, HACMDRIVERID__* param1, uint param2, LPARAM param3, 
                                       LPARAM param4);
alias LPACMDRIVERPROC = LRESULT function();
alias ACMFORMATTAGENUMCBA = BOOL function(HACMDRIVERID__* hadid, tACMFORMATTAGDETAILSA* paftd, size_t dwInstance, 
                                          uint fdwSupport);
alias ACMFORMATTAGENUMCBW = BOOL function(HACMDRIVERID__* hadid, tACMFORMATTAGDETAILSW* paftd, size_t dwInstance, 
                                          uint fdwSupport);
alias ACMFORMATENUMCBA = BOOL function(HACMDRIVERID__* hadid, tACMFORMATDETAILSA* pafd, size_t dwInstance, 
                                       uint fdwSupport);
alias ACMFORMATENUMCBW = BOOL function(HACMDRIVERID__* hadid, tACMFORMATDETAILSW* pafd, size_t dwInstance, 
                                       uint fdwSupport);
alias ACMFORMATCHOOSEHOOKPROCA = uint function(HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
alias ACMFORMATCHOOSEHOOKPROCW = uint function(HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
alias ACMFILTERTAGENUMCBA = BOOL function(HACMDRIVERID__* hadid, tACMFILTERTAGDETAILSA* paftd, size_t dwInstance, 
                                          uint fdwSupport);
alias ACMFILTERTAGENUMCBW = BOOL function(HACMDRIVERID__* hadid, tACMFILTERTAGDETAILSW* paftd, size_t dwInstance, 
                                          uint fdwSupport);
alias ACMFILTERENUMCBA = BOOL function(HACMDRIVERID__* hadid, tACMFILTERDETAILSA* pafd, size_t dwInstance, 
                                       uint fdwSupport);
alias ACMFILTERENUMCBW = BOOL function(HACMDRIVERID__* hadid, tACMFILTERDETAILSW* pafd, size_t dwInstance, 
                                       uint fdwSupport);
alias ACMFILTERCHOOSEHOOKPROCA = uint function(HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
alias ACMFILTERCHOOSEHOOKPROCW = uint function(HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
alias AVISAVECALLBACK = BOOL function(int param0);
alias CAPYIELDCALLBACK = LRESULT function(HWND hWnd);
alias CAPSTATUSCALLBACKW = LRESULT function(HWND hWnd, int nID, const(wchar)* lpsz);
alias CAPERRORCALLBACKW = LRESULT function(HWND hWnd, int nID, const(wchar)* lpsz);
alias CAPSTATUSCALLBACKA = LRESULT function(HWND hWnd, int nID, const(char)* lpsz);
alias CAPERRORCALLBACKA = LRESULT function(HWND hWnd, int nID, const(char)* lpsz);
alias CAPVIDEOCALLBACK = LRESULT function(HWND hWnd, VIDEOHDR* lpVHdr);
alias CAPWAVECALLBACK = LRESULT function(HWND hWnd, WAVEHDR* lpWHdr);
alias CAPCONTROLCALLBACK = LRESULT function(HWND hWnd, int nState);
alias JOYDEVMSGPROC = uint function(uint param0, uint param1, int param2, int param3);
alias LPJOYDEVMSGPROC = uint function();
alias TASKCALLBACK = void function(size_t dwInst);
alias LPTASKCALLBACK = void function();

// Structs


struct MMTIME
{
align (1):
    uint wType;
    union u
    {
    align (1):
        uint ms;
        uint sample;
        uint cb;
        uint ticks;
        struct smpte
        {
            ubyte    hour;
            ubyte    min;
            ubyte    sec;
            ubyte    frame;
            ubyte    fps;
            ubyte    dummy;
            ubyte[2] pad;
        }
        struct midi
        {
        align (1):
            uint songptrpos;
        }
    }
}

struct HDRVR__
{
align (1):
    int unused;
}

struct DRVCONFIGINFOEX
{
align (1):
    uint          dwDCISize;
    const(wchar)* lpszDCISectionName;
    const(wchar)* lpszDCIAliasName;
    uint          dnDevNode;
}

struct DRVCONFIGINFO
{
align (1):
    uint          dwDCISize;
    const(wchar)* lpszDCISectionName;
    const(wchar)* lpszDCIAliasName;
}

struct HMMIO__
{
align (1):
    int unused;
}

struct MMIOINFO
{
align (1):
    uint       dwFlags;
    uint       fccIOProc;
    LPMMIOPROC pIOProc;
    uint       wErrorRet;
    ptrdiff_t  htask;
    int        cchBuffer;
    byte*      pchBuffer;
    byte*      pchNext;
    byte*      pchEndRead;
    byte*      pchEndWrite;
    int        lBufOffset;
    int        lDiskOffset;
    uint[3]    adwInfo;
    uint       dwReserved1;
    uint       dwReserved2;
    HMMIO__*   hmmio;
}

struct MMCKINFO
{
align (1):
    uint ckid;
    uint cksize;
    uint fccType;
    uint dwDataOffset;
    uint dwFlags;
}

struct HWAVE__
{
align (1):
    int unused;
}

struct HWAVEIN__
{
align (1):
    int unused;
}

struct HWAVEOUT__
{
align (1):
    int unused;
}

struct WAVEHDR
{
align (1):
    const(char)* lpData;
    uint         dwBufferLength;
    uint         dwBytesRecorded;
    size_t       dwUser;
    uint         dwFlags;
    uint         dwLoops;
    WAVEHDR*     lpNext;
    size_t       reserved;
}

struct WAVEOUTCAPSA
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    byte[32] szPname;
    uint     dwFormats;
    ushort   wChannels;
    ushort   wReserved1;
    uint     dwSupport;
}

struct WAVEOUTCAPSW
{
align (1):
    ushort     wMid;
    ushort     wPid;
    uint       vDriverVersion;
    ushort[32] szPname;
    uint       dwFormats;
    ushort     wChannels;
    ushort     wReserved1;
    uint       dwSupport;
}

struct WAVEOUTCAPS2A
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    byte[32] szPname;
    uint     dwFormats;
    ushort   wChannels;
    ushort   wReserved1;
    uint     dwSupport;
    GUID     ManufacturerGuid;
    GUID     ProductGuid;
    GUID     NameGuid;
}

struct WAVEOUTCAPS2W
{
align (1):
    ushort     wMid;
    ushort     wPid;
    uint       vDriverVersion;
    ushort[32] szPname;
    uint       dwFormats;
    ushort     wChannels;
    ushort     wReserved1;
    uint       dwSupport;
    GUID       ManufacturerGuid;
    GUID       ProductGuid;
    GUID       NameGuid;
}

struct WAVEINCAPSA
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    byte[32] szPname;
    uint     dwFormats;
    ushort   wChannels;
    ushort   wReserved1;
}

struct WAVEINCAPSW
{
align (1):
    ushort     wMid;
    ushort     wPid;
    uint       vDriverVersion;
    ushort[32] szPname;
    uint       dwFormats;
    ushort     wChannels;
    ushort     wReserved1;
}

struct WAVEINCAPS2A
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    byte[32] szPname;
    uint     dwFormats;
    ushort   wChannels;
    ushort   wReserved1;
    GUID     ManufacturerGuid;
    GUID     ProductGuid;
    GUID     NameGuid;
}

struct WAVEINCAPS2W
{
align (1):
    ushort     wMid;
    ushort     wPid;
    uint       vDriverVersion;
    ushort[32] szPname;
    uint       dwFormats;
    ushort     wChannels;
    ushort     wReserved1;
    GUID       ManufacturerGuid;
    GUID       ProductGuid;
    GUID       NameGuid;
}

struct WAVEFORMAT
{
align (1):
    ushort wFormatTag;
    ushort nChannels;
    uint   nSamplesPerSec;
    uint   nAvgBytesPerSec;
    ushort nBlockAlign;
}

struct PCMWAVEFORMAT
{
align (1):
    WAVEFORMAT wf;
    ushort     wBitsPerSample;
}

struct WAVEFORMATEX
{
align (1):
    ushort wFormatTag;
    ushort nChannels;
    uint   nSamplesPerSec;
    uint   nAvgBytesPerSec;
    ushort nBlockAlign;
    ushort wBitsPerSample;
    ushort cbSize;
}

struct HMIDI__
{
align (1):
    int unused;
}

struct HMIDIIN__
{
align (1):
    int unused;
}

struct HMIDIOUT__
{
align (1):
    int unused;
}

struct HMIDISTRM__
{
align (1):
    int unused;
}

struct MIDIOUTCAPSA
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    byte[32] szPname;
    ushort   wTechnology;
    ushort   wVoices;
    ushort   wNotes;
    ushort   wChannelMask;
    uint     dwSupport;
}

struct MIDIOUTCAPSW
{
align (1):
    ushort     wMid;
    ushort     wPid;
    uint       vDriverVersion;
    ushort[32] szPname;
    ushort     wTechnology;
    ushort     wVoices;
    ushort     wNotes;
    ushort     wChannelMask;
    uint       dwSupport;
}

struct MIDIOUTCAPS2A
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    byte[32] szPname;
    ushort   wTechnology;
    ushort   wVoices;
    ushort   wNotes;
    ushort   wChannelMask;
    uint     dwSupport;
    GUID     ManufacturerGuid;
    GUID     ProductGuid;
    GUID     NameGuid;
}

struct MIDIOUTCAPS2W
{
align (1):
    ushort     wMid;
    ushort     wPid;
    uint       vDriverVersion;
    ushort[32] szPname;
    ushort     wTechnology;
    ushort     wVoices;
    ushort     wNotes;
    ushort     wChannelMask;
    uint       dwSupport;
    GUID       ManufacturerGuid;
    GUID       ProductGuid;
    GUID       NameGuid;
}

struct MIDIINCAPSA
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    byte[32] szPname;
    uint     dwSupport;
}

struct MIDIINCAPSW
{
align (1):
    ushort     wMid;
    ushort     wPid;
    uint       vDriverVersion;
    ushort[32] szPname;
    uint       dwSupport;
}

struct MIDIINCAPS2A
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    byte[32] szPname;
    uint     dwSupport;
    GUID     ManufacturerGuid;
    GUID     ProductGuid;
    GUID     NameGuid;
}

struct MIDIINCAPS2W
{
align (1):
    ushort     wMid;
    ushort     wPid;
    uint       vDriverVersion;
    ushort[32] szPname;
    uint       dwSupport;
    GUID       ManufacturerGuid;
    GUID       ProductGuid;
    GUID       NameGuid;
}

struct MIDIHDR
{
align (1):
    const(char)* lpData;
    uint         dwBufferLength;
    uint         dwBytesRecorded;
    size_t       dwUser;
    uint         dwFlags;
    MIDIHDR*     lpNext;
    size_t       reserved;
    uint         dwOffset;
    size_t[8]    dwReserved;
}

struct MIDIEVENT
{
align (1):
    uint    dwDeltaTime;
    uint    dwStreamID;
    uint    dwEvent;
    uint[1] dwParms;
}

struct MIDISTRMBUFFVER
{
align (1):
    uint dwVersion;
    uint dwMid;
    uint dwOEMVersion;
}

struct MIDIPROPTIMEDIV
{
align (1):
    uint cbStruct;
    uint dwTimeDiv;
}

struct MIDIPROPTEMPO
{
align (1):
    uint cbStruct;
    uint dwTempo;
}

struct AUXCAPSA
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    byte[32] szPname;
    ushort   wTechnology;
    ushort   wReserved1;
    uint     dwSupport;
}

struct AUXCAPSW
{
align (1):
    ushort     wMid;
    ushort     wPid;
    uint       vDriverVersion;
    ushort[32] szPname;
    ushort     wTechnology;
    ushort     wReserved1;
    uint       dwSupport;
}

struct AUXCAPS2A
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    byte[32] szPname;
    ushort   wTechnology;
    ushort   wReserved1;
    uint     dwSupport;
    GUID     ManufacturerGuid;
    GUID     ProductGuid;
    GUID     NameGuid;
}

struct AUXCAPS2W
{
align (1):
    ushort     wMid;
    ushort     wPid;
    uint       vDriverVersion;
    ushort[32] szPname;
    ushort     wTechnology;
    ushort     wReserved1;
    uint       dwSupport;
    GUID       ManufacturerGuid;
    GUID       ProductGuid;
    GUID       NameGuid;
}

struct HMIXEROBJ__
{
align (1):
    int unused;
}

struct HMIXER__
{
align (1):
    int unused;
}

struct MIXERCAPSA
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    byte[32] szPname;
    uint     fdwSupport;
    uint     cDestinations;
}

struct MIXERCAPSW
{
align (1):
    ushort     wMid;
    ushort     wPid;
    uint       vDriverVersion;
    ushort[32] szPname;
    uint       fdwSupport;
    uint       cDestinations;
}

struct MIXERCAPS2A
{
align (1):
    ushort   wMid;
    ushort   wPid;
    uint     vDriverVersion;
    byte[32] szPname;
    uint     fdwSupport;
    uint     cDestinations;
    GUID     ManufacturerGuid;
    GUID     ProductGuid;
    GUID     NameGuid;
}

struct MIXERCAPS2W
{
align (1):
    ushort     wMid;
    ushort     wPid;
    uint       vDriverVersion;
    ushort[32] szPname;
    uint       fdwSupport;
    uint       cDestinations;
    GUID       ManufacturerGuid;
    GUID       ProductGuid;
    GUID       NameGuid;
}

struct MIXERLINEA
{
align (1):
    uint     cbStruct;
    uint     dwDestination;
    uint     dwSource;
    uint     dwLineID;
    uint     fdwLine;
    size_t   dwUser;
    uint     dwComponentType;
    uint     cChannels;
    uint     cConnections;
    uint     cControls;
    byte[16] szShortName;
    byte[64] szName;
    struct Target
    {
    align (1):
        uint     dwType;
        uint     dwDeviceID;
        ushort   wMid;
        ushort   wPid;
        uint     vDriverVersion;
        byte[32] szPname;
    }
}

struct MIXERLINEW
{
align (1):
    uint       cbStruct;
    uint       dwDestination;
    uint       dwSource;
    uint       dwLineID;
    uint       fdwLine;
    size_t     dwUser;
    uint       dwComponentType;
    uint       cChannels;
    uint       cConnections;
    uint       cControls;
    ushort[16] szShortName;
    ushort[64] szName;
    struct Target
    {
    align (1):
        uint       dwType;
        uint       dwDeviceID;
        ushort     wMid;
        ushort     wPid;
        uint       vDriverVersion;
        ushort[32] szPname;
    }
}

struct MIXERCONTROLA
{
align (1):
    uint     cbStruct;
    uint     dwControlID;
    uint     dwControlType;
    uint     fdwControl;
    uint     cMultipleItems;
    byte[16] szShortName;
    byte[64] szName;
    union Bounds
    {
    align (1):
        struct
        {
        align (1):
            int lMinimum;
            int lMaximum;
        }
        struct
        {
        align (1):
            uint dwMinimum;
            uint dwMaximum;
        }
        uint[6] dwReserved;
    }
    union Metrics
    {
    align (1):
        uint    cSteps;
        uint    cbCustomData;
        uint[6] dwReserved;
    }
}

struct MIXERCONTROLW
{
align (1):
    uint       cbStruct;
    uint       dwControlID;
    uint       dwControlType;
    uint       fdwControl;
    uint       cMultipleItems;
    ushort[16] szShortName;
    ushort[64] szName;
    union Bounds
    {
    align (1):
        struct
        {
        align (1):
            int lMinimum;
            int lMaximum;
        }
        struct
        {
        align (1):
            uint dwMinimum;
            uint dwMaximum;
        }
        uint[6] dwReserved;
    }
    union Metrics
    {
    align (1):
        uint    cSteps;
        uint    cbCustomData;
        uint[6] dwReserved;
    }
}

struct MIXERLINECONTROLSA
{
align (1):
    uint           cbStruct;
    uint           dwLineID;
    union
    {
    align (1):
        uint dwControlID;
        uint dwControlType;
    }
    uint           cControls;
    uint           cbmxctrl;
    MIXERCONTROLA* pamxctrl;
}

struct MIXERLINECONTROLSW
{
align (1):
    uint           cbStruct;
    uint           dwLineID;
    union
    {
    align (1):
        uint dwControlID;
        uint dwControlType;
    }
    uint           cControls;
    uint           cbmxctrl;
    MIXERCONTROLW* pamxctrl;
}

struct MIXERCONTROLDETAILS
{
align (1):
    uint  cbStruct;
    uint  dwControlID;
    uint  cChannels;
    union
    {
    align (1):
        HWND hwndOwner;
        uint cMultipleItems;
    }
    uint  cbDetails;
    void* paDetails;
}

struct MIXERCONTROLDETAILS_LISTTEXTA
{
align (1):
    uint     dwParam1;
    uint     dwParam2;
    byte[64] szName;
}

struct MIXERCONTROLDETAILS_LISTTEXTW
{
align (1):
    uint       dwParam1;
    uint       dwParam2;
    ushort[64] szName;
}

struct MIXERCONTROLDETAILS_BOOLEAN
{
align (1):
    int fValue;
}

struct MIXERCONTROLDETAILS_SIGNED
{
align (1):
    int lValue;
}

struct MIXERCONTROLDETAILS_UNSIGNED
{
align (1):
    uint dwValue;
}

struct TIMECAPS
{
align (1):
    uint wPeriodMin;
    uint wPeriodMax;
}

struct JOYCAPSA
{
align (1):
    ushort    wMid;
    ushort    wPid;
    byte[32]  szPname;
    uint      wXmin;
    uint      wXmax;
    uint      wYmin;
    uint      wYmax;
    uint      wZmin;
    uint      wZmax;
    uint      wNumButtons;
    uint      wPeriodMin;
    uint      wPeriodMax;
    uint      wRmin;
    uint      wRmax;
    uint      wUmin;
    uint      wUmax;
    uint      wVmin;
    uint      wVmax;
    uint      wCaps;
    uint      wMaxAxes;
    uint      wNumAxes;
    uint      wMaxButtons;
    byte[32]  szRegKey;
    byte[260] szOEMVxD;
}

struct JOYCAPSW
{
align (1):
    ushort      wMid;
    ushort      wPid;
    ushort[32]  szPname;
    uint        wXmin;
    uint        wXmax;
    uint        wYmin;
    uint        wYmax;
    uint        wZmin;
    uint        wZmax;
    uint        wNumButtons;
    uint        wPeriodMin;
    uint        wPeriodMax;
    uint        wRmin;
    uint        wRmax;
    uint        wUmin;
    uint        wUmax;
    uint        wVmin;
    uint        wVmax;
    uint        wCaps;
    uint        wMaxAxes;
    uint        wNumAxes;
    uint        wMaxButtons;
    ushort[32]  szRegKey;
    ushort[260] szOEMVxD;
}

struct JOYCAPS2A
{
align (1):
    ushort    wMid;
    ushort    wPid;
    byte[32]  szPname;
    uint      wXmin;
    uint      wXmax;
    uint      wYmin;
    uint      wYmax;
    uint      wZmin;
    uint      wZmax;
    uint      wNumButtons;
    uint      wPeriodMin;
    uint      wPeriodMax;
    uint      wRmin;
    uint      wRmax;
    uint      wUmin;
    uint      wUmax;
    uint      wVmin;
    uint      wVmax;
    uint      wCaps;
    uint      wMaxAxes;
    uint      wNumAxes;
    uint      wMaxButtons;
    byte[32]  szRegKey;
    byte[260] szOEMVxD;
    GUID      ManufacturerGuid;
    GUID      ProductGuid;
    GUID      NameGuid;
}

struct JOYCAPS2W
{
align (1):
    ushort      wMid;
    ushort      wPid;
    ushort[32]  szPname;
    uint        wXmin;
    uint        wXmax;
    uint        wYmin;
    uint        wYmax;
    uint        wZmin;
    uint        wZmax;
    uint        wNumButtons;
    uint        wPeriodMin;
    uint        wPeriodMax;
    uint        wRmin;
    uint        wRmax;
    uint        wUmin;
    uint        wUmax;
    uint        wVmin;
    uint        wVmax;
    uint        wCaps;
    uint        wMaxAxes;
    uint        wNumAxes;
    uint        wMaxButtons;
    ushort[32]  szRegKey;
    ushort[260] szOEMVxD;
    GUID        ManufacturerGuid;
    GUID        ProductGuid;
    GUID        NameGuid;
}

struct JOYINFO
{
align (1):
    uint wXpos;
    uint wYpos;
    uint wZpos;
    uint wButtons;
}

struct JOYINFOEX
{
align (1):
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

struct WAVEFORMATEXTENSIBLE
{
align (1):
    WAVEFORMATEX Format;
    union Samples
    {
    align (1):
        ushort wValidBitsPerSample;
        ushort wSamplesPerBlock;
        ushort wReserved;
    }
    uint         dwChannelMask;
    GUID         SubFormat;
}

struct ADPCMCOEFSET
{
align (1):
    short iCoef1;
    short iCoef2;
}

struct ADPCMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
    ushort       wNumCoef;
    ADPCMCOEFSET aCoef;
}

struct DRMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wReserved;
    uint         ulContentId;
    WAVEFORMATEX wfxSecure;
}

struct DVIADPCMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
}

struct IMAADPCMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
}

struct MEDIASPACEADPCMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wRevision;
}

struct SIERRAADPCMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wRevision;
}

struct G723_ADPCMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       cbExtraSize;
    ushort       nAuxBlockSize;
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
align (1):
    WAVEFORMATEX wfx;
    ushort       wCompType;
}

struct TRUESPEECHWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wRevision;
    ushort       nSamplesPerBlock;
    ubyte[28]    abReserved;
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
align (1):
    WAVEFORMATEX wfx;
    ushort       nAuxBitsCode;
}

struct GSM610WAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
}

struct ADPCMEWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
}

struct CONTRESVQLPCWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
}

struct DIGIREALWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
}

struct DIGIADPCMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
}

struct CONTRESCR10WAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
}

struct NMS_VBXADPCMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
}

struct G721_ADPCMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       nAuxBlockSize;
}

struct MSAUDIO1WAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wSamplesPerBlock;
    ushort       wEncodeOptions;
}

struct WMAUDIO2WAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    uint         dwSamplesPerBlock;
    ushort       wEncodeOptions;
    uint         dwSuperBlockAlign;
}

struct WMAUDIO3WAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wValidBitsPerSample;
    uint         dwChannelMask;
    uint         dwReserved1;
    uint         dwReserved2;
    ushort       wEncodeOptions;
    ushort       wReserved3;
}

struct CREATIVEADPCMWAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wRevision;
}

struct CREATIVEFASTSPEECH8WAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wRevision;
}

struct CREATIVEFASTSPEECH10WAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wRevision;
}

struct FMTOWNS_SND_WAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wRevision;
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
align (1):
    uint    cbStruct;
    uint    dwFilterTag;
    uint    fdwFilter;
    uint[5] dwReserved;
}

struct VOLUMEWAVEFILTER
{
align (1):
    WAVEFILTER wfltr;
    uint       dwVolume;
}

struct ECHOWAVEFILTER
{
align (1):
    WAVEFILTER wfltr;
    uint       dwVolume;
    uint       dwDelay;
}

struct s_RIFFWAVE_inst
{
    ubyte bUnshiftedNote;
    byte  chFineTune;
    byte  chGain;
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
align (1):
    BITMAPINFOHEADER bmi;
    uint             biExtDataOffset;
}

struct JPEGINFOHEADER
{
align (1):
    uint JPEGSize;
    uint JPEGProcess;
    uint JPEGColorSpaceID;
    uint JPEGBitsPerSample;
    uint JPEGHSubSampling;
    uint JPEGVSubSampling;
}

struct MCI_DGV_RECT_PARMS
{
align (1):
    size_t dwCallback;
    RECT   rc;
}

struct MCI_DGV_CAPTURE_PARMSA
{
align (1):
    size_t       dwCallback;
    const(char)* lpstrFileName;
    RECT         rc;
}

struct MCI_DGV_CAPTURE_PARMSW
{
align (1):
    size_t        dwCallback;
    const(wchar)* lpstrFileName;
    RECT          rc;
}

struct MCI_DGV_COPY_PARMS
{
align (1):
    size_t dwCallback;
    uint   dwFrom;
    uint   dwTo;
    RECT   rc;
    uint   dwAudioStream;
    uint   dwVideoStream;
}

struct MCI_DGV_CUE_PARMS
{
align (1):
    size_t dwCallback;
    uint   dwTo;
}

struct MCI_DGV_CUT_PARMS
{
align (1):
    size_t dwCallback;
    uint   dwFrom;
    uint   dwTo;
    RECT   rc;
    uint   dwAudioStream;
    uint   dwVideoStream;
}

struct MCI_DGV_DELETE_PARMS
{
align (1):
    size_t dwCallback;
    uint   dwFrom;
    uint   dwTo;
    RECT   rc;
    uint   dwAudioStream;
    uint   dwVideoStream;
}

struct MCI_DGV_INFO_PARMSA
{
align (1):
    size_t       dwCallback;
    const(char)* lpstrReturn;
    uint         dwRetSize;
    uint         dwItem;
}

struct MCI_DGV_INFO_PARMSW
{
align (1):
    size_t        dwCallback;
    const(wchar)* lpstrReturn;
    uint          dwRetSize;
    uint          dwItem;
}

struct MCI_DGV_LIST_PARMSA
{
align (1):
    size_t       dwCallback;
    const(char)* lpstrReturn;
    uint         dwLength;
    uint         dwNumber;
    uint         dwItem;
    const(char)* lpstrAlgorithm;
}

struct MCI_DGV_LIST_PARMSW
{
align (1):
    size_t        dwCallback;
    const(wchar)* lpstrReturn;
    uint          dwLength;
    uint          dwNumber;
    uint          dwItem;
    const(wchar)* lpstrAlgorithm;
}

struct MCI_DGV_MONITOR_PARMS
{
align (1):
    size_t dwCallback;
    uint   dwSource;
    uint   dwMethod;
}

struct MCI_DGV_OPEN_PARMSA
{
align (1):
    size_t       dwCallback;
    uint         wDeviceID;
    const(char)* lpstrDeviceType;
    const(char)* lpstrElementName;
    const(char)* lpstrAlias;
    uint         dwStyle;
    HWND         hWndParent;
}

struct MCI_DGV_OPEN_PARMSW
{
align (1):
    size_t        dwCallback;
    uint          wDeviceID;
    const(wchar)* lpstrDeviceType;
    const(wchar)* lpstrElementName;
    const(wchar)* lpstrAlias;
    uint          dwStyle;
    HWND          hWndParent;
}

struct MCI_DGV_PASTE_PARMS
{
align (1):
    size_t dwCallback;
    uint   dwTo;
    RECT   rc;
    uint   dwAudioStream;
    uint   dwVideoStream;
}

struct MCI_DGV_QUALITY_PARMSA
{
align (1):
    size_t       dwCallback;
    uint         dwItem;
    const(char)* lpstrName;
    uint         lpstrAlgorithm;
    uint         dwHandle;
}

struct MCI_DGV_QUALITY_PARMSW
{
align (1):
    size_t        dwCallback;
    uint          dwItem;
    const(wchar)* lpstrName;
    uint          lpstrAlgorithm;
    uint          dwHandle;
}

struct MCI_DGV_RECORD_PARMS
{
align (1):
    size_t dwCallback;
    uint   dwFrom;
    uint   dwTo;
    RECT   rc;
    uint   dwAudioStream;
    uint   dwVideoStream;
}

struct MCI_DGV_RESERVE_PARMSA
{
align (1):
    size_t       dwCallback;
    const(char)* lpstrPath;
    uint         dwSize;
}

struct MCI_DGV_RESERVE_PARMSW
{
align (1):
    size_t        dwCallback;
    const(wchar)* lpstrPath;
    uint          dwSize;
}

struct MCI_DGV_RESTORE_PARMSA
{
align (1):
    size_t       dwCallback;
    const(char)* lpstrFileName;
    RECT         rc;
}

struct MCI_DGV_RESTORE_PARMSW
{
align (1):
    size_t        dwCallback;
    const(wchar)* lpstrFileName;
    RECT          rc;
}

struct MCI_DGV_SAVE_PARMSA
{
align (1):
    size_t       dwCallback;
    const(char)* lpstrFileName;
    RECT         rc;
}

struct MCI_DGV_SAVE_PARMSW
{
align (1):
    size_t        dwCallback;
    const(wchar)* lpstrFileName;
    RECT          rc;
}

struct MCI_DGV_SET_PARMS
{
align (1):
    size_t dwCallback;
    uint   dwTimeFormat;
    uint   dwAudio;
    uint   dwFileFormat;
    uint   dwSpeed;
}

struct MCI_DGV_SETAUDIO_PARMSA
{
align (1):
    size_t       dwCallback;
    uint         dwItem;
    uint         dwValue;
    uint         dwOver;
    const(char)* lpstrAlgorithm;
    const(char)* lpstrQuality;
}

struct MCI_DGV_SETAUDIO_PARMSW
{
align (1):
    size_t        dwCallback;
    uint          dwItem;
    uint          dwValue;
    uint          dwOver;
    const(wchar)* lpstrAlgorithm;
    const(wchar)* lpstrQuality;
}

struct MCI_DGV_SIGNAL_PARMS
{
align (1):
    size_t dwCallback;
    uint   dwPosition;
    uint   dwPeriod;
    uint   dwUserParm;
}

struct MCI_DGV_SETVIDEO_PARMSA
{
align (1):
    size_t       dwCallback;
    uint         dwItem;
    uint         dwValue;
    uint         dwOver;
    const(char)* lpstrAlgorithm;
    const(char)* lpstrQuality;
    uint         dwSourceNumber;
}

struct MCI_DGV_SETVIDEO_PARMSW
{
align (1):
    size_t        dwCallback;
    uint          dwItem;
    uint          dwValue;
    uint          dwOver;
    const(wchar)* lpstrAlgorithm;
    const(wchar)* lpstrQuality;
    uint          dwSourceNumber;
}

struct MCI_DGV_STATUS_PARMSA
{
align (1):
    size_t       dwCallback;
    size_t       dwReturn;
    uint         dwItem;
    uint         dwTrack;
    const(char)* lpstrDrive;
    uint         dwReference;
}

struct MCI_DGV_STATUS_PARMSW
{
align (1):
    size_t        dwCallback;
    size_t        dwReturn;
    uint          dwItem;
    uint          dwTrack;
    const(wchar)* lpstrDrive;
    uint          dwReference;
}

struct MCI_DGV_STEP_PARMS
{
align (1):
    size_t dwCallback;
    uint   dwFrames;
}

struct MCI_DGV_UPDATE_PARMS
{
align (1):
    size_t dwCallback;
    RECT   rc;
    HDC    hDC;
}

struct MCI_DGV_WINDOW_PARMSA
{
align (1):
    size_t       dwCallback;
    HWND         hWnd;
    uint         nCmdShow;
    const(char)* lpstrText;
}

struct MCI_DGV_WINDOW_PARMSW
{
align (1):
    size_t        dwCallback;
    HWND          hWnd;
    uint          nCmdShow;
    const(wchar)* lpstrText;
}

struct HACMDRIVERID__
{
align (1):
    int unused;
}

struct HACMDRIVER__
{
align (1):
    int unused;
}

struct HACMSTREAM__
{
align (1):
    int unused;
}

struct HACMOBJ__
{
align (1):
    int unused;
}

struct tACMDRIVERDETAILSA
{
align (1):
    uint      cbStruct;
    uint      fccType;
    uint      fccComp;
    ushort    wMid;
    ushort    wPid;
    uint      vdwACM;
    uint      vdwDriver;
    uint      fdwSupport;
    uint      cFormatTags;
    uint      cFilterTags;
    HICON     hicon;
    byte[32]  szShortName;
    byte[128] szLongName;
    byte[80]  szCopyright;
    byte[128] szLicensing;
    byte[512] szFeatures;
}

struct tACMDRIVERDETAILSW
{
align (1):
    uint        cbStruct;
    uint        fccType;
    uint        fccComp;
    ushort      wMid;
    ushort      wPid;
    uint        vdwACM;
    uint        vdwDriver;
    uint        fdwSupport;
    uint        cFormatTags;
    uint        cFilterTags;
    HICON       hicon;
    ushort[32]  szShortName;
    ushort[128] szLongName;
    ushort[80]  szCopyright;
    ushort[128] szLicensing;
    ushort[512] szFeatures;
}

struct tACMFORMATTAGDETAILSA
{
align (1):
    uint     cbStruct;
    uint     dwFormatTagIndex;
    uint     dwFormatTag;
    uint     cbFormatSize;
    uint     fdwSupport;
    uint     cStandardFormats;
    byte[48] szFormatTag;
}

struct tACMFORMATTAGDETAILSW
{
align (1):
    uint       cbStruct;
    uint       dwFormatTagIndex;
    uint       dwFormatTag;
    uint       cbFormatSize;
    uint       fdwSupport;
    uint       cStandardFormats;
    ushort[48] szFormatTag;
}

struct tACMFORMATDETAILSA
{
align (1):
    uint          cbStruct;
    uint          dwFormatIndex;
    uint          dwFormatTag;
    uint          fdwSupport;
    WAVEFORMATEX* pwfx;
    uint          cbwfx;
    byte[128]     szFormat;
}

struct tACMFORMATDETAILSW
{
align (1):
    uint          cbStruct;
    uint          dwFormatIndex;
    uint          dwFormatTag;
    uint          fdwSupport;
    WAVEFORMATEX* pwfx;
    uint          cbwfx;
    ushort[128]   szFormat;
}

struct tACMFORMATCHOOSEA
{
align (1):
    uint          cbStruct;
    uint          fdwStyle;
    HWND          hwndOwner;
    WAVEFORMATEX* pwfx;
    uint          cbwfx;
    const(char)*  pszTitle;
    byte[48]      szFormatTag;
    byte[128]     szFormat;
    const(char)*  pszName;
    uint          cchName;
    uint          fdwEnum;
    WAVEFORMATEX* pwfxEnum;
    HINSTANCE     hInstance;
    const(char)*  pszTemplateName;
    LPARAM        lCustData;
    ACMFORMATCHOOSEHOOKPROCA pfnHook;
}

struct tACMFORMATCHOOSEW
{
align (1):
    uint          cbStruct;
    uint          fdwStyle;
    HWND          hwndOwner;
    WAVEFORMATEX* pwfx;
    uint          cbwfx;
    const(wchar)* pszTitle;
    ushort[48]    szFormatTag;
    ushort[128]   szFormat;
    const(wchar)* pszName;
    uint          cchName;
    uint          fdwEnum;
    WAVEFORMATEX* pwfxEnum;
    HINSTANCE     hInstance;
    const(wchar)* pszTemplateName;
    LPARAM        lCustData;
    ACMFORMATCHOOSEHOOKPROCW pfnHook;
}

struct tACMFILTERTAGDETAILSA
{
align (1):
    uint     cbStruct;
    uint     dwFilterTagIndex;
    uint     dwFilterTag;
    uint     cbFilterSize;
    uint     fdwSupport;
    uint     cStandardFilters;
    byte[48] szFilterTag;
}

struct tACMFILTERTAGDETAILSW
{
align (1):
    uint       cbStruct;
    uint       dwFilterTagIndex;
    uint       dwFilterTag;
    uint       cbFilterSize;
    uint       fdwSupport;
    uint       cStandardFilters;
    ushort[48] szFilterTag;
}

struct tACMFILTERDETAILSA
{
align (1):
    uint        cbStruct;
    uint        dwFilterIndex;
    uint        dwFilterTag;
    uint        fdwSupport;
    WAVEFILTER* pwfltr;
    uint        cbwfltr;
    byte[128]   szFilter;
}

struct tACMFILTERDETAILSW
{
align (1):
    uint        cbStruct;
    uint        dwFilterIndex;
    uint        dwFilterTag;
    uint        fdwSupport;
    WAVEFILTER* pwfltr;
    uint        cbwfltr;
    ushort[128] szFilter;
}

struct tACMFILTERCHOOSEA
{
align (1):
    uint         cbStruct;
    uint         fdwStyle;
    HWND         hwndOwner;
    WAVEFILTER*  pwfltr;
    uint         cbwfltr;
    const(char)* pszTitle;
    byte[48]     szFilterTag;
    byte[128]    szFilter;
    const(char)* pszName;
    uint         cchName;
    uint         fdwEnum;
    WAVEFILTER*  pwfltrEnum;
    HINSTANCE    hInstance;
    const(char)* pszTemplateName;
    LPARAM       lCustData;
    ACMFILTERCHOOSEHOOKPROCA pfnHook;
}

struct tACMFILTERCHOOSEW
{
align (1):
    uint          cbStruct;
    uint          fdwStyle;
    HWND          hwndOwner;
    WAVEFILTER*   pwfltr;
    uint          cbwfltr;
    const(wchar)* pszTitle;
    ushort[48]    szFilterTag;
    ushort[128]   szFilter;
    const(wchar)* pszName;
    uint          cchName;
    uint          fdwEnum;
    WAVEFILTER*   pwfltrEnum;
    HINSTANCE     hInstance;
    const(wchar)* pszTemplateName;
    LPARAM        lCustData;
    ACMFILTERCHOOSEHOOKPROCW pfnHook;
}

struct ACMSTREAMHEADER
{
align (1):
    uint     cbStruct;
    uint     fdwStatus;
    size_t   dwUser;
    ubyte*   pbSrc;
    uint     cbSrcLength;
    uint     cbSrcLengthUsed;
    size_t   dwSrcUser;
    ubyte*   pbDst;
    uint     cbDstLength;
    uint     cbDstLengthUsed;
    size_t   dwDstUser;
    uint[10] dwReservedDriver;
}

struct HIC__
{
    int unused;
}

struct ICOPEN
{
    uint    dwSize;
    uint    fccType;
    uint    fccHandler;
    uint    dwVersion;
    uint    dwFlags;
    LRESULT dwError;
    void*   pV1Reserved;
    void*   pV2Reserved;
    uint    dnDevNode;
}

struct ICINFO
{
    uint        dwSize;
    uint        fccType;
    uint        fccHandler;
    uint        dwFlags;
    uint        dwVersion;
    uint        dwVersionICM;
    ushort[16]  szName;
    ushort[128] szDescription;
    ushort[128] szDriver;
}

struct ICCOMPRESS
{
    uint              dwFlags;
    BITMAPINFOHEADER* lpbiOutput;
    void*             lpOutput;
    BITMAPINFOHEADER* lpbiInput;
    void*             lpInput;
    uint*             lpckid;
    uint*             lpdwFlags;
    int               lFrameNum;
    uint              dwFrameSize;
    uint              dwQuality;
    BITMAPINFOHEADER* lpbiPrev;
    void*             lpPrev;
}

struct ICCOMPRESSFRAMES
{
    uint              dwFlags;
    BITMAPINFOHEADER* lpbiOutput;
    LPARAM            lOutput;
    BITMAPINFOHEADER* lpbiInput;
    LPARAM            lInput;
    int               lStartFrame;
    int               lFrameCount;
    int               lQuality;
    int               lDataRate;
    int               lKeyRate;
    uint              dwRate;
    uint              dwScale;
    uint              dwOverheadPerFrame;
    uint              dwReserved2;
    ptrdiff_t         GetData;
    ptrdiff_t         PutData;
}

struct ICSETSTATUSPROC
{
    uint      dwFlags;
    LPARAM    lParam;
    ptrdiff_t Status;
}

struct ICDECOMPRESS
{
    uint              dwFlags;
    BITMAPINFOHEADER* lpbiInput;
    void*             lpInput;
    BITMAPINFOHEADER* lpbiOutput;
    void*             lpOutput;
    uint              ckid;
}

struct ICDECOMPRESSEX
{
    uint              dwFlags;
    BITMAPINFOHEADER* lpbiSrc;
    void*             lpSrc;
    BITMAPINFOHEADER* lpbiDst;
    void*             lpDst;
    int               xDst;
    int               yDst;
    int               dxDst;
    int               dyDst;
    int               xSrc;
    int               ySrc;
    int               dxSrc;
    int               dySrc;
}

struct ICDRAWBEGIN
{
    uint              dwFlags;
    HPALETTE          hpal;
    HWND              hwnd;
    HDC               hdc;
    int               xDst;
    int               yDst;
    int               dxDst;
    int               dyDst;
    BITMAPINFOHEADER* lpbi;
    int               xSrc;
    int               ySrc;
    int               dxSrc;
    int               dySrc;
    uint              dwRate;
    uint              dwScale;
}

struct ICDRAW
{
    uint  dwFlags;
    void* lpFormat;
    void* lpData;
    uint  cbData;
    int   lTime;
}

struct ICDRAWSUGGEST
{
    BITMAPINFOHEADER* lpbiIn;
    BITMAPINFOHEADER* lpbiSuggest;
    int               dxSrc;
    int               dySrc;
    int               dxDst;
    int               dyDst;
    HIC__*            hicDecompressor;
}

struct ICPALETTE
{
    uint          dwFlags;
    int           iStart;
    int           iLen;
    PALETTEENTRY* lppe;
}

struct COMPVARS
{
    int         cbSize;
    uint        dwFlags;
    HIC__*      hic;
    uint        fccType;
    uint        fccHandler;
    BITMAPINFO* lpbiIn;
    BITMAPINFO* lpbiOut;
    void*       lpBitsOut;
    void*       lpBitsPrev;
    int         lFrame;
    int         lKey;
    int         lDataRate;
    int         lQ;
    int         lKeyCount;
    void*       lpState;
    int         cbState;
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
    uint       fccType;
    uint       fccHandler;
    uint       dwFlags;
    uint       dwCaps;
    ushort     wPriority;
    ushort     wLanguage;
    uint       dwScale;
    uint       dwRate;
    uint       dwStart;
    uint       dwLength;
    uint       dwInitialFrames;
    uint       dwSuggestedBufferSize;
    uint       dwQuality;
    uint       dwSampleSize;
    RECT       rcFrame;
    uint       dwEditCount;
    uint       dwFormatChangeCount;
    ushort[64] szName;
}

struct AVISTREAMINFOA
{
    uint     fccType;
    uint     fccHandler;
    uint     dwFlags;
    uint     dwCaps;
    ushort   wPriority;
    ushort   wLanguage;
    uint     dwScale;
    uint     dwRate;
    uint     dwStart;
    uint     dwLength;
    uint     dwInitialFrames;
    uint     dwSuggestedBufferSize;
    uint     dwQuality;
    uint     dwSampleSize;
    RECT     rcFrame;
    uint     dwEditCount;
    uint     dwFormatChangeCount;
    byte[64] szName;
}

struct AVIFILEINFOW
{
    uint       dwMaxBytesPerSec;
    uint       dwFlags;
    uint       dwCaps;
    uint       dwStreams;
    uint       dwSuggestedBufferSize;
    uint       dwWidth;
    uint       dwHeight;
    uint       dwScale;
    uint       dwRate;
    uint       dwLength;
    uint       dwEditCount;
    ushort[64] szFileType;
}

struct AVIFILEINFOA
{
    uint     dwMaxBytesPerSec;
    uint     dwFlags;
    uint     dwCaps;
    uint     dwStreams;
    uint     dwSuggestedBufferSize;
    uint     dwWidth;
    uint     dwHeight;
    uint     dwScale;
    uint     dwRate;
    uint     dwLength;
    uint     dwEditCount;
    byte[64] szFileType;
}

struct AVICOMPRESSOPTIONS
{
    uint  fccType;
    uint  fccHandler;
    uint  dwKeyFrameEvery;
    uint  dwQuality;
    uint  dwBytesPerSecond;
    uint  dwFlags;
    void* lpFormat;
    uint  cbFormat;
    void* lpParms;
    uint  cbParms;
    uint  dwInterleaveEvery;
}

struct HVIDEO__
{
    int unused;
}

struct VIDEOHDR
{
    ubyte*    lpData;
    uint      dwBufferLength;
    uint      dwBytesUsed;
    uint      dwTimeCaptured;
    size_t    dwUser;
    uint      dwFlags;
    size_t[4] dwReserved;
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
    uint   wDeviceIndex;
    BOOL   fHasOverlay;
    BOOL   fHasDlgVideoSource;
    BOOL   fHasDlgVideoFormat;
    BOOL   fHasDlgVideoDisplay;
    BOOL   fCaptureInitialized;
    BOOL   fDriverSuppliesPalettes;
    HANDLE hVideoIn;
    HANDLE hVideoOut;
    HANDLE hVideoExtIn;
    HANDLE hVideoExtOut;
}

struct CAPSTATUS
{
    uint     uiImageWidth;
    uint     uiImageHeight;
    BOOL     fLiveWindow;
    BOOL     fOverlayWindow;
    BOOL     fScale;
    POINT    ptScroll;
    BOOL     fUsingDefaultPalette;
    BOOL     fAudioHardware;
    BOOL     fCapFileExists;
    uint     dwCurrentVideoFrame;
    uint     dwCurrentVideoFramesDropped;
    uint     dwCurrentWaveSamples;
    uint     dwCurrentTimeElapsedMS;
    HPALETTE hPalCurrent;
    BOOL     fCapturingNow;
    uint     dwReturn;
    uint     wNumVideoAllocated;
    uint     wNumAudioAllocated;
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
    uint  fccInfoID;
    void* lpData;
    int   cbData;
}

struct DRVM_IOCTL_DATA
{
align (1):
    uint dwSize;
    uint dwCmd;
}

struct waveopendesc_tag
{
align (1):
    ptrdiff_t   hWave;
    WAVEFORMAT* lpFormat;
    size_t      dwCallback;
    size_t      dwInstance;
    uint        uMappedDeviceID;
    size_t      dnDevNode;
}

struct midiopenstrmid_tag
{
align (1):
    uint dwStreamID;
    uint uDeviceID;
}

struct tMIXEROPENDESC
{
align (1):
    ptrdiff_t hmx;
    void*     pReserved0;
    size_t    dwCallback;
    size_t    dwInstance;
    size_t    dnDevNode;
}

struct timerevent_tag
{
align (1):
    ushort         wDelay;
    ushort         wResolution;
    LPTIMECALLBACK lpFunction;
    uint           dwUser;
    ushort         wFlags;
    ushort         wReserved1;
}

struct joypos_tag
{
align (1):
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
align (1):
    uint         dwTimeOut;
    joyrange_tag jrvRanges;
    joypos_tag   jpDeadZone;
}

struct joyreghwsettings_tag
{
align (1):
    uint dwFlags;
    uint dwNumButtons;
}

struct joyreghwconfig_tag
{
align (1):
    joyreghwsettings_tag hws;
    uint                 dwUsageSettings;
    JOYREGHWVALUES       hwv;
    uint                 dwType;
    uint                 dwReserved;
}

struct joycalibrate_tag
{
align (1):
    ushort wXbase;
    ushort wXdelta;
    ushort wYbase;
    ushort wYdelta;
    ushort wZbase;
    ushort wZdelta;
}

struct MCI_OPEN_DRIVER_PARMS
{
align (1):
    uint          wDeviceID;
    const(wchar)* lpstrParams;
    uint          wCustomCommandTable;
    uint          wType;
}

// Functions

@DllImport("WINMM")
uint joyConfigChanged(uint dwFlags);

@DllImport("api-ms-win-mm-misc-l1-1-0")
LRESULT CloseDriver(ptrdiff_t hDriver, LPARAM lParam1, LPARAM lParam2);

@DllImport("api-ms-win-mm-misc-l1-1-0")
ptrdiff_t OpenDriver(const(wchar)* szDriverName, const(wchar)* szSectionName, LPARAM lParam2);

@DllImport("api-ms-win-mm-misc-l1-1-0")
LRESULT SendDriverMessage(ptrdiff_t hDriver, uint message, LPARAM lParam1, LPARAM lParam2);

@DllImport("api-ms-win-mm-misc-l1-1-0")
ptrdiff_t DrvGetModuleHandle(ptrdiff_t hDriver);

@DllImport("api-ms-win-mm-misc-l1-1-0")
ptrdiff_t GetDriverModuleHandle(ptrdiff_t hDriver);

@DllImport("api-ms-win-mm-misc-l1-1-0")
LRESULT DefDriverProc(size_t dwDriverIdentifier, ptrdiff_t hdrvr, uint uMsg, LPARAM lParam1, LPARAM lParam2);

@DllImport("api-ms-win-mm-misc-l1-1-0")
BOOL DriverCallback(size_t dwCallback, uint dwFlags, ptrdiff_t hDevice, uint dwMsg, size_t dwUser, size_t dwParam1, 
                    size_t dwParam2);

@DllImport("api-ms-win-mm-misc-l1-1-1")
int sndOpenSound(const(wchar)* EventName, const(wchar)* AppName, int Flags, ptrdiff_t* FileHandle);

@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmDrvInstall(ptrdiff_t hDriver, const(wchar)* wszDrvEntry, DRIVERMSGPROC drvMessage, uint wFlags);

@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioStringToFOURCCA(const(char)* sz, uint uFlags);

@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioStringToFOURCCW(const(wchar)* sz, uint uFlags);

@DllImport("api-ms-win-mm-misc-l1-1-0")
LPMMIOPROC mmioInstallIOProcA(uint fccIOProc, LPMMIOPROC pIOProc, uint dwFlags);

@DllImport("api-ms-win-mm-misc-l1-1-0")
LPMMIOPROC mmioInstallIOProcW(uint fccIOProc, LPMMIOPROC pIOProc, uint dwFlags);

@DllImport("api-ms-win-mm-misc-l1-1-0")
HMMIO__* mmioOpenA(const(char)* pszFileName, MMIOINFO* pmmioinfo, uint fdwOpen);

@DllImport("api-ms-win-mm-misc-l1-1-0")
HMMIO__* mmioOpenW(const(wchar)* pszFileName, MMIOINFO* pmmioinfo, uint fdwOpen);

@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioRenameA(const(char)* pszFileName, const(char)* pszNewFileName, MMIOINFO* pmmioinfo, uint fdwRename);

@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioRenameW(const(wchar)* pszFileName, const(wchar)* pszNewFileName, MMIOINFO* pmmioinfo, uint fdwRename);

@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioClose(HMMIO__* hmmio, uint fuClose);

@DllImport("api-ms-win-mm-misc-l1-1-0")
int mmioRead(HMMIO__* hmmio, char* pch, int cch);

@DllImport("api-ms-win-mm-misc-l1-1-0")
int mmioWrite(HMMIO__* hmmio, char* pch, int cch);

@DllImport("api-ms-win-mm-misc-l1-1-0")
int mmioSeek(HMMIO__* hmmio, int lOffset, int iOrigin);

@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioGetInfo(HMMIO__* hmmio, MMIOINFO* pmmioinfo, uint fuInfo);

@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioSetInfo(HMMIO__* hmmio, MMIOINFO* pmmioinfo, uint fuInfo);

@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioSetBuffer(HMMIO__* hmmio, const(char)* pchBuffer, int cchBuffer, uint fuBuffer);

@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioFlush(HMMIO__* hmmio, uint fuFlush);

@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioAdvance(HMMIO__* hmmio, MMIOINFO* pmmioinfo, uint fuAdvance);

@DllImport("api-ms-win-mm-misc-l1-1-0")
LRESULT mmioSendMessage(HMMIO__* hmmio, uint uMsg, LPARAM lParam1, LPARAM lParam2);

@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioDescend(HMMIO__* hmmio, MMCKINFO* pmmcki, const(MMCKINFO)* pmmckiParent, uint fuDescend);

@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioAscend(HMMIO__* hmmio, MMCKINFO* pmmcki, uint fuAscend);

@DllImport("api-ms-win-mm-misc-l1-1-0")
uint mmioCreateChunk(HMMIO__* hmmio, MMCKINFO* pmmcki, uint fuCreate);

@DllImport("WINMM")
BOOL sndPlaySoundA(const(char)* pszSound, uint fuSound);

@DllImport("WINMM")
BOOL sndPlaySoundW(const(wchar)* pszSound, uint fuSound);

@DllImport("WINMM")
BOOL PlaySoundA(const(char)* pszSound, ptrdiff_t hmod, uint fdwSound);

@DllImport("WINMM")
BOOL PlaySoundW(const(wchar)* pszSound, ptrdiff_t hmod, uint fdwSound);

@DllImport("WINMM")
uint waveOutGetNumDevs();

@DllImport("WINMM")
uint waveOutGetDevCapsA(size_t uDeviceID, WAVEOUTCAPSA* pwoc, uint cbwoc);

@DllImport("WINMM")
uint waveOutGetDevCapsW(size_t uDeviceID, WAVEOUTCAPSW* pwoc, uint cbwoc);

@DllImport("WINMM")
uint waveOutGetVolume(ptrdiff_t hwo, uint* pdwVolume);

@DllImport("WINMM")
uint waveOutSetVolume(ptrdiff_t hwo, uint dwVolume);

@DllImport("WINMM")
uint waveOutGetErrorTextA(uint mmrError, const(char)* pszText, uint cchText);

@DllImport("WINMM")
uint waveOutGetErrorTextW(uint mmrError, const(wchar)* pszText, uint cchText);

@DllImport("WINMM")
uint waveOutOpen(ptrdiff_t* phwo, uint uDeviceID, WAVEFORMATEX* pwfx, size_t dwCallback, size_t dwInstance, 
                 uint fdwOpen);

@DllImport("WINMM")
uint waveOutClose(ptrdiff_t hwo);

@DllImport("WINMM")
uint waveOutPrepareHeader(ptrdiff_t hwo, char* pwh, uint cbwh);

@DllImport("WINMM")
uint waveOutUnprepareHeader(ptrdiff_t hwo, char* pwh, uint cbwh);

@DllImport("WINMM")
uint waveOutWrite(ptrdiff_t hwo, char* pwh, uint cbwh);

@DllImport("WINMM")
uint waveOutPause(ptrdiff_t hwo);

@DllImport("WINMM")
uint waveOutRestart(ptrdiff_t hwo);

@DllImport("WINMM")
uint waveOutReset(ptrdiff_t hwo);

@DllImport("WINMM")
uint waveOutBreakLoop(ptrdiff_t hwo);

@DllImport("WINMM")
uint waveOutGetPosition(ptrdiff_t hwo, char* pmmt, uint cbmmt);

@DllImport("WINMM")
uint waveOutGetPitch(ptrdiff_t hwo, uint* pdwPitch);

@DllImport("WINMM")
uint waveOutSetPitch(ptrdiff_t hwo, uint dwPitch);

@DllImport("WINMM")
uint waveOutGetPlaybackRate(ptrdiff_t hwo, uint* pdwRate);

@DllImport("WINMM")
uint waveOutSetPlaybackRate(ptrdiff_t hwo, uint dwRate);

@DllImport("WINMM")
uint waveOutGetID(ptrdiff_t hwo, uint* puDeviceID);

@DllImport("WINMM")
uint waveOutMessage(ptrdiff_t hwo, uint uMsg, size_t dw1, size_t dw2);

@DllImport("WINMM")
uint waveInGetNumDevs();

@DllImport("WINMM")
uint waveInGetDevCapsA(size_t uDeviceID, char* pwic, uint cbwic);

@DllImport("WINMM")
uint waveInGetDevCapsW(size_t uDeviceID, char* pwic, uint cbwic);

@DllImport("WINMM")
uint waveInGetErrorTextA(uint mmrError, const(char)* pszText, uint cchText);

@DllImport("WINMM")
uint waveInGetErrorTextW(uint mmrError, const(wchar)* pszText, uint cchText);

@DllImport("WINMM")
uint waveInOpen(ptrdiff_t* phwi, uint uDeviceID, WAVEFORMATEX* pwfx, size_t dwCallback, size_t dwInstance, 
                uint fdwOpen);

@DllImport("WINMM")
uint waveInClose(ptrdiff_t hwi);

@DllImport("WINMM")
uint waveInPrepareHeader(ptrdiff_t hwi, char* pwh, uint cbwh);

@DllImport("WINMM")
uint waveInUnprepareHeader(ptrdiff_t hwi, char* pwh, uint cbwh);

@DllImport("WINMM")
uint waveInAddBuffer(ptrdiff_t hwi, char* pwh, uint cbwh);

@DllImport("WINMM")
uint waveInStart(ptrdiff_t hwi);

@DllImport("WINMM")
uint waveInStop(ptrdiff_t hwi);

@DllImport("WINMM")
uint waveInReset(ptrdiff_t hwi);

@DllImport("WINMM")
uint waveInGetPosition(ptrdiff_t hwi, char* pmmt, uint cbmmt);

@DllImport("WINMM")
uint waveInGetID(ptrdiff_t hwi, uint* puDeviceID);

@DllImport("WINMM")
uint waveInMessage(ptrdiff_t hwi, uint uMsg, size_t dw1, size_t dw2);

@DllImport("WINMM")
uint midiOutGetNumDevs();

@DllImport("WINMM")
uint midiStreamOpen(ptrdiff_t* phms, char* puDeviceID, uint cMidi, size_t dwCallback, size_t dwInstance, 
                    uint fdwOpen);

@DllImport("WINMM")
uint midiStreamClose(ptrdiff_t hms);

@DllImport("WINMM")
uint midiStreamProperty(ptrdiff_t hms, char* lppropdata, uint dwProperty);

@DllImport("WINMM")
uint midiStreamPosition(ptrdiff_t hms, char* lpmmt, uint cbmmt);

@DllImport("WINMM")
uint midiStreamOut(ptrdiff_t hms, char* pmh, uint cbmh);

@DllImport("WINMM")
uint midiStreamPause(ptrdiff_t hms);

@DllImport("WINMM")
uint midiStreamRestart(ptrdiff_t hms);

@DllImport("WINMM")
uint midiStreamStop(ptrdiff_t hms);

@DllImport("WINMM")
uint midiConnect(ptrdiff_t hmi, ptrdiff_t hmo, void* pReserved);

@DllImport("WINMM")
uint midiDisconnect(ptrdiff_t hmi, ptrdiff_t hmo, void* pReserved);

@DllImport("WINMM")
uint midiOutGetDevCapsA(size_t uDeviceID, char* pmoc, uint cbmoc);

@DllImport("WINMM")
uint midiOutGetDevCapsW(size_t uDeviceID, char* pmoc, uint cbmoc);

@DllImport("WINMM")
uint midiOutGetVolume(ptrdiff_t hmo, uint* pdwVolume);

@DllImport("WINMM")
uint midiOutSetVolume(ptrdiff_t hmo, uint dwVolume);

@DllImport("WINMM")
uint midiOutGetErrorTextA(uint mmrError, const(char)* pszText, uint cchText);

@DllImport("WINMM")
uint midiOutGetErrorTextW(uint mmrError, const(wchar)* pszText, uint cchText);

@DllImport("WINMM")
uint midiOutOpen(ptrdiff_t* phmo, uint uDeviceID, size_t dwCallback, size_t dwInstance, uint fdwOpen);

@DllImport("WINMM")
uint midiOutClose(ptrdiff_t hmo);

@DllImport("WINMM")
uint midiOutPrepareHeader(ptrdiff_t hmo, char* pmh, uint cbmh);

@DllImport("WINMM")
uint midiOutUnprepareHeader(ptrdiff_t hmo, char* pmh, uint cbmh);

@DllImport("WINMM")
uint midiOutShortMsg(ptrdiff_t hmo, uint dwMsg);

@DllImport("WINMM")
uint midiOutLongMsg(ptrdiff_t hmo, char* pmh, uint cbmh);

@DllImport("WINMM")
uint midiOutReset(ptrdiff_t hmo);

@DllImport("WINMM")
uint midiOutCachePatches(ptrdiff_t hmo, uint uBank, char* pwpa, uint fuCache);

@DllImport("WINMM")
uint midiOutCacheDrumPatches(ptrdiff_t hmo, uint uPatch, char* pwkya, uint fuCache);

@DllImport("WINMM")
uint midiOutGetID(ptrdiff_t hmo, uint* puDeviceID);

@DllImport("WINMM")
uint midiOutMessage(ptrdiff_t hmo, uint uMsg, size_t dw1, size_t dw2);

@DllImport("WINMM")
uint midiInGetNumDevs();

@DllImport("WINMM")
uint midiInGetDevCapsA(size_t uDeviceID, char* pmic, uint cbmic);

@DllImport("WINMM")
uint midiInGetDevCapsW(size_t uDeviceID, char* pmic, uint cbmic);

@DllImport("WINMM")
uint midiInGetErrorTextA(uint mmrError, const(char)* pszText, uint cchText);

@DllImport("WINMM")
uint midiInGetErrorTextW(uint mmrError, const(wchar)* pszText, uint cchText);

@DllImport("WINMM")
uint midiInOpen(ptrdiff_t* phmi, uint uDeviceID, size_t dwCallback, size_t dwInstance, uint fdwOpen);

@DllImport("WINMM")
uint midiInClose(ptrdiff_t hmi);

@DllImport("WINMM")
uint midiInPrepareHeader(ptrdiff_t hmi, char* pmh, uint cbmh);

@DllImport("WINMM")
uint midiInUnprepareHeader(ptrdiff_t hmi, char* pmh, uint cbmh);

@DllImport("WINMM")
uint midiInAddBuffer(ptrdiff_t hmi, char* pmh, uint cbmh);

@DllImport("WINMM")
uint midiInStart(ptrdiff_t hmi);

@DllImport("WINMM")
uint midiInStop(ptrdiff_t hmi);

@DllImport("WINMM")
uint midiInReset(ptrdiff_t hmi);

@DllImport("WINMM")
uint midiInGetID(ptrdiff_t hmi, uint* puDeviceID);

@DllImport("WINMM")
uint midiInMessage(ptrdiff_t hmi, uint uMsg, size_t dw1, size_t dw2);

@DllImport("WINMM")
uint auxGetNumDevs();

@DllImport("WINMM")
uint auxGetDevCapsA(size_t uDeviceID, char* pac, uint cbac);

@DllImport("WINMM")
uint auxGetDevCapsW(size_t uDeviceID, char* pac, uint cbac);

@DllImport("WINMM")
uint auxSetVolume(uint uDeviceID, uint dwVolume);

@DllImport("WINMM")
uint auxGetVolume(uint uDeviceID, uint* pdwVolume);

@DllImport("WINMM")
uint auxOutMessage(uint uDeviceID, uint uMsg, size_t dw1, size_t dw2);

@DllImport("WINMM")
uint mixerGetNumDevs();

@DllImport("WINMM")
uint mixerGetDevCapsA(size_t uMxId, char* pmxcaps, uint cbmxcaps);

@DllImport("WINMM")
uint mixerGetDevCapsW(size_t uMxId, char* pmxcaps, uint cbmxcaps);

@DllImport("WINMM")
uint mixerOpen(ptrdiff_t* phmx, uint uMxId, size_t dwCallback, size_t dwInstance, uint fdwOpen);

@DllImport("WINMM")
uint mixerClose(ptrdiff_t hmx);

@DllImport("WINMM")
uint mixerMessage(ptrdiff_t hmx, uint uMsg, size_t dwParam1, size_t dwParam2);

@DllImport("WINMM")
uint mixerGetLineInfoA(ptrdiff_t hmxobj, MIXERLINEA* pmxl, uint fdwInfo);

@DllImport("WINMM")
uint mixerGetLineInfoW(ptrdiff_t hmxobj, MIXERLINEW* pmxl, uint fdwInfo);

@DllImport("WINMM")
uint mixerGetID(ptrdiff_t hmxobj, uint* puMxId, uint fdwId);

@DllImport("WINMM")
uint mixerGetLineControlsA(ptrdiff_t hmxobj, MIXERLINECONTROLSA* pmxlc, uint fdwControls);

@DllImport("WINMM")
uint mixerGetLineControlsW(ptrdiff_t hmxobj, MIXERLINECONTROLSW* pmxlc, uint fdwControls);

@DllImport("WINMM")
uint mixerGetControlDetailsA(ptrdiff_t hmxobj, MIXERCONTROLDETAILS* pmxcd, uint fdwDetails);

@DllImport("WINMM")
uint mixerGetControlDetailsW(ptrdiff_t hmxobj, MIXERCONTROLDETAILS* pmxcd, uint fdwDetails);

@DllImport("WINMM")
uint mixerSetControlDetails(ptrdiff_t hmxobj, MIXERCONTROLDETAILS* pmxcd, uint fdwDetails);

@DllImport("WINMM")
uint timeGetSystemTime(char* pmmt, uint cbmmt);

@DllImport("WINMM")
uint timeGetTime();

@DllImport("WINMM")
uint timeGetDevCaps(char* ptc, uint cbtc);

@DllImport("WINMM")
uint timeBeginPeriod(uint uPeriod);

@DllImport("WINMM")
uint timeEndPeriod(uint uPeriod);

@DllImport("WINMM")
uint joyGetPosEx(uint uJoyID, JOYINFOEX* pji);

@DllImport("WINMM")
uint joyGetNumDevs();

@DllImport("WINMM")
uint joyGetDevCapsA(size_t uJoyID, char* pjc, uint cbjc);

@DllImport("WINMM")
uint joyGetDevCapsW(size_t uJoyID, char* pjc, uint cbjc);

@DllImport("WINMM")
uint joyGetPos(uint uJoyID, JOYINFO* pji);

@DllImport("WINMM")
uint joyGetThreshold(uint uJoyID, uint* puThreshold);

@DllImport("WINMM")
uint joyReleaseCapture(uint uJoyID);

@DllImport("WINMM")
uint joySetCapture(HWND hwnd, uint uJoyID, uint uPeriod, BOOL fChanged);

@DllImport("WINMM")
uint joySetThreshold(uint uJoyID, uint uThreshold);

@DllImport("MSACM32")
uint acmGetVersion();

@DllImport("MSACM32")
uint acmMetrics(HACMOBJ__* hao, uint uMetric, void* pMetric);

@DllImport("MSACM32")
uint acmDriverEnum(ACMDRIVERENUMCB fnCallback, size_t dwInstance, uint fdwEnum);

@DllImport("MSACM32")
uint acmDriverID(HACMOBJ__* hao, HACMDRIVERID__** phadid, uint fdwDriverID);

@DllImport("MSACM32")
uint acmDriverAddA(HACMDRIVERID__** phadid, HINSTANCE hinstModule, LPARAM lParam, uint dwPriority, uint fdwAdd);

@DllImport("MSACM32")
uint acmDriverAddW(HACMDRIVERID__** phadid, HINSTANCE hinstModule, LPARAM lParam, uint dwPriority, uint fdwAdd);

@DllImport("MSACM32")
uint acmDriverRemove(HACMDRIVERID__* hadid, uint fdwRemove);

@DllImport("MSACM32")
uint acmDriverOpen(HACMDRIVER__** phad, HACMDRIVERID__* hadid, uint fdwOpen);

@DllImport("MSACM32")
uint acmDriverClose(HACMDRIVER__* had, uint fdwClose);

@DllImport("MSACM32")
LRESULT acmDriverMessage(HACMDRIVER__* had, uint uMsg, LPARAM lParam1, LPARAM lParam2);

@DllImport("MSACM32")
uint acmDriverPriority(HACMDRIVERID__* hadid, uint dwPriority, uint fdwPriority);

@DllImport("MSACM32")
uint acmDriverDetailsA(HACMDRIVERID__* hadid, tACMDRIVERDETAILSA* padd, uint fdwDetails);

@DllImport("MSACM32")
uint acmDriverDetailsW(HACMDRIVERID__* hadid, tACMDRIVERDETAILSW* padd, uint fdwDetails);

@DllImport("MSACM32")
uint acmFormatTagDetailsA(HACMDRIVER__* had, tACMFORMATTAGDETAILSA* paftd, uint fdwDetails);

@DllImport("MSACM32")
uint acmFormatTagDetailsW(HACMDRIVER__* had, tACMFORMATTAGDETAILSW* paftd, uint fdwDetails);

@DllImport("MSACM32")
uint acmFormatTagEnumA(HACMDRIVER__* had, tACMFORMATTAGDETAILSA* paftd, ACMFORMATTAGENUMCBA fnCallback, 
                       size_t dwInstance, uint fdwEnum);

@DllImport("MSACM32")
uint acmFormatTagEnumW(HACMDRIVER__* had, tACMFORMATTAGDETAILSW* paftd, ACMFORMATTAGENUMCBW fnCallback, 
                       size_t dwInstance, uint fdwEnum);

@DllImport("MSACM32")
uint acmFormatDetailsA(HACMDRIVER__* had, tACMFORMATDETAILSA* pafd, uint fdwDetails);

@DllImport("MSACM32")
uint acmFormatDetailsW(HACMDRIVER__* had, tACMFORMATDETAILSW* pafd, uint fdwDetails);

@DllImport("MSACM32")
uint acmFormatEnumA(HACMDRIVER__* had, tACMFORMATDETAILSA* pafd, ACMFORMATENUMCBA fnCallback, size_t dwInstance, 
                    uint fdwEnum);

@DllImport("MSACM32")
uint acmFormatEnumW(HACMDRIVER__* had, tACMFORMATDETAILSW* pafd, ACMFORMATENUMCBW fnCallback, size_t dwInstance, 
                    uint fdwEnum);

@DllImport("MSACM32")
uint acmFormatSuggest(HACMDRIVER__* had, WAVEFORMATEX* pwfxSrc, WAVEFORMATEX* pwfxDst, uint cbwfxDst, 
                      uint fdwSuggest);

@DllImport("MSACM32")
uint acmFormatChooseA(tACMFORMATCHOOSEA* pafmtc);

@DllImport("MSACM32")
uint acmFormatChooseW(tACMFORMATCHOOSEW* pafmtc);

@DllImport("MSACM32")
uint acmFilterTagDetailsA(HACMDRIVER__* had, tACMFILTERTAGDETAILSA* paftd, uint fdwDetails);

@DllImport("MSACM32")
uint acmFilterTagDetailsW(HACMDRIVER__* had, tACMFILTERTAGDETAILSW* paftd, uint fdwDetails);

@DllImport("MSACM32")
uint acmFilterTagEnumA(HACMDRIVER__* had, tACMFILTERTAGDETAILSA* paftd, ACMFILTERTAGENUMCBA fnCallback, 
                       size_t dwInstance, uint fdwEnum);

@DllImport("MSACM32")
uint acmFilterTagEnumW(HACMDRIVER__* had, tACMFILTERTAGDETAILSW* paftd, ACMFILTERTAGENUMCBW fnCallback, 
                       size_t dwInstance, uint fdwEnum);

@DllImport("MSACM32")
uint acmFilterDetailsA(HACMDRIVER__* had, tACMFILTERDETAILSA* pafd, uint fdwDetails);

@DllImport("MSACM32")
uint acmFilterDetailsW(HACMDRIVER__* had, tACMFILTERDETAILSW* pafd, uint fdwDetails);

@DllImport("MSACM32")
uint acmFilterEnumA(HACMDRIVER__* had, tACMFILTERDETAILSA* pafd, ACMFILTERENUMCBA fnCallback, size_t dwInstance, 
                    uint fdwEnum);

@DllImport("MSACM32")
uint acmFilterEnumW(HACMDRIVER__* had, tACMFILTERDETAILSW* pafd, ACMFILTERENUMCBW fnCallback, size_t dwInstance, 
                    uint fdwEnum);

@DllImport("MSACM32")
uint acmFilterChooseA(tACMFILTERCHOOSEA* pafltrc);

@DllImport("MSACM32")
uint acmFilterChooseW(tACMFILTERCHOOSEW* pafltrc);

@DllImport("MSACM32")
uint acmStreamOpen(HACMSTREAM__** phas, HACMDRIVER__* had, WAVEFORMATEX* pwfxSrc, WAVEFORMATEX* pwfxDst, 
                   WAVEFILTER* pwfltr, size_t dwCallback, size_t dwInstance, uint fdwOpen);

@DllImport("MSACM32")
uint acmStreamClose(HACMSTREAM__* has, uint fdwClose);

@DllImport("MSACM32")
uint acmStreamSize(HACMSTREAM__* has, uint cbInput, uint* pdwOutputBytes, uint fdwSize);

@DllImport("MSACM32")
uint acmStreamReset(HACMSTREAM__* has, uint fdwReset);

@DllImport("MSACM32")
uint acmStreamMessage(HACMSTREAM__* has, uint uMsg, LPARAM lParam1, LPARAM lParam2);

@DllImport("MSACM32")
uint acmStreamConvert(HACMSTREAM__* has, ACMSTREAMHEADER* pash, uint fdwConvert);

@DllImport("MSACM32")
uint acmStreamPrepareHeader(HACMSTREAM__* has, ACMSTREAMHEADER* pash, uint fdwPrepare);

@DllImport("MSACM32")
uint acmStreamUnprepareHeader(HACMSTREAM__* has, ACMSTREAMHEADER* pash, uint fdwUnprepare);

@DllImport("MSVFW32")
uint VideoForWindowsVersion();

@DllImport("MSVFW32")
BOOL ICInfo(uint fccType, uint fccHandler, ICINFO* lpicinfo);

@DllImport("MSVFW32")
BOOL ICInstall(uint fccType, uint fccHandler, LPARAM lParam, const(char)* szDesc, uint wFlags);

@DllImport("MSVFW32")
BOOL ICRemove(uint fccType, uint fccHandler, uint wFlags);

@DllImport("MSVFW32")
LRESULT ICGetInfo(HIC__* hic, char* picinfo, uint cb);

@DllImport("MSVFW32")
HIC__* ICOpen(uint fccType, uint fccHandler, uint wMode);

@DllImport("MSVFW32")
HIC__* ICOpenFunction(uint fccType, uint fccHandler, uint wMode, FARPROC lpfnHandler);

@DllImport("MSVFW32")
LRESULT ICClose(HIC__* hic);

@DllImport("MSVFW32")
LRESULT ICSendMessage(HIC__* hic, uint msg, size_t dw1, size_t dw2);

@DllImport("MSVFW32")
uint ICCompress(HIC__* hic, uint dwFlags, BITMAPINFOHEADER* lpbiOutput, char* lpData, BITMAPINFOHEADER* lpbiInput, 
                char* lpBits, uint* lpckid, uint* lpdwFlags, int lFrameNum, uint dwFrameSize, uint dwQuality, 
                BITMAPINFOHEADER* lpbiPrev, char* lpPrev);

@DllImport("MSVFW32")
uint ICDecompress(HIC__* hic, uint dwFlags, BITMAPINFOHEADER* lpbiFormat, char* lpData, BITMAPINFOHEADER* lpbi, 
                  char* lpBits);

@DllImport("MSVFW32")
uint ICDrawBegin(HIC__* hic, uint dwFlags, HPALETTE hpal, HWND hwnd, HDC hdc, int xDst, int yDst, int dxDst, 
                 int dyDst, BITMAPINFOHEADER* lpbi, int xSrc, int ySrc, int dxSrc, int dySrc, uint dwRate, 
                 uint dwScale);

@DllImport("MSVFW32")
uint ICDraw(HIC__* hic, uint dwFlags, void* lpFormat, char* lpData, uint cbData, int lTime);

@DllImport("MSVFW32")
HIC__* ICLocate(uint fccType, uint fccHandler, BITMAPINFOHEADER* lpbiIn, BITMAPINFOHEADER* lpbiOut, ushort wFlags);

@DllImport("MSVFW32")
HIC__* ICGetDisplayFormat(HIC__* hic, BITMAPINFOHEADER* lpbiIn, BITMAPINFOHEADER* lpbiOut, int BitDepth, int dx, 
                          int dy);

@DllImport("MSVFW32")
HANDLE ICImageCompress(HIC__* hic, uint uiFlags, BITMAPINFO* lpbiIn, void* lpBits, BITMAPINFO* lpbiOut, 
                       int lQuality, int* plSize);

@DllImport("MSVFW32")
HANDLE ICImageDecompress(HIC__* hic, uint uiFlags, BITMAPINFO* lpbiIn, void* lpBits, BITMAPINFO* lpbiOut);

@DllImport("MSVFW32")
BOOL ICCompressorChoose(HWND hwnd, uint uiFlags, void* pvIn, void* lpData, COMPVARS* pc, const(char)* lpszTitle);

@DllImport("MSVFW32")
BOOL ICSeqCompressFrameStart(COMPVARS* pc, BITMAPINFO* lpbiIn);

@DllImport("MSVFW32")
void ICSeqCompressFrameEnd(COMPVARS* pc);

@DllImport("MSVFW32")
void* ICSeqCompressFrame(COMPVARS* pc, uint uiFlags, void* lpBits, int* pfKey, int* plSize);

@DllImport("MSVFW32")
void ICCompressorFree(COMPVARS* pc);

@DllImport("MSVFW32")
ptrdiff_t DrawDibOpen();

@DllImport("MSVFW32")
BOOL DrawDibClose(ptrdiff_t hdd);

@DllImport("MSVFW32")
void* DrawDibGetBuffer(ptrdiff_t hdd, BITMAPINFOHEADER* lpbi, uint dwSize, uint dwFlags);

@DllImport("MSVFW32")
HPALETTE DrawDibGetPalette(ptrdiff_t hdd);

@DllImport("MSVFW32")
BOOL DrawDibSetPalette(ptrdiff_t hdd, HPALETTE hpal);

@DllImport("MSVFW32")
BOOL DrawDibChangePalette(ptrdiff_t hdd, int iStart, int iLen, char* lppe);

@DllImport("MSVFW32")
uint DrawDibRealize(ptrdiff_t hdd, HDC hdc, BOOL fBackground);

@DllImport("MSVFW32")
BOOL DrawDibStart(ptrdiff_t hdd, uint rate);

@DllImport("MSVFW32")
BOOL DrawDibStop(ptrdiff_t hdd);

@DllImport("MSVFW32")
BOOL DrawDibBegin(ptrdiff_t hdd, HDC hdc, int dxDst, int dyDst, BITMAPINFOHEADER* lpbi, int dxSrc, int dySrc, 
                  uint wFlags);

@DllImport("MSVFW32")
BOOL DrawDibDraw(ptrdiff_t hdd, HDC hdc, int xDst, int yDst, int dxDst, int dyDst, BITMAPINFOHEADER* lpbi, 
                 void* lpBits, int xSrc, int ySrc, int dxSrc, int dySrc, uint wFlags);

@DllImport("MSVFW32")
BOOL DrawDibEnd(ptrdiff_t hdd);

@DllImport("MSVFW32")
BOOL DrawDibTime(ptrdiff_t hdd, DRAWDIBTIME* lpddtime);

@DllImport("MSVFW32")
LRESULT DrawDibProfileDisplay(BITMAPINFOHEADER* lpbi);

@DllImport("AVIFIL32")
void AVIFileInit();

@DllImport("AVIFIL32")
void AVIFileExit();

@DllImport("AVIFIL32")
uint AVIFileAddRef(IAVIFile pfile);

@DllImport("AVIFIL32")
uint AVIFileRelease(IAVIFile pfile);

@DllImport("AVIFIL32")
HRESULT AVIFileOpenA(IAVIFile* ppfile, const(char)* szFile, uint uMode, GUID* lpHandler);

@DllImport("AVIFIL32")
HRESULT AVIFileOpenW(IAVIFile* ppfile, const(wchar)* szFile, uint uMode, GUID* lpHandler);

@DllImport("AVIFIL32")
HRESULT AVIFileInfoW(IAVIFile pfile, char* pfi, int lSize);

@DllImport("AVIFIL32")
HRESULT AVIFileInfoA(IAVIFile pfile, char* pfi, int lSize);

@DllImport("AVIFIL32")
HRESULT AVIFileGetStream(IAVIFile pfile, IAVIStream* ppavi, uint fccType, int lParam);

@DllImport("AVIFIL32")
HRESULT AVIFileCreateStreamW(IAVIFile pfile, IAVIStream* ppavi, AVISTREAMINFOW* psi);

@DllImport("AVIFIL32")
HRESULT AVIFileCreateStreamA(IAVIFile pfile, IAVIStream* ppavi, AVISTREAMINFOA* psi);

@DllImport("AVIFIL32")
HRESULT AVIFileWriteData(IAVIFile pfile, uint ckid, char* lpData, int cbData);

@DllImport("AVIFIL32")
HRESULT AVIFileReadData(IAVIFile pfile, uint ckid, char* lpData, int* lpcbData);

@DllImport("AVIFIL32")
HRESULT AVIFileEndRecord(IAVIFile pfile);

@DllImport("AVIFIL32")
uint AVIStreamAddRef(IAVIStream pavi);

@DllImport("AVIFIL32")
uint AVIStreamRelease(IAVIStream pavi);

@DllImport("AVIFIL32")
HRESULT AVIStreamInfoW(IAVIStream pavi, char* psi, int lSize);

@DllImport("AVIFIL32")
HRESULT AVIStreamInfoA(IAVIStream pavi, char* psi, int lSize);

@DllImport("AVIFIL32")
int AVIStreamFindSample(IAVIStream pavi, int lPos, int lFlags);

@DllImport("AVIFIL32")
HRESULT AVIStreamReadFormat(IAVIStream pavi, int lPos, char* lpFormat, int* lpcbFormat);

@DllImport("AVIFIL32")
HRESULT AVIStreamSetFormat(IAVIStream pavi, int lPos, char* lpFormat, int cbFormat);

@DllImport("AVIFIL32")
HRESULT AVIStreamReadData(IAVIStream pavi, uint fcc, char* lp, int* lpcb);

@DllImport("AVIFIL32")
HRESULT AVIStreamWriteData(IAVIStream pavi, uint fcc, char* lp, int cb);

@DllImport("AVIFIL32")
HRESULT AVIStreamRead(IAVIStream pavi, int lStart, int lSamples, char* lpBuffer, int cbBuffer, int* plBytes, 
                      int* plSamples);

@DllImport("AVIFIL32")
HRESULT AVIStreamWrite(IAVIStream pavi, int lStart, int lSamples, char* lpBuffer, int cbBuffer, uint dwFlags, 
                       int* plSampWritten, int* plBytesWritten);

@DllImport("AVIFIL32")
int AVIStreamStart(IAVIStream pavi);

@DllImport("AVIFIL32")
int AVIStreamLength(IAVIStream pavi);

@DllImport("AVIFIL32")
int AVIStreamTimeToSample(IAVIStream pavi, int lTime);

@DllImport("AVIFIL32")
int AVIStreamSampleToTime(IAVIStream pavi, int lSample);

@DllImport("AVIFIL32")
HRESULT AVIStreamBeginStreaming(IAVIStream pavi, int lStart, int lEnd, int lRate);

@DllImport("AVIFIL32")
HRESULT AVIStreamEndStreaming(IAVIStream pavi);

@DllImport("AVIFIL32")
IGetFrame AVIStreamGetFrameOpen(IAVIStream pavi, BITMAPINFOHEADER* lpbiWanted);

@DllImport("AVIFIL32")
void* AVIStreamGetFrame(IGetFrame pg, int lPos);

@DllImport("AVIFIL32")
HRESULT AVIStreamGetFrameClose(IGetFrame pg);

@DllImport("AVIFIL32")
HRESULT AVIStreamOpenFromFileA(IAVIStream* ppavi, const(char)* szFile, uint fccType, int lParam, uint mode, 
                               GUID* pclsidHandler);

@DllImport("AVIFIL32")
HRESULT AVIStreamOpenFromFileW(IAVIStream* ppavi, const(wchar)* szFile, uint fccType, int lParam, uint mode, 
                               GUID* pclsidHandler);

@DllImport("AVIFIL32")
HRESULT AVIStreamCreate(IAVIStream* ppavi, int lParam1, int lParam2, GUID* pclsidHandler);

@DllImport("AVIFIL32")
HRESULT AVIMakeCompressedStream(IAVIStream* ppsCompressed, IAVIStream ppsSource, AVICOMPRESSOPTIONS* lpOptions, 
                                GUID* pclsidHandler);

@DllImport("AVIFIL32")
HRESULT AVISaveA(const(char)* szFile, GUID* pclsidHandler, AVISAVECALLBACK lpfnCallback, int nStreams, 
                 IAVIStream pfile, AVICOMPRESSOPTIONS* lpOptions);

@DllImport("AVIFIL32")
HRESULT AVISaveVA(const(char)* szFile, GUID* pclsidHandler, AVISAVECALLBACK lpfnCallback, int nStreams, 
                  char* ppavi, char* plpOptions);

@DllImport("AVIFIL32")
HRESULT AVISaveW(const(wchar)* szFile, GUID* pclsidHandler, AVISAVECALLBACK lpfnCallback, int nStreams, 
                 IAVIStream pfile, AVICOMPRESSOPTIONS* lpOptions);

@DllImport("AVIFIL32")
HRESULT AVISaveVW(const(wchar)* szFile, GUID* pclsidHandler, AVISAVECALLBACK lpfnCallback, int nStreams, 
                  char* ppavi, char* plpOptions);

@DllImport("AVIFIL32")
ptrdiff_t AVISaveOptions(HWND hwnd, uint uiFlags, int nStreams, char* ppavi, char* plpOptions);

@DllImport("AVIFIL32")
HRESULT AVISaveOptionsFree(int nStreams, char* plpOptions);

@DllImport("AVIFIL32")
HRESULT AVIBuildFilterW(const(wchar)* lpszFilter, int cbFilter, BOOL fSaving);

@DllImport("AVIFIL32")
HRESULT AVIBuildFilterA(const(char)* lpszFilter, int cbFilter, BOOL fSaving);

@DllImport("AVIFIL32")
HRESULT AVIMakeFileFromStreams(IAVIFile* ppfile, int nStreams, char* papStreams);

@DllImport("AVIFIL32")
HRESULT AVIMakeStreamFromClipboard(uint cfFormat, HANDLE hGlobal, IAVIStream* ppstream);

@DllImport("AVIFIL32")
HRESULT AVIPutFileOnClipboard(IAVIFile pf);

@DllImport("AVIFIL32")
HRESULT AVIGetFromClipboard(IAVIFile* lppf);

@DllImport("AVIFIL32")
HRESULT AVIClearClipboard();

@DllImport("AVIFIL32")
HRESULT CreateEditableStream(IAVIStream* ppsEditable, IAVIStream psSource);

@DllImport("AVIFIL32")
HRESULT EditStreamCut(IAVIStream pavi, int* plStart, int* plLength, IAVIStream* ppResult);

@DllImport("AVIFIL32")
HRESULT EditStreamCopy(IAVIStream pavi, int* plStart, int* plLength, IAVIStream* ppResult);

@DllImport("AVIFIL32")
HRESULT EditStreamPaste(IAVIStream pavi, int* plPos, int* plLength, IAVIStream pstream, int lStart, int lEnd);

@DllImport("AVIFIL32")
HRESULT EditStreamClone(IAVIStream pavi, IAVIStream* ppResult);

@DllImport("AVIFIL32")
HRESULT EditStreamSetNameA(IAVIStream pavi, const(char)* lpszName);

@DllImport("AVIFIL32")
HRESULT EditStreamSetNameW(IAVIStream pavi, const(wchar)* lpszName);

@DllImport("AVIFIL32")
HRESULT EditStreamSetInfoW(IAVIStream pavi, char* lpInfo, int cbInfo);

@DllImport("AVIFIL32")
HRESULT EditStreamSetInfoA(IAVIStream pavi, char* lpInfo, int cbInfo);

@DllImport("MSVFW32")
HWND MCIWndCreateA(HWND hwndParent, HINSTANCE hInstance, uint dwStyle, const(char)* szFile);

@DllImport("MSVFW32")
HWND MCIWndCreateW(HWND hwndParent, HINSTANCE hInstance, uint dwStyle, const(wchar)* szFile);

@DllImport("MSVFW32")
BOOL MCIWndRegisterClass();

@DllImport("AVICAP32")
HWND capCreateCaptureWindowA(const(char)* lpszWindowName, uint dwStyle, int x, int y, int nWidth, int nHeight, 
                             HWND hwndParent, int nID);

@DllImport("AVICAP32")
BOOL capGetDriverDescriptionA(uint wDriverIndex, const(char)* lpszName, int cbName, const(char)* lpszVer, 
                              int cbVer);

@DllImport("AVICAP32")
HWND capCreateCaptureWindowW(const(wchar)* lpszWindowName, uint dwStyle, int x, int y, int nWidth, int nHeight, 
                             HWND hwndParent, int nID);

@DllImport("AVICAP32")
BOOL capGetDriverDescriptionW(uint wDriverIndex, const(wchar)* lpszName, int cbName, const(wchar)* lpszVer, 
                              int cbVer);

@DllImport("MSVFW32")
BOOL GetOpenFileNamePreviewA(OPENFILENAMEA* lpofn);

@DllImport("MSVFW32")
BOOL GetSaveFileNamePreviewA(OPENFILENAMEA* lpofn);

@DllImport("MSVFW32")
BOOL GetOpenFileNamePreviewW(OPENFILENAMEW* lpofn);

@DllImport("MSVFW32")
BOOL GetSaveFileNamePreviewW(OPENFILENAMEW* lpofn);

@DllImport("WINMM")
uint mmTaskCreate(LPTASKCALLBACK lpfn, HANDLE* lph, size_t dwInst);

@DllImport("WINMM")
void mmTaskBlock(uint h);

@DllImport("WINMM")
BOOL mmTaskSignal(uint h);

@DllImport("WINMM")
void mmTaskYield();

@DllImport("WINMM")
uint mmGetCurrentTask();


// Interfaces

@GUID("00000001-0000-0010-8000-00AA00389B71")
struct KSDATAFORMAT_SUBTYPE_PCM;

@GUID("00000003-0000-0010-8000-00AA00389B71")
struct KSDATAFORMAT_SUBTYPE_IEEE_FLOAT;

@GUID("00000000-0000-0010-8000-00AA00389B71")
struct KSDATAFORMAT_SUBTYPE_WAVEFORMATEX;

interface IAVIStream : IUnknown
{
    HRESULT Create(LPARAM lParam1, LPARAM lParam2);
    HRESULT Info(char* psi, int lSize);
    int     FindSample(int lPos, int lFlags);
    HRESULT ReadFormat(int lPos, char* lpFormat, int* lpcbFormat);
    HRESULT SetFormat(int lPos, char* lpFormat, int cbFormat);
    HRESULT Read(int lStart, int lSamples, char* lpBuffer, int cbBuffer, int* plBytes, int* plSamples);
    HRESULT Write(int lStart, int lSamples, char* lpBuffer, int cbBuffer, uint dwFlags, int* plSampWritten, 
                  int* plBytesWritten);
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
    void*   GetFrame(int lPos);
    HRESULT Begin(int lStart, int lEnd, int lRate);
    HRESULT End();
    HRESULT SetFormat(BITMAPINFOHEADER* lpbi, void* lpBits, int x, int y, int dx, int dy);
}


// GUIDs

const GUID CLSID_KSDATAFORMAT_SUBTYPE_IEEE_FLOAT   = GUIDOF!KSDATAFORMAT_SUBTYPE_IEEE_FLOAT;
const GUID CLSID_KSDATAFORMAT_SUBTYPE_PCM          = GUIDOF!KSDATAFORMAT_SUBTYPE_PCM;
const GUID CLSID_KSDATAFORMAT_SUBTYPE_WAVEFORMATEX = GUIDOF!KSDATAFORMAT_SUBTYPE_WAVEFORMATEX;

