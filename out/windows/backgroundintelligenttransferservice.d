module windows.backgroundintelligenttransferservice;

public import system;
public import windows.automation;
public import windows.com;
public import windows.systemservices;
public import windows.windowsprogramming;

extern(Windows):

const GUID CLSID_BackgroundCopyManager = {0x4991D34B, 0x80A1, 0x4291, [0x83, 0xB6, 0x33, 0x28, 0x36, 0x6B, 0x90, 0x97]};
@GUID(0x4991D34B, 0x80A1, 0x4291, [0x83, 0xB6, 0x33, 0x28, 0x36, 0x6B, 0x90, 0x97]);
struct BackgroundCopyManager;

struct BG_FILE_PROGRESS
{
    ulong BytesTotal;
    ulong BytesTransferred;
    BOOL Completed;
}

const GUID IID_IBackgroundCopyFile = {0x01B7BD23, 0xFB88, 0x4A77, [0x84, 0x90, 0x58, 0x91, 0xD3, 0xE4, 0x65, 0x3A]};
@GUID(0x01B7BD23, 0xFB88, 0x4A77, [0x84, 0x90, 0x58, 0x91, 0xD3, 0xE4, 0x65, 0x3A]);
interface IBackgroundCopyFile : IUnknown
{
    HRESULT GetRemoteName(ushort** pVal);
    HRESULT GetLocalName(ushort** pVal);
    HRESULT GetProgress(BG_FILE_PROGRESS* pVal);
}

const GUID IID_IEnumBackgroundCopyFiles = {0xCA51E165, 0xC365, 0x424C, [0x8D, 0x41, 0x24, 0xAA, 0xA4, 0xFF, 0x3C, 0x40]};
@GUID(0xCA51E165, 0xC365, 0x424C, [0x8D, 0x41, 0x24, 0xAA, 0xA4, 0xFF, 0x3C, 0x40]);
interface IEnumBackgroundCopyFiles : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumBackgroundCopyFiles* ppenum);
    HRESULT GetCount(uint* puCount);
}

enum BG_ERROR_CONTEXT
{
    BG_ERROR_CONTEXT_NONE = 0,
    BG_ERROR_CONTEXT_UNKNOWN = 1,
    BG_ERROR_CONTEXT_GENERAL_QUEUE_MANAGER = 2,
    BG_ERROR_CONTEXT_QUEUE_MANAGER_NOTIFICATION = 3,
    BG_ERROR_CONTEXT_LOCAL_FILE = 4,
    BG_ERROR_CONTEXT_REMOTE_FILE = 5,
    BG_ERROR_CONTEXT_GENERAL_TRANSPORT = 6,
    BG_ERROR_CONTEXT_REMOTE_APPLICATION = 7,
    BG_ERROR_CONTEXT_SERVER_CERTIFICATE_CALLBACK = 8,
}

const GUID IID_IBackgroundCopyError = {0x19C613A0, 0xFCB8, 0x4F28, [0x81, 0xAE, 0x89, 0x7C, 0x3D, 0x07, 0x8F, 0x81]};
@GUID(0x19C613A0, 0xFCB8, 0x4F28, [0x81, 0xAE, 0x89, 0x7C, 0x3D, 0x07, 0x8F, 0x81]);
interface IBackgroundCopyError : IUnknown
{
    HRESULT GetError(BG_ERROR_CONTEXT* pContext, int* pCode);
    HRESULT GetFile(IBackgroundCopyFile* pVal);
    HRESULT GetErrorDescription(uint LanguageId, ushort** pErrorDescription);
    HRESULT GetErrorContextDescription(uint LanguageId, ushort** pContextDescription);
    HRESULT GetProtocol(ushort** pProtocol);
}

struct BG_FILE_INFO
{
    const(wchar)* RemoteName;
    const(wchar)* LocalName;
}

struct BG_JOB_PROGRESS
{
    ulong BytesTotal;
    ulong BytesTransferred;
    uint FilesTotal;
    uint FilesTransferred;
}

struct BG_JOB_TIMES
{
    FILETIME CreationTime;
    FILETIME ModificationTime;
    FILETIME TransferCompletionTime;
}

enum BG_JOB_PRIORITY
{
    BG_JOB_PRIORITY_FOREGROUND = 0,
    BG_JOB_PRIORITY_HIGH = 1,
    BG_JOB_PRIORITY_NORMAL = 2,
    BG_JOB_PRIORITY_LOW = 3,
}

enum BG_JOB_STATE
{
    BG_JOB_STATE_QUEUED = 0,
    BG_JOB_STATE_CONNECTING = 1,
    BG_JOB_STATE_TRANSFERRING = 2,
    BG_JOB_STATE_SUSPENDED = 3,
    BG_JOB_STATE_ERROR = 4,
    BG_JOB_STATE_TRANSIENT_ERROR = 5,
    BG_JOB_STATE_TRANSFERRED = 6,
    BG_JOB_STATE_ACKNOWLEDGED = 7,
    BG_JOB_STATE_CANCELLED = 8,
}

enum BG_JOB_TYPE
{
    BG_JOB_TYPE_DOWNLOAD = 0,
    BG_JOB_TYPE_UPLOAD = 1,
    BG_JOB_TYPE_UPLOAD_REPLY = 2,
}

enum BG_JOB_PROXY_USAGE
{
    BG_JOB_PROXY_USAGE_PRECONFIG = 0,
    BG_JOB_PROXY_USAGE_NO_PROXY = 1,
    BG_JOB_PROXY_USAGE_OVERRIDE = 2,
    BG_JOB_PROXY_USAGE_AUTODETECT = 3,
}

