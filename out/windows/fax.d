module windows.fax;

public import system;
public import windows.automation;
public import windows.com;
public import windows.controls;
public import windows.gdi;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

enum FAX_ENUM_LOG_LEVELS
{
    FAXLOG_LEVEL_NONE = 0,
    FAXLOG_LEVEL_MIN = 1,
    FAXLOG_LEVEL_MED = 2,
    FAXLOG_LEVEL_MAX = 3,
}

enum FAX_ENUM_LOG_CATEGORIES
{
    FAXLOG_CATEGORY_INIT = 1,
    FAXLOG_CATEGORY_OUTBOUND = 2,
    FAXLOG_CATEGORY_INBOUND = 3,
    FAXLOG_CATEGORY_UNKNOWN = 4,
}

struct FAX_LOG_CATEGORYA
{
    const(char)* Name;
    uint Category;
    uint Level;
}

struct FAX_LOG_CATEGORYW
{
    const(wchar)* Name;
    uint Category;
    uint Level;
}

struct FAX_TIME
{
    ushort Hour;
    ushort Minute;
}

struct FAX_CONFIGURATIONA
{
    uint SizeOfStruct;
    uint Retries;
    uint RetryDelay;
    uint DirtyDays;
    BOOL Branding;
    BOOL UseDeviceTsid;
    BOOL ServerCp;
    BOOL PauseServerQueue;
    FAX_TIME StartCheapTime;
    FAX_TIME StopCheapTime;
    BOOL ArchiveOutgoingFaxes;
    const(char)* ArchiveDirectory;
    const(char)* Reserved;
}

struct FAX_CONFIGURATIONW
{
    uint SizeOfStruct;
    uint Retries;
    uint RetryDelay;
    uint DirtyDays;
    BOOL Branding;
    BOOL UseDeviceTsid;
    BOOL ServerCp;
    BOOL PauseServerQueue;
    FAX_TIME StartCheapTime;
    FAX_TIME StopCheapTime;
    BOOL ArchiveOutgoingFaxes;
    const(wchar)* ArchiveDirectory;
    const(wchar)* Reserved;
}

enum FAX_ENUM_JOB_COMMANDS
{
    JC_UNKNOWN = 0,
    JC_DELETE = 1,
    JC_PAUSE = 2,
    JC_RESUME = 3,
}

struct FAX_DEVICE_STATUSA
{
    uint SizeOfStruct;
    const(char)* CallerId;
    const(char)* Csid;
    uint CurrentPage;
    uint DeviceId;
    const(char)* DeviceName;
    const(char)* DocumentName;
    uint JobType;
    const(char)* PhoneNumber;
    const(char)* RoutingString;
    const(char)* SenderName;
    const(char)* RecipientName;
    uint Size;
    FILETIME StartTime;
    uint Status;
    const(char)* StatusString;
    FILETIME SubmittedTime;
    uint TotalPages;
    const(char)* Tsid;
    const(char)* UserName;
}

struct FAX_DEVICE_STATUSW
{
    uint SizeOfStruct;
    const(wchar)* CallerId;
    const(wchar)* Csid;
    uint CurrentPage;
    uint DeviceId;
    const(wchar)* DeviceName;
    const(wchar)* DocumentName;
    uint JobType;
    const(wchar)* PhoneNumber;
    const(wchar)* RoutingString;
    const(wchar)* SenderName;
    const(wchar)* RecipientName;
    uint Size;
    FILETIME StartTime;
    uint Status;
    const(wchar)* StatusString;
    FILETIME SubmittedTime;
    uint TotalPages;
    const(wchar)* Tsid;
    const(wchar)* UserName;
}

struct FAX_JOB_ENTRYA
{
    uint SizeOfStruct;
    uint JobId;
    const(char)* UserName;
    uint JobType;
    uint QueueStatus;
    uint Status;
    uint Size;
    uint PageCount;
    const(char)* RecipientNumber;
    const(char)* RecipientName;
    const(char)* Tsid;
    const(char)* SenderName;
    const(char)* SenderCompany;
    const(char)* SenderDept;
    const(char)* BillingCode;
    uint ScheduleAction;
    SYSTEMTIME ScheduleTime;
    uint DeliveryReportType;
    const(char)* DeliveryReportAddress;
    const(char)* DocumentName;
}

struct FAX_JOB_ENTRYW
{
    uint SizeOfStruct;
    uint JobId;
    const(wchar)* UserName;
    uint JobType;
    uint QueueStatus;
    uint Status;
    uint Size;
    uint PageCount;
    const(wchar)* RecipientNumber;
    const(wchar)* RecipientName;
    const(wchar)* Tsid;
    const(wchar)* SenderName;
    const(wchar)* SenderCompany;
    const(wchar)* SenderDept;
    const(wchar)* BillingCode;
    uint ScheduleAction;
    SYSTEMTIME ScheduleTime;
    uint DeliveryReportType;
    const(wchar)* DeliveryReportAddress;
    const(wchar)* DocumentName;
}

struct FAX_PORT_INFOA
{
    uint SizeOfStruct;
    uint DeviceId;
    uint State;
    uint Flags;
    uint Rings;
    uint Priority;
    const(char)* DeviceName;
    const(char)* Tsid;
    const(char)* Csid;
}

struct FAX_PORT_INFOW
{
    uint SizeOfStruct;
    uint DeviceId;
    uint State;
    uint Flags;
    uint Rings;
    uint Priority;
    const(wchar)* DeviceName;
    const(wchar)* Tsid;
    const(wchar)* Csid;
}

struct FAX_ROUTING_METHODA
{
    uint SizeOfStruct;
    uint DeviceId;
    BOOL Enabled;
    const(char)* DeviceName;
    const(char)* Guid;
    const(char)* FriendlyName;
    const(char)* FunctionName;
    const(char)* ExtensionImageName;
    const(char)* ExtensionFriendlyName;
}

struct FAX_ROUTING_METHODW
{
    uint SizeOfStruct;
    uint DeviceId;
    BOOL Enabled;
    const(wchar)* DeviceName;
    const(wchar)* Guid;
    const(wchar)* FriendlyName;
    const(wchar)* FunctionName;
    const(wchar)* ExtensionImageName;
    const(wchar)* ExtensionFriendlyName;
}

struct FAX_GLOBAL_ROUTING_INFOA
{
    uint SizeOfStruct;
    uint Priority;
    const(char)* Guid;
    const(char)* FriendlyName;
    const(char)* FunctionName;
    const(char)* ExtensionImageName;
    const(char)* ExtensionFriendlyName;
}

struct FAX_GLOBAL_ROUTING_INFOW
{
    uint SizeOfStruct;
    uint Priority;
    const(wchar)* Guid;
    const(wchar)* FriendlyName;
    const(wchar)* FunctionName;
    const(wchar)* ExtensionImageName;
    const(wchar)* ExtensionFriendlyName;
}

struct FAX_COVERPAGE_INFOA
{
    uint SizeOfStruct;
    const(char)* CoverPageName;
    BOOL UseServerCoverPage;
    const(char)* RecName;
    const(char)* RecFaxNumber;
    const(char)* RecCompany;
    const(char)* RecStreetAddress;
    const(char)* RecCity;
    const(char)* RecState;
    const(char)* RecZip;
    const(char)* RecCountry;
    const(char)* RecTitle;
    const(char)* RecDepartment;
    const(char)* RecOfficeLocation;
    const(char)* RecHomePhone;
    const(char)* RecOfficePhone;
    const(char)* SdrName;
    const(char)* SdrFaxNumber;
    const(char)* SdrCompany;
    const(char)* SdrAddress;
    const(char)* SdrTitle;
    const(char)* SdrDepartment;
    const(char)* SdrOfficeLocation;
    const(char)* SdrHomePhone;
    const(char)* SdrOfficePhone;
    const(char)* Note;
    const(char)* Subject;
    SYSTEMTIME TimeSent;
    uint PageCount;
}

struct FAX_COVERPAGE_INFOW
{
    uint SizeOfStruct;
    const(wchar)* CoverPageName;
    BOOL UseServerCoverPage;
    const(wchar)* RecName;
    const(wchar)* RecFaxNumber;
    const(wchar)* RecCompany;
    const(wchar)* RecStreetAddress;
    const(wchar)* RecCity;
    const(wchar)* RecState;
    const(wchar)* RecZip;
    const(wchar)* RecCountry;
    const(wchar)* RecTitle;
    const(wchar)* RecDepartment;
    const(wchar)* RecOfficeLocation;
    const(wchar)* RecHomePhone;
    const(wchar)* RecOfficePhone;
    const(wchar)* SdrName;
    const(wchar)* SdrFaxNumber;
    const(wchar)* SdrCompany;
    const(wchar)* SdrAddress;
    const(wchar)* SdrTitle;
    const(wchar)* SdrDepartment;
    const(wchar)* SdrOfficeLocation;
    const(wchar)* SdrHomePhone;
    const(wchar)* SdrOfficePhone;
    const(wchar)* Note;
    const(wchar)* Subject;
    SYSTEMTIME TimeSent;
    uint PageCount;
}

enum FAX_ENUM_JOB_SEND_ATTRIBUTES
{
    JSA_NOW = 0,
    JSA_SPECIFIC_TIME = 1,
    JSA_DISCOUNT_PERIOD = 2,
}

enum FAX_ENUM_DELIVERY_REPORT_TYPES
{
    DRT_NONE = 0,
    DRT_EMAIL = 1,
    DRT_INBOX = 2,
}

struct FAX_JOB_PARAMA
{
    uint SizeOfStruct;
    const(char)* RecipientNumber;
    const(char)* RecipientName;
    const(char)* Tsid;
    const(char)* SenderName;
    const(char)* SenderCompany;
    const(char)* SenderDept;
    const(char)* BillingCode;
    uint ScheduleAction;
    SYSTEMTIME ScheduleTime;
    uint DeliveryReportType;
    const(char)* DeliveryReportAddress;
    const(char)* DocumentName;
    uint CallHandle;
    uint Reserved;
}

struct FAX_JOB_PARAMW
{
    uint SizeOfStruct;
    const(wchar)* RecipientNumber;
    const(wchar)* RecipientName;
    const(wchar)* Tsid;
    const(wchar)* SenderName;
    const(wchar)* SenderCompany;
    const(wchar)* SenderDept;
    const(wchar)* BillingCode;
    uint ScheduleAction;
    SYSTEMTIME ScheduleTime;
    uint DeliveryReportType;
    const(wchar)* DeliveryReportAddress;
    const(wchar)* DocumentName;
    uint CallHandle;
    uint Reserved;
}

struct FAX_EVENTA
{
    uint SizeOfStruct;
    FILETIME TimeStamp;
    uint DeviceId;
    uint EventId;
    uint JobId;
}

struct FAX_EVENTW
{
    uint SizeOfStruct;
    FILETIME TimeStamp;
    uint DeviceId;
    uint EventId;
    uint JobId;
}

struct FAX_PRINT_INFOA
{
    uint SizeOfStruct;
    const(char)* DocName;
    const(char)* RecipientName;
    const(char)* RecipientNumber;
    const(char)* SenderName;
    const(char)* SenderCompany;
    const(char)* SenderDept;
    const(char)* SenderBillingCode;
    const(char)* Reserved;
    const(char)* DrEmailAddress;
    const(char)* OutputFileName;
}

struct FAX_PRINT_INFOW
{
    uint SizeOfStruct;
    const(wchar)* DocName;
    const(wchar)* RecipientName;
    const(wchar)* RecipientNumber;
    const(wchar)* SenderName;
    const(wchar)* SenderCompany;
    const(wchar)* SenderDept;
    const(wchar)* SenderBillingCode;
    const(wchar)* Reserved;
    const(wchar)* DrEmailAddress;
    const(wchar)* OutputFileName;
}

struct FAX_CONTEXT_INFOA
{
    uint SizeOfStruct;
    HDC hDC;
    byte ServerName;
}

struct FAX_CONTEXT_INFOW
{
    uint SizeOfStruct;
    HDC hDC;
    ushort ServerName;
}

alias PFAXCONNECTFAXSERVERA = extern(Windows) BOOL function(const(char)* MachineName, int* FaxHandle);
alias PFAXCONNECTFAXSERVERW = extern(Windows) BOOL function(const(wchar)* MachineName, int* FaxHandle);
alias PFAXCLOSE = extern(Windows) BOOL function(HANDLE FaxHandle);
enum FAX_ENUM_PORT_OPEN_TYPE
{
    PORT_OPEN_QUERY = 1,
    PORT_OPEN_MODIFY = 2,
}

