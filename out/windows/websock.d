// Written in the D programming language.

module windows.websock;

public import windows.core;
public import windows.com : HRESULT;

extern(Windows):


// Enums


///The <b>WEB_SOCKET_CLOSE_STATUS</b> enumeration specifies the WebSocket close status as defined by WSPROTO.
alias WEB_SOCKET_CLOSE_STATUS = int;
enum : int
{
    ///Close completed successfully.
    WEB_SOCKET_SUCCESS_CLOSE_STATUS                = 0x000003e8,
    ///The endpoint is going away and thus closing the connection.
    WEB_SOCKET_ENDPOINT_UNAVAILABLE_CLOSE_STATUS   = 0x000003e9,
    ///Peer detected protocol error and it is closing the connection.
    WEB_SOCKET_PROTOCOL_ERROR_CLOSE_STATUS         = 0x000003ea,
    ///The endpoint cannot receive this type of data.
    WEB_SOCKET_INVALID_DATA_TYPE_CLOSE_STATUS      = 0x000003eb,
    ///No close status code was provided.
    WEB_SOCKET_EMPTY_CLOSE_STATUS                  = 0x000003ed,
    ///The connection was closed without sending or receiving a close frame.
    WEB_SOCKET_ABORTED_CLOSE_STATUS                = 0x000003ee,
    ///Data within a message is not consistent with the type of the message.
    WEB_SOCKET_INVALID_PAYLOAD_CLOSE_STATUS        = 0x000003ef,
    ///The message violates an endpoint's policy.
    WEB_SOCKET_POLICY_VIOLATION_CLOSE_STATUS       = 0x000003f0,
    ///The message sent was too large to process.
    WEB_SOCKET_MESSAGE_TOO_BIG_CLOSE_STATUS        = 0x000003f1,
    ///A client endpoint expected the server to negotiate one or more extensions, but the server didn't return them in
    ///the response message of the WebSocket handshake.
    WEB_SOCKET_UNSUPPORTED_EXTENSIONS_CLOSE_STATUS = 0x000003f2,
    ///An unexpected condition prevented the server from fulfilling the request.
    WEB_SOCKET_SERVER_ERROR_CLOSE_STATUS           = 0x000003f3,
    ///The TLS handshake could not be completed.
    WEB_SOCKET_SECURE_HANDSHAKE_ERROR_CLOSE_STATUS = 0x000003f7,
}

///The <b>WEB_SOCKET_PROPERTY_TYPE</b> enumeration specifies a WebSocket property type.
alias WEB_SOCKET_PROPERTY_TYPE = int;
enum : int
{
    ///Property type: <b>ULONG</b> The WebSocket property is the internal receive buffer size. The buffer cannot be
    ///smaller than 256 bytes. The default is 4096. Used with WebSocketCreateClientHandle and
    ///WebSocketCreateServerHandle.
    WEB_SOCKET_RECEIVE_BUFFER_SIZE_PROPERTY_TYPE       = 0x00000000,
    ///Property type: <b>ULONG</b> The WebSocket property is the internal send buffer size. The buffer cannot be smaller
    ///than 256 bytes. The default is 4096 on a handle created with WebSocketCreateClientHandle, and 16 on a handle
    ///created with WebSocketCreateServerHandle. Used with WebSocketCreateClientHandle and WebSocketCreateServerHandle.
    WEB_SOCKET_SEND_BUFFER_SIZE_PROPERTY_TYPE          = 0x00000001,
    ///Property type: <b>BOOL</b> The WebSocket property is the disabling of the mask bit in client frames. On the
    ///client, this property sets the mask key to 0. On the server, this property allows the server to accept client
    ///frames with the mask bit set to 0. This property may have serious security implications. By default, this
    ///property is not used and masking is enabled. Used with WebSocketCreateClientHandle and
    ///WebSocketCreateServerHandle.
    WEB_SOCKET_DISABLE_MASKING_PROPERTY_TYPE           = 0x00000002,
    ///Property type: <b>PVOID</b> The WebSocket property is the buffer that is used as an internal buffer. If the
    ///passed buffer is not used, the WebSocket library will take care of buffer management. The passed buffer must be
    ///aligned to an 8-byte boundary and be greater in size than the receive buffer size + send buffer size + 256 bytes.
    ///Used with WebSocketCreateClientHandle and WebSocketCreateServerHandle.
    WEB_SOCKET_ALLOCATED_BUFFER_PROPERTY_TYPE          = 0x00000003,
    ///Property type: <b>BOOL</b> The WebSocket property disables UTF-8 verification. Used with
    ///WebSocketCreateClientHandle and WebSocketCreateServerHandle.
    WEB_SOCKET_DISABLE_UTF8_VERIFICATION_PROPERTY_TYPE = 0x00000004,
    ///Property type: <b>ULONG</b> The WebSocket property is the interval, in milliseconds, to send a keep-alive packet
    ///over the connection. The default interval is 30000 (30 seconds). The minimum interval is 15000 (15 seconds). <div
    ///class="alert"><b>Note</b> The default value for the keep-alive interval is read from
    ///<b>HKLM:\SOFTWARE\Microsoft\WebSocket\KeepaliveInterval</b>. If a value is not set, the default value of 30000
    ///will be used. It is not possible to have a lower keepalive interval than 15000 milliseconds. If a lower value is
    ///set, 15000 milliseconds will be used.</div> <div> </div> Used with WebSocketGetGlobalProperty.
    WEB_SOCKET_KEEPALIVE_INTERVAL_PROPERTY_TYPE        = 0x00000005,
    ///Property type: <b>ULONG</b> array The WebSocket property is the versions of the WebSocket protocol that are
    ///supported. Used with WebSocketGetGlobalProperty.
    WEB_SOCKET_SUPPORTED_VERSIONS_PROPERTY_TYPE        = 0x00000006,
}