const GUID IID_IBackgroundCopyJob = {0x37668D37, 0x507E, 0x4160, [0x93, 0x16, 0x26, 0x30, 0x6D, 0x15, 0x0B, 0x12]};
@GUID(0x37668D37, 0x507E, 0x4160, [0x93, 0x16, 0x26, 0x30, 0x6D, 0x15, 0x0B, 0x12]);
interface IBackgroundCopyJob : IUnknown
{
    HRESULT AddFileSet(uint cFileCount, char* pFileSet);
    HRESULT AddFile(const(wchar)* RemoteUrl, const(wchar)* LocalName);
    HRESULT EnumFiles(IEnumBackgroundCopyFiles* pEnum);
    HRESULT Suspend();
    HRESULT Resume();
    HRESULT Cancel();
    HRESULT Complete();
    HRESULT GetId(Guid* pVal);
    HRESULT GetType(BG_JOB_TYPE* pVal);
    HRESULT GetProgress(BG_JOB_PROGRESS* pVal);
    HRESULT GetTimes(BG_JOB_TIMES* pVal);
    HRESULT GetState(BG_JOB_STATE* pVal);
    HRESULT GetError(IBackgroundCopyError* ppError);
    HRESULT GetOwner(ushort** pVal);
    HRESULT SetDisplayName(const(wchar)* Val);
    HRESULT GetDisplayName(ushort** pVal);
    HRESULT SetDescription(const(wchar)* Val);
    HRESULT GetDescription(ushort** pVal);
    HRESULT SetPriority(BG_JOB_PRIORITY Val);
    HRESULT GetPriority(BG_JOB_PRIORITY* pVal);
    HRESULT SetNotifyFlags(uint Val);
    HRESULT GetNotifyFlags(uint* pVal);
    HRESULT SetNotifyInterface(IUnknown Val);
    HRESULT GetNotifyInterface(IUnknown* pVal);
    HRESULT SetMinimumRetryDelay(uint Seconds);
    HRESULT GetMinimumRetryDelay(uint* Seconds);
    HRESULT SetNoProgressTimeout(uint Seconds);
    HRESULT GetNoProgressTimeout(uint* Seconds);
    HRESULT GetErrorCount(uint* Errors);
    HRESULT SetProxySettings(BG_JOB_PROXY_USAGE ProxyUsage, const(wchar)* ProxyList, const(wchar)* ProxyBypassList);
    HRESULT GetProxySettings(BG_JOB_PROXY_USAGE* pProxyUsage, ushort** pProxyList, ushort** pProxyBypassList);
    HRESULT TakeOwnership();
}

const GUID IID_IEnumBackgroundCopyJobs = {0x1AF4F612, 0x3B71, 0x466F, [0x8F, 0x58, 0x7B, 0x6F, 0x73, 0xAC, 0x57, 0xAD]};
@GUID(0x1AF4F612, 0x3B71, 0x466F, [0x8F, 0x58, 0x7B, 0x6F, 0x73, 0xAC, 0x57, 0xAD]);
interface IEnumBackgroundCopyJobs : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumBackgroundCopyJobs* ppenum);
    HRESULT GetCount(uint* puCount);
}

const GUID IID_IBackgroundCopyCallback = {0x97EA99C7, 0x0186, 0x4AD4, [0x8D, 0xF9, 0xC5, 0xB4, 0xE0, 0xED, 0x6B, 0x22]};
@GUID(0x97EA99C7, 0x0186, 0x4AD4, [0x8D, 0xF9, 0xC5, 0xB4, 0xE0, 0xED, 0x6B, 0x22]);
interface IBackgroundCopyCallback : IUnknown
{
    HRESULT JobTransferred(IBackgroundCopyJob pJob);
    HRESULT JobError(IBackgroundCopyJob pJob, IBackgroundCopyError pError);
    HRESULT JobModification(IBackgroundCopyJob pJob, uint dwReserved);
}

const GUID IID_AsyncIBackgroundCopyCallback = {0xCA29D251, 0xB4BB, 0x4679, [0xA3, 0xD9, 0xAE, 0x80, 0x06, 0x11, 0x9D, 0x54]};
@GUID(0xCA29D251, 0xB4BB, 0x4679, [0xA3, 0xD9, 0xAE, 0x80, 0x06, 0x11, 0x9D, 0x54]);
interface AsyncIBackgroundCopyCallback : IUnknown
{
    HRESULT Begin_JobTransferred(IBackgroundCopyJob pJob);
    HRESULT Finish_JobTransferred();
    HRESULT Begin_JobError(IBackgroundCopyJob pJob, IBackgroundCopyError pError);
    HRESULT Finish_JobError();
    HRESULT Begin_JobModification(IBackgroundCopyJob pJob, uint dwReserved);
    HRESULT Finish_JobModification();
}

const GUID IID_IBackgroundCopyManager = {0x5CE34C0D, 0x0DC9, 0x4C1F, [0x89, 0x7C, 0xDA, 0xA1, 0xB7, 0x8C, 0xEE, 0x7C]};
@GUID(0x5CE34C0D, 0x0DC9, 0x4C1F, [0x89, 0x7C, 0xDA, 0xA1, 0xB7, 0x8C, 0xEE, 0x7C]);
interface IBackgroundCopyManager : IUnknown
{
    HRESULT CreateJob(const(wchar)* DisplayName, BG_JOB_TYPE Type, Guid* pJobId, IBackgroundCopyJob* ppJob);
    HRESULT GetJobA(const(Guid)* jobID, IBackgroundCopyJob* ppJob);
    HRESULT EnumJobsA(uint dwFlags, IEnumBackgroundCopyJobs* ppEnum);
    HRESULT GetErrorDescription(HRESULT hResult, uint LanguageId, ushort** pErrorDescription);
}

