// Written in the D programming language.

module windows.win32.networkmanagement.netbios;

public import windows.core;
public import windows.win32.foundation : HANDLE;

extern(Windows) @nogc nothrow:


// Constants


enum uint NCBNAMSZ = 0x00000010U;
enum uint MAX_LANA = 0x000000feU;
enum uint NAME_FLAGS_MASK = 0x00000087U;
enum uint GROUP_NAME = 0x00000080U;
enum uint UNIQUE_NAME = 0x00000000U;

enum : uint
{
    REGISTERING = 0x00000000U,
    REGISTERED  = 0x00000004U,
}

enum uint DEREGISTERED = 0x00000005U;

enum : uint
{
    DUPLICATE       = 0x00000006U,
    DUPLICATE_DEREG = 0x00000007U,
}

enum uint LISTEN_OUTSTANDING = 0x00000001U;
enum uint CALL_PENDING = 0x00000002U;
enum uint SESSION_ESTABLISHED = 0x00000003U;

enum : uint
{
    HANGUP_PENDING  = 0x00000004U,
    HANGUP_COMPLETE = 0x00000005U,
}

enum uint SESSION_ABORTED = 0x00000006U;
// Native encoding: ansi
enum const(wchar)* ALL_TRANSPORTS = "M\0\0\0";
// Native encoding: ansi
enum const(wchar)* MS_NBF = "MNBF";

enum : uint
{
    NCBCALL   = 0x00000010U,
    NCBLISTEN = 0x00000011U,
}

enum uint NCBHANGUP = 0x00000012U;

enum : uint
{
    NCBSEND    = 0x00000014U,
    NCBRECV    = 0x00000015U,
    NCBRECVANY = 0x00000016U,
}

enum uint NCBCHAINSEND = 0x00000017U;

enum : uint
{
    NCBDGSEND   = 0x00000020U,
    NCBDGRECV   = 0x00000021U,
    NCBDGSENDBC = 0x00000022U,
    NCBDGRECVBC = 0x00000023U,
}

enum uint NCBADDNAME = 0x00000030U;
enum uint NCBDELNAME = 0x00000031U;
enum uint NCBRESET = 0x00000032U;
enum uint NCBASTAT = 0x00000033U;
enum uint NCBSSTAT = 0x00000034U;
enum uint NCBCANCEL = 0x00000035U;
enum uint NCBADDGRNAME = 0x00000036U;

enum : uint
{
    NCBENUM   = 0x00000037U,
    NCBUNLINK = 0x00000070U,
}

enum uint NCBSENDNA = 0x00000071U;
enum uint NCBCHAINSENDNA = 0x00000072U;
enum uint NCBLANSTALERT = 0x00000073U;
enum uint NCBACTION = 0x00000077U;
enum uint NCBFINDNAME = 0x00000078U;
enum uint NCBTRACE = 0x00000079U;
enum uint ASYNCH = 0x00000080U;
enum uint NRC_GOODRET = 0x00000000U;
enum uint NRC_BUFLEN = 0x00000001U;
enum uint NRC_ILLCMD = 0x00000003U;
enum uint NRC_CMDTMO = 0x00000005U;
enum uint NRC_INCOMP = 0x00000006U;

enum : uint
{
    NRC_BADDR   = 0x00000007U,
    NRC_SNUMOUT = 0x00000008U,
}

enum : uint
{
    NRC_NORES   = 0x00000009U,
    NRC_SCLOSED = 0x0000000aU,
}

enum uint NRC_CMDCAN = 0x0000000bU;
enum uint NRC_DUPNAME = 0x0000000dU;
enum uint NRC_NAMTFUL = 0x0000000eU;
enum uint NRC_ACTSES = 0x0000000fU;
enum uint NRC_LOCTFUL = 0x00000011U;
enum uint NRC_REMTFUL = 0x00000012U;

enum : uint
{
    NRC_ILLNN  = 0x00000013U,
    NRC_NOCALL = 0x00000014U,
    NRC_NOWILD = 0x00000015U,
}

enum : uint
{
    NRC_INUSE  = 0x00000016U,
    NRC_NAMERR = 0x00000017U,
}

enum uint NRC_SABORT = 0x00000018U;
enum uint NRC_NAMCONF = 0x00000019U;
enum uint NRC_IFBUSY = 0x00000021U;
enum uint NRC_TOOMANY = 0x00000022U;
enum uint NRC_BRIDGE = 0x00000023U;

enum : uint
{
    NRC_CANOCCR = 0x00000024U,
    NRC_CANCEL  = 0x00000026U,
}

enum uint NRC_DUPENV = 0x00000030U;
enum uint NRC_ENVNOTDEF = 0x00000034U;
enum uint NRC_OSRESNOTAV = 0x00000035U;
enum uint NRC_MAXAPPS = 0x00000036U;