alias PFAXOPENPORT = extern(Windows) BOOL function(HANDLE FaxHandle, uint DeviceId, uint Flags, int* FaxPortHandle);
alias PFAXCOMPLETEJOBPARAMSA = extern(Windows) BOOL function(FAX_JOB_PARAMA** JobParams, FAX_COVERPAGE_INFOA** CoverpageInfo);
alias PFAXCOMPLETEJOBPARAMSW = extern(Windows) BOOL function(FAX_JOB_PARAMW** JobParams, FAX_COVERPAGE_INFOW** CoverpageInfo);
alias PFAXSENDDOCUMENTA = extern(Windows) BOOL function(HANDLE FaxHandle, const(char)* FileName, FAX_JOB_PARAMA* JobParams, const(FAX_COVERPAGE_INFOA)* CoverpageInfo, uint* FaxJobId);
alias PFAXSENDDOCUMENTW = extern(Windows) BOOL function(HANDLE FaxHandle, const(wchar)* FileName, FAX_JOB_PARAMW* JobParams, const(FAX_COVERPAGE_INFOW)* CoverpageInfo, uint* FaxJobId);
alias PFAX_RECIPIENT_CALLBACKA = extern(Windows) BOOL function(HANDLE FaxHandle, uint RecipientNumber, void* Context, FAX_JOB_PARAMA* JobParams, FAX_COVERPAGE_INFOA* CoverpageInfo);
alias PFAX_RECIPIENT_CALLBACKW = extern(Windows) BOOL function(HANDLE FaxHandle, uint RecipientNumber, void* Context, FAX_JOB_PARAMW* JobParams, FAX_COVERPAGE_INFOW* CoverpageInfo);
alias PFAXSENDDOCUMENTFORBROADCASTA = extern(Windows) BOOL function(HANDLE FaxHandle, const(char)* FileName, uint* FaxJobId, PFAX_RECIPIENT_CALLBACKA FaxRecipientCallback, void* Context);
alias PFAXSENDDOCUMENTFORBROADCASTW = extern(Windows) BOOL function(HANDLE FaxHandle, const(wchar)* FileName, uint* FaxJobId, PFAX_RECIPIENT_CALLBACKW FaxRecipientCallback, void* Context);
alias PFAXENUMJOBSA = extern(Windows) BOOL function(HANDLE FaxHandle, FAX_JOB_ENTRYA** JobEntry, uint* JobsReturned);
alias PFAXENUMJOBSW = extern(Windows) BOOL function(HANDLE FaxHandle, FAX_JOB_ENTRYW** JobEntry, uint* JobsReturned);
alias PFAXGETJOBA = extern(Windows) BOOL function(HANDLE FaxHandle, uint JobId, FAX_JOB_ENTRYA** JobEntry);
alias PFAXGETJOBW = extern(Windows) BOOL function(HANDLE FaxHandle, uint JobId, FAX_JOB_ENTRYW** JobEntry);
alias PFAXSETJOBA = extern(Windows) BOOL function(HANDLE FaxHandle, uint JobId, uint Command, const(FAX_JOB_ENTRYA)* JobEntry);
alias PFAXSETJOBW = extern(Windows) BOOL function(HANDLE FaxHandle, uint JobId, uint Command, const(FAX_JOB_ENTRYW)* JobEntry);
alias PFAXGETPAGEDATA = extern(Windows) BOOL function(HANDLE FaxHandle, uint JobId, ubyte** Buffer, uint* BufferSize, uint* ImageWidth, uint* ImageHeight);
alias PFAXGETDEVICESTATUSA = extern(Windows) BOOL function(HANDLE FaxPortHandle, FAX_DEVICE_STATUSA** DeviceStatus);
alias PFAXGETDEVICESTATUSW = extern(Windows) BOOL function(HANDLE FaxPortHandle, FAX_DEVICE_STATUSW** DeviceStatus);
alias PFAXABORT = extern(Windows) BOOL function(HANDLE FaxHandle, uint JobId);
alias PFAXGETCONFIGURATIONA = extern(Windows) BOOL function(HANDLE FaxHandle, FAX_CONFIGURATIONA** FaxConfig);
alias PFAXGETCONFIGURATIONW = extern(Windows) BOOL function(HANDLE FaxHandle, FAX_CONFIGURATIONW** FaxConfig);
alias PFAXSETCONFIGURATIONA = extern(Windows) BOOL function(HANDLE FaxHandle, const(FAX_CONFIGURATIONA)* FaxConfig);
alias PFAXSETCONFIGURATIONW = extern(Windows) BOOL function(HANDLE FaxHandle, const(FAX_CONFIGURATIONW)* FaxConfig);
alias PFAXGETLOGGINGCATEGORIESA = extern(Windows) BOOL function(HANDLE FaxHandle, FAX_LOG_CATEGORYA** Categories, uint* NumberCategories);
alias PFAXGETLOGGINGCATEGORIESW = extern(Windows) BOOL function(HANDLE FaxHandle, FAX_LOG_CATEGORYW** Categories, uint* NumberCategories);
alias PFAXSETLOGGINGCATEGORIESA = extern(Windows) BOOL function(HANDLE FaxHandle, const(FAX_LOG_CATEGORYA)* Categories, uint NumberCategories);
alias PFAXSETLOGGINGCATEGORIESW = extern(Windows) BOOL function(HANDLE FaxHandle, const(FAX_LOG_CATEGORYW)* Categories, uint NumberCategories);
alias PFAXENUMPORTSA = extern(Windows) BOOL function(HANDLE FaxHandle, FAX_PORT_INFOA** PortInfo, uint* PortsReturned);
alias PFAXENUMPORTSW = extern(Windows) BOOL function(HANDLE FaxHandle, FAX_PORT_INFOW** PortInfo, uint* PortsReturned);
alias PFAXGETPORTA = extern(Windows) BOOL function(HANDLE FaxPortHandle, FAX_PORT_INFOA** PortInfo);
alias PFAXGETPORTW = extern(Windows) BOOL function(HANDLE FaxPortHandle, FAX_PORT_INFOW** PortInfo);
alias PFAXSETPORTA = extern(Windows) BOOL function(HANDLE FaxPortHandle, const(FAX_PORT_INFOA)* PortInfo);
alias PFAXSETPORTW = extern(Windows) BOOL function(HANDLE FaxPortHandle, const(FAX_PORT_INFOW)* PortInfo);
alias PFAXENUMROUTINGMETHODSA = extern(Windows) BOOL function(HANDLE FaxPortHandle, FAX_ROUTING_METHODA** RoutingMethod, uint* MethodsReturned);
alias PFAXENUMROUTINGMETHODSW = extern(Windows) BOOL function(HANDLE FaxPortHandle, FAX_ROUTING_METHODW** RoutingMethod, uint* MethodsReturned);
alias PFAXENABLEROUTINGMETHODA = extern(Windows) BOOL function(HANDLE FaxPortHandle, const(char)* RoutingGuid, BOOL Enabled);
alias PFAXENABLEROUTINGMETHODW = extern(Windows) BOOL function(HANDLE FaxPortHandle, const(wchar)* RoutingGuid, BOOL Enabled);
alias PFAXENUMGLOBALROUTINGINFOA = extern(Windows) BOOL function(HANDLE FaxHandle, FAX_GLOBAL_ROUTING_INFOA** RoutingInfo, uint* MethodsReturned);
alias PFAXENUMGLOBALROUTINGINFOW = extern(Windows) BOOL function(HANDLE FaxHandle, FAX_GLOBAL_ROUTING_INFOW** RoutingInfo, uint* MethodsReturned);
alias PFAXSETGLOBALROUTINGINFOA = extern(Windows) BOOL function(HANDLE FaxPortHandle, const(FAX_GLOBAL_ROUTING_INFOA)* RoutingInfo);
alias PFAXSETGLOBALROUTINGINFOW = extern(Windows) BOOL function(HANDLE FaxPortHandle, const(FAX_GLOBAL_ROUTING_INFOW)* RoutingInfo);
alias PFAXGETROUTINGINFOA = extern(Windows) BOOL function(HANDLE FaxPortHandle, const(char)* RoutingGuid, ubyte** RoutingInfoBuffer, uint* RoutingInfoBufferSize);
alias PFAXGETROUTINGINFOW = extern(Windows) BOOL function(HANDLE FaxPortHandle, const(wchar)* RoutingGuid, ubyte** RoutingInfoBuffer, uint* RoutingInfoBufferSize);
alias PFAXSETROUTINGINFOA = extern(Windows) BOOL function(HANDLE FaxPortHandle, const(char)* RoutingGuid, const(ubyte)* RoutingInfoBuffer, uint RoutingInfoBufferSize);
alias PFAXSETROUTINGINFOW = extern(Windows) BOOL function(HANDLE FaxPortHandle, const(wchar)* RoutingGuid, const(ubyte)* RoutingInfoBuffer, uint RoutingInfoBufferSize);
alias PFAXINITIALIZEEVENTQUEUE = extern(Windows) BOOL function(HANDLE FaxHandle, HANDLE CompletionPort, uint CompletionKey, HWND hWnd, uint MessageStart);
alias PFAXFREEBUFFER = extern(Windows) void function(void* Buffer);
alias PFAXSTARTPRINTJOBA = extern(Windows) BOOL function(const(char)* PrinterName, const(FAX_PRINT_INFOA)* PrintInfo, uint* FaxJobId, FAX_CONTEXT_INFOA* FaxContextInfo);
alias PFAXSTARTPRINTJOBW = extern(Windows) BOOL function(const(wchar)* PrinterName, const(FAX_PRINT_INFOW)* PrintInfo, uint* FaxJobId, FAX_CONTEXT_INFOW* FaxContextInfo);
alias PFAXPRINTCOVERPAGEA = extern(Windows) BOOL function(const(FAX_CONTEXT_INFOA)* FaxContextInfo, const(FAX_COVERPAGE_INFOA)* CoverPageInfo);
alias PFAXPRINTCOVERPAGEW = extern(Windows) BOOL function(const(FAX_CONTEXT_INFOW)* FaxContextInfo, const(FAX_COVERPAGE_INFOW)* CoverPageInfo);
alias PFAXREGISTERSERVICEPROVIDERW = extern(Windows) BOOL function(const(wchar)* DeviceProvider, const(wchar)* FriendlyName, const(wchar)* ImageName, const(wchar)* TspName);
alias PFAXUNREGISTERSERVICEPROVIDERW = extern(Windows) BOOL function(const(wchar)* DeviceProvider);
alias PFAX_ROUTING_INSTALLATION_CALLBACKW = extern(Windows) BOOL function(HANDLE FaxHandle, void* Context, const(wchar)* MethodName, const(wchar)* FriendlyName, const(wchar)* FunctionName, const(wchar)* Guid);
alias PFAXREGISTERROUTINGEXTENSIONW = extern(Windows) BOOL function(HANDLE FaxHandle, const(wchar)* ExtensionName, const(wchar)* FriendlyName, const(wchar)* ImageName, PFAX_ROUTING_INSTALLATION_CALLBACKW CallBack, void* Context);
alias PFAXACCESSCHECK = extern(Windows) BOOL function(HANDLE FaxHandle, uint AccessMask);
struct FAX_SEND
{
    uint SizeOfStruct;
    const(wchar)* FileName;
    const(wchar)* CallerName;
    const(wchar)* CallerNumber;
    const(wchar)* ReceiverName;
    const(wchar)* ReceiverNumber;
    BOOL Branding;
    uint CallHandle;
    uint Reserved;
}

struct FAX_RECEIVE
{
    uint SizeOfStruct;
    const(wchar)* FileName;
    const(wchar)* ReceiverName;
    const(wchar)* ReceiverNumber;
    uint Reserved;
}

struct FAX_DEV_STATUS
{
    uint SizeOfStruct;
    uint StatusId;
    uint StringId;
    uint PageCount;
    const(wchar)* CSI;
    const(wchar)* CallerId;
    const(wchar)* RoutingInfo;
    uint ErrorCode;
    uint Reserved;
}

alias PFAX_SERVICE_CALLBACK = extern(Windows) BOOL function(HANDLE FaxHandle, uint DeviceId, uint Param1, uint Param2, uint Param3);
alias PFAX_LINECALLBACK = extern(Windows) void function(HANDLE FaxHandle, uint hDevice, uint dwMessage, uint dwInstance, uint dwParam1, uint dwParam2, uint dwParam3);
alias PFAX_SEND_CALLBACK = extern(Windows) BOOL function(HANDLE FaxHandle, uint CallHandle, uint Reserved1, uint Reserved2);
alias PFAXDEVINITIALIZE = extern(Windows) BOOL function(uint param0, HANDLE param1, PFAX_LINECALLBACK* param2, PFAX_SERVICE_CALLBACK param3);
alias PFAXDEVVIRTUALDEVICECREATION = extern(Windows) BOOL function(uint* DeviceCount, const(wchar)* DeviceNamePrefix, uint* DeviceIdPrefix, HANDLE CompletionPort, uint CompletionKey);
alias PFAXDEVSTARTJOB = extern(Windows) BOOL function(uint param0, uint param1, int* param2, HANDLE param3, uint param4);
alias PFAXDEVENDJOB = extern(Windows) BOOL function(HANDLE param0);
alias PFAXDEVSEND = extern(Windows) BOOL function(HANDLE param0, FAX_SEND* param1, PFAX_SEND_CALLBACK param2);
alias PFAXDEVRECEIVE = extern(Windows) BOOL function(HANDLE param0, uint param1, FAX_RECEIVE* param2);
alias PFAXDEVREPORTSTATUS = extern(Windows) BOOL function(HANDLE param0, FAX_DEV_STATUS* param1, uint param2, uint* param3);
alias PFAXDEVABORTOPERATION = extern(Windows) BOOL function(HANDLE param0);
alias PFAXDEVCONFIGURE = extern(Windows) BOOL function(HPROPSHEETPAGE* param0);
alias PFAXDEVSHUTDOWN = extern(Windows) HRESULT function();
const GUID CLSID_FaxServer = {0xCDA8ACB0, 0x8CF5, 0x4F6C, [0x9B, 0xA2, 0x59, 0x31, 0xD4, 0x0C, 0x8C, 0xAE]};
@GUID(0xCDA8ACB0, 0x8CF5, 0x4F6C, [0x9B, 0xA2, 0x59, 0x31, 0xD4, 0x0C, 0x8C, 0xAE]);
struct FaxServer;

const GUID CLSID_FaxDeviceProviders = {0xEB8FE768, 0x875A, 0x4F5F, [0x82, 0xC5, 0x03, 0xF2, 0x3A, 0xAC, 0x1B, 0xD7]};
@GUID(0xEB8FE768, 0x875A, 0x4F5F, [0x82, 0xC5, 0x03, 0xF2, 0x3A, 0xAC, 0x1B, 0xD7]);
struct FaxDeviceProviders;

const GUID CLSID_FaxDevices = {0x5589E28E, 0x23CB, 0x4919, [0x88, 0x08, 0xE6, 0x10, 0x18, 0x46, 0xE8, 0x0D]};
@GUID(0x5589E28E, 0x23CB, 0x4919, [0x88, 0x08, 0xE6, 0x10, 0x18, 0x46, 0xE8, 0x0D]);
struct FaxDevices;

const GUID CLSID_FaxInboundRouting = {0xE80248ED, 0xAD65, 0x4218, [0x81, 0x08, 0x99, 0x19, 0x24, 0xD4, 0xE7, 0xED]};
@GUID(0xE80248ED, 0xAD65, 0x4218, [0x81, 0x08, 0x99, 0x19, 0x24, 0xD4, 0xE7, 0xED]);
struct FaxInboundRouting;

const GUID CLSID_FaxFolders = {0xC35211D7, 0x5776, 0x48CB, [0xAF, 0x44, 0xC3, 0x1B, 0xE3, 0xB2, 0xCF, 0xE5]};
@GUID(0xC35211D7, 0x5776, 0x48CB, [0xAF, 0x44, 0xC3, 0x1B, 0xE3, 0xB2, 0xCF, 0xE5]);
struct FaxFolders;

const GUID CLSID_FaxLoggingOptions = {0x1BF9EEA6, 0xECE0, 0x4785, [0xA1, 0x8B, 0xDE, 0x56, 0xE9, 0xEE, 0xF9, 0x6A]};
@GUID(0x1BF9EEA6, 0xECE0, 0x4785, [0xA1, 0x8B, 0xDE, 0x56, 0xE9, 0xEE, 0xF9, 0x6A]);
struct FaxLoggingOptions;

const GUID CLSID_FaxActivity = {0xCFEF5D0E, 0xE84D, 0x462E, [0xAA, 0xBB, 0x87, 0xD3, 0x1E, 0xB0, 0x4F, 0xEF]};
@GUID(0xCFEF5D0E, 0xE84D, 0x462E, [0xAA, 0xBB, 0x87, 0xD3, 0x1E, 0xB0, 0x4F, 0xEF]);
struct FaxActivity;

const GUID CLSID_FaxOutboundRouting = {0xC81B385E, 0xB869, 0x4AFD, [0x86, 0xC0, 0x61, 0x64, 0x98, 0xED, 0x9B, 0xE2]};
@GUID(0xC81B385E, 0xB869, 0x4AFD, [0x86, 0xC0, 0x61, 0x64, 0x98, 0xED, 0x9B, 0xE2]);
struct FaxOutboundRouting;

const GUID CLSID_FaxReceiptOptions = {0x6982487B, 0x227B, 0x4C96, [0xA6, 0x1C, 0x24, 0x83, 0x48, 0xB0, 0x5A, 0xB6]};
@GUID(0x6982487B, 0x227B, 0x4C96, [0xA6, 0x1C, 0x24, 0x83, 0x48, 0xB0, 0x5A, 0xB6]);
struct FaxReceiptOptions;

const GUID CLSID_FaxSecurity = {0x10C4DDDE, 0xABF0, 0x43DF, [0x96, 0x4F, 0x7F, 0x3A, 0xC2, 0x1A, 0x4C, 0x7B]};
@GUID(0x10C4DDDE, 0xABF0, 0x43DF, [0x96, 0x4F, 0x7F, 0x3A, 0xC2, 0x1A, 0x4C, 0x7B]);
struct FaxSecurity;

const GUID CLSID_FaxDocument = {0x0F3F9F91, 0xC838, 0x415E, [0xA4, 0xF3, 0x3E, 0x82, 0x8C, 0xA4, 0x45, 0xE0]};
@GUID(0x0F3F9F91, 0xC838, 0x415E, [0xA4, 0xF3, 0x3E, 0x82, 0x8C, 0xA4, 0x45, 0xE0]);
struct FaxDocument;

const GUID CLSID_FaxSender = {0x265D84D0, 0x1850, 0x4360, [0xB7, 0xC8, 0x75, 0x8B, 0xBB, 0x5F, 0x0B, 0x96]};
@GUID(0x265D84D0, 0x1850, 0x4360, [0xB7, 0xC8, 0x75, 0x8B, 0xBB, 0x5F, 0x0B, 0x96]);
struct FaxSender;

const GUID CLSID_FaxRecipients = {0xEA9BDF53, 0x10A9, 0x4D4F, [0xA0, 0x67, 0x63, 0xC8, 0xF8, 0x4F, 0x01, 0xB0]};
@GUID(0xEA9BDF53, 0x10A9, 0x4D4F, [0xA0, 0x67, 0x63, 0xC8, 0xF8, 0x4F, 0x01, 0xB0]);
struct FaxRecipients;

const GUID CLSID_FaxIncomingArchive = {0x8426C56A, 0x35A1, 0x4C6F, [0xAF, 0x93, 0xFC, 0x95, 0x24, 0x22, 0xE2, 0xC2]};
@GUID(0x8426C56A, 0x35A1, 0x4C6F, [0xAF, 0x93, 0xFC, 0x95, 0x24, 0x22, 0xE2, 0xC2]);
struct FaxIncomingArchive;

const GUID CLSID_FaxIncomingQueue = {0x69131717, 0xF3F1, 0x40E3, [0x80, 0x9D, 0xA6, 0xCB, 0xF7, 0xBD, 0x85, 0xE5]};
@GUID(0x69131717, 0xF3F1, 0x40E3, [0x80, 0x9D, 0xA6, 0xCB, 0xF7, 0xBD, 0x85, 0xE5]);
struct FaxIncomingQueue;

const GUID CLSID_FaxOutgoingArchive = {0x43C28403, 0xE04F, 0x474D, [0x99, 0x0C, 0xB9, 0x46, 0x69, 0x14, 0x8F, 0x59]};
@GUID(0x43C28403, 0xE04F, 0x474D, [0x99, 0x0C, 0xB9, 0x46, 0x69, 0x14, 0x8F, 0x59]);
struct FaxOutgoingArchive;

const GUID CLSID_FaxOutgoingQueue = {0x7421169E, 0x8C43, 0x4B0D, [0xBB, 0x16, 0x64, 0x5C, 0x8F, 0xA4, 0x03, 0x57]};
@GUID(0x7421169E, 0x8C43, 0x4B0D, [0xBB, 0x16, 0x64, 0x5C, 0x8F, 0xA4, 0x03, 0x57]);
struct FaxOutgoingQueue;

const GUID CLSID_FaxIncomingMessageIterator = {0x6088E1D8, 0x3FC8, 0x45C2, [0x87, 0xB1, 0x90, 0x9A, 0x29, 0x60, 0x7E, 0xA9]};
@GUID(0x6088E1D8, 0x3FC8, 0x45C2, [0x87, 0xB1, 0x90, 0x9A, 0x29, 0x60, 0x7E, 0xA9]);
struct FaxIncomingMessageIterator;

const GUID CLSID_FaxIncomingMessage = {0x1932FCF7, 0x9D43, 0x4D5A, [0x89, 0xFF, 0x03, 0x86, 0x1B, 0x32, 0x17, 0x36]};
@GUID(0x1932FCF7, 0x9D43, 0x4D5A, [0x89, 0xFF, 0x03, 0x86, 0x1B, 0x32, 0x17, 0x36]);
struct FaxIncomingMessage;

const GUID CLSID_FaxOutgoingJobs = {0x92BF2A6C, 0x37BE, 0x43FA, [0xA3, 0x7D, 0xCB, 0x0E, 0x5F, 0x75, 0x3B, 0x35]};
@GUID(0x92BF2A6C, 0x37BE, 0x43FA, [0xA3, 0x7D, 0xCB, 0x0E, 0x5F, 0x75, 0x3B, 0x35]);
struct FaxOutgoingJobs;

const GUID CLSID_FaxOutgoingJob = {0x71BB429C, 0x0EF9, 0x4915, [0xBE, 0xC5, 0xA5, 0xD8, 0x97, 0xA3, 0xE9, 0x24]};
@GUID(0x71BB429C, 0x0EF9, 0x4915, [0xBE, 0xC5, 0xA5, 0xD8, 0x97, 0xA3, 0xE9, 0x24]);
struct FaxOutgoingJob;

