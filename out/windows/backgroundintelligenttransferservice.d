module windows.backgroundintelligenttransferservice;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


enum : int
{
    BG_ERROR_CONTEXT_NONE                        = 0x00000000,
    BG_ERROR_CONTEXT_UNKNOWN                     = 0x00000001,
    BG_ERROR_CONTEXT_GENERAL_QUEUE_MANAGER       = 0x00000002,
    BG_ERROR_CONTEXT_QUEUE_MANAGER_NOTIFICATION  = 0x00000003,
    BG_ERROR_CONTEXT_LOCAL_FILE                  = 0x00000004,
    BG_ERROR_CONTEXT_REMOTE_FILE                 = 0x00000005,
    BG_ERROR_CONTEXT_GENERAL_TRANSPORT           = 0x00000006,
    BG_ERROR_CONTEXT_REMOTE_APPLICATION          = 0x00000007,
    BG_ERROR_CONTEXT_SERVER_CERTIFICATE_CALLBACK = 0x00000008,
}
alias BG_ERROR_CONTEXT = int;

enum : int
{
    BG_JOB_PRIORITY_FOREGROUND = 0x00000000,
    BG_JOB_PRIORITY_HIGH       = 0x00000001,
    BG_JOB_PRIORITY_NORMAL     = 0x00000002,
    BG_JOB_PRIORITY_LOW        = 0x00000003,
}
alias BG_JOB_PRIORITY = int;

enum : int
{
    BG_JOB_STATE_QUEUED          = 0x00000000,
    BG_JOB_STATE_CONNECTING      = 0x00000001,
    BG_JOB_STATE_TRANSFERRING    = 0x00000002,
    BG_JOB_STATE_SUSPENDED       = 0x00000003,
    BG_JOB_STATE_ERROR           = 0x00000004,
    BG_JOB_STATE_TRANSIENT_ERROR = 0x00000005,
    BG_JOB_STATE_TRANSFERRED     = 0x00000006,
    BG_JOB_STATE_ACKNOWLEDGED    = 0x00000007,
    BG_JOB_STATE_CANCELLED       = 0x00000008,
}
alias BG_JOB_STATE = int;

enum : int
{
    BG_JOB_TYPE_DOWNLOAD     = 0x00000000,
    BG_JOB_TYPE_UPLOAD       = 0x00000001,
    BG_JOB_TYPE_UPLOAD_REPLY = 0x00000002,
}
alias BG_JOB_TYPE = int;

enum : int
{
    BG_JOB_PROXY_USAGE_PRECONFIG  = 0x00000000,
    BG_JOB_PROXY_USAGE_NO_PROXY   = 0x00000001,
    BG_JOB_PROXY_USAGE_OVERRIDE   = 0x00000002,
    BG_JOB_PROXY_USAGE_AUTODETECT = 0x00000003,
}
alias BG_JOB_PROXY_USAGE = int;

enum : int
{
    BG_AUTH_TARGET_SERVER = 0x00000001,
    BG_AUTH_TARGET_PROXY  = 0x00000002,
}
alias BG_AUTH_TARGET = int;

enum : int
{
    BG_AUTH_SCHEME_BASIC     = 0x00000001,
    BG_AUTH_SCHEME_DIGEST    = 0x00000002,
    BG_AUTH_SCHEME_NTLM      = 0x00000003,
    BG_AUTH_SCHEME_NEGOTIATE = 0x00000004,
    BG_AUTH_SCHEME_PASSPORT  = 0x00000005,
}
alias BG_AUTH_SCHEME = int;

enum : int
{
    BG_CERT_STORE_LOCATION_CURRENT_USER               = 0x00000000,
    BG_CERT_STORE_LOCATION_LOCAL_MACHINE              = 0x00000001,
    BG_CERT_STORE_LOCATION_CURRENT_SERVICE            = 0x00000002,
    BG_CERT_STORE_LOCATION_SERVICES                   = 0x00000003,
    BG_CERT_STORE_LOCATION_USERS                      = 0x00000004,
    BG_CERT_STORE_LOCATION_CURRENT_USER_GROUP_POLICY  = 0x00000005,
    BG_CERT_STORE_LOCATION_LOCAL_MACHINE_GROUP_POLICY = 0x00000006,
    BG_CERT_STORE_LOCATION_LOCAL_MACHINE_ENTERPRISE   = 0x00000007,
}
alias BG_CERT_STORE_LOCATION = int;

