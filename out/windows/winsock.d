module windows.winsock;

public import windows.core;
public import windows.com : HRESULT;
public import windows.iphelper : SOCKADDR_INET;
public import windows.networkdrivers : SOCKADDR_STORAGE_LH, SOCKET_ADDRESS_LIST;
public import windows.qualityofservice : QOS;
public import windows.systemservices : BOOL, FARPROC, HANDLE, LARGE_INTEGER, OVERLAPPED, PROCESSOR_NUMBER;
public import windows.windowsandmessaging : HWND, LPARAM, WPARAM;

extern(Windows):


// Enums


enum : int
{
    IPPROTO_HOPOPTS               = 0x00000000,
    IPPROTO_ICMP                  = 0x00000001,
    IPPROTO_IGMP                  = 0x00000002,
    IPPROTO_GGP                   = 0x00000003,
    IPPROTO_IPV4                  = 0x00000004,
    IPPROTO_ST                    = 0x00000005,
    IPPROTO_TCP                   = 0x00000006,
    IPPROTO_CBT                   = 0x00000007,
    IPPROTO_EGP                   = 0x00000008,
    IPPROTO_IGP                   = 0x00000009,
    IPPROTO_PUP                   = 0x0000000c,
    IPPROTO_UDP                   = 0x00000011,
    IPPROTO_IDP                   = 0x00000016,
    IPPROTO_RDP                   = 0x0000001b,
    IPPROTO_IPV6                  = 0x00000029,
    IPPROTO_ROUTING               = 0x0000002b,
    IPPROTO_FRAGMENT              = 0x0000002c,
    IPPROTO_ESP                   = 0x00000032,
    IPPROTO_AH                    = 0x00000033,
    IPPROTO_ICMPV6                = 0x0000003a,
    IPPROTO_NONE                  = 0x0000003b,
    IPPROTO_DSTOPTS               = 0x0000003c,
    IPPROTO_ND                    = 0x0000004d,
    IPPROTO_ICLFXBM               = 0x0000004e,
    IPPROTO_PIM                   = 0x00000067,
    IPPROTO_PGM                   = 0x00000071,
    IPPROTO_L2TP                  = 0x00000073,
    IPPROTO_SCTP                  = 0x00000084,
    IPPROTO_RAW                   = 0x000000ff,
    IPPROTO_MAX                   = 0x00000100,
    IPPROTO_RESERVED_RAW          = 0x00000101,
    IPPROTO_RESERVED_IPSEC        = 0x00000102,
    IPPROTO_RESERVED_IPSECOFFLOAD = 0x00000103,
    IPPROTO_RESERVED_WNV          = 0x00000104,
    IPPROTO_RESERVED_MAX          = 0x00000105,
}
alias IPPROTO = int;

enum : int
{
    NSP_NOTIFY_IMMEDIATELY = 0x00000000,
    NSP_NOTIFY_HWND        = 0x00000001,
    NSP_NOTIFY_EVENT       = 0x00000002,
    NSP_NOTIFY_PORT        = 0x00000003,
    NSP_NOTIFY_APC         = 0x00000004,
}
alias WSACOMPLETIONTYPE = int;

enum : int
{
    COMP_EQUAL   = 0x00000000,
    COMP_NOTLESS = 0x00000001,
}
alias WSAECOMPARATOR = int;

enum : int
{
    RNRSERVICE_REGISTER   = 0x00000000,
    RNRSERVICE_DEREGISTER = 0x00000001,
    RNRSERVICE_DELETE     = 0x00000002,
}
alias WSAESETSERVICEOP = int;

enum : int
{
    IP_PMTUDISC_NOT_SET = 0x00000000,
    IP_PMTUDISC_DO      = 0x00000001,
    IP_PMTUDISC_DONT    = 0x00000002,
    IP_PMTUDISC_PROBE   = 0x00000003,
    IP_PMTUDISC_MAX     = 0x00000004,
}
alias PMTUD_STATE = int;

enum : int
{
    MCAST_INCLUDE = 0x00000000,
    MCAST_EXCLUDE = 0x00000001,
}
alias MULTICAST_MODE_TYPE = int;

enum : int
{
    E_WINDOW_ADVANCE_BY_TIME   = 0x00000001,
    E_WINDOW_USE_AS_DATA_CACHE = 0x00000002,
}
alias eWINDOW_ADVANCE_METHOD = int;

enum : int
{
    NlbwDisabled  = 0x00000000,
    NlbwEnabled   = 0x00000001,
    NlbwUnchanged = 0xffffffff,
}
alias NL_BANDWIDTH_FLAG = int;

enum : int
{
    NetworkCategoryPublic              = 0x00000000,
    NetworkCategoryPrivate             = 0x00000001,
    NetworkCategoryDomainAuthenticated = 0x00000002,
    NetworkCategoryUnchanged           = 0xffffffff,
    NetworkCategoryUnknown             = 0xffffffff,
}
alias NL_NETWORK_CATEGORY = int;

enum : int
{
    NlincCategoryUnknown     = 0x00000000,
    NlincPublic              = 0x00000001,
    NlincPrivate             = 0x00000002,
    NlincDomainAuthenticated = 0x00000003,
    NlincCategoryStateMax    = 0x00000004,
}
alias NL_INTERFACE_NETWORK_CATEGORY_STATE = int;

enum : int
{
    TCPSTATE_CLOSED      = 0x00000000,
    TCPSTATE_LISTEN      = 0x00000001,
    TCPSTATE_SYN_SENT    = 0x00000002,
    TCPSTATE_SYN_RCVD    = 0x00000003,
    TCPSTATE_ESTABLISHED = 0x00000004,
    TCPSTATE_FIN_WAIT_1  = 0x00000005,
    TCPSTATE_FIN_WAIT_2  = 0x00000006,
    TCPSTATE_CLOSE_WAIT  = 0x00000007,
    TCPSTATE_CLOSING     = 0x00000008,
    TCPSTATE_LAST_ACK    = 0x00000009,
    TCPSTATE_TIME_WAIT   = 0x0000000a,
    TCPSTATE_MAX         = 0x0000000b,
}
alias TCPSTATE = int;

enum : int
{
    CONTROL_CHANNEL_TRIGGER_STATUS_INVALID                 = 0x00000000,
    CONTROL_CHANNEL_TRIGGER_STATUS_SOFTWARE_SLOT_ALLOCATED = 0x00000001,
    CONTROL_CHANNEL_TRIGGER_STATUS_HARDWARE_SLOT_ALLOCATED = 0x00000002,
    CONTROL_CHANNEL_TRIGGER_STATUS_POLICY_ERROR            = 0x00000003,
    CONTROL_CHANNEL_TRIGGER_STATUS_SYSTEM_ERROR            = 0x00000004,
    CONTROL_CHANNEL_TRIGGER_STATUS_TRANSPORT_DISCONNECTED  = 0x00000005,
    CONTROL_CHANNEL_TRIGGER_STATUS_SERVICE_UNAVAILABLE     = 0x00000006,
}
alias CONTROL_CHANNEL_TRIGGER_STATUS = int;

enum : int
{
    RCVALL_OFF             = 0x00000000,
    RCVALL_ON              = 0x00000001,
    RCVALL_SOCKETLEVELONLY = 0x00000002,
    RCVALL_IPLEVEL         = 0x00000003,
}
alias RCVALL_VALUE = int;

enum : int
{
    TCP_ICW_LEVEL_DEFAULT      = 0x00000000,
    TCP_ICW_LEVEL_HIGH         = 0x00000001,
    TCP_ICW_LEVEL_VERY_HIGH    = 0x00000002,
    TCP_ICW_LEVEL_AGGRESSIVE   = 0x00000003,
    TCP_ICW_LEVEL_EXPERIMENTAL = 0x00000004,
    TCP_ICW_LEVEL_COMPAT       = 0x000000fe,
    TCP_ICW_LEVEL_MAX          = 0x000000ff,
}
alias TCP_ICW_LEVEL = int;

enum : int
{
    SYSTEM_CRITICAL_SOCKET = 0x00000001,
}
alias SOCKET_USAGE_TYPE = int;

enum : int
{
    SOCKET_SECURITY_PROTOCOL_DEFAULT = 0x00000000,
    SOCKET_SECURITY_PROTOCOL_IPSEC   = 0x00000001,
    SOCKET_SECURITY_PROTOCOL_IPSEC2  = 0x00000002,
    SOCKET_SECURITY_PROTOCOL_INVALID = 0x00000003,
}
alias SOCKET_SECURITY_PROTOCOL = int;

enum : int
{
    WsaBehaviorAll              = 0x00000000,
    WsaBehaviorReceiveBuffering = 0x00000001,
    WsaBehaviorAutoTuning       = 0x00000002,
}
alias WSA_COMPATIBILITY_BEHAVIOR_ID = int;

enum : int
{
    IE_AALParameters             = 0x00000000,
    IE_TrafficDescriptor         = 0x00000001,
    IE_BroadbandBearerCapability = 0x00000002,
    IE_BHLI                      = 0x00000003,
    IE_BLLI                      = 0x00000004,
    IE_CalledPartyNumber         = 0x00000005,
    IE_CalledPartySubaddress     = 0x00000006,
    IE_CallingPartyNumber        = 0x00000007,
    IE_CallingPartySubaddress    = 0x00000008,
    IE_Cause                     = 0x00000009,
    IE_QOSClass                  = 0x0000000a,
    IE_TransitNetworkSelection   = 0x0000000b,
}
alias Q2931_IE_TYPE = int;

enum : int
{
    AALTYPE_5    = 0x00000005,
    AALTYPE_USER = 0x00000010,
}
alias AAL_TYPE = int;

enum : int
{
    ProviderType_Application = 0x00000001,
    ProviderType_Service     = 0x00000002,
}
alias NAPI_PROVIDER_TYPE = int;

enum : int
{
    ProviderLevel_None      = 0x00000000,
    ProviderLevel_Secondary = 0x00000001,
    ProviderLevel_Primary   = 0x00000002,
}
alias NAPI_PROVIDER_LEVEL = int;

enum : int
{
    NLA_RAW_DATA        = 0x00000000,
    NLA_INTERFACE       = 0x00000001,
    NLA_802_1X_LOCATION = 0x00000002,
    NLA_CONNECTIVITY    = 0x00000003,
    NLA_ICS             = 0x00000004,
}
alias NLA_BLOB_DATA_TYPE = int;

enum : int
{
    NLA_NETWORK_AD_HOC    = 0x00000000,
    NLA_NETWORK_MANAGED   = 0x00000001,
    NLA_NETWORK_UNMANAGED = 0x00000002,
    NLA_NETWORK_UNKNOWN   = 0x00000003,
}
alias NLA_CONNECTIVITY_TYPE = int;

enum : int
{
    NLA_INTERNET_UNKNOWN = 0x00000000,
    NLA_INTERNET_NO      = 0x00000001,
    NLA_INTERNET_YES     = 0x00000002,
}
alias NLA_INTERNET = int;

enum : int
{
    RIO_EVENT_COMPLETION = 0x00000001,
    RIO_IOCP_COMPLETION  = 0x00000002,
}
alias RIO_NOTIFICATION_COMPLETION_TYPE = int;

enum : int
{
    ProviderInfoLspCategories = 0x00000000,
    ProviderInfoAudit         = 0x00000001,
}
alias WSC_PROVIDER_INFO_TYPE = int;

// Constants


enum int LM_HB_Extension = 0x00000080;
enum int LM_HB1_PDA_Palmtop = 0x00000002;

enum : int
{
    LM_HB1_Printer   = 0x00000008,
    LM_HB1_Modem     = 0x00000010,
    LM_HB1_Fax       = 0x00000020,
    LM_HB1_LANAccess = 0x00000040,
}

enum int LM_HB2_FileServer = 0x00000002;

// Callbacks

alias LPCONDITIONPROC = int function(WSABUF* lpCallerId, WSABUF* lpCallerData, QOS* lpSQOS, QOS* lpGQOS, 
                                     WSABUF* lpCalleeId, WSABUF* lpCalleeData, uint* g, size_t dwCallbackData);
alias LPWSAOVERLAPPED_COMPLETION_ROUTINE = void function(uint dwError, uint cbTransferred, 
                                                         OVERLAPPED* lpOverlapped, uint dwFlags);
alias LPFN_TRANSMITFILE = BOOL function(size_t hSocket, HANDLE hFile, uint nNumberOfBytesToWrite, 
                                        uint nNumberOfBytesPerSend, OVERLAPPED* lpOverlapped, 
                                        TRANSMIT_FILE_BUFFERS* lpTransmitBuffers, uint dwReserved);
