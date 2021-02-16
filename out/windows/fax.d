module windows.fax;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.controls : HPROPSHEETPAGE;
public import windows.gdi : HDC;
public import windows.systemservices : BOOL, HANDLE, HINSTANCE;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME, SYSTEMTIME;

extern(Windows):


// Enums


enum : int
{
    FAXLOG_LEVEL_NONE = 0x00000000,
    FAXLOG_LEVEL_MIN  = 0x00000001,
    FAXLOG_LEVEL_MED  = 0x00000002,
    FAXLOG_LEVEL_MAX  = 0x00000003,
}
alias FAX_ENUM_LOG_LEVELS = int;

enum : int
{
    FAXLOG_CATEGORY_INIT     = 0x00000001,
    FAXLOG_CATEGORY_OUTBOUND = 0x00000002,
    FAXLOG_CATEGORY_INBOUND  = 0x00000003,
    FAXLOG_CATEGORY_UNKNOWN  = 0x00000004,
}
alias FAX_ENUM_LOG_CATEGORIES = int;

enum : int
{
    JC_UNKNOWN = 0x00000000,
    JC_DELETE  = 0x00000001,
    JC_PAUSE   = 0x00000002,
    JC_RESUME  = 0x00000003,
}
alias FAX_ENUM_JOB_COMMANDS = int;

enum : int
{
    JSA_NOW             = 0x00000000,
    JSA_SPECIFIC_TIME   = 0x00000001,
    JSA_DISCOUNT_PERIOD = 0x00000002,
}
alias FAX_ENUM_JOB_SEND_ATTRIBUTES = int;

enum : int
{
    DRT_NONE  = 0x00000000,
    DRT_EMAIL = 0x00000001,
    DRT_INBOX = 0x00000002,
}
alias FAX_ENUM_DELIVERY_REPORT_TYPES = int;

enum : int
{
    PORT_OPEN_QUERY  = 0x00000001,
    PORT_OPEN_MODIFY = 0x00000002,
}
alias FAX_ENUM_PORT_OPEN_TYPE = int;

enum : int
{
    fjsPENDING          = 0x00000001,
    fjsINPROGRESS       = 0x00000002,
    fjsFAILED           = 0x00000008,
    fjsPAUSED           = 0x00000010,
    fjsNOLINE           = 0x00000020,
    fjsRETRYING         = 0x00000040,
    fjsRETRIES_EXCEEDED = 0x00000080,
    fjsCOMPLETED        = 0x00000100,
    fjsCANCELED         = 0x00000200,
    fjsCANCELING        = 0x00000400,
    fjsROUTING          = 0x00000800,
}
alias FAX_JOB_STATUS_ENUM = int;

enum : int
{
    fjesNONE               = 0x00000000,
    fjesDISCONNECTED       = 0x00000001,
    fjesINITIALIZING       = 0x00000002,
    fjesDIALING            = 0x00000003,
    fjesTRANSMITTING       = 0x00000004,
    fjesANSWERED           = 0x00000005,
    fjesRECEIVING          = 0x00000006,
    fjesLINE_UNAVAILABLE   = 0x00000007,
    fjesBUSY               = 0x00000008,
    fjesNO_ANSWER          = 0x00000009,
    fjesBAD_ADDRESS        = 0x0000000a,
    fjesNO_DIAL_TONE       = 0x0000000b,
    fjesFATAL_ERROR        = 0x0000000c,
    fjesCALL_DELAYED       = 0x0000000d,
    fjesCALL_BLACKLISTED   = 0x0000000e,
    fjesNOT_FAX_CALL       = 0x0000000f,
    fjesPARTIALLY_RECEIVED = 0x00000010,
    fjesHANDLED            = 0x00000011,
    fjesCALL_COMPLETED     = 0x00000012,
    fjesCALL_ABORTED       = 0x00000013,
    fjesPROPRIETARY        = 0x01000000,
}
alias FAX_JOB_EXTENDED_STATUS_ENUM = int;

enum : int
{
    fjoVIEW           = 0x00000001,
    fjoPAUSE          = 0x00000002,
    fjoRESUME         = 0x00000004,
    fjoRESTART        = 0x00000008,
    fjoDELETE         = 0x00000010,
    fjoRECIPIENT_INFO = 0x00000020,
    fjoSENDER_INFO    = 0x00000040,
}
alias FAX_JOB_OPERATIONS_ENUM = int;

enum : int
{
    fjtSEND    = 0x00000000,
    fjtRECEIVE = 0x00000001,
    fjtROUTING = 0x00000002,
}
alias FAX_JOB_TYPE_ENUM = int;

enum : int
{
    fsetNONE          = 0x00000000,
    fsetIN_QUEUE      = 0x00000001,
    fsetOUT_QUEUE     = 0x00000002,
    fsetCONFIG        = 0x00000004,
    fsetACTIVITY      = 0x00000008,
    fsetQUEUE_STATE   = 0x00000010,
    fsetIN_ARCHIVE    = 0x00000020,
    fsetOUT_ARCHIVE   = 0x00000040,
    fsetFXSSVC_ENDED  = 0x00000080,
    fsetDEVICE_STATUS = 0x00000100,
    fsetINCOMING_CALL = 0x00000200,
}
alias FAX_SERVER_EVENTS_TYPE_ENUM = int;

enum : int
{
    fsAPI_VERSION_0 = 0x00000000,
    fsAPI_VERSION_1 = 0x00010000,
    fsAPI_VERSION_2 = 0x00020000,
    fsAPI_VERSION_3 = 0x00030000,
}
alias FAX_SERVER_APIVERSION_ENUM = int;

enum : int
{
    fsatANONYMOUS = 0x00000000,
    fsatBASIC     = 0x00000001,
    fsatNTLM      = 0x00000002,
}
alias FAX_SMTP_AUTHENTICATION_TYPE_ENUM = int;

enum : int
{
    frtNONE   = 0x00000000,
    frtMAIL   = 0x00000001,
    frtMSGBOX = 0x00000004,
}
alias FAX_RECEIPT_TYPE_ENUM = int;

enum : int
{
    farSUBMIT_LOW         = 0x00000001,
    farSUBMIT_NORMAL      = 0x00000002,
    farSUBMIT_HIGH        = 0x00000004,
    farQUERY_JOBS         = 0x00000008,
    farMANAGE_JOBS        = 0x00000010,
    farQUERY_CONFIG       = 0x00000020,
    farMANAGE_CONFIG      = 0x00000040,
    farQUERY_IN_ARCHIVE   = 0x00000080,
    farMANAGE_IN_ARCHIVE  = 0x00000100,
    farQUERY_OUT_ARCHIVE  = 0x00000200,
    farMANAGE_OUT_ARCHIVE = 0x00000400,
}
alias FAX_ACCESS_RIGHTS_ENUM = int;

enum : int
{
    fptLOW    = 0x00000000,
    fptNORMAL = 0x00000001,
    fptHIGH   = 0x00000002,
}
alias FAX_PRIORITY_TYPE_ENUM = int;

enum : int
{
    fcptNONE   = 0x00000000,
    fcptLOCAL  = 0x00000001,
    fcptSERVER = 0x00000002,
}
alias FAX_COVERPAGE_TYPE_ENUM = int;

enum : int
{
    fstNOW             = 0x00000000,
    fstSPECIFIC_TIME   = 0x00000001,
    fstDISCOUNT_PERIOD = 0x00000002,
}
alias FAX_SCHEDULE_TYPE_ENUM = int;

enum : int
{
    fpsSUCCESS      = 0x00000000,
    fpsSERVER_ERROR = 0x00000001,
    fpsBAD_GUID     = 0x00000002,
    fpsBAD_VERSION  = 0x00000003,
    fpsCANT_LOAD    = 0x00000004,
    fpsCANT_LINK    = 0x00000005,
    fpsCANT_INIT    = 0x00000006,
}
alias FAX_PROVIDER_STATUS_ENUM = int;

enum : int
{
    fdrmNO_ANSWER     = 0x00000000,
    fdrmAUTO_ANSWER   = 0x00000001,
    fdrmMANUAL_ANSWER = 0x00000002,
}
alias FAX_DEVICE_RECEIVE_MODE_ENUM = int;

enum : int
{
    fllNONE = 0x00000000,
    fllMIN  = 0x00000001,
    fllMED  = 0x00000002,
    fllMAX  = 0x00000003,
}
alias FAX_LOG_LEVEL_ENUM = int;

enum : int
{
    fgsALL_DEV_VALID      = 0x00000000,
    fgsEMPTY              = 0x00000001,
    fgsALL_DEV_NOT_VALID  = 0x00000002,
    fgsSOME_DEV_NOT_VALID = 0x00000003,
}
alias FAX_GROUP_STATUS_ENUM = int;

enum : int
{
    frsVALID                    = 0x00000000,
    frsEMPTY_GROUP              = 0x00000001,
    frsALL_GROUP_DEV_NOT_VALID  = 0x00000002,
    frsSOME_GROUP_DEV_NOT_VALID = 0x00000003,
    frsBAD_DEVICE               = 0x00000004,
}
alias FAX_RULE_STATUS_ENUM = int;

enum : int
{
    faetNONE         = 0x00000000,
    faetIN_QUEUE     = 0x00000001,
    faetOUT_QUEUE    = 0x00000002,
    faetIN_ARCHIVE   = 0x00000004,
    faetOUT_ARCHIVE  = 0x00000008,
    faetFXSSVC_ENDED = 0x00000010,
}
alias FAX_ACCOUNT_EVENTS_TYPE_ENUM = int;

enum : int
{
    far2SUBMIT_LOW            = 0x00000001,
    far2SUBMIT_NORMAL         = 0x00000002,
    far2SUBMIT_HIGH           = 0x00000004,
    far2QUERY_OUT_JOBS        = 0x00000008,
    far2MANAGE_OUT_JOBS       = 0x00000010,
    far2QUERY_CONFIG          = 0x00000020,
    far2MANAGE_CONFIG         = 0x00000040,
    far2QUERY_ARCHIVES        = 0x00000080,
    far2MANAGE_ARCHIVES       = 0x00000100,
    far2MANAGE_RECEIVE_FOLDER = 0x00000200,
}
alias FAX_ACCESS_RIGHTS_ENUM_2 = int;

enum : int
{
    frrcANY_CODE = 0x00000000,
}
alias FAX_ROUTING_RULE_CODE_ENUM = int;