const GUID CLSID_FaxOutgoingMessageIterator = {0x8A3224D0, 0xD30B, 0x49DE, [0x98, 0x13, 0xCB, 0x38, 0x57, 0x90, 0xFB, 0xBB]};
@GUID(0x8A3224D0, 0xD30B, 0x49DE, [0x98, 0x13, 0xCB, 0x38, 0x57, 0x90, 0xFB, 0xBB]);
struct FaxOutgoingMessageIterator;

const GUID CLSID_FaxOutgoingMessage = {0x91B4A378, 0x4AD8, 0x4AEF, [0xA4, 0xDC, 0x97, 0xD9, 0x6E, 0x93, 0x9A, 0x3A]};
@GUID(0x91B4A378, 0x4AD8, 0x4AEF, [0xA4, 0xDC, 0x97, 0xD9, 0x6E, 0x93, 0x9A, 0x3A]);
struct FaxOutgoingMessage;

const GUID CLSID_FaxIncomingJobs = {0xA1BB8A43, 0x8866, 0x4FB7, [0xA1, 0x5D, 0x62, 0x66, 0xC8, 0x75, 0xA5, 0xCC]};
@GUID(0xA1BB8A43, 0x8866, 0x4FB7, [0xA1, 0x5D, 0x62, 0x66, 0xC8, 0x75, 0xA5, 0xCC]);
struct FaxIncomingJobs;

const GUID CLSID_FaxIncomingJob = {0xC47311EC, 0xAE32, 0x41B8, [0xAE, 0x4B, 0x3E, 0xAE, 0x06, 0x29, 0xD0, 0xC9]};
@GUID(0xC47311EC, 0xAE32, 0x41B8, [0xAE, 0x4B, 0x3E, 0xAE, 0x06, 0x29, 0xD0, 0xC9]);
struct FaxIncomingJob;

const GUID CLSID_FaxDeviceProvider = {0x17CF1AA3, 0xF5EB, 0x484A, [0x9C, 0x9A, 0x44, 0x40, 0xA5, 0xBA, 0xAB, 0xFC]};
@GUID(0x17CF1AA3, 0xF5EB, 0x484A, [0x9C, 0x9A, 0x44, 0x40, 0xA5, 0xBA, 0xAB, 0xFC]);
struct FaxDeviceProvider;

const GUID CLSID_FaxDevice = {0x59E3A5B2, 0xD676, 0x484B, [0xA6, 0xDE, 0x72, 0x0B, 0xFA, 0x89, 0xB5, 0xAF]};
@GUID(0x59E3A5B2, 0xD676, 0x484B, [0xA6, 0xDE, 0x72, 0x0B, 0xFA, 0x89, 0xB5, 0xAF]);
struct FaxDevice;

const GUID CLSID_FaxActivityLogging = {0xF0A0294E, 0x3BBD, 0x48B8, [0x8F, 0x13, 0x8C, 0x59, 0x1A, 0x55, 0xBD, 0xBC]};
@GUID(0xF0A0294E, 0x3BBD, 0x48B8, [0x8F, 0x13, 0x8C, 0x59, 0x1A, 0x55, 0xBD, 0xBC]);
struct FaxActivityLogging;

const GUID CLSID_FaxEventLogging = {0xA6850930, 0xA0F6, 0x4A6F, [0x95, 0xB7, 0xDB, 0x2E, 0xBF, 0x3D, 0x02, 0xE3]};
@GUID(0xA6850930, 0xA0F6, 0x4A6F, [0x95, 0xB7, 0xDB, 0x2E, 0xBF, 0x3D, 0x02, 0xE3]);
struct FaxEventLogging;

const GUID CLSID_FaxOutboundRoutingGroups = {0xCCBEA1A5, 0xE2B4, 0x4B57, [0x94, 0x21, 0xB0, 0x4B, 0x62, 0x89, 0x46, 0x4B]};
@GUID(0xCCBEA1A5, 0xE2B4, 0x4B57, [0x94, 0x21, 0xB0, 0x4B, 0x62, 0x89, 0x46, 0x4B]);
struct FaxOutboundRoutingGroups;

const GUID CLSID_FaxOutboundRoutingGroup = {0x0213F3E0, 0x6791, 0x4D77, [0xA2, 0x71, 0x04, 0xD2, 0x35, 0x7C, 0x50, 0xD6]};
@GUID(0x0213F3E0, 0x6791, 0x4D77, [0xA2, 0x71, 0x04, 0xD2, 0x35, 0x7C, 0x50, 0xD6]);
struct FaxOutboundRoutingGroup;

const GUID CLSID_FaxDeviceIds = {0xCDC539EA, 0x7277, 0x460E, [0x8D, 0xE0, 0x48, 0xA0, 0xA5, 0x76, 0x0D, 0x1F]};
@GUID(0xCDC539EA, 0x7277, 0x460E, [0x8D, 0xE0, 0x48, 0xA0, 0xA5, 0x76, 0x0D, 0x1F]);
struct FaxDeviceIds;

const GUID CLSID_FaxOutboundRoutingRules = {0xD385BECA, 0xE624, 0x4473, [0xBF, 0xAA, 0x9F, 0x40, 0x00, 0x83, 0x1F, 0x54]};
@GUID(0xD385BECA, 0xE624, 0x4473, [0xBF, 0xAA, 0x9F, 0x40, 0x00, 0x83, 0x1F, 0x54]);
struct FaxOutboundRoutingRules;

const GUID CLSID_FaxOutboundRoutingRule = {0x6549EEBF, 0x08D1, 0x475A, [0x82, 0x8B, 0x3B, 0xF1, 0x05, 0x95, 0x2F, 0xA0]};
@GUID(0x6549EEBF, 0x08D1, 0x475A, [0x82, 0x8B, 0x3B, 0xF1, 0x05, 0x95, 0x2F, 0xA0]);
struct FaxOutboundRoutingRule;

const GUID CLSID_FaxInboundRoutingExtensions = {0x189A48ED, 0x623C, 0x4C0D, [0x80, 0xF2, 0xD6, 0x6C, 0x7B, 0x9E, 0xFE, 0xC2]};
@GUID(0x189A48ED, 0x623C, 0x4C0D, [0x80, 0xF2, 0xD6, 0x6C, 0x7B, 0x9E, 0xFE, 0xC2]);
struct FaxInboundRoutingExtensions;

const GUID CLSID_FaxInboundRoutingExtension = {0x1D7DFB51, 0x7207, 0x4436, [0xA0, 0xD9, 0x24, 0xE3, 0x2E, 0xE5, 0x69, 0x88]};
@GUID(0x1D7DFB51, 0x7207, 0x4436, [0xA0, 0xD9, 0x24, 0xE3, 0x2E, 0xE5, 0x69, 0x88]);
struct FaxInboundRoutingExtension;

const GUID CLSID_FaxInboundRoutingMethods = {0x25FCB76A, 0xB750, 0x4B82, [0x92, 0x66, 0xFB, 0xBB, 0xAE, 0x89, 0x22, 0xBA]};
@GUID(0x25FCB76A, 0xB750, 0x4B82, [0x92, 0x66, 0xFB, 0xBB, 0xAE, 0x89, 0x22, 0xBA]);
struct FaxInboundRoutingMethods;

const GUID CLSID_FaxInboundRoutingMethod = {0x4B9FD75C, 0x0194, 0x4B72, [0x9C, 0xE5, 0x02, 0xA8, 0x20, 0x5A, 0xC7, 0xD4]};
@GUID(0x4B9FD75C, 0x0194, 0x4B72, [0x9C, 0xE5, 0x02, 0xA8, 0x20, 0x5A, 0xC7, 0xD4]);
struct FaxInboundRoutingMethod;

const GUID CLSID_FaxJobStatus = {0x7BF222F4, 0xBE8D, 0x442F, [0x84, 0x1D, 0x61, 0x32, 0x74, 0x24, 0x23, 0xBB]};
@GUID(0x7BF222F4, 0xBE8D, 0x442F, [0x84, 0x1D, 0x61, 0x32, 0x74, 0x24, 0x23, 0xBB]);
struct FaxJobStatus;

const GUID CLSID_FaxRecipient = {0x60BF3301, 0x7DF8, 0x4BD8, [0x91, 0x48, 0x7B, 0x58, 0x01, 0xF9, 0xEF, 0xDF]};
@GUID(0x60BF3301, 0x7DF8, 0x4BD8, [0x91, 0x48, 0x7B, 0x58, 0x01, 0xF9, 0xEF, 0xDF]);
struct FaxRecipient;

const GUID CLSID_FaxConfiguration = {0x5857326F, 0xE7B3, 0x41A7, [0x9C, 0x19, 0xA9, 0x1B, 0x46, 0x3E, 0x2D, 0x56]};
@GUID(0x5857326F, 0xE7B3, 0x41A7, [0x9C, 0x19, 0xA9, 0x1B, 0x46, 0x3E, 0x2D, 0x56]);
struct FaxConfiguration;

const GUID CLSID_FaxAccountSet = {0xFBC23C4B, 0x79E0, 0x4291, [0xBC, 0x56, 0xC1, 0x2E, 0x25, 0x3B, 0xBF, 0x3A]};
@GUID(0xFBC23C4B, 0x79E0, 0x4291, [0xBC, 0x56, 0xC1, 0x2E, 0x25, 0x3B, 0xBF, 0x3A]);
struct FaxAccountSet;

const GUID CLSID_FaxAccounts = {0xDA1F94AA, 0xEE2C, 0x47C0, [0x8F, 0x4F, 0x2A, 0x21, 0x70, 0x75, 0xB7, 0x6E]};
@GUID(0xDA1F94AA, 0xEE2C, 0x47C0, [0x8F, 0x4F, 0x2A, 0x21, 0x70, 0x75, 0xB7, 0x6E]);
struct FaxAccounts;

const GUID CLSID_FaxAccount = {0xA7E0647F, 0x4524, 0x4464, [0xA5, 0x6D, 0xB9, 0xFE, 0x66, 0x6F, 0x71, 0x5E]};
@GUID(0xA7E0647F, 0x4524, 0x4464, [0xA5, 0x6D, 0xB9, 0xFE, 0x66, 0x6F, 0x71, 0x5E]);
struct FaxAccount;

const GUID CLSID_FaxAccountFolders = {0x85398F49, 0xC034, 0x4A3F, [0x82, 0x1C, 0xDB, 0x7D, 0x68, 0x5E, 0x81, 0x29]};
@GUID(0x85398F49, 0xC034, 0x4A3F, [0x82, 0x1C, 0xDB, 0x7D, 0x68, 0x5E, 0x81, 0x29]);
struct FaxAccountFolders;

const GUID CLSID_FaxAccountIncomingQueue = {0x9BCF6094, 0xB4DA, 0x45F4, [0xB8, 0xD6, 0xDD, 0xEB, 0x21, 0x86, 0x65, 0x2C]};
@GUID(0x9BCF6094, 0xB4DA, 0x45F4, [0xB8, 0xD6, 0xDD, 0xEB, 0x21, 0x86, 0x65, 0x2C]);
struct FaxAccountIncomingQueue;

const GUID CLSID_FaxAccountOutgoingQueue = {0xFEECEEFB, 0xC149, 0x48BA, [0xBA, 0xB8, 0xB7, 0x91, 0xE1, 0x01, 0xF6, 0x2F]};
@GUID(0xFEECEEFB, 0xC149, 0x48BA, [0xBA, 0xB8, 0xB7, 0x91, 0xE1, 0x01, 0xF6, 0x2F]);
struct FaxAccountOutgoingQueue;

const GUID CLSID_FaxAccountIncomingArchive = {0x14B33DB5, 0x4C40, 0x4ECF, [0x9E, 0xF8, 0xA3, 0x60, 0xCB, 0xE8, 0x09, 0xED]};
@GUID(0x14B33DB5, 0x4C40, 0x4ECF, [0x9E, 0xF8, 0xA3, 0x60, 0xCB, 0xE8, 0x09, 0xED]);
struct FaxAccountIncomingArchive;

const GUID CLSID_FaxAccountOutgoingArchive = {0x851E7AF5, 0x433A, 0x4739, [0xA2, 0xDF, 0xAD, 0x24, 0x5C, 0x2C, 0xB9, 0x8E]};
@GUID(0x851E7AF5, 0x433A, 0x4739, [0xA2, 0xDF, 0xAD, 0x24, 0x5C, 0x2C, 0xB9, 0x8E]);
struct FaxAccountOutgoingArchive;

const GUID CLSID_FaxSecurity2 = {0x735C1248, 0xEC89, 0x4C30, [0xA1, 0x27, 0x65, 0x6E, 0x92, 0xE3, 0xC4, 0xEA]};
@GUID(0x735C1248, 0xEC89, 0x4C30, [0xA1, 0x27, 0x65, 0x6E, 0x92, 0xE3, 0xC4, 0xEA]);
struct FaxSecurity2;

enum FAX_JOB_STATUS_ENUM
{
    fjsPENDING = 1,
    fjsINPROGRESS = 2,
    fjsFAILED = 8,
    fjsPAUSED = 16,
    fjsNOLINE = 32,
    fjsRETRYING = 64,
    fjsRETRIES_EXCEEDED = 128,
    fjsCOMPLETED = 256,
    fjsCANCELED = 512,
    fjsCANCELING = 1024,
    fjsROUTING = 2048,
}

enum FAX_JOB_EXTENDED_STATUS_ENUM
{
    fjesNONE = 0,
    fjesDISCONNECTED = 1,
    fjesINITIALIZING = 2,
    fjesDIALING = 3,
    fjesTRANSMITTING = 4,
    fjesANSWERED = 5,
    fjesRECEIVING = 6,
    fjesLINE_UNAVAILABLE = 7,
    fjesBUSY = 8,
    fjesNO_ANSWER = 9,
    fjesBAD_ADDRESS = 10,
    fjesNO_DIAL_TONE = 11,
    fjesFATAL_ERROR = 12,
    fjesCALL_DELAYED = 13,
    fjesCALL_BLACKLISTED = 14,
    fjesNOT_FAX_CALL = 15,
    fjesPARTIALLY_RECEIVED = 16,
    fjesHANDLED = 17,
    fjesCALL_COMPLETED = 18,
    fjesCALL_ABORTED = 19,
    fjesPROPRIETARY = 16777216,
}

enum FAX_JOB_OPERATIONS_ENUM
{
    fjoVIEW = 1,
    fjoPAUSE = 2,
    fjoRESUME = 4,
    fjoRESTART = 8,
    fjoDELETE = 16,
    fjoRECIPIENT_INFO = 32,
    fjoSENDER_INFO = 64,
}

enum FAX_JOB_TYPE_ENUM
{
    fjtSEND = 0,
    fjtRECEIVE = 1,
    fjtROUTING = 2,
}

const GUID IID_IFaxJobStatus = {0x8B86F485, 0xFD7F, 0x4824, [0x88, 0x6B, 0x40, 0xC5, 0xCA, 0xA6, 0x17, 0xCC]};
@GUID(0x8B86F485, 0xFD7F, 0x4824, [0x88, 0x6B, 0x40, 0xC5, 0xCA, 0xA6, 0x17, 0xCC]);
interface IFaxJobStatus : IDispatch
{
    HRESULT get_Status(FAX_JOB_STATUS_ENUM* pStatus);
    HRESULT get_Pages(int* plPages);
    HRESULT get_Size(int* plSize);
    HRESULT get_CurrentPage(int* plCurrentPage);
    HRESULT get_DeviceId(int* plDeviceId);
    HRESULT get_CSID(BSTR* pbstrCSID);
    HRESULT get_TSID(BSTR* pbstrTSID);
    HRESULT get_ExtendedStatusCode(FAX_JOB_EXTENDED_STATUS_ENUM* pExtendedStatusCode);
    HRESULT get_ExtendedStatus(BSTR* pbstrExtendedStatus);
    HRESULT get_AvailableOperations(FAX_JOB_OPERATIONS_ENUM* pAvailableOperations);
    HRESULT get_Retries(int* plRetries);
    HRESULT get_JobType(FAX_JOB_TYPE_ENUM* pJobType);
    HRESULT get_ScheduledTime(double* pdateScheduledTime);
    HRESULT get_TransmissionStart(double* pdateTransmissionStart);
    HRESULT get_TransmissionEnd(double* pdateTransmissionEnd);
    HRESULT get_CallerId(BSTR* pbstrCallerId);
    HRESULT get_RoutingInformation(BSTR* pbstrRoutingInformation);
}

enum FAX_SERVER_EVENTS_TYPE_ENUM
{
    fsetNONE = 0,
    fsetIN_QUEUE = 1,
    fsetOUT_QUEUE = 2,
    fsetCONFIG = 4,
    fsetACTIVITY = 8,
    fsetQUEUE_STATE = 16,
    fsetIN_ARCHIVE = 32,
    fsetOUT_ARCHIVE = 64,
    fsetFXSSVC_ENDED = 128,
    fsetDEVICE_STATUS = 256,
    fsetINCOMING_CALL = 512,
}

enum FAX_SERVER_APIVERSION_ENUM
{
    fsAPI_VERSION_0 = 0,
    fsAPI_VERSION_1 = 65536,
    fsAPI_VERSION_2 = 131072,
    fsAPI_VERSION_3 = 196608,
}

