// Written in the D programming language.

module windows.netbios;

public import windows.core;
public import windows.systemservices : HANDLE;

extern(Windows):


// Structs


///<p class="CCE_Message">[Netbios is not supported on Windows Vista, Windows Server 2008, and subsequent versions of
///the operating system] The <b>NCB</b> structure represents a network control block. It contains information about the
///command to perform, an optional post routine, an optional event handle, and a pointer to a buffer that is used for
///messages or other data. A pointer to this structure is passed to the Netbios function.
struct NCB
{
    ///Specifies the command code and a flag that indicates whether the <b>NCB</b> structure is processed
    ///asynchronously. The most significant bit contains the flag. If the ASYNCH constant is combined with a command
    ///code (by using the OR operator), the <b>NCB</b> structure is processed asynchronously. The following command
    ///codes are supported. <table> <tr> <th>Code</th> <th>Meaning</th> </tr> <tr> <td>NCBACTION</td> <td> <b>Windows
    ///Server 2003, Windows XP, Windows 2000, and Windows NT: </b>Enables extensions to the transport interface.
    ///NCBACTION is mapped to <b>TdiAction</b>. When this code is specified, the <b>ncb_buffer</b> member points to a
    ///buffer to be filled with an ACTION_HEADER structure, which is optionally followed by data. NCBACTION commands
    ///cannot be canceled by using NCBCANCEL. NCBACTION is not a standard NetBIOS 3.0 command. </td> </tr> <tr>
    ///<td>NCBADDGRNAME </td> <td> Adds a group name to the local name table. This name cannot be used by another
    ///process on the network as a unique name, but it can be added by anyone as a group name. </td> </tr> <tr>
    ///<td>NCBADDNAME</td> <td> Adds a unique name to the local name table. The TDI driver ensures that the name is
    ///unique across the network. </td> </tr> <tr> <td>NCBASTAT</td> <td> Retrieves the status of either a local or
    ///remote adapter. When this code is specified, the <b>ncb_buffer</b> member points to a buffer to be filled with an
    ///ADAPTER_STATUS structure, followed by an array of NAME_BUFFER structures. </td> </tr> <tr> <td>NCBCALL</td> <td>
    ///Opens a session with another name. </td> </tr> <tr> <td>NCBCANCEL</td> <td> Cancels a previous pending command.
    ///</td> </tr> <tr> <td>NCBCHAINSEND</td> <td> Sends the contents of two data buffers to the specified session
    ///partner. </td> </tr> <tr> <td>NCBCHAINSENDNA</td> <td> Sends the contents of two data buffers to the specified
    ///session partner and does not wait for acknowledgment. </td> </tr> <tr> <td>NCBDELNAME</td> <td> Deletes a name
    ///from the local name table. </td> </tr> <tr> <td>NCBDGRECV</td> <td> Receives a datagram from any name. </td>
    ///</tr> <tr> <td>NCBDGRECVBC</td> <td> Receives a broadcast datagram from any name. </td> </tr> <tr>
    ///<td>NCBDGSEND</td> <td> Sends datagram to a specified name. </td> </tr> <tr> <td>NCBDGSENDBC</td> <td> Sends a
    ///broadcast datagram to every host on the local area network (LAN). </td> </tr> <tr> <td>NCBENUM</td> <td>
    ///<b>Windows Server 2003, Windows XP, Windows 2000, and Windows NT: </b>Enumerates LAN adapter (LANA) numbers. When
    ///this code is specified, the ncb_buffer member points to a buffer to be filled with a LANA_ENUM structure. NCBENUM
    ///is not a standard NetBIOS 3.0 command. </td> </tr> <tr> <td>NCBFINDNAME</td> <td> Determines the location of a
    ///name on the network. When this code is specified, the <b>ncb_buffer</b> member points to a buffer to be filled
    ///with a FIND_NAME_HEADER structure followed by one or more FIND_NAME_BUFFER structures. </td> </tr> <tr>
    ///<td>NCBHANGUP</td> <td> Closes a specified session. </td> </tr> <tr> <td>NCBLANSTALERT</td> <td> <b>Windows
    ///Server 2003, Windows XP, Windows 2000, and Windows NT: </b>Notifies the user of LAN failures that last for more
    ///than one minute. </td> </tr> <tr> <td>NCBLISTEN</td> <td> Enables a session to be opened with another name (local
    ///or remote). </td> </tr> <tr> <td>NCBRECV</td> <td> Receives data from the specified session partner. </td> </tr>
    ///<tr> <td>NCBRECVANY</td> <td> Receives data from any session corresponding to a specified name. </td> </tr> <tr>
    ///<td>NCBRESET</td> <td> Resets a LAN adapter. An adapter must be reset before it can accept any other NCB command
    ///that specifies the same number in the <b>ncb_lana_num</b> member. Use the following values to specify how
    ///resources are to be freed: <ul> <li>If <b>ncb_lsn</b> is not 0x00, all resources associated with
    ///<b>ncb_lana_num</b> are to be freed.</li> <li>If <b>ncb_lsn</b> is 0x00, all resources associated with
    ///<b>ncb_lana_num</b> are to be freed, and new resources are to be allocated. The <b>ncb_callname</b>[0] byte
    ///specifies the maximum number of sessions, and the <b>ncb_callname</b>[2] byte specifies the maximum number of
    ///names. A nonzero value for the <b>ncb_callname</b>[3] byte requests that the application use
    ///<b>NAME_NUMBER_1</b>. </li> </ul> </td> </tr> <tr> <td>NCBSEND</td> <td> Sends data to the specified session
    ///partner. </td> </tr> <tr> <td>NCBSENDNA</td> <td> Sends data to specified session partner and does not wait for
    ///acknowledgment. </td> </tr> <tr> <td>NCBSSTAT</td> <td> Retrieves the status of the session. When this value is
    ///specified, the <b>ncb_buffer</b> member points to a buffer to be filled with a SESSION_HEADER structure, followed
    ///by one or more SESSION_BUFFER structures. </td> </tr> <tr> <td>NCBTRACE</td> <td> Activates or deactivates NCB
    ///tracing. This command is not supported. </td> </tr> <tr> <td>NCBUNLINK</td> <td> Unlinks the adapter. This
    ///command is provided for compatibility with earlier versions of NetBIOS. It has no effect in Windows. </td> </tr>
    ///</table>
    ubyte     ncb_command;
    ///Specifies the return code. This value is set to NRC_PENDING while an asynchronous operation is in progress. The
    ///system returns one of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td>NRC_GOODRET</td> <td>The operation succeeded.</td> </tr> <tr> <td>NRC_BUFLEN</td> <td>An illegal buffer
    ///length was supplied.</td> </tr> <tr> <td>NRC_ILLCMD</td> <td>An illegal command was supplied.</td> </tr> <tr>
    ///<td>NRC_CMDTMO</td> <td>The command was timed out.</td> </tr> <tr> <td>NRC_INCOMP</td> <td>The message was
    ///incomplete. The application is to issue another command.</td> </tr> <tr> <td>NRC_BADDR</td> <td>The buffer
    ///address was illegal.</td> </tr> <tr> <td>NRC_SNUMOUT</td> <td>The session number was out of range.</td> </tr>
    ///<tr> <td>NRC_NORES</td> <td>No resource was available.</td> </tr> <tr> <td>NRC_SCLOSED</td> <td>The session was
    ///closed.</td> </tr> <tr> <td>NRC_CMDCAN</td> <td>The command was canceled.</td> </tr> <tr> <td>NRC_DUPNAME</td>
    ///<td>A duplicate name existed in the local name table.</td> </tr> <tr> <td>NRC_NAMTFUL</td> <td>The name table was
    ///full.</td> </tr> <tr> <td>NRC_ACTSES</td> <td>The command finished; the name has active sessions and is no longer
    ///registered.</td> </tr> <tr> <td>NRC_LOCTFUL</td> <td>The local session table was full.</td> </tr> <tr>
    ///<td>NRC_REMTFUL</td> <td>The remote session table was full. The request to open a session was rejected.</td>
    ///</tr> <tr> <td>NRC_ILLNN</td> <td>An illegal name number was specified.</td> </tr> <tr> <td>NRC_NOCALL</td>
    ///<td>The system did not find the name that was called.</td> </tr> <tr> <td>NRC_NOWILD</td> <td>Wildcards are not
    ///permitted in the <b>ncb_name</b> member.</td> </tr> <tr> <td>NRC_INUSE</td> <td>The name was already in use on
    ///the remote adapter.</td> </tr> <tr> <td>NRC_NAMERR</td> <td>The name was deleted.</td> </tr> <tr>
    ///<td>NRC_SABORT</td> <td>The session ended abnormally.</td> </tr> <tr> <td>NRC_NAMCONF</td> <td>A name conflict
    ///was detected.</td> </tr> <tr> <td>NRC_IFBUSY</td> <td>The interface was busy.</td> </tr> <tr>
    ///<td>NRC_TOOMANY</td> <td>Too many commands were outstanding; the application can retry the command later.</td>
    ///</tr> <tr> <td>NRC_BRIDGE</td> <td>The <b>ncb_lana_num</b> member did not specify a valid network number.</td>
    ///</tr> <tr> <td>NRC_CANOCCR</td> <td>The command finished while a cancel operation was occurring.</td> </tr> <tr>
    ///<td>NRC_CANCEL</td> <td>The NCBCANCEL command was not valid; the command was not canceled.</td> </tr> <tr>
    ///<td>NRC_DUPENV</td> <td>The name was defined by another local process.</td> </tr> <tr> <td>NRC_ENVNOTDEF</td>
    ///<td>The environment was not defined. A reset command must be issued.</td> </tr> <tr> <td>NRC_OSRESNOTAV</td>
    ///<td>Operating system resources were exhausted. The application can retry the command later.</td> </tr> <tr>
    ///<td>NRC_MAXAPPS</td> <td>The maximum number of applications was exceeded.</td> </tr> <tr> <td>NRC_NOSAPS</td>
    ///<td>No service access points (SAPs) were available for NetBIOS.</td> </tr> <tr> <td>NRC_NORESOURCES</td> <td>The
    ///requested resources were not available.</td> </tr> <tr> <td>NRC_INVADDRESS</td> <td>The NCB address was not
    ///valid.</td> </tr> <tr> <td>NRC_INVDDID</td> <td> The NCB DDID was invalid. This return code is not part of the
    ///IBM NetBIOS 3.0 specification and is not returned in the <b>NCB</b> structure. Instead, it is returned by the
    ///Netbios function. </td> </tr> <tr> <td>NRC_LOCKFAIL</td> <td>The attempt to lock the user area failed.</td> </tr>
    ///<tr> <td>NRC_OPENERR</td> <td>An error occurred during an open operation being performed by the device driver.
    ///This error code is not part of the NetBIOS 3.0 specification.</td> </tr> <tr> <td>NRC_SYSTEM</td> <td>A system
    ///error occurred.</td> </tr> <tr> <td>NRC_PENDING</td> <td>An asynchronous operation is not yet finished.</td>
    ///</tr> </table>
    ubyte     ncb_retcode;
    ///Identifies the local session number. This number uniquely identifies a session within an environment. This number
    ///is returned by the Netbios function after a successful NCBCALL command.
    ubyte     ncb_lsn;
    ///Specifies the number for the local network name. This number is returned by Netbios after a successful
    ///<b>NCBADDNAME</b> or <b>NCBADDGRNAME</b> command. This number, not the name, must be used with all datagram
    ///commands and for <b>NCBRECVANY</b> commands. The number for <b>NAME_NUMBER_1</b> is always 0x01. The Netbios
    ///function assigns values in the range 0x02 to 0xFE for the remaining names.
    ubyte     ncb_num;
    ///Pointer to the message buffer. The buffer must have write access. Its uses are as follows: <table> <tr>
    ///<th>Command</th> <th>Purpose</th> </tr> <tr> <td>NCBSEND</td> <td>Contains the message to be sent. </td> </tr>
    ///<tr> <td>NCBRECV</td> <td>Receives the message. </td> </tr> <tr> <td>NCBSSTAT</td> <td>Receives the requested
    ///status information.</td> </tr> </table>
    ubyte*    ncb_buffer;
    ///Specifies the size, in bytes, of the message buffer. For receive commands, this member is set by the Netbios
    ///function to indicate the number of bytes received. If the buffer length is incorrect, the Netbios function
    ///returns the <b>NRC_BUFLEN</b> error code.
    ushort    ncb_length;
    ///Specifies the name of the remote application. Trailing-space characters should be supplied to make the length of
    ///the string equal to <b>NCBNAMSZ</b>.
    ubyte[16] ncb_callname;
    ///Specifies the name by which the application is known. Trailing-space characters should be supplied to make the
    ///length of the string equal to <b>NCBNAMSZ</b>.
    ubyte[16] ncb_name;
    ///Specifies the time-out period for receive operations, in 500-millisecond units, for the session. A value of zero
    ///implies no time-out. Specify with the <b>NCBCALL</b> or <b>NCBLISTEN</b> command. Affects subsequent
    ///<b>NCBRECV</b> commands.
    ubyte     ncb_rto;
    ///Specifies the time-out period for send operations, in 500-millisecond units, for the session. A value of zero
    ///implies no time-out. Specify with the <b>NCBCALL</b> or <b>NCBLISTEN</b> command. Affects subsequent
    ///<b>NCBSEND</b> and <b>NCBCHAINSEND</b> commands.
    ubyte     ncb_sto;
    ///Specifies the address of the post routine to call when the asynchronous command is completed. The post routine is
    ///defined as: NCB_POST PostRoutine( PNCB <i>pncb</i> ); where the <i>pncb</i> parameter is a pointer to the
    ///completed <b>NCB</b> structure.
    ptrdiff_t ncb_post;
    ///Specifies the LAN adapter number. This zero-based number corresponds to a particular transport provider using a
    ///particular LAN adapter board.
    ubyte     ncb_lana_num;
    ///Specifies the command complete flag. This value is the same as the <b>ncb_retcode</b> member.
    ubyte     ncb_cmd_cplt;
    ///Reserved; must be zero. The length, X, of the <b>ncb_reserve</b> array is dependent upon the system architecture.
    ///For 64-bit systems, the array contains 18 elements. Otherwise, the array contains 10 elements.
    ubyte[10] ncb_reserve;
    ///Specifies a handle to an event object that is set to the nonsignaled state when an asynchronous command is
    ///accepted, and it is set to the signaled state when the asynchronous command is completed. The event is signaled
    ///if the Netbios function returns a nonzero value. Only manual reset events should be used for synchronization. A
    ///specified event should not be associated with more than one active asynchronous command. The <b>ncb_event</b>
    ///member must be zero if the <b>ncb_command</b> member does not have the <b>ASYNCH</b> flag set or if
    ///<b>ncb_post</b> is nonzero. Otherwise, Netbios returns the <b>NRC_ILLCMD</b> error code.
    HANDLE    ncb_event;
}