const GUID CLSID_BackgroundCopyManager1_5 = {0xF087771F, 0xD74F, 0x4C1A, [0xBB, 0x8A, 0xE1, 0x6A, 0xCA, 0x91, 0x24, 0xEA]};
@GUID(0xF087771F, 0xD74F, 0x4C1A, [0xBB, 0x8A, 0xE1, 0x6A, 0xCA, 0x91, 0x24, 0xEA]);
struct BackgroundCopyManager1_5;

struct BG_JOB_REPLY_PROGRESS
{
    ulong BytesTotal;
    ulong BytesTransferred;
}

enum BG_AUTH_TARGET
{
    BG_AUTH_TARGET_SERVER = 1,
    BG_AUTH_TARGET_PROXY = 2,
}

enum BG_AUTH_SCHEME
{
    BG_AUTH_SCHEME_BASIC = 1,
    BG_AUTH_SCHEME_DIGEST = 2,
    BG_AUTH_SCHEME_NTLM = 3,
    BG_AUTH_SCHEME_NEGOTIATE = 4,
    BG_AUTH_SCHEME_PASSPORT = 5,
}

struct BG_BASIC_CREDENTIALS
{
    const(wchar)* UserName;
    const(wchar)* Password;
}

struct BG_AUTH_CREDENTIALS_UNION
{
    BG_BASIC_CREDENTIALS Basic;
}

struct BG_AUTH_CREDENTIALS
{
    BG_AUTH_TARGET Target;
    BG_AUTH_SCHEME Scheme;
    BG_AUTH_CREDENTIALS_UNION Credentials;
}

const GUID IID_IBackgroundCopyJob2 = {0x54B50739, 0x686F, 0x45EB, [0x9D, 0xFF, 0xD6, 0xA9, 0xA0, 0xFA, 0xA9, 0xAF]};
@GUID(0x54B50739, 0x686F, 0x45EB, [0x9D, 0xFF, 0xD6, 0xA9, 0xA0, 0xFA, 0xA9, 0xAF]);
interface IBackgroundCopyJob2 : IBackgroundCopyJob
{
    HRESULT SetNotifyCmdLine(const(wchar)* Program, const(wchar)* Parameters);
    HRESULT GetNotifyCmdLine(ushort** pProgram, ushort** pParameters);
    HRESULT GetReplyProgress(BG_JOB_REPLY_PROGRESS* pProgress);
    HRESULT GetReplyData(char* ppBuffer, ulong* pLength);
    HRESULT SetReplyFileName(const(wchar)* ReplyFileName);
    HRESULT GetReplyFileName(ushort** pReplyFileName);
    HRESULT SetCredentials(BG_AUTH_CREDENTIALS* credentials);
    HRESULT RemoveCredentials(BG_AUTH_TARGET Target, BG_AUTH_SCHEME Scheme);
}

const GUID CLSID_BackgroundCopyManager2_0 = {0x6D18AD12, 0xBDE3, 0x4393, [0xB3, 0x11, 0x09, 0x9C, 0x34, 0x6E, 0x6D, 0xF9]};
@GUID(0x6D18AD12, 0xBDE3, 0x4393, [0xB3, 0x11, 0x09, 0x9C, 0x34, 0x6E, 0x6D, 0xF9]);
struct BackgroundCopyManager2_0;

struct BG_FILE_RANGE
{
    ulong InitialOffset;
    ulong Length;
}

const GUID IID_IBackgroundCopyJob3 = {0x443C8934, 0x90FF, 0x48ED, [0xBC, 0xDE, 0x26, 0xF5, 0xC7, 0x45, 0x00, 0x42]};
@GUID(0x443C8934, 0x90FF, 0x48ED, [0xBC, 0xDE, 0x26, 0xF5, 0xC7, 0x45, 0x00, 0x42]);
interface IBackgroundCopyJob3 : IBackgroundCopyJob2
{
    HRESULT ReplaceRemotePrefix(const(wchar)* OldPrefix, const(wchar)* NewPrefix);
    HRESULT AddFileWithRanges(const(wchar)* RemoteUrl, const(wchar)* LocalName, uint RangeCount, char* Ranges);
    HRESULT SetFileACLFlags(uint Flags);
    HRESULT GetFileACLFlags(uint* Flags);
}

const GUID IID_IBackgroundCopyFile2 = {0x83E81B93, 0x0873, 0x474D, [0x8A, 0x8C, 0xF2, 0x01, 0x8B, 0x1A, 0x93, 0x9C]};
@GUID(0x83E81B93, 0x0873, 0x474D, [0x8A, 0x8C, 0xF2, 0x01, 0x8B, 0x1A, 0x93, 0x9C]);
interface IBackgroundCopyFile2 : IBackgroundCopyFile
{
    HRESULT GetFileRanges(uint* RangeCount, char* Ranges);
    HRESULT SetRemoteName(const(wchar)* Val);
}

const GUID CLSID_BackgroundCopyManager2_5 = {0x03CA98D6, 0xFF5D, 0x49B8, [0xAB, 0xC6, 0x03, 0xDD, 0x84, 0x12, 0x70, 0x20]};
@GUID(0x03CA98D6, 0xFF5D, 0x49B8, [0xAB, 0xC6, 0x03, 0xDD, 0x84, 0x12, 0x70, 0x20]);
struct BackgroundCopyManager2_5;

