// Written in the D programming language.

module windows.win32.devices.communication;

public import windows.core;
public import windows.win32.foundation : BOOL, CHAR, HANDLE, HWND, PSTR, PWSTR;
public import windows.win32.system.io : OVERLAPPED;

extern(Windows) @nogc nothrow:


// Enums


alias MODEM_STATUS_FLAGS = uint;
enum : uint
{
    MS_CTS_ON  = 0x00000010U,
    MS_DSR_ON  = 0x00000020U,
    MS_RING_ON = 0x00000040U,
    MS_RLSD_ON = 0x00000080U,
}

alias CLEAR_COMM_ERROR_FLAGS = uint;
enum : uint
{
    CE_BREAK    = 0x00000010U,
    CE_FRAME    = 0x00000008U,
    CE_OVERRUN  = 0x00000002U,
    CE_RXOVER   = 0x00000001U,
    CE_RXPARITY = 0x00000004U,
}

alias PURGE_COMM_FLAGS = uint;
enum : uint
{
    PURGE_RXABORT = 0x00000002U,
    PURGE_RXCLEAR = 0x00000008U,
    PURGE_TXABORT = 0x00000001U,
    PURGE_TXCLEAR = 0x00000004U,
}

alias COMM_EVENT_MASK = uint;
enum : uint
{
    EV_BREAK    = 0x00000040U,
    EV_CTS      = 0x00000008U,
    EV_DSR      = 0x00000010U,
    EV_ERR      = 0x00000080U,
    EV_EVENT1   = 0x00000800U,
    EV_EVENT2   = 0x00001000U,
    EV_PERR     = 0x00000200U,
    EV_RING     = 0x00000100U,
    EV_RLSD     = 0x00000020U,
    EV_RX80FULL = 0x00000400U,
    EV_RXCHAR   = 0x00000001U,
    EV_RXFLAG   = 0x00000002U,
    EV_TXEMPTY  = 0x00000004U,
}

alias ESCAPE_COMM_FUNCTION = uint;
enum : uint
{
    CLRBREAK = 0x00000009U,
    CLRDTR   = 0x00000006U,
    CLRRTS   = 0x00000004U,
    SETBREAK = 0x00000008U,
    SETDTR   = 0x00000005U,
    SETRTS   = 0x00000003U,
    SETXOFF  = 0x00000001U,
    SETXON   = 0x00000002U,
}

alias MODEMDEVCAPS_DIAL_OPTIONS = uint;
enum : uint
{
    DIALOPTION_BILLING  = 0x00000040U,
    DIALOPTION_DIALTONE = 0x00000100U,
    DIALOPTION_QUIET    = 0x00000080U,
}

alias MODEMSETTINGS_SPEAKER_MODE = uint;
enum : uint
{
    MDMSPKR_CALLSETUP = 0x00000008U,
    MDMSPKR_DIAL      = 0x00000002U,
    MDMSPKR_OFF       = 0x00000001U,
    MDMSPKR_ON        = 0x00000004U,
}

alias COMMPROP_STOP_PARITY = ushort;
enum : ushort
{
    STOPBITS_10  = cast(ushort) 0x0001,
    STOPBITS_15  = cast(ushort) 0x0002,
    STOPBITS_20  = cast(ushort) 0x0004,
    PARITY_NONE  = cast(ushort) 0x0100,
    PARITY_ODD   = cast(ushort) 0x0200,
    PARITY_EVEN  = cast(ushort) 0x0400,
    PARITY_MARK  = cast(ushort) 0x0800,
    PARITY_SPACE = cast(ushort) 0x1000,
}

alias MODEM_SPEAKER_VOLUME = uint;
enum : uint
{
    MDMVOL_HIGH   = 0x00000002U,
    MDMVOL_LOW    = 0x00000000U,
    MDMVOL_MEDIUM = 0x00000001U,
}

alias MODEMDEVCAPS_SPEAKER_VOLUME = uint;
enum : uint
{
    MDMVOLFLAG_HIGH   = 0x00000004U,
    MDMVOLFLAG_LOW    = 0x00000001U,
    MDMVOLFLAG_MEDIUM = 0x00000002U,
}