alias LPFN_ACCEPTEX = BOOL function(size_t sListenSocket, size_t sAcceptSocket, char* lpOutputBuffer, 
                                    uint dwReceiveDataLength, uint dwLocalAddressLength, uint dwRemoteAddressLength, 
                                    uint* lpdwBytesReceived, OVERLAPPED* lpOverlapped);
alias LPFN_GETACCEPTEXSOCKADDRS = void function(char* lpOutputBuffer, uint dwReceiveDataLength, 
                                                uint dwLocalAddressLength, uint dwRemoteAddressLength, 
                                                SOCKADDR** LocalSockaddr, int* LocalSockaddrLength, 
                                                SOCKADDR** RemoteSockaddr, int* RemoteSockaddrLength);
alias LPFN_TRANSMITPACKETS = BOOL function(size_t hSocket, TRANSMIT_PACKETS_ELEMENT* lpPacketArray, 
                                           uint nElementCount, uint nSendSize, OVERLAPPED* lpOverlapped, 
                                           uint dwFlags);
alias LPFN_CONNECTEX = BOOL function(size_t s, char* name, int namelen, char* lpSendBuffer, uint dwSendDataLength, 
                                     uint* lpdwBytesSent, OVERLAPPED* lpOverlapped);
alias LPFN_DISCONNECTEX = BOOL function(size_t s, OVERLAPPED* lpOverlapped, uint dwFlags, uint dwReserved);
alias LPFN_WSARECVMSG = int function(size_t s, WSAMSG* lpMsg, uint* lpdwNumberOfBytesRecvd, 
                                     OVERLAPPED* lpOverlapped, 
                                     LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);
alias LPFN_WSASENDMSG = int function(size_t s, WSAMSG* lpMsg, uint dwFlags, uint* lpNumberOfBytesSent, 
                                     OVERLAPPED* lpOverlapped, 
                                     LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);
alias LPFN_WSAPOLL = int function(WSAPOLLFD* fdarray, uint nfds, int timeout);
alias LPFN_RIORECEIVE = BOOL function(RIO_RQ_t* SocketQueue, char* pData, uint DataBufferCount, uint Flags, 
                                      void* RequestContext);
alias LPFN_RIORECEIVEEX = int function(RIO_RQ_t* SocketQueue, char* pData, uint DataBufferCount, 
                                       RIO_BUF* pLocalAddress, RIO_BUF* pRemoteAddress, RIO_BUF* pControlContext, 
                                       RIO_BUF* pFlags, uint Flags, void* RequestContext);
alias LPFN_RIOSEND = BOOL function(RIO_RQ_t* SocketQueue, char* pData, uint DataBufferCount, uint Flags, 
                                   void* RequestContext);
alias LPFN_RIOSENDEX = BOOL function(RIO_RQ_t* SocketQueue, char* pData, uint DataBufferCount, 
                                     RIO_BUF* pLocalAddress, RIO_BUF* pRemoteAddress, RIO_BUF* pControlContext, 
                                     RIO_BUF* pFlags, uint Flags, void* RequestContext);
alias LPFN_RIOCLOSECOMPLETIONQUEUE = void function(RIO_CQ_t* CQ);
alias LPFN_RIOCREATECOMPLETIONQUEUE = RIO_CQ_t* function(uint QueueSize, 
                                                         RIO_NOTIFICATION_COMPLETION* NotificationCompletion);
alias LPFN_RIOCREATEREQUESTQUEUE = RIO_RQ_t* function(size_t Socket, uint MaxOutstandingReceive, 
                                                      uint MaxReceiveDataBuffers, uint MaxOutstandingSend, 
                                                      uint MaxSendDataBuffers, RIO_CQ_t* ReceiveCQ, RIO_CQ_t* SendCQ, 
                                                      void* SocketContext);
alias LPFN_RIODEQUEUECOMPLETION = uint function(RIO_CQ_t* CQ, char* Array, uint ArraySize);
alias LPFN_RIODEREGISTERBUFFER = void function(RIO_BUFFERID_t* BufferId);
alias LPFN_RIONOTIFY = int function(RIO_CQ_t* CQ);
alias LPFN_RIOREGISTERBUFFER = RIO_BUFFERID_t* function(const(char)* DataBuffer, uint DataLength);
alias LPFN_RIORESIZECOMPLETIONQUEUE = BOOL function(RIO_CQ_t* CQ, uint QueueSize);
alias LPFN_RIORESIZEREQUESTQUEUE = BOOL function(RIO_RQ_t* RQ, uint MaxOutstandingReceive, uint MaxOutstandingSend);
alias LPBLOCKINGCALLBACK = BOOL function(size_t dwContext);
alias LPWSAUSERAPC = void function(size_t dwContext);
alias LPWSPACCEPT = size_t function(size_t s, char* addr, int* addrlen, LPCONDITIONPROC lpfnCondition, 
                                    size_t dwCallbackData, int* lpErrno);
alias LPWSPADDRESSTOSTRING = int function(char* lpsaAddress, uint dwAddressLength, 
                                          WSAPROTOCOL_INFOW* lpProtocolInfo, const(wchar)* lpszAddressString, 
                                          uint* lpdwAddressStringLength, int* lpErrno);
alias LPWSPASYNCSELECT = int function(size_t s, HWND hWnd, uint wMsg, int lEvent, int* lpErrno);
alias LPWSPBIND = int function(size_t s, char* name, int namelen, int* lpErrno);
alias LPWSPCANCELBLOCKINGCALL = int function(int* lpErrno);
alias LPWSPCLEANUP = int function(int* lpErrno);
alias LPWSPCLOSESOCKET = int function(size_t s, int* lpErrno);
alias LPWSPCONNECT = int function(size_t s, char* name, int namelen, WSABUF* lpCallerData, WSABUF* lpCalleeData, 
                                  QOS* lpSQOS, QOS* lpGQOS, int* lpErrno);
alias LPWSPDUPLICATESOCKET = int function(size_t s, uint dwProcessId, WSAPROTOCOL_INFOW* lpProtocolInfo, 
                                          int* lpErrno);
alias LPWSPENUMNETWORKEVENTS = int function(size_t s, HANDLE hEventObject, WSANETWORKEVENTS* lpNetworkEvents, 
                                            int* lpErrno);
alias LPWSPEVENTSELECT = int function(size_t s, HANDLE hEventObject, int lNetworkEvents, int* lpErrno);
alias LPWSPGETOVERLAPPEDRESULT = BOOL function(size_t s, OVERLAPPED* lpOverlapped, uint* lpcbTransfer, BOOL fWait, 
                                               uint* lpdwFlags, int* lpErrno);
alias LPWSPGETPEERNAME = int function(size_t s, char* name, int* namelen, int* lpErrno);
alias LPWSPGETSOCKNAME = int function(size_t s, char* name, int* namelen, int* lpErrno);
alias LPWSPGETSOCKOPT = int function(size_t s, int level, int optname, char* optval, int* optlen, int* lpErrno);
alias LPWSPGETQOSBYNAME = BOOL function(size_t s, WSABUF* lpQOSName, QOS* lpQOS, int* lpErrno);
alias LPWSPIOCTL = int function(size_t s, uint dwIoControlCode, char* lpvInBuffer, uint cbInBuffer, 
                                char* lpvOutBuffer, uint cbOutBuffer, uint* lpcbBytesReturned, 
                                OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, 
                                WSATHREADID* lpThreadId, int* lpErrno);
alias LPWSPJOINLEAF = size_t function(size_t s, char* name, int namelen, WSABUF* lpCallerData, 
                                      WSABUF* lpCalleeData, QOS* lpSQOS, QOS* lpGQOS, uint dwFlags, int* lpErrno);
alias LPWSPLISTEN = int function(size_t s, int backlog, int* lpErrno);
alias LPWSPRECV = int function(size_t s, char* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesRecvd, 
                               uint* lpFlags, OVERLAPPED* lpOverlapped, 
                               LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, WSATHREADID* lpThreadId, 
                               int* lpErrno);
alias LPWSPRECVDISCONNECT = int function(size_t s, WSABUF* lpInboundDisconnectData, int* lpErrno);
alias LPWSPRECVFROM = int function(size_t s, char* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesRecvd, 
                                   uint* lpFlags, char* lpFrom, int* lpFromlen, OVERLAPPED* lpOverlapped, 
                                   LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, WSATHREADID* lpThreadId, 
                                   int* lpErrno);
alias LPWSPSELECT = int function(int nfds, fd_set* readfds, fd_set* writefds, fd_set* exceptfds, 
                                 const(timeval)* timeout, int* lpErrno);
alias LPWSPSEND = int function(size_t s, char* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesSent, 
                               uint dwFlags, OVERLAPPED* lpOverlapped, 
                               LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, WSATHREADID* lpThreadId, 
                               int* lpErrno);
alias LPWSPSENDDISCONNECT = int function(size_t s, WSABUF* lpOutboundDisconnectData, int* lpErrno);
alias LPWSPSENDTO = int function(size_t s, char* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesSent, 
                                 uint dwFlags, char* lpTo, int iTolen, OVERLAPPED* lpOverlapped, 
                                 LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, WSATHREADID* lpThreadId, 
                                 int* lpErrno);
alias LPWSPSETSOCKOPT = int function(size_t s, int level, int optname, char* optval, int optlen, int* lpErrno);
alias LPWSPSHUTDOWN = int function(size_t s, int how, int* lpErrno);
alias LPWSPSOCKET = size_t function(int af, int type, int protocol, WSAPROTOCOL_INFOW* lpProtocolInfo, uint g, 
                                    uint dwFlags, int* lpErrno);
alias LPWSPSTRINGTOADDRESS = int function(const(wchar)* AddressString, int AddressFamily, 
                                          WSAPROTOCOL_INFOW* lpProtocolInfo, char* lpAddress, int* lpAddressLength, 
                                          int* lpErrno);
alias LPWPUCLOSEEVENT = BOOL function(HANDLE hEvent, int* lpErrno);
alias LPWPUCLOSESOCKETHANDLE = int function(size_t s, int* lpErrno);
alias LPWPUCREATEEVENT = HANDLE function(int* lpErrno);
alias LPWPUCREATESOCKETHANDLE = size_t function(uint dwCatalogEntryId, size_t dwContext, int* lpErrno);
alias LPWPUFDISSET = int function(size_t s, fd_set* fdset);
alias LPWPUGETPROVIDERPATH = int function(GUID* lpProviderId, char* lpszProviderDllPath, int* lpProviderDllPathLen, 
                                          int* lpErrno);
alias LPWPUMODIFYIFSHANDLE = size_t function(uint dwCatalogEntryId, size_t ProposedHandle, int* lpErrno);
alias LPWPUPOSTMESSAGE = BOOL function(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);
alias LPWPUQUERYBLOCKINGCALLBACK = int function(uint dwCatalogEntryId, LPBLOCKINGCALLBACK* lplpfnCallback, 
                                                size_t* lpdwContext, int* lpErrno);
alias LPWPUQUERYSOCKETHANDLECONTEXT = int function(size_t s, size_t* lpContext, int* lpErrno);
alias LPWPUQUEUEAPC = int function(WSATHREADID* lpThreadId, LPWSAUSERAPC lpfnUserApc, size_t dwContext, 
                                   int* lpErrno);
alias LPWPURESETEVENT = BOOL function(HANDLE hEvent, int* lpErrno);
alias LPWPUSETEVENT = BOOL function(HANDLE hEvent, int* lpErrno);
alias LPWPUOPENCURRENTTHREAD = int function(WSATHREADID* lpThreadId, int* lpErrno);
alias LPWPUCLOSETHREAD = int function(WSATHREADID* lpThreadId, int* lpErrno);
alias LPWPUCOMPLETEOVERLAPPEDREQUEST = int function(size_t s, OVERLAPPED* lpOverlapped, uint dwError, 
                                                    uint cbTransferred, int* lpErrno);
alias LPWSPSTARTUP = int function(ushort wVersionRequested, WSPData* lpWSPData, WSAPROTOCOL_INFOW* lpProtocolInfo, 
                                  WSPUPCALLTABLE UpcallTable, WSPPROC_TABLE* lpProcTable);
alias LPWSCENUMPROTOCOLS = int function(int* lpiProtocols, char* lpProtocolBuffer, uint* lpdwBufferLength, 
                                        int* lpErrno);
alias LPWSCDEINSTALLPROVIDER = int function(GUID* lpProviderId, int* lpErrno);
alias LPWSCINSTALLPROVIDER = int function(GUID* lpProviderId, const(wchar)* lpszProviderDllPath, 
                                          char* lpProtocolInfoList, uint dwNumberOfEntries, int* lpErrno);
alias LPWSCGETPROVIDERPATH = int function(GUID* lpProviderId, char* lpszProviderDllPath, int* lpProviderDllPathLen, 
                                          int* lpErrno);
