module windows.rpc;

public import system;
public import windows.com;
public import windows.kernel;
public import windows.security;
public import windows.systemservices;

extern(Windows):

struct NDR_SCONTEXT_1
{
    void* pad;
    void* userContext;
}

@DllImport("RPCRT4.dll")
HRESULT IUnknown_QueryInterface_Proxy(IUnknown This, const(Guid)* riid, void** ppvObject);

@DllImport("RPCRT4.dll")
uint IUnknown_AddRef_Proxy(IUnknown This);

@DllImport("RPCRT4.dll")
uint IUnknown_Release_Proxy(IUnknown This);

@DllImport("RPCRT4.dll")
int RpcBindingCopy(void* SourceBinding, void** DestinationBinding);

@DllImport("RPCRT4.dll")
int RpcBindingFree(void** Binding);

@DllImport("RPCRT4.dll")
int RpcBindingSetOption(void* hBinding, uint option, uint optionValue);

@DllImport("RPCRT4.dll")
int RpcBindingInqOption(void* hBinding, uint option, uint* pOptionValue);

@DllImport("RPCRT4.dll")
int RpcBindingFromStringBindingA(ubyte* StringBinding, void** Binding);

@DllImport("RPCRT4.dll")
int RpcBindingFromStringBindingW(ushort* StringBinding, void** Binding);

@DllImport("RPCRT4.dll")
int RpcSsGetContextBinding(void* ContextHandle, void** Binding);

@DllImport("RPCRT4.dll")
int RpcBindingInqObject(void* Binding, Guid* ObjectUuid);

@DllImport("RPCRT4.dll")
int RpcBindingReset(void* Binding);

@DllImport("RPCRT4.dll")
int RpcBindingSetObject(void* Binding, Guid* ObjectUuid);

@DllImport("RPCRT4.dll")
int RpcMgmtInqDefaultProtectLevel(uint AuthnSvc, uint* AuthnLevel);

@DllImport("RPCRT4.dll")
int RpcBindingToStringBindingA(void* Binding, ubyte** StringBinding);

@DllImport("RPCRT4.dll")
int RpcBindingToStringBindingW(void* Binding, ushort** StringBinding);

@DllImport("RPCRT4.dll")
int RpcBindingVectorFree(RPC_BINDING_VECTOR** BindingVector);

@DllImport("RPCRT4.dll")
int RpcStringBindingComposeA(ubyte* ObjUuid, ubyte* ProtSeq, ubyte* NetworkAddr, ubyte* Endpoint, ubyte* Options, ubyte** StringBinding);

@DllImport("RPCRT4.dll")
int RpcStringBindingComposeW(ushort* ObjUuid, ushort* ProtSeq, ushort* NetworkAddr, ushort* Endpoint, ushort* Options, ushort** StringBinding);

@DllImport("RPCRT4.dll")
int RpcStringBindingParseA(ubyte* StringBinding, ubyte** ObjUuid, ubyte** Protseq, ubyte** NetworkAddr, ubyte** Endpoint, ubyte** NetworkOptions);

@DllImport("RPCRT4.dll")
int RpcStringBindingParseW(ushort* StringBinding, ushort** ObjUuid, ushort** Protseq, ushort** NetworkAddr, ushort** Endpoint, ushort** NetworkOptions);

@DllImport("RPCRT4.dll")
int RpcStringFreeA(ubyte** String);

@DllImport("RPCRT4.dll")
int RpcStringFreeW(ushort** String);

@DllImport("RPCRT4.dll")
int RpcIfInqId(void* RpcIfHandle, RPC_IF_ID* RpcIfId);

@DllImport("RPCRT4.dll")
int RpcNetworkIsProtseqValidA(ubyte* Protseq);

@DllImport("RPCRT4.dll")
int RpcNetworkIsProtseqValidW(ushort* Protseq);

@DllImport("RPCRT4.dll")
int RpcMgmtInqComTimeout(void* Binding, uint* Timeout);

@DllImport("RPCRT4.dll")
int RpcMgmtSetComTimeout(void* Binding, uint Timeout);

@DllImport("RPCRT4.dll")
int RpcMgmtSetCancelTimeout(int Timeout);

@DllImport("RPCRT4.dll")
int RpcNetworkInqProtseqsA(RPC_PROTSEQ_VECTORA** ProtseqVector);

@DllImport("RPCRT4.dll")
int RpcNetworkInqProtseqsW(RPC_PROTSEQ_VECTORW** ProtseqVector);

@DllImport("RPCRT4.dll")
int RpcObjectInqType(Guid* ObjUuid, Guid* TypeUuid);

@DllImport("RPCRT4.dll")
int RpcObjectSetInqFn(RPC_OBJECT_INQ_FN* InquiryFn);

@DllImport("RPCRT4.dll")
int RpcObjectSetType(Guid* ObjUuid, Guid* TypeUuid);

@DllImport("RPCRT4.dll")
int RpcProtseqVectorFreeA(RPC_PROTSEQ_VECTORA** ProtseqVector);

@DllImport("RPCRT4.dll")
int RpcProtseqVectorFreeW(RPC_PROTSEQ_VECTORW** ProtseqVector);

@DllImport("RPCRT4.dll")
int RpcServerInqBindings(RPC_BINDING_VECTOR** BindingVector);

@DllImport("RPCRT4.dll")
int RpcServerInqBindingsEx(void* SecurityDescriptor, RPC_BINDING_VECTOR** BindingVector);

@DllImport("RPCRT4.dll")
int RpcServerInqIf(void* IfSpec, Guid* MgrTypeUuid, void** MgrEpv);

@DllImport("RPCRT4.dll")
int RpcServerListen(uint MinimumCallThreads, uint MaxCalls, uint DontWait);

@DllImport("RPCRT4.dll")
int RpcServerRegisterIf(void* IfSpec, Guid* MgrTypeUuid, void* MgrEpv);

@DllImport("RPCRT4.dll")
int RpcServerRegisterIfEx(void* IfSpec, Guid* MgrTypeUuid, void* MgrEpv, uint Flags, uint MaxCalls, RPC_IF_CALLBACK_FN* IfCallback);

@DllImport("RPCRT4.dll")
int RpcServerRegisterIf2(void* IfSpec, Guid* MgrTypeUuid, void* MgrEpv, uint Flags, uint MaxCalls, uint MaxRpcSize, RPC_IF_CALLBACK_FN* IfCallbackFn);

@DllImport("RPCRT4.dll")
int RpcServerRegisterIf3(void* IfSpec, Guid* MgrTypeUuid, void* MgrEpv, uint Flags, uint MaxCalls, uint MaxRpcSize, RPC_IF_CALLBACK_FN* IfCallback, void* SecurityDescriptor);

@DllImport("RPCRT4.dll")
int RpcServerUnregisterIf(void* IfSpec, Guid* MgrTypeUuid, uint WaitForCallsToComplete);

@DllImport("RPCRT4.dll")
int RpcServerUnregisterIfEx(void* IfSpec, Guid* MgrTypeUuid, int RundownContextHandles);

@DllImport("RPCRT4.dll")
int RpcServerUseAllProtseqs(uint MaxCalls, void* SecurityDescriptor);

@DllImport("RPCRT4.dll")
int RpcServerUseAllProtseqsEx(uint MaxCalls, void* SecurityDescriptor, RPC_POLICY* Policy);

@DllImport("RPCRT4.dll")
int RpcServerUseAllProtseqsIf(uint MaxCalls, void* IfSpec, void* SecurityDescriptor);

@DllImport("RPCRT4.dll")
int RpcServerUseAllProtseqsIfEx(uint MaxCalls, void* IfSpec, void* SecurityDescriptor, RPC_POLICY* Policy);

@DllImport("RPCRT4.dll")
int RpcServerUseProtseqA(ubyte* Protseq, uint MaxCalls, void* SecurityDescriptor);

@DllImport("RPCRT4.dll")
int RpcServerUseProtseqExA(ubyte* Protseq, uint MaxCalls, void* SecurityDescriptor, RPC_POLICY* Policy);

@DllImport("RPCRT4.dll")
int RpcServerUseProtseqW(ushort* Protseq, uint MaxCalls, void* SecurityDescriptor);

@DllImport("RPCRT4.dll")
int RpcServerUseProtseqExW(ushort* Protseq, uint MaxCalls, void* SecurityDescriptor, RPC_POLICY* Policy);

@DllImport("RPCRT4.dll")
int RpcServerUseProtseqEpA(ubyte* Protseq, uint MaxCalls, ubyte* Endpoint, void* SecurityDescriptor);

@DllImport("RPCRT4.dll")
int RpcServerUseProtseqEpExA(ubyte* Protseq, uint MaxCalls, ubyte* Endpoint, void* SecurityDescriptor, RPC_POLICY* Policy);

@DllImport("RPCRT4.dll")
int RpcServerUseProtseqEpW(ushort* Protseq, uint MaxCalls, ushort* Endpoint, void* SecurityDescriptor);

@DllImport("RPCRT4.dll")
int RpcServerUseProtseqEpExW(ushort* Protseq, uint MaxCalls, ushort* Endpoint, void* SecurityDescriptor, RPC_POLICY* Policy);

@DllImport("RPCRT4.dll")
int RpcServerUseProtseqIfA(ubyte* Protseq, uint MaxCalls, void* IfSpec, void* SecurityDescriptor);

@DllImport("RPCRT4.dll")
int RpcServerUseProtseqIfExA(ubyte* Protseq, uint MaxCalls, void* IfSpec, void* SecurityDescriptor, RPC_POLICY* Policy);

@DllImport("RPCRT4.dll")
int RpcServerUseProtseqIfW(ushort* Protseq, uint MaxCalls, void* IfSpec, void* SecurityDescriptor);

@DllImport("RPCRT4.dll")
int RpcServerUseProtseqIfExW(ushort* Protseq, uint MaxCalls, void* IfSpec, void* SecurityDescriptor, RPC_POLICY* Policy);

@DllImport("RPCRT4.dll")
void RpcServerYield();

@DllImport("RPCRT4.dll")
int RpcMgmtStatsVectorFree(RPC_STATS_VECTOR** StatsVector);

@DllImport("RPCRT4.dll")
int RpcMgmtInqStats(void* Binding, RPC_STATS_VECTOR** Statistics);

@DllImport("RPCRT4.dll")
int RpcMgmtIsServerListening(void* Binding);

@DllImport("RPCRT4.dll")
int RpcMgmtStopServerListening(void* Binding);

@DllImport("RPCRT4.dll")
int RpcMgmtWaitServerListen();

@DllImport("RPCRT4.dll")
int RpcMgmtSetServerStackSize(uint ThreadStackSize);

@DllImport("RPCRT4.dll")
void RpcSsDontSerializeContext();

@DllImport("RPCRT4.dll")
int RpcMgmtEnableIdleCleanup();

@DllImport("RPCRT4.dll")
int RpcMgmtInqIfIds(void* Binding, RPC_IF_ID_VECTOR** IfIdVector);

@DllImport("RPCRT4.dll")
int RpcIfIdVectorFree(RPC_IF_ID_VECTOR** IfIdVector);

@DllImport("RPCRT4.dll")
int RpcMgmtInqServerPrincNameA(void* Binding, uint AuthnSvc, ubyte** ServerPrincName);

@DllImport("RPCRT4.dll")
int RpcMgmtInqServerPrincNameW(void* Binding, uint AuthnSvc, ushort** ServerPrincName);

@DllImport("RPCRT4.dll")
int RpcServerInqDefaultPrincNameA(uint AuthnSvc, ubyte** PrincName);

@DllImport("RPCRT4.dll")
int RpcServerInqDefaultPrincNameW(uint AuthnSvc, ushort** PrincName);

@DllImport("RPCRT4.dll")
int RpcEpResolveBinding(void* Binding, void* IfSpec);

@DllImport("RPCRT4.dll")
int RpcNsBindingInqEntryNameA(void* Binding, uint EntryNameSyntax, ubyte** EntryName);

@DllImport("RPCRT4.dll")
int RpcNsBindingInqEntryNameW(void* Binding, uint EntryNameSyntax, ushort** EntryName);

@DllImport("RPCRT4.dll")
int RpcBindingCreateA(RPC_BINDING_HANDLE_TEMPLATE_V1_A* Template, RPC_BINDING_HANDLE_SECURITY_V1_A* Security, RPC_BINDING_HANDLE_OPTIONS_V1* Options, void** Binding);

@DllImport("RPCRT4.dll")
int RpcBindingCreateW(RPC_BINDING_HANDLE_TEMPLATE_V1_W* Template, RPC_BINDING_HANDLE_SECURITY_V1_W* Security, RPC_BINDING_HANDLE_OPTIONS_V1* Options, void** Binding);

@DllImport("RPCRT4.dll")
int RpcServerInqBindingHandle(void** Binding);