enum : uint
{
    NRC_NOSAPS      = 0x00000037U,
    NRC_NORESOURCES = 0x00000038U,
}

enum : uint
{
    NRC_INVADDRESS = 0x00000039U,
    NRC_INVDDID    = 0x0000003bU,
}

enum uint NRC_LOCKFAIL = 0x0000003cU;
enum uint NRC_OPENERR = 0x0000003fU;
enum uint NRC_SYSTEM = 0x00000040U;
enum uint NRC_PENDING = 0x000000ffU;

// Structs


version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nb30/ns-nb30-ncb
    struct NCB
    {
        ubyte     ncb_command;
        ubyte     ncb_retcode;
        ubyte     ncb_lsn;
        ubyte     ncb_num;
        ubyte*    ncb_buffer;
        ushort    ncb_length;
        ubyte[16] ncb_callname;
        ubyte[16] ncb_name;
        ubyte     ncb_rto;
        ubyte     ncb_sto;
        ptrdiff_t ncb_post;
        ubyte     ncb_lana_num;
        ubyte     ncb_cmd_cplt;
        ubyte[18] ncb_reserve;
        HANDLE    ncb_event;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nb30/ns-nb30-ncb
    struct NCB
    {
        ubyte     ncb_command;
        ubyte     ncb_retcode;
        ubyte     ncb_lsn;
        ubyte     ncb_num;
        ubyte*    ncb_buffer;
        ushort    ncb_length;
        ubyte[16] ncb_callname;
        ubyte[16] ncb_name;
        ubyte     ncb_rto;
        ubyte     ncb_sto;
        ptrdiff_t ncb_post;
        ubyte     ncb_lana_num;
        ubyte     ncb_cmd_cplt;
        ubyte[18] ncb_reserve;
        HANDLE    ncb_event;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nb30/ns-nb30-ncb
    struct NCB
    {
        ubyte     ncb_command;
        ubyte     ncb_retcode;
        ubyte     ncb_lsn;
        ubyte     ncb_num;
        ubyte*    ncb_buffer;
        ushort    ncb_length;
        ubyte[16] ncb_callname;
        ubyte[16] ncb_name;
        ubyte     ncb_rto;
        ubyte     ncb_sto;
        ptrdiff_t ncb_post;
        ubyte     ncb_lana_num;
        ubyte     ncb_cmd_cplt;
        ubyte[10] ncb_reserve;
        HANDLE    ncb_event;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nb30/ns-nb30-adapter_status
struct ADAPTER_STATUS
{
    ubyte[6] adapter_address;
    ubyte    rev_major;
    ubyte    reserved0;
    ubyte    adapter_type;
    ubyte    rev_minor;
    ushort   duration;
    ushort   frmr_recv;
    ushort   frmr_xmit;
    ushort   iframe_recv_err;
    ushort   xmit_aborts;
    uint     xmit_success;
    uint     recv_success;
    ushort   iframe_xmit_err;
    ushort   recv_buff_unavail;
    ushort   t1_timeouts;
    ushort   ti_timeouts;
    uint     reserved1;
    ushort   free_ncbs;
    ushort   max_cfg_ncbs;
    ushort   max_ncbs;
    ushort   xmit_buf_unavail;
    ushort   max_dgram_size;
    ushort   pending_sess;
    ushort   max_cfg_sess;
    ushort   max_sess;
    ushort   max_sess_pkt_size;
    ushort   name_count;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nb30/ns-nb30-name_buffer
struct NAME_BUFFER
{
    ubyte[16] name;
    ubyte     name_num;
    ubyte     name_flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nb30/ns-nb30-session_header
struct SESSION_HEADER
{
    ubyte sess_name;
    ubyte num_sess;
    ubyte rcv_dg_outstanding;
    ubyte rcv_any_outstanding;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nb30/ns-nb30-session_buffer
struct SESSION_BUFFER
{
    ubyte     lsn;
    ubyte     state;
    ubyte[16] local_name;
    ubyte[16] remote_name;
    ubyte     rcvs_outstanding;
    ubyte     sends_outstanding;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nb30/ns-nb30-lana_enum
struct LANA_ENUM
{
    ubyte      length;
    ubyte[255] lana;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nb30/ns-nb30-find_name_header
struct FIND_NAME_HEADER
{
    ushort node_count;
    ubyte  reserved;
    ubyte  unique_group;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nb30/ns-nb30-find_name_buffer
struct FIND_NAME_BUFFER
{
    ubyte     length;
    ubyte     access_control;
    ubyte     frame_control;
    ubyte[6]  destination_addr;
    ubyte[6]  source_addr;
    ubyte[18] routing_info;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nb30/ns-nb30-action_header
struct ACTION_HEADER
{
    uint   transport_id;
    ushort action_code;
    ushort reserved;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("NETAPI32.dll")
ubyte Netbios(NCB* pncb);


