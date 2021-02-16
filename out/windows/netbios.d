module windows.netbios;

public import windows.core;
public import windows.systemservices : HANDLE;

extern(Windows):


// Structs


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

struct NAME_BUFFER
{
    ubyte[16] name;
    ubyte     name_num;
    ubyte     name_flags;
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
    ubyte     lsn;
    ubyte     state;
    ubyte[16] local_name;
    ubyte[16] remote_name;
    ubyte     rcvs_outstanding;
    ubyte     sends_outstanding;
}

struct LANA_ENUM
{
    ubyte      length;
    ubyte[255] lana;
}

struct FIND_NAME_HEADER
{
    ushort node_count;
    ubyte  reserved;
    ubyte  unique_group;
}

struct FIND_NAME_BUFFER
{
    ubyte     length;
    ubyte     access_control;
    ubyte     frame_control;
    ubyte[6]  destination_addr;
    ubyte[6]  source_addr;
    ubyte[18] routing_info;
}

struct ACTION_HEADER
{
    uint   transport_id;
    ushort action_code;
    ushort reserved;
}

// Functions

@DllImport("NETAPI32")
ubyte Netbios(NCB* pncb);