alias LPWSCUPDATEPROVIDER = int function(GUID* lpProviderId, const(wchar)* lpszProviderDllPath, 
                                         char* lpProtocolInfoList, uint dwNumberOfEntries, int* lpErrno);
alias LPWSCINSTALLNAMESPACE = int function(const(wchar)* lpszIdentifier, const(wchar)* lpszPathName, 
                                           uint dwNameSpace, uint dwVersion, GUID* lpProviderId);
alias LPWSCUNINSTALLNAMESPACE = int function(GUID* lpProviderId);
alias LPWSCENABLENSPROVIDER = int function(GUID* lpProviderId, BOOL fEnable);
alias LPNSPCLEANUP = int function(GUID* lpProviderId);
alias LPNSPLOOKUPSERVICEBEGIN = int function(GUID* lpProviderId, WSAQUERYSETW* lpqsRestrictions, 
                                             WSASERVICECLASSINFOW* lpServiceClassInfo, uint dwControlFlags, 
                                             ptrdiff_t* lphLookup);
alias LPNSPLOOKUPSERVICENEXT = int function(HANDLE hLookup, uint dwControlFlags, uint* lpdwBufferLength, 
                                            char* lpqsResults);
alias LPNSPIOCTL = int function(HANDLE hLookup, uint dwControlCode, char* lpvInBuffer, uint cbInBuffer, 
                                char* lpvOutBuffer, uint cbOutBuffer, uint* lpcbBytesReturned, 
                                WSACOMPLETION* lpCompletion, WSATHREADID* lpThreadId);
alias LPNSPLOOKUPSERVICEEND = int function(HANDLE hLookup);
alias LPNSPSETSERVICE = int function(GUID* lpProviderId, WSASERVICECLASSINFOW* lpServiceClassInfo, 
                                     WSAQUERYSETW* lpqsRegInfo, WSAESETSERVICEOP essOperation, uint dwControlFlags);
alias LPNSPINSTALLSERVICECLASS = int function(GUID* lpProviderId, WSASERVICECLASSINFOW* lpServiceClassInfo);
alias LPNSPREMOVESERVICECLASS = int function(GUID* lpProviderId, GUID* lpServiceClassId);
alias LPNSPGETSERVICECLASSINFO = int function(GUID* lpProviderId, uint* lpdwBufSize, 
                                              WSASERVICECLASSINFOW* lpServiceClassInfo);
alias LPNSPSTARTUP = int function(GUID* lpProviderId, NSP_ROUTINE* lpnspRoutines);
alias LPNSPV2STARTUP = int function(GUID* lpProviderId, void** ppvClientSessionArg);
alias LPNSPV2CLEANUP = int function(GUID* lpProviderId, void* pvClientSessionArg);
alias LPNSPV2LOOKUPSERVICEBEGIN = int function(GUID* lpProviderId, WSAQUERYSET2W* lpqsRestrictions, 
                                               uint dwControlFlags, void* lpvClientSessionArg, ptrdiff_t* lphLookup);
alias LPNSPV2LOOKUPSERVICENEXTEX = void function(HANDLE hAsyncCall, HANDLE hLookup, uint dwControlFlags, 
                                                 uint* lpdwBufferLength, WSAQUERYSET2W* lpqsResults);
alias LPNSPV2LOOKUPSERVICEEND = int function(HANDLE hLookup);
alias LPNSPV2SETSERVICEEX = void function(HANDLE hAsyncCall, GUID* lpProviderId, WSAQUERYSET2W* lpqsRegInfo, 
                                          WSAESETSERVICEOP essOperation, uint dwControlFlags, 
                                          void* lpvClientSessionArg);
alias LPNSPV2CLIENTSESSIONRUNDOWN = void function(GUID* lpProviderId, void* pvClientSessionArg);
alias LPFN_NSPAPI = uint function();
alias LPSERVICE_CALLBACK_PROC = void function(LPARAM lParam, HANDLE hAsyncTaskHandle);
alias LPLOOKUPSERVICE_COMPLETION_ROUTINE = void function(uint dwError, uint dwBytes, OVERLAPPED* lpOverlapped);
alias LPWSCWRITEPROVIDERORDER = int function(uint* lpwdCatalogEntryId, uint dwNumberOfEntries);
alias LPWSCWRITENAMESPACEORDER = int function(GUID* lpProviderId, uint dwNumberOfEntries);

// Structs


struct BLOB
{
    uint   cbSize;
    ubyte* pBlobData;
}

alias HWSAEVENT = ptrdiff_t;

struct in_addr
{
    union S_un
    {
        struct S_un_b
        {
            ubyte s_b1;
            ubyte s_b2;
            ubyte s_b3;
            ubyte s_b4;
        }
        struct S_un_w
        {
            ushort s_w1;
            ushort s_w2;
        }
        uint S_addr;
    }
}

struct SOCKADDR
{
    ushort   sa_family;
    byte[14] sa_data;
}

struct SOCKET_ADDRESS
{
    SOCKADDR* lpSockaddr;
    int       iSockaddrLength;
}

struct CSADDR_INFO
{
    SOCKET_ADDRESS LocalAddr;
    SOCKET_ADDRESS RemoteAddr;
    int            iSocketType;
    int            iProtocol;
}

struct sockaddr_storage_xp
{
    short     ss_family;
    byte[6]   __ss_pad1;
    long      __ss_align;
    byte[112] __ss_pad2;
}

struct SOCKET_PROCESSOR_AFFINITY
{
    PROCESSOR_NUMBER Processor;
    ushort           NumaNodeId;
    ushort           Reserved;
}

struct SCOPE_ID
{
    union
    {
        struct
        {
            uint _bitfield199;
        }
        uint Value;
    }
}

struct sockaddr_in
{
    ushort  sin_family;
    ushort  sin_port;
    in_addr sin_addr;
    byte[8] sin_zero;
}

struct sockaddr_dl
{
    ushort   sdl_family;
    ubyte[8] sdl_data;
    ubyte[4] sdl_zero;
}

struct WSABUF
{
    uint  len;
    byte* buf;
}

struct WSAMSG
{
    SOCKADDR* name;
    int       namelen;
    WSABUF*   lpBuffers;
    uint      dwBufferCount;
    WSABUF    Control;
    uint      dwFlags;
}

struct cmsghdr
{
    size_t cmsg_len;
    int    cmsg_level;
    int    cmsg_type;
}

struct ADDRINFOA
{
    int        ai_flags;
    int        ai_family;
    int        ai_socktype;
    int        ai_protocol;
    size_t     ai_addrlen;
    byte*      ai_canonname;
    SOCKADDR*  ai_addr;
    ADDRINFOA* ai_next;
}

struct addrinfoW
{
    int           ai_flags;
    int           ai_family;
    int           ai_socktype;
    int           ai_protocol;
    size_t        ai_addrlen;
    const(wchar)* ai_canonname;
    SOCKADDR*     ai_addr;
    addrinfoW*    ai_next;
}

struct addrinfoexA
{
    int          ai_flags;
    int          ai_family;
    int          ai_socktype;
    int          ai_protocol;
    size_t       ai_addrlen;
    byte*        ai_canonname;
    SOCKADDR*    ai_addr;
    void*        ai_blob;
    size_t       ai_bloblen;
    GUID*        ai_provider;
    addrinfoexA* ai_next;
}

struct addrinfoexW
{
    int           ai_flags;
    int           ai_family;
    int           ai_socktype;
    int           ai_protocol;
    size_t        ai_addrlen;
    const(wchar)* ai_canonname;
    SOCKADDR*     ai_addr;
    void*         ai_blob;
    size_t        ai_bloblen;
    GUID*         ai_provider;
    addrinfoexW*  ai_next;
}

struct addrinfoex2A
{
    int           ai_flags;
    int           ai_family;
    int           ai_socktype;
    int           ai_protocol;
    size_t        ai_addrlen;
    byte*         ai_canonname;
    SOCKADDR*     ai_addr;
    void*         ai_blob;
    size_t        ai_bloblen;
    GUID*         ai_provider;
    addrinfoex2A* ai_next;
    int           ai_version;
    byte*         ai_fqdn;
}

struct addrinfoex2W
{
    int           ai_flags;
    int           ai_family;
    int           ai_socktype;
    int           ai_protocol;
    size_t        ai_addrlen;
    const(wchar)* ai_canonname;
    SOCKADDR*     ai_addr;
    void*         ai_blob;
    size_t        ai_bloblen;
    GUID*         ai_provider;
    addrinfoex2W* ai_next;
    int           ai_version;
    const(wchar)* ai_fqdn;
}

struct addrinfoex3
{
    int           ai_flags;
    int           ai_family;
    int           ai_socktype;
    int           ai_protocol;
    size_t        ai_addrlen;
    const(wchar)* ai_canonname;
    SOCKADDR*     ai_addr;
    void*         ai_blob;
    size_t        ai_bloblen;
    GUID*         ai_provider;
    addrinfoex3*  ai_next;
    int           ai_version;
    const(wchar)* ai_fqdn;
    int           ai_interfaceindex;
}

struct addrinfoex4
{
    int           ai_flags;
    int           ai_family;
    int           ai_socktype;
    int           ai_protocol;
    size_t        ai_addrlen;
    const(wchar)* ai_canonname;
    SOCKADDR*     ai_addr;
    void*         ai_blob;
    size_t        ai_bloblen;
    GUID*         ai_provider;
    addrinfoex4*  ai_next;
    int           ai_version;
    const(wchar)* ai_fqdn;
    int           ai_interfaceindex;
    HANDLE        ai_resolutionhandle;
}

struct fd_set
{
    uint       fd_count;
    size_t[64] fd_array;
}

struct timeval
{
    int tv_sec;
    int tv_usec;
}

struct hostent
{
    byte*  h_name;
    byte** h_aliases;
    short  h_addrtype;
    short  h_length;
    byte** h_addr_list;
}

struct netent
{
    byte*  n_name;
    byte** n_aliases;
    short  n_addrtype;
    uint   n_net;
}

struct servent
{
    byte*  s_name;
    byte** s_aliases;
    short  s_port;
    byte*  s_proto;
}

struct protoent
{
    byte*  p_name;
    byte** p_aliases;
    short  p_proto;
}

struct WSAData
{
    ushort    wVersion;
    ushort    wHighVersion;
    byte[257] szDescription;
    byte[129] szSystemStatus;
    ushort    iMaxSockets;
    ushort    iMaxUdpDg;
    byte*     lpVendorInfo;
}

struct sockproto
{
    ushort sp_family;
    ushort sp_protocol;
}

struct linger
{
    ushort l_onoff;
    ushort l_linger;
}

struct WSANETWORKEVENTS
{
    int     lNetworkEvents;
    int[10] iErrorCode;
}

struct WSAPROTOCOLCHAIN
{
    int     ChainLen;
    uint[7] ChainEntries;
}

struct WSAPROTOCOL_INFOA
{
    uint             dwServiceFlags1;
    uint             dwServiceFlags2;
    uint             dwServiceFlags3;
    uint             dwServiceFlags4;
    uint             dwProviderFlags;
    GUID             ProviderId;
    uint             dwCatalogEntryId;
    WSAPROTOCOLCHAIN ProtocolChain;
    int              iVersion;
    int              iAddressFamily;
    int              iMaxSockAddr;
    int              iMinSockAddr;
    int              iSocketType;
    int              iProtocol;
    int              iProtocolMaxOffset;
    int              iNetworkByteOrder;
    int              iSecurityScheme;
    uint             dwMessageSize;
    uint             dwProviderReserved;
    byte[256]        szProtocol;
}

struct WSAPROTOCOL_INFOW
{
    uint             dwServiceFlags1;
    uint             dwServiceFlags2;
    uint             dwServiceFlags3;
    uint             dwServiceFlags4;
    uint             dwProviderFlags;
    GUID             ProviderId;
    uint             dwCatalogEntryId;
    WSAPROTOCOLCHAIN ProtocolChain;
    int              iVersion;
    int              iAddressFamily;
    int              iMaxSockAddr;
    int              iMinSockAddr;
    int              iSocketType;
    int              iProtocol;
    int              iProtocolMaxOffset;
    int              iNetworkByteOrder;
    int              iSecurityScheme;
    uint             dwMessageSize;
    uint             dwProviderReserved;
    ushort[256]      szProtocol;
}

struct WSACOMPLETION
{
    WSACOMPLETIONTYPE Type;
    union Parameters
    {
        struct WindowMessage
        {
            HWND   hWnd;
            uint   uMsg;
            WPARAM context;
        }
        struct Event
        {
            OVERLAPPED* lpOverlapped;
        }
        struct Apc
        {
            OVERLAPPED* lpOverlapped;
            LPWSAOVERLAPPED_COMPLETION_ROUTINE lpfnCompletionProc;
        }
        struct Port
        {
            OVERLAPPED* lpOverlapped;
            HANDLE      hPort;
            size_t      Key;
        }
    }
}