const GUID IID_IFaxServer = {0x475B6469, 0x90A5, 0x4878, [0xA5, 0x77, 0x17, 0xA8, 0x6E, 0x8E, 0x34, 0x62]};
@GUID(0x475B6469, 0x90A5, 0x4878, [0xA5, 0x77, 0x17, 0xA8, 0x6E, 0x8E, 0x34, 0x62]);
interface IFaxServer : IDispatch
{
    HRESULT Connect(BSTR bstrServerName);
    HRESULT get_ServerName(BSTR* pbstrServerName);
    HRESULT GetDeviceProviders(IFaxDeviceProviders* ppFaxDeviceProviders);
    HRESULT GetDevices(IFaxDevices* ppFaxDevices);
    HRESULT get_InboundRouting(IFaxInboundRouting* ppFaxInboundRouting);
    HRESULT get_Folders(IFaxFolders* pFaxFolders);
    HRESULT get_LoggingOptions(IFaxLoggingOptions* ppFaxLoggingOptions);
    HRESULT get_MajorVersion(int* plMajorVersion);
    HRESULT get_MinorVersion(int* plMinorVersion);
    HRESULT get_MajorBuild(int* plMajorBuild);
    HRESULT get_MinorBuild(int* plMinorBuild);
    HRESULT get_Debug(short* pbDebug);
    HRESULT get_Activity(IFaxActivity* ppFaxActivity);
    HRESULT get_OutboundRouting(IFaxOutboundRouting* ppFaxOutboundRouting);
    HRESULT get_ReceiptOptions(IFaxReceiptOptions* ppFaxReceiptOptions);
    HRESULT get_Security(IFaxSecurity* ppFaxSecurity);
    HRESULT Disconnect();
    HRESULT GetExtensionProperty(BSTR bstrGUID, VARIANT* pvProperty);
    HRESULT SetExtensionProperty(BSTR bstrGUID, VARIANT vProperty);
    HRESULT ListenToServerEvents(FAX_SERVER_EVENTS_TYPE_ENUM EventTypes);
    HRESULT RegisterDeviceProvider(BSTR bstrGUID, BSTR bstrFriendlyName, BSTR bstrImageName, BSTR TspName, int lFSPIVersion);
    HRESULT UnregisterDeviceProvider(BSTR bstrUniqueName);
    HRESULT RegisterInboundRoutingExtension(BSTR bstrExtensionName, BSTR bstrFriendlyName, BSTR bstrImageName, VARIANT vMethods);
    HRESULT UnregisterInboundRoutingExtension(BSTR bstrExtensionUniqueName);
    HRESULT get_RegisteredEvents(FAX_SERVER_EVENTS_TYPE_ENUM* pEventTypes);
    HRESULT get_APIVersion(FAX_SERVER_APIVERSION_ENUM* pAPIVersion);
}

const GUID IID_IFaxDeviceProviders = {0x9FB76F62, 0x4C7E, 0x43A5, [0xB6, 0xFD, 0x50, 0x28, 0x93, 0xF7, 0xE1, 0x3E]};
@GUID(0x9FB76F62, 0x4C7E, 0x43A5, [0xB6, 0xFD, 0x50, 0x28, 0x93, 0xF7, 0xE1, 0x3E]);
interface IFaxDeviceProviders : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(VARIANT vIndex, IFaxDeviceProvider* pFaxDeviceProvider);
    HRESULT get_Count(int* plCount);
}

const GUID IID_IFaxDevices = {0x9E46783E, 0xF34F, 0x482E, [0xA3, 0x60, 0x04, 0x16, 0xBE, 0xCB, 0xBD, 0x96]};
@GUID(0x9E46783E, 0xF34F, 0x482E, [0xA3, 0x60, 0x04, 0x16, 0xBE, 0xCB, 0xBD, 0x96]);
interface IFaxDevices : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(VARIANT vIndex, IFaxDevice* pFaxDevice);
    HRESULT get_Count(int* plCount);
    HRESULT get_ItemById(int lId, IFaxDevice* ppFaxDevice);
}

const GUID IID_IFaxInboundRouting = {0x8148C20F, 0x9D52, 0x45B1, [0xBF, 0x96, 0x38, 0xFC, 0x12, 0x71, 0x35, 0x27]};
@GUID(0x8148C20F, 0x9D52, 0x45B1, [0xBF, 0x96, 0x38, 0xFC, 0x12, 0x71, 0x35, 0x27]);
interface IFaxInboundRouting : IDispatch
{
    HRESULT GetExtensions(IFaxInboundRoutingExtensions* pFaxInboundRoutingExtensions);
    HRESULT GetMethods(IFaxInboundRoutingMethods* pFaxInboundRoutingMethods);
}

const GUID IID_IFaxFolders = {0xDCE3B2A8, 0xA7AB, 0x42BC, [0x9D, 0x0A, 0x31, 0x49, 0x45, 0x72, 0x61, 0xA0]};
@GUID(0xDCE3B2A8, 0xA7AB, 0x42BC, [0x9D, 0x0A, 0x31, 0x49, 0x45, 0x72, 0x61, 0xA0]);
interface IFaxFolders : IDispatch
{
    HRESULT get_OutgoingQueue(IFaxOutgoingQueue* pFaxOutgoingQueue);
    HRESULT get_IncomingQueue(IFaxIncomingQueue* pFaxIncomingQueue);
    HRESULT get_IncomingArchive(IFaxIncomingArchive* pFaxIncomingArchive);
    HRESULT get_OutgoingArchive(IFaxOutgoingArchive* pFaxOutgoingArchive);
}

const GUID IID_IFaxLoggingOptions = {0x34E64FB9, 0x6B31, 0x4D32, [0x8B, 0x27, 0xD2, 0x86, 0xC0, 0xC3, 0x36, 0x06]};
@GUID(0x34E64FB9, 0x6B31, 0x4D32, [0x8B, 0x27, 0xD2, 0x86, 0xC0, 0xC3, 0x36, 0x06]);
interface IFaxLoggingOptions : IDispatch
{
    HRESULT get_EventLogging(IFaxEventLogging* pFaxEventLogging);
    HRESULT get_ActivityLogging(IFaxActivityLogging* pFaxActivityLogging);
}

const GUID IID_IFaxActivity = {0x4B106F97, 0x3DF5, 0x40F2, [0xBC, 0x3C, 0x44, 0xCB, 0x81, 0x15, 0xEB, 0xDF]};
@GUID(0x4B106F97, 0x3DF5, 0x40F2, [0xBC, 0x3C, 0x44, 0xCB, 0x81, 0x15, 0xEB, 0xDF]);
interface IFaxActivity : IDispatch
{
    HRESULT get_IncomingMessages(int* plIncomingMessages);
    HRESULT get_RoutingMessages(int* plRoutingMessages);
    HRESULT get_OutgoingMessages(int* plOutgoingMessages);
    HRESULT get_QueuedMessages(int* plQueuedMessages);
    HRESULT Refresh();
}

const GUID IID_IFaxOutboundRouting = {0x25DC05A4, 0x9909, 0x41BD, [0xA9, 0x5B, 0x7E, 0x5D, 0x1D, 0xEC, 0x1D, 0x43]};
@GUID(0x25DC05A4, 0x9909, 0x41BD, [0xA9, 0x5B, 0x7E, 0x5D, 0x1D, 0xEC, 0x1D, 0x43]);
interface IFaxOutboundRouting : IDispatch
{
    HRESULT GetGroups(IFaxOutboundRoutingGroups* pFaxOutboundRoutingGroups);
    HRESULT GetRules(IFaxOutboundRoutingRules* pFaxOutboundRoutingRules);
}

enum FAX_SMTP_AUTHENTICATION_TYPE_ENUM
{
    fsatANONYMOUS = 0,
    fsatBASIC = 1,
    fsatNTLM = 2,
}

enum FAX_RECEIPT_TYPE_ENUM
{
    frtNONE = 0,
    frtMAIL = 1,
    frtMSGBOX = 4,
}

const GUID IID_IFaxReceiptOptions = {0x378EFAEB, 0x5FCB, 0x4AFB, [0xB2, 0xEE, 0xE1, 0x6E, 0x80, 0x61, 0x44, 0x87]};
@GUID(0x378EFAEB, 0x5FCB, 0x4AFB, [0xB2, 0xEE, 0xE1, 0x6E, 0x80, 0x61, 0x44, 0x87]);
interface IFaxReceiptOptions : IDispatch
{
    HRESULT get_AuthenticationType(FAX_SMTP_AUTHENTICATION_TYPE_ENUM* pType);
    HRESULT put_AuthenticationType(FAX_SMTP_AUTHENTICATION_TYPE_ENUM Type);
    HRESULT get_SMTPServer(BSTR* pbstrSMTPServer);
    HRESULT put_SMTPServer(BSTR bstrSMTPServer);
    HRESULT get_SMTPPort(int* plSMTPPort);
    HRESULT put_SMTPPort(int lSMTPPort);
    HRESULT get_SMTPSender(BSTR* pbstrSMTPSender);
    HRESULT put_SMTPSender(BSTR bstrSMTPSender);
    HRESULT get_SMTPUser(BSTR* pbstrSMTPUser);
    HRESULT put_SMTPUser(BSTR bstrSMTPUser);
    HRESULT get_AllowedReceipts(FAX_RECEIPT_TYPE_ENUM* pAllowedReceipts);
    HRESULT put_AllowedReceipts(FAX_RECEIPT_TYPE_ENUM AllowedReceipts);
    HRESULT get_SMTPPassword(BSTR* pbstrSMTPPassword);
    HRESULT put_SMTPPassword(BSTR bstrSMTPPassword);
    HRESULT Refresh();
    HRESULT Save();
    HRESULT get_UseForInboundRouting(short* pbUseForInboundRouting);
    HRESULT put_UseForInboundRouting(short bUseForInboundRouting);
}

enum FAX_ACCESS_RIGHTS_ENUM
{
    farSUBMIT_LOW = 1,
    farSUBMIT_NORMAL = 2,
    farSUBMIT_HIGH = 4,
    farQUERY_JOBS = 8,
    farMANAGE_JOBS = 16,
    farQUERY_CONFIG = 32,
    farMANAGE_CONFIG = 64,
    farQUERY_IN_ARCHIVE = 128,
    farMANAGE_IN_ARCHIVE = 256,
    farQUERY_OUT_ARCHIVE = 512,
    farMANAGE_OUT_ARCHIVE = 1024,
}

const GUID IID_IFaxSecurity = {0x77B508C1, 0x09C0, 0x47A2, [0x91, 0xEB, 0xFC, 0xE7, 0xFD, 0xF2, 0x69, 0x0E]};
@GUID(0x77B508C1, 0x09C0, 0x47A2, [0x91, 0xEB, 0xFC, 0xE7, 0xFD, 0xF2, 0x69, 0x0E]);
interface IFaxSecurity : IDispatch
{
    HRESULT get_Descriptor(VARIANT* pvDescriptor);
    HRESULT put_Descriptor(VARIANT vDescriptor);
    HRESULT get_GrantedRights(FAX_ACCESS_RIGHTS_ENUM* pGrantedRights);
    HRESULT Refresh();
    HRESULT Save();
    HRESULT get_InformationType(int* plInformationType);
    HRESULT put_InformationType(int lInformationType);
}

enum FAX_PRIORITY_TYPE_ENUM
{
    fptLOW = 0,
    fptNORMAL = 1,
    fptHIGH = 2,
}

enum FAX_COVERPAGE_TYPE_ENUM
{
    fcptNONE = 0,
    fcptLOCAL = 1,
    fcptSERVER = 2,
}

enum FAX_SCHEDULE_TYPE_ENUM
{
    fstNOW = 0,
    fstSPECIFIC_TIME = 1,
    fstDISCOUNT_PERIOD = 2,
}

const GUID IID_IFaxDocument = {0xB207A246, 0x09E3, 0x4A4E, [0xA7, 0xDC, 0xFE, 0xA3, 0x1D, 0x29, 0x45, 0x8F]};
@GUID(0xB207A246, 0x09E3, 0x4A4E, [0xA7, 0xDC, 0xFE, 0xA3, 0x1D, 0x29, 0x45, 0x8F]);
interface IFaxDocument : IDispatch
{
    HRESULT get_Body(BSTR* pbstrBody);
    HRESULT put_Body(BSTR bstrBody);
    HRESULT get_Sender(IFaxSender* ppFaxSender);
    HRESULT get_Recipients(IFaxRecipients* ppFaxRecipients);
    HRESULT get_CoverPage(BSTR* pbstrCoverPage);
    HRESULT put_CoverPage(BSTR bstrCoverPage);
    HRESULT get_Subject(BSTR* pbstrSubject);
    HRESULT put_Subject(BSTR bstrSubject);
    HRESULT get_Note(BSTR* pbstrNote);
    HRESULT put_Note(BSTR bstrNote);
    HRESULT get_ScheduleTime(double* pdateScheduleTime);
    HRESULT put_ScheduleTime(double dateScheduleTime);
    HRESULT get_ReceiptAddress(BSTR* pbstrReceiptAddress);
    HRESULT put_ReceiptAddress(BSTR bstrReceiptAddress);
    HRESULT get_DocumentName(BSTR* pbstrDocumentName);
    HRESULT put_DocumentName(BSTR bstrDocumentName);
    HRESULT get_CallHandle(int* plCallHandle);
    HRESULT put_CallHandle(int lCallHandle);
    HRESULT get_CoverPageType(FAX_COVERPAGE_TYPE_ENUM* pCoverPageType);
    HRESULT put_CoverPageType(FAX_COVERPAGE_TYPE_ENUM CoverPageType);
    HRESULT get_ScheduleType(FAX_SCHEDULE_TYPE_ENUM* pScheduleType);
    HRESULT put_ScheduleType(FAX_SCHEDULE_TYPE_ENUM ScheduleType);
    HRESULT get_ReceiptType(FAX_RECEIPT_TYPE_ENUM* pReceiptType);
    HRESULT put_ReceiptType(FAX_RECEIPT_TYPE_ENUM ReceiptType);
    HRESULT get_GroupBroadcastReceipts(short* pbUseGrouping);
    HRESULT put_GroupBroadcastReceipts(short bUseGrouping);
    HRESULT get_Priority(FAX_PRIORITY_TYPE_ENUM* pPriority);
    HRESULT put_Priority(FAX_PRIORITY_TYPE_ENUM Priority);
    HRESULT get_TapiConnection(IDispatch* ppTapiConnection);
    HRESULT putref_TapiConnection(IDispatch pTapiConnection);
    HRESULT Submit(BSTR bstrFaxServerName, VARIANT* pvFaxOutgoingJobIDs);
    HRESULT ConnectedSubmit(IFaxServer pFaxServer, VARIANT* pvFaxOutgoingJobIDs);
    HRESULT get_AttachFaxToReceipt(short* pbAttachFax);
    HRESULT put_AttachFaxToReceipt(short bAttachFax);
}

const GUID IID_IFaxSender = {0x0D879D7D, 0xF57A, 0x4CC6, [0xA6, 0xF9, 0x3E, 0xE5, 0xD5, 0x27, 0xB4, 0x6A]};
@GUID(0x0D879D7D, 0xF57A, 0x4CC6, [0xA6, 0xF9, 0x3E, 0xE5, 0xD5, 0x27, 0xB4, 0x6A]);
interface IFaxSender : IDispatch
{
    HRESULT get_BillingCode(BSTR* pbstrBillingCode);
    HRESULT put_BillingCode(BSTR bstrBillingCode);
    HRESULT get_City(BSTR* pbstrCity);
    HRESULT put_City(BSTR bstrCity);
    HRESULT get_Company(BSTR* pbstrCompany);
    HRESULT put_Company(BSTR bstrCompany);
    HRESULT get_Country(BSTR* pbstrCountry);
    HRESULT put_Country(BSTR bstrCountry);
    HRESULT get_Department(BSTR* pbstrDepartment);
    HRESULT put_Department(BSTR bstrDepartment);
    HRESULT get_Email(BSTR* pbstrEmail);
    HRESULT put_Email(BSTR bstrEmail);
    HRESULT get_FaxNumber(BSTR* pbstrFaxNumber);
    HRESULT put_FaxNumber(BSTR bstrFaxNumber);
    HRESULT get_HomePhone(BSTR* pbstrHomePhone);
    HRESULT put_HomePhone(BSTR bstrHomePhone);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrName);
    HRESULT get_TSID(BSTR* pbstrTSID);
    HRESULT put_TSID(BSTR bstrTSID);
    HRESULT get_OfficePhone(BSTR* pbstrOfficePhone);
    HRESULT put_OfficePhone(BSTR bstrOfficePhone);
    HRESULT get_OfficeLocation(BSTR* pbstrOfficeLocation);
    HRESULT put_OfficeLocation(BSTR bstrOfficeLocation);
    HRESULT get_State(BSTR* pbstrState);
    HRESULT put_State(BSTR bstrState);
    HRESULT get_StreetAddress(BSTR* pbstrStreetAddress);
    HRESULT put_StreetAddress(BSTR bstrStreetAddress);
    HRESULT get_Title(BSTR* pbstrTitle);
    HRESULT put_Title(BSTR bstrTitle);
    HRESULT get_ZipCode(BSTR* pbstrZipCode);
    HRESULT put_ZipCode(BSTR bstrZipCode);
    HRESULT LoadDefaultSender();
    HRESULT SaveDefaultSender();
}

const GUID IID_IFaxRecipient = {0x9A3DA3A0, 0x538D, 0x42B6, [0x94, 0x44, 0xAA, 0xA5, 0x7D, 0x0C, 0xE2, 0xBC]};
@GUID(0x9A3DA3A0, 0x538D, 0x42B6, [0x94, 0x44, 0xAA, 0xA5, 0x7D, 0x0C, 0xE2, 0xBC]);
interface IFaxRecipient : IDispatch
{
    HRESULT get_FaxNumber(BSTR* pbstrFaxNumber);
    HRESULT put_FaxNumber(BSTR bstrFaxNumber);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrName);
}