enum : int
{
    BITS_JOB_TRANSFER_POLICY_ALWAYS       = 0x800000ff,
    BITS_JOB_TRANSFER_POLICY_NOT_ROAMING  = 0x8000007f,
    BITS_JOB_TRANSFER_POLICY_NO_SURCHARGE = 0x8000006f,
    BITS_JOB_TRANSFER_POLICY_STANDARD     = 0x80000067,
    BITS_JOB_TRANSFER_POLICY_UNRESTRICTED = 0x80000021,
}
alias BITS_JOB_TRANSFER_POLICY = int;

enum : int
{
    BITS_JOB_PROPERTY_ID_COST_FLAGS                    = 0x00000001,
    BITS_JOB_PROPERTY_NOTIFICATION_CLSID               = 0x00000002,
    BITS_JOB_PROPERTY_DYNAMIC_CONTENT                  = 0x00000003,
    BITS_JOB_PROPERTY_HIGH_PERFORMANCE                 = 0x00000004,
    BITS_JOB_PROPERTY_MAX_DOWNLOAD_SIZE                = 0x00000005,
    BITS_JOB_PROPERTY_USE_STORED_CREDENTIALS           = 0x00000007,
    BITS_JOB_PROPERTY_MINIMUM_NOTIFICATION_INTERVAL_MS = 0x00000009,
    BITS_JOB_PROPERTY_ON_DEMAND_MODE                   = 0x0000000a,
}
alias BITS_JOB_PROPERTY_ID = int;

enum : int
{
    BITS_FILE_PROPERTY_ID_HTTP_RESPONSE_HEADERS = 0x00000001,
}
alias BITS_FILE_PROPERTY_ID = int;

enum : int
{
    GROUPPROP_PRIORITY        = 0x00000000,
    GROUPPROP_REMOTEUSERID    = 0x00000001,
    GROUPPROP_REMOTEUSERPWD   = 0x00000002,
    GROUPPROP_LOCALUSERID     = 0x00000003,
    GROUPPROP_LOCALUSERPWD    = 0x00000004,
    GROUPPROP_PROTOCOLFLAGS   = 0x00000005,
    GROUPPROP_NOTIFYFLAGS     = 0x00000006,
    GROUPPROP_NOTIFYCLSID     = 0x00000007,
    GROUPPROP_PROGRESSSIZE    = 0x00000008,
    GROUPPROP_PROGRESSPERCENT = 0x00000009,
    GROUPPROP_PROGRESSTIME    = 0x0000000a,
    GROUPPROP_DISPLAYNAME     = 0x0000000b,
    GROUPPROP_DESCRIPTION     = 0x0000000c,
}
alias GROUPPROP = int;

// Structs


struct BG_FILE_PROGRESS
{
    ulong BytesTotal;
    ulong BytesTransferred;
    BOOL  Completed;
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
    uint  FilesTotal;
    uint  FilesTransferred;
}

struct BG_JOB_TIMES
{
    FILETIME CreationTime;
    FILETIME ModificationTime;
    FILETIME TransferCompletionTime;
}

struct BG_JOB_REPLY_PROGRESS
{
    ulong BytesTotal;
    ulong BytesTransferred;
}

struct BG_BASIC_CREDENTIALS
{
    const(wchar)* UserName;
    const(wchar)* Password;
}

union BG_AUTH_CREDENTIALS_UNION
{
    BG_BASIC_CREDENTIALS Basic;
}

struct BG_AUTH_CREDENTIALS
{
    BG_AUTH_TARGET Target;
    BG_AUTH_SCHEME Scheme;
    BG_AUTH_CREDENTIALS_UNION Credentials;
}

struct BG_FILE_RANGE
{
    ulong InitialOffset;
    ulong Length;
}

