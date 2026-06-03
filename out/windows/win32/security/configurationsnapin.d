// Written in the D programming language.

module windows.win32.security.configurationsnapin;

public import windows.core;
public import windows.win32.foundation : BOOL, HRESULT;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


alias SCE_LOG_ERR_LEVEL = int;
enum : int
{
    SCE_LOG_LEVEL_ALWAYS = 0x00000000,
    SCE_LOG_LEVEL_ERROR  = 0x00000001,
    SCE_LOG_LEVEL_DETAIL = 0x00000002,
    SCE_LOG_LEVEL_DEBUG  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/scesvc/ne-scesvc-scesvc_info_type
alias SCESVC_INFO_TYPE = int;
enum : int
{
    SceSvcConfigurationInfo = 0x00000000,
    SceSvcMergedPolicyInfo  = 0x00000001,
    SceSvcAnalysisInfo      = 0x00000002,
    SceSvcInternalUse       = 0x00000003,
}

// Constants


enum : GUID
{
    cNodetypeSceTemplateServices = GUID("24a7f717-1f0c-11d1-affb-00c04fb984f9"),
    cNodetypeSceAnalysisServices = GUID("678050c7-1ff8-11d1-affb-00c04fb984f9"),
    cNodetypeSceEventLog         = GUID("2ce06698-4bf3-11d1-8c30-00c04fb984f9"),
}

enum : int
{
    SCESTATUS_SUCCESS           = 0x00000000,
    SCESTATUS_INVALID_PARAMETER = 0x00000001,
}

enum int SCESTATUS_RECORD_NOT_FOUND = 0x00000002;

enum : int
{
    SCESTATUS_INVALID_DATA     = 0x00000003,
    SCESTATUS_OBJECT_EXIST     = 0x00000004,
    SCESTATUS_BUFFER_TOO_SMALL = 0x00000005,
}

enum int SCESTATUS_PROFILE_NOT_FOUND = 0x00000006;

enum : int
{
    SCESTATUS_BAD_FORMAT          = 0x00000007,
    SCESTATUS_NOT_ENOUGH_RESOURCE = 0x00000008,
}

enum : int
{
    SCESTATUS_ACCESS_DENIED   = 0x00000009,
    SCESTATUS_CANT_DELETE     = 0x0000000a,
    SCESTATUS_PREFIX_OVERFLOW = 0x0000000b,
}

enum : int
{
    SCESTATUS_OTHER_ERROR     = 0x0000000c,
    SCESTATUS_ALREADY_RUNNING = 0x0000000d,
}

enum int SCESTATUS_SERVICE_NOT_SUPPORT = 0x0000000e;

enum : int
{
    SCESTATUS_MOD_NOT_FOUND       = 0x0000000f,
    SCESTATUS_EXCEPTION_IN_SERVER = 0x00000010,
}

enum : int
{
    SCESTATUS_NO_TEMPLATE_GIVEN = 0x00000011,
    SCESTATUS_NO_MAPPING        = 0x00000012,
    SCESTATUS_TRUST_FAIL        = 0x00000013,
}

enum const(wchar)* SCE_ROOT_PATH = "Software\\Microsoft\\Windows NT\\CurrentVersion\\SeCEdit";
enum int SCESVC_ENUMERATION_MAX = 0x00000064;
// Native encoding: ansi
enum const(wchar)* struuidNodetypeSceTemplateServices = "{24a7f717-1f0c-11d1-affb-00c04fb984f9}";
enum const(wchar)* lstruuidNodetypeSceTemplateServices = "{24a7f717-1f0c-11d1-affb-00c04fb984f9}";
// Native encoding: ansi
enum const(wchar)* struuidNodetypeSceAnalysisServices = "{678050c7-1ff8-11d1-affb-00c04fb984f9}";
enum const(wchar)* lstruuidNodetypeSceAnalysisServices = "{678050c7-1ff8-11d1-affb-00c04fb984f9}";
// Native encoding: ansi
enum const(wchar)* struuidNodetypeSceEventLog = "{2ce06698-4bf3-11d1-8c30-00c04fb984f9}";
enum const(wchar)* lstruuidNodetypeSceEventLog = "{2ce06698-4bf3-11d1-8c30-00c04fb984f9}";

enum : const(wchar)*
{
    CCF_SCESVC_ATTACHMENT      = "CCF_SCESVC_ATTACHMENT",
    CCF_SCESVC_ATTACHMENT_DATA = "CCF_SCESVC_ATTACHMENT_DATA",
}

// Callbacks

alias PFSCE_QUERY_INFO = uint function(void* sceHandle, SCESVC_INFO_TYPE sceType, byte* lpPrefix, BOOL bExact, 
                                       void** ppvInfo, uint* psceEnumHandle);
alias PFSCE_SET_INFO = uint function(void* sceHandle, SCESVC_INFO_TYPE sceType, byte* lpPrefix, BOOL bExact, 
                                     void* pvInfo);
alias PFSCE_FREE_INFO = uint function(void* pvServiceInfo);
alias PFSCE_LOG_INFO = uint function(SCE_LOG_ERR_LEVEL ErrLevel, uint Win32rc, byte* pErrFmt);
alias PF_ConfigAnalyzeService = uint function(SCESVC_CALLBACK_INFO* pSceCbInfo);
alias PF_UpdateService = uint function(SCESVC_CALLBACK_INFO* pSceCbInfo, SCESVC_CONFIGURATION_INFO* ServiceInfo);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/scesvc/ns-scesvc-scesvc_configuration_line
struct SCESVC_CONFIGURATION_LINE
{
    byte* Key;
    byte* Value;
    uint  ValueLen;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/scesvc/ns-scesvc-scesvc_configuration_info
struct SCESVC_CONFIGURATION_INFO
{
    uint Count;
    SCESVC_CONFIGURATION_LINE* Lines;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/scesvc/ns-scesvc-scesvc_analysis_line
struct SCESVC_ANALYSIS_LINE
{
    byte*  Key;
    ubyte* Value;
    uint   ValueLen;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/scesvc/ns-scesvc-scesvc_analysis_info
struct SCESVC_ANALYSIS_INFO
{
    uint Count;
    SCESVC_ANALYSIS_LINE* Lines;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/scesvc/ns-scesvc-scesvc_callback_info
struct SCESVC_CALLBACK_INFO
{
    void*            sceHandle;
    PFSCE_QUERY_INFO pfQueryInfo;
    PFSCE_SET_INFO   pfSetInfo;
    PFSCE_FREE_INFO  pfFreeInfo;
    PFSCE_LOG_INFO   pfLogInfo;
}

// Interfaces

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/scesvc/nn-scesvc-iscesvcattachmentpersistinfo
@GUID("6d90e0d0-200d-11d1-affb-00c04fb984f9")
interface ISceSvcAttachmentPersistInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/scesvc/nf-scesvc-iscesvcattachmentpersistinfo-save
    HRESULT Save(byte* lpTemplateName, void** scesvcHandle, void** ppvData, BOOL* pbOverwriteAll);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT IsDirty(byte* lpTemplateName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/scesvc/nf-scesvc-iscesvcattachmentpersistinfo-freebuffer
    HRESULT FreeBuffer(void* pvData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/scesvc/nn-scesvc-iscesvcattachmentdata
@GUID("17c35fde-200d-11d1-affb-00c04fb984f9")
interface ISceSvcAttachmentData : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/scesvc/nf-scesvc-iscesvcattachmentdata-getdata
    HRESULT GetData(void* scesvcHandle, SCESVC_INFO_TYPE sceType, void** ppvData, uint* psceEnumHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/scesvc/nf-scesvc-iscesvcattachmentdata-initialize
    HRESULT Initialize(byte* lpServiceName, byte* lpTemplateName, ISceSvcAttachmentPersistInfo lpSceSvcPersistInfo, 
                       void** pscesvcHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/scesvc/nf-scesvc-iscesvcattachmentdata-freebuffer
    HRESULT FreeBuffer(void* pvData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/scesvc/nf-scesvc-iscesvcattachmentdata-closehandle
    HRESULT CloseHandle(void* scesvcHandle);
}


// GUIDs


const GUID IID_ISceSvcAttachmentData        = GUIDOF!ISceSvcAttachmentData;
const GUID IID_ISceSvcAttachmentPersistInfo = GUIDOF!ISceSvcAttachmentPersistInfo;
