// Written in the D programming language.

module windows.win32.system.diagnostics.debug_.activescript;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, HANDLE, HANDLE_PTR, HRESULT,
                                         HWND, PSTR, PWSTR, VARIANT_BOOL;
public import windows.win32.system.com : DISPPARAMS, EXCEPINFO, IDispatch, ITypeInfo,
                                         IUnknown, TYPEDESC;
public import windows.win32.system.diagnostics.debug_ : IDebugProperty;
public import windows.win32.system.variant : VARENUM, VARIANT;

extern(Windows) @nogc nothrow:


// Enums


alias SCRIPTLANGUAGEVERSION = int;
enum : int
{
    SCRIPTLANGUAGEVERSION_DEFAULT = 0x00000000,
    SCRIPTLANGUAGEVERSION_5_7     = 0x00000001,
    SCRIPTLANGUAGEVERSION_5_8     = 0x00000002,
    SCRIPTLANGUAGEVERSION_MAX     = 0x000000ff,
}

alias SCRIPTSTATE = int;
enum : int
{
    SCRIPTSTATE_UNINITIALIZED = 0x00000000,
    SCRIPTSTATE_INITIALIZED   = 0x00000005,
    SCRIPTSTATE_STARTED       = 0x00000001,
    SCRIPTSTATE_CONNECTED     = 0x00000002,
    SCRIPTSTATE_DISCONNECTED  = 0x00000003,
    SCRIPTSTATE_CLOSED        = 0x00000004,
}

alias SCRIPTTRACEINFO = int;
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

alias SCRIPTTHREADSTATE = int;
enum : int
{
    SCRIPTTHREADSTATE_NOTINSCRIPT = 0x00000000,
    SCRIPTTHREADSTATE_RUNNING     = 0x00000001,
}

alias SCRIPTGCTYPE = int;
enum : int
{
    SCRIPTGCTYPE_NORMAL     = 0x00000000,
    SCRIPTGCTYPE_EXHAUSTIVE = 0x00000001,
}

alias SCRIPTUICITEM = int;
enum : int
{
    SCRIPTUICITEM_INPUTBOX = 0x00000001,
    SCRIPTUICITEM_MSGBOX   = 0x00000002,
}

alias SCRIPTUICHANDLING = int;
enum : int
{
    SCRIPTUICHANDLING_ALLOW       = 0x00000000,
    SCRIPTUICHANDLING_NOUIERROR   = 0x00000001,
    SCRIPTUICHANDLING_NOUIDEFAULT = 0x00000002,
}

alias BREAKPOINT_STATE = int;
enum : int
{
    BREAKPOINT_DELETED  = 0x00000000,
    BREAKPOINT_DISABLED = 0x00000001,
    BREAKPOINT_ENABLED  = 0x00000002,
}

alias BREAKREASON = int;
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

alias BREAKRESUMEACTION = int;
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

alias ERRORRESUMEACTION = int;
enum : int
{
    ERRORRESUMEACTION_ReexecuteErrorStatement         = 0x00000000,
    ERRORRESUMEACTION_AbortCallAndReturnErrorToCaller = 0x00000001,
    ERRORRESUMEACTION_SkipErrorStatement              = 0x00000002,
}

alias DOCUMENTNAMETYPE = int;
enum : int
{
    DOCUMENTNAMETYPE_APPNODE        = 0x00000000,
    DOCUMENTNAMETYPE_TITLE          = 0x00000001,
    DOCUMENTNAMETYPE_FILE_TAIL      = 0x00000002,
    DOCUMENTNAMETYPE_URL            = 0x00000003,
    DOCUMENTNAMETYPE_UNIQUE_TITLE   = 0x00000004,
    DOCUMENTNAMETYPE_SOURCE_MAP_URL = 0x00000005,
}

alias PROFILER_SCRIPT_TYPE = int;
enum : int
{
    PROFILER_SCRIPT_TYPE_USER    = 0x00000000,
    PROFILER_SCRIPT_TYPE_DYNAMIC = 0x00000001,
    PROFILER_SCRIPT_TYPE_NATIVE  = 0x00000002,
    PROFILER_SCRIPT_TYPE_DOM     = 0x00000003,
}

alias PROFILER_EVENT_MASK = int;
enum : int
{
    PROFILER_EVENT_MASK_TRACE_SCRIPT_FUNCTION_CALL = 0x00000001,
    PROFILER_EVENT_MASK_TRACE_NATIVE_FUNCTION_CALL = 0x00000002,
    PROFILER_EVENT_MASK_TRACE_DOM_FUNCTION_CALL    = 0x00000004,
    PROFILER_EVENT_MASK_TRACE_ALL                  = 0x00000003,
    PROFILER_EVENT_MASK_TRACE_ALL_WITH_DOM         = 0x00000007,
}

alias PROFILER_HEAP_OBJECT_FLAGS = int;
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

alias PROFILER_HEAP_OBJECT_OPTIONAL_INFO_TYPE = int;
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

alias PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS = int;
enum : int
{
    PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS_NONE            = 0x00000000,
    PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS_IS_GET_ACCESSOR = 0x00010000,
    PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS_IS_SET_ACCESSOR = 0x00020000,
    PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS_LET_VARIABLE    = 0x00040000,
    PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS_CONST_VARIABLE  = 0x00080000,
}

alias PROFILER_HEAP_ENUM_FLAGS = int;
enum : int
{
    PROFILER_HEAP_ENUM_FLAGS_NONE                     = 0x00000000,
    PROFILER_HEAP_ENUM_FLAGS_STORE_RELATIONSHIP_FLAGS = 0x00000001,
    PROFILER_HEAP_ENUM_FLAGS_SUBSTRINGS               = 0x00000002,
    PROFILER_HEAP_ENUM_FLAGS_RELATIONSHIP_SUBSTRINGS  = 0x00000003,
}

alias PROFILER_RELATIONSHIP_INFO = int;
enum : int
{
    PROFILER_PROPERTY_TYPE_NUMBER          = 0x00000001,
    PROFILER_PROPERTY_TYPE_STRING          = 0x00000002,
    PROFILER_PROPERTY_TYPE_HEAP_OBJECT     = 0x00000003,
    PROFILER_PROPERTY_TYPE_EXTERNAL_OBJECT = 0x00000004,
    PROFILER_PROPERTY_TYPE_BSTR            = 0x00000005,
    PROFILER_PROPERTY_TYPE_SUBSTRING       = 0x00000006,
}

alias PROFILER_HEAP_SUMMARY_VERSION = int;
enum : int
{
    PROFILER_HEAP_SUMMARY_VERSION_1 = 0x00000001,
}

alias APPLICATION_NODE_EVENT_FILTER = int;
enum : int
{
    FILTER_EXCLUDE_NOTHING        = 0x00000000,
    FILTER_EXCLUDE_ANONYMOUS_CODE = 0x00000001,
    FILTER_EXCLUDE_EVAL_CODE      = 0x00000002,
}

alias SCRIPT_DEBUGGER_OPTIONS = int;
enum : int
{
    SDO_NONE                           = 0x00000000,
    SDO_ENABLE_FIRST_CHANCE_EXCEPTIONS = 0x00000001,
    SDO_ENABLE_WEB_WORKER_SUPPORT      = 0x00000002,
    SDO_ENABLE_NONUSER_CODE_SUPPORT    = 0x00000004,
    SDO_ENABLE_LIBRARY_STACK_FRAME     = 0x00000008,
}

alias SCRIPT_ERROR_DEBUG_EXCEPTION_THROWN_KIND = int;
enum : int
{
    ETK_FIRST_CHANCE   = 0x00000000,
    ETK_USER_UNHANDLED = 0x00000001,
    ETK_UNHANDLED      = 0x00000002,
}

alias SCRIPT_INVOCATION_CONTEXT_TYPE = int;
enum : int
{
    SICT_Event                      = 0x00000000,
    SICT_SetTimeout                 = 0x00000001,
    SICT_SetInterval                = 0x00000002,
    SICT_SetImmediate               = 0x00000003,
    SICT_RequestAnimationFrame      = 0x00000004,
    SICT_ToString                   = 0x00000005,
    SICT_MutationObserverCheckpoint = 0x00000006,
    SICT_WWAExecUnsafeLocalFunction = 0x00000007,
    SICT_WWAExecAtPriority          = 0x00000008,
}

alias DEBUG_STACKFRAME_TYPE = int;
enum : int
{
    DST_SCRIPT_FRAME     = 0x00000000,
    DST_INTERNAL_FRAME   = 0x00000001,
    DST_INVOCATION_FRAME = 0x00000002,
}

alias DEBUG_EVENT_INFO_TYPE = int;
enum : int
{
    DEIT_GENERAL            = 0x00000000,
    DEIT_ASMJS_IN_DEBUGGING = 0x00000001,
    DEIT_ASMJS_SUCCEEDED    = 0x00000002,
    DEIT_ASMJS_FAILED       = 0x00000003,
}

alias JS_PROPERTY_MEMBERS = int;
enum : int
{
    JS_PROPERTY_MEMBERS_ALL       = 0x00000000,
    JS_PROPERTY_MEMBERS_ARGUMENTS = 0x00000001,
}

alias JS_PROPERTY_ATTRIBUTES = int;
enum : int
{
    JS_PROPERTY_ATTRIBUTE_NONE       = 0x00000000,
    JS_PROPERTY_HAS_CHILDREN         = 0x00000001,
    JS_PROPERTY_FAKE                 = 0x00000002,
    JS_PROPERTY_METHOD               = 0x00000004,
    JS_PROPERTY_READONLY             = 0x00000008,
    JS_PROPERTY_NATIVE_WINRT_POINTER = 0x00000010,
    JS_PROPERTY_FRAME_INTRYBLOCK     = 0x00000020,
    JS_PROPERTY_FRAME_INCATCHBLOCK   = 0x00000040,
    JS_PROPERTY_FRAME_INFINALLYBLOCK = 0x00000080,
}

//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
enum JsDebugReadMemoryFlags : int
{
    None                    = 0x00000000,
    JsDebugAllowPartialRead = 0x00000001,
}

// Constants


enum GUID CATID_ActiveScriptAuthor = GUID("0aee2a92-bcbb-11d0-8c72-00c04fc2b085");

enum : uint
{
    APPBREAKFLAG_DEBUGGER_BLOCK    = 0x00000001U,
    APPBREAKFLAG_DEBUGGER_HALT     = 0x00000002U,
    APPBREAKFLAG_STEP              = 0x00010000U,
    APPBREAKFLAG_NESTED            = 0x00020000U,
    APPBREAKFLAG_STEPTYPE_SOURCE   = 0x00000000U,
    APPBREAKFLAG_STEPTYPE_BYTECODE = 0x00100000U,
    APPBREAKFLAG_STEPTYPE_MACHINE  = 0x00200000U,
    APPBREAKFLAG_STEPTYPE_MASK     = 0x00f00000U,
    APPBREAKFLAG_IN_BREAKPOINT     = 0x80000000U,
}

enum : uint
{
    SOURCETEXT_ATTR_KEYWORD        = 0x00000001U,
    SOURCETEXT_ATTR_COMMENT        = 0x00000002U,
    SOURCETEXT_ATTR_NONSOURCE      = 0x00000004U,
    SOURCETEXT_ATTR_OPERATOR       = 0x00000008U,
    SOURCETEXT_ATTR_NUMBER         = 0x00000010U,
    SOURCETEXT_ATTR_STRING         = 0x00000020U,
    SOURCETEXT_ATTR_FUNCTION_START = 0x00000040U,
}

enum : uint
{
    TEXT_DOC_ATTR_READONLY     = 0x00000001U,
    TEXT_DOC_ATTR_TYPE_PRIMARY = 0x00000002U,
    TEXT_DOC_ATTR_TYPE_WORKER  = 0x00000004U,
    TEXT_DOC_ATTR_TYPE_SCRIPT  = 0x00000008U,
}

