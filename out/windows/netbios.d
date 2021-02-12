module windows.netbios;

public import windows.systemservices;

extern(Windows):

struct NCB
{
    ubyte ncb_command;
    ubyte ncb_retcode;
    ubyte ncb_lsn;
    ubyte ncb_num;
    ubyte* ncb_buffer;
    ushort ncb_length;
    ubyte ncb_callname;
    ubyte ncb_name;
    ubyte ncb_rto;
    ubyte ncb_sto;
    int ncb_post;
    ubyte ncb_lana_num;
    ubyte ncb_cmd_cplt;
    ubyte ncb_reserve;
    HANDLE ncb_event;
}

struct ADAPTER_STATUS
{
    ubyte adapter_address;
    ubyte rev_major;
    ubyte reserved0;
    ubyte adapter_type;
    ubyte rev_minor;
    ushort duration;
    ushort frmr_recv;
    ushort frmr_xmit;
    ushort iframe_recv_err;
    ushort xmit_aborts;
    uint xmit_success;
    uint recv_success;
    ushort iframe_xmit_err;
    ushort recv_buff_unavail;
    ushort t1_timeouts;
    ushort ti_timeouts;
    uint reserved1;
    ushort free_ncbs;
    ushort max_cfg_ncbs;
    ushort max_ncbs;
    ushort xmit_buf_unavail;
    ushort max_dgram_size;
    ushort pending_sess;
    ushort max_cfg_sess;
    ushort max_sess;
    ushort max_sess_pkt_size;
    ushort name_count;
}

struct NAME_BUFFER
{
    ubyte name;
    ubyte name_num;
    ubyte name_flags;
}

struct SESSION_HEADER
{
    ubyte sess_name;
    ubyte num_sess;
    ubyte rcv_dg_outstanding;
    ubyte rcv_any_outstanding;
}

struct SESSION_BUFFER
{
    ubyte lsn;
    ubyte state;
    ubyte local_name;
    ubyte remote_name;
    ubyte rcvs_outstanding;
    ubyte sends_outstanding;
}

struct LANA_ENUM
{
    ubyte length;
    ubyte lana;
}

struct FIND_NAME_HEADER
{
    ushort node_count;
    ubyte reserved;
    ubyte unique_group;
}

struct FIND_NAME_BUFFER
{
    ubyte length;
    ubyte access_control;
    ubyte frame_control;
    ubyte destination_addr;
    ubyte source_addr;
    ubyte routing_info;
}

struct ACTION_HEADER
{
    uint transport_id;
    ushort action_code;
    ushort reserved;
}

@DllImport("NETAPI32.dll")
ubyte Netbios(NCB* pncb);

