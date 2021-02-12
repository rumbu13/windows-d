module windows.websock;

public import windows.com;

extern(Windows):

struct WEB_SOCKET_HANDLE__
{
    int unused;
}

enum WEB_SOCKET_CLOSE_STATUS
{
    WEB_SOCKET_SUCCESS_CLOSE_STATUS = 1000,
    WEB_SOCKET_ENDPOINT_UNAVAILABLE_CLOSE_STATUS = 1001,
    WEB_SOCKET_PROTOCOL_ERROR_CLOSE_STATUS = 1002,
    WEB_SOCKET_INVALID_DATA_TYPE_CLOSE_STATUS = 1003,
    WEB_SOCKET_EMPTY_CLOSE_STATUS = 1005,
    WEB_SOCKET_ABORTED_CLOSE_STATUS = 1006,
    WEB_SOCKET_INVALID_PAYLOAD_CLOSE_STATUS = 1007,
    WEB_SOCKET_POLICY_VIOLATION_CLOSE_STATUS = 1008,
    WEB_SOCKET_MESSAGE_TOO_BIG_CLOSE_STATUS = 1009,
    WEB_SOCKET_UNSUPPORTED_EXTENSIONS_CLOSE_STATUS = 1010,
    WEB_SOCKET_SERVER_ERROR_CLOSE_STATUS = 1011,
    WEB_SOCKET_SECURE_HANDSHAKE_ERROR_CLOSE_STATUS = 1015,
}

enum WEB_SOCKET_PROPERTY_TYPE
{
    WEB_SOCKET_RECEIVE_BUFFER_SIZE_PROPERTY_TYPE = 0,
    WEB_SOCKET_SEND_BUFFER_SIZE_PROPERTY_TYPE = 1,
    WEB_SOCKET_DISABLE_MASKING_PROPERTY_TYPE = 2,
    WEB_SOCKET_ALLOCATED_BUFFER_PROPERTY_TYPE = 3,
    WEB_SOCKET_DISABLE_UTF8_VERIFICATION_PROPERTY_TYPE = 4,
    WEB_SOCKET_KEEPALIVE_INTERVAL_PROPERTY_TYPE = 5,
    WEB_SOCKET_SUPPORTED_VERSIONS_PROPERTY_TYPE = 6,
}

enum WEB_SOCKET_ACTION_QUEUE
{
    WEB_SOCKET_SEND_ACTION_QUEUE = 1,
    WEB_SOCKET_RECEIVE_ACTION_QUEUE = 2,
    WEB_SOCKET_ALL_ACTION_QUEUE = 3,
}

enum WEB_SOCKET_BUFFER_TYPE
{
    WEB_SOCKET_UTF8_MESSAGE_BUFFER_TYPE = -2147483648,
    WEB_SOCKET_UTF8_FRAGMENT_BUFFER_TYPE = -2147483647,
    WEB_SOCKET_BINARY_MESSAGE_BUFFER_TYPE = -2147483646,
    WEB_SOCKET_BINARY_FRAGMENT_BUFFER_TYPE = -2147483645,
    WEB_SOCKET_CLOSE_BUFFER_TYPE = -2147483644,
    WEB_SOCKET_PING_PONG_BUFFER_TYPE = -2147483643,
    WEB_SOCKET_UNSOLICITED_PONG_BUFFER_TYPE = -2147483642,
}

enum WEB_SOCKET_ACTION
{
    WEB_SOCKET_NO_ACTION = 0,
    WEB_SOCKET_SEND_TO_NETWORK_ACTION = 1,
    WEB_SOCKET_INDICATE_SEND_COMPLETE_ACTION = 2,
    WEB_SOCKET_RECEIVE_FROM_NETWORK_ACTION = 3,
    WEB_SOCKET_INDICATE_RECEIVE_COMPLETE_ACTION = 4,
}

struct WEB_SOCKET_PROPERTY
{
    WEB_SOCKET_PROPERTY_TYPE Type;
    void* pvValue;
    uint ulValueSize;
}

struct WEB_SOCKET_HTTP_HEADER
{
    const(char)* pcName;
    uint ulNameLength;
    const(char)* pcValue;
    uint ulValueLength;
}

struct WEB_SOCKET_BUFFER
{
    _Data_e__Struct Data;
    _CloseStatus_e__Struct CloseStatus;
}

@DllImport("websocket.dll")
HRESULT WebSocketCreateClientHandle(char* pProperties, uint ulPropertyCount, WEB_SOCKET_HANDLE__** phWebSocket);

@DllImport("websocket.dll")
HRESULT WebSocketBeginClientHandshake(WEB_SOCKET_HANDLE__* hWebSocket, char* pszSubprotocols, uint ulSubprotocolCount, char* pszExtensions, uint ulExtensionCount, char* pInitialHeaders, uint ulInitialHeaderCount, char* pAdditionalHeaders, uint* pulAdditionalHeaderCount);

@DllImport("websocket.dll")
HRESULT WebSocketEndClientHandshake(WEB_SOCKET_HANDLE__* hWebSocket, char* pResponseHeaders, uint ulReponseHeaderCount, char* pulSelectedExtensions, uint* pulSelectedExtensionCount, uint* pulSelectedSubprotocol);

@DllImport("websocket.dll")
HRESULT WebSocketCreateServerHandle(char* pProperties, uint ulPropertyCount, WEB_SOCKET_HANDLE__** phWebSocket);

@DllImport("websocket.dll")
HRESULT WebSocketBeginServerHandshake(WEB_SOCKET_HANDLE__* hWebSocket, const(char)* pszSubprotocolSelected, char* pszExtensionSelected, uint ulExtensionSelectedCount, char* pRequestHeaders, uint ulRequestHeaderCount, char* pResponseHeaders, uint* pulResponseHeaderCount);

@DllImport("websocket.dll")
HRESULT WebSocketEndServerHandshake(WEB_SOCKET_HANDLE__* hWebSocket);

@DllImport("websocket.dll")
HRESULT WebSocketSend(WEB_SOCKET_HANDLE__* hWebSocket, WEB_SOCKET_BUFFER_TYPE BufferType, WEB_SOCKET_BUFFER* pBuffer, void* Context);

@DllImport("websocket.dll")
HRESULT WebSocketReceive(WEB_SOCKET_HANDLE__* hWebSocket, WEB_SOCKET_BUFFER* pBuffer, void* pvContext);

@DllImport("websocket.dll")
HRESULT WebSocketGetAction(WEB_SOCKET_HANDLE__* hWebSocket, WEB_SOCKET_ACTION_QUEUE eActionQueue, char* pDataBuffers, uint* pulDataBufferCount, WEB_SOCKET_ACTION* pAction, WEB_SOCKET_BUFFER_TYPE* pBufferType, void** pvApplicationContext, void** pvActionContext);

@DllImport("websocket.dll")
void WebSocketCompleteAction(WEB_SOCKET_HANDLE__* hWebSocket, void* pvActionContext, uint ulBytesTransferred);

@DllImport("websocket.dll")
void WebSocketAbortHandle(WEB_SOCKET_HANDLE__* hWebSocket);

@DllImport("websocket.dll")
void WebSocketDeleteHandle(WEB_SOCKET_HANDLE__* hWebSocket);

@DllImport("websocket.dll")
HRESULT WebSocketGetGlobalProperty(WEB_SOCKET_PROPERTY_TYPE eType, char* pvValue, uint* ulSize);