///The <b>WEB_SOCKET_ACTION_QUEUE</b> enumeration specifies the action types returned by WebSocketGetAction.
alias WEB_SOCKET_ACTION_QUEUE = int;
enum : int
{
    ///WebSocketGetAction will return only send-related actions.
    WEB_SOCKET_SEND_ACTION_QUEUE    = 0x00000001,
    ///WebSocketGetAction will return receive-related actions as well as internal send actions (reply to a ping frame).
    WEB_SOCKET_RECEIVE_ACTION_QUEUE = 0x00000002,
    ///WebSocketGetAction will return all actions.
    WEB_SOCKET_ALL_ACTION_QUEUE     = 0x00000003,
}

///The <b>WEB_SOCKET_BUFFER_TYPE</b> enumeration specifies the bit values used to construct the WebSocket frame header.
alias WEB_SOCKET_BUFFER_TYPE = int;
enum : int
{
    ///Indicates the buffer contains the last, and possibly only, part of a UTF8 message.
    WEB_SOCKET_UTF8_MESSAGE_BUFFER_TYPE     = 0x80000000,
    ///Indicates the buffer contains part of a UTF8 message.
    WEB_SOCKET_UTF8_FRAGMENT_BUFFER_TYPE    = 0x80000001,
    ///Indicates the buffer contains the last, and possibly only, part of a binary message.
    WEB_SOCKET_BINARY_MESSAGE_BUFFER_TYPE   = 0x80000002,
    ///Indicates the buffer contains part of a binary message.
    WEB_SOCKET_BINARY_FRAGMENT_BUFFER_TYPE  = 0x80000003,
    ///Indicates the buffer contains a close message.
    WEB_SOCKET_CLOSE_BUFFER_TYPE            = 0x80000004,
    ///Indicates the buffer contains a ping or pong message. When sending, this value means 'ping', when processing
    ///received data, this value means 'pong'.
    WEB_SOCKET_PING_PONG_BUFFER_TYPE        = 0x80000005,
    ///Indicates the buffer contains an unsolicited pong message.
    WEB_SOCKET_UNSOLICITED_PONG_BUFFER_TYPE = 0x80000006,
}

///The <b>WEB_SOCKET_ACTION</b> enumeration specifies actions to be taken by WebSocket applications.
alias WEB_SOCKET_ACTION = int;
enum : int
{
    ///There are no actions to process.
    WEB_SOCKET_NO_ACTION                        = 0x00000000,
    ///Indicates the application should send the buffers to a network.
    WEB_SOCKET_SEND_TO_NETWORK_ACTION           = 0x00000001,
    ///Indicates the operation queued by WebSocketSend is complete. The application context returned by
    ///WebSocketCompleteAction for this send operation is no longer needed, therefore it should be freed.
    WEB_SOCKET_INDICATE_SEND_COMPLETE_ACTION    = 0x00000002,
    ///Indicates the application should fill the buffers with data from a network.
    WEB_SOCKET_RECEIVE_FROM_NETWORK_ACTION      = 0x00000003,
    ///Indicates the operation queued by WebSocketReceive is complete. The application context returned by
    ///WebSocketCompleteAction for this receive operation is no longer needed, therefore it should be freed.
    WEB_SOCKET_INDICATE_RECEIVE_COMPLETE_ACTION = 0x00000004,
}