enum BG_CERT_STORE_LOCATION
{
    BG_CERT_STORE_LOCATION_CURRENT_USER = 0,
    BG_CERT_STORE_LOCATION_LOCAL_MACHINE = 1,
    BG_CERT_STORE_LOCATION_CURRENT_SERVICE = 2,
    BG_CERT_STORE_LOCATION_SERVICES = 3,
    BG_CERT_STORE_LOCATION_USERS = 4,
    BG_CERT_STORE_LOCATION_CURRENT_USER_GROUP_POLICY = 5,
    BG_CERT_STORE_LOCATION_LOCAL_MACHINE_GROUP_POLICY = 6,
    BG_CERT_STORE_LOCATION_LOCAL_MACHINE_ENTERPRISE = 7,
}

const GUID IID_IBackgroundCopyJobHttpOptions = {0xF1BD1079, 0x9F01, 0x4BDC, [0x80, 0x36, 0xF0, 0x9B, 0x70, 0x09, 0x50, 0x66]};
@GUID(0xF1BD1079, 0x9F01, 0x4BDC, [0x80, 0x36, 0xF0, 0x9B, 0x70, 0x09, 0x50, 0x66]);
interface IBackgroundCopyJobHttpOptions : IUnknown
{
    HRESULT SetClientCertificateByID(BG_CERT_STORE_LOCATION StoreLocation, const(wchar)* StoreName, char* pCertHashBlob);
    HRESULT SetClientCertificateByName(BG_CERT_STORE_LOCATION StoreLocation, const(wchar)* StoreName, const(wchar)* SubjectName);
    HRESULT RemoveClientCertificate();
    HRESULT GetClientCertificate(BG_CERT_STORE_LOCATION* pStoreLocation, ushort** pStoreName, char* ppCertHashBlob, ushort** pSubjectName);
    HRESULT SetCustomHeaders(const(wchar)* RequestHeaders);
    HRESULT GetCustomHeaders(ushort** pRequestHeaders);
    HRESULT SetSecurityFlags(uint Flags);
    HRESULT GetSecurityFlags(uint* pFlags);
}

const GUID CLSID_BackgroundCopyManager3_0 = {0x659CDEA7, 0x489E, 0x11D9, [0xA9, 0xCD, 0x00, 0x0D, 0x56, 0x96, 0x52, 0x51]};
@GUID(0x659CDEA7, 0x489E, 0x11D9, [0xA9, 0xCD, 0x00, 0x0D, 0x56, 0x96, 0x52, 0x51]);
struct BackgroundCopyManager3_0;

const GUID IID_IBitsPeerCacheRecord = {0x659CDEAF, 0x489E, 0x11D9, [0xA9, 0xCD, 0x00, 0x0D, 0x56, 0x96, 0x52, 0x51]};
@GUID(0x659CDEAF, 0x489E, 0x11D9, [0xA9, 0xCD, 0x00, 0x0D, 0x56, 0x96, 0x52, 0x51]);
interface IBitsPeerCacheRecord : IUnknown
{
    HRESULT GetId(Guid* pVal);
    HRESULT GetOriginUrl(ushort** pVal);
    HRESULT GetFileSize(ulong* pVal);
    HRESULT GetFileModificationTime(FILETIME* pVal);
    HRESULT GetLastAccessTime(FILETIME* pVal);
    HRESULT IsFileValidated();
    HRESULT GetFileRanges(uint* pRangeCount, char* ppRanges);
}

const GUID IID_IEnumBitsPeerCacheRecords = {0x659CDEA4, 0x489E, 0x11D9, [0xA9, 0xCD, 0x00, 0x0D, 0x56, 0x96, 0x52, 0x51]};
@GUID(0x659CDEA4, 0x489E, 0x11D9, [0xA9, 0xCD, 0x00, 0x0D, 0x56, 0x96, 0x52, 0x51]);
interface IEnumBitsPeerCacheRecords : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumBitsPeerCacheRecords* ppenum);
    HRESULT GetCount(uint* puCount);
}

const GUID IID_IBitsPeer = {0x659CDEA2, 0x489E, 0x11D9, [0xA9, 0xCD, 0x00, 0x0D, 0x56, 0x96, 0x52, 0x51]};
@GUID(0x659CDEA2, 0x489E, 0x11D9, [0xA9, 0xCD, 0x00, 0x0D, 0x56, 0x96, 0x52, 0x51]);
interface IBitsPeer : IUnknown
{
    HRESULT GetPeerName(ushort** pName);
    HRESULT IsAuthenticated(int* pAuth);
    HRESULT IsAvailable(int* pOnline);
}

const GUID IID_IEnumBitsPeers = {0x659CDEA5, 0x489E, 0x11D9, [0xA9, 0xCD, 0x00, 0x0D, 0x56, 0x96, 0x52, 0x51]};
@GUID(0x659CDEA5, 0x489E, 0x11D9, [0xA9, 0xCD, 0x00, 0x0D, 0x56, 0x96, 0x52, 0x51]);
interface IEnumBitsPeers : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumBitsPeers* ppenum);
    HRESULT GetCount(uint* puCount);
}