enum : uint
{
    DEBUG_TEXT_ISEXPRESSION          = 0x00000001U,
    DEBUG_TEXT_RETURNVALUE           = 0x00000002U,
    DEBUG_TEXT_NOSIDEEFFECTS         = 0x00000004U,
    DEBUG_TEXT_ALLOWBREAKPOINTS      = 0x00000008U,
    DEBUG_TEXT_ALLOWERRORREPORT      = 0x00000010U,
    DEBUG_TEXT_EVALUATETOCODECONTEXT = 0x00000020U,
}

enum uint DEBUG_TEXT_ISNONUSERCODE = 0x00000040U;

enum : uint
{
    THREAD_STATE_RUNNING   = 0x00000001U,
    THREAD_STATE_SUSPENDED = 0x00000002U,
}

enum : uint
{
    THREAD_BLOCKED        = 0x00000004U,
    THREAD_OUT_OF_CONTEXT = 0x00000008U,
}

enum : GUID
{
    CATID_ActiveScript       = GUID("f0b7a1a1-9847-11cf-8f20-00805f2cd064"),
    CATID_ActiveScriptParse  = GUID("f0b7a1a2-9847-11cf-8f20-00805f2cd064"),
    CATID_ActiveScriptEncode = GUID("f0b7a1a3-9847-11cf-8f20-00805f2cd064"),
}

enum GUID OID_VBSSIP = GUID("1629f04e-2799-4db5-8fe5-ace10f17ebab");

enum : GUID
{
    OID_JSSIP  = GUID("06c9e010-38ce-11d4-a2a3-00104bd35090"),
    OID_WSFSIP = GUID("1a610570-38ce-11d4-a2a3-00104bd35090"),
}

enum : uint
{
    SCRIPTITEM_ISVISIBLE     = 0x00000002U,
    SCRIPTITEM_ISSOURCE      = 0x00000004U,
    SCRIPTITEM_GLOBALMEMBERS = 0x00000008U,
    SCRIPTITEM_ISPERSISTENT  = 0x00000040U,
    SCRIPTITEM_CODEONLY      = 0x00000200U,
    SCRIPTITEM_NOCODE        = 0x00000400U,
}

enum : uint
{
    SCRIPTTYPELIB_ISCONTROL    = 0x00000010U,
    SCRIPTTYPELIB_ISPERSISTENT = 0x00000040U,
}

enum : uint
{
    SCRIPTTEXT_DELAYEXECUTION    = 0x00000001U,
    SCRIPTTEXT_ISVISIBLE         = 0x00000002U,
    SCRIPTTEXT_ISEXPRESSION      = 0x00000020U,
    SCRIPTTEXT_ISPERSISTENT      = 0x00000040U,
    SCRIPTTEXT_HOSTMANAGESSOURCE = 0x00000080U,
}

enum : uint
{
    SCRIPTTEXT_ISXDOMAIN     = 0x00000100U,
    SCRIPTTEXT_ISNONUSERCODE = 0x00000200U,
}

enum : uint
{
    SCRIPTPROC_ISEXPRESSION      = 0x00000020U,
    SCRIPTPROC_HOSTMANAGESSOURCE = 0x00000080U,
}

enum : uint
{
    SCRIPTPROC_IMPLICIT_THIS    = 0x00000100U,
    SCRIPTPROC_IMPLICIT_PARENTS = 0x00000200U,
    SCRIPTPROC_ISXDOMAIN        = 0x00000400U,
}

enum : uint
{
    SCRIPTINFO_IUNKNOWN  = 0x00000001U,
    SCRIPTINFO_ITYPEINFO = 0x00000002U,
}

enum : uint
{
    SCRIPTINTERRUPT_DEBUG          = 0x00000001U,
    SCRIPTINTERRUPT_RAISEEXCEPTION = 0x00000002U,
}

enum : uint
{
    SCRIPTSTAT_STATEMENT_COUNT   = 0x00000001U,
    SCRIPTSTAT_INSTRUCTION_COUNT = 0x00000002U,
    SCRIPTSTAT_INTSTRUCTION_TIME = 0x00000003U,
}

enum uint SCRIPTSTAT_TOTAL_TIME = 0x00000004U;

enum : uint
{
    SCRIPT_ENCODE_SECTION          = 0x00000001U,
    SCRIPT_ENCODE_DEFAULT_LANGUAGE = 0x00000001U,
    SCRIPT_ENCODE_NO_ASP_LANGUAGE  = 0x00000002U,
}

enum : uint
{
    SCRIPTPROP_NAME                = 0x00000000U,
    SCRIPTPROP_MAJORVERSION        = 0x00000001U,
    SCRIPTPROP_MINORVERSION        = 0x00000002U,
    SCRIPTPROP_BUILDNUMBER         = 0x00000003U,
    SCRIPTPROP_DELAYEDEVENTSINKING = 0x00001000U,
}

enum : uint
{
    SCRIPTPROP_CATCHEXCEPTION    = 0x00001001U,
    SCRIPTPROP_CONVERSIONLCID    = 0x00001002U,
    SCRIPTPROP_HOSTSTACKREQUIRED = 0x00001003U,
}

enum uint SCRIPTPROP_SCRIPTSAREFULLYTRUSTED = 0x00001004U;

enum : uint
{
    SCRIPTPROP_DEBUGGER           = 0x00001100U,
    SCRIPTPROP_JITDEBUG           = 0x00001101U,
    SCRIPTPROP_GCCONTROLSOFTCLOSE = 0x00002000U,
}

enum : uint
{
    SCRIPTPROP_INTEGERMODE           = 0x00003000U,
    SCRIPTPROP_STRINGCOMPAREINSTANCE = 0x00003001U,
}

enum : uint
{
    SCRIPTPROP_INVOKEVERSIONING      = 0x00004000U,
    SCRIPTPROP_HACK_FIBERSUPPORT     = 0x70000000U,
    SCRIPTPROP_HACK_TRIDENTEVENTSINK = 0x70000001U,
}

enum uint SCRIPTPROP_ABBREVIATE_GLOBALNAME_RESOLUTION = 0x70000002U;
enum uint SCRIPTPROP_HOSTKEEPALIVE = 0x70000004U;

enum : int
{
    SCRIPT_E_RECORDED  = 0x86664004,
    SCRIPT_E_REPORTED  = 0x80020101,
    SCRIPT_E_PROPAGATE = 0x80020102,
}

enum uint FACILITY_JsDEBUG = 0x00000dc7U;
enum HRESULT E_JsDEBUG_MISMATCHED_RUNTIME = HRESULT(0x8dc70001);

enum : HRESULT
{
    E_JsDEBUG_UNKNOWN_THREAD         = HRESULT(0x8dc70002),
    E_JsDEBUG_OUTSIDE_OF_VM          = HRESULT(0x8dc70004),
    E_JsDEBUG_INVALID_MEMORY_ADDRESS = HRESULT(0x8dc70005),
}

enum HRESULT E_JsDEBUG_SOURCE_LOCATION_NOT_FOUND = HRESULT(0x8dc70006);
enum HRESULT E_JsDEBUG_RUNTIME_NOT_IN_DEBUG_MODE = HRESULT(0x8dc70007);

enum : HRESULT
{
    ACTIVPROF_E_PROFILER_PRESENT       = HRESULT(0x80040200),
    ACTIVPROF_E_PROFILER_ABSENT        = HRESULT(0x80040201),
    ACTIVPROF_E_UNABLE_TO_APPLY_ACTION = HRESULT(0x80040202),
}

enum uint PROFILER_HEAP_OBJECT_NAME_ID_UNAVAILABLE = 0xffffffffU;
enum uint fasaPreferInternalHandler = 0x00000001U;
enum uint fasaSupportInternalHandler = 0x00000002U;
enum uint fasaCaseSensitive = 0x00000004U;

enum : uint
{
    SCRIPT_CMPL_NOLIST         = 0x00000000U,
    SCRIPT_CMPL_MEMBERLIST     = 0x00000001U,
    SCRIPT_CMPL_ENUMLIST       = 0x00000002U,
    SCRIPT_CMPL_PARAMTIP       = 0x00000004U,
    SCRIPT_CMPL_GLOBALLIST     = 0x00000008U,
    SCRIPT_CMPL_ENUM_TRIGGER   = 0x00000001U,
    SCRIPT_CMPL_MEMBER_TRIGGER = 0x00000002U,
    SCRIPT_CMPL_PARAM_TRIGGER  = 0x00000003U,
    SCRIPT_CMPL_COMMIT         = 0x00000004U,
}

enum : uint
{
    GETATTRTYPE_NORMAL  = 0x00000000U,
    GETATTRTYPE_DEPSCAN = 0x00000001U,
}

enum : uint
{
    GETATTRFLAG_THIS      = 0x00000100U,
    GETATTRFLAG_HUMANTEXT = 0x00008000U,
}

enum : uint
{
    SOURCETEXT_ATTR_HUMANTEXT    = 0x00008000U,
    SOURCETEXT_ATTR_IDENTIFIER   = 0x00000100U,
    SOURCETEXT_ATTR_MEMBERLOOKUP = 0x00000200U,
    SOURCETEXT_ATTR_THIS         = 0x00000400U,
}

// Structs


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
    size_t[1] scopes; // Flexible array
}

struct PROFILER_PROPERTY_TYPE_SUBSTRING_INFO
{
    uint         length;
    const(PWSTR) value;
}

struct PROFILER_HEAP_OBJECT_RELATIONSHIP
{
    uint relationshipId;
    PROFILER_RELATIONSHIP_INFO relationshipInfo;
    union
    {
        double       numberValue;
        const(PWSTR) stringValue;
        BSTR         bstrValue;
        size_t       objectId;
        void*        externalObjectAddress;
        PROFILER_PROPERTY_TYPE_SUBSTRING_INFO* subString;
    }
}

struct PROFILER_HEAP_OBJECT_RELATIONSHIP_LIST
{
    uint count;
    PROFILER_HEAP_OBJECT_RELATIONSHIP[1] elements; // Flexible array
}

