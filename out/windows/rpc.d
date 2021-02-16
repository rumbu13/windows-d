module windows.rpc;

public import windows.core;
public import windows.com : HRESULT, IRpcChannelBuffer, IRpcStubBuffer, IUnknown;
public import windows.kernel : LUID;
public import windows.security : CERT_CONTEXT, SEC_WINNT_AUTH_IDENTITY_A, SEC_WINNT_AUTH_IDENTITY_W;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER, OVERLAPPED;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME, SYSTEMTIME;

extern(Windows):


// Enums


enum : int
{
    RPCHTTP_RS_REDIRECT  = 0x00000001,
    RPCHTTP_RS_ACCESS_1  = 0x00000002,
    RPCHTTP_RS_SESSION   = 0x00000003,
    RPCHTTP_RS_ACCESS_2  = 0x00000004,
    RPCHTTP_RS_INTERFACE = 0x00000005,
}
alias RPC_HTTP_REDIRECTOR_STAGE = int;

enum : int
{
    PROTOCOL_NOT_LOADED     = 0x00000001,
    PROTOCOL_LOADED         = 0x00000002,
    PROTOCOL_ADDRESS_CHANGE = 0x00000003,
}
alias RPC_ADDRESS_CHANGE_TYPE = int;

enum : int
{
    MarshalDirectionMarshal   = 0x00000000,
    MarshalDirectionUnmarshal = 0x00000001,
}
alias LRPC_SYSTEM_HANDLE_MARSHAL_DIRECTION = int;

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

enum : int
{
    RpcNotificationTypeNone     = 0x00000000,
    RpcNotificationTypeEvent    = 0x00000001,
    RpcNotificationTypeApc      = 0x00000002,
    RpcNotificationTypeIoc      = 0x00000003,
    RpcNotificationTypeHwnd     = 0x00000004,
    RpcNotificationTypeCallback = 0x00000005,
}
alias RPC_NOTIFICATION_TYPES = int;

enum : int
{
    RpcCallComplete     = 0x00000000,
    RpcSendComplete     = 0x00000001,
    RpcReceiveComplete  = 0x00000002,
    RpcClientDisconnect = 0x00000003,
    RpcClientCancel     = 0x00000004,
}
alias RPC_ASYNC_EVENT = int;

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

enum RpcLocalAddressFormat : int
{
    rlafInvalid = 0x00000000,
    rlafIPv4    = 0x00000001,
    rlafIPv6    = 0x00000002,
}

enum RpcCallType : int
{
    rctInvalid    = 0x00000000,
    rctNormal     = 0x00000001,
    rctTraining   = 0x00000002,
    rctGuaranteed = 0x00000003,
}

enum RpcCallClientLocality : int
{
    rcclInvalid               = 0x00000000,
    rcclLocal                 = 0x00000001,
    rcclRemote                = 0x00000002,
    rcclClientUnknownLocality = 0x00000003,
}

enum : int
{
    RpcNotificationCallNone         = 0x00000000,
    RpcNotificationClientDisconnect = 0x00000001,
    RpcNotificationCallCancel       = 0x00000002,
}
alias RPC_NOTIFICATIONS = int;

enum : int
{
    USER_MARSHAL_CB_BUFFER_SIZE = 0x00000000,
    USER_MARSHAL_CB_MARSHALL    = 0x00000001,
    USER_MARSHAL_CB_UNMARSHALL  = 0x00000002,
    USER_MARSHAL_CB_FREE        = 0x00000003,
}
alias USER_MARSHAL_CB_TYPE = int;

enum : int
{
    IDL_CS_NO_CONVERT         = 0x00000000,
    IDL_CS_IN_PLACE_CONVERT   = 0x00000001,
    IDL_CS_NEW_BUFFER_CONVERT = 0x00000002,
}
alias IDL_CS_CONVERT = int;

enum : int
{
    XLAT_SERVER = 0x00000001,
    XLAT_CLIENT = 0x00000002,
}
alias XLAT_SIDE = int;

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
alias system_handle_t = int;

enum : int
{
    STUB_UNMARSHAL              = 0x00000000,
    STUB_CALL_SERVER            = 0x00000001,
    STUB_MARSHAL                = 0x00000002,
    STUB_CALL_SERVER_NO_HRESULT = 0x00000003,
}
alias STUB_PHASE = int;

enum : int
{
    PROXY_CALCSIZE    = 0x00000000,
    PROXY_GETBUFFER   = 0x00000001,
    PROXY_MARSHAL     = 0x00000002,
    PROXY_SENDRECEIVE = 0x00000003,
    PROXY_UNMARSHAL   = 0x00000004,
}
alias PROXY_PHASE = int;

enum : int
{
    MES_ENCODE       = 0x00000000,
    MES_DECODE       = 0x00000001,
    MES_ENCODE_NDR64 = 0x00000002,
}
alias MIDL_ES_CODE = int;

enum : int
{
    MES_INCREMENTAL_HANDLE    = 0x00000000,
    MES_FIXED_BUFFER_HANDLE   = 0x00000001,
    MES_DYNAMIC_BUFFER_HANDLE = 0x00000002,
}
alias MIDL_ES_HANDLE_STYLE = int;

// Constants


enum int MidlInterceptionInfoVersionOne = 0x00000001;

// Callbacks

alias RPC_OBJECT_INQ_FN = void function(GUID* ObjectUuid, GUID* TypeUuid, int* Status);
alias RPC_IF_CALLBACK_FN = int function(void* InterfaceUuid, void* Context);
alias RPC_SECURITY_CALLBACK_FN = void function(void* Context);
alias RPC_NEW_HTTP_PROXY_CHANNEL = int function(RPC_HTTP_REDIRECTOR_STAGE RedirectorStage, ushort* ServerName, 
                                                ushort* ServerPort, ushort* RemoteUser, ushort* AuthType, 
                                                void* ResourceUuid, void* SessionId, void* Interface, void* Reserved, 
                                                uint Flags, ushort** NewServerName, ushort** NewServerPort);
alias RPC_HTTP_PROXY_FREE_STRING = void function(ushort* String);
alias RPC_AUTH_KEY_RETRIEVAL_FN = void function(void* Arg, ushort* ServerPrincName, uint KeyVer, void** Key, 
                                                int* Status);
alias RPC_MGMT_AUTHORIZATION_FN = int function(void* ClientBinding, uint RequestedMgmtOperation, int* Status);
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

struct RPC_BINDING_VECTOR
{
    uint     Count;
    void[1]* BindingH;
}

struct UUID_VECTOR
{
    uint     Count;
    GUID[1]* Uuid;
}