struct AFPROTOCOLS
{
    int iAddressFamily;
    int iProtocol;
}

struct WSAVERSION
{
    uint           dwVersion;
    WSAECOMPARATOR ecHow;
}

struct WSAQUERYSETA
{
    uint         dwSize;
    const(char)* lpszServiceInstanceName;
    GUID*        lpServiceClassId;
    WSAVERSION*  lpVersion;
    const(char)* lpszComment;
    uint         dwNameSpace;
    GUID*        lpNSProviderId;
    const(char)* lpszContext;
    uint         dwNumberOfProtocols;
    AFPROTOCOLS* lpafpProtocols;
    const(char)* lpszQueryString;
    uint         dwNumberOfCsAddrs;
    CSADDR_INFO* lpcsaBuffer;
    uint         dwOutputFlags;
    BLOB*        lpBlob;
}

struct WSAQUERYSETW
{
    uint          dwSize;
    const(wchar)* lpszServiceInstanceName;
    GUID*         lpServiceClassId;
    WSAVERSION*   lpVersion;
    const(wchar)* lpszComment;
    uint          dwNameSpace;
    GUID*         lpNSProviderId;
    const(wchar)* lpszContext;
    uint          dwNumberOfProtocols;
    AFPROTOCOLS*  lpafpProtocols;
    const(wchar)* lpszQueryString;
    uint          dwNumberOfCsAddrs;
    CSADDR_INFO*  lpcsaBuffer;
    uint          dwOutputFlags;
    BLOB*         lpBlob;
}

struct WSAQUERYSET2A
{
    uint         dwSize;
    const(char)* lpszServiceInstanceName;
    WSAVERSION*  lpVersion;
    const(char)* lpszComment;
    uint         dwNameSpace;
    GUID*        lpNSProviderId;
    const(char)* lpszContext;
    uint         dwNumberOfProtocols;
    AFPROTOCOLS* lpafpProtocols;
    const(char)* lpszQueryString;
    uint         dwNumberOfCsAddrs;
    CSADDR_INFO* lpcsaBuffer;
    uint         dwOutputFlags;
    BLOB*        lpBlob;
}

struct WSAQUERYSET2W
{
    uint          dwSize;
    const(wchar)* lpszServiceInstanceName;
    WSAVERSION*   lpVersion;
    const(wchar)* lpszComment;
    uint          dwNameSpace;
    GUID*         lpNSProviderId;
    const(wchar)* lpszContext;
    uint          dwNumberOfProtocols;
    AFPROTOCOLS*  lpafpProtocols;
    const(wchar)* lpszQueryString;
    uint          dwNumberOfCsAddrs;
    CSADDR_INFO*  lpcsaBuffer;
    uint          dwOutputFlags;
    BLOB*         lpBlob;
}

struct WSANSCLASSINFOA
{
    const(char)* lpszName;
    uint         dwNameSpace;
    uint         dwValueType;
    uint         dwValueSize;
    void*        lpValue;
}

struct WSANSCLASSINFOW
{
    const(wchar)* lpszName;
    uint          dwNameSpace;
    uint          dwValueType;
    uint          dwValueSize;
    void*         lpValue;
}

struct WSASERVICECLASSINFOA
{
    GUID*            lpServiceClassId;
    const(char)*     lpszServiceClassName;
    uint             dwCount;
    WSANSCLASSINFOA* lpClassInfos;
}

struct WSASERVICECLASSINFOW
{
    GUID*            lpServiceClassId;
    const(wchar)*    lpszServiceClassName;
    uint             dwCount;
    WSANSCLASSINFOW* lpClassInfos;
}

struct WSANAMESPACE_INFOA
{
    GUID         NSProviderId;
    uint         dwNameSpace;
    BOOL         fActive;
    uint         dwVersion;
    const(char)* lpszIdentifier;
}

struct WSANAMESPACE_INFOW
{
    GUID          NSProviderId;
    uint          dwNameSpace;
    BOOL          fActive;
    uint          dwVersion;
    const(wchar)* lpszIdentifier;
}

struct WSANAMESPACE_INFOEXA
{
    GUID         NSProviderId;
    uint         dwNameSpace;
    BOOL         fActive;
    uint         dwVersion;
    const(char)* lpszIdentifier;
    BLOB         ProviderSpecific;
}

struct WSANAMESPACE_INFOEXW
{
    GUID          NSProviderId;
    uint          dwNameSpace;
    BOOL          fActive;
    uint          dwVersion;
    const(wchar)* lpszIdentifier;
    BLOB          ProviderSpecific;
}

struct WSAPOLLFD
{
    size_t fd;
    short  events;
    short  revents;
}

struct in6_addr
{
    union u
    {
        ubyte[16] Byte;
        ushort[8] Word;
    }
}

struct sockaddr_in6_old
{
    short    sin6_family;
    ushort   sin6_port;
    uint     sin6_flowinfo;
    in6_addr sin6_addr;
}

union sockaddr_gen
{
    SOCKADDR         Address;
    sockaddr_in      AddressIn;
    sockaddr_in6_old AddressIn6;
}

struct INTERFACE_INFO
{
    uint         iiFlags;
    sockaddr_gen iiAddress;
    sockaddr_gen iiBroadcastAddress;
    sockaddr_gen iiNetmask;
}

struct INTERFACE_INFO_EX
{
    uint           iiFlags;
    SOCKET_ADDRESS iiAddress;
    SOCKET_ADDRESS iiBroadcastAddress;
    SOCKET_ADDRESS iiNetmask;
}

struct sockaddr_in6_w2ksp1
{
    short    sin6_family;
    ushort   sin6_port;
    uint     sin6_flowinfo;
    in6_addr sin6_addr;
    uint     sin6_scope_id;
}

struct ip_mreq
{
    in_addr imr_multiaddr;
    in_addr imr_interface;
}

struct ip_mreq_source
{
    in_addr imr_multiaddr;
    in_addr imr_sourceaddr;
    in_addr imr_interface;
}

struct ip_msfilter
{
    in_addr             imsf_multiaddr;
    in_addr             imsf_interface;
    MULTICAST_MODE_TYPE imsf_fmode;
    uint                imsf_numsrc;
    in_addr[1]          imsf_slist;
}

struct ipv6_mreq
{
    in6_addr ipv6mr_multiaddr;
    uint     ipv6mr_interface;
}

struct group_req
{
    uint                gr_interface;
    SOCKADDR_STORAGE_LH gr_group;
}

struct group_source_req
{
    uint                gsr_interface;
    SOCKADDR_STORAGE_LH gsr_group;
    SOCKADDR_STORAGE_LH gsr_source;
}

struct group_filter
{
    uint                gf_interface;
    SOCKADDR_STORAGE_LH gf_group;
    MULTICAST_MODE_TYPE gf_fmode;
    uint                gf_numsrc;
    SOCKADDR_STORAGE_LH[1] gf_slist;
}

struct in_pktinfo
{
    in_addr ipi_addr;
    uint    ipi_ifindex;
}

struct in6_pktinfo
{
    in6_addr ipi6_addr;
    uint     ipi6_ifindex;
}

struct in_pktinfo_ex
{
    in_pktinfo pkt_info;
    SCOPE_ID   scope_id;
}

struct in6_pktinfo_ex
{
    in6_pktinfo pkt_info;
    SCOPE_ID    scope_id;
}

struct in_recverr
{
    IPPROTO protocol;
    uint    info;
    ubyte   type;
    ubyte   code;
}

struct icmp_error_info
{
    SOCKADDR_INET srcaddress;
    IPPROTO       protocol;
    ubyte         type;
    ubyte         code;
}

struct RM_SEND_WINDOW
{
    uint RateKbitsPerSec;
    uint WindowSizeInMSecs;
    uint WindowSizeInBytes;
}

struct RM_SENDER_STATS
{
    ulong DataBytesSent;
    ulong TotalBytesSent;
    ulong NaksReceived;
    ulong NaksReceivedTooLate;
    ulong NumOutstandingNaks;
    ulong NumNaksAfterRData;
    ulong RepairPacketsSent;
    ulong BufferSpaceAvailable;
    ulong TrailingEdgeSeqId;
    ulong LeadingEdgeSeqId;
    ulong RateKBitsPerSecOverall;
    ulong RateKBitsPerSecLast;
    ulong TotalODataPacketsSent;
}

struct RM_RECEIVER_STATS
{
    ulong NumODataPacketsReceived;
    ulong NumRDataPacketsReceived;
    ulong NumDuplicateDataPackets;
    ulong DataBytesReceived;
    ulong TotalBytesReceived;
    ulong RateKBitsPerSecOverall;
    ulong RateKBitsPerSecLast;
    ulong TrailingEdgeSeqId;
    ulong LeadingEdgeSeqId;
    ulong AverageSequencesInWindow;
    ulong MinSequencesInWindow;
    ulong MaxSequencesInWindow;
    ulong FirstNakSequenceNumber;
    ulong NumPendingNaks;
    ulong NumOutstandingNaks;
    ulong NumDataPacketsBuffered;
    ulong TotalSelectiveNaksSent;
    ulong TotalParityNaksSent;
}

struct RM_FEC_INFO
{
    ushort FECBlockSize;
    ushort FECProActivePackets;
    ubyte  FECGroupSize;
    ubyte  fFECOnDemandParityEnabled;
}

struct IPX_ADDRESS_DATA
{
    int      adapternum;
    ubyte[4] netnum;
    ubyte[6] nodenum;
    ubyte    wan;
    ubyte    status;
    int      maxpkt;
    uint     linkspeed;
}

struct IPX_NETNUM_DATA
{
    ubyte[4] netnum;
    ushort   hopcount;
    ushort   netdelay;
    int      cardnum;
    ubyte[6] router;
}

struct IPX_SPXCONNSTATUS_DATA
{
    ubyte    ConnectionState;
    ubyte    WatchDogActive;
    ushort   LocalConnectionId;
    ushort   RemoteConnectionId;
    ushort   LocalSequenceNumber;
    ushort   LocalAckNumber;
    ushort   LocalAllocNumber;
    ushort   RemoteAckNumber;
    ushort   RemoteAllocNumber;
    ushort   LocalSocket;
    ubyte[6] ImmediateAddress;
    ubyte[4] RemoteNetwork;
    ubyte[6] RemoteNode;
    ushort   RemoteSocket;
    ushort   RetransmissionCount;
    ushort   EstimatedRoundTripDelay;
    ushort   RetransmittedPackets;
    ushort   SuppressedPacket;
}

struct LM_IRPARMS
{
    uint   nTXDataBytes;
    uint   nRXDataBytes;
    uint   nBaudRate;
    uint   thresholdTime;
    uint   discTime;
    ushort nMSLinkTurn;
    ubyte  nTXPackets;
    ubyte  nRXPackets;
}

struct SOCKADDR_IRDA
{
    ushort   irdaAddressFamily;
    ubyte[4] irdaDeviceID;
    byte[25] irdaServiceName;
}

struct WINDOWS_IRDA_DEVICE_INFO
{
    ubyte[4] irdaDeviceID;
    byte[22] irdaDeviceName;
    ubyte    irdaDeviceHints1;
    ubyte    irdaDeviceHints2;
    ubyte    irdaCharSet;
}

struct WCE_IRDA_DEVICE_INFO
{
    ubyte[4] irdaDeviceID;
    byte[22] irdaDeviceName;
    ubyte[2] Reserved;
}

struct WINDOWS_DEVICELIST
{
    uint numDevice;
    WINDOWS_IRDA_DEVICE_INFO[1] Device;
}

struct WCE_DEVICELIST
{
    uint numDevice;
    WCE_IRDA_DEVICE_INFO[1] Device;
}

struct WINDOWS_IAS_SET
{
    byte[64]  irdaClassName;
    byte[256] irdaAttribName;
    uint      irdaAttribType;
    union irdaAttribute
    {
        int irdaAttribInt;
        struct irdaAttribOctetSeq
        {
            ushort      Len;
            ubyte[1024] OctetSeq;
        }
        struct irdaAttribUsrStr
        {
            ubyte      Len;
            ubyte      CharSet;
            ubyte[256] UsrStr;
        }
    }
}

struct WINDOWS_IAS_QUERY
{
    ubyte[4]  irdaDeviceID;
    byte[64]  irdaClassName;
    byte[256] irdaAttribName;
    uint      irdaAttribType;
    union irdaAttribute
    {
        int irdaAttribInt;
        struct irdaAttribOctetSeq
        {
            uint        Len;
            ubyte[1024] OctetSeq;
        }
        struct irdaAttribUsrStr
        {
            uint       Len;
            uint       CharSet;
            ubyte[256] UsrStr;
        }
    }
}