enum : int
{
    QUERY_STATUS   = 0xffffffff,
    STATUS_DISABLE = 0x00000000,
    STATUS_ENABLE  = 0x00000001,
}
alias FAXROUTE_ENABLE = int;

enum : int
{
    DEV_ID_SRC_FAX  = 0x00000000,
    DEV_ID_SRC_TAPI = 0x00000001,
}
alias FAX_ENUM_DEVICE_ID_SOURCE = int;

enum SendToMode : int
{
    SEND_TO_FAX_RECIPIENT_ATTACHMENT = 0x00000000,
}

// Constants


enum int lDEFAULT_PREFETCH_SIZE = 0x00000064;

// Callbacks

alias PFAXCONNECTFAXSERVERA = BOOL function(const(char)* MachineName, ptrdiff_t* FaxHandle);
alias PFAXCONNECTFAXSERVERW = BOOL function(const(wchar)* MachineName, ptrdiff_t* FaxHandle);
alias PFAXCLOSE = BOOL function(HANDLE FaxHandle);
alias PFAXOPENPORT = BOOL function(HANDLE FaxHandle, uint DeviceId, uint Flags, ptrdiff_t* FaxPortHandle);
alias PFAXCOMPLETEJOBPARAMSA = BOOL function(FAX_JOB_PARAMA** JobParams, FAX_COVERPAGE_INFOA** CoverpageInfo);
alias PFAXCOMPLETEJOBPARAMSW = BOOL function(FAX_JOB_PARAMW** JobParams, FAX_COVERPAGE_INFOW** CoverpageInfo);
alias PFAXSENDDOCUMENTA = BOOL function(HANDLE FaxHandle, const(char)* FileName, FAX_JOB_PARAMA* JobParams, 
                                        const(FAX_COVERPAGE_INFOA)* CoverpageInfo, uint* FaxJobId);
alias PFAXSENDDOCUMENTW = BOOL function(HANDLE FaxHandle, const(wchar)* FileName, FAX_JOB_PARAMW* JobParams, 
                                        const(FAX_COVERPAGE_INFOW)* CoverpageInfo, uint* FaxJobId);
alias PFAX_RECIPIENT_CALLBACKA = BOOL function(HANDLE FaxHandle, uint RecipientNumber, void* Context, 
                                               FAX_JOB_PARAMA* JobParams, FAX_COVERPAGE_INFOA* CoverpageInfo);
alias PFAX_RECIPIENT_CALLBACKW = BOOL function(HANDLE FaxHandle, uint RecipientNumber, void* Context, 
                                               FAX_JOB_PARAMW* JobParams, FAX_COVERPAGE_INFOW* CoverpageInfo);
alias PFAXSENDDOCUMENTFORBROADCASTA = BOOL function(HANDLE FaxHandle, const(char)* FileName, uint* FaxJobId, 
                                                    PFAX_RECIPIENT_CALLBACKA FaxRecipientCallback, void* Context);
alias PFAXSENDDOCUMENTFORBROADCASTW = BOOL function(HANDLE FaxHandle, const(wchar)* FileName, uint* FaxJobId, 
                                                    PFAX_RECIPIENT_CALLBACKW FaxRecipientCallback, void* Context);
alias PFAXENUMJOBSA = BOOL function(HANDLE FaxHandle, FAX_JOB_ENTRYA** JobEntry, uint* JobsReturned);
alias PFAXENUMJOBSW = BOOL function(HANDLE FaxHandle, FAX_JOB_ENTRYW** JobEntry, uint* JobsReturned);
alias PFAXGETJOBA = BOOL function(HANDLE FaxHandle, uint JobId, FAX_JOB_ENTRYA** JobEntry);
alias PFAXGETJOBW = BOOL function(HANDLE FaxHandle, uint JobId, FAX_JOB_ENTRYW** JobEntry);
alias PFAXSETJOBA = BOOL function(HANDLE FaxHandle, uint JobId, uint Command, const(FAX_JOB_ENTRYA)* JobEntry);
alias PFAXSETJOBW = BOOL function(HANDLE FaxHandle, uint JobId, uint Command, const(FAX_JOB_ENTRYW)* JobEntry);
alias PFAXGETPAGEDATA = BOOL function(HANDLE FaxHandle, uint JobId, ubyte** Buffer, uint* BufferSize, 
                                      uint* ImageWidth, uint* ImageHeight);
alias PFAXGETDEVICESTATUSA = BOOL function(HANDLE FaxPortHandle, FAX_DEVICE_STATUSA** DeviceStatus);
alias PFAXGETDEVICESTATUSW = BOOL function(HANDLE FaxPortHandle, FAX_DEVICE_STATUSW** DeviceStatus);
alias PFAXABORT = BOOL function(HANDLE FaxHandle, uint JobId);
alias PFAXGETCONFIGURATIONA = BOOL function(HANDLE FaxHandle, FAX_CONFIGURATIONA** FaxConfig);
alias PFAXGETCONFIGURATIONW = BOOL function(HANDLE FaxHandle, FAX_CONFIGURATIONW** FaxConfig);
alias PFAXSETCONFIGURATIONA = BOOL function(HANDLE FaxHandle, const(FAX_CONFIGURATIONA)* FaxConfig);
alias PFAXSETCONFIGURATIONW = BOOL function(HANDLE FaxHandle, const(FAX_CONFIGURATIONW)* FaxConfig);
alias PFAXGETLOGGINGCATEGORIESA = BOOL function(HANDLE FaxHandle, FAX_LOG_CATEGORYA** Categories, 
                                                uint* NumberCategories);
alias PFAXGETLOGGINGCATEGORIESW = BOOL function(HANDLE FaxHandle, FAX_LOG_CATEGORYW** Categories, 
                                                uint* NumberCategories);
alias PFAXSETLOGGINGCATEGORIESA = BOOL function(HANDLE FaxHandle, const(FAX_LOG_CATEGORYA)* Categories, 
                                                uint NumberCategories);
alias PFAXSETLOGGINGCATEGORIESW = BOOL function(HANDLE FaxHandle, const(FAX_LOG_CATEGORYW)* Categories, 
                                                uint NumberCategories);
alias PFAXENUMPORTSA = BOOL function(HANDLE FaxHandle, FAX_PORT_INFOA** PortInfo, uint* PortsReturned);
alias PFAXENUMPORTSW = BOOL function(HANDLE FaxHandle, FAX_PORT_INFOW** PortInfo, uint* PortsReturned);
alias PFAXGETPORTA = BOOL function(HANDLE FaxPortHandle, FAX_PORT_INFOA** PortInfo);
alias PFAXGETPORTW = BOOL function(HANDLE FaxPortHandle, FAX_PORT_INFOW** PortInfo);
alias PFAXSETPORTA = BOOL function(HANDLE FaxPortHandle, const(FAX_PORT_INFOA)* PortInfo);
alias PFAXSETPORTW = BOOL function(HANDLE FaxPortHandle, const(FAX_PORT_INFOW)* PortInfo);
alias PFAXENUMROUTINGMETHODSA = BOOL function(HANDLE FaxPortHandle, FAX_ROUTING_METHODA** RoutingMethod, 
                                              uint* MethodsReturned);
alias PFAXENUMROUTINGMETHODSW = BOOL function(HANDLE FaxPortHandle, FAX_ROUTING_METHODW** RoutingMethod, 
                                              uint* MethodsReturned);
alias PFAXENABLEROUTINGMETHODA = BOOL function(HANDLE FaxPortHandle, const(char)* RoutingGuid, BOOL Enabled);
alias PFAXENABLEROUTINGMETHODW = BOOL function(HANDLE FaxPortHandle, const(wchar)* RoutingGuid, BOOL Enabled);
alias PFAXENUMGLOBALROUTINGINFOA = BOOL function(HANDLE FaxHandle, FAX_GLOBAL_ROUTING_INFOA** RoutingInfo, 
                                                 uint* MethodsReturned);
alias PFAXENUMGLOBALROUTINGINFOW = BOOL function(HANDLE FaxHandle, FAX_GLOBAL_ROUTING_INFOW** RoutingInfo, 
                                                 uint* MethodsReturned);
alias PFAXSETGLOBALROUTINGINFOA = BOOL function(HANDLE FaxPortHandle, const(FAX_GLOBAL_ROUTING_INFOA)* RoutingInfo);
alias PFAXSETGLOBALROUTINGINFOW = BOOL function(HANDLE FaxPortHandle, const(FAX_GLOBAL_ROUTING_INFOW)* RoutingInfo);
alias PFAXGETROUTINGINFOA = BOOL function(HANDLE FaxPortHandle, const(char)* RoutingGuid, 
                                          ubyte** RoutingInfoBuffer, uint* RoutingInfoBufferSize);
alias PFAXGETROUTINGINFOW = BOOL function(HANDLE FaxPortHandle, const(wchar)* RoutingGuid, 
                                          ubyte** RoutingInfoBuffer, uint* RoutingInfoBufferSize);
alias PFAXSETROUTINGINFOA = BOOL function(HANDLE FaxPortHandle, const(char)* RoutingGuid, 
                                          const(ubyte)* RoutingInfoBuffer, uint RoutingInfoBufferSize);
alias PFAXSETROUTINGINFOW = BOOL function(HANDLE FaxPortHandle, const(wchar)* RoutingGuid, 
                                          const(ubyte)* RoutingInfoBuffer, uint RoutingInfoBufferSize);
alias PFAXINITIALIZEEVENTQUEUE = BOOL function(HANDLE FaxHandle, HANDLE CompletionPort, size_t CompletionKey, 
                                               HWND hWnd, uint MessageStart);
alias PFAXFREEBUFFER = void function(void* Buffer);
alias PFAXSTARTPRINTJOBA = BOOL function(const(char)* PrinterName, const(FAX_PRINT_INFOA)* PrintInfo, 
                                         uint* FaxJobId, FAX_CONTEXT_INFOA* FaxContextInfo);
alias PFAXSTARTPRINTJOBW = BOOL function(const(wchar)* PrinterName, const(FAX_PRINT_INFOW)* PrintInfo, 
                                         uint* FaxJobId, FAX_CONTEXT_INFOW* FaxContextInfo);
alias PFAXPRINTCOVERPAGEA = BOOL function(const(FAX_CONTEXT_INFOA)* FaxContextInfo, 
                                          const(FAX_COVERPAGE_INFOA)* CoverPageInfo);