alias MODEMDEVCAPS_SPEAKER_MODE = uint;
enum : uint
{
    MDMSPKRFLAG_CALLSETUP = 0x00000008U,
    MDMSPKRFLAG_DIAL      = 0x00000002U,
    MDMSPKRFLAG_OFF       = 0x00000001U,
    MDMSPKRFLAG_ON        = 0x00000004U,
}

alias DCB_STOP_BITS = ubyte;
enum : ubyte
{
    ONESTOPBIT   = cast(ubyte) 0x00,
    ONE5STOPBITS = cast(ubyte) 0x01,
    TWOSTOPBITS  = cast(ubyte) 0x02,
}

alias DCB_PARITY = ubyte;
enum : ubyte
{
    EVENPARITY  = cast(ubyte) 0x02,
    MARKPARITY  = cast(ubyte) 0x03,
    NOPARITY    = cast(ubyte) 0x00,
    ODDPARITY   = cast(ubyte) 0x01,
    SPACEPARITY = cast(ubyte) 0x04,
}

// Constants


enum uint MDM_COMPRESSION = 0x00000001U;
enum uint MDM_ERROR_CONTROL = 0x00000002U;
enum uint MDM_FORCED_EC = 0x00000004U;
enum uint MDM_CELLULAR = 0x00000008U;

enum : uint
{
    MDM_FLOWCONTROL_HARD = 0x00000010U,
    MDM_FLOWCONTROL_SOFT = 0x00000020U,
}

enum uint MDM_CCITT_OVERRIDE = 0x00000040U;
enum uint MDM_SPEED_ADJUST = 0x00000080U;
enum uint MDM_TONE_DIAL = 0x00000100U;
enum uint MDM_BLIND_DIAL = 0x00000200U;
enum uint MDM_V23_OVERRIDE = 0x00000400U;
enum uint MDM_DIAGNOSTICS = 0x00000800U;
enum uint MDM_MASK_BEARERMODE = 0x0000f000U;
enum uint MDM_SHIFT_BEARERMODE = 0x0000000cU;
enum uint MDM_MASK_PROTOCOLID = 0x000f0000U;
enum uint MDM_SHIFT_PROTOCOLID = 0x00000010U;
enum uint MDM_MASK_PROTOCOLDATA = 0x0ff00000U;

enum : uint
{
    MDM_SHIFT_PROTOCOLDATA = 0x00000014U,
    MDM_SHIFT_PROTOCOLINFO = 0x00000010U,
    MDM_SHIFT_EXTENDEDINFO = 0x0000000cU,
}

enum : uint
{
    MDM_BEARERMODE_ANALOG = 0x00000000U,
    MDM_BEARERMODE_ISDN   = 0x00000001U,
    MDM_BEARERMODE_GSM    = 0x00000002U,
}

enum : uint
{
    MDM_PROTOCOLID_DEFAULT = 0x00000000U,
    MDM_PROTOCOLID_HDLCPPP = 0x00000001U,
    MDM_PROTOCOLID_V128    = 0x00000002U,
    MDM_PROTOCOLID_X75     = 0x00000003U,
    MDM_PROTOCOLID_V110    = 0x00000004U,
    MDM_PROTOCOLID_V120    = 0x00000005U,
    MDM_PROTOCOLID_AUTO    = 0x00000006U,
    MDM_PROTOCOLID_ANALOG  = 0x00000007U,
    MDM_PROTOCOLID_GPRS    = 0x00000008U,
    MDM_PROTOCOLID_PIAFS   = 0x00000009U,
}

enum uint MDM_SHIFT_HDLCPPP_SPEED = 0x00000000U;
enum uint MDM_MASK_HDLCPPP_SPEED = 0x00000007U;

enum : uint
{
    MDM_HDLCPPP_SPEED_DEFAULT = 0x00000000U,
    MDM_HDLCPPP_SPEED_64K     = 0x00000001U,
    MDM_HDLCPPP_SPEED_56K     = 0x00000002U,
}