const GUID IID_IFaxRecipients = {0xB9C9DE5A, 0x894E, 0x4492, [0x9F, 0xA3, 0x08, 0xC6, 0x27, 0xC1, 0x1D, 0x5D]};
@GUID(0xB9C9DE5A, 0x894E, 0x4492, [0x9F, 0xA3, 0x08, 0xC6, 0x27, 0xC1, 0x1D, 0x5D]);
interface IFaxRecipients : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(int lIndex, IFaxRecipient* ppFaxRecipient);
    HRESULT get_Count(int* plCount);
    HRESULT Add(BSTR bstrFaxNumber, BSTR bstrRecipientName, IFaxRecipient* ppFaxRecipient);
    HRESULT Remove(int lIndex);
}

const GUID IID_IFaxIncomingArchive = {0x76062CC7, 0xF714, 0x4FBD, [0xAA, 0x06, 0xED, 0x6E, 0x4A, 0x4B, 0x70, 0xF3]};
@GUID(0x76062CC7, 0xF714, 0x4FBD, [0xAA, 0x06, 0xED, 0x6E, 0x4A, 0x4B, 0x70, 0xF3]);
interface IFaxIncomingArchive : IDispatch
{
    HRESULT get_UseArchive(short* pbUseArchive);
    HRESULT put_UseArchive(short bUseArchive);
    HRESULT get_ArchiveFolder(BSTR* pbstrArchiveFolder);
    HRESULT put_ArchiveFolder(BSTR bstrArchiveFolder);
    HRESULT get_SizeQuotaWarning(short* pbSizeQuotaWarning);
    HRESULT put_SizeQuotaWarning(short bSizeQuotaWarning);
    HRESULT get_HighQuotaWaterMark(int* plHighQuotaWaterMark);
    HRESULT put_HighQuotaWaterMark(int lHighQuotaWaterMark);
    HRESULT get_LowQuotaWaterMark(int* plLowQuotaWaterMark);
    HRESULT put_LowQuotaWaterMark(int lLowQuotaWaterMark);
    HRESULT get_AgeLimit(int* plAgeLimit);
    HRESULT put_AgeLimit(int lAgeLimit);
    HRESULT get_SizeLow(int* plSizeLow);
    HRESULT get_SizeHigh(int* plSizeHigh);
    HRESULT Refresh();
    HRESULT Save();
    HRESULT GetMessages(int lPrefetchSize, IFaxIncomingMessageIterator* pFaxIncomingMessageIterator);
    HRESULT GetMessageA(BSTR bstrMessageId, IFaxIncomingMessage* pFaxIncomingMessage);
}

const GUID IID_IFaxIncomingQueue = {0x902E64EF, 0x8FD8, 0x4B75, [0x97, 0x25, 0x60, 0x14, 0xDF, 0x16, 0x15, 0x45]};
@GUID(0x902E64EF, 0x8FD8, 0x4B75, [0x97, 0x25, 0x60, 0x14, 0xDF, 0x16, 0x15, 0x45]);
interface IFaxIncomingQueue : IDispatch
{
    HRESULT get_Blocked(short* pbBlocked);
    HRESULT put_Blocked(short bBlocked);
    HRESULT Refresh();
    HRESULT Save();
    HRESULT GetJobs(IFaxIncomingJobs* pFaxIncomingJobs);
    HRESULT GetJobA(BSTR bstrJobId, IFaxIncomingJob* pFaxIncomingJob);
}

const GUID IID_IFaxOutgoingArchive = {0xC9C28F40, 0x8D80, 0x4E53, [0x81, 0x0F, 0x9A, 0x79, 0x91, 0x9B, 0x49, 0xFD]};
@GUID(0xC9C28F40, 0x8D80, 0x4E53, [0x81, 0x0F, 0x9A, 0x79, 0x91, 0x9B, 0x49, 0xFD]);
interface IFaxOutgoingArchive : IDispatch
{
    HRESULT get_UseArchive(short* pbUseArchive);
    HRESULT put_UseArchive(short bUseArchive);
    HRESULT get_ArchiveFolder(BSTR* pbstrArchiveFolder);
    HRESULT put_ArchiveFolder(BSTR bstrArchiveFolder);
    HRESULT get_SizeQuotaWarning(short* pbSizeQuotaWarning);
    HRESULT put_SizeQuotaWarning(short bSizeQuotaWarning);
    HRESULT get_HighQuotaWaterMark(int* plHighQuotaWaterMark);
    HRESULT put_HighQuotaWaterMark(int lHighQuotaWaterMark);
    HRESULT get_LowQuotaWaterMark(int* plLowQuotaWaterMark);
    HRESULT put_LowQuotaWaterMark(int lLowQuotaWaterMark);
    HRESULT get_AgeLimit(int* plAgeLimit);
    HRESULT put_AgeLimit(int lAgeLimit);
    HRESULT get_SizeLow(int* plSizeLow);
    HRESULT get_SizeHigh(int* plSizeHigh);
    HRESULT Refresh();
    HRESULT Save();
    HRESULT GetMessages(int lPrefetchSize, IFaxOutgoingMessageIterator* pFaxOutgoingMessageIterator);
    HRESULT GetMessageA(BSTR bstrMessageId, IFaxOutgoingMessage* pFaxOutgoingMessage);
}

const GUID IID_IFaxOutgoingQueue = {0x80B1DF24, 0xD9AC, 0x4333, [0xB3, 0x73, 0x48, 0x7C, 0xED, 0xC8, 0x0C, 0xE5]};
@GUID(0x80B1DF24, 0xD9AC, 0x4333, [0xB3, 0x73, 0x48, 0x7C, 0xED, 0xC8, 0x0C, 0xE5]);
interface IFaxOutgoingQueue : IDispatch
{
    HRESULT get_Blocked(short* pbBlocked);
    HRESULT put_Blocked(short bBlocked);
    HRESULT get_Paused(short* pbPaused);
    HRESULT put_Paused(short bPaused);
    HRESULT get_AllowPersonalCoverPages(short* pbAllowPersonalCoverPages);
    HRESULT put_AllowPersonalCoverPages(short bAllowPersonalCoverPages);
    HRESULT get_UseDeviceTSID(short* pbUseDeviceTSID);
    HRESULT put_UseDeviceTSID(short bUseDeviceTSID);
    HRESULT get_Retries(int* plRetries);
    HRESULT put_Retries(int lRetries);
    HRESULT get_RetryDelay(int* plRetryDelay);
    HRESULT put_RetryDelay(int lRetryDelay);
    HRESULT get_DiscountRateStart(double* pdateDiscountRateStart);
    HRESULT put_DiscountRateStart(double dateDiscountRateStart);
    HRESULT get_DiscountRateEnd(double* pdateDiscountRateEnd);
    HRESULT put_DiscountRateEnd(double dateDiscountRateEnd);
    HRESULT get_AgeLimit(int* plAgeLimit);
    HRESULT put_AgeLimit(int lAgeLimit);
    HRESULT get_Branding(short* pbBranding);
    HRESULT put_Branding(short bBranding);
    HRESULT Refresh();
    HRESULT Save();
    HRESULT GetJobs(IFaxOutgoingJobs* pFaxOutgoingJobs);
    HRESULT GetJobA(BSTR bstrJobId, IFaxOutgoingJob* pFaxOutgoingJob);
}

const GUID IID_IFaxIncomingMessageIterator = {0xFD73ECC4, 0x6F06, 0x4F52, [0x82, 0xA8, 0xF7, 0xBA, 0x06, 0xAE, 0x31, 0x08]};
@GUID(0xFD73ECC4, 0x6F06, 0x4F52, [0x82, 0xA8, 0xF7, 0xBA, 0x06, 0xAE, 0x31, 0x08]);
interface IFaxIncomingMessageIterator : IDispatch
{
    HRESULT get_Message(IFaxIncomingMessage* pFaxIncomingMessage);
    HRESULT get_PrefetchSize(int* plPrefetchSize);
    HRESULT put_PrefetchSize(int lPrefetchSize);
    HRESULT get_AtEOF(short* pbEOF);
    HRESULT MoveFirst();
    HRESULT MoveNext();
}

const GUID IID_IFaxIncomingMessage = {0x7CAB88FA, 0x2EF9, 0x4851, [0xB2, 0xF3, 0x1D, 0x14, 0x8F, 0xED, 0x84, 0x47]};
@GUID(0x7CAB88FA, 0x2EF9, 0x4851, [0xB2, 0xF3, 0x1D, 0x14, 0x8F, 0xED, 0x84, 0x47]);
interface IFaxIncomingMessage : IDispatch
{
    HRESULT get_Id(BSTR* pbstrId);
    HRESULT get_Pages(int* plPages);
    HRESULT get_Size(int* plSize);
    HRESULT get_DeviceName(BSTR* pbstrDeviceName);
    HRESULT get_Retries(int* plRetries);
    HRESULT get_TransmissionStart(double* pdateTransmissionStart);
    HRESULT get_TransmissionEnd(double* pdateTransmissionEnd);
    HRESULT get_CSID(BSTR* pbstrCSID);
    HRESULT get_TSID(BSTR* pbstrTSID);
    HRESULT get_CallerId(BSTR* pbstrCallerId);
    HRESULT get_RoutingInformation(BSTR* pbstrRoutingInformation);
    HRESULT CopyTiff(BSTR bstrTiffPath);
    HRESULT Delete();
}

const GUID IID_IFaxOutgoingJobs = {0x2C56D8E6, 0x8C2F, 0x4573, [0x94, 0x4C, 0xE5, 0x05, 0xF8, 0xF5, 0xAE, 0xED]};
@GUID(0x2C56D8E6, 0x8C2F, 0x4573, [0x94, 0x4C, 0xE5, 0x05, 0xF8, 0xF5, 0xAE, 0xED]);
interface IFaxOutgoingJobs : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(VARIANT vIndex, IFaxOutgoingJob* pFaxOutgoingJob);
    HRESULT get_Count(int* plCount);
}

const GUID IID_IFaxOutgoingJob = {0x6356DAAD, 0x6614, 0x4583, [0xBF, 0x7A, 0x3A, 0xD6, 0x7B, 0xBF, 0xC7, 0x1C]};
@GUID(0x6356DAAD, 0x6614, 0x4583, [0xBF, 0x7A, 0x3A, 0xD6, 0x7B, 0xBF, 0xC7, 0x1C]);
interface IFaxOutgoingJob : IDispatch
{
    HRESULT get_Subject(BSTR* pbstrSubject);
    HRESULT get_DocumentName(BSTR* pbstrDocumentName);
    HRESULT get_Pages(int* plPages);
    HRESULT get_Size(int* plSize);
    HRESULT get_SubmissionId(BSTR* pbstrSubmissionId);
    HRESULT get_Id(BSTR* pbstrId);
    HRESULT get_OriginalScheduledTime(double* pdateOriginalScheduledTime);
    HRESULT get_SubmissionTime(double* pdateSubmissionTime);
    HRESULT get_ReceiptType(FAX_RECEIPT_TYPE_ENUM* pReceiptType);
    HRESULT get_Priority(FAX_PRIORITY_TYPE_ENUM* pPriority);
    HRESULT get_Sender(IFaxSender* ppFaxSender);
    HRESULT get_Recipient(IFaxRecipient* ppFaxRecipient);
    HRESULT get_CurrentPage(int* plCurrentPage);
    HRESULT get_DeviceId(int* plDeviceId);
    HRESULT get_Status(FAX_JOB_STATUS_ENUM* pStatus);
    HRESULT get_ExtendedStatusCode(FAX_JOB_EXTENDED_STATUS_ENUM* pExtendedStatusCode);
    HRESULT get_ExtendedStatus(BSTR* pbstrExtendedStatus);
    HRESULT get_AvailableOperations(FAX_JOB_OPERATIONS_ENUM* pAvailableOperations);
    HRESULT get_Retries(int* plRetries);
    HRESULT get_ScheduledTime(double* pdateScheduledTime);
    HRESULT get_TransmissionStart(double* pdateTransmissionStart);
    HRESULT get_TransmissionEnd(double* pdateTransmissionEnd);
    HRESULT get_CSID(BSTR* pbstrCSID);
    HRESULT get_TSID(BSTR* pbstrTSID);
    HRESULT get_GroupBroadcastReceipts(short* pbGroupBroadcastReceipts);
    HRESULT Pause();
    HRESULT Resume();
    HRESULT Restart();
    HRESULT CopyTiff(BSTR bstrTiffPath);
    HRESULT Refresh();
    HRESULT Cancel();
}

const GUID IID_IFaxOutgoingMessageIterator = {0xF5EC5D4F, 0xB840, 0x432F, [0x99, 0x80, 0x11, 0x2F, 0xE4, 0x2A, 0x9B, 0x7A]};
@GUID(0xF5EC5D4F, 0xB840, 0x432F, [0x99, 0x80, 0x11, 0x2F, 0xE4, 0x2A, 0x9B, 0x7A]);
interface IFaxOutgoingMessageIterator : IDispatch
{
    HRESULT get_Message(IFaxOutgoingMessage* pFaxOutgoingMessage);
    HRESULT get_AtEOF(short* pbEOF);
    HRESULT get_PrefetchSize(int* plPrefetchSize);
    HRESULT put_PrefetchSize(int lPrefetchSize);
    HRESULT MoveFirst();
    HRESULT MoveNext();
}

const GUID IID_IFaxOutgoingMessage = {0xF0EA35DE, 0xCAA5, 0x4A7C, [0x82, 0xC7, 0x2B, 0x60, 0xBA, 0x5F, 0x2B, 0xE2]};
@GUID(0xF0EA35DE, 0xCAA5, 0x4A7C, [0x82, 0xC7, 0x2B, 0x60, 0xBA, 0x5F, 0x2B, 0xE2]);
interface IFaxOutgoingMessage : IDispatch
{
    HRESULT get_SubmissionId(BSTR* pbstrSubmissionId);
    HRESULT get_Id(BSTR* pbstrId);
    HRESULT get_Subject(BSTR* pbstrSubject);
    HRESULT get_DocumentName(BSTR* pbstrDocumentName);
    HRESULT get_Retries(int* plRetries);
    HRESULT get_Pages(int* plPages);
    HRESULT get_Size(int* plSize);
    HRESULT get_OriginalScheduledTime(double* pdateOriginalScheduledTime);
    HRESULT get_SubmissionTime(double* pdateSubmissionTime);
    HRESULT get_Priority(FAX_PRIORITY_TYPE_ENUM* pPriority);
    HRESULT get_Sender(IFaxSender* ppFaxSender);
    HRESULT get_Recipient(IFaxRecipient* ppFaxRecipient);
    HRESULT get_DeviceName(BSTR* pbstrDeviceName);
    HRESULT get_TransmissionStart(double* pdateTransmissionStart);
    HRESULT get_TransmissionEnd(double* pdateTransmissionEnd);
    HRESULT get_CSID(BSTR* pbstrCSID);
    HRESULT get_TSID(BSTR* pbstrTSID);
    HRESULT CopyTiff(BSTR bstrTiffPath);
    HRESULT Delete();
}

const GUID IID_IFaxIncomingJobs = {0x011F04E9, 0x4FD6, 0x4C23, [0x95, 0x13, 0xB6, 0xB6, 0x6B, 0xB2, 0x6B, 0xE9]};
@GUID(0x011F04E9, 0x4FD6, 0x4C23, [0x95, 0x13, 0xB6, 0xB6, 0x6B, 0xB2, 0x6B, 0xE9]);
interface IFaxIncomingJobs : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(VARIANT vIndex, IFaxIncomingJob* pFaxIncomingJob);
    HRESULT get_Count(int* plCount);
}

const GUID IID_IFaxIncomingJob = {0x207529E6, 0x654A, 0x4916, [0x9F, 0x88, 0x4D, 0x23, 0x2E, 0xE8, 0xA1, 0x07]};
@GUID(0x207529E6, 0x654A, 0x4916, [0x9F, 0x88, 0x4D, 0x23, 0x2E, 0xE8, 0xA1, 0x07]);
interface IFaxIncomingJob : IDispatch
{
    HRESULT get_Size(int* plSize);
    HRESULT get_Id(BSTR* pbstrId);
    HRESULT get_CurrentPage(int* plCurrentPage);
    HRESULT get_DeviceId(int* plDeviceId);
    HRESULT get_Status(FAX_JOB_STATUS_ENUM* pStatus);
    HRESULT get_ExtendedStatusCode(FAX_JOB_EXTENDED_STATUS_ENUM* pExtendedStatusCode);
    HRESULT get_ExtendedStatus(BSTR* pbstrExtendedStatus);
    HRESULT get_AvailableOperations(FAX_JOB_OPERATIONS_ENUM* pAvailableOperations);
    HRESULT get_Retries(int* plRetries);
    HRESULT get_TransmissionStart(double* pdateTransmissionStart);
    HRESULT get_TransmissionEnd(double* pdateTransmissionEnd);
    HRESULT get_CSID(BSTR* pbstrCSID);
    HRESULT get_TSID(BSTR* pbstrTSID);
    HRESULT get_CallerId(BSTR* pbstrCallerId);
    HRESULT get_RoutingInformation(BSTR* pbstrRoutingInformation);
    HRESULT get_JobType(FAX_JOB_TYPE_ENUM* pJobType);
    HRESULT Cancel();
    HRESULT Refresh();
    HRESULT CopyTiff(BSTR bstrTiffPath);
}

enum FAX_PROVIDER_STATUS_ENUM
{
    fpsSUCCESS = 0,
    fpsSERVER_ERROR = 1,
    fpsBAD_GUID = 2,
    fpsBAD_VERSION = 3,
    fpsCANT_LOAD = 4,
    fpsCANT_LINK = 5,
    fpsCANT_INIT = 6,
}