///<p class="CCE_Message">[Netbios is not supported on Windows Vista, Windows Server 2008, and subsequent versions of
///the operating system] The <b>ADAPTER_STATUS</b> structure contains information about a network adapter. This
///structure is pointed to by the <b>ncb_buffer</b> member of the NCB structure. <b>ADAPTER_STATUS</b> is followed by as
///many NAME_BUFFER structures as required to describe the network adapters on the system.
struct ADAPTER_STATUS
{
    ///Specifies encoded address of the adapter.
    ubyte[6] adapter_address;
    ///Specifies the major software-release level. This value is 3 for IBM NetBIOS 3. x.
    ubyte    rev_major;
    ///Reserved. This value is always zero.
    ubyte    reserved0;
    ///Specifies the adapter type. This value is 0xFF for a Token Ring adapter or 0xFE for an Ethernet adapter.
    ubyte    adapter_type;
    ///Specifies the minor software-release level. This value is zero for IBM NetBIOS x.0.
    ubyte    rev_minor;
    ///Specifies the duration of the reporting period, in minutes.
    ushort   duration;
    ///Specifies the number of FRMR frames received.
    ushort   frmr_recv;
    ///Specifies the number of FRMR frames transmitted.
    ushort   frmr_xmit;
    ///Specifies the number of I frames received in error.
    ushort   iframe_recv_err;
    ///Specifies the number of aborted transmissions.
    ushort   xmit_aborts;
    ///Specifies the number of successfully transmitted packets.
    uint     xmit_success;
    ///Specifies the number of successfully received packets.
    uint     recv_success;
    ///Specifies the number of I frames transmitted in error.
    ushort   iframe_xmit_err;
    ///Specifies the number of times a buffer was not available to service a request from a remote computer.
    ushort   recv_buff_unavail;
    ///Specifies the number of times that the DLC T1 timer timed out. <b>Windows 95: </b>DLC is no longer supported.
    ushort   t1_timeouts;
    ///Specifies the number of times that the ti inactivity timer timed out. The ti timer is used to detect links that
    ///have been broken.
    ushort   ti_timeouts;
    ///Reserved. This value is always zero.
    uint     reserved1;
    ///Specifies the current number of free network control blocks.
    ushort   free_ncbs;
    ///Undefined for IBM NetBIOS 3.0.
    ushort   max_cfg_ncbs;
    ///Undefined for IBM NetBIOS 3.0.
    ushort   max_ncbs;
    ///Undefined for IBM NetBIOS 3.0.
    ushort   xmit_buf_unavail;
    ///Specifies the maximum size of a datagram packet. This value is always at least 512 bytes.
    ushort   max_dgram_size;
    ///Specifies the number of pending sessions.
    ushort   pending_sess;
    ///Specifies the configured maximum pending sessions.
    ushort   max_cfg_sess;
    ///Undefined for IBM NetBIOS 3.0.
    ushort   max_sess;
    ///Specifies the maximum size of a session data packet.
    ushort   max_sess_pkt_size;
    ///Specifies the number of names in the local names table.
    ushort   name_count;
}