@DllImport("RPCRT4.dll")
int RpcImpersonateClient(void* BindingHandle);

@DllImport("RPCRT4.dll")
int RpcImpersonateClient2(void* BindingHandle);

@DllImport("RPCRT4.dll")
int RpcRevertToSelfEx(void* BindingHandle);

@DllImport("RPCRT4.dll")
int RpcRevertToSelf();

@DllImport("RPCRT4.dll")
int RpcImpersonateClientContainer(void* BindingHandle);

@DllImport("RPCRT4.dll")
int RpcRevertContainerImpersonation();

@DllImport("RPCRT4.dll")
int RpcBindingInqAuthClientA(void* ClientBinding, void** Privs, ubyte** ServerPrincName, uint* AuthnLevel, uint* AuthnSvc, uint* AuthzSvc);

@DllImport("RPCRT4.dll")
int RpcBindingInqAuthClientW(void* ClientBinding, void** Privs, ushort** ServerPrincName, uint* AuthnLevel, uint* AuthnSvc, uint* AuthzSvc);

@DllImport("RPCRT4.dll")
int RpcBindingInqAuthClientExA(void* ClientBinding, void** Privs, ubyte** ServerPrincName, uint* AuthnLevel, uint* AuthnSvc, uint* AuthzSvc, uint Flags);

@DllImport("RPCRT4.dll")
int RpcBindingInqAuthClientExW(void* ClientBinding, void** Privs, ushort** ServerPrincName, uint* AuthnLevel, uint* AuthnSvc, uint* AuthzSvc, uint Flags);

@DllImport("RPCRT4.dll")
int RpcBindingInqAuthInfoA(void* Binding, ubyte** ServerPrincName, uint* AuthnLevel, uint* AuthnSvc, void** AuthIdentity, uint* AuthzSvc);

@DllImport("RPCRT4.dll")
int RpcBindingInqAuthInfoW(void* Binding, ushort** ServerPrincName, uint* AuthnLevel, uint* AuthnSvc, void** AuthIdentity, uint* AuthzSvc);

@DllImport("RPCRT4.dll")
int RpcBindingSetAuthInfoA(void* Binding, ubyte* ServerPrincName, uint AuthnLevel, uint AuthnSvc, void* AuthIdentity, uint AuthzSvc);

@DllImport("RPCRT4.dll")
int RpcBindingSetAuthInfoExA(void* Binding, ubyte* ServerPrincName, uint AuthnLevel, uint AuthnSvc, void* AuthIdentity, uint AuthzSvc, RPC_SECURITY_QOS* SecurityQos);

@DllImport("RPCRT4.dll")
int RpcBindingSetAuthInfoW(void* Binding, ushort* ServerPrincName, uint AuthnLevel, uint AuthnSvc, void* AuthIdentity, uint AuthzSvc);

@DllImport("RPCRT4.dll")
int RpcBindingSetAuthInfoExW(void* Binding, ushort* ServerPrincName, uint AuthnLevel, uint AuthnSvc, void* AuthIdentity, uint AuthzSvc, RPC_SECURITY_QOS* SecurityQOS);

@DllImport("RPCRT4.dll")
int RpcBindingInqAuthInfoExA(void* Binding, ubyte** ServerPrincName, uint* AuthnLevel, uint* AuthnSvc, void** AuthIdentity, uint* AuthzSvc, uint RpcQosVersion, RPC_SECURITY_QOS* SecurityQOS);

@DllImport("RPCRT4.dll")
int RpcBindingInqAuthInfoExW(void* Binding, ushort** ServerPrincName, uint* AuthnLevel, uint* AuthnSvc, void** AuthIdentity, uint* AuthzSvc, uint RpcQosVersion, RPC_SECURITY_QOS* SecurityQOS);

@DllImport("RPCRT4.dll")
int RpcServerCompleteSecurityCallback(void* BindingHandle, int Status);

@DllImport("RPCRT4.dll")
int RpcServerRegisterAuthInfoA(ubyte* ServerPrincName, uint AuthnSvc, RPC_AUTH_KEY_RETRIEVAL_FN GetKeyFn, void* Arg);

@DllImport("RPCRT4.dll")
int RpcServerRegisterAuthInfoW(ushort* ServerPrincName, uint AuthnSvc, RPC_AUTH_KEY_RETRIEVAL_FN GetKeyFn, void* Arg);

@DllImport("RPCRT4.dll")
int RpcBindingServerFromClient(void* ClientBinding, void** ServerBinding);

@DllImport("RPCRT4.dll")
void RpcRaiseException(int exception);

@DllImport("RPCRT4.dll")
int RpcTestCancel();

@DllImport("RPCRT4.dll")
int RpcServerTestCancel(void* BindingHandle);

@DllImport("RPCRT4.dll")
int RpcCancelThread(void* Thread);

@DllImport("RPCRT4.dll")
int RpcCancelThreadEx(void* Thread, int Timeout);

@DllImport("RPCRT4.dll")
int UuidCreate(Guid* Uuid);

@DllImport("RPCRT4.dll")
int UuidCreateSequential(Guid* Uuid);

@DllImport("RPCRT4.dll")
int UuidToStringA(const(Guid)* Uuid, ubyte** StringUuid);

@DllImport("RPCRT4.dll")
int UuidFromStringA(ubyte* StringUuid, Guid* Uuid);

@DllImport("RPCRT4.dll")
int UuidToStringW(const(Guid)* Uuid, ushort** StringUuid);

@DllImport("RPCRT4.dll")
int UuidFromStringW(ushort* StringUuid, Guid* Uuid);

@DllImport("RPCRT4.dll")
int UuidCompare(Guid* Uuid1, Guid* Uuid2, int* Status);

@DllImport("RPCRT4.dll")
int UuidCreateNil(Guid* NilUuid);

@DllImport("RPCRT4.dll")
int UuidEqual(Guid* Uuid1, Guid* Uuid2, int* Status);

@DllImport("RPCRT4.dll")
ushort UuidHash(Guid* Uuid, int* Status);

@DllImport("RPCRT4.dll")
int UuidIsNil(Guid* Uuid, int* Status);

@DllImport("RPCRT4.dll")
int RpcEpRegisterNoReplaceA(void* IfSpec, RPC_BINDING_VECTOR* BindingVector, UUID_VECTOR* UuidVector, ubyte* Annotation);

@DllImport("RPCRT4.dll")
int RpcEpRegisterNoReplaceW(void* IfSpec, RPC_BINDING_VECTOR* BindingVector, UUID_VECTOR* UuidVector, ushort* Annotation);

@DllImport("RPCRT4.dll")
int RpcEpRegisterA(void* IfSpec, RPC_BINDING_VECTOR* BindingVector, UUID_VECTOR* UuidVector, ubyte* Annotation);

@DllImport("RPCRT4.dll")
int RpcEpRegisterW(void* IfSpec, RPC_BINDING_VECTOR* BindingVector, UUID_VECTOR* UuidVector, ushort* Annotation);

@DllImport("RPCRT4.dll")
int RpcEpUnregister(void* IfSpec, RPC_BINDING_VECTOR* BindingVector, UUID_VECTOR* UuidVector);

@DllImport("RPCRT4.dll")
int DceErrorInqTextA(int RpcStatus, char* ErrorText);

@DllImport("RPCRT4.dll")
int DceErrorInqTextW(int RpcStatus, char* ErrorText);

@DllImport("RPCRT4.dll")
int RpcMgmtEpEltInqBegin(void* EpBinding, uint InquiryType, RPC_IF_ID* IfId, uint VersOption, Guid* ObjectUuid, void*** InquiryContext);

@DllImport("RPCRT4.dll")
int RpcMgmtEpEltInqDone(void*** InquiryContext);

@DllImport("RPCRT4.dll")
int RpcMgmtEpEltInqNextA(void** InquiryContext, RPC_IF_ID* IfId, void** Binding, Guid* ObjectUuid, ubyte** Annotation);

@DllImport("RPCRT4.dll")
int RpcMgmtEpEltInqNextW(void** InquiryContext, RPC_IF_ID* IfId, void** Binding, Guid* ObjectUuid, ushort** Annotation);

@DllImport("RPCRT4.dll")
int RpcMgmtEpUnregister(void* EpBinding, RPC_IF_ID* IfId, void* Binding, Guid* ObjectUuid);

@DllImport("RPCRT4.dll")
int RpcMgmtSetAuthorizationFn(RPC_MGMT_AUTHORIZATION_FN AuthorizationFn);

@DllImport("RPCRT4.dll")
int RpcExceptionFilter(uint ExceptionCode);

@DllImport("RPCRT4.dll")
int RpcServerInterfaceGroupCreateW(char* Interfaces, uint NumIfs, char* Endpoints, uint NumEndpoints, uint IdlePeriod, RPC_INTERFACE_GROUP_IDLE_CALLBACK_FN IdleCallbackFn, void* IdleCallbackContext, void** IfGroup);

@DllImport("RPCRT4.dll")
int RpcServerInterfaceGroupCreateA(char* Interfaces, uint NumIfs, char* Endpoints, uint NumEndpoints, uint IdlePeriod, RPC_INTERFACE_GROUP_IDLE_CALLBACK_FN IdleCallbackFn, void* IdleCallbackContext, void** IfGroup);

@DllImport("RPCRT4.dll")
int RpcServerInterfaceGroupClose(void* IfGroup);

@DllImport("RPCRT4.dll")
int RpcServerInterfaceGroupActivate(void* IfGroup);

@DllImport("RPCRT4.dll")
int RpcServerInterfaceGroupDeactivate(void* IfGroup, uint ForceDeactivation);

@DllImport("RPCRT4.dll")
int RpcServerInterfaceGroupInqBindings(void* IfGroup, RPC_BINDING_VECTOR** BindingVector);

@DllImport("RPCRT4.dll")
int I_RpcNegotiateTransferSyntax(RPC_MESSAGE* Message);

@DllImport("RPCRT4.dll")
int I_RpcGetBuffer(RPC_MESSAGE* Message);

@DllImport("RPCRT4.dll")
int I_RpcGetBufferWithObject(RPC_MESSAGE* Message, Guid* ObjectUuid);

@DllImport("RPCRT4.dll")
int I_RpcSendReceive(RPC_MESSAGE* Message);

@DllImport("RPCRT4.dll")
int I_RpcFreeBuffer(RPC_MESSAGE* Message);

@DllImport("RPCRT4.dll")
int I_RpcSend(RPC_MESSAGE* Message);

@DllImport("RPCRT4.dll")
int I_RpcReceive(RPC_MESSAGE* Message, uint Size);

@DllImport("RPCRT4.dll")
int I_RpcFreePipeBuffer(RPC_MESSAGE* Message);

@DllImport("RPCRT4.dll")
int I_RpcReallocPipeBuffer(RPC_MESSAGE* Message, uint NewSize);

@DllImport("RPCRT4.dll")
void I_RpcRequestMutex(void** Mutex);

@DllImport("RPCRT4.dll")
void I_RpcClearMutex(void* Mutex);

@DllImport("RPCRT4.dll")
void I_RpcDeleteMutex(void* Mutex);

@DllImport("RPCRT4.dll")
void* I_RpcAllocate(uint Size);

@DllImport("RPCRT4.dll")
void I_RpcFree(void* Object);

@DllImport("RPCRT4.dll")
void I_RpcPauseExecution(uint Milliseconds);

@DllImport("RPCRT4.dll")
int I_RpcGetExtendedError();

@DllImport("RPCRT4.dll")
int I_RpcSystemHandleTypeSpecificWork(void* Handle, ubyte ActualType, ubyte IdlType, LRPC_SYSTEM_HANDLE_MARSHAL_DIRECTION MarshalDirection);

@DllImport("RPCRT4.dll")
void* I_RpcGetCurrentCallHandle();

@DllImport("RPCRT4.dll")
int I_RpcNsInterfaceExported(uint EntryNameSyntax, ushort* EntryName, RPC_SERVER_INTERFACE* RpcInterfaceInformation);

@DllImport("RPCRT4.dll")
int I_RpcNsInterfaceUnexported(uint EntryNameSyntax, ushort* EntryName, RPC_SERVER_INTERFACE* RpcInterfaceInformation);

@DllImport("RPCRT4.dll")
int I_RpcBindingToStaticStringBindingW(void* Binding, ushort** StringBinding);

@DllImport("RPCRT4.dll")
int I_RpcBindingInqSecurityContext(void* Binding, void** SecurityContextHandle);

@DllImport("RPCRT4.dll")
int I_RpcBindingInqSecurityContextKeyInfo(void* Binding, void* KeyInfo);

@DllImport("RPCRT4.dll")
int I_RpcBindingInqWireIdForSnego(void* Binding, ubyte* WireId);

@DllImport("RPCRT4.dll")
int I_RpcBindingInqMarshalledTargetInfo(void* Binding, uint* MarshalledTargetInfoSize, ubyte** MarshalledTargetInfo);