struct NL_PATH_BANDWIDTH_ROD
{
    ulong Bandwidth;
    ulong Instability;
    ubyte BandwidthPeaked;
}

struct TRANSPORT_SETTING_ID
{
    GUID Guid;
}

struct tcp_keepalive
{
    uint onoff;
    uint keepalivetime;
    uint keepaliveinterval;
}

struct REAL_TIME_NOTIFICATION_SETTING_INPUT
{
    TRANSPORT_SETTING_ID TransportSettingId;
    GUID                 BrokerEventGuid;
}

struct REAL_TIME_NOTIFICATION_SETTING_INPUT_EX
{
    TRANSPORT_SETTING_ID TransportSettingId;
    GUID                 BrokerEventGuid;
    ubyte                Unmark;
}

struct REAL_TIME_NOTIFICATION_SETTING_OUTPUT
{
    CONTROL_CHANNEL_TRIGGER_STATUS ChannelStatus;
}

struct ASSOCIATE_NAMERES_CONTEXT_INPUT
{
    TRANSPORT_SETTING_ID TransportSettingId;
    ulong                Handle;
}

struct RCVALL_IF
{
    RCVALL_VALUE Mode;
    uint         Interface;
}

struct TCP_INITIAL_RTO_PARAMETERS
{
    ushort Rtt;
    ubyte  MaxSynRetransmissions;
}

struct TCP_ICW_PARAMETERS
{
    TCP_ICW_LEVEL Level;
}

struct TCP_ACK_FREQUENCY_PARAMETERS
{
    ubyte TcpDelayedAckFrequency;
}

struct TCP_INFO_v0
{
    TCPSTATE State;
    uint     Mss;
    ulong    ConnectionTimeMs;
    ubyte    TimestampsEnabled;
    uint     RttUs;
    uint     MinRttUs;
    uint     BytesInFlight;
    uint     Cwnd;
    uint     SndWnd;
    uint     RcvWnd;
    uint     RcvBuf;
    ulong    BytesOut;
    ulong    BytesIn;
    uint     BytesReordered;
    uint     BytesRetrans;
    uint     FastRetrans;
    uint     DupAcksIn;
    uint     TimeoutEpisodes;
    ubyte    SynRetrans;
}

struct TCP_INFO_v1
{
    TCPSTATE State;
    uint     Mss;
    ulong    ConnectionTimeMs;
    ubyte    TimestampsEnabled;
    uint     RttUs;
    uint     MinRttUs;
    uint     BytesInFlight;
    uint     Cwnd;
    uint     SndWnd;
    uint     RcvWnd;
    uint     RcvBuf;
    ulong    BytesOut;
    ulong    BytesIn;
    uint     BytesReordered;
    uint     BytesRetrans;
    uint     FastRetrans;
    uint     DupAcksIn;
    uint     TimeoutEpisodes;
    ubyte    SynRetrans;
    uint     SndLimTransRwin;
    uint     SndLimTimeRwin;
    ulong    SndLimBytesRwin;
    uint     SndLimTransCwnd;
    uint     SndLimTimeCwnd;
    ulong    SndLimBytesCwnd;
    uint     SndLimTransSnd;
    uint     SndLimTimeSnd;
    ulong    SndLimBytesSnd;
}

struct INET_PORT_RANGE
{
    ushort StartPort;
    ushort NumberOfPorts;
}

struct INET_PORT_RESERVATION_TOKEN
{
    ulong Token;
}

struct INET_PORT_RESERVATION_INSTANCE
{
    INET_PORT_RANGE Reservation;
    INET_PORT_RESERVATION_TOKEN Token;
}

struct INET_PORT_RESERVATION_INFORMATION
{
    uint OwningPid;
}

struct SOCKET_SECURITY_SETTINGS
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    uint SecurityFlags;
}

struct SOCKET_SECURITY_SETTINGS_IPSEC
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    uint      SecurityFlags;
    uint      IpsecFlags;
    GUID      AuthipMMPolicyKey;
    GUID      AuthipQMPolicyKey;
    GUID      Reserved;
    ulong     Reserved2;
    uint      UserNameStringLen;
    uint      DomainNameStringLen;
    uint      PasswordStringLen;
    ushort[1] AllStrings;
}

struct SOCKET_PEER_TARGET_NAME
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    SOCKADDR_STORAGE_LH PeerAddress;
    uint                PeerTargetNameStringLen;
    ushort[1]           AllStrings;
}

struct SOCKET_SECURITY_QUERY_TEMPLATE
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    SOCKADDR_STORAGE_LH PeerAddress;
    uint                PeerTokenAccessMask;
}

struct SOCKET_SECURITY_QUERY_TEMPLATE_IPSEC2
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    SOCKADDR_STORAGE_LH PeerAddress;
    uint                PeerTokenAccessMask;
    uint                Flags;
    uint                FieldMask;
}

struct SOCKET_SECURITY_QUERY_INFO
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    uint  Flags;
    ulong PeerApplicationAccessTokenHandle;
    ulong PeerMachineAccessTokenHandle;
}

struct SOCKET_SECURITY_QUERY_INFO_IPSEC2
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    uint  Flags;
    ulong PeerApplicationAccessTokenHandle;
    ulong PeerMachineAccessTokenHandle;
    ulong MmSaId;
    ulong QmSaId;
    uint  NegotiationWinerr;
    GUID  SaLookupContext;
}

struct RSS_SCALABILITY_INFO
{
    ubyte RssEnabled;
}

struct WSA_COMPATIBILITY_MODE
{
    WSA_COMPATIBILITY_BEHAVIOR_ID BehaviorId;
    uint TargetOsVersion;
}

struct RIO_BUFFERID_t
{
}

struct RIO_CQ_t
{
}

struct RIO_RQ_t
{
}

struct RIORESULT
{
    int   Status;
    uint  BytesTransferred;
    ulong SocketContext;
    ulong RequestContext;
}

struct RIO_BUF
{
    RIO_BUFFERID_t* BufferId;
    uint            Offset;
    uint            Length;
}

struct RIO_CMSG_BUFFER
{
    uint TotalLength;
}

struct ATM_ADDRESS
{
    uint      AddressType;
    uint      NumofDigits;
    ubyte[20] Addr;
}

struct ATM_BLLI
{
    uint     Layer2Protocol;
    uint     Layer2UserSpecifiedProtocol;
    uint     Layer3Protocol;
    uint     Layer3UserSpecifiedProtocol;
    uint     Layer3IPI;
    ubyte[5] SnapID;
}

struct ATM_BHLI
{
    uint     HighLayerInfoType;
    uint     HighLayerInfoLength;
    ubyte[8] HighLayerInfo;
}

struct sockaddr_atm
{
    ushort      satm_family;
    ATM_ADDRESS satm_number;
    ATM_BLLI    satm_blli;
    ATM_BHLI    satm_bhli;
}

struct Q2931_IE
{
    Q2931_IE_TYPE IEType;
    uint          IELength;
    ubyte[1]      IE;
}

struct AAL5_PARAMETERS
{
    uint  ForwardMaxCPCSSDUSize;
    uint  BackwardMaxCPCSSDUSize;
    ubyte Mode;
    ubyte SSCSType;
}

struct AALUSER_PARAMETERS
{
    uint UserDefined;
}

struct AAL_PARAMETERS_IE
{
    AAL_TYPE AALType;
    union AALSpecificParameters
    {
        AAL5_PARAMETERS    AAL5Parameters;
        AALUSER_PARAMETERS AALUserParameters;
    }
}

struct ATM_TD
{
    uint PeakCellRate_CLP0;
    uint PeakCellRate_CLP01;
    uint SustainableCellRate_CLP0;
    uint SustainableCellRate_CLP01;
    uint MaxBurstSize_CLP0;
    uint MaxBurstSize_CLP01;
    BOOL Tagging;
}

struct ATM_TRAFFIC_DESCRIPTOR_IE
{
    ATM_TD Forward;
    ATM_TD Backward;
    BOOL   BestEffort;
}

struct ATM_BROADBAND_BEARER_CAPABILITY_IE
{
    ubyte BearerClass;
    ubyte TrafficType;
    ubyte TimingRequirements;
    ubyte ClippingSusceptability;
    ubyte UserPlaneConnectionConfig;
}

struct ATM_BLLI_IE
{
    uint     Layer2Protocol;
    ubyte    Layer2Mode;
    ubyte    Layer2WindowSize;
    uint     Layer2UserSpecifiedProtocol;
    uint     Layer3Protocol;
    ubyte    Layer3Mode;
    ubyte    Layer3DefaultPacketSize;
    ubyte    Layer3PacketWindowSize;
    uint     Layer3UserSpecifiedProtocol;
    uint     Layer3IPI;
    ubyte[5] SnapID;
}

struct ATM_CALLING_PARTY_NUMBER_IE
{
    ATM_ADDRESS ATM_Number;
    ubyte       Presentation_Indication;
    ubyte       Screening_Indicator;
}

struct ATM_CAUSE_IE
{
    ubyte    Location;
    ubyte    Cause;
    ubyte    DiagnosticsLength;
    ubyte[4] Diagnostics;
}

struct ATM_QOS_CLASS_IE
{
    ubyte QOSClassForward;
    ubyte QOSClassBackward;
}

struct ATM_TRANSIT_NETWORK_SELECTION_IE
{
    ubyte    TypeOfNetworkId;
    ubyte    NetworkIdPlan;
    ubyte    NetworkIdLength;
    ubyte[1] NetworkId;
}

struct ATM_CONNECTION_ID
{
    uint DeviceNumber;
    uint VPI;
    uint VCI;
}

struct ATM_PVC_PARAMS
{
    ATM_CONNECTION_ID PvcConnectionId;
    QOS               PvcQos;
}

struct NAPI_DOMAIN_DESCRIPTION_BLOB
{
    uint AuthLevel;
    uint cchDomainName;
    uint OffsetNextDomainDescription;
    uint OffsetThisDomainName;
}

struct NAPI_PROVIDER_INSTALLATION_BLOB
{
    uint dwVersion;
    uint dwProviderType;
    uint fSupportsWildCard;
    uint cDomains;
    uint OffsetFirstDomain;
}

struct TRANSMIT_FILE_BUFFERS
{
    void* Head;
    uint  HeadLength;
    void* Tail;
    uint  TailLength;
}

struct TRANSMIT_PACKETS_ELEMENT
{
    uint dwElFlags;
    uint cLength;
    union
    {
        struct
        {
            LARGE_INTEGER nFileOffset;
            HANDLE        hFile;
        }
        void* pBuffer;
    }
}

struct NLA_BLOB
{
    struct header
    {
        NLA_BLOB_DATA_TYPE type;
        uint               dwSize;
        uint               nextOffset;
    }
    union data
    {
        byte[1] rawData;
        struct interfaceData
        {
            uint    dwType;
            uint    dwSpeed;
            byte[1] adapterName;
        }
        struct locationData
        {
            byte[1] information;
        }
        struct connectivity
        {
            NLA_CONNECTIVITY_TYPE type;
            NLA_INTERNET internet;
        }
        struct ICS
        {
            struct remote
            {
                uint        speed;
                uint        type;
                uint        state;
                ushort[256] machineName;
                ushort[256] sharedAdapterName;
            }
        }
    }
}

struct WSAPOLLDATA
{
    int          result;
    uint         fds;
    int          timeout;
    WSAPOLLFD[1] fdArray;
}

struct WSASENDMSG
{
    WSAMSG*     lpMsg;
    uint        dwFlags;
    uint*       lpNumberOfBytesSent;
    OVERLAPPED* lpOverlapped;
    LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine;
}

struct RIO_NOTIFICATION_COMPLETION
{
    RIO_NOTIFICATION_COMPLETION_TYPE Type;
    union
    {
        struct Event
        {
            HANDLE EventHandle;
            BOOL   NotifyReset;
        }
        struct Iocp
        {
            HANDLE IocpHandle;
            void*  CompletionKey;
            void*  Overlapped;
        }
    }
}

struct RIO_EXTENSION_FUNCTION_TABLE
{
    uint              cbSize;
    LPFN_RIORECEIVE   RIOReceive;
    LPFN_RIORECEIVEEX RIOReceiveEx;
    LPFN_RIOSEND      RIOSend;
    LPFN_RIOSENDEX    RIOSendEx;
    LPFN_RIOCLOSECOMPLETIONQUEUE RIOCloseCompletionQueue;
    LPFN_RIOCREATECOMPLETIONQUEUE RIOCreateCompletionQueue;
    LPFN_RIOCREATEREQUESTQUEUE RIOCreateRequestQueue;
    LPFN_RIODEQUEUECOMPLETION RIODequeueCompletion;
    LPFN_RIODEREGISTERBUFFER RIODeregisterBuffer;
    LPFN_RIONOTIFY    RIONotify;
    LPFN_RIOREGISTERBUFFER RIORegisterBuffer;
    LPFN_RIORESIZECOMPLETIONQUEUE RIOResizeCompletionQueue;
    LPFN_RIORESIZEREQUESTQUEUE RIOResizeRequestQueue;
}

