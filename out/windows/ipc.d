// Written in the D programming language.

module windows.ipc;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE, PSTR, SECURITY_ATTRIBUTES;

extern(Windows) @nogc nothrow:


// Functions

///Creates an instance of a named pipe and returns a handle for subsequent pipe operations. A named pipe server process
///uses this function either to create the first instance of a specific named pipe and establish its basic attributes or
///to create a new instance of an existing named pipe.
///Params:
///    lpName = The unique pipe name. This string must have the following form: \\\\.\\pipe&
///    dwOpenMode = The open mode. The function fails if <i>dwOpenMode</i> specifies anything other than 0 or the flags listed in the
///                 following tables. This parameter must specify one of the following pipe access modes. The same mode must be
///                 specified for each instance of the pipe. <table> <tr> <th>Mode</th> <th>Meaning</th> </tr> <tr> <td
///                 width="40%"><a id="PIPE_ACCESS_DUPLEX"></a><a id="pipe_access_duplex"></a><dl> <dt><b>PIPE_ACCESS_DUPLEX</b></dt>
///                 <dt>0x00000003</dt> </dl> </td> <td width="60%"> The pipe is bi-directional; both server and client processes can
///                 read from and write to the pipe. This mode gives the server the equivalent of <b>GENERIC_READ</b> and
///                 <b>GENERIC_WRITE</b> access to the pipe. The client can specify <b>GENERIC_READ</b> or <b>GENERIC_WRITE</b>, or
///                 both, when it connects to the pipe using the CreateFile function. </td> </tr> <tr> <td width="40%"><a
///                 id="PIPE_ACCESS_INBOUND"></a><a id="pipe_access_inbound"></a><dl> <dt><b>PIPE_ACCESS_INBOUND</b></dt>
///                 <dt>0x00000001</dt> </dl> </td> <td width="60%"> The flow of data in the pipe goes from client to server only.
///                 This mode gives the server the equivalent of <b>GENERIC_READ</b> access to the pipe. The client must specify
///                 <b>GENERIC_WRITE</b> access when connecting to the pipe. If the client must read pipe settings by calling the
///                 GetNamedPipeInfo or GetNamedPipeHandleState functions, the client must specify <b>GENERIC_WRITE</b> and
///                 <b>FILE_READ_ATTRIBUTES</b> access when connecting to the pipe. </td> </tr> <tr> <td width="40%"><a
///                 id="PIPE_ACCESS_OUTBOUND"></a><a id="pipe_access_outbound"></a><dl> <dt><b>PIPE_ACCESS_OUTBOUND</b></dt>
///                 <dt>0x00000002</dt> </dl> </td> <td width="60%"> The flow of data in the pipe goes from server to client only.
///                 This mode gives the server the equivalent of <b>GENERIC_WRITE</b> access to the pipe. The client must specify
///                 <b>GENERIC_READ</b> access when connecting to the pipe. If the client must change pipe settings by calling the
///                 SetNamedPipeHandleState function, the client must specify <b>GENERIC_READ</b> and <b>FILE_WRITE_ATTRIBUTES</b>
///                 access when connecting to the pipe. </td> </tr> </table> This parameter can also include one or more of the
///                 following flags, which enable the write-through and overlapped modes. These modes can be different for different
///                 instances of the same pipe. <table> <tr> <th>Mode</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                 id="FILE_FLAG_FIRST_PIPE_INSTANCE"></a><a id="file_flag_first_pipe_instance"></a><dl>
///                 <dt><b>FILE_FLAG_FIRST_PIPE_INSTANCE</b></dt> <dt>0x00080000</dt> </dl> </td> <td width="60%"> If you attempt to
///                 create multiple instances of a pipe with this flag, creation of the first instance succeeds, but creation of the
///                 next instance fails with <b>ERROR_ACCESS_DENIED</b>. </td> </tr> <tr> <td width="40%"><a
///                 id="FILE_FLAG_WRITE_THROUGH"></a><a id="file_flag_write_through"></a><dl> <dt><b>FILE_FLAG_WRITE_THROUGH</b></dt>
///                 <dt>0x80000000</dt> </dl> </td> <td width="60%"> Write-through mode is enabled. This mode affects only write
///                 operations on byte-type pipes and, then, only when the client and server processes are on different computers. If
///                 this mode is enabled, functions writing to a named pipe do not return until the data written is transmitted
///                 across the network and is in the pipe's buffer on the remote computer. If this mode is not enabled, the system
///                 enhances the efficiency of network operations by buffering data until a minimum number of bytes accumulate or
///                 until a maximum time elapses. </td> </tr> <tr> <td width="40%"><a id="FILE_FLAG_OVERLAPPED"></a><a
///                 id="file_flag_overlapped"></a><dl> <dt><b>FILE_FLAG_OVERLAPPED</b></dt> <dt>0x40000000</dt> </dl> </td> <td
///                 width="60%"> Overlapped mode is enabled. If this mode is enabled, functions performing read, write, and connect
///                 operations that may take a significant time to be completed can return immediately. This mode enables the thread
///                 that started the operation to perform other operations while the time-consuming operation executes in the
///                 background. For example, in overlapped mode, a thread can handle simultaneous input and output (I/O) operations
///                 on multiple instances of a pipe or perform simultaneous read and write operations on the same pipe handle. If
///                 overlapped mode is not enabled, functions performing read, write, and connect operations on the pipe handle do
///                 not return until the operation is finished. The ReadFileEx and WriteFileEx functions can only be used with a pipe
///                 handle in overlapped mode. The ReadFile, WriteFile, ConnectNamedPipe, and TransactNamedPipe functions can execute
///                 either synchronously or as overlapped operations. </td> </tr> </table> This parameter can include any combination
///                 of the following security access modes. These modes can be different for different instances of the same pipe.
///                 <table> <tr> <th>Mode</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WRITE_DAC"></a><a
///                 id="write_dac"></a><dl> <dt><b>WRITE_DAC</b></dt> <dt>0x00040000L</dt> </dl> </td> <td width="60%"> The caller
///                 will have write access to the named pipe's discretionary access control list (ACL). </td> </tr> <tr> <td
///                 width="40%"><a id="WRITE_OWNER"></a><a id="write_owner"></a><dl> <dt><b>WRITE_OWNER</b></dt> <dt>0x00080000L</dt>
///                 </dl> </td> <td width="60%"> The caller will have write access to the named pipe's owner. </td> </tr> <tr> <td
///                 width="40%"><a id="ACCESS_SYSTEM_SECURITY"></a><a id="access_system_security"></a><dl>
///                 <dt><b>ACCESS_SYSTEM_SECURITY</b></dt> <dt>0x01000000L</dt> </dl> </td> <td width="60%"> The caller will have
///                 write access to the named pipe's SACL. For more information, see Access-Control Lists (ACLs) and SACL Access
///                 Right. </td> </tr> </table>
///    dwPipeMode = The pipe mode. The function fails if <i>dwPipeMode</i> specifies anything other than 0 or the flags listed in the
///                 following tables. One of the following type modes can be specified. The same type mode must be specified for each
///                 instance of the pipe. <table> <tr> <th>Mode</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                 id="PIPE_TYPE_BYTE"></a><a id="pipe_type_byte"></a><dl> <dt><b>PIPE_TYPE_BYTE</b></dt> <dt>0x00000000</dt> </dl>
///                 </td> <td width="60%"> Data is written to the pipe as a stream of bytes. This mode cannot be used with
///                 PIPE_READMODE_MESSAGE. The pipe does not distinguish bytes written during different write operations. </td> </tr>
///                 <tr> <td width="40%"><a id="PIPE_TYPE_MESSAGE"></a><a id="pipe_type_message"></a><dl>
///                 <dt><b>PIPE_TYPE_MESSAGE</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> Data is written to the pipe as
///                 a stream of messages. The pipe treats the bytes written during each write operation as a message unit. The
///                 GetLastError function returns <b>ERROR_MORE_DATA</b> when a message is not read completely. This mode can be used
///                 with either <b>PIPE_READMODE_MESSAGE</b> or <b>PIPE_READMODE_BYTE</b>. </td> </tr> </table> One of the following
///                 read modes can be specified. Different instances of the same pipe can specify different read modes. <table> <tr>
///                 <th>Mode</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PIPE_READMODE_BYTE"></a><a
///                 id="pipe_readmode_byte"></a><dl> <dt><b>PIPE_READMODE_BYTE</b></dt> <dt>0x00000000</dt> </dl> </td> <td
///                 width="60%"> Data is read from the pipe as a stream of bytes. This mode can be used with either
///                 <b>PIPE_TYPE_MESSAGE</b> or <b>PIPE_TYPE_BYTE</b>. </td> </tr> <tr> <td width="40%"><a
///                 id="PIPE_READMODE_MESSAGE"></a><a id="pipe_readmode_message"></a><dl> <dt><b>PIPE_READMODE_MESSAGE</b></dt>
///                 <dt>0x00000002</dt> </dl> </td> <td width="60%"> Data is read from the pipe as a stream of messages. This mode
///                 can be only used if <b>PIPE_TYPE_MESSAGE</b> is also specified. </td> </tr> </table> One of the following wait
///                 modes can be specified. Different instances of the same pipe can specify different wait modes. <table> <tr>
///                 <th>Mode</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PIPE_WAIT"></a><a id="pipe_wait"></a><dl>
///                 <dt><b>PIPE_WAIT</b></dt> <dt>0x00000000</dt> </dl> </td> <td width="60%"> Blocking mode is enabled. When the
///                 pipe handle is specified in the ReadFile, WriteFile, or ConnectNamedPipe function, the operations are not
///                 completed until there is data to read, all data is written, or a client is connected. Use of this mode can mean
///                 waiting indefinitely in some situations for a client process to perform an action. </td> </tr> <tr> <td
///                 width="40%"><a id="PIPE_NOWAIT"></a><a id="pipe_nowait"></a><dl> <dt><b>PIPE_NOWAIT</b></dt> <dt>0x00000001</dt>
///                 </dl> </td> <td width="60%"> Nonblocking mode is enabled. In this mode, ReadFile, WriteFile, and ConnectNamedPipe
///                 always return immediately. Note that nonblocking mode is supported for compatibility with Microsoft LAN Manager
///                 version 2.0 and should not be used to achieve asynchronous I/O with named pipes. For more information on
///                 asynchronous pipe I/O, see Synchronous and Overlapped Input and Output. </td> </tr> </table> One of the following
///                 remote-client modes can be specified. Different instances of the same pipe can specify different remote-client
///                 modes. <table> <tr> <th>Mode</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                 id="PIPE_ACCEPT_REMOTE_CLIENTS"></a><a id="pipe_accept_remote_clients"></a><dl>
///                 <dt><b>PIPE_ACCEPT_REMOTE_CLIENTS</b></dt> <dt>0x00000000</dt> </dl> </td> <td width="60%"> Connections from
///                 remote clients can be accepted and checked against the security descriptor for the pipe. </td> </tr> <tr> <td
///                 width="40%"><a id="PIPE_REJECT_REMOTE_CLIENTS"></a><a id="pipe_reject_remote_clients"></a><dl>
///                 <dt><b>PIPE_REJECT_REMOTE_CLIENTS</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> Connections from
///                 remote clients are automatically rejected. </td> </tr> </table>
///    nMaxInstances = The maximum number of instances that can be created for this pipe. The first instance of the pipe can specify
///                    this value; the same number must be specified for other instances of the pipe. Acceptable values are in the range
///                    1 through <b>PIPE_UNLIMITED_INSTANCES</b> (255). If this parameter is <b>PIPE_UNLIMITED_INSTANCES</b>, the number
///                    of pipe instances that can be created is limited only by the availability of system resources. If
///                    <i>nMaxInstances</i> is greater than <b>PIPE_UNLIMITED_INSTANCES</b>, the return value is
///                    <b>INVALID_HANDLE_VALUE</b> and GetLastError returns <b>ERROR_INVALID_PARAMETER</b>.
///    nOutBufferSize = The number of bytes to reserve for the output buffer. For a discussion on sizing named pipe buffers, see the
///                     following Remarks section.
///    nInBufferSize = The number of bytes to reserve for the input buffer. For a discussion on sizing named pipe buffers, see the
///                    following Remarks section.
///    nDefaultTimeOut = The default time-out value, in milliseconds, if the WaitNamedPipe function specifies
///                      <b>NMPWAIT_USE_DEFAULT_WAIT</b>. Each instance of a named pipe must specify the same value. A value of zero will
///                      result in a default time-out of 50 milliseconds.
///    lpSecurityAttributes = A pointer to a SECURITY_ATTRIBUTES structure that specifies a security descriptor for the new named pipe and
///                           determines whether child processes can inherit the returned handle. If <i>lpSecurityAttributes</i> is
///                           <b>NULL</b>, the named pipe gets a default security descriptor and the handle cannot be inherited. The ACLs in
///                           the default security descriptor for a named pipe grant full control to the LocalSystem account, administrators,
///                           and the creator owner. They also grant read access to members of the Everyone group and the anonymous account.
///Returns:
///    If the function succeeds, the return value is a handle to the server end of a named pipe instance. If the
///    function fails, the return value is <b>INVALID_HANDLE_VALUE</b>. To get extended error information, call
///    GetLastError.
///    
@DllImport("KERNEL32")
HANDLE CreateNamedPipeA(const(PSTR) lpName, uint dwOpenMode, uint dwPipeMode, uint nMaxInstances, 
                        uint nOutBufferSize, uint nInBufferSize, uint nDefaultTimeOut, 
                        SECURITY_ATTRIBUTES* lpSecurityAttributes);

