module windows.websock;

public import windows.core;
public import windows.com : HRESULT;

extern(Windows):


// Enums


enum : int
{
    WEB_SOCKET_SUCCESS_CLOSE_STATUS                = 0x000003e8,
    WEB_SOCKET_ENDPOINT_UNAVAILABLE_CLOSE_STATUS   = 0x000003e9,
    WEB_SOCKET_PROTOCOL_ERROR_CLOSE_STATUS         = 0x000003ea,
    WEB_SOCKET_INVALID_DATA_TYPE_CLOSE_STATUS      = 0x000003eb,
    WEB_SOCKET_EMPTY_CLOSE_STATUS                  = 0x000003ed,
    WEB_SOCKET_ABORTED_CLOSE_STATUS                = 0x000003ee,
    WEB_SOCKET_INVALID_PAYLOAD_CLOSE_STATUS        = 0x000003ef,
    WEB_SOCKET_POLICY_VIOLATION_CLOSE_STATUS       = 0x000003f0,
    WEB_SOCKET_MESSAGE_TOO_BIG_CLOSE_STATUS        = 0x000003f1,
    WEB_SOCKET_UNSUPPORTED_EXTENSIONS_CLOSE_STATUS = 0x000003f2,
    WEB_SOCKET_SERVER_ERROR_CLOSE_STATUS           = 0x000003f3,
    WEB_SOCKET_SECURE_HANDSHAKE_ERROR_CLOSE_STATUS = 0x000003f7,
}
alias WEB_SOCKET_CLOSE_STATUS = int;

enum : int
{
    WEB_SOCKET_RECEIVE_BUFFER_SIZE_PROPERTY_TYPE       = 0x00000000,
    WEB_SOCKET_SEND_BUFFER_SIZE_PROPERTY_TYPE          = 0x00000001,
    WEB_SOCKET_DISABLE_MASKING_PROPERTY_TYPE           = 0x00000002,
    WEB_SOCKET_ALLOCATED_BUFFER_PROPERTY_TYPE          = 0x00000003,
    WEB_SOCKET_DISABLE_UTF8_VERIFICATION_PROPERTY_TYPE = 0x00000004,
    WEB_SOCKET_KEEPALIVE_INTERVAL_PROPERTY_TYPE        = 0x00000005,
    WEB_SOCKET_SUPPORTED_VERSIONS_PROPERTY_TYPE        = 0x00000006,
}
alias WEB_SOCKET_PROPERTY_TYPE = int;

enum : int
{
    WEB_SOCKET_SEND_ACTION_QUEUE    = 0x00000001,
    WEB_SOCKET_RECEIVE_ACTION_QUEUE = 0x00000002,
    WEB_SOCKET_ALL_ACTION_QUEUE     = 0x00000003,
}
alias WEB_SOCKET_ACTION_QUEUE = int;

enum : int
{
    WEB_SOCKET_UTF8_MESSAGE_BUFFER_TYPE     = 0x80000000,
    WEB_SOCKET_UTF8_FRAGMENT_BUFFER_TYPE    = 0x80000001,
    WEB_SOCKET_BINARY_MESSAGE_BUFFER_TYPE   = 0x80000002,
    WEB_SOCKET_BINARY_FRAGMENT_BUFFER_TYPE  = 0x80000003,
    WEB_SOCKET_CLOSE_BUFFER_TYPE            = 0x80000004,
    WEB_SOCKET_PING_PONG_BUFFER_TYPE        = 0x80000005,
    WEB_SOCKET_UNSOLICITED_PONG_BUFFER_TYPE = 0x80000006,
}
alias WEB_SOCKET_BUFFER_TYPE = int;

enum : int
{
    WEB_SOCKET_NO_ACTION                        = 0x00000000,
    WEB_SOCKET_SEND_TO_NETWORK_ACTION           = 0x00000001,
    WEB_SOCKET_INDICATE_SEND_COMPLETE_ACTION    = 0x00000002,
    WEB_SOCKET_RECEIVE_FROM_NETWORK_ACTION      = 0x00000003,
    WEB_SOCKET_INDICATE_RECEIVE_COMPLETE_ACTION = 0x00000004,
}
alias WEB_SOCKET_ACTION = int;