union BITS_JOB_PROPERTY_VALUE
{
    uint           Dword;
    GUID           ClsID;
    BOOL           Enable;
    ulong          Uint64;
    BG_AUTH_TARGET Target;
}

union BITS_FILE_PROPERTY_VALUE
{
    const(wchar)* String;
}

struct FILESETINFO
{
    BSTR bstrRemoteFile;
    BSTR bstrLocalFile;
    uint dwSizeHint;
}

// Interfaces

@GUID("4991D34B-80A1-4291-83B6-3328366B9097")
struct BackgroundCopyManager;

@GUID("F087771F-D74F-4C1A-BB8A-E16ACA9124EA")
struct BackgroundCopyManager1_5;

@GUID("6D18AD12-BDE3-4393-B311-099C346E6DF9")
struct BackgroundCopyManager2_0;

@GUID("03CA98D6-FF5D-49B8-ABC6-03DD84127020")
struct BackgroundCopyManager2_5;

@GUID("659CDEA7-489E-11D9-A9CD-000D56965251")
struct BackgroundCopyManager3_0;

@GUID("BB6DF56B-CACE-11DC-9992-0019B93A3A84")
struct BackgroundCopyManager4_0;

@GUID("1ECCA34C-E88A-44E3-8D6A-8921BDE9E452")
struct BackgroundCopyManager5_0;

@GUID("4BD3E4E1-7BD4-4A2B-9964-496400DE5193")
struct BackgroundCopyManager10_1;

@GUID("4575438F-A6C8-4976-B0FE-2F26B80D959E")
struct BackgroundCopyManager10_2;

@GUID("5FD42AD5-C04E-4D36-ADC7-E08FF15737AD")
struct BackgroundCopyManager10_3;

@GUID("EFBBAB68-7286-4783-94BF-9461D8B7E7E9")
struct BITSExtensionSetupFactory;

@GUID("69AD4AEE-51BE-439B-A92C-86AE490E8B30")
struct BackgroundCopyQMgr;

@GUID("01B7BD23-FB88-4A77-8490-5891D3E4653A")
interface IBackgroundCopyFile : IUnknown
{
    HRESULT GetRemoteName(ushort** pVal);
    HRESULT GetLocalName(ushort** pVal);
    HRESULT GetProgress(BG_FILE_PROGRESS* pVal);
}

@GUID("CA51E165-C365-424C-8D41-24AAA4FF3C40")
interface IEnumBackgroundCopyFiles : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumBackgroundCopyFiles* ppenum);
    HRESULT GetCount(uint* puCount);
}

@GUID("19C613A0-FCB8-4F28-81AE-897C3D078F81")
interface IBackgroundCopyError : IUnknown
{
    HRESULT GetError(BG_ERROR_CONTEXT* pContext, int* pCode);
    HRESULT GetFile(IBackgroundCopyFile* pVal);
    HRESULT GetErrorDescription(uint LanguageId, ushort** pErrorDescription);
    HRESULT GetErrorContextDescription(uint LanguageId, ushort** pContextDescription);
    HRESULT GetProtocol(ushort** pProtocol);
}

@GUID("37668D37-507E-4160-9316-26306D150B12")
interface IBackgroundCopyJob : IUnknown
{
    HRESULT AddFileSet(uint cFileCount, char* pFileSet);
    HRESULT AddFile(const(wchar)* RemoteUrl, const(wchar)* LocalName);
    HRESULT EnumFiles(IEnumBackgroundCopyFiles* pEnum);
    HRESULT Suspend();
    HRESULT Resume();
    HRESULT Cancel();
    HRESULT Complete();
    HRESULT GetId(GUID* pVal);
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

@GUID("1AF4F612-3B71-466F-8F58-7B6F73AC57AD")
interface IEnumBackgroundCopyJobs : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumBackgroundCopyJobs* ppenum);
    HRESULT GetCount(uint* puCount);
}

@GUID("97EA99C7-0186-4AD4-8DF9-C5B4E0ED6B22")
interface IBackgroundCopyCallback : IUnknown
{
    HRESULT JobTransferred(IBackgroundCopyJob pJob);
    HRESULT JobError(IBackgroundCopyJob pJob, IBackgroundCopyError pError);
    HRESULT JobModification(IBackgroundCopyJob pJob, uint dwReserved);
}