@DllImport("RPCRT4.dll")
int I_RpcBindingInqLocalClientPID(void* Binding, uint* Pid);

@DllImport("RPCRT4.dll")
int I_RpcBindingHandleToAsyncHandle(void* Binding, void** AsyncHandle);

@DllImport("RPCRT4.dll")
int I_RpcNsBindingSetEntryNameW(void* Binding, uint EntryNameSyntax, ushort* EntryName);

@DllImport("RPCRT4.dll")
int I_RpcNsBindingSetEntryNameA(void* Binding, uint EntryNameSyntax, ubyte* EntryName);

@DllImport("RPCRT4.dll")
int I_RpcServerUseProtseqEp2A(ubyte* NetworkAddress, ubyte* Protseq, uint MaxCalls, ubyte* Endpoint, void* SecurityDescriptor, void* Policy);

@DllImport("RPCRT4.dll")
int I_RpcServerUseProtseqEp2W(ushort* NetworkAddress, ushort* Protseq, uint MaxCalls, ushort* Endpoint, void* SecurityDescriptor, void* Policy);

@DllImport("RPCRT4.dll")
int I_RpcServerUseProtseq2W(ushort* NetworkAddress, ushort* Protseq, uint MaxCalls, void* SecurityDescriptor, void* Policy);

@DllImport("RPCRT4.dll")
int I_RpcServerUseProtseq2A(ubyte* NetworkAddress, ubyte* Protseq, uint MaxCalls, void* SecurityDescriptor, void* Policy);

@DllImport("RPCRT4.dll")
int I_RpcServerStartService(ushort* Protseq, ushort* Endpoint, void* IfSpec);

@DllImport("RPCRT4.dll")
int I_RpcBindingInqDynamicEndpointW(void* Binding, ushort** DynamicEndpoint);

@DllImport("RPCRT4.dll")
int I_RpcBindingInqDynamicEndpointA(void* Binding, ubyte** DynamicEndpoint);

@DllImport("RPCRT4.dll")
int I_RpcServerCheckClientRestriction(void* Context);

@DllImport("RPCRT4.dll")
int I_RpcBindingInqTransportType(void* Binding, uint* Type);

@DllImport("RPCRT4.dll")
int I_RpcIfInqTransferSyntaxes(void* RpcIfHandle, RPC_TRANSFER_SYNTAX* TransferSyntaxes, uint TransferSyntaxSize, uint* TransferSyntaxCount);

@DllImport("RPCRT4.dll")
int I_UuidCreate(Guid* Uuid);

@DllImport("RPCRT4.dll")
int I_RpcBindingCopy(void* SourceBinding, void** DestinationBinding);

@DllImport("RPCRT4.dll")
int I_RpcBindingIsClientLocal(void* BindingHandle, uint* ClientLocalFlag);

@DllImport("RPCRT4.dll")
int I_RpcBindingCreateNP(ushort* ServerName, ushort* ServiceName, ushort* NetworkOptions, void** Binding);

@DllImport("RPCRT4.dll")
void I_RpcSsDontSerializeContext();

@DllImport("RPCRT4.dll")
int I_RpcServerRegisterForwardFunction(RPC_FORWARD_FUNCTION* pForwardFunction);

@DllImport("RPCRT4.dll")
RPC_ADDRESS_CHANGE_FN* I_RpcServerInqAddressChangeFn();

@DllImport("RPCRT4.dll")
int I_RpcServerSetAddressChangeFn(RPC_ADDRESS_CHANGE_FN* pAddressChangeFn);

@DllImport("RPCRT4.dll")
int I_RpcServerInqLocalConnAddress(void* Binding, void* Buffer, uint* BufferSize, uint* AddressFormat);

@DllImport("RPCRT4.dll")
int I_RpcServerInqRemoteConnAddress(void* Binding, void* Buffer, uint* BufferSize, uint* AddressFormat);

@DllImport("RPCRT4.dll")
void I_RpcSessionStrictContextHandle();

@DllImport("RPCRT4.dll")
int I_RpcTurnOnEEInfoPropagation();

@DllImport("RPCRT4.dll")
int I_RpcServerInqTransportType(uint* Type);

@DllImport("RPCRT4.dll")
int I_RpcMapWin32Status(int Status);

@DllImport("RPCRT4.dll")
void I_RpcRecordCalloutFailure(int RpcStatus, RDR_CALLOUT_STATE* CallOutState, ushort* DllName);

@DllImport("RPCRT4.dll")
int I_RpcMgmtEnableDedicatedThreadPool();

@DllImport("RPCRT4.dll")
int I_RpcGetDefaultSD(void** ppSecurityDescriptor);

@DllImport("RPCRT4.dll")
int I_RpcOpenClientProcess(void* Binding, uint DesiredAccess, void** ClientProcess);

@DllImport("RPCRT4.dll")
int I_RpcBindingIsServerLocal(void* Binding, uint* ServerLocalFlag);

@DllImport("RPCRT4.dll")
int I_RpcBindingSetPrivateOption(void* hBinding, uint option, uint optionValue);

@DllImport("RPCRT4.dll")
int I_RpcServerSubscribeForDisconnectNotification(void* Binding, void* hEvent);

@DllImport("RPCRT4.dll")
int I_RpcServerGetAssociationID(void* Binding, uint* AssociationID);

@DllImport("RPCRT4.dll")
int I_RpcServerDisableExceptionFilter();

@DllImport("RPCRT4.dll")
int I_RpcServerSubscribeForDisconnectNotification2(void* Binding, void* hEvent, Guid* SubscriptionId);

@DllImport("RPCRT4.dll")
int I_RpcServerUnsubscribeForDisconnectNotification(void* Binding, Guid SubscriptionId);

@DllImport("RPCNS4.dll")
int RpcNsBindingExportA(uint EntryNameSyntax, ubyte* EntryName, void* IfSpec, RPC_BINDING_VECTOR* BindingVec, UUID_VECTOR* ObjectUuidVec);

@DllImport("RPCNS4.dll")
int RpcNsBindingUnexportA(uint EntryNameSyntax, ubyte* EntryName, void* IfSpec, UUID_VECTOR* ObjectUuidVec);

@DllImport("RPCNS4.dll")
int RpcNsBindingExportW(uint EntryNameSyntax, ushort* EntryName, void* IfSpec, RPC_BINDING_VECTOR* BindingVec, UUID_VECTOR* ObjectUuidVec);

@DllImport("RPCNS4.dll")
int RpcNsBindingUnexportW(uint EntryNameSyntax, ushort* EntryName, void* IfSpec, UUID_VECTOR* ObjectUuidVec);

@DllImport("RPCNS4.dll")
int RpcNsBindingExportPnPA(uint EntryNameSyntax, ubyte* EntryName, void* IfSpec, UUID_VECTOR* ObjectVector);

@DllImport("RPCNS4.dll")
int RpcNsBindingUnexportPnPA(uint EntryNameSyntax, ubyte* EntryName, void* IfSpec, UUID_VECTOR* ObjectVector);

@DllImport("RPCNS4.dll")
int RpcNsBindingExportPnPW(uint EntryNameSyntax, ushort* EntryName, void* IfSpec, UUID_VECTOR* ObjectVector);

@DllImport("RPCNS4.dll")
int RpcNsBindingUnexportPnPW(uint EntryNameSyntax, ushort* EntryName, void* IfSpec, UUID_VECTOR* ObjectVector);

@DllImport("RPCNS4.dll")
int RpcNsBindingLookupBeginA(uint EntryNameSyntax, ubyte* EntryName, void* IfSpec, Guid* ObjUuid, uint BindingMaxCount, void** LookupContext);

@DllImport("RPCNS4.dll")
int RpcNsBindingLookupBeginW(uint EntryNameSyntax, ushort* EntryName, void* IfSpec, Guid* ObjUuid, uint BindingMaxCount, void** LookupContext);

@DllImport("RPCNS4.dll")
int RpcNsBindingLookupNext(void* LookupContext, RPC_BINDING_VECTOR** BindingVec);

@DllImport("RPCNS4.dll")
int RpcNsBindingLookupDone(void** LookupContext);

@DllImport("RPCNS4.dll")
int RpcNsGroupDeleteA(uint GroupNameSyntax, ubyte* GroupName);

@DllImport("RPCNS4.dll")
int RpcNsGroupMbrAddA(uint GroupNameSyntax, ubyte* GroupName, uint MemberNameSyntax, ubyte* MemberName);

@DllImport("RPCNS4.dll")
int RpcNsGroupMbrRemoveA(uint GroupNameSyntax, ubyte* GroupName, uint MemberNameSyntax, ubyte* MemberName);

@DllImport("RPCNS4.dll")
int RpcNsGroupMbrInqBeginA(uint GroupNameSyntax, ubyte* GroupName, uint MemberNameSyntax, void** InquiryContext);

@DllImport("RPCNS4.dll")
int RpcNsGroupMbrInqNextA(void* InquiryContext, ubyte** MemberName);

@DllImport("RPCNS4.dll")
int RpcNsGroupDeleteW(uint GroupNameSyntax, ushort* GroupName);

@DllImport("RPCNS4.dll")
int RpcNsGroupMbrAddW(uint GroupNameSyntax, ushort* GroupName, uint MemberNameSyntax, ushort* MemberName);

@DllImport("RPCNS4.dll")
int RpcNsGroupMbrRemoveW(uint GroupNameSyntax, ushort* GroupName, uint MemberNameSyntax, ushort* MemberName);

@DllImport("RPCNS4.dll")
int RpcNsGroupMbrInqBeginW(uint GroupNameSyntax, ushort* GroupName, uint MemberNameSyntax, void** InquiryContext);

@DllImport("RPCNS4.dll")
int RpcNsGroupMbrInqNextW(void* InquiryContext, ushort** MemberName);

@DllImport("RPCNS4.dll")
int RpcNsGroupMbrInqDone(void** InquiryContext);

@DllImport("RPCNS4.dll")
int RpcNsProfileDeleteA(uint ProfileNameSyntax, ubyte* ProfileName);

@DllImport("RPCNS4.dll")
int RpcNsProfileEltAddA(uint ProfileNameSyntax, ubyte* ProfileName, RPC_IF_ID* IfId, uint MemberNameSyntax, ubyte* MemberName, uint Priority, ubyte* Annotation);

@DllImport("RPCNS4.dll")
int RpcNsProfileEltRemoveA(uint ProfileNameSyntax, ubyte* ProfileName, RPC_IF_ID* IfId, uint MemberNameSyntax, ubyte* MemberName);

@DllImport("RPCNS4.dll")
int RpcNsProfileEltInqBeginA(uint ProfileNameSyntax, ubyte* ProfileName, uint InquiryType, RPC_IF_ID* IfId, uint VersOption, uint MemberNameSyntax, ubyte* MemberName, void** InquiryContext);

@DllImport("RPCNS4.dll")
int RpcNsProfileEltInqNextA(void* InquiryContext, RPC_IF_ID* IfId, ubyte** MemberName, uint* Priority, ubyte** Annotation);

@DllImport("RPCNS4.dll")
int RpcNsProfileDeleteW(uint ProfileNameSyntax, ushort* ProfileName);

@DllImport("RPCNS4.dll")
int RpcNsProfileEltAddW(uint ProfileNameSyntax, ushort* ProfileName, RPC_IF_ID* IfId, uint MemberNameSyntax, ushort* MemberName, uint Priority, ushort* Annotation);

@DllImport("RPCNS4.dll")
int RpcNsProfileEltRemoveW(uint ProfileNameSyntax, ushort* ProfileName, RPC_IF_ID* IfId, uint MemberNameSyntax, ushort* MemberName);

@DllImport("RPCNS4.dll")
int RpcNsProfileEltInqBeginW(uint ProfileNameSyntax, ushort* ProfileName, uint InquiryType, RPC_IF_ID* IfId, uint VersOption, uint MemberNameSyntax, ushort* MemberName, void** InquiryContext);

@DllImport("RPCNS4.dll")
int RpcNsProfileEltInqNextW(void* InquiryContext, RPC_IF_ID* IfId, ushort** MemberName, uint* Priority, ushort** Annotation);

@DllImport("RPCNS4.dll")
int RpcNsProfileEltInqDone(void** InquiryContext);

@DllImport("RPCNS4.dll")
int RpcNsEntryObjectInqBeginA(uint EntryNameSyntax, ubyte* EntryName, void** InquiryContext);

@DllImport("RPCNS4.dll")
int RpcNsEntryObjectInqBeginW(uint EntryNameSyntax, ushort* EntryName, void** InquiryContext);

@DllImport("RPCNS4.dll")
int RpcNsEntryObjectInqNext(void* InquiryContext, Guid* ObjUuid);

@DllImport("RPCNS4.dll")
int RpcNsEntryObjectInqDone(void** InquiryContext);

