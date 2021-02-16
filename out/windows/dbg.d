module windows.dbg;

public import windows.core;
public import windows.automation : BSTR, DISPPARAMS, EXCEPINFO, IDispatch, IDispatchEx, ITypeInfo, SAFEARRAY, TYPEDESC,
                                   VARIANT;
public import windows.com : CADWORD, CALPOLESTR, HRESULT, IEnumUnknown, IUnknown;
public import windows.displaydevices : POINT, RECT, SIZE;
public import windows.dxgi : DXGI_FORMAT;
public import windows.gdi : HDC, HRGN;
public import windows.menusandresources : VS_FIXEDFILEINFO;
public import windows.shell : IActiveIMMApp, LOGFONTW;
public import windows.structuredstorage : ILockBytes;
public import windows.systemservices : BOOL, FLOATING_SAVE_AREA, HANDLE, IMAGE_LOAD_CONFIG_CODE_INTEGRITY,
                                       IServiceProvider, LARGE_INTEGER, LPTHREAD_START_ROUTINE, NTSTATUS,
                                       XSTATE_FEATURE;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : TIME_ZONE_INFORMATION;

extern(Windows):


// Enums


enum : int
{
    WctCriticalSectionType = 0x00000001,
    WctSendMessageType     = 0x00000002,
    WctMutexType           = 0x00000003,
    WctAlpcType            = 0x00000004,
    WctComType             = 0x00000005,
    WctThreadWaitType      = 0x00000006,
    WctProcessWaitType     = 0x00000007,
    WctThreadType          = 0x00000008,
    WctComActivationType   = 0x00000009,
    WctUnknownType         = 0x0000000a,
    WctSocketIoType        = 0x0000000b,
    WctSmbIoType           = 0x0000000c,
    WctMaxType             = 0x0000000d,
}
alias WCT_OBJECT_TYPE = int;

enum : int
{
    WctStatusNoAccess     = 0x00000001,
    WctStatusRunning      = 0x00000002,
    WctStatusBlocked      = 0x00000003,
    WctStatusPidOnly      = 0x00000004,
    WctStatusPidOnlyRpcss = 0x00000005,
    WctStatusOwned        = 0x00000006,
    WctStatusNotOwned     = 0x00000007,
    WctStatusAbandoned    = 0x00000008,
    WctStatusUnknown      = 0x00000009,
    WctStatusError        = 0x0000000a,
    WctStatusMax          = 0x0000000b,
}
alias WCT_OBJECT_STATUS = int;

enum : int
{
    UnusedStream                = 0x00000000,
    ReservedStream0             = 0x00000001,
    ReservedStream1             = 0x00000002,
    ThreadListStream            = 0x00000003,
    ModuleListStream            = 0x00000004,
    MemoryListStream            = 0x00000005,
    ExceptionStream             = 0x00000006,
    SystemInfoStream            = 0x00000007,
    ThreadExListStream          = 0x00000008,
    Memory64ListStream          = 0x00000009,
    CommentStreamA              = 0x0000000a,
    CommentStreamW              = 0x0000000b,
    HandleDataStream            = 0x0000000c,
    FunctionTableStream         = 0x0000000d,
    UnloadedModuleListStream    = 0x0000000e,
    MiscInfoStream              = 0x0000000f,
    MemoryInfoListStream        = 0x00000010,
    ThreadInfoListStream        = 0x00000011,
    HandleOperationListStream   = 0x00000012,
    TokenStream                 = 0x00000013,
    JavaScriptDataStream        = 0x00000014,
    SystemMemoryInfoStream      = 0x00000015,
    ProcessVmCountersStream     = 0x00000016,
    IptTraceStream              = 0x00000017,
    ThreadNamesStream           = 0x00000018,
    ceStreamNull                = 0x00008000,
    ceStreamSystemInfo          = 0x00008001,
    ceStreamException           = 0x00008002,
    ceStreamModuleList          = 0x00008003,
    ceStreamProcessList         = 0x00008004,
    ceStreamThreadList          = 0x00008005,
    ceStreamThreadContextList   = 0x00008006,
    ceStreamThreadCallStackList = 0x00008007,
    ceStreamMemoryVirtualList   = 0x00008008,
    ceStreamMemoryPhysicalList  = 0x00008009,
    ceStreamBucketParameters    = 0x0000800a,
    ceStreamProcessModuleMap    = 0x0000800b,
    ceStreamDiagnosisList       = 0x0000800c,
    LastReservedStream          = 0x0000ffff,
}
alias MINIDUMP_STREAM_TYPE = int;

enum : int
{
    MiniHandleObjectInformationNone    = 0x00000000,
    MiniThreadInformation1             = 0x00000001,
    MiniMutantInformation1             = 0x00000002,
    MiniMutantInformation2             = 0x00000003,
    MiniProcessInformation1            = 0x00000004,
    MiniProcessInformation2            = 0x00000005,
    MiniEventInformation1              = 0x00000006,
    MiniSectionInformation1            = 0x00000007,
    MiniSemaphoreInformation1          = 0x00000008,
    MiniHandleObjectInformationTypeMax = 0x00000009,
}
alias MINIDUMP_HANDLE_OBJECT_INFORMATION_TYPE = int;

enum : int
{
    ModuleCallback               = 0x00000000,
    ThreadCallback               = 0x00000001,
    ThreadExCallback             = 0x00000002,
    IncludeThreadCallback        = 0x00000003,
    IncludeModuleCallback        = 0x00000004,
    MemoryCallback               = 0x00000005,
    CancelCallback               = 0x00000006,
    WriteKernelMinidumpCallback  = 0x00000007,
    KernelMinidumpStatusCallback = 0x00000008,
    RemoveMemoryCallback         = 0x00000009,
    IncludeVmRegionCallback      = 0x0000000a,
    IoStartCallback              = 0x0000000b,
    IoWriteAllCallback           = 0x0000000c,
    IoFinishCallback             = 0x0000000d,
    ReadMemoryFailureCallback    = 0x0000000e,
    SecondaryFlagsCallback       = 0x0000000f,
    IsProcessSnapshotCallback    = 0x00000010,
    VmStartCallback              = 0x00000011,
    VmQueryCallback              = 0x00000012,
    VmPreReadCallback            = 0x00000013,
    VmPostReadCallback           = 0x00000014,
}
alias MINIDUMP_CALLBACK_TYPE = int;

enum : int
{
    ThreadWriteThread            = 0x00000001,
    ThreadWriteStack             = 0x00000002,
    ThreadWriteContext           = 0x00000004,
    ThreadWriteBackingStore      = 0x00000008,
    ThreadWriteInstructionWindow = 0x00000010,
    ThreadWriteThreadData        = 0x00000020,
    ThreadWriteThreadInfo        = 0x00000040,
}
alias THREAD_WRITE_FLAGS = int;

enum : int
{
    ModuleWriteModule        = 0x00000001,
    ModuleWriteDataSeg       = 0x00000002,
    ModuleWriteMiscRecord    = 0x00000004,
    ModuleWriteCvRecord      = 0x00000008,
    ModuleReferencedByMemory = 0x00000010,
    ModuleWriteTlsData       = 0x00000020,
    ModuleWriteCodeSegs      = 0x00000040,
}
alias MODULE_WRITE_FLAGS = int;

enum : int
{
    MiniDumpNormal                         = 0x00000000,
    MiniDumpWithDataSegs                   = 0x00000001,
    MiniDumpWithFullMemory                 = 0x00000002,
    MiniDumpWithHandleData                 = 0x00000004,
    MiniDumpFilterMemory                   = 0x00000008,
    MiniDumpScanMemory                     = 0x00000010,
    MiniDumpWithUnloadedModules            = 0x00000020,
    MiniDumpWithIndirectlyReferencedMemory = 0x00000040,
    MiniDumpFilterModulePaths              = 0x00000080,
    MiniDumpWithProcessThreadData          = 0x00000100,
    MiniDumpWithPrivateReadWriteMemory     = 0x00000200,
    MiniDumpWithoutOptionalData            = 0x00000400,
    MiniDumpWithFullMemoryInfo             = 0x00000800,
    MiniDumpWithThreadInfo                 = 0x00001000,
    MiniDumpWithCodeSegs                   = 0x00002000,
    MiniDumpWithoutAuxiliaryState          = 0x00004000,
    MiniDumpWithFullAuxiliaryState         = 0x00008000,
    MiniDumpWithPrivateWriteCopyMemory     = 0x00010000,
    MiniDumpIgnoreInaccessibleMemory       = 0x00020000,
    MiniDumpWithTokenInformation           = 0x00040000,
    MiniDumpWithModuleHeaders              = 0x00080000,
    MiniDumpFilterTriage                   = 0x00100000,
    MiniDumpWithAvxXStateContext           = 0x00200000,
    MiniDumpWithIptTrace                   = 0x00400000,
    MiniDumpScanInaccessiblePartialPages   = 0x00800000,
    MiniDumpValidTypeFlags                 = 0x00ffffff,
}
alias MINIDUMP_TYPE = int;

enum : int
{
    MiniSecondaryWithoutPowerInfo = 0x00000001,
    MiniSecondaryValidFlags       = 0x00000001,
}
alias MINIDUMP_SECONDARY_FLAGS = int;

enum : int
{
    SCRIPTLANGUAGEVERSION_DEFAULT = 0x00000000,
    SCRIPTLANGUAGEVERSION_5_7     = 0x00000001,
    SCRIPTLANGUAGEVERSION_5_8     = 0x00000002,
    SCRIPTLANGUAGEVERSION_MAX     = 0x000000ff,
}
alias SCRIPTLANGUAGEVERSION = int;

enum : int
{
    SCRIPTSTATE_UNINITIALIZED = 0x00000000,
    SCRIPTSTATE_INITIALIZED   = 0x00000005,
    SCRIPTSTATE_STARTED       = 0x00000001,
    SCRIPTSTATE_CONNECTED     = 0x00000002,
    SCRIPTSTATE_DISCONNECTED  = 0x00000003,
    SCRIPTSTATE_CLOSED        = 0x00000004,
}
alias SCRIPTSTATE = int;

enum : int
{
    SCRIPTTRACEINFO_SCRIPTSTART    = 0x00000000,
    SCRIPTTRACEINFO_SCRIPTEND      = 0x00000001,
    SCRIPTTRACEINFO_COMCALLSTART   = 0x00000002,
    SCRIPTTRACEINFO_COMCALLEND     = 0x00000003,
    SCRIPTTRACEINFO_CREATEOBJSTART = 0x00000004,
    SCRIPTTRACEINFO_CREATEOBJEND   = 0x00000005,
    SCRIPTTRACEINFO_GETOBJSTART    = 0x00000006,
    SCRIPTTRACEINFO_GETOBJEND      = 0x00000007,
}
alias SCRIPTTRACEINFO = int;

enum : int
{
    SCRIPTTHREADSTATE_NOTINSCRIPT = 0x00000000,
    SCRIPTTHREADSTATE_RUNNING     = 0x00000001,
}
alias SCRIPTTHREADSTATE = int;

enum : int
{
    SCRIPTGCTYPE_NORMAL     = 0x00000000,
    SCRIPTGCTYPE_EXHAUSTIVE = 0x00000001,
}
alias SCRIPTGCTYPE = int;

enum : int
{
    SCRIPTUICITEM_INPUTBOX = 0x00000001,
    SCRIPTUICITEM_MSGBOX   = 0x00000002,
}
alias SCRIPTUICITEM = int;

enum : int
{
    SCRIPTUICHANDLING_ALLOW       = 0x00000000,
    SCRIPTUICHANDLING_NOUIERROR   = 0x00000001,
    SCRIPTUICHANDLING_NOUIDEFAULT = 0x00000002,
}
alias SCRIPTUICHANDLING = int;

enum : int
{
    DBGPROP_ATTRIB_NO_ATTRIB              = 0x00000000,
    DBGPROP_ATTRIB_VALUE_IS_INVALID       = 0x00000008,
    DBGPROP_ATTRIB_VALUE_IS_EXPANDABLE    = 0x00000010,
    DBGPROP_ATTRIB_VALUE_IS_FAKE          = 0x00000020,
    DBGPROP_ATTRIB_VALUE_IS_METHOD        = 0x00000100,
    DBGPROP_ATTRIB_VALUE_IS_EVENT         = 0x00000200,
    DBGPROP_ATTRIB_VALUE_IS_RAW_STRING    = 0x00000400,
    DBGPROP_ATTRIB_VALUE_READONLY         = 0x00000800,
    DBGPROP_ATTRIB_ACCESS_PUBLIC          = 0x00001000,
    DBGPROP_ATTRIB_ACCESS_PRIVATE         = 0x00002000,
    DBGPROP_ATTRIB_ACCESS_PROTECTED       = 0x00004000,
    DBGPROP_ATTRIB_ACCESS_FINAL           = 0x00008000,
    DBGPROP_ATTRIB_STORAGE_GLOBAL         = 0x00010000,
    DBGPROP_ATTRIB_STORAGE_STATIC         = 0x00020000,
    DBGPROP_ATTRIB_STORAGE_FIELD          = 0x00040000,
    DBGPROP_ATTRIB_STORAGE_VIRTUAL        = 0x00080000,
    DBGPROP_ATTRIB_TYPE_IS_CONSTANT       = 0x00100000,
    DBGPROP_ATTRIB_TYPE_IS_SYNCHRONIZED   = 0x00200000,
    DBGPROP_ATTRIB_TYPE_IS_VOLATILE       = 0x00400000,
    DBGPROP_ATTRIB_HAS_EXTENDED_ATTRIBS   = 0x00800000,
    DBGPROP_ATTRIB_FRAME_INTRYBLOCK       = 0x01000000,
    DBGPROP_ATTRIB_FRAME_INCATCHBLOCK     = 0x02000000,
    DBGPROP_ATTRIB_FRAME_INFINALLYBLOCK   = 0x04000000,
    DBGPROP_ATTRIB_VALUE_IS_RETURN_VALUE  = 0x08000000,
    DBGPROP_ATTRIB_VALUE_PENDING_MUTATION = 0x10000000,
}
alias __MIDL___MIDL_itf_dbgprop_0000_0000_0001 = int;

enum : int
{
    DBGPROP_INFO_NAME         = 0x00000001,
    DBGPROP_INFO_TYPE         = 0x00000002,
    DBGPROP_INFO_VALUE        = 0x00000004,
    DBGPROP_INFO_FULLNAME     = 0x00000020,
    DBGPROP_INFO_ATTRIBUTES   = 0x00000008,
    DBGPROP_INFO_DEBUGPROP    = 0x00000010,
    DBGPROP_INFO_BEAUTIFY     = 0x02000000,
    DBGPROP_INFO_CALLTOSTRING = 0x04000000,
    DBGPROP_INFO_AUTOEXPAND   = 0x08000000,
}
alias __MIDL___MIDL_itf_dbgprop_0000_0000_0002 = int;

enum : int
{
    OBJECT_ATTRIB_NO_ATTRIB            = 0x00000000,
    OBJECT_ATTRIB_NO_NAME              = 0x00000001,
    OBJECT_ATTRIB_NO_TYPE              = 0x00000002,
    OBJECT_ATTRIB_NO_VALUE             = 0x00000004,
    OBJECT_ATTRIB_VALUE_IS_INVALID     = 0x00000008,
    OBJECT_ATTRIB_VALUE_IS_OBJECT      = 0x00000010,
    OBJECT_ATTRIB_VALUE_IS_ENUM        = 0x00000020,
    OBJECT_ATTRIB_VALUE_IS_CUSTOM      = 0x00000040,
    OBJECT_ATTRIB_OBJECT_IS_EXPANDABLE = 0x00000070,
    OBJECT_ATTRIB_VALUE_HAS_CODE       = 0x00000080,
    OBJECT_ATTRIB_TYPE_IS_OBJECT       = 0x00000100,
    OBJECT_ATTRIB_TYPE_HAS_CODE        = 0x00000200,
    OBJECT_ATTRIB_TYPE_IS_EXPANDABLE   = 0x00000100,
    OBJECT_ATTRIB_SLOT_IS_CATEGORY     = 0x00000400,
    OBJECT_ATTRIB_VALUE_READONLY       = 0x00000800,
    OBJECT_ATTRIB_ACCESS_PUBLIC        = 0x00001000,
    OBJECT_ATTRIB_ACCESS_PRIVATE       = 0x00002000,
    OBJECT_ATTRIB_ACCESS_PROTECTED     = 0x00004000,
    OBJECT_ATTRIB_ACCESS_FINAL         = 0x00008000,
    OBJECT_ATTRIB_STORAGE_GLOBAL       = 0x00010000,
    OBJECT_ATTRIB_STORAGE_STATIC       = 0x00020000,
    OBJECT_ATTRIB_STORAGE_FIELD        = 0x00040000,
    OBJECT_ATTRIB_STORAGE_VIRTUAL      = 0x00080000,
    OBJECT_ATTRIB_TYPE_IS_CONSTANT     = 0x00100000,
    OBJECT_ATTRIB_TYPE_IS_SYNCHRONIZED = 0x00200000,
    OBJECT_ATTRIB_TYPE_IS_VOLATILE     = 0x00400000,
    OBJECT_ATTRIB_HAS_EXTENDED_ATTRIBS = 0x00800000,
    OBJECT_ATTRIB_IS_CLASS             = 0x01000000,
    OBJECT_ATTRIB_IS_FUNCTION          = 0x02000000,
    OBJECT_ATTRIB_IS_VARIABLE          = 0x04000000,
    OBJECT_ATTRIB_IS_PROPERTY          = 0x08000000,
    OBJECT_ATTRIB_IS_MACRO             = 0x10000000,
    OBJECT_ATTRIB_IS_TYPE              = 0x20000000,
    OBJECT_ATTRIB_IS_INHERITED         = 0x40000000,
    OBJECT_ATTRIB_IS_INTERFACE         = 0x80000000,
}
alias tagOBJECT_ATTRIB_FLAG = int;

enum : int
{
    PROP_INFO_NAME       = 0x00000001,
    PROP_INFO_TYPE       = 0x00000002,
    PROP_INFO_VALUE      = 0x00000004,
    PROP_INFO_FULLNAME   = 0x00000020,
    PROP_INFO_ATTRIBUTES = 0x00000008,
    PROP_INFO_DEBUGPROP  = 0x00000010,
    PROP_INFO_AUTOEXPAND = 0x08000000,
}
alias PROP_INFO_FLAGS = int;

enum : int
{
    EX_PROP_INFO_ID           = 0x00000100,
    EX_PROP_INFO_NTYPE        = 0x00000200,
    EX_PROP_INFO_NVALUE       = 0x00000400,
    EX_PROP_INFO_LOCKBYTES    = 0x00000800,
    EX_PROP_INFO_DEBUGEXTPROP = 0x00001000,
}
alias EX_PROP_INFO_FLAGS = int;

enum : int
{
    BREAKPOINT_DELETED  = 0x00000000,
    BREAKPOINT_DISABLED = 0x00000001,
    BREAKPOINT_ENABLED  = 0x00000002,
}
alias BREAKPOINT_STATE = int;

enum : int
{
    BREAKREASON_STEP                = 0x00000000,
    BREAKREASON_BREAKPOINT          = 0x00000001,
    BREAKREASON_DEBUGGER_BLOCK      = 0x00000002,
    BREAKREASON_HOST_INITIATED      = 0x00000003,
    BREAKREASON_LANGUAGE_INITIATED  = 0x00000004,
    BREAKREASON_DEBUGGER_HALT       = 0x00000005,
    BREAKREASON_ERROR               = 0x00000006,
    BREAKREASON_JIT                 = 0x00000007,
    BREAKREASON_MUTATION_BREAKPOINT = 0x00000008,
}
alias BREAKREASON = int;

enum : int
{
    BREAKRESUMEACTION_ABORT         = 0x00000000,
    BREAKRESUMEACTION_CONTINUE      = 0x00000001,
    BREAKRESUMEACTION_STEP_INTO     = 0x00000002,
    BREAKRESUMEACTION_STEP_OVER     = 0x00000003,
    BREAKRESUMEACTION_STEP_OUT      = 0x00000004,
    BREAKRESUMEACTION_IGNORE        = 0x00000005,
    BREAKRESUMEACTION_STEP_DOCUMENT = 0x00000006,
}
alias tagBREAKRESUME_ACTION = int;

enum : int
{
    ERRORRESUMEACTION_ReexecuteErrorStatement         = 0x00000000,
    ERRORRESUMEACTION_AbortCallAndReturnErrorToCaller = 0x00000001,
    ERRORRESUMEACTION_SkipErrorStatement              = 0x00000002,
}
alias ERRORRESUMEACTION = int;

enum : int
{
    DOCUMENTNAMETYPE_APPNODE        = 0x00000000,
    DOCUMENTNAMETYPE_TITLE          = 0x00000001,
    DOCUMENTNAMETYPE_FILE_TAIL      = 0x00000002,
    DOCUMENTNAMETYPE_URL            = 0x00000003,
    DOCUMENTNAMETYPE_UNIQUE_TITLE   = 0x00000004,
    DOCUMENTNAMETYPE_SOURCE_MAP_URL = 0x00000005,
}
alias DOCUMENTNAMETYPE = int;

enum : int
{
    PROFILER_SCRIPT_TYPE_USER    = 0x00000000,
    PROFILER_SCRIPT_TYPE_DYNAMIC = 0x00000001,
    PROFILER_SCRIPT_TYPE_NATIVE  = 0x00000002,
    PROFILER_SCRIPT_TYPE_DOM     = 0x00000003,
}
alias __MIDL___MIDL_itf_activprof_0000_0000_0001 = int;

enum : int
{
    PROFILER_EVENT_MASK_TRACE_SCRIPT_FUNCTION_CALL = 0x00000001,
    PROFILER_EVENT_MASK_TRACE_NATIVE_FUNCTION_CALL = 0x00000002,
    PROFILER_EVENT_MASK_TRACE_DOM_FUNCTION_CALL    = 0x00000004,
    PROFILER_EVENT_MASK_TRACE_ALL                  = 0x00000003,
    PROFILER_EVENT_MASK_TRACE_ALL_WITH_DOM         = 0x00000007,
}
alias __MIDL___MIDL_itf_activprof_0000_0000_0002 = int;

enum : int
{
    PROFILER_HEAP_OBJECT_FLAGS_NEW_OBJECT            = 0x00000001,
    PROFILER_HEAP_OBJECT_FLAGS_IS_ROOT               = 0x00000002,
    PROFILER_HEAP_OBJECT_FLAGS_SITE_CLOSED           = 0x00000004,
    PROFILER_HEAP_OBJECT_FLAGS_EXTERNAL              = 0x00000008,
    PROFILER_HEAP_OBJECT_FLAGS_EXTERNAL_UNKNOWN      = 0x00000010,
    PROFILER_HEAP_OBJECT_FLAGS_EXTERNAL_DISPATCH     = 0x00000020,
    PROFILER_HEAP_OBJECT_FLAGS_SIZE_APPROXIMATE      = 0x00000040,
    PROFILER_HEAP_OBJECT_FLAGS_SIZE_UNAVAILABLE      = 0x00000080,
    PROFILER_HEAP_OBJECT_FLAGS_NEW_STATE_UNAVAILABLE = 0x00000100,
    PROFILER_HEAP_OBJECT_FLAGS_WINRT_INSTANCE        = 0x00000200,
    PROFILER_HEAP_OBJECT_FLAGS_WINRT_RUNTIMECLASS    = 0x00000400,
    PROFILER_HEAP_OBJECT_FLAGS_WINRT_DELEGATE        = 0x00000800,
    PROFILER_HEAP_OBJECT_FLAGS_WINRT_NAMESPACE       = 0x00001000,
}
alias __MIDL___MIDL_itf_activprof_0000_0002_0001 = int;

enum : int
{
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_PROTOTYPE                  = 0x00000001,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_FUNCTION_NAME              = 0x00000002,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_SCOPE_LIST                 = 0x00000003,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_INTERNAL_PROPERTY          = 0x00000004,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_NAME_PROPERTIES            = 0x00000005,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_INDEX_PROPERTIES           = 0x00000006,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_ELEMENT_ATTRIBUTES_SIZE    = 0x00000007,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_ELEMENT_TEXT_CHILDREN_SIZE = 0x00000008,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_RELATIONSHIPS              = 0x00000009,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_WINRTEVENTS                = 0x0000000a,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_WEAKMAP_COLLECTION_LIST    = 0x0000000b,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_MAP_COLLECTION_LIST        = 0x0000000c,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_SET_COLLECTION_LIST        = 0x0000000d,
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_MAX_VALUE                  = 0x0000000d,
}
alias __MIDL___MIDL_itf_activprof_0000_0002_0002 = int;

enum : int
{
    PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS_NONE            = 0x00000000,
    PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS_IS_GET_ACCESSOR = 0x00010000,
    PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS_IS_SET_ACCESSOR = 0x00020000,
    PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS_LET_VARIABLE    = 0x00040000,
    PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS_CONST_VARIABLE  = 0x00080000,
}
alias __MIDL___MIDL_itf_activprof_0000_0002_0003 = int;

enum : int
{
    PROFILER_HEAP_ENUM_FLAGS_NONE                     = 0x00000000,
    PROFILER_HEAP_ENUM_FLAGS_STORE_RELATIONSHIP_FLAGS = 0x00000001,
    PROFILER_HEAP_ENUM_FLAGS_SUBSTRINGS               = 0x00000002,
    PROFILER_HEAP_ENUM_FLAGS_RELATIONSHIP_SUBSTRINGS  = 0x00000003,
}
alias __MIDL___MIDL_itf_activprof_0000_0002_0004 = int;

enum : int
{
    PROFILER_PROPERTY_TYPE_NUMBER          = 0x00000001,
    PROFILER_PROPERTY_TYPE_STRING          = 0x00000002,
    PROFILER_PROPERTY_TYPE_HEAP_OBJECT     = 0x00000003,
    PROFILER_PROPERTY_TYPE_EXTERNAL_OBJECT = 0x00000004,
    PROFILER_PROPERTY_TYPE_BSTR            = 0x00000005,
    PROFILER_PROPERTY_TYPE_SUBSTRING       = 0x00000006,
}
alias __MIDL___MIDL_itf_activprof_0000_0002_0005 = int;

enum : int
{
    PROFILER_HEAP_SUMMARY_VERSION_1 = 0x00000001,
}
alias __MIDL___MIDL_itf_activprof_0000_0004_0001 = int;

enum : int
{
    htmlDesignModeInherit = 0xfffffffe,
    htmlDesignModeOn      = 0xffffffff,
    htmlDesignModeOff     = 0x00000000,
    htmlDesignMode_Max    = 0x7fffffff,
}
alias htmlDesignMode = int;

enum : int
{
    htmlZOrderFront = 0x00000000,
    htmlZOrderBack  = 0x00000001,
    htmlZOrder_Max  = 0x7fffffff,
}
alias htmlZOrder = int;

enum : int
{
    htmlClearNotSet = 0x00000000,
    htmlClearAll    = 0x00000001,
    htmlClearLeft   = 0x00000002,
    htmlClearRight  = 0x00000003,
    htmlClearBoth   = 0x00000004,
    htmlClearNone   = 0x00000005,
    htmlClear_Max   = 0x7fffffff,
}
alias htmlClear = int;

enum : int
{
    htmlControlAlignNotSet    = 0x00000000,
    htmlControlAlignLeft      = 0x00000001,
    htmlControlAlignCenter    = 0x00000002,
    htmlControlAlignRight     = 0x00000003,
    htmlControlAlignTextTop   = 0x00000004,
    htmlControlAlignAbsMiddle = 0x00000005,
    htmlControlAlignBaseline  = 0x00000006,
    htmlControlAlignAbsBottom = 0x00000007,
    htmlControlAlignBottom    = 0x00000008,
    htmlControlAlignMiddle    = 0x00000009,
    htmlControlAlignTop       = 0x0000000a,
    htmlControlAlign_Max      = 0x7fffffff,
}
alias htmlControlAlign = int;

enum : int
{
    htmlBlockAlignNotSet  = 0x00000000,
    htmlBlockAlignLeft    = 0x00000001,
    htmlBlockAlignCenter  = 0x00000002,
    htmlBlockAlignRight   = 0x00000003,
    htmlBlockAlignJustify = 0x00000004,
    htmlBlockAlign_Max    = 0x7fffffff,
}
alias htmlBlockAlign = int;

enum : int
{
    htmlReadyStateuninitialized = 0x00000000,
    htmlReadyStateloading       = 0x00000001,
    htmlReadyStateloaded        = 0x00000002,
    htmlReadyStateinteractive   = 0x00000003,
    htmlReadyStatecomplete      = 0x00000004,
    htmlReadyState_Max          = 0x7fffffff,
}
alias htmlReadyState = int;

enum : int
{
    htmlLoopLoopInfinite = 0xffffffff,
    htmlLoop_Max         = 0x7fffffff,
}
alias htmlLoop = int;

enum : int
{
    mediaTypeNotSet     = 0x00000000,
    mediaTypeAll        = 0x000001ff,
    mediaTypeAural      = 0x00000001,
    mediaTypeBraille    = 0x00000002,
    mediaTypeEmbossed   = 0x00000004,
    mediaTypeHandheld   = 0x00000008,
    mediaTypePrint      = 0x00000010,
    mediaTypeProjection = 0x00000020,
    mediaTypeScreen     = 0x00000040,
    mediaTypeTty        = 0x00000080,
    mediaTypeTv         = 0x00000100,
    mediaType_Max       = 0x7fffffff,
}
alias mediaType = int;

enum DomConstructor : int
{
    DomConstructorObject                      = 0x00000000,
    DomConstructorAttr                        = 0x00000001,
    DomConstructorBehaviorUrnsCollection      = 0x00000002,
    DomConstructorBookmarkCollection          = 0x00000003,
    DomConstructorCompatibleInfo              = 0x00000004,
    DomConstructorCompatibleInfoCollection    = 0x00000005,
    DomConstructorControlRangeCollection      = 0x00000006,
    DomConstructorCSSCurrentStyleDeclaration  = 0x00000007,
    DomConstructorCSSRuleList                 = 0x00000008,
    DomConstructorCSSRuleStyleDeclaration     = 0x00000009,
    DomConstructorCSSStyleDeclaration         = 0x0000000a,
    DomConstructorCSSStyleRule                = 0x0000000b,
    DomConstructorCSSStyleSheet               = 0x0000000c,
    DomConstructorDataTransfer                = 0x0000000d,
    DomConstructorDOMImplementation           = 0x0000000e,
    DomConstructorElement                     = 0x0000000f,
    DomConstructorEvent                       = 0x00000010,
    DomConstructorHistory                     = 0x00000011,
    DomConstructorHTCElementBehaviorDefaults  = 0x00000012,
    DomConstructorHTMLAnchorElement           = 0x00000013,
    DomConstructorHTMLAreaElement             = 0x00000014,
    DomConstructorHTMLAreasCollection         = 0x00000015,
    DomConstructorHTMLBaseElement             = 0x00000016,
    DomConstructorHTMLBaseFontElement         = 0x00000017,
    DomConstructorHTMLBGSoundElement          = 0x00000018,
    DomConstructorHTMLBlockElement            = 0x00000019,
    DomConstructorHTMLBodyElement             = 0x0000001a,
    DomConstructorHTMLBRElement               = 0x0000001b,
    DomConstructorHTMLButtonElement           = 0x0000001c,
    DomConstructorHTMLCollection              = 0x0000001d,
    DomConstructorHTMLCommentElement          = 0x0000001e,
    DomConstructorHTMLDDElement               = 0x0000001f,
    DomConstructorHTMLDivElement              = 0x00000020,
    DomConstructorHTMLDocument                = 0x00000021,
    DomConstructorHTMLDListElement            = 0x00000022,
    DomConstructorHTMLDTElement               = 0x00000023,
    DomConstructorHTMLEmbedElement            = 0x00000024,
    DomConstructorHTMLFieldSetElement         = 0x00000025,
    DomConstructorHTMLFontElement             = 0x00000026,
    DomConstructorHTMLFormElement             = 0x00000027,
    DomConstructorHTMLFrameElement            = 0x00000028,
    DomConstructorHTMLFrameSetElement         = 0x00000029,
    DomConstructorHTMLGenericElement          = 0x0000002a,
    DomConstructorHTMLHeadElement             = 0x0000002b,
    DomConstructorHTMLHeadingElement          = 0x0000002c,
    DomConstructorHTMLHRElement               = 0x0000002d,
    DomConstructorHTMLHtmlElement             = 0x0000002e,
    DomConstructorHTMLIFrameElement           = 0x0000002f,
    DomConstructorHTMLImageElement            = 0x00000030,
    DomConstructorHTMLInputElement            = 0x00000031,
    DomConstructorHTMLIsIndexElement          = 0x00000032,
    DomConstructorHTMLLabelElement            = 0x00000033,
    DomConstructorHTMLLegendElement           = 0x00000034,
    DomConstructorHTMLLIElement               = 0x00000035,
    DomConstructorHTMLLinkElement             = 0x00000036,
    DomConstructorHTMLMapElement              = 0x00000037,
    DomConstructorHTMLMarqueeElement          = 0x00000038,
    DomConstructorHTMLMetaElement             = 0x00000039,
    DomConstructorHTMLModelessDialog          = 0x0000003a,
    DomConstructorHTMLNamespaceInfo           = 0x0000003b,
    DomConstructorHTMLNamespaceInfoCollection = 0x0000003c,
    DomConstructorHTMLNextIdElement           = 0x0000003d,
    DomConstructorHTMLNoShowElement           = 0x0000003e,
    DomConstructorHTMLObjectElement           = 0x0000003f,
    DomConstructorHTMLOListElement            = 0x00000040,
    DomConstructorHTMLOptionElement           = 0x00000041,
    DomConstructorHTMLParagraphElement        = 0x00000042,
    DomConstructorHTMLParamElement            = 0x00000043,
    DomConstructorHTMLPhraseElement           = 0x00000044,
    DomConstructorHTMLPluginsCollection       = 0x00000045,
    DomConstructorHTMLPopup                   = 0x00000046,
    DomConstructorHTMLScriptElement           = 0x00000047,
    DomConstructorHTMLSelectElement           = 0x00000048,
    DomConstructorHTMLSpanElement             = 0x00000049,
    DomConstructorHTMLStyleElement            = 0x0000004a,
    DomConstructorHTMLTableCaptionElement     = 0x0000004b,
    DomConstructorHTMLTableCellElement        = 0x0000004c,
    DomConstructorHTMLTableColElement         = 0x0000004d,
    DomConstructorHTMLTableElement            = 0x0000004e,
    DomConstructorHTMLTableRowElement         = 0x0000004f,
    DomConstructorHTMLTableSectionElement     = 0x00000050,
    DomConstructorHTMLTextAreaElement         = 0x00000051,
    DomConstructorHTMLTextElement             = 0x00000052,
    DomConstructorHTMLTitleElement            = 0x00000053,
    DomConstructorHTMLUListElement            = 0x00000054,
    DomConstructorHTMLUnknownElement          = 0x00000055,
    DomConstructorImage                       = 0x00000056,
    DomConstructorLocation                    = 0x00000057,
    DomConstructorNamedNodeMap                = 0x00000058,
    DomConstructorNavigator                   = 0x00000059,
    DomConstructorNodeList                    = 0x0000005a,
    DomConstructorOption                      = 0x0000005b,
    DomConstructorScreen                      = 0x0000005c,
    DomConstructorSelection                   = 0x0000005d,
    DomConstructorStaticNodeList              = 0x0000005e,
    DomConstructorStorage                     = 0x0000005f,
    DomConstructorStyleSheetList              = 0x00000060,
    DomConstructorStyleSheetPage              = 0x00000061,
    DomConstructorStyleSheetPageList          = 0x00000062,
    DomConstructorText                        = 0x00000063,
    DomConstructorTextRange                   = 0x00000064,
    DomConstructorTextRangeCollection         = 0x00000065,
    DomConstructorTextRectangle               = 0x00000066,
    DomConstructorTextRectangleList           = 0x00000067,
    DomConstructorWindow                      = 0x00000068,
    DomConstructorXDomainRequest              = 0x00000069,
    DomConstructorXMLHttpRequest              = 0x0000006a,
    DomConstructorMax                         = 0x0000006b,
    DomConstructor_Max                        = 0x7fffffff,
}

enum : int
{
    styleTextTransformNotSet     = 0x00000000,
    styleTextTransformCapitalize = 0x00000001,
    styleTextTransformLowercase  = 0x00000002,
    styleTextTransformUppercase  = 0x00000003,
    styleTextTransformNone       = 0x00000004,
    styleTextTransform_Max       = 0x7fffffff,
}
alias styleTextTransform = int;

enum : int
{
    styleDataRepeatNone  = 0x00000000,
    styleDataRepeatInner = 0x00000001,
    styleDataRepeat_Max  = 0x7fffffff,
}
alias styleDataRepeat = int;

enum : int
{
    styleOverflowNotSet  = 0x00000000,
    styleOverflowAuto    = 0x00000001,
    styleOverflowHidden  = 0x00000002,
    styleOverflowVisible = 0x00000003,
    styleOverflowScroll  = 0x00000004,
    styleOverflow_Max    = 0x7fffffff,
}
alias styleOverflow = int;

enum : int
{
    styleMsOverflowStyleNotSet                = 0x00000000,
    styleMsOverflowStyleAuto                  = 0x00000001,
    styleMsOverflowStyleNone                  = 0x00000002,
    styleMsOverflowStyleScrollbar             = 0x00000003,
    styleMsOverflowStyleMsAutoHidingScrollbar = 0x00000004,
    styleMsOverflowStyle_Max                  = 0x7fffffff,
}
alias styleMsOverflowStyle = int;

enum : int
{
    styleTableLayoutNotSet = 0x00000000,
    styleTableLayoutAuto   = 0x00000001,
    styleTableLayoutFixed  = 0x00000002,
    styleTableLayout_Max   = 0x7fffffff,
}
alias styleTableLayout = int;

enum : int
{
    styleBorderCollapseNotSet   = 0x00000000,
    styleBorderCollapseSeparate = 0x00000001,
    styleBorderCollapseCollapse = 0x00000002,
    styleBorderCollapse_Max     = 0x7fffffff,
}
alias styleBorderCollapse = int;

enum : int
{
    styleCaptionSideNotSet = 0x00000000,
    styleCaptionSideTop    = 0x00000001,
    styleCaptionSideBottom = 0x00000002,
    styleCaptionSideLeft   = 0x00000003,
    styleCaptionSideRight  = 0x00000004,
    styleCaptionSide_Max   = 0x7fffffff,
}
alias styleCaptionSide = int;

enum : int
{
    styleEmptyCellsNotSet = 0x00000000,
    styleEmptyCellsShow   = 0x00000001,
    styleEmptyCellsHide   = 0x00000002,
    styleEmptyCells_Max   = 0x7fffffff,
}
alias styleEmptyCells = int;

enum : int
{
    styleFontStyleNotSet  = 0x00000000,
    styleFontStyleItalic  = 0x00000001,
    styleFontStyleOblique = 0x00000002,
    styleFontStyleNormal  = 0x00000003,
    styleFontStyle_Max    = 0x7fffffff,
}
alias styleFontStyle = int;

enum : int
{
    styleFontVariantNotSet    = 0x00000000,
    styleFontVariantSmallCaps = 0x00000001,
    styleFontVariantNormal    = 0x00000002,
    styleFontVariant_Max      = 0x7fffffff,
}
alias styleFontVariant = int;

enum : int
{
    styleBackgroundRepeatRepeat   = 0x00000000,
    styleBackgroundRepeatRepeatX  = 0x00000001,
    styleBackgroundRepeatRepeatY  = 0x00000002,
    styleBackgroundRepeatNoRepeat = 0x00000003,
    styleBackgroundRepeatNotSet   = 0x00000004,
    styleBackgroundRepeat_Max     = 0x7fffffff,
}
alias styleBackgroundRepeat = int;

enum : int
{
    styleBackgroundAttachmentFixed  = 0x00000000,
    styleBackgroundAttachmentScroll = 0x00000001,
    styleBackgroundAttachmentNotSet = 0x00000002,
    styleBackgroundAttachment_Max   = 0x7fffffff,
}
alias styleBackgroundAttachment = int;

enum : int
{
    styleBackgroundAttachment3Fixed  = 0x00000000,
    styleBackgroundAttachment3Scroll = 0x00000001,
    styleBackgroundAttachment3Local  = 0x00000002,
    styleBackgroundAttachment3NotSet = 0x00000003,
    styleBackgroundAttachment3_Max   = 0x7fffffff,
}
alias styleBackgroundAttachment3 = int;

enum : int
{
    styleBackgroundClipBorderBox  = 0x00000000,
    styleBackgroundClipPaddingBox = 0x00000001,
    styleBackgroundClipContentBox = 0x00000002,
    styleBackgroundClipNotSet     = 0x00000003,
    styleBackgroundClip_Max       = 0x7fffffff,
}
alias styleBackgroundClip = int;

enum : int
{
    styleBackgroundOriginBorderBox  = 0x00000000,
    styleBackgroundOriginPaddingBox = 0x00000001,
    styleBackgroundOriginContentBox = 0x00000002,
    styleBackgroundOriginNotSet     = 0x00000003,
    styleBackgroundOrigin_Max       = 0x7fffffff,
}
alias styleBackgroundOrigin = int;

enum : int
{
    styleVerticalAlignAuto       = 0x00000000,
    styleVerticalAlignBaseline   = 0x00000001,
    styleVerticalAlignSub        = 0x00000002,
    styleVerticalAlignSuper      = 0x00000003,
    styleVerticalAlignTop        = 0x00000004,
    styleVerticalAlignTextTop    = 0x00000005,
    styleVerticalAlignMiddle     = 0x00000006,
    styleVerticalAlignBottom     = 0x00000007,
    styleVerticalAlignTextBottom = 0x00000008,
    styleVerticalAlignInherit    = 0x00000009,
    styleVerticalAlignNotSet     = 0x0000000a,
    styleVerticalAlign_Max       = 0x7fffffff,
}
alias styleVerticalAlign = int;

enum : int
{
    styleFontWeightNotSet  = 0x00000000,
    styleFontWeight100     = 0x00000001,
    styleFontWeight200     = 0x00000002,
    styleFontWeight300     = 0x00000003,
    styleFontWeight400     = 0x00000004,
    styleFontWeight500     = 0x00000005,
    styleFontWeight600     = 0x00000006,
    styleFontWeight700     = 0x00000007,
    styleFontWeight800     = 0x00000008,
    styleFontWeight900     = 0x00000009,
    styleFontWeightNormal  = 0x0000000a,
    styleFontWeightBold    = 0x0000000b,
    styleFontWeightBolder  = 0x0000000c,
    styleFontWeightLighter = 0x0000000d,
    styleFontWeight_Max    = 0x7fffffff,
}
alias styleFontWeight = int;

enum : int
{
    styleFontSizeXXSmall = 0x00000000,
    styleFontSizeXSmall  = 0x00000001,
    styleFontSizeSmall   = 0x00000002,
    styleFontSizeMedium  = 0x00000003,
    styleFontSizeLarge   = 0x00000004,
    styleFontSizeXLarge  = 0x00000005,
    styleFontSizeXXLarge = 0x00000006,
    styleFontSizeSmaller = 0x00000007,
    styleFontSizeLarger  = 0x00000008,
    styleFontSize_Max    = 0x7fffffff,
}
alias styleFontSize = int;

enum : int
{
    styleZIndexAuto = 0x80000001,
    styleZIndex_Max = 0x7fffffff,
}
alias styleZIndex = int;

enum : int
{
    styleWidowsOrphansNotSet = 0x80000001,
    styleWidowsOrphans_Max   = 0x7fffffff,
}
alias styleWidowsOrphans = int;

enum : int
{
    styleAutoAuto = 0x00000000,
    styleAuto_Max = 0x7fffffff,
}
alias styleAuto = int;

enum : int
{
    styleNoneNone = 0x00000000,
    styleNone_Max = 0x7fffffff,
}
alias styleNone = int;

enum : int
{
    styleNormalNormal = 0x00000000,
    styleNormal_Max   = 0x7fffffff,
}
alias styleNormal = int;

enum : int
{
    styleBorderWidthThin   = 0x00000000,
    styleBorderWidthMedium = 0x00000001,
    styleBorderWidthThick  = 0x00000002,
    styleBorderWidth_Max   = 0x7fffffff,
}
alias styleBorderWidth = int;

enum : int
{
    stylePositionNotSet        = 0x00000000,
    stylePositionstatic        = 0x00000001,
    stylePositionrelative      = 0x00000002,
    stylePositionabsolute      = 0x00000003,
    stylePositionfixed         = 0x00000004,
    stylePositionMsPage        = 0x00000005,
    stylePositionMsDeviceFixed = 0x00000006,
    stylePosition_Max          = 0x7fffffff,
}
alias stylePosition = int;

enum : int
{
    styleBorderStyleNotSet      = 0x00000000,
    styleBorderStyleDotted      = 0x00000001,
    styleBorderStyleDashed      = 0x00000002,
    styleBorderStyleSolid       = 0x00000003,
    styleBorderStyleDouble      = 0x00000004,
    styleBorderStyleGroove      = 0x00000005,
    styleBorderStyleRidge       = 0x00000006,
    styleBorderStyleInset       = 0x00000007,
    styleBorderStyleOutset      = 0x00000008,
    styleBorderStyleWindowInset = 0x00000009,
    styleBorderStyleNone        = 0x0000000a,
    styleBorderStyleHidden      = 0x0000000b,
    styleBorderStyle_Max        = 0x7fffffff,
}
alias styleBorderStyle = int;

enum : int
{
    styleOutlineStyleNotSet      = 0x00000000,
    styleOutlineStyleDotted      = 0x00000001,
    styleOutlineStyleDashed      = 0x00000002,
    styleOutlineStyleSolid       = 0x00000003,
    styleOutlineStyleDouble      = 0x00000004,
    styleOutlineStyleGroove      = 0x00000005,
    styleOutlineStyleRidge       = 0x00000006,
    styleOutlineStyleInset       = 0x00000007,
    styleOutlineStyleOutset      = 0x00000008,
    styleOutlineStyleWindowInset = 0x00000009,
    styleOutlineStyleNone        = 0x0000000a,
    styleOutlineStyle_Max        = 0x7fffffff,
}
alias styleOutlineStyle = int;

enum : int
{
    styleStyleFloatNotSet = 0x00000000,
    styleStyleFloatLeft   = 0x00000001,
    styleStyleFloatRight  = 0x00000002,
    styleStyleFloatNone   = 0x00000003,
    styleStyleFloat_Max   = 0x7fffffff,
}
alias styleStyleFloat = int;

enum : int
{
    styleDisplayNotSet            = 0x00000000,
    styleDisplayBlock             = 0x00000001,
    styleDisplayInline            = 0x00000002,
    styleDisplayListItem          = 0x00000003,
    styleDisplayNone              = 0x00000004,
    styleDisplayTableHeaderGroup  = 0x00000005,
    styleDisplayTableFooterGroup  = 0x00000006,
    styleDisplayInlineBlock       = 0x00000007,
    styleDisplayTable             = 0x00000008,
    styleDisplayInlineTable       = 0x00000009,
    styleDisplayTableRow          = 0x0000000a,
    styleDisplayTableRowGroup     = 0x0000000b,
    styleDisplayTableColumn       = 0x0000000c,
    styleDisplayTableColumnGroup  = 0x0000000d,
    styleDisplayTableCell         = 0x0000000e,
    styleDisplayTableCaption      = 0x0000000f,
    styleDisplayRunIn             = 0x00000010,
    styleDisplayRuby              = 0x00000011,
    styleDisplayRubyBase          = 0x00000012,
    styleDisplayRubyText          = 0x00000013,
    styleDisplayRubyBaseContainer = 0x00000014,
    styleDisplayRubyTextContainer = 0x00000015,
    styleDisplayMsFlexbox         = 0x00000016,
    styleDisplayMsInlineFlexbox   = 0x00000017,
    styleDisplayMsGrid            = 0x00000018,
    styleDisplayMsInlineGrid      = 0x00000019,
    styleDisplayFlex              = 0x0000001a,
    styleDisplayInlineFlex        = 0x0000001b,
    styleDisplayWebkitBox         = 0x0000001c,
    styleDisplayWebkitInlineBox   = 0x0000001d,
    styleDisplay_Max              = 0x7fffffff,
}
alias styleDisplay = int;

enum : int
{
    styleVisibilityNotSet   = 0x00000000,
    styleVisibilityInherit  = 0x00000001,
    styleVisibilityVisible  = 0x00000002,
    styleVisibilityHidden   = 0x00000003,
    styleVisibilityCollapse = 0x00000004,
    styleVisibility_Max     = 0x7fffffff,
}
alias styleVisibility = int;

enum : int
{
    styleListStyleTypeNotSet             = 0x00000000,
    styleListStyleTypeDisc               = 0x00000001,
    styleListStyleTypeCircle             = 0x00000002,
    styleListStyleTypeSquare             = 0x00000003,
    styleListStyleTypeDecimal            = 0x00000004,
    styleListStyleTypeLowerRoman         = 0x00000005,
    styleListStyleTypeUpperRoman         = 0x00000006,
    styleListStyleTypeLowerAlpha         = 0x00000007,
    styleListStyleTypeUpperAlpha         = 0x00000008,
    styleListStyleTypeNone               = 0x00000009,
    styleListStyleTypeDecimalLeadingZero = 0x0000000a,
    styleListStyleTypeGeorgian           = 0x0000000b,
    styleListStyleTypeArmenian           = 0x0000000c,
    styleListStyleTypeUpperLatin         = 0x0000000d,
    styleListStyleTypeLowerLatin         = 0x0000000e,
    styleListStyleTypeUpperGreek         = 0x0000000f,
    styleListStyleTypeLowerGreek         = 0x00000010,
    styleListStyleType_Max               = 0x7fffffff,
}
alias styleListStyleType = int;

enum : int
{
    styleListStylePositionNotSet  = 0x00000000,
    styleListStylePositionInside  = 0x00000001,
    styleListStylePositionOutSide = 0x00000002,
    styleListStylePosition_Max    = 0x7fffffff,
}
alias styleListStylePosition = int;

enum : int
{
    styleWhiteSpaceNotSet  = 0x00000000,
    styleWhiteSpaceNormal  = 0x00000001,
    styleWhiteSpacePre     = 0x00000002,
    styleWhiteSpaceNowrap  = 0x00000003,
    styleWhiteSpacePreline = 0x00000004,
    styleWhiteSpacePrewrap = 0x00000005,
    styleWhiteSpace_Max    = 0x7fffffff,
}
alias styleWhiteSpace = int;

enum : int
{
    stylePageBreakNotSet = 0x00000000,
    stylePageBreakAuto   = 0x00000001,
    stylePageBreakAlways = 0x00000002,
    stylePageBreakLeft   = 0x00000003,
    stylePageBreakRight  = 0x00000004,
    stylePageBreakAvoid  = 0x00000005,
    stylePageBreak_Max   = 0x7fffffff,
}
alias stylePageBreak = int;

enum : int
{
    stylePageBreakInsideNotSet = 0x00000000,
    stylePageBreakInsideAuto   = 0x00000001,
    stylePageBreakInsideAvoid  = 0x00000002,
    stylePageBreakInside_Max   = 0x7fffffff,
}
alias stylePageBreakInside = int;

enum : int
{
    styleCursorAuto          = 0x00000000,
    styleCursorCrosshair     = 0x00000001,
    styleCursorDefault       = 0x00000002,
    styleCursorHand          = 0x00000003,
    styleCursorMove          = 0x00000004,
    styleCursorE_resize      = 0x00000005,
    styleCursorNe_resize     = 0x00000006,
    styleCursorNw_resize     = 0x00000007,
    styleCursorN_resize      = 0x00000008,
    styleCursorSe_resize     = 0x00000009,
    styleCursorSw_resize     = 0x0000000a,
    styleCursorS_resize      = 0x0000000b,
    styleCursorW_resize      = 0x0000000c,
    styleCursorText          = 0x0000000d,
    styleCursorWait          = 0x0000000e,
    styleCursorHelp          = 0x0000000f,
    styleCursorPointer       = 0x00000010,
    styleCursorProgress      = 0x00000011,
    styleCursorNot_allowed   = 0x00000012,
    styleCursorNo_drop       = 0x00000013,
    styleCursorVertical_text = 0x00000014,
    styleCursorall_scroll    = 0x00000015,
    styleCursorcol_resize    = 0x00000016,
    styleCursorrow_resize    = 0x00000017,
    styleCursorNone          = 0x00000018,
    styleCursorContext_menu  = 0x00000019,
    styleCursorEw_resize     = 0x0000001a,
    styleCursorNs_resize     = 0x0000001b,
    styleCursorNesw_resize   = 0x0000001c,
    styleCursorNwse_resize   = 0x0000001d,
    styleCursorCell          = 0x0000001e,
    styleCursorCopy          = 0x0000001f,
    styleCursorAlias         = 0x00000020,
    styleCursorcustom        = 0x00000021,
    styleCursorNotSet        = 0x00000022,
    styleCursor_Max          = 0x7fffffff,
}
alias styleCursor = int;

enum : int
{
    styleDirNotSet      = 0x00000000,
    styleDirLeftToRight = 0x00000001,
    styleDirRightToLeft = 0x00000002,
    styleDirInherit     = 0x00000003,
    styleDir_Max        = 0x7fffffff,
}
alias styleDir = int;

enum : int
{
    styleBidiNotSet   = 0x00000000,
    styleBidiNormal   = 0x00000001,
    styleBidiEmbed    = 0x00000002,
    styleBidiOverride = 0x00000003,
    styleBidiInherit  = 0x00000004,
    styleBidi_Max     = 0x7fffffff,
}
alias styleBidi = int;

enum : int
{
    styleImeModeAuto     = 0x00000000,
    styleImeModeActive   = 0x00000001,
    styleImeModeInactive = 0x00000002,
    styleImeModeDisabled = 0x00000003,
    styleImeModeNotSet   = 0x00000004,
    styleImeMode_Max     = 0x7fffffff,
}
alias styleImeMode = int;

enum : int
{
    styleRubyAlignNotSet           = 0x00000000,
    styleRubyAlignAuto             = 0x00000001,
    styleRubyAlignLeft             = 0x00000002,
    styleRubyAlignCenter           = 0x00000003,
    styleRubyAlignRight            = 0x00000004,
    styleRubyAlignDistributeLetter = 0x00000005,
    styleRubyAlignDistributeSpace  = 0x00000006,
    styleRubyAlignLineEdge         = 0x00000007,
    styleRubyAlign_Max             = 0x7fffffff,
}
alias styleRubyAlign = int;

enum : int
{
    styleRubyPositionNotSet = 0x00000000,
    styleRubyPositionAbove  = 0x00000001,
    styleRubyPositionInline = 0x00000002,
    styleRubyPosition_Max   = 0x7fffffff,
}
alias styleRubyPosition = int;

enum : int
{
    styleRubyOverhangNotSet     = 0x00000000,
    styleRubyOverhangAuto       = 0x00000001,
    styleRubyOverhangWhitespace = 0x00000002,
    styleRubyOverhangNone       = 0x00000003,
    styleRubyOverhang_Max       = 0x7fffffff,
}
alias styleRubyOverhang = int;

enum : int
{
    styleLayoutGridCharNotSet = 0x00000000,
    styleLayoutGridCharAuto   = 0x00000001,
    styleLayoutGridCharNone   = 0x00000002,
    styleLayoutGridChar_Max   = 0x7fffffff,
}
alias styleLayoutGridChar = int;

enum : int
{
    styleLayoutGridLineNotSet = 0x00000000,
    styleLayoutGridLineAuto   = 0x00000001,
    styleLayoutGridLineNone   = 0x00000002,
    styleLayoutGridLine_Max   = 0x7fffffff,
}
alias styleLayoutGridLine = int;

enum : int
{
    styleLayoutGridModeNotSet = 0x00000000,
    styleLayoutGridModeChar   = 0x00000001,
    styleLayoutGridModeLine   = 0x00000002,
    styleLayoutGridModeBoth   = 0x00000003,
    styleLayoutGridModeNone   = 0x00000004,
    styleLayoutGridMode_Max   = 0x7fffffff,
}
alias styleLayoutGridMode = int;

enum : int
{
    styleLayoutGridTypeNotSet = 0x00000000,
    styleLayoutGridTypeLoose  = 0x00000001,
    styleLayoutGridTypeStrict = 0x00000002,
    styleLayoutGridTypeFixed  = 0x00000003,
    styleLayoutGridType_Max   = 0x7fffffff,
}
alias styleLayoutGridType = int;

enum : int
{
    styleLineBreakNotSet = 0x00000000,
    styleLineBreakNormal = 0x00000001,
    styleLineBreakStrict = 0x00000002,
    styleLineBreak_Max   = 0x7fffffff,
}
alias styleLineBreak = int;

enum : int
{
    styleWordBreakNotSet   = 0x00000000,
    styleWordBreakNormal   = 0x00000001,
    styleWordBreakBreakAll = 0x00000002,
    styleWordBreakKeepAll  = 0x00000003,
    styleWordBreak_Max     = 0x7fffffff,
}
alias styleWordBreak = int;

enum : int
{
    styleWordWrapNotSet = 0x00000000,
    styleWordWrapOff    = 0x00000001,
    styleWordWrapOn     = 0x00000002,
    styleWordWrap_Max   = 0x7fffffff,
}
alias styleWordWrap = int;

enum : int
{
    styleTextJustifyNotSet             = 0x00000000,
    styleTextJustifyInterWord          = 0x00000001,
    styleTextJustifyNewspaper          = 0x00000002,
    styleTextJustifyDistribute         = 0x00000003,
    styleTextJustifyDistributeAllLines = 0x00000004,
    styleTextJustifyInterIdeograph     = 0x00000005,
    styleTextJustifyInterCluster       = 0x00000006,
    styleTextJustifyKashida            = 0x00000007,
    styleTextJustifyAuto               = 0x00000008,
    styleTextJustify_Max               = 0x7fffffff,
}
alias styleTextJustify = int;

enum : int
{
    styleTextAlignLastNotSet  = 0x00000000,
    styleTextAlignLastLeft    = 0x00000001,
    styleTextAlignLastCenter  = 0x00000002,
    styleTextAlignLastRight   = 0x00000003,
    styleTextAlignLastJustify = 0x00000004,
    styleTextAlignLastAuto    = 0x00000005,
    styleTextAlignLast_Max    = 0x7fffffff,
}
alias styleTextAlignLast = int;

enum : int
{
    styleTextJustifyTrimNotSet       = 0x00000000,
    styleTextJustifyTrimNone         = 0x00000001,
    styleTextJustifyTrimPunctuation  = 0x00000002,
    styleTextJustifyTrimPunctAndKana = 0x00000003,
    styleTextJustifyTrim_Max         = 0x7fffffff,
}
alias styleTextJustifyTrim = int;

enum : int
{
    styleAcceleratorFalse = 0x00000000,
    styleAcceleratorTrue  = 0x00000001,
    styleAccelerator_Max  = 0x7fffffff,
}
alias styleAccelerator = int;

enum : int
{
    styleLayoutFlowHorizontal          = 0x00000000,
    styleLayoutFlowVerticalIdeographic = 0x00000001,
    styleLayoutFlowNotSet              = 0x00000002,
    styleLayoutFlow_Max                = 0x7fffffff,
}
alias styleLayoutFlow = int;

enum : int
{
    styleBlockProgressionTb     = 0x00000000,
    styleBlockProgressionRl     = 0x00000001,
    styleBlockProgressionBt     = 0x00000002,
    styleBlockProgressionLr     = 0x00000003,
    styleBlockProgressionNotSet = 0x00000004,
    styleBlockProgression_Max   = 0x7fffffff,
}
alias styleBlockProgression = int;

enum : int
{
    styleWritingModeLrtb   = 0x00000000,
    styleWritingModeTbrl   = 0x00000001,
    styleWritingModeRltb   = 0x00000002,
    styleWritingModeBtrl   = 0x00000003,
    styleWritingModeNotSet = 0x00000004,
    styleWritingModeTblr   = 0x00000005,
    styleWritingModeBtlr   = 0x00000006,
    styleWritingModeLrbt   = 0x00000007,
    styleWritingModeRlbt   = 0x00000008,
    styleWritingModeLr     = 0x00000009,
    styleWritingModeRl     = 0x0000000a,
    styleWritingModeTb     = 0x0000000b,
    styleWritingMode_Max   = 0x7fffffff,
}
alias styleWritingMode = int;

enum : int
{
    styleBoolFalse = 0x00000000,
    styleBoolTrue  = 0x00000001,
    styleBool_Max  = 0x7fffffff,
}
alias styleBool = int;

enum : int
{
    styleTextUnderlinePositionBelow  = 0x00000000,
    styleTextUnderlinePositionAbove  = 0x00000001,
    styleTextUnderlinePositionAuto   = 0x00000002,
    styleTextUnderlinePositionNotSet = 0x00000003,
    styleTextUnderlinePosition_Max   = 0x7fffffff,
}
alias styleTextUnderlinePosition = int;

enum : int
{
    styleTextOverflowClip     = 0x00000000,
    styleTextOverflowEllipsis = 0x00000001,
    styleTextOverflowNotSet   = 0x00000002,
    styleTextOverflow_Max     = 0x7fffffff,
}
alias styleTextOverflow = int;

enum : int
{
    styleInterpolationNotSet = 0x00000000,
    styleInterpolationNN     = 0x00000001,
    styleInterpolationBCH    = 0x00000002,
    styleInterpolation_Max   = 0x7fffffff,
}
alias styleInterpolation = int;

enum : int
{
    styleBoxSizingNotSet     = 0x00000000,
    styleBoxSizingContentBox = 0x00000001,
    styleBoxSizingBorderBox  = 0x00000002,
    styleBoxSizing_Max       = 0x7fffffff,
}
alias styleBoxSizing = int;

enum : int
{
    styleFlexNone   = 0x00000000,
    styleFlexNotSet = 0x00000001,
    styleFlex_Max   = 0x7fffffff,
}
alias styleFlex = int;

enum : int
{
    styleFlexBasisAuto   = 0x00000000,
    styleFlexBasisNotSet = 0x00000001,
    styleFlexBasis_Max   = 0x7fffffff,
}
alias styleFlexBasis = int;

enum : int
{
    styleFlexDirectionRow           = 0x00000000,
    styleFlexDirectionRowReverse    = 0x00000001,
    styleFlexDirectionColumn        = 0x00000002,
    styleFlexDirectionColumnReverse = 0x00000003,
    styleFlexDirectionNotSet        = 0x00000004,
    styleFlexDirection_Max          = 0x7fffffff,
}
alias styleFlexDirection = int;

enum : int
{
    styleWebkitBoxOrientHorizontal = 0x00000000,
    styleWebkitBoxOrientInlineAxis = 0x00000001,
    styleWebkitBoxOrientVertical   = 0x00000002,
    styleWebkitBoxOrientBlockAxis  = 0x00000003,
    styleWebkitBoxOrientNotSet     = 0x00000004,
    styleWebkitBoxOrient_Max       = 0x7fffffff,
}
alias styleWebkitBoxOrient = int;

enum : int
{
    styleWebkitBoxDirectionNormal  = 0x00000000,
    styleWebkitBoxDirectionReverse = 0x00000001,
    styleWebkitBoxDirectionNotSet  = 0x00000002,
    styleWebkitBoxDirection_Max    = 0x7fffffff,
}
alias styleWebkitBoxDirection = int;

enum : int
{
    styleFlexWrapNowrap      = 0x00000000,
    styleFlexWrapWrap        = 0x00000001,
    styleFlexWrapWrapReverse = 0x00000002,
    styleFlexWrapNotSet      = 0x00000003,
    styleFlexWrap_Max        = 0x7fffffff,
}
alias styleFlexWrap = int;

enum : int
{
    styleAlignItemsFlexStart = 0x00000000,
    styleAlignItemsFlexEnd   = 0x00000001,
    styleAlignItemsCenter    = 0x00000002,
    styleAlignItemsBaseline  = 0x00000003,
    styleAlignItemsStretch   = 0x00000004,
    styleAlignItemsNotSet    = 0x00000005,
    styleAlignItems_Max      = 0x7fffffff,
}
alias styleAlignItems = int;

enum : int
{
    styleMsFlexAlignStart    = 0x00000000,
    styleMsFlexAlignEnd      = 0x00000001,
    styleMsFlexAlignCenter   = 0x00000002,
    styleMsFlexAlignBaseline = 0x00000003,
    styleMsFlexAlignStretch  = 0x00000004,
    styleMsFlexAlignNotSet   = 0x00000005,
    styleMsFlexAlign_Max     = 0x7fffffff,
}
alias styleMsFlexAlign = int;

enum : int
{
    styleMsFlexItemAlignStart    = 0x00000000,
    styleMsFlexItemAlignEnd      = 0x00000001,
    styleMsFlexItemAlignCenter   = 0x00000002,
    styleMsFlexItemAlignBaseline = 0x00000003,
    styleMsFlexItemAlignStretch  = 0x00000004,
    styleMsFlexItemAlignAuto     = 0x00000005,
    styleMsFlexItemAlignNotSet   = 0x00000006,
    styleMsFlexItemAlign_Max     = 0x7fffffff,
}
alias styleMsFlexItemAlign = int;

enum : int
{
    styleAlignSelfFlexStart = 0x00000000,
    styleAlignSelfFlexEnd   = 0x00000001,
    styleAlignSelfCenter    = 0x00000002,
    styleAlignSelfBaseline  = 0x00000003,
    styleAlignSelfStretch   = 0x00000004,
    styleAlignSelfAuto      = 0x00000005,
    styleAlignSelfNotSet    = 0x00000006,
    styleAlignSelf_Max      = 0x7fffffff,
}
alias styleAlignSelf = int;

enum : int
{
    styleJustifyContentFlexStart    = 0x00000000,
    styleJustifyContentFlexEnd      = 0x00000001,
    styleJustifyContentCenter       = 0x00000002,
    styleJustifyContentSpaceBetween = 0x00000003,
    styleJustifyContentSpaceAround  = 0x00000004,
    styleJustifyContentNotSet       = 0x00000005,
    styleJustifyContent_Max         = 0x7fffffff,
}
alias styleJustifyContent = int;

enum : int
{
    styleMsFlexPackStart      = 0x00000000,
    styleMsFlexPackEnd        = 0x00000001,
    styleMsFlexPackCenter     = 0x00000002,
    styleMsFlexPackJustify    = 0x00000003,
    styleMsFlexPackDistribute = 0x00000004,
    styleMsFlexPackNotSet     = 0x00000005,
    styleMsFlexPack_Max       = 0x7fffffff,
}
alias styleMsFlexPack = int;

enum : int
{
    styleWebkitBoxPackStart   = 0x00000000,
    styleWebkitBoxPackEnd     = 0x00000001,
    styleWebkitBoxPackCenter  = 0x00000002,
    styleWebkitBoxPackJustify = 0x00000003,
    styleWebkitBoxPackNotSet  = 0x00000005,
    styleWebkitBoxPack_Max    = 0x7fffffff,
}
alias styleWebkitBoxPack = int;

enum : int
{
    styleMsFlexLinePackStart      = 0x00000000,
    styleMsFlexLinePackEnd        = 0x00000001,
    styleMsFlexLinePackCenter     = 0x00000002,
    styleMsFlexLinePackJustify    = 0x00000003,
    styleMsFlexLinePackDistribute = 0x00000004,
    styleMsFlexLinePackStretch    = 0x00000005,
    styleMsFlexLinePackNotSet     = 0x00000006,
    styleMsFlexLinePack_Max       = 0x7fffffff,
}
alias styleMsFlexLinePack = int;

enum : int
{
    styleAlignContentFlexStart    = 0x00000000,
    styleAlignContentFlexEnd      = 0x00000001,
    styleAlignContentCenter       = 0x00000002,
    styleAlignContentSpaceBetween = 0x00000003,
    styleAlignContentSpaceAround  = 0x00000004,
    styleAlignContentStretch      = 0x00000005,
    styleAlignContentNotSet       = 0x00000006,
    styleAlignContent_Max         = 0x7fffffff,
}
alias styleAlignContent = int;

enum : int
{
    styleColumnFillAuto    = 0x00000000,
    styleColumnFillBalance = 0x00000001,
    styleColumnFillNotSet  = 0x00000002,
    styleColumnFill_Max    = 0x7fffffff,
}
alias styleColumnFill = int;

enum : int
{
    styleColumnSpanNone   = 0x00000000,
    styleColumnSpanAll    = 0x00000001,
    styleColumnSpanOne    = 0x00000002,
    styleColumnSpanNotSet = 0x00000003,
    styleColumnSpan_Max   = 0x7fffffff,
}
alias styleColumnSpan = int;

enum : int
{
    styleBreakNotSet      = 0x00000000,
    styleBreakAuto        = 0x00000001,
    styleBreakAlways      = 0x00000002,
    styleBreakAvoid       = 0x00000003,
    styleBreakLeft        = 0x00000004,
    styleBreakRight       = 0x00000005,
    styleBreakPage        = 0x00000006,
    styleBreakColumn      = 0x00000007,
    styleBreakAvoidPage   = 0x00000008,
    styleBreakAvoidColumn = 0x00000009,
    styleBreak_Max        = 0x7fffffff,
}
alias styleBreak = int;

enum : int
{
    styleBreakInsideNotSet      = 0x00000000,
    styleBreakInsideAuto        = 0x00000001,
    styleBreakInsideAvoid       = 0x00000002,
    styleBreakInsideAvoidPage   = 0x00000003,
    styleBreakInsideAvoidColumn = 0x00000004,
    styleBreakInside_Max        = 0x7fffffff,
}
alias styleBreakInside = int;

enum : int
{
    styleMsScrollChainingNotSet  = 0x00000000,
    styleMsScrollChainingNone    = 0x00000001,
    styleMsScrollChainingChained = 0x00000002,
    styleMsScrollChaining_Max    = 0x7fffffff,
}
alias styleMsScrollChaining = int;

enum : int
{
    styleMsContentZoomingNotSet = 0x00000000,
    styleMsContentZoomingNone   = 0x00000001,
    styleMsContentZoomingZoom   = 0x00000002,
    styleMsContentZooming_Max   = 0x7fffffff,
}
alias styleMsContentZooming = int;

enum : int
{
    styleMsContentZoomSnapTypeNotSet    = 0x00000000,
    styleMsContentZoomSnapTypeNone      = 0x00000001,
    styleMsContentZoomSnapTypeMandatory = 0x00000002,
    styleMsContentZoomSnapTypeProximity = 0x00000003,
    styleMsContentZoomSnapType_Max      = 0x7fffffff,
}
alias styleMsContentZoomSnapType = int;

enum : int
{
    styleMsScrollRailsNotSet = 0x00000000,
    styleMsScrollRailsNone   = 0x00000001,
    styleMsScrollRailsRailed = 0x00000002,
    styleMsScrollRails_Max   = 0x7fffffff,
}
alias styleMsScrollRails = int;

enum : int
{
    styleMsContentZoomChainingNotSet  = 0x00000000,
    styleMsContentZoomChainingNone    = 0x00000001,
    styleMsContentZoomChainingChained = 0x00000002,
    styleMsContentZoomChaining_Max    = 0x7fffffff,
}
alias styleMsContentZoomChaining = int;

enum : int
{
    styleMsScrollSnapTypeNotSet    = 0x00000000,
    styleMsScrollSnapTypeNone      = 0x00000001,
    styleMsScrollSnapTypeMandatory = 0x00000002,
    styleMsScrollSnapTypeProximity = 0x00000003,
    styleMsScrollSnapType_Max      = 0x7fffffff,
}
alias styleMsScrollSnapType = int;

enum : int
{
    styleGridColumnNotSet = 0x00000000,
    styleGridColumn_Max   = 0x7fffffff,
}
alias styleGridColumn = int;

enum : int
{
    styleGridColumnAlignCenter  = 0x00000000,
    styleGridColumnAlignEnd     = 0x00000001,
    styleGridColumnAlignStart   = 0x00000002,
    styleGridColumnAlignStretch = 0x00000003,
    styleGridColumnAlignNotSet  = 0x00000004,
    styleGridColumnAlign_Max    = 0x7fffffff,
}
alias styleGridColumnAlign = int;

enum : int
{
    styleGridColumnSpanNotSet = 0x00000000,
    styleGridColumnSpan_Max   = 0x7fffffff,
}
alias styleGridColumnSpan = int;

enum : int
{
    styleGridRowNotSet = 0x00000000,
    styleGridRow_Max   = 0x7fffffff,
}
alias styleGridRow = int;

enum : int
{
    styleGridRowAlignCenter  = 0x00000000,
    styleGridRowAlignEnd     = 0x00000001,
    styleGridRowAlignStart   = 0x00000002,
    styleGridRowAlignStretch = 0x00000003,
    styleGridRowAlignNotSet  = 0x00000004,
    styleGridRowAlign_Max    = 0x7fffffff,
}
alias styleGridRowAlign = int;

enum : int
{
    styleGridRowSpanNotSet = 0x00000000,
    styleGridRowSpan_Max   = 0x7fffffff,
}
alias styleGridRowSpan = int;

enum : int
{
    styleWrapThroughNotSet = 0x00000000,
    styleWrapThroughWrap   = 0x00000001,
    styleWrapThroughNone   = 0x00000002,
    styleWrapThrough_Max   = 0x7fffffff,
}
alias styleWrapThrough = int;

enum : int
{
    styleWrapFlowNotSet  = 0x00000000,
    styleWrapFlowAuto    = 0x00000001,
    styleWrapFlowBoth    = 0x00000002,
    styleWrapFlowStart   = 0x00000003,
    styleWrapFlowEnd     = 0x00000004,
    styleWrapFlowClear   = 0x00000005,
    styleWrapFlowMinimum = 0x00000006,
    styleWrapFlowMaximum = 0x00000007,
    styleWrapFlow_Max    = 0x7fffffff,
}
alias styleWrapFlow = int;

enum : int
{
    styleAlignmentBaselineNotSet         = 0x00000000,
    styleAlignmentBaselineAfterEdge      = 0x00000001,
    styleAlignmentBaselineAlphabetic     = 0x00000002,
    styleAlignmentBaselineAuto           = 0x00000003,
    styleAlignmentBaselineBaseline       = 0x00000004,
    styleAlignmentBaselineBeforeEdge     = 0x00000005,
    styleAlignmentBaselineCentral        = 0x00000006,
    styleAlignmentBaselineHanging        = 0x00000007,
    styleAlignmentBaselineMathematical   = 0x00000008,
    styleAlignmentBaselineMiddle         = 0x00000009,
    styleAlignmentBaselineTextAfterEdge  = 0x0000000a,
    styleAlignmentBaselineTextBeforeEdge = 0x0000000b,
    styleAlignmentBaselineIdeographic    = 0x0000000c,
    styleAlignmentBaseline_Max           = 0x7fffffff,
}
alias styleAlignmentBaseline = int;

enum : int
{
    styleBaselineShiftBaseline = 0x00000000,
    styleBaselineShiftSub      = 0x00000001,
    styleBaselineShiftSuper    = 0x00000002,
    styleBaselineShift_Max     = 0x7fffffff,
}
alias styleBaselineShift = int;

enum : int
{
    styleClipRuleNotSet  = 0x00000000,
    styleClipRuleNonZero = 0x00000001,
    styleClipRuleEvenOdd = 0x00000002,
    styleClipRule_Max    = 0x7fffffff,
}
alias styleClipRule = int;

enum : int
{
    styleDominantBaselineNotSet         = 0x00000000,
    styleDominantBaselineAlphabetic     = 0x00000001,
    styleDominantBaselineAuto           = 0x00000002,
    styleDominantBaselineCentral        = 0x00000003,
    styleDominantBaselineHanging        = 0x00000004,
    styleDominantBaselineIdeographic    = 0x00000005,
    styleDominantBaselineMathematical   = 0x00000006,
    styleDominantBaselineMiddle         = 0x00000007,
    styleDominantBaselineNoChange       = 0x00000008,
    styleDominantBaselineResetSize      = 0x00000009,
    styleDominantBaselineTextAfterEdge  = 0x0000000a,
    styleDominantBaselineTextBeforeEdge = 0x0000000b,
    styleDominantBaselineUseScript      = 0x0000000c,
    styleDominantBaseline_Max           = 0x7fffffff,
}
alias styleDominantBaseline = int;

enum : int
{
    styleFillRuleNotSet  = 0x00000000,
    styleFillRuleNonZero = 0x00000001,
    styleFillRuleEvenOdd = 0x00000002,
    styleFillRule_Max    = 0x7fffffff,
}
alias styleFillRule = int;

enum : int
{
    styleFontStretchNotSet         = 0x00000000,
    styleFontStretchWider          = 0x00000001,
    styleFontStretchNarrower       = 0x00000002,
    styleFontStretchUltraCondensed = 0x00000003,
    styleFontStretchExtraCondensed = 0x00000004,
    styleFontStretchCondensed      = 0x00000005,
    styleFontStretchSemiCondensed  = 0x00000006,
    styleFontStretchNormal         = 0x00000007,
    styleFontStretchSemiExpanded   = 0x00000008,
    styleFontStretchExpanded       = 0x00000009,
    styleFontStretchExtraExpanded  = 0x0000000a,
    styleFontStretchUltraExpanded  = 0x0000000b,
    styleFontStretch_Max           = 0x7fffffff,
}
alias styleFontStretch = int;

enum : int
{
    stylePointerEventsNotSet         = 0x00000000,
    stylePointerEventsVisiblePainted = 0x00000001,
    stylePointerEventsVisibleFill    = 0x00000002,
    stylePointerEventsVisibleStroke  = 0x00000003,
    stylePointerEventsVisible        = 0x00000004,
    stylePointerEventsPainted        = 0x00000005,
    stylePointerEventsFill           = 0x00000006,
    stylePointerEventsStroke         = 0x00000007,
    stylePointerEventsAll            = 0x00000008,
    stylePointerEventsNone           = 0x00000009,
    stylePointerEventsInitial        = 0x0000000a,
    stylePointerEventsAuto           = 0x0000000b,
    stylePointerEvents_Max           = 0x7fffffff,
}
alias stylePointerEvents = int;

enum : int
{
    styleEnableBackgroundNotSet     = 0x00000000,
    styleEnableBackgroundAccumulate = 0x00000001,
    styleEnableBackgroundNew        = 0x00000002,
    styleEnableBackgroundInherit    = 0x00000003,
    styleEnableBackground_Max       = 0x7fffffff,
}
alias styleEnableBackground = int;

enum : int
{
    styleStrokeLinecapNotSet = 0x00000000,
    styleStrokeLinecapButt   = 0x00000001,
    styleStrokeLinecapRound  = 0x00000002,
    styleStrokeLinecapSquare = 0x00000003,
    styleStrokeLinecap_Max   = 0x7fffffff,
}
alias styleStrokeLinecap = int;

enum : int
{
    styleStrokeLinejoinNotSet = 0x00000000,
    styleStrokeLinejoinMiter  = 0x00000001,
    styleStrokeLinejoinRound  = 0x00000002,
    styleStrokeLinejoinBevel  = 0x00000003,
    styleStrokeLinejoin_Max   = 0x7fffffff,
}
alias styleStrokeLinejoin = int;

enum : int
{
    styleTextAnchorNotSet = 0x00000000,
    styleTextAnchorStart  = 0x00000001,
    styleTextAnchorMiddle = 0x00000002,
    styleTextAnchorEnd    = 0x00000003,
    styleTextAnchor_Max   = 0x7fffffff,
}
alias styleTextAnchor = int;

enum : int
{
    styleAttrTypeString     = 0x00000000,
    styleAttrTypeColor      = 0x00000001,
    styleAttrTypeUrl        = 0x00000002,
    styleAttrTypeInteger    = 0x00000003,
    styleAttrTypeNumber     = 0x00000004,
    styleAttrTypeLength     = 0x00000005,
    styleAttrTypePx         = 0x00000006,
    styleAttrTypeEm         = 0x00000007,
    styleAttrTypeEx         = 0x00000008,
    styleAttrTypeIn         = 0x00000009,
    styleAttrTypeCm         = 0x0000000a,
    styleAttrTypeMm         = 0x0000000b,
    styleAttrTypePt         = 0x0000000c,
    styleAttrTypePc         = 0x0000000d,
    styleAttrTypeRem        = 0x0000000e,
    styleAttrTypeCh         = 0x0000000f,
    styleAttrTypeVh         = 0x00000010,
    styleAttrTypeVw         = 0x00000011,
    styleAttrTypeVmin       = 0x00000012,
    styleAttrTypePercentage = 0x00000013,
    styleAttrTypeAngle      = 0x00000014,
    styleAttrTypeDeg        = 0x00000015,
    styleAttrTypeRad        = 0x00000016,
    styleAttrTypeGrad       = 0x00000017,
    styleAttrTypeTime       = 0x00000018,
    styleAttrTypeS          = 0x00000019,
    styleAttrTypeMs         = 0x0000001a,
    styleAttrType_Max       = 0x7fffffff,
}
alias styleAttrType = int;

enum : int
{
    styleInitialColorNoInitial     = 0x00000000,
    styleInitialColorColorProperty = 0x00000001,
    styleInitialColorTransparent   = 0x00000002,
    styleInitialColorInvert        = 0x00000003,
    styleInitialColor_Max          = 0x7fffffff,
}
alias styleInitialColor = int;

enum : int
{
    styleInitialStringNoInitial = 0x00000000,
    styleInitialStringNone      = 0x00000001,
    styleInitialStringAuto      = 0x00000002,
    styleInitialStringNormal    = 0x00000003,
    styleInitialString_Max      = 0x7fffffff,
}
alias styleInitialString = int;

enum : int
{
    styleTransformOriginXNotSet = 0x00000000,
    styleTransformOriginXLeft   = 0x00000001,
    styleTransformOriginXCenter = 0x00000002,
    styleTransformOriginXRight  = 0x00000003,
    styleTransformOriginX_Max   = 0x7fffffff,
}
alias styleTransformOriginX = int;

enum : int
{
    styleTransformOriginYNotSet = 0x00000000,
    styleTransformOriginYTop    = 0x00000001,
    styleTransformOriginYCenter = 0x00000002,
    styleTransformOriginYBottom = 0x00000003,
    styleTransformOriginY_Max   = 0x7fffffff,
}
alias styleTransformOriginY = int;

enum : int
{
    stylePerspectiveOriginXNotSet = 0x00000000,
    stylePerspectiveOriginXLeft   = 0x00000001,
    stylePerspectiveOriginXCenter = 0x00000002,
    stylePerspectiveOriginXRight  = 0x00000003,
    stylePerspectiveOriginX_Max   = 0x7fffffff,
}
alias stylePerspectiveOriginX = int;

enum : int
{
    stylePerspectiveOriginYNotSet = 0x00000000,
    stylePerspectiveOriginYTop    = 0x00000001,
    stylePerspectiveOriginYCenter = 0x00000002,
    stylePerspectiveOriginYBottom = 0x00000003,
    stylePerspectiveOriginY_Max   = 0x7fffffff,
}
alias stylePerspectiveOriginY = int;

enum : int
{
    styleTransformStyleFlat       = 0x00000000,
    styleTransformStylePreserve3D = 0x00000001,
    styleTransformStyleNotSet     = 0x00000002,
    styleTransformStyle_Max       = 0x7fffffff,
}
alias styleTransformStyle = int;

enum : int
{
    styleBackfaceVisibilityVisible = 0x00000000,
    styleBackfaceVisibilityHidden  = 0x00000001,
    styleBackfaceVisibilityNotSet  = 0x00000002,
    styleBackfaceVisibility_Max    = 0x7fffffff,
}
alias styleBackfaceVisibility = int;

enum : int
{
    styleTextSizeAdjustNone = 0x00000000,
    styleTextSizeAdjustAuto = 0x00000001,
    styleTextSizeAdjust_Max = 0x7fffffff,
}
alias styleTextSizeAdjust = int;

enum : int
{
    styleColorInterpolationFiltersAuto      = 0x00000000,
    styleColorInterpolationFiltersSRgb      = 0x00000001,
    styleColorInterpolationFiltersLinearRgb = 0x00000002,
    styleColorInterpolationFiltersNotSet    = 0x00000003,
    styleColorInterpolationFilters_Max      = 0x7fffffff,
}
alias styleColorInterpolationFilters = int;

enum : int
{
    styleHyphensNone   = 0x00000000,
    styleHyphensManual = 0x00000001,
    styleHyphensAuto   = 0x00000002,
    styleHyphensNotSet = 0x00000003,
    styleHyphens_Max   = 0x7fffffff,
}
alias styleHyphens = int;

enum : int
{
    styleHyphenateLimitLinesNoLimit = 0x00000000,
    styleHyphenateLimitLines_Max    = 0x7fffffff,
}
alias styleHyphenateLimitLines = int;

enum : int
{
    styleMsAnimationPlayStateRunning = 0x00000000,
    styleMsAnimationPlayStatePaused  = 0x00000001,
    styleMsAnimationPlayStateNotSet  = 0x00000002,
    styleMsAnimationPlayState_Max    = 0x7fffffff,
}
alias styleMsAnimationPlayState = int;

enum : int
{
    styleMsAnimationDirectionNormal           = 0x00000000,
    styleMsAnimationDirectionAlternate        = 0x00000001,
    styleMsAnimationDirectionReverse          = 0x00000002,
    styleMsAnimationDirectionAlternateReverse = 0x00000003,
    styleMsAnimationDirectionNotSet           = 0x00000004,
    styleMsAnimationDirection_Max             = 0x7fffffff,
}
alias styleMsAnimationDirection = int;

enum : int
{
    styleMsAnimationFillModeNone      = 0x00000000,
    styleMsAnimationFillModeForwards  = 0x00000001,
    styleMsAnimationFillModeBackwards = 0x00000002,
    styleMsAnimationFillModeBoth      = 0x00000003,
    styleMsAnimationFillModeNotSet    = 0x00000004,
    styleMsAnimationFillMode_Max      = 0x7fffffff,
}
alias styleMsAnimationFillMode = int;

enum : int
{
    styleMsHighContrastAdjustNotSet = 0x00000000,
    styleMsHighContrastAdjustAuto   = 0x00000001,
    styleMsHighContrastAdjustNone   = 0x00000002,
    styleMsHighContrastAdjust_Max   = 0x7fffffff,
}
alias styleMsHighContrastAdjust = int;

enum : int
{
    styleMsUserSelectAuto    = 0x00000000,
    styleMsUserSelectText    = 0x00000001,
    styleMsUserSelectElement = 0x00000002,
    styleMsUserSelectNone    = 0x00000003,
    styleMsUserSelectNotSet  = 0x00000004,
    styleMsUserSelect_Max    = 0x7fffffff,
}
alias styleMsUserSelect = int;

enum : int
{
    styleMsTouchActionNotSet        = 0xffffffff,
    styleMsTouchActionNone          = 0x00000000,
    styleMsTouchActionAuto          = 0x00000001,
    styleMsTouchActionManipulation  = 0x00000002,
    styleMsTouchActionDoubleTapZoom = 0x00000004,
    styleMsTouchActionPanX          = 0x00000008,
    styleMsTouchActionPanY          = 0x00000010,
    styleMsTouchActionPinchZoom     = 0x00000020,
    styleMsTouchActionCrossSlideX   = 0x00000040,
    styleMsTouchActionCrossSlideY   = 0x00000080,
    styleMsTouchAction_Max          = 0x7fffffff,
}
alias styleMsTouchAction = int;

enum : int
{
    styleMsTouchSelectGrippers = 0x00000000,
    styleMsTouchSelectNone     = 0x00000001,
    styleMsTouchSelectNotSet   = 0x00000002,
    styleMsTouchSelect_Max     = 0x7fffffff,
}
alias styleMsTouchSelect = int;

enum : int
{
    styleMsScrollTranslationNotSet = 0x00000000,
    styleMsScrollTranslationNone   = 0x00000001,
    styleMsScrollTranslationVtoH   = 0x00000002,
    styleMsScrollTranslation_Max   = 0x7fffffff,
}
alias styleMsScrollTranslation = int;

enum : int
{
    styleBorderImageRepeatStretch = 0x00000000,
    styleBorderImageRepeatRepeat  = 0x00000001,
    styleBorderImageRepeatRound   = 0x00000002,
    styleBorderImageRepeatSpace   = 0x00000003,
    styleBorderImageRepeatNotSet  = 0x00000004,
    styleBorderImageRepeat_Max    = 0x7fffffff,
}
alias styleBorderImageRepeat = int;

enum : int
{
    styleBorderImageSliceFillNotSet = 0x00000000,
    styleBorderImageSliceFillFill   = 0x00000001,
    styleBorderImageSliceFill_Max   = 0x7fffffff,
}
alias styleBorderImageSliceFill = int;

enum : int
{
    styleMsImeAlignAuto   = 0x00000000,
    styleMsImeAlignAfter  = 0x00000001,
    styleMsImeAlignNotSet = 0x00000002,
    styleMsImeAlign_Max   = 0x7fffffff,
}
alias styleMsImeAlign = int;

enum : int
{
    styleMsTextCombineHorizontalNone   = 0x00000000,
    styleMsTextCombineHorizontalAll    = 0x00000001,
    styleMsTextCombineHorizontalDigits = 0x00000002,
    styleMsTextCombineHorizontalNotSet = 0x00000003,
    styleMsTextCombineHorizontal_Max   = 0x7fffffff,
}
alias styleMsTextCombineHorizontal = int;

enum : int
{
    styleWebkitAppearanceNone                         = 0x00000000,
    styleWebkitAppearanceCapsLockIndicator            = 0x00000001,
    styleWebkitAppearanceButton                       = 0x00000002,
    styleWebkitAppearanceButtonBevel                  = 0x00000003,
    styleWebkitAppearanceCaret                        = 0x00000004,
    styleWebkitAppearanceCheckbox                     = 0x00000005,
    styleWebkitAppearanceDefaultButton                = 0x00000006,
    styleWebkitAppearanceListbox                      = 0x00000007,
    styleWebkitAppearanceListitem                     = 0x00000008,
    styleWebkitAppearanceMediaFullscreenButton        = 0x00000009,
    styleWebkitAppearanceMediaMuteButton              = 0x0000000a,
    styleWebkitAppearanceMediaPlayButton              = 0x0000000b,
    styleWebkitAppearanceMediaSeekBackButton          = 0x0000000c,
    styleWebkitAppearanceMediaSeekForwardButton       = 0x0000000d,
    styleWebkitAppearanceMediaSlider                  = 0x0000000e,
    styleWebkitAppearanceMediaSliderthumb             = 0x0000000f,
    styleWebkitAppearanceMenulist                     = 0x00000010,
    styleWebkitAppearanceMenulistButton               = 0x00000011,
    styleWebkitAppearanceMenulistText                 = 0x00000012,
    styleWebkitAppearanceMenulistTextfield            = 0x00000013,
    styleWebkitAppearancePushButton                   = 0x00000014,
    styleWebkitAppearanceRadio                        = 0x00000015,
    styleWebkitAppearanceSearchfield                  = 0x00000016,
    styleWebkitAppearanceSearchfieldCancelButton      = 0x00000017,
    styleWebkitAppearanceSearchfieldDecoration        = 0x00000018,
    styleWebkitAppearanceSearchfieldResultsButton     = 0x00000019,
    styleWebkitAppearanceSearchfieldResultsDecoration = 0x0000001a,
    styleWebkitAppearanceSliderHorizontal             = 0x0000001b,
    styleWebkitAppearanceSliderVertical               = 0x0000001c,
    styleWebkitAppearanceSliderthumbHorizontal        = 0x0000001d,
    styleWebkitAppearanceSliderthumbVertical          = 0x0000001e,
    styleWebkitAppearanceSquareButton                 = 0x0000001f,
    styleWebkitAppearanceTextarea                     = 0x00000020,
    styleWebkitAppearanceTextfield                    = 0x00000021,
    styleWebkitAppearanceNotSet                       = 0x00000022,
    styleWebkitAppearance_Max                         = 0x7fffffff,
}
alias styleWebkitAppearance = int;

enum : int
{
    styleViewportSizeAuto         = 0x00000000,
    styleViewportSizeDeviceWidth  = 0x00000001,
    styleViewportSizeDeviceHeight = 0x00000002,
    styleViewportSize_Max         = 0x7fffffff,
}
alias styleViewportSize = int;

enum : int
{
    styleUserZoomNotSet = 0x00000000,
    styleUserZoomZoom   = 0x00000001,
    styleUserZoomFixed  = 0x00000002,
    styleUserZoom_Max   = 0x7fffffff,
}
alias styleUserZoom = int;

enum : int
{
    styleTextLineThroughStyleUndefined = 0x00000000,
    styleTextLineThroughStyleSingle    = 0x00000001,
    styleTextLineThroughStyleDouble    = 0x00000002,
    styleTextLineThroughStyle_Max      = 0x7fffffff,
}
alias styleTextLineThroughStyle = int;

enum : int
{
    styleTextUnderlineStyleUndefined        = 0x00000000,
    styleTextUnderlineStyleSingle           = 0x00000001,
    styleTextUnderlineStyleDouble           = 0x00000002,
    styleTextUnderlineStyleWords            = 0x00000003,
    styleTextUnderlineStyleDotted           = 0x00000004,
    styleTextUnderlineStyleThick            = 0x00000005,
    styleTextUnderlineStyleDash             = 0x00000006,
    styleTextUnderlineStyleDotDash          = 0x00000007,
    styleTextUnderlineStyleDotDotDash       = 0x00000008,
    styleTextUnderlineStyleWave             = 0x00000009,
    styleTextUnderlineStyleSingleAccounting = 0x0000000a,
    styleTextUnderlineStyleDoubleAccounting = 0x0000000b,
    styleTextUnderlineStyleThickDash        = 0x0000000c,
    styleTextUnderlineStyle_Max             = 0x7fffffff,
}
alias styleTextUnderlineStyle = int;

enum : int
{
    styleTextEffectNone    = 0x00000000,
    styleTextEffectEmboss  = 0x00000001,
    styleTextEffectEngrave = 0x00000002,
    styleTextEffectOutline = 0x00000003,
    styleTextEffect_Max    = 0x7fffffff,
}
alias styleTextEffect = int;

enum : int
{
    styleDefaultTextSelectionFalse = 0x00000000,
    styleDefaultTextSelectionTrue  = 0x00000001,
    styleDefaultTextSelection_Max  = 0x7fffffff,
}
alias styleDefaultTextSelection = int;

enum : int
{
    styleTextDecorationNone        = 0x00000000,
    styleTextDecorationUnderline   = 0x00000001,
    styleTextDecorationOverline    = 0x00000002,
    styleTextDecorationLineThrough = 0x00000003,
    styleTextDecorationBlink       = 0x00000004,
    styleTextDecoration_Max        = 0x7fffffff,
}
alias styleTextDecoration = int;

enum : int
{
    textDecorationNone        = 0x00000000,
    textDecorationUnderline   = 0x00000001,
    textDecorationOverline    = 0x00000002,
    textDecorationLineThrough = 0x00000003,
    textDecorationBlink       = 0x00000004,
    textDecoration_Max        = 0x7fffffff,
}
alias textDecoration = int;

enum : int
{
    htmlListTypeNotSet     = 0x00000000,
    htmlListTypeLargeAlpha = 0x00000001,
    htmlListTypeSmallAlpha = 0x00000002,
    htmlListTypeLargeRoman = 0x00000003,
    htmlListTypeSmallRoman = 0x00000004,
    htmlListTypeNumbers    = 0x00000005,
    htmlListTypeDisc       = 0x00000006,
    htmlListTypeCircle     = 0x00000007,
    htmlListTypeSquare     = 0x00000008,
    htmlListType_Max       = 0x7fffffff,
}
alias htmlListType = int;

enum : int
{
    htmlMethodNotSet = 0x00000000,
    htmlMethodGet    = 0x00000001,
    htmlMethodPost   = 0x00000002,
    htmlMethod_Max   = 0x7fffffff,
}
alias htmlMethod = int;

enum : int
{
    htmlWrapOff  = 0x00000001,
    htmlWrapSoft = 0x00000002,
    htmlWrapHard = 0x00000003,
    htmlWrap_Max = 0x7fffffff,
}
alias htmlWrap = int;

enum : int
{
    htmlDirNotSet      = 0x00000000,
    htmlDirLeftToRight = 0x00000001,
    htmlDirRightToLeft = 0x00000002,
    htmlDir_Max        = 0x7fffffff,
}
alias htmlDir = int;

enum : int
{
    htmlEditableInherit = 0x00000000,
    htmlEditableTrue    = 0x00000001,
    htmlEditableFalse   = 0x00000002,
    htmlEditable_Max    = 0x7fffffff,
}
alias htmlEditable = int;

enum : int
{
    htmlInputNotSet         = 0x00000000,
    htmlInputButton         = 0x00000001,
    htmlInputCheckbox       = 0x00000002,
    htmlInputFile           = 0x00000003,
    htmlInputHidden         = 0x00000004,
    htmlInputImage          = 0x00000005,
    htmlInputPassword       = 0x00000006,
    htmlInputRadio          = 0x00000007,
    htmlInputReset          = 0x00000008,
    htmlInputSelectOne      = 0x00000009,
    htmlInputSelectMultiple = 0x0000000a,
    htmlInputSubmit         = 0x0000000b,
    htmlInputText           = 0x0000000c,
    htmlInputTextarea       = 0x0000000d,
    htmlInputRichtext       = 0x0000000e,
    htmlInputRange          = 0x0000000f,
    htmlInputUrl            = 0x00000010,
    htmlInputEmail          = 0x00000011,
    htmlInputNumber         = 0x00000012,
    htmlInputTel            = 0x00000013,
    htmlInputSearch         = 0x00000014,
    htmlInput_Max           = 0x7fffffff,
}
alias htmlInput = int;

enum : int
{
    htmlSpellCheckNotSet  = 0x00000000,
    htmlSpellCheckTrue    = 0x00000001,
    htmlSpellCheckFalse   = 0x00000002,
    htmlSpellCheckDefault = 0x00000003,
    htmlSpellCheck_Max    = 0x7fffffff,
}
alias htmlSpellCheck = int;

enum : int
{
    htmlEncodingURL       = 0x00000000,
    htmlEncodingMultipart = 0x00000001,
    htmlEncodingText      = 0x00000002,
    htmlEncoding_Max      = 0x7fffffff,
}
alias htmlEncoding = int;

enum : int
{
    htmlAdjacencyBeforeBegin = 0x00000001,
    htmlAdjacencyAfterBegin  = 0x00000002,
    htmlAdjacencyBeforeEnd   = 0x00000003,
    htmlAdjacencyAfterEnd    = 0x00000004,
    htmlAdjacency_Max        = 0x7fffffff,
}
alias htmlAdjacency = int;

enum : int
{
    htmlTabIndexNotSet = 0xffff8000,
    htmlTabIndex_Max   = 0x7fffffff,
}
alias htmlTabIndex = int;

enum : int
{
    htmlComponentClient        = 0x00000000,
    htmlComponentSbLeft        = 0x00000001,
    htmlComponentSbPageLeft    = 0x00000002,
    htmlComponentSbHThumb      = 0x00000003,
    htmlComponentSbPageRight   = 0x00000004,
    htmlComponentSbRight       = 0x00000005,
    htmlComponentSbUp          = 0x00000006,
    htmlComponentSbPageUp      = 0x00000007,
    htmlComponentSbVThumb      = 0x00000008,
    htmlComponentSbPageDown    = 0x00000009,
    htmlComponentSbDown        = 0x0000000a,
    htmlComponentSbLeft2       = 0x0000000b,
    htmlComponentSbPageLeft2   = 0x0000000c,
    htmlComponentSbRight2      = 0x0000000d,
    htmlComponentSbPageRight2  = 0x0000000e,
    htmlComponentSbUp2         = 0x0000000f,
    htmlComponentSbPageUp2     = 0x00000010,
    htmlComponentSbDown2       = 0x00000011,
    htmlComponentSbPageDown2   = 0x00000012,
    htmlComponentSbTop         = 0x00000013,
    htmlComponentSbBottom      = 0x00000014,
    htmlComponentOutside       = 0x00000015,
    htmlComponentGHTopLeft     = 0x00000016,
    htmlComponentGHLeft        = 0x00000017,
    htmlComponentGHTop         = 0x00000018,
    htmlComponentGHBottomLeft  = 0x00000019,
    htmlComponentGHTopRight    = 0x0000001a,
    htmlComponentGHBottom      = 0x0000001b,
    htmlComponentGHRight       = 0x0000001c,
    htmlComponentGHBottomRight = 0x0000001d,
    htmlComponent_Max          = 0x7fffffff,
}
alias htmlComponent = int;

enum : int
{
    htmlApplyLocationInside  = 0x00000000,
    htmlApplyLocationOutside = 0x00000001,
    htmlApplyLocation_Max    = 0x7fffffff,
}
alias htmlApplyLocation = int;

enum : int
{
    htmlGlyphModeNone  = 0x00000000,
    htmlGlyphModeBegin = 0x00000001,
    htmlGlyphModeEnd   = 0x00000002,
    htmlGlyphModeBoth  = 0x00000003,
    htmlGlyphMode_Max  = 0x7fffffff,
}
alias htmlGlyphMode = int;

enum : int
{
    htmlDraggableAuto  = 0x00000000,
    htmlDraggableTrue  = 0x00000001,
    htmlDraggableFalse = 0x00000002,
    htmlDraggable_Max  = 0x7fffffff,
}
alias htmlDraggable = int;

enum : int
{
    htmlUnitCharacter = 0x00000001,
    htmlUnitWord      = 0x00000002,
    htmlUnitSentence  = 0x00000003,
    htmlUnitTextEdit  = 0x00000006,
    htmlUnit_Max      = 0x7fffffff,
}
alias htmlUnit = int;

enum : int
{
    htmlEndPointsStartToStart = 0x00000001,
    htmlEndPointsStartToEnd   = 0x00000002,
    htmlEndPointsEndToStart   = 0x00000003,
    htmlEndPointsEndToEnd     = 0x00000004,
    htmlEndPoints_Max         = 0x7fffffff,
}
alias htmlEndPoints = int;

enum : int
{
    htmlDirectionForward  = 0x0001869f,
    htmlDirectionBackward = 0xfffe7961,
    htmlDirection_Max     = 0x7fffffff,
}
alias htmlDirection = int;

enum : int
{
    htmlStartfileopen  = 0x00000000,
    htmlStartmouseover = 0x00000001,
    htmlStart_Max      = 0x7fffffff,
}
alias htmlStart = int;

enum : int
{
    bodyScrollyes     = 0x00000001,
    bodyScrollno      = 0x00000002,
    bodyScrollauto    = 0x00000004,
    bodyScrolldefault = 0x00000003,
    bodyScroll_Max    = 0x7fffffff,
}
alias bodyScroll = int;

enum : int
{
    htmlSelectTypeSelectOne      = 0x00000001,
    htmlSelectTypeSelectMultiple = 0x00000002,
    htmlSelectType_Max           = 0x7fffffff,
}
alias htmlSelectType = int;

enum : int
{
    htmlSelectExFlagNone                  = 0x00000000,
    htmlSelectExFlagHideSelectionInDesign = 0x00000001,
    htmlSelectExFlag_Max                  = 0x7fffffff,
}
alias htmlSelectExFlag = int;

enum : int
{
    htmlSelectionNone    = 0x00000000,
    htmlSelectionText    = 0x00000001,
    htmlSelectionControl = 0x00000002,
    htmlSelectionTable   = 0x00000003,
    htmlSelection_Max    = 0x7fffffff,
}
alias htmlSelection = int;

enum : int
{
    htmlMarqueeBehaviorscroll    = 0x00000001,
    htmlMarqueeBehaviorslide     = 0x00000002,
    htmlMarqueeBehavioralternate = 0x00000003,
    htmlMarqueeBehavior_Max      = 0x7fffffff,
}
alias htmlMarqueeBehavior = int;

enum : int
{
    htmlMarqueeDirectionleft  = 0x00000001,
    htmlMarqueeDirectionright = 0x00000003,
    htmlMarqueeDirectionup    = 0x00000005,
    htmlMarqueeDirectiondown  = 0x00000007,
    htmlMarqueeDirection_Max  = 0x7fffffff,
}
alias htmlMarqueeDirection = int;

enum : int
{
    htmlPersistStateNormal   = 0x00000000,
    htmlPersistStateFavorite = 0x00000001,
    htmlPersistStateHistory  = 0x00000002,
    htmlPersistStateSnapshot = 0x00000003,
    htmlPersistStateUserData = 0x00000004,
    htmlPersistState_Max     = 0x7fffffff,
}
alias htmlPersistState = int;

enum : int
{
    htmlDropEffectCopy = 0x00000000,
    htmlDropEffectLink = 0x00000001,
    htmlDropEffectMove = 0x00000002,
    htmlDropEffectNone = 0x00000003,
    htmlDropEffect_Max = 0x7fffffff,
}
alias htmlDropEffect = int;

enum : int
{
    htmlEffectAllowedCopy          = 0x00000000,
    htmlEffectAllowedLink          = 0x00000001,
    htmlEffectAllowedMove          = 0x00000002,
    htmlEffectAllowedCopyLink      = 0x00000003,
    htmlEffectAllowedCopyMove      = 0x00000004,
    htmlEffectAllowedLinkMove      = 0x00000005,
    htmlEffectAllowedAll           = 0x00000006,
    htmlEffectAllowedNone          = 0x00000007,
    htmlEffectAllowedUninitialized = 0x00000008,
    htmlEffectAllowed_Max          = 0x7fffffff,
}
alias htmlEffectAllowed = int;

enum : int
{
    htmlCompatModeBackCompat = 0x00000000,
    htmlCompatModeCSS1Compat = 0x00000001,
    htmlCompatMode_Max       = 0x7fffffff,
}
alias htmlCompatMode = int;

enum BoolValue : int
{
    True          = 0x00000001,
    False         = 0x00000000,
    BoolValue_Max = 0x7fffffff,
}

enum : int
{
    htmlCaptionAlignNotSet  = 0x00000000,
    htmlCaptionAlignLeft    = 0x00000001,
    htmlCaptionAlignCenter  = 0x00000002,
    htmlCaptionAlignRight   = 0x00000003,
    htmlCaptionAlignJustify = 0x00000004,
    htmlCaptionAlignTop     = 0x00000005,
    htmlCaptionAlignBottom  = 0x00000006,
    htmlCaptionAlign_Max    = 0x7fffffff,
}
alias htmlCaptionAlign = int;

enum : int
{
    htmlCaptionVAlignNotSet = 0x00000000,
    htmlCaptionVAlignTop    = 0x00000001,
    htmlCaptionVAlignBottom = 0x00000002,
    htmlCaptionVAlign_Max   = 0x7fffffff,
}
alias htmlCaptionVAlign = int;

enum : int
{
    htmlFrameNotSet = 0x00000000,
    htmlFramevoid   = 0x00000001,
    htmlFrameabove  = 0x00000002,
    htmlFramebelow  = 0x00000003,
    htmlFramehsides = 0x00000004,
    htmlFramelhs    = 0x00000005,
    htmlFramerhs    = 0x00000006,
    htmlFramevsides = 0x00000007,
    htmlFramebox    = 0x00000008,
    htmlFrameborder = 0x00000009,
    htmlFrame_Max   = 0x7fffffff,
}
alias htmlFrame = int;

enum : int
{
    htmlRulesNotSet = 0x00000000,
    htmlRulesnone   = 0x00000001,
    htmlRulesgroups = 0x00000002,
    htmlRulesrows   = 0x00000003,
    htmlRulescols   = 0x00000004,
    htmlRulesall    = 0x00000005,
    htmlRules_Max   = 0x7fffffff,
}
alias htmlRules = int;

enum : int
{
    htmlCellAlignNotSet = 0x00000000,
    htmlCellAlignLeft   = 0x00000001,
    htmlCellAlignCenter = 0x00000002,
    htmlCellAlignRight  = 0x00000003,
    htmlCellAlignMiddle = 0x00000002,
    htmlCellAlign_Max   = 0x7fffffff,
}
alias htmlCellAlign = int;

enum : int
{
    htmlCellVAlignNotSet   = 0x00000000,
    htmlCellVAlignTop      = 0x00000001,
    htmlCellVAlignMiddle   = 0x00000002,
    htmlCellVAlignBottom   = 0x00000003,
    htmlCellVAlignBaseline = 0x00000004,
    htmlCellVAlignCenter   = 0x00000002,
    htmlCellVAlign_Max     = 0x7fffffff,
}
alias htmlCellVAlign = int;

enum : int
{
    frameScrollingyes  = 0x00000001,
    frameScrollingno   = 0x00000002,
    frameScrollingauto = 0x00000004,
    frameScrolling_Max = 0x7fffffff,
}
alias frameScrolling = int;

enum : int
{
    sandboxAllowScripts       = 0x00000000,
    sandboxAllowSameOrigin    = 0x00000001,
    sandboxAllowTopNavigation = 0x00000002,
    sandboxAllowForms         = 0x00000003,
    sandboxAllowPopups        = 0x00000004,
    sandboxAllow_Max          = 0x7fffffff,
}
alias sandboxAllow = int;

enum : int
{
    SVG_ANGLETYPE_UNKNOWN     = 0x00000000,
    SVG_ANGLETYPE_UNSPECIFIED = 0x00000001,
    SVG_ANGLETYPE_DEG         = 0x00000002,
    SVG_ANGLETYPE_RAD         = 0x00000003,
    SVG_ANGLETYPE_GRAD        = 0x00000004,
    svgAngleType_Max          = 0x7fffffff,
}
alias svgAngleType = int;

enum : int
{
    svgExternalResourcesRequiredFalse = 0x00000000,
    svgExternalResourcesRequiredTrue  = 0x00000001,
    svgExternalResourcesRequired_Max  = 0x7fffffff,
}
alias svgExternalResourcesRequired = int;

enum : int
{
    svgFocusableNotSet = 0x00000000,
    svgFocusableAuto   = 0x00000001,
    svgFocusableTrue   = 0x00000002,
    svgFocusableFalse  = 0x00000003,
    svgFocusable_Max   = 0x7fffffff,
}
alias svgFocusable = int;

enum : int
{
    SVG_LENGTHTYPE_UNKNOWN    = 0x00000000,
    SVG_LENGTHTYPE_NUMBER     = 0x00000001,
    SVG_LENGTHTYPE_PERCENTAGE = 0x00000002,
    SVG_LENGTHTYPE_EMS        = 0x00000003,
    SVG_LENGTHTYPE_EXS        = 0x00000004,
    SVG_LENGTHTYPE_PX         = 0x00000005,
    SVG_LENGTHTYPE_CM         = 0x00000006,
    SVG_LENGTHTYPE_MM         = 0x00000007,
    SVG_LENGTHTYPE_IN         = 0x00000008,
    SVG_LENGTHTYPE_PT         = 0x00000009,
    SVG_LENGTHTYPE_PC         = 0x0000000a,
    svgLengthType_Max         = 0x7fffffff,
}
alias svgLengthType = int;

enum : int
{
    PATHSEG_UNKNOWN                      = 0x00000000,
    PATHSEG_CLOSEPATH                    = 0x00000001,
    PATHSEG_MOVETO_ABS                   = 0x00000002,
    PATHSEG_MOVETO_REL                   = 0x00000003,
    PATHSEG_LINETO_ABS                   = 0x00000004,
    PATHSEG_LINETO_REL                   = 0x00000005,
    PATHSEG_CURVETO_CUBIC_ABS            = 0x00000006,
    PATHSEG_CURVETO_CUBIC_REL            = 0x00000007,
    PATHSEG_CURVETO_QUADRATIC_ABS        = 0x00000008,
    PATHSEG_CURVETO_QUADRATIC_REL        = 0x00000009,
    PATHSEG_ARC_ABS                      = 0x0000000a,
    PATHSEG_ARC_REL                      = 0x0000000b,
    PATHSEG_LINETO_HORIZONTAL_ABS        = 0x0000000c,
    PATHSEG_LINETO_HORIZONTAL_REL        = 0x0000000d,
    PATHSEG_LINETO_VERTICAL_ABS          = 0x0000000e,
    PATHSEG_LINETO_VERTICAL_REL          = 0x0000000f,
    PATHSEG_CURVETO_CUBIC_SMOOTH_ABS     = 0x00000010,
    PATHSEG_CURVETO_CUBIC_SMOOTH_REL     = 0x00000011,
    PATHSEG_CURVETO_QUADRATIC_SMOOTH_ABS = 0x00000012,
    PATHSEG_CURVETO_QUADRATIC_SMOOTH_REL = 0x00000013,
    svgPathSegType_Max                   = 0x7fffffff,
}
alias svgPathSegType = int;

enum : int
{
    SVG_TRANSFORM_UNKNOWN   = 0x00000000,
    SVG_TRANSFORM_MATRIX    = 0x00000001,
    SVG_TRANSFORM_TRANSLATE = 0x00000002,
    SVG_TRANSFORM_SCALE     = 0x00000003,
    SVG_TRANSFORM_ROTATE    = 0x00000004,
    SVG_TRANSFORM_SKEWX     = 0x00000005,
    SVG_TRANSFORM_SKEWY     = 0x00000006,
    svgTransformType_Max    = 0x7fffffff,
}
alias svgTransformType = int;

enum : int
{
    SVG_PRESERVEASPECTRATIO_UNKNOWN     = 0x00000000,
    SVG_PRESERVEASPECTRATIO_NONE        = 0x00000001,
    SVG_PRESERVEASPECTRATIO_XMINYMIN    = 0x00000002,
    SVG_PRESERVEASPECTRATIO_XMIDYMIN    = 0x00000003,
    SVG_PRESERVEASPECTRATIO_XMAXYMIN    = 0x00000004,
    SVG_PRESERVEASPECTRATIO_XMINYMID    = 0x00000005,
    SVG_PRESERVEASPECTRATIO_XMIDYMID    = 0x00000006,
    SVG_PRESERVEASPECTRATIO_XMAXYMID    = 0x00000007,
    SVG_PRESERVEASPECTRATIO_XMINYMAX    = 0x00000008,
    SVG_PRESERVEASPECTRATIO_XMIDYMAX    = 0x00000009,
    SVG_PRESERVEASPECTRATIO_XMAXYMAX    = 0x0000000a,
    svgPreserveAspectRatioAlignType_Max = 0x7fffffff,
}
alias svgPreserveAspectRatioAlignType = int;

enum : int
{
    SVG_MEETORSLICE_UNKNOWN              = 0x00000000,
    SVG_MEETORSLICE_MEET                 = 0x00000001,
    SVG_MEETORSLICE_SLICE                = 0x00000002,
    svgPreserveAspectMeetOrSliceType_Max = 0x7fffffff,
}
alias svgPreserveAspectMeetOrSliceType = int;

enum : int
{
    SVG_UNITTYPE_UNKNOWN           = 0x00000000,
    SVG_UNITTYPE_USERSPACEONUSE    = 0x00000001,
    SVG_UNITTYPE_OBJECTBOUNDINGBOX = 0x00000002,
    svgUnitTypes_Max               = 0x7fffffff,
}
alias svgUnitTypes = int;

enum : int
{
    SVG_SPREADMETHOD_UNKNOWN = 0x00000000,
    SVG_SPREADMETHOD_PAD     = 0x00000001,
    SVG_SPREADMETHOD_REFLECT = 0x00000002,
    SVG_SPREADMETHOD_REPEAT  = 0x00000003,
    svgSpreadMethod_Max      = 0x7fffffff,
}
alias svgSpreadMethod = int;

enum : int
{
    SVG_FEBLEND_MODE_UNKNOWN  = 0x00000000,
    SVG_FEBLEND_MODE_NORMAL   = 0x00000001,
    SVG_FEBLEND_MODE_MULTIPLY = 0x00000002,
    SVG_FEBLEND_MODE_SCREEN   = 0x00000003,
    SVG_FEBLEND_MODE_DARKEN   = 0x00000004,
    SVG_FEBLEND_MODE_LIGHTEN  = 0x00000005,
    svgFeblendMode_Max        = 0x7fffffff,
}
alias svgFeblendMode = int;

enum : int
{
    SVG_FECOLORMATRIX_TYPE_UNKNOWN          = 0x00000000,
    SVG_FECOLORMATRIX_TYPE_MATRIX           = 0x00000001,
    SVG_FECOLORMATRIX_TYPE_SATURATE         = 0x00000002,
    SVG_FECOLORMATRIX_TYPE_HUEROTATE        = 0x00000003,
    SVG_FECOLORMATRIX_TYPE_LUMINANCETOALPHA = 0x00000004,
    svgFecolormatrixType_Max                = 0x7fffffff,
}
alias svgFecolormatrixType = int;

enum : int
{
    SVG_FECOMPONENTTRANSFER_TYPE_UNKNOWN  = 0x00000000,
    SVG_FECOMPONENTTRANSFER_TYPE_IDENTITY = 0x00000001,
    SVG_FECOMPONENTTRANSFER_TYPE_TABLE    = 0x00000002,
    SVG_FECOMPONENTTRANSFER_TYPE_DISCRETE = 0x00000003,
    SVG_FECOMPONENTTRANSFER_TYPE_LINEAR   = 0x00000004,
    SVG_FECOMPONENTTRANSFER_TYPE_GAMMA    = 0x00000005,
    svgFecomponenttransferType_Max        = 0x7fffffff,
}
alias svgFecomponenttransferType = int;

enum : int
{
    SVG_FECOMPOSITE_OPERATOR_UNKNOWN    = 0x00000000,
    SVG_FECOMPOSITE_OPERATOR_OVER       = 0x00000001,
    SVG_FECOMPOSITE_OPERATOR_IN         = 0x00000002,
    SVG_FECOMPOSITE_OPERATOR_OUT        = 0x00000003,
    SVG_FECOMPOSITE_OPERATOR_ATOP       = 0x00000004,
    SVG_FECOMPOSITE_OPERATOR_XOR        = 0x00000005,
    SVG_FECOMPOSITE_OPERATOR_ARITHMETIC = 0x00000006,
    svgFecompositeOperator_Max          = 0x7fffffff,
}
alias svgFecompositeOperator = int;

enum : int
{
    SVG_EDGEMODE_UNKNOWN   = 0x00000000,
    SVG_EDGEMODE_DUPLICATE = 0x00000001,
    SVG_EDGEMODE_WRAP      = 0x00000002,
    SVG_EDGEMODE_NONE      = 0x00000003,
    svgEdgemode_Max        = 0x7fffffff,
}
alias svgEdgemode = int;

enum : int
{
    SVG_PRESERVEALPHA_FALSE = 0x00000000,
    SVG_PRESERVEALPHA_TRUE  = 0x00000001,
    svgPreserveAlpha_Max    = 0x7fffffff,
}
alias svgPreserveAlpha = int;

enum : int
{
    SVG_CHANNEL_UNKNOWN = 0x00000000,
    SVG_CHANNEL_R       = 0x00000001,
    SVG_CHANNEL_G       = 0x00000002,
    SVG_CHANNEL_B       = 0x00000003,
    SVG_CHANNEL_A       = 0x00000004,
    svgChannel_Max      = 0x7fffffff,
}
alias svgChannel = int;

enum : int
{
    SVG_MORPHOLOGY_OPERATOR_UNKNOWN = 0x00000000,
    SVG_MORPHOLOGY_OPERATOR_ERODE   = 0x00000001,
    SVG_MORPHOLOGY_OPERATOR_DILATE  = 0x00000002,
    svgMorphologyOperator_Max       = 0x7fffffff,
}
alias svgMorphologyOperator = int;

enum : int
{
    SVG_TURBULENCE_TYPE_UNKNOWN     = 0x00000000,
    SVG_TURBULENCE_TYPE_FACTALNOISE = 0x00000001,
    SVG_TURBULENCE_TYPE_TURBULENCE  = 0x00000002,
    svgTurbulenceType_Max           = 0x7fffffff,
}
alias svgTurbulenceType = int;

enum : int
{
    SVG_STITCHTYPE_UNKNOWN  = 0x00000000,
    SVG_STITCHTYPE_STITCH   = 0x00000001,
    SVG_STITCHTYPE_NOSTITCH = 0x00000002,
    svgStitchtype_Max       = 0x7fffffff,
}
alias svgStitchtype = int;

enum : int
{
    SVG_MARKERUNITS_UNKNOWN        = 0x00000000,
    SVG_MARKERUNITS_USERSPACEONUSE = 0x00000001,
    SVG_MARKERUNITS_STROKEWIDTH    = 0x00000002,
    svgMarkerUnits_Max             = 0x7fffffff,
}
alias svgMarkerUnits = int;

enum : int
{
    SVG_MARKER_ORIENT_UNKNOWN = 0x00000000,
    SVG_MARKER_ORIENT_AUTO    = 0x00000001,
    SVG_MARKER_ORIENT_ANGLE   = 0x00000002,
    svgMarkerOrient_Max       = 0x7fffffff,
}
alias svgMarkerOrient = int;

enum : int
{
    svgMarkerOrientAttributeAuto = 0x00000000,
    svgMarkerOrientAttribute_Max = 0x7fffffff,
}
alias svgMarkerOrientAttribute = int;

enum : int
{
    htmlMediaNetworkStateEmpty    = 0x00000000,
    htmlMediaNetworkStateIdle     = 0x00000001,
    htmlMediaNetworkStateLoading  = 0x00000002,
    htmlMediaNetworkStateNoSource = 0x00000003,
    htmlMediaNetworkState_Max     = 0x7fffffff,
}
alias htmlMediaNetworkState = int;

enum : int
{
    htmlMediaReadyStateHaveNothing     = 0x00000000,
    htmlMediaReadyStateHaveMetadata    = 0x00000001,
    htmlMediaReadyStateHaveCurrentData = 0x00000002,
    htmlMediaReadyStateHaveFutureData  = 0x00000003,
    htmlMediaReadyStateHaveEnoughData  = 0x00000004,
    htmlMediaReadyState_Max            = 0x7fffffff,
}
alias htmlMediaReadyState = int;

enum : int
{
    htmlMediaErrAborted         = 0x00000000,
    htmlMediaErrNetwork         = 0x00000001,
    htmlMediaErrDecode          = 0x00000002,
    htmlMediaErrSrcNotSupported = 0x00000003,
    htmlMediaErr_Max            = 0x7fffffff,
}
alias htmlMediaErr = int;

enum : int
{
    LENGTHADJUST_UNKNOWN          = 0x00000000,
    LENGTHADJUST_SPACING          = 0x00000001,
    LENGTHADJUST_SPACINGANDGLYPHS = 0x00000002,
    lengthAdjust_Max              = 0x7fffffff,
}
alias lengthAdjust = int;

enum : int
{
    TEXTPATH_METHODTYPE_UNKNOWN = 0x00000000,
    TEXTPATH_METHODTYPE_ALIGN   = 0x00000001,
    TEXTPATH_METHODTYPE_STRETCH = 0x00000002,
    textpathMethodtype_Max      = 0x7fffffff,
}
alias textpathMethodtype = int;

enum : int
{
    TEXTPATH_SPACINGTYPE_UNKNOWN = 0x00000000,
    TEXTPATH_SPACINGTYPE_AUTO    = 0x00000001,
    TEXTPATH_SPACINGTYPE_EXACT   = 0x00000002,
    textpathSpacingtype_Max      = 0x7fffffff,
}
alias textpathSpacingtype = int;

enum : int
{
    ELEMENT_CORNER_NONE        = 0x00000000,
    ELEMENT_CORNER_TOP         = 0x00000001,
    ELEMENT_CORNER_LEFT        = 0x00000002,
    ELEMENT_CORNER_BOTTOM      = 0x00000003,
    ELEMENT_CORNER_RIGHT       = 0x00000004,
    ELEMENT_CORNER_TOPLEFT     = 0x00000005,
    ELEMENT_CORNER_TOPRIGHT    = 0x00000006,
    ELEMENT_CORNER_BOTTOMLEFT  = 0x00000007,
    ELEMENT_CORNER_BOTTOMRIGHT = 0x00000008,
    ELEMENT_CORNER_Max         = 0x7fffffff,
}
alias ELEMENT_CORNER = int;

enum : int
{
    SUHV_PROMPTBEFORENO             = 0x00000001,
    SUHV_SILENTYES                  = 0x00000002,
    SUHV_UNSECURESOURCE             = 0x00000004,
    SECUREURLHOSTVALIDATE_FLAGS_Max = 0x7fffffff,
}
alias SECUREURLHOSTVALIDATE_FLAGS = int;

enum : int
{
    POINTER_GRAVITY_Left  = 0x00000000,
    POINTER_GRAVITY_Right = 0x00000001,
    POINTER_GRAVITY_Max   = 0x7fffffff,
}
alias POINTER_GRAVITY = int;

enum : int
{
    ELEM_ADJ_BeforeBegin  = 0x00000000,
    ELEM_ADJ_AfterBegin   = 0x00000001,
    ELEM_ADJ_BeforeEnd    = 0x00000002,
    ELEM_ADJ_AfterEnd     = 0x00000003,
    ELEMENT_ADJACENCY_Max = 0x7fffffff,
}
alias ELEMENT_ADJACENCY = int;

enum : int
{
    CONTEXT_TYPE_None       = 0x00000000,
    CONTEXT_TYPE_Text       = 0x00000001,
    CONTEXT_TYPE_EnterScope = 0x00000002,
    CONTEXT_TYPE_ExitScope  = 0x00000003,
    CONTEXT_TYPE_NoScope    = 0x00000004,
    MARKUP_CONTEXT_TYPE_Max = 0x7fffffff,
}
alias MARKUP_CONTEXT_TYPE = int;

enum : int
{
    FINDTEXT_BACKWARDS               = 0x00000001,
    FINDTEXT_WHOLEWORD               = 0x00000002,
    FINDTEXT_MATCHCASE               = 0x00000004,
    FINDTEXT_RAW                     = 0x00020000,
    FINDTEXT_MATCHREPEATEDWHITESPACE = 0x00040000,
    FINDTEXT_MATCHDIAC               = 0x20000000,
    FINDTEXT_MATCHKASHIDA            = 0x40000000,
    FINDTEXT_MATCHALEFHAMZA          = 0x80000000,
    FINDTEXT_FLAGS_Max               = 0x7fffffff,
}
alias FINDTEXT_FLAGS = int;

enum : int
{
    MOVEUNIT_PREVCHAR         = 0x00000000,
    MOVEUNIT_NEXTCHAR         = 0x00000001,
    MOVEUNIT_PREVCLUSTERBEGIN = 0x00000002,
    MOVEUNIT_NEXTCLUSTERBEGIN = 0x00000003,
    MOVEUNIT_PREVCLUSTEREND   = 0x00000004,
    MOVEUNIT_NEXTCLUSTEREND   = 0x00000005,
    MOVEUNIT_PREVWORDBEGIN    = 0x00000006,
    MOVEUNIT_NEXTWORDBEGIN    = 0x00000007,
    MOVEUNIT_PREVWORDEND      = 0x00000008,
    MOVEUNIT_NEXTWORDEND      = 0x00000009,
    MOVEUNIT_PREVPROOFWORD    = 0x0000000a,
    MOVEUNIT_NEXTPROOFWORD    = 0x0000000b,
    MOVEUNIT_NEXTURLBEGIN     = 0x0000000c,
    MOVEUNIT_PREVURLBEGIN     = 0x0000000d,
    MOVEUNIT_NEXTURLEND       = 0x0000000e,
    MOVEUNIT_PREVURLEND       = 0x0000000f,
    MOVEUNIT_PREVSENTENCE     = 0x00000010,
    MOVEUNIT_NEXTSENTENCE     = 0x00000011,
    MOVEUNIT_PREVBLOCK        = 0x00000012,
    MOVEUNIT_NEXTBLOCK        = 0x00000013,
    MOVEUNIT_ACTION_Max       = 0x7fffffff,
}
alias MOVEUNIT_ACTION = int;

enum : int
{
    PARSE_ABSOLUTIFYIE40URLS = 0x00000001,
    PARSE_DISABLEVML         = 0x00000002,
    PARSE_FLAGS_Max          = 0x7fffffff,
}
alias PARSE_FLAGS = int;

enum : int
{
    TAGID_NULL                    = 0x00000000,
    TAGID_UNKNOWN                 = 0x00000001,
    TAGID_A                       = 0x00000002,
    TAGID_ACRONYM                 = 0x00000003,
    TAGID_ADDRESS                 = 0x00000004,
    TAGID_APPLET                  = 0x00000005,
    TAGID_AREA                    = 0x00000006,
    TAGID_B                       = 0x00000007,
    TAGID_BASE                    = 0x00000008,
    TAGID_BASEFONT                = 0x00000009,
    TAGID_BDO                     = 0x0000000a,
    TAGID_BGSOUND                 = 0x0000000b,
    TAGID_BIG                     = 0x0000000c,
    TAGID_BLINK                   = 0x0000000d,
    TAGID_BLOCKQUOTE              = 0x0000000e,
    TAGID_BODY                    = 0x0000000f,
    TAGID_BR                      = 0x00000010,
    TAGID_BUTTON                  = 0x00000011,
    TAGID_CAPTION                 = 0x00000012,
    TAGID_CENTER                  = 0x00000013,
    TAGID_CITE                    = 0x00000014,
    TAGID_CODE                    = 0x00000015,
    TAGID_COL                     = 0x00000016,
    TAGID_COLGROUP                = 0x00000017,
    TAGID_COMMENT                 = 0x00000018,
    TAGID_COMMENT_RAW             = 0x00000019,
    TAGID_DD                      = 0x0000001a,
    TAGID_DEL                     = 0x0000001b,
    TAGID_DFN                     = 0x0000001c,
    TAGID_DIR                     = 0x0000001d,
    TAGID_DIV                     = 0x0000001e,
    TAGID_DL                      = 0x0000001f,
    TAGID_DT                      = 0x00000020,
    TAGID_EM                      = 0x00000021,
    TAGID_EMBED                   = 0x00000022,
    TAGID_FIELDSET                = 0x00000023,
    TAGID_FONT                    = 0x00000024,
    TAGID_FORM                    = 0x00000025,
    TAGID_FRAME                   = 0x00000026,
    TAGID_FRAMESET                = 0x00000027,
    TAGID_GENERIC                 = 0x00000028,
    TAGID_H1                      = 0x00000029,
    TAGID_H2                      = 0x0000002a,
    TAGID_H3                      = 0x0000002b,
    TAGID_H4                      = 0x0000002c,
    TAGID_H5                      = 0x0000002d,
    TAGID_H6                      = 0x0000002e,
    TAGID_HEAD                    = 0x0000002f,
    TAGID_HR                      = 0x00000030,
    TAGID_HTML                    = 0x00000031,
    TAGID_I                       = 0x00000032,
    TAGID_IFRAME                  = 0x00000033,
    TAGID_IMG                     = 0x00000034,
    TAGID_INPUT                   = 0x00000035,
    TAGID_INS                     = 0x00000036,
    TAGID_KBD                     = 0x00000037,
    TAGID_LABEL                   = 0x00000038,
    TAGID_LEGEND                  = 0x00000039,
    TAGID_LI                      = 0x0000003a,
    TAGID_LINK                    = 0x0000003b,
    TAGID_LISTING                 = 0x0000003c,
    TAGID_MAP                     = 0x0000003d,
    TAGID_MARQUEE                 = 0x0000003e,
    TAGID_MENU                    = 0x0000003f,
    TAGID_META                    = 0x00000040,
    TAGID_NEXTID                  = 0x00000041,
    TAGID_NOBR                    = 0x00000042,
    TAGID_NOEMBED                 = 0x00000043,
    TAGID_NOFRAMES                = 0x00000044,
    TAGID_NOSCRIPT                = 0x00000045,
    TAGID_OBJECT                  = 0x00000046,
    TAGID_OL                      = 0x00000047,
    TAGID_OPTION                  = 0x00000048,
    TAGID_P                       = 0x00000049,
    TAGID_PARAM                   = 0x0000004a,
    TAGID_PLAINTEXT               = 0x0000004b,
    TAGID_PRE                     = 0x0000004c,
    TAGID_Q                       = 0x0000004d,
    TAGID_RP                      = 0x0000004e,
    TAGID_RT                      = 0x0000004f,
    TAGID_RUBY                    = 0x00000050,
    TAGID_S                       = 0x00000051,
    TAGID_SAMP                    = 0x00000052,
    TAGID_SCRIPT                  = 0x00000053,
    TAGID_SELECT                  = 0x00000054,
    TAGID_SMALL                   = 0x00000055,
    TAGID_SPAN                    = 0x00000056,
    TAGID_STRIKE                  = 0x00000057,
    TAGID_STRONG                  = 0x00000058,
    TAGID_STYLE                   = 0x00000059,
    TAGID_SUB                     = 0x0000005a,
    TAGID_SUP                     = 0x0000005b,
    TAGID_TABLE                   = 0x0000005c,
    TAGID_TBODY                   = 0x0000005d,
    TAGID_TC                      = 0x0000005e,
    TAGID_TD                      = 0x0000005f,
    TAGID_TEXTAREA                = 0x00000060,
    TAGID_TFOOT                   = 0x00000061,
    TAGID_TH                      = 0x00000062,
    TAGID_THEAD                   = 0x00000063,
    TAGID_TITLE                   = 0x00000064,
    TAGID_TR                      = 0x00000065,
    TAGID_TT                      = 0x00000066,
    TAGID_U                       = 0x00000067,
    TAGID_UL                      = 0x00000068,
    TAGID_VAR                     = 0x00000069,
    TAGID_WBR                     = 0x0000006a,
    TAGID_XMP                     = 0x0000006b,
    TAGID_ROOT                    = 0x0000006c,
    TAGID_OPTGROUP                = 0x0000006d,
    TAGID_ABBR                    = 0x0000006e,
    TAGID_SVG_A                   = 0x0000006f,
    TAGID_SVG_ALTGLYPH            = 0x00000070,
    TAGID_SVG_ALTGLYPHDEF         = 0x00000071,
    TAGID_SVG_ALTGLYPHITEM        = 0x00000072,
    TAGID_SVG_ANIMATE             = 0x00000073,
    TAGID_SVG_ANIMATECOLOR        = 0x00000074,
    TAGID_SVG_ANIMATEMOTION       = 0x00000075,
    TAGID_SVG_ANIMATETRANSFORM    = 0x00000076,
    TAGID_SVG_CIRCLE              = 0x00000077,
    TAGID_SVG_CLIPPATH            = 0x00000078,
    TAGID_SVG_COLOR_PROFILE       = 0x00000079,
    TAGID_SVG_CURSOR              = 0x0000007a,
    TAGID_SVG_DEFINITION_SRC      = 0x0000007b,
    TAGID_SVG_DEFS                = 0x0000007c,
    TAGID_SVG_DESC                = 0x0000007d,
    TAGID_SVG_ELLIPSE             = 0x0000007e,
    TAGID_SVG_FEBLEND             = 0x0000007f,
    TAGID_SVG_FECOLORMATRIX       = 0x00000080,
    TAGID_SVG_FECOMPONENTTRANSFER = 0x00000081,
    TAGID_SVG_FECOMPOSITE         = 0x00000082,
    TAGID_SVG_FECONVOLVEMATRIX    = 0x00000083,
    TAGID_SVG_FEDIFFUSELIGHTING   = 0x00000084,
    TAGID_SVG_FEDISPLACEMENTMAP   = 0x00000085,
    TAGID_SVG_FEDISTANTLIGHT      = 0x00000086,
    TAGID_SVG_FEFLOOD             = 0x00000087,
    TAGID_SVG_FEFUNCA             = 0x00000088,
    TAGID_SVG_FEFUNCB             = 0x00000089,
    TAGID_SVG_FEFUNCG             = 0x0000008a,
    TAGID_SVG_FEFUNCR             = 0x0000008b,
    TAGID_SVG_FEGAUSSIANBLUR      = 0x0000008c,
    TAGID_SVG_FEIMAGE             = 0x0000008d,
    TAGID_SVG_FEMERGE             = 0x0000008e,
    TAGID_SVG_FEMERGENODE         = 0x0000008f,
    TAGID_SVG_FEMORPHOLOGY        = 0x00000090,
    TAGID_SVG_FEOFFSET            = 0x00000091,
    TAGID_SVG_FEPOINTLIGHT        = 0x00000092,
    TAGID_SVG_FESPECULARLIGHTING  = 0x00000093,
    TAGID_SVG_FESPOTLIGHT         = 0x00000094,
    TAGID_SVG_FETILE              = 0x00000095,
    TAGID_SVG_FETURBULENCE        = 0x00000096,
    TAGID_SVG_FILTER              = 0x00000097,
    TAGID_SVG_FONT                = 0x00000098,
    TAGID_SVG_FONT_FACE           = 0x00000099,
    TAGID_SVG_FONT_FACE_FORMAT    = 0x0000009a,
    TAGID_SVG_FONT_FACE_NAME      = 0x0000009b,
    TAGID_SVG_FONT_FACE_SRC       = 0x0000009c,
    TAGID_SVG_FONT_FACE_URI       = 0x0000009d,
    TAGID_SVG_FOREIGNOBJECT       = 0x0000009e,
    TAGID_SVG_G                   = 0x0000009f,
    TAGID_SVG_GLYPH               = 0x000000a0,
    TAGID_SVG_GLYPHREF            = 0x000000a1,
    TAGID_SVG_HKERN               = 0x000000a2,
    TAGID_SVG_IMAGE               = 0x000000a3,
    TAGID_SVG_LINE                = 0x000000a4,
    TAGID_SVG_LINEARGRADIENT      = 0x000000a5,
    TAGID_SVG_MARKER              = 0x000000a6,
    TAGID_SVG_MASK                = 0x000000a7,
    TAGID_SVG_METADATA            = 0x000000a8,
    TAGID_SVG_MISSING_GLYPH       = 0x000000a9,
    TAGID_SVG_MPATH               = 0x000000aa,
    TAGID_SVG_PATH                = 0x000000ab,
    TAGID_SVG_PATTERN             = 0x000000ac,
    TAGID_SVG_POLYGON             = 0x000000ad,
    TAGID_SVG_POLYLINE            = 0x000000ae,
    TAGID_SVG_RADIALGRADIENT      = 0x000000af,
    TAGID_SVG_RECT                = 0x000000b0,
    TAGID_SVG_SCRIPT              = 0x000000b1,
    TAGID_SVG_SET                 = 0x000000b2,
    TAGID_SVG_STOP                = 0x000000b3,
    TAGID_SVG_STYLE               = 0x000000b4,
    TAGID_SVG_SVG                 = 0x000000b5,
    TAGID_SVG_SWITCH              = 0x000000b6,
    TAGID_SVG_SYMBOL              = 0x000000b7,
    TAGID_SVG_TEXT                = 0x000000b8,
    TAGID_SVG_TEXTPATH            = 0x000000b9,
    TAGID_SVG_TITLE               = 0x000000ba,
    TAGID_SVG_TREF                = 0x000000bb,
    TAGID_SVG_TSPAN               = 0x000000bc,
    TAGID_SVG_USE                 = 0x000000bd,
    TAGID_SVG_VIEW                = 0x000000be,
    TAGID_SVG_VKERN               = 0x000000bf,
    TAGID_AUDIO                   = 0x000000c0,
    TAGID_SOURCE                  = 0x000000c1,
    TAGID_VIDEO                   = 0x000000c2,
    TAGID_CANVAS                  = 0x000000c3,
    TAGID_DOCTYPE                 = 0x000000c4,
    TAGID_KEYGEN                  = 0x000000c5,
    TAGID_PROCESSINGINSTRUCTION   = 0x000000c6,
    TAGID_ARTICLE                 = 0x000000c7,
    TAGID_ASIDE                   = 0x000000c8,
    TAGID_FIGCAPTION              = 0x000000c9,
    TAGID_FIGURE                  = 0x000000ca,
    TAGID_FOOTER                  = 0x000000cb,
    TAGID_HEADER                  = 0x000000cc,
    TAGID_HGROUP                  = 0x000000cd,
    TAGID_MARK                    = 0x000000ce,
    TAGID_NAV                     = 0x000000cf,
    TAGID_SECTION                 = 0x000000d0,
    TAGID_PROGRESS                = 0x000000d1,
    TAGID_MATHML_ANNOTATION_XML   = 0x000000d2,
    TAGID_MATHML_MATH             = 0x000000d3,
    TAGID_MATHML_MI               = 0x000000d4,
    TAGID_MATHML_MN               = 0x000000d5,
    TAGID_MATHML_MO               = 0x000000d6,
    TAGID_MATHML_MS               = 0x000000d7,
    TAGID_MATHML_MTEXT            = 0x000000d8,
    TAGID_DATALIST                = 0x000000d9,
    TAGID_TRACK                   = 0x000000da,
    TAGID_ISINDEX                 = 0x000000db,
    TAGID_COMMAND                 = 0x000000dc,
    TAGID_DETAILS                 = 0x000000dd,
    TAGID_SUMMARY                 = 0x000000de,
    TAGID_X_MS_WEBVIEW            = 0x000000df,
    TAGID_COUNT                   = 0x000000e0,
    TAGID_LAST_PREDEFINED         = 0x00002710,
    ELEMENT_TAG_ID_Max            = 0x7fffffff,
}
alias ELEMENT_TAG_ID = int;

enum : int
{
    SELECTION_TYPE_None    = 0x00000000,
    SELECTION_TYPE_Caret   = 0x00000001,
    SELECTION_TYPE_Text    = 0x00000002,
    SELECTION_TYPE_Control = 0x00000003,
    SELECTION_TYPE_Max     = 0x7fffffff,
}
alias SELECTION_TYPE = int;

enum : int
{
    SAVE_SEGMENTS_NoIE4SelectionCompat = 0x00000001,
    SAVE_SEGMENTS_FLAGS_Max            = 0x7fffffff,
}
alias SAVE_SEGMENTS_FLAGS = int;

enum : int
{
    CARET_DIRECTION_INDETERMINATE = 0x00000000,
    CARET_DIRECTION_SAME          = 0x00000001,
    CARET_DIRECTION_BACKWARD      = 0x00000002,
    CARET_DIRECTION_FORWARD       = 0x00000003,
    CARET_DIRECTION_Max           = 0x7fffffff,
}
alias CARET_DIRECTION = int;

enum : int
{
    LINE_DIRECTION_RightToLeft = 0x00000001,
    LINE_DIRECTION_LeftToRight = 0x00000002,
    LINE_DIRECTION_Max         = 0x7fffffff,
}
alias LINE_DIRECTION = int;

enum : int
{
    HT_OPT_AllowAfterEOL = 0x00000001,
    HT_OPTIONS_Max       = 0x7fffffff,
}
alias HT_OPTIONS = int;

enum : int
{
    HT_RESULTS_Glyph = 0x00000001,
    HT_RESULTS_Max   = 0x7fffffff,
}
alias HT_RESULTS = int;

enum : int
{
    DISPLAY_MOVEUNIT_PreviousLine     = 0x00000001,
    DISPLAY_MOVEUNIT_NextLine         = 0x00000002,
    DISPLAY_MOVEUNIT_CurrentLineStart = 0x00000003,
    DISPLAY_MOVEUNIT_CurrentLineEnd   = 0x00000004,
    DISPLAY_MOVEUNIT_TopOfWindow      = 0x00000005,
    DISPLAY_MOVEUNIT_BottomOfWindow   = 0x00000006,
    DISPLAY_MOVEUNIT_Max              = 0x7fffffff,
}
alias DISPLAY_MOVEUNIT = int;

enum : int
{
    DISPLAY_GRAVITY_PreviousLine = 0x00000001,
    DISPLAY_GRAVITY_NextLine     = 0x00000002,
    DISPLAY_GRAVITY_Max          = 0x7fffffff,
}
alias DISPLAY_GRAVITY = int;

enum : int
{
    DISPLAY_BREAK_None  = 0x00000000,
    DISPLAY_BREAK_Block = 0x00000001,
    DISPLAY_BREAK_Break = 0x00000002,
    DISPLAY_BREAK_Max   = 0x7fffffff,
}
alias DISPLAY_BREAK = int;

enum : int
{
    COORD_SYSTEM_GLOBAL    = 0x00000000,
    COORD_SYSTEM_PARENT    = 0x00000001,
    COORD_SYSTEM_CONTAINER = 0x00000002,
    COORD_SYSTEM_CONTENT   = 0x00000003,
    COORD_SYSTEM_FRAME     = 0x00000004,
    COORD_SYSTEM_CLIENT    = 0x00000005,
    COORD_SYSTEM_Max       = 0x7fffffff,
}
alias COORD_SYSTEM = int;

enum : int
{
    DCML_INFORMATIONAL            = 0x00000000,
    DCML_WARNING                  = 0x00000001,
    DCML_ERROR                    = 0x00000002,
    DEV_CONSOLE_MESSAGE_LEVEL_Max = 0x7fffffff,
}
alias DEV_CONSOLE_MESSAGE_LEVEL = int;

enum : int
{
    DEP_CAPTURING_PHASE = 0x00000001,
    DEP_AT_TARGET       = 0x00000002,
    DEP_BUBBLING_PHASE  = 0x00000003,
    DOM_EVENT_PHASE_Max = 0x7fffffff,
}
alias DOM_EVENT_PHASE = int;

enum : int
{
    STT_TIMEOUT           = 0x00000000,
    STT_INTERVAL          = 0x00000001,
    STT_IMMEDIATE         = 0x00000002,
    STT_ANIMATION_FRAME   = 0x00000003,
    SCRIPT_TIMER_TYPE_Max = 0x7fffffff,
}
alias SCRIPT_TIMER_TYPE = int;

enum : int
{
    HTMLPAINTER_OPAQUE         = 0x00000001,
    HTMLPAINTER_TRANSPARENT    = 0x00000002,
    HTMLPAINTER_ALPHA          = 0x00000004,
    HTMLPAINTER_COMPLEX        = 0x00000008,
    HTMLPAINTER_OVERLAY        = 0x00000010,
    HTMLPAINTER_HITTEST        = 0x00000020,
    HTMLPAINTER_SURFACE        = 0x00000100,
    HTMLPAINTER_3DSURFACE      = 0x00000200,
    HTMLPAINTER_NOBAND         = 0x00000400,
    HTMLPAINTER_NODC           = 0x00001000,
    HTMLPAINTER_NOPHYSICALCLIP = 0x00002000,
    HTMLPAINTER_NOSAVEDC       = 0x00004000,
    HTMLPAINTER_SUPPORTS_XFORM = 0x00008000,
    HTMLPAINTER_EXPAND         = 0x00010000,
    HTMLPAINTER_NOSCROLLBITS   = 0x00020000,
    HTML_PAINTER_Max           = 0x7fffffff,
}
alias HTML_PAINTER = int;

enum : int
{
    HTMLPAINT_ZORDER_NONE               = 0x00000000,
    HTMLPAINT_ZORDER_REPLACE_ALL        = 0x00000001,
    HTMLPAINT_ZORDER_REPLACE_CONTENT    = 0x00000002,
    HTMLPAINT_ZORDER_REPLACE_BACKGROUND = 0x00000003,
    HTMLPAINT_ZORDER_BELOW_CONTENT      = 0x00000004,
    HTMLPAINT_ZORDER_BELOW_FLOW         = 0x00000005,
    HTMLPAINT_ZORDER_ABOVE_FLOW         = 0x00000006,
    HTMLPAINT_ZORDER_ABOVE_CONTENT      = 0x00000007,
    HTMLPAINT_ZORDER_WINDOW_TOP         = 0x00000008,
    HTML_PAINT_ZORDER_Max               = 0x7fffffff,
}
alias HTML_PAINT_ZORDER = int;

enum : int
{
    HTMLPAINT_DRAW_UPDATEREGION = 0x00000001,
    HTMLPAINT_DRAW_USE_XFORM    = 0x00000002,
    HTML_PAINT_DRAW_FLAGS_Max   = 0x7fffffff,
}
alias HTML_PAINT_DRAW_FLAGS = int;

enum : int
{
    HTMLPAINT_EVENT_TARGET     = 0x00000001,
    HTMLPAINT_EVENT_SETCURSOR  = 0x00000002,
    HTML_PAINT_EVENT_FLAGS_Max = 0x7fffffff,
}
alias HTML_PAINT_EVENT_FLAGS = int;

enum : int
{
    HTMLPAINT_DRAWINFO_VIEWPORT     = 0x00000001,
    HTMLPAINT_DRAWINFO_UPDATEREGION = 0x00000002,
    HTMLPAINT_DRAWINFO_XFORM        = 0x00000004,
    HTML_PAINT_DRAW_INFO_FLAGS_Max  = 0x7fffffff,
}
alias HTML_PAINT_DRAW_INFO_FLAGS = int;

enum : int
{
    HTMLDlgFlagNo     = 0x00000000,
    HTMLDlgFlagOff    = 0x00000000,
    HTMLDlgFlag0      = 0x00000000,
    HTMLDlgFlagYes    = 0x00000001,
    HTMLDlgFlagOn     = 0x00000001,
    HTMLDlgFlag1      = 0x00000001,
    HTMLDlgFlagNotSet = 0xffffffff,
    HTMLDlgFlag_Max   = 0x7fffffff,
}
alias HTMLDlgFlag = int;

enum HTMLDlgBorder : int
{
    HTMLDlgBorderThin  = 0x00000000,
    HTMLDlgBorderThick = 0x00040000,
    HTMLDlgBorder_Max  = 0x7fffffff,
}

enum : int
{
    HTMLDlgEdgeSunken = 0x00000000,
    HTMLDlgEdgeRaised = 0x00000010,
    HTMLDlgEdge_Max   = 0x7fffffff,
}
alias HTMLDlgEdge = int;

enum HTMLDlgCenter : int
{
    HTMLDlgCenterNo      = 0x00000000,
    HTMLDlgCenterOff     = 0x00000000,
    HTMLDlgCenter0       = 0x00000000,
    HTMLDlgCenterYes     = 0x00000001,
    HTMLDlgCenterOn      = 0x00000001,
    HTMLDlgCenter1       = 0x00000001,
    HTMLDlgCenterParent  = 0x00000001,
    HTMLDlgCenterDesktop = 0x00000002,
    HTMLDlgCenter_Max    = 0x7fffffff,
}

enum : int
{
    HTMLAppFlagNo   = 0x00000000,
    HTMLAppFlagOff  = 0x00000000,
    HTMLAppFlag0    = 0x00000000,
    HTMLAppFlagYes  = 0x00000001,
    HTMLAppFlagOn   = 0x00000001,
    HTMLAppFlag1    = 0x00000001,
    HTMLAppFlag_Max = 0x7fffffff,
}
alias HTMLAppFlag = int;

enum HTMLMinimizeFlag : int
{
    HTMLMinimizeFlagNo   = 0x00000000,
    HTMLMinimizeFlagYes  = 0x00020000,
    HTMLMinimizeFlag_Max = 0x7fffffff,
}

enum HTMLMaximizeFlag : int
{
    HTMLMaximizeFlagNo   = 0x00000000,
    HTMLMaximizeFlagYes  = 0x00010000,
    HTMLMaximizeFlag_Max = 0x7fffffff,
}

enum HTMLCaptionFlag : int
{
    HTMLCaptionFlagNo   = 0x00000000,
    HTMLCaptionFlagYes  = 0x00c00000,
    HTMLCaptionFlag_Max = 0x7fffffff,
}

enum HTMLSysMenuFlag : int
{
    HTMLSysMenuFlagNo   = 0x00000000,
    HTMLSysMenuFlagYes  = 0x00080000,
    HTMLSysMenuFlag_Max = 0x7fffffff,
}

enum : int
{
    HTMLBorderNone   = 0x00000000,
    HTMLBorderThick  = 0x00040000,
    HTMLBorderDialog = 0x00400000,
    HTMLBorderThin   = 0x00800000,
    HTMLBorder_Max   = 0x7fffffff,
}
alias HTMLBorder = int;

enum HTMLBorderStyle : int
{
    HTMLBorderStyleNormal   = 0x00000000,
    HTMLBorderStyleRaised   = 0x00000100,
    HTMLBorderStyleSunken   = 0x00000200,
    HTMLBorderStylecombined = 0x00000300,
    HTMLBorderStyleStatic   = 0x00020000,
    HTMLBorderStyle_Max     = 0x7fffffff,
}

enum HTMLWindowState : int
{
    HTMLWindowStateNormal   = 0x00000001,
    HTMLWindowStateMaximize = 0x00000003,
    HTMLWindowStateMinimize = 0x00000006,
    HTMLWindowState_Max     = 0x7fffffff,
}

enum : int
{
    BEHAVIOREVENT_FIRST                 = 0x00000000,
    BEHAVIOREVENT_CONTENTREADY          = 0x00000000,
    BEHAVIOREVENT_DOCUMENTREADY         = 0x00000001,
    BEHAVIOREVENT_APPLYSTYLE            = 0x00000002,
    BEHAVIOREVENT_DOCUMENTCONTEXTCHANGE = 0x00000003,
    BEHAVIOREVENT_CONTENTSAVE           = 0x00000004,
    BEHAVIOREVENT_LAST                  = 0x00000004,
    BEHAVIOR_EVENT_Max                  = 0x7fffffff,
}
alias BEHAVIOR_EVENT = int;

enum : int
{
    BEHAVIOREVENTFLAGS_BUBBLE           = 0x00000001,
    BEHAVIOREVENTFLAGS_STANDARDADDITIVE = 0x00000002,
    BEHAVIOR_EVENT_FLAGS_Max            = 0x7fffffff,
}
alias BEHAVIOR_EVENT_FLAGS = int;

enum : int
{
    BEHAVIORRENDERINFO_BEFOREBACKGROUND  = 0x00000001,
    BEHAVIORRENDERINFO_AFTERBACKGROUND   = 0x00000002,
    BEHAVIORRENDERINFO_BEFORECONTENT     = 0x00000004,
    BEHAVIORRENDERINFO_AFTERCONTENT      = 0x00000008,
    BEHAVIORRENDERINFO_AFTERFOREGROUND   = 0x00000020,
    BEHAVIORRENDERINFO_ABOVECONTENT      = 0x00000028,
    BEHAVIORRENDERINFO_ALLLAYERS         = 0x000000ff,
    BEHAVIORRENDERINFO_DISABLEBACKGROUND = 0x00000100,
    BEHAVIORRENDERINFO_DISABLENEGATIVEZ  = 0x00000200,
    BEHAVIORRENDERINFO_DISABLECONTENT    = 0x00000400,
    BEHAVIORRENDERINFO_DISABLEPOSITIVEZ  = 0x00000800,
    BEHAVIORRENDERINFO_DISABLEALLLAYERS  = 0x00000f00,
    BEHAVIORRENDERINFO_HITTESTING        = 0x00001000,
    BEHAVIORRENDERINFO_SURFACE           = 0x00100000,
    BEHAVIORRENDERINFO_3DSURFACE         = 0x00200000,
    BEHAVIOR_RENDER_INFO_Max             = 0x7fffffff,
}
alias BEHAVIOR_RENDER_INFO = int;

enum : int
{
    BEHAVIOR_FIRSTRELATION = 0x00000000,
    BEHAVIOR_SAMEELEMENT   = 0x00000000,
    BEHAVIOR_PARENT        = 0x00000001,
    BEHAVIOR_CHILD         = 0x00000002,
    BEHAVIOR_SIBLING       = 0x00000003,
    BEHAVIOR_LASTRELATION  = 0x00000003,
    BEHAVIOR_RELATION_Max  = 0x7fffffff,
}
alias BEHAVIOR_RELATION = int;

enum : int
{
    BEHAVIORLAYOUTINFO_FULLDELEGATION = 0x00000001,
    BEHAVIORLAYOUTINFO_MODIFYNATURAL  = 0x00000002,
    BEHAVIORLAYOUTINFO_MAPSIZE        = 0x00000004,
    BEHAVIOR_LAYOUT_INFO_Max          = 0x7fffffff,
}
alias BEHAVIOR_LAYOUT_INFO = int;

enum : int
{
    BEHAVIORLAYOUTMODE_NATURAL          = 0x00000001,
    BEHAVIORLAYOUTMODE_MINWIDTH         = 0x00000002,
    BEHAVIORLAYOUTMODE_MAXWIDTH         = 0x00000004,
    BEHAVIORLAYOUTMODE_MEDIA_RESOLUTION = 0x00004000,
    BEHAVIORLAYOUTMODE_FINAL_PERCENT    = 0x00008000,
    BEHAVIOR_LAYOUT_MODE_Max            = 0x7fffffff,
}
alias BEHAVIOR_LAYOUT_MODE = int;

enum : int
{
    ELEMENTDESCRIPTORFLAGS_LITERAL        = 0x00000001,
    ELEMENTDESCRIPTORFLAGS_NESTED_LITERAL = 0x00000002,
    ELEMENTDESCRIPTOR_FLAGS_Max           = 0x7fffffff,
}
alias ELEMENTDESCRIPTOR_FLAGS = int;

enum : int
{
    ELEMENTNAMESPACEFLAGS_ALLOWANYTAG         = 0x00000001,
    ELEMENTNAMESPACEFLAGS_QUERYFORUNKNOWNTAGS = 0x00000002,
    ELEMENTNAMESPACE_FLAGS_Max                = 0x7fffffff,
}
alias ELEMENTNAMESPACE_FLAGS = int;

enum : int
{
    VIEW_OBJECT_ALPHA_MODE_IGNORE        = 0x00000000,
    VIEW_OBJECT_ALPHA_MODE_PREMULTIPLIED = 0x00000001,
    VIEW_OBJECT_ALPHA_MODE_Max           = 0x7fffffff,
}
alias VIEW_OBJECT_ALPHA_MODE = int;

enum : int
{
    VIEW_OBJECT_COMPOSITION_MODE_LEGACY           = 0x00000000,
    VIEW_OBJECT_COMPOSITION_MODE_SURFACEPRESENTER = 0x00000001,
    VIEW_OBJECT_COMPOSITION_MODE_Max              = 0x7fffffff,
}
alias VIEW_OBJECT_COMPOSITION_MODE = int;

// Constants


enum : int
{
    ACTIVPROF_E_PROFILER_PRESENT       = 0x80040200,
    ACTIVPROF_E_PROFILER_ABSENT        = 0x80040201,
    ACTIVPROF_E_UNABLE_TO_APPLY_ACTION = 0x80040202,
}

// Callbacks

alias PVECTORED_EXCEPTION_HANDLER = int function(EXCEPTION_POINTERS* ExceptionInfo);
alias PTOP_LEVEL_EXCEPTION_FILTER = int function(EXCEPTION_POINTERS* ExceptionInfo);
alias LPTOP_LEVEL_EXCEPTION_FILTER = int function();
alias PWAITCHAINCALLBACK = void function(void* WctHandle, size_t Context, uint CallbackStatus, uint* NodeCount, 
                                         WAITCHAIN_NODE_INFO* NodeInfoArray, int* IsCycle);
alias PCOGETCALLSTATE = HRESULT function(int param0, uint* param1);
alias PCOGETACTIVATIONSTATE = HRESULT function(GUID param0, uint param1, uint* param2);
alias MINIDUMP_CALLBACK_ROUTINE = BOOL function(void* CallbackParam, MINIDUMP_CALLBACK_INPUT* CallbackInput, 
                                                MINIDUMP_CALLBACK_OUTPUT* CallbackOutput);
alias RegisterAuthoringClientFunctionType = HRESULT function(IWebApplicationAuthoringMode authoringModeObject, 
                                                             IWebApplicationHost host);
alias UnregisterAuthoringClientFunctionType = HRESULT function(IWebApplicationHost host);

// Structs


struct CONTEXT
{
    uint               ContextFlags;
    uint               Dr0;
    uint               Dr1;
    uint               Dr2;
    uint               Dr3;
    uint               Dr6;
    uint               Dr7;
    FLOATING_SAVE_AREA FloatSave;
    uint               SegGs;
    uint               SegFs;
    uint               SegEs;
    uint               SegDs;
    uint               Edi;
    uint               Esi;
    uint               Ebx;
    uint               Edx;
    uint               Ecx;
    uint               Eax;
    uint               Ebp;
    uint               Eip;
    uint               SegCs;
    uint               EFlags;
    uint               Esp;
    uint               SegSs;
    ubyte[512]         ExtendedRegisters;
}

struct LDT_ENTRY
{
    ushort LimitLow;
    ushort BaseLow;
    union HighWord
    {
        struct Bytes
        {
            ubyte BaseMid;
            ubyte Flags1;
            ubyte Flags2;
            ubyte BaseHi;
        }
        struct Bits
        {
            uint _bitfield9;
        }
    }
}

struct WOW64_FLOATING_SAVE_AREA
{
    uint      ControlWord;
    uint      StatusWord;
    uint      TagWord;
    uint      ErrorOffset;
    uint      ErrorSelector;
    uint      DataOffset;
    uint      DataSelector;
    ubyte[80] RegisterArea;
    uint      Cr0NpxState;
}

struct WOW64_CONTEXT
{
    uint       ContextFlags;
    uint       Dr0;
    uint       Dr1;
    uint       Dr2;
    uint       Dr3;
    uint       Dr6;
    uint       Dr7;
    WOW64_FLOATING_SAVE_AREA FloatSave;
    uint       SegGs;
    uint       SegFs;
    uint       SegEs;
    uint       SegDs;
    uint       Edi;
    uint       Esi;
    uint       Ebx;
    uint       Edx;
    uint       Ecx;
    uint       Eax;
    uint       Ebp;
    uint       Eip;
    uint       SegCs;
    uint       EFlags;
    uint       Esp;
    uint       SegSs;
    ubyte[512] ExtendedRegisters;
}

struct WOW64_LDT_ENTRY
{
    ushort LimitLow;
    ushort BaseLow;
    union HighWord
    {
        struct Bytes
        {
            ubyte BaseMid;
            ubyte Flags1;
            ubyte Flags2;
            ubyte BaseHi;
        }
        struct Bits
        {
            uint _bitfield10;
        }
    }
}

struct EXCEPTION_RECORD
{
    uint              ExceptionCode;
    uint              ExceptionFlags;
    EXCEPTION_RECORD* ExceptionRecord;
    void*             ExceptionAddress;
    uint              NumberParameters;
    size_t[15]        ExceptionInformation;
}

struct EXCEPTION_RECORD64
{
    uint      ExceptionCode;
    uint      ExceptionFlags;
    ulong     ExceptionRecord;
    ulong     ExceptionAddress;
    uint      NumberParameters;
    uint      __unusedAlignment;
    ulong[15] ExceptionInformation;
}

struct EXCEPTION_POINTERS
{
    EXCEPTION_RECORD* ExceptionRecord;
    CONTEXT*          ContextRecord;
}

struct IMAGE_FILE_HEADER
{
    ushort Machine;
    ushort NumberOfSections;
    uint   TimeDateStamp;
    uint   PointerToSymbolTable;
    uint   NumberOfSymbols;
    ushort SizeOfOptionalHeader;
    ushort Characteristics;
}

struct IMAGE_DATA_DIRECTORY
{
    uint VirtualAddress;
    uint Size;
}

struct IMAGE_OPTIONAL_HEADER64
{
align (4):
    ushort Magic;
    ubyte  MajorLinkerVersion;
    ubyte  MinorLinkerVersion;
    uint   SizeOfCode;
    uint   SizeOfInitializedData;
    uint   SizeOfUninitializedData;
    uint   AddressOfEntryPoint;
    uint   BaseOfCode;
    ulong  ImageBase;
    uint   SectionAlignment;
    uint   FileAlignment;
    ushort MajorOperatingSystemVersion;
    ushort MinorOperatingSystemVersion;
    ushort MajorImageVersion;
    ushort MinorImageVersion;
    ushort MajorSubsystemVersion;
    ushort MinorSubsystemVersion;
    uint   Win32VersionValue;
    uint   SizeOfImage;
    uint   SizeOfHeaders;
    uint   CheckSum;
    ushort Subsystem;
    ushort DllCharacteristics;
    ulong  SizeOfStackReserve;
    ulong  SizeOfStackCommit;
    ulong  SizeOfHeapReserve;
    ulong  SizeOfHeapCommit;
    uint   LoaderFlags;
    uint   NumberOfRvaAndSizes;
    IMAGE_DATA_DIRECTORY[16] DataDirectory;
}

struct IMAGE_NT_HEADERS64
{
    uint              Signature;
    IMAGE_FILE_HEADER FileHeader;
    IMAGE_OPTIONAL_HEADER64 OptionalHeader;
}

struct IMAGE_SECTION_HEADER
{
    ubyte[8] Name;
    union Misc
    {
        uint PhysicalAddress;
        uint VirtualSize;
    }
    uint     VirtualAddress;
    uint     SizeOfRawData;
    uint     PointerToRawData;
    uint     PointerToRelocations;
    uint     PointerToLinenumbers;
    ushort   NumberOfRelocations;
    ushort   NumberOfLinenumbers;
    uint     Characteristics;
}

struct IMAGE_LOAD_CONFIG_DIRECTORY32
{
    uint   Size;
    uint   TimeDateStamp;
    ushort MajorVersion;
    ushort MinorVersion;
    uint   GlobalFlagsClear;
    uint   GlobalFlagsSet;
    uint   CriticalSectionDefaultTimeout;
    uint   DeCommitFreeBlockThreshold;
    uint   DeCommitTotalFreeThreshold;
    uint   LockPrefixTable;
    uint   MaximumAllocationSize;
    uint   VirtualMemoryThreshold;
    uint   ProcessHeapFlags;
    uint   ProcessAffinityMask;
    ushort CSDVersion;
    ushort DependentLoadFlags;
    uint   EditList;
    uint   SecurityCookie;
    uint   SEHandlerTable;
    uint   SEHandlerCount;
    uint   GuardCFCheckFunctionPointer;
    uint   GuardCFDispatchFunctionPointer;
    uint   GuardCFFunctionTable;
    uint   GuardCFFunctionCount;
    uint   GuardFlags;
    IMAGE_LOAD_CONFIG_CODE_INTEGRITY CodeIntegrity;
    uint   GuardAddressTakenIatEntryTable;
    uint   GuardAddressTakenIatEntryCount;
    uint   GuardLongJumpTargetTable;
    uint   GuardLongJumpTargetCount;
    uint   DynamicValueRelocTable;
    uint   CHPEMetadataPointer;
    uint   GuardRFFailureRoutine;
    uint   GuardRFFailureRoutineFunctionPointer;
    uint   DynamicValueRelocTableOffset;
    ushort DynamicValueRelocTableSection;
    ushort Reserved2;
    uint   GuardRFVerifyStackPointerFunctionPointer;
    uint   HotPatchTableOffset;
    uint   Reserved3;
    uint   EnclaveConfigurationPointer;
    uint   VolatileMetadataPointer;
    uint   GuardEHContinuationTable;
    uint   GuardEHContinuationCount;
}

struct IMAGE_LOAD_CONFIG_DIRECTORY64
{
align (4):
    uint   Size;
    uint   TimeDateStamp;
    ushort MajorVersion;
    ushort MinorVersion;
    uint   GlobalFlagsClear;
    uint   GlobalFlagsSet;
    uint   CriticalSectionDefaultTimeout;
    ulong  DeCommitFreeBlockThreshold;
    ulong  DeCommitTotalFreeThreshold;
    ulong  LockPrefixTable;
    ulong  MaximumAllocationSize;
    ulong  VirtualMemoryThreshold;
    ulong  ProcessAffinityMask;
    uint   ProcessHeapFlags;
    ushort CSDVersion;
    ushort DependentLoadFlags;
    ulong  EditList;
    ulong  SecurityCookie;
    ulong  SEHandlerTable;
    ulong  SEHandlerCount;
    ulong  GuardCFCheckFunctionPointer;
    ulong  GuardCFDispatchFunctionPointer;
    ulong  GuardCFFunctionTable;
    ulong  GuardCFFunctionCount;
    uint   GuardFlags;
    IMAGE_LOAD_CONFIG_CODE_INTEGRITY CodeIntegrity;
    ulong  GuardAddressTakenIatEntryTable;
    ulong  GuardAddressTakenIatEntryCount;
    ulong  GuardLongJumpTargetTable;
    ulong  GuardLongJumpTargetCount;
    ulong  DynamicValueRelocTable;
    ulong  CHPEMetadataPointer;
    ulong  GuardRFFailureRoutine;
    ulong  GuardRFFailureRoutineFunctionPointer;
    uint   DynamicValueRelocTableOffset;
    ushort DynamicValueRelocTableSection;
    ushort Reserved2;
    ulong  GuardRFVerifyStackPointerFunctionPointer;
    uint   HotPatchTableOffset;
    uint   Reserved3;
    ulong  EnclaveConfigurationPointer;
    ulong  VolatileMetadataPointer;
    ulong  GuardEHContinuationTable;
    ulong  GuardEHContinuationCount;
}

struct IMAGE_DEBUG_DIRECTORY
{
    uint   Characteristics;
    uint   TimeDateStamp;
    ushort MajorVersion;
    ushort MinorVersion;
    uint   Type;
    uint   SizeOfData;
    uint   AddressOfRawData;
    uint   PointerToRawData;
}

struct IMAGE_COFF_SYMBOLS_HEADER
{
    uint NumberOfSymbols;
    uint LvaToFirstSymbol;
    uint NumberOfLinenumbers;
    uint LvaToFirstLinenumber;
    uint RvaToFirstByteOfCode;
    uint RvaToLastByteOfCode;
    uint RvaToFirstByteOfData;
    uint RvaToLastByteOfData;
}

struct FPO_DATA
{
    uint   ulOffStart;
    uint   cbProcSize;
    uint   cdwLocals;
    ushort cdwParams;
    ushort _bitfield11;
}

struct IMAGE_FUNCTION_ENTRY
{
    uint StartingAddress;
    uint EndingAddress;
    uint EndOfPrologue;
}

struct IMAGE_FUNCTION_ENTRY64
{
align (4):
    ulong StartingAddress;
    ulong EndingAddress;
    union
    {
    align (4):
        ulong EndOfPrologue;
        ulong UnwindInfoAddress;
    }
}

struct EXCEPTION_DEBUG_INFO
{
    EXCEPTION_RECORD ExceptionRecord;
    uint             dwFirstChance;
}

struct CREATE_THREAD_DEBUG_INFO
{
    HANDLE hThread;
    void*  lpThreadLocalBase;
    LPTHREAD_START_ROUTINE lpStartAddress;
}

struct CREATE_PROCESS_DEBUG_INFO
{
    HANDLE hFile;
    HANDLE hProcess;
    HANDLE hThread;
    void*  lpBaseOfImage;
    uint   dwDebugInfoFileOffset;
    uint   nDebugInfoSize;
    void*  lpThreadLocalBase;
    LPTHREAD_START_ROUTINE lpStartAddress;
    void*  lpImageName;
    ushort fUnicode;
}

struct EXIT_THREAD_DEBUG_INFO
{
    uint dwExitCode;
}

struct EXIT_PROCESS_DEBUG_INFO
{
    uint dwExitCode;
}

struct LOAD_DLL_DEBUG_INFO
{
    HANDLE hFile;
    void*  lpBaseOfDll;
    uint   dwDebugInfoFileOffset;
    uint   nDebugInfoSize;
    void*  lpImageName;
    ushort fUnicode;
}

struct UNLOAD_DLL_DEBUG_INFO
{
    void* lpBaseOfDll;
}

struct OUTPUT_DEBUG_STRING_INFO
{
    const(char)* lpDebugStringData;
    ushort       fUnicode;
    ushort       nDebugStringLength;
}

struct RIP_INFO
{
    uint dwError;
    uint dwType;
}

struct DEBUG_EVENT
{
    uint dwDebugEventCode;
    uint dwProcessId;
    uint dwThreadId;
    union u
    {
        EXCEPTION_DEBUG_INFO Exception;
        CREATE_THREAD_DEBUG_INFO CreateThread;
        CREATE_PROCESS_DEBUG_INFO CreateProcessInfo;
        EXIT_THREAD_DEBUG_INFO ExitThread;
        EXIT_PROCESS_DEBUG_INFO ExitProcess;
        LOAD_DLL_DEBUG_INFO  LoadDll;
        UNLOAD_DLL_DEBUG_INFO UnloadDll;
        OUTPUT_DEBUG_STRING_INFO DebugString;
        RIP_INFO             RipInfo;
    }
}

struct FLASHWINFO
{
    uint cbSize;
    HWND hwnd;
    uint dwFlags;
    uint uCount;
    uint dwTimeout;
}

struct WAITCHAIN_NODE_INFO
{
    WCT_OBJECT_TYPE   ObjectType;
    WCT_OBJECT_STATUS ObjectStatus;
    union
    {
        struct LockObject
        {
            ushort[128]   ObjectName;
            LARGE_INTEGER Timeout;
            BOOL          Alertable;
        }
        struct ThreadObject
        {
            uint ProcessId;
            uint ThreadId;
            uint WaitTime;
            uint ContextSwitches;
        }
    }
}

struct MINIDUMP_LOCATION_DESCRIPTOR
{
    uint DataSize;
    uint Rva;
}

struct MINIDUMP_LOCATION_DESCRIPTOR64
{
align (4):
    ulong DataSize;
    ulong Rva;
}

struct MINIDUMP_MEMORY_DESCRIPTOR
{
align (4):
    ulong StartOfMemoryRange;
    MINIDUMP_LOCATION_DESCRIPTOR Memory;
}

struct MINIDUMP_MEMORY_DESCRIPTOR64
{
align (4):
    ulong StartOfMemoryRange;
    ulong DataSize;
}

struct MINIDUMP_HEADER
{
align (4):
    uint  Signature;
    uint  Version;
    uint  NumberOfStreams;
    uint  StreamDirectoryRva;
    uint  CheckSum;
    union
    {
        uint Reserved;
        uint TimeDateStamp;
    }
    ulong Flags;
}

struct MINIDUMP_DIRECTORY
{
    uint StreamType;
    MINIDUMP_LOCATION_DESCRIPTOR Location;
}

struct MINIDUMP_STRING
{
    uint      Length;
    ushort[1] Buffer;
}

union CPU_INFORMATION
{
    struct X86CpuInfo
    {
        uint[3] VendorId;
        uint    VersionInformation;
        uint    FeatureInformation;
        uint    AMDExtendedCpuFeatures;
    }
    struct OtherCpuInfo
    {
    align (4):
        ulong[2] ProcessorFeatures;
    }
}

struct MINIDUMP_SYSTEM_INFO
{
    ushort          ProcessorArchitecture;
    ushort          ProcessorLevel;
    ushort          ProcessorRevision;
    union
    {
        ushort Reserved0;
        struct
        {
            ubyte NumberOfProcessors;
            ubyte ProductType;
        }
    }
    uint            MajorVersion;
    uint            MinorVersion;
    uint            BuildNumber;
    uint            PlatformId;
    uint            CSDVersionRva;
    union
    {
        uint Reserved1;
        struct
        {
            ushort SuiteMask;
            ushort Reserved2;
        }
    }
    CPU_INFORMATION Cpu;
}

struct MINIDUMP_THREAD
{
align (4):
    uint  ThreadId;
    uint  SuspendCount;
    uint  PriorityClass;
    uint  Priority;
    ulong Teb;
    MINIDUMP_MEMORY_DESCRIPTOR Stack;
    MINIDUMP_LOCATION_DESCRIPTOR ThreadContext;
}

struct MINIDUMP_THREAD_LIST
{
    uint               NumberOfThreads;
    MINIDUMP_THREAD[1] Threads;
}

struct MINIDUMP_THREAD_EX
{
align (4):
    uint  ThreadId;
    uint  SuspendCount;
    uint  PriorityClass;
    uint  Priority;
    ulong Teb;
    MINIDUMP_MEMORY_DESCRIPTOR Stack;
    MINIDUMP_LOCATION_DESCRIPTOR ThreadContext;
    MINIDUMP_MEMORY_DESCRIPTOR BackingStore;
}

struct MINIDUMP_THREAD_EX_LIST
{
    uint NumberOfThreads;
    MINIDUMP_THREAD_EX[1] Threads;
}

struct MINIDUMP_EXCEPTION
{
align (4):
    uint      ExceptionCode;
    uint      ExceptionFlags;
    ulong     ExceptionRecord;
    ulong     ExceptionAddress;
    uint      NumberParameters;
    uint      __unusedAlignment;
    ulong[15] ExceptionInformation;
}

struct MINIDUMP_EXCEPTION_STREAM
{
    uint               ThreadId;
    uint               __alignment;
    MINIDUMP_EXCEPTION ExceptionRecord;
    MINIDUMP_LOCATION_DESCRIPTOR ThreadContext;
}

struct MINIDUMP_MODULE
{
align (4):
    ulong            BaseOfImage;
    uint             SizeOfImage;
    uint             CheckSum;
    uint             TimeDateStamp;
    uint             ModuleNameRva;
    VS_FIXEDFILEINFO VersionInfo;
    MINIDUMP_LOCATION_DESCRIPTOR CvRecord;
    MINIDUMP_LOCATION_DESCRIPTOR MiscRecord;
    ulong            Reserved0;
    ulong            Reserved1;
}

struct MINIDUMP_MODULE_LIST
{
    uint               NumberOfModules;
    MINIDUMP_MODULE[1] Modules;
}

struct MINIDUMP_MEMORY_LIST
{
    uint NumberOfMemoryRanges;
    MINIDUMP_MEMORY_DESCRIPTOR[1] MemoryRanges;
}

struct MINIDUMP_MEMORY64_LIST
{
align (4):
    ulong NumberOfMemoryRanges;
    ulong BaseRva;
    MINIDUMP_MEMORY_DESCRIPTOR64[1] MemoryRanges;
}

struct MINIDUMP_EXCEPTION_INFORMATION
{
    uint                ThreadId;
    EXCEPTION_POINTERS* ExceptionPointers;
    BOOL                ClientPointers;
}

struct MINIDUMP_EXCEPTION_INFORMATION64
{
align (4):
    uint  ThreadId;
    ulong ExceptionRecord;
    ulong ContextRecord;
    BOOL  ClientPointers;
}

struct MINIDUMP_HANDLE_OBJECT_INFORMATION
{
    uint NextInfoRva;
    uint InfoType;
    uint SizeOfInfo;
}

struct MINIDUMP_HANDLE_DESCRIPTOR
{
align (4):
    ulong Handle;
    uint  TypeNameRva;
    uint  ObjectNameRva;
    uint  Attributes;
    uint  GrantedAccess;
    uint  HandleCount;
    uint  PointerCount;
}

struct MINIDUMP_HANDLE_DESCRIPTOR_2
{
align (4):
    ulong Handle;
    uint  TypeNameRva;
    uint  ObjectNameRva;
    uint  Attributes;
    uint  GrantedAccess;
    uint  HandleCount;
    uint  PointerCount;
    uint  ObjectInfoRva;
    uint  Reserved0;
}

struct MINIDUMP_HANDLE_DATA_STREAM
{
    uint SizeOfHeader;
    uint SizeOfDescriptor;
    uint NumberOfDescriptors;
    uint Reserved;
}

struct MINIDUMP_HANDLE_OPERATION_LIST
{
    uint SizeOfHeader;
    uint SizeOfEntry;
    uint NumberOfEntries;
    uint Reserved;
}

struct MINIDUMP_FUNCTION_TABLE_DESCRIPTOR
{
align (4):
    ulong MinimumAddress;
    ulong MaximumAddress;
    ulong BaseAddress;
    uint  EntryCount;
    uint  SizeOfAlignPad;
}

struct MINIDUMP_FUNCTION_TABLE_STREAM
{
    uint SizeOfHeader;
    uint SizeOfDescriptor;
    uint SizeOfNativeDescriptor;
    uint SizeOfFunctionEntry;
    uint NumberOfDescriptors;
    uint SizeOfAlignPad;
}

struct MINIDUMP_UNLOADED_MODULE
{
align (4):
    ulong BaseOfImage;
    uint  SizeOfImage;
    uint  CheckSum;
    uint  TimeDateStamp;
    uint  ModuleNameRva;
}

struct MINIDUMP_UNLOADED_MODULE_LIST
{
    uint SizeOfHeader;
    uint SizeOfEntry;
    uint NumberOfEntries;
}

struct XSTATE_CONFIG_FEATURE_MSC_INFO
{
align (4):
    uint               SizeOfInfo;
    uint               ContextSize;
    ulong              EnabledFeatures;
    XSTATE_FEATURE[64] Features;
}

struct MINIDUMP_MISC_INFO
{
    uint SizeOfInfo;
    uint Flags1;
    uint ProcessId;
    uint ProcessCreateTime;
    uint ProcessUserTime;
    uint ProcessKernelTime;
}

struct MINIDUMP_MISC_INFO_2
{
    uint SizeOfInfo;
    uint Flags1;
    uint ProcessId;
    uint ProcessCreateTime;
    uint ProcessUserTime;
    uint ProcessKernelTime;
    uint ProcessorMaxMhz;
    uint ProcessorCurrentMhz;
    uint ProcessorMhzLimit;
    uint ProcessorMaxIdleState;
    uint ProcessorCurrentIdleState;
}

struct MINIDUMP_MISC_INFO_3
{
    uint SizeOfInfo;
    uint Flags1;
    uint ProcessId;
    uint ProcessCreateTime;
    uint ProcessUserTime;
    uint ProcessKernelTime;
    uint ProcessorMaxMhz;
    uint ProcessorCurrentMhz;
    uint ProcessorMhzLimit;
    uint ProcessorMaxIdleState;
    uint ProcessorCurrentIdleState;
    uint ProcessIntegrityLevel;
    uint ProcessExecuteFlags;
    uint ProtectedProcess;
    uint TimeZoneId;
    TIME_ZONE_INFORMATION TimeZone;
}

struct MINIDUMP_MISC_INFO_4
{
    uint        SizeOfInfo;
    uint        Flags1;
    uint        ProcessId;
    uint        ProcessCreateTime;
    uint        ProcessUserTime;
    uint        ProcessKernelTime;
    uint        ProcessorMaxMhz;
    uint        ProcessorCurrentMhz;
    uint        ProcessorMhzLimit;
    uint        ProcessorMaxIdleState;
    uint        ProcessorCurrentIdleState;
    uint        ProcessIntegrityLevel;
    uint        ProcessExecuteFlags;
    uint        ProtectedProcess;
    uint        TimeZoneId;
    TIME_ZONE_INFORMATION TimeZone;
    ushort[260] BuildString;
    ushort[40]  DbgBldStr;
}

struct MINIDUMP_MISC_INFO_5
{
    uint        SizeOfInfo;
    uint        Flags1;
    uint        ProcessId;
    uint        ProcessCreateTime;
    uint        ProcessUserTime;
    uint        ProcessKernelTime;
    uint        ProcessorMaxMhz;
    uint        ProcessorCurrentMhz;
    uint        ProcessorMhzLimit;
    uint        ProcessorMaxIdleState;
    uint        ProcessorCurrentIdleState;
    uint        ProcessIntegrityLevel;
    uint        ProcessExecuteFlags;
    uint        ProtectedProcess;
    uint        TimeZoneId;
    TIME_ZONE_INFORMATION TimeZone;
    ushort[260] BuildString;
    ushort[40]  DbgBldStr;
    XSTATE_CONFIG_FEATURE_MSC_INFO XStateData;
    uint        ProcessCookie;
}

struct MINIDUMP_MEMORY_INFO
{
align (4):
    ulong BaseAddress;
    ulong AllocationBase;
    uint  AllocationProtect;
    uint  __alignment1;
    ulong RegionSize;
    uint  State;
    uint  Protect;
    uint  Type;
    uint  __alignment2;
}

struct MINIDUMP_MEMORY_INFO_LIST
{
align (4):
    uint  SizeOfHeader;
    uint  SizeOfEntry;
    ulong NumberOfEntries;
}

struct MINIDUMP_THREAD_NAME
{
align (4):
    uint  ThreadId;
    ulong RvaOfThreadName;
}

struct MINIDUMP_THREAD_NAME_LIST
{
    uint NumberOfThreadNames;
    MINIDUMP_THREAD_NAME[1] ThreadNames;
}

struct MINIDUMP_THREAD_INFO
{
align (4):
    uint  ThreadId;
    uint  DumpFlags;
    uint  DumpError;
    uint  ExitStatus;
    ulong CreateTime;
    ulong ExitTime;
    ulong KernelTime;
    ulong UserTime;
    ulong StartAddress;
    ulong Affinity;
}

struct MINIDUMP_THREAD_INFO_LIST
{
    uint SizeOfHeader;
    uint SizeOfEntry;
    uint NumberOfEntries;
}

struct MINIDUMP_TOKEN_INFO_HEADER
{
align (4):
    uint  TokenSize;
    uint  TokenId;
    ulong TokenHandle;
}

struct MINIDUMP_TOKEN_INFO_LIST
{
    uint TokenListSize;
    uint TokenListEntries;
    uint ListHeaderSize;
    uint ElementHeaderSize;
}

struct MINIDUMP_SYSTEM_BASIC_INFORMATION
{
align (4):
    uint  TimerResolution;
    uint  PageSize;
    uint  NumberOfPhysicalPages;
    uint  LowestPhysicalPageNumber;
    uint  HighestPhysicalPageNumber;
    uint  AllocationGranularity;
    ulong MinimumUserModeAddress;
    ulong MaximumUserModeAddress;
    ulong ActiveProcessorsAffinityMask;
    uint  NumberOfProcessors;
}

struct MINIDUMP_SYSTEM_FILECACHE_INFORMATION
{
align (4):
    ulong CurrentSize;
    ulong PeakSize;
    uint  PageFaultCount;
    ulong MinimumWorkingSet;
    ulong MaximumWorkingSet;
    ulong CurrentSizeIncludingTransitionInPages;
    ulong PeakSizeIncludingTransitionInPages;
    uint  TransitionRePurposeCount;
    uint  Flags;
}

struct MINIDUMP_SYSTEM_BASIC_PERFORMANCE_INFORMATION
{
align (4):
    ulong AvailablePages;
    ulong CommittedPages;
    ulong CommitLimit;
    ulong PeakCommitment;
}

struct MINIDUMP_SYSTEM_PERFORMANCE_INFORMATION
{
align (4):
    ulong IdleProcessTime;
    ulong IoReadTransferCount;
    ulong IoWriteTransferCount;
    ulong IoOtherTransferCount;
    uint  IoReadOperationCount;
    uint  IoWriteOperationCount;
    uint  IoOtherOperationCount;
    uint  AvailablePages;
    uint  CommittedPages;
    uint  CommitLimit;
    uint  PeakCommitment;
    uint  PageFaultCount;
    uint  CopyOnWriteCount;
    uint  TransitionCount;
    uint  CacheTransitionCount;
    uint  DemandZeroCount;
    uint  PageReadCount;
    uint  PageReadIoCount;
    uint  CacheReadCount;
    uint  CacheIoCount;
    uint  DirtyPagesWriteCount;
    uint  DirtyWriteIoCount;
    uint  MappedPagesWriteCount;
    uint  MappedWriteIoCount;
    uint  PagedPoolPages;
    uint  NonPagedPoolPages;
    uint  PagedPoolAllocs;
    uint  PagedPoolFrees;
    uint  NonPagedPoolAllocs;
    uint  NonPagedPoolFrees;
    uint  FreeSystemPtes;
    uint  ResidentSystemCodePage;
    uint  TotalSystemDriverPages;
    uint  TotalSystemCodePages;
    uint  NonPagedPoolLookasideHits;
    uint  PagedPoolLookasideHits;
    uint  AvailablePagedPoolPages;
    uint  ResidentSystemCachePage;
    uint  ResidentPagedPoolPage;
    uint  ResidentSystemDriverPage;
    uint  CcFastReadNoWait;
    uint  CcFastReadWait;
    uint  CcFastReadResourceMiss;
    uint  CcFastReadNotPossible;
    uint  CcFastMdlReadNoWait;
    uint  CcFastMdlReadWait;
    uint  CcFastMdlReadResourceMiss;
    uint  CcFastMdlReadNotPossible;
    uint  CcMapDataNoWait;
    uint  CcMapDataWait;
    uint  CcMapDataNoWaitMiss;
    uint  CcMapDataWaitMiss;
    uint  CcPinMappedDataCount;
    uint  CcPinReadNoWait;
    uint  CcPinReadWait;
    uint  CcPinReadNoWaitMiss;
    uint  CcPinReadWaitMiss;
    uint  CcCopyReadNoWait;
    uint  CcCopyReadWait;
    uint  CcCopyReadNoWaitMiss;
    uint  CcCopyReadWaitMiss;
    uint  CcMdlReadNoWait;
    uint  CcMdlReadWait;
    uint  CcMdlReadNoWaitMiss;
    uint  CcMdlReadWaitMiss;
    uint  CcReadAheadIos;
    uint  CcLazyWriteIos;
    uint  CcLazyWritePages;
    uint  CcDataFlushes;
    uint  CcDataPages;
    uint  ContextSwitches;
    uint  FirstLevelTbFills;
    uint  SecondLevelTbFills;
    uint  SystemCalls;
    ulong CcTotalDirtyPages;
    ulong CcDirtyPageThreshold;
    long  ResidentAvailablePages;
    ulong SharedCommittedPages;
}

struct MINIDUMP_SYSTEM_MEMORY_INFO_1
{
    ushort Revision;
    ushort Flags;
    MINIDUMP_SYSTEM_BASIC_INFORMATION BasicInfo;
    MINIDUMP_SYSTEM_FILECACHE_INFORMATION FileCacheInfo;
    MINIDUMP_SYSTEM_BASIC_PERFORMANCE_INFORMATION BasicPerfInfo;
    MINIDUMP_SYSTEM_PERFORMANCE_INFORMATION PerfInfo;
}

struct MINIDUMP_PROCESS_VM_COUNTERS_1
{
align (4):
    ushort Revision;
    uint   PageFaultCount;
    ulong  PeakWorkingSetSize;
    ulong  WorkingSetSize;
    ulong  QuotaPeakPagedPoolUsage;
    ulong  QuotaPagedPoolUsage;
    ulong  QuotaPeakNonPagedPoolUsage;
    ulong  QuotaNonPagedPoolUsage;
    ulong  PagefileUsage;
    ulong  PeakPagefileUsage;
    ulong  PrivateUsage;
}

struct MINIDUMP_PROCESS_VM_COUNTERS_2
{
align (4):
    ushort Revision;
    ushort Flags;
    uint   PageFaultCount;
    ulong  PeakWorkingSetSize;
    ulong  WorkingSetSize;
    ulong  QuotaPeakPagedPoolUsage;
    ulong  QuotaPagedPoolUsage;
    ulong  QuotaPeakNonPagedPoolUsage;
    ulong  QuotaNonPagedPoolUsage;
    ulong  PagefileUsage;
    ulong  PeakPagefileUsage;
    ulong  PeakVirtualSize;
    ulong  VirtualSize;
    ulong  PrivateUsage;
    ulong  PrivateWorkingSetSize;
    ulong  SharedCommitUsage;
    ulong  JobSharedCommitUsage;
    ulong  JobPrivateCommitUsage;
    ulong  JobPeakPrivateCommitUsage;
    ulong  JobPrivateCommitLimit;
    ulong  JobTotalCommitLimit;
}

struct MINIDUMP_USER_RECORD
{
    uint Type;
    MINIDUMP_LOCATION_DESCRIPTOR Memory;
}

struct MINIDUMP_USER_STREAM
{
    uint  Type;
    uint  BufferSize;
    void* Buffer;
}

struct MINIDUMP_USER_STREAM_INFORMATION
{
    uint UserStreamCount;
    MINIDUMP_USER_STREAM* UserStreamArray;
}

struct MINIDUMP_THREAD_CALLBACK
{
align (4):
    uint    ThreadId;
    HANDLE  ThreadHandle;
    CONTEXT Context;
    uint    SizeOfContext;
    ulong   StackBase;
    ulong   StackEnd;
}

struct MINIDUMP_THREAD_EX_CALLBACK
{
align (4):
    uint    ThreadId;
    HANDLE  ThreadHandle;
    CONTEXT Context;
    uint    SizeOfContext;
    ulong   StackBase;
    ulong   StackEnd;
    ulong   BackingStoreBase;
    ulong   BackingStoreEnd;
}

struct MINIDUMP_INCLUDE_THREAD_CALLBACK
{
    uint ThreadId;
}

struct MINIDUMP_MODULE_CALLBACK
{
align (4):
    const(wchar)*    FullPath;
    ulong            BaseOfImage;
    uint             SizeOfImage;
    uint             CheckSum;
    uint             TimeDateStamp;
    VS_FIXEDFILEINFO VersionInfo;
    void*            CvRecord;
    uint             SizeOfCvRecord;
    void*            MiscRecord;
    uint             SizeOfMiscRecord;
}

struct MINIDUMP_INCLUDE_MODULE_CALLBACK
{
align (4):
    ulong BaseOfImage;
}

struct MINIDUMP_IO_CALLBACK
{
align (4):
    HANDLE Handle;
    ulong  Offset;
    void*  Buffer;
    uint   BufferBytes;
}

struct MINIDUMP_READ_MEMORY_FAILURE_CALLBACK
{
align (4):
    ulong   Offset;
    uint    Bytes;
    HRESULT FailureStatus;
}

struct MINIDUMP_VM_QUERY_CALLBACK
{
align (4):
    ulong Offset;
}

struct MINIDUMP_VM_PRE_READ_CALLBACK
{
align (4):
    ulong Offset;
    void* Buffer;
    uint  Size;
}

struct MINIDUMP_VM_POST_READ_CALLBACK
{
align (4):
    ulong   Offset;
    void*   Buffer;
    uint    Size;
    uint    Completed;
    HRESULT Status;
}

struct MINIDUMP_CALLBACK_INPUT
{
    uint   ProcessId;
    HANDLE ProcessHandle;
    uint   CallbackType;
    union
    {
        HRESULT              Status;
        MINIDUMP_THREAD_CALLBACK Thread;
        MINIDUMP_THREAD_EX_CALLBACK ThreadEx;
        MINIDUMP_MODULE_CALLBACK Module;
        MINIDUMP_INCLUDE_THREAD_CALLBACK IncludeThread;
        MINIDUMP_INCLUDE_MODULE_CALLBACK IncludeModule;
        MINIDUMP_IO_CALLBACK Io;
        MINIDUMP_READ_MEMORY_FAILURE_CALLBACK ReadMemoryFailure;
        uint                 SecondaryFlags;
        MINIDUMP_VM_QUERY_CALLBACK VmQuery;
        MINIDUMP_VM_PRE_READ_CALLBACK VmPreRead;
        MINIDUMP_VM_POST_READ_CALLBACK VmPostRead;
    }
}

struct MINIDUMP_CALLBACK_OUTPUT
{
    union
    {
        uint    ModuleWriteFlags;
        uint    ThreadWriteFlags;
        uint    SecondaryFlags;
        struct
        {
        align (4):
            ulong MemoryBase;
            uint  MemorySize;
        }
        struct
        {
            BOOL CheckCancel;
            BOOL Cancel;
        }
        HANDLE  Handle;
        struct
        {
            MINIDUMP_MEMORY_INFO VmRegion;
            BOOL                 Continue;
        }
        struct
        {
            HRESULT              VmQueryStatus;
            MINIDUMP_MEMORY_INFO VmQueryResult;
        }
        struct
        {
            HRESULT VmReadStatus;
            uint    VmReadBytesCompleted;
        }
        HRESULT Status;
    }
}

struct MINIDUMP_CALLBACK_INFORMATION
{
    MINIDUMP_CALLBACK_ROUTINE CallbackRoutine;
    void* CallbackParam;
}

struct DebugPropertyInfo
{
    uint           m_dwValidFields;
    BSTR           m_bstrName;
    BSTR           m_bstrType;
    BSTR           m_bstrValue;
    BSTR           m_bstrFullName;
    uint           m_dwAttrib;
    IDebugProperty m_pDebugProp;
}

struct ExtendedDebugPropertyInfo
{
    uint           dwValidFields;
    ushort*        pszName;
    ushort*        pszType;
    ushort*        pszValue;
    ushort*        pszFullName;
    uint           dwAttrib;
    IDebugProperty pDebugProp;
    uint           nDISPID;
    uint           nType;
    VARIANT        varValue;
    ILockBytes     plbValue;
    IDebugExtendedProperty pDebugExtProp;
}

struct DebugStackFrameDescriptor
{
    IDebugStackFrame pdsf;
    uint             dwMin;
    uint             dwLim;
    BOOL             fFinal;
    IUnknown         punkFinal;
}

struct DebugStackFrameDescriptor64
{
    IDebugStackFrame pdsf;
    ulong            dwMin;
    ulong            dwLim;
    BOOL             fFinal;
    IUnknown         punkFinal;
}

struct PROFILER_HEAP_OBJECT_SCOPE_LIST
{
    uint      count;
    size_t[1] scopes;
}

struct PROFILER_PROPERTY_TYPE_SUBSTRING_INFO
{
    uint          length;
    const(wchar)* value;
}

struct PROFILER_HEAP_OBJECT_RELATIONSHIP
{
    uint relationshipId;
    __MIDL___MIDL_itf_activprof_0000_0002_0005 relationshipInfo;
    union
    {
        double        numberValue;
        const(wchar)* stringValue;
        BSTR          bstrValue;
        size_t        objectId;
        void*         externalObjectAddress;
        PROFILER_PROPERTY_TYPE_SUBSTRING_INFO* subString;
    }
}

struct PROFILER_HEAP_OBJECT_RELATIONSHIP_LIST
{
    uint count;
    PROFILER_HEAP_OBJECT_RELATIONSHIP[1] elements;
}

struct PROFILER_HEAP_OBJECT_OPTIONAL_INFO
{
    __MIDL___MIDL_itf_activprof_0000_0002_0002 infoType;
    union
    {
        size_t        prototype;
        const(wchar)* functionName;
        uint          elementAttributesSize;
        uint          elementTextChildrenSize;
        PROFILER_HEAP_OBJECT_SCOPE_LIST* scopeList;
        PROFILER_HEAP_OBJECT_RELATIONSHIP* internalProperty;
        PROFILER_HEAP_OBJECT_RELATIONSHIP_LIST* namePropertyList;
        PROFILER_HEAP_OBJECT_RELATIONSHIP_LIST* indexPropertyList;
        PROFILER_HEAP_OBJECT_RELATIONSHIP_LIST* relationshipList;
        PROFILER_HEAP_OBJECT_RELATIONSHIP_LIST* eventList;
        PROFILER_HEAP_OBJECT_RELATIONSHIP_LIST* weakMapCollectionList;
        PROFILER_HEAP_OBJECT_RELATIONSHIP_LIST* mapCollectionList;
        PROFILER_HEAP_OBJECT_RELATIONSHIP_LIST* setCollectionList;
    }
}

struct PROFILER_HEAP_OBJECT
{
    uint   size;
    union
    {
        size_t objectId;
        void*  externalObjectAddress;
    }
    uint   typeNameId;
    uint   flags;
    ushort unused;
    ushort optionalInfoCount;
}

struct PROFILER_HEAP_SUMMARY
{
    __MIDL___MIDL_itf_activprof_0000_0004_0001 version_;
    uint totalHeapSize;
}

struct HTML_PAINTER_INFO
{
    int  lFlags;
    int  lZOrder;
    GUID iidDrawObject;
    RECT rcExpand;
}

struct HTML_PAINT_XFORM
{
    float eM11;
    float eM12;
    float eM21;
    float eM22;
    float eDx;
    float eDy;
}

struct HTML_PAINT_DRAW_INFO
{
    RECT             rcViewport;
    HRGN             hrgnUpdate;
    HTML_PAINT_XFORM xform;
}

// Functions

@DllImport("KERNEL32")
void RtlCaptureContext(CONTEXT* ContextRecord);

@DllImport("KERNEL32")
void RtlUnwind(void* TargetFrame, void* TargetIp, EXCEPTION_RECORD* ExceptionRecord, void* ReturnValue);

@DllImport("KERNEL32")
void* RtlPcToFileHeader(void* PcValue, void** BaseOfImage);

@DllImport("KERNEL32")
BOOL ReadProcessMemory(HANDLE hProcess, void* lpBaseAddress, char* lpBuffer, size_t nSize, 
                       size_t* lpNumberOfBytesRead);

@DllImport("KERNEL32")
BOOL WriteProcessMemory(HANDLE hProcess, void* lpBaseAddress, char* lpBuffer, size_t nSize, 
                        size_t* lpNumberOfBytesWritten);

@DllImport("USER32")
BOOL FlashWindow(HWND hWnd, BOOL bInvert);

@DllImport("USER32")
BOOL FlashWindowEx(FLASHWINFO* pfwi);

@DllImport("USER32")
BOOL MessageBeep(uint uType);

@DllImport("USER32")
void SetLastErrorEx(uint dwErrCode, uint dwType);

@DllImport("KERNEL32")
BOOL Wow64GetThreadContext(HANDLE hThread, WOW64_CONTEXT* lpContext);

@DllImport("KERNEL32")
BOOL Wow64SetThreadContext(HANDLE hThread, const(WOW64_CONTEXT)* lpContext);

@DllImport("KERNEL32")
BOOL GetThreadContext(HANDLE hThread, CONTEXT* lpContext);

@DllImport("KERNEL32")
BOOL SetThreadContext(HANDLE hThread, const(CONTEXT)* lpContext);

@DllImport("KERNEL32")
BOOL FlushInstructionCache(HANDLE hProcess, char* lpBaseAddress, size_t dwSize);

@DllImport("KERNEL32")
void FatalExit(int ExitCode);

@DllImport("KERNEL32")
BOOL GetThreadSelectorEntry(HANDLE hThread, uint dwSelector, LDT_ENTRY* lpSelectorEntry);

@DllImport("KERNEL32")
BOOL Wow64GetThreadSelectorEntry(HANDLE hThread, uint dwSelector, WOW64_LDT_ENTRY* lpSelectorEntry);

@DllImport("KERNEL32")
BOOL DebugSetProcessKillOnExit(BOOL KillOnExit);

@DllImport("KERNEL32")
BOOL DebugBreakProcess(HANDLE Process);

@DllImport("KERNEL32")
uint FormatMessageA(uint dwFlags, void* lpSource, uint dwMessageId, uint dwLanguageId, const(char)* lpBuffer, 
                    uint nSize, byte** Arguments);

@DllImport("KERNEL32")
uint FormatMessageW(uint dwFlags, void* lpSource, uint dwMessageId, uint dwLanguageId, const(wchar)* lpBuffer, 
                    uint nSize, byte** Arguments);

@DllImport("KERNEL32")
BOOL CopyContext(CONTEXT* Destination, uint ContextFlags, CONTEXT* Source);

@DllImport("KERNEL32")
BOOL InitializeContext(char* Buffer, uint ContextFlags, CONTEXT** Context, uint* ContextLength);

@DllImport("KERNEL32")
ulong GetEnabledXStateFeatures();

@DllImport("KERNEL32")
BOOL GetXStateFeaturesMask(CONTEXT* Context, ulong* FeatureMask);

@DllImport("KERNEL32")
void* LocateXStateFeature(CONTEXT* Context, uint FeatureId, uint* Length);

@DllImport("KERNEL32")
BOOL SetXStateFeaturesMask(CONTEXT* Context, ulong FeatureMask);

@DllImport("ntdll")
uint RtlNtStatusToDosError(NTSTATUS Status);

@DllImport("KERNEL32")
BOOL IsDebuggerPresent();

@DllImport("KERNEL32")
void DebugBreak();

@DllImport("KERNEL32")
void OutputDebugStringA(const(char)* lpOutputString);

@DllImport("KERNEL32")
void OutputDebugStringW(const(wchar)* lpOutputString);

@DllImport("KERNEL32")
BOOL ContinueDebugEvent(uint dwProcessId, uint dwThreadId, uint dwContinueStatus);

@DllImport("KERNEL32")
BOOL WaitForDebugEvent(DEBUG_EVENT* lpDebugEvent, uint dwMilliseconds);

@DllImport("KERNEL32")
BOOL DebugActiveProcess(uint dwProcessId);

@DllImport("KERNEL32")
BOOL DebugActiveProcessStop(uint dwProcessId);

@DllImport("KERNEL32")
BOOL CheckRemoteDebuggerPresent(HANDLE hProcess, int* pbDebuggerPresent);

@DllImport("KERNEL32")
BOOL WaitForDebugEventEx(DEBUG_EVENT* lpDebugEvent, uint dwMilliseconds);

@DllImport("KERNEL32")
void* EncodePointer(void* Ptr);

@DllImport("KERNEL32")
void* DecodePointer(void* Ptr);

@DllImport("KERNEL32")
void* EncodeSystemPointer(void* Ptr);

@DllImport("KERNEL32")
void* DecodeSystemPointer(void* Ptr);

@DllImport("api-ms-win-core-util-l1-1-1")
HRESULT EncodeRemotePointer(HANDLE ProcessHandle, void* Ptr, void** EncodedPtr);

@DllImport("api-ms-win-core-util-l1-1-1")
HRESULT DecodeRemotePointer(HANDLE ProcessHandle, void* Ptr, void** DecodedPtr);

@DllImport("KERNEL32")
BOOL Beep(uint dwFreq, uint dwDuration);

@DllImport("KERNEL32")
void RaiseException(uint dwExceptionCode, uint dwExceptionFlags, uint nNumberOfArguments, char* lpArguments);

@DllImport("KERNEL32")
int UnhandledExceptionFilter(EXCEPTION_POINTERS* ExceptionInfo);

@DllImport("KERNEL32")
LPTOP_LEVEL_EXCEPTION_FILTER SetUnhandledExceptionFilter(LPTOP_LEVEL_EXCEPTION_FILTER lpTopLevelExceptionFilter);

@DllImport("KERNEL32")
uint GetLastError();

@DllImport("KERNEL32")
void SetLastError(uint dwErrCode);

@DllImport("KERNEL32")
uint GetErrorMode();

@DllImport("KERNEL32")
uint SetErrorMode(uint uMode);

@DllImport("KERNEL32")
void* AddVectoredExceptionHandler(uint First, PVECTORED_EXCEPTION_HANDLER Handler);

@DllImport("KERNEL32")
uint RemoveVectoredExceptionHandler(void* Handle);

@DllImport("KERNEL32")
void* AddVectoredContinueHandler(uint First, PVECTORED_EXCEPTION_HANDLER Handler);

@DllImport("KERNEL32")
uint RemoveVectoredContinueHandler(void* Handle);

@DllImport("KERNEL32")
void RaiseFailFastException(EXCEPTION_RECORD* pExceptionRecord, CONTEXT* pContextRecord, uint dwFlags);

@DllImport("KERNEL32")
void FatalAppExitA(uint uAction, const(char)* lpMessageText);

@DllImport("KERNEL32")
void FatalAppExitW(uint uAction, const(wchar)* lpMessageText);

@DllImport("KERNEL32")
uint GetThreadErrorMode();

@DllImport("KERNEL32")
BOOL SetThreadErrorMode(uint dwNewMode, uint* lpOldMode);

@DllImport("api-ms-win-core-errorhandling-l1-1-3")
void TerminateProcessOnMemoryExhaustion(size_t FailedAllocationSize);

@DllImport("ADVAPI32")
void* OpenThreadWaitChainSession(uint Flags, PWAITCHAINCALLBACK callback);

@DllImport("ADVAPI32")
void CloseThreadWaitChainSession(void* WctHandle);

@DllImport("ADVAPI32")
BOOL GetThreadWaitChain(void* WctHandle, size_t Context, uint Flags, uint ThreadId, uint* NodeCount, 
                        char* NodeInfoArray, int* IsCycle);

@DllImport("ADVAPI32")
void RegisterWaitChainCOMCallback(PCOGETCALLSTATE CallStateCallback, PCOGETACTIVATIONSTATE ActivationStateCallback);

@DllImport("api-ms-win-core-debug-minidump-l1-1-0")
BOOL MiniDumpWriteDump(HANDLE hProcess, uint ProcessId, HANDLE hFile, MINIDUMP_TYPE DumpType, 
                       MINIDUMP_EXCEPTION_INFORMATION* ExceptionParam, 
                       MINIDUMP_USER_STREAM_INFORMATION* UserStreamParam, 
                       MINIDUMP_CALLBACK_INFORMATION* CallbackParam);

@DllImport("api-ms-win-core-debug-minidump-l1-1-0")
BOOL MiniDumpReadDumpStream(void* BaseOfDump, uint StreamNumber, MINIDUMP_DIRECTORY** Dir, void** StreamPointer, 
                            uint* StreamSize);


// Interfaces

@GUID("78A51822-51F4-11D0-8F20-00805F2CD064")
struct ProcessDebugManager;

@GUID("0BFCC060-8C1D-11D0-ACCD-00AA0060275C")
struct DebugHelper;

@GUID("83B8BCA6-687C-11D0-A405-00AA0060275C")
struct CDebugDocumentHelper;

@GUID("0C0A3666-30C9-11D0-8F20-00805F2CD064")
struct MachineDebugManager_RETAIL;

@GUID("49769CEC-3A55-4BB0-B697-88FEDE77E8EA")
struct MachineDebugManager_DEBUG;

@GUID("834128A2-51F4-11D0-8F20-00805F2CD064")
struct DefaultDebugSessionProvider;

@GUID("30510741-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLCSSStyleDeclaration;

@GUID("3050F285-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLStyle;

@GUID("3050F3D0-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLRuleStyle;

@GUID("305106EF-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLCSSRule;

@GUID("305106F0-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLCSSImportRule;

@GUID("305106F1-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLCSSMediaRule;

@GUID("30510732-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLCSSMediaList;

@GUID("305106F2-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLCSSNamespaceRule;

@GUID("3051080E-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLMSCSSKeyframeRule;

@GUID("3051080F-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLMSCSSKeyframesRule;

@GUID("3050F6AA-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLRenderStyle;

@GUID("3050F3DC-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLCurrentStyle;

@GUID("3050F4B2-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLDOMAttribute;

@GUID("3050F4BA-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLDOMTextNode;

@GUID("3050F80E-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLDOMImplementation;

@GUID("3050F4CC-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLAttributeCollection;

@GUID("30510467-98B5-11CF-BB82-00AA00BDCE0B")
struct StaticNodeList;

@GUID("3050F5AA-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMChildrenCollection;

@GUID("3050F6C8-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLDefaults;

@GUID("3050F4FC-98B5-11CF-BB82-00AA00BDCE0B")
struct HTCDefaultDispatch;

@GUID("3050F5DE-98B5-11CF-BB82-00AA00BDCE0B")
struct HTCPropertyBehavior;

@GUID("3050F630-98B5-11CF-BB82-00AA00BDCE0B")
struct HTCMethodBehavior;

@GUID("3050F4FE-98B5-11CF-BB82-00AA00BDCE0B")
struct HTCEventBehavior;

@GUID("3050F5F5-98B5-11CF-BB82-00AA00BDCE0B")
struct HTCAttachBehavior;

@GUID("3050F5DD-98B5-11CF-BB82-00AA00BDCE0B")
struct HTCDescBehavior;

@GUID("3050F580-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLUrnCollection;

@GUID("3050F4B8-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLGenericElement;

@GUID("3050F3CE-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLStyleSheetRule;

@GUID("3050F3CD-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLStyleSheetRulesCollection;

@GUID("3050F7EF-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLStyleSheetPage;

@GUID("3050F7F1-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLStyleSheetPagesCollection;

@GUID("3050F2E4-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLStyleSheet;

@GUID("3050F37F-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLStyleSheetsCollection;

@GUID("3050F277-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLLinkElement;

@GUID("305106C3-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLDOMRange;

@GUID("3050F251-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLFormElement;

@GUID("3050F26A-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLTextElement;

@GUID("3050F241-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLImg;

@GUID("3050F38F-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLImageElementFactory;

@GUID("3050F24A-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLBody;

@GUID("3050F27B-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLFontElement;

@GUID("3050F248-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLAnchorElement;

@GUID("3050F32B-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLLabelElement;

@GUID("3050F272-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLListElement;

@GUID("3050F269-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLUListElement;

@GUID("3050F270-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLOListElement;

@GUID("3050F273-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLLIElement;

@GUID("3050F281-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLBlockElement;

@GUID("3050F27E-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLDivElement;

@GUID("3050F27F-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLDDElement;

@GUID("3050F27C-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLDTElement;

@GUID("3050F280-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLBRElement;

@GUID("3050F27D-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLDListElement;

@GUID("3050F252-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLHRElement;

@GUID("3050F26F-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLParaElement;

@GUID("3050F4CB-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLElementCollection;

@GUID("3050F27A-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLHeaderElement;

@GUID("3050F245-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLSelectElement;

@GUID("3050F2CF-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLWndSelectElement;

@GUID("3050F24D-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLOptionElement;

@GUID("3050F38D-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLOptionElementFactory;

@GUID("3050F2D0-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLWndOptionElement;

@GUID("3050F5D8-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLInputElement;

@GUID("3050F2AC-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLTextAreaElement;

@GUID("3050F2DF-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLRichtextElement;

@GUID("3050F2C6-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLButtonElement;

@GUID("3050F2B9-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLMarqueeElement;

@GUID("3050F491-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLHtmlElement;

@GUID("3050F493-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLHeadElement;

@GUID("3050F284-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLTitleElement;

@GUID("3050F275-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLMetaElement;

@GUID("3050F276-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLBaseElement;

@GUID("3050F278-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLIsIndexElement;

@GUID("3050F279-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLNextIdElement;

@GUID("3050F282-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLBaseFontElement;

@GUID("3050F268-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLUnknownElement;

@GUID("FECEAAA3-8405-11CF-8BA1-00AA00476DA6")
struct HTMLHistory;

@GUID("3050F402-98B5-11CF-BB82-00AA00BDCE0B")
struct COpsProfile;

@GUID("FECEAAA6-8405-11CF-8BA1-00AA00476DA6")
struct HTMLNavigator;

@GUID("163BB1E1-6E00-11CF-837A-48DC04C10000")
struct HTMLLocation;

@GUID("3050F3FE-98B5-11CF-BB82-00AA00BDCE0B")
struct CMimeTypes;

@GUID("3050F3FF-98B5-11CF-BB82-00AA00BDCE0B")
struct CPlugins;

@GUID("3050F48A-98B5-11CF-BB82-00AA00BDCE0B")
struct CEventObj;

@GUID("3051074C-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLStyleMedia;

@GUID("3050F7F6-98B5-11CF-BB82-00AA00BDCE0B")
struct FramesCollection;

@GUID("3050F35D-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLScreen;

@GUID("D48A6EC6-6A4A-11CF-94A7-444553540000")
struct HTMLWindow2;

@GUID("3050F391-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLWindowProxy;

@GUID("3051041B-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLDocumentCompatibleInfo;

@GUID("30510419-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLDocumentCompatibleInfoCollection;

@GUID("25336920-03F9-11CF-8FD0-00AA00686F13")
struct HTMLDocument;

@GUID("AE24FDAE-03C6-11D1-8B76-0080C744F389")
struct Scriptlet;

@GUID("3050F25D-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLEmbed;

@GUID("3050F4CA-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLAreasCollection;

@GUID("3050F271-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLMapElement;

@GUID("3050F283-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLAreaElement;

@GUID("3050F2EC-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLTableCaption;

@GUID("3050F317-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLCommentElement;

@GUID("3050F26E-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLPhraseElement;

@GUID("3050F3F5-98B4-11CF-BB82-00AA00BDCE0B")
struct HTMLSpanElement;

@GUID("3050F26B-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLTable;

@GUID("3050F26C-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLTableCol;

@GUID("3050F2E9-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLTableSection;

@GUID("3050F26D-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLTableRow;

@GUID("3050F246-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLTableCell;

@GUID("3050F28C-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLScriptElement;

@GUID("3050F38B-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLNoShowElement;

@GUID("3050F24E-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLObjectElement;

@GUID("3050F83E-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLParamElement;

@GUID("3050F312-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLFrameBase;

@GUID("3050F314-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLFrameElement;

@GUID("3050F316-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLIFrame;

@GUID("3050F249-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLDivPosition;

@GUID("3050F3E8-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLFieldSetElement;

@GUID("3050F3E9-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLLegendElement;

@GUID("3050F3E6-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLSpanFlow;

@GUID("3050F31A-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLFrameSetSite;

@GUID("3050F370-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLBGsound;

@GUID("3050F37D-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLStyleElement;

@GUID("3050F3D4-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLStyleFontFace;

@GUID("30510455-98B5-11CF-BB82-00AA00BDCE0B")
struct XDomainRequest;

@GUID("30510457-98B5-11CF-BB82-00AA00BDCE0B")
struct XDomainRequestFactory;

@GUID("30510475-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLStorage;

@GUID("305104BB-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMEvent;

@GUID("305106CB-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMUIEvent;

@GUID("305106CF-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMMouseEvent;

@GUID("30510762-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMDragEvent;

@GUID("305106D1-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMMouseWheelEvent;

@GUID("305106D3-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMWheelEvent;

@GUID("305106D5-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMTextEvent;

@GUID("305106D7-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMKeyboardEvent;

@GUID("305106D9-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMCompositionEvent;

@GUID("305106DB-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMMutationEvent;

@GUID("30510764-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMBeforeUnloadEvent;

@GUID("305106CD-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMFocusEvent;

@GUID("305106DF-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMCustomEvent;

@GUID("30510715-98B5-11CF-BB82-00AA00BDCE0B")
struct CanvasGradient;

@GUID("30510717-98B5-11CF-BB82-00AA00BDCE0B")
struct CanvasPattern;

@GUID("30510719-98B5-11CF-BB82-00AA00BDCE0B")
struct CanvasTextMetrics;

@GUID("3051071B-98B5-11CF-BB82-00AA00BDCE0B")
struct CanvasImageData;

@GUID("30510700-98B5-11CF-BB82-00AA00BDCE0B")
struct CanvasRenderingContext2D;

@GUID("305106E5-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLCanvasElement;

@GUID("3051071F-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMProgressEvent;

@GUID("30510721-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMMessageEvent;

@GUID("30510766-98B6-11CF-BB82-00AA00BDCE0B")
struct DOMSiteModeEvent;

@GUID("30510723-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMStorageEvent;

@GUID("30510831-98B5-11CF-BB82-00AA00BDCE0B")
struct XMLHttpRequestEventTarget;

@GUID("3051040B-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLXMLHttpRequest;

@GUID("3051040D-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLXMLHttpRequestFactory;

@GUID("30510584-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGAngle;

@GUID("305105E4-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGAnimatedAngle;

@GUID("305105B1-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGAnimatedTransformList;

@GUID("3051058B-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGAnimatedBoolean;

@GUID("3051058E-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGAnimatedEnumeration;

@GUID("3051058F-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGAnimatedInteger;

@GUID("30510581-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGAnimatedLength;

@GUID("30510582-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGAnimatedLengthList;

@GUID("30510588-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGAnimatedNumber;

@GUID("3051058A-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGAnimatedNumberList;

@GUID("30510586-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGAnimatedRect;

@GUID("3051058C-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGAnimatedString;

@GUID("305105E6-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGClipPathElement;

@GUID("30510564-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGElement;

@GUID("3051057E-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGLength;

@GUID("30510580-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGLengthList;

@GUID("305105AE-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGMatrix;

@GUID("30510587-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGNumber;

@GUID("30510589-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGNumberList;

@GUID("305105D4-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPatternElement;

@GUID("305105B3-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSeg;

@GUID("305105BB-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSegArcAbs;

@GUID("305105BC-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSegArcRel;

@GUID("305105BD-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSegClosePath;

@GUID("305105CC-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSegMovetoAbs;

@GUID("305105CD-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSegMovetoRel;

@GUID("305105C6-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSegLinetoAbs;

@GUID("305105C9-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSegLinetoRel;

@GUID("305105BE-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSegCurvetoCubicAbs;

@GUID("305105BF-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSegCurvetoCubicRel;

@GUID("305105C0-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSegCurvetoCubicSmoothAbs;

@GUID("305105C1-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSegCurvetoCubicSmoothRel;

@GUID("305105C2-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSegCurvetoQuadraticAbs;

@GUID("305105C3-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSegCurvetoQuadraticRel;

@GUID("305105C4-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSegCurvetoQuadraticSmoothAbs;

@GUID("305105C5-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSegCurvetoQuadraticSmoothRel;

@GUID("305105C7-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSegLinetoHorizontalAbs;

@GUID("305105C8-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSegLinetoHorizontalRel;

@GUID("305105CA-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSegLinetoVerticalAbs;

@GUID("305105CB-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSegLinetoVerticalRel;

@GUID("305105B4-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathSegList;

@GUID("305105BA-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPoint;

@GUID("305105B9-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPointList;

@GUID("30510583-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGRect;

@GUID("3051058D-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGStringList;

@GUID("305105AF-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGTransform;

@GUID("30510574-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGSVGElement;

@GUID("30510590-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGUseElement;

@GUID("EB36F845-2395-4719-B85C-D0D80E184BD9")
struct HTMLStyleSheetRulesAppliedCollection;

@GUID("7C803920-7A53-4D26-98AC-FDD23E6B9E01")
struct RulesApplied;

@GUID("671926EE-C3CF-40AF-BE8F-1CBAEE6486E8")
struct RulesAppliedCollection;

@GUID("305106C8-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLW3CComputedStyle;

@GUID("305105B0-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGTransformList;

@GUID("30510578-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGCircleElement;

@GUID("30510579-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGEllipseElement;

@GUID("3051057A-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGLineElement;

@GUID("30510577-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGRectElement;

@GUID("3051057B-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPolygonElement;

@GUID("3051057C-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPolylineElement;

@GUID("3051056F-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGGElement;

@GUID("30510571-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGSymbolElement;

@GUID("30510570-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGDefsElement;

@GUID("305105B2-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPathElement;

@GUID("305105D0-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGPreserveAspectRatio;

@GUID("305105DF-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGTextElement;

@GUID("305105CE-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGAnimatedPreserveAspectRatio;

@GUID("305105CF-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGImageElement;

@GUID("305105D5-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGStopElement;

@GUID("305105D6-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGGradientElement;

@GUID("305105D2-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGLinearGradientElement;

@GUID("305105D3-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGRadialGradientElement;

@GUID("305105E7-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGMaskElement;

@GUID("305105DE-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGMarkerElement;

@GUID("305105D9-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGZoomEvent;

@GUID("305105DB-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGAElement;

@GUID("305105DC-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGViewElement;

@GUID("3051070A-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLMediaError;

@GUID("3051070B-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLTimeRanges;

@GUID("3051070C-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLMediaElement;

@GUID("3051070D-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLSourceElement;

@GUID("3051070E-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLAudioElement;

@GUID("305107EC-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLAudioElementFactory;

@GUID("3051070F-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLVideoElement;

@GUID("305105D8-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGSwitchElement;

@GUID("30510572-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGDescElement;

@GUID("30510573-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGTitleElement;

@GUID("305105D7-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGMetadataElement;

@GUID("30510575-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGElementInstance;

@GUID("30510576-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGElementInstanceList;

@GUID("3051072C-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMException;

@GUID("3051072E-98B5-11CF-BB82-00AA00BDCE0B")
struct RangeException;

@GUID("30510730-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGException;

@GUID("3051073B-98B5-11CF-BB82-00AA00BDCE0B")
struct EventException;

@GUID("305105E1-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGScriptElement;

@GUID("305105D1-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGStyleElement;

@GUID("305105DD-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGTextContentElement;

@GUID("305105E0-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGTextPositioningElement;

@GUID("30510739-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMDocumentType;

@GUID("30510745-98B5-11CF-BB82-00AA00BDCE0B")
struct NodeIterator;

@GUID("30510747-98B5-11CF-BB82-00AA00BDCE0B")
struct TreeWalker;

@GUID("30510743-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMProcessingInstruction;

@GUID("3051074F-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLPerformance;

@GUID("30510751-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLPerformanceNavigation;

@GUID("30510753-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLPerformanceTiming;

@GUID("305105E2-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGTSpanElement;

@GUID("3050F6B3-98B5-11CF-BB82-00AA00BDCE0B")
struct CTemplatePrinter;

@GUID("63619F54-9D71-4C23-A08D-50D7F18DB2E9")
struct CPrintManagerTemplatePrinter;

@GUID("305105EB-98B5-11CF-BB82-00AA00BDCE0B")
struct SVGTextPathElement;

@GUID("3051077E-98B5-11CF-BB82-00AA00BDCE0B")
struct XMLSerializer;

@GUID("30510782-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMParser;

@GUID("30510780-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLDOMXmlSerializerFactory;

@GUID("30510784-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMParserFactory;

@GUID("305107B0-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLSemanticElement;

@GUID("3050F2D5-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLProgressElement;

@GUID("305107B6-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMMSTransitionEvent;

@GUID("305107B8-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMMSAnimationEvent;

@GUID("305107C6-98B5-11CF-BB82-00AA00BDCE0B")
struct WebGeolocation;

@GUID("305107C8-98B5-11CF-BB82-00AA00BDCE0B")
struct WebGeocoordinates;

@GUID("305107CA-98B5-11CF-BB82-00AA00BDCE0B")
struct WebGeopositionError;

@GUID("305107CE-98B5-11CF-BB82-00AA00BDCE0B")
struct WebGeoposition;

@GUID("7E8BC44E-AEFF-11D1-89C2-00C04FB6BFC4")
struct CClientCaps;

@GUID("30510817-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMMSManipulationEvent;

@GUID("30510800-98B5-11CF-BB82-00AA00BDCE0B")
struct DOMCloseEvent;

@GUID("30510829-98B5-11CF-BB82-00AA00BDCE0B")
struct ApplicationCache;

@GUID("3050F819-98B5-11CF-BB82-00AA00BDCE0B")
struct HtmlDlgSafeHelper;

@GUID("3050F831-98B5-11CF-BB82-00AA00BDCE0B")
struct BlockFormats;

@GUID("3050F83A-98B5-11CF-BB82-00AA00BDCE0B")
struct FontNames;

@GUID("3050F6BC-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLNamespace;

@GUID("3050F6B9-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLNamespaceCollection;

@GUID("3050F5EB-98B5-11CF-BB82-00AA00BDCE0B")
struct ThreadDialogProcParam;

@GUID("3050F28A-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLDialog;

@GUID("3050F667-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLPopup;

@GUID("3050F5CB-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLAppBehavior;

@GUID("D48A6EC9-6A4A-11CF-94A7-444553540000")
struct OldHTMLDocument;

@GUID("0D04D285-6BEC-11CF-8B97-00AA00476DA6")
struct OldHTMLFormElement;

@GUID("3050F2B4-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLInputButtonElement;

@GUID("3050F2AB-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLInputTextElement;

@GUID("3050F2AE-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLInputFileElement;

@GUID("3050F2BE-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLOptionButtonElement;

@GUID("3050F2C4-98B5-11CF-BB82-00AA00BDCE0B")
struct HTMLInputImage;

@GUID("DB01A1E3-A42B-11CF-8F20-00805F2CD064")
interface IActiveScriptSite : IUnknown
{
    HRESULT GetLCID(uint* plcid);
    HRESULT GetItemInfo(ushort* pstrName, uint dwReturnMask, IUnknown* ppiunkItem, ITypeInfo* ppti);
    HRESULT GetDocVersionString(BSTR* pbstrVersion);
    HRESULT OnScriptTerminate(const(VARIANT)* pvarResult, const(EXCEPINFO)* pexcepinfo);
    HRESULT OnStateChange(SCRIPTSTATE ssScriptState);
    HRESULT OnScriptError(IActiveScriptError pscripterror);
    HRESULT OnEnterScript();
    HRESULT OnLeaveScript();
}

@GUID("EAE1BA61-A4ED-11CF-8F20-00805F2CD064")
interface IActiveScriptError : IUnknown
{
    HRESULT GetExceptionInfo(EXCEPINFO* pexcepinfo);
    HRESULT GetSourcePosition(uint* pdwSourceContext, uint* pulLineNumber, int* plCharacterPosition);
    HRESULT GetSourceLineText(BSTR* pbstrSourceLine);
}

@GUID("B21FB2A1-5B8F-4963-8C21-21450F84ED7F")
interface IActiveScriptError64 : IActiveScriptError
{
    HRESULT GetSourcePosition64(ulong* pdwSourceContext, uint* pulLineNumber, int* plCharacterPosition);
}

@GUID("D10F6761-83E9-11CF-8F20-00805F2CD064")
interface IActiveScriptSiteWindow : IUnknown
{
    HRESULT GetWindow(HWND* phwnd);
    HRESULT EnableModeless(BOOL fEnable);
}

@GUID("AEDAE97E-D7EE-4796-B960-7F092AE844AB")
interface IActiveScriptSiteUIControl : IUnknown
{
    HRESULT GetUIBehavior(SCRIPTUICITEM UicItem, SCRIPTUICHANDLING* pUicHandling);
}

@GUID("539698A0-CDCA-11CF-A5EB-00AA0047A063")
interface IActiveScriptSiteInterruptPoll : IUnknown
{
    HRESULT QueryContinue();
}

@GUID("BB1A2AE1-A4F9-11CF-8F20-00805F2CD064")
interface IActiveScript : IUnknown
{
    HRESULT SetScriptSite(IActiveScriptSite pass);
    HRESULT GetScriptSite(const(GUID)* riid, void** ppvObject);
    HRESULT SetScriptState(SCRIPTSTATE ss);
    HRESULT GetScriptState(SCRIPTSTATE* pssState);
    HRESULT Close();
    HRESULT AddNamedItem(ushort* pstrName, uint dwFlags);
    HRESULT AddTypeLib(const(GUID)* rguidTypeLib, uint dwMajor, uint dwMinor, uint dwFlags);
    HRESULT GetScriptDispatch(ushort* pstrItemName, IDispatch* ppdisp);
    HRESULT GetCurrentScriptThreadID(uint* pstidThread);
    HRESULT GetScriptThreadID(uint dwWin32ThreadId, uint* pstidThread);
    HRESULT GetScriptThreadState(uint stidThread, SCRIPTTHREADSTATE* pstsState);
    HRESULT InterruptScriptThread(uint stidThread, const(EXCEPINFO)* pexcepinfo, uint dwFlags);
    HRESULT Clone(IActiveScript* ppscript);
}

@GUID("BB1A2AE2-A4F9-11CF-8F20-00805F2CD064")
interface IActiveScriptParse32 : IUnknown
{
    HRESULT InitNew();
    HRESULT AddScriptlet(ushort* pstrDefaultName, ushort* pstrCode, ushort* pstrItemName, ushort* pstrSubItemName, 
                         ushort* pstrEventName, ushort* pstrDelimiter, uint dwSourceContextCookie, 
                         uint ulStartingLineNumber, uint dwFlags, BSTR* pbstrName, EXCEPINFO* pexcepinfo);
    HRESULT ParseScriptText(ushort* pstrCode, ushort* pstrItemName, IUnknown punkContext, ushort* pstrDelimiter, 
                            uint dwSourceContextCookie, uint ulStartingLineNumber, uint dwFlags, VARIANT* pvarResult, 
                            EXCEPINFO* pexcepinfo);
}

@GUID("C7EF7658-E1EE-480E-97EA-D52CB4D76D17")
interface IActiveScriptParse64 : IUnknown
{
    HRESULT InitNew();
    HRESULT AddScriptlet(ushort* pstrDefaultName, ushort* pstrCode, ushort* pstrItemName, ushort* pstrSubItemName, 
                         ushort* pstrEventName, ushort* pstrDelimiter, ulong dwSourceContextCookie, 
                         uint ulStartingLineNumber, uint dwFlags, BSTR* pbstrName, EXCEPINFO* pexcepinfo);
    HRESULT ParseScriptText(ushort* pstrCode, ushort* pstrItemName, IUnknown punkContext, ushort* pstrDelimiter, 
                            ulong dwSourceContextCookie, uint ulStartingLineNumber, uint dwFlags, 
                            VARIANT* pvarResult, EXCEPINFO* pexcepinfo);
}

@GUID("1CFF0050-6FDD-11D0-9328-00A0C90DCAA9")
interface IActiveScriptParseProcedureOld32 : IUnknown
{
    HRESULT ParseProcedureText(ushort* pstrCode, ushort* pstrFormalParams, ushort* pstrItemName, 
                               IUnknown punkContext, ushort* pstrDelimiter, uint dwSourceContextCookie, 
                               uint ulStartingLineNumber, uint dwFlags, IDispatch* ppdisp);
}

@GUID("21F57128-08C9-4638-BA12-22D15D88DC5C")
interface IActiveScriptParseProcedureOld64 : IUnknown
{
    HRESULT ParseProcedureText(ushort* pstrCode, ushort* pstrFormalParams, ushort* pstrItemName, 
                               IUnknown punkContext, ushort* pstrDelimiter, ulong dwSourceContextCookie, 
                               uint ulStartingLineNumber, uint dwFlags, IDispatch* ppdisp);
}

@GUID("AA5B6A80-B834-11D0-932F-00A0C90DCAA9")
interface IActiveScriptParseProcedure32 : IUnknown
{
    HRESULT ParseProcedureText(ushort* pstrCode, ushort* pstrFormalParams, ushort* pstrProcedureName, 
                               ushort* pstrItemName, IUnknown punkContext, ushort* pstrDelimiter, 
                               uint dwSourceContextCookie, uint ulStartingLineNumber, uint dwFlags, 
                               IDispatch* ppdisp);
}

@GUID("C64713B6-E029-4CC5-9200-438B72890B6A")
interface IActiveScriptParseProcedure64 : IUnknown
{
    HRESULT ParseProcedureText(ushort* pstrCode, ushort* pstrFormalParams, ushort* pstrProcedureName, 
                               ushort* pstrItemName, IUnknown punkContext, ushort* pstrDelimiter, 
                               ulong dwSourceContextCookie, uint ulStartingLineNumber, uint dwFlags, 
                               IDispatch* ppdisp);
}

@GUID("71EE5B20-FB04-11D1-B3A8-00A0C911E8B2")
interface IActiveScriptParseProcedure2_32 : IActiveScriptParseProcedure32
{
}

@GUID("FE7C4271-210C-448D-9F54-76DAB7047B28")
interface IActiveScriptParseProcedure2_64 : IActiveScriptParseProcedure64
{
}

@GUID("BB1A2AE3-A4F9-11CF-8F20-00805F2CD064")
interface IActiveScriptEncode : IUnknown
{
    HRESULT EncodeSection(ushort* pchIn, uint cchIn, ushort* pchOut, uint cchOut, uint* pcchRet);
    HRESULT DecodeScript(ushort* pchIn, uint cchIn, ushort* pchOut, uint cchOut, uint* pcchRet);
    HRESULT GetEncodeProgId(BSTR* pbstrOut);
}

@GUID("BEE9B76E-CFE3-11D1-B747-00C04FC2B085")
interface IActiveScriptHostEncode : IUnknown
{
    HRESULT EncodeScriptHostFile(BSTR bstrInFile, BSTR* pbstrOutFile, uint cFlags, BSTR bstrDefaultLang);
}

@GUID("63CDBCB0-C1B1-11D0-9336-00A0C90DCAA9")
interface IBindEventHandler : IUnknown
{
    HRESULT BindHandler(ushort* pstrEvent, IDispatch pdisp);
}

@GUID("B8DA6310-E19B-11D0-933C-00A0C90DCAA9")
interface IActiveScriptStats : IUnknown
{
    HRESULT GetStat(uint stid, uint* pluHi, uint* pluLo);
    HRESULT GetStatEx(const(GUID)* guid, uint* pluHi, uint* pluLo);
    HRESULT ResetStats();
}

@GUID("4954E0D0-FBC7-11D1-8410-006008C3FBFC")
interface IActiveScriptProperty : IUnknown
{
    HRESULT GetProperty(uint dwProperty, VARIANT* pvarIndex, VARIANT* pvarValue);
    HRESULT SetProperty(uint dwProperty, VARIANT* pvarIndex, VARIANT* pvarValue);
}

@GUID("1DC9CA50-06EF-11D2-8415-006008C3FBFC")
interface ITridentEventSink : IUnknown
{
    HRESULT FireEvent(ushort* pstrEvent, DISPPARAMS* pdp, VARIANT* pvarRes, EXCEPINFO* pei);
}

@GUID("6AA2C4A0-2B53-11D4-A2A0-00104BD35090")
interface IActiveScriptGarbageCollector : IUnknown
{
    HRESULT CollectGarbage(SCRIPTGCTYPE scriptgctype);
}

@GUID("764651D0-38DE-11D4-A2A3-00104BD35090")
interface IActiveScriptSIPInfo : IUnknown
{
    HRESULT GetSIPOID(GUID* poid_sip);
}

@GUID("4B7272AE-1955-4BFE-98B0-780621888569")
interface IActiveScriptSiteTraceInfo : IUnknown
{
    HRESULT SendScriptTraceInfo(SCRIPTTRACEINFO stiEventType, GUID guidContextID, uint dwScriptContextCookie, 
                                int lScriptStatementStart, int lScriptStatementEnd, ulong dwReserved);
}

@GUID("C35456E7-BEBF-4A1B-86A9-24D56BE8B369")
interface IActiveScriptTraceInfo : IUnknown
{
    HRESULT StartScriptTracing(IActiveScriptSiteTraceInfo pSiteTraceInfo, GUID guidContextID);
    HRESULT StopScriptTracing();
}

@GUID("58562769-ED52-42F7-8403-4963514E1F11")
interface IActiveScriptStringCompare : IUnknown
{
    HRESULT StrComp(BSTR bszStr1, BSTR bszStr2, int* iRet);
}

@GUID("51973C50-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugProperty : IUnknown
{
    HRESULT GetPropertyInfo(uint dwFieldSpec, uint nRadix, DebugPropertyInfo* pPropertyInfo);
    HRESULT GetExtendedInfo(uint cInfos, char* rgguidExtendedInfo, char* rgvar);
    HRESULT SetValueAsString(ushort* pszValue, uint nRadix);
    HRESULT EnumMembers(uint dwFieldSpec, uint nRadix, const(GUID)* refiid, IEnumDebugPropertyInfo* ppepi);
    HRESULT GetParent(IDebugProperty* ppDebugProp);
}

@GUID("51973C51-CB0C-11D0-B5C9-00A0244A0E7A")
interface IEnumDebugPropertyInfo : IUnknown
{
    HRESULT Next(uint celt, char* pi, uint* pcEltsfetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumDebugPropertyInfo* ppepi);
    HRESULT GetCount(uint* pcelt);
}

@GUID("51973C52-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugExtendedProperty : IDebugProperty
{
    HRESULT GetExtendedPropertyInfo(uint dwFieldSpec, uint nRadix, 
                                    ExtendedDebugPropertyInfo* pExtendedPropertyInfo);
    HRESULT EnumExtendedMembers(uint dwFieldSpec, uint nRadix, IEnumDebugExtendedPropertyInfo* ppeepi);
}

@GUID("51973C53-CB0C-11D0-B5C9-00A0244A0E7A")
interface IEnumDebugExtendedPropertyInfo : IUnknown
{
    HRESULT Next(uint celt, char* rgExtendedPropertyInfo, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumDebugExtendedPropertyInfo* pedpe);
    HRESULT GetCount(uint* pcelt);
}

@GUID("51973C54-CB0C-11D0-B5C9-00A0244A0E7A")
interface IPerPropertyBrowsing2 : IUnknown
{
    HRESULT GetDisplayString(int dispid, BSTR* pBstr);
    HRESULT MapPropertyToPage(int dispid, GUID* pClsidPropPage);
    HRESULT GetPredefinedStrings(int dispid, CALPOLESTR* pCaStrings, CADWORD* pCaCookies);
    HRESULT SetPredefinedValue(int dispid, uint dwCookie);
}

@GUID("51973C55-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugPropertyEnumType_All : IUnknown
{
    HRESULT GetName(BSTR* __MIDL__IDebugPropertyEnumType_All0000);
}

@GUID("51973C56-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugPropertyEnumType_Locals : IDebugPropertyEnumType_All
{
}

@GUID("51973C57-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugPropertyEnumType_Arguments : IDebugPropertyEnumType_All
{
}

@GUID("51973C58-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugPropertyEnumType_LocalsPlusArgs : IDebugPropertyEnumType_All
{
}

@GUID("51973C59-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugPropertyEnumType_Registers : IDebugPropertyEnumType_All
{
}

@GUID("51973C10-CB0C-11D0-B5C9-00A0244A0E7A")
interface IActiveScriptDebug32 : IUnknown
{
    HRESULT GetScriptTextAttributes(char* pstrCode, uint uNumCodeChars, ushort* pstrDelimiter, uint dwFlags, 
                                    char* pattr);
    HRESULT GetScriptletTextAttributes(char* pstrCode, uint uNumCodeChars, ushort* pstrDelimiter, uint dwFlags, 
                                       char* pattr);
    HRESULT EnumCodeContextsOfPosition(uint dwSourceContext, uint uCharacterOffset, uint uNumChars, 
                                       IEnumDebugCodeContexts* ppescc);
}

@GUID("BC437E23-F5B8-47F4-BB79-7D1CE5483B86")
interface IActiveScriptDebug64 : IUnknown
{
    HRESULT GetScriptTextAttributes(char* pstrCode, uint uNumCodeChars, ushort* pstrDelimiter, uint dwFlags, 
                                    char* pattr);
    HRESULT GetScriptletTextAttributes(char* pstrCode, uint uNumCodeChars, ushort* pstrDelimiter, uint dwFlags, 
                                       char* pattr);
    HRESULT EnumCodeContextsOfPosition(ulong dwSourceContext, uint uCharacterOffset, uint uNumChars, 
                                       IEnumDebugCodeContexts* ppescc);
}

@GUID("51973C11-CB0C-11D0-B5C9-00A0244A0E7A")
interface IActiveScriptSiteDebug32 : IUnknown
{
    HRESULT GetDocumentContextFromPosition(uint dwSourceContext, uint uCharacterOffset, uint uNumChars, 
                                           IDebugDocumentContext* ppsc);
    HRESULT GetApplication(IDebugApplication32* ppda);
    HRESULT GetRootApplicationNode(IDebugApplicationNode* ppdanRoot);
    HRESULT OnScriptErrorDebug(IActiveScriptErrorDebug pErrorDebug, int* pfEnterDebugger, 
                               int* pfCallOnScriptErrorWhenContinuing);
}

@GUID("D6B96B0A-7463-402C-92AC-89984226942F")
interface IActiveScriptSiteDebug64 : IUnknown
{
    HRESULT GetDocumentContextFromPosition(ulong dwSourceContext, uint uCharacterOffset, uint uNumChars, 
                                           IDebugDocumentContext* ppsc);
    HRESULT GetApplication(IDebugApplication64* ppda);
    HRESULT GetRootApplicationNode(IDebugApplicationNode* ppdanRoot);
    HRESULT OnScriptErrorDebug(IActiveScriptErrorDebug pErrorDebug, int* pfEnterDebugger, 
                               int* pfCallOnScriptErrorWhenContinuing);
}

@GUID("BB722CCB-6AD2-41C6-B780-AF9C03EE69F5")
interface IActiveScriptSiteDebugEx : IUnknown
{
    HRESULT OnCanNotJITScriptErrorDebug(IActiveScriptErrorDebug pErrorDebug, 
                                        int* pfCallOnScriptErrorWhenContinuing);
}

@GUID("51973C12-CB0C-11D0-B5C9-00A0244A0E7A")
interface IActiveScriptErrorDebug : IActiveScriptError
{
    HRESULT GetDocumentContext(IDebugDocumentContext* ppssc);
    HRESULT GetStackFrame(IDebugStackFrame* ppdsf);
}

@GUID("51973C13-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugCodeContext : IUnknown
{
    HRESULT GetDocumentContext(IDebugDocumentContext* ppsc);
    HRESULT SetBreakPoint(BREAKPOINT_STATE bps);
}

@GUID("51973C14-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugExpression : IUnknown
{
    HRESULT Start(IDebugExpressionCallBack pdecb);
    HRESULT Abort();
    HRESULT QueryIsComplete();
    HRESULT GetResultAsString(int* phrResult, BSTR* pbstrResult);
    HRESULT GetResultAsDebugProperty(int* phrResult, IDebugProperty* ppdp);
}

@GUID("51973C15-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugExpressionContext : IUnknown
{
    HRESULT ParseLanguageText(ushort* pstrCode, uint nRadix, ushort* pstrDelimiter, uint dwFlags, 
                              IDebugExpression* ppe);
    HRESULT GetLanguageInfo(BSTR* pbstrLanguageName, GUID* pLanguageID);
}

@GUID("51973C16-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugExpressionCallBack : IUnknown
{
    HRESULT onComplete();
}

@GUID("51973C17-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugStackFrame : IUnknown
{
    HRESULT GetCodeContext(IDebugCodeContext* ppcc);
    HRESULT GetDescriptionString(BOOL fLong, BSTR* pbstrDescription);
    HRESULT GetLanguageString(BOOL fLong, BSTR* pbstrLanguage);
    HRESULT GetThread(IDebugApplicationThread* ppat);
    HRESULT GetDebugProperty(IDebugProperty* ppDebugProp);
}

@GUID("51973C18-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugStackFrameSniffer : IUnknown
{
    HRESULT EnumStackFrames(IEnumDebugStackFrames* ppedsf);
}

@GUID("51973C19-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugStackFrameSnifferEx32 : IDebugStackFrameSniffer
{
    HRESULT EnumStackFramesEx32(uint dwSpMin, IEnumDebugStackFrames* ppedsf);
}

@GUID("8CD12AF4-49C1-4D52-8D8A-C146F47581AA")
interface IDebugStackFrameSnifferEx64 : IDebugStackFrameSniffer
{
    HRESULT EnumStackFramesEx64(ulong dwSpMin, IEnumDebugStackFrames64* ppedsf);
}

@GUID("51973C1A-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugSyncOperation : IUnknown
{
    HRESULT GetTargetThread(IDebugApplicationThread* ppatTarget);
    HRESULT Execute(IUnknown* ppunkResult);
    HRESULT InProgressAbort();
}

@GUID("51973C1B-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugAsyncOperation : IUnknown
{
    HRESULT GetSyncDebugOperation(IDebugSyncOperation* ppsdo);
    HRESULT Start(IDebugAsyncOperationCallBack padocb);
    HRESULT Abort();
    HRESULT QueryIsComplete();
    HRESULT GetResult(int* phrResult, IUnknown* ppunkResult);
}

@GUID("51973C1C-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugAsyncOperationCallBack : IUnknown
{
    HRESULT onComplete();
}

@GUID("51973C1D-CB0C-11D0-B5C9-00A0244A0E7A")
interface IEnumDebugCodeContexts : IUnknown
{
    HRESULT Next(uint celt, IDebugCodeContext* pscc, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumDebugCodeContexts* ppescc);
}

@GUID("51973C1E-CB0C-11D0-B5C9-00A0244A0E7A")
interface IEnumDebugStackFrames : IUnknown
{
    HRESULT Next(uint celt, DebugStackFrameDescriptor* prgdsfd, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumDebugStackFrames* ppedsf);
}

@GUID("0DC38853-C1B0-4176-A984-B298361027AF")
interface IEnumDebugStackFrames64 : IEnumDebugStackFrames
{
    HRESULT Next64(uint celt, DebugStackFrameDescriptor64* prgdsfd, uint* pceltFetched);
}

@GUID("51973C1F-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugDocumentInfo : IUnknown
{
    HRESULT GetName(DOCUMENTNAMETYPE dnt, BSTR* pbstrName);
    HRESULT GetDocumentClassId(GUID* pclsidDocument);
}

@GUID("51973C20-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugDocumentProvider : IDebugDocumentInfo
{
    HRESULT GetDocument(IDebugDocument* ppssd);
}

@GUID("51973C21-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugDocument : IDebugDocumentInfo
{
}

@GUID("51973C22-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugDocumentText : IDebugDocument
{
    HRESULT GetDocumentAttributes(uint* ptextdocattr);
    HRESULT GetSize(uint* pcNumLines, uint* pcNumChars);
    HRESULT GetPositionOfLine(uint cLineNumber, uint* pcCharacterPosition);
    HRESULT GetLineOfPosition(uint cCharacterPosition, uint* pcLineNumber, uint* pcCharacterOffsetInLine);
    HRESULT GetText(uint cCharacterPosition, char* pcharText, char* pstaTextAttr, uint* pcNumChars, uint cMaxChars);
    HRESULT GetPositionOfContext(IDebugDocumentContext psc, uint* pcCharacterPosition, uint* cNumChars);
    HRESULT GetContextOfPosition(uint cCharacterPosition, uint cNumChars, IDebugDocumentContext* ppsc);
}

@GUID("51973C23-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugDocumentTextEvents : IUnknown
{
    HRESULT onDestroy();
    HRESULT onInsertText(uint cCharacterPosition, uint cNumToInsert);
    HRESULT onRemoveText(uint cCharacterPosition, uint cNumToRemove);
    HRESULT onReplaceText(uint cCharacterPosition, uint cNumToReplace);
    HRESULT onUpdateTextAttributes(uint cCharacterPosition, uint cNumToUpdate);
    HRESULT onUpdateDocumentAttributes(uint textdocattr);
}

@GUID("51973C24-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugDocumentTextAuthor : IDebugDocumentText
{
    HRESULT InsertText(uint cCharacterPosition, uint cNumToInsert, char* pcharText);
    HRESULT RemoveText(uint cCharacterPosition, uint cNumToRemove);
    HRESULT ReplaceTextA(uint cCharacterPosition, uint cNumToReplace, char* pcharText);
}

@GUID("51973C25-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugDocumentTextExternalAuthor : IUnknown
{
    HRESULT GetPathName(BSTR* pbstrLongName, int* pfIsOriginalFile);
    HRESULT GetFileName(BSTR* pbstrShortName);
    HRESULT NotifyChanged();
}

@GUID("51973C26-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugDocumentHelper32 : IUnknown
{
    HRESULT Init(IDebugApplication32 pda, ushort* pszShortName, ushort* pszLongName, uint docAttr);
    HRESULT Attach(IDebugDocumentHelper32 pddhParent);
    HRESULT Detach();
    HRESULT AddUnicodeText(ushort* pszText);
    HRESULT AddDBCSText(const(char)* pszText);
    HRESULT SetDebugDocumentHost(IDebugDocumentHost pddh);
    HRESULT AddDeferredText(uint cChars, uint dwTextStartCookie);
    HRESULT DefineScriptBlock(uint ulCharOffset, uint cChars, IActiveScript pas, BOOL fScriptlet, 
                              uint* pdwSourceContext);
    HRESULT SetDefaultTextAttr(ushort staTextAttr);
    HRESULT SetTextAttributes(uint ulCharOffset, uint cChars, char* pstaTextAttr);
    HRESULT SetLongName(ushort* pszLongName);
    HRESULT SetShortName(ushort* pszShortName);
    HRESULT SetDocumentAttr(uint pszAttributes);
    HRESULT GetDebugApplicationNode(IDebugApplicationNode* ppdan);
    HRESULT GetScriptBlockInfo(uint dwSourceContext, IActiveScript* ppasd, uint* piCharPos, uint* pcChars);
    HRESULT CreateDebugDocumentContext(uint iCharPos, uint cChars, IDebugDocumentContext* ppddc);
    HRESULT BringDocumentToTop();
    HRESULT BringDocumentContextToTop(IDebugDocumentContext pddc);
}

@GUID("C4C7363C-20FD-47F9-BD82-4855E0150871")
interface IDebugDocumentHelper64 : IUnknown
{
    HRESULT Init(IDebugApplication64 pda, ushort* pszShortName, ushort* pszLongName, uint docAttr);
    HRESULT Attach(IDebugDocumentHelper64 pddhParent);
    HRESULT Detach();
    HRESULT AddUnicodeText(ushort* pszText);
    HRESULT AddDBCSText(const(char)* pszText);
    HRESULT SetDebugDocumentHost(IDebugDocumentHost pddh);
    HRESULT AddDeferredText(uint cChars, uint dwTextStartCookie);
    HRESULT DefineScriptBlock(uint ulCharOffset, uint cChars, IActiveScript pas, BOOL fScriptlet, 
                              ulong* pdwSourceContext);
    HRESULT SetDefaultTextAttr(ushort staTextAttr);
    HRESULT SetTextAttributes(uint ulCharOffset, uint cChars, char* pstaTextAttr);
    HRESULT SetLongName(ushort* pszLongName);
    HRESULT SetShortName(ushort* pszShortName);
    HRESULT SetDocumentAttr(uint pszAttributes);
    HRESULT GetDebugApplicationNode(IDebugApplicationNode* ppdan);
    HRESULT GetScriptBlockInfo(ulong dwSourceContext, IActiveScript* ppasd, uint* piCharPos, uint* pcChars);
    HRESULT CreateDebugDocumentContext(uint iCharPos, uint cChars, IDebugDocumentContext* ppddc);
    HRESULT BringDocumentToTop();
    HRESULT BringDocumentContextToTop(IDebugDocumentContext pddc);
}

@GUID("51973C27-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugDocumentHost : IUnknown
{
    HRESULT GetDeferredText(uint dwTextStartCookie, char* pcharText, char* pstaTextAttr, uint* pcNumChars, 
                            uint cMaxChars);
    HRESULT GetScriptTextAttributes(char* pstrCode, uint uNumCodeChars, ushort* pstrDelimiter, uint dwFlags, 
                                    char* pattr);
    HRESULT OnCreateDocumentContext(IUnknown* ppunkOuter);
    HRESULT GetPathName(BSTR* pbstrLongName, int* pfIsOriginalFile);
    HRESULT GetFileName(BSTR* pbstrShortName);
    HRESULT NotifyChanged();
}

@GUID("51973C28-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugDocumentContext : IUnknown
{
    HRESULT GetDocument(IDebugDocument* ppsd);
    HRESULT EnumCodeContexts(IEnumDebugCodeContexts* ppescc);
}

@GUID("51973C29-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugSessionProvider : IUnknown
{
    HRESULT StartDebugSession(IRemoteDebugApplication pda);
}

@GUID("51973C2A-CB0C-11D0-B5C9-00A0244A0E7A")
interface IApplicationDebugger : IUnknown
{
    HRESULT QueryAlive();
    HRESULT CreateInstanceAtDebugger(const(GUID)* rclsid, IUnknown pUnkOuter, uint dwClsContext, const(GUID)* riid, 
                                     IUnknown* ppvObject);
    HRESULT onDebugOutput(ushort* pstr);
    HRESULT onHandleBreakPoint(IRemoteDebugApplicationThread prpt, BREAKREASON br, IActiveScriptErrorDebug pError);
    HRESULT onClose();
    HRESULT onDebuggerEvent(const(GUID)* riid, IUnknown punk);
}

@GUID("51973C2B-CB0C-11D0-B5C9-00A0244A0E7A")
interface IApplicationDebuggerUI : IUnknown
{
    HRESULT BringDocumentToTop(IDebugDocumentText pddt);
    HRESULT BringDocumentContextToTop(IDebugDocumentContext pddc);
}

@GUID("51973C2C-CB0C-11D0-B5C9-00A0244A0E7A")
interface IMachineDebugManager : IUnknown
{
    HRESULT AddApplication(IRemoteDebugApplication pda, uint* pdwAppCookie);
    HRESULT RemoveApplication(uint dwAppCookie);
    HRESULT EnumApplications(IEnumRemoteDebugApplications* ppeda);
}

@GUID("51973C2D-CB0C-11D0-B5C9-00A0244A0E7A")
interface IMachineDebugManagerCookie : IUnknown
{
    HRESULT AddApplication(IRemoteDebugApplication pda, uint dwDebugAppCookie, uint* pdwAppCookie);
    HRESULT RemoveApplication(uint dwDebugAppCookie, uint dwAppCookie);
    HRESULT EnumApplications(IEnumRemoteDebugApplications* ppeda);
}

@GUID("51973C2E-CB0C-11D0-B5C9-00A0244A0E7A")
interface IMachineDebugManagerEvents : IUnknown
{
    HRESULT onAddApplication(IRemoteDebugApplication pda, uint dwAppCookie);
    HRESULT onRemoveApplication(IRemoteDebugApplication pda, uint dwAppCookie);
}

@GUID("51973C2F-CB0C-11D0-B5C9-00A0244A0E7A")
interface IProcessDebugManager32 : IUnknown
{
    HRESULT CreateApplication(IDebugApplication32* ppda);
    HRESULT GetDefaultApplication(IDebugApplication32* ppda);
    HRESULT AddApplication(IDebugApplication32 pda, uint* pdwAppCookie);
    HRESULT RemoveApplication(uint dwAppCookie);
    HRESULT CreateDebugDocumentHelper(IUnknown punkOuter, IDebugDocumentHelper32* pddh);
}

@GUID("56B9FC1C-63A9-4CC1-AC21-087D69A17FAB")
interface IProcessDebugManager64 : IUnknown
{
    HRESULT CreateApplication(IDebugApplication64* ppda);
    HRESULT GetDefaultApplication(IDebugApplication64* ppda);
    HRESULT AddApplication(IDebugApplication64 pda, uint* pdwAppCookie);
    HRESULT RemoveApplication(uint dwAppCookie);
    HRESULT CreateDebugDocumentHelper(IUnknown punkOuter, IDebugDocumentHelper64* pddh);
}

@GUID("51973C30-CB0C-11D0-B5C9-00A0244A0E7A")
interface IRemoteDebugApplication : IUnknown
{
    HRESULT ResumeFromBreakPoint(IRemoteDebugApplicationThread prptFocus, tagBREAKRESUME_ACTION bra, 
                                 ERRORRESUMEACTION era);
    HRESULT CauseBreak();
    HRESULT ConnectDebugger(IApplicationDebugger pad);
    HRESULT DisconnectDebugger();
    HRESULT GetDebugger(IApplicationDebugger* pad);
    HRESULT CreateInstanceAtApplication(const(GUID)* rclsid, IUnknown pUnkOuter, uint dwClsContext, 
                                        const(GUID)* riid, IUnknown* ppvObject);
    HRESULT QueryAlive();
    HRESULT EnumThreads(IEnumRemoteDebugApplicationThreads* pperdat);
    HRESULT GetName(BSTR* pbstrName);
    HRESULT GetRootNode(IDebugApplicationNode* ppdanRoot);
    HRESULT EnumGlobalExpressionContexts(IEnumDebugExpressionContexts* ppedec);
}

@GUID("51973C32-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugApplication32 : IRemoteDebugApplication
{
    HRESULT SetName(ushort* pstrName);
    HRESULT StepOutComplete();
    HRESULT DebugOutput(ushort* pstr);
    HRESULT StartDebugSession();
    HRESULT HandleBreakPoint(BREAKREASON br, tagBREAKRESUME_ACTION* pbra);
    HRESULT Close();
    HRESULT GetBreakFlags(uint* pabf, IRemoteDebugApplicationThread* pprdatSteppingThread);
    HRESULT GetCurrentThread(IDebugApplicationThread* pat);
    HRESULT CreateAsyncDebugOperation(IDebugSyncOperation psdo, IDebugAsyncOperation* ppado);
    HRESULT AddStackFrameSniffer(IDebugStackFrameSniffer pdsfs, uint* pdwCookie);
    HRESULT RemoveStackFrameSniffer(uint dwCookie);
    HRESULT QueryCurrentThreadIsDebuggerThread();
    HRESULT SynchronousCallInDebuggerThread(IDebugThreadCall32 pptc, uint dwParam1, uint dwParam2, uint dwParam3);
    HRESULT CreateApplicationNode(IDebugApplicationNode* ppdanNew);
    HRESULT FireDebuggerEvent(const(GUID)* riid, IUnknown punk);
    HRESULT HandleRuntimeError(IActiveScriptErrorDebug pErrorDebug, IActiveScriptSite pScriptSite, 
                               tagBREAKRESUME_ACTION* pbra, ERRORRESUMEACTION* perra, int* pfCallOnScriptError);
    BOOL    FCanJitDebug();
    BOOL    FIsAutoJitDebugEnabled();
    HRESULT AddGlobalExpressionContextProvider(IProvideExpressionContexts pdsfs, uint* pdwCookie);
    HRESULT RemoveGlobalExpressionContextProvider(uint dwCookie);
}

@GUID("4DEDC754-04C7-4F10-9E60-16A390FE6E62")
interface IDebugApplication64 : IRemoteDebugApplication
{
    HRESULT SetName(ushort* pstrName);
    HRESULT StepOutComplete();
    HRESULT DebugOutput(ushort* pstr);
    HRESULT StartDebugSession();
    HRESULT HandleBreakPoint(BREAKREASON br, tagBREAKRESUME_ACTION* pbra);
    HRESULT Close();
    HRESULT GetBreakFlags(uint* pabf, IRemoteDebugApplicationThread* pprdatSteppingThread);
    HRESULT GetCurrentThread(IDebugApplicationThread* pat);
    HRESULT CreateAsyncDebugOperation(IDebugSyncOperation psdo, IDebugAsyncOperation* ppado);
    HRESULT AddStackFrameSniffer(IDebugStackFrameSniffer pdsfs, uint* pdwCookie);
    HRESULT RemoveStackFrameSniffer(uint dwCookie);
    HRESULT QueryCurrentThreadIsDebuggerThread();
    HRESULT SynchronousCallInDebuggerThread(IDebugThreadCall64 pptc, ulong dwParam1, ulong dwParam2, 
                                            ulong dwParam3);
    HRESULT CreateApplicationNode(IDebugApplicationNode* ppdanNew);
    HRESULT FireDebuggerEvent(const(GUID)* riid, IUnknown punk);
    HRESULT HandleRuntimeError(IActiveScriptErrorDebug pErrorDebug, IActiveScriptSite pScriptSite, 
                               tagBREAKRESUME_ACTION* pbra, ERRORRESUMEACTION* perra, int* pfCallOnScriptError);
    BOOL    FCanJitDebug();
    BOOL    FIsAutoJitDebugEnabled();
    HRESULT AddGlobalExpressionContextProvider(IProvideExpressionContexts pdsfs, ulong* pdwCookie);
    HRESULT RemoveGlobalExpressionContextProvider(ulong dwCookie);
}

@GUID("51973C33-CB0C-11D0-B5C9-00A0244A0E7A")
interface IRemoteDebugApplicationEvents : IUnknown
{
    HRESULT OnConnectDebugger(IApplicationDebugger pad);
    HRESULT OnDisconnectDebugger();
    HRESULT OnSetName(ushort* pstrName);
    HRESULT OnDebugOutput(ushort* pstr);
    HRESULT OnClose();
    HRESULT OnEnterBreakPoint(IRemoteDebugApplicationThread prdat);
    HRESULT OnLeaveBreakPoint(IRemoteDebugApplicationThread prdat);
    HRESULT OnCreateThread(IRemoteDebugApplicationThread prdat);
    HRESULT OnDestroyThread(IRemoteDebugApplicationThread prdat);
    HRESULT OnBreakFlagChange(uint abf, IRemoteDebugApplicationThread prdatSteppingThread);
}

@GUID("51973C34-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugApplicationNode : IDebugDocumentProvider
{
    HRESULT EnumChildren(IEnumDebugApplicationNodes* pperddp);
    HRESULT GetParent(IDebugApplicationNode* pprddp);
    HRESULT SetDocumentProvider(IDebugDocumentProvider pddp);
    HRESULT Close();
    HRESULT Attach(IDebugApplicationNode pdanParent);
    HRESULT Detach();
}

@GUID("51973C35-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugApplicationNodeEvents : IUnknown
{
    HRESULT onAddChild(IDebugApplicationNode prddpChild);
    HRESULT onRemoveChild(IDebugApplicationNode prddpChild);
    HRESULT onDetach();
    HRESULT onAttach(IDebugApplicationNode prddpParent);
}

@GUID("A2E3AA3B-AA8D-4EBF-84CD-648B737B8C13")
interface AsyncIDebugApplicationNodeEvents : IUnknown
{
    HRESULT Begin_onAddChild(IDebugApplicationNode prddpChild);
    HRESULT Finish_onAddChild();
    HRESULT Begin_onRemoveChild(IDebugApplicationNode prddpChild);
    HRESULT Finish_onRemoveChild();
    HRESULT Begin_onDetach();
    HRESULT Finish_onDetach();
    HRESULT Begin_onAttach(IDebugApplicationNode prddpParent);
    HRESULT Finish_onAttach();
}

@GUID("51973C36-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugThreadCall32 : IUnknown
{
    HRESULT ThreadCallHandler(uint dwParam1, uint dwParam2, uint dwParam3);
}

@GUID("CB3FA335-E979-42FD-9FCF-A7546A0F3905")
interface IDebugThreadCall64 : IUnknown
{
    HRESULT ThreadCallHandler(ulong dwParam1, ulong dwParam2, ulong dwParam3);
}

@GUID("51973C37-CB0C-11D0-B5C9-00A0244A0E7A")
interface IRemoteDebugApplicationThread : IUnknown
{
    HRESULT GetSystemThreadId(uint* dwThreadId);
    HRESULT GetApplication(IRemoteDebugApplication* pprda);
    HRESULT EnumStackFrames(IEnumDebugStackFrames* ppedsf);
    HRESULT GetDescription(BSTR* pbstrDescription, BSTR* pbstrState);
    HRESULT SetNextStatement(IDebugStackFrame pStackFrame, IDebugCodeContext pCodeContext);
    HRESULT GetState(uint* pState);
    HRESULT Suspend(uint* pdwCount);
    HRESULT Resume(uint* pdwCount);
    HRESULT GetSuspendCount(uint* pdwCount);
}

@GUID("51973C38-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugApplicationThread : IRemoteDebugApplicationThread
{
    HRESULT SynchronousCallIntoThread32(IDebugThreadCall32 pstcb, uint dwParam1, uint dwParam2, uint dwParam3);
    HRESULT QueryIsCurrentThread();
    HRESULT QueryIsDebuggerThread();
    HRESULT SetDescription(ushort* pstrDescription);
    HRESULT SetStateString(ushort* pstrState);
}

@GUID("9DAC5886-DBAD-456D-9DEE-5DEC39AB3DDA")
interface IDebugApplicationThread64 : IDebugApplicationThread
{
    HRESULT SynchronousCallIntoThread64(IDebugThreadCall64 pstcb, ulong dwParam1, ulong dwParam2, ulong dwParam3);
}

@GUID("51973C39-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugCookie : IUnknown
{
    HRESULT SetDebugCookie(uint dwDebugAppCookie);
}

@GUID("51973C3A-CB0C-11D0-B5C9-00A0244A0E7A")
interface IEnumDebugApplicationNodes : IUnknown
{
    HRESULT Next(uint celt, IDebugApplicationNode* pprddp, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumDebugApplicationNodes* pperddp);
}

@GUID("51973C3B-CB0C-11D0-B5C9-00A0244A0E7A")
interface IEnumRemoteDebugApplications : IUnknown
{
    HRESULT Next(uint celt, IRemoteDebugApplication* ppda, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumRemoteDebugApplications* ppessd);
}

@GUID("51973C3C-CB0C-11D0-B5C9-00A0244A0E7A")
interface IEnumRemoteDebugApplicationThreads : IUnknown
{
    HRESULT Next(uint celt, IRemoteDebugApplicationThread* pprdat, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumRemoteDebugApplicationThreads* pperdat);
}

@GUID("51973C05-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugFormatter : IUnknown
{
    HRESULT GetStringForVariant(VARIANT* pvar, uint nRadix, BSTR* pbstrValue);
    HRESULT GetVariantForString(ushort* pwstrValue, VARIANT* pvar);
    HRESULT GetStringForVarType(ushort vt, TYPEDESC* ptdescArrayType, BSTR* pbstr);
}

@GUID("51973C3E-CB0C-11D0-B5C9-00A0244A0E7A")
interface ISimpleConnectionPoint : IUnknown
{
    HRESULT GetEventCount(uint* pulCount);
    HRESULT DescribeEvents(uint iEvent, uint cEvents, int* prgid, BSTR* prgbstr, uint* pcEventsFetched);
    HRESULT Advise(IDispatch pdisp, uint* pdwCookie);
    HRESULT Unadvise(uint dwCookie);
}

@GUID("51973C3F-CB0C-11D0-B5C9-00A0244A0E7A")
interface IDebugHelper : IUnknown
{
    HRESULT CreatePropertyBrowser(VARIANT* pvar, ushort* bstrName, IDebugApplicationThread pdat, 
                                  IDebugProperty* ppdob);
    HRESULT CreatePropertyBrowserEx(VARIANT* pvar, ushort* bstrName, IDebugApplicationThread pdat, 
                                    IDebugFormatter pdf, IDebugProperty* ppdob);
    HRESULT CreateSimpleConnectionPoint(IDispatch pdisp, ISimpleConnectionPoint* ppscp);
}

@GUID("51973C40-CB0C-11D0-B5C9-00A0244A0E7A")
interface IEnumDebugExpressionContexts : IUnknown
{
    HRESULT Next(uint celt, IDebugExpressionContext* ppdec, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumDebugExpressionContexts* ppedec);
}

@GUID("51973C41-CB0C-11D0-B5C9-00A0244A0E7A")
interface IProvideExpressionContexts : IUnknown
{
    HRESULT EnumExpressionContexts(IEnumDebugExpressionContexts* ppedec);
}

@GUID("784B5FF0-69B0-47D1-A7DC-2518F4230E90")
interface IActiveScriptProfilerControl : IUnknown
{
    HRESULT StartProfiling(const(GUID)* clsidProfilerObject, uint dwEventMask, uint dwContext);
    HRESULT SetProfilerEventMask(uint dwEventMask);
    HRESULT StopProfiling(HRESULT hrShutdownReason);
}

@GUID("47810165-498F-40BE-94F1-653557E9E7DA")
interface IActiveScriptProfilerControl2 : IActiveScriptProfilerControl
{
    HRESULT CompleteProfilerStart();
    HRESULT PrepareProfilerStop();
}

@GUID("32E4694E-0D37-419B-B93D-FA20DED6E8EA")
interface IActiveScriptProfilerHeapEnum : IUnknown
{
    HRESULT Next(uint celt, PROFILER_HEAP_OBJECT** heapObjects, uint* pceltFetched);
    HRESULT GetOptionalInfo(PROFILER_HEAP_OBJECT* heapObject, uint celt, 
                            PROFILER_HEAP_OBJECT_OPTIONAL_INFO* optionalInfo);
    HRESULT FreeObjectAndOptionalInfo(uint celt, PROFILER_HEAP_OBJECT** heapObjects);
    HRESULT GetNameIdMap(ushort*** pNameList, uint* pcelt);
}

@GUID("0B403015-F381-4023-A5D0-6FED076DE716")
interface IActiveScriptProfilerControl3 : IActiveScriptProfilerControl2
{
    HRESULT EnumHeap(IActiveScriptProfilerHeapEnum* ppEnum);
}

@GUID("160F94FD-9DBC-40D4-9EAC-2B71DB3132F4")
interface IActiveScriptProfilerControl4 : IActiveScriptProfilerControl3
{
    HRESULT SummarizeHeap(PROFILER_HEAP_SUMMARY* heapSummary);
}

@GUID("1C01A2D1-8F0F-46A5-9720-0D7ED2C62F0A")
interface IActiveScriptProfilerControl5 : IActiveScriptProfilerControl4
{
    HRESULT EnumHeap2(__MIDL___MIDL_itf_activprof_0000_0002_0004 enumFlags, IActiveScriptProfilerHeapEnum* ppEnum);
}

@GUID("740ECA23-7D9D-42E5-BA9D-F8B24B1C7A9B")
interface IActiveScriptProfilerCallback : IUnknown
{
    HRESULT Initialize(uint dwContext);
    HRESULT Shutdown(HRESULT hrReason);
    HRESULT ScriptCompiled(int scriptId, __MIDL___MIDL_itf_activprof_0000_0000_0001 type, 
                           IUnknown pIDebugDocumentContext);
    HRESULT FunctionCompiled(int functionId, int scriptId, const(wchar)* pwszFunctionName, 
                             const(wchar)* pwszFunctionNameHint, IUnknown pIDebugDocumentContext);
    HRESULT OnFunctionEnter(int scriptId, int functionId);
    HRESULT OnFunctionExit(int scriptId, int functionId);
}

@GUID("31B7F8AD-A637-409C-B22F-040995B6103D")
interface IActiveScriptProfilerCallback2 : IActiveScriptProfilerCallback
{
    HRESULT OnFunctionEnterByName(const(wchar)* pwszFunctionName, __MIDL___MIDL_itf_activprof_0000_0000_0001 type);
    HRESULT OnFunctionExitByName(const(wchar)* pwszFunctionName, __MIDL___MIDL_itf_activprof_0000_0000_0001 type);
}

@GUID("6AC5AD25-2037-4687-91DF-B59979D93D73")
interface IActiveScriptProfilerCallback3 : IActiveScriptProfilerCallback2
{
    HRESULT SetWebWorkerId(uint webWorkerId);
}

@GUID("3050F3EE-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLFiltersCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT* pvarIndex, VARIANT* pvarResult);
}

@GUID("3051046B-98B5-11CF-BB82-00AA00BDCE0B")
interface IIE70DispatchEx : IDispatchEx
{
}

@GUID("3051046C-98B5-11CF-BB82-00AA00BDCE0B")
interface IIE80DispatchEx : IDispatchEx
{
}

@GUID("3050F32D-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLEventObj : IDispatch
{
    HRESULT get_srcElement(IHTMLElement* p);
    HRESULT get_altKey(short* p);
    HRESULT get_ctrlKey(short* p);
    HRESULT get_shiftKey(short* p);
    HRESULT put_returnValue(VARIANT v);
    HRESULT get_returnValue(VARIANT* p);
    HRESULT put_cancelBubble(short v);
    HRESULT get_cancelBubble(short* p);
    HRESULT get_fromElement(IHTMLElement* p);
    HRESULT get_toElement(IHTMLElement* p);
    HRESULT put_keyCode(int v);
    HRESULT get_keyCode(int* p);
    HRESULT get_button(int* p);
    HRESULT get_type(BSTR* p);
    HRESULT get_qualifier(BSTR* p);
    HRESULT get_reason(int* p);
    HRESULT get_x(int* p);
    HRESULT get_y(int* p);
    HRESULT get_clientX(int* p);
    HRESULT get_clientY(int* p);
    HRESULT get_offsetX(int* p);
    HRESULT get_offsetY(int* p);
    HRESULT get_screenX(int* p);
    HRESULT get_screenY(int* p);
    HRESULT get_srcFilter(IDispatch* p);
}

@GUID("3050F427-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementBehaviorSite : IUnknown
{
    HRESULT GetElement(IHTMLElement* ppElement);
    HRESULT RegisterNotification(int lEvent);
}

@GUID("3050F425-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementBehavior : IUnknown
{
    HRESULT Init(IElementBehaviorSite pBehaviorSite);
    HRESULT Notify(int lEvent, VARIANT* pVar);
    HRESULT Detach();
}

@GUID("3050F429-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementBehaviorFactory : IUnknown
{
    HRESULT FindBehavior(BSTR bstrBehavior, BSTR bstrBehaviorUrl, IElementBehaviorSite pSite, 
                         IElementBehavior* ppBehavior);
}

@GUID("3050F489-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementBehaviorSiteOM : IUnknown
{
    HRESULT RegisterEvent(ushort* pchEvent, int lFlags, int* plCookie);
    HRESULT GetEventCookie(ushort* pchEvent, int* plCookie);
    HRESULT FireEvent(int lCookie, IHTMLEventObj pEventObject);
    HRESULT CreateEventObject(IHTMLEventObj* ppEventObject);
    HRESULT RegisterName(ushort* pchName);
    HRESULT RegisterUrn(ushort* pchUrn);
}

@GUID("3050F4AA-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementBehaviorRender : IUnknown
{
    HRESULT Draw(HDC hdc, int lLayer, RECT* pRect, IUnknown pReserved);
    HRESULT GetRenderInfo(int* plRenderInfo);
    HRESULT HitTestPoint(POINT* pPoint, IUnknown pReserved, int* pbHit);
}

@GUID("3050F4A7-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementBehaviorSiteRender : IUnknown
{
    HRESULT Invalidate(RECT* pRect);
    HRESULT InvalidateRenderInfo();
    HRESULT InvalidateStyle();
}

@GUID("305104BA-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMEvent : IDispatch
{
    HRESULT get_bubbles(short* p);
    HRESULT get_cancelable(short* p);
    HRESULT get_currentTarget(IEventTarget* p);
    HRESULT get_defaultPrevented(short* p);
    HRESULT get_eventPhase(ushort* p);
    HRESULT get_target(IEventTarget* p);
    HRESULT get_timeStamp(ulong* p);
    HRESULT get_type(BSTR* p);
    HRESULT initEvent(BSTR eventType, short canBubble, short cancelable);
    HRESULT preventDefault();
    HRESULT stopPropagation();
    HRESULT stopImmediatePropagation();
    HRESULT get_isTrusted(short* p);
    HRESULT put_cancelBubble(short v);
    HRESULT get_cancelBubble(short* p);
    HRESULT get_srcElement(IHTMLElement* p);
}

@GUID("3051049B-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDOMConstructor : IDispatch
{
    HRESULT get_constructor(IDispatch* p);
    HRESULT LookupGetter(BSTR propname, VARIANT* ppDispHandler);
    HRESULT LookupSetter(BSTR propname, VARIANT* ppDispHandler);
    HRESULT DefineGetter(BSTR propname, VARIANT* pdispHandler);
    HRESULT DefineSetter(BSTR propname, VARIANT* pdispHandler);
}

@GUID("3050F357-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleSheetRule : IDispatch
{
    HRESULT put_selectorText(BSTR v);
    HRESULT get_selectorText(BSTR* p);
    HRESULT get_style(IHTMLRuleStyle* p);
    HRESULT get_readOnly(short* p);
}

@GUID("30510740-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLCSSStyleDeclaration : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get_parentRule(VARIANT* p);
    HRESULT getPropertyValue(BSTR bstrPropertyName, BSTR* pbstrPropertyValue);
    HRESULT getPropertyPriority(BSTR bstrPropertyName, BSTR* pbstrPropertyPriority);
    HRESULT removeProperty(BSTR bstrPropertyName, BSTR* pbstrPropertyValue);
    HRESULT setProperty(BSTR bstrPropertyName, VARIANT* pvarPropertyValue, VARIANT* pvarPropertyPriority);
    HRESULT item(int index, BSTR* pbstrPropertyName);
    HRESULT put_fontFamily(BSTR v);
    HRESULT get_fontFamily(BSTR* p);
    HRESULT put_fontStyle(BSTR v);
    HRESULT get_fontStyle(BSTR* p);
    HRESULT put_fontVariant(BSTR v);
    HRESULT get_fontVariant(BSTR* p);
    HRESULT put_fontWeight(BSTR v);
    HRESULT get_fontWeight(BSTR* p);
    HRESULT put_fontSize(VARIANT v);
    HRESULT get_fontSize(VARIANT* p);
    HRESULT put_font(BSTR v);
    HRESULT get_font(BSTR* p);
    HRESULT put_color(VARIANT v);
    HRESULT get_color(VARIANT* p);
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_backgroundColor(VARIANT v);
    HRESULT get_backgroundColor(VARIANT* p);
    HRESULT put_backgroundImage(BSTR v);
    HRESULT get_backgroundImage(BSTR* p);
    HRESULT put_backgroundRepeat(BSTR v);
    HRESULT get_backgroundRepeat(BSTR* p);
    HRESULT put_backgroundAttachment(BSTR v);
    HRESULT get_backgroundAttachment(BSTR* p);
    HRESULT put_backgroundPosition(BSTR v);
    HRESULT get_backgroundPosition(BSTR* p);
    HRESULT put_backgroundPositionX(VARIANT v);
    HRESULT get_backgroundPositionX(VARIANT* p);
    HRESULT put_backgroundPositionY(VARIANT v);
    HRESULT get_backgroundPositionY(VARIANT* p);
    HRESULT put_wordSpacing(VARIANT v);
    HRESULT get_wordSpacing(VARIANT* p);
    HRESULT put_letterSpacing(VARIANT v);
    HRESULT get_letterSpacing(VARIANT* p);
    HRESULT put_textDecoration(BSTR v);
    HRESULT get_textDecoration(BSTR* p);
    HRESULT put_verticalAlign(VARIANT v);
    HRESULT get_verticalAlign(VARIANT* p);
    HRESULT put_textTransform(BSTR v);
    HRESULT get_textTransform(BSTR* p);
    HRESULT put_textAlign(BSTR v);
    HRESULT get_textAlign(BSTR* p);
    HRESULT put_textIndent(VARIANT v);
    HRESULT get_textIndent(VARIANT* p);
    HRESULT put_lineHeight(VARIANT v);
    HRESULT get_lineHeight(VARIANT* p);
    HRESULT put_marginTop(VARIANT v);
    HRESULT get_marginTop(VARIANT* p);
    HRESULT put_marginRight(VARIANT v);
    HRESULT get_marginRight(VARIANT* p);
    HRESULT put_marginBottom(VARIANT v);
    HRESULT get_marginBottom(VARIANT* p);
    HRESULT put_marginLeft(VARIANT v);
    HRESULT get_marginLeft(VARIANT* p);
    HRESULT put_margin(BSTR v);
    HRESULT get_margin(BSTR* p);
    HRESULT put_paddingTop(VARIANT v);
    HRESULT get_paddingTop(VARIANT* p);
    HRESULT put_paddingRight(VARIANT v);
    HRESULT get_paddingRight(VARIANT* p);
    HRESULT put_paddingBottom(VARIANT v);
    HRESULT get_paddingBottom(VARIANT* p);
    HRESULT put_paddingLeft(VARIANT v);
    HRESULT get_paddingLeft(VARIANT* p);
    HRESULT put_padding(BSTR v);
    HRESULT get_padding(BSTR* p);
    HRESULT put_border(BSTR v);
    HRESULT get_border(BSTR* p);
    HRESULT put_borderTop(BSTR v);
    HRESULT get_borderTop(BSTR* p);
    HRESULT put_borderRight(BSTR v);
    HRESULT get_borderRight(BSTR* p);
    HRESULT put_borderBottom(BSTR v);
    HRESULT get_borderBottom(BSTR* p);
    HRESULT put_borderLeft(BSTR v);
    HRESULT get_borderLeft(BSTR* p);
    HRESULT put_borderColor(BSTR v);
    HRESULT get_borderColor(BSTR* p);
    HRESULT put_borderTopColor(VARIANT v);
    HRESULT get_borderTopColor(VARIANT* p);
    HRESULT put_borderRightColor(VARIANT v);
    HRESULT get_borderRightColor(VARIANT* p);
    HRESULT put_borderBottomColor(VARIANT v);
    HRESULT get_borderBottomColor(VARIANT* p);
    HRESULT put_borderLeftColor(VARIANT v);
    HRESULT get_borderLeftColor(VARIANT* p);
    HRESULT put_borderWidth(BSTR v);
    HRESULT get_borderWidth(BSTR* p);
    HRESULT put_borderTopWidth(VARIANT v);
    HRESULT get_borderTopWidth(VARIANT* p);
    HRESULT put_borderRightWidth(VARIANT v);
    HRESULT get_borderRightWidth(VARIANT* p);
    HRESULT put_borderBottomWidth(VARIANT v);
    HRESULT get_borderBottomWidth(VARIANT* p);
    HRESULT put_borderLeftWidth(VARIANT v);
    HRESULT get_borderLeftWidth(VARIANT* p);
    HRESULT put_borderStyle(BSTR v);
    HRESULT get_borderStyle(BSTR* p);
    HRESULT put_borderTopStyle(BSTR v);
    HRESULT get_borderTopStyle(BSTR* p);
    HRESULT put_borderRightStyle(BSTR v);
    HRESULT get_borderRightStyle(BSTR* p);
    HRESULT put_borderBottomStyle(BSTR v);
    HRESULT get_borderBottomStyle(BSTR* p);
    HRESULT put_borderLeftStyle(BSTR v);
    HRESULT get_borderLeftStyle(BSTR* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_styleFloat(BSTR v);
    HRESULT get_styleFloat(BSTR* p);
    HRESULT put_clear(BSTR v);
    HRESULT get_clear(BSTR* p);
    HRESULT put_display(BSTR v);
    HRESULT get_display(BSTR* p);
    HRESULT put_visibility(BSTR v);
    HRESULT get_visibility(BSTR* p);
    HRESULT put_listStyleType(BSTR v);
    HRESULT get_listStyleType(BSTR* p);
    HRESULT put_listStylePosition(BSTR v);
    HRESULT get_listStylePosition(BSTR* p);
    HRESULT put_listStyleImage(BSTR v);
    HRESULT get_listStyleImage(BSTR* p);
    HRESULT put_listStyle(BSTR v);
    HRESULT get_listStyle(BSTR* p);
    HRESULT put_whiteSpace(BSTR v);
    HRESULT get_whiteSpace(BSTR* p);
    HRESULT put_top(VARIANT v);
    HRESULT get_top(VARIANT* p);
    HRESULT put_left(VARIANT v);
    HRESULT get_left(VARIANT* p);
    HRESULT put_zIndex(VARIANT v);
    HRESULT get_zIndex(VARIANT* p);
    HRESULT put_overflow(BSTR v);
    HRESULT get_overflow(BSTR* p);
    HRESULT put_pageBreakBefore(BSTR v);
    HRESULT get_pageBreakBefore(BSTR* p);
    HRESULT put_pageBreakAfter(BSTR v);
    HRESULT get_pageBreakAfter(BSTR* p);
    HRESULT put_cssText(BSTR v);
    HRESULT get_cssText(BSTR* p);
    HRESULT put_cursor(BSTR v);
    HRESULT get_cursor(BSTR* p);
    HRESULT put_clip(BSTR v);
    HRESULT get_clip(BSTR* p);
    HRESULT put_filter(BSTR v);
    HRESULT get_filter(BSTR* p);
    HRESULT put_tableLayout(BSTR v);
    HRESULT get_tableLayout(BSTR* p);
    HRESULT put_borderCollapse(BSTR v);
    HRESULT get_borderCollapse(BSTR* p);
    HRESULT put_direction(BSTR v);
    HRESULT get_direction(BSTR* p);
    HRESULT put_behavior(BSTR v);
    HRESULT get_behavior(BSTR* p);
    HRESULT put_position(BSTR v);
    HRESULT get_position(BSTR* p);
    HRESULT put_unicodeBidi(BSTR v);
    HRESULT get_unicodeBidi(BSTR* p);
    HRESULT put_bottom(VARIANT v);
    HRESULT get_bottom(VARIANT* p);
    HRESULT put_right(VARIANT v);
    HRESULT get_right(VARIANT* p);
    HRESULT put_imeMode(BSTR v);
    HRESULT get_imeMode(BSTR* p);
    HRESULT put_rubyAlign(BSTR v);
    HRESULT get_rubyAlign(BSTR* p);
    HRESULT put_rubyPosition(BSTR v);
    HRESULT get_rubyPosition(BSTR* p);
    HRESULT put_rubyOverhang(BSTR v);
    HRESULT get_rubyOverhang(BSTR* p);
    HRESULT put_layoutGridChar(VARIANT v);
    HRESULT get_layoutGridChar(VARIANT* p);
    HRESULT put_layoutGridLine(VARIANT v);
    HRESULT get_layoutGridLine(VARIANT* p);
    HRESULT put_layoutGridMode(BSTR v);
    HRESULT get_layoutGridMode(BSTR* p);
    HRESULT put_layoutGridType(BSTR v);
    HRESULT get_layoutGridType(BSTR* p);
    HRESULT put_layoutGrid(BSTR v);
    HRESULT get_layoutGrid(BSTR* p);
    HRESULT put_textAutospace(BSTR v);
    HRESULT get_textAutospace(BSTR* p);
    HRESULT put_wordBreak(BSTR v);
    HRESULT get_wordBreak(BSTR* p);
    HRESULT put_lineBreak(BSTR v);
    HRESULT get_lineBreak(BSTR* p);
    HRESULT put_textJustify(BSTR v);
    HRESULT get_textJustify(BSTR* p);
    HRESULT put_textJustifyTrim(BSTR v);
    HRESULT get_textJustifyTrim(BSTR* p);
    HRESULT put_textKashida(VARIANT v);
    HRESULT get_textKashida(VARIANT* p);
    HRESULT put_overflowX(BSTR v);
    HRESULT get_overflowX(BSTR* p);
    HRESULT put_overflowY(BSTR v);
    HRESULT get_overflowY(BSTR* p);
    HRESULT put_accelerator(BSTR v);
    HRESULT get_accelerator(BSTR* p);
    HRESULT put_layoutFlow(BSTR v);
    HRESULT get_layoutFlow(BSTR* p);
    HRESULT put_zoom(VARIANT v);
    HRESULT get_zoom(VARIANT* p);
    HRESULT put_wordWrap(BSTR v);
    HRESULT get_wordWrap(BSTR* p);
    HRESULT put_textUnderlinePosition(BSTR v);
    HRESULT get_textUnderlinePosition(BSTR* p);
    HRESULT put_scrollbarBaseColor(VARIANT v);
    HRESULT get_scrollbarBaseColor(VARIANT* p);
    HRESULT put_scrollbarFaceColor(VARIANT v);
    HRESULT get_scrollbarFaceColor(VARIANT* p);
    HRESULT put_scrollbar3dLightColor(VARIANT v);
    HRESULT get_scrollbar3dLightColor(VARIANT* p);
    HRESULT put_scrollbarShadowColor(VARIANT v);
    HRESULT get_scrollbarShadowColor(VARIANT* p);
    HRESULT put_scrollbarHighlightColor(VARIANT v);
    HRESULT get_scrollbarHighlightColor(VARIANT* p);
    HRESULT put_scrollbarDarkShadowColor(VARIANT v);
    HRESULT get_scrollbarDarkShadowColor(VARIANT* p);
    HRESULT put_scrollbarArrowColor(VARIANT v);
    HRESULT get_scrollbarArrowColor(VARIANT* p);
    HRESULT put_scrollbarTrackColor(VARIANT v);
    HRESULT get_scrollbarTrackColor(VARIANT* p);
    HRESULT put_writingMode(BSTR v);
    HRESULT get_writingMode(BSTR* p);
    HRESULT put_textAlignLast(BSTR v);
    HRESULT get_textAlignLast(BSTR* p);
    HRESULT put_textKashidaSpace(VARIANT v);
    HRESULT get_textKashidaSpace(VARIANT* p);
    HRESULT put_textOverflow(BSTR v);
    HRESULT get_textOverflow(BSTR* p);
    HRESULT put_minHeight(VARIANT v);
    HRESULT get_minHeight(VARIANT* p);
    HRESULT put_msInterpolationMode(BSTR v);
    HRESULT get_msInterpolationMode(BSTR* p);
    HRESULT put_maxHeight(VARIANT v);
    HRESULT get_maxHeight(VARIANT* p);
    HRESULT put_minWidth(VARIANT v);
    HRESULT get_minWidth(VARIANT* p);
    HRESULT put_maxWidth(VARIANT v);
    HRESULT get_maxWidth(VARIANT* p);
    HRESULT put_content(BSTR v);
    HRESULT get_content(BSTR* p);
    HRESULT put_captionSide(BSTR v);
    HRESULT get_captionSide(BSTR* p);
    HRESULT put_counterIncrement(BSTR v);
    HRESULT get_counterIncrement(BSTR* p);
    HRESULT put_counterReset(BSTR v);
    HRESULT get_counterReset(BSTR* p);
    HRESULT put_outline(BSTR v);
    HRESULT get_outline(BSTR* p);
    HRESULT put_outlineWidth(VARIANT v);
    HRESULT get_outlineWidth(VARIANT* p);
    HRESULT put_outlineStyle(BSTR v);
    HRESULT get_outlineStyle(BSTR* p);
    HRESULT put_outlineColor(VARIANT v);
    HRESULT get_outlineColor(VARIANT* p);
    HRESULT put_boxSizing(BSTR v);
    HRESULT get_boxSizing(BSTR* p);
    HRESULT put_borderSpacing(BSTR v);
    HRESULT get_borderSpacing(BSTR* p);
    HRESULT put_orphans(VARIANT v);
    HRESULT get_orphans(VARIANT* p);
    HRESULT put_widows(VARIANT v);
    HRESULT get_widows(VARIANT* p);
    HRESULT put_pageBreakInside(BSTR v);
    HRESULT get_pageBreakInside(BSTR* p);
    HRESULT put_emptyCells(BSTR v);
    HRESULT get_emptyCells(BSTR* p);
    HRESULT put_msBlockProgression(BSTR v);
    HRESULT get_msBlockProgression(BSTR* p);
    HRESULT put_quotes(BSTR v);
    HRESULT get_quotes(BSTR* p);
    HRESULT put_alignmentBaseline(BSTR v);
    HRESULT get_alignmentBaseline(BSTR* p);
    HRESULT put_baselineShift(VARIANT v);
    HRESULT get_baselineShift(VARIANT* p);
    HRESULT put_dominantBaseline(BSTR v);
    HRESULT get_dominantBaseline(BSTR* p);
    HRESULT put_fontSizeAdjust(VARIANT v);
    HRESULT get_fontSizeAdjust(VARIANT* p);
    HRESULT put_fontStretch(BSTR v);
    HRESULT get_fontStretch(BSTR* p);
    HRESULT put_opacity(VARIANT v);
    HRESULT get_opacity(VARIANT* p);
    HRESULT put_clipPath(BSTR v);
    HRESULT get_clipPath(BSTR* p);
    HRESULT put_clipRule(BSTR v);
    HRESULT get_clipRule(BSTR* p);
    HRESULT put_fill(BSTR v);
    HRESULT get_fill(BSTR* p);
    HRESULT put_fillOpacity(VARIANT v);
    HRESULT get_fillOpacity(VARIANT* p);
    HRESULT put_fillRule(BSTR v);
    HRESULT get_fillRule(BSTR* p);
    HRESULT put_kerning(VARIANT v);
    HRESULT get_kerning(VARIANT* p);
    HRESULT put_marker(BSTR v);
    HRESULT get_marker(BSTR* p);
    HRESULT put_markerEnd(BSTR v);
    HRESULT get_markerEnd(BSTR* p);
    HRESULT put_markerMid(BSTR v);
    HRESULT get_markerMid(BSTR* p);
    HRESULT put_markerStart(BSTR v);
    HRESULT get_markerStart(BSTR* p);
    HRESULT put_mask(BSTR v);
    HRESULT get_mask(BSTR* p);
    HRESULT put_pointerEvents(BSTR v);
    HRESULT get_pointerEvents(BSTR* p);
    HRESULT put_stopColor(VARIANT v);
    HRESULT get_stopColor(VARIANT* p);
    HRESULT put_stopOpacity(VARIANT v);
    HRESULT get_stopOpacity(VARIANT* p);
    HRESULT put_stroke(BSTR v);
    HRESULT get_stroke(BSTR* p);
    HRESULT put_strokeDasharray(BSTR v);
    HRESULT get_strokeDasharray(BSTR* p);
    HRESULT put_strokeDashoffset(VARIANT v);
    HRESULT get_strokeDashoffset(VARIANT* p);
    HRESULT put_strokeLinecap(BSTR v);
    HRESULT get_strokeLinecap(BSTR* p);
    HRESULT put_strokeLinejoin(BSTR v);
    HRESULT get_strokeLinejoin(BSTR* p);
    HRESULT put_strokeMiterlimit(VARIANT v);
    HRESULT get_strokeMiterlimit(VARIANT* p);
    HRESULT put_strokeOpacity(VARIANT v);
    HRESULT get_strokeOpacity(VARIANT* p);
    HRESULT put_strokeWidth(VARIANT v);
    HRESULT get_strokeWidth(VARIANT* p);
    HRESULT put_textAnchor(BSTR v);
    HRESULT get_textAnchor(BSTR* p);
    HRESULT put_glyphOrientationHorizontal(VARIANT v);
    HRESULT get_glyphOrientationHorizontal(VARIANT* p);
    HRESULT put_glyphOrientationVertical(VARIANT v);
    HRESULT get_glyphOrientationVertical(VARIANT* p);
    HRESULT put_borderRadius(BSTR v);
    HRESULT get_borderRadius(BSTR* p);
    HRESULT put_borderTopLeftRadius(BSTR v);
    HRESULT get_borderTopLeftRadius(BSTR* p);
    HRESULT put_borderTopRightRadius(BSTR v);
    HRESULT get_borderTopRightRadius(BSTR* p);
    HRESULT put_borderBottomRightRadius(BSTR v);
    HRESULT get_borderBottomRightRadius(BSTR* p);
    HRESULT put_borderBottomLeftRadius(BSTR v);
    HRESULT get_borderBottomLeftRadius(BSTR* p);
    HRESULT put_clipTop(VARIANT v);
    HRESULT get_clipTop(VARIANT* p);
    HRESULT put_clipRight(VARIANT v);
    HRESULT get_clipRight(VARIANT* p);
    HRESULT get_clipBottom(VARIANT* p);
    HRESULT put_clipLeft(VARIANT v);
    HRESULT get_clipLeft(VARIANT* p);
    HRESULT put_cssFloat(BSTR v);
    HRESULT get_cssFloat(BSTR* p);
    HRESULT put_backgroundClip(BSTR v);
    HRESULT get_backgroundClip(BSTR* p);
    HRESULT put_backgroundOrigin(BSTR v);
    HRESULT get_backgroundOrigin(BSTR* p);
    HRESULT put_backgroundSize(BSTR v);
    HRESULT get_backgroundSize(BSTR* p);
    HRESULT put_boxShadow(BSTR v);
    HRESULT get_boxShadow(BSTR* p);
    HRESULT put_msTransform(BSTR v);
    HRESULT get_msTransform(BSTR* p);
    HRESULT put_msTransformOrigin(BSTR v);
    HRESULT get_msTransformOrigin(BSTR* p);
}

@GUID("305107D1-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLCSSStyleDeclaration2 : IDispatch
{
    HRESULT put_msScrollChaining(BSTR v);
    HRESULT get_msScrollChaining(BSTR* p);
    HRESULT put_msContentZooming(BSTR v);
    HRESULT get_msContentZooming(BSTR* p);
    HRESULT put_msContentZoomSnapType(BSTR v);
    HRESULT get_msContentZoomSnapType(BSTR* p);
    HRESULT put_msScrollRails(BSTR v);
    HRESULT get_msScrollRails(BSTR* p);
    HRESULT put_msContentZoomChaining(BSTR v);
    HRESULT get_msContentZoomChaining(BSTR* p);
    HRESULT put_msScrollSnapType(BSTR v);
    HRESULT get_msScrollSnapType(BSTR* p);
    HRESULT put_msContentZoomLimit(BSTR v);
    HRESULT get_msContentZoomLimit(BSTR* p);
    HRESULT put_msContentZoomSnap(BSTR v);
    HRESULT get_msContentZoomSnap(BSTR* p);
    HRESULT put_msContentZoomSnapPoints(BSTR v);
    HRESULT get_msContentZoomSnapPoints(BSTR* p);
    HRESULT put_msContentZoomLimitMin(VARIANT v);
    HRESULT get_msContentZoomLimitMin(VARIANT* p);
    HRESULT put_msContentZoomLimitMax(VARIANT v);
    HRESULT get_msContentZoomLimitMax(VARIANT* p);
    HRESULT put_msScrollSnapX(BSTR v);
    HRESULT get_msScrollSnapX(BSTR* p);
    HRESULT put_msScrollSnapY(BSTR v);
    HRESULT get_msScrollSnapY(BSTR* p);
    HRESULT put_msScrollSnapPointsX(BSTR v);
    HRESULT get_msScrollSnapPointsX(BSTR* p);
    HRESULT put_msScrollSnapPointsY(BSTR v);
    HRESULT get_msScrollSnapPointsY(BSTR* p);
    HRESULT put_msGridColumn(VARIANT v);
    HRESULT get_msGridColumn(VARIANT* p);
    HRESULT put_msGridColumnAlign(BSTR v);
    HRESULT get_msGridColumnAlign(BSTR* p);
    HRESULT put_msGridColumns(BSTR v);
    HRESULT get_msGridColumns(BSTR* p);
    HRESULT put_msGridColumnSpan(VARIANT v);
    HRESULT get_msGridColumnSpan(VARIANT* p);
    HRESULT put_msGridRow(VARIANT v);
    HRESULT get_msGridRow(VARIANT* p);
    HRESULT put_msGridRowAlign(BSTR v);
    HRESULT get_msGridRowAlign(BSTR* p);
    HRESULT put_msGridRows(BSTR v);
    HRESULT get_msGridRows(BSTR* p);
    HRESULT put_msGridRowSpan(VARIANT v);
    HRESULT get_msGridRowSpan(VARIANT* p);
    HRESULT put_msWrapThrough(BSTR v);
    HRESULT get_msWrapThrough(BSTR* p);
    HRESULT put_msWrapMargin(VARIANT v);
    HRESULT get_msWrapMargin(VARIANT* p);
    HRESULT put_msWrapFlow(BSTR v);
    HRESULT get_msWrapFlow(BSTR* p);
    HRESULT put_msAnimationName(BSTR v);
    HRESULT get_msAnimationName(BSTR* p);
    HRESULT put_msAnimationDuration(BSTR v);
    HRESULT get_msAnimationDuration(BSTR* p);
    HRESULT put_msAnimationTimingFunction(BSTR v);
    HRESULT get_msAnimationTimingFunction(BSTR* p);
    HRESULT put_msAnimationDelay(BSTR v);
    HRESULT get_msAnimationDelay(BSTR* p);
    HRESULT put_msAnimationDirection(BSTR v);
    HRESULT get_msAnimationDirection(BSTR* p);
    HRESULT put_msAnimationPlayState(BSTR v);
    HRESULT get_msAnimationPlayState(BSTR* p);
    HRESULT put_msAnimationIterationCount(BSTR v);
    HRESULT get_msAnimationIterationCount(BSTR* p);
    HRESULT put_msAnimation(BSTR v);
    HRESULT get_msAnimation(BSTR* p);
    HRESULT put_msAnimationFillMode(BSTR v);
    HRESULT get_msAnimationFillMode(BSTR* p);
    HRESULT put_colorInterpolationFilters(BSTR v);
    HRESULT get_colorInterpolationFilters(BSTR* p);
    HRESULT put_columnCount(VARIANT v);
    HRESULT get_columnCount(VARIANT* p);
    HRESULT put_columnWidth(VARIANT v);
    HRESULT get_columnWidth(VARIANT* p);
    HRESULT put_columnGap(VARIANT v);
    HRESULT get_columnGap(VARIANT* p);
    HRESULT put_columnFill(BSTR v);
    HRESULT get_columnFill(BSTR* p);
    HRESULT put_columnSpan(BSTR v);
    HRESULT get_columnSpan(BSTR* p);
    HRESULT put_columns(BSTR v);
    HRESULT get_columns(BSTR* p);
    HRESULT put_columnRule(BSTR v);
    HRESULT get_columnRule(BSTR* p);
    HRESULT put_columnRuleColor(VARIANT v);
    HRESULT get_columnRuleColor(VARIANT* p);
    HRESULT put_columnRuleStyle(BSTR v);
    HRESULT get_columnRuleStyle(BSTR* p);
    HRESULT put_columnRuleWidth(VARIANT v);
    HRESULT get_columnRuleWidth(VARIANT* p);
    HRESULT put_breakBefore(BSTR v);
    HRESULT get_breakBefore(BSTR* p);
    HRESULT put_breakAfter(BSTR v);
    HRESULT get_breakAfter(BSTR* p);
    HRESULT put_breakInside(BSTR v);
    HRESULT get_breakInside(BSTR* p);
    HRESULT put_floodColor(VARIANT v);
    HRESULT get_floodColor(VARIANT* p);
    HRESULT put_floodOpacity(VARIANT v);
    HRESULT get_floodOpacity(VARIANT* p);
    HRESULT put_lightingColor(VARIANT v);
    HRESULT get_lightingColor(VARIANT* p);
    HRESULT put_msScrollLimitXMin(VARIANT v);
    HRESULT get_msScrollLimitXMin(VARIANT* p);
    HRESULT put_msScrollLimitYMin(VARIANT v);
    HRESULT get_msScrollLimitYMin(VARIANT* p);
    HRESULT put_msScrollLimitXMax(VARIANT v);
    HRESULT get_msScrollLimitXMax(VARIANT* p);
    HRESULT put_msScrollLimitYMax(VARIANT v);
    HRESULT get_msScrollLimitYMax(VARIANT* p);
    HRESULT put_msScrollLimit(BSTR v);
    HRESULT get_msScrollLimit(BSTR* p);
    HRESULT put_textShadow(BSTR v);
    HRESULT get_textShadow(BSTR* p);
    HRESULT put_msFlowFrom(BSTR v);
    HRESULT get_msFlowFrom(BSTR* p);
    HRESULT put_msFlowInto(BSTR v);
    HRESULT get_msFlowInto(BSTR* p);
    HRESULT put_msHyphens(BSTR v);
    HRESULT get_msHyphens(BSTR* p);
    HRESULT put_msHyphenateLimitZone(VARIANT v);
    HRESULT get_msHyphenateLimitZone(VARIANT* p);
    HRESULT put_msHyphenateLimitChars(BSTR v);
    HRESULT get_msHyphenateLimitChars(BSTR* p);
    HRESULT put_msHyphenateLimitLines(VARIANT v);
    HRESULT get_msHyphenateLimitLines(VARIANT* p);
    HRESULT put_msHighContrastAdjust(BSTR v);
    HRESULT get_msHighContrastAdjust(BSTR* p);
    HRESULT put_enableBackground(BSTR v);
    HRESULT get_enableBackground(BSTR* p);
    HRESULT put_msFontFeatureSettings(BSTR v);
    HRESULT get_msFontFeatureSettings(BSTR* p);
    HRESULT put_msUserSelect(BSTR v);
    HRESULT get_msUserSelect(BSTR* p);
    HRESULT put_msOverflowStyle(BSTR v);
    HRESULT get_msOverflowStyle(BSTR* p);
    HRESULT put_msTransformStyle(BSTR v);
    HRESULT get_msTransformStyle(BSTR* p);
    HRESULT put_msBackfaceVisibility(BSTR v);
    HRESULT get_msBackfaceVisibility(BSTR* p);
    HRESULT put_msPerspective(VARIANT v);
    HRESULT get_msPerspective(VARIANT* p);
    HRESULT put_msPerspectiveOrigin(BSTR v);
    HRESULT get_msPerspectiveOrigin(BSTR* p);
    HRESULT put_msTransitionProperty(BSTR v);
    HRESULT get_msTransitionProperty(BSTR* p);
    HRESULT put_msTransitionDuration(BSTR v);
    HRESULT get_msTransitionDuration(BSTR* p);
    HRESULT put_msTransitionTimingFunction(BSTR v);
    HRESULT get_msTransitionTimingFunction(BSTR* p);
    HRESULT put_msTransitionDelay(BSTR v);
    HRESULT get_msTransitionDelay(BSTR* p);
    HRESULT put_msTransition(BSTR v);
    HRESULT get_msTransition(BSTR* p);
    HRESULT put_msTouchAction(BSTR v);
    HRESULT get_msTouchAction(BSTR* p);
    HRESULT put_msScrollTranslation(BSTR v);
    HRESULT get_msScrollTranslation(BSTR* p);
    HRESULT put_msFlex(BSTR v);
    HRESULT get_msFlex(BSTR* p);
    HRESULT put_msFlexPositive(VARIANT v);
    HRESULT get_msFlexPositive(VARIANT* p);
    HRESULT put_msFlexNegative(VARIANT v);
    HRESULT get_msFlexNegative(VARIANT* p);
    HRESULT put_msFlexPreferredSize(VARIANT v);
    HRESULT get_msFlexPreferredSize(VARIANT* p);
    HRESULT put_msFlexFlow(BSTR v);
    HRESULT get_msFlexFlow(BSTR* p);
    HRESULT put_msFlexDirection(BSTR v);
    HRESULT get_msFlexDirection(BSTR* p);
    HRESULT put_msFlexWrap(BSTR v);
    HRESULT get_msFlexWrap(BSTR* p);
    HRESULT put_msFlexAlign(BSTR v);
    HRESULT get_msFlexAlign(BSTR* p);
    HRESULT put_msFlexItemAlign(BSTR v);
    HRESULT get_msFlexItemAlign(BSTR* p);
    HRESULT put_msFlexPack(BSTR v);
    HRESULT get_msFlexPack(BSTR* p);
    HRESULT put_msFlexLinePack(BSTR v);
    HRESULT get_msFlexLinePack(BSTR* p);
    HRESULT put_msFlexOrder(VARIANT v);
    HRESULT get_msFlexOrder(VARIANT* p);
    HRESULT put_msTouchSelect(BSTR v);
    HRESULT get_msTouchSelect(BSTR* p);
    HRESULT put_transform(BSTR v);
    HRESULT get_transform(BSTR* p);
    HRESULT put_transformOrigin(BSTR v);
    HRESULT get_transformOrigin(BSTR* p);
    HRESULT put_transformStyle(BSTR v);
    HRESULT get_transformStyle(BSTR* p);
    HRESULT put_backfaceVisibility(BSTR v);
    HRESULT get_backfaceVisibility(BSTR* p);
    HRESULT put_perspective(VARIANT v);
    HRESULT get_perspective(VARIANT* p);
    HRESULT put_perspectiveOrigin(BSTR v);
    HRESULT get_perspectiveOrigin(BSTR* p);
    HRESULT put_transitionProperty(BSTR v);
    HRESULT get_transitionProperty(BSTR* p);
    HRESULT put_transitionDuration(BSTR v);
    HRESULT get_transitionDuration(BSTR* p);
    HRESULT put_transitionTimingFunction(BSTR v);
    HRESULT get_transitionTimingFunction(BSTR* p);
    HRESULT put_transitionDelay(BSTR v);
    HRESULT get_transitionDelay(BSTR* p);
    HRESULT put_transition(BSTR v);
    HRESULT get_transition(BSTR* p);
    HRESULT put_fontFeatureSettings(BSTR v);
    HRESULT get_fontFeatureSettings(BSTR* p);
    HRESULT put_animationName(BSTR v);
    HRESULT get_animationName(BSTR* p);
    HRESULT put_animationDuration(BSTR v);
    HRESULT get_animationDuration(BSTR* p);
    HRESULT put_animationTimingFunction(BSTR v);
    HRESULT get_animationTimingFunction(BSTR* p);
    HRESULT put_animationDelay(BSTR v);
    HRESULT get_animationDelay(BSTR* p);
    HRESULT put_animationDirection(BSTR v);
    HRESULT get_animationDirection(BSTR* p);
    HRESULT put_animationPlayState(BSTR v);
    HRESULT get_animationPlayState(BSTR* p);
    HRESULT put_animationIterationCount(BSTR v);
    HRESULT get_animationIterationCount(BSTR* p);
    HRESULT put_animation(BSTR v);
    HRESULT get_animation(BSTR* p);
    HRESULT put_animationFillMode(BSTR v);
    HRESULT get_animationFillMode(BSTR* p);
}

@GUID("3051085C-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLCSSStyleDeclaration3 : IDispatch
{
    HRESULT put_flex(BSTR v);
    HRESULT get_flex(BSTR* p);
    HRESULT put_flexDirection(BSTR v);
    HRESULT get_flexDirection(BSTR* p);
    HRESULT put_flexWrap(BSTR v);
    HRESULT get_flexWrap(BSTR* p);
    HRESULT put_flexFlow(BSTR v);
    HRESULT get_flexFlow(BSTR* p);
    HRESULT put_flexGrow(VARIANT v);
    HRESULT get_flexGrow(VARIANT* p);
    HRESULT put_flexShrink(VARIANT v);
    HRESULT get_flexShrink(VARIANT* p);
    HRESULT put_flexBasis(VARIANT v);
    HRESULT get_flexBasis(VARIANT* p);
    HRESULT put_justifyContent(BSTR v);
    HRESULT get_justifyContent(BSTR* p);
    HRESULT put_alignItems(BSTR v);
    HRESULT get_alignItems(BSTR* p);
    HRESULT put_alignSelf(BSTR v);
    HRESULT get_alignSelf(BSTR* p);
    HRESULT put_alignContent(BSTR v);
    HRESULT get_alignContent(BSTR* p);
    HRESULT put_borderImage(BSTR v);
    HRESULT get_borderImage(BSTR* p);
    HRESULT put_borderImageSource(BSTR v);
    HRESULT get_borderImageSource(BSTR* p);
    HRESULT put_borderImageSlice(BSTR v);
    HRESULT get_borderImageSlice(BSTR* p);
    HRESULT put_borderImageWidth(BSTR v);
    HRESULT get_borderImageWidth(BSTR* p);
    HRESULT put_borderImageOutset(BSTR v);
    HRESULT get_borderImageOutset(BSTR* p);
    HRESULT put_borderImageRepeat(BSTR v);
    HRESULT get_borderImageRepeat(BSTR* p);
    HRESULT put_msImeAlign(BSTR v);
    HRESULT get_msImeAlign(BSTR* p);
    HRESULT put_msTextCombineHorizontal(BSTR v);
    HRESULT get_msTextCombineHorizontal(BSTR* p);
    HRESULT put_touchAction(BSTR v);
    HRESULT get_touchAction(BSTR* p);
}

@GUID("D6100F3B-27C8-4132-AFEA-F0E4B1E00060")
interface IHTMLCSSStyleDeclaration4 : IDispatch
{
    HRESULT put_webkitAppearance(BSTR v);
    HRESULT get_webkitAppearance(BSTR* p);
    HRESULT put_webkitUserSelect(BSTR v);
    HRESULT get_webkitUserSelect(BSTR* p);
    HRESULT put_webkitBoxAlign(BSTR v);
    HRESULT get_webkitBoxAlign(BSTR* p);
    HRESULT put_webkitBoxOrdinalGroup(VARIANT v);
    HRESULT get_webkitBoxOrdinalGroup(VARIANT* p);
    HRESULT put_webkitBoxPack(BSTR v);
    HRESULT get_webkitBoxPack(BSTR* p);
    HRESULT put_webkitBoxFlex(VARIANT v);
    HRESULT get_webkitBoxFlex(VARIANT* p);
    HRESULT put_webkitBoxOrient(BSTR v);
    HRESULT get_webkitBoxOrient(BSTR* p);
    HRESULT put_webkitBoxDirection(BSTR v);
    HRESULT get_webkitBoxDirection(BSTR* p);
    HRESULT put_webkitTransform(BSTR v);
    HRESULT get_webkitTransform(BSTR* p);
    HRESULT put_webkitBackgroundSize(BSTR v);
    HRESULT get_webkitBackgroundSize(BSTR* p);
    HRESULT put_webkitBackfaceVisibility(BSTR v);
    HRESULT get_webkitBackfaceVisibility(BSTR* p);
    HRESULT put_webkitAnimation(BSTR v);
    HRESULT get_webkitAnimation(BSTR* p);
    HRESULT put_webkitTransition(BSTR v);
    HRESULT get_webkitTransition(BSTR* p);
    HRESULT put_webkitAnimationName(BSTR v);
    HRESULT get_webkitAnimationName(BSTR* p);
    HRESULT put_webkitAnimationDuration(BSTR v);
    HRESULT get_webkitAnimationDuration(BSTR* p);
    HRESULT put_webkitAnimationTimingFunction(BSTR v);
    HRESULT get_webkitAnimationTimingFunction(BSTR* p);
    HRESULT put_webkitAnimationDelay(BSTR v);
    HRESULT get_webkitAnimationDelay(BSTR* p);
    HRESULT put_webkitAnimationIterationCount(BSTR v);
    HRESULT get_webkitAnimationIterationCount(BSTR* p);
    HRESULT put_webkitAnimationDirection(BSTR v);
    HRESULT get_webkitAnimationDirection(BSTR* p);
    HRESULT put_webkitAnimationPlayState(BSTR v);
    HRESULT get_webkitAnimationPlayState(BSTR* p);
    HRESULT put_webkitTransitionProperty(BSTR v);
    HRESULT get_webkitTransitionProperty(BSTR* p);
    HRESULT put_webkitTransitionDuration(BSTR v);
    HRESULT get_webkitTransitionDuration(BSTR* p);
    HRESULT put_webkitTransitionTimingFunction(BSTR v);
    HRESULT get_webkitTransitionTimingFunction(BSTR* p);
    HRESULT put_webkitTransitionDelay(BSTR v);
    HRESULT get_webkitTransitionDelay(BSTR* p);
    HRESULT put_webkitBackgroundAttachment(BSTR v);
    HRESULT get_webkitBackgroundAttachment(BSTR* p);
    HRESULT put_webkitBackgroundColor(VARIANT v);
    HRESULT get_webkitBackgroundColor(VARIANT* p);
    HRESULT put_webkitBackgroundClip(BSTR v);
    HRESULT get_webkitBackgroundClip(BSTR* p);
    HRESULT put_webkitBackgroundImage(BSTR v);
    HRESULT get_webkitBackgroundImage(BSTR* p);
    HRESULT put_webkitBackgroundRepeat(BSTR v);
    HRESULT get_webkitBackgroundRepeat(BSTR* p);
    HRESULT put_webkitBackgroundOrigin(BSTR v);
    HRESULT get_webkitBackgroundOrigin(BSTR* p);
    HRESULT put_webkitBackgroundPosition(BSTR v);
    HRESULT get_webkitBackgroundPosition(BSTR* p);
    HRESULT put_webkitBackgroundPositionX(VARIANT v);
    HRESULT get_webkitBackgroundPositionX(VARIANT* p);
    HRESULT put_webkitBackgroundPositionY(VARIANT v);
    HRESULT get_webkitBackgroundPositionY(VARIANT* p);
    HRESULT put_webkitBackground(BSTR v);
    HRESULT get_webkitBackground(BSTR* p);
    HRESULT put_webkitTransformOrigin(BSTR v);
    HRESULT get_webkitTransformOrigin(BSTR* p);
    HRESULT put_msTextSizeAdjust(VARIANT v);
    HRESULT get_msTextSizeAdjust(VARIANT* p);
    HRESULT put_webkitTextSizeAdjust(VARIANT v);
    HRESULT get_webkitTextSizeAdjust(VARIANT* p);
    HRESULT put_webkitBorderImage(BSTR v);
    HRESULT get_webkitBorderImage(BSTR* p);
    HRESULT put_webkitBorderImageSource(BSTR v);
    HRESULT get_webkitBorderImageSource(BSTR* p);
    HRESULT put_webkitBorderImageSlice(BSTR v);
    HRESULT get_webkitBorderImageSlice(BSTR* p);
    HRESULT put_webkitBorderImageWidth(BSTR v);
    HRESULT get_webkitBorderImageWidth(BSTR* p);
    HRESULT put_webkitBorderImageOutset(BSTR v);
    HRESULT get_webkitBorderImageOutset(BSTR* p);
    HRESULT put_webkitBorderImageRepeat(BSTR v);
    HRESULT get_webkitBorderImageRepeat(BSTR* p);
    HRESULT put_webkitBoxSizing(BSTR v);
    HRESULT get_webkitBoxSizing(BSTR* p);
    HRESULT put_webkitAnimationFillMode(BSTR v);
    HRESULT get_webkitAnimationFillMode(BSTR* p);
}

@GUID("305104C2-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleEnabled : IDispatch
{
    HRESULT msGetPropertyEnabled(BSTR name, short* p);
    HRESULT msPutPropertyEnabled(BSTR name, short b);
}

@GUID("3059009A-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLCSSStyleDeclaration : IDispatch
{
}

@GUID("3050F25E-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyle : IDispatch
{
    HRESULT put_fontFamily(BSTR v);
    HRESULT get_fontFamily(BSTR* p);
    HRESULT put_fontStyle(BSTR v);
    HRESULT get_fontStyle(BSTR* p);
    HRESULT put_fontVariant(BSTR v);
    HRESULT get_fontVariant(BSTR* p);
    HRESULT put_fontWeight(BSTR v);
    HRESULT get_fontWeight(BSTR* p);
    HRESULT put_fontSize(VARIANT v);
    HRESULT get_fontSize(VARIANT* p);
    HRESULT put_font(BSTR v);
    HRESULT get_font(BSTR* p);
    HRESULT put_color(VARIANT v);
    HRESULT get_color(VARIANT* p);
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_backgroundColor(VARIANT v);
    HRESULT get_backgroundColor(VARIANT* p);
    HRESULT put_backgroundImage(BSTR v);
    HRESULT get_backgroundImage(BSTR* p);
    HRESULT put_backgroundRepeat(BSTR v);
    HRESULT get_backgroundRepeat(BSTR* p);
    HRESULT put_backgroundAttachment(BSTR v);
    HRESULT get_backgroundAttachment(BSTR* p);
    HRESULT put_backgroundPosition(BSTR v);
    HRESULT get_backgroundPosition(BSTR* p);
    HRESULT put_backgroundPositionX(VARIANT v);
    HRESULT get_backgroundPositionX(VARIANT* p);
    HRESULT put_backgroundPositionY(VARIANT v);
    HRESULT get_backgroundPositionY(VARIANT* p);
    HRESULT put_wordSpacing(VARIANT v);
    HRESULT get_wordSpacing(VARIANT* p);
    HRESULT put_letterSpacing(VARIANT v);
    HRESULT get_letterSpacing(VARIANT* p);
    HRESULT put_textDecoration(BSTR v);
    HRESULT get_textDecoration(BSTR* p);
    HRESULT put_textDecorationNone(short v);
    HRESULT get_textDecorationNone(short* p);
    HRESULT put_textDecorationUnderline(short v);
    HRESULT get_textDecorationUnderline(short* p);
    HRESULT put_textDecorationOverline(short v);
    HRESULT get_textDecorationOverline(short* p);
    HRESULT put_textDecorationLineThrough(short v);
    HRESULT get_textDecorationLineThrough(short* p);
    HRESULT put_textDecorationBlink(short v);
    HRESULT get_textDecorationBlink(short* p);
    HRESULT put_verticalAlign(VARIANT v);
    HRESULT get_verticalAlign(VARIANT* p);
    HRESULT put_textTransform(BSTR v);
    HRESULT get_textTransform(BSTR* p);
    HRESULT put_textAlign(BSTR v);
    HRESULT get_textAlign(BSTR* p);
    HRESULT put_textIndent(VARIANT v);
    HRESULT get_textIndent(VARIANT* p);
    HRESULT put_lineHeight(VARIANT v);
    HRESULT get_lineHeight(VARIANT* p);
    HRESULT put_marginTop(VARIANT v);
    HRESULT get_marginTop(VARIANT* p);
    HRESULT put_marginRight(VARIANT v);
    HRESULT get_marginRight(VARIANT* p);
    HRESULT put_marginBottom(VARIANT v);
    HRESULT get_marginBottom(VARIANT* p);
    HRESULT put_marginLeft(VARIANT v);
    HRESULT get_marginLeft(VARIANT* p);
    HRESULT put_margin(BSTR v);
    HRESULT get_margin(BSTR* p);
    HRESULT put_paddingTop(VARIANT v);
    HRESULT get_paddingTop(VARIANT* p);
    HRESULT put_paddingRight(VARIANT v);
    HRESULT get_paddingRight(VARIANT* p);
    HRESULT put_paddingBottom(VARIANT v);
    HRESULT get_paddingBottom(VARIANT* p);
    HRESULT put_paddingLeft(VARIANT v);
    HRESULT get_paddingLeft(VARIANT* p);
    HRESULT put_padding(BSTR v);
    HRESULT get_padding(BSTR* p);
    HRESULT put_border(BSTR v);
    HRESULT get_border(BSTR* p);
    HRESULT put_borderTop(BSTR v);
    HRESULT get_borderTop(BSTR* p);
    HRESULT put_borderRight(BSTR v);
    HRESULT get_borderRight(BSTR* p);
    HRESULT put_borderBottom(BSTR v);
    HRESULT get_borderBottom(BSTR* p);
    HRESULT put_borderLeft(BSTR v);
    HRESULT get_borderLeft(BSTR* p);
    HRESULT put_borderColor(BSTR v);
    HRESULT get_borderColor(BSTR* p);
    HRESULT put_borderTopColor(VARIANT v);
    HRESULT get_borderTopColor(VARIANT* p);
    HRESULT put_borderRightColor(VARIANT v);
    HRESULT get_borderRightColor(VARIANT* p);
    HRESULT put_borderBottomColor(VARIANT v);
    HRESULT get_borderBottomColor(VARIANT* p);
    HRESULT put_borderLeftColor(VARIANT v);
    HRESULT get_borderLeftColor(VARIANT* p);
    HRESULT put_borderWidth(BSTR v);
    HRESULT get_borderWidth(BSTR* p);
    HRESULT put_borderTopWidth(VARIANT v);
    HRESULT get_borderTopWidth(VARIANT* p);
    HRESULT put_borderRightWidth(VARIANT v);
    HRESULT get_borderRightWidth(VARIANT* p);
    HRESULT put_borderBottomWidth(VARIANT v);
    HRESULT get_borderBottomWidth(VARIANT* p);
    HRESULT put_borderLeftWidth(VARIANT v);
    HRESULT get_borderLeftWidth(VARIANT* p);
    HRESULT put_borderStyle(BSTR v);
    HRESULT get_borderStyle(BSTR* p);
    HRESULT put_borderTopStyle(BSTR v);
    HRESULT get_borderTopStyle(BSTR* p);
    HRESULT put_borderRightStyle(BSTR v);
    HRESULT get_borderRightStyle(BSTR* p);
    HRESULT put_borderBottomStyle(BSTR v);
    HRESULT get_borderBottomStyle(BSTR* p);
    HRESULT put_borderLeftStyle(BSTR v);
    HRESULT get_borderLeftStyle(BSTR* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_styleFloat(BSTR v);
    HRESULT get_styleFloat(BSTR* p);
    HRESULT put_clear(BSTR v);
    HRESULT get_clear(BSTR* p);
    HRESULT put_display(BSTR v);
    HRESULT get_display(BSTR* p);
    HRESULT put_visibility(BSTR v);
    HRESULT get_visibility(BSTR* p);
    HRESULT put_listStyleType(BSTR v);
    HRESULT get_listStyleType(BSTR* p);
    HRESULT put_listStylePosition(BSTR v);
    HRESULT get_listStylePosition(BSTR* p);
    HRESULT put_listStyleImage(BSTR v);
    HRESULT get_listStyleImage(BSTR* p);
    HRESULT put_listStyle(BSTR v);
    HRESULT get_listStyle(BSTR* p);
    HRESULT put_whiteSpace(BSTR v);
    HRESULT get_whiteSpace(BSTR* p);
    HRESULT put_top(VARIANT v);
    HRESULT get_top(VARIANT* p);
    HRESULT put_left(VARIANT v);
    HRESULT get_left(VARIANT* p);
    HRESULT get_position(BSTR* p);
    HRESULT put_zIndex(VARIANT v);
    HRESULT get_zIndex(VARIANT* p);
    HRESULT put_overflow(BSTR v);
    HRESULT get_overflow(BSTR* p);
    HRESULT put_pageBreakBefore(BSTR v);
    HRESULT get_pageBreakBefore(BSTR* p);
    HRESULT put_pageBreakAfter(BSTR v);
    HRESULT get_pageBreakAfter(BSTR* p);
    HRESULT put_cssText(BSTR v);
    HRESULT get_cssText(BSTR* p);
    HRESULT put_pixelTop(int v);
    HRESULT get_pixelTop(int* p);
    HRESULT put_pixelLeft(int v);
    HRESULT get_pixelLeft(int* p);
    HRESULT put_pixelWidth(int v);
    HRESULT get_pixelWidth(int* p);
    HRESULT put_pixelHeight(int v);
    HRESULT get_pixelHeight(int* p);
    HRESULT put_posTop(float v);
    HRESULT get_posTop(float* p);
    HRESULT put_posLeft(float v);
    HRESULT get_posLeft(float* p);
    HRESULT put_posWidth(float v);
    HRESULT get_posWidth(float* p);
    HRESULT put_posHeight(float v);
    HRESULT get_posHeight(float* p);
    HRESULT put_cursor(BSTR v);
    HRESULT get_cursor(BSTR* p);
    HRESULT put_clip(BSTR v);
    HRESULT get_clip(BSTR* p);
    HRESULT put_filter(BSTR v);
    HRESULT get_filter(BSTR* p);
    HRESULT setAttribute(BSTR strAttributeName, VARIANT AttributeValue, int lFlags);
    HRESULT getAttribute(BSTR strAttributeName, int lFlags, VARIANT* AttributeValue);
    HRESULT removeAttribute(BSTR strAttributeName, int lFlags, short* pfSuccess);
    HRESULT toString(BSTR* String);
}

@GUID("3050F4A2-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyle2 : IDispatch
{
    HRESULT put_tableLayout(BSTR v);
    HRESULT get_tableLayout(BSTR* p);
    HRESULT put_borderCollapse(BSTR v);
    HRESULT get_borderCollapse(BSTR* p);
    HRESULT put_direction(BSTR v);
    HRESULT get_direction(BSTR* p);
    HRESULT put_behavior(BSTR v);
    HRESULT get_behavior(BSTR* p);
    HRESULT setExpression(BSTR propname, BSTR expression, BSTR language);
    HRESULT getExpression(BSTR propname, VARIANT* expression);
    HRESULT removeExpression(BSTR propname, short* pfSuccess);
    HRESULT put_position(BSTR v);
    HRESULT get_position(BSTR* p);
    HRESULT put_unicodeBidi(BSTR v);
    HRESULT get_unicodeBidi(BSTR* p);
    HRESULT put_bottom(VARIANT v);
    HRESULT get_bottom(VARIANT* p);
    HRESULT put_right(VARIANT v);
    HRESULT get_right(VARIANT* p);
    HRESULT put_pixelBottom(int v);
    HRESULT get_pixelBottom(int* p);
    HRESULT put_pixelRight(int v);
    HRESULT get_pixelRight(int* p);
    HRESULT put_posBottom(float v);
    HRESULT get_posBottom(float* p);
    HRESULT put_posRight(float v);
    HRESULT get_posRight(float* p);
    HRESULT put_imeMode(BSTR v);
    HRESULT get_imeMode(BSTR* p);
    HRESULT put_rubyAlign(BSTR v);
    HRESULT get_rubyAlign(BSTR* p);
    HRESULT put_rubyPosition(BSTR v);
    HRESULT get_rubyPosition(BSTR* p);
    HRESULT put_rubyOverhang(BSTR v);
    HRESULT get_rubyOverhang(BSTR* p);
    HRESULT put_layoutGridChar(VARIANT v);
    HRESULT get_layoutGridChar(VARIANT* p);
    HRESULT put_layoutGridLine(VARIANT v);
    HRESULT get_layoutGridLine(VARIANT* p);
    HRESULT put_layoutGridMode(BSTR v);
    HRESULT get_layoutGridMode(BSTR* p);
    HRESULT put_layoutGridType(BSTR v);
    HRESULT get_layoutGridType(BSTR* p);
    HRESULT put_layoutGrid(BSTR v);
    HRESULT get_layoutGrid(BSTR* p);
    HRESULT put_wordBreak(BSTR v);
    HRESULT get_wordBreak(BSTR* p);
    HRESULT put_lineBreak(BSTR v);
    HRESULT get_lineBreak(BSTR* p);
    HRESULT put_textJustify(BSTR v);
    HRESULT get_textJustify(BSTR* p);
    HRESULT put_textJustifyTrim(BSTR v);
    HRESULT get_textJustifyTrim(BSTR* p);
    HRESULT put_textKashida(VARIANT v);
    HRESULT get_textKashida(VARIANT* p);
    HRESULT put_textAutospace(BSTR v);
    HRESULT get_textAutospace(BSTR* p);
    HRESULT put_overflowX(BSTR v);
    HRESULT get_overflowX(BSTR* p);
    HRESULT put_overflowY(BSTR v);
    HRESULT get_overflowY(BSTR* p);
    HRESULT put_accelerator(BSTR v);
    HRESULT get_accelerator(BSTR* p);
}

@GUID("3050F656-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyle3 : IDispatch
{
    HRESULT put_layoutFlow(BSTR v);
    HRESULT get_layoutFlow(BSTR* p);
    HRESULT put_zoom(VARIANT v);
    HRESULT get_zoom(VARIANT* p);
    HRESULT put_wordWrap(BSTR v);
    HRESULT get_wordWrap(BSTR* p);
    HRESULT put_textUnderlinePosition(BSTR v);
    HRESULT get_textUnderlinePosition(BSTR* p);
    HRESULT put_scrollbarBaseColor(VARIANT v);
    HRESULT get_scrollbarBaseColor(VARIANT* p);
    HRESULT put_scrollbarFaceColor(VARIANT v);
    HRESULT get_scrollbarFaceColor(VARIANT* p);
    HRESULT put_scrollbar3dLightColor(VARIANT v);
    HRESULT get_scrollbar3dLightColor(VARIANT* p);
    HRESULT put_scrollbarShadowColor(VARIANT v);
    HRESULT get_scrollbarShadowColor(VARIANT* p);
    HRESULT put_scrollbarHighlightColor(VARIANT v);
    HRESULT get_scrollbarHighlightColor(VARIANT* p);
    HRESULT put_scrollbarDarkShadowColor(VARIANT v);
    HRESULT get_scrollbarDarkShadowColor(VARIANT* p);
    HRESULT put_scrollbarArrowColor(VARIANT v);
    HRESULT get_scrollbarArrowColor(VARIANT* p);
    HRESULT put_scrollbarTrackColor(VARIANT v);
    HRESULT get_scrollbarTrackColor(VARIANT* p);
    HRESULT put_writingMode(BSTR v);
    HRESULT get_writingMode(BSTR* p);
    HRESULT put_textAlignLast(BSTR v);
    HRESULT get_textAlignLast(BSTR* p);
    HRESULT put_textKashidaSpace(VARIANT v);
    HRESULT get_textKashidaSpace(VARIANT* p);
}

@GUID("3050F816-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyle4 : IDispatch
{
    HRESULT put_textOverflow(BSTR v);
    HRESULT get_textOverflow(BSTR* p);
    HRESULT put_minHeight(VARIANT v);
    HRESULT get_minHeight(VARIANT* p);
}

@GUID("3050F33A-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyle5 : IDispatch
{
    HRESULT put_msInterpolationMode(BSTR v);
    HRESULT get_msInterpolationMode(BSTR* p);
    HRESULT put_maxHeight(VARIANT v);
    HRESULT get_maxHeight(VARIANT* p);
    HRESULT put_minWidth(VARIANT v);
    HRESULT get_minWidth(VARIANT* p);
    HRESULT put_maxWidth(VARIANT v);
    HRESULT get_maxWidth(VARIANT* p);
}

@GUID("30510480-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyle6 : IDispatch
{
    HRESULT put_content(BSTR v);
    HRESULT get_content(BSTR* p);
    HRESULT put_captionSide(BSTR v);
    HRESULT get_captionSide(BSTR* p);
    HRESULT put_counterIncrement(BSTR v);
    HRESULT get_counterIncrement(BSTR* p);
    HRESULT put_counterReset(BSTR v);
    HRESULT get_counterReset(BSTR* p);
    HRESULT put_outline(BSTR v);
    HRESULT get_outline(BSTR* p);
    HRESULT put_outlineWidth(VARIANT v);
    HRESULT get_outlineWidth(VARIANT* p);
    HRESULT put_outlineStyle(BSTR v);
    HRESULT get_outlineStyle(BSTR* p);
    HRESULT put_outlineColor(VARIANT v);
    HRESULT get_outlineColor(VARIANT* p);
    HRESULT put_boxSizing(BSTR v);
    HRESULT get_boxSizing(BSTR* p);
    HRESULT put_borderSpacing(BSTR v);
    HRESULT get_borderSpacing(BSTR* p);
    HRESULT put_orphans(VARIANT v);
    HRESULT get_orphans(VARIANT* p);
    HRESULT put_widows(VARIANT v);
    HRESULT get_widows(VARIANT* p);
    HRESULT put_pageBreakInside(BSTR v);
    HRESULT get_pageBreakInside(BSTR* p);
    HRESULT put_emptyCells(BSTR v);
    HRESULT get_emptyCells(BSTR* p);
    HRESULT put_msBlockProgression(BSTR v);
    HRESULT get_msBlockProgression(BSTR* p);
    HRESULT put_quotes(BSTR v);
    HRESULT get_quotes(BSTR* p);
}

@GUID("3050F3CF-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLRuleStyle : IDispatch
{
    HRESULT put_fontFamily(BSTR v);
    HRESULT get_fontFamily(BSTR* p);
    HRESULT put_fontStyle(BSTR v);
    HRESULT get_fontStyle(BSTR* p);
    HRESULT put_fontVariant(BSTR v);
    HRESULT get_fontVariant(BSTR* p);
    HRESULT put_fontWeight(BSTR v);
    HRESULT get_fontWeight(BSTR* p);
    HRESULT put_fontSize(VARIANT v);
    HRESULT get_fontSize(VARIANT* p);
    HRESULT put_font(BSTR v);
    HRESULT get_font(BSTR* p);
    HRESULT put_color(VARIANT v);
    HRESULT get_color(VARIANT* p);
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_backgroundColor(VARIANT v);
    HRESULT get_backgroundColor(VARIANT* p);
    HRESULT put_backgroundImage(BSTR v);
    HRESULT get_backgroundImage(BSTR* p);
    HRESULT put_backgroundRepeat(BSTR v);
    HRESULT get_backgroundRepeat(BSTR* p);
    HRESULT put_backgroundAttachment(BSTR v);
    HRESULT get_backgroundAttachment(BSTR* p);
    HRESULT put_backgroundPosition(BSTR v);
    HRESULT get_backgroundPosition(BSTR* p);
    HRESULT put_backgroundPositionX(VARIANT v);
    HRESULT get_backgroundPositionX(VARIANT* p);
    HRESULT put_backgroundPositionY(VARIANT v);
    HRESULT get_backgroundPositionY(VARIANT* p);
    HRESULT put_wordSpacing(VARIANT v);
    HRESULT get_wordSpacing(VARIANT* p);
    HRESULT put_letterSpacing(VARIANT v);
    HRESULT get_letterSpacing(VARIANT* p);
    HRESULT put_textDecoration(BSTR v);
    HRESULT get_textDecoration(BSTR* p);
    HRESULT put_textDecorationNone(short v);
    HRESULT get_textDecorationNone(short* p);
    HRESULT put_textDecorationUnderline(short v);
    HRESULT get_textDecorationUnderline(short* p);
    HRESULT put_textDecorationOverline(short v);
    HRESULT get_textDecorationOverline(short* p);
    HRESULT put_textDecorationLineThrough(short v);
    HRESULT get_textDecorationLineThrough(short* p);
    HRESULT put_textDecorationBlink(short v);
    HRESULT get_textDecorationBlink(short* p);
    HRESULT put_verticalAlign(VARIANT v);
    HRESULT get_verticalAlign(VARIANT* p);
    HRESULT put_textTransform(BSTR v);
    HRESULT get_textTransform(BSTR* p);
    HRESULT put_textAlign(BSTR v);
    HRESULT get_textAlign(BSTR* p);
    HRESULT put_textIndent(VARIANT v);
    HRESULT get_textIndent(VARIANT* p);
    HRESULT put_lineHeight(VARIANT v);
    HRESULT get_lineHeight(VARIANT* p);
    HRESULT put_marginTop(VARIANT v);
    HRESULT get_marginTop(VARIANT* p);
    HRESULT put_marginRight(VARIANT v);
    HRESULT get_marginRight(VARIANT* p);
    HRESULT put_marginBottom(VARIANT v);
    HRESULT get_marginBottom(VARIANT* p);
    HRESULT put_marginLeft(VARIANT v);
    HRESULT get_marginLeft(VARIANT* p);
    HRESULT put_margin(BSTR v);
    HRESULT get_margin(BSTR* p);
    HRESULT put_paddingTop(VARIANT v);
    HRESULT get_paddingTop(VARIANT* p);
    HRESULT put_paddingRight(VARIANT v);
    HRESULT get_paddingRight(VARIANT* p);
    HRESULT put_paddingBottom(VARIANT v);
    HRESULT get_paddingBottom(VARIANT* p);
    HRESULT put_paddingLeft(VARIANT v);
    HRESULT get_paddingLeft(VARIANT* p);
    HRESULT put_padding(BSTR v);
    HRESULT get_padding(BSTR* p);
    HRESULT put_border(BSTR v);
    HRESULT get_border(BSTR* p);
    HRESULT put_borderTop(BSTR v);
    HRESULT get_borderTop(BSTR* p);
    HRESULT put_borderRight(BSTR v);
    HRESULT get_borderRight(BSTR* p);
    HRESULT put_borderBottom(BSTR v);
    HRESULT get_borderBottom(BSTR* p);
    HRESULT put_borderLeft(BSTR v);
    HRESULT get_borderLeft(BSTR* p);
    HRESULT put_borderColor(BSTR v);
    HRESULT get_borderColor(BSTR* p);
    HRESULT put_borderTopColor(VARIANT v);
    HRESULT get_borderTopColor(VARIANT* p);
    HRESULT put_borderRightColor(VARIANT v);
    HRESULT get_borderRightColor(VARIANT* p);
    HRESULT put_borderBottomColor(VARIANT v);
    HRESULT get_borderBottomColor(VARIANT* p);
    HRESULT put_borderLeftColor(VARIANT v);
    HRESULT get_borderLeftColor(VARIANT* p);
    HRESULT put_borderWidth(BSTR v);
    HRESULT get_borderWidth(BSTR* p);
    HRESULT put_borderTopWidth(VARIANT v);
    HRESULT get_borderTopWidth(VARIANT* p);
    HRESULT put_borderRightWidth(VARIANT v);
    HRESULT get_borderRightWidth(VARIANT* p);
    HRESULT put_borderBottomWidth(VARIANT v);
    HRESULT get_borderBottomWidth(VARIANT* p);
    HRESULT put_borderLeftWidth(VARIANT v);
    HRESULT get_borderLeftWidth(VARIANT* p);
    HRESULT put_borderStyle(BSTR v);
    HRESULT get_borderStyle(BSTR* p);
    HRESULT put_borderTopStyle(BSTR v);
    HRESULT get_borderTopStyle(BSTR* p);
    HRESULT put_borderRightStyle(BSTR v);
    HRESULT get_borderRightStyle(BSTR* p);
    HRESULT put_borderBottomStyle(BSTR v);
    HRESULT get_borderBottomStyle(BSTR* p);
    HRESULT put_borderLeftStyle(BSTR v);
    HRESULT get_borderLeftStyle(BSTR* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_styleFloat(BSTR v);
    HRESULT get_styleFloat(BSTR* p);
    HRESULT put_clear(BSTR v);
    HRESULT get_clear(BSTR* p);
    HRESULT put_display(BSTR v);
    HRESULT get_display(BSTR* p);
    HRESULT put_visibility(BSTR v);
    HRESULT get_visibility(BSTR* p);
    HRESULT put_listStyleType(BSTR v);
    HRESULT get_listStyleType(BSTR* p);
    HRESULT put_listStylePosition(BSTR v);
    HRESULT get_listStylePosition(BSTR* p);
    HRESULT put_listStyleImage(BSTR v);
    HRESULT get_listStyleImage(BSTR* p);
    HRESULT put_listStyle(BSTR v);
    HRESULT get_listStyle(BSTR* p);
    HRESULT put_whiteSpace(BSTR v);
    HRESULT get_whiteSpace(BSTR* p);
    HRESULT put_top(VARIANT v);
    HRESULT get_top(VARIANT* p);
    HRESULT put_left(VARIANT v);
    HRESULT get_left(VARIANT* p);
    HRESULT get_position(BSTR* p);
    HRESULT put_zIndex(VARIANT v);
    HRESULT get_zIndex(VARIANT* p);
    HRESULT put_overflow(BSTR v);
    HRESULT get_overflow(BSTR* p);
    HRESULT put_pageBreakBefore(BSTR v);
    HRESULT get_pageBreakBefore(BSTR* p);
    HRESULT put_pageBreakAfter(BSTR v);
    HRESULT get_pageBreakAfter(BSTR* p);
    HRESULT put_cssText(BSTR v);
    HRESULT get_cssText(BSTR* p);
    HRESULT put_cursor(BSTR v);
    HRESULT get_cursor(BSTR* p);
    HRESULT put_clip(BSTR v);
    HRESULT get_clip(BSTR* p);
    HRESULT put_filter(BSTR v);
    HRESULT get_filter(BSTR* p);
    HRESULT setAttribute(BSTR strAttributeName, VARIANT AttributeValue, int lFlags);
    HRESULT getAttribute(BSTR strAttributeName, int lFlags, VARIANT* AttributeValue);
    HRESULT removeAttribute(BSTR strAttributeName, int lFlags, short* pfSuccess);
}

@GUID("3050F4AC-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLRuleStyle2 : IDispatch
{
    HRESULT put_tableLayout(BSTR v);
    HRESULT get_tableLayout(BSTR* p);
    HRESULT put_borderCollapse(BSTR v);
    HRESULT get_borderCollapse(BSTR* p);
    HRESULT put_direction(BSTR v);
    HRESULT get_direction(BSTR* p);
    HRESULT put_behavior(BSTR v);
    HRESULT get_behavior(BSTR* p);
    HRESULT put_position(BSTR v);
    HRESULT get_position(BSTR* p);
    HRESULT put_unicodeBidi(BSTR v);
    HRESULT get_unicodeBidi(BSTR* p);
    HRESULT put_bottom(VARIANT v);
    HRESULT get_bottom(VARIANT* p);
    HRESULT put_right(VARIANT v);
    HRESULT get_right(VARIANT* p);
    HRESULT put_pixelBottom(int v);
    HRESULT get_pixelBottom(int* p);
    HRESULT put_pixelRight(int v);
    HRESULT get_pixelRight(int* p);
    HRESULT put_posBottom(float v);
    HRESULT get_posBottom(float* p);
    HRESULT put_posRight(float v);
    HRESULT get_posRight(float* p);
    HRESULT put_imeMode(BSTR v);
    HRESULT get_imeMode(BSTR* p);
    HRESULT put_rubyAlign(BSTR v);
    HRESULT get_rubyAlign(BSTR* p);
    HRESULT put_rubyPosition(BSTR v);
    HRESULT get_rubyPosition(BSTR* p);
    HRESULT put_rubyOverhang(BSTR v);
    HRESULT get_rubyOverhang(BSTR* p);
    HRESULT put_layoutGridChar(VARIANT v);
    HRESULT get_layoutGridChar(VARIANT* p);
    HRESULT put_layoutGridLine(VARIANT v);
    HRESULT get_layoutGridLine(VARIANT* p);
    HRESULT put_layoutGridMode(BSTR v);
    HRESULT get_layoutGridMode(BSTR* p);
    HRESULT put_layoutGridType(BSTR v);
    HRESULT get_layoutGridType(BSTR* p);
    HRESULT put_layoutGrid(BSTR v);
    HRESULT get_layoutGrid(BSTR* p);
    HRESULT put_textAutospace(BSTR v);
    HRESULT get_textAutospace(BSTR* p);
    HRESULT put_wordBreak(BSTR v);
    HRESULT get_wordBreak(BSTR* p);
    HRESULT put_lineBreak(BSTR v);
    HRESULT get_lineBreak(BSTR* p);
    HRESULT put_textJustify(BSTR v);
    HRESULT get_textJustify(BSTR* p);
    HRESULT put_textJustifyTrim(BSTR v);
    HRESULT get_textJustifyTrim(BSTR* p);
    HRESULT put_textKashida(VARIANT v);
    HRESULT get_textKashida(VARIANT* p);
    HRESULT put_overflowX(BSTR v);
    HRESULT get_overflowX(BSTR* p);
    HRESULT put_overflowY(BSTR v);
    HRESULT get_overflowY(BSTR* p);
    HRESULT put_accelerator(BSTR v);
    HRESULT get_accelerator(BSTR* p);
}

@GUID("3050F657-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLRuleStyle3 : IDispatch
{
    HRESULT put_layoutFlow(BSTR v);
    HRESULT get_layoutFlow(BSTR* p);
    HRESULT put_zoom(VARIANT v);
    HRESULT get_zoom(VARIANT* p);
    HRESULT put_wordWrap(BSTR v);
    HRESULT get_wordWrap(BSTR* p);
    HRESULT put_textUnderlinePosition(BSTR v);
    HRESULT get_textUnderlinePosition(BSTR* p);
    HRESULT put_scrollbarBaseColor(VARIANT v);
    HRESULT get_scrollbarBaseColor(VARIANT* p);
    HRESULT put_scrollbarFaceColor(VARIANT v);
    HRESULT get_scrollbarFaceColor(VARIANT* p);
    HRESULT put_scrollbar3dLightColor(VARIANT v);
    HRESULT get_scrollbar3dLightColor(VARIANT* p);
    HRESULT put_scrollbarShadowColor(VARIANT v);
    HRESULT get_scrollbarShadowColor(VARIANT* p);
    HRESULT put_scrollbarHighlightColor(VARIANT v);
    HRESULT get_scrollbarHighlightColor(VARIANT* p);
    HRESULT put_scrollbarDarkShadowColor(VARIANT v);
    HRESULT get_scrollbarDarkShadowColor(VARIANT* p);
    HRESULT put_scrollbarArrowColor(VARIANT v);
    HRESULT get_scrollbarArrowColor(VARIANT* p);
    HRESULT put_scrollbarTrackColor(VARIANT v);
    HRESULT get_scrollbarTrackColor(VARIANT* p);
    HRESULT put_writingMode(BSTR v);
    HRESULT get_writingMode(BSTR* p);
    HRESULT put_textAlignLast(BSTR v);
    HRESULT get_textAlignLast(BSTR* p);
    HRESULT put_textKashidaSpace(VARIANT v);
    HRESULT get_textKashidaSpace(VARIANT* p);
}

@GUID("3050F817-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLRuleStyle4 : IDispatch
{
    HRESULT put_textOverflow(BSTR v);
    HRESULT get_textOverflow(BSTR* p);
    HRESULT put_minHeight(VARIANT v);
    HRESULT get_minHeight(VARIANT* p);
}

@GUID("3050F335-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLRuleStyle5 : IDispatch
{
    HRESULT put_msInterpolationMode(BSTR v);
    HRESULT get_msInterpolationMode(BSTR* p);
    HRESULT put_maxHeight(VARIANT v);
    HRESULT get_maxHeight(VARIANT* p);
    HRESULT put_minWidth(VARIANT v);
    HRESULT get_minWidth(VARIANT* p);
    HRESULT put_maxWidth(VARIANT v);
    HRESULT get_maxWidth(VARIANT* p);
}

@GUID("30510471-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLRuleStyle6 : IDispatch
{
    HRESULT put_content(BSTR v);
    HRESULT get_content(BSTR* p);
    HRESULT put_captionSide(BSTR v);
    HRESULT get_captionSide(BSTR* p);
    HRESULT put_counterIncrement(BSTR v);
    HRESULT get_counterIncrement(BSTR* p);
    HRESULT put_counterReset(BSTR v);
    HRESULT get_counterReset(BSTR* p);
    HRESULT put_outline(BSTR v);
    HRESULT get_outline(BSTR* p);
    HRESULT put_outlineWidth(VARIANT v);
    HRESULT get_outlineWidth(VARIANT* p);
    HRESULT put_outlineStyle(BSTR v);
    HRESULT get_outlineStyle(BSTR* p);
    HRESULT put_outlineColor(VARIANT v);
    HRESULT get_outlineColor(VARIANT* p);
    HRESULT put_boxSizing(BSTR v);
    HRESULT get_boxSizing(BSTR* p);
    HRESULT put_borderSpacing(BSTR v);
    HRESULT get_borderSpacing(BSTR* p);
    HRESULT put_orphans(VARIANT v);
    HRESULT get_orphans(VARIANT* p);
    HRESULT put_widows(VARIANT v);
    HRESULT get_widows(VARIANT* p);
    HRESULT put_pageBreakInside(BSTR v);
    HRESULT get_pageBreakInside(BSTR* p);
    HRESULT put_emptyCells(BSTR v);
    HRESULT get_emptyCells(BSTR* p);
    HRESULT put_msBlockProgression(BSTR v);
    HRESULT get_msBlockProgression(BSTR* p);
    HRESULT put_quotes(BSTR v);
    HRESULT get_quotes(BSTR* p);
}

@GUID("3050F55A-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLStyle : IDispatch
{
}

@GUID("3050F55C-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLRuleStyle : IDispatch
{
}

@GUID("3050F2E5-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleSheetRulesCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, IHTMLStyleSheetRule* ppHTMLStyleSheetRule);
}

@GUID("3050F2E3-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleSheet : IDispatch
{
    HRESULT put_title(BSTR v);
    HRESULT get_title(BSTR* p);
    HRESULT get_parentStyleSheet(IHTMLStyleSheet* p);
    HRESULT get_owningElement(IHTMLElement* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_readOnly(short* p);
    HRESULT get_imports(IHTMLStyleSheetsCollection* p);
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT get_type(BSTR* p);
    HRESULT get_id(BSTR* p);
    HRESULT addImport(BSTR bstrURL, int lIndex, int* plIndex);
    HRESULT addRule(BSTR bstrSelector, BSTR bstrStyle, int lIndex, int* plNewIndex);
    HRESULT removeImport(int lIndex);
    HRESULT removeRule(int lIndex);
    HRESULT put_media(BSTR v);
    HRESULT get_media(BSTR* p);
    HRESULT put_cssText(BSTR v);
    HRESULT get_cssText(BSTR* p);
    HRESULT get_rules(IHTMLStyleSheetRulesCollection* p);
}

@GUID("305106E9-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLCSSRule : IDispatch
{
    HRESULT get_type(ushort* p);
    HRESULT put_cssText(BSTR v);
    HRESULT get_cssText(BSTR* p);
    HRESULT get_parentRule(IHTMLCSSRule* p);
    HRESULT get_parentStyleSheet(IHTMLStyleSheet* p);
}

@GUID("305106EA-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLCSSImportRule : IDispatch
{
    HRESULT get_href(BSTR* p);
    HRESULT put_media(VARIANT v);
    HRESULT get_media(VARIANT* p);
    HRESULT get_styleSheet(IHTMLStyleSheet* p);
}

@GUID("305106EB-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLCSSMediaRule : IDispatch
{
    HRESULT put_media(VARIANT v);
    HRESULT get_media(VARIANT* p);
    HRESULT get_cssRules(IHTMLStyleSheetRulesCollection* p);
    HRESULT insertRule(BSTR bstrRule, int lIndex, int* plNewIndex);
    HRESULT deleteRule(int lIndex);
}

@GUID("30510731-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLCSSMediaList : IDispatch
{
    HRESULT put_mediaText(BSTR v);
    HRESULT get_mediaText(BSTR* p);
    HRESULT get_length(int* p);
    HRESULT item(int index, BSTR* pbstrMedium);
    HRESULT appendMedium(BSTR bstrMedium);
    HRESULT deleteMedium(BSTR bstrMedium);
}

@GUID("305106EE-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLCSSNamespaceRule : IDispatch
{
    HRESULT get_namespaceURI(BSTR* p);
    HRESULT get_prefix(BSTR* p);
}

@GUID("3051080C-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLMSCSSKeyframeRule : IDispatch
{
    HRESULT put_keyText(BSTR v);
    HRESULT get_keyText(BSTR* p);
    HRESULT get_style(IHTMLRuleStyle* p);
}

@GUID("3051080D-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLMSCSSKeyframesRule : IDispatch
{
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT get_cssRules(IHTMLStyleSheetRulesCollection* p);
    HRESULT appendRule(BSTR bstrRule);
    HRESULT deleteRule(BSTR bstrKey);
    HRESULT findRule(BSTR bstrKey, IHTMLMSCSSKeyframeRule* ppMSKeyframeRule);
}

@GUID("3059007D-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLCSSRule : IDispatch
{
}

@GUID("3059007E-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLCSSImportRule : IDispatch
{
}

@GUID("3059007F-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLCSSMediaRule : IDispatch
{
}

@GUID("30590097-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLCSSMediaList : IDispatch
{
}

@GUID("30590080-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLCSSNamespaceRule : IDispatch
{
}

@GUID("305900DE-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLMSCSSKeyframeRule : IDispatch
{
}

@GUID("305900DF-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLMSCSSKeyframesRule : IDispatch
{
}

@GUID("3050F6AE-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLRenderStyle : IDispatch
{
    HRESULT put_textLineThroughStyle(BSTR v);
    HRESULT get_textLineThroughStyle(BSTR* p);
    HRESULT put_textUnderlineStyle(BSTR v);
    HRESULT get_textUnderlineStyle(BSTR* p);
    HRESULT put_textEffect(BSTR v);
    HRESULT get_textEffect(BSTR* p);
    HRESULT put_textColor(VARIANT v);
    HRESULT get_textColor(VARIANT* p);
    HRESULT put_textBackgroundColor(VARIANT v);
    HRESULT get_textBackgroundColor(VARIANT* p);
    HRESULT put_textDecorationColor(VARIANT v);
    HRESULT get_textDecorationColor(VARIANT* p);
    HRESULT put_renderingPriority(int v);
    HRESULT get_renderingPriority(int* p);
    HRESULT put_defaultTextSelection(BSTR v);
    HRESULT get_defaultTextSelection(BSTR* p);
    HRESULT put_textDecoration(BSTR v);
    HRESULT get_textDecoration(BSTR* p);
}

@GUID("3050F58B-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLRenderStyle : IDispatch
{
}

@GUID("3050F3DB-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLCurrentStyle : IDispatch
{
    HRESULT get_position(BSTR* p);
    HRESULT get_styleFloat(BSTR* p);
    HRESULT get_color(VARIANT* p);
    HRESULT get_backgroundColor(VARIANT* p);
    HRESULT get_fontFamily(BSTR* p);
    HRESULT get_fontStyle(BSTR* p);
    HRESULT get_fontVariant(BSTR* p);
    HRESULT get_fontWeight(VARIANT* p);
    HRESULT get_fontSize(VARIANT* p);
    HRESULT get_backgroundImage(BSTR* p);
    HRESULT get_backgroundPositionX(VARIANT* p);
    HRESULT get_backgroundPositionY(VARIANT* p);
    HRESULT get_backgroundRepeat(BSTR* p);
    HRESULT get_borderLeftColor(VARIANT* p);
    HRESULT get_borderTopColor(VARIANT* p);
    HRESULT get_borderRightColor(VARIANT* p);
    HRESULT get_borderBottomColor(VARIANT* p);
    HRESULT get_borderTopStyle(BSTR* p);
    HRESULT get_borderRightStyle(BSTR* p);
    HRESULT get_borderBottomStyle(BSTR* p);
    HRESULT get_borderLeftStyle(BSTR* p);
    HRESULT get_borderTopWidth(VARIANT* p);
    HRESULT get_borderRightWidth(VARIANT* p);
    HRESULT get_borderBottomWidth(VARIANT* p);
    HRESULT get_borderLeftWidth(VARIANT* p);
    HRESULT get_left(VARIANT* p);
    HRESULT get_top(VARIANT* p);
    HRESULT get_width(VARIANT* p);
    HRESULT get_height(VARIANT* p);
    HRESULT get_paddingLeft(VARIANT* p);
    HRESULT get_paddingTop(VARIANT* p);
    HRESULT get_paddingRight(VARIANT* p);
    HRESULT get_paddingBottom(VARIANT* p);
    HRESULT get_textAlign(BSTR* p);
    HRESULT get_textDecoration(BSTR* p);
    HRESULT get_display(BSTR* p);
    HRESULT get_visibility(BSTR* p);
    HRESULT get_zIndex(VARIANT* p);
    HRESULT get_letterSpacing(VARIANT* p);
    HRESULT get_lineHeight(VARIANT* p);
    HRESULT get_textIndent(VARIANT* p);
    HRESULT get_verticalAlign(VARIANT* p);
    HRESULT get_backgroundAttachment(BSTR* p);
    HRESULT get_marginTop(VARIANT* p);
    HRESULT get_marginRight(VARIANT* p);
    HRESULT get_marginBottom(VARIANT* p);
    HRESULT get_marginLeft(VARIANT* p);
    HRESULT get_clear(BSTR* p);
    HRESULT get_listStyleType(BSTR* p);
    HRESULT get_listStylePosition(BSTR* p);
    HRESULT get_listStyleImage(BSTR* p);
    HRESULT get_clipTop(VARIANT* p);
    HRESULT get_clipRight(VARIANT* p);
    HRESULT get_clipBottom(VARIANT* p);
    HRESULT get_clipLeft(VARIANT* p);
    HRESULT get_overflow(BSTR* p);
    HRESULT get_pageBreakBefore(BSTR* p);
    HRESULT get_pageBreakAfter(BSTR* p);
    HRESULT get_cursor(BSTR* p);
    HRESULT get_tableLayout(BSTR* p);
    HRESULT get_borderCollapse(BSTR* p);
    HRESULT get_direction(BSTR* p);
    HRESULT get_behavior(BSTR* p);
    HRESULT getAttribute(BSTR strAttributeName, int lFlags, VARIANT* AttributeValue);
    HRESULT get_unicodeBidi(BSTR* p);
    HRESULT get_right(VARIANT* p);
    HRESULT get_bottom(VARIANT* p);
    HRESULT get_imeMode(BSTR* p);
    HRESULT get_rubyAlign(BSTR* p);
    HRESULT get_rubyPosition(BSTR* p);
    HRESULT get_rubyOverhang(BSTR* p);
    HRESULT get_textAutospace(BSTR* p);
    HRESULT get_lineBreak(BSTR* p);
    HRESULT get_wordBreak(BSTR* p);
    HRESULT get_textJustify(BSTR* p);
    HRESULT get_textJustifyTrim(BSTR* p);
    HRESULT get_textKashida(VARIANT* p);
    HRESULT get_blockDirection(BSTR* p);
    HRESULT get_layoutGridChar(VARIANT* p);
    HRESULT get_layoutGridLine(VARIANT* p);
    HRESULT get_layoutGridMode(BSTR* p);
    HRESULT get_layoutGridType(BSTR* p);
    HRESULT get_borderStyle(BSTR* p);
    HRESULT get_borderColor(BSTR* p);
    HRESULT get_borderWidth(BSTR* p);
    HRESULT get_padding(BSTR* p);
    HRESULT get_margin(BSTR* p);
    HRESULT get_accelerator(BSTR* p);
    HRESULT get_overflowX(BSTR* p);
    HRESULT get_overflowY(BSTR* p);
    HRESULT get_textTransform(BSTR* p);
}

@GUID("3050F658-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLCurrentStyle2 : IDispatch
{
    HRESULT get_layoutFlow(BSTR* p);
    HRESULT get_wordWrap(BSTR* p);
    HRESULT get_textUnderlinePosition(BSTR* p);
    HRESULT get_hasLayout(short* p);
    HRESULT get_scrollbarBaseColor(VARIANT* p);
    HRESULT get_scrollbarFaceColor(VARIANT* p);
    HRESULT get_scrollbar3dLightColor(VARIANT* p);
    HRESULT get_scrollbarShadowColor(VARIANT* p);
    HRESULT get_scrollbarHighlightColor(VARIANT* p);
    HRESULT get_scrollbarDarkShadowColor(VARIANT* p);
    HRESULT get_scrollbarArrowColor(VARIANT* p);
    HRESULT get_scrollbarTrackColor(VARIANT* p);
    HRESULT get_writingMode(BSTR* p);
    HRESULT get_zoom(VARIANT* p);
    HRESULT get_filter(BSTR* p);
    HRESULT get_textAlignLast(BSTR* p);
    HRESULT get_textKashidaSpace(VARIANT* p);
    HRESULT get_isBlock(short* p);
}

@GUID("3050F818-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLCurrentStyle3 : IDispatch
{
    HRESULT get_textOverflow(BSTR* p);
    HRESULT get_minHeight(VARIANT* p);
    HRESULT get_wordSpacing(VARIANT* p);
    HRESULT get_whiteSpace(BSTR* p);
}

@GUID("3050F33B-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLCurrentStyle4 : IDispatch
{
    HRESULT get_msInterpolationMode(BSTR* p);
    HRESULT get_maxHeight(VARIANT* p);
    HRESULT get_minWidth(VARIANT* p);
    HRESULT get_maxWidth(VARIANT* p);
}

@GUID("30510481-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLCurrentStyle5 : IDispatch
{
    HRESULT get_captionSide(BSTR* p);
    HRESULT get_outline(BSTR* p);
    HRESULT get_outlineWidth(VARIANT* p);
    HRESULT get_outlineStyle(BSTR* p);
    HRESULT get_outlineColor(VARIANT* p);
    HRESULT get_boxSizing(BSTR* p);
    HRESULT get_borderSpacing(BSTR* p);
    HRESULT get_orphans(VARIANT* p);
    HRESULT get_widows(VARIANT* p);
    HRESULT get_pageBreakInside(BSTR* p);
    HRESULT get_emptyCells(BSTR* p);
    HRESULT get_msBlockProgression(BSTR* p);
    HRESULT get_quotes(BSTR* p);
}

@GUID("3050F557-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLCurrentStyle : IDispatch
{
}

@GUID("3050F1FF-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLElement : IDispatch
{
    HRESULT setAttribute(BSTR strAttributeName, VARIANT AttributeValue, int lFlags);
    HRESULT getAttribute(BSTR strAttributeName, int lFlags, VARIANT* AttributeValue);
    HRESULT removeAttribute(BSTR strAttributeName, int lFlags, short* pfSuccess);
    HRESULT put_className(BSTR v);
    HRESULT get_className(BSTR* p);
    HRESULT put_id(BSTR v);
    HRESULT get_id(BSTR* p);
    HRESULT get_tagName(BSTR* p);
    HRESULT get_parentElement(IHTMLElement* p);
    HRESULT get_style(IHTMLStyle* p);
    HRESULT put_onhelp(VARIANT v);
    HRESULT get_onhelp(VARIANT* p);
    HRESULT put_onclick(VARIANT v);
    HRESULT get_onclick(VARIANT* p);
    HRESULT put_ondblclick(VARIANT v);
    HRESULT get_ondblclick(VARIANT* p);
    HRESULT put_onkeydown(VARIANT v);
    HRESULT get_onkeydown(VARIANT* p);
    HRESULT put_onkeyup(VARIANT v);
    HRESULT get_onkeyup(VARIANT* p);
    HRESULT put_onkeypress(VARIANT v);
    HRESULT get_onkeypress(VARIANT* p);
    HRESULT put_onmouseout(VARIANT v);
    HRESULT get_onmouseout(VARIANT* p);
    HRESULT put_onmouseover(VARIANT v);
    HRESULT get_onmouseover(VARIANT* p);
    HRESULT put_onmousemove(VARIANT v);
    HRESULT get_onmousemove(VARIANT* p);
    HRESULT put_onmousedown(VARIANT v);
    HRESULT get_onmousedown(VARIANT* p);
    HRESULT put_onmouseup(VARIANT v);
    HRESULT get_onmouseup(VARIANT* p);
    HRESULT get_document(IDispatch* p);
    HRESULT put_title(BSTR v);
    HRESULT get_title(BSTR* p);
    HRESULT put_language(BSTR v);
    HRESULT get_language(BSTR* p);
    HRESULT put_onselectstart(VARIANT v);
    HRESULT get_onselectstart(VARIANT* p);
    HRESULT scrollIntoView(VARIANT varargStart);
    HRESULT contains(IHTMLElement pChild, short* pfResult);
    HRESULT get_sourceIndex(int* p);
    HRESULT get_recordNumber(VARIANT* p);
    HRESULT put_lang(BSTR v);
    HRESULT get_lang(BSTR* p);
    HRESULT get_offsetLeft(int* p);
    HRESULT get_offsetTop(int* p);
    HRESULT get_offsetWidth(int* p);
    HRESULT get_offsetHeight(int* p);
    HRESULT get_offsetParent(IHTMLElement* p);
    HRESULT put_innerHTML(BSTR v);
    HRESULT get_innerHTML(BSTR* p);
    HRESULT put_innerText(BSTR v);
    HRESULT get_innerText(BSTR* p);
    HRESULT put_outerHTML(BSTR v);
    HRESULT get_outerHTML(BSTR* p);
    HRESULT put_outerText(BSTR v);
    HRESULT get_outerText(BSTR* p);
    HRESULT insertAdjacentHTML(BSTR where, BSTR html);
    HRESULT insertAdjacentText(BSTR where, BSTR text);
    HRESULT get_parentTextEdit(IHTMLElement* p);
    HRESULT get_isTextEdit(short* p);
    HRESULT click();
    HRESULT get_filters(IHTMLFiltersCollection* p);
    HRESULT put_ondragstart(VARIANT v);
    HRESULT get_ondragstart(VARIANT* p);
    HRESULT toString(BSTR* String);
    HRESULT put_onbeforeupdate(VARIANT v);
    HRESULT get_onbeforeupdate(VARIANT* p);
    HRESULT put_onafterupdate(VARIANT v);
    HRESULT get_onafterupdate(VARIANT* p);
    HRESULT put_onerrorupdate(VARIANT v);
    HRESULT get_onerrorupdate(VARIANT* p);
    HRESULT put_onrowexit(VARIANT v);
    HRESULT get_onrowexit(VARIANT* p);
    HRESULT put_onrowenter(VARIANT v);
    HRESULT get_onrowenter(VARIANT* p);
    HRESULT put_ondatasetchanged(VARIANT v);
    HRESULT get_ondatasetchanged(VARIANT* p);
    HRESULT put_ondataavailable(VARIANT v);
    HRESULT get_ondataavailable(VARIANT* p);
    HRESULT put_ondatasetcomplete(VARIANT v);
    HRESULT get_ondatasetcomplete(VARIANT* p);
    HRESULT put_onfilterchange(VARIANT v);
    HRESULT get_onfilterchange(VARIANT* p);
    HRESULT get_children(IDispatch* p);
    HRESULT get_all(IDispatch* p);
}

@GUID("3050F4A3-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLRect : IDispatch
{
    HRESULT put_left(int v);
    HRESULT get_left(int* p);
    HRESULT put_top(int v);
    HRESULT get_top(int* p);
    HRESULT put_right(int v);
    HRESULT get_right(int* p);
    HRESULT put_bottom(int v);
    HRESULT get_bottom(int* p);
}

@GUID("3051076C-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLRect2 : IDispatch
{
    HRESULT get_width(float* p);
    HRESULT get_height(float* p);
}

@GUID("3050F4A4-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLRectCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT* pvarIndex, VARIANT* pvarResult);
}

@GUID("3050F21F-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLElementCollection : IDispatch
{
    HRESULT toString(BSTR* String);
    HRESULT put_length(int v);
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT name, VARIANT index, IDispatch* pdisp);
    HRESULT tags(VARIANT tagName, IDispatch* pdisp);
}

@GUID("3050F434-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLElement2 : IDispatch
{
    HRESULT get_scopeName(BSTR* p);
    HRESULT setCapture(short containerCapture);
    HRESULT releaseCapture();
    HRESULT put_onlosecapture(VARIANT v);
    HRESULT get_onlosecapture(VARIANT* p);
    HRESULT componentFromPoint(int x, int y, BSTR* component);
    HRESULT doScroll(VARIANT component);
    HRESULT put_onscroll(VARIANT v);
    HRESULT get_onscroll(VARIANT* p);
    HRESULT put_ondrag(VARIANT v);
    HRESULT get_ondrag(VARIANT* p);
    HRESULT put_ondragend(VARIANT v);
    HRESULT get_ondragend(VARIANT* p);
    HRESULT put_ondragenter(VARIANT v);
    HRESULT get_ondragenter(VARIANT* p);
    HRESULT put_ondragover(VARIANT v);
    HRESULT get_ondragover(VARIANT* p);
    HRESULT put_ondragleave(VARIANT v);
    HRESULT get_ondragleave(VARIANT* p);
    HRESULT put_ondrop(VARIANT v);
    HRESULT get_ondrop(VARIANT* p);
    HRESULT put_onbeforecut(VARIANT v);
    HRESULT get_onbeforecut(VARIANT* p);
    HRESULT put_oncut(VARIANT v);
    HRESULT get_oncut(VARIANT* p);
    HRESULT put_onbeforecopy(VARIANT v);
    HRESULT get_onbeforecopy(VARIANT* p);
    HRESULT put_oncopy(VARIANT v);
    HRESULT get_oncopy(VARIANT* p);
    HRESULT put_onbeforepaste(VARIANT v);
    HRESULT get_onbeforepaste(VARIANT* p);
    HRESULT put_onpaste(VARIANT v);
    HRESULT get_onpaste(VARIANT* p);
    HRESULT get_currentStyle(IHTMLCurrentStyle* p);
    HRESULT put_onpropertychange(VARIANT v);
    HRESULT get_onpropertychange(VARIANT* p);
    HRESULT getClientRects(IHTMLRectCollection* pRectCol);
    HRESULT getBoundingClientRect(IHTMLRect* pRect);
    HRESULT setExpression(BSTR propname, BSTR expression, BSTR language);
    HRESULT getExpression(BSTR propname, VARIANT* expression);
    HRESULT removeExpression(BSTR propname, short* pfSuccess);
    HRESULT put_tabIndex(short v);
    HRESULT get_tabIndex(short* p);
    HRESULT focus();
    HRESULT put_accessKey(BSTR v);
    HRESULT get_accessKey(BSTR* p);
    HRESULT put_onblur(VARIANT v);
    HRESULT get_onblur(VARIANT* p);
    HRESULT put_onfocus(VARIANT v);
    HRESULT get_onfocus(VARIANT* p);
    HRESULT put_onresize(VARIANT v);
    HRESULT get_onresize(VARIANT* p);
    HRESULT blur();
    HRESULT addFilter(IUnknown pUnk);
    HRESULT removeFilter(IUnknown pUnk);
    HRESULT get_clientHeight(int* p);
    HRESULT get_clientWidth(int* p);
    HRESULT get_clientTop(int* p);
    HRESULT get_clientLeft(int* p);
    HRESULT attachEvent(BSTR event, IDispatch pDisp, short* pfResult);
    HRESULT detachEvent(BSTR event, IDispatch pDisp);
    HRESULT get_readyState(VARIANT* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT put_onrowsdelete(VARIANT v);
    HRESULT get_onrowsdelete(VARIANT* p);
    HRESULT put_onrowsinserted(VARIANT v);
    HRESULT get_onrowsinserted(VARIANT* p);
    HRESULT put_oncellchange(VARIANT v);
    HRESULT get_oncellchange(VARIANT* p);
    HRESULT put_dir(BSTR v);
    HRESULT get_dir(BSTR* p);
    HRESULT createControlRange(IDispatch* range);
    HRESULT get_scrollHeight(int* p);
    HRESULT get_scrollWidth(int* p);
    HRESULT put_scrollTop(int v);
    HRESULT get_scrollTop(int* p);
    HRESULT put_scrollLeft(int v);
    HRESULT get_scrollLeft(int* p);
    HRESULT clearAttributes();
    HRESULT mergeAttributes(IHTMLElement mergeThis);
    HRESULT put_oncontextmenu(VARIANT v);
    HRESULT get_oncontextmenu(VARIANT* p);
    HRESULT insertAdjacentElement(BSTR where, IHTMLElement insertedElement, IHTMLElement* inserted);
    HRESULT applyElement(IHTMLElement apply, BSTR where, IHTMLElement* applied);
    HRESULT getAdjacentText(BSTR where, BSTR* text);
    HRESULT replaceAdjacentText(BSTR where, BSTR newText, BSTR* oldText);
    HRESULT get_canHaveChildren(short* p);
    HRESULT addBehavior(BSTR bstrUrl, VARIANT* pvarFactory, int* pCookie);
    HRESULT removeBehavior(int cookie, short* pfResult);
    HRESULT get_runtimeStyle(IHTMLStyle* p);
    HRESULT get_behaviorUrns(IDispatch* p);
    HRESULT put_tagUrn(BSTR v);
    HRESULT get_tagUrn(BSTR* p);
    HRESULT put_onbeforeeditfocus(VARIANT v);
    HRESULT get_onbeforeeditfocus(VARIANT* p);
    HRESULT get_readyStateValue(int* p);
    HRESULT getElementsByTagName(BSTR v, IHTMLElementCollection* pelColl);
}

@GUID("30510469-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLAttributeCollection3 : IDispatch
{
    HRESULT getNamedItem(BSTR bstrName, IHTMLDOMAttribute* ppNodeOut);
    HRESULT setNamedItem(IHTMLDOMAttribute pNodeIn, IHTMLDOMAttribute* ppNodeOut);
    HRESULT removeNamedItem(BSTR bstrName, IHTMLDOMAttribute* ppNodeOut);
    HRESULT item(int index, IHTMLDOMAttribute* ppNodeOut);
    HRESULT get_length(int* p);
}

@GUID("30510738-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMDocumentType : IDispatch
{
    HRESULT get_name(BSTR* p);
    HRESULT get_entities(IDispatch* p);
    HRESULT get_notations(IDispatch* p);
    HRESULT get_publicId(VARIANT* p);
    HRESULT get_systemId(VARIANT* p);
    HRESULT get_internalSubset(VARIANT* p);
}

@GUID("305104B8-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDocument7 : IDispatch
{
    HRESULT get_defaultView(IHTMLWindow2* p);
    HRESULT createCDATASection(BSTR text, IHTMLDOMNode* newCDATASectionNode);
    HRESULT getSelection(IHTMLSelection* ppIHTMLSelection);
    HRESULT getElementsByTagNameNS(VARIANT* pvarNS, BSTR bstrLocalName, IHTMLElementCollection* pelColl);
    HRESULT createElementNS(VARIANT* pvarNS, BSTR bstrTag, IHTMLElement* newElem);
    HRESULT createAttributeNS(VARIANT* pvarNS, BSTR bstrAttrName, IHTMLDOMAttribute* ppAttribute);
    HRESULT put_onmsthumbnailclick(VARIANT v);
    HRESULT get_onmsthumbnailclick(VARIANT* p);
    HRESULT get_characterSet(BSTR* p);
    HRESULT createElement(BSTR bstrTag, IHTMLElement* newElem);
    HRESULT createAttribute(BSTR bstrAttrName, IHTMLDOMAttribute* ppAttribute);
    HRESULT getElementsByClassName(BSTR v, IHTMLElementCollection* pel);
    HRESULT createProcessingInstruction(BSTR bstrTarget, BSTR bstrData, 
                                        IDOMProcessingInstruction* newProcessingInstruction);
    HRESULT adoptNode(IHTMLDOMNode pNodeSource, IHTMLDOMNode3* ppNodeDest);
    HRESULT put_onmssitemodejumplistitemremoved(VARIANT v);
    HRESULT get_onmssitemodejumplistitemremoved(VARIANT* p);
    HRESULT get_all(IHTMLElementCollection* p);
    HRESULT get_inputEncoding(BSTR* p);
    HRESULT get_xmlEncoding(BSTR* p);
    HRESULT put_xmlStandalone(short v);
    HRESULT get_xmlStandalone(short* p);
    HRESULT put_xmlVersion(BSTR v);
    HRESULT get_xmlVersion(BSTR* p);
    HRESULT hasAttributes(short* pfHasAttributes);
    HRESULT put_onabort(VARIANT v);
    HRESULT get_onabort(VARIANT* p);
    HRESULT put_onblur(VARIANT v);
    HRESULT get_onblur(VARIANT* p);
    HRESULT put_oncanplay(VARIANT v);
    HRESULT get_oncanplay(VARIANT* p);
    HRESULT put_oncanplaythrough(VARIANT v);
    HRESULT get_oncanplaythrough(VARIANT* p);
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_ondrag(VARIANT v);
    HRESULT get_ondrag(VARIANT* p);
    HRESULT put_ondragend(VARIANT v);
    HRESULT get_ondragend(VARIANT* p);
    HRESULT put_ondragenter(VARIANT v);
    HRESULT get_ondragenter(VARIANT* p);
    HRESULT put_ondragleave(VARIANT v);
    HRESULT get_ondragleave(VARIANT* p);
    HRESULT put_ondragover(VARIANT v);
    HRESULT get_ondragover(VARIANT* p);
    HRESULT put_ondrop(VARIANT v);
    HRESULT get_ondrop(VARIANT* p);
    HRESULT put_ondurationchange(VARIANT v);
    HRESULT get_ondurationchange(VARIANT* p);
    HRESULT put_onemptied(VARIANT v);
    HRESULT get_onemptied(VARIANT* p);
    HRESULT put_onended(VARIANT v);
    HRESULT get_onended(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_onfocus(VARIANT v);
    HRESULT get_onfocus(VARIANT* p);
    HRESULT put_oninput(VARIANT v);
    HRESULT get_oninput(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onloadeddata(VARIANT v);
    HRESULT get_onloadeddata(VARIANT* p);
    HRESULT put_onloadedmetadata(VARIANT v);
    HRESULT get_onloadedmetadata(VARIANT* p);
    HRESULT put_onloadstart(VARIANT v);
    HRESULT get_onloadstart(VARIANT* p);
    HRESULT put_onpause(VARIANT v);
    HRESULT get_onpause(VARIANT* p);
    HRESULT put_onplay(VARIANT v);
    HRESULT get_onplay(VARIANT* p);
    HRESULT put_onplaying(VARIANT v);
    HRESULT get_onplaying(VARIANT* p);
    HRESULT put_onprogress(VARIANT v);
    HRESULT get_onprogress(VARIANT* p);
    HRESULT put_onratechange(VARIANT v);
    HRESULT get_onratechange(VARIANT* p);
    HRESULT put_onreset(VARIANT v);
    HRESULT get_onreset(VARIANT* p);
    HRESULT put_onscroll(VARIANT v);
    HRESULT get_onscroll(VARIANT* p);
    HRESULT put_onseeked(VARIANT v);
    HRESULT get_onseeked(VARIANT* p);
    HRESULT put_onseeking(VARIANT v);
    HRESULT get_onseeking(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_onstalled(VARIANT v);
    HRESULT get_onstalled(VARIANT* p);
    HRESULT put_onsubmit(VARIANT v);
    HRESULT get_onsubmit(VARIANT* p);
    HRESULT put_onsuspend(VARIANT v);
    HRESULT get_onsuspend(VARIANT* p);
    HRESULT put_ontimeupdate(VARIANT v);
    HRESULT get_ontimeupdate(VARIANT* p);
    HRESULT put_onvolumechange(VARIANT v);
    HRESULT get_onvolumechange(VARIANT* p);
    HRESULT put_onwaiting(VARIANT v);
    HRESULT get_onwaiting(VARIANT* p);
    HRESULT normalize();
    HRESULT importNode(IHTMLDOMNode pNodeSource, short fDeep, IHTMLDOMNode3* ppNodeDest);
    HRESULT get_parentWindow(IHTMLWindow2* p);
    HRESULT putref_body(IHTMLElement v);
    HRESULT get_body(IHTMLElement* p);
    HRESULT get_head(IHTMLElement* p);
}

@GUID("3050F5DA-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDOMNode : IDispatch
{
    HRESULT get_nodeType(int* p);
    HRESULT get_parentNode(IHTMLDOMNode* p);
    HRESULT hasChildNodes(short* fChildren);
    HRESULT get_childNodes(IDispatch* p);
    HRESULT get_attributes(IDispatch* p);
    HRESULT insertBefore(IHTMLDOMNode newChild, VARIANT refChild, IHTMLDOMNode* node);
    HRESULT removeChild(IHTMLDOMNode oldChild, IHTMLDOMNode* node);
    HRESULT replaceChild(IHTMLDOMNode newChild, IHTMLDOMNode oldChild, IHTMLDOMNode* node);
    HRESULT cloneNode(short fDeep, IHTMLDOMNode* clonedNode);
    HRESULT removeNode(short fDeep, IHTMLDOMNode* removed);
    HRESULT swapNode(IHTMLDOMNode otherNode, IHTMLDOMNode* swappedNode);
    HRESULT replaceNode(IHTMLDOMNode replacement, IHTMLDOMNode* replaced);
    HRESULT appendChild(IHTMLDOMNode newChild, IHTMLDOMNode* node);
    HRESULT get_nodeName(BSTR* p);
    HRESULT put_nodeValue(VARIANT v);
    HRESULT get_nodeValue(VARIANT* p);
    HRESULT get_firstChild(IHTMLDOMNode* p);
    HRESULT get_lastChild(IHTMLDOMNode* p);
    HRESULT get_previousSibling(IHTMLDOMNode* p);
    HRESULT get_nextSibling(IHTMLDOMNode* p);
}

@GUID("3050F80B-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDOMNode2 : IDispatch
{
    HRESULT get_ownerDocument(IDispatch* p);
}

@GUID("305106E0-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDOMNode3 : IDispatch
{
    HRESULT put_prefix(VARIANT v);
    HRESULT get_prefix(VARIANT* p);
    HRESULT get_localName(VARIANT* p);
    HRESULT get_namespaceURI(VARIANT* p);
    HRESULT put_textContent(VARIANT v);
    HRESULT get_textContent(VARIANT* p);
    HRESULT isEqualNode(IHTMLDOMNode3 otherNode, short* isEqual);
    HRESULT lookupNamespaceURI(VARIANT* pvarPrefix, VARIANT* pvarNamespaceURI);
    HRESULT lookupPrefix(VARIANT* pvarNamespaceURI, VARIANT* pvarPrefix);
    HRESULT isDefaultNamespace(VARIANT* pvarNamespace, short* pfDefaultNamespace);
    HRESULT appendChild(IHTMLDOMNode newChild, IHTMLDOMNode* node);
    HRESULT insertBefore(IHTMLDOMNode newChild, VARIANT refChild, IHTMLDOMNode* node);
    HRESULT removeChild(IHTMLDOMNode oldChild, IHTMLDOMNode* node);
    HRESULT replaceChild(IHTMLDOMNode newChild, IHTMLDOMNode oldChild, IHTMLDOMNode* node);
    HRESULT isSameNode(IHTMLDOMNode3 otherNode, short* isSame);
    HRESULT compareDocumentPosition(IHTMLDOMNode otherNode, ushort* flags);
    HRESULT isSupported(BSTR feature, VARIANT version_, short* pfisSupported);
}

@GUID("3050F4B0-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDOMAttribute : IDispatch
{
    HRESULT get_nodeName(BSTR* p);
    HRESULT put_nodeValue(VARIANT v);
    HRESULT get_nodeValue(VARIANT* p);
    HRESULT get_specified(short* p);
}

@GUID("3050F810-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDOMAttribute2 : IDispatch
{
    HRESULT get_name(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT get_expando(short* p);
    HRESULT get_nodeType(int* p);
    HRESULT get_parentNode(IHTMLDOMNode* p);
    HRESULT get_childNodes(IDispatch* p);
    HRESULT get_firstChild(IHTMLDOMNode* p);
    HRESULT get_lastChild(IHTMLDOMNode* p);
    HRESULT get_previousSibling(IHTMLDOMNode* p);
    HRESULT get_nextSibling(IHTMLDOMNode* p);
    HRESULT get_attributes(IDispatch* p);
    HRESULT get_ownerDocument(IDispatch* p);
    HRESULT insertBefore(IHTMLDOMNode newChild, VARIANT refChild, IHTMLDOMNode* node);
    HRESULT replaceChild(IHTMLDOMNode newChild, IHTMLDOMNode oldChild, IHTMLDOMNode* node);
    HRESULT removeChild(IHTMLDOMNode oldChild, IHTMLDOMNode* node);
    HRESULT appendChild(IHTMLDOMNode newChild, IHTMLDOMNode* node);
    HRESULT hasChildNodes(short* fChildren);
    HRESULT cloneNode(short fDeep, IHTMLDOMAttribute* clonedNode);
}

@GUID("30510468-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDOMAttribute3 : IDispatch
{
    HRESULT put_nodeValue(VARIANT v);
    HRESULT get_nodeValue(VARIANT* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT get_specified(short* p);
    HRESULT get_ownerElement(IHTMLElement2* p);
}

@GUID("305106F9-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDOMAttribute4 : IDispatch
{
    HRESULT put_nodeValue(VARIANT v);
    HRESULT get_nodeValue(VARIANT* p);
    HRESULT get_nodeName(BSTR* p);
    HRESULT get_name(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT get_firstChild(IHTMLDOMNode* p);
    HRESULT get_lastChild(IHTMLDOMNode* p);
    HRESULT get_childNodes(IDispatch* p);
    HRESULT hasAttributes(short* pfHasAttributes);
    HRESULT hasChildNodes(short* fChildren);
    HRESULT normalize();
    HRESULT get_specified(short* p);
}

@GUID("3050F4B1-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDOMTextNode : IDispatch
{
    HRESULT put_data(BSTR v);
    HRESULT get_data(BSTR* p);
    HRESULT toString(BSTR* String);
    HRESULT get_length(int* p);
    HRESULT splitText(int offset, IHTMLDOMNode* pRetNode);
}

@GUID("3050F809-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDOMTextNode2 : IDispatch
{
    HRESULT substringData(int offset, int Count, BSTR* pbstrsubString);
    HRESULT appendData(BSTR bstrstring);
    HRESULT insertData(int offset, BSTR bstrstring);
    HRESULT deleteData(int offset, int Count);
    HRESULT replaceData(int offset, int Count, BSTR bstrstring);
}

@GUID("3051073E-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDOMTextNode3 : IDispatch
{
    HRESULT substringData(int offset, int Count, BSTR* pbstrsubString);
    HRESULT insertData(int offset, BSTR bstrstring);
    HRESULT deleteData(int offset, int Count);
    HRESULT replaceData(int offset, int Count, BSTR bstrstring);
    HRESULT splitText(int offset, IHTMLDOMNode* pRetNode);
    HRESULT get_wholeText(BSTR* p);
    HRESULT replaceWholeText(BSTR bstrText, IHTMLDOMNode* ppRetNode);
    HRESULT hasAttributes(short* pfHasAttributes);
    HRESULT normalize();
}

@GUID("3050F80D-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDOMImplementation : IDispatch
{
    HRESULT hasFeature(BSTR bstrfeature, VARIANT version_, short* pfHasFeature);
}

@GUID("3051073C-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDOMImplementation2 : IDispatch
{
    HRESULT createDocumentType(BSTR bstrQualifiedName, VARIANT* pvarPublicId, VARIANT* pvarSystemId, 
                               IDOMDocumentType* newDocumentType);
    HRESULT createDocument(VARIANT* pvarNS, VARIANT* pvarTagName, IDOMDocumentType pDocumentType, 
                           IHTMLDocument7* ppnewDocument);
    HRESULT createHTMLDocument(BSTR bstrTitle, IHTMLDocument7* ppnewDocument);
    HRESULT hasFeature(BSTR bstrfeature, VARIANT version_, short* pfHasFeature);
}

@GUID("3050F564-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLDOMAttribute : IDispatch
{
}

@GUID("3050F565-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLDOMTextNode : IDispatch
{
}

@GUID("3050F58F-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLDOMImplementation : IDispatch
{
}

@GUID("3050F4C3-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLAttributeCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT* name, IDispatch* pdisp);
}

@GUID("3050F80A-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLAttributeCollection2 : IDispatch
{
    HRESULT getNamedItem(BSTR bstrName, IHTMLDOMAttribute* newretNode);
    HRESULT setNamedItem(IHTMLDOMAttribute ppNode, IHTMLDOMAttribute* newretNode);
    HRESULT removeNamedItem(BSTR bstrName, IHTMLDOMAttribute* newretNode);
}

@GUID("305106FA-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLAttributeCollection4 : IDispatch
{
    HRESULT getNamedItemNS(VARIANT* pvarNS, BSTR bstrName, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT setNamedItemNS(IHTMLDOMAttribute2 pNodeIn, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT removeNamedItemNS(VARIANT* pvarNS, BSTR bstrName, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT getNamedItem(BSTR bstrName, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT setNamedItem(IHTMLDOMAttribute2 pNodeIn, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT removeNamedItem(BSTR bstrName, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT item(int index, IHTMLDOMAttribute2* ppNodeOut);
    HRESULT get_length(int* p);
}

@GUID("3050F5AB-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDOMChildrenCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(int index, IDispatch* ppItem);
}

@GUID("30510791-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDOMChildrenCollection2 : IDispatch
{
    HRESULT item(int index, IDispatch* ppItem);
}

@GUID("3050F56C-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLAttributeCollection : IDispatch
{
}

@GUID("3050F59B-98B5-11CF-BB82-00AA00BDCE0B")
interface DispStaticNodeList : IDispatch
{
}

@GUID("3050F577-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMChildrenCollection : IDispatch
{
}

@GUID("3051075E-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLElementEvents4 : IDispatch
{
}

@GUID("3050F59F-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLElementEvents3 : IDispatch
{
}

@GUID("3050F60F-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLElementEvents2 : IDispatch
{
}

@GUID("3050F33C-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLElementEvents : IDispatch
{
}

@GUID("305104BE-98B5-11CF-BB82-00AA00BDCE0B")
interface IRulesAppliedCollection : IDispatch
{
    HRESULT item(int index, IRulesApplied* ppRulesApplied);
    HRESULT get_length(int* p);
    HRESULT get_element(IHTMLElement* p);
    HRESULT propertyInheritedFrom(BSTR name, IRulesApplied* ppRulesApplied);
    HRESULT get_propertyCount(int* p);
    HRESULT property(int index, BSTR* pbstrProperty);
    HRESULT propertyInheritedTrace(BSTR name, int index, IRulesApplied* ppRulesApplied);
    HRESULT propertyInheritedTraceLength(BSTR name, int* pLength);
}

@GUID("3050F673-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLElement3 : IDispatch
{
    HRESULT mergeAttributes(IHTMLElement mergeThis, VARIANT* pvarFlags);
    HRESULT get_isMultiLine(short* p);
    HRESULT get_canHaveHTML(short* p);
    HRESULT put_onlayoutcomplete(VARIANT v);
    HRESULT get_onlayoutcomplete(VARIANT* p);
    HRESULT put_onpage(VARIANT v);
    HRESULT get_onpage(VARIANT* p);
    HRESULT put_inflateBlock(short v);
    HRESULT get_inflateBlock(short* p);
    HRESULT put_onbeforedeactivate(VARIANT v);
    HRESULT get_onbeforedeactivate(VARIANT* p);
    HRESULT setActive();
    HRESULT put_contentEditable(BSTR v);
    HRESULT get_contentEditable(BSTR* p);
    HRESULT get_isContentEditable(short* p);
    HRESULT put_hideFocus(short v);
    HRESULT get_hideFocus(short* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_isDisabled(short* p);
    HRESULT put_onmove(VARIANT v);
    HRESULT get_onmove(VARIANT* p);
    HRESULT put_oncontrolselect(VARIANT v);
    HRESULT get_oncontrolselect(VARIANT* p);
    HRESULT fireEvent(BSTR bstrEventName, VARIANT* pvarEventObject, short* pfCancelled);
    HRESULT put_onresizestart(VARIANT v);
    HRESULT get_onresizestart(VARIANT* p);
    HRESULT put_onresizeend(VARIANT v);
    HRESULT get_onresizeend(VARIANT* p);
    HRESULT put_onmovestart(VARIANT v);
    HRESULT get_onmovestart(VARIANT* p);
    HRESULT put_onmoveend(VARIANT v);
    HRESULT get_onmoveend(VARIANT* p);
    HRESULT put_onmouseenter(VARIANT v);
    HRESULT get_onmouseenter(VARIANT* p);
    HRESULT put_onmouseleave(VARIANT v);
    HRESULT get_onmouseleave(VARIANT* p);
    HRESULT put_onactivate(VARIANT v);
    HRESULT get_onactivate(VARIANT* p);
    HRESULT put_ondeactivate(VARIANT v);
    HRESULT get_ondeactivate(VARIANT* p);
    HRESULT dragDrop(short* pfRet);
    HRESULT get_glyphMode(int* p);
}

@GUID("3050F80F-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLElement4 : IDispatch
{
    HRESULT put_onmousewheel(VARIANT v);
    HRESULT get_onmousewheel(VARIANT* p);
    HRESULT normalize();
    HRESULT getAttributeNode(BSTR bstrname, IHTMLDOMAttribute* ppAttribute);
    HRESULT setAttributeNode(IHTMLDOMAttribute pattr, IHTMLDOMAttribute* ppretAttribute);
    HRESULT removeAttributeNode(IHTMLDOMAttribute pattr, IHTMLDOMAttribute* ppretAttribute);
    HRESULT put_onbeforeactivate(VARIANT v);
    HRESULT get_onbeforeactivate(VARIANT* p);
    HRESULT put_onfocusin(VARIANT v);
    HRESULT get_onfocusin(VARIANT* p);
    HRESULT put_onfocusout(VARIANT v);
    HRESULT get_onfocusout(VARIANT* p);
}

@GUID("30510463-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementSelector : IDispatch
{
    HRESULT querySelector(BSTR v, IHTMLElement* pel);
    HRESULT querySelectorAll(BSTR v, IHTMLDOMChildrenCollection* pel);
}

@GUID("3050F669-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLElementRender : IUnknown
{
    HRESULT DrawToDC(HDC hDC);
    HRESULT SetDocumentPrinter(BSTR bstrPrinterName, HDC hDC);
}

@GUID("3050F4D0-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLUniqueName : IDispatch
{
    HRESULT get_uniqueNumber(int* p);
    HRESULT get_uniqueID(BSTR* p);
}

@GUID("3051045D-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLElement5 : IDispatch
{
    HRESULT getAttributeNode(BSTR bstrname, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT setAttributeNode(IHTMLDOMAttribute2 pattr, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT removeAttributeNode(IHTMLDOMAttribute2 pattr, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT hasAttribute(BSTR name, short* pfHasAttribute);
    HRESULT put_role(BSTR v);
    HRESULT get_role(BSTR* p);
    HRESULT put_ariaBusy(BSTR v);
    HRESULT get_ariaBusy(BSTR* p);
    HRESULT put_ariaChecked(BSTR v);
    HRESULT get_ariaChecked(BSTR* p);
    HRESULT put_ariaDisabled(BSTR v);
    HRESULT get_ariaDisabled(BSTR* p);
    HRESULT put_ariaExpanded(BSTR v);
    HRESULT get_ariaExpanded(BSTR* p);
    HRESULT put_ariaHaspopup(BSTR v);
    HRESULT get_ariaHaspopup(BSTR* p);
    HRESULT put_ariaHidden(BSTR v);
    HRESULT get_ariaHidden(BSTR* p);
    HRESULT put_ariaInvalid(BSTR v);
    HRESULT get_ariaInvalid(BSTR* p);
    HRESULT put_ariaMultiselectable(BSTR v);
    HRESULT get_ariaMultiselectable(BSTR* p);
    HRESULT put_ariaPressed(BSTR v);
    HRESULT get_ariaPressed(BSTR* p);
    HRESULT put_ariaReadonly(BSTR v);
    HRESULT get_ariaReadonly(BSTR* p);
    HRESULT put_ariaRequired(BSTR v);
    HRESULT get_ariaRequired(BSTR* p);
    HRESULT put_ariaSecret(BSTR v);
    HRESULT get_ariaSecret(BSTR* p);
    HRESULT put_ariaSelected(BSTR v);
    HRESULT get_ariaSelected(BSTR* p);
    HRESULT getAttribute(BSTR strAttributeName, VARIANT* AttributeValue);
    HRESULT setAttribute(BSTR strAttributeName, VARIANT AttributeValue);
    HRESULT removeAttribute(BSTR strAttributeName, short* pfSuccess);
    HRESULT get_attributes(IHTMLAttributeCollection3* p);
    HRESULT put_ariaValuenow(BSTR v);
    HRESULT get_ariaValuenow(BSTR* p);
    HRESULT put_ariaPosinset(short v);
    HRESULT get_ariaPosinset(short* p);
    HRESULT put_ariaSetsize(short v);
    HRESULT get_ariaSetsize(short* p);
    HRESULT put_ariaLevel(short v);
    HRESULT get_ariaLevel(short* p);
    HRESULT put_ariaValuemin(BSTR v);
    HRESULT get_ariaValuemin(BSTR* p);
    HRESULT put_ariaValuemax(BSTR v);
    HRESULT get_ariaValuemax(BSTR* p);
    HRESULT put_ariaControls(BSTR v);
    HRESULT get_ariaControls(BSTR* p);
    HRESULT put_ariaDescribedby(BSTR v);
    HRESULT get_ariaDescribedby(BSTR* p);
    HRESULT put_ariaFlowto(BSTR v);
    HRESULT get_ariaFlowto(BSTR* p);
    HRESULT put_ariaLabelledby(BSTR v);
    HRESULT get_ariaLabelledby(BSTR* p);
    HRESULT put_ariaActivedescendant(BSTR v);
    HRESULT get_ariaActivedescendant(BSTR* p);
    HRESULT put_ariaOwns(BSTR v);
    HRESULT get_ariaOwns(BSTR* p);
    HRESULT hasAttributes(short* pfHasAttributes);
    HRESULT put_ariaLive(BSTR v);
    HRESULT get_ariaLive(BSTR* p);
    HRESULT put_ariaRelevant(BSTR v);
    HRESULT get_ariaRelevant(BSTR* p);
}

@GUID("305106F8-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLElement6 : IDispatch
{
    HRESULT getAttributeNS(VARIANT* pvarNS, BSTR strAttributeName, VARIANT* AttributeValue);
    HRESULT setAttributeNS(VARIANT* pvarNS, BSTR strAttributeName, VARIANT* pvarAttributeValue);
    HRESULT removeAttributeNS(VARIANT* pvarNS, BSTR strAttributeName);
    HRESULT getAttributeNodeNS(VARIANT* pvarNS, BSTR bstrname, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT setAttributeNodeNS(IHTMLDOMAttribute2 pattr, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT hasAttributeNS(VARIANT* pvarNS, BSTR name, short* pfHasAttribute);
    HRESULT getAttribute(BSTR strAttributeName, VARIANT* AttributeValue);
    HRESULT setAttribute(BSTR strAttributeName, VARIANT* pvarAttributeValue);
    HRESULT removeAttribute(BSTR strAttributeName);
    HRESULT getAttributeNode(BSTR strAttributeName, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT setAttributeNode(IHTMLDOMAttribute2 pattr, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT removeAttributeNode(IHTMLDOMAttribute2 pattr, IHTMLDOMAttribute2* ppretAttribute);
    HRESULT hasAttribute(BSTR name, short* pfHasAttribute);
    HRESULT getElementsByTagNameNS(VARIANT* varNS, BSTR bstrLocalName, IHTMLElementCollection* pelColl);
    HRESULT get_tagName(BSTR* p);
    HRESULT get_nodeName(BSTR* p);
    HRESULT getElementsByClassName(BSTR v, IHTMLElementCollection* pel);
    HRESULT msMatchesSelector(BSTR v, short* pfMatches);
    HRESULT put_onabort(VARIANT v);
    HRESULT get_onabort(VARIANT* p);
    HRESULT put_oncanplay(VARIANT v);
    HRESULT get_oncanplay(VARIANT* p);
    HRESULT put_oncanplaythrough(VARIANT v);
    HRESULT get_oncanplaythrough(VARIANT* p);
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_ondurationchange(VARIANT v);
    HRESULT get_ondurationchange(VARIANT* p);
    HRESULT put_onemptied(VARIANT v);
    HRESULT get_onemptied(VARIANT* p);
    HRESULT put_onended(VARIANT v);
    HRESULT get_onended(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_oninput(VARIANT v);
    HRESULT get_oninput(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onloadeddata(VARIANT v);
    HRESULT get_onloadeddata(VARIANT* p);
    HRESULT put_onloadedmetadata(VARIANT v);
    HRESULT get_onloadedmetadata(VARIANT* p);
    HRESULT put_onloadstart(VARIANT v);
    HRESULT get_onloadstart(VARIANT* p);
    HRESULT put_onpause(VARIANT v);
    HRESULT get_onpause(VARIANT* p);
    HRESULT put_onplay(VARIANT v);
    HRESULT get_onplay(VARIANT* p);
    HRESULT put_onplaying(VARIANT v);
    HRESULT get_onplaying(VARIANT* p);
    HRESULT put_onprogress(VARIANT v);
    HRESULT get_onprogress(VARIANT* p);
    HRESULT put_onratechange(VARIANT v);
    HRESULT get_onratechange(VARIANT* p);
    HRESULT put_onreset(VARIANT v);
    HRESULT get_onreset(VARIANT* p);
    HRESULT put_onseeked(VARIANT v);
    HRESULT get_onseeked(VARIANT* p);
    HRESULT put_onseeking(VARIANT v);
    HRESULT get_onseeking(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_onstalled(VARIANT v);
    HRESULT get_onstalled(VARIANT* p);
    HRESULT put_onsubmit(VARIANT v);
    HRESULT get_onsubmit(VARIANT* p);
    HRESULT put_onsuspend(VARIANT v);
    HRESULT get_onsuspend(VARIANT* p);
    HRESULT put_ontimeupdate(VARIANT v);
    HRESULT get_ontimeupdate(VARIANT* p);
    HRESULT put_onvolumechange(VARIANT v);
    HRESULT get_onvolumechange(VARIANT* p);
    HRESULT put_onwaiting(VARIANT v);
    HRESULT get_onwaiting(VARIANT* p);
    HRESULT hasAttributes(short* pfHasAttributes);
}

@GUID("305107AA-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLElement7 : IDispatch
{
    HRESULT put_onmspointerdown(VARIANT v);
    HRESULT get_onmspointerdown(VARIANT* p);
    HRESULT put_onmspointermove(VARIANT v);
    HRESULT get_onmspointermove(VARIANT* p);
    HRESULT put_onmspointerup(VARIANT v);
    HRESULT get_onmspointerup(VARIANT* p);
    HRESULT put_onmspointerover(VARIANT v);
    HRESULT get_onmspointerover(VARIANT* p);
    HRESULT put_onmspointerout(VARIANT v);
    HRESULT get_onmspointerout(VARIANT* p);
    HRESULT put_onmspointercancel(VARIANT v);
    HRESULT get_onmspointercancel(VARIANT* p);
    HRESULT put_onmspointerhover(VARIANT v);
    HRESULT get_onmspointerhover(VARIANT* p);
    HRESULT put_onmslostpointercapture(VARIANT v);
    HRESULT get_onmslostpointercapture(VARIANT* p);
    HRESULT put_onmsgotpointercapture(VARIANT v);
    HRESULT get_onmsgotpointercapture(VARIANT* p);
    HRESULT put_onmsgesturestart(VARIANT v);
    HRESULT get_onmsgesturestart(VARIANT* p);
    HRESULT put_onmsgesturechange(VARIANT v);
    HRESULT get_onmsgesturechange(VARIANT* p);
    HRESULT put_onmsgestureend(VARIANT v);
    HRESULT get_onmsgestureend(VARIANT* p);
    HRESULT put_onmsgesturehold(VARIANT v);
    HRESULT get_onmsgesturehold(VARIANT* p);
    HRESULT put_onmsgesturetap(VARIANT v);
    HRESULT get_onmsgesturetap(VARIANT* p);
    HRESULT put_onmsgesturedoubletap(VARIANT v);
    HRESULT get_onmsgesturedoubletap(VARIANT* p);
    HRESULT put_onmsinertiastart(VARIANT v);
    HRESULT get_onmsinertiastart(VARIANT* p);
    HRESULT msSetPointerCapture(int pointerId);
    HRESULT msReleasePointerCapture(int pointerId);
    HRESULT put_onmstransitionstart(VARIANT v);
    HRESULT get_onmstransitionstart(VARIANT* p);
    HRESULT put_onmstransitionend(VARIANT v);
    HRESULT get_onmstransitionend(VARIANT* p);
    HRESULT put_onmsanimationstart(VARIANT v);
    HRESULT get_onmsanimationstart(VARIANT* p);
    HRESULT put_onmsanimationend(VARIANT v);
    HRESULT get_onmsanimationend(VARIANT* p);
    HRESULT put_onmsanimationiteration(VARIANT v);
    HRESULT get_onmsanimationiteration(VARIANT* p);
    HRESULT put_oninvalid(VARIANT v);
    HRESULT get_oninvalid(VARIANT* p);
    HRESULT put_xmsAcceleratorKey(BSTR v);
    HRESULT get_xmsAcceleratorKey(BSTR* p);
    HRESULT put_spellcheck(VARIANT v);
    HRESULT get_spellcheck(VARIANT* p);
    HRESULT put_onmsmanipulationstatechanged(VARIANT v);
    HRESULT get_onmsmanipulationstatechanged(VARIANT* p);
    HRESULT put_oncuechange(VARIANT v);
    HRESULT get_oncuechange(VARIANT* p);
}

@GUID("305104BD-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLElementAppliedStyles : IDispatch
{
    HRESULT msGetRulesApplied(IRulesAppliedCollection* ppRulesAppliedCollection);
    HRESULT msGetRulesAppliedWithAncestor(VARIANT varContext, IRulesAppliedCollection* ppRulesAppliedCollection);
}

@GUID("30510736-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementTraversal : IDispatch
{
    HRESULT get_firstElementChild(IHTMLElement* p);
    HRESULT get_lastElementChild(IHTMLElement* p);
    HRESULT get_previousElementSibling(IHTMLElement* p);
    HRESULT get_nextElementSibling(IHTMLElement* p);
    HRESULT get_childElementCount(int* p);
}

@GUID("3050F3F2-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDatabinding : IDispatch
{
    HRESULT put_dataFld(BSTR v);
    HRESULT get_dataFld(BSTR* p);
    HRESULT put_dataSrc(BSTR v);
    HRESULT get_dataSrc(BSTR* p);
    HRESULT put_dataFormatAs(BSTR v);
    HRESULT get_dataFormatAs(BSTR* p);
}

@GUID("626FC520-A41E-11CF-A731-00A0C9082637")
interface IHTMLDocument : IDispatch
{
    HRESULT get_Script(IDispatch* p);
}

@GUID("3050F6C9-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLElementDefaults : IDispatch
{
    HRESULT get_style(IHTMLStyle* p);
    HRESULT put_tabStop(short v);
    HRESULT get_tabStop(short* p);
    HRESULT put_viewInheritStyle(short v);
    HRESULT get_viewInheritStyle(short* p);
    HRESULT put_viewMasterTab(short v);
    HRESULT get_viewMasterTab(short* p);
    HRESULT put_scrollSegmentX(int v);
    HRESULT get_scrollSegmentX(int* p);
    HRESULT put_scrollSegmentY(int v);
    HRESULT get_scrollSegmentY(int* p);
    HRESULT put_isMultiLine(short v);
    HRESULT get_isMultiLine(short* p);
    HRESULT put_contentEditable(BSTR v);
    HRESULT get_contentEditable(BSTR* p);
    HRESULT put_canHaveHTML(short v);
    HRESULT get_canHaveHTML(short* p);
    HRESULT putref_viewLink(IHTMLDocument v);
    HRESULT get_viewLink(IHTMLDocument* p);
    HRESULT put_frozen(short v);
    HRESULT get_frozen(short* p);
}

@GUID("3050F58C-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLDefaults : IDispatch
{
}

@GUID("3050F4FD-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTCDefaultDispatch : IDispatch
{
    HRESULT get_element(IHTMLElement* p);
    HRESULT createEventObject(IHTMLEventObj* eventObj);
    HRESULT get_defaults(IDispatch* p);
    HRESULT get_document(IDispatch* p);
}

@GUID("3050F5DF-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTCPropertyBehavior : IDispatch
{
    HRESULT fireChange();
    HRESULT put_value(VARIANT v);
    HRESULT get_value(VARIANT* p);
}

@GUID("3050F631-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTCMethodBehavior : IDispatch
{
}

@GUID("3050F4FF-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTCEventBehavior : IDispatch
{
    HRESULT fire(IHTMLEventObj pvar);
}

@GUID("3050F5F4-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTCAttachBehavior : IDispatch
{
    HRESULT fireEvent(IDispatch evt);
    HRESULT detachEvent();
}

@GUID("3050F7EB-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTCAttachBehavior2 : IDispatch
{
    HRESULT fireEvent(VARIANT evt);
}

@GUID("3050F5DC-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTCDescBehavior : IDispatch
{
    HRESULT get_urn(BSTR* p);
    HRESULT get_name(BSTR* p);
}

@GUID("3050F573-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTCDefaultDispatch : IDispatch
{
}

@GUID("3050F57F-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTCPropertyBehavior : IDispatch
{
}

@GUID("3050F587-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTCMethodBehavior : IDispatch
{
}

@GUID("3050F574-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTCEventBehavior : IDispatch
{
}

@GUID("3050F583-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTCAttachBehavior : IDispatch
{
}

@GUID("3050F57E-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTCDescBehavior : IDispatch
{
}

@GUID("3050F5E2-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLUrnCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, BSTR* ppUrn);
}

@GUID("3050F551-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLUrnCollection : IDispatch
{
}

@GUID("3050F4B7-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLGenericElement : IDispatch
{
    HRESULT get_recordset(IDispatch* p);
    HRESULT namedRecordset(BSTR dataMember, VARIANT* hierarchy, IDispatch* ppRecordset);
}

@GUID("3050F563-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLGenericElement : IDispatch
{
}

@GUID("305104C1-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleSheetRuleApplied : IDispatch
{
    HRESULT get_msSpecificity(int* p);
    HRESULT msGetSpecificity(int index, int* p);
}

@GUID("305106FD-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleSheetRule2 : IDispatch
{
    HRESULT put_selectorText(BSTR v);
    HRESULT get_selectorText(BSTR* p);
}

@GUID("305106E8-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleSheetRulesCollection2 : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, IHTMLCSSRule* ppHTMLCSSRule);
}

@GUID("3050F50E-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLStyleSheetRule : IDispatch
{
}

@GUID("3050F52F-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLStyleSheetRulesCollection : IDispatch
{
}

@GUID("3050F7EE-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleSheetPage : IDispatch
{
    HRESULT get_selector(BSTR* p);
    HRESULT get_pseudoClass(BSTR* p);
}

@GUID("305106ED-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleSheetPage2 : IDispatch
{
    HRESULT put_selectorText(BSTR v);
    HRESULT get_selectorText(BSTR* p);
    HRESULT get_style(IHTMLRuleStyle* p);
}

@GUID("3050F7F0-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleSheetPagesCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, IHTMLStyleSheetPage* ppHTMLStyleSheetPage);
}

@GUID("3050F540-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLStyleSheetPage : IDispatch
{
}

@GUID("3050F543-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLStyleSheetPagesCollection : IDispatch
{
}

@GUID("3050F37E-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleSheetsCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT* pvarIndex, VARIANT* pvarResult);
}

@GUID("3050F3D1-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleSheet2 : IDispatch
{
    HRESULT get_pages(IHTMLStyleSheetPagesCollection* p);
    HRESULT addPageRule(BSTR bstrSelector, BSTR bstrStyle, int lIndex, int* plNewIndex);
}

@GUID("30510496-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleSheet3 : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT get_isAlternate(short* p);
    HRESULT get_isPrefAlternate(short* p);
}

@GUID("305106F4-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleSheet4 : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT get_href(VARIANT* p);
    HRESULT get_title(BSTR* p);
    HRESULT get_ownerNode(IHTMLElement* p);
    HRESULT get_ownerRule(IHTMLCSSRule* p);
    HRESULT get_cssRules(IHTMLStyleSheetRulesCollection* p);
    HRESULT get_media(VARIANT* p);
    HRESULT insertRule(BSTR bstrRule, int lIndex, int* plNewIndex);
    HRESULT deleteRule(int lIndex);
}

@GUID("3050F58D-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLStyleSheet : IDispatch
{
}

@GUID("305106E7-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleSheetsCollection2 : IDispatch
{
    HRESULT item(int index, VARIANT* pvarResult);
}

@GUID("3050F547-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLStyleSheetsCollection : IDispatch
{
}

@GUID("3050F61D-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLLinkElementEvents2 : IDispatch
{
}

@GUID("3050F3CC-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLLinkElementEvents : IDispatch
{
}

@GUID("3050F205-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLLinkElement : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT put_rel(BSTR v);
    HRESULT get_rel(BSTR* p);
    HRESULT put_rev(BSTR v);
    HRESULT get_rev(BSTR* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT get_styleSheet(IHTMLStyleSheet* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT put_media(BSTR v);
    HRESULT get_media(BSTR* p);
}

@GUID("3050F4E5-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLLinkElement2 : IDispatch
{
    HRESULT put_target(BSTR v);
    HRESULT get_target(BSTR* p);
}

@GUID("3050F81E-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLLinkElement3 : IDispatch
{
    HRESULT put_charset(BSTR v);
    HRESULT get_charset(BSTR* p);
    HRESULT put_hreflang(BSTR v);
    HRESULT get_hreflang(BSTR* p);
}

@GUID("3051043A-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLLinkElement4 : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
}

@GUID("30510726-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLLinkElement5 : IDispatch
{
    HRESULT get_sheet(IHTMLStyleSheet* p);
}

@GUID("3050F524-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLLinkElement : IDispatch
{
}

@GUID("3050F220-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTxtRange : IDispatch
{
    HRESULT get_htmlText(BSTR* p);
    HRESULT put_text(BSTR v);
    HRESULT get_text(BSTR* p);
    HRESULT parentElement(IHTMLElement* parent);
    HRESULT duplicate(IHTMLTxtRange* Duplicate);
    HRESULT inRange(IHTMLTxtRange Range, short* InRange);
    HRESULT isEqual(IHTMLTxtRange Range, short* IsEqual);
    HRESULT scrollIntoView(short fStart);
    HRESULT collapse(short Start);
    HRESULT expand(BSTR Unit, short* Success);
    HRESULT move(BSTR Unit, int Count, int* ActualCount);
    HRESULT moveStart(BSTR Unit, int Count, int* ActualCount);
    HRESULT moveEnd(BSTR Unit, int Count, int* ActualCount);
    HRESULT select();
    HRESULT pasteHTML(BSTR html);
    HRESULT moveToElementText(IHTMLElement element);
    HRESULT setEndPoint(BSTR how, IHTMLTxtRange SourceRange);
    HRESULT compareEndPoints(BSTR how, IHTMLTxtRange SourceRange, int* ret);
    HRESULT findText(BSTR String, int count, int Flags, short* Success);
    HRESULT moveToPoint(int x, int y);
    HRESULT getBookmark(BSTR* Boolmark);
    HRESULT moveToBookmark(BSTR Bookmark, short* Success);
    HRESULT queryCommandSupported(BSTR cmdID, short* pfRet);
    HRESULT queryCommandEnabled(BSTR cmdID, short* pfRet);
    HRESULT queryCommandState(BSTR cmdID, short* pfRet);
    HRESULT queryCommandIndeterm(BSTR cmdID, short* pfRet);
    HRESULT queryCommandText(BSTR cmdID, BSTR* pcmdText);
    HRESULT queryCommandValue(BSTR cmdID, VARIANT* pcmdValue);
    HRESULT execCommand(BSTR cmdID, short showUI, VARIANT value, short* pfRet);
    HRESULT execCommandShowHelp(BSTR cmdID, short* pfRet);
}

@GUID("3050F40B-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTextRangeMetrics : IDispatch
{
    HRESULT get_offsetTop(int* p);
    HRESULT get_offsetLeft(int* p);
    HRESULT get_boundingTop(int* p);
    HRESULT get_boundingLeft(int* p);
    HRESULT get_boundingWidth(int* p);
    HRESULT get_boundingHeight(int* p);
}

@GUID("3050F4A6-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTextRangeMetrics2 : IDispatch
{
    HRESULT getClientRects(IHTMLRectCollection* pRectCol);
    HRESULT getBoundingClientRect(IHTMLRect* pRect);
}

@GUID("3050F7ED-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTxtRangeCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT* pvarIndex, VARIANT* pvarResult);
}

@GUID("305104AE-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDOMRange : IDispatch
{
    HRESULT get_startContainer(IHTMLDOMNode* p);
    HRESULT get_startOffset(int* p);
    HRESULT get_endContainer(IHTMLDOMNode* p);
    HRESULT get_endOffset(int* p);
    HRESULT get_collapsed(short* p);
    HRESULT get_commonAncestorContainer(IHTMLDOMNode* p);
    HRESULT setStart(IDispatch refNode, int offset);
    HRESULT setEnd(IDispatch refNode, int offset);
    HRESULT setStartBefore(IDispatch refNode);
    HRESULT setStartAfter(IDispatch refNode);
    HRESULT setEndBefore(IDispatch refNode);
    HRESULT setEndAfter(IDispatch refNode);
    HRESULT collapse(short toStart);
    HRESULT selectNode(IDispatch refNode);
    HRESULT selectNodeContents(IDispatch refNode);
    HRESULT compareBoundaryPoints(short how, IDispatch sourceRange, int* compareResult);
    HRESULT deleteContents();
    HRESULT extractContents(IDispatch* ppDocumentFragment);
    HRESULT cloneContents(IDispatch* ppDocumentFragment);
    HRESULT insertNode(IDispatch newNode);
    HRESULT surroundContents(IDispatch newParent);
    HRESULT cloneRange(IHTMLDOMRange* ppClonedRange);
    HRESULT toString(BSTR* pRangeString);
    HRESULT detach();
    HRESULT getClientRects(IHTMLRectCollection* ppRectCol);
    HRESULT getBoundingClientRect(IHTMLRect* ppRect);
}

@GUID("3050F5A3-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLDOMRange : IDispatch
{
}

@GUID("3050F614-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLFormElementEvents2 : IDispatch
{
}

@GUID("3050F364-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLFormElementEvents : IDispatch
{
}

@GUID("3050F1F7-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLFormElement : IDispatch
{
    HRESULT put_action(BSTR v);
    HRESULT get_action(BSTR* p);
    HRESULT put_dir(BSTR v);
    HRESULT get_dir(BSTR* p);
    HRESULT put_encoding(BSTR v);
    HRESULT get_encoding(BSTR* p);
    HRESULT put_method(BSTR v);
    HRESULT get_method(BSTR* p);
    HRESULT get_elements(IDispatch* p);
    HRESULT put_target(BSTR v);
    HRESULT get_target(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_onsubmit(VARIANT v);
    HRESULT get_onsubmit(VARIANT* p);
    HRESULT put_onreset(VARIANT v);
    HRESULT get_onreset(VARIANT* p);
    HRESULT submit();
    HRESULT reset();
    HRESULT put_length(int v);
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT name, VARIANT index, IDispatch* pdisp);
    HRESULT tags(VARIANT tagName, IDispatch* pdisp);
}

@GUID("3050F4F6-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLFormElement2 : IDispatch
{
    HRESULT put_acceptCharset(BSTR v);
    HRESULT get_acceptCharset(BSTR* p);
    HRESULT urns(VARIANT urn, IDispatch* pdisp);
}

@GUID("3050F836-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLFormElement3 : IDispatch
{
    HRESULT namedItem(BSTR name, IDispatch* pdisp);
}

@GUID("3050F645-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLSubmitData : IDispatch
{
    HRESULT appendNameValuePair(BSTR name, BSTR value);
    HRESULT appendNameFilePair(BSTR name, BSTR filename);
    HRESULT appendItemSeparator();
}

@GUID("3051042C-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLFormElement4 : IDispatch
{
    HRESULT put_action(BSTR v);
    HRESULT get_action(BSTR* p);
}

@GUID("3050F510-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLFormElement : IDispatch
{
}

@GUID("3050F612-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLControlElementEvents2 : IDispatch
{
}

@GUID("3050F4EA-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLControlElementEvents : IDispatch
{
}

@GUID("3050F4E9-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLControlElement : IDispatch
{
    HRESULT put_tabIndex(short v);
    HRESULT get_tabIndex(short* p);
    HRESULT focus();
    HRESULT put_accessKey(BSTR v);
    HRESULT get_accessKey(BSTR* p);
    HRESULT put_onblur(VARIANT v);
    HRESULT get_onblur(VARIANT* p);
    HRESULT put_onfocus(VARIANT v);
    HRESULT get_onfocus(VARIANT* p);
    HRESULT put_onresize(VARIANT v);
    HRESULT get_onresize(VARIANT* p);
    HRESULT blur();
    HRESULT addFilter(IUnknown pUnk);
    HRESULT removeFilter(IUnknown pUnk);
    HRESULT get_clientHeight(int* p);
    HRESULT get_clientWidth(int* p);
    HRESULT get_clientTop(int* p);
    HRESULT get_clientLeft(int* p);
}

@GUID("3050F218-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTextElement : IDispatch
{
}

@GUID("3050F537-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLTextElement : IDispatch
{
}

@GUID("3050F624-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLTextContainerEvents2 : IDispatch
{
}

@GUID("1FF6AA72-5842-11CF-A707-00AA00C0098D")
interface HTMLTextContainerEvents : IDispatch
{
}

@GUID("3050F230-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTextContainer : IDispatch
{
    HRESULT createControlRange(IDispatch* range);
    HRESULT get_scrollHeight(int* p);
    HRESULT get_scrollWidth(int* p);
    HRESULT put_scrollTop(int v);
    HRESULT get_scrollTop(int* p);
    HRESULT put_scrollLeft(int v);
    HRESULT get_scrollLeft(int* p);
    HRESULT put_onscroll(VARIANT v);
    HRESULT get_onscroll(VARIANT* p);
}

@GUID("3050F29C-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLControlRange : IDispatch
{
    HRESULT select();
    HRESULT add(IHTMLControlElement item);
    HRESULT remove(int index);
    HRESULT item(int index, IHTMLElement* pdisp);
    HRESULT scrollIntoView(VARIANT varargStart);
    HRESULT queryCommandSupported(BSTR cmdID, short* pfRet);
    HRESULT queryCommandEnabled(BSTR cmdID, short* pfRet);
    HRESULT queryCommandState(BSTR cmdID, short* pfRet);
    HRESULT queryCommandIndeterm(BSTR cmdID, short* pfRet);
    HRESULT queryCommandText(BSTR cmdID, BSTR* pcmdText);
    HRESULT queryCommandValue(BSTR cmdID, VARIANT* pcmdValue);
    HRESULT execCommand(BSTR cmdID, short showUI, VARIANT value, short* pfRet);
    HRESULT execCommandShowHelp(BSTR cmdID, short* pfRet);
    HRESULT commonParentElement(IHTMLElement* parent);
    HRESULT get_length(int* p);
}

@GUID("3050F65E-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLControlRange2 : IDispatch
{
    HRESULT addElement(IHTMLElement item);
}

@GUID("3050F616-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLImgEvents2 : IDispatch
{
}

@GUID("3050F25B-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLImgEvents : IDispatch
{
}

@GUID("3050F240-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLImgElement : IDispatch
{
    HRESULT put_isMap(short v);
    HRESULT get_isMap(short* p);
    HRESULT put_useMap(BSTR v);
    HRESULT get_useMap(BSTR* p);
    HRESULT get_mimeType(BSTR* p);
    HRESULT get_fileSize(BSTR* p);
    HRESULT get_fileCreatedDate(BSTR* p);
    HRESULT get_fileModifiedDate(BSTR* p);
    HRESULT get_fileUpdatedDate(BSTR* p);
    HRESULT get_protocol(BSTR* p);
    HRESULT get_href(BSTR* p);
    HRESULT get_nameProp(BSTR* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_vspace(int v);
    HRESULT get_vspace(int* p);
    HRESULT put_hspace(int v);
    HRESULT get_hspace(int* p);
    HRESULT put_alt(BSTR v);
    HRESULT get_alt(BSTR* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_lowsrc(BSTR v);
    HRESULT get_lowsrc(BSTR* p);
    HRESULT put_vrml(BSTR v);
    HRESULT get_vrml(BSTR* p);
    HRESULT put_dynsrc(BSTR v);
    HRESULT get_dynsrc(BSTR* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT get_complete(short* p);
    HRESULT put_loop(VARIANT v);
    HRESULT get_loop(VARIANT* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_onabort(VARIANT v);
    HRESULT get_onabort(VARIANT* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_width(int v);
    HRESULT get_width(int* p);
    HRESULT put_height(int v);
    HRESULT get_height(int* p);
    HRESULT put_start(BSTR v);
    HRESULT get_start(BSTR* p);
}

@GUID("3050F826-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLImgElement2 : IDispatch
{
    HRESULT put_longDesc(BSTR v);
    HRESULT get_longDesc(BSTR* p);
}

@GUID("30510434-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLImgElement3 : IDispatch
{
    HRESULT put_longDesc(BSTR v);
    HRESULT get_longDesc(BSTR* p);
    HRESULT put_vrml(BSTR v);
    HRESULT get_vrml(BSTR* p);
    HRESULT put_lowsrc(BSTR v);
    HRESULT get_lowsrc(BSTR* p);
    HRESULT put_dynsrc(BSTR v);
    HRESULT get_dynsrc(BSTR* p);
}

@GUID("305107F6-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLImgElement4 : IDispatch
{
    HRESULT get_naturalWidth(int* p);
    HRESULT get_naturalHeight(int* p);
}

@GUID("30510793-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLMSImgElement : IDispatch
{
    HRESULT put_msPlayToDisabled(short v);
    HRESULT get_msPlayToDisabled(short* p);
    HRESULT put_msPlayToPrimary(short v);
    HRESULT get_msPlayToPrimary(short* p);
}

@GUID("3050F38E-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLImageElementFactory : IDispatch
{
    HRESULT create(VARIANT width, VARIANT height, IHTMLImgElement* __MIDL__IHTMLImageElementFactory0000);
}

@GUID("3050F51C-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLImg : IDispatch
{
}

@GUID("3050F1D8-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLBodyElement : IDispatch
{
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_bgProperties(BSTR v);
    HRESULT get_bgProperties(BSTR* p);
    HRESULT put_leftMargin(VARIANT v);
    HRESULT get_leftMargin(VARIANT* p);
    HRESULT put_topMargin(VARIANT v);
    HRESULT get_topMargin(VARIANT* p);
    HRESULT put_rightMargin(VARIANT v);
    HRESULT get_rightMargin(VARIANT* p);
    HRESULT put_bottomMargin(VARIANT v);
    HRESULT get_bottomMargin(VARIANT* p);
    HRESULT put_noWrap(short v);
    HRESULT get_noWrap(short* p);
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT put_text(VARIANT v);
    HRESULT get_text(VARIANT* p);
    HRESULT put_link(VARIANT v);
    HRESULT get_link(VARIANT* p);
    HRESULT put_vLink(VARIANT v);
    HRESULT get_vLink(VARIANT* p);
    HRESULT put_aLink(VARIANT v);
    HRESULT get_aLink(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onunload(VARIANT v);
    HRESULT get_onunload(VARIANT* p);
    HRESULT put_scroll(BSTR v);
    HRESULT get_scroll(BSTR* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_onbeforeunload(VARIANT v);
    HRESULT get_onbeforeunload(VARIANT* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
}

@GUID("3050F5C5-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLBodyElement2 : IDispatch
{
    HRESULT put_onbeforeprint(VARIANT v);
    HRESULT get_onbeforeprint(VARIANT* p);
    HRESULT put_onafterprint(VARIANT v);
    HRESULT get_onafterprint(VARIANT* p);
}

@GUID("30510422-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLBodyElement3 : IDispatch
{
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_ononline(VARIANT v);
    HRESULT get_ononline(VARIANT* p);
    HRESULT put_onoffline(VARIANT v);
    HRESULT get_onoffline(VARIANT* p);
    HRESULT put_onhashchange(VARIANT v);
    HRESULT get_onhashchange(VARIANT* p);
}

@GUID("30510795-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLBodyElement4 : IDispatch
{
    HRESULT put_onmessage(VARIANT v);
    HRESULT get_onmessage(VARIANT* p);
    HRESULT put_onstorage(VARIANT v);
    HRESULT get_onstorage(VARIANT* p);
}

@GUID("30510822-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLBodyElement5 : IDispatch
{
    HRESULT put_onpopstate(VARIANT v);
    HRESULT get_onpopstate(VARIANT* p);
}

@GUID("3050F507-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLBody : IDispatch
{
}

@GUID("3050F1D9-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLFontElement : IDispatch
{
    HRESULT put_color(VARIANT v);
    HRESULT get_color(VARIANT* p);
    HRESULT put_face(BSTR v);
    HRESULT get_face(BSTR* p);
    HRESULT put_size(VARIANT v);
    HRESULT get_size(VARIANT* p);
}

@GUID("3050F512-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLFontElement : IDispatch
{
}

@GUID("3050F610-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLAnchorEvents2 : IDispatch
{
}

@GUID("3050F29D-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLAnchorEvents : IDispatch
{
}

@GUID("3050F1DA-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLAnchorElement : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT put_target(BSTR v);
    HRESULT get_target(BSTR* p);
    HRESULT put_rel(BSTR v);
    HRESULT get_rel(BSTR* p);
    HRESULT put_rev(BSTR v);
    HRESULT get_rev(BSTR* p);
    HRESULT put_urn(BSTR v);
    HRESULT get_urn(BSTR* p);
    HRESULT put_Methods(BSTR v);
    HRESULT get_Methods(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_host(BSTR v);
    HRESULT get_host(BSTR* p);
    HRESULT put_hostname(BSTR v);
    HRESULT get_hostname(BSTR* p);
    HRESULT put_pathname(BSTR v);
    HRESULT get_pathname(BSTR* p);
    HRESULT put_port(BSTR v);
    HRESULT get_port(BSTR* p);
    HRESULT put_protocol(BSTR v);
    HRESULT get_protocol(BSTR* p);
    HRESULT put_search(BSTR v);
    HRESULT get_search(BSTR* p);
    HRESULT put_hash(BSTR v);
    HRESULT get_hash(BSTR* p);
    HRESULT put_onblur(VARIANT v);
    HRESULT get_onblur(VARIANT* p);
    HRESULT put_onfocus(VARIANT v);
    HRESULT get_onfocus(VARIANT* p);
    HRESULT put_accessKey(BSTR v);
    HRESULT get_accessKey(BSTR* p);
    HRESULT get_protocolLong(BSTR* p);
    HRESULT get_mimeType(BSTR* p);
    HRESULT get_nameProp(BSTR* p);
    HRESULT put_tabIndex(short v);
    HRESULT get_tabIndex(short* p);
    HRESULT focus();
    HRESULT blur();
}

@GUID("3050F825-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLAnchorElement2 : IDispatch
{
    HRESULT put_charset(BSTR v);
    HRESULT get_charset(BSTR* p);
    HRESULT put_coords(BSTR v);
    HRESULT get_coords(BSTR* p);
    HRESULT put_hreflang(BSTR v);
    HRESULT get_hreflang(BSTR* p);
    HRESULT put_shape(BSTR v);
    HRESULT get_shape(BSTR* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
}

@GUID("3051041D-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLAnchorElement3 : IDispatch
{
    HRESULT put_shape(BSTR v);
    HRESULT get_shape(BSTR* p);
    HRESULT put_coords(BSTR v);
    HRESULT get_coords(BSTR* p);
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
}

@GUID("3050F502-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLAnchorElement : IDispatch
{
}

@GUID("3050F61C-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLLabelEvents2 : IDispatch
{
}

@GUID("3050F329-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLLabelEvents : IDispatch
{
}

@GUID("3050F32A-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLLabelElement : IDispatch
{
    HRESULT put_htmlFor(BSTR v);
    HRESULT get_htmlFor(BSTR* p);
    HRESULT put_accessKey(BSTR v);
    HRESULT get_accessKey(BSTR* p);
}

@GUID("3050F832-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLLabelElement2 : IDispatch
{
    HRESULT get_form(IHTMLFormElement* p);
}

@GUID("3050F522-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLLabelElement : IDispatch
{
}

@GUID("3050F20E-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLListElement : IDispatch
{
}

@GUID("3050F822-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLListElement2 : IDispatch
{
    HRESULT put_compact(short v);
    HRESULT get_compact(short* p);
}

@GUID("3050F525-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLListElement : IDispatch
{
}

@GUID("3050F1DD-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLUListElement : IDispatch
{
    HRESULT put_compact(short v);
    HRESULT get_compact(short* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
}

@GUID("3050F538-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLUListElement : IDispatch
{
}

@GUID("3050F1DE-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLOListElement : IDispatch
{
    HRESULT put_compact(short v);
    HRESULT get_compact(short* p);
    HRESULT put_start(int v);
    HRESULT get_start(int* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
}

@GUID("3050F52A-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLOListElement : IDispatch
{
}

@GUID("3050F1E0-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLLIElement : IDispatch
{
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_value(int v);
    HRESULT get_value(int* p);
}

@GUID("3050F523-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLLIElement : IDispatch
{
}

@GUID("3050F208-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLBlockElement : IDispatch
{
    HRESULT put_clear(BSTR v);
    HRESULT get_clear(BSTR* p);
}

@GUID("3050F823-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLBlockElement2 : IDispatch
{
    HRESULT put_cite(BSTR v);
    HRESULT get_cite(BSTR* p);
    HRESULT put_width(BSTR v);
    HRESULT get_width(BSTR* p);
}

@GUID("30510494-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLBlockElement3 : IDispatch
{
    HRESULT put_cite(BSTR v);
    HRESULT get_cite(BSTR* p);
}

@GUID("3050F506-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLBlockElement : IDispatch
{
}

@GUID("3050F200-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDivElement : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_noWrap(short v);
    HRESULT get_noWrap(short* p);
}

@GUID("3050F50C-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLDivElement : IDispatch
{
}

@GUID("3050F1F2-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDDElement : IDispatch
{
    HRESULT put_noWrap(short v);
    HRESULT get_noWrap(short* p);
}

@GUID("3050F50B-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLDDElement : IDispatch
{
}

@GUID("3050F1F3-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDTElement : IDispatch
{
    HRESULT put_noWrap(short v);
    HRESULT get_noWrap(short* p);
}

@GUID("3050F50D-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLDTElement : IDispatch
{
}

@GUID("3050F1F0-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLBRElement : IDispatch
{
    HRESULT put_clear(BSTR v);
    HRESULT get_clear(BSTR* p);
}

@GUID("3050F53A-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLBRElement : IDispatch
{
}

@GUID("3050F1F1-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDListElement : IDispatch
{
    HRESULT put_compact(short v);
    HRESULT get_compact(short* p);
}

@GUID("3050F53B-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLDListElement : IDispatch
{
}

@GUID("3050F1F4-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLHRElement : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_color(VARIANT v);
    HRESULT get_color(VARIANT* p);
    HRESULT put_noShade(short v);
    HRESULT get_noShade(short* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_size(VARIANT v);
    HRESULT get_size(VARIANT* p);
}

@GUID("3050F53D-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLHRElement : IDispatch
{
}

@GUID("3050F1F5-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLParaElement : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

@GUID("3050F52C-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLParaElement : IDispatch
{
}

@GUID("3050F5EE-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLElementCollection2 : IDispatch
{
    HRESULT urns(VARIANT urn, IDispatch* pdisp);
}

@GUID("3050F835-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLElementCollection3 : IDispatch
{
    HRESULT namedItem(BSTR name, IDispatch* pdisp);
}

@GUID("30510425-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLElementCollection4 : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, IHTMLElement2* pNode);
    HRESULT namedItem(BSTR name, IHTMLElement2* pNode);
}

@GUID("3050F56B-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLElementCollection : IDispatch
{
}

@GUID("3050F1F6-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLHeaderElement : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

@GUID("3050F515-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLHeaderElement : IDispatch
{
}

@GUID("3050F622-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLSelectElementEvents2 : IDispatch
{
}

@GUID("3050F302-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLSelectElementEvents : IDispatch
{
}

@GUID("3050F211-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLOptionElement : IDispatch
{
    HRESULT put_selected(short v);
    HRESULT get_selected(short* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_defaultSelected(short v);
    HRESULT get_defaultSelected(short* p);
    HRESULT put_index(int v);
    HRESULT get_index(int* p);
    HRESULT put_text(BSTR v);
    HRESULT get_text(BSTR* p);
    HRESULT get_form(IHTMLFormElement* p);
}

@GUID("3050F2D1-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLSelectElementEx : IUnknown
{
    HRESULT ShowDropdown(BOOL fShow);
    HRESULT SetSelectExFlags(uint lFlags);
    HRESULT GetSelectExFlags(uint* pFlags);
    HRESULT GetDropdownOpen(int* pfOpen);
}

@GUID("3050F244-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLSelectElement : IDispatch
{
    HRESULT put_size(int v);
    HRESULT get_size(int* p);
    HRESULT put_multiple(short v);
    HRESULT get_multiple(short* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT get_options(IDispatch* p);
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_selectedIndex(int v);
    HRESULT get_selectedIndex(int* p);
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT add(IHTMLElement element, VARIANT before);
    HRESULT remove(int index);
    HRESULT put_length(int v);
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT name, VARIANT index, IDispatch* pdisp);
    HRESULT tags(VARIANT tagName, IDispatch* pdisp);
}

@GUID("3050F5ED-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLSelectElement2 : IDispatch
{
    HRESULT urns(VARIANT urn, IDispatch* pdisp);
}

@GUID("3050F838-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLSelectElement4 : IDispatch
{
    HRESULT namedItem(BSTR name, IDispatch* pdisp);
}

@GUID("3051049D-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLSelectElement5 : IDispatch
{
    HRESULT add(IHTMLOptionElement pElem, VARIANT* pvarBefore);
}

@GUID("30510760-98B6-11CF-BB82-00AA00BDCE0B")
interface IHTMLSelectElement6 : IDispatch
{
    HRESULT add(IHTMLOptionElement pElem, VARIANT* pvarBefore);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
}

@GUID("3050F531-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLSelectElement : IDispatch
{
}

@GUID("3050F597-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLWndSelectElement : IDispatch
{
}

@GUID("3050F25A-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLSelectionObject : IDispatch
{
    HRESULT createRange(IDispatch* range);
    HRESULT empty();
    HRESULT clear();
    HRESULT get_type(BSTR* p);
}

@GUID("3050F7EC-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLSelectionObject2 : IDispatch
{
    HRESULT createRangeCollection(IDispatch* rangeCollection);
    HRESULT get_typeDetail(BSTR* p);
}

@GUID("305104B6-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLSelection : IDispatch
{
    HRESULT get_anchorNode(IHTMLDOMNode* p);
    HRESULT get_anchorOffset(int* p);
    HRESULT get_focusNode(IHTMLDOMNode* p);
    HRESULT get_focusOffset(int* p);
    HRESULT get_isCollapsed(short* p);
    HRESULT collapse(IDispatch parentNode, int offfset);
    HRESULT collapseToStart();
    HRESULT collapseToEnd();
    HRESULT selectAllChildren(IDispatch parentNode);
    HRESULT deleteFromDocument();
    HRESULT get_rangeCount(int* p);
    HRESULT getRangeAt(int index, IHTMLDOMRange* ppRange);
    HRESULT addRange(IDispatch range);
    HRESULT removeRange(IDispatch range);
    HRESULT removeAllRanges();
    HRESULT toString(BSTR* pSelectionString);
}

@GUID("3050F820-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLOptionElement3 : IDispatch
{
    HRESULT put_label(BSTR v);
    HRESULT get_label(BSTR* p);
}

@GUID("305107B4-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLOptionElement4 : IDispatch
{
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
}

@GUID("3050F38C-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLOptionElementFactory : IDispatch
{
    HRESULT create(VARIANT text, VARIANT value, VARIANT defaultselected, VARIANT selected, 
                   IHTMLOptionElement* __MIDL__IHTMLOptionElementFactory0000);
}

@GUID("3050F52B-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLOptionElement : IDispatch
{
}

@GUID("3050F598-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLWndOptionElement : IDispatch
{
}

@GUID("3050F617-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLButtonElementEvents2 : IDispatch
{
}

@GUID("3050F2B3-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLButtonElementEvents : IDispatch
{
}

@GUID("3050F618-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLInputTextElementEvents2 : IDispatch
{
}

@GUID("3050F619-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLOptionButtonElementEvents2 : IDispatch
{
}

@GUID("3050F61A-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLInputFileElementEvents2 : IDispatch
{
}

@GUID("3050F61B-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLInputImageEvents2 : IDispatch
{
}

@GUID("3050F2A7-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLInputTextElementEvents : IDispatch
{
}

@GUID("3050F2BD-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLOptionButtonElementEvents : IDispatch
{
}

@GUID("3050F2AF-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLInputFileElementEvents : IDispatch
{
}

@GUID("3050F2C3-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLInputImageEvents : IDispatch
{
}

@GUID("3050F5D2-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLInputElement : IDispatch
{
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(short v);
    HRESULT get_status(short* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT put_size(int v);
    HRESULT get_size(int* p);
    HRESULT put_maxLength(int v);
    HRESULT get_maxLength(int* p);
    HRESULT select();
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_defaultValue(BSTR v);
    HRESULT get_defaultValue(BSTR* p);
    HRESULT put_readOnly(short v);
    HRESULT get_readOnly(short* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
    HRESULT put_indeterminate(short v);
    HRESULT get_indeterminate(short* p);
    HRESULT put_defaultChecked(short v);
    HRESULT get_defaultChecked(short* p);
    HRESULT put_checked(short v);
    HRESULT get_checked(short* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_vspace(int v);
    HRESULT get_vspace(int* p);
    HRESULT put_hspace(int v);
    HRESULT get_hspace(int* p);
    HRESULT put_alt(BSTR v);
    HRESULT get_alt(BSTR* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_lowsrc(BSTR v);
    HRESULT get_lowsrc(BSTR* p);
    HRESULT put_vrml(BSTR v);
    HRESULT get_vrml(BSTR* p);
    HRESULT put_dynsrc(BSTR v);
    HRESULT get_dynsrc(BSTR* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT get_complete(short* p);
    HRESULT put_loop(VARIANT v);
    HRESULT get_loop(VARIANT* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_onabort(VARIANT v);
    HRESULT get_onabort(VARIANT* p);
    HRESULT put_width(int v);
    HRESULT get_width(int* p);
    HRESULT put_height(int v);
    HRESULT get_height(int* p);
    HRESULT put_start(BSTR v);
    HRESULT get_start(BSTR* p);
}

@GUID("3050F821-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLInputElement2 : IDispatch
{
    HRESULT put_accept(BSTR v);
    HRESULT get_accept(BSTR* p);
    HRESULT put_useMap(BSTR v);
    HRESULT get_useMap(BSTR* p);
}

@GUID("30510435-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLInputElement3 : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_lowsrc(BSTR v);
    HRESULT get_lowsrc(BSTR* p);
    HRESULT put_vrml(BSTR v);
    HRESULT get_vrml(BSTR* p);
    HRESULT put_dynsrc(BSTR v);
    HRESULT get_dynsrc(BSTR* p);
}

@GUID("3050F2B2-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLInputButtonElement : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(VARIANT v);
    HRESULT get_status(VARIANT* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
}

@GUID("3050F2A4-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLInputHiddenElement : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(VARIANT v);
    HRESULT get_status(VARIANT* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
}

@GUID("3050F2A6-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLInputTextElement : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(VARIANT v);
    HRESULT get_status(VARIANT* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT put_defaultValue(BSTR v);
    HRESULT get_defaultValue(BSTR* p);
    HRESULT put_size(int v);
    HRESULT get_size(int* p);
    HRESULT put_maxLength(int v);
    HRESULT get_maxLength(int* p);
    HRESULT select();
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_readOnly(short v);
    HRESULT get_readOnly(short* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
}

@GUID("3050F2D2-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLInputTextElement2 : IDispatch
{
    HRESULT put_selectionStart(int v);
    HRESULT get_selectionStart(int* p);
    HRESULT put_selectionEnd(int v);
    HRESULT get_selectionEnd(int* p);
    HRESULT setSelectionRange(int start, int end);
}

@GUID("3050F2AD-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLInputFileElement : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(VARIANT v);
    HRESULT get_status(VARIANT* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT put_size(int v);
    HRESULT get_size(int* p);
    HRESULT put_maxLength(int v);
    HRESULT get_maxLength(int* p);
    HRESULT select();
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
}

@GUID("3050F2BC-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLOptionButtonElement : IDispatch
{
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT get_type(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_checked(short v);
    HRESULT get_checked(short* p);
    HRESULT put_defaultChecked(short v);
    HRESULT get_defaultChecked(short* p);
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT put_status(short v);
    HRESULT get_status(short* p);
    HRESULT put_indeterminate(short v);
    HRESULT get_indeterminate(short* p);
    HRESULT get_form(IHTMLFormElement* p);
}

@GUID("3050F2C2-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLInputImage : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_vspace(int v);
    HRESULT get_vspace(int* p);
    HRESULT put_hspace(int v);
    HRESULT get_hspace(int* p);
    HRESULT put_alt(BSTR v);
    HRESULT get_alt(BSTR* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_lowsrc(BSTR v);
    HRESULT get_lowsrc(BSTR* p);
    HRESULT put_vrml(BSTR v);
    HRESULT get_vrml(BSTR* p);
    HRESULT put_dynsrc(BSTR v);
    HRESULT get_dynsrc(BSTR* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT get_complete(short* p);
    HRESULT put_loop(VARIANT v);
    HRESULT get_loop(VARIANT* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_onabort(VARIANT v);
    HRESULT get_onabort(VARIANT* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_width(int v);
    HRESULT get_width(int* p);
    HRESULT put_height(int v);
    HRESULT get_height(int* p);
    HRESULT put_start(BSTR v);
    HRESULT get_start(BSTR* p);
}

@GUID("3050F2D4-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLInputRangeElement : IDispatch
{
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_type(BSTR* p);
    HRESULT put_alt(BSTR v);
    HRESULT get_alt(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_min(BSTR v);
    HRESULT get_min(BSTR* p);
    HRESULT put_max(BSTR v);
    HRESULT get_max(BSTR* p);
    HRESULT put_step(BSTR v);
    HRESULT get_step(BSTR* p);
    HRESULT put_valueAsNumber(double v);
    HRESULT get_valueAsNumber(double* p);
    HRESULT stepUp(int n);
    HRESULT stepDown(int n);
}

@GUID("3050F57D-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLInputElement : IDispatch
{
}

@GUID("3050F2AA-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTextAreaElement : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(VARIANT v);
    HRESULT get_status(VARIANT* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT put_defaultValue(BSTR v);
    HRESULT get_defaultValue(BSTR* p);
    HRESULT select();
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_readOnly(short v);
    HRESULT get_readOnly(short* p);
    HRESULT put_rows(int v);
    HRESULT get_rows(int* p);
    HRESULT put_cols(int v);
    HRESULT get_cols(int* p);
    HRESULT put_wrap(BSTR v);
    HRESULT get_wrap(BSTR* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
}

@GUID("3050F2D3-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTextAreaElement2 : IDispatch
{
    HRESULT put_selectionStart(int v);
    HRESULT get_selectionStart(int* p);
    HRESULT put_selectionEnd(int v);
    HRESULT get_selectionEnd(int* p);
    HRESULT setSelectionRange(int start, int end);
}

@GUID("3050F521-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLTextAreaElement : IDispatch
{
}

@GUID("3050F54D-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLRichtextElement : IDispatch
{
}

@GUID("3050F2BB-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLButtonElement : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_status(VARIANT v);
    HRESULT get_status(VARIANT* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT createTextRange(IHTMLTxtRange* range);
}

@GUID("305106F3-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLButtonElement2 : IDispatch
{
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
}

@GUID("3050F51F-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLButtonElement : IDispatch
{
}

@GUID("3050F61F-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLMarqueeElementEvents2 : IDispatch
{
}

@GUID("3050F2B8-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLMarqueeElementEvents : IDispatch
{
}

@GUID("3050F2B5-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLMarqueeElement : IDispatch
{
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT put_scrollDelay(int v);
    HRESULT get_scrollDelay(int* p);
    HRESULT put_direction(BSTR v);
    HRESULT get_direction(BSTR* p);
    HRESULT put_behavior(BSTR v);
    HRESULT get_behavior(BSTR* p);
    HRESULT put_scrollAmount(int v);
    HRESULT get_scrollAmount(int* p);
    HRESULT put_loop(int v);
    HRESULT get_loop(int* p);
    HRESULT put_vspace(int v);
    HRESULT get_vspace(int* p);
    HRESULT put_hspace(int v);
    HRESULT get_hspace(int* p);
    HRESULT put_onfinish(VARIANT v);
    HRESULT get_onfinish(VARIANT* p);
    HRESULT put_onstart(VARIANT v);
    HRESULT get_onstart(VARIANT* p);
    HRESULT put_onbounce(VARIANT v);
    HRESULT get_onbounce(VARIANT* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_trueSpeed(short v);
    HRESULT get_trueSpeed(short* p);
    HRESULT start();
    HRESULT stop();
}

@GUID("3050F527-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLMarqueeElement : IDispatch
{
}

@GUID("3050F81C-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLHtmlElement : IDispatch
{
    HRESULT put_version(BSTR v);
    HRESULT get_version(BSTR* p);
}

@GUID("3050F81D-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLHeadElement : IDispatch
{
    HRESULT put_profile(BSTR v);
    HRESULT get_profile(BSTR* p);
}

@GUID("3051042F-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLHeadElement2 : IDispatch
{
    HRESULT put_profile(BSTR v);
    HRESULT get_profile(BSTR* p);
}

@GUID("3050F322-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTitleElement : IDispatch
{
    HRESULT put_text(BSTR v);
    HRESULT get_text(BSTR* p);
}

@GUID("3050F203-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLMetaElement : IDispatch
{
    HRESULT put_httpEquiv(BSTR v);
    HRESULT get_httpEquiv(BSTR* p);
    HRESULT put_content(BSTR v);
    HRESULT get_content(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_url(BSTR v);
    HRESULT get_url(BSTR* p);
    HRESULT put_charset(BSTR v);
    HRESULT get_charset(BSTR* p);
}

@GUID("3050F81F-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLMetaElement2 : IDispatch
{
    HRESULT put_scheme(BSTR v);
    HRESULT get_scheme(BSTR* p);
}

@GUID("30510495-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLMetaElement3 : IDispatch
{
    HRESULT put_url(BSTR v);
    HRESULT get_url(BSTR* p);
}

@GUID("3050F204-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLBaseElement : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT put_target(BSTR v);
    HRESULT get_target(BSTR* p);
}

@GUID("30510420-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLBaseElement2 : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
}

@GUID("3050F560-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLHtmlElement : IDispatch
{
}

@GUID("3050F561-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLHeadElement : IDispatch
{
}

@GUID("3050F516-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLTitleElement : IDispatch
{
}

@GUID("3050F517-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLMetaElement : IDispatch
{
}

@GUID("3050F518-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLBaseElement : IDispatch
{
}

@GUID("3050F206-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLIsIndexElement : IDispatch
{
    HRESULT put_prompt(BSTR v);
    HRESULT get_prompt(BSTR* p);
    HRESULT put_action(BSTR v);
    HRESULT get_action(BSTR* p);
}

@GUID("3050F82F-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLIsIndexElement2 : IDispatch
{
    HRESULT get_form(IHTMLFormElement* p);
}

@GUID("3050F207-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLNextIdElement : IDispatch
{
    HRESULT put_n(BSTR v);
    HRESULT get_n(BSTR* p);
}

@GUID("3050F519-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLIsIndexElement : IDispatch
{
}

@GUID("3050F51A-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLNextIdElement : IDispatch
{
}

@GUID("3050F202-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLBaseFontElement : IDispatch
{
    HRESULT put_color(VARIANT v);
    HRESULT get_color(VARIANT* p);
    HRESULT put_face(BSTR v);
    HRESULT get_face(BSTR* p);
    HRESULT put_size(int v);
    HRESULT get_size(int* p);
}

@GUID("3050F504-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLBaseFontElement : IDispatch
{
}

@GUID("3050F209-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLUnknownElement : IDispatch
{
}

@GUID("3050F539-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLUnknownElement : IDispatch
{
}

@GUID("305107C5-98B5-11CF-BB82-00AA00BDCE0B")
interface IWebGeolocation : IDispatch
{
    HRESULT getCurrentPosition(IDispatch successCallback, IDispatch errorCallback, IDispatch options);
    HRESULT watchPosition(IDispatch successCallback, IDispatch errorCallback, IDispatch options, int* watchId);
    HRESULT clearWatch(int watchId);
}

@GUID("3050F3FC-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLMimeTypesCollection : IDispatch
{
    HRESULT get_length(int* p);
}

@GUID("3050F3FD-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLPluginsCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT refresh(short reload);
}

@GUID("FECEAAA2-8405-11CF-8BA1-00AA00476DA6")
interface IOmHistory : IDispatch
{
    HRESULT get_length(short* p);
    HRESULT back(VARIANT* pvargdistance);
    HRESULT forward(VARIANT* pvargdistance);
    HRESULT go(VARIANT* pvargdistance);
}

@GUID("3050F401-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLOpsProfile : IDispatch
{
    HRESULT addRequest(BSTR name, VARIANT reserved, short* success);
    HRESULT clearRequest();
    HRESULT doRequest(VARIANT usage, VARIANT fname, VARIANT domain, VARIANT path, VARIANT expire, VARIANT reserved);
    HRESULT getAttribute(BSTR name, BSTR* value);
    HRESULT setAttribute(BSTR name, BSTR value, VARIANT prefs, short* success);
    HRESULT commitChanges(short* success);
    HRESULT addReadRequest(BSTR name, VARIANT reserved, short* success);
    HRESULT doReadRequest(VARIANT usage, VARIANT fname, VARIANT domain, VARIANT path, VARIANT expire, 
                          VARIANT reserved);
    HRESULT doWriteRequest(short* success);
}

@GUID("FECEAAA5-8405-11CF-8BA1-00AA00476DA6")
interface IOmNavigator : IDispatch
{
    HRESULT get_appCodeName(BSTR* p);
    HRESULT get_appName(BSTR* p);
    HRESULT get_appVersion(BSTR* p);
    HRESULT get_userAgent(BSTR* p);
    HRESULT javaEnabled(short* enabled);
    HRESULT taintEnabled(short* enabled);
    HRESULT get_mimeTypes(IHTMLMimeTypesCollection* p);
    HRESULT get_plugins(IHTMLPluginsCollection* p);
    HRESULT get_cookieEnabled(short* p);
    HRESULT get_opsProfile(IHTMLOpsProfile* p);
    HRESULT toString(BSTR* string);
    HRESULT get_cpuClass(BSTR* p);
    HRESULT get_systemLanguage(BSTR* p);
    HRESULT get_browserLanguage(BSTR* p);
    HRESULT get_userLanguage(BSTR* p);
    HRESULT get_platform(BSTR* p);
    HRESULT get_appMinorVersion(BSTR* p);
    HRESULT get_connectionSpeed(int* p);
    HRESULT get_onLine(short* p);
    HRESULT get_userProfile(IHTMLOpsProfile* p);
}

@GUID("305107CF-98B5-11CF-BB82-00AA00BDCE0B")
interface INavigatorGeolocation : IDispatch
{
    HRESULT get_geolocation(IWebGeolocation* p);
}

@GUID("30510804-98B5-11CF-BB82-00AA00BDCE0B")
interface INavigatorDoNotTrack : IDispatch
{
    HRESULT get_msDoNotTrack(BSTR* p);
}

@GUID("163BB1E0-6E00-11CF-837A-48DC04C10000")
interface IHTMLLocation : IDispatch
{
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT put_protocol(BSTR v);
    HRESULT get_protocol(BSTR* p);
    HRESULT put_host(BSTR v);
    HRESULT get_host(BSTR* p);
    HRESULT put_hostname(BSTR v);
    HRESULT get_hostname(BSTR* p);
    HRESULT put_port(BSTR v);
    HRESULT get_port(BSTR* p);
    HRESULT put_pathname(BSTR v);
    HRESULT get_pathname(BSTR* p);
    HRESULT put_search(BSTR v);
    HRESULT get_search(BSTR* p);
    HRESULT put_hash(BSTR v);
    HRESULT get_hash(BSTR* p);
    HRESULT reload(short flag);
    HRESULT replace(BSTR bstr);
    HRESULT assign(BSTR bstr);
    HRESULT toString(BSTR* string);
}

@GUID("3050F549-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLHistory : IDispatch
{
}

@GUID("3050F54C-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLNavigator : IDispatch
{
}

@GUID("3050F54E-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLLocation : IDispatch
{
}

@GUID("3050F54A-98B5-11CF-BB82-00AA00BDCE0B")
interface DispCPlugins : IDispatch
{
}

@GUID("3050F4CE-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLBookmarkCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(int index, VARIANT* pVarBookmark);
}

@GUID("3050F4B3-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDataTransfer : IDispatch
{
    HRESULT setData(BSTR format, VARIANT* data, short* pret);
    HRESULT getData(BSTR format, VARIANT* pvarRet);
    HRESULT clearData(BSTR format, short* pret);
    HRESULT put_dropEffect(BSTR v);
    HRESULT get_dropEffect(BSTR* p);
    HRESULT put_effectAllowed(BSTR v);
    HRESULT get_effectAllowed(BSTR* p);
}

@GUID("3050F48B-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLEventObj2 : IDispatch
{
    HRESULT setAttribute(BSTR strAttributeName, VARIANT AttributeValue, int lFlags);
    HRESULT getAttribute(BSTR strAttributeName, int lFlags, VARIANT* AttributeValue);
    HRESULT removeAttribute(BSTR strAttributeName, int lFlags, short* pfSuccess);
    HRESULT put_propertyName(BSTR v);
    HRESULT get_propertyName(BSTR* p);
    HRESULT putref_bookmarks(IHTMLBookmarkCollection v);
    HRESULT get_bookmarks(IHTMLBookmarkCollection* p);
    HRESULT putref_recordset(IDispatch v);
    HRESULT get_recordset(IDispatch* p);
    HRESULT put_dataFld(BSTR v);
    HRESULT get_dataFld(BSTR* p);
    HRESULT putref_boundElements(IHTMLElementCollection v);
    HRESULT get_boundElements(IHTMLElementCollection* p);
    HRESULT put_repeat(short v);
    HRESULT get_repeat(short* p);
    HRESULT put_srcUrn(BSTR v);
    HRESULT get_srcUrn(BSTR* p);
    HRESULT putref_srcElement(IHTMLElement v);
    HRESULT get_srcElement(IHTMLElement* p);
    HRESULT put_altKey(short v);
    HRESULT get_altKey(short* p);
    HRESULT put_ctrlKey(short v);
    HRESULT get_ctrlKey(short* p);
    HRESULT put_shiftKey(short v);
    HRESULT get_shiftKey(short* p);
    HRESULT putref_fromElement(IHTMLElement v);
    HRESULT get_fromElement(IHTMLElement* p);
    HRESULT putref_toElement(IHTMLElement v);
    HRESULT get_toElement(IHTMLElement* p);
    HRESULT put_button(int v);
    HRESULT get_button(int* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_qualifier(BSTR v);
    HRESULT get_qualifier(BSTR* p);
    HRESULT put_reason(int v);
    HRESULT get_reason(int* p);
    HRESULT put_x(int v);
    HRESULT get_x(int* p);
    HRESULT put_y(int v);
    HRESULT get_y(int* p);
    HRESULT put_clientX(int v);
    HRESULT get_clientX(int* p);
    HRESULT put_clientY(int v);
    HRESULT get_clientY(int* p);
    HRESULT put_offsetX(int v);
    HRESULT get_offsetX(int* p);
    HRESULT put_offsetY(int v);
    HRESULT get_offsetY(int* p);
    HRESULT put_screenX(int v);
    HRESULT get_screenX(int* p);
    HRESULT put_screenY(int v);
    HRESULT get_screenY(int* p);
    HRESULT putref_srcFilter(IDispatch v);
    HRESULT get_srcFilter(IDispatch* p);
    HRESULT get_dataTransfer(IHTMLDataTransfer* p);
}

@GUID("3050F680-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLEventObj3 : IDispatch
{
    HRESULT get_contentOverflow(short* p);
    HRESULT put_shiftLeft(short v);
    HRESULT get_shiftLeft(short* p);
    HRESULT put_altLeft(short v);
    HRESULT get_altLeft(short* p);
    HRESULT put_ctrlLeft(short v);
    HRESULT get_ctrlLeft(short* p);
    HRESULT get_imeCompositionChange(ptrdiff_t* p);
    HRESULT get_imeNotifyCommand(ptrdiff_t* p);
    HRESULT get_imeNotifyData(ptrdiff_t* p);
    HRESULT get_imeRequest(ptrdiff_t* p);
    HRESULT get_imeRequestData(ptrdiff_t* p);
    HRESULT get_keyboardLayout(ptrdiff_t* p);
    HRESULT get_behaviorCookie(int* p);
    HRESULT get_behaviorPart(int* p);
    HRESULT get_nextPage(BSTR* p);
}

@GUID("3050F814-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLEventObj4 : IDispatch
{
    HRESULT get_wheelDelta(int* p);
}

@GUID("30510478-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLEventObj5 : IDispatch
{
    HRESULT put_url(BSTR v);
    HRESULT get_url(BSTR* p);
    HRESULT put_data(BSTR v);
    HRESULT get_data(BSTR* p);
    HRESULT get_source(IDispatch* p);
    HRESULT put_origin(BSTR v);
    HRESULT get_origin(BSTR* p);
    HRESULT put_issession(short v);
    HRESULT get_issession(short* p);
}

@GUID("30510734-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLEventObj6 : IDispatch
{
    HRESULT get_actionURL(BSTR* p);
    HRESULT get_buttonID(int* p);
}

@GUID("3050F558-98B5-11CF-BB82-00AA00BDCE0B")
interface DispCEventObj : IDispatch
{
}

@GUID("3051074B-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleMedia : IDispatch
{
    HRESULT get_type(BSTR* p);
    HRESULT matchMedium(BSTR mediaQuery, short* matches);
}

@GUID("3059009E-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLStyleMedia : IDispatch
{
}

@GUID("332C4426-26CB-11D0-B483-00C04FD90119")
interface IHTMLFramesCollection2 : IDispatch
{
    HRESULT item(VARIANT* pvarIndex, VARIANT* pvarResult);
    HRESULT get_length(int* p);
}

@GUID("3050F5A1-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLWindowEvents3 : IDispatch
{
}

@GUID("3050F625-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLWindowEvents2 : IDispatch
{
}

@GUID("96A0A4E0-D062-11CF-94B6-00AA0060275C")
interface HTMLWindowEvents : IDispatch
{
}

@GUID("332C4425-26CB-11D0-B483-00C04FD90119")
interface IHTMLDocument2 : IHTMLDocument
{
    HRESULT get_all(IHTMLElementCollection* p);
    HRESULT get_body(IHTMLElement* p);
    HRESULT get_activeElement(IHTMLElement* p);
    HRESULT get_images(IHTMLElementCollection* p);
    HRESULT get_applets(IHTMLElementCollection* p);
    HRESULT get_links(IHTMLElementCollection* p);
    HRESULT get_forms(IHTMLElementCollection* p);
    HRESULT get_anchors(IHTMLElementCollection* p);
    HRESULT put_title(BSTR v);
    HRESULT get_title(BSTR* p);
    HRESULT get_scripts(IHTMLElementCollection* p);
    HRESULT put_designMode(BSTR v);
    HRESULT get_designMode(BSTR* p);
    HRESULT get_selection(IHTMLSelectionObject* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT get_frames(IHTMLFramesCollection2* p);
    HRESULT get_embeds(IHTMLElementCollection* p);
    HRESULT get_plugins(IHTMLElementCollection* p);
    HRESULT put_alinkColor(VARIANT v);
    HRESULT get_alinkColor(VARIANT* p);
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT put_fgColor(VARIANT v);
    HRESULT get_fgColor(VARIANT* p);
    HRESULT put_linkColor(VARIANT v);
    HRESULT get_linkColor(VARIANT* p);
    HRESULT put_vlinkColor(VARIANT v);
    HRESULT get_vlinkColor(VARIANT* p);
    HRESULT get_referrer(BSTR* p);
    HRESULT get_location(IHTMLLocation* p);
    HRESULT get_lastModified(BSTR* p);
    HRESULT put_URL(BSTR v);
    HRESULT get_URL(BSTR* p);
    HRESULT put_domain(BSTR v);
    HRESULT get_domain(BSTR* p);
    HRESULT put_cookie(BSTR v);
    HRESULT get_cookie(BSTR* p);
    HRESULT put_expando(short v);
    HRESULT get_expando(short* p);
    HRESULT put_charset(BSTR v);
    HRESULT get_charset(BSTR* p);
    HRESULT put_defaultCharset(BSTR v);
    HRESULT get_defaultCharset(BSTR* p);
    HRESULT get_mimeType(BSTR* p);
    HRESULT get_fileSize(BSTR* p);
    HRESULT get_fileCreatedDate(BSTR* p);
    HRESULT get_fileModifiedDate(BSTR* p);
    HRESULT get_fileUpdatedDate(BSTR* p);
    HRESULT get_security(BSTR* p);
    HRESULT get_protocol(BSTR* p);
    HRESULT get_nameProp(BSTR* p);
    HRESULT write(SAFEARRAY* psarray);
    HRESULT writeln(SAFEARRAY* psarray);
    HRESULT open(BSTR url, VARIANT name, VARIANT features, VARIANT replace, IDispatch* pomWindowResult);
    HRESULT close();
    HRESULT clear();
    HRESULT queryCommandSupported(BSTR cmdID, short* pfRet);
    HRESULT queryCommandEnabled(BSTR cmdID, short* pfRet);
    HRESULT queryCommandState(BSTR cmdID, short* pfRet);
    HRESULT queryCommandIndeterm(BSTR cmdID, short* pfRet);
    HRESULT queryCommandText(BSTR cmdID, BSTR* pcmdText);
    HRESULT queryCommandValue(BSTR cmdID, VARIANT* pcmdValue);
    HRESULT execCommand(BSTR cmdID, short showUI, VARIANT value, short* pfRet);
    HRESULT execCommandShowHelp(BSTR cmdID, short* pfRet);
    HRESULT createElement(BSTR eTag, IHTMLElement* newElem);
    HRESULT put_onhelp(VARIANT v);
    HRESULT get_onhelp(VARIANT* p);
    HRESULT put_onclick(VARIANT v);
    HRESULT get_onclick(VARIANT* p);
    HRESULT put_ondblclick(VARIANT v);
    HRESULT get_ondblclick(VARIANT* p);
    HRESULT put_onkeyup(VARIANT v);
    HRESULT get_onkeyup(VARIANT* p);
    HRESULT put_onkeydown(VARIANT v);
    HRESULT get_onkeydown(VARIANT* p);
    HRESULT put_onkeypress(VARIANT v);
    HRESULT get_onkeypress(VARIANT* p);
    HRESULT put_onmouseup(VARIANT v);
    HRESULT get_onmouseup(VARIANT* p);
    HRESULT put_onmousedown(VARIANT v);
    HRESULT get_onmousedown(VARIANT* p);
    HRESULT put_onmousemove(VARIANT v);
    HRESULT get_onmousemove(VARIANT* p);
    HRESULT put_onmouseout(VARIANT v);
    HRESULT get_onmouseout(VARIANT* p);
    HRESULT put_onmouseover(VARIANT v);
    HRESULT get_onmouseover(VARIANT* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT put_onafterupdate(VARIANT v);
    HRESULT get_onafterupdate(VARIANT* p);
    HRESULT put_onrowexit(VARIANT v);
    HRESULT get_onrowexit(VARIANT* p);
    HRESULT put_onrowenter(VARIANT v);
    HRESULT get_onrowenter(VARIANT* p);
    HRESULT put_ondragstart(VARIANT v);
    HRESULT get_ondragstart(VARIANT* p);
    HRESULT put_onselectstart(VARIANT v);
    HRESULT get_onselectstart(VARIANT* p);
    HRESULT elementFromPoint(int x, int y, IHTMLElement* elementHit);
    HRESULT get_parentWindow(IHTMLWindow2* p);
    HRESULT get_styleSheets(IHTMLStyleSheetsCollection* p);
    HRESULT put_onbeforeupdate(VARIANT v);
    HRESULT get_onbeforeupdate(VARIANT* p);
    HRESULT put_onerrorupdate(VARIANT v);
    HRESULT get_onerrorupdate(VARIANT* p);
    HRESULT toString(BSTR* String);
    HRESULT createStyleSheet(BSTR bstrHref, int lIndex, IHTMLStyleSheet* ppnewStyleSheet);
}

@GUID("332C4427-26CB-11D0-B483-00C04FD90119")
interface IHTMLWindow2 : IHTMLFramesCollection2
{
    HRESULT get_frames(IHTMLFramesCollection2* p);
    HRESULT put_defaultStatus(BSTR v);
    HRESULT get_defaultStatus(BSTR* p);
    HRESULT put_status(BSTR v);
    HRESULT get_status(BSTR* p);
    HRESULT setTimeout(BSTR expression, int msec, VARIANT* language, int* timerID);
    HRESULT clearTimeout(int timerID);
    HRESULT alert(BSTR message);
    HRESULT confirm(BSTR message, short* confirmed);
    HRESULT prompt(BSTR message, BSTR defstr, VARIANT* textdata);
    HRESULT get_Image(IHTMLImageElementFactory* p);
    HRESULT get_location(IHTMLLocation* p);
    HRESULT get_history(IOmHistory* p);
    HRESULT close();
    HRESULT put_opener(VARIANT v);
    HRESULT get_opener(VARIANT* p);
    HRESULT get_navigator(IOmNavigator* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT get_parent(IHTMLWindow2* p);
    HRESULT open(BSTR url, BSTR name, BSTR features, short replace, IHTMLWindow2* pomWindowResult);
    HRESULT get_self(IHTMLWindow2* p);
    HRESULT get_top(IHTMLWindow2* p);
    HRESULT get_window(IHTMLWindow2* p);
    HRESULT navigate(BSTR url);
    HRESULT put_onfocus(VARIANT v);
    HRESULT get_onfocus(VARIANT* p);
    HRESULT put_onblur(VARIANT v);
    HRESULT get_onblur(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onbeforeunload(VARIANT v);
    HRESULT get_onbeforeunload(VARIANT* p);
    HRESULT put_onunload(VARIANT v);
    HRESULT get_onunload(VARIANT* p);
    HRESULT put_onhelp(VARIANT v);
    HRESULT get_onhelp(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_onresize(VARIANT v);
    HRESULT get_onresize(VARIANT* p);
    HRESULT put_onscroll(VARIANT v);
    HRESULT get_onscroll(VARIANT* p);
    HRESULT get_document(IHTMLDocument2* p);
    HRESULT get_event(IHTMLEventObj* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT showModalDialog(BSTR dialog, VARIANT* varArgIn, VARIANT* varOptions, VARIANT* varArgOut);
    HRESULT showHelp(BSTR helpURL, VARIANT helpArg, BSTR features);
    HRESULT get_screen(IHTMLScreen* p);
    HRESULT get_Option(IHTMLOptionElementFactory* p);
    HRESULT focus();
    HRESULT get_closed(short* p);
    HRESULT blur();
    HRESULT scroll(int x, int y);
    HRESULT get_clientInformation(IOmNavigator* p);
    HRESULT setInterval(BSTR expression, int msec, VARIANT* language, int* timerID);
    HRESULT clearInterval(int timerID);
    HRESULT put_offscreenBuffering(VARIANT v);
    HRESULT get_offscreenBuffering(VARIANT* p);
    HRESULT execScript(BSTR code, BSTR language, VARIANT* pvarRet);
    HRESULT toString(BSTR* String);
    HRESULT scrollBy(int x, int y);
    HRESULT scrollTo(int x, int y);
    HRESULT moveTo(int x, int y);
    HRESULT moveBy(int x, int y);
    HRESULT resizeTo(int x, int y);
    HRESULT resizeBy(int x, int y);
    HRESULT get_external(IDispatch* p);
}

@GUID("3050F4AE-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLWindow3 : IDispatch
{
    HRESULT get_screenLeft(int* p);
    HRESULT get_screenTop(int* p);
    HRESULT attachEvent(BSTR event, IDispatch pDisp, short* pfResult);
    HRESULT detachEvent(BSTR event, IDispatch pDisp);
    HRESULT setTimeout(VARIANT* expression, int msec, VARIANT* language, int* timerID);
    HRESULT setInterval(VARIANT* expression, int msec, VARIANT* language, int* timerID);
    HRESULT print();
    HRESULT put_onbeforeprint(VARIANT v);
    HRESULT get_onbeforeprint(VARIANT* p);
    HRESULT put_onafterprint(VARIANT v);
    HRESULT get_onafterprint(VARIANT* p);
    HRESULT get_clipboardData(IHTMLDataTransfer* p);
    HRESULT showModelessDialog(BSTR url, VARIANT* varArgIn, VARIANT* options, IHTMLWindow2* pDialog);
}

@GUID("3050F311-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLFrameBase : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_frameBorder(BSTR v);
    HRESULT get_frameBorder(BSTR* p);
    HRESULT put_frameSpacing(VARIANT v);
    HRESULT get_frameSpacing(VARIANT* p);
    HRESULT put_marginWidth(VARIANT v);
    HRESULT get_marginWidth(VARIANT* p);
    HRESULT put_marginHeight(VARIANT v);
    HRESULT get_marginHeight(VARIANT* p);
    HRESULT put_noResize(short v);
    HRESULT get_noResize(short* p);
    HRESULT put_scrolling(BSTR v);
    HRESULT get_scrolling(BSTR* p);
}

@GUID("30510474-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStorage : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get_remainingSpace(int* p);
    HRESULT key(int lIndex, BSTR* __MIDL__IHTMLStorage0000);
    HRESULT getItem(BSTR bstrKey, VARIANT* __MIDL__IHTMLStorage0001);
    HRESULT setItem(BSTR bstrKey, BSTR bstrValue);
    HRESULT removeItem(BSTR bstrKey);
    HRESULT clear();
}

@GUID("3051074E-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLPerformance : IDispatch
{
    HRESULT get_navigation(IHTMLPerformanceNavigation* p);
    HRESULT get_timing(IHTMLPerformanceTiming* p);
    HRESULT toString(BSTR* string);
    HRESULT toJSON(VARIANT* pVar);
}

@GUID("30510828-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLApplicationCache : IDispatch
{
    HRESULT get_status(int* p);
    HRESULT put_onchecking(VARIANT v);
    HRESULT get_onchecking(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_onnoupdate(VARIANT v);
    HRESULT get_onnoupdate(VARIANT* p);
    HRESULT put_ondownloading(VARIANT v);
    HRESULT get_ondownloading(VARIANT* p);
    HRESULT put_onprogress(VARIANT v);
    HRESULT get_onprogress(VARIANT* p);
    HRESULT put_onupdateready(VARIANT v);
    HRESULT get_onupdateready(VARIANT* p);
    HRESULT put_oncached(VARIANT v);
    HRESULT get_oncached(VARIANT* p);
    HRESULT put_onobsolete(VARIANT v);
    HRESULT get_onobsolete(VARIANT* p);
    HRESULT update();
    HRESULT swapCache();
    HRESULT abort();
}

@GUID("3050F35C-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLScreen : IDispatch
{
    HRESULT get_colorDepth(int* p);
    HRESULT put_bufferDepth(int v);
    HRESULT get_bufferDepth(int* p);
    HRESULT get_width(int* p);
    HRESULT get_height(int* p);
    HRESULT put_updateInterval(int v);
    HRESULT get_updateInterval(int* p);
    HRESULT get_availHeight(int* p);
    HRESULT get_availWidth(int* p);
    HRESULT get_fontSmoothingEnabled(short* p);
}

@GUID("3050F84A-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLScreen2 : IDispatch
{
    HRESULT get_logicalXDPI(int* p);
    HRESULT get_logicalYDPI(int* p);
    HRESULT get_deviceXDPI(int* p);
    HRESULT get_deviceYDPI(int* p);
}

@GUID("305104A1-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLScreen3 : IDispatch
{
    HRESULT get_systemXDPI(int* p);
    HRESULT get_systemYDPI(int* p);
}

@GUID("3051076B-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLScreen4 : IDispatch
{
    HRESULT get_pixelDepth(int* p);
}

@GUID("3050F6CF-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLWindow4 : IDispatch
{
    HRESULT createPopup(VARIANT* varArgIn, IDispatch* ppPopup);
    HRESULT get_frameElement(IHTMLFrameBase* p);
}

@GUID("3051040E-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLWindow5 : IDispatch
{
    HRESULT put_XMLHttpRequest(VARIANT v);
    HRESULT get_XMLHttpRequest(VARIANT* p);
}

@GUID("30510453-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLWindow6 : IDispatch
{
    HRESULT put_XDomainRequest(VARIANT v);
    HRESULT get_XDomainRequest(VARIANT* p);
    HRESULT get_sessionStorage(IHTMLStorage* p);
    HRESULT get_localStorage(IHTMLStorage* p);
    HRESULT put_onhashchange(VARIANT v);
    HRESULT get_onhashchange(VARIANT* p);
    HRESULT get_maxConnectionsPerServer(int* p);
    HRESULT postMessage(BSTR msg, VARIANT targetOrigin);
    HRESULT toStaticHTML(BSTR bstrHTML, BSTR* pbstrStaticHTML);
    HRESULT put_onmessage(VARIANT v);
    HRESULT get_onmessage(VARIANT* p);
    HRESULT msWriteProfilerMark(BSTR bstrProfilerMarkName);
}

@GUID("305104B7-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLWindow7 : IDispatch
{
    HRESULT getSelection(IHTMLSelection* ppIHTMLSelection);
    HRESULT getComputedStyle(IHTMLDOMNode varArgIn, BSTR bstrPseudoElt, IHTMLCSSStyleDeclaration* ppComputedStyle);
    HRESULT get_styleMedia(IHTMLStyleMedia* p);
    HRESULT put_performance(VARIANT v);
    HRESULT get_performance(VARIANT* p);
    HRESULT get_innerWidth(int* p);
    HRESULT get_innerHeight(int* p);
    HRESULT get_pageXOffset(int* p);
    HRESULT get_pageYOffset(int* p);
    HRESULT get_screenX(int* p);
    HRESULT get_screenY(int* p);
    HRESULT get_outerWidth(int* p);
    HRESULT get_outerHeight(int* p);
    HRESULT put_onabort(VARIANT v);
    HRESULT get_onabort(VARIANT* p);
    HRESULT put_oncanplay(VARIANT v);
    HRESULT get_oncanplay(VARIANT* p);
    HRESULT put_oncanplaythrough(VARIANT v);
    HRESULT get_oncanplaythrough(VARIANT* p);
    HRESULT put_onchange(VARIANT v);
    HRESULT get_onchange(VARIANT* p);
    HRESULT put_onclick(VARIANT v);
    HRESULT get_onclick(VARIANT* p);
    HRESULT put_oncontextmenu(VARIANT v);
    HRESULT get_oncontextmenu(VARIANT* p);
    HRESULT put_ondblclick(VARIANT v);
    HRESULT get_ondblclick(VARIANT* p);
    HRESULT put_ondrag(VARIANT v);
    HRESULT get_ondrag(VARIANT* p);
    HRESULT put_ondragend(VARIANT v);
    HRESULT get_ondragend(VARIANT* p);
    HRESULT put_ondragenter(VARIANT v);
    HRESULT get_ondragenter(VARIANT* p);
    HRESULT put_ondragleave(VARIANT v);
    HRESULT get_ondragleave(VARIANT* p);
    HRESULT put_ondragover(VARIANT v);
    HRESULT get_ondragover(VARIANT* p);
    HRESULT put_ondragstart(VARIANT v);
    HRESULT get_ondragstart(VARIANT* p);
    HRESULT put_ondrop(VARIANT v);
    HRESULT get_ondrop(VARIANT* p);
    HRESULT put_ondurationchange(VARIANT v);
    HRESULT get_ondurationchange(VARIANT* p);
    HRESULT put_onfocusin(VARIANT v);
    HRESULT get_onfocusin(VARIANT* p);
    HRESULT put_onfocusout(VARIANT v);
    HRESULT get_onfocusout(VARIANT* p);
    HRESULT put_oninput(VARIANT v);
    HRESULT get_oninput(VARIANT* p);
    HRESULT put_onemptied(VARIANT v);
    HRESULT get_onemptied(VARIANT* p);
    HRESULT put_onended(VARIANT v);
    HRESULT get_onended(VARIANT* p);
    HRESULT put_onkeydown(VARIANT v);
    HRESULT get_onkeydown(VARIANT* p);
    HRESULT put_onkeypress(VARIANT v);
    HRESULT get_onkeypress(VARIANT* p);
    HRESULT put_onkeyup(VARIANT v);
    HRESULT get_onkeyup(VARIANT* p);
    HRESULT put_onloadeddata(VARIANT v);
    HRESULT get_onloadeddata(VARIANT* p);
    HRESULT put_onloadedmetadata(VARIANT v);
    HRESULT get_onloadedmetadata(VARIANT* p);
    HRESULT put_onloadstart(VARIANT v);
    HRESULT get_onloadstart(VARIANT* p);
    HRESULT put_onmousedown(VARIANT v);
    HRESULT get_onmousedown(VARIANT* p);
    HRESULT put_onmouseenter(VARIANT v);
    HRESULT get_onmouseenter(VARIANT* p);
    HRESULT put_onmouseleave(VARIANT v);
    HRESULT get_onmouseleave(VARIANT* p);
    HRESULT put_onmousemove(VARIANT v);
    HRESULT get_onmousemove(VARIANT* p);
    HRESULT put_onmouseout(VARIANT v);
    HRESULT get_onmouseout(VARIANT* p);
    HRESULT put_onmouseover(VARIANT v);
    HRESULT get_onmouseover(VARIANT* p);
    HRESULT put_onmouseup(VARIANT v);
    HRESULT get_onmouseup(VARIANT* p);
    HRESULT put_onmousewheel(VARIANT v);
    HRESULT get_onmousewheel(VARIANT* p);
    HRESULT put_onoffline(VARIANT v);
    HRESULT get_onoffline(VARIANT* p);
    HRESULT put_ononline(VARIANT v);
    HRESULT get_ononline(VARIANT* p);
    HRESULT put_onprogress(VARIANT v);
    HRESULT get_onprogress(VARIANT* p);
    HRESULT put_onratechange(VARIANT v);
    HRESULT get_onratechange(VARIANT* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT put_onreset(VARIANT v);
    HRESULT get_onreset(VARIANT* p);
    HRESULT put_onseeked(VARIANT v);
    HRESULT get_onseeked(VARIANT* p);
    HRESULT put_onseeking(VARIANT v);
    HRESULT get_onseeking(VARIANT* p);
    HRESULT put_onselect(VARIANT v);
    HRESULT get_onselect(VARIANT* p);
    HRESULT put_onstalled(VARIANT v);
    HRESULT get_onstalled(VARIANT* p);
    HRESULT put_onstorage(VARIANT v);
    HRESULT get_onstorage(VARIANT* p);
    HRESULT put_onsubmit(VARIANT v);
    HRESULT get_onsubmit(VARIANT* p);
    HRESULT put_onsuspend(VARIANT v);
    HRESULT get_onsuspend(VARIANT* p);
    HRESULT put_ontimeupdate(VARIANT v);
    HRESULT get_ontimeupdate(VARIANT* p);
    HRESULT put_onpause(VARIANT v);
    HRESULT get_onpause(VARIANT* p);
    HRESULT put_onplay(VARIANT v);
    HRESULT get_onplay(VARIANT* p);
    HRESULT put_onplaying(VARIANT v);
    HRESULT get_onplaying(VARIANT* p);
    HRESULT put_onvolumechange(VARIANT v);
    HRESULT get_onvolumechange(VARIANT* p);
    HRESULT put_onwaiting(VARIANT v);
    HRESULT get_onwaiting(VARIANT* p);
}

@GUID("305107AB-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLWindow8 : IDispatch
{
    HRESULT put_onmspointerdown(VARIANT v);
    HRESULT get_onmspointerdown(VARIANT* p);
    HRESULT put_onmspointermove(VARIANT v);
    HRESULT get_onmspointermove(VARIANT* p);
    HRESULT put_onmspointerup(VARIANT v);
    HRESULT get_onmspointerup(VARIANT* p);
    HRESULT put_onmspointerover(VARIANT v);
    HRESULT get_onmspointerover(VARIANT* p);
    HRESULT put_onmspointerout(VARIANT v);
    HRESULT get_onmspointerout(VARIANT* p);
    HRESULT put_onmspointercancel(VARIANT v);
    HRESULT get_onmspointercancel(VARIANT* p);
    HRESULT put_onmspointerhover(VARIANT v);
    HRESULT get_onmspointerhover(VARIANT* p);
    HRESULT put_onmsgesturestart(VARIANT v);
    HRESULT get_onmsgesturestart(VARIANT* p);
    HRESULT put_onmsgesturechange(VARIANT v);
    HRESULT get_onmsgesturechange(VARIANT* p);
    HRESULT put_onmsgestureend(VARIANT v);
    HRESULT get_onmsgestureend(VARIANT* p);
    HRESULT put_onmsgesturehold(VARIANT v);
    HRESULT get_onmsgesturehold(VARIANT* p);
    HRESULT put_onmsgesturetap(VARIANT v);
    HRESULT get_onmsgesturetap(VARIANT* p);
    HRESULT put_onmsgesturedoubletap(VARIANT v);
    HRESULT get_onmsgesturedoubletap(VARIANT* p);
    HRESULT put_onmsinertiastart(VARIANT v);
    HRESULT get_onmsinertiastart(VARIANT* p);
    HRESULT get_applicationCache(IHTMLApplicationCache* p);
    HRESULT put_onpopstate(VARIANT v);
    HRESULT get_onpopstate(VARIANT* p);
}

@GUID("3050F591-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLScreen : IDispatch
{
}

@GUID("3050F55D-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLWindow2 : IDispatch
{
}

@GUID("3050F55E-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLWindowProxy : IDispatch
{
}

@GUID("3051041A-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDocumentCompatibleInfo : IDispatch
{
    HRESULT get_userAgent(BSTR* p);
    HRESULT get_version(BSTR* p);
}

@GUID("30510418-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDocumentCompatibleInfoCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, IHTMLDocumentCompatibleInfo* compatibleInfo);
}

@GUID("3050F53E-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLDocumentCompatibleInfo : IDispatch
{
}

@GUID("3050F53F-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLDocumentCompatibleInfoCollection : IDispatch
{
}

@GUID("30510737-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLDocumentEvents4 : IDispatch
{
}

@GUID("3050F5A0-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLDocumentEvents3 : IDispatch
{
}

@GUID("3050F613-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLDocumentEvents2 : IDispatch
{
}

@GUID("3050F260-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLDocumentEvents : IDispatch
{
}

@GUID("305104E7-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGSVGElement : IDispatch
{
    HRESULT putref_x(ISVGAnimatedLength v);
    HRESULT get_x(ISVGAnimatedLength* p);
    HRESULT putref_y(ISVGAnimatedLength v);
    HRESULT get_y(ISVGAnimatedLength* p);
    HRESULT putref_width(ISVGAnimatedLength v);
    HRESULT get_width(ISVGAnimatedLength* p);
    HRESULT putref_height(ISVGAnimatedLength v);
    HRESULT get_height(ISVGAnimatedLength* p);
    HRESULT put_contentScriptType(BSTR v);
    HRESULT get_contentScriptType(BSTR* p);
    HRESULT put_contentStyleType(BSTR v);
    HRESULT get_contentStyleType(BSTR* p);
    HRESULT putref_viewport(ISVGRect v);
    HRESULT get_viewport(ISVGRect* p);
    HRESULT put_pixelUnitToMillimeterX(float v);
    HRESULT get_pixelUnitToMillimeterX(float* p);
    HRESULT put_pixelUnitToMillimeterY(float v);
    HRESULT get_pixelUnitToMillimeterY(float* p);
    HRESULT put_screenPixelToMillimeterX(float v);
    HRESULT get_screenPixelToMillimeterX(float* p);
    HRESULT put_screenPixelToMillimeterY(float v);
    HRESULT get_screenPixelToMillimeterY(float* p);
    HRESULT put_useCurrentView(short v);
    HRESULT get_useCurrentView(short* p);
    HRESULT putref_currentView(ISVGViewSpec v);
    HRESULT get_currentView(ISVGViewSpec* p);
    HRESULT put_currentScale(float v);
    HRESULT get_currentScale(float* p);
    HRESULT putref_currentTranslate(ISVGPoint v);
    HRESULT get_currentTranslate(ISVGPoint* p);
    HRESULT suspendRedraw(uint maxWaitMilliseconds, uint* pResult);
    HRESULT unsuspendRedraw(uint suspendHandeID);
    HRESULT unsuspendRedrawAll();
    HRESULT forceRedraw();
    HRESULT pauseAnimations();
    HRESULT unpauseAnimations();
    HRESULT animationsPaused(short* pResult);
    HRESULT getCurrentTime(float* pResult);
    HRESULT setCurrentTime(float seconds);
    HRESULT getIntersectionList(ISVGRect rect, ISVGElement referenceElement, VARIANT* pResult);
    HRESULT getEnclosureList(ISVGRect rect, ISVGElement referenceElement, VARIANT* pResult);
    HRESULT checkIntersection(ISVGElement element, ISVGRect rect, short* pResult);
    HRESULT checkEnclosure(ISVGElement element, ISVGRect rect, short* pResult);
    HRESULT deselectAll();
    HRESULT createSVGNumber(ISVGNumber* pResult);
    HRESULT createSVGLength(ISVGLength* pResult);
    HRESULT createSVGAngle(ISVGAngle* pResult);
    HRESULT createSVGPoint(ISVGPoint* pResult);
    HRESULT createSVGMatrix(ISVGMatrix* pResult);
    HRESULT createSVGRect(ISVGRect* pResult);
    HRESULT createSVGTransform(ISVGTransform* pResult);
    HRESULT createSVGTransformFromMatrix(ISVGMatrix matrix, ISVGTransform* pResult);
    HRESULT getElementById(BSTR elementId, IHTMLElement* pResult);
}

@GUID("30510746-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMNodeIterator : IDispatch
{
    HRESULT get_root(IDispatch* p);
    HRESULT get_whatToShow(uint* p);
    HRESULT get_filter(IDispatch* p);
    HRESULT get_expandEntityReferences(short* p);
    HRESULT nextNode(IDispatch* ppRetNode);
    HRESULT previousNode(IDispatch* ppRetNode);
    HRESULT detach();
}

@GUID("30510748-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMTreeWalker : IDispatch
{
    HRESULT get_root(IDispatch* p);
    HRESULT get_whatToShow(uint* p);
    HRESULT get_filter(IDispatch* p);
    HRESULT get_expandEntityReferences(short* p);
    HRESULT putref_currentNode(IDispatch v);
    HRESULT get_currentNode(IDispatch* p);
    HRESULT parentNode(IDispatch* ppRetNode);
    HRESULT firstChild(IDispatch* ppRetNode);
    HRESULT lastChild(IDispatch* ppRetNode);
    HRESULT previousSibling(IDispatch* ppRetNode);
    HRESULT nextSibling(IDispatch* ppRetNode);
    HRESULT previousNode(IDispatch* ppRetNode);
    HRESULT nextNode(IDispatch* ppRetNode);
}

@GUID("30510742-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMProcessingInstruction : IDispatch
{
    HRESULT get_target(BSTR* p);
    HRESULT put_data(BSTR v);
    HRESULT get_data(BSTR* p);
}

@GUID("3050F485-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDocument3 : IDispatch
{
    HRESULT releaseCapture();
    HRESULT recalc(short fForce);
    HRESULT createTextNode(BSTR text, IHTMLDOMNode* newTextNode);
    HRESULT get_documentElement(IHTMLElement* p);
    HRESULT get_uniqueID(BSTR* p);
    HRESULT attachEvent(BSTR event, IDispatch pDisp, short* pfResult);
    HRESULT detachEvent(BSTR event, IDispatch pDisp);
    HRESULT put_onrowsdelete(VARIANT v);
    HRESULT get_onrowsdelete(VARIANT* p);
    HRESULT put_onrowsinserted(VARIANT v);
    HRESULT get_onrowsinserted(VARIANT* p);
    HRESULT put_oncellchange(VARIANT v);
    HRESULT get_oncellchange(VARIANT* p);
    HRESULT put_ondatasetchanged(VARIANT v);
    HRESULT get_ondatasetchanged(VARIANT* p);
    HRESULT put_ondataavailable(VARIANT v);
    HRESULT get_ondataavailable(VARIANT* p);
    HRESULT put_ondatasetcomplete(VARIANT v);
    HRESULT get_ondatasetcomplete(VARIANT* p);
    HRESULT put_onpropertychange(VARIANT v);
    HRESULT get_onpropertychange(VARIANT* p);
    HRESULT put_dir(BSTR v);
    HRESULT get_dir(BSTR* p);
    HRESULT put_oncontextmenu(VARIANT v);
    HRESULT get_oncontextmenu(VARIANT* p);
    HRESULT put_onstop(VARIANT v);
    HRESULT get_onstop(VARIANT* p);
    HRESULT createDocumentFragment(IHTMLDocument2* pNewDoc);
    HRESULT get_parentDocument(IHTMLDocument2* p);
    HRESULT put_enableDownload(short v);
    HRESULT get_enableDownload(short* p);
    HRESULT put_baseUrl(BSTR v);
    HRESULT get_baseUrl(BSTR* p);
    HRESULT get_childNodes(IDispatch* p);
    HRESULT put_inheritStyleSheets(short v);
    HRESULT get_inheritStyleSheets(short* p);
    HRESULT put_onbeforeeditfocus(VARIANT v);
    HRESULT get_onbeforeeditfocus(VARIANT* p);
    HRESULT getElementsByName(BSTR v, IHTMLElementCollection* pelColl);
    HRESULT getElementById(BSTR v, IHTMLElement* pel);
    HRESULT getElementsByTagName(BSTR v, IHTMLElementCollection* pelColl);
}

@GUID("3050F69A-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDocument4 : IDispatch
{
    HRESULT focus();
    HRESULT hasFocus(short* pfFocus);
    HRESULT put_onselectionchange(VARIANT v);
    HRESULT get_onselectionchange(VARIANT* p);
    HRESULT get_namespaces(IDispatch* p);
    HRESULT createDocumentFromUrl(BSTR bstrUrl, BSTR bstrOptions, IHTMLDocument2* newDoc);
    HRESULT put_media(BSTR v);
    HRESULT get_media(BSTR* p);
    HRESULT createEventObject(VARIANT* pvarEventObject, IHTMLEventObj* ppEventObj);
    HRESULT fireEvent(BSTR bstrEventName, VARIANT* pvarEventObject, short* pfCancelled);
    HRESULT createRenderStyle(BSTR v, IHTMLRenderStyle* ppIHTMLRenderStyle);
    HRESULT put_oncontrolselect(VARIANT v);
    HRESULT get_oncontrolselect(VARIANT* p);
    HRESULT get_URLUnencoded(BSTR* p);
}

@GUID("3050F80C-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDocument5 : IDispatch
{
    HRESULT put_onmousewheel(VARIANT v);
    HRESULT get_onmousewheel(VARIANT* p);
    HRESULT get_doctype(IHTMLDOMNode* p);
    HRESULT get_implementation(IHTMLDOMImplementation* p);
    HRESULT createAttribute(BSTR bstrattrName, IHTMLDOMAttribute* ppattribute);
    HRESULT createComment(BSTR bstrdata, IHTMLDOMNode* ppRetNode);
    HRESULT put_onfocusin(VARIANT v);
    HRESULT get_onfocusin(VARIANT* p);
    HRESULT put_onfocusout(VARIANT v);
    HRESULT get_onfocusout(VARIANT* p);
    HRESULT put_onactivate(VARIANT v);
    HRESULT get_onactivate(VARIANT* p);
    HRESULT put_ondeactivate(VARIANT v);
    HRESULT get_ondeactivate(VARIANT* p);
    HRESULT put_onbeforeactivate(VARIANT v);
    HRESULT get_onbeforeactivate(VARIANT* p);
    HRESULT put_onbeforedeactivate(VARIANT v);
    HRESULT get_onbeforedeactivate(VARIANT* p);
    HRESULT get_compatMode(BSTR* p);
}

@GUID("30510417-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDocument6 : IDispatch
{
    HRESULT get_compatible(IHTMLDocumentCompatibleInfoCollection* p);
    HRESULT get_documentMode(VARIANT* p);
    HRESULT put_onstorage(VARIANT v);
    HRESULT get_onstorage(VARIANT* p);
    HRESULT put_onstoragecommit(VARIANT v);
    HRESULT get_onstoragecommit(VARIANT* p);
    HRESULT getElementById(BSTR bstrId, IHTMLElement2* ppRetElement);
    HRESULT updateSettings();
}

@GUID("305107D0-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDocument8 : IDispatch
{
    HRESULT put_onmscontentzoom(VARIANT v);
    HRESULT get_onmscontentzoom(VARIANT* p);
    HRESULT put_onmspointerdown(VARIANT v);
    HRESULT get_onmspointerdown(VARIANT* p);
    HRESULT put_onmspointermove(VARIANT v);
    HRESULT get_onmspointermove(VARIANT* p);
    HRESULT put_onmspointerup(VARIANT v);
    HRESULT get_onmspointerup(VARIANT* p);
    HRESULT put_onmspointerover(VARIANT v);
    HRESULT get_onmspointerover(VARIANT* p);
    HRESULT put_onmspointerout(VARIANT v);
    HRESULT get_onmspointerout(VARIANT* p);
    HRESULT put_onmspointercancel(VARIANT v);
    HRESULT get_onmspointercancel(VARIANT* p);
    HRESULT put_onmspointerhover(VARIANT v);
    HRESULT get_onmspointerhover(VARIANT* p);
    HRESULT put_onmsgesturestart(VARIANT v);
    HRESULT get_onmsgesturestart(VARIANT* p);
    HRESULT put_onmsgesturechange(VARIANT v);
    HRESULT get_onmsgesturechange(VARIANT* p);
    HRESULT put_onmsgestureend(VARIANT v);
    HRESULT get_onmsgestureend(VARIANT* p);
    HRESULT put_onmsgesturehold(VARIANT v);
    HRESULT get_onmsgesturehold(VARIANT* p);
    HRESULT put_onmsgesturetap(VARIANT v);
    HRESULT get_onmsgesturetap(VARIANT* p);
    HRESULT put_onmsgesturedoubletap(VARIANT v);
    HRESULT get_onmsgesturedoubletap(VARIANT* p);
    HRESULT put_onmsinertiastart(VARIANT v);
    HRESULT get_onmsinertiastart(VARIANT* p);
    HRESULT elementsFromPoint(float x, float y, IHTMLDOMChildrenCollection* elementsHit);
    HRESULT elementsFromRect(float left, float top, float width, float height, 
                             IHTMLDOMChildrenCollection* elementsHit);
    HRESULT put_onmsmanipulationstatechanged(VARIANT v);
    HRESULT get_onmsmanipulationstatechanged(VARIANT* p);
    HRESULT put_msCapsLockWarningOff(short v);
    HRESULT get_msCapsLockWarningOff(short* p);
}

@GUID("305104BC-98B5-11CF-BB82-00AA00BDCE0B")
interface IDocumentEvent : IDispatch
{
    HRESULT createEvent(BSTR eventType, IDOMEvent* ppEvent);
}

@GUID("305104AF-98B5-11CF-BB82-00AA00BDCE0B")
interface IDocumentRange : IDispatch
{
    HRESULT createRange(IHTMLDOMRange* ppIHTMLDOMRange);
}

@GUID("30510462-98B5-11CF-BB82-00AA00BDCE0B")
interface IDocumentSelector : IDispatch
{
    HRESULT querySelector(BSTR v, IHTMLElement* pel);
    HRESULT querySelectorAll(BSTR v, IHTMLDOMChildrenCollection* pel);
}

@GUID("30510744-98B5-11CF-BB82-00AA00BDCE0B")
interface IDocumentTraversal : IDispatch
{
    HRESULT createNodeIterator(IDispatch pRootNode, int ulWhatToShow, VARIANT* pFilter, 
                               short fEntityReferenceExpansion, IDOMNodeIterator* ppNodeIterator);
    HRESULT createTreeWalker(IDispatch pRootNode, int ulWhatToShow, VARIANT* pFilter, 
                             short fEntityReferenceExpansion, IDOMTreeWalker* ppTreeWalker);
}

@GUID("3050F55F-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLDocument : IDispatch
{
}

@GUID("A6D897FF-0A95-11D1-B0BA-006008166E11")
interface DWebBridgeEvents : IDispatch
{
}

@GUID("AE24FDAD-03C6-11D1-8B76-0080C744F389")
interface IWebBridge : IDispatch
{
    HRESULT put_URL(BSTR v);
    HRESULT get_URL(BSTR* p);
    HRESULT put_Scrollbar(short v);
    HRESULT get_Scrollbar(short* p);
    HRESULT put_embed(short v);
    HRESULT get_embed(short* p);
    HRESULT get_event(IDispatch* p);
    HRESULT get_readyState(int* p);
    HRESULT AboutBox();
}

@GUID("A5170870-0CF8-11D1-8B91-0080C744F389")
interface IWBScriptControl : IDispatch
{
    HRESULT raiseEvent(BSTR name, VARIANT eventData);
    HRESULT bubbleEvent();
    HRESULT setContextMenu(VARIANT menuItemPairs);
    HRESULT put_selectableContent(short v);
    HRESULT get_selectableContent(short* p);
    HRESULT get_frozen(short* p);
    HRESULT put_scrollbar(short v);
    HRESULT get_scrollbar(short* p);
    HRESULT get_version(BSTR* p);
    HRESULT get_visibility(short* p);
    HRESULT put_onvisibilitychange(VARIANT v);
    HRESULT get_onvisibilitychange(VARIANT* p);
}

@GUID("3050F25F-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLEmbedElement : IDispatch
{
    HRESULT put_hidden(BSTR v);
    HRESULT get_hidden(BSTR* p);
    HRESULT get_palette(BSTR* p);
    HRESULT get_pluginspage(BSTR* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_units(BSTR v);
    HRESULT get_units(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
}

@GUID("30510493-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLEmbedElement2 : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT get_pluginspage(BSTR* p);
}

@GUID("3050F52E-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLEmbed : IDispatch
{
}

@GUID("3050F61E-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLMapEvents2 : IDispatch
{
}

@GUID("3050F3BA-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLMapEvents : IDispatch
{
}

@GUID("3050F383-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLAreasCollection : IDispatch
{
    HRESULT put_length(int v);
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(VARIANT name, VARIANT index, IDispatch* pdisp);
    HRESULT tags(VARIANT tagName, IDispatch* pdisp);
    HRESULT add(IHTMLElement element, VARIANT before);
    HRESULT remove(int index);
}

@GUID("3050F5EC-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLAreasCollection2 : IDispatch
{
    HRESULT urns(VARIANT urn, IDispatch* pdisp);
}

@GUID("3050F837-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLAreasCollection3 : IDispatch
{
    HRESULT namedItem(BSTR name, IDispatch* pdisp);
}

@GUID("30510492-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLAreasCollection4 : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, IHTMLElement2* pNode);
    HRESULT namedItem(BSTR name, IHTMLElement2* pNode);
}

@GUID("3050F266-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLMapElement : IDispatch
{
    HRESULT get_areas(IHTMLAreasCollection* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
}

@GUID("3050F56A-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLAreasCollection : IDispatch
{
}

@GUID("3050F526-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLMapElement : IDispatch
{
}

@GUID("3050F611-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLAreaEvents2 : IDispatch
{
}

@GUID("3050F366-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLAreaEvents : IDispatch
{
}

@GUID("3050F265-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLAreaElement : IDispatch
{
    HRESULT put_shape(BSTR v);
    HRESULT get_shape(BSTR* p);
    HRESULT put_coords(BSTR v);
    HRESULT get_coords(BSTR* p);
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
    HRESULT put_target(BSTR v);
    HRESULT get_target(BSTR* p);
    HRESULT put_alt(BSTR v);
    HRESULT get_alt(BSTR* p);
    HRESULT put_noHref(short v);
    HRESULT get_noHref(short* p);
    HRESULT put_host(BSTR v);
    HRESULT get_host(BSTR* p);
    HRESULT put_hostname(BSTR v);
    HRESULT get_hostname(BSTR* p);
    HRESULT put_pathname(BSTR v);
    HRESULT get_pathname(BSTR* p);
    HRESULT put_port(BSTR v);
    HRESULT get_port(BSTR* p);
    HRESULT put_protocol(BSTR v);
    HRESULT get_protocol(BSTR* p);
    HRESULT put_search(BSTR v);
    HRESULT get_search(BSTR* p);
    HRESULT put_hash(BSTR v);
    HRESULT get_hash(BSTR* p);
    HRESULT put_onblur(VARIANT v);
    HRESULT get_onblur(VARIANT* p);
    HRESULT put_onfocus(VARIANT v);
    HRESULT get_onfocus(VARIANT* p);
    HRESULT put_tabIndex(short v);
    HRESULT get_tabIndex(short* p);
    HRESULT focus();
    HRESULT blur();
}

@GUID("3051041F-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLAreaElement2 : IDispatch
{
    HRESULT put_shape(BSTR v);
    HRESULT get_shape(BSTR* p);
    HRESULT put_coords(BSTR v);
    HRESULT get_coords(BSTR* p);
    HRESULT put_href(BSTR v);
    HRESULT get_href(BSTR* p);
}

@GUID("3050F503-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLAreaElement : IDispatch
{
}

@GUID("3050F2EB-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTableCaption : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_vAlign(BSTR v);
    HRESULT get_vAlign(BSTR* p);
}

@GUID("3050F508-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLTableCaption : IDispatch
{
}

@GUID("3050F20C-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLCommentElement : IDispatch
{
    HRESULT put_text(BSTR v);
    HRESULT get_text(BSTR* p);
    HRESULT put_atomic(int v);
    HRESULT get_atomic(int* p);
}

@GUID("3050F813-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLCommentElement2 : IDispatch
{
    HRESULT put_data(BSTR v);
    HRESULT get_data(BSTR* p);
    HRESULT get_length(int* p);
    HRESULT substringData(int offset, int Count, BSTR* pbstrsubString);
    HRESULT appendData(BSTR bstrstring);
    HRESULT insertData(int offset, BSTR bstrstring);
    HRESULT deleteData(int offset, int Count);
    HRESULT replaceData(int offset, int Count, BSTR bstrstring);
}

@GUID("3051073F-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLCommentElement3 : IDispatch
{
    HRESULT substringData(int offset, int Count, BSTR* pbstrsubString);
    HRESULT insertData(int offset, BSTR bstrstring);
    HRESULT deleteData(int offset, int Count);
    HRESULT replaceData(int offset, int Count, BSTR bstrstring);
}

@GUID("3050F50A-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLCommentElement : IDispatch
{
}

@GUID("3050F20A-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLPhraseElement : IDispatch
{
}

@GUID("3050F824-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLPhraseElement2 : IDispatch
{
    HRESULT put_cite(BSTR v);
    HRESULT get_cite(BSTR* p);
    HRESULT put_dateTime(BSTR v);
    HRESULT get_dateTime(BSTR* p);
}

@GUID("3051043D-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLPhraseElement3 : IDispatch
{
    HRESULT put_cite(BSTR v);
    HRESULT get_cite(BSTR* p);
}

@GUID("3050F3F3-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLSpanElement : IDispatch
{
}

@GUID("3050F52D-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLPhraseElement : IDispatch
{
}

@GUID("3050F548-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLSpanElement : IDispatch
{
}

@GUID("3050F623-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLTableEvents2 : IDispatch
{
}

@GUID("3050F407-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLTableEvents : IDispatch
{
}

@GUID("3050F23B-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTableSection : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_vAlign(BSTR v);
    HRESULT get_vAlign(BSTR* p);
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT get_rows(IHTMLElementCollection* p);
    HRESULT insertRow(int index, IDispatch* row);
    HRESULT deleteRow(int index);
}

@GUID("3050F21E-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTable : IDispatch
{
    HRESULT put_cols(int v);
    HRESULT get_cols(int* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_frame(BSTR v);
    HRESULT get_frame(BSTR* p);
    HRESULT put_rules(BSTR v);
    HRESULT get_rules(BSTR* p);
    HRESULT put_cellSpacing(VARIANT v);
    HRESULT get_cellSpacing(VARIANT* p);
    HRESULT put_cellPadding(VARIANT v);
    HRESULT get_cellPadding(VARIANT* p);
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT put_borderColor(VARIANT v);
    HRESULT get_borderColor(VARIANT* p);
    HRESULT put_borderColorLight(VARIANT v);
    HRESULT get_borderColorLight(VARIANT* p);
    HRESULT put_borderColorDark(VARIANT v);
    HRESULT get_borderColorDark(VARIANT* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT refresh();
    HRESULT get_rows(IHTMLElementCollection* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_dataPageSize(int v);
    HRESULT get_dataPageSize(int* p);
    HRESULT nextPage();
    HRESULT previousPage();
    HRESULT get_tHead(IHTMLTableSection* p);
    HRESULT get_tFoot(IHTMLTableSection* p);
    HRESULT get_tBodies(IHTMLElementCollection* p);
    HRESULT get_caption(IHTMLTableCaption* p);
    HRESULT createTHead(IDispatch* head);
    HRESULT deleteTHead();
    HRESULT createTFoot(IDispatch* foot);
    HRESULT deleteTFoot();
    HRESULT createCaption(IHTMLTableCaption* caption);
    HRESULT deleteCaption();
    HRESULT insertRow(int index, IDispatch* row);
    HRESULT deleteRow(int index);
    HRESULT get_readyState(BSTR* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
}

@GUID("3050F4AD-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTable2 : IDispatch
{
    HRESULT firstPage();
    HRESULT lastPage();
    HRESULT get_cells(IHTMLElementCollection* p);
    HRESULT moveRow(int indexFrom, int indexTo, IDispatch* row);
}

@GUID("3050F829-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTable3 : IDispatch
{
    HRESULT put_summary(BSTR v);
    HRESULT get_summary(BSTR* p);
}

@GUID("305106C2-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTable4 : IDispatch
{
    HRESULT putref_tHead(IHTMLTableSection v);
    HRESULT get_tHead(IHTMLTableSection* p);
    HRESULT putref_tFoot(IHTMLTableSection v);
    HRESULT get_tFoot(IHTMLTableSection* p);
    HRESULT putref_caption(IHTMLTableCaption v);
    HRESULT get_caption(IHTMLTableCaption* p);
    HRESULT insertRow(int index, IDispatch* row);
    HRESULT deleteRow(int index);
    HRESULT createTBody(IHTMLTableSection* tbody);
}

@GUID("3050F23A-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTableCol : IDispatch
{
    HRESULT put_span(int v);
    HRESULT get_span(int* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_vAlign(BSTR v);
    HRESULT get_vAlign(BSTR* p);
}

@GUID("3050F82A-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTableCol2 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
}

@GUID("305106C4-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTableCol3 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
}

@GUID("3050F5C7-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTableSection2 : IDispatch
{
    HRESULT moveRow(int indexFrom, int indexTo, IDispatch* row);
}

@GUID("3050F82B-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTableSection3 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
}

@GUID("305106C5-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTableSection4 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
    HRESULT insertRow(int index, IDispatch* row);
    HRESULT deleteRow(int index);
}

@GUID("3050F23C-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTableRow : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_vAlign(BSTR v);
    HRESULT get_vAlign(BSTR* p);
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT put_borderColor(VARIANT v);
    HRESULT get_borderColor(VARIANT* p);
    HRESULT put_borderColorLight(VARIANT v);
    HRESULT get_borderColorLight(VARIANT* p);
    HRESULT put_borderColorDark(VARIANT v);
    HRESULT get_borderColorDark(VARIANT* p);
    HRESULT get_rowIndex(int* p);
    HRESULT get_sectionRowIndex(int* p);
    HRESULT get_cells(IHTMLElementCollection* p);
    HRESULT insertCell(int index, IDispatch* row);
    HRESULT deleteCell(int index);
}

@GUID("3050F4A1-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTableRow2 : IDispatch
{
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
}

@GUID("3050F82C-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTableRow3 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
}

@GUID("305106C6-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTableRow4 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
    HRESULT insertCell(int index, IDispatch* row);
    HRESULT deleteCell(int index);
}

@GUID("3050F413-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTableRowMetrics : IDispatch
{
    HRESULT get_clientHeight(int* p);
    HRESULT get_clientWidth(int* p);
    HRESULT get_clientTop(int* p);
    HRESULT get_clientLeft(int* p);
}

@GUID("3050F23D-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTableCell : IDispatch
{
    HRESULT put_rowSpan(int v);
    HRESULT get_rowSpan(int* p);
    HRESULT put_colSpan(int v);
    HRESULT get_colSpan(int* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_vAlign(BSTR v);
    HRESULT get_vAlign(BSTR* p);
    HRESULT put_bgColor(VARIANT v);
    HRESULT get_bgColor(VARIANT* p);
    HRESULT put_noWrap(short v);
    HRESULT get_noWrap(short* p);
    HRESULT put_background(BSTR v);
    HRESULT get_background(BSTR* p);
    HRESULT put_borderColor(VARIANT v);
    HRESULT get_borderColor(VARIANT* p);
    HRESULT put_borderColorLight(VARIANT v);
    HRESULT get_borderColorLight(VARIANT* p);
    HRESULT put_borderColorDark(VARIANT v);
    HRESULT get_borderColorDark(VARIANT* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT get_cellIndex(int* p);
}

@GUID("3050F82D-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTableCell2 : IDispatch
{
    HRESULT put_abbr(BSTR v);
    HRESULT get_abbr(BSTR* p);
    HRESULT put_axis(BSTR v);
    HRESULT get_axis(BSTR* p);
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
    HRESULT put_headers(BSTR v);
    HRESULT get_headers(BSTR* p);
    HRESULT put_scope(BSTR v);
    HRESULT get_scope(BSTR* p);
}

@GUID("305106C7-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTableCell3 : IDispatch
{
    HRESULT put_ch(BSTR v);
    HRESULT get_ch(BSTR* p);
    HRESULT put_chOff(BSTR v);
    HRESULT get_chOff(BSTR* p);
}

@GUID("3050F532-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLTable : IDispatch
{
}

@GUID("3050F533-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLTableCol : IDispatch
{
}

@GUID("3050F534-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLTableSection : IDispatch
{
}

@GUID("3050F535-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLTableRow : IDispatch
{
}

@GUID("3050F536-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLTableCell : IDispatch
{
}

@GUID("3050F621-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLScriptEvents2 : IDispatch
{
}

@GUID("3050F3E2-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLScriptEvents : IDispatch
{
}

@GUID("3050F28B-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLScriptElement : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_htmlFor(BSTR v);
    HRESULT get_htmlFor(BSTR* p);
    HRESULT put_event(BSTR v);
    HRESULT get_event(BSTR* p);
    HRESULT put_text(BSTR v);
    HRESULT get_text(BSTR* p);
    HRESULT put_defer(short v);
    HRESULT get_defer(short* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
}

@GUID("3050F828-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLScriptElement2 : IDispatch
{
    HRESULT put_charset(BSTR v);
    HRESULT get_charset(BSTR* p);
}

@GUID("30510447-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLScriptElement3 : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
}

@GUID("30510801-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLScriptElement4 : IDispatch
{
    HRESULT get_usedCharset(BSTR* p);
}

@GUID("3050F530-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLScriptElement : IDispatch
{
}

@GUID("3050F38A-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLNoShowElement : IDispatch
{
}

@GUID("3050F528-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLNoShowElement : IDispatch
{
}

@GUID("3050F620-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLObjectElementEvents2 : IDispatch
{
}

@GUID("3050F3C4-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLObjectElementEvents : IDispatch
{
}

@GUID("3050F24F-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLObjectElement : IDispatch
{
    HRESULT get_object(IDispatch* p);
    HRESULT get_classid(BSTR* p);
    HRESULT get_data(BSTR* p);
    HRESULT putref_recordset(IDispatch v);
    HRESULT get_recordset(IDispatch* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_codeBase(BSTR v);
    HRESULT get_codeBase(BSTR* p);
    HRESULT put_codeType(BSTR v);
    HRESULT get_codeType(BSTR* p);
    HRESULT put_code(BSTR v);
    HRESULT get_code(BSTR* p);
    HRESULT get_BaseHref(BSTR* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT get_form(IHTMLFormElement* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT get_readyState(int* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_altHtml(BSTR v);
    HRESULT get_altHtml(BSTR* p);
    HRESULT put_vspace(int v);
    HRESULT get_vspace(int* p);
    HRESULT put_hspace(int v);
    HRESULT get_hspace(int* p);
}

@GUID("3050F4CD-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLObjectElement2 : IDispatch
{
    HRESULT namedRecordset(BSTR dataMember, VARIANT* hierarchy, IDispatch* ppRecordset);
    HRESULT put_classid(BSTR v);
    HRESULT get_classid(BSTR* p);
    HRESULT put_data(BSTR v);
    HRESULT get_data(BSTR* p);
}

@GUID("3050F827-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLObjectElement3 : IDispatch
{
    HRESULT put_archive(BSTR v);
    HRESULT get_archive(BSTR* p);
    HRESULT put_alt(BSTR v);
    HRESULT get_alt(BSTR* p);
    HRESULT put_declare(short v);
    HRESULT get_declare(short* p);
    HRESULT put_standby(BSTR v);
    HRESULT get_standby(BSTR* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_useMap(BSTR v);
    HRESULT get_useMap(BSTR* p);
}

@GUID("3051043E-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLObjectElement4 : IDispatch
{
    HRESULT get_contentDocument(IDispatch* p);
    HRESULT put_codeBase(BSTR v);
    HRESULT get_codeBase(BSTR* p);
    HRESULT put_data(BSTR v);
    HRESULT get_data(BSTR* p);
}

@GUID("305104B5-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLObjectElement5 : IDispatch
{
    HRESULT put_object(BSTR v);
    HRESULT get_object(BSTR* p);
}

@GUID("3050F83D-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLParamElement : IDispatch
{
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_valueType(BSTR v);
    HRESULT get_valueType(BSTR* p);
}

@GUID("30510444-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLParamElement2 : IDispatch
{
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_value(BSTR v);
    HRESULT get_value(BSTR* p);
    HRESULT put_valueType(BSTR v);
    HRESULT get_valueType(BSTR* p);
}

@GUID("3050F529-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLObjectElement : IDispatch
{
}

@GUID("3050F590-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLParamElement : IDispatch
{
}

@GUID("3050F7FF-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLFrameSiteEvents2 : IDispatch
{
}

@GUID("3050F800-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLFrameSiteEvents : IDispatch
{
}

@GUID("3050F6DB-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLFrameBase2 : IDispatch
{
    HRESULT get_contentWindow(IHTMLWindow2* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT put_allowTransparency(short v);
    HRESULT get_allowTransparency(short* p);
}

@GUID("3050F82E-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLFrameBase3 : IDispatch
{
    HRESULT put_longDesc(BSTR v);
    HRESULT get_longDesc(BSTR* p);
}

@GUID("3050F541-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLFrameBase : IDispatch
{
}

@GUID("3050F313-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLFrameElement : IDispatch
{
    HRESULT put_borderColor(VARIANT v);
    HRESULT get_borderColor(VARIANT* p);
}

@GUID("3050F7F5-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLFrameElement2 : IDispatch
{
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
}

@GUID("3051042D-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLFrameElement3 : IDispatch
{
    HRESULT get_contentDocument(IDispatch* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_longDesc(BSTR v);
    HRESULT get_longDesc(BSTR* p);
    HRESULT put_frameBorder(BSTR v);
    HRESULT get_frameBorder(BSTR* p);
}

@GUID("3050F513-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLFrameElement : IDispatch
{
}

@GUID("3050F315-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLIFrameElement : IDispatch
{
    HRESULT put_vspace(int v);
    HRESULT get_vspace(int* p);
    HRESULT put_hspace(int v);
    HRESULT get_hspace(int* p);
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

@GUID("3050F4E6-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLIFrameElement2 : IDispatch
{
    HRESULT put_height(VARIANT v);
    HRESULT get_height(VARIANT* p);
    HRESULT put_width(VARIANT v);
    HRESULT get_width(VARIANT* p);
}

@GUID("30510433-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLIFrameElement3 : IDispatch
{
    HRESULT get_contentDocument(IDispatch* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_longDesc(BSTR v);
    HRESULT get_longDesc(BSTR* p);
    HRESULT put_frameBorder(BSTR v);
    HRESULT get_frameBorder(BSTR* p);
}

@GUID("3050F51B-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLIFrame : IDispatch
{
}

@GUID("3050F212-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDivPosition : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

@GUID("3050F3E7-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLFieldSetElement : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

@GUID("3050F833-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLFieldSetElement2 : IDispatch
{
    HRESULT get_form(IHTMLFormElement* p);
}

@GUID("3050F3EA-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLLegendElement : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

@GUID("3050F834-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLLegendElement2 : IDispatch
{
    HRESULT get_form(IHTMLFormElement* p);
}

@GUID("3050F50F-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLDivPosition : IDispatch
{
}

@GUID("3050F545-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLFieldSetElement : IDispatch
{
}

@GUID("3050F546-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLLegendElement : IDispatch
{
}

@GUID("3050F3E5-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLSpanFlow : IDispatch
{
    HRESULT put_align(BSTR v);
    HRESULT get_align(BSTR* p);
}

@GUID("3050F544-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLSpanFlow : IDispatch
{
}

@GUID("3050F319-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLFrameSetElement : IDispatch
{
    HRESULT put_rows(BSTR v);
    HRESULT get_rows(BSTR* p);
    HRESULT put_cols(BSTR v);
    HRESULT get_cols(BSTR* p);
    HRESULT put_border(VARIANT v);
    HRESULT get_border(VARIANT* p);
    HRESULT put_borderColor(VARIANT v);
    HRESULT get_borderColor(VARIANT* p);
    HRESULT put_frameBorder(BSTR v);
    HRESULT get_frameBorder(BSTR* p);
    HRESULT put_frameSpacing(VARIANT v);
    HRESULT get_frameSpacing(VARIANT* p);
    HRESULT put_name(BSTR v);
    HRESULT get_name(BSTR* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onunload(VARIANT v);
    HRESULT get_onunload(VARIANT* p);
    HRESULT put_onbeforeunload(VARIANT v);
    HRESULT get_onbeforeunload(VARIANT* p);
}

@GUID("3050F5C6-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLFrameSetElement2 : IDispatch
{
    HRESULT put_onbeforeprint(VARIANT v);
    HRESULT get_onbeforeprint(VARIANT* p);
    HRESULT put_onafterprint(VARIANT v);
    HRESULT get_onafterprint(VARIANT* p);
}

@GUID("30510796-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLFrameSetElement3 : IDispatch
{
    HRESULT put_onhashchange(VARIANT v);
    HRESULT get_onhashchange(VARIANT* p);
    HRESULT put_onmessage(VARIANT v);
    HRESULT get_onmessage(VARIANT* p);
    HRESULT put_onoffline(VARIANT v);
    HRESULT get_onoffline(VARIANT* p);
    HRESULT put_ononline(VARIANT v);
    HRESULT get_ononline(VARIANT* p);
    HRESULT put_onstorage(VARIANT v);
    HRESULT get_onstorage(VARIANT* p);
}

@GUID("3050F514-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLFrameSetSite : IDispatch
{
}

@GUID("3050F369-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLBGsound : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_loop(VARIANT v);
    HRESULT get_loop(VARIANT* p);
    HRESULT put_volume(VARIANT v);
    HRESULT get_volume(VARIANT* p);
    HRESULT put_balance(VARIANT v);
    HRESULT get_balance(VARIANT* p);
}

@GUID("3050F53C-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLBGsound : IDispatch
{
}

@GUID("3050F376-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLFontNamesCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(int index, BSTR* pBstr);
}

@GUID("3050F377-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLFontSizesCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT get_forFont(BSTR* p);
    HRESULT item(int index, int* plSize);
}

@GUID("3050F378-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLOptionsHolder : IDispatch
{
    HRESULT get_document(IHTMLDocument2* p);
    HRESULT get_fonts(IHTMLFontNamesCollection* p);
    HRESULT put_execArg(VARIANT v);
    HRESULT get_execArg(VARIANT* p);
    HRESULT put_errorLine(int v);
    HRESULT get_errorLine(int* p);
    HRESULT put_errorCharacter(int v);
    HRESULT get_errorCharacter(int* p);
    HRESULT put_errorCode(int v);
    HRESULT get_errorCode(int* p);
    HRESULT put_errorMessage(BSTR v);
    HRESULT get_errorMessage(BSTR* p);
    HRESULT put_errorDebug(short v);
    HRESULT get_errorDebug(short* p);
    HRESULT get_unsecuredWindowOfDocument(IHTMLWindow2* p);
    HRESULT put_findText(BSTR v);
    HRESULT get_findText(BSTR* p);
    HRESULT put_anythingAfterFrameset(short v);
    HRESULT get_anythingAfterFrameset(short* p);
    HRESULT sizes(BSTR fontName, IHTMLFontSizesCollection* pSizesCollection);
    HRESULT openfiledlg(VARIANT initFile, VARIANT initDir, VARIANT filter, VARIANT title, BSTR* pathName);
    HRESULT savefiledlg(VARIANT initFile, VARIANT initDir, VARIANT filter, VARIANT title, BSTR* pathName);
    HRESULT choosecolordlg(VARIANT initColor, int* rgbColor);
    HRESULT showSecurityInfo();
    HRESULT isApartmentModel(IHTMLObjectElement object, short* fApartment);
    HRESULT getCharset(BSTR fontName, int* charset);
    HRESULT get_secureConnectionInfo(BSTR* p);
}

@GUID("3050F615-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLStyleElementEvents2 : IDispatch
{
}

@GUID("3050F3CB-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLStyleElementEvents : IDispatch
{
}

@GUID("3050F375-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleElement : IDispatch
{
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT get_readyState(BSTR* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT get_styleSheet(IHTMLStyleSheet* p);
    HRESULT put_disabled(short v);
    HRESULT get_disabled(short* p);
    HRESULT put_media(BSTR v);
    HRESULT get_media(BSTR* p);
}

@GUID("3051072A-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleElement2 : IDispatch
{
    HRESULT get_sheet(IHTMLStyleSheet* p);
}

@GUID("3050F511-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLStyleElement : IDispatch
{
}

@GUID("3050F3D5-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleFontFace : IDispatch
{
    HRESULT put_fontsrc(BSTR v);
    HRESULT get_fontsrc(BSTR* p);
}

@GUID("305106EC-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleFontFace2 : IDispatch
{
    HRESULT get_style(IHTMLRuleStyle* p);
}

@GUID("30590081-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLStyleFontFace : IDispatch
{
}

@GUID("30510454-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLXDomainRequest : IDispatch
{
    HRESULT get_responseText(BSTR* p);
    HRESULT put_timeout(int v);
    HRESULT get_timeout(int* p);
    HRESULT get_contentType(BSTR* p);
    HRESULT put_onprogress(VARIANT v);
    HRESULT get_onprogress(VARIANT* p);
    HRESULT put_onerror(VARIANT v);
    HRESULT get_onerror(VARIANT* p);
    HRESULT put_ontimeout(VARIANT v);
    HRESULT get_ontimeout(VARIANT* p);
    HRESULT put_onload(VARIANT v);
    HRESULT get_onload(VARIANT* p);
    HRESULT abort();
    HRESULT open(BSTR bstrMethod, BSTR bstrUrl);
    HRESULT send(VARIANT varBody);
}

@GUID("30510456-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLXDomainRequestFactory : IDispatch
{
    HRESULT create(IHTMLXDomainRequest* __MIDL__IHTMLXDomainRequestFactory0000);
}

@GUID("3050F599-98B5-11CF-BB82-00AA00BDCE0B")
interface DispXDomainRequest : IDispatch
{
}

@GUID("30510799-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStorage2 : IDispatch
{
    HRESULT setItem(BSTR bstrKey, BSTR bstrValue);
}

@GUID("3050F59D-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLStorage : IDispatch
{
}

@GUID("305104B9-98B5-11CF-BB82-00AA00BDCE0B")
interface IEventTarget : IDispatch
{
    HRESULT addEventListener(BSTR type, IDispatch listener, short useCapture);
    HRESULT removeEventListener(BSTR type, IDispatch listener, short useCapture);
    HRESULT dispatchEvent(IDOMEvent evt, short* pfResult);
}

@GUID("3050F5A2-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMEvent : IDispatch
{
}

@GUID("305106CA-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMUIEvent : IDispatch
{
    HRESULT get_view(IHTMLWindow2* p);
    HRESULT get_detail(int* p);
    HRESULT initUIEvent(BSTR eventType, short canBubble, short cancelable, IHTMLWindow2 view, int detail);
}

@GUID("30590072-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMUIEvent : IDispatch
{
}

@GUID("305106CE-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMMouseEvent : IDispatch
{
    HRESULT get_screenX(int* p);
    HRESULT get_screenY(int* p);
    HRESULT get_clientX(int* p);
    HRESULT get_clientY(int* p);
    HRESULT get_ctrlKey(short* p);
    HRESULT get_shiftKey(short* p);
    HRESULT get_altKey(short* p);
    HRESULT get_metaKey(short* p);
    HRESULT get_button(ushort* p);
    HRESULT get_relatedTarget(IEventTarget* p);
    HRESULT initMouseEvent(BSTR eventType, short canBubble, short cancelable, IHTMLWindow2 viewArg, int detailArg, 
                           int screenXArg, int screenYArg, int clientXArg, int clientYArg, short ctrlKeyArg, 
                           short altKeyArg, short shiftKeyArg, short metaKeyArg, ushort buttonArg, 
                           IEventTarget relatedTargetArg);
    HRESULT getModifierState(BSTR keyArg, short* activated);
    HRESULT get_buttons(ushort* p);
    HRESULT get_fromElement(IHTMLElement* p);
    HRESULT get_toElement(IHTMLElement* p);
    HRESULT get_x(int* p);
    HRESULT get_y(int* p);
    HRESULT get_offsetX(int* p);
    HRESULT get_offsetY(int* p);
    HRESULT get_pageX(int* p);
    HRESULT get_pageY(int* p);
    HRESULT get_layerX(int* p);
    HRESULT get_layerY(int* p);
    HRESULT get_which(ushort* p);
}

@GUID("30590073-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMMouseEvent : IDispatch
{
}

@GUID("30510761-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMDragEvent : IDispatch
{
    HRESULT get_dataTransfer(IHTMLDataTransfer* p);
    HRESULT initDragEvent(BSTR eventType, short canBubble, short cancelable, IHTMLWindow2 viewArg, int detailArg, 
                          int screenXArg, int screenYArg, int clientXArg, int clientYArg, short ctrlKeyArg, 
                          short altKeyArg, short shiftKeyArg, short metaKeyArg, ushort buttonArg, 
                          IEventTarget relatedTargetArg, IHTMLDataTransfer dataTransferArg);
}

@GUID("305900A7-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMDragEvent : IDispatch
{
}

@GUID("305106D0-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMMouseWheelEvent : IDispatch
{
    HRESULT get_wheelDelta(int* p);
    HRESULT initMouseWheelEvent(BSTR eventType, short canBubble, short cancelable, IHTMLWindow2 viewArg, 
                                int detailArg, int screenXArg, int screenYArg, int clientXArg, int clientYArg, 
                                ushort buttonArg, IEventTarget relatedTargetArg, BSTR modifiersListArg, 
                                int wheelDeltaArg);
}

@GUID("30590074-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMMouseWheelEvent : IDispatch
{
}

@GUID("305106D2-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMWheelEvent : IDispatch
{
    HRESULT get_deltaX(int* p);
    HRESULT get_deltaY(int* p);
    HRESULT get_deltaZ(int* p);
    HRESULT get_deltaMode(uint* p);
    HRESULT initWheelEvent(BSTR eventType, short canBubble, short cancelable, IHTMLWindow2 viewArg, int detailArg, 
                           int screenXArg, int screenYArg, int clientXArg, int clientYArg, ushort buttonArg, 
                           IEventTarget relatedTargetArg, BSTR modifiersListArg, int deltaX, int deltaY, int deltaZ, 
                           uint deltaMode);
}

@GUID("30590075-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMWheelEvent : IDispatch
{
}

@GUID("305106D4-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMTextEvent : IDispatch
{
    HRESULT get_data(BSTR* p);
    HRESULT get_inputMethod(uint* p);
    HRESULT initTextEvent(BSTR eventType, short canBubble, short cancelable, IHTMLWindow2 viewArg, BSTR dataArg, 
                          uint inputMethod, BSTR locale);
    HRESULT get_locale(BSTR* p);
}

@GUID("30590076-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMTextEvent : IDispatch
{
}

@GUID("305106D6-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMKeyboardEvent : IDispatch
{
    HRESULT get_key(BSTR* p);
    HRESULT get_location(uint* p);
    HRESULT get_ctrlKey(short* p);
    HRESULT get_shiftKey(short* p);
    HRESULT get_altKey(short* p);
    HRESULT get_metaKey(short* p);
    HRESULT get_repeat(short* p);
    HRESULT getModifierState(BSTR keyArg, short* state);
    HRESULT initKeyboardEvent(BSTR eventType, short canBubble, short cancelable, IHTMLWindow2 viewArg, BSTR keyArg, 
                              uint locationArg, BSTR modifiersListArg, short repeat, BSTR locale);
    HRESULT get_keyCode(int* p);
    HRESULT get_charCode(int* p);
    HRESULT get_which(int* p);
    HRESULT get_ie9_char(VARIANT* p);
    HRESULT get_locale(BSTR* p);
}

@GUID("30590077-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMKeyboardEvent : IDispatch
{
}

@GUID("305106D8-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMCompositionEvent : IDispatch
{
    HRESULT get_data(BSTR* p);
    HRESULT initCompositionEvent(BSTR eventType, short canBubble, short cancelable, IHTMLWindow2 viewArg, 
                                 BSTR data, BSTR locale);
    HRESULT get_locale(BSTR* p);
}

@GUID("30590078-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMCompositionEvent : IDispatch
{
}

@GUID("305106DA-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMMutationEvent : IDispatch
{
    HRESULT get_relatedNode(IDispatch* p);
    HRESULT get_prevValue(BSTR* p);
    HRESULT get_newValue(BSTR* p);
    HRESULT get_attrName(BSTR* p);
    HRESULT get_attrChange(ushort* p);
    HRESULT initMutationEvent(BSTR eventType, short canBubble, short cancelable, IDispatch relatedNodeArg, 
                              BSTR prevValueArg, BSTR newValueArg, BSTR attrNameArg, ushort attrChangeArg);
}

@GUID("30590079-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMMutationEvent : IDispatch
{
}

@GUID("30510763-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMBeforeUnloadEvent : IDispatch
{
    HRESULT put_returnValue(VARIANT v);
    HRESULT get_returnValue(VARIANT* p);
}

@GUID("305900A8-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMBeforeUnloadEvent : IDispatch
{
}

@GUID("305106CC-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMFocusEvent : IDispatch
{
    HRESULT get_relatedTarget(IEventTarget* p);
    HRESULT initFocusEvent(BSTR eventType, short canBubble, short cancelable, IHTMLWindow2 view, int detail, 
                           IEventTarget relatedTargetArg);
}

@GUID("30590071-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMFocusEvent : IDispatch
{
}

@GUID("305106DE-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMCustomEvent : IDispatch
{
    HRESULT get_detail(VARIANT* p);
    HRESULT initCustomEvent(BSTR eventType, short canBubble, short cancelable, VARIANT* detail);
}

@GUID("3059007C-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMCustomEvent : IDispatch
{
}

@GUID("30510714-98B5-11CF-BB82-00AA00BDCE0B")
interface ICanvasGradient : IDispatch
{
    HRESULT addColorStop(float offset, BSTR color);
}

@GUID("30510716-98B5-11CF-BB82-00AA00BDCE0B")
interface ICanvasPattern : IDispatch
{
}

@GUID("30510718-98B5-11CF-BB82-00AA00BDCE0B")
interface ICanvasTextMetrics : IDispatch
{
    HRESULT get_width(float* p);
}

@GUID("3051071A-98B5-11CF-BB82-00AA00BDCE0B")
interface ICanvasImageData : IDispatch
{
    HRESULT get_width(uint* p);
    HRESULT get_height(uint* p);
    HRESULT get_data(VARIANT* p);
}

@GUID("3051071C-98B5-11CF-BB82-00AA00BDCE0B")
interface ICanvasPixelArray : IDispatch
{
    HRESULT get_length(uint* p);
}

@GUID("305106E4-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLCanvasElement : IDispatch
{
    HRESULT put_width(int v);
    HRESULT get_width(int* p);
    HRESULT put_height(int v);
    HRESULT get_height(int* p);
    HRESULT getContext(BSTR contextId, ICanvasRenderingContext2D* ppContext);
    HRESULT toDataURL(BSTR type, VARIANT jpegquality, BSTR* pUrl);
}

@GUID("305106FF-98B5-11CF-BB82-00AA00BDCE0B")
interface ICanvasRenderingContext2D : IDispatch
{
    HRESULT get_canvas(IHTMLCanvasElement* p);
    HRESULT restore();
    HRESULT save();
    HRESULT rotate(float angle);
    HRESULT scale(float x, float y);
    HRESULT setTransform(float m11, float m12, float m21, float m22, float dx, float dy);
    HRESULT transform(float m11, float m12, float m21, float m22, float dx, float dy);
    HRESULT translate(float x, float y);
    HRESULT put_globalAlpha(float v);
    HRESULT get_globalAlpha(float* p);
    HRESULT put_globalCompositeOperation(BSTR v);
    HRESULT get_globalCompositeOperation(BSTR* p);
    HRESULT put_fillStyle(VARIANT v);
    HRESULT get_fillStyle(VARIANT* p);
    HRESULT put_strokeStyle(VARIANT v);
    HRESULT get_strokeStyle(VARIANT* p);
    HRESULT createLinearGradient(float x0, float y0, float x1, float y1, ICanvasGradient* ppCanvasGradient);
    HRESULT createRadialGradient(float x0, float y0, float r0, float x1, float y1, float r1, 
                                 ICanvasGradient* ppCanvasGradient);
    HRESULT createPattern(IDispatch image, VARIANT repetition, ICanvasPattern* ppCanvasPattern);
    HRESULT put_lineCap(BSTR v);
    HRESULT get_lineCap(BSTR* p);
    HRESULT put_lineJoin(BSTR v);
    HRESULT get_lineJoin(BSTR* p);
    HRESULT put_lineWidth(float v);
    HRESULT get_lineWidth(float* p);
    HRESULT put_miterLimit(float v);
    HRESULT get_miterLimit(float* p);
    HRESULT put_shadowBlur(float v);
    HRESULT get_shadowBlur(float* p);
    HRESULT put_shadowColor(BSTR v);
    HRESULT get_shadowColor(BSTR* p);
    HRESULT put_shadowOffsetX(float v);
    HRESULT get_shadowOffsetX(float* p);
    HRESULT put_shadowOffsetY(float v);
    HRESULT get_shadowOffsetY(float* p);
    HRESULT clearRect(float x, float y, float w, float h);
    HRESULT fillRect(float x, float y, float w, float h);
    HRESULT strokeRect(float x, float y, float w, float h);
    HRESULT arc(float x, float y, float radius, float startAngle, float endAngle, BOOL anticlockwise);
    HRESULT arcTo(float x1, float y1, float x2, float y2, float radius);
    HRESULT beginPath();
    HRESULT bezierCurveTo(float cp1x, float cp1y, float cp2x, float cp2y, float x, float y);
    HRESULT clip();
    HRESULT closePath();
    HRESULT fill();
    HRESULT lineTo(float x, float y);
    HRESULT moveTo(float x, float y);
    HRESULT quadraticCurveTo(float cpx, float cpy, float x, float y);
    HRESULT rect(float x, float y, float w, float h);
    HRESULT stroke();
    HRESULT isPointInPath(float x, float y, short* pResult);
    HRESULT put_font(BSTR v);
    HRESULT get_font(BSTR* p);
    HRESULT put_textAlign(BSTR v);
    HRESULT get_textAlign(BSTR* p);
    HRESULT put_textBaseline(BSTR v);
    HRESULT get_textBaseline(BSTR* p);
    HRESULT fillText(BSTR text, float x, float y, VARIANT maxWidth);
    HRESULT measureText(BSTR text, ICanvasTextMetrics* ppCanvasTextMetrics);
    HRESULT strokeText(BSTR text, float x, float y, VARIANT maxWidth);
    HRESULT drawImage(IDispatch pSrc, VARIANT a1, VARIANT a2, VARIANT a3, VARIANT a4, VARIANT a5, VARIANT a6, 
                      VARIANT a7, VARIANT a8);
    HRESULT createImageData(VARIANT a1, VARIANT a2, ICanvasImageData* ppCanvasImageData);
    HRESULT getImageData(float sx, float sy, float sw, float sh, ICanvasImageData* ppCanvasImageData);
    HRESULT putImageData(ICanvasImageData imagedata, float dx, float dy, VARIANT dirtyX, VARIANT dirtyY, 
                         VARIANT dirtyWidth, VARIANT dirtyHeight);
}

@GUID("3059008C-98B5-11CF-BB82-00AA00BDCE0B")
interface DispCanvasGradient : IDispatch
{
}

@GUID("3059008D-98B5-11CF-BB82-00AA00BDCE0B")
interface DispCanvasPattern : IDispatch
{
}

@GUID("3059008E-98B5-11CF-BB82-00AA00BDCE0B")
interface DispCanvasTextMetrics : IDispatch
{
}

@GUID("3059008F-98B5-11CF-BB82-00AA00BDCE0B")
interface DispCanvasImageData : IDispatch
{
}

@GUID("30590082-98B5-11CF-BB82-00AA00BDCE0B")
interface DispCanvasRenderingContext2D : IDispatch
{
}

@GUID("3059007B-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLCanvasElement : IDispatch
{
}

@GUID("3051071E-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMProgressEvent : IDispatch
{
    HRESULT get_lengthComputable(short* p);
    HRESULT get_loaded(ulong* p);
    HRESULT get_total(ulong* p);
    HRESULT initProgressEvent(BSTR eventType, short canBubble, short cancelable, short lengthComputableArg, 
                              ulong loadedArg, ulong totalArg);
}

@GUID("30590091-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMProgressEvent : IDispatch
{
}

@GUID("30510720-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMMessageEvent : IDispatch
{
    HRESULT get_data(BSTR* p);
    HRESULT get_origin(BSTR* p);
    HRESULT get_source(IHTMLWindow2* p);
    HRESULT initMessageEvent(BSTR eventType, short canBubble, short cancelable, BSTR data, BSTR origin, 
                             BSTR lastEventId, IHTMLWindow2 source);
}

@GUID("30590092-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMMessageEvent : IDispatch
{
}

@GUID("30510765-98B6-11CF-BB82-00AA00BDCE0B")
interface IDOMSiteModeEvent : IDispatch
{
    HRESULT get_buttonID(int* p);
    HRESULT get_actionURL(BSTR* p);
}

@GUID("305900A9-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMSiteModeEvent : IDispatch
{
}

@GUID("30510722-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMStorageEvent : IDispatch
{
    HRESULT get_key(BSTR* p);
    HRESULT get_oldValue(BSTR* p);
    HRESULT get_newValue(BSTR* p);
    HRESULT get_url(BSTR* p);
    HRESULT get_storageArea(IHTMLStorage* p);
    HRESULT initStorageEvent(BSTR eventType, short canBubble, short cancelable, BSTR keyArg, BSTR oldValueArg, 
                             BSTR newValueArg, BSTR urlArg, IHTMLStorage storageAreaArg);
}

@GUID("30590093-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMStorageEvent : IDispatch
{
}

@GUID("30510830-98B5-11CF-BB82-00AA00BDCE0B")
interface IXMLHttpRequestEventTarget : IDispatch
{
}

@GUID("305900E7-98B5-11CF-BB82-00AA00BDCE0B")
interface DispXMLHttpRequestEventTarget : IDispatch
{
}

@GUID("30510498-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLXMLHttpRequestEvents : IDispatch
{
}

@GUID("3051040A-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLXMLHttpRequest : IDispatch
{
    HRESULT get_readyState(int* p);
    HRESULT get_responseBody(VARIANT* p);
    HRESULT get_responseText(BSTR* p);
    HRESULT get_responseXML(IDispatch* p);
    HRESULT get_status(int* p);
    HRESULT get_statusText(BSTR* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT abort();
    HRESULT open(BSTR bstrMethod, BSTR bstrUrl, VARIANT varAsync, VARIANT varUser, VARIANT varPassword);
    HRESULT send(VARIANT varBody);
    HRESULT getAllResponseHeaders(BSTR* __MIDL__IHTMLXMLHttpRequest0000);
    HRESULT getResponseHeader(BSTR bstrHeader, BSTR* __MIDL__IHTMLXMLHttpRequest0001);
    HRESULT setRequestHeader(BSTR bstrHeader, BSTR bstrValue);
}

@GUID("30510482-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLXMLHttpRequest2 : IDispatch
{
    HRESULT put_timeout(int v);
    HRESULT get_timeout(int* p);
    HRESULT put_ontimeout(VARIANT v);
    HRESULT get_ontimeout(VARIANT* p);
}

@GUID("3051040C-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLXMLHttpRequestFactory : IDispatch
{
    HRESULT create(IHTMLXMLHttpRequest* __MIDL__IHTMLXMLHttpRequestFactory0000);
}

@GUID("3050F596-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLXMLHttpRequest : IDispatch
{
}

@GUID("305104D3-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGAngle : IDispatch
{
    HRESULT put_unitType(short v);
    HRESULT get_unitType(short* p);
    HRESULT put_value(float v);
    HRESULT get_value(float* p);
    HRESULT put_valueInSpecifiedUnits(float v);
    HRESULT get_valueInSpecifiedUnits(float* p);
    HRESULT put_valueAsString(BSTR v);
    HRESULT get_valueAsString(BSTR* p);
    HRESULT newValueSpecifiedUnits(short unitType, float valueInSpecifiedUnits);
    HRESULT convertToSpecifiedUnits(short unitType);
}

@GUID("305104C5-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGElement : IDispatch
{
    HRESULT put_xmlbase(BSTR v);
    HRESULT get_xmlbase(BSTR* p);
    HRESULT putref_ownerSVGElement(ISVGSVGElement v);
    HRESULT get_ownerSVGElement(ISVGSVGElement* p);
    HRESULT putref_viewportElement(ISVGElement v);
    HRESULT get_viewportElement(ISVGElement* p);
    HRESULT putref_focusable(ISVGAnimatedEnumeration v);
    HRESULT get_focusable(ISVGAnimatedEnumeration* p);
}

@GUID("305104D7-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGRect : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_width(float v);
    HRESULT get_width(float* p);
    HRESULT put_height(float v);
    HRESULT get_height(float* p);
}

@GUID("305104F6-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGMatrix : IDispatch
{
    HRESULT put_a(float v);
    HRESULT get_a(float* p);
    HRESULT put_b(float v);
    HRESULT get_b(float* p);
    HRESULT put_c(float v);
    HRESULT get_c(float* p);
    HRESULT put_d(float v);
    HRESULT get_d(float* p);
    HRESULT put_e(float v);
    HRESULT get_e(float* p);
    HRESULT put_f(float v);
    HRESULT get_f(float* p);
    HRESULT multiply(ISVGMatrix secondMatrix, ISVGMatrix* ppResult);
    HRESULT inverse(ISVGMatrix* ppResult);
    HRESULT translate(float x, float y, ISVGMatrix* ppResult);
    HRESULT scale(float scaleFactor, ISVGMatrix* ppResult);
    HRESULT scaleNonUniform(float scaleFactorX, float scaleFactorY, ISVGMatrix* ppResult);
    HRESULT rotate(float angle, ISVGMatrix* ppResult);
    HRESULT rotateFromVector(float x, float y, ISVGMatrix* ppResult);
    HRESULT flipX(ISVGMatrix* ppResult);
    HRESULT flipY(ISVGMatrix* ppResult);
    HRESULT skewX(float angle, ISVGMatrix* ppResult);
    HRESULT skewY(float angle, ISVGMatrix* ppResult);
}

@GUID("305104C8-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGStringList : IDispatch
{
    HRESULT put_numberOfItems(int v);
    HRESULT get_numberOfItems(int* p);
    HRESULT clear();
    HRESULT initialize(BSTR newItem, BSTR* ppResult);
    HRESULT getItem(int index, BSTR* ppResult);
    HRESULT insertItemBefore(BSTR newItem, int index, BSTR* ppResult);
    HRESULT replaceItem(BSTR newItem, int index, BSTR* ppResult);
    HRESULT removeItem(int index, BSTR* ppResult);
    HRESULT appendItem(BSTR newItem, BSTR* ppResult);
}

@GUID("305104D8-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGAnimatedRect : IDispatch
{
    HRESULT putref_baseVal(ISVGRect v);
    HRESULT get_baseVal(ISVGRect* p);
    HRESULT putref_animVal(ISVGRect v);
    HRESULT get_animVal(ISVGRect* p);
}

@GUID("305104C7-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGAnimatedString : IDispatch
{
    HRESULT put_baseVal(BSTR v);
    HRESULT get_baseVal(BSTR* p);
    HRESULT get_animVal(BSTR* p);
}

@GUID("305104C6-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGAnimatedBoolean : IDispatch
{
    HRESULT put_baseVal(short v);
    HRESULT get_baseVal(short* p);
    HRESULT put_animVal(short v);
    HRESULT get_animVal(short* p);
}

@GUID("305104F9-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGAnimatedTransformList : IDispatch
{
    HRESULT putref_baseVal(ISVGTransformList v);
    HRESULT get_baseVal(ISVGTransformList* p);
    HRESULT putref_animVal(ISVGTransformList v);
    HRESULT get_animVal(ISVGTransformList* p);
}

@GUID("305104FB-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGAnimatedPreserveAspectRatio : IDispatch
{
    HRESULT putref_baseVal(ISVGPreserveAspectRatio v);
    HRESULT get_baseVal(ISVGPreserveAspectRatio* p);
    HRESULT putref_animVal(ISVGPreserveAspectRatio v);
    HRESULT get_animVal(ISVGPreserveAspectRatio* p);
}

@GUID("305104DA-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGStylable : IDispatch
{
    HRESULT get_className(ISVGAnimatedString* p);
}

@GUID("305104DB-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGLocatable : IDispatch
{
    HRESULT get_nearestViewportElement(ISVGElement* p);
    HRESULT get_farthestViewportElement(ISVGElement* p);
    HRESULT getBBox(ISVGRect* ppResult);
    HRESULT getCTM(ISVGMatrix* ppResult);
    HRESULT getScreenCTM(ISVGMatrix* ppResult);
    HRESULT getTransformToElement(ISVGElement pElement, ISVGMatrix* ppResult);
}

@GUID("305104DC-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGTransformable : IDispatch
{
    HRESULT get_transform(ISVGAnimatedTransformList* p);
}

@GUID("305104DD-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGTests : IDispatch
{
    HRESULT get_requiredFeatures(ISVGStringList* p);
    HRESULT get_requiredExtensions(ISVGStringList* p);
    HRESULT get_systemLanguage(ISVGStringList* p);
    HRESULT hasExtension(BSTR extension, short* pResult);
}

@GUID("305104DE-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGLangSpace : IDispatch
{
    HRESULT put_xmllang(BSTR v);
    HRESULT get_xmllang(BSTR* p);
    HRESULT put_xmlspace(BSTR v);
    HRESULT get_xmlspace(BSTR* p);
}

@GUID("305104DF-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGExternalResourcesRequired : IDispatch
{
    HRESULT get_externalResourcesRequired(ISVGAnimatedBoolean* p);
}

@GUID("305104E0-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGFitToViewBox : IDispatch
{
    HRESULT get_viewBox(ISVGAnimatedRect* p);
    HRESULT putref_preserveAspectRatio(ISVGAnimatedPreserveAspectRatio v);
    HRESULT get_preserveAspectRatio(ISVGAnimatedPreserveAspectRatio* p);
}

@GUID("305104E1-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGZoomAndPan : IDispatch
{
    HRESULT get_zoomAndPan(short* p);
}

@GUID("305104E3-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGURIReference : IDispatch
{
    HRESULT get_href(ISVGAnimatedString* p);
}

@GUID("305104D4-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGAnimatedAngle : IDispatch
{
    HRESULT putref_baseVal(ISVGAngle v);
    HRESULT get_baseVal(ISVGAngle* p);
    HRESULT putref_animVal(ISVGAngle v);
    HRESULT get_animVal(ISVGAngle* p);
}

@GUID("305104F8-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGTransformList : IDispatch
{
    HRESULT put_numberOfItems(int v);
    HRESULT get_numberOfItems(int* p);
    HRESULT clear();
    HRESULT initialize(ISVGTransform newItem, ISVGTransform* ppResult);
    HRESULT getItem(int index, ISVGTransform* ppResult);
    HRESULT insertItemBefore(ISVGTransform newItem, int index, ISVGTransform* ppResult);
    HRESULT replaceItem(ISVGTransform newItem, int index, ISVGTransform* ppResult);
    HRESULT removeItem(int index, ISVGTransform* ppResult);
    HRESULT appendItem(ISVGTransform newItem, ISVGTransform* ppResult);
    HRESULT createSVGTransformFromMatrix(ISVGMatrix newItem, ISVGTransform* ppResult);
    HRESULT consolidate(ISVGTransform* ppResult);
}

@GUID("305104C9-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGAnimatedEnumeration : IDispatch
{
    HRESULT put_baseVal(ushort v);
    HRESULT get_baseVal(ushort* p);
    HRESULT put_animVal(ushort v);
    HRESULT get_animVal(ushort* p);
}

@GUID("305104CA-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGAnimatedInteger : IDispatch
{
    HRESULT put_baseVal(int v);
    HRESULT get_baseVal(int* p);
    HRESULT put_animVal(int v);
    HRESULT get_animVal(int* p);
}

@GUID("305104CF-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGLength : IDispatch
{
    HRESULT put_unitType(short v);
    HRESULT get_unitType(short* p);
    HRESULT put_value(float v);
    HRESULT get_value(float* p);
    HRESULT put_valueInSpecifiedUnits(float v);
    HRESULT get_valueInSpecifiedUnits(float* p);
    HRESULT put_valueAsString(BSTR v);
    HRESULT get_valueAsString(BSTR* p);
    HRESULT newValueSpecifiedUnits(short unitType, float valueInSpecifiedUnits);
    HRESULT convertToSpecifiedUnits(short unitType);
}

@GUID("305104D0-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGAnimatedLength : IDispatch
{
    HRESULT putref_baseVal(ISVGLength v);
    HRESULT get_baseVal(ISVGLength* p);
    HRESULT putref_animVal(ISVGLength v);
    HRESULT get_animVal(ISVGLength* p);
}

@GUID("305104D1-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGLengthList : IDispatch
{
    HRESULT put_numberOfItems(int v);
    HRESULT get_numberOfItems(int* p);
    HRESULT clear();
    HRESULT initialize(ISVGLength newItem, ISVGLength* ppResult);
    HRESULT getItem(int index, ISVGLength* ppResult);
    HRESULT insertItemBefore(ISVGLength newItem, int index, ISVGLength* ppResult);
    HRESULT replaceItem(ISVGLength newItem, int index, ISVGLength* ppResult);
    HRESULT removeItem(int index, ISVGLength* ppResult);
    HRESULT appendItem(ISVGLength newItem, ISVGLength* ppResult);
}

@GUID("305104D2-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGAnimatedLengthList : IDispatch
{
    HRESULT putref_baseVal(ISVGLengthList v);
    HRESULT get_baseVal(ISVGLengthList* p);
    HRESULT putref_animVal(ISVGLengthList v);
    HRESULT get_animVal(ISVGLengthList* p);
}

@GUID("305104CB-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGNumber : IDispatch
{
    HRESULT put_value(float v);
    HRESULT get_value(float* p);
}

@GUID("305104CC-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGAnimatedNumber : IDispatch
{
    HRESULT put_baseVal(float v);
    HRESULT get_baseVal(float* p);
    HRESULT put_animVal(float v);
    HRESULT get_animVal(float* p);
}

@GUID("305104CD-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGNumberList : IDispatch
{
    HRESULT put_numberOfItems(int v);
    HRESULT get_numberOfItems(int* p);
    HRESULT clear();
    HRESULT initialize(ISVGNumber newItem, ISVGNumber* ppResult);
    HRESULT getItem(int index, ISVGNumber* ppResult);
    HRESULT insertItemBefore(ISVGNumber newItem, int index, ISVGNumber* ppResult);
    HRESULT replaceItem(ISVGNumber newItem, int index, ISVGNumber* ppResult);
    HRESULT removeItem(int index, ISVGNumber* ppResult);
    HRESULT appendItem(ISVGNumber newItem, ISVGNumber* ppResult);
}

@GUID("305104CE-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGAnimatedNumberList : IDispatch
{
    HRESULT putref_baseVal(ISVGNumberList v);
    HRESULT get_baseVal(ISVGNumberList* p);
    HRESULT putref_animVal(ISVGNumberList v);
    HRESULT get_animVal(ISVGNumberList* p);
}

@GUID("3051052D-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGClipPathElement : IDispatch
{
    HRESULT putref_clipPathUnits(ISVGAnimatedEnumeration v);
    HRESULT get_clipPathUnits(ISVGAnimatedEnumeration* p);
}

@GUID("3059003B-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGClipPathElement : IDispatch
{
}

@GUID("305104E6-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGDocument : IDispatch
{
    HRESULT get_rootElement(ISVGSVGElement* p);
}

@GUID("305105AB-98B5-11CF-BB82-00AA00BDCE0B")
interface IGetSVGDocument : IDispatch
{
    HRESULT getSVGDocument(IDispatch* ppSVGDocument);
}

@GUID("30590000-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGElement : IDispatch
{
}

@GUID("305104D6-98B5-11CF-BB82-00AA00BDCE0B")
interface IICCSVGColor : IDispatch
{
}

@GUID("30510524-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPaint : IDispatch
{
}

@GUID("3051052C-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPatternElement : IDispatch
{
    HRESULT putref_patternUnits(ISVGAnimatedEnumeration v);
    HRESULT get_patternUnits(ISVGAnimatedEnumeration* p);
    HRESULT putref_patternContentUnits(ISVGAnimatedEnumeration v);
    HRESULT get_patternContentUnits(ISVGAnimatedEnumeration* p);
    HRESULT putref_patternTransform(ISVGAnimatedTransformList v);
    HRESULT get_patternTransform(ISVGAnimatedTransformList* p);
    HRESULT putref_x(ISVGAnimatedLength v);
    HRESULT get_x(ISVGAnimatedLength* p);
    HRESULT putref_y(ISVGAnimatedLength v);
    HRESULT get_y(ISVGAnimatedLength* p);
    HRESULT putref_width(ISVGAnimatedLength v);
    HRESULT get_width(ISVGAnimatedLength* p);
    HRESULT putref_height(ISVGAnimatedLength v);
    HRESULT get_height(ISVGAnimatedLength* p);
}

@GUID("3059002C-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPatternElement : IDispatch
{
}

@GUID("305104FC-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSeg : IDispatch
{
    HRESULT put_pathSegType(short v);
    HRESULT get_pathSegType(short* p);
    HRESULT get_pathSegTypeAsLetter(BSTR* p);
}

@GUID("30510506-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSegArcAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_r1(float v);
    HRESULT get_r1(float* p);
    HRESULT put_r2(float v);
    HRESULT get_r2(float* p);
    HRESULT put_angle(float v);
    HRESULT get_angle(float* p);
    HRESULT put_largeArcFlag(short v);
    HRESULT get_largeArcFlag(short* p);
    HRESULT put_sweepFlag(short v);
    HRESULT get_sweepFlag(short* p);
}

@GUID("30510507-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSegArcRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_r1(float v);
    HRESULT get_r1(float* p);
    HRESULT put_r2(float v);
    HRESULT get_r2(float* p);
    HRESULT put_angle(float v);
    HRESULT get_angle(float* p);
    HRESULT put_largeArcFlag(short v);
    HRESULT get_largeArcFlag(short* p);
    HRESULT put_sweepFlag(short v);
    HRESULT get_sweepFlag(short* p);
}

@GUID("305104FD-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSegClosePath : IDispatch
{
}

@GUID("305104FE-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSegMovetoAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

@GUID("305104FF-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSegMovetoRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

@GUID("30510500-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSegLinetoAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

@GUID("30510501-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSegLinetoRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

@GUID("30510502-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSegCurvetoCubicAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_x1(float v);
    HRESULT get_x1(float* p);
    HRESULT put_y1(float v);
    HRESULT get_y1(float* p);
    HRESULT put_x2(float v);
    HRESULT get_x2(float* p);
    HRESULT put_y2(float v);
    HRESULT get_y2(float* p);
}

@GUID("30510503-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSegCurvetoCubicRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_x1(float v);
    HRESULT get_x1(float* p);
    HRESULT put_y1(float v);
    HRESULT get_y1(float* p);
    HRESULT put_x2(float v);
    HRESULT get_x2(float* p);
    HRESULT put_y2(float v);
    HRESULT get_y2(float* p);
}

@GUID("3051050C-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSegCurvetoCubicSmoothAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_x2(float v);
    HRESULT get_x2(float* p);
    HRESULT put_y2(float v);
    HRESULT get_y2(float* p);
}

@GUID("3051050D-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSegCurvetoCubicSmoothRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_x2(float v);
    HRESULT get_x2(float* p);
    HRESULT put_y2(float v);
    HRESULT get_y2(float* p);
}

@GUID("30510504-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSegCurvetoQuadraticAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_x1(float v);
    HRESULT get_x1(float* p);
    HRESULT put_y1(float v);
    HRESULT get_y1(float* p);
}

@GUID("30510505-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSegCurvetoQuadraticRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT put_x1(float v);
    HRESULT get_x1(float* p);
    HRESULT put_y1(float v);
    HRESULT get_y1(float* p);
}

@GUID("3051050E-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSegCurvetoQuadraticSmoothAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

@GUID("3051050F-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSegCurvetoQuadraticSmoothRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

@GUID("30510508-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSegLinetoHorizontalAbs : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
}

@GUID("30510509-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSegLinetoHorizontalRel : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
}

@GUID("3051050A-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSegLinetoVerticalAbs : IDispatch
{
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

@GUID("3051050B-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSegLinetoVerticalRel : IDispatch
{
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
}

@GUID("30590013-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPathSegArcAbs : IDispatch
{
}

@GUID("30590014-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPathSegArcRel : IDispatch
{
}

@GUID("30590015-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPathSegClosePath : IDispatch
{
}

@GUID("30590024-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPathSegMovetoAbs : IDispatch
{
}

@GUID("30590025-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPathSegMovetoRel : IDispatch
{
}

@GUID("3059001E-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPathSegLinetoAbs : IDispatch
{
}

@GUID("30590021-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPathSegLinetoRel : IDispatch
{
}

@GUID("30590016-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPathSegCurvetoCubicAbs : IDispatch
{
}

@GUID("30590017-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPathSegCurvetoCubicRel : IDispatch
{
}

@GUID("30590018-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPathSegCurvetoCubicSmoothAbs : IDispatch
{
}

@GUID("30590019-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPathSegCurvetoCubicSmoothRel : IDispatch
{
}

@GUID("3059001A-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPathSegCurvetoQuadraticAbs : IDispatch
{
}

@GUID("3059001B-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPathSegCurvetoQuadraticRel : IDispatch
{
}

@GUID("3059001C-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPathSegCurvetoQuadraticSmoothAbs : IDispatch
{
}

@GUID("3059001D-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPathSegCurvetoQuadraticSmoothRel : IDispatch
{
}

@GUID("3059001F-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPathSegLinetoHorizontalAbs : IDispatch
{
}

@GUID("30590020-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPathSegLinetoHorizontalRel : IDispatch
{
}

@GUID("30590022-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPathSegLinetoVerticalAbs : IDispatch
{
}

@GUID("30590023-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPathSegLinetoVerticalRel : IDispatch
{
}

@GUID("30510510-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathSegList : IDispatch
{
    HRESULT put_numberOfItems(int v);
    HRESULT get_numberOfItems(int* p);
    HRESULT clear();
    HRESULT initialize(ISVGPathSeg newItem, ISVGPathSeg* ppResult);
    HRESULT getItem(int index, ISVGPathSeg* ppResult);
    HRESULT insertItemBefore(ISVGPathSeg newItem, int index, ISVGPathSeg* ppResult);
    HRESULT replaceItem(ISVGPathSeg newItem, int index, ISVGPathSeg* ppResult);
    HRESULT removeItem(int index, ISVGPathSeg* ppResult);
    HRESULT appendItem(ISVGPathSeg newItem, ISVGPathSeg* ppResult);
}

@GUID("305104F4-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPoint : IDispatch
{
    HRESULT put_x(float v);
    HRESULT get_x(float* p);
    HRESULT put_y(float v);
    HRESULT get_y(float* p);
    HRESULT matrixTransform(ISVGMatrix pMatrix, ISVGPoint* ppResult);
}

@GUID("305104F5-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPointList : IDispatch
{
    HRESULT put_numberOfItems(int v);
    HRESULT get_numberOfItems(int* p);
    HRESULT clear();
    HRESULT initialize(ISVGPoint pNewItem, ISVGPoint* ppResult);
    HRESULT getItem(int index, ISVGPoint* ppResult);
    HRESULT insertItemBefore(ISVGPoint pNewItem, int index, ISVGPoint* ppResult);
    HRESULT replaceItem(ISVGPoint pNewItem, int index, ISVGPoint* ppResult);
    HRESULT removeItem(int index, ISVGPoint* ppResult);
    HRESULT appendItem(ISVGPoint pNewItem, ISVGPoint* ppResult);
}

@GUID("305104E2-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGViewSpec : IDispatch
{
}

@GUID("305104F7-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGTransform : IDispatch
{
    HRESULT put_type(short v);
    HRESULT get_type(short* p);
    HRESULT putref_matrix(ISVGMatrix v);
    HRESULT get_matrix(ISVGMatrix* p);
    HRESULT put_angle(float v);
    HRESULT get_angle(float* p);
    HRESULT setMatrix(ISVGMatrix matrix);
    HRESULT setTranslate(float tx, float ty);
    HRESULT setScale(float sx, float sy);
    HRESULT setRotate(float angle, float cx, float cy);
    HRESULT setSkewX(float angle);
    HRESULT setSkewY(float angle);
}

@GUID("30590001-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGSVGElement : IDispatch
{
}

@GUID("305104EE-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGElementInstance : IDispatch
{
    HRESULT get_correspondingElement(ISVGElement* p);
    HRESULT get_correspondingUseElement(ISVGUseElement* p);
    HRESULT get_parentNode(ISVGElementInstance* p);
    HRESULT get_childNodes(ISVGElementInstanceList* p);
    HRESULT get_firstChild(ISVGElementInstance* p);
    HRESULT get_lastChild(ISVGElementInstance* p);
    HRESULT get_previousSibling(ISVGElementInstance* p);
    HRESULT get_nextSibling(ISVGElementInstance* p);
}

@GUID("305104ED-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGUseElement : IDispatch
{
    HRESULT putref_x(ISVGAnimatedLength v);
    HRESULT get_x(ISVGAnimatedLength* p);
    HRESULT putref_y(ISVGAnimatedLength v);
    HRESULT get_y(ISVGAnimatedLength* p);
    HRESULT putref_width(ISVGAnimatedLength v);
    HRESULT get_width(ISVGAnimatedLength* p);
    HRESULT putref_height(ISVGAnimatedLength v);
    HRESULT get_height(ISVGAnimatedLength* p);
    HRESULT putref_instanceRoot(ISVGElementInstance v);
    HRESULT get_instanceRoot(ISVGElementInstance* p);
    HRESULT putref_animatedInstanceRoot(ISVGElementInstance v);
    HRESULT get_animatedInstanceRoot(ISVGElementInstance* p);
}

@GUID("30590010-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGUseElement : IDispatch
{
}

@GUID("305104C0-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLStyleSheetRulesAppliedCollection : IDispatch
{
    HRESULT item(int index, IHTMLStyleSheetRule* ppHTMLStyleSheetRule);
    HRESULT get_length(int* p);
    HRESULT propertyAppliedBy(BSTR name, IHTMLStyleSheetRule* ppRule);
    HRESULT propertyAppliedTrace(BSTR name, int index, IHTMLStyleSheetRule* ppRule);
    HRESULT propertyAppliedTraceLength(BSTR name, int* pLength);
}

@GUID("305104BF-98B5-11CF-BB82-00AA00BDCE0B")
interface IRulesApplied : IDispatch
{
    HRESULT get_element(IHTMLElement* p);
    HRESULT get_inlineStyles(IHTMLStyle* p);
    HRESULT get_appliedRules(IHTMLStyleSheetRulesAppliedCollection* p);
    HRESULT propertyIsInline(BSTR name, short* p);
    HRESULT propertyIsInheritable(BSTR name, short* p);
    HRESULT hasInheritableProperty(short* p);
}

@GUID("3050F5A6-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLStyleSheetRulesAppliedCollection : IDispatch
{
}

@GUID("3050F5A5-98B5-11CF-BB82-00AA00BDCE0B")
interface DispRulesApplied : IDispatch
{
}

@GUID("3050F5A4-98B5-11CF-BB82-00AA00BDCE0B")
interface DispRulesAppliedCollection : IDispatch
{
}

@GUID("30590070-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLW3CComputedStyle : IDispatch
{
}

@GUID("30510517-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGAnimatedPoints : IDispatch
{
    HRESULT putref_points(ISVGPointList v);
    HRESULT get_points(ISVGPointList* p);
    HRESULT putref_animatedPoints(ISVGPointList v);
    HRESULT get_animatedPoints(ISVGPointList* p);
}

@GUID("30510514-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGCircleElement : IDispatch
{
    HRESULT putref_cx(ISVGAnimatedLength v);
    HRESULT get_cx(ISVGAnimatedLength* p);
    HRESULT putref_cy(ISVGAnimatedLength v);
    HRESULT get_cy(ISVGAnimatedLength* p);
    HRESULT putref_r(ISVGAnimatedLength v);
    HRESULT get_r(ISVGAnimatedLength* p);
}

@GUID("30510515-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGEllipseElement : IDispatch
{
    HRESULT putref_cx(ISVGAnimatedLength v);
    HRESULT get_cx(ISVGAnimatedLength* p);
    HRESULT putref_cy(ISVGAnimatedLength v);
    HRESULT get_cy(ISVGAnimatedLength* p);
    HRESULT putref_rx(ISVGAnimatedLength v);
    HRESULT get_rx(ISVGAnimatedLength* p);
    HRESULT putref_ry(ISVGAnimatedLength v);
    HRESULT get_ry(ISVGAnimatedLength* p);
}

@GUID("30510516-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGLineElement : IDispatch
{
    HRESULT putref_x1(ISVGAnimatedLength v);
    HRESULT get_x1(ISVGAnimatedLength* p);
    HRESULT putref_y1(ISVGAnimatedLength v);
    HRESULT get_y1(ISVGAnimatedLength* p);
    HRESULT putref_x2(ISVGAnimatedLength v);
    HRESULT get_x2(ISVGAnimatedLength* p);
    HRESULT putref_y2(ISVGAnimatedLength v);
    HRESULT get_y2(ISVGAnimatedLength* p);
}

@GUID("30510513-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGRectElement : IDispatch
{
    HRESULT putref_x(ISVGAnimatedLength v);
    HRESULT get_x(ISVGAnimatedLength* p);
    HRESULT putref_y(ISVGAnimatedLength v);
    HRESULT get_y(ISVGAnimatedLength* p);
    HRESULT putref_width(ISVGAnimatedLength v);
    HRESULT get_width(ISVGAnimatedLength* p);
    HRESULT putref_height(ISVGAnimatedLength v);
    HRESULT get_height(ISVGAnimatedLength* p);
    HRESULT putref_rx(ISVGAnimatedLength v);
    HRESULT get_rx(ISVGAnimatedLength* p);
    HRESULT putref_ry(ISVGAnimatedLength v);
    HRESULT get_ry(ISVGAnimatedLength* p);
}

@GUID("30510519-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPolygonElement : IDispatch
{
}

@GUID("30510518-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPolylineElement : IDispatch
{
}

@GUID("3059000A-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGCircleElement : IDispatch
{
}

@GUID("3059000B-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGEllipseElement : IDispatch
{
}

@GUID("3059000C-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGLineElement : IDispatch
{
}

@GUID("30590009-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGRectElement : IDispatch
{
}

@GUID("3059000D-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPolygonElement : IDispatch
{
}

@GUID("3059000E-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPolylineElement : IDispatch
{
}

@GUID("305104E8-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGGElement : IDispatch
{
}

@GUID("30590002-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGGElement : IDispatch
{
}

@GUID("305104EC-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGSymbolElement : IDispatch
{
}

@GUID("30590004-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGSymbolElement : IDispatch
{
}

@GUID("305104E9-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGDefsElement : IDispatch
{
}

@GUID("30590003-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGDefsElement : IDispatch
{
}

@GUID("30510511-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGAnimatedPathData : IDispatch
{
    HRESULT putref_pathSegList(ISVGPathSegList v);
    HRESULT get_pathSegList(ISVGPathSegList* p);
    HRESULT putref_normalizedPathSegList(ISVGPathSegList v);
    HRESULT get_normalizedPathSegList(ISVGPathSegList* p);
    HRESULT putref_animatedPathSegList(ISVGPathSegList v);
    HRESULT get_animatedPathSegList(ISVGPathSegList* p);
    HRESULT putref_animatedNormalizedPathSegList(ISVGPathSegList v);
    HRESULT get_animatedNormalizedPathSegList(ISVGPathSegList* p);
}

@GUID("30510512-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPathElement : IDispatch
{
    HRESULT putref_pathLength(ISVGAnimatedNumber v);
    HRESULT get_pathLength(ISVGAnimatedNumber* p);
    HRESULT getTotalLength(float* pfltResult);
    HRESULT getPointAtLength(float fltdistance, ISVGPoint* ppPointResult);
    HRESULT getPathSegAtLength(float fltdistance, int* plResult);
    HRESULT createSVGPathSegClosePath(ISVGPathSegClosePath* ppResult);
    HRESULT createSVGPathSegMovetoAbs(float x, float y, ISVGPathSegMovetoAbs* ppResult);
    HRESULT createSVGPathSegMovetoRel(float x, float y, ISVGPathSegMovetoRel* ppResult);
    HRESULT createSVGPathSegLinetoAbs(float x, float y, ISVGPathSegLinetoAbs* ppResult);
    HRESULT createSVGPathSegLinetoRel(float x, float y, ISVGPathSegLinetoRel* ppResult);
    HRESULT createSVGPathSegCurvetoCubicAbs(float x, float y, float x1, float y1, float x2, float y2, 
                                            ISVGPathSegCurvetoCubicAbs* ppResult);
    HRESULT createSVGPathSegCurvetoCubicRel(float x, float y, float x1, float y1, float x2, float y2, 
                                            ISVGPathSegCurvetoCubicRel* ppResult);
    HRESULT createSVGPathSegCurvetoQuadraticAbs(float x, float y, float x1, float y1, 
                                                ISVGPathSegCurvetoQuadraticAbs* ppResult);
    HRESULT createSVGPathSegCurvetoQuadraticRel(float x, float y, float x1, float y1, 
                                                ISVGPathSegCurvetoQuadraticRel* ppResult);
    HRESULT createSVGPathSegArcAbs(float x, float y, float r1, float r2, float angle, short largeArcFlag, 
                                   short sweepFlag, ISVGPathSegArcAbs* ppResult);
    HRESULT createSVGPathSegArcRel(float x, float y, float r1, float r2, float angle, short largeArcFlag, 
                                   short sweepFlag, ISVGPathSegArcRel* ppResult);
    HRESULT createSVGPathSegLinetoHorizontalAbs(float x, ISVGPathSegLinetoHorizontalAbs* ppResult);
    HRESULT createSVGPathSegLinetoHorizontalRel(float x, ISVGPathSegLinetoHorizontalRel* ppResult);
    HRESULT createSVGPathSegLinetoVerticalAbs(float y, ISVGPathSegLinetoVerticalAbs* ppResult);
    HRESULT createSVGPathSegLinetoVerticalRel(float y, ISVGPathSegLinetoVerticalRel* ppResult);
    HRESULT createSVGPathSegCurvetoCubicSmoothAbs(float x, float y, float x2, float y2, 
                                                  ISVGPathSegCurvetoCubicSmoothAbs* ppResult);
    HRESULT createSVGPathSegCurvetoCubicSmoothRel(float x, float y, float x2, float y2, 
                                                  ISVGPathSegCurvetoCubicSmoothRel* ppResult);
    HRESULT createSVGPathSegCurvetoQuadraticSmoothAbs(float x, float y, 
                                                      ISVGPathSegCurvetoQuadraticSmoothAbs* ppResult);
    HRESULT createSVGPathSegCurvetoQuadraticSmoothRel(float x, float y, 
                                                      ISVGPathSegCurvetoQuadraticSmoothRel* ppResult);
}

@GUID("30590011-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGPathElement : IDispatch
{
}

@GUID("305104FA-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGPreserveAspectRatio : IDispatch
{
    HRESULT put_align(short v);
    HRESULT get_align(short* p);
    HRESULT put_meetOrSlice(short v);
    HRESULT get_meetOrSlice(short* p);
}

@GUID("3051051C-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGTextElement : IDispatch
{
}

@GUID("30590037-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGTextElement : IDispatch
{
}

@GUID("305104F0-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGImageElement : IDispatch
{
    HRESULT putref_x(ISVGAnimatedLength v);
    HRESULT get_x(ISVGAnimatedLength* p);
    HRESULT putref_y(ISVGAnimatedLength v);
    HRESULT get_y(ISVGAnimatedLength* p);
    HRESULT putref_width(ISVGAnimatedLength v);
    HRESULT get_width(ISVGAnimatedLength* p);
    HRESULT putref_height(ISVGAnimatedLength v);
    HRESULT get_height(ISVGAnimatedLength* p);
}

@GUID("30590027-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGImageElement : IDispatch
{
}

@GUID("3051052B-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGStopElement : IDispatch
{
    HRESULT putref_offset(ISVGAnimatedNumber v);
    HRESULT get_offset(ISVGAnimatedNumber* p);
}

@GUID("3059002D-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGStopElement : IDispatch
{
}

@GUID("30510528-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGGradientElement : IDispatch
{
    HRESULT putref_gradientUnits(ISVGAnimatedEnumeration v);
    HRESULT get_gradientUnits(ISVGAnimatedEnumeration* p);
    HRESULT putref_gradientTransform(ISVGAnimatedTransformList v);
    HRESULT get_gradientTransform(ISVGAnimatedTransformList* p);
    HRESULT putref_spreadMethod(ISVGAnimatedEnumeration v);
    HRESULT get_spreadMethod(ISVGAnimatedEnumeration* p);
}

@GUID("3059002E-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGGradientElement : IDispatch
{
}

@GUID("30510529-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGLinearGradientElement : IDispatch
{
    HRESULT putref_x1(ISVGAnimatedLength v);
    HRESULT get_x1(ISVGAnimatedLength* p);
    HRESULT putref_y1(ISVGAnimatedLength v);
    HRESULT get_y1(ISVGAnimatedLength* p);
    HRESULT putref_x2(ISVGAnimatedLength v);
    HRESULT get_x2(ISVGAnimatedLength* p);
    HRESULT putref_y2(ISVGAnimatedLength v);
    HRESULT get_y2(ISVGAnimatedLength* p);
}

@GUID("3059002A-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGLinearGradientElement : IDispatch
{
}

@GUID("3051052A-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGRadialGradientElement : IDispatch
{
    HRESULT putref_cx(ISVGAnimatedLength v);
    HRESULT get_cx(ISVGAnimatedLength* p);
    HRESULT putref_cy(ISVGAnimatedLength v);
    HRESULT get_cy(ISVGAnimatedLength* p);
    HRESULT putref_r(ISVGAnimatedLength v);
    HRESULT get_r(ISVGAnimatedLength* p);
    HRESULT putref_fx(ISVGAnimatedLength v);
    HRESULT get_fx(ISVGAnimatedLength* p);
    HRESULT putref_fy(ISVGAnimatedLength v);
    HRESULT get_fy(ISVGAnimatedLength* p);
}

@GUID("3059002B-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGRadialGradientElement : IDispatch
{
}

@GUID("3051052E-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGMaskElement : IDispatch
{
    HRESULT putref_maskUnits(ISVGAnimatedEnumeration v);
    HRESULT get_maskUnits(ISVGAnimatedEnumeration* p);
    HRESULT putref_maskContentUnits(ISVGAnimatedEnumeration v);
    HRESULT get_maskContentUnits(ISVGAnimatedEnumeration* p);
    HRESULT putref_x(ISVGAnimatedLength v);
    HRESULT get_x(ISVGAnimatedLength* p);
    HRESULT putref_y(ISVGAnimatedLength v);
    HRESULT get_y(ISVGAnimatedLength* p);
    HRESULT putref_width(ISVGAnimatedLength v);
    HRESULT get_width(ISVGAnimatedLength* p);
    HRESULT putref_height(ISVGAnimatedLength v);
    HRESULT get_height(ISVGAnimatedLength* p);
}

@GUID("3059003C-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGMaskElement : IDispatch
{
}

@GUID("30510525-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGMarkerElement : IDispatch
{
    HRESULT putref_refX(ISVGAnimatedLength v);
    HRESULT get_refX(ISVGAnimatedLength* p);
    HRESULT putref_refY(ISVGAnimatedLength v);
    HRESULT get_refY(ISVGAnimatedLength* p);
    HRESULT putref_markerUnits(ISVGAnimatedEnumeration v);
    HRESULT get_markerUnits(ISVGAnimatedEnumeration* p);
    HRESULT putref_markerWidth(ISVGAnimatedLength v);
    HRESULT get_markerWidth(ISVGAnimatedLength* p);
    HRESULT putref_markerHeight(ISVGAnimatedLength v);
    HRESULT get_markerHeight(ISVGAnimatedLength* p);
    HRESULT putref_orientType(ISVGAnimatedEnumeration v);
    HRESULT get_orientType(ISVGAnimatedEnumeration* p);
    HRESULT putref_orientAngle(ISVGAnimatedAngle v);
    HRESULT get_orientAngle(ISVGAnimatedAngle* p);
    HRESULT setOrientToAuto();
    HRESULT setOrientToAngle(ISVGAngle pSVGAngle);
}

@GUID("30590036-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGMarkerElement : IDispatch
{
}

@GUID("3051054E-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGZoomEvent : IDispatch
{
    HRESULT get_zoomRectScreen(ISVGRect* p);
    HRESULT get_previousScale(float* p);
    HRESULT get_previousTranslate(ISVGPoint* p);
    HRESULT get_newScale(float* p);
    HRESULT get_newTranslate(ISVGPoint* p);
}

@GUID("30590031-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGZoomEvent : IDispatch
{
}

@GUID("3051054B-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGAElement : IDispatch
{
    HRESULT putref_target(ISVGAnimatedString v);
    HRESULT get_target(ISVGAnimatedString* p);
}

@GUID("30590033-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGAElement : IDispatch
{
}

@GUID("3051054C-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGViewElement : IDispatch
{
    HRESULT putref_viewTarget(ISVGStringList v);
    HRESULT get_viewTarget(ISVGStringList* p);
}

@GUID("30590034-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGViewElement : IDispatch
{
}

@GUID("30510704-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLMediaError : IDispatch
{
    HRESULT get_code(short* p);
}

@GUID("30510705-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTimeRanges : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT start(int index, float* startTime);
    HRESULT end(int index, float* endTime);
}

@GUID("3051080B-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLTimeRanges2 : IDispatch
{
    HRESULT startDouble(int index, double* startTime);
    HRESULT endDouble(int index, double* endTime);
}

@GUID("30510706-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLMediaElement : IDispatch
{
    HRESULT get_error(IHTMLMediaError* p);
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT get_currentSrc(BSTR* p);
    HRESULT get_networkState(ushort* p);
    HRESULT put_preload(BSTR v);
    HRESULT get_preload(BSTR* p);
    HRESULT get_buffered(IHTMLTimeRanges* p);
    HRESULT load();
    HRESULT canPlayType(BSTR type, BSTR* canPlay);
    HRESULT get_seeking(short* p);
    HRESULT put_currentTime(float v);
    HRESULT get_currentTime(float* p);
    HRESULT get_initialTime(float* p);
    HRESULT get_duration(float* p);
    HRESULT get_paused(short* p);
    HRESULT put_defaultPlaybackRate(float v);
    HRESULT get_defaultPlaybackRate(float* p);
    HRESULT put_playbackRate(float v);
    HRESULT get_playbackRate(float* p);
    HRESULT get_played(IHTMLTimeRanges* p);
    HRESULT get_seekable(IHTMLTimeRanges* p);
    HRESULT get_ended(short* p);
    HRESULT put_autoplay(short v);
    HRESULT get_autoplay(short* p);
    HRESULT put_loop(short v);
    HRESULT get_loop(short* p);
    HRESULT play();
    HRESULT pause();
    HRESULT put_controls(short v);
    HRESULT get_controls(short* p);
    HRESULT put_volume(float v);
    HRESULT get_volume(float* p);
    HRESULT put_muted(short v);
    HRESULT get_muted(short* p);
    HRESULT put_autobuffer(short v);
    HRESULT get_autobuffer(short* p);
}

@GUID("30510809-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLMediaElement2 : IDispatch
{
    HRESULT put_currentTimeDouble(double v);
    HRESULT get_currentTimeDouble(double* p);
    HRESULT get_initialTimeDouble(double* p);
    HRESULT get_durationDouble(double* p);
    HRESULT put_defaultPlaybackRateDouble(double v);
    HRESULT get_defaultPlaybackRateDouble(double* p);
    HRESULT put_playbackRateDouble(double v);
    HRESULT get_playbackRateDouble(double* p);
    HRESULT put_volumeDouble(double v);
    HRESULT get_volumeDouble(double* p);
}

@GUID("30510792-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLMSMediaElement : IDispatch
{
    HRESULT put_msPlayToDisabled(short v);
    HRESULT get_msPlayToDisabled(short* p);
    HRESULT put_msPlayToPrimary(short v);
    HRESULT get_msPlayToPrimary(short* p);
}

@GUID("30510707-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLSourceElement : IDispatch
{
    HRESULT put_src(BSTR v);
    HRESULT get_src(BSTR* p);
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_media(BSTR v);
    HRESULT get_media(BSTR* p);
}

@GUID("30510708-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLAudioElement : IDispatch
{
}

@GUID("30510709-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLVideoElement : IDispatch
{
    HRESULT put_width(int v);
    HRESULT get_width(int* p);
    HRESULT put_height(int v);
    HRESULT get_height(int* p);
    HRESULT get_videoWidth(uint* p);
    HRESULT get_videoHeight(uint* p);
    HRESULT put_poster(BSTR v);
    HRESULT get_poster(BSTR* p);
}

@GUID("305107EB-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLAudioElementFactory : IDispatch
{
    HRESULT create(VARIANT src, IHTMLAudioElement* __MIDL__IHTMLAudioElementFactory0000);
}

@GUID("30590086-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLMediaError : IDispatch
{
}

@GUID("30590087-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLTimeRanges : IDispatch
{
}

@GUID("30590088-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLMediaElement : IDispatch
{
}

@GUID("30590089-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLSourceElement : IDispatch
{
}

@GUID("3059008A-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLAudioElement : IDispatch
{
}

@GUID("3059008B-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLVideoElement : IDispatch
{
}

@GUID("305104F1-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGSwitchElement : IDispatch
{
}

@GUID("30590030-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGSwitchElement : IDispatch
{
}

@GUID("305104EA-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGDescElement : IDispatch
{
}

@GUID("30590005-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGDescElement : IDispatch
{
}

@GUID("305104EB-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGTitleElement : IDispatch
{
}

@GUID("30590006-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGTitleElement : IDispatch
{
}

@GUID("30510560-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGMetadataElement : IDispatch
{
}

@GUID("3059002F-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGMetadataElement : IDispatch
{
}

@GUID("305104EF-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGElementInstanceList : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(int index, ISVGElementInstance* ppResult);
}

@GUID("30590007-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGElementInstance : IDispatch
{
}

@GUID("30590008-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGElementInstanceList : IDispatch
{
}

@GUID("3051072B-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMException : IDispatch
{
    HRESULT put_code(int v);
    HRESULT get_code(int* p);
    HRESULT get_message(BSTR* p);
}

@GUID("30590094-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMException : IDispatch
{
}

@GUID("3051072D-98B5-11CF-BB82-00AA00BDCE0B")
interface IRangeException : IDispatch
{
    HRESULT put_code(int v);
    HRESULT get_code(int* p);
    HRESULT get_message(BSTR* p);
}

@GUID("30590095-98B5-11CF-BB82-00AA00BDCE0B")
interface DispRangeException : IDispatch
{
}

@GUID("3051072F-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGException : IDispatch
{
    HRESULT put_code(int v);
    HRESULT get_code(int* p);
    HRESULT get_message(BSTR* p);
}

@GUID("30590096-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGException : IDispatch
{
}

@GUID("3051073A-98B5-11CF-BB82-00AA00BDCE0B")
interface IEventException : IDispatch
{
    HRESULT put_code(int v);
    HRESULT get_code(int* p);
    HRESULT get_message(BSTR* p);
}

@GUID("30590099-98B5-11CF-BB82-00AA00BDCE0B")
interface DispEventException : IDispatch
{
}

@GUID("3051054D-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGScriptElement : IDispatch
{
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
}

@GUID("30590039-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGScriptElement : IDispatch
{
}

@GUID("305104F3-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGStyleElement : IDispatch
{
    HRESULT put_type(BSTR v);
    HRESULT get_type(BSTR* p);
    HRESULT put_media(BSTR v);
    HRESULT get_media(BSTR* p);
}

@GUID("30590029-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGStyleElement : IDispatch
{
}

@GUID("3051051A-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGTextContentElement : IDispatch
{
    HRESULT putref_textLength(ISVGAnimatedLength v);
    HRESULT get_textLength(ISVGAnimatedLength* p);
    HRESULT putref_lengthAdjust(ISVGAnimatedEnumeration v);
    HRESULT get_lengthAdjust(ISVGAnimatedEnumeration* p);
    HRESULT getNumberOfChars(int* pResult);
    HRESULT getComputedTextLength(float* pResult);
    HRESULT getSubStringLength(int charnum, int nchars, float* pResult);
    HRESULT getStartPositionOfChar(int charnum, ISVGPoint* ppResult);
    HRESULT getEndPositionOfChar(int charnum, ISVGPoint* ppResult);
    HRESULT getExtentOfChar(int charnum, ISVGRect* ppResult);
    HRESULT getRotationOfChar(int charnum, float* pResult);
    HRESULT getCharNumAtPosition(ISVGPoint point, int* pResult);
    HRESULT selectSubString(int charnum, int nchars);
}

@GUID("30590035-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGTextContentElement : IDispatch
{
}

@GUID("3051051B-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGTextPositioningElement : IDispatch
{
    HRESULT putref_x(ISVGAnimatedLengthList v);
    HRESULT get_x(ISVGAnimatedLengthList* p);
    HRESULT putref_y(ISVGAnimatedLengthList v);
    HRESULT get_y(ISVGAnimatedLengthList* p);
    HRESULT putref_dx(ISVGAnimatedLengthList v);
    HRESULT get_dx(ISVGAnimatedLengthList* p);
    HRESULT putref_dy(ISVGAnimatedLengthList v);
    HRESULT get_dy(ISVGAnimatedLengthList* p);
    HRESULT putref_rotate(ISVGAnimatedNumberList v);
    HRESULT get_rotate(ISVGAnimatedNumberList* p);
}

@GUID("30590038-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGTextPositioningElement : IDispatch
{
}

@GUID("30590098-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMDocumentType : IDispatch
{
}

@GUID("3059009C-98B5-11CF-BB82-00AA00BDCE0B")
interface DispNodeIterator : IDispatch
{
}

@GUID("3059009D-98B5-11CF-BB82-00AA00BDCE0B")
interface DispTreeWalker : IDispatch
{
}

@GUID("3059009B-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMProcessingInstruction : IDispatch
{
}

@GUID("30510750-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLPerformanceNavigation : IDispatch
{
    HRESULT get_type(uint* p);
    HRESULT get_redirectCount(uint* p);
    HRESULT toString(BSTR* string);
    HRESULT toJSON(VARIANT* pVar);
}

@GUID("30510752-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLPerformanceTiming : IDispatch
{
    HRESULT get_navigationStart(ulong* p);
    HRESULT get_unloadEventStart(ulong* p);
    HRESULT get_unloadEventEnd(ulong* p);
    HRESULT get_redirectStart(ulong* p);
    HRESULT get_redirectEnd(ulong* p);
    HRESULT get_fetchStart(ulong* p);
    HRESULT get_domainLookupStart(ulong* p);
    HRESULT get_domainLookupEnd(ulong* p);
    HRESULT get_connectStart(ulong* p);
    HRESULT get_connectEnd(ulong* p);
    HRESULT get_requestStart(ulong* p);
    HRESULT get_responseStart(ulong* p);
    HRESULT get_responseEnd(ulong* p);
    HRESULT get_domLoading(ulong* p);
    HRESULT get_domInteractive(ulong* p);
    HRESULT get_domContentLoadedEventStart(ulong* p);
    HRESULT get_domContentLoadedEventEnd(ulong* p);
    HRESULT get_domComplete(ulong* p);
    HRESULT get_loadEventStart(ulong* p);
    HRESULT get_loadEventEnd(ulong* p);
    HRESULT get_msFirstPaint(ulong* p);
    HRESULT toString(BSTR* string);
    HRESULT toJSON(VARIANT* pVar);
}

@GUID("3059009F-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLPerformance : IDispatch
{
}

@GUID("305900A0-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLPerformanceNavigation : IDispatch
{
}

@GUID("305900A1-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLPerformanceTiming : IDispatch
{
}

@GUID("3051051D-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGTSpanElement : IDispatch
{
}

@GUID("3059003A-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGTSpanElement : IDispatch
{
}

@GUID("3050F6B4-98B5-11CF-BB82-00AA00BDCE0B")
interface ITemplatePrinter : IDispatch
{
    HRESULT startDoc(BSTR bstrTitle, short* p);
    HRESULT stopDoc();
    HRESULT printBlankPage();
    HRESULT printPage(IDispatch pElemDisp);
    HRESULT ensurePrintDialogDefaults(short* p);
    HRESULT showPrintDialog(short* p);
    HRESULT showPageSetupDialog(short* p);
    HRESULT printNonNative(IUnknown pMarkup, short* p);
    HRESULT printNonNativeFrames(IUnknown pMarkup, short fActiveFrame);
    HRESULT put_framesetDocument(short v);
    HRESULT get_framesetDocument(short* p);
    HRESULT put_frameActive(short v);
    HRESULT get_frameActive(short* p);
    HRESULT put_frameAsShown(short v);
    HRESULT get_frameAsShown(short* p);
    HRESULT put_selection(short v);
    HRESULT get_selection(short* p);
    HRESULT put_selectedPages(short v);
    HRESULT get_selectedPages(short* p);
    HRESULT put_currentPage(short v);
    HRESULT get_currentPage(short* p);
    HRESULT put_currentPageAvail(short v);
    HRESULT get_currentPageAvail(short* p);
    HRESULT put_collate(short v);
    HRESULT get_collate(short* p);
    HRESULT get_duplex(short* p);
    HRESULT put_copies(ushort v);
    HRESULT get_copies(ushort* p);
    HRESULT put_pageFrom(ushort v);
    HRESULT get_pageFrom(ushort* p);
    HRESULT put_pageTo(ushort v);
    HRESULT get_pageTo(ushort* p);
    HRESULT put_tableOfLinks(short v);
    HRESULT get_tableOfLinks(short* p);
    HRESULT put_allLinkedDocuments(short v);
    HRESULT get_allLinkedDocuments(short* p);
    HRESULT put_header(BSTR v);
    HRESULT get_header(BSTR* p);
    HRESULT put_footer(BSTR v);
    HRESULT get_footer(BSTR* p);
    HRESULT put_marginLeft(int v);
    HRESULT get_marginLeft(int* p);
    HRESULT put_marginRight(int v);
    HRESULT get_marginRight(int* p);
    HRESULT put_marginTop(int v);
    HRESULT get_marginTop(int* p);
    HRESULT put_marginBottom(int v);
    HRESULT get_marginBottom(int* p);
    HRESULT get_pageWidth(int* p);
    HRESULT get_pageHeight(int* p);
    HRESULT get_unprintableLeft(int* p);
    HRESULT get_unprintableTop(int* p);
    HRESULT get_unprintableRight(int* p);
    HRESULT get_unprintableBottom(int* p);
    HRESULT updatePageStatus(int* p);
}

@GUID("3050F83F-98B5-11CF-BB82-00AA00BDCE0B")
interface ITemplatePrinter2 : ITemplatePrinter
{
    HRESULT put_selectionEnabled(short v);
    HRESULT get_selectionEnabled(short* p);
    HRESULT put_frameActiveEnabled(short v);
    HRESULT get_frameActiveEnabled(short* p);
    HRESULT put_orientation(BSTR v);
    HRESULT get_orientation(BSTR* p);
    HRESULT put_usePrinterCopyCollate(short v);
    HRESULT get_usePrinterCopyCollate(short* p);
    HRESULT deviceSupports(BSTR bstrProperty, VARIANT* pvar);
}

@GUID("305104A3-98B5-11CF-BB82-00AA00BDCE0B")
interface ITemplatePrinter3 : ITemplatePrinter2
{
    HRESULT put_headerFooterFont(BSTR v);
    HRESULT get_headerFooterFont(BSTR* p);
    HRESULT getPageMarginTop(IDispatch pageRule, int pageWidth, int pageHeight, VARIANT* pMargin);
    HRESULT getPageMarginRight(IDispatch pageRule, int pageWidth, int pageHeight, VARIANT* pMargin);
    HRESULT getPageMarginBottom(IDispatch pageRule, int pageWidth, int pageHeight, VARIANT* pMargin);
    HRESULT getPageMarginLeft(IDispatch pageRule, int pageWidth, int pageHeight, VARIANT* pMargin);
    HRESULT getPageMarginTopImportant(IDispatch pageRule, short* pbImportant);
    HRESULT getPageMarginRightImportant(IDispatch pageRule, short* pbImportant);
    HRESULT getPageMarginBottomImportant(IDispatch pageRule, short* pbImportant);
    HRESULT getPageMarginLeftImportant(IDispatch pageRule, short* pbImportant);
}

@GUID("F633BE14-9EFF-4C4D-929E-05717B21B3E6")
interface IPrintManagerTemplatePrinter : IDispatch
{
    HRESULT startPrint();
    HRESULT drawPreviewPage(IDispatch pElemDisp, int nPage);
    HRESULT setPageCount(int nPage);
    HRESULT invalidatePreview();
    HRESULT getPrintTaskOptionValue(BSTR bstrKey, VARIANT* pvarin);
    HRESULT endPrint();
}

@GUID("C6403497-7493-4F09-8016-54B03E9BDA69")
interface IPrintManagerTemplatePrinter2 : IPrintManagerTemplatePrinter
{
    HRESULT get_showHeaderFooter(short* p);
    HRESULT get_shrinkToFit(short* p);
    HRESULT get_percentScale(float* p);
}

@GUID("305900E9-98B5-11CF-BB82-00AA00BDCE0B")
interface DispCPrintManagerTemplatePrinter : IDispatch
{
}

@GUID("3051051F-98B5-11CF-BB82-00AA00BDCE0B")
interface ISVGTextPathElement : IDispatch
{
    HRESULT putref_startOffset(ISVGAnimatedLength v);
    HRESULT get_startOffset(ISVGAnimatedLength* p);
    HRESULT putref_method(ISVGAnimatedEnumeration v);
    HRESULT get_method(ISVGAnimatedEnumeration* p);
    HRESULT putref_spacing(ISVGAnimatedEnumeration v);
    HRESULT get_spacing(ISVGAnimatedEnumeration* p);
}

@GUID("3059003D-98B5-11CF-BB82-00AA00BDCE0B")
interface DispSVGTextPathElement : IDispatch
{
}

@GUID("3051077D-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMXmlSerializer : IDispatch
{
    HRESULT serializeToString(IHTMLDOMNode pNode, BSTR* pString);
}

@GUID("30510781-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMParser : IDispatch
{
    HRESULT parseFromString(BSTR xmlSource, BSTR mimeType, IHTMLDocument2* ppNode);
}

@GUID("305900AD-98B5-11CF-BB82-00AA00BDCE0B")
interface DispXMLSerializer : IDispatch
{
}

@GUID("305900AE-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMParser : IDispatch
{
}

@GUID("3051077F-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMXmlSerializerFactory : IDispatch
{
    HRESULT create(IDOMXmlSerializer* __MIDL__IDOMXmlSerializerFactory0000);
}

@GUID("30510783-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMParserFactory : IDispatch
{
    HRESULT create(IDOMParser* __MIDL__IDOMParserFactory0000);
}

@GUID("305900BA-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLSemanticElement : IDispatch
{
}

@GUID("3050F2D6-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLProgressElement : IDispatch
{
    HRESULT put_value(float v);
    HRESULT get_value(float* p);
    HRESULT put_max(float v);
    HRESULT get_max(float* p);
    HRESULT get_position(float* p);
    HRESULT get_form(IHTMLFormElement* p);
}

@GUID("305900AF-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLProgressElement : IDispatch
{
}

@GUID("305107B5-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMMSTransitionEvent : IDispatch
{
    HRESULT get_propertyName(BSTR* p);
    HRESULT get_elapsedTime(float* p);
    HRESULT initMSTransitionEvent(BSTR eventType, short canBubble, short cancelable, BSTR propertyName, 
                                  float elapsedTime);
}

@GUID("305900BB-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMMSTransitionEvent : IDispatch
{
}

@GUID("305107B7-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMMSAnimationEvent : IDispatch
{
    HRESULT get_animationName(BSTR* p);
    HRESULT get_elapsedTime(float* p);
    HRESULT initMSAnimationEvent(BSTR eventType, short canBubble, short cancelable, BSTR animationName, 
                                 float elapsedTime);
}

@GUID("305900BC-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMMSAnimationEvent : IDispatch
{
}

@GUID("305107C7-98B5-11CF-BB82-00AA00BDCE0B")
interface IWebGeocoordinates : IDispatch
{
    HRESULT get_latitude(double* p);
    HRESULT get_longitude(double* p);
    HRESULT get_altitude(VARIANT* p);
    HRESULT get_accuracy(double* p);
    HRESULT get_altitudeAccuracy(VARIANT* p);
    HRESULT get_heading(VARIANT* p);
    HRESULT get_speed(VARIANT* p);
}

@GUID("305107C9-98B5-11CF-BB82-00AA00BDCE0B")
interface IWebGeopositionError : IDispatch
{
    HRESULT get_code(int* p);
    HRESULT get_message(BSTR* p);
}

@GUID("305107CD-98B5-11CF-BB82-00AA00BDCE0B")
interface IWebGeoposition : IDispatch
{
    HRESULT get_coords(IWebGeocoordinates* p);
    HRESULT get_timestamp(ulong* p);
}

@GUID("305900BD-98B5-11CF-BB82-00AA00BDCE0B")
interface DispWebGeolocation : IDispatch
{
}

@GUID("305900BE-98B5-11CF-BB82-00AA00BDCE0B")
interface DispWebGeocoordinates : IDispatch
{
}

@GUID("305900BF-98B5-11CF-BB82-00AA00BDCE0B")
interface DispWebGeopositionError : IDispatch
{
}

@GUID("305900C1-98B5-11CF-BB82-00AA00BDCE0B")
interface DispWebGeoposition : IDispatch
{
}

@GUID("7E8BC44D-AEFF-11D1-89C2-00C04FB6BFC4")
interface IClientCaps : IDispatch
{
    HRESULT get_javaEnabled(short* p);
    HRESULT get_cookieEnabled(short* p);
    HRESULT get_cpuClass(BSTR* p);
    HRESULT get_systemLanguage(BSTR* p);
    HRESULT get_userLanguage(BSTR* p);
    HRESULT get_platform(BSTR* p);
    HRESULT get_connectionSpeed(int* p);
    HRESULT get_onLine(short* p);
    HRESULT get_colorDepth(int* p);
    HRESULT get_bufferDepth(int* p);
    HRESULT get_width(int* p);
    HRESULT get_height(int* p);
    HRESULT get_availHeight(int* p);
    HRESULT get_availWidth(int* p);
    HRESULT get_connectionType(BSTR* p);
    HRESULT isComponentInstalled(BSTR bstrName, BSTR bstrUrl, BSTR bStrVer, short* p);
    HRESULT getComponentVersion(BSTR bstrName, BSTR bstrUrl, BSTR* pbstrVer);
    HRESULT compareVersions(BSTR bstrVer1, BSTR bstrVer2, int* p);
    HRESULT addComponentRequest(BSTR bstrName, BSTR bstrUrl, BSTR bStrVer);
    HRESULT doComponentRequest(short* p);
    HRESULT clearComponentRequest();
}

@GUID("30510816-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMMSManipulationEvent : IDispatch
{
    HRESULT get_lastState(int* p);
    HRESULT get_currentState(int* p);
    HRESULT initMSManipulationEvent(BSTR eventType, short canBubble, short cancelable, IHTMLWindow2 viewArg, 
                                    int detailArg, int lastState, int currentState);
}

@GUID("305900E1-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMMSManipulationEvent : IDispatch
{
}

@GUID("305107FF-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMCloseEvent : IDispatch
{
    HRESULT get_wasClean(short* p);
    HRESULT initCloseEvent(BSTR eventType, short canBubble, short cancelable, short wasClean, int code, 
                           BSTR reason);
}

@GUID("305900DC-98B5-11CF-BB82-00AA00BDCE0B")
interface DispDOMCloseEvent : IDispatch
{
}

@GUID("305900E4-98B5-11CF-BB82-00AA00BDCE0B")
interface DispApplicationCache : IDispatch
{
}

@GUID("3050F3ED-98B5-11CF-BB82-00AA00BDCE0B")
interface ICSSFilterSite : IUnknown
{
    HRESULT GetElement(IHTMLElement* Element);
    HRESULT FireOnFilterChangeEvent();
}

@GUID("3050F49F-98B5-11CF-BB82-00AA00BDCE0B")
interface IMarkupPointer : IUnknown
{
    HRESULT OwningDoc(IHTMLDocument2* ppDoc);
    HRESULT Gravity(POINTER_GRAVITY* pGravity);
    HRESULT SetGravity(POINTER_GRAVITY Gravity);
    HRESULT Cling(int* pfCling);
    HRESULT SetCling(BOOL fCLing);
    HRESULT Unposition();
    HRESULT IsPositioned(int* pfPositioned);
    HRESULT GetContainer(IMarkupContainer* ppContainer);
    HRESULT MoveAdjacentToElement(IHTMLElement pElement, ELEMENT_ADJACENCY eAdj);
    HRESULT MoveToPointer(IMarkupPointer pPointer);
    HRESULT MoveToContainer(IMarkupContainer pContainer, BOOL fAtStart);
    HRESULT Left(BOOL fMove, MARKUP_CONTEXT_TYPE* pContext, IHTMLElement* ppElement, int* pcch, char* pchText);
    HRESULT Right(BOOL fMove, MARKUP_CONTEXT_TYPE* pContext, IHTMLElement* ppElement, int* pcch, char* pchText);
    HRESULT CurrentScope(IHTMLElement* ppElemCurrent);
    HRESULT IsLeftOf(IMarkupPointer pPointerThat, int* pfResult);
    HRESULT IsLeftOfOrEqualTo(IMarkupPointer pPointerThat, int* pfResult);
    HRESULT IsRightOf(IMarkupPointer pPointerThat, int* pfResult);
    HRESULT IsRightOfOrEqualTo(IMarkupPointer pPointerThat, int* pfResult);
    HRESULT IsEqualTo(IMarkupPointer pPointerThat, int* pfAreEqual);
    HRESULT MoveUnit(MOVEUNIT_ACTION muAction);
    HRESULT FindTextA(ushort* pchFindText, uint dwFlags, IMarkupPointer pIEndMatch, IMarkupPointer pIEndSearch);
}

@GUID("3050F5F9-98B5-11CF-BB82-00AA00BDCE0B")
interface IMarkupContainer : IUnknown
{
    HRESULT OwningDoc(IHTMLDocument2* ppDoc);
}

@GUID("3050F648-98B5-11CF-BB82-00AA00BDCE0B")
interface IMarkupContainer2 : IMarkupContainer
{
    HRESULT CreateChangeLog(IHTMLChangeSink pChangeSink, IHTMLChangeLog* ppChangeLog, BOOL fForward, 
                            BOOL fBackward);
    HRESULT RegisterForDirtyRange(IHTMLChangeSink pChangeSink, uint* pdwCookie);
    HRESULT UnRegisterForDirtyRange(uint dwCookie);
    HRESULT GetAndClearDirtyRange(uint dwCookie, IMarkupPointer pIPointerBegin, IMarkupPointer pIPointerEnd);
    int     GetVersionNumber();
    HRESULT GetMasterElement(IHTMLElement* ppElementMaster);
}

@GUID("3050F649-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLChangeLog : IUnknown
{
    HRESULT GetNextChange(ubyte* pbBuffer, int nBufferSize, int* pnRecordLength);
}

@GUID("3050F64A-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLChangeSink : IUnknown
{
    HRESULT Notify();
}

@GUID("3050F605-98B5-11CF-BB82-00AA00BDCE0B")
interface ISegmentList : IUnknown
{
    HRESULT CreateIterator(ISegmentListIterator* ppIIter);
    HRESULT GetType(SELECTION_TYPE* peType);
    HRESULT IsEmpty(int* pfEmpty);
}

@GUID("3050F692-98B5-11CF-BB82-00AA00BDCE0B")
interface ISegmentListIterator : IUnknown
{
    HRESULT Current(ISegment* ppISegment);
    HRESULT First();
    HRESULT IsDone();
    HRESULT Advance();
}

@GUID("3050F604-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLCaret : IUnknown
{
    HRESULT MoveCaretToPointer(IDisplayPointer pDispPointer, BOOL fScrollIntoView, CARET_DIRECTION eDir);
    HRESULT MoveCaretToPointerEx(IDisplayPointer pDispPointer, BOOL fVisible, BOOL fScrollIntoView, 
                                 CARET_DIRECTION eDir);
    HRESULT MoveMarkupPointerToCaret(IMarkupPointer pIMarkupPointer);
    HRESULT MoveDisplayPointerToCaret(IDisplayPointer pDispPointer);
    HRESULT IsVisible(int* pIsVisible);
    HRESULT Show(BOOL fScrollIntoView);
    HRESULT Hide();
    HRESULT InsertText(ushort* pText, int lLen);
    HRESULT ScrollIntoView();
    HRESULT GetLocation(POINT* pPoint, BOOL fTranslate);
    HRESULT GetCaretDirection(CARET_DIRECTION* peDir);
    HRESULT SetCaretDirection(CARET_DIRECTION eDir);
}

@GUID("3050F683-98B5-11CF-BB82-00AA00BDCE0B")
interface ISegment : IUnknown
{
    HRESULT GetPointers(IMarkupPointer pIStart, IMarkupPointer pIEnd);
}

@GUID("3050F68F-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementSegment : ISegment
{
    HRESULT GetElement(IHTMLElement* ppIElement);
    HRESULT SetPrimary(BOOL fPrimary);
    HRESULT IsPrimary(int* pfPrimary);
}

@GUID("3050F690-98B5-11CF-BB82-00AA00BDCE0B")
interface IHighlightSegment : ISegment
{
}

@GUID("3050F606-98B5-11CF-BB82-00AA00BDCE0B")
interface IHighlightRenderingServices : IUnknown
{
    HRESULT AddSegment(IDisplayPointer pDispPointerStart, IDisplayPointer pDispPointerEnd, 
                       IHTMLRenderStyle pIRenderStyle, IHighlightSegment* ppISegment);
    HRESULT MoveSegmentToPointers(IHighlightSegment pISegment, IDisplayPointer pDispPointerStart, 
                                  IDisplayPointer pDispPointerEnd);
    HRESULT RemoveSegment(IHighlightSegment pISegment);
}

@GUID("3050F7E2-98B5-11CF-BB82-00AA00BDCE0B")
interface ILineInfo : IUnknown
{
    HRESULT get_x(int* p);
    HRESULT get_baseLine(int* p);
    HRESULT get_textDescent(int* p);
    HRESULT get_textHeight(int* p);
    HRESULT get_lineDirection(int* p);
}

@GUID("3050F69E-98B5-11CF-BB82-00AA00BDCE0B")
interface IDisplayPointer : IUnknown
{
    HRESULT MoveToPoint(POINT ptPoint, COORD_SYSTEM eCoordSystem, IHTMLElement pElementContext, 
                        uint dwHitTestOptions, uint* pdwHitTestResults);
    HRESULT MoveUnit(DISPLAY_MOVEUNIT eMoveUnit, int lXPos);
    HRESULT PositionMarkupPointer(IMarkupPointer pMarkupPointer);
    HRESULT MoveToPointer(IDisplayPointer pDispPointer);
    HRESULT SetPointerGravity(POINTER_GRAVITY eGravity);
    HRESULT GetPointerGravity(POINTER_GRAVITY* peGravity);
    HRESULT SetDisplayGravity(DISPLAY_GRAVITY eGravity);
    HRESULT GetDisplayGravity(DISPLAY_GRAVITY* peGravity);
    HRESULT IsPositioned(int* pfPositioned);
    HRESULT Unposition();
    HRESULT IsEqualTo(IDisplayPointer pDispPointer, int* pfIsEqual);
    HRESULT IsLeftOf(IDisplayPointer pDispPointer, int* pfIsLeftOf);
    HRESULT IsRightOf(IDisplayPointer pDispPointer, int* pfIsRightOf);
    HRESULT IsAtBOL(int* pfBOL);
    HRESULT MoveToMarkupPointer(IMarkupPointer pPointer, IDisplayPointer pDispLineContext);
    HRESULT ScrollIntoView();
    HRESULT GetLineInfo(ILineInfo* ppLineInfo);
    HRESULT GetFlowElement(IHTMLElement* ppLayoutElement);
    HRESULT QueryBreaks(uint* pdwBreaks);
}

@GUID("3050F69D-98B5-11CF-BB82-00AA00BDCE0B")
interface IDisplayServices : IUnknown
{
    HRESULT CreateDisplayPointer(IDisplayPointer* ppDispPointer);
    HRESULT TransformRect(RECT* pRect, COORD_SYSTEM eSource, COORD_SYSTEM eDestination, IHTMLElement pIElement);
    HRESULT TransformPoint(POINT* pPoint, COORD_SYSTEM eSource, COORD_SYSTEM eDestination, IHTMLElement pIElement);
    HRESULT GetCaret(IHTMLCaret* ppCaret);
    HRESULT GetComputedStyle(IMarkupPointer pPointer, IHTMLComputedStyle* ppComputedStyle);
    HRESULT ScrollRectIntoView(IHTMLElement pIElement, RECT rect);
    HRESULT HasFlowLayout(IHTMLElement pIElement, int* pfHasFlowLayout);
}

@GUID("3050F81A-98B5-11CF-BB82-00AA00BDCE0B")
interface IHtmlDlgSafeHelper : IDispatch
{
    HRESULT choosecolordlg(VARIANT initColor, VARIANT* rgbColor);
    HRESULT getCharset(BSTR fontName, VARIANT* charset);
    HRESULT get_Fonts(IDispatch* p);
    HRESULT get_BlockFormats(IDispatch* p);
}

@GUID("3050F830-98B5-11CF-BB82-00AA00BDCE0B")
interface IBlockFormats : IDispatch
{
    HRESULT get__NewEnum(IUnknown* p);
    HRESULT get_Count(int* p);
    HRESULT Item(VARIANT* pvarIndex, BSTR* pbstrBlockFormat);
}

@GUID("3050F839-98B5-11CF-BB82-00AA00BDCE0B")
interface IFontNames : IDispatch
{
    HRESULT get__NewEnum(IUnknown* p);
    HRESULT get_Count(int* p);
    HRESULT Item(VARIANT* pvarIndex, BSTR* pbstrFontName);
}

@GUID("3050F3EC-98B5-11CF-BB82-00AA00BDCE0B")
interface ICSSFilter : IUnknown
{
    HRESULT SetSite(ICSSFilterSite pSink);
    HRESULT OnAmbientPropertyChange(int dispid);
}

@GUID("C81984C4-74C8-11D2-BAA9-00C04FC2040E")
interface ISecureUrlHost : IUnknown
{
    HRESULT ValidateSecureUrl(int* pfAllow, ushort* pchUrlInQuestion, uint dwFlags);
}

@GUID("3050F4A0-98B5-11CF-BB82-00AA00BDCE0B")
interface IMarkupServices : IUnknown
{
    HRESULT CreateMarkupPointer(IMarkupPointer* ppPointer);
    HRESULT CreateMarkupContainer(IMarkupContainer* ppMarkupContainer);
    HRESULT CreateElement(ELEMENT_TAG_ID tagID, ushort* pchAttributes, IHTMLElement* ppElement);
    HRESULT CloneElement(IHTMLElement pElemCloneThis, IHTMLElement* ppElementTheClone);
    HRESULT InsertElement(IHTMLElement pElementInsert, IMarkupPointer pPointerStart, IMarkupPointer pPointerFinish);
    HRESULT RemoveElement(IHTMLElement pElementRemove);
    HRESULT Remove(IMarkupPointer pPointerStart, IMarkupPointer pPointerFinish);
    HRESULT Copy(IMarkupPointer pPointerSourceStart, IMarkupPointer pPointerSourceFinish, 
                 IMarkupPointer pPointerTarget);
    HRESULT Move(IMarkupPointer pPointerSourceStart, IMarkupPointer pPointerSourceFinish, 
                 IMarkupPointer pPointerTarget);
    HRESULT InsertText(ushort* pchText, int cch, IMarkupPointer pPointerTarget);
    HRESULT ParseString(ushort* pchHTML, uint dwFlags, IMarkupContainer* ppContainerResult, 
                        IMarkupPointer ppPointerStart, IMarkupPointer ppPointerFinish);
    HRESULT ParseGlobal(ptrdiff_t hglobalHTML, uint dwFlags, IMarkupContainer* ppContainerResult, 
                        IMarkupPointer pPointerStart, IMarkupPointer pPointerFinish);
    HRESULT IsScopedElement(IHTMLElement pElement, int* pfScoped);
    HRESULT GetElementTagId(IHTMLElement pElement, ELEMENT_TAG_ID* ptagId);
    HRESULT GetTagIDForName(BSTR bstrName, ELEMENT_TAG_ID* ptagId);
    HRESULT GetNameForTagID(ELEMENT_TAG_ID tagId, BSTR* pbstrName);
    HRESULT MovePointersToRange(IHTMLTxtRange pIRange, IMarkupPointer pPointerStart, IMarkupPointer pPointerFinish);
    HRESULT MoveRangeToPointers(IMarkupPointer pPointerStart, IMarkupPointer pPointerFinish, IHTMLTxtRange pIRange);
    HRESULT BeginUndoUnit(ushort* pchTitle);
    HRESULT EndUndoUnit();
}

@GUID("3050F682-98B5-11CF-BB82-00AA00BDCE0B")
interface IMarkupServices2 : IMarkupServices
{
    HRESULT ParseGlobalEx(ptrdiff_t hglobalHTML, uint dwFlags, IMarkupContainer pContext, 
                          IMarkupContainer* ppContainerResult, IMarkupPointer pPointerStart, 
                          IMarkupPointer pPointerFinish);
    HRESULT ValidateElements(IMarkupPointer pPointerStart, IMarkupPointer pPointerFinish, 
                             IMarkupPointer pPointerTarget, IMarkupPointer pPointerStatus, 
                             IHTMLElement* ppElemFailBottom, IHTMLElement* ppElemFailTop);
    HRESULT SaveSegmentsToClipboard(ISegmentList pSegmentList, uint dwFlags);
}

@GUID("3050F6E0-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLChangePlayback : IUnknown
{
    HRESULT ExecChange(ubyte* pbRecord, BOOL fForward);
}

@GUID("3050F675-98B5-11CF-BB82-00AA00BDCE0B")
interface IMarkupPointer2 : IMarkupPointer
{
    HRESULT IsAtWordBreak(int* pfAtBreak);
    HRESULT GetMarkupPosition(int* plMP);
    HRESULT MoveToMarkupPosition(IMarkupContainer pContainer, int lMP);
    HRESULT MoveUnitBounded(MOVEUNIT_ACTION muAction, IMarkupPointer pIBoundary);
    HRESULT IsInsideURL(IMarkupPointer pRight, int* pfResult);
    HRESULT MoveToContent(IHTMLElement pIElement, BOOL fAtStart);
}

@GUID("3050F5FA-98B5-11CF-BB82-00AA00BDCE0B")
interface IMarkupTextFrags : IUnknown
{
    HRESULT GetTextFragCount(int* pcFrags);
    HRESULT GetTextFrag(int iFrag, BSTR* pbstrFrag, IMarkupPointer pPointerFrag);
    HRESULT RemoveTextFrag(int iFrag);
    HRESULT InsertTextFrag(int iFrag, BSTR bstrInsert, IMarkupPointer pPointerInsert);
    HRESULT FindTextFragFromMarkupPointer(IMarkupPointer pPointerFind, int* piFrag, int* pfFragFound);
}

@GUID("E4E23071-4D07-11D2-AE76-0080C73BC199")
interface IXMLGenericParse : IUnknown
{
    HRESULT SetGenericParse(short fDoGeneric);
}

@GUID("3050F6A0-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLEditHost : IUnknown
{
    HRESULT SnapRect(IHTMLElement pIElement, RECT* prcNew, ELEMENT_CORNER eHandle);
}

@GUID("3050F848-98B5-11CF-BB82-00AA00BDCE0D")
interface IHTMLEditHost2 : IHTMLEditHost
{
    HRESULT PreDrag();
}

@GUID("3050F6C1-98B5-11CF-BB82-00AA00BDCE0B")
interface ISequenceNumber : IUnknown
{
    HRESULT GetSequenceNumber(int nCurrent, int* pnNew);
}

@GUID("3050F6CA-98B5-11CF-BB82-00AA00BDCE0B")
interface IIMEServices : IUnknown
{
    HRESULT GetActiveIMM(IActiveIMMApp* ppActiveIMM);
}

@GUID("3050F699-98B5-11CF-BB82-00AA00BDCE0B")
interface ISelectionServicesListener : IUnknown
{
    HRESULT BeginSelectionUndo();
    HRESULT EndSelectionUndo();
    HRESULT OnSelectedElementExit(IMarkupPointer pIElementStart, IMarkupPointer pIElementEnd, 
                                  IMarkupPointer pIElementContentStart, IMarkupPointer pIElementContentEnd);
    HRESULT OnChangeType(SELECTION_TYPE eType, ISelectionServicesListener pIListener);
    HRESULT GetTypeDetail(BSTR* pTypeDetail);
}

@GUID("3050F684-98B5-11CF-BB82-00AA00BDCE0B")
interface ISelectionServices : IUnknown
{
    HRESULT SetSelectionType(SELECTION_TYPE eType, ISelectionServicesListener pIListener);
    HRESULT GetMarkupContainer(IMarkupContainer* ppIContainer);
    HRESULT AddSegment(IMarkupPointer pIStart, IMarkupPointer pIEnd, ISegment* ppISegmentAdded);
    HRESULT AddElementSegment(IHTMLElement pIElement, IElementSegment* ppISegmentAdded);
    HRESULT RemoveSegment(ISegment pISegment);
    HRESULT GetSelectionServicesListener(ISelectionServicesListener* ppISelectionServicesListener);
}

@GUID("3050F662-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLEditDesigner : IUnknown
{
    HRESULT PreHandleEvent(int inEvtDispId, IHTMLEventObj pIEventObj);
    HRESULT PostHandleEvent(int inEvtDispId, IHTMLEventObj pIEventObj);
    HRESULT TranslateAcceleratorA(int inEvtDispId, IHTMLEventObj pIEventObj);
    HRESULT PostEditorEventNotify(int inEvtDispId, IHTMLEventObj pIEventObj);
}

@GUID("3050F663-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLEditServices : IUnknown
{
    HRESULT AddDesigner(IHTMLEditDesigner pIDesigner);
    HRESULT RemoveDesigner(IHTMLEditDesigner pIDesigner);
    HRESULT GetSelectionServices(IMarkupContainer pIContainer, ISelectionServices* ppSelSvc);
    HRESULT MoveToSelectionAnchor(IMarkupPointer pIStartAnchor);
    HRESULT MoveToSelectionEnd(IMarkupPointer pIEndAnchor);
    HRESULT SelectRange(IMarkupPointer pStart, IMarkupPointer pEnd, SELECTION_TYPE eType);
}

@GUID("3050F812-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLEditServices2 : IHTMLEditServices
{
    HRESULT MoveToSelectionAnchorEx(IDisplayPointer pIStartAnchor);
    HRESULT MoveToSelectionEndEx(IDisplayPointer pIEndAnchor);
    HRESULT FreezeVirtualCaretPos(BOOL fReCompute);
    HRESULT UnFreezeVirtualCaretPos(BOOL fReset);
}

@GUID("3050F6C3-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLComputedStyle : IUnknown
{
    HRESULT get_bold(short* p);
    HRESULT get_italic(short* p);
    HRESULT get_underline(short* p);
    HRESULT get_overline(short* p);
    HRESULT get_strikeOut(short* p);
    HRESULT get_subScript(short* p);
    HRESULT get_superScript(short* p);
    HRESULT get_explicitFace(short* p);
    HRESULT get_fontWeight(int* p);
    HRESULT get_fontSize(int* p);
    HRESULT get_fontName(byte* p);
    HRESULT get_hasBgColor(short* p);
    HRESULT get_textColor(uint* p);
    HRESULT get_backgroundColor(uint* p);
    HRESULT get_preFormatted(short* p);
    HRESULT get_direction(short* p);
    HRESULT get_blockDirection(short* p);
    HRESULT get_OL(short* p);
    HRESULT IsEqual(IHTMLComputedStyle pComputedStyle, short* pfEqual);
}

@GUID("30510808-98B5-11CF-BB82-00AA00BDCE0B")
interface IDeveloperConsoleMessageReceiver : IUnknown
{
    HRESULT Write(const(wchar)* source, DEV_CONSOLE_MESSAGE_LEVEL level, int messageId, const(wchar)* messageText);
    HRESULT WriteWithUrl(const(wchar)* source, DEV_CONSOLE_MESSAGE_LEVEL level, int messageId, 
                         const(wchar)* messageText, const(wchar)* fileUrl);
    HRESULT WriteWithUrlAndLine(const(wchar)* source, DEV_CONSOLE_MESSAGE_LEVEL level, int messageId, 
                                const(wchar)* messageText, const(wchar)* fileUrl, uint line);
    HRESULT WriteWithUrlLineAndColumn(const(wchar)* source, DEV_CONSOLE_MESSAGE_LEVEL level, int messageId, 
                                      const(wchar)* messageText, const(wchar)* fileUrl, uint line, uint column);
}

@GUID("3051083A-98B5-11CF-BB82-00AA00BDCE0B")
interface IScriptEventHandler : IUnknown
{
    HRESULT FunctionName(BSTR* pbstrFunctionName);
    HRESULT DebugDocumentContext(IUnknown* ppDebugDocumentContext);
    HRESULT EventHandlerDispatch(IDispatch* ppDispHandler);
    HRESULT UsesCapture(int* pfUsesCapture);
    HRESULT Cookie(ulong* pullCookie);
}

@GUID("30510842-98B5-11CF-BB82-00AA00BDCE0B")
interface IDebugCallbackNotificationHandler : IUnknown
{
    HRESULT RequestedCallbackTypes(uint* pCallbackMask);
    HRESULT BeforeDispatchEvent(IUnknown pEvent);
    HRESULT DispatchEventComplete(IUnknown pEvent, uint propagationStatus);
    HRESULT BeforeInvokeDomCallback(IUnknown pEvent, IScriptEventHandler pCallback, DOM_EVENT_PHASE eStage, 
                                    uint propagationStatus);
    HRESULT InvokeDomCallbackComplete(IUnknown pEvent, IScriptEventHandler pCallback, DOM_EVENT_PHASE eStage, 
                                      uint propagationStatus);
    HRESULT BeforeInvokeCallback(SCRIPT_TIMER_TYPE eCallbackType, uint callbackCookie, IDispatch pDispHandler, 
                                 ulong ullHandlerCookie, BSTR functionName, uint line, uint column, uint cchLength, 
                                 IUnknown pDebugDocumentContext);
    HRESULT InvokeCallbackComplete(SCRIPT_TIMER_TYPE eCallbackType, uint callbackCookie, IDispatch pDispHandler, 
                                   ulong ullHandlerCookie, BSTR functionName, uint line, uint column, uint cchLength, 
                                   IUnknown pDebugDocumentContext);
}

@GUID("30510841-98B5-11CF-BB82-00AA00BDCE0B")
interface IScriptEventHandlerSourceInfo : IUnknown
{
    HRESULT GetSourceInfo(BSTR* pbstrFunctionName, uint* line, uint* column, uint* cchLength);
}

@GUID("3051083B-98B5-11CF-BB82-00AA00BDCE0B")
interface IDOMEventRegistrationCallback : IUnknown
{
    HRESULT OnDOMEventListenerAdded(const(wchar)* pszEventType, IScriptEventHandler pHandler);
    HRESULT OnDOMEventListenerRemoved(ulong ullCookie);
}

@GUID("30510839-98B5-11CF-BB82-00AA00BDCE0B")
interface IEventTarget2 : IUnknown
{
    HRESULT GetRegisteredEventTypes(SAFEARRAY** ppEventTypeArray);
    HRESULT GetListenersForType(const(wchar)* pszEventType, SAFEARRAY** ppEventHandlerArray);
    HRESULT RegisterForDOMEventListeners(IDOMEventRegistrationCallback pCallback);
    HRESULT UnregisterForDOMEventListeners(IDOMEventRegistrationCallback pCallback);
}

@GUID("3050F6BD-98B5-11CF-BB82-00AA00BDCE0B")
interface HTMLNamespaceEvents : IDispatch
{
}

@GUID("3050F6BB-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLNamespace : IDispatch
{
    HRESULT get_name(BSTR* p);
    HRESULT get_urn(BSTR* p);
    HRESULT get_tagNames(IDispatch* p);
    HRESULT get_readyState(VARIANT* p);
    HRESULT put_onreadystatechange(VARIANT v);
    HRESULT get_onreadystatechange(VARIANT* p);
    HRESULT doImport(BSTR bstrImplementationUrl);
    HRESULT attachEvent(BSTR event, IDispatch pDisp, short* pfResult);
    HRESULT detachEvent(BSTR event, IDispatch pDisp);
}

@GUID("3050F6B8-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLNamespaceCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT item(VARIANT index, IDispatch* ppNamespace);
    HRESULT add(BSTR bstrNamespace, BSTR bstrUrn, VARIANT implementationUrl, IDispatch* ppNamespace);
}

@GUID("3050F54F-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLNamespace : IDispatch
{
}

@GUID("3050F550-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLNamespaceCollection : IDispatch
{
}

@GUID("3050F6A6-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLPainter : IUnknown
{
    HRESULT Draw(RECT rcBounds, RECT rcUpdate, int lDrawFlags, HDC hdc, void* pvDrawObject);
    HRESULT OnResize(SIZE size);
    HRESULT GetPainterInfo(HTML_PAINTER_INFO* pInfo);
    HRESULT HitTestPoint(POINT pt, int* pbHit, int* plPartID);
}

@GUID("3050F6A7-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLPaintSite : IUnknown
{
    HRESULT InvalidatePainterInfo();
    HRESULT InvalidateRect(RECT* prcInvalid);
    HRESULT InvalidateRegion(HRGN rgnInvalid);
    HRESULT GetDrawInfo(int lFlags, HTML_PAINT_DRAW_INFO* pDrawInfo);
    HRESULT TransformGlobalToLocal(POINT ptGlobal, POINT* pptLocal);
    HRESULT TransformLocalToGlobal(POINT ptLocal, POINT* pptGlobal);
    HRESULT GetHitTestCookie(int* plCookie);
}

@GUID("3050F6DF-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLPainterEventInfo : IUnknown
{
    HRESULT GetEventInfoFlags(int* plEventInfoFlags);
    HRESULT GetEventTarget(IHTMLElement* ppElement);
    HRESULT SetCursor(int lPartID);
    HRESULT StringFromPartID(int lPartID, BSTR* pbstrPart);
}

@GUID("3050F7E3-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLPainterOverlay : IUnknown
{
    HRESULT OnMove(RECT rcDevice);
}

@GUID("3050F6B5-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLIPrintCollection : IDispatch
{
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* p);
    HRESULT item(int index, IUnknown* ppIPrint);
}

@GUID("3050F844-98B5-11CF-BB82-00AA00BDCE0B")
interface IEnumPrivacyRecords : IUnknown
{
    HRESULT Reset();
    HRESULT GetSize(uint* pSize);
    HRESULT GetPrivacyImpacted(int* pState);
    HRESULT Next(BSTR* pbstrUrl, BSTR* pbstrPolicyRef, int* pdwReserved, uint* pdwPrivacyFlags);
}

@GUID("30510413-98B5-11CF-BB82-00AA00BDCE0B")
interface IWPCBlockedUrls : IUnknown
{
    HRESULT GetCount(uint* pdwCount);
    HRESULT GetUrl(uint dwIdx, BSTR* pbstrUrl);
}

@GUID("3051049C-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDOMConstructorCollection : IDispatch
{
    HRESULT get_Attr(IDispatch* p);
    HRESULT get_BehaviorUrnsCollection(IDispatch* p);
    HRESULT get_BookmarkCollection(IDispatch* p);
    HRESULT get_CompatibleInfo(IDispatch* p);
    HRESULT get_CompatibleInfoCollection(IDispatch* p);
    HRESULT get_ControlRangeCollection(IDispatch* p);
    HRESULT get_CSSCurrentStyleDeclaration(IDispatch* p);
    HRESULT get_CSSRuleList(IDispatch* p);
    HRESULT get_CSSRuleStyleDeclaration(IDispatch* p);
    HRESULT get_CSSStyleDeclaration(IDispatch* p);
    HRESULT get_CSSStyleRule(IDispatch* p);
    HRESULT get_CSSStyleSheet(IDispatch* p);
    HRESULT get_DataTransfer(IDispatch* p);
    HRESULT get_DOMImplementation(IDispatch* p);
    HRESULT get_Element(IDispatch* p);
    HRESULT get_Event(IDispatch* p);
    HRESULT get_History(IDispatch* p);
    HRESULT get_HTCElementBehaviorDefaults(IDispatch* p);
    HRESULT get_HTMLAnchorElement(IDispatch* p);
    HRESULT get_HTMLAreaElement(IDispatch* p);
    HRESULT get_HTMLAreasCollection(IDispatch* p);
    HRESULT get_HTMLBaseElement(IDispatch* p);
    HRESULT get_HTMLBaseFontElement(IDispatch* p);
    HRESULT get_HTMLBGSoundElement(IDispatch* p);
    HRESULT get_HTMLBlockElement(IDispatch* p);
    HRESULT get_HTMLBodyElement(IDispatch* p);
    HRESULT get_HTMLBRElement(IDispatch* p);
    HRESULT get_HTMLButtonElement(IDispatch* p);
    HRESULT get_HTMLCollection(IDispatch* p);
    HRESULT get_HTMLCommentElement(IDispatch* p);
    HRESULT get_HTMLDDElement(IDispatch* p);
    HRESULT get_HTMLDivElement(IDispatch* p);
    HRESULT get_HTMLDocument(IDispatch* p);
    HRESULT get_HTMLDListElement(IDispatch* p);
    HRESULT get_HTMLDTElement(IDispatch* p);
    HRESULT get_HTMLEmbedElement(IDispatch* p);
    HRESULT get_HTMLFieldSetElement(IDispatch* p);
    HRESULT get_HTMLFontElement(IDispatch* p);
    HRESULT get_HTMLFormElement(IDispatch* p);
    HRESULT get_HTMLFrameElement(IDispatch* p);
    HRESULT get_HTMLFrameSetElement(IDispatch* p);
    HRESULT get_HTMLGenericElement(IDispatch* p);
    HRESULT get_HTMLHeadElement(IDispatch* p);
    HRESULT get_HTMLHeadingElement(IDispatch* p);
    HRESULT get_HTMLHRElement(IDispatch* p);
    HRESULT get_HTMLHtmlElement(IDispatch* p);
    HRESULT get_HTMLIFrameElement(IDispatch* p);
    HRESULT get_HTMLImageElement(IDispatch* p);
    HRESULT get_HTMLInputElement(IDispatch* p);
    HRESULT get_HTMLIsIndexElement(IDispatch* p);
    HRESULT get_HTMLLabelElement(IDispatch* p);
    HRESULT get_HTMLLegendElement(IDispatch* p);
    HRESULT get_HTMLLIElement(IDispatch* p);
    HRESULT get_HTMLLinkElement(IDispatch* p);
    HRESULT get_HTMLMapElement(IDispatch* p);
    HRESULT get_HTMLMarqueeElement(IDispatch* p);
    HRESULT get_HTMLMetaElement(IDispatch* p);
    HRESULT get_HTMLModelessDialog(IDispatch* p);
    HRESULT get_HTMLNamespaceInfo(IDispatch* p);
    HRESULT get_HTMLNamespaceInfoCollection(IDispatch* p);
    HRESULT get_HTMLNextIdElement(IDispatch* p);
    HRESULT get_HTMLNoShowElement(IDispatch* p);
    HRESULT get_HTMLObjectElement(IDispatch* p);
    HRESULT get_HTMLOListElement(IDispatch* p);
    HRESULT get_HTMLOptionElement(IDispatch* p);
    HRESULT get_HTMLParagraphElement(IDispatch* p);
    HRESULT get_HTMLParamElement(IDispatch* p);
    HRESULT get_HTMLPhraseElement(IDispatch* p);
    HRESULT get_HTMLPluginsCollection(IDispatch* p);
    HRESULT get_HTMLPopup(IDispatch* p);
    HRESULT get_HTMLScriptElement(IDispatch* p);
    HRESULT get_HTMLSelectElement(IDispatch* p);
    HRESULT get_HTMLSpanElement(IDispatch* p);
    HRESULT get_HTMLStyleElement(IDispatch* p);
    HRESULT get_HTMLTableCaptionElement(IDispatch* p);
    HRESULT get_HTMLTableCellElement(IDispatch* p);
    HRESULT get_HTMLTableColElement(IDispatch* p);
    HRESULT get_HTMLTableElement(IDispatch* p);
    HRESULT get_HTMLTableRowElement(IDispatch* p);
    HRESULT get_HTMLTableSectionElement(IDispatch* p);
    HRESULT get_HTMLTextAreaElement(IDispatch* p);
    HRESULT get_HTMLTextElement(IDispatch* p);
    HRESULT get_HTMLTitleElement(IDispatch* p);
    HRESULT get_HTMLUListElement(IDispatch* p);
    HRESULT get_HTMLUnknownElement(IDispatch* p);
    HRESULT get_Image(IDispatch* p);
    HRESULT get_Location(IDispatch* p);
    HRESULT get_NamedNodeMap(IDispatch* p);
    HRESULT get_Navigator(IDispatch* p);
    HRESULT get_NodeList(IDispatch* p);
    HRESULT get_Option(IDispatch* p);
    HRESULT get_Screen(IDispatch* p);
    HRESULT get_Selection(IDispatch* p);
    HRESULT get_StaticNodeList(IDispatch* p);
    HRESULT get_Storage(IDispatch* p);
    HRESULT get_StyleSheetList(IDispatch* p);
    HRESULT get_StyleSheetPage(IDispatch* p);
    HRESULT get_StyleSheetPageList(IDispatch* p);
    HRESULT get_Text(IDispatch* p);
    HRESULT get_TextRange(IDispatch* p);
    HRESULT get_TextRangeCollection(IDispatch* p);
    HRESULT get_TextRectangle(IDispatch* p);
    HRESULT get_TextRectangleList(IDispatch* p);
    HRESULT get_Window(IDispatch* p);
    HRESULT get_XDomainRequest(IDispatch* p);
    HRESULT get_XMLHttpRequest(IDispatch* p);
}

@GUID("3050F216-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDialog : IDispatch
{
    HRESULT put_dialogTop(VARIANT v);
    HRESULT get_dialogTop(VARIANT* p);
    HRESULT put_dialogLeft(VARIANT v);
    HRESULT get_dialogLeft(VARIANT* p);
    HRESULT put_dialogWidth(VARIANT v);
    HRESULT get_dialogWidth(VARIANT* p);
    HRESULT put_dialogHeight(VARIANT v);
    HRESULT get_dialogHeight(VARIANT* p);
    HRESULT get_dialogArguments(VARIANT* p);
    HRESULT get_menuArguments(VARIANT* p);
    HRESULT put_returnValue(VARIANT v);
    HRESULT get_returnValue(VARIANT* p);
    HRESULT close();
    HRESULT toString(BSTR* String);
}

@GUID("3050F5E0-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDialog2 : IDispatch
{
    HRESULT put_status(BSTR v);
    HRESULT get_status(BSTR* p);
    HRESULT put_resizable(BSTR v);
    HRESULT get_resizable(BSTR* p);
}

@GUID("3050F388-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLDialog3 : IDispatch
{
    HRESULT put_unadorned(BSTR v);
    HRESULT get_unadorned(BSTR* p);
    HRESULT put_dialogHide(BSTR v);
    HRESULT get_dialogHide(BSTR* p);
}

@GUID("3050F5E4-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLModelessInit : IDispatch
{
    HRESULT get_parameters(VARIANT* p);
    HRESULT get_optionString(VARIANT* p);
    HRESULT get_moniker(IUnknown* p);
    HRESULT get_document(IUnknown* p);
}

@GUID("3050F666-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLPopup : IDispatch
{
    HRESULT show(int x, int y, int w, int h, VARIANT* pElement);
    HRESULT hide();
    HRESULT get_document(IHTMLDocument* p);
    HRESULT get_isOpen(short* p);
}

@GUID("3050F589-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLPopup : IDispatch
{
}

@GUID("3050F5CA-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLAppBehavior : IDispatch
{
    HRESULT put_applicationName(BSTR v);
    HRESULT get_applicationName(BSTR* p);
    HRESULT put_version(BSTR v);
    HRESULT get_version(BSTR* p);
    HRESULT put_icon(BSTR v);
    HRESULT get_icon(BSTR* p);
    HRESULT put_singleInstance(BSTR v);
    HRESULT get_singleInstance(BSTR* p);
    HRESULT put_minimizeButton(BSTR v);
    HRESULT get_minimizeButton(BSTR* p);
    HRESULT put_maximizeButton(BSTR v);
    HRESULT get_maximizeButton(BSTR* p);
    HRESULT put_border(BSTR v);
    HRESULT get_border(BSTR* p);
    HRESULT put_borderStyle(BSTR v);
    HRESULT get_borderStyle(BSTR* p);
    HRESULT put_sysMenu(BSTR v);
    HRESULT get_sysMenu(BSTR* p);
    HRESULT put_caption(BSTR v);
    HRESULT get_caption(BSTR* p);
    HRESULT put_windowState(BSTR v);
    HRESULT get_windowState(BSTR* p);
    HRESULT put_showInTaskBar(BSTR v);
    HRESULT get_showInTaskBar(BSTR* p);
    HRESULT get_commandLine(BSTR* p);
}

@GUID("3050F5C9-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLAppBehavior2 : IDispatch
{
    HRESULT put_contextMenu(BSTR v);
    HRESULT get_contextMenu(BSTR* p);
    HRESULT put_innerBorder(BSTR v);
    HRESULT get_innerBorder(BSTR* p);
    HRESULT put_scroll(BSTR v);
    HRESULT get_scroll(BSTR* p);
    HRESULT put_scrollFlat(BSTR v);
    HRESULT get_scrollFlat(BSTR* p);
    HRESULT put_selection(BSTR v);
    HRESULT get_selection(BSTR* p);
}

@GUID("3050F5CD-98B5-11CF-BB82-00AA00BDCE0B")
interface IHTMLAppBehavior3 : IDispatch
{
    HRESULT put_navigable(BSTR v);
    HRESULT get_navigable(BSTR* p);
}

@GUID("3050F57C-98B5-11CF-BB82-00AA00BDCE0B")
interface DispHTMLAppBehavior : IDispatch
{
}

@GUID("3050F51E-98B5-11CF-BB82-00AA00BDCE0B")
interface DispIHTMLInputButtonElement : IDispatch
{
}

@GUID("3050F520-98B5-11CF-BB82-00AA00BDCE0B")
interface DispIHTMLInputTextElement : IDispatch
{
}

@GUID("3050F542-98B5-11CF-BB82-00AA00BDCE0B")
interface DispIHTMLInputFileElement : IDispatch
{
}

@GUID("3050F509-98B5-11CF-BB82-00AA00BDCE0B")
interface DispIHTMLOptionButtonElement : IDispatch
{
}

@GUID("3050F51D-98B5-11CF-BB82-00AA00BDCE0B")
interface DispIHTMLInputImage : IDispatch
{
}

@GUID("3050F671-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementNamespace : IUnknown
{
    HRESULT AddTag(BSTR bstrTagName, int lFlags);
}

@GUID("3050F670-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementNamespaceTable : IUnknown
{
    HRESULT AddNamespace(BSTR bstrNamespace, BSTR bstrUrn, int lFlags, VARIANT* pvarFactory);
}

@GUID("3050F672-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementNamespaceFactory : IUnknown
{
    HRESULT Create(IElementNamespace pNamespace);
}

@GUID("3050F805-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementNamespaceFactory2 : IElementNamespaceFactory
{
    HRESULT CreateWithImplementation(IElementNamespace pNamespace, BSTR bstrImplementation);
}

@GUID("3050F7FD-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementNamespaceFactoryCallback : IUnknown
{
    HRESULT Resolve(BSTR bstrNamespace, BSTR bstrTagName, BSTR bstrAttrs, IElementNamespace pNamespace);
}

@GUID("3050F659-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementBehaviorSiteOM2 : IElementBehaviorSiteOM
{
    HRESULT GetDefaults(IHTMLElementDefaults* ppDefaults);
}

@GUID("3050F4ED-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementBehaviorCategory : IUnknown
{
    HRESULT GetCategory(ushort** ppchCategory);
}

@GUID("3050F4EE-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementBehaviorSiteCategory : IUnknown
{
    HRESULT GetRelatedBehaviors(int lDirection, ushort* pchCategory, IEnumUnknown* ppEnumerator);
}

@GUID("3050F646-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementBehaviorSubmit : IUnknown
{
    HRESULT GetSubmitInfo(IHTMLSubmitData pSubmitData);
    HRESULT Reset();
}

@GUID("3050F6B6-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementBehaviorFocus : IUnknown
{
    HRESULT GetFocusRect(RECT* pRect);
}

@GUID("3050F6BA-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementBehaviorLayout : IUnknown
{
    HRESULT GetSize(int dwFlags, SIZE sizeContent, POINT* pptTranslateBy, POINT* pptTopLeft, SIZE* psizeProposed);
    HRESULT GetLayoutInfo(int* plLayoutInfo);
    HRESULT GetPosition(int lFlags, POINT* pptTopLeft);
    HRESULT MapSize(SIZE* psizeIn, RECT* prcOut);
}

@GUID("3050F846-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementBehaviorLayout2 : IUnknown
{
    HRESULT GetTextDescent(int* plDescent);
}

@GUID("3050F6B7-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementBehaviorSiteLayout : IUnknown
{
    HRESULT InvalidateLayoutInfo();
    HRESULT InvalidateSize();
    HRESULT GetMediaResolution(SIZE* psizeResolution);
}

@GUID("3050F847-98B5-11CF-BB82-00AA00BDCE0B")
interface IElementBehaviorSiteLayout2 : IUnknown
{
    HRESULT GetFontInfo(LOGFONTW* plf);
}

@GUID("3050F842-98B5-11CF-BB82-00AA00BDCE0B")
interface IHostBehaviorInit : IUnknown
{
    HRESULT PopulateNamespaceTable();
}

@GUID("305106E2-98B5-11CF-BB82-00AA00BDCE0B")
interface ISurfacePresenter : IUnknown
{
    HRESULT Present(uint uBuffer, RECT* pDirty);
    HRESULT GetBuffer(uint backBufferIndex, const(GUID)* riid, void** ppBuffer);
    HRESULT IsCurrent(int* pIsCurrent);
}

@GUID("305106E1-98B5-11CF-BB82-00AA00BDCE0B")
interface IViewObjectPresentSite : IUnknown
{
    HRESULT CreateSurfacePresenter(IUnknown pDevice, uint width, uint height, uint backBufferCount, 
                                   DXGI_FORMAT format, VIEW_OBJECT_ALPHA_MODE mode, ISurfacePresenter* ppQueue);
    HRESULT IsHardwareComposition(int* pIsHardwareComposition);
    HRESULT SetCompositionMode(VIEW_OBJECT_COMPOSITION_MODE mode);
}

@GUID("305107F9-98B5-11CF-BB82-00AA00BDCE0B")
interface ICanvasPixelArrayData : IUnknown
{
    HRESULT GetBufferPointer(ubyte** ppBuffer, uint* pBufferLength);
}

@GUID("305106E3-98B5-11CF-BB82-00AA00BDCE0B")
interface IViewObjectPrint : IUnknown
{
    HRESULT GetPrintBitmap(IUnknown* ppPrintBitmap);
}

@GUID("305107FA-98B5-11CF-BB82-00AA00BDCE0B")
interface IViewObjectPresentNotifySite : IViewObjectPresentSite
{
    HRESULT RequestFrame();
}

@GUID("305107F8-98B5-11CF-BB82-00AA00BDCE0B")
interface IViewObjectPresentNotify : IUnknown
{
    HRESULT OnPreRender();
}

@GUID("30510803-98B5-11CF-BB82-00AA00BDCE0B")
interface ITrackingProtection : IUnknown
{
    HRESULT EvaluateUrl(BSTR bstrUrl, int* pfAllowed);
    HRESULT GetEnabled(int* pfEnabled);
}

@GUID("30510861-98B5-11CF-BB82-00AA00BDCE0B")
interface IBFCacheable : IUnknown
{
    HRESULT EnterBFCache();
    HRESULT ExitBFCache();
}

@GUID("7C3F6998-1567-4BBA-B52B-48D32141D613")
interface IWebApplicationScriptEvents : IUnknown
{
    HRESULT BeforeScriptExecute(IHTMLWindow2 htmlWindow);
    HRESULT ScriptError(IHTMLWindow2 htmlWindow, IActiveScriptError scriptError, const(wchar)* url, 
                        BOOL errorHandled);
}

@GUID("C22615D2-D318-4DA2-8422-1FCAF77B10E4")
interface IWebApplicationNavigationEvents : IUnknown
{
    HRESULT BeforeNavigate(IHTMLWindow2 htmlWindow, const(wchar)* url, uint navigationFlags, 
                           const(wchar)* targetFrameName);
    HRESULT NavigateComplete(IHTMLWindow2 htmlWindow, const(wchar)* url);
    HRESULT NavigateError(IHTMLWindow2 htmlWindow, const(wchar)* url, const(wchar)* targetFrameName, 
                          uint statusCode);
    HRESULT DocumentComplete(IHTMLWindow2 htmlWindow, const(wchar)* url);
    HRESULT DownloadBegin();
    HRESULT DownloadComplete();
}

@GUID("5B2B3F99-328C-41D5-A6F7-7483ED8E71DD")
interface IWebApplicationUIEvents : IUnknown
{
    HRESULT SecurityProblem(uint securityProblem, int* result);
}

@GUID("3E59E6B7-C652-4DAF-AD5E-16FEB350CDE3")
interface IWebApplicationUpdateEvents : IUnknown
{
    HRESULT OnPaint();
    HRESULT OnCssChanged();
}

@GUID("CECBD2C3-A3A5-4749-9681-20E9161C6794")
interface IWebApplicationHost : IUnknown
{
    HRESULT get_HWND(HWND* hwnd);
    HRESULT get_Document(IHTMLDocument2* htmlDocument);
    HRESULT Refresh();
    HRESULT Advise(const(GUID)* interfaceId, IUnknown callback, uint* cookie);
    HRESULT Unadvise(uint cookie);
}

@GUID("BCDCD0DE-330E-481B-B843-4898A6A8EBAC")
interface IWebApplicationActivation : IUnknown
{
    HRESULT CancelPendingActivation();
}

@GUID("720AEA93-1964-4DB0-B005-29EB9E2B18A9")
interface IWebApplicationAuthoringMode : IServiceProvider
{
    HRESULT get_AuthoringClientBinary(BSTR* designModeDllPath);
}


// GUIDs

const GUID CLSID_ApplicationCache                     = GUIDOF!ApplicationCache;
const GUID CLSID_BlockFormats                         = GUIDOF!BlockFormats;
const GUID CLSID_CClientCaps                          = GUIDOF!CClientCaps;
const GUID CLSID_CDebugDocumentHelper                 = GUIDOF!CDebugDocumentHelper;
const GUID CLSID_CEventObj                            = GUIDOF!CEventObj;
const GUID CLSID_CMimeTypes                           = GUIDOF!CMimeTypes;
const GUID CLSID_COpsProfile                          = GUIDOF!COpsProfile;
const GUID CLSID_CPlugins                             = GUIDOF!CPlugins;
const GUID CLSID_CPrintManagerTemplatePrinter         = GUIDOF!CPrintManagerTemplatePrinter;
const GUID CLSID_CTemplatePrinter                     = GUIDOF!CTemplatePrinter;
const GUID CLSID_CanvasGradient                       = GUIDOF!CanvasGradient;
const GUID CLSID_CanvasImageData                      = GUIDOF!CanvasImageData;
const GUID CLSID_CanvasPattern                        = GUIDOF!CanvasPattern;
const GUID CLSID_CanvasRenderingContext2D             = GUIDOF!CanvasRenderingContext2D;
const GUID CLSID_CanvasTextMetrics                    = GUIDOF!CanvasTextMetrics;
const GUID CLSID_DOMBeforeUnloadEvent                 = GUIDOF!DOMBeforeUnloadEvent;
const GUID CLSID_DOMChildrenCollection                = GUIDOF!DOMChildrenCollection;
const GUID CLSID_DOMCloseEvent                        = GUIDOF!DOMCloseEvent;
const GUID CLSID_DOMCompositionEvent                  = GUIDOF!DOMCompositionEvent;
const GUID CLSID_DOMCustomEvent                       = GUIDOF!DOMCustomEvent;
const GUID CLSID_DOMDocumentType                      = GUIDOF!DOMDocumentType;
const GUID CLSID_DOMDragEvent                         = GUIDOF!DOMDragEvent;
const GUID CLSID_DOMEvent                             = GUIDOF!DOMEvent;
const GUID CLSID_DOMException                         = GUIDOF!DOMException;
const GUID CLSID_DOMFocusEvent                        = GUIDOF!DOMFocusEvent;
const GUID CLSID_DOMKeyboardEvent                     = GUIDOF!DOMKeyboardEvent;
const GUID CLSID_DOMMSAnimationEvent                  = GUIDOF!DOMMSAnimationEvent;
const GUID CLSID_DOMMSManipulationEvent               = GUIDOF!DOMMSManipulationEvent;
const GUID CLSID_DOMMSTransitionEvent                 = GUIDOF!DOMMSTransitionEvent;
const GUID CLSID_DOMMessageEvent                      = GUIDOF!DOMMessageEvent;
const GUID CLSID_DOMMouseEvent                        = GUIDOF!DOMMouseEvent;
const GUID CLSID_DOMMouseWheelEvent                   = GUIDOF!DOMMouseWheelEvent;
const GUID CLSID_DOMMutationEvent                     = GUIDOF!DOMMutationEvent;
const GUID CLSID_DOMParser                            = GUIDOF!DOMParser;
const GUID CLSID_DOMParserFactory                     = GUIDOF!DOMParserFactory;
const GUID CLSID_DOMProcessingInstruction             = GUIDOF!DOMProcessingInstruction;
const GUID CLSID_DOMProgressEvent                     = GUIDOF!DOMProgressEvent;
const GUID CLSID_DOMSiteModeEvent                     = GUIDOF!DOMSiteModeEvent;
const GUID CLSID_DOMStorageEvent                      = GUIDOF!DOMStorageEvent;
const GUID CLSID_DOMTextEvent                         = GUIDOF!DOMTextEvent;
const GUID CLSID_DOMUIEvent                           = GUIDOF!DOMUIEvent;
const GUID CLSID_DOMWheelEvent                        = GUIDOF!DOMWheelEvent;
const GUID CLSID_DebugHelper                          = GUIDOF!DebugHelper;
const GUID CLSID_DefaultDebugSessionProvider          = GUIDOF!DefaultDebugSessionProvider;
const GUID CLSID_EventException                       = GUIDOF!EventException;
const GUID CLSID_FontNames                            = GUIDOF!FontNames;
const GUID CLSID_FramesCollection                     = GUIDOF!FramesCollection;
const GUID CLSID_HTCAttachBehavior                    = GUIDOF!HTCAttachBehavior;
const GUID CLSID_HTCDefaultDispatch                   = GUIDOF!HTCDefaultDispatch;
const GUID CLSID_HTCDescBehavior                      = GUIDOF!HTCDescBehavior;
const GUID CLSID_HTCEventBehavior                     = GUIDOF!HTCEventBehavior;
const GUID CLSID_HTCMethodBehavior                    = GUIDOF!HTCMethodBehavior;
const GUID CLSID_HTCPropertyBehavior                  = GUIDOF!HTCPropertyBehavior;
const GUID CLSID_HTMLAnchorElement                    = GUIDOF!HTMLAnchorElement;
const GUID CLSID_HTMLAppBehavior                      = GUIDOF!HTMLAppBehavior;
const GUID CLSID_HTMLAreaElement                      = GUIDOF!HTMLAreaElement;
const GUID CLSID_HTMLAreasCollection                  = GUIDOF!HTMLAreasCollection;
const GUID CLSID_HTMLAttributeCollection              = GUIDOF!HTMLAttributeCollection;
const GUID CLSID_HTMLAudioElement                     = GUIDOF!HTMLAudioElement;
const GUID CLSID_HTMLAudioElementFactory              = GUIDOF!HTMLAudioElementFactory;
const GUID CLSID_HTMLBGsound                          = GUIDOF!HTMLBGsound;
const GUID CLSID_HTMLBRElement                        = GUIDOF!HTMLBRElement;
const GUID CLSID_HTMLBaseElement                      = GUIDOF!HTMLBaseElement;
const GUID CLSID_HTMLBaseFontElement                  = GUIDOF!HTMLBaseFontElement;
const GUID CLSID_HTMLBlockElement                     = GUIDOF!HTMLBlockElement;
const GUID CLSID_HTMLBody                             = GUIDOF!HTMLBody;
const GUID CLSID_HTMLButtonElement                    = GUIDOF!HTMLButtonElement;
const GUID CLSID_HTMLCSSImportRule                    = GUIDOF!HTMLCSSImportRule;
const GUID CLSID_HTMLCSSMediaList                     = GUIDOF!HTMLCSSMediaList;
const GUID CLSID_HTMLCSSMediaRule                     = GUIDOF!HTMLCSSMediaRule;
const GUID CLSID_HTMLCSSNamespaceRule                 = GUIDOF!HTMLCSSNamespaceRule;
const GUID CLSID_HTMLCSSRule                          = GUIDOF!HTMLCSSRule;
const GUID CLSID_HTMLCSSStyleDeclaration              = GUIDOF!HTMLCSSStyleDeclaration;
const GUID CLSID_HTMLCanvasElement                    = GUIDOF!HTMLCanvasElement;
const GUID CLSID_HTMLCommentElement                   = GUIDOF!HTMLCommentElement;
const GUID CLSID_HTMLCurrentStyle                     = GUIDOF!HTMLCurrentStyle;
const GUID CLSID_HTMLDDElement                        = GUIDOF!HTMLDDElement;
const GUID CLSID_HTMLDListElement                     = GUIDOF!HTMLDListElement;
const GUID CLSID_HTMLDOMAttribute                     = GUIDOF!HTMLDOMAttribute;
const GUID CLSID_HTMLDOMImplementation                = GUIDOF!HTMLDOMImplementation;
const GUID CLSID_HTMLDOMRange                         = GUIDOF!HTMLDOMRange;
const GUID CLSID_HTMLDOMTextNode                      = GUIDOF!HTMLDOMTextNode;
const GUID CLSID_HTMLDOMXmlSerializerFactory          = GUIDOF!HTMLDOMXmlSerializerFactory;
const GUID CLSID_HTMLDTElement                        = GUIDOF!HTMLDTElement;
const GUID CLSID_HTMLDefaults                         = GUIDOF!HTMLDefaults;
const GUID CLSID_HTMLDialog                           = GUIDOF!HTMLDialog;
const GUID CLSID_HTMLDivElement                       = GUIDOF!HTMLDivElement;
const GUID CLSID_HTMLDivPosition                      = GUIDOF!HTMLDivPosition;
const GUID CLSID_HTMLDocument                         = GUIDOF!HTMLDocument;
const GUID CLSID_HTMLDocumentCompatibleInfo           = GUIDOF!HTMLDocumentCompatibleInfo;
const GUID CLSID_HTMLDocumentCompatibleInfoCollection = GUIDOF!HTMLDocumentCompatibleInfoCollection;
const GUID CLSID_HTMLElementCollection                = GUIDOF!HTMLElementCollection;
const GUID CLSID_HTMLEmbed                            = GUIDOF!HTMLEmbed;
const GUID CLSID_HTMLFieldSetElement                  = GUIDOF!HTMLFieldSetElement;
const GUID CLSID_HTMLFontElement                      = GUIDOF!HTMLFontElement;
const GUID CLSID_HTMLFormElement                      = GUIDOF!HTMLFormElement;
const GUID CLSID_HTMLFrameBase                        = GUIDOF!HTMLFrameBase;
const GUID CLSID_HTMLFrameElement                     = GUIDOF!HTMLFrameElement;
const GUID CLSID_HTMLFrameSetSite                     = GUIDOF!HTMLFrameSetSite;
const GUID CLSID_HTMLGenericElement                   = GUIDOF!HTMLGenericElement;
const GUID CLSID_HTMLHRElement                        = GUIDOF!HTMLHRElement;
const GUID CLSID_HTMLHeadElement                      = GUIDOF!HTMLHeadElement;
const GUID CLSID_HTMLHeaderElement                    = GUIDOF!HTMLHeaderElement;
const GUID CLSID_HTMLHistory                          = GUIDOF!HTMLHistory;
const GUID CLSID_HTMLHtmlElement                      = GUIDOF!HTMLHtmlElement;
const GUID CLSID_HTMLIFrame                           = GUIDOF!HTMLIFrame;
const GUID CLSID_HTMLImageElementFactory              = GUIDOF!HTMLImageElementFactory;
const GUID CLSID_HTMLImg                              = GUIDOF!HTMLImg;
const GUID CLSID_HTMLInputButtonElement               = GUIDOF!HTMLInputButtonElement;
const GUID CLSID_HTMLInputElement                     = GUIDOF!HTMLInputElement;
const GUID CLSID_HTMLInputFileElement                 = GUIDOF!HTMLInputFileElement;
const GUID CLSID_HTMLInputImage                       = GUIDOF!HTMLInputImage;
const GUID CLSID_HTMLInputTextElement                 = GUIDOF!HTMLInputTextElement;
const GUID CLSID_HTMLIsIndexElement                   = GUIDOF!HTMLIsIndexElement;
const GUID CLSID_HTMLLIElement                        = GUIDOF!HTMLLIElement;
const GUID CLSID_HTMLLabelElement                     = GUIDOF!HTMLLabelElement;
const GUID CLSID_HTMLLegendElement                    = GUIDOF!HTMLLegendElement;
const GUID CLSID_HTMLLinkElement                      = GUIDOF!HTMLLinkElement;
const GUID CLSID_HTMLListElement                      = GUIDOF!HTMLListElement;
const GUID CLSID_HTMLLocation                         = GUIDOF!HTMLLocation;
const GUID CLSID_HTMLMSCSSKeyframeRule                = GUIDOF!HTMLMSCSSKeyframeRule;
const GUID CLSID_HTMLMSCSSKeyframesRule               = GUIDOF!HTMLMSCSSKeyframesRule;
const GUID CLSID_HTMLMapElement                       = GUIDOF!HTMLMapElement;
const GUID CLSID_HTMLMarqueeElement                   = GUIDOF!HTMLMarqueeElement;
const GUID CLSID_HTMLMediaElement                     = GUIDOF!HTMLMediaElement;
const GUID CLSID_HTMLMediaError                       = GUIDOF!HTMLMediaError;
const GUID CLSID_HTMLMetaElement                      = GUIDOF!HTMLMetaElement;
const GUID CLSID_HTMLNamespace                        = GUIDOF!HTMLNamespace;
const GUID CLSID_HTMLNamespaceCollection              = GUIDOF!HTMLNamespaceCollection;
const GUID CLSID_HTMLNavigator                        = GUIDOF!HTMLNavigator;
const GUID CLSID_HTMLNextIdElement                    = GUIDOF!HTMLNextIdElement;
const GUID CLSID_HTMLNoShowElement                    = GUIDOF!HTMLNoShowElement;
const GUID CLSID_HTMLOListElement                     = GUIDOF!HTMLOListElement;
const GUID CLSID_HTMLObjectElement                    = GUIDOF!HTMLObjectElement;
const GUID CLSID_HTMLOptionButtonElement              = GUIDOF!HTMLOptionButtonElement;
const GUID CLSID_HTMLOptionElement                    = GUIDOF!HTMLOptionElement;
const GUID CLSID_HTMLOptionElementFactory             = GUIDOF!HTMLOptionElementFactory;
const GUID CLSID_HTMLParaElement                      = GUIDOF!HTMLParaElement;
const GUID CLSID_HTMLParamElement                     = GUIDOF!HTMLParamElement;
const GUID CLSID_HTMLPerformance                      = GUIDOF!HTMLPerformance;
const GUID CLSID_HTMLPerformanceNavigation            = GUIDOF!HTMLPerformanceNavigation;
const GUID CLSID_HTMLPerformanceTiming                = GUIDOF!HTMLPerformanceTiming;
const GUID CLSID_HTMLPhraseElement                    = GUIDOF!HTMLPhraseElement;
const GUID CLSID_HTMLPopup                            = GUIDOF!HTMLPopup;
const GUID CLSID_HTMLProgressElement                  = GUIDOF!HTMLProgressElement;
const GUID CLSID_HTMLRenderStyle                      = GUIDOF!HTMLRenderStyle;
const GUID CLSID_HTMLRichtextElement                  = GUIDOF!HTMLRichtextElement;
const GUID CLSID_HTMLRuleStyle                        = GUIDOF!HTMLRuleStyle;
const GUID CLSID_HTMLScreen                           = GUIDOF!HTMLScreen;
const GUID CLSID_HTMLScriptElement                    = GUIDOF!HTMLScriptElement;
const GUID CLSID_HTMLSelectElement                    = GUIDOF!HTMLSelectElement;
const GUID CLSID_HTMLSemanticElement                  = GUIDOF!HTMLSemanticElement;
const GUID CLSID_HTMLSourceElement                    = GUIDOF!HTMLSourceElement;
const GUID CLSID_HTMLSpanElement                      = GUIDOF!HTMLSpanElement;
const GUID CLSID_HTMLSpanFlow                         = GUIDOF!HTMLSpanFlow;
const GUID CLSID_HTMLStorage                          = GUIDOF!HTMLStorage;
const GUID CLSID_HTMLStyle                            = GUIDOF!HTMLStyle;
const GUID CLSID_HTMLStyleElement                     = GUIDOF!HTMLStyleElement;
const GUID CLSID_HTMLStyleFontFace                    = GUIDOF!HTMLStyleFontFace;
const GUID CLSID_HTMLStyleMedia                       = GUIDOF!HTMLStyleMedia;
const GUID CLSID_HTMLStyleSheet                       = GUIDOF!HTMLStyleSheet;
const GUID CLSID_HTMLStyleSheetPage                   = GUIDOF!HTMLStyleSheetPage;
const GUID CLSID_HTMLStyleSheetPagesCollection        = GUIDOF!HTMLStyleSheetPagesCollection;
const GUID CLSID_HTMLStyleSheetRule                   = GUIDOF!HTMLStyleSheetRule;
const GUID CLSID_HTMLStyleSheetRulesAppliedCollection = GUIDOF!HTMLStyleSheetRulesAppliedCollection;
const GUID CLSID_HTMLStyleSheetRulesCollection        = GUIDOF!HTMLStyleSheetRulesCollection;
const GUID CLSID_HTMLStyleSheetsCollection            = GUIDOF!HTMLStyleSheetsCollection;
const GUID CLSID_HTMLTable                            = GUIDOF!HTMLTable;
const GUID CLSID_HTMLTableCaption                     = GUIDOF!HTMLTableCaption;
const GUID CLSID_HTMLTableCell                        = GUIDOF!HTMLTableCell;
const GUID CLSID_HTMLTableCol                         = GUIDOF!HTMLTableCol;
const GUID CLSID_HTMLTableRow                         = GUIDOF!HTMLTableRow;
const GUID CLSID_HTMLTableSection                     = GUIDOF!HTMLTableSection;
const GUID CLSID_HTMLTextAreaElement                  = GUIDOF!HTMLTextAreaElement;
const GUID CLSID_HTMLTextElement                      = GUIDOF!HTMLTextElement;
const GUID CLSID_HTMLTimeRanges                       = GUIDOF!HTMLTimeRanges;
const GUID CLSID_HTMLTitleElement                     = GUIDOF!HTMLTitleElement;
const GUID CLSID_HTMLUListElement                     = GUIDOF!HTMLUListElement;
const GUID CLSID_HTMLUnknownElement                   = GUIDOF!HTMLUnknownElement;
const GUID CLSID_HTMLUrnCollection                    = GUIDOF!HTMLUrnCollection;
const GUID CLSID_HTMLVideoElement                     = GUIDOF!HTMLVideoElement;
const GUID CLSID_HTMLW3CComputedStyle                 = GUIDOF!HTMLW3CComputedStyle;
const GUID CLSID_HTMLWindow2                          = GUIDOF!HTMLWindow2;
const GUID CLSID_HTMLWindowProxy                      = GUIDOF!HTMLWindowProxy;
const GUID CLSID_HTMLWndOptionElement                 = GUIDOF!HTMLWndOptionElement;
const GUID CLSID_HTMLWndSelectElement                 = GUIDOF!HTMLWndSelectElement;
const GUID CLSID_HTMLXMLHttpRequest                   = GUIDOF!HTMLXMLHttpRequest;
const GUID CLSID_HTMLXMLHttpRequestFactory            = GUIDOF!HTMLXMLHttpRequestFactory;
const GUID CLSID_HtmlDlgSafeHelper                    = GUIDOF!HtmlDlgSafeHelper;
const GUID CLSID_MachineDebugManager_DEBUG            = GUIDOF!MachineDebugManager_DEBUG;
const GUID CLSID_MachineDebugManager_RETAIL           = GUIDOF!MachineDebugManager_RETAIL;
const GUID CLSID_NodeIterator                         = GUIDOF!NodeIterator;
const GUID CLSID_OldHTMLDocument                      = GUIDOF!OldHTMLDocument;
const GUID CLSID_OldHTMLFormElement                   = GUIDOF!OldHTMLFormElement;
const GUID CLSID_ProcessDebugManager                  = GUIDOF!ProcessDebugManager;
const GUID CLSID_RangeException                       = GUIDOF!RangeException;
const GUID CLSID_RulesApplied                         = GUIDOF!RulesApplied;
const GUID CLSID_RulesAppliedCollection               = GUIDOF!RulesAppliedCollection;
const GUID CLSID_SVGAElement                          = GUIDOF!SVGAElement;
const GUID CLSID_SVGAngle                             = GUIDOF!SVGAngle;
const GUID CLSID_SVGAnimatedAngle                     = GUIDOF!SVGAnimatedAngle;
const GUID CLSID_SVGAnimatedBoolean                   = GUIDOF!SVGAnimatedBoolean;
const GUID CLSID_SVGAnimatedEnumeration               = GUIDOF!SVGAnimatedEnumeration;
const GUID CLSID_SVGAnimatedInteger                   = GUIDOF!SVGAnimatedInteger;
const GUID CLSID_SVGAnimatedLength                    = GUIDOF!SVGAnimatedLength;
const GUID CLSID_SVGAnimatedLengthList                = GUIDOF!SVGAnimatedLengthList;
const GUID CLSID_SVGAnimatedNumber                    = GUIDOF!SVGAnimatedNumber;
const GUID CLSID_SVGAnimatedNumberList                = GUIDOF!SVGAnimatedNumberList;
const GUID CLSID_SVGAnimatedPreserveAspectRatio       = GUIDOF!SVGAnimatedPreserveAspectRatio;
const GUID CLSID_SVGAnimatedRect                      = GUIDOF!SVGAnimatedRect;
const GUID CLSID_SVGAnimatedString                    = GUIDOF!SVGAnimatedString;
const GUID CLSID_SVGAnimatedTransformList             = GUIDOF!SVGAnimatedTransformList;
const GUID CLSID_SVGCircleElement                     = GUIDOF!SVGCircleElement;
const GUID CLSID_SVGClipPathElement                   = GUIDOF!SVGClipPathElement;
const GUID CLSID_SVGDefsElement                       = GUIDOF!SVGDefsElement;
const GUID CLSID_SVGDescElement                       = GUIDOF!SVGDescElement;
const GUID CLSID_SVGElement                           = GUIDOF!SVGElement;
const GUID CLSID_SVGElementInstance                   = GUIDOF!SVGElementInstance;
const GUID CLSID_SVGElementInstanceList               = GUIDOF!SVGElementInstanceList;
const GUID CLSID_SVGEllipseElement                    = GUIDOF!SVGEllipseElement;
const GUID CLSID_SVGException                         = GUIDOF!SVGException;
const GUID CLSID_SVGGElement                          = GUIDOF!SVGGElement;
const GUID CLSID_SVGGradientElement                   = GUIDOF!SVGGradientElement;
const GUID CLSID_SVGImageElement                      = GUIDOF!SVGImageElement;
const GUID CLSID_SVGLength                            = GUIDOF!SVGLength;
const GUID CLSID_SVGLengthList                        = GUIDOF!SVGLengthList;
const GUID CLSID_SVGLineElement                       = GUIDOF!SVGLineElement;
const GUID CLSID_SVGLinearGradientElement             = GUIDOF!SVGLinearGradientElement;
const GUID CLSID_SVGMarkerElement                     = GUIDOF!SVGMarkerElement;
const GUID CLSID_SVGMaskElement                       = GUIDOF!SVGMaskElement;
const GUID CLSID_SVGMatrix                            = GUIDOF!SVGMatrix;
const GUID CLSID_SVGMetadataElement                   = GUIDOF!SVGMetadataElement;
const GUID CLSID_SVGNumber                            = GUIDOF!SVGNumber;
const GUID CLSID_SVGNumberList                        = GUIDOF!SVGNumberList;
const GUID CLSID_SVGPathElement                       = GUIDOF!SVGPathElement;
const GUID CLSID_SVGPathSeg                           = GUIDOF!SVGPathSeg;
const GUID CLSID_SVGPathSegArcAbs                     = GUIDOF!SVGPathSegArcAbs;
const GUID CLSID_SVGPathSegArcRel                     = GUIDOF!SVGPathSegArcRel;
const GUID CLSID_SVGPathSegClosePath                  = GUIDOF!SVGPathSegClosePath;
const GUID CLSID_SVGPathSegCurvetoCubicAbs            = GUIDOF!SVGPathSegCurvetoCubicAbs;
const GUID CLSID_SVGPathSegCurvetoCubicRel            = GUIDOF!SVGPathSegCurvetoCubicRel;
const GUID CLSID_SVGPathSegCurvetoCubicSmoothAbs      = GUIDOF!SVGPathSegCurvetoCubicSmoothAbs;
const GUID CLSID_SVGPathSegCurvetoCubicSmoothRel      = GUIDOF!SVGPathSegCurvetoCubicSmoothRel;
const GUID CLSID_SVGPathSegCurvetoQuadraticAbs        = GUIDOF!SVGPathSegCurvetoQuadraticAbs;
const GUID CLSID_SVGPathSegCurvetoQuadraticRel        = GUIDOF!SVGPathSegCurvetoQuadraticRel;
const GUID CLSID_SVGPathSegCurvetoQuadraticSmoothAbs  = GUIDOF!SVGPathSegCurvetoQuadraticSmoothAbs;
const GUID CLSID_SVGPathSegCurvetoQuadraticSmoothRel  = GUIDOF!SVGPathSegCurvetoQuadraticSmoothRel;
const GUID CLSID_SVGPathSegLinetoAbs                  = GUIDOF!SVGPathSegLinetoAbs;
const GUID CLSID_SVGPathSegLinetoHorizontalAbs        = GUIDOF!SVGPathSegLinetoHorizontalAbs;
const GUID CLSID_SVGPathSegLinetoHorizontalRel        = GUIDOF!SVGPathSegLinetoHorizontalRel;
const GUID CLSID_SVGPathSegLinetoRel                  = GUIDOF!SVGPathSegLinetoRel;
const GUID CLSID_SVGPathSegLinetoVerticalAbs          = GUIDOF!SVGPathSegLinetoVerticalAbs;
const GUID CLSID_SVGPathSegLinetoVerticalRel          = GUIDOF!SVGPathSegLinetoVerticalRel;
const GUID CLSID_SVGPathSegList                       = GUIDOF!SVGPathSegList;
const GUID CLSID_SVGPathSegMovetoAbs                  = GUIDOF!SVGPathSegMovetoAbs;
const GUID CLSID_SVGPathSegMovetoRel                  = GUIDOF!SVGPathSegMovetoRel;
const GUID CLSID_SVGPatternElement                    = GUIDOF!SVGPatternElement;
const GUID CLSID_SVGPoint                             = GUIDOF!SVGPoint;
const GUID CLSID_SVGPointList                         = GUIDOF!SVGPointList;
const GUID CLSID_SVGPolygonElement                    = GUIDOF!SVGPolygonElement;
const GUID CLSID_SVGPolylineElement                   = GUIDOF!SVGPolylineElement;
const GUID CLSID_SVGPreserveAspectRatio               = GUIDOF!SVGPreserveAspectRatio;
const GUID CLSID_SVGRadialGradientElement             = GUIDOF!SVGRadialGradientElement;
const GUID CLSID_SVGRect                              = GUIDOF!SVGRect;
const GUID CLSID_SVGRectElement                       = GUIDOF!SVGRectElement;
const GUID CLSID_SVGSVGElement                        = GUIDOF!SVGSVGElement;
const GUID CLSID_SVGScriptElement                     = GUIDOF!SVGScriptElement;
const GUID CLSID_SVGStopElement                       = GUIDOF!SVGStopElement;
const GUID CLSID_SVGStringList                        = GUIDOF!SVGStringList;
const GUID CLSID_SVGStyleElement                      = GUIDOF!SVGStyleElement;
const GUID CLSID_SVGSwitchElement                     = GUIDOF!SVGSwitchElement;
const GUID CLSID_SVGSymbolElement                     = GUIDOF!SVGSymbolElement;
const GUID CLSID_SVGTSpanElement                      = GUIDOF!SVGTSpanElement;
const GUID CLSID_SVGTextContentElement                = GUIDOF!SVGTextContentElement;
const GUID CLSID_SVGTextElement                       = GUIDOF!SVGTextElement;
const GUID CLSID_SVGTextPathElement                   = GUIDOF!SVGTextPathElement;
const GUID CLSID_SVGTextPositioningElement            = GUIDOF!SVGTextPositioningElement;
const GUID CLSID_SVGTitleElement                      = GUIDOF!SVGTitleElement;
const GUID CLSID_SVGTransform                         = GUIDOF!SVGTransform;
const GUID CLSID_SVGTransformList                     = GUIDOF!SVGTransformList;
const GUID CLSID_SVGUseElement                        = GUIDOF!SVGUseElement;
const GUID CLSID_SVGViewElement                       = GUIDOF!SVGViewElement;
const GUID CLSID_SVGZoomEvent                         = GUIDOF!SVGZoomEvent;
const GUID CLSID_Scriptlet                            = GUIDOF!Scriptlet;
const GUID CLSID_StaticNodeList                       = GUIDOF!StaticNodeList;
const GUID CLSID_ThreadDialogProcParam                = GUIDOF!ThreadDialogProcParam;
const GUID CLSID_TreeWalker                           = GUIDOF!TreeWalker;
const GUID CLSID_WebGeocoordinates                    = GUIDOF!WebGeocoordinates;
const GUID CLSID_WebGeolocation                       = GUIDOF!WebGeolocation;
const GUID CLSID_WebGeoposition                       = GUIDOF!WebGeoposition;
const GUID CLSID_WebGeopositionError                  = GUIDOF!WebGeopositionError;
const GUID CLSID_XDomainRequest                       = GUIDOF!XDomainRequest;
const GUID CLSID_XDomainRequestFactory                = GUIDOF!XDomainRequestFactory;
const GUID CLSID_XMLHttpRequestEventTarget            = GUIDOF!XMLHttpRequestEventTarget;
const GUID CLSID_XMLSerializer                        = GUIDOF!XMLSerializer;

const GUID IID_AsyncIDebugApplicationNodeEvents         = GUIDOF!AsyncIDebugApplicationNodeEvents;
const GUID IID_DWebBridgeEvents                         = GUIDOF!DWebBridgeEvents;
const GUID IID_DispApplicationCache                     = GUIDOF!DispApplicationCache;
const GUID IID_DispCEventObj                            = GUIDOF!DispCEventObj;
const GUID IID_DispCPlugins                             = GUIDOF!DispCPlugins;
const GUID IID_DispCPrintManagerTemplatePrinter         = GUIDOF!DispCPrintManagerTemplatePrinter;
const GUID IID_DispCanvasGradient                       = GUIDOF!DispCanvasGradient;
const GUID IID_DispCanvasImageData                      = GUIDOF!DispCanvasImageData;
const GUID IID_DispCanvasPattern                        = GUIDOF!DispCanvasPattern;
const GUID IID_DispCanvasRenderingContext2D             = GUIDOF!DispCanvasRenderingContext2D;
const GUID IID_DispCanvasTextMetrics                    = GUIDOF!DispCanvasTextMetrics;
const GUID IID_DispDOMBeforeUnloadEvent                 = GUIDOF!DispDOMBeforeUnloadEvent;
const GUID IID_DispDOMChildrenCollection                = GUIDOF!DispDOMChildrenCollection;
const GUID IID_DispDOMCloseEvent                        = GUIDOF!DispDOMCloseEvent;
const GUID IID_DispDOMCompositionEvent                  = GUIDOF!DispDOMCompositionEvent;
const GUID IID_DispDOMCustomEvent                       = GUIDOF!DispDOMCustomEvent;
const GUID IID_DispDOMDocumentType                      = GUIDOF!DispDOMDocumentType;
const GUID IID_DispDOMDragEvent                         = GUIDOF!DispDOMDragEvent;
const GUID IID_DispDOMEvent                             = GUIDOF!DispDOMEvent;
const GUID IID_DispDOMException                         = GUIDOF!DispDOMException;
const GUID IID_DispDOMFocusEvent                        = GUIDOF!DispDOMFocusEvent;
const GUID IID_DispDOMKeyboardEvent                     = GUIDOF!DispDOMKeyboardEvent;
const GUID IID_DispDOMMSAnimationEvent                  = GUIDOF!DispDOMMSAnimationEvent;
const GUID IID_DispDOMMSManipulationEvent               = GUIDOF!DispDOMMSManipulationEvent;
const GUID IID_DispDOMMSTransitionEvent                 = GUIDOF!DispDOMMSTransitionEvent;
const GUID IID_DispDOMMessageEvent                      = GUIDOF!DispDOMMessageEvent;
const GUID IID_DispDOMMouseEvent                        = GUIDOF!DispDOMMouseEvent;
const GUID IID_DispDOMMouseWheelEvent                   = GUIDOF!DispDOMMouseWheelEvent;
const GUID IID_DispDOMMutationEvent                     = GUIDOF!DispDOMMutationEvent;
const GUID IID_DispDOMParser                            = GUIDOF!DispDOMParser;
const GUID IID_DispDOMProcessingInstruction             = GUIDOF!DispDOMProcessingInstruction;
const GUID IID_DispDOMProgressEvent                     = GUIDOF!DispDOMProgressEvent;
const GUID IID_DispDOMSiteModeEvent                     = GUIDOF!DispDOMSiteModeEvent;
const GUID IID_DispDOMStorageEvent                      = GUIDOF!DispDOMStorageEvent;
const GUID IID_DispDOMTextEvent                         = GUIDOF!DispDOMTextEvent;
const GUID IID_DispDOMUIEvent                           = GUIDOF!DispDOMUIEvent;
const GUID IID_DispDOMWheelEvent                        = GUIDOF!DispDOMWheelEvent;
const GUID IID_DispEventException                       = GUIDOF!DispEventException;
const GUID IID_DispHTCAttachBehavior                    = GUIDOF!DispHTCAttachBehavior;
const GUID IID_DispHTCDefaultDispatch                   = GUIDOF!DispHTCDefaultDispatch;
const GUID IID_DispHTCDescBehavior                      = GUIDOF!DispHTCDescBehavior;
const GUID IID_DispHTCEventBehavior                     = GUIDOF!DispHTCEventBehavior;
const GUID IID_DispHTCMethodBehavior                    = GUIDOF!DispHTCMethodBehavior;
const GUID IID_DispHTCPropertyBehavior                  = GUIDOF!DispHTCPropertyBehavior;
const GUID IID_DispHTMLAnchorElement                    = GUIDOF!DispHTMLAnchorElement;
const GUID IID_DispHTMLAppBehavior                      = GUIDOF!DispHTMLAppBehavior;
const GUID IID_DispHTMLAreaElement                      = GUIDOF!DispHTMLAreaElement;
const GUID IID_DispHTMLAreasCollection                  = GUIDOF!DispHTMLAreasCollection;
const GUID IID_DispHTMLAttributeCollection              = GUIDOF!DispHTMLAttributeCollection;
const GUID IID_DispHTMLAudioElement                     = GUIDOF!DispHTMLAudioElement;
const GUID IID_DispHTMLBGsound                          = GUIDOF!DispHTMLBGsound;
const GUID IID_DispHTMLBRElement                        = GUIDOF!DispHTMLBRElement;
const GUID IID_DispHTMLBaseElement                      = GUIDOF!DispHTMLBaseElement;
const GUID IID_DispHTMLBaseFontElement                  = GUIDOF!DispHTMLBaseFontElement;
const GUID IID_DispHTMLBlockElement                     = GUIDOF!DispHTMLBlockElement;
const GUID IID_DispHTMLBody                             = GUIDOF!DispHTMLBody;
const GUID IID_DispHTMLButtonElement                    = GUIDOF!DispHTMLButtonElement;
const GUID IID_DispHTMLCSSImportRule                    = GUIDOF!DispHTMLCSSImportRule;
const GUID IID_DispHTMLCSSMediaList                     = GUIDOF!DispHTMLCSSMediaList;
const GUID IID_DispHTMLCSSMediaRule                     = GUIDOF!DispHTMLCSSMediaRule;
const GUID IID_DispHTMLCSSNamespaceRule                 = GUIDOF!DispHTMLCSSNamespaceRule;
const GUID IID_DispHTMLCSSRule                          = GUIDOF!DispHTMLCSSRule;
const GUID IID_DispHTMLCSSStyleDeclaration              = GUIDOF!DispHTMLCSSStyleDeclaration;
const GUID IID_DispHTMLCanvasElement                    = GUIDOF!DispHTMLCanvasElement;
const GUID IID_DispHTMLCommentElement                   = GUIDOF!DispHTMLCommentElement;
const GUID IID_DispHTMLCurrentStyle                     = GUIDOF!DispHTMLCurrentStyle;
const GUID IID_DispHTMLDDElement                        = GUIDOF!DispHTMLDDElement;
const GUID IID_DispHTMLDListElement                     = GUIDOF!DispHTMLDListElement;
const GUID IID_DispHTMLDOMAttribute                     = GUIDOF!DispHTMLDOMAttribute;
const GUID IID_DispHTMLDOMImplementation                = GUIDOF!DispHTMLDOMImplementation;
const GUID IID_DispHTMLDOMRange                         = GUIDOF!DispHTMLDOMRange;
const GUID IID_DispHTMLDOMTextNode                      = GUIDOF!DispHTMLDOMTextNode;
const GUID IID_DispHTMLDTElement                        = GUIDOF!DispHTMLDTElement;
const GUID IID_DispHTMLDefaults                         = GUIDOF!DispHTMLDefaults;
const GUID IID_DispHTMLDivElement                       = GUIDOF!DispHTMLDivElement;
const GUID IID_DispHTMLDivPosition                      = GUIDOF!DispHTMLDivPosition;
const GUID IID_DispHTMLDocument                         = GUIDOF!DispHTMLDocument;
const GUID IID_DispHTMLDocumentCompatibleInfo           = GUIDOF!DispHTMLDocumentCompatibleInfo;
const GUID IID_DispHTMLDocumentCompatibleInfoCollection = GUIDOF!DispHTMLDocumentCompatibleInfoCollection;
const GUID IID_DispHTMLElementCollection                = GUIDOF!DispHTMLElementCollection;
const GUID IID_DispHTMLEmbed                            = GUIDOF!DispHTMLEmbed;
const GUID IID_DispHTMLFieldSetElement                  = GUIDOF!DispHTMLFieldSetElement;
const GUID IID_DispHTMLFontElement                      = GUIDOF!DispHTMLFontElement;
const GUID IID_DispHTMLFormElement                      = GUIDOF!DispHTMLFormElement;
const GUID IID_DispHTMLFrameBase                        = GUIDOF!DispHTMLFrameBase;
const GUID IID_DispHTMLFrameElement                     = GUIDOF!DispHTMLFrameElement;
const GUID IID_DispHTMLFrameSetSite                     = GUIDOF!DispHTMLFrameSetSite;
const GUID IID_DispHTMLGenericElement                   = GUIDOF!DispHTMLGenericElement;
const GUID IID_DispHTMLHRElement                        = GUIDOF!DispHTMLHRElement;
const GUID IID_DispHTMLHeadElement                      = GUIDOF!DispHTMLHeadElement;
const GUID IID_DispHTMLHeaderElement                    = GUIDOF!DispHTMLHeaderElement;
const GUID IID_DispHTMLHistory                          = GUIDOF!DispHTMLHistory;
const GUID IID_DispHTMLHtmlElement                      = GUIDOF!DispHTMLHtmlElement;
const GUID IID_DispHTMLIFrame                           = GUIDOF!DispHTMLIFrame;
const GUID IID_DispHTMLImg                              = GUIDOF!DispHTMLImg;
const GUID IID_DispHTMLInputElement                     = GUIDOF!DispHTMLInputElement;
const GUID IID_DispHTMLIsIndexElement                   = GUIDOF!DispHTMLIsIndexElement;
const GUID IID_DispHTMLLIElement                        = GUIDOF!DispHTMLLIElement;
const GUID IID_DispHTMLLabelElement                     = GUIDOF!DispHTMLLabelElement;
const GUID IID_DispHTMLLegendElement                    = GUIDOF!DispHTMLLegendElement;
const GUID IID_DispHTMLLinkElement                      = GUIDOF!DispHTMLLinkElement;
const GUID IID_DispHTMLListElement                      = GUIDOF!DispHTMLListElement;
const GUID IID_DispHTMLLocation                         = GUIDOF!DispHTMLLocation;
const GUID IID_DispHTMLMSCSSKeyframeRule                = GUIDOF!DispHTMLMSCSSKeyframeRule;
const GUID IID_DispHTMLMSCSSKeyframesRule               = GUIDOF!DispHTMLMSCSSKeyframesRule;
const GUID IID_DispHTMLMapElement                       = GUIDOF!DispHTMLMapElement;
const GUID IID_DispHTMLMarqueeElement                   = GUIDOF!DispHTMLMarqueeElement;
const GUID IID_DispHTMLMediaElement                     = GUIDOF!DispHTMLMediaElement;
const GUID IID_DispHTMLMediaError                       = GUIDOF!DispHTMLMediaError;
const GUID IID_DispHTMLMetaElement                      = GUIDOF!DispHTMLMetaElement;
const GUID IID_DispHTMLNamespace                        = GUIDOF!DispHTMLNamespace;
const GUID IID_DispHTMLNamespaceCollection              = GUIDOF!DispHTMLNamespaceCollection;
const GUID IID_DispHTMLNavigator                        = GUIDOF!DispHTMLNavigator;
const GUID IID_DispHTMLNextIdElement                    = GUIDOF!DispHTMLNextIdElement;
const GUID IID_DispHTMLNoShowElement                    = GUIDOF!DispHTMLNoShowElement;
const GUID IID_DispHTMLOListElement                     = GUIDOF!DispHTMLOListElement;
const GUID IID_DispHTMLObjectElement                    = GUIDOF!DispHTMLObjectElement;
const GUID IID_DispHTMLOptionElement                    = GUIDOF!DispHTMLOptionElement;
const GUID IID_DispHTMLParaElement                      = GUIDOF!DispHTMLParaElement;
const GUID IID_DispHTMLParamElement                     = GUIDOF!DispHTMLParamElement;
const GUID IID_DispHTMLPerformance                      = GUIDOF!DispHTMLPerformance;
const GUID IID_DispHTMLPerformanceNavigation            = GUIDOF!DispHTMLPerformanceNavigation;
const GUID IID_DispHTMLPerformanceTiming                = GUIDOF!DispHTMLPerformanceTiming;
const GUID IID_DispHTMLPhraseElement                    = GUIDOF!DispHTMLPhraseElement;
const GUID IID_DispHTMLPopup                            = GUIDOF!DispHTMLPopup;
const GUID IID_DispHTMLProgressElement                  = GUIDOF!DispHTMLProgressElement;
const GUID IID_DispHTMLRenderStyle                      = GUIDOF!DispHTMLRenderStyle;
const GUID IID_DispHTMLRichtextElement                  = GUIDOF!DispHTMLRichtextElement;
const GUID IID_DispHTMLRuleStyle                        = GUIDOF!DispHTMLRuleStyle;
const GUID IID_DispHTMLScreen                           = GUIDOF!DispHTMLScreen;
const GUID IID_DispHTMLScriptElement                    = GUIDOF!DispHTMLScriptElement;
const GUID IID_DispHTMLSelectElement                    = GUIDOF!DispHTMLSelectElement;
const GUID IID_DispHTMLSemanticElement                  = GUIDOF!DispHTMLSemanticElement;
const GUID IID_DispHTMLSourceElement                    = GUIDOF!DispHTMLSourceElement;
const GUID IID_DispHTMLSpanElement                      = GUIDOF!DispHTMLSpanElement;
const GUID IID_DispHTMLSpanFlow                         = GUIDOF!DispHTMLSpanFlow;
const GUID IID_DispHTMLStorage                          = GUIDOF!DispHTMLStorage;
const GUID IID_DispHTMLStyle                            = GUIDOF!DispHTMLStyle;
const GUID IID_DispHTMLStyleElement                     = GUIDOF!DispHTMLStyleElement;
const GUID IID_DispHTMLStyleFontFace                    = GUIDOF!DispHTMLStyleFontFace;
const GUID IID_DispHTMLStyleMedia                       = GUIDOF!DispHTMLStyleMedia;
const GUID IID_DispHTMLStyleSheet                       = GUIDOF!DispHTMLStyleSheet;
const GUID IID_DispHTMLStyleSheetPage                   = GUIDOF!DispHTMLStyleSheetPage;
const GUID IID_DispHTMLStyleSheetPagesCollection        = GUIDOF!DispHTMLStyleSheetPagesCollection;
const GUID IID_DispHTMLStyleSheetRule                   = GUIDOF!DispHTMLStyleSheetRule;
const GUID IID_DispHTMLStyleSheetRulesAppliedCollection = GUIDOF!DispHTMLStyleSheetRulesAppliedCollection;
const GUID IID_DispHTMLStyleSheetRulesCollection        = GUIDOF!DispHTMLStyleSheetRulesCollection;
const GUID IID_DispHTMLStyleSheetsCollection            = GUIDOF!DispHTMLStyleSheetsCollection;
const GUID IID_DispHTMLTable                            = GUIDOF!DispHTMLTable;
const GUID IID_DispHTMLTableCaption                     = GUIDOF!DispHTMLTableCaption;
const GUID IID_DispHTMLTableCell                        = GUIDOF!DispHTMLTableCell;
const GUID IID_DispHTMLTableCol                         = GUIDOF!DispHTMLTableCol;
const GUID IID_DispHTMLTableRow                         = GUIDOF!DispHTMLTableRow;
const GUID IID_DispHTMLTableSection                     = GUIDOF!DispHTMLTableSection;
const GUID IID_DispHTMLTextAreaElement                  = GUIDOF!DispHTMLTextAreaElement;
const GUID IID_DispHTMLTextElement                      = GUIDOF!DispHTMLTextElement;
const GUID IID_DispHTMLTimeRanges                       = GUIDOF!DispHTMLTimeRanges;
const GUID IID_DispHTMLTitleElement                     = GUIDOF!DispHTMLTitleElement;
const GUID IID_DispHTMLUListElement                     = GUIDOF!DispHTMLUListElement;
const GUID IID_DispHTMLUnknownElement                   = GUIDOF!DispHTMLUnknownElement;
const GUID IID_DispHTMLUrnCollection                    = GUIDOF!DispHTMLUrnCollection;
const GUID IID_DispHTMLVideoElement                     = GUIDOF!DispHTMLVideoElement;
const GUID IID_DispHTMLW3CComputedStyle                 = GUIDOF!DispHTMLW3CComputedStyle;
const GUID IID_DispHTMLWindow2                          = GUIDOF!DispHTMLWindow2;
const GUID IID_DispHTMLWindowProxy                      = GUIDOF!DispHTMLWindowProxy;
const GUID IID_DispHTMLWndOptionElement                 = GUIDOF!DispHTMLWndOptionElement;
const GUID IID_DispHTMLWndSelectElement                 = GUIDOF!DispHTMLWndSelectElement;
const GUID IID_DispHTMLXMLHttpRequest                   = GUIDOF!DispHTMLXMLHttpRequest;
const GUID IID_DispIHTMLInputButtonElement              = GUIDOF!DispIHTMLInputButtonElement;
const GUID IID_DispIHTMLInputFileElement                = GUIDOF!DispIHTMLInputFileElement;
const GUID IID_DispIHTMLInputImage                      = GUIDOF!DispIHTMLInputImage;
const GUID IID_DispIHTMLInputTextElement                = GUIDOF!DispIHTMLInputTextElement;
const GUID IID_DispIHTMLOptionButtonElement             = GUIDOF!DispIHTMLOptionButtonElement;
const GUID IID_DispNodeIterator                         = GUIDOF!DispNodeIterator;
const GUID IID_DispRangeException                       = GUIDOF!DispRangeException;
const GUID IID_DispRulesApplied                         = GUIDOF!DispRulesApplied;
const GUID IID_DispRulesAppliedCollection               = GUIDOF!DispRulesAppliedCollection;
const GUID IID_DispSVGAElement                          = GUIDOF!DispSVGAElement;
const GUID IID_DispSVGCircleElement                     = GUIDOF!DispSVGCircleElement;
const GUID IID_DispSVGClipPathElement                   = GUIDOF!DispSVGClipPathElement;
const GUID IID_DispSVGDefsElement                       = GUIDOF!DispSVGDefsElement;
const GUID IID_DispSVGDescElement                       = GUIDOF!DispSVGDescElement;
const GUID IID_DispSVGElement                           = GUIDOF!DispSVGElement;
const GUID IID_DispSVGElementInstance                   = GUIDOF!DispSVGElementInstance;
const GUID IID_DispSVGElementInstanceList               = GUIDOF!DispSVGElementInstanceList;
const GUID IID_DispSVGEllipseElement                    = GUIDOF!DispSVGEllipseElement;
const GUID IID_DispSVGException                         = GUIDOF!DispSVGException;
const GUID IID_DispSVGGElement                          = GUIDOF!DispSVGGElement;
const GUID IID_DispSVGGradientElement                   = GUIDOF!DispSVGGradientElement;
const GUID IID_DispSVGImageElement                      = GUIDOF!DispSVGImageElement;
const GUID IID_DispSVGLineElement                       = GUIDOF!DispSVGLineElement;
const GUID IID_DispSVGLinearGradientElement             = GUIDOF!DispSVGLinearGradientElement;
const GUID IID_DispSVGMarkerElement                     = GUIDOF!DispSVGMarkerElement;
const GUID IID_DispSVGMaskElement                       = GUIDOF!DispSVGMaskElement;
const GUID IID_DispSVGMetadataElement                   = GUIDOF!DispSVGMetadataElement;
const GUID IID_DispSVGPathElement                       = GUIDOF!DispSVGPathElement;
const GUID IID_DispSVGPathSegArcAbs                     = GUIDOF!DispSVGPathSegArcAbs;
const GUID IID_DispSVGPathSegArcRel                     = GUIDOF!DispSVGPathSegArcRel;
const GUID IID_DispSVGPathSegClosePath                  = GUIDOF!DispSVGPathSegClosePath;
const GUID IID_DispSVGPathSegCurvetoCubicAbs            = GUIDOF!DispSVGPathSegCurvetoCubicAbs;
const GUID IID_DispSVGPathSegCurvetoCubicRel            = GUIDOF!DispSVGPathSegCurvetoCubicRel;
const GUID IID_DispSVGPathSegCurvetoCubicSmoothAbs      = GUIDOF!DispSVGPathSegCurvetoCubicSmoothAbs;
const GUID IID_DispSVGPathSegCurvetoCubicSmoothRel      = GUIDOF!DispSVGPathSegCurvetoCubicSmoothRel;
const GUID IID_DispSVGPathSegCurvetoQuadraticAbs        = GUIDOF!DispSVGPathSegCurvetoQuadraticAbs;
const GUID IID_DispSVGPathSegCurvetoQuadraticRel        = GUIDOF!DispSVGPathSegCurvetoQuadraticRel;
const GUID IID_DispSVGPathSegCurvetoQuadraticSmoothAbs  = GUIDOF!DispSVGPathSegCurvetoQuadraticSmoothAbs;
const GUID IID_DispSVGPathSegCurvetoQuadraticSmoothRel  = GUIDOF!DispSVGPathSegCurvetoQuadraticSmoothRel;
const GUID IID_DispSVGPathSegLinetoAbs                  = GUIDOF!DispSVGPathSegLinetoAbs;
const GUID IID_DispSVGPathSegLinetoHorizontalAbs        = GUIDOF!DispSVGPathSegLinetoHorizontalAbs;
const GUID IID_DispSVGPathSegLinetoHorizontalRel        = GUIDOF!DispSVGPathSegLinetoHorizontalRel;
const GUID IID_DispSVGPathSegLinetoRel                  = GUIDOF!DispSVGPathSegLinetoRel;
const GUID IID_DispSVGPathSegLinetoVerticalAbs          = GUIDOF!DispSVGPathSegLinetoVerticalAbs;
const GUID IID_DispSVGPathSegLinetoVerticalRel          = GUIDOF!DispSVGPathSegLinetoVerticalRel;
const GUID IID_DispSVGPathSegMovetoAbs                  = GUIDOF!DispSVGPathSegMovetoAbs;
const GUID IID_DispSVGPathSegMovetoRel                  = GUIDOF!DispSVGPathSegMovetoRel;
const GUID IID_DispSVGPatternElement                    = GUIDOF!DispSVGPatternElement;
const GUID IID_DispSVGPolygonElement                    = GUIDOF!DispSVGPolygonElement;
const GUID IID_DispSVGPolylineElement                   = GUIDOF!DispSVGPolylineElement;
const GUID IID_DispSVGRadialGradientElement             = GUIDOF!DispSVGRadialGradientElement;
const GUID IID_DispSVGRectElement                       = GUIDOF!DispSVGRectElement;
const GUID IID_DispSVGSVGElement                        = GUIDOF!DispSVGSVGElement;
const GUID IID_DispSVGScriptElement                     = GUIDOF!DispSVGScriptElement;
const GUID IID_DispSVGStopElement                       = GUIDOF!DispSVGStopElement;
const GUID IID_DispSVGStyleElement                      = GUIDOF!DispSVGStyleElement;
const GUID IID_DispSVGSwitchElement                     = GUIDOF!DispSVGSwitchElement;
const GUID IID_DispSVGSymbolElement                     = GUIDOF!DispSVGSymbolElement;
const GUID IID_DispSVGTSpanElement                      = GUIDOF!DispSVGTSpanElement;
const GUID IID_DispSVGTextContentElement                = GUIDOF!DispSVGTextContentElement;
const GUID IID_DispSVGTextElement                       = GUIDOF!DispSVGTextElement;
const GUID IID_DispSVGTextPathElement                   = GUIDOF!DispSVGTextPathElement;
const GUID IID_DispSVGTextPositioningElement            = GUIDOF!DispSVGTextPositioningElement;
const GUID IID_DispSVGTitleElement                      = GUIDOF!DispSVGTitleElement;
const GUID IID_DispSVGUseElement                        = GUIDOF!DispSVGUseElement;
const GUID IID_DispSVGViewElement                       = GUIDOF!DispSVGViewElement;
const GUID IID_DispSVGZoomEvent                         = GUIDOF!DispSVGZoomEvent;
const GUID IID_DispStaticNodeList                       = GUIDOF!DispStaticNodeList;
const GUID IID_DispTreeWalker                           = GUIDOF!DispTreeWalker;
const GUID IID_DispWebGeocoordinates                    = GUIDOF!DispWebGeocoordinates;
const GUID IID_DispWebGeolocation                       = GUIDOF!DispWebGeolocation;
const GUID IID_DispWebGeoposition                       = GUIDOF!DispWebGeoposition;
const GUID IID_DispWebGeopositionError                  = GUIDOF!DispWebGeopositionError;
const GUID IID_DispXDomainRequest                       = GUIDOF!DispXDomainRequest;
const GUID IID_DispXMLHttpRequestEventTarget            = GUIDOF!DispXMLHttpRequestEventTarget;
const GUID IID_DispXMLSerializer                        = GUIDOF!DispXMLSerializer;
const GUID IID_HTMLAnchorEvents                         = GUIDOF!HTMLAnchorEvents;
const GUID IID_HTMLAnchorEvents2                        = GUIDOF!HTMLAnchorEvents2;
const GUID IID_HTMLAreaEvents                           = GUIDOF!HTMLAreaEvents;
const GUID IID_HTMLAreaEvents2                          = GUIDOF!HTMLAreaEvents2;
const GUID IID_HTMLButtonElementEvents                  = GUIDOF!HTMLButtonElementEvents;
const GUID IID_HTMLButtonElementEvents2                 = GUIDOF!HTMLButtonElementEvents2;
const GUID IID_HTMLControlElementEvents                 = GUIDOF!HTMLControlElementEvents;
const GUID IID_HTMLControlElementEvents2                = GUIDOF!HTMLControlElementEvents2;
const GUID IID_HTMLDocumentEvents                       = GUIDOF!HTMLDocumentEvents;
const GUID IID_HTMLDocumentEvents2                      = GUIDOF!HTMLDocumentEvents2;
const GUID IID_HTMLDocumentEvents3                      = GUIDOF!HTMLDocumentEvents3;
const GUID IID_HTMLDocumentEvents4                      = GUIDOF!HTMLDocumentEvents4;
const GUID IID_HTMLElementEvents                        = GUIDOF!HTMLElementEvents;
const GUID IID_HTMLElementEvents2                       = GUIDOF!HTMLElementEvents2;
const GUID IID_HTMLElementEvents3                       = GUIDOF!HTMLElementEvents3;
const GUID IID_HTMLElementEvents4                       = GUIDOF!HTMLElementEvents4;
const GUID IID_HTMLFormElementEvents                    = GUIDOF!HTMLFormElementEvents;
const GUID IID_HTMLFormElementEvents2                   = GUIDOF!HTMLFormElementEvents2;
const GUID IID_HTMLFrameSiteEvents                      = GUIDOF!HTMLFrameSiteEvents;
const GUID IID_HTMLFrameSiteEvents2                     = GUIDOF!HTMLFrameSiteEvents2;
const GUID IID_HTMLImgEvents                            = GUIDOF!HTMLImgEvents;
const GUID IID_HTMLImgEvents2                           = GUIDOF!HTMLImgEvents2;
const GUID IID_HTMLInputFileElementEvents               = GUIDOF!HTMLInputFileElementEvents;
const GUID IID_HTMLInputFileElementEvents2              = GUIDOF!HTMLInputFileElementEvents2;
const GUID IID_HTMLInputImageEvents                     = GUIDOF!HTMLInputImageEvents;
const GUID IID_HTMLInputImageEvents2                    = GUIDOF!HTMLInputImageEvents2;
const GUID IID_HTMLInputTextElementEvents               = GUIDOF!HTMLInputTextElementEvents;
const GUID IID_HTMLInputTextElementEvents2              = GUIDOF!HTMLInputTextElementEvents2;
const GUID IID_HTMLLabelEvents                          = GUIDOF!HTMLLabelEvents;
const GUID IID_HTMLLabelEvents2                         = GUIDOF!HTMLLabelEvents2;
const GUID IID_HTMLLinkElementEvents                    = GUIDOF!HTMLLinkElementEvents;
const GUID IID_HTMLLinkElementEvents2                   = GUIDOF!HTMLLinkElementEvents2;
const GUID IID_HTMLMapEvents                            = GUIDOF!HTMLMapEvents;
const GUID IID_HTMLMapEvents2                           = GUIDOF!HTMLMapEvents2;
const GUID IID_HTMLMarqueeElementEvents                 = GUIDOF!HTMLMarqueeElementEvents;
const GUID IID_HTMLMarqueeElementEvents2                = GUIDOF!HTMLMarqueeElementEvents2;
const GUID IID_HTMLNamespaceEvents                      = GUIDOF!HTMLNamespaceEvents;
const GUID IID_HTMLObjectElementEvents                  = GUIDOF!HTMLObjectElementEvents;
const GUID IID_HTMLObjectElementEvents2                 = GUIDOF!HTMLObjectElementEvents2;
const GUID IID_HTMLOptionButtonElementEvents            = GUIDOF!HTMLOptionButtonElementEvents;
const GUID IID_HTMLOptionButtonElementEvents2           = GUIDOF!HTMLOptionButtonElementEvents2;
const GUID IID_HTMLScriptEvents                         = GUIDOF!HTMLScriptEvents;
const GUID IID_HTMLScriptEvents2                        = GUIDOF!HTMLScriptEvents2;
const GUID IID_HTMLSelectElementEvents                  = GUIDOF!HTMLSelectElementEvents;
const GUID IID_HTMLSelectElementEvents2                 = GUIDOF!HTMLSelectElementEvents2;
const GUID IID_HTMLStyleElementEvents                   = GUIDOF!HTMLStyleElementEvents;
const GUID IID_HTMLStyleElementEvents2                  = GUIDOF!HTMLStyleElementEvents2;
const GUID IID_HTMLTableEvents                          = GUIDOF!HTMLTableEvents;
const GUID IID_HTMLTableEvents2                         = GUIDOF!HTMLTableEvents2;
const GUID IID_HTMLTextContainerEvents                  = GUIDOF!HTMLTextContainerEvents;
const GUID IID_HTMLTextContainerEvents2                 = GUIDOF!HTMLTextContainerEvents2;
const GUID IID_HTMLWindowEvents                         = GUIDOF!HTMLWindowEvents;
const GUID IID_HTMLWindowEvents2                        = GUIDOF!HTMLWindowEvents2;
const GUID IID_HTMLWindowEvents3                        = GUIDOF!HTMLWindowEvents3;
const GUID IID_HTMLXMLHttpRequestEvents                 = GUIDOF!HTMLXMLHttpRequestEvents;
const GUID IID_IActiveScript                            = GUIDOF!IActiveScript;
const GUID IID_IActiveScriptDebug32                     = GUIDOF!IActiveScriptDebug32;
const GUID IID_IActiveScriptDebug64                     = GUIDOF!IActiveScriptDebug64;
const GUID IID_IActiveScriptEncode                      = GUIDOF!IActiveScriptEncode;
const GUID IID_IActiveScriptError                       = GUIDOF!IActiveScriptError;
const GUID IID_IActiveScriptError64                     = GUIDOF!IActiveScriptError64;
const GUID IID_IActiveScriptErrorDebug                  = GUIDOF!IActiveScriptErrorDebug;
const GUID IID_IActiveScriptGarbageCollector            = GUIDOF!IActiveScriptGarbageCollector;
const GUID IID_IActiveScriptHostEncode                  = GUIDOF!IActiveScriptHostEncode;
const GUID IID_IActiveScriptParse32                     = GUIDOF!IActiveScriptParse32;
const GUID IID_IActiveScriptParse64                     = GUIDOF!IActiveScriptParse64;
const GUID IID_IActiveScriptParseProcedure2_32          = GUIDOF!IActiveScriptParseProcedure2_32;
const GUID IID_IActiveScriptParseProcedure2_64          = GUIDOF!IActiveScriptParseProcedure2_64;
const GUID IID_IActiveScriptParseProcedure32            = GUIDOF!IActiveScriptParseProcedure32;
const GUID IID_IActiveScriptParseProcedure64            = GUIDOF!IActiveScriptParseProcedure64;
const GUID IID_IActiveScriptParseProcedureOld32         = GUIDOF!IActiveScriptParseProcedureOld32;
const GUID IID_IActiveScriptParseProcedureOld64         = GUIDOF!IActiveScriptParseProcedureOld64;
const GUID IID_IActiveScriptProfilerCallback            = GUIDOF!IActiveScriptProfilerCallback;
const GUID IID_IActiveScriptProfilerCallback2           = GUIDOF!IActiveScriptProfilerCallback2;
const GUID IID_IActiveScriptProfilerCallback3           = GUIDOF!IActiveScriptProfilerCallback3;
const GUID IID_IActiveScriptProfilerControl             = GUIDOF!IActiveScriptProfilerControl;
const GUID IID_IActiveScriptProfilerControl2            = GUIDOF!IActiveScriptProfilerControl2;
const GUID IID_IActiveScriptProfilerControl3            = GUIDOF!IActiveScriptProfilerControl3;
const GUID IID_IActiveScriptProfilerControl4            = GUIDOF!IActiveScriptProfilerControl4;
const GUID IID_IActiveScriptProfilerControl5            = GUIDOF!IActiveScriptProfilerControl5;
const GUID IID_IActiveScriptProfilerHeapEnum            = GUIDOF!IActiveScriptProfilerHeapEnum;
const GUID IID_IActiveScriptProperty                    = GUIDOF!IActiveScriptProperty;
const GUID IID_IActiveScriptSIPInfo                     = GUIDOF!IActiveScriptSIPInfo;
const GUID IID_IActiveScriptSite                        = GUIDOF!IActiveScriptSite;
const GUID IID_IActiveScriptSiteDebug32                 = GUIDOF!IActiveScriptSiteDebug32;
const GUID IID_IActiveScriptSiteDebug64                 = GUIDOF!IActiveScriptSiteDebug64;
const GUID IID_IActiveScriptSiteDebugEx                 = GUIDOF!IActiveScriptSiteDebugEx;
const GUID IID_IActiveScriptSiteInterruptPoll           = GUIDOF!IActiveScriptSiteInterruptPoll;
const GUID IID_IActiveScriptSiteTraceInfo               = GUIDOF!IActiveScriptSiteTraceInfo;
const GUID IID_IActiveScriptSiteUIControl               = GUIDOF!IActiveScriptSiteUIControl;
const GUID IID_IActiveScriptSiteWindow                  = GUIDOF!IActiveScriptSiteWindow;
const GUID IID_IActiveScriptStats                       = GUIDOF!IActiveScriptStats;
const GUID IID_IActiveScriptStringCompare               = GUIDOF!IActiveScriptStringCompare;
const GUID IID_IActiveScriptTraceInfo                   = GUIDOF!IActiveScriptTraceInfo;
const GUID IID_IApplicationDebugger                     = GUIDOF!IApplicationDebugger;
const GUID IID_IApplicationDebuggerUI                   = GUIDOF!IApplicationDebuggerUI;
const GUID IID_IBFCacheable                             = GUIDOF!IBFCacheable;
const GUID IID_IBindEventHandler                        = GUIDOF!IBindEventHandler;
const GUID IID_IBlockFormats                            = GUIDOF!IBlockFormats;
const GUID IID_ICSSFilter                               = GUIDOF!ICSSFilter;
const GUID IID_ICSSFilterSite                           = GUIDOF!ICSSFilterSite;
const GUID IID_ICanvasGradient                          = GUIDOF!ICanvasGradient;
const GUID IID_ICanvasImageData                         = GUIDOF!ICanvasImageData;
const GUID IID_ICanvasPattern                           = GUIDOF!ICanvasPattern;
const GUID IID_ICanvasPixelArray                        = GUIDOF!ICanvasPixelArray;
const GUID IID_ICanvasPixelArrayData                    = GUIDOF!ICanvasPixelArrayData;
const GUID IID_ICanvasRenderingContext2D                = GUIDOF!ICanvasRenderingContext2D;
const GUID IID_ICanvasTextMetrics                       = GUIDOF!ICanvasTextMetrics;
const GUID IID_IClientCaps                              = GUIDOF!IClientCaps;
const GUID IID_IDOMBeforeUnloadEvent                    = GUIDOF!IDOMBeforeUnloadEvent;
const GUID IID_IDOMCloseEvent                           = GUIDOF!IDOMCloseEvent;
const GUID IID_IDOMCompositionEvent                     = GUIDOF!IDOMCompositionEvent;
const GUID IID_IDOMCustomEvent                          = GUIDOF!IDOMCustomEvent;
const GUID IID_IDOMDocumentType                         = GUIDOF!IDOMDocumentType;
const GUID IID_IDOMDragEvent                            = GUIDOF!IDOMDragEvent;
const GUID IID_IDOMEvent                                = GUIDOF!IDOMEvent;
const GUID IID_IDOMEventRegistrationCallback            = GUIDOF!IDOMEventRegistrationCallback;
const GUID IID_IDOMException                            = GUIDOF!IDOMException;
const GUID IID_IDOMFocusEvent                           = GUIDOF!IDOMFocusEvent;
const GUID IID_IDOMKeyboardEvent                        = GUIDOF!IDOMKeyboardEvent;
const GUID IID_IDOMMSAnimationEvent                     = GUIDOF!IDOMMSAnimationEvent;
const GUID IID_IDOMMSManipulationEvent                  = GUIDOF!IDOMMSManipulationEvent;
const GUID IID_IDOMMSTransitionEvent                    = GUIDOF!IDOMMSTransitionEvent;
const GUID IID_IDOMMessageEvent                         = GUIDOF!IDOMMessageEvent;
const GUID IID_IDOMMouseEvent                           = GUIDOF!IDOMMouseEvent;
const GUID IID_IDOMMouseWheelEvent                      = GUIDOF!IDOMMouseWheelEvent;
const GUID IID_IDOMMutationEvent                        = GUIDOF!IDOMMutationEvent;
const GUID IID_IDOMNodeIterator                         = GUIDOF!IDOMNodeIterator;
const GUID IID_IDOMParser                               = GUIDOF!IDOMParser;
const GUID IID_IDOMParserFactory                        = GUIDOF!IDOMParserFactory;
const GUID IID_IDOMProcessingInstruction                = GUIDOF!IDOMProcessingInstruction;
const GUID IID_IDOMProgressEvent                        = GUIDOF!IDOMProgressEvent;
const GUID IID_IDOMSiteModeEvent                        = GUIDOF!IDOMSiteModeEvent;
const GUID IID_IDOMStorageEvent                         = GUIDOF!IDOMStorageEvent;
const GUID IID_IDOMTextEvent                            = GUIDOF!IDOMTextEvent;
const GUID IID_IDOMTreeWalker                           = GUIDOF!IDOMTreeWalker;
const GUID IID_IDOMUIEvent                              = GUIDOF!IDOMUIEvent;
const GUID IID_IDOMWheelEvent                           = GUIDOF!IDOMWheelEvent;
const GUID IID_IDOMXmlSerializer                        = GUIDOF!IDOMXmlSerializer;
const GUID IID_IDOMXmlSerializerFactory                 = GUIDOF!IDOMXmlSerializerFactory;
const GUID IID_IDebugApplication32                      = GUIDOF!IDebugApplication32;
const GUID IID_IDebugApplication64                      = GUIDOF!IDebugApplication64;
const GUID IID_IDebugApplicationNode                    = GUIDOF!IDebugApplicationNode;
const GUID IID_IDebugApplicationNodeEvents              = GUIDOF!IDebugApplicationNodeEvents;
const GUID IID_IDebugApplicationThread                  = GUIDOF!IDebugApplicationThread;
const GUID IID_IDebugApplicationThread64                = GUIDOF!IDebugApplicationThread64;
const GUID IID_IDebugAsyncOperation                     = GUIDOF!IDebugAsyncOperation;
const GUID IID_IDebugAsyncOperationCallBack             = GUIDOF!IDebugAsyncOperationCallBack;
const GUID IID_IDebugCallbackNotificationHandler        = GUIDOF!IDebugCallbackNotificationHandler;
const GUID IID_IDebugCodeContext                        = GUIDOF!IDebugCodeContext;
const GUID IID_IDebugCookie                             = GUIDOF!IDebugCookie;
const GUID IID_IDebugDocument                           = GUIDOF!IDebugDocument;
const GUID IID_IDebugDocumentContext                    = GUIDOF!IDebugDocumentContext;
const GUID IID_IDebugDocumentHelper32                   = GUIDOF!IDebugDocumentHelper32;
const GUID IID_IDebugDocumentHelper64                   = GUIDOF!IDebugDocumentHelper64;
const GUID IID_IDebugDocumentHost                       = GUIDOF!IDebugDocumentHost;
const GUID IID_IDebugDocumentInfo                       = GUIDOF!IDebugDocumentInfo;
const GUID IID_IDebugDocumentProvider                   = GUIDOF!IDebugDocumentProvider;
const GUID IID_IDebugDocumentText                       = GUIDOF!IDebugDocumentText;
const GUID IID_IDebugDocumentTextAuthor                 = GUIDOF!IDebugDocumentTextAuthor;
const GUID IID_IDebugDocumentTextEvents                 = GUIDOF!IDebugDocumentTextEvents;
const GUID IID_IDebugDocumentTextExternalAuthor         = GUIDOF!IDebugDocumentTextExternalAuthor;
const GUID IID_IDebugExpression                         = GUIDOF!IDebugExpression;
const GUID IID_IDebugExpressionCallBack                 = GUIDOF!IDebugExpressionCallBack;
const GUID IID_IDebugExpressionContext                  = GUIDOF!IDebugExpressionContext;
const GUID IID_IDebugExtendedProperty                   = GUIDOF!IDebugExtendedProperty;
const GUID IID_IDebugFormatter                          = GUIDOF!IDebugFormatter;
const GUID IID_IDebugHelper                             = GUIDOF!IDebugHelper;
const GUID IID_IDebugProperty                           = GUIDOF!IDebugProperty;
const GUID IID_IDebugPropertyEnumType_All               = GUIDOF!IDebugPropertyEnumType_All;
const GUID IID_IDebugPropertyEnumType_Arguments         = GUIDOF!IDebugPropertyEnumType_Arguments;
const GUID IID_IDebugPropertyEnumType_Locals            = GUIDOF!IDebugPropertyEnumType_Locals;
const GUID IID_IDebugPropertyEnumType_LocalsPlusArgs    = GUIDOF!IDebugPropertyEnumType_LocalsPlusArgs;
const GUID IID_IDebugPropertyEnumType_Registers         = GUIDOF!IDebugPropertyEnumType_Registers;
const GUID IID_IDebugSessionProvider                    = GUIDOF!IDebugSessionProvider;
const GUID IID_IDebugStackFrame                         = GUIDOF!IDebugStackFrame;
const GUID IID_IDebugStackFrameSniffer                  = GUIDOF!IDebugStackFrameSniffer;
const GUID IID_IDebugStackFrameSnifferEx32              = GUIDOF!IDebugStackFrameSnifferEx32;
const GUID IID_IDebugStackFrameSnifferEx64              = GUIDOF!IDebugStackFrameSnifferEx64;
const GUID IID_IDebugSyncOperation                      = GUIDOF!IDebugSyncOperation;
const GUID IID_IDebugThreadCall32                       = GUIDOF!IDebugThreadCall32;
const GUID IID_IDebugThreadCall64                       = GUIDOF!IDebugThreadCall64;
const GUID IID_IDeveloperConsoleMessageReceiver         = GUIDOF!IDeveloperConsoleMessageReceiver;
const GUID IID_IDisplayPointer                          = GUIDOF!IDisplayPointer;
const GUID IID_IDisplayServices                         = GUIDOF!IDisplayServices;
const GUID IID_IDocumentEvent                           = GUIDOF!IDocumentEvent;
const GUID IID_IDocumentRange                           = GUIDOF!IDocumentRange;
const GUID IID_IDocumentSelector                        = GUIDOF!IDocumentSelector;
const GUID IID_IDocumentTraversal                       = GUIDOF!IDocumentTraversal;
const GUID IID_IElementBehavior                         = GUIDOF!IElementBehavior;
const GUID IID_IElementBehaviorCategory                 = GUIDOF!IElementBehaviorCategory;
const GUID IID_IElementBehaviorFactory                  = GUIDOF!IElementBehaviorFactory;
const GUID IID_IElementBehaviorFocus                    = GUIDOF!IElementBehaviorFocus;
const GUID IID_IElementBehaviorLayout                   = GUIDOF!IElementBehaviorLayout;
const GUID IID_IElementBehaviorLayout2                  = GUIDOF!IElementBehaviorLayout2;
const GUID IID_IElementBehaviorRender                   = GUIDOF!IElementBehaviorRender;
const GUID IID_IElementBehaviorSite                     = GUIDOF!IElementBehaviorSite;
const GUID IID_IElementBehaviorSiteCategory             = GUIDOF!IElementBehaviorSiteCategory;
const GUID IID_IElementBehaviorSiteLayout               = GUIDOF!IElementBehaviorSiteLayout;
const GUID IID_IElementBehaviorSiteLayout2              = GUIDOF!IElementBehaviorSiteLayout2;
const GUID IID_IElementBehaviorSiteOM                   = GUIDOF!IElementBehaviorSiteOM;
const GUID IID_IElementBehaviorSiteOM2                  = GUIDOF!IElementBehaviorSiteOM2;
const GUID IID_IElementBehaviorSiteRender               = GUIDOF!IElementBehaviorSiteRender;
const GUID IID_IElementBehaviorSubmit                   = GUIDOF!IElementBehaviorSubmit;
const GUID IID_IElementNamespace                        = GUIDOF!IElementNamespace;
const GUID IID_IElementNamespaceFactory                 = GUIDOF!IElementNamespaceFactory;
const GUID IID_IElementNamespaceFactory2                = GUIDOF!IElementNamespaceFactory2;
const GUID IID_IElementNamespaceFactoryCallback         = GUIDOF!IElementNamespaceFactoryCallback;
const GUID IID_IElementNamespaceTable                   = GUIDOF!IElementNamespaceTable;
const GUID IID_IElementSegment                          = GUIDOF!IElementSegment;
const GUID IID_IElementSelector                         = GUIDOF!IElementSelector;
const GUID IID_IElementTraversal                        = GUIDOF!IElementTraversal;
const GUID IID_IEnumDebugApplicationNodes               = GUIDOF!IEnumDebugApplicationNodes;
const GUID IID_IEnumDebugCodeContexts                   = GUIDOF!IEnumDebugCodeContexts;
const GUID IID_IEnumDebugExpressionContexts             = GUIDOF!IEnumDebugExpressionContexts;
const GUID IID_IEnumDebugExtendedPropertyInfo           = GUIDOF!IEnumDebugExtendedPropertyInfo;
const GUID IID_IEnumDebugPropertyInfo                   = GUIDOF!IEnumDebugPropertyInfo;
const GUID IID_IEnumDebugStackFrames                    = GUIDOF!IEnumDebugStackFrames;
const GUID IID_IEnumDebugStackFrames64                  = GUIDOF!IEnumDebugStackFrames64;
const GUID IID_IEnumPrivacyRecords                      = GUIDOF!IEnumPrivacyRecords;
const GUID IID_IEnumRemoteDebugApplicationThreads       = GUIDOF!IEnumRemoteDebugApplicationThreads;
const GUID IID_IEnumRemoteDebugApplications             = GUIDOF!IEnumRemoteDebugApplications;
const GUID IID_IEventException                          = GUIDOF!IEventException;
const GUID IID_IEventTarget                             = GUIDOF!IEventTarget;
const GUID IID_IEventTarget2                            = GUIDOF!IEventTarget2;
const GUID IID_IFontNames                               = GUIDOF!IFontNames;
const GUID IID_IGetSVGDocument                          = GUIDOF!IGetSVGDocument;
const GUID IID_IHTCAttachBehavior                       = GUIDOF!IHTCAttachBehavior;
const GUID IID_IHTCAttachBehavior2                      = GUIDOF!IHTCAttachBehavior2;
const GUID IID_IHTCDefaultDispatch                      = GUIDOF!IHTCDefaultDispatch;
const GUID IID_IHTCDescBehavior                         = GUIDOF!IHTCDescBehavior;
const GUID IID_IHTCEventBehavior                        = GUIDOF!IHTCEventBehavior;
const GUID IID_IHTCMethodBehavior                       = GUIDOF!IHTCMethodBehavior;
const GUID IID_IHTCPropertyBehavior                     = GUIDOF!IHTCPropertyBehavior;
const GUID IID_IHTMLAnchorElement                       = GUIDOF!IHTMLAnchorElement;
const GUID IID_IHTMLAnchorElement2                      = GUIDOF!IHTMLAnchorElement2;
const GUID IID_IHTMLAnchorElement3                      = GUIDOF!IHTMLAnchorElement3;
const GUID IID_IHTMLAppBehavior                         = GUIDOF!IHTMLAppBehavior;
const GUID IID_IHTMLAppBehavior2                        = GUIDOF!IHTMLAppBehavior2;
const GUID IID_IHTMLAppBehavior3                        = GUIDOF!IHTMLAppBehavior3;
const GUID IID_IHTMLApplicationCache                    = GUIDOF!IHTMLApplicationCache;
const GUID IID_IHTMLAreaElement                         = GUIDOF!IHTMLAreaElement;
const GUID IID_IHTMLAreaElement2                        = GUIDOF!IHTMLAreaElement2;
const GUID IID_IHTMLAreasCollection                     = GUIDOF!IHTMLAreasCollection;
const GUID IID_IHTMLAreasCollection2                    = GUIDOF!IHTMLAreasCollection2;
const GUID IID_IHTMLAreasCollection3                    = GUIDOF!IHTMLAreasCollection3;
const GUID IID_IHTMLAreasCollection4                    = GUIDOF!IHTMLAreasCollection4;
const GUID IID_IHTMLAttributeCollection                 = GUIDOF!IHTMLAttributeCollection;
const GUID IID_IHTMLAttributeCollection2                = GUIDOF!IHTMLAttributeCollection2;
const GUID IID_IHTMLAttributeCollection3                = GUIDOF!IHTMLAttributeCollection3;
const GUID IID_IHTMLAttributeCollection4                = GUIDOF!IHTMLAttributeCollection4;
const GUID IID_IHTMLAudioElement                        = GUIDOF!IHTMLAudioElement;
const GUID IID_IHTMLAudioElementFactory                 = GUIDOF!IHTMLAudioElementFactory;
const GUID IID_IHTMLBGsound                             = GUIDOF!IHTMLBGsound;
const GUID IID_IHTMLBRElement                           = GUIDOF!IHTMLBRElement;
const GUID IID_IHTMLBaseElement                         = GUIDOF!IHTMLBaseElement;
const GUID IID_IHTMLBaseElement2                        = GUIDOF!IHTMLBaseElement2;
const GUID IID_IHTMLBaseFontElement                     = GUIDOF!IHTMLBaseFontElement;
const GUID IID_IHTMLBlockElement                        = GUIDOF!IHTMLBlockElement;
const GUID IID_IHTMLBlockElement2                       = GUIDOF!IHTMLBlockElement2;
const GUID IID_IHTMLBlockElement3                       = GUIDOF!IHTMLBlockElement3;
const GUID IID_IHTMLBodyElement                         = GUIDOF!IHTMLBodyElement;
const GUID IID_IHTMLBodyElement2                        = GUIDOF!IHTMLBodyElement2;
const GUID IID_IHTMLBodyElement3                        = GUIDOF!IHTMLBodyElement3;
const GUID IID_IHTMLBodyElement4                        = GUIDOF!IHTMLBodyElement4;
const GUID IID_IHTMLBodyElement5                        = GUIDOF!IHTMLBodyElement5;
const GUID IID_IHTMLBookmarkCollection                  = GUIDOF!IHTMLBookmarkCollection;
const GUID IID_IHTMLButtonElement                       = GUIDOF!IHTMLButtonElement;
const GUID IID_IHTMLButtonElement2                      = GUIDOF!IHTMLButtonElement2;
const GUID IID_IHTMLCSSImportRule                       = GUIDOF!IHTMLCSSImportRule;
const GUID IID_IHTMLCSSMediaList                        = GUIDOF!IHTMLCSSMediaList;
const GUID IID_IHTMLCSSMediaRule                        = GUIDOF!IHTMLCSSMediaRule;
const GUID IID_IHTMLCSSNamespaceRule                    = GUIDOF!IHTMLCSSNamespaceRule;
const GUID IID_IHTMLCSSRule                             = GUIDOF!IHTMLCSSRule;
const GUID IID_IHTMLCSSStyleDeclaration                 = GUIDOF!IHTMLCSSStyleDeclaration;
const GUID IID_IHTMLCSSStyleDeclaration2                = GUIDOF!IHTMLCSSStyleDeclaration2;
const GUID IID_IHTMLCSSStyleDeclaration3                = GUIDOF!IHTMLCSSStyleDeclaration3;
const GUID IID_IHTMLCSSStyleDeclaration4                = GUIDOF!IHTMLCSSStyleDeclaration4;
const GUID IID_IHTMLCanvasElement                       = GUIDOF!IHTMLCanvasElement;
const GUID IID_IHTMLCaret                               = GUIDOF!IHTMLCaret;
const GUID IID_IHTMLChangeLog                           = GUIDOF!IHTMLChangeLog;
const GUID IID_IHTMLChangePlayback                      = GUIDOF!IHTMLChangePlayback;
const GUID IID_IHTMLChangeSink                          = GUIDOF!IHTMLChangeSink;
const GUID IID_IHTMLCommentElement                      = GUIDOF!IHTMLCommentElement;
const GUID IID_IHTMLCommentElement2                     = GUIDOF!IHTMLCommentElement2;
const GUID IID_IHTMLCommentElement3                     = GUIDOF!IHTMLCommentElement3;
const GUID IID_IHTMLComputedStyle                       = GUIDOF!IHTMLComputedStyle;
const GUID IID_IHTMLControlElement                      = GUIDOF!IHTMLControlElement;
const GUID IID_IHTMLControlRange                        = GUIDOF!IHTMLControlRange;
const GUID IID_IHTMLControlRange2                       = GUIDOF!IHTMLControlRange2;
const GUID IID_IHTMLCurrentStyle                        = GUIDOF!IHTMLCurrentStyle;
const GUID IID_IHTMLCurrentStyle2                       = GUIDOF!IHTMLCurrentStyle2;
const GUID IID_IHTMLCurrentStyle3                       = GUIDOF!IHTMLCurrentStyle3;
const GUID IID_IHTMLCurrentStyle4                       = GUIDOF!IHTMLCurrentStyle4;
const GUID IID_IHTMLCurrentStyle5                       = GUIDOF!IHTMLCurrentStyle5;
const GUID IID_IHTMLDDElement                           = GUIDOF!IHTMLDDElement;
const GUID IID_IHTMLDListElement                        = GUIDOF!IHTMLDListElement;
const GUID IID_IHTMLDOMAttribute                        = GUIDOF!IHTMLDOMAttribute;
const GUID IID_IHTMLDOMAttribute2                       = GUIDOF!IHTMLDOMAttribute2;
const GUID IID_IHTMLDOMAttribute3                       = GUIDOF!IHTMLDOMAttribute3;
const GUID IID_IHTMLDOMAttribute4                       = GUIDOF!IHTMLDOMAttribute4;
const GUID IID_IHTMLDOMChildrenCollection               = GUIDOF!IHTMLDOMChildrenCollection;
const GUID IID_IHTMLDOMChildrenCollection2              = GUIDOF!IHTMLDOMChildrenCollection2;
const GUID IID_IHTMLDOMConstructor                      = GUIDOF!IHTMLDOMConstructor;
const GUID IID_IHTMLDOMConstructorCollection            = GUIDOF!IHTMLDOMConstructorCollection;
const GUID IID_IHTMLDOMImplementation                   = GUIDOF!IHTMLDOMImplementation;
const GUID IID_IHTMLDOMImplementation2                  = GUIDOF!IHTMLDOMImplementation2;
const GUID IID_IHTMLDOMNode                             = GUIDOF!IHTMLDOMNode;
const GUID IID_IHTMLDOMNode2                            = GUIDOF!IHTMLDOMNode2;
const GUID IID_IHTMLDOMNode3                            = GUIDOF!IHTMLDOMNode3;
const GUID IID_IHTMLDOMRange                            = GUIDOF!IHTMLDOMRange;
const GUID IID_IHTMLDOMTextNode                         = GUIDOF!IHTMLDOMTextNode;
const GUID IID_IHTMLDOMTextNode2                        = GUIDOF!IHTMLDOMTextNode2;
const GUID IID_IHTMLDOMTextNode3                        = GUIDOF!IHTMLDOMTextNode3;
const GUID IID_IHTMLDTElement                           = GUIDOF!IHTMLDTElement;
const GUID IID_IHTMLDataTransfer                        = GUIDOF!IHTMLDataTransfer;
const GUID IID_IHTMLDatabinding                         = GUIDOF!IHTMLDatabinding;
const GUID IID_IHTMLDialog                              = GUIDOF!IHTMLDialog;
const GUID IID_IHTMLDialog2                             = GUIDOF!IHTMLDialog2;
const GUID IID_IHTMLDialog3                             = GUIDOF!IHTMLDialog3;
const GUID IID_IHTMLDivElement                          = GUIDOF!IHTMLDivElement;
const GUID IID_IHTMLDivPosition                         = GUIDOF!IHTMLDivPosition;
const GUID IID_IHTMLDocument                            = GUIDOF!IHTMLDocument;
const GUID IID_IHTMLDocument2                           = GUIDOF!IHTMLDocument2;
const GUID IID_IHTMLDocument3                           = GUIDOF!IHTMLDocument3;
const GUID IID_IHTMLDocument4                           = GUIDOF!IHTMLDocument4;
const GUID IID_IHTMLDocument5                           = GUIDOF!IHTMLDocument5;
const GUID IID_IHTMLDocument6                           = GUIDOF!IHTMLDocument6;
const GUID IID_IHTMLDocument7                           = GUIDOF!IHTMLDocument7;
const GUID IID_IHTMLDocument8                           = GUIDOF!IHTMLDocument8;
const GUID IID_IHTMLDocumentCompatibleInfo              = GUIDOF!IHTMLDocumentCompatibleInfo;
const GUID IID_IHTMLDocumentCompatibleInfoCollection    = GUIDOF!IHTMLDocumentCompatibleInfoCollection;
const GUID IID_IHTMLEditDesigner                        = GUIDOF!IHTMLEditDesigner;
const GUID IID_IHTMLEditHost                            = GUIDOF!IHTMLEditHost;
const GUID IID_IHTMLEditHost2                           = GUIDOF!IHTMLEditHost2;
const GUID IID_IHTMLEditServices                        = GUIDOF!IHTMLEditServices;
const GUID IID_IHTMLEditServices2                       = GUIDOF!IHTMLEditServices2;
const GUID IID_IHTMLElement                             = GUIDOF!IHTMLElement;
const GUID IID_IHTMLElement2                            = GUIDOF!IHTMLElement2;
const GUID IID_IHTMLElement3                            = GUIDOF!IHTMLElement3;
const GUID IID_IHTMLElement4                            = GUIDOF!IHTMLElement4;
const GUID IID_IHTMLElement5                            = GUIDOF!IHTMLElement5;
const GUID IID_IHTMLElement6                            = GUIDOF!IHTMLElement6;
const GUID IID_IHTMLElement7                            = GUIDOF!IHTMLElement7;
const GUID IID_IHTMLElementAppliedStyles                = GUIDOF!IHTMLElementAppliedStyles;
const GUID IID_IHTMLElementCollection                   = GUIDOF!IHTMLElementCollection;
const GUID IID_IHTMLElementCollection2                  = GUIDOF!IHTMLElementCollection2;
const GUID IID_IHTMLElementCollection3                  = GUIDOF!IHTMLElementCollection3;
const GUID IID_IHTMLElementCollection4                  = GUIDOF!IHTMLElementCollection4;
const GUID IID_IHTMLElementDefaults                     = GUIDOF!IHTMLElementDefaults;
const GUID IID_IHTMLElementRender                       = GUIDOF!IHTMLElementRender;
const GUID IID_IHTMLEmbedElement                        = GUIDOF!IHTMLEmbedElement;
const GUID IID_IHTMLEmbedElement2                       = GUIDOF!IHTMLEmbedElement2;
const GUID IID_IHTMLEventObj                            = GUIDOF!IHTMLEventObj;
const GUID IID_IHTMLEventObj2                           = GUIDOF!IHTMLEventObj2;
const GUID IID_IHTMLEventObj3                           = GUIDOF!IHTMLEventObj3;
const GUID IID_IHTMLEventObj4                           = GUIDOF!IHTMLEventObj4;
const GUID IID_IHTMLEventObj5                           = GUIDOF!IHTMLEventObj5;
const GUID IID_IHTMLEventObj6                           = GUIDOF!IHTMLEventObj6;
const GUID IID_IHTMLFieldSetElement                     = GUIDOF!IHTMLFieldSetElement;
const GUID IID_IHTMLFieldSetElement2                    = GUIDOF!IHTMLFieldSetElement2;
const GUID IID_IHTMLFiltersCollection                   = GUIDOF!IHTMLFiltersCollection;
const GUID IID_IHTMLFontElement                         = GUIDOF!IHTMLFontElement;
const GUID IID_IHTMLFontNamesCollection                 = GUIDOF!IHTMLFontNamesCollection;
const GUID IID_IHTMLFontSizesCollection                 = GUIDOF!IHTMLFontSizesCollection;
const GUID IID_IHTMLFormElement                         = GUIDOF!IHTMLFormElement;
const GUID IID_IHTMLFormElement2                        = GUIDOF!IHTMLFormElement2;
const GUID IID_IHTMLFormElement3                        = GUIDOF!IHTMLFormElement3;
const GUID IID_IHTMLFormElement4                        = GUIDOF!IHTMLFormElement4;
const GUID IID_IHTMLFrameBase                           = GUIDOF!IHTMLFrameBase;
const GUID IID_IHTMLFrameBase2                          = GUIDOF!IHTMLFrameBase2;
const GUID IID_IHTMLFrameBase3                          = GUIDOF!IHTMLFrameBase3;
const GUID IID_IHTMLFrameElement                        = GUIDOF!IHTMLFrameElement;
const GUID IID_IHTMLFrameElement2                       = GUIDOF!IHTMLFrameElement2;
const GUID IID_IHTMLFrameElement3                       = GUIDOF!IHTMLFrameElement3;
const GUID IID_IHTMLFrameSetElement                     = GUIDOF!IHTMLFrameSetElement;
const GUID IID_IHTMLFrameSetElement2                    = GUIDOF!IHTMLFrameSetElement2;
const GUID IID_IHTMLFrameSetElement3                    = GUIDOF!IHTMLFrameSetElement3;
const GUID IID_IHTMLFramesCollection2                   = GUIDOF!IHTMLFramesCollection2;
const GUID IID_IHTMLGenericElement                      = GUIDOF!IHTMLGenericElement;
const GUID IID_IHTMLHRElement                           = GUIDOF!IHTMLHRElement;
const GUID IID_IHTMLHeadElement                         = GUIDOF!IHTMLHeadElement;
const GUID IID_IHTMLHeadElement2                        = GUIDOF!IHTMLHeadElement2;
const GUID IID_IHTMLHeaderElement                       = GUIDOF!IHTMLHeaderElement;
const GUID IID_IHTMLHtmlElement                         = GUIDOF!IHTMLHtmlElement;
const GUID IID_IHTMLIFrameElement                       = GUIDOF!IHTMLIFrameElement;
const GUID IID_IHTMLIFrameElement2                      = GUIDOF!IHTMLIFrameElement2;
const GUID IID_IHTMLIFrameElement3                      = GUIDOF!IHTMLIFrameElement3;
const GUID IID_IHTMLIPrintCollection                    = GUIDOF!IHTMLIPrintCollection;
const GUID IID_IHTMLImageElementFactory                 = GUIDOF!IHTMLImageElementFactory;
const GUID IID_IHTMLImgElement                          = GUIDOF!IHTMLImgElement;
const GUID IID_IHTMLImgElement2                         = GUIDOF!IHTMLImgElement2;
const GUID IID_IHTMLImgElement3                         = GUIDOF!IHTMLImgElement3;
const GUID IID_IHTMLImgElement4                         = GUIDOF!IHTMLImgElement4;
const GUID IID_IHTMLInputButtonElement                  = GUIDOF!IHTMLInputButtonElement;
const GUID IID_IHTMLInputElement                        = GUIDOF!IHTMLInputElement;
const GUID IID_IHTMLInputElement2                       = GUIDOF!IHTMLInputElement2;
const GUID IID_IHTMLInputElement3                       = GUIDOF!IHTMLInputElement3;
const GUID IID_IHTMLInputFileElement                    = GUIDOF!IHTMLInputFileElement;
const GUID IID_IHTMLInputHiddenElement                  = GUIDOF!IHTMLInputHiddenElement;
const GUID IID_IHTMLInputImage                          = GUIDOF!IHTMLInputImage;
const GUID IID_IHTMLInputRangeElement                   = GUIDOF!IHTMLInputRangeElement;
const GUID IID_IHTMLInputTextElement                    = GUIDOF!IHTMLInputTextElement;
const GUID IID_IHTMLInputTextElement2                   = GUIDOF!IHTMLInputTextElement2;
const GUID IID_IHTMLIsIndexElement                      = GUIDOF!IHTMLIsIndexElement;
const GUID IID_IHTMLIsIndexElement2                     = GUIDOF!IHTMLIsIndexElement2;
const GUID IID_IHTMLLIElement                           = GUIDOF!IHTMLLIElement;
const GUID IID_IHTMLLabelElement                        = GUIDOF!IHTMLLabelElement;
const GUID IID_IHTMLLabelElement2                       = GUIDOF!IHTMLLabelElement2;
const GUID IID_IHTMLLegendElement                       = GUIDOF!IHTMLLegendElement;
const GUID IID_IHTMLLegendElement2                      = GUIDOF!IHTMLLegendElement2;
const GUID IID_IHTMLLinkElement                         = GUIDOF!IHTMLLinkElement;
const GUID IID_IHTMLLinkElement2                        = GUIDOF!IHTMLLinkElement2;
const GUID IID_IHTMLLinkElement3                        = GUIDOF!IHTMLLinkElement3;
const GUID IID_IHTMLLinkElement4                        = GUIDOF!IHTMLLinkElement4;
const GUID IID_IHTMLLinkElement5                        = GUIDOF!IHTMLLinkElement5;
const GUID IID_IHTMLListElement                         = GUIDOF!IHTMLListElement;
const GUID IID_IHTMLListElement2                        = GUIDOF!IHTMLListElement2;
const GUID IID_IHTMLLocation                            = GUIDOF!IHTMLLocation;
const GUID IID_IHTMLMSCSSKeyframeRule                   = GUIDOF!IHTMLMSCSSKeyframeRule;
const GUID IID_IHTMLMSCSSKeyframesRule                  = GUIDOF!IHTMLMSCSSKeyframesRule;
const GUID IID_IHTMLMSImgElement                        = GUIDOF!IHTMLMSImgElement;
const GUID IID_IHTMLMSMediaElement                      = GUIDOF!IHTMLMSMediaElement;
const GUID IID_IHTMLMapElement                          = GUIDOF!IHTMLMapElement;
const GUID IID_IHTMLMarqueeElement                      = GUIDOF!IHTMLMarqueeElement;
const GUID IID_IHTMLMediaElement                        = GUIDOF!IHTMLMediaElement;
const GUID IID_IHTMLMediaElement2                       = GUIDOF!IHTMLMediaElement2;
const GUID IID_IHTMLMediaError                          = GUIDOF!IHTMLMediaError;
const GUID IID_IHTMLMetaElement                         = GUIDOF!IHTMLMetaElement;
const GUID IID_IHTMLMetaElement2                        = GUIDOF!IHTMLMetaElement2;
const GUID IID_IHTMLMetaElement3                        = GUIDOF!IHTMLMetaElement3;
const GUID IID_IHTMLMimeTypesCollection                 = GUIDOF!IHTMLMimeTypesCollection;
const GUID IID_IHTMLModelessInit                        = GUIDOF!IHTMLModelessInit;
const GUID IID_IHTMLNamespace                           = GUIDOF!IHTMLNamespace;
const GUID IID_IHTMLNamespaceCollection                 = GUIDOF!IHTMLNamespaceCollection;
const GUID IID_IHTMLNextIdElement                       = GUIDOF!IHTMLNextIdElement;
const GUID IID_IHTMLNoShowElement                       = GUIDOF!IHTMLNoShowElement;
const GUID IID_IHTMLOListElement                        = GUIDOF!IHTMLOListElement;
const GUID IID_IHTMLObjectElement                       = GUIDOF!IHTMLObjectElement;
const GUID IID_IHTMLObjectElement2                      = GUIDOF!IHTMLObjectElement2;
const GUID IID_IHTMLObjectElement3                      = GUIDOF!IHTMLObjectElement3;
const GUID IID_IHTMLObjectElement4                      = GUIDOF!IHTMLObjectElement4;
const GUID IID_IHTMLObjectElement5                      = GUIDOF!IHTMLObjectElement5;
const GUID IID_IHTMLOpsProfile                          = GUIDOF!IHTMLOpsProfile;
const GUID IID_IHTMLOptionButtonElement                 = GUIDOF!IHTMLOptionButtonElement;
const GUID IID_IHTMLOptionElement                       = GUIDOF!IHTMLOptionElement;
const GUID IID_IHTMLOptionElement3                      = GUIDOF!IHTMLOptionElement3;
const GUID IID_IHTMLOptionElement4                      = GUIDOF!IHTMLOptionElement4;
const GUID IID_IHTMLOptionElementFactory                = GUIDOF!IHTMLOptionElementFactory;
const GUID IID_IHTMLOptionsHolder                       = GUIDOF!IHTMLOptionsHolder;
const GUID IID_IHTMLPaintSite                           = GUIDOF!IHTMLPaintSite;
const GUID IID_IHTMLPainter                             = GUIDOF!IHTMLPainter;
const GUID IID_IHTMLPainterEventInfo                    = GUIDOF!IHTMLPainterEventInfo;
const GUID IID_IHTMLPainterOverlay                      = GUIDOF!IHTMLPainterOverlay;
const GUID IID_IHTMLParaElement                         = GUIDOF!IHTMLParaElement;
const GUID IID_IHTMLParamElement                        = GUIDOF!IHTMLParamElement;
const GUID IID_IHTMLParamElement2                       = GUIDOF!IHTMLParamElement2;
const GUID IID_IHTMLPerformance                         = GUIDOF!IHTMLPerformance;
const GUID IID_IHTMLPerformanceNavigation               = GUIDOF!IHTMLPerformanceNavigation;
const GUID IID_IHTMLPerformanceTiming                   = GUIDOF!IHTMLPerformanceTiming;
const GUID IID_IHTMLPhraseElement                       = GUIDOF!IHTMLPhraseElement;
const GUID IID_IHTMLPhraseElement2                      = GUIDOF!IHTMLPhraseElement2;
const GUID IID_IHTMLPhraseElement3                      = GUIDOF!IHTMLPhraseElement3;
const GUID IID_IHTMLPluginsCollection                   = GUIDOF!IHTMLPluginsCollection;
const GUID IID_IHTMLPopup                               = GUIDOF!IHTMLPopup;
const GUID IID_IHTMLProgressElement                     = GUIDOF!IHTMLProgressElement;
const GUID IID_IHTMLRect                                = GUIDOF!IHTMLRect;
const GUID IID_IHTMLRect2                               = GUIDOF!IHTMLRect2;
const GUID IID_IHTMLRectCollection                      = GUIDOF!IHTMLRectCollection;
const GUID IID_IHTMLRenderStyle                         = GUIDOF!IHTMLRenderStyle;
const GUID IID_IHTMLRuleStyle                           = GUIDOF!IHTMLRuleStyle;
const GUID IID_IHTMLRuleStyle2                          = GUIDOF!IHTMLRuleStyle2;
const GUID IID_IHTMLRuleStyle3                          = GUIDOF!IHTMLRuleStyle3;
const GUID IID_IHTMLRuleStyle4                          = GUIDOF!IHTMLRuleStyle4;
const GUID IID_IHTMLRuleStyle5                          = GUIDOF!IHTMLRuleStyle5;
const GUID IID_IHTMLRuleStyle6                          = GUIDOF!IHTMLRuleStyle6;
const GUID IID_IHTMLScreen                              = GUIDOF!IHTMLScreen;
const GUID IID_IHTMLScreen2                             = GUIDOF!IHTMLScreen2;
const GUID IID_IHTMLScreen3                             = GUIDOF!IHTMLScreen3;
const GUID IID_IHTMLScreen4                             = GUIDOF!IHTMLScreen4;
const GUID IID_IHTMLScriptElement                       = GUIDOF!IHTMLScriptElement;
const GUID IID_IHTMLScriptElement2                      = GUIDOF!IHTMLScriptElement2;
const GUID IID_IHTMLScriptElement3                      = GUIDOF!IHTMLScriptElement3;
const GUID IID_IHTMLScriptElement4                      = GUIDOF!IHTMLScriptElement4;
const GUID IID_IHTMLSelectElement                       = GUIDOF!IHTMLSelectElement;
const GUID IID_IHTMLSelectElement2                      = GUIDOF!IHTMLSelectElement2;
const GUID IID_IHTMLSelectElement4                      = GUIDOF!IHTMLSelectElement4;
const GUID IID_IHTMLSelectElement5                      = GUIDOF!IHTMLSelectElement5;
const GUID IID_IHTMLSelectElement6                      = GUIDOF!IHTMLSelectElement6;
const GUID IID_IHTMLSelectElementEx                     = GUIDOF!IHTMLSelectElementEx;
const GUID IID_IHTMLSelection                           = GUIDOF!IHTMLSelection;
const GUID IID_IHTMLSelectionObject                     = GUIDOF!IHTMLSelectionObject;
const GUID IID_IHTMLSelectionObject2                    = GUIDOF!IHTMLSelectionObject2;
const GUID IID_IHTMLSourceElement                       = GUIDOF!IHTMLSourceElement;
const GUID IID_IHTMLSpanElement                         = GUIDOF!IHTMLSpanElement;
const GUID IID_IHTMLSpanFlow                            = GUIDOF!IHTMLSpanFlow;
const GUID IID_IHTMLStorage                             = GUIDOF!IHTMLStorage;
const GUID IID_IHTMLStorage2                            = GUIDOF!IHTMLStorage2;
const GUID IID_IHTMLStyle                               = GUIDOF!IHTMLStyle;
const GUID IID_IHTMLStyle2                              = GUIDOF!IHTMLStyle2;
const GUID IID_IHTMLStyle3                              = GUIDOF!IHTMLStyle3;
const GUID IID_IHTMLStyle4                              = GUIDOF!IHTMLStyle4;
const GUID IID_IHTMLStyle5                              = GUIDOF!IHTMLStyle5;
const GUID IID_IHTMLStyle6                              = GUIDOF!IHTMLStyle6;
const GUID IID_IHTMLStyleElement                        = GUIDOF!IHTMLStyleElement;
const GUID IID_IHTMLStyleElement2                       = GUIDOF!IHTMLStyleElement2;
const GUID IID_IHTMLStyleEnabled                        = GUIDOF!IHTMLStyleEnabled;
const GUID IID_IHTMLStyleFontFace                       = GUIDOF!IHTMLStyleFontFace;
const GUID IID_IHTMLStyleFontFace2                      = GUIDOF!IHTMLStyleFontFace2;
const GUID IID_IHTMLStyleMedia                          = GUIDOF!IHTMLStyleMedia;
const GUID IID_IHTMLStyleSheet                          = GUIDOF!IHTMLStyleSheet;
const GUID IID_IHTMLStyleSheet2                         = GUIDOF!IHTMLStyleSheet2;
const GUID IID_IHTMLStyleSheet3                         = GUIDOF!IHTMLStyleSheet3;
const GUID IID_IHTMLStyleSheet4                         = GUIDOF!IHTMLStyleSheet4;
const GUID IID_IHTMLStyleSheetPage                      = GUIDOF!IHTMLStyleSheetPage;
const GUID IID_IHTMLStyleSheetPage2                     = GUIDOF!IHTMLStyleSheetPage2;
const GUID IID_IHTMLStyleSheetPagesCollection           = GUIDOF!IHTMLStyleSheetPagesCollection;
const GUID IID_IHTMLStyleSheetRule                      = GUIDOF!IHTMLStyleSheetRule;
const GUID IID_IHTMLStyleSheetRule2                     = GUIDOF!IHTMLStyleSheetRule2;
const GUID IID_IHTMLStyleSheetRuleApplied               = GUIDOF!IHTMLStyleSheetRuleApplied;
const GUID IID_IHTMLStyleSheetRulesAppliedCollection    = GUIDOF!IHTMLStyleSheetRulesAppliedCollection;
const GUID IID_IHTMLStyleSheetRulesCollection           = GUIDOF!IHTMLStyleSheetRulesCollection;
const GUID IID_IHTMLStyleSheetRulesCollection2          = GUIDOF!IHTMLStyleSheetRulesCollection2;
const GUID IID_IHTMLStyleSheetsCollection               = GUIDOF!IHTMLStyleSheetsCollection;
const GUID IID_IHTMLStyleSheetsCollection2              = GUIDOF!IHTMLStyleSheetsCollection2;
const GUID IID_IHTMLSubmitData                          = GUIDOF!IHTMLSubmitData;
const GUID IID_IHTMLTable                               = GUIDOF!IHTMLTable;
const GUID IID_IHTMLTable2                              = GUIDOF!IHTMLTable2;
const GUID IID_IHTMLTable3                              = GUIDOF!IHTMLTable3;
const GUID IID_IHTMLTable4                              = GUIDOF!IHTMLTable4;
const GUID IID_IHTMLTableCaption                        = GUIDOF!IHTMLTableCaption;
const GUID IID_IHTMLTableCell                           = GUIDOF!IHTMLTableCell;
const GUID IID_IHTMLTableCell2                          = GUIDOF!IHTMLTableCell2;
const GUID IID_IHTMLTableCell3                          = GUIDOF!IHTMLTableCell3;
const GUID IID_IHTMLTableCol                            = GUIDOF!IHTMLTableCol;
const GUID IID_IHTMLTableCol2                           = GUIDOF!IHTMLTableCol2;
const GUID IID_IHTMLTableCol3                           = GUIDOF!IHTMLTableCol3;
const GUID IID_IHTMLTableRow                            = GUIDOF!IHTMLTableRow;
const GUID IID_IHTMLTableRow2                           = GUIDOF!IHTMLTableRow2;
const GUID IID_IHTMLTableRow3                           = GUIDOF!IHTMLTableRow3;
const GUID IID_IHTMLTableRow4                           = GUIDOF!IHTMLTableRow4;
const GUID IID_IHTMLTableRowMetrics                     = GUIDOF!IHTMLTableRowMetrics;
const GUID IID_IHTMLTableSection                        = GUIDOF!IHTMLTableSection;
const GUID IID_IHTMLTableSection2                       = GUIDOF!IHTMLTableSection2;
const GUID IID_IHTMLTableSection3                       = GUIDOF!IHTMLTableSection3;
const GUID IID_IHTMLTableSection4                       = GUIDOF!IHTMLTableSection4;
const GUID IID_IHTMLTextAreaElement                     = GUIDOF!IHTMLTextAreaElement;
const GUID IID_IHTMLTextAreaElement2                    = GUIDOF!IHTMLTextAreaElement2;
const GUID IID_IHTMLTextContainer                       = GUIDOF!IHTMLTextContainer;
const GUID IID_IHTMLTextElement                         = GUIDOF!IHTMLTextElement;
const GUID IID_IHTMLTextRangeMetrics                    = GUIDOF!IHTMLTextRangeMetrics;
const GUID IID_IHTMLTextRangeMetrics2                   = GUIDOF!IHTMLTextRangeMetrics2;
const GUID IID_IHTMLTimeRanges                          = GUIDOF!IHTMLTimeRanges;
const GUID IID_IHTMLTimeRanges2                         = GUIDOF!IHTMLTimeRanges2;
const GUID IID_IHTMLTitleElement                        = GUIDOF!IHTMLTitleElement;
const GUID IID_IHTMLTxtRange                            = GUIDOF!IHTMLTxtRange;
const GUID IID_IHTMLTxtRangeCollection                  = GUIDOF!IHTMLTxtRangeCollection;
const GUID IID_IHTMLUListElement                        = GUIDOF!IHTMLUListElement;
const GUID IID_IHTMLUniqueName                          = GUIDOF!IHTMLUniqueName;
const GUID IID_IHTMLUnknownElement                      = GUIDOF!IHTMLUnknownElement;
const GUID IID_IHTMLUrnCollection                       = GUIDOF!IHTMLUrnCollection;
const GUID IID_IHTMLVideoElement                        = GUIDOF!IHTMLVideoElement;
const GUID IID_IHTMLWindow2                             = GUIDOF!IHTMLWindow2;
const GUID IID_IHTMLWindow3                             = GUIDOF!IHTMLWindow3;
const GUID IID_IHTMLWindow4                             = GUIDOF!IHTMLWindow4;
const GUID IID_IHTMLWindow5                             = GUIDOF!IHTMLWindow5;
const GUID IID_IHTMLWindow6                             = GUIDOF!IHTMLWindow6;
const GUID IID_IHTMLWindow7                             = GUIDOF!IHTMLWindow7;
const GUID IID_IHTMLWindow8                             = GUIDOF!IHTMLWindow8;
const GUID IID_IHTMLXDomainRequest                      = GUIDOF!IHTMLXDomainRequest;
const GUID IID_IHTMLXDomainRequestFactory               = GUIDOF!IHTMLXDomainRequestFactory;
const GUID IID_IHTMLXMLHttpRequest                      = GUIDOF!IHTMLXMLHttpRequest;
const GUID IID_IHTMLXMLHttpRequest2                     = GUIDOF!IHTMLXMLHttpRequest2;
const GUID IID_IHTMLXMLHttpRequestFactory               = GUIDOF!IHTMLXMLHttpRequestFactory;
const GUID IID_IHighlightRenderingServices              = GUIDOF!IHighlightRenderingServices;
const GUID IID_IHighlightSegment                        = GUIDOF!IHighlightSegment;
const GUID IID_IHostBehaviorInit                        = GUIDOF!IHostBehaviorInit;
const GUID IID_IHtmlDlgSafeHelper                       = GUIDOF!IHtmlDlgSafeHelper;
const GUID IID_IICCSVGColor                             = GUIDOF!IICCSVGColor;
const GUID IID_IIE70DispatchEx                          = GUIDOF!IIE70DispatchEx;
const GUID IID_IIE80DispatchEx                          = GUIDOF!IIE80DispatchEx;
const GUID IID_IIMEServices                             = GUIDOF!IIMEServices;
const GUID IID_ILineInfo                                = GUIDOF!ILineInfo;
const GUID IID_IMachineDebugManager                     = GUIDOF!IMachineDebugManager;
const GUID IID_IMachineDebugManagerCookie               = GUIDOF!IMachineDebugManagerCookie;
const GUID IID_IMachineDebugManagerEvents               = GUIDOF!IMachineDebugManagerEvents;
const GUID IID_IMarkupContainer                         = GUIDOF!IMarkupContainer;
const GUID IID_IMarkupContainer2                        = GUIDOF!IMarkupContainer2;
const GUID IID_IMarkupPointer                           = GUIDOF!IMarkupPointer;
const GUID IID_IMarkupPointer2                          = GUIDOF!IMarkupPointer2;
const GUID IID_IMarkupServices                          = GUIDOF!IMarkupServices;
const GUID IID_IMarkupServices2                         = GUIDOF!IMarkupServices2;
const GUID IID_IMarkupTextFrags                         = GUIDOF!IMarkupTextFrags;
const GUID IID_INavigatorDoNotTrack                     = GUIDOF!INavigatorDoNotTrack;
const GUID IID_INavigatorGeolocation                    = GUIDOF!INavigatorGeolocation;
const GUID IID_IOmHistory                               = GUIDOF!IOmHistory;
const GUID IID_IOmNavigator                             = GUIDOF!IOmNavigator;
const GUID IID_IPerPropertyBrowsing2                    = GUIDOF!IPerPropertyBrowsing2;
const GUID IID_IPrintManagerTemplatePrinter             = GUIDOF!IPrintManagerTemplatePrinter;
const GUID IID_IPrintManagerTemplatePrinter2            = GUIDOF!IPrintManagerTemplatePrinter2;
const GUID IID_IProcessDebugManager32                   = GUIDOF!IProcessDebugManager32;
const GUID IID_IProcessDebugManager64                   = GUIDOF!IProcessDebugManager64;
const GUID IID_IProvideExpressionContexts               = GUIDOF!IProvideExpressionContexts;
const GUID IID_IRangeException                          = GUIDOF!IRangeException;
const GUID IID_IRemoteDebugApplication                  = GUIDOF!IRemoteDebugApplication;
const GUID IID_IRemoteDebugApplicationEvents            = GUIDOF!IRemoteDebugApplicationEvents;
const GUID IID_IRemoteDebugApplicationThread            = GUIDOF!IRemoteDebugApplicationThread;
const GUID IID_IRulesApplied                            = GUIDOF!IRulesApplied;
const GUID IID_IRulesAppliedCollection                  = GUIDOF!IRulesAppliedCollection;
const GUID IID_ISVGAElement                             = GUIDOF!ISVGAElement;
const GUID IID_ISVGAngle                                = GUIDOF!ISVGAngle;
const GUID IID_ISVGAnimatedAngle                        = GUIDOF!ISVGAnimatedAngle;
const GUID IID_ISVGAnimatedBoolean                      = GUIDOF!ISVGAnimatedBoolean;
const GUID IID_ISVGAnimatedEnumeration                  = GUIDOF!ISVGAnimatedEnumeration;
const GUID IID_ISVGAnimatedInteger                      = GUIDOF!ISVGAnimatedInteger;
const GUID IID_ISVGAnimatedLength                       = GUIDOF!ISVGAnimatedLength;
const GUID IID_ISVGAnimatedLengthList                   = GUIDOF!ISVGAnimatedLengthList;
const GUID IID_ISVGAnimatedNumber                       = GUIDOF!ISVGAnimatedNumber;
const GUID IID_ISVGAnimatedNumberList                   = GUIDOF!ISVGAnimatedNumberList;
const GUID IID_ISVGAnimatedPathData                     = GUIDOF!ISVGAnimatedPathData;
const GUID IID_ISVGAnimatedPoints                       = GUIDOF!ISVGAnimatedPoints;
const GUID IID_ISVGAnimatedPreserveAspectRatio          = GUIDOF!ISVGAnimatedPreserveAspectRatio;
const GUID IID_ISVGAnimatedRect                         = GUIDOF!ISVGAnimatedRect;
const GUID IID_ISVGAnimatedString                       = GUIDOF!ISVGAnimatedString;
const GUID IID_ISVGAnimatedTransformList                = GUIDOF!ISVGAnimatedTransformList;
const GUID IID_ISVGCircleElement                        = GUIDOF!ISVGCircleElement;
const GUID IID_ISVGClipPathElement                      = GUIDOF!ISVGClipPathElement;
const GUID IID_ISVGDefsElement                          = GUIDOF!ISVGDefsElement;
const GUID IID_ISVGDescElement                          = GUIDOF!ISVGDescElement;
const GUID IID_ISVGDocument                             = GUIDOF!ISVGDocument;
const GUID IID_ISVGElement                              = GUIDOF!ISVGElement;
const GUID IID_ISVGElementInstance                      = GUIDOF!ISVGElementInstance;
const GUID IID_ISVGElementInstanceList                  = GUIDOF!ISVGElementInstanceList;
const GUID IID_ISVGEllipseElement                       = GUIDOF!ISVGEllipseElement;
const GUID IID_ISVGException                            = GUIDOF!ISVGException;
const GUID IID_ISVGExternalResourcesRequired            = GUIDOF!ISVGExternalResourcesRequired;
const GUID IID_ISVGFitToViewBox                         = GUIDOF!ISVGFitToViewBox;
const GUID IID_ISVGGElement                             = GUIDOF!ISVGGElement;
const GUID IID_ISVGGradientElement                      = GUIDOF!ISVGGradientElement;
const GUID IID_ISVGImageElement                         = GUIDOF!ISVGImageElement;
const GUID IID_ISVGLangSpace                            = GUIDOF!ISVGLangSpace;
const GUID IID_ISVGLength                               = GUIDOF!ISVGLength;
const GUID IID_ISVGLengthList                           = GUIDOF!ISVGLengthList;
const GUID IID_ISVGLineElement                          = GUIDOF!ISVGLineElement;
const GUID IID_ISVGLinearGradientElement                = GUIDOF!ISVGLinearGradientElement;
const GUID IID_ISVGLocatable                            = GUIDOF!ISVGLocatable;
const GUID IID_ISVGMarkerElement                        = GUIDOF!ISVGMarkerElement;
const GUID IID_ISVGMaskElement                          = GUIDOF!ISVGMaskElement;
const GUID IID_ISVGMatrix                               = GUIDOF!ISVGMatrix;
const GUID IID_ISVGMetadataElement                      = GUIDOF!ISVGMetadataElement;
const GUID IID_ISVGNumber                               = GUIDOF!ISVGNumber;
const GUID IID_ISVGNumberList                           = GUIDOF!ISVGNumberList;
const GUID IID_ISVGPaint                                = GUIDOF!ISVGPaint;
const GUID IID_ISVGPathElement                          = GUIDOF!ISVGPathElement;
const GUID IID_ISVGPathSeg                              = GUIDOF!ISVGPathSeg;
const GUID IID_ISVGPathSegArcAbs                        = GUIDOF!ISVGPathSegArcAbs;
const GUID IID_ISVGPathSegArcRel                        = GUIDOF!ISVGPathSegArcRel;
const GUID IID_ISVGPathSegClosePath                     = GUIDOF!ISVGPathSegClosePath;
const GUID IID_ISVGPathSegCurvetoCubicAbs               = GUIDOF!ISVGPathSegCurvetoCubicAbs;
const GUID IID_ISVGPathSegCurvetoCubicRel               = GUIDOF!ISVGPathSegCurvetoCubicRel;
const GUID IID_ISVGPathSegCurvetoCubicSmoothAbs         = GUIDOF!ISVGPathSegCurvetoCubicSmoothAbs;
const GUID IID_ISVGPathSegCurvetoCubicSmoothRel         = GUIDOF!ISVGPathSegCurvetoCubicSmoothRel;
const GUID IID_ISVGPathSegCurvetoQuadraticAbs           = GUIDOF!ISVGPathSegCurvetoQuadraticAbs;
const GUID IID_ISVGPathSegCurvetoQuadraticRel           = GUIDOF!ISVGPathSegCurvetoQuadraticRel;
const GUID IID_ISVGPathSegCurvetoQuadraticSmoothAbs     = GUIDOF!ISVGPathSegCurvetoQuadraticSmoothAbs;
const GUID IID_ISVGPathSegCurvetoQuadraticSmoothRel     = GUIDOF!ISVGPathSegCurvetoQuadraticSmoothRel;
const GUID IID_ISVGPathSegLinetoAbs                     = GUIDOF!ISVGPathSegLinetoAbs;
const GUID IID_ISVGPathSegLinetoHorizontalAbs           = GUIDOF!ISVGPathSegLinetoHorizontalAbs;
const GUID IID_ISVGPathSegLinetoHorizontalRel           = GUIDOF!ISVGPathSegLinetoHorizontalRel;
const GUID IID_ISVGPathSegLinetoRel                     = GUIDOF!ISVGPathSegLinetoRel;
const GUID IID_ISVGPathSegLinetoVerticalAbs             = GUIDOF!ISVGPathSegLinetoVerticalAbs;
const GUID IID_ISVGPathSegLinetoVerticalRel             = GUIDOF!ISVGPathSegLinetoVerticalRel;
const GUID IID_ISVGPathSegList                          = GUIDOF!ISVGPathSegList;
const GUID IID_ISVGPathSegMovetoAbs                     = GUIDOF!ISVGPathSegMovetoAbs;
const GUID IID_ISVGPathSegMovetoRel                     = GUIDOF!ISVGPathSegMovetoRel;
const GUID IID_ISVGPatternElement                       = GUIDOF!ISVGPatternElement;
const GUID IID_ISVGPoint                                = GUIDOF!ISVGPoint;
const GUID IID_ISVGPointList                            = GUIDOF!ISVGPointList;
const GUID IID_ISVGPolygonElement                       = GUIDOF!ISVGPolygonElement;
const GUID IID_ISVGPolylineElement                      = GUIDOF!ISVGPolylineElement;
const GUID IID_ISVGPreserveAspectRatio                  = GUIDOF!ISVGPreserveAspectRatio;
const GUID IID_ISVGRadialGradientElement                = GUIDOF!ISVGRadialGradientElement;
const GUID IID_ISVGRect                                 = GUIDOF!ISVGRect;
const GUID IID_ISVGRectElement                          = GUIDOF!ISVGRectElement;
const GUID IID_ISVGSVGElement                           = GUIDOF!ISVGSVGElement;
const GUID IID_ISVGScriptElement                        = GUIDOF!ISVGScriptElement;
const GUID IID_ISVGStopElement                          = GUIDOF!ISVGStopElement;
const GUID IID_ISVGStringList                           = GUIDOF!ISVGStringList;
const GUID IID_ISVGStylable                             = GUIDOF!ISVGStylable;
const GUID IID_ISVGStyleElement                         = GUIDOF!ISVGStyleElement;
const GUID IID_ISVGSwitchElement                        = GUIDOF!ISVGSwitchElement;
const GUID IID_ISVGSymbolElement                        = GUIDOF!ISVGSymbolElement;
const GUID IID_ISVGTSpanElement                         = GUIDOF!ISVGTSpanElement;
const GUID IID_ISVGTests                                = GUIDOF!ISVGTests;
const GUID IID_ISVGTextContentElement                   = GUIDOF!ISVGTextContentElement;
const GUID IID_ISVGTextElement                          = GUIDOF!ISVGTextElement;
const GUID IID_ISVGTextPathElement                      = GUIDOF!ISVGTextPathElement;
const GUID IID_ISVGTextPositioningElement               = GUIDOF!ISVGTextPositioningElement;
const GUID IID_ISVGTitleElement                         = GUIDOF!ISVGTitleElement;
const GUID IID_ISVGTransform                            = GUIDOF!ISVGTransform;
const GUID IID_ISVGTransformList                        = GUIDOF!ISVGTransformList;
const GUID IID_ISVGTransformable                        = GUIDOF!ISVGTransformable;
const GUID IID_ISVGURIReference                         = GUIDOF!ISVGURIReference;
const GUID IID_ISVGUseElement                           = GUIDOF!ISVGUseElement;
const GUID IID_ISVGViewElement                          = GUIDOF!ISVGViewElement;
const GUID IID_ISVGViewSpec                             = GUIDOF!ISVGViewSpec;
const GUID IID_ISVGZoomAndPan                           = GUIDOF!ISVGZoomAndPan;
const GUID IID_ISVGZoomEvent                            = GUIDOF!ISVGZoomEvent;
const GUID IID_IScriptEventHandler                      = GUIDOF!IScriptEventHandler;
const GUID IID_IScriptEventHandlerSourceInfo            = GUIDOF!IScriptEventHandlerSourceInfo;
const GUID IID_ISecureUrlHost                           = GUIDOF!ISecureUrlHost;
const GUID IID_ISegment                                 = GUIDOF!ISegment;
const GUID IID_ISegmentList                             = GUIDOF!ISegmentList;
const GUID IID_ISegmentListIterator                     = GUIDOF!ISegmentListIterator;
const GUID IID_ISelectionServices                       = GUIDOF!ISelectionServices;
const GUID IID_ISelectionServicesListener               = GUIDOF!ISelectionServicesListener;
const GUID IID_ISequenceNumber                          = GUIDOF!ISequenceNumber;
const GUID IID_ISimpleConnectionPoint                   = GUIDOF!ISimpleConnectionPoint;
const GUID IID_ISurfacePresenter                        = GUIDOF!ISurfacePresenter;
const GUID IID_ITemplatePrinter                         = GUIDOF!ITemplatePrinter;
const GUID IID_ITemplatePrinter2                        = GUIDOF!ITemplatePrinter2;
const GUID IID_ITemplatePrinter3                        = GUIDOF!ITemplatePrinter3;
const GUID IID_ITrackingProtection                      = GUIDOF!ITrackingProtection;
const GUID IID_ITridentEventSink                        = GUIDOF!ITridentEventSink;
const GUID IID_IViewObjectPresentNotify                 = GUIDOF!IViewObjectPresentNotify;
const GUID IID_IViewObjectPresentNotifySite             = GUIDOF!IViewObjectPresentNotifySite;
const GUID IID_IViewObjectPresentSite                   = GUIDOF!IViewObjectPresentSite;
const GUID IID_IViewObjectPrint                         = GUIDOF!IViewObjectPrint;
const GUID IID_IWBScriptControl                         = GUIDOF!IWBScriptControl;
const GUID IID_IWPCBlockedUrls                          = GUIDOF!IWPCBlockedUrls;
const GUID IID_IWebApplicationActivation                = GUIDOF!IWebApplicationActivation;
const GUID IID_IWebApplicationAuthoringMode             = GUIDOF!IWebApplicationAuthoringMode;
const GUID IID_IWebApplicationHost                      = GUIDOF!IWebApplicationHost;
const GUID IID_IWebApplicationNavigationEvents          = GUIDOF!IWebApplicationNavigationEvents;
const GUID IID_IWebApplicationScriptEvents              = GUIDOF!IWebApplicationScriptEvents;
const GUID IID_IWebApplicationUIEvents                  = GUIDOF!IWebApplicationUIEvents;
const GUID IID_IWebApplicationUpdateEvents              = GUIDOF!IWebApplicationUpdateEvents;
const GUID IID_IWebBridge                               = GUIDOF!IWebBridge;
const GUID IID_IWebGeocoordinates                       = GUIDOF!IWebGeocoordinates;
const GUID IID_IWebGeolocation                          = GUIDOF!IWebGeolocation;
const GUID IID_IWebGeoposition                          = GUIDOF!IWebGeoposition;
const GUID IID_IWebGeopositionError                     = GUIDOF!IWebGeopositionError;
const GUID IID_IXMLGenericParse                         = GUIDOF!IXMLGenericParse;
const GUID IID_IXMLHttpRequestEventTarget               = GUIDOF!IXMLHttpRequestEventTarget;