struct RPC_IF_ID
{
    GUID   Uuid;
    ushort VersMajor;
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

struct RPC_POLICY
{
    uint Length;
    uint EndpointFlags;
    uint NICFlags;
}

struct RPC_STATS_VECTOR
{
    uint    Count;
    uint[1] Stats;
}

struct RPC_IF_ID_VECTOR
{
    uint          Count;
    RPC_IF_ID[1]* IfId;
}

struct RPC_SECURITY_QOS
{
    uint Version;
    uint Capabilities;
    uint IdentityTracking;
    uint ImpersonationType;
}

struct RPC_HTTP_TRANSPORT_CREDENTIALS_W
{
    SEC_WINNT_AUTH_IDENTITY_W* TransportCredentials;
    uint    Flags;
    uint    AuthenticationTarget;
    uint    NumberOfAuthnSchemes;
    uint*   AuthnSchemes;
    ushort* ServerCertificateSubject;
}

struct RPC_HTTP_TRANSPORT_CREDENTIALS_A
{
    SEC_WINNT_AUTH_IDENTITY_A* TransportCredentials;
    uint   Flags;
    uint   AuthenticationTarget;
    uint   NumberOfAuthnSchemes;
    uint*  AuthnSchemes;
    ubyte* ServerCertificateSubject;
}

struct RPC_HTTP_TRANSPORT_CREDENTIALS_V2_W
{
    SEC_WINNT_AUTH_IDENTITY_W* TransportCredentials;
    uint    Flags;
    uint    AuthenticationTarget;
    uint    NumberOfAuthnSchemes;
    uint*   AuthnSchemes;
    ushort* ServerCertificateSubject;
    SEC_WINNT_AUTH_IDENTITY_W* ProxyCredentials;
    uint    NumberOfProxyAuthnSchemes;
    uint*   ProxyAuthnSchemes;
}

struct RPC_HTTP_TRANSPORT_CREDENTIALS_V2_A
{
    SEC_WINNT_AUTH_IDENTITY_A* TransportCredentials;
    uint   Flags;
    uint   AuthenticationTarget;
    uint   NumberOfAuthnSchemes;
    uint*  AuthnSchemes;
    ubyte* ServerCertificateSubject;
    SEC_WINNT_AUTH_IDENTITY_A* ProxyCredentials;
    uint   NumberOfProxyAuthnSchemes;
    uint*  ProxyAuthnSchemes;
}

struct RPC_HTTP_TRANSPORT_CREDENTIALS_V3_W
{
    void*   TransportCredentials;
    uint    Flags;
    uint    AuthenticationTarget;
    uint    NumberOfAuthnSchemes;
    uint*   AuthnSchemes;
    ushort* ServerCertificateSubject;
    void*   ProxyCredentials;
    uint    NumberOfProxyAuthnSchemes;
    uint*   ProxyAuthnSchemes;
}

struct RPC_HTTP_TRANSPORT_CREDENTIALS_V3_A
{
    void*  TransportCredentials;
    uint   Flags;
    uint   AuthenticationTarget;
    uint   NumberOfAuthnSchemes;
    uint*  AuthnSchemes;
    ubyte* ServerCertificateSubject;
    void*  ProxyCredentials;
    uint   NumberOfProxyAuthnSchemes;
    uint*  ProxyAuthnSchemes;
}

struct RPC_SECURITY_QOS_V2_W
{
    uint Version;
    uint Capabilities;
    uint IdentityTracking;
    uint ImpersonationType;
    uint AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_W* HttpCredentials;
    }
}

struct RPC_SECURITY_QOS_V2_A
{
    uint Version;
    uint Capabilities;
    uint IdentityTracking;
    uint ImpersonationType;
    uint AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_A* HttpCredentials;
    }
}

struct RPC_SECURITY_QOS_V3_W
{
    uint  Version;
    uint  Capabilities;
    uint  IdentityTracking;
    uint  ImpersonationType;
    uint  AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_W* HttpCredentials;
    }
    void* Sid;
}

struct RPC_SECURITY_QOS_V3_A
{
    uint  Version;
    uint  Capabilities;
    uint  IdentityTracking;
    uint  ImpersonationType;
    uint  AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_A* HttpCredentials;
    }
    void* Sid;
}

struct RPC_SECURITY_QOS_V4_W
{
    uint  Version;
    uint  Capabilities;
    uint  IdentityTracking;
    uint  ImpersonationType;
    uint  AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_W* HttpCredentials;
    }
    void* Sid;
    uint  EffectiveOnly;
}

struct RPC_SECURITY_QOS_V4_A
{
    uint  Version;
    uint  Capabilities;
    uint  IdentityTracking;
    uint  ImpersonationType;
    uint  AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_A* HttpCredentials;
    }
    void* Sid;
    uint  EffectiveOnly;
}

struct RPC_SECURITY_QOS_V5_W
{
    uint  Version;
    uint  Capabilities;
    uint  IdentityTracking;
    uint  ImpersonationType;
    uint  AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_W* HttpCredentials;
    }
    void* Sid;
    uint  EffectiveOnly;
    void* ServerSecurityDescriptor;
}

struct RPC_SECURITY_QOS_V5_A
{
    uint  Version;
    uint  Capabilities;
    uint  IdentityTracking;
    uint  ImpersonationType;
    uint  AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_A* HttpCredentials;
    }
    void* Sid;
    uint  EffectiveOnly;
    void* ServerSecurityDescriptor;
}

struct RPC_BINDING_HANDLE_TEMPLATE_V1_W
{
    uint    Version;
    uint    Flags;
    uint    ProtocolSequence;
    ushort* NetworkAddress;
    ushort* StringEndpoint;
    union u1
    {
        ushort* Reserved;
    }
    GUID    ObjectUuid;
}

struct RPC_BINDING_HANDLE_TEMPLATE_V1_A
{
    uint   Version;
    uint   Flags;
    uint   ProtocolSequence;
    ubyte* NetworkAddress;
    ubyte* StringEndpoint;
    union u1
    {
        ubyte* Reserved;
    }
    GUID   ObjectUuid;
}

struct RPC_BINDING_HANDLE_SECURITY_V1_W
{
    uint              Version;
    ushort*           ServerPrincName;
    uint              AuthnLevel;
    uint              AuthnSvc;
    SEC_WINNT_AUTH_IDENTITY_W* AuthIdentity;
    RPC_SECURITY_QOS* SecurityQos;
}

struct RPC_BINDING_HANDLE_SECURITY_V1_A
{
    uint              Version;
    ubyte*            ServerPrincName;
    uint              AuthnLevel;
    uint              AuthnSvc;
    SEC_WINNT_AUTH_IDENTITY_A* AuthIdentity;
    RPC_SECURITY_QOS* SecurityQos;
}

struct RPC_BINDING_HANDLE_OPTIONS_V1
{
    uint Version;
    uint Flags;
    uint ComTimeout;
    uint CallTimeout;
}

struct RPC_CLIENT_INFORMATION1
{
    ubyte* UserName;
    ubyte* ComputerName;
    ushort Privilege;
    uint   AuthFlags;
}

struct RPC_ENDPOINT_TEMPLATEW
{
    uint    Version;
    ushort* ProtSeq;
    ushort* Endpoint;
    void*   SecurityDescriptor;
    uint    Backlog;
}

struct RPC_ENDPOINT_TEMPLATEA
{
    uint   Version;
    ubyte* ProtSeq;
    ubyte* Endpoint;
    void*  SecurityDescriptor;
    uint   Backlog;
}

struct RPC_INTERFACE_TEMPLATEA
{
    uint                Version;
    void*               IfSpec;
    GUID*               MgrTypeUuid;
    void*               MgrEpv;
    uint                Flags;
    uint                MaxCalls;
    uint                MaxRpcSize;
    RPC_IF_CALLBACK_FN* IfCallback;
    UUID_VECTOR*        UuidVector;
    ubyte*              Annotation;
    void*               SecurityDescriptor;
}