alias PFAXPRINTCOVERPAGEW = BOOL function(const(FAX_CONTEXT_INFOW)* FaxContextInfo, 
                                          const(FAX_COVERPAGE_INFOW)* CoverPageInfo);
alias PFAXREGISTERSERVICEPROVIDERW = BOOL function(const(wchar)* DeviceProvider, const(wchar)* FriendlyName, 
                                                   const(wchar)* ImageName, const(wchar)* TspName);
alias PFAXUNREGISTERSERVICEPROVIDERW = BOOL function(const(wchar)* DeviceProvider);
alias PFAX_ROUTING_INSTALLATION_CALLBACKW = BOOL function(HANDLE FaxHandle, void* Context, 
                                                          const(wchar)* MethodName, const(wchar)* FriendlyName, 
                                                          const(wchar)* FunctionName, const(wchar)* Guid);
alias PFAXREGISTERROUTINGEXTENSIONW = BOOL function(HANDLE FaxHandle, const(wchar)* ExtensionName, 
                                                    const(wchar)* FriendlyName, const(wchar)* ImageName, 
                                                    PFAX_ROUTING_INSTALLATION_CALLBACKW CallBack, void* Context);
alias PFAXACCESSCHECK = BOOL function(HANDLE FaxHandle, uint AccessMask);
alias PFAX_SERVICE_CALLBACK = BOOL function(HANDLE FaxHandle, uint DeviceId, size_t Param1, size_t Param2, 
                                            size_t Param3);
alias PFAX_LINECALLBACK = void function(HANDLE FaxHandle, uint hDevice, uint dwMessage, size_t dwInstance, 
                                        size_t dwParam1, size_t dwParam2, size_t dwParam3);
alias PFAX_SEND_CALLBACK = BOOL function(HANDLE FaxHandle, uint CallHandle, uint Reserved1, uint Reserved2);
alias PFAXDEVINITIALIZE = BOOL function(uint param0, HANDLE param1, PFAX_LINECALLBACK* param2, 
                                        PFAX_SERVICE_CALLBACK param3);
alias PFAXDEVVIRTUALDEVICECREATION = BOOL function(uint* DeviceCount, const(wchar)* DeviceNamePrefix, 
                                                   uint* DeviceIdPrefix, HANDLE CompletionPort, size_t CompletionKey);
alias PFAXDEVSTARTJOB = BOOL function(uint param0, uint param1, ptrdiff_t* param2, HANDLE param3, size_t param4);
alias PFAXDEVENDJOB = BOOL function(HANDLE param0);
alias PFAXDEVSEND = BOOL function(HANDLE param0, FAX_SEND* param1, PFAX_SEND_CALLBACK param2);
alias PFAXDEVRECEIVE = BOOL function(HANDLE param0, uint param1, FAX_RECEIVE* param2);
alias PFAXDEVREPORTSTATUS = BOOL function(HANDLE param0, FAX_DEV_STATUS* param1, uint param2, uint* param3);
alias PFAXDEVABORTOPERATION = BOOL function(HANDLE param0);
alias PFAXDEVCONFIGURE = BOOL function(HPROPSHEETPAGE* param0);
alias PFAXDEVSHUTDOWN = HRESULT function();
alias PFAXROUTEADDFILE = int function(uint JobId, const(wchar)* FileName, GUID* Guid);
alias PFAXROUTEDELETEFILE = int function(uint JobId, const(wchar)* FileName);
alias PFAXROUTEGETFILE = BOOL function(uint JobId, uint Index, const(wchar)* FileNameBuffer, uint* RequiredSize);
alias PFAXROUTEENUMFILE = BOOL function(uint JobId, GUID* GuidOwner, GUID* GuidCaller, const(wchar)* FileName, 
                                        void* Context);
alias PFAXROUTEENUMFILES = BOOL function(uint JobId, GUID* Guid, PFAXROUTEENUMFILE FileEnumerator, void* Context);
alias PFAXROUTEMODIFYROUTINGDATA = BOOL function(uint JobId, const(wchar)* RoutingGuid, ubyte* RoutingData, 
                                                 uint RoutingDataSize);
alias PFAXROUTEINITIALIZE = BOOL function(HANDLE param0, FAX_ROUTE_CALLBACKROUTINES* param1);
alias PFAXROUTEMETHOD = BOOL function(const(FAX_ROUTE)* param0, void** param1, uint* param2);
alias PFAXROUTEDEVICEENABLE = BOOL function(const(wchar)* param0, uint param1, int param2);
alias PFAXROUTEDEVICECHANGENOTIFICATION = BOOL function(uint param0, BOOL param1);
alias PFAXROUTEGETROUTINGINFO = BOOL function(const(wchar)* param0, uint param1, ubyte* param2, uint* param3);
alias PFAXROUTESETROUTINGINFO = BOOL function(const(wchar)* param0, uint param1, const(ubyte)* param2, uint param3);
alias PFAX_EXT_GET_DATA = uint function(uint param0, FAX_ENUM_DEVICE_ID_SOURCE param1, const(wchar)* param2, 
                                        ubyte** param3, uint* param4);
alias PFAX_EXT_SET_DATA = uint function(HINSTANCE param0, uint param1, FAX_ENUM_DEVICE_ID_SOURCE param2, 
                                        const(wchar)* param3, ubyte* param4, uint param5);
alias PFAX_EXT_CONFIG_CHANGE = HRESULT function(uint param0, const(wchar)* param1, ubyte* param2, uint param3);
alias PFAX_EXT_REGISTER_FOR_EVENTS = HANDLE function(HINSTANCE param0, uint param1, 
                                                     FAX_ENUM_DEVICE_ID_SOURCE param2, const(wchar)* param3, 
                                                     PFAX_EXT_CONFIG_CHANGE param4);
alias PFAX_EXT_UNREGISTER_FOR_EVENTS = uint function(HANDLE param0);
alias PFAX_EXT_FREE_BUFFER = void function(void* param0);
alias PFAX_EXT_INITIALIZE_CONFIG = HRESULT function(PFAX_EXT_GET_DATA param0, PFAX_EXT_SET_DATA param1, 
                                                    PFAX_EXT_REGISTER_FOR_EVENTS param2, 
                                                    PFAX_EXT_UNREGISTER_FOR_EVENTS param3, 
                                                    PFAX_EXT_FREE_BUFFER param4);

// Structs


struct FAX_LOG_CATEGORYA
{
    const(char)* Name;
    uint         Category;
    uint         Level;
}

struct FAX_LOG_CATEGORYW
{
    const(wchar)* Name;
    uint          Category;
    uint          Level;
}

struct FAX_TIME
{
    ushort Hour;
    ushort Minute;
}

struct FAX_CONFIGURATIONA
{
    uint         SizeOfStruct;
    uint         Retries;
    uint         RetryDelay;
    uint         DirtyDays;
    BOOL         Branding;
    BOOL         UseDeviceTsid;
    BOOL         ServerCp;
    BOOL         PauseServerQueue;
    FAX_TIME     StartCheapTime;
    FAX_TIME     StopCheapTime;
    BOOL         ArchiveOutgoingFaxes;
    const(char)* ArchiveDirectory;
    const(char)* Reserved;
}

struct FAX_CONFIGURATIONW
{
    uint          SizeOfStruct;
    uint          Retries;
    uint          RetryDelay;
    uint          DirtyDays;
    BOOL          Branding;
    BOOL          UseDeviceTsid;
    BOOL          ServerCp;
    BOOL          PauseServerQueue;
    FAX_TIME      StartCheapTime;
    FAX_TIME      StopCheapTime;
    BOOL          ArchiveOutgoingFaxes;
    const(wchar)* ArchiveDirectory;
    const(wchar)* Reserved;
}

struct FAX_DEVICE_STATUSA
{
    uint         SizeOfStruct;
    const(char)* CallerId;
    const(char)* Csid;
    uint         CurrentPage;
    uint         DeviceId;
    const(char)* DeviceName;
    const(char)* DocumentName;
    uint         JobType;
    const(char)* PhoneNumber;
    const(char)* RoutingString;
    const(char)* SenderName;
    const(char)* RecipientName;
    uint         Size;
    FILETIME     StartTime;
    uint         Status;
    const(char)* StatusString;
    FILETIME     SubmittedTime;
    uint         TotalPages;
    const(char)* Tsid;
    const(char)* UserName;
}

struct FAX_DEVICE_STATUSW
{
    uint          SizeOfStruct;
    const(wchar)* CallerId;
    const(wchar)* Csid;
    uint          CurrentPage;
    uint          DeviceId;
    const(wchar)* DeviceName;
    const(wchar)* DocumentName;
    uint          JobType;
    const(wchar)* PhoneNumber;
    const(wchar)* RoutingString;
    const(wchar)* SenderName;
    const(wchar)* RecipientName;
    uint          Size;
    FILETIME      StartTime;
    uint          Status;
    const(wchar)* StatusString;
    FILETIME      SubmittedTime;
    uint          TotalPages;
    const(wchar)* Tsid;
    const(wchar)* UserName;
}

struct FAX_JOB_ENTRYA
{
    uint         SizeOfStruct;
    uint         JobId;
    const(char)* UserName;
    uint         JobType;
    uint         QueueStatus;
    uint         Status;
    uint         Size;
    uint         PageCount;
    const(char)* RecipientNumber;
    const(char)* RecipientName;
    const(char)* Tsid;
    const(char)* SenderName;
    const(char)* SenderCompany;
    const(char)* SenderDept;
    const(char)* BillingCode;
    uint         ScheduleAction;
    SYSTEMTIME   ScheduleTime;
    uint         DeliveryReportType;
    const(char)* DeliveryReportAddress;
    const(char)* DocumentName;
}

struct FAX_JOB_ENTRYW
{
    uint          SizeOfStruct;
    uint          JobId;
    const(wchar)* UserName;
    uint          JobType;
    uint          QueueStatus;
    uint          Status;
    uint          Size;
    uint          PageCount;
    const(wchar)* RecipientNumber;
    const(wchar)* RecipientName;
    const(wchar)* Tsid;
    const(wchar)* SenderName;
    const(wchar)* SenderCompany;
    const(wchar)* SenderDept;
    const(wchar)* BillingCode;
    uint          ScheduleAction;
    SYSTEMTIME    ScheduleTime;
    uint          DeliveryReportType;
    const(wchar)* DeliveryReportAddress;
    const(wchar)* DocumentName;
}

