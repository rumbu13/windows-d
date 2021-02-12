module windows.com;

public import system;
public import windows.automation;
public import windows.componentservices;
public import windows.controls;
public import windows.displaydevices;
public import windows.gdi;
public import windows.menusandresources;
public import windows.security;
public import windows.shell;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.winrt;
public import windows.winsock;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

struct COAUTHIDENTITY
{
    ushort* User;
    uint UserLength;
    ushort* Domain;
    uint DomainLength;
    ushort* Password;
    uint PasswordLength;
    uint Flags;
}

struct COAUTHINFO
{
    uint dwAuthnSvc;
    uint dwAuthzSvc;
    const(wchar)* pwszServerPrincName;
    uint dwAuthnLevel;
    uint dwImpersonationLevel;
    COAUTHIDENTITY* pAuthIdentityData;
    uint dwCapabilities;
}

enum MEMCTX
{
    MEMCTX_TASK = 1,
    MEMCTX_SHARED = 2,
    MEMCTX_MACSYSTEM = 3,
    MEMCTX_UNKNOWN = -1,
    MEMCTX_SAME = -2,
}

enum CLSCTX
{
    CLSCTX_INPROC_SERVER = 1,
    CLSCTX_INPROC_HANDLER = 2,
    CLSCTX_LOCAL_SERVER = 4,
    CLSCTX_INPROC_SERVER16 = 8,
    CLSCTX_REMOTE_SERVER = 16,
    CLSCTX_INPROC_HANDLER16 = 32,
    CLSCTX_RESERVED1 = 64,
    CLSCTX_RESERVED2 = 128,
    CLSCTX_RESERVED3 = 256,
    CLSCTX_RESERVED4 = 512,
    CLSCTX_NO_CODE_DOWNLOAD = 1024,
    CLSCTX_RESERVED5 = 2048,
    CLSCTX_NO_CUSTOM_MARSHAL = 4096,
    CLSCTX_ENABLE_CODE_DOWNLOAD = 8192,
    CLSCTX_NO_FAILURE_LOG = 16384,
    CLSCTX_DISABLE_AAA = 32768,
    CLSCTX_ENABLE_AAA = 65536,
    CLSCTX_FROM_DEFAULT_CONTEXT = 131072,
    CLSCTX_ACTIVATE_X86_SERVER = 262144,
    CLSCTX_ACTIVATE_32_BIT_SERVER = 262144,
    CLSCTX_ACTIVATE_64_BIT_SERVER = 524288,
    CLSCTX_ENABLE_CLOAKING = 1048576,
    CLSCTX_APPCONTAINER = 4194304,
    CLSCTX_ACTIVATE_AAA_AS_IU = 8388608,
    CLSCTX_RESERVED6 = 16777216,
    CLSCTX_ACTIVATE_ARM32_SERVER = 33554432,
    CLSCTX_PS_DLL = -2147483648,
}

enum MSHLFLAGS
{
    MSHLFLAGS_NORMAL = 0,
    MSHLFLAGS_TABLESTRONG = 1,
    MSHLFLAGS_TABLEWEAK = 2,
    MSHLFLAGS_NOPING = 4,
    MSHLFLAGS_RESERVED1 = 8,
    MSHLFLAGS_RESERVED2 = 16,
    MSHLFLAGS_RESERVED3 = 32,
    MSHLFLAGS_RESERVED4 = 64,
}

enum MSHCTX
{
    MSHCTX_LOCAL = 0,
    MSHCTX_NOSHAREDMEM = 1,
    MSHCTX_DIFFERENTMACHINE = 2,
    MSHCTX_INPROC = 3,
    MSHCTX_CROSSCTX = 4,
    MSHCTX_RESERVED1 = 5,
}

struct BYTE_BLOB
{
    uint clSize;
    ubyte abData;
}

struct WORD_BLOB
{
    uint clSize;
    ushort asData;
}

struct DWORD_BLOB
{
    uint clSize;
    uint alData;
}

struct FLAGGED_BYTE_BLOB
{
    uint fFlags;
    uint clSize;
    ubyte abData;
}

struct FLAGGED_WORD_BLOB
{
    uint fFlags;
    uint clSize;
    ushort asData;
}

struct BYTE_SIZEDARR
{
    uint clSize;
    ubyte* pData;
}

struct SHORT_SIZEDARR
{
    uint clSize;
    ushort* pData;
}

struct LONG_SIZEDARR
{
    uint clSize;
    uint* pData;
}

struct HYPER_SIZEDARR
{
    uint clSize;
    long* pData;
}

enum REGCLS
{
    REGCLS_SINGLEUSE = 0,
    REGCLS_MULTIPLEUSE = 1,
    REGCLS_MULTI_SEPARATE = 2,
    REGCLS_SUSPENDED = 4,
    REGCLS_SURROGATE = 8,
    REGCLS_AGILE = 16,
}

enum COINITBASE
{
    COINITBASE_MULTITHREADED = 0,
}