const GUID IID_IBitsPeerCacheAdministration = {0x659CDEAD, 0x489E, 0x11D9, [0xA9, 0xCD, 0x00, 0x0D, 0x56, 0x96, 0x52, 0x51]};
@GUID(0x659CDEAD, 0x489E, 0x11D9, [0xA9, 0xCD, 0x00, 0x0D, 0x56, 0x96, 0x52, 0x51]);
interface IBitsPeerCacheAdministration : IUnknown
{
    HRESULT GetMaximumCacheSize(uint* pBytes);
    HRESULT SetMaximumCacheSize(uint Bytes);
    HRESULT GetMaximumContentAge(uint* pSeconds);
    HRESULT SetMaximumContentAge(uint Seconds);
    HRESULT GetConfigurationFlags(uint* pFlags);
    HRESULT SetConfigurationFlags(uint Flags);
    HRESULT EnumRecords(IEnumBitsPeerCacheRecords* ppEnum);
    HRESULT GetRecord(const(Guid)* id, IBitsPeerCacheRecord* ppRecord);
    HRESULT ClearRecords();
    HRESULT DeleteRecord(const(Guid)* id);
    HRESULT DeleteUrl(const(wchar)* url);
    HRESULT EnumPeers(IEnumBitsPeers* ppEnum);
    HRESULT ClearPeers();
    HRESULT DiscoverPeers();
}

const GUID IID_IBackgroundCopyJob4 = {0x659CDEAE, 0x489E, 0x11D9, [0xA9, 0xCD, 0x00, 0x0D, 0x56, 0x96, 0x52, 0x51]};
@GUID(0x659CDEAE, 0x489E, 0x11D9, [0xA9, 0xCD, 0x00, 0x0D, 0x56, 0x96, 0x52, 0x51]);
interface IBackgroundCopyJob4 : IBackgroundCopyJob3
{
    HRESULT SetPeerCachingFlags(uint Flags);
    HRESULT GetPeerCachingFlags(uint* pFlags);
    HRESULT GetOwnerIntegrityLevel(uint* pLevel);
    HRESULT GetOwnerElevationState(int* pElevated);
    HRESULT SetMaximumDownloadTime(uint Timeout);
    HRESULT GetMaximumDownloadTime(uint* pTimeout);
}

const GUID IID_IBackgroundCopyFile3 = {0x659CDEAA, 0x489E, 0x11D9, [0xA9, 0xCD, 0x00, 0x0D, 0x56, 0x96, 0x52, 0x51]};
@GUID(0x659CDEAA, 0x489E, 0x11D9, [0xA9, 0xCD, 0x00, 0x0D, 0x56, 0x96, 0x52, 0x51]);
interface IBackgroundCopyFile3 : IBackgroundCopyFile2
{
    HRESULT GetTemporaryName(ushort** pFilename);
    HRESULT SetValidationState(BOOL state);
    HRESULT GetValidationState(int* pState);
    HRESULT IsDownloadedFromPeer(int* pVal);
}

const GUID IID_IBackgroundCopyCallback2 = {0x659CDEAC, 0x489E, 0x11D9, [0xA9, 0xCD, 0x00, 0x0D, 0x56, 0x96, 0x52, 0x51]};
@GUID(0x659CDEAC, 0x489E, 0x11D9, [0xA9, 0xCD, 0x00, 0x0D, 0x56, 0x96, 0x52, 0x51]);
interface IBackgroundCopyCallback2 : IBackgroundCopyCallback
{
    HRESULT FileTransferred(IBackgroundCopyJob pJob, IBackgroundCopyFile pFile);
}

const GUID CLSID_BackgroundCopyManager4_0 = {0xBB6DF56B, 0xCACE, 0x11DC, [0x99, 0x92, 0x00, 0x19, 0xB9, 0x3A, 0x3A, 0x84]};
@GUID(0xBB6DF56B, 0xCACE, 0x11DC, [0x99, 0x92, 0x00, 0x19, 0xB9, 0x3A, 0x3A, 0x84]);
struct BackgroundCopyManager4_0;

const GUID IID_IBitsTokenOptions = {0x9A2584C3, 0xF7D2, 0x457A, [0x9A, 0x5E, 0x22, 0xB6, 0x7B, 0xFF, 0xC7, 0xD2]};
@GUID(0x9A2584C3, 0xF7D2, 0x457A, [0x9A, 0x5E, 0x22, 0xB6, 0x7B, 0xFF, 0xC7, 0xD2]);
interface IBitsTokenOptions : IUnknown
{
    HRESULT SetHelperTokenFlags(uint UsageFlags);
    HRESULT GetHelperTokenFlags(uint* pFlags);
    HRESULT SetHelperToken();
    HRESULT ClearHelperToken();
    HRESULT GetHelperTokenSid(ushort** pSid);
}

const GUID IID_IBackgroundCopyFile4 = {0xEF7E0655, 0x7888, 0x4960, [0xB0, 0xE5, 0x73, 0x08, 0x46, 0xE0, 0x34, 0x92]};
@GUID(0xEF7E0655, 0x7888, 0x4960, [0xB0, 0xE5, 0x73, 0x08, 0x46, 0xE0, 0x34, 0x92]);
interface IBackgroundCopyFile4 : IBackgroundCopyFile3
{
    HRESULT GetPeerDownloadStats(ulong* pFromOrigin, ulong* pFromPeers);
}

const GUID CLSID_BackgroundCopyManager5_0 = {0x1ECCA34C, 0xE88A, 0x44E3, [0x8D, 0x6A, 0x89, 0x21, 0xBD, 0xE9, 0xE4, 0x52]};
@GUID(0x1ECCA34C, 0xE88A, 0x44E3, [0x8D, 0x6A, 0x89, 0x21, 0xBD, 0xE9, 0xE4, 0x52]);
struct BackgroundCopyManager5_0;

enum BITS_JOB_TRANSFER_POLICY
{
    BITS_JOB_TRANSFER_POLICY_ALWAYS = -2147483393,
    BITS_JOB_TRANSFER_POLICY_NOT_ROAMING = -2147483521,
    BITS_JOB_TRANSFER_POLICY_NO_SURCHARGE = -2147483537,
    BITS_JOB_TRANSFER_POLICY_STANDARD = -2147483545,
    BITS_JOB_TRANSFER_POLICY_UNRESTRICTED = -2147483615,
}