struct FAX_PORT_INFOA
{
    uint         SizeOfStruct;
    uint         DeviceId;
    uint         State;
    uint         Flags;
    uint         Rings;
    uint         Priority;
    const(char)* DeviceName;
    const(char)* Tsid;
    const(char)* Csid;
}

struct FAX_PORT_INFOW
{
    uint          SizeOfStruct;
    uint          DeviceId;
    uint          State;
    uint          Flags;
    uint          Rings;
    uint          Priority;
    const(wchar)* DeviceName;
    const(wchar)* Tsid;
    const(wchar)* Csid;
}

struct FAX_ROUTING_METHODA
{
    uint         SizeOfStruct;
    uint         DeviceId;
    BOOL         Enabled;
    const(char)* DeviceName;
    const(char)* Guid;
    const(char)* FriendlyName;
    const(char)* FunctionName;
    const(char)* ExtensionImageName;
    const(char)* ExtensionFriendlyName;
}

struct FAX_ROUTING_METHODW
{
    uint          SizeOfStruct;
    uint          DeviceId;
    BOOL          Enabled;
    const(wchar)* DeviceName;
    const(wchar)* Guid;
    const(wchar)* FriendlyName;
    const(wchar)* FunctionName;
    const(wchar)* ExtensionImageName;
    const(wchar)* ExtensionFriendlyName;
}

struct FAX_GLOBAL_ROUTING_INFOA
{
    uint         SizeOfStruct;
    uint         Priority;
    const(char)* Guid;
    const(char)* FriendlyName;
    const(char)* FunctionName;
    const(char)* ExtensionImageName;
    const(char)* ExtensionFriendlyName;
}

struct FAX_GLOBAL_ROUTING_INFOW
{
    uint          SizeOfStruct;
    uint          Priority;
    const(wchar)* Guid;
    const(wchar)* FriendlyName;
    const(wchar)* FunctionName;
    const(wchar)* ExtensionImageName;
    const(wchar)* ExtensionFriendlyName;
}

struct FAX_COVERPAGE_INFOA
{
    uint         SizeOfStruct;
    const(char)* CoverPageName;
    BOOL         UseServerCoverPage;
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
    SYSTEMTIME   TimeSent;
    uint         PageCount;
}

struct FAX_COVERPAGE_INFOW
{
    uint          SizeOfStruct;
    const(wchar)* CoverPageName;
    BOOL          UseServerCoverPage;
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
    SYSTEMTIME    TimeSent;
    uint          PageCount;
}

struct FAX_JOB_PARAMA
{
    uint         SizeOfStruct;
    const(char)* RecipientNumber;
    const(char)* RecipientName;
    const(char)* Tsid;
    const(char)* SenderName;
    const(char)* SenderCompany;
    const(char)* SenderDept;
    const(char)* BillingCode;
    uint         ScheduleAction;
    SYSTEMTIME   ScheduleTime;
    uint         DeliveryReportType;
    const(char)* DeliveryReportAddress;
    const(char)* DocumentName;
    uint         CallHandle;
    size_t[3]    Reserved;
}

struct FAX_JOB_PARAMW
{
    uint          SizeOfStruct;
    const(wchar)* RecipientNumber;
    const(wchar)* RecipientName;
    const(wchar)* Tsid;
    const(wchar)* SenderName;
    const(wchar)* SenderCompany;
    const(wchar)* SenderDept;
    const(wchar)* BillingCode;
    uint          ScheduleAction;
    SYSTEMTIME    ScheduleTime;
    uint          DeliveryReportType;
    const(wchar)* DeliveryReportAddress;
    const(wchar)* DocumentName;
    uint          CallHandle;
    size_t[3]     Reserved;
}

struct FAX_EVENTA
{
    uint     SizeOfStruct;
    FILETIME TimeStamp;
    uint     DeviceId;
    uint     EventId;
    uint     JobId;
}

struct FAX_EVENTW
{
    uint     SizeOfStruct;
    FILETIME TimeStamp;
    uint     DeviceId;
    uint     EventId;
    uint     JobId;
}

struct FAX_PRINT_INFOA
{
    uint         SizeOfStruct;
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
    uint          SizeOfStruct;
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
    uint     SizeOfStruct;
    HDC      hDC;
    byte[16] ServerName;
}

struct FAX_CONTEXT_INFOW
{
    uint       SizeOfStruct;
    HDC        hDC;
    ushort[16] ServerName;
}

struct FAX_SEND
{
    uint          SizeOfStruct;
    const(wchar)* FileName;
    const(wchar)* CallerName;
    const(wchar)* CallerNumber;
    const(wchar)* ReceiverName;
    const(wchar)* ReceiverNumber;
    BOOL          Branding;
    uint          CallHandle;
    uint[3]       Reserved;
}

struct FAX_RECEIVE
{
    uint          SizeOfStruct;
    const(wchar)* FileName;
    const(wchar)* ReceiverName;
    const(wchar)* ReceiverNumber;
    uint[4]       Reserved;
}

struct FAX_DEV_STATUS
{
    uint          SizeOfStruct;
    uint          StatusId;
    uint          StringId;
    uint          PageCount;
    const(wchar)* CSI;
    const(wchar)* CallerId;
    const(wchar)* RoutingInfo;
    uint          ErrorCode;
    uint[3]       Reserved;
}

struct FAX_ROUTE_CALLBACKROUTINES
{
    uint                SizeOfStruct;
    PFAXROUTEADDFILE    FaxRouteAddFile;
    PFAXROUTEDELETEFILE FaxRouteDeleteFile;
    PFAXROUTEGETFILE    FaxRouteGetFile;
    PFAXROUTEENUMFILES  FaxRouteEnumFiles;
    PFAXROUTEMODIFYROUTINGDATA FaxRouteModifyRoutingData;
}

struct FAX_ROUTE
{
    uint          SizeOfStruct;
    uint          JobId;
    ulong         ElapsedTime;
    ulong         ReceiveTime;
    uint          PageCount;
    const(wchar)* Csid;
    const(wchar)* Tsid;
    const(wchar)* CallerId;
    const(wchar)* RoutingInfo;
    const(wchar)* ReceiverName;
    const(wchar)* ReceiverNumber;
    const(wchar)* DeviceName;
    uint          DeviceId;
    ubyte*        RoutingInfoData;
    uint          RoutingInfoDataSize;
}

// Functions

@DllImport("WINFAX")
BOOL FaxConnectFaxServerA(const(char)* MachineName, ptrdiff_t* FaxHandle);

@DllImport("WINFAX")
BOOL FaxConnectFaxServerW(const(wchar)* MachineName, ptrdiff_t* FaxHandle);

@DllImport("WINFAX")
BOOL FaxClose(HANDLE FaxHandle);

@DllImport("WINFAX")
BOOL FaxOpenPort(HANDLE FaxHandle, uint DeviceId, uint Flags, ptrdiff_t* FaxPortHandle);

@DllImport("WINFAX")
BOOL FaxCompleteJobParamsA(FAX_JOB_PARAMA** JobParams, FAX_COVERPAGE_INFOA** CoverpageInfo);

@DllImport("WINFAX")
BOOL FaxCompleteJobParamsW(FAX_JOB_PARAMW** JobParams, FAX_COVERPAGE_INFOW** CoverpageInfo);

@DllImport("WINFAX")
BOOL FaxSendDocumentA(HANDLE FaxHandle, const(char)* FileName, FAX_JOB_PARAMA* JobParams, 
                      const(FAX_COVERPAGE_INFOA)* CoverpageInfo, uint* FaxJobId);

@DllImport("WINFAX")
BOOL FaxSendDocumentW(HANDLE FaxHandle, const(wchar)* FileName, FAX_JOB_PARAMW* JobParams, 
                      const(FAX_COVERPAGE_INFOW)* CoverpageInfo, uint* FaxJobId);

@DllImport("WINFAX")
BOOL FaxSendDocumentForBroadcastA(HANDLE FaxHandle, const(char)* FileName, uint* FaxJobId, 
                                  PFAX_RECIPIENT_CALLBACKA FaxRecipientCallback, void* Context);

@DllImport("WINFAX")
BOOL FaxSendDocumentForBroadcastW(HANDLE FaxHandle, const(wchar)* FileName, uint* FaxJobId, 
                                  PFAX_RECIPIENT_CALLBACKW FaxRecipientCallback, void* Context);

@DllImport("WINFAX")
BOOL FaxEnumJobsA(HANDLE FaxHandle, FAX_JOB_ENTRYA** JobEntry, uint* JobsReturned);

@DllImport("WINFAX")
BOOL FaxEnumJobsW(HANDLE FaxHandle, FAX_JOB_ENTRYW** JobEntry, uint* JobsReturned);

@DllImport("WINFAX")
BOOL FaxGetJobA(HANDLE FaxHandle, uint JobId, FAX_JOB_ENTRYA** JobEntry);

@DllImport("WINFAX")
BOOL FaxGetJobW(HANDLE FaxHandle, uint JobId, FAX_JOB_ENTRYW** JobEntry);

@DllImport("WINFAX")
BOOL FaxSetJobA(HANDLE FaxHandle, uint JobId, uint Command, const(FAX_JOB_ENTRYA)* JobEntry);

@DllImport("WINFAX")
BOOL FaxSetJobW(HANDLE FaxHandle, uint JobId, uint Command, const(FAX_JOB_ENTRYW)* JobEntry);

@DllImport("WINFAX")
BOOL FaxGetPageData(HANDLE FaxHandle, uint JobId, ubyte** Buffer, uint* BufferSize, uint* ImageWidth, 
                    uint* ImageHeight);

@DllImport("WINFAX")
BOOL FaxGetDeviceStatusA(HANDLE FaxPortHandle, FAX_DEVICE_STATUSA** DeviceStatus);

@DllImport("WINFAX")
BOOL FaxGetDeviceStatusW(HANDLE FaxPortHandle, FAX_DEVICE_STATUSW** DeviceStatus);

@DllImport("WINFAX")
BOOL FaxAbort(HANDLE FaxHandle, uint JobId);

@DllImport("WINFAX")
BOOL FaxGetConfigurationA(HANDLE FaxHandle, FAX_CONFIGURATIONA** FaxConfig);