const GUID IID_IUnknown = {0x00000000, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000000, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IUnknown
{
    HRESULT QueryInterface(const(Guid)* riid, void** ppvObject);
    uint AddRef();
    uint Release();
}

const GUID IID_AsyncIUnknown = {0x000E0000, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000E0000, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface AsyncIUnknown : IUnknown
{
    HRESULT Begin_QueryInterface(const(Guid)* riid);
    HRESULT Finish_QueryInterface(void** ppvObject);
    HRESULT Begin_AddRef();
    uint Finish_AddRef();
    HRESULT Begin_Release();
    uint Finish_Release();
}

const GUID IID_IClassFactory = {0x00000001, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000001, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IClassFactory : IUnknown
{
    HRESULT CreateInstance(IUnknown pUnkOuter, const(Guid)* riid, void** ppvObject);
    HRESULT LockServer(BOOL fLock);
}

struct IEnumContextProps
{
}

struct IContext
{
}

struct IObjContext
{
}

struct COSERVERINFO
{
    uint dwReserved1;
    const(wchar)* pwszName;
    COAUTHINFO* pAuthInfo;
    uint dwReserved2;
}

const GUID IID_IMarshal = {0x00000003, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000003, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IMarshal : IUnknown
{
    HRESULT GetUnmarshalClass(const(Guid)* riid, void* pv, uint dwDestContext, void* pvDestContext, uint mshlflags, Guid* pCid);
    HRESULT GetMarshalSizeMax(const(Guid)* riid, void* pv, uint dwDestContext, void* pvDestContext, uint mshlflags, uint* pSize);
    HRESULT MarshalInterface(IStream pStm, const(Guid)* riid, void* pv, uint dwDestContext, void* pvDestContext, uint mshlflags);
    HRESULT UnmarshalInterface(IStream pStm, const(Guid)* riid, void** ppv);
    HRESULT ReleaseMarshalData(IStream pStm);
    HRESULT DisconnectObject(uint dwReserved);
}

const GUID IID_INoMarshal = {0xECC8691B, 0xC1DB, 0x4DC0, [0x85, 0x5E, 0x65, 0xF6, 0xC5, 0x51, 0xAF, 0x49]};
@GUID(0xECC8691B, 0xC1DB, 0x4DC0, [0x85, 0x5E, 0x65, 0xF6, 0xC5, 0x51, 0xAF, 0x49]);
interface INoMarshal : IUnknown
{
}

const GUID IID_IAgileObject = {0x94EA2B94, 0xE9CC, 0x49E0, [0xC0, 0xFF, 0xEE, 0x64, 0xCA, 0x8F, 0x5B, 0x90]};
@GUID(0x94EA2B94, 0xE9CC, 0x49E0, [0xC0, 0xFF, 0xEE, 0x64, 0xCA, 0x8F, 0x5B, 0x90]);
interface IAgileObject : IUnknown
{
}

const GUID IID_IActivationFilter = {0x00000017, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000017, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IActivationFilter : IUnknown
{
    HRESULT HandleActivation(uint dwActivationType, const(Guid)* rclsid, Guid* pReplacementClsId);
}

const GUID IID_IMarshal2 = {0x000001CF, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000001CF, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IMarshal2 : IMarshal
{
}

const GUID IID_IMalloc = {0x00000002, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000002, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IMalloc : IUnknown
{
    void* Alloc(uint cb);
    void* Realloc(void* pv, uint cb);
    void Free(void* pv);
    uint GetSize(void* pv);
    int DidAlloc(void* pv);
    void HeapMinimize();
}

const GUID IID_IStdMarshalInfo = {0x00000018, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000018, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IStdMarshalInfo : IUnknown
{
    HRESULT GetClassForHandler(uint dwDestContext, void* pvDestContext, Guid* pClsid);
}

enum EXTCONN
{
    EXTCONN_STRONG = 1,
    EXTCONN_WEAK = 2,
    EXTCONN_CALLABLE = 4,
}

const GUID IID_IExternalConnection = {0x00000019, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000019, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IExternalConnection : IUnknown
{
    uint AddConnection(uint extconn, uint reserved);
    uint ReleaseConnection(uint extconn, uint reserved, BOOL fLastReleaseCloses);
}

struct MULTI_QI
{
    const(Guid)* pIID;
    IUnknown pItf;
    HRESULT hr;
}

const GUID IID_IMultiQI = {0x00000020, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000020, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IMultiQI : IUnknown
{
    HRESULT QueryMultipleInterfaces(uint cMQIs, char* pMQIs);
}

const GUID IID_AsyncIMultiQI = {0x000E0020, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000E0020, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface AsyncIMultiQI : IUnknown
{
    HRESULT Begin_QueryMultipleInterfaces(uint cMQIs, char* pMQIs);
    HRESULT Finish_QueryMultipleInterfaces(char* pMQIs);
}

const GUID IID_IInternalUnknown = {0x00000021, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000021, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IInternalUnknown : IUnknown
{
    HRESULT QueryInternalInterface(const(Guid)* riid, void** ppv);
}

const GUID IID_IEnumUnknown = {0x00000100, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000100, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IEnumUnknown : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumUnknown* ppenum);
}

const GUID IID_IEnumString = {0x00000101, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000101, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IEnumString : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumString* ppenum);
}

struct RPCOLEMESSAGE
{
    void* reserved1;
    uint dataRepresentation;
    void* Buffer;
    uint cbBuffer;
    uint iMethod;
    void* reserved2;
    uint rpcFlags;
}

const GUID IID_IRpcChannelBuffer = {0xD5F56B60, 0x593B, 0x101A, [0xB5, 0x69, 0x08, 0x00, 0x2B, 0x2D, 0xBF, 0x7A]};
@GUID(0xD5F56B60, 0x593B, 0x101A, [0xB5, 0x69, 0x08, 0x00, 0x2B, 0x2D, 0xBF, 0x7A]);
interface IRpcChannelBuffer : IUnknown
{
    HRESULT GetBuffer(RPCOLEMESSAGE* pMessage, const(Guid)* riid);
    HRESULT SendReceive(RPCOLEMESSAGE* pMessage, uint* pStatus);
    HRESULT FreeBuffer(RPCOLEMESSAGE* pMessage);
    HRESULT GetDestCtx(uint* pdwDestContext, void** ppvDestContext);
    HRESULT IsConnected();
}

const GUID IID_IRpcChannelBuffer2 = {0x594F31D0, 0x7F19, 0x11D0, [0xB1, 0x94, 0x00, 0xA0, 0xC9, 0x0D, 0xC8, 0xBF]};
@GUID(0x594F31D0, 0x7F19, 0x11D0, [0xB1, 0x94, 0x00, 0xA0, 0xC9, 0x0D, 0xC8, 0xBF]);
interface IRpcChannelBuffer2 : IRpcChannelBuffer
{
    HRESULT GetProtocolVersion(uint* pdwVersion);
}

const GUID IID_IAsyncRpcChannelBuffer = {0xA5029FB6, 0x3C34, 0x11D1, [0x9C, 0x99, 0x00, 0xC0, 0x4F, 0xB9, 0x98, 0xAA]};
@GUID(0xA5029FB6, 0x3C34, 0x11D1, [0x9C, 0x99, 0x00, 0xC0, 0x4F, 0xB9, 0x98, 0xAA]);
interface IAsyncRpcChannelBuffer : IRpcChannelBuffer2
{
    HRESULT Send(RPCOLEMESSAGE* pMsg, ISynchronize pSync, uint* pulStatus);
    HRESULT Receive(RPCOLEMESSAGE* pMsg, uint* pulStatus);
    HRESULT GetDestCtxEx(RPCOLEMESSAGE* pMsg, uint* pdwDestContext, void** ppvDestContext);
}

const GUID IID_IRpcChannelBuffer3 = {0x25B15600, 0x0115, 0x11D0, [0xBF, 0x0D, 0x00, 0xAA, 0x00, 0xB8, 0xDF, 0xD2]};
@GUID(0x25B15600, 0x0115, 0x11D0, [0xBF, 0x0D, 0x00, 0xAA, 0x00, 0xB8, 0xDF, 0xD2]);
interface IRpcChannelBuffer3 : IRpcChannelBuffer2
{
    HRESULT Send(RPCOLEMESSAGE* pMsg, uint* pulStatus);
    HRESULT Receive(RPCOLEMESSAGE* pMsg, uint ulSize, uint* pulStatus);
    HRESULT Cancel(RPCOLEMESSAGE* pMsg);
    HRESULT GetCallContext(RPCOLEMESSAGE* pMsg, const(Guid)* riid, void** pInterface);
    HRESULT GetDestCtxEx(RPCOLEMESSAGE* pMsg, uint* pdwDestContext, void** ppvDestContext);
    HRESULT GetState(RPCOLEMESSAGE* pMsg, uint* pState);
    HRESULT RegisterAsync(RPCOLEMESSAGE* pMsg, IAsyncManager pAsyncMgr);
}

const GUID IID_IRpcSyntaxNegotiate = {0x58A08519, 0x24C8, 0x4935, [0xB4, 0x82, 0x3F, 0xD8, 0x23, 0x33, 0x3A, 0x4F]};
@GUID(0x58A08519, 0x24C8, 0x4935, [0xB4, 0x82, 0x3F, 0xD8, 0x23, 0x33, 0x3A, 0x4F]);
interface IRpcSyntaxNegotiate : IUnknown
{
    HRESULT NegotiateSyntax(RPCOLEMESSAGE* pMsg);
}

const GUID IID_IRpcProxyBuffer = {0xD5F56A34, 0x593B, 0x101A, [0xB5, 0x69, 0x08, 0x00, 0x2B, 0x2D, 0xBF, 0x7A]};
@GUID(0xD5F56A34, 0x593B, 0x101A, [0xB5, 0x69, 0x08, 0x00, 0x2B, 0x2D, 0xBF, 0x7A]);
interface IRpcProxyBuffer : IUnknown
{
    HRESULT Connect(IRpcChannelBuffer pRpcChannelBuffer);
    void Disconnect();
}

const GUID IID_IRpcStubBuffer = {0xD5F56AFC, 0x593B, 0x101A, [0xB5, 0x69, 0x08, 0x00, 0x2B, 0x2D, 0xBF, 0x7A]};
@GUID(0xD5F56AFC, 0x593B, 0x101A, [0xB5, 0x69, 0x08, 0x00, 0x2B, 0x2D, 0xBF, 0x7A]);
interface IRpcStubBuffer : IUnknown
{
    HRESULT Connect(IUnknown pUnkServer);
    void Disconnect();
    HRESULT Invoke(RPCOLEMESSAGE* _prpcmsg, IRpcChannelBuffer _pRpcChannelBuffer);
    IRpcStubBuffer IsIIDSupported(const(Guid)* riid);
    uint CountRefs();
    HRESULT DebugServerQueryInterface(void** ppv);
    void DebugServerRelease(void* pv);
}

const GUID IID_IPSFactoryBuffer = {0xD5F569D0, 0x593B, 0x101A, [0xB5, 0x69, 0x08, 0x00, 0x2B, 0x2D, 0xBF, 0x7A]};
@GUID(0xD5F569D0, 0x593B, 0x101A, [0xB5, 0x69, 0x08, 0x00, 0x2B, 0x2D, 0xBF, 0x7A]);
interface IPSFactoryBuffer : IUnknown
{
    HRESULT CreateProxy(IUnknown pUnkOuter, const(Guid)* riid, IRpcProxyBuffer* ppProxy, void** ppv);
    HRESULT CreateStub(const(Guid)* riid, IUnknown pUnkServer, IRpcStubBuffer* ppStub);
}

struct SChannelHookCallInfo
{
    Guid iid;
    uint cbSize;
    Guid uCausality;
    uint dwServerPid;
    uint iMethod;
    void* pObject;
}

const GUID IID_IChannelHook = {0x1008C4A0, 0x7613, 0x11CF, [0x9A, 0xF1, 0x00, 0x20, 0xAF, 0x6E, 0x72, 0xF4]};
@GUID(0x1008C4A0, 0x7613, 0x11CF, [0x9A, 0xF1, 0x00, 0x20, 0xAF, 0x6E, 0x72, 0xF4]);
interface IChannelHook : IUnknown
{
    void ClientGetSize(const(Guid)* uExtent, const(Guid)* riid, uint* pDataSize);
    void ClientFillBuffer(const(Guid)* uExtent, const(Guid)* riid, uint* pDataSize, void* pDataBuffer);
    void ClientNotify(const(Guid)* uExtent, const(Guid)* riid, uint cbDataSize, void* pDataBuffer, uint lDataRep, HRESULT hrFault);
    void ServerNotify(const(Guid)* uExtent, const(Guid)* riid, uint cbDataSize, void* pDataBuffer, uint lDataRep);
    void ServerGetSize(const(Guid)* uExtent, const(Guid)* riid, HRESULT hrFault, uint* pDataSize);
    void ServerFillBuffer(const(Guid)* uExtent, const(Guid)* riid, uint* pDataSize, void* pDataBuffer, HRESULT hrFault);
}

struct SOLE_AUTHENTICATION_SERVICE
{
    uint dwAuthnSvc;
    uint dwAuthzSvc;
    ushort* pPrincipalName;
    HRESULT hr;
}

enum EOLE_AUTHENTICATION_CAPABILITIES
{
    EOAC_NONE = 0,
    EOAC_MUTUAL_AUTH = 1,
    EOAC_STATIC_CLOAKING = 32,
    EOAC_DYNAMIC_CLOAKING = 64,
    EOAC_ANY_AUTHORITY = 128,
    EOAC_MAKE_FULLSIC = 256,
    EOAC_DEFAULT = 2048,
    EOAC_SECURE_REFS = 2,
    EOAC_ACCESS_CONTROL = 4,
    EOAC_APPID = 8,
    EOAC_DYNAMIC = 16,
    EOAC_REQUIRE_FULLSIC = 512,
    EOAC_AUTO_IMPERSONATE = 1024,
    EOAC_DISABLE_AAA = 4096,
    EOAC_NO_CUSTOM_MARSHAL = 8192,
    EOAC_RESERVED1 = 16384,
}

struct SOLE_AUTHENTICATION_INFO
{
    uint dwAuthnSvc;
    uint dwAuthzSvc;
    void* pAuthInfo;
}

struct SOLE_AUTHENTICATION_LIST
{
    uint cAuthInfo;
    SOLE_AUTHENTICATION_INFO* aAuthInfo;
}

const GUID IID_IClientSecurity = {0x0000013D, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000013D, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IClientSecurity : IUnknown
{
    HRESULT QueryBlanket(IUnknown pProxy, uint* pAuthnSvc, uint* pAuthzSvc, ushort** pServerPrincName, uint* pAuthnLevel, uint* pImpLevel, void** pAuthInfo, uint* pCapabilites);
    HRESULT SetBlanket(IUnknown pProxy, uint dwAuthnSvc, uint dwAuthzSvc, ushort* pServerPrincName, uint dwAuthnLevel, uint dwImpLevel, void* pAuthInfo, uint dwCapabilities);
    HRESULT CopyProxy(IUnknown pProxy, IUnknown* ppCopy);
}

const GUID IID_IServerSecurity = {0x0000013E, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000013E, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IServerSecurity : IUnknown
{
    HRESULT QueryBlanket(uint* pAuthnSvc, uint* pAuthzSvc, ushort** pServerPrincName, uint* pAuthnLevel, uint* pImpLevel, void** pPrivs, uint* pCapabilities);
    HRESULT ImpersonateClient();
    HRESULT RevertToSelf();
    BOOL IsImpersonating();
}

enum RPCOPT_PROPERTIES
{
    COMBND_RPCTIMEOUT = 1,
    COMBND_SERVER_LOCALITY = 2,
    COMBND_RESERVED1 = 4,
    COMBND_RESERVED2 = 5,
    COMBND_RESERVED3 = 8,
    COMBND_RESERVED4 = 16,
}

enum RPCOPT_SERVER_LOCALITY_VALUES
{
    SERVER_LOCALITY_PROCESS_LOCAL = 0,
    SERVER_LOCALITY_MACHINE_LOCAL = 1,
    SERVER_LOCALITY_REMOTE = 2,
}

const GUID IID_IRpcOptions = {0x00000144, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000144, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IRpcOptions : IUnknown
{
    HRESULT Set(IUnknown pPrx, RPCOPT_PROPERTIES dwProperty, uint dwValue);
    HRESULT Query(IUnknown pPrx, RPCOPT_PROPERTIES dwProperty, uint* pdwValue);
}

enum GLOBALOPT_PROPERTIES
{
    COMGLB_EXCEPTION_HANDLING = 1,
    COMGLB_APPID = 2,
    COMGLB_RPC_THREADPOOL_SETTING = 3,
    COMGLB_RO_SETTINGS = 4,
    COMGLB_UNMARSHALING_POLICY = 5,
    COMGLB_PROPERTIES_RESERVED1 = 6,
    COMGLB_PROPERTIES_RESERVED2 = 7,
    COMGLB_PROPERTIES_RESERVED3 = 8,
}

enum GLOBALOPT_EH_VALUES
{
    COMGLB_EXCEPTION_HANDLE = 0,
    COMGLB_EXCEPTION_DONOT_HANDLE_FATAL = 1,
    COMGLB_EXCEPTION_DONOT_HANDLE = 1,
    COMGLB_EXCEPTION_DONOT_HANDLE_ANY = 2,
}

enum GLOBALOPT_RPCTP_VALUES
{
    COMGLB_RPC_THREADPOOL_SETTING_DEFAULT_POOL = 0,
    COMGLB_RPC_THREADPOOL_SETTING_PRIVATE_POOL = 1,
}

enum GLOBALOPT_RO_FLAGS
{
    COMGLB_STA_MODALLOOP_REMOVE_TOUCH_MESSAGES = 1,
    COMGLB_STA_MODALLOOP_SHARED_QUEUE_REMOVE_INPUT_MESSAGES = 2,
    COMGLB_STA_MODALLOOP_SHARED_QUEUE_DONOT_REMOVE_INPUT_MESSAGES = 4,
    COMGLB_FAST_RUNDOWN = 8,
    COMGLB_RESERVED1 = 16,
    COMGLB_RESERVED2 = 32,
    COMGLB_RESERVED3 = 64,
    COMGLB_STA_MODALLOOP_SHARED_QUEUE_REORDER_POINTER_MESSAGES = 128,
    COMGLB_RESERVED4 = 256,
    COMGLB_RESERVED5 = 512,
    COMGLB_RESERVED6 = 1024,
}

enum GLOBALOPT_UNMARSHALING_POLICY_VALUES
{
    COMGLB_UNMARSHALING_POLICY_NORMAL = 0,
    COMGLB_UNMARSHALING_POLICY_STRONG = 1,
    COMGLB_UNMARSHALING_POLICY_HYBRID = 2,
}

const GUID IID_IGlobalOptions = {0x0000015B, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000015B, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IGlobalOptions : IUnknown
{
    HRESULT Set(GLOBALOPT_PROPERTIES dwProperty, uint dwValue);
    HRESULT Query(GLOBALOPT_PROPERTIES dwProperty, uint* pdwValue);
}

const GUID IID_ISurrogate = {0x00000022, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000022, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ISurrogate : IUnknown
{
    HRESULT LoadDllServer(const(Guid)* Clsid);
    HRESULT FreeSurrogate();
}

const GUID IID_IGlobalInterfaceTable = {0x00000146, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000146, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IGlobalInterfaceTable : IUnknown
{
    HRESULT RegisterInterfaceInGlobal(IUnknown pUnk, const(Guid)* riid, uint* pdwCookie);
    HRESULT RevokeInterfaceFromGlobal(uint dwCookie);
    HRESULT GetInterfaceFromGlobal(uint dwCookie, const(Guid)* riid, void** ppv);
}

const GUID IID_ISynchronize = {0x00000030, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000030, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ISynchronize : IUnknown
{
    HRESULT Wait(uint dwFlags, uint dwMilliseconds);
    HRESULT Signal();
    HRESULT Reset();
}

const GUID IID_ISynchronizeHandle = {0x00000031, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000031, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ISynchronizeHandle : IUnknown
{
    HRESULT GetHandle(HANDLE* ph);
}

const GUID IID_ISynchronizeEvent = {0x00000032, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000032, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ISynchronizeEvent : ISynchronizeHandle
{
    HRESULT SetEventHandle(HANDLE* ph);
}

const GUID IID_ISynchronizeContainer = {0x00000033, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000033, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ISynchronizeContainer : IUnknown
{
    HRESULT AddSynchronize(ISynchronize pSync);
    HRESULT WaitMultiple(uint dwFlags, uint dwTimeOut, ISynchronize* ppSync);
}

const GUID IID_ISynchronizeMutex = {0x00000025, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000025, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ISynchronizeMutex : ISynchronize
{
    HRESULT ReleaseMutex();
}

const GUID IID_ICancelMethodCalls = {0x00000029, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000029, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ICancelMethodCalls : IUnknown
{
    HRESULT Cancel(uint ulSeconds);
    HRESULT TestCancel();
}

enum DCOM_CALL_STATE
{
    DCOM_NONE = 0,
    DCOM_CALL_COMPLETE = 1,
    DCOM_CALL_CANCELED = 2,
}

const GUID IID_IAsyncManager = {0x0000002A, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000002A, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IAsyncManager : IUnknown
{
    HRESULT CompleteCall(HRESULT Result);
    HRESULT GetCallContext(const(Guid)* riid, void** pInterface);
    HRESULT GetState(uint* pulStateFlags);
}

const GUID IID_ICallFactory = {0x1C733A30, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x1C733A30, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ICallFactory : IUnknown
{
    HRESULT CreateCall(const(Guid)* riid, IUnknown pCtrlUnk, const(Guid)* riid2, IUnknown* ppv);
}

const GUID IID_IRpcHelper = {0x00000149, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000149, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IRpcHelper : IUnknown
{
    HRESULT GetDCOMProtocolVersion(uint* pComVersion);
    HRESULT GetIIDFromOBJREF(void* pObjRef, Guid** piid);
}

const GUID IID_IReleaseMarshalBuffers = {0xEB0CB9E8, 0x7996, 0x11D2, [0x87, 0x2E, 0x00, 0x00, 0xF8, 0x08, 0x08, 0x59]};
@GUID(0xEB0CB9E8, 0x7996, 0x11D2, [0x87, 0x2E, 0x00, 0x00, 0xF8, 0x08, 0x08, 0x59]);
interface IReleaseMarshalBuffers : IUnknown
{
    HRESULT ReleaseMarshalBuffer(RPCOLEMESSAGE* pMsg, uint dwFlags, IUnknown pChnl);
}

const GUID IID_IWaitMultiple = {0x0000002B, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000002B, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IWaitMultiple : IUnknown
{
    HRESULT WaitMultiple(uint timeout, ISynchronize* pSync);
    HRESULT AddSynchronize(ISynchronize pSync);
}

const GUID IID_IAddrTrackingControl = {0x00000147, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000147, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IAddrTrackingControl : IUnknown
{
    HRESULT EnableCOMDynamicAddrTracking();
    HRESULT DisableCOMDynamicAddrTracking();
}

const GUID IID_IAddrExclusionControl = {0x00000148, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000148, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IAddrExclusionControl : IUnknown
{
    HRESULT GetCurrentAddrExclusionList(const(Guid)* riid, void** ppEnumerator);
    HRESULT UpdateAddrExclusionList(IUnknown pEnumerator);
}

const GUID IID_IPipeByte = {0xDB2F3ACA, 0x2F86, 0x11D1, [0x8E, 0x04, 0x00, 0xC0, 0x4F, 0xB9, 0x98, 0x9A]};
@GUID(0xDB2F3ACA, 0x2F86, 0x11D1, [0x8E, 0x04, 0x00, 0xC0, 0x4F, 0xB9, 0x98, 0x9A]);
interface IPipeByte : IUnknown
{
    HRESULT Pull(char* buf, uint cRequest, uint* pcReturned);
    HRESULT Push(char* buf, uint cSent);
}

const GUID IID_AsyncIPipeByte = {0xDB2F3ACB, 0x2F86, 0x11D1, [0x8E, 0x04, 0x00, 0xC0, 0x4F, 0xB9, 0x98, 0x9A]};
@GUID(0xDB2F3ACB, 0x2F86, 0x11D1, [0x8E, 0x04, 0x00, 0xC0, 0x4F, 0xB9, 0x98, 0x9A]);
interface AsyncIPipeByte : IUnknown
{
    HRESULT Begin_Pull(uint cRequest);
    HRESULT Finish_Pull(ubyte* buf, uint* pcReturned);
    HRESULT Begin_Push(char* buf, uint cSent);
    HRESULT Finish_Push();
}

const GUID IID_IPipeLong = {0xDB2F3ACC, 0x2F86, 0x11D1, [0x8E, 0x04, 0x00, 0xC0, 0x4F, 0xB9, 0x98, 0x9A]};
@GUID(0xDB2F3ACC, 0x2F86, 0x11D1, [0x8E, 0x04, 0x00, 0xC0, 0x4F, 0xB9, 0x98, 0x9A]);
interface IPipeLong : IUnknown
{
    HRESULT Pull(char* buf, uint cRequest, uint* pcReturned);
    HRESULT Push(char* buf, uint cSent);
}

const GUID IID_AsyncIPipeLong = {0xDB2F3ACD, 0x2F86, 0x11D1, [0x8E, 0x04, 0x00, 0xC0, 0x4F, 0xB9, 0x98, 0x9A]};
@GUID(0xDB2F3ACD, 0x2F86, 0x11D1, [0x8E, 0x04, 0x00, 0xC0, 0x4F, 0xB9, 0x98, 0x9A]);
interface AsyncIPipeLong : IUnknown
{
    HRESULT Begin_Pull(uint cRequest);
    HRESULT Finish_Pull(int* buf, uint* pcReturned);
    HRESULT Begin_Push(char* buf, uint cSent);
    HRESULT Finish_Push();
}

const GUID IID_IPipeDouble = {0xDB2F3ACE, 0x2F86, 0x11D1, [0x8E, 0x04, 0x00, 0xC0, 0x4F, 0xB9, 0x98, 0x9A]};
@GUID(0xDB2F3ACE, 0x2F86, 0x11D1, [0x8E, 0x04, 0x00, 0xC0, 0x4F, 0xB9, 0x98, 0x9A]);
interface IPipeDouble : IUnknown
{
    HRESULT Pull(char* buf, uint cRequest, uint* pcReturned);
    HRESULT Push(char* buf, uint cSent);
}

const GUID IID_AsyncIPipeDouble = {0xDB2F3ACF, 0x2F86, 0x11D1, [0x8E, 0x04, 0x00, 0xC0, 0x4F, 0xB9, 0x98, 0x9A]};
@GUID(0xDB2F3ACF, 0x2F86, 0x11D1, [0x8E, 0x04, 0x00, 0xC0, 0x4F, 0xB9, 0x98, 0x9A]);
interface AsyncIPipeDouble : IUnknown
{
    HRESULT Begin_Pull(uint cRequest);
    HRESULT Finish_Pull(double* buf, uint* pcReturned);
    HRESULT Begin_Push(char* buf, uint cSent);
    HRESULT Finish_Push();
}

enum APTTYPEQUALIFIER
{
    APTTYPEQUALIFIER_NONE = 0,
    APTTYPEQUALIFIER_IMPLICIT_MTA = 1,
    APTTYPEQUALIFIER_NA_ON_MTA = 2,
    APTTYPEQUALIFIER_NA_ON_STA = 3,
    APTTYPEQUALIFIER_NA_ON_IMPLICIT_MTA = 4,
    APTTYPEQUALIFIER_NA_ON_MAINSTA = 5,
    APTTYPEQUALIFIER_APPLICATION_STA = 6,
    APTTYPEQUALIFIER_RESERVED_1 = 7,
}

enum APTTYPE
{
    APTTYPE_CURRENT = -1,
    APTTYPE_STA = 0,
    APTTYPE_MTA = 1,
    APTTYPE_NA = 2,
    APTTYPE_MAINSTA = 3,
}

enum THDTYPE
{
    THDTYPE_BLOCKMESSAGES = 0,
    THDTYPE_PROCESSMESSAGES = 1,
}

const GUID IID_IComThreadingInfo = {0x000001CE, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000001CE, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IComThreadingInfo : IUnknown
{
    HRESULT GetCurrentApartmentType(APTTYPE* pAptType);
    HRESULT GetCurrentThreadType(THDTYPE* pThreadType);
    HRESULT GetCurrentLogicalThreadId(Guid* pguidLogicalThreadId);
    HRESULT SetCurrentLogicalThreadId(const(Guid)* rguid);
}

const GUID IID_IProcessInitControl = {0x72380D55, 0x8D2B, 0x43A3, [0x85, 0x13, 0x2B, 0x6E, 0xF3, 0x14, 0x34, 0xE9]};
@GUID(0x72380D55, 0x8D2B, 0x43A3, [0x85, 0x13, 0x2B, 0x6E, 0xF3, 0x14, 0x34, 0xE9]);
interface IProcessInitControl : IUnknown
{
    HRESULT ResetInitializerTimeout(uint dwSecondsRemaining);
}

const GUID IID_IFastRundown = {0x00000040, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000040, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IFastRundown : IUnknown
{
}

enum CO_MARSHALING_CONTEXT_ATTRIBUTES
{
    CO_MARSHALING_SOURCE_IS_APP_CONTAINER = 0,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_1 = -2147483648,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_2 = -2147483647,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_3 = -2147483646,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_4 = -2147483645,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_5 = -2147483644,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_6 = -2147483643,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_7 = -2147483642,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_8 = -2147483641,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_9 = -2147483640,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_10 = -2147483639,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_11 = -2147483638,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_12 = -2147483637,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_13 = -2147483636,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_14 = -2147483635,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_15 = -2147483634,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_16 = -2147483633,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_17 = -2147483632,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_18 = -2147483631,
}

const GUID IID_IMarshalingStream = {0xD8F2F5E6, 0x6102, 0x4863, [0x9F, 0x26, 0x38, 0x9A, 0x46, 0x76, 0xEF, 0xDE]};
@GUID(0xD8F2F5E6, 0x6102, 0x4863, [0x9F, 0x26, 0x38, 0x9A, 0x46, 0x76, 0xEF, 0xDE]);
interface IMarshalingStream : IStream
{
    HRESULT GetMarshalingContextAttribute(CO_MARSHALING_CONTEXT_ATTRIBUTES attribute, uint* pAttributeValue);
}

struct CO_MTA_USAGE_COOKIE__
{
    int unused;
}

enum STDMSHLFLAGS
{
    SMEXF_SERVER = 1,
    SMEXF_HANDLER = 2,
}

enum COWAIT_FLAGS
{
    COWAIT_DEFAULT = 0,
    COWAIT_WAITALL = 1,
    COWAIT_ALERTABLE = 2,
    COWAIT_INPUTAVAILABLE = 4,
    COWAIT_DISPATCH_CALLS = 8,
    COWAIT_DISPATCH_WINDOW_MESSAGES = 16,
}

enum CWMO_FLAGS
{
    CWMO_DEFAULT = 0,
    CWMO_DISPATCH_CALLS = 1,
    CWMO_DISPATCH_WINDOW_MESSAGES = 2,
}

alias LPFNGETCLASSOBJECT = extern(Windows) HRESULT function(const(Guid)* param0, const(Guid)* param1, void** param2);
alias LPFNCANUNLOADNOW = extern(Windows) HRESULT function();
struct CO_DEVICE_CATALOG_COOKIE__
{
    int unused;
}

const GUID IID_IMallocSpy = {0x0000001D, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000001D, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IMallocSpy : IUnknown
{
    uint PreAlloc(uint cbRequest);
    void* PostAlloc(void* pActual);
    void* PreFree(void* pRequest, BOOL fSpyed);
    void PostFree(BOOL fSpyed);
    uint PreRealloc(void* pRequest, uint cbRequest, void** ppNewRequest, BOOL fSpyed);
    void* PostRealloc(void* pActual, BOOL fSpyed);
    void* PreGetSize(void* pRequest, BOOL fSpyed);
    uint PostGetSize(uint cbActual, BOOL fSpyed);
    void* PreDidAlloc(void* pRequest, BOOL fSpyed);
    int PostDidAlloc(void* pRequest, BOOL fSpyed, int fActual);
    void PreHeapMinimize();
    void PostHeapMinimize();
}

struct BIND_OPTS
{
    uint cbStruct;
    uint grfFlags;
    uint grfMode;
    uint dwTickCountDeadline;
}

struct BIND_OPTS2
{
    BIND_OPTS __AnonymousBase_objidl_L8451_C36;
    uint dwTrackFlags;
    uint dwClassContext;
    uint locale;
    COSERVERINFO* pServerInfo;
}

struct BIND_OPTS3
{
    BIND_OPTS2 __AnonymousBase_objidl_L8475_C36;
    HWND hwnd;
}

enum BIND_FLAGS
{
    BIND_MAYBOTHERUSER = 1,
    BIND_JUSTTESTEXISTENCE = 2,
}

const GUID IID_IBindCtx = {0x0000000E, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000000E, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IBindCtx : IUnknown
{
    HRESULT RegisterObjectBound(IUnknown punk);
    HRESULT RevokeObjectBound(IUnknown punk);
    HRESULT ReleaseBoundObjects();
    HRESULT SetBindOptions(BIND_OPTS* pbindopts);
    HRESULT GetBindOptions(BIND_OPTS* pbindopts);
    HRESULT GetRunningObjectTable(IRunningObjectTable* pprot);
    HRESULT RegisterObjectParam(ushort* pszKey, IUnknown punk);
    HRESULT GetObjectParam(ushort* pszKey, IUnknown* ppunk);
    HRESULT EnumObjectParam(IEnumString* ppenum);
    HRESULT RevokeObjectParam(ushort* pszKey);
}

const GUID IID_IEnumMoniker = {0x00000102, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000102, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IEnumMoniker : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumMoniker* ppenum);
}

const GUID IID_IRunnableObject = {0x00000126, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000126, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IRunnableObject : IUnknown
{
    HRESULT GetRunningClass(Guid* lpClsid);
    HRESULT Run(IBindCtx pbc);
    BOOL IsRunning();
    HRESULT LockRunning(BOOL fLock, BOOL fLastUnlockCloses);
    HRESULT SetContainedObject(BOOL fContained);
}

const GUID IID_IRunningObjectTable = {0x00000010, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000010, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IRunningObjectTable : IUnknown
{
    HRESULT Register(uint grfFlags, IUnknown punkObject, IMoniker pmkObjectName, uint* pdwRegister);
    HRESULT Revoke(uint dwRegister);
    HRESULT IsRunning(IMoniker pmkObjectName);
    HRESULT GetObjectA(IMoniker pmkObjectName, IUnknown* ppunkObject);
    HRESULT NoteChangeTime(uint dwRegister, FILETIME* pfiletime);
    HRESULT GetTimeOfLastChange(IMoniker pmkObjectName, FILETIME* pfiletime);
    HRESULT EnumRunning(IEnumMoniker* ppenumMoniker);
}

const GUID IID_IPersist = {0x0000010C, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000010C, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IPersist : IUnknown
{
    HRESULT GetClassID(Guid* pClassID);
}

const GUID IID_IPersistStream = {0x00000109, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000109, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IPersistStream : IPersist
{
    HRESULT IsDirty();
    HRESULT Load(IStream pStm);
    HRESULT Save(IStream pStm, BOOL fClearDirty);
    HRESULT GetSizeMax(ULARGE_INTEGER* pcbSize);
}

enum MKSYS
{
    MKSYS_NONE = 0,
    MKSYS_GENERICCOMPOSITE = 1,
    MKSYS_FILEMONIKER = 2,
    MKSYS_ANTIMONIKER = 3,
    MKSYS_ITEMMONIKER = 4,
    MKSYS_POINTERMONIKER = 5,
    MKSYS_CLASSMONIKER = 7,
    MKSYS_OBJREFMONIKER = 8,
    MKSYS_SESSIONMONIKER = 9,
    MKSYS_LUAMONIKER = 10,
}

enum MKREDUCE
{
    MKRREDUCE_ONE = 196608,
    MKRREDUCE_TOUSER = 131072,
    MKRREDUCE_THROUGHUSER = 65536,
    MKRREDUCE_ALL = 0,
}

const GUID IID_IMoniker = {0x0000000F, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000000F, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IMoniker : IPersistStream
{
    HRESULT BindToObject(IBindCtx pbc, IMoniker pmkToLeft, const(Guid)* riidResult, void** ppvResult);
    HRESULT BindToStorage(IBindCtx pbc, IMoniker pmkToLeft, const(Guid)* riid, void** ppvObj);
    HRESULT Reduce(IBindCtx pbc, uint dwReduceHowFar, IMoniker* ppmkToLeft, IMoniker* ppmkReduced);
    HRESULT ComposeWith(IMoniker pmkRight, BOOL fOnlyIfNotGeneric, IMoniker* ppmkComposite);
    HRESULT Enum(BOOL fForward, IEnumMoniker* ppenumMoniker);
    HRESULT IsEqual(IMoniker pmkOtherMoniker);
    HRESULT Hash(uint* pdwHash);
    HRESULT IsRunning(IBindCtx pbc, IMoniker pmkToLeft, IMoniker pmkNewlyRunning);
    HRESULT GetTimeOfLastChange(IBindCtx pbc, IMoniker pmkToLeft, FILETIME* pFileTime);
    HRESULT Inverse(IMoniker* ppmk);
    HRESULT CommonPrefixWith(IMoniker pmkOther, IMoniker* ppmkPrefix);
    HRESULT RelativePathTo(IMoniker pmkOther, IMoniker* ppmkRelPath);
    HRESULT GetDisplayName(IBindCtx pbc, IMoniker pmkToLeft, ushort** ppszDisplayName);
    HRESULT ParseDisplayName(IBindCtx pbc, IMoniker pmkToLeft, ushort* pszDisplayName, uint* pchEaten, IMoniker* ppmkOut);
    HRESULT IsSystemMoniker(uint* pdwMksys);
}

const GUID IID_IROTData = {0xF29F6BC0, 0x5021, 0x11CE, [0xAA, 0x15, 0x00, 0x00, 0x69, 0x01, 0x29, 0x3F]};
@GUID(0xF29F6BC0, 0x5021, 0x11CE, [0xAA, 0x15, 0x00, 0x00, 0x69, 0x01, 0x29, 0x3F]);
interface IROTData : IUnknown
{
    HRESULT GetComparisonData(char* pbData, uint cbMax, uint* pcbData);
}

const GUID IID_IPersistFile = {0x0000010B, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000010B, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IPersistFile : IPersist
{
    HRESULT IsDirty();
    HRESULT Load(ushort* pszFileName, uint dwMode);
    HRESULT Save(ushort* pszFileName, BOOL fRemember);
    HRESULT SaveCompleted(ushort* pszFileName);
    HRESULT GetCurFile(ushort** ppszFileName);
}

const GUID IID_IPersistStorage = {0x0000010A, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000010A, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IPersistStorage : IPersist
{
    HRESULT IsDirty();
    HRESULT InitNew(IStorage pStg);
    HRESULT Load(IStorage pStg);
    HRESULT Save(IStorage pStgSave, BOOL fSameAsLoad);
    HRESULT SaveCompleted(IStorage pStgNew);
    HRESULT HandsOffStorage();
}

struct DVTARGETDEVICE
{
    uint tdSize;
    ushort tdDriverNameOffset;
    ushort tdDeviceNameOffset;
    ushort tdPortNameOffset;
    ushort tdExtDevmodeOffset;
    ubyte tdData;
}

struct FORMATETC
{
    ushort cfFormat;
    DVTARGETDEVICE* ptd;
    uint dwAspect;
    int lindex;
    uint tymed;
}

const GUID IID_IEnumFORMATETC = {0x00000103, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000103, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IEnumFORMATETC : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumFORMATETC* ppenum);
}

enum ADVF
{
    ADVF_NODATA = 1,
    ADVF_PRIMEFIRST = 2,
    ADVF_ONLYONCE = 4,
    ADVF_DATAONSTOP = 64,
    ADVFCACHE_NOHANDLER = 8,
    ADVFCACHE_FORCEBUILTIN = 16,
    ADVFCACHE_ONSAVE = 32,
}

struct STATDATA
{
    FORMATETC formatetc;
    uint advf;
    IAdviseSink pAdvSink;
    uint dwConnection;
}

const GUID IID_IEnumSTATDATA = {0x00000105, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000105, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IEnumSTATDATA : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumSTATDATA* ppenum);
}

enum TYMED
{
    TYMED_HGLOBAL = 1,
    TYMED_FILE = 2,
    TYMED_ISTREAM = 4,
    TYMED_ISTORAGE = 8,
    TYMED_GDI = 16,
    TYMED_MFPICT = 32,
    TYMED_ENHMF = 64,
    TYMED_NULL = 0,
}

struct RemSTGMEDIUM
{
    uint tymed;
    uint dwHandleType;
    uint pData;
    uint pUnkForRelease;
    uint cbData;
    ubyte data;
}

struct STGMEDIUM
{
    uint tymed;
    _Anonymous_e__Union Anonymous;
    IUnknown pUnkForRelease;
}

struct GDI_OBJECT
{
    uint ObjectType;
    _u_e__Struct u;
}

struct userSTGMEDIUM
{
    IUnknown pUnkForRelease;
}

struct userFLAG_STGMEDIUM
{
    int ContextFlags;
    int fPassOwnership;
    userSTGMEDIUM Stgmed;
}

struct FLAG_STGMEDIUM
{
    int ContextFlags;
    int fPassOwnership;
    STGMEDIUM Stgmed;
}

const GUID IID_IAdviseSink = {0x0000010F, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000010F, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IAdviseSink : IUnknown
{
    void OnDataChange(FORMATETC* pFormatetc, STGMEDIUM* pStgmed);
    void OnViewChange(uint dwAspect, int lindex);
    void OnRename(IMoniker pmk);
    void OnSave();
    void OnClose();
}

const GUID IID_AsyncIAdviseSink = {0x00000150, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000150, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface AsyncIAdviseSink : IUnknown
{
    void Begin_OnDataChange(FORMATETC* pFormatetc, STGMEDIUM* pStgmed);
    void Finish_OnDataChange();
    void Begin_OnViewChange(uint dwAspect, int lindex);
    void Finish_OnViewChange();
    void Begin_OnRename(IMoniker pmk);
    void Finish_OnRename();
    void Begin_OnSave();
    void Finish_OnSave();
    void Begin_OnClose();
    void Finish_OnClose();
}

const GUID IID_IAdviseSink2 = {0x00000125, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000125, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IAdviseSink2 : IAdviseSink
{
    void OnLinkSrcChange(IMoniker pmk);
}

const GUID IID_AsyncIAdviseSink2 = {0x00000151, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000151, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface AsyncIAdviseSink2 : AsyncIAdviseSink
{
    void Begin_OnLinkSrcChange(IMoniker pmk);
    void Finish_OnLinkSrcChange();
}

enum DATADIR
{
    DATADIR_GET = 1,
    DATADIR_SET = 2,
}

const GUID IID_IDataObject = {0x0000010E, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000010E, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IDataObject : IUnknown
{
    HRESULT GetData(FORMATETC* pformatetcIn, STGMEDIUM* pmedium);
    HRESULT GetDataHere(FORMATETC* pformatetc, STGMEDIUM* pmedium);
    HRESULT QueryGetData(FORMATETC* pformatetc);
    HRESULT GetCanonicalFormatEtc(FORMATETC* pformatectIn, FORMATETC* pformatetcOut);
    HRESULT SetData(FORMATETC* pformatetc, STGMEDIUM* pmedium, BOOL fRelease);
    HRESULT EnumFormatEtc(uint dwDirection, IEnumFORMATETC* ppenumFormatEtc);
    HRESULT DAdvise(FORMATETC* pformatetc, uint advf, IAdviseSink pAdvSink, uint* pdwConnection);
    HRESULT DUnadvise(uint dwConnection);
    HRESULT EnumDAdvise(IEnumSTATDATA* ppenumAdvise);
}

const GUID IID_IDataAdviseHolder = {0x00000110, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000110, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IDataAdviseHolder : IUnknown
{
    HRESULT Advise(IDataObject pDataObject, FORMATETC* pFetc, uint advf, IAdviseSink pAdvise, uint* pdwConnection);
    HRESULT Unadvise(uint dwConnection);
    HRESULT EnumAdvise(IEnumSTATDATA* ppenumAdvise);
    HRESULT SendOnDataChange(IDataObject pDataObject, uint dwReserved, uint advf);
}

enum CALLTYPE
{
    CALLTYPE_TOPLEVEL = 1,
    CALLTYPE_NESTED = 2,
    CALLTYPE_ASYNC = 3,
    CALLTYPE_TOPLEVEL_CALLPENDING = 4,
    CALLTYPE_ASYNC_CALLPENDING = 5,
}

enum SERVERCALL
{
    SERVERCALL_ISHANDLED = 0,
    SERVERCALL_REJECTED = 1,
    SERVERCALL_RETRYLATER = 2,
}

enum PENDINGTYPE
{
    PENDINGTYPE_TOPLEVEL = 1,
    PENDINGTYPE_NESTED = 2,
}

enum PENDINGMSG
{
    PENDINGMSG_CANCELCALL = 0,
    PENDINGMSG_WAITNOPROCESS = 1,
    PENDINGMSG_WAITDEFPROCESS = 2,
}

struct INTERFACEINFO
{
    IUnknown pUnk;
    Guid iid;
    ushort wMethod;
}

const GUID IID_IMessageFilter = {0x00000016, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000016, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IMessageFilter : IUnknown
{
    uint HandleInComingCall(uint dwCallType, int htaskCaller, uint dwTickCount, INTERFACEINFO* lpInterfaceInfo);
    uint RetryRejectedCall(int htaskCallee, uint dwTickCount, uint dwRejectType);
    uint MessagePending(int htaskCallee, uint dwTickCount, uint dwPendingType);
}

const GUID IID_IClassActivator = {0x00000140, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000140, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IClassActivator : IUnknown
{
    HRESULT GetClassObject(const(Guid)* rclsid, uint dwClassContext, uint locale, const(Guid)* riid, void** ppv);
}

const GUID IID_IProgressNotify = {0xA9D758A0, 0x4617, 0x11CF, [0x95, 0xFC, 0x00, 0xAA, 0x00, 0x68, 0x0D, 0xB4]};
@GUID(0xA9D758A0, 0x4617, 0x11CF, [0x95, 0xFC, 0x00, 0xAA, 0x00, 0x68, 0x0D, 0xB4]);
interface IProgressNotify : IUnknown
{
    HRESULT OnProgress(uint dwProgressCurrent, uint dwProgressMaximum, BOOL fAccurate, BOOL fOwner);
}

const GUID IID_IBlockingLock = {0x30F3D47A, 0x6447, 0x11D1, [0x8E, 0x3C, 0x00, 0xC0, 0x4F, 0xB9, 0x38, 0x6D]};
@GUID(0x30F3D47A, 0x6447, 0x11D1, [0x8E, 0x3C, 0x00, 0xC0, 0x4F, 0xB9, 0x38, 0x6D]);
interface IBlockingLock : IUnknown
{
    HRESULT Lock(uint dwTimeout);
    HRESULT Unlock();
}

const GUID IID_ITimeAndNoticeControl = {0xBC0BF6AE, 0x8878, 0x11D1, [0x83, 0xE9, 0x00, 0xC0, 0x4F, 0xC2, 0xC6, 0xD4]};
@GUID(0xBC0BF6AE, 0x8878, 0x11D1, [0x83, 0xE9, 0x00, 0xC0, 0x4F, 0xC2, 0xC6, 0xD4]);
interface ITimeAndNoticeControl : IUnknown
{
    HRESULT SuppressChanges(uint res1, uint res2);
}

const GUID IID_IOplockStorage = {0x8D19C834, 0x8879, 0x11D1, [0x83, 0xE9, 0x00, 0xC0, 0x4F, 0xC2, 0xC6, 0xD4]};
@GUID(0x8D19C834, 0x8879, 0x11D1, [0x83, 0xE9, 0x00, 0xC0, 0x4F, 0xC2, 0xC6, 0xD4]);
interface IOplockStorage : IUnknown
{
    HRESULT CreateStorageEx(const(wchar)* pwcsName, uint grfMode, uint stgfmt, uint grfAttrs, const(Guid)* riid, void** ppstgOpen);
    HRESULT OpenStorageEx(const(wchar)* pwcsName, uint grfMode, uint stgfmt, uint grfAttrs, const(Guid)* riid, void** ppstgOpen);
}

const GUID IID_IUrlMon = {0x00000026, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000026, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IUrlMon : IUnknown
{
    HRESULT AsyncGetClassBits(const(Guid)* rclsid, const(wchar)* pszTYPE, const(wchar)* pszExt, uint dwFileVersionMS, uint dwFileVersionLS, const(wchar)* pszCodeBase, IBindCtx pbc, uint dwClassContext, const(Guid)* riid, uint flags);
}

const GUID IID_IForegroundTransfer = {0x00000145, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000145, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IForegroundTransfer : IUnknown
{
    HRESULT AllowForegroundTransfer(void* lpvReserved);
}

const GUID IID_IThumbnailExtractor = {0x969DC708, 0x5C76, 0x11D1, [0x8D, 0x86, 0x00, 0x00, 0xF8, 0x04, 0xB0, 0x57]};
@GUID(0x969DC708, 0x5C76, 0x11D1, [0x8D, 0x86, 0x00, 0x00, 0xF8, 0x04, 0xB0, 0x57]);
interface IThumbnailExtractor : IUnknown
{
    HRESULT ExtractThumbnail(IStorage pStg, uint ulLength, uint ulHeight, uint* pulOutputLength, uint* pulOutputHeight, HBITMAP* phOutputBitmap);
    HRESULT OnFileUpdated(IStorage pStg);
}

const GUID IID_IDummyHICONIncluder = {0x947990DE, 0xCC28, 0x11D2, [0xA0, 0xF7, 0x00, 0x80, 0x5F, 0x85, 0x8F, 0xB1]};
@GUID(0x947990DE, 0xCC28, 0x11D2, [0xA0, 0xF7, 0x00, 0x80, 0x5F, 0x85, 0x8F, 0xB1]);
interface IDummyHICONIncluder : IUnknown
{
    HRESULT Dummy(HICON h1, HDC h2);
}

enum ApplicationType
{
    ServerApplication = 0,
    LibraryApplication = 1,
}

enum ShutdownType
{
    IdleShutdown = 0,
    ForcedShutdown = 1,
}

const GUID IID_IProcessLock = {0x000001D5, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000001D5, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IProcessLock : IUnknown
{
    uint AddRefOnProcess();
    uint ReleaseRefOnProcess();
}

const GUID IID_ISurrogateService = {0x000001D4, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000001D4, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ISurrogateService : IUnknown
{
    HRESULT Init(const(Guid)* rguidProcessID, IProcessLock pProcessLock, int* pfApplicationAware);
    HRESULT ApplicationLaunch(const(Guid)* rguidApplID, ApplicationType appType);
    HRESULT ApplicationFree(const(Guid)* rguidApplID);
    HRESULT CatalogRefresh(uint ulReserved);
    HRESULT ProcessShutdown(ShutdownType shutdownType);
}

const GUID IID_IInitializeSpy = {0x00000034, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000034, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IInitializeSpy : IUnknown
{
    HRESULT PreInitialize(uint dwCoInit, uint dwCurThreadAptRefs);
    HRESULT PostInitialize(HRESULT hrCoInit, uint dwCoInit, uint dwNewThreadAptRefs);
    HRESULT PreUninitialize(uint dwCurThreadAptRefs);
    HRESULT PostUninitialize(uint dwNewThreadAptRefs);
}

const GUID IID_IOleAdviseHolder = {0x00000111, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000111, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IOleAdviseHolder : IUnknown
{
    HRESULT Advise(IAdviseSink pAdvise, uint* pdwConnection);
    HRESULT Unadvise(uint dwConnection);
    HRESULT EnumAdvise(IEnumSTATDATA* ppenumAdvise);
    HRESULT SendOnRename(IMoniker pmk);
    HRESULT SendOnSave();
    HRESULT SendOnClose();
}

const GUID IID_IOleCache = {0x0000011E, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000011E, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IOleCache : IUnknown
{
    HRESULT Cache(FORMATETC* pformatetc, uint advf, uint* pdwConnection);
    HRESULT Uncache(uint dwConnection);
    HRESULT EnumCache(IEnumSTATDATA* ppenumSTATDATA);
    HRESULT InitCache(IDataObject pDataObject);
    HRESULT SetData(FORMATETC* pformatetc, STGMEDIUM* pmedium, BOOL fRelease);
}

enum DISCARDCACHE
{
    DISCARDCACHE_SAVEIFDIRTY = 0,
    DISCARDCACHE_NOSAVE = 1,
}

const GUID IID_IOleCache2 = {0x00000128, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000128, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IOleCache2 : IOleCache
{
    HRESULT UpdateCache(IDataObject pDataObject, uint grfUpdf, void* pReserved);
    HRESULT DiscardCache(uint dwDiscardOptions);
}

const GUID IID_IOleCacheControl = {0x00000129, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000129, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IOleCacheControl : IUnknown
{
    HRESULT OnRun(IDataObject pDataObject);
    HRESULT OnStop();
}

const GUID IID_IParseDisplayName = {0x0000011A, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000011A, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IParseDisplayName : IUnknown
{
    HRESULT ParseDisplayName(IBindCtx pbc, ushort* pszDisplayName, uint* pchEaten, IMoniker* ppmkOut);
}

const GUID IID_IOleContainer = {0x0000011B, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000011B, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IOleContainer : IParseDisplayName
{
    HRESULT EnumObjects(uint grfFlags, IEnumUnknown* ppenum);
    HRESULT LockContainer(BOOL fLock);
}

const GUID IID_IOleClientSite = {0x00000118, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000118, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IOleClientSite : IUnknown
{
    HRESULT SaveObject();
    HRESULT GetMoniker(uint dwAssign, uint dwWhichMoniker, IMoniker* ppmk);
    HRESULT GetContainer(IOleContainer* ppContainer);
    HRESULT ShowObject();
    HRESULT OnShowWindow(BOOL fShow);
    HRESULT RequestNewObjectLayout();
}

enum OLEGETMONIKER
{
    OLEGETMONIKER_ONLYIFTHERE = 1,
    OLEGETMONIKER_FORCEASSIGN = 2,
    OLEGETMONIKER_UNASSIGN = 3,
    OLEGETMONIKER_TEMPFORUSER = 4,
}

enum OLEWHICHMK
{
    OLEWHICHMK_CONTAINER = 1,
    OLEWHICHMK_OBJREL = 2,
    OLEWHICHMK_OBJFULL = 3,
}

enum USERCLASSTYPE
{
    USERCLASSTYPE_FULL = 1,
    USERCLASSTYPE_SHORT = 2,
    USERCLASSTYPE_APPNAME = 3,
}

enum OLEMISC
{
    OLEMISC_RECOMPOSEONRESIZE = 1,
    OLEMISC_ONLYICONIC = 2,
    OLEMISC_INSERTNOTREPLACE = 4,
    OLEMISC_STATIC = 8,
    OLEMISC_CANTLINKINSIDE = 16,
    OLEMISC_CANLINKBYOLE1 = 32,
    OLEMISC_ISLINKOBJECT = 64,
    OLEMISC_INSIDEOUT = 128,
    OLEMISC_ACTIVATEWHENVISIBLE = 256,
    OLEMISC_RENDERINGISDEVICEINDEPENDENT = 512,
    OLEMISC_INVISIBLEATRUNTIME = 1024,
    OLEMISC_ALWAYSRUN = 2048,
    OLEMISC_ACTSLIKEBUTTON = 4096,
    OLEMISC_ACTSLIKELABEL = 8192,
    OLEMISC_NOUIACTIVATE = 16384,
    OLEMISC_ALIGNABLE = 32768,
    OLEMISC_SIMPLEFRAME = 65536,
    OLEMISC_SETCLIENTSITEFIRST = 131072,
    OLEMISC_IMEMODE = 262144,
    OLEMISC_IGNOREACTIVATEWHENVISIBLE = 524288,
    OLEMISC_WANTSTOMENUMERGE = 1048576,
    OLEMISC_SUPPORTSMULTILEVELUNDO = 2097152,
}

enum OLECLOSE
{
    OLECLOSE_SAVEIFDIRTY = 0,
    OLECLOSE_NOSAVE = 1,
    OLECLOSE_PROMPTSAVE = 2,
}

const GUID IID_IOleObject = {0x00000112, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000112, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IOleObject : IUnknown
{
    HRESULT SetClientSite(IOleClientSite pClientSite);
    HRESULT GetClientSite(IOleClientSite* ppClientSite);
    HRESULT SetHostNames(ushort* szContainerApp, ushort* szContainerObj);
    HRESULT Close(uint dwSaveOption);
    HRESULT SetMoniker(uint dwWhichMoniker, IMoniker pmk);
    HRESULT GetMoniker(uint dwAssign, uint dwWhichMoniker, IMoniker* ppmk);
    HRESULT InitFromData(IDataObject pDataObject, BOOL fCreation, uint dwReserved);
    HRESULT GetClipboardData(uint dwReserved, IDataObject* ppDataObject);
    HRESULT DoVerb(int iVerb, MSG* lpmsg, IOleClientSite pActiveSite, int lindex, HWND hwndParent, RECT* lprcPosRect);
    HRESULT EnumVerbs(IEnumOLEVERB* ppEnumOleVerb);
    HRESULT Update();
    HRESULT IsUpToDate();
    HRESULT GetUserClassID(Guid* pClsid);
    HRESULT GetUserType(uint dwFormOfType, ushort** pszUserType);
    HRESULT SetExtent(uint dwDrawAspect, SIZE* psizel);
    HRESULT GetExtent(uint dwDrawAspect, SIZE* psizel);
    HRESULT Advise(IAdviseSink pAdvSink, uint* pdwConnection);
    HRESULT Unadvise(uint dwConnection);
    HRESULT EnumAdvise(IEnumSTATDATA* ppenumAdvise);
    HRESULT GetMiscStatus(uint dwAspect, uint* pdwStatus);
    HRESULT SetColorScheme(LOGPALETTE* pLogpal);
}

enum OLERENDER
{
    OLERENDER_NONE = 0,
    OLERENDER_DRAW = 1,
    OLERENDER_FORMAT = 2,
    OLERENDER_ASIS = 3,
}

struct OBJECTDESCRIPTOR
{
    uint cbSize;
    Guid clsid;
    uint dwDrawAspect;
    SIZE sizel;
    POINTL pointl;
    uint dwStatus;
    uint dwFullUserTypeName;
    uint dwSrcOfCopy;
}

const GUID IID_IOleWindow = {0x00000114, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000114, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IOleWindow : IUnknown
{
    HRESULT GetWindow(HWND* phwnd);
    HRESULT ContextSensitiveHelp(BOOL fEnterMode);
}

enum OLEUPDATE
{
    OLEUPDATE_ALWAYS = 1,
    OLEUPDATE_ONCALL = 3,
}

enum OLELINKBIND
{
    OLELINKBIND_EVENIFCLASSDIFF = 1,
}

const GUID IID_IOleLink = {0x0000011D, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000011D, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IOleLink : IUnknown
{
    HRESULT SetUpdateOptions(uint dwUpdateOpt);
    HRESULT GetUpdateOptions(uint* pdwUpdateOpt);
    HRESULT SetSourceMoniker(IMoniker pmk, const(Guid)* rclsid);
    HRESULT GetSourceMoniker(IMoniker* ppmk);
    HRESULT SetSourceDisplayName(ushort* pszStatusText);
    HRESULT GetSourceDisplayName(ushort** ppszDisplayName);
    HRESULT BindToSource(uint bindflags, IBindCtx pbc);
    HRESULT BindIfRunning();
    HRESULT GetBoundSource(IUnknown* ppunk);
    HRESULT UnbindSource();
    HRESULT Update(IBindCtx pbc);
}

enum BINDSPEED
{
    BINDSPEED_INDEFINITE = 1,
    BINDSPEED_MODERATE = 2,
    BINDSPEED_IMMEDIATE = 3,
}

enum OLECONTF
{
    OLECONTF_EMBEDDINGS = 1,
    OLECONTF_LINKS = 2,
    OLECONTF_OTHERS = 4,
    OLECONTF_ONLYUSER = 8,
    OLECONTF_ONLYIFRUNNING = 16,
}

const GUID IID_IOleItemContainer = {0x0000011C, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000011C, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IOleItemContainer : IOleContainer
{
    HRESULT GetObjectA(ushort* pszItem, uint dwSpeedNeeded, IBindCtx pbc, const(Guid)* riid, void** ppvObject);
    HRESULT GetObjectStorage(ushort* pszItem, IBindCtx pbc, const(Guid)* riid, void** ppvStorage);
    HRESULT IsRunning(ushort* pszItem);
}

const GUID IID_IOleInPlaceUIWindow = {0x00000115, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000115, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IOleInPlaceUIWindow : IOleWindow
{
    HRESULT GetBorder(RECT* lprectBorder);
    HRESULT RequestBorderSpace(RECT* pborderwidths);
    HRESULT SetBorderSpace(RECT* pborderwidths);
    HRESULT SetActiveObject(IOleInPlaceActiveObject pActiveObject, ushort* pszObjName);
}

const GUID IID_IOleInPlaceActiveObject = {0x00000117, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000117, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IOleInPlaceActiveObject : IOleWindow
{
    HRESULT TranslateAcceleratorA(MSG* lpmsg);
    HRESULT OnFrameWindowActivate(BOOL fActivate);
    HRESULT OnDocWindowActivate(BOOL fActivate);
    HRESULT ResizeBorder(RECT* prcBorder, IOleInPlaceUIWindow pUIWindow, BOOL fFrameWindow);
    HRESULT EnableModeless(BOOL fEnable);
}

struct OIFI
{
    uint cb;
    BOOL fMDIApp;
    HWND hwndFrame;
    HACCEL haccel;
    uint cAccelEntries;
}

struct OleMenuGroupWidths
{
    int width;
}

const GUID IID_IOleInPlaceFrame = {0x00000116, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000116, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IOleInPlaceFrame : IOleInPlaceUIWindow
{
    HRESULT InsertMenus(HMENU hmenuShared, OleMenuGroupWidths* lpMenuWidths);
    HRESULT SetMenu(HMENU hmenuShared, int holemenu, HWND hwndActiveObject);
    HRESULT RemoveMenus(HMENU hmenuShared);
    HRESULT SetStatusText(ushort* pszStatusText);
    HRESULT EnableModeless(BOOL fEnable);
    HRESULT TranslateAcceleratorA(MSG* lpmsg, ushort wID);
}

const GUID IID_IOleInPlaceObject = {0x00000113, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000113, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IOleInPlaceObject : IOleWindow
{
    HRESULT InPlaceDeactivate();
    HRESULT UIDeactivate();
    HRESULT SetObjectRects(RECT* lprcPosRect, RECT* lprcClipRect);
    HRESULT ReactivateAndUndo();
}

const GUID IID_IOleInPlaceSite = {0x00000119, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000119, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IOleInPlaceSite : IOleWindow
{
    HRESULT CanInPlaceActivate();
    HRESULT OnInPlaceActivate();
    HRESULT OnUIActivate();
    HRESULT GetWindowContext(IOleInPlaceFrame* ppFrame, IOleInPlaceUIWindow* ppDoc, RECT* lprcPosRect, RECT* lprcClipRect, OIFI* lpFrameInfo);
    HRESULT Scroll(SIZE scrollExtant);
    HRESULT OnUIDeactivate(BOOL fUndoable);
    HRESULT OnInPlaceDeactivate();
    HRESULT DiscardUndoState();
    HRESULT DeactivateAndUndo();
    HRESULT OnPosRectChange(RECT* lprcPosRect);
}

const GUID IID_IContinue = {0x0000012A, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000012A, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IContinue : IUnknown
{
    HRESULT FContinue();
}

const GUID IID_IViewObject = {0x0000010D, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000010D, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IViewObject : IUnknown
{
    HRESULT Draw(uint dwDrawAspect, int lindex, void* pvAspect, DVTARGETDEVICE* ptd, HDC hdcTargetDev, HDC hdcDraw, RECTL* lprcBounds, RECTL* lprcWBounds, BOOL************** pfnContinue, uint dwContinue);
    HRESULT GetColorSet(uint dwDrawAspect, int lindex, void* pvAspect, DVTARGETDEVICE* ptd, HDC hicTargetDev, LOGPALETTE** ppColorSet);
    HRESULT Freeze(uint dwDrawAspect, int lindex, void* pvAspect, uint* pdwFreeze);
    HRESULT Unfreeze(uint dwFreeze);
    HRESULT SetAdvise(uint aspects, uint advf, IAdviseSink pAdvSink);
    HRESULT GetAdvise(uint* pAspects, uint* pAdvf, IAdviseSink* ppAdvSink);
}

const GUID IID_IViewObject2 = {0x00000127, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000127, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IViewObject2 : IViewObject
{
    HRESULT GetExtent(uint dwDrawAspect, int lindex, DVTARGETDEVICE* ptd, SIZE* lpsizel);
}

const GUID IID_IDropSource = {0x00000121, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000121, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IDropSource : IUnknown
{
    HRESULT QueryContinueDrag(BOOL fEscapePressed, uint grfKeyState);
    HRESULT GiveFeedback(uint dwEffect);
}

const GUID IID_IDropTarget = {0x00000122, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000122, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IDropTarget : IUnknown
{
    HRESULT DragEnter(IDataObject pDataObj, uint grfKeyState, POINTL pt, uint* pdwEffect);
    HRESULT DragOver(uint grfKeyState, POINTL pt, uint* pdwEffect);
    HRESULT DragLeave();
    HRESULT Drop(IDataObject pDataObj, uint grfKeyState, POINTL pt, uint* pdwEffect);
}

const GUID IID_IDropSourceNotify = {0x0000012B, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0000012B, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IDropSourceNotify : IUnknown
{
    HRESULT DragEnterTarget(HWND hwndTarget);
    HRESULT DragLeaveTarget();
}

const GUID IID_IEnterpriseDropTarget = {0x390E3878, 0xFD55, 0x4E18, [0x81, 0x9D, 0x46, 0x82, 0x08, 0x1C, 0x0C, 0xFD]};
@GUID(0x390E3878, 0xFD55, 0x4E18, [0x81, 0x9D, 0x46, 0x82, 0x08, 0x1C, 0x0C, 0xFD]);
interface IEnterpriseDropTarget : IUnknown
{
    HRESULT SetDropSourceEnterpriseId(const(wchar)* identity);
    HRESULT IsEvaluatingEdpPolicy(int* value);
}

struct OLEVERB
{
    int lVerb;
    ushort* lpszVerbName;
    uint fuFlags;
    uint grfAttribs;
}

enum OLEVERBATTRIB
{
    OLEVERBATTRIB_NEVERDIRTIES = 1,
    OLEVERBATTRIB_ONCONTAINERMENU = 2,
}

const GUID IID_IEnumOLEVERB = {0x00000104, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00000104, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IEnumOLEVERB : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumOLEVERB* ppenum);
}

enum IEObjectType
{
    IE_EPM_OBJECT_EVENT = 0,
    IE_EPM_OBJECT_MUTEX = 1,
    IE_EPM_OBJECT_SEMAPHORE = 2,
    IE_EPM_OBJECT_SHARED_MEMORY = 3,
    IE_EPM_OBJECT_WAITABLE_TIMER = 4,
    IE_EPM_OBJECT_FILE = 5,
    IE_EPM_OBJECT_NAMED_PIPE = 6,
    IE_EPM_OBJECT_REGISTRY = 7,
}

const GUID IID_IPersistMoniker = {0x79EAC9C9, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9C9, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IPersistMoniker : IUnknown
{
    HRESULT GetClassID(Guid* pClassID);
    HRESULT IsDirty();
    HRESULT Load(BOOL fFullyAvailable, IMoniker pimkName, IBindCtx pibc, uint grfMode);
    HRESULT Save(IMoniker pimkName, IBindCtx pbc, BOOL fRemember);
    HRESULT SaveCompleted(IMoniker pimkName, IBindCtx pibc);
    HRESULT GetCurMoniker(IMoniker* ppimkName);
}

enum MONIKERPROPERTY
{
    MIMETYPEPROP = 0,
    USE_SRC_URL = 1,
    CLASSIDPROP = 2,
    TRUSTEDDOWNLOADPROP = 3,
    POPUPLEVELPROP = 4,
}

const GUID IID_IMonikerProp = {0xA5CA5F7F, 0x1847, 0x4D87, [0x9C, 0x5B, 0x91, 0x85, 0x09, 0xF7, 0x51, 0x1D]};
@GUID(0xA5CA5F7F, 0x1847, 0x4D87, [0x9C, 0x5B, 0x91, 0x85, 0x09, 0xF7, 0x51, 0x1D]);
interface IMonikerProp : IUnknown
{
    HRESULT PutProperty(MONIKERPROPERTY mkp, const(wchar)* val);
}

const GUID IID_IBindProtocol = {0x79EAC9CD, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9CD, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IBindProtocol : IUnknown
{
    HRESULT CreateBinding(const(wchar)* szUrl, IBindCtx pbc, IBinding* ppb);
}

const GUID IID_IBinding = {0x79EAC9C0, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9C0, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IBinding : IUnknown
{
    HRESULT Abort();
    HRESULT Suspend();
    HRESULT Resume();
    HRESULT SetPriority(int nPriority);
    HRESULT GetPriority(int* pnPriority);
    HRESULT GetBindResult(Guid* pclsidProtocol, uint* pdwResult, ushort** pszResult, uint* pdwReserved);
}

enum BINDVERB
{
    BINDVERB_GET = 0,
    BINDVERB_POST = 1,
    BINDVERB_PUT = 2,
    BINDVERB_CUSTOM = 3,
    BINDVERB_RESERVED1 = 4,
}

enum BINDINFOF
{
    BINDINFOF_URLENCODESTGMEDDATA = 1,
    BINDINFOF_URLENCODEDEXTRAINFO = 2,
}

enum BINDF
{
    BINDF_ASYNCHRONOUS = 1,
    BINDF_ASYNCSTORAGE = 2,
    BINDF_NOPROGRESSIVERENDERING = 4,
    BINDF_OFFLINEOPERATION = 8,
    BINDF_GETNEWESTVERSION = 16,
    BINDF_NOWRITECACHE = 32,
    BINDF_NEEDFILE = 64,
    BINDF_PULLDATA = 128,
    BINDF_IGNORESECURITYPROBLEM = 256,
    BINDF_RESYNCHRONIZE = 512,
    BINDF_HYPERLINK = 1024,
    BINDF_NO_UI = 2048,
    BINDF_SILENTOPERATION = 4096,
    BINDF_PRAGMA_NO_CACHE = 8192,
    BINDF_GETCLASSOBJECT = 16384,
    BINDF_RESERVED_1 = 32768,
    BINDF_FREE_THREADED = 65536,
    BINDF_DIRECT_READ = 131072,
    BINDF_FORMS_SUBMIT = 262144,
    BINDF_GETFROMCACHE_IF_NET_FAIL = 524288,
    BINDF_FROMURLMON = 1048576,
    BINDF_FWD_BACK = 2097152,
    BINDF_PREFERDEFAULTHANDLER = 4194304,
    BINDF_ENFORCERESTRICTED = 8388608,
    BINDF_RESERVED_2 = -2147483648,
    BINDF_RESERVED_3 = 16777216,
    BINDF_RESERVED_4 = 33554432,
    BINDF_RESERVED_5 = 67108864,
    BINDF_RESERVED_6 = 134217728,
    BINDF_RESERVED_7 = 1073741824,
    BINDF_RESERVED_8 = 536870912,
}

enum URL_ENCODING
{
    URL_ENCODING_NONE = 0,
    URL_ENCODING_ENABLE_UTF8 = 268435456,
    URL_ENCODING_DISABLE_UTF8 = 536870912,
}

struct BINDINFO
{
    uint cbSize;
    const(wchar)* szExtraInfo;
    STGMEDIUM stgmedData;
    uint grfBindInfoF;
    uint dwBindVerb;
    const(wchar)* szCustomVerb;
    uint cbstgmedData;
    uint dwOptions;
    uint dwOptionsFlags;
    uint dwCodePage;
    SECURITY_ATTRIBUTES securityAttributes;
    Guid iid;
    IUnknown pUnk;
    uint dwReserved;
}

struct REMSECURITY_ATTRIBUTES
{
    uint nLength;
    uint lpSecurityDescriptor;
    BOOL bInheritHandle;
}

struct RemBINDINFO
{
    uint cbSize;
    const(wchar)* szExtraInfo;
    uint grfBindInfoF;
    uint dwBindVerb;
    const(wchar)* szCustomVerb;
    uint cbstgmedData;
    uint dwOptions;
    uint dwOptionsFlags;
    uint dwCodePage;
    REMSECURITY_ATTRIBUTES securityAttributes;
    Guid iid;
    IUnknown pUnk;
    uint dwReserved;
}

struct RemFORMATETC
{
    uint cfFormat;
    uint ptd;
    uint dwAspect;
    int lindex;
    uint tymed;
}

enum BINDINFO_OPTIONS
{
    BINDINFO_OPTIONS_WININETFLAG = 65536,
    BINDINFO_OPTIONS_ENABLE_UTF8 = 131072,
    BINDINFO_OPTIONS_DISABLE_UTF8 = 262144,
    BINDINFO_OPTIONS_USE_IE_ENCODING = 524288,
    BINDINFO_OPTIONS_BINDTOOBJECT = 1048576,
    BINDINFO_OPTIONS_SECURITYOPTOUT = 2097152,
    BINDINFO_OPTIONS_IGNOREMIMETEXTPLAIN = 4194304,
    BINDINFO_OPTIONS_USEBINDSTRINGCREDS = 8388608,
    BINDINFO_OPTIONS_IGNOREHTTPHTTPSREDIRECTS = 16777216,
    BINDINFO_OPTIONS_IGNORE_SSLERRORS_ONCE = 33554432,
    BINDINFO_WPC_DOWNLOADBLOCKED = 134217728,
    BINDINFO_WPC_LOGGING_ENABLED = 268435456,
    BINDINFO_OPTIONS_ALLOWCONNECTDATA = 536870912,
    BINDINFO_OPTIONS_DISABLEAUTOREDIRECTS = 1073741824,
    BINDINFO_OPTIONS_SHDOCVW_NAVIGATE = -2147483648,
}

enum BSCF
{
    BSCF_FIRSTDATANOTIFICATION = 1,
    BSCF_INTERMEDIATEDATANOTIFICATION = 2,
    BSCF_LASTDATANOTIFICATION = 4,
    BSCF_DATAFULLYAVAILABLE = 8,
    BSCF_AVAILABLEDATASIZEUNKNOWN = 16,
    BSCF_SKIPDRAINDATAFORFILEURLS = 32,
    BSCF_64BITLENGTHDOWNLOAD = 64,
}

enum BINDSTATUS
{
    BINDSTATUS_FINDINGRESOURCE = 1,
    BINDSTATUS_CONNECTING = 2,
    BINDSTATUS_REDIRECTING = 3,
    BINDSTATUS_BEGINDOWNLOADDATA = 4,
    BINDSTATUS_DOWNLOADINGDATA = 5,
    BINDSTATUS_ENDDOWNLOADDATA = 6,
    BINDSTATUS_BEGINDOWNLOADCOMPONENTS = 7,
    BINDSTATUS_INSTALLINGCOMPONENTS = 8,
    BINDSTATUS_ENDDOWNLOADCOMPONENTS = 9,
    BINDSTATUS_USINGCACHEDCOPY = 10,
    BINDSTATUS_SENDINGREQUEST = 11,
    BINDSTATUS_CLASSIDAVAILABLE = 12,
    BINDSTATUS_MIMETYPEAVAILABLE = 13,
    BINDSTATUS_CACHEFILENAMEAVAILABLE = 14,
    BINDSTATUS_BEGINSYNCOPERATION = 15,
    BINDSTATUS_ENDSYNCOPERATION = 16,
    BINDSTATUS_BEGINUPLOADDATA = 17,
    BINDSTATUS_UPLOADINGDATA = 18,
    BINDSTATUS_ENDUPLOADDATA = 19,
    BINDSTATUS_PROTOCOLCLASSID = 20,
    BINDSTATUS_ENCODING = 21,
    BINDSTATUS_VERIFIEDMIMETYPEAVAILABLE = 22,
    BINDSTATUS_CLASSINSTALLLOCATION = 23,
    BINDSTATUS_DECODING = 24,
    BINDSTATUS_LOADINGMIMEHANDLER = 25,
    BINDSTATUS_CONTENTDISPOSITIONATTACH = 26,
    BINDSTATUS_FILTERREPORTMIMETYPE = 27,
    BINDSTATUS_CLSIDCANINSTANTIATE = 28,
    BINDSTATUS_IUNKNOWNAVAILABLE = 29,
    BINDSTATUS_DIRECTBIND = 30,
    BINDSTATUS_RAWMIMETYPE = 31,
    BINDSTATUS_PROXYDETECTING = 32,
    BINDSTATUS_ACCEPTRANGES = 33,
    BINDSTATUS_COOKIE_SENT = 34,
    BINDSTATUS_COMPACT_POLICY_RECEIVED = 35,
    BINDSTATUS_COOKIE_SUPPRESSED = 36,
    BINDSTATUS_COOKIE_STATE_UNKNOWN = 37,
    BINDSTATUS_COOKIE_STATE_ACCEPT = 38,
    BINDSTATUS_COOKIE_STATE_REJECT = 39,
    BINDSTATUS_COOKIE_STATE_PROMPT = 40,
    BINDSTATUS_COOKIE_STATE_LEASH = 41,
    BINDSTATUS_COOKIE_STATE_DOWNGRADE = 42,
    BINDSTATUS_POLICY_HREF = 43,
    BINDSTATUS_P3P_HEADER = 44,
    BINDSTATUS_SESSION_COOKIE_RECEIVED = 45,
    BINDSTATUS_PERSISTENT_COOKIE_RECEIVED = 46,
    BINDSTATUS_SESSION_COOKIES_ALLOWED = 47,
    BINDSTATUS_CACHECONTROL = 48,
    BINDSTATUS_CONTENTDISPOSITIONFILENAME = 49,
    BINDSTATUS_MIMETEXTPLAINMISMATCH = 50,
    BINDSTATUS_PUBLISHERAVAILABLE = 51,
    BINDSTATUS_DISPLAYNAMEAVAILABLE = 52,
    BINDSTATUS_SSLUX_NAVBLOCKED = 53,
    BINDSTATUS_SERVER_MIMETYPEAVAILABLE = 54,
    BINDSTATUS_SNIFFED_CLASSIDAVAILABLE = 55,
    BINDSTATUS_64BIT_PROGRESS = 56,
    BINDSTATUS_LAST = 56,
    BINDSTATUS_RESERVED_0 = 57,
    BINDSTATUS_RESERVED_1 = 58,
    BINDSTATUS_RESERVED_2 = 59,
    BINDSTATUS_RESERVED_3 = 60,
    BINDSTATUS_RESERVED_4 = 61,
    BINDSTATUS_RESERVED_5 = 62,
    BINDSTATUS_RESERVED_6 = 63,
    BINDSTATUS_RESERVED_7 = 64,
    BINDSTATUS_RESERVED_8 = 65,
    BINDSTATUS_RESERVED_9 = 66,
    BINDSTATUS_RESERVED_A = 67,
    BINDSTATUS_RESERVED_B = 68,
    BINDSTATUS_RESERVED_C = 69,
    BINDSTATUS_RESERVED_D = 70,
    BINDSTATUS_RESERVED_E = 71,
    BINDSTATUS_RESERVED_F = 72,
    BINDSTATUS_RESERVED_10 = 73,
    BINDSTATUS_RESERVED_11 = 74,
    BINDSTATUS_RESERVED_12 = 75,
    BINDSTATUS_RESERVED_13 = 76,
    BINDSTATUS_LAST_PRIVATE = 76,
}

const GUID IID_IBindStatusCallback = {0x79EAC9C1, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9C1, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IBindStatusCallback : IUnknown
{
    HRESULT OnStartBinding(uint dwReserved, IBinding pib);
    HRESULT GetPriority(int* pnPriority);
    HRESULT OnLowResource(uint reserved);
    HRESULT OnProgress(uint ulProgress, uint ulProgressMax, uint ulStatusCode, const(wchar)* szStatusText);
    HRESULT OnStopBinding(HRESULT hresult, const(wchar)* szError);
    HRESULT GetBindInfo(uint* grfBINDF, BINDINFO* pbindinfo);
    HRESULT OnDataAvailable(uint grfBSCF, uint dwSize, FORMATETC* pformatetc, STGMEDIUM* pstgmed);
    HRESULT OnObjectAvailable(const(Guid)* riid, IUnknown punk);
}

enum BINDF2
{
    BINDF2_DISABLEBASICOVERHTTP = 1,
    BINDF2_DISABLEAUTOCOOKIEHANDLING = 2,
    BINDF2_READ_DATA_GREATER_THAN_4GB = 4,
    BINDF2_DISABLE_HTTP_REDIRECT_XSECURITYID = 8,
    BINDF2_SETDOWNLOADMODE = 32,
    BINDF2_DISABLE_HTTP_REDIRECT_CACHING = 64,
    BINDF2_KEEP_CALLBACK_MODULE_LOADED = 128,
    BINDF2_ALLOW_PROXY_CRED_PROMPT = 256,
    BINDF2_RESERVED_17 = 512,
    BINDF2_RESERVED_16 = 1024,
    BINDF2_RESERVED_15 = 2048,
    BINDF2_RESERVED_14 = 4096,
    BINDF2_RESERVED_13 = 8192,
    BINDF2_RESERVED_12 = 16384,
    BINDF2_RESERVED_11 = 32768,
    BINDF2_RESERVED_10 = 65536,
    BINDF2_RESERVED_F = 131072,
    BINDF2_RESERVED_E = 262144,
    BINDF2_RESERVED_D = 524288,
    BINDF2_RESERVED_C = 1048576,
    BINDF2_RESERVED_B = 2097152,
    BINDF2_RESERVED_A = 4194304,
    BINDF2_RESERVED_9 = 8388608,
    BINDF2_RESERVED_8 = 16777216,
    BINDF2_RESERVED_7 = 33554432,
    BINDF2_RESERVED_6 = 67108864,
    BINDF2_RESERVED_5 = 134217728,
    BINDF2_RESERVED_4 = 268435456,
    BINDF2_RESERVED_3 = 536870912,
    BINDF2_RESERVED_2 = 1073741824,
    BINDF2_RESERVED_1 = -2147483648,
}

const GUID IID_IBindStatusCallbackEx = {0xAAA74EF9, 0x8EE7, 0x4659, [0x88, 0xD9, 0xF8, 0xC5, 0x04, 0xDA, 0x73, 0xCC]};
@GUID(0xAAA74EF9, 0x8EE7, 0x4659, [0x88, 0xD9, 0xF8, 0xC5, 0x04, 0xDA, 0x73, 0xCC]);
interface IBindStatusCallbackEx : IBindStatusCallback
{
    HRESULT GetBindInfoEx(uint* grfBINDF, BINDINFO* pbindinfo, uint* grfBINDF2, uint* pdwReserved);
}

const GUID IID_IAuthenticate = {0x79EAC9D0, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9D0, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IAuthenticate : IUnknown
{
    HRESULT Authenticate(HWND* phwnd, ushort** pszUsername, ushort** pszPassword);
}

enum AUTHENTICATEF
{
    AUTHENTICATEF_PROXY = 1,
    AUTHENTICATEF_BASIC = 2,
    AUTHENTICATEF_HTTP = 4,
}

struct AUTHENTICATEINFO
{
    uint dwFlags;
    uint dwReserved;
}

const GUID IID_IAuthenticateEx = {0x2AD1EDAF, 0xD83D, 0x48B5, [0x9A, 0xDF, 0x03, 0xDB, 0xE1, 0x9F, 0x53, 0xBD]};
@GUID(0x2AD1EDAF, 0xD83D, 0x48B5, [0x9A, 0xDF, 0x03, 0xDB, 0xE1, 0x9F, 0x53, 0xBD]);
interface IAuthenticateEx : IAuthenticate
{
    HRESULT AuthenticateEx(HWND* phwnd, ushort** pszUsername, ushort** pszPassword, AUTHENTICATEINFO* pauthinfo);
}

const GUID IID_IHttpNegotiate = {0x79EAC9D2, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9D2, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IHttpNegotiate : IUnknown
{
    HRESULT BeginningTransaction(const(wchar)* szURL, const(wchar)* szHeaders, uint dwReserved, ushort** pszAdditionalHeaders);
    HRESULT OnResponse(uint dwResponseCode, const(wchar)* szResponseHeaders, const(wchar)* szRequestHeaders, ushort** pszAdditionalRequestHeaders);
}

const GUID IID_IHttpNegotiate2 = {0x4F9F9FCB, 0xE0F4, 0x48EB, [0xB7, 0xAB, 0xFA, 0x2E, 0xA9, 0x36, 0x5C, 0xB4]};
@GUID(0x4F9F9FCB, 0xE0F4, 0x48EB, [0xB7, 0xAB, 0xFA, 0x2E, 0xA9, 0x36, 0x5C, 0xB4]);
interface IHttpNegotiate2 : IHttpNegotiate
{
    HRESULT GetRootSecurityId(char* pbSecurityId, uint* pcbSecurityId, uint dwReserved);
}

const GUID IID_IHttpNegotiate3 = {0x57B6C80A, 0x34C2, 0x4602, [0xBC, 0x26, 0x66, 0xA0, 0x2F, 0xC5, 0x71, 0x53]};
@GUID(0x57B6C80A, 0x34C2, 0x4602, [0xBC, 0x26, 0x66, 0xA0, 0x2F, 0xC5, 0x71, 0x53]);
interface IHttpNegotiate3 : IHttpNegotiate2
{
    HRESULT GetSerializedClientCertContext(char* ppbCert, uint* pcbCert);
}

const GUID IID_IWinInetFileStream = {0xF134C4B7, 0xB1F8, 0x4E75, [0xB8, 0x86, 0x74, 0xB9, 0x09, 0x43, 0xBE, 0xCB]};
@GUID(0xF134C4B7, 0xB1F8, 0x4E75, [0xB8, 0x86, 0x74, 0xB9, 0x09, 0x43, 0xBE, 0xCB]);
interface IWinInetFileStream : IUnknown
{
    HRESULT SetHandleForUnlock(uint hWinInetLockHandle, uint dwReserved);
    HRESULT SetDeleteFile(uint dwReserved);
}

const GUID IID_IWindowForBindingUI = {0x79EAC9D5, 0xBAFA, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9D5, 0xBAFA, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IWindowForBindingUI : IUnknown
{
    HRESULT GetWindow(const(Guid)* rguidReason, HWND* phwnd);
}

enum CIP_STATUS
{
    CIP_DISK_FULL = 0,
    CIP_ACCESS_DENIED = 1,
    CIP_NEWER_VERSION_EXISTS = 2,
    CIP_OLDER_VERSION_EXISTS = 3,
    CIP_NAME_CONFLICT = 4,
    CIP_TRUST_VERIFICATION_COMPONENT_MISSING = 5,
    CIP_EXE_SELF_REGISTERATION_TIMEOUT = 6,
    CIP_UNSAFE_TO_ABORT = 7,
    CIP_NEED_REBOOT = 8,
    CIP_NEED_REBOOT_UI_PERMISSION = 9,
}

const GUID IID_ICodeInstall = {0x79EAC9D1, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9D1, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface ICodeInstall : IWindowForBindingUI
{
    HRESULT OnCodeInstallProblem(uint ulStatusCode, const(wchar)* szDestination, const(wchar)* szSource, uint dwReserved);
}

enum Uri_PROPERTY
{
    Uri_PROPERTY_ABSOLUTE_URI = 0,
    Uri_PROPERTY_STRING_START = 0,
    Uri_PROPERTY_AUTHORITY = 1,
    Uri_PROPERTY_DISPLAY_URI = 2,
    Uri_PROPERTY_DOMAIN = 3,
    Uri_PROPERTY_EXTENSION = 4,
    Uri_PROPERTY_FRAGMENT = 5,
    Uri_PROPERTY_HOST = 6,
    Uri_PROPERTY_PASSWORD = 7,
    Uri_PROPERTY_PATH = 8,
    Uri_PROPERTY_PATH_AND_QUERY = 9,
    Uri_PROPERTY_QUERY = 10,
    Uri_PROPERTY_RAW_URI = 11,
    Uri_PROPERTY_SCHEME_NAME = 12,
    Uri_PROPERTY_USER_INFO = 13,
    Uri_PROPERTY_USER_NAME = 14,
    Uri_PROPERTY_STRING_LAST = 14,
    Uri_PROPERTY_HOST_TYPE = 15,
    Uri_PROPERTY_DWORD_START = 15,
    Uri_PROPERTY_PORT = 16,
    Uri_PROPERTY_SCHEME = 17,
    Uri_PROPERTY_ZONE = 18,
    Uri_PROPERTY_DWORD_LAST = 18,
}

enum Uri_HOST_TYPE
{
    Uri_HOST_UNKNOWN = 0,
    Uri_HOST_DNS = 1,
    Uri_HOST_IPV4 = 2,
    Uri_HOST_IPV6 = 3,
    Uri_HOST_IDN = 4,
}

const GUID IID_IUri = {0xA39EE748, 0x6A27, 0x4817, [0xA6, 0xF2, 0x13, 0x91, 0x4B, 0xEF, 0x58, 0x90]};
@GUID(0xA39EE748, 0x6A27, 0x4817, [0xA6, 0xF2, 0x13, 0x91, 0x4B, 0xEF, 0x58, 0x90]);
interface IUri : IUnknown
{
    HRESULT GetPropertyBSTR(Uri_PROPERTY uriProp, BSTR* pbstrProperty, uint dwFlags);
    HRESULT GetPropertyLength(Uri_PROPERTY uriProp, uint* pcchProperty, uint dwFlags);
    HRESULT GetPropertyDWORD(Uri_PROPERTY uriProp, uint* pdwProperty, uint dwFlags);
    HRESULT HasProperty(Uri_PROPERTY uriProp, int* pfHasProperty);
    HRESULT GetAbsoluteUri(BSTR* pbstrAbsoluteUri);
    HRESULT GetAuthority(BSTR* pbstrAuthority);
    HRESULT GetDisplayUri(BSTR* pbstrDisplayString);
    HRESULT GetDomain(BSTR* pbstrDomain);
    HRESULT GetExtension(BSTR* pbstrExtension);
    HRESULT GetFragment(BSTR* pbstrFragment);
    HRESULT GetHost(BSTR* pbstrHost);
    HRESULT GetPassword(BSTR* pbstrPassword);
    HRESULT GetPath(BSTR* pbstrPath);
    HRESULT GetPathAndQuery(BSTR* pbstrPathAndQuery);
    HRESULT GetQuery(BSTR* pbstrQuery);
    HRESULT GetRawUri(BSTR* pbstrRawUri);
    HRESULT GetSchemeName(BSTR* pbstrSchemeName);
    HRESULT GetUserInfo(BSTR* pbstrUserInfo);
    HRESULT GetUserNameA(BSTR* pbstrUserName);
    HRESULT GetHostType(uint* pdwHostType);
    HRESULT GetPort(uint* pdwPort);
    HRESULT GetScheme(uint* pdwScheme);
    HRESULT GetZone(uint* pdwZone);
    HRESULT GetProperties(uint* pdwFlags);
    HRESULT IsEqual(IUri pUri, int* pfEqual);
}

const GUID IID_IUriContainer = {0xA158A630, 0xED6F, 0x45FB, [0xB9, 0x87, 0xF6, 0x86, 0x76, 0xF5, 0x77, 0x52]};
@GUID(0xA158A630, 0xED6F, 0x45FB, [0xB9, 0x87, 0xF6, 0x86, 0x76, 0xF5, 0x77, 0x52]);
interface IUriContainer : IUnknown
{
    HRESULT GetIUri(IUri* ppIUri);
}

const GUID IID_IUriBuilder = {0x4221B2E1, 0x8955, 0x46C0, [0xBD, 0x5B, 0xDE, 0x98, 0x97, 0x56, 0x5D, 0xE7]};
@GUID(0x4221B2E1, 0x8955, 0x46C0, [0xBD, 0x5B, 0xDE, 0x98, 0x97, 0x56, 0x5D, 0xE7]);
interface IUriBuilder : IUnknown
{
    HRESULT CreateUriSimple(uint dwAllowEncodingPropertyMask, uint dwReserved, IUri* ppIUri);
    HRESULT CreateUri(uint dwCreateFlags, uint dwAllowEncodingPropertyMask, uint dwReserved, IUri* ppIUri);
    HRESULT CreateUriWithFlags(uint dwCreateFlags, uint dwUriBuilderFlags, uint dwAllowEncodingPropertyMask, uint dwReserved, IUri* ppIUri);
    HRESULT GetIUri(IUri* ppIUri);
    HRESULT SetIUri(IUri pIUri);
    HRESULT GetFragment(uint* pcchFragment, ushort** ppwzFragment);
    HRESULT GetHost(uint* pcchHost, ushort** ppwzHost);
    HRESULT GetPassword(uint* pcchPassword, ushort** ppwzPassword);
    HRESULT GetPath(uint* pcchPath, ushort** ppwzPath);
    HRESULT GetPort(int* pfHasPort, uint* pdwPort);
    HRESULT GetQuery(uint* pcchQuery, ushort** ppwzQuery);
    HRESULT GetSchemeName(uint* pcchSchemeName, ushort** ppwzSchemeName);
    HRESULT GetUserNameA(uint* pcchUserName, ushort** ppwzUserName);
    HRESULT SetFragment(const(wchar)* pwzNewValue);
    HRESULT SetHost(const(wchar)* pwzNewValue);
    HRESULT SetPassword(const(wchar)* pwzNewValue);
    HRESULT SetPath(const(wchar)* pwzNewValue);
    HRESULT SetPortA(BOOL fHasPort, uint dwNewValue);
    HRESULT SetQuery(const(wchar)* pwzNewValue);
    HRESULT SetSchemeName(const(wchar)* pwzNewValue);
    HRESULT SetUserName(const(wchar)* pwzNewValue);
    HRESULT RemoveProperties(uint dwPropertyMask);
    HRESULT HasBeenModified(int* pfModified);
}

const GUID IID_IUriBuilderFactory = {0xE982CE48, 0x0B96, 0x440C, [0xBC, 0x37, 0x0C, 0x86, 0x9B, 0x27, 0xA2, 0x9E]};
@GUID(0xE982CE48, 0x0B96, 0x440C, [0xBC, 0x37, 0x0C, 0x86, 0x9B, 0x27, 0xA2, 0x9E]);
interface IUriBuilderFactory : IUnknown
{
    HRESULT CreateIUriBuilder(uint dwFlags, uint dwReserved, IUriBuilder* ppIUriBuilder);
    HRESULT CreateInitializedIUriBuilder(uint dwFlags, uint dwReserved, IUriBuilder* ppIUriBuilder);
}

const GUID IID_IWinInetInfo = {0x79EAC9D6, 0xBAFA, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9D6, 0xBAFA, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IWinInetInfo : IUnknown
{
    HRESULT QueryOption(uint dwOption, void* pBuffer, uint* pcbBuf);
}

const GUID IID_IHttpSecurity = {0x79EAC9D7, 0xBAFA, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9D7, 0xBAFA, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IHttpSecurity : IWindowForBindingUI
{
    HRESULT OnSecurityProblem(uint dwProblem);
}

const GUID IID_IWinInetHttpInfo = {0x79EAC9D8, 0xBAFA, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9D8, 0xBAFA, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IWinInetHttpInfo : IWinInetInfo
{
    HRESULT QueryInfo(uint dwOption, void* pBuffer, uint* pcbBuf, uint* pdwFlags, uint* pdwReserved);
}

const GUID IID_IWinInetHttpTimeouts = {0xF286FA56, 0xC1FD, 0x4270, [0x8E, 0x67, 0xB3, 0xEB, 0x79, 0x0A, 0x81, 0xE8]};
@GUID(0xF286FA56, 0xC1FD, 0x4270, [0x8E, 0x67, 0xB3, 0xEB, 0x79, 0x0A, 0x81, 0xE8]);
interface IWinInetHttpTimeouts : IUnknown
{
    HRESULT GetRequestTimeouts(uint* pdwConnectTimeout, uint* pdwSendTimeout, uint* pdwReceiveTimeout);
}

const GUID IID_IWinInetCacheHints = {0xDD1EC3B3, 0x8391, 0x4FDB, [0xA9, 0xE6, 0x34, 0x7C, 0x3C, 0xAA, 0xA7, 0xDD]};
@GUID(0xDD1EC3B3, 0x8391, 0x4FDB, [0xA9, 0xE6, 0x34, 0x7C, 0x3C, 0xAA, 0xA7, 0xDD]);
interface IWinInetCacheHints : IUnknown
{
    HRESULT SetCacheExtension(const(wchar)* pwzExt, void* pszCacheFile, uint* pcbCacheFile, uint* pdwWinInetError, uint* pdwReserved);
}

const GUID IID_IWinInetCacheHints2 = {0x7857AEAC, 0xD31F, 0x49BF, [0x88, 0x4E, 0xDD, 0x46, 0xDF, 0x36, 0x78, 0x0A]};
@GUID(0x7857AEAC, 0xD31F, 0x49BF, [0x88, 0x4E, 0xDD, 0x46, 0xDF, 0x36, 0x78, 0x0A]);
interface IWinInetCacheHints2 : IWinInetCacheHints
{
    HRESULT SetCacheExtension2(const(wchar)* pwzExt, char* pwzCacheFile, uint* pcchCacheFile, uint* pdwWinInetError, uint* pdwReserved);
}

const GUID IID_IBindHost = {0xFC4801A1, 0x2BA9, 0x11CF, [0xA2, 0x29, 0x00, 0xAA, 0x00, 0x3D, 0x73, 0x52]};
@GUID(0xFC4801A1, 0x2BA9, 0x11CF, [0xA2, 0x29, 0x00, 0xAA, 0x00, 0x3D, 0x73, 0x52]);
interface IBindHost : IUnknown
{
    HRESULT CreateMoniker(ushort* szName, IBindCtx pBC, IMoniker* ppmk, uint dwReserved);
    HRESULT MonikerBindToStorage(IMoniker pMk, IBindCtx pBC, IBindStatusCallback pBSC, const(Guid)* riid, void** ppvObj);
    HRESULT MonikerBindToObject(IMoniker pMk, IBindCtx pBC, IBindStatusCallback pBSC, const(Guid)* riid, void** ppvObj);
}

const GUID IID_IInternet = {0x79EAC9E0, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9E0, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IInternet : IUnknown
{
}

enum BINDSTRING
{
    BINDSTRING_HEADERS = 1,
    BINDSTRING_ACCEPT_MIMES = 2,
    BINDSTRING_EXTRA_URL = 3,
    BINDSTRING_LANGUAGE = 4,
    BINDSTRING_USERNAME = 5,
    BINDSTRING_PASSWORD = 6,
    BINDSTRING_UA_PIXELS = 7,
    BINDSTRING_UA_COLOR = 8,
    BINDSTRING_OS = 9,
    BINDSTRING_USER_AGENT = 10,
    BINDSTRING_ACCEPT_ENCODINGS = 11,
    BINDSTRING_POST_COOKIE = 12,
    BINDSTRING_POST_DATA_MIME = 13,
    BINDSTRING_URL = 14,
    BINDSTRING_IID = 15,
    BINDSTRING_FLAG_BIND_TO_OBJECT = 16,
    BINDSTRING_PTR_BIND_CONTEXT = 17,
    BINDSTRING_XDR_ORIGIN = 18,
    BINDSTRING_DOWNLOADPATH = 19,
    BINDSTRING_ROOTDOC_URL = 20,
    BINDSTRING_INITIAL_FILENAME = 21,
    BINDSTRING_PROXY_USERNAME = 22,
    BINDSTRING_PROXY_PASSWORD = 23,
    BINDSTRING_ENTERPRISE_ID = 24,
    BINDSTRING_DOC_URL = 25,
    BINDSTRING_SAMESITE_COOKIE_LEVEL = 26,
}

const GUID IID_IInternetBindInfo = {0x79EAC9E1, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9E1, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IInternetBindInfo : IUnknown
{
    HRESULT GetBindInfo(uint* grfBINDF, BINDINFO* pbindinfo);
    HRESULT GetBindString(uint ulStringType, ushort** ppwzStr, uint cEl, uint* pcElFetched);
}

const GUID IID_IInternetBindInfoEx = {0xA3E015B7, 0xA82C, 0x4DCD, [0xA1, 0x50, 0x56, 0x9A, 0xEE, 0xED, 0x36, 0xAB]};
@GUID(0xA3E015B7, 0xA82C, 0x4DCD, [0xA1, 0x50, 0x56, 0x9A, 0xEE, 0xED, 0x36, 0xAB]);
interface IInternetBindInfoEx : IInternetBindInfo
{
    HRESULT GetBindInfoEx(uint* grfBINDF, BINDINFO* pbindinfo, uint* grfBINDF2, uint* pdwReserved);
}

enum PI_FLAGS
{
    PI_PARSE_URL = 1,
    PI_FILTER_MODE = 2,
    PI_FORCE_ASYNC = 4,
    PI_USE_WORKERTHREAD = 8,
    PI_MIMEVERIFICATION = 16,
    PI_CLSIDLOOKUP = 32,
    PI_DATAPROGRESS = 64,
    PI_SYNCHRONOUS = 128,
    PI_APARTMENTTHREADED = 256,
    PI_CLASSINSTALL = 512,
    PI_PASSONBINDCTX = 8192,
    PI_NOMIMEHANDLER = 32768,
    PI_LOADAPPDIRECT = 16384,
    PD_FORCE_SWITCH = 65536,
    PI_PREFERDEFAULTHANDLER = 131072,
}

struct PROTOCOLDATA
{
    uint grfFlags;
    uint dwState;
    void* pData;
    uint cbData;
}

struct StartParam
{
    Guid iid;
    IBindCtx pIBindCtx;
    IUnknown pItf;
}

const GUID IID_IInternetProtocolRoot = {0x79EAC9E3, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9E3, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IInternetProtocolRoot : IUnknown
{
    HRESULT Start(const(wchar)* szUrl, IInternetProtocolSink pOIProtSink, IInternetBindInfo pOIBindInfo, uint grfPI, uint dwReserved);
    HRESULT Continue(PROTOCOLDATA* pProtocolData);
    HRESULT Abort(HRESULT hrReason, uint dwOptions);
    HRESULT Terminate(uint dwOptions);
    HRESULT Suspend();
    HRESULT Resume();
}

const GUID IID_IInternetProtocol = {0x79EAC9E4, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9E4, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IInternetProtocol : IInternetProtocolRoot
{
    HRESULT Read(void* pv, uint cb, uint* pcbRead);
    HRESULT Seek(LARGE_INTEGER dlibMove, uint dwOrigin, ULARGE_INTEGER* plibNewPosition);
    HRESULT LockRequest(uint dwOptions);
    HRESULT UnlockRequest();
}

const GUID IID_IInternetProtocolEx = {0xC7A98E66, 0x1010, 0x492C, [0xA1, 0xC8, 0xC8, 0x09, 0xE1, 0xF7, 0x59, 0x05]};
@GUID(0xC7A98E66, 0x1010, 0x492C, [0xA1, 0xC8, 0xC8, 0x09, 0xE1, 0xF7, 0x59, 0x05]);
interface IInternetProtocolEx : IInternetProtocol
{
    HRESULT StartEx(IUri pUri, IInternetProtocolSink pOIProtSink, IInternetBindInfo pOIBindInfo, uint grfPI, uint dwReserved);
}

const GUID IID_IInternetProtocolSink = {0x79EAC9E5, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9E5, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IInternetProtocolSink : IUnknown
{
    HRESULT Switch(PROTOCOLDATA* pProtocolData);
    HRESULT ReportProgress(uint ulStatusCode, const(wchar)* szStatusText);
    HRESULT ReportData(uint grfBSCF, uint ulProgress, uint ulProgressMax);
    HRESULT ReportResult(HRESULT hrResult, uint dwError, const(wchar)* szResult);
}

const GUID IID_IInternetProtocolSinkStackable = {0x79EAC9F0, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9F0, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IInternetProtocolSinkStackable : IUnknown
{
    HRESULT SwitchSink(IInternetProtocolSink pOIProtSink);
    HRESULT CommitSwitch();
    HRESULT RollbackSwitch();
}

enum OIBDG_FLAGS
{
    OIBDG_APARTMENTTHREADED = 256,
    OIBDG_DATAONLY = 4096,
}

const GUID IID_IInternetSession = {0x79EAC9E7, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9E7, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IInternetSession : IUnknown
{
    HRESULT RegisterNameSpace(IClassFactory pCF, const(Guid)* rclsid, const(wchar)* pwzProtocol, uint cPatterns, const(ushort)** ppwzPatterns, uint dwReserved);
    HRESULT UnregisterNameSpace(IClassFactory pCF, const(wchar)* pszProtocol);
    HRESULT RegisterMimeFilter(IClassFactory pCF, const(Guid)* rclsid, const(wchar)* pwzType);
    HRESULT UnregisterMimeFilter(IClassFactory pCF, const(wchar)* pwzType);
    HRESULT CreateBinding(IBindCtx pBC, const(wchar)* szUrl, IUnknown pUnkOuter, IUnknown* ppUnk, IInternetProtocol* ppOInetProt, uint dwOption);
    HRESULT SetSessionOption(uint dwOption, void* pBuffer, uint dwBufferLength, uint dwReserved);
    HRESULT GetSessionOption(uint dwOption, void* pBuffer, uint* pdwBufferLength, uint dwReserved);
}

const GUID IID_IInternetThreadSwitch = {0x79EAC9E8, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9E8, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IInternetThreadSwitch : IUnknown
{
    HRESULT Prepare();
    HRESULT Continue();
}

const GUID IID_IInternetPriority = {0x79EAC9EB, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9EB, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IInternetPriority : IUnknown
{
    HRESULT SetPriority(int nPriority);
    HRESULT GetPriority(int* pnPriority);
}

enum PARSEACTION
{
    PARSE_CANONICALIZE = 1,
    PARSE_FRIENDLY = 2,
    PARSE_SECURITY_URL = 3,
    PARSE_ROOTDOCUMENT = 4,
    PARSE_DOCUMENT = 5,
    PARSE_ANCHOR = 6,
    PARSE_ENCODE_IS_UNESCAPE = 7,
    PARSE_DECODE_IS_ESCAPE = 8,
    PARSE_PATH_FROM_URL = 9,
    PARSE_URL_FROM_PATH = 10,
    PARSE_MIME = 11,
    PARSE_SERVER = 12,
    PARSE_SCHEMA = 13,
    PARSE_SITE = 14,
    PARSE_DOMAIN = 15,
    PARSE_LOCATION = 16,
    PARSE_SECURITY_DOMAIN = 17,
    PARSE_ESCAPE = 18,
    PARSE_UNESCAPE = 19,
}

enum PSUACTION
{
    PSU_DEFAULT = 1,
    PSU_SECURITY_URL_ONLY = 2,
}

enum QUERYOPTION
{
    QUERY_EXPIRATION_DATE = 1,
    QUERY_TIME_OF_LAST_CHANGE = 2,
    QUERY_CONTENT_ENCODING = 3,
    QUERY_CONTENT_TYPE = 4,
    QUERY_REFRESH = 5,
    QUERY_RECOMBINE = 6,
    QUERY_CAN_NAVIGATE = 7,
    QUERY_USES_NETWORK = 8,
    QUERY_IS_CACHED = 9,
    QUERY_IS_INSTALLEDENTRY = 10,
    QUERY_IS_CACHED_OR_MAPPED = 11,
    QUERY_USES_CACHE = 12,
    QUERY_IS_SECURE = 13,
    QUERY_IS_SAFE = 14,
    QUERY_USES_HISTORYFOLDER = 15,
    QUERY_IS_CACHED_AND_USABLE_OFFLINE = 16,
}

const GUID IID_IInternetProtocolInfo = {0x79EAC9EC, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9EC, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IInternetProtocolInfo : IUnknown
{
    HRESULT ParseUrl(const(wchar)* pwzUrl, PARSEACTION ParseAction, uint dwParseFlags, const(wchar)* pwzResult, uint cchResult, uint* pcchResult, uint dwReserved);
    HRESULT CombineUrl(const(wchar)* pwzBaseUrl, const(wchar)* pwzRelativeUrl, uint dwCombineFlags, const(wchar)* pwzResult, uint cchResult, uint* pcchResult, uint dwReserved);
    HRESULT CompareUrl(const(wchar)* pwzUrl1, const(wchar)* pwzUrl2, uint dwCompareFlags);
    HRESULT QueryInfo(const(wchar)* pwzUrl, QUERYOPTION OueryOption, uint dwQueryFlags, void* pBuffer, uint cbBuffer, uint* pcbBuf, uint dwReserved);
}

enum INTERNETFEATURELIST
{
    FEATURE_OBJECT_CACHING = 0,
    FEATURE_ZONE_ELEVATION = 1,
    FEATURE_MIME_HANDLING = 2,
    FEATURE_MIME_SNIFFING = 3,
    FEATURE_WINDOW_RESTRICTIONS = 4,
    FEATURE_WEBOC_POPUPMANAGEMENT = 5,
    FEATURE_BEHAVIORS = 6,
    FEATURE_DISABLE_MK_PROTOCOL = 7,
    FEATURE_LOCALMACHINE_LOCKDOWN = 8,
    FEATURE_SECURITYBAND = 9,
    FEATURE_RESTRICT_ACTIVEXINSTALL = 10,
    FEATURE_VALIDATE_NAVIGATE_URL = 11,
    FEATURE_RESTRICT_FILEDOWNLOAD = 12,
    FEATURE_ADDON_MANAGEMENT = 13,
    FEATURE_PROTOCOL_LOCKDOWN = 14,
    FEATURE_HTTP_USERNAME_PASSWORD_DISABLE = 15,
    FEATURE_SAFE_BINDTOOBJECT = 16,
    FEATURE_UNC_SAVEDFILECHECK = 17,
    FEATURE_GET_URL_DOM_FILEPATH_UNENCODED = 18,
    FEATURE_TABBED_BROWSING = 19,
    FEATURE_SSLUX = 20,
    FEATURE_DISABLE_NAVIGATION_SOUNDS = 21,
    FEATURE_DISABLE_LEGACY_COMPRESSION = 22,
    FEATURE_FORCE_ADDR_AND_STATUS = 23,
    FEATURE_XMLHTTP = 24,
    FEATURE_DISABLE_TELNET_PROTOCOL = 25,
    FEATURE_FEEDS = 26,
    FEATURE_BLOCK_INPUT_PROMPTS = 27,
    FEATURE_ENTRY_COUNT = 28,
}

const GUID IID_IInternetSecurityMgrSite = {0x79EAC9ED, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9ED, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IInternetSecurityMgrSite : IUnknown
{
    HRESULT GetWindow(HWND* phwnd);
    HRESULT EnableModeless(BOOL fEnable);
}

enum PUAF
{
    PUAF_DEFAULT = 0,
    PUAF_NOUI = 1,
    PUAF_ISFILE = 2,
    PUAF_WARN_IF_DENIED = 4,
    PUAF_FORCEUI_FOREGROUND = 8,
    PUAF_CHECK_TIFS = 16,
    PUAF_DONTCHECKBOXINDIALOG = 32,
    PUAF_TRUSTED = 64,
    PUAF_ACCEPT_WILDCARD_SCHEME = 128,
    PUAF_ENFORCERESTRICTED = 256,
    PUAF_NOSAVEDFILECHECK = 512,
    PUAF_REQUIRESAVEDFILECHECK = 1024,
    PUAF_DONT_USE_CACHE = 4096,
    PUAF_RESERVED1 = 8192,
    PUAF_RESERVED2 = 16384,
    PUAF_LMZ_UNLOCKED = 65536,
    PUAF_LMZ_LOCKED = 131072,
    PUAF_DEFAULTZONEPOL = 262144,
    PUAF_NPL_USE_LOCKED_IF_RESTRICTED = 524288,
    PUAF_NOUIIFLOCKED = 1048576,
    PUAF_DRAGPROTOCOLCHECK = 2097152,
}

enum PUAFOUT
{
    PUAFOUT_DEFAULT = 0,
    PUAFOUT_ISLOCKZONEPOLICY = 1,
}

enum SZM_FLAGS
{
    SZM_CREATE = 0,
    SZM_DELETE = 1,
}

const GUID IID_IInternetSecurityManager = {0x79EAC9EE, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9EE, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IInternetSecurityManager : IUnknown
{
    HRESULT SetSecuritySite(IInternetSecurityMgrSite pSite);
    HRESULT GetSecuritySite(IInternetSecurityMgrSite* ppSite);
    HRESULT MapUrlToZone(const(wchar)* pwszUrl, uint* pdwZone, uint dwFlags);
    HRESULT GetSecurityId(const(wchar)* pwszUrl, char* pbSecurityId, uint* pcbSecurityId, uint dwReserved);
    HRESULT ProcessUrlAction(const(wchar)* pwszUrl, uint dwAction, char* pPolicy, uint cbPolicy, ubyte* pContext, uint cbContext, uint dwFlags, uint dwReserved);
    HRESULT QueryCustomPolicy(const(wchar)* pwszUrl, const(Guid)* guidKey, char* ppPolicy, uint* pcbPolicy, ubyte* pContext, uint cbContext, uint dwReserved);
    HRESULT SetZoneMapping(uint dwZone, const(wchar)* lpszPattern, uint dwFlags);
    HRESULT GetZoneMappings(uint dwZone, IEnumString* ppenumString, uint dwFlags);
}

const GUID IID_IInternetSecurityManagerEx = {0xF164EDF1, 0xCC7C, 0x4F0D, [0x9A, 0x94, 0x34, 0x22, 0x26, 0x25, 0xC3, 0x93]};
@GUID(0xF164EDF1, 0xCC7C, 0x4F0D, [0x9A, 0x94, 0x34, 0x22, 0x26, 0x25, 0xC3, 0x93]);
interface IInternetSecurityManagerEx : IInternetSecurityManager
{
    HRESULT ProcessUrlActionEx(const(wchar)* pwszUrl, uint dwAction, char* pPolicy, uint cbPolicy, ubyte* pContext, uint cbContext, uint dwFlags, uint dwReserved, uint* pdwOutFlags);
}

const GUID IID_IInternetSecurityManagerEx2 = {0xF1E50292, 0xA795, 0x4117, [0x8E, 0x09, 0x2B, 0x56, 0x0A, 0x72, 0xAC, 0x60]};
@GUID(0xF1E50292, 0xA795, 0x4117, [0x8E, 0x09, 0x2B, 0x56, 0x0A, 0x72, 0xAC, 0x60]);
interface IInternetSecurityManagerEx2 : IInternetSecurityManagerEx
{
    HRESULT MapUrlToZoneEx2(IUri pUri, uint* pdwZone, uint dwFlags, ushort** ppwszMappedUrl, uint* pdwOutFlags);
    HRESULT ProcessUrlActionEx2(IUri pUri, uint dwAction, char* pPolicy, uint cbPolicy, ubyte* pContext, uint cbContext, uint dwFlags, uint dwReserved, uint* pdwOutFlags);
    HRESULT GetSecurityIdEx2(IUri pUri, char* pbSecurityId, uint* pcbSecurityId, uint dwReserved);
    HRESULT QueryCustomPolicyEx2(IUri pUri, const(Guid)* guidKey, char* ppPolicy, uint* pcbPolicy, ubyte* pContext, uint cbContext, uint dwReserved);
}

const GUID IID_IZoneIdentifier = {0xCD45F185, 0x1B21, 0x48E2, [0x96, 0x7B, 0xEA, 0xD7, 0x43, 0xA8, 0x91, 0x4E]};
@GUID(0xCD45F185, 0x1B21, 0x48E2, [0x96, 0x7B, 0xEA, 0xD7, 0x43, 0xA8, 0x91, 0x4E]);
interface IZoneIdentifier : IUnknown
{
    HRESULT GetId(uint* pdwZone);
    HRESULT SetId(uint dwZone);
    HRESULT Remove();
}

const GUID IID_IZoneIdentifier2 = {0xEB5E760C, 0x09EF, 0x45C0, [0xB5, 0x10, 0x70, 0x83, 0x0C, 0xE3, 0x1E, 0x6A]};
@GUID(0xEB5E760C, 0x09EF, 0x45C0, [0xB5, 0x10, 0x70, 0x83, 0x0C, 0xE3, 0x1E, 0x6A]);
interface IZoneIdentifier2 : IZoneIdentifier
{
    HRESULT GetLastWriterPackageFamilyName(ushort** packageFamilyName);
    HRESULT SetLastWriterPackageFamilyName(const(wchar)* packageFamilyName);
    HRESULT RemoveLastWriterPackageFamilyName();
    HRESULT GetAppZoneId(uint* zone);
    HRESULT SetAppZoneId(uint zone);
    HRESULT RemoveAppZoneId();
}

const GUID IID_IInternetHostSecurityManager = {0x3AF280B6, 0xCB3F, 0x11D0, [0x89, 0x1E, 0x00, 0xC0, 0x4F, 0xB6, 0xBF, 0xC4]};
@GUID(0x3AF280B6, 0xCB3F, 0x11D0, [0x89, 0x1E, 0x00, 0xC0, 0x4F, 0xB6, 0xBF, 0xC4]);
interface IInternetHostSecurityManager : IUnknown
{
    HRESULT GetSecurityId(char* pbSecurityId, uint* pcbSecurityId, uint dwReserved);
    HRESULT ProcessUrlAction(uint dwAction, char* pPolicy, uint cbPolicy, char* pContext, uint cbContext, uint dwFlags, uint dwReserved);
    HRESULT QueryCustomPolicy(const(Guid)* guidKey, char* ppPolicy, uint* pcbPolicy, char* pContext, uint cbContext, uint dwReserved);
}

enum URLZONE
{
    URLZONE_INVALID = -1,
    URLZONE_PREDEFINED_MIN = 0,
    URLZONE_LOCAL_MACHINE = 0,
    URLZONE_INTRANET = 1,
    URLZONE_TRUSTED = 2,
    URLZONE_INTERNET = 3,
    URLZONE_UNTRUSTED = 4,
    URLZONE_PREDEFINED_MAX = 999,
    URLZONE_USER_MIN = 1000,
    URLZONE_USER_MAX = 10000,
}

enum URLTEMPLATE
{
    URLTEMPLATE_CUSTOM = 0,
    URLTEMPLATE_PREDEFINED_MIN = 65536,
    URLTEMPLATE_LOW = 65536,
    URLTEMPLATE_MEDLOW = 66816,
    URLTEMPLATE_MEDIUM = 69632,
    URLTEMPLATE_MEDHIGH = 70912,
    URLTEMPLATE_HIGH = 73728,
    URLTEMPLATE_PREDEFINED_MAX = 131072,
}

enum __MIDL_IInternetZoneManager_0001
{
    MAX_ZONE_PATH = 260,
    MAX_ZONE_DESCRIPTION = 200,
}

enum ZAFLAGS
{
    ZAFLAGS_CUSTOM_EDIT = 1,
    ZAFLAGS_ADD_SITES = 2,
    ZAFLAGS_REQUIRE_VERIFICATION = 4,
    ZAFLAGS_INCLUDE_PROXY_OVERRIDE = 8,
    ZAFLAGS_INCLUDE_INTRANET_SITES = 16,
    ZAFLAGS_NO_UI = 32,
    ZAFLAGS_SUPPORTS_VERIFICATION = 64,
    ZAFLAGS_UNC_AS_INTRANET = 128,
    ZAFLAGS_DETECT_INTRANET = 256,
    ZAFLAGS_USE_LOCKED_ZONES = 65536,
    ZAFLAGS_VERIFY_TEMPLATE_SETTINGS = 131072,
    ZAFLAGS_NO_CACHE = 262144,
}

struct ZONEATTRIBUTES
{
    uint cbSize;
    ushort szDisplayName;
    ushort szDescription;
    ushort szIconPath;
    uint dwTemplateMinLevel;
    uint dwTemplateRecommended;
    uint dwTemplateCurrentLevel;
    uint dwFlags;
}

enum URLZONEREG
{
    URLZONEREG_DEFAULT = 0,
    URLZONEREG_HKLM = 1,
    URLZONEREG_HKCU = 2,
}

const GUID IID_IInternetZoneManager = {0x79EAC9EF, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9EF, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IInternetZoneManager : IUnknown
{
    HRESULT GetZoneAttributes(uint dwZone, ZONEATTRIBUTES* pZoneAttributes);
    HRESULT SetZoneAttributes(uint dwZone, ZONEATTRIBUTES* pZoneAttributes);
    HRESULT GetZoneCustomPolicy(uint dwZone, const(Guid)* guidKey, ubyte** ppPolicy, uint* pcbPolicy, URLZONEREG urlZoneReg);
    HRESULT SetZoneCustomPolicy(uint dwZone, const(Guid)* guidKey, char* pPolicy, uint cbPolicy, URLZONEREG urlZoneReg);
    HRESULT GetZoneActionPolicy(uint dwZone, uint dwAction, char* pPolicy, uint cbPolicy, URLZONEREG urlZoneReg);
    HRESULT SetZoneActionPolicy(uint dwZone, uint dwAction, char* pPolicy, uint cbPolicy, URLZONEREG urlZoneReg);
    HRESULT PromptAction(uint dwAction, HWND hwndParent, const(wchar)* pwszUrl, const(wchar)* pwszText, uint dwPromptFlags);
    HRESULT LogAction(uint dwAction, const(wchar)* pwszUrl, const(wchar)* pwszText, uint dwLogFlags);
    HRESULT CreateZoneEnumerator(uint* pdwEnum, uint* pdwCount, uint dwFlags);
    HRESULT GetZoneAt(uint dwEnum, uint dwIndex, uint* pdwZone);
    HRESULT DestroyZoneEnumerator(uint dwEnum);
    HRESULT CopyTemplatePoliciesToZone(uint dwTemplate, uint dwZone, uint dwReserved);
}

const GUID IID_IInternetZoneManagerEx = {0xA4C23339, 0x8E06, 0x431E, [0x9B, 0xF4, 0x7E, 0x71, 0x1C, 0x08, 0x56, 0x48]};
@GUID(0xA4C23339, 0x8E06, 0x431E, [0x9B, 0xF4, 0x7E, 0x71, 0x1C, 0x08, 0x56, 0x48]);
interface IInternetZoneManagerEx : IInternetZoneManager
{
    HRESULT GetZoneActionPolicyEx(uint dwZone, uint dwAction, char* pPolicy, uint cbPolicy, URLZONEREG urlZoneReg, uint dwFlags);
    HRESULT SetZoneActionPolicyEx(uint dwZone, uint dwAction, char* pPolicy, uint cbPolicy, URLZONEREG urlZoneReg, uint dwFlags);
}

const GUID IID_IInternetZoneManagerEx2 = {0xEDC17559, 0xDD5D, 0x4846, [0x8E, 0xEF, 0x8B, 0xEC, 0xBA, 0x5A, 0x4A, 0xBF]};
@GUID(0xEDC17559, 0xDD5D, 0x4846, [0x8E, 0xEF, 0x8B, 0xEC, 0xBA, 0x5A, 0x4A, 0xBF]);
interface IInternetZoneManagerEx2 : IInternetZoneManagerEx
{
    HRESULT GetZoneAttributesEx(uint dwZone, ZONEATTRIBUTES* pZoneAttributes, uint dwFlags);
    HRESULT GetZoneSecurityState(uint dwZoneIndex, BOOL fRespectPolicy, uint* pdwState, int* pfPolicyEncountered);
    HRESULT GetIESecurityState(BOOL fRespectPolicy, uint* pdwState, int* pfPolicyEncountered, BOOL fNoCache);
    HRESULT FixUnsecureSettings();
}

struct CODEBASEHOLD
{
    uint cbSize;
    const(wchar)* szDistUnit;
    const(wchar)* szCodeBase;
    uint dwVersionMS;
    uint dwVersionLS;
    uint dwStyle;
}

const GUID IID_ISoftDistExt = {0xB15B8DC1, 0xC7E1, 0x11D0, [0x86, 0x80, 0x00, 0xAA, 0x00, 0xBD, 0xCB, 0x71]};
@GUID(0xB15B8DC1, 0xC7E1, 0x11D0, [0x86, 0x80, 0x00, 0xAA, 0x00, 0xBD, 0xCB, 0x71]);
interface ISoftDistExt : IUnknown
{
    HRESULT ProcessSoftDist(const(wchar)* szCDFURL, IXMLElement pSoftDistElement, SOFTDISTINFO* lpsdi);
    HRESULT GetFirstCodeBase(ushort** szCodeBase, uint* dwMaxSize);
    HRESULT GetNextCodeBase(ushort** szCodeBase, uint* dwMaxSize);
    HRESULT AsyncInstallDistributionUnit(IBindCtx pbc, void* pvReserved, uint flags, CODEBASEHOLD* lpcbh);
}

const GUID IID_ICatalogFileInfo = {0x711C7600, 0x6B48, 0x11D1, [0xB4, 0x03, 0x00, 0xAA, 0x00, 0xB9, 0x2A, 0xF1]};
@GUID(0x711C7600, 0x6B48, 0x11D1, [0xB4, 0x03, 0x00, 0xAA, 0x00, 0xB9, 0x2A, 0xF1]);
interface ICatalogFileInfo : IUnknown
{
    HRESULT GetCatalogFile(byte** ppszCatalogFile);
    HRESULT GetJavaTrust(void** ppJavaTrust);
}

const GUID IID_IDataFilter = {0x69D14C80, 0xC18E, 0x11D0, [0xA9, 0xCE, 0x00, 0x60, 0x97, 0x94, 0x23, 0x11]};
@GUID(0x69D14C80, 0xC18E, 0x11D0, [0xA9, 0xCE, 0x00, 0x60, 0x97, 0x94, 0x23, 0x11]);
interface IDataFilter : IUnknown
{
    HRESULT DoEncode(uint dwFlags, int lInBufferSize, char* pbInBuffer, int lOutBufferSize, char* pbOutBuffer, int lInBytesAvailable, int* plInBytesRead, int* plOutBytesWritten, uint dwReserved);
    HRESULT DoDecode(uint dwFlags, int lInBufferSize, char* pbInBuffer, int lOutBufferSize, char* pbOutBuffer, int lInBytesAvailable, int* plInBytesRead, int* plOutBytesWritten, uint dwReserved);
    HRESULT SetEncodingLevel(uint dwEncLevel);
}

struct PROTOCOLFILTERDATA
{
    uint cbSize;
    IInternetProtocolSink pProtocolSink;
    IInternetProtocol pProtocol;
    IUnknown pUnk;
    uint dwFilterFlags;
}

struct DATAINFO
{
    uint ulTotalSize;
    uint ulavrPacketSize;
    uint ulConnectSpeed;
    uint ulProcessorSpeed;
}

const GUID IID_IEncodingFilterFactory = {0x70BDDE00, 0xC18E, 0x11D0, [0xA9, 0xCE, 0x00, 0x60, 0x97, 0x94, 0x23, 0x11]};
@GUID(0x70BDDE00, 0xC18E, 0x11D0, [0xA9, 0xCE, 0x00, 0x60, 0x97, 0x94, 0x23, 0x11]);
interface IEncodingFilterFactory : IUnknown
{
    HRESULT FindBestFilter(const(wchar)* pwzCodeIn, const(wchar)* pwzCodeOut, DATAINFO info, IDataFilter* ppDF);
    HRESULT GetDefaultFilter(const(wchar)* pwzCodeIn, const(wchar)* pwzCodeOut, IDataFilter* ppDF);
}

struct HIT_LOGGING_INFO
{
    uint dwStructSize;
    const(char)* lpszLoggedUrlName;
    SYSTEMTIME StartTime;
    SYSTEMTIME EndTime;
    const(char)* lpszExtendedInfo;
}

struct CONFIRMSAFETY
{
    Guid clsid;
    IUnknown pUnk;
    uint dwFlags;
}

const GUID IID_IWrappedProtocol = {0x53C84785, 0x8425, 0x4DC5, [0x97, 0x1B, 0xE5, 0x8D, 0x9C, 0x19, 0xF9, 0xB6]};
@GUID(0x53C84785, 0x8425, 0x4DC5, [0x97, 0x1B, 0xE5, 0x8D, 0x9C, 0x19, 0xF9, 0xB6]);
interface IWrappedProtocol : IUnknown
{
    HRESULT GetWrapperCode(int* pnCode, uint dwReserved);
}

enum BINDHANDLETYPES
{
    BINDHANDLETYPES_APPCACHE = 0,
    BINDHANDLETYPES_DEPENDENCY = 1,
    BINDHANDLETYPES_COUNT = 2,
}

const GUID IID_IGetBindHandle = {0xAF0FF408, 0x129D, 0x4B20, [0x91, 0xF0, 0x02, 0xBD, 0x23, 0xD8, 0x83, 0x52]};
@GUID(0xAF0FF408, 0x129D, 0x4B20, [0x91, 0xF0, 0x02, 0xBD, 0x23, 0xD8, 0x83, 0x52]);
interface IGetBindHandle : IUnknown
{
    HRESULT GetBindHandle(BINDHANDLETYPES enumRequestedHandle, HANDLE* pRetHandle);
}

struct PROTOCOL_ARGUMENT
{
    const(wchar)* szMethod;
    const(wchar)* szTargetUrl;
}

const GUID IID_IBindCallbackRedirect = {0x11C81BC2, 0x121E, 0x4ED5, [0xB9, 0xC4, 0xB4, 0x30, 0xBD, 0x54, 0xF2, 0xC0]};
@GUID(0x11C81BC2, 0x121E, 0x4ED5, [0xB9, 0xC4, 0xB4, 0x30, 0xBD, 0x54, 0xF2, 0xC0]);
interface IBindCallbackRedirect : IUnknown
{
    HRESULT Redirect(const(wchar)* lpcUrl, short* vbCancel);
}

const GUID IID_IBindHttpSecurity = {0xA9EDA967, 0xF50E, 0x4A33, [0xB3, 0x58, 0x20, 0x6F, 0x6E, 0xF3, 0x08, 0x6D]};
@GUID(0xA9EDA967, 0xF50E, 0x4A33, [0xB3, 0x58, 0x20, 0x6F, 0x6E, 0xF3, 0x08, 0x6D]);
interface IBindHttpSecurity : IUnknown
{
    HRESULT GetIgnoreCertMask(uint* pdwIgnoreCertMask);
}

struct OLESTREAMVTBL
{
    int Get;
    int Put;
}

struct OLESTREAM
{
    OLESTREAMVTBL* lpstbl;
}

enum UASFLAGS
{
    UAS_NORMAL = 0,
    UAS_BLOCKED = 1,
    UAS_NOPARENTENABLE = 2,
    UAS_MASK = 3,
}

struct CONNECTDATA
{
    IUnknown pUnk;
    uint dwCookie;
}

const GUID IID_IEnumConnections = {0xB196B287, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]};
@GUID(0xB196B287, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]);
interface IEnumConnections : IUnknown
{
    HRESULT Next(uint cConnections, CONNECTDATA* rgcd, uint* pcFetched);
    HRESULT Skip(uint cConnections);
    HRESULT Reset();
    HRESULT Clone(IEnumConnections* ppEnum);
}

const GUID IID_IConnectionPoint = {0xB196B286, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]};
@GUID(0xB196B286, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]);
interface IConnectionPoint : IUnknown
{
    HRESULT GetConnectionInterface(Guid* pIID);
    HRESULT GetConnectionPointContainer(IConnectionPointContainer* ppCPC);
    HRESULT Advise(IUnknown pUnkSink, uint* pdwCookie);
    HRESULT Unadvise(uint dwCookie);
    HRESULT EnumConnections(IEnumConnections* ppEnum);
}

const GUID IID_IEnumConnectionPoints = {0xB196B285, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]};
@GUID(0xB196B285, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]);
interface IEnumConnectionPoints : IUnknown
{
    HRESULT Next(uint cConnections, IConnectionPoint* ppCP, uint* pcFetched);
    HRESULT Skip(uint cConnections);
    HRESULT Reset();
    HRESULT Clone(IEnumConnectionPoints* ppEnum);
}

const GUID IID_IConnectionPointContainer = {0xB196B284, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]};
@GUID(0xB196B284, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]);
interface IConnectionPointContainer : IUnknown
{
    HRESULT EnumConnectionPoints(IEnumConnectionPoints* ppEnum);
    HRESULT FindConnectionPoint(const(Guid)* riid, IConnectionPoint* ppCP);
}

struct LICINFO
{
    int cbLicInfo;
    BOOL fRuntimeKeyAvail;
    BOOL fLicVerified;
}

const GUID IID_IClassFactory2 = {0xB196B28F, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]};
@GUID(0xB196B28F, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]);
interface IClassFactory2 : IClassFactory
{
    HRESULT GetLicInfo(LICINFO* pLicInfo);
    HRESULT RequestLicKey(uint dwReserved, BSTR* pBstrKey);
    HRESULT CreateInstanceLic(IUnknown pUnkOuter, IUnknown pUnkReserved, const(Guid)* riid, BSTR bstrKey, void** ppvObj);
}

const GUID IID_IProvideClassInfo = {0xB196B283, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]};
@GUID(0xB196B283, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]);
interface IProvideClassInfo : IUnknown
{
    HRESULT GetClassInfoA(ITypeInfo* ppTI);
}

enum GUIDKIND
{
    GUIDKIND_DEFAULT_SOURCE_DISP_IID = 1,
}

const GUID IID_IProvideClassInfo2 = {0xA6BC3AC0, 0xDBAA, 0x11CE, [0x9D, 0xE3, 0x00, 0xAA, 0x00, 0x4B, 0xB8, 0x51]};
@GUID(0xA6BC3AC0, 0xDBAA, 0x11CE, [0x9D, 0xE3, 0x00, 0xAA, 0x00, 0x4B, 0xB8, 0x51]);
interface IProvideClassInfo2 : IProvideClassInfo
{
    HRESULT GetGUID(uint dwGuidKind, Guid* pGUID);
}

const GUID IID_IProvideMultipleClassInfo = {0xA7ABA9C1, 0x8983, 0x11CF, [0x8F, 0x20, 0x00, 0x80, 0x5F, 0x2C, 0xD0, 0x64]};
@GUID(0xA7ABA9C1, 0x8983, 0x11CF, [0x8F, 0x20, 0x00, 0x80, 0x5F, 0x2C, 0xD0, 0x64]);
interface IProvideMultipleClassInfo : IProvideClassInfo2
{
    HRESULT GetMultiTypeInfoCount(uint* pcti);
    HRESULT GetInfoOfIndex(uint iti, uint dwFlags, ITypeInfo* pptiCoClass, uint* pdwTIFlags, uint* pcdispidReserved, Guid* piidPrimary, Guid* piidSource);
}

struct CONTROLINFO
{
    uint cb;
    HACCEL hAccel;
    ushort cAccel;
    uint dwFlags;
}

enum CTRLINFO
{
    CTRLINFO_EATS_RETURN = 1,
    CTRLINFO_EATS_ESCAPE = 2,
}

const GUID IID_IOleControl = {0xB196B288, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]};
@GUID(0xB196B288, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]);
interface IOleControl : IUnknown
{
    HRESULT GetControlInfo(CONTROLINFO* pCI);
    HRESULT OnMnemonic(MSG* pMsg);
    HRESULT OnAmbientPropertyChange(int dispID);
    HRESULT FreezeEvents(BOOL bFreeze);
}

struct POINTF
{
    float x;
    float y;
}

enum XFORMCOORDS
{
    XFORMCOORDS_POSITION = 1,
    XFORMCOORDS_SIZE = 2,
    XFORMCOORDS_HIMETRICTOCONTAINER = 4,
    XFORMCOORDS_CONTAINERTOHIMETRIC = 8,
    XFORMCOORDS_EVENTCOMPAT = 16,
}

const GUID IID_IOleControlSite = {0xB196B289, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]};
@GUID(0xB196B289, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]);
interface IOleControlSite : IUnknown
{
    HRESULT OnControlInfoChanged();
    HRESULT LockInPlaceActive(BOOL fLock);
    HRESULT GetExtendedControl(IDispatch* ppDisp);
    HRESULT TransformCoords(POINTL* pPtlHimetric, POINTF* pPtfContainer, uint dwFlags);
    HRESULT TranslateAcceleratorA(MSG* pMsg, uint grfModifiers);
    HRESULT OnFocus(BOOL fGotFocus);
    HRESULT ShowPropertyFrame();
}

struct PROPPAGEINFO
{
    uint cb;
    ushort* pszTitle;
    SIZE size;
    ushort* pszDocString;
    ushort* pszHelpFile;
    uint dwHelpContext;
}

const GUID IID_IPropertyPage = {0xB196B28D, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]};
@GUID(0xB196B28D, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]);
interface IPropertyPage : IUnknown
{
    HRESULT SetPageSite(IPropertyPageSite pPageSite);
    HRESULT Activate(HWND hWndParent, RECT* pRect, BOOL bModal);
    HRESULT Deactivate();
    HRESULT GetPageInfo(PROPPAGEINFO* pPageInfo);
    HRESULT SetObjects(uint cObjects, char* ppUnk);
    HRESULT Show(uint nCmdShow);
    HRESULT Move(RECT* pRect);
    HRESULT IsPageDirty();
    HRESULT Apply();
    HRESULT Help(ushort* pszHelpDir);
    HRESULT TranslateAcceleratorA(MSG* pMsg);
}

const GUID IID_IPropertyPage2 = {0x01E44665, 0x24AC, 0x101B, [0x84, 0xED, 0x08, 0x00, 0x2B, 0x2E, 0xC7, 0x13]};
@GUID(0x01E44665, 0x24AC, 0x101B, [0x84, 0xED, 0x08, 0x00, 0x2B, 0x2E, 0xC7, 0x13]);
interface IPropertyPage2 : IPropertyPage
{
    HRESULT EditProperty(int dispID);
}

enum PROPPAGESTATUS
{
    PROPPAGESTATUS_DIRTY = 1,
    PROPPAGESTATUS_VALIDATE = 2,
    PROPPAGESTATUS_CLEAN = 4,
}

const GUID IID_IPropertyPageSite = {0xB196B28C, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]};
@GUID(0xB196B28C, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]);
interface IPropertyPageSite : IUnknown
{
    HRESULT OnStatusChange(uint dwFlags);
    HRESULT GetLocaleID(uint* pLocaleID);
    HRESULT GetPageContainer(IUnknown* ppUnk);
    HRESULT TranslateAcceleratorA(MSG* pMsg);
}

const GUID IID_IPropertyNotifySink = {0x9BFBBC02, 0xEFF1, 0x101A, [0x84, 0xED, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]};
@GUID(0x9BFBBC02, 0xEFF1, 0x101A, [0x84, 0xED, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]);
interface IPropertyNotifySink : IUnknown
{
    HRESULT OnChanged(int dispID);
    HRESULT OnRequestEdit(int dispID);
}

struct CAUUID
{
    uint cElems;
    Guid* pElems;
}

const GUID IID_ISpecifyPropertyPages = {0xB196B28B, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]};
@GUID(0xB196B28B, 0xBAB4, 0x101A, [0xB6, 0x9C, 0x00, 0xAA, 0x00, 0x34, 0x1D, 0x07]);
interface ISpecifyPropertyPages : IUnknown
{
    HRESULT GetPages(CAUUID* pPages);
}

const GUID IID_IPersistMemory = {0xBD1AE5E0, 0xA6AE, 0x11CE, [0xBD, 0x37, 0x50, 0x42, 0x00, 0xC1, 0x00, 0x00]};
@GUID(0xBD1AE5E0, 0xA6AE, 0x11CE, [0xBD, 0x37, 0x50, 0x42, 0x00, 0xC1, 0x00, 0x00]);
interface IPersistMemory : IPersist
{
    HRESULT IsDirty();
    HRESULT Load(void* pMem, uint cbSize);
    HRESULT Save(void* pMem, BOOL fClearDirty, uint cbSize);
    HRESULT GetSizeMax(uint* pCbSize);
    HRESULT InitNew();
}

const GUID IID_IPersistStreamInit = {0x7FD52380, 0x4E07, 0x101B, [0xAE, 0x2D, 0x08, 0x00, 0x2B, 0x2E, 0xC7, 0x13]};
@GUID(0x7FD52380, 0x4E07, 0x101B, [0xAE, 0x2D, 0x08, 0x00, 0x2B, 0x2E, 0xC7, 0x13]);
interface IPersistStreamInit : IPersist
{
    HRESULT IsDirty();
    HRESULT Load(IStream pStm);
    HRESULT Save(IStream pStm, BOOL fClearDirty);
    HRESULT GetSizeMax(ULARGE_INTEGER* pCbSize);
    HRESULT InitNew();
}

const GUID IID_IPersistPropertyBag = {0x37D84F60, 0x42CB, 0x11CE, [0x81, 0x35, 0x00, 0xAA, 0x00, 0x4B, 0xB8, 0x51]};
@GUID(0x37D84F60, 0x42CB, 0x11CE, [0x81, 0x35, 0x00, 0xAA, 0x00, 0x4B, 0xB8, 0x51]);
interface IPersistPropertyBag : IPersist
{
    HRESULT InitNew();
    HRESULT Load(IPropertyBag pPropBag, IErrorLog pErrorLog);
    HRESULT Save(IPropertyBag pPropBag, BOOL fClearDirty, BOOL fSaveAllProperties);
}

const GUID IID_ISimpleFrameSite = {0x742B0E01, 0x14E6, 0x101B, [0x91, 0x4E, 0x00, 0xAA, 0x00, 0x30, 0x0C, 0xAB]};
@GUID(0x742B0E01, 0x14E6, 0x101B, [0x91, 0x4E, 0x00, 0xAA, 0x00, 0x30, 0x0C, 0xAB]);
interface ISimpleFrameSite : IUnknown
{
    HRESULT PreMessageFilter(HWND hWnd, uint msg, WPARAM wp, LPARAM lp, LRESULT* plResult, uint* pdwCookie);
    HRESULT PostMessageFilter(HWND hWnd, uint msg, WPARAM wp, LPARAM lp, LRESULT* plResult, uint dwCookie);
}

const GUID IID_IFont = {0xBEF6E002, 0xA874, 0x101A, [0x8B, 0xBA, 0x00, 0xAA, 0x00, 0x30, 0x0C, 0xAB]};
@GUID(0xBEF6E002, 0xA874, 0x101A, [0x8B, 0xBA, 0x00, 0xAA, 0x00, 0x30, 0x0C, 0xAB]);
interface IFont : IUnknown
{
    HRESULT get_Name(BSTR* pName);
    HRESULT put_Name(BSTR name);
    HRESULT get_Size(CY* pSize);
    HRESULT put_Size(CY size);
    HRESULT get_Bold(int* pBold);
    HRESULT put_Bold(BOOL bold);
    HRESULT get_Italic(int* pItalic);
    HRESULT put_Italic(BOOL italic);
    HRESULT get_Underline(int* pUnderline);
    HRESULT put_Underline(BOOL underline);
    HRESULT get_Strikethrough(int* pStrikethrough);
    HRESULT put_Strikethrough(BOOL strikethrough);
    HRESULT get_Weight(short* pWeight);
    HRESULT put_Weight(short weight);
    HRESULT get_Charset(short* pCharset);
    HRESULT put_Charset(short charset);
    HRESULT get_hFont(HFONT* phFont);
    HRESULT Clone(IFont* ppFont);
    HRESULT IsEqual(IFont pFontOther);
    HRESULT SetRatio(int cyLogical, int cyHimetric);
    HRESULT QueryTextMetrics(TEXTMETRICW* pTM);
    HRESULT AddRefHfont(HFONT hFont);
    HRESULT ReleaseHfont(HFONT hFont);
    HRESULT SetHdc(HDC hDC);
}

enum PictureAttributes
{
    PICTURE_SCALABLE = 1,
    PICTURE_TRANSPARENT = 2,
}

const GUID IID_IPicture = {0x7BF80980, 0xBF32, 0x101A, [0x8B, 0xBB, 0x00, 0xAA, 0x00, 0x30, 0x0C, 0xAB]};
@GUID(0x7BF80980, 0xBF32, 0x101A, [0x8B, 0xBB, 0x00, 0xAA, 0x00, 0x30, 0x0C, 0xAB]);
interface IPicture : IUnknown
{
    HRESULT get_Handle(uint* pHandle);
    HRESULT get_hPal(uint* phPal);
    HRESULT get_Type(short* pType);
    HRESULT get_Width(int* pWidth);
    HRESULT get_Height(int* pHeight);
    HRESULT Render(HDC hDC, int x, int y, int cx, int cy, int xSrc, int ySrc, int cxSrc, int cySrc, RECT* pRcWBounds);
    HRESULT set_hPal(uint hPal);
    HRESULT get_CurDC(HDC* phDC);
    HRESULT SelectPicture(HDC hDCIn, HDC* phDCOut, uint* phBmpOut);
    HRESULT get_KeepOriginalFormat(int* pKeep);
    HRESULT put_KeepOriginalFormat(BOOL keep);
    HRESULT PictureChanged();
    HRESULT SaveAsFile(IStream pStream, BOOL fSaveMemCopy, int* pCbSize);
    HRESULT get_Attributes(uint* pDwAttr);
}

const GUID IID_IPicture2 = {0xF5185DD8, 0x2012, 0x4B0B, [0xAA, 0xD9, 0xF0, 0x52, 0xC6, 0xBD, 0x48, 0x2B]};
@GUID(0xF5185DD8, 0x2012, 0x4B0B, [0xAA, 0xD9, 0xF0, 0x52, 0xC6, 0xBD, 0x48, 0x2B]);
interface IPicture2 : IUnknown
{
    HRESULT get_Handle(uint* pHandle);
    HRESULT get_hPal(uint* phPal);
    HRESULT get_Type(short* pType);
    HRESULT get_Width(int* pWidth);
    HRESULT get_Height(int* pHeight);
    HRESULT Render(HDC hDC, int x, int y, int cx, int cy, int xSrc, int ySrc, int cxSrc, int cySrc, RECT* pRcWBounds);
    HRESULT set_hPal(uint hPal);
    HRESULT get_CurDC(HDC* phDC);
    HRESULT SelectPicture(HDC hDCIn, HDC* phDCOut, uint* phBmpOut);
    HRESULT get_KeepOriginalFormat(int* pKeep);
    HRESULT put_KeepOriginalFormat(BOOL keep);
    HRESULT PictureChanged();
    HRESULT SaveAsFile(IStream pStream, BOOL fSaveMemCopy, int* pCbSize);
    HRESULT get_Attributes(uint* pDwAttr);
}

const GUID IID_IFontEventsDisp = {0x4EF6100A, 0xAF88, 0x11D0, [0x98, 0x46, 0x00, 0xC0, 0x4F, 0xC2, 0x99, 0x93]};
@GUID(0x4EF6100A, 0xAF88, 0x11D0, [0x98, 0x46, 0x00, 0xC0, 0x4F, 0xC2, 0x99, 0x93]);
interface IFontEventsDisp : IDispatch
{
}

const GUID IID_IFontDisp = {0xBEF6E003, 0xA874, 0x101A, [0x8B, 0xBA, 0x00, 0xAA, 0x00, 0x30, 0x0C, 0xAB]};
@GUID(0xBEF6E003, 0xA874, 0x101A, [0x8B, 0xBA, 0x00, 0xAA, 0x00, 0x30, 0x0C, 0xAB]);
interface IFontDisp : IDispatch
{
}

const GUID IID_IPictureDisp = {0x7BF80981, 0xBF32, 0x101A, [0x8B, 0xBB, 0x00, 0xAA, 0x00, 0x30, 0x0C, 0xAB]};
@GUID(0x7BF80981, 0xBF32, 0x101A, [0x8B, 0xBB, 0x00, 0xAA, 0x00, 0x30, 0x0C, 0xAB]);
interface IPictureDisp : IDispatch
{
}

const GUID IID_IOleInPlaceObjectWindowless = {0x1C2056CC, 0x5EF4, 0x101B, [0x8B, 0xC8, 0x00, 0xAA, 0x00, 0x3E, 0x3B, 0x29]};
@GUID(0x1C2056CC, 0x5EF4, 0x101B, [0x8B, 0xC8, 0x00, 0xAA, 0x00, 0x3E, 0x3B, 0x29]);
interface IOleInPlaceObjectWindowless : IOleInPlaceObject
{
    HRESULT OnWindowMessage(uint msg, WPARAM wParam, LPARAM lParam, LRESULT* plResult);
    HRESULT GetDropTarget(IDropTarget* ppDropTarget);
}

enum ACTIVATEFLAGS
{
    ACTIVATE_WINDOWLESS = 1,
}

const GUID IID_IOleInPlaceSiteEx = {0x9C2CAD80, 0x3424, 0x11CF, [0xB6, 0x70, 0x00, 0xAA, 0x00, 0x4C, 0xD6, 0xD8]};
@GUID(0x9C2CAD80, 0x3424, 0x11CF, [0xB6, 0x70, 0x00, 0xAA, 0x00, 0x4C, 0xD6, 0xD8]);
interface IOleInPlaceSiteEx : IOleInPlaceSite
{
    HRESULT OnInPlaceActivateEx(int* pfNoRedraw, uint dwFlags);
    HRESULT OnInPlaceDeactivateEx(BOOL fNoRedraw);
    HRESULT RequestUIActivate();
}

enum OLEDCFLAGS
{
    OLEDC_NODRAW = 1,
    OLEDC_PAINTBKGND = 2,
    OLEDC_OFFSCREEN = 4,
}

const GUID IID_IOleInPlaceSiteWindowless = {0x922EADA0, 0x3424, 0x11CF, [0xB6, 0x70, 0x00, 0xAA, 0x00, 0x4C, 0xD6, 0xD8]};
@GUID(0x922EADA0, 0x3424, 0x11CF, [0xB6, 0x70, 0x00, 0xAA, 0x00, 0x4C, 0xD6, 0xD8]);
interface IOleInPlaceSiteWindowless : IOleInPlaceSiteEx
{
    HRESULT CanWindowlessActivate();
    HRESULT GetCapture();
    HRESULT SetCapture(BOOL fCapture);
    HRESULT GetFocus();
    HRESULT SetFocus(BOOL fFocus);
    HRESULT GetDC(RECT* pRect, uint grfFlags, HDC* phDC);
    HRESULT ReleaseDC(HDC hDC);
    HRESULT InvalidateRect(RECT* pRect, BOOL fErase);
    HRESULT InvalidateRgn(HRGN hRGN, BOOL fErase);
    HRESULT ScrollRect(int dx, int dy, RECT* pRectScroll, RECT* pRectClip);
    HRESULT AdjustRect(RECT* prc);
    HRESULT OnDefWindowMessage(uint msg, WPARAM wParam, LPARAM lParam, LRESULT* plResult);
}

enum VIEWSTATUS
{
    VIEWSTATUS_OPAQUE = 1,
    VIEWSTATUS_SOLIDBKGND = 2,
    VIEWSTATUS_DVASPECTOPAQUE = 4,
    VIEWSTATUS_DVASPECTTRANSPARENT = 8,
    VIEWSTATUS_SURFACE = 16,
    VIEWSTATUS_3DSURFACE = 32,
}

enum HITRESULT
{
    HITRESULT_OUTSIDE = 0,
    HITRESULT_TRANSPARENT = 1,
    HITRESULT_CLOSE = 2,
    HITRESULT_HIT = 3,
}

enum DVASPECT2
{
    DVASPECT_OPAQUE = 16,
    DVASPECT_TRANSPARENT = 32,
}

struct ExtentInfo
{
    uint cb;
    uint dwExtentMode;
    SIZE sizelProposed;
}

enum ExtentMode
{
    DVEXTENT_CONTENT = 0,
    DVEXTENT_INTEGRAL = 1,
}

enum AspectInfoFlag
{
    DVASPECTINFOFLAG_CANOPTIMIZE = 1,
}

struct AspectInfo
{
    uint cb;
    uint dwFlags;
}

const GUID IID_IViewObjectEx = {0x3AF24292, 0x0C96, 0x11CE, [0xA0, 0xCF, 0x00, 0xAA, 0x00, 0x60, 0x0A, 0xB8]};
@GUID(0x3AF24292, 0x0C96, 0x11CE, [0xA0, 0xCF, 0x00, 0xAA, 0x00, 0x60, 0x0A, 0xB8]);
interface IViewObjectEx : IViewObject2
{
    HRESULT GetRect(uint dwAspect, RECTL* pRect);
    HRESULT GetViewStatus(uint* pdwStatus);
    HRESULT QueryHitPoint(uint dwAspect, RECT* pRectBounds, POINT ptlLoc, int lCloseHint, uint* pHitResult);
    HRESULT QueryHitRect(uint dwAspect, RECT* pRectBounds, RECT* pRectLoc, int lCloseHint, uint* pHitResult);
    HRESULT GetNaturalExtent(uint dwAspect, int lindex, DVTARGETDEVICE* ptd, HDC hicTargetDev, ExtentInfo* pExtentInfo, SIZE* pSizel);
}

const GUID IID_IOleUndoUnit = {0x894AD3B0, 0xEF97, 0x11CE, [0x9B, 0xC9, 0x00, 0xAA, 0x00, 0x60, 0x8E, 0x01]};
@GUID(0x894AD3B0, 0xEF97, 0x11CE, [0x9B, 0xC9, 0x00, 0xAA, 0x00, 0x60, 0x8E, 0x01]);
interface IOleUndoUnit : IUnknown
{
    HRESULT Do(IOleUndoManager pUndoManager);
    HRESULT GetDescription(BSTR* pBstr);
    HRESULT GetUnitType(Guid* pClsid, int* plID);
    HRESULT OnNextAdd();
}

const GUID IID_IOleParentUndoUnit = {0xA1FAF330, 0xEF97, 0x11CE, [0x9B, 0xC9, 0x00, 0xAA, 0x00, 0x60, 0x8E, 0x01]};
@GUID(0xA1FAF330, 0xEF97, 0x11CE, [0x9B, 0xC9, 0x00, 0xAA, 0x00, 0x60, 0x8E, 0x01]);
interface IOleParentUndoUnit : IOleUndoUnit
{
    HRESULT Open(IOleParentUndoUnit pPUU);
    HRESULT Close(IOleParentUndoUnit pPUU, BOOL fCommit);
    HRESULT Add(IOleUndoUnit pUU);
    HRESULT FindUnit(IOleUndoUnit pUU);
    HRESULT GetParentState(uint* pdwState);
}

const GUID IID_IEnumOleUndoUnits = {0xB3E7C340, 0xEF97, 0x11CE, [0x9B, 0xC9, 0x00, 0xAA, 0x00, 0x60, 0x8E, 0x01]};
@GUID(0xB3E7C340, 0xEF97, 0x11CE, [0x9B, 0xC9, 0x00, 0xAA, 0x00, 0x60, 0x8E, 0x01]);
interface IEnumOleUndoUnits : IUnknown
{
    HRESULT Next(uint cElt, IOleUndoUnit* rgElt, uint* pcEltFetched);
    HRESULT Skip(uint cElt);
    HRESULT Reset();
    HRESULT Clone(IEnumOleUndoUnits* ppEnum);
}

const GUID IID_IOleUndoManager = {0xD001F200, 0xEF97, 0x11CE, [0x9B, 0xC9, 0x00, 0xAA, 0x00, 0x60, 0x8E, 0x01]};
@GUID(0xD001F200, 0xEF97, 0x11CE, [0x9B, 0xC9, 0x00, 0xAA, 0x00, 0x60, 0x8E, 0x01]);
interface IOleUndoManager : IUnknown
{
    HRESULT Open(IOleParentUndoUnit pPUU);
    HRESULT Close(IOleParentUndoUnit pPUU, BOOL fCommit);
    HRESULT Add(IOleUndoUnit pUU);
    HRESULT GetOpenParentState(uint* pdwState);
    HRESULT DiscardFrom(IOleUndoUnit pUU);
    HRESULT UndoTo(IOleUndoUnit pUU);
    HRESULT RedoTo(IOleUndoUnit pUU);
    HRESULT EnumUndoable(IEnumOleUndoUnits* ppEnum);
    HRESULT EnumRedoable(IEnumOleUndoUnits* ppEnum);
    HRESULT GetLastUndoDescription(BSTR* pBstr);
    HRESULT GetLastRedoDescription(BSTR* pBstr);
    HRESULT Enable(BOOL fEnable);
}

enum POINTERINACTIVE
{
    POINTERINACTIVE_ACTIVATEONENTRY = 1,
    POINTERINACTIVE_DEACTIVATEONLEAVE = 2,
    POINTERINACTIVE_ACTIVATEONDRAG = 4,
}

const GUID IID_IPointerInactive = {0x55980BA0, 0x35AA, 0x11CF, [0xB6, 0x71, 0x00, 0xAA, 0x00, 0x4C, 0xD6, 0xD8]};
@GUID(0x55980BA0, 0x35AA, 0x11CF, [0xB6, 0x71, 0x00, 0xAA, 0x00, 0x4C, 0xD6, 0xD8]);
interface IPointerInactive : IUnknown
{
    HRESULT GetActivationPolicy(uint* pdwPolicy);
    HRESULT OnInactiveMouseMove(RECT* pRectBounds, int x, int y, uint grfKeyState);
    HRESULT OnInactiveSetCursor(RECT* pRectBounds, int x, int y, uint dwMouseMsg, BOOL fSetAlways);
}

const GUID IID_IObjectWithSite = {0xFC4801A3, 0x2BA9, 0x11CF, [0xA2, 0x29, 0x00, 0xAA, 0x00, 0x3D, 0x73, 0x52]};
@GUID(0xFC4801A3, 0x2BA9, 0x11CF, [0xA2, 0x29, 0x00, 0xAA, 0x00, 0x3D, 0x73, 0x52]);
interface IObjectWithSite : IUnknown
{
    HRESULT SetSite(IUnknown pUnkSite);
    HRESULT GetSite(const(Guid)* riid, void** ppvSite);
}

struct CALPOLESTR
{
    uint cElems;
    ushort** pElems;
}

struct CADWORD
{
    uint cElems;
    uint* pElems;
}

const GUID IID_IPerPropertyBrowsing = {0x376BD3AA, 0x3845, 0x101B, [0x84, 0xED, 0x08, 0x00, 0x2B, 0x2E, 0xC7, 0x13]};
@GUID(0x376BD3AA, 0x3845, 0x101B, [0x84, 0xED, 0x08, 0x00, 0x2B, 0x2E, 0xC7, 0x13]);
interface IPerPropertyBrowsing : IUnknown
{
    HRESULT GetDisplayString(int dispID, BSTR* pBstr);
    HRESULT MapPropertyToPage(int dispID, Guid* pClsid);
    HRESULT GetPredefinedStrings(int dispID, CALPOLESTR* pCaStringsOut, CADWORD* pCaCookiesOut);
    HRESULT GetPredefinedValue(int dispID, uint dwCookie, VARIANT* pVarOut);
}

enum PROPBAG2_TYPE
{
    PROPBAG2_TYPE_UNDEFINED = 0,
    PROPBAG2_TYPE_DATA = 1,
    PROPBAG2_TYPE_URL = 2,
    PROPBAG2_TYPE_OBJECT = 3,
    PROPBAG2_TYPE_STREAM = 4,
    PROPBAG2_TYPE_STORAGE = 5,
    PROPBAG2_TYPE_MONIKER = 6,
}

struct PROPBAG2
{
    uint dwType;
    ushort vt;
    ushort cfType;
    uint dwHint;
    ushort* pstrName;
    Guid clsid;
}

const GUID IID_IPropertyBag2 = {0x22F55882, 0x280B, 0x11D0, [0xA8, 0xA9, 0x00, 0xA0, 0xC9, 0x0C, 0x20, 0x04]};
@GUID(0x22F55882, 0x280B, 0x11D0, [0xA8, 0xA9, 0x00, 0xA0, 0xC9, 0x0C, 0x20, 0x04]);
interface IPropertyBag2 : IUnknown
{
    HRESULT Read(uint cProperties, char* pPropBag, IErrorLog pErrLog, char* pvarValue, char* phrError);
    HRESULT Write(uint cProperties, char* pPropBag, char* pvarValue);
    HRESULT CountProperties(uint* pcProperties);
    HRESULT GetPropertyInfo(uint iProperty, uint cProperties, char* pPropBag, uint* pcProperties);
    HRESULT LoadObject(ushort* pstrName, uint dwHint, IUnknown pUnkObject, IErrorLog pErrLog);
}

const GUID IID_IPersistPropertyBag2 = {0x22F55881, 0x280B, 0x11D0, [0xA8, 0xA9, 0x00, 0xA0, 0xC9, 0x0C, 0x20, 0x04]};
@GUID(0x22F55881, 0x280B, 0x11D0, [0xA8, 0xA9, 0x00, 0xA0, 0xC9, 0x0C, 0x20, 0x04]);
interface IPersistPropertyBag2 : IPersist
{
    HRESULT InitNew();
    HRESULT Load(IPropertyBag2 pPropBag, IErrorLog pErrLog);
    HRESULT Save(IPropertyBag2 pPropBag, BOOL fClearDirty, BOOL fSaveAllProperties);
    HRESULT IsDirty();
}

const GUID IID_IAdviseSinkEx = {0x3AF24290, 0x0C96, 0x11CE, [0xA0, 0xCF, 0x00, 0xAA, 0x00, 0x60, 0x0A, 0xB8]};
@GUID(0x3AF24290, 0x0C96, 0x11CE, [0xA0, 0xCF, 0x00, 0xAA, 0x00, 0x60, 0x0A, 0xB8]);
interface IAdviseSinkEx : IAdviseSink
{
    void OnViewStatusChange(uint dwViewStatus);
}

enum QACONTAINERFLAGS
{
    QACONTAINER_SHOWHATCHING = 1,
    QACONTAINER_SHOWGRABHANDLES = 2,
    QACONTAINER_USERMODE = 4,
    QACONTAINER_DISPLAYASDEFAULT = 8,
    QACONTAINER_UIDEAD = 16,
    QACONTAINER_AUTOCLIP = 32,
    QACONTAINER_MESSAGEREFLECT = 64,
    QACONTAINER_SUPPORTSMNEMONICS = 128,
}

struct QACONTAINER
{
    uint cbSize;
    IOleClientSite pClientSite;
    IAdviseSinkEx pAdviseSink;
    IPropertyNotifySink pPropertyNotifySink;
    IUnknown pUnkEventSink;
    uint dwAmbientFlags;
    uint colorFore;
    uint colorBack;
    IFont pFont;
    IOleUndoManager pUndoMgr;
    uint dwAppearance;
    int lcid;
    HPALETTE hpal;
    IBindHost pBindHost;
    IOleControlSite pOleControlSite;
    IServiceProvider pServiceProvider;
}

struct QACONTROL
{
    uint cbSize;
    uint dwMiscStatus;
    uint dwViewStatus;
    uint dwEventCookie;
    uint dwPropNotifyCookie;
    uint dwPointerActivationPolicy;
}

const GUID IID_IQuickActivate = {0xCF51ED10, 0x62FE, 0x11CF, [0xBF, 0x86, 0x00, 0xA0, 0xC9, 0x03, 0x48, 0x36]};
@GUID(0xCF51ED10, 0x62FE, 0x11CF, [0xBF, 0x86, 0x00, 0xA0, 0xC9, 0x03, 0x48, 0x36]);
interface IQuickActivate : IUnknown
{
    HRESULT QuickActivate(QACONTAINER* pQaContainer, QACONTROL* pQaControl);
    HRESULT SetContentExtent(SIZE* pSizel);
    HRESULT GetContentExtent(SIZE* pSizel);
}

struct OCPFIPARAMS
{
    uint cbStructSize;
    HWND hWndOwner;
    int x;
    int y;
    ushort* lpszCaption;
    uint cObjects;
    IUnknown* lplpUnk;
    uint cPages;
    Guid* lpPages;
    uint lcid;
    int dispidInitialProperty;
}

struct FONTDESC
{
    uint cbSizeofstruct;
    ushort* lpstrName;
    CY cySize;
    short sWeight;
    short sCharset;
    BOOL fItalic;
    BOOL fUnderline;
    BOOL fStrikethrough;
}

struct PICTDESC
{
    uint cbSizeofstruct;
    uint picType;
    _Anonymous_e__Union Anonymous;
}

enum OLE_TRISTATE
{
    triUnchecked = 0,
    triChecked = 1,
    triGray = 2,
}

interface IVBGetControl : IUnknown
{
    HRESULT EnumControls(uint dwOleContF, uint dwWhich, IEnumUnknown* ppenumUnk);
}

interface IGetOleObject : IUnknown
{
    HRESULT GetOleObject(const(Guid)* riid, void** ppvObj);
}

interface IVBFormat : IUnknown
{
    HRESULT Format(VARIANT* vData, BSTR bstrFormat, void* lpBuffer, ushort cb, int lcid, short sFirstDayOfWeek, ushort sFirstWeekOfYear, ushort* rcb);
}

interface IGetVBAObject : IUnknown
{
    HRESULT GetObjectA(const(Guid)* riid, void** ppvObj, uint dwReserved);
}

enum DOCMISC
{
    DOCMISC_CANCREATEMULTIPLEVIEWS = 1,
    DOCMISC_SUPPORTCOMPLEXRECTANGLES = 2,
    DOCMISC_CANTOPENEDIT = 4,
    DOCMISC_NOFILESUPPORT = 8,
}

const GUID IID_IOleDocument = {0xB722BCC5, 0x4E68, 0x101B, [0xA2, 0xBC, 0x00, 0xAA, 0x00, 0x40, 0x47, 0x70]};
@GUID(0xB722BCC5, 0x4E68, 0x101B, [0xA2, 0xBC, 0x00, 0xAA, 0x00, 0x40, 0x47, 0x70]);
interface IOleDocument : IUnknown
{
    HRESULT CreateView(IOleInPlaceSite pIPSite, IStream pstm, uint dwReserved, IOleDocumentView* ppView);
    HRESULT GetDocMiscStatus(uint* pdwStatus);
    HRESULT EnumViews(IEnumOleDocumentViews* ppEnum, IOleDocumentView* ppView);
}

const GUID IID_IOleDocumentSite = {0xB722BCC7, 0x4E68, 0x101B, [0xA2, 0xBC, 0x00, 0xAA, 0x00, 0x40, 0x47, 0x70]};
@GUID(0xB722BCC7, 0x4E68, 0x101B, [0xA2, 0xBC, 0x00, 0xAA, 0x00, 0x40, 0x47, 0x70]);
interface IOleDocumentSite : IUnknown
{
    HRESULT ActivateMe(IOleDocumentView pViewToActivate);
}

const GUID IID_IOleDocumentView = {0xB722BCC6, 0x4E68, 0x101B, [0xA2, 0xBC, 0x00, 0xAA, 0x00, 0x40, 0x47, 0x70]};
@GUID(0xB722BCC6, 0x4E68, 0x101B, [0xA2, 0xBC, 0x00, 0xAA, 0x00, 0x40, 0x47, 0x70]);
interface IOleDocumentView : IUnknown
{
    HRESULT SetInPlaceSite(IOleInPlaceSite pIPSite);
    HRESULT GetInPlaceSite(IOleInPlaceSite* ppIPSite);
    HRESULT GetDocument(IUnknown* ppunk);
    HRESULT SetRect(RECT* prcView);
    HRESULT GetRect(RECT* prcView);
    HRESULT SetRectComplex(RECT* prcView, RECT* prcHScroll, RECT* prcVScroll, RECT* prcSizeBox);
    HRESULT Show(BOOL fShow);
    HRESULT UIActivate(BOOL fUIActivate);
    HRESULT Open();
    HRESULT CloseView(uint dwReserved);
    HRESULT SaveViewState(IStream pstm);
    HRESULT ApplyViewState(IStream pstm);
    HRESULT Clone(IOleInPlaceSite pIPSiteNew, IOleDocumentView* ppViewNew);
}

const GUID IID_IEnumOleDocumentViews = {0xB722BCC8, 0x4E68, 0x101B, [0xA2, 0xBC, 0x00, 0xAA, 0x00, 0x40, 0x47, 0x70]};
@GUID(0xB722BCC8, 0x4E68, 0x101B, [0xA2, 0xBC, 0x00, 0xAA, 0x00, 0x40, 0x47, 0x70]);
interface IEnumOleDocumentViews : IUnknown
{
    HRESULT Next(uint cViews, IOleDocumentView* rgpView, uint* pcFetched);
    HRESULT Skip(uint cViews);
    HRESULT Reset();
    HRESULT Clone(IEnumOleDocumentViews* ppEnum);
}

const GUID IID_IContinueCallback = {0xB722BCCA, 0x4E68, 0x101B, [0xA2, 0xBC, 0x00, 0xAA, 0x00, 0x40, 0x47, 0x70]};
@GUID(0xB722BCCA, 0x4E68, 0x101B, [0xA2, 0xBC, 0x00, 0xAA, 0x00, 0x40, 0x47, 0x70]);
interface IContinueCallback : IUnknown
{
    HRESULT FContinue();
    HRESULT FContinuePrinting(int nCntPrinted, int nCurPage, ushort* pwszPrintStatus);
}

enum __MIDL_IPrint_0001
{
    PRINTFLAG_MAYBOTHERUSER = 1,
    PRINTFLAG_PROMPTUSER = 2,
    PRINTFLAG_USERMAYCHANGEPRINTER = 4,
    PRINTFLAG_RECOMPOSETODEVICE = 8,
    PRINTFLAG_DONTACTUALLYPRINT = 16,
    PRINTFLAG_FORCEPROPERTIES = 32,
    PRINTFLAG_PRINTTOFILE = 64,
}

struct PAGERANGE
{
    int nFromPage;
    int nToPage;
}

struct PAGESET
{
    uint cbStruct;
    BOOL fOddPages;
    BOOL fEvenPages;
    uint cPageRange;
    PAGERANGE rgPages;
}

const GUID IID_IPrint = {0xB722BCC9, 0x4E68, 0x101B, [0xA2, 0xBC, 0x00, 0xAA, 0x00, 0x40, 0x47, 0x70]};
@GUID(0xB722BCC9, 0x4E68, 0x101B, [0xA2, 0xBC, 0x00, 0xAA, 0x00, 0x40, 0x47, 0x70]);
interface IPrint : IUnknown
{
    HRESULT SetInitialPageNum(int nFirstPage);
    HRESULT GetPageInfo(int* pnFirstPage, int* pcPages);
    HRESULT Print(uint grfFlags, DVTARGETDEVICE** pptd, PAGESET** ppPageSet, STGMEDIUM* pstgmOptions, IContinueCallback pcallback, int nFirstPage, int* pcPagesPrinted, int* pnLastPage);
}

enum OLECMDF
{
    OLECMDF_SUPPORTED = 1,
    OLECMDF_ENABLED = 2,
    OLECMDF_LATCHED = 4,
    OLECMDF_NINCHED = 8,
    OLECMDF_INVISIBLE = 16,
    OLECMDF_DEFHIDEONCTXTMENU = 32,
}

struct OLECMD
{
    uint cmdID;
    uint cmdf;
}

struct OLECMDTEXT
{
    uint cmdtextf;
    uint cwActual;
    uint cwBuf;
    ushort rgwz;
}

enum OLECMDTEXTF
{
    OLECMDTEXTF_NONE = 0,
    OLECMDTEXTF_NAME = 1,
    OLECMDTEXTF_STATUS = 2,
}

enum OLECMDEXECOPT
{
    OLECMDEXECOPT_DODEFAULT = 0,
    OLECMDEXECOPT_PROMPTUSER = 1,
    OLECMDEXECOPT_DONTPROMPTUSER = 2,
    OLECMDEXECOPT_SHOWHELP = 3,
}

enum OLECMDID
{
    OLECMDID_OPEN = 1,
    OLECMDID_NEW = 2,
    OLECMDID_SAVE = 3,
    OLECMDID_SAVEAS = 4,
    OLECMDID_SAVECOPYAS = 5,
    OLECMDID_PRINT = 6,
    OLECMDID_PRINTPREVIEW = 7,
    OLECMDID_PAGESETUP = 8,
    OLECMDID_SPELL = 9,
    OLECMDID_PROPERTIES = 10,
    OLECMDID_CUT = 11,
    OLECMDID_COPY = 12,
    OLECMDID_PASTE = 13,
    OLECMDID_PASTESPECIAL = 14,
    OLECMDID_UNDO = 15,
    OLECMDID_REDO = 16,
    OLECMDID_SELECTALL = 17,
    OLECMDID_CLEARSELECTION = 18,
    OLECMDID_ZOOM = 19,
    OLECMDID_GETZOOMRANGE = 20,
    OLECMDID_UPDATECOMMANDS = 21,
    OLECMDID_REFRESH = 22,
    OLECMDID_STOP = 23,
    OLECMDID_HIDETOOLBARS = 24,
    OLECMDID_SETPROGRESSMAX = 25,
    OLECMDID_SETPROGRESSPOS = 26,
    OLECMDID_SETPROGRESSTEXT = 27,
    OLECMDID_SETTITLE = 28,
    OLECMDID_SETDOWNLOADSTATE = 29,
    OLECMDID_STOPDOWNLOAD = 30,
    OLECMDID_ONTOOLBARACTIVATED = 31,
    OLECMDID_FIND = 32,
    OLECMDID_DELETE = 33,
    OLECMDID_HTTPEQUIV = 34,
    OLECMDID_HTTPEQUIV_DONE = 35,
    OLECMDID_ENABLE_INTERACTION = 36,
    OLECMDID_ONUNLOAD = 37,
    OLECMDID_PROPERTYBAG2 = 38,
    OLECMDID_PREREFRESH = 39,
    OLECMDID_SHOWSCRIPTERROR = 40,
    OLECMDID_SHOWMESSAGE = 41,
    OLECMDID_SHOWFIND = 42,
    OLECMDID_SHOWPAGESETUP = 43,
    OLECMDID_SHOWPRINT = 44,
    OLECMDID_CLOSE = 45,
    OLECMDID_ALLOWUILESSSAVEAS = 46,
    OLECMDID_DONTDOWNLOADCSS = 47,
    OLECMDID_UPDATEPAGESTATUS = 48,
    OLECMDID_PRINT2 = 49,
    OLECMDID_PRINTPREVIEW2 = 50,
    OLECMDID_SETPRINTTEMPLATE = 51,
    OLECMDID_GETPRINTTEMPLATE = 52,
    OLECMDID_PAGEACTIONBLOCKED = 55,
    OLECMDID_PAGEACTIONUIQUERY = 56,
    OLECMDID_FOCUSVIEWCONTROLS = 57,
    OLECMDID_FOCUSVIEWCONTROLSQUERY = 58,
    OLECMDID_SHOWPAGEACTIONMENU = 59,
    OLECMDID_ADDTRAVELENTRY = 60,
    OLECMDID_UPDATETRAVELENTRY = 61,
    OLECMDID_UPDATEBACKFORWARDSTATE = 62,
    OLECMDID_OPTICAL_ZOOM = 63,
    OLECMDID_OPTICAL_GETZOOMRANGE = 64,
    OLECMDID_WINDOWSTATECHANGED = 65,
    OLECMDID_ACTIVEXINSTALLSCOPE = 66,
    OLECMDID_UPDATETRAVELENTRY_DATARECOVERY = 67,
    OLECMDID_SHOWTASKDLG = 68,
    OLECMDID_POPSTATEEVENT = 69,
    OLECMDID_VIEWPORT_MODE = 70,
    OLECMDID_LAYOUT_VIEWPORT_WIDTH = 71,
    OLECMDID_VISUAL_VIEWPORT_EXCLUDE_BOTTOM = 72,
    OLECMDID_USER_OPTICAL_ZOOM = 73,
    OLECMDID_PAGEAVAILABLE = 74,
    OLECMDID_GETUSERSCALABLE = 75,
    OLECMDID_UPDATE_CARET = 76,
    OLECMDID_ENABLE_VISIBILITY = 77,
    OLECMDID_MEDIA_PLAYBACK = 78,
    OLECMDID_SETFAVICON = 79,
    OLECMDID_SET_HOST_FULLSCREENMODE = 80,
    OLECMDID_EXITFULLSCREEN = 81,
    OLECMDID_SCROLLCOMPLETE = 82,
    OLECMDID_ONBEFOREUNLOAD = 83,
    OLECMDID_SHOWMESSAGE_BLOCKABLE = 84,
    OLECMDID_SHOWTASKDLG_BLOCKABLE = 85,
}

enum MEDIAPLAYBACK_STATE
{
    MEDIAPLAYBACK_RESUME = 0,
    MEDIAPLAYBACK_PAUSE = 1,
    MEDIAPLAYBACK_PAUSE_AND_SUSPEND = 2,
    MEDIAPLAYBACK_RESUME_FROM_SUSPEND = 3,
}

enum IGNOREMIME
{
    IGNOREMIME_PROMPT = 1,
    IGNOREMIME_TEXT = 2,
}

enum WPCSETTING
{
    WPCSETTING_LOGGING_ENABLED = 1,
    WPCSETTING_FILEDOWNLOAD_BLOCKED = 2,
}

const GUID IID_IOleCommandTarget = {0xB722BCCB, 0x4E68, 0x101B, [0xA2, 0xBC, 0x00, 0xAA, 0x00, 0x40, 0x47, 0x70]};
@GUID(0xB722BCCB, 0x4E68, 0x101B, [0xA2, 0xBC, 0x00, 0xAA, 0x00, 0x40, 0x47, 0x70]);
interface IOleCommandTarget : IUnknown
{
    HRESULT QueryStatus(const(Guid)* pguidCmdGroup, uint cCmds, char* prgCmds, OLECMDTEXT* pCmdText);
    HRESULT Exec(const(Guid)* pguidCmdGroup, uint nCmdID, uint nCmdexecopt, VARIANT* pvaIn, VARIANT* pvaOut);
}

enum OLECMDID_REFRESHFLAG
{
    OLECMDIDF_REFRESH_NORMAL = 0,
    OLECMDIDF_REFRESH_IFEXPIRED = 1,
    OLECMDIDF_REFRESH_CONTINUE = 2,
    OLECMDIDF_REFRESH_COMPLETELY = 3,
    OLECMDIDF_REFRESH_NO_CACHE = 4,
    OLECMDIDF_REFRESH_RELOAD = 5,
    OLECMDIDF_REFRESH_LEVELMASK = 255,
    OLECMDIDF_REFRESH_CLEARUSERINPUT = 4096,
    OLECMDIDF_REFRESH_PROMPTIFOFFLINE = 8192,
    OLECMDIDF_REFRESH_THROUGHSCRIPT = 16384,
    OLECMDIDF_REFRESH_SKIPBEFOREUNLOADEVENT = 32768,
    OLECMDIDF_REFRESH_PAGEACTION_ACTIVEXINSTALL = 65536,
    OLECMDIDF_REFRESH_PAGEACTION_FILEDOWNLOAD = 131072,
    OLECMDIDF_REFRESH_PAGEACTION_LOCALMACHINE = 262144,
    OLECMDIDF_REFRESH_PAGEACTION_POPUPWINDOW = 524288,
    OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNLOCALMACHINE = 1048576,
    OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNTRUSTED = 2097152,
    OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNINTRANET = 4194304,
    OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNINTERNET = 8388608,
    OLECMDIDF_REFRESH_PAGEACTION_PROTLOCKDOWNRESTRICTED = 16777216,
    OLECMDIDF_REFRESH_PAGEACTION_MIXEDCONTENT = 33554432,
    OLECMDIDF_REFRESH_PAGEACTION_INVALID_CERT = 67108864,
    OLECMDIDF_REFRESH_PAGEACTION_ALLOW_VERSION = 134217728,
}

enum OLECMDID_PAGEACTIONFLAG
{
    OLECMDIDF_PAGEACTION_FILEDOWNLOAD = 1,
    OLECMDIDF_PAGEACTION_ACTIVEXINSTALL = 2,
    OLECMDIDF_PAGEACTION_ACTIVEXTRUSTFAIL = 4,
    OLECMDIDF_PAGEACTION_ACTIVEXUSERDISABLE = 8,
    OLECMDIDF_PAGEACTION_ACTIVEXDISALLOW = 16,
    OLECMDIDF_PAGEACTION_ACTIVEXUNSAFE = 32,
    OLECMDIDF_PAGEACTION_POPUPWINDOW = 64,
    OLECMDIDF_PAGEACTION_LOCALMACHINE = 128,
    OLECMDIDF_PAGEACTION_MIMETEXTPLAIN = 256,
    OLECMDIDF_PAGEACTION_SCRIPTNAVIGATE = 512,
    OLECMDIDF_PAGEACTION_SCRIPTNAVIGATE_ACTIVEXINSTALL = 512,
    OLECMDIDF_PAGEACTION_PROTLOCKDOWNLOCALMACHINE = 1024,
    OLECMDIDF_PAGEACTION_PROTLOCKDOWNTRUSTED = 2048,
    OLECMDIDF_PAGEACTION_PROTLOCKDOWNINTRANET = 4096,
    OLECMDIDF_PAGEACTION_PROTLOCKDOWNINTERNET = 8192,
    OLECMDIDF_PAGEACTION_PROTLOCKDOWNRESTRICTED = 16384,
    OLECMDIDF_PAGEACTION_PROTLOCKDOWNDENY = 32768,
    OLECMDIDF_PAGEACTION_POPUPALLOWED = 65536,
    OLECMDIDF_PAGEACTION_SCRIPTPROMPT = 131072,
    OLECMDIDF_PAGEACTION_ACTIVEXUSERAPPROVAL = 262144,
    OLECMDIDF_PAGEACTION_MIXEDCONTENT = 524288,
    OLECMDIDF_PAGEACTION_INVALID_CERT = 1048576,
    OLECMDIDF_PAGEACTION_INTRANETZONEREQUEST = 2097152,
    OLECMDIDF_PAGEACTION_XSSFILTERED = 4194304,
    OLECMDIDF_PAGEACTION_SPOOFABLEIDNHOST = 8388608,
    OLECMDIDF_PAGEACTION_ACTIVEX_EPM_INCOMPATIBLE = 16777216,
    OLECMDIDF_PAGEACTION_SCRIPTNAVIGATE_ACTIVEXUSERAPPROVAL = 33554432,
    OLECMDIDF_PAGEACTION_WPCBLOCKED = 67108864,
    OLECMDIDF_PAGEACTION_WPCBLOCKED_ACTIVEX = 134217728,
    OLECMDIDF_PAGEACTION_EXTENSION_COMPAT_BLOCKED = 268435456,
    OLECMDIDF_PAGEACTION_NORESETACTIVEX = 536870912,
    OLECMDIDF_PAGEACTION_GENERIC_STATE = 1073741824,
    OLECMDIDF_PAGEACTION_RESET = -2147483648,
}

enum OLECMDID_BROWSERSTATEFLAG
{
    OLECMDIDF_BROWSERSTATE_EXTENSIONSOFF = 1,
    OLECMDIDF_BROWSERSTATE_IESECURITY = 2,
    OLECMDIDF_BROWSERSTATE_PROTECTEDMODE_OFF = 4,
    OLECMDIDF_BROWSERSTATE_RESET = 8,
    OLECMDIDF_BROWSERSTATE_REQUIRESACTIVEX = 16,
    OLECMDIDF_BROWSERSTATE_DESKTOPHTMLDIALOG = 32,
    OLECMDIDF_BROWSERSTATE_BLOCKEDVERSION = 64,
}

enum OLECMDID_OPTICAL_ZOOMFLAG
{
    OLECMDIDF_OPTICAL_ZOOM_NOPERSIST = 1,
    OLECMDIDF_OPTICAL_ZOOM_NOLAYOUT = 16,
    OLECMDIDF_OPTICAL_ZOOM_NOTRANSIENT = 32,
    OLECMDIDF_OPTICAL_ZOOM_RELOADFORNEWTAB = 64,
}

enum PAGEACTION_UI
{
    PAGEACTION_UI_DEFAULT = 0,
    PAGEACTION_UI_MODAL = 1,
    PAGEACTION_UI_MODELESS = 2,
    PAGEACTION_UI_SILENT = 3,
}

enum OLECMDID_WINDOWSTATE_FLAG
{
    OLECMDIDF_WINDOWSTATE_USERVISIBLE = 1,
    OLECMDIDF_WINDOWSTATE_ENABLED = 2,
    OLECMDIDF_WINDOWSTATE_USERVISIBLE_VALID = 65536,
    OLECMDIDF_WINDOWSTATE_ENABLED_VALID = 131072,
}

enum OLECMDID_VIEWPORT_MODE_FLAG
{
    OLECMDIDF_VIEWPORTMODE_FIXED_LAYOUT_WIDTH = 1,
    OLECMDIDF_VIEWPORTMODE_EXCLUDE_VISUAL_BOTTOM = 2,
    OLECMDIDF_VIEWPORTMODE_FIXED_LAYOUT_WIDTH_VALID = 65536,
    OLECMDIDF_VIEWPORTMODE_EXCLUDE_VISUAL_BOTTOM_VALID = 131072,
}

const GUID IID_IZoomEvents = {0x41B68150, 0x904C, 0x4E17, [0xA0, 0xBA, 0xA4, 0x38, 0x18, 0x2E, 0x35, 0x9D]};
@GUID(0x41B68150, 0x904C, 0x4E17, [0xA0, 0xBA, 0xA4, 0x38, 0x18, 0x2E, 0x35, 0x9D]);
interface IZoomEvents : IUnknown
{
    HRESULT OnZoomPercentChanged(uint ulZoomPercent);
}

const GUID IID_IProtectFocus = {0xD81F90A3, 0x8156, 0x44F7, [0xAD, 0x28, 0x5A, 0xBB, 0x87, 0x00, 0x32, 0x74]};
@GUID(0xD81F90A3, 0x8156, 0x44F7, [0xAD, 0x28, 0x5A, 0xBB, 0x87, 0x00, 0x32, 0x74]);
interface IProtectFocus : IUnknown
{
    HRESULT AllowFocusChange(int* pfAllow);
}

const GUID IID_IProtectedModeMenuServices = {0x73C105EE, 0x9DFF, 0x4A07, [0xB8, 0x3C, 0x7E, 0xFF, 0x29, 0x0C, 0x26, 0x6E]};
@GUID(0x73C105EE, 0x9DFF, 0x4A07, [0xB8, 0x3C, 0x7E, 0xFF, 0x29, 0x0C, 0x26, 0x6E]);
interface IProtectedModeMenuServices : IUnknown
{
    HRESULT CreateMenu(HMENU* phMenu);
    HRESULT LoadMenuA(const(wchar)* pszModuleName, const(wchar)* pszMenuName, HMENU* phMenu);
    HRESULT LoadMenuID(const(wchar)* pszModuleName, ushort wResourceID, HMENU* phMenu);
}

alias LPFNOLEUIHOOK = extern(Windows) uint function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
struct OLEUIINSERTOBJECTW
{
    uint cbStruct;
    uint dwFlags;
    HWND hWndOwner;
    const(wchar)* lpszCaption;
    LPFNOLEUIHOOK lpfnHook;
    LPARAM lCustData;
    HINSTANCE hInstance;
    const(wchar)* lpszTemplate;
    int hResource;
    Guid clsid;
    const(wchar)* lpszFile;
    uint cchFile;
    uint cClsidExclude;
    Guid* lpClsidExclude;
    Guid iid;
    uint oleRender;
    FORMATETC* lpFormatEtc;
    IOleClientSite lpIOleClientSite;
    IStorage lpIStorage;
    void** ppvObj;
    int sc;
    int hMetaPict;
}

struct OLEUIINSERTOBJECTA
{
    uint cbStruct;
    uint dwFlags;
    HWND hWndOwner;
    const(char)* lpszCaption;
    LPFNOLEUIHOOK lpfnHook;
    LPARAM lCustData;
    HINSTANCE hInstance;
    const(char)* lpszTemplate;
    int hResource;
    Guid clsid;
    const(char)* lpszFile;
    uint cchFile;
    uint cClsidExclude;
    Guid* lpClsidExclude;
    Guid iid;
    uint oleRender;
    FORMATETC* lpFormatEtc;
    IOleClientSite lpIOleClientSite;
    IStorage lpIStorage;
    void** ppvObj;
    int sc;
    int hMetaPict;
}

enum OLEUIPASTEFLAG
{
    OLEUIPASTE_ENABLEICON = 2048,
    OLEUIPASTE_PASTEONLY = 0,
    OLEUIPASTE_PASTE = 512,
    OLEUIPASTE_LINKANYTYPE = 1024,
    OLEUIPASTE_LINKTYPE1 = 1,
    OLEUIPASTE_LINKTYPE2 = 2,
    OLEUIPASTE_LINKTYPE3 = 4,
    OLEUIPASTE_LINKTYPE4 = 8,
    OLEUIPASTE_LINKTYPE5 = 16,
    OLEUIPASTE_LINKTYPE6 = 32,
    OLEUIPASTE_LINKTYPE7 = 64,
    OLEUIPASTE_LINKTYPE8 = 128,
}

struct OLEUIPASTEENTRYW
{
    FORMATETC fmtetc;
    const(wchar)* lpstrFormatName;
    const(wchar)* lpstrResultText;
    uint dwFlags;
    uint dwScratchSpace;
}

struct OLEUIPASTEENTRYA
{
    FORMATETC fmtetc;
    const(char)* lpstrFormatName;
    const(char)* lpstrResultText;
    uint dwFlags;
    uint dwScratchSpace;
}

struct OLEUIPASTESPECIALW
{
    uint cbStruct;
    uint dwFlags;
    HWND hWndOwner;
    const(wchar)* lpszCaption;
    LPFNOLEUIHOOK lpfnHook;
    LPARAM lCustData;
    HINSTANCE hInstance;
    const(wchar)* lpszTemplate;
    int hResource;
    IDataObject lpSrcDataObj;
    OLEUIPASTEENTRYW* arrPasteEntries;
    int cPasteEntries;
    uint* arrLinkTypes;
    int cLinkTypes;
    uint cClsidExclude;
    Guid* lpClsidExclude;
    int nSelectedIndex;
    BOOL fLink;
    int hMetaPict;
    SIZE sizel;
}

struct OLEUIPASTESPECIALA
{
    uint cbStruct;
    uint dwFlags;
    HWND hWndOwner;
    const(char)* lpszCaption;
    LPFNOLEUIHOOK lpfnHook;
    LPARAM lCustData;
    HINSTANCE hInstance;
    const(char)* lpszTemplate;
    int hResource;
    IDataObject lpSrcDataObj;
    OLEUIPASTEENTRYA* arrPasteEntries;
    int cPasteEntries;
    uint* arrLinkTypes;
    int cLinkTypes;
    uint cClsidExclude;
    Guid* lpClsidExclude;
    int nSelectedIndex;
    BOOL fLink;
    int hMetaPict;
    SIZE sizel;
}

interface IOleUILinkContainerW : IUnknown
{
    uint GetNextLink(uint dwLink);
    HRESULT SetLinkUpdateOptions(uint dwLink, uint dwUpdateOpt);
    HRESULT GetLinkUpdateOptions(uint dwLink, uint* lpdwUpdateOpt);
    HRESULT SetLinkSource(uint dwLink, const(wchar)* lpszDisplayName, uint lenFileName, uint* pchEaten, BOOL fValidateSource);
    HRESULT GetLinkSource(uint dwLink, ushort** lplpszDisplayName, uint* lplenFileName, ushort** lplpszFullLinkType, ushort** lplpszShortLinkType, int* lpfSourceAvailable, int* lpfIsSelected);
    HRESULT OpenLinkSource(uint dwLink);
    HRESULT UpdateLink(uint dwLink, BOOL fErrorMessage, BOOL fReserved);
    HRESULT CancelLink(uint dwLink);
}

interface IOleUILinkContainerA : IUnknown
{
    uint GetNextLink(uint dwLink);
    HRESULT SetLinkUpdateOptions(uint dwLink, uint dwUpdateOpt);
    HRESULT GetLinkUpdateOptions(uint dwLink, uint* lpdwUpdateOpt);
    HRESULT SetLinkSource(uint dwLink, const(char)* lpszDisplayName, uint lenFileName, uint* pchEaten, BOOL fValidateSource);
    HRESULT GetLinkSource(uint dwLink, byte** lplpszDisplayName, uint* lplenFileName, byte** lplpszFullLinkType, byte** lplpszShortLinkType, int* lpfSourceAvailable, int* lpfIsSelected);
    HRESULT OpenLinkSource(uint dwLink);
    HRESULT UpdateLink(uint dwLink, BOOL fErrorMessage, BOOL fReserved);
    HRESULT CancelLink(uint dwLink);
}

struct OLEUIEDITLINKSW
{
    uint cbStruct;
    uint dwFlags;
    HWND hWndOwner;
    const(wchar)* lpszCaption;
    LPFNOLEUIHOOK lpfnHook;
    LPARAM lCustData;
    HINSTANCE hInstance;
    const(wchar)* lpszTemplate;
    int hResource;
    IOleUILinkContainerW lpOleUILinkContainer;
}

struct OLEUIEDITLINKSA
{
    uint cbStruct;
    uint dwFlags;
    HWND hWndOwner;
    const(char)* lpszCaption;
    LPFNOLEUIHOOK lpfnHook;
    LPARAM lCustData;
    HINSTANCE hInstance;
    const(char)* lpszTemplate;
    int hResource;
    IOleUILinkContainerA lpOleUILinkContainer;
}

struct OLEUICHANGEICONW
{
    uint cbStruct;
    uint dwFlags;
    HWND hWndOwner;
    const(wchar)* lpszCaption;
    LPFNOLEUIHOOK lpfnHook;
    LPARAM lCustData;
    HINSTANCE hInstance;
    const(wchar)* lpszTemplate;
    int hResource;
    int hMetaPict;
    Guid clsid;
    ushort szIconExe;
    int cchIconExe;
}

struct OLEUICHANGEICONA
{
    uint cbStruct;
    uint dwFlags;
    HWND hWndOwner;
    const(char)* lpszCaption;
    LPFNOLEUIHOOK lpfnHook;
    LPARAM lCustData;
    HINSTANCE hInstance;
    const(char)* lpszTemplate;
    int hResource;
    int hMetaPict;
    Guid clsid;
    byte szIconExe;
    int cchIconExe;
}

struct OLEUICONVERTW
{
    uint cbStruct;
    uint dwFlags;
    HWND hWndOwner;
    const(wchar)* lpszCaption;
    LPFNOLEUIHOOK lpfnHook;
    LPARAM lCustData;
    HINSTANCE hInstance;
    const(wchar)* lpszTemplate;
    int hResource;
    Guid clsid;
    Guid clsidConvertDefault;
    Guid clsidActivateDefault;
    Guid clsidNew;
    uint dvAspect;
    ushort wFormat;
    BOOL fIsLinkedObject;
    int hMetaPict;
    const(wchar)* lpszUserType;
    BOOL fObjectsIconChanged;
    const(wchar)* lpszDefLabel;
    uint cClsidExclude;
    Guid* lpClsidExclude;
}

struct OLEUICONVERTA
{
    uint cbStruct;
    uint dwFlags;
    HWND hWndOwner;
    const(char)* lpszCaption;
    LPFNOLEUIHOOK lpfnHook;
    LPARAM lCustData;
    HINSTANCE hInstance;
    const(char)* lpszTemplate;
    int hResource;
    Guid clsid;
    Guid clsidConvertDefault;
    Guid clsidActivateDefault;
    Guid clsidNew;
    uint dvAspect;
    ushort wFormat;
    BOOL fIsLinkedObject;
    int hMetaPict;
    const(char)* lpszUserType;
    BOOL fObjectsIconChanged;
    const(char)* lpszDefLabel;
    uint cClsidExclude;
    Guid* lpClsidExclude;
}

struct OLEUIBUSYW
{
    uint cbStruct;
    uint dwFlags;
    HWND hWndOwner;
    const(wchar)* lpszCaption;
    LPFNOLEUIHOOK lpfnHook;
    LPARAM lCustData;
    HINSTANCE hInstance;
    const(wchar)* lpszTemplate;
    int hResource;
    int hTask;
    HWND* lphWndDialog;
}

struct OLEUIBUSYA
{
    uint cbStruct;
    uint dwFlags;
    HWND hWndOwner;
    const(char)* lpszCaption;
    LPFNOLEUIHOOK lpfnHook;
    LPARAM lCustData;
    HINSTANCE hInstance;
    const(char)* lpszTemplate;
    int hResource;
    int hTask;
    HWND* lphWndDialog;
}

struct OLEUICHANGESOURCEW
{
    uint cbStruct;
    uint dwFlags;
    HWND hWndOwner;
    const(wchar)* lpszCaption;
    LPFNOLEUIHOOK lpfnHook;
    LPARAM lCustData;
    HINSTANCE hInstance;
    const(wchar)* lpszTemplate;
    int hResource;
    OPENFILENAMEW* lpOFN;
    uint dwReserved1;
    IOleUILinkContainerW lpOleUILinkContainer;
    uint dwLink;
    const(wchar)* lpszDisplayName;
    uint nFileLength;
    const(wchar)* lpszFrom;
    const(wchar)* lpszTo;
}

struct OLEUICHANGESOURCEA
{
    uint cbStruct;
    uint dwFlags;
    HWND hWndOwner;
    const(char)* lpszCaption;
    LPFNOLEUIHOOK lpfnHook;
    LPARAM lCustData;
    HINSTANCE hInstance;
    const(char)* lpszTemplate;
    int hResource;
    OPENFILENAMEA* lpOFN;
    uint dwReserved1;
    IOleUILinkContainerA lpOleUILinkContainer;
    uint dwLink;
    const(char)* lpszDisplayName;
    uint nFileLength;
    const(char)* lpszFrom;
    const(char)* lpszTo;
}

interface IOleUIObjInfoW : IUnknown
{
    HRESULT GetObjectInfo(uint dwObject, uint* lpdwObjSize, ushort** lplpszLabel, ushort** lplpszType, ushort** lplpszShortType, ushort** lplpszLocation);
    HRESULT GetConvertInfo(uint dwObject, Guid* lpClassID, ushort* lpwFormat, Guid* lpConvertDefaultClassID, Guid** lplpClsidExclude, uint* lpcClsidExclude);
    HRESULT ConvertObject(uint dwObject, const(Guid)* clsidNew);
    HRESULT GetViewInfo(uint dwObject, int* phMetaPict, uint* pdvAspect, int* pnCurrentScale);
    HRESULT SetViewInfo(uint dwObject, int hMetaPict, uint dvAspect, int nCurrentScale, BOOL bRelativeToOrig);
}

interface IOleUIObjInfoA : IUnknown
{
    HRESULT GetObjectInfo(uint dwObject, uint* lpdwObjSize, byte** lplpszLabel, byte** lplpszType, byte** lplpszShortType, byte** lplpszLocation);
    HRESULT GetConvertInfo(uint dwObject, Guid* lpClassID, ushort* lpwFormat, Guid* lpConvertDefaultClassID, Guid** lplpClsidExclude, uint* lpcClsidExclude);
    HRESULT ConvertObject(uint dwObject, const(Guid)* clsidNew);
    HRESULT GetViewInfo(uint dwObject, int* phMetaPict, uint* pdvAspect, int* pnCurrentScale);
    HRESULT SetViewInfo(uint dwObject, int hMetaPict, uint dvAspect, int nCurrentScale, BOOL bRelativeToOrig);
}

interface IOleUILinkInfoW : IOleUILinkContainerW
{
    HRESULT GetLastUpdate(uint dwLink, FILETIME* lpLastUpdate);
}

interface IOleUILinkInfoA : IOleUILinkContainerA
{
    HRESULT GetLastUpdate(uint dwLink, FILETIME* lpLastUpdate);
}

struct OLEUIGNRLPROPSW
{
    uint cbStruct;
    uint dwFlags;
    uint dwReserved1;
    LPFNOLEUIHOOK lpfnHook;
    LPARAM lCustData;
    uint dwReserved2;
    OLEUIOBJECTPROPSW* lpOP;
}

struct OLEUIGNRLPROPSA
{
    uint cbStruct;
    uint dwFlags;
    uint dwReserved1;
    LPFNOLEUIHOOK lpfnHook;
    LPARAM lCustData;
    uint dwReserved2;
    OLEUIOBJECTPROPSA* lpOP;
}

struct OLEUIVIEWPROPSW
{
    uint cbStruct;
    uint dwFlags;
    uint dwReserved1;
    LPFNOLEUIHOOK lpfnHook;
    LPARAM lCustData;
    uint dwReserved2;
    OLEUIOBJECTPROPSW* lpOP;
    int nScaleMin;
    int nScaleMax;
}

struct OLEUIVIEWPROPSA
{
    uint cbStruct;
    uint dwFlags;
    uint dwReserved1;
    LPFNOLEUIHOOK lpfnHook;
    LPARAM lCustData;
    uint dwReserved2;
    OLEUIOBJECTPROPSA* lpOP;
    int nScaleMin;
    int nScaleMax;
}

struct OLEUILINKPROPSW
{
    uint cbStruct;
    uint dwFlags;
    uint dwReserved1;
    LPFNOLEUIHOOK lpfnHook;
    LPARAM lCustData;
    uint dwReserved2;
    OLEUIOBJECTPROPSW* lpOP;
}

struct OLEUILINKPROPSA
{
    uint cbStruct;
    uint dwFlags;
    uint dwReserved1;
    LPFNOLEUIHOOK lpfnHook;
    LPARAM lCustData;
    uint dwReserved2;
    OLEUIOBJECTPROPSA* lpOP;
}

struct OLEUIOBJECTPROPSW
{
    uint cbStruct;
    uint dwFlags;
    PROPSHEETHEADERW_V2* lpPS;
    uint dwObject;
    IOleUIObjInfoW lpObjInfo;
    uint dwLink;
    IOleUILinkInfoW lpLinkInfo;
    OLEUIGNRLPROPSW* lpGP;
    OLEUIVIEWPROPSW* lpVP;
    OLEUILINKPROPSW* lpLP;
}

struct OLEUIOBJECTPROPSA
{
    uint cbStruct;
    uint dwFlags;
    PROPSHEETHEADERA_V2* lpPS;
    uint dwObject;
    IOleUIObjInfoA lpObjInfo;
    uint dwLink;
    IOleUILinkInfoA lpLinkInfo;
    OLEUIGNRLPROPSA* lpGP;
    OLEUIVIEWPROPSA* lpVP;
    OLEUILINKPROPSA* lpLP;
}

struct CALLFRAMEINFO
{
    uint iMethod;
    BOOL fHasInValues;
    BOOL fHasInOutValues;
    BOOL fHasOutValues;
    BOOL fDerivesFromIDispatch;
    int cInInterfacesMax;
    int cInOutInterfacesMax;
    int cOutInterfacesMax;
    int cTopLevelInInterfaces;
    Guid iid;
    uint cMethod;
    uint cParams;
}

struct CALLFRAMEPARAMINFO
{
    ubyte fIn;
    ubyte fOut;
    uint stackOffset;
    uint cbParam;
}

enum CALLFRAME_COPY
{
    CALLFRAME_COPY_NESTED = 1,
    CALLFRAME_COPY_INDEPENDENT = 2,
}

enum CALLFRAME_FREE
{
    CALLFRAME_FREE_NONE = 0,
    CALLFRAME_FREE_IN = 1,
    CALLFRAME_FREE_INOUT = 2,
    CALLFRAME_FREE_OUT = 4,
    CALLFRAME_FREE_TOP_INOUT = 8,
    CALLFRAME_FREE_TOP_OUT = 16,
    CALLFRAME_FREE_ALL = 31,
}

enum CALLFRAME_NULL
{
    CALLFRAME_NULL_NONE = 0,
    CALLFRAME_NULL_INOUT = 2,
    CALLFRAME_NULL_OUT = 4,
    CALLFRAME_NULL_ALL = 6,
}

enum CALLFRAME_WALK
{
    CALLFRAME_WALK_IN = 1,
    CALLFRAME_WALK_INOUT = 2,
    CALLFRAME_WALK_OUT = 4,
}

struct CALLFRAME_MARSHALCONTEXT
{
    ubyte fIn;
    uint dwDestContext;
    void* pvDestContext;
    IUnknown punkReserved;
    Guid guidTransferSyntax;
}

const GUID IID_ICallFrame = {0xD573B4B0, 0x894E, 0x11D2, [0xB8, 0xB6, 0x00, 0xC0, 0x4F, 0xB9, 0x61, 0x8A]};
@GUID(0xD573B4B0, 0x894E, 0x11D2, [0xB8, 0xB6, 0x00, 0xC0, 0x4F, 0xB9, 0x61, 0x8A]);
interface ICallFrame : IUnknown
{
    HRESULT GetInfo(CALLFRAMEINFO* pInfo);
    HRESULT GetIIDAndMethod(Guid* pIID, uint* piMethod);
    HRESULT GetNames(ushort** pwszInterface, ushort** pwszMethod);
    void* GetStackLocation();
    void SetStackLocation(void* pvStack);
    void SetReturnValue(HRESULT hr);
    HRESULT GetReturnValue();
    HRESULT GetParamInfo(uint iparam, CALLFRAMEPARAMINFO* pInfo);
    HRESULT SetParam(uint iparam, VARIANT* pvar);
    HRESULT GetParam(uint iparam, VARIANT* pvar);
    HRESULT Copy(CALLFRAME_COPY copyControl, ICallFrameWalker pWalker, ICallFrame* ppFrame);
    HRESULT Free(ICallFrame pframeArgsDest, ICallFrameWalker pWalkerDestFree, ICallFrameWalker pWalkerCopy, uint freeFlags, ICallFrameWalker pWalkerFree, uint nullFlags);
    HRESULT FreeParam(uint iparam, uint freeFlags, ICallFrameWalker pWalkerFree, uint nullFlags);
    HRESULT WalkFrame(uint walkWhat, ICallFrameWalker pWalker);
    HRESULT GetMarshalSizeMax(CALLFRAME_MARSHALCONTEXT* pmshlContext, MSHLFLAGS mshlflags, uint* pcbBufferNeeded);
    HRESULT Marshal(CALLFRAME_MARSHALCONTEXT* pmshlContext, MSHLFLAGS mshlflags, void* pBuffer, uint cbBuffer, uint* pcbBufferUsed, uint* pdataRep, uint* prpcFlags);
    HRESULT Unmarshal(void* pBuffer, uint cbBuffer, uint dataRep, CALLFRAME_MARSHALCONTEXT* pcontext, uint* pcbUnmarshalled);
    HRESULT ReleaseMarshalData(void* pBuffer, uint cbBuffer, uint ibFirstRelease, uint dataRep, CALLFRAME_MARSHALCONTEXT* pcontext);
    HRESULT Invoke(void* pvReceiver);
}

const GUID IID_ICallIndirect = {0xD573B4B1, 0x894E, 0x11D2, [0xB8, 0xB6, 0x00, 0xC0, 0x4F, 0xB9, 0x61, 0x8A]};
@GUID(0xD573B4B1, 0x894E, 0x11D2, [0xB8, 0xB6, 0x00, 0xC0, 0x4F, 0xB9, 0x61, 0x8A]);
interface ICallIndirect : IUnknown
{
    HRESULT CallIndirect(int* phrReturn, uint iMethod, void* pvArgs, uint* cbArgs);
    HRESULT GetMethodInfo(uint iMethod, CALLFRAMEINFO* pInfo, ushort** pwszMethod);
    HRESULT GetStackSize(uint iMethod, uint* cbArgs);
    HRESULT GetIID(Guid* piid, int* pfDerivesFromIDispatch, uint* pcMethod, ushort** pwszInterface);
}

const GUID IID_ICallInterceptor = {0x60C7CA75, 0x896D, 0x11D2, [0xB8, 0xB6, 0x00, 0xC0, 0x4F, 0xB9, 0x61, 0x8A]};
@GUID(0x60C7CA75, 0x896D, 0x11D2, [0xB8, 0xB6, 0x00, 0xC0, 0x4F, 0xB9, 0x61, 0x8A]);
interface ICallInterceptor : ICallIndirect
{
    HRESULT RegisterSink(ICallFrameEvents psink);
    HRESULT GetRegisteredSink(ICallFrameEvents* ppsink);
}

const GUID IID_ICallFrameEvents = {0xFD5E0843, 0xFC91, 0x11D0, [0x97, 0xD7, 0x00, 0xC0, 0x4F, 0xB9, 0x61, 0x8A]};
@GUID(0xFD5E0843, 0xFC91, 0x11D0, [0x97, 0xD7, 0x00, 0xC0, 0x4F, 0xB9, 0x61, 0x8A]);
interface ICallFrameEvents : IUnknown
{
    HRESULT OnCall(ICallFrame pFrame);
}

const GUID IID_ICallUnmarshal = {0x5333B003, 0x2E42, 0x11D2, [0xB8, 0x9D, 0x00, 0xC0, 0x4F, 0xB9, 0x61, 0x8A]};
@GUID(0x5333B003, 0x2E42, 0x11D2, [0xB8, 0x9D, 0x00, 0xC0, 0x4F, 0xB9, 0x61, 0x8A]);
interface ICallUnmarshal : IUnknown
{
    HRESULT Unmarshal(uint iMethod, void* pBuffer, uint cbBuffer, BOOL fForceBufferCopy, uint dataRep, CALLFRAME_MARSHALCONTEXT* pcontext, uint* pcbUnmarshalled, ICallFrame* ppFrame);
    HRESULT ReleaseMarshalData(uint iMethod, void* pBuffer, uint cbBuffer, uint ibFirstRelease, uint dataRep, CALLFRAME_MARSHALCONTEXT* pcontext);
}

const GUID IID_ICallFrameWalker = {0x08B23919, 0x392D, 0x11D2, [0xB8, 0xA4, 0x00, 0xC0, 0x4F, 0xB9, 0x61, 0x8A]};
@GUID(0x08B23919, 0x392D, 0x11D2, [0xB8, 0xA4, 0x00, 0xC0, 0x4F, 0xB9, 0x61, 0x8A]);
interface ICallFrameWalker : IUnknown
{
    HRESULT OnWalkInterface(const(Guid)* iid, void** ppvInterface, BOOL fIn, BOOL fOut);
}

const GUID IID_IInterfaceRelated = {0xD1FB5A79, 0x7706, 0x11D1, [0xAD, 0xBA, 0x00, 0xC0, 0x4F, 0xC2, 0xAD, 0xC0]};
@GUID(0xD1FB5A79, 0x7706, 0x11D1, [0xAD, 0xBA, 0x00, 0xC0, 0x4F, 0xC2, 0xAD, 0xC0]);
interface IInterfaceRelated : IUnknown
{
    HRESULT SetIID(const(Guid)* iid);
    HRESULT GetIID(Guid* piid);
}

enum RECORD_READING_POLICY
{
    RECORD_READING_POLICY_FORWARD = 1,
    RECORD_READING_POLICY_BACKWARD = 2,
    RECORD_READING_POLICY_RANDOM = 3,
}

const GUID IID_ILog = {0xFF222117, 0x0C6C, 0x11D2, [0xB8, 0x9A, 0x00, 0xC0, 0x4F, 0xB9, 0x61, 0x8A]};
@GUID(0xFF222117, 0x0C6C, 0x11D2, [0xB8, 0x9A, 0x00, 0xC0, 0x4F, 0xB9, 0x61, 0x8A]);
interface ILog : IUnknown
{
    HRESULT Force(LARGE_INTEGER lsnMinToForce);
    HRESULT AppendRecord(char* rgBlob, uint cBlob, BOOL fForceNow, LARGE_INTEGER* plsn);
    HRESULT ReadRecord(LARGE_INTEGER lsnToRead, LARGE_INTEGER* plsnPrev, LARGE_INTEGER* plsnNext, char* ppbData, uint* pcbData);
    HRESULT ReadRecordPrefix(LARGE_INTEGER lsnToRead, LARGE_INTEGER* plsnPrev, LARGE_INTEGER* plsnNext, char* pbData, uint* pcbData, uint* pcbRecord);
    HRESULT GetLogLimits(LARGE_INTEGER* plsnFirst, LARGE_INTEGER* plsnLast);
    HRESULT TruncatePrefix(LARGE_INTEGER lsnFirstToKeep);
    HRESULT SetAccessPolicyHint(RECORD_READING_POLICY policy);
}

const GUID IID_IFileBasedLogInit = {0x00951E8C, 0x1294, 0x11D1, [0x97, 0xE4, 0x00, 0xC0, 0x4F, 0xB9, 0x61, 0x8A]};
@GUID(0x00951E8C, 0x1294, 0x11D1, [0x97, 0xE4, 0x00, 0xC0, 0x4F, 0xB9, 0x61, 0x8A]);
interface IFileBasedLogInit : IUnknown
{
    HRESULT InitNew(const(wchar)* filename, uint cbCapacityHint);
}

const GUID IID_IEnumGUID = {0x0002E000, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0002E000, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IEnumGUID : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumGUID* ppenum);
}

struct CATEGORYINFO
{
    Guid catid;
    uint lcid;
    ushort szDescription;
}

const GUID IID_IEnumCATEGORYINFO = {0x0002E011, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0002E011, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IEnumCATEGORYINFO : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumCATEGORYINFO* ppenum);
}

const GUID IID_ICatRegister = {0x0002E012, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0002E012, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ICatRegister : IUnknown
{
    HRESULT RegisterCategories(uint cCategories, char* rgCategoryInfo);
    HRESULT UnRegisterCategories(uint cCategories, char* rgcatid);
    HRESULT RegisterClassImplCategories(const(Guid)* rclsid, uint cCategories, char* rgcatid);
    HRESULT UnRegisterClassImplCategories(const(Guid)* rclsid, uint cCategories, char* rgcatid);
    HRESULT RegisterClassReqCategories(const(Guid)* rclsid, uint cCategories, char* rgcatid);
    HRESULT UnRegisterClassReqCategories(const(Guid)* rclsid, uint cCategories, char* rgcatid);
}

const GUID IID_ICatInformation = {0x0002E013, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x0002E013, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ICatInformation : IUnknown
{
    HRESULT EnumCategories(uint lcid, IEnumCATEGORYINFO* ppenumCategoryInfo);
    HRESULT GetCategoryDesc(Guid* rcatid, uint lcid, ushort** pszDesc);
    HRESULT EnumClassesOfCategories(uint cImplemented, const(Guid)* rgcatidImpl, uint cRequired, const(Guid)* rgcatidReq, IEnumGUID* ppenumClsid);
    HRESULT IsClassOfCategories(const(Guid)* rclsid, uint cImplemented, const(Guid)* rgcatidImpl, uint cRequired, const(Guid)* rgcatidReq);
    HRESULT EnumImplCategoriesOfClass(const(Guid)* rclsid, IEnumGUID* ppenumCatid);
    HRESULT EnumReqCategoriesOfClass(const(Guid)* rclsid, IEnumGUID* ppenumCatid);
}

const GUID IID_IAccessControl = {0xEEDD23E0, 0x8410, 0x11CE, [0xA1, 0xC3, 0x08, 0x00, 0x2B, 0x2B, 0x8D, 0x8F]};
@GUID(0xEEDD23E0, 0x8410, 0x11CE, [0xA1, 0xC3, 0x08, 0x00, 0x2B, 0x2B, 0x8D, 0x8F]);
interface IAccessControl : IUnknown
{
    HRESULT GrantAccessRights(ACTRL_ACCESSW* pAccessList);
    HRESULT SetAccessRights(ACTRL_ACCESSW* pAccessList);
    HRESULT SetOwner(TRUSTEE_W* pOwner, TRUSTEE_W* pGroup);
    HRESULT RevokeAccessRights(const(wchar)* lpProperty, uint cTrustees, char* prgTrustees);
    HRESULT GetAllAccessRights(const(wchar)* lpProperty, ACTRL_ACCESSW** ppAccessList, TRUSTEE_W** ppOwner, TRUSTEE_W** ppGroup);
    HRESULT IsAccessAllowed(TRUSTEE_W* pTrustee, const(wchar)* lpProperty, uint AccessRights, int* pfAccessAllowed);
}

const GUID IID_IAuditControl = {0x1DA6292F, 0xBC66, 0x11CE, [0xAA, 0xE3, 0x00, 0xAA, 0x00, 0x4C, 0x27, 0x37]};
@GUID(0x1DA6292F, 0xBC66, 0x11CE, [0xAA, 0xE3, 0x00, 0xAA, 0x00, 0x4C, 0x27, 0x37]);
interface IAuditControl : IUnknown
{
    HRESULT GrantAuditRights(ACTRL_ACCESSW* pAuditList);
    HRESULT SetAuditRights(ACTRL_ACCESSW* pAuditList);
    HRESULT RevokeAuditRights(const(wchar)* lpProperty, uint cTrustees, char* prgTrustees);
    HRESULT GetAllAuditRights(const(wchar)* lpProperty, ACTRL_ACCESSW** ppAuditList);
    HRESULT IsAccessAudited(TRUSTEE_W* pTrustee, uint AuditRights, int* pfAccessAudited);
}

struct ComCallData
{
    uint dwDispid;
    uint dwReserved;
    void* pUserDefined;
}

alias PFNCONTEXTCALL = extern(Windows) HRESULT function(ComCallData* pParam);
const GUID IID_IContextCallback = {0x000001DA, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000001DA, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IContextCallback : IUnknown
{
    HRESULT ContextCallback(PFNCONTEXTCALL pfnCallback, ComCallData* pParam, const(Guid)* riid, int iMethod, IUnknown pUnk);
}

const GUID IID_IMessageDispatcher = {0xF5F84C8F, 0xCFD0, 0x4CD6, [0xB6, 0x6B, 0xC5, 0xD2, 0x6F, 0xF1, 0x68, 0x9D]};
@GUID(0xF5F84C8F, 0xCFD0, 0x4CD6, [0xB6, 0x6B, 0xC5, 0xD2, 0x6F, 0xF1, 0x68, 0x9D]);
interface IMessageDispatcher : IInspectable
{
    HRESULT PumpMessages();
}

@DllImport("OLE32.dll")
HRESULT CoGetMalloc(uint dwMemContext, IMalloc* ppMalloc);

@DllImport("OLE32.dll")
void CoUninitialize();

@DllImport("OLE32.dll")
uint CoGetCurrentProcess();

@DllImport("OLE32.dll")
HRESULT CoInitializeEx(void* pvReserved, uint dwCoInit);

@DllImport("OLE32.dll")
HRESULT CoGetCallerTID(uint* lpdwTID);

@DllImport("OLE32.dll")
HRESULT CoGetCurrentLogicalThreadId(Guid* pguid);

@DllImport("OLE32.dll")
HRESULT CoGetContextToken(uint* pToken);

@DllImport("OLE32.dll")
HRESULT CoGetApartmentType(APTTYPE* pAptType, APTTYPEQUALIFIER* pAptQualifier);

@DllImport("OLE32.dll")
HRESULT CoIncrementMTAUsage(int* pCookie);

@DllImport("OLE32.dll")
HRESULT CoDecrementMTAUsage(int Cookie);

@DllImport("OLE32.dll")
HRESULT CoAllowUnmarshalerCLSID(const(Guid)* clsid);

@DllImport("OLE32.dll")
HRESULT CoGetObjectContext(const(Guid)* riid, void** ppv);

@DllImport("OLE32.dll")
HRESULT CoGetClassObject(const(Guid)* rclsid, uint dwClsContext, void* pvReserved, const(Guid)* riid, void** ppv);

@DllImport("OLE32.dll")
HRESULT CoRegisterClassObject(const(Guid)* rclsid, IUnknown pUnk, uint dwClsContext, uint flags, uint* lpdwRegister);

@DllImport("OLE32.dll")
HRESULT CoRevokeClassObject(uint dwRegister);

@DllImport("OLE32.dll")
HRESULT CoResumeClassObjects();

@DllImport("OLE32.dll")
HRESULT CoSuspendClassObjects();

@DllImport("OLE32.dll")
uint CoAddRefServerProcess();

@DllImport("OLE32.dll")
uint CoReleaseServerProcess();

@DllImport("OLE32.dll")
HRESULT CoGetPSClsid(const(Guid)* riid, Guid* pClsid);

@DllImport("OLE32.dll")
HRESULT CoRegisterPSClsid(const(Guid)* riid, const(Guid)* rclsid);

@DllImport("OLE32.dll")
HRESULT CoRegisterSurrogate(ISurrogate pSurrogate);

@DllImport("OLE32.dll")
HRESULT CoGetMarshalSizeMax(uint* pulSize, const(Guid)* riid, IUnknown pUnk, uint dwDestContext, void* pvDestContext, uint mshlflags);

@DllImport("OLE32.dll")
HRESULT CoMarshalInterface(IStream pStm, const(Guid)* riid, IUnknown pUnk, uint dwDestContext, void* pvDestContext, uint mshlflags);

@DllImport("OLE32.dll")
HRESULT CoUnmarshalInterface(IStream pStm, const(Guid)* riid, void** ppv);

@DllImport("OLE32.dll")
HRESULT CoMarshalHresult(IStream pstm, HRESULT hresult);

@DllImport("OLE32.dll")
HRESULT CoUnmarshalHresult(IStream pstm, int* phresult);

@DllImport("OLE32.dll")
HRESULT CoReleaseMarshalData(IStream pStm);

@DllImport("OLE32.dll")
HRESULT CoDisconnectObject(IUnknown pUnk, uint dwReserved);

@DllImport("OLE32.dll")
HRESULT CoLockObjectExternal(IUnknown pUnk, BOOL fLock, BOOL fLastUnlockReleases);

@DllImport("OLE32.dll")
HRESULT CoGetStandardMarshal(const(Guid)* riid, IUnknown pUnk, uint dwDestContext, void* pvDestContext, uint mshlflags, IMarshal* ppMarshal);

@DllImport("OLE32.dll")
HRESULT CoGetStdMarshalEx(IUnknown pUnkOuter, uint smexflags, IUnknown* ppUnkInner);

@DllImport("OLE32.dll")
BOOL CoIsHandlerConnected(IUnknown pUnk);

@DllImport("OLE32.dll")
HRESULT CoMarshalInterThreadInterfaceInStream(const(Guid)* riid, IUnknown pUnk, IStream* ppStm);

@DllImport("OLE32.dll")
HRESULT CoGetInterfaceAndReleaseStream(IStream pStm, const(Guid)* iid, void** ppv);

@DllImport("OLE32.dll")
HRESULT CoCreateFreeThreadedMarshaler(IUnknown punkOuter, IUnknown* ppunkMarshal);

@DllImport("OLE32.dll")
void CoFreeUnusedLibraries();

@DllImport("OLE32.dll")
void CoFreeUnusedLibrariesEx(uint dwUnloadDelay, uint dwReserved);

@DllImport("OLE32.dll")
HRESULT CoDisconnectContext(uint dwTimeout);

@DllImport("OLE32.dll")
HRESULT CoInitializeSecurity(void* pSecDesc, int cAuthSvc, char* asAuthSvc, void* pReserved1, uint dwAuthnLevel, uint dwImpLevel, void* pAuthList, uint dwCapabilities, void* pReserved3);

@DllImport("OLE32.dll")
HRESULT CoGetCallContext(const(Guid)* riid, void** ppInterface);

@DllImport("OLE32.dll")
HRESULT CoQueryProxyBlanket(IUnknown pProxy, uint* pwAuthnSvc, uint* pAuthzSvc, ushort** pServerPrincName, uint* pAuthnLevel, uint* pImpLevel, void** pAuthInfo, uint* pCapabilites);

@DllImport("OLE32.dll")
HRESULT CoSetProxyBlanket(IUnknown pProxy, uint dwAuthnSvc, uint dwAuthzSvc, ushort* pServerPrincName, uint dwAuthnLevel, uint dwImpLevel, void* pAuthInfo, uint dwCapabilities);

@DllImport("OLE32.dll")
HRESULT CoCopyProxy(IUnknown pProxy, IUnknown* ppCopy);

@DllImport("OLE32.dll")
HRESULT CoQueryClientBlanket(uint* pAuthnSvc, uint* pAuthzSvc, ushort** pServerPrincName, uint* pAuthnLevel, uint* pImpLevel, void** pPrivs, uint* pCapabilities);

@DllImport("OLE32.dll")
HRESULT CoImpersonateClient();

@DllImport("OLE32.dll")
HRESULT CoRevertToSelf();

@DllImport("OLE32.dll")
HRESULT CoQueryAuthenticationServices(uint* pcAuthSvc, SOLE_AUTHENTICATION_SERVICE** asAuthSvc);

@DllImport("OLE32.dll")
HRESULT CoSwitchCallContext(IUnknown pNewObject, IUnknown* ppOldObject);

@DllImport("OLE32.dll")
HRESULT CoCreateInstance(const(Guid)* rclsid, IUnknown pUnkOuter, uint dwClsContext, const(Guid)* riid, void** ppv);

@DllImport("OLE32.dll")
HRESULT CoCreateInstanceEx(const(Guid)* Clsid, IUnknown punkOuter, uint dwClsCtx, COSERVERINFO* pServerInfo, uint dwCount, char* pResults);

@DllImport("OLE32.dll")
HRESULT CoCreateInstanceFromApp(const(Guid)* Clsid, IUnknown punkOuter, uint dwClsCtx, void* reserved, uint dwCount, char* pResults);

@DllImport("OLE32.dll")
HRESULT CoRegisterActivationFilter(IActivationFilter pActivationFilter);

@DllImport("OLE32.dll")
HRESULT CoGetCancelObject(uint dwThreadId, const(Guid)* iid, void** ppUnk);

@DllImport("OLE32.dll")
HRESULT CoSetCancelObject(IUnknown pUnk);

@DllImport("OLE32.dll")
HRESULT CoCancelCall(uint dwThreadId, uint ulTimeout);

@DllImport("OLE32.dll")
HRESULT CoTestCancel();

@DllImport("OLE32.dll")
HRESULT CoEnableCallCancellation(void* pReserved);

@DllImport("OLE32.dll")
HRESULT CoDisableCallCancellation(void* pReserved);

@DllImport("OLE32.dll")
HRESULT StringFromCLSID(const(Guid)* rclsid, ushort** lplpsz);

@DllImport("OLE32.dll")
HRESULT CLSIDFromString(ushort* lpsz, Guid* pclsid);

@DllImport("OLE32.dll")
HRESULT StringFromIID(const(Guid)* rclsid, ushort** lplpsz);

@DllImport("OLE32.dll")
HRESULT IIDFromString(ushort* lpsz, Guid* lpiid);

@DllImport("OLE32.dll")
HRESULT ProgIDFromCLSID(const(Guid)* clsid, ushort** lplpszProgID);

@DllImport("OLE32.dll")
HRESULT CLSIDFromProgID(ushort* lpszProgID, Guid* lpclsid);

@DllImport("OLE32.dll")
int StringFromGUID2(const(Guid)* rguid, char* lpsz, int cchMax);

@DllImport("OLE32.dll")
HRESULT CoCreateGuid(Guid* pguid);

@DllImport("OLE32.dll")
HRESULT CoWaitForMultipleHandles(uint dwFlags, uint dwTimeout, uint cHandles, char* pHandles, uint* lpdwindex);

@DllImport("OLE32.dll")
HRESULT CoWaitForMultipleObjects(uint dwFlags, uint dwTimeout, uint cHandles, char* pHandles, uint* lpdwindex);

@DllImport("OLE32.dll")
HRESULT CoGetTreatAsClass(const(Guid)* clsidOld, Guid* pClsidNew);

@DllImport("OLE32.dll")
HRESULT CoInvalidateRemoteMachineBindings(ushort* pszMachineName);

@DllImport("OLE32.dll")
void* CoTaskMemAlloc(uint cb);

@DllImport("OLE32.dll")
void* CoTaskMemRealloc(void* pv, uint cb);

@DllImport("OLE32.dll")
void CoTaskMemFree(void* pv);

@DllImport("OLE32.dll")
HRESULT CoFileTimeNow(FILETIME* lpFileTime);

@DllImport("OLE32.dll")
HRESULT CLSIDFromProgIDEx(ushort* lpszProgID, Guid* lpclsid);

@DllImport("OLE32.dll")
HRESULT CoRegisterDeviceCatalog(const(wchar)* deviceInstanceId, int* cookie);

@DllImport("OLE32.dll")
HRESULT CoRevokeDeviceCatalog(int cookie);

@DllImport("OLE32.dll")
uint CLIPFORMAT_UserSize(uint* param0, uint param1, ushort* param2);

@DllImport("OLE32.dll")
ubyte* CLIPFORMAT_UserMarshal(uint* param0, ubyte* param1, ushort* param2);

@DllImport("OLE32.dll")
ubyte* CLIPFORMAT_UserUnmarshal(uint* param0, char* param1, ushort* param2);

@DllImport("OLE32.dll")
void CLIPFORMAT_UserFree(uint* param0, ushort* param1);

@DllImport("OLE32.dll")
uint HBITMAP_UserSize(uint* param0, uint param1, HBITMAP* param2);

@DllImport("OLE32.dll")
ubyte* HBITMAP_UserMarshal(uint* param0, ubyte* param1, HBITMAP* param2);

@DllImport("OLE32.dll")
ubyte* HBITMAP_UserUnmarshal(uint* param0, char* param1, HBITMAP* param2);

@DllImport("OLE32.dll")
void HBITMAP_UserFree(uint* param0, HBITMAP* param1);

@DllImport("OLE32.dll")
uint HDC_UserSize(uint* param0, uint param1, HDC* param2);

@DllImport("OLE32.dll")
ubyte* HDC_UserMarshal(uint* param0, ubyte* param1, HDC* param2);

@DllImport("OLE32.dll")
ubyte* HDC_UserUnmarshal(uint* param0, char* param1, HDC* param2);

@DllImport("OLE32.dll")
void HDC_UserFree(uint* param0, HDC* param1);

@DllImport("OLE32.dll")
uint HICON_UserSize(uint* param0, uint param1, HICON* param2);

@DllImport("OLE32.dll")
ubyte* HICON_UserMarshal(uint* param0, ubyte* param1, HICON* param2);

@DllImport("OLE32.dll")
ubyte* HICON_UserUnmarshal(uint* param0, char* param1, HICON* param2);

@DllImport("OLE32.dll")
void HICON_UserFree(uint* param0, HICON* param1);

@DllImport("ole32.dll")
uint SNB_UserSize(uint* param0, uint param1, ushort*** param2);

@DllImport("ole32.dll")
ubyte* SNB_UserMarshal(uint* param0, ubyte* param1, ushort*** param2);

@DllImport("ole32.dll")
ubyte* SNB_UserUnmarshal(uint* param0, char* param1, ushort*** param2);

@DllImport("ole32.dll")
void SNB_UserFree(uint* param0, ushort*** param1);

@DllImport("OLE32.dll")
uint CLIPFORMAT_UserSize64(uint* param0, uint param1, ushort* param2);

@DllImport("OLE32.dll")
ubyte* CLIPFORMAT_UserMarshal64(uint* param0, ubyte* param1, ushort* param2);

@DllImport("OLE32.dll")
ubyte* CLIPFORMAT_UserUnmarshal64(uint* param0, char* param1, ushort* param2);

@DllImport("OLE32.dll")
void CLIPFORMAT_UserFree64(uint* param0, ushort* param1);

@DllImport("OLE32.dll")
uint HBITMAP_UserSize64(uint* param0, uint param1, HBITMAP* param2);

@DllImport("OLE32.dll")
ubyte* HBITMAP_UserMarshal64(uint* param0, ubyte* param1, HBITMAP* param2);

@DllImport("OLE32.dll")
ubyte* HBITMAP_UserUnmarshal64(uint* param0, char* param1, HBITMAP* param2);

@DllImport("OLE32.dll")
void HBITMAP_UserFree64(uint* param0, HBITMAP* param1);

@DllImport("OLE32.dll")
uint HDC_UserSize64(uint* param0, uint param1, HDC* param2);

@DllImport("OLE32.dll")
ubyte* HDC_UserMarshal64(uint* param0, ubyte* param1, HDC* param2);

@DllImport("OLE32.dll")
ubyte* HDC_UserUnmarshal64(uint* param0, char* param1, HDC* param2);

@DllImport("OLE32.dll")
void HDC_UserFree64(uint* param0, HDC* param1);

@DllImport("OLE32.dll")
uint HICON_UserSize64(uint* param0, uint param1, HICON* param2);

@DllImport("OLE32.dll")
ubyte* HICON_UserMarshal64(uint* param0, ubyte* param1, HICON* param2);

@DllImport("OLE32.dll")
ubyte* HICON_UserUnmarshal64(uint* param0, char* param1, HICON* param2);

@DllImport("OLE32.dll")
void HICON_UserFree64(uint* param0, HICON* param1);

@DllImport("ole32.dll")
uint SNB_UserSize64(uint* param0, uint param1, ushort*** param2);

@DllImport("ole32.dll")
ubyte* SNB_UserMarshal64(uint* param0, ubyte* param1, ushort*** param2);

@DllImport("ole32.dll")
ubyte* SNB_UserUnmarshal64(uint* param0, char* param1, ushort*** param2);

@DllImport("ole32.dll")
void SNB_UserFree64(uint* param0, ushort*** param1);

@DllImport("OLE32.dll")
uint HACCEL_UserSize(uint* param0, uint param1, HACCEL* param2);

@DllImport("OLE32.dll")
ubyte* HACCEL_UserMarshal(uint* param0, ubyte* param1, HACCEL* param2);

@DllImport("OLE32.dll")
ubyte* HACCEL_UserUnmarshal(uint* param0, char* param1, HACCEL* param2);

@DllImport("OLE32.dll")
void HACCEL_UserFree(uint* param0, HACCEL* param1);

@DllImport("OLE32.dll")
uint HGLOBAL_UserSize(uint* param0, uint param1, int* param2);

@DllImport("OLE32.dll")
ubyte* HGLOBAL_UserMarshal(uint* param0, ubyte* param1, int* param2);

@DllImport("OLE32.dll")
ubyte* HGLOBAL_UserUnmarshal(uint* param0, char* param1, int* param2);

@DllImport("OLE32.dll")
void HGLOBAL_UserFree(uint* param0, int* param1);

@DllImport("OLE32.dll")
uint HMENU_UserSize(uint* param0, uint param1, HMENU* param2);

@DllImport("OLE32.dll")
ubyte* HMENU_UserMarshal(uint* param0, ubyte* param1, HMENU* param2);

@DllImport("OLE32.dll")
ubyte* HMENU_UserUnmarshal(uint* param0, char* param1, HMENU* param2);

@DllImport("OLE32.dll")
void HMENU_UserFree(uint* param0, HMENU* param1);

@DllImport("OLE32.dll")
uint HACCEL_UserSize64(uint* param0, uint param1, HACCEL* param2);

@DllImport("OLE32.dll")
ubyte* HACCEL_UserMarshal64(uint* param0, ubyte* param1, HACCEL* param2);

@DllImport("OLE32.dll")
ubyte* HACCEL_UserUnmarshal64(uint* param0, char* param1, HACCEL* param2);

@DllImport("OLE32.dll")
void HACCEL_UserFree64(uint* param0, HACCEL* param1);

@DllImport("OLE32.dll")
uint HGLOBAL_UserSize64(uint* param0, uint param1, int* param2);

@DllImport("OLE32.dll")
ubyte* HGLOBAL_UserMarshal64(uint* param0, ubyte* param1, int* param2);

@DllImport("OLE32.dll")
ubyte* HGLOBAL_UserUnmarshal64(uint* param0, char* param1, int* param2);

@DllImport("OLE32.dll")
void HGLOBAL_UserFree64(uint* param0, int* param1);

@DllImport("OLE32.dll")
uint HMENU_UserSize64(uint* param0, uint param1, HMENU* param2);

@DllImport("OLE32.dll")
ubyte* HMENU_UserMarshal64(uint* param0, ubyte* param1, HMENU* param2);

@DllImport("OLE32.dll")
ubyte* HMENU_UserUnmarshal64(uint* param0, char* param1, HMENU* param2);

@DllImport("OLE32.dll")
void HMENU_UserFree64(uint* param0, HMENU* param1);

@DllImport("urlmon.dll")
HRESULT CreateURLMoniker(IMoniker pMkCtx, const(wchar)* szURL, IMoniker* ppmk);

@DllImport("urlmon.dll")
HRESULT CreateURLMonikerEx(IMoniker pMkCtx, const(wchar)* szURL, IMoniker* ppmk, uint dwFlags);

@DllImport("urlmon.dll")
HRESULT GetClassURL(const(wchar)* szURL, Guid* pClsID);

@DllImport("urlmon.dll")
HRESULT CreateAsyncBindCtx(uint reserved, IBindStatusCallback pBSCb, IEnumFORMATETC pEFetc, IBindCtx* ppBC);

@DllImport("urlmon.dll")
HRESULT CreateURLMonikerEx2(IMoniker pMkCtx, IUri pUri, IMoniker* ppmk, uint dwFlags);

@DllImport("urlmon.dll")
HRESULT CreateAsyncBindCtxEx(IBindCtx pbc, uint dwOptions, IBindStatusCallback pBSCb, IEnumFORMATETC pEnum, IBindCtx* ppBC, uint reserved);

@DllImport("urlmon.dll")
HRESULT MkParseDisplayNameEx(IBindCtx pbc, const(wchar)* szDisplayName, uint* pchEaten, IMoniker* ppmk);

@DllImport("urlmon.dll")
HRESULT RegisterBindStatusCallback(IBindCtx pBC, IBindStatusCallback pBSCb, IBindStatusCallback* ppBSCBPrev, uint dwReserved);

@DllImport("urlmon.dll")
HRESULT RevokeBindStatusCallback(IBindCtx pBC, IBindStatusCallback pBSCb);

@DllImport("urlmon.dll")
HRESULT GetClassFileOrMime(IBindCtx pBC, const(wchar)* szFilename, char* pBuffer, uint cbSize, const(wchar)* szMime, uint dwReserved, Guid* pclsid);

@DllImport("urlmon.dll")
HRESULT IsValidURL(IBindCtx pBC, const(wchar)* szURL, uint dwReserved);

@DllImport("urlmon.dll")
HRESULT CoGetClassObjectFromURL(const(Guid)* rCLASSID, const(wchar)* szCODE, uint dwFileVersionMS, uint dwFileVersionLS, const(wchar)* szTYPE, IBindCtx pBindCtx, uint dwClsContext, void* pvReserved, const(Guid)* riid, void** ppv);

@DllImport("urlmon.dll")
HRESULT IEInstallScope(uint* pdwScope);

@DllImport("urlmon.dll")
HRESULT FaultInIEFeature(HWND hWnd, uCLSSPEC* pClassSpec, QUERYCONTEXT* pQuery, uint dwFlags);

@DllImport("urlmon.dll")
HRESULT GetComponentIDFromCLSSPEC(uCLSSPEC* pClassspec, byte** ppszComponentID);

@DllImport("urlmon.dll")
HRESULT IsAsyncMoniker(IMoniker pmk);

@DllImport("urlmon.dll")
HRESULT RegisterMediaTypes(uint ctypes, char* rgszTypes, char* rgcfTypes);

@DllImport("urlmon.dll")
HRESULT FindMediaType(const(char)* rgszTypes, ushort* rgcfTypes);

@DllImport("urlmon.dll")
HRESULT CreateFormatEnumerator(uint cfmtetc, char* rgfmtetc, IEnumFORMATETC* ppenumfmtetc);

@DllImport("urlmon.dll")
HRESULT RegisterFormatEnumerator(IBindCtx pBC, IEnumFORMATETC pEFetc, uint reserved);

@DllImport("urlmon.dll")
HRESULT RevokeFormatEnumerator(IBindCtx pBC, IEnumFORMATETC pEFetc);

@DllImport("urlmon.dll")
HRESULT RegisterMediaTypeClass(IBindCtx pBC, uint ctypes, char* rgszTypes, char* rgclsID, uint reserved);

@DllImport("urlmon.dll")
HRESULT FindMediaTypeClass(IBindCtx pBC, const(char)* szType, Guid* pclsID, uint reserved);

@DllImport("urlmon.dll")
HRESULT UrlMkSetSessionOption(uint dwOption, char* pBuffer, uint dwBufferLength, uint dwReserved);

@DllImport("urlmon.dll")
HRESULT UrlMkGetSessionOption(uint dwOption, char* pBuffer, uint dwBufferLength, uint* pdwBufferLengthOut, uint dwReserved);

@DllImport("urlmon.dll")
HRESULT FindMimeFromData(IBindCtx pBC, const(wchar)* pwzUrl, char* pBuffer, uint cbSize, const(wchar)* pwzMimeProposed, uint dwMimeFlags, ushort** ppwzMimeOut, uint dwReserved);

@DllImport("urlmon.dll")
HRESULT ObtainUserAgentString(uint dwOption, const(char)* pszUAOut, uint* cbSize);

@DllImport("urlmon.dll")
HRESULT CompareSecurityIds(char* pbSecurityId1, uint dwLen1, char* pbSecurityId2, uint dwLen2, uint dwReserved);

@DllImport("urlmon.dll")
HRESULT CompatFlagsFromClsid(Guid* pclsid, uint* pdwCompatFlags, uint* pdwMiscStatusFlags);

@DllImport("urlmon.dll")
HRESULT SetAccessForIEAppContainer(HANDLE hObject, IEObjectType ieObjectType, uint dwAccessMask);

@DllImport("URLMON.dll")
HRESULT CreateUri(const(wchar)* pwzURI, uint dwFlags, uint dwReserved, IUri* ppURI);

@DllImport("URLMON.dll")
HRESULT CreateUriWithFragment(const(wchar)* pwzURI, const(wchar)* pwzFragment, uint dwFlags, uint dwReserved, IUri* ppURI);

@DllImport("urlmon.dll")
HRESULT CreateUriFromMultiByteString(const(char)* pszANSIInputUri, uint dwEncodingFlags, uint dwCodePage, uint dwCreateFlags, uint dwReserved, IUri* ppUri);

@DllImport("URLMON.dll")
HRESULT CreateIUriBuilder(IUri pIUri, uint dwFlags, uint dwReserved, IUriBuilder* ppIUriBuilder);

@DllImport("urlmon.dll")
HRESULT HlinkSimpleNavigateToString(const(wchar)* szTarget, const(wchar)* szLocation, const(wchar)* szTargetFrameName, IUnknown pUnk, IBindCtx pbc, IBindStatusCallback param5, uint grfHLNF, uint dwReserved);

@DllImport("urlmon.dll")
HRESULT HlinkSimpleNavigateToMoniker(IMoniker pmkTarget, const(wchar)* szLocation, const(wchar)* szTargetFrameName, IUnknown pUnk, IBindCtx pbc, IBindStatusCallback param5, uint grfHLNF, uint dwReserved);

@DllImport("urlmon.dll")
HRESULT URLOpenStreamA(IUnknown param0, const(char)* param1, uint param2, IBindStatusCallback param3);

@DllImport("urlmon.dll")
HRESULT URLOpenStreamW(IUnknown param0, const(wchar)* param1, uint param2, IBindStatusCallback param3);

@DllImport("urlmon.dll")
HRESULT URLOpenPullStreamA(IUnknown param0, const(char)* param1, uint param2, IBindStatusCallback param3);

@DllImport("urlmon.dll")
HRESULT URLOpenPullStreamW(IUnknown param0, const(wchar)* param1, uint param2, IBindStatusCallback param3);

@DllImport("urlmon.dll")
HRESULT URLDownloadToFileA(IUnknown param0, const(char)* param1, const(char)* param2, uint param3, IBindStatusCallback param4);

@DllImport("urlmon.dll")
HRESULT URLDownloadToFileW(IUnknown param0, const(wchar)* param1, const(wchar)* param2, uint param3, IBindStatusCallback param4);

@DllImport("urlmon.dll")
HRESULT URLDownloadToCacheFileA(IUnknown param0, const(char)* param1, const(char)* param2, uint cchFileName, uint param4, IBindStatusCallback param5);

@DllImport("urlmon.dll")
HRESULT URLDownloadToCacheFileW(IUnknown param0, const(wchar)* param1, const(wchar)* param2, uint cchFileName, uint param4, IBindStatusCallback param5);

@DllImport("urlmon.dll")
HRESULT URLOpenBlockingStreamA(IUnknown param0, const(char)* param1, IStream* param2, uint param3, IBindStatusCallback param4);

@DllImport("urlmon.dll")
HRESULT URLOpenBlockingStreamW(IUnknown param0, const(wchar)* param1, IStream* param2, uint param3, IBindStatusCallback param4);

@DllImport("urlmon.dll")
HRESULT HlinkGoBack(IUnknown pUnk);

@DllImport("urlmon.dll")
HRESULT HlinkGoForward(IUnknown pUnk);

@DllImport("urlmon.dll")
HRESULT HlinkNavigateString(IUnknown pUnk, const(wchar)* szTarget);

@DllImport("urlmon.dll")
HRESULT HlinkNavigateMoniker(IUnknown pUnk, IMoniker pmkTarget);

@DllImport("urlmon.dll")
HRESULT CoInternetParseUrl(const(wchar)* pwzUrl, PARSEACTION ParseAction, uint dwFlags, const(wchar)* pszResult, uint cchResult, uint* pcchResult, uint dwReserved);

@DllImport("urlmon.dll")
HRESULT CoInternetParseIUri(IUri pIUri, PARSEACTION ParseAction, uint dwFlags, const(wchar)* pwzResult, uint cchResult, uint* pcchResult, uint dwReserved);

@DllImport("urlmon.dll")
HRESULT CoInternetCombineUrl(const(wchar)* pwzBaseUrl, const(wchar)* pwzRelativeUrl, uint dwCombineFlags, const(wchar)* pszResult, uint cchResult, uint* pcchResult, uint dwReserved);

@DllImport("urlmon.dll")
HRESULT CoInternetCombineUrlEx(IUri pBaseUri, const(wchar)* pwzRelativeUrl, uint dwCombineFlags, IUri* ppCombinedUri, uint dwReserved);

@DllImport("urlmon.dll")
HRESULT CoInternetCombineIUri(IUri pBaseUri, IUri pRelativeUri, uint dwCombineFlags, IUri* ppCombinedUri, uint dwReserved);

@DllImport("urlmon.dll")
HRESULT CoInternetCompareUrl(const(wchar)* pwzUrl1, const(wchar)* pwzUrl2, uint dwFlags);

@DllImport("urlmon.dll")
HRESULT CoInternetGetProtocolFlags(const(wchar)* pwzUrl, uint* pdwFlags, uint dwReserved);

@DllImport("urlmon.dll")
HRESULT CoInternetQueryInfo(const(wchar)* pwzUrl, QUERYOPTION QueryOptions, uint dwQueryFlags, char* pvBuffer, uint cbBuffer, uint* pcbBuffer, uint dwReserved);

@DllImport("urlmon.dll")
HRESULT CoInternetGetSession(uint dwSessionMode, IInternetSession* ppIInternetSession, uint dwReserved);

@DllImport("urlmon.dll")
HRESULT CoInternetGetSecurityUrl(const(wchar)* pwszUrl, ushort** ppwszSecUrl, PSUACTION psuAction, uint dwReserved);

@DllImport("urlmon.dll")
HRESULT CoInternetGetSecurityUrlEx(IUri pUri, IUri* ppSecUri, PSUACTION psuAction, uint dwReserved);

@DllImport("urlmon.dll")
HRESULT CoInternetSetFeatureEnabled(INTERNETFEATURELIST FeatureEntry, uint dwFlags, BOOL fEnable);

@DllImport("urlmon.dll")
HRESULT CoInternetIsFeatureEnabled(INTERNETFEATURELIST FeatureEntry, uint dwFlags);

@DllImport("urlmon.dll")
HRESULT CoInternetIsFeatureEnabledForUrl(INTERNETFEATURELIST FeatureEntry, uint dwFlags, const(wchar)* szURL, IInternetSecurityManager pSecMgr);

@DllImport("urlmon.dll")
HRESULT CoInternetIsFeatureEnabledForIUri(INTERNETFEATURELIST FeatureEntry, uint dwFlags, IUri pIUri, IInternetSecurityManagerEx2 pSecMgr);

@DllImport("urlmon.dll")
HRESULT CoInternetIsFeatureZoneElevationEnabled(const(wchar)* szFromURL, const(wchar)* szToURL, IInternetSecurityManager pSecMgr, uint dwFlags);

@DllImport("urlmon.dll")
HRESULT CopyStgMedium(const(STGMEDIUM)* pcstgmedSrc, STGMEDIUM* pstgmedDest);

@DllImport("urlmon.dll")
HRESULT CopyBindInfo(const(BINDINFO)* pcbiSrc, BINDINFO* pbiDest);

@DllImport("urlmon.dll")
void ReleaseBindInfo(BINDINFO* pbindinfo);

@DllImport("urlmon.dll")
ushort* IEGetUserPrivateNamespaceName();

@DllImport("urlmon.dll")
HRESULT CoInternetCreateSecurityManager(IServiceProvider pSP, IInternetSecurityManager* ppSM, uint dwReserved);

@DllImport("urlmon.dll")
HRESULT CoInternetCreateZoneManager(IServiceProvider pSP, IInternetZoneManager* ppZM, uint dwReserved);

@DllImport("urlmon.dll")
HRESULT GetSoftwareUpdateInfo(const(wchar)* szDistUnit, SOFTDISTINFO* psdi);

@DllImport("urlmon.dll")
HRESULT SetSoftwareUpdateAdvertisementState(const(wchar)* szDistUnit, uint dwAdState, uint dwAdvertisedVersionMS, uint dwAdvertisedVersionLS);

@DllImport("urlmon.dll")
BOOL IsLoggingEnabledA(const(char)* pszUrl);

@DllImport("urlmon.dll")
BOOL IsLoggingEnabledW(const(wchar)* pwszUrl);

@DllImport("urlmon.dll")
BOOL WriteHitLogging(HIT_LOGGING_INFO* lpLogginginfo);

@DllImport("OLE32.dll")
HRESULT CreateDataAdviseHolder(IDataAdviseHolder* ppDAHolder);

@DllImport("ole32.dll")
uint OleBuildVersion();

@DllImport("OLE32.dll")
HRESULT OleInitialize(void* pvReserved);

@DllImport("OLE32.dll")
void OleUninitialize();

@DllImport("OLE32.dll")
HRESULT OleQueryLinkFromData(IDataObject pSrcDataObject);

@DllImport("OLE32.dll")
HRESULT OleQueryCreateFromData(IDataObject pSrcDataObject);

@DllImport("OLE32.dll")
HRESULT OleCreate(const(Guid)* rclsid, const(Guid)* riid, uint renderopt, FORMATETC* pFormatEtc, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

@DllImport("ole32.dll")
HRESULT OleCreateEx(const(Guid)* rclsid, const(Guid)* riid, uint dwFlags, uint renderopt, uint cFormats, uint* rgAdvf, FORMATETC* rgFormatEtc, IAdviseSink lpAdviseSink, uint* rgdwConnection, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

@DllImport("OLE32.dll")
HRESULT OleCreateFromData(IDataObject pSrcDataObj, const(Guid)* riid, uint renderopt, FORMATETC* pFormatEtc, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

@DllImport("ole32.dll")
HRESULT OleCreateFromDataEx(IDataObject pSrcDataObj, const(Guid)* riid, uint dwFlags, uint renderopt, uint cFormats, uint* rgAdvf, FORMATETC* rgFormatEtc, IAdviseSink lpAdviseSink, uint* rgdwConnection, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

@DllImport("OLE32.dll")
HRESULT OleCreateLinkFromData(IDataObject pSrcDataObj, const(Guid)* riid, uint renderopt, FORMATETC* pFormatEtc, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

@DllImport("ole32.dll")
HRESULT OleCreateLinkFromDataEx(IDataObject pSrcDataObj, const(Guid)* riid, uint dwFlags, uint renderopt, uint cFormats, uint* rgAdvf, FORMATETC* rgFormatEtc, IAdviseSink lpAdviseSink, uint* rgdwConnection, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

@DllImport("OLE32.dll")
HRESULT OleCreateStaticFromData(IDataObject pSrcDataObj, const(Guid)* iid, uint renderopt, FORMATETC* pFormatEtc, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

@DllImport("ole32.dll")
HRESULT OleCreateLink(IMoniker pmkLinkSrc, const(Guid)* riid, uint renderopt, FORMATETC* lpFormatEtc, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

@DllImport("ole32.dll")
HRESULT OleCreateLinkEx(IMoniker pmkLinkSrc, const(Guid)* riid, uint dwFlags, uint renderopt, uint cFormats, uint* rgAdvf, FORMATETC* rgFormatEtc, IAdviseSink lpAdviseSink, uint* rgdwConnection, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

@DllImport("OLE32.dll")
HRESULT OleCreateLinkToFile(ushort* lpszFileName, const(Guid)* riid, uint renderopt, FORMATETC* lpFormatEtc, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

@DllImport("ole32.dll")
HRESULT OleCreateLinkToFileEx(ushort* lpszFileName, const(Guid)* riid, uint dwFlags, uint renderopt, uint cFormats, uint* rgAdvf, FORMATETC* rgFormatEtc, IAdviseSink lpAdviseSink, uint* rgdwConnection, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

@DllImport("OLE32.dll")
HRESULT OleCreateFromFile(const(Guid)* rclsid, ushort* lpszFileName, const(Guid)* riid, uint renderopt, FORMATETC* lpFormatEtc, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

@DllImport("ole32.dll")
HRESULT OleCreateFromFileEx(const(Guid)* rclsid, ushort* lpszFileName, const(Guid)* riid, uint dwFlags, uint renderopt, uint cFormats, uint* rgAdvf, FORMATETC* rgFormatEtc, IAdviseSink lpAdviseSink, uint* rgdwConnection, IOleClientSite pClientSite, IStorage pStg, void** ppvObj);

@DllImport("OLE32.dll")
HRESULT OleLoad(IStorage pStg, const(Guid)* riid, IOleClientSite pClientSite, void** ppvObj);

@DllImport("OLE32.dll")
HRESULT OleSave(IPersistStorage pPS, IStorage pStg, BOOL fSameAsLoad);

@DllImport("OLE32.dll")
HRESULT OleLoadFromStream(IStream pStm, const(Guid)* iidInterface, void** ppvObj);

@DllImport("OLE32.dll")
HRESULT OleSaveToStream(IPersistStream pPStm, IStream pStm);

@DllImport("OLE32.dll")
HRESULT OleSetContainedObject(IUnknown pUnknown, BOOL fContained);

@DllImport("ole32.dll")
HRESULT OleNoteObjectVisible(IUnknown pUnknown, BOOL fVisible);

@DllImport("OLE32.dll")
HRESULT RegisterDragDrop(HWND hwnd, IDropTarget pDropTarget);

@DllImport("OLE32.dll")
HRESULT RevokeDragDrop(HWND hwnd);

@DllImport("OLE32.dll")
HRESULT DoDragDrop(IDataObject pDataObj, IDropSource pDropSource, uint dwOKEffects, uint* pdwEffect);

@DllImport("OLE32.dll")
HRESULT OleSetClipboard(IDataObject pDataObj);

@DllImport("OLE32.dll")
HRESULT OleGetClipboard(IDataObject* ppDataObj);

@DllImport("ole32.dll")
HRESULT OleGetClipboardWithEnterpriseInfo(IDataObject* dataObject, ushort** dataEnterpriseId, ushort** sourceDescription, ushort** targetDescription, ushort** dataDescription);

@DllImport("OLE32.dll")
HRESULT OleFlushClipboard();

@DllImport("OLE32.dll")
HRESULT OleIsCurrentClipboard(IDataObject pDataObj);

@DllImport("OLE32.dll")
int OleCreateMenuDescriptor(HMENU hmenuCombined, OleMenuGroupWidths* lpMenuWidths);

@DllImport("OLE32.dll")
HRESULT OleSetMenuDescriptor(int holemenu, HWND hwndFrame, HWND hwndActiveObject, IOleInPlaceFrame lpFrame, IOleInPlaceActiveObject lpActiveObj);

@DllImport("OLE32.dll")
HRESULT OleDestroyMenuDescriptor(int holemenu);

@DllImport("OLE32.dll")
HRESULT OleTranslateAccelerator(IOleInPlaceFrame lpFrame, OIFI* lpFrameInfo, MSG* lpmsg);

@DllImport("OLE32.dll")
HANDLE OleDuplicateData(HANDLE hSrc, ushort cfFormat, uint uiFlags);

@DllImport("OLE32.dll")
HRESULT OleDraw(IUnknown pUnknown, uint dwAspect, HDC hdcDraw, RECT* lprcBounds);

@DllImport("OLE32.dll")
HRESULT OleRun(IUnknown pUnknown);

@DllImport("OLE32.dll")
BOOL OleIsRunning(IOleObject pObject);

@DllImport("OLE32.dll")
HRESULT OleLockRunning(IUnknown pUnknown, BOOL fLock, BOOL fLastUnlockCloses);

@DllImport("OLE32.dll")
void ReleaseStgMedium(STGMEDIUM* param0);

@DllImport("OLE32.dll")
HRESULT CreateOleAdviseHolder(IOleAdviseHolder* ppOAHolder);

@DllImport("ole32.dll")
HRESULT OleCreateDefaultHandler(const(Guid)* clsid, IUnknown pUnkOuter, const(Guid)* riid, void** lplpObj);

@DllImport("OLE32.dll")
HRESULT OleCreateEmbeddingHelper(const(Guid)* clsid, IUnknown pUnkOuter, uint flags, IClassFactory pCF, const(Guid)* riid, void** lplpObj);

@DllImport("OLE32.dll")
BOOL IsAccelerator(HACCEL hAccel, int cAccelEntries, MSG* lpMsg, ushort* lpwCmd);

@DllImport("ole32.dll")
int OleGetIconOfFile(ushort* lpszPath, BOOL fUseFileAsLabel);

@DllImport("OLE32.dll")
int OleGetIconOfClass(const(Guid)* rclsid, ushort* lpszLabel, BOOL fUseTypeAsLabel);

@DllImport("ole32.dll")
int OleMetafilePictFromIconAndLabel(HICON hIcon, ushort* lpszLabel, ushort* lpszSourceFile, uint iIconIndex);

@DllImport("OLE32.dll")
HRESULT OleRegGetUserType(const(Guid)* clsid, uint dwFormOfType, ushort** pszUserType);

@DllImport("OLE32.dll")
HRESULT OleRegGetMiscStatus(const(Guid)* clsid, uint dwAspect, uint* pdwStatus);

@DllImport("ole32.dll")
HRESULT OleRegEnumFormatEtc(const(Guid)* clsid, uint dwDirection, IEnumFORMATETC* ppenum);

@DllImport("OLE32.dll")
HRESULT OleRegEnumVerbs(const(Guid)* clsid, IEnumOLEVERB* ppenum);

@DllImport("ole32.dll")
HRESULT OleDoAutoConvert(IStorage pStg, Guid* pClsidNew);

@DllImport("OLE32.dll")
HRESULT OleGetAutoConvert(const(Guid)* clsidOld, Guid* pClsidNew);

@DllImport("ole32.dll")
HRESULT OleSetAutoConvert(const(Guid)* clsidOld, const(Guid)* clsidNew);

@DllImport("OLE32.dll")
uint HPALETTE_UserSize(uint* param0, uint param1, HPALETTE* param2);

@DllImport("OLE32.dll")
ubyte* HPALETTE_UserMarshal(uint* param0, ubyte* param1, HPALETTE* param2);

@DllImport("OLE32.dll")
ubyte* HPALETTE_UserUnmarshal(uint* param0, char* param1, HPALETTE* param2);

@DllImport("OLE32.dll")
void HPALETTE_UserFree(uint* param0, HPALETTE* param1);

@DllImport("OLE32.dll")
uint HRGN_UserSize(uint* param0, uint param1, HRGN* param2);

@DllImport("OLE32.dll")
ubyte* HRGN_UserMarshal(uint* param0, ubyte* param1, HRGN* param2);

@DllImport("OLE32.dll")
ubyte* HRGN_UserUnmarshal(uint* param0, char* param1, HRGN* param2);

@DllImport("OLE32.dll")
void HRGN_UserFree(uint* param0, HRGN* param1);

@DllImport("OLE32.dll")
uint HPALETTE_UserSize64(uint* param0, uint param1, HPALETTE* param2);

@DllImport("OLE32.dll")
ubyte* HPALETTE_UserMarshal64(uint* param0, ubyte* param1, HPALETTE* param2);

@DllImport("OLE32.dll")
ubyte* HPALETTE_UserUnmarshal64(uint* param0, char* param1, HPALETTE* param2);

@DllImport("OLE32.dll")
void HPALETTE_UserFree64(uint* param0, HPALETTE* param1);

@DllImport("OLEAUT32.dll")
HRESULT OleCreatePropertyFrame(HWND hwndOwner, uint x, uint y, ushort* lpszCaption, uint cObjects, IUnknown* ppUnk, uint cPages, Guid* pPageClsID, uint lcid, uint dwReserved, void* pvReserved);

@DllImport("OLEAUT32.dll")
HRESULT OleCreatePropertyFrameIndirect(OCPFIPARAMS* lpParams);

@DllImport("OLEAUT32.dll")
HRESULT OleTranslateColor(uint clr, HPALETTE hpal, uint* lpcolorref);

@DllImport("OLEAUT32.dll")
HRESULT OleCreateFontIndirect(FONTDESC* lpFontDesc, const(Guid)* riid, void** lplpvObj);

@DllImport("OLEAUT32.dll")
HRESULT OleCreatePictureIndirect(PICTDESC* lpPictDesc, const(Guid)* riid, BOOL fOwn, void** lplpvObj);

@DllImport("OLEAUT32.dll")
HRESULT OleLoadPicture(IStream lpstream, int lSize, BOOL fRunmode, const(Guid)* riid, void** lplpvObj);

@DllImport("OLEAUT32.dll")
HRESULT OleLoadPictureEx(IStream lpstream, int lSize, BOOL fRunmode, const(Guid)* riid, uint xSizeDesired, uint ySizeDesired, uint dwFlags, void** lplpvObj);

@DllImport("OLEAUT32.dll")
HRESULT OleLoadPicturePath(ushort* szURLorPath, IUnknown punkCaller, uint dwReserved, uint clrReserved, const(Guid)* riid, void** ppvRet);

@DllImport("OLEAUT32.dll")
HCURSOR OleIconToCursor(HINSTANCE hinstExe, HICON hIcon);

@DllImport("oledlg.dll")
BOOL OleUIAddVerbMenuW(IOleObject lpOleObj, const(wchar)* lpszShortType, HMENU hMenu, uint uPos, uint uIDVerbMin, uint uIDVerbMax, BOOL bAddConvert, uint idConvert, HMENU* lphMenu);

@DllImport("oledlg.dll")
BOOL OleUIAddVerbMenuA(IOleObject lpOleObj, const(char)* lpszShortType, HMENU hMenu, uint uPos, uint uIDVerbMin, uint uIDVerbMax, BOOL bAddConvert, uint idConvert, HMENU* lphMenu);

@DllImport("oledlg.dll")
uint OleUIInsertObjectW(OLEUIINSERTOBJECTW* param0);

@DllImport("oledlg.dll")
uint OleUIInsertObjectA(OLEUIINSERTOBJECTA* param0);

@DllImport("oledlg.dll")
uint OleUIPasteSpecialW(OLEUIPASTESPECIALW* param0);

@DllImport("oledlg.dll")
uint OleUIPasteSpecialA(OLEUIPASTESPECIALA* param0);

@DllImport("oledlg.dll")
uint OleUIEditLinksW(OLEUIEDITLINKSW* param0);

@DllImport("oledlg.dll")
uint OleUIEditLinksA(OLEUIEDITLINKSA* param0);

@DllImport("oledlg.dll")
uint OleUIChangeIconW(OLEUICHANGEICONW* param0);

@DllImport("oledlg.dll")
uint OleUIChangeIconA(OLEUICHANGEICONA* param0);

@DllImport("oledlg.dll")
uint OleUIConvertW(OLEUICONVERTW* param0);

@DllImport("oledlg.dll")
uint OleUIConvertA(OLEUICONVERTA* param0);

@DllImport("oledlg.dll")
BOOL OleUICanConvertOrActivateAs(const(Guid)* rClsid, BOOL fIsLinkedObject, ushort wFormat);

@DllImport("oledlg.dll")
uint OleUIBusyW(OLEUIBUSYW* param0);

@DllImport("oledlg.dll")
uint OleUIBusyA(OLEUIBUSYA* param0);

@DllImport("oledlg.dll")
uint OleUIChangeSourceW(OLEUICHANGESOURCEW* param0);

@DllImport("oledlg.dll")
uint OleUIChangeSourceA(OLEUICHANGESOURCEA* param0);

@DllImport("oledlg.dll")
uint OleUIObjectPropertiesW(OLEUIOBJECTPROPSW* param0);

@DllImport("oledlg.dll")
uint OleUIObjectPropertiesA(OLEUIOBJECTPROPSA* param0);

@DllImport("oledlg.dll")
int OleUIPromptUserW(int nTemplate, HWND hwndParent);

@DllImport("oledlg.dll")
int OleUIPromptUserA(int nTemplate, HWND hwndParent);

@DllImport("oledlg.dll")
BOOL OleUIUpdateLinksW(IOleUILinkContainerW lpOleUILinkCntr, HWND hwndParent, const(wchar)* lpszTitle, int cLinks);

@DllImport("oledlg.dll")
BOOL OleUIUpdateLinksA(IOleUILinkContainerA lpOleUILinkCntr, HWND hwndParent, const(char)* lpszTitle, int cLinks);

@DllImport("ole32.dll")
HRESULT CoGetInterceptor(const(Guid)* iidIntercepted, IUnknown punkOuter, const(Guid)* iid, void** ppv);

@DllImport("ole32.dll")
HRESULT CoGetInterceptorFromTypeInfo(const(Guid)* iidIntercepted, IUnknown punkOuter, ITypeInfo typeInfo, const(Guid)* iid, void** ppv);

@DllImport("ole32.dll")
void CoSetMessageDispatcher(IMessageDispatcher pMessageDispatcher);

@DllImport("ole32.dll")
void CoHandlePriorityEventsFromMessagePump();

@DllImport("OLE32.dll")
HRESULT CoInitialize(void* pvReserved);

@DllImport("OLE32.dll")
HRESULT CoRegisterMallocSpy(IMallocSpy pMallocSpy);

@DllImport("OLE32.dll")
HRESULT CoRevokeMallocSpy();

@DllImport("OLE32.dll")
HRESULT CoRegisterInitializeSpy(IInitializeSpy pSpy, ULARGE_INTEGER* puliCookie);

@DllImport("OLE32.dll")
HRESULT CoRevokeInitializeSpy(ULARGE_INTEGER uliCookie);

@DllImport("OLE32.dll")
HRESULT CoGetSystemSecurityPermissions(COMSD comSDType, void** ppSD);

@DllImport("OLE32.dll")
HINSTANCE CoLoadLibrary(ushort* lpszLibName, BOOL bAutoFree);

@DllImport("OLE32.dll")
void CoFreeLibrary(HINSTANCE hInst);

@DllImport("OLE32.dll")
void CoFreeAllLibraries();

@DllImport("OLE32.dll")
HRESULT CoGetInstanceFromFile(COSERVERINFO* pServerInfo, Guid* pClsid, IUnknown punkOuter, uint dwClsCtx, uint grfMode, ushort* pwszName, uint dwCount, char* pResults);

@DllImport("OLE32.dll")
HRESULT CoGetInstanceFromIStorage(COSERVERINFO* pServerInfo, Guid* pClsid, IUnknown punkOuter, uint dwClsCtx, IStorage pstg, uint dwCount, char* pResults);

@DllImport("OLE32.dll")
HRESULT CoAllowSetForegroundWindow(IUnknown pUnk, void* lpvReserved);

@DllImport("ole32.dll")
BOOL CoIsOle1Class(const(Guid)* rclsid);

@DllImport("OLE32.dll")
BOOL CoFileTimeToDosDateTime(FILETIME* lpFileTime, ushort* lpDosDate, ushort* lpDosTime);

@DllImport("OLE32.dll")
BOOL CoDosDateTimeToFileTime(ushort nDosDate, ushort nDosTime, FILETIME* lpFileTime);

@DllImport("OLE32.dll")
HRESULT CoRegisterMessageFilter(IMessageFilter lpMessageFilter, IMessageFilter* lplpMessageFilter);

@DllImport("ole32.dll")
HRESULT CoRegisterChannelHook(const(Guid)* ExtensionUuid, IChannelHook pChannelHook);

@DllImport("OLE32.dll")
HRESULT CoTreatAsClass(const(Guid)* clsidOld, const(Guid)* clsidNew);

@DllImport("OLE32.dll")
HRESULT CreateDataCache(IUnknown pUnkOuter, const(Guid)* rclsid, const(Guid)* iid, void** ppv);

@DllImport("OLE32.dll")
HRESULT BindMoniker(IMoniker pmk, uint grfOpt, const(Guid)* iidResult, void** ppvResult);

@DllImport("OLE32.dll")
HRESULT CoGetObject(const(wchar)* pszName, BIND_OPTS* pBindOptions, const(Guid)* riid, void** ppv);

@DllImport("OLE32.dll")
HRESULT MkParseDisplayName(IBindCtx pbc, ushort* szUserName, uint* pchEaten, IMoniker* ppmk);

@DllImport("ole32.dll")
HRESULT MonikerRelativePathTo(IMoniker pmkSrc, IMoniker pmkDest, IMoniker* ppmkRelPath, BOOL dwReserved);

@DllImport("ole32.dll")
HRESULT MonikerCommonPrefixWith(IMoniker pmkThis, IMoniker pmkOther, IMoniker* ppmkCommon);

@DllImport("OLE32.dll")
HRESULT CreateBindCtx(uint reserved, IBindCtx* ppbc);

@DllImport("OLE32.dll")
HRESULT CreateGenericComposite(IMoniker pmkFirst, IMoniker pmkRest, IMoniker* ppmkComposite);

@DllImport("OLE32.dll")
HRESULT GetClassFile(ushort* szFilename, Guid* pclsid);

@DllImport("OLE32.dll")
HRESULT CreateClassMoniker(const(Guid)* rclsid, IMoniker* ppmk);

@DllImport("OLE32.dll")
HRESULT CreateFileMoniker(ushort* lpszPathName, IMoniker* ppmk);

@DllImport("OLE32.dll")
HRESULT CreateItemMoniker(ushort* lpszDelim, ushort* lpszItem, IMoniker* ppmk);

@DllImport("OLE32.dll")
HRESULT CreateAntiMoniker(IMoniker* ppmk);

@DllImport("OLE32.dll")
HRESULT CreatePointerMoniker(IUnknown punk, IMoniker* ppmk);

@DllImport("OLE32.dll")
HRESULT CreateObjrefMoniker(IUnknown punk, IMoniker* ppmk);

@DllImport("OLE32.dll")
HRESULT GetRunningObjectTable(uint reserved, IRunningObjectTable* pprot);

alias HRESULT = int;
enum DVASPECT
{
    DVASPECT_CONTENT = 1,
    DVASPECT_THUMBNAIL = 2,
    DVASPECT_ICON = 4,
    DVASPECT_DOCPRINT = 8,
}

struct CSPLATFORM
{
    uint dwPlatformId;
    uint dwVersionHi;
    uint dwVersionLo;
    uint dwProcessorArch;
}

struct QUERYCONTEXT
{
    uint dwContext;
    CSPLATFORM Platform;
    uint Locale;
    uint dwVersionHi;
    uint dwVersionLo;
}

enum TYSPEC
{
    TYSPEC_CLSID = 0,
    TYSPEC_FILEEXT = 1,
    TYSPEC_MIMETYPE = 2,
    TYSPEC_FILENAME = 3,
    TYSPEC_PROGID = 4,
    TYSPEC_PACKAGENAME = 5,
    TYSPEC_OBJECTID = 6,
}

const GUID IID_IEventPublisher = {0xE341516B, 0x2E32, 0x11D1, [0x99, 0x64, 0x00, 0xC0, 0x4F, 0xBB, 0xB3, 0x45]};
@GUID(0xE341516B, 0x2E32, 0x11D1, [0x99, 0x64, 0x00, 0xC0, 0x4F, 0xBB, 0xB3, 0x45]);
interface IEventPublisher : IDispatch
{
    HRESULT get_PublisherID(BSTR* pbstrPublisherID);
    HRESULT put_PublisherID(BSTR bstrPublisherID);
    HRESULT get_PublisherName(BSTR* pbstrPublisherName);
    HRESULT put_PublisherName(BSTR bstrPublisherName);
    HRESULT get_PublisherType(BSTR* pbstrPublisherType);
    HRESULT put_PublisherType(BSTR bstrPublisherType);
    HRESULT get_OwnerSID(BSTR* pbstrOwnerSID);
    HRESULT put_OwnerSID(BSTR bstrOwnerSID);
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT GetDefaultProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
    HRESULT PutDefaultProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
    HRESULT RemoveDefaultProperty(BSTR bstrPropertyName);
    HRESULT GetDefaultPropertyCollection(IEventObjectCollection* collection);
}

enum EOC_ChangeType
{
    EOC_NewObject = 0,
    EOC_ModifiedObject = 1,
    EOC_DeletedObject = 2,
}

const GUID IID_IEventProperty = {0xDA538EE2, 0xF4DE, 0x11D1, [0xB6, 0xBB, 0x00, 0x80, 0x5F, 0xC7, 0x92, 0x16]};
@GUID(0xDA538EE2, 0xF4DE, 0x11D1, [0xB6, 0xBB, 0x00, 0x80, 0x5F, 0xC7, 0x92, 0x16]);
interface IEventProperty : IDispatch
{
    HRESULT get_Name(BSTR* propertyName);
    HRESULT put_Name(BSTR propertyName);
    HRESULT get_Value(VARIANT* propertyValue);
    HRESULT put_Value(VARIANT* propertyValue);
}

const GUID IID_IAccessibilityDockingServiceCallback = {0x157733FD, 0xA592, 0x42E5, [0xB5, 0x94, 0x24, 0x84, 0x68, 0xC5, 0xA8, 0x1B]};
@GUID(0x157733FD, 0xA592, 0x42E5, [0xB5, 0x94, 0x24, 0x84, 0x68, 0xC5, 0xA8, 0x1B]);
interface IAccessibilityDockingServiceCallback : IUnknown
{
    HRESULT Undocked(UNDOCK_REASON undockReason);
}

const GUID IID_IAccessibilityDockingService = {0x8849DC22, 0xCEDF, 0x4C95, [0x99, 0x8D, 0x05, 0x14, 0x19, 0xDD, 0x3F, 0x76]};
@GUID(0x8849DC22, 0xCEDF, 0x4C95, [0x99, 0x8D, 0x05, 0x14, 0x19, 0xDD, 0x3F, 0x76]);
interface IAccessibilityDockingService : IUnknown
{
    HRESULT GetAvailableSize(int hMonitor, uint* pcxFixed, uint* pcyMax);
    HRESULT DockWindow(HWND hwnd, int hMonitor, uint cyRequested, IAccessibilityDockingServiceCallback pCallback);
    HRESULT UndockWindow(HWND hwnd);
}

struct ACTRL_ACCESS_ENTRYA
{
    TRUSTEE_A Trustee;
    uint fAccessFlags;
    uint Access;
    uint ProvSpecificAccess;
    uint Inheritance;
    const(char)* lpInheritProperty;
}

struct ACTRL_ACCESS_ENTRYW
{
    TRUSTEE_W Trustee;
    uint fAccessFlags;
    uint Access;
    uint ProvSpecificAccess;
    uint Inheritance;
    const(wchar)* lpInheritProperty;
}

struct ACTRL_ACCESS_ENTRY_LISTA
{
    uint cEntries;
    ACTRL_ACCESS_ENTRYA* pAccessList;
}

struct ACTRL_ACCESS_ENTRY_LISTW
{
    uint cEntries;
    ACTRL_ACCESS_ENTRYW* pAccessList;
}

struct ACTRL_PROPERTY_ENTRYA
{
    const(char)* lpProperty;
    ACTRL_ACCESS_ENTRY_LISTA* pAccessEntryList;
    uint fListFlags;
}

struct ACTRL_PROPERTY_ENTRYW
{
    const(wchar)* lpProperty;
    ACTRL_ACCESS_ENTRY_LISTW* pAccessEntryList;
    uint fListFlags;
}

struct ACTRL_ACCESSA
{
    uint cEntries;
    ACTRL_PROPERTY_ENTRYA* pPropertyAccessList;
}

struct ACTRL_ACCESSW
{
    uint cEntries;
    ACTRL_PROPERTY_ENTRYW* pPropertyAccessList;
}

enum COINIT
{
    COINIT_APARTMENTTHREADED = 2,
    COINIT_MULTITHREADED = 0,
    COINIT_DISABLE_OLE1DDE = 4,
    COINIT_SPEED_OVER_MEMORY = 8,
}

enum COMSD
{
    SD_LAUNCHPERMISSIONS = 0,
    SD_ACCESSPERMISSIONS = 1,
    SD_LAUNCHRESTRICTIONS = 2,
    SD_ACCESSRESTRICTIONS = 3,
}