// Structs


struct WEB_SOCKET_HANDLE__
{
    int unused;
}

///The <b>WEB_SOCKET_PROPERTY</b> structure contains a single WebSocket property.
struct WEB_SOCKET_PROPERTY
{
    ///Type: <b>WEB_SOCKET_PROPERTY_TYPE</b> The WebSocket property type.
    WEB_SOCKET_PROPERTY_TYPE Type;
    ///Type: <b>PVOID</b> A pointer to the value to set. The pointer must have an alignment compatible with the type of
    ///the property.
    void* pvValue;
    ///Type: <b>ULONG</b> The size, in bytes, of the property pointed to by <b>pvValue</b>.
    uint  ulValueSize;
}

///The <b>WEB_SOCKET_HTTP_HEADER</b> structure contains an HTTP header.
struct WEB_SOCKET_HTTP_HEADER
{
    ///Type: <b>PCHAR</b> A pointer to the HTTP header name. The name must not contain a colon character.
    const(char)* pcName;
    ///Type: <b>ULONG</b> Length, in characters, of the HTTP header pointed to by <b>pcName</b>.
    uint         ulNameLength;
    ///Type: <b>PCHAR</b> A pointer to the HTTP header value.
    const(char)* pcValue;
    ///Type: <b>ULONG</b> Length, in characters, of the HTTP value pointed to by <b>pcValue</b>.
    uint         ulValueLength;
}

///The <b>WEB_SOCKET_BUFFER</b> structure contains data for a specific WebSocket action.
union WEB_SOCKET_BUFFER
{
    struct Data
    {
        ubyte* pbBuffer;
        uint   ulBufferLength;
    }
    struct CloseStatus
    {
        ubyte* pbReason;
        uint   ulReasonLength;
        ushort usStatus;
    }
}

// Functions

///The <b>WebSocketCreateClientHandle</b> function creates a client-side WebSocket session handle.
///Params:
///    pProperties = Type: <b>const PWEB_SOCKET_PROPERTY</b> Pointer to an array of WEB_SOCKET_PROPERTY structures that contain
///                  WebSocket session-related properties.
///    ulPropertyCount = Type: <b>ULONG</b> Number of properties in <i>pProperties</i>.
///    phWebSocket = Type: <b>WEB_SOCKET_HANDLE*</b> On successful output, pointer to a newly allocated client-side WebSocket session
///                  handle.
///Returns:
///    Type: <b>HRESULT</b> If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns a system
///    error code defined in WinError.h.
///    
@DllImport("websocket")
HRESULT WebSocketCreateClientHandle(char* pProperties, uint ulPropertyCount, WEB_SOCKET_HANDLE__** phWebSocket);