enum BITS_JOB_PROPERTY_ID
{
    BITS_JOB_PROPERTY_ID_COST_FLAGS = 1,
    BITS_JOB_PROPERTY_NOTIFICATION_CLSID = 2,
    BITS_JOB_PROPERTY_DYNAMIC_CONTENT = 3,
    BITS_JOB_PROPERTY_HIGH_PERFORMANCE = 4,
    BITS_JOB_PROPERTY_MAX_DOWNLOAD_SIZE = 5,
    BITS_JOB_PROPERTY_USE_STORED_CREDENTIALS = 7,
    BITS_JOB_PROPERTY_MINIMUM_NOTIFICATION_INTERVAL_MS = 9,
    BITS_JOB_PROPERTY_ON_DEMAND_MODE = 10,
}

struct BITS_JOB_PROPERTY_VALUE
{
    uint Dword;
    Guid ClsID;
    BOOL Enable;
    ulong Uint64;
    BG_AUTH_TARGET Target;
}

enum BITS_FILE_PROPERTY_ID
{
    BITS_FILE_PROPERTY_ID_HTTP_RESPONSE_HEADERS = 1,
}

struct BITS_FILE_PROPERTY_VALUE
{
    const(wchar)* String;
}

const GUID IID_IBackgroundCopyJob5 = {0xE847030C, 0xBBBA, 0x4657, [0xAF, 0x6D, 0x48, 0x4A, 0xA4, 0x2B, 0xF1, 0xFE]};
@GUID(0xE847030C, 0xBBBA, 0x4657, [0xAF, 0x6D, 0x48, 0x4A, 0xA4, 0x2B, 0xF1, 0xFE]);
interface IBackgroundCopyJob5 : IBackgroundCopyJob4
{
    HRESULT SetProperty(BITS_JOB_PROPERTY_ID PropertyId, BITS_JOB_PROPERTY_VALUE PropertyValue);
    HRESULT GetProperty(BITS_JOB_PROPERTY_ID PropertyId, BITS_JOB_PROPERTY_VALUE* PropertyValue);
}

const GUID IID_IBackgroundCopyFile5 = {0x85C1657F, 0xDAFC, 0x40E8, [0x88, 0x34, 0xDF, 0x18, 0xEA, 0x25, 0x71, 0x7E]};
@GUID(0x85C1657F, 0xDAFC, 0x40E8, [0x88, 0x34, 0xDF, 0x18, 0xEA, 0x25, 0x71, 0x7E]);
interface IBackgroundCopyFile5 : IBackgroundCopyFile4
{
    HRESULT SetProperty(BITS_FILE_PROPERTY_ID PropertyId, BITS_FILE_PROPERTY_VALUE PropertyValue);
    HRESULT GetProperty(BITS_FILE_PROPERTY_ID PropertyId, BITS_FILE_PROPERTY_VALUE* PropertyValue);
}

const GUID CLSID_BackgroundCopyManager10_1 = {0x4BD3E4E1, 0x7BD4, 0x4A2B, [0x99, 0x64, 0x49, 0x64, 0x00, 0xDE, 0x51, 0x93]};
@GUID(0x4BD3E4E1, 0x7BD4, 0x4A2B, [0x99, 0x64, 0x49, 0x64, 0x00, 0xDE, 0x51, 0x93]);
struct BackgroundCopyManager10_1;

const GUID IID_IBackgroundCopyCallback3 = {0x98C97BD2, 0xE32B, 0x4AD8, [0xA5, 0x28, 0x95, 0xFD, 0x8B, 0x16, 0xBD, 0x42]};
@GUID(0x98C97BD2, 0xE32B, 0x4AD8, [0xA5, 0x28, 0x95, 0xFD, 0x8B, 0x16, 0xBD, 0x42]);
interface IBackgroundCopyCallback3 : IBackgroundCopyCallback2
{
    HRESULT FileRangesTransferred(IBackgroundCopyJob job, IBackgroundCopyFile file, uint rangeCount, char* ranges);
}

const GUID IID_IBackgroundCopyFile6 = {0xCF6784F7, 0xD677, 0x49FD, [0x93, 0x68, 0xCB, 0x47, 0xAE, 0xE9, 0xD1, 0xAD]};
@GUID(0xCF6784F7, 0xD677, 0x49FD, [0x93, 0x68, 0xCB, 0x47, 0xAE, 0xE9, 0xD1, 0xAD]);
interface IBackgroundCopyFile6 : IBackgroundCopyFile5
{
    HRESULT UpdateDownloadPosition(ulong offset);
    HRESULT RequestFileRanges(uint rangeCount, char* ranges);
    HRESULT GetFilledFileRanges(uint* rangeCount, char* ranges);
}

const GUID CLSID_BackgroundCopyManager10_2 = {0x4575438F, 0xA6C8, 0x4976, [0xB0, 0xFE, 0x2F, 0x26, 0xB8, 0x0D, 0x95, 0x9E]};
@GUID(0x4575438F, 0xA6C8, 0x4976, [0xB0, 0xFE, 0x2F, 0x26, 0xB8, 0x0D, 0x95, 0x9E]);
struct BackgroundCopyManager10_2;