struct RPC_INTERFACE_TEMPLATEW
{
    uint                Version;
    void*               IfSpec;
    GUID*               MgrTypeUuid;
    void*               MgrEpv;
    uint                Flags;
    uint                MaxCalls;
    uint                MaxRpcSize;
    RPC_IF_CALLBACK_FN* IfCallback;
    UUID_VECTOR*        UuidVector;
    ushort*             Annotation;
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

struct RPC_MESSAGE
{
    void* Handle;
    uint  DataRepresentation;
    void* Buffer;
    uint  BufferLength;
    uint  ProcNum;
    RPC_SYNTAX_IDENTIFIER* TransferSyntax;
    void* RpcInterfaceInformation;
    void* ReservedForRuntime;
    void* ManagerEpv;
    void* ImportContext;
    uint  RpcFlags;
}

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

struct RPC_C_OPT_COOKIE_AUTH_DESCRIPTOR
{
    uint  BufferSize;
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
    HANDLE hEvent;
    PFN_RPCNOTIFICATION_ROUTINE NotificationRoutine;
}

struct RPC_ASYNC_STATE
{
    uint            Size;
    uint            Signature;
    int             Lock;
    uint            Flags;
    void*           StubInfo;
    void*           UserInfo;
    void*           RuntimeInfo;
    RPC_ASYNC_EVENT Event;
    RPC_NOTIFICATION_TYPES NotificationType;
    RPC_ASYNC_NOTIFICATION_INFO u;
    ptrdiff_t[4]    Reserved;
}

struct BinaryParam
{
    void* Buffer;
    short Size;
}

struct RPC_EE_INFO_PARAM
{
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

struct RPC_EXTENDED_ERROR_INFO
{
    uint                 Version;
    const(wchar)*        ComputerName;
    uint                 ProcessID;
    union u
    {
        SYSTEMTIME SystemTime;
        FILETIME   FileTime;
    }
    uint                 GeneratingComponent;
    uint                 Status;
    ushort               DetectionLocation;
    ushort               Flags;
    int                  NumberOfParameters;
    RPC_EE_INFO_PARAM[4] Parameters;
}

struct RPC_ERROR_ENUM_HANDLE
{
    uint  Signature;
    void* CurrentPos;
    void* Head;
}

struct RPC_CALL_LOCAL_ADDRESS_V1
{
    uint  Version;
    void* Buffer;
    uint  BufferSize;
    RpcLocalAddressFormat AddressFormat;
}

struct RPC_CALL_ATTRIBUTES_V1_W
{
    uint    Version;
    uint    Flags;
    uint    ServerPrincipalNameBufferLength;
    ushort* ServerPrincipalName;
    uint    ClientPrincipalNameBufferLength;
    ushort* ClientPrincipalName;
    uint    AuthenticationLevel;
    uint    AuthenticationService;
    BOOL    NullSession;
}

struct RPC_CALL_ATTRIBUTES_V1_A
{
    uint   Version;
    uint   Flags;
    uint   ServerPrincipalNameBufferLength;
    ubyte* ServerPrincipalName;
    uint   ClientPrincipalNameBufferLength;
    ubyte* ClientPrincipalName;
    uint   AuthenticationLevel;
    uint   AuthenticationService;
    BOOL   NullSession;
}

struct RPC_CALL_ATTRIBUTES_V2_W
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
}

struct RPC_CALL_ATTRIBUTES_V2_A
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

struct MIDL_STUB_MESSAGE
{
    RPC_MESSAGE*        RpcMsg;
    ubyte*              Buffer;
    ubyte*              BufferStart;
    ubyte*              BufferEnd;
    ubyte*              BufferMark;
    uint                BufferLength;
    uint                MemorySize;
    ubyte*              Memory;
    ubyte               IsClient;
    ubyte               Pad;
    ushort              uFlags2;
    int                 ReuseBuffer;
    NDR_ALLOC_ALL_NODES_CONTEXT* pAllocAllNodesContext;
    NDR_POINTER_QUEUE_STATE* pPointerQueueState;
    int                 IgnoreEmbeddedPointers;
    ubyte*              PointerBufferMark;
    ubyte               CorrDespIncrement;
    ubyte               uFlags;
    ushort              UniquePtrCount;
    size_t              MaxCount;
    uint                Offset;
    uint                ActualCount;
    ptrdiff_t           pfnAllocate;
    ptrdiff_t           pfnFree;
    ubyte*              StackTop;
    ubyte*              pPresentedType;
    ubyte*              pTransmitType;
    void*               SavedHandle;
    const(MIDL_STUB_DESC)* StubDesc;
    FULL_PTR_XLAT_TABLES* FullPtrXlatTables;
    uint                FullPtrRefId;
    uint                PointerLength;
    int                 _bitfield98;
    uint                dwDestContext;
    void*               pvDestContext;
    NDR_SCONTEXT_1**    SavedContextHandles;
    int                 ParamNumber;
    IRpcChannelBuffer   pRpcChannelBuffer;
    ARRAY_INFO*         pArrayInfo;
    uint*               SizePtrCountArray;
    uint*               SizePtrOffsetArray;
    uint*               SizePtrLengthArray;
    void*               pArgQueue;
    uint                dwStubPhase;
    void*               LowStackMark;
    _NDR_ASYNC_MESSAGE* pAsyncMsg;
    _NDR_CORRELATION_INFO* pCorrInfo;
    ubyte*              pCorrMemory;
    void*               pMemoryList;
    ptrdiff_t           pCSInfo;
    ubyte*              ConformanceMark;
    ubyte*              VarianceMark;
    ptrdiff_t           Unused;
    _NDR_PROC_CONTEXT*  pContext;
    void*               ContextHandleHash;
    void*               pUserMarshalList;
    ptrdiff_t           Reserved51_3;
    ptrdiff_t           Reserved51_4;
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

struct MIDL_STUB_DESC
{
    void*               RpcInterfaceInformation;
    ptrdiff_t           pfnAllocate;
    ptrdiff_t           pfnFree;
    union IMPLICIT_HANDLE_INFO
    {
        void** pAutoHandle;
        void** pPrimitiveHandle;
        __GENERIC_BINDING_INFO* pGenericBindingInfo;
    }
    const(ptrdiff_t)*   apfnNdrRundownRoutines;
    const(GENERIC_BINDING_ROUTINE_PAIR)* aGenericBindingRoutinePairs;
    const(ptrdiff_t)*   apfnExprEval;
    const(XMIT_ROUTINE_QUINTUPLE)* aXmitQuintuple;
    const(ubyte)*       pFormatTypes;
    int                 fCheckBounds;
    uint                Version;
    MALLOC_FREE_STRUCT* pMallocFreeStruct;
    int                 MIDLVersion;
    const(COMM_FAULT_OFFSETS)* CommFaultOffsets;
    const(USER_MARSHAL_ROUTINE_QUADRUPLE)* aUserMarshalQuadruple;
    const(ptrdiff_t)*   NotifyRoutineTable;
    size_t              mFlags;
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

struct NDR_USER_MARSHAL_INFO_LEVEL1
{
    void*             Buffer;
    uint              BufferSize;
    ptrdiff_t         pfnAllocate;
    ptrdiff_t         pfnFree;
    IRpcChannelBuffer pRpcChannelBuffer;
    size_t[5]         Reserved;
}

struct NDR_USER_MARSHAL_INFO
{
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

@DllImport("RPCRT4")
HRESULT IUnknown_QueryInterface_Proxy(IUnknown This, const(GUID)* riid, void** ppvObject);

@DllImport("RPCRT4")
uint IUnknown_AddRef_Proxy(IUnknown This);

@DllImport("RPCRT4")
uint IUnknown_Release_Proxy(IUnknown This);

@DllImport("RPCRT4")
int RpcBindingCopy(void* SourceBinding, void** DestinationBinding);

@DllImport("RPCRT4")
int RpcBindingFree(void** Binding);

@DllImport("RPCRT4")
int RpcBindingSetOption(void* hBinding, uint option, size_t optionValue);

@DllImport("RPCRT4")
int RpcBindingInqOption(void* hBinding, uint option, size_t* pOptionValue);

@DllImport("RPCRT4")
int RpcBindingFromStringBindingA(ubyte* StringBinding, void** Binding);

@DllImport("RPCRT4")
int RpcBindingFromStringBindingW(ushort* StringBinding, void** Binding);

@DllImport("RPCRT4")
int RpcSsGetContextBinding(void* ContextHandle, void** Binding);

@DllImport("RPCRT4")
int RpcBindingInqObject(void* Binding, GUID* ObjectUuid);

@DllImport("RPCRT4")
int RpcBindingReset(void* Binding);

@DllImport("RPCRT4")
int RpcBindingSetObject(void* Binding, GUID* ObjectUuid);

@DllImport("RPCRT4")
int RpcMgmtInqDefaultProtectLevel(uint AuthnSvc, uint* AuthnLevel);

@DllImport("RPCRT4")
int RpcBindingToStringBindingA(void* Binding, ubyte** StringBinding);

@DllImport("RPCRT4")
int RpcBindingToStringBindingW(void* Binding, ushort** StringBinding);

@DllImport("RPCRT4")
int RpcBindingVectorFree(RPC_BINDING_VECTOR** BindingVector);

@DllImport("RPCRT4")
int RpcStringBindingComposeA(ubyte* ObjUuid, ubyte* ProtSeq, ubyte* NetworkAddr, ubyte* Endpoint, ubyte* Options, 
                             ubyte** StringBinding);

@DllImport("RPCRT4")
int RpcStringBindingComposeW(ushort* ObjUuid, ushort* ProtSeq, ushort* NetworkAddr, ushort* Endpoint, 
                             ushort* Options, ushort** StringBinding);

@DllImport("RPCRT4")
int RpcStringBindingParseA(ubyte* StringBinding, ubyte** ObjUuid, ubyte** Protseq, ubyte** NetworkAddr, 
                           ubyte** Endpoint, ubyte** NetworkOptions);

@DllImport("RPCRT4")
int RpcStringBindingParseW(ushort* StringBinding, ushort** ObjUuid, ushort** Protseq, ushort** NetworkAddr, 
                           ushort** Endpoint, ushort** NetworkOptions);

@DllImport("RPCRT4")
int RpcStringFreeA(ubyte** String);

@DllImport("RPCRT4")
int RpcStringFreeW(ushort** String);

@DllImport("RPCRT4")
int RpcIfInqId(void* RpcIfHandle, RPC_IF_ID* RpcIfId);

@DllImport("RPCRT4")
int RpcNetworkIsProtseqValidA(ubyte* Protseq);

@DllImport("RPCRT4")
int RpcNetworkIsProtseqValidW(ushort* Protseq);

@DllImport("RPCRT4")
int RpcMgmtInqComTimeout(void* Binding, uint* Timeout);

@DllImport("RPCRT4")
int RpcMgmtSetComTimeout(void* Binding, uint Timeout);

@DllImport("RPCRT4")
int RpcMgmtSetCancelTimeout(int Timeout);

@DllImport("RPCRT4")
int RpcNetworkInqProtseqsA(RPC_PROTSEQ_VECTORA** ProtseqVector);

@DllImport("RPCRT4")
int RpcNetworkInqProtseqsW(RPC_PROTSEQ_VECTORW** ProtseqVector);

@DllImport("RPCRT4")
int RpcObjectInqType(GUID* ObjUuid, GUID* TypeUuid);

@DllImport("RPCRT4")
int RpcObjectSetInqFn(RPC_OBJECT_INQ_FN* InquiryFn);

@DllImport("RPCRT4")
int RpcObjectSetType(GUID* ObjUuid, GUID* TypeUuid);

@DllImport("RPCRT4")
int RpcProtseqVectorFreeA(RPC_PROTSEQ_VECTORA** ProtseqVector);

@DllImport("RPCRT4")
int RpcProtseqVectorFreeW(RPC_PROTSEQ_VECTORW** ProtseqVector);

@DllImport("RPCRT4")
int RpcServerInqBindings(RPC_BINDING_VECTOR** BindingVector);

@DllImport("RPCRT4")
int RpcServerInqBindingsEx(void* SecurityDescriptor, RPC_BINDING_VECTOR** BindingVector);

@DllImport("RPCRT4")
int RpcServerInqIf(void* IfSpec, GUID* MgrTypeUuid, void** MgrEpv);

@DllImport("RPCRT4")
int RpcServerListen(uint MinimumCallThreads, uint MaxCalls, uint DontWait);

@DllImport("RPCRT4")
int RpcServerRegisterIf(void* IfSpec, GUID* MgrTypeUuid, void* MgrEpv);

@DllImport("RPCRT4")
int RpcServerRegisterIfEx(void* IfSpec, GUID* MgrTypeUuid, void* MgrEpv, uint Flags, uint MaxCalls, 
                          RPC_IF_CALLBACK_FN* IfCallback);

@DllImport("RPCRT4")
int RpcServerRegisterIf2(void* IfSpec, GUID* MgrTypeUuid, void* MgrEpv, uint Flags, uint MaxCalls, uint MaxRpcSize, 
                         RPC_IF_CALLBACK_FN* IfCallbackFn);

@DllImport("RPCRT4")
int RpcServerRegisterIf3(void* IfSpec, GUID* MgrTypeUuid, void* MgrEpv, uint Flags, uint MaxCalls, uint MaxRpcSize, 
                         RPC_IF_CALLBACK_FN* IfCallback, void* SecurityDescriptor);

@DllImport("RPCRT4")
int RpcServerUnregisterIf(void* IfSpec, GUID* MgrTypeUuid, uint WaitForCallsToComplete);

@DllImport("RPCRT4")
int RpcServerUnregisterIfEx(void* IfSpec, GUID* MgrTypeUuid, int RundownContextHandles);

@DllImport("RPCRT4")
int RpcServerUseAllProtseqs(uint MaxCalls, void* SecurityDescriptor);

@DllImport("RPCRT4")
int RpcServerUseAllProtseqsEx(uint MaxCalls, void* SecurityDescriptor, RPC_POLICY* Policy);

@DllImport("RPCRT4")
int RpcServerUseAllProtseqsIf(uint MaxCalls, void* IfSpec, void* SecurityDescriptor);

@DllImport("RPCRT4")
int RpcServerUseAllProtseqsIfEx(uint MaxCalls, void* IfSpec, void* SecurityDescriptor, RPC_POLICY* Policy);

@DllImport("RPCRT4")
int RpcServerUseProtseqA(ubyte* Protseq, uint MaxCalls, void* SecurityDescriptor);

@DllImport("RPCRT4")
int RpcServerUseProtseqExA(ubyte* Protseq, uint MaxCalls, void* SecurityDescriptor, RPC_POLICY* Policy);

@DllImport("RPCRT4")
int RpcServerUseProtseqW(ushort* Protseq, uint MaxCalls, void* SecurityDescriptor);

@DllImport("RPCRT4")
int RpcServerUseProtseqExW(ushort* Protseq, uint MaxCalls, void* SecurityDescriptor, RPC_POLICY* Policy);

@DllImport("RPCRT4")
int RpcServerUseProtseqEpA(ubyte* Protseq, uint MaxCalls, ubyte* Endpoint, void* SecurityDescriptor);

@DllImport("RPCRT4")
int RpcServerUseProtseqEpExA(ubyte* Protseq, uint MaxCalls, ubyte* Endpoint, void* SecurityDescriptor, 
                             RPC_POLICY* Policy);

@DllImport("RPCRT4")
int RpcServerUseProtseqEpW(ushort* Protseq, uint MaxCalls, ushort* Endpoint, void* SecurityDescriptor);

@DllImport("RPCRT4")
int RpcServerUseProtseqEpExW(ushort* Protseq, uint MaxCalls, ushort* Endpoint, void* SecurityDescriptor, 
                             RPC_POLICY* Policy);

@DllImport("RPCRT4")
int RpcServerUseProtseqIfA(ubyte* Protseq, uint MaxCalls, void* IfSpec, void* SecurityDescriptor);

@DllImport("RPCRT4")
int RpcServerUseProtseqIfExA(ubyte* Protseq, uint MaxCalls, void* IfSpec, void* SecurityDescriptor, 
                             RPC_POLICY* Policy);

@DllImport("RPCRT4")
int RpcServerUseProtseqIfW(ushort* Protseq, uint MaxCalls, void* IfSpec, void* SecurityDescriptor);

@DllImport("RPCRT4")
int RpcServerUseProtseqIfExW(ushort* Protseq, uint MaxCalls, void* IfSpec, void* SecurityDescriptor, 
                             RPC_POLICY* Policy);

@DllImport("RPCRT4")
void RpcServerYield();

@DllImport("RPCRT4")
int RpcMgmtStatsVectorFree(RPC_STATS_VECTOR** StatsVector);

@DllImport("RPCRT4")
int RpcMgmtInqStats(void* Binding, RPC_STATS_VECTOR** Statistics);

@DllImport("RPCRT4")
int RpcMgmtIsServerListening(void* Binding);

@DllImport("RPCRT4")
int RpcMgmtStopServerListening(void* Binding);

@DllImport("RPCRT4")
int RpcMgmtWaitServerListen();

@DllImport("RPCRT4")
int RpcMgmtSetServerStackSize(uint ThreadStackSize);

@DllImport("RPCRT4")
void RpcSsDontSerializeContext();

@DllImport("RPCRT4")
int RpcMgmtEnableIdleCleanup();

@DllImport("RPCRT4")
int RpcMgmtInqIfIds(void* Binding, RPC_IF_ID_VECTOR** IfIdVector);

@DllImport("RPCRT4")
int RpcIfIdVectorFree(RPC_IF_ID_VECTOR** IfIdVector);

@DllImport("RPCRT4")
int RpcMgmtInqServerPrincNameA(void* Binding, uint AuthnSvc, ubyte** ServerPrincName);

@DllImport("RPCRT4")
int RpcMgmtInqServerPrincNameW(void* Binding, uint AuthnSvc, ushort** ServerPrincName);

@DllImport("RPCRT4")
int RpcServerInqDefaultPrincNameA(uint AuthnSvc, ubyte** PrincName);

@DllImport("RPCRT4")
int RpcServerInqDefaultPrincNameW(uint AuthnSvc, ushort** PrincName);

@DllImport("RPCRT4")
int RpcEpResolveBinding(void* Binding, void* IfSpec);

@DllImport("RPCRT4")
int RpcNsBindingInqEntryNameA(void* Binding, uint EntryNameSyntax, ubyte** EntryName);

@DllImport("RPCRT4")
int RpcNsBindingInqEntryNameW(void* Binding, uint EntryNameSyntax, ushort** EntryName);

@DllImport("RPCRT4")
int RpcBindingCreateA(RPC_BINDING_HANDLE_TEMPLATE_V1_A* Template, RPC_BINDING_HANDLE_SECURITY_V1_A* Security, 
                      RPC_BINDING_HANDLE_OPTIONS_V1* Options, void** Binding);

@DllImport("RPCRT4")
int RpcBindingCreateW(RPC_BINDING_HANDLE_TEMPLATE_V1_W* Template, RPC_BINDING_HANDLE_SECURITY_V1_W* Security, 
                      RPC_BINDING_HANDLE_OPTIONS_V1* Options, void** Binding);

@DllImport("RPCRT4")
int RpcServerInqBindingHandle(void** Binding);

@DllImport("RPCRT4")
int RpcImpersonateClient(void* BindingHandle);

@DllImport("RPCRT4")
int RpcImpersonateClient2(void* BindingHandle);

@DllImport("RPCRT4")
int RpcRevertToSelfEx(void* BindingHandle);

@DllImport("RPCRT4")
int RpcRevertToSelf();

@DllImport("RPCRT4")
int RpcImpersonateClientContainer(void* BindingHandle);

@DllImport("RPCRT4")
int RpcRevertContainerImpersonation();

@DllImport("RPCRT4")
int RpcBindingInqAuthClientA(void* ClientBinding, void** Privs, ubyte** ServerPrincName, uint* AuthnLevel, 
                             uint* AuthnSvc, uint* AuthzSvc);

@DllImport("RPCRT4")
int RpcBindingInqAuthClientW(void* ClientBinding, void** Privs, ushort** ServerPrincName, uint* AuthnLevel, 
                             uint* AuthnSvc, uint* AuthzSvc);

@DllImport("RPCRT4")
int RpcBindingInqAuthClientExA(void* ClientBinding, void** Privs, ubyte** ServerPrincName, uint* AuthnLevel, 
                               uint* AuthnSvc, uint* AuthzSvc, uint Flags);

@DllImport("RPCRT4")
int RpcBindingInqAuthClientExW(void* ClientBinding, void** Privs, ushort** ServerPrincName, uint* AuthnLevel, 
                               uint* AuthnSvc, uint* AuthzSvc, uint Flags);

@DllImport("RPCRT4")
int RpcBindingInqAuthInfoA(void* Binding, ubyte** ServerPrincName, uint* AuthnLevel, uint* AuthnSvc, 
                           void** AuthIdentity, uint* AuthzSvc);

@DllImport("RPCRT4")
int RpcBindingInqAuthInfoW(void* Binding, ushort** ServerPrincName, uint* AuthnLevel, uint* AuthnSvc, 
                           void** AuthIdentity, uint* AuthzSvc);

@DllImport("RPCRT4")
int RpcBindingSetAuthInfoA(void* Binding, ubyte* ServerPrincName, uint AuthnLevel, uint AuthnSvc, 
                           void* AuthIdentity, uint AuthzSvc);

@DllImport("RPCRT4")
int RpcBindingSetAuthInfoExA(void* Binding, ubyte* ServerPrincName, uint AuthnLevel, uint AuthnSvc, 
                             void* AuthIdentity, uint AuthzSvc, RPC_SECURITY_QOS* SecurityQos);

@DllImport("RPCRT4")
int RpcBindingSetAuthInfoW(void* Binding, ushort* ServerPrincName, uint AuthnLevel, uint AuthnSvc, 
                           void* AuthIdentity, uint AuthzSvc);

@DllImport("RPCRT4")
int RpcBindingSetAuthInfoExW(void* Binding, ushort* ServerPrincName, uint AuthnLevel, uint AuthnSvc, 
                             void* AuthIdentity, uint AuthzSvc, RPC_SECURITY_QOS* SecurityQOS);

@DllImport("RPCRT4")
int RpcBindingInqAuthInfoExA(void* Binding, ubyte** ServerPrincName, uint* AuthnLevel, uint* AuthnSvc, 
                             void** AuthIdentity, uint* AuthzSvc, uint RpcQosVersion, RPC_SECURITY_QOS* SecurityQOS);

@DllImport("RPCRT4")
int RpcBindingInqAuthInfoExW(void* Binding, ushort** ServerPrincName, uint* AuthnLevel, uint* AuthnSvc, 
                             void** AuthIdentity, uint* AuthzSvc, uint RpcQosVersion, RPC_SECURITY_QOS* SecurityQOS);

@DllImport("RPCRT4")
int RpcServerCompleteSecurityCallback(void* BindingHandle, int Status);

@DllImport("RPCRT4")
int RpcServerRegisterAuthInfoA(ubyte* ServerPrincName, uint AuthnSvc, RPC_AUTH_KEY_RETRIEVAL_FN GetKeyFn, 
                               void* Arg);

@DllImport("RPCRT4")
int RpcServerRegisterAuthInfoW(ushort* ServerPrincName, uint AuthnSvc, RPC_AUTH_KEY_RETRIEVAL_FN GetKeyFn, 
                               void* Arg);

@DllImport("RPCRT4")
int RpcBindingServerFromClient(void* ClientBinding, void** ServerBinding);

@DllImport("RPCRT4")
void RpcRaiseException(int exception);

@DllImport("RPCRT4")
int RpcTestCancel();

@DllImport("RPCRT4")
int RpcServerTestCancel(void* BindingHandle);

@DllImport("RPCRT4")
int RpcCancelThread(void* Thread);

@DllImport("RPCRT4")
int RpcCancelThreadEx(void* Thread, int Timeout);

@DllImport("RPCRT4")
int UuidCreate(GUID* Uuid);

@DllImport("RPCRT4")
int UuidCreateSequential(GUID* Uuid);

@DllImport("RPCRT4")
int UuidToStringA(const(GUID)* Uuid, ubyte** StringUuid);

@DllImport("RPCRT4")
int UuidFromStringA(ubyte* StringUuid, GUID* Uuid);

@DllImport("RPCRT4")
int UuidToStringW(const(GUID)* Uuid, ushort** StringUuid);

@DllImport("RPCRT4")
int UuidFromStringW(ushort* StringUuid, GUID* Uuid);

@DllImport("RPCRT4")
int UuidCompare(GUID* Uuid1, GUID* Uuid2, int* Status);

@DllImport("RPCRT4")
int UuidCreateNil(GUID* NilUuid);

@DllImport("RPCRT4")
int UuidEqual(GUID* Uuid1, GUID* Uuid2, int* Status);

@DllImport("RPCRT4")
ushort UuidHash(GUID* Uuid, int* Status);

@DllImport("RPCRT4")
int UuidIsNil(GUID* Uuid, int* Status);

@DllImport("RPCRT4")
int RpcEpRegisterNoReplaceA(void* IfSpec, RPC_BINDING_VECTOR* BindingVector, UUID_VECTOR* UuidVector, 
                            ubyte* Annotation);

@DllImport("RPCRT4")
int RpcEpRegisterNoReplaceW(void* IfSpec, RPC_BINDING_VECTOR* BindingVector, UUID_VECTOR* UuidVector, 
                            ushort* Annotation);

@DllImport("RPCRT4")
int RpcEpRegisterA(void* IfSpec, RPC_BINDING_VECTOR* BindingVector, UUID_VECTOR* UuidVector, ubyte* Annotation);

@DllImport("RPCRT4")
int RpcEpRegisterW(void* IfSpec, RPC_BINDING_VECTOR* BindingVector, UUID_VECTOR* UuidVector, ushort* Annotation);

@DllImport("RPCRT4")
int RpcEpUnregister(void* IfSpec, RPC_BINDING_VECTOR* BindingVector, UUID_VECTOR* UuidVector);

@DllImport("RPCRT4")
int DceErrorInqTextA(int RpcStatus, char* ErrorText);

@DllImport("RPCRT4")
int DceErrorInqTextW(int RpcStatus, char* ErrorText);

@DllImport("RPCRT4")
int RpcMgmtEpEltInqBegin(void* EpBinding, uint InquiryType, RPC_IF_ID* IfId, uint VersOption, GUID* ObjectUuid, 
                         void*** InquiryContext);

@DllImport("RPCRT4")
int RpcMgmtEpEltInqDone(void*** InquiryContext);

@DllImport("RPCRT4")
int RpcMgmtEpEltInqNextA(void** InquiryContext, RPC_IF_ID* IfId, void** Binding, GUID* ObjectUuid, 
                         ubyte** Annotation);

@DllImport("RPCRT4")
int RpcMgmtEpEltInqNextW(void** InquiryContext, RPC_IF_ID* IfId, void** Binding, GUID* ObjectUuid, 
                         ushort** Annotation);

@DllImport("RPCRT4")
int RpcMgmtEpUnregister(void* EpBinding, RPC_IF_ID* IfId, void* Binding, GUID* ObjectUuid);

@DllImport("RPCRT4")
int RpcMgmtSetAuthorizationFn(RPC_MGMT_AUTHORIZATION_FN AuthorizationFn);

@DllImport("RPCRT4")
int RpcExceptionFilter(uint ExceptionCode);

@DllImport("RPCRT4")
int RpcServerInterfaceGroupCreateW(char* Interfaces, uint NumIfs, char* Endpoints, uint NumEndpoints, 
                                   uint IdlePeriod, RPC_INTERFACE_GROUP_IDLE_CALLBACK_FN IdleCallbackFn, 
                                   void* IdleCallbackContext, void** IfGroup);

@DllImport("RPCRT4")
int RpcServerInterfaceGroupCreateA(char* Interfaces, uint NumIfs, char* Endpoints, uint NumEndpoints, 
                                   uint IdlePeriod, RPC_INTERFACE_GROUP_IDLE_CALLBACK_FN IdleCallbackFn, 
                                   void* IdleCallbackContext, void** IfGroup);

@DllImport("RPCRT4")
int RpcServerInterfaceGroupClose(void* IfGroup);

@DllImport("RPCRT4")
int RpcServerInterfaceGroupActivate(void* IfGroup);

@DllImport("RPCRT4")
int RpcServerInterfaceGroupDeactivate(void* IfGroup, uint ForceDeactivation);

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

@DllImport("RPCNS4")
int RpcNsBindingExportA(uint EntryNameSyntax, ubyte* EntryName, void* IfSpec, RPC_BINDING_VECTOR* BindingVec, 
                        UUID_VECTOR* ObjectUuidVec);

@DllImport("RPCNS4")
int RpcNsBindingUnexportA(uint EntryNameSyntax, ubyte* EntryName, void* IfSpec, UUID_VECTOR* ObjectUuidVec);

@DllImport("RPCNS4")
int RpcNsBindingExportW(uint EntryNameSyntax, ushort* EntryName, void* IfSpec, RPC_BINDING_VECTOR* BindingVec, 
                        UUID_VECTOR* ObjectUuidVec);

@DllImport("RPCNS4")
int RpcNsBindingUnexportW(uint EntryNameSyntax, ushort* EntryName, void* IfSpec, UUID_VECTOR* ObjectUuidVec);

@DllImport("RPCNS4")
int RpcNsBindingExportPnPA(uint EntryNameSyntax, ubyte* EntryName, void* IfSpec, UUID_VECTOR* ObjectVector);

@DllImport("RPCNS4")
int RpcNsBindingUnexportPnPA(uint EntryNameSyntax, ubyte* EntryName, void* IfSpec, UUID_VECTOR* ObjectVector);

@DllImport("RPCNS4")
int RpcNsBindingExportPnPW(uint EntryNameSyntax, ushort* EntryName, void* IfSpec, UUID_VECTOR* ObjectVector);

@DllImport("RPCNS4")
int RpcNsBindingUnexportPnPW(uint EntryNameSyntax, ushort* EntryName, void* IfSpec, UUID_VECTOR* ObjectVector);

@DllImport("RPCNS4")
int RpcNsBindingLookupBeginA(uint EntryNameSyntax, ubyte* EntryName, void* IfSpec, GUID* ObjUuid, 
                             uint BindingMaxCount, void** LookupContext);

@DllImport("RPCNS4")
int RpcNsBindingLookupBeginW(uint EntryNameSyntax, ushort* EntryName, void* IfSpec, GUID* ObjUuid, 
                             uint BindingMaxCount, void** LookupContext);

@DllImport("RPCNS4")
int RpcNsBindingLookupNext(void* LookupContext, RPC_BINDING_VECTOR** BindingVec);

@DllImport("RPCNS4")
int RpcNsBindingLookupDone(void** LookupContext);

@DllImport("RPCNS4")
int RpcNsGroupDeleteA(uint GroupNameSyntax, ubyte* GroupName);

@DllImport("RPCNS4")
int RpcNsGroupMbrAddA(uint GroupNameSyntax, ubyte* GroupName, uint MemberNameSyntax, ubyte* MemberName);

@DllImport("RPCNS4")
int RpcNsGroupMbrRemoveA(uint GroupNameSyntax, ubyte* GroupName, uint MemberNameSyntax, ubyte* MemberName);

@DllImport("RPCNS4")
int RpcNsGroupMbrInqBeginA(uint GroupNameSyntax, ubyte* GroupName, uint MemberNameSyntax, void** InquiryContext);

@DllImport("RPCNS4")
int RpcNsGroupMbrInqNextA(void* InquiryContext, ubyte** MemberName);

@DllImport("RPCNS4")
int RpcNsGroupDeleteW(uint GroupNameSyntax, ushort* GroupName);

@DllImport("RPCNS4")
int RpcNsGroupMbrAddW(uint GroupNameSyntax, ushort* GroupName, uint MemberNameSyntax, ushort* MemberName);

@DllImport("RPCNS4")
int RpcNsGroupMbrRemoveW(uint GroupNameSyntax, ushort* GroupName, uint MemberNameSyntax, ushort* MemberName);

@DllImport("RPCNS4")
int RpcNsGroupMbrInqBeginW(uint GroupNameSyntax, ushort* GroupName, uint MemberNameSyntax, void** InquiryContext);

@DllImport("RPCNS4")
int RpcNsGroupMbrInqNextW(void* InquiryContext, ushort** MemberName);

@DllImport("RPCNS4")
int RpcNsGroupMbrInqDone(void** InquiryContext);

@DllImport("RPCNS4")
int RpcNsProfileDeleteA(uint ProfileNameSyntax, ubyte* ProfileName);

@DllImport("RPCNS4")
int RpcNsProfileEltAddA(uint ProfileNameSyntax, ubyte* ProfileName, RPC_IF_ID* IfId, uint MemberNameSyntax, 
                        ubyte* MemberName, uint Priority, ubyte* Annotation);

@DllImport("RPCNS4")
int RpcNsProfileEltRemoveA(uint ProfileNameSyntax, ubyte* ProfileName, RPC_IF_ID* IfId, uint MemberNameSyntax, 
                           ubyte* MemberName);

@DllImport("RPCNS4")
int RpcNsProfileEltInqBeginA(uint ProfileNameSyntax, ubyte* ProfileName, uint InquiryType, RPC_IF_ID* IfId, 
                             uint VersOption, uint MemberNameSyntax, ubyte* MemberName, void** InquiryContext);

@DllImport("RPCNS4")
int RpcNsProfileEltInqNextA(void* InquiryContext, RPC_IF_ID* IfId, ubyte** MemberName, uint* Priority, 
                            ubyte** Annotation);

@DllImport("RPCNS4")
int RpcNsProfileDeleteW(uint ProfileNameSyntax, ushort* ProfileName);

@DllImport("RPCNS4")
int RpcNsProfileEltAddW(uint ProfileNameSyntax, ushort* ProfileName, RPC_IF_ID* IfId, uint MemberNameSyntax, 
                        ushort* MemberName, uint Priority, ushort* Annotation);

@DllImport("RPCNS4")
int RpcNsProfileEltRemoveW(uint ProfileNameSyntax, ushort* ProfileName, RPC_IF_ID* IfId, uint MemberNameSyntax, 
                           ushort* MemberName);

@DllImport("RPCNS4")
int RpcNsProfileEltInqBeginW(uint ProfileNameSyntax, ushort* ProfileName, uint InquiryType, RPC_IF_ID* IfId, 
                             uint VersOption, uint MemberNameSyntax, ushort* MemberName, void** InquiryContext);

@DllImport("RPCNS4")
int RpcNsProfileEltInqNextW(void* InquiryContext, RPC_IF_ID* IfId, ushort** MemberName, uint* Priority, 
                            ushort** Annotation);

@DllImport("RPCNS4")
int RpcNsProfileEltInqDone(void** InquiryContext);

@DllImport("RPCNS4")
int RpcNsEntryObjectInqBeginA(uint EntryNameSyntax, ubyte* EntryName, void** InquiryContext);

@DllImport("RPCNS4")
int RpcNsEntryObjectInqBeginW(uint EntryNameSyntax, ushort* EntryName, void** InquiryContext);

@DllImport("RPCNS4")
int RpcNsEntryObjectInqNext(void* InquiryContext, GUID* ObjUuid);

@DllImport("RPCNS4")
int RpcNsEntryObjectInqDone(void** InquiryContext);

@DllImport("RPCNS4")
int RpcNsEntryExpandNameA(uint EntryNameSyntax, ubyte* EntryName, ubyte** ExpandedName);

@DllImport("RPCNS4")
int RpcNsMgmtBindingUnexportA(uint EntryNameSyntax, ubyte* EntryName, RPC_IF_ID* IfId, uint VersOption, 
                              UUID_VECTOR* ObjectUuidVec);

@DllImport("RPCNS4")
int RpcNsMgmtEntryCreateA(uint EntryNameSyntax, ubyte* EntryName);

@DllImport("RPCNS4")
int RpcNsMgmtEntryDeleteA(uint EntryNameSyntax, ubyte* EntryName);

@DllImport("RPCNS4")
int RpcNsMgmtEntryInqIfIdsA(uint EntryNameSyntax, ubyte* EntryName, RPC_IF_ID_VECTOR** IfIdVec);

@DllImport("RPCNS4")
int RpcNsMgmtHandleSetExpAge(void* NsHandle, uint ExpirationAge);

@DllImport("RPCNS4")
int RpcNsMgmtInqExpAge(uint* ExpirationAge);

@DllImport("RPCNS4")
int RpcNsMgmtSetExpAge(uint ExpirationAge);

@DllImport("RPCNS4")
int RpcNsEntryExpandNameW(uint EntryNameSyntax, ushort* EntryName, ushort** ExpandedName);

@DllImport("RPCNS4")
int RpcNsMgmtBindingUnexportW(uint EntryNameSyntax, ushort* EntryName, RPC_IF_ID* IfId, uint VersOption, 
                              UUID_VECTOR* ObjectUuidVec);

@DllImport("RPCNS4")
int RpcNsMgmtEntryCreateW(uint EntryNameSyntax, ushort* EntryName);

@DllImport("RPCNS4")
int RpcNsMgmtEntryDeleteW(uint EntryNameSyntax, ushort* EntryName);

@DllImport("RPCNS4")
int RpcNsMgmtEntryInqIfIdsW(uint EntryNameSyntax, ushort* EntryName, RPC_IF_ID_VECTOR** IfIdVec);

@DllImport("RPCNS4")
int RpcNsBindingImportBeginA(uint EntryNameSyntax, ubyte* EntryName, void* IfSpec, GUID* ObjUuid, 
                             void** ImportContext);

@DllImport("RPCNS4")
int RpcNsBindingImportBeginW(uint EntryNameSyntax, ushort* EntryName, void* IfSpec, GUID* ObjUuid, 
                             void** ImportContext);

@DllImport("RPCNS4")
int RpcNsBindingImportNext(void* ImportContext, void** Binding);

@DllImport("RPCNS4")
int RpcNsBindingImportDone(void** ImportContext);

@DllImport("RPCNS4")
int RpcNsBindingSelect(RPC_BINDING_VECTOR* BindingVec, void** Binding);

@DllImport("RPCRT4")
int RpcAsyncRegisterInfo(RPC_ASYNC_STATE* pAsync);

@DllImport("RPCRT4")
int RpcAsyncInitializeHandle(char* pAsync, uint Size);

@DllImport("RPCRT4")
int RpcAsyncGetCallStatus(RPC_ASYNC_STATE* pAsync);

@DllImport("RPCRT4")
int RpcAsyncCompleteCall(RPC_ASYNC_STATE* pAsync, void* Reply);

@DllImport("RPCRT4")
int RpcAsyncAbortCall(RPC_ASYNC_STATE* pAsync, uint ExceptionCode);

@DllImport("RPCRT4")
int RpcAsyncCancelCall(RPC_ASYNC_STATE* pAsync, BOOL fAbort);

@DllImport("RPCRT4")
int RpcErrorStartEnumeration(RPC_ERROR_ENUM_HANDLE* EnumHandle);

@DllImport("RPCRT4")
int RpcErrorGetNextRecord(RPC_ERROR_ENUM_HANDLE* EnumHandle, BOOL CopyStrings, RPC_EXTENDED_ERROR_INFO* ErrorInfo);

@DllImport("RPCRT4")
int RpcErrorEndEnumeration(RPC_ERROR_ENUM_HANDLE* EnumHandle);

@DllImport("RPCRT4")
int RpcErrorResetEnumeration(RPC_ERROR_ENUM_HANDLE* EnumHandle);

@DllImport("RPCRT4")
int RpcErrorGetNumberOfRecords(RPC_ERROR_ENUM_HANDLE* EnumHandle, int* Records);

@DllImport("RPCRT4")
int RpcErrorSaveErrorInfo(RPC_ERROR_ENUM_HANDLE* EnumHandle, void** ErrorBlob, size_t* BlobSize);

@DllImport("RPCRT4")
int RpcErrorLoadErrorInfo(char* ErrorBlob, size_t BlobSize, RPC_ERROR_ENUM_HANDLE* EnumHandle);

@DllImport("RPCRT4")
int RpcErrorAddRecord(RPC_EXTENDED_ERROR_INFO* ErrorInfo);

@DllImport("RPCRT4")
void RpcErrorClearInformation();

@DllImport("RPCRT4")
int RpcGetAuthorizationContextForClient(void* ClientBinding, BOOL ImpersonateOnReturn, void* Reserved1, 
                                        LARGE_INTEGER* pExpirationTime, LUID Reserved2, uint Reserved3, 
                                        void* Reserved4, void** pAuthzClientContext);

@DllImport("RPCRT4")
int RpcFreeAuthorizationContext(void** pAuthzClientContext);

@DllImport("RPCRT4")
int RpcSsContextLockExclusive(void* ServerBindingHandle, void* UserContext);

@DllImport("RPCRT4")
int RpcSsContextLockShared(void* ServerBindingHandle, void* UserContext);

@DllImport("RPCRT4")
int RpcServerInqCallAttributesW(void* ClientBinding, void* RpcCallAttributes);

@DllImport("RPCRT4")
int RpcServerInqCallAttributesA(void* ClientBinding, void* RpcCallAttributes);

@DllImport("RPCRT4")
int RpcServerSubscribeForNotification(void* Binding, RPC_NOTIFICATIONS Notification, 
                                      RPC_NOTIFICATION_TYPES NotificationType, 
                                      RPC_ASYNC_NOTIFICATION_INFO* NotificationInfo);

@DllImport("RPCRT4")
int RpcServerUnsubscribeForNotification(void* Binding, RPC_NOTIFICATIONS Notification, uint* NotificationsQueued);

@DllImport("RPCRT4")
int RpcBindingBind(RPC_ASYNC_STATE* pAsync, void* Binding, void* IfSpec);

@DllImport("RPCRT4")
int RpcBindingUnbind(void* Binding);

@DllImport("RPCRT4")
int I_RpcAsyncSetHandle(RPC_MESSAGE* Message, RPC_ASYNC_STATE* pAsync);

@DllImport("RPCRT4")
int I_RpcAsyncAbortCall(RPC_ASYNC_STATE* pAsync, uint ExceptionCode);

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

@DllImport("RPCRT4")
void RpcSsDestroyClientContext(void** ContextHandle);

@DllImport("RPCRT4")
void NdrSimpleTypeMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte FormatChar);

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

@DllImport("RPCRT4")
ubyte* NdrUserMarshalMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

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

@DllImport("RPCRT4")
ubyte* NdrInterfacePointerUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                     ubyte fMustAlloc);

@DllImport("RPCRT4")
void NdrClientContextUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ptrdiff_t* pContextHandle, void* BindHandle);

@DllImport("RPCRT4")
NDR_SCONTEXT_1* NdrServerContextUnmarshall(MIDL_STUB_MESSAGE* pStubMsg);

@DllImport("RPCRT4")
NDR_SCONTEXT_1* NdrContextHandleInitialize(MIDL_STUB_MESSAGE* pStubMsg, char* pFormat);

@DllImport("RPCRT4")
NDR_SCONTEXT_1* NdrServerContextNewUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, char* pFormat);

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