struct PROFILER_HEAP_OBJECT_OPTIONAL_INFO
{
    PROFILER_HEAP_OBJECT_OPTIONAL_INFO_TYPE infoType;
    union
    {
        size_t       prototype;
        const(PWSTR) functionName;
        uint         elementAttributesSize;
        uint         elementTextChildrenSize;
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
    PROFILER_HEAP_SUMMARY_VERSION version_;
    uint totalHeapSize;
}

struct TEXT_DOCUMENT_ARRAY
{
    uint                dwCount;
    IDebugDocumentText* Members;
}

struct JsDebugPropertyInfo
{
    BSTR name;
    BSTR type;
    BSTR value;
    BSTR fullName;
    JS_PROPERTY_ATTRIBUTES attr;
}

struct JS_NATIVE_FRAME
{
    ulong InstructionOffset;
    ulong ReturnOffset;
    ulong FrameOffset;
    ulong StackOffset;
}

// Interfaces

@GUID("78a51822-51f4-11d0-8f20-00805f2cd064")
struct ProcessDebugManager;

@GUID("0bfcc060-8c1d-11d0-accd-00aa0060275c")
struct DebugHelper;

@GUID("83b8bca6-687c-11d0-a405-00aa0060275c")
struct CDebugDocumentHelper;

@GUID("0c0a3666-30c9-11d0-8f20-00805f2cd064")
struct MachineDebugManager_RETAIL;

@GUID("49769cec-3a55-4bb0-b697-88fede77e8ea")
struct MachineDebugManager_DEBUG;

@GUID("834128a2-51f4-11d0-8f20-00805f2cd064")
struct DefaultDebugSessionProvider;

@GUID("db01a1e3-a42b-11cf-8f20-00805f2cd064")
interface IActiveScriptSite : IUnknown
{
    HRESULT GetLCID(uint* plcid);
    HRESULT GetItemInfo(const(PWSTR) pstrName, uint dwReturnMask, IUnknown* ppiunkItem, ITypeInfo* ppti);
    HRESULT GetDocVersionString(BSTR* pbstrVersion);
    HRESULT OnScriptTerminate(const(VARIANT)* pvarResult, const(EXCEPINFO)* pexcepinfo);
    HRESULT OnStateChange(SCRIPTSTATE ssScriptState);
    HRESULT OnScriptError(IActiveScriptError pscripterror);
    HRESULT OnEnterScript();
    HRESULT OnLeaveScript();
}

@GUID("eae1ba61-a4ed-11cf-8f20-00805f2cd064")
interface IActiveScriptError : IUnknown
{
    HRESULT GetExceptionInfo(EXCEPINFO* pexcepinfo);
    HRESULT GetSourcePosition(uint* pdwSourceContext, uint* pulLineNumber, int* plCharacterPosition);
    HRESULT GetSourceLineText(BSTR* pbstrSourceLine);
}

@GUID("b21fb2a1-5b8f-4963-8c21-21450f84ed7f")
interface IActiveScriptError64 : IActiveScriptError
{
    HRESULT GetSourcePosition64(ulong* pdwSourceContext, uint* pulLineNumber, int* plCharacterPosition);
}

@GUID("d10f6761-83e9-11cf-8f20-00805f2cd064")
interface IActiveScriptSiteWindow : IUnknown
{
    HRESULT GetWindow(HWND* phwnd);
    HRESULT EnableModeless(BOOL fEnable);
}

@GUID("aedae97e-d7ee-4796-b960-7f092ae844ab")
interface IActiveScriptSiteUIControl : IUnknown
{
    HRESULT GetUIBehavior(SCRIPTUICITEM UicItem, SCRIPTUICHANDLING* pUicHandling);
}

@GUID("539698a0-cdca-11cf-a5eb-00aa0047a063")
interface IActiveScriptSiteInterruptPoll : IUnknown
{
    HRESULT QueryContinue();
}

@GUID("bb1a2ae1-a4f9-11cf-8f20-00805f2cd064")
interface IActiveScript : IUnknown
{
    HRESULT SetScriptSite(IActiveScriptSite pass);
    HRESULT GetScriptSite(const(GUID)* riid, void** ppvObject);
    HRESULT SetScriptState(SCRIPTSTATE ss);
    HRESULT GetScriptState(SCRIPTSTATE* pssState);
    HRESULT Close();
    HRESULT AddNamedItem(const(PWSTR) pstrName, uint dwFlags);
    HRESULT AddTypeLib(const(GUID)* rguidTypeLib, uint dwMajor, uint dwMinor, uint dwFlags);
    HRESULT GetScriptDispatch(const(PWSTR) pstrItemName, IDispatch* ppdisp);
    HRESULT GetCurrentScriptThreadID(uint* pstidThread);
    HRESULT GetScriptThreadID(uint dwWin32ThreadId, uint* pstidThread);
    HRESULT GetScriptThreadState(uint stidThread, SCRIPTTHREADSTATE* pstsState);
    HRESULT InterruptScriptThread(uint stidThread, const(EXCEPINFO)* pexcepinfo, uint dwFlags);
    HRESULT Clone(IActiveScript* ppscript);
}

@GUID("bb1a2ae2-a4f9-11cf-8f20-00805f2cd064")
interface IActiveScriptParse32 : IUnknown
{
    HRESULT InitNew();
    HRESULT AddScriptlet(const(PWSTR) pstrDefaultName, const(PWSTR) pstrCode, const(PWSTR) pstrItemName, 
                         const(PWSTR) pstrSubItemName, const(PWSTR) pstrEventName, const(PWSTR) pstrDelimiter, 
                         uint dwSourceContextCookie, uint ulStartingLineNumber, uint dwFlags, BSTR* pbstrName, 
                         EXCEPINFO* pexcepinfo);
    HRESULT ParseScriptText(const(PWSTR) pstrCode, const(PWSTR) pstrItemName, IUnknown punkContext, 
                            const(PWSTR) pstrDelimiter, uint dwSourceContextCookie, uint ulStartingLineNumber, 
                            uint dwFlags, VARIANT* pvarResult, EXCEPINFO* pexcepinfo);
}

@GUID("c7ef7658-e1ee-480e-97ea-d52cb4d76d17")
interface IActiveScriptParse64 : IUnknown
{
    HRESULT InitNew();
    HRESULT AddScriptlet(const(PWSTR) pstrDefaultName, const(PWSTR) pstrCode, const(PWSTR) pstrItemName, 
                         const(PWSTR) pstrSubItemName, const(PWSTR) pstrEventName, const(PWSTR) pstrDelimiter, 
                         ulong dwSourceContextCookie, uint ulStartingLineNumber, uint dwFlags, BSTR* pbstrName, 
                         EXCEPINFO* pexcepinfo);
    HRESULT ParseScriptText(const(PWSTR) pstrCode, const(PWSTR) pstrItemName, IUnknown punkContext, 
                            const(PWSTR) pstrDelimiter, ulong dwSourceContextCookie, uint ulStartingLineNumber, 
                            uint dwFlags, VARIANT* pvarResult, EXCEPINFO* pexcepinfo);
}

@GUID("1cff0050-6fdd-11d0-9328-00a0c90dcaa9")
interface IActiveScriptParseProcedureOld32 : IUnknown
{
    HRESULT ParseProcedureText(const(PWSTR) pstrCode, const(PWSTR) pstrFormalParams, const(PWSTR) pstrItemName, 
                               IUnknown punkContext, const(PWSTR) pstrDelimiter, uint dwSourceContextCookie, 
                               uint ulStartingLineNumber, uint dwFlags, IDispatch* ppdisp);
}

@GUID("21f57128-08c9-4638-ba12-22d15d88dc5c")
interface IActiveScriptParseProcedureOld64 : IUnknown
{
    HRESULT ParseProcedureText(const(PWSTR) pstrCode, const(PWSTR) pstrFormalParams, const(PWSTR) pstrItemName, 
                               IUnknown punkContext, const(PWSTR) pstrDelimiter, ulong dwSourceContextCookie, 
                               uint ulStartingLineNumber, uint dwFlags, IDispatch* ppdisp);
}

@GUID("aa5b6a80-b834-11d0-932f-00a0c90dcaa9")
interface IActiveScriptParseProcedure32 : IUnknown
{
    HRESULT ParseProcedureText(const(PWSTR) pstrCode, const(PWSTR) pstrFormalParams, 
                               const(PWSTR) pstrProcedureName, const(PWSTR) pstrItemName, IUnknown punkContext, 
                               const(PWSTR) pstrDelimiter, uint dwSourceContextCookie, uint ulStartingLineNumber, 
                               uint dwFlags, IDispatch* ppdisp);
}

@GUID("c64713b6-e029-4cc5-9200-438b72890b6a")
interface IActiveScriptParseProcedure64 : IUnknown
{
    HRESULT ParseProcedureText(const(PWSTR) pstrCode, const(PWSTR) pstrFormalParams, 
                               const(PWSTR) pstrProcedureName, const(PWSTR) pstrItemName, IUnknown punkContext, 
                               const(PWSTR) pstrDelimiter, ulong dwSourceContextCookie, uint ulStartingLineNumber, 
                               uint dwFlags, IDispatch* ppdisp);
}

@GUID("71ee5b20-fb04-11d1-b3a8-00a0c911e8b2")
interface IActiveScriptParseProcedure2_32 : IActiveScriptParseProcedure32
{
}

@GUID("fe7c4271-210c-448d-9f54-76dab7047b28")
interface IActiveScriptParseProcedure2_64 : IActiveScriptParseProcedure64
{
}

@GUID("bb1a2ae3-a4f9-11cf-8f20-00805f2cd064")
interface IActiveScriptEncode : IUnknown
{
    HRESULT EncodeSection(const(PWSTR) pchIn, uint cchIn, PWSTR pchOut, uint cchOut, uint* pcchRet);
    HRESULT DecodeScript(const(PWSTR) pchIn, uint cchIn, PWSTR pchOut, uint cchOut, uint* pcchRet);
    HRESULT GetEncodeProgId(BSTR* pbstrOut);
}

@GUID("bee9b76e-cfe3-11d1-b747-00c04fc2b085")
interface IActiveScriptHostEncode : IUnknown
{
    HRESULT EncodeScriptHostFile(BSTR bstrInFile, BSTR* pbstrOutFile, uint cFlags, BSTR bstrDefaultLang);
}

@GUID("63cdbcb0-c1b1-11d0-9336-00a0c90dcaa9")
interface IBindEventHandler : IUnknown
{
    HRESULT BindHandler(const(PWSTR) pstrEvent, IDispatch pdisp);
}

@GUID("b8da6310-e19b-11d0-933c-00a0c90dcaa9")
interface IActiveScriptStats : IUnknown
{
    HRESULT GetStat(uint stid, uint* pluHi, uint* pluLo);
    HRESULT GetStatEx(const(GUID)* guid, uint* pluHi, uint* pluLo);
    HRESULT ResetStats();
}

@GUID("4954e0d0-fbc7-11d1-8410-006008c3fbfc")
interface IActiveScriptProperty : IUnknown
{
    HRESULT GetProperty(uint dwProperty, VARIANT* pvarIndex, VARIANT* pvarValue);
    HRESULT SetProperty(uint dwProperty, VARIANT* pvarIndex, VARIANT* pvarValue);
}

@GUID("1dc9ca50-06ef-11d2-8415-006008c3fbfc")
interface ITridentEventSink : IUnknown
{
    HRESULT FireEvent(const(PWSTR) pstrEvent, DISPPARAMS* pdp, VARIANT* pvarRes, EXCEPINFO* pei);
}

@GUID("6aa2c4a0-2b53-11d4-a2a0-00104bd35090")
interface IActiveScriptGarbageCollector : IUnknown
{
    HRESULT CollectGarbage(SCRIPTGCTYPE scriptgctype);
}

@GUID("764651d0-38de-11d4-a2a3-00104bd35090")
interface IActiveScriptSIPInfo : IUnknown
{
    HRESULT GetSIPOID(GUID* poid_sip);
}

@GUID("4b7272ae-1955-4bfe-98b0-780621888569")
interface IActiveScriptSiteTraceInfo : IUnknown
{
    HRESULT SendScriptTraceInfo(SCRIPTTRACEINFO stiEventType, GUID guidContextID, uint dwScriptContextCookie, 
                                int lScriptStatementStart, int lScriptStatementEnd, ulong dwReserved);
}

@GUID("c35456e7-bebf-4a1b-86a9-24d56be8b369")
interface IActiveScriptTraceInfo : IUnknown
{
    HRESULT StartScriptTracing(IActiveScriptSiteTraceInfo pSiteTraceInfo, GUID guidContextID);
    HRESULT StopScriptTracing();
}

@GUID("58562769-ed52-42f7-8403-4963514e1f11")
interface IActiveScriptStringCompare : IUnknown
{
    HRESULT StrComp(BSTR bszStr1, BSTR bszStr2, int* iRet);
}

@GUID("51973c10-cb0c-11d0-b5c9-00a0244a0e7a")
interface IActiveScriptDebug32 : IUnknown
{
    HRESULT GetScriptTextAttributes(const(PWSTR) pstrCode, uint uNumCodeChars, const(PWSTR) pstrDelimiter, 
                                    uint dwFlags, ushort* pattr);
    HRESULT GetScriptletTextAttributes(const(PWSTR) pstrCode, uint uNumCodeChars, const(PWSTR) pstrDelimiter, 
                                       uint dwFlags, ushort* pattr);
    HRESULT EnumCodeContextsOfPosition(uint dwSourceContext, uint uCharacterOffset, uint uNumChars, 
                                       IEnumDebugCodeContexts* ppescc);
}

@GUID("bc437e23-f5b8-47f4-bb79-7d1ce5483b86")
interface IActiveScriptDebug64 : IUnknown
{
    HRESULT GetScriptTextAttributes(const(PWSTR) pstrCode, uint uNumCodeChars, const(PWSTR) pstrDelimiter, 
                                    uint dwFlags, ushort* pattr);
    HRESULT GetScriptletTextAttributes(const(PWSTR) pstrCode, uint uNumCodeChars, const(PWSTR) pstrDelimiter, 
                                       uint dwFlags, ushort* pattr);
    HRESULT EnumCodeContextsOfPosition(ulong dwSourceContext, uint uCharacterOffset, uint uNumChars, 
                                       IEnumDebugCodeContexts* ppescc);
}

@GUID("51973c11-cb0c-11d0-b5c9-00a0244a0e7a")
interface IActiveScriptSiteDebug32 : IUnknown
{
    HRESULT GetDocumentContextFromPosition(uint dwSourceContext, uint uCharacterOffset, uint uNumChars, 
                                           IDebugDocumentContext* ppsc);
    HRESULT GetApplication(IDebugApplication32* ppda);
    HRESULT GetRootApplicationNode(IDebugApplicationNode* ppdanRoot);
    HRESULT OnScriptErrorDebug(IActiveScriptErrorDebug pErrorDebug, BOOL* pfEnterDebugger, 
                               BOOL* pfCallOnScriptErrorWhenContinuing);
}

@GUID("d6b96b0a-7463-402c-92ac-89984226942f")
interface IActiveScriptSiteDebug64 : IUnknown
{
    HRESULT GetDocumentContextFromPosition(ulong dwSourceContext, uint uCharacterOffset, uint uNumChars, 
                                           IDebugDocumentContext* ppsc);
    HRESULT GetApplication(IDebugApplication64* ppda);
    HRESULT GetRootApplicationNode(IDebugApplicationNode* ppdanRoot);
    HRESULT OnScriptErrorDebug(IActiveScriptErrorDebug pErrorDebug, BOOL* pfEnterDebugger, 
                               BOOL* pfCallOnScriptErrorWhenContinuing);
}

@GUID("bb722ccb-6ad2-41c6-b780-af9c03ee69f5")
interface IActiveScriptSiteDebugEx : IUnknown
{
    HRESULT OnCanNotJITScriptErrorDebug(IActiveScriptErrorDebug pErrorDebug, 
                                        BOOL* pfCallOnScriptErrorWhenContinuing);
}

@GUID("51973c12-cb0c-11d0-b5c9-00a0244a0e7a")
interface IActiveScriptErrorDebug : IActiveScriptError
{
    HRESULT GetDocumentContext(IDebugDocumentContext* ppssc);
    HRESULT GetStackFrame(IDebugStackFrame* ppdsf);
}

@GUID("51973c13-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugCodeContext : IUnknown
{
    HRESULT GetDocumentContext(IDebugDocumentContext* ppsc);
    HRESULT SetBreakPoint(BREAKPOINT_STATE bps);
}

@GUID("51973c14-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugExpression : IUnknown
{
    HRESULT Start(IDebugExpressionCallBack pdecb);
    HRESULT Abort();
    HRESULT QueryIsComplete();
    HRESULT GetResultAsString(HRESULT* phrResult, BSTR* pbstrResult);
    HRESULT GetResultAsDebugProperty(HRESULT* phrResult, IDebugProperty* ppdp);
}

@GUID("51973c15-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugExpressionContext : IUnknown
{
    HRESULT ParseLanguageText(const(PWSTR) pstrCode, uint nRadix, const(PWSTR) pstrDelimiter, uint dwFlags, 
                              IDebugExpression* ppe);
    HRESULT GetLanguageInfo(BSTR* pbstrLanguageName, GUID* pLanguageID);
}

@GUID("51973c16-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugExpressionCallBack : IUnknown
{
    HRESULT onComplete();
}

@GUID("51973c17-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugStackFrame : IUnknown
{
    HRESULT GetCodeContext(IDebugCodeContext* ppcc);
    HRESULT GetDescriptionString(BOOL fLong, BSTR* pbstrDescription);
    HRESULT GetLanguageString(BOOL fLong, BSTR* pbstrLanguage);
    HRESULT GetThread(IDebugApplicationThread* ppat);
    HRESULT GetDebugProperty(IDebugProperty* ppDebugProp);
}

@GUID("51973c18-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugStackFrameSniffer : IUnknown
{
    HRESULT EnumStackFrames(IEnumDebugStackFrames* ppedsf);
}

@GUID("51973c19-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugStackFrameSnifferEx32 : IDebugStackFrameSniffer
{
    HRESULT EnumStackFramesEx32(uint dwSpMin, IEnumDebugStackFrames* ppedsf);
}

@GUID("8cd12af4-49c1-4d52-8d8a-c146f47581aa")
interface IDebugStackFrameSnifferEx64 : IDebugStackFrameSniffer
{
    HRESULT EnumStackFramesEx64(ulong dwSpMin, IEnumDebugStackFrames64* ppedsf);
}

@GUID("51973c1a-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugSyncOperation : IUnknown
{
    HRESULT GetTargetThread(IDebugApplicationThread* ppatTarget);
    HRESULT Execute(IUnknown* ppunkResult);
    HRESULT InProgressAbort();
}

@GUID("51973c1b-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugAsyncOperation : IUnknown
{
    HRESULT GetSyncDebugOperation(IDebugSyncOperation* ppsdo);
    HRESULT Start(IDebugAsyncOperationCallBack padocb);
    HRESULT Abort();
    HRESULT QueryIsComplete();
    HRESULT GetResult(HRESULT* phrResult, IUnknown* ppunkResult);
}

@GUID("51973c1c-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugAsyncOperationCallBack : IUnknown
{
    HRESULT onComplete();
}

@GUID("51973c1d-cb0c-11d0-b5c9-00a0244a0e7a")
interface IEnumDebugCodeContexts : IUnknown
{
    HRESULT Next(uint celt, IDebugCodeContext* pscc, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumDebugCodeContexts* ppescc);
}

@GUID("51973c1e-cb0c-11d0-b5c9-00a0244a0e7a")
interface IEnumDebugStackFrames : IUnknown
{
    HRESULT Next(uint celt, DebugStackFrameDescriptor* prgdsfd, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumDebugStackFrames* ppedsf);
}

@GUID("0dc38853-c1b0-4176-a984-b298361027af")
interface IEnumDebugStackFrames64 : IEnumDebugStackFrames
{
    HRESULT Next64(uint celt, DebugStackFrameDescriptor64* prgdsfd, uint* pceltFetched);
}

@GUID("51973c1f-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugDocumentInfo : IUnknown
{
    HRESULT GetName(DOCUMENTNAMETYPE dnt, BSTR* pbstrName);
    HRESULT GetDocumentClassId(GUID* pclsidDocument);
}

@GUID("51973c20-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugDocumentProvider : IDebugDocumentInfo
{
    HRESULT GetDocument(IDebugDocument* ppssd);
}

@GUID("51973c21-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugDocument : IDebugDocumentInfo
{
}

@GUID("51973c22-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugDocumentText : IDebugDocument
{
    HRESULT GetDocumentAttributes(uint* ptextdocattr);
    HRESULT GetSize(uint* pcNumLines, uint* pcNumChars);
    HRESULT GetPositionOfLine(uint cLineNumber, uint* pcCharacterPosition);
    HRESULT GetLineOfPosition(uint cCharacterPosition, uint* pcLineNumber, uint* pcCharacterOffsetInLine);
    HRESULT GetText(uint cCharacterPosition, PWSTR pcharText, ushort* pstaTextAttr, uint* pcNumChars, 
                    uint cMaxChars);
    HRESULT GetPositionOfContext(IDebugDocumentContext psc, uint* pcCharacterPosition, uint* cNumChars);
    HRESULT GetContextOfPosition(uint cCharacterPosition, uint cNumChars, IDebugDocumentContext* ppsc);
}

@GUID("51973c23-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugDocumentTextEvents : IUnknown
{
    HRESULT onDestroy();
    HRESULT onInsertText(uint cCharacterPosition, uint cNumToInsert);
    HRESULT onRemoveText(uint cCharacterPosition, uint cNumToRemove);
    HRESULT onReplaceText(uint cCharacterPosition, uint cNumToReplace);
    HRESULT onUpdateTextAttributes(uint cCharacterPosition, uint cNumToUpdate);
    HRESULT onUpdateDocumentAttributes(uint textdocattr);
}

@GUID("51973c24-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugDocumentTextAuthor : IDebugDocumentText
{
    HRESULT InsertText(uint cCharacterPosition, uint cNumToInsert, PWSTR pcharText);
    HRESULT RemoveText(uint cCharacterPosition, uint cNumToRemove);
    HRESULT ReplaceText(uint cCharacterPosition, uint cNumToReplace, PWSTR pcharText);
}

@GUID("51973c25-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugDocumentTextExternalAuthor : IUnknown
{
    HRESULT GetPathName(BSTR* pbstrLongName, BOOL* pfIsOriginalFile);
    HRESULT GetFileName(BSTR* pbstrShortName);
    HRESULT NotifyChanged();
}

@GUID("51973c26-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugDocumentHelper32 : IUnknown
{
    HRESULT Init(IDebugApplication32 pda, const(PWSTR) pszShortName, const(PWSTR) pszLongName, uint docAttr);
    HRESULT Attach(IDebugDocumentHelper32 pddhParent);
    HRESULT Detach();
    HRESULT AddUnicodeText(const(PWSTR) pszText);
    HRESULT AddDBCSText(const(PSTR) pszText);
    HRESULT SetDebugDocumentHost(IDebugDocumentHost pddh);
    HRESULT AddDeferredText(uint cChars, uint dwTextStartCookie);
    HRESULT DefineScriptBlock(uint ulCharOffset, uint cChars, IActiveScript pas, BOOL fScriptlet, 
                              uint* pdwSourceContext);
    HRESULT SetDefaultTextAttr(ushort staTextAttr);
    HRESULT SetTextAttributes(uint ulCharOffset, uint cChars, ushort* pstaTextAttr);
    HRESULT SetLongName(const(PWSTR) pszLongName);
    HRESULT SetShortName(const(PWSTR) pszShortName);
    HRESULT SetDocumentAttr(uint pszAttributes);
    HRESULT GetDebugApplicationNode(IDebugApplicationNode* ppdan);
    HRESULT GetScriptBlockInfo(uint dwSourceContext, IActiveScript* ppasd, uint* piCharPos, uint* pcChars);
    HRESULT CreateDebugDocumentContext(uint iCharPos, uint cChars, IDebugDocumentContext* ppddc);
    HRESULT BringDocumentToTop();
    HRESULT BringDocumentContextToTop(IDebugDocumentContext pddc);
}

@GUID("c4c7363c-20fd-47f9-bd82-4855e0150871")
interface IDebugDocumentHelper64 : IUnknown
{
    HRESULT Init(IDebugApplication64 pda, const(PWSTR) pszShortName, const(PWSTR) pszLongName, uint docAttr);
    HRESULT Attach(IDebugDocumentHelper64 pddhParent);
    HRESULT Detach();
    HRESULT AddUnicodeText(const(PWSTR) pszText);
    HRESULT AddDBCSText(const(PSTR) pszText);
    HRESULT SetDebugDocumentHost(IDebugDocumentHost pddh);
    HRESULT AddDeferredText(uint cChars, uint dwTextStartCookie);
    HRESULT DefineScriptBlock(uint ulCharOffset, uint cChars, IActiveScript pas, BOOL fScriptlet, 
                              ulong* pdwSourceContext);
    HRESULT SetDefaultTextAttr(ushort staTextAttr);
    HRESULT SetTextAttributes(uint ulCharOffset, uint cChars, ushort* pstaTextAttr);
    HRESULT SetLongName(const(PWSTR) pszLongName);
    HRESULT SetShortName(const(PWSTR) pszShortName);
    HRESULT SetDocumentAttr(uint pszAttributes);
    HRESULT GetDebugApplicationNode(IDebugApplicationNode* ppdan);
    HRESULT GetScriptBlockInfo(ulong dwSourceContext, IActiveScript* ppasd, uint* piCharPos, uint* pcChars);
    HRESULT CreateDebugDocumentContext(uint iCharPos, uint cChars, IDebugDocumentContext* ppddc);
    HRESULT BringDocumentToTop();
    HRESULT BringDocumentContextToTop(IDebugDocumentContext pddc);
}

@GUID("51973c27-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugDocumentHost : IUnknown
{
    HRESULT GetDeferredText(uint dwTextStartCookie, PWSTR pcharText, ushort* pstaTextAttr, uint* pcNumChars, 
                            uint cMaxChars);
    HRESULT GetScriptTextAttributes(const(PWSTR) pstrCode, uint uNumCodeChars, const(PWSTR) pstrDelimiter, 
                                    uint dwFlags, ushort* pattr);
    HRESULT OnCreateDocumentContext(IUnknown* ppunkOuter);
    HRESULT GetPathName(BSTR* pbstrLongName, BOOL* pfIsOriginalFile);
    HRESULT GetFileName(BSTR* pbstrShortName);
    HRESULT NotifyChanged();
}

@GUID("51973c28-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugDocumentContext : IUnknown
{
    HRESULT GetDocument(IDebugDocument* ppsd);
    HRESULT EnumCodeContexts(IEnumDebugCodeContexts* ppescc);
}

@GUID("51973c29-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugSessionProvider : IUnknown
{
    HRESULT StartDebugSession(IRemoteDebugApplication pda);
}

@GUID("51973c2a-cb0c-11d0-b5c9-00a0244a0e7a")
interface IApplicationDebugger : IUnknown
{
    HRESULT QueryAlive();
    HRESULT CreateInstanceAtDebugger(const(GUID)* rclsid, IUnknown pUnkOuter, uint dwClsContext, const(GUID)* riid, 
                                     IUnknown* ppvObject);
    HRESULT onDebugOutput(const(PWSTR) pstr);
    HRESULT onHandleBreakPoint(IRemoteDebugApplicationThread prpt, BREAKREASON br, IActiveScriptErrorDebug pError);
    HRESULT onClose();
    HRESULT onDebuggerEvent(const(GUID)* riid, IUnknown punk);
}

@GUID("51973c2b-cb0c-11d0-b5c9-00a0244a0e7a")
interface IApplicationDebuggerUI : IUnknown
{
    HRESULT BringDocumentToTop(IDebugDocumentText pddt);
    HRESULT BringDocumentContextToTop(IDebugDocumentContext pddc);
}

@GUID("51973c2c-cb0c-11d0-b5c9-00a0244a0e7a")
interface IMachineDebugManager : IUnknown
{
    HRESULT AddApplication(IRemoteDebugApplication pda, uint* pdwAppCookie);
    HRESULT RemoveApplication(uint dwAppCookie);
    HRESULT EnumApplications(IEnumRemoteDebugApplications* ppeda);
}

@GUID("51973c2d-cb0c-11d0-b5c9-00a0244a0e7a")
interface IMachineDebugManagerCookie : IUnknown
{
    HRESULT AddApplication(IRemoteDebugApplication pda, uint dwDebugAppCookie, uint* pdwAppCookie);
    HRESULT RemoveApplication(uint dwDebugAppCookie, uint dwAppCookie);
    HRESULT EnumApplications(IEnumRemoteDebugApplications* ppeda);
}

@GUID("51973c2e-cb0c-11d0-b5c9-00a0244a0e7a")
interface IMachineDebugManagerEvents : IUnknown
{
    HRESULT onAddApplication(IRemoteDebugApplication pda, uint dwAppCookie);
    HRESULT onRemoveApplication(IRemoteDebugApplication pda, uint dwAppCookie);
}

@GUID("51973c2f-cb0c-11d0-b5c9-00a0244a0e7a")
interface IProcessDebugManager32 : IUnknown
{
    HRESULT CreateApplication(IDebugApplication32* ppda);
    HRESULT GetDefaultApplication(IDebugApplication32* ppda);
    HRESULT AddApplication(IDebugApplication32 pda, uint* pdwAppCookie);
    HRESULT RemoveApplication(uint dwAppCookie);
    HRESULT CreateDebugDocumentHelper(IUnknown punkOuter, IDebugDocumentHelper32* pddh);
}

@GUID("56b9fc1c-63a9-4cc1-ac21-087d69a17fab")
interface IProcessDebugManager64 : IUnknown
{
    HRESULT CreateApplication(IDebugApplication64* ppda);
    HRESULT GetDefaultApplication(IDebugApplication64* ppda);
    HRESULT AddApplication(IDebugApplication64 pda, uint* pdwAppCookie);
    HRESULT RemoveApplication(uint dwAppCookie);
    HRESULT CreateDebugDocumentHelper(IUnknown punkOuter, IDebugDocumentHelper64* pddh);
}

@GUID("51973c30-cb0c-11d0-b5c9-00a0244a0e7a")
interface IRemoteDebugApplication : IUnknown
{
    HRESULT ResumeFromBreakPoint(IRemoteDebugApplicationThread prptFocus, BREAKRESUMEACTION bra, 
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

@GUID("51973c32-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugApplication32 : IRemoteDebugApplication
{
    HRESULT SetName(const(PWSTR) pstrName);
    HRESULT StepOutComplete();
    HRESULT DebugOutput(const(PWSTR) pstr);
    HRESULT StartDebugSession();
    HRESULT HandleBreakPoint(BREAKREASON br, BREAKRESUMEACTION* pbra);
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
                               BREAKRESUMEACTION* pbra, ERRORRESUMEACTION* perra, BOOL* pfCallOnScriptError);
    BOOL    FCanJitDebug();
    BOOL    FIsAutoJitDebugEnabled();
    HRESULT AddGlobalExpressionContextProvider(IProvideExpressionContexts pdsfs, uint* pdwCookie);
    HRESULT RemoveGlobalExpressionContextProvider(uint dwCookie);
}

@GUID("4dedc754-04c7-4f10-9e60-16a390fe6e62")
interface IDebugApplication64 : IRemoteDebugApplication
{
    HRESULT SetName(const(PWSTR) pstrName);
    HRESULT StepOutComplete();
    HRESULT DebugOutput(const(PWSTR) pstr);
    HRESULT StartDebugSession();
    HRESULT HandleBreakPoint(BREAKREASON br, BREAKRESUMEACTION* pbra);
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
                               BREAKRESUMEACTION* pbra, ERRORRESUMEACTION* perra, BOOL* pfCallOnScriptError);
    BOOL    FCanJitDebug();
    BOOL    FIsAutoJitDebugEnabled();
    HRESULT AddGlobalExpressionContextProvider(IProvideExpressionContexts pdsfs, ulong* pdwCookie);
    HRESULT RemoveGlobalExpressionContextProvider(ulong dwCookie);
}

@GUID("51973c33-cb0c-11d0-b5c9-00a0244a0e7a")
interface IRemoteDebugApplicationEvents : IUnknown
{
    HRESULT OnConnectDebugger(IApplicationDebugger pad);
    HRESULT OnDisconnectDebugger();
    HRESULT OnSetName(const(PWSTR) pstrName);
    HRESULT OnDebugOutput(const(PWSTR) pstr);
    HRESULT OnClose();
    HRESULT OnEnterBreakPoint(IRemoteDebugApplicationThread prdat);
    HRESULT OnLeaveBreakPoint(IRemoteDebugApplicationThread prdat);
    HRESULT OnCreateThread(IRemoteDebugApplicationThread prdat);
    HRESULT OnDestroyThread(IRemoteDebugApplicationThread prdat);
    HRESULT OnBreakFlagChange(uint abf, IRemoteDebugApplicationThread prdatSteppingThread);
}

@GUID("51973c34-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugApplicationNode : IDebugDocumentProvider
{
    HRESULT EnumChildren(IEnumDebugApplicationNodes* pperddp);
    HRESULT GetParent(IDebugApplicationNode* pprddp);
    HRESULT SetDocumentProvider(IDebugDocumentProvider pddp);
    HRESULT Close();
    HRESULT Attach(IDebugApplicationNode pdanParent);
    HRESULT Detach();
}

@GUID("51973c35-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugApplicationNodeEvents : IUnknown
{
    HRESULT onAddChild(IDebugApplicationNode prddpChild);
    HRESULT onRemoveChild(IDebugApplicationNode prddpChild);
    HRESULT onDetach();
    HRESULT onAttach(IDebugApplicationNode prddpParent);
}

@GUID("a2e3aa3b-aa8d-4ebf-84cd-648b737b8c13")
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

@GUID("51973c36-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugThreadCall32 : IUnknown
{
    HRESULT ThreadCallHandler(uint dwParam1, uint dwParam2, uint dwParam3);
}

@GUID("cb3fa335-e979-42fd-9fcf-a7546a0f3905")
interface IDebugThreadCall64 : IUnknown
{
    HRESULT ThreadCallHandler(ulong dwParam1, ulong dwParam2, ulong dwParam3);
}

@GUID("51973c37-cb0c-11d0-b5c9-00a0244a0e7a")
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

@GUID("51973c38-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugApplicationThread : IRemoteDebugApplicationThread
{
    HRESULT SynchronousCallIntoThread32(IDebugThreadCall32 pstcb, uint dwParam1, uint dwParam2, uint dwParam3);
    HRESULT QueryIsCurrentThread();
    HRESULT QueryIsDebuggerThread();
    HRESULT SetDescription(const(PWSTR) pstrDescription);
    HRESULT SetStateString(const(PWSTR) pstrState);
}

@GUID("9dac5886-dbad-456d-9dee-5dec39ab3dda")
interface IDebugApplicationThread64 : IDebugApplicationThread
{
    HRESULT SynchronousCallIntoThread64(IDebugThreadCall64 pstcb, ulong dwParam1, ulong dwParam2, ulong dwParam3);
}

@GUID("51973c39-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugCookie : IUnknown
{
    HRESULT SetDebugCookie(uint dwDebugAppCookie);
}

@GUID("51973c3a-cb0c-11d0-b5c9-00a0244a0e7a")
interface IEnumDebugApplicationNodes : IUnknown
{
    HRESULT Next(uint celt, IDebugApplicationNode* pprddp, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumDebugApplicationNodes* pperddp);
}

@GUID("51973c3b-cb0c-11d0-b5c9-00a0244a0e7a")
interface IEnumRemoteDebugApplications : IUnknown
{
    HRESULT Next(uint celt, IRemoteDebugApplication* ppda, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumRemoteDebugApplications* ppessd);
}

@GUID("51973c3c-cb0c-11d0-b5c9-00a0244a0e7a")
interface IEnumRemoteDebugApplicationThreads : IUnknown
{
    HRESULT Next(uint celt, IRemoteDebugApplicationThread* pprdat, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumRemoteDebugApplicationThreads* pperdat);
}

@GUID("51973c05-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugFormatter : IUnknown
{
    HRESULT GetStringForVariant(VARIANT* pvar, uint nRadix, BSTR* pbstrValue);
    HRESULT GetVariantForString(const(PWSTR) pwstrValue, VARIANT* pvar);
    HRESULT GetStringForVarType(VARENUM vt, TYPEDESC* ptdescArrayType, BSTR* pbstr);
}

@GUID("51973c3e-cb0c-11d0-b5c9-00a0244a0e7a")
interface ISimpleConnectionPoint : IUnknown
{
    HRESULT GetEventCount(uint* pulCount);
    HRESULT DescribeEvents(uint iEvent, uint cEvents, int* prgid, BSTR* prgbstr, uint* pcEventsFetched);
    HRESULT Advise(IDispatch pdisp, uint* pdwCookie);
    HRESULT Unadvise(uint dwCookie);
}

@GUID("51973c3f-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugHelper : IUnknown
{
    HRESULT CreatePropertyBrowser(VARIANT* pvar, const(PWSTR) bstrName, IDebugApplicationThread pdat, 
                                  IDebugProperty* ppdob);
    HRESULT CreatePropertyBrowserEx(VARIANT* pvar, const(PWSTR) bstrName, IDebugApplicationThread pdat, 
                                    IDebugFormatter pdf, IDebugProperty* ppdob);
    HRESULT CreateSimpleConnectionPoint(IDispatch pdisp, ISimpleConnectionPoint* ppscp);
}

@GUID("51973c40-cb0c-11d0-b5c9-00a0244a0e7a")
interface IEnumDebugExpressionContexts : IUnknown
{
    HRESULT Next(uint celt, IDebugExpressionContext* ppdec, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumDebugExpressionContexts* ppedec);
}

@GUID("51973c41-cb0c-11d0-b5c9-00a0244a0e7a")
interface IProvideExpressionContexts : IUnknown
{
    HRESULT EnumExpressionContexts(IEnumDebugExpressionContexts* ppedec);
}

@GUID("784b5ff0-69b0-47d1-a7dc-2518f4230e90")
interface IActiveScriptProfilerControl : IUnknown
{
    HRESULT StartProfiling(const(GUID)* clsidProfilerObject, uint dwEventMask, uint dwContext);
    HRESULT SetProfilerEventMask(uint dwEventMask);
    HRESULT StopProfiling(HRESULT hrShutdownReason);
}

@GUID("47810165-498f-40be-94f1-653557e9e7da")
interface IActiveScriptProfilerControl2 : IActiveScriptProfilerControl
{
    HRESULT CompleteProfilerStart();
    HRESULT PrepareProfilerStop();
}

@GUID("32e4694e-0d37-419b-b93d-fa20ded6e8ea")
interface IActiveScriptProfilerHeapEnum : IUnknown
{
    HRESULT Next(uint celt, PROFILER_HEAP_OBJECT** heapObjects, uint* pceltFetched);
    HRESULT GetOptionalInfo(PROFILER_HEAP_OBJECT* heapObject, uint celt, 
                            PROFILER_HEAP_OBJECT_OPTIONAL_INFO* optionalInfo);
    HRESULT FreeObjectAndOptionalInfo(uint celt, PROFILER_HEAP_OBJECT** heapObjects);
    HRESULT GetNameIdMap(const(PWSTR)*** pNameList, uint* pcelt);
}

@GUID("0b403015-f381-4023-a5d0-6fed076de716")
interface IActiveScriptProfilerControl3 : IActiveScriptProfilerControl2
{
    HRESULT EnumHeap(IActiveScriptProfilerHeapEnum* ppEnum);
}

@GUID("160f94fd-9dbc-40d4-9eac-2b71db3132f4")
interface IActiveScriptProfilerControl4 : IActiveScriptProfilerControl3
{
    HRESULT SummarizeHeap(PROFILER_HEAP_SUMMARY* heapSummary);
}

@GUID("1c01a2d1-8f0f-46a5-9720-0d7ed2c62f0a")
interface IActiveScriptProfilerControl5 : IActiveScriptProfilerControl4
{
    HRESULT EnumHeap2(PROFILER_HEAP_ENUM_FLAGS enumFlags, IActiveScriptProfilerHeapEnum* ppEnum);
}

@GUID("740eca23-7d9d-42e5-ba9d-f8b24b1c7a9b")
interface IActiveScriptProfilerCallback : IUnknown
{
    HRESULT Initialize(uint dwContext);
    HRESULT Shutdown(HRESULT hrReason);
    HRESULT ScriptCompiled(int scriptId, PROFILER_SCRIPT_TYPE type, IUnknown pIDebugDocumentContext);
    HRESULT FunctionCompiled(int functionId, int scriptId, const(PWSTR) pwszFunctionName, 
                             const(PWSTR) pwszFunctionNameHint, IUnknown pIDebugDocumentContext);
    HRESULT OnFunctionEnter(int scriptId, int functionId);
    HRESULT OnFunctionExit(int scriptId, int functionId);
}

@GUID("31b7f8ad-a637-409c-b22f-040995b6103d")
interface IActiveScriptProfilerCallback2 : IActiveScriptProfilerCallback
{
    HRESULT OnFunctionEnterByName(const(PWSTR) pwszFunctionName, PROFILER_SCRIPT_TYPE type);
    HRESULT OnFunctionExitByName(const(PWSTR) pwszFunctionName, PROFILER_SCRIPT_TYPE type);
}

@GUID("6ac5ad25-2037-4687-91df-b59979d93d73")
interface IActiveScriptProfilerCallback3 : IActiveScriptProfilerCallback2
{
    HRESULT SetWebWorkerId(uint webWorkerId);
}

@GUID("0aee2a94-bcbb-11d0-8c72-00c04fc2b085")
interface IScriptNode : IUnknown
{
    HRESULT Alive();
    HRESULT Delete();
    HRESULT GetParent(IScriptNode* ppsnParent);
    HRESULT GetIndexInParent(uint* pisn);
    HRESULT GetCookie(uint* pdwCookie);
    HRESULT GetNumberOfChildren(uint* pcsn);
    HRESULT GetChild(uint isn, IScriptNode* ppsn);
    HRESULT GetLanguage(BSTR* pbstr);
    HRESULT CreateChildEntry(uint isn, uint dwCookie, const(PWSTR) pszDelimiter, IScriptEntry* ppse);
    HRESULT CreateChildHandler(const(PWSTR) pszDefaultName, PWSTR* prgpszNames, uint cpszNames, 
                               const(PWSTR) pszEvent, const(PWSTR) pszDelimiter, ITypeInfo ptiSignature, 
                               uint iMethodSignature, uint isn, uint dwCookie, IScriptEntry* ppse);
}

@GUID("0aee2a95-bcbb-11d0-8c72-00c04fc2b085")
interface IScriptEntry : IScriptNode
{
    HRESULT GetText(BSTR* pbstr);
    HRESULT SetText(const(PWSTR) psz);
    HRESULT GetBody(BSTR* pbstr);
    HRESULT SetBody(const(PWSTR) psz);
    HRESULT GetName(BSTR* pbstr);
    HRESULT SetName(const(PWSTR) psz);
    HRESULT GetItemName(BSTR* pbstr);
    HRESULT SetItemName(const(PWSTR) psz);
    HRESULT GetSignature(ITypeInfo* ppti, uint* piMethod);
    HRESULT SetSignature(ITypeInfo pti, uint iMethod);
    HRESULT GetRange(uint* pichMin, uint* pcch);
}

@GUID("0aee2a96-bcbb-11d0-8c72-00c04fc2b085")
interface IScriptScriptlet : IScriptEntry
{
    HRESULT GetSubItemName(BSTR* pbstr);
    HRESULT SetSubItemName(const(PWSTR) psz);
    HRESULT GetEventName(BSTR* pbstr);
    HRESULT SetEventName(const(PWSTR) psz);
    HRESULT GetSimpleEventName(BSTR* pbstr);
    HRESULT SetSimpleEventName(const(PWSTR) psz);
}

@GUID("9c109da0-7006-11d1-b36c-00a0c911e8b2")
interface IActiveScriptAuthor : IUnknown
{
    HRESULT AddNamedItem(const(PWSTR) pszName, uint dwFlags, IDispatch pdisp);
    HRESULT AddScriptlet(const(PWSTR) pszDefaultName, const(PWSTR) pszCode, const(PWSTR) pszItemName, 
                         const(PWSTR) pszSubItemName, const(PWSTR) pszEventName, const(PWSTR) pszDelimiter, 
                         uint dwCookie, uint dwFlags);
    HRESULT ParseScriptText(const(PWSTR) pszCode, const(PWSTR) pszItemName, const(PWSTR) pszDelimiter, 
                            uint dwCookie, uint dwFlags);
    HRESULT GetScriptTextAttributes(const(PWSTR) pszCode, uint cch, const(PWSTR) pszDelimiter, uint dwFlags, 
                                    ushort* pattr);
    HRESULT GetScriptletTextAttributes(const(PWSTR) pszCode, uint cch, const(PWSTR) pszDelimiter, uint dwFlags, 
                                       ushort* pattr);
    HRESULT GetRoot(IScriptNode* ppsp);
    HRESULT GetLanguageFlags(uint* pgrfasa);
    HRESULT GetEventHandler(IDispatch pdisp, const(PWSTR) pszItem, const(PWSTR) pszSubItem, const(PWSTR) pszEvent, 
                            IScriptEntry* ppse);
    HRESULT RemoveNamedItem(const(PWSTR) pszName);
    HRESULT AddTypeLib(const(GUID)* rguidTypeLib, uint dwMajor, uint dwMinor, uint dwFlags);
    HRESULT RemoveTypeLib(const(GUID)* rguidTypeLib, uint dwMajor, uint dwMinor);
    HRESULT GetChars(uint fRequestedList, BSTR* pbstrChars);
    HRESULT GetInfoFromContext(const(PWSTR) pszCode, uint cchCode, uint ichCurrentPosition, 
                               uint dwListTypesRequested, uint* pdwListTypesProvided, uint* pichListAnchorPosition, 
                               uint* pichFuncAnchorPosition, int* pmemid, int* piCurrentParameter, IUnknown* ppunk);
    HRESULT IsCommitChar(wchar ch, BOOL* pfcommit);
}

@GUID("7e2d4b70-bd9a-11d0-9336-00a0c90dcaa9")
interface IActiveScriptAuthorProcedure : IUnknown
{
    HRESULT ParseProcedureText(const(PWSTR) pszCode, const(PWSTR) pszFormalParams, const(PWSTR) pszProcedureName, 
                               const(PWSTR) pszItemName, const(PWSTR) pszDelimiter, uint dwCookie, uint dwFlags, 
                               IDispatch pdispFor);
}

@GUID("90a7734e-841b-4f77-9384-a2891e76e7e2")
interface IDebugApplicationNode100 : IUnknown
{
    HRESULT SetFilterForEventSink(uint dwCookie, APPLICATION_NODE_EVENT_FILTER filter);
    HRESULT GetExcludedDocuments(APPLICATION_NODE_EVENT_FILTER filter, TEXT_DOCUMENT_ARRAY* pDocuments);
    HRESULT QueryIsChildNode(IDebugDocument pSearchKey);
}

@GUID("379bfbe1-c6c9-432a-93e1-6d17656c538c")
interface IWebAppDiagnosticsSetup : IUnknown
{
    HRESULT DiagnosticsSupported(VARIANT_BOOL* pRetVal);
    HRESULT CreateObjectWithSiteAtWebApp(const(GUID)* rclsid, uint dwClsContext, const(GUID)* riid, 
                                         size_t hPassToObject);
}

@GUID("d5fe005b-2836-485e-b1f9-89d91aa24fd4")
interface IRemoteDebugApplication110 : IUnknown
{
    HRESULT SetDebuggerOptions(SCRIPT_DEBUGGER_OPTIONS mask, SCRIPT_DEBUGGER_OPTIONS value);
    HRESULT GetCurrentDebuggerOptions(SCRIPT_DEBUGGER_OPTIONS* pCurrentOptions);
    HRESULT GetMainThread(IRemoteDebugApplicationThread* ppThread);
}

@GUID("bdb3b5de-89f2-4e11-84a5-97445f941c7d")
interface IDebugApplication11032 : IRemoteDebugApplication110
{
    HRESULT SynchronousCallInMainThread(IDebugThreadCall32 pptc, size_t dwParam1, size_t dwParam2, size_t dwParam3);
    HRESULT AsynchronousCallInMainThread(IDebugThreadCall32 pptc, size_t dwParam1, size_t dwParam2, 
                                         size_t dwParam3);
    HRESULT CallableWaitForHandles(uint handleCount, const(HANDLE)* pHandles, uint* pIndex);
}

@GUID("2039d958-4eeb-496a-87bb-2e5201eadeef")
interface IDebugApplication11064 : IRemoteDebugApplication110
{
    HRESULT SynchronousCallInMainThread(IDebugThreadCall64 pptc, size_t dwParam1, size_t dwParam2, size_t dwParam3);
    HRESULT AsynchronousCallInMainThread(IDebugThreadCall64 pptc, size_t dwParam1, size_t dwParam2, 
                                         size_t dwParam3);
    HRESULT CallableWaitForHandles(uint handleCount, const(HANDLE)* pHandles, uint* pIndex);
}

@GUID("16ff3a42-a5f5-432b-b625-8e8e16f57e15")
interface IWebAppDiagnosticsObjectInitialization : IUnknown
{
    HRESULT Initialize(HANDLE_PTR hPassedHandle, IUnknown pDebugApplication);
}

@GUID("73a3f82a-0fe9-4b33-ba3b-fe095f697e0a")
interface IActiveScriptWinRTErrorDebug : IActiveScriptError
{
    HRESULT GetRestrictedErrorString(BSTR* errorString);
    HRESULT GetRestrictedErrorReference(BSTR* referenceString);
    HRESULT GetCapabilitySid(BSTR* capabilitySid);
}

@GUID("516e42b6-89a8-4530-937b-5f0708431442")
interface IActiveScriptErrorDebug110 : IUnknown
{
    HRESULT GetExceptionThrownKind(SCRIPT_ERROR_DEBUG_EXCEPTION_THROWN_KIND* pExceptionKind);
}

@GUID("84e5e468-d5da-48a8-83f4-40366429007b")
interface IDebugApplicationThreadEvents110 : IUnknown
{
    HRESULT OnSuspendForBreakPoint();
    HRESULT OnResumeFromBreakPoint();
    HRESULT OnThreadRequestComplete();
    HRESULT OnBeginThreadRequest();
}

@GUID("2194ac5c-6561-404a-a2e9-f57d72de3702")
interface IDebugApplicationThread11032 : IUnknown
{
    HRESULT GetActiveThreadRequestCount(uint* puiThreadRequests);
    HRESULT IsSuspendedForBreakPoint(BOOL* pfIsSuspended);
    HRESULT IsThreadCallable(BOOL* pfIsCallable);
    HRESULT AsynchronousCallIntoThread(IDebugThreadCall32 pptc, size_t dwParam1, size_t dwParam2, size_t dwParam3);
}

@GUID("420aa4cc-efd8-4dac-983b-47127826917d")
interface IDebugApplicationThread11064 : IUnknown
{
    HRESULT GetActiveThreadRequestCount(uint* puiThreadRequests);
    HRESULT IsSuspendedForBreakPoint(BOOL* pfIsSuspended);
    HRESULT IsThreadCallable(BOOL* pfIsCallable);
    HRESULT AsynchronousCallIntoThread(IDebugThreadCall64 pptc, size_t dwParam1, size_t dwParam2, size_t dwParam3);
}

@GUID("2f69c611-6b14-47e8-9260-4bb7c52f504b")
interface IRemoteDebugCriticalErrorEvent110 : IUnknown
{
    HRESULT GetErrorInfo(BSTR* pbstrSource, int* pMessageId, BSTR* pbstrMessage, IDebugDocumentContext* ppLocation);
}

@GUID("5d7741b7-af7e-4a2a-85e5-c77f4d0659fb")
interface IScriptInvocationContext : IUnknown
{
    HRESULT GetContextType(SCRIPT_INVOCATION_CONTEXT_TYPE* pInvocationContextType);
    HRESULT GetContextDescription(BSTR* pDescription);
    HRESULT GetContextObject(IUnknown* ppContextObject);
}

@GUID("4b509611-b6ea-4b24-adcb-d0ccfd1a7e33")
interface IDebugStackFrame110 : IDebugStackFrame
{
    HRESULT GetStackFrameType(DEBUG_STACKFRAME_TYPE* pStackFrameKind);
    HRESULT GetScriptInvocationContext(IScriptInvocationContext* ppInvocationContext);
}

@GUID("9ff56bb6-eb89-4c0f-8823-cc2a4c0b7f26")
interface IRemoteDebugInfoEvent110 : IUnknown
{
    HRESULT GetEventInfo(DEBUG_EVENT_INFO_TYPE* pMessageType, BSTR* pbstrMessage, BSTR* pbstrUrl, 
                         IDebugDocumentContext* ppLocation);
}

@GUID("be0e89da-2ac5-4c04-ac5e-59956aae3613")
interface IJsDebug : IUnknown
{
    HRESULT OpenVirtualProcess(uint processId, ulong runtimeJsBaseAddress, IJsDebugDataTarget pDataTarget, 
                               IJsDebugProcess* ppProcess);
}

@GUID("3d587168-6a2d-4041-bd3b-0de674502862")
interface IJsDebugProcess : IUnknown
{
    HRESULT CreateStackWalker(uint threadId, IJsDebugStackWalker* ppStackWalker);
    HRESULT CreateBreakPoint(ulong documentId, uint characterOffset, uint characterCount, BOOL isEnabled, 
                             IJsDebugBreakPoint* ppDebugBreakPoint);
    HRESULT PerformAsyncBreak(uint threadId);
    HRESULT GetExternalStepAddress(ulong* pCodeAddress);
}

@GUID("db24b094-73c4-456c-a4ec-e90ea00bdfe3")
interface IJsDebugStackWalker : IUnknown
{
    HRESULT GetNext(IJsDebugFrame* ppFrame);
}

@GUID("c9196637-ab9d-44b2-bad2-13b95b3f390e")
interface IJsDebugFrame : IUnknown
{
    HRESULT GetStackRange(ulong* pStart, ulong* pEnd);
    HRESULT GetName(BSTR* pName);
    HRESULT GetDocumentPositionWithId(ulong* pDocumentId, uint* pCharacterOffset, uint* pStatementCharCount);
    HRESULT GetDocumentPositionWithName(BSTR* pDocumentName, uint* pLine, uint* pColumn);
    HRESULT GetDebugProperty(IJsDebugProperty* ppDebugProperty);
    HRESULT GetReturnAddress(ulong* pReturnAddress);
    HRESULT Evaluate(const(PWSTR) pExpressionText, IJsDebugProperty* ppDebugProperty, BSTR* pError);
}

@GUID("f8ffcf2b-3aa4-4320-85c3-52a312ba9633")
interface IJsDebugProperty : IUnknown
{
    HRESULT GetPropertyInfo(uint nRadix, JsDebugPropertyInfo* pPropertyInfo);
    HRESULT GetMembers(JS_PROPERTY_MEMBERS members, IJsEnumDebugProperty* ppEnum);
}

@GUID("4092432f-2f0f-4fe1-b638-5b74a52cdcbe")
interface IJsEnumDebugProperty : IUnknown
{
    HRESULT Next(uint count, IJsDebugProperty* ppDebugProperty, uint* pActualCount);
    HRESULT GetCount(uint* pCount);
}

@GUID("df6773e3-ed8d-488b-8a3e-5812577d1542")
interface IJsDebugBreakPoint : IUnknown
{
    HRESULT IsEnabled(BOOL* pIsEnabled);
    HRESULT Enable();
    HRESULT Disable();
    HRESULT Delete();
    HRESULT GetDocumentPosition(ulong* pDocumentId, uint* pCharacterOffset, uint* pStatementCharCount);
}

@GUID("5e7da34b-fb51-4791-abe7-cb5bdf419755")
interface IEnumJsStackFrames : IUnknown
{
    HRESULT Next(uint cFrameCount, JS_NATIVE_FRAME* pFrames, uint* pcFetched);
    HRESULT Reset();
}

@GUID("53b28977-53a1-48e5-9000-5d0dfa893931")
interface IJsDebugDataTarget : IUnknown
{
    HRESULT ReadMemory(ulong address, JsDebugReadMemoryFlags flags, ubyte* pBuffer, uint size, uint* pBytesRead);
    HRESULT WriteMemory(ulong address, ubyte* pMemory, uint size);
    HRESULT AllocateVirtualMemory(ulong address, uint size, uint allocationType, uint pageProtection, 
                                  ulong* pAllocatedAddress);
    HRESULT FreeVirtualMemory(ulong address, uint size, uint freeType);
    HRESULT GetTlsValue(uint threadId, uint tlsIndex, ulong* pValue);
    HRESULT ReadBSTR(ulong address, BSTR* pString);
    HRESULT ReadNullTerminatedString(ulong address, ushort characterSize, uint maxCharacters, BSTR* pString);
    HRESULT CreateStackFrameEnumerator(uint threadId, IEnumJsStackFrames* ppEnumerator);
    HRESULT GetThreadContext(uint threadId, uint contextFlags, uint contextSize, void* pContext);
}


// GUIDs

const GUID CLSID_CDebugDocumentHelper        = GUIDOF!CDebugDocumentHelper;
const GUID CLSID_DebugHelper                 = GUIDOF!DebugHelper;
const GUID CLSID_DefaultDebugSessionProvider = GUIDOF!DefaultDebugSessionProvider;
const GUID CLSID_MachineDebugManager_DEBUG   = GUIDOF!MachineDebugManager_DEBUG;
const GUID CLSID_MachineDebugManager_RETAIL  = GUIDOF!MachineDebugManager_RETAIL;
const GUID CLSID_ProcessDebugManager         = GUIDOF!ProcessDebugManager;

const GUID IID_AsyncIDebugApplicationNodeEvents       = GUIDOF!AsyncIDebugApplicationNodeEvents;
const GUID IID_IActiveScript                          = GUIDOF!IActiveScript;
const GUID IID_IActiveScriptAuthor                    = GUIDOF!IActiveScriptAuthor;
const GUID IID_IActiveScriptAuthorProcedure           = GUIDOF!IActiveScriptAuthorProcedure;
const GUID IID_IActiveScriptDebug32                   = GUIDOF!IActiveScriptDebug32;
const GUID IID_IActiveScriptDebug64                   = GUIDOF!IActiveScriptDebug64;
const GUID IID_IActiveScriptEncode                    = GUIDOF!IActiveScriptEncode;
const GUID IID_IActiveScriptError                     = GUIDOF!IActiveScriptError;
const GUID IID_IActiveScriptError64                   = GUIDOF!IActiveScriptError64;
const GUID IID_IActiveScriptErrorDebug                = GUIDOF!IActiveScriptErrorDebug;
const GUID IID_IActiveScriptErrorDebug110             = GUIDOF!IActiveScriptErrorDebug110;
const GUID IID_IActiveScriptGarbageCollector          = GUIDOF!IActiveScriptGarbageCollector;
const GUID IID_IActiveScriptHostEncode                = GUIDOF!IActiveScriptHostEncode;
const GUID IID_IActiveScriptParse32                   = GUIDOF!IActiveScriptParse32;
const GUID IID_IActiveScriptParse64                   = GUIDOF!IActiveScriptParse64;
const GUID IID_IActiveScriptParseProcedure2_32        = GUIDOF!IActiveScriptParseProcedure2_32;
const GUID IID_IActiveScriptParseProcedure2_64        = GUIDOF!IActiveScriptParseProcedure2_64;
const GUID IID_IActiveScriptParseProcedure32          = GUIDOF!IActiveScriptParseProcedure32;
const GUID IID_IActiveScriptParseProcedure64          = GUIDOF!IActiveScriptParseProcedure64;
const GUID IID_IActiveScriptParseProcedureOld32       = GUIDOF!IActiveScriptParseProcedureOld32;
const GUID IID_IActiveScriptParseProcedureOld64       = GUIDOF!IActiveScriptParseProcedureOld64;
const GUID IID_IActiveScriptProfilerCallback          = GUIDOF!IActiveScriptProfilerCallback;
const GUID IID_IActiveScriptProfilerCallback2         = GUIDOF!IActiveScriptProfilerCallback2;
const GUID IID_IActiveScriptProfilerCallback3         = GUIDOF!IActiveScriptProfilerCallback3;
const GUID IID_IActiveScriptProfilerControl           = GUIDOF!IActiveScriptProfilerControl;
const GUID IID_IActiveScriptProfilerControl2          = GUIDOF!IActiveScriptProfilerControl2;
const GUID IID_IActiveScriptProfilerControl3          = GUIDOF!IActiveScriptProfilerControl3;
const GUID IID_IActiveScriptProfilerControl4          = GUIDOF!IActiveScriptProfilerControl4;
const GUID IID_IActiveScriptProfilerControl5          = GUIDOF!IActiveScriptProfilerControl5;
const GUID IID_IActiveScriptProfilerHeapEnum          = GUIDOF!IActiveScriptProfilerHeapEnum;
const GUID IID_IActiveScriptProperty                  = GUIDOF!IActiveScriptProperty;
const GUID IID_IActiveScriptSIPInfo                   = GUIDOF!IActiveScriptSIPInfo;
const GUID IID_IActiveScriptSite                      = GUIDOF!IActiveScriptSite;
const GUID IID_IActiveScriptSiteDebug32               = GUIDOF!IActiveScriptSiteDebug32;
const GUID IID_IActiveScriptSiteDebug64               = GUIDOF!IActiveScriptSiteDebug64;
const GUID IID_IActiveScriptSiteDebugEx               = GUIDOF!IActiveScriptSiteDebugEx;
const GUID IID_IActiveScriptSiteInterruptPoll         = GUIDOF!IActiveScriptSiteInterruptPoll;
const GUID IID_IActiveScriptSiteTraceInfo             = GUIDOF!IActiveScriptSiteTraceInfo;
const GUID IID_IActiveScriptSiteUIControl             = GUIDOF!IActiveScriptSiteUIControl;
const GUID IID_IActiveScriptSiteWindow                = GUIDOF!IActiveScriptSiteWindow;
const GUID IID_IActiveScriptStats                     = GUIDOF!IActiveScriptStats;
const GUID IID_IActiveScriptStringCompare             = GUIDOF!IActiveScriptStringCompare;
const GUID IID_IActiveScriptTraceInfo                 = GUIDOF!IActiveScriptTraceInfo;
const GUID IID_IActiveScriptWinRTErrorDebug           = GUIDOF!IActiveScriptWinRTErrorDebug;
const GUID IID_IApplicationDebugger                   = GUIDOF!IApplicationDebugger;
const GUID IID_IApplicationDebuggerUI                 = GUIDOF!IApplicationDebuggerUI;
const GUID IID_IBindEventHandler                      = GUIDOF!IBindEventHandler;
const GUID IID_IDebugApplication11032                 = GUIDOF!IDebugApplication11032;
const GUID IID_IDebugApplication11064                 = GUIDOF!IDebugApplication11064;
const GUID IID_IDebugApplication32                    = GUIDOF!IDebugApplication32;
const GUID IID_IDebugApplication64                    = GUIDOF!IDebugApplication64;
const GUID IID_IDebugApplicationNode                  = GUIDOF!IDebugApplicationNode;
const GUID IID_IDebugApplicationNode100               = GUIDOF!IDebugApplicationNode100;
const GUID IID_IDebugApplicationNodeEvents            = GUIDOF!IDebugApplicationNodeEvents;
const GUID IID_IDebugApplicationThread                = GUIDOF!IDebugApplicationThread;
const GUID IID_IDebugApplicationThread11032           = GUIDOF!IDebugApplicationThread11032;
const GUID IID_IDebugApplicationThread11064           = GUIDOF!IDebugApplicationThread11064;
const GUID IID_IDebugApplicationThread64              = GUIDOF!IDebugApplicationThread64;
const GUID IID_IDebugApplicationThreadEvents110       = GUIDOF!IDebugApplicationThreadEvents110;
const GUID IID_IDebugAsyncOperation                   = GUIDOF!IDebugAsyncOperation;
const GUID IID_IDebugAsyncOperationCallBack           = GUIDOF!IDebugAsyncOperationCallBack;
const GUID IID_IDebugCodeContext                      = GUIDOF!IDebugCodeContext;
const GUID IID_IDebugCookie                           = GUIDOF!IDebugCookie;
const GUID IID_IDebugDocument                         = GUIDOF!IDebugDocument;
const GUID IID_IDebugDocumentContext                  = GUIDOF!IDebugDocumentContext;
const GUID IID_IDebugDocumentHelper32                 = GUIDOF!IDebugDocumentHelper32;
const GUID IID_IDebugDocumentHelper64                 = GUIDOF!IDebugDocumentHelper64;
const GUID IID_IDebugDocumentHost                     = GUIDOF!IDebugDocumentHost;
const GUID IID_IDebugDocumentInfo                     = GUIDOF!IDebugDocumentInfo;
const GUID IID_IDebugDocumentProvider                 = GUIDOF!IDebugDocumentProvider;
const GUID IID_IDebugDocumentText                     = GUIDOF!IDebugDocumentText;
const GUID IID_IDebugDocumentTextAuthor               = GUIDOF!IDebugDocumentTextAuthor;
const GUID IID_IDebugDocumentTextEvents               = GUIDOF!IDebugDocumentTextEvents;
const GUID IID_IDebugDocumentTextExternalAuthor       = GUIDOF!IDebugDocumentTextExternalAuthor;
const GUID IID_IDebugExpression                       = GUIDOF!IDebugExpression;
const GUID IID_IDebugExpressionCallBack               = GUIDOF!IDebugExpressionCallBack;
const GUID IID_IDebugExpressionContext                = GUIDOF!IDebugExpressionContext;
const GUID IID_IDebugFormatter                        = GUIDOF!IDebugFormatter;
const GUID IID_IDebugHelper                           = GUIDOF!IDebugHelper;
const GUID IID_IDebugSessionProvider                  = GUIDOF!IDebugSessionProvider;
const GUID IID_IDebugStackFrame                       = GUIDOF!IDebugStackFrame;
const GUID IID_IDebugStackFrame110                    = GUIDOF!IDebugStackFrame110;
const GUID IID_IDebugStackFrameSniffer                = GUIDOF!IDebugStackFrameSniffer;
const GUID IID_IDebugStackFrameSnifferEx32            = GUIDOF!IDebugStackFrameSnifferEx32;
const GUID IID_IDebugStackFrameSnifferEx64            = GUIDOF!IDebugStackFrameSnifferEx64;
const GUID IID_IDebugSyncOperation                    = GUIDOF!IDebugSyncOperation;
const GUID IID_IDebugThreadCall32                     = GUIDOF!IDebugThreadCall32;
const GUID IID_IDebugThreadCall64                     = GUIDOF!IDebugThreadCall64;
const GUID IID_IEnumDebugApplicationNodes             = GUIDOF!IEnumDebugApplicationNodes;
const GUID IID_IEnumDebugCodeContexts                 = GUIDOF!IEnumDebugCodeContexts;
const GUID IID_IEnumDebugExpressionContexts           = GUIDOF!IEnumDebugExpressionContexts;
const GUID IID_IEnumDebugStackFrames                  = GUIDOF!IEnumDebugStackFrames;
const GUID IID_IEnumDebugStackFrames64                = GUIDOF!IEnumDebugStackFrames64;
const GUID IID_IEnumJsStackFrames                     = GUIDOF!IEnumJsStackFrames;
const GUID IID_IEnumRemoteDebugApplicationThreads     = GUIDOF!IEnumRemoteDebugApplicationThreads;
const GUID IID_IEnumRemoteDebugApplications           = GUIDOF!IEnumRemoteDebugApplications;
const GUID IID_IJsDebug                               = GUIDOF!IJsDebug;
const GUID IID_IJsDebugBreakPoint                     = GUIDOF!IJsDebugBreakPoint;
const GUID IID_IJsDebugDataTarget                     = GUIDOF!IJsDebugDataTarget;
const GUID IID_IJsDebugFrame                          = GUIDOF!IJsDebugFrame;
const GUID IID_IJsDebugProcess                        = GUIDOF!IJsDebugProcess;
const GUID IID_IJsDebugProperty                       = GUIDOF!IJsDebugProperty;
const GUID IID_IJsDebugStackWalker                    = GUIDOF!IJsDebugStackWalker;
const GUID IID_IJsEnumDebugProperty                   = GUIDOF!IJsEnumDebugProperty;
const GUID IID_IMachineDebugManager                   = GUIDOF!IMachineDebugManager;
const GUID IID_IMachineDebugManagerCookie             = GUIDOF!IMachineDebugManagerCookie;
const GUID IID_IMachineDebugManagerEvents             = GUIDOF!IMachineDebugManagerEvents;
const GUID IID_IProcessDebugManager32                 = GUIDOF!IProcessDebugManager32;
const GUID IID_IProcessDebugManager64                 = GUIDOF!IProcessDebugManager64;
const GUID IID_IProvideExpressionContexts             = GUIDOF!IProvideExpressionContexts;
const GUID IID_IRemoteDebugApplication                = GUIDOF!IRemoteDebugApplication;
const GUID IID_IRemoteDebugApplication110             = GUIDOF!IRemoteDebugApplication110;
const GUID IID_IRemoteDebugApplicationEvents          = GUIDOF!IRemoteDebugApplicationEvents;
const GUID IID_IRemoteDebugApplicationThread          = GUIDOF!IRemoteDebugApplicationThread;
const GUID IID_IRemoteDebugCriticalErrorEvent110      = GUIDOF!IRemoteDebugCriticalErrorEvent110;
const GUID IID_IRemoteDebugInfoEvent110               = GUIDOF!IRemoteDebugInfoEvent110;
const GUID IID_IScriptEntry                           = GUIDOF!IScriptEntry;
const GUID IID_IScriptInvocationContext               = GUIDOF!IScriptInvocationContext;
const GUID IID_IScriptNode                            = GUIDOF!IScriptNode;
const GUID IID_IScriptScriptlet                       = GUIDOF!IScriptScriptlet;
const GUID IID_ISimpleConnectionPoint                 = GUIDOF!ISimpleConnectionPoint;
const GUID IID_ITridentEventSink                      = GUIDOF!ITridentEventSink;
const GUID IID_IWebAppDiagnosticsObjectInitialization = GUIDOF!IWebAppDiagnosticsObjectInitialization;
const GUID IID_IWebAppDiagnosticsSetup                = GUIDOF!IWebAppDiagnosticsSetup;