const GUID IID_IBackgroundCopyJobHttpOptions2 = {0xB591A192, 0xA405, 0x4FC3, [0x83, 0x23, 0x4C, 0x5C, 0x54, 0x25, 0x78, 0xFC]};
@GUID(0xB591A192, 0xA405, 0x4FC3, [0x83, 0x23, 0x4C, 0x5C, 0x54, 0x25, 0x78, 0xFC]);
interface IBackgroundCopyJobHttpOptions2 : IBackgroundCopyJobHttpOptions
{
    HRESULT SetHttpMethod(const(wchar)* method);
    HRESULT GetHttpMethod(ushort** method);
}

const GUID CLSID_BackgroundCopyManager10_3 = {0x5FD42AD5, 0xC04E, 0x4D36, [0xAD, 0xC7, 0xE0, 0x8F, 0xF1, 0x57, 0x37, 0xAD]};
@GUID(0x5FD42AD5, 0xC04E, 0x4D36, [0xAD, 0xC7, 0xE0, 0x8F, 0xF1, 0x57, 0x37, 0xAD]);
struct BackgroundCopyManager10_3;

const GUID IID_IBackgroundCopyServerCertificateValidationCallback = {0x4CEC0D02, 0xDEF7, 0x4158, [0x81, 0x3A, 0xC3, 0x2A, 0x46, 0x94, 0x5F, 0xF7]};
@GUID(0x4CEC0D02, 0xDEF7, 0x4158, [0x81, 0x3A, 0xC3, 0x2A, 0x46, 0x94, 0x5F, 0xF7]);
interface IBackgroundCopyServerCertificateValidationCallback : IUnknown
{
    HRESULT ValidateServerCertificate(IBackgroundCopyJob job, IBackgroundCopyFile file, uint certLength, char* certData, uint certEncodingType, uint certStoreLength, char* certStoreData);
}

const GUID IID_IBackgroundCopyJobHttpOptions3 = {0x8A9263D3, 0xFD4C, 0x4EDA, [0x9B, 0x28, 0x30, 0x13, 0x2A, 0x4D, 0x4E, 0x3C]};
@GUID(0x8A9263D3, 0xFD4C, 0x4EDA, [0x9B, 0x28, 0x30, 0x13, 0x2A, 0x4D, 0x4E, 0x3C]);
interface IBackgroundCopyJobHttpOptions3 : IBackgroundCopyJobHttpOptions2
{
    HRESULT SetServerCertificateValidationInterface(IUnknown certValidationCallback);
    HRESULT MakeCustomHeadersWriteOnly();
}

const GUID CLSID_BITSExtensionSetupFactory = {0xEFBBAB68, 0x7286, 0x4783, [0x94, 0xBF, 0x94, 0x61, 0xD8, 0xB7, 0xE7, 0xE9]};
@GUID(0xEFBBAB68, 0x7286, 0x4783, [0x94, 0xBF, 0x94, 0x61, 0xD8, 0xB7, 0xE7, 0xE9]);
struct BITSExtensionSetupFactory;

const GUID IID_IBITSExtensionSetup = {0x29CFBBF7, 0x09E4, 0x4B97, [0xB0, 0xBC, 0xF2, 0x28, 0x7E, 0x3D, 0x8E, 0xB3]};
@GUID(0x29CFBBF7, 0x09E4, 0x4B97, [0xB0, 0xBC, 0xF2, 0x28, 0x7E, 0x3D, 0x8E, 0xB3]);
interface IBITSExtensionSetup : IDispatch
{
    HRESULT EnableBITSUploads();
    HRESULT DisableBITSUploads();
    HRESULT GetCleanupTaskName(BSTR* pTaskName);
    HRESULT GetCleanupTask(const(Guid)* riid, IUnknown* ppUnk);
}

const GUID IID_IBITSExtensionSetupFactory = {0xD5D2D542, 0x5503, 0x4E64, [0x8B, 0x48, 0x72, 0xEF, 0x91, 0xA3, 0x2E, 0xE1]};
@GUID(0xD5D2D542, 0x5503, 0x4E64, [0x8B, 0x48, 0x72, 0xEF, 0x91, 0xA3, 0x2E, 0xE1]);
interface IBITSExtensionSetupFactory : IDispatch
{
    HRESULT GetObjectA(BSTR Path, IBITSExtensionSetup* ppExtensionSetup);
}

const GUID CLSID_BackgroundCopyQMgr = {0x69AD4AEE, 0x51BE, 0x439B, [0xA9, 0x2C, 0x86, 0xAE, 0x49, 0x0E, 0x8B, 0x30]};
@GUID(0x69AD4AEE, 0x51BE, 0x439B, [0xA9, 0x2C, 0x86, 0xAE, 0x49, 0x0E, 0x8B, 0x30]);
struct BackgroundCopyQMgr;

struct FILESETINFO
{
    BSTR bstrRemoteFile;
    BSTR bstrLocalFile;
    uint dwSizeHint;
}

const GUID IID_IBackgroundCopyJob1 = {0x59F5553C, 0x2031, 0x4629, [0xBB, 0x18, 0x26, 0x45, 0xA6, 0x97, 0x09, 0x47]};
@GUID(0x59F5553C, 0x2031, 0x4629, [0xBB, 0x18, 0x26, 0x45, 0xA6, 0x97, 0x09, 0x47]);
interface IBackgroundCopyJob1 : IUnknown
{
    HRESULT CancelJob();
    HRESULT GetProgress(uint dwFlags, uint* pdwProgress);
    HRESULT GetStatus(uint* pdwStatus, uint* pdwWin32Result, uint* pdwTransportResult, uint* pdwNumOfRetries);
    HRESULT AddFiles(uint cFileCount, char* ppFileSet);
    HRESULT GetFile(uint cFileIndex, FILESETINFO* pFileInfo);
    HRESULT GetFileCount(uint* pdwFileCount);
    HRESULT SwitchToForeground();
    HRESULT get_JobID(Guid* pguidJobID);
}