@GUID("CA29D251-B4BB-4679-A3D9-AE8006119D54")
interface AsyncIBackgroundCopyCallback : IUnknown
{
    HRESULT Begin_JobTransferred(IBackgroundCopyJob pJob);
    HRESULT Finish_JobTransferred();
    HRESULT Begin_JobError(IBackgroundCopyJob pJob, IBackgroundCopyError pError);
    HRESULT Finish_JobError();
    HRESULT Begin_JobModification(IBackgroundCopyJob pJob, uint dwReserved);
    HRESULT Finish_JobModification();
}

@GUID("5CE34C0D-0DC9-4C1F-897C-DAA1B78CEE7C")
interface IBackgroundCopyManager : IUnknown
{
    HRESULT CreateJob(const(wchar)* DisplayName, BG_JOB_TYPE Type, GUID* pJobId, IBackgroundCopyJob* ppJob);
    HRESULT GetJobA(const(GUID)* jobID, IBackgroundCopyJob* ppJob);
    HRESULT EnumJobsA(uint dwFlags, IEnumBackgroundCopyJobs* ppEnum);
    HRESULT GetErrorDescription(HRESULT hResult, uint LanguageId, ushort** pErrorDescription);
}

@GUID("54B50739-686F-45EB-9DFF-D6A9A0FAA9AF")
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

@GUID("443C8934-90FF-48ED-BCDE-26F5C7450042")
interface IBackgroundCopyJob3 : IBackgroundCopyJob2
{
    HRESULT ReplaceRemotePrefix(const(wchar)* OldPrefix, const(wchar)* NewPrefix);
    HRESULT AddFileWithRanges(const(wchar)* RemoteUrl, const(wchar)* LocalName, uint RangeCount, char* Ranges);
    HRESULT SetFileACLFlags(uint Flags);
    HRESULT GetFileACLFlags(uint* Flags);
}

@GUID("83E81B93-0873-474D-8A8C-F2018B1A939C")
interface IBackgroundCopyFile2 : IBackgroundCopyFile
{
    HRESULT GetFileRanges(uint* RangeCount, char* Ranges);
    HRESULT SetRemoteName(const(wchar)* Val);
}

@GUID("F1BD1079-9F01-4BDC-8036-F09B70095066")
interface IBackgroundCopyJobHttpOptions : IUnknown
{
    HRESULT SetClientCertificateByID(BG_CERT_STORE_LOCATION StoreLocation, const(wchar)* StoreName, 
                                     char* pCertHashBlob);
    HRESULT SetClientCertificateByName(BG_CERT_STORE_LOCATION StoreLocation, const(wchar)* StoreName, 
                                       const(wchar)* SubjectName);
    HRESULT RemoveClientCertificate();
    HRESULT GetClientCertificate(BG_CERT_STORE_LOCATION* pStoreLocation, ushort** pStoreName, char* ppCertHashBlob, 
                                 ushort** pSubjectName);
    HRESULT SetCustomHeaders(const(wchar)* RequestHeaders);
    HRESULT GetCustomHeaders(ushort** pRequestHeaders);
    HRESULT SetSecurityFlags(uint Flags);
    HRESULT GetSecurityFlags(uint* pFlags);
}

@GUID("659CDEAF-489E-11D9-A9CD-000D56965251")
interface IBitsPeerCacheRecord : IUnknown
{
    HRESULT GetId(GUID* pVal);
    HRESULT GetOriginUrl(ushort** pVal);
    HRESULT GetFileSize(ulong* pVal);
    HRESULT GetFileModificationTime(FILETIME* pVal);
    HRESULT GetLastAccessTime(FILETIME* pVal);
    HRESULT IsFileValidated();
    HRESULT GetFileRanges(uint* pRangeCount, char* ppRanges);
}

@GUID("659CDEA4-489E-11D9-A9CD-000D56965251")
interface IEnumBitsPeerCacheRecords : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumBitsPeerCacheRecords* ppenum);
    HRESULT GetCount(uint* puCount);
}