const GUID IID_IFaxDeviceProvider = {0x290EAC63, 0x83EC, 0x449C, [0x84, 0x17, 0xF1, 0x48, 0xDF, 0x8C, 0x68, 0x2A]};
@GUID(0x290EAC63, 0x83EC, 0x449C, [0x84, 0x17, 0xF1, 0x48, 0xDF, 0x8C, 0x68, 0x2A]);
interface IFaxDeviceProvider : IDispatch
{
    HRESULT get_FriendlyName(BSTR* pbstrFriendlyName);
    HRESULT get_ImageName(BSTR* pbstrImageName);
    HRESULT get_UniqueName(BSTR* pbstrUniqueName);
    HRESULT get_TapiProviderName(BSTR* pbstrTapiProviderName);
    HRESULT get_MajorVersion(int* plMajorVersion);
    HRESULT get_MinorVersion(int* plMinorVersion);
    HRESULT get_MajorBuild(int* plMajorBuild);
    HRESULT get_MinorBuild(int* plMinorBuild);
    HRESULT get_Debug(short* pbDebug);
    HRESULT get_Status(FAX_PROVIDER_STATUS_ENUM* pStatus);
    HRESULT get_InitErrorCode(int* plInitErrorCode);
    HRESULT get_DeviceIds(VARIANT* pvDeviceIds);
}

enum FAX_DEVICE_RECEIVE_MODE_ENUM
{
    fdrmNO_ANSWER = 0,
    fdrmAUTO_ANSWER = 1,
    fdrmMANUAL_ANSWER = 2,
}

const GUID IID_IFaxDevice = {0x49306C59, 0xB52E, 0x4867, [0x9D, 0xF4, 0xCA, 0x58, 0x41, 0xC9, 0x56, 0xD0]};
@GUID(0x49306C59, 0xB52E, 0x4867, [0x9D, 0xF4, 0xCA, 0x58, 0x41, 0xC9, 0x56, 0xD0]);
interface IFaxDevice : IDispatch
{
    HRESULT get_Id(int* plId);
    HRESULT get_DeviceName(BSTR* pbstrDeviceName);
    HRESULT get_ProviderUniqueName(BSTR* pbstrProviderUniqueName);
    HRESULT get_PoweredOff(short* pbPoweredOff);
    HRESULT get_ReceivingNow(short* pbReceivingNow);
    HRESULT get_SendingNow(short* pbSendingNow);
    HRESULT get_UsedRoutingMethods(VARIANT* pvUsedRoutingMethods);
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_SendEnabled(short* pbSendEnabled);
    HRESULT put_SendEnabled(short bSendEnabled);
    HRESULT get_ReceiveMode(FAX_DEVICE_RECEIVE_MODE_ENUM* pReceiveMode);
    HRESULT put_ReceiveMode(FAX_DEVICE_RECEIVE_MODE_ENUM ReceiveMode);
    HRESULT get_RingsBeforeAnswer(int* plRingsBeforeAnswer);
    HRESULT put_RingsBeforeAnswer(int lRingsBeforeAnswer);
    HRESULT get_CSID(BSTR* pbstrCSID);
    HRESULT put_CSID(BSTR bstrCSID);
    HRESULT get_TSID(BSTR* pbstrTSID);
    HRESULT put_TSID(BSTR bstrTSID);
    HRESULT Refresh();
    HRESULT Save();
    HRESULT GetExtensionProperty(BSTR bstrGUID, VARIANT* pvProperty);
    HRESULT SetExtensionProperty(BSTR bstrGUID, VARIANT vProperty);
    HRESULT UseRoutingMethod(BSTR bstrMethodGUID, short bUse);
    HRESULT get_RingingNow(short* pbRingingNow);
    HRESULT AnswerCall();
}

const GUID IID_IFaxActivityLogging = {0x1E29078B, 0x5A69, 0x497B, [0x95, 0x92, 0x49, 0xB7, 0xE7, 0xFA, 0xDD, 0xB5]};
@GUID(0x1E29078B, 0x5A69, 0x497B, [0x95, 0x92, 0x49, 0xB7, 0xE7, 0xFA, 0xDD, 0xB5]);
interface IFaxActivityLogging : IDispatch
{
    HRESULT get_LogIncoming(short* pbLogIncoming);
    HRESULT put_LogIncoming(short bLogIncoming);
    HRESULT get_LogOutgoing(short* pbLogOutgoing);
    HRESULT put_LogOutgoing(short bLogOutgoing);
    HRESULT get_DatabasePath(BSTR* pbstrDatabasePath);
    HRESULT put_DatabasePath(BSTR bstrDatabasePath);
    HRESULT Refresh();
    HRESULT Save();
}

enum FAX_LOG_LEVEL_ENUM
{
    fllNONE = 0,
    fllMIN = 1,
    fllMED = 2,
    fllMAX = 3,
}

const GUID IID_IFaxEventLogging = {0x0880D965, 0x20E8, 0x42E4, [0x8E, 0x17, 0x94, 0x4F, 0x19, 0x2C, 0xAA, 0xD4]};
@GUID(0x0880D965, 0x20E8, 0x42E4, [0x8E, 0x17, 0x94, 0x4F, 0x19, 0x2C, 0xAA, 0xD4]);
interface IFaxEventLogging : IDispatch
{
    HRESULT get_InitEventsLevel(FAX_LOG_LEVEL_ENUM* pInitEventLevel);
    HRESULT put_InitEventsLevel(FAX_LOG_LEVEL_ENUM InitEventLevel);
    HRESULT get_InboundEventsLevel(FAX_LOG_LEVEL_ENUM* pInboundEventLevel);
    HRESULT put_InboundEventsLevel(FAX_LOG_LEVEL_ENUM InboundEventLevel);
    HRESULT get_OutboundEventsLevel(FAX_LOG_LEVEL_ENUM* pOutboundEventLevel);
    HRESULT put_OutboundEventsLevel(FAX_LOG_LEVEL_ENUM OutboundEventLevel);
    HRESULT get_GeneralEventsLevel(FAX_LOG_LEVEL_ENUM* pGeneralEventLevel);
    HRESULT put_GeneralEventsLevel(FAX_LOG_LEVEL_ENUM GeneralEventLevel);
    HRESULT Refresh();
    HRESULT Save();
}

const GUID IID_IFaxOutboundRoutingGroups = {0x235CBEF7, 0xC2DE, 0x4BFD, [0xB8, 0xDA, 0x75, 0x09, 0x7C, 0x82, 0xC8, 0x7F]};
@GUID(0x235CBEF7, 0xC2DE, 0x4BFD, [0xB8, 0xDA, 0x75, 0x09, 0x7C, 0x82, 0xC8, 0x7F]);
interface IFaxOutboundRoutingGroups : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(VARIANT vIndex, IFaxOutboundRoutingGroup* pFaxOutboundRoutingGroup);
    HRESULT get_Count(int* plCount);
    HRESULT Add(BSTR bstrName, IFaxOutboundRoutingGroup* pFaxOutboundRoutingGroup);
    HRESULT Remove(VARIANT vIndex);
}

enum FAX_GROUP_STATUS_ENUM
{
    fgsALL_DEV_VALID = 0,
    fgsEMPTY = 1,
    fgsALL_DEV_NOT_VALID = 2,
    fgsSOME_DEV_NOT_VALID = 3,
}

const GUID IID_IFaxOutboundRoutingGroup = {0xCA6289A1, 0x7E25, 0x4F87, [0x9A, 0x0B, 0x93, 0x36, 0x57, 0x34, 0x96, 0x2C]};
@GUID(0xCA6289A1, 0x7E25, 0x4F87, [0x9A, 0x0B, 0x93, 0x36, 0x57, 0x34, 0x96, 0x2C]);
interface IFaxOutboundRoutingGroup : IDispatch
{
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT get_Status(FAX_GROUP_STATUS_ENUM* pStatus);
    HRESULT get_DeviceIds(IFaxDeviceIds* pFaxDeviceIds);
}

const GUID IID_IFaxDeviceIds = {0x2F0F813F, 0x4CE9, 0x443E, [0x8C, 0xA1, 0x73, 0x8C, 0xFA, 0xEE, 0xE1, 0x49]};
@GUID(0x2F0F813F, 0x4CE9, 0x443E, [0x8C, 0xA1, 0x73, 0x8C, 0xFA, 0xEE, 0xE1, 0x49]);
interface IFaxDeviceIds : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(int lIndex, int* plDeviceId);
    HRESULT get_Count(int* plCount);
    HRESULT Add(int lDeviceId);
    HRESULT Remove(int lIndex);
    HRESULT SetOrder(int lDeviceId, int lNewOrder);
}

const GUID IID_IFaxOutboundRoutingRules = {0xDCEFA1E7, 0xAE7D, 0x4ED6, [0x85, 0x21, 0x36, 0x9E, 0xDC, 0xCA, 0x51, 0x20]};
@GUID(0xDCEFA1E7, 0xAE7D, 0x4ED6, [0x85, 0x21, 0x36, 0x9E, 0xDC, 0xCA, 0x51, 0x20]);
interface IFaxOutboundRoutingRules : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(int lIndex, IFaxOutboundRoutingRule* pFaxOutboundRoutingRule);
    HRESULT get_Count(int* plCount);
    HRESULT ItemByCountryAndArea(int lCountryCode, int lAreaCode, IFaxOutboundRoutingRule* pFaxOutboundRoutingRule);
    HRESULT RemoveByCountryAndArea(int lCountryCode, int lAreaCode);
    HRESULT Remove(int lIndex);
    HRESULT Add(int lCountryCode, int lAreaCode, short bUseDevice, BSTR bstrGroupName, int lDeviceId, IFaxOutboundRoutingRule* pFaxOutboundRoutingRule);
}

enum FAX_RULE_STATUS_ENUM
{
    frsVALID = 0,
    frsEMPTY_GROUP = 1,
    frsALL_GROUP_DEV_NOT_VALID = 2,
    frsSOME_GROUP_DEV_NOT_VALID = 3,
    frsBAD_DEVICE = 4,
}

const GUID IID_IFaxOutboundRoutingRule = {0xE1F795D5, 0x07C2, 0x469F, [0xB0, 0x27, 0xAC, 0xAC, 0xC2, 0x32, 0x19, 0xDA]};
@GUID(0xE1F795D5, 0x07C2, 0x469F, [0xB0, 0x27, 0xAC, 0xAC, 0xC2, 0x32, 0x19, 0xDA]);
interface IFaxOutboundRoutingRule : IDispatch
{
    HRESULT get_CountryCode(int* plCountryCode);
    HRESULT get_AreaCode(int* plAreaCode);
    HRESULT get_Status(FAX_RULE_STATUS_ENUM* pStatus);
    HRESULT get_UseDevice(short* pbUseDevice);
    HRESULT put_UseDevice(short bUseDevice);
    HRESULT get_DeviceId(int* plDeviceId);
    HRESULT put_DeviceId(int DeviceId);
    HRESULT get_GroupName(BSTR* pbstrGroupName);
    HRESULT put_GroupName(BSTR bstrGroupName);
    HRESULT Refresh();
    HRESULT Save();
}

const GUID IID_IFaxInboundRoutingExtensions = {0x2F6C9673, 0x7B26, 0x42DE, [0x8E, 0xB0, 0x91, 0x5D, 0xCD, 0x2A, 0x4F, 0x4C]};
@GUID(0x2F6C9673, 0x7B26, 0x42DE, [0x8E, 0xB0, 0x91, 0x5D, 0xCD, 0x2A, 0x4F, 0x4C]);
interface IFaxInboundRoutingExtensions : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(VARIANT vIndex, IFaxInboundRoutingExtension* pFaxInboundRoutingExtension);
    HRESULT get_Count(int* plCount);
}

const GUID IID_IFaxInboundRoutingExtension = {0x885B5E08, 0xC26C, 0x4EF9, [0xAF, 0x83, 0x51, 0x58, 0x0A, 0x75, 0x0B, 0xE1]};
@GUID(0x885B5E08, 0xC26C, 0x4EF9, [0xAF, 0x83, 0x51, 0x58, 0x0A, 0x75, 0x0B, 0xE1]);
interface IFaxInboundRoutingExtension : IDispatch
{
    HRESULT get_FriendlyName(BSTR* pbstrFriendlyName);
    HRESULT get_ImageName(BSTR* pbstrImageName);
    HRESULT get_UniqueName(BSTR* pbstrUniqueName);
    HRESULT get_MajorVersion(int* plMajorVersion);
    HRESULT get_MinorVersion(int* plMinorVersion);
    HRESULT get_MajorBuild(int* plMajorBuild);
    HRESULT get_MinorBuild(int* plMinorBuild);
    HRESULT get_Debug(short* pbDebug);
    HRESULT get_Status(FAX_PROVIDER_STATUS_ENUM* pStatus);
    HRESULT get_InitErrorCode(int* plInitErrorCode);
    HRESULT get_Methods(VARIANT* pvMethods);
}

const GUID IID_IFaxInboundRoutingMethods = {0x783FCA10, 0x8908, 0x4473, [0x9D, 0x69, 0xF6, 0x7F, 0xBE, 0xA0, 0xC6, 0xB9]};
@GUID(0x783FCA10, 0x8908, 0x4473, [0x9D, 0x69, 0xF6, 0x7F, 0xBE, 0xA0, 0xC6, 0xB9]);
interface IFaxInboundRoutingMethods : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(VARIANT vIndex, IFaxInboundRoutingMethod* pFaxInboundRoutingMethod);
    HRESULT get_Count(int* plCount);
}

const GUID IID_IFaxInboundRoutingMethod = {0x45700061, 0xAD9D, 0x4776, [0xA8, 0xC4, 0x64, 0x06, 0x54, 0x92, 0xCF, 0x4B]};
@GUID(0x45700061, 0xAD9D, 0x4776, [0xA8, 0xC4, 0x64, 0x06, 0x54, 0x92, 0xCF, 0x4B]);
interface IFaxInboundRoutingMethod : IDispatch
{
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT get_GUID(BSTR* pbstrGUID);
    HRESULT get_FunctionName(BSTR* pbstrFunctionName);
    HRESULT get_ExtensionFriendlyName(BSTR* pbstrExtensionFriendlyName);
    HRESULT get_ExtensionImageName(BSTR* pbstrExtensionImageName);
    HRESULT get_Priority(int* plPriority);
    HRESULT put_Priority(int lPriority);
    HRESULT Refresh();
    HRESULT Save();
}

const GUID IID_IFaxDocument2 = {0xE1347661, 0xF9EF, 0x4D6D, [0xB4, 0xA5, 0xC0, 0xA0, 0x68, 0xB6, 0x5C, 0xFF]};
@GUID(0xE1347661, 0xF9EF, 0x4D6D, [0xB4, 0xA5, 0xC0, 0xA0, 0x68, 0xB6, 0x5C, 0xFF]);
interface IFaxDocument2 : IFaxDocument
{
    HRESULT get_SubmissionId(BSTR* pbstrSubmissionId);
    HRESULT get_Bodies(VARIANT* pvBodies);
    HRESULT put_Bodies(VARIANT vBodies);
    HRESULT Submit2(BSTR bstrFaxServerName, VARIANT* pvFaxOutgoingJobIDs, int* plErrorBodyFile);
    HRESULT ConnectedSubmit2(IFaxServer pFaxServer, VARIANT* pvFaxOutgoingJobIDs, int* plErrorBodyFile);
}

const GUID IID_IFaxConfiguration = {0x10F4D0F7, 0x0994, 0x4543, [0xAB, 0x6E, 0x50, 0x69, 0x49, 0x12, 0x8C, 0x40]};
@GUID(0x10F4D0F7, 0x0994, 0x4543, [0xAB, 0x6E, 0x50, 0x69, 0x49, 0x12, 0x8C, 0x40]);
interface IFaxConfiguration : IDispatch
{
    HRESULT get_UseArchive(short* pbUseArchive);
    HRESULT put_UseArchive(short bUseArchive);
    HRESULT get_ArchiveLocation(BSTR* pbstrArchiveLocation);
    HRESULT put_ArchiveLocation(BSTR bstrArchiveLocation);
    HRESULT get_SizeQuotaWarning(short* pbSizeQuotaWarning);
    HRESULT put_SizeQuotaWarning(short bSizeQuotaWarning);
    HRESULT get_HighQuotaWaterMark(int* plHighQuotaWaterMark);
    HRESULT put_HighQuotaWaterMark(int lHighQuotaWaterMark);
    HRESULT get_LowQuotaWaterMark(int* plLowQuotaWaterMark);
    HRESULT put_LowQuotaWaterMark(int lLowQuotaWaterMark);
    HRESULT get_ArchiveAgeLimit(int* plArchiveAgeLimit);
    HRESULT put_ArchiveAgeLimit(int lArchiveAgeLimit);
    HRESULT get_ArchiveSizeLow(int* plSizeLow);
    HRESULT get_ArchiveSizeHigh(int* plSizeHigh);
    HRESULT get_OutgoingQueueBlocked(short* pbOutgoingBlocked);
    HRESULT put_OutgoingQueueBlocked(short bOutgoingBlocked);
    HRESULT get_OutgoingQueuePaused(short* pbOutgoingPaused);
    HRESULT put_OutgoingQueuePaused(short bOutgoingPaused);
    HRESULT get_AllowPersonalCoverPages(short* pbAllowPersonalCoverPages);
    HRESULT put_AllowPersonalCoverPages(short bAllowPersonalCoverPages);
    HRESULT get_UseDeviceTSID(short* pbUseDeviceTSID);
    HRESULT put_UseDeviceTSID(short bUseDeviceTSID);
    HRESULT get_Retries(int* plRetries);
    HRESULT put_Retries(int lRetries);
    HRESULT get_RetryDelay(int* plRetryDelay);
    HRESULT put_RetryDelay(int lRetryDelay);
    HRESULT get_DiscountRateStart(double* pdateDiscountRateStart);
    HRESULT put_DiscountRateStart(double dateDiscountRateStart);
    HRESULT get_DiscountRateEnd(double* pdateDiscountRateEnd);
    HRESULT put_DiscountRateEnd(double dateDiscountRateEnd);
    HRESULT get_OutgoingQueueAgeLimit(int* plOutgoingQueueAgeLimit);
    HRESULT put_OutgoingQueueAgeLimit(int lOutgoingQueueAgeLimit);
    HRESULT get_Branding(short* pbBranding);
    HRESULT put_Branding(short bBranding);
    HRESULT get_IncomingQueueBlocked(short* pbIncomingBlocked);
    HRESULT put_IncomingQueueBlocked(short bIncomingBlocked);
    HRESULT get_AutoCreateAccountOnConnect(short* pbAutoCreateAccountOnConnect);
    HRESULT put_AutoCreateAccountOnConnect(short bAutoCreateAccountOnConnect);
    HRESULT get_IncomingFaxesArePublic(short* pbIncomingFaxesArePublic);
    HRESULT put_IncomingFaxesArePublic(short bIncomingFaxesArePublic);
    HRESULT Refresh();
    HRESULT Save();
}