struct WSPData
{
    ushort      wVersion;
    ushort      wHighVersion;
    ushort[256] szDescription;
}

struct WSATHREADID
{
    HANDLE ThreadHandle;
    size_t Reserved;
}

struct WSPPROC_TABLE
{
    LPWSPACCEPT          lpWSPAccept;
    LPWSPADDRESSTOSTRING lpWSPAddressToString;
    LPWSPASYNCSELECT     lpWSPAsyncSelect;
    LPWSPBIND            lpWSPBind;
    LPWSPCANCELBLOCKINGCALL lpWSPCancelBlockingCall;
    LPWSPCLEANUP         lpWSPCleanup;
    LPWSPCLOSESOCKET     lpWSPCloseSocket;
    LPWSPCONNECT         lpWSPConnect;
    LPWSPDUPLICATESOCKET lpWSPDuplicateSocket;
    LPWSPENUMNETWORKEVENTS lpWSPEnumNetworkEvents;
    LPWSPEVENTSELECT     lpWSPEventSelect;
    LPWSPGETOVERLAPPEDRESULT lpWSPGetOverlappedResult;
    LPWSPGETPEERNAME     lpWSPGetPeerName;
    LPWSPGETSOCKNAME     lpWSPGetSockName;
    LPWSPGETSOCKOPT      lpWSPGetSockOpt;
    LPWSPGETQOSBYNAME    lpWSPGetQOSByName;
    LPWSPIOCTL           lpWSPIoctl;
    LPWSPJOINLEAF        lpWSPJoinLeaf;
    LPWSPLISTEN          lpWSPListen;
    LPWSPRECV            lpWSPRecv;
    LPWSPRECVDISCONNECT  lpWSPRecvDisconnect;
    LPWSPRECVFROM        lpWSPRecvFrom;
    LPWSPSELECT          lpWSPSelect;
    LPWSPSEND            lpWSPSend;
    LPWSPSENDDISCONNECT  lpWSPSendDisconnect;
    LPWSPSENDTO          lpWSPSendTo;
    LPWSPSETSOCKOPT      lpWSPSetSockOpt;
    LPWSPSHUTDOWN        lpWSPShutdown;
    LPWSPSOCKET          lpWSPSocket;
    LPWSPSTRINGTOADDRESS lpWSPStringToAddress;
}

struct WSPUPCALLTABLE
{
    LPWPUCLOSEEVENT      lpWPUCloseEvent;
    LPWPUCLOSESOCKETHANDLE lpWPUCloseSocketHandle;
    LPWPUCREATEEVENT     lpWPUCreateEvent;
    LPWPUCREATESOCKETHANDLE lpWPUCreateSocketHandle;
    LPWPUFDISSET         lpWPUFDIsSet;
    LPWPUGETPROVIDERPATH lpWPUGetProviderPath;
    LPWPUMODIFYIFSHANDLE lpWPUModifyIFSHandle;
    LPWPUPOSTMESSAGE     lpWPUPostMessage;
    LPWPUQUERYBLOCKINGCALLBACK lpWPUQueryBlockingCallback;
    LPWPUQUERYSOCKETHANDLECONTEXT lpWPUQuerySocketHandleContext;
    LPWPUQUEUEAPC        lpWPUQueueApc;
    LPWPURESETEVENT      lpWPUResetEvent;
    LPWPUSETEVENT        lpWPUSetEvent;
    LPWPUOPENCURRENTTHREAD lpWPUOpenCurrentThread;
    LPWPUCLOSETHREAD     lpWPUCloseThread;
}

struct WSC_PROVIDER_AUDIT_INFO
{
    uint  RecordSize;
    void* Reserved;
}

struct NSP_ROUTINE
{
    uint            cbSize;
    uint            dwMajorVersion;
    uint            dwMinorVersion;
    LPNSPCLEANUP    NSPCleanup;
    LPNSPLOOKUPSERVICEBEGIN NSPLookupServiceBegin;
    LPNSPLOOKUPSERVICENEXT NSPLookupServiceNext;
    LPNSPLOOKUPSERVICEEND NSPLookupServiceEnd;
    LPNSPSETSERVICE NSPSetService;
    LPNSPINSTALLSERVICECLASS NSPInstallServiceClass;
    LPNSPREMOVESERVICECLASS NSPRemoveServiceClass;
    LPNSPGETSERVICECLASSINFO NSPGetServiceClassInfo;
    LPNSPIOCTL      NSPIoctl;
}

struct NSPV2_ROUTINE
{
    uint                cbSize;
    uint                dwMajorVersion;
    uint                dwMinorVersion;
    LPNSPV2STARTUP      NSPv2Startup;
    LPNSPV2CLEANUP      NSPv2Cleanup;
    LPNSPV2LOOKUPSERVICEBEGIN NSPv2LookupServiceBegin;
    LPNSPV2LOOKUPSERVICENEXTEX NSPv2LookupServiceNextEx;
    LPNSPV2LOOKUPSERVICEEND NSPv2LookupServiceEnd;
    LPNSPV2SETSERVICEEX NSPv2SetServiceEx;
    LPNSPV2CLIENTSESSIONRUNDOWN NSPv2ClientSessionRundown;
}

struct NS_INFOA
{
    uint         dwNameSpace;
    uint         dwNameSpaceFlags;
    const(char)* lpNameSpace;
}

struct NS_INFOW
{
    uint          dwNameSpace;
    uint          dwNameSpaceFlags;
    const(wchar)* lpNameSpace;
}

struct SERVICE_TYPE_VALUE
{
    uint dwNameSpace;
    uint dwValueType;
    uint dwValueSize;
    uint dwValueNameOffset;
    uint dwValueOffset;
}

struct SERVICE_TYPE_VALUE_ABSA
{
    uint         dwNameSpace;
    uint         dwValueType;
    uint         dwValueSize;
    const(char)* lpValueName;
    void*        lpValue;
}

struct SERVICE_TYPE_VALUE_ABSW
{
    uint          dwNameSpace;
    uint          dwValueType;
    uint          dwValueSize;
    const(wchar)* lpValueName;
    void*         lpValue;
}

struct SERVICE_TYPE_INFO
{
    uint dwTypeNameOffset;
    uint dwValueCount;
    SERVICE_TYPE_VALUE[1] Values;
}

struct SERVICE_TYPE_INFO_ABSA
{
    const(char)* lpTypeName;
    uint         dwValueCount;
    SERVICE_TYPE_VALUE_ABSA[1] Values;
}

struct SERVICE_TYPE_INFO_ABSW
{
    const(wchar)* lpTypeName;
    uint          dwValueCount;
    SERVICE_TYPE_VALUE_ABSW[1] Values;
}

struct SERVICE_ADDRESS
{
    uint   dwAddressType;
    uint   dwAddressFlags;
    uint   dwAddressLength;
    uint   dwPrincipalLength;
    ubyte* lpAddress;
    ubyte* lpPrincipal;
}

struct SERVICE_ADDRESSES
{
    uint               dwAddressCount;
    SERVICE_ADDRESS[1] Addresses;
}

struct SERVICE_INFOA
{
    GUID*              lpServiceType;
    const(char)*       lpServiceName;
    const(char)*       lpComment;
    const(char)*       lpLocale;
    uint               dwDisplayHint;
    uint               dwVersion;
    uint               dwTime;
    const(char)*       lpMachineName;
    SERVICE_ADDRESSES* lpServiceAddress;
    BLOB               ServiceSpecificInfo;
}

struct SERVICE_INFOW
{
    GUID*              lpServiceType;
    const(wchar)*      lpServiceName;
    const(wchar)*      lpComment;
    const(wchar)*      lpLocale;
    uint               dwDisplayHint;
    uint               dwVersion;
    uint               dwTime;
    const(wchar)*      lpMachineName;
    SERVICE_ADDRESSES* lpServiceAddress;
    BLOB               ServiceSpecificInfo;
}

struct NS_SERVICE_INFOA
{
    uint          dwNameSpace;
    SERVICE_INFOA ServiceInfo;
}

struct NS_SERVICE_INFOW
{
    uint          dwNameSpace;
    SERVICE_INFOW ServiceInfo;
}

struct PROTOCOL_INFOA
{
    uint         dwServiceFlags;
    int          iAddressFamily;
    int          iMaxSockAddr;
    int          iMinSockAddr;
    int          iSocketType;
    int          iProtocol;
    uint         dwMessageSize;
    const(char)* lpProtocol;
}

struct PROTOCOL_INFOW
{
    uint          dwServiceFlags;
    int           iAddressFamily;
    int           iMaxSockAddr;
    int           iMinSockAddr;
    int           iSocketType;
    int           iProtocol;
    uint          dwMessageSize;
    const(wchar)* lpProtocol;
}

struct NETRESOURCE2A
{
    uint         dwScope;
    uint         dwType;
    uint         dwUsage;
    uint         dwDisplayType;
    const(char)* lpLocalName;
    const(char)* lpRemoteName;
    const(char)* lpComment;
    NS_INFOA     ns_info;
    GUID         ServiceType;
    uint         dwProtocols;
    int*         lpiProtocols;
}

struct NETRESOURCE2W
{
    uint          dwScope;
    uint          dwType;
    uint          dwUsage;
    uint          dwDisplayType;
    const(wchar)* lpLocalName;
    const(wchar)* lpRemoteName;
    const(wchar)* lpComment;
    NS_INFOA      ns_info;
    GUID          ServiceType;
    uint          dwProtocols;
    int*          lpiProtocols;
}

struct SERVICE_ASYNC_INFO
{
    LPSERVICE_CALLBACK_PROC lpServiceCallbackProc;
    LPARAM lParam;
    HANDLE hAsyncTaskHandle;
}

// Functions

@DllImport("WS2_32")
int __WSAFDIsSet(size_t fd, fd_set* param1);

@DllImport("WS2_32")
size_t accept(size_t s, char* addr, int* addrlen);

@DllImport("WS2_32")
int bind(size_t s, char* name, int namelen);

@DllImport("WS2_32")
int closesocket(size_t s);

@DllImport("WS2_32")
int connect(size_t s, char* name, int namelen);

@DllImport("WS2_32")
int ioctlsocket(size_t s, int cmd, uint* argp);

@DllImport("WS2_32")
int getpeername(size_t s, char* name, int* namelen);

@DllImport("WS2_32")
int getsockname(size_t s, char* name, int* namelen);

@DllImport("WS2_32")
int getsockopt(size_t s, int level, int optname, char* optval, int* optlen);

@DllImport("WS2_32")
uint htonl(uint hostlong);

@DllImport("WS2_32")
ushort htons(ushort hostshort);

@DllImport("WS2_32")
uint inet_addr(const(byte)* cp);

@DllImport("WS2_32")
byte* inet_ntoa(in_addr in_);

@DllImport("WS2_32")
int listen(size_t s, int backlog);

@DllImport("WS2_32")
uint ntohl(uint netlong);

@DllImport("WS2_32")
ushort ntohs(ushort netshort);

@DllImport("WS2_32")
int recv(size_t s, char* buf, int len, int flags);

@DllImport("WS2_32")
int recvfrom(size_t s, char* buf, int len, int flags, char* from, int* fromlen);

@DllImport("WS2_32")
int select(int nfds, fd_set* readfds, fd_set* writefds, fd_set* exceptfds, const(timeval)* timeout);

@DllImport("WS2_32")
int send(size_t s, char* buf, int len, int flags);

@DllImport("WS2_32")
int sendto(size_t s, char* buf, int len, int flags, char* to, int tolen);

@DllImport("WS2_32")
int setsockopt(size_t s, int level, int optname, char* optval, int optlen);

@DllImport("WS2_32")
int shutdown(size_t s, int how);

@DllImport("WS2_32")
size_t socket(int af, int type, int protocol);

@DllImport("WS2_32")
hostent* gethostbyaddr(char* addr, int len, int type);

@DllImport("WS2_32")
hostent* gethostbyname(const(byte)* name);

@DllImport("WS2_32")
int gethostname(char* name, int namelen);

@DllImport("WS2_32")
int GetHostNameW(const(wchar)* name, int namelen);

@DllImport("WS2_32")
servent* getservbyport(int port, const(byte)* proto);

@DllImport("WS2_32")
servent* getservbyname(const(byte)* name, const(byte)* proto);

@DllImport("WS2_32")
protoent* getprotobynumber(int number);

@DllImport("WS2_32")
protoent* getprotobyname(const(byte)* name);

@DllImport("WS2_32")
int WSAStartup(ushort wVersionRequested, WSAData* lpWSAData);