@GUID("659CDEA2-489E-11D9-A9CD-000D56965251")
interface IBitsPeer : IUnknown
{
    HRESULT GetPeerName(ushort** pName);
    HRESULT IsAuthenticated(int* pAuth);
    HRESULT IsAvailable(int* pOnline);
}

@GUID("659CDEA5-489E-11D9-A9CD-000D56965251")
interface IEnumBitsPeers : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumBitsPeers* ppenum);
    HRESULT GetCount(uint* puCount);
}

@GUID("659CDEAD-489E-11D9-A9CD-000D56965251")
interface IBitsPeerCacheAdministration : IUnknown
{
    HRESULT GetMaximumCacheSize(uint* pBytes);
    HRESULT SetMaximumCacheSize(uint Bytes);
    HRESULT GetMaximumContentAge(uint* pSeconds);
    HRESULT SetMaximumContentAge(uint Seconds);
    HRESULT GetConfigurationFlags(uint* pFlags);
    HRESULT SetConfigurationFlags(uint Flags);
    HRESULT EnumRecords(IEnumBitsPeerCacheRecords* ppEnum);
    HRESULT GetRecord(const(GUID)* id, IBitsPeerCacheRecord* ppRecord);
    HRESULT ClearRecords();
    HRESULT DeleteRecord(const(GUID)* id);
    HRESULT DeleteUrl(const(wchar)* url);
    HRESULT EnumPeers(IEnumBitsPeers* ppEnum);
    HRESULT ClearPeers();
    HRESULT DiscoverPeers();
}

@GUID("659CDEAE-489E-11D9-A9CD-000D56965251")
interface IBackgroundCopyJob4 : IBackgroundCopyJob3
{
    HRESULT SetPeerCachingFlags(uint Flags);
    HRESULT GetPeerCachingFlags(uint* pFlags);
    HRESULT GetOwnerIntegrityLevel(uint* pLevel);
    HRESULT GetOwnerElevationState(int* pElevated);
    HRESULT SetMaximumDownloadTime(uint Timeout);
    HRESULT GetMaximumDownloadTime(uint* pTimeout);
}

@GUID("659CDEAA-489E-11D9-A9CD-000D56965251")
interface IBackgroundCopyFile3 : IBackgroundCopyFile2
{
    HRESULT GetTemporaryName(ushort** pFilename);
    HRESULT SetValidationState(BOOL state);
    HRESULT GetValidationState(int* pState);
    HRESULT IsDownloadedFromPeer(int* pVal);
}

@GUID("659CDEAC-489E-11D9-A9CD-000D56965251")
interface IBackgroundCopyCallback2 : IBackgroundCopyCallback
{
    HRESULT FileTransferred(IBackgroundCopyJob pJob, IBackgroundCopyFile pFile);
}

@GUID("9A2584C3-F7D2-457A-9A5E-22B67BFFC7D2")
interface IBitsTokenOptions : IUnknown
{
    HRESULT SetHelperTokenFlags(uint UsageFlags);
    HRESULT GetHelperTokenFlags(uint* pFlags);
    HRESULT SetHelperToken();
    HRESULT ClearHelperToken();
    HRESULT GetHelperTokenSid(ushort** pSid);
}

@GUID("EF7E0655-7888-4960-B0E5-730846E03492")
interface IBackgroundCopyFile4 : IBackgroundCopyFile3
{
    HRESULT GetPeerDownloadStats(ulong* pFromOrigin, ulong* pFromPeers);
}

@GUID("E847030C-BBBA-4657-AF6D-484AA42BF1FE")
interface IBackgroundCopyJob5 : IBackgroundCopyJob4
{
    HRESULT SetProperty(BITS_JOB_PROPERTY_ID PropertyId, BITS_JOB_PROPERTY_VALUE PropertyValue);
    HRESULT GetProperty(BITS_JOB_PROPERTY_ID PropertyId, BITS_JOB_PROPERTY_VALUE* PropertyValue);
}