///<p class="CCE_Message">[Netbios is not supported on Windows Vista, Windows Server 2008, and subsequent versions of
///the operating system] The <b>NAME_BUFFER</b> structure contains information about a local network name. One or more
///<b>NAME_BUFFER</b> structures follows an ADAPTER_STATUS structure when an application specifies the <b>NCBASTAT</b>
///command in the ncb_command member of the NCB structure.
struct NAME_BUFFER
{
    ///Specifies the local network name. This value is in the <b>ncb_name</b> member of the NCB structure.
    ubyte[16] name;
    ///Specifies the number for the local network name. This value is in the <b>ncb_num</b> member of the NCB structure.
    ubyte     name_num;
    ///Specifies the current state of the name table entry. This member can be one of the following values.
    ///**REGISTERED** The name specified by the name member has been successfully added to the network. **DEREGISTERED**
    ///The name specified by the name member has an active session when an NCBDELNAME command is issued. The name will
    ///be removed from the name table when the session is closed. **DUPLICATE** A duplicate name was detected during
    ///registration. **DUPLICATE_DEREG** A duplicate name was detected with a pending deregistration. **GROUP_NAME** The
    ///name specified by the name member was created by using the NCBADDGRNAME command. **UNIQUE_NAME** The name
    ///specified by the name member was created by using the NCBADDNAME command.
    ubyte     name_flags;
}