enum uint MDM_SHIFT_HDLCPPP_AUTH = 0x00000003U;
enum uint MDM_MASK_HDLCPPP_AUTH = 0x00000038U;

enum : uint
{
    MDM_HDLCPPP_AUTH_DEFAULT = 0x00000000U,
    MDM_HDLCPPP_AUTH_NONE    = 0x00000001U,
    MDM_HDLCPPP_AUTH_PAP     = 0x00000002U,
    MDM_HDLCPPP_AUTH_CHAP    = 0x00000003U,
    MDM_HDLCPPP_AUTH_MSCHAP  = 0x00000004U,
}

enum uint MDM_SHIFT_HDLCPPP_ML = 0x00000006U;
enum uint MDM_MASK_HDLCPPP_ML = 0x000000c0U;

enum : uint
{
    MDM_HDLCPPP_ML_DEFAULT = 0x00000000U,
    MDM_HDLCPPP_ML_NONE    = 0x00000001U,
    MDM_HDLCPPP_ML_2       = 0x00000002U,
}

enum uint MDM_SHIFT_V120_SPEED = 0x00000000U;
enum uint MDM_MASK_V120_SPEED = 0x00000007U;

enum : uint
{
    MDM_V120_SPEED_DEFAULT = 0x00000000U,
    MDM_V120_SPEED_64K     = 0x00000001U,
    MDM_V120_SPEED_56K     = 0x00000002U,
}

enum uint MDM_SHIFT_V120_ML = 0x00000006U;
enum uint MDM_MASK_V120_ML = 0x000000c0U;

enum : uint
{
    MDM_V120_ML_DEFAULT = 0x00000000U,
    MDM_V120_ML_NONE    = 0x00000001U,
    MDM_V120_ML_2       = 0x00000002U,
}

enum uint MDM_SHIFT_X75_DATA = 0x00000000U;
enum uint MDM_MASK_X75_DATA = 0x00000007U;

enum : uint
{
    MDM_X75_DATA_DEFAULT = 0x00000000U,
    MDM_X75_DATA_64K     = 0x00000001U,
    MDM_X75_DATA_128K    = 0x00000002U,
    MDM_X75_DATA_T_70    = 0x00000003U,
    MDM_X75_DATA_BTX     = 0x00000004U,
}

enum uint MDM_SHIFT_V110_SPEED = 0x00000000U;
enum uint MDM_MASK_V110_SPEED = 0x0000000fU;

enum : uint
{
    MDM_V110_SPEED_DEFAULT = 0x00000000U,
    MDM_V110_SPEED_1DOT2K  = 0x00000001U,
    MDM_V110_SPEED_2DOT4K  = 0x00000002U,
    MDM_V110_SPEED_4DOT8K  = 0x00000003U,
    MDM_V110_SPEED_9DOT6K  = 0x00000004U,
    MDM_V110_SPEED_12DOT0K = 0x00000005U,
    MDM_V110_SPEED_14DOT4K = 0x00000006U,
    MDM_V110_SPEED_19DOT2K = 0x00000007U,
    MDM_V110_SPEED_28DOT8K = 0x00000008U,
    MDM_V110_SPEED_38DOT4K = 0x00000009U,
    MDM_V110_SPEED_57DOT6K = 0x0000000aU,
}

enum uint MDM_SHIFT_AUTO_SPEED = 0x00000000U;
enum uint MDM_MASK_AUTO_SPEED = 0x00000007U;
enum uint MDM_AUTO_SPEED_DEFAULT = 0x00000000U;
enum uint MDM_SHIFT_AUTO_ML = 0x00000006U;
enum uint MDM_MASK_AUTO_ML = 0x000000c0U;

enum : uint
{
    MDM_AUTO_ML_DEFAULT = 0x00000000U,
    MDM_AUTO_ML_NONE    = 0x00000001U,
    MDM_AUTO_ML_2       = 0x00000002U,
}