const GUID IID_IFaxServer2 = {0x571CED0F, 0x5609, 0x4F40, [0x91, 0x76, 0x54, 0x7E, 0x3A, 0x72, 0xCA, 0x7C]};
@GUID(0x571CED0F, 0x5609, 0x4F40, [0x91, 0x76, 0x54, 0x7E, 0x3A, 0x72, 0xCA, 0x7C]);
interface IFaxServer2 : IFaxServer
{
    HRESULT get_Configuration(IFaxConfiguration* ppFaxConfiguration);
    HRESULT get_CurrentAccount(IFaxAccount* ppCurrentAccount);
    HRESULT get_FaxAccountSet(IFaxAccountSet* ppFaxAccountSet);
    HRESULT get_Security2(IFaxSecurity2* ppFaxSecurity2);
}

const GUID IID_IFaxAccountSet = {0x7428FBAE, 0x841E, 0x47B8, [0x86, 0xF4, 0x22, 0x88, 0x94, 0x6D, 0xCA, 0x1B]};
@GUID(0x7428FBAE, 0x841E, 0x47B8, [0x86, 0xF4, 0x22, 0x88, 0x94, 0x6D, 0xCA, 0x1B]);
interface IFaxAccountSet : IDispatch
{
    HRESULT GetAccounts(IFaxAccounts* ppFaxAccounts);
    HRESULT GetAccount(BSTR bstrAccountName, IFaxAccount* pFaxAccount);
    HRESULT AddAccount(BSTR bstrAccountName, IFaxAccount* pFaxAccount);
    HRESULT RemoveAccount(BSTR bstrAccountName);
}

const GUID IID_IFaxAccounts = {0x93EA8162, 0x8BE7, 0x42D1, [0xAE, 0x7B, 0xEC, 0x74, 0xE2, 0xD9, 0x89, 0xDA]};
@GUID(0x93EA8162, 0x8BE7, 0x42D1, [0xAE, 0x7B, 0xEC, 0x74, 0xE2, 0xD9, 0x89, 0xDA]);
interface IFaxAccounts : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(VARIANT vIndex, IFaxAccount* pFaxAccount);
    HRESULT get_Count(int* plCount);
}

enum FAX_ACCOUNT_EVENTS_TYPE_ENUM
{
    faetNONE = 0,
    faetIN_QUEUE = 1,
    faetOUT_QUEUE = 2,
    faetIN_ARCHIVE = 4,
    faetOUT_ARCHIVE = 8,
    faetFXSSVC_ENDED = 16,
}

const GUID IID_IFaxAccount = {0x68535B33, 0x5DC4, 0x4086, [0xBE, 0x26, 0xB7, 0x6F, 0x9B, 0x71, 0x10, 0x06]};
@GUID(0x68535B33, 0x5DC4, 0x4086, [0xBE, 0x26, 0xB7, 0x6F, 0x9B, 0x71, 0x10, 0x06]);
interface IFaxAccount : IDispatch
{
    HRESULT get_AccountName(BSTR* pbstrAccountName);
    HRESULT get_Folders(IFaxAccountFolders* ppFolders);
    HRESULT ListenToAccountEvents(FAX_ACCOUNT_EVENTS_TYPE_ENUM EventTypes);
    HRESULT get_RegisteredEvents(FAX_ACCOUNT_EVENTS_TYPE_ENUM* pRegisteredEvents);
}

const GUID IID_IFaxOutgoingJob2 = {0x418A8D96, 0x59A0, 0x4789, [0xB1, 0x76, 0xED, 0xF3, 0xDC, 0x8F, 0xA8, 0xF7]};
@GUID(0x418A8D96, 0x59A0, 0x4789, [0xB1, 0x76, 0xED, 0xF3, 0xDC, 0x8F, 0xA8, 0xF7]);
interface IFaxOutgoingJob2 : IFaxOutgoingJob
{
    HRESULT get_HasCoverPage(short* pbHasCoverPage);
    HRESULT get_ReceiptAddress(BSTR* pbstrReceiptAddress);
    HRESULT get_ScheduleType(FAX_SCHEDULE_TYPE_ENUM* pScheduleType);
}

const GUID IID_IFaxAccountFolders = {0x6463F89D, 0x23D8, 0x46A9, [0x8F, 0x86, 0xC4, 0x7B, 0x77, 0xCA, 0x79, 0x26]};
@GUID(0x6463F89D, 0x23D8, 0x46A9, [0x8F, 0x86, 0xC4, 0x7B, 0x77, 0xCA, 0x79, 0x26]);
interface IFaxAccountFolders : IDispatch
{
    HRESULT get_OutgoingQueue(IFaxAccountOutgoingQueue* pFaxOutgoingQueue);
    HRESULT get_IncomingQueue(IFaxAccountIncomingQueue* pFaxIncomingQueue);
    HRESULT get_IncomingArchive(IFaxAccountIncomingArchive* pFaxIncomingArchive);
    HRESULT get_OutgoingArchive(IFaxAccountOutgoingArchive* pFaxOutgoingArchive);
}

const GUID IID_IFaxAccountIncomingQueue = {0xDD142D92, 0x0186, 0x4A95, [0xA0, 0x90, 0xCB, 0xC3, 0xEA, 0xDB, 0xA6, 0xB4]};
@GUID(0xDD142D92, 0x0186, 0x4A95, [0xA0, 0x90, 0xCB, 0xC3, 0xEA, 0xDB, 0xA6, 0xB4]);
interface IFaxAccountIncomingQueue : IDispatch
{
    HRESULT GetJobs(IFaxIncomingJobs* pFaxIncomingJobs);
    HRESULT GetJobA(BSTR bstrJobId, IFaxIncomingJob* pFaxIncomingJob);
}

const GUID IID_IFaxAccountOutgoingQueue = {0x0F1424E9, 0xF22D, 0x4553, [0xB7, 0xA5, 0x0D, 0x24, 0xBD, 0x0D, 0x7E, 0x46]};
@GUID(0x0F1424E9, 0xF22D, 0x4553, [0xB7, 0xA5, 0x0D, 0x24, 0xBD, 0x0D, 0x7E, 0x46]);
interface IFaxAccountOutgoingQueue : IDispatch
{
    HRESULT GetJobs(IFaxOutgoingJobs* pFaxOutgoingJobs);
    HRESULT GetJobA(BSTR bstrJobId, IFaxOutgoingJob* pFaxOutgoingJob);
}

const GUID IID_IFaxOutgoingMessage2 = {0xB37DF687, 0xBC88, 0x4B46, [0xB3, 0xBE, 0xB4, 0x58, 0xB3, 0xEA, 0x9E, 0x7F]};
@GUID(0xB37DF687, 0xBC88, 0x4B46, [0xB3, 0xBE, 0xB4, 0x58, 0xB3, 0xEA, 0x9E, 0x7F]);
interface IFaxOutgoingMessage2 : IFaxOutgoingMessage
{
    HRESULT get_HasCoverPage(short* pbHasCoverPage);
    HRESULT get_ReceiptType(FAX_RECEIPT_TYPE_ENUM* pReceiptType);
    HRESULT get_ReceiptAddress(BSTR* pbstrReceiptAddress);
    HRESULT get_Read(short* pbRead);
    HRESULT put_Read(short bRead);
    HRESULT Save();
    HRESULT Refresh();
}

const GUID IID_IFaxAccountIncomingArchive = {0xA8A5B6EF, 0xE0D6, 0x4AEE, [0x95, 0x5C, 0x91, 0x62, 0x5B, 0xEC, 0x9D, 0xB4]};
@GUID(0xA8A5B6EF, 0xE0D6, 0x4AEE, [0x95, 0x5C, 0x91, 0x62, 0x5B, 0xEC, 0x9D, 0xB4]);
interface IFaxAccountIncomingArchive : IDispatch
{
    HRESULT get_SizeLow(int* plSizeLow);
    HRESULT get_SizeHigh(int* plSizeHigh);
    HRESULT Refresh();
    HRESULT GetMessages(int lPrefetchSize, IFaxIncomingMessageIterator* pFaxIncomingMessageIterator);
    HRESULT GetMessageA(BSTR bstrMessageId, IFaxIncomingMessage* pFaxIncomingMessage);
}

const GUID IID_IFaxAccountOutgoingArchive = {0x5463076D, 0xEC14, 0x491F, [0x92, 0x6E, 0xB3, 0xCE, 0xDA, 0x5E, 0x56, 0x62]};
@GUID(0x5463076D, 0xEC14, 0x491F, [0x92, 0x6E, 0xB3, 0xCE, 0xDA, 0x5E, 0x56, 0x62]);
interface IFaxAccountOutgoingArchive : IDispatch
{
    HRESULT get_SizeLow(int* plSizeLow);
    HRESULT get_SizeHigh(int* plSizeHigh);
    HRESULT Refresh();
    HRESULT GetMessages(int lPrefetchSize, IFaxOutgoingMessageIterator* pFaxOutgoingMessageIterator);
    HRESULT GetMessageA(BSTR bstrMessageId, IFaxOutgoingMessage* pFaxOutgoingMessage);
}

enum FAX_ACCESS_RIGHTS_ENUM_2
{
    far2SUBMIT_LOW = 1,
    far2SUBMIT_NORMAL = 2,
    far2SUBMIT_HIGH = 4,
    far2QUERY_OUT_JOBS = 8,
    far2MANAGE_OUT_JOBS = 16,
    far2QUERY_CONFIG = 32,
    far2MANAGE_CONFIG = 64,
    far2QUERY_ARCHIVES = 128,
    far2MANAGE_ARCHIVES = 256,
    far2MANAGE_RECEIVE_FOLDER = 512,
}

const GUID IID_IFaxSecurity2 = {0x17D851F4, 0xD09B, 0x48FC, [0x99, 0xC9, 0x8F, 0x24, 0xC4, 0xDB, 0x9A, 0xB1]};
@GUID(0x17D851F4, 0xD09B, 0x48FC, [0x99, 0xC9, 0x8F, 0x24, 0xC4, 0xDB, 0x9A, 0xB1]);
interface IFaxSecurity2 : IDispatch
{
    HRESULT get_Descriptor(VARIANT* pvDescriptor);
    HRESULT put_Descriptor(VARIANT vDescriptor);
    HRESULT get_GrantedRights(FAX_ACCESS_RIGHTS_ENUM_2* pGrantedRights);
    HRESULT Refresh();
    HRESULT Save();
    HRESULT get_InformationType(int* plInformationType);
    HRESULT put_InformationType(int lInformationType);
}

const GUID IID_IFaxIncomingMessage2 = {0xF9208503, 0xE2BC, 0x48F3, [0x9E, 0xC0, 0xE6, 0x23, 0x6F, 0x9B, 0x50, 0x9A]};
@GUID(0xF9208503, 0xE2BC, 0x48F3, [0x9E, 0xC0, 0xE6, 0x23, 0x6F, 0x9B, 0x50, 0x9A]);
interface IFaxIncomingMessage2 : IFaxIncomingMessage
{
    HRESULT get_Subject(BSTR* pbstrSubject);
    HRESULT put_Subject(BSTR bstrSubject);
    HRESULT get_SenderName(BSTR* pbstrSenderName);
    HRESULT put_SenderName(BSTR bstrSenderName);
    HRESULT get_SenderFaxNumber(BSTR* pbstrSenderFaxNumber);
    HRESULT put_SenderFaxNumber(BSTR bstrSenderFaxNumber);
    HRESULT get_HasCoverPage(short* pbHasCoverPage);
    HRESULT put_HasCoverPage(short bHasCoverPage);
    HRESULT get_Recipients(BSTR* pbstrRecipients);
    HRESULT put_Recipients(BSTR bstrRecipients);
    HRESULT get_WasReAssigned(short* pbWasReAssigned);
    HRESULT get_Read(short* pbRead);
    HRESULT put_Read(short bRead);
    HRESULT ReAssign();
    HRESULT Save();
    HRESULT Refresh();
}

enum FAX_ROUTING_RULE_CODE_ENUM
{
    frrcANY_CODE = 0,
}

const GUID IID_IFaxServerNotify = {0x2E037B27, 0xCF8A, 0x4ABD, [0xB1, 0xE0, 0x57, 0x04, 0x94, 0x3B, 0xEA, 0x6F]};
@GUID(0x2E037B27, 0xCF8A, 0x4ABD, [0xB1, 0xE0, 0x57, 0x04, 0x94, 0x3B, 0xEA, 0x6F]);
interface IFaxServerNotify : IDispatch
{
}

const GUID IID__IFaxServerNotify2 = {0xEC9C69B9, 0x5FE7, 0x4805, [0x94, 0x67, 0x82, 0xFC, 0xD9, 0x6A, 0xF9, 0x03]};
@GUID(0xEC9C69B9, 0x5FE7, 0x4805, [0x94, 0x67, 0x82, 0xFC, 0xD9, 0x6A, 0xF9, 0x03]);
interface _IFaxServerNotify2 : IDispatch
{
    HRESULT OnIncomingJobAdded(IFaxServer2 pFaxServer, BSTR bstrJobId);
    HRESULT OnIncomingJobRemoved(IFaxServer2 pFaxServer, BSTR bstrJobId);
    HRESULT OnIncomingJobChanged(IFaxServer2 pFaxServer, BSTR bstrJobId, IFaxJobStatus pJobStatus);
    HRESULT OnOutgoingJobAdded(IFaxServer2 pFaxServer, BSTR bstrJobId);
    HRESULT OnOutgoingJobRemoved(IFaxServer2 pFaxServer, BSTR bstrJobId);
    HRESULT OnOutgoingJobChanged(IFaxServer2 pFaxServer, BSTR bstrJobId, IFaxJobStatus pJobStatus);
    HRESULT OnIncomingMessageAdded(IFaxServer2 pFaxServer, BSTR bstrMessageId);
    HRESULT OnIncomingMessageRemoved(IFaxServer2 pFaxServer, BSTR bstrMessageId);
    HRESULT OnOutgoingMessageAdded(IFaxServer2 pFaxServer, BSTR bstrMessageId);
    HRESULT OnOutgoingMessageRemoved(IFaxServer2 pFaxServer, BSTR bstrMessageId);
    HRESULT OnReceiptOptionsChange(IFaxServer2 pFaxServer);
    HRESULT OnActivityLoggingConfigChange(IFaxServer2 pFaxServer);
    HRESULT OnSecurityConfigChange(IFaxServer2 pFaxServer);
    HRESULT OnEventLoggingConfigChange(IFaxServer2 pFaxServer);
    HRESULT OnOutgoingQueueConfigChange(IFaxServer2 pFaxServer);
    HRESULT OnOutgoingArchiveConfigChange(IFaxServer2 pFaxServer);
    HRESULT OnIncomingArchiveConfigChange(IFaxServer2 pFaxServer);
    HRESULT OnDevicesConfigChange(IFaxServer2 pFaxServer);
    HRESULT OnOutboundRoutingGroupsConfigChange(IFaxServer2 pFaxServer);
    HRESULT OnOutboundRoutingRulesConfigChange(IFaxServer2 pFaxServer);
    HRESULT OnServerActivityChange(IFaxServer2 pFaxServer, int lIncomingMessages, int lRoutingMessages, int lOutgoingMessages, int lQueuedMessages);
    HRESULT OnQueuesStatusChange(IFaxServer2 pFaxServer, short bOutgoingQueueBlocked, short bOutgoingQueuePaused, short bIncomingQueueBlocked);
    HRESULT OnNewCall(IFaxServer2 pFaxServer, int lCallId, int lDeviceId, BSTR bstrCallerId);
    HRESULT OnServerShutDown(IFaxServer2 pFaxServer);
    HRESULT OnDeviceStatusChange(IFaxServer2 pFaxServer, int lDeviceId, short bPoweredOff, short bSending, short bReceiving, short bRinging);
    HRESULT OnGeneralServerConfigChanged(IFaxServer2 pFaxServer);
}

const GUID IID_IFaxServerNotify2 = {0x616CA8D6, 0xA77A, 0x4062, [0xAB, 0xFD, 0x0E, 0x47, 0x12, 0x41, 0xC7, 0xAA]};
@GUID(0x616CA8D6, 0xA77A, 0x4062, [0xAB, 0xFD, 0x0E, 0x47, 0x12, 0x41, 0xC7, 0xAA]);
interface IFaxServerNotify2 : IDispatch
{
}