@DllImport("RPCNS4.dll")
int RpcNsEntryExpandNameA(uint EntryNameSyntax, ubyte* EntryName, ubyte** ExpandedName);

@DllImport("RPCNS4.dll")
int RpcNsMgmtBindingUnexportA(uint EntryNameSyntax, ubyte* EntryName, RPC_IF_ID* IfId, uint VersOption, UUID_VECTOR* ObjectUuidVec);

@DllImport("RPCNS4.dll")
int RpcNsMgmtEntryCreateA(uint EntryNameSyntax, ubyte* EntryName);

@DllImport("RPCNS4.dll")
int RpcNsMgmtEntryDeleteA(uint EntryNameSyntax, ubyte* EntryName);

@DllImport("RPCNS4.dll")
int RpcNsMgmtEntryInqIfIdsA(uint EntryNameSyntax, ubyte* EntryName, RPC_IF_ID_VECTOR** IfIdVec);

@DllImport("RPCNS4.dll")
int RpcNsMgmtHandleSetExpAge(void* NsHandle, uint ExpirationAge);

@DllImport("RPCNS4.dll")
int RpcNsMgmtInqExpAge(uint* ExpirationAge);

@DllImport("RPCNS4.dll")
int RpcNsMgmtSetExpAge(uint ExpirationAge);

@DllImport("RPCNS4.dll")
int RpcNsEntryExpandNameW(uint EntryNameSyntax, ushort* EntryName, ushort** ExpandedName);

@DllImport("RPCNS4.dll")
int RpcNsMgmtBindingUnexportW(uint EntryNameSyntax, ushort* EntryName, RPC_IF_ID* IfId, uint VersOption, UUID_VECTOR* ObjectUuidVec);

@DllImport("RPCNS4.dll")
int RpcNsMgmtEntryCreateW(uint EntryNameSyntax, ushort* EntryName);

@DllImport("RPCNS4.dll")
int RpcNsMgmtEntryDeleteW(uint EntryNameSyntax, ushort* EntryName);

@DllImport("RPCNS4.dll")
int RpcNsMgmtEntryInqIfIdsW(uint EntryNameSyntax, ushort* EntryName, RPC_IF_ID_VECTOR** IfIdVec);

@DllImport("RPCNS4.dll")
int RpcNsBindingImportBeginA(uint EntryNameSyntax, ubyte* EntryName, void* IfSpec, Guid* ObjUuid, void** ImportContext);

@DllImport("RPCNS4.dll")
int RpcNsBindingImportBeginW(uint EntryNameSyntax, ushort* EntryName, void* IfSpec, Guid* ObjUuid, void** ImportContext);

@DllImport("RPCNS4.dll")
int RpcNsBindingImportNext(void* ImportContext, void** Binding);

@DllImport("RPCNS4.dll")
int RpcNsBindingImportDone(void** ImportContext);

@DllImport("RPCNS4.dll")
int RpcNsBindingSelect(RPC_BINDING_VECTOR* BindingVec, void** Binding);

@DllImport("RPCRT4.dll")
int RpcAsyncRegisterInfo(RPC_ASYNC_STATE* pAsync);

@DllImport("RPCRT4.dll")
int RpcAsyncInitializeHandle(char* pAsync, uint Size);

@DllImport("RPCRT4.dll")
int RpcAsyncGetCallStatus(RPC_ASYNC_STATE* pAsync);

@DllImport("RPCRT4.dll")
int RpcAsyncCompleteCall(RPC_ASYNC_STATE* pAsync, void* Reply);

@DllImport("RPCRT4.dll")
int RpcAsyncAbortCall(RPC_ASYNC_STATE* pAsync, uint ExceptionCode);

@DllImport("RPCRT4.dll")
int RpcAsyncCancelCall(RPC_ASYNC_STATE* pAsync, BOOL fAbort);

@DllImport("RPCRT4.dll")
int RpcErrorStartEnumeration(RPC_ERROR_ENUM_HANDLE* EnumHandle);

@DllImport("RPCRT4.dll")
int RpcErrorGetNextRecord(RPC_ERROR_ENUM_HANDLE* EnumHandle, BOOL CopyStrings, RPC_EXTENDED_ERROR_INFO* ErrorInfo);

@DllImport("RPCRT4.dll")
int RpcErrorEndEnumeration(RPC_ERROR_ENUM_HANDLE* EnumHandle);

@DllImport("RPCRT4.dll")
int RpcErrorResetEnumeration(RPC_ERROR_ENUM_HANDLE* EnumHandle);

@DllImport("RPCRT4.dll")
int RpcErrorGetNumberOfRecords(RPC_ERROR_ENUM_HANDLE* EnumHandle, int* Records);

@DllImport("RPCRT4.dll")
int RpcErrorSaveErrorInfo(RPC_ERROR_ENUM_HANDLE* EnumHandle, void** ErrorBlob, uint* BlobSize);

@DllImport("RPCRT4.dll")
int RpcErrorLoadErrorInfo(char* ErrorBlob, uint BlobSize, RPC_ERROR_ENUM_HANDLE* EnumHandle);

@DllImport("RPCRT4.dll")
int RpcErrorAddRecord(RPC_EXTENDED_ERROR_INFO* ErrorInfo);

@DllImport("RPCRT4.dll")
void RpcErrorClearInformation();

@DllImport("RPCRT4.dll")
int RpcGetAuthorizationContextForClient(void* ClientBinding, BOOL ImpersonateOnReturn, void* Reserved1, LARGE_INTEGER* pExpirationTime, LUID Reserved2, uint Reserved3, void* Reserved4, void** pAuthzClientContext);

@DllImport("RPCRT4.dll")
int RpcFreeAuthorizationContext(void** pAuthzClientContext);

@DllImport("RPCRT4.dll")
int RpcSsContextLockExclusive(void* ServerBindingHandle, void* UserContext);

@DllImport("RPCRT4.dll")
int RpcSsContextLockShared(void* ServerBindingHandle, void* UserContext);

@DllImport("RPCRT4.dll")
int RpcServerInqCallAttributesW(void* ClientBinding, void* RpcCallAttributes);

@DllImport("RPCRT4.dll")
int RpcServerInqCallAttributesA(void* ClientBinding, void* RpcCallAttributes);

@DllImport("RPCRT4.dll")
int RpcServerSubscribeForNotification(void* Binding, RPC_NOTIFICATIONS Notification, RPC_NOTIFICATION_TYPES NotificationType, RPC_ASYNC_NOTIFICATION_INFO* NotificationInfo);

@DllImport("RPCRT4.dll")
int RpcServerUnsubscribeForNotification(void* Binding, RPC_NOTIFICATIONS Notification, uint* NotificationsQueued);

@DllImport("RPCRT4.dll")
int RpcBindingBind(RPC_ASYNC_STATE* pAsync, void* Binding, void* IfSpec);

@DllImport("RPCRT4.dll")
int RpcBindingUnbind(void* Binding);

@DllImport("RPCRT4.dll")
int I_RpcAsyncSetHandle(RPC_MESSAGE* Message, RPC_ASYNC_STATE* pAsync);

@DllImport("RPCRT4.dll")
int I_RpcAsyncAbortCall(RPC_ASYNC_STATE* pAsync, uint ExceptionCode);

@DllImport("RPCRT4.dll")
int I_RpcExceptionFilter(uint ExceptionCode);

@DllImport("RPCRT4.dll")
int I_RpcBindingInqClientTokenAttributes(void* Binding, LUID* TokenId, LUID* AuthenticationId, LUID* ModifiedId);

@DllImport("RPCRT4.dll")
void* NDRCContextBinding(int CContext);

@DllImport("RPCRT4.dll")
void NDRCContextMarshall(int CContext, void* pBuff);

@DllImport("RPCRT4.dll")
void NDRCContextUnmarshall(int* pCContext, void* hBinding, void* pBuff, uint DataRepresentation);

@DllImport("RPCRT4.dll")
void NDRSContextMarshall(NDR_SCONTEXT_1* CContext, void* pBuff, NDR_RUNDOWN userRunDownIn);

@DllImport("RPCRT4.dll")
NDR_SCONTEXT_1* NDRSContextUnmarshall(void* pBuff, uint DataRepresentation);

@DllImport("RPCRT4.dll")
void NDRSContextMarshallEx(void* BindingHandle, NDR_SCONTEXT_1* CContext, void* pBuff, NDR_RUNDOWN userRunDownIn);

@DllImport("RPCRT4.dll")
void NDRSContextMarshall2(void* BindingHandle, NDR_SCONTEXT_1* CContext, void* pBuff, NDR_RUNDOWN userRunDownIn, void* CtxGuard, uint Flags);

@DllImport("RPCRT4.dll")
NDR_SCONTEXT_1* NDRSContextUnmarshallEx(void* BindingHandle, void* pBuff, uint DataRepresentation);

@DllImport("RPCRT4.dll")
NDR_SCONTEXT_1* NDRSContextUnmarshall2(void* BindingHandle, void* pBuff, uint DataRepresentation, void* CtxGuard, uint Flags);

@DllImport("RPCRT4.dll")
void RpcSsDestroyClientContext(void** ContextHandle);

@DllImport("RPCRT4.dll")
void NdrSimpleTypeMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte FormatChar);

@DllImport("RPCRT4.dll")
ubyte* NdrPointerMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrConformantStructMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrConformantVaryingStructMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrFixedArrayMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrConformantVaryingArrayMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrVaryingArrayMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrNonConformantStringMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrConformantStringMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrEncapsulatedUnionMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrNonEncapsulatedUnionMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrByteCountPointerMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrXmitOrRepAsMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrUserMarshalMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrInterfacePointerMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrClientContextMarshall(MIDL_STUB_MESSAGE* pStubMsg, int ContextHandle, int fCheck);

@DllImport("RPCRT4.dll")
void NdrServerContextMarshall(MIDL_STUB_MESSAGE* pStubMsg, NDR_SCONTEXT_1* ContextHandle, NDR_RUNDOWN RundownRoutine);

@DllImport("RPCRT4.dll")
void NdrServerContextNewMarshall(MIDL_STUB_MESSAGE* pStubMsg, NDR_SCONTEXT_1* ContextHandle, NDR_RUNDOWN RundownRoutine, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrSimpleTypeUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte FormatChar);

@DllImport("RPCRT4.dll")
ubyte* NdrRangeUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
void NdrCorrelationInitialize(MIDL_STUB_MESSAGE* pStubMsg, void* pMemory, uint CacheSize, uint flags);

@DllImport("RPCRT4.dll")
void NdrCorrelationPass(MIDL_STUB_MESSAGE* pStubMsg);

@DllImport("RPCRT4.dll")
void NdrCorrelationFree(MIDL_STUB_MESSAGE* pStubMsg);

@DllImport("RPCRT4.dll")
ubyte* NdrPointerUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrConformantStructUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrConformantVaryingStructUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrFixedArrayUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrConformantArrayUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrConformantVaryingArrayUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrVaryingArrayUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrNonConformantStringUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrConformantStringUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrEncapsulatedUnionUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrNonEncapsulatedUnionUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrByteCountPointerUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrXmitOrRepAsUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrInterfacePointerUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
void NdrClientContextUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, int* pContextHandle, void* BindHandle);

@DllImport("RPCRT4.dll")
NDR_SCONTEXT_1* NdrServerContextUnmarshall(MIDL_STUB_MESSAGE* pStubMsg);

@DllImport("RPCRT4.dll")
NDR_SCONTEXT_1* NdrContextHandleInitialize(MIDL_STUB_MESSAGE* pStubMsg, char* pFormat);

@DllImport("RPCRT4.dll")
NDR_SCONTEXT_1* NdrServerContextNewUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, char* pFormat);

@DllImport("RPCRT4.dll")
void NdrPointerBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrConformantStructBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrConformantVaryingStructBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrFixedArrayBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrConformantVaryingArrayBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrVaryingArrayBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrConformantStringBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrNonConformantStringBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrEncapsulatedUnionBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrNonEncapsulatedUnionBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrByteCountPointerBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrXmitOrRepAsBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrUserMarshalBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrInterfacePointerBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrContextHandleSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrPointerMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrSimpleStructMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrConformantStructMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrConformantVaryingStructMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrComplexStructMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrFixedArrayMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrConformantArrayMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrConformantVaryingArrayMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrVaryingArrayMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrComplexArrayMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrConformantStringMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrNonConformantStringMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrEncapsulatedUnionMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrNonEncapsulatedUnionMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrXmitOrRepAsMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrUserMarshalMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrInterfacePointerMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrPointerFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrSimpleStructFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrConformantStructFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrConformantVaryingStructFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrComplexStructFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrFixedArrayFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrConformantArrayFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrConformantVaryingArrayFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrVaryingArrayFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrComplexArrayFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrEncapsulatedUnionFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrNonEncapsulatedUnionFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrByteCountPointerFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrXmitOrRepAsFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrUserMarshalFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrInterfacePointerFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrConvert2(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat, int NumberParams);