@DllImport("WS2_32")
int WSACleanup();

@DllImport("WS2_32")
void WSASetLastError(int iError);

@DllImport("WS2_32")
int WSAGetLastError();

@DllImport("WS2_32")
BOOL WSAIsBlocking();

@DllImport("WS2_32")
int WSAUnhookBlockingHook();

@DllImport("WS2_32")
FARPROC WSASetBlockingHook(FARPROC lpBlockFunc);

@DllImport("WS2_32")
int WSACancelBlockingCall();

@DllImport("WS2_32")
HANDLE WSAAsyncGetServByName(HWND hWnd, uint wMsg, const(byte)* name, const(byte)* proto, char* buf, int buflen);

@DllImport("WS2_32")
HANDLE WSAAsyncGetServByPort(HWND hWnd, uint wMsg, int port, const(byte)* proto, char* buf, int buflen);

@DllImport("WS2_32")
HANDLE WSAAsyncGetProtoByName(HWND hWnd, uint wMsg, const(byte)* name, char* buf, int buflen);

@DllImport("WS2_32")
HANDLE WSAAsyncGetProtoByNumber(HWND hWnd, uint wMsg, int number, char* buf, int buflen);

@DllImport("WS2_32")
HANDLE WSAAsyncGetHostByName(HWND hWnd, uint wMsg, const(byte)* name, char* buf, int buflen);

@DllImport("WS2_32")
HANDLE WSAAsyncGetHostByAddr(HWND hWnd, uint wMsg, char* addr, int len, int type, char* buf, int buflen);

@DllImport("WS2_32")
int WSACancelAsyncRequest(HANDLE hAsyncTaskHandle);

@DllImport("WS2_32")
int WSAAsyncSelect(size_t s, HWND hWnd, uint wMsg, int lEvent);

@DllImport("WS2_32")
size_t WSAAccept(size_t s, char* addr, int* addrlen, LPCONDITIONPROC lpfnCondition, size_t dwCallbackData);

@DllImport("WS2_32")
BOOL WSACloseEvent(HANDLE hEvent);

@DllImport("WS2_32")
int WSAConnect(size_t s, char* name, int namelen, WSABUF* lpCallerData, WSABUF* lpCalleeData, QOS* lpSQOS, 
               QOS* lpGQOS);

@DllImport("WS2_32")
BOOL WSAConnectByNameW(size_t s, const(wchar)* nodename, const(wchar)* servicename, uint* LocalAddressLength, 
                       char* LocalAddress, uint* RemoteAddressLength, char* RemoteAddress, const(timeval)* timeout, 
                       OVERLAPPED* Reserved);

@DllImport("WS2_32")
BOOL WSAConnectByNameA(size_t s, const(char)* nodename, const(char)* servicename, uint* LocalAddressLength, 
                       char* LocalAddress, uint* RemoteAddressLength, char* RemoteAddress, const(timeval)* timeout, 
                       OVERLAPPED* Reserved);

@DllImport("WS2_32")
BOOL WSAConnectByList(size_t s, SOCKET_ADDRESS_LIST* SocketAddress, uint* LocalAddressLength, char* LocalAddress, 
                      uint* RemoteAddressLength, char* RemoteAddress, const(timeval)* timeout, OVERLAPPED* Reserved);

@DllImport("WS2_32")
HANDLE WSACreateEvent();

@DllImport("WS2_32")
int WSADuplicateSocketA(size_t s, uint dwProcessId, WSAPROTOCOL_INFOA* lpProtocolInfo);

@DllImport("WS2_32")
int WSADuplicateSocketW(size_t s, uint dwProcessId, WSAPROTOCOL_INFOW* lpProtocolInfo);

@DllImport("WS2_32")
int WSAEnumNetworkEvents(size_t s, HANDLE hEventObject, WSANETWORKEVENTS* lpNetworkEvents);

@DllImport("WS2_32")
int WSAEnumProtocolsA(int* lpiProtocols, char* lpProtocolBuffer, uint* lpdwBufferLength);

@DllImport("WS2_32")
int WSAEnumProtocolsW(int* lpiProtocols, char* lpProtocolBuffer, uint* lpdwBufferLength);

@DllImport("WS2_32")
int WSAEventSelect(size_t s, HANDLE hEventObject, int lNetworkEvents);

@DllImport("WS2_32")
BOOL WSAGetOverlappedResult(size_t s, OVERLAPPED* lpOverlapped, uint* lpcbTransfer, BOOL fWait, uint* lpdwFlags);

@DllImport("WS2_32")
BOOL WSAGetQOSByName(size_t s, WSABUF* lpQOSName, QOS* lpQOS);

@DllImport("WS2_32")
int WSAHtonl(size_t s, uint hostlong, uint* lpnetlong);

@DllImport("WS2_32")
int WSAHtons(size_t s, ushort hostshort, ushort* lpnetshort);