///The <b>WebSocketBeginClientHandshake</b> function begins the client-side handshake.
///Params:
///    hWebSocket = Type: <b>WEB_SOCKET_HANDLE</b> WebSocket session handle returned by a previous call to
///                 WebSocketCreateClientHandle.
///    pszSubprotocols = Type: <b>PCSTR*</b> Pointer to an array of sub-protocols chosen by the application. Once the client-server
///                      handshake is complete, the application must use the sub-protocol returned by WebSocketEndClientHandshake. Must
///                      contain one subprotocol per entry.
///    ulSubprotocolCount = Type: <b>ULONG</b> Number of sub-protocols in <i>pszSubprotocols</i>.
///    pszExtensions = Type: <b>PCSTR*</b> Pointer to an array of extensions chosen by the application. Once the client-server handshake
///                    is complete, the application must use the extension returned by WebSocketEndClientHandshake. Must contain one
///                    extension per entry.
///    ulExtensionCount = Type: <b>ULONG</b> Number of extensions in <i>pszExtensions</i>.
///    pInitialHeaders = Type: <b>const PWEB_SOCKET_HTTP_HEADER</b> Pointer to an array of WEB_SOCKET_HTTP_HEADER structures that contain
///                      the request headers to be sent by the application. The array must include the <i>Host HTTP</i> header as defined
///                      in RFC 2616.
///    ulInitialHeaderCount = Type: <b>ULONG</b> Number of request headers in <i>pInitialHeaders</i>.
///    pAdditionalHeaders = Type: <b>PWEB_SOCKET_HTTP_HEADER</b> On successful output, pointer to an array of WEB_SOCKET_HTTP_HEADER
///                         structures that contain the request headers to be sent by the application. If any of these headers were specified
///                         in <i>pInitialHeaders</i>, the header must be replaced.
///    pulAdditionalHeaderCount = Type: <b>ULONG*</b> On successful output, number of response headers in <i>pAdditionalHeaders</i>.
///Returns:
///    Type: <b>HRESULT</b> If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns a system
///    error code defined in WinError.h.
///    
@DllImport("websocket")
HRESULT WebSocketBeginClientHandshake(WEB_SOCKET_HANDLE__* hWebSocket, char* pszSubprotocols, 
                                      uint ulSubprotocolCount, char* pszExtensions, uint ulExtensionCount, 
                                      char* pInitialHeaders, uint ulInitialHeaderCount, char* pAdditionalHeaders, 
                                      uint* pulAdditionalHeaderCount);

///The <b>WebSocketEndClientHandshake</b> function completes the client-side handshake.
///Params:
///    hWebSocket = Type: <b>WEB_SOCKET_HANDLE</b> WebSocket session handle returned by a previous call to
///                 WebSocketCreateClientHandle.
///    pResponseHeaders = Type: <b>const PWEB_SOCKET_HTTP_HEADER</b> Pointer to an array or WEB_SOCKET_HTTP_HEADER structures that contain
///                       the response headers received by the application.
///    ulReponseHeaderCount = Type: <b>ULONG</b> Number of response headers in <i>pResponseHeaders</i>.
///    pulSelectedExtensions = Type: <b>ULONG*</b> On input, pointer to an array allocated by the application. On successful output, pointer to
///                            an array of numbers that represent the extensions chosen by the server during the client-server handshake. These
///                            number are the zero-based indices into the extensions array passed to <i>pszExtensions</i> in
///                            WebSocketBeginClientHandshake.
///    pulSelectedExtensionCount = Type: <b>ULONG*</b> On input, number of extensions allocated in <i>pulSelectedExtensions</i>. This must be at
///                                least equal to the number passed to <i>ulExtensionCount</i> in <b>WebSocketEndClientHandshake</b>. On successful
///                                output, number of extensions returned in <i>pulSelectedExtensions</i>.
///    pulSelectedSubprotocol = Type: <b>ULONG*</b> On successful output, pointer to a number that represents the sub-protocol chosen by the
///                             server during the client-server handshake. This number is the zero-based index into the sub-protocols array
///                             passed to <i>pszSubprotocols</i> in WebSocketBeginClientHandshake.
///Returns:
///    Type: <b>HRESULT</b> If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns one of
///    the following or a system error code defined in WinError.h. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALID_PROTOCOL_FORMAT</b></dt> </dl> </td> <td
///    width="60%"> Protocol data had an invalid format. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_UNSUPPORTED_SUBPROTOCOL</b></dt> </dl> </td> <td width="60%"> Server does not accept any of the
///    sub-protocols specified by the application. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_UNSUPPORTED_EXTENSION</b></dt> </dl> </td> <td width="60%"> Server does not accept extensions specified
///    by the application. </td> </tr> </table>
///    
@DllImport("websocket")
HRESULT WebSocketEndClientHandshake(WEB_SOCKET_HANDLE__* hWebSocket, char* pResponseHeaders, 
                                    uint ulReponseHeaderCount, char* pulSelectedExtensions, 
                                    uint* pulSelectedExtensionCount, uint* pulSelectedSubprotocol);