///Waits until either a time-out interval elapses or an instance of the specified named pipe is available for connection
///(that is, the pipe's server process has a pending ConnectNamedPipe operation on the pipe).
///Params:
///    lpNamedPipeName = The name of the named pipe. The string must include the name of the computer on which the server process is
///                      executing. A period may be used for the <i>servername</i> if the pipe is local. The following pipe name format is
///                      used: &
///    nTimeOut = The number of milliseconds that the function will wait for an instance of the named pipe to be available. You can
///               used one of the following values instead of specifying a number of milliseconds. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="NMPWAIT_USE_DEFAULT_WAIT"></a><a
///               id="nmpwait_use_default_wait"></a><dl> <dt><b>NMPWAIT_USE_DEFAULT_WAIT</b></dt> <dt>0x00000000</dt> </dl> </td>
///               <td width="60%"> The time-out interval is the default value specified by the server process in the
///               CreateNamedPipe function. </td> </tr> <tr> <td width="40%"><a id="NMPWAIT_WAIT_FOREVER"></a><a
///               id="nmpwait_wait_forever"></a><dl> <dt><b>NMPWAIT_WAIT_FOREVER</b></dt> <dt>0xffffffff</dt> </dl> </td> <td
///               width="60%"> The function does not return until an instance of the named pipe is available. </td> </tr> </table>
///Returns:
///    If an instance of the pipe is available before the time-out interval elapses, the return value is nonzero. If an
///    instance of the pipe is not available before the time-out interval elapses, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL WaitNamedPipeA(const(PSTR) lpNamedPipeName, uint nTimeOut);