///<p class="CCE_Message">[Netbios is not supported on Windows Vista, Windows Server 2008, and subsequent versions of
///the operating system] The <b>SESSION_HEADER</b> structure contains information about a network session. This
///structure is pointed to by the <b>ncb_buffer</b> member of the NCB structure. <b>SESSION_HEADER</b> is followed by as
///many SESSION_BUFFER structures as are required to describe the current network sessions.
struct SESSION_HEADER
{
    ///Specifies the name number of the session. This value corresponds to the <b>ncb_num</b> member of the NCB
    ///structure.
    ubyte sess_name;
    ///Specifies the number of sessions that have the name specified by the <b>sess_name</b> member.
    ubyte num_sess;
    ///Specifies the number of outstanding <b>NCBDGRECV</b> and <b>NCBDGRECVBC</b> commands.
    ubyte rcv_dg_outstanding;
    ///Specifies the number of outstanding <b>NCBRECVANY</b> commands.
    ubyte rcv_any_outstanding;
}

///<p class="CCE_Message">[Netbios is not supported on Windows Vista, Windows Server 2008, and subsequent versions of
///the operating system] The <b>SESSION_BUFFER</b> structure contains information about a local network session. One or
///more <b>SESSION_BUFFER</b> structures follows a SESSION_HEADER structure when an application specifies the
///<b>NCBSSTAT</b> command in the <b>ncb_command</b> member of the NCB structure.
struct SESSION_BUFFER
{
    ///Specifies the local session number.
    ubyte     lsn;
    ///Specifies the state of the session. This member can be one of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="LISTEN_OUTSTANDING"></a><a id="listen_outstanding"></a><dl>
    ///<dt><b>LISTEN_OUTSTANDING</b></dt> </dl> </td> <td width="60%"> The session is waiting for a call from a remote
    ///computer. </td> </tr> <tr> <td width="40%"><a id="CALL_PENDING"></a><a id="call_pending"></a><dl>
    ///<dt><b>CALL_PENDING</b></dt> </dl> </td> <td width="60%"> The session is attempting to connect to a remote
    ///computer. </td> </tr> <tr> <td width="40%"><a id="SESSION_ESTABLISHED"></a><a id="session_established"></a><dl>
    ///<dt><b>SESSION_ESTABLISHED</b></dt> </dl> </td> <td width="60%"> The session connected and is able to transfer
    ///data. </td> </tr> <tr> <td width="40%"><a id="HANGUP_PENDING"></a><a id="hangup_pending"></a><dl>
    ///<dt><b>HANGUP_PENDING</b></dt> </dl> </td> <td width="60%"> The session is being deleted due to a command by the
    ///local user. </td> </tr> <tr> <td width="40%"><a id="HANGUP_COMPLETE"></a><a id="hangup_complete"></a><dl>
    ///<dt><b>HANGUP_COMPLETE</b></dt> </dl> </td> <td width="60%"> The session was deleted due to a command by the
    ///local user. </td> </tr> <tr> <td width="40%"><a id="SESSION_ABORTED"></a><a id="session_aborted"></a><dl>
    ///<dt><b>SESSION_ABORTED</b></dt> </dl> </td> <td width="60%"> The session was abandoned due to a network or user
    ///problem. </td> </tr> </table>
    ubyte     state;
    ///Specifies the 16-byte NetBIOS name on the local computer used for this session.
    ubyte[16] local_name;
    ///Specifies the 16-byte NetBIOS name on the remote computer used for this session.
    ubyte[16] remote_name;
    ///Specifies the number of pending <b>NCBRECV</b> commands.
    ubyte     rcvs_outstanding;
    ///Specifies the number of pending <b>NCBSEND</b> and <b>NCBCHAINSEND</b> commands.
    ubyte     sends_outstanding;
}