@GUID("85C1657F-DAFC-40E8-8834-DF18EA25717E")
interface IBackgroundCopyFile5 : IBackgroundCopyFile4
{
    HRESULT SetProperty(BITS_FILE_PROPERTY_ID PropertyId, BITS_FILE_PROPERTY_VALUE PropertyValue);
    HRESULT GetProperty(BITS_FILE_PROPERTY_ID PropertyId, BITS_FILE_PROPERTY_VALUE* PropertyValue);
}

@GUID("98C97BD2-E32B-4AD8-A528-95FD8B16BD42")
interface IBackgroundCopyCallback3 : IBackgroundCopyCallback2
{
    HRESULT FileRangesTransferred(IBackgroundCopyJob job, IBackgroundCopyFile file, uint rangeCount, char* ranges);
}

@GUID("CF6784F7-D677-49FD-9368-CB47AEE9D1AD")
interface IBackgroundCopyFile6 : IBackgroundCopyFile5
{
    HRESULT UpdateDownloadPosition(ulong offset);
    HRESULT RequestFileRanges(uint rangeCount, char* ranges);
    HRESULT GetFilledFileRanges(uint* rangeCount, char* ranges);
}

@GUID("B591A192-A405-4FC3-8323-4C5C542578FC")
interface IBackgroundCopyJobHttpOptions2 : IBackgroundCopyJobHttpOptions
{
    HRESULT SetHttpMethod(const(wchar)* method);
    HRESULT GetHttpMethod(ushort** method);
}

@GUID("4CEC0D02-DEF7-4158-813A-C32A46945FF7")
interface IBackgroundCopyServerCertificateValidationCallback : IUnknown
{
    HRESULT ValidateServerCertificate(IBackgroundCopyJob job, IBackgroundCopyFile file, uint certLength, 
                                      char* certData, uint certEncodingType, uint certStoreLength, 
                                      char* certStoreData);
}

@GUID("8A9263D3-FD4C-4EDA-9B28-30132A4D4E3C")
interface IBackgroundCopyJobHttpOptions3 : IBackgroundCopyJobHttpOptions2
{
    HRESULT SetServerCertificateValidationInterface(IUnknown certValidationCallback);
    HRESULT MakeCustomHeadersWriteOnly();
}

@GUID("29CFBBF7-09E4-4B97-B0BC-F2287E3D8EB3")
interface IBITSExtensionSetup : IDispatch
{
    HRESULT EnableBITSUploads();
    HRESULT DisableBITSUploads();
    HRESULT GetCleanupTaskName(BSTR* pTaskName);
    HRESULT GetCleanupTask(const(GUID)* riid, IUnknown* ppUnk);
}

@GUID("D5D2D542-5503-4E64-8B48-72EF91A32EE1")
interface IBITSExtensionSetupFactory : IDispatch
{
    HRESULT GetObjectA(BSTR Path, IBITSExtensionSetup* ppExtensionSetup);
}

@GUID("59F5553C-2031-4629-BB18-2645A6970947")
interface IBackgroundCopyJob1 : IUnknown
{
    HRESULT CancelJob();
    HRESULT GetProgress(uint dwFlags, uint* pdwProgress);
    HRESULT GetStatus(uint* pdwStatus, uint* pdwWin32Result, uint* pdwTransportResult, uint* pdwNumOfRetries);
    HRESULT AddFiles(uint cFileCount, char* ppFileSet);
    HRESULT GetFile(uint cFileIndex, FILESETINFO* pFileInfo);
    HRESULT GetFileCount(uint* pdwFileCount);
    HRESULT SwitchToForeground();
    HRESULT get_JobID(GUID* pguidJobID);
}

@GUID("8BAEBA9D-8F1C-42C4-B82C-09AE79980D25")
interface IEnumBackgroundCopyJobs1 : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumBackgroundCopyJobs1* ppenum);
    HRESULT GetCount(uint* puCount);
}