///The <b>WebSocketCreateServerHandle</b> function creates a server-side WebSocket session handle.
///Params:
///    pProperties = Type: <b>const PWEB_SOCKET_PROPERTY</b> Pointer to an array of WEB_SOCKET_PROPERTY structures that contain
///                  WebSocket session-related properties.
///    ulPropertyCount = Type: <b>ULONG</b> Number of properties in <i>pProperties</i>.
///    phWebSocket = Type: <b>WEB_SOCKET_HANDLE*</b> On successful output, pointer to a newly allocated server-side WebSocket session
///                  handle.
///Returns:
///    Type: <b>HRESULT</b> If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns a system
///    error code defined in WinError.h.
///    
@DllImport("websocket")
HRESULT WebSocketCreateServerHandle(char* pProperties, uint ulPropertyCount, WEB_SOCKET_HANDLE__** phWebSocket);

///The <b>WebSocketBeginServerHandshake</b> function begins the server-side handshake.
///Params:
///    hWebSocket = Type: <b>WEB_SOCKET_HANDLE</b> WebSocket session handle returned by a previous call to
///                 WebSocketCreateServerHandle.
///    pszSubprotocolSelected = Type: <b>PCSTR</b> A pointer to a sub-protocol value chosen by the application. Must contain one subprotocol.
///    pszExtensionSelected = Type: <b>PCSTR*</b> A pointer to a list of extensions chosen by the application. Must contain one extension per
///                           entry.
///    ulExtensionSelectedCount = Type: <b>ULONG</b> Number of extensions in <i>pszExtensionSelected</i>.
///    pRequestHeaders = Type: <b>const PWEB_SOCKET_HTTP_HEADER</b> Pointer to an array of WEB_SOCKET_HTTP_HEADER structures that contain
///                      the request headers received by the application.
///    ulRequestHeaderCount = Type: <b>ULONG</b> Number of request headers in <i>pRequestHeaders</i>.
///    pResponseHeaders = Type: <b>PWEB_SOCKET_HTTP_HEADER*</b> On successful output, a pointer to an array or WEB_SOCKET_HTTP_HEADER
///                       structures that contain the response headers to be sent by the application.
///    pulResponseHeaderCount = Type: <b>ULONG*</b> On successful output, number of response headers in <i>pResponseHeaders</i>.
///Returns:
///    Type: <b>HRESULT</b> If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns one of
///    the following or a system error code defined in WinError.h. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALID_PROTOCOL_FORMAT</b></dt> </dl> </td> <td
///    width="60%"> Protocol data had an invalid format. </td> </tr> </table>
///    
@DllImport("websocket")
HRESULT WebSocketBeginServerHandshake(WEB_SOCKET_HANDLE__* hWebSocket, const(char)* pszSubprotocolSelected, 
                                      char* pszExtensionSelected, uint ulExtensionSelectedCount, 
                                      char* pRequestHeaders, uint ulRequestHeaderCount, char* pResponseHeaders, 
                                      uint* pulResponseHeaderCount);

///The <b>WebSocketEndServerHandshake</b> function completes the server-side handshake.
///Params:
///    hWebSocket = Type: <b>WEB_SOCKET_HANDLE</b> WebSocket session handle returned by a previous call to
///                 WebSocketCreateServerHandle.
///Returns:
///    Type: <b>HRESULT</b> If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns a system
///    error code defined in WinError.h.
///    
@DllImport("websocket")
HRESULT WebSocketEndServerHandshake(WEB_SOCKET_HANDLE__* hWebSocket);

///The <b>WebSocketSend</b> function adds a send operation to the protocol component operation queue.
///Params:
///    hWebSocket = Type: <b>WEB_SOCKET_HANDLE</b> WebSocket session handle returned by a previous call to
///                 WebSocketCreateClientHandle or WebSocketCreateServerHandle.
///    BufferType = Type: <b>WEB_SOCKET_BUFFER_TYPE</b> The type of WebSocket buffer data to send in <i>pBuffer</i>.
///    pBuffer = Type: <b>WEB_SOCKET_BUFFER*</b> A pointer to an array of WEB_SOCKET_BUFFER structures that contains WebSocket
///              buffer data to send. If <i>BufferType</i> is WEB_SOCKET_PING_PONG_BUFFER_TYPE or
///              WEB_SOCKET_UNSOLICITED_PONG_BUFFER_TYPE, <i>pBuffer</i> must be <b>NULL</b>. <div class="alert"><b>Note</b> Once
///              WEB_SOCKET_INDICATE_SEND_COMPLETE is returned by WebSocketGetAction for this action, the memory pointer to by
///              <i>pBuffer</i> can be reclaimed.</div> <div> </div>
///    Context = Type: <b>PVOID</b> A pointer to an application context handle that will be returned by a subsequent call to
///              WebSocketGetAction.
///Returns:
///    Type: <b>HRESULT</b> If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns one of
///    the following or a system error code defined in WinError.h. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALID_PROTOCOL_OPERATION</b></dt> </dl> </td>
///    <td width="60%"> Protocol performed an invalid operation. </td> </tr> </table>
///    
@DllImport("websocket")
HRESULT WebSocketSend(WEB_SOCKET_HANDLE__* hWebSocket, WEB_SOCKET_BUFFER_TYPE BufferType, 
                      WEB_SOCKET_BUFFER* pBuffer, void* Context);