const GUID IID__IFaxAccountNotify = {0xB9B3BC81, 0xAC1B, 0x46F3, [0xB3, 0x9D, 0x0A, 0xDC, 0x30, 0xE1, 0xB7, 0x88]};
@GUID(0xB9B3BC81, 0xAC1B, 0x46F3, [0xB3, 0x9D, 0x0A, 0xDC, 0x30, 0xE1, 0xB7, 0x88]);
interface _IFaxAccountNotify : IDispatch
{
    HRESULT OnIncomingJobAdded(IFaxAccount pFaxAccount, BSTR bstrJobId);
    HRESULT OnIncomingJobRemoved(IFaxAccount pFaxAccount, BSTR bstrJobId);
    HRESULT OnIncomingJobChanged(IFaxAccount pFaxAccount, BSTR bstrJobId, IFaxJobStatus pJobStatus);
    HRESULT OnOutgoingJobAdded(IFaxAccount pFaxAccount, BSTR bstrJobId);
    HRESULT OnOutgoingJobRemoved(IFaxAccount pFaxAccount, BSTR bstrJobId);
    HRESULT OnOutgoingJobChanged(IFaxAccount pFaxAccount, BSTR bstrJobId, IFaxJobStatus pJobStatus);
    HRESULT OnIncomingMessageAdded(IFaxAccount pFaxAccount, BSTR bstrMessageId, short fAddedToReceiveFolder);
    HRESULT OnIncomingMessageRemoved(IFaxAccount pFaxAccount, BSTR bstrMessageId, short fRemovedFromReceiveFolder);
    HRESULT OnOutgoingMessageAdded(IFaxAccount pFaxAccount, BSTR bstrMessageId);
    HRESULT OnOutgoingMessageRemoved(IFaxAccount pFaxAccount, BSTR bstrMessageId);
    HRESULT OnServerShutDown(IFaxServer2 pFaxServer);
}

const GUID IID_IFaxAccountNotify = {0x0B5E5BD1, 0xB8A9, 0x47A0, [0xA3, 0x23, 0xEF, 0x4A, 0x29, 0x3B, 0xA0, 0x6A]};
@GUID(0x0B5E5BD1, 0xB8A9, 0x47A0, [0xA3, 0x23, 0xEF, 0x4A, 0x29, 0x3B, 0xA0, 0x6A]);
interface IFaxAccountNotify : IDispatch
{
}

alias PFAXROUTEADDFILE = extern(Windows) int function(uint JobId, const(wchar)* FileName, Guid* Guid);
alias PFAXROUTEDELETEFILE = extern(Windows) int function(uint JobId, const(wchar)* FileName);
alias PFAXROUTEGETFILE = extern(Windows) BOOL function(uint JobId, uint Index, const(wchar)* FileNameBuffer, uint* RequiredSize);
alias PFAXROUTEENUMFILE = extern(Windows) BOOL function(uint JobId, Guid* GuidOwner, Guid* GuidCaller, const(wchar)* FileName, void* Context);
alias PFAXROUTEENUMFILES = extern(Windows) BOOL function(uint JobId, Guid* Guid, PFAXROUTEENUMFILE FileEnumerator, void* Context);
alias PFAXROUTEMODIFYROUTINGDATA = extern(Windows) BOOL function(uint JobId, const(wchar)* RoutingGuid, ubyte* RoutingData, uint RoutingDataSize);
struct FAX_ROUTE_CALLBACKROUTINES
{
    uint SizeOfStruct;
    PFAXROUTEADDFILE FaxRouteAddFile;
    PFAXROUTEDELETEFILE FaxRouteDeleteFile;
    PFAXROUTEGETFILE FaxRouteGetFile;
    PFAXROUTEENUMFILES FaxRouteEnumFiles;
    PFAXROUTEMODIFYROUTINGDATA FaxRouteModifyRoutingData;
}

struct FAX_ROUTE
{
    uint SizeOfStruct;
    uint JobId;
    ulong ElapsedTime;
    ulong ReceiveTime;
    uint PageCount;
    const(wchar)* Csid;
    const(wchar)* Tsid;
    const(wchar)* CallerId;
    const(wchar)* RoutingInfo;
    const(wchar)* ReceiverName;
    const(wchar)* ReceiverNumber;
    const(wchar)* DeviceName;
    uint DeviceId;
    ubyte* RoutingInfoData;
    uint RoutingInfoDataSize;
}

enum FAXROUTE_ENABLE
{
    QUERY_STATUS = -1,
    STATUS_DISABLE = 0,
    STATUS_ENABLE = 1,
}

alias PFAXROUTEINITIALIZE = extern(Windows) BOOL function(HANDLE param0, FAX_ROUTE_CALLBACKROUTINES* param1);
alias PFAXROUTEMETHOD = extern(Windows) BOOL function(const(FAX_ROUTE)* param0, void** param1, uint* param2);
alias PFAXROUTEDEVICEENABLE = extern(Windows) BOOL function(const(wchar)* param0, uint param1, int param2);
alias PFAXROUTEDEVICECHANGENOTIFICATION = extern(Windows) BOOL function(uint param0, BOOL param1);
alias PFAXROUTEGETROUTINGINFO = extern(Windows) BOOL function(const(wchar)* param0, uint param1, ubyte* param2, uint* param3);
alias PFAXROUTESETROUTINGINFO = extern(Windows) BOOL function(const(wchar)* param0, uint param1, const(ubyte)* param2, uint param3);
enum FAX_ENUM_DEVICE_ID_SOURCE
{
    DEV_ID_SRC_FAX = 0,
    DEV_ID_SRC_TAPI = 1,
}

alias PFAX_EXT_GET_DATA = extern(Windows) uint function(uint param0, FAX_ENUM_DEVICE_ID_SOURCE param1, const(wchar)* param2, ubyte** param3, uint* param4);
alias PFAX_EXT_SET_DATA = extern(Windows) uint function(HINSTANCE param0, uint param1, FAX_ENUM_DEVICE_ID_SOURCE param2, const(wchar)* param3, ubyte* param4, uint param5);
alias PFAX_EXT_CONFIG_CHANGE = extern(Windows) HRESULT function(uint param0, const(wchar)* param1, ubyte* param2, uint param3);
alias PFAX_EXT_REGISTER_FOR_EVENTS = extern(Windows) HANDLE function(HINSTANCE param0, uint param1, FAX_ENUM_DEVICE_ID_SOURCE param2, const(wchar)* param3, PFAX_EXT_CONFIG_CHANGE param4);
alias PFAX_EXT_UNREGISTER_FOR_EVENTS = extern(Windows) uint function(HANDLE param0);
alias PFAX_EXT_FREE_BUFFER = extern(Windows) void function(void* param0);
alias PFAX_EXT_INITIALIZE_CONFIG = extern(Windows) HRESULT function(PFAX_EXT_GET_DATA param0, PFAX_EXT_SET_DATA param1, PFAX_EXT_REGISTER_FOR_EVENTS param2, PFAX_EXT_UNREGISTER_FOR_EVENTS param3, PFAX_EXT_FREE_BUFFER param4);
enum SendToMode
{
    SEND_TO_FAX_RECIPIENT_ATTACHMENT = 0,
}

@DllImport("WINFAX.dll")
BOOL FaxConnectFaxServerA(const(char)* MachineName, int* FaxHandle);

@DllImport("WINFAX.dll")
BOOL FaxConnectFaxServerW(const(wchar)* MachineName, int* FaxHandle);

@DllImport("WINFAX.dll")
BOOL FaxClose(HANDLE FaxHandle);

@DllImport("WINFAX.dll")
BOOL FaxOpenPort(HANDLE FaxHandle, uint DeviceId, uint Flags, int* FaxPortHandle);

@DllImport("WINFAX.dll")
BOOL FaxCompleteJobParamsA(FAX_JOB_PARAMA** JobParams, FAX_COVERPAGE_INFOA** CoverpageInfo);

@DllImport("WINFAX.dll")
BOOL FaxCompleteJobParamsW(FAX_JOB_PARAMW** JobParams, FAX_COVERPAGE_INFOW** CoverpageInfo);

@DllImport("WINFAX.dll")
BOOL FaxSendDocumentA(HANDLE FaxHandle, const(char)* FileName, FAX_JOB_PARAMA* JobParams, const(FAX_COVERPAGE_INFOA)* CoverpageInfo, uint* FaxJobId);

@DllImport("WINFAX.dll")
BOOL FaxSendDocumentW(HANDLE FaxHandle, const(wchar)* FileName, FAX_JOB_PARAMW* JobParams, const(FAX_COVERPAGE_INFOW)* CoverpageInfo, uint* FaxJobId);

@DllImport("WINFAX.dll")
BOOL FaxSendDocumentForBroadcastA(HANDLE FaxHandle, const(char)* FileName, uint* FaxJobId, PFAX_RECIPIENT_CALLBACKA FaxRecipientCallback, void* Context);

@DllImport("WINFAX.dll")
BOOL FaxSendDocumentForBroadcastW(HANDLE FaxHandle, const(wchar)* FileName, uint* FaxJobId, PFAX_RECIPIENT_CALLBACKW FaxRecipientCallback, void* Context);

@DllImport("WINFAX.dll")
BOOL FaxEnumJobsA(HANDLE FaxHandle, FAX_JOB_ENTRYA** JobEntry, uint* JobsReturned);

@DllImport("WINFAX.dll")
BOOL FaxEnumJobsW(HANDLE FaxHandle, FAX_JOB_ENTRYW** JobEntry, uint* JobsReturned);

@DllImport("WINFAX.dll")
BOOL FaxGetJobA(HANDLE FaxHandle, uint JobId, FAX_JOB_ENTRYA** JobEntry);

@DllImport("WINFAX.dll")
BOOL FaxGetJobW(HANDLE FaxHandle, uint JobId, FAX_JOB_ENTRYW** JobEntry);

@DllImport("WINFAX.dll")
BOOL FaxSetJobA(HANDLE FaxHandle, uint JobId, uint Command, const(FAX_JOB_ENTRYA)* JobEntry);

@DllImport("WINFAX.dll")
BOOL FaxSetJobW(HANDLE FaxHandle, uint JobId, uint Command, const(FAX_JOB_ENTRYW)* JobEntry);

@DllImport("WINFAX.dll")
BOOL FaxGetPageData(HANDLE FaxHandle, uint JobId, ubyte** Buffer, uint* BufferSize, uint* ImageWidth, uint* ImageHeight);

@DllImport("WINFAX.dll")
BOOL FaxGetDeviceStatusA(HANDLE FaxPortHandle, FAX_DEVICE_STATUSA** DeviceStatus);

@DllImport("WINFAX.dll")
BOOL FaxGetDeviceStatusW(HANDLE FaxPortHandle, FAX_DEVICE_STATUSW** DeviceStatus);

@DllImport("WINFAX.dll")
BOOL FaxAbort(HANDLE FaxHandle, uint JobId);

@DllImport("WINFAX.dll")
BOOL FaxGetConfigurationA(HANDLE FaxHandle, FAX_CONFIGURATIONA** FaxConfig);

@DllImport("WINFAX.dll")
BOOL FaxGetConfigurationW(HANDLE FaxHandle, FAX_CONFIGURATIONW** FaxConfig);

@DllImport("WINFAX.dll")
BOOL FaxSetConfigurationA(HANDLE FaxHandle, const(FAX_CONFIGURATIONA)* FaxConfig);

@DllImport("WINFAX.dll")
BOOL FaxSetConfigurationW(HANDLE FaxHandle, const(FAX_CONFIGURATIONW)* FaxConfig);

@DllImport("WINFAX.dll")
BOOL FaxGetLoggingCategoriesA(HANDLE FaxHandle, FAX_LOG_CATEGORYA** Categories, uint* NumberCategories);

@DllImport("WINFAX.dll")
BOOL FaxGetLoggingCategoriesW(HANDLE FaxHandle, FAX_LOG_CATEGORYW** Categories, uint* NumberCategories);

@DllImport("WINFAX.dll")
BOOL FaxSetLoggingCategoriesA(HANDLE FaxHandle, const(FAX_LOG_CATEGORYA)* Categories, uint NumberCategories);

@DllImport("WINFAX.dll")
BOOL FaxSetLoggingCategoriesW(HANDLE FaxHandle, const(FAX_LOG_CATEGORYW)* Categories, uint NumberCategories);

@DllImport("WINFAX.dll")
BOOL FaxEnumPortsA(HANDLE FaxHandle, FAX_PORT_INFOA** PortInfo, uint* PortsReturned);

@DllImport("WINFAX.dll")
BOOL FaxEnumPortsW(HANDLE FaxHandle, FAX_PORT_INFOW** PortInfo, uint* PortsReturned);

@DllImport("WINFAX.dll")
BOOL FaxGetPortA(HANDLE FaxPortHandle, FAX_PORT_INFOA** PortInfo);

@DllImport("WINFAX.dll")
BOOL FaxGetPortW(HANDLE FaxPortHandle, FAX_PORT_INFOW** PortInfo);

@DllImport("WINFAX.dll")
BOOL FaxSetPortA(HANDLE FaxPortHandle, const(FAX_PORT_INFOA)* PortInfo);

@DllImport("WINFAX.dll")
BOOL FaxSetPortW(HANDLE FaxPortHandle, const(FAX_PORT_INFOW)* PortInfo);

@DllImport("WINFAX.dll")
BOOL FaxEnumRoutingMethodsA(HANDLE FaxPortHandle, FAX_ROUTING_METHODA** RoutingMethod, uint* MethodsReturned);

@DllImport("WINFAX.dll")
BOOL FaxEnumRoutingMethodsW(HANDLE FaxPortHandle, FAX_ROUTING_METHODW** RoutingMethod, uint* MethodsReturned);

@DllImport("WINFAX.dll")
BOOL FaxEnableRoutingMethodA(HANDLE FaxPortHandle, const(char)* RoutingGuid, BOOL Enabled);

@DllImport("WINFAX.dll")
BOOL FaxEnableRoutingMethodW(HANDLE FaxPortHandle, const(wchar)* RoutingGuid, BOOL Enabled);

@DllImport("WINFAX.dll")
BOOL FaxEnumGlobalRoutingInfoA(HANDLE FaxHandle, FAX_GLOBAL_ROUTING_INFOA** RoutingInfo, uint* MethodsReturned);

@DllImport("WINFAX.dll")
BOOL FaxEnumGlobalRoutingInfoW(HANDLE FaxHandle, FAX_GLOBAL_ROUTING_INFOW** RoutingInfo, uint* MethodsReturned);

@DllImport("WINFAX.dll")
BOOL FaxSetGlobalRoutingInfoA(HANDLE FaxHandle, const(FAX_GLOBAL_ROUTING_INFOA)* RoutingInfo);

@DllImport("WINFAX.dll")
BOOL FaxSetGlobalRoutingInfoW(HANDLE FaxHandle, const(FAX_GLOBAL_ROUTING_INFOW)* RoutingInfo);

@DllImport("WINFAX.dll")
BOOL FaxGetRoutingInfoA(HANDLE FaxPortHandle, const(char)* RoutingGuid, ubyte** RoutingInfoBuffer, uint* RoutingInfoBufferSize);

@DllImport("WINFAX.dll")
BOOL FaxGetRoutingInfoW(HANDLE FaxPortHandle, const(wchar)* RoutingGuid, ubyte** RoutingInfoBuffer, uint* RoutingInfoBufferSize);

@DllImport("WINFAX.dll")
BOOL FaxSetRoutingInfoA(HANDLE FaxPortHandle, const(char)* RoutingGuid, const(ubyte)* RoutingInfoBuffer, uint RoutingInfoBufferSize);

@DllImport("WINFAX.dll")
BOOL FaxSetRoutingInfoW(HANDLE FaxPortHandle, const(wchar)* RoutingGuid, const(ubyte)* RoutingInfoBuffer, uint RoutingInfoBufferSize);

@DllImport("WINFAX.dll")
BOOL FaxInitializeEventQueue(HANDLE FaxHandle, HANDLE CompletionPort, uint CompletionKey, HWND hWnd, uint MessageStart);

@DllImport("WINFAX.dll")
void FaxFreeBuffer(void* Buffer);

@DllImport("WINFAX.dll")
BOOL FaxStartPrintJobA(const(char)* PrinterName, const(FAX_PRINT_INFOA)* PrintInfo, uint* FaxJobId, FAX_CONTEXT_INFOA* FaxContextInfo);

@DllImport("WINFAX.dll")
BOOL FaxStartPrintJobW(const(wchar)* PrinterName, const(FAX_PRINT_INFOW)* PrintInfo, uint* FaxJobId, FAX_CONTEXT_INFOW* FaxContextInfo);

@DllImport("WINFAX.dll")
BOOL FaxPrintCoverPageA(const(FAX_CONTEXT_INFOA)* FaxContextInfo, const(FAX_COVERPAGE_INFOA)* CoverPageInfo);

@DllImport("WINFAX.dll")
BOOL FaxPrintCoverPageW(const(FAX_CONTEXT_INFOW)* FaxContextInfo, const(FAX_COVERPAGE_INFOW)* CoverPageInfo);

@DllImport("WINFAX.dll")
BOOL FaxRegisterServiceProviderW(const(wchar)* DeviceProvider, const(wchar)* FriendlyName, const(wchar)* ImageName, const(wchar)* TspName);

@DllImport("WINFAX.dll")
BOOL FaxUnregisterServiceProviderW(const(wchar)* DeviceProvider);

@DllImport("WINFAX.dll")
BOOL FaxRegisterRoutingExtensionW(HANDLE FaxHandle, const(wchar)* ExtensionName, const(wchar)* FriendlyName, const(wchar)* ImageName, PFAX_ROUTING_INSTALLATION_CALLBACKW CallBack, void* Context);

@DllImport("WINFAX.dll")
BOOL FaxAccessCheck(HANDLE FaxHandle, uint AccessMask);

@DllImport("fxsutility.dll")
BOOL CanSendToFaxRecipient();

@DllImport("fxsutility.dll")
uint SendToFaxRecipient(SendToMode sndMode, const(wchar)* lpFileName);

