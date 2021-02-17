// Written in the D programming language.

module windows.rpc;

public import windows.core;
public import windows.com : HRESULT, IRpcChannelBuffer, IRpcStubBuffer, IUnknown;
public import windows.kernel : LUID;
public import windows.security : CERT_CONTEXT, SEC_WINNT_AUTH_IDENTITY_A,
                                 SEC_WINNT_AUTH_IDENTITY_W;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER, OVERLAPPED;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME, SYSTEMTIME;

extern(Windows):


// Enums


alias RPC_HTTP_REDIRECTOR_STAGE = int;
enum : int
{
    RPCHTTP_RS_REDIRECT  = 0x00000001,
    RPCHTTP_RS_ACCESS_1  = 0x00000002,
    RPCHTTP_RS_SESSION   = 0x00000003,
    RPCHTTP_RS_ACCESS_2  = 0x00000004,
    RPCHTTP_RS_INTERFACE = 0x00000005,
}

alias RPC_ADDRESS_CHANGE_TYPE = int;
enum : int
{
    PROTOCOL_NOT_LOADED     = 0x00000001,
    PROTOCOL_LOADED         = 0x00000002,
    PROTOCOL_ADDRESS_CHANGE = 0x00000003,
}

alias LRPC_SYSTEM_HANDLE_MARSHAL_DIRECTION = int;
enum : int
{
    MarshalDirectionMarshal   = 0x00000000,
    MarshalDirectionUnmarshal = 0x00000001,
}

enum RpcProxyPerfCounters : int
{
    RpcCurrentUniqueUser         = 0x00000001,
    RpcBackEndConnectionAttempts = 0x00000002,
    RpcBackEndConnectionFailed   = 0x00000003,
    RpcRequestsPerSecond         = 0x00000004,
    RpcIncomingConnections       = 0x00000005,
    RpcIncomingBandwidth         = 0x00000006,
    RpcOutgoingBandwidth         = 0x00000007,
    RpcAttemptedLbsDecisions     = 0x00000008,
    RpcFailedLbsDecisions        = 0x00000009,
    RpcAttemptedLbsMessages      = 0x0000000a,
    RpcFailedLbsMessages         = 0x0000000b,
    RpcLastCounter               = 0x0000000c,
}

///The <b>RPC_NOTIFICATION_TYPES</b> enumerated type contains values that specify the method of asynchronous
///notification that a client program will use.
alias RPC_NOTIFICATION_TYPES = int;
enum : int
{
    ///The client does not require notification of the completion of an asynchronous remote procedure call.
    RpcNotificationTypeNone     = 0x00000000,
    ///Notify the client program by signaling an event object. See Event Objects.
    RpcNotificationTypeEvent    = 0x00000001,
    ///Use an asynchronous procedure call to notify the client that the remote procedure call is complete.
    RpcNotificationTypeApc      = 0x00000002,
    ///Send the asynchronous RPC notification to the client through an I/O completion port.
    RpcNotificationTypeIoc      = 0x00000003,
    ///Post a notification message to the specified window handle.
    RpcNotificationTypeHwnd     = 0x00000004,
    ///Invoke a callback function provided by the client program.
    RpcNotificationTypeCallback = 0x00000005,
}

///The <b>RPC_ASYNC_EVENT</b> enumerated type describes the asynchronous notification events that an RPC application can
///receive.
alias RPC_ASYNC_EVENT = int;
enum : int
{
    ///The remote procedure call has completely executed.
    RpcCallComplete     = 0x00000000,
    ///The RPC run-time library finished transmitting some of the data provided by the user. A portion, but not
    ///necessarily all of the data being sent, has been transmitted. Only applications using DCE pipes will receive this
    ///notification.
    RpcSendComplete     = 0x00000001,
    ///The RPC run-time library finished receiving data. Only applications using DCE pipes will receive this
    ///notification.
    RpcReceiveComplete  = 0x00000002,
    ///The RPC client has disconnected from the service.
    RpcClientDisconnect = 0x00000003,
    RpcClientCancel     = 0x00000004,
}

enum ExtendedErrorParamTypes : int
{
    eeptAnsiString    = 0x00000001,
    eeptUnicodeString = 0x00000002,
    eeptLongVal       = 0x00000003,
    eeptShortVal      = 0x00000004,
    eeptPointerVal    = 0x00000005,
    eeptNone          = 0x00000006,
    eeptBinary        = 0x00000007,
}

///The <b>RpcLocalAddressFormat</b> enumeration specifies the possible local IP address formats supported by RPC.
enum RpcLocalAddressFormat : int
{
    ///The address format is not supported.
    rlafInvalid = 0x00000000,
    ///The address format is IP version 4.
    rlafIPv4    = 0x00000001,
    ///The address format is IP version 6.
    rlafIPv6    = 0x00000002,
}

///The <b>RpcCallType</b> enumeration specifies the set of RPC call types.
enum RpcCallType : int
{
    ///The remote procedure call is invalid.
    rctInvalid    = 0x00000000,
    ///The remote procedure call has no special properties.
    rctNormal     = 0x00000001,
    ///The remote procedure call is used for "training" RPC.
    rctTraining   = 0x00000002,
    ///The remote procedure call has guaranteed execution.
    rctGuaranteed = 0x00000003,
}

///The <b>RpcCallClientLocality</b> enumeration specifies the set of possible RPC client localities.
enum RpcCallClientLocality : int
{
    ///The RPC client locality is invalid.
    rcclInvalid               = 0x00000000,
    ///The RPC client is local.
    rcclLocal                 = 0x00000001,
    ///The RPC client is remote.
    rcclRemote                = 0x00000002,
    ///The RPC client has an unknown locality.
    rcclClientUnknownLocality = 0x00000003,
}

///The <b>RPC_NOTIFICATIONS</b> enumeration specifies the notifications a server can receive from RPC.
alias RPC_NOTIFICATIONS = int;
enum : int
{
    ///Do not send a notification. <b>Windows Vista: </b>Currently, this value is not supported for
    ///RpcServerSubscribeForNotification and RpcServerUnsubscribeForNotification.
    RpcNotificationCallNone         = 0x00000000,
    ///The client has disconnected.
    RpcNotificationClientDisconnect = 0x00000001,
    ///The RPC call has been canceled.
    RpcNotificationCallCancel       = 0x00000002,
}

alias USER_MARSHAL_CB_TYPE = int;
enum : int
{
    USER_MARSHAL_CB_BUFFER_SIZE = 0x00000000,
    USER_MARSHAL_CB_MARSHALL    = 0x00000001,
    USER_MARSHAL_CB_UNMARSHALL  = 0x00000002,
    USER_MARSHAL_CB_FREE        = 0x00000003,
}

alias IDL_CS_CONVERT = int;
enum : int
{
    IDL_CS_NO_CONVERT         = 0x00000000,
    IDL_CS_IN_PLACE_CONVERT   = 0x00000001,
    IDL_CS_NEW_BUFFER_CONVERT = 0x00000002,
}

alias XLAT_SIDE = int;
enum : int
{
    XLAT_SERVER = 0x00000001,
    XLAT_CLIENT = 0x00000002,
}

alias system_handle_t = int;
enum : int
{
    SYSTEM_HANDLE_FILE               = 0x00000000,
    SYSTEM_HANDLE_SEMAPHORE          = 0x00000001,
    SYSTEM_HANDLE_EVENT              = 0x00000002,
    SYSTEM_HANDLE_MUTEX              = 0x00000003,
    SYSTEM_HANDLE_PROCESS            = 0x00000004,
    SYSTEM_HANDLE_TOKEN              = 0x00000005,
    SYSTEM_HANDLE_SECTION            = 0x00000006,
    SYSTEM_HANDLE_REG_KEY            = 0x00000007,
    SYSTEM_HANDLE_THREAD             = 0x00000008,
    SYSTEM_HANDLE_COMPOSITION_OBJECT = 0x00000009,
    SYSTEM_HANDLE_SOCKET             = 0x0000000a,
    SYSTEM_HANDLE_JOB                = 0x0000000b,
    SYSTEM_HANDLE_PIPE               = 0x0000000c,
    SYSTEM_HANDLE_MAX                = 0x0000000c,
    SYSTEM_HANDLE_INVALID            = 0x000000ff,
}

alias STUB_PHASE = int;
enum : int
{
    STUB_UNMARSHAL              = 0x00000000,
    STUB_CALL_SERVER            = 0x00000001,
    STUB_MARSHAL                = 0x00000002,
    STUB_CALL_SERVER_NO_HRESULT = 0x00000003,
}

alias PROXY_PHASE = int;
enum : int
{
    PROXY_CALCSIZE    = 0x00000000,
    PROXY_GETBUFFER   = 0x00000001,
    PROXY_MARSHAL     = 0x00000002,
    PROXY_SENDRECEIVE = 0x00000003,
    PROXY_UNMARSHAL   = 0x00000004,
}

alias MIDL_ES_CODE = int;
enum : int
{
    MES_ENCODE       = 0x00000000,
    MES_DECODE       = 0x00000001,
    MES_ENCODE_NDR64 = 0x00000002,
}

alias MIDL_ES_HANDLE_STYLE = int;
enum : int
{
    MES_INCREMENTAL_HANDLE    = 0x00000000,
    MES_FIXED_BUFFER_HANDLE   = 0x00000001,
    MES_DYNAMIC_BUFFER_HANDLE = 0x00000002,
}

// Constants


enum int MidlInterceptionInfoVersionOne = 0x00000001;

// Callbacks

///The <b>RPC_OBJECT_INQ_FN</b> function is a prototype for a function that facilitates replacement of the default
///object UUID to type UUID mapping.
///Params:
///    ObjectUuid = Pointer to the variable that specifies the object UUID that is to be mapped to a type UUID.
///    TypeUuid = Pointer to the address of the variable that is to contain the type UUID derived from the object UUID. The type
///               UUID is returned by the function.
///    Status = Pointer to a return value for the function.
alias RPC_OBJECT_INQ_FN = void function(GUID* ObjectUuid, GUID* TypeUuid, int* Status);
///The <b>RPC_IF_CALLBACK_FN</b> is a prototype for a security-callback function that your application supplies. Your
///program can provide a callback function for each interface it defines.
///Params:
///    InterfaceUuid = 
///    Context = Pointer to an RPC_IF_ID server binding handle representing the client. In the function declaration, this must be
///              of type RPC_IF_HANDLE, but it is a client binding handle and can be safely cast to it. The callback function may
///              pass this handle to RpcImpersonateClient, RpcBindingServerFromClient, RpcGetAuthorizationContextForClient, or any
///              other server side function that accepts a client binding handle to obtain information about the client.
///Returns:
///    The callback function should return RPC_S_OK if the client is allowed to call methods in this interface. Any
///    other return code will cause the client to receive the exception RPC_S_ACCESS_DENIED. <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
alias RPC_IF_CALLBACK_FN = int function(void* InterfaceUuid, void* Context);
alias RPC_SECURITY_CALLBACK_FN = void function(void* Context);
alias RPC_NEW_HTTP_PROXY_CHANNEL = int function(RPC_HTTP_REDIRECTOR_STAGE RedirectorStage, ushort* ServerName, 
                                                ushort* ServerPort, ushort* RemoteUser, ushort* AuthType, 
                                                void* ResourceUuid, void* SessionId, void* Interface, void* Reserved, 
                                                uint Flags, ushort** NewServerName, ushort** NewServerPort);
alias RPC_HTTP_PROXY_FREE_STRING = void function(ushort* String);
///The <i>RPC_AUTH_KEY_RETRIEVAL_FN</i> function is a prototype for a function that specifies the address of a
///server-application-provided routine returning encryption keys.
///Params:
///    Arg = Pointer to a user-defined argument to the user-supplied encryption key acquisition function. The RPC run-time
///          library uses the <i>Arg</i> parameter supplied to RpcServerRegisterAuthInfo.
///    ServerPrincName = Pointer to the principal name to use for the server when authenticating remote procedure calls. The RPC run-time
///                      library uses the <i>ServerPrincName</i> parameter supplied to RpcServerRegisterAuthInfo.
///    KeyVer = Value that the RPC run-time library automatically provides for the key-version parameter. When the value is zero,
///             the acquisition function must return the most recent key available.
///    Status = Pointer to the status returned by the acquisition function when it is called by the RPC run-time library to
///             authenticate the client RPC request. If the status is other than RPC_S_OK, the request fails and the run-time
///             library returns the error status to the client application.
///    Key = Pointer to a pointer to the authentication key returned by the user-supplied function.
alias RPC_AUTH_KEY_RETRIEVAL_FN = void function(void* Arg, ushort* ServerPrincName, uint KeyVer, void** Key, 
                                                int* Status);
///The <i>RPC_MGMT_AUTHORIZATION_FN</i> enables server programs to implement custom RPC authorization techniques.
///Params:
///    ClientBinding = Client/server binding handle.
///    RequestedMgmtOperation = The value for <i>RequestedMgmtOperation</i> depends on the remote function requested, as shown in the following
///                             table. <table> <tr> <th>Called remote function</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                             id="RpcMgmtInqIfIds"></a><a id="rpcmgmtinqifids"></a><a id="RPCMGMTINQIFIDS"></a><dl>
///                             <dt><b>RpcMgmtInqIfIds</b></dt> </dl> </td> <td width="60%"> RPC_C_MGMT_INQ_IF_IDS </td> </tr> <tr> <td
///                             width="40%"><a id="RpcMgmtInqServerPrincName"></a><a id="rpcmgmtinqserverprincname"></a><a
///                             id="RPCMGMTINQSERVERPRINCNAME"></a><dl> <dt><b>RpcMgmtInqServerPrincName</b></dt> </dl> </td> <td width="60%">
///                             RPC_C_MGMT_INQ_PRINC_NAME </td> </tr> <tr> <td width="40%"><a id="RpcMgmtInqStats"></a><a
///                             id="rpcmgmtinqstats"></a><a id="RPCMGMTINQSTATS"></a><dl> <dt><b>RpcMgmtInqStats</b></dt> </dl> </td> <td
///                             width="60%"> RPC_C_MGMT_INQ_STATS </td> </tr> <tr> <td width="40%"><a id="RpcMgmtIsServerListening"></a><a
///                             id="rpcmgmtisserverlistening"></a><a id="RPCMGMTISSERVERLISTENING"></a><dl>
///                             <dt><b>RpcMgmtIsServerListening</b></dt> </dl> </td> <td width="60%"> RPC_C_MGMT_IS_SERVER_LISTEN </td> </tr>
///                             <tr> <td width="40%"><a id="RpcMgmtStopServerListening"></a><a id="rpcmgmtstopserverlistening"></a><a
///                             id="RPCMGMTSTOPSERVERLISTENING"></a><dl> <dt><b>RpcMgmtStopServerListening</b></dt> </dl> </td> <td width="60%">
///                             RPC_C_MGMT_STOP_SERVER_LISTEN </td> </tr> </table> The authorization function must handle all of these values.
///    Status = If <i>Status</i> is either 0 (zero) or RPC_S_OK, the <i>Status</i> value RPC_S_ACCESS_DENIED is returned to the
///             client by the remote management function. If the authorization function returns any other value for
///             <i>Status</i>, that <i>Status</i> value is returned to the client by the remote management function.
///Returns:
///    Returns <b>TRUE</b> if the calling client is allowed access to the requested management function. If the
///    authorization function returns <b>FALSE</b>, the management function cannot execute. In this case, the function
///    returns a <i>Status</i> value to the client:
///    
alias RPC_MGMT_AUTHORIZATION_FN = int function(void* ClientBinding, uint RequestedMgmtOperation, int* Status);
///The <b>RPC_INTERFACE_GROUP_IDLE_CALLBACK_FN</b> is a user-defined callback that can be implemented for each defined
///interface group. This callback is invoked by the RPC runtime when it detects that the idle state of an interface
///group has changed.
///Params:
///    IfGroup = A <b>RPC_INTERFACE_GROUP</b> from RpcServerInterfaceGroupCreate that defines the interface group for which the
///              idle state has changed.
///    IdleCallbackContext = A user-defined context provided at interface group creation.
///    IsGroupIdle = <b>TRUE</b> if the interface group has just become idle. <b>FALSE</b> if the interface group was previously idle
///                  but has since received new activity.
alias RPC_INTERFACE_GROUP_IDLE_CALLBACK_FN = void function(void* IfGroup, void* IdleCallbackContext, 
                                                           uint IsGroupIdle);
alias RPC_FORWARD_FUNCTION = int function(GUID* InterfaceId, RPC_VERSION* InterfaceVersion, GUID* ObjectId, 
                                          ubyte* Rpcpro, void** ppDestEndpoint);
alias RPC_ADDRESS_CHANGE_FN = void function(void* arg);
alias RPC_DISPATCH_FUNCTION = void function(RPC_MESSAGE* Message);
alias PRPC_RUNDOWN = void function(void* AssociationContext);
alias RPCLT_PDU_FILTER_FUNC = void function(void* Buffer, uint BufferLength, int fDatagram);
alias RPC_SETFILTER_FUNC = void function(RPCLT_PDU_FILTER_FUNC pfnFilter);
alias RPC_BLOCKING_FN = int function(void* hWnd, void* Context, void* hSyncEvent);
alias I_RpcProxyIsValidMachineFn = int function(ushort* Machine, ushort* DotMachine, uint PortNumber);
alias I_RpcProxyGetClientAddressFn = int function(void* Context, byte* Buffer, uint* BufferLength);
alias I_RpcProxyGetConnectionTimeoutFn = int function(uint* ConnectionTimeout);
alias I_RpcPerformCalloutFn = int function(void* Context, RDR_CALLOUT_STATE* CallOutState, 
                                           RPC_HTTP_REDIRECTOR_STAGE Stage);
alias I_RpcFreeCalloutStateFn = void function(RDR_CALLOUT_STATE* CallOutState);
alias I_RpcProxyGetClientSessionAndResourceUUID = int function(void* Context, int* SessionIdPresent, 
                                                               GUID* SessionId, int* ResourceIdPresent, 
                                                               GUID* ResourceId);
alias I_RpcProxyFilterIfFn = int function(void* Context, GUID* IfUuid, ushort IfMajorVersion, int* fAllow);
alias I_RpcProxyUpdatePerfCounterFn = void function(RpcProxyPerfCounters Counter, int ModifyTrend, uint Size);
alias I_RpcProxyUpdatePerfCounterBackendServerFn = void function(ushort* MachineName, int IsConnectEvent);
///The <b>RPCNOTIFICATION_ROUTINE</b> function provides programs that utilize asynchronous RPC with the ability to
///customize responses to asynchronous events.
///Params:
///    pAsync = Pointer to a structure that contains the current state of the asynchronous RPC run-time library. For more
///             information, see RPC_ASYNC_STATE.
///    Context = Reserved for future use. Windows 2000 currently sets this parameter to <b>NULL</b>.
///    Event = A value from the RPC_ASYNC_EVENT enumerated type that identifies the current asynchronous event.
alias RPCNOTIFICATION_ROUTINE = void function(RPC_ASYNC_STATE* pAsync, void* Context, RPC_ASYNC_EVENT Event);
alias PFN_RPCNOTIFICATION_ROUTINE = void function();
alias NDR_RUNDOWN = void function(void* context);
alias NDR_NOTIFY_ROUTINE = void function();
alias NDR_NOTIFY2_ROUTINE = void function(ubyte flag);
alias EXPR_EVAL = void function(MIDL_STUB_MESSAGE* param0);
alias GENERIC_BINDING_ROUTINE = void* function(void* param0);
alias GENERIC_UNBIND_ROUTINE = void function(void* param0, ubyte* param1);
alias XMIT_HELPER_ROUTINE = void function(MIDL_STUB_MESSAGE* param0);
alias USER_MARSHAL_SIZING_ROUTINE = uint function(uint* param0, uint param1, void* param2);
alias USER_MARSHAL_MARSHALLING_ROUTINE = ubyte* function(uint* param0, ubyte* param1, void* param2);
alias USER_MARSHAL_UNMARSHALLING_ROUTINE = ubyte* function(uint* param0, ubyte* param1, void* param2);
alias USER_MARSHAL_FREEING_ROUTINE = void function(uint* param0, void* param1);
alias CS_TYPE_NET_SIZE_ROUTINE = void function(void* hBinding, uint ulNetworkCodeSet, uint ulLocalBufferSize, 
                                               IDL_CS_CONVERT* conversionType, uint* pulNetworkBufferSize, 
                                               uint* pStatus);
alias CS_TYPE_LOCAL_SIZE_ROUTINE = void function(void* hBinding, uint ulNetworkCodeSet, uint ulNetworkBufferSize, 
                                                 IDL_CS_CONVERT* conversionType, uint* pulLocalBufferSize, 
                                                 uint* pStatus);
alias CS_TYPE_TO_NETCS_ROUTINE = void function(void* hBinding, uint ulNetworkCodeSet, void* pLocalData, 
                                               uint ulLocalDataLength, ubyte* pNetworkData, 
                                               uint* pulNetworkDataLength, uint* pStatus);
alias CS_TYPE_FROM_NETCS_ROUTINE = void function(void* hBinding, uint ulNetworkCodeSet, ubyte* pNetworkData, 
                                                 uint ulNetworkDataLength, uint ulLocalBufferSize, void* pLocalData, 
                                                 uint* pulLocalDataLength, uint* pStatus);
alias CS_TAG_GETTING_ROUTINE = void function(void* hBinding, int fServerSide, uint* pulSendingTag, 
                                             uint* pulDesiredReceivingTag, uint* pulReceivingTag, uint* pStatus);
alias STUB_THUNK = void function(MIDL_STUB_MESSAGE* param0);
alias SERVER_ROUTINE = int function();
alias RPC_CLIENT_ALLOC = void* function(size_t Size);
alias RPC_CLIENT_FREE = void function(void* Ptr);
alias MIDL_ES_ALLOC = void function(void* state, byte** pbuffer, uint* psize);
alias MIDL_ES_WRITE = void function(void* state, byte* buffer, uint size);
alias MIDL_ES_READ = void function(void* state, byte** pbuffer, uint* psize);

// Structs


struct NDR_SCONTEXT_1
{
    void[2]* pad;
    void*    userContext;
}

///The <b>RPC_BINDING_VECTOR</b> structure contains a list of binding handles over which a server application can
///receive remote procedure calls.
struct RPC_BINDING_VECTOR
{
    ///Number of binding handles present in the binding-handle array <b>BindingH</b>.
    uint     Count;
    ///Array of binding handles that contains <b>Count</b> elements.
    void[1]* BindingH;
}

///The <b>UUID_VECTOR</b> structure contains a list of UUIDs.
struct UUID_VECTOR
{
    ///Number of UUIDs present in the array <b>Uuid</b>.
    uint     Count;
    ///Array of pointers to UUIDs that contains <b>Count</b> elements.
    GUID[1]* Uuid;
}

///The <b>RPC_IF_ID</b> structure contains the interface UUID and major and minor version numbers of an interface.
struct RPC_IF_ID
{
    ///Specifies the interface UUID.
    GUID   Uuid;
    ///Major version number, an integer from 0 to 65535, inclusive.
    ushort VersMajor;
    ///Minor version number, an integer from 0 to 65535, inclusive.
    ushort VersMinor;
}

struct RPC_PROTSEQ_VECTORA
{
    uint      Count;
    ubyte[1]* Protseq;
}

struct RPC_PROTSEQ_VECTORW
{
    uint       Count;
    ushort[1]* Protseq;
}

///The <b>RPC_POLICY</b> structure contains flags that determine binding on multihomed computers, and port allocations
///when using the ncacn_ip_tcp and ncadg_ip_udp protocols.
struct RPC_POLICY
{
    ///Size of the <b>RPC_POLICY</b> structure, in bytes. The <b>Length</b> member allows compatibility with future
    ///versions of this structure, which may contain additional fields. Always set the <b>Length</b> equal to
    ///<b>sizeof</b>(RPC_POLICY) when you initialize the <b>RPC_POLICY</b> structure in your code.
    uint Length;
    ///Set of flags that determine the attributes of the port or ports where the server receives remote procedure calls.
    ///You can specify more than one flag (by using the bitwise OR operator) from the set of values for a given protocol
    ///sequence. The following table lists the possible values for the <b>EndpointFlags</b> member. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td
    ///width="60%"> Specifies the system default. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_USE_INTERNET_PORT"></a><a id="rpc_c_use_internet_port"></a><dl> <dt><b>RPC_C_USE_INTERNET_PORT</b></dt>
    ///</dl> </td> <td width="60%"> Allocates the endpoint from one of the ports defined in the registry as "Internet
    ///Available." Valid only with ncacn_ip_tcp and ncadg_ip_udp protocol sequences. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_USE_INTRANET_PORT"></a><a id="rpc_c_use_intranet_port"></a><dl> <dt><b>RPC_C_USE_INTRANET_PORT</b></dt>
    ///</dl> </td> <td width="60%"> Allocates the endpoint from one of the ports defined in the registry as "Intranet
    ///Available." Valid only with ncacn_ip_tcp and ncadg_ip_udp protocol sequences. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_MQ_TEMPORARY"></a><a id="rpc_c_mq_temporary"></a><dl> <dt><b>RPC_C_MQ_TEMPORARY</b></dt> </dl> </td>
    ///<td width="60%"> The server process–receive queue will be deleted automatically when the RPC server exits. Any
    ///outstanding calls still in the queue will be lost. This is the default. Valid only with the ncadg_mq protocol
    ///sequence. </td> </tr> <tr> <td width="40%"><a id="RPC_C_MQ_PERMANENT"></a><a id="rpc_c_mq_permanent"></a><dl>
    ///<dt><b>RPC_C_MQ_PERMANENT</b></dt> </dl> </td> <td width="60%"> Specifies that the server process–receive queue
    ///persists after the server process exits. The default is that the queue is deleted when the server process
    ///terminates. Valid only with ncadg_mq protocol sequence. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_MQ_CLEAR_ON_OPEN"></a><a id="rpc_c_mq_clear_on_open"></a><dl> <dt><b>RPC_C_MQ_CLEAR_ON_OPEN</b></dt>
    ///</dl> </td> <td width="60%"> If the receive queue already exists because it was opened previously as a permanent
    ///queue, then clear any outstanding calls waiting in the queue. Valid only with the ncadg_mq protocol sequence
    ///only. </td> </tr> <tr> <td width="40%"><a id="RPC_C_MQ_USE_EXISTING_SECURITY"></a><a
    ///id="rpc_c_mq_use_existing_security"></a><dl> <dt><b>RPC_C_MQ_USE_EXISTING_SECURITY</b></dt> </dl> </td> <td
    ///width="60%"> If the receive queue already exists, then do not modify its existing settings for authentication or
    ///encryption. Valid only with the ncadg_mq protocol sequence. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_MQ_AUTHENTICATE"></a><a id="rpc_c_mq_authenticate"></a><dl> <dt><b>RPC_C_MQ_AUTHENTICATE</b></dt> </dl>
    ///</td> <td width="60%"> The server process–receive queue accepts only authenticated calls from clients. The
    ///default is that both authenticated and unauthenticated calls are accepted. Valid only with ncadg_mq protocol
    ///sequence. </td> </tr> <tr> <td width="40%"><a id="RPC_C_MQ_ENCRYPT"></a><a id="rpc_c_mq_encrypt"></a><dl>
    ///<dt><b>RPC_C_MQ_ENCRYPT</b></dt> </dl> </td> <td width="60%"> Calls to server are encrypted. The default is that
    ///both encrypted and unencrypted calls are accepted. Valid only with ncadg_mq protocol sequence. </td> </tr> <tr>
    ///<td width="40%"><a id="RPC_C_MQ_AUTHN_LEVEL_NONE"></a><a id="rpc_c_mq_authn_level_none"></a><dl>
    ///<dt><b>RPC_C_MQ_AUTHN_LEVEL_NONE</b></dt> </dl> </td> <td width="60%"> The server's receive queue accepts all
    ///calls from clients. This is the default authentication level. Valid only with the ncadg_mq protocol. </td> </tr>
    ///<tr> <td width="40%"><a id="RPC_C_MQ_AUTHN_LEVEL_PKT_INTEGRITY"></a><a
    ///id="rpc_c_mq_authn_level_pkt_integrity"></a><dl> <dt><b>RPC_C_MQ_AUTHN_LEVEL_PKT_INTEGRITY</b></dt> </dl> </td>
    ///<td width="60%"> Sets the server's receive queue to only accept client calls that have authentication level
    ///RPC_C_AUTHN_LEVEL_PKT_INTEGRITY or RPC_C_AUTHN_LEVEL_PKT_PRIVACY. Valid only with the ncadg_mq protocol sequence.
    ///</td> </tr> <tr> <td width="40%"><a id="RPC_C_MQ_AUTHN_LEVEL_PKT_PRIVACY"></a><a
    ///id="rpc_c_mq_authn_level_pkt_privacy"></a><dl> <dt><b>RPC_C_MQ_AUTHN_LEVEL_PKT_PRIVACY</b></dt> </dl> </td> <td
    ///width="60%"> Sets the server's receive queue to only accept client calls that have authentication level
    ///RPC_C_AUTHN_LEVEL_PKT_PRIVACY. Calls with a lower authentication level are ignored. Valid only with the ncadg_mq
    ///protocol sequence. </td> </tr> </table> <div> </div> <div class="alert"><b>Note</b> If the registry does not
    ///contain any of the keys that specify the default policies, then the <b>EndpointFlags</b> member will have no
    ///effect at run time. If a key is missing or contains an invalid value, then the entire configuration for that
    ///protocol ( ncacn_ip_tcp, ncadg_ip_udp or ncadg_mq) is marked as invalid and all calls to
    ///<b>RpcServerUseProtseq*</b> functions over that protocol will fail.</div> <div> </div>
    uint EndpointFlags;
    ///Policy for binding to Network Interface Cards (NICs). The following table lists the possible values for the
    ///<b>NICFlags</b> member. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%"> Binds to NICs on the basis of the registry
    ///settings. Always use this value when you are using the <b>RPC_POLICY</b> structure to define message-queue
    ///properties. </td> </tr> <tr> <td width="40%"><a id="RPC_C_BIND_TO_ALL_NICS"></a><a
    ///id="rpc_c_bind_to_all_nics"></a><dl> <dt><b>RPC_C_BIND_TO_ALL_NICS</b></dt> </dl> </td> <td width="60%">
    ///Overrides the registry settings and binds to all NICs. If the Bind key is missing from the registry, then the
    ///<b>NICFlags</b> member will have no effect at run time. If the key contains an invalid value, then the entire
    ///configuration is marked as invalid and all calls to RpcServerUseProtseq* will fail. </td> </tr> </table>
    uint NICFlags;
}

///The <b>RPC_STATS_VECTOR</b> structure contains statistics from the RPC run-time library on a per-server basis.
struct RPC_STATS_VECTOR
{
    ///Number of statistics values present in the array <b>Stats</b>.
    uint    Count;
    ///Array of unsigned long integers representing server statistics that contains <b>Count</b> elements. Each array
    ///element contains an unsigned long value from the following list. <table> <tr> <th>Constant</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_STATS_CALLS_IN"></a><a id="rpc_c_stats_calls_in"></a><dl>
    ///<dt><b>RPC_C_STATS_CALLS_IN</b></dt> </dl> </td> <td width="60%"> The number of remote procedure calls received
    ///by the server. </td> </tr> <tr> <td width="40%"><a id="RPC_C_STATS_CALLS_OUT"></a><a
    ///id="rpc_c_stats_calls_out"></a><dl> <dt><b>RPC_C_STATS_CALLS_OUT</b></dt> </dl> </td> <td width="60%"> The number
    ///of remote procedure calls initiated by the server. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_STATS_PKTS_IN"></a><a id="rpc_c_stats_pkts_in"></a><dl> <dt><b>RPC_C_STATS_PKTS_IN</b></dt> </dl> </td>
    ///<td width="60%"> The number of network packets received by the server. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_STATS_PKTS_OUT"></a><a id="rpc_c_stats_pkts_out"></a><dl> <dt><b>RPC_C_STATS_PKTS_OUT</b></dt> </dl>
    ///</td> <td width="60%"> The number of network packets sent by the server. </td> </tr> </table>
    uint[1] Stats;
}

///The <b>RPC_IF_ID_VECTOR</b> structure contains a list of interfaces offered by a server.
struct RPC_IF_ID_VECTOR
{
    ///Number of interface-identification structures present in the array <b>IfHandl</b>.
    uint          Count;
    RPC_IF_ID[1]* IfId;
}

///The <b>RPC_SECURITY_QOS</b> structure defines security quality-of-service settings on a binding handle. See Remarks
///for version availability on Windows editions.
struct RPC_SECURITY_QOS
{
    ///Version of the <b>RPC_SECURITY_QOS</b> structure being used. This topic documents version 1 of the
    ///<b>RPC_SECURITY_QOS</b> structure. See RPC_SECURITY_QOS_V2, RPC_SECURITY_QOS_V3, RPC_SECURITY_QOS_V4 and
    ///RPC_SECURITY_QOS_V5 for other versions.
    uint Version;
    ///Security services being provided to the application. Capabilities is a set of flags that can be combined using
    ///the bitwise OR operator. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_DEFAULT"></a><a id="rpc_c_qos_capabilities_default"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_DEFAULT</b></dt> </dl> </td> <td width="60%"> Used when no provider-specific
    ///capabilities are needed. </td> </tr> <tr> <td width="40%"><a id="RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH"></a><a
    ///id="rpc_c_qos_capabilities_mutual_auth"></a><dl> <dt><b>RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH</b></dt> </dl> </td>
    ///<td width="60%"> Specifying this flag causes the RPC run time to request mutual authentication from the security
    ///provider. Some security providers do not support mutual authentication. If the security provider does not support
    ///mutual authentication, or the identity of the server cannot be established, a remote procedure call to such
    ///server fails with error RPC_S_SEC_PKG_ERROR. <div class="alert"><b>Note</b> RPC relies on the SSP to indicate
    ///which security options were successfully negotiated; RPC in turn fails any call for which the Security Service
    ///Provider (SSP) reports it could not negotiate an option. However, some security providers are known to report the
    ///successful negotiation of an option even when the option was not successfully negotiated. For example, NTLM will
    ///report successful negotiation of mutual authentication for backward compatibility reasons, even though it does
    ///not support mutual authentication. Check with the particular SSP being used to determine its behavior with
    ///respect to security options.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC"></a><a id="rpc_c_qos_capabilities_make_fullsic"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC</b></dt> </dl> </td> <td width="60%"> Not currently implemented. </td>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY"></a><a
    ///id="rpc_c_qos_capabilities_any_authority"></a><dl> <dt><b>RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY</b></dt> </dl>
    ///</td> <td width="60%"> Accepts the client's credentials even if the certificate authority (CA) is not in the
    ///server's list of trusted CAs. This constant is used only by the SCHANNEL SSP. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE"></a><a
    ///id="rpc_c_qos_capabilities_ignore_delegate_failure"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE</b></dt> </dl> </td> <td width="60%"> When specified, this
    ///flag directs the RPC runtime on the client to ignore an error to establish a security context that supports
    ///delegation. Normally, if the client asks for delegation and the security system cannot establish a security
    ///context that supports delegation, error RPC_S_SEC_PKG_ERROR is returned; when this flag is specified, no error is
    ///returned. <div class="alert"><b>Note</b> Unsupported on Windows XP and earlier client editions, unsupported on
    ///Windows 2000 and earlier server editions.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT"></a><a id="rpc_c_qos_capabilities_local_ma_hint"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT</b></dt> </dl> </td> <td width="60%"> This flag specifies to RPC that
    ///the server is local to the machine making the RPC call. In this situation RPC instructs the endpoint mapper to
    ///pick up only endpoints registered by the principal specified in the <b>ServerPrincName</b> or <b>Sid</b> members
    ///(these members are available in RPC_SECURITY_QOS_V3, RPC_SECURITY_QOS_V4, and RPC_SECURITY_QOS_V5 only). See
    ///Remarks for more information. <div class="alert"><b>Note</b> Unsupported on Windows XP and earlier client
    ///editions, unsupported on Windows 2000 and earlier server editions.</div> <div> </div> </td> </tr> <tr> <td
    ///width="40%"><a id="RPC_C_QOS_CAPABILITIES_SCHANNEL_FULL_AUTH_IDENTITY_"></a><a
    ///id="rpc_c_qos_capabilities_schannel_full_auth_identity_"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_SCHANNEL_FULL_AUTH_IDENTITY </b></dt> </dl> </td> <td width="60%"> If set, the RPC
    ///runtime uses the SChannel SSP to perform smartcard-based authentication without displaying a PIN prompt dialog
    ///box by the cryptographic services provider (CSP). In the call to RpcBindingSetAuthInfoEx, the <i>AuthIdentity</i>
    ///parameter must be a SEC_WINNT_AUTH_IDENTITY structure whose members contain the following: <ul> <li><b>User</b>
    ///must be a pointer to an SCHANNEL_CRED structure</li> <li><b>UserLength</b> must be 0</li> <li><b>Domain</b> must
    ///be NULL</li> <li><b>DomainLength</b> must be 0</li> <li><b>Password</b> may be the certificate PIN or NULL. If
    ///<b>Password</b> is the PIN, <b>PasswordLength</b> must be the correct length for the PIN, and if <b>Password</b>
    ///is NULL, <b>PasswordLength</b> must be 0</li> </ul> If the
    ///<b>RPC_C_QOS_CAPABILITIES_SCHANNEL_FULL_AUTH_IDENTITY</b> flag is used for any SSP other than SChannel, or if the
    ///members of SEC_WINNT_AUTH_IDENTITY do not conform to the above, <b>RPC_S_INVALID_ARG</b> will be returned by
    ///RpcBindingSetAuthInfoEx. </td> </tr> </table>
    uint Capabilities;
    ///Sets the context tracking mode. Should be set to one of the values shown in the following table. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RPC_C_QOS_IDENTITY_STATIC"></a><a
    ///id="rpc_c_qos_identity_static"></a><dl> <dt><b>RPC_C_QOS_IDENTITY_STATIC</b></dt> </dl> </td> <td width="60%">
    ///Security context is created only once and is never revised during the entire communication, even if the client
    ///side changes it. This is the default behavior if <b>RPC_SECURITY_QOS</b> is not specified. </td> </tr> <tr> <td
    ///width="40%"><a id="RPC_C_QOS_IDENTITY_DYNAMIC"></a><a id="rpc_c_qos_identity_dynamic"></a><dl>
    ///<dt><b>RPC_C_QOS_IDENTITY_DYNAMIC</b></dt> </dl> </td> <td width="60%"> Context is revised whenever the
    ///ModifiedId in the client's token is changed. All protocols use the ModifiedId (see note). <b>Windows 2000:
    ///</b>All remote protocols (all protocols other than ncalrpc) use the AuthenticationID, also known as the LogonId,
    ///to track changes in the client's identity. The <b>ncalrpc</b> protocol uses ModifiedId. </td> </tr> </table>
    uint IdentityTracking;
    ///Level at which the server process can impersonate the client. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_DEFAULT"></a><a id="rpc_c_imp_level_default"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_DEFAULT</b></dt> </dl> </td> <td width="60%"> Uses the default impersonation level. </td>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_ANONYMOUS"></a><a id="rpc_c_imp_level_anonymous"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_ANONYMOUS</b></dt> </dl> </td> <td width="60%"> Client does not provide identification
    ///information to the server. The server cannot impersonate the client or identify the client. Many servers reject
    ///calls with this impersonation type. <div class="alert"><b>Note</b> Some security providers may treat this
    ///impersonation type as equivalent to RPC_C_IMP_LEVEL_IMPERSONATE. From the Windows security providers, this is
    ///done by RPC_C_AUTHN_WINNT only when used with protocol sequences other than ncalrpc. It is also done by
    ///RPC_C_AUTHN_GSS_NEGOTIATE, RPC_C_AUTHN_GSS_SCHANNEL and RPC_C_AUTHN_GSS_KERBEROS.</div> <div> </div> </td> </tr>
    ///<tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_IDENTIFY"></a><a id="rpc_c_imp_level_identify"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_IDENTIFY</b></dt> </dl> </td> <td width="60%"> Server can obtain the client's identity,
    ///and impersonate the client to perform Access Control List (ACL) checks, but cannot impersonate the client. See
    ///Impersonation Levels for more information. <div class="alert"><b>Note</b> Some security providers may treat this
    ///impersonation type as equivalent to RPC_C_IMP_LEVEL_IMPERSONATE. From the Windows security providers, this is
    ///done by RPC_C_AUTHN_WINNT only when used with protocol sequences other than ncalrpc. It is also done by
    ///RPC_C_AUTHN_GSS_NEGOTIATE, RPC_C_AUTHN_GSS_SCHANNEL and RPC_C_AUTHN_GSS_KERBEROS.</div> <div> </div> </td> </tr>
    ///<tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_IMPERSONATE"></a><a id="rpc_c_imp_level_impersonate"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_IMPERSONATE</b></dt> </dl> </td> <td width="60%"> Server can impersonate the client's
    ///security context on its local system, but not on remote systems. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_IMP_LEVEL_DELEGATE"></a><a id="rpc_c_imp_level_delegate"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_DELEGATE</b></dt> </dl> </td> <td width="60%"> The server can impersonate the client's
    ///security context while acting on behalf of the client. The server can also make outgoing calls to other servers
    ///while acting on behalf of the client. The server may use the client's security context on other machines to
    ///access local and remote resources as the client. </td> </tr> </table>
    uint ImpersonationType;
}

///The <b>RPC_HTTP_TRANSPORT_CREDENTIALS</b> structure defines additional credentials to authenticate to an RPC proxy
///server when using RPC/HTTP.
struct RPC_HTTP_TRANSPORT_CREDENTIALS_W
{
    ///A pointer to a SEC_WINNT_AUTH_IDENTITY structure that contains the user name, domain, and password for the user.
    SEC_WINNT_AUTH_IDENTITY_W* TransportCredentials;
    ///A set of flags that can be combined with the bitwise OR operator. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_HTTP_FLAG_USE_SSL"></a><a id="rpc_c_http_flag_use_ssl"></a><dl>
    ///<dt><b>RPC_C_HTTP_FLAG_USE_SSL</b></dt> </dl> </td> <td width="60%"> Instructs RPC to use SSL to communicate with
    ///the RPC Proxy. </td> </tr> <tr> <td width="40%"><a id="RPC_C_HTTP_FLAG_USE_FIRST_AUTH_SCHEME"></a><a
    ///id="rpc_c_http_flag_use_first_auth_scheme"></a><dl> <dt><b>RPC_C_HTTP_FLAG_USE_FIRST_AUTH_SCHEME</b></dt> </dl>
    ///</td> <td width="60%"> When set, RPC chooses the first scheme in the <b>AuthnSchemes</b> array and attempts to
    ///authenticate to the RPC Proxy. If the RPC Proxy does not support the selected authentication scheme, the call
    ///fails. When not set, the RPC client queries the RPC Proxy for supported authentication schemes, and chooses one.
    ///</td> </tr> </table>
    uint    Flags;
    ///Specifies the authentication target. Should be set to one or both of the following values: <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RPC_C_HTTP_AUTHN_TARGET_SERVER"></a><a
    ///id="rpc_c_http_authn_target_server"></a><dl> <dt><b>RPC_C_HTTP_AUTHN_TARGET_SERVER</b></dt> </dl> </td> <td
    ///width="60%"> Authenticate against the RPC Proxy, which is the HTTP Server from an HTTP perspective. This is the
    ///most common value. </td> </tr> <tr> <td width="40%"><a id="RPC_C_HTTP_AUTHN_TARGET_PROXY"></a><a
    ///id="rpc_c_http_authn_target_proxy"></a><dl> <dt><b>RPC_C_HTTP_AUTHN_TARGET_PROXY</b></dt> </dl> </td> <td
    ///width="60%"> Authenticate against the HTTP Proxy. This value is uncommon. </td> </tr> </table>
    uint    AuthenticationTarget;
    ///The number of elements in the <b>AuthnScheme</b> array.
    uint    NumberOfAuthnSchemes;
    uint*   AuthnSchemes;
    ///Contains an optional string with the expected server principal name. The principal name is in the same format as
    ///that generated for RpcCertGeneratePrincipalName (see Principal Names for more information). This member is used
    ///only when SSL is used. In such cases, the server certificate is checked against the generated principal name. If
    ///they do not match, an error is returned. This member enables clients to authenticate the RPC Proxy.
    ushort* ServerCertificateSubject;
}

///The <b>RPC_HTTP_TRANSPORT_CREDENTIALS</b> structure defines additional credentials to authenticate to an RPC proxy
///server when using RPC/HTTP.
struct RPC_HTTP_TRANSPORT_CREDENTIALS_A
{
    ///A pointer to a SEC_WINNT_AUTH_IDENTITY structure that contains the user name, domain, and password for the user.
    SEC_WINNT_AUTH_IDENTITY_A* TransportCredentials;
    ///A set of flags that can be combined with the bitwise OR operator. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_HTTP_FLAG_USE_SSL"></a><a id="rpc_c_http_flag_use_ssl"></a><dl>
    ///<dt><b>RPC_C_HTTP_FLAG_USE_SSL</b></dt> </dl> </td> <td width="60%"> Instructs RPC to use SSL to communicate with
    ///the RPC Proxy. </td> </tr> <tr> <td width="40%"><a id="RPC_C_HTTP_FLAG_USE_FIRST_AUTH_SCHEME"></a><a
    ///id="rpc_c_http_flag_use_first_auth_scheme"></a><dl> <dt><b>RPC_C_HTTP_FLAG_USE_FIRST_AUTH_SCHEME</b></dt> </dl>
    ///</td> <td width="60%"> When set, RPC chooses the first scheme in the <b>AuthnSchemes</b> array and attempts to
    ///authenticate to the RPC Proxy. If the RPC Proxy does not support the selected authentication scheme, the call
    ///fails. When not set, the RPC client queries the RPC Proxy for supported authentication schemes, and chooses one.
    ///</td> </tr> </table>
    uint   Flags;
    ///Specifies the authentication target. Should be set to one or both of the following values: <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RPC_C_HTTP_AUTHN_TARGET_SERVER"></a><a
    ///id="rpc_c_http_authn_target_server"></a><dl> <dt><b>RPC_C_HTTP_AUTHN_TARGET_SERVER</b></dt> </dl> </td> <td
    ///width="60%"> Authenticate against the RPC Proxy, which is the HTTP Server from an HTTP perspective. This is the
    ///most common value. </td> </tr> <tr> <td width="40%"><a id="RPC_C_HTTP_AUTHN_TARGET_PROXY"></a><a
    ///id="rpc_c_http_authn_target_proxy"></a><dl> <dt><b>RPC_C_HTTP_AUTHN_TARGET_PROXY</b></dt> </dl> </td> <td
    ///width="60%"> Authenticate against the HTTP Proxy. This value is uncommon. </td> </tr> </table>
    uint   AuthenticationTarget;
    ///The number of elements in the <b>AuthnScheme</b> array.
    uint   NumberOfAuthnSchemes;
    uint*  AuthnSchemes;
    ///Contains an optional string with the expected server principal name. The principal name is in the same format as
    ///that generated for RpcCertGeneratePrincipalName (see Principal Names for more information). This member is used
    ///only when SSL is used. In such cases, the server certificate is checked against the generated principal name. If
    ///they do not match, an error is returned. This member enables clients to authenticate the RPC Proxy.
    ubyte* ServerCertificateSubject;
}

///The <b>RPC_HTTP_TRANSPORT_CREDENTIALS_V2</b> structure defines additional credentials to authenticate to an RPC proxy
///server or HTTP proxy server when using RPC/HTTP. <b>RPC_HTTP_TRANSPORT_CREDENTIALS_V2</b> extends
///RPC_HTTP_TRANSPORT_CREDENTIALS by allowing authentication against an HTTP proxy server.
struct RPC_HTTP_TRANSPORT_CREDENTIALS_V2_W
{
    ///A pointer to a SEC_WINNT_AUTH_IDENTITY structure that contains the user name, domain, and password for the user.
    SEC_WINNT_AUTH_IDENTITY_W* TransportCredentials;
    ///A set of flags that can be combined with the bitwise OR operator. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_HTTP_FLAG_USE_SSL"></a><a id="rpc_c_http_flag_use_ssl"></a><dl>
    ///<dt><b>RPC_C_HTTP_FLAG_USE_SSL</b></dt> </dl> </td> <td width="60%"> Instructs RPC to use SSL to communicate with
    ///the RPC Proxy. </td> </tr> <tr> <td width="40%"><a id="RPC_C_HTTP_FLAG_USE_FIRST_AUTH_SCHEME"></a><a
    ///id="rpc_c_http_flag_use_first_auth_scheme"></a><dl> <dt><b>RPC_C_HTTP_FLAG_USE_FIRST_AUTH_SCHEME</b></dt> </dl>
    ///</td> <td width="60%"> When set, RPC chooses the first scheme in the <b>AuthnSchemes</b> array and attempts to
    ///authenticate to the RPC Proxy. If the RPC Proxy does not support the selected authentication scheme, the call
    ///fails. When not set, the RPC client queries the RPC Proxy for supported authentication schemes, and chooses one.
    ///</td> </tr> </table>
    uint    Flags;
    ///Specifies the authentication target. Should be set to one or both of the following values: <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RPC_C_HTTP_AUTHN_TARGET_SERVER"></a><a
    ///id="rpc_c_http_authn_target_server"></a><dl> <dt><b>RPC_C_HTTP_AUTHN_TARGET_SERVER</b></dt> </dl> </td> <td
    ///width="60%"> Authenticate against the RPC Proxy, which is the HTTP Server from an HTTP perspective. This is the
    ///most common value. </td> </tr> <tr> <td width="40%"><a id="RPC_C_HTTP_AUTHN_TARGET_PROXY"></a><a
    ///id="rpc_c_http_authn_target_proxy"></a><dl> <dt><b>RPC_C_HTTP_AUTHN_TARGET_PROXY</b></dt> </dl> </td> <td
    ///width="60%"> Authenticate against the HTTP Proxy. This value is uncommon. </td> </tr> </table>
    uint    AuthenticationTarget;
    ///The number of elements in the <b>AuthnScheme</b> array.
    uint    NumberOfAuthnSchemes;
    ///A pointer to an array of authentication schemes the client is willing to use. Each element of the array can
    ///contain one of the following constants: <a id="RPC_C_HTTP_AUTHN_SCHEME_BASIC"></a> <a
    ///id="rpc_c_http_authn_scheme_basic"></a>
    uint*   AuthnSchemes;
    ///Contains an optional string with the expected server principal name. The principal name is in the same format as
    ///that generated for RpcCertGeneratePrincipalName (see Principal Names for more information). This member is used
    ///only when SSL is used. In such cases, the server certificate is checked against the generated principal name. If
    ///they do not match, an error is returned. This member enables clients to authenticate the RPC Proxy.
    ushort* ServerCertificateSubject;
    ///A pointer to a SEC_WINNT_AUTH_IDENTITY structure that contains the user name, domain, and password for the user
    ///when authenticating against an HTTP proxy server. <b>ProxyCredentials</b> is only valid when
    ///<b>AuthenticationTarget</b> contains <b>RPC_C_HTTP_AUTHN_TARGET_PROXY</b>.
    SEC_WINNT_AUTH_IDENTITY_W* ProxyCredentials;
    ///The number of elements in the <b>ProxyAuthnSchemes</b> array when authenticating against an HTTP proxy server.
    ///<b>NumberOfProxyAuthnSchemes</b> is only valid when <b>AuthenticationTarget</b> contains
    ///<b>RPC_C_HTTP_AUTHN_TARGET_PROXY</b>.
    uint    NumberOfProxyAuthnSchemes;
    ///A pointer to an array of authentication schemes the client is willing to use when authenticating against an HTTP
    ///proxy server. Each element of the array can contain one of the following constants. <b>ProxyAuthnSchemes</b> is
    ///only valid when <b>AuthenticationTarget</b> contains <b>RPC_C_HTTP_AUTHN_TARGET_PROXY</b>. <a
    ///id="RPC_C_HTTP_AUTHN_SCHEME_BASIC"></a> <a id="rpc_c_http_authn_scheme_basic"></a>
    uint*   ProxyAuthnSchemes;
}

///The <b>RPC_HTTP_TRANSPORT_CREDENTIALS_V2</b> structure defines additional credentials to authenticate to an RPC proxy
///server or HTTP proxy server when using RPC/HTTP. <b>RPC_HTTP_TRANSPORT_CREDENTIALS_V2</b> extends
///RPC_HTTP_TRANSPORT_CREDENTIALS by allowing authentication against an HTTP proxy server.
struct RPC_HTTP_TRANSPORT_CREDENTIALS_V2_A
{
    ///A pointer to a SEC_WINNT_AUTH_IDENTITY structure that contains the user name, domain, and password for the user.
    SEC_WINNT_AUTH_IDENTITY_A* TransportCredentials;
    ///A set of flags that can be combined with the bitwise OR operator. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_HTTP_FLAG_USE_SSL"></a><a id="rpc_c_http_flag_use_ssl"></a><dl>
    ///<dt><b>RPC_C_HTTP_FLAG_USE_SSL</b></dt> </dl> </td> <td width="60%"> Instructs RPC to use SSL to communicate with
    ///the RPC Proxy. </td> </tr> <tr> <td width="40%"><a id="RPC_C_HTTP_FLAG_USE_FIRST_AUTH_SCHEME"></a><a
    ///id="rpc_c_http_flag_use_first_auth_scheme"></a><dl> <dt><b>RPC_C_HTTP_FLAG_USE_FIRST_AUTH_SCHEME</b></dt> </dl>
    ///</td> <td width="60%"> When set, RPC chooses the first scheme in the <b>AuthnSchemes</b> array and attempts to
    ///authenticate to the RPC Proxy. If the RPC Proxy does not support the selected authentication scheme, the call
    ///fails. When not set, the RPC client queries the RPC Proxy for supported authentication schemes, and chooses one.
    ///</td> </tr> </table>
    uint   Flags;
    ///Specifies the authentication target. Should be set to one or both of the following values: <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RPC_C_HTTP_AUTHN_TARGET_SERVER"></a><a
    ///id="rpc_c_http_authn_target_server"></a><dl> <dt><b>RPC_C_HTTP_AUTHN_TARGET_SERVER</b></dt> </dl> </td> <td
    ///width="60%"> Authenticate against the RPC Proxy, which is the HTTP Server from an HTTP perspective. This is the
    ///most common value. </td> </tr> <tr> <td width="40%"><a id="RPC_C_HTTP_AUTHN_TARGET_PROXY"></a><a
    ///id="rpc_c_http_authn_target_proxy"></a><dl> <dt><b>RPC_C_HTTP_AUTHN_TARGET_PROXY</b></dt> </dl> </td> <td
    ///width="60%"> Authenticate against the HTTP Proxy. This value is uncommon. </td> </tr> </table>
    uint   AuthenticationTarget;
    ///The number of elements in the <b>AuthnScheme</b> array.
    uint   NumberOfAuthnSchemes;
    ///A pointer to an array of authentication schemes the client is willing to use. Each element of the array can
    ///contain one of the following constants: <a id="RPC_C_HTTP_AUTHN_SCHEME_BASIC"></a> <a
    ///id="rpc_c_http_authn_scheme_basic"></a>
    uint*  AuthnSchemes;
    ///Contains an optional string with the expected server principal name. The principal name is in the same format as
    ///that generated for RpcCertGeneratePrincipalName (see Principal Names for more information). This member is used
    ///only when SSL is used. In such cases, the server certificate is checked against the generated principal name. If
    ///they do not match, an error is returned. This member enables clients to authenticate the RPC Proxy.
    ubyte* ServerCertificateSubject;
    ///A pointer to a SEC_WINNT_AUTH_IDENTITY structure that contains the user name, domain, and password for the user
    ///when authenticating against an HTTP proxy server. <b>ProxyCredentials</b> is only valid when
    ///<b>AuthenticationTarget</b> contains <b>RPC_C_HTTP_AUTHN_TARGET_PROXY</b>.
    SEC_WINNT_AUTH_IDENTITY_A* ProxyCredentials;
    ///The number of elements in the <b>ProxyAuthnSchemes</b> array when authenticating against an HTTP proxy server.
    ///<b>NumberOfProxyAuthnSchemes</b> is only valid when <b>AuthenticationTarget</b> contains
    ///<b>RPC_C_HTTP_AUTHN_TARGET_PROXY</b>.
    uint   NumberOfProxyAuthnSchemes;
    ///A pointer to an array of authentication schemes the client is willing to use when authenticating against an HTTP
    ///proxy server. Each element of the array can contain one of the following constants. <b>ProxyAuthnSchemes</b> is
    ///only valid when <b>AuthenticationTarget</b> contains <b>RPC_C_HTTP_AUTHN_TARGET_PROXY</b>. <a
    ///id="RPC_C_HTTP_AUTHN_SCHEME_BASIC"></a> <a id="rpc_c_http_authn_scheme_basic"></a>
    uint*  ProxyAuthnSchemes;
}

///The <b>RPC_HTTP_TRANSPORT_CREDENTIALS_V3</b> structure defines additional credentials to authenticate to an RPC proxy
///server or HTTP proxy server when using RPC/HTTP. <b>RPC_HTTP_TRANSPORT_CREDENTIALS_V3</b> extends
///RPC_HTTP_TRANSPORT_CREDENTIALS_V2 by allowing arbitrary credential forms to be used.
struct RPC_HTTP_TRANSPORT_CREDENTIALS_V3_W
{
    ///A pointer to an opaque authentication handle in the form of an RPC_AUTH_IDENTITY_HANDLE structure.
    void*   TransportCredentials;
    ///A set of flags that can be combined with the bitwise OR operator. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_HTTP_FLAG_USE_SSL"></a><a id="rpc_c_http_flag_use_ssl"></a><dl>
    ///<dt><b>RPC_C_HTTP_FLAG_USE_SSL</b></dt> </dl> </td> <td width="60%"> Instructs RPC to use SSL to communicate with
    ///the RPC Proxy. </td> </tr> <tr> <td width="40%"><a id="RPC_C_HTTP_FLAG_USE_FIRST_AUTH_SCHEME"></a><a
    ///id="rpc_c_http_flag_use_first_auth_scheme"></a><dl> <dt><b>RPC_C_HTTP_FLAG_USE_FIRST_AUTH_SCHEME</b></dt> </dl>
    ///</td> <td width="60%"> When set, RPC chooses the first scheme in the <b>AuthnSchemes</b> array and attempts to
    ///authenticate to the RPC Proxy. If the RPC Proxy does not support the selected authentication scheme, the call
    ///fails. When not set, the RPC client queries the RPC Proxy for supported authentication schemes, and chooses one.
    ///</td> </tr> </table>
    uint    Flags;
    ///Specifies the authentication target. Should be set to one or both of the following values: <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RPC_C_HTTP_AUTHN_TARGET_SERVER"></a><a
    ///id="rpc_c_http_authn_target_server"></a><dl> <dt><b>RPC_C_HTTP_AUTHN_TARGET_SERVER</b></dt> </dl> </td> <td
    ///width="60%"> Authenticate against the RPC Proxy, which is the HTTP Server from an HTTP perspective. This is the
    ///most common value. </td> </tr> <tr> <td width="40%"><a id="RPC_C_HTTP_AUTHN_TARGET_PROXY"></a><a
    ///id="rpc_c_http_authn_target_proxy"></a><dl> <dt><b>RPC_C_HTTP_AUTHN_TARGET_PROXY</b></dt> </dl> </td> <td
    ///width="60%"> Authenticate against the HTTP Proxy. This value is uncommon. </td> </tr> </table>
    uint    AuthenticationTarget;
    ///The number of elements in the <b>AuthnScheme</b> array.
    uint    NumberOfAuthnSchemes;
    ///A pointer to an array of authentication schemes the client is willing to use. Each element of the array can
    ///contain one of the following constants: <a id="RPC_C_HTTP_AUTHN_SCHEME_BASIC"></a> <a
    ///id="rpc_c_http_authn_scheme_basic"></a>
    uint*   AuthnSchemes;
    ///Contains an optional string with the expected server principal name. The principal name is in the same format as
    ///that generated for RpcCertGeneratePrincipalName (see Principal Names for more information). This member is used
    ///only when SSL is used. In such cases, the server certificate is checked against the generated principal name. If
    ///they do not match, an error is returned. This member enables clients to authenticate the RPC Proxy.
    ushort* ServerCertificateSubject;
    ///A pointer to an opaque authentication handle in the form of an RPC_AUTH_IDENTITY_HANDLE structure when
    ///authenticating against an HTTP proxy server. <b>ProxyCredentials</b> is only valid when
    ///<b>AuthenticationTarget</b> contains <b>RPC_C_HTTP_AUTHN_TARGET_PROXY</b>.
    void*   ProxyCredentials;
    ///The number of elements in the <b>ProxyAuthnSchemes</b> array when authenticating against an HTTP proxy server.
    ///<b>NumberOfProxyAuthnSchemes</b> is only valid when <b>AuthenticationTarget</b> contains
    ///<b>RPC_C_HTTP_AUTHN_TARGET_PROXY</b>.
    uint    NumberOfProxyAuthnSchemes;
    ///A pointer to an array of authentication schemes the client is willing to use when authenticating against an HTTP
    ///proxy server. Each element of the array can contain one of the following constants. <b>ProxyAuthnSchemes</b> is
    ///only valid when <b>AuthenticationTarget</b> contains <b>RPC_C_HTTP_AUTHN_TARGET_PROXY</b>. <a
    ///id="RPC_C_HTTP_AUTHN_SCHEME_BASIC"></a> <a id="rpc_c_http_authn_scheme_basic"></a>
    uint*   ProxyAuthnSchemes;
}

///The <b>RPC_HTTP_TRANSPORT_CREDENTIALS_V3</b> structure defines additional credentials to authenticate to an RPC proxy
///server or HTTP proxy server when using RPC/HTTP. <b>RPC_HTTP_TRANSPORT_CREDENTIALS_V3</b> extends
///RPC_HTTP_TRANSPORT_CREDENTIALS_V2 by allowing arbitrary credential forms to be used.
struct RPC_HTTP_TRANSPORT_CREDENTIALS_V3_A
{
    ///A pointer to an opaque authentication handle in the form of an RPC_AUTH_IDENTITY_HANDLE structure.
    void*  TransportCredentials;
    ///A set of flags that can be combined with the bitwise OR operator. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_HTTP_FLAG_USE_SSL"></a><a id="rpc_c_http_flag_use_ssl"></a><dl>
    ///<dt><b>RPC_C_HTTP_FLAG_USE_SSL</b></dt> </dl> </td> <td width="60%"> Instructs RPC to use SSL to communicate with
    ///the RPC Proxy. </td> </tr> <tr> <td width="40%"><a id="RPC_C_HTTP_FLAG_USE_FIRST_AUTH_SCHEME"></a><a
    ///id="rpc_c_http_flag_use_first_auth_scheme"></a><dl> <dt><b>RPC_C_HTTP_FLAG_USE_FIRST_AUTH_SCHEME</b></dt> </dl>
    ///</td> <td width="60%"> When set, RPC chooses the first scheme in the <b>AuthnSchemes</b> array and attempts to
    ///authenticate to the RPC Proxy. If the RPC Proxy does not support the selected authentication scheme, the call
    ///fails. When not set, the RPC client queries the RPC Proxy for supported authentication schemes, and chooses one.
    ///</td> </tr> </table>
    uint   Flags;
    ///Specifies the authentication target. Should be set to one or both of the following values: <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RPC_C_HTTP_AUTHN_TARGET_SERVER"></a><a
    ///id="rpc_c_http_authn_target_server"></a><dl> <dt><b>RPC_C_HTTP_AUTHN_TARGET_SERVER</b></dt> </dl> </td> <td
    ///width="60%"> Authenticate against the RPC Proxy, which is the HTTP Server from an HTTP perspective. This is the
    ///most common value. </td> </tr> <tr> <td width="40%"><a id="RPC_C_HTTP_AUTHN_TARGET_PROXY"></a><a
    ///id="rpc_c_http_authn_target_proxy"></a><dl> <dt><b>RPC_C_HTTP_AUTHN_TARGET_PROXY</b></dt> </dl> </td> <td
    ///width="60%"> Authenticate against the HTTP Proxy. This value is uncommon. </td> </tr> </table>
    uint   AuthenticationTarget;
    ///The number of elements in the <b>AuthnScheme</b> array.
    uint   NumberOfAuthnSchemes;
    ///A pointer to an array of authentication schemes the client is willing to use. Each element of the array can
    ///contain one of the following constants: <a id="RPC_C_HTTP_AUTHN_SCHEME_BASIC"></a> <a
    ///id="rpc_c_http_authn_scheme_basic"></a>
    uint*  AuthnSchemes;
    ///Contains an optional string with the expected server principal name. The principal name is in the same format as
    ///that generated for RpcCertGeneratePrincipalName (see Principal Names for more information). This member is used
    ///only when SSL is used. In such cases, the server certificate is checked against the generated principal name. If
    ///they do not match, an error is returned. This member enables clients to authenticate the RPC Proxy.
    ubyte* ServerCertificateSubject;
    ///A pointer to an opaque authentication handle in the form of an RPC_AUTH_IDENTITY_HANDLE structure when
    ///authenticating against an HTTP proxy server. <b>ProxyCredentials</b> is only valid when
    ///<b>AuthenticationTarget</b> contains <b>RPC_C_HTTP_AUTHN_TARGET_PROXY</b>.
    void*  ProxyCredentials;
    ///The number of elements in the <b>ProxyAuthnSchemes</b> array when authenticating against an HTTP proxy server.
    ///<b>NumberOfProxyAuthnSchemes</b> is only valid when <b>AuthenticationTarget</b> contains
    ///<b>RPC_C_HTTP_AUTHN_TARGET_PROXY</b>.
    uint   NumberOfProxyAuthnSchemes;
    ///A pointer to an array of authentication schemes the client is willing to use when authenticating against an HTTP
    ///proxy server. Each element of the array can contain one of the following constants. <b>ProxyAuthnSchemes</b> is
    ///only valid when <b>AuthenticationTarget</b> contains <b>RPC_C_HTTP_AUTHN_TARGET_PROXY</b>. <a
    ///id="RPC_C_HTTP_AUTHN_SCHEME_BASIC"></a> <a id="rpc_c_http_authn_scheme_basic"></a>
    uint*  ProxyAuthnSchemes;
}

///The <b>RPC_SECURITY_QOS_V2</b> structure defines version 2 security quality-of-service settings on a binding handle.
///See Remarks for version availability on Windows editions.
struct RPC_SECURITY_QOS_V2_W
{
    ///Version of the RPC_SECURITY_QOS structure being used. This topic documents version 2 of the
    ///<b>RPC_SECURITY_QOS</b> structure. See <b>RPC_SECURITY_QOS</b>, RPC_SECURITY_QOS_V3, RPC_SECURITY_QOS_V4, and
    ///RPC_SECURITY_QOS_V5 for other versions.
    uint Version;
    ///Security services being provided to the application. Capabilities is a set of flags that can be combined using
    ///the bitwise <b>OR</b> operator. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_DEFAULT"></a><a id="rpc_c_qos_capabilities_default"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_DEFAULT</b></dt> </dl> </td> <td width="60%"> Used when no provider-specific
    ///capabilities are needed. </td> </tr> <tr> <td width="40%"><a id="RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH"></a><a
    ///id="rpc_c_qos_capabilities_mutual_auth"></a><dl> <dt><b>RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH</b></dt> </dl> </td>
    ///<td width="60%"> Specifying this flag causes the RPC run time to request mutual authentication from the security
    ///provider. Some security providers do not support mutual authentication. If the security provider does not support
    ///mutual authentication, or the identity of the server cannot be established, a remote procedure call to such
    ///server fails with error RPC_S_SEC_PKG_ERROR. <div class="alert"><b>Note</b> RPC relies on the SSP to indicate
    ///which security options were successfully negotiated; RPC in turn fails any call for which the SSP reports it
    ///could not negotiate an option. However, some security providers are known to report the successful negotiation of
    ///an option even when the option was not successfully negotiated. For example, NTLM will report successful
    ///negotiation of mutual authentication for backward compatibility reasons, even though it does not support mutual
    ///authentication. Check with the particular SSP being used to determine its behavior with respect to security
    ///options.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC"></a><a
    ///id="rpc_c_qos_capabilities_make_fullsic"></a><dl> <dt><b>RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC</b></dt> </dl> </td>
    ///<td width="60%"> Not currently implemented. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY"></a><a id="rpc_c_qos_capabilities_any_authority"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY</b></dt> </dl> </td> <td width="60%"> Accepts the client's
    ///credentials even if the certificate authority (CA) is not in the server's list of trusted CAs. This constant is
    ///used only by the SCHANNEL SSP. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE"></a><a
    ///id="rpc_c_qos_capabilities_ignore_delegate_failure"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE</b></dt> </dl> </td> <td width="60%"> When specified, this
    ///flag directs the RPC runtime on the client to ignore an error to establish a security context that supports
    ///delegation. Normally, if the client asks for delegation and the security system cannot establish a security
    ///context that supports delegation, error RPC_S_SEC_PKG_ERROR is returned; when this flag is specified, no error is
    ///returned. <div class="alert"><b>Note</b> Unsupported on Windows XP and earlier client editions, unsupported on
    ///Windows 2000 and earlier server editions.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT"></a><a id="rpc_c_qos_capabilities_local_ma_hint"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT</b></dt> </dl> </td> <td width="60%"> When specified, this flag
    ///specifies to RPC that the server is local to the machine making the RPC call. In this situation RPC instructs the
    ///endpoint mapper to pick up only endpoints registered by the principal specified in the <b>ServerPrincName</b> or
    ///<b>Sid</b> members (these members are available in RPC_SECURITY_QOS_V3, RPC_SECURITY_QOS_V4, and
    ///RPC_SECURITY_QOS_V5 only). See Remarks for more information. <div class="alert"><b>Note</b> Unsupported on
    ///Windows XP and earlier client editions, unsupported on Windows 2000 and earlier server editions.</div> <div>
    ///</div> </td> </tr> </table>
    uint Capabilities;
    ///Sets the context tracking mode. Should be set to one of the values shown in the following table. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RPC_C_QOS_IDENTITY_STATIC"></a><a
    ///id="rpc_c_qos_identity_static"></a><dl> <dt><b>RPC_C_QOS_IDENTITY_STATIC</b></dt> </dl> </td> <td width="60%">
    ///Security context is created only once and is never revised during the entire communication, even if the client
    ///side changes it. This is the default behavior if <b>RPC_SECURITY_QOS_V2</b> is not specified. </td> </tr> <tr>
    ///<td width="40%"><a id="RPC_C_QOS_IDENTITY_DYNAMIC"></a><a id="rpc_c_qos_identity_dynamic"></a><dl>
    ///<dt><b>RPC_C_QOS_IDENTITY_DYNAMIC</b></dt> </dl> </td> <td width="60%"> Context is revised whenever the
    ///ModifiedId in the client's token is changed. All protocols use the ModifiedId (see note). <b>Windows 2000:
    ///</b>All remote protocols (all protocols other than ncalrpc) use the AuthenticationID, also known as the LogonId,
    ///to track changes in the client's identity. The <b>ncalrpc</b> protocol uses ModifiedId. </td> </tr> </table>
    uint IdentityTracking;
    ///Level at which the server process can impersonate the client. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_DEFAULT"></a><a id="rpc_c_imp_level_default"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_DEFAULT</b></dt> </dl> </td> <td width="60%"> Uses the default impersonation level. </td>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_ANONYMOUS"></a><a id="rpc_c_imp_level_anonymous"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_ANONYMOUS</b></dt> </dl> </td> <td width="60%"> Client does not provide identification
    ///information to the server. The server cannot impersonate the client or identify the client. Many servers reject
    ///calls with this impersonation type. </td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_IDENTIFY"></a><a
    ///id="rpc_c_imp_level_identify"></a><dl> <dt><b>RPC_C_IMP_LEVEL_IDENTIFY</b></dt> </dl> </td> <td width="60%">
    ///Server can obtain the client's identity, and impersonate the client to perform Access Control List (ACL) checks,
    ///but cannot impersonate the client. See Impersonation Levels for more information. <div class="alert"><b>Note</b>
    ///Some security providers may treat this impersonation type as equivalent to RPC_C_IMP_LEVEL_IMPERSONATE. </div>
    ///<div> </div> </td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_IMPERSONATE"></a><a
    ///id="rpc_c_imp_level_impersonate"></a><dl> <dt><b>RPC_C_IMP_LEVEL_IMPERSONATE</b></dt> </dl> </td> <td
    ///width="60%"> Server can impersonate the client's security context on its local system, but not on remote systems.
    ///</td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_DELEGATE"></a><a id="rpc_c_imp_level_delegate"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_DELEGATE</b></dt> </dl> </td> <td width="60%"> The server can impersonate the client's
    ///security context while acting on behalf of the client. The server can also make outgoing calls to other servers
    ///while acting on behalf of the client. The server may use the client's security context on other machines to
    ///access local and remote resources as the client. </td> </tr> </table>
    uint ImpersonationType;
    ///Specifies the type of additional credentials present in the <b>u</b> union. The following constants are
    ///supported: <table> <tr> <th>Supported Constants</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%"> No additional credentials are passed in the
    ///<b>u</b> union. </td> </tr> <tr> <td width="40%"><a id="RPC_C_AUTHN_INFO_TYPE_HTTP"></a><a
    ///id="rpc_c_authn_info_type_http"></a><dl> <dt><b>RPC_C_AUTHN_INFO_TYPE_HTTP</b></dt> </dl> </td> <td width="60%">
    ///The <b>HttpCredentials</b> member of the <b>u</b> union points to a RPC_HTTP_TRANSPORT_CREDENTIALS structure.
    ///This value can be used only when the protocol sequence is ncacn_http. Any other protocol sequence returns
    ///RPC_S_INVALID_ARG. </td> </tr> </table>
    uint AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_W* HttpCredentials;
    }
}

///The <b>RPC_SECURITY_QOS_V2</b> structure defines version 2 security quality-of-service settings on a binding handle.
///See Remarks for version availability on Windows editions.
struct RPC_SECURITY_QOS_V2_A
{
    ///Version of the RPC_SECURITY_QOS structure being used. This topic documents version 2 of the
    ///<b>RPC_SECURITY_QOS</b> structure. See <b>RPC_SECURITY_QOS</b>, RPC_SECURITY_QOS_V3, RPC_SECURITY_QOS_V4, and
    ///RPC_SECURITY_QOS_V5 for other versions.
    uint Version;
    ///Security services being provided to the application. Capabilities is a set of flags that can be combined using
    ///the bitwise <b>OR</b> operator. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_DEFAULT"></a><a id="rpc_c_qos_capabilities_default"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_DEFAULT</b></dt> </dl> </td> <td width="60%"> Used when no provider-specific
    ///capabilities are needed. </td> </tr> <tr> <td width="40%"><a id="RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH"></a><a
    ///id="rpc_c_qos_capabilities_mutual_auth"></a><dl> <dt><b>RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH</b></dt> </dl> </td>
    ///<td width="60%"> Specifying this flag causes the RPC run time to request mutual authentication from the security
    ///provider. Some security providers do not support mutual authentication. If the security provider does not support
    ///mutual authentication, or the identity of the server cannot be established, a remote procedure call to such
    ///server fails with error RPC_S_SEC_PKG_ERROR. <div class="alert"><b>Note</b> RPC relies on the SSP to indicate
    ///which security options were successfully negotiated; RPC in turn fails any call for which the SSP reports it
    ///could not negotiate an option. However, some security providers are known to report the successful negotiation of
    ///an option even when the option was not successfully negotiated. For example, NTLM will report successful
    ///negotiation of mutual authentication for backward compatibility reasons, even though it does not support mutual
    ///authentication. Check with the particular SSP being used to determine its behavior with respect to security
    ///options.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC"></a><a
    ///id="rpc_c_qos_capabilities_make_fullsic"></a><dl> <dt><b>RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC</b></dt> </dl> </td>
    ///<td width="60%"> Not currently implemented. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY"></a><a id="rpc_c_qos_capabilities_any_authority"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY</b></dt> </dl> </td> <td width="60%"> Accepts the client's
    ///credentials even if the certificate authority (CA) is not in the server's list of trusted CAs. This constant is
    ///used only by the SCHANNEL SSP. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE"></a><a
    ///id="rpc_c_qos_capabilities_ignore_delegate_failure"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE</b></dt> </dl> </td> <td width="60%"> When specified, this
    ///flag directs the RPC runtime on the client to ignore an error to establish a security context that supports
    ///delegation. Normally, if the client asks for delegation and the security system cannot establish a security
    ///context that supports delegation, error RPC_S_SEC_PKG_ERROR is returned; when this flag is specified, no error is
    ///returned. <div class="alert"><b>Note</b> Unsupported on Windows XP and earlier client editions, unsupported on
    ///Windows 2000 and earlier server editions.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT"></a><a id="rpc_c_qos_capabilities_local_ma_hint"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT</b></dt> </dl> </td> <td width="60%"> When specified, this flag
    ///specifies to RPC that the server is local to the machine making the RPC call. In this situation RPC instructs the
    ///endpoint mapper to pick up only endpoints registered by the principal specified in the <b>ServerPrincName</b> or
    ///<b>Sid</b> members (these members are available in RPC_SECURITY_QOS_V3, RPC_SECURITY_QOS_V4, and
    ///RPC_SECURITY_QOS_V5 only). See Remarks for more information. <div class="alert"><b>Note</b> Unsupported on
    ///Windows XP and earlier client editions, unsupported on Windows 2000 and earlier server editions.</div> <div>
    ///</div> </td> </tr> </table>
    uint Capabilities;
    ///Sets the context tracking mode. Should be set to one of the values shown in the following table. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RPC_C_QOS_IDENTITY_STATIC"></a><a
    ///id="rpc_c_qos_identity_static"></a><dl> <dt><b>RPC_C_QOS_IDENTITY_STATIC</b></dt> </dl> </td> <td width="60%">
    ///Security context is created only once and is never revised during the entire communication, even if the client
    ///side changes it. This is the default behavior if <b>RPC_SECURITY_QOS_V2</b> is not specified. </td> </tr> <tr>
    ///<td width="40%"><a id="RPC_C_QOS_IDENTITY_DYNAMIC"></a><a id="rpc_c_qos_identity_dynamic"></a><dl>
    ///<dt><b>RPC_C_QOS_IDENTITY_DYNAMIC</b></dt> </dl> </td> <td width="60%"> Context is revised whenever the
    ///ModifiedId in the client's token is changed. All protocols use the ModifiedId (see note). <b>Windows 2000:
    ///</b>All remote protocols (all protocols other than ncalrpc) use the AuthenticationID, also known as the LogonId,
    ///to track changes in the client's identity. The <b>ncalrpc</b> protocol uses ModifiedId. </td> </tr> </table>
    uint IdentityTracking;
    ///Level at which the server process can impersonate the client. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_DEFAULT"></a><a id="rpc_c_imp_level_default"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_DEFAULT</b></dt> </dl> </td> <td width="60%"> Uses the default impersonation level. </td>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_ANONYMOUS"></a><a id="rpc_c_imp_level_anonymous"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_ANONYMOUS</b></dt> </dl> </td> <td width="60%"> Client does not provide identification
    ///information to the server. The server cannot impersonate the client or identify the client. Many servers reject
    ///calls with this impersonation type. </td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_IDENTIFY"></a><a
    ///id="rpc_c_imp_level_identify"></a><dl> <dt><b>RPC_C_IMP_LEVEL_IDENTIFY</b></dt> </dl> </td> <td width="60%">
    ///Server can obtain the client's identity, and impersonate the client to perform Access Control List (ACL) checks,
    ///but cannot impersonate the client. See Impersonation Levels for more information. <div class="alert"><b>Note</b>
    ///Some security providers may treat this impersonation type as equivalent to RPC_C_IMP_LEVEL_IMPERSONATE. </div>
    ///<div> </div> </td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_IMPERSONATE"></a><a
    ///id="rpc_c_imp_level_impersonate"></a><dl> <dt><b>RPC_C_IMP_LEVEL_IMPERSONATE</b></dt> </dl> </td> <td
    ///width="60%"> Server can impersonate the client's security context on its local system, but not on remote systems.
    ///</td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_DELEGATE"></a><a id="rpc_c_imp_level_delegate"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_DELEGATE</b></dt> </dl> </td> <td width="60%"> The server can impersonate the client's
    ///security context while acting on behalf of the client. The server can also make outgoing calls to other servers
    ///while acting on behalf of the client. The server may use the client's security context on other machines to
    ///access local and remote resources as the client. </td> </tr> </table>
    uint ImpersonationType;
    ///Specifies the type of additional credentials present in the <b>u</b> union. The following constants are
    ///supported: <table> <tr> <th>Supported Constants</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%"> No additional credentials are passed in the
    ///<b>u</b> union. </td> </tr> <tr> <td width="40%"><a id="RPC_C_AUTHN_INFO_TYPE_HTTP"></a><a
    ///id="rpc_c_authn_info_type_http"></a><dl> <dt><b>RPC_C_AUTHN_INFO_TYPE_HTTP</b></dt> </dl> </td> <td width="60%">
    ///The <b>HttpCredentials</b> member of the <b>u</b> union points to a RPC_HTTP_TRANSPORT_CREDENTIALS structure.
    ///This value can be used only when the protocol sequence is ncacn_http. Any other protocol sequence returns
    ///RPC_S_INVALID_ARG. </td> </tr> </table>
    uint AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_A* HttpCredentials;
    }
}

///The <b>RPC_SECURITY_QOS_V3</b> structure defines version 3 security quality-of-service settings on a binding handle.
///See Remarks for version availability on Windows editions.
struct RPC_SECURITY_QOS_V3_W
{
    ///Version of the RPC_SECURITY_QOS structure being used. This topic documents version 3 of the
    ///<b>RPC_SECURITY_QOS</b> structure. See <b>RPC_SECURITY_QOS</b>, RPC_SECURITY_QOS_V2 and RPC_SECURITY_QOS_V4, and
    ///RPC_SECURITY_QOS_V5 for other versions.
    uint  Version;
    ///Security services being provided to the application. Capabilities is a set of flags that can be combined using
    ///the bitwise OR operator. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_DEFAULT"></a><a id="rpc_c_qos_capabilities_default"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_DEFAULT</b></dt> </dl> </td> <td width="60%"> Used when no provider-specific
    ///capabilities are needed. </td> </tr> <tr> <td width="40%"><a id="RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH"></a><a
    ///id="rpc_c_qos_capabilities_mutual_auth"></a><dl> <dt><b>RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH</b></dt> </dl> </td>
    ///<td width="60%"> Specifying this flag causes the RPC run time to request mutual authentication from the security
    ///provider. Some security providers do not support mutual authentication. If the security provider does not support
    ///mutual authentication, or the identity of the server cannot be established, a remote procedure call to such
    ///server fails with error RPC_S_SEC_PKG_ERROR. <div class="alert"><b>Note</b> RPC relies on the SSP to indicate
    ///which security options were successfully negotiated; RPC in turn fails any call for which the SSP reports it
    ///could not negotiate an option. However, some security providers are known to report the successful negotiation of
    ///an option even when the option was not successfully negotiated. For example, NTLM will report successful
    ///negotiation of mutual authentication for backward compatibility reasons, even though it does not support mutual
    ///authentication. Check with the particular SSP being used to determine its behavior with respect to security
    ///options.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC"></a><a
    ///id="rpc_c_qos_capabilities_make_fullsic"></a><dl> <dt><b>RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC</b></dt> </dl> </td>
    ///<td width="60%"> Not currently implemented. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY"></a><a id="rpc_c_qos_capabilities_any_authority"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY</b></dt> </dl> </td> <td width="60%"> Accepts the client's
    ///credentials even if the certificate authority (CA) is not in the server's list of trusted CAs. This constant is
    ///used only by the SCHANNEL SSP. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE"></a><a
    ///id="rpc_c_qos_capabilities_ignore_delegate_failure"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE</b></dt> </dl> </td> <td width="60%"> When specified, this
    ///flag directs the RPC runtime on the client to ignore an error to establish a security context that supports
    ///delegation. Normally, if the client asks for delegation and the security system cannot establish a security
    ///context that supports delegation, error RPC_S_SEC_PKG_ERROR is returned; when this flag is specified, no error is
    ///returned. <div class="alert"><b>Note</b> Unsupported on Windows XP and earlier client editions, unsupported on
    ///Windows 2000 and earlier server editions.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT"></a><a id="rpc_c_qos_capabilities_local_ma_hint"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT</b></dt> </dl> </td> <td width="60%"> When specified, this flag
    ///specifies to RPC that the server is local to the machine making the RPC call. In this situation RPC instructs the
    ///endpoint mapper to pick up only endpoints registered by the principal specified in the <b>ServerPrincName</b> or
    ///<b>Sid</b> members (these members are available in <b>RPC_SECURITY_QOS_V3</b>, RPC_SECURITY_QOS_V4, and
    ///RPC_SECURITY_QOS_V5 only). See Remarks for more information. <div class="alert"><b>Note</b> Unsupported on
    ///Windows XP and earlier client editions, unsupported on Windows 2000 and earlier server editions.</div> <div>
    ///</div> </td> </tr> </table>
    uint  Capabilities;
    ///Sets the context tracking mode. Should be set to one of the values shown in the following table. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RPC_C_QOS_IDENTITY_STATIC"></a><a
    ///id="rpc_c_qos_identity_static"></a><dl> <dt><b>RPC_C_QOS_IDENTITY_STATIC</b></dt> </dl> </td> <td width="60%">
    ///Security context is created only once and is never revised during the entire communication, even if the client
    ///side changes it. This is the default behavior if <b>RPC_SECURITY_QOS_V3</b> is not specified. </td> </tr> <tr>
    ///<td width="40%"><a id="RPC_C_QOS_IDENTITY_DYNAMIC"></a><a id="rpc_c_qos_identity_dynamic"></a><dl>
    ///<dt><b>RPC_C_QOS_IDENTITY_DYNAMIC</b></dt> </dl> </td> <td width="60%"> Context is revised whenever the
    ///ModifiedId in the client's token is changed. All protocols use the ModifiedId (see note). <b>Windows 2000:
    ///</b>All remote protocols (all protocols other than ncalrpc) use the AuthenticationID, also known as the LogonId,
    ///to track changes in the client's identity. The <b>ncalrpc</b> protocol uses ModifiedId. </td> </tr> </table>
    uint  IdentityTracking;
    ///Level at which the server process can impersonate the client. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_DEFAULT"></a><a id="rpc_c_imp_level_default"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_DEFAULT</b></dt> </dl> </td> <td width="60%"> Uses the default impersonation level. </td>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_ANONYMOUS"></a><a id="rpc_c_imp_level_anonymous"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_ANONYMOUS</b></dt> </dl> </td> <td width="60%"> Client does not provide identification
    ///information to the server. The server cannot impersonate the client or identify the client. Many servers reject
    ///calls with this impersonation type. </td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_IDENTIFY"></a><a
    ///id="rpc_c_imp_level_identify"></a><dl> <dt><b>RPC_C_IMP_LEVEL_IDENTIFY</b></dt> </dl> </td> <td width="60%">
    ///Server can obtain the client's identity, and impersonate the client to perform Access Control List (ACL) checks,
    ///but cannot impersonate the client. See Impersonation Levels for more information. <div class="alert"><b>Note</b>
    ///Some security providers may treat this impersonation type as equivalent to RPC_C_IMP_LEVEL_IMPERSONATE. </div>
    ///<div> </div> </td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_IMPERSONATE"></a><a
    ///id="rpc_c_imp_level_impersonate"></a><dl> <dt><b>RPC_C_IMP_LEVEL_IMPERSONATE</b></dt> </dl> </td> <td
    ///width="60%"> Server can impersonate the client's security context on its local system, but not on remote systems.
    ///</td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_DELEGATE"></a><a id="rpc_c_imp_level_delegate"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_DELEGATE</b></dt> </dl> </td> <td width="60%"> The server can impersonate the client's
    ///security context while acting on behalf of the client. The server can also make outgoing calls to other servers
    ///while acting on behalf of the client. The server may use the client's security context on other machines to
    ///access local and remote resources as the client. </td> </tr> </table>
    uint  ImpersonationType;
    ///Specifies the type of additional credentials present in the <b>u</b> union. The following constants are
    ///supported: <table> <tr> <th>Supported Constants</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%"> No additional credentials are passed in the
    ///<b>u</b> union. </td> </tr> <tr> <td width="40%"><a id="RPC_C_AUTHN_INFO_TYPE_HTTP"></a><a
    ///id="rpc_c_authn_info_type_http"></a><dl> <dt><b>RPC_C_AUTHN_INFO_TYPE_HTTP</b></dt> </dl> </td> <td width="60%">
    ///The <b>HttpCredentials</b> member of the <b>u</b> union points to a RPC_HTTP_TRANSPORT_CREDENTIALS structure.
    ///This value can be used only when the protocol sequence is ncacn_http. Any other protocol sequence returns
    ///RPC_S_INVALID_ARG. </td> </tr> </table>
    uint  AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_W* HttpCredentials;
    }
    ///Points to a security identifier (SID). The SID is an alternative to the <b>ServerPrincName</b> member, and only
    ///one can be specified. The <b>Sid</b> member cannot be set to non-<b>NULL</b> if the security provider is the
    ///SCHANNEL SSP. Some protocol sequences use <b>Sid</b> internally for security, and some use a
    ///<b>ServerPrincName</b>. For example, ncalrpc uses a <b>Sid</b> internally, and if the caller knows both the SID
    ///and the <b>ServerPrincName</b>, a call using <b>ncalrpc</b> can complete much faster in some cases if the SID is
    ///passed. In contrast, the <b>ncacn_*</b> and <b>ncadg_*</b> protocol sequences use a <b>ServerPrincName</b>
    ///internally, and therefore can execute calls faster when provided the <b>ServerPrincName</b>.
    void* Sid;
}

///The <b>RPC_SECURITY_QOS_V3</b> structure defines version 3 security quality-of-service settings on a binding handle.
///See Remarks for version availability on Windows editions.
struct RPC_SECURITY_QOS_V3_A
{
    ///Version of the RPC_SECURITY_QOS structure being used. This topic documents version 3 of the
    ///<b>RPC_SECURITY_QOS</b> structure. See <b>RPC_SECURITY_QOS</b>, RPC_SECURITY_QOS_V2 and RPC_SECURITY_QOS_V4, and
    ///RPC_SECURITY_QOS_V5 for other versions.
    uint  Version;
    ///Security services being provided to the application. Capabilities is a set of flags that can be combined using
    ///the bitwise OR operator. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_DEFAULT"></a><a id="rpc_c_qos_capabilities_default"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_DEFAULT</b></dt> </dl> </td> <td width="60%"> Used when no provider-specific
    ///capabilities are needed. </td> </tr> <tr> <td width="40%"><a id="RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH"></a><a
    ///id="rpc_c_qos_capabilities_mutual_auth"></a><dl> <dt><b>RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH</b></dt> </dl> </td>
    ///<td width="60%"> Specifying this flag causes the RPC run time to request mutual authentication from the security
    ///provider. Some security providers do not support mutual authentication. If the security provider does not support
    ///mutual authentication, or the identity of the server cannot be established, a remote procedure call to such
    ///server fails with error RPC_S_SEC_PKG_ERROR. <div class="alert"><b>Note</b> RPC relies on the SSP to indicate
    ///which security options were successfully negotiated; RPC in turn fails any call for which the SSP reports it
    ///could not negotiate an option. However, some security providers are known to report the successful negotiation of
    ///an option even when the option was not successfully negotiated. For example, NTLM will report successful
    ///negotiation of mutual authentication for backward compatibility reasons, even though it does not support mutual
    ///authentication. Check with the particular SSP being used to determine its behavior with respect to security
    ///options.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a id="RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC"></a><a
    ///id="rpc_c_qos_capabilities_make_fullsic"></a><dl> <dt><b>RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC</b></dt> </dl> </td>
    ///<td width="60%"> Not currently implemented. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY"></a><a id="rpc_c_qos_capabilities_any_authority"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY</b></dt> </dl> </td> <td width="60%"> Accepts the client's
    ///credentials even if the certificate authority (CA) is not in the server's list of trusted CAs. This constant is
    ///used only by the SCHANNEL SSP. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE"></a><a
    ///id="rpc_c_qos_capabilities_ignore_delegate_failure"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE</b></dt> </dl> </td> <td width="60%"> When specified, this
    ///flag directs the RPC runtime on the client to ignore an error to establish a security context that supports
    ///delegation. Normally, if the client asks for delegation and the security system cannot establish a security
    ///context that supports delegation, error RPC_S_SEC_PKG_ERROR is returned; when this flag is specified, no error is
    ///returned. <div class="alert"><b>Note</b> Unsupported on Windows XP and earlier client editions, unsupported on
    ///Windows 2000 and earlier server editions.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT"></a><a id="rpc_c_qos_capabilities_local_ma_hint"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT</b></dt> </dl> </td> <td width="60%"> When specified, this flag
    ///specifies to RPC that the server is local to the machine making the RPC call. In this situation RPC instructs the
    ///endpoint mapper to pick up only endpoints registered by the principal specified in the <b>ServerPrincName</b> or
    ///<b>Sid</b> members (these members are available in <b>RPC_SECURITY_QOS_V3</b>, RPC_SECURITY_QOS_V4, and
    ///RPC_SECURITY_QOS_V5 only). See Remarks for more information. <div class="alert"><b>Note</b> Unsupported on
    ///Windows XP and earlier client editions, unsupported on Windows 2000 and earlier server editions.</div> <div>
    ///</div> </td> </tr> </table>
    uint  Capabilities;
    ///Sets the context tracking mode. Should be set to one of the values shown in the following table. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RPC_C_QOS_IDENTITY_STATIC"></a><a
    ///id="rpc_c_qos_identity_static"></a><dl> <dt><b>RPC_C_QOS_IDENTITY_STATIC</b></dt> </dl> </td> <td width="60%">
    ///Security context is created only once and is never revised during the entire communication, even if the client
    ///side changes it. This is the default behavior if <b>RPC_SECURITY_QOS_V3</b> is not specified. </td> </tr> <tr>
    ///<td width="40%"><a id="RPC_C_QOS_IDENTITY_DYNAMIC"></a><a id="rpc_c_qos_identity_dynamic"></a><dl>
    ///<dt><b>RPC_C_QOS_IDENTITY_DYNAMIC</b></dt> </dl> </td> <td width="60%"> Context is revised whenever the
    ///ModifiedId in the client's token is changed. All protocols use the ModifiedId (see note). <b>Windows 2000:
    ///</b>All remote protocols (all protocols other than ncalrpc) use the AuthenticationID, also known as the LogonId,
    ///to track changes in the client's identity. The <b>ncalrpc</b> protocol uses ModifiedId. </td> </tr> </table>
    uint  IdentityTracking;
    ///Level at which the server process can impersonate the client. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_DEFAULT"></a><a id="rpc_c_imp_level_default"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_DEFAULT</b></dt> </dl> </td> <td width="60%"> Uses the default impersonation level. </td>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_ANONYMOUS"></a><a id="rpc_c_imp_level_anonymous"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_ANONYMOUS</b></dt> </dl> </td> <td width="60%"> Client does not provide identification
    ///information to the server. The server cannot impersonate the client or identify the client. Many servers reject
    ///calls with this impersonation type. </td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_IDENTIFY"></a><a
    ///id="rpc_c_imp_level_identify"></a><dl> <dt><b>RPC_C_IMP_LEVEL_IDENTIFY</b></dt> </dl> </td> <td width="60%">
    ///Server can obtain the client's identity, and impersonate the client to perform Access Control List (ACL) checks,
    ///but cannot impersonate the client. See Impersonation Levels for more information. <div class="alert"><b>Note</b>
    ///Some security providers may treat this impersonation type as equivalent to RPC_C_IMP_LEVEL_IMPERSONATE. </div>
    ///<div> </div> </td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_IMPERSONATE"></a><a
    ///id="rpc_c_imp_level_impersonate"></a><dl> <dt><b>RPC_C_IMP_LEVEL_IMPERSONATE</b></dt> </dl> </td> <td
    ///width="60%"> Server can impersonate the client's security context on its local system, but not on remote systems.
    ///</td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_DELEGATE"></a><a id="rpc_c_imp_level_delegate"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_DELEGATE</b></dt> </dl> </td> <td width="60%"> The server can impersonate the client's
    ///security context while acting on behalf of the client. The server can also make outgoing calls to other servers
    ///while acting on behalf of the client. The server may use the client's security context on other machines to
    ///access local and remote resources as the client. </td> </tr> </table>
    uint  ImpersonationType;
    ///Specifies the type of additional credentials present in the <b>u</b> union. The following constants are
    ///supported: <table> <tr> <th>Supported Constants</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="0"></a><dl> <dt><b>0</b></dt> </dl> </td> <td width="60%"> No additional credentials are passed in the
    ///<b>u</b> union. </td> </tr> <tr> <td width="40%"><a id="RPC_C_AUTHN_INFO_TYPE_HTTP"></a><a
    ///id="rpc_c_authn_info_type_http"></a><dl> <dt><b>RPC_C_AUTHN_INFO_TYPE_HTTP</b></dt> </dl> </td> <td width="60%">
    ///The <b>HttpCredentials</b> member of the <b>u</b> union points to a RPC_HTTP_TRANSPORT_CREDENTIALS structure.
    ///This value can be used only when the protocol sequence is ncacn_http. Any other protocol sequence returns
    ///RPC_S_INVALID_ARG. </td> </tr> </table>
    uint  AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_A* HttpCredentials;
    }
    ///Points to a security identifier (SID). The SID is an alternative to the <b>ServerPrincName</b> member, and only
    ///one can be specified. The <b>Sid</b> member cannot be set to non-<b>NULL</b> if the security provider is the
    ///SCHANNEL SSP. Some protocol sequences use <b>Sid</b> internally for security, and some use a
    ///<b>ServerPrincName</b>. For example, ncalrpc uses a <b>Sid</b> internally, and if the caller knows both the SID
    ///and the <b>ServerPrincName</b>, a call using <b>ncalrpc</b> can complete much faster in some cases if the SID is
    ///passed. In contrast, the <b>ncacn_*</b> and <b>ncadg_*</b> protocol sequences use a <b>ServerPrincName</b>
    ///internally, and therefore can execute calls faster when provided the <b>ServerPrincName</b>.
    void* Sid;
}

///The <b>RPC_SECURITY_QOS_V4</b> structure defines version 4 security quality-of-service settings on a binding handle.
///See Remarks for version availability on Windows editions.
struct RPC_SECURITY_QOS_V4_W
{
    ///Version of the RPC_SECURITY_QOS structure being used. This topic documents version 4 of the
    ///<b>RPC_SECURITY_QOS</b> structure. See <b>RPC_SECURITY_QOS</b>, RPC_SECURITY_QOS_V2, RPC_SECURITY_QOS_V3, and
    ///RPC_SECURITY_QOS_V5 for other versions.
    uint  Version;
    ///Security services being provided to the application. <i>Capabilities</i> is a set of flags that can be combined
    ///using the bitwise OR operator. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_DEFAULT"></a><a id="rpc_c_qos_capabilities_default"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_DEFAULT</b></dt> </dl> </td> <td width="60%"> No provider-specific capabilities are
    ///needed. </td> </tr> <tr> <td width="40%"><a id="RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH"></a><a
    ///id="rpc_c_qos_capabilities_mutual_auth"></a><dl> <dt><b>RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH</b></dt> </dl> </td>
    ///<td width="60%"> The RPC run time requests mutual authentication from the security provider. Some security
    ///providers do not support mutual authentication. If the security provider does not support mutual authentication,
    ///or the identity of the server cannot be established, a remote procedure call to such server fails with error
    ///RPC_S_SEC_PKG_ERROR. <div class="alert"><b>Note</b> RPC relies on the SSP to indicate which security options were
    ///successfully negotiated; in turn an RPC call fails if the SSP reports it could not negotiate an option. However,
    ///some security providers are known to report the successful negotiation of an option even when the option was not
    ///successfully negotiated. For example, NTLM will report successful negotiation of mutual authentication for
    ///backward compatibility reasons, even though it does not support mutual authentication. Check with the particular
    ///SSP being used to determine its behavior with respect to security options.</div> <div> </div> </td> </tr> <tr>
    ///<td width="40%"><a id="RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC"></a><a
    ///id="rpc_c_qos_capabilities_make_fullsic"></a><dl> <dt><b>RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC</b></dt> </dl> </td>
    ///<td width="60%"> Not currently implemented. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY"></a><a id="rpc_c_qos_capabilities_any_authority"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY</b></dt> </dl> </td> <td width="60%"> Accepts the client's
    ///credentials even if the certificate authority (CA) is not in the server's list of trusted CAs. This constant is
    ///used only by the SCHANNEL SSP. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE"></a><a
    ///id="rpc_c_qos_capabilities_ignore_delegate_failure"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE</b></dt> </dl> </td> <td width="60%"> The RPC runtime on
    ///the client ignores an error to establish a security context that supports delegation. Normally, if the client
    ///asks for delegation and the security system cannot establish a security context that supports delegation, error
    ///RPC_S_SEC_PKG_ERROR is returned; when this flag is specified, no error is returned. <div
    ///class="alert"><b>Note</b> Unsupported on Windows XP and earlier client editions, unsupported on Windows 2000 and
    ///earlier server editions.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT"></a><a id="rpc_c_qos_capabilities_local_ma_hint"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT</b></dt> </dl> </td> <td width="60%"> The server is local to the
    ///machine making the RPC call. In this situation RPC instructs the endpoint mapper to pick up only endpoints
    ///registered by the principal specified in the <b>ServerPrincName</b> or <b>Sid</b> members (these members are
    ///available in RPC_SECURITY_QOS_V3, <b>RPC_SECURITY_QOS_V4</b>, and RPC_SECURITY_QOS_V5 only). See Remarks for more
    ///information. <div class="alert"><b>Note</b> Unsupported on Windows XP and earlier client editions, unsupported on
    ///Windows 2000 and earlier server editions.</div> <div> </div> </td> </tr> </table>
    uint  Capabilities;
    ///The context tracking mode as one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="RPC_C_QOS_IDENTITY_STATIC"></a><a id="rpc_c_qos_identity_static"></a><dl>
    ///<dt><b>RPC_C_QOS_IDENTITY_STATIC</b></dt> </dl> </td> <td width="60%"> The security context is created only once
    ///and is never revised during the entire communication, even if the client side changes it. This is the default
    ///behavior if <b>RPC_SECURITY_QOS_V4</b> is not specified. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_IDENTITY_DYNAMIC"></a><a id="rpc_c_qos_identity_dynamic"></a><dl>
    ///<dt><b>RPC_C_QOS_IDENTITY_DYNAMIC</b></dt> </dl> </td> <td width="60%"> The Security context is revised whenever
    ///the ModifiedId in the client's token is changed. All protocols use the ModifiedId (see note). <b>Windows 2000:
    ///</b>All remote protocols (all protocols other than ncalrpc) use the AuthenticationID, also known as the LogonId,
    ///to track changes in the client's identity. The <b>ncalrpc</b> protocol uses ModifiedId. </td> </tr> </table>
    uint  IdentityTracking;
    ///The level at which the server process can impersonate the client. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_DEFAULT"></a><a id="rpc_c_imp_level_default"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_DEFAULT</b></dt> </dl> </td> <td width="60%"> Uses the default impersonation level. </td>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_ANONYMOUS"></a><a id="rpc_c_imp_level_anonymous"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_ANONYMOUS</b></dt> </dl> </td> <td width="60%"> The client does not provide identification
    ///information to the server. The server cannot impersonate the client or identify the client. Many servers reject
    ///calls with this impersonation type. </td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_IDENTIFY"></a><a
    ///id="rpc_c_imp_level_identify"></a><dl> <dt><b>RPC_C_IMP_LEVEL_IDENTIFY</b></dt> </dl> </td> <td width="60%"> The
    ///server can obtain the client's identity, and impersonate the client to perform Access Control List (ACL) checks,
    ///but cannot impersonate the client. See Impersonation Levels for more information. <div class="alert"><b>Note</b>
    ///Some security providers may treat this impersonation type as equivalent to RPC_C_IMP_LEVEL_IMPERSONATE. </div>
    ///<div> </div> </td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_IMPERSONATE"></a><a
    ///id="rpc_c_imp_level_impersonate"></a><dl> <dt><b>RPC_C_IMP_LEVEL_IMPERSONATE</b></dt> </dl> </td> <td
    ///width="60%"> The server can impersonate the client's security context on its local system, but not on remote
    ///systems. </td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_DELEGATE"></a><a
    ///id="rpc_c_imp_level_delegate"></a><dl> <dt><b>RPC_C_IMP_LEVEL_DELEGATE</b></dt> </dl> </td> <td width="60%"> The
    ///server can impersonate the client's security context while acting on behalf of the client. The server can also
    ///make outgoing calls to other servers while acting on behalf of the client. The server may use the client's
    ///security context on other machines to access local and remote resources as the client. </td> </tr> </table>
    uint  ImpersonationType;
    ///The type of additional credentials present in the <b>u</b> union. The following constants are supported: <table>
    ///<tr> <th>Supported Constants</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl>
    ///<dt><b>0</b></dt> </dl> </td> <td width="60%"> No additional credentials are passed in the <b>u</b> union. </td>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_AUTHN_INFO_TYPE_HTTP"></a><a id="rpc_c_authn_info_type_http"></a><dl>
    ///<dt><b>RPC_C_AUTHN_INFO_TYPE_HTTP</b></dt> </dl> </td> <td width="60%"> The <b>HttpCredentials</b> member of the
    ///<b>u</b> union points to a RPC_HTTP_TRANSPORT_CREDENTIALS structure. This value can be used only when the
    ///protocol sequence is ncacn_http. Any other protocol sequence returns RPC_S_INVALID_ARG. </td> </tr> </table>
    uint  AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_W* HttpCredentials;
    }
    ///Pointer to a security identifier (SID). The SID is an alternative to the <b>ServerPrincName</b> member, and only
    ///one can be specified. The <b>Sid</b> member cannot be set to non-<b>NULL</b> if the security provider is the
    ///SCHANNEL SSP. Some protocol sequences use <b>Sid</b> internally for security, and some use a
    ///<b>ServerPrincName</b>. For example, ncalrpc uses a <b>Sid</b> internally, and if the caller knows both the SID
    ///and the <b>ServerPrincName</b>, a call using <b>ncalrpc</b> can complete much faster in some cases if the SID is
    ///passed. In contrast, the <b>ncacn_*</b> and <b>ncadg_*</b> protocol sequences use a <b>ServerPrincName</b>
    ///internally, and therefore can execute calls faster when provided the <b>ServerPrincName</b>.
    void* Sid;
    ///If set, only enabled privileges are seen by the server.
    uint  EffectiveOnly;
}

///The <b>RPC_SECURITY_QOS_V4</b> structure defines version 4 security quality-of-service settings on a binding handle.
///See Remarks for version availability on Windows editions.
struct RPC_SECURITY_QOS_V4_A
{
    ///Version of the RPC_SECURITY_QOS structure being used. This topic documents version 4 of the
    ///<b>RPC_SECURITY_QOS</b> structure. See <b>RPC_SECURITY_QOS</b>, RPC_SECURITY_QOS_V2, RPC_SECURITY_QOS_V3, and
    ///RPC_SECURITY_QOS_V5 for other versions.
    uint  Version;
    ///Security services being provided to the application. <i>Capabilities</i> is a set of flags that can be combined
    ///using the bitwise OR operator. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_DEFAULT"></a><a id="rpc_c_qos_capabilities_default"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_DEFAULT</b></dt> </dl> </td> <td width="60%"> No provider-specific capabilities are
    ///needed. </td> </tr> <tr> <td width="40%"><a id="RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH"></a><a
    ///id="rpc_c_qos_capabilities_mutual_auth"></a><dl> <dt><b>RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH</b></dt> </dl> </td>
    ///<td width="60%"> The RPC run time requests mutual authentication from the security provider. Some security
    ///providers do not support mutual authentication. If the security provider does not support mutual authentication,
    ///or the identity of the server cannot be established, a remote procedure call to such server fails with error
    ///RPC_S_SEC_PKG_ERROR. <div class="alert"><b>Note</b> RPC relies on the SSP to indicate which security options were
    ///successfully negotiated; in turn an RPC call fails if the SSP reports it could not negotiate an option. However,
    ///some security providers are known to report the successful negotiation of an option even when the option was not
    ///successfully negotiated. For example, NTLM will report successful negotiation of mutual authentication for
    ///backward compatibility reasons, even though it does not support mutual authentication. Check with the particular
    ///SSP being used to determine its behavior with respect to security options.</div> <div> </div> </td> </tr> <tr>
    ///<td width="40%"><a id="RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC"></a><a
    ///id="rpc_c_qos_capabilities_make_fullsic"></a><dl> <dt><b>RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC</b></dt> </dl> </td>
    ///<td width="60%"> Not currently implemented. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY"></a><a id="rpc_c_qos_capabilities_any_authority"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY</b></dt> </dl> </td> <td width="60%"> Accepts the client's
    ///credentials even if the certificate authority (CA) is not in the server's list of trusted CAs. This constant is
    ///used only by the SCHANNEL SSP. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE"></a><a
    ///id="rpc_c_qos_capabilities_ignore_delegate_failure"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE</b></dt> </dl> </td> <td width="60%"> The RPC runtime on
    ///the client ignores an error to establish a security context that supports delegation. Normally, if the client
    ///asks for delegation and the security system cannot establish a security context that supports delegation, error
    ///RPC_S_SEC_PKG_ERROR is returned; when this flag is specified, no error is returned. <div
    ///class="alert"><b>Note</b> Unsupported on Windows XP and earlier client editions, unsupported on Windows 2000 and
    ///earlier server editions.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT"></a><a id="rpc_c_qos_capabilities_local_ma_hint"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT</b></dt> </dl> </td> <td width="60%"> The server is local to the
    ///machine making the RPC call. In this situation RPC instructs the endpoint mapper to pick up only endpoints
    ///registered by the principal specified in the <b>ServerPrincName</b> or <b>Sid</b> members (these members are
    ///available in RPC_SECURITY_QOS_V3, <b>RPC_SECURITY_QOS_V4</b>, and RPC_SECURITY_QOS_V5 only). See Remarks for more
    ///information. <div class="alert"><b>Note</b> Unsupported on Windows XP and earlier client editions, unsupported on
    ///Windows 2000 and earlier server editions.</div> <div> </div> </td> </tr> </table>
    uint  Capabilities;
    ///The context tracking mode as one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="RPC_C_QOS_IDENTITY_STATIC"></a><a id="rpc_c_qos_identity_static"></a><dl>
    ///<dt><b>RPC_C_QOS_IDENTITY_STATIC</b></dt> </dl> </td> <td width="60%"> The security context is created only once
    ///and is never revised during the entire communication, even if the client side changes it. This is the default
    ///behavior if <b>RPC_SECURITY_QOS_V4</b> is not specified. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_IDENTITY_DYNAMIC"></a><a id="rpc_c_qos_identity_dynamic"></a><dl>
    ///<dt><b>RPC_C_QOS_IDENTITY_DYNAMIC</b></dt> </dl> </td> <td width="60%"> The Security context is revised whenever
    ///the ModifiedId in the client's token is changed. All protocols use the ModifiedId (see note). <b>Windows 2000:
    ///</b>All remote protocols (all protocols other than ncalrpc) use the AuthenticationID, also known as the LogonId,
    ///to track changes in the client's identity. The <b>ncalrpc</b> protocol uses ModifiedId. </td> </tr> </table>
    uint  IdentityTracking;
    ///The level at which the server process can impersonate the client. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_DEFAULT"></a><a id="rpc_c_imp_level_default"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_DEFAULT</b></dt> </dl> </td> <td width="60%"> Uses the default impersonation level. </td>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_ANONYMOUS"></a><a id="rpc_c_imp_level_anonymous"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_ANONYMOUS</b></dt> </dl> </td> <td width="60%"> The client does not provide identification
    ///information to the server. The server cannot impersonate the client or identify the client. Many servers reject
    ///calls with this impersonation type. </td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_IDENTIFY"></a><a
    ///id="rpc_c_imp_level_identify"></a><dl> <dt><b>RPC_C_IMP_LEVEL_IDENTIFY</b></dt> </dl> </td> <td width="60%"> The
    ///server can obtain the client's identity, and impersonate the client to perform Access Control List (ACL) checks,
    ///but cannot impersonate the client. See Impersonation Levels for more information. <div class="alert"><b>Note</b>
    ///Some security providers may treat this impersonation type as equivalent to RPC_C_IMP_LEVEL_IMPERSONATE. </div>
    ///<div> </div> </td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_IMPERSONATE"></a><a
    ///id="rpc_c_imp_level_impersonate"></a><dl> <dt><b>RPC_C_IMP_LEVEL_IMPERSONATE</b></dt> </dl> </td> <td
    ///width="60%"> The server can impersonate the client's security context on its local system, but not on remote
    ///systems. </td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_DELEGATE"></a><a
    ///id="rpc_c_imp_level_delegate"></a><dl> <dt><b>RPC_C_IMP_LEVEL_DELEGATE</b></dt> </dl> </td> <td width="60%"> The
    ///server can impersonate the client's security context while acting on behalf of the client. The server can also
    ///make outgoing calls to other servers while acting on behalf of the client. The server may use the client's
    ///security context on other machines to access local and remote resources as the client. </td> </tr> </table>
    uint  ImpersonationType;
    ///The type of additional credentials present in the <b>u</b> union. The following constants are supported: <table>
    ///<tr> <th>Supported Constants</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl>
    ///<dt><b>0</b></dt> </dl> </td> <td width="60%"> No additional credentials are passed in the <b>u</b> union. </td>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_AUTHN_INFO_TYPE_HTTP"></a><a id="rpc_c_authn_info_type_http"></a><dl>
    ///<dt><b>RPC_C_AUTHN_INFO_TYPE_HTTP</b></dt> </dl> </td> <td width="60%"> The <b>HttpCredentials</b> member of the
    ///<b>u</b> union points to a RPC_HTTP_TRANSPORT_CREDENTIALS structure. This value can be used only when the
    ///protocol sequence is ncacn_http. Any other protocol sequence returns RPC_S_INVALID_ARG. </td> </tr> </table>
    uint  AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_A* HttpCredentials;
    }
    ///Pointer to a security identifier (SID). The SID is an alternative to the <b>ServerPrincName</b> member, and only
    ///one can be specified. The <b>Sid</b> member cannot be set to non-<b>NULL</b> if the security provider is the
    ///SCHANNEL SSP. Some protocol sequences use <b>Sid</b> internally for security, and some use a
    ///<b>ServerPrincName</b>. For example, ncalrpc uses a <b>Sid</b> internally, and if the caller knows both the SID
    ///and the <b>ServerPrincName</b>, a call using <b>ncalrpc</b> can complete much faster in some cases if the SID is
    ///passed. In contrast, the <b>ncacn_*</b> and <b>ncadg_*</b> protocol sequences use a <b>ServerPrincName</b>
    ///internally, and therefore can execute calls faster when provided the <b>ServerPrincName</b>.
    void* Sid;
    ///If set, only enabled privileges are seen by the server.
    uint  EffectiveOnly;
}

///The <b>RPC_SECURITY_QOS_V5</b> structure defines version 5 security quality-of-service settings on a binding handle.
///See Remarks for version availability on Windows editions.
struct RPC_SECURITY_QOS_V5_W
{
    ///Version of the RPC_SECURITY_QOS structure being used. This topic documents version 5 of the
    ///<b>RPC_SECURITY_QOS</b> structure. See <b>RPC_SECURITY_QOS</b>, RPC_SECURITY_QOS_V2, RPC_SECURITY_QOS_V3, and
    ///RPC_SECURITY_QOS_V4 for other versions.
    uint  Version;
    ///Security services being provided to the application. <i>Capabilities</i> is a set of flags that can be combined
    ///using the bitwise OR operator. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_DEFAULT"></a><a id="rpc_c_qos_capabilities_default"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_DEFAULT</b></dt> </dl> </td> <td width="60%"> No provider-specific capabilities are
    ///needed. </td> </tr> <tr> <td width="40%"><a id="RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH"></a><a
    ///id="rpc_c_qos_capabilities_mutual_auth"></a><dl> <dt><b>RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH</b></dt> </dl> </td>
    ///<td width="60%"> The RPC run time requests mutual authentication from the security provider. Some security
    ///providers do not support mutual authentication. If the security provider does not support mutual authentication,
    ///or the identity of the server cannot be established, a remote procedure call to such server fails with error
    ///RPC_S_SEC_PKG_ERROR. <div class="alert"><b>Note</b> RPC relies on the SSP to indicate which security options were
    ///successfully negotiated; in turn an RPC call fails if the SSP reports it could not negotiate an option. However,
    ///some security providers are known to report the successful negotiation of an option even when the option was not
    ///successfully negotiated. For example, NTLM will report successful negotiation of mutual authentication for
    ///backward compatibility reasons, even though it does not support mutual authentication. Check with the particular
    ///SSP being used to determine its behavior with respect to security options.</div> <div> </div> </td> </tr> <tr>
    ///<td width="40%"><a id="RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC"></a><a
    ///id="rpc_c_qos_capabilities_make_fullsic"></a><dl> <dt><b>RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC</b></dt> </dl> </td>
    ///<td width="60%"> Not currently implemented. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY"></a><a id="rpc_c_qos_capabilities_any_authority"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY</b></dt> </dl> </td> <td width="60%"> Accepts the client's
    ///credentials even if the certificate authority (CA) is not in the server's list of trusted CAs. This constant is
    ///used only by the SCHANNEL SSP. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE"></a><a
    ///id="rpc_c_qos_capabilities_ignore_delegate_failure"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE</b></dt> </dl> </td> <td width="60%"> The RPC runtime on
    ///the client ignores an error to establish a security context that supports delegation. Normally, if the client
    ///asks for delegation and the security system cannot establish a security context that supports delegation, error
    ///RPC_S_SEC_PKG_ERROR is returned; when this flag is specified, no error is returned. <div
    ///class="alert"><b>Note</b> Unsupported on Windows XP and earlier client editions, unsupported on Windows 2000 and
    ///earlier server editions.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT"></a><a id="rpc_c_qos_capabilities_local_ma_hint"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT</b></dt> </dl> </td> <td width="60%"> The server is local to the
    ///machine making the RPC call. In this situation RPC instructs the endpoint mapper to pick up only endpoints
    ///registered by the principal specified in the <b>ServerPrincName</b> or <b>Sid</b> members (these members are
    ///available in RPC_SECURITY_QOS_V3, RPC_SECURITY_QOS_V4, and <b>RPC_SECURITY_QOS_V5</b> only). See Remarks for more
    ///information. <div class="alert"><b>Note</b> Unsupported on Windows XP and earlier client editions, unsupported on
    ///Windows 2000 and earlier server editions.</div> <div> </div> </td> </tr> </table>
    uint  Capabilities;
    ///The context tracking mode as one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="RPC_C_QOS_IDENTITY_STATIC"></a><a id="rpc_c_qos_identity_static"></a><dl>
    ///<dt><b>RPC_C_QOS_IDENTITY_STATIC</b></dt> </dl> </td> <td width="60%"> The security context is created only once
    ///and is never revised during the entire communication, even if the client side changes it. This is the default
    ///behavior if <b>RPC_SECURITY_QOS_V5</b> is not specified. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_IDENTITY_DYNAMIC"></a><a id="rpc_c_qos_identity_dynamic"></a><dl>
    ///<dt><b>RPC_C_QOS_IDENTITY_DYNAMIC</b></dt> </dl> </td> <td width="60%"> The Security context is revised whenever
    ///the ModifiedId in the client's token is changed. All protocols use the ModifiedId (see note). <b>Windows 2000:
    ///</b>All remote protocols (all protocols other than ncalrpc) use the AuthenticationID, also known as the LogonId,
    ///to track changes in the client's identity. The <b>ncalrpc</b> protocol uses ModifiedId. </td> </tr> </table>
    uint  IdentityTracking;
    ///The level at which the server process can impersonate the client. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_DEFAULT"></a><a id="rpc_c_imp_level_default"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_DEFAULT</b></dt> </dl> </td> <td width="60%"> Uses the default impersonation level. </td>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_ANONYMOUS"></a><a id="rpc_c_imp_level_anonymous"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_ANONYMOUS</b></dt> </dl> </td> <td width="60%"> The client does not provide identification
    ///information to the server. The server cannot impersonate the client or identify the client. Many servers reject
    ///calls with this impersonation type. </td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_IDENTIFY"></a><a
    ///id="rpc_c_imp_level_identify"></a><dl> <dt><b>RPC_C_IMP_LEVEL_IDENTIFY</b></dt> </dl> </td> <td width="60%"> The
    ///server can obtain the client's identity, and impersonate the client to perform Access Control List (ACL) checks,
    ///but cannot impersonate the client. See Impersonation Levels for more information. <div class="alert"><b>Note</b>
    ///Some security providers may treat this impersonation type as equivalent to RPC_C_IMP_LEVEL_IMPERSONATE. </div>
    ///<div> </div> </td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_IMPERSONATE"></a><a
    ///id="rpc_c_imp_level_impersonate"></a><dl> <dt><b>RPC_C_IMP_LEVEL_IMPERSONATE</b></dt> </dl> </td> <td
    ///width="60%"> The server can impersonate the client's security context on its local system, but not on remote
    ///systems. </td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_DELEGATE"></a><a
    ///id="rpc_c_imp_level_delegate"></a><dl> <dt><b>RPC_C_IMP_LEVEL_DELEGATE</b></dt> </dl> </td> <td width="60%"> The
    ///server can impersonate the client's security context while acting on behalf of the client. The server can also
    ///make outgoing calls to other servers while acting on behalf of the client. The server may use the client's
    ///security context on other machines to access local and remote resources as the client. </td> </tr> </table>
    uint  ImpersonationType;
    ///The type of additional credentials present in the <b>u</b> union. The following constants are supported: <table>
    ///<tr> <th>Supported Constants</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl>
    ///<dt><b>0</b></dt> </dl> </td> <td width="60%"> No additional credentials are passed in the <b>u</b> union. </td>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_AUTHN_INFO_TYPE_HTTP"></a><a id="rpc_c_authn_info_type_http"></a><dl>
    ///<dt><b>RPC_C_AUTHN_INFO_TYPE_HTTP</b></dt> </dl> </td> <td width="60%"> The <b>HttpCredentials</b> member of the
    ///<b>u</b> union points to a RPC_HTTP_TRANSPORT_CREDENTIALS structure. This value can be used only when the
    ///protocol sequence is ncacn_http. Any other protocol sequence returns RPC_S_INVALID_ARG. </td> </tr> </table>
    uint  AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_W* HttpCredentials;
    }
    ///Pointer to a security identifier (SID). The SID is an alternative to the <b>ServerPrincName</b> member, and only
    ///one can be specified. The <b>Sid</b> member cannot be set to non-<b>NULL</b> if the security provider is the
    ///SCHANNEL SSP. Some protocol sequences use <b>Sid</b> internally for security, and some use a
    ///<b>ServerPrincName</b>. For example, ncalrpc uses a <b>Sid</b> internally, and if the caller knows both the SID
    ///and the <b>ServerPrincName</b>, a call using <b>ncalrpc</b> can complete much faster in some cases if the SID is
    ///passed. In contrast, the <b>ncacn_*</b> and <b>ncadg_*</b> protocol sequences use a <b>ServerPrincName</b>
    ///internally, and therefore can execute calls faster when provided the <b>ServerPrincName</b>.
    void* Sid;
    ///If set, only enabled privileges are seen by the server.
    uint  EffectiveOnly;
    ///A pointer to the SECURITY_DESCRIPTOR that identifies the server. It is required for mutual authentication.
    void* ServerSecurityDescriptor;
}

///The <b>RPC_SECURITY_QOS_V5</b> structure defines version 5 security quality-of-service settings on a binding handle.
///See Remarks for version availability on Windows editions.
struct RPC_SECURITY_QOS_V5_A
{
    ///Version of the RPC_SECURITY_QOS structure being used. This topic documents version 5 of the
    ///<b>RPC_SECURITY_QOS</b> structure. See <b>RPC_SECURITY_QOS</b>, RPC_SECURITY_QOS_V2, RPC_SECURITY_QOS_V3, and
    ///RPC_SECURITY_QOS_V4 for other versions.
    uint  Version;
    ///Security services being provided to the application. <i>Capabilities</i> is a set of flags that can be combined
    ///using the bitwise OR operator. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_DEFAULT"></a><a id="rpc_c_qos_capabilities_default"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_DEFAULT</b></dt> </dl> </td> <td width="60%"> No provider-specific capabilities are
    ///needed. </td> </tr> <tr> <td width="40%"><a id="RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH"></a><a
    ///id="rpc_c_qos_capabilities_mutual_auth"></a><dl> <dt><b>RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH</b></dt> </dl> </td>
    ///<td width="60%"> The RPC run time requests mutual authentication from the security provider. Some security
    ///providers do not support mutual authentication. If the security provider does not support mutual authentication,
    ///or the identity of the server cannot be established, a remote procedure call to such server fails with error
    ///RPC_S_SEC_PKG_ERROR. <div class="alert"><b>Note</b> RPC relies on the SSP to indicate which security options were
    ///successfully negotiated; in turn an RPC call fails if the SSP reports it could not negotiate an option. However,
    ///some security providers are known to report the successful negotiation of an option even when the option was not
    ///successfully negotiated. For example, NTLM will report successful negotiation of mutual authentication for
    ///backward compatibility reasons, even though it does not support mutual authentication. Check with the particular
    ///SSP being used to determine its behavior with respect to security options.</div> <div> </div> </td> </tr> <tr>
    ///<td width="40%"><a id="RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC"></a><a
    ///id="rpc_c_qos_capabilities_make_fullsic"></a><dl> <dt><b>RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC</b></dt> </dl> </td>
    ///<td width="60%"> Not currently implemented. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY"></a><a id="rpc_c_qos_capabilities_any_authority"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY</b></dt> </dl> </td> <td width="60%"> Accepts the client's
    ///credentials even if the certificate authority (CA) is not in the server's list of trusted CAs. This constant is
    ///used only by the SCHANNEL SSP. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE"></a><a
    ///id="rpc_c_qos_capabilities_ignore_delegate_failure"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE</b></dt> </dl> </td> <td width="60%"> The RPC runtime on
    ///the client ignores an error to establish a security context that supports delegation. Normally, if the client
    ///asks for delegation and the security system cannot establish a security context that supports delegation, error
    ///RPC_S_SEC_PKG_ERROR is returned; when this flag is specified, no error is returned. <div
    ///class="alert"><b>Note</b> Unsupported on Windows XP and earlier client editions, unsupported on Windows 2000 and
    ///earlier server editions.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT"></a><a id="rpc_c_qos_capabilities_local_ma_hint"></a><dl>
    ///<dt><b>RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT</b></dt> </dl> </td> <td width="60%"> The server is local to the
    ///machine making the RPC call. In this situation RPC instructs the endpoint mapper to pick up only endpoints
    ///registered by the principal specified in the <b>ServerPrincName</b> or <b>Sid</b> members (these members are
    ///available in RPC_SECURITY_QOS_V3, RPC_SECURITY_QOS_V4, and <b>RPC_SECURITY_QOS_V5</b> only). See Remarks for more
    ///information. <div class="alert"><b>Note</b> Unsupported on Windows XP and earlier client editions, unsupported on
    ///Windows 2000 and earlier server editions.</div> <div> </div> </td> </tr> </table>
    uint  Capabilities;
    ///The context tracking mode as one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="RPC_C_QOS_IDENTITY_STATIC"></a><a id="rpc_c_qos_identity_static"></a><dl>
    ///<dt><b>RPC_C_QOS_IDENTITY_STATIC</b></dt> </dl> </td> <td width="60%"> The security context is created only once
    ///and is never revised during the entire communication, even if the client side changes it. This is the default
    ///behavior if <b>RPC_SECURITY_QOS_V5</b> is not specified. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_C_QOS_IDENTITY_DYNAMIC"></a><a id="rpc_c_qos_identity_dynamic"></a><dl>
    ///<dt><b>RPC_C_QOS_IDENTITY_DYNAMIC</b></dt> </dl> </td> <td width="60%"> The Security context is revised whenever
    ///the ModifiedId in the client's token is changed. All protocols use the ModifiedId (see note). <b>Windows 2000:
    ///</b>All remote protocols (all protocols other than ncalrpc) use the AuthenticationID, also known as the LogonId,
    ///to track changes in the client's identity. The <b>ncalrpc</b> protocol uses ModifiedId. </td> </tr> </table>
    uint  IdentityTracking;
    ///The level at which the server process can impersonate the client. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_DEFAULT"></a><a id="rpc_c_imp_level_default"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_DEFAULT</b></dt> </dl> </td> <td width="60%"> Uses the default impersonation level. </td>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_ANONYMOUS"></a><a id="rpc_c_imp_level_anonymous"></a><dl>
    ///<dt><b>RPC_C_IMP_LEVEL_ANONYMOUS</b></dt> </dl> </td> <td width="60%"> The client does not provide identification
    ///information to the server. The server cannot impersonate the client or identify the client. Many servers reject
    ///calls with this impersonation type. </td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_IDENTIFY"></a><a
    ///id="rpc_c_imp_level_identify"></a><dl> <dt><b>RPC_C_IMP_LEVEL_IDENTIFY</b></dt> </dl> </td> <td width="60%"> The
    ///server can obtain the client's identity, and impersonate the client to perform Access Control List (ACL) checks,
    ///but cannot impersonate the client. See Impersonation Levels for more information. <div class="alert"><b>Note</b>
    ///Some security providers may treat this impersonation type as equivalent to RPC_C_IMP_LEVEL_IMPERSONATE. </div>
    ///<div> </div> </td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_IMPERSONATE"></a><a
    ///id="rpc_c_imp_level_impersonate"></a><dl> <dt><b>RPC_C_IMP_LEVEL_IMPERSONATE</b></dt> </dl> </td> <td
    ///width="60%"> The server can impersonate the client's security context on its local system, but not on remote
    ///systems. </td> </tr> <tr> <td width="40%"><a id="RPC_C_IMP_LEVEL_DELEGATE"></a><a
    ///id="rpc_c_imp_level_delegate"></a><dl> <dt><b>RPC_C_IMP_LEVEL_DELEGATE</b></dt> </dl> </td> <td width="60%"> The
    ///server can impersonate the client's security context while acting on behalf of the client. The server can also
    ///make outgoing calls to other servers while acting on behalf of the client. The server may use the client's
    ///security context on other machines to access local and remote resources as the client. </td> </tr> </table>
    uint  ImpersonationType;
    ///The type of additional credentials present in the <b>u</b> union. The following constants are supported: <table>
    ///<tr> <th>Supported Constants</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="0"></a><dl>
    ///<dt><b>0</b></dt> </dl> </td> <td width="60%"> No additional credentials are passed in the <b>u</b> union. </td>
    ///</tr> <tr> <td width="40%"><a id="RPC_C_AUTHN_INFO_TYPE_HTTP"></a><a id="rpc_c_authn_info_type_http"></a><dl>
    ///<dt><b>RPC_C_AUTHN_INFO_TYPE_HTTP</b></dt> </dl> </td> <td width="60%"> The <b>HttpCredentials</b> member of the
    ///<b>u</b> union points to a RPC_HTTP_TRANSPORT_CREDENTIALS structure. This value can be used only when the
    ///protocol sequence is ncacn_http. Any other protocol sequence returns RPC_S_INVALID_ARG. </td> </tr> </table>
    uint  AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_A* HttpCredentials;
    }
    ///Pointer to a security identifier (SID). The SID is an alternative to the <b>ServerPrincName</b> member, and only
    ///one can be specified. The <b>Sid</b> member cannot be set to non-<b>NULL</b> if the security provider is the
    ///SCHANNEL SSP. Some protocol sequences use <b>Sid</b> internally for security, and some use a
    ///<b>ServerPrincName</b>. For example, ncalrpc uses a <b>Sid</b> internally, and if the caller knows both the SID
    ///and the <b>ServerPrincName</b>, a call using <b>ncalrpc</b> can complete much faster in some cases if the SID is
    ///passed. In contrast, the <b>ncacn_*</b> and <b>ncadg_*</b> protocol sequences use a <b>ServerPrincName</b>
    ///internally, and therefore can execute calls faster when provided the <b>ServerPrincName</b>.
    void* Sid;
    ///If set, only enabled privileges are seen by the server.
    uint  EffectiveOnly;
    ///A pointer to the SECURITY_DESCRIPTOR that identifies the server. It is required for mutual authentication.
    void* ServerSecurityDescriptor;
}

///The <b>RPC_BINDING_HANDLE_TEMPLATE_V1</b> structure contains the basic options with which to create an RPC binding
///handle.
struct RPC_BINDING_HANDLE_TEMPLATE_V1_W
{
    ///The version of this structure. For <b>RPC_BINDING_HANDLE_TEMPLATE_V1</b> this must be set to 1.
    uint    Version;
    ///Flag values that describe specific properties of the RPC template. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="RPC_BHT_OBJECT_UUID_VALID"></a><a id="rpc_bht_object_uuid_valid"></a><dl>
    ///<dt><b>RPC_BHT_OBJECT_UUID_VALID</b></dt> </dl> </td> <td width="60%"> The <b>ObjectUuid</b> member contains a
    ///valid value. If this flag is not set, then the ObjectUuid member does not contain a valid UUID. </td> </tr>
    ///</table>
    uint    Flags;
    ///A protocol sequence string literal associated with this binding handle. It can be one of the following values.
    ///**ncalrpc** - Specifies local RPC. **ncacn_ip_tcp** - Specifies RPC over TCP/IP. **ncacn_np** - Specifies RPC
    ///over named pipes. **ncacn_http** - Specifies RPC over HTTP.
    uint    ProtocolSequence;
    ///Pointer to a string representation of the network address to bind to.
    ushort* NetworkAddress;
    ///Pointer to a string representation of the endpoint to bind to. If a dynamic endpoint is used, set this member to
    ///<b>NULL</b>. After the endpoint is resolved, use RpcBindingToStringBinding to obtain it.
    ushort* StringEndpoint;
    union u1
    {
        ushort* Reserved;
    }
    ///The UUID of the remote object. The semantics for this UUID are the same as those for a string binding. After the
    ///binding handle is created, call RpcBindingSetObject to change the UUID as needed.
    GUID    ObjectUuid;
}

///The <b>RPC_BINDING_HANDLE_TEMPLATE_V1</b> structure contains the basic options with which to create an RPC binding
///handle.
struct RPC_BINDING_HANDLE_TEMPLATE_V1_A
{
    ///The version of this structure. For <b>RPC_BINDING_HANDLE_TEMPLATE_V1</b> this must be set to 1.
    uint   Version;
    ///Flag values that describe specific properties of the RPC template. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="RPC_BHT_OBJECT_UUID_VALID"></a><a id="rpc_bht_object_uuid_valid"></a><dl>
    ///<dt><b>RPC_BHT_OBJECT_UUID_VALID</b></dt> </dl> </td> <td width="60%"> The <b>ObjectUuid</b> member contains a
    ///valid value. If this flag is not set, then the ObjectUuid member does not contain a valid UUID. </td> </tr>
    ///</table>
    uint   Flags;
    ///A protocol sequence string literal associated with this binding handle. It can be one of the following values. *
    ///**ncalrpc** - Specifies local RPC. * **ncacn_ip_tcp** - Specifies RPC over TCP/IP. * **ncacn_np** - Specifies RPC
    ///over named pipes. * **ncacn_http** - Specifies RPC over HTTP.
    uint   ProtocolSequence;
    ///Pointer to a string representation of the network address to bind to.
    ubyte* NetworkAddress;
    ///Pointer to a string representation of the endpoint to bind to. If a dynamic endpoint is used, set this member to
    ///<b>NULL</b>. After the endpoint is resolved, use RpcBindingToStringBinding to obtain it.
    ubyte* StringEndpoint;
    union u1
    {
        ubyte* Reserved;
    }
    ///The UUID of the remote object. The semantics for this UUID are the same as those for a string binding. After the
    ///binding handle is created, call RpcBindingSetObject to change the UUID as needed.
    GUID   ObjectUuid;
}

///The <b>RPC_BINDING_HANDLE_SECURITY_V1</b> structure contains the basic security options with which to create an RPC
///binding handle.
struct RPC_BINDING_HANDLE_SECURITY_V1_W
{
    ///The version of this structure. For <b>RPC_BINDING_HANDLE_SECURITY_V1</b> this must be set to 1.
    uint              Version;
    ///Pointer to a string that contains the server principal name referenced by the binding handle. The content of the
    ///name and its syntax are defined by the authentication service in use.
    ushort*           ServerPrincName;
    ///Level of authentication to be performed on remote procedure calls made using this binding handle. For a list of
    ///the RPC-supported authentication levels, see Authentication-Level Constants. If <i>AuthnSvc</i> is set to
    ///RPC_C_AUTHN_NONE, this member must likewise be set to RPC_C_AUTHN_NONE.
    uint              AuthnLevel;
    ///Authentication service to use when binding. Specify RPC_C_AUTHN_NONE to turn off authentication for remote
    ///procedure calls made using the binding handle. If RPC_C_AUTHN_DEFAULT is specified, the RPC run-time library uses
    ///the RPC_C_AUTHN_WINNT authentication service for remote procedure calls made using the binding handle. If
    ///<i>AuthnLevel</i> is set to RPC_C_AUTHN_NONE, this member must likewise be set to RPC_C_AUTHN_NONE.
    uint              AuthnSvc;
    ///SEC_WINNT_AUTH_IDENTITY structure that contains the client's authentication and authorization credentials
    ///appropriate for the selected authentication and authorization service.
    SEC_WINNT_AUTH_IDENTITY_W* AuthIdentity;
    ///RPC_SECURITY_QOS structure that contains the security quality-of-service settings for the binding handle. <div
    ///class="alert"><b>Note</b> For a list of the RPC-supported authentication services, see Authentication-Service
    ///Constants.</div> <div> </div>
    RPC_SECURITY_QOS* SecurityQos;
}

///The <b>RPC_BINDING_HANDLE_SECURITY_V1</b> structure contains the basic security options with which to create an RPC
///binding handle.
struct RPC_BINDING_HANDLE_SECURITY_V1_A
{
    ///The version of this structure. For <b>RPC_BINDING_HANDLE_SECURITY_V1</b> this must be set to 1.
    uint              Version;
    ///Pointer to a string that contains the server principal name referenced by the binding handle. The content of the
    ///name and its syntax are defined by the authentication service in use.
    ubyte*            ServerPrincName;
    ///Level of authentication to be performed on remote procedure calls made using this binding handle. For a list of
    ///the RPC-supported authentication levels, see Authentication-Level Constants. If <i>AuthnSvc</i> is set to
    ///RPC_C_AUTHN_NONE, this member must likewise be set to RPC_C_AUTHN_NONE.
    uint              AuthnLevel;
    ///Authentication service to use when binding. Specify RPC_C_AUTHN_NONE to turn off authentication for remote
    ///procedure calls made using the binding handle. If RPC_C_AUTHN_DEFAULT is specified, the RPC run-time library uses
    ///the RPC_C_AUTHN_WINNT authentication service for remote procedure calls made using the binding handle. If
    ///<i>AuthnLevel</i> is set to RPC_C_AUTHN_NONE, this member must likewise be set to RPC_C_AUTHN_NONE.
    uint              AuthnSvc;
    ///SEC_WINNT_AUTH_IDENTITY structure that contains the client's authentication and authorization credentials
    ///appropriate for the selected authentication and authorization service.
    SEC_WINNT_AUTH_IDENTITY_A* AuthIdentity;
    ///RPC_SECURITY_QOS structure that contains the security quality-of-service settings for the binding handle. <div
    ///class="alert"><b>Note</b> For a list of the RPC-supported authentication services, see Authentication-Service
    ///Constants.</div> <div> </div>
    RPC_SECURITY_QOS* SecurityQos;
}

///The <b>RPC_BINDING_HANDLE_OPTIONS_V1</b> structure contains additional options with which to create an RPC binding
///handle.
struct RPC_BINDING_HANDLE_OPTIONS_V1
{
    ///The version of this structure. For <b>RPC_BINDING_HANDLE_OPTIONS_V1</b> this must be set to 1.
    uint Version;
    ///A set of flags describing specific RPC behaviors. This parameter can be set to one or more of the following
    ///values. Note that by default, RPC calls use causal order and socket lingering. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="RPC_BHO_NONCAUSAL"></a><a id="rpc_bho_noncausal"></a><dl>
    ///<dt><b>RPC_BHO_NONCAUSAL</b></dt> </dl> </td> <td width="60%"> Specifies causal ordering whereby calls are
    ///executed independently of one another rather than in order of submission. </td> </tr> <tr> <td width="40%"><a
    ///id="RPC_BHO_DONTLINGER"></a><a id="rpc_bho_dontlinger"></a><dl> <dt><b>RPC_BHO_DONTLINGER</b></dt> </dl> </td>
    ///<td width="60%"> Specifies that a socket association must be shutdown after the last binding handle on it is
    ///freed. </td> </tr> </table>
    uint Flags;
    ///The communication timeout value, specified in microseconds. The default value for RPC is
    ///RPC_C_BINDING_DEFAULT_TIMEOUT. This option can be changed later by calling RpcMgmtSetComTimeout.
    uint ComTimeout;
    ///The call timeout value, specified in microseconds. The default value for RPC is 0.
    uint CallTimeout;
}

struct RPC_CLIENT_INFORMATION1
{
    ubyte* UserName;
    ubyte* ComputerName;
    ushort Privilege;
    uint   AuthFlags;
}

///The <b>RPC_ENDPOINT_TEMPLATE</b> structure specifies the properties of an RPC interface group server endpoint,
///including protocol sequence and name.
struct RPC_ENDPOINT_TEMPLATEW
{
    ///This field is reserved and must be set to 0.
    uint    Version;
    ///Pointer to a string identifier of the protocol sequence to register with the RPC run-time library. Only ncalrpc,
    ///ncacn_ip_tcp, and ncacn_np are supported. This value must not be <b>NULL</b>.
    ushort* ProtSeq;
    ///Optional pointer to the endpoint-address information to use in creating a binding for the protocol sequence
    ///specified in the <i>Protseq</i> parameter. Specify <b>NULL</b> to use dynamic endpoints.
    ushort* Endpoint;
    ///Pointer to an optional parameter provided for the security subsystem. Used only for ncacn_np and ncalrpc protocol
    ///sequences. All other protocol sequences ignore this parameter. Using a security descriptor on the endpoint in
    ///order to make a server secure is not recommended.
    void*   SecurityDescriptor;
    ///Backlog queue length for the ncacn_ip_tcp protocol sequence. All other protocol sequences ignore this parameter.
    ///Use <b>RPC_C_PROTSEQ_MAX_REQS_DEFAULT</b> to specify the default value. See Remarks for more informatation.
    uint    Backlog;
}

///The <b>RPC_ENDPOINT_TEMPLATE</b> structure specifies the properties of an RPC interface group server endpoint,
///including protocol sequence and name.
struct RPC_ENDPOINT_TEMPLATEA
{
    ///This field is reserved and must be set to 0.
    uint   Version;
    ///Pointer to a string identifier of the protocol sequence to register with the RPC run-time library. Only ncalrpc,
    ///ncacn_ip_tcp, and ncacn_np are supported. This value must not be <b>NULL</b>.
    ubyte* ProtSeq;
    ///Optional pointer to the endpoint-address information to use in creating a binding for the protocol sequence
    ///specified in the <i>Protseq</i> parameter. Specify <b>NULL</b> to use dynamic endpoints.
    ubyte* Endpoint;
    ///Pointer to an optional parameter provided for the security subsystem. Used only for ncacn_np and ncalrpc protocol
    ///sequences. All other protocol sequences ignore this parameter. Using a security descriptor on the endpoint in
    ///order to make a server secure is not recommended.
    void*  SecurityDescriptor;
    ///Backlog queue length for the ncacn_ip_tcp protocol sequence. All other protocol sequences ignore this parameter.
    ///Use <b>RPC_C_PROTSEQ_MAX_REQS_DEFAULT</b> to specify the default value. See Remarks for more informatation.
    uint   Backlog;
}

///The <b>RPC_INTERFACE_TEMPLATE</b> structure defines an RPC interface group server interface.
struct RPC_INTERFACE_TEMPLATEA
{
    ///This field is reserved and must be set to 0.
    uint                Version;
    ///MIDL-generated structure that defines the interface to register.
    void*               IfSpec;
    ///Pointer to a UUID to associate with <i>MgrEpv</i>. <b>NULL</b> or a nil <b>UUID</b> registers <i>IfSpec</i> with
    ///a nil <b>UUID</b>.
    GUID*               MgrTypeUuid;
    ///Pointer to a RPC_MGR_EPV structure that contains the manager routines' entry-point vector (EPV). If
    ///<b>NULL</b>,the MIDL-generated default EPV is used.
    void*               MgrEpv;
    ///Flags. For a list of flag values, see Interface Registration Flags. Interface group interfaces are always treated
    ///as <b>auto-listen</b>.
    uint                Flags;
    ///Maximum number of concurrent remote procedure call requests the server can accept on this interface. The RPC
    ///run-time library makes its best effort to ensure the server does not allow more concurrent call requests than the
    ///number of calls specified in <i>MaxCalls</i>. However, the actual number can be greater than <i>MaxCalls</i> and
    ///can vary for each protocol sequence. Calls on other interfaces are governed by the value of the process-wide
    ///<i>MaxCalls</i> parameter specified in RpcServerListen. If the number of concurrent calls is not a concern,
    ///slightly better server-side performance can be achieved by specifying the default value using
    ///<b>RPC_C_LISTEN_MAX_CALLS_DEFAULT</b>. Doing so relieves the RPC run-time environment from enforcing an
    ///unnecessary restriction.
    uint                MaxCalls;
    ///Maximum size, in bytes, of incoming data blocks. <i>MaxRpcSize</i> may be used to help prevent malicious
    ///denial-of-service attacks. If the data block of a remote procedure call is larger than <i>MaxRpcSize</i>, the RPC
    ///run-time library rejects the call and sends an <b>RPC_S_ACCESS_DENIED</b> error to the client. Specifying a value
    ///of (unsigned int) –1 in <i>MaxRpcSize</i> removes the limit on the size of incoming data blocks. This parameter
    ///has no effect on calls made over the ncalrpc protocol.
    uint                MaxRpcSize;
    ///A pointer to a RPC_INTERFACE_GROUP_IDLE_CALLBACK_FN security-callback function, or <b>NULL</b> for no callback.
    ///Each registered interface can have a different callback function.
    RPC_IF_CALLBACK_FN* IfCallback;
    ///Pointer to a vector of object UUIDs offered by the server to be registered with the RPC endpoint mapper. The
    ///server application constructs this vector. <b>NULL</b> indicates there are no object <b>UUIDs</b> to register.
    UUID_VECTOR*        UuidVector;
    ///Pointer to the character-string comment applied to each cross-product element added to the local endpoint-map
    ///database. The string can be up to 64 characters long, including the null terminating character. Specify a null
    ///value or a null-terminated string ("\0") if there is no annotation string. The annotation string is used by
    ///applications for information only. RPC does not use this string to determine which server instance a client
    ///communicates with or for enumerating elements in the endpoint-map database.
    ubyte*              Annotation;
    ///Optional security descriptor describing which clients have the right to access the interface.
    void*               SecurityDescriptor;
}

///The <b>RPC_INTERFACE_TEMPLATE</b> structure defines an RPC interface group server interface.
struct RPC_INTERFACE_TEMPLATEW
{
    ///This field is reserved and must be set to 0.
    uint                Version;
    ///MIDL-generated structure that defines the interface to register.
    void*               IfSpec;
    ///Pointer to a UUID to associate with <i>MgrEpv</i>. <b>NULL</b> or a nil <b>UUID</b> registers <i>IfSpec</i> with
    ///a nil <b>UUID</b>.
    GUID*               MgrTypeUuid;
    ///Pointer to a RPC_MGR_EPV structure that contains the manager routines' entry-point vector (EPV). If
    ///<b>NULL</b>,the MIDL-generated default EPV is used.
    void*               MgrEpv;
    ///Flags. For a list of flag values, see Interface Registration Flags. Interface group interfaces are always treated
    ///as <b>auto-listen</b>.
    uint                Flags;
    ///Maximum number of concurrent remote procedure call requests the server can accept on this interface. The RPC
    ///run-time library makes its best effort to ensure the server does not allow more concurrent call requests than the
    ///number of calls specified in <i>MaxCalls</i>. However, the actual number can be greater than <i>MaxCalls</i> and
    ///can vary for each protocol sequence. Calls on other interfaces are governed by the value of the process-wide
    ///<i>MaxCalls</i> parameter specified in RpcServerListen. If the number of concurrent calls is not a concern,
    ///slightly better server-side performance can be achieved by specifying the default value using
    ///<b>RPC_C_LISTEN_MAX_CALLS_DEFAULT</b>. Doing so relieves the RPC run-time environment from enforcing an
    ///unnecessary restriction.
    uint                MaxCalls;
    ///Maximum size, in bytes, of incoming data blocks. <i>MaxRpcSize</i> may be used to help prevent malicious
    ///denial-of-service attacks. If the data block of a remote procedure call is larger than <i>MaxRpcSize</i>, the RPC
    ///run-time library rejects the call and sends an <b>RPC_S_ACCESS_DENIED</b> error to the client. Specifying a value
    ///of (unsigned int) –1 in <i>MaxRpcSize</i> removes the limit on the size of incoming data blocks. This parameter
    ///has no effect on calls made over the ncalrpc protocol.
    uint                MaxRpcSize;
    ///A pointer to a RPC_INTERFACE_GROUP_IDLE_CALLBACK_FN security-callback function, or <b>NULL</b> for no callback.
    ///Each registered interface can have a different callback function.
    RPC_IF_CALLBACK_FN* IfCallback;
    ///Pointer to a vector of object UUIDs offered by the server to be registered with the RPC endpoint mapper. The
    ///server application constructs this vector. <b>NULL</b> indicates there are no object <b>UUIDs</b> to register.
    UUID_VECTOR*        UuidVector;
    ///Pointer to the character-string comment applied to each cross-product element added to the local endpoint-map
    ///database. The string can be up to 64 characters long, including the null terminating character. Specify a null
    ///value or a null-terminated string ("\0") if there is no annotation string. The annotation string is used by
    ///applications for information only. RPC does not use this string to determine which server instance a client
    ///communicates with or for enumerating elements in the endpoint-map database.
    ushort*             Annotation;
    ///Optional security descriptor describing which clients have the right to access the interface.
    void*               SecurityDescriptor;
}

struct RPC_VERSION
{
    ushort MajorVersion;
    ushort MinorVersion;
}

struct RPC_SYNTAX_IDENTIFIER
{
    GUID        SyntaxGUID;
    RPC_VERSION SyntaxVersion;
}

///The <b>RPC_MESSAGE</b> structure contains information shared between NDR and the rest of the RPC or OLE runtime.
struct RPC_MESSAGE
{
    ///Reserved.
    void* Handle;
    ///Data representation of the network buffer as defined by the NDR specification.
    uint  DataRepresentation;
    ///Pointer to the beginning of the network buffer.
    void* Buffer;
    ///Size, in bytes, of <b>Buffer</b>.
    uint  BufferLength;
    ///Reserved.
    uint  ProcNum;
    ///Reserved.
    RPC_SYNTAX_IDENTIFIER* TransferSyntax;
    ///Reserved.
    void* RpcInterfaceInformation;
    ///Reserved.
    void* ReservedForRuntime;
    ///Reserved.
    void* ManagerEpv;
    ///Reserved.
    void* ImportContext;
    uint  RpcFlags;
}

///The <b>RPC_DISPATCH_TABLE</b> structure is part of the private interface between the run-time libraries and the
///stubs. Most distributed applications that use Microsoft RPC do not need this structure. The structure is defined in
///the header file Rpcdcep.h. See the header file for syntax block and member definitions.
struct RPC_DISPATCH_TABLE
{
    uint      DispatchTableCount;
    RPC_DISPATCH_FUNCTION* DispatchTable;
    ptrdiff_t Reserved;
}

struct RPC_PROTSEQ_ENDPOINT
{
    ubyte* RpcProtocolSequence;
    ubyte* Endpoint;
}

struct RPC_SERVER_INTERFACE
{
    uint                Length;
    RPC_SYNTAX_IDENTIFIER InterfaceId;
    RPC_SYNTAX_IDENTIFIER TransferSyntax;
    RPC_DISPATCH_TABLE* DispatchTable;
    uint                RpcProtseqEndpointCount;
    RPC_PROTSEQ_ENDPOINT* RpcProtseqEndpoint;
    void*               DefaultManagerEpv;
    const(void)*        InterpreterInfo;
    uint                Flags;
}

///The <b>RPC_CLIENT_INTERFACE</b> structure is part of the private interface between the run-time libraries and the
///stubs. Most distributed applications that use Microsoft RPC do not need this structure. The data structure is defined
///in the header file Rpcdcep.h. See the header file for syntax block and member definitions.
struct RPC_CLIENT_INTERFACE
{
    uint                Length;
    RPC_SYNTAX_IDENTIFIER InterfaceId;
    RPC_SYNTAX_IDENTIFIER TransferSyntax;
    RPC_DISPATCH_TABLE* DispatchTable;
    uint                RpcProtseqEndpointCount;
    RPC_PROTSEQ_ENDPOINT* RpcProtseqEndpoint;
    size_t              Reserved;
    const(void)*        InterpreterInfo;
    uint                Flags;
}

struct RPC_SEC_CONTEXT_KEY_INFO
{
    uint EncryptAlgorithm;
    uint KeySize;
    uint SignatureAlgorithm;
}

struct RPC_TRANSFER_SYNTAX
{
    GUID   Uuid;
    ushort VersMajor;
    ushort VersMinor;
}

///The <b>RPC_C_OPT_COOKIE_AUTH_DESCRIPTOR</b> structure contains a cookie that is inserted into the header of RPC/HTTP
///traffic. This cookie can be used for authentication or for load balancing. When used for authentication,
///RPC_S_COOKIE_AUTH_FAILED is returned from an RPC call if cookie authentication fails. There are no specific error
///messages when used for load balancing.
struct RPC_C_OPT_COOKIE_AUTH_DESCRIPTOR
{
    ///The length, in bytes, of <b>Buffer</b>.
    uint  BufferSize;
    ///A null-terminated string that contains the cookie.
    byte* Buffer;
}

struct RDR_CALLOUT_STATE
{
    int     LastError;
    void*   LastEEInfo;
    RPC_HTTP_REDIRECTOR_STAGE LastCalledStage;
    ushort* ServerName;
    ushort* ServerPort;
    ushort* RemoteUser;
    ushort* AuthType;
    ubyte   ResourceTypePresent;
    ubyte   SessionIdPresent;
    ubyte   InterfacePresent;
    GUID    ResourceType;
    GUID    SessionId;
    RPC_SYNTAX_IDENTIFIER Interface;
    void*   CertContext;
}

struct I_RpcProxyCallbackInterface
{
    I_RpcProxyIsValidMachineFn IsValidMachineFn;
    I_RpcProxyGetClientAddressFn GetClientAddressFn;
    I_RpcProxyGetConnectionTimeoutFn GetConnectionTimeoutFn;
    I_RpcPerformCalloutFn PerformCalloutFn;
    I_RpcFreeCalloutStateFn FreeCalloutStateFn;
    I_RpcProxyGetClientSessionAndResourceUUID GetClientSessionAndResourceUUIDFn;
    I_RpcProxyFilterIfFn ProxyFilterIfFn;
    I_RpcProxyUpdatePerfCounterFn RpcProxyUpdatePerfCounterFn;
    I_RpcProxyUpdatePerfCounterBackendServerFn RpcProxyUpdatePerfCounterBackendServerFn;
}

///The <b>RPC_ASYNC_NOTIFICATION_INFO</b> union contains notification information for asynchronous remote procedure
///calls. This notification information can be configured for I/O completion ports (IOC), Windows asynchronous procedure
///calls (APC), Windows messaging, and Windows event notification.
union RPC_ASYNC_NOTIFICATION_INFO
{
    struct APC
    {
        PFN_RPCNOTIFICATION_ROUTINE NotificationRoutine;
        HANDLE hThread;
    }
    struct IOC
    {
        HANDLE      hIOPort;
        uint        dwNumberOfBytesTransferred;
        size_t      dwCompletionKey;
        OVERLAPPED* lpOverlapped;
    }
    struct IntPtr
    {
        HWND hWnd;
        uint Msg;
    }
    ///Handle used for notification by an event.
    HANDLE hEvent;
    ///Windows Vista or earlier versions of Windows: COM uses this internally for direct callbacks. Do not use this
    ///member. Windows 7 or later versions of Windows: An optional function pointer to a user-defined notification
    ///scheme built on top of RPC call completion. As an example, an application could call SubmitThreadpoolWork from
    ///the notification callback. <div class="alert"><b>Note</b> Making additional RPC calls, blocking, or performing
    ///long running work from notification callbacks is strongly discouraged.</div> <div> </div>
    PFN_RPCNOTIFICATION_ROUTINE NotificationRoutine;
}

///The <b>RPC_ASYNC_STATE</b> structure holds the state of an asynchronous remote procedure call. <b>RPC_ASYNC_STATE</b>
///is a handle to this structure, used to wait for, query, reply to, or cancel asynchronous calls.
struct RPC_ASYNC_STATE
{
    ///Size of this structure, in bytes. The environment sets this member when RpcAsyncInitializeHandle is called. Do
    ///not modify this member.
    uint            Size;
    ///The run-time environment sets this member when RpcAsyncInitializeHandle is called. Do not modify this member.
    uint            Signature;
    ///The run-time environment sets this member when RpcAsyncInitializeHandle is called. Do not modify this member.
    int             Lock;
    ///The <b>flags</b> member can be set to the following values. <table> <tr> <th>Constant</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="RPC_C_NOTIFY_ON_SEND_COMPLETE"></a><a id="rpc_c_notify_on_send_complete"></a><dl>
    ///<dt><b>RPC_C_NOTIFY_ON_SEND_COMPLETE</b></dt> </dl> </td> <td width="60%"> Posts a notification message when the
    ///asynchronous operation is complete. </td> </tr> </table> These flags are used with DCE pipes, which allow
    ///applications to send or receive data in multiple blocks. Programs can either send a continuous stream of data or
    ///wait for each block to be transmitted before it sends the next block. If it does not wait, the RPC run-time
    ///library will buffer the output until it can be sent. When the data transmission is complete, the RPC library
    ///sends the application a notification. If an application specifies the RPC_C_NOTIFY_ON_SEND_COMPLETE flag, the RPC
    ///library sends it a member of the RPC_NOTIFICATION_TYPES enumeration after it completes each send operation.
    uint            Flags;
    ///Reserved for use by the stubs. Do not use this member.
    void*           StubInfo;
    ///Use this member for any application-specific information that you want to keep track of in this structure.
    void*           UserInfo;
    ///Reserved for use by the RPC run-time environment. Do not use this member.
    void*           RuntimeInfo;
    ///Type of event that occurred. The RPC run-time environment sets this field to a member of the RPC_ASYNC_EVENT
    ///enumeration.
    RPC_ASYNC_EVENT Event;
    ///Type of notification the RPC run time should use to notify the client for the occurrence of an event, such as
    ///completion of the call or completion of the event. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="RpcNotificationTypeNone"></a><a id="rpcnotificationtypenone"></a><a
    ///id="RPCNOTIFICATIONTYPENONE"></a><dl> <dt><b>RpcNotificationTypeNone</b></dt> </dl> </td> <td width="60%"> No
    ///notification is specified; RPC_ASYNC_NOTIFICATION_INFO is not initialized. </td> </tr> <tr> <td width="40%"><a
    ///id="RpcNotificationTypeEvent"></a><a id="rpcnotificationtypeevent"></a><a id="RPCNOTIFICATIONTYPEEVENT"></a><dl>
    ///<dt><b>RpcNotificationTypeEvent</b></dt> </dl> </td> <td width="60%"> The notification mechanism is a Windows
    ///event. </td> </tr> <tr> <td width="40%"><a id="RpcNotificationTypeApc"></a><a id="rpcnotificationtypeapc"></a><a
    ///id="RPCNOTIFICATIONTYPEAPC"></a><dl> <dt><b>RpcNotificationTypeApc</b></dt> </dl> </td> <td width="60%"> The
    ///notification mechanism is a Windows asynchronous procedure call. </td> </tr> <tr> <td width="40%"><a
    ///id="RpcNotificationTypeIoc"></a><a id="rpcnotificationtypeioc"></a><a id="RPCNOTIFICATIONTYPEIOC"></a><dl>
    ///<dt><b>RpcNotificationTypeIoc</b></dt> </dl> </td> <td width="60%"> The notification mechanism is an I/O
    ///completion port. </td> </tr> <tr> <td width="40%"><a id="RpcNotificationTypeHwnd"></a><a
    ///id="rpcnotificationtypehwnd"></a><a id="RPCNOTIFICATIONTYPEHWND"></a><dl> <dt><b>RpcNotificationTypeHwnd</b></dt>
    ///</dl> </td> <td width="60%"> The notification mechanism is a Windows system message. <b>Windows Server 2003 or
    ///later: </b>Notification via the HWND is deprecated. Do not use this value. </td> </tr> <tr> <td width="40%"><a
    ///id="RpcNotificationTypeCallback"></a><a id="rpcnotificationtypecallback"></a><a
    ///id="RPCNOTIFICATIONTYPECALLBACK"></a><dl> <dt><b>RpcNotificationTypeCallback</b></dt> </dl> </td> <td
    ///width="60%"> The notification mechanism is a function callback. </td> </tr> </table>
    RPC_NOTIFICATION_TYPES NotificationType;
    ///Contains asynchronous notification information formatted for the mechanism type specified in
    ///<b>NotificationType</b>. <div class="alert"><b>Note</b> Previous to Windows Vista, this member contained the
    ///specific syntax of the union currently specified by the RPC_ASYNC_NOTIFICATION_INFO union.</div> <div> </div>
    RPC_ASYNC_NOTIFICATION_INFO u;
    ///Reserved for compatibility with future versions, if any. Do not use this member.
    ptrdiff_t[4]    Reserved;
}

struct BinaryParam
{
    void* Buffer;
    short Size;
}

///The <b>RPC_EE_INFO_PARAM</b> structure is used to store extended error information.
struct RPC_EE_INFO_PARAM
{
    ///Type of parameter being provided as extended error information. This value determines which union member(s) is
    ///used. Valid values are the following: <ul> <li><b>eeptAnsiString</b> to specify an ANSI string, indicating the
    ///value is provided in <b>AnsiString</b>.</li> <li><b>eeptUnicodeString</b> to specify a Unicode string, indicating
    ///the value is provided in <b>UnicodeString</b>.</li> <li><b>eeptLongVal</b> to specify a LONG value, indicating
    ///the value is provided in <b>LVal</b>.</li> <li><b>eeptShortVal</b> to specify a SHORT value, indicating the
    ///values is provided in <b>SVal</b>.</li> <li><b>eeptPointerVal</b> to specify a pointer value, indicating the
    ///values is provided in <b>PVal</b>.</li> <li><b>eeptBinary</b> is used by the RPC Runtime and should not be used
    ///or specified by applications.</li> <li><b>eeptNone</b> indicates the parameter contained either a Unicode or ANSI
    ///string, but was truncated due to lack of memory or network fragment length limitations.</li> </ul>
    ExtendedErrorParamTypes ParameterType;
    union u
    {
        const(char)*  AnsiString;
        const(wchar)* UnicodeString;
        int           LVal;
        short         SVal;
        ulong         PVal;
        BinaryParam   BVal;
    }
}

///The <b>RPC_EXTENDED_ERROR_INFO</b> structure is used to store extended error information.
struct RPC_EXTENDED_ERROR_INFO
{
    ///Version of the structure. Must be RPC_EEINFO_VERSION.
    uint                 Version;
    ///Non-qualified DNS name, expressed in Unicode.
    const(wchar)*        ComputerName;
    ///Process identifier for the offending error event.
    uint                 ProcessID;
    union u
    {
        SYSTEMTIME SystemTime;
        FILETIME   FileTime;
    }
    ///Code for the component that generated the error.
    uint                 GeneratingComponent;
    ///Status code for the error.
    uint                 Status;
    ///Code for the detection location. See Extended Error Information Detection Locations for valid locations.
    ushort               DetectionLocation;
    ///On input, specifies whether <b>SystemTime</b> or <b>FileTime</b> is used. Set to zero to use <b>SystemTime</b>,
    ///or EEInfoUseFileTime to use <b>FileTime</b>. On output, specifies whether records are missing. If a record is
    ///missing after the current record, <b>Flags</b> is set to EEInfoNextRecordsMissing. If a record is missing before
    ///the current record, <b>Flags</b> is set to EEInfoPreviousRecordsMissing.
    ushort               Flags;
    ///Number of parameters in the <b>Parameters</b> member.
    int                  NumberOfParameters;
    ///Array of RPC_EE_INFO_PARAM structures containing the extended error information.
    RPC_EE_INFO_PARAM[4] Parameters;
}

///The <b>RPC_ERROR_ENUM_HANDLE</b> structure provides an enumeration handle used by <b>RpcError</b>* functions for
///processing extended error information. All members of the <b>RPC_ERROR_ENUM_HANDLE</b> structure are used internally
///by the RPC Runtime, and should not be read or changed by applications. Applications should treat the
///<b>RPC_ERROR_ENUM_HANDLE</b> as an opaque value used as a handle.
struct RPC_ERROR_ENUM_HANDLE
{
    uint  Signature;
    void* CurrentPos;
    void* Head;
}

///The <b>RPC_CALL_LOCAL_ADDRESS_V1</b> structure contains information about the local address on which a call was made.
struct RPC_CALL_LOCAL_ADDRESS_V1
{
    ///Version of the <b>RPC_CALL_LOCAL_ADDRESS</b> structure. For this structure, this value must be set to 1.
    uint  Version;
    ///Pointer to a user-supplied opaque data block that contains the local address.
    void* Buffer;
    ///On input, this member contains the size of the buffer pointed to by the <b>Buffer</b> member, in bytes. On
    ///output, it contains the actual number of bytes written to buffer. For example, if the buffer is allocated a size
    ///of 8 bytes, but the local address written to it is 4, this parameter will specify 8 on input and contain 4 on
    ///output.
    uint  BufferSize;
    ///RpcLocalAddressFormat enumeration values that specifies the format of the local address written to <b>Buffer</b>.
    ///For this version of the structure, only IPv4 and IPv6 addresses are supported; if another is specified,
    ///RPC_S_CANNOT_SUPPORT is returned.
    RpcLocalAddressFormat AddressFormat;
}

///The <b>RPC_CALL_ATTRIBUTES_V1</b> structure provides parameters to the RpcServerInqCallAttributes function.
///Implemented in ANSI and UNICODE versions for Windows XP and Windows Server 2003 operating systems.
struct RPC_CALL_ATTRIBUTES_V1_W
{
    ///Version of the RpcServerInqCallAttributes function being used by the calling application. See Remarks.
    uint    Version;
    ///Bitmask specifying valid flags to request RPC_QUERY_SERVER_PRINCIPAL_NAME or RPC_QUERY_CLIENT_PRINCIPAL_NAME. See
    ///Remarks.
    uint    Flags;
    ///Length of <b>ServerPrincipalName</b>, in bytes. If insufficient, <b>ServerPrincipalName</b> is unchanged, and
    ///<b>ServerPrincipalNameBufferLength</b> indicates the required buffer length including the terminating <b>NULL</b>
    ///character, and ERROR_MORE_DATA is returned. If <b>ServerPrincipalNameBufferLength</b> is longer than necessary,
    ///upon return it is set to the actual length used, in bytes, including the terminating <b>NULL</b> character. See
    ///Remarks. If the protocol sequence does not support retrieving a server principal name,
    ///<b>ServerPrincipalNameBufferLength</b> is set to zero on return, and the buffer pointed by
    ///<b>ServerPrincipalName</b> is unmodified. <b>Windows XP: </b>Only the <b>ncacn_*</b> group of protocol sequences
    ///support retrieving the server principal name. If the RPC_QUERY_SERVER_PRINCIPAL_NAME flag is not specified,
    ///<b>ServerPrincipalNameBufferLength</b> is ignored. If <b>ServerPrincipalNameBufferLength</b> is nonzero and
    ///<b>ServerPrincipalName</b> is <b>NULL</b>, ERROR_INVALID_PARAMETER is returned.
    uint    ServerPrincipalNameBufferLength;
    ///Pointer to the server principal name, if requested in <b>Flags</b> and supported by the protocol sequence. Upon
    ///any return value other than RPC_S_OK or ERROR_MORE_DATA, the content of <b>ServerPrincipalName</b> is undefined
    ///and may have been modified by RPC.
    ushort* ServerPrincipalName;
    ///Length of the buffer pointed to by <b>ClientPrincipalName</b>, in bytes. If insufficient,
    ///<b>ClientPrincipalName</b> is unchanged, and <b>ClientPrincipalNameBufferLength</b> indicates the required buffer
    ///length including the terminating <b>NULL</b> character, and ERROR_MORE_DATA is returned. If
    ///<b>ClientPrincipalNameBufferLength</b> is longer than necessary, upon return it is set to the actual length used,
    ///in bytes, including the terminating <b>NULL</b> character. If the protocol sequence does not support retrieving a
    ///client principal name, <b>ClientPrincipalNameBufferLength</b> is set to zero on return, and the buffer pointed by
    ///<b>ClientPrincipalName</b> is unmodified. <b>Windows XP: </b>Only the <b>ncalrpc</b> protocol sequence supports
    ///retrieving the client principal name. If the RPC_QUERY_CLIENT_PRINCIPAL_NAME flag is not specified,
    ///<b>ClientPrincipalNameBufferLength</b> is ignored. If <b>ClientPrincipalNameBufferLength</b> is nonzero and
    ///<b>ClientPrincipalName</b> is <b>NULL</b>, ERROR_INVALID_PARAMETER is returned.
    uint    ClientPrincipalNameBufferLength;
    ///Pointer to the client principal name, if requested in <b>Flags</b> member and supported by the protocol sequence.
    ///Upon any return value other than RPC_S_OK or ERROR_MORE_DATA, the content of <b>ClientPrincipalName</b> is
    ///undefined and may have been modified by RPC.
    ushort* ClientPrincipalName;
    ///Authentication level for the call. See Authentication-Level Constants for authentication levels supported by RPC.
    uint    AuthenticationLevel;
    ///Authentication service, or security provider, used to make the remote procedure call.
    uint    AuthenticationService;
    ///Specifies whether a <b>Null</b> session is used. Zero indicates the call is not coming over a <b>Null</b>
    ///session; any other value indicates a <b>Null</b> session.
    BOOL    NullSession;
}

///The <b>RPC_CALL_ATTRIBUTES_V1</b> structure provides parameters to the RpcServerInqCallAttributes function.
///Implemented in ANSI and UNICODE versions for Windows XP and Windows Server 2003 operating systems.
struct RPC_CALL_ATTRIBUTES_V1_A
{
    ///Version of the RpcServerInqCallAttributes function being used by the calling application. See Remarks.
    uint   Version;
    ///Bitmask specifying valid flags to request RPC_QUERY_SERVER_PRINCIPAL_NAME or RPC_QUERY_CLIENT_PRINCIPAL_NAME. See
    ///Remarks.
    uint   Flags;
    ///Length of <b>ServerPrincipalName</b>, in bytes. If insufficient, <b>ServerPrincipalName</b> is unchanged, and
    ///<b>ServerPrincipalNameBufferLength</b> indicates the required buffer length including the terminating <b>NULL</b>
    ///character, and ERROR_MORE_DATA is returned. If <b>ServerPrincipalNameBufferLength</b> is longer than necessary,
    ///upon return it is set to the actual length used, in bytes, including the terminating <b>NULL</b> character. See
    ///Remarks. If the protocol sequence does not support retrieving a server principal name,
    ///<b>ServerPrincipalNameBufferLength</b> is set to zero on return, and the buffer pointed by
    ///<b>ServerPrincipalName</b> is unmodified. <b>Windows XP: </b>Only the <b>ncacn_*</b> group of protocol sequences
    ///support retrieving the server principal name. If the RPC_QUERY_SERVER_PRINCIPAL_NAME flag is not specified,
    ///<b>ServerPrincipalNameBufferLength</b> is ignored. If <b>ServerPrincipalNameBufferLength</b> is nonzero and
    ///<b>ServerPrincipalName</b> is <b>NULL</b>, ERROR_INVALID_PARAMETER is returned.
    uint   ServerPrincipalNameBufferLength;
    ///Pointer to the server principal name, if requested in <b>Flags</b> and supported by the protocol sequence. Upon
    ///any return value other than RPC_S_OK or ERROR_MORE_DATA, the content of <b>ServerPrincipalName</b> is undefined
    ///and may have been modified by RPC.
    ubyte* ServerPrincipalName;
    ///Length of the buffer pointed to by <b>ClientPrincipalName</b>, in bytes. If insufficient,
    ///<b>ClientPrincipalName</b> is unchanged, and <b>ClientPrincipalNameBufferLength</b> indicates the required buffer
    ///length including the terminating <b>NULL</b> character, and ERROR_MORE_DATA is returned. If
    ///<b>ClientPrincipalNameBufferLength</b> is longer than necessary, upon return it is set to the actual length used,
    ///in bytes, including the terminating <b>NULL</b> character. If the protocol sequence does not support retrieving a
    ///client principal name, <b>ClientPrincipalNameBufferLength</b> is set to zero on return, and the buffer pointed by
    ///<b>ClientPrincipalName</b> is unmodified. <b>Windows XP: </b>Only the <b>ncalrpc</b> protocol sequence supports
    ///retrieving the client principal name. If the RPC_QUERY_CLIENT_PRINCIPAL_NAME flag is not specified,
    ///<b>ClientPrincipalNameBufferLength</b> is ignored. If <b>ClientPrincipalNameBufferLength</b> is nonzero and
    ///<b>ClientPrincipalName</b> is <b>NULL</b>, ERROR_INVALID_PARAMETER is returned.
    uint   ClientPrincipalNameBufferLength;
    ///Pointer to the client principal name, if requested in <b>Flags</b> member and supported by the protocol sequence.
    ///Upon any return value other than RPC_S_OK or ERROR_MORE_DATA, the content of <b>ClientPrincipalName</b> is
    ///undefined and may have been modified by RPC.
    ubyte* ClientPrincipalName;
    ///Authentication level for the call. See Authentication-Level Constants for authentication levels supported by RPC.
    uint   AuthenticationLevel;
    ///Authentication service, or security provider, used to make the remote procedure call.
    uint   AuthenticationService;
    ///Specifies whether a <b>Null</b> session is used. Zero indicates the call is not coming over a <b>Null</b>
    ///session; any other value indicates a <b>Null</b> session.
    BOOL   NullSession;
}

///The <b>RPC_CALL_ATTRIBUTES_V2</b> structure provides parameters to the RpcServerInqCallAttributes function. Version 2
///specifies support for local addresses and client process IDs.
struct RPC_CALL_ATTRIBUTES_V2_W
{
    ///Version of the <b>RPC_CALL_ATTRIBUTES</b> structure. For this structure, this value must be set to 2.
    uint        Version;
    ///Bitmasked flags that indicate which members of this structure should be populated by the call to
    ///RpcServerInqCallAttributesto which this structure was passed. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="RPC_QUERY_SERVER_PRINCIPAL_NAME"></a><a id="rpc_query_server_principal_name"></a><dl>
    ///<dt><b>RPC_QUERY_SERVER_PRINCIPAL_NAME</b></dt> </dl> </td> <td width="60%"> Indicates that
    ///RpcServerInqCallAttributes should populate the <b>ServerPrincipalName</b> member of this structure. </td> </tr>
    ///<tr> <td width="40%"><a id="RPC_QUERY_CLIENT_PRINCIPAL_NAME"></a><a id="rpc_query_client_principal_name"></a><dl>
    ///<dt><b>RPC_QUERY_CLIENT_PRINCIPAL_NAME</b></dt> </dl> </td> <td width="60%"> Indicates that
    ///RpcServerInqCallAttributes should populate the <b>ClientPrincipalName</b> member of this structure. </td> </tr>
    ///<tr> <td width="40%"><a id="RPC_QUERY_CALL_LOCAL_ADDRESS"></a><a id="rpc_query_call_local_address"></a><dl>
    ///<dt><b>RPC_QUERY_CALL_LOCAL_ADDRESS</b></dt> </dl> </td> <td width="60%"> Indicates that
    ///RpcServerInqCallAttributes should populate the <b>CallLocalAddress</b> member of this structure. </td> </tr> <tr>
    ///<td width="40%"><a id="RPC_QUERY_CLIENT_PID"></a><a id="rpc_query_client_pid"></a><dl>
    ///<dt><b>RPC_QUERY_CLIENT_PID</b></dt> </dl> </td> <td width="60%"> Indicates that RpcServerInqCallAttributes
    ///should populate the <b>ClientPID</b> member of this structure. This flag is only supported for the ncalrpc
    ///protocol sequence. </td> </tr> </table>
    uint        Flags;
    ///Length of <b>ServerPrincipalName</b>, in bytes. If insufficient, <b>ServerPrincipalName</b> is unchanged, and
    ///<b>ServerPrincipalNameBufferLength</b> indicates the required buffer length including the terminating <b>NULL</b>
    ///character, and ERROR_MORE_DATA is returned. If <b>ServerPrincipalNameBufferLength</b> is longer than necessary,
    ///upon return it is set to the actual length used, in bytes, including the terminating <b>NULL</b> character. See
    ///Remarks. If the protocol sequence does not support retrieving a server principal name,
    ///<b>ServerPrincipalNameBufferLength</b> is set to zero on return, and the buffer pointed by
    ///<b>ServerPrincipalName</b> is unmodified. <b>Windows XP: </b>Only the <b>ncacn_*</b> group of protocol sequences
    ///support retrieving the server principal name. If the RPC_QUERY_SERVER_PRINCIPAL_NAME flag is not specified,
    ///<b>ServerPrincipalNameBufferLength</b> is ignored. If <b>ServerPrincipalNameBufferLength</b> is nonzero and
    ///<b>ServerPrincipalName</b> is <b>NULL</b>, ERROR_INVALID_PARAMETER is returned.
    uint        ServerPrincipalNameBufferLength;
    ///Pointer to the server principal name, if requested in <b>Flags</b> and supported by the protocol sequence. Upon
    ///any return value other than RPC_S_OK or ERROR_MORE_DATA, the content of <b>ServerPrincipalName</b> is undefined
    ///and may have been modified by RPC.
    ushort*     ServerPrincipalName;
    ///Length of the buffer pointed to by <b>ClientPrincipalName</b>, in bytes. If insufficient,
    ///<b>ClientPrincipalName</b> is unchanged, and <b>ClientPrincipalNameBufferLength</b> indicates the required buffer
    ///length including the terminating <b>NULL</b> character, and ERROR_MORE_DATA is returned. If
    ///<b>ClientPrincipalNameBufferLength</b> is longer than necessary, upon return it is set to the actual length used,
    ///in bytes, including the terminating <b>NULL</b> character. If the protocol sequence does not support retrieving a
    ///client principal name, <b>ClientPrincipalNameBufferLength</b> is set to zero on return, and the buffer pointed by
    ///<b>ClientPrincipalName</b> is unmodified. <b>Windows XP: </b>Only the <b>ncalrpc</b> protocol sequence supports
    ///retrieving the client principal name. If the RPC_QUERY_CLIENT_PRINCIPAL_NAME flag is not specified,
    ///<b>ClientPrincipalNameBufferLength</b> is ignored. If <b>ClientPrincipalNameBufferLength</b> is nonzero and
    ///<b>ClientPrincipalName</b> is <b>NULL</b>, ERROR_INVALID_PARAMETER is returned.
    uint        ClientPrincipalNameBufferLength;
    ///Pointer to the client principal name, if requested in <b>Flags</b> member and supported by the protocol sequence.
    ///Upon any return value other than RPC_S_OK or ERROR_MORE_DATA, the content of <b>ClientPrincipalName</b> is
    ///undefined and may have been modified by RPC.
    ushort*     ClientPrincipalName;
    ///Authentication level for the call. See Authentication-Level Constants for authentication levels supported by RPC.
    uint        AuthenticationLevel;
    ///Authentication service, or security provider, used to make the remote procedure call.
    uint        AuthenticationService;
    ///Specifies whether a <b>Null</b> session is used. Zero indicates the call is not coming over a <b>Null</b>
    ///session; any other value indicates a <b>Null</b> session.
    BOOL        NullSession;
    BOOL        KernelModeCaller;
    ///Constant that indicates the protocol sequence over which the call was made.
    uint        ProtocolSequence;
    ///RpcCallClientLocality enumeration value that indicates the locality of the client (local, remote, or unknown).
    RpcCallClientLocality IsClientLocal;
    ///Handle that contains the process ID of the calling client. This field is only supported for the ncalrpc protocol
    ///sequence, and is populated only when <b>RPC_QUERY_CLIENT_PID</b> is specified in the <i>Flags</i> parameter.
    HANDLE      ClientPID;
    ///Bit field that specifies the status of the RPC call. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="RPC_CALL_STATUS_IN_PROGRESS"></a><a id="rpc_call_status_in_progress"></a><dl>
    ///<dt><b>RPC_CALL_STATUS_IN_PROGRESS</b></dt> <dt>0x01</dt> </dl> </td> <td width="60%"> The call is in progress.
    ///</td> </tr> <tr> <td width="40%"><a id="RPC_CALL_STATUS_CANCELLED"></a><a id="rpc_call_status_cancelled"></a><dl>
    ///<dt><b>RPC_CALL_STATUS_CANCELLED</b></dt> <dt>0x02</dt> </dl> </td> <td width="60%"> The call was canceled. </td>
    ///</tr> <tr> <td width="40%"><a id="RPC_CALL_STATUS_DISCONNECTED"></a><a id="rpc_call_status_disconnected"></a><dl>
    ///<dt><b>RPC_CALL_STATUS_DISCONNECTED</b></dt> <dt>0x03</dt> </dl> </td> <td width="60%"> The client has
    ///disconnected. </td> </tr> </table>
    uint        CallStatus;
    ///RpcCallType enumeration value that indicates the type of the RPC call.
    RpcCallType CallType;
    ///Pointer to a RPC_CALL_LOCAL_ADDRESS structure that contains information to the server about the local address on
    ///which the call was made. This field must not be <b>NULL</b> if <b>RPC_QUERY_CALL_LOCAL_ADDRESS</b> is specified
    ///in <i>Flags</i>; otherwise, RPC_S_INVALID_ARG is returned. If the buffer supplied by the application is
    ///insufficient, RpcServerInqCallAttributes returns ERROR_MORE_DATA.
    RPC_CALL_LOCAL_ADDRESS_V1* CallLocalAddress;
    ///The opnum value associated with the call in the corresponding IDL file.
    ushort      OpNum;
    ///The interface UUID on which the call is made.
    GUID        InterfaceUuid;
}

///The <b>RPC_CALL_ATTRIBUTES_V2</b> structure provides parameters to the RpcServerInqCallAttributes function. Version 2
///specifies support for local addresses and client process IDs.
struct RPC_CALL_ATTRIBUTES_V2_A
{
    ///Version of the <b>RPC_CALL_ATTRIBUTES</b> structure. For this structure, this value must be set to 2.
    uint        Version;
    ///Bitmasked flags that indicate which members of this structure should be populated by the call to
    ///RpcServerInqCallAttributesto which this structure was passed. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="RPC_QUERY_SERVER_PRINCIPAL_NAME"></a><a id="rpc_query_server_principal_name"></a><dl>
    ///<dt><b>RPC_QUERY_SERVER_PRINCIPAL_NAME</b></dt> </dl> </td> <td width="60%"> Indicates that
    ///RpcServerInqCallAttributes should populate the <b>ServerPrincipalName</b> member of this structure. </td> </tr>
    ///<tr> <td width="40%"><a id="RPC_QUERY_CLIENT_PRINCIPAL_NAME"></a><a id="rpc_query_client_principal_name"></a><dl>
    ///<dt><b>RPC_QUERY_CLIENT_PRINCIPAL_NAME</b></dt> </dl> </td> <td width="60%"> Indicates that
    ///RpcServerInqCallAttributes should populate the <b>ClientPrincipalName</b> member of this structure. </td> </tr>
    ///<tr> <td width="40%"><a id="RPC_QUERY_CALL_LOCAL_ADDRESS"></a><a id="rpc_query_call_local_address"></a><dl>
    ///<dt><b>RPC_QUERY_CALL_LOCAL_ADDRESS</b></dt> </dl> </td> <td width="60%"> Indicates that
    ///RpcServerInqCallAttributes should populate the <b>CallLocalAddress</b> member of this structure. </td> </tr> <tr>
    ///<td width="40%"><a id="RPC_QUERY_CLIENT_PID"></a><a id="rpc_query_client_pid"></a><dl>
    ///<dt><b>RPC_QUERY_CLIENT_PID</b></dt> </dl> </td> <td width="60%"> Indicates that RpcServerInqCallAttributes
    ///should populate the <b>ClientPID</b> member of this structure. This flag is only supported for the ncalrpc
    ///protocol sequence. </td> </tr> </table>
    uint        Flags;
    ///Length of <b>ServerPrincipalName</b>, in bytes. If insufficient, <b>ServerPrincipalName</b> is unchanged, and
    ///<b>ServerPrincipalNameBufferLength</b> indicates the required buffer length including the terminating <b>NULL</b>
    ///character, and ERROR_MORE_DATA is returned. If <b>ServerPrincipalNameBufferLength</b> is longer than necessary,
    ///upon return it is set to the actual length used, in bytes, including the terminating <b>NULL</b> character. See
    ///Remarks. If the protocol sequence does not support retrieving a server principal name,
    ///<b>ServerPrincipalNameBufferLength</b> is set to zero on return, and the buffer pointed by
    ///<b>ServerPrincipalName</b> is unmodified. <b>Windows XP: </b>Only the <b>ncacn_*</b> group of protocol sequences
    ///support retrieving the server principal name. If the RPC_QUERY_SERVER_PRINCIPAL_NAME flag is not specified,
    ///<b>ServerPrincipalNameBufferLength</b> is ignored. If <b>ServerPrincipalNameBufferLength</b> is nonzero and
    ///<b>ServerPrincipalName</b> is <b>NULL</b>, ERROR_INVALID_PARAMETER is returned.
    uint        ServerPrincipalNameBufferLength;
    ///Pointer to the server principal name, if requested in <b>Flags</b> and supported by the protocol sequence. Upon
    ///any return value other than RPC_S_OK or ERROR_MORE_DATA, the content of <b>ServerPrincipalName</b> is undefined
    ///and may have been modified by RPC.
    ubyte*      ServerPrincipalName;
    ///Length of the buffer pointed to by <b>ClientPrincipalName</b>, in bytes. If insufficient,
    ///<b>ClientPrincipalName</b> is unchanged, and <b>ClientPrincipalNameBufferLength</b> indicates the required buffer
    ///length including the terminating <b>NULL</b> character, and ERROR_MORE_DATA is returned. If
    ///<b>ClientPrincipalNameBufferLength</b> is longer than necessary, upon return it is set to the actual length used,
    ///in bytes, including the terminating <b>NULL</b> character. If the protocol sequence does not support retrieving a
    ///client principal name, <b>ClientPrincipalNameBufferLength</b> is set to zero on return, and the buffer pointed by
    ///<b>ClientPrincipalName</b> is unmodified. <b>Windows XP: </b>Only the <b>ncalrpc</b> protocol sequence supports
    ///retrieving the client principal name. If the RPC_QUERY_CLIENT_PRINCIPAL_NAME flag is not specified,
    ///<b>ClientPrincipalNameBufferLength</b> is ignored. If <b>ClientPrincipalNameBufferLength</b> is nonzero and
    ///<b>ClientPrincipalName</b> is <b>NULL</b>, ERROR_INVALID_PARAMETER is returned.
    uint        ClientPrincipalNameBufferLength;
    ///Pointer to the client principal name, if requested in <b>Flags</b> member and supported by the protocol sequence.
    ///Upon any return value other than RPC_S_OK or ERROR_MORE_DATA, the content of <b>ClientPrincipalName</b> is
    ///undefined and may have been modified by RPC.
    ubyte*      ClientPrincipalName;
    ///Authentication level for the call. See Authentication-Level Constants for authentication levels supported by RPC.
    uint        AuthenticationLevel;
    ///Authentication service, or security provider, used to make the remote procedure call.
    uint        AuthenticationService;
    ///Specifies whether a <b>Null</b> session is used. Zero indicates the call is not coming over a <b>Null</b>
    ///session; any other value indicates a <b>Null</b> session.
    BOOL        NullSession;
    BOOL        KernelModeCaller;
    ///Constant that indicates the protocol sequence over which the call was made.
    uint        ProtocolSequence;
    ///RpcCallClientLocality enumeration value that indicates the locality of the client (local, remote, or unknown).
    uint        IsClientLocal;
    ///Handle that contains the process ID of the calling client. This field is only supported for the ncalrpc protocol
    ///sequence, and is populated only when <b>RPC_QUERY_CLIENT_PID</b> is specified in the <i>Flags</i> parameter.
    HANDLE      ClientPID;
    ///Bit field that specifies the status of the RPC call. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="RPC_CALL_STATUS_IN_PROGRESS"></a><a id="rpc_call_status_in_progress"></a><dl>
    ///<dt><b>RPC_CALL_STATUS_IN_PROGRESS</b></dt> <dt>0x01</dt> </dl> </td> <td width="60%"> The call is in progress.
    ///</td> </tr> <tr> <td width="40%"><a id="RPC_CALL_STATUS_CANCELLED"></a><a id="rpc_call_status_cancelled"></a><dl>
    ///<dt><b>RPC_CALL_STATUS_CANCELLED</b></dt> <dt>0x02</dt> </dl> </td> <td width="60%"> The call was canceled. </td>
    ///</tr> <tr> <td width="40%"><a id="RPC_CALL_STATUS_DISCONNECTED"></a><a id="rpc_call_status_disconnected"></a><dl>
    ///<dt><b>RPC_CALL_STATUS_DISCONNECTED</b></dt> <dt>0x03</dt> </dl> </td> <td width="60%"> The client has
    ///disconnected. </td> </tr> </table>
    uint        CallStatus;
    ///RpcCallType enumeration value that indicates the type of the RPC call.
    RpcCallType CallType;
    ///Pointer to a RPC_CALL_LOCAL_ADDRESS structure that contains information to the server about the local address on
    ///which the call was made. This field must not be <b>NULL</b> if <b>RPC_QUERY_CALL_LOCAL_ADDRESS</b> is specified
    ///in <i>Flags</i>; otherwise, RPC_S_INVALID_ARG is returned. If the buffer supplied by the application is
    ///insufficient, RpcServerInqCallAttributes returns ERROR_MORE_DATA.
    RPC_CALL_LOCAL_ADDRESS_V1* CallLocalAddress;
    ///The opnum value associated with the call in the corresponding IDL file.
    ushort      OpNum;
    ///The interface UUID on which the call is made.
    GUID        InterfaceUuid;
}

struct RPC_CALL_ATTRIBUTES_V3_W
{
    uint        Version;
    uint        Flags;
    uint        ServerPrincipalNameBufferLength;
    ushort*     ServerPrincipalName;
    uint        ClientPrincipalNameBufferLength;
    ushort*     ClientPrincipalName;
    uint        AuthenticationLevel;
    uint        AuthenticationService;
    BOOL        NullSession;
    BOOL        KernelModeCaller;
    uint        ProtocolSequence;
    RpcCallClientLocality IsClientLocal;
    HANDLE      ClientPID;
    uint        CallStatus;
    RpcCallType CallType;
    RPC_CALL_LOCAL_ADDRESS_V1* CallLocalAddress;
    ushort      OpNum;
    GUID        InterfaceUuid;
    uint        ClientIdentifierBufferLength;
    ubyte*      ClientIdentifier;
}

struct RPC_CALL_ATTRIBUTES_V3_A
{
    uint        Version;
    uint        Flags;
    uint        ServerPrincipalNameBufferLength;
    ubyte*      ServerPrincipalName;
    uint        ClientPrincipalNameBufferLength;
    ubyte*      ClientPrincipalName;
    uint        AuthenticationLevel;
    uint        AuthenticationService;
    BOOL        NullSession;
    BOOL        KernelModeCaller;
    uint        ProtocolSequence;
    uint        IsClientLocal;
    HANDLE      ClientPID;
    uint        CallStatus;
    RpcCallType CallType;
    RPC_CALL_LOCAL_ADDRESS_V1* CallLocalAddress;
    ushort      OpNum;
    GUID        InterfaceUuid;
    uint        ClientIdentifierBufferLength;
    ubyte*      ClientIdentifier;
}

struct __AnonymousRecord_rpcndr_L275_C9
{
    void[2]* pad;
    void*    userContext;
}

struct SCONTEXT_QUEUE
{
    uint             NumberOfObjects;
    NDR_SCONTEXT_1** ArrayOfObjects;
}

struct ARRAY_INFO
{
    int   Dimension;
    uint* BufferConformanceMark;
    uint* BufferVarianceMark;
    uint* MaxCountArray;
    uint* OffsetArray;
    uint* ActualCountArray;
}

struct _NDR_ASYNC_MESSAGE
{
}

struct _NDR_CORRELATION_INFO
{
}

struct NDR_ALLOC_ALL_NODES_CONTEXT
{
}

struct NDR_POINTER_QUEUE_STATE
{
}

struct _NDR_PROC_CONTEXT
{
}

///The <b>MIDL_STUB_MESSAGE</b> structure is generated by MIDL and contains the current status of the RPC stub.
///Applications are not to modify the <b>MIDL_STUB_MESSAGE</b> structure directly.
struct MIDL_STUB_MESSAGE
{
    ///Pointer to the RPC_MESSAGE structure.
    RPC_MESSAGE*        RpcMsg;
    ///Pointer that points to a location within the network buffer where the data is marshaled or unmarshaled.
    ubyte*              Buffer;
    ///Pointer to the beginning of the network buffer.
    ubyte*              BufferStart;
    ///Pointer to the end of the network buffer.
    ubyte*              BufferEnd;
    ///Reserved.
    ubyte*              BufferMark;
    ///Size, in bytes, of <b>Buffer</b>.
    uint                BufferLength;
    ///Reserved.
    uint                MemorySize;
    ///Reserved.
    ubyte*              Memory;
    ///Reserved.
    ubyte               IsClient;
    ubyte               Pad;
    ushort              uFlags2;
    ///Reserved.
    int                 ReuseBuffer;
    ///Reserved.
    NDR_ALLOC_ALL_NODES_CONTEXT* pAllocAllNodesContext;
    ///Reserved.
    NDR_POINTER_QUEUE_STATE* pPointerQueueState;
    ///Reserved.
    int                 IgnoreEmbeddedPointers;
    ///Reserved.
    ubyte*              PointerBufferMark;
    ubyte               CorrDespIncrement;
    ///Reserved.
    ubyte               uFlags;
    ushort              UniquePtrCount;
    ///Reserved.
    size_t              MaxCount;
    ///Reserved.
    uint                Offset;
    ///Reserved.
    uint                ActualCount;
    ///Reserved.
    ptrdiff_t           pfnAllocate;
    ///Reserved.
    ptrdiff_t           pfnFree;
    ///Reserved.
    ubyte*              StackTop;
    ///Reserved.
    ubyte*              pPresentedType;
    ///Reserved.
    ubyte*              pTransmitType;
    ///Reserved.
    void*               SavedHandle;
    ///Reserved.
    const(MIDL_STUB_DESC)* StubDesc;
    ///Reserved.
    FULL_PTR_XLAT_TABLES* FullPtrXlatTables;
    ///Reserved.
    uint                FullPtrRefId;
    ///Reserved.
    uint                PointerLength;
    int                 _bitfield98;
    ///Reserved.
    uint                dwDestContext;
    ///Reserved.
    void*               pvDestContext;
    ///Reserved.
    NDR_SCONTEXT_1**    SavedContextHandles;
    ///Reserved.
    int                 ParamNumber;
    ///Reserved.
    IRpcChannelBuffer   pRpcChannelBuffer;
    ///Reserved.
    ARRAY_INFO*         pArrayInfo;
    ///Reserved.
    uint*               SizePtrCountArray;
    ///Reserved.
    uint*               SizePtrOffsetArray;
    ///Reserved.
    uint*               SizePtrLengthArray;
    ///Reserved.
    void*               pArgQueue;
    ///Pointer to a flag that tracks the current interpreter call's activity.
    uint                dwStubPhase;
    ///Reserved.
    void*               LowStackMark;
    ///Reserved.
    _NDR_ASYNC_MESSAGE* pAsyncMsg;
    ///Reserved.
    _NDR_CORRELATION_INFO* pCorrInfo;
    ///Reserved.
    ubyte*              pCorrMemory;
    ///Reserved.
    void*               pMemoryList;
    ///Reserved.
    ptrdiff_t           pCSInfo;
    ///Reserved.
    ubyte*              ConformanceMark;
    ///Reserved.
    ubyte*              VarianceMark;
    ///Reserved.
    ptrdiff_t           Unused;
    ///Reserved.
    _NDR_PROC_CONTEXT*  pContext;
    void*               ContextHandleHash;
    void*               pUserMarshalList;
    ///Reserved.
    ptrdiff_t           Reserved51_3;
    ///Reserved.
    ptrdiff_t           Reserved51_4;
    ///Reserved.
    ptrdiff_t           Reserved51_5;
}

struct GENERIC_BINDING_ROUTINE_PAIR
{
    GENERIC_BINDING_ROUTINE pfnBind;
    GENERIC_UNBIND_ROUTINE pfnUnbind;
}

struct __GENERIC_BINDING_INFO
{
    void* pObj;
    uint  Size;
    GENERIC_BINDING_ROUTINE pfnBind;
    GENERIC_UNBIND_ROUTINE pfnUnbind;
}

struct XMIT_ROUTINE_QUINTUPLE
{
    XMIT_HELPER_ROUTINE pfnTranslateToXmit;
    XMIT_HELPER_ROUTINE pfnTranslateFromXmit;
    XMIT_HELPER_ROUTINE pfnFreeXmit;
    XMIT_HELPER_ROUTINE pfnFreeInst;
}

struct USER_MARSHAL_ROUTINE_QUADRUPLE
{
    USER_MARSHAL_SIZING_ROUTINE pfnBufferSize;
    USER_MARSHAL_MARSHALLING_ROUTINE pfnMarshall;
    USER_MARSHAL_UNMARSHALLING_ROUTINE pfnUnmarshall;
    USER_MARSHAL_FREEING_ROUTINE pfnFree;
}

struct USER_MARSHAL_CB
{
    uint                 Flags;
    MIDL_STUB_MESSAGE*   pStubMsg;
    ubyte*               pReserve;
    uint                 Signature;
    USER_MARSHAL_CB_TYPE CBType;
    ubyte*               pFormat;
    ubyte*               pTypeFormat;
}

struct MALLOC_FREE_STRUCT
{
    ptrdiff_t pfnAllocate;
    ptrdiff_t pfnFree;
}

struct COMM_FAULT_OFFSETS
{
    short CommOffset;
    short FaultOffset;
}

struct NDR_CS_SIZE_CONVERT_ROUTINES
{
    CS_TYPE_NET_SIZE_ROUTINE pfnNetSize;
    CS_TYPE_TO_NETCS_ROUTINE pfnToNetCs;
    CS_TYPE_LOCAL_SIZE_ROUTINE pfnLocalSize;
    CS_TYPE_FROM_NETCS_ROUTINE pfnFromNetCs;
}

struct NDR_CS_ROUTINES
{
    NDR_CS_SIZE_CONVERT_ROUTINES* pSizeConvertRoutines;
    CS_TAG_GETTING_ROUTINE* pTagGettingRoutines;
}

struct NDR_EXPR_DESC
{
    const(ushort)* pOffset;
    ubyte*         pFormatExpr;
}

///The <b>MIDL_STUB_DESC</b> structure is a MIDL-generated structure that contains information about the interface stub
///regarding RPC calls between the client and server.
struct MIDL_STUB_DESC
{
    ///For a nonobject RPC interface on the server-side, it points to an RPC server interface structure. On the
    ///client-side, it points to an RPC client interface structure. It is null for an object interface.
    void*               RpcInterfaceInformation;
    ///Memory allocation function to be used by the stub. Set to midl_user_allocate for nonobject interface and
    ///NdrOleAllocate for object interface.
    ptrdiff_t           pfnAllocate;
    ///Memory-free function to be used by the stub. Set to midl_user_free for nonobject interface and NdrOleFree for
    ///object interface.
    ptrdiff_t           pfnFree;
    union IMPLICIT_HANDLE_INFO
    {
        void** pAutoHandle;
        void** pPrimitiveHandle;
        __GENERIC_BINDING_INFO* pGenericBindingInfo;
    }
    ///Array of context handle rundown functions.
    const(ptrdiff_t)*   apfnNdrRundownRoutines;
    ///Array of function pointers to bind and unbind function pairs for the implicit generic handle.
    const(GENERIC_BINDING_ROUTINE_PAIR)* aGenericBindingRoutinePairs;
    ///Array of function pointers to expression evaluator functions used to evaluate MIDL complex conformance and
    ///varying descriptions. For example, size_is(param1 + param2).
    const(ptrdiff_t)*   apfnExprEval;
    ///Array of an array of function pointers for user-defined transmit_as and represent_as types.
    const(XMIT_ROUTINE_QUINTUPLE)* aXmitQuintuple;
    ///Pointer to the type format description.
    const(ubyte)*       pFormatTypes;
    ///Flag describing the user-specified /error MIDL compiler option.
    int                 fCheckBounds;
    ///NDR version required for the stub.
    uint                Version;
    ///Pointer to the MALLOC_FREE_STRUCT structure which contains the allocate and free function pointers. Use if the
    ///enable_allocate MIDL attribute is specified.
    MALLOC_FREE_STRUCT* pMallocFreeStruct;
    ///Version of the MIDL compiler used to compile the .idl file.
    int                 MIDLVersion;
    ///Array of stack offsets for parameters with comm_status or fault_status attributes.
    const(COMM_FAULT_OFFSETS)* CommFaultOffsets;
    ///Array of an array of function pointers for user-defined user_marshal and wire_marshal types.
    const(USER_MARSHAL_ROUTINE_QUADRUPLE)* aUserMarshalQuadruple;
    ///Array of notification function pointers for methods with the notify or notify_flag attribute specified.
    const(ptrdiff_t)*   NotifyRoutineTable;
    ///Flag describing the attributes of the stub <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="RPCFLG_HAS_MULTI_SYNTAXES"></a><a id="rpcflg_has_multi_syntaxes"></a><dl>
    ///<dt><b>RPCFLG_HAS_MULTI_SYNTAXES</b></dt> </dl> </td> <td width="60%"> Set if the stub supports multiple transfer
    ///syntaxes. </td> </tr> <tr> <td width="40%"><a id="RPCFLG_HAS_CALLBACK"></a><a id="rpcflg_has_callback"></a><dl>
    ///<dt><b>RPCFLG_HAS_CALLBACK</b></dt> </dl> </td> <td width="60%"> Set if the interface contains callback
    ///functions. </td> </tr> <tr> <td width="40%"><a id="RPC_INTERFACE_HAS_PIPES"></a><a
    ///id="rpc_interface_has_pipes"></a><dl> <dt><b>RPC_INTERFACE_HAS_PIPES</b></dt> </dl> </td> <td width="60%"> Set if
    ///the interface contains a method that uses pipes. </td> </tr> </table>
    size_t              mFlags;
    ///Unused.
    const(NDR_CS_ROUTINES)* CsRoutineTables;
    void*               ProxyServerInfo;
    const(NDR_EXPR_DESC)* pExprInfo;
}

struct MIDL_FORMAT_STRING
{
    short Pad;
    ubyte Format;
}

struct MIDL_METHOD_PROPERTY
{
    uint   Id;
    size_t Value;
}

struct MIDL_METHOD_PROPERTY_MAP
{
    uint Count;
    const(MIDL_METHOD_PROPERTY)* Properties;
}

struct MIDL_INTERFACE_METHOD_PROPERTIES
{
    ushort MethodCount;
    const(MIDL_METHOD_PROPERTY_MAP)** MethodProperties;
}

struct _MIDL_SERVER_INFO_
{
    MIDL_STUB_DESC*   pStubDesc;
    const(ptrdiff_t)* DispatchTable;
    ubyte*            ProcString;
    const(ushort)*    FmtStringOffset;
    const(ptrdiff_t)* ThunkTable;
    RPC_SYNTAX_IDENTIFIER* pTransferSyntax;
    size_t            nCount;
    MIDL_SYNTAX_INFO* pSyntaxInfo;
}

struct MIDL_STUBLESS_PROXY_INFO
{
    MIDL_STUB_DESC*   pStubDesc;
    ubyte*            ProcFormatString;
    const(ushort)*    FormatStringOffset;
    RPC_SYNTAX_IDENTIFIER* pTransferSyntax;
    size_t            nCount;
    MIDL_SYNTAX_INFO* pSyntaxInfo;
}

struct MIDL_SYNTAX_INFO
{
    RPC_SYNTAX_IDENTIFIER TransferSyntax;
    RPC_DISPATCH_TABLE* DispatchTable;
    ubyte*              ProcString;
    const(ushort)*      FmtStringOffset;
    ubyte*              TypeString;
    const(void)*        aUserMarshalQuadruple;
    const(MIDL_INTERFACE_METHOD_PROPERTIES)* pMethodProperties;
    size_t              pReserved2;
}

union CLIENT_CALL_RETURN
{
    void*     Pointer;
    ptrdiff_t Simple;
}

struct FULL_PTR_XLAT_TABLES
{
    void*     RefIdToPointer;
    void*     PointerToRefId;
    uint      NextRefId;
    XLAT_SIDE XlatSide;
}

struct MIDL_INTERCEPTION_INFO
{
    uint           Version;
    ubyte*         ProcString;
    const(ushort)* ProcFormatOffsetTable;
    uint           ProcCount;
    ubyte*         TypeString;
}

struct MIDL_WINRT_TYPE_SERIALIZATION_INFO
{
    uint            Version;
    ubyte*          TypeFormatString;
    ushort          FormatStringSize;
    ushort          TypeOffset;
    MIDL_STUB_DESC* StubDesc;
}

///The <b>NDR_USER_MARSHAL_INFO_LEVEL1</b> structure holds information about the state of an RPC call that can be passed
///to wire_marshal and user_marshal helper functions.
struct NDR_USER_MARSHAL_INFO_LEVEL1
{
    ///Pointer to the beginning of the marshaling buffer available for use by the helper function. If no buffer is
    ///available, this field is null.
    void*             Buffer;
    ///Size, in bytes, of the marshaling buffer available for use by the helper function. If no buffer is available,
    ///<i>BufferSize</i> is zero.
    uint              BufferSize;
    ///Function used by RPC to allocate memory for the application. An example of the use of this function is to create
    ///a node.
    ptrdiff_t         pfnAllocate;
    ///Function used by RPC to free memory for the application. An example of the use of this function is to free a
    ///node.
    ptrdiff_t         pfnFree;
    ///If the current call is for a COM interface, this member is a pointer to the channel buffer that RPC uses for the
    ///call. Otherwise, this member is null.
    IRpcChannelBuffer pRpcChannelBuffer;
    size_t[5]         Reserved;
}

///The <b>NDR_USER_MARSHAL_INFO</b> structure holds information about the state of an RPC call that can be passed to
///wire_marshal and user_marshal helper functions.
struct NDR_USER_MARSHAL_INFO
{
    ///The information level of the returned data. Currently only a value of 1 is defined.
    uint InformationLevel;
    union
    {
        NDR_USER_MARSHAL_INFO_LEVEL1 Level1;
    }
}

struct MIDL_TYPE_PICKLING_INFO
{
    uint      Version;
    uint      Flags;
    size_t[3] Reserved;
}

// Functions

///<p class="CCE_Message">[IUnknown_QueryInterface_Proxy is not supported and may be altered or unavailable in the
///future.] The <b>IUnknown_QueryInterface_Proxy</b> function implements the QueryInterface method for all interface
///proxies.
///Params:
///    This = Pointer to the proxy object.
///    riid = IID of the interface to be queried.
///    ppvObject = Address to a pointer whose interface is queried or null when an interface is not supported.
///Returns:
///    Returns S_OK on success.
///    
@DllImport("RPCRT4")
HRESULT IUnknown_QueryInterface_Proxy(IUnknown This, const(GUID)* riid, void** ppvObject);

///<p class="CCE_Message">[IUnknown_AddRef_Proxy is not supported and may be altered or unavailable in the future.] The
///<b>IUnknown_AddRef_Proxy</b> function implements the AddRef method for all interface proxies.
///Params:
///    This = Pointer to the proxy object.
///Returns:
///    Returns an integer from 1 to <i>n</i>, indicating the value of the new reference count.
///    
@DllImport("RPCRT4")
uint IUnknown_AddRef_Proxy(IUnknown This);

///<p class="CCE_Message">[IUnknown_Release_Proxy is not supported and may be altered or unavailable in the future.] The
///IUnknown_Release_Proxy function implements the Release method for all interface proxies.
///Params:
///    This = Pointer to the proxy object.
///Returns:
///    Returns an integer from 1 to <i>n</i>, indicating the value of the new reference count.
///    
@DllImport("RPCRT4")
uint IUnknown_Release_Proxy(IUnknown This);

///The <b>RpcBindingCopy</b> function copies binding information and creates a new binding handle.
///Params:
///    SourceBinding = Server binding handle whose referenced binding information is copied.
///    DestinationBinding = Returns a pointer to the server binding handle that refers to the copied binding information.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid
///    error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingCopy(void* SourceBinding, void** DestinationBinding);

///The <b>RpcBindingFree</b> function releases binding-handle resources.
///Params:
///    Binding = Pointer to the server binding to be freed.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid
///    error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingFree(void** Binding);

///The <b>RpcBindingSetOption</b> function enables client applications to specify message-queuing options on a binding
///handle.
///Params:
///    hBinding = Server binding to modify.
///    option = Binding property to modify. For a list of binding options and their possible values, see Binding Option
///             Constants. See Remarks for information on the RPC Call time-out feature.
///    optionValue = New value for the binding property. See Remarks.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_CANNOT_SUPPORT</b></dt> </dl> </td> <td width="60%"> The function is not supported for either the
///    operating system or the transport. Note that calling <b>RpcBindingSetOption</b> on binding handles that use any
///    protocol sequence other than <b>ncacn_*</b> will fail and return this value. </td> </tr> </table> <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingSetOption(void* hBinding, uint option, size_t optionValue);

///RPC client processes use <b>RpcBindingInqOption</b> to determine current values of the binding options for a given
///binding handle.
///Params:
///    hBinding = Server binding about which to determine binding-option values.
///    option = Binding handle property to inquire about.
///    pOptionValue = Memory location to place the value for the specified <i>Option</i> <div class="alert"><b>Note</b> For a list of
///                   binding options and their possible values, see Binding Option Constants.</div> <div> </div>
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_CANNOT_SUPPORT</b></dt> </dl> </td> <td width="60%"> The function is not supported for either the
///    operating system or the transport. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error
///    codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingInqOption(void* hBinding, uint option, size_t* pOptionValue);

///The <b>RpcBindingFromStringBinding</b> function returns a binding handle from a string representation of a binding
///handle.
///Params:
///    StringBinding = Pointer to a string representation of a binding handle.
///    Binding = Returns a pointer to the server binding handle.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_STRING_BINDING</b></dt> </dl> </td> <td width="60%"> The string binding is not valid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%">
///    Protocol sequence not supported on this host. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_RPC_PROTSEQ</b></dt> </dl> </td> <td width="60%"> The protocol sequence is not valid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_ENDPOINT_FORMAT</b></dt> </dl> </td> <td width="60%"> The
///    endpoint format is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_STRING_TOO_LONG</b></dt> </dl>
///    </td> <td width="60%"> String too long. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NET_ADDR</b></dt> </dl> </td> <td width="60%"> The network address is not valid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> The argument was not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_NAF_ID</b></dt> </dl> </td> <td width="60%">
///    The network address family identifier is not valid. </td> </tr> </table> <div class="alert"><b>Note</b> For a
///    list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingFromStringBindingA(ubyte* StringBinding, void** Binding);

///The <b>RpcBindingFromStringBinding</b> function returns a binding handle from a string representation of a binding
///handle.
///Params:
///    StringBinding = Pointer to a string representation of a binding handle.
///    Binding = Returns a pointer to the server binding handle.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_STRING_BINDING</b></dt> </dl> </td> <td width="60%"> The string binding is not valid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%">
///    Protocol sequence not supported on this host. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_RPC_PROTSEQ</b></dt> </dl> </td> <td width="60%"> The protocol sequence is not valid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_ENDPOINT_FORMAT</b></dt> </dl> </td> <td width="60%"> The
///    endpoint format is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_STRING_TOO_LONG</b></dt> </dl>
///    </td> <td width="60%"> String too long. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NET_ADDR</b></dt> </dl> </td> <td width="60%"> The network address is not valid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> The argument was not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_NAF_ID</b></dt> </dl> </td> <td width="60%">
///    The network address family identifier is not valid. </td> </tr> </table> <div class="alert"><b>Note</b> For a
///    list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingFromStringBindingW(ushort* StringBinding, void** Binding);

@DllImport("RPCRT4")
int RpcSsGetContextBinding(void* ContextHandle, void** Binding);

///The <b>RpcBindingInqObject</b> function returns the object UUID from a binding handle.
///Params:
///    Binding = Client or server binding handle.
///    ObjectUuid = Returns a pointer to the object UUID found in the <i>Binding</i> parameter. <i>ObjectUuid</i> is a unique
///                 identifier of an object to which a remote procedure call can be made.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcBindingInqObject(void* Binding, GUID* ObjectUuid);

///The <b>RpcBindingReset</b> function resets a binding handle so that the host is specified but the server on that host
///is unspecified.
///Params:
///    Binding = Server binding handle to reset.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid
///    error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingReset(void* Binding);

///The <b>RpcBindingSetObject</b> function sets the object UUID value in a binding handle.
///Params:
///    Binding = Server binding into which the <i>ObjectUuid</i> is set.
///    ObjectUuid = Pointer to the UUID of the object serviced by the server specified in the <i>Binding</i> parameter.
///                 <i>ObjectUuid</i> is a unique identifier of an object to which a remote procedure call can be made.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid
///    error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingSetObject(void* Binding, GUID* ObjectUuid);

///The <b>RpcMgmtInqDefaultProtectLevel</b> function returns the default authentication level for an authentication
///service.
///Params:
///    AuthnSvc = Authentication service for which to return the default authentication level. Valid values are the constant for
///               any valid security provider.
///    AuthnLevel = Returns the default authentication level for the specified authentication service. The authentication level
///                 determines the degree to which authenticated communications between the client and server are protected. For more
///                 information, see Authentication Level Constants.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_UNKNOWN_AUTH_SERVICE</b></dt> </dl> </td> <td width="60%"> Unknown authentication service. </td>
///    </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcMgmtInqDefaultProtectLevel(uint AuthnSvc, uint* AuthnLevel);

///The <b>RpcBindingToStringBinding</b> function returns a string representation of a binding handle.
///Params:
///    Binding = Client or server binding handle to convert to a string representation of a binding handle.
///    StringBinding = Returns a pointer to a pointer to the string representation of the binding handle specified in the <i>Binding</i>
///                    parameter. Specify a null value to prevent <b>RpcBindingToStringBinding</b> from returning the
///                    <i>StringBinding</i> parameter. In this case, the application does not call the RpcStringFree function.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcBindingToStringBindingA(void* Binding, ubyte** StringBinding);

///The <b>RpcBindingToStringBinding</b> function returns a string representation of a binding handle.
///Params:
///    Binding = Client or server binding handle to convert to a string representation of a binding handle.
///    StringBinding = Returns a pointer to a pointer to the string representation of the binding handle specified in the <i>Binding</i>
///                    parameter. Specify a null value to prevent <b>RpcBindingToStringBinding</b> from returning the
///                    <i>StringBinding</i> parameter. In this case, the application does not call the RpcStringFree function.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcBindingToStringBindingW(void* Binding, ushort** StringBinding);

///The <b>RpcBindingVectorFree</b> function frees the binding handles contained in the vector and the vector itself.
///Params:
///    BindingVector = Pointer to a pointer to a vector of server binding handles. On return, the pointer is set to <b>NULL</b>.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> The argument was invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td
///    width="60%"> This was the wrong kind of binding for the operation. </td> </tr> </table> <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingVectorFree(RPC_BINDING_VECTOR** BindingVector);

///The <b>RpcStringBindingCompose</b> function creates a string binding handle.
///Params:
///    ObjUuid = Pointer to a <b>null</b>-terminated string representation of an object UUID. For example, the string
///              6B29FC40-CA47-1067-B31D-00DD010662DA represents a valid UUID.
///    ProtSeq = Pointer to a <b>null</b>-terminated string representation of a protocol sequence. See Note.
///    NetworkAddr = Pointer to a <b>null</b>-terminated string representation of a network address. The network-address format is
///                  associated with the protocol sequence. See Note.
///    Endpoint = Pointer to a <b>null</b>-terminated string representation of an endpoint. The endpoint format and content are
///               associated with the protocol sequence. For example, the endpoint associated with the protocol sequence
///               <b>ncacn_np</b> is a pipe name in the format \pipe\pipename. See Note.
///    Options = Pointer to a <b>null</b>-terminated string representation of network options. The option string is associated
///              with the protocol sequence. See Note.
///    StringBinding = Returns a pointer to a pointer to a <b>null</b>-terminated string representation of a binding handle. Specify a
///                    <b>NULL</b> value to prevent <b>RpcStringBindingCompose</b> from returning the <i>StringBinding</i> parameter. In
///                    this case, the application does not call RpcStringFree. See Note. <div class="alert"><b>Note</b> For more
///                    information, see String Binding.</div> <div> </div>
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_STRING_UUID</b></dt> </dl> </td> <td width="60%"> The string representation of the UUID is
///    not valid. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return
///    Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcStringBindingComposeA(ubyte* ObjUuid, ubyte* ProtSeq, ubyte* NetworkAddr, ubyte* Endpoint, ubyte* Options, 
                             ubyte** StringBinding);

///The <b>RpcStringBindingCompose</b> function creates a string binding handle.
///Params:
///    ObjUuid = Pointer to a <b>null</b>-terminated string representation of an object UUID. For example, the string
///              6B29FC40-CA47-1067-B31D-00DD010662DA represents a valid UUID.
///    ProtSeq = Pointer to a <b>null</b>-terminated string representation of a protocol sequence. See Note.
///    NetworkAddr = Pointer to a <b>null</b>-terminated string representation of a network address. The network-address format is
///                  associated with the protocol sequence. See Note.
///    Endpoint = Pointer to a <b>null</b>-terminated string representation of an endpoint. The endpoint format and content are
///               associated with the protocol sequence. For example, the endpoint associated with the protocol sequence
///               <b>ncacn_np</b> is a pipe name in the format \pipe\pipename. See Note.
///    Options = Pointer to a <b>null</b>-terminated string representation of network options. The option string is associated
///              with the protocol sequence. See Note.
///    StringBinding = Returns a pointer to a pointer to a <b>null</b>-terminated string representation of a binding handle. Specify a
///                    <b>NULL</b> value to prevent <b>RpcStringBindingCompose</b> from returning the <i>StringBinding</i> parameter. In
///                    this case, the application does not call RpcStringFree. See Note. <div class="alert"><b>Note</b> For more
///                    information, see String Binding.</div> <div> </div>
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_STRING_UUID</b></dt> </dl> </td> <td width="60%"> The string representation of the UUID is
///    not valid. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return
///    Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcStringBindingComposeW(ushort* ObjUuid, ushort* ProtSeq, ushort* NetworkAddr, ushort* Endpoint, 
                             ushort* Options, ushort** StringBinding);

///The <b>RpcStringBindingParse</b> function returns the object UUID part and the address parts of a string binding as
///separate strings. An application calls <b>RpcStringBindingParse</b> to parse a string representation of a binding
///handle into its component fields. The <b>RpcStringBindingParse</b> function returns the object UUID part and the
///address parts of a string binding as separate strings.
///Params:
///    StringBinding = Pointer to a <b>null</b>-terminated string representation of a binding.
///    ObjUuid = Returns a pointer to a pointer to a <b>null</b>-terminated string representation of an object UUID. Specify a
///              <b>NULL</b> value to prevent <b>RpcStringBindingParse</b> from returning the <i>ObjectUuid</i> parameter. In this
///              case, the application does not call RpcStringFree.
///    Protseq = Returns a pointer to a pointer to a <b>null</b>-terminated string representation of a protocol sequence. For a
///              list of Microsoft RPC supported protocol sequences, see String Binding. Specify a <b>NULL</b> value to prevent
///              <b>RpcStringBindingParse</b> from returning the <i>ProtSeq</i> parameter. In this case, the application does not
///              call RpcStringFree.
///    NetworkAddr = Returns a pointer to a pointer to a <b>null</b>-terminated string representation of a network address. Specify a
///                  <b>NULL</b> value to prevent <b>RpcStringBindingParse</b> from returning the <i>NetworkAddr</i> parameter. In
///                  this case, the application does not call RpcStringFree.
///    Endpoint = Returns a pointer to a pointer to a <b>null</b>-terminated string representation of an endpoint. Specify a
///               <b>NULL</b> value to prevent <b>RpcStringBindingParse</b> from returning the <i>EndPoint</i> parameter. In this
///               case, the application does not call RpcStringFree.
///    NetworkOptions = Returns a pointer to a pointer to a <b>null</b>-terminated string representation of network options. Specify a
///                     <b>NULL</b> value to prevent <b>RpcStringBindingParse</b> from returning the <i>NetworkOptions</i> parameter. In
///                     this case, the application does not call RpcStringFree.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_STRING_BINDING</b></dt> </dl> </td> <td width="60%"> The string binding is invalid. </td>
///    </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcStringBindingParseA(ubyte* StringBinding, ubyte** ObjUuid, ubyte** Protseq, ubyte** NetworkAddr, 
                           ubyte** Endpoint, ubyte** NetworkOptions);

///The <b>RpcStringBindingParse</b> function returns the object UUID part and the address parts of a string binding as
///separate strings. An application calls <b>RpcStringBindingParse</b> to parse a string representation of a binding
///handle into its component fields. The <b>RpcStringBindingParse</b> function returns the object UUID part and the
///address parts of a string binding as separate strings.
///Params:
///    StringBinding = Pointer to a <b>null</b>-terminated string representation of a binding.
///    ObjUuid = Returns a pointer to a pointer to a <b>null</b>-terminated string representation of an object UUID. Specify a
///              <b>NULL</b> value to prevent <b>RpcStringBindingParse</b> from returning the <i>ObjectUuid</i> parameter. In this
///              case, the application does not call RpcStringFree.
///    Protseq = Returns a pointer to a pointer to a <b>null</b>-terminated string representation of a protocol sequence. For a
///              list of Microsoft RPC supported protocol sequences, see String Binding. Specify a <b>NULL</b> value to prevent
///              <b>RpcStringBindingParse</b> from returning the <i>ProtSeq</i> parameter. In this case, the application does not
///              call RpcStringFree.
///    NetworkAddr = Returns a pointer to a pointer to a <b>null</b>-terminated string representation of a network address. Specify a
///                  <b>NULL</b> value to prevent <b>RpcStringBindingParse</b> from returning the <i>NetworkAddr</i> parameter. In
///                  this case, the application does not call RpcStringFree.
///    Endpoint = Returns a pointer to a pointer to a <b>null</b>-terminated string representation of an endpoint. Specify a
///               <b>NULL</b> value to prevent <b>RpcStringBindingParse</b> from returning the <i>EndPoint</i> parameter. In this
///               case, the application does not call RpcStringFree.
///    NetworkOptions = Returns a pointer to a pointer to a <b>null</b>-terminated string representation of network options. Specify a
///                     <b>NULL</b> value to prevent <b>RpcStringBindingParse</b> from returning the <i>NetworkOptions</i> parameter. In
///                     this case, the application does not call RpcStringFree.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_STRING_BINDING</b></dt> </dl> </td> <td width="60%"> The string binding is invalid. </td>
///    </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcStringBindingParseW(ushort* StringBinding, ushort** ObjUuid, ushort** Protseq, ushort** NetworkAddr, 
                           ushort** Endpoint, ushort** NetworkOptions);

///The <b>RpcStringFree</b> function frees a character string allocated by the RPC run-time library.
///Params:
///    String = Pointer to a pointer to the character string to free.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcStringFreeA(ubyte** String);

///The <b>RpcStringFree</b> function frees a character string allocated by the RPC run-time library.
///Params:
///    String = Pointer to a pointer to the character string to free.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcStringFreeW(ushort** String);

///The <b>RpcIfInqId</b> function returns the interface-identification part of an interface specification.
///Params:
///    RpcIfHandle = Stub-generated structure specifying the interface to query.
///    RpcIfId = Returns a pointer to the interface identification. The application provides memory for the returned data.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcIfInqId(void* RpcIfHandle, RPC_IF_ID* RpcIfId);

///The <b>RpcNetworkIsProtseqValid</b> function tells whether the specified protocol sequence is supported by both the
///RPC run-time library and the operating system. Server applications often use RpcNetworkInqProtseqs.
///Params:
///    Protseq = Pointer to a string identifier of the protocol sequence to be checked. If the <i>Protseq</i> parameter is not a
///              valid protocol sequence string, <b>RpcNetworkIsProtseqValid</b> returns RPC_S_INVALID_RPC_PROTSEQ.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded.; protocol sequence supported </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> Protocol sequence not supported on this
///    host. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_RPC_PROTSEQ</b></dt> </dl> </td> <td
///    width="60%"> Invalid protocol sequence. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid
///    error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcNetworkIsProtseqValidA(ubyte* Protseq);

///The <b>RpcNetworkIsProtseqValid</b> function tells whether the specified protocol sequence is supported by both the
///RPC run-time library and the operating system. Server applications often use RpcNetworkInqProtseqs.
///Params:
///    Protseq = Pointer to a string identifier of the protocol sequence to be checked. If the <i>Protseq</i> parameter is not a
///              valid protocol sequence string, <b>RpcNetworkIsProtseqValid</b> returns RPC_S_INVALID_RPC_PROTSEQ.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded.; protocol sequence supported </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> Protocol sequence not supported on this
///    host. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_RPC_PROTSEQ</b></dt> </dl> </td> <td
///    width="60%"> Invalid protocol sequence. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid
///    error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcNetworkIsProtseqValidW(ushort* Protseq);

///The <b>RpcMgmtInqComTimeout</b> function returns the binding-communications time-out value in a binding handle.
///Params:
///    Binding = Specifies a binding.
///    Timeout = Returns a pointer to the time-out value from the <i>Binding</i> parameter.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid
///    error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcMgmtInqComTimeout(void* Binding, uint* Timeout);

///The <b>RpcMgmtSetComTimeout</b> function sets the binding-communications time-out value in a binding handle.
///Params:
///    Binding = Server binding handle whose time-out value is set.
///    Timeout = Communications time-out value, from zero to 10. These values are not seconds; they represent a relative amount of
///              time on a scale of zero to 10.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_TIMEOUT</b></dt> </dl> </td> <td width="60%"> The time-out value
///    was invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td
///    width="60%"> This was the wrong kind of binding for the operation. </td> </tr> </table> <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcMgmtSetComTimeout(void* Binding, uint Timeout);

///The <b>RpcMgmtSetCancelTimeout</b> function sets the lower bound on the time to wait before timing out after
///forwarding a cancel.
///Params:
///    Timeout = Seconds to wait for a server to acknowledge a cancel command. To specify that a client waits an indefinite amount
///              of time, supply the value RPC_C_CANCEL_INFINITE_TIMEOUT.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_CANNOT_SUPPORT</b></dt> </dl> </td> <td width="60%"> Called from an MS-DOS or Windows 3.<i>x</i>
///    client. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return
///    Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcMgmtSetCancelTimeout(int Timeout);

///The <b>RpcNetworkInqProtseqs</b> function returns all protocol sequences supported by both the RPC run-time library
///and the operating system. Client applications often use RpcNetworkIsProtseqValid. For a list of Microsoft RPC's
///supported protocol sequences, see String Binding.
///Params:
///    ProtseqVector = Returns a pointer to a pointer to a protocol sequence vector.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_PROTSEQS</b></dt> </dl> </td> <td width="60%"> No supported protocol sequences. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcNetworkInqProtseqsA(RPC_PROTSEQ_VECTORA** ProtseqVector);

///The <b>RpcNetworkInqProtseqs</b> function returns all protocol sequences supported by both the RPC run-time library
///and the operating system. Client applications often use RpcNetworkIsProtseqValid. For a list of Microsoft RPC's
///supported protocol sequences, see String Binding.
///Params:
///    ProtseqVector = Returns a pointer to a pointer to a protocol sequence vector.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_PROTSEQS</b></dt> </dl> </td> <td width="60%"> No supported protocol sequences. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcNetworkInqProtseqsW(RPC_PROTSEQ_VECTORW** ProtseqVector);

///The <b>RpcObjectInqType</b> function returns the type of an object.
///Params:
///    ObjUuid = Pointer to the object UUID whose associated type UUID is returned.
///    TypeUuid = Returns a pointer to the type UUID of the <i>ObjUuid</i> parameter. Specify a parameter value of <b>NULL</b> to
///               prevent the return of a type UUID. In this way, an application can determine (from the returned status) whether
///               <i>ObjUuid</i> is registered without specifying an output type UUID variable.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_OBJECT_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> Object not found. </td> </tr> </table> <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcObjectInqType(GUID* ObjUuid, GUID* TypeUuid);

///The <b>RpcObjectSetInqFn</b> function registers an object-inquiry function. A null value turns off a previously
///registered object-inquiry function.
///Params:
///    InquiryFn = Object-type inquiry function. See RPC_OBJECT_INQ_FN. When an application calls RpcObjectInqType and the RPC
///                run-time library finds that the specified object is not registered, the run-time library automatically calls
///                <b>RpcObjectSetInqFn</b> to determine the object's type.
///Returns:
///    This function returns the following value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl> </td> <td width="60%"> The call succeeded. </td> </tr> </table>
///    <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcObjectSetInqFn(RPC_OBJECT_INQ_FN* InquiryFn);

///The <b>RpcObjectSetType</b> function assigns the type of an object.
///Params:
///    ObjUuid = Pointer to an object UUID to associate with the type UUID in the <i>TypeUuid</i> parameter.
///    TypeUuid = Pointer to the type UUID of the <i>ObjUuid</i> parameter. Specify a parameter value of NULL or a nil UUID to
///               reset the object type to the default association of object UUID/nil-type UUID.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_OBJECT</b></dt> </dl> </td> <td width="60%"> The object is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_ALREADY_REGISTERED</b></dt> </dl> </td> <td width="60%"> The object is already
///    registered. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> The system is out of memory. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid
///    error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcObjectSetType(GUID* ObjUuid, GUID* TypeUuid);

///The <b>RpcProtseqVectorFree</b> function frees the protocol sequences contained in the vector and the vector itself.
///Params:
///    ProtseqVector = Pointer to a pointer to a vector of protocol sequences. On return, the pointer is set to NULL.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcProtseqVectorFreeA(RPC_PROTSEQ_VECTORA** ProtseqVector);

///The <b>RpcProtseqVectorFree</b> function frees the protocol sequences contained in the vector and the vector itself.
///Params:
///    ProtseqVector = Pointer to a pointer to a vector of protocol sequences. On return, the pointer is set to NULL.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcProtseqVectorFreeW(RPC_PROTSEQ_VECTORW** ProtseqVector);

///The <b>RpcServerInqBindings</b> function returns the binding handles over which remote procedure calls can be
///received.
///Params:
///    BindingVector = Returns a pointer to a pointer to a vector of server binding handles.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_BINDINGS</b></dt> </dl> </td> <td width="60%"> There are no bindings. </td> </tr> </table> <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerInqBindings(RPC_BINDING_VECTOR** BindingVector);

@DllImport("RPCRT4")
int RpcServerInqBindingsEx(void* SecurityDescriptor, RPC_BINDING_VECTOR** BindingVector);

///The <b>RpcServerInqIf</b> function returns the manager entry-point vector (EPV) registered for an interface.
///Params:
///    IfSpec = Interface whose manager EPV is returned.
///    MgrTypeUuid = Pointer to the manager type UUID whose manager EPV is returned. Specifying a parameter value of <b>NULL</b> (or a
///                  nil UUID) signifies to return the manager EPV registered with <i>IfSpec</i> and the nil manager type UUID.
///    MgrEpv = Returns a pointer to the manager EPV for the requested interface.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_UNKNOWN_IF</b></dt> </dl> </td> <td width="60%"> The interface is unknown. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_UNKNOWN_MGR_TYPE</b></dt> </dl> </td> <td width="60%"> The manager type is
///    unknown. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return
///    Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerInqIf(void* IfSpec, GUID* MgrTypeUuid, void** MgrEpv);

///The <b>RpcServerListen</b> function signals the RPC run-time library to listen for remote procedure calls. This
///function will not affect auto-listen interfaces; use RpcServerRegisterIfEx if you need that functionality.
///Params:
///    MinimumCallThreads = Hint to the RPC run time that specifies the minimum number of call threads that should be created and maintained
///                         in the given server. This value is only a hint and is interpreted differently in different versions of Windows.
///                         In Windows XP, this value is the number of previously created threads in each thread pool that the RPC run time
///                         creates. An application should specify one for this parameter, and defer thread creation decisions to the RPC run
///                         time.
///    MaxCalls = Recommended maximum number of concurrent remote procedure calls the server can execute. To allow efficient
///               performance, the RPC run-time libraries interpret the <i>MaxCalls</i> parameter as a suggested limit rather than
///               as an absolute upper bound. Use RPC_C_LISTEN_MAX_CALLS_DEFAULT to specify the default value.
///    DontWait = Flag controlling the return from <b>RpcServerListen</b>. A value of nonzero indicates that <b>RpcServerListen</b>
///               should return immediately after completing function processing. A value of zero indicates that
///               <b>RpcServerListen</b> should not return until the RpcMgmtStopServerListening function has been called and all
///               remote calls have completed.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ALREADY_LISTENING</b></dt> </dl> </td> <td width="60%"> The server is already listening. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_NO_PROTSEQS_REGISTERED</b></dt> </dl> </td> <td width="60%"> There are no
///    protocol sequences registered. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_MAX_CALLS_TOO_SMALL</b></dt>
///    </dl> </td> <td width="60%"> The maximum calls value is too small. </td> </tr> </table> <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerListen(uint MinimumCallThreads, uint MaxCalls, uint DontWait);

///The <b>RpcServerRegisterIf</b> function registers an interface with the RPC run-time library.
///Params:
///    IfSpec = MIDL-generated structure indicating the interface to register.
///    MgrTypeUuid = Pointer to a type UUID to associate with the <i>MgrEpv</i> parameter. Specifying a null parameter value (or a nil
///                  UUID) registers <i>IfSpec</i> with a nil-type UUID.
///    MgrEpv = Manager routines' entry-point vector (EPV). To use the MIDL-generated default EPV, specify a null value. For more
///             information, please see RPC_MGR_EPV.
///Returns:
///    Returns RPC_S_OK upon success. <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return
///    Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerRegisterIf(void* IfSpec, GUID* MgrTypeUuid, void* MgrEpv);

///The <b>RpcServerRegisterIfEx</b> function registers an interface with the RPC run-time library.
///Params:
///    IfSpec = MIDL-generated structure indicating the interface to register.
///    MgrTypeUuid = Pointer to a type UUID to associate with the <i>MgrEpv</i> parameter. Specifying a <b>null</b> parameter value
///                  (or a nil UUID) registers <i>IfSpec</i> with a nil-type UUID.
///    MgrEpv = Manager routines' entry-point vector (EPV). To use the MIDL-generated default EPV, specify a <b>null</b> value.
///             For more information, please see RPC_MGR_EPV.
///    Flags = Flags. For a list of flag values, see Interface Registration Flags.
///    MaxCalls = Maximum number of concurrent remote procedure call requests the server can accept on an auto-listen interface.
///               The <i>MaxCalls</i> parameters is only applicable on an auto-listen interface, and is ignored on interfaces that
///               are not auto-listen. The RPC run-time library makes its best effort to ensure the server does not allow more
///               concurrent call requests than the number of calls specified in <i>MaxCalls</i>. The actual number can be greater
///               and can vary for each protocol sequence. Calls on other interfaces are governed by the value of the process-wide
///               <i>MaxCalls</i> parameter specified in the RpcServerListen function call. If the number of concurrent calls is
///               not a concern, you can achieve slightly better server-side performance by specifying the default value using
///               RPC_C_LISTEN_MAX_CALLS_DEFAULT. Doing so relieves the RPC run-time environment from enforcing an unnecessary
///               restriction.
///    IfCallback = Security-callback function, or <b>NULL</b> for no callback. Each registered interface can have a different
///                 callback function. See Remarks for more details.
///Returns:
///    Returns RPC_S_OK upon success. <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return
///    Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerRegisterIfEx(void* IfSpec, GUID* MgrTypeUuid, void* MgrEpv, uint Flags, uint MaxCalls, 
                          RPC_IF_CALLBACK_FN* IfCallback);

///The <b>RpcServerRegisterIf2</b> function registers an interface with the RPC run-time library.
///Params:
///    IfSpec = MIDL-generated structure indicating the interface to register.
///    MgrTypeUuid = Pointer to a type <b>UUID</b> to associate with the <i>MgrEpv</i> parameter. Specifying a <b>null</b> parameter
///                  value (or a nil <b>UUID</b>) registers <i>IfSpec</i> with a nil-type <b>UUID</b>.
///    MgrEpv = Manager routines' entry-point vector (EPV). To use the MIDL-generated default EPV, specify a <b>null</b> value.
///             For more information, please see RPC_MGR_EPV.
///    Flags = Flags. For a list of flag values, see Interface Registration Flags.
///    MaxCalls = Maximum number of concurrent remote procedure call requests the server can accept on an <b>auto-listen</b>
///               interface. The <i>MaxCalls</i> parameter is only applicable on an <b>auto-listen</b> interface, and is ignored on
///               interfaces that are not <b>auto-listen</b>. The RPC run-time library makes its best effort to ensure the server
///               does not allow more concurrent call requests than the number of calls specified in <i>MaxCalls</i>. The actual
///               number can be greater and can vary for each protocol sequence. Calls on other interfaces are governed by the
///               value of the process-wide <i>MaxCalls</i> parameter specified in the RpcServerListen function call. If the number
///               of concurrent calls is not a concern, you can achieve slightly better server-side performance by specifying the
///               default value using RPC_C_LISTEN_MAX_CALLS_DEFAULT. Doing so relieves the RPC run-time environment from enforcing
///               an unnecessary restriction.
///    MaxRpcSize = Maximum size of incoming data blocks, in bytes. This parameter may be used to help prevent malicious
///                 denial-of-service attacks. If the data block of a remote procedure call is larger than <i>MaxRpcSize</i>, the RPC
///                 run-time library rejects the call and sends an RPC_S_ACCESS_DENIED error to the client. Specifying a value of
///                 (unsigned int) –1 for this parameter removes the limit on the size of incoming data blocks. This parameter has
///                 no effect on calls made over the ncalrpc protocol.
///    IfCallbackFn = Security-callback function, or <b>NULL</b> for no callback. Each registered interface can have a different
///                   callback function. See Remarks.
///Returns:
///    Returns RPC_S_OK upon success. <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return
///    Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerRegisterIf2(void* IfSpec, GUID* MgrTypeUuid, void* MgrEpv, uint Flags, uint MaxCalls, uint MaxRpcSize, 
                         RPC_IF_CALLBACK_FN* IfCallbackFn);

///The <b>RpcServerRegisterIf3</b> function registers an interface with the RPC run-time library.
///Params:
///    IfSpec = MIDL-generated structure indicating the interface to register.
///    MgrTypeUuid = Pointer to a type <b>UUID</b> to associate with the <i>MgrEpv</i> parameter. Specifying a <b>null</b> parameter
///                  value (or a nil <b>UUID</b>) registers <i>IfSpec</i> with a nil-type <b>UUID</b>.
///    MgrEpv = Manager routines' entry-point vector (EPV). To use the MIDL-generated default EPV, specify a <b>null</b> value.
///             For more information, please see RPC_MGR_EPV.
///    Flags = Flags. For a list of flag values, see Interface Registration Flags.
///    MaxCalls = Maximum number of concurrent remote procedure call requests the server can accept on an <b>auto-listen</b>
///               interface. The <i>MaxCalls</i> parameter is only applicable on an <b>auto-listen</b> interface, and is ignored on
///               interfaces that are not <b>auto-listen</b>. The RPC run-time library makes its best effort to ensure the server
///               does not allow more concurrent call requests than the number of calls specified in <i>MaxCalls</i>. The actual
///               number can be greater and can vary for each protocol sequence. Calls on other interfaces are governed by the
///               value of the process-wide <i>MaxCalls</i> parameter specified in the RpcServerListen function call. If the number
///               of concurrent calls is not a concern, you can achieve slightly better server-side performance by specifying the
///               default value using RPC_C_LISTEN_MAX_CALLS_DEFAULT. Doing so relieves the RPC run-time environment from enforcing
///               an unnecessary restriction.
///    MaxRpcSize = Maximum size of incoming data blocks, in bytes. This parameter may be used to help prevent malicious
///                 denial-of-service attacks. If the data block of a remote procedure call is larger than <i>MaxRpcSize</i>, the RPC
///                 run-time library rejects the call and sends an RPC_S_ACCESS_DENIED error to the client. Specifying a value of
///                 (unsigned int) –1 for this parameter removes the limit on the size of incoming data blocks. This parameter has
///                 no effect on calls made over the ncalrpc protocol.
///    IfCallback = Security-callback function, or <b>NULL</b> for no callback. Each registered interface can have a different
///                 callback function. See the Remarks on RpcServerRegisterIf2.
///    SecurityDescriptor = Security descriptor for accessing the RPC interface. Each registered interface can have a different security
///                         descriptor.
///Returns:
///    Returns RPC_S_OK upon success. <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return
///    Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerRegisterIf3(void* IfSpec, GUID* MgrTypeUuid, void* MgrEpv, uint Flags, uint MaxCalls, uint MaxRpcSize, 
                         RPC_IF_CALLBACK_FN* IfCallback, void* SecurityDescriptor);

///The <b>RpcServerUnregisterIf</b> function removes an interface from the RPC run-time library registry.
///Params:
///    IfSpec = Interface to remove from the registry. Specify a <b>null</b> value to remove all interfaces previously registered
///             with the type UUID value specified in the <i>MgrTypeUuid</i> parameter.
///    MgrTypeUuid = Pointer to the type UUID of the manager entry-point vector (EPV) to remove from the registry. The value of
///                  <i>MgrTypeUuid</i> should be the same value as was provided in a call to the RpcServerRegisterIf function,
///                  RpcServerRegisterIf2 function, or the RpcServerRegisterIfEx function. Specify a <b>null</b> value to remove the
///                  interface specified in the <i>IfSpec</i> parameter for all previously registered type UUIDs from the registry.
///                  Specify a nil UUID to remove the MIDL-generated default manager EPV from the registry. In this case, all manager
///                  EPVs registered with a non-nil type UUID remain registered.
///    WaitForCallsToComplete = Flag that indicates whether to remove the interface from the registry immediately or to wait until all current
///                             calls are complete. Specify a value of zero to disregard calls in progress and remove the interface from the
///                             registry immediately. Specify any nonzero value to wait until all active calls complete.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_UNKNOWN_MGR_TYPE</b></dt> </dl> </td> <td width="60%"> The manager type is unknown. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>RPC_S_UNKNOWN_IF</b></dt> </dl> </td> <td width="60%"> The interface is unknown.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerUnregisterIf(void* IfSpec, GUID* MgrTypeUuid, uint WaitForCallsToComplete);

///The <b>RpcServerUnregisterIfEx</b> function removes an interface from the RPC run-time library registry. This
///function extends the functionality of the RpcServerUnregisterIf function.
///Params:
///    IfSpec = Interface to remove from the registry. Specify a null value to remove all interfaces previously registered with
///             the type UUID value specified in the <i>MgrTypeUuid</i> parameter.
///    MgrTypeUuid = Pointer to the type UUID of the manager entry-point vector (EPV) to remove from the registry. The value of
///                  <i>MgrTypeUuid</i> should be the same value as was provided in a call to the RpcServerRegisterIf function,
///                  RpcServerRegisterIf2 function, or the RpcServerRegisterIfEx function. Specify a null value to remove the
///                  interface specified in the <i>IfSpec</i> parameter for all previously registered type UUIDs from the registry.
///                  Specify a nil UUID to remove the MIDL-generated default manager EPV from the registry. In this case, all manager
///                  EPVs registered with a non-nil type UUID remain registered.
///    RundownContextHandles = Specifies whether rundown is called for active context handles. If non-zero, the rundown is called once all calls
///                            on the interface have completed. If set to zero, the RPC run time assumes the server has already destroyed its
///                            portion of the context handle and it will not call the rundown routines.
///Returns:
///    Returns RPC status. <b>RpcServerUnregisterIfEx</b> does not fail unless supplied with invalid values. <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerUnregisterIfEx(void* IfSpec, GUID* MgrTypeUuid, int RundownContextHandles);

///The <b>RpcServerUseAllProtseqs</b> function tells the RPC run-time library to use all supported protocol sequences
///for receiving remote procedure calls.
///Params:
///    MaxCalls = Backlog queue length for the ncacn_ip_tcp protocol sequence. All other protocol sequences ignore this parameter.
///               Use RPC_C_PROTSEQ_MAX_REQS_DEFAULT to specify the default value. See Remarks.
///    SecurityDescriptor = Pointer to an optional parameter provided for the security subsystem. Used only for ncacn_np and ncalrpc protocol
///                         sequences. All other protocol sequences ignore this parameter. Using a security descriptor on the endpoint in
///                         order to make a server secure is not recommended. This parameter does not appear in the DCE specification for
///                         this API.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_PROTSEQS</b></dt> </dl> </td> <td width="60%"> There are no supported protocol sequences. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> Sufficient
///    memory is not available. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_SECURITY_DESC</b></dt> </dl>
///    </td> <td width="60%"> The security descriptor is invalid. </td> </tr> </table> <div class="alert"><b>Note</b>
///    For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerUseAllProtseqs(uint MaxCalls, void* SecurityDescriptor);

///The <b>RpcServerUseAllProtseqsEx</b> function tells the RPC run-time library to use all supported protocol sequences
///for receiving remote procedure calls.
///Params:
///    MaxCalls = Backlog queue length for the ncacn_ip_tcp protocol sequence. All other protocol sequences ignore this parameter.
///               Use RPC_C_PROTSEQ_MAX_REQS_DEFAULT to specify the default value. See Remarks.
///    SecurityDescriptor = Pointer to an optional parameter provided for the security subsystem. Used only for ncacn_np and ncalrpc protocol
///                         sequences. All other protocol sequences ignore this parameter. Using a security descriptor on the endpoint in
///                         order to make a server secure is not recommended. This parameter does not appear in the DCE specification for
///                         this API.
///    Policy = Pointer to the RPC_POLICY structure, which allows you to override the default policies for dynamic port
///             allocation and binding to network interface cards (NICs) on multihomed computers (computers with multiple network
///             cards).
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_PROTSEQS</b></dt> </dl> </td> <td width="60%"> There are no supported protocol sequences. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> Sufficient
///    memory is not available. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_SECURITY_DESC</b></dt> </dl>
///    </td> <td width="60%"> The security descriptor is invalid. </td> </tr> </table> <div class="alert"><b>Note</b>
///    For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerUseAllProtseqsEx(uint MaxCalls, void* SecurityDescriptor, RPC_POLICY* Policy);

///The <b>RpcServerUseAllProtseqsIf</b> function tells the RPC run-time library to use all specified protocol sequences
///and endpoints in the interface specification for receiving remote procedure calls.
///Params:
///    MaxCalls = Backlog queue length for the ncacn_ip_tcp protocol sequence. All other protocol sequences ignore this parameter.
///               Use RPC_C_PROTSEQ_MAX_REQS_DEFAULT to specify the default value. See Remarks.
///    IfSpec = Interface containing the protocol sequences and corresponding endpoint information to use in creating binding
///             handles.
///    SecurityDescriptor = Pointer to an optional parameter provided for the security subsystem. Used only for ncacn_np and ncalrpc protocol
///                         sequences. All other protocol sequences ignore this parameter. Using a security descriptor on the endpoint in
///                         order to make a server secure is not recommended. This parameter does not appear in the DCE specification for
///                         this API.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_PROTSEQS</b></dt> </dl> </td> <td width="60%"> There are no supported protocol sequences. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_ENDPOINT_FORMAT</b></dt> </dl> </td> <td width="60%"> The
///    endpoint format. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> The system is out of memory. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_DUPLICATE_ENDPOINT</b></dt> </dl> </td> <td width="60%"> The endpoint is a duplicate. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_SECURITY_DESC</b></dt> </dl> </td> <td width="60%"> The security
///    descriptor is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_RPC_PROTSEQ</b></dt> </dl>
///    </td> <td width="60%"> RPC protocol sequence invalid. </td> </tr> </table> <div class="alert"><b>Note</b> For a
///    list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerUseAllProtseqsIf(uint MaxCalls, void* IfSpec, void* SecurityDescriptor);

///The <b>RpcServerUseAllProtseqsIfEx</b> function tells the RPC run-time library to use all the specified protocol
///sequences and endpoints in the interface specification for receiving remote procedure calls.
///Params:
///    MaxCalls = Backlog queue length for the ncacn_ip_tcp protocol sequence. All other protocol sequences ignore this parameter.
///               Use RPC_C_PROTSEQ_MAX_REQS_DEFAULT to specify the default value. See Remarks.
///    IfSpec = Interface containing the protocol sequences and corresponding endpoint information to use in creating binding
///             handles.
///    SecurityDescriptor = Pointer to an optional parameter provided for the security subsystem. Used only for ncacn_np and ncalrpc protocol
///                         sequences. All other protocol sequences ignore this parameter. Using a security descriptor on the endpoint in
///                         order to make a server secure is not recommended. This parameter does not appear in the DCE specification for
///                         this API.
///    Policy = Pointer to the RPC_POLICY structure, which contains flags to restrict port allocation for dynamic ports and allow
///             multihomed computers to selectively bind to network interface cards.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_PROTSEQS</b></dt> </dl> </td> <td width="60%"> There are no supported protocol sequences. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_ENDPOINT_FORMAT</b></dt> </dl> </td> <td width="60%"> The
///    endpoint format. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> The system is out of memory. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_DUPLICATE_ENDPOINT</b></dt> </dl> </td> <td width="60%"> The endpoint is a duplicate. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_SECURITY_DESC</b></dt> </dl> </td> <td width="60%"> The security
///    descriptor is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_RPC_PROTSEQ</b></dt> </dl>
///    </td> <td width="60%"> The RPC protocol sequence is invalid. </td> </tr> </table> <div class="alert"><b>Note</b>
///    For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerUseAllProtseqsIfEx(uint MaxCalls, void* IfSpec, void* SecurityDescriptor, RPC_POLICY* Policy);

///The <b>RpcServerUseProtseq</b> function tells the RPC run-time library to use the specified protocol sequence for
///receiving remote procedure calls.
///Params:
///    Protseq = Pointer to a string identifier of the protocol sequence to register with the RPC run-time library.
///    MaxCalls = Backlog queue length for the <b>ncacn_ip_tcp</b> protocol sequence. All other protocol sequences ignore this
///               parameter. Use RPC_C_PROTSEQ_MAX_REQS_DEFAULT to specify the default value. See Remarks.
///    SecurityDescriptor = Pointer to an optional parameter provided for the security subsystem. Used only for <b>ncacn_np</b> and
///                         <b>ncalrpc</b> protocol sequences. All other protocol sequences ignore this parameter. Using a security
///                         descriptor on the endpoint in order to make a server secure is not recommended. This parameter does not appear in
///                         the DCE specification for this API.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The protocol sequence is not supported
///    on this host. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_RPC_PROTSEQ</b></dt> </dl> </td> <td
///    width="60%"> The protocol sequence. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt>
///    </dl> </td> <td width="60%"> The system is out of memory. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_SECURITY_DESC</b></dt> </dl> </td> <td width="60%"> The security descriptor is invalid.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerUseProtseqA(ubyte* Protseq, uint MaxCalls, void* SecurityDescriptor);

///The <b>RpcServerUseProtseqEx</b> function tells the RPC run-time library to use the specified protocol sequence for
///receiving remote procedure calls.
///Params:
///    Protseq = Pointer to a string identifier of the protocol sequence to register with the RPC run-time library.
///    MaxCalls = Backlog queue length for the <b>ncacn_ip_tcp</b> protocol sequence. All other protocol sequences ignore this
///               parameter. Use RPC_C_PROTSEQ_MAX_REQS_DEFAULT to specify the default value. See Remarks.
///    SecurityDescriptor = Pointer to an optional parameter provided for the Windows XP/2000/NT security subsystem. Used only for
///                         <b>ncacn_np</b> and <b>ncalrpc</b> protocol sequences. All other protocol sequences ignore this parameter. Using
///                         a security descriptor on the endpoint in order to make a server secure is not recommended. This parameter does
///                         not appear in the DCE specification for this API.
///    Policy = Pointer to the RPC_POLICY structure, which contains flags to restrict port allocation for dynamic ports and allow
///             multihomed computers to selectively bind to network interface cards. The <b>RPC_POLICY</b> structure enables the
///             caller to direct the RPC run-time library to use an intranet port or an Internet port, among other options.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The protocol sequence is not supported
///    on this host. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_RPC_PROTSEQ</b></dt> </dl> </td> <td
///    width="60%"> The protocol sequence. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt>
///    </dl> </td> <td width="60%"> The system is out of memory. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_SECURITY_DESC</b></dt> </dl> </td> <td width="60%"> The security descriptor is invalid.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerUseProtseqExA(ubyte* Protseq, uint MaxCalls, void* SecurityDescriptor, RPC_POLICY* Policy);

///The <b>RpcServerUseProtseq</b> function tells the RPC run-time library to use the specified protocol sequence for
///receiving remote procedure calls.
///Params:
///    Protseq = Pointer to a string identifier of the protocol sequence to register with the RPC run-time library.
///    MaxCalls = Backlog queue length for the <b>ncacn_ip_tcp</b> protocol sequence. All other protocol sequences ignore this
///               parameter. Use RPC_C_PROTSEQ_MAX_REQS_DEFAULT to specify the default value. See Remarks.
///    SecurityDescriptor = Pointer to an optional parameter provided for the security subsystem. Used only for <b>ncacn_np</b> and
///                         <b>ncalrpc</b> protocol sequences. All other protocol sequences ignore this parameter. Using a security
///                         descriptor on the endpoint in order to make a server secure is not recommended. This parameter does not appear in
///                         the DCE specification for this API.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The protocol sequence is not supported
///    on this host. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_RPC_PROTSEQ</b></dt> </dl> </td> <td
///    width="60%"> The protocol sequence. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt>
///    </dl> </td> <td width="60%"> The system is out of memory. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_SECURITY_DESC</b></dt> </dl> </td> <td width="60%"> The security descriptor is invalid.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerUseProtseqW(ushort* Protseq, uint MaxCalls, void* SecurityDescriptor);

///The <b>RpcServerUseProtseqEx</b> function tells the RPC run-time library to use the specified protocol sequence for
///receiving remote procedure calls.
///Params:
///    Protseq = Pointer to a string identifier of the protocol sequence to register with the RPC run-time library.
///    MaxCalls = Backlog queue length for the <b>ncacn_ip_tcp</b> protocol sequence. All other protocol sequences ignore this
///               parameter. Use RPC_C_PROTSEQ_MAX_REQS_DEFAULT to specify the default value. See Remarks.
///    SecurityDescriptor = Pointer to an optional parameter provided for the Windows XP/2000/NT security subsystem. Used only for
///                         <b>ncacn_np</b> and <b>ncalrpc</b> protocol sequences. All other protocol sequences ignore this parameter. Using
///                         a security descriptor on the endpoint in order to make a server secure is not recommended. This parameter does
///                         not appear in the DCE specification for this API.
///    Policy = Pointer to the RPC_POLICY structure, which contains flags to restrict port allocation for dynamic ports and allow
///             multihomed computers to selectively bind to network interface cards. The <b>RPC_POLICY</b> structure enables the
///             caller to direct the RPC run-time library to use an intranet port or an Internet port, among other options.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The protocol sequence is not supported
///    on this host. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_RPC_PROTSEQ</b></dt> </dl> </td> <td
///    width="60%"> The protocol sequence. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt>
///    </dl> </td> <td width="60%"> The system is out of memory. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_SECURITY_DESC</b></dt> </dl> </td> <td width="60%"> The security descriptor is invalid.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerUseProtseqExW(ushort* Protseq, uint MaxCalls, void* SecurityDescriptor, RPC_POLICY* Policy);

///The <b>RpcServerUseProtseqEp</b> function tells the RPC run-time library to use the specified protocol sequence
///combined with the specified endpoint for receiving remote procedure calls.
///Params:
///    Protseq = Pointer to a string identifier of the protocol sequence to register with the RPC run-time library.
///    MaxCalls = Backlog queue length for the <b>ncacn_ip_tcp</b> protocol sequence. All other protocol sequences ignore this
///               parameter. Use RPC_C_PROTSEQ_MAX_REQS_DEFAULT to specify the default value. See Remarks.
///    Endpoint = Pointer to the endpoint-address information to use in creating a binding for the protocol sequence specified in
///               the <i>Protseq</i> parameter.
///    SecurityDescriptor = Pointer to an optional parameter provided for the security subsystem. Used only for <b>ncacn_np</b> and
///                         <b>ncalrpc</b> protocol sequences. All other protocol sequences ignore this parameter. Using a security
///                         descriptor on the endpoint in order to make a server secure is not recommended. This parameter does not appear in
///                         the DCE specification for this API.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The protocol sequence is not supported
///    on this host. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_RPC_PROTSEQ</b></dt> </dl> </td> <td
///    width="60%"> The protocol sequence is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ENDPOINT_FORMAT</b></dt> </dl> </td> <td width="60%"> The endpoint format is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is
///    out of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_DUPLICATE_ENDPOINT</b></dt> </dl> </td> <td
///    width="60%"> The endpoint is a duplicate. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_SECURITY_DESC</b></dt> </dl> </td> <td width="60%"> The security descriptor is invalid.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerUseProtseqEpA(ubyte* Protseq, uint MaxCalls, ubyte* Endpoint, void* SecurityDescriptor);

///The <b>RpcServerUseProtseqEpEx</b> function tells the RPC run-time library to use the specified protocol sequence
///combined with the specified endpoint for receiving remote procedure calls.
///Params:
///    Protseq = Pointer to a string identifier of the protocol sequence to register with the RPC run-time library.
///    MaxCalls = Backlog queue length for the <b>ncacn_ip_tcp</b> protocol sequence. All other protocol sequences ignore this
///               parameter. Use RPC_C_PROTSEQ_MAX_REQS_DEFAULT to specify the default value. See Remarks.
///    Endpoint = Pointer to the endpoint-address information to use in creating a binding for the protocol sequence specified by
///               <i>Protseq</i>.
///    SecurityDescriptor = Pointer to an optional parameter provided for the security subsystem. Used only for <b>ncacn_np</b> and
///                         <i>ncalrpc</i> protocol sequences. All other protocol sequences ignore this parameter. Using a security
///                         descriptor on the endpoint in order to make a server secure is not recommended. This parameter does not appear in
///                         the DCE specification for this API.
///    Policy = Pointer to the RPC_POLICY structure, which contains flags that set transport-specific attributes. In the case of
///             the <b>ncadg_mq</b> transport, these flags specify the properties of the server process–receive queue. In the
///             case of the <b>ncacn_ip_tcp</b> or <b>ncadg_ip_udp</b> transports, these flags restrict port allocation for
///             dynamic ports and allow multihomed computers to selectively bind to network interface cards. The flag settings in
///             the <b>Policy</b> field are effective only when the <b>ncacn_ip_tcp</b>, <b>ncadg_ip_udp</b>, or <b>ncadg_mq</b>
///             protocol sequences are in use. For all other protocol sequences, the RPC run time ignores these values. <div
///             class="alert"><b>Note</b> Portions of the policy associated with dynamic endpoints are ignored when the
///             RpcServerUseProtseqEpEx function is called, since the port is specified in the endpoint itself.</div> <div>
///             </div>
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The protocol sequence is not supported
///    on this host. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_RPC_PROTSEQ</b></dt> </dl> </td> <td
///    width="60%"> The protocol sequence is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ENDPOINT_FORMAT</b></dt> </dl> </td> <td width="60%"> The endpoint format is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is
///    out of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_DUPLICATE_ENDPOINT</b></dt> </dl> </td> <td
///    width="60%"> The endpoint is a duplicate. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_SECURITY_DESC</b></dt> </dl> </td> <td width="60%"> The security descriptor is invalid.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerUseProtseqEpExA(ubyte* Protseq, uint MaxCalls, ubyte* Endpoint, void* SecurityDescriptor, 
                             RPC_POLICY* Policy);

///The <b>RpcServerUseProtseqEp</b> function tells the RPC run-time library to use the specified protocol sequence
///combined with the specified endpoint for receiving remote procedure calls.
///Params:
///    Protseq = Pointer to a string identifier of the protocol sequence to register with the RPC run-time library.
///    MaxCalls = Backlog queue length for the <b>ncacn_ip_tcp</b> protocol sequence. All other protocol sequences ignore this
///               parameter. Use RPC_C_PROTSEQ_MAX_REQS_DEFAULT to specify the default value. See Remarks.
///    Endpoint = Pointer to the endpoint-address information to use in creating a binding for the protocol sequence specified in
///               the <i>Protseq</i> parameter.
///    SecurityDescriptor = Pointer to an optional parameter provided for the security subsystem. Used only for <b>ncacn_np</b> and
///                         <b>ncalrpc</b> protocol sequences. All other protocol sequences ignore this parameter. Using a security
///                         descriptor on the endpoint in order to make a server secure is not recommended. This parameter does not appear in
///                         the DCE specification for this API.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The protocol sequence is not supported
///    on this host. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_RPC_PROTSEQ</b></dt> </dl> </td> <td
///    width="60%"> The protocol sequence is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ENDPOINT_FORMAT</b></dt> </dl> </td> <td width="60%"> The endpoint format is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is
///    out of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_DUPLICATE_ENDPOINT</b></dt> </dl> </td> <td
///    width="60%"> The endpoint is a duplicate. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_SECURITY_DESC</b></dt> </dl> </td> <td width="60%"> The security descriptor is invalid.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerUseProtseqEpW(ushort* Protseq, uint MaxCalls, ushort* Endpoint, void* SecurityDescriptor);

///The <b>RpcServerUseProtseqEpEx</b> function tells the RPC run-time library to use the specified protocol sequence
///combined with the specified endpoint for receiving remote procedure calls.
///Params:
///    Protseq = Pointer to a string identifier of the protocol sequence to register with the RPC run-time library.
///    MaxCalls = Backlog queue length for the <b>ncacn_ip_tcp</b> protocol sequence. All other protocol sequences ignore this
///               parameter. Use RPC_C_PROTSEQ_MAX_REQS_DEFAULT to specify the default value. See Remarks.
///    Endpoint = Pointer to the endpoint-address information to use in creating a binding for the protocol sequence specified by
///               <i>Protseq</i>.
///    SecurityDescriptor = Pointer to an optional parameter provided for the security subsystem. Used only for <b>ncacn_np</b> and
///                         <i>ncalrpc</i> protocol sequences. All other protocol sequences ignore this parameter. Using a security
///                         descriptor on the endpoint in order to make a server secure is not recommended. This parameter does not appear in
///                         the DCE specification for this API.
///    Policy = Pointer to the RPC_POLICY structure, which contains flags that set transport-specific attributes. In the case of
///             the <b>ncadg_mq</b> transport, these flags specify the properties of the server process–receive queue. In the
///             case of the <b>ncacn_ip_tcp</b> or <b>ncadg_ip_udp</b> transports, these flags restrict port allocation for
///             dynamic ports and allow multihomed computers to selectively bind to network interface cards. The flag settings in
///             the <b>Policy</b> field are effective only when the <b>ncacn_ip_tcp</b>, <b>ncadg_ip_udp</b>, or <b>ncadg_mq</b>
///             protocol sequences are in use. For all other protocol sequences, the RPC run time ignores these values. <div
///             class="alert"><b>Note</b> Portions of the policy associated with dynamic endpoints are ignored when the
///             RpcServerUseProtseqEpEx function is called, since the port is specified in the endpoint itself.</div> <div>
///             </div>
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The protocol sequence is not supported
///    on this host. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_RPC_PROTSEQ</b></dt> </dl> </td> <td
///    width="60%"> The protocol sequence is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ENDPOINT_FORMAT</b></dt> </dl> </td> <td width="60%"> The endpoint format is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is
///    out of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_DUPLICATE_ENDPOINT</b></dt> </dl> </td> <td
///    width="60%"> The endpoint is a duplicate. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_SECURITY_DESC</b></dt> </dl> </td> <td width="60%"> The security descriptor is invalid.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerUseProtseqEpExW(ushort* Protseq, uint MaxCalls, ushort* Endpoint, void* SecurityDescriptor, 
                             RPC_POLICY* Policy);

///The <b>RpcServerUseProtseqIf</b> function tells the RPC run-time library to use the specified protocol sequence
///combined with the endpoints in the interface specification for receiving remote procedure calls.
///Params:
///    Protseq = Pointer to a string identifier of the protocol sequence to register with the RPC run-time library.
///    MaxCalls = Backlog queue length for the <b>ncacn_ip_tcp</b> protocol sequence. All other protocol sequences ignore this
///               parameter. Use RPC_C_PROTSEQ_MAX_REQS_DEFAULT to specify the default value. See Remarks.
///    IfSpec = Interface containing endpoint information to use in creating a binding for the protocol sequence specified in the
///             <i>Protseq</i> parameter.
///    SecurityDescriptor = Pointer to an optional parameter provided for the security subsystem. Used only for <b>ncacn_np</b> and
///                         <b>ncalrpc</b> protocol sequences. All other protocol sequences ignore this parameter. Using a security
///                         descriptor on the endpoint in order to make a server secure is not recommended. This parameter does not appear in
///                         the DCE specification for this API.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_PROTSEQ_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The endpoint for this protocol sequence is
///    not specified in the IDL file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> The protocol sequence is not supported on this host. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_INVALID_RPC_PROTSEQ</b></dt> </dl> </td> <td width="60%"> The protocol sequence is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_ENDPOINT_FORMAT</b></dt> </dl> </td> <td
///    width="60%"> The endpoint format is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is out of memory. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>RPC_S_INVALID_SECURITY_DESC</b></dt> </dl> </td> <td width="60%"> The security
///    descriptor is invalid. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see
///    RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerUseProtseqIfA(ubyte* Protseq, uint MaxCalls, void* IfSpec, void* SecurityDescriptor);

///The <b>RpcServerUseProtseqIfEx</b> function tells the RPC run-time library to use the specified protocol sequence
///combined with the endpoints in the interface specification for receiving remote procedure calls.
///Params:
///    Protseq = Pointer to a string identifier of the protocol sequence to register with the RPC run-time library.
///    MaxCalls = Backlog queue length for the <b>ncacn_ip_tcp</b> protocol sequence. All other protocol sequences ignore this
///               parameter. Use RPC_C_PROTSEQ_MAX_REQS_DEFAULT to specify the default value. See Remarks.
///    IfSpec = Interface containing endpoint information to use in creating a binding for the protocol sequence specified in the
///             <i>Protseq</i> parameter.
///    SecurityDescriptor = Pointer to an optional parameter provided for the security subsystem. Used only for <b>ncacn_np</b> and
///                         <b>ncalrpc</b> protocol sequences. All other protocol sequences ignore this parameter. Using a security
///                         descriptor on the endpoint in order to make a server secure is not recommended. This parameter does not appear in
///                         the DCE specification for this API.
///    Policy = Pointer to the RPC_POLICY structure, which contains flags to restrict port allocation for dynamic ports and that
///             allow multihomed computers to selectively bind to network interface cards.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_PROTSEQ_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The endpoint for this protocol sequence is
///    not specified in the IDL file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> The protocol sequence is not supported on this host. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_INVALID_RPC_PROTSEQ</b></dt> </dl> </td> <td width="60%"> The protocol sequence is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_ENDPOINT_FORMAT</b></dt> </dl> </td> <td
///    width="60%"> The endpoint format is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is out of memory. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>RPC_S_INVALID_SECURITY_DESC</b></dt> </dl> </td> <td width="60%"> The security
///    descriptor is invalid. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see
///    RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerUseProtseqIfExA(ubyte* Protseq, uint MaxCalls, void* IfSpec, void* SecurityDescriptor, 
                             RPC_POLICY* Policy);

///The <b>RpcServerUseProtseqIf</b> function tells the RPC run-time library to use the specified protocol sequence
///combined with the endpoints in the interface specification for receiving remote procedure calls.
///Params:
///    Protseq = Pointer to a string identifier of the protocol sequence to register with the RPC run-time library.
///    MaxCalls = Backlog queue length for the <b>ncacn_ip_tcp</b> protocol sequence. All other protocol sequences ignore this
///               parameter. Use RPC_C_PROTSEQ_MAX_REQS_DEFAULT to specify the default value. See Remarks.
///    IfSpec = Interface containing endpoint information to use in creating a binding for the protocol sequence specified in the
///             <i>Protseq</i> parameter.
///    SecurityDescriptor = Pointer to an optional parameter provided for the security subsystem. Used only for <b>ncacn_np</b> and
///                         <b>ncalrpc</b> protocol sequences. All other protocol sequences ignore this parameter. Using a security
///                         descriptor on the endpoint in order to make a server secure is not recommended. This parameter does not appear in
///                         the DCE specification for this API.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_PROTSEQ_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The endpoint for this protocol sequence is
///    not specified in the IDL file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> The protocol sequence is not supported on this host. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_INVALID_RPC_PROTSEQ</b></dt> </dl> </td> <td width="60%"> The protocol sequence is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_ENDPOINT_FORMAT</b></dt> </dl> </td> <td
///    width="60%"> The endpoint format is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is out of memory. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>RPC_S_INVALID_SECURITY_DESC</b></dt> </dl> </td> <td width="60%"> The security
///    descriptor is invalid. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see
///    RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerUseProtseqIfW(ushort* Protseq, uint MaxCalls, void* IfSpec, void* SecurityDescriptor);

///The <b>RpcServerUseProtseqIfEx</b> function tells the RPC run-time library to use the specified protocol sequence
///combined with the endpoints in the interface specification for receiving remote procedure calls.
///Params:
///    Protseq = Pointer to a string identifier of the protocol sequence to register with the RPC run-time library.
///    MaxCalls = Backlog queue length for the <b>ncacn_ip_tcp</b> protocol sequence. All other protocol sequences ignore this
///               parameter. Use RPC_C_PROTSEQ_MAX_REQS_DEFAULT to specify the default value. See Remarks.
///    IfSpec = Interface containing endpoint information to use in creating a binding for the protocol sequence specified in the
///             <i>Protseq</i> parameter.
///    SecurityDescriptor = Pointer to an optional parameter provided for the security subsystem. Used only for <b>ncacn_np</b> and
///                         <b>ncalrpc</b> protocol sequences. All other protocol sequences ignore this parameter. Using a security
///                         descriptor on the endpoint in order to make a server secure is not recommended. This parameter does not appear in
///                         the DCE specification for this API.
///    Policy = Pointer to the RPC_POLICY structure, which contains flags to restrict port allocation for dynamic ports and that
///             allow multihomed computers to selectively bind to network interface cards.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_PROTSEQ_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The endpoint for this protocol sequence is
///    not specified in the IDL file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> The protocol sequence is not supported on this host. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_INVALID_RPC_PROTSEQ</b></dt> </dl> </td> <td width="60%"> The protocol sequence is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_ENDPOINT_FORMAT</b></dt> </dl> </td> <td
///    width="60%"> The endpoint format is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is out of memory. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>RPC_S_INVALID_SECURITY_DESC</b></dt> </dl> </td> <td width="60%"> The security
///    descriptor is invalid. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see
///    RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerUseProtseqIfExW(ushort* Protseq, uint MaxCalls, void* IfSpec, void* SecurityDescriptor, 
                             RPC_POLICY* Policy);

@DllImport("RPCRT4")
void RpcServerYield();

///The <b>RpcMgmtStatsVectorFree</b> function frees a statistics vector.
///Params:
///    StatsVector = Pointer to a pointer to a statistics vector. On return, the pointer is set to <b>NULL</b>.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcMgmtStatsVectorFree(RPC_STATS_VECTOR** StatsVector);

///The <b>RpcMgmtInqStats</b> function returns RPC run-time statistics.
///Params:
///    Binding = To receive statistics about a remote application, specify a server binding handle for that application. To
///              receive statistics about your own (local) application, specify a value of <b>NULL</b>.
///    Statistics = Returns a pointer to a pointer to the statistics about the server specified by the <i>Binding</i> parameter. Each
///                 statistic is an <b>unsigned long</b> value.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid
///    error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcMgmtInqStats(void* Binding, RPC_STATS_VECTOR** Statistics);

///The <b>RpcMgmtIsServerListening</b> function tells whether a server is listening for remote procedure calls.
///Params:
///    Binding = To determine whether a remote application is listening for remote procedure calls, specify a server binding
///              handle for that application. To determine whether your own (local) application is listening for remote procedure
///              calls, specify a value of <b>NULL</b>.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> Server listening for remote procedure calls. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NOT_LISTENING</b></dt> </dl> </td> <td width="60%"> Server not listening for remote procedure calls,
///    or the interface is auto-listening. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt>
///    </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the wrong kind of binding for
///    the operation. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC
///    Return Values.</div> <div> </div> <div> </div> The <b>RpcMgmtIsServerListening</b> function returns correct
///    results only for interfaces that are not auto-listening. If the server application is auto-listening and calls
///    the <b>RpcMgmtIsServerListening</b> function, <b>RpcMgmtIsServerListening</b> returns RPC_SERVER_NOT_LISTENING,
///    yet the server may be listening, and subsequent RPC calls may succeed.
///    
@DllImport("RPCRT4")
int RpcMgmtIsServerListening(void* Binding);

///The <b>RpcMgmtStopServerListening</b> function tells a server to stop listening for remote procedure calls. This
///function will not affect auto-listen interfaces. See RpcServerRegisterIfEx for more details.
///Params:
///    Binding = To direct a remote application to stop listening for remote procedure calls, specify a server binding handle for
///              that application. To direct your own (local) application to stop listening for remote procedure calls, specify a
///              value of <b>NULL</b>.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid
///    error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcMgmtStopServerListening(void* Binding);

///The <b>RpcMgmtWaitServerListen</b> function performs the <i>wait</i> operation usually associated with
///RpcServerListen.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> All remote procedure calls are complete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ALREADY_LISTENING</b></dt> </dl> </td> <td width="60%"> Another thread has called
///    <b>RpcMgmtWaitServerListen</b> and has not yet returned. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NOT_LISTENING</b></dt> </dl> </td> <td width="60%"> The server application must call RpcServerListen
///    before calling <b>RpcMgmtWaitServerListen</b>. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcMgmtWaitServerListen();

///The <b>RpcMgmtSetServerStackSize</b> function specifies the stack size for server threads created by the RPC run
///time.
///Params:
///    ThreadStackSize = Stack size allocated for each thread created by the RPC run time, in bytes. This value is applied to all threads
///                      created for the server, but not to threads already created. Select this value based on the stack requirements of
///                      the remote procedures offered by the server.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> The argument was invalid. </td> </tr> </table>
///    <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcMgmtSetServerStackSize(uint ThreadStackSize);

///The <b>RpcSsDontSerializeContext</b> function disables run-time serialization of multiple calls dispatched to
///server-manager routines on the same context handle. Use of this function is not recommended. Developers should use
///mixed mode–content handle serialization instead. The See Also section provides links to more appropriate functions.
@DllImport("RPCRT4")
void RpcSsDontSerializeContext();

///The <b>RpcMgmtEnableIdleCleanup</b> function enables RPC to close idle resources, such as network connections, on the
///client.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_OUT_OF_THREADS</b></dt> </dl> </td> <td width="60%"> Out of threads. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_OUT_OF_RESOURCES</b></dt> </dl> </td> <td width="60%"> Out of resources. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> Out of memory.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcMgmtEnableIdleCleanup();

///The <b>RpcMgmtInqIfIds</b> function returns a vector containing the identifiers of the interfaces offered by the
///server.
///Params:
///    Binding = To receive interface identifiers about a remote application, specify a server binding handle for that
///              application. To receive interface information about your own application, specify a value of <b>NULL</b>.
///    IfIdVector = Returns the address of an interface identifier vector.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid
///    error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcMgmtInqIfIds(void* Binding, RPC_IF_ID_VECTOR** IfIdVector);

///The <b>RpcIfIdVectorFree</b> function frees the vector and the interface-identification structures contained in the
///vector.
///Params:
///    IfIdVector = Address of a pointer to a vector of interface information. On return, the pointer is set to <b>NULL</b>.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> The argument was invalid. </td> </tr> </table>
///    <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcIfIdVectorFree(RPC_IF_ID_VECTOR** IfIdVector);

///The <b>RpcMgmtInqServerPrincName</b> function returns a server's principal name.
///Params:
///    Binding = To receive the principal name for a server, specify a server binding handle for that server. To receive the
///              principal name for your own (local) application, specify a value of <b>NULL</b>.
///    AuthnSvc = Authentication service for which a principal name is returned. Valid values are the constant for any valid
///               security provider.
///    ServerPrincName = Returns a principal name that is registered for the authentication service in <i>AuthnSvc</i> by the server
///                      referenced in <i>Binding</i>. If multiple names are registered, only one name is returned.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid
///    error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcMgmtInqServerPrincNameA(void* Binding, uint AuthnSvc, ubyte** ServerPrincName);

///The <b>RpcMgmtInqServerPrincName</b> function returns a server's principal name.
///Params:
///    Binding = To receive the principal name for a server, specify a server binding handle for that server. To receive the
///              principal name for your own (local) application, specify a value of <b>NULL</b>.
///    AuthnSvc = Authentication service for which a principal name is returned. Valid values are the constant for any valid
///               security provider.
///    ServerPrincName = Returns a principal name that is registered for the authentication service in <i>AuthnSvc</i> by the server
///                      referenced in <i>Binding</i>. If multiple names are registered, only one name is returned.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid
///    error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcMgmtInqServerPrincNameW(void* Binding, uint AuthnSvc, ushort** ServerPrincName);

///The <b>RpcServerInqDefaultPrincName</b> function obtains the default principal name for a given authentication
///service.
///Params:
///    AuthnSvc = Authentication service to use when the server receives a request for a remote procedure call.
///    PrincName = Upon success, contains the default principal name for the given authentication service as specified by the
///                <i>AuthnSvc</i> parameter. The authentication service in use defines the content of the name and its syntax. This
///                principal name must be used as the <i>ServerPrincName</i> parameter of the RpcServerRegisterAuthInfo function. If
///                the function succeeds, <i>PrincName</i> must be freed using the RpcStringFree function. If the function fails,
///                the contents of <i>PrincName</i> is undefined and the caller has no obligation to free it.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> There is insufficient memory to complete the
///    operation. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return
///    Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerInqDefaultPrincNameA(uint AuthnSvc, ubyte** PrincName);

///The <b>RpcServerInqDefaultPrincName</b> function obtains the default principal name for a given authentication
///service.
///Params:
///    AuthnSvc = Authentication service to use when the server receives a request for a remote procedure call.
///    PrincName = Upon success, contains the default principal name for the given authentication service as specified by the
///                <i>AuthnSvc</i> parameter. The authentication service in use defines the content of the name and its syntax. This
///                principal name must be used as the <i>ServerPrincName</i> parameter of the RpcServerRegisterAuthInfo function. If
///                the function succeeds, <i>PrincName</i> must be freed using the RpcStringFree function. If the function fails,
///                the contents of <i>PrincName</i> is undefined and the caller has no obligation to free it.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> There is insufficient memory to complete the
///    operation. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return
///    Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerInqDefaultPrincNameW(uint AuthnSvc, ushort** PrincName);

///The <b>RpcEpResolveBinding</b> function resolves a partially-bound server binding handle into a fully-bound server
///binding handle.
///Params:
///    Binding = Partially-bound server binding handle to resolve to a fully-bound server binding handle.
///    IfSpec = Stub-generated structure specifying the interface of interest.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid
///    error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcEpResolveBinding(void* Binding, void* IfSpec);

///The <b>RpcNsBindingInqEntryName</b> function returns the entry name from which the binding handle came. <div
///class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating systems.</div><div>
///</div>
///Params:
///    Binding = Binding handle whose name-service database entry name is returned.
///    EntryNameSyntax = Syntax used in <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Returns the address of a pointer to the name of the name-service database entry in which <i>Binding</i> was
///                found. Specify a null value to prevent <b>RpcNsBindingInqEntryName</b> from returning the <i>EntryName</i>
///                parameter. In this case, the application does not call the RpcStringFree function.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_NO_ENTRY_NAME</b></dt> </dl> </td> <td width="60%"> No entry name for
///    binding. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td
///    width="60%"> The name syntax is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is unsupported. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td> <td width="60%"> The name is
///    incomplete. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return
///    Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcNsBindingInqEntryNameA(void* Binding, uint EntryNameSyntax, ubyte** EntryName);

///The <b>RpcNsBindingInqEntryName</b> function returns the entry name from which the binding handle came. <div
///class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating systems.</div><div>
///</div>
///Params:
///    Binding = Binding handle whose name-service database entry name is returned.
///    EntryNameSyntax = Syntax used in <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Returns the address of a pointer to the name of the name-service database entry in which <i>Binding</i> was
///                found. Specify a null value to prevent <b>RpcNsBindingInqEntryName</b> from returning the <i>EntryName</i>
///                parameter. In this case, the application does not call the RpcStringFree function.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_NO_ENTRY_NAME</b></dt> </dl> </td> <td width="60%"> No entry name for
///    binding. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td
///    width="60%"> The name syntax is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is unsupported. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td> <td width="60%"> The name is
///    incomplete. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return
///    Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcNsBindingInqEntryNameW(void* Binding, uint EntryNameSyntax, ushort** EntryName);

///The <b>RpcBindingCreate</b> function creates a new fast RPC binding handle based on a supplied template.
///Params:
///    Template = RPC_BINDING_HANDLE_TEMPLATE structure that describes the binding handle to be created by this call. This data may
///               be overwritten during the call, so the API does not maintain a reference to this data. The caller must free the
///               memory used by this structure when the API returns.
///    Security = RPC_BINDING_HANDLE_SECURITY structure that describes the security options for this binding handle. This data may
///               be overwritten during the call, so the API does not maintain a reference to this data. The caller must free the
///               memory used by this structure when the API returns. This parameter is optional. If this parameter is set to
///               <b>NULL</b>, the default security settings for RPC_BINDING_HANDLE_SECURITY will be used.
///    Options = RPC_BINDING_HANDLE_OPTIONS structure that describes additional options for the binding handle. This data may be
///              overwritten during the call, so the API does not maintain a reference to this data. The caller must free the
///              memory used by this structure when the API returns. This parameter is optional. If this parameter is set to
///              <b>NULL</b>, the default options for RPC_BINDING_HANDLE_OPTIONS will be used.
///    Binding = RPC_BINDING_HANDLE structure that contains the newly-created binding handle. If this function did not return
///              RPC_S_OK, then the contents of this structure are undefined. For non-local RPC calls, this handle must be passed
///              to RpcBindingBind.
///Returns:
///    This function returns RPC_S_OK on success; otherwise, an RPC_S_* error code is returned. For information on these
///    error codes, see RPC Return Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl> </td> <td width="60%"> The binding handle was successfully
///    created. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_CANNOT_SUPPORT</b></dt> </dl> </td> <td width="60%">
///    An obsolete feature of RPC was requested for this binding handle. <div class="alert"><b>Note</b> The only
///    supported protocol sequences for this API is <b>ncalrpc</b>; choosing another protocol sequence results in the
///    return of this error status code.</div> <div> </div> </td> </tr> </table> <div class="alert"><b>Note</b> For a
///    list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingCreateA(RPC_BINDING_HANDLE_TEMPLATE_V1_A* Template, RPC_BINDING_HANDLE_SECURITY_V1_A* Security, 
                      RPC_BINDING_HANDLE_OPTIONS_V1* Options, void** Binding);

///The <b>RpcBindingCreate</b> function creates a new fast RPC binding handle based on a supplied template.
///Params:
///    Template = RPC_BINDING_HANDLE_TEMPLATE structure that describes the binding handle to be created by this call. This data may
///               be overwritten during the call, so the API does not maintain a reference to this data. The caller must free the
///               memory used by this structure when the API returns.
///    Security = RPC_BINDING_HANDLE_SECURITY structure that describes the security options for this binding handle. This data may
///               be overwritten during the call, so the API does not maintain a reference to this data. The caller must free the
///               memory used by this structure when the API returns. This parameter is optional. If this parameter is set to
///               <b>NULL</b>, the default security settings for RPC_BINDING_HANDLE_SECURITY will be used.
///    Options = RPC_BINDING_HANDLE_OPTIONS structure that describes additional options for the binding handle. This data may be
///              overwritten during the call, so the API does not maintain a reference to this data. The caller must free the
///              memory used by this structure when the API returns. This parameter is optional. If this parameter is set to
///              <b>NULL</b>, the default options for RPC_BINDING_HANDLE_OPTIONS will be used.
///    Binding = RPC_BINDING_HANDLE structure that contains the newly-created binding handle. If this function did not return
///              RPC_S_OK, then the contents of this structure are undefined. For non-local RPC calls, this handle must be passed
///              to RpcBindingBind.
///Returns:
///    This function returns RPC_S_OK on success; otherwise, an RPC_S_* error code is returned. For information on these
///    error codes, see RPC Return Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl> </td> <td width="60%"> The binding handle was successfully
///    created. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_CANNOT_SUPPORT</b></dt> </dl> </td> <td width="60%">
///    An obsolete feature of RPC was requested for this binding handle. <div class="alert"><b>Note</b> The only
///    supported protocol sequences for this API is <b>ncalrpc</b>; choosing another protocol sequence results in the
///    return of this error status code.</div> <div> </div> </td> </tr> </table> <div class="alert"><b>Note</b> For a
///    list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingCreateW(RPC_BINDING_HANDLE_TEMPLATE_V1_W* Template, RPC_BINDING_HANDLE_SECURITY_V1_W* Security, 
                      RPC_BINDING_HANDLE_OPTIONS_V1* Options, void** Binding);

///The <b>RpcServerInqBindingHandle</b> function obtains the binding handle for RPC calls serviced by the thread in
///which <b>RpcServerInqBindingHandle</b> is called.
///Params:
///    Binding = RPC_BINDING_HANDLE structure that, upon success, receives the binding handle for the call serviced by the thread
///              on which <b>RpcServerInqBindingHandle</b> is also called. If the call fails, this parameter is undefined.
///Returns:
///    This function returns RPC_S_OK on success; otherwise, an RPC_S_* error code is returned. This function cannot
///    fail unless it is called on a thread that is not currently servicing an RPC call. <div class="alert"><b>Note</b>
///    For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerInqBindingHandle(void** Binding);

///A server thread that is processing client remote procedure calls can call the <b>RpcImpersonateClient</b> function to
///impersonate the active client.
///Params:
///    BindingHandle = Binding handle on the server that represents a binding to a client. The server impersonates the client indicated
///                    by this handle. If a value of zero is specified, the server impersonates the client that is being served by this
///                    server thread.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_CALL_ACTIVE</b></dt> </dl> </td> <td width="60%"> No client is active on this server thread.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_CANNOT_SUPPORT</b></dt> </dl> </td> <td width="60%"> The
///    function is not supported for either the operating system, the transport, or this security subsystem. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle
///    was invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td
///    width="60%"> This was the wrong kind of binding for the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_CONTEXT_AVAILABLE</b></dt> </dl> </td> <td width="60%"> The server does not have permission to
///    impersonate the client. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see
///    RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcImpersonateClient(void* BindingHandle);

@DllImport("RPCRT4")
int RpcImpersonateClient2(void* BindingHandle);

///The <b>RpcRevertToSelfEx</b> function allows a server to impersonate a client and then revert in a multithreaded
///operation where the call to impersonate a client can come from a thread other than the thread originally dispatched
///from the RPC.
///Params:
///    BindingHandle = Binding handle on the server that represents a binding to the client that the server impersonated. A value of
///                    zero specifies the client handle of the current thread; in this case, the functionality of
///                    <b>RpcRevertToSelfEx</b> is identical to that of the RpcRevertToSelf function.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_CALL_ACTIVE</b></dt> </dl> </td> <td width="60%"> The server does not have a client to
///    impersonate. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td
///    width="60%"> The binding handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This is the wrong kind of binding for
///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_CANNOT_SUPPORT</b></dt> </dl> </td> <td
///    width="60%"> The call is not supported for this operating system, this transport, or this security subsystem.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcRevertToSelfEx(void* BindingHandle);

///After calling RpcImpersonateClient and completing any tasks that require client impersonation, the server calls
///<b>RpcRevertToSelf</b> to end impersonation and to reestablish its own security identity.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_CALL_ACTIVE</b></dt> </dl> </td> <td width="60%"> The server does not have a client to
///    impersonate. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td
///    width="60%"> The binding handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This is the wrong kind of binding for
///    this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_CANNOT_SUPPORT</b></dt> </dl> </td> <td
///    width="60%"> The call is not supported for this operating system, this transport, or this security subsystem.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcRevertToSelf();

///<p class="CCE_Message">[RpcImpersonateClientContainer is not supported and may be altered or unavailable in the
///future.] RpcImpersonateClientContainer may be altered or unavailable.
///Params:
///    BindingHandle = Reserved.
///Returns:
///    Reserved.
///    
@DllImport("RPCRT4")
int RpcImpersonateClientContainer(void* BindingHandle);

///<p class="CCE_Message">[RpcRevertContainerImpersonation is not supported and may be altered or unavailable in the
///future.] RpcRevertContainerImpersonation may be altered or unavailable.
///Returns:
///    Reserved.
///    
@DllImport("RPCRT4")
int RpcRevertContainerImpersonation();

///A server application calls the <b>RpcBindingInqAuthClient</b> function to obtain the principal name or privilege
///attributes of the authenticated client that made the remote procedure call.
///Params:
///    ClientBinding = Client binding handle of the client that made the remote procedure call. This value can be zero. See Remarks.
///    Privs = Returns a pointer to a handle to the privileged information for the client application that made the remote
///            procedure call on the <i>ClientBinding</i> binding handle. For <b>ncalrpc</b> calls, <i>Privs</i> contains a
///            string with the client's principal name. The data referenced by this parameter is read-only and should not be
///            modified by the server application. If the server wants to preserve any of the returned data, the server must
///            copy the data into server-allocated memory. The data that the <i>Privs</i> parameter points to comes directly
///            from the SSP. Therefore, the format of the data is specific to the SSP. For more information on SSPs, see
///            Security Support Providers (SSPs).
///    ServerPrincName = Returns a pointer to a pointer to the server principal name specified by the server application that called the
///                      RpcServerRegisterAuthInfo function. The content of the returned name and its syntax are defined by the
///                      authentication service in use. For the SCHANNEL SSP, the principal name is in Microsoft-standard (msstd) format.
///                      For further information on msstd format, see Principal Names. Specify a null value to prevent
///                      <b>RpcBindingInqAuthClient</b> from returning the <i>ServerPrincName</i> parameter. In this case, the application
///                      does not call the RpcStringFree function.
///    AuthnLevel = Returns a pointer set to the level of authentication requested by the client application that made the remote
///                 procedure call on the <i>ClientBinding</i> binding handle. Specify a null value to prevent
///                 <b>RpcBindingInqAuthClient</b> from returning the <i>AuthnLevel</i> parameter.
///    AuthnSvc = Returns a pointer set to the authentication service requested by the client application that made the remote
///               procedure call on the <i>ClientBinding</i> binding handle. For a list of the RPC-supported authentication levels,
///               see Authentication-Level Constants. Specify a null value to prevent <b>RpcBindingInqAuthClient</b> from returning
///               the <i>AuthnSvc</i> parameter.
///    AuthzSvc = Returns a pointer set to the authorization service requested by the client application that made the remote
///               procedure call on the <i>ClientBinding</i> binding handle. Specify a null value to prevent
///               <b>RpcBindingInqAuthClient</b> from returning the <i>AuthzSvc</i> parameter. This parameter is not used by the
///               RPC_C_AUTHN_WINNT authentication service. The returned value will always be RPC_C_AUTHZ_NONE.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_BINDING_HAS_NO_AUTH</b></dt> </dl> </td> <td width="60%"> Binding has no authentication information.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingInqAuthClientA(void* ClientBinding, void** Privs, ubyte** ServerPrincName, uint* AuthnLevel, 
                             uint* AuthnSvc, uint* AuthzSvc);

///A server application calls the <b>RpcBindingInqAuthClient</b> function to obtain the principal name or privilege
///attributes of the authenticated client that made the remote procedure call.
///Params:
///    ClientBinding = Client binding handle of the client that made the remote procedure call. This value can be zero. See Remarks.
///    Privs = Returns a pointer to a handle to the privileged information for the client application that made the remote
///            procedure call on the <i>ClientBinding</i> binding handle. For <b>ncalrpc</b> calls, <i>Privs</i> contains a
///            string with the client's principal name. The data referenced by this parameter is read-only and should not be
///            modified by the server application. If the server wants to preserve any of the returned data, the server must
///            copy the data into server-allocated memory. The data that the <i>Privs</i> parameter points to comes directly
///            from the SSP. Therefore, the format of the data is specific to the SSP. For more information on SSPs, see
///            Security Support Providers (SSPs).
///    ServerPrincName = Returns a pointer to a pointer to the server principal name specified by the server application that called the
///                      RpcServerRegisterAuthInfo function. The content of the returned name and its syntax are defined by the
///                      authentication service in use. For the SCHANNEL SSP, the principal name is in Microsoft-standard (msstd) format.
///                      For further information on msstd format, see Principal Names. Specify a null value to prevent
///                      <b>RpcBindingInqAuthClient</b> from returning the <i>ServerPrincName</i> parameter. In this case, the application
///                      does not call the RpcStringFree function.
///    AuthnLevel = Returns a pointer set to the level of authentication requested by the client application that made the remote
///                 procedure call on the <i>ClientBinding</i> binding handle. Specify a null value to prevent
///                 <b>RpcBindingInqAuthClient</b> from returning the <i>AuthnLevel</i> parameter.
///    AuthnSvc = Returns a pointer set to the authentication service requested by the client application that made the remote
///               procedure call on the <i>ClientBinding</i> binding handle. For a list of the RPC-supported authentication levels,
///               see Authentication-Level Constants. Specify a null value to prevent <b>RpcBindingInqAuthClient</b> from returning
///               the <i>AuthnSvc</i> parameter.
///    AuthzSvc = Returns a pointer set to the authorization service requested by the client application that made the remote
///               procedure call on the <i>ClientBinding</i> binding handle. Specify a null value to prevent
///               <b>RpcBindingInqAuthClient</b> from returning the <i>AuthzSvc</i> parameter. This parameter is not used by the
///               RPC_C_AUTHN_WINNT authentication service. The returned value will always be RPC_C_AUTHZ_NONE.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_BINDING_HAS_NO_AUTH</b></dt> </dl> </td> <td width="60%"> Binding has no authentication information.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingInqAuthClientW(void* ClientBinding, void** Privs, ushort** ServerPrincName, uint* AuthnLevel, 
                             uint* AuthnSvc, uint* AuthzSvc);

///A server application calls the <b>RpcBindingInqAuthClientEx</b> function to obtain extended information about the
///client program that made the remote procedure call.
///Params:
///    ClientBinding = Client binding handle of the client that made the remote procedure call. This value can be zero. See Remarks.
///    Privs = Returns a pointer to a handle to the privileged information for the client application that made the remote
///            procedure call on the <i>ClientBinding</i> binding handle. For <b>ncalrpc</b> calls, <i>Privs</i> contains a
///            string with the client's principal name. The server application must cast the <i>Privs</i> parameter to the data
///            type specified by the <i>AuthnSvc</i> parameter. The data referenced by this argument is read-only and should not
///            be modified by the server application. If the server wants to preserve any of the returned data, the server must
///            copy the data into server-allocated memory. For more information on SSPs, see Security Support Providers (SSPs).
///    ServerPrincName = Returns a pointer to a pointer to the server principal name specified by the server application that called the
///                      RpcServerRegisterAuthInfo function. The content of the returned name and its syntax are defined by the
///                      authentication service in use. For the SCHANNEL SSP, the principal name is in msstd format. For further
///                      information on msstd format, see Principal Names. Specify a null value to prevent
///                      <b>RpcBindingInqAuthClientEx</b> from returning the <i>ServerPrincName</i> parameter. In this case, the
///                      application does not call the RpcStringFree function.
///    AuthnLevel = Returns a pointer set to the level of authentication requested by the client application that made the remote
///                 procedure call on the <i>ClientBinding</i> binding handle. For a list of the RPC-supported authentication levels,
///                 see Authentication-Level Constants. Specify a null value to prevent <b>RpcBindingInqAuthClientEx</b> from
///                 returning the <i>AuthnLevel</i> parameter.
///    AuthnSvc = Returns a pointer set to the authentication service requested by the client application that made the remote
///               procedure call on the <i>ClientBinding</i> binding handle. For a list of the RPC-supported authentication
///               services, see Authentication-Service Constants. Specify a null value to prevent <b>RpcBindingInqAuthClientEx</b>
///               from returning the <i>AuthnSvc</i> parameter. <div class="alert"><b>Note</b> <i>AuthnSvc</i> corresponds to the
///               <b>SECURITY_STATUS</b> returned by QueryContextAttributes on each certificate-based SSP for
///               <b>SECPKG_ATTR_DCE_INFO</b> or<b> SECPKG_ATTR_REMOTE_CERT_CONTEXT</b>.</div> <div> </div>
///    AuthzSvc = Returns a pointer set to the authorization service requested by the client application that made the remote
///               procedure call on the <i>Binding</i> binding handle. For a list of the RPC-supported authorization services, see
///               Authorization-Service Constants . Specify a null value to prevent <b>RpcBindingInqAuthClientEx</b> from returning
///               the <i>AuthzSvc</i> parameter. This parameter is not used by the RPC_C_AUTHN_WINNT authentication service. The
///               returned value will always be RPC_S_AUTHZ_NONE.
///    Flags = Controls the format of the principal name. This parameter can be set to the following value. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RPC_C_FULL_CERT_CHAIN"></a><a
///            id="rpc_c_full_cert_chain"></a><dl> <dt><b>RPC_C_FULL_CERT_CHAIN</b></dt> </dl> </td> <td width="60%"> Passes
///            back the principal name in fullsic format. </td> </tr> </table>
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_BINDING_HAS_NO_AUTH</b></dt> </dl> </td> <td width="60%"> Binding has no authentication information.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingInqAuthClientExA(void* ClientBinding, void** Privs, ubyte** ServerPrincName, uint* AuthnLevel, 
                               uint* AuthnSvc, uint* AuthzSvc, uint Flags);

///A server application calls the <b>RpcBindingInqAuthClientEx</b> function to obtain extended information about the
///client program that made the remote procedure call.
///Params:
///    ClientBinding = Client binding handle of the client that made the remote procedure call. This value can be zero. See Remarks.
///    Privs = Returns a pointer to a handle to the privileged information for the client application that made the remote
///            procedure call on the <i>ClientBinding</i> binding handle. For <b>ncalrpc</b> calls, <i>Privs</i> contains a
///            string with the client's principal name. The server application must cast the <i>Privs</i> parameter to the data
///            type specified by the <i>AuthnSvc</i> parameter. The data referenced by this argument is read-only and should not
///            be modified by the server application. If the server wants to preserve any of the returned data, the server must
///            copy the data into server-allocated memory. For more information on SSPs, see Security Support Providers (SSPs).
///    ServerPrincName = Returns a pointer to a pointer to the server principal name specified by the server application that called the
///                      RpcServerRegisterAuthInfo function. The content of the returned name and its syntax are defined by the
///                      authentication service in use. For the SCHANNEL SSP, the principal name is in msstd format. For further
///                      information on msstd format, see Principal Names. Specify a null value to prevent
///                      <b>RpcBindingInqAuthClientEx</b> from returning the <i>ServerPrincName</i> parameter. In this case, the
///                      application does not call the RpcStringFree function.
///    AuthnLevel = Returns a pointer set to the level of authentication requested by the client application that made the remote
///                 procedure call on the <i>ClientBinding</i> binding handle. For a list of the RPC-supported authentication levels,
///                 see Authentication-Level Constants. Specify a null value to prevent <b>RpcBindingInqAuthClientEx</b> from
///                 returning the <i>AuthnLevel</i> parameter.
///    AuthnSvc = Returns a pointer set to the authentication service requested by the client application that made the remote
///               procedure call on the <i>ClientBinding</i> binding handle. For a list of the RPC-supported authentication
///               services, see Authentication-Service Constants. Specify a null value to prevent <b>RpcBindingInqAuthClientEx</b>
///               from returning the <i>AuthnSvc</i> parameter. <div class="alert"><b>Note</b> <i>AuthnSvc</i> corresponds to the
///               <b>SECURITY_STATUS</b> returned by QueryContextAttributes on each certificate-based SSP for
///               <b>SECPKG_ATTR_DCE_INFO</b> or<b> SECPKG_ATTR_REMOTE_CERT_CONTEXT</b>.</div> <div> </div>
///    AuthzSvc = Returns a pointer set to the authorization service requested by the client application that made the remote
///               procedure call on the <i>Binding</i> binding handle. For a list of the RPC-supported authorization services, see
///               Authorization-Service Constants . Specify a null value to prevent <b>RpcBindingInqAuthClientEx</b> from returning
///               the <i>AuthzSvc</i> parameter. This parameter is not used by the RPC_C_AUTHN_WINNT authentication service. The
///               returned value will always be RPC_S_AUTHZ_NONE.
///    Flags = Controls the format of the principal name. This parameter can be set to the following value. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RPC_C_FULL_CERT_CHAIN"></a><a
///            id="rpc_c_full_cert_chain"></a><dl> <dt><b>RPC_C_FULL_CERT_CHAIN</b></dt> </dl> </td> <td width="60%"> Passes
///            back the principal name in fullsic format. </td> </tr> </table>
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_BINDING_HAS_NO_AUTH</b></dt> </dl> </td> <td width="60%"> Binding has no authentication information.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingInqAuthClientExW(void* ClientBinding, void** Privs, ushort** ServerPrincName, uint* AuthnLevel, 
                               uint* AuthnSvc, uint* AuthzSvc, uint Flags);

///The <b>RpcBindingInqAuthInfo</b> function returns authentication and authorization information from a binding handle.
///Params:
///    Binding = Server binding handle from which authentication and authorization information is returned.
///    ServerPrincName = Returns a pointer to a pointer to the expected principal name of the server referenced in <i>Binding</i>. The
///                      content of the returned name and its syntax are defined by the authentication service in use. Specify a null
///                      value to prevent <b>RpcBindingInqAuthInfo</b> from returning the <i>ServerPrincName</i> parameter. In this case,
///                      the application does not call the RpcStringFree function.
///    AuthnLevel = Returns a pointer set to the level of authentication used for remote procedure calls made using <i>Binding</i>.
///                 See Note. Specify a null value to prevent the function from returning the <i>AuthnLevel</i> parameter. The level
///                 returned in the <i>AuthnLevel</i> parameter may be different from the level specified when the client called the
///                 RpcBindingSetAuthInfo function. This discrepancy occurs when the RPC run-time library does not support the
///                 authentication level specified by the client and automatically upgrades to the next higher authentication level.
///    AuthnSvc = Returns a pointer set to the authentication service specified for remote procedure calls made using
///               <i>Binding</i>. See Note. Specify a null value to prevent <b>RpcBindingInqAuthInfo</b> from returning the
///               <i>AuthnSvc</i> parameter.
///    AuthIdentity = Returns a pointer to a handle to the data structure that contains the client's authentication and authorization
///                   credentials specified for remote procedure calls made using <i>Binding</i>. Specify a null value to prevent
///                   <b>RpcBindingInqAuthInfo</b> from returning the <i>AuthIdentity</i> parameter.
///    AuthzSvc = Returns a pointer set to the authorization service requested by the client application that made the remote
///               procedure call on <i>Binding</i> See Note. Specify a null value to prevent <b>RpcBindingInqAuthInfo</b> from
///               returning the <i>AuthzSvc</i> parameter. <div class="alert"><b>Note</b> For a list of the RPC-supported
///               authentication services, see Authentication-Service Constants.</div> <div> </div>
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_BINDING_HAS_NO_AUTH</b></dt> </dl> </td> <td width="60%"> Binding has no authentication information.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingInqAuthInfoA(void* Binding, ubyte** ServerPrincName, uint* AuthnLevel, uint* AuthnSvc, 
                           void** AuthIdentity, uint* AuthzSvc);

///The <b>RpcBindingInqAuthInfo</b> function returns authentication and authorization information from a binding handle.
///Params:
///    Binding = Server binding handle from which authentication and authorization information is returned.
///    ServerPrincName = Returns a pointer to a pointer to the expected principal name of the server referenced in <i>Binding</i>. The
///                      content of the returned name and its syntax are defined by the authentication service in use. Specify a null
///                      value to prevent <b>RpcBindingInqAuthInfo</b> from returning the <i>ServerPrincName</i> parameter. In this case,
///                      the application does not call the RpcStringFree function.
///    AuthnLevel = Returns a pointer set to the level of authentication used for remote procedure calls made using <i>Binding</i>.
///                 See Note. Specify a null value to prevent the function from returning the <i>AuthnLevel</i> parameter. The level
///                 returned in the <i>AuthnLevel</i> parameter may be different from the level specified when the client called the
///                 RpcBindingSetAuthInfo function. This discrepancy occurs when the RPC run-time library does not support the
///                 authentication level specified by the client and automatically upgrades to the next higher authentication level.
///    AuthnSvc = Returns a pointer set to the authentication service specified for remote procedure calls made using
///               <i>Binding</i>. See Note. Specify a null value to prevent <b>RpcBindingInqAuthInfo</b> from returning the
///               <i>AuthnSvc</i> parameter.
///    AuthIdentity = Returns a pointer to a handle to the data structure that contains the client's authentication and authorization
///                   credentials specified for remote procedure calls made using <i>Binding</i>. Specify a null value to prevent
///                   <b>RpcBindingInqAuthInfo</b> from returning the <i>AuthIdentity</i> parameter.
///    AuthzSvc = Returns a pointer set to the authorization service requested by the client application that made the remote
///               procedure call on <i>Binding</i> See Note. Specify a null value to prevent <b>RpcBindingInqAuthInfo</b> from
///               returning the <i>AuthzSvc</i> parameter. <div class="alert"><b>Note</b> For a list of the RPC-supported
///               authentication services, see Authentication-Service Constants.</div> <div> </div>
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_BINDING_HAS_NO_AUTH</b></dt> </dl> </td> <td width="60%"> Binding has no authentication information.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingInqAuthInfoW(void* Binding, ushort** ServerPrincName, uint* AuthnLevel, uint* AuthnSvc, 
                           void** AuthIdentity, uint* AuthzSvc);

///The <b>RpcBindingSetAuthInfo</b> function sets a binding handle's authentication and authorization information.
///Params:
///    Binding = Server binding handle to which authentication and authorization information is to be applied.
///    ServerPrincName = Pointer to the expected principal name of the server referenced by <i>Binding</i>. The content of the name and
///                      its syntax are defined by the authentication service in use. <div class="alert"><b>Note</b> For the set of
///                      allowable target names for SSPs, please refer to the comments in the InitializeSecurityContext
///                      documentation.</div> <div> </div>
///    AuthnLevel = Level of authentication to be performed on remote procedure calls made using <i>Binding</i>. For a list of the
///                 RPC-supported authentication levels, see the list of Authentication-Level Constants.
///    AuthnSvc = Authentication service to use. See Note. Specify RPC_C_AUTHN_NONE to turn off authentication for remote procedure
///               calls made using <i>Binding</i>. If RPC_C_AUTHN_DEFAULT is specified, the RPC run-time library uses the
///               RPC_C_AUTHN_WINNT authentication service for remote procedure calls made using <i>Binding</i>.
///    AuthIdentity = Handle to the structure containing the client's authentication and authorization credentials appropriate for the
///                   selected authentication and authorization service.When using the RPC_C_AUTHN_WINNT authentication service
///                   <i>AuthIdentity</i> should be a pointer to a SEC_WINNT_AUTH_IDENTITY structure (defined in Rpcdce.h). Kerberos
///                   and Negotiate authentication services also use the <b>SEC_WINNT_AUTH_IDENTITY</b> structure. When you select the
///                   RPC_C_AUTHN_GSS_SCHANNEL authentication service, the <i>AuthIdentity</i> parameter should be a pointer to an
///                   <b>SCHANNEL_CRED</b> structure (defined in Schannel.h). Specify a null value to use the security login context
///                   for the current address space. Pass the value RPC_C_NO_CREDENTIALS to use an anonymous log-in context. <div
///                   class="alert"><b>Note</b> When selecting the RPC_C_AUTHN_GSS_SCHANNEL authentication service, the
///                   <i>AuthIdentity</i> parameter may also be a pointer to a <b>SCH_CRED</b> structure. However, in Windows XP and
///                   later releases of Windows, the only acceptable structure to be passed as the <i>AuthIdentity</i> parameter for
///                   the RPC_C_AUTHN_GSS_SCHANNEL authentication service is the <b>SCHANNEL_CRED</b> structure.</div> <div> </div>
///    AuthzSvc = Authorization service implemented by the server for the interface of interest. See Note. The validity and
///               trustworthiness of authorization data, like any application data, depends on the authentication service and
///               authentication level selected. This parameter is ignored when using the RPC_C_AUTHN_WINNT authentication service.
///               <div class="alert"><b>Note</b> For more information, see Authentication-Service Constants.</div> <div> </div>
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_UNKNOWN_AUTHN_SERVICE</b></dt> </dl> </td> <td width="60%"> Unknown authentication service. </td>
///    </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcBindingSetAuthInfoA(void* Binding, ubyte* ServerPrincName, uint AuthnLevel, uint AuthnSvc, 
                           void* AuthIdentity, uint AuthzSvc);

///The <b>RpcBindingSetAuthInfoEx</b> function sets a binding handle's authentication, authorization, and security
///quality-of-service information.
///Params:
///    Binding = Server binding handle into which authentication and authorization information is set.
///    ServerPrincName = Pointer to the expected principal name of the server referenced by <i>Binding</i>. The content of the name and
///                      its syntax are defined by the authentication service in use. <div class="alert"><b>Note</b> For the set of
///                      allowable target names for SSPs, please refer to the comments in the InitializeSecurityContext
///                      documentation.</div> <div> </div>
///    AuthnLevel = Level of authentication to be performed on remote procedure calls made using <i>Binding</i>. For a list of the
///                 RPC-supported authentication levels, see Authentication-Level Constants.
///    AuthnSvc = Authentication service to use. Specify RPC_C_AUTHN_NONE to turn off authentication for remote procedure calls
///               made using <i>Binding</i>. If RPC_C_AUTHN_DEFAULT is specified, the RPC run-time library uses the
///               RPC_C_AUTHN_WINNT authentication service for remote procedure calls made using <i>Binding</i>.
///    AuthIdentity = Handle for the structure that contains the client's authentication and authorization credentials appropriate for
///                   the selected authentication and authorization service. When using the RPC_C_AUTHN_WINNTauthentication service
///                   <i>AuthIdentity</i> should be a pointer to a SEC_WINNT_AUTH_IDENTITY structure (defined in Rpcdce.h). Kerberos
///                   and Negotiate authentication services also use the <b>SEC_WINNT_AUTH_IDENTITY</b> structure. Specify a null value
///                   to use the security login context for the current address space. Pass the value RPC_C_NO_CREDENTIALS to use an
///                   anonymous log-in context. Note that RPC_C_NO_CREDENTIALS is only valid if RPC_C_AUTHN_GSS_SCHANNEL is selected as
///                   the authentication service.
///    AuthzSvc = Authorization service implemented by the server for the interface of interest. The validity and trustworthiness
///               of authorization data, like any application data, depends on the authentication service and authentication level
///               selected. This parameter is ignored when using the RPC_C_AUTHN_WINNT authentication service. See Note.
///    SecurityQos = TBD
///    SecurityQOS = Pointer to the RPC_SECURITY_QOS structure, which defines the security quality-of-service. <div
///                  class="alert"><b>Note</b> For a list of the RPC-supported authentication services, see Authentication-Service
///                  Constants.</div> <div> </div>
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_UNKNOWN_AUTHN_SERVICE</b></dt> </dl> </td> <td width="60%"> Unknown authentication service. </td>
///    </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcBindingSetAuthInfoExA(void* Binding, ubyte* ServerPrincName, uint AuthnLevel, uint AuthnSvc, 
                             void* AuthIdentity, uint AuthzSvc, RPC_SECURITY_QOS* SecurityQos);

///The <b>RpcBindingSetAuthInfo</b> function sets a binding handle's authentication and authorization information.
///Params:
///    Binding = Server binding handle to which authentication and authorization information is to be applied.
///    ServerPrincName = Pointer to the expected principal name of the server referenced by <i>Binding</i>. The content of the name and
///                      its syntax are defined by the authentication service in use. <div class="alert"><b>Note</b> For the set of
///                      allowable target names for SSPs, please refer to the comments in the InitializeSecurityContext
///                      documentation.</div> <div> </div>
///    AuthnLevel = Level of authentication to be performed on remote procedure calls made using <i>Binding</i>. For a list of the
///                 RPC-supported authentication levels, see the list of Authentication-Level Constants.
///    AuthnSvc = Authentication service to use. See Note. Specify RPC_C_AUTHN_NONE to turn off authentication for remote procedure
///               calls made using <i>Binding</i>. If RPC_C_AUTHN_DEFAULT is specified, the RPC run-time library uses the
///               RPC_C_AUTHN_WINNT authentication service for remote procedure calls made using <i>Binding</i>.
///    AuthIdentity = Handle to the structure containing the client's authentication and authorization credentials appropriate for the
///                   selected authentication and authorization service.When using the RPC_C_AUTHN_WINNT authentication service
///                   <i>AuthIdentity</i> should be a pointer to a SEC_WINNT_AUTH_IDENTITY structure (defined in Rpcdce.h). Kerberos
///                   and Negotiate authentication services also use the <b>SEC_WINNT_AUTH_IDENTITY</b> structure. When you select the
///                   RPC_C_AUTHN_GSS_SCHANNEL authentication service, the <i>AuthIdentity</i> parameter should be a pointer to an
///                   <b>SCHANNEL_CRED</b> structure (defined in Schannel.h). Specify a null value to use the security login context
///                   for the current address space. Pass the value RPC_C_NO_CREDENTIALS to use an anonymous log-in context. <div
///                   class="alert"><b>Note</b> When selecting the RPC_C_AUTHN_GSS_SCHANNEL authentication service, the
///                   <i>AuthIdentity</i> parameter may also be a pointer to a <b>SCH_CRED</b> structure. However, in Windows XP and
///                   later releases of Windows, the only acceptable structure to be passed as the <i>AuthIdentity</i> parameter for
///                   the RPC_C_AUTHN_GSS_SCHANNEL authentication service is the <b>SCHANNEL_CRED</b> structure.</div> <div> </div>
///    AuthzSvc = Authorization service implemented by the server for the interface of interest. See Note. The validity and
///               trustworthiness of authorization data, like any application data, depends on the authentication service and
///               authentication level selected. This parameter is ignored when using the RPC_C_AUTHN_WINNT authentication service.
///               <div class="alert"><b>Note</b> For more information, see Authentication-Service Constants.</div> <div> </div>
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_UNKNOWN_AUTHN_SERVICE</b></dt> </dl> </td> <td width="60%"> Unknown authentication service. </td>
///    </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcBindingSetAuthInfoW(void* Binding, ushort* ServerPrincName, uint AuthnLevel, uint AuthnSvc, 
                           void* AuthIdentity, uint AuthzSvc);

///The <b>RpcBindingSetAuthInfoEx</b> function sets a binding handle's authentication, authorization, and security
///quality-of-service information.
///Params:
///    Binding = Server binding handle into which authentication and authorization information is set.
///    ServerPrincName = Pointer to the expected principal name of the server referenced by <i>Binding</i>. The content of the name and
///                      its syntax are defined by the authentication service in use. <div class="alert"><b>Note</b> For the set of
///                      allowable target names for SSPs, please refer to the comments in the InitializeSecurityContext
///                      documentation.</div> <div> </div>
///    AuthnLevel = Level of authentication to be performed on remote procedure calls made using <i>Binding</i>. For a list of the
///                 RPC-supported authentication levels, see Authentication-Level Constants.
///    AuthnSvc = Authentication service to use. Specify RPC_C_AUTHN_NONE to turn off authentication for remote procedure calls
///               made using <i>Binding</i>. If RPC_C_AUTHN_DEFAULT is specified, the RPC run-time library uses the
///               RPC_C_AUTHN_WINNT authentication service for remote procedure calls made using <i>Binding</i>.
///    AuthIdentity = Handle for the structure that contains the client's authentication and authorization credentials appropriate for
///                   the selected authentication and authorization service. When using the RPC_C_AUTHN_WINNTauthentication service
///                   <i>AuthIdentity</i> should be a pointer to a SEC_WINNT_AUTH_IDENTITY structure (defined in Rpcdce.h). Kerberos
///                   and Negotiate authentication services also use the <b>SEC_WINNT_AUTH_IDENTITY</b> structure. Specify a null value
///                   to use the security login context for the current address space. Pass the value RPC_C_NO_CREDENTIALS to use an
///                   anonymous log-in context. Note that RPC_C_NO_CREDENTIALS is only valid if RPC_C_AUTHN_GSS_SCHANNEL is selected as
///                   the authentication service.
///    AuthzSvc = Authorization service implemented by the server for the interface of interest. The validity and trustworthiness
///               of authorization data, like any application data, depends on the authentication service and authentication level
///               selected. This parameter is ignored when using the RPC_C_AUTHN_WINNT authentication service. See Note.
///    SecurityQOS = Pointer to the RPC_SECURITY_QOS structure, which defines the security quality-of-service. <div
///                  class="alert"><b>Note</b> For a list of the RPC-supported authentication services, see Authentication-Service
///                  Constants.</div> <div> </div>
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_UNKNOWN_AUTHN_SERVICE</b></dt> </dl> </td> <td width="60%"> Unknown authentication service. </td>
///    </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcBindingSetAuthInfoExW(void* Binding, ushort* ServerPrincName, uint AuthnLevel, uint AuthnSvc, 
                             void* AuthIdentity, uint AuthzSvc, RPC_SECURITY_QOS* SecurityQOS);

///The <b>RpcBindingInqAuthInfoEx</b> function returns authentication, authorization, and security quality-of-service
///information from a binding handle.
///Params:
///    Binding = Server binding handle from which authentication and authorization information is returned.
///    ServerPrincName = Returns a pointer to a pointer to the expected principal name of the server referenced in <i>Binding</i>. The
///                      content of the returned name and its syntax are defined by the authentication service in use. Specify a null
///                      value to prevent <b>RpcBindingInqAuthInfoEx</b> from returning the <i>ServerPrincName</i> parameter. In this
///                      case, the application does not call the RpcStringFree function.
///    AuthnLevel = Returns a pointer set to the level of authentication used for remote procedure calls made using <i>Binding</i>.
///                 For a list of the RPC-supported authentication levels, see Authentication-Level Constants. Specify a null value
///                 to prevent the function from returning the <i>AuthnLevel</i> parameter. The level returned in the
///                 <i>AuthnLevel</i> parameter may be different from the level specified when the client called the
///                 RpcBindingSetAuthInfoEx function. This discrepancy happens when the RPC run-time library does not support the
///                 authentication level specified by the client and automatically upgrades to the next higher authentication level.
///    AuthnSvc = Returns a pointer set to the authentication service specified for remote procedure calls made using
///               <i>Binding</i>. For a list of the RPC-supported authentication services, see Authentication-Service Constants.
///               Specify a null value to prevent <b>RpcBindingInqAuthInfoEx</b> from returning the <i>AuthnSvc</i> parameter.
///    AuthIdentity = Returns a pointer to a handle to the data structure that contains the client's authentication and authorization
///                   credentials specified for remote procedure calls made using <i>Binding</i>. Specify a null value to prevent
///                   <b>RpcBindingInqAuthInfoEx</b> from returning the <i>AuthIdentity</i> parameter.
///    AuthzSvc = Returns a pointer set to the authorization service requested by the client application that made the remote
///               procedure call on <i>Binding</i>. For a list of the RPC-supported authentication services, see
///               Authentication-Service Constants. Specify a null value to prevent <b>RpcBindingInqAuthInfoEx</b> from returning
///               the <i>AuthzSvc</i> parameter.
///    RpcQosVersion = Passes value of current version (needed for forward compatibility if extensions are made to this function).
///                    Always set this parameter to RPC_C_SECURITY_QOS_VERSION.
///    SecurityQOS = Returns pointer to the RPC_SECURITY_QOS structure, which defines quality-of-service settings.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_BINDING_HAS_NO_AUTH</b></dt> </dl> </td> <td width="60%"> Binding has no authentication information.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingInqAuthInfoExA(void* Binding, ubyte** ServerPrincName, uint* AuthnLevel, uint* AuthnSvc, 
                             void** AuthIdentity, uint* AuthzSvc, uint RpcQosVersion, RPC_SECURITY_QOS* SecurityQOS);

///The <b>RpcBindingInqAuthInfoEx</b> function returns authentication, authorization, and security quality-of-service
///information from a binding handle.
///Params:
///    Binding = Server binding handle from which authentication and authorization information is returned.
///    ServerPrincName = Returns a pointer to a pointer to the expected principal name of the server referenced in <i>Binding</i>. The
///                      content of the returned name and its syntax are defined by the authentication service in use. Specify a null
///                      value to prevent <b>RpcBindingInqAuthInfoEx</b> from returning the <i>ServerPrincName</i> parameter. In this
///                      case, the application does not call the RpcStringFree function.
///    AuthnLevel = Returns a pointer set to the level of authentication used for remote procedure calls made using <i>Binding</i>.
///                 For a list of the RPC-supported authentication levels, see Authentication-Level Constants. Specify a null value
///                 to prevent the function from returning the <i>AuthnLevel</i> parameter. The level returned in the
///                 <i>AuthnLevel</i> parameter may be different from the level specified when the client called the
///                 RpcBindingSetAuthInfoEx function. This discrepancy happens when the RPC run-time library does not support the
///                 authentication level specified by the client and automatically upgrades to the next higher authentication level.
///    AuthnSvc = Returns a pointer set to the authentication service specified for remote procedure calls made using
///               <i>Binding</i>. For a list of the RPC-supported authentication services, see Authentication-Service Constants.
///               Specify a null value to prevent <b>RpcBindingInqAuthInfoEx</b> from returning the <i>AuthnSvc</i> parameter.
///    AuthIdentity = Returns a pointer to a handle to the data structure that contains the client's authentication and authorization
///                   credentials specified for remote procedure calls made using <i>Binding</i>. Specify a null value to prevent
///                   <b>RpcBindingInqAuthInfoEx</b> from returning the <i>AuthIdentity</i> parameter.
///    AuthzSvc = Returns a pointer set to the authorization service requested by the client application that made the remote
///               procedure call on <i>Binding</i>. For a list of the RPC-supported authentication services, see
///               Authentication-Service Constants. Specify a null value to prevent <b>RpcBindingInqAuthInfoEx</b> from returning
///               the <i>AuthzSvc</i> parameter.
///    RpcQosVersion = Passes value of current version (needed for forward compatibility if extensions are made to this function).
///                    Always set this parameter to RPC_C_SECURITY_QOS_VERSION.
///    SecurityQOS = Returns pointer to the RPC_SECURITY_QOS structure, which defines quality-of-service settings.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_BINDING_HAS_NO_AUTH</b></dt> </dl> </td> <td width="60%"> Binding has no authentication information.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingInqAuthInfoExW(void* Binding, ushort** ServerPrincName, uint* AuthnLevel, uint* AuthnSvc, 
                             void** AuthIdentity, uint* AuthzSvc, uint RpcQosVersion, RPC_SECURITY_QOS* SecurityQOS);

///The <b>RpcServerCompleteSecurityCallback</b> function completes an asynchronous security callback. This function can
///cause the call either to be dispatched or fail.
///Params:
///    BindingHandle = The Server Call that this function dispatches or fails.
///    Status = Specifies an RPC status. If this value is not <b>RPC_S_OK</b>, the Server Call is failed with a value of
///             <b>RPC_S_ACCESS_DENIED</b>. <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return
///             Values.</div> <div> </div>
@DllImport("RPCRT4")
int RpcServerCompleteSecurityCallback(void* BindingHandle, int Status);

///The <b>RpcServerRegisterAuthInfo</b> function registers authentication information with the RPC run-time library.
///Params:
///    ServerPrincName = Pointer to the principal name to use for the server when authenticating remote procedure calls using the service
///                      specified by the <i>AuthnSvc</i> parameter. The content of the name and its syntax are defined by the
///                      authentication service in use. For more information, see Principal Names.
///    AuthnSvc = Authentication service to use when the server receives a request for a remote procedure call.
///    GetKeyFn = Address of a server-application-provided routine that returns encryption keys. See RPC_AUTH_KEY_RETRIEVAL_FN.
///               Specify a <b>NULL</b> parameter value to use the default method of encryption-key acquisition. In this case, the
///               authentication service specifies the default behavior. Set this parameter to <b>NULL</b> when using the
///               RPC_C_AUTHN_WINNT authentication service. <table> <tr> <th>Authentication service</th> <th>GetKeyFn</th>
///               <th>Arg</th> <th>Run-time behavior</th> </tr> <tr> <td>RPC_C_AUTHN_DPA</td> <td>Ignored</td> <td>Ignored</td>
///               <td>Does not support</td> </tr> <tr> <td>RPC_C_AUTHN_GSS_KERBEROS</td> <td>Ignored</td> <td>Ignored</td> <td>Does
///               not support</td> </tr> <tr> <td>RPC_C_AUTHN_GSS_NEGOTIATE</td> <td>Ignored</td> <td>Ignored</td> <td>Does not
///               support</td> </tr> <tr> <td>RPC_C_AUTHN_GSS_SCHANNEL</td> <td>Ignored</td> <td>Ignored</td> <td>Does not
///               support</td> </tr> <tr> <td>RPC_C_AUTHN_MQ</td> <td>Ignored</td> <td>Ignored</td> <td>Does not support</td> </tr>
///               <tr> <td>RPC_C_AUTHN_MSN</td> <td>Ignored</td> <td>Ignored</td> <td>Does not support</td> </tr> <tr>
///               <td>RPC_C_AUTHN_WINNT</td> <td>Ignored</td> <td>Ignored</td> <td>Does not support</td> </tr> <tr>
///               <td>RPC_C_AUTHN_DCE_PRIVATE</td> <td><b>NULL</b></td> <td>Non-<b>null</b></td> <td>Uses default method of
///               encryption-key acquisition from specified key table; specified argument is passed to default acquisition
///               function.</td> </tr> <tr> <td>RPC_C_AUTHN_DCE_PRIVATE</td> <td>Non-<b>null</b></td> <td><b>NULL</b></td> <td>Uses
///               specified encryption-key acquisition function to obtain keys from default key table.</td> </tr> <tr>
///               <td>RPC_C_AUTHN_DCE_PRIVATE</td> <td>Non-<b>null</b></td> <td>Non-<b>null</b></td> <td>Uses specified
///               encryption-key acquisition function to obtain keys from specified key table; specified argument is passed to
///               acquisition function.</td> </tr> <tr> <td>RPC_C_AUTHN_DEC_PUBLIC</td> <td>Ignored</td> <td>Ignored</td>
///               <td>Reserved for future use.</td> </tr> </table> <div> </div> The RPC run-time library passes the
///               <i>ServerPrincName</i> parameter value from <b>RpcServerRegisterAuthInfo</b> as the <i>ServerPrincName</i>
///               parameter value to the <i>GetKeyFn</i> acquisition function. The RPC run-time library automatically provides a
///               value for the key version (<i>KeyVer</i>) parameter. For a <i>KeyVer</i> parameter value of zero, the acquisition
///               function must return the most recent key available. The retrieval function returns the authentication key in the
///               <i>Key</i> parameter. If the acquisition function called from <b>RpcServerRegisterAuthInfo</b> returns a status
///               other than RPC_S_OK, then this function fails and returns an error code to the server application. If the
///               acquisition function called by the RPC run-time library while authenticating a client's remote procedure call
///               request returns a status other than RPC_S_OK, the request fails and the RPC run-time library returns an error
///               code to the client application.
///    Arg = Pointer to a parameter to pass to the <i>GetKeyFn</i> routine, if specified. This parameter can also be used to
///          pass a pointer to an SCHANNEL_CRED structure to specify explicit credentials if the authentication service is set
///          to SCHANNEL. If the <i>Arg</i> parameter is set to <b>NULL</b>, this function will use the default certificate or
///          credential if it has been set up in the directory service.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_UNKNOWN_AUTHN_SERVICE</b></dt> </dl> </td> <td width="60%"> The authentication service is unknown.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerRegisterAuthInfoA(ubyte* ServerPrincName, uint AuthnSvc, RPC_AUTH_KEY_RETRIEVAL_FN GetKeyFn, 
                               void* Arg);

///The <b>RpcServerRegisterAuthInfo</b> function registers authentication information with the RPC run-time library.
///Params:
///    ServerPrincName = Pointer to the principal name to use for the server when authenticating remote procedure calls using the service
///                      specified by the <i>AuthnSvc</i> parameter. The content of the name and its syntax are defined by the
///                      authentication service in use. For more information, see Principal Names.
///    AuthnSvc = Authentication service to use when the server receives a request for a remote procedure call.
///    GetKeyFn = Address of a server-application-provided routine that returns encryption keys. See RPC_AUTH_KEY_RETRIEVAL_FN.
///               Specify a <b>NULL</b> parameter value to use the default method of encryption-key acquisition. In this case, the
///               authentication service specifies the default behavior. Set this parameter to <b>NULL</b> when using the
///               RPC_C_AUTHN_WINNT authentication service. <table> <tr> <th>Authentication service</th> <th>GetKeyFn</th>
///               <th>Arg</th> <th>Run-time behavior</th> </tr> <tr> <td>RPC_C_AUTHN_DPA</td> <td>Ignored</td> <td>Ignored</td>
///               <td>Does not support</td> </tr> <tr> <td>RPC_C_AUTHN_GSS_KERBEROS</td> <td>Ignored</td> <td>Ignored</td> <td>Does
///               not support</td> </tr> <tr> <td>RPC_C_AUTHN_GSS_NEGOTIATE</td> <td>Ignored</td> <td>Ignored</td> <td>Does not
///               support</td> </tr> <tr> <td>RPC_C_AUTHN_GSS_SCHANNEL</td> <td>Ignored</td> <td>Ignored</td> <td>Does not
///               support</td> </tr> <tr> <td>RPC_C_AUTHN_MQ</td> <td>Ignored</td> <td>Ignored</td> <td>Does not support</td> </tr>
///               <tr> <td>RPC_C_AUTHN_MSN</td> <td>Ignored</td> <td>Ignored</td> <td>Does not support</td> </tr> <tr>
///               <td>RPC_C_AUTHN_WINNT</td> <td>Ignored</td> <td>Ignored</td> <td>Does not support</td> </tr> <tr>
///               <td>RPC_C_AUTHN_DCE_PRIVATE</td> <td><b>NULL</b></td> <td>Non-<b>null</b></td> <td>Uses default method of
///               encryption-key acquisition from specified key table; specified argument is passed to default acquisition
///               function.</td> </tr> <tr> <td>RPC_C_AUTHN_DCE_PRIVATE</td> <td>Non-<b>null</b></td> <td><b>NULL</b></td> <td>Uses
///               specified encryption-key acquisition function to obtain keys from default key table.</td> </tr> <tr>
///               <td>RPC_C_AUTHN_DCE_PRIVATE</td> <td>Non-<b>null</b></td> <td>Non-<b>null</b></td> <td>Uses specified
///               encryption-key acquisition function to obtain keys from specified key table; specified argument is passed to
///               acquisition function.</td> </tr> <tr> <td>RPC_C_AUTHN_DEC_PUBLIC</td> <td>Ignored</td> <td>Ignored</td>
///               <td>Reserved for future use.</td> </tr> </table> <div> </div> The RPC run-time library passes the
///               <i>ServerPrincName</i> parameter value from <b>RpcServerRegisterAuthInfo</b> as the <i>ServerPrincName</i>
///               parameter value to the <i>GetKeyFn</i> acquisition function. The RPC run-time library automatically provides a
///               value for the key version (<i>KeyVer</i>) parameter. For a <i>KeyVer</i> parameter value of zero, the acquisition
///               function must return the most recent key available. The retrieval function returns the authentication key in the
///               <i>Key</i> parameter. If the acquisition function called from <b>RpcServerRegisterAuthInfo</b> returns a status
///               other than RPC_S_OK, then this function fails and returns an error code to the server application. If the
///               acquisition function called by the RPC run-time library while authenticating a client's remote procedure call
///               request returns a status other than RPC_S_OK, the request fails and the RPC run-time library returns an error
///               code to the client application.
///    Arg = Pointer to a parameter to pass to the <i>GetKeyFn</i> routine, if specified. This parameter can also be used to
///          pass a pointer to an SCHANNEL_CRED structure to specify explicit credentials if the authentication service is set
///          to SCHANNEL. If the <i>Arg</i> parameter is set to <b>NULL</b>, this function will use the default certificate or
///          credential if it has been set up in the directory service.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_UNKNOWN_AUTHN_SERVICE</b></dt> </dl> </td> <td width="60%"> The authentication service is unknown.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerRegisterAuthInfoW(ushort* ServerPrincName, uint AuthnSvc, RPC_AUTH_KEY_RETRIEVAL_FN GetKeyFn, 
                               void* Arg);

///An application calls <b>RpcBindingServerFromClient</b> to convert a client binding handle into a partially-bound
///server binding handle.
///Params:
///    ClientBinding = Client binding handle to convert to a server binding handle. If a value of zero is specified, the server
///                    impersonates the client that is being served by this server thread. <div class="alert"><b>Note</b> This parameter
///                    cannot be <b>NULL</b> in Windows NT 4.0.</div> <div> </div>
///    ServerBinding = Returns a server binding handle.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This was the
///    wrong kind of binding for the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_CANNOT_SUPPORT</b></dt> </dl> </td> <td width="60%"> Cannot determine the client's host. See Remarks
///    for a list of supported protocol sequences. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingServerFromClient(void* ClientBinding, void** ServerBinding);

///Use the <b>RpcRaiseException</b> function to raise an exception. The function does not return to the caller.
///Params:
///    exception = Exception code for the exception.
///Returns:
///    This function does not return a value. <div class="alert"><b>Note</b> For a list of valid error codes, see RPC
///    Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
void RpcRaiseException(int exception);

///The <b>RpcTestCancel</b> function checks for a cancel indication.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call has been canceled. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other
///    values</b></dt> </dl> </td> <td width="60%"> The call has not been canceled. </td> </tr> </table> <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div> It is not
///    unusual for the <b>RpcTestCancel</b> function to return the value ERROR_ACCESS_DENIED. This indicates that the
///    remote procedure call has not been canceled.
///    
@DllImport("RPCRT4")
int RpcTestCancel();

///The server calls <b>RpcServerTestCancel</b> to test for client cancel requests.
///Params:
///    BindingHandle = Call to test for cancel commands. If a value of zero is specified, the server impersonates the client that is
///                    being served by this server thread.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call was canceled by the client. The server must still complete or abort the call.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NO_CALL_ACTIVE</b></dt> </dl> </td> <td width="60%"> There is
///    no active call on the current thread. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_CALL_IN_PROGRESS</b></dt> </dl> </td> <td width="60%"> The call was not canceled. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The handle is not valid.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerTestCancel(void* BindingHandle);

///The <b>RpcCancelThread</b> function cancels a thread. The <b>RpcCancelThread</b> function should not be used to
///cancel asynchronous RPC calls; instead, use the RpcAsyncCancelCall function to cancel an asynchronous RPC call.
///Params:
///    Thread = Handle of the thread to cancel.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Thread handle does not have privilege. Thread
///    handles must have THREAD_SET_CONTEXT set properly for the function to execute properly. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_CANNOT_SUPPORT</b></dt> </dl> </td> <td width="60%"> Called by an MS-DOS or
///    Windows 3.x client. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC
///    Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcCancelThread(void* Thread);

///The <b>RpcCancelThreadEx</b> function stops the execution of a thread. The <b>RpcCancelThreadEx</b> function should
///not be used to stop the execution of an asynchronous RPC call; instead, use the RpcAsyncCancelCall function to stop
///the execution of an asynchronous RPC call.
///Params:
///    Thread = Handle of the thread to cancel.
///    Timeout = Number of seconds to wait for the thread to be canceled before this function returns. To specify that a client
///              waits an indefinite amount of time, pass the value RPC_C_CANCEL_INFINITE_TIMEOUT.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Thread handle does not have privilege. Thread
///    handles must have THREAD_SET_CONTEXT set properly for the function to execute properly. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_CANNOT_SUPPORT</b></dt> </dl> </td> <td width="60%"> Called by an MS-DOS or
///    Windows 3.<i>x</i> client. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes,
///    see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcCancelThreadEx(void* Thread, int Timeout);

///The <b>UuidCreate</b> function creates a new UUID.
///Params:
///    Uuid = Returns a pointer to the created UUID.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_UUID_LOCAL_ONLY</b></dt> </dl> </td> <td width="60%"> The UUID is guaranteed to be unique to this
///    computer only. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_UUID_NO_ADDRESS</b></dt> </dl> </td> <td
///    width="60%"> Cannot get Ethernet or token-ring hardware address for this computer. </td> </tr> </table> <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int UuidCreate(GUID* Uuid);

///The <b>UuidCreateSequential</b> function creates a new UUID.
///Params:
///    Uuid = Returns a pointer to the created UUID.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_UUID_LOCAL_ONLY</b></dt> </dl> </td> <td width="60%"> The UUID is guaranteed to be unique to this
///    computer only. For more information please see: KB article 981080. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_UUID_NO_ADDRESS</b></dt> </dl> </td> <td width="60%"> Cannot get Ethernet or token-ring hardware
///    address for this computer. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes,
///    see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int UuidCreateSequential(GUID* Uuid);

///The <b>UuidToString</b> function converts a UUID to a string.
///Params:
///    Uuid = Pointer to a binary UUID.
///    StringUuid = Pointer to the null-terminated string into which the UUID specified in the <i>Uuid</i> parameter will be placed.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is out of memory. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int UuidToStringA(const(GUID)* Uuid, ubyte** StringUuid);

///The <b>UuidFromString</b> function converts a string to a UUID.
///Params:
///    StringUuid = Pointer to a string representation of a UUID.
///    Uuid = Returns a pointer to a UUID in binary form.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_STRING_UUID</b></dt> </dl> </td> <td width="60%"> The string UUID is invalid. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int UuidFromStringA(ubyte* StringUuid, GUID* Uuid);

///The <b>UuidToString</b> function converts a UUID to a string.
///Params:
///    Uuid = Pointer to a binary UUID.
///    StringUuid = Pointer to the null-terminated string into which the UUID specified in the <i>Uuid</i> parameter will be placed.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is out of memory. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int UuidToStringW(const(GUID)* Uuid, ushort** StringUuid);

///The <b>UuidFromString</b> function converts a string to a UUID.
///Params:
///    StringUuid = Pointer to a string representation of a UUID.
///    Uuid = Returns a pointer to a UUID in binary form.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_STRING_UUID</b></dt> </dl> </td> <td width="60%"> The string UUID is invalid. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int UuidFromStringW(ushort* StringUuid, GUID* Uuid);

///An application calls the <b>UuidCompare</b> function to compare two UUIDs and determine their order. The returned
///value gives the order.
///Params:
///    Uuid1 = Pointer to a UUID. This <b>UUID</b> is compared with the <b>UUID</b> specified in the <i>Uuid2</i> parameter.
///    Uuid2 = Pointer to a UUID. This <b>UUID</b> is compared with the <b>UUID</b> specified in the <i>Uuid1</i> parameter.
///    Status = Returns any errors that may occur, and will typically be set by the function to RPC_S_OK upon return.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>–1</b></dt> </dl> </td>
///    <td width="60%"> The <i>Uuid1</i> parameter is less than the <i>Uuid2</i> parameter. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>0</b></dt> </dl> </td> <td width="60%"> The <i>Uuid1</i> parameter is equal to the
///    <i>Uuid2</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>1</b></dt> </dl> </td> <td width="60%"> The
///    <i>Uuid1</i> parameter is greater than the <i>Uuid2</i> parameter. </td> </tr> </table> <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int UuidCompare(GUID* Uuid1, GUID* Uuid2, int* Status);

///The <b>UuidCreateNil</b> function creates a nil-valued UUID.
///Params:
///    NilUuid = Returns a nil-valued UUID.
///Returns:
///    Returns RPC_S_OK. <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int UuidCreateNil(GUID* NilUuid);

///An application calls the <b>UuidEqual</b> function to compare two UUIDs and determine whether they are equal.
///Params:
///    Uuid1 = Pointer to a UUID. This <b>UUID</b> is compared with the <b>UUID</b> specified in the <i>Uuid2</i> parameter.
///    Uuid2 = Pointer to a UUID. This <b>UUID</b> is compared with the <b>UUID</b> specified in the <i>Uuid1</i> parameter.
///    Status = Returns RPC_S_OK.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>TRUE</b></dt> </dl> </td>
///    <td width="60%"> The <i>Uuid1</i> parameter is equal to the <i>Uuid2</i> parameter. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> The <i>Uuid1</i> parameter is not equal to
///    the <i>Uuid2</i> parameter. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes,
///    see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int UuidEqual(GUID* Uuid1, GUID* Uuid2, int* Status);

///An application calls the <b>UuidHash</b> function to generate a hash value for a specified UUID.
///Params:
///    Uuid = UUID for which a hash value is created.
///    Status = Returns RPC_S_OK.
///Returns:
///    <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
ushort UuidHash(GUID* Uuid, int* Status);

///An application calls the <b>UuidIsNil</b> function to determine whether the specified UUID is a nil-valued
///<b>UUID</b>.
///Params:
///    Uuid = UUID to test for nil value.
///    Status = Returns RPC_S_OK.
///Returns:
///    <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int UuidIsNil(GUID* Uuid, int* Status);

///The <b>RpcEpRegisterNoReplace</b> function adds server-address information to the local endpoint-map database.
///Params:
///    IfSpec = Interface to register with the local endpoint-map database.
///    BindingVector = Pointer to a vector of binding handles over which the server can receive remote procedure calls.
///    UuidVector = Pointer to a vector of object UUIDs offered by the server. The server application constructs this vector. A null
///                 parameter value indicates there are no object UUIDs to register.
///    Annotation = Pointer to the character-string comment applied to each cross-product element added to the local endpoint-map
///                 database. The string can be up to 64 characters long, including the null-terminating character. Specify a null
///                 value or a null-terminated string ("\0") if there is no annotation string. The annotation string is used by
///                 applications for information only. RPC does not use this string to determine which server instance a client
///                 communicates with or to enumerate elements in the endpoint-map database.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_BINDINGS</b></dt> </dl> </td> <td width="60%"> No bindings. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This
///    was the wrong kind of binding for the operation. </td> </tr> </table> <div class="alert"><b>Note</b> For a list
///    of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcEpRegisterNoReplaceA(void* IfSpec, RPC_BINDING_VECTOR* BindingVector, UUID_VECTOR* UuidVector, 
                            ubyte* Annotation);

///The <b>RpcEpRegisterNoReplace</b> function adds server-address information to the local endpoint-map database.
///Params:
///    IfSpec = Interface to register with the local endpoint-map database.
///    BindingVector = Pointer to a vector of binding handles over which the server can receive remote procedure calls.
///    UuidVector = Pointer to a vector of object UUIDs offered by the server. The server application constructs this vector. A null
///                 parameter value indicates there are no object UUIDs to register.
///    Annotation = Pointer to the character-string comment applied to each cross-product element added to the local endpoint-map
///                 database. The string can be up to 64 characters long, including the null-terminating character. Specify a null
///                 value or a null-terminated string ("\0") if there is no annotation string. The annotation string is used by
///                 applications for information only. RPC does not use this string to determine which server instance a client
///                 communicates with or to enumerate elements in the endpoint-map database.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_BINDINGS</b></dt> </dl> </td> <td width="60%"> No bindings. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This
///    was the wrong kind of binding for the operation. </td> </tr> </table> <div class="alert"><b>Note</b> For a list
///    of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcEpRegisterNoReplaceW(void* IfSpec, RPC_BINDING_VECTOR* BindingVector, UUID_VECTOR* UuidVector, 
                            ushort* Annotation);

///The <b>RpcEpRegister</b> function adds to or replaces server address information in the local endpoint-map database.
///Params:
///    IfSpec = Interface to register with the local endpoint-map database.
///    BindingVector = Pointer to a vector of binding handles over which the server can receive remote procedure calls.
///    UuidVector = Pointer to a vector of object UUIDs offered by the server. The server application constructs this vector.A null
///                 argument value indicates there are no object UUIDs to register.
///    Annotation = Pointer to the character-string comment applied to each cross-product element added to the local endpoint-map
///                 database. The string can be up to 64 characters long, including the null terminating character. Specify a null
///                 value or a null-terminated string ("\0") if there is no annotation string. The annotation string is used by
///                 applications for information only. RPC does not use this string to determine which server instance a client
///                 communicates with or for enumerating elements in the endpoint-map database.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_BINDINGS</b></dt> </dl> </td> <td width="60%"> No bindings. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This
///    was the wrong kind of binding for the operation. </td> </tr> </table> <div class="alert"><b>Note</b> For a list
///    of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcEpRegisterA(void* IfSpec, RPC_BINDING_VECTOR* BindingVector, UUID_VECTOR* UuidVector, ubyte* Annotation);

///The <b>RpcEpRegister</b> function adds to or replaces server address information in the local endpoint-map database.
///Params:
///    IfSpec = Interface to register with the local endpoint-map database.
///    BindingVector = Pointer to a vector of binding handles over which the server can receive remote procedure calls.
///    UuidVector = Pointer to a vector of object UUIDs offered by the server. The server application constructs this vector.A null
///                 argument value indicates there are no object UUIDs to register.
///    Annotation = Pointer to the character-string comment applied to each cross-product element added to the local endpoint-map
///                 database. The string can be up to 64 characters long, including the null terminating character. Specify a null
///                 value or a null-terminated string ("\0") if there is no annotation string. The annotation string is used by
///                 applications for information only. RPC does not use this string to determine which server instance a client
///                 communicates with or for enumerating elements in the endpoint-map database.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_BINDINGS</b></dt> </dl> </td> <td width="60%"> No bindings. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This
///    was the wrong kind of binding for the operation. </td> </tr> </table> <div class="alert"><b>Note</b> For a list
///    of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcEpRegisterW(void* IfSpec, RPC_BINDING_VECTOR* BindingVector, UUID_VECTOR* UuidVector, ushort* Annotation);

///The <b>RpcEpUnregister</b> function removes server-address information from the local endpoint-map database.
///Params:
///    IfSpec = Interface to unregister from the local endpoint-map database.
///    BindingVector = Pointer to a vector of binding handles to unregister.
///    UuidVector = Pointer to an optional vector of object UUIDs to unregister. The server application constructs this vector.
///                 <b>RpcEpUnregister</b> unregisters all endpoint-map database elements that match the specified <i>IfSpec</i> and
///                 <i>BindingVector</i> parameters and the object UUID(s). A null parameter value indicates there are no object
///                 UUIDs to unregister.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_BINDINGS</b></dt> </dl> </td> <td width="60%"> No bindings. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle was invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td width="60%"> This
///    was the wrong kind of binding for the operation. </td> </tr> </table> <div class="alert"><b>Note</b> For a list
///    of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcEpUnregister(void* IfSpec, RPC_BINDING_VECTOR* BindingVector, UUID_VECTOR* UuidVector);

///The <b>DceErrorInqText</b> function returns the message text for a status code.
///Params:
///    RpcStatus = Status code to convert to a text string.
///    ErrorText = Returns the text corresponding to the error code. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                width="40%"><a id="RPC_S_OK"></a><a id="rpc_s_ok"></a><dl> <dt><b>RPC_S_OK</b></dt> </dl> </td> <td width="60%">
///                The call succeeded. </td> </tr> <tr> <td width="40%"><a id="RPC_S_INVALID_ARG"></a><a
///                id="rpc_s_invalid_arg"></a><dl> <dt><b>RPC_S_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> Unknown error
///                code. </td> </tr> </table>
///Returns:
///    This function returns RPC_S_OK if it is successful, or an error code if not. <div class="alert"><b>Note</b> For a
///    list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int DceErrorInqTextA(int RpcStatus, char* ErrorText);

///The <b>DceErrorInqText</b> function returns the message text for a status code.
///Params:
///    RpcStatus = Status code to convert to a text string.
///    ErrorText = Returns the text corresponding to the error code. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                width="40%"><a id="RPC_S_OK"></a><a id="rpc_s_ok"></a><dl> <dt><b>RPC_S_OK</b></dt> </dl> </td> <td width="60%">
///                The call succeeded. </td> </tr> <tr> <td width="40%"><a id="RPC_S_INVALID_ARG"></a><a
///                id="rpc_s_invalid_arg"></a><dl> <dt><b>RPC_S_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> Unknown error
///                code. </td> </tr> </table>
///Returns:
///    This function returns RPC_S_OK if it is successful, or an error code if not. <div class="alert"><b>Note</b> For a
///    list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int DceErrorInqTextW(int RpcStatus, char* ErrorText);

///The <b>RpcMgmtEpEltInqBegin</b> function creates an inquiry context for viewing the elements in an endpoint map.
///Params:
///    EpBinding = Binding handle to a host whose endpoint-map elements is to be viewed. Specify <b>NULL</b> to view elements from
///                the local host. If a binding handle is specified, the object UUID on the binding handle must be <b>NULL</b>. If
///                present, the endpoint on the binding handle is ignored and the endpoint to the endpoint mapper database on the
///                given host is used.
///    InquiryType = Integer value that indicates the type of inquiry to perform on the endpoint map. The following are valid inquiry
///                  types. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RPC_C_EP_ALL_ELTS"></a><a
///                  id="rpc_c_ep_all_elts"></a><dl> <dt><b>RPC_C_EP_ALL_ELTS</b></dt> </dl> </td> <td width="60%"> Returns every
///                  element from the endpoint map. The <i>IfId</i>, <i>VersOption</i>, and <i>ObjectUuid</i> parameters are ignored.
///                  </td> </tr> <tr> <td width="40%"><a id="RPC_C_EP_MATCH_BY_IF"></a><a id="rpc_c_ep_match_by_if"></a><dl>
///                  <dt><b>RPC_C_EP_MATCH_BY_IF</b></dt> </dl> </td> <td width="60%"> Searches the endpoint map for elements that
///                  contain the interface identifier specified by the <i>IfId</i> and <i>VersOption</i> values. </td> </tr> <tr> <td
///                  width="40%"><a id="RPC_C_EP_MATCH_BY_OBJ"></a><a id="rpc_c_ep_match_by_obj"></a><dl>
///                  <dt><b>RPC_C_EP_MATCH_BY_OBJ</b></dt> </dl> </td> <td width="60%"> Searches the endpoint map for elements that
///                  contain the object UUID specified by <i>ObjectUuid</i>. </td> </tr> <tr> <td width="40%"><a
///                  id="RPC_C_EP_MATCH_BY_BOTH"></a><a id="rpc_c_ep_match_by_both"></a><dl> <dt><b>RPC_C_EP_MATCH_BY_BOTH</b></dt>
///                  </dl> </td> <td width="60%"> Searches the endpoint map for elements that contain the interface identifier and
///                  object UUID specified by <i>IfId</i>, <i>VersOption</i>, and <i>ObjectUuid</i>. </td> </tr> </table>
///    IfId = Interface identifier of the endpoint-map elements to be returned by RpcMgmtEpEltInqNext. This parameter is only
///           used when <i>InquiryType</i> is either RPC_C_EP_MATCH_BY_IF or RPC_C_EP_MATCH_BY_BOTH. Otherwise, it is ignored.
///    VersOption = Specifies how RpcMgmtEpEltInqNext uses the <i>IfId</i> parameter. This parameter is only used when
///                 <i>InquiryType</i> is either RPC_C_EP_MATCH_BY_IF or RPC_C_EP_MATCH_BY_BOTH. Otherwise, it is ignored. The
///                 following are valid values for this parameter. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                 width="40%"><a id="RPC_C_VERS_ALL"></a><a id="rpc_c_vers_all"></a><dl> <dt><b>RPC_C_VERS_ALL</b></dt> </dl> </td>
///                 <td width="60%"> Returns endpoint-map elements that offer the specified interface UUID, regardless of the version
///                 numbers. </td> </tr> <tr> <td width="40%"><a id="RPC_C_VERS_COMPATIBLE"></a><a
///                 id="rpc_c_vers_compatible"></a><dl> <dt><b>RPC_C_VERS_COMPATIBLE</b></dt> </dl> </td> <td width="60%"> Returns
///                 endpoint-map elements that offer the same major version of the specified interface UUID and a minor version
///                 greater than or equal to the minor version of the specified interface <b>UUID</b>. </td> </tr> <tr> <td
///                 width="40%"><a id="RPC_C_VERS_EXACT"></a><a id="rpc_c_vers_exact"></a><dl> <dt><b>RPC_C_VERS_EXACT</b></dt> </dl>
///                 </td> <td width="60%"> Returns endpoint-map elements that offer the specified version of the specified interface
///                 UUID. </td> </tr> <tr> <td width="40%"><a id="RPC_C_VERS_MAJOR_ONLY"></a><a id="rpc_c_vers_major_only"></a><dl>
///                 <dt><b>RPC_C_VERS_MAJOR_ONLY</b></dt> </dl> </td> <td width="60%"> Returns endpoint-map elements that offer the
///                 same major version of the specified interface UUID and ignores the minor version. </td> </tr> <tr> <td
///                 width="40%"><a id="RPC_C_VERS_UPTO"></a><a id="rpc_c_vers_upto"></a><dl> <dt><b>RPC_C_VERS_UPTO</b></dt> </dl>
///                 </td> <td width="60%"> Returns endpoint-map elements that offer a version of the specified interface UUID less
///                 than or equal to the specified major and minor version. </td> </tr> </table>
///    ObjectUuid = The object UUID that RpcMgmtEpEltInqNext looks for in endpoint-map elements. This parameter is used only when
///                 <i>InquiryType</i> is either RPC_C_EP_MATCH_BY_OBJ or RPC_C_EP_MATCH_BY_BOTH.
///    InquiryContext = Returns an inquiry context for use with RpcMgmtEpEltInqNext and RpcMgmtEpEltInqDone. See RPC_EP_INQ_HANDLE.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcMgmtEpEltInqBegin(void* EpBinding, uint InquiryType, RPC_IF_ID* IfId, uint VersOption, GUID* ObjectUuid, 
                         void*** InquiryContext);

///The <b>RpcMgmtEpEltInqDone</b> function deletes the inquiry context for viewing the elements in an endpoint map.
///Params:
///    InquiryContext = Inquiry context to delete and returns the value <b>NULL</b>.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcMgmtEpEltInqDone(void*** InquiryContext);

///The <b>RpcMgmtEpEltInqNext</b> function returns one element from an endpoint map.
///Params:
///    InquiryContext = Specifies an inquiry context. The inquiry context is returned from RpcMgmtEpEltInqBegin.
///    IfId = Returns the interface identifier of the endpoint-map element.
///    Binding = Optional. Returns the binding handle from the endpoint-map element.
///    ObjectUuid = Optional. Returns the object UUID from the endpoint-map element.
///    Annotation = Optional. Returns the annotation string for the endpoint-map element. When there is no annotation string in the
///                 endpoint-map element, the empty string ("") is returned.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcMgmtEpEltInqNextA(void** InquiryContext, RPC_IF_ID* IfId, void** Binding, GUID* ObjectUuid, 
                         ubyte** Annotation);

///The <b>RpcMgmtEpEltInqNext</b> function returns one element from an endpoint map.
///Params:
///    InquiryContext = Specifies an inquiry context. The inquiry context is returned from RpcMgmtEpEltInqBegin.
///    IfId = Returns the interface identifier of the endpoint-map element.
///    Binding = Optional. Returns the binding handle from the endpoint-map element.
///    ObjectUuid = Optional. Returns the object UUID from the endpoint-map element.
///    Annotation = Optional. Returns the annotation string for the endpoint-map element. When there is no annotation string in the
///                 endpoint-map element, the empty string ("") is returned.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcMgmtEpEltInqNextW(void** InquiryContext, RPC_IF_ID* IfId, void** Binding, GUID* ObjectUuid, 
                         ushort** Annotation);

///<p class="CCE_Message">[This function is supported only on Windows NT and Windows Me/98/95; it returns
///EP_S_CANT_PERFORM_OP on other versions of Windows.] The <b>RpcMgmtEpUnregister</b> function removes server address
///information from an endpoint map.
///Params:
///    EpBinding = Host whose endpoint-map elements are to be unregistered. To remove elements from the same host as the calling
///                application, the application specifies a value of <b>NULL</b>. To remove elements from another host, the
///                application specifies a server binding handle for any server residing on that host. Note that the application can
///                specify the same binding handle it is using to make other remote procedure calls.
///    IfId = Interface identifier to remove from the endpoint map.
///    Binding = Binding handle to remove.
///    ObjectUuid = Optional object UUID to remove. The value <b>NULL</b> indicates there is no object UUID to remove.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt>
///    </dl> </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_CANT_PERFORM_OP</b></dt> </dl> </td> <td width="60%"> Cannot perform the requested operation. </td>
///    </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcMgmtEpUnregister(void* EpBinding, RPC_IF_ID* IfId, void* Binding, GUID* ObjectUuid);

///The <b>RpcMgmtSetAuthorizationFn</b> function establishes an authorization function for processing remote calls to a
///server's management functions.
///Params:
///    AuthorizationFn = Specifies an authorization function. The RPC server run-time library automatically calls this function whenever
///                      the server run-time receives a client request to execute one of the remote management functions. The server must
///                      implement this function. Applications specify a value of <b>NULL</b> to unregister a previously registered
///                      authorization function. After such a call, default authorizations are used.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcMgmtSetAuthorizationFn(RPC_MGMT_AUTHORIZATION_FN AuthorizationFn);

///The <b>RpcExceptionFilter</b> function is a default exception filter that determines whether an exception is fatal or
///non-fatal.<b>RpcExceptionFilter</b> is recommended for structured exception handling for the most common exceptions
///as an alternative to custom filters with RpcExcept.
///Params:
///    ExceptionCode = Value of an exception. Any of the following exception values will return <b>EXCEPTION_CONTINUE_SEARCH</b>: <a
///                    id="STATUS_ACCESS_VIOLATION"></a> <a id="status_access_violation"></a>
///Returns:
///    A value that specifies whether the exception was fatal or non-fatal. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>EXCEPTION_CONTINUE_SEARCH</b></dt> </dl> </td> <td
///    width="60%"> The exception is fatal and must be handled. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>EXCEPTION_EXECUTE_HANDLER</b></dt> </dl> </td> <td width="60%"> The exception is not fatal. </td> </tr>
///    </table>
///    
@DllImport("RPCRT4")
int RpcExceptionFilter(uint ExceptionCode);

///The <b>RpcServerInterfaceGroupCreate</b> function creates an RPC server interface group for the server application.
///This interface group fully specifies the interfaces, endpoints, and idle properties of an RPC server application.
///Once created, an interface group can be activated and deactivated as the application requires.
///Params:
///    Interfaces = A pointer to an array of RPC_INTERFACE_TEMPLATE structures that define the interfaces exposed by the interface
///                 group.
///    NumIfs = The number of elements in <i>Interfaces</i>.
///    Endpoints = A pointer to an array of RPC_ENDPOINT_TEMPLATE structures that define the endpoints used by the interface group.
///    NumEndpoints = The number of elements in <i>Endpoints</i>.
///    IdlePeriod = The length of time in seconds after the interface group becomes idle that the RPC runtime should wait before
///                 invoking the idle callback. 0 means the callback is invoked immediately. <b>INFINITE</b> means the server
///                 application does not care about the interface group’s idle state.
///    IdleCallbackFn = A RPC_INTERFACE_GROUP_IDLE_CALLBACK_FN callback that the RPC runtime will invoke once the interface group is idle
///                     for the length of time given in <i>IdlePeriod</i>. Can be <b>NULL</b> only if <i>IdlePeriod</i> is
///                     <b>INFINITE</b>.
///    IdleCallbackContext = A user-defined pointer to be passed to the idle callback in <i>IdleCallbackFn</i>.
///    IfGroup = If successful, a pointer to an <b>RPC_INTERFACE_GROUP</b> buffer that receives the handle to the newly created
///              interface group. If this function fails, <i>IfGroup</i> is undefined.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerInterfaceGroupCreateW(char* Interfaces, uint NumIfs, char* Endpoints, uint NumEndpoints, 
                                   uint IdlePeriod, RPC_INTERFACE_GROUP_IDLE_CALLBACK_FN IdleCallbackFn, 
                                   void* IdleCallbackContext, void** IfGroup);

///The <b>RpcServerInterfaceGroupCreate</b> function creates an RPC server interface group for the server application.
///This interface group fully specifies the interfaces, endpoints, and idle properties of an RPC server application.
///Once created, an interface group can be activated and deactivated as the application requires.
///Params:
///    Interfaces = A pointer to an array of RPC_INTERFACE_TEMPLATE structures that define the interfaces exposed by the interface
///                 group.
///    NumIfs = The number of elements in <i>Interfaces</i>.
///    Endpoints = A pointer to an array of RPC_ENDPOINT_TEMPLATE structures that define the endpoints used by the interface group.
///    NumEndpoints = The number of elements in <i>Endpoints</i>.
///    IdlePeriod = The length of time in seconds after the interface group becomes idle that the RPC runtime should wait before
///                 invoking the idle callback. 0 means the callback is invoked immediately. <b>INFINITE</b> means the server
///                 application does not care about the interface group’s idle state.
///    IdleCallbackFn = A RPC_INTERFACE_GROUP_IDLE_CALLBACK_FN callback that the RPC runtime will invoke once the interface group is idle
///                     for the length of time given in <i>IdlePeriod</i>. Can be <b>NULL</b> only if <i>IdlePeriod</i> is
///                     <b>INFINITE</b>.
///    IdleCallbackContext = A user-defined pointer to be passed to the idle callback in <i>IdleCallbackFn</i>.
///    IfGroup = If successful, a pointer to an <b>RPC_INTERFACE_GROUP</b> buffer that receives the handle to the newly created
///              interface group. If this function fails, <i>IfGroup</i> is undefined.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerInterfaceGroupCreateA(char* Interfaces, uint NumIfs, char* Endpoints, uint NumEndpoints, 
                                   uint IdlePeriod, RPC_INTERFACE_GROUP_IDLE_CALLBACK_FN IdleCallbackFn, 
                                   void* IdleCallbackContext, void** IfGroup);

///The <b>RpcServerInterfaceGroupClose</b> function is used to free an interface group.
///Params:
///    IfGroup = A <b>RPC_INTERFACE_GROUP</b> from RpcServerInterfaceGroupCreate that defines the interface group to close.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> <i>IfGroup</i> is invalid. </td> </tr> </table>
///    <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerInterfaceGroupClose(void* IfGroup);

///The <b>RpcServerInterfaceGroupActivate</b> function tells the RPC server runtime to register the interface group’s
///interfaces and endpoints and begin listening for calls.
///Params:
///    IfGroup = A <b>RPC_INTERFACE_GROUP</b> from RpcServerInterfaceGroupCreate that defines the interface group to activate.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_PROTSEQ_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The protocol sequence is not supported
///    on this host. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_RPC_PROTSEQ</b></dt> </dl> </td> <td
///    width="60%"> The protocol sequence is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ENDPOINT_FORMAT</b></dt> </dl> </td> <td width="60%"> The endpoint format is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is
///    out of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_SECURITY_DESC</b></dt> </dl> </td> <td
///    width="60%"> The security descriptor for an endpoint or interface is invalid. </td> </tr> </table> <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerInterfaceGroupActivate(void* IfGroup);

///The <b>RpcServerInterfaceGroupDeactivate</b> function tells the RPC runtime to attempt to close the given interface
///group, optionally aborting the operation if there is outstanding client activity.
///Params:
///    IfGroup = A <b>RPC_INTERFACE_GROUP</b> from RpcServerInterfaceGroupCreate that defines the interface group to deactivate
///    ForceDeactivation = If <b>TRUE</b>, the RPC runtime should ignore client activity and unconditionally deactivate the interface group.
///                        If <b>FALSE</b>, the operation should be aborted if new activity takes place.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_SERVER_TOO_BUSY</b></dt> </dl> </td> <td width="60%"> <i>ForceDeactivation</i> is <b>FALSE</b> and
///    there is outstanding client activity. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid
///    error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerInterfaceGroupDeactivate(void* IfGroup, uint ForceDeactivation);

///The <b>RpcServerInterfaceGroupInqBindings</b> function returns the binding handles over which remote procedure calls
///can be received for the given interface group.
///Params:
///    IfGroup = A <b>RPC_INTERFACE_GROUP</b> from RpcServerInterfaceGroupCreate that defines the interface group for which the
///              bindings should be queried.
///    BindingVector = Returns a pointer to a pointer to a vector of server binding handles.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_BINDINGS</b></dt> </dl> </td> <td width="60%"> There are no bindings. </td> </tr> </table> <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerInterfaceGroupInqBindings(void* IfGroup, RPC_BINDING_VECTOR** BindingVector);

@DllImport("RPCRT4")
int I_RpcNegotiateTransferSyntax(RPC_MESSAGE* Message);

@DllImport("RPCRT4")
int I_RpcGetBuffer(RPC_MESSAGE* Message);

@DllImport("RPCRT4")
int I_RpcGetBufferWithObject(RPC_MESSAGE* Message, GUID* ObjectUuid);

@DllImport("RPCRT4")
int I_RpcSendReceive(RPC_MESSAGE* Message);

@DllImport("RPCRT4")
int I_RpcFreeBuffer(RPC_MESSAGE* Message);

@DllImport("RPCRT4")
int I_RpcSend(RPC_MESSAGE* Message);

@DllImport("RPCRT4")
int I_RpcReceive(RPC_MESSAGE* Message, uint Size);

@DllImport("RPCRT4")
int I_RpcFreePipeBuffer(RPC_MESSAGE* Message);

@DllImport("RPCRT4")
int I_RpcReallocPipeBuffer(RPC_MESSAGE* Message, uint NewSize);

@DllImport("RPCRT4")
void I_RpcRequestMutex(void** Mutex);

@DllImport("RPCRT4")
void I_RpcClearMutex(void* Mutex);

@DllImport("RPCRT4")
void I_RpcDeleteMutex(void* Mutex);

@DllImport("RPCRT4")
void* I_RpcAllocate(uint Size);

@DllImport("RPCRT4")
void I_RpcFree(void* Object);

@DllImport("RPCRT4")
void I_RpcPauseExecution(uint Milliseconds);

@DllImport("RPCRT4")
int I_RpcGetExtendedError();

@DllImport("RPCRT4")
int I_RpcSystemHandleTypeSpecificWork(void* Handle, ubyte ActualType, ubyte IdlType, 
                                      LRPC_SYSTEM_HANDLE_MARSHAL_DIRECTION MarshalDirection);

@DllImport("RPCRT4")
void* I_RpcGetCurrentCallHandle();

@DllImport("RPCRT4")
int I_RpcNsInterfaceExported(uint EntryNameSyntax, ushort* EntryName, 
                             RPC_SERVER_INTERFACE* RpcInterfaceInformation);

@DllImport("RPCRT4")
int I_RpcNsInterfaceUnexported(uint EntryNameSyntax, ushort* EntryName, 
                               RPC_SERVER_INTERFACE* RpcInterfaceInformation);

@DllImport("RPCRT4")
int I_RpcBindingToStaticStringBindingW(void* Binding, ushort** StringBinding);

@DllImport("RPCRT4")
int I_RpcBindingInqSecurityContext(void* Binding, void** SecurityContextHandle);

@DllImport("RPCRT4")
int I_RpcBindingInqSecurityContextKeyInfo(void* Binding, void* KeyInfo);

@DllImport("RPCRT4")
int I_RpcBindingInqWireIdForSnego(void* Binding, ubyte* WireId);

@DllImport("RPCRT4")
int I_RpcBindingInqMarshalledTargetInfo(void* Binding, uint* MarshalledTargetInfoSize, 
                                        ubyte** MarshalledTargetInfo);

///<p class="CCE_Message">[The <b>I_RpcBindingInqLocalClientPID</b> function is available for use in the operating
///systems specified in the Requirements section. Instead, call RpcServerInqCallAttributes.] The
///<b>I_RpcBindingInqLocalClientPID</b> function obtains a client process ID.
///Params:
///    Binding = <b>RPC_BINDING_HANDLE</b> that specifies the binding handle for an explicit RPC binding from the client to a
///              server application.
///    Pid = Contains the process ID of the client that issued the call upon return.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The function call was successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_CALL_ACTIVE</b></dt> </dl> </td> <td width="60%"> The current thread does not have an active RPC
///    call. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%">
///    The RPC binding handle is invalid. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error
///    codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int I_RpcBindingInqLocalClientPID(void* Binding, uint* Pid);

@DllImport("RPCRT4")
int I_RpcBindingHandleToAsyncHandle(void* Binding, void** AsyncHandle);

@DllImport("RPCRT4")
int I_RpcNsBindingSetEntryNameW(void* Binding, uint EntryNameSyntax, ushort* EntryName);

@DllImport("RPCRT4")
int I_RpcNsBindingSetEntryNameA(void* Binding, uint EntryNameSyntax, ubyte* EntryName);

@DllImport("RPCRT4")
int I_RpcServerUseProtseqEp2A(ubyte* NetworkAddress, ubyte* Protseq, uint MaxCalls, ubyte* Endpoint, 
                              void* SecurityDescriptor, void* Policy);

@DllImport("RPCRT4")
int I_RpcServerUseProtseqEp2W(ushort* NetworkAddress, ushort* Protseq, uint MaxCalls, ushort* Endpoint, 
                              void* SecurityDescriptor, void* Policy);

@DllImport("RPCRT4")
int I_RpcServerUseProtseq2W(ushort* NetworkAddress, ushort* Protseq, uint MaxCalls, void* SecurityDescriptor, 
                            void* Policy);

@DllImport("RPCRT4")
int I_RpcServerUseProtseq2A(ubyte* NetworkAddress, ubyte* Protseq, uint MaxCalls, void* SecurityDescriptor, 
                            void* Policy);

@DllImport("RPCRT4")
int I_RpcServerStartService(ushort* Protseq, ushort* Endpoint, void* IfSpec);

@DllImport("RPCRT4")
int I_RpcBindingInqDynamicEndpointW(void* Binding, ushort** DynamicEndpoint);

@DllImport("RPCRT4")
int I_RpcBindingInqDynamicEndpointA(void* Binding, ubyte** DynamicEndpoint);

@DllImport("RPCRT4")
int I_RpcServerCheckClientRestriction(void* Context);

@DllImport("RPCRT4")
int I_RpcBindingInqTransportType(void* Binding, uint* Type);

@DllImport("RPCRT4")
int I_RpcIfInqTransferSyntaxes(void* RpcIfHandle, RPC_TRANSFER_SYNTAX* TransferSyntaxes, uint TransferSyntaxSize, 
                               uint* TransferSyntaxCount);

@DllImport("RPCRT4")
int I_UuidCreate(GUID* Uuid);

@DllImport("RPCRT4")
int I_RpcBindingCopy(void* SourceBinding, void** DestinationBinding);

@DllImport("RPCRT4")
int I_RpcBindingIsClientLocal(void* BindingHandle, uint* ClientLocalFlag);

@DllImport("RPCRT4")
int I_RpcBindingCreateNP(ushort* ServerName, ushort* ServiceName, ushort* NetworkOptions, void** Binding);

@DllImport("RPCRT4")
void I_RpcSsDontSerializeContext();

@DllImport("RPCRT4")
int I_RpcServerRegisterForwardFunction(RPC_FORWARD_FUNCTION* pForwardFunction);

@DllImport("RPCRT4")
RPC_ADDRESS_CHANGE_FN* I_RpcServerInqAddressChangeFn();

@DllImport("RPCRT4")
int I_RpcServerSetAddressChangeFn(RPC_ADDRESS_CHANGE_FN* pAddressChangeFn);

@DllImport("RPCRT4")
int I_RpcServerInqLocalConnAddress(void* Binding, void* Buffer, uint* BufferSize, uint* AddressFormat);

@DllImport("RPCRT4")
int I_RpcServerInqRemoteConnAddress(void* Binding, void* Buffer, uint* BufferSize, uint* AddressFormat);

@DllImport("RPCRT4")
void I_RpcSessionStrictContextHandle();

@DllImport("RPCRT4")
int I_RpcTurnOnEEInfoPropagation();

@DllImport("RPCRT4")
int I_RpcServerInqTransportType(uint* Type);

@DllImport("RPCRT4")
int I_RpcMapWin32Status(int Status);

@DllImport("RPCRT4")
void I_RpcRecordCalloutFailure(int RpcStatus, RDR_CALLOUT_STATE* CallOutState, ushort* DllName);

@DllImport("RPCRT4")
int I_RpcMgmtEnableDedicatedThreadPool();

@DllImport("RPCRT4")
int I_RpcGetDefaultSD(void** ppSecurityDescriptor);

@DllImport("RPCRT4")
int I_RpcOpenClientProcess(void* Binding, uint DesiredAccess, void** ClientProcess);

@DllImport("RPCRT4")
int I_RpcBindingIsServerLocal(void* Binding, uint* ServerLocalFlag);

@DllImport("RPCRT4")
int I_RpcBindingSetPrivateOption(void* hBinding, uint option, size_t optionValue);

@DllImport("RPCRT4")
int I_RpcServerSubscribeForDisconnectNotification(void* Binding, void* hEvent);

@DllImport("RPCRT4")
int I_RpcServerGetAssociationID(void* Binding, uint* AssociationID);

@DllImport("RPCRT4")
int I_RpcServerDisableExceptionFilter();

@DllImport("RPCRT4")
int I_RpcServerSubscribeForDisconnectNotification2(void* Binding, void* hEvent, GUID* SubscriptionId);

@DllImport("RPCRT4")
int I_RpcServerUnsubscribeForDisconnectNotification(void* Binding, GUID SubscriptionId);

///The <b>RpcNsBindingExport</b> function establishes a name service–database entry with multiple binding handles and
///multiple objects for a server. <div class="alert"><b>Note</b> This function is not supported on Windows Vista and
///later operating systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax of <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to the entry name to which binding handles and object UUIDs are exported. You cannot provide a null or
///                empty string. The client and the server must both use the same entry name.
///    IfSpec = Stub-generated data structure specifying the interface to export. A null value indicates there are no binding
///             handles to export (only object UUIDs are to be exported) and <i>BindingVec</i> is ignored.
///    BindingVec = Pointer to server bindings to export. A null value indicates there are no binding handles to export (only object
///                 UUIDs are to be exported).
///    ObjectUuidVec = Pointer to a vector of object UUIDs offered by the server. The server application constructs this vector. A null
///                    value indicates there are no object UUIDs to export (only binding handles are to be exported).
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NOTHING_TO_EXPORT</b></dt> </dl> </td> <td width="60%"> There was nothing to export. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle
///    was invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td
///    width="60%"> This was the wrong kind of binding for the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is unsupported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_NS_PRIVILEGE</b></dt> </dl> </td> <td width="60%"> No privilege for name-service operation. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
///    name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes,
///    see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsBindingExportA(uint EntryNameSyntax, ubyte* EntryName, void* IfSpec, RPC_BINDING_VECTOR* BindingVec, 
                        UUID_VECTOR* ObjectUuidVec);

///The <b>RpcNsBindingUnexport</b> function removes the binding handles for an interface and objects from an entry in
///the name-service database. <div class="alert"><b>Note</b> This function is not supported on Windows Vista and later
///operating systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax of <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to the entry name from which to remove binding handles and object UUIDs.
///    IfSpec = Interface specification for the binding handles to be removed from the name service database. A null parameter
///             value indicates not to unexport any binding handles (only object UUIDs are to be unexported).
///    ObjectUuidVec = Pointer to a vector of object UUIDs that the server no longer wants to offer. The application constructs this
///                    vector. A null value indicates there are no object UUIDs to unexport (only binding handles are to be unexported).
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_VERS_OPTION</b></dt> </dl> </td> <td width="60%"> The version option is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td
///    width="60%"> The name syntax is unsupported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td> <td width="60%"> The name is incomplete. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was
///    not found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The name service is unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INTERFACE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The interface was not found. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_NOT_ALL_OBJS_UNEXPORTED</b></dt> </dl> </td> <td width="60%"> Not all
///    objects unexported. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC
///    Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsBindingUnexportA(uint EntryNameSyntax, ubyte* EntryName, void* IfSpec, UUID_VECTOR* ObjectUuidVec);

///The <b>RpcNsBindingExport</b> function establishes a name service–database entry with multiple binding handles and
///multiple objects for a server. <div class="alert"><b>Note</b> This function is not supported on Windows Vista and
///later operating systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax of <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to the entry name to which binding handles and object UUIDs are exported. You cannot provide a null or
///                empty string. The client and the server must both use the same entry name.
///    IfSpec = Stub-generated data structure specifying the interface to export. A null value indicates there are no binding
///             handles to export (only object UUIDs are to be exported) and <i>BindingVec</i> is ignored.
///    BindingVec = Pointer to server bindings to export. A null value indicates there are no binding handles to export (only object
///                 UUIDs are to be exported).
///    ObjectUuidVec = Pointer to a vector of object UUIDs offered by the server. The server application constructs this vector. A null
///                    value indicates there are no object UUIDs to export (only binding handles are to be exported).
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NOTHING_TO_EXPORT</b></dt> </dl> </td> <td width="60%"> There was nothing to export. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle
///    was invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td
///    width="60%"> This was the wrong kind of binding for the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is unsupported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_NS_PRIVILEGE</b></dt> </dl> </td> <td width="60%"> No privilege for name-service operation. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
///    name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes,
///    see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsBindingExportW(uint EntryNameSyntax, ushort* EntryName, void* IfSpec, RPC_BINDING_VECTOR* BindingVec, 
                        UUID_VECTOR* ObjectUuidVec);

///The <b>RpcNsBindingUnexport</b> function removes the binding handles for an interface and objects from an entry in
///the name-service database. <div class="alert"><b>Note</b> This function is not supported on Windows Vista and later
///operating systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax of <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to the entry name from which to remove binding handles and object UUIDs.
///    IfSpec = Interface specification for the binding handles to be removed from the name service database. A null parameter
///             value indicates not to unexport any binding handles (only object UUIDs are to be unexported).
///    ObjectUuidVec = Pointer to a vector of object UUIDs that the server no longer wants to offer. The application constructs this
///                    vector. A null value indicates there are no object UUIDs to unexport (only binding handles are to be unexported).
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_VERS_OPTION</b></dt> </dl> </td> <td width="60%"> The version option is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td
///    width="60%"> The name syntax is unsupported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td> <td width="60%"> The name is incomplete. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was
///    not found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The name service is unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INTERFACE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The interface was not found. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_NOT_ALL_OBJS_UNEXPORTED</b></dt> </dl> </td> <td width="60%"> Not all
///    objects unexported. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC
///    Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsBindingUnexportW(uint EntryNameSyntax, ushort* EntryName, void* IfSpec, UUID_VECTOR* ObjectUuidVec);

///The <b>RpcNsBindingExportPnP</b> function establishes a name-service database entry with multiple binding handles and
///multiple objects for a server that supports Plug and Play. <div class="alert"><b>Note</b> This function is not
///supported on Windows Vista and later operating systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax of <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to the entry name to which binding handles and object UUIDs are exported. You cannot provide a null or
///                empty string. To use the entry name specified in the registry value entry
///                <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultEntry</b>, provide a null pointer or an empty
///                string. In this case, the <i>EntryNameSyntax</i> parameter is ignored and the run-time library uses the default
///                syntax.
///    IfSpec = Stub-generated data structure specifying the interface to export. A null value indicates there are no binding
///             handles to export (only object UUIDs are to be exported) and <i>BindingVec</i> is ignored.
///    ObjectVector = Pointer to a vector of object UUIDs offered by the server. The server application constructs this vector. A null
///                   value indicates there are no object UUIDs to export (only binding handles are to be exported).
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NOTHING_TO_EXPORT</b></dt> </dl> </td> <td width="60%"> There was nothing to export. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle
///    was invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td
///    width="60%"> This was the wrong kind of binding for the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is unsupported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_NS_PRIVILEGE</b></dt> </dl> </td> <td width="60%"> No privilege for name-service operation. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
///    name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes,
///    see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsBindingExportPnPA(uint EntryNameSyntax, ubyte* EntryName, void* IfSpec, UUID_VECTOR* ObjectVector);

///The <b>RpcNsBindingUnexportPnP</b> function removes the binding handles for Plug and Play interfaces and objects from
///an entry in the name-service database. <div class="alert"><b>Note</b> This function is not supported on Windows Vista
///and later operating systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax of <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to the entry name from which to remove binding handles and object UUIDs.
///    IfSpec = Interface specification for the binding handles to be removed from the name service database. A null parameter
///             value indicates not to unexport any binding handles (only object UUIDs are to be unexported).
///    ObjectVector = Pointer to a vector of object UUIDs that the server no longer wants to offer. The application constructs this
///                   vector. A null value indicates there are no object UUIDs to unexport (only binding handles are to be unexported).
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_VERS_OPTION</b></dt> </dl> </td> <td width="60%"> The version option is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td
///    width="60%"> The name syntax is unsupported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td> <td width="60%"> The name is incomplete. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was
///    not found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The name service is unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INTERFACE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The interface was not found. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_NOT_ALL_OBJS_UNEXPORTED</b></dt> </dl> </td> <td width="60%"> Not all
///    objects unexported. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC
///    Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsBindingUnexportPnPA(uint EntryNameSyntax, ubyte* EntryName, void* IfSpec, UUID_VECTOR* ObjectVector);

///The <b>RpcNsBindingExportPnP</b> function establishes a name-service database entry with multiple binding handles and
///multiple objects for a server that supports Plug and Play. <div class="alert"><b>Note</b> This function is not
///supported on Windows Vista and later operating systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax of <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to the entry name to which binding handles and object UUIDs are exported. You cannot provide a null or
///                empty string. To use the entry name specified in the registry value entry
///                <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultEntry</b>, provide a null pointer or an empty
///                string. In this case, the <i>EntryNameSyntax</i> parameter is ignored and the run-time library uses the default
///                syntax.
///    IfSpec = Stub-generated data structure specifying the interface to export. A null value indicates there are no binding
///             handles to export (only object UUIDs are to be exported) and <i>BindingVec</i> is ignored.
///    ObjectVector = Pointer to a vector of object UUIDs offered by the server. The server application constructs this vector. A null
///                   value indicates there are no object UUIDs to export (only binding handles are to be exported).
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NOTHING_TO_EXPORT</b></dt> </dl> </td> <td width="60%"> There was nothing to export. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_BINDING</b></dt> </dl> </td> <td width="60%"> The binding handle
///    was invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_WRONG_KIND_OF_BINDING</b></dt> </dl> </td> <td
///    width="60%"> This was the wrong kind of binding for the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is unsupported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_NS_PRIVILEGE</b></dt> </dl> </td> <td width="60%"> No privilege for name-service operation. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
///    name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes,
///    see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsBindingExportPnPW(uint EntryNameSyntax, ushort* EntryName, void* IfSpec, UUID_VECTOR* ObjectVector);

///The <b>RpcNsBindingUnexportPnP</b> function removes the binding handles for Plug and Play interfaces and objects from
///an entry in the name-service database. <div class="alert"><b>Note</b> This function is not supported on Windows Vista
///and later operating systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax of <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to the entry name from which to remove binding handles and object UUIDs.
///    IfSpec = Interface specification for the binding handles to be removed from the name service database. A null parameter
///             value indicates not to unexport any binding handles (only object UUIDs are to be unexported).
///    ObjectVector = Pointer to a vector of object UUIDs that the server no longer wants to offer. The application constructs this
///                   vector. A null value indicates there are no object UUIDs to unexport (only binding handles are to be unexported).
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_VERS_OPTION</b></dt> </dl> </td> <td width="60%"> The version option is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td
///    width="60%"> The name syntax is unsupported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td> <td width="60%"> The name is incomplete. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was
///    not found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The name service is unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INTERFACE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The interface was not found. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_NOT_ALL_OBJS_UNEXPORTED</b></dt> </dl> </td> <td width="60%"> Not all
///    objects unexported. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC
///    Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsBindingUnexportPnPW(uint EntryNameSyntax, ushort* EntryName, void* IfSpec, UUID_VECTOR* ObjectVector);

///The <b>RpcNsBindingLookupBegin</b> function creates a lookup context for an interface and an object. <div
///class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating systems.</div><div>
///</div>
///Params:
///    EntryNameSyntax = Syntax of the <i>EntryName</i> parameter. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to an entry name at which the search for compatible bindings begins. To use the entry name specified in
///                the registry value entry <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultEntry</b>, provide a
///                null pointer or an empty string. In this case, the <i>EntryNameSyntax</i> parameter is ignored and the run-time
///                library uses the default syntax.
///    IfSpec = Stub-generated structure indicating the interface to look up. If the interface specification has not been
///             exported or is of no concern to the caller, specify a null value for this parameter. In this case, the bindings
///             returned are only guaranteed to be of a compatible and supported protocol sequence and to contain the specified
///             object UUID. The desired interface might not be supported by the contacted server.
///    ObjUuid = Pointer to an optional object UUID. For a nonzero UUID, compatible binding handles are returned from an entry
///              only if the server has exported the specified object UUID. For a null pointer value or a nil UUID for this
///              parameter, the returned binding handles contain one of the object UUIDs exported by the compatible server. If the
///              server did not export any object UUIDs, the returned compatible binding handles contain a nil object UUID.
///    BindingMaxCount = Maximum number of bindings to return in the <i>BindingVec</i> parameter from the RpcNsBindingLookupNext function.
///                      Specify a value of zero to use the default count of RPC_C_BINDING_MAX_COUNT_DEFAULT.
///    LookupContext = Returns a pointer to a name-service handle for use with the RpcNsBindingLookupNext and RpcNsBindingLookupDone
///                    functions.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is unsupported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was not found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
///    name service is unavailable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_OBJECT</b></dt> </dl>
///    </td> <td width="60%"> Invalid object. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid
///    error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsBindingLookupBeginA(uint EntryNameSyntax, ubyte* EntryName, void* IfSpec, GUID* ObjUuid, 
                             uint BindingMaxCount, void** LookupContext);

///The <b>RpcNsBindingLookupBegin</b> function creates a lookup context for an interface and an object. <div
///class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating systems.</div><div>
///</div>
///Params:
///    EntryNameSyntax = Syntax of the <i>EntryName</i> parameter. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to an entry name at which the search for compatible bindings begins. To use the entry name specified in
///                the registry value entry <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultEntry</b>, provide a
///                null pointer or an empty string. In this case, the <i>EntryNameSyntax</i> parameter is ignored and the run-time
///                library uses the default syntax.
///    IfSpec = Stub-generated structure indicating the interface to look up. If the interface specification has not been
///             exported or is of no concern to the caller, specify a null value for this parameter. In this case, the bindings
///             returned are only guaranteed to be of a compatible and supported protocol sequence and to contain the specified
///             object UUID. The desired interface might not be supported by the contacted server.
///    ObjUuid = Pointer to an optional object UUID. For a nonzero UUID, compatible binding handles are returned from an entry
///              only if the server has exported the specified object UUID. For a null pointer value or a nil UUID for this
///              parameter, the returned binding handles contain one of the object UUIDs exported by the compatible server. If the
///              server did not export any object UUIDs, the returned compatible binding handles contain a nil object UUID.
///    BindingMaxCount = Maximum number of bindings to return in the <i>BindingVec</i> parameter from the RpcNsBindingLookupNext function.
///                      Specify a value of zero to use the default count of RPC_C_BINDING_MAX_COUNT_DEFAULT.
///    LookupContext = Returns a pointer to a name-service handle for use with the RpcNsBindingLookupNext and RpcNsBindingLookupDone
///                    functions.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is unsupported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was not found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
///    name service is unavailable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_OBJECT</b></dt> </dl>
///    </td> <td width="60%"> Invalid object. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid
///    error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsBindingLookupBeginW(uint EntryNameSyntax, ushort* EntryName, void* IfSpec, GUID* ObjUuid, 
                             uint BindingMaxCount, void** LookupContext);

///The <b>RpcNsBindingLookupNext</b> function returns a list of compatible binding handles for a specified interface and
///optionally an object. <div class="alert"><b>Note</b> This function is not supported on Windows Vista and later
///operating systems.</div><div> </div>
///Params:
///    LookupContext = Name-service handle returned from the RpcNsBindingLookupBegin function.
///    BindingVec = Returns the address of a pointer to a vector of client-compatible server binding handles.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_MORE_BINDINGS</b></dt> </dl> </td> <td width="60%"> No more bindings. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The name service is
///    unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return
///    Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsBindingLookupNext(void* LookupContext, RPC_BINDING_VECTOR** BindingVec);

///The <b>RpcNsBindingLookupDone</b> function signifies that a client has finished looking for compatible servers and
///deletes the lookup context. <div class="alert"><b>Note</b> This function is not supported on Windows Vista and later
///operating systems.</div><div> </div>
///Params:
///    LookupContext = Pointer to the name-service handle to free. The name-service handle <i>LookupContext</i> points to is created by
///                    calling the RpcNsBindingLookupBegin function. An argument value of <b>NULL</b> is returned.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsBindingLookupDone(void** LookupContext);

///The <b>RpcNsGroupDelete</b> function deletes a group attribute. <div class="alert"><b>Note</b> This function is not
///supported on Windows Vista and later operating systems.</div><div> </div>
///Params:
///    GroupNameSyntax = Integer value that indicates the syntax of <i>GroupName</i>. Can be set to one of the following values: <table>
///                      <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RPC_C_NS_SYNTAX_DEFAULT"></a><a
///                      id="rpc_c_ns_syntax_default"></a><dl> <dt><b>RPC_C_NS_SYNTAX_DEFAULT</b></dt> </dl> </td> <td width="60%"> Use
///                      the syntax specified in the registry value <b>HKEY_LOCAL_MACHINE\ Software\Microsoft\Rpc\ NameService\
///                      DefaultSyntax </b> </td> </tr> <tr> <td width="40%"><a id="RPC_C_NS_SYNTAX_DCE"></a><a
///                      id="rpc_c_ns_syntax_dce"></a><dl> <dt><b>RPC_C_NS_SYNTAX_DCE</b></dt> </dl> </td> <td width="60%"> Use DCE
///                      syntax. </td> </tr> </table>
///    GroupName = Pointer to the name of the name-service group to delete.
///Returns:
///    This function returns one of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl> </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td
///    width="60%"> The name syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td> <td width="60%"> The name is incomplete. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was
///    not found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsGroupDeleteA(uint GroupNameSyntax, ubyte* GroupName);

///The <b>RpcNsGroupMbrAdd</b> function adds an entry name to a group. If necessary, it creates the entry. <div
///class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating systems.</div><div>
///</div>
///Params:
///    GroupNameSyntax = Syntax of <i>GroupName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    GroupName = Pointer to the name of the RPC group to receive a new member.
///    MemberNameSyntax = Syntax to use in <i>MemberName</i>. To use the syntax specified in the registry value entry
///                       <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                       RPC_C_NS_SYNTAX_DEFAULT.
///    MemberName = Pointer to the name of the new RPC group member.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The name service is unavailable.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsGroupMbrAddA(uint GroupNameSyntax, ubyte* GroupName, uint MemberNameSyntax, ubyte* MemberName);

///The <b>RpcNsGroupMbrRemove</b> function removes an entry name from a group. <div class="alert"><b>Note</b> This
///function is not supported on Windows Vista and later operating systems.</div><div> </div>
///Params:
///    GroupNameSyntax = Syntax of <i>GroupName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    GroupName = Pointer to the name of the RPC group from which to remove the member name.
///    MemberNameSyntax = Syntax to use in the <i>MemberName</i> parameter. To use the syntax specified in the registry value entry
///                       <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                       RPC_C_NS_SYNTAX_DEFAULT.
///    MemberName = Pointer to the name of the member to remove from the RPC group attribute in the entry <i>GroupName</i>.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was not found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
///    name service is unavailable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_GROUP_MEMBER_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> The group member was not found. </td> </tr> </table> <div class="alert"><b>Note</b>
///    For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsGroupMbrRemoveA(uint GroupNameSyntax, ubyte* GroupName, uint MemberNameSyntax, ubyte* MemberName);

///The <b>RpcNsGroupMbrInqBegin</b> function creates an inquiry context for viewing group members. <div
///class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating systems.</div><div>
///</div>
///Params:
///    GroupNameSyntax = Syntax of <i>GroupName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    GroupName = Pointer to the name of the RPC group to view.
///    MemberNameSyntax = Syntax of the return parameter, <i>MemberName</i>, in the RpcNsGroupMbrInqNext function. To use the syntax
///                       specified in the registry value entry <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>,
///                       provide a value of RPC_C_NS_SYNTAX_DEFAULT.
///    InquiryContext = Returns a pointer to a name-service handle for use with the RpcNsGroupMbrInqNext and RpcNsGroupMbrInqDone
///                     functions.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was not found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
///    name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes,
///    see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsGroupMbrInqBeginA(uint GroupNameSyntax, ubyte* GroupName, uint MemberNameSyntax, void** InquiryContext);

///The <b>RpcNsGroupMbrInqNext</b> function returns one entry name from a group at a time. <div
///class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating systems.</div><div>
///</div>
///Params:
///    InquiryContext = Name service handle.
///    MemberName = Returns the address of a pointer to an RPC group member name. The syntax of the returned name was specified by
///                 the <i>MemberNameSyntax</i> parameter in the RpcNsGroupMbrInqBegin function. Specify a null value to prevent
///                 <b>RpcNsGroupMbrInqNext</b> from returning the <i>MemberName</i> parameter. In this case, the application does
///                 not call the RpcStringFree function.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NS_HANDLE</b></dt> </dl> </td> <td width="60%"> The name-service handle is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NO_MORE_MEMBERS</b></dt> </dl> </td> <td width="60%"> No more
///    members. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsGroupMbrInqNextA(void* InquiryContext, ubyte** MemberName);

///The <b>RpcNsGroupDelete</b> function deletes a group attribute. <div class="alert"><b>Note</b> This function is not
///supported on Windows Vista and later operating systems.</div><div> </div>
///Params:
///    GroupNameSyntax = Integer value that indicates the syntax of <i>GroupName</i>. Can be set to one of the following values: <table>
///                      <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RPC_C_NS_SYNTAX_DEFAULT"></a><a
///                      id="rpc_c_ns_syntax_default"></a><dl> <dt><b>RPC_C_NS_SYNTAX_DEFAULT</b></dt> </dl> </td> <td width="60%"> Use
///                      the syntax specified in the registry value <b>HKEY_LOCAL_MACHINE\ Software\Microsoft\Rpc\ NameService\
///                      DefaultSyntax </b> </td> </tr> <tr> <td width="40%"><a id="RPC_C_NS_SYNTAX_DCE"></a><a
///                      id="rpc_c_ns_syntax_dce"></a><dl> <dt><b>RPC_C_NS_SYNTAX_DCE</b></dt> </dl> </td> <td width="60%"> Use DCE
///                      syntax. </td> </tr> </table>
///    GroupName = Pointer to the name of the name-service group to delete.
///Returns:
///    This function returns one of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl> </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td
///    width="60%"> The name syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td> <td width="60%"> The name is incomplete. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was
///    not found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsGroupDeleteW(uint GroupNameSyntax, ushort* GroupName);

///The <b>RpcNsGroupMbrAdd</b> function adds an entry name to a group. If necessary, it creates the entry. <div
///class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating systems.</div><div>
///</div>
///Params:
///    GroupNameSyntax = Syntax of <i>GroupName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    GroupName = Pointer to the name of the RPC group to receive a new member.
///    MemberNameSyntax = Syntax to use in <i>MemberName</i>. To use the syntax specified in the registry value entry
///                       <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                       RPC_C_NS_SYNTAX_DEFAULT.
///    MemberName = Pointer to the name of the new RPC group member.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The name service is unavailable.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsGroupMbrAddW(uint GroupNameSyntax, ushort* GroupName, uint MemberNameSyntax, ushort* MemberName);

///The <b>RpcNsGroupMbrRemove</b> function removes an entry name from a group. <div class="alert"><b>Note</b> This
///function is not supported on Windows Vista and later operating systems.</div><div> </div>
///Params:
///    GroupNameSyntax = Syntax of <i>GroupName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    GroupName = Pointer to the name of the RPC group from which to remove the member name.
///    MemberNameSyntax = Syntax to use in the <i>MemberName</i> parameter. To use the syntax specified in the registry value entry
///                       <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                       RPC_C_NS_SYNTAX_DEFAULT.
///    MemberName = Pointer to the name of the member to remove from the RPC group attribute in the entry <i>GroupName</i>.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was not found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
///    name service is unavailable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_GROUP_MEMBER_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> The group member was not found. </td> </tr> </table> <div class="alert"><b>Note</b>
///    For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsGroupMbrRemoveW(uint GroupNameSyntax, ushort* GroupName, uint MemberNameSyntax, ushort* MemberName);

///The <b>RpcNsGroupMbrInqBegin</b> function creates an inquiry context for viewing group members. <div
///class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating systems.</div><div>
///</div>
///Params:
///    GroupNameSyntax = Syntax of <i>GroupName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    GroupName = Pointer to the name of the RPC group to view.
///    MemberNameSyntax = Syntax of the return parameter, <i>MemberName</i>, in the RpcNsGroupMbrInqNext function. To use the syntax
///                       specified in the registry value entry <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>,
///                       provide a value of RPC_C_NS_SYNTAX_DEFAULT.
///    InquiryContext = Returns a pointer to a name-service handle for use with the RpcNsGroupMbrInqNext and RpcNsGroupMbrInqDone
///                     functions.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was not found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
///    name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes,
///    see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsGroupMbrInqBeginW(uint GroupNameSyntax, ushort* GroupName, uint MemberNameSyntax, void** InquiryContext);

///The <b>RpcNsGroupMbrInqNext</b> function returns one entry name from a group at a time. <div
///class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating systems.</div><div>
///</div>
///Params:
///    InquiryContext = Name service handle.
///    MemberName = Returns the address of a pointer to an RPC group member name. The syntax of the returned name was specified by
///                 the <i>MemberNameSyntax</i> parameter in the RpcNsGroupMbrInqBegin function. Specify a null value to prevent
///                 <b>RpcNsGroupMbrInqNext</b> from returning the <i>MemberName</i> parameter. In this case, the application does
///                 not call the RpcStringFree function.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NS_HANDLE</b></dt> </dl> </td> <td width="60%"> The name-service handle is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NO_MORE_MEMBERS</b></dt> </dl> </td> <td width="60%"> No more
///    members. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsGroupMbrInqNextW(void* InquiryContext, ushort** MemberName);

///The <b>RpcNsGroupMbrInqDone</b> function deletes the inquiry context for a group. <div class="alert"><b>Note</b> This
///function is not supported on Windows Vista and later operating systems.</div><div> </div>
///Params:
///    InquiryContext = Pointer to a name-service handle to free. A value of NULL is returned.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NS_HANDLE</b></dt> </dl> </td> <td width="60%"> The name-service handle is invalid. </td>
///    </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCNS4")
int RpcNsGroupMbrInqDone(void** InquiryContext);

///The <b>RpcNsProfileDelete</b> function deletes a profile attribute. <div class="alert"><b>Note</b> This function is
///not supported on Windows Vista and later operating systems.</div><div> </div>
///Params:
///    ProfileNameSyntax = Integer value indicating the syntax of the next parameter, <i>ProfileName</i>. To use the syntax specified in the
///                        registry value <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                        RPC_C_NS_SYNTAX_DEFAULT.
///    ProfileName = Pointer to the name of the profile to delete.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was not found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
///    name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes,
///    see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsProfileDeleteA(uint ProfileNameSyntax, ubyte* ProfileName);

///The <b>RpcNsProfileEltAdd</b> function adds an element to a profile. If necessary, it creates the entry. <div
///class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating systems.</div><div>
///</div>
///Params:
///    ProfileNameSyntax = Syntax of <i>ProfileName</i>. To use the syntax specified in the registry value entry
///                        <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                        RPC_C_NS_SYNTAX_DEFAULT.
///    ProfileName = Pointer to the name of the profile to receive a new element.
///    IfId = Pointer to the interface identification of the new profile element. To add or replace the default profile
///           element, specify a null value.
///    MemberNameSyntax = Syntax of <i>MemberName</i>. To use the syntax specified in the registry value entry
///                       <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                       RPC_C_NS_SYNTAX_DEFAULT.
///    MemberName = Pointer to a name service–entry name to include in the new profile element.
///    Priority = Integer value (0 through 7) that indicates the relative priority for using the new profile element during the
///               import and lookup operations. A value of 0 is the highest priority; a value of 7 is the lowest priority. When
///               adding a default profile member, use a value of 0.
///    Annotation = Pointer to an annotation string stored as part of the new profile element. Specify a null value or a
///                 null-terminated string if there is no annotation string. The string is used by applications for informational
///                 purposes only. For example, an application can use this string to store the interface-name string specified in
///                 the IDL file. RPC does not use the annotation string during lookup or import operations or for enumerating
///                 profile elements.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The name service is unavailable.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsProfileEltAddA(uint ProfileNameSyntax, ubyte* ProfileName, RPC_IF_ID* IfId, uint MemberNameSyntax, 
                        ubyte* MemberName, uint Priority, ubyte* Annotation);

///The <b>RpcNsProfileEltRemove</b> function removes an element from a profile. <div class="alert"><b>Note</b> This
///function is not supported on Windows Vista and later operating systems.</div><div> </div>
///Params:
///    ProfileNameSyntax = Syntax of <i>ProfileName</i>. To use the syntax specified in the registry value entry
///                        <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                        RPC_C_NS_SYNTAX_DEFAULT.
///    ProfileName = Pointer to the name of the profile from which to remove an element.
///    IfId = Pointer to the interface identification of the profile element to be removed. Specify a null value to remove the
///           default profile member.
///    MemberNameSyntax = Syntax of <i>MemberName</i>. To use the syntax specified in the registry value entry
///                       <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                       RPC_C_NS_SYNTAX_DEFAULT.
///    MemberName = Pointer to the name service–entry name in the profile element to remove.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was not found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
///    name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes,
///    see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsProfileEltRemoveA(uint ProfileNameSyntax, ubyte* ProfileName, RPC_IF_ID* IfId, uint MemberNameSyntax, 
                           ubyte* MemberName);

///The <b>RpcNsProfileEltInqBegin</b> function creates an inquiry context for viewing the elements in a profile. <div
///class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating systems.</div><div>
///</div>
///Params:
///    ProfileNameSyntax = Syntax of <i>ProfileName</i>. To use the syntax specified in the registry value entry
///                        <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                        RPC_C_NS_SYNTAX_DEFAULT.
///    ProfileName = Pointer to the name of the profile to view.
///    InquiryType = Type of inquiry to perform on the profile. The following table lists valid inquiry types. <table> <tr>
///                  <th>Inquiry type</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RPC_C_PROFILE_DEFAULT_ELT"></a><a
///                  id="rpc_c_profile_default_elt"></a><dl> <dt><b>RPC_C_PROFILE_DEFAULT_ELT</b></dt> </dl> </td> <td width="60%">
///                  Searches the profile for the default profile element, if any. The <i>IfId</i>, <i>VersOption</i>, and
///                  <i>MemberName</i> parameters are ignored. </td> </tr> <tr> <td width="40%"><a id="RPC_C_PROFILE_ALL_ELTS"></a><a
///                  id="rpc_c_profile_all_elts"></a><dl> <dt><b>RPC_C_PROFILE_ALL_ELTS</b></dt> </dl> </td> <td width="60%"> Returns
///                  every element from the profile. The <i>IfId</i>, <i>VersOption</i>, and <i>MemberName</i> parameters are ignored.
///                  </td> </tr> <tr> <td width="40%"><a id="RPC_C_PROFILE_MATCH_BY_IF"></a><a id="rpc_c_profile_match_by_if"></a><dl>
///                  <dt><b>RPC_C_PROFILE_MATCH_BY_IF</b></dt> </dl> </td> <td width="60%"> Searches the profile for elements that
///                  contain the interface identification specified by <i>IfId</i> and <i>VersOption</i>. The <i>MemberName</i>
///                  parameter is ignored. </td> </tr> <tr> <td width="40%"><a id="RPC_C_PROFILE_MATCH_BY_MBR"></a><a
///                  id="rpc_c_profile_match_by_mbr"></a><dl> <dt><b>RPC_C_PROFILE_MATCH_BY_MBR</b></dt> </dl> </td> <td width="60%">
///                  Searches the profile for elements that contain <i>MemberName</i>. The <i>IfId</i> and <i>VersOption</i>
///                  parameters are ignored. </td> </tr> <tr> <td width="40%"><a id="RPC_C_PROFILE_MATCH_BY_BOTH"></a><a
///                  id="rpc_c_profile_match_by_both"></a><dl> <dt><b>RPC_C_PROFILE_MATCH_BY_BOTH</b></dt> </dl> </td> <td
///                  width="60%"> Searches the profile for elements that contain the interface identification and member identified by
///                  the <i>IfId</i>, <i>VersOption</i>, and <i>MemberName</i> parameters. </td> </tr> </table>
///    IfId = Pointer to the interface identification of the profile elements to be returned by the RpcNsProfileEltInqNext
///           function. The <i>IfId</i> parameter is used only when specifying a value of RPC_C_PROFILE_MATCH_BY_IF or
///           RPC_C_PROFILE_MATCH_BY_BOTH for the <i>InquiryType</i> parameter. Otherwise, <i>IfId</i> is ignored and a null
///           value can be specified.
///    VersOption = Specifies how the RpcNsProfileEltInqNext function uses the <i>IfId</i> parameter. This parameter is used only
///                 when specifying a value of RPC_C_PROFILE_MATCH_BY_IF or RPC_C_PROFILE_MATCH_BY_BOTH for <i>InquiryType</i>.
///                 Otherwise, this parameter is ignored and a 0 value can be specified. The following table describes valid values
///                 for <i>VersOption</i>. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                 id="RPC_C_VERS_ALL"></a><a id="rpc_c_vers_all"></a><dl> <dt><b>RPC_C_VERS_ALL</b></dt> </dl> </td> <td
///                 width="60%"> Returns profile elements that offer the specified interface UUID, regardless of the version numbers.
///                 For this value, specify 0 for both the major and minor versions in <i>IfId</i>. </td> </tr> <tr> <td
///                 width="40%"><a id="RPC_C_VERS_COMPATIBLE"></a><a id="rpc_c_vers_compatible"></a><dl>
///                 <dt><b>RPC_C_VERS_COMPATIBLE</b></dt> </dl> </td> <td width="60%"> Returns profile elements that offer the same
///                 major version of the specified interface UUID and a minor version greater than or equal to the minor version of
///                 the specified interface UUID. </td> </tr> <tr> <td width="40%"><a id="RPC_C_VERS_EXACT"></a><a
///                 id="rpc_c_vers_exact"></a><dl> <dt><b>RPC_C_VERS_EXACT</b></dt> </dl> </td> <td width="60%"> Returns profile
///                 elements that offer the specified version of the specified interface UUID. </td> </tr> <tr> <td width="40%"><a
///                 id="RPC_C_VERS_MAJOR_ONLY"></a><a id="rpc_c_vers_major_only"></a><dl> <dt><b>RPC_C_VERS_MAJOR_ONLY</b></dt> </dl>
///                 </td> <td width="60%"> Returns profile elements that offer the same major version of the specified interface UUID
///                 (ignores the minor version). For this value, specify 0 for the minor version in <i>IfId</i>. </td> </tr> <tr> <td
///                 width="40%"><a id="RPC_C_VERS_UPTO"></a><a id="rpc_c_vers_upto"></a><dl> <dt><b>RPC_C_VERS_UPTO</b></dt> </dl>
///                 </td> <td width="60%"> Returns profile elements that offer a version of the specified interface UUID less than or
///                 equal to the specified major and minor version. (For example, if the <i>IfId</i> contained V2.0 and the profile
///                 contained elements with V1.3, V2.0, and V2.1, the RpcNsProfileEltInqNext function returns elements with V1.3 and
///                 V2.0.) </td> </tr> </table>
///    MemberNameSyntax = Syntax of <i>MemberName</i>, and the return parameter <i>MemberName</i> in the RpcNsProfileEltInqNext function.
///                       To use the syntax specified in the registry value entry
///                       <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                       RPC_C_NS_SYNTAX_DEFAULT.
///    MemberName = Pointer to the member name that the RpcNsProfileEltInqNext function looks for in profile elements. The
///                 <i>MemberName</i> parameter is used only when specifying a value of RPC_C_PROFILE_MATCH_BY_MBR or
///                 RPC_C_PROFILE_MATCH_BY_BOTH for <i>InquiryType</i>. Otherwise, <i>MemberName</i> is ignored and a null value can
///                 be specified.
///    InquiryContext = Returns a pointer to a name-service handle for use with the RpcNsProfileEltInqNext and RpcNsProfileEltInqDone
///                     functions.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_VERS_OPTION</b></dt> </dl> </td> <td width="60%"> The version option is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td
///    width="60%"> The name syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td> <td width="60%"> The name is incomplete. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was
///    not found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsProfileEltInqBeginA(uint ProfileNameSyntax, ubyte* ProfileName, uint InquiryType, RPC_IF_ID* IfId, 
                             uint VersOption, uint MemberNameSyntax, ubyte* MemberName, void** InquiryContext);

///The <b>RpcNsProfileEltInqNext</b> function returns one element at a time from a profile. <div
///class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating systems.</div><div>
///</div>
///Params:
///    InquiryContext = Name-service handle returned from the RpcNsProfileEltInqBegin function.
///    IfId = Returns a pointer to the interface identification of the profile element.
///    MemberName = Returns a pointer to a pointer to the profile element's member name.The syntax of the returned name was specified
///                 by the <i>MemberNameSyntax</i> parameter in the RpcNsProfileEltInqBegin function. Specify a null value to prevent
///                 <b>RpcNsProfileEltInqNext</b> from returning the <i>MemberName</i> parameter. In this case, the application does
///                 not call the RpcStringFree function.
///    Priority = Returns a pointer to the profile-element priority.
///    Annotation = Returns a pointer to a pointer to the annotation string for the profile element. If there is no annotation string
///                 in the profile element, the string \0 is returned. Specify a null value to prevent <b>RpcNsProfileEltInqNext</b>
///                 from returning the <i>Annotation</i> parameter. In this case, the application does not need to call the
///                 RpcStringFree function.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td> <td width="60%"> The name is incomplete. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The name service is
///    unavailable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NO_MORE_ELEMENTS</b></dt> </dl> </td> <td
///    width="60%"> No more elements. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error
///    codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsProfileEltInqNextA(void* InquiryContext, RPC_IF_ID* IfId, ubyte** MemberName, uint* Priority, 
                            ubyte** Annotation);

///The <b>RpcNsProfileDelete</b> function deletes a profile attribute. <div class="alert"><b>Note</b> This function is
///not supported on Windows Vista and later operating systems.</div><div> </div>
///Params:
///    ProfileNameSyntax = Integer value indicating the syntax of the next parameter, <i>ProfileName</i>. To use the syntax specified in the
///                        registry value <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                        RPC_C_NS_SYNTAX_DEFAULT.
///    ProfileName = Pointer to the name of the profile to delete.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was not found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
///    name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes,
///    see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsProfileDeleteW(uint ProfileNameSyntax, ushort* ProfileName);

///The <b>RpcNsProfileEltAdd</b> function adds an element to a profile. If necessary, it creates the entry. <div
///class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating systems.</div><div>
///</div>
///Params:
///    ProfileNameSyntax = Syntax of <i>ProfileName</i>. To use the syntax specified in the registry value entry
///                        <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                        RPC_C_NS_SYNTAX_DEFAULT.
///    ProfileName = Pointer to the name of the profile to receive a new element.
///    IfId = Pointer to the interface identification of the new profile element. To add or replace the default profile
///           element, specify a null value.
///    MemberNameSyntax = Syntax of <i>MemberName</i>. To use the syntax specified in the registry value entry
///                       <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                       RPC_C_NS_SYNTAX_DEFAULT.
///    MemberName = Pointer to a name service–entry name to include in the new profile element.
///    Priority = Integer value (0 through 7) that indicates the relative priority for using the new profile element during the
///               import and lookup operations. A value of 0 is the highest priority; a value of 7 is the lowest priority. When
///               adding a default profile member, use a value of 0.
///    Annotation = Pointer to an annotation string stored as part of the new profile element. Specify a null value or a
///                 null-terminated string if there is no annotation string. The string is used by applications for informational
///                 purposes only. For example, an application can use this string to store the interface-name string specified in
///                 the IDL file. RPC does not use the annotation string during lookup or import operations or for enumerating
///                 profile elements.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The name service is unavailable.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsProfileEltAddW(uint ProfileNameSyntax, ushort* ProfileName, RPC_IF_ID* IfId, uint MemberNameSyntax, 
                        ushort* MemberName, uint Priority, ushort* Annotation);

///The <b>RpcNsProfileEltRemove</b> function removes an element from a profile. <div class="alert"><b>Note</b> This
///function is not supported on Windows Vista and later operating systems.</div><div> </div>
///Params:
///    ProfileNameSyntax = Syntax of <i>ProfileName</i>. To use the syntax specified in the registry value entry
///                        <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                        RPC_C_NS_SYNTAX_DEFAULT.
///    ProfileName = Pointer to the name of the profile from which to remove an element.
///    IfId = Pointer to the interface identification of the profile element to be removed. Specify a null value to remove the
///           default profile member.
///    MemberNameSyntax = Syntax of <i>MemberName</i>. To use the syntax specified in the registry value entry
///                       <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                       RPC_C_NS_SYNTAX_DEFAULT.
///    MemberName = Pointer to the name service–entry name in the profile element to remove.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was not found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
///    name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes,
///    see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsProfileEltRemoveW(uint ProfileNameSyntax, ushort* ProfileName, RPC_IF_ID* IfId, uint MemberNameSyntax, 
                           ushort* MemberName);

///The <b>RpcNsProfileEltInqBegin</b> function creates an inquiry context for viewing the elements in a profile. <div
///class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating systems.</div><div>
///</div>
///Params:
///    ProfileNameSyntax = Syntax of <i>ProfileName</i>. To use the syntax specified in the registry value entry
///                        <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                        RPC_C_NS_SYNTAX_DEFAULT.
///    ProfileName = Pointer to the name of the profile to view.
///    InquiryType = Type of inquiry to perform on the profile. The following table lists valid inquiry types. <table> <tr>
///                  <th>Inquiry type</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RPC_C_PROFILE_DEFAULT_ELT"></a><a
///                  id="rpc_c_profile_default_elt"></a><dl> <dt><b>RPC_C_PROFILE_DEFAULT_ELT</b></dt> </dl> </td> <td width="60%">
///                  Searches the profile for the default profile element, if any. The <i>IfId</i>, <i>VersOption</i>, and
///                  <i>MemberName</i> parameters are ignored. </td> </tr> <tr> <td width="40%"><a id="RPC_C_PROFILE_ALL_ELTS"></a><a
///                  id="rpc_c_profile_all_elts"></a><dl> <dt><b>RPC_C_PROFILE_ALL_ELTS</b></dt> </dl> </td> <td width="60%"> Returns
///                  every element from the profile. The <i>IfId</i>, <i>VersOption</i>, and <i>MemberName</i> parameters are ignored.
///                  </td> </tr> <tr> <td width="40%"><a id="RPC_C_PROFILE_MATCH_BY_IF"></a><a id="rpc_c_profile_match_by_if"></a><dl>
///                  <dt><b>RPC_C_PROFILE_MATCH_BY_IF</b></dt> </dl> </td> <td width="60%"> Searches the profile for elements that
///                  contain the interface identification specified by <i>IfId</i> and <i>VersOption</i>. The <i>MemberName</i>
///                  parameter is ignored. </td> </tr> <tr> <td width="40%"><a id="RPC_C_PROFILE_MATCH_BY_MBR"></a><a
///                  id="rpc_c_profile_match_by_mbr"></a><dl> <dt><b>RPC_C_PROFILE_MATCH_BY_MBR</b></dt> </dl> </td> <td width="60%">
///                  Searches the profile for elements that contain <i>MemberName</i>. The <i>IfId</i> and <i>VersOption</i>
///                  parameters are ignored. </td> </tr> <tr> <td width="40%"><a id="RPC_C_PROFILE_MATCH_BY_BOTH"></a><a
///                  id="rpc_c_profile_match_by_both"></a><dl> <dt><b>RPC_C_PROFILE_MATCH_BY_BOTH</b></dt> </dl> </td> <td
///                  width="60%"> Searches the profile for elements that contain the interface identification and member identified by
///                  the <i>IfId</i>, <i>VersOption</i>, and <i>MemberName</i> parameters. </td> </tr> </table>
///    IfId = Pointer to the interface identification of the profile elements to be returned by the RpcNsProfileEltInqNext
///           function. The <i>IfId</i> parameter is used only when specifying a value of RPC_C_PROFILE_MATCH_BY_IF or
///           RPC_C_PROFILE_MATCH_BY_BOTH for the <i>InquiryType</i> parameter. Otherwise, <i>IfId</i> is ignored and a null
///           value can be specified.
///    VersOption = Specifies how the RpcNsProfileEltInqNext function uses the <i>IfId</i> parameter. This parameter is used only
///                 when specifying a value of RPC_C_PROFILE_MATCH_BY_IF or RPC_C_PROFILE_MATCH_BY_BOTH for <i>InquiryType</i>.
///                 Otherwise, this parameter is ignored and a 0 value can be specified. The following table describes valid values
///                 for <i>VersOption</i>. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                 id="RPC_C_VERS_ALL"></a><a id="rpc_c_vers_all"></a><dl> <dt><b>RPC_C_VERS_ALL</b></dt> </dl> </td> <td
///                 width="60%"> Returns profile elements that offer the specified interface UUID, regardless of the version numbers.
///                 For this value, specify 0 for both the major and minor versions in <i>IfId</i>. </td> </tr> <tr> <td
///                 width="40%"><a id="RPC_C_VERS_COMPATIBLE"></a><a id="rpc_c_vers_compatible"></a><dl>
///                 <dt><b>RPC_C_VERS_COMPATIBLE</b></dt> </dl> </td> <td width="60%"> Returns profile elements that offer the same
///                 major version of the specified interface UUID and a minor version greater than or equal to the minor version of
///                 the specified interface UUID. </td> </tr> <tr> <td width="40%"><a id="RPC_C_VERS_EXACT"></a><a
///                 id="rpc_c_vers_exact"></a><dl> <dt><b>RPC_C_VERS_EXACT</b></dt> </dl> </td> <td width="60%"> Returns profile
///                 elements that offer the specified version of the specified interface UUID. </td> </tr> <tr> <td width="40%"><a
///                 id="RPC_C_VERS_MAJOR_ONLY"></a><a id="rpc_c_vers_major_only"></a><dl> <dt><b>RPC_C_VERS_MAJOR_ONLY</b></dt> </dl>
///                 </td> <td width="60%"> Returns profile elements that offer the same major version of the specified interface UUID
///                 (ignores the minor version). For this value, specify 0 for the minor version in <i>IfId</i>. </td> </tr> <tr> <td
///                 width="40%"><a id="RPC_C_VERS_UPTO"></a><a id="rpc_c_vers_upto"></a><dl> <dt><b>RPC_C_VERS_UPTO</b></dt> </dl>
///                 </td> <td width="60%"> Returns profile elements that offer a version of the specified interface UUID less than or
///                 equal to the specified major and minor version. (For example, if the <i>IfId</i> contained V2.0 and the profile
///                 contained elements with V1.3, V2.0, and V2.1, the RpcNsProfileEltInqNext function returns elements with V1.3 and
///                 V2.0.) </td> </tr> </table>
///    MemberNameSyntax = Syntax of <i>MemberName</i>, and the return parameter <i>MemberName</i> in the RpcNsProfileEltInqNext function.
///                       To use the syntax specified in the registry value entry
///                       <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                       RPC_C_NS_SYNTAX_DEFAULT.
///    MemberName = Pointer to the member name that the RpcNsProfileEltInqNext function looks for in profile elements. The
///                 <i>MemberName</i> parameter is used only when specifying a value of RPC_C_PROFILE_MATCH_BY_MBR or
///                 RPC_C_PROFILE_MATCH_BY_BOTH for <i>InquiryType</i>. Otherwise, <i>MemberName</i> is ignored and a null value can
///                 be specified.
///    InquiryContext = Returns a pointer to a name-service handle for use with the RpcNsProfileEltInqNext and RpcNsProfileEltInqDone
///                     functions.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_VERS_OPTION</b></dt> </dl> </td> <td width="60%"> The version option is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td
///    width="60%"> The name syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td> <td width="60%"> The name is incomplete. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was
///    not found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsProfileEltInqBeginW(uint ProfileNameSyntax, ushort* ProfileName, uint InquiryType, RPC_IF_ID* IfId, 
                             uint VersOption, uint MemberNameSyntax, ushort* MemberName, void** InquiryContext);

///The <b>RpcNsProfileEltInqNext</b> function returns one element at a time from a profile. <div
///class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating systems.</div><div>
///</div>
///Params:
///    InquiryContext = Name-service handle returned from the RpcNsProfileEltInqBegin function.
///    IfId = Returns a pointer to the interface identification of the profile element.
///    MemberName = Returns a pointer to a pointer to the profile element's member name.The syntax of the returned name was specified
///                 by the <i>MemberNameSyntax</i> parameter in the RpcNsProfileEltInqBegin function. Specify a null value to prevent
///                 <b>RpcNsProfileEltInqNext</b> from returning the <i>MemberName</i> parameter. In this case, the application does
///                 not call the RpcStringFree function.
///    Priority = Returns a pointer to the profile-element priority.
///    Annotation = Returns a pointer to a pointer to the annotation string for the profile element. If there is no annotation string
///                 in the profile element, the string \0 is returned. Specify a null value to prevent <b>RpcNsProfileEltInqNext</b>
///                 from returning the <i>Annotation</i> parameter. In this case, the application does not need to call the
///                 RpcStringFree function.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td> <td width="60%"> The name is incomplete. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The name service is
///    unavailable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NO_MORE_ELEMENTS</b></dt> </dl> </td> <td
///    width="60%"> No more elements. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error
///    codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsProfileEltInqNextW(void* InquiryContext, RPC_IF_ID* IfId, ushort** MemberName, uint* Priority, 
                            ushort** Annotation);

///The <b>RpcNsProfileEltInqDone</b> function deletes the inquiry context for viewing the elements in a profile. <div
///class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating systems.</div><div>
///</div>
///Params:
///    InquiryContext = Pointer to a name-service handle to free. The name-service handle that <i>InquiryContext</i> points to is created
///                     by calling the RpcNsProfileEltInqBegin function. An argument value of NULL is returned.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsProfileEltInqDone(void** InquiryContext);

///The <b>RpcNsEntryObjectInqBegin</b> function creates an inquiry context for the objects of a name-service database
///entry. <div class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating
///systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax to use in <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to the name-service database entry name for which object UUIDs are to be viewed.
///    InquiryContext = Returns a pointer to a name-service handle for use with the RpcNsEntryObjectInqNext and RpcNsEntryObjectInqDone
///                     functions.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is unsupported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was not found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
///    name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes,
///    see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsEntryObjectInqBeginA(uint EntryNameSyntax, ubyte* EntryName, void** InquiryContext);

///The <b>RpcNsEntryObjectInqBegin</b> function creates an inquiry context for the objects of a name-service database
///entry. <div class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating
///systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax to use in <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to the name-service database entry name for which object UUIDs are to be viewed.
///    InquiryContext = Returns a pointer to a name-service handle for use with the RpcNsEntryObjectInqNext and RpcNsEntryObjectInqDone
///                     functions.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is unsupported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was not found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
///    name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes,
///    see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsEntryObjectInqBeginW(uint EntryNameSyntax, ushort* EntryName, void** InquiryContext);

///The <b>RpcNsEntryObjectInqNext</b> function returns one object at a time from a name-service database entry. <div
///class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating systems.</div><div>
///</div>
///Params:
///    InquiryContext = Name-service handle that indicates the object UUIDs for a name-service database entry.
///    ObjUuid = Returns a pointer to an exported object UUID.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_MORE_MEMBERS</b></dt> </dl> </td> <td width="60%"> No more members. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td> <td width="60%"> The name is incomplete.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The
///    name-service entry was not found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The name service is unavailable.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsEntryObjectInqNext(void* InquiryContext, GUID* ObjUuid);

///The <b>RpcNsEntryObjectInqDone</b> function deletes the inquiry context for a name-service database entry's objects.
///<div class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating
///systems.</div><div> </div>
///Params:
///    InquiryContext = Pointer to a name-service handle specifying the object UUIDs exported to the <i>EntryName</i> parameter specified
///                     in the RpcNsEntryObjectInqBegin function. An argument value of <b>NULL</b> is returned.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsEntryObjectInqDone(void** InquiryContext);

///The <b>RpcNsEntryExpandName</b> function expands a name-service entry name. This function is supported by Active
///Directory. <div class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating
///systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax of <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      <b>RPC_C_NS_SYNTAX_DEFAULT</b>.
///    EntryName = Pointer to the entry name to expand.
///    ExpandedName = Returns a pointer to a pointer to the expanded version of <i>EntryName</i>.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td> <td width="60%"> The name is incomplete. </td> </tr> </table>
///    <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsEntryExpandNameA(uint EntryNameSyntax, ubyte* EntryName, ubyte** ExpandedName);

///The <b>RpcNsMgmtBindingUnexport</b> function removes multiple binding handles and objects from an entry in the
///name-service database. <div class="alert"><b>Note</b> This function is not supported on Windows Vista and later
///operating systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax of <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to the name of the entry from which to remove binding handles and object UUIDs.
///    IfId = Pointer to an interface identification. A null parameter value indicates that binding handles are not to be
///           unexported—only object UUIDs are to be unexported.
///    VersOption = Specifies how the <b>RpcNsMgmtBindingUnexport</b> function uses the <b>VersMajor</b> and <b>VersMinor</b> members
///                 of the structure pointed to by the <i>IfId</i> parameter. The following table describes valid values for the
///                 <i>VersOption</i> parameter. <table> <tr> <th>VersOption values</th> <th>Meaning</th> </tr> <tr> <td
///                 width="40%"><a id="RPC_C_VERS_ALL"></a><a id="rpc_c_vers_all"></a><dl> <dt><b>RPC_C_VERS_ALL</b></dt> </dl> </td>
///                 <td width="60%"> Unexports all bindings for the interface UUID in <i>IfId</i>, regardless of the version numbers.
///                 For this value, specify 0 for both the major and minor versions in <i>IfId</i>. </td> </tr> <tr> <td
///                 width="40%"><a id="RPC_C_VERS_IF_ID"></a><a id="rpc_c_vers_if_id"></a><dl> <dt><b>RPC_C_VERS_IF_ID</b></dt> </dl>
///                 </td> <td width="60%"> Unexports the bindings for the compatible interface UUID in <i>IfId</i> with the same
///                 major version and with a minor version greater than or equal to the minor version in <i>IfId</i>. </td> </tr>
///                 <tr> <td width="40%"><a id="RPC_C_VERS_EXACT"></a><a id="rpc_c_vers_exact"></a><dl>
///                 <dt><b>RPC_C_VERS_EXACT</b></dt> </dl> </td> <td width="60%"> Unexports the bindings for the interface UUID in
///                 <i>IfId</i> with the same major and minor versions as in <i>IfId</i>. </td> </tr> <tr> <td width="40%"><a
///                 id="RPC_C_VERS_MAJOR_ONLY"></a><a id="rpc_c_vers_major_only"></a><dl> <dt><b>RPC_C_VERS_MAJOR_ONLY</b></dt> </dl>
///                 </td> <td width="60%"> Unexports the bindings for the interface UUID in <i>IfId</i> with the same major version
///                 as in <i>IfId</i> (ignores the minor version). For this value, specify 0 for the minor version in <i>IfId</i>.
///                 </td> </tr> <tr> <td width="40%"><a id="RPC_C_VERS_UPTO"></a><a id="rpc_c_vers_upto"></a><dl>
///                 <dt><b>RPC_C_VERS_UPTO</b></dt> </dl> </td> <td width="60%"> Unexports the bindings that offer a version of the
///                 specified interface UUID less than or equal to the specified major and minor version. (For example, if the
///                 <i>IfId</i> contained V2.0 and the name service–database entry contained binding handles with the versions 1.3,
///                 2.0, and 2.1, the <b>RpcNsMgmtBindingUnexport</b> function would unexport the binding handles with versions 1.3
///                 and 2.0.) </td> </tr> </table>
///    ObjectUuidVec = Pointer to a vector of object UUIDs that the server no longer wants to offer. The application constructs this
///                    vector. A null value indicates there are no object UUIDs to unexport—only binding handles are to be unexported.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_VERS_OPTION</b></dt> </dl> </td> <td width="60%"> The version option is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td
///    width="60%"> The name syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td> <td width="60%"> The name is incomplete. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was
///    not found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The name service is unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INTERFACE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The interface was not found. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_NOT_ALL_OBJS_UNEXPORTED</b></dt> </dl> </td> <td width="60%"> Not all
///    objects unexported. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC
///    Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsMgmtBindingUnexportA(uint EntryNameSyntax, ubyte* EntryName, RPC_IF_ID* IfId, uint VersOption, 
                              UUID_VECTOR* ObjectUuidVec);

///The <b>RpcNsMgmtEntryCreate</b> function creates a name service–database entry. <div class="alert"><b>Note</b> This
///function is not supported on Windows Vista and later operating systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax of <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to the name of the entry to create.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ENTRY_ALREADY_EXISTS</b></dt> </dl> </td> <td width="60%"> The name-service entry already exists.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsMgmtEntryCreateA(uint EntryNameSyntax, ubyte* EntryName);

///The <b>RpcNsMgmtEntryDelete</b> function deletes a name service–database entry. <div class="alert"><b>Note</b> This
///function is not supported on Windows Vista and later operating systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax of <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to the name of the entry to delete.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was not found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
///    name service is unavailable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NOT_RPC_ENTRY</b></dt> </dl>
///    </td> <td width="60%"> Not an RPC entry. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid
///    error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsMgmtEntryDeleteA(uint EntryNameSyntax, ubyte* EntryName);

///The <b>RpcNsMgmtEntryInqIfIds</b> function returns the list of interfaces exported to a name service–database
///entry. It also returns an interface-identification vector containing the interfaces of binding handles exported by a
///server to <i>EntryName</i>. This function uses an expiration age of 0, causing an immediate update of the local copy
///of name-service data. <div class="alert"><b>Note</b> This function is not supported on Windows Vista and later
///operating systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax of <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to the name service–database entry name for which an interface-identification vector is returned.
///    IfIdVec = Returns an address of a pointer to the interface-identification vector.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was not found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
///    name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes,
///    see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsMgmtEntryInqIfIdsA(uint EntryNameSyntax, ubyte* EntryName, RPC_IF_ID_VECTOR** IfIdVec);

///The <b>RpcNsMgmtHandleSetExpAge</b> function sets the expiration age of a name-service handle for local copies of
///name-service data. <div class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating
///systems.</div><div> </div>
///Params:
///    NsHandle = Name-service handle for which an expiration age is set. A name-service handle is returned from a name service
///               begin operation.
///    ExpirationAge = Integer value, in seconds, that sets the expiration age of local name-service data read by all next routines
///                    using the specified <i>NsHandle</i> parameter. An expiration age of 0 causes an immediate update of the local
///                    name-service data.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The name service is unavailable.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsMgmtHandleSetExpAge(void* NsHandle, uint ExpirationAge);

///The <b>RpcNsMgmtInqExpAge</b> function returns the global expiration age for local copies of name-service data. <div
///class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating systems.</div><div>
///</div>
///Params:
///    ExpirationAge = Pointer to the default expiration age, in seconds. This value is used by all name service next operations.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsMgmtInqExpAge(uint* ExpirationAge);

///The <b>RpcNsMgmtSetExpAge</b> function modifies the application's global expiration age for local copies of
///name-service data. <div class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating
///systems.</div><div> </div>
///Params:
///    ExpirationAge = Pointer to the default expiration age, in seconds. This value is used by all name service–next operations. An
///                    expiration age of 0 causes an immediate update of the local name-service data. To reset the expiration age to an
///                    RPC-assigned default value of two hours, specify a value of RPC_C_NS_DEFAULT_EXP_AGE.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The name service is unavailable.
///    </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsMgmtSetExpAge(uint ExpirationAge);

///The <b>RpcNsEntryExpandName</b> function expands a name-service entry name. This function is supported by Active
///Directory. <div class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating
///systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax of <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      <b>RPC_C_NS_SYNTAX_DEFAULT</b>.
///    EntryName = Pointer to the entry name to expand.
///    ExpandedName = Returns a pointer to a pointer to the expanded version of <i>EntryName</i>.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td> <td width="60%"> The name is incomplete. </td> </tr> </table>
///    <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsEntryExpandNameW(uint EntryNameSyntax, ushort* EntryName, ushort** ExpandedName);

///The <b>RpcNsMgmtBindingUnexport</b> function removes multiple binding handles and objects from an entry in the
///name-service database. <div class="alert"><b>Note</b> This function is not supported on Windows Vista and later
///operating systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax of <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to the name of the entry from which to remove binding handles and object UUIDs.
///    IfId = Pointer to an interface identification. A null parameter value indicates that binding handles are not to be
///           unexported—only object UUIDs are to be unexported.
///    VersOption = Specifies how the <b>RpcNsMgmtBindingUnexport</b> function uses the <b>VersMajor</b> and <b>VersMinor</b> members
///                 of the structure pointed to by the <i>IfId</i> parameter. The following table describes valid values for the
///                 <i>VersOption</i> parameter. <table> <tr> <th>VersOption values</th> <th>Meaning</th> </tr> <tr> <td
///                 width="40%"><a id="RPC_C_VERS_ALL"></a><a id="rpc_c_vers_all"></a><dl> <dt><b>RPC_C_VERS_ALL</b></dt> </dl> </td>
///                 <td width="60%"> Unexports all bindings for the interface UUID in <i>IfId</i>, regardless of the version numbers.
///                 For this value, specify 0 for both the major and minor versions in <i>IfId</i>. </td> </tr> <tr> <td
///                 width="40%"><a id="RPC_C_VERS_IF_ID"></a><a id="rpc_c_vers_if_id"></a><dl> <dt><b>RPC_C_VERS_IF_ID</b></dt> </dl>
///                 </td> <td width="60%"> Unexports the bindings for the compatible interface UUID in <i>IfId</i> with the same
///                 major version and with a minor version greater than or equal to the minor version in <i>IfId</i>. </td> </tr>
///                 <tr> <td width="40%"><a id="RPC_C_VERS_EXACT"></a><a id="rpc_c_vers_exact"></a><dl>
///                 <dt><b>RPC_C_VERS_EXACT</b></dt> </dl> </td> <td width="60%"> Unexports the bindings for the interface UUID in
///                 <i>IfId</i> with the same major and minor versions as in <i>IfId</i>. </td> </tr> <tr> <td width="40%"><a
///                 id="RPC_C_VERS_MAJOR_ONLY"></a><a id="rpc_c_vers_major_only"></a><dl> <dt><b>RPC_C_VERS_MAJOR_ONLY</b></dt> </dl>
///                 </td> <td width="60%"> Unexports the bindings for the interface UUID in <i>IfId</i> with the same major version
///                 as in <i>IfId</i> (ignores the minor version). For this value, specify 0 for the minor version in <i>IfId</i>.
///                 </td> </tr> <tr> <td width="40%"><a id="RPC_C_VERS_UPTO"></a><a id="rpc_c_vers_upto"></a><dl>
///                 <dt><b>RPC_C_VERS_UPTO</b></dt> </dl> </td> <td width="60%"> Unexports the bindings that offer a version of the
///                 specified interface UUID less than or equal to the specified major and minor version. (For example, if the
///                 <i>IfId</i> contained V2.0 and the name service–database entry contained binding handles with the versions 1.3,
///                 2.0, and 2.1, the <b>RpcNsMgmtBindingUnexport</b> function would unexport the binding handles with versions 1.3
///                 and 2.0.) </td> </tr> </table>
///    ObjectUuidVec = Pointer to a vector of object UUIDs that the server no longer wants to offer. The application constructs this
///                    vector. A null value indicates there are no object UUIDs to unexport—only binding handles are to be unexported.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_VERS_OPTION</b></dt> </dl> </td> <td width="60%"> The version option is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td
///    width="60%"> The name syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td> <td width="60%"> The name is incomplete. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was
///    not found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The name service is unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INTERFACE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The interface was not found. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_NOT_ALL_OBJS_UNEXPORTED</b></dt> </dl> </td> <td width="60%"> Not all
///    objects unexported. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC
///    Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsMgmtBindingUnexportW(uint EntryNameSyntax, ushort* EntryName, RPC_IF_ID* IfId, uint VersOption, 
                              UUID_VECTOR* ObjectUuidVec);

///The <b>RpcNsMgmtEntryCreate</b> function creates a name service–database entry. <div class="alert"><b>Note</b> This
///function is not supported on Windows Vista and later operating systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax of <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to the name of the entry to create.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ENTRY_ALREADY_EXISTS</b></dt> </dl> </td> <td width="60%"> The name-service entry already exists.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsMgmtEntryCreateW(uint EntryNameSyntax, ushort* EntryName);

///The <b>RpcNsMgmtEntryDelete</b> function deletes a name service–database entry. <div class="alert"><b>Note</b> This
///function is not supported on Windows Vista and later operating systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax of <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to the name of the entry to delete.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was not found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
///    name service is unavailable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NOT_RPC_ENTRY</b></dt> </dl>
///    </td> <td width="60%"> Not an RPC entry. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid
///    error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsMgmtEntryDeleteW(uint EntryNameSyntax, ushort* EntryName);

///The <b>RpcNsMgmtEntryInqIfIds</b> function returns the list of interfaces exported to a name service–database
///entry. It also returns an interface-identification vector containing the interfaces of binding handles exported by a
///server to <i>EntryName</i>. This function uses an expiration age of 0, causing an immediate update of the local copy
///of name-service data. <div class="alert"><b>Note</b> This function is not supported on Windows Vista and later
///operating systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax of <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, provide a value of
///                      RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to the name service–database entry name for which an interface-identification vector is returned.
///    IfIdVec = Returns an address of a pointer to the interface-identification vector.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name
///    syntax is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td>
///    <td width="60%"> The name is incomplete. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was not found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
///    name service is unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes,
///    see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsMgmtEntryInqIfIdsW(uint EntryNameSyntax, ushort* EntryName, RPC_IF_ID_VECTOR** IfIdVec);

///The <b>RpcNsBindingImportBegin</b> function creates an import context for importing client-compatible binding handles
///for servers that offer the specified interface and object. <div class="alert"><b>Note</b> This function is not
///supported on Windows Vista and later operating systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax of <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, specify RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to an entry name at which the search for compatible binding handles begins. To use the entry name
///                specified in the registry value entry <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultEntry</b>,
///                provide a null pointer or an empty string. In this case, the <i>EntryNameSyntax</i> parameter is ignored and the
///                run-time library uses the default syntax.
///    IfSpec = Stub-generated data structure indicating the interface to import. If the interface specification has not been
///             exported or is of no concern to the caller, specify a null value for this parameter. In this case, the bindings
///             returned are only guaranteed to be of a compatible and supported protocol sequence and to contain the specified
///             object UUID. The contacted server might not support the desired interface.
///    ObjUuid = Pointer to an optional object UUID. For a nonzero UUID, compatible binding handles are returned from an entry
///              only if the server has exported the specified object UUID. When <i>ObjUuid</i> has a null pointer value or a nil
///              UUID, the returned binding handles contain one of the object UUIDs exported by the compatible server. If the
///              server did not export any object UUIDs, the returned compatible binding handles contain a nil object UUID.
///    ImportContext = Name-service handle returned for use with the RpcNsBindingImportNext and RpcNsBindingImportDone functions.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The name
///    exceeds the maximum length. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt>
///    </dl> </td> <td width="60%"> The name syntax is unsupported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td> <td width="60%"> The name is incomplete. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was
///    not found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The name service is unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_OBJECT</b></dt> </dl> </td> <td width="60%"> Invalid object. </td> </tr> </table> <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsBindingImportBeginA(uint EntryNameSyntax, ubyte* EntryName, void* IfSpec, GUID* ObjUuid, 
                             void** ImportContext);

///The <b>RpcNsBindingImportBegin</b> function creates an import context for importing client-compatible binding handles
///for servers that offer the specified interface and object. <div class="alert"><b>Note</b> This function is not
///supported on Windows Vista and later operating systems.</div><div> </div>
///Params:
///    EntryNameSyntax = Syntax of <i>EntryName</i>. To use the syntax specified in the registry value entry
///                      <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultSyntax</b>, specify RPC_C_NS_SYNTAX_DEFAULT.
///    EntryName = Pointer to an entry name at which the search for compatible binding handles begins. To use the entry name
///                specified in the registry value entry <b>HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\NameService\DefaultEntry</b>,
///                provide a null pointer or an empty string. In this case, the <i>EntryNameSyntax</i> parameter is ignored and the
///                run-time library uses the default syntax.
///    IfSpec = Stub-generated data structure indicating the interface to import. If the interface specification has not been
///             exported or is of no concern to the caller, specify a null value for this parameter. In this case, the bindings
///             returned are only guaranteed to be of a compatible and supported protocol sequence and to contain the specified
///             object UUID. The contacted server might not support the desired interface.
///    ObjUuid = Pointer to an optional object UUID. For a nonzero UUID, compatible binding handles are returned from an entry
///              only if the server has exported the specified object UUID. When <i>ObjUuid</i> has a null pointer value or a nil
///              UUID, the returned binding handles contain one of the object UUIDs exported by the compatible server. If the
///              server did not export any object UUIDs, the returned compatible binding handles contain a nil object UUID.
///    ImportContext = Name-service handle returned for use with the RpcNsBindingImportNext and RpcNsBindingImportDone functions.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_NAME_SYNTAX</b></dt> </dl> </td> <td width="60%"> The name syntax is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The name
///    exceeds the maximum length. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_NAME_SYNTAX</b></dt>
///    </dl> </td> <td width="60%"> The name syntax is unsupported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INCOMPLETE_NAME</b></dt> </dl> </td> <td width="60%"> The name is incomplete. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_ENTRY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The name-service entry was
///    not found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The name service is unavailable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_OBJECT</b></dt> </dl> </td> <td width="60%"> Invalid object. </td> </tr> </table> <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsBindingImportBeginW(uint EntryNameSyntax, ushort* EntryName, void* IfSpec, GUID* ObjUuid, 
                             void** ImportContext);

///The <b>RpcNsBindingImportNext</b> function looks up an interface (and optionally an object from a name-service
///database) and returns a binding handle of a compatible server, if found. <div class="alert"><b>Note</b> This function
///is not supported on Windows Vista and later operating systems.</div><div> </div>
///Params:
///    ImportContext = Name-service handle returned from the RpcNsBindingImportBegin function.
///    Binding = Returns a pointer to a client-compatible server binding handle for a server.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_MORE_BINDINGS</b></dt> </dl> </td> <td width="60%"> No more bindings. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_NAME_SERVICE_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The name service is
///    unavailable. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return
///    Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsBindingImportNext(void* ImportContext, void** Binding);

///The <b>RpcNsBindingImportDone</b> function signals that a client has finished looking for a compatible server and
///deletes the import context. <div class="alert"><b>Note</b> This function is not supported on Windows Vista and later
///operating systems.</div><div> </div>
///Params:
///    ImportContext = Pointer to a name-service handle to free. The name-service handle <i>ImportContext</i> points to is created by
///                    calling the RpcNsBindingImportBegin function. An argument value of <b>NULL</b> is returned.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsBindingImportDone(void** ImportContext);

///The <b>RpcNsBindingSelect</b> function returns a binding handle from a list of compatible binding handles. <div
///class="alert"><b>Note</b> This function is not supported on Windows Vista and later operating systems.</div><div>
///</div>
///Params:
///    BindingVec = Pointer to the vector of client-compatible server binding handles from which a binding handle is selected. The
///                 returned binding vector no longer references the selected binding handle, which is returned separately in the
///                 <i>Binding</i> parameter.
///    Binding = Pointer to a selected binding handle.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_NO_MORE_BINDINGS</b></dt> </dl> </td> <td width="60%"> No more bindings. </td> </tr> </table> <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCNS4")
int RpcNsBindingSelect(RPC_BINDING_VECTOR* BindingVec, void** Binding);

///The <b>RpcAsyncRegisterInfo</b> function is obsolete.
///Params:
///    pAsync = TBD
///Returns:
///    This function does not return a value.
///    
@DllImport("RPCRT4")
int RpcAsyncRegisterInfo(RPC_ASYNC_STATE* pAsync);

///The client calls the <b>RpcAsyncInitializeHandle</b> function to initialize the RPC_ASYNC_STATE structure to be used
///to make an asynchronous call.
///Params:
///    pAsync = Pointer to the RPC_ASYNC_STATE structure that contains asynchronous call information.
///    Size = Size of the RPC_ASYNC_STATE structure.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> The size is either too small or too large. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_INVALID_ASYNC_HANDLE</b></dt> </dl> </td> <td width="60%">
///    <i>pAsync</i> points to invalid memory. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid
///    error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcAsyncInitializeHandle(char* pAsync, uint Size);

///The client calls the <b>RpcAsyncGetCallStatus</b> function to determine the current status of an asynchronous remote
///call.
///Params:
///    pAsync = Pointer to the RPC_ASYNC_STATE structure that contains asynchronous call information.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call was completed successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ASYNC_HANDLE</b></dt> </dl> </td> <td width="60%"> The asynchronous call handle is not
///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_ASYNC_CALL_PENDING</b></dt> </dl> </td> <td
///    width="60%"> The call has not yet completed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other error
///    codes</b></dt> </dl> </td> <td width="60%"> The call failed. The client application must call
///    RpcAsyncCompleteCall to receive the application-specific error code. </td> </tr> </table> <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcAsyncGetCallStatus(RPC_ASYNC_STATE* pAsync);

///The client and the server call the <b>RpcAsyncCompleteCall</b> function to complete an asynchronous remote procedure
///call.
///Params:
///    pAsync = Pointer to the RPC_ASYNC_STATE structure that contains asynchronous call information.
///    Reply = Pointer to a buffer containing the return value of the remote procedure call.
///Returns:
///    In addition to the following values, <b>RpcAsyncCompleteCall</b> can also return any general RPC or
///    application-specific error. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_OK</b></dt> </dl> </td> <td width="60%"> The call was completed successfully. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_INVALID_ASYNC_HANDLE</b></dt> </dl> </td> <td width="60%"> The asynchronous call
///    handle is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_ASYNC_CALL_PENDING</b></dt> </dl> </td>
///    <td width="60%"> The call has not yet completed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_CALL_CANCELLED</b></dt> </dl> </td> <td width="60%"> The call was canceled. </td> </tr> </table>
///    <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcAsyncCompleteCall(RPC_ASYNC_STATE* pAsync, void* Reply);

///The server calls <b>RpcAsyncAbortCall</b> to abort an asynchronous call.
///Params:
///    pAsync = Pointer to the RPC_ASYNC_STATE structure that contains asynchronous call information.
///    ExceptionCode = A nonzero application-specific exception code. Can be an application-defined error code, or a standard RPC error
///                    code. For more information, see RPC Return Values.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> Call cancelation successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ASYNC_HANDLE</b></dt> </dl> </td> <td width="60%"> Asynchronous handle is invalid. </td>
///    </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcAsyncAbortCall(RPC_ASYNC_STATE* pAsync, uint ExceptionCode);

///The client calls the <b>RpcAsyncCancelCall</b> function to cancel an asynchronous call.
///Params:
///    pAsync = Pointer to the RPC_ASYNC_STATE structure that contains asynchronous call information.
///    fAbort = If <b>TRUE</b>, the call is canceled immediately. If <b>FALSE</b>, wait for the server to complete the call.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The cancellation request was processed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ASYNC_HANDLE</b></dt> </dl> </td> <td width="60%"> The asynchronous handle is invalid. </td>
///    </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcAsyncCancelCall(RPC_ASYNC_STATE* pAsync, BOOL fAbort);

///The <b>RpcErrorStartEnumeration</b> function begins enumeration of extended error information.
///Params:
///    EnumHandle = Pointer to the enumeration handle, in the form of an RPC_ERROR_ENUM_HANDLE structure. The structure must be
///                 allocated by the caller, and cannot be freed until the operation is complete. All members are ignored on input.
///Returns:
///    Successful completion returns RPC_S_OK. Returns RPC_S_ENTRY_NOT_FOUND if no extended error information is on the
///    thread. If an enumeration is in progress, starting a second enumeration starts from the beginning. <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcErrorStartEnumeration(RPC_ERROR_ENUM_HANDLE* EnumHandle);

///The <b>RpcErrorGetNextRecord</b> function retrieves the next extended error information record for an enumeration
///handle.
///Params:
///    EnumHandle = Pointer to the enumeration handle, in the form of an RPC_ERROR_ENUM_HANDLE structure. The structure must be
///                 allocated by the caller, and cannot be freed until the operation is complete. All members are ignored on input.
///    CopyStrings = Specifies whether the string fields in <i>ErrorInfo</i> are copied to the default system heap, at which point
///                  ownership of those buffers is transferred to the caller. TRUE indicates the strings are to be copied to the
///                  system heap. FALSE indicates the strings in <i>ErrorInfo</i> point to internal RPC data structures; the caller
///                  cannot free or write to them, and they become invalid once the RpcErrorEndEnumeration function is called.
///    ErrorInfo = Pointer to an RPC_EXTENDED_ERROR_INFO structure. See Remarks.
///Returns:
///    If <i>CopyStrings</i> is false the function call cannot fail unless its parameters are invalid. When the last
///    extended error record is retrieved, <b>RpcErrorGetNextRecord</b> returns RPC_S_OK. Any subsequent calls return
///    RPC_S_ENTRY_NOT_FOUND. Upon any error, the enumeration position is not advanced. <div class="alert"><b>Note</b>
///    For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcErrorGetNextRecord(RPC_ERROR_ENUM_HANDLE* EnumHandle, BOOL CopyStrings, RPC_EXTENDED_ERROR_INFO* ErrorInfo);

///The <b>RpcErrorEndEnumeration</b> function ends enumeration of extended error information and frees all resources
///allocated by RPC for the enumeration.
///Params:
///    EnumHandle = Pointer to the enumeration handle.
///Returns:
///    Successful completion returns RPC_S_OK. The <b>RpcErrorEndEnumeration</b> function call cannot fail unless its
///    parameters are invalid. <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return
///    Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcErrorEndEnumeration(RPC_ERROR_ENUM_HANDLE* EnumHandle);

///The <b>RpcErrorResetEnumeration</b> function resets an enumeration cursor for any in-process enumeration, resetting
///the process such that a subsequent call to the RpcErrorGetNextRecord retrieves the first extended error information
///record.
///Params:
///    EnumHandle = Pointer to the enumeration handle.
///Returns:
///    Successful completion returns RPC_S_OK. The <b>RpcErrorResetEnumeration</b> function call cannot fail unless its
///    parameters are invalid. <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return
///    Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcErrorResetEnumeration(RPC_ERROR_ENUM_HANDLE* EnumHandle);

///The <b>RpcErrorGetNumberOfRecords</b> function returns the number of records in the extended error information.
///Params:
///    EnumHandle = Pointer to the enumeration handle.
///    Records = Number of records for the extended error information.
///Returns:
///    Successful completion returns RPC_S_OK. The <b>RpcErrorGetNumberOfRecords</b> function call cannot fail unless
///    its parameters are invalid. <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return
///    Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcErrorGetNumberOfRecords(RPC_ERROR_ENUM_HANDLE* EnumHandle, int* Records);

///The <b>RpcErrorSaveErrorInfo</b> function returns all error information for an enumeration handle as a BLOB.
///Params:
///    EnumHandle = Pointer to the enumeration handle.
///    ErrorBlob = Pointer to the BLOB containing the error information.
///    BlobSize = Size of <i>ErrorBlob</i>, in bytes.
///Returns:
///    Successful completion returns RPC_S_OK. The <b>RpcErrorSaveErrorInfo</b> function call may fail if not enough
///    memory is available. <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div>
///    <div> </div>
///    
@DllImport("RPCRT4")
int RpcErrorSaveErrorInfo(RPC_ERROR_ENUM_HANDLE* EnumHandle, void** ErrorBlob, size_t* BlobSize);

///The <b>RpcErrorLoadErrorInfo</b> function converts a BLOB obtained by a call to RpcErrorSaveErrorInfo into extended
///error information.
///Params:
///    ErrorBlob = Pointer to the BLOB containing the error information.
///    BlobSize = Size of <i>ErrorBlob</i>, in bytes.
///    EnumHandle = Pointer to the enumeration handle associated with the extended error information.
///Returns:
///    Successful completion returns RPC_S_OK. The <b>RpcErrorLoadInfo</b> function call can fail if not enough memory
///    is available. <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcErrorLoadErrorInfo(char* ErrorBlob, size_t BlobSize, RPC_ERROR_ENUM_HANDLE* EnumHandle);

///The <b>RpcErrorAddRecord</b> function adds extended error information to a chain of extended error information
///records.
///Params:
///    ErrorInfo = Error information to be added, in the form of an RPC_EXTENDED_ERROR_INFO structure.
///Returns:
///    Successful completion returns RPC_S_OK. <div class="alert"><b>Note</b> For a list of valid error codes, see RPC
///    Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcErrorAddRecord(RPC_EXTENDED_ERROR_INFO* ErrorInfo);

///The <b>RpcErrorClearInformation</b> function clears all extended error information on the current thread.
///Returns:
///    This function has no return values. <div class="alert"><b>Note</b> For a list of valid error codes, see RPC
///    Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
void RpcErrorClearInformation();

///The <b>RpcGetAuthorizationContextForClient</b> function returns the Authz context for an RPC client that can be used
///with Authz functions for high-performance authentication. Supported for <b>ncalrpc</b> and <b>ncacn_*</b> protocol
///sequences only.
///Params:
///    ClientBinding = Binding handle on the server that represents a binding to a client. The server impersonates the client indicated
///                    by this handle. If a value of zero is specified, the server impersonates the client that is being served by this
///                    server thread.
///    ImpersonateOnReturn = Directs the function to impersonate the client on return, and then return an <b>AUTHZ_CLIENT_CONTEXT_HANDLE</b>
///                          structure. Set this parameter to nonzero to impersonate the client. See Remarks.
///    Reserved1 = Reserved. Must be null.
///    pExpirationTime = Pointer to the expiration date and time of the token. If no value is passed, the token never expires. Expiration
///                      time is not currently enforced.
///    Reserved2 = Reserved. Must be a <b>LUID</b> structure with each member set to zero.
///    Reserved3 = Reserved. Must be zero.
///    Reserved4 = Reserved. Must be null.
///    pAuthzClientContext = Pointer to an <b>AUTHZ_CLIENT_CONTEXT_HANDLE</b> structure that can be passed directly to Authz functions. If the
///                          function fails, the content of this parameter is undefined.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A reserved parameter is different than its
///    prescribed value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_NO_CONTEXT_AVAILABLE </b></dt> </dl> </td>
///    <td width="60%"> The RPC client has not been authenticated successfully. </td> </tr> </table> Failure returns an
///    RPC_S_* error code, or a Windows error code. Extended error information is available through standard RPC or
///    Windows error code retrieval mechanisms. For a list of valid error codes, see RPC Return Values.
///    
@DllImport("RPCRT4")
int RpcGetAuthorizationContextForClient(void* ClientBinding, BOOL ImpersonateOnReturn, void* Reserved1, 
                                        LARGE_INTEGER* pExpirationTime, LUID Reserved2, uint Reserved3, 
                                        void* Reserved4, void** pAuthzClientContext);

///The <b>RpcFreeAuthorizationContext</b> function frees an Authz context obtained by a previous call to the
///RpcGetAuthorizationContextForClient function.
///Params:
///    pAuthzClientContext = Pointer to the previously obtained Authz client context to be freed.
///Returns:
///    Successful completion returns RPC_S_OK. This function does not fail unless an invalid parameter is provided. <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcFreeAuthorizationContext(void** pAuthzClientContext);

///The <b>RpcSsContextLockExclusive</b> function enables an application to begin using a context handle in exclusive
///mode. The <b>RpcSsContextLockExclusive</b> function enables methods declared as nonserialized (shared) in the IDL or
///ACF file to be dynamically changed to access a context handle in serialized (exclusive) mode.
///Params:
///    ServerBindingHandle = Binding handle on the server that represents a binding to a client. The server impersonates the client indicated
///                          by this handle. If a value of zero is specified, the server impersonates the client that is being served by this
///                          server thread.
///    UserContext = Pointer passed to the manager or server routine by RPC. See Remarks. For out-only context handles, the
///                  <b>RpcSsContextLockExclusive</b> function performs no operation.
///Returns:
///    Returns RPC_S_OK upon successful execution, indicating the thread now has access to the context handle in
///    exclusive mode. Returns ERROR_MORE_WRITES when multiple threads attempt an exclusive lock on the context handle.
///    See Remarks. <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcSsContextLockExclusive(void* ServerBindingHandle, void* UserContext);

///The <b>RpcSsContextLockShared</b> function enables an application to begin using a context handle in shared mode.
///Params:
///    ServerBindingHandle = Binding handle on the server that represents a binding to a client. The server impersonates the client indicated
///                          by this handle. If a value of zero is specified, the server impersonates the client that is being served by this
///                          server thread.
///    UserContext = Pointer passed to the manager or server routine by RPC. See Remarks for more information. For [out] only context
///                  handles, the <b>RpcSsContextLockShared</b> function performs no operation.
///Returns:
///    Returns RPC_S_OK upon successful execution, indicating the thread now has access to the context handle in shared
///    mode. <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcSsContextLockShared(void* ServerBindingHandle, void* UserContext);

///The <b>RpcServerInqCallAttributes</b> function is an RPC server call that obtains client security context attributes.
///Params:
///    ClientBinding = Optional. For explicit binding within a server routine, <i>ClientBinding</i> is the binding handle with which the
///                    manager routine was called. See Remarks.
///    RpcCallAttributes = RPC_CALL_ATTRIBUTES_V2 structure that receives call attributes.
///Returns:
///    Returns RPC_S_OK upon success, and <i>RpcCallAttributes</i> is filled. If ERROR_MORE_DATA is returned, one or
///    more fields in <i>RpcCallAttributes</i> was of insufficient length and could not be filled. See Remarks in
///    RPC_CALL_ATTRIBUTES_V2 for details on handling ERROR_MORE_DATA. Upon failure, the contents of
///    <i>RpcCallAttributes</i> is undefined and may be partially modified by RPC. <div class="alert"><b>Note</b> For a
///    list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerInqCallAttributesW(void* ClientBinding, void* RpcCallAttributes);

///The <b>RpcServerInqCallAttributes</b> function is an RPC server call that obtains client security context attributes.
///Params:
///    ClientBinding = Optional. For explicit binding within a server routine, <i>ClientBinding</i> is the binding handle with which the
///                    manager routine was called. See Remarks.
///    RpcCallAttributes = RPC_CALL_ATTRIBUTES_V2 structure that receives call attributes.
///Returns:
///    Returns RPC_S_OK upon success, and <i>RpcCallAttributes</i> is filled. If ERROR_MORE_DATA is returned, one or
///    more fields in <i>RpcCallAttributes</i> was of insufficient length and could not be filled. See Remarks in
///    RPC_CALL_ATTRIBUTES_V2 for details on handling ERROR_MORE_DATA. Upon failure, the contents of
///    <i>RpcCallAttributes</i> is undefined and may be partially modified by RPC. <div class="alert"><b>Note</b> For a
///    list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerInqCallAttributesA(void* ClientBinding, void* RpcCallAttributes);

///The <b>RpcServerSubscribeForNotification</b> function subscribes the server for RPC notifications.
///Params:
///    Binding = RPC_BINDING_HANDLE structure that contains the binding handle for the current call. If this function is called on
///              the same thread that RPC has dispatched a call on, this parameter can be set to <b>NULL</b>; otherwise, an
///              explicit binding handle must be passed in this parameter.
///    Notification = Bitwise combination of the RPC_NOTIFICATIONS enumeration values that specifies the type of notification requested
///                   from RPC by the server. <b>Windows Vista: </b>Currently, only <b>RpcNotificationClientDisconnect</b> and
///                   <b>RpcNotificationCallCancel</b> are supported. If any other value is specified for this parameter, the
///                   RPC_S_CANNOT_SUPPORT error code is returned.
///    NotificationType = RPC_NOTIFICATION_TYPES enumeration value that specifies the method by which RPC will notify the server.
///                       <b>Windows Vista: </b><b>RpcNotificationTypeNone</b> is not supported. If this value is specified, the
///                       RPC_S_INVALID_ARG error code is returned.
///    NotificationInfo = Pointer to an RPC_ASYNC_NOTIFICATION_INFO union that contains the specific information necessary for RPC to
///                       contact the server for notification. The data contained in this union is specific to the method passed to the
///                       <i>NotificationType</i> parameter. If the <b>RpcNotificationTypeCallback</b> method is specified in
///                       <i>NotificationTypes</i>, the <b>NotificationRoutine</b> member of the corresponding branch of the union is set
///                       to the binding handle for synchronous calls and the async handle for asynchronous calls. RPC makes a copy of this
///                       parameter during a successful call to this function. The caller can free or update this parameter when the API
///                       returns.
///Returns:
///    This function returns RPC_S_OK on success; otherwise, an RPC_S_* error code is returned. <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerSubscribeForNotification(void* Binding, RPC_NOTIFICATIONS Notification, 
                                      RPC_NOTIFICATION_TYPES NotificationType, 
                                      RPC_ASYNC_NOTIFICATION_INFO* NotificationInfo);

///The <b>RpcServerUnsubscribeForNotification</b> function unsubscribes the server from RPC notifications.
///Params:
///    Binding = RPC_BINDING_HANDLE structure that contains the binding handle for the current RPC call specified in a previous
///              call to RpcServerSubscribeForNotification. If this function is called on the same thread that RPC has dispatched
///              a call on, this parameter can be set to <b>NULL</b>; otherwise, an explicit binding handle must be passed in this
///              parameter.
///    Notification = A value from the RPC_NOTIFICATIONS enumeration that specifies the type of notification requested from RPC by the
///                   server. Notifications must be unsubscribed individually, multiple values are not supported. <b>Windows Vista:
///                   </b>Currently, only <b>RpcNotificationClientDisconnect</b> and <b>RpcNotificationCallCancel</b> are supported. If
///                   any other value is specified for this parameter, the RPC_S_CANNOT_SUPPORT error code is returned.
///    NotificationsQueued = A required pointer to a value that receives the number of notifications that the RPC runtime queued for the
///                          specified RPC call. The pointer must be supplied; it is not optional. Your code should keep track of the number
///                          of notifications that it receives. When you unsubscribe from RPC notifications, you should check if the number of
///                          notifications that the RPC runtime queued matches the number of notifications that you received. If the numbers
///                          do not match, some notifications could still be incoming on another thread. You should delay cleaning up the
///                          notification state until you receive all incoming notifications.
///Returns:
///    This function returns RPC_S_OK on success; otherwise, an RPC_S_* error code is returned. <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcServerUnsubscribeForNotification(void* Binding, RPC_NOTIFICATIONS Notification, uint* NotificationsQueued);

///The <b>RpcBindingBind</b> function contacts an RPC server and binds to it.
///Params:
///    pAsync = Pointer to the RPC_ASYNC_STATE structure that contains asynchronous call information. This state information
///             contains the completion method used to signal when the bind operation is complete.
///    Binding = RPC_BINDING_HANDLE structure that contains the binding handle created with a previous call to RpcBindingCreate.
///    IfSpec = RPC_IF_HANDLE value that specifies the interface on which calls for this binding handle will be made.
///Returns:
///    This function returns RPC_S_OK on success; otherwise, an RPC_S_* error code is returned. For information on these
///    error codes, see RPC Return Values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl> </td> <td width="60%"> The RPC is successfully bound to the
///    server and remote calls can be made. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_CANNOT_SUPPORT</b></dt>
///    </dl> </td> <td width="60%"> An obsolete feature of RPC was requested for this binding operation. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcBindingBind(RPC_ASYNC_STATE* pAsync, void* Binding, void* IfSpec);

///The <b>RpcBindingUnbind</b> function unbinds a binding handle previously bound by RpcBindingBind.
///Params:
///    Binding = RPC_BINDING_HANDLE structure that contains the binding handle to unbind from the RPC server.
///Returns:
///    This function returns RPC_S_OK on success; otherwise, an RPC_S_* error code is returned. <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcBindingUnbind(void* Binding);

@DllImport("RPCRT4")
int I_RpcAsyncSetHandle(RPC_MESSAGE* Message, RPC_ASYNC_STATE* pAsync);

@DllImport("RPCRT4")
int I_RpcAsyncAbortCall(RPC_ASYNC_STATE* pAsync, uint ExceptionCode);

///Determines whether an exception is fatal or non-fatal
///Params:
///    ExceptionCode = Value of an exception. Any of the following exception values will return EXCEPTION_CONTINUE_SEARCH: -
///                    STATUS_ACCESS_VIOLATION - STATUS_POSSIBLE_DEADLOCK - STATUS_INSTRUCTION_MISALIGNMENT -
///                    STATUS_DATATYPE_MISALIGNMENT - STATUS_PRIVILEGED_INSTRUCTION - STATUS_ILLEGAL_INSTRUCTION - STATUS_BREAKPOINT -
///                    STATUS_STACK_OVERFLOW - STATUS_HANDLE_NOT_CLOSABLE - STATUS_IN_PAGE_ERROR - STATUS_ASSERTION_FAILURE -
///                    STATUS_STACK_BUFFER_OVERRUN - STATUS_GUARD_PAGE_VIOLATION - STATUS_REG_NAT_CONSUMPTION
///Returns:
///    A value that specifies whether the exception was fatal or non-fatal. | Return code | Description
///    |-------------|------------| | EXCEPTION_CONTINUE_SEARCH | The exception is fatal and must be handled. | |
///    EXCEPTION_EXECUTE_HANDLER | The exception is not fatal. |
///    
@DllImport("RPCRT4")
int I_RpcExceptionFilter(uint ExceptionCode);

@DllImport("RPCRT4")
int I_RpcBindingInqClientTokenAttributes(void* Binding, LUID* TokenId, LUID* AuthenticationId, LUID* ModifiedId);

@DllImport("RPCRT4")
void* NDRCContextBinding(ptrdiff_t CContext);

@DllImport("RPCRT4")
void NDRCContextMarshall(ptrdiff_t CContext, void* pBuff);

@DllImport("RPCRT4")
void NDRCContextUnmarshall(ptrdiff_t* pCContext, void* hBinding, void* pBuff, uint DataRepresentation);

@DllImport("RPCRT4")
void NDRSContextMarshall(NDR_SCONTEXT_1* CContext, void* pBuff, NDR_RUNDOWN userRunDownIn);

@DllImport("RPCRT4")
NDR_SCONTEXT_1* NDRSContextUnmarshall(void* pBuff, uint DataRepresentation);

@DllImport("RPCRT4")
void NDRSContextMarshallEx(void* BindingHandle, NDR_SCONTEXT_1* CContext, void* pBuff, NDR_RUNDOWN userRunDownIn);

@DllImport("RPCRT4")
void NDRSContextMarshall2(void* BindingHandle, NDR_SCONTEXT_1* CContext, void* pBuff, NDR_RUNDOWN userRunDownIn, 
                          void* CtxGuard, uint Flags);

@DllImport("RPCRT4")
NDR_SCONTEXT_1* NDRSContextUnmarshallEx(void* BindingHandle, void* pBuff, uint DataRepresentation);

@DllImport("RPCRT4")
NDR_SCONTEXT_1* NDRSContextUnmarshall2(void* BindingHandle, void* pBuff, uint DataRepresentation, void* CtxGuard, 
                                       uint Flags);

///The <b>RpcSsDestroyClientContext</b> function destroys a context handle no longer needed by the client, without
///contacting the server.
///Params:
///    ContextHandle = Context handle to be destroyed. The handle is set to <b>NULL</b> before <b>RpcSsDestroyClientContext</b> returns.
///Returns:
///    <b>RpcSsDestroyClientContext</b> has no return value. <div class="alert"><b>Note</b> For a list of valid error
///    codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
void RpcSsDestroyClientContext(void** ContextHandle);

///The <b>NdrSimpleTypeMarshall</b> function marshalls a simple type.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. Structure is for
///               internal use only; do not modify.
///    pMemory = Pointer to the simple type to be marshalled.
///    FormatChar = Simple type format character.
@DllImport("RPCRT4")
void NdrSimpleTypeMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte FormatChar);

///The <b>NdrPointerMarshall</b> function marshalls a top level pointer to anything. Pointers embedded in structures,
///arrays, or unions call <b>NdrPointerMarshall</b> directly.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. Structure is for
///               internal use only; do not modify.
///    pMemory = Pointer to the pointer to be marshalled.
///    pFormat = Pointer to the format string description.
///Returns:
///    Returns <b>NULL</b> upon success. If an error occurs, the function throws one of the following exception codes.
///    <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td>STATUS_ACCESS_VIOLATION</td> <td>An access
///    violation occurred.</td> </tr> <tr> <td>RPC_S_INTERNAL_ERROR</td> <td>An error occurred in RPC.</td> </tr>
///    </table>
///    
@DllImport("RPCRT4")
ubyte* NdrPointerMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
ubyte* NdrConformantStructMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
ubyte* NdrConformantVaryingStructMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
ubyte* NdrFixedArrayMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
ubyte* NdrConformantVaryingArrayMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
ubyte* NdrVaryingArrayMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
ubyte* NdrNonConformantStringMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

///The <b>NdrConformantStringMarshall</b> function marshals the conformant string into a network buffer to be sent to
///the server.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. This structure is for
///               internal use only and should not be modified.
///    pMemory = Pointer to the null-terminated conformant string to be marshaled.
///    pFormat = Pointer to the format string description.
@DllImport("RPCRT4")
ubyte* NdrConformantStringMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
ubyte* NdrEncapsulatedUnionMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
ubyte* NdrNonEncapsulatedUnionMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
ubyte* NdrByteCountPointerMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
ubyte* NdrXmitOrRepAsMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

///The <b>NdrUserMarshalMarshall</b> function marshals the supplied data buffer.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. Structure is for
///               internal use only; do not modify.
///    pMemory = Pointer to user data object to be marshaled.
///    pFormat = Pointer's format string description.
@DllImport("RPCRT4")
ubyte* NdrUserMarshalMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

///The <b>NdrInterfacePointerMarshall</b> function marshals the interface pointer into a network buffer to be sent to
///the server.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. This structure is for
///               internal use only and should not be modified.
///    pMemory = Pointer to the interface pointer to be marshaled.
///    pFormat = Pointer to the format string description.
@DllImport("RPCRT4")
ubyte* NdrInterfacePointerMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrClientContextMarshall(MIDL_STUB_MESSAGE* pStubMsg, ptrdiff_t ContextHandle, int fCheck);

@DllImport("RPCRT4")
void NdrServerContextMarshall(MIDL_STUB_MESSAGE* pStubMsg, NDR_SCONTEXT_1* ContextHandle, 
                              NDR_RUNDOWN RundownRoutine);

@DllImport("RPCRT4")
void NdrServerContextNewMarshall(MIDL_STUB_MESSAGE* pStubMsg, NDR_SCONTEXT_1* ContextHandle, 
                                 NDR_RUNDOWN RundownRoutine, ubyte* pFormat);

///The <b>NdrSimpleTypeUnmarshall</b> function unmarshalls a simple type.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. Structure is for
///               internal use only; do not modify.
///    pMemory = Pointer to memory to unmarshall.
///    FormatChar = Format string of the simple type.
@DllImport("RPCRT4")
void NdrSimpleTypeUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte FormatChar);

@DllImport("RPCRT4")
ubyte* NdrRangeUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4")
void NdrCorrelationInitialize(MIDL_STUB_MESSAGE* pStubMsg, void* pMemory, uint CacheSize, uint flags);

@DllImport("RPCRT4")
void NdrCorrelationPass(MIDL_STUB_MESSAGE* pStubMsg);

@DllImport("RPCRT4")
void NdrCorrelationFree(MIDL_STUB_MESSAGE* pStubMsg);

///The <b>NdrPointerUnmarshall</b> function unmarshalls a top level pointer to anything. Pointers embedded in
///structures, arrays, or unions call <b>NdrPointerUnmarshall</b> directly.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. Structure is for
///               internal use only; do not modify.
///    ppMemory = Pointer to memory where pointer will be unmarshalled. Please see MCCP Buffer Protection for information on buffer
///               overrun protections in RPC: http://msdn.microsoft.com/en-us/library/ff621497(VS.85).aspx
///    pFormat = Pointer to the format string description.
///    fMustAlloc = Unused.
///Returns:
///    Returns <b>NULL</b> upon success. If an error occurs, the function throws one of the following exception codes.
///    <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td>RPC_BAD_STUB_DATA or RPC_X_INVALID_BOUND </td>
///    <td>The network buffer is incorrect.</td> </tr> <tr> <td>RPC_S_OUT_OF_MEMORY</td> <td>The system is out of
///    memory.</td> </tr> <tr> <td>STATUS_ACCESS_VIOLATION</td> <td>An access violation occurred.</td> </tr> <tr>
///    <td>RPC_S_INTERNAL_ERROR</td> <td>An error occurred in RPC.</td> </tr> </table>
///    
@DllImport("RPCRT4")
ubyte* NdrPointerUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4")
ubyte* NdrConformantStructUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                     ubyte fMustAlloc);

@DllImport("RPCRT4")
ubyte* NdrConformantVaryingStructUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                            ubyte fMustAlloc);

@DllImport("RPCRT4")
ubyte* NdrFixedArrayUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

///The <b>NdrConformantArrayUnmarshall</b> function unmarshals a conformant array.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. This structure is for
///               internal use only and should not be modified.
///    ppMemory = Address to a pointer to the buffer where the conformant array is unmarshalled. If set to <b>null</b>, or if the
///               <i>fMustAlloc</i> is set to <b>TRUE</b>, the stub will allocate the memory.
///    pFormat = Pointer to the format string description.
///    fMustAlloc = Flag that specifies whether the stub must allocate the memory into which the conformant array is to be
///                 marshalled. Specify <b>TRUE</b> if RPC must allocate <i>ppMemory</i>.
///Returns:
///    Returns <b>null</b> upon success. If an error occurs, the function throws one of the following exception codes.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_BAD_STUB_DATA</b></dt> </dl> </td> <td width="60%"> The network is incorrect. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_X_INVALID_BOUND</b></dt> </dl> </td> <td width="60%"> The network is incorrect.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> The
///    system is out of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_ACCESS_VIOLATION</b></dt> </dl>
///    </td> <td width="60%"> An access violation occurred. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INTERNAL_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred in RPC. </td> </tr> </table>
///    
@DllImport("RPCRT4")
ubyte* NdrConformantArrayUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                    ubyte fMustAlloc);

@DllImport("RPCRT4")
ubyte* NdrConformantVaryingArrayUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                           ubyte fMustAlloc);

@DllImport("RPCRT4")
ubyte* NdrVaryingArrayUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4")
ubyte* NdrNonConformantStringUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                        ubyte fMustAlloc);

///The <b>NdrConformantStringUnmarshall</b> function unmarshals the conformant string from the network buffer to memory.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. This structure is for
///               internal use only and should not be modified.
///    ppMemory = Address to a pointer to the unmarshalled conformant string. If set to null, or if the <i>fMustAlloc</i> is set to
///               <b>TRUE</b>, the stub will allocate the memory.
///    pFormat = Pointer to the format string description.
///    fMustAlloc = Flag that specifies whether the stub must allocate the memory into which the conformant string is to be
///                 marshaled. Specify <b>TRUE</b> if RPC must allocate <i>ppMemory</i>.
@DllImport("RPCRT4")
ubyte* NdrConformantStringUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                     ubyte fMustAlloc);

@DllImport("RPCRT4")
ubyte* NdrEncapsulatedUnionUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                      ubyte fMustAlloc);

@DllImport("RPCRT4")
ubyte* NdrNonEncapsulatedUnionUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                         ubyte fMustAlloc);

@DllImport("RPCRT4")
ubyte* NdrByteCountPointerUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                     ubyte fMustAlloc);

@DllImport("RPCRT4")
ubyte* NdrXmitOrRepAsUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

///The <b>NdrInterfacePointerUnmarshall</b> function unmarshalls the data referenced by the interface pointer from the
///network buffer to memory.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. Structure is for
///               internal use only; do not modify.
///    ppMemory = Pointer to a pointer to the unmarshalled interface pointer.
///    pFormat = Pointer to the format string description.
///    fMustAlloc = Unused.
@DllImport("RPCRT4")
ubyte* NdrInterfacePointerUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                     ubyte fMustAlloc);

@DllImport("RPCRT4")
void NdrClientContextUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ptrdiff_t* pContextHandle, void* BindHandle);

@DllImport("RPCRT4")
NDR_SCONTEXT_1* NdrServerContextUnmarshall(MIDL_STUB_MESSAGE* pStubMsg);

///The <b>NdrContextHandleInitialize</b> function initializes a new RPC context handle.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that contains the current status of the RPC stub. Structure is for
///               internal use only; do not modify.
///    pFormat = Pointer to a <b>FORMAT_STRING</b> structure that contains the format of the new context handle.
@DllImport("RPCRT4")
NDR_SCONTEXT_1* NdrContextHandleInitialize(MIDL_STUB_MESSAGE* pStubMsg, char* pFormat);

@DllImport("RPCRT4")
NDR_SCONTEXT_1* NdrServerContextNewUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, char* pFormat);

///The <b>NdrPointerBufferSize</b> function computes the needed buffer size, in bytes, for a top-level pointer to
///anything.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. The
///               <b>BufferLength</b> member contains the size of the buffer. This structure is for internal use only and should
///               not be modified.
///    pMemory = Pointer to the data being sized.
///    pFormat = Pointer to the format string description.
///Returns:
///    This function has no return values. If an error occurs, the function throws one of the following exception codes.
///    <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td>STATUS_ACCESS_VIOLATION</td> <td>An access
///    violation occurred.</td> </tr> <tr> <td>RPC_S_INTERNAL_ERROR</td> <td>An error occurred in RPC.</td> </tr>
///    </table>
///    
@DllImport("RPCRT4")
void NdrPointerBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrConformantStructBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrConformantVaryingStructBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrFixedArrayBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrConformantVaryingArrayBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrVaryingArrayBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

///The <b>NdrConformantStringBufferSize</b> function calculates the size of the buffer, in bytes, needed to marshal the
///conformant string.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. The
///               <b>BufferLength</b> member contains the size of the buffer. Structure is for internal use only; do not modify.
///    pMemory = Pointer to the null-terminated conformant string to be calculated.
///    pFormat = Pointer to the format string description.
@DllImport("RPCRT4")
void NdrConformantStringBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrNonConformantStringBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrEncapsulatedUnionBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrNonEncapsulatedUnionBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrByteCountPointerBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrXmitOrRepAsBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

///The <b>NdrUserMarshalBufferSize</b> function calculates the size of the buffer, in bytes, needed to marshal the user
///marshal object.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. The
///               <b>BufferLength</b> member contains the size of the buffer. Structure is for internal use only; do not modify.
///    pMemory = Pointer to the user marshal object to be calculated.
@DllImport("RPCRT4")
void NdrUserMarshalBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

///The <b>NdrInterfacePointerBufferSize</b> function calculates the size of the buffer, in bytes, needed to marshal the
///interface pointer.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. The
///               <b>BufferLength</b> member contains the size of the buffer. This structure is for internal use only and should
///               not be modified.
///    pMemory = Pointer to the interface pointer to be calculated.
///    pFormat = Pointer to the format string description.
@DllImport("RPCRT4")
void NdrInterfacePointerBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

///The <b>NdrContextHandleSize</b> function returns the size of the supplied RPC context handle.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that contains the current status of the RPC stub. The
///               <b>BufferLength</b> member contains the size of the context handle, in bytes. Structure is for internal use only;
///               do not modify.
///    pMemory = Pointer to a string buffer that contains an RPC context handle.
///    pFormat = Pointer to a <b>FORMAT_STRING</b> structure that contains the format of the context handle specified in
///              <i>pMemory</i>.
@DllImport("RPCRT4")
void NdrContextHandleSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
uint NdrPointerMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4")
uint NdrSimpleStructMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4")
uint NdrConformantStructMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4")
uint NdrConformantVaryingStructMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4")
uint NdrComplexStructMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4")
uint NdrFixedArrayMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4")
uint NdrConformantArrayMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4")
uint NdrConformantVaryingArrayMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4")
uint NdrVaryingArrayMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4")
uint NdrComplexArrayMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4")
uint NdrConformantStringMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4")
uint NdrNonConformantStringMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4")
uint NdrEncapsulatedUnionMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4")
uint NdrNonEncapsulatedUnionMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4")
uint NdrXmitOrRepAsMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4")
uint NdrUserMarshalMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4")
uint NdrInterfacePointerMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

///The <b>NdrPointerFree</b> function frees memory.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. This structure is for
///               internal use only and should not be modified.
///    pMemory = Pointer to memory to be freed.
@DllImport("RPCRT4")
void NdrPointerFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrSimpleStructFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrConformantStructFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrConformantVaryingStructFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrComplexStructFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrFixedArrayFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrConformantArrayFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrConformantVaryingArrayFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrVaryingArrayFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrComplexArrayFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrEncapsulatedUnionFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrNonEncapsulatedUnionFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrByteCountPointerFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrXmitOrRepAsFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

///The <b>NdrUserMarshalFree</b> function frees the user marshal object.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. Structure is for
///               internal use only; do not modify.
///    pMemory = Pointer to be freed.
///    pFormat = Pointer's format string description.
@DllImport("RPCRT4")
void NdrUserMarshalFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

///The <b>NdrInterfacePointerFree</b> function releases the interface pointer.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. This structure is for
///               internal use only and should not be modified.
///    pMemory = Pointer to the interface pointer to be released.
@DllImport("RPCRT4")
void NdrInterfacePointerFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrConvert2(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat, int NumberParams);

///The <b>NdrConvert</b> function converts the network buffer from the data representation of the sender to the data
///representation of the receiver if they are different.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. The <b>pRpcMsg</b>
///               member points to a structure whose <b>Buffer</b> member contains the data to convert. This structure is for
///               internal use only and should not be modified.
///    pFormat = Pointer to type format of the data to convert.
///Returns:
///    This function has no return values. If an error occurs, the function throws one of the following exception codes.
///    <table> <tr> <th>Error</th> <th>Description</th> </tr> <tr> <td>RPC_BAD_STUB_DATA or RPC_X_INVALID_BOUND</td>
///    <td>The network buffer is incorrect.</td> </tr> <tr> <td>STATUS_ACCESS_VIOLATION</td> <td>An access violation
///    occurred.</td> </tr> <tr> <td>RPC_S_INTERNAL_ERROR</td> <td>An error occurred in RPC.</td> </tr> </table>
///    
@DllImport("RPCRT4")
void NdrConvert(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4")
ubyte* NdrUserMarshalSimpleTypeConvert(uint* pFlags, ubyte* pBuffer, ubyte FormatChar);

@DllImport("RPCRT4")
void NdrClientInitializeNew(RPC_MESSAGE* pRpcMsg, MIDL_STUB_MESSAGE* pStubMsg, MIDL_STUB_DESC* pStubDescriptor, 
                            uint ProcNum);

@DllImport("RPCRT4")
ubyte* NdrServerInitializeNew(RPC_MESSAGE* pRpcMsg, MIDL_STUB_MESSAGE* pStubMsg, MIDL_STUB_DESC* pStubDescriptor);

@DllImport("RPCRT4")
void NdrServerInitializePartial(RPC_MESSAGE* pRpcMsg, MIDL_STUB_MESSAGE* pStubMsg, MIDL_STUB_DESC* pStubDescriptor, 
                                uint RequestedBufferSize);

@DllImport("RPCRT4")
void NdrClientInitialize(RPC_MESSAGE* pRpcMsg, MIDL_STUB_MESSAGE* pStubMsg, MIDL_STUB_DESC* pStubDescriptor, 
                         uint ProcNum);

@DllImport("RPCRT4")
ubyte* NdrServerInitialize(RPC_MESSAGE* pRpcMsg, MIDL_STUB_MESSAGE* pStubMsg, MIDL_STUB_DESC* pStubDescriptor);

@DllImport("RPCRT4")
ubyte* NdrServerInitializeUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, MIDL_STUB_DESC* pStubDescriptor, 
                                     RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4")
void NdrServerInitializeMarshall(RPC_MESSAGE* pRpcMsg, MIDL_STUB_MESSAGE* pStubMsg);

@DllImport("RPCRT4")
ubyte* NdrGetBuffer(MIDL_STUB_MESSAGE* pStubMsg, uint BufferLength, void* Handle);

@DllImport("RPCRT4")
ubyte* NdrNsGetBuffer(MIDL_STUB_MESSAGE* pStubMsg, uint BufferLength, void* Handle);

@DllImport("RPCRT4")
ubyte* NdrSendReceive(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pBufferEnd);

@DllImport("RPCRT4")
ubyte* NdrNsSendReceive(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pBufferEnd, void** pAutoHandle);

@DllImport("RPCRT4")
void NdrFreeBuffer(MIDL_STUB_MESSAGE* pStubMsg);

@DllImport("RPCRT4")
HRESULT NdrGetDcomProtocolVersion(MIDL_STUB_MESSAGE* pStubMsg, RPC_VERSION* pVersion);

///The <b>NdrClientCall2</b> function is the client-side entry point for the /Oicf mode stub.
///Params:
///    pStubDescriptor = Pointer to the MIDL-generated MIDL_STUB_DESC structure that contains information about the description of the
///                      remote interface.
///    pFormat = Pointer to the MIDL-generated procedure format string that describes the method and parameters.
///    arg3 = Pointer to the client-side calling stack.
///Returns:
///    Return value of the remote call. The maximum size of a return value is equivalent to the register size of the
///    system. MIDL switches to the /Os mode stub if the return value size is larger than the register size. Depending
///    on the method definition, this function can throw an exception if there is a network or server failure.
///    
@DllImport("RPCRT4")
CLIENT_CALL_RETURN NdrClientCall2(MIDL_STUB_DESC* pStubDescriptor, ubyte* pFormat);

///The <b>NdrAsyncClientCall</b> function is the asynchronous client-side entry point for the /Oi and <b>/Oic</b> mode
///stub.
///Params:
///    pStubDescriptor = Pointer to the MIDL-generated MIDL_STUB_DESC structure that contains information about the description of the
///                      remote interface.
///    pFormat = Pointer to the MIDL-generated procedure format string that describes the method and parameters.
///    arg3 = Pointer to the client-side calling stack.
@DllImport("RPCRT4")
CLIENT_CALL_RETURN NdrAsyncClientCall(MIDL_STUB_DESC* pStubDescriptor, ubyte* pFormat);

///<p class="CCE_Message">[NdrDcomAsyncClientCall is not supported and may be altered or unavailable in the future.]
///NdrDcomAsyncClientCall may be altered or unavailable.
///Params:
///    pStubDescriptor = Reserved.
///    pFormat = Reserved.
///    arg3 = Reserved.
@DllImport("RPCRT4")
CLIENT_CALL_RETURN NdrDcomAsyncClientCall(MIDL_STUB_DESC* pStubDescriptor, ubyte* pFormat);

///<b>NdrAsyncServerCall</b> is not intended to be directly called by applications.
@DllImport("RPCRT4")
void NdrAsyncServerCall(RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4")
int NdrDcomAsyncStubCall(IRpcStubBuffer pThis, IRpcChannelBuffer pChannel, RPC_MESSAGE* pRpcMsg, 
                         uint* pdwStubPhase);

///The <b>NdrStubCall2</b> function is the server-side entry point for /Oicf mode stubs.
///Params:
///    pThis = Pointer to an instance of the CStdStubBuffer object, implementing IRpcStubBuffer, for the DCOM interface. Set to
///            <b>NULL</b> for nonobject RPC interfaces.
///    pChannel = Pointer to IRpcChannelBuffer for the DCOM interface, often provided by OLE. Set to <b>NULL</b> for nonobject
///               interfaces.
///    pRpcMsg = Pointer to an RPC_MESSAGE structure that contains information about the RPC request. In nonobject interfaces,
///              <i>pRpcMsg</i> also contains information about the remoting method.
///    pdwStubPhase = Pointer to a flag that tracks the current interpreter call's activity.
///Returns:
///    Returns S_OK upon success. Raises an exception upon error.
///    
@DllImport("RPCRT4")
int NdrStubCall2(void* pThis, void* pChannel, RPC_MESSAGE* pRpcMsg, uint* pdwStubPhase);

///<b>NdrServerCall2</b> is not intended to be directly called by applications.
@DllImport("RPCRT4")
void NdrServerCall2(RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4")
int NdrMapCommAndFaultStatus(MIDL_STUB_MESSAGE* pStubMsg, uint* pCommStatus, uint* pFaultStatus, int Status);

///The <b>RpcSsAllocate</b> function allocates memory within the RPC stub memory-management function, and returns a
///pointer to the allocated memory or <b>NULL</b>.
///Params:
///    Size = Size of memory to allocate, in bytes.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt>
///    </dl> </td> <td width="60%"> The system is out of memory. </td> </tr> </table> <div class="alert"><b>Note</b> For
///    a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
void* RpcSsAllocate(size_t Size);

///The <b>RpcSsDisableAllocate</b> function frees resources and memory within the stub memory–management environment.
///Returns:
///    <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
void RpcSsDisableAllocate();

///The <b>RpcSsEnableAllocate</b> function establishes the stub memory–management environment.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt>
///    </dl> </td> <td width="60%"> The system is out of memory. </td> </tr> </table> <div class="alert"><b>Note</b> For
///    a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
void RpcSsEnableAllocate();

///The <b>RpcSsFree</b> function releases memory allocated by RpcSsAllocate.
///Params:
///    NodeToFree = Pointer to memory allocated by RpcSsAllocate or RpcSmAllocate.
@DllImport("RPCRT4")
void RpcSsFree(void* NodeToFree);

///The <b>RpcSsGetThreadHandle</b> function returns a thread handle for the stub memory–management environment.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
void* RpcSsGetThreadHandle();

///The <b>RpcSsSetClientAllocFree</b> function enables the memory allocation and release mechanisms used by the client
///stubs.
///Params:
///    ClientAlloc = Memory-allocation function.
///    ClientFree = Memory-releasing function used with the memory-allocation function specified by <i>pfnAllocate</i>.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt>
///    </dl> </td> <td width="60%"> The system is out of memory. </td> </tr> </table> <div class="alert"><b>Note</b> For
///    a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
void RpcSsSetClientAllocFree(RPC_CLIENT_ALLOC* ClientAlloc, RPC_CLIENT_FREE* ClientFree);

///The <b>RpcSsSetThreadHandle</b> function sets a thread handle for the stub memory–management environment.
///Params:
///    Id = Thread handle returned by a call to RpcSsGetThreadHandle.
@DllImport("RPCRT4")
void RpcSsSetThreadHandle(void* Id);

///The <b>RpcSsSwapClientAllocFree</b> function exchanges the memory allocation and release mechanisms used by the
///client stubs with those supplied by the client.
///Params:
///    ClientAlloc = New function to allocate memory.
///    ClientFree = New function to release memory.
///    OldClientAlloc = Returns the previous memory-allocation function.
///    OldClientFree = Returns the previous memory-freeing function.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is out of memory. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
void RpcSsSwapClientAllocFree(RPC_CLIENT_ALLOC* ClientAlloc, RPC_CLIENT_FREE* ClientFree, 
                              RPC_CLIENT_ALLOC** OldClientAlloc, RPC_CLIENT_FREE** OldClientFree);

///The <b>RpcSmAllocate</b> function allocates memory within the RPC stub memory management function and returns a
///pointer to the allocated memory or <b>NULL</b>.
///Params:
///    Size = Size of memory to allocate, in bytes.
///    pStatus = Pointer to the returned status.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is out of memory. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
void* RpcSmAllocate(size_t Size, int* pStatus);

///The <b>RpcSmClientFree</b> function frees memory returned from a client stub.
///Params:
///    pNodeToFree = Pointer to memory returned from a client stub.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcSmClientFree(void* pNodeToFree);

///The <b>RpcSmDestroyClientContext</b> function reclaims the client memory resources for a context handle and makes the
///context handle <b>NULL</b>.
///Params:
///    ContextHandle = Context handle that can no longer be used. The handle is set to <b>NULL</b> before
///                    <b>RpcSMDestroyClientContext</b> returns.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_X_SS_CONTEXT_MISMATCH</b></dt> </dl> </td> <td width="60%"> The handle is invalid. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcSmDestroyClientContext(void** ContextHandle);

///The <b>RpcSmDisableAllocate</b> function frees resources and memory within the stub memory–management environment.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcSmDisableAllocate();

///The <b>RpcSmEnableAllocate</b> function establishes the stub memory–management environment.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is out of memory. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcSmEnableAllocate();

///The <b>RpcSmFree</b> function releases memory allocated by RpcSmAllocate.
///Params:
///    NodeToFree = Pointer to memory allocated by RpcSmAllocate or RpcSsAllocate.
///Returns:
///    The function <b>RpcSmFree</b> returns the following value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl> </td> <td width="60%"> The call succeeded. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcSmFree(void* NodeToFree);

///The <b>RpcSmGetThreadHandle</b> function returns a thread handle, or <b>NULL</b>, for the stub memory–management
///environment.
///Params:
///    pStatus = Pointer to the returned status.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
void* RpcSmGetThreadHandle(int* pStatus);

///The <b>RpcSmSetClientAllocFree</b> function enables the memory allocation and release mechanisms used by the client
///stubs.
///Params:
///    ClientAlloc = Function used to allocate memory.
///    ClientFree = Function used to release memory and used with the function specified by <i>pfnAllocate</i>.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> The system is out of memory. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int RpcSmSetClientAllocFree(RPC_CLIENT_ALLOC* ClientAlloc, RPC_CLIENT_FREE* ClientFree);

///The <b>RpcSmSetThreadHandle</b> function sets a thread handle for the stub memory–management environment.
///Params:
///    Id = Thread handle returned by a call to RpcSmGetThreadHandle.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcSmSetThreadHandle(void* Id);

///The <b>RpcSmSwapClientAllocFree</b> function exchanges the client stub's memory-allocation and memory-freeing
///mechanisms with those supplied by the client.
///Params:
///    ClientAlloc = New memory-allocation function.
///    ClientFree = New memory-releasing function.
///    OldClientAlloc = Returns the previous memory-allocation function before the call to this function.
///    OldClientFree = Returns the previous memory-releasing function before the call to this function.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> The argument is invalid. </td> </tr> </table> <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int RpcSmSwapClientAllocFree(RPC_CLIENT_ALLOC* ClientAlloc, RPC_CLIENT_FREE* ClientFree, 
                             RPC_CLIENT_ALLOC** OldClientAlloc, RPC_CLIENT_FREE** OldClientFree);

@DllImport("RPCRT4")
void NdrRpcSsEnableAllocate(MIDL_STUB_MESSAGE* pMessage);

@DllImport("RPCRT4")
void NdrRpcSsDisableAllocate(MIDL_STUB_MESSAGE* pMessage);

@DllImport("RPCRT4")
void NdrRpcSmSetClientToOsf(MIDL_STUB_MESSAGE* pMessage);

@DllImport("RPCRT4")
void* NdrRpcSmClientAllocate(size_t Size);

@DllImport("RPCRT4")
void NdrRpcSmClientFree(void* NodeToFree);

@DllImport("RPCRT4")
void* NdrRpcSsDefaultAllocate(size_t Size);

@DllImport("RPCRT4")
void NdrRpcSsDefaultFree(void* NodeToFree);

@DllImport("RPCRT4")
FULL_PTR_XLAT_TABLES* NdrFullPointerXlatInit(uint NumberOfPointers, XLAT_SIDE XlatSide);

@DllImport("RPCRT4")
void NdrFullPointerXlatFree(FULL_PTR_XLAT_TABLES* pXlatTables);

@DllImport("RPCRT4")
void* NdrAllocate(MIDL_STUB_MESSAGE* pStubMsg, size_t Len);

///The <b>NdrClearOutParameters</b> function frees resources of the out parameter and clears its memory if the RPC call
///to the server fails.
///Params:
///    pStubMsg = Pointer to MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. The structure is for
///               internal use only and should not be modified.
///    pFormat = Pointer to the format string description.
@DllImport("RPCRT4")
void NdrClearOutParameters(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat, void* ArgAddr);

///The <b>NdrOleAllocate</b> function is used by RPC to allocate memory for an object interface. This function is a
///wrapper for the CoTaskMemAlloc function.
///Params:
///    Size = Memory to allocate, in bytes.
///Returns:
///    Returns a void pointer to the allocated space upon success. Returns null upon failure due to insufficient memory.
///    
@DllImport("RPCRT4")
void* NdrOleAllocate(size_t Size);

///The <b>NdrOleFree</b> function is a wrapper for the CoTaskMemFree function.
@DllImport("RPCRT4")
void NdrOleFree(void* NodeToFree);

///The <b>NdrGetUserMarshalInfo</b> function provides additional information to wire_marshal and user_marshal helper
///functions.
///Params:
///    pFlags = Pointer by the same name that RPC passed to the helper function.
///    InformationLevel = Desired level of detail to be received. Different levels imply different sets of information fields. Only level 1
///                       is currently defined.
///    pMarshalInfo = Address of a memory buffer, supplied by the application, to receive the requested information. The buffer must be
///                   at least as large as the information structure indicated by <i>InformationLevel</i>.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> At least one of the arguments was not valid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_X_INVALID_BUFFER</b></dt> </dl> </td> <td width="60%"> Current
///    marshaling buffer was not valid. </td> </tr> </table>
///    
@DllImport("RPCRT4")
int NdrGetUserMarshalInfo(uint* pFlags, uint InformationLevel, NDR_USER_MARSHAL_INFO* pMarshalInfo);

@DllImport("RPCRT4")
int NdrCreateServerInterfaceFromStub(IRpcStubBuffer pStub, RPC_SERVER_INTERFACE* pServerIf);

///<p class="CCE_Message">[NdrClientCall3 is not supported and may be altered or unavailable in the future.]
///NdrClientCall3 may be altered or unavailable.
///Params:
///    pProxyInfo = Reserved.
///    nProcNum = Reserved.
///    pReturnValue = Reserved.
///    arg4 = TBD
@DllImport("RPCRT4")
CLIENT_CALL_RETURN NdrClientCall3(MIDL_STUBLESS_PROXY_INFO* pProxyInfo, uint nProcNum, void* pReturnValue);

///<b>Ndr64AsyncClientCall</b> is not intended to be directly called by applications.
///Params:
///    pProxyInfo = Reserved.
///    nProcNum = Reserved.
///    pReturnValue = Reserved.
///    arg4 = Reserved.
@DllImport("RPCRT4")
CLIENT_CALL_RETURN Ndr64AsyncClientCall(MIDL_STUBLESS_PROXY_INFO* pProxyInfo, uint nProcNum, void* pReturnValue);

@DllImport("RPCRT4")
CLIENT_CALL_RETURN Ndr64DcomAsyncClientCall(MIDL_STUBLESS_PROXY_INFO* pProxyInfo, uint nProcNum, 
                                            void* pReturnValue);

@DllImport("RPCRT4")
void Ndr64AsyncServerCall64(RPC_MESSAGE* pRpcMsg);

///<b>Ndr64AsyncServerCallAll</b> is not intended to be directly called by applications.
@DllImport("RPCRT4")
void Ndr64AsyncServerCallAll(RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4")
int Ndr64DcomAsyncStubCall(IRpcStubBuffer pThis, IRpcChannelBuffer pChannel, RPC_MESSAGE* pRpcMsg, 
                           uint* pdwStubPhase);

///<b>NdrStubCall3</b> is not intended to be directly called by applications.
///Params:
///    pThis = Reserved.
///    pChannel = Reserved.
///    pRpcMsg = Reserved.
///    pdwStubPhase = Reserved.
@DllImport("RPCRT4")
int NdrStubCall3(void* pThis, void* pChannel, RPC_MESSAGE* pRpcMsg, uint* pdwStubPhase);

///<b>NdrServerCallAll</b> is not intended to be directly called by applications.
@DllImport("RPCRT4")
void NdrServerCallAll(RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4")
void NdrServerCallNdr64(RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4")
void NdrPartialIgnoreClientMarshall(MIDL_STUB_MESSAGE* pStubMsg, void* pMemory);

@DllImport("RPCRT4")
void NdrPartialIgnoreServerUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, void** ppMemory);

@DllImport("RPCRT4")
void NdrPartialIgnoreClientBufferSize(MIDL_STUB_MESSAGE* pStubMsg, void* pMemory);

@DllImport("RPCRT4")
void NdrPartialIgnoreServerInitialize(MIDL_STUB_MESSAGE* pStubMsg, void** ppMemory, ubyte* pFormat);

///<p class="CCE_Message">[RpcUserFree is not supported and may be altered or unavailable in the future.] RpcUserFree
///may be altered or unavailable.
///Params:
///    AsyncHandle = Reserved.
@DllImport("RPCRT4")
void RpcUserFree(void* AsyncHandle, void* pBuffer);

///The <b>MesEncodeIncrementalHandleCreate</b> function creates an encoding and then initializes it for the incremental
///style of serialization.
///Params:
///    UserState = Pointer to the user-supplied state object that coordinates the user-supplied <b>Alloc</b>, <b>Write</b>, and
///                <b>Read</b> functions.
///    AllocFn = Pointer to the user-supplied <b>Alloc</b> function.
///    WriteFn = Pointer to the user-supplied <b>Write</b> function.
///    pHandle = Pointer to the newly created handle.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> The argument was invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> Out of memory. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int MesEncodeIncrementalHandleCreate(void* UserState, MIDL_ES_ALLOC AllocFn, MIDL_ES_WRITE WriteFn, void** pHandle);

///The <b>MesDecodeIncrementalHandleCreate</b> function creates a decoding handle for the incremental style of
///serialization.
///Params:
///    UserState = Pointer to the user-supplied state object that coordinates the user-supplied <b>Alloc</b>, <b>Write</b>, and
///                <b>Read</b> functions.
///    ReadFn = Pointer to the <b>Read</b> function.
///    pHandle = Pointer to the newly created handle.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> The argument was invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> Out of memory. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int MesDecodeIncrementalHandleCreate(void* UserState, MIDL_ES_READ ReadFn, void** pHandle);

///The <b>MesIncrementalHandleReset</b> function re-initializes the handle for incremental serialization.
///Params:
///    Handle = Handle to be re-initialized.
///    UserState = Depending on the function, pointer to the user-supplied block that coordinates successive calls to the
///                user-supplied <b>Alloc</b>, <b>Write</b>, and <b>Read</b> functions.
///    AllocFn = Pointer to the user-supplied <b>Alloc</b> function. This parameter can be <b>NULL</b> if the operation does not
///              require it, or if the handle was previously initiated with the pointer.
///    WriteFn = Pointer to the user-supplied <b>Write</b> function. This parameter can be <b>NULL</b> if the operation does not
///              require it, or if the handle was previously initiated with the pointer.
///    ReadFn = Pointer to the user-supplied <b>Read</b> function. This parameter can be <b>NULL</b> if the operation does not
///             require it, or if the handle was previously initiated with the pointer.
///    Operation = Specifies the operation. Valid operations are <b>MES_ENCODE</b>, <b>MES_ENCODE_NDR64</b>, or <b>MES_DECODE</b>.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> The argument was invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> Out of memory. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int MesIncrementalHandleReset(void* Handle, void* UserState, MIDL_ES_ALLOC AllocFn, MIDL_ES_WRITE WriteFn, 
                              MIDL_ES_READ ReadFn, MIDL_ES_CODE Operation);

///The <b>MesEncodeFixedBufferHandleCreate</b> function creates an encoding handle and then initializes it for a fixed
///buffer style of serialization.
///Params:
///    pBuffer = Pointer to the user-supplied buffer.
///    BufferSize = Size of the user-supplied buffer, in bytes.
///    pEncodedSize = Pointer to the size of the completed encoding. The size will be written to the pointee by the subsequent encoding
///                   operation(s).
///    pHandle = Pointer to the newly created handle.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> The argument was invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> Out of memory. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int MesEncodeFixedBufferHandleCreate(char* pBuffer, uint BufferSize, uint* pEncodedSize, void** pHandle);

///The <b>MesEncodeDynBufferHandleCreate</b> function creates an encoding handle and then initializes it for a dynamic
///buffer style of serialization.
///Params:
///    pBuffer = Pointer to a pointer to the stub-supplied buffer containing the encoding after serialization is complete.
///    pEncodedSize = Pointer to the size of the completed encoding. The size will be written to the memory location pointed to by
///                   <i>pEncodedSize</i> by subsequent encoding operations.
///    pHandle = Pointer to the address to which the handle will be written.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> The argument was invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> Out of memory. </td> </tr>
///    </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div>
///    </div>
///    
@DllImport("RPCRT4")
int MesEncodeDynBufferHandleCreate(byte** pBuffer, uint* pEncodedSize, void** pHandle);

///The <b>MesDecodeBufferHandleCreate</b> function creates a decoding handle and initializes it for a (fixed) buffer
///style of serialization.
///Params:
///    Buffer = Pointer to the buffer containing the data to decode.
///    BufferSize = Bytes of data to decode in the buffer.
///    pHandle = Pointer to the address to which the handle will be written.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> The argument was not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> Out of memory. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_X_INVALID_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer was not
///    valid. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return
///    Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int MesDecodeBufferHandleCreate(char* Buffer, uint BufferSize, void** pHandle);

///The <b>MesBufferHandleReset</b> function re-initializes the handle for buffer serialization.
///Params:
///    Handle = Handle to be initialized.
///    HandleStyle = Style of <i>Handle</i>. Valid styles are <b>MES_FIXED_BUFFER_HANDLE</b> or <b>MES_DYNAMIC_BUFFER_HANDLE</b>.
///    Operation = Operation code. Valid codes are <b>MES_ENCODE</b>, <b>MES_ENCODE_NDR64</b>, or <b>MES_DECODE</b>.
///    pBuffer = For <b>MES_DECODE</b>, pointer to a pointer to the buffer containing the data to be decoded. For
///              <b>MES_ENCODE</b>, pointer to a pointer to the buffer for fixed buffer style, and pointer to a pointer to return
///              the buffer address for dynamic buffer style of serialization. For <b>MES_ENCODE_NDR64</b>, pointer to a pointer
///              to the buffer for fixed buffer style, and pointer to a pointer to return the buffer address for dynamic buffer
///              style of serialization, but explicitly uses NDR64 to encode the buffer. The user-provided buffer must be aligned
///              to 16.
///    BufferSize = Bytes of data to be decoded in the buffer. Note that this is used only for the fixed buffer style of
///                 serialization.
///    pEncodedSize = Pointer to the size of the completed encoding. Note that this is used only when the operation is
///                   <b>MES_ENCODE</b> or <b>MES_ENCODE_NDR64</b>.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> The argument was invalid. </td> </tr> </table>
///    <div class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int MesBufferHandleReset(void* Handle, uint HandleStyle, MIDL_ES_CODE Operation, char* pBuffer, uint BufferSize, 
                         uint* pEncodedSize);

///The <b>MesHandleFree</b> function frees the memory allocated by the serialization handle.
///Params:
///    Handle = Handle to be freed.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> </table> <div class="alert"><b>Note</b> For a list of
///    valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int MesHandleFree(void* Handle);

///The <b>MesInqProcEncodingId</b> function provides the identity of an encoding.
///Params:
///    Handle = An encoding or decoding handle.
///    pInterfaceId = Pointer to the address in which the identity of the interface used to encode the data will be written. The
///                   <i>pInterfaceId</i> consists of the interface universally unique identifier UUID and the version number.
///    pProcNum = Number of the function used to encode the data.
///Returns:
///    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_OK</b></dt> </dl>
///    </td> <td width="60%"> The call succeeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_S_INVALID_ARG</b></dt> </dl> </td> <td width="60%"> The argument was not valid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>RPC_S_OUT_OF_MEMORY</b></dt> </dl> </td> <td width="60%"> Out of memory. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNKNOWN_IF</b></dt> </dl> </td> <td width="60%"> Unknown interface. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_S_UNSUPPORTED_TRANS_SYN</b></dt> </dl> </td> <td width="60%">
///    Transfer syntax not supported by server. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_X_INVALID_ES_ACTION</b></dt> </dl> </td> <td width="60%"> Operation for a given handle was not valid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_X_WRONG_ES_VERSION</b></dt> </dl> </td> <td width="60%">
///    Incompatible version of the serializing package. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>RPC_X_SS_INVALID_BUFFER</b></dt> </dl> </td> <td width="60%"> Buffer not valid. </td> </tr> </table> <div
///    class="alert"><b>Note</b> For a list of valid error codes, see RPC Return Values.</div> <div> </div>
///    
@DllImport("RPCRT4")
int MesInqProcEncodingId(void* Handle, RPC_SYNTAX_IDENTIFIER* pInterfaceId, uint* pProcNum);

@DllImport("RPCRT4")
size_t NdrMesSimpleTypeAlignSize(void* param0);

@DllImport("RPCRT4")
void NdrMesSimpleTypeDecode(void* Handle, void* pObject, short Size);

@DllImport("RPCRT4")
void NdrMesSimpleTypeEncode(void* Handle, const(MIDL_STUB_DESC)* pStubDesc, const(void)* pObject, short Size);

@DllImport("RPCRT4")
size_t NdrMesTypeAlignSize(void* Handle, const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString, 
                           const(void)* pObject);

@DllImport("RPCRT4")
void NdrMesTypeEncode(void* Handle, const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString, const(void)* pObject);

@DllImport("RPCRT4")
void NdrMesTypeDecode(void* Handle, const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString, void* pObject);

@DllImport("RPCRT4")
size_t NdrMesTypeAlignSize2(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, 
                            const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString, const(void)* pObject);

@DllImport("RPCRT4")
void NdrMesTypeEncode2(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, 
                       const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString, const(void)* pObject);

@DllImport("RPCRT4")
void NdrMesTypeDecode2(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, 
                       const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString, void* pObject);

@DllImport("RPCRT4")
void NdrMesTypeFree2(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, const(MIDL_STUB_DESC)* pStubDesc, 
                     ubyte* pFormatString, void* pObject);

@DllImport("RPCRT4")
void NdrMesProcEncodeDecode(void* Handle, const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString);

///<p class="CCE_Message">[NdrMesProcEncodeDecode2 is not supported and may be altered or unavailable in the future.]
///NdrMesProcEncodeDecode2 may be altered or unavailable.
///Params:
///    Handle = Reserved.
///    pStubDesc = Reserved.
///    pFormatString = Reserved.
///    arg4 = Reserved.
@DllImport("RPCRT4")
CLIENT_CALL_RETURN NdrMesProcEncodeDecode2(void* Handle, const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString);

@DllImport("RPCRT4")
size_t NdrMesTypeAlignSize3(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, 
                            const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, const(uint)** ArrTypeOffset, 
                            uint nTypeIndex, const(void)* pObject);

@DllImport("RPCRT4")
void NdrMesTypeEncode3(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, 
                       const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, const(uint)** ArrTypeOffset, uint nTypeIndex, 
                       const(void)* pObject);

@DllImport("RPCRT4")
void NdrMesTypeDecode3(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, 
                       const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, const(uint)** ArrTypeOffset, uint nTypeIndex, 
                       void* pObject);

@DllImport("RPCRT4")
void NdrMesTypeFree3(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, 
                     const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, const(uint)** ArrTypeOffset, uint nTypeIndex, 
                     void* pObject);

@DllImport("RPCRT4")
CLIENT_CALL_RETURN NdrMesProcEncodeDecode3(void* Handle, const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, 
                                           uint nProcNum, void* pReturnValue);

@DllImport("RPCRT4")
void NdrMesSimpleTypeDecodeAll(void* Handle, const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, void* pObject, 
                               short Size);

@DllImport("RPCRT4")
void NdrMesSimpleTypeEncodeAll(void* Handle, const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, const(void)* pObject, 
                               short Size);

@DllImport("RPCRT4")
size_t NdrMesSimpleTypeAlignSizeAll(void* Handle, const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo);

///Server programs use the <b>RpcCertGeneratePrincipalName</b> function to generate principal names for security
///certificates.
///Params:
///    Context = Pointer to the security-certificate context.
///    Flags = Currently, the only valid flag for this parameter is RPC_C_FULL_CERT_CHAIN. Using this flag causes the principal
///            name to be generated in fullsic format.
///    pBuffer = Pointer to a pointer. The <b>RpcCertGeneratePrincipalName</b> function sets this to point at a null-terminated
///              string that contains the principal name.
///Returns:
///    This function does not return a value.
///    
@DllImport("RPCRT4")
int RpcCertGeneratePrincipalNameW(CERT_CONTEXT* Context, uint Flags, ushort** pBuffer);

///Server programs use the <b>RpcCertGeneratePrincipalName</b> function to generate principal names for security
///certificates.
///Params:
///    Context = Pointer to the security-certificate context.
///    Flags = Currently, the only valid flag for this parameter is RPC_C_FULL_CERT_CHAIN. Using this flag causes the principal
///            name to be generated in fullsic format.
///    pBuffer = Pointer to a pointer. The <b>RpcCertGeneratePrincipalName</b> function sets this to point at a null-terminated
///              string that contains the principal name.
///Returns:
///    This function does not return a value.
///    
@DllImport("RPCRT4")
int RpcCertGeneratePrincipalNameA(CERT_CONTEXT* Context, uint Flags, ubyte** pBuffer);