///The <b>WebSocketReceive</b> function adds a receive operation to the protocol component operation queue.
///Params:
///    hWebSocket = Type: <b>WEB_SOCKET_HANDLE</b> WebSocket session handle returned by a previous call to
///                 WebSocketCreateClientHandle or WebSocketCreateServerHandle.
///    pBuffer = Type: <b>WEB_SOCKET_BUFFER*</b> A pointer to an array of WEB_SOCKET_BUFFER structures that WebSocket data will be
///              written to when it is returned by WebSocketGetAction. If <b>NULL</b>, <b>WebSocketGetAction</b> will return an
///              internal buffer that enables zero-copy scenarios. <div class="alert"><b>Note</b> Once
///              WEB_SOCKET_INDICATE_RECEIVE_COMPLETE is returned by WebSocketGetAction for this action, the memory pointer to by
///              <i>pBuffer</i> can be reclaimed.</div> <div> </div>
///    pvContext = Type: <b>PVOID</b> A pointer to an application context handle that will be returned by a subsequent call to
///                WebSocketGetAction.
///Returns:
///    Type: <b>HRESULT</b> If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns one of
///    the following or a system error code defined in WinError.h. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALID_PROTOCOL_OPERATION</b></dt> </dl> </td>
///    <td width="60%"> Protocol performed an invalid operation. </td> </tr> </table>
///    
@DllImport("websocket")
HRESULT WebSocketReceive(WEB_SOCKET_HANDLE__* hWebSocket, WEB_SOCKET_BUFFER* pBuffer, void* pvContext);

///The <b>WebSocketGetAction</b> function returns an action from a call to WebSocketSend, WebSocketReceive or
///WebSocketCompleteAction.
///Params:
///    hWebSocket = Type: <b>WEB_SOCKET_HANDLE</b> WebSocket session handle returned by a previous call to
///                 WebSocketCreateClientHandle or WebSocketCreateServerHandle.
///    eActionQueue = Type: <b>WEB_SOCKET_ACTION_QUEUE</b> Enumeration that specifies whether to query the send queue, the receive
///                   queue, or both.
///    pDataBuffers = Type: <b>WEB_SOCKET_BUFFER*</b> Pointer to an array of WEB_SOCKET_BUFFER structures that contain WebSocket buffer
///                   data. <div class="alert"><b>Note</b> Do not allocate or deallocate memory for WEB_SOCKET_BUFFER structures,
///                   because they will be overwritten by <b>WebSocketGetAction</b>. The memory for buffers returned by
///                   <b>WebSocketGetAction</b> are managed by the library.</div> <div> </div>
///    pulDataBufferCount = Type: <b>ULONG*</b> On input, pointer to a value that specifies the number of elements in <i>pDataBuffers</i>. On
///                         successful output, number of elements that were actually returned in <i>pDataBuffers</i>.
///    pAction = Type: <b>WEB_SOCKET_ACTION*</b> On successful output, pointer to a WEB_SOCKET_ACTION enumeration that specifies
///              the action returned from the query to the queue defines in <i>eActionQueue</i>.
///    pBufferType = Type: <b>WEB_SOCKET_BUFFER_TYPE*</b> On successful output, pointer to a WEB_SOCKET_BUFFER_TYPE enumeration that
///                  specifies the type of Web Socket buffer data returned in <i>pDataBuffers</i>.
///    pvApplicationContext = Type: <b>PVOID*</b> On successful output, pointer to an application context handle. The context returned here was
///                           initially passed to WebSocketSend or WebSocketReceive. <i>pvApplicationContext</i> is not set if <i>pAction</i>
///                           is WEB_SOCKET_NO_ACTION or WEB_SOCKET_SEND_TO_NETWORK_ACTION when sending a pong in response to receiving a ping.
///    pvActionContext = Type: <b>PVOID*</b> On successful output, pointer to an action context handle. This handle is passed into a
///                      subsequent call WebSocketCompleteAction.
///Returns:
///    Type: <b>HRESULT</b> If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns one of
///    the following or a system error code defined in WinError.h. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALID_PROTOCOL_FORMAT</b></dt> </dl> </td> <td
///    width="60%"> Protocol data had invalid format. This is only returned for receive operations. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALID_PROTOCOL_OPERATION</b></dt> </dl> </td> <td width="60%"> Protocol performed
///    invalid operations. This is only returned for receive operations. </td> </tr> </table>
///    
@DllImport("websocket")
HRESULT WebSocketGetAction(WEB_SOCKET_HANDLE__* hWebSocket, WEB_SOCKET_ACTION_QUEUE eActionQueue, 
                           char* pDataBuffers, uint* pulDataBufferCount, WEB_SOCKET_ACTION* pAction, 
                           WEB_SOCKET_BUFFER_TYPE* pBufferType, void** pvApplicationContext, void** pvActionContext);