const GUID IID_IEnumBackgroundCopyJobs1 = {0x8BAEBA9D, 0x8F1C, 0x42C4, [0xB8, 0x2C, 0x09, 0xAE, 0x79, 0x98, 0x0D, 0x25]};
@GUID(0x8BAEBA9D, 0x8F1C, 0x42C4, [0xB8, 0x2C, 0x09, 0xAE, 0x79, 0x98, 0x0D, 0x25]);
interface IEnumBackgroundCopyJobs1 : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumBackgroundCopyJobs1* ppenum);
    HRESULT GetCount(uint* puCount);
}

enum GROUPPROP
{
    GROUPPROP_PRIORITY = 0,
    GROUPPROP_REMOTEUSERID = 1,
    GROUPPROP_REMOTEUSERPWD = 2,
    GROUPPROP_LOCALUSERID = 3,
    GROUPPROP_LOCALUSERPWD = 4,
    GROUPPROP_PROTOCOLFLAGS = 5,
    GROUPPROP_NOTIFYFLAGS = 6,
    GROUPPROP_NOTIFYCLSID = 7,
    GROUPPROP_PROGRESSSIZE = 8,
    GROUPPROP_PROGRESSPERCENT = 9,
    GROUPPROP_PROGRESSTIME = 10,
    GROUPPROP_DISPLAYNAME = 11,
    GROUPPROP_DESCRIPTION = 12,
}

const GUID IID_IBackgroundCopyGroup = {0x1DED80A7, 0x53EA, 0x424F, [0x8A, 0x04, 0x17, 0xFE, 0xA9, 0xAD, 0xC4, 0xF5]};
@GUID(0x1DED80A7, 0x53EA, 0x424F, [0x8A, 0x04, 0x17, 0xFE, 0xA9, 0xAD, 0xC4, 0xF5]);
interface IBackgroundCopyGroup : IUnknown
{
    HRESULT GetPropA(GROUPPROP propID, VARIANT* pvarVal);
    HRESULT SetPropA(GROUPPROP propID, VARIANT* pvarVal);
    HRESULT GetProgress(uint dwFlags, uint* pdwProgress);
    HRESULT GetStatus(uint* pdwStatus, uint* pdwJobIndex);
    HRESULT GetJobA(Guid jobID, IBackgroundCopyJob1* ppJob);
    HRESULT SuspendGroup();
    HRESULT ResumeGroup();
    HRESULT CancelGroup();
    HRESULT get_Size(uint* pdwSize);
    HRESULT get_GroupID(Guid* pguidGroupID);
    HRESULT CreateJob(Guid guidJobID, IBackgroundCopyJob1* ppJob);
    HRESULT EnumJobsA(uint dwFlags, IEnumBackgroundCopyJobs1* ppEnumJobs);
    HRESULT SwitchToForeground();
    HRESULT QueryNewJobInterface(const(Guid)* iid, IUnknown* pUnk);
    HRESULT SetNotificationPointer(const(Guid)* iid, IUnknown pUnk);
}

const GUID IID_IEnumBackgroundCopyGroups = {0xD993E603, 0x4AA4, 0x47C5, [0x86, 0x65, 0xC2, 0x0D, 0x39, 0xC2, 0xBA, 0x4F]};
@GUID(0xD993E603, 0x4AA4, 0x47C5, [0x86, 0x65, 0xC2, 0x0D, 0x39, 0xC2, 0xBA, 0x4F]);
interface IEnumBackgroundCopyGroups : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumBackgroundCopyGroups* ppenum);
    HRESULT GetCount(uint* puCount);
}

const GUID IID_IBackgroundCopyCallback1 = {0x084F6593, 0x3800, 0x4E08, [0x9B, 0x59, 0x99, 0xFA, 0x59, 0xAD, 0xDF, 0x82]};
@GUID(0x084F6593, 0x3800, 0x4E08, [0x9B, 0x59, 0x99, 0xFA, 0x59, 0xAD, 0xDF, 0x82]);
interface IBackgroundCopyCallback1 : IUnknown
{
    HRESULT OnStatus(IBackgroundCopyGroup pGroup, IBackgroundCopyJob1 pJob, uint dwFileIndex, uint dwStatus, uint dwNumOfRetries, uint dwWin32Result, uint dwTransportResult);
    HRESULT OnProgress(uint ProgressType, IBackgroundCopyGroup pGroup, IBackgroundCopyJob1 pJob, uint dwFileIndex, uint dwProgressValue);
    HRESULT OnProgressEx(uint ProgressType, IBackgroundCopyGroup pGroup, IBackgroundCopyJob1 pJob, uint dwFileIndex, uint dwProgressValue, uint dwByteArraySize, char* pByte);
}

const GUID IID_IBackgroundCopyQMgr = {0x16F41C69, 0x09F5, 0x41D2, [0x8C, 0xD8, 0x3C, 0x08, 0xC4, 0x7B, 0xC8, 0xA8]};
@GUID(0x16F41C69, 0x09F5, 0x41D2, [0x8C, 0xD8, 0x3C, 0x08, 0xC4, 0x7B, 0xC8, 0xA8]);
interface IBackgroundCopyQMgr : IUnknown
{
    HRESULT CreateGroup(Guid guidGroupID, IBackgroundCopyGroup* ppGroup);
    HRESULT GetGroup(Guid groupID, IBackgroundCopyGroup* ppGroup);
    HRESULT EnumGroups(uint dwFlags, IEnumBackgroundCopyGroups* ppEnumGroups);
}