@DllImport("WINFAX")
BOOL FaxGetConfigurationW(HANDLE FaxHandle, FAX_CONFIGURATIONW** FaxConfig);

@DllImport("WINFAX")
BOOL FaxSetConfigurationA(HANDLE FaxHandle, const(FAX_CONFIGURATIONA)* FaxConfig);

@DllImport("WINFAX")
BOOL FaxSetConfigurationW(HANDLE FaxHandle, const(FAX_CONFIGURATIONW)* FaxConfig);

@DllImport("WINFAX")
BOOL FaxGetLoggingCategoriesA(HANDLE FaxHandle, FAX_LOG_CATEGORYA** Categories, uint* NumberCategories);

@DllImport("WINFAX")
BOOL FaxGetLoggingCategoriesW(HANDLE FaxHandle, FAX_LOG_CATEGORYW** Categories, uint* NumberCategories);

@DllImport("WINFAX")
BOOL FaxSetLoggingCategoriesA(HANDLE FaxHandle, const(FAX_LOG_CATEGORYA)* Categories, uint NumberCategories);

@DllImport("WINFAX")
BOOL FaxSetLoggingCategoriesW(HANDLE FaxHandle, const(FAX_LOG_CATEGORYW)* Categories, uint NumberCategories);

@DllImport("WINFAX")
BOOL FaxEnumPortsA(HANDLE FaxHandle, FAX_PORT_INFOA** PortInfo, uint* PortsReturned);

@DllImport("WINFAX")
BOOL FaxEnumPortsW(HANDLE FaxHandle, FAX_PORT_INFOW** PortInfo, uint* PortsReturned);

@DllImport("WINFAX")
BOOL FaxGetPortA(HANDLE FaxPortHandle, FAX_PORT_INFOA** PortInfo);

@DllImport("WINFAX")
BOOL FaxGetPortW(HANDLE FaxPortHandle, FAX_PORT_INFOW** PortInfo);

@DllImport("WINFAX")
BOOL FaxSetPortA(HANDLE FaxPortHandle, const(FAX_PORT_INFOA)* PortInfo);

@DllImport("WINFAX")
BOOL FaxSetPortW(HANDLE FaxPortHandle, const(FAX_PORT_INFOW)* PortInfo);

@DllImport("WINFAX")
BOOL FaxEnumRoutingMethodsA(HANDLE FaxPortHandle, FAX_ROUTING_METHODA** RoutingMethod, uint* MethodsReturned);

@DllImport("WINFAX")
BOOL FaxEnumRoutingMethodsW(HANDLE FaxPortHandle, FAX_ROUTING_METHODW** RoutingMethod, uint* MethodsReturned);

@DllImport("WINFAX")
BOOL FaxEnableRoutingMethodA(HANDLE FaxPortHandle, const(char)* RoutingGuid, BOOL Enabled);

@DllImport("WINFAX")
BOOL FaxEnableRoutingMethodW(HANDLE FaxPortHandle, const(wchar)* RoutingGuid, BOOL Enabled);

@DllImport("WINFAX")
BOOL FaxEnumGlobalRoutingInfoA(HANDLE FaxHandle, FAX_GLOBAL_ROUTING_INFOA** RoutingInfo, uint* MethodsReturned);

@DllImport("WINFAX")
BOOL FaxEnumGlobalRoutingInfoW(HANDLE FaxHandle, FAX_GLOBAL_ROUTING_INFOW** RoutingInfo, uint* MethodsReturned);

@DllImport("WINFAX")
BOOL FaxSetGlobalRoutingInfoA(HANDLE FaxHandle, const(FAX_GLOBAL_ROUTING_INFOA)* RoutingInfo);

@DllImport("WINFAX")
BOOL FaxSetGlobalRoutingInfoW(HANDLE FaxHandle, const(FAX_GLOBAL_ROUTING_INFOW)* RoutingInfo);

@DllImport("WINFAX")
BOOL FaxGetRoutingInfoA(HANDLE FaxPortHandle, const(char)* RoutingGuid, ubyte** RoutingInfoBuffer, 
                        uint* RoutingInfoBufferSize);

@DllImport("WINFAX")
BOOL FaxGetRoutingInfoW(HANDLE FaxPortHandle, const(wchar)* RoutingGuid, ubyte** RoutingInfoBuffer, 
                        uint* RoutingInfoBufferSize);

@DllImport("WINFAX")
BOOL FaxSetRoutingInfoA(HANDLE FaxPortHandle, const(char)* RoutingGuid, const(ubyte)* RoutingInfoBuffer, 
                        uint RoutingInfoBufferSize);

@DllImport("WINFAX")
BOOL FaxSetRoutingInfoW(HANDLE FaxPortHandle, const(wchar)* RoutingGuid, const(ubyte)* RoutingInfoBuffer, 
                        uint RoutingInfoBufferSize);

@DllImport("WINFAX")
BOOL FaxInitializeEventQueue(HANDLE FaxHandle, HANDLE CompletionPort, size_t CompletionKey, HWND hWnd, 
                             uint MessageStart);

@DllImport("WINFAX")
void FaxFreeBuffer(void* Buffer);

@DllImport("WINFAX")
BOOL FaxStartPrintJobA(const(char)* PrinterName, const(FAX_PRINT_INFOA)* PrintInfo, uint* FaxJobId, 
                       FAX_CONTEXT_INFOA* FaxContextInfo);

@DllImport("WINFAX")
BOOL FaxStartPrintJobW(const(wchar)* PrinterName, const(FAX_PRINT_INFOW)* PrintInfo, uint* FaxJobId, 
                       FAX_CONTEXT_INFOW* FaxContextInfo);

@DllImport("WINFAX")
BOOL FaxPrintCoverPageA(const(FAX_CONTEXT_INFOA)* FaxContextInfo, const(FAX_COVERPAGE_INFOA)* CoverPageInfo);

@DllImport("WINFAX")
BOOL FaxPrintCoverPageW(const(FAX_CONTEXT_INFOW)* FaxContextInfo, const(FAX_COVERPAGE_INFOW)* CoverPageInfo);

@DllImport("WINFAX")
BOOL FaxRegisterServiceProviderW(const(wchar)* DeviceProvider, const(wchar)* FriendlyName, const(wchar)* ImageName, 
                                 const(wchar)* TspName);

@DllImport("WINFAX")
BOOL FaxUnregisterServiceProviderW(const(wchar)* DeviceProvider);

@DllImport("WINFAX")
BOOL FaxRegisterRoutingExtensionW(HANDLE FaxHandle, const(wchar)* ExtensionName, const(wchar)* FriendlyName, 
                                  const(wchar)* ImageName, PFAX_ROUTING_INSTALLATION_CALLBACKW CallBack, 
                                  void* Context);

@DllImport("WINFAX")
BOOL FaxAccessCheck(HANDLE FaxHandle, uint AccessMask);

@DllImport("fxsutility")
BOOL CanSendToFaxRecipient();

@DllImport("fxsutility")
uint SendToFaxRecipient(SendToMode sndMode, const(wchar)* lpFileName);


// Interfaces

@GUID("CDA8ACB0-8CF5-4F6C-9BA2-5931D40C8CAE")
struct FaxServer;

@GUID("EB8FE768-875A-4F5F-82C5-03F23AAC1BD7")
struct FaxDeviceProviders;

@GUID("5589E28E-23CB-4919-8808-E6101846E80D")
struct FaxDevices;

@GUID("E80248ED-AD65-4218-8108-991924D4E7ED")
struct FaxInboundRouting;

@GUID("C35211D7-5776-48CB-AF44-C31BE3B2CFE5")
struct FaxFolders;

@GUID("1BF9EEA6-ECE0-4785-A18B-DE56E9EEF96A")
struct FaxLoggingOptions;

@GUID("CFEF5D0E-E84D-462E-AABB-87D31EB04FEF")
struct FaxActivity;

@GUID("C81B385E-B869-4AFD-86C0-616498ED9BE2")
struct FaxOutboundRouting;

@GUID("6982487B-227B-4C96-A61C-248348B05AB6")
struct FaxReceiptOptions;

@GUID("10C4DDDE-ABF0-43DF-964F-7F3AC21A4C7B")
struct FaxSecurity;

@GUID("0F3F9F91-C838-415E-A4F3-3E828CA445E0")
struct FaxDocument;

@GUID("265D84D0-1850-4360-B7C8-758BBB5F0B96")
struct FaxSender;

@GUID("EA9BDF53-10A9-4D4F-A067-63C8F84F01B0")
struct FaxRecipients;

@GUID("8426C56A-35A1-4C6F-AF93-FC952422E2C2")
struct FaxIncomingArchive;

@GUID("69131717-F3F1-40E3-809D-A6CBF7BD85E5")
struct FaxIncomingQueue;

@GUID("43C28403-E04F-474D-990C-B94669148F59")
struct FaxOutgoingArchive;

@GUID("7421169E-8C43-4B0D-BB16-645C8FA40357")
struct FaxOutgoingQueue;

@GUID("6088E1D8-3FC8-45C2-87B1-909A29607EA9")
struct FaxIncomingMessageIterator;

@GUID("1932FCF7-9D43-4D5A-89FF-03861B321736")
struct FaxIncomingMessage;

@GUID("92BF2A6C-37BE-43FA-A37D-CB0E5F753B35")
struct FaxOutgoingJobs;

@GUID("71BB429C-0EF9-4915-BEC5-A5D897A3E924")
struct FaxOutgoingJob;

@GUID("8A3224D0-D30B-49DE-9813-CB385790FBBB")
struct FaxOutgoingMessageIterator;

@GUID("91B4A378-4AD8-4AEF-A4DC-97D96E939A3A")
struct FaxOutgoingMessage;

@GUID("A1BB8A43-8866-4FB7-A15D-6266C875A5CC")
struct FaxIncomingJobs;

@GUID("C47311EC-AE32-41B8-AE4B-3EAE0629D0C9")
struct FaxIncomingJob;

@GUID("17CF1AA3-F5EB-484A-9C9A-4440A5BAABFC")
struct FaxDeviceProvider;

@GUID("59E3A5B2-D676-484B-A6DE-720BFA89B5AF")
struct FaxDevice;

@GUID("F0A0294E-3BBD-48B8-8F13-8C591A55BDBC")
struct FaxActivityLogging;