@GUID("1DED80A7-53EA-424F-8A04-17FEA9ADC4F5")
interface IBackgroundCopyGroup : IUnknown
{
    HRESULT GetPropA(GROUPPROP propID, VARIANT* pvarVal);
    HRESULT SetPropA(GROUPPROP propID, VARIANT* pvarVal);
    HRESULT GetProgress(uint dwFlags, uint* pdwProgress);
    HRESULT GetStatus(uint* pdwStatus, uint* pdwJobIndex);
    HRESULT GetJobA(GUID jobID, IBackgroundCopyJob1* ppJob);
    HRESULT SuspendGroup();
    HRESULT ResumeGroup();
    HRESULT CancelGroup();
    HRESULT get_Size(uint* pdwSize);
    HRESULT get_GroupID(GUID* pguidGroupID);
    HRESULT CreateJob(GUID guidJobID, IBackgroundCopyJob1* ppJob);
    HRESULT EnumJobsA(uint dwFlags, IEnumBackgroundCopyJobs1* ppEnumJobs);
    HRESULT SwitchToForeground();
    HRESULT QueryNewJobInterface(const(GUID)* iid, IUnknown* pUnk);
    HRESULT SetNotificationPointer(const(GUID)* iid, IUnknown pUnk);
}

@GUID("D993E603-4AA4-47C5-8665-C20D39C2BA4F")
interface IEnumBackgroundCopyGroups : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumBackgroundCopyGroups* ppenum);
    HRESULT GetCount(uint* puCount);
}

@GUID("084F6593-3800-4E08-9B59-99FA59ADDF82")
interface IBackgroundCopyCallback1 : IUnknown
{
    HRESULT OnStatus(IBackgroundCopyGroup pGroup, IBackgroundCopyJob1 pJob, uint dwFileIndex, uint dwStatus, 
                     uint dwNumOfRetries, uint dwWin32Result, uint dwTransportResult);
    HRESULT OnProgress(uint ProgressType, IBackgroundCopyGroup pGroup, IBackgroundCopyJob1 pJob, uint dwFileIndex, 
                       uint dwProgressValue);
    HRESULT OnProgressEx(uint ProgressType, IBackgroundCopyGroup pGroup, IBackgroundCopyJob1 pJob, 
                         uint dwFileIndex, uint dwProgressValue, uint dwByteArraySize, char* pByte);
}

@GUID("16F41C69-09F5-41D2-8CD8-3C08C47BC8A8")
interface IBackgroundCopyQMgr : IUnknown
{
    HRESULT CreateGroup(GUID guidGroupID, IBackgroundCopyGroup* ppGroup);
    HRESULT GetGroup(GUID groupID, IBackgroundCopyGroup* ppGroup);
    HRESULT EnumGroups(uint dwFlags, IEnumBackgroundCopyGroups* ppEnumGroups);
}


// GUIDs

const GUID CLSID_BITSExtensionSetupFactory = GUIDOF!BITSExtensionSetupFactory;
const GUID CLSID_BackgroundCopyManager     = GUIDOF!BackgroundCopyManager;
const GUID CLSID_BackgroundCopyManager10_1 = GUIDOF!BackgroundCopyManager10_1;
const GUID CLSID_BackgroundCopyManager10_2 = GUIDOF!BackgroundCopyManager10_2;
const GUID CLSID_BackgroundCopyManager10_3 = GUIDOF!BackgroundCopyManager10_3;
const GUID CLSID_BackgroundCopyManager1_5  = GUIDOF!BackgroundCopyManager1_5;
const GUID CLSID_BackgroundCopyManager2_0  = GUIDOF!BackgroundCopyManager2_0;
const GUID CLSID_BackgroundCopyManager2_5  = GUIDOF!BackgroundCopyManager2_5;
const GUID CLSID_BackgroundCopyManager3_0  = GUIDOF!BackgroundCopyManager3_0;
const GUID CLSID_BackgroundCopyManager4_0  = GUIDOF!BackgroundCopyManager4_0;
const GUID CLSID_BackgroundCopyManager5_0  = GUIDOF!BackgroundCopyManager5_0;
const GUID CLSID_BackgroundCopyQMgr        = GUIDOF!BackgroundCopyQMgr;