@DllImport("RPCRT4.dll")
void NdrConvert(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrUserMarshalSimpleTypeConvert(uint* pFlags, ubyte* pBuffer, ubyte FormatChar);

@DllImport("RPCRT4.dll")
void NdrClientInitializeNew(RPC_MESSAGE* pRpcMsg, MIDL_STUB_MESSAGE* pStubMsg, MIDL_STUB_DESC* pStubDescriptor, uint ProcNum);

@DllImport("RPCRT4.dll")
ubyte* NdrServerInitializeNew(RPC_MESSAGE* pRpcMsg, MIDL_STUB_MESSAGE* pStubMsg, MIDL_STUB_DESC* pStubDescriptor);

@DllImport("RPCRT4.dll")
void NdrServerInitializePartial(RPC_MESSAGE* pRpcMsg, MIDL_STUB_MESSAGE* pStubMsg, MIDL_STUB_DESC* pStubDescriptor, uint RequestedBufferSize);

@DllImport("RPCRT4.dll")
void NdrClientInitialize(RPC_MESSAGE* pRpcMsg, MIDL_STUB_MESSAGE* pStubMsg, MIDL_STUB_DESC* pStubDescriptor, uint ProcNum);

@DllImport("RPCRT4.dll")
ubyte* NdrServerInitialize(RPC_MESSAGE* pRpcMsg, MIDL_STUB_MESSAGE* pStubMsg, MIDL_STUB_DESC* pStubDescriptor);

@DllImport("RPCRT4.dll")
ubyte* NdrServerInitializeUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, MIDL_STUB_DESC* pStubDescriptor, RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4.dll")
void NdrServerInitializeMarshall(RPC_MESSAGE* pRpcMsg, MIDL_STUB_MESSAGE* pStubMsg);

@DllImport("RPCRT4.dll")
ubyte* NdrGetBuffer(MIDL_STUB_MESSAGE* pStubMsg, uint BufferLength, void* Handle);

@DllImport("RPCRT4.dll")
ubyte* NdrNsGetBuffer(MIDL_STUB_MESSAGE* pStubMsg, uint BufferLength, void* Handle);

@DllImport("RPCRT4.dll")
ubyte* NdrSendReceive(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pBufferEnd);

@DllImport("RPCRT4.dll")
ubyte* NdrNsSendReceive(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pBufferEnd, void** pAutoHandle);

@DllImport("RPCRT4.dll")
void NdrFreeBuffer(MIDL_STUB_MESSAGE* pStubMsg);

@DllImport("RPCRT4.dll")
HRESULT NdrGetDcomProtocolVersion(MIDL_STUB_MESSAGE* pStubMsg, RPC_VERSION* pVersion);

@DllImport("RPCRT4.dll")
CLIENT_CALL_RETURN NdrClientCall2(MIDL_STUB_DESC* pStubDescriptor, ubyte* pFormat);

@DllImport("RPCRT4.dll")
CLIENT_CALL_RETURN NdrAsyncClientCall(MIDL_STUB_DESC* pStubDescriptor, ubyte* pFormat);

@DllImport("RPCRT4.dll")
CLIENT_CALL_RETURN NdrDcomAsyncClientCall(MIDL_STUB_DESC* pStubDescriptor, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrAsyncServerCall(RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4.dll")
int NdrDcomAsyncStubCall(IRpcStubBuffer pThis, IRpcChannelBuffer pChannel, RPC_MESSAGE* pRpcMsg, uint* pdwStubPhase);

@DllImport("RPCRT4.dll")
int NdrStubCall2(void* pThis, void* pChannel, RPC_MESSAGE* pRpcMsg, uint* pdwStubPhase);

@DllImport("RPCRT4.dll")
void NdrServerCall2(RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4.dll")
int NdrMapCommAndFaultStatus(MIDL_STUB_MESSAGE* pStubMsg, uint* pCommStatus, uint* pFaultStatus, int Status);

@DllImport("RPCRT4.dll")
void* RpcSsAllocate(uint Size);

@DllImport("RPCRT4.dll")
void RpcSsDisableAllocate();

@DllImport("RPCRT4.dll")
void RpcSsEnableAllocate();

@DllImport("RPCRT4.dll")
void RpcSsFree(void* NodeToFree);

@DllImport("RPCRT4.dll")
void* RpcSsGetThreadHandle();

@DllImport("RPCRT4.dll")
void RpcSsSetClientAllocFree(RPC_CLIENT_ALLOC* ClientAlloc, RPC_CLIENT_FREE* ClientFree);

@DllImport("RPCRT4.dll")
void RpcSsSetThreadHandle(void* Id);

@DllImport("RPCRT4.dll")
void RpcSsSwapClientAllocFree(RPC_CLIENT_ALLOC* ClientAlloc, RPC_CLIENT_FREE* ClientFree, RPC_CLIENT_ALLOC** OldClientAlloc, RPC_CLIENT_FREE** OldClientFree);

@DllImport("RPCRT4.dll")
void* RpcSmAllocate(uint Size, int* pStatus);

@DllImport("RPCRT4.dll")
int RpcSmClientFree(void* pNodeToFree);

@DllImport("RPCRT4.dll")
int RpcSmDestroyClientContext(void** ContextHandle);

@DllImport("RPCRT4.dll")
int RpcSmDisableAllocate();

@DllImport("RPCRT4.dll")
int RpcSmEnableAllocate();

@DllImport("RPCRT4.dll")
int RpcSmFree(void* NodeToFree);

@DllImport("RPCRT4.dll")
void* RpcSmGetThreadHandle(int* pStatus);

@DllImport("RPCRT4.dll")
int RpcSmSetClientAllocFree(RPC_CLIENT_ALLOC* ClientAlloc, RPC_CLIENT_FREE* ClientFree);

@DllImport("RPCRT4.dll")
int RpcSmSetThreadHandle(void* Id);

@DllImport("RPCRT4.dll")
int RpcSmSwapClientAllocFree(RPC_CLIENT_ALLOC* ClientAlloc, RPC_CLIENT_FREE* ClientFree, RPC_CLIENT_ALLOC** OldClientAlloc, RPC_CLIENT_FREE** OldClientFree);

@DllImport("RPCRT4.dll")
void NdrRpcSsEnableAllocate(MIDL_STUB_MESSAGE* pMessage);

@DllImport("RPCRT4.dll")
void NdrRpcSsDisableAllocate(MIDL_STUB_MESSAGE* pMessage);

@DllImport("RPCRT4.dll")
void NdrRpcSmSetClientToOsf(MIDL_STUB_MESSAGE* pMessage);

@DllImport("RPCRT4.dll")
void* NdrRpcSmClientAllocate(uint Size);

@DllImport("RPCRT4.dll")
void NdrRpcSmClientFree(void* NodeToFree);

@DllImport("RPCRT4.dll")
void* NdrRpcSsDefaultAllocate(uint Size);

@DllImport("RPCRT4.dll")
void NdrRpcSsDefaultFree(void* NodeToFree);

@DllImport("RPCRT4.dll")
FULL_PTR_XLAT_TABLES* NdrFullPointerXlatInit(uint NumberOfPointers, XLAT_SIDE XlatSide);

@DllImport("RPCRT4.dll")
void NdrFullPointerXlatFree(FULL_PTR_XLAT_TABLES* pXlatTables);

@DllImport("RPCRT4.dll")
void* NdrAllocate(MIDL_STUB_MESSAGE* pStubMsg, uint Len);

@DllImport("RPCRT4.dll")
void NdrClearOutParameters(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat, void* ArgAddr);

@DllImport("RPCRT4.dll")
void* NdrOleAllocate(uint Size);

@DllImport("RPCRT4.dll")
void NdrOleFree(void* NodeToFree);

@DllImport("RPCRT4.dll")
int NdrGetUserMarshalInfo(uint* pFlags, uint InformationLevel, NDR_USER_MARSHAL_INFO* pMarshalInfo);

@DllImport("RPCRT4.dll")
int NdrCreateServerInterfaceFromStub(IRpcStubBuffer pStub, RPC_SERVER_INTERFACE* pServerIf);

@DllImport("RPCRT4.dll")
CLIENT_CALL_RETURN NdrClientCall3(MIDL_STUBLESS_PROXY_INFO* pProxyInfo, uint nProcNum, void* pReturnValue);

@DllImport("RPCRT4.dll")
CLIENT_CALL_RETURN Ndr64AsyncClientCall(MIDL_STUBLESS_PROXY_INFO* pProxyInfo, uint nProcNum, void* pReturnValue);

@DllImport("RPCRT4.dll")
CLIENT_CALL_RETURN Ndr64DcomAsyncClientCall(MIDL_STUBLESS_PROXY_INFO* pProxyInfo, uint nProcNum, void* pReturnValue);

@DllImport("RPCRT4.dll")
void Ndr64AsyncServerCall64(RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4.dll")
void Ndr64AsyncServerCallAll(RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4.dll")
int Ndr64DcomAsyncStubCall(IRpcStubBuffer pThis, IRpcChannelBuffer pChannel, RPC_MESSAGE* pRpcMsg, uint* pdwStubPhase);

@DllImport("RPCRT4.dll")
int NdrStubCall3(void* pThis, void* pChannel, RPC_MESSAGE* pRpcMsg, uint* pdwStubPhase);

@DllImport("RPCRT4.dll")
void NdrServerCallAll(RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4.dll")
void NdrServerCallNdr64(RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4.dll")
void NdrPartialIgnoreClientMarshall(MIDL_STUB_MESSAGE* pStubMsg, void* pMemory);

@DllImport("RPCRT4.dll")
void NdrPartialIgnoreServerUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, void** ppMemory);

@DllImport("RPCRT4.dll")
void NdrPartialIgnoreClientBufferSize(MIDL_STUB_MESSAGE* pStubMsg, void* pMemory);

@DllImport("RPCRT4.dll")
void NdrPartialIgnoreServerInitialize(MIDL_STUB_MESSAGE* pStubMsg, void** ppMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void RpcUserFree(void* AsyncHandle, void* pBuffer);

@DllImport("RPCRT4.dll")
int MesEncodeIncrementalHandleCreate(void* UserState, MIDL_ES_ALLOC AllocFn, MIDL_ES_WRITE WriteFn, void** pHandle);

@DllImport("RPCRT4.dll")
int MesDecodeIncrementalHandleCreate(void* UserState, MIDL_ES_READ ReadFn, void** pHandle);

@DllImport("RPCRT4.dll")
int MesIncrementalHandleReset(void* Handle, void* UserState, MIDL_ES_ALLOC AllocFn, MIDL_ES_WRITE WriteFn, MIDL_ES_READ ReadFn, MIDL_ES_CODE Operation);

@DllImport("RPCRT4.dll")
int MesEncodeFixedBufferHandleCreate(char* pBuffer, uint BufferSize, uint* pEncodedSize, void** pHandle);

@DllImport("RPCRT4.dll")
int MesEncodeDynBufferHandleCreate(byte** pBuffer, uint* pEncodedSize, void** pHandle);

@DllImport("RPCRT4.dll")
int MesDecodeBufferHandleCreate(char* Buffer, uint BufferSize, void** pHandle);

@DllImport("RPCRT4.dll")
int MesBufferHandleReset(void* Handle, uint HandleStyle, MIDL_ES_CODE Operation, char* pBuffer, uint BufferSize, uint* pEncodedSize);

@DllImport("RPCRT4.dll")
int MesHandleFree(void* Handle);

@DllImport("RPCRT4.dll")
int MesInqProcEncodingId(void* Handle, RPC_SYNTAX_IDENTIFIER* pInterfaceId, uint* pProcNum);

@DllImport("RPCRT4.dll")
uint NdrMesSimpleTypeAlignSize(void* param0);

@DllImport("RPCRT4.dll")
void NdrMesSimpleTypeDecode(void* Handle, void* pObject, short Size);

@DllImport("RPCRT4.dll")
void NdrMesSimpleTypeEncode(void* Handle, const(MIDL_STUB_DESC)* pStubDesc, const(void)* pObject, short Size);

@DllImport("RPCRT4.dll")
uint NdrMesTypeAlignSize(void* Handle, const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString, const(void)* pObject);

@DllImport("RPCRT4.dll")
void NdrMesTypeEncode(void* Handle, const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString, const(void)* pObject);

@DllImport("RPCRT4.dll")
void NdrMesTypeDecode(void* Handle, const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString, void* pObject);

@DllImport("RPCRT4.dll")
uint NdrMesTypeAlignSize2(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString, const(void)* pObject);

@DllImport("RPCRT4.dll")
void NdrMesTypeEncode2(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString, const(void)* pObject);

@DllImport("RPCRT4.dll")
void NdrMesTypeDecode2(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString, void* pObject);

@DllImport("RPCRT4.dll")
void NdrMesTypeFree2(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString, void* pObject);

@DllImport("RPCRT4.dll")
void NdrMesProcEncodeDecode(void* Handle, const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString);

@DllImport("RPCRT4.dll")
CLIENT_CALL_RETURN NdrMesProcEncodeDecode2(void* Handle, const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString);

@DllImport("RPCRT4.dll")
uint NdrMesTypeAlignSize3(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, const(uint)** ArrTypeOffset, uint nTypeIndex, const(void)* pObject);

@DllImport("RPCRT4.dll")
void NdrMesTypeEncode3(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, const(uint)** ArrTypeOffset, uint nTypeIndex, const(void)* pObject);

@DllImport("RPCRT4.dll")
void NdrMesTypeDecode3(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, const(uint)** ArrTypeOffset, uint nTypeIndex, void* pObject);

@DllImport("RPCRT4.dll")
void NdrMesTypeFree3(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, const(uint)** ArrTypeOffset, uint nTypeIndex, void* pObject);

@DllImport("RPCRT4.dll")
CLIENT_CALL_RETURN NdrMesProcEncodeDecode3(void* Handle, const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, uint nProcNum, void* pReturnValue);

@DllImport("RPCRT4.dll")
void NdrMesSimpleTypeDecodeAll(void* Handle, const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, void* pObject, short Size);

@DllImport("RPCRT4.dll")
void NdrMesSimpleTypeEncodeAll(void* Handle, const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, const(void)* pObject, short Size);

@DllImport("RPCRT4.dll")
uint NdrMesSimpleTypeAlignSizeAll(void* Handle, const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo);

@DllImport("RPCRT4.dll")
int RpcCertGeneratePrincipalNameW(CERT_CONTEXT* Context, uint Flags, ushort** pBuffer);

@DllImport("RPCRT4.dll")
int RpcCertGeneratePrincipalNameA(CERT_CONTEXT* Context, uint Flags, ubyte** pBuffer);

struct RPC_BINDING_VECTOR
{
    uint Count;
    void* BindingH;
}

struct UUID_VECTOR
{
    uint Count;
    Guid* Uuid;
}

struct RPC_IF_ID
{
    Guid Uuid;
    ushort VersMajor;
    ushort VersMinor;
}

struct RPC_PROTSEQ_VECTORA
{
    uint Count;
    ubyte* Protseq;
}

struct RPC_PROTSEQ_VECTORW
{
    uint Count;
    ushort* Protseq;
}

struct RPC_POLICY
{
    uint Length;
    uint EndpointFlags;
    uint NICFlags;
}

alias RPC_OBJECT_INQ_FN = extern(Windows) void function(Guid* ObjectUuid, Guid* TypeUuid, int* Status);
alias RPC_IF_CALLBACK_FN = extern(Windows) int function(void* InterfaceUuid, void* Context);
alias RPC_SECURITY_CALLBACK_FN = extern(Windows) void function(void* Context);
struct RPC_STATS_VECTOR
{
    uint Count;
    uint Stats;
}

struct RPC_IF_ID_VECTOR
{
    uint Count;
    RPC_IF_ID* IfId;
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
    uint Flags;
    uint AuthenticationTarget;
    uint NumberOfAuthnSchemes;
    uint* AuthnSchemes;
    ushort* ServerCertificateSubject;
}

struct RPC_HTTP_TRANSPORT_CREDENTIALS_A
{
    SEC_WINNT_AUTH_IDENTITY_A* TransportCredentials;
    uint Flags;
    uint AuthenticationTarget;
    uint NumberOfAuthnSchemes;
    uint* AuthnSchemes;
    ubyte* ServerCertificateSubject;
}

struct RPC_HTTP_TRANSPORT_CREDENTIALS_V2_W
{
    SEC_WINNT_AUTH_IDENTITY_W* TransportCredentials;
    uint Flags;
    uint AuthenticationTarget;
    uint NumberOfAuthnSchemes;
    uint* AuthnSchemes;
    ushort* ServerCertificateSubject;
    SEC_WINNT_AUTH_IDENTITY_W* ProxyCredentials;
    uint NumberOfProxyAuthnSchemes;
    uint* ProxyAuthnSchemes;
}

struct RPC_HTTP_TRANSPORT_CREDENTIALS_V2_A
{
    SEC_WINNT_AUTH_IDENTITY_A* TransportCredentials;
    uint Flags;
    uint AuthenticationTarget;
    uint NumberOfAuthnSchemes;
    uint* AuthnSchemes;
    ubyte* ServerCertificateSubject;
    SEC_WINNT_AUTH_IDENTITY_A* ProxyCredentials;
    uint NumberOfProxyAuthnSchemes;
    uint* ProxyAuthnSchemes;
}

struct RPC_HTTP_TRANSPORT_CREDENTIALS_V3_W
{
    void* TransportCredentials;
    uint Flags;
    uint AuthenticationTarget;
    uint NumberOfAuthnSchemes;
    uint* AuthnSchemes;
    ushort* ServerCertificateSubject;
    void* ProxyCredentials;
    uint NumberOfProxyAuthnSchemes;
    uint* ProxyAuthnSchemes;
}

struct RPC_HTTP_TRANSPORT_CREDENTIALS_V3_A
{
    void* TransportCredentials;
    uint Flags;
    uint AuthenticationTarget;
    uint NumberOfAuthnSchemes;
    uint* AuthnSchemes;
    ubyte* ServerCertificateSubject;
    void* ProxyCredentials;
    uint NumberOfProxyAuthnSchemes;
    uint* ProxyAuthnSchemes;
}

struct RPC_SECURITY_QOS_V2_W
{
    uint Version;
    uint Capabilities;
    uint IdentityTracking;
    uint ImpersonationType;
    uint AdditionalSecurityInfoType;
    _u_e__Union u;
}

struct RPC_SECURITY_QOS_V2_A
{
    uint Version;
    uint Capabilities;
    uint IdentityTracking;
    uint ImpersonationType;
    uint AdditionalSecurityInfoType;
    _u_e__Union u;
}

struct RPC_SECURITY_QOS_V3_W
{
    uint Version;
    uint Capabilities;
    uint IdentityTracking;
    uint ImpersonationType;
    uint AdditionalSecurityInfoType;
    _u_e__Union u;
    void* Sid;
}

struct RPC_SECURITY_QOS_V3_A
{
    uint Version;
    uint Capabilities;
    uint IdentityTracking;
    uint ImpersonationType;
    uint AdditionalSecurityInfoType;
    _u_e__Union u;
    void* Sid;
}

struct RPC_SECURITY_QOS_V4_W
{
    uint Version;
    uint Capabilities;
    uint IdentityTracking;
    uint ImpersonationType;
    uint AdditionalSecurityInfoType;
    _u_e__Union u;
    void* Sid;
    uint EffectiveOnly;
}

struct RPC_SECURITY_QOS_V4_A
{
    uint Version;
    uint Capabilities;
    uint IdentityTracking;
    uint ImpersonationType;
    uint AdditionalSecurityInfoType;
    _u_e__Union u;
    void* Sid;
    uint EffectiveOnly;
}

struct RPC_SECURITY_QOS_V5_W
{
    uint Version;
    uint Capabilities;
    uint IdentityTracking;
    uint ImpersonationType;
    uint AdditionalSecurityInfoType;
    _u_e__Union u;
    void* Sid;
    uint EffectiveOnly;
    void* ServerSecurityDescriptor;
}

struct RPC_SECURITY_QOS_V5_A
{
    uint Version;
    uint Capabilities;
    uint IdentityTracking;
    uint ImpersonationType;
    uint AdditionalSecurityInfoType;
    _u_e__Union u;
    void* Sid;
    uint EffectiveOnly;
    void* ServerSecurityDescriptor;
}

struct RPC_BINDING_HANDLE_TEMPLATE_V1_W
{
    uint Version;
    uint Flags;
    uint ProtocolSequence;
    ushort* NetworkAddress;
    ushort* StringEndpoint;
    _u1_e__Union u1;
    Guid ObjectUuid;
}

struct RPC_BINDING_HANDLE_TEMPLATE_V1_A
{
    uint Version;
    uint Flags;
    uint ProtocolSequence;
    ubyte* NetworkAddress;
    ubyte* StringEndpoint;
    _u1_e__Union u1;
    Guid ObjectUuid;
}

struct RPC_BINDING_HANDLE_SECURITY_V1_W
{
    uint Version;
    ushort* ServerPrincName;
    uint AuthnLevel;
    uint AuthnSvc;
    SEC_WINNT_AUTH_IDENTITY_W* AuthIdentity;
    RPC_SECURITY_QOS* SecurityQos;
}

struct RPC_BINDING_HANDLE_SECURITY_V1_A
{
    uint Version;
    ubyte* ServerPrincName;
    uint AuthnLevel;
    uint AuthnSvc;
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

enum RPC_HTTP_REDIRECTOR_STAGE
{
    RPCHTTP_RS_REDIRECT = 1,
    RPCHTTP_RS_ACCESS_1 = 2,
    RPCHTTP_RS_SESSION = 3,
    RPCHTTP_RS_ACCESS_2 = 4,
    RPCHTTP_RS_INTERFACE = 5,
}

alias RPC_NEW_HTTP_PROXY_CHANNEL = extern(Windows) int function(RPC_HTTP_REDIRECTOR_STAGE RedirectorStage, ushort* ServerName, ushort* ServerPort, ushort* RemoteUser, ushort* AuthType, void* ResourceUuid, void* SessionId, void* Interface, void* Reserved, uint Flags, ushort** NewServerName, ushort** NewServerPort);
alias RPC_HTTP_PROXY_FREE_STRING = extern(Windows) void function(ushort* String);
alias RPC_AUTH_KEY_RETRIEVAL_FN = extern(Windows) void function(void* Arg, ushort* ServerPrincName, uint KeyVer, void** Key, int* Status);
struct RPC_CLIENT_INFORMATION1
{
    ubyte* UserName;
    ubyte* ComputerName;
    ushort Privilege;
    uint AuthFlags;
}

alias RPC_MGMT_AUTHORIZATION_FN = extern(Windows) int function(void* ClientBinding, uint RequestedMgmtOperation, int* Status);
struct RPC_ENDPOINT_TEMPLATEW
{
    uint Version;
    ushort* ProtSeq;
    ushort* Endpoint;
    void* SecurityDescriptor;
    uint Backlog;
}

struct RPC_ENDPOINT_TEMPLATEA
{
    uint Version;
    ubyte* ProtSeq;
    ubyte* Endpoint;
    void* SecurityDescriptor;
    uint Backlog;
}

struct RPC_INTERFACE_TEMPLATEA
{
    uint Version;
    void* IfSpec;
    Guid* MgrTypeUuid;
    void* MgrEpv;
    uint Flags;
    uint MaxCalls;
    uint MaxRpcSize;
    RPC_IF_CALLBACK_FN* IfCallback;
    UUID_VECTOR* UuidVector;
    ubyte* Annotation;
    void* SecurityDescriptor;
}

struct RPC_INTERFACE_TEMPLATEW
{
    uint Version;
    void* IfSpec;
    Guid* MgrTypeUuid;
    void* MgrEpv;
    uint Flags;
    uint MaxCalls;
    uint MaxRpcSize;
    RPC_IF_CALLBACK_FN* IfCallback;
    UUID_VECTOR* UuidVector;
    ushort* Annotation;
    void* SecurityDescriptor;
}

alias RPC_INTERFACE_GROUP_IDLE_CALLBACK_FN = extern(Windows) void function(void* IfGroup, void* IdleCallbackContext, uint IsGroupIdle);
struct RPC_VERSION
{
    ushort MajorVersion;
    ushort MinorVersion;
}

struct RPC_SYNTAX_IDENTIFIER
{
    Guid SyntaxGUID;
    RPC_VERSION SyntaxVersion;
}

struct RPC_MESSAGE
{
    void* Handle;
    uint DataRepresentation;
    void* Buffer;
    uint BufferLength;
    uint ProcNum;
    RPC_SYNTAX_IDENTIFIER* TransferSyntax;
    void* RpcInterfaceInformation;
    void* ReservedForRuntime;
    void* ManagerEpv;
    void* ImportContext;
    uint RpcFlags;
}

alias RPC_FORWARD_FUNCTION = extern(Windows) int function(Guid* InterfaceId, RPC_VERSION* InterfaceVersion, Guid* ObjectId, ubyte* Rpcpro, void** ppDestEndpoint);
enum RPC_ADDRESS_CHANGE_TYPE
{
    PROTOCOL_NOT_LOADED = 1,
    PROTOCOL_LOADED = 2,
    PROTOCOL_ADDRESS_CHANGE = 3,
}

alias RPC_ADDRESS_CHANGE_FN = extern(Windows) void function(void* arg);
alias RPC_DISPATCH_FUNCTION = extern(Windows) void function(RPC_MESSAGE* Message);
struct RPC_DISPATCH_TABLE
{
    uint DispatchTableCount;
    RPC_DISPATCH_FUNCTION* DispatchTable;
    int Reserved;
}

struct RPC_PROTSEQ_ENDPOINT
{
    ubyte* RpcProtocolSequence;
    ubyte* Endpoint;
}

struct RPC_SERVER_INTERFACE
{
    uint Length;
    RPC_SYNTAX_IDENTIFIER InterfaceId;
    RPC_SYNTAX_IDENTIFIER TransferSyntax;
    RPC_DISPATCH_TABLE* DispatchTable;
    uint RpcProtseqEndpointCount;
    RPC_PROTSEQ_ENDPOINT* RpcProtseqEndpoint;
    void* DefaultManagerEpv;
    const(void)* InterpreterInfo;
    uint Flags;
}

struct RPC_CLIENT_INTERFACE
{
    uint Length;
    RPC_SYNTAX_IDENTIFIER InterfaceId;
    RPC_SYNTAX_IDENTIFIER TransferSyntax;
    RPC_DISPATCH_TABLE* DispatchTable;
    uint RpcProtseqEndpointCount;
    RPC_PROTSEQ_ENDPOINT* RpcProtseqEndpoint;
    uint Reserved;
    const(void)* InterpreterInfo;
    uint Flags;
}

enum LRPC_SYSTEM_HANDLE_MARSHAL_DIRECTION
{
    MarshalDirectionMarshal = 0,
    MarshalDirectionUnmarshal = 1,
}

alias PRPC_RUNDOWN = extern(Windows) void function(void* AssociationContext);
struct RPC_SEC_CONTEXT_KEY_INFO
{
    uint EncryptAlgorithm;
    uint KeySize;
    uint SignatureAlgorithm;
}

struct RPC_TRANSFER_SYNTAX
{
    Guid Uuid;
    ushort VersMajor;
    ushort VersMinor;
}

alias RPCLT_PDU_FILTER_FUNC = extern(Windows) void function(void* Buffer, uint BufferLength, int fDatagram);
alias RPC_SETFILTER_FUNC = extern(Windows) void function(RPCLT_PDU_FILTER_FUNC pfnFilter);
alias RPC_BLOCKING_FN = extern(Windows) int function(void* hWnd, void* Context, void* hSyncEvent);
struct RPC_C_OPT_COOKIE_AUTH_DESCRIPTOR
{
    uint BufferSize;
    byte* Buffer;
}

struct RDR_CALLOUT_STATE
{
    int LastError;
    void* LastEEInfo;
    RPC_HTTP_REDIRECTOR_STAGE LastCalledStage;
    ushort* ServerName;
    ushort* ServerPort;
    ushort* RemoteUser;
    ushort* AuthType;
    ubyte ResourceTypePresent;
    ubyte SessionIdPresent;
    ubyte InterfacePresent;
    Guid ResourceType;
    Guid SessionId;
    RPC_SYNTAX_IDENTIFIER Interface;
    void* CertContext;
}

alias I_RpcProxyIsValidMachineFn = extern(Windows) int function(ushort* Machine, ushort* DotMachine, uint PortNumber);
alias I_RpcProxyGetClientAddressFn = extern(Windows) int function(void* Context, byte* Buffer, uint* BufferLength);
alias I_RpcProxyGetConnectionTimeoutFn = extern(Windows) int function(uint* ConnectionTimeout);
alias I_RpcPerformCalloutFn = extern(Windows) int function(void* Context, RDR_CALLOUT_STATE* CallOutState, RPC_HTTP_REDIRECTOR_STAGE Stage);
alias I_RpcFreeCalloutStateFn = extern(Windows) void function(RDR_CALLOUT_STATE* CallOutState);
alias I_RpcProxyGetClientSessionAndResourceUUID = extern(Windows) int function(void* Context, int* SessionIdPresent, Guid* SessionId, int* ResourceIdPresent, Guid* ResourceId);
alias I_RpcProxyFilterIfFn = extern(Windows) int function(void* Context, Guid* IfUuid, ushort IfMajorVersion, int* fAllow);
enum RpcProxyPerfCounters
{
    RpcCurrentUniqueUser = 1,
    RpcBackEndConnectionAttempts = 2,
    RpcBackEndConnectionFailed = 3,
    RpcRequestsPerSecond = 4,
    RpcIncomingConnections = 5,
    RpcIncomingBandwidth = 6,
    RpcOutgoingBandwidth = 7,
    RpcAttemptedLbsDecisions = 8,
    RpcFailedLbsDecisions = 9,
    RpcAttemptedLbsMessages = 10,
    RpcFailedLbsMessages = 11,
    RpcLastCounter = 12,
}

alias I_RpcProxyUpdatePerfCounterFn = extern(Windows) void function(RpcProxyPerfCounters Counter, int ModifyTrend, uint Size);
alias I_RpcProxyUpdatePerfCounterBackendServerFn = extern(Windows) void function(ushort* MachineName, int IsConnectEvent);
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

enum RPC_NOTIFICATION_TYPES
{
    RpcNotificationTypeNone = 0,
    RpcNotificationTypeEvent = 1,
    RpcNotificationTypeApc = 2,
    RpcNotificationTypeIoc = 3,
    RpcNotificationTypeHwnd = 4,
    RpcNotificationTypeCallback = 5,
}

enum RPC_ASYNC_EVENT
{
    RpcCallComplete = 0,
    RpcSendComplete = 1,
    RpcReceiveComplete = 2,
    RpcClientDisconnect = 3,
    RpcClientCancel = 4,
}

alias RPCNOTIFICATION_ROUTINE = extern(Windows) void function(RPC_ASYNC_STATE* pAsync, void* Context, RPC_ASYNC_EVENT Event);
alias PFN_RPCNOTIFICATION_ROUTINE = extern(Windows) void function();
struct RPC_ASYNC_NOTIFICATION_INFO
{
    _APC_e__Struct APC;
    _IOC_e__Struct IOC;
    _IntPtr_e__Struct IntPtr;
    HANDLE hEvent;
    PFN_RPCNOTIFICATION_ROUTINE NotificationRoutine;
}

struct RPC_ASYNC_STATE
{
    uint Size;
    uint Signature;
    int Lock;
    uint Flags;
    void* StubInfo;
    void* UserInfo;
    void* RuntimeInfo;
    RPC_ASYNC_EVENT Event;
    RPC_NOTIFICATION_TYPES NotificationType;
    RPC_ASYNC_NOTIFICATION_INFO u;
    int Reserved;
}

enum ExtendedErrorParamTypes
{
    eeptAnsiString = 1,
    eeptUnicodeString = 2,
    eeptLongVal = 3,
    eeptShortVal = 4,
    eeptPointerVal = 5,
    eeptNone = 6,
    eeptBinary = 7,
}

struct BinaryParam
{
    void* Buffer;
    short Size;
}

struct RPC_EE_INFO_PARAM
{
    ExtendedErrorParamTypes ParameterType;
    _u_e__Union u;
}

struct RPC_EXTENDED_ERROR_INFO
{
    uint Version;
    const(wchar)* ComputerName;
    uint ProcessID;
    _u_e__Union u;
    uint GeneratingComponent;
    uint Status;
    ushort DetectionLocation;
    ushort Flags;
    int NumberOfParameters;
    RPC_EE_INFO_PARAM Parameters;
}

struct RPC_ERROR_ENUM_HANDLE
{
    uint Signature;
    void* CurrentPos;
    void* Head;
}

enum RpcLocalAddressFormat
{
    rlafInvalid = 0,
    rlafIPv4 = 1,
    rlafIPv6 = 2,
}

struct RPC_CALL_LOCAL_ADDRESS_V1
{
    uint Version;
    void* Buffer;
    uint BufferSize;
    RpcLocalAddressFormat AddressFormat;
}

struct RPC_CALL_ATTRIBUTES_V1_W
{
    uint Version;
    uint Flags;
    uint ServerPrincipalNameBufferLength;
    ushort* ServerPrincipalName;
    uint ClientPrincipalNameBufferLength;
    ushort* ClientPrincipalName;
    uint AuthenticationLevel;
    uint AuthenticationService;
    BOOL NullSession;
}

struct RPC_CALL_ATTRIBUTES_V1_A
{
    uint Version;
    uint Flags;
    uint ServerPrincipalNameBufferLength;
    ubyte* ServerPrincipalName;
    uint ClientPrincipalNameBufferLength;
    ubyte* ClientPrincipalName;
    uint AuthenticationLevel;
    uint AuthenticationService;
    BOOL NullSession;
}

enum RpcCallType
{
    rctInvalid = 0,
    rctNormal = 1,
    rctTraining = 2,
    rctGuaranteed = 3,
}

enum RpcCallClientLocality
{
    rcclInvalid = 0,
    rcclLocal = 1,
    rcclRemote = 2,
    rcclClientUnknownLocality = 3,
}

struct RPC_CALL_ATTRIBUTES_V2_W
{
    uint Version;
    uint Flags;
    uint ServerPrincipalNameBufferLength;
    ushort* ServerPrincipalName;
    uint ClientPrincipalNameBufferLength;
    ushort* ClientPrincipalName;
    uint AuthenticationLevel;
    uint AuthenticationService;
    BOOL NullSession;
    BOOL KernelModeCaller;
    uint ProtocolSequence;
    RpcCallClientLocality IsClientLocal;
    HANDLE ClientPID;
    uint CallStatus;
    RpcCallType CallType;
    RPC_CALL_LOCAL_ADDRESS_V1* CallLocalAddress;
    ushort OpNum;
    Guid InterfaceUuid;
}

struct RPC_CALL_ATTRIBUTES_V2_A
{
    uint Version;
    uint Flags;
    uint ServerPrincipalNameBufferLength;
    ubyte* ServerPrincipalName;
    uint ClientPrincipalNameBufferLength;
    ubyte* ClientPrincipalName;
    uint AuthenticationLevel;
    uint AuthenticationService;
    BOOL NullSession;
    BOOL KernelModeCaller;
    uint ProtocolSequence;
    uint IsClientLocal;
    HANDLE ClientPID;
    uint CallStatus;
    RpcCallType CallType;
    RPC_CALL_LOCAL_ADDRESS_V1* CallLocalAddress;
    ushort OpNum;
    Guid InterfaceUuid;
}

struct RPC_CALL_ATTRIBUTES_V3_W
{
    uint Version;
    uint Flags;
    uint ServerPrincipalNameBufferLength;
    ushort* ServerPrincipalName;
    uint ClientPrincipalNameBufferLength;
    ushort* ClientPrincipalName;
    uint AuthenticationLevel;
    uint AuthenticationService;
    BOOL NullSession;
    BOOL KernelModeCaller;
    uint ProtocolSequence;
    RpcCallClientLocality IsClientLocal;
    HANDLE ClientPID;
    uint CallStatus;
    RpcCallType CallType;
    RPC_CALL_LOCAL_ADDRESS_V1* CallLocalAddress;
    ushort OpNum;
    Guid InterfaceUuid;
    uint ClientIdentifierBufferLength;
    ubyte* ClientIdentifier;
}

struct RPC_CALL_ATTRIBUTES_V3_A
{
    uint Version;
    uint Flags;
    uint ServerPrincipalNameBufferLength;
    ubyte* ServerPrincipalName;
    uint ClientPrincipalNameBufferLength;
    ubyte* ClientPrincipalName;
    uint AuthenticationLevel;
    uint AuthenticationService;
    BOOL NullSession;
    BOOL KernelModeCaller;
    uint ProtocolSequence;
    uint IsClientLocal;
    HANDLE ClientPID;
    uint CallStatus;
    RpcCallType CallType;
    RPC_CALL_LOCAL_ADDRESS_V1* CallLocalAddress;
    ushort OpNum;
    Guid InterfaceUuid;
    uint ClientIdentifierBufferLength;
    ubyte* ClientIdentifier;
}

enum RPC_NOTIFICATIONS
{
    RpcNotificationCallNone = 0,
    RpcNotificationClientDisconnect = 1,
    RpcNotificationCallCancel = 2,
}

struct __AnonymousRecord_rpcndr_L275_C9
{
    void* pad;
    void* userContext;
}

alias NDR_RUNDOWN = extern(Windows) void function(void* context);
alias NDR_NOTIFY_ROUTINE = extern(Windows) void function();
alias NDR_NOTIFY2_ROUTINE = extern(Windows) void function(ubyte flag);
struct SCONTEXT_QUEUE
{
    uint NumberOfObjects;
    NDR_SCONTEXT_1** ArrayOfObjects;
}

alias EXPR_EVAL = extern(Windows) void function(MIDL_STUB_MESSAGE* param0);
struct ARRAY_INFO
{
    int Dimension;
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
    RPC_MESSAGE* RpcMsg;
    ubyte* Buffer;
    ubyte* BufferStart;
    ubyte* BufferEnd;
    ubyte* BufferMark;
    uint BufferLength;
    uint MemorySize;
    ubyte* Memory;
    ubyte IsClient;
    ubyte Pad;
    ushort uFlags2;
    int ReuseBuffer;
    NDR_ALLOC_ALL_NODES_CONTEXT* pAllocAllNodesContext;
    NDR_POINTER_QUEUE_STATE* pPointerQueueState;
    int IgnoreEmbeddedPointers;
    ubyte* PointerBufferMark;
    ubyte CorrDespIncrement;
    ubyte uFlags;
    ushort UniquePtrCount;
    uint MaxCount;
    uint Offset;
    uint ActualCount;
    int pfnAllocate;
    int pfnFree;
    ubyte* StackTop;
    ubyte* pPresentedType;
    ubyte* pTransmitType;
    void* SavedHandle;
    const(MIDL_STUB_DESC)* StubDesc;
    FULL_PTR_XLAT_TABLES* FullPtrXlatTables;
    uint FullPtrRefId;
    uint PointerLength;
    int _bitfield;
    uint dwDestContext;
    void* pvDestContext;
    NDR_SCONTEXT_1** SavedContextHandles;
    int ParamNumber;
    IRpcChannelBuffer pRpcChannelBuffer;
    ARRAY_INFO* pArrayInfo;
    uint* SizePtrCountArray;
    uint* SizePtrOffsetArray;
    uint* SizePtrLengthArray;
    void* pArgQueue;
    uint dwStubPhase;
    void* LowStackMark;
    _NDR_ASYNC_MESSAGE* pAsyncMsg;
    _NDR_CORRELATION_INFO* pCorrInfo;
    ubyte* pCorrMemory;
    void* pMemoryList;
    int pCSInfo;
    ubyte* ConformanceMark;
    ubyte* VarianceMark;
    int Unused;
    _NDR_PROC_CONTEXT* pContext;
    void* ContextHandleHash;
    void* pUserMarshalList;
    int Reserved51_3;
    int Reserved51_4;
    int Reserved51_5;
}

alias GENERIC_BINDING_ROUTINE = extern(Windows) void* function(void* param0);
alias GENERIC_UNBIND_ROUTINE = extern(Windows) void function(void* param0, ubyte* param1);
struct GENERIC_BINDING_ROUTINE_PAIR
{
    GENERIC_BINDING_ROUTINE pfnBind;
    GENERIC_UNBIND_ROUTINE pfnUnbind;
}

struct __GENERIC_BINDING_INFO
{
    void* pObj;
    uint Size;
    GENERIC_BINDING_ROUTINE pfnBind;
    GENERIC_UNBIND_ROUTINE pfnUnbind;
}

alias XMIT_HELPER_ROUTINE = extern(Windows) void function(MIDL_STUB_MESSAGE* param0);
struct XMIT_ROUTINE_QUINTUPLE
{
    XMIT_HELPER_ROUTINE pfnTranslateToXmit;
    XMIT_HELPER_ROUTINE pfnTranslateFromXmit;
    XMIT_HELPER_ROUTINE pfnFreeXmit;
    XMIT_HELPER_ROUTINE pfnFreeInst;
}

alias USER_MARSHAL_SIZING_ROUTINE = extern(Windows) uint function(uint* param0, uint param1, void* param2);
alias USER_MARSHAL_MARSHALLING_ROUTINE = extern(Windows) ubyte* function(uint* param0, ubyte* param1, void* param2);
alias USER_MARSHAL_UNMARSHALLING_ROUTINE = extern(Windows) ubyte* function(uint* param0, ubyte* param1, void* param2);
alias USER_MARSHAL_FREEING_ROUTINE = extern(Windows) void function(uint* param0, void* param1);
struct USER_MARSHAL_ROUTINE_QUADRUPLE
{
    USER_MARSHAL_SIZING_ROUTINE pfnBufferSize;
    USER_MARSHAL_MARSHALLING_ROUTINE pfnMarshall;
    USER_MARSHAL_UNMARSHALLING_ROUTINE pfnUnmarshall;
    USER_MARSHAL_FREEING_ROUTINE pfnFree;
}

enum USER_MARSHAL_CB_TYPE
{
    USER_MARSHAL_CB_BUFFER_SIZE = 0,
    USER_MARSHAL_CB_MARSHALL = 1,
    USER_MARSHAL_CB_UNMARSHALL = 2,
    USER_MARSHAL_CB_FREE = 3,
}

struct USER_MARSHAL_CB
{
    uint Flags;
    MIDL_STUB_MESSAGE* pStubMsg;
    ubyte* pReserve;
    uint Signature;
    USER_MARSHAL_CB_TYPE CBType;
    ubyte* pFormat;
    ubyte* pTypeFormat;
}

struct MALLOC_FREE_STRUCT
{
    int pfnAllocate;
    int pfnFree;
}

struct COMM_FAULT_OFFSETS
{
    short CommOffset;
    short FaultOffset;
}

enum IDL_CS_CONVERT
{
    IDL_CS_NO_CONVERT = 0,
    IDL_CS_IN_PLACE_CONVERT = 1,
    IDL_CS_NEW_BUFFER_CONVERT = 2,
}

alias CS_TYPE_NET_SIZE_ROUTINE = extern(Windows) void function(void* hBinding, uint ulNetworkCodeSet, uint ulLocalBufferSize, IDL_CS_CONVERT* conversionType, uint* pulNetworkBufferSize, uint* pStatus);
alias CS_TYPE_LOCAL_SIZE_ROUTINE = extern(Windows) void function(void* hBinding, uint ulNetworkCodeSet, uint ulNetworkBufferSize, IDL_CS_CONVERT* conversionType, uint* pulLocalBufferSize, uint* pStatus);
alias CS_TYPE_TO_NETCS_ROUTINE = extern(Windows) void function(void* hBinding, uint ulNetworkCodeSet, void* pLocalData, uint ulLocalDataLength, ubyte* pNetworkData, uint* pulNetworkDataLength, uint* pStatus);
alias CS_TYPE_FROM_NETCS_ROUTINE = extern(Windows) void function(void* hBinding, uint ulNetworkCodeSet, ubyte* pNetworkData, uint ulNetworkDataLength, uint ulLocalBufferSize, void* pLocalData, uint* pulLocalDataLength, uint* pStatus);
alias CS_TAG_GETTING_ROUTINE = extern(Windows) void function(void* hBinding, int fServerSide, uint* pulSendingTag, uint* pulDesiredReceivingTag, uint* pulReceivingTag, uint* pStatus);
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
    ubyte* pFormatExpr;
}

struct MIDL_STUB_DESC
{
    void* RpcInterfaceInformation;
    int pfnAllocate;
    int pfnFree;
    _IMPLICIT_HANDLE_INFO_e__Union IMPLICIT_HANDLE_INFO;
    const(int)* apfnNdrRundownRoutines;
    const(GENERIC_BINDING_ROUTINE_PAIR)* aGenericBindingRoutinePairs;
    const(int)* apfnExprEval;
    const(XMIT_ROUTINE_QUINTUPLE)* aXmitQuintuple;
    const(ubyte)* pFormatTypes;
    int fCheckBounds;
    uint Version;
    MALLOC_FREE_STRUCT* pMallocFreeStruct;
    int MIDLVersion;
    const(COMM_FAULT_OFFSETS)* CommFaultOffsets;
    const(USER_MARSHAL_ROUTINE_QUADRUPLE)* aUserMarshalQuadruple;
    const(int)* NotifyRoutineTable;
    uint mFlags;
    const(NDR_CS_ROUTINES)* CsRoutineTables;
    void* ProxyServerInfo;
    const(NDR_EXPR_DESC)* pExprInfo;
}

struct MIDL_FORMAT_STRING
{
    short Pad;
    ubyte Format;
}

alias STUB_THUNK = extern(Windows) void function(MIDL_STUB_MESSAGE* param0);
alias SERVER_ROUTINE = extern(Windows) int function();
struct MIDL_METHOD_PROPERTY
{
    uint Id;
    uint Value;
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
    MIDL_STUB_DESC* pStubDesc;
    const(int)* DispatchTable;
    ubyte* ProcString;
    const(ushort)* FmtStringOffset;
    const(int)* ThunkTable;
    RPC_SYNTAX_IDENTIFIER* pTransferSyntax;
    uint nCount;
    MIDL_SYNTAX_INFO* pSyntaxInfo;
}

struct MIDL_STUBLESS_PROXY_INFO
{
    MIDL_STUB_DESC* pStubDesc;
    ubyte* ProcFormatString;
    const(ushort)* FormatStringOffset;
    RPC_SYNTAX_IDENTIFIER* pTransferSyntax;
    uint nCount;
    MIDL_SYNTAX_INFO* pSyntaxInfo;
}

struct MIDL_SYNTAX_INFO
{
    RPC_SYNTAX_IDENTIFIER TransferSyntax;
    RPC_DISPATCH_TABLE* DispatchTable;
    ubyte* ProcString;
    const(ushort)* FmtStringOffset;
    ubyte* TypeString;
    const(void)* aUserMarshalQuadruple;
    const(MIDL_INTERFACE_METHOD_PROPERTIES)* pMethodProperties;
    uint pReserved2;
}

struct CLIENT_CALL_RETURN
{
    void* Pointer;
    int Simple;
}

enum XLAT_SIDE
{
    XLAT_SERVER = 1,
    XLAT_CLIENT = 2,
}

struct FULL_PTR_XLAT_TABLES
{
    void* RefIdToPointer;
    void* PointerToRefId;
    uint NextRefId;
    XLAT_SIDE XlatSide;
}

enum system_handle_t
{
    SYSTEM_HANDLE_FILE = 0,
    SYSTEM_HANDLE_SEMAPHORE = 1,
    SYSTEM_HANDLE_EVENT = 2,
    SYSTEM_HANDLE_MUTEX = 3,
    SYSTEM_HANDLE_PROCESS = 4,
    SYSTEM_HANDLE_TOKEN = 5,
    SYSTEM_HANDLE_SECTION = 6,
    SYSTEM_HANDLE_REG_KEY = 7,
    SYSTEM_HANDLE_THREAD = 8,
    SYSTEM_HANDLE_COMPOSITION_OBJECT = 9,
    SYSTEM_HANDLE_SOCKET = 10,
    SYSTEM_HANDLE_JOB = 11,
    SYSTEM_HANDLE_PIPE = 12,
    SYSTEM_HANDLE_MAX = 12,
    SYSTEM_HANDLE_INVALID = 255,
}

struct MIDL_INTERCEPTION_INFO
{
    uint Version;
    ubyte* ProcString;
    const(ushort)* ProcFormatOffsetTable;
    uint ProcCount;
    ubyte* TypeString;
}

struct MIDL_WINRT_TYPE_SERIALIZATION_INFO
{
    uint Version;
    ubyte* TypeFormatString;
    ushort FormatStringSize;
    ushort TypeOffset;
    MIDL_STUB_DESC* StubDesc;
}

enum STUB_PHASE
{
    STUB_UNMARSHAL = 0,
    STUB_CALL_SERVER = 1,
    STUB_MARSHAL = 2,
    STUB_CALL_SERVER_NO_HRESULT = 3,
}

enum PROXY_PHASE
{
    PROXY_CALCSIZE = 0,
    PROXY_GETBUFFER = 1,
    PROXY_MARSHAL = 2,
    PROXY_SENDRECEIVE = 3,
    PROXY_UNMARSHAL = 4,
}

alias RPC_CLIENT_ALLOC = extern(Windows) void* function(uint Size);
alias RPC_CLIENT_FREE = extern(Windows) void function(void* Ptr);
struct NDR_USER_MARSHAL_INFO_LEVEL1
{
    void* Buffer;
    uint BufferSize;
    int pfnAllocate;
    int pfnFree;
    IRpcChannelBuffer pRpcChannelBuffer;
    uint Reserved;
}

struct NDR_USER_MARSHAL_INFO
{
    uint InformationLevel;
    _Anonymous_e__Union Anonymous;
}

enum MIDL_ES_CODE
{
    MES_ENCODE = 0,
    MES_DECODE = 1,
    MES_ENCODE_NDR64 = 2,
}

enum MIDL_ES_HANDLE_STYLE
{
    MES_INCREMENTAL_HANDLE = 0,
    MES_FIXED_BUFFER_HANDLE = 1,
    MES_DYNAMIC_BUFFER_HANDLE = 2,
}

alias MIDL_ES_ALLOC = extern(Windows) void function(void* state, byte** pbuffer, uint* psize);
alias MIDL_ES_WRITE = extern(Windows) void function(void* state, byte* buffer, uint size);
alias MIDL_ES_READ = extern(Windows) void function(void* state, byte** pbuffer, uint* psize);
struct MIDL_TYPE_PICKLING_INFO
{
    uint Version;
    uint Flags;
    uint Reserved;
}