@GUID("A6850930-A0F6-4A6F-95B7-DB2EBF3D02E3")
struct FaxEventLogging;

@GUID("CCBEA1A5-E2B4-4B57-9421-B04B6289464B")
struct FaxOutboundRoutingGroups;

@GUID("0213F3E0-6791-4D77-A271-04D2357C50D6")
struct FaxOutboundRoutingGroup;

@GUID("CDC539EA-7277-460E-8DE0-48A0A5760D1F")
struct FaxDeviceIds;

@GUID("D385BECA-E624-4473-BFAA-9F4000831F54")
struct FaxOutboundRoutingRules;

@GUID("6549EEBF-08D1-475A-828B-3BF105952FA0")
struct FaxOutboundRoutingRule;

@GUID("189A48ED-623C-4C0D-80F2-D66C7B9EFEC2")
struct FaxInboundRoutingExtensions;

@GUID("1D7DFB51-7207-4436-A0D9-24E32EE56988")
struct FaxInboundRoutingExtension;

@GUID("25FCB76A-B750-4B82-9266-FBBBAE8922BA")
struct FaxInboundRoutingMethods;

@GUID("4B9FD75C-0194-4B72-9CE5-02A8205AC7D4")
struct FaxInboundRoutingMethod;

@GUID("7BF222F4-BE8D-442F-841D-6132742423BB")
struct FaxJobStatus;

@GUID("60BF3301-7DF8-4BD8-9148-7B5801F9EFDF")
struct FaxRecipient;

@GUID("5857326F-E7B3-41A7-9C19-A91B463E2D56")
struct FaxConfiguration;

@GUID("FBC23C4B-79E0-4291-BC56-C12E253BBF3A")
struct FaxAccountSet;

@GUID("DA1F94AA-EE2C-47C0-8F4F-2A217075B76E")
struct FaxAccounts;

@GUID("A7E0647F-4524-4464-A56D-B9FE666F715E")
struct FaxAccount;

@GUID("85398F49-C034-4A3F-821C-DB7D685E8129")
struct FaxAccountFolders;

@GUID("9BCF6094-B4DA-45F4-B8D6-DDEB2186652C")
struct FaxAccountIncomingQueue;

@GUID("FEECEEFB-C149-48BA-BAB8-B791E101F62F")
struct FaxAccountOutgoingQueue;

@GUID("14B33DB5-4C40-4ECF-9EF8-A360CBE809ED")
struct FaxAccountIncomingArchive;

@GUID("851E7AF5-433A-4739-A2DF-AD245C2CB98E")
struct FaxAccountOutgoingArchive;

@GUID("735C1248-EC89-4C30-A127-656E92E3C4EA")
struct FaxSecurity2;

@GUID("8B86F485-FD7F-4824-886B-40C5CAA617CC")
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

@GUID("475B6469-90A5-4878-A577-17A86E8E3462")
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
    HRESULT RegisterDeviceProvider(BSTR bstrGUID, BSTR bstrFriendlyName, BSTR bstrImageName, BSTR TspName, 
                                   int lFSPIVersion);
    HRESULT UnregisterDeviceProvider(BSTR bstrUniqueName);
    HRESULT RegisterInboundRoutingExtension(BSTR bstrExtensionName, BSTR bstrFriendlyName, BSTR bstrImageName, 
                                            VARIANT vMethods);
    HRESULT UnregisterInboundRoutingExtension(BSTR bstrExtensionUniqueName);
    HRESULT get_RegisteredEvents(FAX_SERVER_EVENTS_TYPE_ENUM* pEventTypes);
    HRESULT get_APIVersion(FAX_SERVER_APIVERSION_ENUM* pAPIVersion);
}

@GUID("9FB76F62-4C7E-43A5-B6FD-502893F7E13E")
interface IFaxDeviceProviders : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(VARIANT vIndex, IFaxDeviceProvider* pFaxDeviceProvider);
    HRESULT get_Count(int* plCount);
}

@GUID("9E46783E-F34F-482E-A360-0416BECBBD96")
interface IFaxDevices : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(VARIANT vIndex, IFaxDevice* pFaxDevice);
    HRESULT get_Count(int* plCount);
    HRESULT get_ItemById(int lId, IFaxDevice* ppFaxDevice);
}

@GUID("8148C20F-9D52-45B1-BF96-38FC12713527")
interface IFaxInboundRouting : IDispatch
{
    HRESULT GetExtensions(IFaxInboundRoutingExtensions* pFaxInboundRoutingExtensions);
    HRESULT GetMethods(IFaxInboundRoutingMethods* pFaxInboundRoutingMethods);
}

@GUID("DCE3B2A8-A7AB-42BC-9D0A-3149457261A0")
interface IFaxFolders : IDispatch
{
    HRESULT get_OutgoingQueue(IFaxOutgoingQueue* pFaxOutgoingQueue);
    HRESULT get_IncomingQueue(IFaxIncomingQueue* pFaxIncomingQueue);
    HRESULT get_IncomingArchive(IFaxIncomingArchive* pFaxIncomingArchive);
    HRESULT get_OutgoingArchive(IFaxOutgoingArchive* pFaxOutgoingArchive);
}

@GUID("34E64FB9-6B31-4D32-8B27-D286C0C33606")
interface IFaxLoggingOptions : IDispatch
{
    HRESULT get_EventLogging(IFaxEventLogging* pFaxEventLogging);
    HRESULT get_ActivityLogging(IFaxActivityLogging* pFaxActivityLogging);
}

@GUID("4B106F97-3DF5-40F2-BC3C-44CB8115EBDF")
interface IFaxActivity : IDispatch
{
    HRESULT get_IncomingMessages(int* plIncomingMessages);
    HRESULT get_RoutingMessages(int* plRoutingMessages);
    HRESULT get_OutgoingMessages(int* plOutgoingMessages);
    HRESULT get_QueuedMessages(int* plQueuedMessages);
    HRESULT Refresh();
}

@GUID("25DC05A4-9909-41BD-A95B-7E5D1DEC1D43")
interface IFaxOutboundRouting : IDispatch
{
    HRESULT GetGroups(IFaxOutboundRoutingGroups* pFaxOutboundRoutingGroups);
    HRESULT GetRules(IFaxOutboundRoutingRules* pFaxOutboundRoutingRules);
}

@GUID("378EFAEB-5FCB-4AFB-B2EE-E16E80614487")
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

@GUID("77B508C1-09C0-47A2-91EB-FCE7FDF2690E")
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

@GUID("B207A246-09E3-4A4E-A7DC-FEA31D29458F")
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

@GUID("0D879D7D-F57A-4CC6-A6F9-3EE5D527B46A")
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

@GUID("9A3DA3A0-538D-42B6-9444-AAA57D0CE2BC")
interface IFaxRecipient : IDispatch
{
    HRESULT get_FaxNumber(BSTR* pbstrFaxNumber);
    HRESULT put_FaxNumber(BSTR bstrFaxNumber);
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrName);
}

@GUID("B9C9DE5A-894E-4492-9FA3-08C627C11D5D")
interface IFaxRecipients : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(int lIndex, IFaxRecipient* ppFaxRecipient);
    HRESULT get_Count(int* plCount);
    HRESULT Add(BSTR bstrFaxNumber, BSTR bstrRecipientName, IFaxRecipient* ppFaxRecipient);
    HRESULT Remove(int lIndex);
}

@GUID("76062CC7-F714-4FBD-AA06-ED6E4A4B70F3")
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

@GUID("902E64EF-8FD8-4B75-9725-6014DF161545")
interface IFaxIncomingQueue : IDispatch
{
    HRESULT get_Blocked(short* pbBlocked);
    HRESULT put_Blocked(short bBlocked);
    HRESULT Refresh();
    HRESULT Save();
    HRESULT GetJobs(IFaxIncomingJobs* pFaxIncomingJobs);
    HRESULT GetJobA(BSTR bstrJobId, IFaxIncomingJob* pFaxIncomingJob);
}

@GUID("C9C28F40-8D80-4E53-810F-9A79919B49FD")
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

@GUID("80B1DF24-D9AC-4333-B373-487CEDC80CE5")
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

@GUID("FD73ECC4-6F06-4F52-82A8-F7BA06AE3108")
interface IFaxIncomingMessageIterator : IDispatch
{
    HRESULT get_Message(IFaxIncomingMessage* pFaxIncomingMessage);
    HRESULT get_PrefetchSize(int* plPrefetchSize);
    HRESULT put_PrefetchSize(int lPrefetchSize);
    HRESULT get_AtEOF(short* pbEOF);
    HRESULT MoveFirst();
    HRESULT MoveNext();
}

@GUID("7CAB88FA-2EF9-4851-B2F3-1D148FED8447")
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

@GUID("2C56D8E6-8C2F-4573-944C-E505F8F5AEED")
interface IFaxOutgoingJobs : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(VARIANT vIndex, IFaxOutgoingJob* pFaxOutgoingJob);
    HRESULT get_Count(int* plCount);
}

@GUID("6356DAAD-6614-4583-BF7A-3AD67BBFC71C")
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

@GUID("F5EC5D4F-B840-432F-9980-112FE42A9B7A")
interface IFaxOutgoingMessageIterator : IDispatch
{
    HRESULT get_Message(IFaxOutgoingMessage* pFaxOutgoingMessage);
    HRESULT get_AtEOF(short* pbEOF);
    HRESULT get_PrefetchSize(int* plPrefetchSize);
    HRESULT put_PrefetchSize(int lPrefetchSize);
    HRESULT MoveFirst();
    HRESULT MoveNext();
}

@GUID("F0EA35DE-CAA5-4A7C-82C7-2B60BA5F2BE2")
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

@GUID("011F04E9-4FD6-4C23-9513-B6B66BB26BE9")
interface IFaxIncomingJobs : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(VARIANT vIndex, IFaxIncomingJob* pFaxIncomingJob);
    HRESULT get_Count(int* plCount);
}

@GUID("207529E6-654A-4916-9F88-4D232EE8A107")
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

@GUID("290EAC63-83EC-449C-8417-F148DF8C682A")
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

@GUID("49306C59-B52E-4867-9DF4-CA5841C956D0")
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

@GUID("1E29078B-5A69-497B-9592-49B7E7FADDB5")
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

@GUID("0880D965-20E8-42E4-8E17-944F192CAAD4")
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