@DllImport("RPCRT4")
void NdrUserMarshalBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrInterfacePointerBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

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

@DllImport("RPCRT4")
void NdrUserMarshalFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrInterfacePointerFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrConvert2(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat, int NumberParams);

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

@DllImport("RPCRT4")
CLIENT_CALL_RETURN NdrClientCall2(MIDL_STUB_DESC* pStubDescriptor, ubyte* pFormat);

@DllImport("RPCRT4")
CLIENT_CALL_RETURN NdrAsyncClientCall(MIDL_STUB_DESC* pStubDescriptor, ubyte* pFormat);

@DllImport("RPCRT4")
CLIENT_CALL_RETURN NdrDcomAsyncClientCall(MIDL_STUB_DESC* pStubDescriptor, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrAsyncServerCall(RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4")
int NdrDcomAsyncStubCall(IRpcStubBuffer pThis, IRpcChannelBuffer pChannel, RPC_MESSAGE* pRpcMsg, 
                         uint* pdwStubPhase);

@DllImport("RPCRT4")
int NdrStubCall2(void* pThis, void* pChannel, RPC_MESSAGE* pRpcMsg, uint* pdwStubPhase);

@DllImport("RPCRT4")
void NdrServerCall2(RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4")
int NdrMapCommAndFaultStatus(MIDL_STUB_MESSAGE* pStubMsg, uint* pCommStatus, uint* pFaultStatus, int Status);

@DllImport("RPCRT4")
void* RpcSsAllocate(size_t Size);

@DllImport("RPCRT4")
void RpcSsDisableAllocate();

@DllImport("RPCRT4")
void RpcSsEnableAllocate();

@DllImport("RPCRT4")
void RpcSsFree(void* NodeToFree);

@DllImport("RPCRT4")
void* RpcSsGetThreadHandle();

@DllImport("RPCRT4")
void RpcSsSetClientAllocFree(RPC_CLIENT_ALLOC* ClientAlloc, RPC_CLIENT_FREE* ClientFree);

@DllImport("RPCRT4")
void RpcSsSetThreadHandle(void* Id);

@DllImport("RPCRT4")
void RpcSsSwapClientAllocFree(RPC_CLIENT_ALLOC* ClientAlloc, RPC_CLIENT_FREE* ClientFree, 
                              RPC_CLIENT_ALLOC** OldClientAlloc, RPC_CLIENT_FREE** OldClientFree);

@DllImport("RPCRT4")
void* RpcSmAllocate(size_t Size, int* pStatus);

@DllImport("RPCRT4")
int RpcSmClientFree(void* pNodeToFree);

@DllImport("RPCRT4")
int RpcSmDestroyClientContext(void** ContextHandle);

@DllImport("RPCRT4")
int RpcSmDisableAllocate();

@DllImport("RPCRT4")
int RpcSmEnableAllocate();

@DllImport("RPCRT4")
int RpcSmFree(void* NodeToFree);

@DllImport("RPCRT4")
void* RpcSmGetThreadHandle(int* pStatus);

@DllImport("RPCRT4")
int RpcSmSetClientAllocFree(RPC_CLIENT_ALLOC* ClientAlloc, RPC_CLIENT_FREE* ClientFree);

@DllImport("RPCRT4")
int RpcSmSetThreadHandle(void* Id);

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

@DllImport("RPCRT4")
void NdrClearOutParameters(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat, void* ArgAddr);

@DllImport("RPCRT4")
void* NdrOleAllocate(size_t Size);

@DllImport("RPCRT4")
void NdrOleFree(void* NodeToFree);

@DllImport("RPCRT4")
int NdrGetUserMarshalInfo(uint* pFlags, uint InformationLevel, NDR_USER_MARSHAL_INFO* pMarshalInfo);

@DllImport("RPCRT4")
int NdrCreateServerInterfaceFromStub(IRpcStubBuffer pStub, RPC_SERVER_INTERFACE* pServerIf);

@DllImport("RPCRT4")
CLIENT_CALL_RETURN NdrClientCall3(MIDL_STUBLESS_PROXY_INFO* pProxyInfo, uint nProcNum, void* pReturnValue);

@DllImport("RPCRT4")
CLIENT_CALL_RETURN Ndr64AsyncClientCall(MIDL_STUBLESS_PROXY_INFO* pProxyInfo, uint nProcNum, void* pReturnValue);

@DllImport("RPCRT4")
CLIENT_CALL_RETURN Ndr64DcomAsyncClientCall(MIDL_STUBLESS_PROXY_INFO* pProxyInfo, uint nProcNum, 
                                            void* pReturnValue);

@DllImport("RPCRT4")
void Ndr64AsyncServerCall64(RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4")
void Ndr64AsyncServerCallAll(RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4")
int Ndr64DcomAsyncStubCall(IRpcStubBuffer pThis, IRpcChannelBuffer pChannel, RPC_MESSAGE* pRpcMsg, 
                           uint* pdwStubPhase);

@DllImport("RPCRT4")
int NdrStubCall3(void* pThis, void* pChannel, RPC_MESSAGE* pRpcMsg, uint* pdwStubPhase);

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

@DllImport("RPCRT4")
void RpcUserFree(void* AsyncHandle, void* pBuffer);

@DllImport("RPCRT4")
int MesEncodeIncrementalHandleCreate(void* UserState, MIDL_ES_ALLOC AllocFn, MIDL_ES_WRITE WriteFn, void** pHandle);

@DllImport("RPCRT4")
int MesDecodeIncrementalHandleCreate(void* UserState, MIDL_ES_READ ReadFn, void** pHandle);

@DllImport("RPCRT4")
int MesIncrementalHandleReset(void* Handle, void* UserState, MIDL_ES_ALLOC AllocFn, MIDL_ES_WRITE WriteFn, 
                              MIDL_ES_READ ReadFn, MIDL_ES_CODE Operation);

@DllImport("RPCRT4")
int MesEncodeFixedBufferHandleCreate(char* pBuffer, uint BufferSize, uint* pEncodedSize, void** pHandle);

@DllImport("RPCRT4")
int MesEncodeDynBufferHandleCreate(byte** pBuffer, uint* pEncodedSize, void** pHandle);

@DllImport("RPCRT4")
int MesDecodeBufferHandleCreate(char* Buffer, uint BufferSize, void** pHandle);

@DllImport("RPCRT4")
int MesBufferHandleReset(void* Handle, uint HandleStyle, MIDL_ES_CODE Operation, char* pBuffer, uint BufferSize, 
                         uint* pEncodedSize);

@DllImport("RPCRT4")
int MesHandleFree(void* Handle);

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

@DllImport("RPCRT4")
int RpcCertGeneratePrincipalNameW(CERT_CONTEXT* Context, uint Flags, ushort** pBuffer);

@DllImport("RPCRT4")
int RpcCertGeneratePrincipalNameA(CERT_CONTEXT* Context, uint Flags, ubyte** pBuffer);