@DllImport("WS2_32")
int WSAIoctl(size_t s, uint dwIoControlCode, char* lpvInBuffer, uint cbInBuffer, char* lpvOutBuffer, 
             uint cbOutBuffer, uint* lpcbBytesReturned, OVERLAPPED* lpOverlapped, 
             LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

@DllImport("WS2_32")
size_t WSAJoinLeaf(size_t s, char* name, int namelen, WSABUF* lpCallerData, WSABUF* lpCalleeData, QOS* lpSQOS, 
                   QOS* lpGQOS, uint dwFlags);

@DllImport("WS2_32")
int WSANtohl(size_t s, uint netlong, uint* lphostlong);

@DllImport("WS2_32")
int WSANtohs(size_t s, ushort netshort, ushort* lphostshort);

@DllImport("WS2_32")
int WSARecv(size_t s, char* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesRecvd, uint* lpFlags, 
            OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

@DllImport("WS2_32")
int WSARecvDisconnect(size_t s, WSABUF* lpInboundDisconnectData);

@DllImport("WS2_32")
int WSARecvFrom(size_t s, char* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesRecvd, uint* lpFlags, 
                char* lpFrom, int* lpFromlen, OVERLAPPED* lpOverlapped, 
                LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

@DllImport("WS2_32")
BOOL WSAResetEvent(HANDLE hEvent);

@DllImport("WS2_32")
int WSASend(size_t s, char* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesSent, uint dwFlags, 
            OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

@DllImport("WS2_32")
int WSASendMsg(size_t Handle, WSAMSG* lpMsg, uint dwFlags, uint* lpNumberOfBytesSent, OVERLAPPED* lpOverlapped, 
               LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

@DllImport("WS2_32")
int WSASendDisconnect(size_t s, WSABUF* lpOutboundDisconnectData);

@DllImport("WS2_32")
int WSASendTo(size_t s, char* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesSent, uint dwFlags, char* lpTo, 
              int iTolen, OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

@DllImport("WS2_32")
BOOL WSASetEvent(HANDLE hEvent);

@DllImport("WS2_32")
size_t WSASocketA(int af, int type, int protocol, WSAPROTOCOL_INFOA* lpProtocolInfo, uint g, uint dwFlags);

@DllImport("WS2_32")
size_t WSASocketW(int af, int type, int protocol, WSAPROTOCOL_INFOW* lpProtocolInfo, uint g, uint dwFlags);

@DllImport("WS2_32")
uint WSAWaitForMultipleEvents(uint cEvents, char* lphEvents, BOOL fWaitAll, uint dwTimeout, BOOL fAlertable);

@DllImport("WS2_32")
int WSAAddressToStringA(char* lpsaAddress, uint dwAddressLength, WSAPROTOCOL_INFOA* lpProtocolInfo, 
                        const(char)* lpszAddressString, uint* lpdwAddressStringLength);

@DllImport("WS2_32")
int WSAAddressToStringW(char* lpsaAddress, uint dwAddressLength, WSAPROTOCOL_INFOW* lpProtocolInfo, 
                        const(wchar)* lpszAddressString, uint* lpdwAddressStringLength);

@DllImport("WS2_32")
int WSAStringToAddressA(const(char)* AddressString, int AddressFamily, WSAPROTOCOL_INFOA* lpProtocolInfo, 
                        char* lpAddress, int* lpAddressLength);

@DllImport("WS2_32")
int WSAStringToAddressW(const(wchar)* AddressString, int AddressFamily, WSAPROTOCOL_INFOW* lpProtocolInfo, 
                        char* lpAddress, int* lpAddressLength);

@DllImport("WS2_32")
int WSALookupServiceBeginA(WSAQUERYSETA* lpqsRestrictions, uint dwControlFlags, ptrdiff_t* lphLookup);

@DllImport("WS2_32")
int WSALookupServiceBeginW(WSAQUERYSETW* lpqsRestrictions, uint dwControlFlags, ptrdiff_t* lphLookup);

@DllImport("WS2_32")
int WSALookupServiceNextA(HANDLE hLookup, uint dwControlFlags, uint* lpdwBufferLength, char* lpqsResults);

@DllImport("WS2_32")
int WSALookupServiceNextW(HANDLE hLookup, uint dwControlFlags, uint* lpdwBufferLength, char* lpqsResults);

@DllImport("WS2_32")
int WSANSPIoctl(HANDLE hLookup, uint dwControlCode, char* lpvInBuffer, uint cbInBuffer, char* lpvOutBuffer, 
                uint cbOutBuffer, uint* lpcbBytesReturned, WSACOMPLETION* lpCompletion);

@DllImport("WS2_32")
int WSALookupServiceEnd(HANDLE hLookup);

@DllImport("WS2_32")
int WSAInstallServiceClassA(WSASERVICECLASSINFOA* lpServiceClassInfo);

@DllImport("WS2_32")
int WSAInstallServiceClassW(WSASERVICECLASSINFOW* lpServiceClassInfo);

@DllImport("WS2_32")
int WSARemoveServiceClass(GUID* lpServiceClassId);

@DllImport("WS2_32")
int WSAGetServiceClassInfoA(GUID* lpProviderId, GUID* lpServiceClassId, uint* lpdwBufSize, 
                            char* lpServiceClassInfo);

@DllImport("WS2_32")
int WSAGetServiceClassInfoW(GUID* lpProviderId, GUID* lpServiceClassId, uint* lpdwBufSize, 
                            char* lpServiceClassInfo);

@DllImport("WS2_32")
int WSAEnumNameSpaceProvidersA(uint* lpdwBufferLength, char* lpnspBuffer);

@DllImport("WS2_32")
int WSAEnumNameSpaceProvidersW(uint* lpdwBufferLength, char* lpnspBuffer);

@DllImport("WS2_32")
int WSAEnumNameSpaceProvidersExA(uint* lpdwBufferLength, char* lpnspBuffer);

@DllImport("WS2_32")
int WSAEnumNameSpaceProvidersExW(uint* lpdwBufferLength, char* lpnspBuffer);

@DllImport("WS2_32")
int WSAGetServiceClassNameByClassIdA(GUID* lpServiceClassId, const(char)* lpszServiceClassName, 
                                     uint* lpdwBufferLength);

@DllImport("WS2_32")
int WSAGetServiceClassNameByClassIdW(GUID* lpServiceClassId, const(wchar)* lpszServiceClassName, 
                                     uint* lpdwBufferLength);

@DllImport("WS2_32")
int WSASetServiceA(WSAQUERYSETA* lpqsRegInfo, WSAESETSERVICEOP essoperation, uint dwControlFlags);

@DllImport("WS2_32")
int WSASetServiceW(WSAQUERYSETW* lpqsRegInfo, WSAESETSERVICEOP essoperation, uint dwControlFlags);

@DllImport("WS2_32")
int WSAProviderConfigChange(ptrdiff_t* lpNotificationHandle, OVERLAPPED* lpOverlapped, 
                            LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

@DllImport("WS2_32")
int WSAPoll(WSAPOLLFD* fdArray, uint fds, int timeout);

@DllImport("ntdll")
int RtlIpv4AddressToStringExA(const(in_addr)* Address, ushort Port, const(char)* AddressString, 
                              uint* AddressStringLength);

@DllImport("ntdll")
int RtlIpv4StringToAddressExA(const(char)* AddressString, ubyte Strict, in_addr* Address, ushort* Port);

@DllImport("ntdll")
int RtlIpv6AddressToStringExA(const(in6_addr)* Address, uint ScopeId, ushort Port, const(char)* AddressString, 
                              uint* AddressStringLength);

@DllImport("ntdll")
int RtlIpv6StringToAddressExA(const(char)* AddressString, in6_addr* Address, uint* ScopeId, ushort* Port);

@DllImport("MSWSOCK")
int WSARecvEx(size_t s, char* buf, int len, int* flags);

@DllImport("MSWSOCK")
BOOL TransmitFile(size_t hSocket, HANDLE hFile, uint nNumberOfBytesToWrite, uint nNumberOfBytesPerSend, 
                  OVERLAPPED* lpOverlapped, TRANSMIT_FILE_BUFFERS* lpTransmitBuffers, uint dwReserved);

@DllImport("MSWSOCK")
BOOL AcceptEx(size_t sListenSocket, size_t sAcceptSocket, char* lpOutputBuffer, uint dwReceiveDataLength, 
              uint dwLocalAddressLength, uint dwRemoteAddressLength, uint* lpdwBytesReceived, 
              OVERLAPPED* lpOverlapped);

@DllImport("MSWSOCK")
void GetAcceptExSockaddrs(char* lpOutputBuffer, uint dwReceiveDataLength, uint dwLocalAddressLength, 
                          uint dwRemoteAddressLength, SOCKADDR** LocalSockaddr, int* LocalSockaddrLength, 
                          SOCKADDR** RemoteSockaddr, int* RemoteSockaddrLength);

@DllImport("WS2_32")
int WSCEnumProtocols(int* lpiProtocols, char* lpProtocolBuffer, uint* lpdwBufferLength, int* lpErrno);

@DllImport("WS2_32")
int WSCDeinstallProvider(GUID* lpProviderId, int* lpErrno);

@DllImport("WS2_32")
int WSCInstallProvider(GUID* lpProviderId, const(wchar)* lpszProviderDllPath, char* lpProtocolInfoList, 
                       uint dwNumberOfEntries, int* lpErrno);

@DllImport("WS2_32")
int WSCGetProviderPath(GUID* lpProviderId, char* lpszProviderDllPath, int* lpProviderDllPathLen, int* lpErrno);

@DllImport("WS2_32")
int WSCUpdateProvider(GUID* lpProviderId, const(wchar)* lpszProviderDllPath, char* lpProtocolInfoList, 
                      uint dwNumberOfEntries, int* lpErrno);

@DllImport("WS2_32")
int WSCSetProviderInfo(GUID* lpProviderId, WSC_PROVIDER_INFO_TYPE InfoType, char* Info, size_t InfoSize, 
                       uint Flags, int* lpErrno);

@DllImport("WS2_32")
int WSCGetProviderInfo(GUID* lpProviderId, WSC_PROVIDER_INFO_TYPE InfoType, char* Info, size_t* InfoSize, 
                       uint Flags, int* lpErrno);

@DllImport("WS2_32")
int WSCSetApplicationCategory(const(wchar)* Path, uint PathLength, const(wchar)* Extra, uint ExtraLength, 
                              uint PermittedLspCategories, uint* pPrevPermLspCat, int* lpErrno);

@DllImport("WS2_32")
int WSCGetApplicationCategory(const(wchar)* Path, uint PathLength, const(wchar)* Extra, uint ExtraLength, 
                              uint* pPermittedLspCategories, int* lpErrno);

@DllImport("WS2_32")
int WPUCompleteOverlappedRequest(size_t s, OVERLAPPED* lpOverlapped, uint dwError, uint cbTransferred, 
                                 int* lpErrno);

@DllImport("WS2_32")
int WSCInstallNameSpace(const(wchar)* lpszIdentifier, const(wchar)* lpszPathName, uint dwNameSpace, uint dwVersion, 
                        GUID* lpProviderId);

@DllImport("WS2_32")
int WSCUnInstallNameSpace(GUID* lpProviderId);

@DllImport("WS2_32")
int WSCInstallNameSpaceEx(const(wchar)* lpszIdentifier, const(wchar)* lpszPathName, uint dwNameSpace, 
                          uint dwVersion, GUID* lpProviderId, BLOB* lpProviderSpecific);

@DllImport("WS2_32")
int WSCEnableNSProvider(GUID* lpProviderId, BOOL fEnable);

@DllImport("WS2_32")
int WSAAdvertiseProvider(const(GUID)* puuidProviderId, const(NSPV2_ROUTINE)* pNSPv2Routine);

@DllImport("WS2_32")
int WSAUnadvertiseProvider(const(GUID)* puuidProviderId);

@DllImport("WS2_32")
int WSAProviderCompleteAsyncCall(HANDLE hAsyncCall, int iRetCode);

@DllImport("MSWSOCK")
int EnumProtocolsA(int* lpiProtocols, char* lpProtocolBuffer, uint* lpdwBufferLength);

@DllImport("MSWSOCK")
int EnumProtocolsW(int* lpiProtocols, char* lpProtocolBuffer, uint* lpdwBufferLength);

@DllImport("MSWSOCK")
int GetAddressByNameA(uint dwNameSpace, GUID* lpServiceType, const(char)* lpServiceName, int* lpiProtocols, 
                      uint dwResolution, SERVICE_ASYNC_INFO* lpServiceAsyncInfo, char* lpCsaddrBuffer, 
                      uint* lpdwBufferLength, const(char)* lpAliasBuffer, uint* lpdwAliasBufferLength);

@DllImport("MSWSOCK")
int GetAddressByNameW(uint dwNameSpace, GUID* lpServiceType, const(wchar)* lpServiceName, int* lpiProtocols, 
                      uint dwResolution, SERVICE_ASYNC_INFO* lpServiceAsyncInfo, char* lpCsaddrBuffer, 
                      uint* lpdwBufferLength, const(wchar)* lpAliasBuffer, uint* lpdwAliasBufferLength);

@DllImport("MSWSOCK")
int GetTypeByNameA(const(char)* lpServiceName, GUID* lpServiceType);

@DllImport("MSWSOCK")
int GetTypeByNameW(const(wchar)* lpServiceName, GUID* lpServiceType);

@DllImport("MSWSOCK")
int GetNameByTypeA(GUID* lpServiceType, const(char)* lpServiceName, uint dwNameLength);

@DllImport("MSWSOCK")
int GetNameByTypeW(GUID* lpServiceType, const(wchar)* lpServiceName, uint dwNameLength);

@DllImport("MSWSOCK")
int SetServiceA(uint dwNameSpace, uint dwOperation, uint dwFlags, SERVICE_INFOA* lpServiceInfo, 
                SERVICE_ASYNC_INFO* lpServiceAsyncInfo, uint* lpdwStatusFlags);

@DllImport("MSWSOCK")
int SetServiceW(uint dwNameSpace, uint dwOperation, uint dwFlags, SERVICE_INFOW* lpServiceInfo, 
                SERVICE_ASYNC_INFO* lpServiceAsyncInfo, uint* lpdwStatusFlags);

@DllImport("MSWSOCK")
int GetServiceA(uint dwNameSpace, GUID* lpGuid, const(char)* lpServiceName, uint dwProperties, char* lpBuffer, 
                uint* lpdwBufferSize, SERVICE_ASYNC_INFO* lpServiceAsyncInfo);

@DllImport("MSWSOCK")
int GetServiceW(uint dwNameSpace, GUID* lpGuid, const(wchar)* lpServiceName, uint dwProperties, char* lpBuffer, 
                uint* lpdwBufferSize, SERVICE_ASYNC_INFO* lpServiceAsyncInfo);

@DllImport("WS2_32")
int getaddrinfo(const(char)* pNodeName, const(char)* pServiceName, const(ADDRINFOA)* pHints, ADDRINFOA** ppResult);

@DllImport("WS2_32")
int GetAddrInfoW(const(wchar)* pNodeName, const(wchar)* pServiceName, const(addrinfoW)* pHints, 
                 addrinfoW** ppResult);

@DllImport("WS2_32")
int GetAddrInfoExA(const(char)* pName, const(char)* pServiceName, uint dwNameSpace, GUID* lpNspId, 
                   const(addrinfoexA)* hints, addrinfoexA** ppResult, timeval* timeout, OVERLAPPED* lpOverlapped, 
                   LPLOOKUPSERVICE_COMPLETION_ROUTINE lpCompletionRoutine, ptrdiff_t* lpNameHandle);

@DllImport("WS2_32")
int GetAddrInfoExW(const(wchar)* pName, const(wchar)* pServiceName, uint dwNameSpace, GUID* lpNspId, 
                   const(addrinfoexW)* hints, addrinfoexW** ppResult, timeval* timeout, OVERLAPPED* lpOverlapped, 
                   LPLOOKUPSERVICE_COMPLETION_ROUTINE lpCompletionRoutine, ptrdiff_t* lpHandle);

@DllImport("WS2_32")
int GetAddrInfoExCancel(ptrdiff_t* lpHandle);

@DllImport("WS2_32")
int GetAddrInfoExOverlappedResult(OVERLAPPED* lpOverlapped);

@DllImport("WS2_32")
int SetAddrInfoExA(const(char)* pName, const(char)* pServiceName, SOCKET_ADDRESS* pAddresses, uint dwAddressCount, 
                   BLOB* lpBlob, uint dwFlags, uint dwNameSpace, GUID* lpNspId, timeval* timeout, 
                   OVERLAPPED* lpOverlapped, LPLOOKUPSERVICE_COMPLETION_ROUTINE lpCompletionRoutine, 
                   ptrdiff_t* lpNameHandle);

@DllImport("WS2_32")
int SetAddrInfoExW(const(wchar)* pName, const(wchar)* pServiceName, SOCKET_ADDRESS* pAddresses, 
                   uint dwAddressCount, BLOB* lpBlob, uint dwFlags, uint dwNameSpace, GUID* lpNspId, 
                   timeval* timeout, OVERLAPPED* lpOverlapped, 
                   LPLOOKUPSERVICE_COMPLETION_ROUTINE lpCompletionRoutine, ptrdiff_t* lpNameHandle);

@DllImport("WS2_32")
void freeaddrinfo(ADDRINFOA* pAddrInfo);

@DllImport("WS2_32")
void FreeAddrInfoW(addrinfoW* pAddrInfo);

@DllImport("WS2_32")
void FreeAddrInfoEx(addrinfoexA* pAddrInfoEx);

@DllImport("WS2_32")
void FreeAddrInfoExW(addrinfoexW* pAddrInfoEx);

@DllImport("WS2_32")
int getnameinfo(char* pSockaddr, int SockaddrLength, const(char)* pNodeBuffer, uint NodeBufferSize, 
                const(char)* pServiceBuffer, uint ServiceBufferSize, int Flags);

@DllImport("WS2_32")
int GetNameInfoW(char* pSockaddr, int SockaddrLength, const(wchar)* pNodeBuffer, uint NodeBufferSize, 
                 const(wchar)* pServiceBuffer, uint ServiceBufferSize, int Flags);

@DllImport("WS2_32")
int inet_pton(int Family, const(char)* pszAddrString, char* pAddrBuf);

@DllImport("WS2_32")
int InetPtonW(int Family, const(wchar)* pszAddrString, char* pAddrBuf);

@DllImport("WS2_32")
byte* inet_ntop(int Family, const(void)* pAddr, const(char)* pStringBuf, size_t StringBufSize);

@DllImport("WS2_32")
ushort* InetNtopW(int Family, const(void)* pAddr, const(wchar)* pStringBuf, size_t StringBufSize);

@DllImport("fwpuclnt")
int WSASetSocketSecurity(size_t Socket, char* SecuritySettings, uint SecuritySettingsLen, OVERLAPPED* Overlapped, 
                         LPWSAOVERLAPPED_COMPLETION_ROUTINE CompletionRoutine);

@DllImport("fwpuclnt")
int WSAQuerySocketSecurity(size_t Socket, char* SecurityQueryTemplate, uint SecurityQueryTemplateLen, 
                           char* SecurityQueryInfo, uint* SecurityQueryInfoLen, OVERLAPPED* Overlapped, 
                           LPWSAOVERLAPPED_COMPLETION_ROUTINE CompletionRoutine);

@DllImport("fwpuclnt")
int WSASetSocketPeerTargetName(size_t Socket, char* PeerTargetName, uint PeerTargetNameLen, OVERLAPPED* Overlapped, 
                               LPWSAOVERLAPPED_COMPLETION_ROUTINE CompletionRoutine);

@DllImport("fwpuclnt")
int WSADeleteSocketPeerTargetName(size_t Socket, char* PeerAddr, uint PeerAddrLen, OVERLAPPED* Overlapped, 
                                  LPWSAOVERLAPPED_COMPLETION_ROUTINE CompletionRoutine);

@DllImport("fwpuclnt")
int WSAImpersonateSocketPeer(size_t Socket, char* PeerAddr, uint PeerAddrLen);

@DllImport("fwpuclnt")
int WSARevertImpersonation();

@DllImport("Windows")
HRESULT SetSocketMediaStreamingMode(BOOL value);

@DllImport("WS2_32")
int WSCWriteProviderOrder(uint* lpwdCatalogEntryId, uint dwNumberOfEntries);

@DllImport("WS2_32")
int WSCWriteNameSpaceOrder(GUID* lpProviderId, uint dwNumberOfEntries);