///The <b>WebSocketCompleteAction</b> function completes an action started by WebSocketGetAction.
///Params:
///    hWebSocket = Type: <b>WEB_SOCKET_HANDLE</b> WebSocket session handle returned by a previous call to
///                 WebSocketCreateClientHandle or WebSocketCreateServerHandle.
///    pvActionContext = Type: <b>PVOID</b> Pointer to an action context handle that was returned by a previous call to
///                      WebSocketGetAction.
///    ulBytesTransferred = Type: <b>ULONG</b> Number of bytes transferred for the WEB_SOCKET_SEND_TO_NETWORK_ACTION or
///                         <b>WEB_SOCKET_RECEIVE_FROM_NETWORK_ACTION</b> actions. This value must be 0 for all other actions.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns a system error code defined
///    in WinError.h.
///    
@DllImport("websocket")
void WebSocketCompleteAction(WEB_SOCKET_HANDLE__* hWebSocket, void* pvActionContext, uint ulBytesTransferred);

///The <b>WebSocketAbortHandle</b> function aborts a WebSocket session handle created by WebSocketCreateClientHandle or
///WebSocketCreateServerHandle.
///Params:
///    hWebSocket = Type: <b>WEB_SOCKET_HANDLE</b> WebSocket session handle returned by a previous call to
///                 WebSocketCreateClientHandle or WebSocketCreateServerHandle.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns a system error code defined
///    in WinError.h.
///    
@DllImport("websocket")
void WebSocketAbortHandle(WEB_SOCKET_HANDLE__* hWebSocket);

///The <b>WebSocketDeleteHandle</b> function deletes a WebSocket session handle created by WebSocketCreateClientHandle
///or WebSocketCreateServerHandle.
///Params:
///    hWebSocket = Type: <b>WEB_SOCKET_HANDLE</b> WebSocket session handle returned by a previous call to
///                 WebSocketCreateClientHandle or WebSocketCreateServerHandle.
///Returns:
///    If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns a system error code defined
///    in WinError.h.
///    
@DllImport("websocket")
void WebSocketDeleteHandle(WEB_SOCKET_HANDLE__* hWebSocket);

///The <b>WebSocketGetGlobalProperty</b> function gets a single WebSocket property.
///Params:
///    eType = Type: <b>WEB_SOCKET_PROPERTY</b> A WebSocket property.
///    pvValue = Type: <b>PVOID</b> A pointer to the property value. The pointer must have an alignment compatible with the type
///              of the property.
///    ulSize = Type: <b>ULONG*</b> The size, in bytes, of the property pointed to by <b>pvValue</b>.
///Returns:
///    Type: <b>HRESULT</b> If the function succeeds, it returns <b>S_OK</b>. If the function fails, it returns a system
///    error code defined in WinError.h.
///    
@DllImport("websocket")
HRESULT WebSocketGetGlobalProperty(WEB_SOCKET_PROPERTY_TYPE eType, char* pvValue, uint* ulSize);