// Structs


struct WEB_SOCKET_HANDLE__
{
    int unused;
}

struct WEB_SOCKET_PROPERTY
{
    WEB_SOCKET_PROPERTY_TYPE Type;
    void* pvValue;
    uint  ulValueSize;
}

struct WEB_SOCKET_HTTP_HEADER
{
    const(char)* pcName;
    uint         ulNameLength;
    const(char)* pcValue;
    uint         ulValueLength;
}

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

@DllImport("websocket")
HRESULT WebSocketCreateClientHandle(char* pProperties, uint ulPropertyCount, WEB_SOCKET_HANDLE__** phWebSocket);

@DllImport("websocket")
HRESULT WebSocketBeginClientHandshake(WEB_SOCKET_HANDLE__* hWebSocket, char* pszSubprotocols, 
                                      uint ulSubprotocolCount, char* pszExtensions, uint ulExtensionCount, 
                                      char* pInitialHeaders, uint ulInitialHeaderCount, char* pAdditionalHeaders, 
                                      uint* pulAdditionalHeaderCount);

@DllImport("websocket")
HRESULT WebSocketEndClientHandshake(WEB_SOCKET_HANDLE__* hWebSocket, char* pResponseHeaders, 
                                    uint ulReponseHeaderCount, char* pulSelectedExtensions, 
                                    uint* pulSelectedExtensionCount, uint* pulSelectedSubprotocol);

@DllImport("websocket")
HRESULT WebSocketCreateServerHandle(char* pProperties, uint ulPropertyCount, WEB_SOCKET_HANDLE__** phWebSocket);

@DllImport("websocket")
HRESULT WebSocketBeginServerHandshake(WEB_SOCKET_HANDLE__* hWebSocket, const(char)* pszSubprotocolSelected, 
                                      char* pszExtensionSelected, uint ulExtensionSelectedCount, 
                                      char* pRequestHeaders, uint ulRequestHeaderCount, char* pResponseHeaders, 
                                      uint* pulResponseHeaderCount);

@DllImport("websocket")
HRESULT WebSocketEndServerHandshake(WEB_SOCKET_HANDLE__* hWebSocket);

@DllImport("websocket")
HRESULT WebSocketSend(WEB_SOCKET_HANDLE__* hWebSocket, WEB_SOCKET_BUFFER_TYPE BufferType, 
                      WEB_SOCKET_BUFFER* pBuffer, void* Context);

@DllImport("websocket")
HRESULT WebSocketReceive(WEB_SOCKET_HANDLE__* hWebSocket, WEB_SOCKET_BUFFER* pBuffer, void* pvContext);

@DllImport("websocket")
HRESULT WebSocketGetAction(WEB_SOCKET_HANDLE__* hWebSocket, WEB_SOCKET_ACTION_QUEUE eActionQueue, 
                           char* pDataBuffers, uint* pulDataBufferCount, WEB_SOCKET_ACTION* pAction, 
                           WEB_SOCKET_BUFFER_TYPE* pBufferType, void** pvApplicationContext, void** pvActionContext);

@DllImport("websocket")
void WebSocketCompleteAction(WEB_SOCKET_HANDLE__* hWebSocket, void* pvActionContext, uint ulBytesTransferred);

@DllImport("websocket")
void WebSocketAbortHandle(WEB_SOCKET_HANDLE__* hWebSocket);

@DllImport("websocket")
void WebSocketDeleteHandle(WEB_SOCKET_HANDLE__* hWebSocket);

@DllImport("websocket")
HRESULT WebSocketGetGlobalProperty(WEB_SOCKET_PROPERTY_TYPE eType, char* pvValue, uint* ulSize);