enum : uint
{
    MDM_ANALOG_RLP_ON  = 0x00000000U,
    MDM_ANALOG_RLP_OFF = 0x00000001U,
    MDM_ANALOG_V34     = 0x00000002U,
}

enum : uint
{
    MDM_PIAFS_INCOMING = 0x00000000U,
    MDM_PIAFS_OUTGOING = 0x00000001U,
}

enum GUID SID_3GPP_SUPSVCMODEL = GUID("d7d08e07-d767-4478-b14a-eecc87ea12f7");

enum : uint
{
    MAXLENGTH_NAI           = 0x00000048U,
    MAXLENGTH_UICCDATASTORE = 0x0000000aU,
}

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mcx/ns-mcx-modemdevcaps
struct MODEMDEVCAPS
{
    uint     dwActualSize;
    uint     dwRequiredSize;
    uint     dwDevSpecificOffset;
    uint     dwDevSpecificSize;
    uint     dwModemProviderVersion;
    uint     dwModemManufacturerOffset;
    uint     dwModemManufacturerSize;
    uint     dwModemModelOffset;
    uint     dwModemModelSize;
    uint     dwModemVersionOffset;
    uint     dwModemVersionSize;
    MODEMDEVCAPS_DIAL_OPTIONS dwDialOptions;
    uint     dwCallSetupFailTimer;
    uint     dwInactivityTimeout;
    MODEMDEVCAPS_SPEAKER_VOLUME dwSpeakerVolume;
    MODEMDEVCAPS_SPEAKER_MODE dwSpeakerMode;
    uint     dwModemOptions;
    uint     dwMaxDTERate;
    uint     dwMaxDCERate;
    ubyte[1] abVariablePortion; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mcx/ns-mcx-modemsettings
struct MODEMSETTINGS
{
    uint                 dwActualSize;
    uint                 dwRequiredSize;
    uint                 dwDevSpecificOffset;
    uint                 dwDevSpecificSize;
    uint                 dwCallSetupFailTimer;
    uint                 dwInactivityTimeout;
    MODEM_SPEAKER_VOLUME dwSpeakerVolume;
    MODEMSETTINGS_SPEAKER_MODE dwSpeakerMode;
    uint                 dwPreferredModemOptions;
    uint                 dwNegotiatedModemOptions;
    uint                 dwNegotiatedDCERate;
    ubyte[1]             abVariablePortion; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-commprop
struct COMMPROP
{
    ushort               wPacketLength;
    ushort               wPacketVersion;
    uint                 dwServiceMask;
    uint                 dwReserved1;
    uint                 dwMaxTxQueue;
    uint                 dwMaxRxQueue;
    uint                 dwMaxBaud;
    uint                 dwProvSubType;
    uint                 dwProvCapabilities;
    uint                 dwSettableParams;
    uint                 dwSettableBaud;
    ushort               wSettableData;
    COMMPROP_STOP_PARITY wSettableStopParity;
    uint                 dwCurrentTxQueue;
    uint                 dwCurrentRxQueue;
    uint                 dwProvSpec1;
    uint                 dwProvSpec2;
    wchar[1]             wcProvChar; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-comstat
struct COMSTAT
{
    // Native bit field: fCtsHold: [0], fDsrHold: [1], fRlsdHold: [2], fXoffHold: [3], fXoffSent: [4], fEof: [5], fTxim: [6], fReserved: [7-31]
    uint _bitfield0;
    uint cbInQue;
    uint cbOutQue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-dcb
struct DCB
{
    uint          DCBlength;
    uint          BaudRate;
    // Native bit field: fBinary: [0], fParity: [1], fOutxCtsFlow: [2], fOutxDsrFlow: [3], fDtrControl: [4-5], fDsrSensitivity: [6], fTXContinueOnXoff: [7], fOutX: [8], fInX: [9], fErrorChar: [10], fNull: [11], fRtsControl: [12-13], fAbortOnError: [14], fDummy2: [15-31]
    uint          _bitfield0;
    ushort        wReserved;
    ushort        XonLim;
    ushort        XoffLim;
    ubyte         ByteSize;
    DCB_PARITY    Parity;
    DCB_STOP_BITS StopBits;
    CHAR          XonChar;
    CHAR          XoffChar;
    CHAR          ErrorChar;
    CHAR          EofChar;
    CHAR          EvtChar;
    ushort        wReserved1;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-commtimeouts
struct COMMTIMEOUTS
{
    uint ReadIntervalTimeout;
    uint ReadTotalTimeoutMultiplier;
    uint ReadTotalTimeoutConstant;
    uint WriteTotalTimeoutMultiplier;
    uint WriteTotalTimeoutConstant;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-commconfig
struct COMMCONFIG
{
    uint     dwSize;
    ushort   wVersion;
    ushort   wReserved;
    DCB      dcb;
    uint     dwProviderSubType;
    uint     dwProviderOffset;
    uint     dwProviderSize;
    wchar[1] wcProviderData; // Flexible array
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL ClearCommBreak(HANDLE hFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL ClearCommError(HANDLE hFile, CLEAR_COMM_ERROR_FLAGS* lpErrors, COMSTAT* lpStat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetupComm(HANDLE hFile, uint dwInQueue, uint dwOutQueue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL EscapeCommFunction(HANDLE hFile, ESCAPE_COMM_FUNCTION dwFunc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetCommConfig(HANDLE hCommDev, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/COMMCONFIG* lpCC, 
                   uint* lpdwSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetCommMask(HANDLE hFile, COMM_EVENT_MASK* lpEvtMask);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetCommProperties(HANDLE hFile, COMMPROP* lpCommProp);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetCommModemStatus(HANDLE hFile, MODEM_STATUS_FLAGS* lpModemStat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetCommState(HANDLE hFile, DCB* lpDCB);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetCommTimeouts(HANDLE hFile, COMMTIMEOUTS* lpCommTimeouts);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL PurgeComm(HANDLE hFile, PURGE_COMM_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetCommBreak(HANDLE hFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetCommConfig(HANDLE hCommDev, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/COMMCONFIG* lpCC, 
                   uint dwSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetCommMask(HANDLE hFile, COMM_EVENT_MASK dwEvtMask);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetCommState(HANDLE hFile, DCB* lpDCB);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetCommTimeouts(HANDLE hFile, COMMTIMEOUTS* lpCommTimeouts);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL TransmitCommChar(HANDLE hFile, CHAR cChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL WaitCommEvent(HANDLE hFile, COMM_EVENT_MASK* lpEvtMask, OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("api-ms-win-core-comm-l1-1-1.dll")
HANDLE OpenCommPort(uint uPortNumber, uint dwDesiredAccess, uint dwFlagsAndAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
@DllImport("api-ms-win-core-comm-l1-1-2.dll")
uint GetCommPorts(uint* lpPortNumbers, uint uPortNumbersCount, uint* puPortNumbersFound);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL BuildCommDCBA(const(PSTR) lpDef, DCB* lpDCB);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL BuildCommDCBW(const(PWSTR) lpDef, DCB* lpDCB);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL BuildCommDCBAndTimeoutsA(const(PSTR) lpDef, DCB* lpDCB, COMMTIMEOUTS* lpCommTimeouts);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL BuildCommDCBAndTimeoutsW(const(PWSTR) lpDef, DCB* lpDCB, COMMTIMEOUTS* lpCommTimeouts);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL CommConfigDialogA(const(PSTR) lpszName, HWND hWnd, COMMCONFIG* lpCC);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL CommConfigDialogW(const(PWSTR) lpszName, HWND hWnd, COMMCONFIG* lpCC);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetDefaultCommConfigA(const(PSTR) lpszName, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/COMMCONFIG* lpCC, 
                           uint* lpdwSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetDefaultCommConfigW(const(PWSTR) lpszName, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/COMMCONFIG* lpCC, 
                           uint* lpdwSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetDefaultCommConfigA(const(PSTR) lpszName, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/COMMCONFIG* lpCC, 
                           uint dwSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetDefaultCommConfigW(const(PWSTR) lpszName, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/COMMCONFIG* lpCC, 
                           uint dwSize);