@GUID("235CBEF7-C2DE-4BFD-B8DA-75097C82C87F")
interface IFaxOutboundRoutingGroups : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(VARIANT vIndex, IFaxOutboundRoutingGroup* pFaxOutboundRoutingGroup);
    HRESULT get_Count(int* plCount);
    HRESULT Add(BSTR bstrName, IFaxOutboundRoutingGroup* pFaxOutboundRoutingGroup);
    HRESULT Remove(VARIANT vIndex);
}

@GUID("CA6289A1-7E25-4F87-9A0B-93365734962C")
interface IFaxOutboundRoutingGroup : IDispatch
{
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT get_Status(FAX_GROUP_STATUS_ENUM* pStatus);
    HRESULT get_DeviceIds(IFaxDeviceIds* pFaxDeviceIds);
}

@GUID("2F0F813F-4CE9-443E-8CA1-738CFAEEE149")
interface IFaxDeviceIds : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(int lIndex, int* plDeviceId);
    HRESULT get_Count(int* plCount);
    HRESULT Add(int lDeviceId);
    HRESULT Remove(int lIndex);
    HRESULT SetOrder(int lDeviceId, int lNewOrder);
}

@GUID("DCEFA1E7-AE7D-4ED6-8521-369EDCCA5120")
interface IFaxOutboundRoutingRules : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(int lIndex, IFaxOutboundRoutingRule* pFaxOutboundRoutingRule);
    HRESULT get_Count(int* plCount);
    HRESULT ItemByCountryAndArea(int lCountryCode, int lAreaCode, IFaxOutboundRoutingRule* pFaxOutboundRoutingRule);
    HRESULT RemoveByCountryAndArea(int lCountryCode, int lAreaCode);
    HRESULT Remove(int lIndex);
    HRESULT Add(int lCountryCode, int lAreaCode, short bUseDevice, BSTR bstrGroupName, int lDeviceId, 
                IFaxOutboundRoutingRule* pFaxOutboundRoutingRule);
}

@GUID("E1F795D5-07C2-469F-B027-ACACC23219DA")
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

@GUID("2F6C9673-7B26-42DE-8EB0-915DCD2A4F4C")
interface IFaxInboundRoutingExtensions : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(VARIANT vIndex, IFaxInboundRoutingExtension* pFaxInboundRoutingExtension);
    HRESULT get_Count(int* plCount);
}

@GUID("885B5E08-C26C-4EF9-AF83-51580A750BE1")
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

@GUID("783FCA10-8908-4473-9D69-F67FBEA0C6B9")
interface IFaxInboundRoutingMethods : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(VARIANT vIndex, IFaxInboundRoutingMethod* pFaxInboundRoutingMethod);
    HRESULT get_Count(int* plCount);
}

@GUID("45700061-AD9D-4776-A8C4-64065492CF4B")
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

@GUID("E1347661-F9EF-4D6D-B4A5-C0A068B65CFF")
interface IFaxDocument2 : IFaxDocument
{
    HRESULT get_SubmissionId(BSTR* pbstrSubmissionId);
    HRESULT get_Bodies(VARIANT* pvBodies);
    HRESULT put_Bodies(VARIANT vBodies);
    HRESULT Submit2(BSTR bstrFaxServerName, VARIANT* pvFaxOutgoingJobIDs, int* plErrorBodyFile);
    HRESULT ConnectedSubmit2(IFaxServer pFaxServer, VARIANT* pvFaxOutgoingJobIDs, int* plErrorBodyFile);
}

@GUID("10F4D0F7-0994-4543-AB6E-506949128C40")
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

@GUID("571CED0F-5609-4F40-9176-547E3A72CA7C")
interface IFaxServer2 : IFaxServer
{
    HRESULT get_Configuration(IFaxConfiguration* ppFaxConfiguration);
    HRESULT get_CurrentAccount(IFaxAccount* ppCurrentAccount);
    HRESULT get_FaxAccountSet(IFaxAccountSet* ppFaxAccountSet);
    HRESULT get_Security2(IFaxSecurity2* ppFaxSecurity2);
}

@GUID("7428FBAE-841E-47B8-86F4-2288946DCA1B")
interface IFaxAccountSet : IDispatch
{
    HRESULT GetAccounts(IFaxAccounts* ppFaxAccounts);
    HRESULT GetAccount(BSTR bstrAccountName, IFaxAccount* pFaxAccount);
    HRESULT AddAccount(BSTR bstrAccountName, IFaxAccount* pFaxAccount);
    HRESULT RemoveAccount(BSTR bstrAccountName);
}

@GUID("93EA8162-8BE7-42D1-AE7B-EC74E2D989DA")
interface IFaxAccounts : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    HRESULT get_Item(VARIANT vIndex, IFaxAccount* pFaxAccount);
    HRESULT get_Count(int* plCount);
}

@GUID("68535B33-5DC4-4086-BE26-B76F9B711006")
interface IFaxAccount : IDispatch
{
    HRESULT get_AccountName(BSTR* pbstrAccountName);
    HRESULT get_Folders(IFaxAccountFolders* ppFolders);
    HRESULT ListenToAccountEvents(FAX_ACCOUNT_EVENTS_TYPE_ENUM EventTypes);
    HRESULT get_RegisteredEvents(FAX_ACCOUNT_EVENTS_TYPE_ENUM* pRegisteredEvents);
}

@GUID("418A8D96-59A0-4789-B176-EDF3DC8FA8F7")
interface IFaxOutgoingJob2 : IFaxOutgoingJob
{
    HRESULT get_HasCoverPage(short* pbHasCoverPage);
    HRESULT get_ReceiptAddress(BSTR* pbstrReceiptAddress);
    HRESULT get_ScheduleType(FAX_SCHEDULE_TYPE_ENUM* pScheduleType);
}

@GUID("6463F89D-23D8-46A9-8F86-C47B77CA7926")
interface IFaxAccountFolders : IDispatch
{
    HRESULT get_OutgoingQueue(IFaxAccountOutgoingQueue* pFaxOutgoingQueue);
    HRESULT get_IncomingQueue(IFaxAccountIncomingQueue* pFaxIncomingQueue);
    HRESULT get_IncomingArchive(IFaxAccountIncomingArchive* pFaxIncomingArchive);
    HRESULT get_OutgoingArchive(IFaxAccountOutgoingArchive* pFaxOutgoingArchive);
}

@GUID("DD142D92-0186-4A95-A090-CBC3EADBA6B4")
interface IFaxAccountIncomingQueue : IDispatch
{
    HRESULT GetJobs(IFaxIncomingJobs* pFaxIncomingJobs);
    HRESULT GetJobA(BSTR bstrJobId, IFaxIncomingJob* pFaxIncomingJob);
}

@GUID("0F1424E9-F22D-4553-B7A5-0D24BD0D7E46")
interface IFaxAccountOutgoingQueue : IDispatch
{
    HRESULT GetJobs(IFaxOutgoingJobs* pFaxOutgoingJobs);
    HRESULT GetJobA(BSTR bstrJobId, IFaxOutgoingJob* pFaxOutgoingJob);
}

@GUID("B37DF687-BC88-4B46-B3BE-B458B3EA9E7F")
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

@GUID("A8A5B6EF-E0D6-4AEE-955C-91625BEC9DB4")
interface IFaxAccountIncomingArchive : IDispatch
{
    HRESULT get_SizeLow(int* plSizeLow);
    HRESULT get_SizeHigh(int* plSizeHigh);
    HRESULT Refresh();
    HRESULT GetMessages(int lPrefetchSize, IFaxIncomingMessageIterator* pFaxIncomingMessageIterator);
    HRESULT GetMessageA(BSTR bstrMessageId, IFaxIncomingMessage* pFaxIncomingMessage);
}

@GUID("5463076D-EC14-491F-926E-B3CEDA5E5662")
interface IFaxAccountOutgoingArchive : IDispatch
{
    HRESULT get_SizeLow(int* plSizeLow);
    HRESULT get_SizeHigh(int* plSizeHigh);
    HRESULT Refresh();
    HRESULT GetMessages(int lPrefetchSize, IFaxOutgoingMessageIterator* pFaxOutgoingMessageIterator);
    HRESULT GetMessageA(BSTR bstrMessageId, IFaxOutgoingMessage* pFaxOutgoingMessage);
}

@GUID("17D851F4-D09B-48FC-99C9-8F24C4DB9AB1")
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

@GUID("F9208503-E2BC-48F3-9EC0-E6236F9B509A")
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

@GUID("2E037B27-CF8A-4ABD-B1E0-5704943BEA6F")
interface IFaxServerNotify : IDispatch
{
}

@GUID("EC9C69B9-5FE7-4805-9467-82FCD96AF903")
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
    HRESULT OnServerActivityChange(IFaxServer2 pFaxServer, int lIncomingMessages, int lRoutingMessages, 
                                   int lOutgoingMessages, int lQueuedMessages);
    HRESULT OnQueuesStatusChange(IFaxServer2 pFaxServer, short bOutgoingQueueBlocked, short bOutgoingQueuePaused, 
                                 short bIncomingQueueBlocked);
    HRESULT OnNewCall(IFaxServer2 pFaxServer, int lCallId, int lDeviceId, BSTR bstrCallerId);
    HRESULT OnServerShutDown(IFaxServer2 pFaxServer);
    HRESULT OnDeviceStatusChange(IFaxServer2 pFaxServer, int lDeviceId, short bPoweredOff, short bSending, 
                                 short bReceiving, short bRinging);
    HRESULT OnGeneralServerConfigChanged(IFaxServer2 pFaxServer);
}

@GUID("616CA8D6-A77A-4062-ABFD-0E471241C7AA")
interface IFaxServerNotify2 : IDispatch
{
}

@GUID("B9B3BC81-AC1B-46F3-B39D-0ADC30E1B788")
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

@GUID("0B5E5BD1-B8A9-47A0-A323-EF4A293BA06A")
interface IFaxAccountNotify : IDispatch
{
}


// GUIDs