///<p class="CCE_Message">[Netbios is not supported on Windows Vista, Windows Server 2008, and subsequent versions of
///the operating system] The <b>LANA_ENUM</b> structure contains the numbers for the current LAN adapters.
struct LANA_ENUM
{
    ///Specifies the number of valid entries in the array of LAN adapter numbers.
    ubyte      length;
    ///Specifies an array of LAN adapter numbers.
    ubyte[255] lana;
}

///<p class="CCE_Message">[Netbios is not supported on Windows Vista, Windows Server 2008, and subsequent versions of
///the operating system] The <b>FIND_NAME_HEADER</b> structure contains information about a network name. This structure
///is followed by as many FIND_NAME_BUFFER structures as are required to describe the name.
struct FIND_NAME_HEADER
{
    ///Specifies the number of nodes on which the specified name was found. This structure is followed by the number of
    ///FIND_NAME_BUFFER structures specified by the <b>node_count</b> member.
    ushort node_count;
    ///Reserved
    ubyte  reserved;
    ///Specifies whether the name is unique. This value is 0 to specify a unique name or 1 to specify a group.
    ubyte  unique_group;
}

///<p class="CCE_Message">[Netbios is not supported on Windows Vista, Windows Server 2008, and subsequent versions of
///the operating system] The <b>FIND_NAME_BUFFER</b> structure contains information about a local network session. One
///or more <b>FIND_NAME_BUFFER</b> structures follows a FIND_NAME_HEADER structure when an application specifies the
///<b>NCBFINDNAME</b> command in the ncb_command member of the NCB structure.
struct FIND_NAME_BUFFER
{
    ///Specifies the length, in bytes, of the <b>FIND_NAME_BUFFER</b> structure. Although this structure always occupies
    ///33 bytes, not all of the structure is necessarily valid.
    ubyte     length;
    ///Specifies the access control for the LAN header.
    ubyte     access_control;
    ///Specifies the frame control for the LAN header.
    ubyte     frame_control;
    ///Specifies the destination address of the remote node where the name was found.
    ubyte[6]  destination_addr;
    ///Specifies the source address for the remote node where the name was found.
    ubyte[6]  source_addr;
    ///Specifies additional routing information.
    ubyte[18] routing_info;
}