const GUID IID_AsyncIBackgroundCopyCallback                       = GUIDOF!AsyncIBackgroundCopyCallback;
const GUID IID_IBITSExtensionSetup                                = GUIDOF!IBITSExtensionSetup;
const GUID IID_IBITSExtensionSetupFactory                         = GUIDOF!IBITSExtensionSetupFactory;
const GUID IID_IBackgroundCopyCallback                            = GUIDOF!IBackgroundCopyCallback;
const GUID IID_IBackgroundCopyCallback1                           = GUIDOF!IBackgroundCopyCallback1;
const GUID IID_IBackgroundCopyCallback2                           = GUIDOF!IBackgroundCopyCallback2;
const GUID IID_IBackgroundCopyCallback3                           = GUIDOF!IBackgroundCopyCallback3;
const GUID IID_IBackgroundCopyError                               = GUIDOF!IBackgroundCopyError;
const GUID IID_IBackgroundCopyFile                                = GUIDOF!IBackgroundCopyFile;
const GUID IID_IBackgroundCopyFile2                               = GUIDOF!IBackgroundCopyFile2;
const GUID IID_IBackgroundCopyFile3                               = GUIDOF!IBackgroundCopyFile3;
const GUID IID_IBackgroundCopyFile4                               = GUIDOF!IBackgroundCopyFile4;
const GUID IID_IBackgroundCopyFile5                               = GUIDOF!IBackgroundCopyFile5;
const GUID IID_IBackgroundCopyFile6                               = GUIDOF!IBackgroundCopyFile6;
const GUID IID_IBackgroundCopyGroup                               = GUIDOF!IBackgroundCopyGroup;
const GUID IID_IBackgroundCopyJob                                 = GUIDOF!IBackgroundCopyJob;
const GUID IID_IBackgroundCopyJob1                                = GUIDOF!IBackgroundCopyJob1;
const GUID IID_IBackgroundCopyJob2                                = GUIDOF!IBackgroundCopyJob2;
const GUID IID_IBackgroundCopyJob3                                = GUIDOF!IBackgroundCopyJob3;
const GUID IID_IBackgroundCopyJob4                                = GUIDOF!IBackgroundCopyJob4;
const GUID IID_IBackgroundCopyJob5                                = GUIDOF!IBackgroundCopyJob5;
const GUID IID_IBackgroundCopyJobHttpOptions                      = GUIDOF!IBackgroundCopyJobHttpOptions;
const GUID IID_IBackgroundCopyJobHttpOptions2                     = GUIDOF!IBackgroundCopyJobHttpOptions2;
const GUID IID_IBackgroundCopyJobHttpOptions3                     = GUIDOF!IBackgroundCopyJobHttpOptions3;
const GUID IID_IBackgroundCopyManager                             = GUIDOF!IBackgroundCopyManager;
const GUID IID_IBackgroundCopyQMgr                                = GUIDOF!IBackgroundCopyQMgr;
const GUID IID_IBackgroundCopyServerCertificateValidationCallback = GUIDOF!IBackgroundCopyServerCertificateValidationCallback;
const GUID IID_IBitsPeer                                          = GUIDOF!IBitsPeer;
const GUID IID_IBitsPeerCacheAdministration                       = GUIDOF!IBitsPeerCacheAdministration;
const GUID IID_IBitsPeerCacheRecord                               = GUIDOF!IBitsPeerCacheRecord;
const GUID IID_IBitsTokenOptions                                  = GUIDOF!IBitsTokenOptions;
const GUID IID_IEnumBackgroundCopyFiles                           = GUIDOF!IEnumBackgroundCopyFiles;
const GUID IID_IEnumBackgroundCopyGroups                          = GUIDOF!IEnumBackgroundCopyGroups;
const GUID IID_IEnumBackgroundCopyJobs                            = GUIDOF!IEnumBackgroundCopyJobs;
const GUID IID_IEnumBackgroundCopyJobs1                           = GUIDOF!IEnumBackgroundCopyJobs1;
const GUID IID_IEnumBitsPeerCacheRecords                          = GUIDOF!IEnumBitsPeerCacheRecords;
const GUID IID_IEnumBitsPeers                                     = GUIDOF!IEnumBitsPeers;