const GUID CLSID_FaxAccount                  = GUIDOF!FaxAccount;
const GUID CLSID_FaxAccountFolders           = GUIDOF!FaxAccountFolders;
const GUID CLSID_FaxAccountIncomingArchive   = GUIDOF!FaxAccountIncomingArchive;
const GUID CLSID_FaxAccountIncomingQueue     = GUIDOF!FaxAccountIncomingQueue;
const GUID CLSID_FaxAccountOutgoingArchive   = GUIDOF!FaxAccountOutgoingArchive;
const GUID CLSID_FaxAccountOutgoingQueue     = GUIDOF!FaxAccountOutgoingQueue;
const GUID CLSID_FaxAccountSet               = GUIDOF!FaxAccountSet;
const GUID CLSID_FaxAccounts                 = GUIDOF!FaxAccounts;
const GUID CLSID_FaxActivity                 = GUIDOF!FaxActivity;
const GUID CLSID_FaxActivityLogging          = GUIDOF!FaxActivityLogging;
const GUID CLSID_FaxConfiguration            = GUIDOF!FaxConfiguration;
const GUID CLSID_FaxDevice                   = GUIDOF!FaxDevice;
const GUID CLSID_FaxDeviceIds                = GUIDOF!FaxDeviceIds;
const GUID CLSID_FaxDeviceProvider           = GUIDOF!FaxDeviceProvider;
const GUID CLSID_FaxDeviceProviders          = GUIDOF!FaxDeviceProviders;
const GUID CLSID_FaxDevices                  = GUIDOF!FaxDevices;
const GUID CLSID_FaxDocument                 = GUIDOF!FaxDocument;
const GUID CLSID_FaxEventLogging             = GUIDOF!FaxEventLogging;
const GUID CLSID_FaxFolders                  = GUIDOF!FaxFolders;
const GUID CLSID_FaxInboundRouting           = GUIDOF!FaxInboundRouting;
const GUID CLSID_FaxInboundRoutingExtension  = GUIDOF!FaxInboundRoutingExtension;
const GUID CLSID_FaxInboundRoutingExtensions = GUIDOF!FaxInboundRoutingExtensions;
const GUID CLSID_FaxInboundRoutingMethod     = GUIDOF!FaxInboundRoutingMethod;
const GUID CLSID_FaxInboundRoutingMethods    = GUIDOF!FaxInboundRoutingMethods;
const GUID CLSID_FaxIncomingArchive          = GUIDOF!FaxIncomingArchive;
const GUID CLSID_FaxIncomingJob              = GUIDOF!FaxIncomingJob;
const GUID CLSID_FaxIncomingJobs             = GUIDOF!FaxIncomingJobs;
const GUID CLSID_FaxIncomingMessage          = GUIDOF!FaxIncomingMessage;
const GUID CLSID_FaxIncomingMessageIterator  = GUIDOF!FaxIncomingMessageIterator;
const GUID CLSID_FaxIncomingQueue            = GUIDOF!FaxIncomingQueue;
const GUID CLSID_FaxJobStatus                = GUIDOF!FaxJobStatus;
const GUID CLSID_FaxLoggingOptions           = GUIDOF!FaxLoggingOptions;
const GUID CLSID_FaxOutboundRouting          = GUIDOF!FaxOutboundRouting;
const GUID CLSID_FaxOutboundRoutingGroup     = GUIDOF!FaxOutboundRoutingGroup;
const GUID CLSID_FaxOutboundRoutingGroups    = GUIDOF!FaxOutboundRoutingGroups;
const GUID CLSID_FaxOutboundRoutingRule      = GUIDOF!FaxOutboundRoutingRule;
const GUID CLSID_FaxOutboundRoutingRules     = GUIDOF!FaxOutboundRoutingRules;
const GUID CLSID_FaxOutgoingArchive          = GUIDOF!FaxOutgoingArchive;
const GUID CLSID_FaxOutgoingJob              = GUIDOF!FaxOutgoingJob;
const GUID CLSID_FaxOutgoingJobs             = GUIDOF!FaxOutgoingJobs;
const GUID CLSID_FaxOutgoingMessage          = GUIDOF!FaxOutgoingMessage;
const GUID CLSID_FaxOutgoingMessageIterator  = GUIDOF!FaxOutgoingMessageIterator;
const GUID CLSID_FaxOutgoingQueue            = GUIDOF!FaxOutgoingQueue;
const GUID CLSID_FaxReceiptOptions           = GUIDOF!FaxReceiptOptions;
const GUID CLSID_FaxRecipient                = GUIDOF!FaxRecipient;
const GUID CLSID_FaxRecipients               = GUIDOF!FaxRecipients;
const GUID CLSID_FaxSecurity                 = GUIDOF!FaxSecurity;
const GUID CLSID_FaxSecurity2                = GUIDOF!FaxSecurity2;
const GUID CLSID_FaxSender                   = GUIDOF!FaxSender;
const GUID CLSID_FaxServer                   = GUIDOF!FaxServer;

const GUID IID_IFaxAccount                  = GUIDOF!IFaxAccount;
const GUID IID_IFaxAccountFolders           = GUIDOF!IFaxAccountFolders;
const GUID IID_IFaxAccountIncomingArchive   = GUIDOF!IFaxAccountIncomingArchive;
const GUID IID_IFaxAccountIncomingQueue     = GUIDOF!IFaxAccountIncomingQueue;
const GUID IID_IFaxAccountNotify            = GUIDOF!IFaxAccountNotify;
const GUID IID_IFaxAccountOutgoingArchive   = GUIDOF!IFaxAccountOutgoingArchive;
const GUID IID_IFaxAccountOutgoingQueue     = GUIDOF!IFaxAccountOutgoingQueue;
const GUID IID_IFaxAccountSet               = GUIDOF!IFaxAccountSet;
const GUID IID_IFaxAccounts                 = GUIDOF!IFaxAccounts;
const GUID IID_IFaxActivity                 = GUIDOF!IFaxActivity;
const GUID IID_IFaxActivityLogging          = GUIDOF!IFaxActivityLogging;
const GUID IID_IFaxConfiguration            = GUIDOF!IFaxConfiguration;
const GUID IID_IFaxDevice                   = GUIDOF!IFaxDevice;
const GUID IID_IFaxDeviceIds                = GUIDOF!IFaxDeviceIds;
const GUID IID_IFaxDeviceProvider           = GUIDOF!IFaxDeviceProvider;
const GUID IID_IFaxDeviceProviders          = GUIDOF!IFaxDeviceProviders;
const GUID IID_IFaxDevices                  = GUIDOF!IFaxDevices;
const GUID IID_IFaxDocument                 = GUIDOF!IFaxDocument;
const GUID IID_IFaxDocument2                = GUIDOF!IFaxDocument2;
const GUID IID_IFaxEventLogging             = GUIDOF!IFaxEventLogging;
const GUID IID_IFaxFolders                  = GUIDOF!IFaxFolders;
const GUID IID_IFaxInboundRouting           = GUIDOF!IFaxInboundRouting;
const GUID IID_IFaxInboundRoutingExtension  = GUIDOF!IFaxInboundRoutingExtension;
const GUID IID_IFaxInboundRoutingExtensions = GUIDOF!IFaxInboundRoutingExtensions;
const GUID IID_IFaxInboundRoutingMethod     = GUIDOF!IFaxInboundRoutingMethod;
const GUID IID_IFaxInboundRoutingMethods    = GUIDOF!IFaxInboundRoutingMethods;
const GUID IID_IFaxIncomingArchive          = GUIDOF!IFaxIncomingArchive;
const GUID IID_IFaxIncomingJob              = GUIDOF!IFaxIncomingJob;
const GUID IID_IFaxIncomingJobs             = GUIDOF!IFaxIncomingJobs;
const GUID IID_IFaxIncomingMessage          = GUIDOF!IFaxIncomingMessage;
const GUID IID_IFaxIncomingMessage2         = GUIDOF!IFaxIncomingMessage2;
const GUID IID_IFaxIncomingMessageIterator  = GUIDOF!IFaxIncomingMessageIterator;
const GUID IID_IFaxIncomingQueue            = GUIDOF!IFaxIncomingQueue;
const GUID IID_IFaxJobStatus                = GUIDOF!IFaxJobStatus;
const GUID IID_IFaxLoggingOptions           = GUIDOF!IFaxLoggingOptions;
const GUID IID_IFaxOutboundRouting          = GUIDOF!IFaxOutboundRouting;
const GUID IID_IFaxOutboundRoutingGroup     = GUIDOF!IFaxOutboundRoutingGroup;
const GUID IID_IFaxOutboundRoutingGroups    = GUIDOF!IFaxOutboundRoutingGroups;
const GUID IID_IFaxOutboundRoutingRule      = GUIDOF!IFaxOutboundRoutingRule;
const GUID IID_IFaxOutboundRoutingRules     = GUIDOF!IFaxOutboundRoutingRules;
const GUID IID_IFaxOutgoingArchive          = GUIDOF!IFaxOutgoingArchive;
const GUID IID_IFaxOutgoingJob              = GUIDOF!IFaxOutgoingJob;
const GUID IID_IFaxOutgoingJob2             = GUIDOF!IFaxOutgoingJob2;
const GUID IID_IFaxOutgoingJobs             = GUIDOF!IFaxOutgoingJobs;
const GUID IID_IFaxOutgoingMessage          = GUIDOF!IFaxOutgoingMessage;
const GUID IID_IFaxOutgoingMessage2         = GUIDOF!IFaxOutgoingMessage2;
const GUID IID_IFaxOutgoingMessageIterator  = GUIDOF!IFaxOutgoingMessageIterator;
const GUID IID_IFaxOutgoingQueue            = GUIDOF!IFaxOutgoingQueue;
const GUID IID_IFaxReceiptOptions           = GUIDOF!IFaxReceiptOptions;
const GUID IID_IFaxRecipient                = GUIDOF!IFaxRecipient;
const GUID IID_IFaxRecipients               = GUIDOF!IFaxRecipients;
const GUID IID_IFaxSecurity                 = GUIDOF!IFaxSecurity;
const GUID IID_IFaxSecurity2                = GUIDOF!IFaxSecurity2;
const GUID IID_IFaxSender                   = GUIDOF!IFaxSender;
const GUID IID_IFaxServer                   = GUIDOF!IFaxServer;
const GUID IID_IFaxServer2                  = GUIDOF!IFaxServer2;
const GUID IID_IFaxServerNotify             = GUIDOF!IFaxServerNotify;
const GUID IID_IFaxServerNotify2            = GUIDOF!IFaxServerNotify2;
const GUID IID__IFaxAccountNotify           = GUIDOF!_IFaxAccountNotify;
const GUID IID__IFaxServerNotify2           = GUIDOF!_IFaxServerNotify2;