///<p class="CCE_Message">[Netbios is not supported on Windows Vista, Windows Server 2008, and subsequent versions of
///the operating system] The ACTION_HEADER structure contains information about an action. This action is an extension
///to the standard transport interface.
struct ACTION_HEADER
{
    ///Specifies the transport provider. This member can be used to check the validity of the request by the transport.
    ///This member is always a four-character string. All strings starting with the letter M are reserved, as shown in
    ///the following example.
    uint   transport_id;
    ///Specifies the action.
    ushort action_code;
    ///Reserved.
    ushort reserved;
}

// Functions

///<p class="CCE_Message">[Netbios is not supported on Windows Vista, Windows Server 2008, and subsequent versions of
///the operating system] The <b>Netbios</b> function interprets and executes the specified network control block (NCB).
///The <b>Netbios</b> function is provided primarily for applications that were written for the NetBIOS interface and
///need to be ported to Windows. Applications not requiring compatibility with NetBIOS should use other interfaces, such
///as Windows Sockets, mailslots, named pipes, RPC, or distributed COM to accomplish tasks similar to those supported by
///NetBIOS. These other interfaces are more flexible and portable.
///Params:
///    pncb = A pointer to an NCB structure that describes the network control block.
///Returns:
///    For synchronous requests, the return value is the return code in the NCB structure. That value is also returned
///    in the <b>ncb_retcode</b> member of the <b>NCB</b> structure. For asynchronous requests, there are the following
///    possibilities: <ul> <li>If the asynchronous command has already completed when <b>Netbios</b> returns to its
///    caller, the return value is the return code of the NCB structure, just as if it were a synchronous NCB
///    structure.</li> <li>If the asynchronous command is still pending when <b>Netbios</b> returns to its caller, the
///    return value is zero.</li> </ul> If the address specified by the pncb parameter is invalid, the return value is
///    <b>NRC_BADNCB</b>. If the buffer length specified in the <b>ncb_length</b> member of the NCB structure is
///    incorrect, or if the buffer specified by the <b>ncb_retcode</b> member is protected from write operations, the
///    return value is <b>NRC_BUFLEN</b>.
///    
@DllImport("NETAPI32")
ubyte Netbios(NCB* pncb);


