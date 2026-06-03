// Written in the D programming language.

module windows.win32.system.diagnostics.debug_.extensions;

public import windows.core;
public import windows.win32.data.xml.msxml : IXMLDOMElement;
public import windows.win32.foundation : BOOL, BOOLEAN, BSTR, CHAR, FARPROC, HANDLE,
                                         HRESULT, PSTR, PWSTR, VARIANT_BOOL;
public import windows.win32.system.com : IStream, IUnknown;
public import windows.win32.system.diagnostics.debug_ : CONTEXT, EXCEPTION_RECORD64,
                                                        IMAGE_NT_HEADERS64;
public import windows.win32.system.kernel : LIST_ENTRY32, LIST_ENTRY64;
public import windows.win32.system.memory : MEMORY_BASIC_INFORMATION64;
public import windows.win32.system.variant : VARENUM, VARIANT;

extern(Windows) @nogc nothrow:


// Enums


enum ModelObjectKind : int
{
    ObjectPropertyAccessor      = 0x00000000,
    ObjectContext               = 0x00000001,
    ObjectTargetObject          = 0x00000002,
    ObjectTargetObjectReference = 0x00000003,
    ObjectSynthetic             = 0x00000004,
    ObjectNoValue               = 0x00000005,
    ObjectError                 = 0x00000006,
    ObjectIntrinsic             = 0x00000007,
    ObjectMethod                = 0x00000008,
    ObjectKeyReference          = 0x00000009,
}

enum SymbolKind : int
{
    Symbol          = 0x00000000,
    SymbolModule    = 0x00000001,
    SymbolType      = 0x00000002,
    SymbolField     = 0x00000003,
    SymbolConstant  = 0x00000004,
    SymbolData      = 0x00000005,
    SymbolBaseClass = 0x00000006,
    SymbolPublic    = 0x00000007,
    SymbolFunction  = 0x00000008,
}

enum TypeKind : int
{
    TypeUDT           = 0x00000000,
    TypePointer       = 0x00000001,
    TypeMemberPointer = 0x00000002,
    TypeArray         = 0x00000003,
    TypeFunction      = 0x00000004,
    TypeTypedef       = 0x00000005,
    TypeEnum          = 0x00000006,
    TypeIntrinsic     = 0x00000007,
    TypeExtendedArray = 0x00000008,
}

enum IntrinsicKind : int
{
    IntrinsicVoid    = 0x00000000,
    IntrinsicBool    = 0x00000001,
    IntrinsicChar    = 0x00000002,
    IntrinsicWChar   = 0x00000003,
    IntrinsicInt     = 0x00000004,
    IntrinsicUInt    = 0x00000005,
    IntrinsicLong    = 0x00000006,
    IntrinsicULong   = 0x00000007,
    IntrinsicFloat   = 0x00000008,
    IntrinsicHRESULT = 0x00000009,
    IntrinsicChar16  = 0x0000000a,
    IntrinsicChar32  = 0x0000000b,
}

enum PointerKind : int
{
    PointerStandard         = 0x00000000,
    PointerReference        = 0x00000001,
    PointerRValueReference  = 0x00000002,
    PointerCXHat            = 0x00000003,
    PointerManagedReference = 0x00000004,
}

enum CallingConventionKind : int
{
    CallingConventionUnknown  = 0x00000000,
    CallingConventionCDecl    = 0x00000001,
    CallingConventionFastCall = 0x00000002,
    CallingConventionStdCall  = 0x00000003,
    CallingConventionSysCall  = 0x00000004,
    CallingConventionThisCall = 0x00000005,
}

enum LocationKind : int
{
    LocationMember   = 0x00000000,
    LocationStatic   = 0x00000001,
    LocationConstant = 0x00000002,
    LocationNone     = 0x00000003,
}

enum PreferredFormat : int
{
    FormatNone                   = 0x00000000,
    FormatSingleCharacter        = 0x00000001,
    FormatQuotedString           = 0x00000002,
    FormatString                 = 0x00000003,
    FormatQuotedUnicodeString    = 0x00000004,
    FormatUnicodeString          = 0x00000005,
    FormatQuotedUTF8String       = 0x00000006,
    FormatUTF8String             = 0x00000007,
    FormatBSTRString             = 0x00000008,
    FormatQuotedHString          = 0x00000009,
    FormatHString                = 0x0000000a,
    FormatRaw                    = 0x0000000b,
    FormatEnumNameOnly           = 0x0000000c,
    FormatEscapedStringWithQuote = 0x0000000d,
    FormatUTF32String            = 0x0000000e,
    FormatQuotedUTF32String      = 0x0000000f,
}

enum RawSearchFlags : int
{
    RawSearchNone    = 0x00000000,
    RawSearchNoBases = 0x00000001,
}

enum WrappedObjectPreference : int
{
    WrappedObjectNameResolution = 0x00000000,
    WrappedObjectGeneralProxy   = 0x00000001,
}

enum AddressSpaceRelation : int
{
    Disjoint    = 0x00000000,
    Equal       = 0x00000001,
    Overlapping = 0x00000002,
    Subset      = 0x00000003,
    Superset    = 0x00000004,
}

enum ErrorClass : int
{
    ErrorClassWarning = 0x00000000,
    ErrorClassError   = 0x00000001,
}

enum KnownCompiler : int
{
    CompilerUnknown = 0x00000000,
    CompilerMSVC    = 0x00000001,
    CompilerGCC     = 0x00000002,
    CompilerClang   = 0x00000003,
    CompilerRustC   = 0x00000004,
}

enum VarArgsKind : int
{
    VarArgsNone   = 0x00000000,
    VarArgsCStyle = 0x00000001,
}

enum ExtendedArrayDimensionFlags : int
{
    ExtendedArrayLengthIsOffset32               = 0x00000001,
    ExtendedArrayLengthIsOffset64               = 0x00000002,
    ExtendedArrayLengthIsOffset                 = 0x00000003,
    ExtendedArrayLowerBoundIsOffset32           = 0x00000004,
    ExtendedArrayLowerBoundIsOffset64           = 0x00000008,
    ExtendedArrayLowerBoundIsOffset             = 0x0000000c,
    ExtendedArrayStrideIsOffset32               = 0x00000010,
    ExtendedArrayStrideIsOffset64               = 0x00000020,
    ExtendedArrayStrideIsOffset                 = 0x00000030,
    ExtendedArrayStrideIsComputedByNextRank     = 0x00000040,
    ExtendedArrayStrideIsComputedByPreviousRank = 0x00000080,
    ExtendedArrayStrideIsComputed               = 0x000000c0,
}

alias UDTKind = int;
enum : int
{
    UDTStruct      = 0x00000000,
    UDTClass       = 0x00000001,
    UDTUnion       = 0x00000002,
    UDTInterface   = 0x00000003,
    UDTTaggedUnion = 0x00000004,
}

enum SignatureComparison : int
{
    Unrelated    = 0x00000000,
    Ambiguous    = 0x00000001,
    LessSpecific = 0x00000002,
    MoreSpecific = 0x00000003,
    Identical    = 0x00000004,
}

enum SymbolSearchOptions : int
{
    SymbolSearchNone            = 0x00000000,
    SymbolSearchCompletion      = 0x00000001,
    SymbolSearchCaseInsensitive = 0x00000002,
}

enum LanguageKind : int
{
    LanguageUnknown  = 0x00000000,
    LanguageC        = 0x00000001,
    LanguageCPP      = 0x00000002,
    LanguageAssembly = 0x00000003,
    LanguageRust     = 0x00000004,
}

enum ScriptChangeKind : int
{
    ScriptRename = 0x00000000,
}

enum ScriptDebugState : int
{
    ScriptDebugNoDebugger   = 0x00000000,
    ScriptDebugNotExecuting = 0x00000001,
    ScriptDebugExecuting    = 0x00000002,
    ScriptDebugBreak        = 0x00000003,
}

enum ScriptDebugEventFilter : int
{
    ScriptDebugEventFilterEntry              = 0x00000000,
    ScriptDebugEventFilterException          = 0x00000001,
    ScriptDebugEventFilterUnhandledException = 0x00000002,
    ScriptDebugEventFilterAbort              = 0x00000003,
}

enum ScriptDebugEvent : int
{
    ScriptDebugBreakpoint = 0x00000000,
    ScriptDebugStep       = 0x00000001,
    ScriptDebugException  = 0x00000002,
    ScriptDebugAsyncBreak = 0x00000003,
}

enum ScriptExecutionKind : int
{
    ScriptExecutionNormal   = 0x00000000,
    ScriptExecutionStepIn   = 0x00000001,
    ScriptExecutionStepOut  = 0x00000002,
    ScriptExecutionStepOver = 0x00000003,
}

enum StorageKind : int
{
    StorageUnknown                  = 0x00000000,
    StorageRegister                 = 0x00000001,
    StorageRegisterRelative         = 0x00000002,
    StorageRegisterRelativeIndirect = 0x00000003,
}

enum LocalKind : int
{
    LocalArgument = 0x00000000,
    LocalVariable = 0x00000001,
}

alias EXT_TDOP = int;
enum : int
{
    EXT_TDOP_COPY                         = 0x00000000,
    EXT_TDOP_RELEASE                      = 0x00000001,
    EXT_TDOP_SET_FROM_EXPR                = 0x00000002,
    EXT_TDOP_SET_FROM_U64_EXPR            = 0x00000003,
    EXT_TDOP_GET_FIELD                    = 0x00000004,
    EXT_TDOP_EVALUATE                     = 0x00000005,
    EXT_TDOP_GET_TYPE_NAME                = 0x00000006,
    EXT_TDOP_OUTPUT_TYPE_NAME             = 0x00000007,
    EXT_TDOP_OUTPUT_SIMPLE_VALUE          = 0x00000008,
    EXT_TDOP_OUTPUT_FULL_VALUE            = 0x00000009,
    EXT_TDOP_HAS_FIELD                    = 0x0000000a,
    EXT_TDOP_GET_FIELD_OFFSET             = 0x0000000b,
    EXT_TDOP_GET_ARRAY_ELEMENT            = 0x0000000c,
    EXT_TDOP_GET_DEREFERENCE              = 0x0000000d,
    EXT_TDOP_GET_TYPE_SIZE                = 0x0000000e,
    EXT_TDOP_OUTPUT_TYPE_DEFINITION       = 0x0000000f,
    EXT_TDOP_GET_POINTER_TO               = 0x00000010,
    EXT_TDOP_SET_FROM_TYPE_ID_AND_U64     = 0x00000011,
    EXT_TDOP_SET_PTR_FROM_TYPE_ID_AND_U64 = 0x00000012,
    EXT_TDOP_COUNT                        = 0x00000013,
}

alias DBGKD_MAJOR_TYPES = int;
enum : int
{
    DBGKD_MAJOR_NT          = 0x00000000,
    DBGKD_MAJOR_XBOX        = 0x00000001,
    DBGKD_MAJOR_BIG         = 0x00000002,
    DBGKD_MAJOR_EXDI        = 0x00000003,
    DBGKD_MAJOR_NTBD        = 0x00000004,
    DBGKD_MAJOR_EFI         = 0x00000005,
    DBGKD_MAJOR_TNT         = 0x00000006,
    DBGKD_MAJOR_SINGULARITY = 0x00000007,
    DBGKD_MAJOR_HYPERVISOR  = 0x00000008,
    DBGKD_MAJOR_MIDORI      = 0x00000009,
    DBGKD_MAJOR_CE          = 0x0000000a,
    DBGKD_MAJOR_COUNT       = 0x0000000b,
}

alias POOL_HEADER_FIELD_NAME = int;
enum : int
{
    DbgkdPreviousSize = 0x00000000,
    DbgkdPoolIndex    = 0x00000001,
    DbgkdBlockSize    = 0x00000002,
    DbgkdPoolType     = 0x00000003,
    DbgkdUlong1       = 0x00000004,
}

alias DEBUG_POOL_REGION = int;
enum : int
{
    DbgPoolRegionUnknown           = 0x00000000,
    DbgPoolRegionSpecial           = 0x00000001,
    DbgPoolRegionPaged             = 0x00000002,
    DbgPoolRegionNonPaged          = 0x00000003,
    DbgPoolRegionNonPagedExpansion = 0x00000004,
    DbgPoolRegionSessionPaged      = 0x00000005,
    DbgPoolRegionMax               = 0x00000006,
}

alias DEBUG_FAILURE_TYPE = int;
enum : int
{
    DEBUG_FLR_UNKNOWN = 0x00000000,
    DEBUG_FLR_KERNEL  = 0x00000001,
    DEBUG_FLR_USER    = 0x00000002,
}

alias DEBUG_FLR_PARAM_TYPE = int;
enum : int
{
    DEBUG_FLR_INVALID                                       = 0x00000000,
    DEBUG_FLR_RESERVED                                      = 0x00000001,
    DEBUG_FLR_DRIVER_OBJECT                                 = 0x00000002,
    DEBUG_FLR_DEVICE_OBJECT                                 = 0x00000003,
    DEBUG_FLR_INVALID_PFN                                   = 0x00000004,
    DEBUG_FLR_WORKER_ROUTINE                                = 0x00000005,
    DEBUG_FLR_WORK_ITEM                                     = 0x00000006,
    DEBUG_FLR_INVALID_DPC_FOUND                             = 0x00000007,
    DEBUG_FLR_PROCESS_OBJECT                                = 0x00000008,
    DEBUG_FLR_FAILED_INSTRUCTION_ADDRESS                    = 0x00000009,
    DEBUG_FLR_LAST_CONTROL_TRANSFER                         = 0x0000000a,
    DEBUG_FLR_ACPI_EXTENSION                                = 0x0000000b,
    DEBUG_FLR_ACPI_RESCONFLICT                              = 0x0000000c,
    DEBUG_FLR_ACPI_OBJECT                                   = 0x0000000d,
    DEBUG_FLR_READ_ADDRESS                                  = 0x0000000e,
    DEBUG_FLR_WRITE_ADDRESS                                 = 0x0000000f,
    DEBUG_FLR_CRITICAL_SECTION                              = 0x00000010,
    DEBUG_FLR_BAD_HANDLE                                    = 0x00000011,
    DEBUG_FLR_INVALID_HEAP_ADDRESS                          = 0x00000012,
    DEBUG_FLR_CHKIMG_EXTENSION                              = 0x00000013,
    DEBUG_FLR_USBPORT_OCADATA                               = 0x00000014,
    DEBUG_FLR_WORK_QUEUE_ITEM                               = 0x00000015,
    DEBUG_FLR_ERESOURCE_ADDRESS                             = 0x00000016,
    DEBUG_FLR_PNP_TRIAGE_DATA_DEPRECATED                    = 0x00000017,
    DEBUG_FLR_HANDLE_VALUE                                  = 0x00000018,
    DEBUG_FLR_WHEA_ERROR_RECORD                             = 0x00000019,
    DEBUG_FLR_VERIFIER_FOUND_DEADLOCK                       = 0x0000001a,
    DEBUG_FLR_PG_MISMATCH                                   = 0x0000001b,
    DEBUG_FLR_DEVICE_NODE                                   = 0x0000001c,
    DEBUG_FLR_POWERREQUEST_ADDRESS                          = 0x0000001d,
    DEBUG_FLR_EXECUTE_ADDRESS                               = 0x0000001e,
    DEBUG_FLR_IRP_ADDRESS                                   = 0x00000100,
    DEBUG_FLR_IRP_MAJOR_FN                                  = 0x00000101,
    DEBUG_FLR_IRP_MINOR_FN                                  = 0x00000102,
    DEBUG_FLR_IRP_CANCEL_ROUTINE                            = 0x00000103,
    DEBUG_FLR_IOSB_ADDRESS                                  = 0x00000104,
    DEBUG_FLR_INVALID_USEREVENT                             = 0x00000105,
    DEBUG_FLR_VIDEO_TDR_CONTEXT                             = 0x00000106,
    DEBUG_FLR_VERIFIER_DRIVER_ENTRY                         = 0x00000107,
    DEBUG_FLR_PNP_IRP_ADDRESS_DEPRECATED                    = 0x00000108,
    DEBUG_FLR_PREVIOUS_MODE                                 = 0x00000109,
    DEBUG_FLR_CURRENT_IRQL                                  = 0x00000200,
    DEBUG_FLR_PREVIOUS_IRQL                                 = 0x00000201,
    DEBUG_FLR_REQUESTED_IRQL                                = 0x00000202,
    DEBUG_FLR_ASSERT_DATA                                   = 0x00000300,
    DEBUG_FLR_ASSERT_FILE                                   = 0x00000301,
    DEBUG_FLR_EXCEPTION_PARAMETER1                          = 0x00000302,
    DEBUG_FLR_EXCEPTION_PARAMETER2                          = 0x00000303,
    DEBUG_FLR_EXCEPTION_PARAMETER3                          = 0x00000304,
    DEBUG_FLR_EXCEPTION_PARAMETER4                          = 0x00000305,
    DEBUG_FLR_EXCEPTION_RECORD                              = 0x00000306,
    DEBUG_FLR_IO_ERROR_CODE                                 = 0x00000307,
    DEBUG_FLR_EXCEPTION_STR                                 = 0x00000308,
    DEBUG_FLR_EXCEPTION_DOESNOT_MATCH_CODE                  = 0x00000309,
    DEBUG_FLR_ASSERT_INSTRUCTION                            = 0x0000030a,
    DEBUG_FLR_POOL_ADDRESS                                  = 0x00000400,
    DEBUG_FLR_SPECIAL_POOL_CORRUPTION_TYPE                  = 0x00000401,
    DEBUG_FLR_CORRUPTING_POOL_ADDRESS                       = 0x00000402,
    DEBUG_FLR_CORRUPTING_POOL_TAG                           = 0x00000403,
    DEBUG_FLR_FREED_POOL_TAG                                = 0x00000404,
    DEBUG_FLR_LEAKED_SESSION_POOL_TAG                       = 0x00000405,
    DEBUG_FLR_INSTR_SESSION_POOL_TAG                        = 0x00000406,
    DEBUG_FLR_CLIENT_DRIVER                                 = 0x00000407,
    DEBUG_FLR_FILE_ID                                       = 0x00000500,
    DEBUG_FLR_FILE_LINE                                     = 0x00000501,
    DEBUG_FLR_BUGCHECK_STR                                  = 0x00000600,
    DEBUG_FLR_BUGCHECK_SPECIFIER                            = 0x00000601,
    DEBUG_FLR_BUGCHECK_DESC                                 = 0x00000602,
    DEBUG_FLR_MANAGED_CODE                                  = 0x00000700,
    DEBUG_FLR_MANAGED_OBJECT                                = 0x00000701,
    DEBUG_FLR_MANAGED_EXCEPTION_OBJECT                      = 0x00000702,
    DEBUG_FLR_MANAGED_EXCEPTION_MESSAGE_deprecated          = 0x00000703,
    DEBUG_FLR_MANAGED_STACK_STRING                          = 0x00000704,
    DEBUG_FLR_MANAGED_BITNESS_MISMATCH                      = 0x00000705,
    DEBUG_FLR_MANAGED_OBJECT_NAME                           = 0x00000706,
    DEBUG_FLR_MANAGED_EXCEPTION_CONTEXT_MESSAGE             = 0x00000707,
    DEBUG_FLR_MANAGED_STACK_COMMAND                         = 0x00000708,
    DEBUG_FLR_MANAGED_KERNEL_DEBUGGER                       = 0x00000709,
    DEBUG_FLR_MANAGED_HRESULT_STRING                        = 0x0000070a,
    DEBUG_FLR_MANAGED_ENGINE_MODULE                         = 0x0000070b,
    DEBUG_FLR_MANAGED_ANALYSIS_PROVIDER                     = 0x0000070c,
    DEBUG_FLR_MANAGED_EXCEPTION_ADDRESS                     = 0x00000800,
    DEBUG_FLR_MANAGED_EXCEPTION_HRESULT                     = 0x00000801,
    DEBUG_FLR_MANAGED_EXCEPTION_TYPE                        = 0x00000802,
    DEBUG_FLR_MANAGED_EXCEPTION_MESSAGE                     = 0x00000803,
    DEBUG_FLR_MANAGED_EXCEPTION_CALLSTACK                   = 0x00000804,
    DEBUG_FLR_MANAGED_EXCEPTION_INNER_ADDRESS               = 0x00000810,
    DEBUG_FLR_MANAGED_EXCEPTION_INNER_HRESULT               = 0x00000811,
    DEBUG_FLR_MANAGED_EXCEPTION_INNER_TYPE                  = 0x00000812,
    DEBUG_FLR_MANAGED_EXCEPTION_INNER_MESSAGE               = 0x00000813,
    DEBUG_FLR_MANAGED_EXCEPTION_INNER_CALLSTACK             = 0x00000814,
    DEBUG_FLR_MANAGED_EXCEPTION_NESTED_ADDRESS              = 0x00000820,
    DEBUG_FLR_MANAGED_EXCEPTION_NESTED_HRESULT              = 0x00000821,
    DEBUG_FLR_MANAGED_EXCEPTION_NESTED_TYPE                 = 0x00000822,
    DEBUG_FLR_MANAGED_EXCEPTION_NESTED_MESSAGE              = 0x00000823,
    DEBUG_FLR_MANAGED_EXCEPTION_NESTED_CALLSTACK            = 0x00000824,
    DEBUG_FLR_MANAGED_EXCEPTION_CMD                         = 0x000008f0,
    DEBUG_FLR_MANAGED_THREAD_ID                             = 0x00000900,
    DEBUG_FLR_MANAGED_THREAD_CMD_CALLSTACK                  = 0x000009f0,
    DEBUG_FLR_MANAGED_THREAD_CMD_STACKOBJECTS               = 0x000009f1,
    DEBUG_FLR_DRIVER_VERIFIER_IO_VIOLATION_TYPE             = 0x00001000,
    DEBUG_FLR_EXCEPTION_CODE                                = 0x00001001,
    DEBUG_FLR_EXCEPTION_CODE_STR                            = 0x00001002,
    DEBUG_FLR_IOCONTROL_CODE                                = 0x00001003,
    DEBUG_FLR_MM_INTERNAL_CODE                              = 0x00001004,
    DEBUG_FLR_DRVPOWERSTATE_SUBCODE                         = 0x00001005,
    DEBUG_FLR_STATUS_CODE                                   = 0x00001006,
    DEBUG_FLR_SYMBOL_STACK_INDEX                            = 0x00001007,
    DEBUG_FLR_SYMBOL_ON_RAW_STACK                           = 0x00001008,
    DEBUG_FLR_SECURITY_COOKIES                              = 0x00001009,
    DEBUG_FLR_THREADPOOL_WAITER                             = 0x0000100a,
    DEBUG_FLR_TARGET_MODE                                   = 0x0000100b,
    DEBUG_FLR_BUGCHECK_CODE                                 = 0x0000100c,
    DEBUG_FLR_BADPAGES_DETECTED                             = 0x0000100d,
    DEBUG_FLR_DPC_TIMEOUT_TYPE                              = 0x0000100e,
    DEBUG_FLR_DPC_RUNTIME                                   = 0x0000100f,
    DEBUG_FLR_DPC_TIMELIMIT                                 = 0x00001010,
    DEBUG_FLR_DUMP_FILE_ATTRIBUTES                          = 0x00001011,
    DEBUG_FLR_PAGE_HASH_ERRORS                              = 0x00001012,
    DEBUG_FLR_BUGCHECK_P1                                   = 0x00001013,
    DEBUG_FLR_BUGCHECK_P2                                   = 0x00001014,
    DEBUG_FLR_BUGCHECK_P3                                   = 0x00001015,
    DEBUG_FLR_BUGCHECK_P4                                   = 0x00001016,
    DEBUG_FLR_CRITICAL_PROCESS                              = 0x00001017,
    DEBUG_FLR_RESOURCE_CALL_TYPE                            = 0x00001100,
    DEBUG_FLR_RESOURCE_CALL_TYPE_STR                        = 0x00001101,
    DEBUG_FLR_CORRUPT_MODULE_LIST                           = 0x00002000,
    DEBUG_FLR_BAD_STACK                                     = 0x00002001,
    DEBUG_FLR_ZEROED_STACK                                  = 0x00002002,
    DEBUG_FLR_WRONG_SYMBOLS                                 = 0x00002003,
    DEBUG_FLR_FOLLOWUP_DRIVER_ONLY                          = 0x00002004,
    DEBUG_FLR_UNUSED001                                     = 0x00002005,
    DEBUG_FLR_CPU_OVERCLOCKED                               = 0x00002006,
    DEBUG_FLR_POSSIBLE_INVALID_CONTROL_TRANSFER             = 0x00002007,
    DEBUG_FLR_POISONED_TB                                   = 0x00002008,
    DEBUG_FLR_UNKNOWN_MODULE                                = 0x00002009,
    DEBUG_FLR_ANALYZABLE_POOL_CORRUPTION                    = 0x0000200a,
    DEBUG_FLR_SINGLE_BIT_ERROR                              = 0x0000200b,
    DEBUG_FLR_TWO_BIT_ERROR                                 = 0x0000200c,
    DEBUG_FLR_INVALID_KERNEL_CONTEXT                        = 0x0000200d,
    DEBUG_FLR_DISK_HARDWARE_ERROR                           = 0x0000200e,
    DEBUG_FLR_SHOW_ERRORLOG                                 = 0x0000200f,
    DEBUG_FLR_MANUAL_BREAKIN                                = 0x00002010,
    DEBUG_FLR_HANG                                          = 0x00002011,
    DEBUG_FLR_BAD_MEMORY_REFERENCE                          = 0x00002012,
    DEBUG_FLR_BAD_OBJECT_REFERENCE                          = 0x00002013,
    DEBUG_FLR_APPKILL                                       = 0x00002014,
    DEBUG_FLR_SINGLE_BIT_PFN_PAGE_ERROR                     = 0x00002015,
    DEBUG_FLR_HARDWARE_ERROR                                = 0x00002016,
    DEBUG_FLR_NO_IMAGE_IN_BUCKET                            = 0x00002017,
    DEBUG_FLR_NO_BUGCHECK_IN_BUCKET                         = 0x00002018,
    DEBUG_FLR_SKIP_STACK_ANALYSIS                           = 0x00002019,
    DEBUG_FLR_INVALID_OPCODE                                = 0x0000201a,
    DEBUG_FLR_ADD_PROCESS_IN_BUCKET                         = 0x0000201b,
    DEBUG_FLR_RAISED_IRQL_USER_FAULT                        = 0x0000201c,
    DEBUG_FLR_USE_DEFAULT_CONTEXT                           = 0x0000201d,
    DEBUG_FLR_BOOST_FOLLOWUP_TO_SPECIFIC                    = 0x0000201e,
    DEBUG_FLR_SWITCH_PROCESS_CONTEXT                        = 0x0000201f,
    DEBUG_FLR_VERIFIER_STOP                                 = 0x00002020,
    DEBUG_FLR_USERBREAK_PEB_PAGEDOUT                        = 0x00002021,
    DEBUG_FLR_MOD_SPECIFIC_DATA_ONLY                        = 0x00002022,
    DEBUG_FLR_OVERLAPPED_MODULE                             = 0x00002023,
    DEBUG_FLR_CPU_MICROCODE_ZERO_INTEL                      = 0x00002024,
    DEBUG_FLR_INTEL_CPU_BIOS_UPGRADE_NEEDED                 = 0x00002025,
    DEBUG_FLR_OVERLAPPED_UNLOADED_MODULE                    = 0x00002026,
    DEBUG_FLR_INVALID_USER_CONTEXT                          = 0x00002027,
    DEBUG_FLR_MILCORE_BREAK                                 = 0x00002028,
    DEBUG_FLR_NO_IMAGE_TIMESTAMP_IN_BUCKET                  = 0x00002029,
    DEBUG_FLR_KERNEL_VERIFIER_ENABLED                       = 0x0000202a,
    DEBUG_FLR_SKIP_CORRUPT_MODULE_DETECTION                 = 0x0000202b,
    DEBUG_FLR_GSFAILURE_FALSE_POSITIVE                      = 0x0000202c,
    DEBUG_FLR_IGNORE_LARGE_MODULE_CORRUPTION                = 0x0000202d,
    DEBUG_FLR_IGNORE_BUCKET_ID_OFFSET                       = 0x0000202e,
    DEBUG_FLR_NO_ARCH_IN_BUCKET                             = 0x0000202f,
    DEBUG_FLR_IGNORE_MODULE_HARDWARE_ID                     = 0x00002030,
    DEBUG_FLR_ARM_WRITE_AV_CAVEAT                           = 0x00002031,
    DEBUG_FLR_ON_DPC_STACK                                  = 0x00002032,
    DEBUG_FLR_LIVE_KERNEL_DUMP                              = 0x00002033,
    DEBUG_FLR_COVERAGE_BUILD                                = 0x00002034,
    DEBUG_FLR_POSSIBLE_STACK_OVERFLOW                       = 0x00002035,
    DEBUG_FLR_WRONG_SYMBOLS_TIMESTAMP                       = 0x00002036,
    DEBUG_FLR_WRONG_SYMBOLS_SIZE                            = 0x00002037,
    DEBUG_FLR_MISSING_IMPORTANT_SYMBOL                      = 0x00002038,
    DEBUG_FLR_MISSING_CLR_SYMBOL                            = 0x00002039,
    DEBUG_FLR_TARGET_TIME                                   = 0x0000203a,
    DEBUG_FLR_LOW_SYSTEM_COMMIT                             = 0x0000203b,
    DEBUG_FLR_LEGACY_PAGE_TABLE_ACCESS                      = 0x0000203c,
    DEBUG_FLR_HIGH_PROCESS_COMMIT                           = 0x0000203d,
    DEBUG_FLR_HIGH_SERVICE_COMMIT                           = 0x0000203e,
    DEBUG_FLR_HIGH_NONPAGED_POOL_USAGE                      = 0x0000203f,
    DEBUG_FLR_HIGH_PAGED_POOL_USAGE                         = 0x00002040,
    DEBUG_FLR_HIGH_SHARED_COMMIT_USAGE                      = 0x00002041,
    DEBUG_FLR_APPS_NOT_TERMINATED                           = 0x00002042,
    DEBUG_FLR_POOL_CORRUPTOR                                = 0x00003000,
    DEBUG_FLR_MEMORY_CORRUPTOR                              = 0x00003001,
    DEBUG_FLR_UNALIGNED_STACK_POINTER                       = 0x00003002,
    DEBUG_FLR_OS_VERSION_deprecated                         = 0x00003003,
    DEBUG_FLR_BUGCHECKING_DRIVER                            = 0x00003004,
    DEBUG_FLR_SOLUTION_ID                                   = 0x00003005,
    DEBUG_FLR_DEFAULT_SOLUTION_ID                           = 0x00003006,
    DEBUG_FLR_SOLUTION_TYPE                                 = 0x00003007,
    DEBUG_FLR_RECURRING_STACK                               = 0x00003008,
    DEBUG_FLR_FAULTING_INSTR_CODE                           = 0x00003009,
    DEBUG_FLR_SYSTEM_LOCALE_deprecated                      = 0x0000300a,
    DEBUG_FLR_CUSTOMER_CRASH_COUNT                          = 0x0000300b,
    DEBUG_FLR_TRAP_FRAME_RECURSION                          = 0x0000300c,
    DEBUG_FLR_STACK_OVERFLOW                                = 0x0000300d,
    DEBUG_FLR_STACK_POINTER_ERROR                           = 0x0000300e,
    DEBUG_FLR_STACK_POINTER_ONEBIT_ERROR                    = 0x0000300f,
    DEBUG_FLR_STACK_POINTER_MISALIGNED                      = 0x00003010,
    DEBUG_FLR_INSTR_POINTER_MISALIGNED                      = 0x00003011,
    DEBUG_FLR_INSTR_POINTER_CLIFAULT                        = 0x00003012,
    DEBUG_FLR_REGISTRYTXT_STRESS_ID                         = 0x00003013,
    DEBUG_FLR_CORRUPT_SERVICE_TABLE                         = 0x00003014,
    DEBUG_FLR_LOP_STACKHASH                                 = 0x00003015,
    DEBUG_FLR_GSFAILURE_FUNCTION                            = 0x00003016,
    DEBUG_FLR_GSFAILURE_MODULE_COOKIE                       = 0x00003017,
    DEBUG_FLR_GSFAILURE_FRAME_COOKIE                        = 0x00003018,
    DEBUG_FLR_GSFAILURE_FRAME_COOKIE_COMPLEMENT             = 0x00003019,
    DEBUG_FLR_GSFAILURE_CORRUPTED_COOKIE                    = 0x0000301a,
    DEBUG_FLR_GSFAILURE_CORRUPTED_EBP                       = 0x0000301b,
    DEBUG_FLR_GSFAILURE_OVERRUN_LOCAL                       = 0x0000301c,
    DEBUG_FLR_GSFAILURE_OVERRUN_LOCAL_NAME                  = 0x0000301d,
    DEBUG_FLR_GSFAILURE_CORRUPTED_EBPESP                    = 0x0000301e,
    DEBUG_FLR_GSFAILURE_POSITIVELY_CORRUPTED_EBPESP         = 0x0000301f,
    DEBUG_FLR_GSFAILURE_MEMORY_READ_ERROR                   = 0x00003020,
    DEBUG_FLR_GSFAILURE_PROBABLY_NOT_USING_GS               = 0x00003021,
    DEBUG_FLR_GSFAILURE_POSITIVE_BUFFER_OVERFLOW            = 0x00003022,
    DEBUG_FLR_GSFAILURE_ANALYSIS_TEXT                       = 0x00003023,
    DEBUG_FLR_GSFAILURE_OFF_BY_ONE_OVERRUN                  = 0x00003024,
    DEBUG_FLR_GSFAILURE_RA_SMASHED                          = 0x00003025,
    DEBUG_FLR_GSFAILURE_NOT_UP2DATE                         = 0x00003026,
    DEBUG_FLR_GSFAILURE_UP2DATE_UNKNOWN                     = 0x00003027,
    DEBUG_FLR_TRIAGER_OS_BUILD_NAME                         = 0x00003028,
    DEBUG_FLR_CPU_MICROCODE_VERSION                         = 0x00003029,
    DEBUG_FLR_CPU_COUNT                                     = 0x0000302a,
    DEBUG_FLR_CPU_SPEED                                     = 0x0000302b,
    DEBUG_FLR_CPU_VENDOR                                    = 0x0000302c,
    DEBUG_FLR_CPU_FAMILY                                    = 0x0000302d,
    DEBUG_FLR_CPU_MODEL                                     = 0x0000302e,
    DEBUG_FLR_CPU_STEPPING                                  = 0x0000302f,
    DEBUG_FLR_INSTR_POINTER_ON_STACK                        = 0x00003030,
    DEBUG_FLR_INSTR_POINTER_ON_HEAP                         = 0x00003031,
    DEBUG_FLR_EVENT_CODE_DATA_MISMATCH                      = 0x00003032,
    DEBUG_FLR_PROCESSOR_INFO                                = 0x00003033,
    DEBUG_FLR_INSTR_POINTER_IN_UNLOADED_MODULE              = 0x00003034,
    DEBUG_FLR_MEMDIAG_LASTRUN_STATUS                        = 0x00003035,
    DEBUG_FLR_MEMDIAG_LASTRUN_TIME                          = 0x00003036,
    DEBUG_FLR_INSTR_POINTER_IN_FREE_BLOCK                   = 0x00003037,
    DEBUG_FLR_INSTR_POINTER_IN_RESERVED_BLOCK               = 0x00003038,
    DEBUG_FLR_INSTR_POINTER_IN_VM_MAPPED_MODULE             = 0x00003039,
    DEBUG_FLR_INSTR_POINTER_IN_MODULE_NOT_IN_LIST           = 0x0000303a,
    DEBUG_FLR_INSTR_POINTER_NOT_IN_STREAM                   = 0x0000303b,
    DEBUG_FLR_MEMORY_CORRUPTION_SIGNATURE                   = 0x0000303c,
    DEBUG_FLR_BUILDNAME_IN_BUCKET                           = 0x0000303d,
    DEBUG_FLR_CANCELLATION_NOT_SUPPORTED                    = 0x0000303e,
    DEBUG_FLR_DETOURED_IMAGE                                = 0x0000303f,
    DEBUG_FLR_EXCEPTION_CONTEXT_RECURSION                   = 0x00003040,
    DEBUG_FLR_DISKIO_READ_FAILURE                           = 0x00003041,
    DEBUG_FLR_DISKIO_WRITE_FAILURE                          = 0x00003042,
    DEBUG_FLR_GSFAILURE_MISSING_ESTABLISHER_FRAME           = 0x00003043,
    DEBUG_FLR_GSFAILURE_COOKIES_MATCH_EXH                   = 0x00003044,
    DEBUG_FLR_GSFAILURE_MANAGED                             = 0x00003045,
    DEBUG_FLR_MANAGED_FRAME_CHAIN_CORRUPTION                = 0x00003046,
    DEBUG_FLR_GSFAILURE_MANAGED_THREADID                    = 0x00003047,
    DEBUG_FLR_GSFAILURE_MANAGED_FRAMEID                     = 0x00003048,
    DEBUG_FLR_STACKUSAGE_IMAGE                              = 0x00003049,
    DEBUG_FLR_STACKUSAGE_IMAGE_SIZE                         = 0x0000304a,
    DEBUG_FLR_STACKUSAGE_FUNCTION                           = 0x0000304b,
    DEBUG_FLR_STACKUSAGE_FUNCTION_SIZE                      = 0x0000304c,
    DEBUG_FLR_STACKUSAGE_RECURSION_COUNT                    = 0x0000304d,
    DEBUG_FLR_XBOX_SYSTEM_UPTIME                            = 0x0000304e,
    DEBUG_FLR_XBOX_SYSTEM_CRASHTIME                         = 0x0000304f,
    DEBUG_FLR_XBOX_LIVE_ENVIRONMENT                         = 0x00003050,
    DEBUG_FLR_LARGE_TICK_INCREMENT                          = 0x00003051,
    DEBUG_FLR_INSTR_POINTER_IN_PAGED_CODE                   = 0x00003052,
    DEBUG_FLR_SERVICETABLE_MODIFIED                         = 0x00003053,
    DEBUG_FLR_ALUREON                                       = 0x00003054,
    DEBUG_FLR_INTERNAL_RAID_BUG                             = 0x00004000,
    DEBUG_FLR_INTERNAL_BUCKET_URL                           = 0x00004001,
    DEBUG_FLR_INTERNAL_SOLUTION_TEXT                        = 0x00004002,
    DEBUG_FLR_INTERNAL_BUCKET_HITCOUNT                      = 0x00004003,
    DEBUG_FLR_INTERNAL_RAID_BUG_DATABASE_STRING             = 0x00004004,
    DEBUG_FLR_INTERNAL_BUCKET_CONTINUABLE                   = 0x00004005,
    DEBUG_FLR_INTERNAL_BUCKET_STATUS_TEXT                   = 0x00004006,
    DEBUG_FLR_WATSON_MODULE                                 = 0x00004100,
    DEBUG_FLR_WATSON_MODULE_VERSION                         = 0x00004101,
    DEBUG_FLR_WATSON_MODULE_OFFSET                          = 0x00004102,
    DEBUG_FLR_WATSON_PROCESS_VERSION                        = 0x00004103,
    DEBUG_FLR_WATSON_IBUCKET                                = 0x00004104,
    DEBUG_FLR_WATSON_MODULE_TIMESTAMP                       = 0x00004105,
    DEBUG_FLR_WATSON_PROCESS_TIMESTAMP                      = 0x00004106,
    DEBUG_FLR_WATSON_GENERIC_EVENT_NAME                     = 0x00004107,
    DEBUG_FLR_WATSON_GENERIC_BUCKETING_00                   = 0x00004108,
    DEBUG_FLR_WATSON_GENERIC_BUCKETING_01                   = 0x00004109,
    DEBUG_FLR_WATSON_GENERIC_BUCKETING_02                   = 0x0000410a,
    DEBUG_FLR_WATSON_GENERIC_BUCKETING_03                   = 0x0000410b,
    DEBUG_FLR_WATSON_GENERIC_BUCKETING_04                   = 0x0000410c,
    DEBUG_FLR_WATSON_GENERIC_BUCKETING_05                   = 0x0000410d,
    DEBUG_FLR_WATSON_GENERIC_BUCKETING_06                   = 0x0000410e,
    DEBUG_FLR_WATSON_GENERIC_BUCKETING_07                   = 0x0000410f,
    DEBUG_FLR_WATSON_GENERIC_BUCKETING_08                   = 0x00004110,
    DEBUG_FLR_WATSON_GENERIC_BUCKETING_09                   = 0x00004111,
    DEBUG_FLR_SYSXML_LOCALEID                               = 0x00004200,
    DEBUG_FLR_SYSXML_CHECKSUM                               = 0x00004201,
    DEBUG_FLR_WQL_EVENT_COUNT                               = 0x00004202,
    DEBUG_FLR_WQL_EVENTLOG_INFO                             = 0x00004203,
    DEBUG_FLR_SYSINFO_SYSTEM_MANUFACTURER                   = 0x00004300,
    DEBUG_FLR_SYSINFO_SYSTEM_PRODUCT                        = 0x00004301,
    DEBUG_FLR_SYSINFO_SYSTEM_SKU                            = 0x00004302,
    DEBUG_FLR_SYSINFO_SYSTEM_VERSION                        = 0x00004303,
    DEBUG_FLR_SYSINFO_BASEBOARD_MANUFACTURER                = 0x00004304,
    DEBUG_FLR_SYSINFO_BASEBOARD_PRODUCT                     = 0x00004305,
    DEBUG_FLR_SYSINFO_BASEBOARD_VERSION                     = 0x00004306,
    DEBUG_FLR_SYSINFO_BIOS_VENDOR                           = 0x00004307,
    DEBUG_FLR_SYSINFO_BIOS_VERSION                          = 0x00004308,
    DEBUG_FLR_SYSINFO_BIOS_DATE                             = 0x00004309,
    DEBUG_FLR_VIRTUAL_MACHINE                               = 0x0000430a,
    DEBUG_FLR_SERVICE                                       = 0x00005000,
    DEBUG_FLR_SERVICE_NAME                                  = 0x00005001,
    DEBUG_FLR_SERVICE_GROUP                                 = 0x00005002,
    DEBUG_FLR_SERVICE_DISPLAYNAME                           = 0x00005003,
    DEBUG_FLR_SERVICE_DESCRIPTION                           = 0x00005004,
    DEBUG_FLR_SERVICE_DEPENDONSERVICE                       = 0x00005005,
    DEBUG_FLR_SERVICE_DEPENDONGROUP                         = 0x00005006,
    DEBUG_FLR_SVCHOST                                       = 0x00005100,
    DEBUG_FLR_SVCHOST_GROUP                                 = 0x00005101,
    DEBUG_FLR_SVCHOST_IMAGEPATH                             = 0x00005102,
    DEBUG_FLR_SVCHOST_SERVICEDLL                            = 0x00005103,
    DEBUG_FLR_SCM                                           = 0x00005200,
    DEBUG_FLR_SCM_BLACKBOX                                  = 0x000052f0,
    DEBUG_FLR_SCM_BLACKBOX_ENTRY                            = 0x000052f1,
    DEBUG_FLR_SCM_BLACKBOX_ENTRY_CONTROLCODE                = 0x000052f2,
    DEBUG_FLR_SCM_BLACKBOX_ENTRY_STARTTIME                  = 0x000052f3,
    DEBUG_FLR_SCM_BLACKBOX_ENTRY_SERVICENAME                = 0x000052f4,
    DEBUG_FLR_ACPI                                          = 0x00006000,
    DEBUG_FLR_ACPI_BLACKBOX                                 = 0x00006100,
    DEBUG_FLR_PO_BLACKBOX                                   = 0x00006101,
    DEBUG_FLR_BOOTSTAT                                      = 0x00007000,
    DEBUG_FLR_BOOTSTAT_BLACKBOX                             = 0x00007100,
    DEBUG_FLR_STORAGE                                       = 0x00007400,
    DEBUG_FLR_STORAGE_ORGID                                 = 0x00007401,
    DEBUG_FLR_STORAGE_MODEL                                 = 0x00007402,
    DEBUG_FLR_STORAGE_MFGID                                 = 0x00007403,
    DEBUG_FLR_STORAGE_ISSUEDESCSTRING                       = 0x00007404,
    DEBUG_FLR_STORAGE_PUBLIC_TOTSIZE                        = 0x00007405,
    DEBUG_FLR_STORAGE_PUBLIC_OFFSET                         = 0x00007406,
    DEBUG_FLR_STORAGE_PUBLIC_DATASIZE                       = 0x00007407,
    DEBUG_FLR_STORAGE_PRIVATE_TOTSIZE                       = 0x00007408,
    DEBUG_FLR_STORAGE_PRIVATE_OFFSET                        = 0x00007409,
    DEBUG_FLR_STORAGE_PRIVATE_DATASIZE                      = 0x0000740a,
    DEBUG_FLR_STORAGE_TOTALSIZE                             = 0x0000740b,
    DEBUG_FLR_STORAGE_REASON                                = 0x0000740c,
    DEBUG_FLR_STORAGE_BLACKBOX                              = 0x000074f0,
    DEBUG_FLR_FILESYSTEMS_NTFS                              = 0x00007600,
    DEBUG_FLR_FILESYSTEMS_NTFS_BLACKBOX                     = 0x000076f0,
    DEBUG_FLR_FILESYSTEMS_REFS                              = 0x00007800,
    DEBUG_FLR_FILESYSTEMS_REFS_BLACKBOX                     = 0x000078f0,
    DEBUG_FLR_PNP                                           = 0x00008000,
    DEBUG_FLR_PNP_TRIAGE_DATA                               = 0x00008001,
    DEBUG_FLR_PNP_IRP_ADDRESS                               = 0x00008002,
    DEBUG_FLR_PNP_BLACKBOX                                  = 0x00008100,
    DEBUG_FLR_BUCKET_ID                                     = 0x00010000,
    DEBUG_FLR_IMAGE_NAME                                    = 0x00010001,
    DEBUG_FLR_SYMBOL_NAME                                   = 0x00010002,
    DEBUG_FLR_FOLLOWUP_NAME                                 = 0x00010003,
    DEBUG_FLR_STACK_COMMAND                                 = 0x00010004,
    DEBUG_FLR_STACK_TEXT                                    = 0x00010005,
    DEBUG_FLR_MODULE_NAME                                   = 0x00010006,
    DEBUG_FLR_FIXED_IN_OSVERSION                            = 0x00010007,
    DEBUG_FLR_DEFAULT_BUCKET_ID                             = 0x00010008,
    DEBUG_FLR_MODULE_BUCKET_ID                              = 0x00010009,
    DEBUG_FLR_ADDITIONAL_DEBUGTEXT                          = 0x0001000a,
    DEBUG_FLR_PROCESS_NAME                                  = 0x0001000b,
    DEBUG_FLR_USER_NAME                                     = 0x0001000c,
    DEBUG_FLR_MARKER_FILE                                   = 0x0001000d,
    DEBUG_FLR_INTERNAL_RESPONSE                             = 0x0001000e,
    DEBUG_FLR_CONTEXT_RESTORE_COMMAND                       = 0x0001000f,
    DEBUG_FLR_DRIVER_HARDWAREID                             = 0x00010010,
    DEBUG_FLR_DRIVER_HARDWARE_VENDOR_ID                     = 0x00010011,
    DEBUG_FLR_DRIVER_HARDWARE_DEVICE_ID                     = 0x00010012,
    DEBUG_FLR_DRIVER_HARDWARE_SUBSYS_ID                     = 0x00010013,
    DEBUG_FLR_DRIVER_HARDWARE_REV_ID                        = 0x00010014,
    DEBUG_FLR_DRIVER_HARDWARE_ID_BUS_TYPE                   = 0x00010015,
    DEBUG_FLR_MARKER_MODULE_FILE                            = 0x00010016,
    DEBUG_FLR_BUGCHECKING_DRIVER_IDTAG                      = 0x00010017,
    DEBUG_FLR_MARKER_BUCKET                                 = 0x00010018,
    DEBUG_FLR_FAILURE_BUCKET_ID                             = 0x00010019,
    DEBUG_FLR_DRIVER_XML_DESCRIPTION                        = 0x0001001a,
    DEBUG_FLR_DRIVER_XML_PRODUCTNAME                        = 0x0001001b,
    DEBUG_FLR_DRIVER_XML_MANUFACTURER                       = 0x0001001c,
    DEBUG_FLR_DRIVER_XML_VERSION                            = 0x0001001d,
    DEBUG_FLR_BUILD_VERSION_STRING                          = 0x0001001e,
    DEBUG_FLR_BUILD_OS_FULL_VERSION_STRING                  = 0x0001001f,
    DEBUG_FLR_ORIGINAL_CAB_NAME                             = 0x00010020,
    DEBUG_FLR_FAULTING_SOURCE_CODE                          = 0x00010021,
    DEBUG_FLR_FAULTING_SERVICE_NAME                         = 0x00010022,
    DEBUG_FLR_FILE_IN_CAB                                   = 0x00010023,
    DEBUG_FLR_UNRESPONSIVE_UI_SYMBOL_NAME                   = 0x00010024,
    DEBUG_FLR_UNRESPONSIVE_UI_FOLLOWUP_NAME                 = 0x00010025,
    DEBUG_FLR_UNRESPONSIVE_UI_STACK                         = 0x00010026,
    DEBUG_FLR_PROCESS_PRODUCTNAME                           = 0x00010027,
    DEBUG_FLR_MODULE_PRODUCTNAME                            = 0x00010028,
    DEBUG_FLR_COLLECT_DATA_FOR_BUCKET                       = 0x00010029,
    DEBUG_FLR_COMPUTER_NAME                                 = 0x0001002a,
    DEBUG_FLR_IMAGE_CLASS                                   = 0x0001002b,
    DEBUG_FLR_SYMBOL_ROUTINE_NAME                           = 0x0001002c,
    DEBUG_FLR_HARDWARE_BUCKET_TAG                           = 0x0001002d,
    DEBUG_FLR_KERNEL_LOG_PROCESS_NAME                       = 0x0001002e,
    DEBUG_FLR_KERNEL_LOG_STATUS                             = 0x0001002f,
    DEBUG_FLR_REGISTRYTXT_SOURCE                            = 0x00010030,
    DEBUG_FLR_FAULTING_SOURCE_LINE                          = 0x00010031,
    DEBUG_FLR_FAULTING_SOURCE_FILE                          = 0x00010032,
    DEBUG_FLR_FAULTING_SOURCE_LINE_NUMBER                   = 0x00010033,
    DEBUG_FLR_SKIP_MODULE_SPECIFIC_BUCKET_INFO              = 0x00010034,
    DEBUG_FLR_BUCKET_ID_FUNC_OFFSET                         = 0x00010035,
    DEBUG_FLR_XHCI_FIRMWARE_VERSION                         = 0x00010036,
    DEBUG_FLR_FAILURE_ANALYSIS_SOURCE                       = 0x00010037,
    DEBUG_FLR_FAILURE_ID_HASH                               = 0x00010038,
    DEBUG_FLR_FAILURE_ID_HASH_STRING                        = 0x00010039,
    DEBUG_FLR_FAILURE_ID_REPORT_LINK                        = 0x0001003a,
    DEBUG_FLR_HOLDINFO                                      = 0x0001003b,
    DEBUG_FLR_HOLDINFO_ACTIVE_HOLD_COUNT                    = 0x0001003c,
    DEBUG_FLR_HOLDINFO_TENET_SOCRE                          = 0x0001003d,
    DEBUG_FLR_HOLDINFO_HISTORIC_HOLD_COUNT                  = 0x0001003e,
    DEBUG_FLR_HOLDINFO_ALWAYS_IGNORE                        = 0x0001003f,
    DEBUG_FLR_HOLDINFO_ALWAYS_HOLD                          = 0x00010040,
    DEBUG_FLR_HOLDINFO_MAX_HOLD_LIMIT                       = 0x00010041,
    DEBUG_FLR_HOLDINFO_MANUAL_HOLD                          = 0x00010042,
    DEBUG_FLR_HOLDINFO_NOTIFICATION_ALIASES                 = 0x00010043,
    DEBUG_FLR_HOLDINFO_LAST_SEEN_HOLD_DATE                  = 0x00010044,
    DEBUG_FLR_HOLDINFO_RECOMMEND_HOLD                       = 0x00010045,
    DEBUG_FLR_FAILURE_PROBLEM_CLASS                         = 0x00010046,
    DEBUG_FLR_FAILURE_EXCEPTION_CODE                        = 0x00010047,
    DEBUG_FLR_FAILURE_IMAGE_NAME                            = 0x00010048,
    DEBUG_FLR_FAILURE_FUNCTION_NAME                         = 0x00010049,
    DEBUG_FLR_FAILURE_SYMBOL_NAME                           = 0x0001004a,
    DEBUG_FLR_FOLLOWUP_BEFORE_RETRACER                      = 0x0001004b,
    DEBUG_FLR_END_MESSAGE                                   = 0x0001004c,
    DEBUG_FLR_FEATURE_PATH                                  = 0x0001004d,
    DEBUG_FLR_USER_MODE_BUCKET                              = 0x0001004e,
    DEBUG_FLR_USER_MODE_BUCKET_INDEX                        = 0x0001004f,
    DEBUG_FLR_USER_MODE_BUCKET_EVENTTYPE                    = 0x00010050,
    DEBUG_FLR_USER_MODE_BUCKET_REPORTGUID                   = 0x00010051,
    DEBUG_FLR_USER_MODE_BUCKET_REPORTCREATIONTIME           = 0x00010052,
    DEBUG_FLR_USER_MODE_BUCKET_P0                           = 0x00010053,
    DEBUG_FLR_USER_MODE_BUCKET_P1                           = 0x00010054,
    DEBUG_FLR_USER_MODE_BUCKET_P2                           = 0x00010055,
    DEBUG_FLR_USER_MODE_BUCKET_P3                           = 0x00010056,
    DEBUG_FLR_USER_MODE_BUCKET_P4                           = 0x00010057,
    DEBUG_FLR_USER_MODE_BUCKET_P5                           = 0x00010058,
    DEBUG_FLR_USER_MODE_BUCKET_P6                           = 0x00010059,
    DEBUG_FLR_USER_MODE_BUCKET_P7                           = 0x0001005a,
    DEBUG_FLR_USER_MODE_BUCKET_STRING                       = 0x0001005b,
    DEBUG_FLR_CRITICAL_PROCESS_REPORTGUID                   = 0x0001005c,
    DEBUG_FLR_FAILURE_MODULE_NAME                           = 0x0001005d,
    DEBUG_FLR_PLATFORM_BUCKET_STRING                        = 0x0001005e,
    DEBUG_FLR_DRIVER_HARDWARE_VENDOR_NAME                   = 0x0001005f,
    DEBUG_FLR_DRIVER_HARDWARE_SUBVENDOR_NAME                = 0x00010060,
    DEBUG_FLR_DRIVER_HARDWARE_DEVICE_NAME                   = 0x00010061,
    DEBUG_FLR_FAULTING_SOURCE_COMMIT_ID                     = 0x00010062,
    DEBUG_FLR_FAULTING_SOURCE_CONTROL_TYPE                  = 0x00010063,
    DEBUG_FLR_FAULTING_SOURCE_PROJECT                       = 0x00010064,
    DEBUG_FLR_FAULTING_SOURCE_REPO_ID                       = 0x00010065,
    DEBUG_FLR_FAULTING_SOURCE_REPO_URL                      = 0x00010066,
    DEBUG_FLR_FAULTING_SOURCE_SRV_COMMAND                   = 0x00010067,
    DEBUG_FLR_USERMODE_DATA                                 = 0x00100000,
    DEBUG_FLR_THREAD_ATTRIBUTES                             = 0x00100001,
    DEBUG_FLR_PROBLEM_CLASSES                               = 0x00100002,
    DEBUG_FLR_PRIMARY_PROBLEM_CLASS                         = 0x00100003,
    DEBUG_FLR_PRIMARY_PROBLEM_CLASS_DATA                    = 0x00100004,
    DEBUG_FLR_UNRESPONSIVE_UI_PROBLEM_CLASS                 = 0x00100005,
    DEBUG_FLR_UNRESPONSIVE_UI_PROBLEM_CLASS_DATA            = 0x00100006,
    DEBUG_FLR_DERIVED_WAIT_CHAIN                            = 0x00100007,
    DEBUG_FLR_HANG_DATA_NEEDED                              = 0x00100008,
    DEBUG_FLR_PROBLEM_CODE_PATH_HASH                        = 0x00100009,
    DEBUG_FLR_SUSPECT_CODE_PATH_HASH                        = 0x0010000a,
    DEBUG_FLR_LOADERLOCK_IN_WAIT_CHAIN                      = 0x0010000b,
    DEBUG_FLR_XPROC_HANG                                    = 0x0010000c,
    DEBUG_FLR_DEADLOCK_INPROC                               = 0x0010000d,
    DEBUG_FLR_DEADLOCK_XPROC                                = 0x0010000e,
    DEBUG_FLR_WCT_XML_AVAILABLE                             = 0x0010000f,
    DEBUG_FLR_XPROC_DUMP_AVAILABLE                          = 0x00100010,
    DEBUG_FLR_DESKTOP_HEAP_MISSING                          = 0x00100011,
    DEBUG_FLR_HANG_REPORT_THREAD_IS_IDLE                    = 0x00100012,
    DEBUG_FLR_FAULT_THREAD_SHA1_HASH_MF                     = 0x00100013,
    DEBUG_FLR_FAULT_THREAD_SHA1_HASH_MFO                    = 0x00100014,
    DEBUG_FLR_FAULT_THREAD_SHA1_HASH_M                      = 0x00100015,
    DEBUG_FLR_WAIT_CHAIN_COMMAND                            = 0x00100016,
    DEBUG_FLR_NTGLOBALFLAG                                  = 0x00100017,
    DEBUG_FLR_APPVERIFERFLAGS                               = 0x00100018,
    DEBUG_FLR_MODLIST_SHA1_HASH                             = 0x00100019,
    DEBUG_FLR_DUMP_TYPE                                     = 0x0010001a,
    DEBUG_FLR_XCS_PATH                                      = 0x0010001b,
    DEBUG_FLR_LOADERLOCK_OWNER_API                          = 0x0010001c,
    DEBUG_FLR_LOADERLOCK_BLOCKED_API                        = 0x0010001d,
    DEBUG_FLR_MODLIST_TSCHKSUM_SHA1_HASH                    = 0x0010001e,
    DEBUG_FLR_MODLIST_UNLOADED_SHA1_HASH                    = 0x0010001f,
    DEBUG_FLR_MACHINE_INFO_SHA1_HASH                        = 0x00100020,
    DEBUG_FLR_URLS_DISCOVERED                               = 0x00100021,
    DEBUG_FLR_URLS                                          = 0x00100022,
    DEBUG_FLR_URL_ENTRY                                     = 0x00100023,
    DEBUG_FLR_WATSON_IBUCKET_S1_RESP                        = 0x00100024,
    DEBUG_FLR_WATSON_IBUCKETTABLE_S1_RESP                   = 0x00100025,
    DEBUG_FLR_SEARCH_HANG                                   = 0x00100026,
    DEBUG_FLR_WER_DATA_COLLECTION_INFO                      = 0x00100027,
    DEBUG_FLR_WER_MACHINE_ID                                = 0x00100028,
    DEBUG_FLR_ULS_SCRIPT_EXCEPTION                          = 0x00100029,
    DEBUG_FLR_LCIE_ISO_AVAILABLE                            = 0x0010002a,
    DEBUG_FLR_SHOW_LCIE_ISO_DATA                            = 0x0010002b,
    DEBUG_FLR_URL_LCIE_ENTRY                                = 0x0010002c,
    DEBUG_FLR_URL_URLMON_ENTRY                              = 0x0010002d,
    DEBUG_FLR_URL_XMLHTTPREQ_SYNC_ENTRY                     = 0x0010002e,
    DEBUG_FLR_FAULTING_LOCAL_VARIABLE_NAME                  = 0x0010002f,
    DEBUG_FLR_MODULE_LIST                                   = 0x00100030,
    DEBUG_FLR_DUMP_FLAGS                                    = 0x00100031,
    DEBUG_FLR_APPLICATION_VERIFIER_LOADED                   = 0x00100032,
    DEBUG_FLR_DUMP_CLASS                                    = 0x00100033,
    DEBUG_FLR_DUMP_QUALIFIER                                = 0x00100034,
    DEBUG_FLR_KM_MODULE_LIST                                = 0x00100035,
    DEBUG_FLR_EXCEPTION_CODE_STR_deprecated                 = 0x00101000,
    DEBUG_FLR_BUCKET_ID_PREFIX_STR                          = 0x00101001,
    DEBUG_FLR_BUCKET_ID_MODULE_STR                          = 0x00101002,
    DEBUG_FLR_BUCKET_ID_MODVER_STR                          = 0x00101003,
    DEBUG_FLR_BUCKET_ID_FUNCTION_STR                        = 0x00101004,
    DEBUG_FLR_BUCKET_ID_OFFSET                              = 0x00101005,
    DEBUG_FLR_OS_BUILD                                      = 0x00101006,
    DEBUG_FLR_OS_SERVICEPACK                                = 0x00101007,
    DEBUG_FLR_OS_BRANCH                                     = 0x00101008,
    DEBUG_FLR_OS_BUILD_TIMESTAMP_LAB                        = 0x00101009,
    DEBUG_FLR_OS_VERSION                                    = 0x0010100a,
    DEBUG_FLR_BUCKET_ID_TIMEDATESTAMP                       = 0x0010100b,
    DEBUG_FLR_BUCKET_ID_CHECKSUM                            = 0x0010100c,
    DEBUG_FLR_OS_FLAVOR                                     = 0x0010100d,
    DEBUG_FLR_BUCKET_ID_FLAVOR_STR                          = 0x0010100e,
    DEBUG_FLR_OS_SKU                                        = 0x0010100f,
    DEBUG_FLR_OS_PRODUCT_TYPE                               = 0x00101010,
    DEBUG_FLR_OS_SUITE_MASK                                 = 0x00101011,
    DEBUG_FLR_USER_LCID                                     = 0x00101012,
    DEBUG_FLR_OS_REVISION                                   = 0x00101013,
    DEBUG_FLR_OS_NAME                                       = 0x00101014,
    DEBUG_FLR_OS_NAME_EDITION                               = 0x00101015,
    DEBUG_FLR_OS_PLATFORM_ARCH                              = 0x00101016,
    DEBUG_FLR_OS_SERVICEPACK_deprecated                     = 0x00101017,
    DEBUG_FLR_OS_LOCALE                                     = 0x00101018,
    DEBUG_FLR_OS_BUILD_TIMESTAMP_ISO                        = 0x00101019,
    DEBUG_FLR_USER_LCID_STR                                 = 0x0010101a,
    DEBUG_FLR_ANALYSIS_SESSION_TIME                         = 0x0010101b,
    DEBUG_FLR_ANALYSIS_SESSION_HOST                         = 0x0010101c,
    DEBUG_FLR_ANALYSIS_SESSION_ELAPSED_TIME                 = 0x0010101d,
    DEBUG_FLR_ANALYSIS_VERSION                              = 0x0010101e,
    DEBUG_FLR_BUCKET_ID_IMAGE_STR                           = 0x0010101f,
    DEBUG_FLR_BUCKET_ID_PRIVATE                             = 0x00101020,
    DEBUG_FLR_ANALYSIS_REPROCESS                            = 0x00101021,
    DEBUG_FLR_OS_MAJOR                                      = 0x00101022,
    DEBUG_FLR_OS_MINOR                                      = 0x00101023,
    DEBUG_FLR_OS_BUILD_STRING                               = 0x00101024,
    DEBUG_FLR_OS_LOCALE_LCID                                = 0x00101025,
    DEBUG_FLR_OS_PLATFORM_ID                                = 0x00101026,
    DEBUG_FLR_OS_BUILD_LAYERS_XML                           = 0x00101027,
    DEBUG_FLR_OSBUILD_deprecated                            = 0x00101100,
    DEBUG_FLR_BUILDOSVER_STR_deprecated                     = 0x00101101,
    DEBUG_FLR_DEBUG_ANALYSIS                                = 0x00111000,
    DEBUG_FLR_KEYVALUE_ANALYSIS                             = 0x00112000,
    DEBUG_FLR_KEY_VALUES_STRING                             = 0x00112100,
    DEBUG_FLR_KEY_VALUES_VARIANT                            = 0x00112200,
    DEBUG_FLR_TIMELINE_ANALYSIS                             = 0x00113000,
    DEBUG_FLR_TIMELINE_TIMES                                = 0x00113001,
    DEBUG_FLR_STREAM_ANALYSIS                               = 0x00114000,
    DEBUG_FLR_MEMORY_ANALYSIS                               = 0x00115000,
    DEBUG_FLR_STACKHASH_ANALYSIS                            = 0x00116000,
    DEBUG_FLR_PROCESSES_ANALYSIS                            = 0x00117000,
    DEBUG_FLR_SERVICE_ANALYSIS                              = 0x00118000,
    DEBUG_FLR_ADDITIONAL_XML                                = 0x00119000,
    DEBUG_FLR_STACK                                         = 0x00200000,
    DEBUG_FLR_FOLLOWUP_CONTEXT                              = 0x00200001,
    DEBUG_FLR_XML_MODULE_LIST                               = 0x00200002,
    DEBUG_FLR_STACK_FRAME                                   = 0x00200003,
    DEBUG_FLR_STACK_FRAME_NUMBER                            = 0x00200004,
    DEBUG_FLR_STACK_FRAME_INSTRUCTION                       = 0x00200005,
    DEBUG_FLR_STACK_FRAME_SYMBOL                            = 0x00200006,
    DEBUG_FLR_STACK_FRAME_SYMBOL_OFFSET                     = 0x00200007,
    DEBUG_FLR_STACK_FRAME_MODULE                            = 0x00200008,
    DEBUG_FLR_STACK_FRAME_IMAGE                             = 0x00200009,
    DEBUG_FLR_STACK_FRAME_FUNCTION                          = 0x0020000a,
    DEBUG_FLR_STACK_FRAME_FLAGS                             = 0x0020000b,
    DEBUG_FLR_CONTEXT_COMMAND                               = 0x0020000c,
    DEBUG_FLR_CONTEXT_FLAGS                                 = 0x0020000d,
    DEBUG_FLR_CONTEXT_ORDER                                 = 0x0020000e,
    DEBUG_FLR_CONTEXT_SYSTEM                                = 0x0020000f,
    DEBUG_FLR_CONTEXT_ID                                    = 0x00200010,
    DEBUG_FLR_XML_MODULE_INFO                               = 0x00200011,
    DEBUG_FLR_XML_MODULE_INFO_INDEX                         = 0x00200012,
    DEBUG_FLR_XML_MODULE_INFO_NAME                          = 0x00200013,
    DEBUG_FLR_XML_MODULE_INFO_IMAGE_NAME                    = 0x00200014,
    DEBUG_FLR_XML_MODULE_INFO_IMAGE_PATH                    = 0x00200015,
    DEBUG_FLR_XML_MODULE_INFO_CHECKSUM                      = 0x00200016,
    DEBUG_FLR_XML_MODULE_INFO_TIMESTAMP                     = 0x00200017,
    DEBUG_FLR_XML_MODULE_INFO_UNLOADED                      = 0x00200018,
    DEBUG_FLR_XML_MODULE_INFO_ON_STACK                      = 0x00200019,
    DEBUG_FLR_XML_MODULE_INFO_FIXED_FILE_VER                = 0x0020001a,
    DEBUG_FLR_XML_MODULE_INFO_FIXED_PROD_VER                = 0x0020001b,
    DEBUG_FLR_XML_MODULE_INFO_STRING_FILE_VER               = 0x0020001c,
    DEBUG_FLR_XML_MODULE_INFO_STRING_PROD_VER               = 0x0020001d,
    DEBUG_FLR_XML_MODULE_INFO_COMPANY_NAME                  = 0x0020001e,
    DEBUG_FLR_XML_MODULE_INFO_FILE_DESCRIPTION              = 0x0020001f,
    DEBUG_FLR_XML_MODULE_INFO_INTERNAL_NAME                 = 0x00200020,
    DEBUG_FLR_XML_MODULE_INFO_ORIG_FILE_NAME                = 0x00200021,
    DEBUG_FLR_XML_MODULE_INFO_BASE                          = 0x00200022,
    DEBUG_FLR_XML_MODULE_INFO_SIZE                          = 0x00200023,
    DEBUG_FLR_XML_MODULE_INFO_PRODUCT_NAME                  = 0x00200024,
    DEBUG_FLR_PROCESS_INFO                                  = 0x00200025,
    DEBUG_FLR_EXCEPTION_MODULE_INFO                         = 0x00200026,
    DEBUG_FLR_CONTEXT_FOLLOWUP_INDEX                        = 0x00200027,
    DEBUG_FLR_XML_GLOBALATTRIBUTE_LIST                      = 0x00200028,
    DEBUG_FLR_XML_ATTRIBUTE_LIST                            = 0x00200029,
    DEBUG_FLR_XML_ATTRIBUTE                                 = 0x0020002a,
    DEBUG_FLR_XML_ATTRIBUTE_NAME                            = 0x0020002b,
    DEBUG_FLR_XML_ATTRIBUTE_VALUE                           = 0x0020002c,
    DEBUG_FLR_XML_ATTRIBUTE_D1VALUE                         = 0x0020002d,
    DEBUG_FLR_XML_ATTRIBUTE_D2VALUE                         = 0x0020002e,
    DEBUG_FLR_XML_ATTRIBUTE_DOVALUE                         = 0x0020002f,
    DEBUG_FLR_XML_ATTRIBUTE_VALUE_TYPE                      = 0x00200030,
    DEBUG_FLR_XML_ATTRIBUTE_FRAME_NUMBER                    = 0x00200031,
    DEBUG_FLR_XML_ATTRIBUTE_THREAD_INDEX                    = 0x00200032,
    DEBUG_FLR_XML_PROBLEMCLASS_LIST                         = 0x00200033,
    DEBUG_FLR_XML_PROBLEMCLASS                              = 0x00200034,
    DEBUG_FLR_XML_PROBLEMCLASS_NAME                         = 0x00200035,
    DEBUG_FLR_XML_PROBLEMCLASS_VALUE                        = 0x00200036,
    DEBUG_FLR_XML_PROBLEMCLASS_VALUE_TYPE                   = 0x00200037,
    DEBUG_FLR_XML_PROBLEMCLASS_FRAME_NUMBER                 = 0x00200038,
    DEBUG_FLR_XML_PROBLEMCLASS_THREAD_INDEX                 = 0x00200039,
    DEBUG_FLR_XML_STACK_FRAME_TRIAGE_STATUS                 = 0x0020003a,
    DEBUG_FLR_CONTEXT_METADATA                              = 0x0020003b,
    DEBUG_FLR_STACK_FRAMES                                  = 0x0020003c,
    DEBUG_FLR_XML_ENCODED_OFFSETS                           = 0x0020003d,
    DEBUG_FLR_FA_PERF_DATA                                  = 0x0020003e,
    DEBUG_FLR_FA_PERF_ITEM                                  = 0x0020003f,
    DEBUG_FLR_FA_PERF_ITEM_NAME                             = 0x00200040,
    DEBUG_FLR_FA_PERF_ITERATIONS                            = 0x00200041,
    DEBUG_FLR_FA_PERF_ELAPSED_MS                            = 0x00200042,
    DEBUG_FLR_STACK_SHA1_HASH_MF                            = 0x00200043,
    DEBUG_FLR_STACK_SHA1_HASH_MFO                           = 0x00200044,
    DEBUG_FLR_STACK_SHA1_HASH_M                             = 0x00200045,
    DEBUG_FLR_XML_MODULE_INFO_SYMBOL_TYPE                   = 0x00200046,
    DEBUG_FLR_XML_MODULE_INFO_FILE_FLAGS                    = 0x00200047,
    DEBUG_FLR_STACK_FRAME_MODULE_BASE                       = 0x00200048,
    DEBUG_FLR_STACK_FRAME_SRC                               = 0x00200049,
    DEBUG_FLR_XML_SYSTEMINFO                                = 0x0020004a,
    DEBUG_FLR_XML_SYSTEMINFO_SYSTEMMANUFACTURER             = 0x0020004b,
    DEBUG_FLR_XML_SYSTEMINFO_SYSTEMMODEL                    = 0x0020004c,
    DEBUG_FLR_XML_SYSTEMINFO_SYSTEMMARKER                   = 0x0020004d,
    DEBUG_FLR_FA_ADHOC_ANALYSIS_ITEMS                       = 0x0020004e,
    DEBUG_FLR_XML_APPLICATION_NAME                          = 0x0020004f,
    DEBUG_FLR_XML_PACKAGE_MONIKER                           = 0x00200050,
    DEBUG_FLR_XML_PACKAGE_RELATIVE_APPLICATION_ID           = 0x00200051,
    DEBUG_FLR_XML_MODERN_ASYNC_REQUEST_OUTSTANDING          = 0x00200052,
    DEBUG_FLR_XML_EVENTTYPE                                 = 0x00200053,
    DEBUG_FLR_XML_PACKAGE_NAME                              = 0x00200054,
    DEBUG_FLR_XML_PACKAGE_VERSION                           = 0x00200055,
    DEBUG_FLR_FAILURE_LIST                                  = 0x00200056,
    DEBUG_FLR_FAILURE_DISPLAY_NAME                          = 0x00200057,
    DEBUG_FLR_FRAME_SOURCE_FILE_NAME                        = 0x00200058,
    DEBUG_FLR_FRAME_SOURCE_FILE_PATH                        = 0x00200059,
    DEBUG_FLR_FRAME_SOURCE_LINE_NUMBER                      = 0x0020005a,
    DEBUG_FLR_XML_MODULE_INFO_SYMSRV_IMAGE_STATUS           = 0x0020005b,
    DEBUG_FLR_XML_MODULE_INFO_SYMSRV_IMAGE_ERROR            = 0x0020005c,
    DEBUG_FLR_XML_MODULE_INFO_SYMSRV_IMAGE_DETAIL           = 0x0020005d,
    DEBUG_FLR_XML_MODULE_INFO_SYMSRV_IMAGE_SEC              = 0x0020005e,
    DEBUG_FLR_XML_MODULE_INFO_SYMSRV_PDB_STATUS             = 0x0020005f,
    DEBUG_FLR_XML_MODULE_INFO_SYMSRV_PDB_ERROR              = 0x00200060,
    DEBUG_FLR_XML_MODULE_INFO_SYMSRV_PDB_DETAIL             = 0x00200061,
    DEBUG_FLR_XML_MODULE_INFO_SYMSRV_PDB_SEC                = 0x00200062,
    DEBUG_FLR_XML_MODULE_INFO_DRIVER_GROUP                  = 0x00200063,
    DEBUG_FLR_REGISTRY_DATA                                 = 0x00300000,
    DEBUG_FLR_WMI_QUERY_DATA                                = 0x00301000,
    DEBUG_FLR_USER_GLOBAL_ATTRIBUTES                        = 0x00302000,
    DEBUG_FLR_USER_THREAD_ATTRIBUTES                        = 0x00303000,
    DEBUG_FLR_USER_PROBLEM_CLASSES                          = 0x00304000,
    DEBUG_FLR_SM_COMPRESSION_FORMAT                         = 0x50000000,
    DEBUG_FLR_SM_SOURCE_PFN1                                = 0x50000001,
    DEBUG_FLR_SM_SOURCE_PFN2                                = 0x50000002,
    DEBUG_FLR_SM_SOURCE_OFFSET                              = 0x50000003,
    DEBUG_FLR_SM_SOURCE_SIZE                                = 0x50000004,
    DEBUG_FLR_SM_TARGET_PFN                                 = 0x50000005,
    DEBUG_FLR_SM_BUFFER_HASH                                = 0x50000006,
    DEBUG_FLR_SM_ONEBIT_SOLUTION_COUNT                      = 0x50000007,
    DEBUG_FLR_STORE_PRODUCT_ID                              = 0x60000000,
    DEBUG_FLR_STORE_PRODUCT_DISPLAY_NAME                    = 0x60000001,
    DEBUG_FLR_STORE_PRODUCT_DESCRIPTION                     = 0x60000002,
    DEBUG_FLR_STORE_PRODUCT_EXTENDED_NAME                   = 0x60000003,
    DEBUG_FLR_STORE_PUBLISHER_ID                            = 0x60000004,
    DEBUG_FLR_STORE_PUBLISHER_NAME                          = 0x60000005,
    DEBUG_FLR_STORE_PUBLISHER_CERTIFICATE_NAME              = 0x60000006,
    DEBUG_FLR_STORE_DEVELOPER_NAME                          = 0x60000007,
    DEBUG_FLR_STORE_PACKAGE_FAMILY_NAME                     = 0x60000008,
    DEBUG_FLR_STORE_PACKAGE_IDENTITY_NAME                   = 0x60000009,
    DEBUG_FLR_STORE_PRIMARY_PARENT_PRODUCT_ID               = 0x6000000a,
    DEBUG_FLR_STORE_LEGACY_PARENT_PRODUCT_ID                = 0x6000000b,
    DEBUG_FLR_STORE_LEGACY_WINDOWS_STORE_PRODUCT_ID         = 0x6000000c,
    DEBUG_FLR_STORE_LEGACY_WINDOWS_PHONE_PRODUCT_ID         = 0x6000000d,
    DEBUG_FLR_STORE_LEGACY_XBOX_ONE_PRODUCT_ID              = 0x6000000e,
    DEBUG_FLR_STORE_LEGACY_XBOX_360_PRODUCT_ID              = 0x6000000f,
    DEBUG_FLR_STORE_XBOX_TITLE_ID                           = 0x60000010,
    DEBUG_FLR_STORE_PREFERRED_SKU_ID                        = 0x60000011,
    DEBUG_FLR_STORE_IS_MICROSOFT_PRODUCT                    = 0x60000012,
    DEBUG_FLR_STORE_URL_APP                                 = 0x60000013,
    DEBUG_FLR_STORE_URL_APPHEALTH                           = 0x60000014,
    DEBUG_FLR_PHONE_VERSIONMAJOR                            = 0x70000000,
    DEBUG_FLR_PHONE_VERSIONMINOR                            = 0x70000001,
    DEBUG_FLR_PHONE_BUILDNUMBER                             = 0x70000002,
    DEBUG_FLR_PHONE_BUILDTIMESTAMP                          = 0x70000003,
    DEBUG_FLR_PHONE_BUILDBRANCH                             = 0x70000004,
    DEBUG_FLR_PHONE_BUILDER                                 = 0x70000005,
    DEBUG_FLR_PHONE_LCID                                    = 0x70000006,
    DEBUG_FLR_PHONE_QFE                                     = 0x70000007,
    DEBUG_FLR_PHONE_OPERATOR                                = 0x70000008,
    DEBUG_FLR_PHONE_MCCMNC                                  = 0x70000009,
    DEBUG_FLR_PHONE_FIRMWAREREVISION                        = 0x7000000a,
    DEBUG_FLR_PHONE_RAM                                     = 0x7000000b,
    DEBUG_FLR_PHONE_ROMVERSION                              = 0x7000000c,
    DEBUG_FLR_PHONE_SOCVERSION                              = 0x7000000d,
    DEBUG_FLR_PHONE_HARDWAREREVISION                        = 0x7000000e,
    DEBUG_FLR_PHONE_RADIOHARDWAREREVISION                   = 0x7000000f,
    DEBUG_FLR_PHONE_RADIOSOFTWAREREVISION                   = 0x70000010,
    DEBUG_FLR_PHONE_BOOTLOADERVERSION                       = 0x70000011,
    DEBUG_FLR_PHONE_REPORTGUID                              = 0x70000012,
    DEBUG_FLR_PHONE_SOURCE                                  = 0x70000013,
    DEBUG_FLR_PHONE_SOURCEEXTERNAL                          = 0x70000014,
    DEBUG_FLR_PHONE_USERALIAS                               = 0x70000015,
    DEBUG_FLR_PHONE_REPORTTIMESTAMP                         = 0x70000016,
    DEBUG_FLR_PHONE_APPID                                   = 0x70000017,
    DEBUG_FLR_PHONE_SKUID                                   = 0x70000018,
    DEBUG_FLR_PHONE_APPVERSION                              = 0x70000019,
    DEBUG_FLR_PHONE_UIF_COMMENT                             = 0x7000001a,
    DEBUG_FLR_PHONE_UIF_APPNAME                             = 0x7000001b,
    DEBUG_FLR_PHONE_UIF_APPID                               = 0x7000001c,
    DEBUG_FLR_PHONE_UIF_CATEGORY                            = 0x7000001d,
    DEBUG_FLR_PHONE_UIF_ORIGIN                              = 0x7000001e,
    DEBUG_FLR_SIMULTANEOUS_TELSVC_INSTANCES                 = 0x7000001f,
    DEBUG_FLR_SIMULTANEOUS_TELWP_INSTANCES                  = 0x70000020,
    DEBUG_FLR_MINUTES_SINCE_LAST_EVENT                      = 0x70000021,
    DEBUG_FLR_MINUTES_SINCE_LAST_EVENT_OF_THIS_TYPE         = 0x70000022,
    DEBUG_FLR_REPORT_INFO_GUID                              = 0x70000023,
    DEBUG_FLR_REPORT_INFO_SOURCE                            = 0x70000024,
    DEBUG_FLR_REPORT_INFO_CREATION_TIME                     = 0x70000025,
    DEBUG_FLR_FAULTING_IP                                   = 0x80000000,
    DEBUG_FLR_FAULTING_MODULE                               = 0x80000001,
    DEBUG_FLR_IMAGE_TIMESTAMP                               = 0x80000002,
    DEBUG_FLR_FOLLOWUP_IP                                   = 0x80000003,
    DEBUG_FLR_FRAME_ONE_INVALID                             = 0x80000004,
    DEBUG_FLR_SYMBOL_FROM_RAW_STACK_ADDRESS                 = 0x80000005,
    DEBUG_FLR_IMAGE_VERSION                                 = 0x80000006,
    DEBUG_FLR_FOLLOWUP_BUCKET_ID                            = 0x80000007,
    DEBUG_FLR_CUSTOM_ANALYSIS_TAG_MIN                       = 0xa0000000,
    DEBUG_FLR_CUSTOM_ANALYSIS_TAG_MAX                       = 0xb0000000,
    DEBUG_FLR_FAULTING_THREAD                               = 0xc0000000,
    DEBUG_FLR_CONTEXT                                       = 0xc0000001,
    DEBUG_FLR_TRAP_FRAME                                    = 0xc0000002,
    DEBUG_FLR_TSS                                           = 0xc0000003,
    DEBUG_FLR_BLOCKING_THREAD                               = 0xc0000004,
    DEBUG_FLR_UNRESPONSIVE_UI_THREAD                        = 0xc0000005,
    DEBUG_FLR_BLOCKED_THREAD0                               = 0xc0000006,
    DEBUG_FLR_BLOCKED_THREAD1                               = 0xc0000007,
    DEBUG_FLR_BLOCKED_THREAD2                               = 0xc0000008,
    DEBUG_FLR_BLOCKING_PROCESSID                            = 0xc0000009,
    DEBUG_FLR_PROCESSOR_ID                                  = 0xc000000a,
    DEBUG_FLR_XDV_VIOLATED_CONDITION                        = 0xc000000b,
    DEBUG_FLR_XDV_STATE_VARIABLE                            = 0xc000000c,
    DEBUG_FLR_XDV_HELP_LINK                                 = 0xc000000d,
    DEBUG_FLR_XDV_RULE_INFO                                 = 0xc000000e,
    DEBUG_FLR_DPC_STACK_BASE                                = 0xc000000f,
    DEBUG_FLR_TESTRESULTSERVER                              = 0xf0000000,
    DEBUG_FLR_TESTRESULTGUID                                = 0xf0000001,
    DEBUG_FLR_CUSTOMREPORTTAG                               = 0xf0000002,
    DEBUG_FLR_DISKSEC_ORGID_DEPRECATED                      = 0xf0000003,
    DEBUG_FLR_DISKSEC_MODEL_DEPRECATED                      = 0xf0000004,
    DEBUG_FLR_DISKSEC_MFGID_DEPRECATED                      = 0xf0000005,
    DEBUG_FLR_DISKSEC_ISSUEDESCSTRING_DEPRECATED            = 0xf0000006,
    DEBUG_FLR_DISKSEC_PUBLIC_TOTSIZE_DEPRECATED             = 0xf0000007,
    DEBUG_FLR_DISKSEC_PUBLIC_OFFSET_DEPRECATED              = 0xf0000008,
    DEBUG_FLR_DISKSEC_PUBLIC_DATASIZE_DEPRECATED            = 0xf0000009,
    DEBUG_FLR_DISKSEC_PRIVATE_TOTSIZE_DEPRECATED            = 0xf000000a,
    DEBUG_FLR_DISKSEC_PRIVATE_OFFSET_DEPRECATED             = 0xf000000b,
    DEBUG_FLR_DISKSEC_PRIVATE_DATASIZE_DEPRECATED           = 0xf000000c,
    DEBUG_FLR_DISKSEC_TOTALSIZE_DEPRECATED                  = 0xf000000d,
    DEBUG_FLR_DISKSEC_REASON_DEPRECATED                     = 0xf000000e,
    DEBUG_FLR_WERCOLLECTION_PROCESSTERMINATED               = 0xf000000f,
    DEBUG_FLR_WERCOLLECTION_PROCESSHEAPDUMP_REQUEST_FAILURE = 0xf0000010,
    DEBUG_FLR_WERCOLLECTION_MINIDUMP_WRITE_FAILURE          = 0xf0000011,
    DEBUG_FLR_WERCOLLECTION_DEFAULTCOLLECTION_FAILURE       = 0xf0000012,
    DEBUG_FLR_PROCESS_BAM_CURRENT_THROTTLED                 = 0xf0000013,
    DEBUG_FLR_PROCESS_BAM_PREVIOUS_THROTTLED                = 0xf0000014,
    DEBUG_FLR_DUMPSTREAM_COMMENTA                           = 0xf0000015,
    DEBUG_FLR_DUMPSTREAM_COMMENTW                           = 0xf0000016,
    DEBUG_FLR_CHPE_PROCESS                                  = 0xf0000017,
    DEBUG_FLR_WINLOGON_BLACKBOX                             = 0xf0000018,
    DEBUG_FLR_CUSTOM_COMMAND                                = 0xf0000019,
    DEBUG_FLR_CUSTOM_COMMAND_OUTPUT                         = 0xf000001a,
    DEBUG_FLR_MASK_ALL                                      = 0xffffffff,
}

alias FA_ENTRY_TYPE = int;
enum : int
{
    DEBUG_FA_ENTRY_NO_TYPE            = 0x00000000,
    DEBUG_FA_ENTRY_ULONG              = 0x00000001,
    DEBUG_FA_ENTRY_ULONG64            = 0x00000002,
    DEBUG_FA_ENTRY_INSTRUCTION_OFFSET = 0x00000003,
    DEBUG_FA_ENTRY_POINTER            = 0x00000004,
    DEBUG_FA_ENTRY_ANSI_STRING        = 0x00000005,
    DEBUG_FA_ENTRY_ANSI_STRINGs       = 0x00000006,
    DEBUG_FA_ENTRY_EXTENSION_CMD      = 0x00000007,
    DEBUG_FA_ENTRY_STRUCTURED_DATA    = 0x00000008,
    DEBUG_FA_ENTRY_UNICODE_STRING     = 0x00000009,
    DEBUG_FA_ENTRY_ARRAY              = 0x00008000,
}

alias FA_EXTENSION_PLUGIN_PHASE = int;
enum : int
{
    FA_PLUGIN_INITIALIZATION = 0x00000001,
    FA_PLUGIN_STACK_ANALYSIS = 0x00000002,
    FA_PLUGIN_PRE_BUCKETING  = 0x00000004,
    FA_PLUGIN_POST_BUCKETING = 0x00000008,
}

alias OS_TYPE = int;
enum : int
{
    WIN_95        = 0x00000000,
    WIN_98        = 0x00000001,
    WIN_ME        = 0x00000002,
    WIN_NT4       = 0x00000003,
    WIN_NT5       = 0x00000004,
    WIN_NT5_1     = 0x00000005,
    WIN_NT5_2     = 0x00000006,
    WIN_NT6_0     = 0x00000007,
    WIN_NT6_1     = 0x00000008,
    WIN_UNDEFINED = 0x000000ff,
}

alias TANALYZE_RETURN = int;
enum : int
{
    NO_TYPE           = 0x00000000,
    PROCESS_END       = 0x00000001,
    EXIT_STATUS       = 0x00000002,
    DISK_READ_0_BYTES = 0x00000003,
    DISK_WRITE        = 0x00000004,
    NT_STATUS_CODE    = 0x00000005,
}

// Constants


enum : uint
{
    ERROR_DBG_CANCELLED = 0xc00004c7U,
    ERROR_DBG_TIMEOUT   = 0xc00005b4U,
}

enum : uint
{
    DEBUG_GET_TEXT_COMPLETIONS_NO_DOT_COMMANDS       = 0x00000001U,
    DEBUG_GET_TEXT_COMPLETIONS_NO_EXTENSION_COMMANDS = 0x00000002U,
    DEBUG_GET_TEXT_COMPLETIONS_NO_SYMBOLS            = 0x00000004U,
    DEBUG_GET_TEXT_COMPLETIONS_IS_DOT_COMMAND        = 0x00000001U,
    DEBUG_GET_TEXT_COMPLETIONS_IS_EXTENSION_COMMAND  = 0x00000002U,
    DEBUG_GET_TEXT_COMPLETIONS_IS_SYMBOL             = 0x00000004U,
}

enum uint DEBUG_REQUEST_SOURCE_PATH_HAS_SOURCE_SERVER = 0x00000000U;

enum : uint
{
    DEBUG_REQUEST_TARGET_EXCEPTION_CONTEXT = 0x00000001U,
    DEBUG_REQUEST_TARGET_EXCEPTION_THREAD  = 0x00000002U,
    DEBUG_REQUEST_TARGET_EXCEPTION_RECORD  = 0x00000003U,
}

enum uint DEBUG_REQUEST_GET_ADDITIONAL_CREATE_OPTIONS = 0x00000004U;
enum uint DEBUG_REQUEST_SET_ADDITIONAL_CREATE_OPTIONS = 0x00000005U;
enum uint DEBUG_REQUEST_GET_WIN32_MAJOR_MINOR_VERSIONS = 0x00000006U;
enum uint DEBUG_REQUEST_READ_USER_MINIDUMP_STREAM = 0x00000007U;

enum : uint
{
    DEBUG_REQUEST_TARGET_CAN_DETACH               = 0x00000008U,
    DEBUG_REQUEST_SET_LOCAL_IMPLICIT_COMMAND_LINE = 0x00000009U,
}

enum uint DEBUG_REQUEST_GET_CAPTURED_EVENT_CODE_OFFSET = 0x0000000aU;
enum uint DEBUG_REQUEST_READ_CAPTURED_EVENT_CODE_STREAM = 0x0000000bU;

enum : uint
{
    DEBUG_REQUEST_EXT_TYPED_DATA_ANSI            = 0x0000000cU,
    DEBUG_REQUEST_GET_EXTENSION_SEARCH_PATH_WIDE = 0x0000000dU,
    DEBUG_REQUEST_GET_TEXT_COMPLETIONS_WIDE      = 0x0000000eU,
    DEBUG_REQUEST_GET_CACHED_SYMBOL_INFO         = 0x0000000fU,
}

enum uint DEBUG_REQUEST_ADD_CACHED_SYMBOL_INFO = 0x00000010U;
enum uint DEBUG_REQUEST_REMOVE_CACHED_SYMBOL_INFO = 0x00000011U;
enum uint DEBUG_REQUEST_GET_TEXT_COMPLETIONS_ANSI = 0x00000012U;
enum uint DEBUG_REQUEST_CURRENT_OUTPUT_CALLBACKS_ARE_DML_AWARE = 0x00000013U;

enum : uint
{
    DEBUG_REQUEST_GET_OFFSET_UNWIND_INFORMATION = 0x00000014U,
    DEBUG_REQUEST_GET_DUMP_HEADER               = 0x00000015U,
    DEBUG_REQUEST_SET_DUMP_HEADER               = 0x00000016U,
    DEBUG_REQUEST_MIDORI                        = 0x00000017U,
    DEBUG_REQUEST_PROCESS_DESCRIPTORS           = 0x00000018U,
    DEBUG_REQUEST_MISC_INFORMATION              = 0x00000019U,
    DEBUG_REQUEST_OPEN_PROCESS_TOKEN            = 0x0000001aU,
    DEBUG_REQUEST_OPEN_THREAD_TOKEN             = 0x0000001bU,
    DEBUG_REQUEST_DUPLICATE_TOKEN               = 0x0000001cU,
    DEBUG_REQUEST_QUERY_INFO_TOKEN              = 0x0000001dU,
    DEBUG_REQUEST_CLOSE_TOKEN                   = 0x0000001eU,
    DEBUG_REQUEST_WOW_PROCESS                   = 0x0000001fU,
    DEBUG_REQUEST_WOW_MODULE                    = 0x00000020U,
}

enum uint DEBUG_LIVE_USER_NON_INVASIVE = 0x00000021U;

enum : uint
{
    DEBUG_REQUEST_RESUME_THREAD            = 0x00000022U,
    DEBUG_REQUEST_INLINE_QUERY             = 0x00000023U,
    DEBUG_REQUEST_TL_INSTRUMENTATION_AWARE = 0x00000024U,
}

enum : uint
{
    DEBUG_REQUEST_GET_INSTRUMENTATION_VERSION = 0x00000025U,
    DEBUG_REQUEST_GET_MODULE_ARCHITECTURE     = 0x00000026U,
    DEBUG_REQUEST_GET_IMAGE_ARCHITECTURE      = 0x00000027U,
}

enum uint DEBUG_REQUEST_SET_PARENT_HWND = 0x00000028U;

enum : uint
{
    DEBUG_SRCFILE_SYMBOL_TOKEN                     = 0x00000000U,
    DEBUG_SRCFILE_SYMBOL_TOKEN_SOURCE_COMMAND_WIDE = 0x00000001U,
    DEBUG_SRCFILE_SYMBOL_CHECKSUMINFO              = 0x00000002U,
}

enum uint DEBUG_SYMINFO_BREAKPOINT_SOURCE_LINE = 0x00000000U;

enum : uint
{
    DEBUG_SYMINFO_IMAGEHLP_MODULEW64                     = 0x00000001U,
    DEBUG_SYMINFO_GET_SYMBOL_NAME_BY_OFFSET_AND_TAG_WIDE = 0x00000002U,
}

enum uint DEBUG_SYMINFO_GET_MODULE_SYMBOL_NAMES_AND_OFFSETS = 0x00000003U;

enum : uint
{
    DEBUG_SYSOBJINFO_THREAD_BASIC_INFORMATION = 0x00000000U,
    DEBUG_SYSOBJINFO_THREAD_NAME_WIDE         = 0x00000001U,
    DEBUG_SYSOBJINFO_CURRENT_PROCESS_COOKIE   = 0x00000002U,
}

enum : uint
{
    DEBUG_TBINFO_EXIT_STATUS    = 0x00000001U,
    DEBUG_TBINFO_PRIORITY_CLASS = 0x00000002U,
    DEBUG_TBINFO_PRIORITY       = 0x00000004U,
    DEBUG_TBINFO_TIMES          = 0x00000008U,
    DEBUG_TBINFO_START_OFFSET   = 0x00000010U,
    DEBUG_TBINFO_AFFINITY       = 0x00000020U,
    DEBUG_TBINFO_ALL            = 0x0000003fU,
}

enum : uint
{
    DEBUG_BREAKPOINT_CODE          = 0x00000000U,
    DEBUG_BREAKPOINT_DATA          = 0x00000001U,
    DEBUG_BREAKPOINT_TIME          = 0x00000002U,
    DEBUG_BREAKPOINT_INLINE        = 0x00000003U,
    DEBUG_BREAKPOINT_GO_ONLY       = 0x00000001U,
    DEBUG_BREAKPOINT_DEFERRED      = 0x00000002U,
    DEBUG_BREAKPOINT_ENABLED       = 0x00000004U,
    DEBUG_BREAKPOINT_ADDER_ONLY    = 0x00000008U,
    DEBUG_BREAKPOINT_ONE_SHOT      = 0x00000010U,
    DEBUG_BREAK_READ               = 0x00000001U,
    DEBUG_BREAK_WRITE              = 0x00000002U,
    DEBUG_BREAK_EXECUTE            = 0x00000004U,
    DEBUG_BREAK_IO                 = 0x00000008U,
    DEBUG_ATTACH_KERNEL_CONNECTION = 0x00000000U,
    DEBUG_ATTACH_LOCAL_KERNEL      = 0x00000001U,
    DEBUG_ATTACH_EXDI_DRIVER       = 0x00000002U,
    DEBUG_ATTACH_INSTALL_DRIVER    = 0x00000004U,
}

enum : uint
{
    DEBUG_GET_PROC_DEFAULT      = 0x00000000U,
    DEBUG_GET_PROC_FULL_MATCH   = 0x00000001U,
    DEBUG_GET_PROC_ONLY_MATCH   = 0x00000002U,
    DEBUG_GET_PROC_SERVICE_NAME = 0x00000004U,
}

enum : uint
{
    DEBUG_PROC_DESC_DEFAULT            = 0x00000000U,
    DEBUG_PROC_DESC_NO_PATHS           = 0x00000001U,
    DEBUG_PROC_DESC_NO_SERVICES        = 0x00000002U,
    DEBUG_PROC_DESC_NO_MTS_PACKAGES    = 0x00000004U,
    DEBUG_PROC_DESC_NO_COMMAND_LINE    = 0x00000008U,
    DEBUG_PROC_DESC_NO_SESSION_ID      = 0x00000010U,
    DEBUG_PROC_DESC_NO_USER_NAME       = 0x00000020U,
    DEBUG_PROC_DESC_WITH_PACKAGEFAMILY = 0x00000040U,
    DEBUG_PROC_DESC_WITH_ARCHITECTURE  = 0x00000080U,
}

enum : uint
{
    DEBUG_ATTACH_DEFAULT                = 0x00000000U,
    DEBUG_ATTACH_NONINVASIVE            = 0x00000001U,
    DEBUG_ATTACH_EXISTING               = 0x00000002U,
    DEBUG_ATTACH_NONINVASIVE_NO_SUSPEND = 0x00000004U,
}

enum : uint
{
    DEBUG_ATTACH_INVASIVE_NO_INITIAL_BREAK = 0x00000008U,
    DEBUG_ATTACH_INVASIVE_RESUME_PROCESS   = 0x00000010U,
}

enum uint DEBUG_ATTACH_NONINVASIVE_ALLOW_PARTIAL = 0x00000020U;

enum : uint
{
    DEBUG_ECREATE_PROCESS_DEFAULT                   = 0x00000000U,
    DEBUG_ECREATE_PROCESS_INHERIT_HANDLES           = 0x00000001U,
    DEBUG_ECREATE_PROCESS_USE_VERIFIER_FLAGS        = 0x00000002U,
    DEBUG_ECREATE_PROCESS_USE_IMPLICIT_COMMAND_LINE = 0x00000004U,
}

enum : uint
{
    DEBUG_PROCESS_DETACH_ON_EXIT    = 0x00000001U,
    DEBUG_PROCESS_ONLY_THIS_PROCESS = 0x00000002U,
}

enum : uint
{
    DEBUG_CONNECT_SESSION_DEFAULT     = 0x00000000U,
    DEBUG_CONNECT_SESSION_NO_VERSION  = 0x00000001U,
    DEBUG_CONNECT_SESSION_NO_ANNOUNCE = 0x00000002U,
}

enum : uint
{
    DEBUG_SERVERS_DEBUGGER = 0x00000001U,
    DEBUG_SERVERS_PROCESS  = 0x00000002U,
    DEBUG_SERVERS_ALL      = 0x00000003U,
}

enum : uint
{
    DEBUG_END_PASSIVE          = 0x00000000U,
    DEBUG_END_ACTIVE_TERMINATE = 0x00000001U,
    DEBUG_END_ACTIVE_DETACH    = 0x00000002U,
    DEBUG_END_REENTRANT        = 0x00000003U,
    DEBUG_END_DISCONNECT       = 0x00000004U,
}

enum : uint
{
    DEBUG_OUTPUT_NORMAL            = 0x00000001U,
    DEBUG_OUTPUT_ERROR             = 0x00000002U,
    DEBUG_OUTPUT_WARNING           = 0x00000004U,
    DEBUG_OUTPUT_VERBOSE           = 0x00000008U,
    DEBUG_OUTPUT_PROMPT            = 0x00000010U,
    DEBUG_OUTPUT_PROMPT_REGISTERS  = 0x00000020U,
    DEBUG_OUTPUT_EXTENSION_WARNING = 0x00000040U,
    DEBUG_OUTPUT_DEBUGGEE          = 0x00000080U,
    DEBUG_OUTPUT_DEBUGGEE_PROMPT   = 0x00000100U,
    DEBUG_OUTPUT_SYMBOLS           = 0x00000200U,
    DEBUG_OUTPUT_STATUS            = 0x00000400U,
    DEBUG_OUTPUT_XML               = 0x00000800U,
}

enum : uint
{
    DEBUG_IOUTPUT_KD_PROTOCOL    = 0x80000000U,
    DEBUG_IOUTPUT_REMOTING       = 0x40000000U,
    DEBUG_IOUTPUT_BREAKPOINT     = 0x20000000U,
    DEBUG_IOUTPUT_EVENT          = 0x10000000U,
    DEBUG_IOUTPUT_ADDR_TRANSLATE = 0x08000000U,
}

enum uint DEBUG_OUTPUT_IDENTITY_DEFAULT = 0x00000000U;

enum : uint
{
    DEBUG_CLIENT_UNKNOWN = 0x00000000U,
    DEBUG_CLIENT_VSINT   = 0x00000001U,
    DEBUG_CLIENT_NTSD    = 0x00000002U,
    DEBUG_CLIENT_NTKD    = 0x00000003U,
    DEBUG_CLIENT_CDB     = 0x00000004U,
    DEBUG_CLIENT_KD      = 0x00000005U,
    DEBUG_CLIENT_WINDBG  = 0x00000006U,
    DEBUG_CLIENT_WINIDE  = 0x00000007U,
}

enum : uint
{
    DEBUG_FORMAT_DEFAULT                  = 0x00000000U,
    DEBUG_FORMAT_CAB_SECONDARY_ALL_IMAGES = 0x10000000U,
}

enum : uint
{
    DEBUG_FORMAT_WRITE_CAB                             = 0x20000000U,
    DEBUG_FORMAT_CAB_SECONDARY_FILES                   = 0x40000000U,
    DEBUG_FORMAT_NO_OVERWRITE                          = 0x80000000U,
    DEBUG_FORMAT_USER_SMALL_FULL_MEMORY                = 0x00000001U,
    DEBUG_FORMAT_USER_SMALL_HANDLE_DATA                = 0x00000002U,
    DEBUG_FORMAT_USER_SMALL_UNLOADED_MODULES           = 0x00000004U,
    DEBUG_FORMAT_USER_SMALL_INDIRECT_MEMORY            = 0x00000008U,
    DEBUG_FORMAT_USER_SMALL_DATA_SEGMENTS              = 0x00000010U,
    DEBUG_FORMAT_USER_SMALL_FILTER_MEMORY              = 0x00000020U,
    DEBUG_FORMAT_USER_SMALL_FILTER_PATHS               = 0x00000040U,
    DEBUG_FORMAT_USER_SMALL_PROCESS_THREAD_DATA        = 0x00000080U,
    DEBUG_FORMAT_USER_SMALL_PRIVATE_READ_WRITE_MEMORY  = 0x00000100U,
    DEBUG_FORMAT_USER_SMALL_NO_OPTIONAL_DATA           = 0x00000200U,
    DEBUG_FORMAT_USER_SMALL_FULL_MEMORY_INFO           = 0x00000400U,
    DEBUG_FORMAT_USER_SMALL_THREAD_INFO                = 0x00000800U,
    DEBUG_FORMAT_USER_SMALL_CODE_SEGMENTS              = 0x00001000U,
    DEBUG_FORMAT_USER_SMALL_NO_AUXILIARY_STATE         = 0x00002000U,
    DEBUG_FORMAT_USER_SMALL_FULL_AUXILIARY_STATE       = 0x00004000U,
    DEBUG_FORMAT_USER_SMALL_MODULE_HEADERS             = 0x00008000U,
    DEBUG_FORMAT_USER_SMALL_FILTER_TRIAGE              = 0x00010000U,
    DEBUG_FORMAT_USER_SMALL_ADD_AVX_XSTATE_CONTEXT     = 0x00020000U,
    DEBUG_FORMAT_USER_SMALL_IPT_TRACE                  = 0x00040000U,
    DEBUG_FORMAT_USER_SMALL_NO_IGNORE_INACCESSIBLE_MEM = 0x04000000U,
    DEBUG_FORMAT_USER_SMALL_IGNORE_INACCESSIBLE_MEM    = 0x08000000U,
    DEBUG_FORMAT_USER_SMALL_SCAN_PARTIAL_PAGES         = 0x10000000U,
}

enum : uint
{
    DEBUG_DUMP_FILE_BASE               = 0xffffffffU,
    DEBUG_DUMP_FILE_PAGE_FILE_DUMP     = 0x00000000U,
    DEBUG_DUMP_FILE_LOAD_FAILED_INDEX  = 0xffffffffU,
    DEBUG_DUMP_FILE_ORIGINAL_CAB_INDEX = 0xfffffffeU,
}

enum : uint
{
    DEBUG_STATUS_NO_CHANGE           = 0x00000000U,
    DEBUG_STATUS_GO                  = 0x00000001U,
    DEBUG_STATUS_GO_HANDLED          = 0x00000002U,
    DEBUG_STATUS_GO_NOT_HANDLED      = 0x00000003U,
    DEBUG_STATUS_STEP_OVER           = 0x00000004U,
    DEBUG_STATUS_STEP_INTO           = 0x00000005U,
    DEBUG_STATUS_BREAK               = 0x00000006U,
    DEBUG_STATUS_NO_DEBUGGEE         = 0x00000007U,
    DEBUG_STATUS_STEP_BRANCH         = 0x00000008U,
    DEBUG_STATUS_IGNORE_EVENT        = 0x00000009U,
    DEBUG_STATUS_RESTART_REQUESTED   = 0x0000000aU,
    DEBUG_STATUS_REVERSE_GO          = 0x0000000bU,
    DEBUG_STATUS_REVERSE_STEP_BRANCH = 0x0000000cU,
    DEBUG_STATUS_REVERSE_STEP_OVER   = 0x0000000dU,
    DEBUG_STATUS_REVERSE_STEP_INTO   = 0x0000000eU,
    DEBUG_STATUS_OUT_OF_SYNC         = 0x0000000fU,
    DEBUG_STATUS_WAIT_INPUT          = 0x00000010U,
    DEBUG_STATUS_TIMEOUT             = 0x00000011U,
    DEBUG_STATUS_MASK                = 0x0000001fU,
}

enum : ulong
{
    DEBUG_STATUS_INSIDE_WAIT  = 0x0000000100000000UL,
    DEBUG_STATUS_WAIT_TIMEOUT = 0x0000000200000000UL,
}

enum : uint
{
    DEBUG_OUTCTL_THIS_CLIENT       = 0x00000000U,
    DEBUG_OUTCTL_ALL_CLIENTS       = 0x00000001U,
    DEBUG_OUTCTL_ALL_OTHER_CLIENTS = 0x00000002U,
    DEBUG_OUTCTL_IGNORE            = 0x00000003U,
    DEBUG_OUTCTL_LOG_ONLY          = 0x00000004U,
    DEBUG_OUTCTL_SEND_MASK         = 0x00000007U,
    DEBUG_OUTCTL_NOT_LOGGED        = 0x00000008U,
    DEBUG_OUTCTL_OVERRIDE_MASK     = 0x00000010U,
    DEBUG_OUTCTL_DML               = 0x00000020U,
    DEBUG_OUTCTL_AMBIENT_DML       = 0xfffffffeU,
    DEBUG_OUTCTL_AMBIENT_TEXT      = 0xffffffffU,
    DEBUG_OUTCTL_AMBIENT           = 0xffffffffU,
}

enum : uint
{
    DEBUG_INTERRUPT_ACTIVE  = 0x00000000U,
    DEBUG_INTERRUPT_PASSIVE = 0x00000001U,
    DEBUG_INTERRUPT_EXIT    = 0x00000002U,
}

enum : uint
{
    DEBUG_CURRENT_DEFAULT     = 0x0000000fU,
    DEBUG_CURRENT_SYMBOL      = 0x00000001U,
    DEBUG_CURRENT_DISASM      = 0x00000002U,
    DEBUG_CURRENT_REGISTERS   = 0x00000004U,
    DEBUG_CURRENT_SOURCE_LINE = 0x00000008U,
}

enum : uint
{
    DEBUG_DISASM_EFFECTIVE_ADDRESS  = 0x00000001U,
    DEBUG_DISASM_MATCHING_SYMBOLS   = 0x00000002U,
    DEBUG_DISASM_SOURCE_LINE_NUMBER = 0x00000004U,
    DEBUG_DISASM_SOURCE_FILE_NAME   = 0x00000008U,
}

enum : uint
{
    DEBUG_LEVEL_SOURCE   = 0x00000000U,
    DEBUG_LEVEL_ASSEMBLY = 0x00000001U,
}

enum : uint
{
    DEBUG_ENGOPT_IGNORE_DBGHELP_VERSION    = 0x00000001U,
    DEBUG_ENGOPT_IGNORE_EXTENSION_VERSIONS = 0x00000002U,
}

enum : uint
{
    DEBUG_ENGOPT_ALLOW_NETWORK_PATHS    = 0x00000004U,
    DEBUG_ENGOPT_DISALLOW_NETWORK_PATHS = 0x00000008U,
}

enum uint DEBUG_ENGOPT_IGNORE_LOADER_EXCEPTIONS = 0x00000010U;

enum : uint
{
    DEBUG_ENGOPT_INITIAL_BREAK        = 0x00000020U,
    DEBUG_ENGOPT_INITIAL_MODULE_BREAK = 0x00000040U,
}

enum : uint
{
    DEBUG_ENGOPT_FINAL_BREAK                 = 0x00000080U,
    DEBUG_ENGOPT_NO_EXECUTE_REPEAT           = 0x00000100U,
    DEBUG_ENGOPT_FAIL_INCOMPLETE_INFORMATION = 0x00000200U,
}

enum uint DEBUG_ENGOPT_ALLOW_READ_ONLY_BREAKPOINTS = 0x00000400U;
enum uint DEBUG_ENGOPT_SYNCHRONIZE_BREAKPOINTS = 0x00000800U;
enum uint DEBUG_ENGOPT_DISALLOW_SHELL_COMMANDS = 0x00001000U;

enum : uint
{
    DEBUG_ENGOPT_KD_QUIET_MODE               = 0x00002000U,
    DEBUG_ENGOPT_DISABLE_MANAGED_SUPPORT     = 0x00004000U,
    DEBUG_ENGOPT_DISABLE_MODULE_SYMBOL_LOAD  = 0x00008000U,
    DEBUG_ENGOPT_DISABLE_EXECUTION_COMMANDS  = 0x00010000U,
    DEBUG_ENGOPT_DISALLOW_IMAGE_FILE_MAPPING = 0x00020000U,
}

enum : uint
{
    DEBUG_ENGOPT_PREFER_DML                = 0x00040000U,
    DEBUG_ENGOPT_DISABLESQM                = 0x00080000U,
    DEBUG_ENGOPT_DISABLE_STEPLINES_OPTIONS = 0x00200000U,
}

enum uint DEBUG_ENGOPT_DEBUGGING_SENSITIVE_DATA = 0x00400000U;

enum : uint
{
    DEBUG_ENGOPT_PREFER_TRACE_FILES         = 0x00800000U,
    DEBUG_ENGOPT_RESOLVE_SHADOWED_VARIABLES = 0x01000000U,
}

enum uint DEBUG_ENGOPT_ALL = 0x01efffffU;
enum uint DEBUG_ANY_ID = 0xffffffffU;

enum : uint
{
    DBG_FRAME_DEFAULT       = 0x00000000U,
    DBG_FRAME_IGNORE_INLINE = 0xffffffffU,
}

enum : uint
{
    STACK_FRAME_TYPE_INIT   = 0x00000000U,
    STACK_FRAME_TYPE_STACK  = 0x00000001U,
    STACK_FRAME_TYPE_INLINE = 0x00000002U,
    STACK_FRAME_TYPE_RA     = 0x00000080U,
    STACK_FRAME_TYPE_IGNORE = 0x000000ffU,
}

enum : uint
{
    DEBUG_STACK_ARGUMENTS             = 0x00000001U,
    DEBUG_STACK_FUNCTION_INFO         = 0x00000002U,
    DEBUG_STACK_SOURCE_LINE           = 0x00000004U,
    DEBUG_STACK_FRAME_ADDRESSES       = 0x00000008U,
    DEBUG_STACK_COLUMN_NAMES          = 0x00000010U,
    DEBUG_STACK_NONVOLATILE_REGISTERS = 0x00000020U,
}

enum : uint
{
    DEBUG_STACK_FRAME_NUMBERS           = 0x00000040U,
    DEBUG_STACK_PARAMETERS              = 0x00000080U,
    DEBUG_STACK_FRAME_ADDRESSES_RA_ONLY = 0x00000100U,
    DEBUG_STACK_FRAME_MEMORY_USAGE      = 0x00000200U,
}

enum uint DEBUG_STACK_PARAMETERS_NEWLINE = 0x00000400U;

enum : uint
{
    DEBUG_STACK_DML           = 0x00000800U,
    DEBUG_STACK_FRAME_OFFSETS = 0x00001000U,
    DEBUG_STACK_PROVIDER      = 0x00002000U,
    DEBUG_STACK_FRAME_ARCH    = 0x00004000U,
}

enum : uint
{
    DEBUG_CLASS_UNINITIALIZED = 0x00000000U,
    DEBUG_CLASS_KERNEL        = 0x00000001U,
    DEBUG_CLASS_USER_WINDOWS  = 0x00000002U,
    DEBUG_CLASS_IMAGE_FILE    = 0x00000003U,
}

enum : uint
{
    DEBUG_DUMP_SMALL      = 0x00000400U,
    DEBUG_DUMP_DEFAULT    = 0x00000401U,
    DEBUG_DUMP_FULL       = 0x00000402U,
    DEBUG_DUMP_IMAGE_FILE = 0x00000403U,
    DEBUG_DUMP_TRACE_LOG  = 0x00000404U,
    DEBUG_DUMP_WINDOWS_CE = 0x00000405U,
    DEBUG_DUMP_ACTIVE     = 0x00000406U,
}

enum : uint
{
    DEBUG_KERNEL_CONNECTION     = 0x00000000U,
    DEBUG_KERNEL_LOCAL          = 0x00000001U,
    DEBUG_KERNEL_EXDI_DRIVER    = 0x00000002U,
    DEBUG_KERNEL_IDNA           = 0x00000003U,
    DEBUG_KERNEL_INSTALL_DRIVER = 0x00000004U,
    DEBUG_KERNEL_REPT           = 0x00000005U,
    DEBUG_KERNEL_SMALL_DUMP     = 0x00000400U,
    DEBUG_KERNEL_DUMP           = 0x00000401U,
    DEBUG_KERNEL_ACTIVE_DUMP    = 0x00000406U,
    DEBUG_KERNEL_FULL_DUMP      = 0x00000402U,
    DEBUG_KERNEL_TRACE_LOG      = 0x00000404U,
}

enum : uint
{
    DEBUG_USER_WINDOWS_PROCESS         = 0x00000000U,
    DEBUG_USER_WINDOWS_PROCESS_SERVER  = 0x00000001U,
    DEBUG_USER_WINDOWS_IDNA            = 0x00000002U,
    DEBUG_USER_WINDOWS_REPT            = 0x00000003U,
    DEBUG_USER_WINDOWS_SMALL_DUMP      = 0x00000400U,
    DEBUG_USER_WINDOWS_DUMP            = 0x00000401U,
    DEBUG_USER_WINDOWS_DUMP_WINDOWS_CE = 0x00000405U,
}

enum uint DEBUG_EXTENSION_AT_ENGINE = 0x00000000U;

enum : uint
{
    DEBUG_EXECUTE_DEFAULT      = 0x00000000U,
    DEBUG_EXECUTE_ECHO         = 0x00000001U,
    DEBUG_EXECUTE_NOT_LOGGED   = 0x00000002U,
    DEBUG_EXECUTE_NO_REPEAT    = 0x00000004U,
    DEBUG_EXECUTE_USER_TYPED   = 0x00000008U,
    DEBUG_EXECUTE_USER_CLICKED = 0x00000010U,
    DEBUG_EXECUTE_EXTENSION    = 0x00000020U,
    DEBUG_EXECUTE_INTERNAL     = 0x00000040U,
    DEBUG_EXECUTE_SCRIPT       = 0x00000080U,
    DEBUG_EXECUTE_TOOLBAR      = 0x00000100U,
    DEBUG_EXECUTE_MENU         = 0x00000200U,
    DEBUG_EXECUTE_HOTKEY       = 0x00000400U,
    DEBUG_EXECUTE_EVENT        = 0x00000800U,
}

enum : uint
{
    DEBUG_FILTER_CREATE_THREAD       = 0x00000000U,
    DEBUG_FILTER_EXIT_THREAD         = 0x00000001U,
    DEBUG_FILTER_CREATE_PROCESS      = 0x00000002U,
    DEBUG_FILTER_EXIT_PROCESS        = 0x00000003U,
    DEBUG_FILTER_LOAD_MODULE         = 0x00000004U,
    DEBUG_FILTER_UNLOAD_MODULE       = 0x00000005U,
    DEBUG_FILTER_SYSTEM_ERROR        = 0x00000006U,
    DEBUG_FILTER_INITIAL_BREAKPOINT  = 0x00000007U,
    DEBUG_FILTER_INITIAL_MODULE_LOAD = 0x00000008U,
    DEBUG_FILTER_DEBUGGEE_OUTPUT     = 0x00000009U,
    DEBUG_FILTER_BREAK               = 0x00000000U,
    DEBUG_FILTER_SECOND_CHANCE_BREAK = 0x00000001U,
    DEBUG_FILTER_OUTPUT              = 0x00000002U,
    DEBUG_FILTER_IGNORE              = 0x00000003U,
    DEBUG_FILTER_REMOVE              = 0x00000004U,
    DEBUG_FILTER_GO_HANDLED          = 0x00000000U,
    DEBUG_FILTER_GO_NOT_HANDLED      = 0x00000001U,
}

enum uint DEBUG_WAIT_DEFAULT = 0x00000000U;

enum : uint
{
    DEBUG_VALUE_INVALID   = 0x00000000U,
    DEBUG_VALUE_INT8      = 0x00000001U,
    DEBUG_VALUE_INT16     = 0x00000002U,
    DEBUG_VALUE_INT32     = 0x00000003U,
    DEBUG_VALUE_INT64     = 0x00000004U,
    DEBUG_VALUE_FLOAT32   = 0x00000005U,
    DEBUG_VALUE_FLOAT64   = 0x00000006U,
    DEBUG_VALUE_FLOAT80   = 0x00000007U,
    DEBUG_VALUE_FLOAT82   = 0x00000008U,
    DEBUG_VALUE_FLOAT128  = 0x00000009U,
    DEBUG_VALUE_VECTOR64  = 0x0000000aU,
    DEBUG_VALUE_VECTOR128 = 0x0000000bU,
    DEBUG_VALUE_TYPES     = 0x0000000cU,
}

enum uint DEBUG_OUT_TEXT_REPL_DEFAULT = 0x00000000U;

enum : uint
{
    DEBUG_ASMOPT_DEFAULT             = 0x00000000U,
    DEBUG_ASMOPT_VERBOSE             = 0x00000001U,
    DEBUG_ASMOPT_NO_CODE_BYTES       = 0x00000002U,
    DEBUG_ASMOPT_IGNORE_OUTPUT_WIDTH = 0x00000004U,
    DEBUG_ASMOPT_SOURCE_LINE_NUMBER  = 0x00000008U,
}

enum : uint
{
    DEBUG_EXPR_MASM      = 0x00000000U,
    DEBUG_EXPR_CPLUSPLUS = 0x00000001U,
}

enum : uint
{
    DEBUG_EINDEX_NAME         = 0x00000000U,
    DEBUG_EINDEX_FROM_START   = 0x00000000U,
    DEBUG_EINDEX_FROM_END     = 0x00000001U,
    DEBUG_EINDEX_FROM_CURRENT = 0x00000002U,
}

enum : uint
{
    DEBUG_LOG_DEFAULT            = 0x00000000U,
    DEBUG_LOG_APPEND             = 0x00000001U,
    DEBUG_LOG_UNICODE            = 0x00000002U,
    DEBUG_LOG_DML                = 0x00000004U,
    DEBUG_SYSVERSTR_SERVICE_PACK = 0x00000000U,
    DEBUG_SYSVERSTR_BUILD        = 0x00000001U,
}

enum : uint
{
    DEBUG_MANAGED_DISABLED   = 0x00000000U,
    DEBUG_MANAGED_ALLOWED    = 0x00000001U,
    DEBUG_MANAGED_DLL_LOADED = 0x00000002U,
}

enum : uint
{
    DEBUG_MANSTR_NONE               = 0x00000000U,
    DEBUG_MANSTR_LOADED_SUPPORT_DLL = 0x00000001U,
    DEBUG_MANSTR_LOAD_STATUS        = 0x00000002U,
}

enum : uint
{
    DEBUG_MANRESET_DEFAULT  = 0x00000000U,
    DEBUG_MANRESET_LOAD_DLL = 0x00000001U,
}

enum uint DEBUG_EXEC_FLAGS_NONBLOCK = 0x00000001U;

enum : uint
{
    DEBUG_DATA_SPACE_VIRTUAL            = 0x00000000U,
    DEBUG_DATA_SPACE_PHYSICAL           = 0x00000001U,
    DEBUG_DATA_SPACE_CONTROL            = 0x00000002U,
    DEBUG_DATA_SPACE_IO                 = 0x00000003U,
    DEBUG_DATA_SPACE_MSR                = 0x00000004U,
    DEBUG_DATA_SPACE_BUS_DATA           = 0x00000005U,
    DEBUG_DATA_SPACE_DEBUGGER_DATA      = 0x00000006U,
    DEBUG_DATA_SPACE_COUNT              = 0x00000007U,
    DEBUG_DATA_KernBase                 = 0x00000018U,
    DEBUG_DATA_BreakpointWithStatusAddr = 0x00000020U,
}

enum : uint
{
    DEBUG_DATA_SavedContextAddr             = 0x00000028U,
    DEBUG_DATA_KiCallUserModeAddr           = 0x00000038U,
    DEBUG_DATA_KeUserCallbackDispatcherAddr = 0x00000040U,
}

enum uint DEBUG_DATA_PsLoadedModuleListAddr = 0x00000048U;
enum uint DEBUG_DATA_PsActiveProcessHeadAddr = 0x00000050U;

enum : uint
{
    DEBUG_DATA_PspCidTableAddr            = 0x00000058U,
    DEBUG_DATA_ExpSystemResourcesListAddr = 0x00000060U,
}

enum uint DEBUG_DATA_ExpPagedPoolDescriptorAddr = 0x00000068U;
enum uint DEBUG_DATA_ExpNumberOfPagedPoolsAddr = 0x00000070U;

enum : uint
{
    DEBUG_DATA_KeTimeIncrementAddr            = 0x00000078U,
    DEBUG_DATA_KeBugCheckCallbackListHeadAddr = 0x00000080U,
}

enum uint DEBUG_DATA_KiBugcheckDataAddr = 0x00000088U;
enum uint DEBUG_DATA_IopErrorLogListHeadAddr = 0x00000090U;
enum uint DEBUG_DATA_ObpRootDirectoryObjectAddr = 0x00000098U;
enum uint DEBUG_DATA_ObpTypeObjectTypeAddr = 0x000000a0U;

enum : uint
{
    DEBUG_DATA_MmSystemCacheStartAddr    = 0x000000a8U,
    DEBUG_DATA_MmSystemCacheEndAddr      = 0x000000b0U,
    DEBUG_DATA_MmSystemCacheWsAddr       = 0x000000b8U,
    DEBUG_DATA_MmPfnDatabaseAddr         = 0x000000c0U,
    DEBUG_DATA_MmSystemPtesStartAddr     = 0x000000c8U,
    DEBUG_DATA_MmSystemPtesEndAddr       = 0x000000d0U,
    DEBUG_DATA_MmSubsectionBaseAddr      = 0x000000d8U,
    DEBUG_DATA_MmNumberOfPagingFilesAddr = 0x000000e0U,
}

enum uint DEBUG_DATA_MmLowestPhysicalPageAddr = 0x000000e8U;
enum uint DEBUG_DATA_MmHighestPhysicalPageAddr = 0x000000f0U;
enum uint DEBUG_DATA_MmNumberOfPhysicalPagesAddr = 0x000000f8U;
enum uint DEBUG_DATA_MmMaximumNonPagedPoolInBytesAddr = 0x00000100U;

enum : uint
{
    DEBUG_DATA_MmNonPagedSystemStartAddr    = 0x00000108U,
    DEBUG_DATA_MmNonPagedPoolStartAddr      = 0x00000110U,
    DEBUG_DATA_MmNonPagedPoolEndAddr        = 0x00000118U,
    DEBUG_DATA_MmPagedPoolStartAddr         = 0x00000120U,
    DEBUG_DATA_MmPagedPoolEndAddr           = 0x00000128U,
    DEBUG_DATA_MmPagedPoolInformationAddr   = 0x00000130U,
    DEBUG_DATA_MmPageSize                   = 0x00000138U,
    DEBUG_DATA_MmSizeOfPagedPoolInBytesAddr = 0x00000140U,
}

enum : uint
{
    DEBUG_DATA_MmTotalCommitLimitAddr    = 0x00000148U,
    DEBUG_DATA_MmTotalCommittedPagesAddr = 0x00000150U,
}

enum : uint
{
    DEBUG_DATA_MmSharedCommitAddr       = 0x00000158U,
    DEBUG_DATA_MmDriverCommitAddr       = 0x00000160U,
    DEBUG_DATA_MmProcessCommitAddr      = 0x00000168U,
    DEBUG_DATA_MmPagedPoolCommitAddr    = 0x00000170U,
    DEBUG_DATA_MmExtendedCommitAddr     = 0x00000178U,
    DEBUG_DATA_MmZeroedPageListHeadAddr = 0x00000180U,
}

enum uint DEBUG_DATA_MmFreePageListHeadAddr = 0x00000188U;
enum uint DEBUG_DATA_MmStandbyPageListHeadAddr = 0x00000190U;

enum : uint
{
    DEBUG_DATA_MmModifiedPageListHeadAddr        = 0x00000198U,
    DEBUG_DATA_MmModifiedNoWritePageListHeadAddr = 0x000001a0U,
}

enum : uint
{
    DEBUG_DATA_MmAvailablePagesAddr         = 0x000001a8U,
    DEBUG_DATA_MmResidentAvailablePagesAddr = 0x000001b0U,
}

enum uint DEBUG_DATA_PoolTrackTableAddr = 0x000001b8U;
enum uint DEBUG_DATA_NonPagedPoolDescriptorAddr = 0x000001c0U;
enum uint DEBUG_DATA_MmHighestUserAddressAddr = 0x000001c8U;
enum uint DEBUG_DATA_MmSystemRangeStartAddr = 0x000001d0U;
enum uint DEBUG_DATA_MmUserProbeAddressAddr = 0x000001d8U;

enum : uint
{
    DEBUG_DATA_KdPrintCircularBufferAddr    = 0x000001e0U,
    DEBUG_DATA_KdPrintCircularBufferEndAddr = 0x000001e8U,
    DEBUG_DATA_KdPrintWritePointerAddr      = 0x000001f0U,
    DEBUG_DATA_KdPrintRolloverCountAddr     = 0x000001f8U,
}

enum uint DEBUG_DATA_MmLoadedUserImageListAddr = 0x00000200U;

enum : uint
{
    DEBUG_DATA_NtBuildLabAddr       = 0x00000208U,
    DEBUG_DATA_KiNormalSystemCall   = 0x00000210U,
    DEBUG_DATA_KiProcessorBlockAddr = 0x00000218U,
}

enum : uint
{
    DEBUG_DATA_MmUnloadedDriversAddr    = 0x00000220U,
    DEBUG_DATA_MmLastUnloadedDriverAddr = 0x00000228U,
}

enum uint DEBUG_DATA_MmTriageActionTakenAddr = 0x00000230U;
enum uint DEBUG_DATA_MmSpecialPoolTagAddr = 0x00000238U;
enum uint DEBUG_DATA_KernelVerifierAddr = 0x00000240U;

enum : uint
{
    DEBUG_DATA_MmVerifierDataAddr          = 0x00000248U,
    DEBUG_DATA_MmAllocatedNonPagedPoolAddr = 0x00000250U,
}

enum : uint
{
    DEBUG_DATA_MmPeakCommitmentAddr          = 0x00000258U,
    DEBUG_DATA_MmTotalCommitLimitMaximumAddr = 0x00000260U,
}

enum uint DEBUG_DATA_CmNtCSDVersionAddr = 0x00000268U;
enum uint DEBUG_DATA_MmPhysicalMemoryBlockAddr = 0x00000270U;

enum : uint
{
    DEBUG_DATA_MmSessionBase           = 0x00000278U,
    DEBUG_DATA_MmSessionSize           = 0x00000280U,
    DEBUG_DATA_MmSystemParentTablePage = 0x00000288U,
}

enum uint DEBUG_DATA_MmVirtualTranslationBase = 0x00000290U;

enum : uint
{
    DEBUG_DATA_OffsetKThreadNextProcessor = 0x00000298U,
    DEBUG_DATA_OffsetKThreadTeb           = 0x0000029aU,
    DEBUG_DATA_OffsetKThreadKernelStack   = 0x0000029cU,
    DEBUG_DATA_OffsetKThreadInitialStack  = 0x0000029eU,
    DEBUG_DATA_OffsetKThreadApcProcess    = 0x000002a0U,
    DEBUG_DATA_OffsetKThreadState         = 0x000002a2U,
    DEBUG_DATA_OffsetKThreadBStore        = 0x000002a4U,
    DEBUG_DATA_OffsetKThreadBStoreLimit   = 0x000002a6U,
}

enum : uint
{
    DEBUG_DATA_SizeEProcess                     = 0x000002a8U,
    DEBUG_DATA_OffsetEprocessPeb                = 0x000002aaU,
    DEBUG_DATA_OffsetEprocessParentCID          = 0x000002acU,
    DEBUG_DATA_OffsetEprocessDirectoryTableBase = 0x000002aeU,
}

enum : uint
{
    DEBUG_DATA_SizePrcb                     = 0x000002b0U,
    DEBUG_DATA_OffsetPrcbDpcRoutine         = 0x000002b2U,
    DEBUG_DATA_OffsetPrcbCurrentThread      = 0x000002b4U,
    DEBUG_DATA_OffsetPrcbMhz                = 0x000002b6U,
    DEBUG_DATA_OffsetPrcbCpuType            = 0x000002b8U,
    DEBUG_DATA_OffsetPrcbVendorString       = 0x000002baU,
    DEBUG_DATA_OffsetPrcbProcessorState     = 0x000002bcU,
    DEBUG_DATA_OffsetPrcbNumber             = 0x000002beU,
    DEBUG_DATA_SizeEThread                  = 0x000002c0U,
    DEBUG_DATA_KdPrintCircularBufferPtrAddr = 0x000002c8U,
    DEBUG_DATA_KdPrintBufferSizeAddr        = 0x000002d0U,
}

enum uint DEBUG_DATA_MmBadPagesDetected = 0x00000320U;

enum : uint
{
    DEBUG_DATA_EtwpDebuggerData                = 0x00000330U,
    DEBUG_DATA_PteBase                         = 0x00000360U,
    DEBUG_DATA_PaeEnabled                      = 0x000186a0U,
    DEBUG_DATA_SharedUserData                  = 0x000186a8U,
    DEBUG_DATA_ProductType                     = 0x000186b0U,
    DEBUG_DATA_SuiteMask                       = 0x000186b8U,
    DEBUG_DATA_DumpWriterStatus                = 0x000186c0U,
    DEBUG_DATA_DumpFormatVersion               = 0x000186c8U,
    DEBUG_DATA_DumpWriterVersion               = 0x000186d0U,
    DEBUG_DATA_DumpPowerState                  = 0x000186d8U,
    DEBUG_DATA_DumpMmStorage                   = 0x000186e0U,
    DEBUG_DATA_DumpAttributes                  = 0x000186e8U,
    DEBUG_DATA_PagingLevels                    = 0x000186f0U,
    DEBUG_DATA_KPCR_OFFSET                     = 0x00000000U,
    DEBUG_DATA_KPRCB_OFFSET                    = 0x00000001U,
    DEBUG_DATA_KTHREAD_OFFSET                  = 0x00000002U,
    DEBUG_DATA_BASE_TRANSLATION_VIRTUAL_OFFSET = 0x00000003U,
}

enum : uint
{
    DEBUG_DATA_PROCESSOR_IDENTIFICATION = 0x00000004U,
    DEBUG_DATA_PROCESSOR_SPEED          = 0x00000005U,
}

enum : uint
{
    DEBUG_HANDLE_DATA_TYPE_BASIC                 = 0x00000000U,
    DEBUG_HANDLE_DATA_TYPE_TYPE_NAME             = 0x00000001U,
    DEBUG_HANDLE_DATA_TYPE_OBJECT_NAME           = 0x00000002U,
    DEBUG_HANDLE_DATA_TYPE_HANDLE_COUNT          = 0x00000003U,
    DEBUG_HANDLE_DATA_TYPE_TYPE_NAME_WIDE        = 0x00000004U,
    DEBUG_HANDLE_DATA_TYPE_OBJECT_NAME_WIDE      = 0x00000005U,
    DEBUG_HANDLE_DATA_TYPE_MINI_THREAD_1         = 0x00000006U,
    DEBUG_HANDLE_DATA_TYPE_MINI_MUTANT_1         = 0x00000007U,
    DEBUG_HANDLE_DATA_TYPE_MINI_MUTANT_2         = 0x00000008U,
    DEBUG_HANDLE_DATA_TYPE_PER_HANDLE_OPERATIONS = 0x00000009U,
    DEBUG_HANDLE_DATA_TYPE_ALL_HANDLE_OPERATIONS = 0x0000000aU,
    DEBUG_HANDLE_DATA_TYPE_MINI_PROCESS_1        = 0x0000000bU,
    DEBUG_HANDLE_DATA_TYPE_MINI_PROCESS_2        = 0x0000000cU,
    DEBUG_HANDLE_DATA_TYPE_MINI_EVENT_1          = 0x0000000dU,
    DEBUG_HANDLE_DATA_TYPE_MINI_SECTION_1        = 0x0000000eU,
    DEBUG_HANDLE_DATA_TYPE_MINI_SEMAPHORE_1      = 0x0000000fU,
}

enum uint DEBUG_OFFSINFO_VIRTUAL_SOURCE = 0x00000001U;

enum : uint
{
    DEBUG_VSOURCE_INVALID              = 0x00000000U,
    DEBUG_VSOURCE_DEBUGGEE             = 0x00000001U,
    DEBUG_VSOURCE_MAPPED_IMAGE         = 0x00000002U,
    DEBUG_VSOURCE_DUMP_WITHOUT_MEMINFO = 0x00000003U,
}

enum : uint
{
    DEBUG_VSEARCH_DEFAULT       = 0x00000000U,
    DEBUG_VSEARCH_WRITABLE_ONLY = 0x00000001U,
}

enum : uint
{
    DEBUG_PHYSICAL_DEFAULT        = 0x00000000U,
    DEBUG_PHYSICAL_CACHED         = 0x00000001U,
    DEBUG_PHYSICAL_UNCACHED       = 0x00000002U,
    DEBUG_PHYSICAL_WRITE_COMBINED = 0x00000003U,
}

enum : uint
{
    DEBUG_EVENT_BREAKPOINT            = 0x00000001U,
    DEBUG_EVENT_EXCEPTION             = 0x00000002U,
    DEBUG_EVENT_CREATE_THREAD         = 0x00000004U,
    DEBUG_EVENT_EXIT_THREAD           = 0x00000008U,
    DEBUG_EVENT_CREATE_PROCESS        = 0x00000010U,
    DEBUG_EVENT_EXIT_PROCESS          = 0x00000020U,
    DEBUG_EVENT_LOAD_MODULE           = 0x00000040U,
    DEBUG_EVENT_UNLOAD_MODULE         = 0x00000080U,
    DEBUG_EVENT_SYSTEM_ERROR          = 0x00000100U,
    DEBUG_EVENT_SESSION_STATUS        = 0x00000200U,
    DEBUG_EVENT_CHANGE_DEBUGGEE_STATE = 0x00000400U,
    DEBUG_EVENT_CHANGE_ENGINE_STATE   = 0x00000800U,
    DEBUG_EVENT_CHANGE_SYMBOL_STATE   = 0x00001000U,
}

enum uint DEBUG_EVENT_SERVICE_EXCEPTION = 0x00002000U;

enum : uint
{
    DEBUG_SESSION_ACTIVE                       = 0x00000000U,
    DEBUG_SESSION_END_SESSION_ACTIVE_TERMINATE = 0x00000001U,
    DEBUG_SESSION_END_SESSION_ACTIVE_DETACH    = 0x00000002U,
    DEBUG_SESSION_END_SESSION_PASSIVE          = 0x00000003U,
    DEBUG_SESSION_END                          = 0x00000004U,
    DEBUG_SESSION_REBOOT                       = 0x00000005U,
    DEBUG_SESSION_HIBERNATE                    = 0x00000006U,
    DEBUG_SESSION_FAILURE                      = 0x00000007U,
}

enum : uint
{
    DEBUG_CDS_ALL                              = 0xffffffffU,
    DEBUG_CDS_REGISTERS                        = 0x00000001U,
    DEBUG_CDS_DATA                             = 0x00000002U,
    DEBUG_CDS_REFRESH                          = 0x00000004U,
    DEBUG_CDS_REFRESH_EVALUATE                 = 0x00000001U,
    DEBUG_CDS_REFRESH_EXECUTE                  = 0x00000002U,
    DEBUG_CDS_REFRESH_EXECUTECOMMANDFILE       = 0x00000003U,
    DEBUG_CDS_REFRESH_ADDBREAKPOINT            = 0x00000004U,
    DEBUG_CDS_REFRESH_REMOVEBREAKPOINT         = 0x00000005U,
    DEBUG_CDS_REFRESH_WRITEVIRTUAL             = 0x00000006U,
    DEBUG_CDS_REFRESH_WRITEVIRTUALUNCACHED     = 0x00000007U,
    DEBUG_CDS_REFRESH_WRITEPHYSICAL            = 0x00000008U,
    DEBUG_CDS_REFRESH_WRITEPHYSICAL2           = 0x00000009U,
    DEBUG_CDS_REFRESH_SETVALUE                 = 0x0000000aU,
    DEBUG_CDS_REFRESH_SETVALUE2                = 0x0000000bU,
    DEBUG_CDS_REFRESH_SETSCOPE                 = 0x0000000cU,
    DEBUG_CDS_REFRESH_SETSCOPEFRAMEBYINDEX     = 0x0000000dU,
    DEBUG_CDS_REFRESH_SETSCOPEFROMJITDEBUGINFO = 0x0000000eU,
    DEBUG_CDS_REFRESH_SETSCOPEFROMSTOREDEVENT  = 0x0000000fU,
    DEBUG_CDS_REFRESH_INLINESTEP               = 0x00000010U,
    DEBUG_CDS_REFRESH_INLINESTEP_PSEUDO        = 0x00000011U,
}

enum : uint
{
    DEBUG_CES_ALL                 = 0xffffffffU,
    DEBUG_CES_CURRENT_THREAD      = 0x00000001U,
    DEBUG_CES_EFFECTIVE_PROCESSOR = 0x00000002U,
}

enum : uint
{
    DEBUG_CES_BREAKPOINTS      = 0x00000004U,
    DEBUG_CES_CODE_LEVEL       = 0x00000008U,
    DEBUG_CES_EXECUTION_STATUS = 0x00000010U,
    DEBUG_CES_ENGINE_OPTIONS   = 0x00000020U,
    DEBUG_CES_LOG_FILE         = 0x00000040U,
    DEBUG_CES_RADIX            = 0x00000080U,
    DEBUG_CES_EVENT_FILTERS    = 0x00000100U,
    DEBUG_CES_PROCESS_OPTIONS  = 0x00000200U,
}

enum : uint
{
    DEBUG_CES_EXTENSIONS       = 0x00000400U,
    DEBUG_CES_SYSTEMS          = 0x00000800U,
    DEBUG_CES_ASSEMBLY_OPTIONS = 0x00001000U,
}

enum uint DEBUG_CES_EXPRESSION_SYNTAX = 0x00002000U;
enum uint DEBUG_CES_TEXT_REPLACEMENTS = 0x00004000U;

enum : uint
{
    DEBUG_CSS_ALL               = 0xffffffffU,
    DEBUG_CSS_LOADS             = 0x00000001U,
    DEBUG_CSS_UNLOADS           = 0x00000002U,
    DEBUG_CSS_SCOPE             = 0x00000004U,
    DEBUG_CSS_PATHS             = 0x00000008U,
    DEBUG_CSS_SYMBOL_OPTIONS    = 0x00000010U,
    DEBUG_CSS_TYPE_OPTIONS      = 0x00000020U,
    DEBUG_CSS_COLLAPSE_CHILDREN = 0x00000040U,
}

enum : uint
{
    DEBUG_OUTCBI_EXPLICIT_FLUSH          = 0x00000001U,
    DEBUG_OUTCBI_TEXT                    = 0x00000002U,
    DEBUG_OUTCBI_DML                     = 0x00000004U,
    DEBUG_OUTCBI_ANY_FORMAT              = 0x00000006U,
    DEBUG_OUTCB_TEXT                     = 0x00000000U,
    DEBUG_OUTCB_DML                      = 0x00000001U,
    DEBUG_OUTCB_EXPLICIT_FLUSH           = 0x00000002U,
    DEBUG_OUTCBF_COMBINED_EXPLICIT_FLUSH = 0x00000001U,
}

enum : uint
{
    DEBUG_OUTCBF_DML_HAS_TAGS               = 0x00000002U,
    DEBUG_OUTCBF_DML_HAS_SPECIAL_CHARACTERS = 0x00000004U,
}

enum : uint
{
    DEBUG_REGISTERS_DEFAULT     = 0x00000000U,
    DEBUG_REGISTERS_INT32       = 0x00000001U,
    DEBUG_REGISTERS_INT64       = 0x00000002U,
    DEBUG_REGISTERS_FLOAT       = 0x00000004U,
    DEBUG_REGISTERS_ALL         = 0x00000007U,
    DEBUG_REGISTER_SUB_REGISTER = 0x00000001U,
}

enum : uint
{
    DEBUG_REGSRC_DEBUGGEE = 0x00000000U,
    DEBUG_REGSRC_EXPLICIT = 0x00000001U,
    DEBUG_REGSRC_FRAME    = 0x00000002U,
}

enum : uint
{
    DEBUG_OUTPUT_SYMBOLS_DEFAULT    = 0x00000000U,
    DEBUG_OUTPUT_SYMBOLS_NO_NAMES   = 0x00000001U,
    DEBUG_OUTPUT_SYMBOLS_NO_OFFSETS = 0x00000002U,
    DEBUG_OUTPUT_SYMBOLS_NO_VALUES  = 0x00000004U,
    DEBUG_OUTPUT_SYMBOLS_NO_TYPES   = 0x00000010U,
}

enum : const(wchar)*
{
    // Native encoding: ansi
    DEBUG_OUTPUT_NAME_END        = "**NAME**",
    // Native encoding: ansi
    DEBUG_OUTPUT_OFFSET_END      = "**OFF**",
    // Native encoding: ansi
    DEBUG_OUTPUT_VALUE_END       = "**VALUE**",
    // Native encoding: ansi
    DEBUG_OUTPUT_TYPE_END        = "**TYPE**",
    DEBUG_OUTPUT_NAME_END_WIDE   = "**NAME**",
    DEBUG_OUTPUT_OFFSET_END_WIDE = "**OFF**",
    DEBUG_OUTPUT_VALUE_END_WIDE  = "**VALUE**",
    DEBUG_OUTPUT_TYPE_END_WIDE   = "**TYPE**",
    DEBUG_OUTPUT_NAME_END_T      = "**NAME**",
    DEBUG_OUTPUT_OFFSET_END_T    = "**OFF**",
    DEBUG_OUTPUT_VALUE_END_T     = "**VALUE**",
    DEBUG_OUTPUT_TYPE_END_T      = "**TYPE**",
}

enum : uint
{
    DEBUG_SYMBOL_EXPANSION_LEVEL_MASK = 0x0000000fU,
    DEBUG_SYMBOL_EXPANDED             = 0x00000010U,
    DEBUG_SYMBOL_READ_ONLY            = 0x00000020U,
    DEBUG_SYMBOL_IS_ARRAY             = 0x00000040U,
    DEBUG_SYMBOL_IS_FLOAT             = 0x00000080U,
    DEBUG_SYMBOL_IS_ARGUMENT          = 0x00000100U,
    DEBUG_SYMBOL_IS_LOCAL             = 0x00000200U,
    DEBUG_SYMENT_IS_CODE              = 0x00000001U,
    DEBUG_SYMENT_IS_DATA              = 0x00000002U,
    DEBUG_SYMENT_IS_PARAMETER         = 0x00000004U,
    DEBUG_SYMENT_IS_LOCAL             = 0x00000008U,
    DEBUG_SYMENT_IS_MANAGED           = 0x00000010U,
    DEBUG_SYMENT_IS_SYNTHETIC         = 0x00000020U,
}

enum : uint
{
    DEBUG_MODULE_LOADED           = 0x00000000U,
    DEBUG_MODULE_UNLOADED         = 0x00000001U,
    DEBUG_MODULE_USER_MODE        = 0x00000002U,
    DEBUG_MODULE_EXE_MODULE       = 0x00000004U,
    DEBUG_MODULE_EXPLICIT         = 0x00000008U,
    DEBUG_MODULE_SECONDARY        = 0x00000010U,
    DEBUG_MODULE_SYNTHETIC        = 0x00000020U,
    DEBUG_MODULE_SYM_BAD_CHECKSUM = 0x00010000U,
}

enum : uint
{
    DEBUG_SYMTYPE_NONE             = 0x00000000U,
    DEBUG_SYMTYPE_COFF             = 0x00000001U,
    DEBUG_SYMTYPE_CODEVIEW         = 0x00000002U,
    DEBUG_SYMTYPE_PDB              = 0x00000003U,
    DEBUG_SYMTYPE_EXPORT           = 0x00000004U,
    DEBUG_SYMTYPE_DEFERRED         = 0x00000005U,
    DEBUG_SYMTYPE_SYM              = 0x00000006U,
    DEBUG_SYMTYPE_DIA              = 0x00000007U,
    DEBUG_SCOPE_GROUP_ARGUMENTS    = 0x00000001U,
    DEBUG_SCOPE_GROUP_LOCALS       = 0x00000002U,
    DEBUG_SCOPE_GROUP_ALL          = 0x00000003U,
    DEBUG_SCOPE_GROUP_BY_DATAMODEL = 0x00000004U,
}

enum : uint
{
    DEBUG_OUTTYPE_DEFAULT          = 0x00000000U,
    DEBUG_OUTTYPE_NO_INDENT        = 0x00000001U,
    DEBUG_OUTTYPE_NO_OFFSET        = 0x00000002U,
    DEBUG_OUTTYPE_VERBOSE          = 0x00000004U,
    DEBUG_OUTTYPE_COMPACT_OUTPUT   = 0x00000008U,
    DEBUG_OUTTYPE_ADDRESS_OF_FIELD = 0x00010000U,
    DEBUG_OUTTYPE_ADDRESS_AT_END   = 0x00020000U,
    DEBUG_OUTTYPE_BLOCK_RECURSE    = 0x00200000U,
}

enum : uint
{
    DEBUG_FIND_SOURCE_DEFAULT              = 0x00000000U,
    DEBUG_FIND_SOURCE_FULL_PATH            = 0x00000001U,
    DEBUG_FIND_SOURCE_BEST_MATCH           = 0x00000002U,
    DEBUG_FIND_SOURCE_NO_SRCSRV            = 0x00000004U,
    DEBUG_FIND_SOURCE_TOKEN_LOOKUP         = 0x00000008U,
    DEBUG_FIND_SOURCE_WITH_CHECKSUM        = 0x00000010U,
    DEBUG_FIND_SOURCE_WITH_CHECKSUM_STRICT = 0x00000020U,
}

enum : uint
{
    MODULE_ORDERS_MASK       = 0xf0000000U,
    MODULE_ORDERS_LOADTIME   = 0x10000000U,
    MODULE_ORDERS_MODULENAME = 0x20000000U,
}

enum : uint
{
    DEBUG_MODNAME_IMAGE        = 0x00000000U,
    DEBUG_MODNAME_MODULE       = 0x00000001U,
    DEBUG_MODNAME_LOADED_IMAGE = 0x00000002U,
    DEBUG_MODNAME_SYMBOL_FILE  = 0x00000003U,
    DEBUG_MODNAME_MAPPED_IMAGE = 0x00000004U,
}

enum : uint
{
    DEBUG_TYPEOPTS_UNICODE_DISPLAY    = 0x00000001U,
    DEBUG_TYPEOPTS_LONGSTATUS_DISPLAY = 0x00000002U,
    DEBUG_TYPEOPTS_FORCERADIX_OUTPUT  = 0x00000004U,
    DEBUG_TYPEOPTS_MATCH_MAXSIZE      = 0x00000008U,
}

enum : uint
{
    DEBUG_GETMOD_DEFAULT             = 0x00000000U,
    DEBUG_GETMOD_NO_LOADED_MODULES   = 0x00000001U,
    DEBUG_GETMOD_NO_UNLOADED_MODULES = 0x00000002U,
}

enum : uint
{
    DEBUG_ADDSYNTHMOD_DEFAULT  = 0x00000000U,
    DEBUG_ADDSYNTHMOD_ZEROBASE = 0x00000001U,
    DEBUG_ADDSYNTHSYM_DEFAULT  = 0x00000000U,
}

enum : uint
{
    DEBUG_OUTSYM_DEFAULT            = 0x00000000U,
    DEBUG_OUTSYM_FORCE_OFFSET       = 0x00000001U,
    DEBUG_OUTSYM_SOURCE_LINE        = 0x00000002U,
    DEBUG_OUTSYM_ALLOW_DISPLACEMENT = 0x00000004U,
}

enum : uint
{
    DEBUG_GETFNENT_DEFAULT        = 0x00000000U,
    DEBUG_GETFNENT_RAW_ENTRY_ONLY = 0x00000001U,
}

enum uint DEBUG_SOURCE_IS_STATEMENT = 0x00000001U;

enum : uint
{
    DEBUG_GSEL_DEFAULT         = 0x00000000U,
    DEBUG_GSEL_NO_SYMBOL_LOADS = 0x00000001U,
    DEBUG_GSEL_ALLOW_LOWER     = 0x00000002U,
    DEBUG_GSEL_ALLOW_HIGHER    = 0x00000004U,
    DEBUG_GSEL_NEAREST_ONLY    = 0x00000008U,
    DEBUG_GSEL_INLINE_CALLSITE = 0x00000010U,
}

enum : uint
{
    DEBUG_FRAME_DEFAULT       = 0x00000000U,
    DEBUG_FRAME_IGNORE_INLINE = 0x00000001U,
}

enum uint DEBUG_COMMAND_EXCEPTION_ID = 0xdbe00dbeU;

enum : uint
{
    DEBUG_CMDEX_INVALID             = 0x00000000U,
    DEBUG_CMDEX_ADD_EVENT_STRING    = 0x00000001U,
    DEBUG_CMDEX_RESET_EVENT_STRINGS = 0x00000002U,
}

enum uint DEBUG_EXTINIT_HAS_COMMAND_HELP = 0x00000001U;

enum : uint
{
    DEBUG_NOTIFY_SESSION_ACTIVE       = 0x00000000U,
    DEBUG_NOTIFY_SESSION_INACTIVE     = 0x00000001U,
    DEBUG_NOTIFY_SESSION_ACCESSIBLE   = 0x00000002U,
    DEBUG_NOTIFY_SESSION_INACCESSIBLE = 0x00000003U,
}

enum : uint
{
    DEBUG_KNOWN_STRUCT_GET_NAMES              = 0x00000001U,
    DEBUG_KNOWN_STRUCT_GET_SINGLE_LINE_OUTPUT = 0x00000002U,
    DEBUG_KNOWN_STRUCT_SUPPRESS_TYPE_NAME     = 0x00000003U,
}

enum : uint
{
    DEBUG_EXT_QVALUE_DEFAULT    = 0x00000000U,
    DEBUG_EXT_PVALUE_DEFAULT    = 0x00000000U,
    DEBUG_EXT_PVTYPE_IS_VALUE   = 0x00000000U,
    DEBUG_EXT_PVTYPE_IS_POINTER = 0x00000001U,
}

enum uint _EXTSAPI_VER_ = 0x0000000aU;

enum : uint
{
    DUMP_HANDLE_FLAG_PRINT_OBJECT     = 0x00000002U,
    DUMP_HANDLE_FLAG_PRINT_FREE_ENTRY = 0x00000004U,
    DUMP_HANDLE_FLAG_KERNEL_TABLE     = 0x00000010U,
    DUMP_HANDLE_FLAG_CID_TABLE        = 0x00000020U,
}

enum uint KDEXTS_LOCK_CALLBACKROUTINE_DEFINED = 0x00000002U;

enum : uint
{
    FAILURE_ANALYSIS_NO_DB_LOOKUP                   = 0x00000001U,
    FAILURE_ANALYSIS_VERBOSE                        = 0x00000002U,
    FAILURE_ANALYSIS_ASSUME_HANG                    = 0x00000004U,
    FAILURE_ANALYSIS_IGNORE_BREAKIN                 = 0x00000008U,
    FAILURE_ANALYSIS_SET_FAILURE_CONTEXT            = 0x00000010U,
    FAILURE_ANALYSIS_EXCEPTION_AS_HANG              = 0x00000020U,
    FAILURE_ANALYSIS_AUTOBUG_PROCESSING             = 0x00000040U,
    FAILURE_ANALYSIS_XML_OUTPUT                     = 0x00000080U,
    FAILURE_ANALYSIS_CALLSTACK_XML                  = 0x00000100U,
    FAILURE_ANALYSIS_REGISTRY_DATA                  = 0x00000200U,
    FAILURE_ANALYSIS_WMI_QUERY_DATA                 = 0x00000400U,
    FAILURE_ANALYSIS_USER_ATTRIBUTES                = 0x00000800U,
    FAILURE_ANALYSIS_MODULE_INFO_XML                = 0x00001000U,
    FAILURE_ANALYSIS_NO_IMAGE_CORRUPTION            = 0x00002000U,
    FAILURE_ANALYSIS_AUTOSET_SYMPATH                = 0x00004000U,
    FAILURE_ANALYSIS_USER_ATTRIBUTES_ALL            = 0x00008000U,
    FAILURE_ANALYSIS_USER_ATTRIBUTES_FRAMES         = 0x00010000U,
    FAILURE_ANALYSIS_MULTI_TARGET                   = 0x00020000U,
    FAILURE_ANALYSIS_SHOW_SOURCE                    = 0x00040000U,
    FAILURE_ANALYSIS_SHOW_WCT_STACKS                = 0x00080000U,
    FAILURE_ANALYSIS_CREATE_INSTANCE                = 0x00100000U,
    FAILURE_ANALYSIS_LIVE_DEBUG_HOLD_CHECK          = 0x00200000U,
    FAILURE_ANALYSIS_XML_FILE_OUTPUT                = 0x00400000U,
    FAILURE_ANALYSIS_XSD_VERIFY                     = 0x00800000U,
    FAILURE_ANALYSIS_CALLSTACK_XML_FULL_SOURCE_INFO = 0x01000000U,
}

enum uint FAILURE_ANALYSIS_HEAP_CORRUPTION_BLAME_FUNCTION = 0x02000000U;
enum uint FAILURE_ANALYSIS_PERMIT_HEAP_ACCESS_VIOLATIONS = 0x04000000U;

enum : uint
{
    FAILURE_ANALYSIS_XSLT_FILE_INPUT  = 0x10000000U,
    FAILURE_ANALYSIS_XSLT_FILE_OUTPUT = 0x20000000U,
}

enum : GUID
{
    CLSID_DebugFailureAnalysisBasic   = GUID("b74eed7f-1c7d-4c1b-959f-b96dd9175aa4"),
    CLSID_DebugFailureAnalysisTarget  = GUID("ba9bfb05-ef75-4bbd-a745-a6b5529458b8"),
    CLSID_DebugFailureAnalysisUser    = GUID("e60b0c93-cf49-4a32-8147-0362202dc56b"),
    CLSID_DebugFailureAnalysisKernel  = GUID("ee433078-64af-4c33-ab2f-ecad7f2a002d"),
    CLSID_DebugFailureAnalysisWinCE   = GUID("67d5e86f-f5e2-462a-9233-1bd616fcc7e8"),
    CLSID_DebugFailureAnalysisXBox360 = GUID("901625bb-95f1-4318-ac80-9d733cee8c8b"),
}

enum uint CROSS_PLATFORM_MAXIMUM_PROCESSORS = 0x00000800U;
enum uint MAX_STACK_IN_BYTES = 0x00001000U;

enum : uint
{
    TRIAGE_FOLLOWUP_FAIL    = 0x00000000U,
    TRIAGE_FOLLOWUP_IGNORE  = 0x00000001U,
    TRIAGE_FOLLOWUP_DEFAULT = 0x00000002U,
    TRIAGE_FOLLOWUP_SUCCESS = 0x00000003U,
}

enum : uint
{
    EXT_ANALYZER_FLAG_MOD = 0x00000001U,
    EXT_ANALYZER_FLAG_ID  = 0x00000002U,
}

enum : uint
{
    EXTDLL_DATA_QUERY_BUILD_BINDIR             = 0x00000001U,
    EXTDLL_DATA_QUERY_BUILD_SYMDIR             = 0x00000002U,
    EXTDLL_DATA_QUERY_BUILD_WOW64SYMDIR        = 0x00000003U,
    EXTDLL_DATA_QUERY_BUILD_WOW64BINDIR        = 0x00000004U,
    EXTDLL_DATA_QUERY_BUILD_BINDIR_SYMSRV      = 0x0000000bU,
    EXTDLL_DATA_QUERY_BUILD_SYMDIR_SYMSRV      = 0x0000000cU,
    EXTDLL_DATA_QUERY_BUILD_WOW64SYMDIR_SYMSRV = 0x0000000dU,
    EXTDLL_DATA_QUERY_BUILD_WOW64BINDIR_SYMSRV = 0x0000000eU,
}

enum : uint
{
    EXT_API_VERSION_NUMBER   = 0x00000005U,
    EXT_API_VERSION_NUMBER32 = 0x00000005U,
    EXT_API_VERSION_NUMBER64 = 0x00000006U,
}

enum uint IG_KD_CONTEXT = 0x00000001U;
enum uint IG_READ_CONTROL_SPACE = 0x00000002U;
enum uint IG_WRITE_CONTROL_SPACE = 0x00000003U;
enum uint IG_READ_IO_SPACE = 0x00000004U;
enum uint IG_WRITE_IO_SPACE = 0x00000005U;
enum uint IG_READ_PHYSICAL = 0x00000006U;
enum uint IG_WRITE_PHYSICAL = 0x00000007U;
enum uint IG_READ_IO_SPACE_EX = 0x00000008U;
enum uint IG_WRITE_IO_SPACE_EX = 0x00000009U;
enum uint IG_KSTACK_HELP = 0x0000000aU;
enum uint IG_SET_THREAD = 0x0000000bU;
enum uint IG_READ_MSR = 0x0000000cU;
enum uint IG_WRITE_MSR = 0x0000000dU;
enum uint IG_GET_DEBUGGER_DATA = 0x0000000eU;
enum uint IG_GET_KERNEL_VERSION = 0x0000000fU;
enum uint IG_RELOAD_SYMBOLS = 0x00000010U;
enum uint IG_GET_SET_SYMPATH = 0x00000011U;
enum uint IG_GET_EXCEPTION_RECORD = 0x00000012U;
enum uint IG_IS_PTR64 = 0x00000013U;
enum uint IG_GET_BUS_DATA = 0x00000014U;
enum uint IG_SET_BUS_DATA = 0x00000015U;
enum uint IG_DUMP_SYMBOL_INFO = 0x00000016U;
enum uint IG_LOWMEM_CHECK = 0x00000017U;
enum uint IG_SEARCH_MEMORY = 0x00000018U;

enum : uint
{
    IG_GET_CURRENT_THREAD  = 0x00000019U,
    IG_GET_CURRENT_PROCESS = 0x0000001aU,
}

enum : uint
{
    IG_GET_TYPE_SIZE              = 0x0000001bU,
    IG_GET_CURRENT_PROCESS_HANDLE = 0x0000001cU,
}

enum : uint
{
    IG_GET_INPUT_LINE    = 0x0000001dU,
    IG_GET_EXPRESSION_EX = 0x0000001eU,
}

enum uint IG_TRANSLATE_VIRTUAL_TO_PHYSICAL = 0x0000001fU;
enum uint IG_GET_CACHE_SIZE = 0x00000020U;
enum uint IG_READ_PHYSICAL_WITH_FLAGS = 0x00000021U;
enum uint IG_WRITE_PHYSICAL_WITH_FLAGS = 0x00000022U;
enum uint IG_POINTER_SEARCH_PHYSICAL = 0x00000023U;
enum uint IG_OBSOLETE_PLACEHOLDER_36 = 0x00000024U;
enum uint IG_GET_THREAD_OS_INFO = 0x00000025U;
enum uint IG_GET_CLR_DATA_INTERFACE = 0x00000026U;
enum uint IG_MATCH_PATTERN_A = 0x00000027U;
enum uint IG_FIND_FILE = 0x00000028U;
enum uint IG_TYPED_DATA_OBSOLETE = 0x00000029U;
enum uint IG_QUERY_TARGET_INTERFACE = 0x0000002aU;
enum uint IG_TYPED_DATA = 0x0000002bU;
enum uint IG_DISASSEMBLE_BUFFER = 0x0000002cU;
enum uint IG_GET_ANY_MODULE_IN_RANGE = 0x0000002dU;
enum uint IG_VIRTUAL_TO_PHYSICAL = 0x0000002eU;
enum uint IG_PHYSICAL_TO_VIRTUAL = 0x0000002fU;

enum : uint
{
    IG_GET_CONTEXT_EX  = 0x00000030U,
    IG_GET_TEB_ADDRESS = 0x00000080U,
}

enum uint IG_GET_PEB_ADDRESS = 0x00000081U;

enum : uint
{
    PHYS_FLAG_DEFAULT        = 0x00000000U,
    PHYS_FLAG_CACHED         = 0x00000001U,
    PHYS_FLAG_UNCACHED       = 0x00000002U,
    PHYS_FLAG_WRITE_COMBINED = 0x00000003U,
}

enum : uint
{
    PTR_SEARCH_PHYS_ALL_HITS         = 0x00000001U,
    PTR_SEARCH_PHYS_PTE              = 0x00000002U,
    PTR_SEARCH_PHYS_RANGE_CHECK_ONLY = 0x00000004U,
    PTR_SEARCH_PHYS_SIZE_SHIFT       = 0x00000003U,
    PTR_SEARCH_NO_SYMBOL_CHECK       = 0x80000000U,
}

enum uint EXT_FIND_FILE_ALLOW_GIVEN_PATH = 0x00000001U;

enum : uint
{
    DEBUG_TYPED_DATA_IS_IN_MEMORY            = 0x00000001U,
    DEBUG_TYPED_DATA_PHYSICAL_DEFAULT        = 0x00000002U,
    DEBUG_TYPED_DATA_PHYSICAL_CACHED         = 0x00000004U,
    DEBUG_TYPED_DATA_PHYSICAL_UNCACHED       = 0x00000006U,
    DEBUG_TYPED_DATA_PHYSICAL_WRITE_COMBINED = 0x00000008U,
    DEBUG_TYPED_DATA_PHYSICAL_MEMORY         = 0x0000000eU,
}

enum : uint
{
    EXT_TDF_PHYSICAL_DEFAULT        = 0x00000002U,
    EXT_TDF_PHYSICAL_CACHED         = 0x00000004U,
    EXT_TDF_PHYSICAL_UNCACHED       = 0x00000006U,
    EXT_TDF_PHYSICAL_WRITE_COMBINED = 0x00000008U,
    EXT_TDF_PHYSICAL_MEMORY         = 0x0000000eU,
}

enum : uint
{
    WDBGEXTS_ADDRESS_DEFAULT   = 0x00000000U,
    WDBGEXTS_ADDRESS_SEG16     = 0x00000001U,
    WDBGEXTS_ADDRESS_SEG32     = 0x00000002U,
    WDBGEXTS_ADDRESS_RESERVED0 = 0x80000000U,
}

enum : uint
{
    DBGKD_VERS_FLAG_MP          = 0x00000001U,
    DBGKD_VERS_FLAG_DATA        = 0x00000002U,
    DBGKD_VERS_FLAG_PTR64       = 0x00000004U,
    DBGKD_VERS_FLAG_NOMM        = 0x00000008U,
    DBGKD_VERS_FLAG_HSS         = 0x00000010U,
    DBGKD_VERS_FLAG_PARTITIONS  = 0x00000020U,
    DBGKD_VERS_FLAG_HAL_IN_NTOS = 0x00000040U,
}

enum : uint
{
    KD_SECONDARY_VERSION_DEFAULT                  = 0x00000000U,
    KD_SECONDARY_VERSION_AMD64_OBSOLETE_CONTEXT_1 = 0x00000000U,
    KD_SECONDARY_VERSION_AMD64_OBSOLETE_CONTEXT_2 = 0x00000001U,
    KD_SECONDARY_VERSION_AMD64_CONTEXT            = 0x00000002U,
}

enum uint CURRENT_KD_SECONDARY_VERSION = 0x00000002U;

enum : uint
{
    DBG_DUMP_NO_INDENT        = 0x00000001U,
    DBG_DUMP_NO_OFFSET        = 0x00000002U,
    DBG_DUMP_VERBOSE          = 0x00000004U,
    DBG_DUMP_CALL_FOR_EACH    = 0x00000008U,
    DBG_DUMP_LIST             = 0x00000020U,
    DBG_DUMP_NO_PRINT         = 0x00000040U,
    DBG_DUMP_GET_SIZE_ONLY    = 0x00000080U,
    DBG_DUMP_COMPACT_OUT      = 0x00002000U,
    DBG_DUMP_ARRAY            = 0x00008000U,
    DBG_DUMP_ADDRESS_OF_FIELD = 0x00010000U,
    DBG_DUMP_ADDRESS_AT_END   = 0x00020000U,
}

enum uint DBG_DUMP_COPY_TYPE_DATA = 0x00040000U;

enum : uint
{
    DBG_DUMP_READ_PHYSICAL   = 0x00080000U,
    DBG_DUMP_FUNCTION_FORMAT = 0x00100000U,
}

enum : uint
{
    DBG_DUMP_BLOCK_RECURSE = 0x00200000U,
    DBG_DUMP_MATCH_SIZE    = 0x00400000U,
}

enum : uint
{
    DBG_RETURN_TYPE        = 0x00000000U,
    DBG_RETURN_SUBTYPES    = 0x00000000U,
    DBG_RETURN_TYPE_VALUES = 0x00000000U,
}

enum : uint
{
    DBG_DUMP_FIELD_CALL_BEFORE_PRINT = 0x00000001U,
    DBG_DUMP_FIELD_NO_CALLBACK_REQ   = 0x00000002U,
    DBG_DUMP_FIELD_RECUR_ON_THIS     = 0x00000004U,
    DBG_DUMP_FIELD_FULL_NAME         = 0x00000008U,
    DBG_DUMP_FIELD_ARRAY             = 0x00000010U,
    DBG_DUMP_FIELD_COPY_FIELD_DATA   = 0x00000020U,
    DBG_DUMP_FIELD_RETURN_ADDRESS    = 0x00001000U,
    DBG_DUMP_FIELD_SIZE_IN_BITS      = 0x00002000U,
    DBG_DUMP_FIELD_NO_PRINT          = 0x00004000U,
    DBG_DUMP_FIELD_DEFAULT_STRING    = 0x00010000U,
    DBG_DUMP_FIELD_WCHAR_STRING      = 0x00020000U,
    DBG_DUMP_FIELD_MULTI_STRING      = 0x00040000U,
    DBG_DUMP_FIELD_GUID_STRING       = 0x00080000U,
    DBG_DUMP_FIELD_UTF32_STRING      = 0x00100000U,
}

enum uint MEMORY_READ_ERROR = 0x00000001U;

enum : uint
{
    SYMBOL_TYPE_INDEX_NOT_FOUND = 0x00000002U,
    SYMBOL_TYPE_INFO_NOT_FOUND  = 0x00000003U,
}

enum uint FIELDS_DID_NOT_MATCH = 0x00000004U;
enum uint NULL_SYM_DUMP_PARAM = 0x00000005U;
enum uint NULL_FIELD_NAME = 0x00000006U;
enum uint INCORRECT_VERSION_INFO = 0x00000007U;
enum uint EXIT_ON_CONTROLC = 0x00000008U;
enum uint CANNOT_ALLOCATE_MEMORY = 0x00000009U;
enum uint INSUFFICIENT_SPACE_TO_COPY = 0x0000000aU;
enum uint ADDRESS_TYPE_INDEX_NOT_FOUND = 0x0000000bU;
enum uint UNAVAILABLE_ERROR = 0x0000000cU;

enum : int
{
    DBGKD_SIMULATION_NONE = 0x00000000,
    DBGKD_SIMULATION_EXDI = 0x00000001,
}

// Callbacks

alias PDEBUG_EXTENSION_INITIALIZE = HRESULT function(uint* Version, uint* Flags);
alias PDEBUG_EXTENSION_UNINITIALIZE = void function();
alias PDEBUG_EXTENSION_CANUNLOAD = HRESULT function();
alias PDEBUG_EXTENSION_UNLOAD = void function();
alias PDEBUG_EXTENSION_NOTIFY = void function(uint Notify, ulong Argument);
alias PDEBUG_EXTENSION_CALL = HRESULT function(IDebugClient Client, const(PSTR) Args);
alias PDEBUG_EXTENSION_KNOWN_STRUCT = HRESULT function(uint Flags, ulong Offset, PSTR TypeName, PSTR Buffer, 
                                                       uint* BufferChars);
alias PDEBUG_EXTENSION_KNOWN_STRUCT_EX = HRESULT function(IDebugClient Client, uint Flags, ulong Offset, 
                                                          const(PSTR) TypeName, PSTR Buffer, uint* BufferChars);
alias PDEBUG_EXTENSION_QUERY_VALUE_NAMES = HRESULT function(IDebugClient Client, uint Flags, PWSTR Buffer, 
                                                            uint BufferChars, uint* BufferNeeded);
alias PDEBUG_EXTENSION_PROVIDE_VALUE = HRESULT function(IDebugClient Client, uint Flags, const(PWSTR) Name, 
                                                        ulong* Value, ulong* TypeModBase, uint* TypeId, 
                                                        uint* TypeFlags);
alias PDEBUG_STACK_PROVIDER_BEGINTHREADSTACKRECONSTRUCTION = HRESULT function(uint StreamType, 
                                                                              void* MiniDumpStreamBuffer, 
                                                                              uint BufferSize);
alias PDEBUG_STACK_PROVIDER_RECONSTRUCTSTACK = HRESULT function(uint SystemThreadId, 
                                                                DEBUG_STACK_FRAME_EX* NativeFrames, 
                                                                uint CountNativeFrames, 
                                                                STACK_SYM_FRAME_INFO** StackSymFrames, 
                                                                uint* StackSymFramesFilled);
alias PDEBUG_STACK_PROVIDER_FREESTACKSYMFRAMES = HRESULT function(STACK_SYM_FRAME_INFO* StackSymFrames);
alias PDEBUG_STACK_PROVIDER_ENDTHREADSTACKRECONSTRUCTION = HRESULT function();
alias PWINDBG_OUTPUT_ROUTINE = void function(const(PSTR) lpFormat);
alias PWINDBG_GET_EXPRESSION = size_t function(const(PSTR) lpExpression);
alias PWINDBG_GET_EXPRESSION32 = uint function(const(PSTR) lpExpression);
alias PWINDBG_GET_EXPRESSION64 = ulong function(const(PSTR) lpExpression);
alias PWINDBG_GET_SYMBOL = void function(void* offset, 
                                         /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR pchBuffer, 
                                         size_t* pDisplacement);
alias PWINDBG_GET_SYMBOL32 = void function(uint offset, 
                                           /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR pchBuffer, 
                                           uint* pDisplacement);
alias PWINDBG_GET_SYMBOL64 = void function(ulong offset, 
                                           /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR pchBuffer, 
                                           ulong* pDisplacement);
alias PWINDBG_DISASM = uint function(size_t* lpOffset, const(PSTR) lpBuffer, uint fShowEffectiveAddress);
alias PWINDBG_DISASM32 = uint function(uint* lpOffset, const(PSTR) lpBuffer, uint fShowEffectiveAddress);
alias PWINDBG_DISASM64 = uint function(ulong* lpOffset, const(PSTR) lpBuffer, uint fShowEffectiveAddress);
alias PWINDBG_CHECK_CONTROL_C = uint function();
alias PWINDBG_READ_PROCESS_MEMORY_ROUTINE = uint function(size_t offset, void* lpBuffer, uint cb, 
                                                          uint* lpcbBytesRead);
alias PWINDBG_READ_PROCESS_MEMORY_ROUTINE32 = uint function(uint offset, void* lpBuffer, uint cb, 
                                                            uint* lpcbBytesRead);
alias PWINDBG_READ_PROCESS_MEMORY_ROUTINE64 = uint function(ulong offset, void* lpBuffer, uint cb, 
                                                            uint* lpcbBytesRead);
alias PWINDBG_WRITE_PROCESS_MEMORY_ROUTINE = uint function(size_t offset, const(void)* lpBuffer, uint cb, 
                                                           uint* lpcbBytesWritten);
alias PWINDBG_WRITE_PROCESS_MEMORY_ROUTINE32 = uint function(uint offset, const(void)* lpBuffer, uint cb, 
                                                             uint* lpcbBytesWritten);
alias PWINDBG_WRITE_PROCESS_MEMORY_ROUTINE64 = uint function(ulong offset, const(void)* lpBuffer, uint cb, 
                                                             uint* lpcbBytesWritten);
alias PWINDBG_GET_THREAD_CONTEXT_ROUTINE = uint function(uint Processor, CONTEXT* lpContext, uint cbSizeOfContext);
alias PWINDBG_SET_THREAD_CONTEXT_ROUTINE = uint function(uint Processor, CONTEXT* lpContext, uint cbSizeOfContext);
alias PWINDBG_IOCTL_ROUTINE = uint function(ushort IoctlType, void* lpvData, uint cbSize);
alias PWINDBG_OLDKD_READ_PHYSICAL_MEMORY = uint function(ulong address, void* buffer, uint count, uint* bytesread);
alias PWINDBG_OLDKD_WRITE_PHYSICAL_MEMORY = uint function(ulong address, void* buffer, uint length, 
                                                          uint* byteswritten);
alias PWINDBG_STACKTRACE_ROUTINE = uint function(uint FramePointer, uint StackPointer, uint ProgramCounter, 
                                                 EXTSTACKTRACE* StackFrames, uint Frames);
alias PWINDBG_STACKTRACE_ROUTINE32 = uint function(uint FramePointer, uint StackPointer, uint ProgramCounter, 
                                                   EXTSTACKTRACE32* StackFrames, uint Frames);
alias PWINDBG_STACKTRACE_ROUTINE64 = uint function(ulong FramePointer, ulong StackPointer, ulong ProgramCounter, 
                                                   EXTSTACKTRACE64* StackFrames, uint Frames);
alias PWINDBG_OLD_EXTENSION_ROUTINE = void function(uint dwCurrentPc, WINDBG_EXTENSION_APIS* lpExtensionApis, 
                                                    const(PSTR) lpArgumentString);
alias PWINDBG_EXTENSION_ROUTINE = void function(HANDLE hCurrentProcess, HANDLE hCurrentThread, uint dwCurrentPc, 
                                                uint dwProcessor, const(PSTR) lpArgumentString);
alias PWINDBG_EXTENSION_ROUTINE32 = void function(HANDLE hCurrentProcess, HANDLE hCurrentThread, uint dwCurrentPc, 
                                                  uint dwProcessor, const(PSTR) lpArgumentString);
alias PWINDBG_EXTENSION_ROUTINE64 = void function(HANDLE hCurrentProcess, HANDLE hCurrentThread, ulong dwCurrentPc, 
                                                  uint dwProcessor, const(PSTR) lpArgumentString);
alias PWINDBG_OLDKD_EXTENSION_ROUTINE = void function(uint dwCurrentPc, 
                                                      WINDBG_OLDKD_EXTENSION_APIS* lpExtensionApis, 
                                                      const(PSTR) lpArgumentString);
alias PWINDBG_EXTENSION_DLL_INIT = void function(WINDBG_EXTENSION_APIS* lpExtensionApis, ushort MajorVersion, 
                                                 ushort MinorVersion);
alias PWINDBG_EXTENSION_DLL_INIT32 = void function(WINDBG_EXTENSION_APIS32* lpExtensionApis, ushort MajorVersion, 
                                                   ushort MinorVersion);
alias PWINDBG_EXTENSION_DLL_INIT64 = void function(WINDBG_EXTENSION_APIS64* lpExtensionApis, ushort MajorVersion, 
                                                   ushort MinorVersion);
alias PWINDBG_CHECK_VERSION = uint function();
alias PWINDBG_EXTENSION_API_VERSION = EXT_API_VERSION* function();
alias PSYM_DUMP_FIELD_CALLBACK = uint function(FIELD_INFO* pField, void* UserContext);
alias PGET_DEVICE_OBJECT_INFO = HRESULT function(IDebugClient Client, ulong DeviceObject, 
                                                 DEBUG_DEVICE_OBJECT_INFO* pDevObjInfo);
alias PGET_DRIVER_OBJECT_INFO = HRESULT function(IDebugClient Client, ulong DriverObject, 
                                                 DEBUG_DRIVER_OBJECT_INFO* pDrvObjInfo);
alias PGET_PROCESS_COMMIT = HRESULT function(IDebugClient Client, ulong* TotalCommitCharge, 
                                             uint* NumberOfProcesses, PROCESS_COMMIT_USAGE** CommitData);
alias PGET_FULL_IMAGE_NAME = HRESULT function(IDebugClient Client, ulong Process, PSTR* FullImageName);
alias PGET_CPU_PSPEED_INFO = HRESULT function(IDebugClient Client, DEBUG_CPU_SPEED_INFO* pCpuSpeedInfo);
alias PGET_CPU_MICROCODE_VERSION = HRESULT function(IDebugClient Client, 
                                                    DEBUG_CPU_MICROCODE_VERSION* pCpuMicrocodeVersion);
alias PGET_SMBIOS_INFO = HRESULT function(IDebugClient Client, DEBUG_SMBIOS_INFO* pSmbiosInfo);
alias PGET_IRP_INFO = HRESULT function(IDebugClient Client, ulong Irp, DEBUG_IRP_INFO* IrpInfo);
alias PGET_PNP_TRIAGE_INFO = HRESULT function(IDebugClient Client, DEBUG_PNP_TRIAGE_INFO* pPNPTriageInfo);
alias PGET_POOL_DATA = HRESULT function(IDebugClient Client, ulong Pool, DEBUG_POOL_DATA* PoolData);
alias PGET_POOL_REGION = HRESULT function(IDebugClient Client, ulong Pool, DEBUG_POOL_REGION* PoolRegion);
alias PFIND_MATCHING_THREAD = HRESULT function(IDebugClient Client, KDEXT_THREAD_FIND_PARAMS* ThreadInfo);
alias PFIND_MATCHING_PROCESS = HRESULT function(IDebugClient Client, KDEXT_PROCESS_FIND_PARAMS* ProcessInfo, 
                                                ulong* Process);
alias EXTS_JOB_PROCESS_CALLBACK = BOOLEAN function(ulong Job, ulong Process, void* Context);
alias PENUMERATE_JOB_PROCESSES = HRESULT function(IDebugClient Client, ulong Job, 
                                                  EXTS_JOB_PROCESS_CALLBACK Callback, void* Context);
alias EXTS_TABLE_ENTRY_CALLBACK = BOOLEAN function(ulong Entry, void* Context);
alias PENUMERATE_HASH_TABLE = HRESULT function(IDebugClient Client, ulong HashTable, 
                                               EXTS_TABLE_ENTRY_CALLBACK Callback, void* Context);
alias KDEXT_DUMP_HANDLE_CALLBACK = BOOLEAN function(KDEXT_HANDLE_INFORMATION* HandleInfo, uint Flags, 
                                                    void* Context);
alias PENUMERATE_HANDLES = HRESULT function(IDebugClient Client, ulong Process, ulong HandleToDump, uint Flags, 
                                            KDEXT_DUMP_HANDLE_CALLBACK Callback, void* Context);
alias PFIND_FILELOCK_OWNERINFO = HRESULT function(IDebugClient Client, KDEXT_FILELOCK_OWNER* pFileLockOwner);
alias KDEXTS_LOCK_CALLBACKROUTINE = HRESULT function(KDEXTS_LOCK_INFO* pLock, void* Context);
alias PENUMERATE_SYSTEM_LOCKS = HRESULT function(IDebugClient Client, uint Flags, 
                                                 KDEXTS_LOCK_CALLBACKROUTINE Callback, void* Context);
alias PKDEXTS_GET_PTE_INFO = HRESULT function(IDebugClient Client, ulong Virtual, KDEXTS_PTE_INFO* PteInfo);
alias PGET_POOL_TAG_DESCRIPTION = HRESULT function(uint PoolTag, DEBUG_POOLTAG_DESCRIPTION* pDescription);
alias EXT_GET_FAILURE_ANALYSIS = HRESULT function(IDebugClient4 Client, uint Flags, 
                                                  IDebugFailureAnalysis* ppAnalysis);
alias EXT_GET_DEBUG_FAILURE_ANALYSIS = HRESULT function(IDebugClient4 Client, uint Flags, GUID ClassId, 
                                                        IDebugFailureAnalysis2* ppAnalysis);
alias fnDebugFailureAnalysisCreateInstance = HRESULT function(IDebugClient Client, const(PWSTR) Args, uint Flags, 
                                                              const(GUID)* rclsid, const(GUID)* riid, void** ppv);
alias EXT_ANALYSIS_PLUGIN = HRESULT function(IDebugClient4 Client, FA_EXTENSION_PLUGIN_PHASE CallPhase, 
                                             IDebugFailureAnalysis2 pAnalysis);
alias EXT_GET_FA_ENTRIES_DATA = HRESULT function(IDebugClient4 Client, uint* Count, FA_ENTRY** Entries);
alias EXT_TARGET_INFO = HRESULT function(IDebugClient4 Client, TARGET_DEBUG_INFO* pTargetInfo);
alias EXT_DECODE_ERROR = void function(DEBUG_DECODE_ERROR* pDecodeError);
alias EXT_TRIAGE_FOLLOWUP = uint function(IDebugClient4 Client, const(PSTR) SymbolName, 
                                          DEBUG_TRIAGE_FOLLOWUP_INFO* OwnerInfo);
alias EXT_RELOAD_TRIAGER = HRESULT function(IDebugClient4 Client);
alias EXT_XML_DATA = HRESULT function(IDebugClient4 Client, EXT_CAB_XML_DATA* pXmpData);
alias EXT_ANALYZER = HRESULT function(IDebugClient Client, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSTR BucketSuffix, 
                                      uint cbBucketSuffix, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PSTR DebugText, 
                                      uint cbDebugText, uint* Flags, IDebugFailureAnalysis pAnalysis);
alias EXTDLL_QUERYDATABYTAG = HRESULT function(IDebugClient4 Client, uint dwDataTag, void* pQueryInfo, 
                                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pData, 
                                               uint cbData);
alias EXTDLL_QUERYDATABYTAGEX = HRESULT function(IDebugClient4 Client, uint dwDataTag, void* pQueryInfo, 
                                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pData, 
                                                 uint cbData, 
                                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* pDataEx, 
                                                 uint cbDataEx);
alias ENTRY_CALLBACK = HRESULT function(ulong EntryAddress, void* Context);
alias EXTDLL_ITERATERTLBALANCEDNODES = void function(ulong RootNode, uint EntryOffset, ENTRY_CALLBACK Callback, 
                                                     void* CallbackContext);
alias EXT_GET_HANDLE_TRACE = HRESULT function(IDebugClient Client, uint TraceType, uint StartIndex, 
                                              ulong* HandleValue, ulong* StackFunctions, uint StackTraceSize);
alias EXT_GET_ENVIRONMENT_VARIABLE = HRESULT function(ulong Peb, PSTR Variable, PSTR Buffer, uint BufferSize);

// Structs


struct ISvcProcess
{
    ptrdiff_t Value;
}

struct ISvcThread
{
    ptrdiff_t Value;
}

struct ISvcExecutionUnit
{
    ptrdiff_t Value;
}

struct IDebugServiceManager
{
    ptrdiff_t Value;
}

struct ISvcModule
{
    ptrdiff_t Value;
}

struct ISvcSymbolType
{
    ptrdiff_t Value;
}

struct DEBUG_OFFSET_REGION
{
    ulong Base;
    ulong Size;
}

struct DEBUG_READ_USER_MINIDUMP_STREAM
{
    uint  StreamType;
    uint  Flags;
    ulong Offset;
    void* Buffer;
    uint  BufferSize;
    uint  BufferUsed;
}

struct DEBUG_GET_TEXT_COMPLETIONS_IN
{
    uint     Flags;
    uint     MatchCountLimit;
    ulong[3] Reserved;
}

struct DEBUG_GET_TEXT_COMPLETIONS_OUT
{
    uint     Flags;
    uint     ReplaceIndex;
    uint     MatchCount;
    uint     Reserved1;
    ulong[2] Reserved2;
}

struct DEBUG_CACHED_SYMBOL_INFO
{
    ulong ModBase;
    ulong Arg1;
    ulong Arg2;
    uint  Id;
    uint  Arg3;
}

struct PROCESS_NAME_ENTRY
{
    uint ProcessId;
    uint NameOffset;
    uint NameSize;
    uint NextEntry;
}

struct DEBUG_THREAD_BASIC_INFORMATION
{
    uint  Valid;
    uint  ExitStatus;
    uint  PriorityClass;
    uint  Priority;
    ulong CreateTime;
    ulong ExitTime;
    ulong KernelTime;
    ulong UserTime;
    ulong StartOffset;
    ulong Affinity;
}

struct SYMBOL_INFO_EX
{
    uint    SizeOfStruct;
    uint    TypeOfInfo;
    ulong   Offset;
    uint    Line;
    uint    Displacement;
    uint[4] Reserved;
}

struct DEBUG_BREAKPOINT_PARAMETERS
{
    ulong Offset;
    uint  Id;
    uint  BreakType;
    uint  ProcType;
    uint  Flags;
    uint  DataSize;
    uint  DataAccessType;
    uint  PassCount;
    uint  CurrentPassCount;
    uint  MatchThread;
    uint  CommandSize;
    uint  OffsetExpressionSize;
}

struct DEBUG_CREATE_PROCESS_OPTIONS
{
    uint CreateFlags;
    uint EngCreateFlags;
    uint VerifierFlags;
    uint Reserved;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct DEBUG_CLIENT_CONTEXT
{
    uint cbSize;
    uint eClient;
}

struct DEBUG_STACK_FRAME
{
    ulong    InstructionOffset;
    ulong    ReturnOffset;
    ulong    FrameOffset;
    ulong    StackOffset;
    ulong    FuncTableEntry;
    ulong[4] Params;
    ulong[6] Reserved;
    BOOL     Virtual;
    uint     FrameNumber;
}

struct DEBUG_STACK_FRAME_EX
{
    ulong    InstructionOffset;
    ulong    ReturnOffset;
    ulong    FrameOffset;
    ulong    StackOffset;
    ulong    FuncTableEntry;
    ulong[4] Params;
    ulong[6] Reserved;
    BOOL     Virtual;
    uint     FrameNumber;
    uint     InlineFrameContext;
    uint     Reserved1;
}

union INLINE_FRAME_CONTEXT
{
    uint ContextValue;
    struct
    {
        ubyte  FrameId;
        ubyte  FrameType;
        ushort FrameSignature;
    }
}

struct STACK_SRC_INFO
{
    const(PWSTR) ImagePath;
    const(PWSTR) ModuleName;
    const(PWSTR) Function;
    uint         Displacement;
    uint         Row;
    uint         Column;
}

struct STACK_SYM_FRAME_INFO
{
    DEBUG_STACK_FRAME_EX StackFrameEx;
    STACK_SRC_INFO       SrcInfo;
}

struct DEBUG_SPECIFIC_FILTER_PARAMETERS
{
    uint ExecutionOption;
    uint ContinueOption;
    uint TextSize;
    uint CommandSize;
    uint ArgumentSize;
}

struct DEBUG_EXCEPTION_FILTER_PARAMETERS
{
    uint ExecutionOption;
    uint ContinueOption;
    uint TextSize;
    uint CommandSize;
    uint SecondCommandSize;
    uint ExceptionCode;
}

struct DEBUG_LAST_EVENT_INFO_BREAKPOINT
{
    uint Id;
}

struct DEBUG_LAST_EVENT_INFO_EXCEPTION
{
    EXCEPTION_RECORD64 ExceptionRecord;
    uint               FirstChance;
}

struct DEBUG_LAST_EVENT_INFO_EXIT_THREAD
{
    uint ExitCode;
}

struct DEBUG_LAST_EVENT_INFO_EXIT_PROCESS
{
    uint ExitCode;
}

struct DEBUG_LAST_EVENT_INFO_LOAD_MODULE
{
    ulong Base;
}

struct DEBUG_LAST_EVENT_INFO_UNLOAD_MODULE
{
    ulong Base;
}

struct DEBUG_LAST_EVENT_INFO_SYSTEM_ERROR
{
    uint Error;
    uint Level;
}

struct DEBUG_LAST_EVENT_INFO_SERVICE_EXCEPTION
{
    uint  Kind;
    uint  DataSize;
    ulong Address;
}

struct DEBUG_VALUE
{
    union
    {
        ubyte     I8;
        ushort    I16;
        uint      I32;
        struct
        {
            ulong I64;
            BOOL  Nat;
        }
        float     F32;
        double    F64;
        ubyte[10] F80Bytes;
        ubyte[11] F82Bytes;
        ubyte[16] F128Bytes;
        ubyte[16] VI8;
        ushort[8] VI16;
        uint[4]   VI32;
        ulong[2]  VI64;
        float[4]  VF32;
        double[2] VF64;
        struct I64Parts32
        {
            uint LowPart;
            uint HighPart;
        }
        struct F128Parts64
        {
            ulong LowPart;
            long  HighPart;
        }
        ubyte[24] RawBytes;
    }
    uint TailOfRawBytes;
    uint Type;
}

struct DEBUG_PROCESSOR_IDENTIFICATION_ALPHA
{
    uint Type;
    uint Revision;
}

struct DEBUG_PROCESSOR_IDENTIFICATION_AMD64
{
    uint     Family;
    uint     Model;
    uint     Stepping;
    CHAR[16] VendorString;
}

struct DEBUG_PROCESSOR_IDENTIFICATION_IA64
{
    uint     Model;
    uint     Revision;
    uint     Family;
    uint     ArchRev;
    CHAR[16] VendorString;
}

struct DEBUG_PROCESSOR_IDENTIFICATION_X86
{
    uint     Family;
    uint     Model;
    uint     Stepping;
    CHAR[16] VendorString;
}

struct DEBUG_PROCESSOR_IDENTIFICATION_ARM
{
    uint     Model;
    uint     Revision;
    CHAR[16] VendorString;
}

struct DEBUG_PROCESSOR_IDENTIFICATION_ARM64
{
    uint     Model;
    uint     Revision;
    CHAR[16] VendorString;
}

union DEBUG_PROCESSOR_IDENTIFICATION_ALL
{
    DEBUG_PROCESSOR_IDENTIFICATION_ALPHA Alpha;
    DEBUG_PROCESSOR_IDENTIFICATION_AMD64 Amd64;
    DEBUG_PROCESSOR_IDENTIFICATION_IA64 Ia64;
    DEBUG_PROCESSOR_IDENTIFICATION_X86 X86;
    DEBUG_PROCESSOR_IDENTIFICATION_ARM Arm;
    DEBUG_PROCESSOR_IDENTIFICATION_ARM64 Arm64;
}

struct DEBUG_HANDLE_DATA_BASIC
{
    uint TypeNameSize;
    uint ObjectNameSize;
    uint Attributes;
    uint GrantedAccess;
    uint HandleCount;
    uint PointerCount;
}

struct DEBUG_EVENT_CONTEXT
{
    uint Size;
    uint ProcessEngineId;
    uint ThreadEngineId;
    uint FrameEngineId;
}

struct DEBUG_REGISTER_DESCRIPTION
{
    uint  Type;
    uint  Flags;
    uint  SubregMaster;
    uint  SubregLength;
    ulong SubregMask;
    uint  SubregShift;
    uint  Reserved0;
}

struct DEBUG_SYMBOL_PARAMETERS
{
    ulong Module;
    uint  TypeId;
    uint  ParentSymbol;
    uint  SubElements;
    uint  Flags;
    ulong Reserved;
}

struct DEBUG_SYMBOL_ENTRY
{
    ulong ModuleBase;
    ulong Offset;
    ulong Id;
    ulong Arg64;
    uint  Size;
    uint  Flags;
    uint  TypeId;
    uint  NameSize;
    uint  Token;
    uint  Tag;
    uint  Arg32;
    uint  Reserved;
}

struct DEBUG_MODULE_PARAMETERS
{
    ulong    Base;
    uint     Size;
    uint     TimeDateStamp;
    uint     Checksum;
    uint     Flags;
    uint     SymbolType;
    uint     ImageNameSize;
    uint     ModuleNameSize;
    uint     LoadedImageNameSize;
    uint     SymbolFileNameSize;
    uint     MappedImageNameSize;
    ulong[2] Reserved;
}

struct DEBUG_MODULE_AND_ID
{
    ulong ModuleBase;
    ulong Id;
}

struct DEBUG_SYMBOL_SOURCE_ENTRY
{
    ulong ModuleBase;
    ulong Offset;
    ulong FileNameId;
    ulong EngineInternal;
    uint  Size;
    uint  Flags;
    uint  FileNameSize;
    uint  StartLine;
    uint  EndLine;
    uint  StartColumn;
    uint  EndColumn;
    uint  Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WMP/location-attribute
struct Location
{
    ulong HostDefined;
    ulong Offset;
}

struct ArrayDimension
{
    long  LowerBound;
    ulong Length;
    ulong Stride;
}

struct ExtendedArrayDimension
{
    ulong DimensionFlags;
    long  LowerBound;
    ulong Length;
    ulong Stride;
}

struct ScriptDebugPosition
{
    uint Line;
    uint Column;
}

struct ScriptDebugEventInformation
{
    ScriptDebugEvent    DebugEvent;
    ScriptDebugPosition EventPosition;
    ScriptDebugPosition EventSpanEnd;
    union u
    {
        struct ExceptionInformation
        {
            ubyte IsUncaught;
        }
        struct BreakpointInformation
        {
            ulong BreakpointId;
        }
    }
}

struct EXTSTACKTRACE
{
    uint    FramePointer;
    uint    ProgramCounter;
    uint    ReturnAddress;
    uint[4] Args;
}

struct EXTSTACKTRACE32
{
    uint    FramePointer;
    uint    ProgramCounter;
    uint    ReturnAddress;
    uint[4] Args;
}

struct EXTSTACKTRACE64
{
    ulong    FramePointer;
    ulong    ProgramCounter;
    ulong    ReturnAddress;
    ulong[4] Args;
}

struct WINDBG_EXTENSION_APIS
{
    uint               nSize;
    PWINDBG_OUTPUT_ROUTINE lpOutputRoutine;
    PWINDBG_GET_EXPRESSION lpGetExpressionRoutine;
    PWINDBG_GET_SYMBOL lpGetSymbolRoutine;
    PWINDBG_DISASM     lpDisasmRoutine;
    PWINDBG_CHECK_CONTROL_C lpCheckControlCRoutine;
    PWINDBG_READ_PROCESS_MEMORY_ROUTINE lpReadProcessMemoryRoutine;
    PWINDBG_WRITE_PROCESS_MEMORY_ROUTINE lpWriteProcessMemoryRoutine;
    PWINDBG_GET_THREAD_CONTEXT_ROUTINE lpGetThreadContextRoutine;
    PWINDBG_SET_THREAD_CONTEXT_ROUTINE lpSetThreadContextRoutine;
    PWINDBG_IOCTL_ROUTINE lpIoctlRoutine;
    PWINDBG_STACKTRACE_ROUTINE lpStackTraceRoutine;
}

struct WINDBG_EXTENSION_APIS32
{
    uint                 nSize;
    PWINDBG_OUTPUT_ROUTINE lpOutputRoutine;
    PWINDBG_GET_EXPRESSION32 lpGetExpressionRoutine;
    PWINDBG_GET_SYMBOL32 lpGetSymbolRoutine;
    PWINDBG_DISASM32     lpDisasmRoutine;
    PWINDBG_CHECK_CONTROL_C lpCheckControlCRoutine;
    PWINDBG_READ_PROCESS_MEMORY_ROUTINE32 lpReadProcessMemoryRoutine;
    PWINDBG_WRITE_PROCESS_MEMORY_ROUTINE32 lpWriteProcessMemoryRoutine;
    PWINDBG_GET_THREAD_CONTEXT_ROUTINE lpGetThreadContextRoutine;
    PWINDBG_SET_THREAD_CONTEXT_ROUTINE lpSetThreadContextRoutine;
    PWINDBG_IOCTL_ROUTINE lpIoctlRoutine;
    PWINDBG_STACKTRACE_ROUTINE32 lpStackTraceRoutine;
}

struct WINDBG_EXTENSION_APIS64
{
    uint                 nSize;
    PWINDBG_OUTPUT_ROUTINE lpOutputRoutine;
    PWINDBG_GET_EXPRESSION64 lpGetExpressionRoutine;
    PWINDBG_GET_SYMBOL64 lpGetSymbolRoutine;
    PWINDBG_DISASM64     lpDisasmRoutine;
    PWINDBG_CHECK_CONTROL_C lpCheckControlCRoutine;
    PWINDBG_READ_PROCESS_MEMORY_ROUTINE64 lpReadProcessMemoryRoutine;
    PWINDBG_WRITE_PROCESS_MEMORY_ROUTINE64 lpWriteProcessMemoryRoutine;
    PWINDBG_GET_THREAD_CONTEXT_ROUTINE lpGetThreadContextRoutine;
    PWINDBG_SET_THREAD_CONTEXT_ROUTINE lpSetThreadContextRoutine;
    PWINDBG_IOCTL_ROUTINE lpIoctlRoutine;
    PWINDBG_STACKTRACE_ROUTINE64 lpStackTraceRoutine;
}

struct WINDBG_OLD_EXTENSION_APIS
{
    uint               nSize;
    PWINDBG_OUTPUT_ROUTINE lpOutputRoutine;
    PWINDBG_GET_EXPRESSION lpGetExpressionRoutine;
    PWINDBG_GET_SYMBOL lpGetSymbolRoutine;
    PWINDBG_DISASM     lpDisasmRoutine;
    PWINDBG_CHECK_CONTROL_C lpCheckControlCRoutine;
}

struct WINDBG_OLDKD_EXTENSION_APIS
{
    uint                 nSize;
    PWINDBG_OUTPUT_ROUTINE lpOutputRoutine;
    PWINDBG_GET_EXPRESSION32 lpGetExpressionRoutine;
    PWINDBG_GET_SYMBOL32 lpGetSymbolRoutine;
    PWINDBG_DISASM32     lpDisasmRoutine;
    PWINDBG_CHECK_CONTROL_C lpCheckControlCRoutine;
    PWINDBG_READ_PROCESS_MEMORY_ROUTINE32 lpReadVirtualMemRoutine;
    PWINDBG_WRITE_PROCESS_MEMORY_ROUTINE32 lpWriteVirtualMemRoutine;
    PWINDBG_OLDKD_READ_PHYSICAL_MEMORY lpReadPhysicalMemRoutine;
    PWINDBG_OLDKD_WRITE_PHYSICAL_MEMORY lpWritePhysicalMemRoutine;
}

struct EXT_API_VERSION
{
    ushort MajorVersion;
    ushort MinorVersion;
    ushort Revision;
    ushort Reserved;
}

struct PROCESSORINFO
{
    ushort Processor;
    ushort NumberProcessors;
}

struct READCONTROLSPACE
{
    ushort   Processor;
    uint     Address;
    uint     BufLen;
    ubyte[1] Buf; // Flexible array
}

struct READCONTROLSPACE32
{
    ushort   Processor;
    uint     Address;
    uint     BufLen;
    ubyte[1] Buf; // Flexible array
}

struct READCONTROLSPACE64
{
    ushort   Processor;
    ulong    Address;
    uint     BufLen;
    ubyte[1] Buf; // Flexible array
}

struct IOSPACE
{
    uint Address;
    uint Length;
    uint Data;
}

struct IOSPACE32
{
    uint Address;
    uint Length;
    uint Data;
}

struct IOSPACE64
{
    ulong Address;
    uint  Length;
    uint  Data;
}

struct IOSPACE_EX
{
    uint Address;
    uint Length;
    uint Data;
    uint InterfaceType;
    uint BusNumber;
    uint AddressSpace;
}

struct IOSPACE_EX32
{
    uint Address;
    uint Length;
    uint Data;
    uint InterfaceType;
    uint BusNumber;
    uint AddressSpace;
}

struct IOSPACE_EX64
{
    ulong Address;
    uint  Length;
    uint  Data;
    uint  InterfaceType;
    uint  BusNumber;
    uint  AddressSpace;
}

struct BUSDATA
{
    uint  BusDataType;
    uint  BusNumber;
    uint  SlotNumber;
    void* Buffer;
    uint  Offset;
    uint  Length;
}

struct SEARCHMEMORY
{
    ulong SearchAddress;
    ulong SearchLength;
    ulong FoundAddress;
    uint  PatternLength;
    void* Pattern;
}

struct PHYSICAL
{
    ulong    Address;
    uint     BufLen;
    ubyte[1] Buf; // Flexible array
}

struct PHYSICAL_WITH_FLAGS
{
    ulong    Address;
    uint     BufLen;
    uint     Flags;
    ubyte[1] Buf; // Flexible array
}

struct READ_WRITE_MSR
{
    uint Msr;
    long Value;
}

struct GET_SET_SYMPATH
{
    const(PSTR) Args;
    PSTR        Result;
    int         Length;
}

struct GET_TEB_ADDRESS
{
    ulong Address;
}

struct GET_PEB_ADDRESS
{
    ulong CurrentThread;
    ulong Address;
}

struct GET_CURRENT_THREAD_ADDRESS
{
    uint  Processor;
    ulong Address;
}

struct GET_CURRENT_PROCESS_ADDRESS
{
    uint  Processor;
    ulong CurrentThread;
    ulong Address;
}

struct GET_INPUT_LINE
{
    const(PSTR) Prompt;
    PSTR        Buffer;
    uint        BufferSize;
    uint        InputSize;
}

struct GET_EXPRESSION_EX
{
    const(PSTR) Expression;
    const(PSTR) Remainder;
    ulong       Value;
}

struct TRANSLATE_VIRTUAL_TO_PHYSICAL
{
    ulong Virtual;
    ulong Physical;
}

struct VIRTUAL_TO_PHYSICAL
{
    uint  Status;
    uint  Size;
    ulong PdeAddress;
    ulong Virtual;
    ulong Physical;
}

struct PHYSICAL_TO_VIRTUAL
{
    uint  Status;
    uint  Size;
    ulong PdeAddress;
}

struct GET_CONTEXT_EX
{
    uint  Status;
    uint  ContextSize;
    void* pContext;
}

struct POINTER_SEARCH_PHYSICAL
{
    ulong  Offset;
    ulong  Length;
    ulong  PointerMin;
    ulong  PointerMax;
    uint   Flags;
    ulong* MatchOffsets;
    uint   MatchOffsetsSize;
    uint   MatchOffsetsCount;
}

struct WDBGEXTS_THREAD_OS_INFO
{
    uint  ThreadId;
    uint  ExitStatus;
    uint  PriorityClass;
    uint  Priority;
    ulong CreateTime;
    ulong ExitTime;
    ulong KernelTime;
    ulong UserTime;
    ulong StartOffset;
    ulong Affinity;
}

struct WDBGEXTS_CLR_DATA_INTERFACE
{
    const(GUID)* Iid;
    void*        Iface;
}

struct EXT_MATCH_PATTERN_A
{
    const(PSTR) Str;
    const(PSTR) Pattern;
    uint        CaseSensitive;
}

struct EXT_FIND_FILE
{
    const(PWSTR) FileName;
    ulong        IndexedSize;
    uint         ImageTimeDateStamp;
    uint         ImageCheckSum;
    void*        ExtraInfo;
    uint         ExtraInfoSize;
    uint         Flags;
    void*        FileMapping;
    ulong        FileMappingSize;
    HANDLE       FileHandle;
    PWSTR        FoundFileName;
    uint         FoundFileNameChars;
}

struct DEBUG_TYPED_DATA
{
    ulong    ModBase;
    ulong    Offset;
    ulong    EngineHandle;
    ulong    Data;
    uint     Size;
    uint     Flags;
    uint     TypeId;
    uint     BaseTypeId;
    uint     Tag;
    uint     Register;
    ulong[9] Internal;
}

struct EXT_TYPED_DATA
{
    EXT_TDOP         Operation;
    uint             Flags;
    DEBUG_TYPED_DATA InData;
    DEBUG_TYPED_DATA OutData;
    uint             InStrIndex;
    uint             In32;
    uint             Out32;
    ulong            In64;
    ulong            Out64;
    uint             StrBufferIndex;
    uint             StrBufferChars;
    uint             StrCharsNeeded;
    uint             DataBufferIndex;
    uint             DataBufferBytes;
    uint             DataBytesNeeded;
    HRESULT          Status;
    ulong[8]         Reserved;
}

struct WDBGEXTS_QUERY_INTERFACE
{
    const(GUID)* Iid;
    void*        Iface;
}

struct WDBGEXTS_DISASSEMBLE_BUFFER
{
    ulong    InOffset;
    ulong    OutOffset;
    uint     AddrFlags;
    uint     FormatFlags;
    uint     DataBufferBytes;
    uint     DisasmBufferChars;
    void*    DataBuffer;
    PWSTR    DisasmBuffer;
    ulong[3] Reserved0;
}

struct WDBGEXTS_MODULE_IN_RANGE
{
    ulong Start;
    ulong End;
    ulong FoundModBase;
    uint  FoundModSize;
}

struct DBGKD_GET_VERSION32
{
    ushort MajorVersion;
    ushort MinorVersion;
    ushort ProtocolVersion;
    ushort Flags;
    uint   KernBase;
    uint   PsLoadedModuleList;
    ushort MachineType;
    ushort ThCallbackStack;
    ushort NextCallback;
    ushort FramePointer;
    uint   KiCallUserMode;
    uint   KeUserCallbackDispatcher;
    uint   BreakpointWithStatus;
    uint   DebuggerDataList;
}

struct DBGKD_DEBUG_DATA_HEADER32
{
    LIST_ENTRY32 List;
    uint         OwnerTag;
    uint         Size;
}

struct KDDEBUGGER_DATA32
{
    DBGKD_DEBUG_DATA_HEADER32 Header;
    uint   KernBase;
    uint   BreakpointWithStatus;
    uint   SavedContext;
    ushort ThCallbackStack;
    ushort NextCallback;
    ushort FramePointer;
    // Native bit field: PaeEnabled: [0]
    ushort _bitfield0;
    uint   KiCallUserMode;
    uint   KeUserCallbackDispatcher;
    uint   PsLoadedModuleList;
    uint   PsActiveProcessHead;
    uint   PspCidTable;
    uint   ExpSystemResourcesList;
    uint   ExpPagedPoolDescriptor;
    uint   ExpNumberOfPagedPools;
    uint   KeTimeIncrement;
    uint   KeBugCheckCallbackListHead;
    uint   KiBugcheckData;
    uint   IopErrorLogListHead;
    uint   ObpRootDirectoryObject;
    uint   ObpTypeObjectType;
    uint   MmSystemCacheStart;
    uint   MmSystemCacheEnd;
    uint   MmSystemCacheWs;
    uint   MmPfnDatabase;
    uint   MmSystemPtesStart;
    uint   MmSystemPtesEnd;
    uint   MmSubsectionBase;
    uint   MmNumberOfPagingFiles;
    uint   MmLowestPhysicalPage;
    uint   MmHighestPhysicalPage;
    uint   MmNumberOfPhysicalPages;
    uint   MmMaximumNonPagedPoolInBytes;
    uint   MmNonPagedSystemStart;
    uint   MmNonPagedPoolStart;
    uint   MmNonPagedPoolEnd;
    uint   MmPagedPoolStart;
    uint   MmPagedPoolEnd;
    uint   MmPagedPoolInformation;
    uint   MmPageSize;
    uint   MmSizeOfPagedPoolInBytes;
    uint   MmTotalCommitLimit;
    uint   MmTotalCommittedPages;
    uint   MmSharedCommit;
    uint   MmDriverCommit;
    uint   MmProcessCommit;
    uint   MmPagedPoolCommit;
    uint   MmExtendedCommit;
    uint   MmZeroedPageListHead;
    uint   MmFreePageListHead;
    uint   MmStandbyPageListHead;
    uint   MmModifiedPageListHead;
    uint   MmModifiedNoWritePageListHead;
    uint   MmAvailablePages;
    uint   MmResidentAvailablePages;
    uint   PoolTrackTable;
    uint   NonPagedPoolDescriptor;
    uint   MmHighestUserAddress;
    uint   MmSystemRangeStart;
    uint   MmUserProbeAddress;
    uint   KdPrintCircularBuffer;
    uint   KdPrintCircularBufferEnd;
    uint   KdPrintWritePointer;
    uint   KdPrintRolloverCount;
    uint   MmLoadedUserImageList;
}

struct DBGKD_GET_VERSION64
{
    ushort    MajorVersion;
    ushort    MinorVersion;
    ubyte     ProtocolVersion;
    ubyte     KdSecondaryVersion;
    ushort    Flags;
    ushort    MachineType;
    ubyte     MaxPacketType;
    ubyte     MaxStateChange;
    ubyte     MaxManipulate;
    ubyte     Simulation;
    ushort[1] Unused;
    ulong     KernBase;
    ulong     PsLoadedModuleList;
    ulong     DebuggerDataList;
}

struct DBGKD_DEBUG_DATA_HEADER64
{
    LIST_ENTRY64 List;
    uint         OwnerTag;
    uint         Size;
}

struct KDDEBUGGER_DATA64
{
    DBGKD_DEBUG_DATA_HEADER64 Header;
    ulong  KernBase;
    ulong  BreakpointWithStatus;
    ulong  SavedContext;
    ushort ThCallbackStack;
    ushort NextCallback;
    ushort FramePointer;
    // Native bit field: PaeEnabled: [0], KiBugCheckRecoveryActive: [1], PagingLevels: [2-5]
    ushort _bitfield0;
    ulong  KiCallUserMode;
    ulong  KeUserCallbackDispatcher;
    ulong  PsLoadedModuleList;
    ulong  PsActiveProcessHead;
    ulong  PspCidTable;
    ulong  ExpSystemResourcesList;
    ulong  ExpPagedPoolDescriptor;
    ulong  ExpNumberOfPagedPools;
    ulong  KeTimeIncrement;
    ulong  KeBugCheckCallbackListHead;
    ulong  KiBugcheckData;
    ulong  IopErrorLogListHead;
    ulong  ObpRootDirectoryObject;
    ulong  ObpTypeObjectType;
    ulong  MmSystemCacheStart;
    ulong  MmSystemCacheEnd;
    ulong  MmSystemCacheWs;
    ulong  MmPfnDatabase;
    ulong  MmSystemPtesStart;
    ulong  MmSystemPtesEnd;
    ulong  MmSubsectionBase;
    ulong  MmNumberOfPagingFiles;
    ulong  MmLowestPhysicalPage;
    ulong  MmHighestPhysicalPage;
    ulong  MmNumberOfPhysicalPages;
    ulong  MmMaximumNonPagedPoolInBytes;
    ulong  MmNonPagedSystemStart;
    ulong  MmNonPagedPoolStart;
    ulong  MmNonPagedPoolEnd;
    ulong  MmPagedPoolStart;
    ulong  MmPagedPoolEnd;
    ulong  MmPagedPoolInformation;
    ulong  MmPageSize;
    ulong  MmSizeOfPagedPoolInBytes;
    ulong  MmTotalCommitLimit;
    ulong  MmTotalCommittedPages;
    ulong  MmSharedCommit;
    ulong  MmDriverCommit;
    ulong  MmProcessCommit;
    ulong  MmPagedPoolCommit;
    ulong  MmExtendedCommit;
    ulong  MmZeroedPageListHead;
    ulong  MmFreePageListHead;
    ulong  MmStandbyPageListHead;
    ulong  MmModifiedPageListHead;
    ulong  MmModifiedNoWritePageListHead;
    ulong  MmAvailablePages;
    ulong  MmResidentAvailablePages;
    ulong  PoolTrackTable;
    ulong  NonPagedPoolDescriptor;
    ulong  MmHighestUserAddress;
    ulong  MmSystemRangeStart;
    ulong  MmUserProbeAddress;
    ulong  KdPrintCircularBuffer;
    ulong  KdPrintCircularBufferEnd;
    ulong  KdPrintWritePointer;
    ulong  KdPrintRolloverCount;
    ulong  MmLoadedUserImageList;
    ulong  NtBuildLab;
    ulong  KiNormalSystemCall;
    ulong  KiProcessorBlock;
    ulong  MmUnloadedDrivers;
    ulong  MmLastUnloadedDriver;
    ulong  MmTriageActionTaken;
    ulong  MmSpecialPoolTag;
    ulong  KernelVerifier;
    ulong  MmVerifierData;
    ulong  MmAllocatedNonPagedPool;
    ulong  MmPeakCommitment;
    ulong  MmTotalCommitLimitMaximum;
    ulong  CmNtCSDVersion;
    ulong  MmPhysicalMemoryBlock;
    ulong  MmSessionBase;
    ulong  MmSessionSize;
    ulong  MmSystemParentTablePage;
    ulong  MmVirtualTranslationBase;
    ushort OffsetKThreadNextProcessor;
    ushort OffsetKThreadTeb;
    ushort OffsetKThreadKernelStack;
    ushort OffsetKThreadInitialStack;
    ushort OffsetKThreadApcProcess;
    ushort OffsetKThreadState;
    ushort OffsetKThreadBStore;
    ushort OffsetKThreadBStoreLimit;
    ushort SizeEProcess;
    ushort OffsetEprocessPeb;
    ushort OffsetEprocessParentCID;
    ushort OffsetEprocessDirectoryTableBase;
    ushort SizePrcb;
    ushort OffsetPrcbDpcRoutine;
    ushort OffsetPrcbCurrentThread;
    ushort OffsetPrcbMhz;
    ushort OffsetPrcbCpuType;
    ushort OffsetPrcbVendorString;
    ushort OffsetPrcbProcStateContext;
    ushort OffsetPrcbNumber;
    ushort SizeEThread;
    ubyte  L1tfHighPhysicalBitIndex;
    ubyte  L1tfSwizzleBitIndex;
    uint   Padding0;
    ulong  KdPrintCircularBufferPtr;
    ulong  KdPrintBufferSize;
    ulong  KeLoaderBlock;
    ushort SizePcr;
    ushort OffsetPcrSelfPcr;
    ushort OffsetPcrCurrentPrcb;
    ushort OffsetPcrContainedPrcb;
    ushort OffsetPcrInitialBStore;
    ushort OffsetPcrBStoreLimit;
    ushort OffsetPcrInitialStack;
    ushort OffsetPcrStackLimit;
    ushort OffsetPrcbPcrPage;
    ushort OffsetPrcbProcStateSpecialReg;
    ushort GdtR0Code;
    ushort GdtR0Data;
    ushort GdtR0Pcr;
    ushort GdtR3Code;
    ushort GdtR3Data;
    ushort GdtR3Teb;
    ushort GdtLdt;
    ushort GdtTss;
    ushort Gdt64R3CmCode;
    ushort Gdt64R3CmTeb;
    ulong  IopNumTriageDumpDataBlocks;
    ulong  IopTriageDumpDataBlocks;
    ulong  VfCrashDataBlock;
    ulong  MmBadPagesDetected;
    ulong  MmZeroedPageSingleBitErrorsDetected;
    ulong  EtwpDebuggerData;
    ushort OffsetPrcbContext;
    ushort OffsetPrcbMaxBreakpoints;
    ushort OffsetPrcbMaxWatchpoints;
    uint   OffsetKThreadStackLimit;
    uint   OffsetKThreadStackBase;
    uint   OffsetKThreadQueueListEntry;
    uint   OffsetEThreadIrpList;
    ushort OffsetPrcbIdleThread;
    ushort OffsetPrcbNormalDpcState;
    ushort OffsetPrcbDpcStack;
    ushort OffsetPrcbIsrStack;
    ushort SizeKDPC_STACK_FRAME;
    ushort OffsetKPriQueueThreadListHead;
    ushort OffsetKThreadWaitReason;
    ushort Padding1;
    ulong  PteBase;
    ulong  RetpolineStubFunctionTable;
    uint   RetpolineStubFunctionTableSize;
    uint   RetpolineStubOffset;
    uint   RetpolineStubSize;
    ushort OffsetEProcessMmHotPatchContext;
    uint   OffsetKThreadShadowStackLimit;
    uint   OffsetKThreadShadowStackBase;
    ulong  ShadowStackEnabled;
    ulong  PointerAuthMask;
    ushort OffsetPrcbExceptionStack;
}

struct FIELD_INFO
{
    ubyte* fName;
    ubyte* printName;
    uint   size;
    uint   fOptions;
    ulong  address;
    union
    {
        void* fieldCallBack;
        void* pBuffer;
    }
    uint   TypeId;
    uint   FieldOffset;
    uint   BufferSize;
    struct BitField
    {
        ushort Position;
        ushort Size;
    }
    // Native bit field: fPointer: [0-1], fArray: [2], fStruct: [3], fConstant: [4], fStatic: [5], Reserved: [6-31]
    uint   _bitfield0;
}

struct SYM_DUMP_PARAM
{
    uint        size;
    ubyte*      sName;
    uint        Options;
    ulong       addr;
    FIELD_INFO* listLink;
    union
    {
        void* Context;
        void* pBuffer;
    }
    PSYM_DUMP_FIELD_CALLBACK CallbackRoutine;
    uint        nFields;
    FIELD_INFO* Fields;
    ulong       ModBase;
    uint        TypeId;
    uint        TypeSize;
    uint        BufferSize;
    // Native bit field: fPointer: [0-1], fArray: [2], fStruct: [3], fConstant: [4], Reserved: [5-31]
    uint        _bitfield0;
}

union POOL_HEADER_SIZE_64
{
    struct
    {
        ubyte UnsafePrevSize;
        ubyte Unused1;
        ubyte UnsafeSize;
        ubyte UnsafePoolType;
    }
    uint Ulong1;
}

struct DEBUG_DEVICE_OBJECT_INFO
{
    uint  SizeOfStruct;
    ulong DevObjAddress;
    uint  ReferenceCount;
    BOOL  QBusy;
    ulong DriverObject;
    ulong CurrentIrp;
    ulong DevExtension;
    ulong DevObjExtension;
}

struct DEBUG_DRIVER_OBJECT_INFO
{
    uint  SizeOfStruct;
    uint  DriverSize;
    ulong DriverObjAddress;
    ulong DriverStart;
    ulong DriverExtension;
    ulong DeviceObject;
    struct DriverName
    {
        ushort Length;
        ushort MaximumLength;
        ulong  Buffer;
    }
}

struct PROCESS_COMMIT_USAGE
{
    ubyte[16] ImageFileName;
    ulong     ClientId;
    ulong     ProcessAddress;
    ulong     CommitCharge;
    ulong     SharedCommitCharge;
    ulong     ReleasedCommitDebt;
    ulong     Reserved;
}

struct DEBUG_CPU_SPEED_INFO
{
    uint       SizeOfStruct;
    uint       CurrentSpeed;
    uint       RatedSpeed;
    wchar[256] NameString;
}

struct DEBUG_CPU_MICROCODE_VERSION
{
    uint SizeOfStruct;
    long CachedSignature;
    long InitialSignature;
    uint ProcessorModel;
    uint ProcessorFamily;
    uint ProcessorStepping;
    uint ProcessorArchRev;
}

struct DEBUG_SMBIOS_INFO
{
    uint     SizeOfStruct;
    ubyte    SmbiosMajorVersion;
    ubyte    SmbiosMinorVersion;
    ubyte    DMIVersion;
    uint     TableSize;
    ubyte    BiosMajorRelease;
    ubyte    BiosMinorRelease;
    ubyte    FirmwareMajorRelease;
    ubyte    FirmwareMinorRelease;
    CHAR[64] BaseBoardManufacturer;
    CHAR[64] BaseBoardProduct;
    CHAR[64] BaseBoardVersion;
    CHAR[64] BiosReleaseDate;
    CHAR[64] BiosVendor;
    CHAR[64] BiosVersion;
    CHAR[64] SystemFamily;
    CHAR[64] SystemManufacturer;
    CHAR[64] SystemProductName;
    CHAR[64] SystemSKU;
    CHAR[64] SystemVersion;
}

struct DEBUG_IRP_STACK_INFO
{
    ubyte Major;
    ubyte Minor;
    ulong DeviceObject;
    ulong FileObject;
    ulong CompletionRoutine;
    ulong StackAddress;
}

struct DEBUG_IRP_INFO
{
    uint                 SizeOfStruct;
    ulong                IrpAddress;
    uint                 IoStatus;
    uint                 StackCount;
    uint                 CurrentLocation;
    ulong                MdlAddress;
    ulong                Thread;
    ulong                CancelRoutine;
    DEBUG_IRP_STACK_INFO CurrentStack;
    DEBUG_IRP_STACK_INFO[10] Stack;
}

struct DEBUG_PNP_TRIAGE_INFO
{
    uint   SizeOfStruct;
    ulong  Lock_Address;
    int    Lock_ActiveCount;
    uint   Lock_ContentionCount;
    uint   Lock_NumberOfExclusiveWaiters;
    uint   Lock_NumberOfSharedWaiters;
    ushort Lock_Flag;
    ulong  TriagedThread;
    int    ThreadCount;
    ulong  TriagedThread_WaitTime;
}

struct DEBUG_POOL_DATA
{
    uint     SizeofStruct;
    ulong    PoolBlock;
    ulong    Pool;
    uint     PreviousSize;
    uint     Size;
    uint     PoolTag;
    ulong    ProcessBilled;
    union
    {
        struct
        {
            // Native bit field: Free: [0], LargePool: [1], SpecialPool: [2], Pageable: [3], Protected: [4], Allocated: [5], Session: [6], Reserved: [7-31]
            uint _bitfield0;
        }
        uint AsUlong;
    }
    ulong[4] Reserved2;
    CHAR[64] PoolTagDescription;
}

struct KDEXT_THREAD_FIND_PARAMS
{
    uint  SizeofStruct;
    ulong StackPointer;
    uint  Cid;
    ulong Thread;
}

struct KDEXT_PROCESS_FIND_PARAMS
{
    uint SizeofStruct;
    uint Pid;
    uint Session;
    PSTR ImageName;
}

struct KDEXT_HANDLE_INFORMATION
{
    ulong   HandleTableEntry;
    ulong   Handle;
    ulong   Object;
    ulong   ObjectBody;
    ulong   GrantedAccess;
    uint    HandleAttributes;
    BOOLEAN PagedOut;
}

struct KDEXT_FILELOCK_OWNER
{
    uint     Sizeofstruct;
    ulong    FileObject;
    ulong    OwnerThread;
    ulong    WaitIrp;
    ulong    DeviceObject;
    CHAR[32] BlockingDirver;
}

struct KDEXTS_LOCK_INFO
{
    uint   SizeOfStruct;
    ulong  Address;
    ulong  OwningThread;
    BOOL   ExclusiveOwned;
    uint   NumOwners;
    uint   ContentionCount;
    uint   NumExclusiveWaiters;
    uint   NumSharedWaiters;
    ulong* pOwnerThreads;
    ulong* pWaiterThreads;
}

struct KDEXTS_PTE_INFO
{
    uint  SizeOfStruct;
    ulong VirtualAddress;
    ulong PpeAddress;
    ulong PdeAddress;
    ulong PteAddress;
    ulong Pfn;
    ulong Levels;
    // Native bit field: PteValid: [0], PteTransition: [1], Prototype: [2], Protection: [3], Reserved: [4-31]
    uint  _bitfield1;
    // Native bit field: ReadInProgress: [0], WriteInProgress: [1], Modified: [2]
    uint  _bitfield2;
}

struct DEBUG_POOLTAG_DESCRIPTION
{
    uint      SizeOfStruct;
    uint      PoolTag;
    CHAR[260] Description;
    CHAR[32]  Binary;
    CHAR[32]  Owner;
}

struct DBG_THREAD_ATTRIBUTES
{
    uint      ThreadIndex;
    ulong     ProcessID;
    ulong     ThreadID;
    ulong     AttributeBits;
    uint      BoolBits;
    ulong     BlockedOnPID;
    ulong     BlockedOnTID;
    ulong     CritSecAddress;
    uint      Timeout_msec;
    CHAR[100] StringData;
    CHAR[100] SymName;
}

struct FA_ENTRY
{
    DEBUG_FLR_PARAM_TYPE Tag;
    ushort               FullSize;
    ushort               DataSize;
}

struct OS_INFO
{
    uint      MajorVer;
    uint      MinorVer;
    uint      Build;
    uint      BuildQfe;
    uint      ProductType;
    uint      Suite;
    uint      Revision;
    struct s
    {
        // Native bit field: Checked: [0], Pae: [1], MultiProc: [2], Reserved: [3-31]
        uint _bitfield0;
    }
    uint      SrvPackNumber;
    uint      ServicePackBuild;
    uint      Architecture;
    uint      Lcid;
    CHAR[64]  Name;
    CHAR[256] FullName;
    CHAR[30]  Language;
    CHAR[64]  BuildVersion;
    CHAR[64]  ServicePackString;
}

struct CPU_INFO
{
    uint Type;
    uint NumCPUs;
    uint CurrentProc;
    DEBUG_PROCESSOR_IDENTIFICATION_ALL[2048] ProcInfo;
    uint Mhz;
}

struct TARGET_DEBUG_INFO
{
    uint      SizeOfStruct;
    ulong     EntryDate;
    uint      DebugeeClass;
    ulong     SysUpTime;
    ulong     AppUpTime;
    ulong     CrashTime;
    OS_INFO   OsInfo;
    CPU_INFO  Cpu;
    CHAR[260] DumpFile;
}

struct CPU_INFO_v2
{
    uint Type;
    uint NumCPUs;
    uint CurrentProc;
    DEBUG_PROCESSOR_IDENTIFICATION_ALL[1280] ProcInfo;
    uint Mhz;
}

struct TARGET_DEBUG_INFO_v2
{
    uint        SizeOfStruct;
    ulong       EntryDate;
    uint        DebugeeClass;
    ulong       SysUpTime;
    ulong       AppUpTime;
    ulong       CrashTime;
    OS_INFO     OsInfo;
    CPU_INFO_v2 Cpu;
    CHAR[260]   DumpFile;
}

struct OS_INFO_v1
{
    OS_TYPE  Type;
    union
    {
        struct Version
        {
            uint Major;
            uint Minor;
        }
        ulong Ver64;
    }
    uint     ProductType;
    uint     Suite;
    struct s
    {
        // Native bit field: Checked: [0], Pae: [1], MultiProc: [2], Reserved: [3-31]
        uint _bitfield0;
    }
    uint     SrvPackNumber;
    CHAR[30] Language;
    CHAR[64] OsString;
    CHAR[64] ServicePackString;
}

struct CPU_INFO_v1
{
    uint Type;
    uint NumCPUs;
    uint CurrentProc;
    DEBUG_PROCESSOR_IDENTIFICATION_ALL[32] ProcInfo;
    uint Mhz;
}

struct TARGET_DEBUG_INFO_v1
{
    uint        SizeOfStruct;
    ulong       Id;
    ulong       Source;
    ulong       EntryDate;
    ulong       SysUpTime;
    ulong       AppUpTime;
    ulong       CrashTime;
    ulong       Mode;
    OS_INFO_v1  OsInfo;
    CPU_INFO_v1 Cpu;
    CHAR[260]   DumpFile;
    void*       FailureData;
    CHAR[4096]  StackTr;
}

struct DEBUG_DECODE_ERROR
{
    uint      SizeOfStruct;
    uint      Code;
    BOOL      TreatAsStatus;
    CHAR[64]  Source;
    CHAR[260] Message;
}

struct DEBUG_TRIAGE_FOLLOWUP_INFO
{
    uint SizeOfStruct;
    uint OwnerNameSize;
    PSTR OwnerName;
}

struct DEBUG_TRIAGE_FOLLOWUP_INFO_2
{
    uint SizeOfStruct;
    uint OwnerNameSize;
    PSTR OwnerName;
    uint FeaturePathSize;
    PSTR FeaturePath;
}

struct EXT_CAB_XML_DATA
{
    uint         SizeOfStruct;
    const(PWSTR) XmlObjectTag;
    uint         NumSubTags;
    struct SubTags
    {
        const(PWSTR) SubTag;
        const(PWSTR) MatchPattern;
        PWSTR        ReturnText;
        uint         ReturnTextSize;
        // Native bit field: MatchType: [0-2], Reserved: [3-31]
        uint         _bitfield0;
        uint         Reserved2;
    }
}

struct XML_DRIVER_NODE_INFO
{
    CHAR[64]  FileName;
    ulong     FileSize;
    ulong     CreationDate;
    CHAR[64]  Version;
    CHAR[260] Manufacturer;
    CHAR[260] ProductName;
    CHAR[260] Group;
    CHAR[260] Altitude;
}

struct DEBUG_ANALYSIS_PROCESSOR_INFO
{
    uint     SizeOfStruct;
    uint     Model;
    uint     Family;
    uint     Stepping;
    uint     Architecture;
    uint     Revision;
    uint     CurrentClockSpeed;
    uint     CurrentVoltage;
    uint     MaxClockSpeed;
    uint     ProcessorType;
    CHAR[32] DeviceID;
    CHAR[64] Manufacturer;
    CHAR[64] Name;
    CHAR[64] Version;
    CHAR[64] Description;
}

struct CKCL_DATA
{
    void*           NextLogEvent;
    PSTR            TAnalyzeString;
    TANALYZE_RETURN TAnalyzeReturnType;
}

struct CKCL_LISTHEAD
{
    CKCL_DATA* LogEventListHead;
    HANDLE     Heap;
}

// Functions

@DllImport("dbgeng.dll")
HRESULT DebugConnect(const(PSTR) RemoteOptions, const(GUID)* InterfaceId, void** Interface);

@DllImport("dbgeng.dll")
HRESULT DebugConnectWide(const(PWSTR) RemoteOptions, const(GUID)* InterfaceId, void** Interface);

@DllImport("dbgeng.dll")
HRESULT DebugCreate(const(GUID)* InterfaceId, void** Interface);

@DllImport("dbgeng.dll")
HRESULT DebugCreateEx(const(GUID)* InterfaceId, uint DbgEngOptions, void** Interface);

@DllImport("dbgmodel.dll")
HRESULT CreateDataModelManager(IDebugHost debugHost, IDataModelManager* manager);


// Interfaces

@GUID("f2df5f53-071f-47bd-9de6-5734c3fed689")
interface IDebugAdvanced : IUnknown
{
    HRESULT GetThreadContext(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* Context, 
                             uint ContextSize);
    HRESULT SetThreadContext(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* Context, 
                             uint ContextSize);
}

@GUID("716d14c9-119b-4ba5-af1f-0890e672416a")
interface IDebugAdvanced2 : IUnknown
{
    HRESULT GetThreadContext(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* Context, 
                             uint ContextSize);
    HRESULT SetThreadContext(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* Context, 
                             uint ContextSize);
    HRESULT Request(uint Request, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* InBuffer, 
                    uint InBufferSize, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* OutBuffer, 
                    uint OutBufferSize, uint* OutSize);
    HRESULT GetSourceFileInformation(uint Which, PSTR SourceFile, ulong Arg64, uint Arg32, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                                     uint BufferSize, uint* InfoSize);
    HRESULT FindSourceFileAndToken(uint StartElement, ulong ModAddr, const(PSTR) File, uint Flags, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* FileToken, 
                                   uint FileTokenSize, uint* FoundElement, PSTR Buffer, uint BufferSize, 
                                   uint* FoundSize);
    HRESULT GetSymbolInformation(uint Which, ulong Arg64, uint Arg32, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                 uint BufferSize, uint* InfoSize, PSTR StringBuffer, uint StringBufferSize, 
                                 uint* StringSize);
    HRESULT GetSystemObjectInformation(uint Which, ulong Arg64, uint Arg32, 
                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                       uint BufferSize, uint* InfoSize);
}

@GUID("cba4abb4-84c4-444d-87ca-a04e13286739")
interface IDebugAdvanced3 : IUnknown
{
    HRESULT GetThreadContext(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* Context, 
                             uint ContextSize);
    HRESULT SetThreadContext(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* Context, 
                             uint ContextSize);
    HRESULT Request(uint Request, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* InBuffer, 
                    uint InBufferSize, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* OutBuffer, 
                    uint OutBufferSize, uint* OutSize);
    HRESULT GetSourceFileInformation(uint Which, PSTR SourceFile, ulong Arg64, uint Arg32, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                                     uint BufferSize, uint* InfoSize);
    HRESULT FindSourceFileAndToken(uint StartElement, ulong ModAddr, const(PSTR) File, uint Flags, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* FileToken, 
                                   uint FileTokenSize, uint* FoundElement, PSTR Buffer, uint BufferSize, 
                                   uint* FoundSize);
    HRESULT GetSymbolInformation(uint Which, ulong Arg64, uint Arg32, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                 uint BufferSize, uint* InfoSize, PSTR StringBuffer, uint StringBufferSize, 
                                 uint* StringSize);
    HRESULT GetSystemObjectInformation(uint Which, ulong Arg64, uint Arg32, 
                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                       uint BufferSize, uint* InfoSize);
    HRESULT GetSourceFileInformationWide(uint Which, PWSTR SourceFile, ulong Arg64, uint Arg32, 
                                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                                         uint BufferSize, uint* InfoSize);
    HRESULT FindSourceFileAndTokenWide(uint StartElement, ulong ModAddr, const(PWSTR) File, uint Flags, 
                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* FileToken, 
                                       uint FileTokenSize, uint* FoundElement, PWSTR Buffer, uint BufferSize, 
                                       uint* FoundSize);
    HRESULT GetSymbolInformationWide(uint Which, ulong Arg64, uint Arg32, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                     uint BufferSize, uint* InfoSize, PWSTR StringBuffer, uint StringBufferSize, 
                                     uint* StringSize);
}

@GUID("d1069067-2a65-4bf0-ae97-76184b67856b")
interface IDebugAdvanced4 : IUnknown
{
    HRESULT GetThreadContext(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* Context, 
                             uint ContextSize);
    HRESULT SetThreadContext(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* Context, 
                             uint ContextSize);
    HRESULT Request(uint Request, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* InBuffer, 
                    uint InBufferSize, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* OutBuffer, 
                    uint OutBufferSize, uint* OutSize);
    HRESULT GetSourceFileInformation(uint Which, PSTR SourceFile, ulong Arg64, uint Arg32, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                                     uint BufferSize, uint* InfoSize);
    HRESULT FindSourceFileAndToken(uint StartElement, ulong ModAddr, const(PSTR) File, uint Flags, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* FileToken, 
                                   uint FileTokenSize, uint* FoundElement, PSTR Buffer, uint BufferSize, 
                                   uint* FoundSize);
    HRESULT GetSymbolInformation(uint Which, ulong Arg64, uint Arg32, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                 uint BufferSize, uint* InfoSize, PSTR StringBuffer, uint StringBufferSize, 
                                 uint* StringSize);
    HRESULT GetSystemObjectInformation(uint Which, ulong Arg64, uint Arg32, 
                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                       uint BufferSize, uint* InfoSize);
    HRESULT GetSourceFileInformationWide(uint Which, PWSTR SourceFile, ulong Arg64, uint Arg32, 
                                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                                         uint BufferSize, uint* InfoSize);
    HRESULT FindSourceFileAndTokenWide(uint StartElement, ulong ModAddr, const(PWSTR) File, uint Flags, 
                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* FileToken, 
                                       uint FileTokenSize, uint* FoundElement, PWSTR Buffer, uint BufferSize, 
                                       uint* FoundSize);
    HRESULT GetSymbolInformationWide(uint Which, ulong Arg64, uint Arg32, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                     uint BufferSize, uint* InfoSize, PWSTR StringBuffer, uint StringBufferSize, 
                                     uint* StringSize);
    HRESULT GetSymbolInformationWideEx(uint Which, ulong Arg64, uint Arg32, 
                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                       uint BufferSize, uint* InfoSize, PWSTR StringBuffer, uint StringBufferSize, 
                                       uint* StringSize, SYMBOL_INFO_EX* pInfoEx);
}

@GUID("5bd9d474-5975-423a-b88b-65a8e7110e65")
interface IDebugBreakpoint : IUnknown
{
    HRESULT GetId(uint* Id);
    HRESULT GetType(uint* BreakType, uint* ProcType);
    HRESULT GetAdder(IDebugClient* Adder);
    HRESULT GetFlags(uint* Flags);
    HRESULT AddFlags(uint Flags);
    HRESULT RemoveFlags(uint Flags);
    HRESULT SetFlags(uint Flags);
    HRESULT GetOffset(ulong* Offset);
    HRESULT SetOffset(ulong Offset);
    HRESULT GetDataParameters(uint* Size, uint* AccessType);
    HRESULT SetDataParameters(uint Size, uint AccessType);
    HRESULT GetPassCount(uint* Count);
    HRESULT SetPassCount(uint Count);
    HRESULT GetCurrentPassCount(uint* Count);
    HRESULT GetMatchThreadId(uint* Id);
    HRESULT SetMatchThreadId(uint Thread);
    HRESULT GetCommand(PSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetCommand(const(PSTR) Command);
    HRESULT GetOffsetExpression(PSTR Buffer, uint BufferSize, uint* ExpressionSize);
    HRESULT SetOffsetExpression(const(PSTR) Expression);
    HRESULT GetParameters(DEBUG_BREAKPOINT_PARAMETERS* Params);
}

@GUID("1b278d20-79f2-426e-a3f9-c1ddf375d48e")
interface IDebugBreakpoint2 : IUnknown
{
    HRESULT GetId(uint* Id);
    HRESULT GetType(uint* BreakType, uint* ProcType);
    HRESULT GetAdder(IDebugClient* Adder);
    HRESULT GetFlags(uint* Flags);
    HRESULT AddFlags(uint Flags);
    HRESULT RemoveFlags(uint Flags);
    HRESULT SetFlags(uint Flags);
    HRESULT GetOffset(ulong* Offset);
    HRESULT SetOffset(ulong Offset);
    HRESULT GetDataParameters(uint* Size, uint* AccessType);
    HRESULT SetDataParameters(uint Size, uint AccessType);
    HRESULT GetPassCount(uint* Count);
    HRESULT SetPassCount(uint Count);
    HRESULT GetCurrentPassCount(uint* Count);
    HRESULT GetMatchThreadId(uint* Id);
    HRESULT SetMatchThreadId(uint Thread);
    HRESULT GetCommand(PSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetCommand(const(PSTR) Command);
    HRESULT GetOffsetExpression(PSTR Buffer, uint BufferSize, uint* ExpressionSize);
    HRESULT SetOffsetExpression(const(PSTR) Expression);
    HRESULT GetParameters(DEBUG_BREAKPOINT_PARAMETERS* Params);
    HRESULT GetCommandWide(PWSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetCommandWide(const(PWSTR) Command);
    HRESULT GetOffsetExpressionWide(PWSTR Buffer, uint BufferSize, uint* ExpressionSize);
    HRESULT SetOffsetExpressionWide(const(PWSTR) Expression);
}

@GUID("38f5c249-b448-43bb-9835-579d4ec02249")
interface IDebugBreakpoint3 : IUnknown
{
    HRESULT GetId(uint* Id);
    HRESULT GetType(uint* BreakType, uint* ProcType);
    HRESULT GetAdder(IDebugClient* Adder);
    HRESULT GetFlags(uint* Flags);
    HRESULT AddFlags(uint Flags);
    HRESULT RemoveFlags(uint Flags);
    HRESULT SetFlags(uint Flags);
    HRESULT GetOffset(ulong* Offset);
    HRESULT SetOffset(ulong Offset);
    HRESULT GetDataParameters(uint* Size, uint* AccessType);
    HRESULT SetDataParameters(uint Size, uint AccessType);
    HRESULT GetPassCount(uint* Count);
    HRESULT SetPassCount(uint Count);
    HRESULT GetCurrentPassCount(uint* Count);
    HRESULT GetMatchThreadId(uint* Id);
    HRESULT SetMatchThreadId(uint Thread);
    HRESULT GetCommand(PSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetCommand(const(PSTR) Command);
    HRESULT GetOffsetExpression(PSTR Buffer, uint BufferSize, uint* ExpressionSize);
    HRESULT SetOffsetExpression(const(PSTR) Expression);
    HRESULT GetParameters(DEBUG_BREAKPOINT_PARAMETERS* Params);
    HRESULT GetCommandWide(PWSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetCommandWide(const(PWSTR) Command);
    HRESULT GetOffsetExpressionWide(PWSTR Buffer, uint BufferSize, uint* ExpressionSize);
    HRESULT SetOffsetExpressionWide(const(PWSTR) Expression);
    HRESULT GetGuid(GUID* Guid);
}

@GUID("27fe5639-8407-4f47-8364-ee118fb08ac8")
interface IDebugClient : IUnknown
{
    HRESULT AttachKernel(uint Flags, const(PSTR) ConnectOptions);
    HRESULT GetKernelConnectionOptions(PSTR Buffer, uint BufferSize, uint* OptionsSize);
    HRESULT SetKernelConnectionOptions(const(PSTR) Options);
    HRESULT StartProcessServer(uint Flags, const(PSTR) Options, 
                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved);
    HRESULT ConnectProcessServer(const(PSTR) RemoteOptions, ulong* Server);
    HRESULT DisconnectProcessServer(ulong Server);
    HRESULT GetRunningProcessSystemIds(ulong Server, uint* Ids, uint Count, uint* ActualCount);
    HRESULT GetRunningProcessSystemIdByExecutableName(ulong Server, const(PSTR) ExeName, uint Flags, uint* Id);
    HRESULT GetRunningProcessDescription(ulong Server, uint SystemId, uint Flags, PSTR ExeName, uint ExeNameSize, 
                                         uint* ActualExeNameSize, PSTR Description, uint DescriptionSize, 
                                         uint* ActualDescriptionSize);
    HRESULT AttachProcess(ulong Server, uint ProcessId, uint AttachFlags);
    HRESULT CreateProcessA(ulong Server, PSTR CommandLine, uint CreateFlags);
    HRESULT CreateProcessAndAttach(ulong Server, PSTR CommandLine, uint CreateFlags, uint ProcessId, 
                                   uint AttachFlags);
    HRESULT GetProcessOptions(uint* Options);
    HRESULT AddProcessOptions(uint Options);
    HRESULT RemoveProcessOptions(uint Options);
    HRESULT SetProcessOptions(uint Options);
    HRESULT OpenDumpFile(const(PSTR) DumpFile);
    HRESULT WriteDumpFile(const(PSTR) DumpFile, uint Qualifier);
    HRESULT ConnectSession(uint Flags, uint HistoryLimit);
    HRESULT StartServer(const(PSTR) Options);
    HRESULT OutputServers(uint OutputControl, const(PSTR) Machine, uint Flags);
    HRESULT TerminateProcesses();
    HRESULT DetachProcesses();
    HRESULT EndSession(uint Flags);
    HRESULT GetExitCode(uint* Code);
    HRESULT DispatchCallbacks(uint Timeout);
    HRESULT ExitDispatch(IDebugClient Client);
    HRESULT CreateClient(IDebugClient* Client);
    HRESULT GetInputCallbacks(IDebugInputCallbacks* Callbacks);
    HRESULT SetInputCallbacks(IDebugInputCallbacks Callbacks);
    HRESULT GetOutputCallbacks(IDebugOutputCallbacks* Callbacks);
    HRESULT SetOutputCallbacks(IDebugOutputCallbacks Callbacks);
    HRESULT GetOutputMask(uint* Mask);
    HRESULT SetOutputMask(uint Mask);
    HRESULT GetOtherOutputMask(IDebugClient Client, uint* Mask);
    HRESULT SetOtherOutputMask(IDebugClient Client, uint Mask);
    HRESULT GetOutputWidth(uint* Columns);
    HRESULT SetOutputWidth(uint Columns);
    HRESULT GetOutputLinePrefix(PSTR Buffer, uint BufferSize, uint* PrefixSize);
    HRESULT SetOutputLinePrefix(const(PSTR) Prefix);
    HRESULT GetIdentity(PSTR Buffer, uint BufferSize, uint* IdentitySize);
    HRESULT OutputIdentity(uint OutputControl, uint Flags, const(PSTR) Format);
    HRESULT GetEventCallbacks(IDebugEventCallbacks* Callbacks);
    HRESULT SetEventCallbacks(IDebugEventCallbacks Callbacks);
    HRESULT FlushCallbacks();
}

@GUID("edbed635-372e-4dab-bbfe-ed0d2f63be81")
interface IDebugClient2 : IUnknown
{
    HRESULT AttachKernel(uint Flags, const(PSTR) ConnectOptions);
    HRESULT GetKernelConnectionOptions(PSTR Buffer, uint BufferSize, uint* OptionsSize);
    HRESULT SetKernelConnectionOptions(const(PSTR) Options);
    HRESULT StartProcessServer(uint Flags, const(PSTR) Options, 
                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved);
    HRESULT ConnectProcessServer(const(PSTR) RemoteOptions, ulong* Server);
    HRESULT DisconnectProcessServer(ulong Server);
    HRESULT GetRunningProcessSystemIds(ulong Server, uint* Ids, uint Count, uint* ActualCount);
    HRESULT GetRunningProcessSystemIdByExecutableName(ulong Server, const(PSTR) ExeName, uint Flags, uint* Id);
    HRESULT GetRunningProcessDescription(ulong Server, uint SystemId, uint Flags, PSTR ExeName, uint ExeNameSize, 
                                         uint* ActualExeNameSize, PSTR Description, uint DescriptionSize, 
                                         uint* ActualDescriptionSize);
    HRESULT AttachProcess(ulong Server, uint ProcessId, uint AttachFlags);
    HRESULT CreateProcessA(ulong Server, PSTR CommandLine, uint CreateFlags);
    HRESULT CreateProcessAndAttach(ulong Server, PSTR CommandLine, uint CreateFlags, uint ProcessId, 
                                   uint AttachFlags);
    HRESULT GetProcessOptions(uint* Options);
    HRESULT AddProcessOptions(uint Options);
    HRESULT RemoveProcessOptions(uint Options);
    HRESULT SetProcessOptions(uint Options);
    HRESULT OpenDumpFile(const(PSTR) DumpFile);
    HRESULT WriteDumpFile(const(PSTR) DumpFile, uint Qualifier);
    HRESULT ConnectSession(uint Flags, uint HistoryLimit);
    HRESULT StartServer(const(PSTR) Options);
    HRESULT OutputServers(uint OutputControl, const(PSTR) Machine, uint Flags);
    HRESULT TerminateProcesses();
    HRESULT DetachProcesses();
    HRESULT EndSession(uint Flags);
    HRESULT GetExitCode(uint* Code);
    HRESULT DispatchCallbacks(uint Timeout);
    HRESULT ExitDispatch(IDebugClient Client);
    HRESULT CreateClient(IDebugClient* Client);
    HRESULT GetInputCallbacks(IDebugInputCallbacks* Callbacks);
    HRESULT SetInputCallbacks(IDebugInputCallbacks Callbacks);
    HRESULT GetOutputCallbacks(IDebugOutputCallbacks* Callbacks);
    HRESULT SetOutputCallbacks(IDebugOutputCallbacks Callbacks);
    HRESULT GetOutputMask(uint* Mask);
    HRESULT SetOutputMask(uint Mask);
    HRESULT GetOtherOutputMask(IDebugClient Client, uint* Mask);
    HRESULT SetOtherOutputMask(IDebugClient Client, uint Mask);
    HRESULT GetOutputWidth(uint* Columns);
    HRESULT SetOutputWidth(uint Columns);
    HRESULT GetOutputLinePrefix(PSTR Buffer, uint BufferSize, uint* PrefixSize);
    HRESULT SetOutputLinePrefix(const(PSTR) Prefix);
    HRESULT GetIdentity(PSTR Buffer, uint BufferSize, uint* IdentitySize);
    HRESULT OutputIdentity(uint OutputControl, uint Flags, const(PSTR) Format);
    HRESULT GetEventCallbacks(IDebugEventCallbacks* Callbacks);
    HRESULT SetEventCallbacks(IDebugEventCallbacks Callbacks);
    HRESULT FlushCallbacks();
    HRESULT WriteDumpFile2(const(PSTR) DumpFile, uint Qualifier, uint FormatFlags, const(PSTR) Comment);
    HRESULT AddDumpInformationFile(const(PSTR) InfoFile, uint Type);
    HRESULT EndProcessServer(ulong Server);
    HRESULT WaitForProcessServerEnd(uint Timeout);
    HRESULT IsKernelDebuggerEnabled();
    HRESULT TerminateCurrentProcess();
    HRESULT DetachCurrentProcess();
    HRESULT AbandonCurrentProcess();
}

@GUID("dd492d7f-71b8-4ad6-a8dc-1c887479ff91")
interface IDebugClient3 : IUnknown
{
    HRESULT AttachKernel(uint Flags, const(PSTR) ConnectOptions);
    HRESULT GetKernelConnectionOptions(PSTR Buffer, uint BufferSize, uint* OptionsSize);
    HRESULT SetKernelConnectionOptions(const(PSTR) Options);
    HRESULT StartProcessServer(uint Flags, const(PSTR) Options, 
                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved);
    HRESULT ConnectProcessServer(const(PSTR) RemoteOptions, ulong* Server);
    HRESULT DisconnectProcessServer(ulong Server);
    HRESULT GetRunningProcessSystemIds(ulong Server, uint* Ids, uint Count, uint* ActualCount);
    HRESULT GetRunningProcessSystemIdByExecutableName(ulong Server, const(PSTR) ExeName, uint Flags, uint* Id);
    HRESULT GetRunningProcessDescription(ulong Server, uint SystemId, uint Flags, PSTR ExeName, uint ExeNameSize, 
                                         uint* ActualExeNameSize, PSTR Description, uint DescriptionSize, 
                                         uint* ActualDescriptionSize);
    HRESULT AttachProcess(ulong Server, uint ProcessId, uint AttachFlags);
    HRESULT CreateProcessA(ulong Server, PSTR CommandLine, uint CreateFlags);
    HRESULT CreateProcessAndAttach(ulong Server, PSTR CommandLine, uint CreateFlags, uint ProcessId, 
                                   uint AttachFlags);
    HRESULT GetProcessOptions(uint* Options);
    HRESULT AddProcessOptions(uint Options);
    HRESULT RemoveProcessOptions(uint Options);
    HRESULT SetProcessOptions(uint Options);
    HRESULT OpenDumpFile(const(PSTR) DumpFile);
    HRESULT WriteDumpFile(const(PSTR) DumpFile, uint Qualifier);
    HRESULT ConnectSession(uint Flags, uint HistoryLimit);
    HRESULT StartServer(const(PSTR) Options);
    HRESULT OutputServers(uint OutputControl, const(PSTR) Machine, uint Flags);
    HRESULT TerminateProcesses();
    HRESULT DetachProcesses();
    HRESULT EndSession(uint Flags);
    HRESULT GetExitCode(uint* Code);
    HRESULT DispatchCallbacks(uint Timeout);
    HRESULT ExitDispatch(IDebugClient Client);
    HRESULT CreateClient(IDebugClient* Client);
    HRESULT GetInputCallbacks(IDebugInputCallbacks* Callbacks);
    HRESULT SetInputCallbacks(IDebugInputCallbacks Callbacks);
    HRESULT GetOutputCallbacks(IDebugOutputCallbacks* Callbacks);
    HRESULT SetOutputCallbacks(IDebugOutputCallbacks Callbacks);
    HRESULT GetOutputMask(uint* Mask);
    HRESULT SetOutputMask(uint Mask);
    HRESULT GetOtherOutputMask(IDebugClient Client, uint* Mask);
    HRESULT SetOtherOutputMask(IDebugClient Client, uint Mask);
    HRESULT GetOutputWidth(uint* Columns);
    HRESULT SetOutputWidth(uint Columns);
    HRESULT GetOutputLinePrefix(PSTR Buffer, uint BufferSize, uint* PrefixSize);
    HRESULT SetOutputLinePrefix(const(PSTR) Prefix);
    HRESULT GetIdentity(PSTR Buffer, uint BufferSize, uint* IdentitySize);
    HRESULT OutputIdentity(uint OutputControl, uint Flags, const(PSTR) Format);
    HRESULT GetEventCallbacks(IDebugEventCallbacks* Callbacks);
    HRESULT SetEventCallbacks(IDebugEventCallbacks Callbacks);
    HRESULT FlushCallbacks();
    HRESULT WriteDumpFile2(const(PSTR) DumpFile, uint Qualifier, uint FormatFlags, const(PSTR) Comment);
    HRESULT AddDumpInformationFile(const(PSTR) InfoFile, uint Type);
    HRESULT EndProcessServer(ulong Server);
    HRESULT WaitForProcessServerEnd(uint Timeout);
    HRESULT IsKernelDebuggerEnabled();
    HRESULT TerminateCurrentProcess();
    HRESULT DetachCurrentProcess();
    HRESULT AbandonCurrentProcess();
    HRESULT GetRunningProcessSystemIdByExecutableNameWide(ulong Server, const(PWSTR) ExeName, uint Flags, uint* Id);
    HRESULT GetRunningProcessDescriptionWide(ulong Server, uint SystemId, uint Flags, PWSTR ExeName, 
                                             uint ExeNameSize, uint* ActualExeNameSize, PWSTR Description, 
                                             uint DescriptionSize, uint* ActualDescriptionSize);
    HRESULT CreateProcessWide(ulong Server, PWSTR CommandLine, uint CreateFlags);
    HRESULT CreateProcessAndAttachWide(ulong Server, PWSTR CommandLine, uint CreateFlags, uint ProcessId, 
                                       uint AttachFlags);
}

@GUID("ca83c3de-5089-4cf8-93c8-d892387f2a5e")
interface IDebugClient4 : IUnknown
{
    HRESULT AttachKernel(uint Flags, const(PSTR) ConnectOptions);
    HRESULT GetKernelConnectionOptions(PSTR Buffer, uint BufferSize, uint* OptionsSize);
    HRESULT SetKernelConnectionOptions(const(PSTR) Options);
    HRESULT StartProcessServer(uint Flags, const(PSTR) Options, 
                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved);
    HRESULT ConnectProcessServer(const(PSTR) RemoteOptions, ulong* Server);
    HRESULT DisconnectProcessServer(ulong Server);
    HRESULT GetRunningProcessSystemIds(ulong Server, uint* Ids, uint Count, uint* ActualCount);
    HRESULT GetRunningProcessSystemIdByExecutableName(ulong Server, const(PSTR) ExeName, uint Flags, uint* Id);
    HRESULT GetRunningProcessDescription(ulong Server, uint SystemId, uint Flags, PSTR ExeName, uint ExeNameSize, 
                                         uint* ActualExeNameSize, PSTR Description, uint DescriptionSize, 
                                         uint* ActualDescriptionSize);
    HRESULT AttachProcess(ulong Server, uint ProcessId, uint AttachFlags);
    HRESULT CreateProcessA(ulong Server, PSTR CommandLine, uint CreateFlags);
    HRESULT CreateProcessAndAttach(ulong Server, PSTR CommandLine, uint CreateFlags, uint ProcessId, 
                                   uint AttachFlags);
    HRESULT GetProcessOptions(uint* Options);
    HRESULT AddProcessOptions(uint Options);
    HRESULT RemoveProcessOptions(uint Options);
    HRESULT SetProcessOptions(uint Options);
    HRESULT OpenDumpFile(const(PSTR) DumpFile);
    HRESULT WriteDumpFile(const(PSTR) DumpFile, uint Qualifier);
    HRESULT ConnectSession(uint Flags, uint HistoryLimit);
    HRESULT StartServer(const(PSTR) Options);
    HRESULT OutputServers(uint OutputControl, const(PSTR) Machine, uint Flags);
    HRESULT TerminateProcesses();
    HRESULT DetachProcesses();
    HRESULT EndSession(uint Flags);
    HRESULT GetExitCode(uint* Code);
    HRESULT DispatchCallbacks(uint Timeout);
    HRESULT ExitDispatch(IDebugClient Client);
    HRESULT CreateClient(IDebugClient* Client);
    HRESULT GetInputCallbacks(IDebugInputCallbacks* Callbacks);
    HRESULT SetInputCallbacks(IDebugInputCallbacks Callbacks);
    HRESULT GetOutputCallbacks(IDebugOutputCallbacks* Callbacks);
    HRESULT SetOutputCallbacks(IDebugOutputCallbacks Callbacks);
    HRESULT GetOutputMask(uint* Mask);
    HRESULT SetOutputMask(uint Mask);
    HRESULT GetOtherOutputMask(IDebugClient Client, uint* Mask);
    HRESULT SetOtherOutputMask(IDebugClient Client, uint Mask);
    HRESULT GetOutputWidth(uint* Columns);
    HRESULT SetOutputWidth(uint Columns);
    HRESULT GetOutputLinePrefix(PSTR Buffer, uint BufferSize, uint* PrefixSize);
    HRESULT SetOutputLinePrefix(const(PSTR) Prefix);
    HRESULT GetIdentity(PSTR Buffer, uint BufferSize, uint* IdentitySize);
    HRESULT OutputIdentity(uint OutputControl, uint Flags, const(PSTR) Format);
    HRESULT GetEventCallbacks(IDebugEventCallbacks* Callbacks);
    HRESULT SetEventCallbacks(IDebugEventCallbacks Callbacks);
    HRESULT FlushCallbacks();
    HRESULT WriteDumpFile2(const(PSTR) DumpFile, uint Qualifier, uint FormatFlags, const(PSTR) Comment);
    HRESULT AddDumpInformationFile(const(PSTR) InfoFile, uint Type);
    HRESULT EndProcessServer(ulong Server);
    HRESULT WaitForProcessServerEnd(uint Timeout);
    HRESULT IsKernelDebuggerEnabled();
    HRESULT TerminateCurrentProcess();
    HRESULT DetachCurrentProcess();
    HRESULT AbandonCurrentProcess();
    HRESULT GetRunningProcessSystemIdByExecutableNameWide(ulong Server, const(PWSTR) ExeName, uint Flags, uint* Id);
    HRESULT GetRunningProcessDescriptionWide(ulong Server, uint SystemId, uint Flags, PWSTR ExeName, 
                                             uint ExeNameSize, uint* ActualExeNameSize, PWSTR Description, 
                                             uint DescriptionSize, uint* ActualDescriptionSize);
    HRESULT CreateProcessWide(ulong Server, PWSTR CommandLine, uint CreateFlags);
    HRESULT CreateProcessAndAttachWide(ulong Server, PWSTR CommandLine, uint CreateFlags, uint ProcessId, 
                                       uint AttachFlags);
    HRESULT OpenDumpFileWide(const(PWSTR) FileName, ulong FileHandle);
    HRESULT WriteDumpFileWide(const(PWSTR) FileName, ulong FileHandle, uint Qualifier, uint FormatFlags, 
                              const(PWSTR) Comment);
    HRESULT AddDumpInformationFileWide(const(PWSTR) FileName, ulong FileHandle, uint Type);
    HRESULT GetNumberDumpFiles(uint* Number);
    HRESULT GetDumpFile(uint Index, PSTR Buffer, uint BufferSize, uint* NameSize, ulong* Handle, uint* Type);
    HRESULT GetDumpFileWide(uint Index, PWSTR Buffer, uint BufferSize, uint* NameSize, ulong* Handle, uint* Type);
}

@GUID("e3acb9d7-7ec2-4f0c-a0da-e81e0cbbe628")
interface IDebugClient5 : IUnknown
{
    HRESULT AttachKernel(uint Flags, const(PSTR) ConnectOptions);
    HRESULT GetKernelConnectionOptions(PSTR Buffer, uint BufferSize, uint* OptionsSize);
    HRESULT SetKernelConnectionOptions(const(PSTR) Options);
    HRESULT StartProcessServer(uint Flags, const(PSTR) Options, 
                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved);
    HRESULT ConnectProcessServer(const(PSTR) RemoteOptions, ulong* Server);
    HRESULT DisconnectProcessServer(ulong Server);
    HRESULT GetRunningProcessSystemIds(ulong Server, uint* Ids, uint Count, uint* ActualCount);
    HRESULT GetRunningProcessSystemIdByExecutableName(ulong Server, const(PSTR) ExeName, uint Flags, uint* Id);
    HRESULT GetRunningProcessDescription(ulong Server, uint SystemId, uint Flags, PSTR ExeName, uint ExeNameSize, 
                                         uint* ActualExeNameSize, PSTR Description, uint DescriptionSize, 
                                         uint* ActualDescriptionSize);
    HRESULT AttachProcess(ulong Server, uint ProcessId, uint AttachFlags);
    HRESULT CreateProcessA(ulong Server, PSTR CommandLine, uint CreateFlags);
    HRESULT CreateProcessAndAttach(ulong Server, PSTR CommandLine, uint CreateFlags, uint ProcessId, 
                                   uint AttachFlags);
    HRESULT GetProcessOptions(uint* Options);
    HRESULT AddProcessOptions(uint Options);
    HRESULT RemoveProcessOptions(uint Options);
    HRESULT SetProcessOptions(uint Options);
    HRESULT OpenDumpFile(const(PSTR) DumpFile);
    HRESULT WriteDumpFile(const(PSTR) DumpFile, uint Qualifier);
    HRESULT ConnectSession(uint Flags, uint HistoryLimit);
    HRESULT StartServer(const(PSTR) Options);
    HRESULT OutputServers(uint OutputControl, const(PSTR) Machine, uint Flags);
    HRESULT TerminateProcesses();
    HRESULT DetachProcesses();
    HRESULT EndSession(uint Flags);
    HRESULT GetExitCode(uint* Code);
    HRESULT DispatchCallbacks(uint Timeout);
    HRESULT ExitDispatch(IDebugClient Client);
    HRESULT CreateClient(IDebugClient* Client);
    HRESULT GetInputCallbacks(IDebugInputCallbacks* Callbacks);
    HRESULT SetInputCallbacks(IDebugInputCallbacks Callbacks);
    HRESULT GetOutputCallbacks(IDebugOutputCallbacks* Callbacks);
    HRESULT SetOutputCallbacks(IDebugOutputCallbacks Callbacks);
    HRESULT GetOutputMask(uint* Mask);
    HRESULT SetOutputMask(uint Mask);
    HRESULT GetOtherOutputMask(IDebugClient Client, uint* Mask);
    HRESULT SetOtherOutputMask(IDebugClient Client, uint Mask);
    HRESULT GetOutputWidth(uint* Columns);
    HRESULT SetOutputWidth(uint Columns);
    HRESULT GetOutputLinePrefix(PSTR Buffer, uint BufferSize, uint* PrefixSize);
    HRESULT SetOutputLinePrefix(const(PSTR) Prefix);
    HRESULT GetIdentity(PSTR Buffer, uint BufferSize, uint* IdentitySize);
    HRESULT OutputIdentity(uint OutputControl, uint Flags, const(PSTR) Format);
    HRESULT GetEventCallbacks(IDebugEventCallbacks* Callbacks);
    HRESULT SetEventCallbacks(IDebugEventCallbacks Callbacks);
    HRESULT FlushCallbacks();
    HRESULT WriteDumpFile2(const(PSTR) DumpFile, uint Qualifier, uint FormatFlags, const(PSTR) Comment);
    HRESULT AddDumpInformationFile(const(PSTR) InfoFile, uint Type);
    HRESULT EndProcessServer(ulong Server);
    HRESULT WaitForProcessServerEnd(uint Timeout);
    HRESULT IsKernelDebuggerEnabled();
    HRESULT TerminateCurrentProcess();
    HRESULT DetachCurrentProcess();
    HRESULT AbandonCurrentProcess();
    HRESULT GetRunningProcessSystemIdByExecutableNameWide(ulong Server, const(PWSTR) ExeName, uint Flags, uint* Id);
    HRESULT GetRunningProcessDescriptionWide(ulong Server, uint SystemId, uint Flags, PWSTR ExeName, 
                                             uint ExeNameSize, uint* ActualExeNameSize, PWSTR Description, 
                                             uint DescriptionSize, uint* ActualDescriptionSize);
    HRESULT CreateProcessWide(ulong Server, PWSTR CommandLine, uint CreateFlags);
    HRESULT CreateProcessAndAttachWide(ulong Server, PWSTR CommandLine, uint CreateFlags, uint ProcessId, 
                                       uint AttachFlags);
    HRESULT OpenDumpFileWide(const(PWSTR) FileName, ulong FileHandle);
    HRESULT WriteDumpFileWide(const(PWSTR) FileName, ulong FileHandle, uint Qualifier, uint FormatFlags, 
                              const(PWSTR) Comment);
    HRESULT AddDumpInformationFileWide(const(PWSTR) FileName, ulong FileHandle, uint Type);
    HRESULT GetNumberDumpFiles(uint* Number);
    HRESULT GetDumpFile(uint Index, PSTR Buffer, uint BufferSize, uint* NameSize, ulong* Handle, uint* Type);
    HRESULT GetDumpFileWide(uint Index, PWSTR Buffer, uint BufferSize, uint* NameSize, ulong* Handle, uint* Type);
    HRESULT AttachKernelWide(uint Flags, const(PWSTR) ConnectOptions);
    HRESULT GetKernelConnectionOptionsWide(PWSTR Buffer, uint BufferSize, uint* OptionsSize);
    HRESULT SetKernelConnectionOptionsWide(const(PWSTR) Options);
    HRESULT StartProcessServerWide(uint Flags, const(PWSTR) Options, 
                                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved);
    HRESULT ConnectProcessServerWide(const(PWSTR) RemoteOptions, ulong* Server);
    HRESULT StartServerWide(const(PWSTR) Options);
    HRESULT OutputServersWide(uint OutputControl, const(PWSTR) Machine, uint Flags);
    HRESULT GetOutputCallbacksWide(IDebugOutputCallbacksWide* Callbacks);
    HRESULT SetOutputCallbacksWide(IDebugOutputCallbacksWide Callbacks);
    HRESULT GetOutputLinePrefixWide(PWSTR Buffer, uint BufferSize, uint* PrefixSize);
    HRESULT SetOutputLinePrefixWide(const(PWSTR) Prefix);
    HRESULT GetIdentityWide(PWSTR Buffer, uint BufferSize, uint* IdentitySize);
    HRESULT OutputIdentityWide(uint OutputControl, uint Flags, const(PWSTR) Format);
    HRESULT GetEventCallbacksWide(IDebugEventCallbacksWide* Callbacks);
    HRESULT SetEventCallbacksWide(IDebugEventCallbacksWide Callbacks);
    HRESULT CreateProcess2(ulong Server, PSTR CommandLine, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* OptionsBuffer, 
                           uint OptionsBufferSize, const(PSTR) InitialDirectory, const(PSTR) Environment);
    HRESULT CreateProcess2Wide(ulong Server, PWSTR CommandLine, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* OptionsBuffer, 
                               uint OptionsBufferSize, const(PWSTR) InitialDirectory, const(PWSTR) Environment);
    HRESULT CreateProcessAndAttach2(ulong Server, PSTR CommandLine, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* OptionsBuffer, 
                                    uint OptionsBufferSize, const(PSTR) InitialDirectory, const(PSTR) Environment, 
                                    uint ProcessId, uint AttachFlags);
    HRESULT CreateProcessAndAttach2Wide(ulong Server, PWSTR CommandLine, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* OptionsBuffer, 
                                        uint OptionsBufferSize, const(PWSTR) InitialDirectory, 
                                        const(PWSTR) Environment, uint ProcessId, uint AttachFlags);
    HRESULT PushOutputLinePrefix(const(PSTR) NewPrefix, ulong* Handle);
    HRESULT PushOutputLinePrefixWide(const(PWSTR) NewPrefix, ulong* Handle);
    HRESULT PopOutputLinePrefix(ulong Handle);
    HRESULT GetNumberInputCallbacks(uint* Count);
    HRESULT GetNumberOutputCallbacks(uint* Count);
    HRESULT GetNumberEventCallbacks(uint EventFlags, uint* Count);
    HRESULT GetQuitLockString(PSTR Buffer, uint BufferSize, uint* StringSize);
    HRESULT SetQuitLockString(const(PSTR) String);
    HRESULT GetQuitLockStringWide(PWSTR Buffer, uint BufferSize, uint* StringSize);
    HRESULT SetQuitLockStringWide(const(PWSTR) String);
}

@GUID("fd28b4c5-c498-4686-a28e-62cad2154eb3")
interface IDebugClient6 : IUnknown
{
    HRESULT AttachKernel(uint Flags, const(PSTR) ConnectOptions);
    HRESULT GetKernelConnectionOptions(PSTR Buffer, uint BufferSize, uint* OptionsSize);
    HRESULT SetKernelConnectionOptions(const(PSTR) Options);
    HRESULT StartProcessServer(uint Flags, const(PSTR) Options, 
                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved);
    HRESULT ConnectProcessServer(const(PSTR) RemoteOptions, ulong* Server);
    HRESULT DisconnectProcessServer(ulong Server);
    HRESULT GetRunningProcessSystemIds(ulong Server, uint* Ids, uint Count, uint* ActualCount);
    HRESULT GetRunningProcessSystemIdByExecutableName(ulong Server, const(PSTR) ExeName, uint Flags, uint* Id);
    HRESULT GetRunningProcessDescription(ulong Server, uint SystemId, uint Flags, PSTR ExeName, uint ExeNameSize, 
                                         uint* ActualExeNameSize, PSTR Description, uint DescriptionSize, 
                                         uint* ActualDescriptionSize);
    HRESULT AttachProcess(ulong Server, uint ProcessId, uint AttachFlags);
    HRESULT CreateProcessA(ulong Server, PSTR CommandLine, uint CreateFlags);
    HRESULT CreateProcessAndAttach(ulong Server, PSTR CommandLine, uint CreateFlags, uint ProcessId, 
                                   uint AttachFlags);
    HRESULT GetProcessOptions(uint* Options);
    HRESULT AddProcessOptions(uint Options);
    HRESULT RemoveProcessOptions(uint Options);
    HRESULT SetProcessOptions(uint Options);
    HRESULT OpenDumpFile(const(PSTR) DumpFile);
    HRESULT WriteDumpFile(const(PSTR) DumpFile, uint Qualifier);
    HRESULT ConnectSession(uint Flags, uint HistoryLimit);
    HRESULT StartServer(const(PSTR) Options);
    HRESULT OutputServers(uint OutputControl, const(PSTR) Machine, uint Flags);
    HRESULT TerminateProcesses();
    HRESULT DetachProcesses();
    HRESULT EndSession(uint Flags);
    HRESULT GetExitCode(uint* Code);
    HRESULT DispatchCallbacks(uint Timeout);
    HRESULT ExitDispatch(IDebugClient Client);
    HRESULT CreateClient(IDebugClient* Client);
    HRESULT GetInputCallbacks(IDebugInputCallbacks* Callbacks);
    HRESULT SetInputCallbacks(IDebugInputCallbacks Callbacks);
    HRESULT GetOutputCallbacks(IDebugOutputCallbacks* Callbacks);
    HRESULT SetOutputCallbacks(IDebugOutputCallbacks Callbacks);
    HRESULT GetOutputMask(uint* Mask);
    HRESULT SetOutputMask(uint Mask);
    HRESULT GetOtherOutputMask(IDebugClient Client, uint* Mask);
    HRESULT SetOtherOutputMask(IDebugClient Client, uint Mask);
    HRESULT GetOutputWidth(uint* Columns);
    HRESULT SetOutputWidth(uint Columns);
    HRESULT GetOutputLinePrefix(PSTR Buffer, uint BufferSize, uint* PrefixSize);
    HRESULT SetOutputLinePrefix(const(PSTR) Prefix);
    HRESULT GetIdentity(PSTR Buffer, uint BufferSize, uint* IdentitySize);
    HRESULT OutputIdentity(uint OutputControl, uint Flags, const(PSTR) Format);
    HRESULT GetEventCallbacks(IDebugEventCallbacks* Callbacks);
    HRESULT SetEventCallbacks(IDebugEventCallbacks Callbacks);
    HRESULT FlushCallbacks();
    HRESULT WriteDumpFile2(const(PSTR) DumpFile, uint Qualifier, uint FormatFlags, const(PSTR) Comment);
    HRESULT AddDumpInformationFile(const(PSTR) InfoFile, uint Type);
    HRESULT EndProcessServer(ulong Server);
    HRESULT WaitForProcessServerEnd(uint Timeout);
    HRESULT IsKernelDebuggerEnabled();
    HRESULT TerminateCurrentProcess();
    HRESULT DetachCurrentProcess();
    HRESULT AbandonCurrentProcess();
    HRESULT GetRunningProcessSystemIdByExecutableNameWide(ulong Server, const(PWSTR) ExeName, uint Flags, uint* Id);
    HRESULT GetRunningProcessDescriptionWide(ulong Server, uint SystemId, uint Flags, PWSTR ExeName, 
                                             uint ExeNameSize, uint* ActualExeNameSize, PWSTR Description, 
                                             uint DescriptionSize, uint* ActualDescriptionSize);
    HRESULT CreateProcessWide(ulong Server, PWSTR CommandLine, uint CreateFlags);
    HRESULT CreateProcessAndAttachWide(ulong Server, PWSTR CommandLine, uint CreateFlags, uint ProcessId, 
                                       uint AttachFlags);
    HRESULT OpenDumpFileWide(const(PWSTR) FileName, ulong FileHandle);
    HRESULT WriteDumpFileWide(const(PWSTR) FileName, ulong FileHandle, uint Qualifier, uint FormatFlags, 
                              const(PWSTR) Comment);
    HRESULT AddDumpInformationFileWide(const(PWSTR) FileName, ulong FileHandle, uint Type);
    HRESULT GetNumberDumpFiles(uint* Number);
    HRESULT GetDumpFile(uint Index, PSTR Buffer, uint BufferSize, uint* NameSize, ulong* Handle, uint* Type);
    HRESULT GetDumpFileWide(uint Index, PWSTR Buffer, uint BufferSize, uint* NameSize, ulong* Handle, uint* Type);
    HRESULT AttachKernelWide(uint Flags, const(PWSTR) ConnectOptions);
    HRESULT GetKernelConnectionOptionsWide(PWSTR Buffer, uint BufferSize, uint* OptionsSize);
    HRESULT SetKernelConnectionOptionsWide(const(PWSTR) Options);
    HRESULT StartProcessServerWide(uint Flags, const(PWSTR) Options, 
                                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved);
    HRESULT ConnectProcessServerWide(const(PWSTR) RemoteOptions, ulong* Server);
    HRESULT StartServerWide(const(PWSTR) Options);
    HRESULT OutputServersWide(uint OutputControl, const(PWSTR) Machine, uint Flags);
    HRESULT GetOutputCallbacksWide(IDebugOutputCallbacksWide* Callbacks);
    HRESULT SetOutputCallbacksWide(IDebugOutputCallbacksWide Callbacks);
    HRESULT GetOutputLinePrefixWide(PWSTR Buffer, uint BufferSize, uint* PrefixSize);
    HRESULT SetOutputLinePrefixWide(const(PWSTR) Prefix);
    HRESULT GetIdentityWide(PWSTR Buffer, uint BufferSize, uint* IdentitySize);
    HRESULT OutputIdentityWide(uint OutputControl, uint Flags, const(PWSTR) Format);
    HRESULT GetEventCallbacksWide(IDebugEventCallbacksWide* Callbacks);
    HRESULT SetEventCallbacksWide(IDebugEventCallbacksWide Callbacks);
    HRESULT CreateProcess2(ulong Server, PSTR CommandLine, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* OptionsBuffer, 
                           uint OptionsBufferSize, const(PSTR) InitialDirectory, const(PSTR) Environment);
    HRESULT CreateProcess2Wide(ulong Server, PWSTR CommandLine, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* OptionsBuffer, 
                               uint OptionsBufferSize, const(PWSTR) InitialDirectory, const(PWSTR) Environment);
    HRESULT CreateProcessAndAttach2(ulong Server, PSTR CommandLine, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* OptionsBuffer, 
                                    uint OptionsBufferSize, const(PSTR) InitialDirectory, const(PSTR) Environment, 
                                    uint ProcessId, uint AttachFlags);
    HRESULT CreateProcessAndAttach2Wide(ulong Server, PWSTR CommandLine, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* OptionsBuffer, 
                                        uint OptionsBufferSize, const(PWSTR) InitialDirectory, 
                                        const(PWSTR) Environment, uint ProcessId, uint AttachFlags);
    HRESULT PushOutputLinePrefix(const(PSTR) NewPrefix, ulong* Handle);
    HRESULT PushOutputLinePrefixWide(const(PWSTR) NewPrefix, ulong* Handle);
    HRESULT PopOutputLinePrefix(ulong Handle);
    HRESULT GetNumberInputCallbacks(uint* Count);
    HRESULT GetNumberOutputCallbacks(uint* Count);
    HRESULT GetNumberEventCallbacks(uint EventFlags, uint* Count);
    HRESULT GetQuitLockString(PSTR Buffer, uint BufferSize, uint* StringSize);
    HRESULT SetQuitLockString(const(PSTR) String);
    HRESULT GetQuitLockStringWide(PWSTR Buffer, uint BufferSize, uint* StringSize);
    HRESULT SetQuitLockStringWide(const(PWSTR) String);
    HRESULT SetEventContextCallbacks(IDebugEventContextCallbacks Callbacks);
}

@GUID("13586be3-542e-481e-b1f2-8497ba74f9a9")
interface IDebugClient7 : IUnknown
{
    HRESULT AttachKernel(uint Flags, const(PSTR) ConnectOptions);
    HRESULT GetKernelConnectionOptions(PSTR Buffer, uint BufferSize, uint* OptionsSize);
    HRESULT SetKernelConnectionOptions(const(PSTR) Options);
    HRESULT StartProcessServer(uint Flags, const(PSTR) Options, 
                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved);
    HRESULT ConnectProcessServer(const(PSTR) RemoteOptions, ulong* Server);
    HRESULT DisconnectProcessServer(ulong Server);
    HRESULT GetRunningProcessSystemIds(ulong Server, uint* Ids, uint Count, uint* ActualCount);
    HRESULT GetRunningProcessSystemIdByExecutableName(ulong Server, const(PSTR) ExeName, uint Flags, uint* Id);
    HRESULT GetRunningProcessDescription(ulong Server, uint SystemId, uint Flags, PSTR ExeName, uint ExeNameSize, 
                                         uint* ActualExeNameSize, PSTR Description, uint DescriptionSize, 
                                         uint* ActualDescriptionSize);
    HRESULT AttachProcess(ulong Server, uint ProcessId, uint AttachFlags);
    HRESULT CreateProcessA(ulong Server, PSTR CommandLine, uint CreateFlags);
    HRESULT CreateProcessAndAttach(ulong Server, PSTR CommandLine, uint CreateFlags, uint ProcessId, 
                                   uint AttachFlags);
    HRESULT GetProcessOptions(uint* Options);
    HRESULT AddProcessOptions(uint Options);
    HRESULT RemoveProcessOptions(uint Options);
    HRESULT SetProcessOptions(uint Options);
    HRESULT OpenDumpFile(const(PSTR) DumpFile);
    HRESULT WriteDumpFile(const(PSTR) DumpFile, uint Qualifier);
    HRESULT ConnectSession(uint Flags, uint HistoryLimit);
    HRESULT StartServer(const(PSTR) Options);
    HRESULT OutputServers(uint OutputControl, const(PSTR) Machine, uint Flags);
    HRESULT TerminateProcesses();
    HRESULT DetachProcesses();
    HRESULT EndSession(uint Flags);
    HRESULT GetExitCode(uint* Code);
    HRESULT DispatchCallbacks(uint Timeout);
    HRESULT ExitDispatch(IDebugClient Client);
    HRESULT CreateClient(IDebugClient* Client);
    HRESULT GetInputCallbacks(IDebugInputCallbacks* Callbacks);
    HRESULT SetInputCallbacks(IDebugInputCallbacks Callbacks);
    HRESULT GetOutputCallbacks(IDebugOutputCallbacks* Callbacks);
    HRESULT SetOutputCallbacks(IDebugOutputCallbacks Callbacks);
    HRESULT GetOutputMask(uint* Mask);
    HRESULT SetOutputMask(uint Mask);
    HRESULT GetOtherOutputMask(IDebugClient Client, uint* Mask);
    HRESULT SetOtherOutputMask(IDebugClient Client, uint Mask);
    HRESULT GetOutputWidth(uint* Columns);
    HRESULT SetOutputWidth(uint Columns);
    HRESULT GetOutputLinePrefix(PSTR Buffer, uint BufferSize, uint* PrefixSize);
    HRESULT SetOutputLinePrefix(const(PSTR) Prefix);
    HRESULT GetIdentity(PSTR Buffer, uint BufferSize, uint* IdentitySize);
    HRESULT OutputIdentity(uint OutputControl, uint Flags, const(PSTR) Format);
    HRESULT GetEventCallbacks(IDebugEventCallbacks* Callbacks);
    HRESULT SetEventCallbacks(IDebugEventCallbacks Callbacks);
    HRESULT FlushCallbacks();
    HRESULT WriteDumpFile2(const(PSTR) DumpFile, uint Qualifier, uint FormatFlags, const(PSTR) Comment);
    HRESULT AddDumpInformationFile(const(PSTR) InfoFile, uint Type);
    HRESULT EndProcessServer(ulong Server);
    HRESULT WaitForProcessServerEnd(uint Timeout);
    HRESULT IsKernelDebuggerEnabled();
    HRESULT TerminateCurrentProcess();
    HRESULT DetachCurrentProcess();
    HRESULT AbandonCurrentProcess();
    HRESULT GetRunningProcessSystemIdByExecutableNameWide(ulong Server, const(PWSTR) ExeName, uint Flags, uint* Id);
    HRESULT GetRunningProcessDescriptionWide(ulong Server, uint SystemId, uint Flags, PWSTR ExeName, 
                                             uint ExeNameSize, uint* ActualExeNameSize, PWSTR Description, 
                                             uint DescriptionSize, uint* ActualDescriptionSize);
    HRESULT CreateProcessWide(ulong Server, PWSTR CommandLine, uint CreateFlags);
    HRESULT CreateProcessAndAttachWide(ulong Server, PWSTR CommandLine, uint CreateFlags, uint ProcessId, 
                                       uint AttachFlags);
    HRESULT OpenDumpFileWide(const(PWSTR) FileName, ulong FileHandle);
    HRESULT WriteDumpFileWide(const(PWSTR) FileName, ulong FileHandle, uint Qualifier, uint FormatFlags, 
                              const(PWSTR) Comment);
    HRESULT AddDumpInformationFileWide(const(PWSTR) FileName, ulong FileHandle, uint Type);
    HRESULT GetNumberDumpFiles(uint* Number);
    HRESULT GetDumpFile(uint Index, PSTR Buffer, uint BufferSize, uint* NameSize, ulong* Handle, uint* Type);
    HRESULT GetDumpFileWide(uint Index, PWSTR Buffer, uint BufferSize, uint* NameSize, ulong* Handle, uint* Type);
    HRESULT AttachKernelWide(uint Flags, const(PWSTR) ConnectOptions);
    HRESULT GetKernelConnectionOptionsWide(PWSTR Buffer, uint BufferSize, uint* OptionsSize);
    HRESULT SetKernelConnectionOptionsWide(const(PWSTR) Options);
    HRESULT StartProcessServerWide(uint Flags, const(PWSTR) Options, 
                                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved);
    HRESULT ConnectProcessServerWide(const(PWSTR) RemoteOptions, ulong* Server);
    HRESULT StartServerWide(const(PWSTR) Options);
    HRESULT OutputServersWide(uint OutputControl, const(PWSTR) Machine, uint Flags);
    HRESULT GetOutputCallbacksWide(IDebugOutputCallbacksWide* Callbacks);
    HRESULT SetOutputCallbacksWide(IDebugOutputCallbacksWide Callbacks);
    HRESULT GetOutputLinePrefixWide(PWSTR Buffer, uint BufferSize, uint* PrefixSize);
    HRESULT SetOutputLinePrefixWide(const(PWSTR) Prefix);
    HRESULT GetIdentityWide(PWSTR Buffer, uint BufferSize, uint* IdentitySize);
    HRESULT OutputIdentityWide(uint OutputControl, uint Flags, const(PWSTR) Format);
    HRESULT GetEventCallbacksWide(IDebugEventCallbacksWide* Callbacks);
    HRESULT SetEventCallbacksWide(IDebugEventCallbacksWide Callbacks);
    HRESULT CreateProcess2(ulong Server, PSTR CommandLine, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* OptionsBuffer, 
                           uint OptionsBufferSize, const(PSTR) InitialDirectory, const(PSTR) Environment);
    HRESULT CreateProcess2Wide(ulong Server, PWSTR CommandLine, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* OptionsBuffer, 
                               uint OptionsBufferSize, const(PWSTR) InitialDirectory, const(PWSTR) Environment);
    HRESULT CreateProcessAndAttach2(ulong Server, PSTR CommandLine, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* OptionsBuffer, 
                                    uint OptionsBufferSize, const(PSTR) InitialDirectory, const(PSTR) Environment, 
                                    uint ProcessId, uint AttachFlags);
    HRESULT CreateProcessAndAttach2Wide(ulong Server, PWSTR CommandLine, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* OptionsBuffer, 
                                        uint OptionsBufferSize, const(PWSTR) InitialDirectory, 
                                        const(PWSTR) Environment, uint ProcessId, uint AttachFlags);
    HRESULT PushOutputLinePrefix(const(PSTR) NewPrefix, ulong* Handle);
    HRESULT PushOutputLinePrefixWide(const(PWSTR) NewPrefix, ulong* Handle);
    HRESULT PopOutputLinePrefix(ulong Handle);
    HRESULT GetNumberInputCallbacks(uint* Count);
    HRESULT GetNumberOutputCallbacks(uint* Count);
    HRESULT GetNumberEventCallbacks(uint EventFlags, uint* Count);
    HRESULT GetQuitLockString(PSTR Buffer, uint BufferSize, uint* StringSize);
    HRESULT SetQuitLockString(const(PSTR) String);
    HRESULT GetQuitLockStringWide(PWSTR Buffer, uint BufferSize, uint* StringSize);
    HRESULT SetQuitLockStringWide(const(PWSTR) String);
    HRESULT SetEventContextCallbacks(IDebugEventContextCallbacks Callbacks);
    HRESULT SetClientContext(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* Context, 
                             uint ContextSize);
}

@GUID("cec43add-6375-469e-83d5-414e4033c19a")
interface IDebugClient8 : IUnknown
{
    HRESULT AttachKernel(uint Flags, const(PSTR) ConnectOptions);
    HRESULT GetKernelConnectionOptions(PSTR Buffer, uint BufferSize, uint* OptionsSize);
    HRESULT SetKernelConnectionOptions(const(PSTR) Options);
    HRESULT StartProcessServer(uint Flags, const(PSTR) Options, 
                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved);
    HRESULT ConnectProcessServer(const(PSTR) RemoteOptions, ulong* Server);
    HRESULT DisconnectProcessServer(ulong Server);
    HRESULT GetRunningProcessSystemIds(ulong Server, uint* Ids, uint Count, uint* ActualCount);
    HRESULT GetRunningProcessSystemIdByExecutableName(ulong Server, const(PSTR) ExeName, uint Flags, uint* Id);
    HRESULT GetRunningProcessDescription(ulong Server, uint SystemId, uint Flags, PSTR ExeName, uint ExeNameSize, 
                                         uint* ActualExeNameSize, PSTR Description, uint DescriptionSize, 
                                         uint* ActualDescriptionSize);
    HRESULT AttachProcess(ulong Server, uint ProcessId, uint AttachFlags);
    HRESULT CreateProcessA(ulong Server, PSTR CommandLine, uint CreateFlags);
    HRESULT CreateProcessAndAttach(ulong Server, PSTR CommandLine, uint CreateFlags, uint ProcessId, 
                                   uint AttachFlags);
    HRESULT GetProcessOptions(uint* Options);
    HRESULT AddProcessOptions(uint Options);
    HRESULT RemoveProcessOptions(uint Options);
    HRESULT SetProcessOptions(uint Options);
    HRESULT OpenDumpFile(const(PSTR) DumpFile);
    HRESULT WriteDumpFile(const(PSTR) DumpFile, uint Qualifier);
    HRESULT ConnectSession(uint Flags, uint HistoryLimit);
    HRESULT StartServer(const(PSTR) Options);
    HRESULT OutputServers(uint OutputControl, const(PSTR) Machine, uint Flags);
    HRESULT TerminateProcesses();
    HRESULT DetachProcesses();
    HRESULT EndSession(uint Flags);
    HRESULT GetExitCode(uint* Code);
    HRESULT DispatchCallbacks(uint Timeout);
    HRESULT ExitDispatch(IDebugClient Client);
    HRESULT CreateClient(IDebugClient* Client);
    HRESULT GetInputCallbacks(IDebugInputCallbacks* Callbacks);
    HRESULT SetInputCallbacks(IDebugInputCallbacks Callbacks);
    HRESULT GetOutputCallbacks(IDebugOutputCallbacks* Callbacks);
    HRESULT SetOutputCallbacks(IDebugOutputCallbacks Callbacks);
    HRESULT GetOutputMask(uint* Mask);
    HRESULT SetOutputMask(uint Mask);
    HRESULT GetOtherOutputMask(IDebugClient Client, uint* Mask);
    HRESULT SetOtherOutputMask(IDebugClient Client, uint Mask);
    HRESULT GetOutputWidth(uint* Columns);
    HRESULT SetOutputWidth(uint Columns);
    HRESULT GetOutputLinePrefix(PSTR Buffer, uint BufferSize, uint* PrefixSize);
    HRESULT SetOutputLinePrefix(const(PSTR) Prefix);
    HRESULT GetIdentity(PSTR Buffer, uint BufferSize, uint* IdentitySize);
    HRESULT OutputIdentity(uint OutputControl, uint Flags, const(PSTR) Format);
    HRESULT GetEventCallbacks(IDebugEventCallbacks* Callbacks);
    HRESULT SetEventCallbacks(IDebugEventCallbacks Callbacks);
    HRESULT FlushCallbacks();
    HRESULT WriteDumpFile2(const(PSTR) DumpFile, uint Qualifier, uint FormatFlags, const(PSTR) Comment);
    HRESULT AddDumpInformationFile(const(PSTR) InfoFile, uint Type);
    HRESULT EndProcessServer(ulong Server);
    HRESULT WaitForProcessServerEnd(uint Timeout);
    HRESULT IsKernelDebuggerEnabled();
    HRESULT TerminateCurrentProcess();
    HRESULT DetachCurrentProcess();
    HRESULT AbandonCurrentProcess();
    HRESULT GetRunningProcessSystemIdByExecutableNameWide(ulong Server, const(PWSTR) ExeName, uint Flags, uint* Id);
    HRESULT GetRunningProcessDescriptionWide(ulong Server, uint SystemId, uint Flags, PWSTR ExeName, 
                                             uint ExeNameSize, uint* ActualExeNameSize, PWSTR Description, 
                                             uint DescriptionSize, uint* ActualDescriptionSize);
    HRESULT CreateProcessWide(ulong Server, PWSTR CommandLine, uint CreateFlags);
    HRESULT CreateProcessAndAttachWide(ulong Server, PWSTR CommandLine, uint CreateFlags, uint ProcessId, 
                                       uint AttachFlags);
    HRESULT OpenDumpFileWide(const(PWSTR) FileName, ulong FileHandle);
    HRESULT WriteDumpFileWide(const(PWSTR) FileName, ulong FileHandle, uint Qualifier, uint FormatFlags, 
                              const(PWSTR) Comment);
    HRESULT AddDumpInformationFileWide(const(PWSTR) FileName, ulong FileHandle, uint Type);
    HRESULT GetNumberDumpFiles(uint* Number);
    HRESULT GetDumpFile(uint Index, PSTR Buffer, uint BufferSize, uint* NameSize, ulong* Handle, uint* Type);
    HRESULT GetDumpFileWide(uint Index, PWSTR Buffer, uint BufferSize, uint* NameSize, ulong* Handle, uint* Type);
    HRESULT AttachKernelWide(uint Flags, const(PWSTR) ConnectOptions);
    HRESULT GetKernelConnectionOptionsWide(PWSTR Buffer, uint BufferSize, uint* OptionsSize);
    HRESULT SetKernelConnectionOptionsWide(const(PWSTR) Options);
    HRESULT StartProcessServerWide(uint Flags, const(PWSTR) Options, 
                                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved);
    HRESULT ConnectProcessServerWide(const(PWSTR) RemoteOptions, ulong* Server);
    HRESULT StartServerWide(const(PWSTR) Options);
    HRESULT OutputServersWide(uint OutputControl, const(PWSTR) Machine, uint Flags);
    HRESULT GetOutputCallbacksWide(IDebugOutputCallbacksWide* Callbacks);
    HRESULT SetOutputCallbacksWide(IDebugOutputCallbacksWide Callbacks);
    HRESULT GetOutputLinePrefixWide(PWSTR Buffer, uint BufferSize, uint* PrefixSize);
    HRESULT SetOutputLinePrefixWide(const(PWSTR) Prefix);
    HRESULT GetIdentityWide(PWSTR Buffer, uint BufferSize, uint* IdentitySize);
    HRESULT OutputIdentityWide(uint OutputControl, uint Flags, const(PWSTR) Format);
    HRESULT GetEventCallbacksWide(IDebugEventCallbacksWide* Callbacks);
    HRESULT SetEventCallbacksWide(IDebugEventCallbacksWide Callbacks);
    HRESULT CreateProcess2(ulong Server, PSTR CommandLine, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* OptionsBuffer, 
                           uint OptionsBufferSize, const(PSTR) InitialDirectory, const(PSTR) Environment);
    HRESULT CreateProcess2Wide(ulong Server, PWSTR CommandLine, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* OptionsBuffer, 
                               uint OptionsBufferSize, const(PWSTR) InitialDirectory, const(PWSTR) Environment);
    HRESULT CreateProcessAndAttach2(ulong Server, PSTR CommandLine, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* OptionsBuffer, 
                                    uint OptionsBufferSize, const(PSTR) InitialDirectory, const(PSTR) Environment, 
                                    uint ProcessId, uint AttachFlags);
    HRESULT CreateProcessAndAttach2Wide(ulong Server, PWSTR CommandLine, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* OptionsBuffer, 
                                        uint OptionsBufferSize, const(PWSTR) InitialDirectory, 
                                        const(PWSTR) Environment, uint ProcessId, uint AttachFlags);
    HRESULT PushOutputLinePrefix(const(PSTR) NewPrefix, ulong* Handle);
    HRESULT PushOutputLinePrefixWide(const(PWSTR) NewPrefix, ulong* Handle);
    HRESULT PopOutputLinePrefix(ulong Handle);
    HRESULT GetNumberInputCallbacks(uint* Count);
    HRESULT GetNumberOutputCallbacks(uint* Count);
    HRESULT GetNumberEventCallbacks(uint EventFlags, uint* Count);
    HRESULT GetQuitLockString(PSTR Buffer, uint BufferSize, uint* StringSize);
    HRESULT SetQuitLockString(const(PSTR) String);
    HRESULT GetQuitLockStringWide(PWSTR Buffer, uint BufferSize, uint* StringSize);
    HRESULT SetQuitLockStringWide(const(PWSTR) String);
    HRESULT SetEventContextCallbacks(IDebugEventContextCallbacks Callbacks);
    HRESULT SetClientContext(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* Context, 
                             uint ContextSize);
    HRESULT OpenDumpFileWide2(const(PWSTR) FileName, ulong FileHandle, uint AlternateArch);
}

@GUID("2c24cd5b-4d9e-4df4-8a70-3d37440d119f")
interface IDebugClient9 : IUnknown
{
    HRESULT AttachKernel(uint Flags, const(PSTR) ConnectOptions);
    HRESULT GetKernelConnectionOptions(PSTR Buffer, uint BufferSize, uint* OptionsSize);
    HRESULT SetKernelConnectionOptions(const(PSTR) Options);
    HRESULT StartProcessServer(uint Flags, const(PSTR) Options, 
                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved);
    HRESULT ConnectProcessServer(const(PSTR) RemoteOptions, ulong* Server);
    HRESULT DisconnectProcessServer(ulong Server);
    HRESULT GetRunningProcessSystemIds(ulong Server, uint* Ids, uint Count, uint* ActualCount);
    HRESULT GetRunningProcessSystemIdByExecutableName(ulong Server, const(PSTR) ExeName, uint Flags, uint* Id);
    HRESULT GetRunningProcessDescription(ulong Server, uint SystemId, uint Flags, PSTR ExeName, uint ExeNameSize, 
                                         uint* ActualExeNameSize, PSTR Description, uint DescriptionSize, 
                                         uint* ActualDescriptionSize);
    HRESULT AttachProcess(ulong Server, uint ProcessId, uint AttachFlags);
    HRESULT CreateProcessA(ulong Server, PSTR CommandLine, uint CreateFlags);
    HRESULT CreateProcessAndAttach(ulong Server, PSTR CommandLine, uint CreateFlags, uint ProcessId, 
                                   uint AttachFlags);
    HRESULT GetProcessOptions(uint* Options);
    HRESULT AddProcessOptions(uint Options);
    HRESULT RemoveProcessOptions(uint Options);
    HRESULT SetProcessOptions(uint Options);
    HRESULT OpenDumpFile(const(PSTR) DumpFile);
    HRESULT WriteDumpFile(const(PSTR) DumpFile, uint Qualifier);
    HRESULT ConnectSession(uint Flags, uint HistoryLimit);
    HRESULT StartServer(const(PSTR) Options);
    HRESULT OutputServers(uint OutputControl, const(PSTR) Machine, uint Flags);
    HRESULT TerminateProcesses();
    HRESULT DetachProcesses();
    HRESULT EndSession(uint Flags);
    HRESULT GetExitCode(uint* Code);
    HRESULT DispatchCallbacks(uint Timeout);
    HRESULT ExitDispatch(IDebugClient Client);
    HRESULT CreateClient(IDebugClient* Client);
    HRESULT GetInputCallbacks(IDebugInputCallbacks* Callbacks);
    HRESULT SetInputCallbacks(IDebugInputCallbacks Callbacks);
    HRESULT GetOutputCallbacks(IDebugOutputCallbacks* Callbacks);
    HRESULT SetOutputCallbacks(IDebugOutputCallbacks Callbacks);
    HRESULT GetOutputMask(uint* Mask);
    HRESULT SetOutputMask(uint Mask);
    HRESULT GetOtherOutputMask(IDebugClient Client, uint* Mask);
    HRESULT SetOtherOutputMask(IDebugClient Client, uint Mask);
    HRESULT GetOutputWidth(uint* Columns);
    HRESULT SetOutputWidth(uint Columns);
    HRESULT GetOutputLinePrefix(PSTR Buffer, uint BufferSize, uint* PrefixSize);
    HRESULT SetOutputLinePrefix(const(PSTR) Prefix);
    HRESULT GetIdentity(PSTR Buffer, uint BufferSize, uint* IdentitySize);
    HRESULT OutputIdentity(uint OutputControl, uint Flags, const(PSTR) Format);
    HRESULT GetEventCallbacks(IDebugEventCallbacks* Callbacks);
    HRESULT SetEventCallbacks(IDebugEventCallbacks Callbacks);
    HRESULT FlushCallbacks();
    HRESULT WriteDumpFile2(const(PSTR) DumpFile, uint Qualifier, uint FormatFlags, const(PSTR) Comment);
    HRESULT AddDumpInformationFile(const(PSTR) InfoFile, uint Type);
    HRESULT EndProcessServer(ulong Server);
    HRESULT WaitForProcessServerEnd(uint Timeout);
    HRESULT IsKernelDebuggerEnabled();
    HRESULT TerminateCurrentProcess();
    HRESULT DetachCurrentProcess();
    HRESULT AbandonCurrentProcess();
    HRESULT GetRunningProcessSystemIdByExecutableNameWide(ulong Server, const(PWSTR) ExeName, uint Flags, uint* Id);
    HRESULT GetRunningProcessDescriptionWide(ulong Server, uint SystemId, uint Flags, PWSTR ExeName, 
                                             uint ExeNameSize, uint* ActualExeNameSize, PWSTR Description, 
                                             uint DescriptionSize, uint* ActualDescriptionSize);
    HRESULT CreateProcessWide(ulong Server, PWSTR CommandLine, uint CreateFlags);
    HRESULT CreateProcessAndAttachWide(ulong Server, PWSTR CommandLine, uint CreateFlags, uint ProcessId, 
                                       uint AttachFlags);
    HRESULT OpenDumpFileWide(const(PWSTR) FileName, ulong FileHandle);
    HRESULT WriteDumpFileWide(const(PWSTR) FileName, ulong FileHandle, uint Qualifier, uint FormatFlags, 
                              const(PWSTR) Comment);
    HRESULT AddDumpInformationFileWide(const(PWSTR) FileName, ulong FileHandle, uint Type);
    HRESULT GetNumberDumpFiles(uint* Number);
    HRESULT GetDumpFile(uint Index, PSTR Buffer, uint BufferSize, uint* NameSize, ulong* Handle, uint* Type);
    HRESULT GetDumpFileWide(uint Index, PWSTR Buffer, uint BufferSize, uint* NameSize, ulong* Handle, uint* Type);
    HRESULT AttachKernelWide(uint Flags, const(PWSTR) ConnectOptions);
    HRESULT GetKernelConnectionOptionsWide(PWSTR Buffer, uint BufferSize, uint* OptionsSize);
    HRESULT SetKernelConnectionOptionsWide(const(PWSTR) Options);
    HRESULT StartProcessServerWide(uint Flags, const(PWSTR) Options, 
                                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved);
    HRESULT ConnectProcessServerWide(const(PWSTR) RemoteOptions, ulong* Server);
    HRESULT StartServerWide(const(PWSTR) Options);
    HRESULT OutputServersWide(uint OutputControl, const(PWSTR) Machine, uint Flags);
    HRESULT GetOutputCallbacksWide(IDebugOutputCallbacksWide* Callbacks);
    HRESULT SetOutputCallbacksWide(IDebugOutputCallbacksWide Callbacks);
    HRESULT GetOutputLinePrefixWide(PWSTR Buffer, uint BufferSize, uint* PrefixSize);
    HRESULT SetOutputLinePrefixWide(const(PWSTR) Prefix);
    HRESULT GetIdentityWide(PWSTR Buffer, uint BufferSize, uint* IdentitySize);
    HRESULT OutputIdentityWide(uint OutputControl, uint Flags, const(PWSTR) Format);
    HRESULT GetEventCallbacksWide(IDebugEventCallbacksWide* Callbacks);
    HRESULT SetEventCallbacksWide(IDebugEventCallbacksWide Callbacks);
    HRESULT CreateProcess2(ulong Server, PSTR CommandLine, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* OptionsBuffer, 
                           uint OptionsBufferSize, const(PSTR) InitialDirectory, const(PSTR) Environment);
    HRESULT CreateProcess2Wide(ulong Server, PWSTR CommandLine, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* OptionsBuffer, 
                               uint OptionsBufferSize, const(PWSTR) InitialDirectory, const(PWSTR) Environment);
    HRESULT CreateProcessAndAttach2(ulong Server, PSTR CommandLine, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* OptionsBuffer, 
                                    uint OptionsBufferSize, const(PSTR) InitialDirectory, const(PSTR) Environment, 
                                    uint ProcessId, uint AttachFlags);
    HRESULT CreateProcessAndAttach2Wide(ulong Server, PWSTR CommandLine, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* OptionsBuffer, 
                                        uint OptionsBufferSize, const(PWSTR) InitialDirectory, 
                                        const(PWSTR) Environment, uint ProcessId, uint AttachFlags);
    HRESULT PushOutputLinePrefix(const(PSTR) NewPrefix, ulong* Handle);
    HRESULT PushOutputLinePrefixWide(const(PWSTR) NewPrefix, ulong* Handle);
    HRESULT PopOutputLinePrefix(ulong Handle);
    HRESULT GetNumberInputCallbacks(uint* Count);
    HRESULT GetNumberOutputCallbacks(uint* Count);
    HRESULT GetNumberEventCallbacks(uint EventFlags, uint* Count);
    HRESULT GetQuitLockString(PSTR Buffer, uint BufferSize, uint* StringSize);
    HRESULT SetQuitLockString(const(PSTR) String);
    HRESULT GetQuitLockStringWide(PWSTR Buffer, uint BufferSize, uint* StringSize);
    HRESULT SetQuitLockStringWide(const(PWSTR) String);
    HRESULT SetEventContextCallbacks(IDebugEventContextCallbacks Callbacks);
    HRESULT SetClientContext(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* Context, 
                             uint ContextSize);
    HRESULT OpenDumpFileWide2(const(PWSTR) FileName, ulong FileHandle, uint AlternateArch);
    HRESULT OpenDumpDirectoryWide(const(PWSTR) DirName, uint AlternateArch);
    HRESULT OpenDumpDirectory(const(PSTR) DumpDir, uint AlternativeArch);
}

@GUID("a02b66c4-aea3-4234-a9f7-fe4c383d4e29")
interface IDebugPlmClient : IUnknown
{
    HRESULT LaunchPlmPackageForDebugWide(ulong Server, uint Timeout, const(PWSTR) PackageFullName, 
                                         const(PWSTR) AppName, const(PWSTR) Arguments, uint* ProcessId, 
                                         uint* ThreadId);
}

@GUID("597c980d-e7bd-4309-962c-9d9b69a7372c")
interface IDebugPlmClient2 : IUnknown
{
    HRESULT LaunchPlmPackageForDebugWide(ulong Server, uint Timeout, const(PWSTR) PackageFullName, 
                                         const(PWSTR) AppName, const(PWSTR) Arguments, uint* ProcessId, 
                                         uint* ThreadId);
    HRESULT LaunchPlmBgTaskForDebugWide(ulong Server, uint Timeout, const(PWSTR) PackageFullName, 
                                        const(PWSTR) BackgroundTaskId, uint* ProcessId, uint* ThreadId);
}

@GUID("d4a5dbd1-ca02-4d90-856a-2a92bfd0f20f")
interface IDebugPlmClient3 : IUnknown
{
    HRESULT LaunchPlmPackageForDebugWide(ulong Server, uint Timeout, const(PWSTR) PackageFullName, 
                                         const(PWSTR) AppName, const(PWSTR) Arguments, uint* ProcessId, 
                                         uint* ThreadId);
    HRESULT LaunchPlmBgTaskForDebugWide(ulong Server, uint Timeout, const(PWSTR) PackageFullName, 
                                        const(PWSTR) BackgroundTaskId, uint* ProcessId, uint* ThreadId);
    HRESULT QueryPlmPackageWide(ulong Server, const(PWSTR) PackageFullName, IDebugOutputStream Stream);
    HRESULT QueryPlmPackageList(ulong Server, IDebugOutputStream Stream);
    HRESULT EnablePlmPackageDebugWide(ulong Server, const(PWSTR) PackageFullName);
    HRESULT DisablePlmPackageDebugWide(ulong Server, const(PWSTR) PackageFullName);
    HRESULT SuspendPlmPackageWide(ulong Server, const(PWSTR) PackageFullName);
    HRESULT ResumePlmPackageWide(ulong Server, const(PWSTR) PackageFullName);
    HRESULT TerminatePlmPackageWide(ulong Server, const(PWSTR) PackageFullName);
    HRESULT LaunchAndDebugPlmAppWide(ulong Server, const(PWSTR) PackageFullName, const(PWSTR) AppName, 
                                     const(PWSTR) Arguments);
    HRESULT ActivateAndDebugPlmBgTaskWide(ulong Server, const(PWSTR) PackageFullName, 
                                          const(PWSTR) BackgroundTaskId);
}

@GUID("7782d8f2-2b85-4059-ab88-28ceddca1c80")
interface IDebugOutputStream : IUnknown
{
    HRESULT Write(const(PWSTR) psz);
}

@GUID("5182e668-105e-416e-ad92-24ef800424ba")
interface IDebugControl : IUnknown
{
    HRESULT GetInterrupt();
    HRESULT SetInterrupt(uint Flags);
    HRESULT GetInterruptTimeout(uint* Seconds);
    HRESULT SetInterruptTimeout(uint Seconds);
    HRESULT GetLogFile(PSTR Buffer, uint BufferSize, uint* FileSize, BOOL* Append);
    HRESULT OpenLogFile(const(PSTR) File, BOOL Append);
    HRESULT CloseLogFile();
    HRESULT GetLogMask(uint* Mask);
    HRESULT SetLogMask(uint Mask);
    HRESULT Input(PSTR Buffer, uint BufferSize, uint* InputSize);
    HRESULT ReturnInput(const(PSTR) Buffer);
    HRESULT Output(uint Mask, const(PSTR) Format);
    HRESULT OutputVaList(uint Mask, const(PSTR) Format, byte* Args);
    HRESULT ControlledOutput(uint OutputControl, uint Mask, const(PSTR) Format);
    HRESULT ControlledOutputVaList(uint OutputControl, uint Mask, const(PSTR) Format, byte* Args);
    HRESULT OutputPrompt(uint OutputControl, const(PSTR) Format);
    HRESULT OutputPromptVaList(uint OutputControl, const(PSTR) Format, byte* Args);
    HRESULT GetPromptText(PSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT OutputCurrentState(uint OutputControl, uint Flags);
    HRESULT OutputVersionInformation(uint OutputControl);
    HRESULT GetNotifyEventHandle(ulong* Handle);
    HRESULT SetNotifyEventHandle(ulong Handle);
    HRESULT Assemble(ulong Offset, const(PSTR) Instr, ulong* EndOffset);
    HRESULT Disassemble(ulong Offset, uint Flags, PSTR Buffer, uint BufferSize, uint* DisassemblySize, 
                        ulong* EndOffset);
    HRESULT GetDisassembleEffectiveOffset(ulong* Offset);
    HRESULT OutputDisassembly(uint OutputControl, ulong Offset, uint Flags, ulong* EndOffset);
    HRESULT OutputDisassemblyLines(uint OutputControl, uint PreviousLines, uint TotalLines, ulong Offset, 
                                   uint Flags, uint* OffsetLine, ulong* StartOffset, ulong* EndOffset, 
                                   ulong* LineOffsets);
    HRESULT GetNearInstruction(ulong Offset, int Delta, ulong* NearOffset);
    HRESULT GetStackTrace(ulong FrameOffset, ulong StackOffset, ulong InstructionOffset, DEBUG_STACK_FRAME* Frames, 
                          uint FramesSize, uint* FramesFilled);
    HRESULT GetReturnOffset(ulong* Offset);
    HRESULT OutputStackTrace(uint OutputControl, DEBUG_STACK_FRAME* Frames, uint FramesSize, uint Flags);
    HRESULT GetDebuggeeType(uint* Class, uint* Qualifier);
    HRESULT GetActualProcessorType(uint* Type);
    HRESULT GetExecutingProcessorType(uint* Type);
    HRESULT GetNumberPossibleExecutingProcessorTypes(uint* Number);
    HRESULT GetPossibleExecutingProcessorTypes(uint Start, uint Count, uint* Types);
    HRESULT GetNumberProcessors(uint* Number);
    HRESULT GetSystemVersion(uint* PlatformId, uint* Major, uint* Minor, PSTR ServicePackString, 
                             uint ServicePackStringSize, uint* ServicePackStringUsed, uint* ServicePackNumber, 
                             PSTR BuildString, uint BuildStringSize, uint* BuildStringUsed);
    HRESULT GetPageSize(uint* Size);
    HRESULT IsPointer64Bit();
    HRESULT ReadBugCheckData(uint* Code, ulong* Arg1, ulong* Arg2, ulong* Arg3, ulong* Arg4);
    HRESULT GetNumberSupportedProcessorTypes(uint* Number);
    HRESULT GetSupportedProcessorTypes(uint Start, uint Count, uint* Types);
    HRESULT GetProcessorTypeNames(uint Type, PSTR FullNameBuffer, uint FullNameBufferSize, uint* FullNameSize, 
                                  PSTR AbbrevNameBuffer, uint AbbrevNameBufferSize, uint* AbbrevNameSize);
    HRESULT GetEffectiveProcessorType(uint* Type);
    HRESULT SetEffectiveProcessorType(uint Type);
    HRESULT GetExecutionStatus(uint* Status);
    HRESULT SetExecutionStatus(uint Status);
    HRESULT GetCodeLevel(uint* Level);
    HRESULT SetCodeLevel(uint Level);
    HRESULT GetEngineOptions(uint* Options);
    HRESULT AddEngineOptions(uint Options);
    HRESULT RemoveEngineOptions(uint Options);
    HRESULT SetEngineOptions(uint Options);
    HRESULT GetSystemErrorControl(uint* OutputLevel, uint* BreakLevel);
    HRESULT SetSystemErrorControl(uint OutputLevel, uint BreakLevel);
    HRESULT GetTextMacro(uint Slot, PSTR Buffer, uint BufferSize, uint* MacroSize);
    HRESULT SetTextMacro(uint Slot, const(PSTR) Macro);
    HRESULT GetRadix(uint* Radix);
    HRESULT SetRadix(uint Radix);
    HRESULT Evaluate(const(PSTR) Expression, uint DesiredType, DEBUG_VALUE* Value, uint* RemainderIndex);
    HRESULT CoerceValue(DEBUG_VALUE* In, uint OutType, DEBUG_VALUE* Out);
    HRESULT CoerceValues(uint Count, DEBUG_VALUE* In, uint* OutTypes, DEBUG_VALUE* Out);
    HRESULT Execute(uint OutputControl, const(PSTR) Command, uint Flags);
    HRESULT ExecuteCommandFile(uint OutputControl, const(PSTR) CommandFile, uint Flags);
    HRESULT GetNumberBreakpoints(uint* Number);
    HRESULT GetBreakpointByIndex(uint Index, IDebugBreakpoint* Bp);
    HRESULT GetBreakpointById(uint Id, IDebugBreakpoint* Bp);
    HRESULT GetBreakpointParameters(uint Count, uint* Ids, uint Start, DEBUG_BREAKPOINT_PARAMETERS* Params);
    HRESULT AddBreakpoint(uint Type, uint DesiredId, IDebugBreakpoint* Bp);
    HRESULT RemoveBreakpoint(IDebugBreakpoint Bp);
    HRESULT AddExtension(const(PSTR) Path, uint Flags, ulong* Handle);
    HRESULT RemoveExtension(ulong Handle);
    HRESULT GetExtensionByPath(const(PSTR) Path, ulong* Handle);
    HRESULT CallExtension(ulong Handle, const(PSTR) Function, const(PSTR) Arguments);
    HRESULT GetExtensionFunction(ulong Handle, const(PSTR) FuncName, FARPROC* Function);
    HRESULT GetWindbgExtensionApis32(WINDBG_EXTENSION_APIS32* Api);
    HRESULT GetWindbgExtensionApis64(WINDBG_EXTENSION_APIS64* Api);
    HRESULT GetNumberEventFilters(uint* SpecificEvents, uint* SpecificExceptions, uint* ArbitraryExceptions);
    HRESULT GetEventFilterText(uint Index, PSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT GetEventFilterCommand(uint Index, PSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetEventFilterCommand(uint Index, const(PSTR) Command);
    HRESULT GetSpecificFilterParameters(uint Start, uint Count, DEBUG_SPECIFIC_FILTER_PARAMETERS* Params);
    HRESULT SetSpecificFilterParameters(uint Start, uint Count, DEBUG_SPECIFIC_FILTER_PARAMETERS* Params);
    HRESULT GetSpecificFilterArgument(uint Index, PSTR Buffer, uint BufferSize, uint* ArgumentSize);
    HRESULT SetSpecificFilterArgument(uint Index, const(PSTR) Argument);
    HRESULT GetExceptionFilterParameters(uint Count, uint* Codes, uint Start, 
                                         DEBUG_EXCEPTION_FILTER_PARAMETERS* Params);
    HRESULT SetExceptionFilterParameters(uint Count, DEBUG_EXCEPTION_FILTER_PARAMETERS* Params);
    HRESULT GetExceptionFilterSecondCommand(uint Index, PSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetExceptionFilterSecondCommand(uint Index, const(PSTR) Command);
    HRESULT WaitForEvent(uint Flags, uint Timeout);
    HRESULT GetLastEventInformation(uint* Type, uint* ProcessId, uint* ThreadId, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* ExtraInformation, 
                                    uint ExtraInformationSize, uint* ExtraInformationUsed, PSTR Description, 
                                    uint DescriptionSize, uint* DescriptionUsed);
}

@GUID("d4366723-44df-4bed-8c7e-4c05424f4588")
interface IDebugControl2 : IUnknown
{
    HRESULT GetInterrupt();
    HRESULT SetInterrupt(uint Flags);
    HRESULT GetInterruptTimeout(uint* Seconds);
    HRESULT SetInterruptTimeout(uint Seconds);
    HRESULT GetLogFile(PSTR Buffer, uint BufferSize, uint* FileSize, BOOL* Append);
    HRESULT OpenLogFile(const(PSTR) File, BOOL Append);
    HRESULT CloseLogFile();
    HRESULT GetLogMask(uint* Mask);
    HRESULT SetLogMask(uint Mask);
    HRESULT Input(PSTR Buffer, uint BufferSize, uint* InputSize);
    HRESULT ReturnInput(const(PSTR) Buffer);
    HRESULT Output(uint Mask, const(PSTR) Format);
    HRESULT OutputVaList(uint Mask, const(PSTR) Format, byte* Args);
    HRESULT ControlledOutput(uint OutputControl, uint Mask, const(PSTR) Format);
    HRESULT ControlledOutputVaList(uint OutputControl, uint Mask, const(PSTR) Format, byte* Args);
    HRESULT OutputPrompt(uint OutputControl, const(PSTR) Format);
    HRESULT OutputPromptVaList(uint OutputControl, const(PSTR) Format, byte* Args);
    HRESULT GetPromptText(PSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT OutputCurrentState(uint OutputControl, uint Flags);
    HRESULT OutputVersionInformation(uint OutputControl);
    HRESULT GetNotifyEventHandle(ulong* Handle);
    HRESULT SetNotifyEventHandle(ulong Handle);
    HRESULT Assemble(ulong Offset, const(PSTR) Instr, ulong* EndOffset);
    HRESULT Disassemble(ulong Offset, uint Flags, PSTR Buffer, uint BufferSize, uint* DisassemblySize, 
                        ulong* EndOffset);
    HRESULT GetDisassembleEffectiveOffset(ulong* Offset);
    HRESULT OutputDisassembly(uint OutputControl, ulong Offset, uint Flags, ulong* EndOffset);
    HRESULT OutputDisassemblyLines(uint OutputControl, uint PreviousLines, uint TotalLines, ulong Offset, 
                                   uint Flags, uint* OffsetLine, ulong* StartOffset, ulong* EndOffset, 
                                   ulong* LineOffsets);
    HRESULT GetNearInstruction(ulong Offset, int Delta, ulong* NearOffset);
    HRESULT GetStackTrace(ulong FrameOffset, ulong StackOffset, ulong InstructionOffset, DEBUG_STACK_FRAME* Frames, 
                          uint FramesSize, uint* FramesFilled);
    HRESULT GetReturnOffset(ulong* Offset);
    HRESULT OutputStackTrace(uint OutputControl, DEBUG_STACK_FRAME* Frames, uint FramesSize, uint Flags);
    HRESULT GetDebuggeeType(uint* Class, uint* Qualifier);
    HRESULT GetActualProcessorType(uint* Type);
    HRESULT GetExecutingProcessorType(uint* Type);
    HRESULT GetNumberPossibleExecutingProcessorTypes(uint* Number);
    HRESULT GetPossibleExecutingProcessorTypes(uint Start, uint Count, uint* Types);
    HRESULT GetNumberProcessors(uint* Number);
    HRESULT GetSystemVersion(uint* PlatformId, uint* Major, uint* Minor, PSTR ServicePackString, 
                             uint ServicePackStringSize, uint* ServicePackStringUsed, uint* ServicePackNumber, 
                             PSTR BuildString, uint BuildStringSize, uint* BuildStringUsed);
    HRESULT GetPageSize(uint* Size);
    HRESULT IsPointer64Bit();
    HRESULT ReadBugCheckData(uint* Code, ulong* Arg1, ulong* Arg2, ulong* Arg3, ulong* Arg4);
    HRESULT GetNumberSupportedProcessorTypes(uint* Number);
    HRESULT GetSupportedProcessorTypes(uint Start, uint Count, uint* Types);
    HRESULT GetProcessorTypeNames(uint Type, PSTR FullNameBuffer, uint FullNameBufferSize, uint* FullNameSize, 
                                  PSTR AbbrevNameBuffer, uint AbbrevNameBufferSize, uint* AbbrevNameSize);
    HRESULT GetEffectiveProcessorType(uint* Type);
    HRESULT SetEffectiveProcessorType(uint Type);
    HRESULT GetExecutionStatus(uint* Status);
    HRESULT SetExecutionStatus(uint Status);
    HRESULT GetCodeLevel(uint* Level);
    HRESULT SetCodeLevel(uint Level);
    HRESULT GetEngineOptions(uint* Options);
    HRESULT AddEngineOptions(uint Options);
    HRESULT RemoveEngineOptions(uint Options);
    HRESULT SetEngineOptions(uint Options);
    HRESULT GetSystemErrorControl(uint* OutputLevel, uint* BreakLevel);
    HRESULT SetSystemErrorControl(uint OutputLevel, uint BreakLevel);
    HRESULT GetTextMacro(uint Slot, PSTR Buffer, uint BufferSize, uint* MacroSize);
    HRESULT SetTextMacro(uint Slot, const(PSTR) Macro);
    HRESULT GetRadix(uint* Radix);
    HRESULT SetRadix(uint Radix);
    HRESULT Evaluate(const(PSTR) Expression, uint DesiredType, DEBUG_VALUE* Value, uint* RemainderIndex);
    HRESULT CoerceValue(DEBUG_VALUE* In, uint OutType, DEBUG_VALUE* Out);
    HRESULT CoerceValues(uint Count, DEBUG_VALUE* In, uint* OutTypes, DEBUG_VALUE* Out);
    HRESULT Execute(uint OutputControl, const(PSTR) Command, uint Flags);
    HRESULT ExecuteCommandFile(uint OutputControl, const(PSTR) CommandFile, uint Flags);
    HRESULT GetNumberBreakpoints(uint* Number);
    HRESULT GetBreakpointByIndex(uint Index, IDebugBreakpoint* Bp);
    HRESULT GetBreakpointById(uint Id, IDebugBreakpoint* Bp);
    HRESULT GetBreakpointParameters(uint Count, uint* Ids, uint Start, DEBUG_BREAKPOINT_PARAMETERS* Params);
    HRESULT AddBreakpoint(uint Type, uint DesiredId, IDebugBreakpoint* Bp);
    HRESULT RemoveBreakpoint(IDebugBreakpoint Bp);
    HRESULT AddExtension(const(PSTR) Path, uint Flags, ulong* Handle);
    HRESULT RemoveExtension(ulong Handle);
    HRESULT GetExtensionByPath(const(PSTR) Path, ulong* Handle);
    HRESULT CallExtension(ulong Handle, const(PSTR) Function, const(PSTR) Arguments);
    HRESULT GetExtensionFunction(ulong Handle, const(PSTR) FuncName, FARPROC* Function);
    HRESULT GetWindbgExtensionApis32(WINDBG_EXTENSION_APIS32* Api);
    HRESULT GetWindbgExtensionApis64(WINDBG_EXTENSION_APIS64* Api);
    HRESULT GetNumberEventFilters(uint* SpecificEvents, uint* SpecificExceptions, uint* ArbitraryExceptions);
    HRESULT GetEventFilterText(uint Index, PSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT GetEventFilterCommand(uint Index, PSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetEventFilterCommand(uint Index, const(PSTR) Command);
    HRESULT GetSpecificFilterParameters(uint Start, uint Count, DEBUG_SPECIFIC_FILTER_PARAMETERS* Params);
    HRESULT SetSpecificFilterParameters(uint Start, uint Count, DEBUG_SPECIFIC_FILTER_PARAMETERS* Params);
    HRESULT GetSpecificFilterArgument(uint Index, PSTR Buffer, uint BufferSize, uint* ArgumentSize);
    HRESULT SetSpecificFilterArgument(uint Index, const(PSTR) Argument);
    HRESULT GetExceptionFilterParameters(uint Count, uint* Codes, uint Start, 
                                         DEBUG_EXCEPTION_FILTER_PARAMETERS* Params);
    HRESULT SetExceptionFilterParameters(uint Count, DEBUG_EXCEPTION_FILTER_PARAMETERS* Params);
    HRESULT GetExceptionFilterSecondCommand(uint Index, PSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetExceptionFilterSecondCommand(uint Index, const(PSTR) Command);
    HRESULT WaitForEvent(uint Flags, uint Timeout);
    HRESULT GetLastEventInformation(uint* Type, uint* ProcessId, uint* ThreadId, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* ExtraInformation, 
                                    uint ExtraInformationSize, uint* ExtraInformationUsed, PSTR Description, 
                                    uint DescriptionSize, uint* DescriptionUsed);
    HRESULT GetCurrentTimeDate(uint* TimeDate);
    HRESULT GetCurrentSystemUpTime(uint* UpTime);
    HRESULT GetDumpFormatFlags(uint* FormatFlags);
    HRESULT GetNumberTextReplacements(uint* NumRepl);
    HRESULT GetTextReplacement(const(PSTR) SrcText, uint Index, PSTR SrcBuffer, uint SrcBufferSize, uint* SrcSize, 
                               PSTR DstBuffer, uint DstBufferSize, uint* DstSize);
    HRESULT SetTextReplacement(const(PSTR) SrcText, const(PSTR) DstText);
    HRESULT RemoveTextReplacements();
    HRESULT OutputTextReplacements(uint OutputControl, uint Flags);
}

@GUID("7df74a86-b03f-407f-90ab-a20dadcead08")
interface IDebugControl3 : IUnknown
{
    HRESULT GetInterrupt();
    HRESULT SetInterrupt(uint Flags);
    HRESULT GetInterruptTimeout(uint* Seconds);
    HRESULT SetInterruptTimeout(uint Seconds);
    HRESULT GetLogFile(PSTR Buffer, uint BufferSize, uint* FileSize, BOOL* Append);
    HRESULT OpenLogFile(const(PSTR) File, BOOL Append);
    HRESULT CloseLogFile();
    HRESULT GetLogMask(uint* Mask);
    HRESULT SetLogMask(uint Mask);
    HRESULT Input(PSTR Buffer, uint BufferSize, uint* InputSize);
    HRESULT ReturnInput(const(PSTR) Buffer);
    HRESULT Output(uint Mask, const(PSTR) Format);
    HRESULT OutputVaList(uint Mask, const(PSTR) Format, byte* Args);
    HRESULT ControlledOutput(uint OutputControl, uint Mask, const(PSTR) Format);
    HRESULT ControlledOutputVaList(uint OutputControl, uint Mask, const(PSTR) Format, byte* Args);
    HRESULT OutputPrompt(uint OutputControl, const(PSTR) Format);
    HRESULT OutputPromptVaList(uint OutputControl, const(PSTR) Format, byte* Args);
    HRESULT GetPromptText(PSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT OutputCurrentState(uint OutputControl, uint Flags);
    HRESULT OutputVersionInformation(uint OutputControl);
    HRESULT GetNotifyEventHandle(ulong* Handle);
    HRESULT SetNotifyEventHandle(ulong Handle);
    HRESULT Assemble(ulong Offset, const(PSTR) Instr, ulong* EndOffset);
    HRESULT Disassemble(ulong Offset, uint Flags, PSTR Buffer, uint BufferSize, uint* DisassemblySize, 
                        ulong* EndOffset);
    HRESULT GetDisassembleEffectiveOffset(ulong* Offset);
    HRESULT OutputDisassembly(uint OutputControl, ulong Offset, uint Flags, ulong* EndOffset);
    HRESULT OutputDisassemblyLines(uint OutputControl, uint PreviousLines, uint TotalLines, ulong Offset, 
                                   uint Flags, uint* OffsetLine, ulong* StartOffset, ulong* EndOffset, 
                                   ulong* LineOffsets);
    HRESULT GetNearInstruction(ulong Offset, int Delta, ulong* NearOffset);
    HRESULT GetStackTrace(ulong FrameOffset, ulong StackOffset, ulong InstructionOffset, DEBUG_STACK_FRAME* Frames, 
                          uint FramesSize, uint* FramesFilled);
    HRESULT GetReturnOffset(ulong* Offset);
    HRESULT OutputStackTrace(uint OutputControl, DEBUG_STACK_FRAME* Frames, uint FramesSize, uint Flags);
    HRESULT GetDebuggeeType(uint* Class, uint* Qualifier);
    HRESULT GetActualProcessorType(uint* Type);
    HRESULT GetExecutingProcessorType(uint* Type);
    HRESULT GetNumberPossibleExecutingProcessorTypes(uint* Number);
    HRESULT GetPossibleExecutingProcessorTypes(uint Start, uint Count, uint* Types);
    HRESULT GetNumberProcessors(uint* Number);
    HRESULT GetSystemVersion(uint* PlatformId, uint* Major, uint* Minor, PSTR ServicePackString, 
                             uint ServicePackStringSize, uint* ServicePackStringUsed, uint* ServicePackNumber, 
                             PSTR BuildString, uint BuildStringSize, uint* BuildStringUsed);
    HRESULT GetPageSize(uint* Size);
    HRESULT IsPointer64Bit();
    HRESULT ReadBugCheckData(uint* Code, ulong* Arg1, ulong* Arg2, ulong* Arg3, ulong* Arg4);
    HRESULT GetNumberSupportedProcessorTypes(uint* Number);
    HRESULT GetSupportedProcessorTypes(uint Start, uint Count, uint* Types);
    HRESULT GetProcessorTypeNames(uint Type, PSTR FullNameBuffer, uint FullNameBufferSize, uint* FullNameSize, 
                                  PSTR AbbrevNameBuffer, uint AbbrevNameBufferSize, uint* AbbrevNameSize);
    HRESULT GetEffectiveProcessorType(uint* Type);
    HRESULT SetEffectiveProcessorType(uint Type);
    HRESULT GetExecutionStatus(uint* Status);
    HRESULT SetExecutionStatus(uint Status);
    HRESULT GetCodeLevel(uint* Level);
    HRESULT SetCodeLevel(uint Level);
    HRESULT GetEngineOptions(uint* Options);
    HRESULT AddEngineOptions(uint Options);
    HRESULT RemoveEngineOptions(uint Options);
    HRESULT SetEngineOptions(uint Options);
    HRESULT GetSystemErrorControl(uint* OutputLevel, uint* BreakLevel);
    HRESULT SetSystemErrorControl(uint OutputLevel, uint BreakLevel);
    HRESULT GetTextMacro(uint Slot, PSTR Buffer, uint BufferSize, uint* MacroSize);
    HRESULT SetTextMacro(uint Slot, const(PSTR) Macro);
    HRESULT GetRadix(uint* Radix);
    HRESULT SetRadix(uint Radix);
    HRESULT Evaluate(const(PSTR) Expression, uint DesiredType, DEBUG_VALUE* Value, uint* RemainderIndex);
    HRESULT CoerceValue(DEBUG_VALUE* In, uint OutType, DEBUG_VALUE* Out);
    HRESULT CoerceValues(uint Count, DEBUG_VALUE* In, uint* OutTypes, DEBUG_VALUE* Out);
    HRESULT Execute(uint OutputControl, const(PSTR) Command, uint Flags);
    HRESULT ExecuteCommandFile(uint OutputControl, const(PSTR) CommandFile, uint Flags);
    HRESULT GetNumberBreakpoints(uint* Number);
    HRESULT GetBreakpointByIndex(uint Index, IDebugBreakpoint* Bp);
    HRESULT GetBreakpointById(uint Id, IDebugBreakpoint* Bp);
    HRESULT GetBreakpointParameters(uint Count, uint* Ids, uint Start, DEBUG_BREAKPOINT_PARAMETERS* Params);
    HRESULT AddBreakpoint(uint Type, uint DesiredId, IDebugBreakpoint* Bp);
    HRESULT RemoveBreakpoint(IDebugBreakpoint Bp);
    HRESULT AddExtension(const(PSTR) Path, uint Flags, ulong* Handle);
    HRESULT RemoveExtension(ulong Handle);
    HRESULT GetExtensionByPath(const(PSTR) Path, ulong* Handle);
    HRESULT CallExtension(ulong Handle, const(PSTR) Function, const(PSTR) Arguments);
    HRESULT GetExtensionFunction(ulong Handle, const(PSTR) FuncName, FARPROC* Function);
    HRESULT GetWindbgExtensionApis32(WINDBG_EXTENSION_APIS32* Api);
    HRESULT GetWindbgExtensionApis64(WINDBG_EXTENSION_APIS64* Api);
    HRESULT GetNumberEventFilters(uint* SpecificEvents, uint* SpecificExceptions, uint* ArbitraryExceptions);
    HRESULT GetEventFilterText(uint Index, PSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT GetEventFilterCommand(uint Index, PSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetEventFilterCommand(uint Index, const(PSTR) Command);
    HRESULT GetSpecificFilterParameters(uint Start, uint Count, DEBUG_SPECIFIC_FILTER_PARAMETERS* Params);
    HRESULT SetSpecificFilterParameters(uint Start, uint Count, DEBUG_SPECIFIC_FILTER_PARAMETERS* Params);
    HRESULT GetSpecificFilterArgument(uint Index, PSTR Buffer, uint BufferSize, uint* ArgumentSize);
    HRESULT SetSpecificFilterArgument(uint Index, const(PSTR) Argument);
    HRESULT GetExceptionFilterParameters(uint Count, uint* Codes, uint Start, 
                                         DEBUG_EXCEPTION_FILTER_PARAMETERS* Params);
    HRESULT SetExceptionFilterParameters(uint Count, DEBUG_EXCEPTION_FILTER_PARAMETERS* Params);
    HRESULT GetExceptionFilterSecondCommand(uint Index, PSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetExceptionFilterSecondCommand(uint Index, const(PSTR) Command);
    HRESULT WaitForEvent(uint Flags, uint Timeout);
    HRESULT GetLastEventInformation(uint* Type, uint* ProcessId, uint* ThreadId, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* ExtraInformation, 
                                    uint ExtraInformationSize, uint* ExtraInformationUsed, PSTR Description, 
                                    uint DescriptionSize, uint* DescriptionUsed);
    HRESULT GetCurrentTimeDate(uint* TimeDate);
    HRESULT GetCurrentSystemUpTime(uint* UpTime);
    HRESULT GetDumpFormatFlags(uint* FormatFlags);
    HRESULT GetNumberTextReplacements(uint* NumRepl);
    HRESULT GetTextReplacement(const(PSTR) SrcText, uint Index, PSTR SrcBuffer, uint SrcBufferSize, uint* SrcSize, 
                               PSTR DstBuffer, uint DstBufferSize, uint* DstSize);
    HRESULT SetTextReplacement(const(PSTR) SrcText, const(PSTR) DstText);
    HRESULT RemoveTextReplacements();
    HRESULT OutputTextReplacements(uint OutputControl, uint Flags);
    HRESULT GetAssemblyOptions(uint* Options);
    HRESULT AddAssemblyOptions(uint Options);
    HRESULT RemoveAssemblyOptions(uint Options);
    HRESULT SetAssemblyOptions(uint Options);
    HRESULT GetExpressionSyntax(uint* Flags);
    HRESULT SetExpressionSyntax(uint Flags);
    HRESULT SetExpressionSyntaxByName(const(PSTR) AbbrevName);
    HRESULT GetNumberExpressionSyntaxes(uint* Number);
    HRESULT GetExpressionSyntaxNames(uint Index, PSTR FullNameBuffer, uint FullNameBufferSize, uint* FullNameSize, 
                                     PSTR AbbrevNameBuffer, uint AbbrevNameBufferSize, uint* AbbrevNameSize);
    HRESULT GetNumberEvents(uint* Events);
    HRESULT GetEventIndexDescription(uint Index, uint Which, PSTR Buffer, uint BufferSize, uint* DescSize);
    HRESULT GetCurrentEventIndex(uint* Index);
    HRESULT SetNextEventIndex(uint Relation, uint Value, uint* NextIndex);
}

@GUID("94e60ce9-9b41-4b19-9fc0-6d9eb35272b3")
interface IDebugControl4 : IUnknown
{
    HRESULT GetInterrupt();
    HRESULT SetInterrupt(uint Flags);
    HRESULT GetInterruptTimeout(uint* Seconds);
    HRESULT SetInterruptTimeout(uint Seconds);
    HRESULT GetLogFile(PSTR Buffer, uint BufferSize, uint* FileSize, BOOL* Append);
    HRESULT OpenLogFile(const(PSTR) File, BOOL Append);
    HRESULT CloseLogFile();
    HRESULT GetLogMask(uint* Mask);
    HRESULT SetLogMask(uint Mask);
    HRESULT Input(PSTR Buffer, uint BufferSize, uint* InputSize);
    HRESULT ReturnInput(const(PSTR) Buffer);
    HRESULT Output(uint Mask, const(PSTR) Format);
    HRESULT OutputVaList(uint Mask, const(PSTR) Format, byte* Args);
    HRESULT ControlledOutput(uint OutputControl, uint Mask, const(PSTR) Format);
    HRESULT ControlledOutputVaList(uint OutputControl, uint Mask, const(PSTR) Format, byte* Args);
    HRESULT OutputPrompt(uint OutputControl, const(PSTR) Format);
    HRESULT OutputPromptVaList(uint OutputControl, const(PSTR) Format, byte* Args);
    HRESULT GetPromptText(PSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT OutputCurrentState(uint OutputControl, uint Flags);
    HRESULT OutputVersionInformation(uint OutputControl);
    HRESULT GetNotifyEventHandle(ulong* Handle);
    HRESULT SetNotifyEventHandle(ulong Handle);
    HRESULT Assemble(ulong Offset, const(PSTR) Instr, ulong* EndOffset);
    HRESULT Disassemble(ulong Offset, uint Flags, PSTR Buffer, uint BufferSize, uint* DisassemblySize, 
                        ulong* EndOffset);
    HRESULT GetDisassembleEffectiveOffset(ulong* Offset);
    HRESULT OutputDisassembly(uint OutputControl, ulong Offset, uint Flags, ulong* EndOffset);
    HRESULT OutputDisassemblyLines(uint OutputControl, uint PreviousLines, uint TotalLines, ulong Offset, 
                                   uint Flags, uint* OffsetLine, ulong* StartOffset, ulong* EndOffset, 
                                   ulong* LineOffsets);
    HRESULT GetNearInstruction(ulong Offset, int Delta, ulong* NearOffset);
    HRESULT GetStackTrace(ulong FrameOffset, ulong StackOffset, ulong InstructionOffset, DEBUG_STACK_FRAME* Frames, 
                          uint FramesSize, uint* FramesFilled);
    HRESULT GetReturnOffset(ulong* Offset);
    HRESULT OutputStackTrace(uint OutputControl, DEBUG_STACK_FRAME* Frames, uint FramesSize, uint Flags);
    HRESULT GetDebuggeeType(uint* Class, uint* Qualifier);
    HRESULT GetActualProcessorType(uint* Type);
    HRESULT GetExecutingProcessorType(uint* Type);
    HRESULT GetNumberPossibleExecutingProcessorTypes(uint* Number);
    HRESULT GetPossibleExecutingProcessorTypes(uint Start, uint Count, uint* Types);
    HRESULT GetNumberProcessors(uint* Number);
    HRESULT GetSystemVersion(uint* PlatformId, uint* Major, uint* Minor, PSTR ServicePackString, 
                             uint ServicePackStringSize, uint* ServicePackStringUsed, uint* ServicePackNumber, 
                             PSTR BuildString, uint BuildStringSize, uint* BuildStringUsed);
    HRESULT GetPageSize(uint* Size);
    HRESULT IsPointer64Bit();
    HRESULT ReadBugCheckData(uint* Code, ulong* Arg1, ulong* Arg2, ulong* Arg3, ulong* Arg4);
    HRESULT GetNumberSupportedProcessorTypes(uint* Number);
    HRESULT GetSupportedProcessorTypes(uint Start, uint Count, uint* Types);
    HRESULT GetProcessorTypeNames(uint Type, PSTR FullNameBuffer, uint FullNameBufferSize, uint* FullNameSize, 
                                  PSTR AbbrevNameBuffer, uint AbbrevNameBufferSize, uint* AbbrevNameSize);
    HRESULT GetEffectiveProcessorType(uint* Type);
    HRESULT SetEffectiveProcessorType(uint Type);
    HRESULT GetExecutionStatus(uint* Status);
    HRESULT SetExecutionStatus(uint Status);
    HRESULT GetCodeLevel(uint* Level);
    HRESULT SetCodeLevel(uint Level);
    HRESULT GetEngineOptions(uint* Options);
    HRESULT AddEngineOptions(uint Options);
    HRESULT RemoveEngineOptions(uint Options);
    HRESULT SetEngineOptions(uint Options);
    HRESULT GetSystemErrorControl(uint* OutputLevel, uint* BreakLevel);
    HRESULT SetSystemErrorControl(uint OutputLevel, uint BreakLevel);
    HRESULT GetTextMacro(uint Slot, PSTR Buffer, uint BufferSize, uint* MacroSize);
    HRESULT SetTextMacro(uint Slot, const(PSTR) Macro);
    HRESULT GetRadix(uint* Radix);
    HRESULT SetRadix(uint Radix);
    HRESULT Evaluate(const(PSTR) Expression, uint DesiredType, DEBUG_VALUE* Value, uint* RemainderIndex);
    HRESULT CoerceValue(DEBUG_VALUE* In, uint OutType, DEBUG_VALUE* Out);
    HRESULT CoerceValues(uint Count, DEBUG_VALUE* In, uint* OutTypes, DEBUG_VALUE* Out);
    HRESULT Execute(uint OutputControl, const(PSTR) Command, uint Flags);
    HRESULT ExecuteCommandFile(uint OutputControl, const(PSTR) CommandFile, uint Flags);
    HRESULT GetNumberBreakpoints(uint* Number);
    HRESULT GetBreakpointByIndex(uint Index, IDebugBreakpoint* Bp);
    HRESULT GetBreakpointById(uint Id, IDebugBreakpoint* Bp);
    HRESULT GetBreakpointParameters(uint Count, uint* Ids, uint Start, DEBUG_BREAKPOINT_PARAMETERS* Params);
    HRESULT AddBreakpoint(uint Type, uint DesiredId, IDebugBreakpoint* Bp);
    HRESULT RemoveBreakpoint(IDebugBreakpoint Bp);
    HRESULT AddExtension(const(PSTR) Path, uint Flags, ulong* Handle);
    HRESULT RemoveExtension(ulong Handle);
    HRESULT GetExtensionByPath(const(PSTR) Path, ulong* Handle);
    HRESULT CallExtension(ulong Handle, const(PSTR) Function, const(PSTR) Arguments);
    HRESULT GetExtensionFunction(ulong Handle, const(PSTR) FuncName, FARPROC* Function);
    HRESULT GetWindbgExtensionApis32(WINDBG_EXTENSION_APIS32* Api);
    HRESULT GetWindbgExtensionApis64(WINDBG_EXTENSION_APIS64* Api);
    HRESULT GetNumberEventFilters(uint* SpecificEvents, uint* SpecificExceptions, uint* ArbitraryExceptions);
    HRESULT GetEventFilterText(uint Index, PSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT GetEventFilterCommand(uint Index, PSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetEventFilterCommand(uint Index, const(PSTR) Command);
    HRESULT GetSpecificFilterParameters(uint Start, uint Count, DEBUG_SPECIFIC_FILTER_PARAMETERS* Params);
    HRESULT SetSpecificFilterParameters(uint Start, uint Count, DEBUG_SPECIFIC_FILTER_PARAMETERS* Params);
    HRESULT GetSpecificFilterArgument(uint Index, PSTR Buffer, uint BufferSize, uint* ArgumentSize);
    HRESULT SetSpecificFilterArgument(uint Index, const(PSTR) Argument);
    HRESULT GetExceptionFilterParameters(uint Count, uint* Codes, uint Start, 
                                         DEBUG_EXCEPTION_FILTER_PARAMETERS* Params);
    HRESULT SetExceptionFilterParameters(uint Count, DEBUG_EXCEPTION_FILTER_PARAMETERS* Params);
    HRESULT GetExceptionFilterSecondCommand(uint Index, PSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetExceptionFilterSecondCommand(uint Index, const(PSTR) Command);
    HRESULT WaitForEvent(uint Flags, uint Timeout);
    HRESULT GetLastEventInformation(uint* Type, uint* ProcessId, uint* ThreadId, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* ExtraInformation, 
                                    uint ExtraInformationSize, uint* ExtraInformationUsed, PSTR Description, 
                                    uint DescriptionSize, uint* DescriptionUsed);
    HRESULT GetCurrentTimeDate(uint* TimeDate);
    HRESULT GetCurrentSystemUpTime(uint* UpTime);
    HRESULT GetDumpFormatFlags(uint* FormatFlags);
    HRESULT GetNumberTextReplacements(uint* NumRepl);
    HRESULT GetTextReplacement(const(PSTR) SrcText, uint Index, PSTR SrcBuffer, uint SrcBufferSize, uint* SrcSize, 
                               PSTR DstBuffer, uint DstBufferSize, uint* DstSize);
    HRESULT SetTextReplacement(const(PSTR) SrcText, const(PSTR) DstText);
    HRESULT RemoveTextReplacements();
    HRESULT OutputTextReplacements(uint OutputControl, uint Flags);
    HRESULT GetAssemblyOptions(uint* Options);
    HRESULT AddAssemblyOptions(uint Options);
    HRESULT RemoveAssemblyOptions(uint Options);
    HRESULT SetAssemblyOptions(uint Options);
    HRESULT GetExpressionSyntax(uint* Flags);
    HRESULT SetExpressionSyntax(uint Flags);
    HRESULT SetExpressionSyntaxByName(const(PSTR) AbbrevName);
    HRESULT GetNumberExpressionSyntaxes(uint* Number);
    HRESULT GetExpressionSyntaxNames(uint Index, PSTR FullNameBuffer, uint FullNameBufferSize, uint* FullNameSize, 
                                     PSTR AbbrevNameBuffer, uint AbbrevNameBufferSize, uint* AbbrevNameSize);
    HRESULT GetNumberEvents(uint* Events);
    HRESULT GetEventIndexDescription(uint Index, uint Which, PSTR Buffer, uint BufferSize, uint* DescSize);
    HRESULT GetCurrentEventIndex(uint* Index);
    HRESULT SetNextEventIndex(uint Relation, uint Value, uint* NextIndex);
    HRESULT GetLogFileWide(PWSTR Buffer, uint BufferSize, uint* FileSize, BOOL* Append);
    HRESULT OpenLogFileWide(const(PWSTR) File, BOOL Append);
    HRESULT InputWide(PWSTR Buffer, uint BufferSize, uint* InputSize);
    HRESULT ReturnInputWide(const(PWSTR) Buffer);
    HRESULT OutputWide(uint Mask, const(PWSTR) Format);
    HRESULT OutputVaListWide(uint Mask, const(PWSTR) Format, byte* Args);
    HRESULT ControlledOutputWide(uint OutputControl, uint Mask, const(PWSTR) Format);
    HRESULT ControlledOutputVaListWide(uint OutputControl, uint Mask, const(PWSTR) Format, byte* Args);
    HRESULT OutputPromptWide(uint OutputControl, const(PWSTR) Format);
    HRESULT OutputPromptVaListWide(uint OutputControl, const(PWSTR) Format, byte* Args);
    HRESULT GetPromptTextWide(PWSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT AssembleWide(ulong Offset, const(PWSTR) Instr, ulong* EndOffset);
    HRESULT DisassembleWide(ulong Offset, uint Flags, PWSTR Buffer, uint BufferSize, uint* DisassemblySize, 
                            ulong* EndOffset);
    HRESULT GetProcessorTypeNamesWide(uint Type, PWSTR FullNameBuffer, uint FullNameBufferSize, uint* FullNameSize, 
                                      PWSTR AbbrevNameBuffer, uint AbbrevNameBufferSize, uint* AbbrevNameSize);
    HRESULT GetTextMacroWide(uint Slot, PWSTR Buffer, uint BufferSize, uint* MacroSize);
    HRESULT SetTextMacroWide(uint Slot, const(PWSTR) Macro);
    HRESULT EvaluateWide(const(PWSTR) Expression, uint DesiredType, DEBUG_VALUE* Value, uint* RemainderIndex);
    HRESULT ExecuteWide(uint OutputControl, const(PWSTR) Command, uint Flags);
    HRESULT ExecuteCommandFileWide(uint OutputControl, const(PWSTR) CommandFile, uint Flags);
    HRESULT GetBreakpointByIndex2(uint Index, IDebugBreakpoint2* Bp);
    HRESULT GetBreakpointById2(uint Id, IDebugBreakpoint2* Bp);
    HRESULT AddBreakpoint2(uint Type, uint DesiredId, IDebugBreakpoint2* Bp);
    HRESULT RemoveBreakpoint2(IDebugBreakpoint2 Bp);
    HRESULT AddExtensionWide(const(PWSTR) Path, uint Flags, ulong* Handle);
    HRESULT GetExtensionByPathWide(const(PWSTR) Path, ulong* Handle);
    HRESULT CallExtensionWide(ulong Handle, const(PWSTR) Function, const(PWSTR) Arguments);
    HRESULT GetExtensionFunctionWide(ulong Handle, const(PWSTR) FuncName, FARPROC* Function);
    HRESULT GetEventFilterTextWide(uint Index, PWSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT GetEventFilterCommandWide(uint Index, PWSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetEventFilterCommandWide(uint Index, const(PWSTR) Command);
    HRESULT GetSpecificFilterArgumentWide(uint Index, PWSTR Buffer, uint BufferSize, uint* ArgumentSize);
    HRESULT SetSpecificFilterArgumentWide(uint Index, const(PWSTR) Argument);
    HRESULT GetExceptionFilterSecondCommandWide(uint Index, PWSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetExceptionFilterSecondCommandWide(uint Index, const(PWSTR) Command);
    HRESULT GetLastEventInformationWide(uint* Type, uint* ProcessId, uint* ThreadId, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* ExtraInformation, 
                                        uint ExtraInformationSize, uint* ExtraInformationUsed, PWSTR Description, 
                                        uint DescriptionSize, uint* DescriptionUsed);
    HRESULT GetTextReplacementWide(const(PWSTR) SrcText, uint Index, PWSTR SrcBuffer, uint SrcBufferSize, 
                                   uint* SrcSize, PWSTR DstBuffer, uint DstBufferSize, uint* DstSize);
    HRESULT SetTextReplacementWide(const(PWSTR) SrcText, const(PWSTR) DstText);
    HRESULT SetExpressionSyntaxByNameWide(const(PWSTR) AbbrevName);
    HRESULT GetExpressionSyntaxNamesWide(uint Index, PWSTR FullNameBuffer, uint FullNameBufferSize, 
                                         uint* FullNameSize, PWSTR AbbrevNameBuffer, uint AbbrevNameBufferSize, 
                                         uint* AbbrevNameSize);
    HRESULT GetEventIndexDescriptionWide(uint Index, uint Which, PWSTR Buffer, uint BufferSize, uint* DescSize);
    HRESULT GetLogFile2(PSTR Buffer, uint BufferSize, uint* FileSize, uint* Flags);
    HRESULT OpenLogFile2(const(PSTR) File, uint Flags);
    HRESULT GetLogFile2Wide(PWSTR Buffer, uint BufferSize, uint* FileSize, uint* Flags);
    HRESULT OpenLogFile2Wide(const(PWSTR) File, uint Flags);
    HRESULT GetSystemVersionValues(uint* PlatformId, uint* Win32Major, uint* Win32Minor, uint* KdMajor, 
                                   uint* KdMinor);
    HRESULT GetSystemVersionString(uint Which, PSTR Buffer, uint BufferSize, uint* StringSize);
    HRESULT GetSystemVersionStringWide(uint Which, PWSTR Buffer, uint BufferSize, uint* StringSize);
    HRESULT GetContextStackTrace(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* StartContext, 
                                 uint StartContextSize, DEBUG_STACK_FRAME* Frames, uint FramesSize, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* FrameContexts, 
                                 uint FrameContextsSize, uint FrameContextsEntrySize, uint* FramesFilled);
    HRESULT OutputContextStackTrace(uint OutputControl, DEBUG_STACK_FRAME* Frames, uint FramesSize, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* FrameContexts, 
                                    uint FrameContextsSize, uint FrameContextsEntrySize, uint Flags);
    HRESULT GetStoredEventInformation(uint* Type, uint* ProcessId, uint* ThreadId, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Context, 
                                      uint ContextSize, uint* ContextUsed, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* ExtraInformation, 
                                      uint ExtraInformationSize, uint* ExtraInformationUsed);
    HRESULT GetManagedStatus(uint* Flags, uint WhichString, PSTR String, uint StringSize, uint* StringNeeded);
    HRESULT GetManagedStatusWide(uint* Flags, uint WhichString, PWSTR String, uint StringSize, uint* StringNeeded);
    HRESULT ResetManagedStatus(uint Flags);
}

@GUID("b2ffe162-2412-429f-8d1d-5bf6dd824696")
interface IDebugControl5 : IUnknown
{
    HRESULT GetInterrupt();
    HRESULT SetInterrupt(uint Flags);
    HRESULT GetInterruptTimeout(uint* Seconds);
    HRESULT SetInterruptTimeout(uint Seconds);
    HRESULT GetLogFile(PSTR Buffer, uint BufferSize, uint* FileSize, BOOL* Append);
    HRESULT OpenLogFile(const(PSTR) File, BOOL Append);
    HRESULT CloseLogFile();
    HRESULT GetLogMask(uint* Mask);
    HRESULT SetLogMask(uint Mask);
    HRESULT Input(PSTR Buffer, uint BufferSize, uint* InputSize);
    HRESULT ReturnInput(const(PSTR) Buffer);
    HRESULT Output(uint Mask, const(PSTR) Format);
    HRESULT OutputVaList(uint Mask, const(PSTR) Format, byte* Args);
    HRESULT ControlledOutput(uint OutputControl, uint Mask, const(PSTR) Format);
    HRESULT ControlledOutputVaList(uint OutputControl, uint Mask, const(PSTR) Format, byte* Args);
    HRESULT OutputPrompt(uint OutputControl, const(PSTR) Format);
    HRESULT OutputPromptVaList(uint OutputControl, const(PSTR) Format, byte* Args);
    HRESULT GetPromptText(PSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT OutputCurrentState(uint OutputControl, uint Flags);
    HRESULT OutputVersionInformation(uint OutputControl);
    HRESULT GetNotifyEventHandle(ulong* Handle);
    HRESULT SetNotifyEventHandle(ulong Handle);
    HRESULT Assemble(ulong Offset, const(PSTR) Instr, ulong* EndOffset);
    HRESULT Disassemble(ulong Offset, uint Flags, PSTR Buffer, uint BufferSize, uint* DisassemblySize, 
                        ulong* EndOffset);
    HRESULT GetDisassembleEffectiveOffset(ulong* Offset);
    HRESULT OutputDisassembly(uint OutputControl, ulong Offset, uint Flags, ulong* EndOffset);
    HRESULT OutputDisassemblyLines(uint OutputControl, uint PreviousLines, uint TotalLines, ulong Offset, 
                                   uint Flags, uint* OffsetLine, ulong* StartOffset, ulong* EndOffset, 
                                   ulong* LineOffsets);
    HRESULT GetNearInstruction(ulong Offset, int Delta, ulong* NearOffset);
    HRESULT GetStackTrace(ulong FrameOffset, ulong StackOffset, ulong InstructionOffset, DEBUG_STACK_FRAME* Frames, 
                          uint FramesSize, uint* FramesFilled);
    HRESULT GetReturnOffset(ulong* Offset);
    HRESULT OutputStackTrace(uint OutputControl, DEBUG_STACK_FRAME* Frames, uint FramesSize, uint Flags);
    HRESULT GetDebuggeeType(uint* Class, uint* Qualifier);
    HRESULT GetActualProcessorType(uint* Type);
    HRESULT GetExecutingProcessorType(uint* Type);
    HRESULT GetNumberPossibleExecutingProcessorTypes(uint* Number);
    HRESULT GetPossibleExecutingProcessorTypes(uint Start, uint Count, uint* Types);
    HRESULT GetNumberProcessors(uint* Number);
    HRESULT GetSystemVersion(uint* PlatformId, uint* Major, uint* Minor, PSTR ServicePackString, 
                             uint ServicePackStringSize, uint* ServicePackStringUsed, uint* ServicePackNumber, 
                             PSTR BuildString, uint BuildStringSize, uint* BuildStringUsed);
    HRESULT GetPageSize(uint* Size);
    HRESULT IsPointer64Bit();
    HRESULT ReadBugCheckData(uint* Code, ulong* Arg1, ulong* Arg2, ulong* Arg3, ulong* Arg4);
    HRESULT GetNumberSupportedProcessorTypes(uint* Number);
    HRESULT GetSupportedProcessorTypes(uint Start, uint Count, uint* Types);
    HRESULT GetProcessorTypeNames(uint Type, PSTR FullNameBuffer, uint FullNameBufferSize, uint* FullNameSize, 
                                  PSTR AbbrevNameBuffer, uint AbbrevNameBufferSize, uint* AbbrevNameSize);
    HRESULT GetEffectiveProcessorType(uint* Type);
    HRESULT SetEffectiveProcessorType(uint Type);
    HRESULT GetExecutionStatus(uint* Status);
    HRESULT SetExecutionStatus(uint Status);
    HRESULT GetCodeLevel(uint* Level);
    HRESULT SetCodeLevel(uint Level);
    HRESULT GetEngineOptions(uint* Options);
    HRESULT AddEngineOptions(uint Options);
    HRESULT RemoveEngineOptions(uint Options);
    HRESULT SetEngineOptions(uint Options);
    HRESULT GetSystemErrorControl(uint* OutputLevel, uint* BreakLevel);
    HRESULT SetSystemErrorControl(uint OutputLevel, uint BreakLevel);
    HRESULT GetTextMacro(uint Slot, PSTR Buffer, uint BufferSize, uint* MacroSize);
    HRESULT SetTextMacro(uint Slot, const(PSTR) Macro);
    HRESULT GetRadix(uint* Radix);
    HRESULT SetRadix(uint Radix);
    HRESULT Evaluate(const(PSTR) Expression, uint DesiredType, DEBUG_VALUE* Value, uint* RemainderIndex);
    HRESULT CoerceValue(DEBUG_VALUE* In, uint OutType, DEBUG_VALUE* Out);
    HRESULT CoerceValues(uint Count, DEBUG_VALUE* In, uint* OutTypes, DEBUG_VALUE* Out);
    HRESULT Execute(uint OutputControl, const(PSTR) Command, uint Flags);
    HRESULT ExecuteCommandFile(uint OutputControl, const(PSTR) CommandFile, uint Flags);
    HRESULT GetNumberBreakpoints(uint* Number);
    HRESULT GetBreakpointByIndex(uint Index, IDebugBreakpoint* Bp);
    HRESULT GetBreakpointById(uint Id, IDebugBreakpoint* Bp);
    HRESULT GetBreakpointParameters(uint Count, uint* Ids, uint Start, DEBUG_BREAKPOINT_PARAMETERS* Params);
    HRESULT AddBreakpoint(uint Type, uint DesiredId, IDebugBreakpoint* Bp);
    HRESULT RemoveBreakpoint(IDebugBreakpoint Bp);
    HRESULT AddExtension(const(PSTR) Path, uint Flags, ulong* Handle);
    HRESULT RemoveExtension(ulong Handle);
    HRESULT GetExtensionByPath(const(PSTR) Path, ulong* Handle);
    HRESULT CallExtension(ulong Handle, const(PSTR) Function, const(PSTR) Arguments);
    HRESULT GetExtensionFunction(ulong Handle, const(PSTR) FuncName, FARPROC* Function);
    HRESULT GetWindbgExtensionApis32(WINDBG_EXTENSION_APIS32* Api);
    HRESULT GetWindbgExtensionApis64(WINDBG_EXTENSION_APIS64* Api);
    HRESULT GetNumberEventFilters(uint* SpecificEvents, uint* SpecificExceptions, uint* ArbitraryExceptions);
    HRESULT GetEventFilterText(uint Index, PSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT GetEventFilterCommand(uint Index, PSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetEventFilterCommand(uint Index, const(PSTR) Command);
    HRESULT GetSpecificFilterParameters(uint Start, uint Count, DEBUG_SPECIFIC_FILTER_PARAMETERS* Params);
    HRESULT SetSpecificFilterParameters(uint Start, uint Count, DEBUG_SPECIFIC_FILTER_PARAMETERS* Params);
    HRESULT GetSpecificFilterArgument(uint Index, PSTR Buffer, uint BufferSize, uint* ArgumentSize);
    HRESULT SetSpecificFilterArgument(uint Index, const(PSTR) Argument);
    HRESULT GetExceptionFilterParameters(uint Count, uint* Codes, uint Start, 
                                         DEBUG_EXCEPTION_FILTER_PARAMETERS* Params);
    HRESULT SetExceptionFilterParameters(uint Count, DEBUG_EXCEPTION_FILTER_PARAMETERS* Params);
    HRESULT GetExceptionFilterSecondCommand(uint Index, PSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetExceptionFilterSecondCommand(uint Index, const(PSTR) Command);
    HRESULT WaitForEvent(uint Flags, uint Timeout);
    HRESULT GetLastEventInformation(uint* Type, uint* ProcessId, uint* ThreadId, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* ExtraInformation, 
                                    uint ExtraInformationSize, uint* ExtraInformationUsed, PSTR Description, 
                                    uint DescriptionSize, uint* DescriptionUsed);
    HRESULT GetCurrentTimeDate(uint* TimeDate);
    HRESULT GetCurrentSystemUpTime(uint* UpTime);
    HRESULT GetDumpFormatFlags(uint* FormatFlags);
    HRESULT GetNumberTextReplacements(uint* NumRepl);
    HRESULT GetTextReplacement(const(PSTR) SrcText, uint Index, PSTR SrcBuffer, uint SrcBufferSize, uint* SrcSize, 
                               PSTR DstBuffer, uint DstBufferSize, uint* DstSize);
    HRESULT SetTextReplacement(const(PSTR) SrcText, const(PSTR) DstText);
    HRESULT RemoveTextReplacements();
    HRESULT OutputTextReplacements(uint OutputControl, uint Flags);
    HRESULT GetAssemblyOptions(uint* Options);
    HRESULT AddAssemblyOptions(uint Options);
    HRESULT RemoveAssemblyOptions(uint Options);
    HRESULT SetAssemblyOptions(uint Options);
    HRESULT GetExpressionSyntax(uint* Flags);
    HRESULT SetExpressionSyntax(uint Flags);
    HRESULT SetExpressionSyntaxByName(const(PSTR) AbbrevName);
    HRESULT GetNumberExpressionSyntaxes(uint* Number);
    HRESULT GetExpressionSyntaxNames(uint Index, PSTR FullNameBuffer, uint FullNameBufferSize, uint* FullNameSize, 
                                     PSTR AbbrevNameBuffer, uint AbbrevNameBufferSize, uint* AbbrevNameSize);
    HRESULT GetNumberEvents(uint* Events);
    HRESULT GetEventIndexDescription(uint Index, uint Which, PSTR Buffer, uint BufferSize, uint* DescSize);
    HRESULT GetCurrentEventIndex(uint* Index);
    HRESULT SetNextEventIndex(uint Relation, uint Value, uint* NextIndex);
    HRESULT GetLogFileWide(PWSTR Buffer, uint BufferSize, uint* FileSize, BOOL* Append);
    HRESULT OpenLogFileWide(const(PWSTR) File, BOOL Append);
    HRESULT InputWide(PWSTR Buffer, uint BufferSize, uint* InputSize);
    HRESULT ReturnInputWide(const(PWSTR) Buffer);
    HRESULT OutputWide(uint Mask, const(PWSTR) Format);
    HRESULT OutputVaListWide(uint Mask, const(PWSTR) Format, byte* Args);
    HRESULT ControlledOutputWide(uint OutputControl, uint Mask, const(PWSTR) Format);
    HRESULT ControlledOutputVaListWide(uint OutputControl, uint Mask, const(PWSTR) Format, byte* Args);
    HRESULT OutputPromptWide(uint OutputControl, const(PWSTR) Format);
    HRESULT OutputPromptVaListWide(uint OutputControl, const(PWSTR) Format, byte* Args);
    HRESULT GetPromptTextWide(PWSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT AssembleWide(ulong Offset, const(PWSTR) Instr, ulong* EndOffset);
    HRESULT DisassembleWide(ulong Offset, uint Flags, PWSTR Buffer, uint BufferSize, uint* DisassemblySize, 
                            ulong* EndOffset);
    HRESULT GetProcessorTypeNamesWide(uint Type, PWSTR FullNameBuffer, uint FullNameBufferSize, uint* FullNameSize, 
                                      PWSTR AbbrevNameBuffer, uint AbbrevNameBufferSize, uint* AbbrevNameSize);
    HRESULT GetTextMacroWide(uint Slot, PWSTR Buffer, uint BufferSize, uint* MacroSize);
    HRESULT SetTextMacroWide(uint Slot, const(PWSTR) Macro);
    HRESULT EvaluateWide(const(PWSTR) Expression, uint DesiredType, DEBUG_VALUE* Value, uint* RemainderIndex);
    HRESULT ExecuteWide(uint OutputControl, const(PWSTR) Command, uint Flags);
    HRESULT ExecuteCommandFileWide(uint OutputControl, const(PWSTR) CommandFile, uint Flags);
    HRESULT GetBreakpointByIndex2(uint Index, IDebugBreakpoint2* Bp);
    HRESULT GetBreakpointById2(uint Id, IDebugBreakpoint2* Bp);
    HRESULT AddBreakpoint2(uint Type, uint DesiredId, IDebugBreakpoint2* Bp);
    HRESULT RemoveBreakpoint2(IDebugBreakpoint2 Bp);
    HRESULT AddExtensionWide(const(PWSTR) Path, uint Flags, ulong* Handle);
    HRESULT GetExtensionByPathWide(const(PWSTR) Path, ulong* Handle);
    HRESULT CallExtensionWide(ulong Handle, const(PWSTR) Function, const(PWSTR) Arguments);
    HRESULT GetExtensionFunctionWide(ulong Handle, const(PWSTR) FuncName, FARPROC* Function);
    HRESULT GetEventFilterTextWide(uint Index, PWSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT GetEventFilterCommandWide(uint Index, PWSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetEventFilterCommandWide(uint Index, const(PWSTR) Command);
    HRESULT GetSpecificFilterArgumentWide(uint Index, PWSTR Buffer, uint BufferSize, uint* ArgumentSize);
    HRESULT SetSpecificFilterArgumentWide(uint Index, const(PWSTR) Argument);
    HRESULT GetExceptionFilterSecondCommandWide(uint Index, PWSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetExceptionFilterSecondCommandWide(uint Index, const(PWSTR) Command);
    HRESULT GetLastEventInformationWide(uint* Type, uint* ProcessId, uint* ThreadId, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* ExtraInformation, 
                                        uint ExtraInformationSize, uint* ExtraInformationUsed, PWSTR Description, 
                                        uint DescriptionSize, uint* DescriptionUsed);
    HRESULT GetTextReplacementWide(const(PWSTR) SrcText, uint Index, PWSTR SrcBuffer, uint SrcBufferSize, 
                                   uint* SrcSize, PWSTR DstBuffer, uint DstBufferSize, uint* DstSize);
    HRESULT SetTextReplacementWide(const(PWSTR) SrcText, const(PWSTR) DstText);
    HRESULT SetExpressionSyntaxByNameWide(const(PWSTR) AbbrevName);
    HRESULT GetExpressionSyntaxNamesWide(uint Index, PWSTR FullNameBuffer, uint FullNameBufferSize, 
                                         uint* FullNameSize, PWSTR AbbrevNameBuffer, uint AbbrevNameBufferSize, 
                                         uint* AbbrevNameSize);
    HRESULT GetEventIndexDescriptionWide(uint Index, uint Which, PWSTR Buffer, uint BufferSize, uint* DescSize);
    HRESULT GetLogFile2(PSTR Buffer, uint BufferSize, uint* FileSize, uint* Flags);
    HRESULT OpenLogFile2(const(PSTR) File, uint Flags);
    HRESULT GetLogFile2Wide(PWSTR Buffer, uint BufferSize, uint* FileSize, uint* Flags);
    HRESULT OpenLogFile2Wide(const(PWSTR) File, uint Flags);
    HRESULT GetSystemVersionValues(uint* PlatformId, uint* Win32Major, uint* Win32Minor, uint* KdMajor, 
                                   uint* KdMinor);
    HRESULT GetSystemVersionString(uint Which, PSTR Buffer, uint BufferSize, uint* StringSize);
    HRESULT GetSystemVersionStringWide(uint Which, PWSTR Buffer, uint BufferSize, uint* StringSize);
    HRESULT GetContextStackTrace(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* StartContext, 
                                 uint StartContextSize, DEBUG_STACK_FRAME* Frames, uint FramesSize, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* FrameContexts, 
                                 uint FrameContextsSize, uint FrameContextsEntrySize, uint* FramesFilled);
    HRESULT OutputContextStackTrace(uint OutputControl, DEBUG_STACK_FRAME* Frames, uint FramesSize, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* FrameContexts, 
                                    uint FrameContextsSize, uint FrameContextsEntrySize, uint Flags);
    HRESULT GetStoredEventInformation(uint* Type, uint* ProcessId, uint* ThreadId, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Context, 
                                      uint ContextSize, uint* ContextUsed, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* ExtraInformation, 
                                      uint ExtraInformationSize, uint* ExtraInformationUsed);
    HRESULT GetManagedStatus(uint* Flags, uint WhichString, PSTR String, uint StringSize, uint* StringNeeded);
    HRESULT GetManagedStatusWide(uint* Flags, uint WhichString, PWSTR String, uint StringSize, uint* StringNeeded);
    HRESULT ResetManagedStatus(uint Flags);
    HRESULT GetStackTraceEx(ulong FrameOffset, ulong StackOffset, ulong InstructionOffset, 
                            DEBUG_STACK_FRAME_EX* Frames, uint FramesSize, uint* FramesFilled);
    HRESULT OutputStackTraceEx(uint OutputControl, DEBUG_STACK_FRAME_EX* Frames, uint FramesSize, uint Flags);
    HRESULT GetContextStackTraceEx(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* StartContext, 
                                   uint StartContextSize, DEBUG_STACK_FRAME_EX* Frames, uint FramesSize, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* FrameContexts, 
                                   uint FrameContextsSize, uint FrameContextsEntrySize, uint* FramesFilled);
    HRESULT OutputContextStackTraceEx(uint OutputControl, DEBUG_STACK_FRAME_EX* Frames, uint FramesSize, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* FrameContexts, 
                                      uint FrameContextsSize, uint FrameContextsEntrySize, uint Flags);
    HRESULT GetBreakpointByGuid(GUID* Guid, IDebugBreakpoint3* Bp);
}

@GUID("bc0d583f-126d-43a1-9cc4-a860ab1d537b")
interface IDebugControl6 : IUnknown
{
    HRESULT GetInterrupt();
    HRESULT SetInterrupt(uint Flags);
    HRESULT GetInterruptTimeout(uint* Seconds);
    HRESULT SetInterruptTimeout(uint Seconds);
    HRESULT GetLogFile(PSTR Buffer, uint BufferSize, uint* FileSize, BOOL* Append);
    HRESULT OpenLogFile(const(PSTR) File, BOOL Append);
    HRESULT CloseLogFile();
    HRESULT GetLogMask(uint* Mask);
    HRESULT SetLogMask(uint Mask);
    HRESULT Input(PSTR Buffer, uint BufferSize, uint* InputSize);
    HRESULT ReturnInput(const(PSTR) Buffer);
    HRESULT Output(uint Mask, const(PSTR) Format);
    HRESULT OutputVaList(uint Mask, const(PSTR) Format, byte* Args);
    HRESULT ControlledOutput(uint OutputControl, uint Mask, const(PSTR) Format);
    HRESULT ControlledOutputVaList(uint OutputControl, uint Mask, const(PSTR) Format, byte* Args);
    HRESULT OutputPrompt(uint OutputControl, const(PSTR) Format);
    HRESULT OutputPromptVaList(uint OutputControl, const(PSTR) Format, byte* Args);
    HRESULT GetPromptText(PSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT OutputCurrentState(uint OutputControl, uint Flags);
    HRESULT OutputVersionInformation(uint OutputControl);
    HRESULT GetNotifyEventHandle(ulong* Handle);
    HRESULT SetNotifyEventHandle(ulong Handle);
    HRESULT Assemble(ulong Offset, const(PSTR) Instr, ulong* EndOffset);
    HRESULT Disassemble(ulong Offset, uint Flags, PSTR Buffer, uint BufferSize, uint* DisassemblySize, 
                        ulong* EndOffset);
    HRESULT GetDisassembleEffectiveOffset(ulong* Offset);
    HRESULT OutputDisassembly(uint OutputControl, ulong Offset, uint Flags, ulong* EndOffset);
    HRESULT OutputDisassemblyLines(uint OutputControl, uint PreviousLines, uint TotalLines, ulong Offset, 
                                   uint Flags, uint* OffsetLine, ulong* StartOffset, ulong* EndOffset, 
                                   ulong* LineOffsets);
    HRESULT GetNearInstruction(ulong Offset, int Delta, ulong* NearOffset);
    HRESULT GetStackTrace(ulong FrameOffset, ulong StackOffset, ulong InstructionOffset, DEBUG_STACK_FRAME* Frames, 
                          uint FramesSize, uint* FramesFilled);
    HRESULT GetReturnOffset(ulong* Offset);
    HRESULT OutputStackTrace(uint OutputControl, DEBUG_STACK_FRAME* Frames, uint FramesSize, uint Flags);
    HRESULT GetDebuggeeType(uint* Class, uint* Qualifier);
    HRESULT GetActualProcessorType(uint* Type);
    HRESULT GetExecutingProcessorType(uint* Type);
    HRESULT GetNumberPossibleExecutingProcessorTypes(uint* Number);
    HRESULT GetPossibleExecutingProcessorTypes(uint Start, uint Count, uint* Types);
    HRESULT GetNumberProcessors(uint* Number);
    HRESULT GetSystemVersion(uint* PlatformId, uint* Major, uint* Minor, PSTR ServicePackString, 
                             uint ServicePackStringSize, uint* ServicePackStringUsed, uint* ServicePackNumber, 
                             PSTR BuildString, uint BuildStringSize, uint* BuildStringUsed);
    HRESULT GetPageSize(uint* Size);
    HRESULT IsPointer64Bit();
    HRESULT ReadBugCheckData(uint* Code, ulong* Arg1, ulong* Arg2, ulong* Arg3, ulong* Arg4);
    HRESULT GetNumberSupportedProcessorTypes(uint* Number);
    HRESULT GetSupportedProcessorTypes(uint Start, uint Count, uint* Types);
    HRESULT GetProcessorTypeNames(uint Type, PSTR FullNameBuffer, uint FullNameBufferSize, uint* FullNameSize, 
                                  PSTR AbbrevNameBuffer, uint AbbrevNameBufferSize, uint* AbbrevNameSize);
    HRESULT GetEffectiveProcessorType(uint* Type);
    HRESULT SetEffectiveProcessorType(uint Type);
    HRESULT GetExecutionStatus(uint* Status);
    HRESULT SetExecutionStatus(uint Status);
    HRESULT GetCodeLevel(uint* Level);
    HRESULT SetCodeLevel(uint Level);
    HRESULT GetEngineOptions(uint* Options);
    HRESULT AddEngineOptions(uint Options);
    HRESULT RemoveEngineOptions(uint Options);
    HRESULT SetEngineOptions(uint Options);
    HRESULT GetSystemErrorControl(uint* OutputLevel, uint* BreakLevel);
    HRESULT SetSystemErrorControl(uint OutputLevel, uint BreakLevel);
    HRESULT GetTextMacro(uint Slot, PSTR Buffer, uint BufferSize, uint* MacroSize);
    HRESULT SetTextMacro(uint Slot, const(PSTR) Macro);
    HRESULT GetRadix(uint* Radix);
    HRESULT SetRadix(uint Radix);
    HRESULT Evaluate(const(PSTR) Expression, uint DesiredType, DEBUG_VALUE* Value, uint* RemainderIndex);
    HRESULT CoerceValue(DEBUG_VALUE* In, uint OutType, DEBUG_VALUE* Out);
    HRESULT CoerceValues(uint Count, DEBUG_VALUE* In, uint* OutTypes, DEBUG_VALUE* Out);
    HRESULT Execute(uint OutputControl, const(PSTR) Command, uint Flags);
    HRESULT ExecuteCommandFile(uint OutputControl, const(PSTR) CommandFile, uint Flags);
    HRESULT GetNumberBreakpoints(uint* Number);
    HRESULT GetBreakpointByIndex(uint Index, IDebugBreakpoint* Bp);
    HRESULT GetBreakpointById(uint Id, IDebugBreakpoint* Bp);
    HRESULT GetBreakpointParameters(uint Count, uint* Ids, uint Start, DEBUG_BREAKPOINT_PARAMETERS* Params);
    HRESULT AddBreakpoint(uint Type, uint DesiredId, IDebugBreakpoint* Bp);
    HRESULT RemoveBreakpoint(IDebugBreakpoint Bp);
    HRESULT AddExtension(const(PSTR) Path, uint Flags, ulong* Handle);
    HRESULT RemoveExtension(ulong Handle);
    HRESULT GetExtensionByPath(const(PSTR) Path, ulong* Handle);
    HRESULT CallExtension(ulong Handle, const(PSTR) Function, const(PSTR) Arguments);
    HRESULT GetExtensionFunction(ulong Handle, const(PSTR) FuncName, FARPROC* Function);
    HRESULT GetWindbgExtensionApis32(WINDBG_EXTENSION_APIS32* Api);
    HRESULT GetWindbgExtensionApis64(WINDBG_EXTENSION_APIS64* Api);
    HRESULT GetNumberEventFilters(uint* SpecificEvents, uint* SpecificExceptions, uint* ArbitraryExceptions);
    HRESULT GetEventFilterText(uint Index, PSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT GetEventFilterCommand(uint Index, PSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetEventFilterCommand(uint Index, const(PSTR) Command);
    HRESULT GetSpecificFilterParameters(uint Start, uint Count, DEBUG_SPECIFIC_FILTER_PARAMETERS* Params);
    HRESULT SetSpecificFilterParameters(uint Start, uint Count, DEBUG_SPECIFIC_FILTER_PARAMETERS* Params);
    HRESULT GetSpecificFilterArgument(uint Index, PSTR Buffer, uint BufferSize, uint* ArgumentSize);
    HRESULT SetSpecificFilterArgument(uint Index, const(PSTR) Argument);
    HRESULT GetExceptionFilterParameters(uint Count, uint* Codes, uint Start, 
                                         DEBUG_EXCEPTION_FILTER_PARAMETERS* Params);
    HRESULT SetExceptionFilterParameters(uint Count, DEBUG_EXCEPTION_FILTER_PARAMETERS* Params);
    HRESULT GetExceptionFilterSecondCommand(uint Index, PSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetExceptionFilterSecondCommand(uint Index, const(PSTR) Command);
    HRESULT WaitForEvent(uint Flags, uint Timeout);
    HRESULT GetLastEventInformation(uint* Type, uint* ProcessId, uint* ThreadId, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* ExtraInformation, 
                                    uint ExtraInformationSize, uint* ExtraInformationUsed, PSTR Description, 
                                    uint DescriptionSize, uint* DescriptionUsed);
    HRESULT GetCurrentTimeDate(uint* TimeDate);
    HRESULT GetCurrentSystemUpTime(uint* UpTime);
    HRESULT GetDumpFormatFlags(uint* FormatFlags);
    HRESULT GetNumberTextReplacements(uint* NumRepl);
    HRESULT GetTextReplacement(const(PSTR) SrcText, uint Index, PSTR SrcBuffer, uint SrcBufferSize, uint* SrcSize, 
                               PSTR DstBuffer, uint DstBufferSize, uint* DstSize);
    HRESULT SetTextReplacement(const(PSTR) SrcText, const(PSTR) DstText);
    HRESULT RemoveTextReplacements();
    HRESULT OutputTextReplacements(uint OutputControl, uint Flags);
    HRESULT GetAssemblyOptions(uint* Options);
    HRESULT AddAssemblyOptions(uint Options);
    HRESULT RemoveAssemblyOptions(uint Options);
    HRESULT SetAssemblyOptions(uint Options);
    HRESULT GetExpressionSyntax(uint* Flags);
    HRESULT SetExpressionSyntax(uint Flags);
    HRESULT SetExpressionSyntaxByName(const(PSTR) AbbrevName);
    HRESULT GetNumberExpressionSyntaxes(uint* Number);
    HRESULT GetExpressionSyntaxNames(uint Index, PSTR FullNameBuffer, uint FullNameBufferSize, uint* FullNameSize, 
                                     PSTR AbbrevNameBuffer, uint AbbrevNameBufferSize, uint* AbbrevNameSize);
    HRESULT GetNumberEvents(uint* Events);
    HRESULT GetEventIndexDescription(uint Index, uint Which, PSTR Buffer, uint BufferSize, uint* DescSize);
    HRESULT GetCurrentEventIndex(uint* Index);
    HRESULT SetNextEventIndex(uint Relation, uint Value, uint* NextIndex);
    HRESULT GetLogFileWide(PWSTR Buffer, uint BufferSize, uint* FileSize, BOOL* Append);
    HRESULT OpenLogFileWide(const(PWSTR) File, BOOL Append);
    HRESULT InputWide(PWSTR Buffer, uint BufferSize, uint* InputSize);
    HRESULT ReturnInputWide(const(PWSTR) Buffer);
    HRESULT OutputWide(uint Mask, const(PWSTR) Format);
    HRESULT OutputVaListWide(uint Mask, const(PWSTR) Format, byte* Args);
    HRESULT ControlledOutputWide(uint OutputControl, uint Mask, const(PWSTR) Format);
    HRESULT ControlledOutputVaListWide(uint OutputControl, uint Mask, const(PWSTR) Format, byte* Args);
    HRESULT OutputPromptWide(uint OutputControl, const(PWSTR) Format);
    HRESULT OutputPromptVaListWide(uint OutputControl, const(PWSTR) Format, byte* Args);
    HRESULT GetPromptTextWide(PWSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT AssembleWide(ulong Offset, const(PWSTR) Instr, ulong* EndOffset);
    HRESULT DisassembleWide(ulong Offset, uint Flags, PWSTR Buffer, uint BufferSize, uint* DisassemblySize, 
                            ulong* EndOffset);
    HRESULT GetProcessorTypeNamesWide(uint Type, PWSTR FullNameBuffer, uint FullNameBufferSize, uint* FullNameSize, 
                                      PWSTR AbbrevNameBuffer, uint AbbrevNameBufferSize, uint* AbbrevNameSize);
    HRESULT GetTextMacroWide(uint Slot, PWSTR Buffer, uint BufferSize, uint* MacroSize);
    HRESULT SetTextMacroWide(uint Slot, const(PWSTR) Macro);
    HRESULT EvaluateWide(const(PWSTR) Expression, uint DesiredType, DEBUG_VALUE* Value, uint* RemainderIndex);
    HRESULT ExecuteWide(uint OutputControl, const(PWSTR) Command, uint Flags);
    HRESULT ExecuteCommandFileWide(uint OutputControl, const(PWSTR) CommandFile, uint Flags);
    HRESULT GetBreakpointByIndex2(uint Index, IDebugBreakpoint2* Bp);
    HRESULT GetBreakpointById2(uint Id, IDebugBreakpoint2* Bp);
    HRESULT AddBreakpoint2(uint Type, uint DesiredId, IDebugBreakpoint2* Bp);
    HRESULT RemoveBreakpoint2(IDebugBreakpoint2 Bp);
    HRESULT AddExtensionWide(const(PWSTR) Path, uint Flags, ulong* Handle);
    HRESULT GetExtensionByPathWide(const(PWSTR) Path, ulong* Handle);
    HRESULT CallExtensionWide(ulong Handle, const(PWSTR) Function, const(PWSTR) Arguments);
    HRESULT GetExtensionFunctionWide(ulong Handle, const(PWSTR) FuncName, FARPROC* Function);
    HRESULT GetEventFilterTextWide(uint Index, PWSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT GetEventFilterCommandWide(uint Index, PWSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetEventFilterCommandWide(uint Index, const(PWSTR) Command);
    HRESULT GetSpecificFilterArgumentWide(uint Index, PWSTR Buffer, uint BufferSize, uint* ArgumentSize);
    HRESULT SetSpecificFilterArgumentWide(uint Index, const(PWSTR) Argument);
    HRESULT GetExceptionFilterSecondCommandWide(uint Index, PWSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetExceptionFilterSecondCommandWide(uint Index, const(PWSTR) Command);
    HRESULT GetLastEventInformationWide(uint* Type, uint* ProcessId, uint* ThreadId, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* ExtraInformation, 
                                        uint ExtraInformationSize, uint* ExtraInformationUsed, PWSTR Description, 
                                        uint DescriptionSize, uint* DescriptionUsed);
    HRESULT GetTextReplacementWide(const(PWSTR) SrcText, uint Index, PWSTR SrcBuffer, uint SrcBufferSize, 
                                   uint* SrcSize, PWSTR DstBuffer, uint DstBufferSize, uint* DstSize);
    HRESULT SetTextReplacementWide(const(PWSTR) SrcText, const(PWSTR) DstText);
    HRESULT SetExpressionSyntaxByNameWide(const(PWSTR) AbbrevName);
    HRESULT GetExpressionSyntaxNamesWide(uint Index, PWSTR FullNameBuffer, uint FullNameBufferSize, 
                                         uint* FullNameSize, PWSTR AbbrevNameBuffer, uint AbbrevNameBufferSize, 
                                         uint* AbbrevNameSize);
    HRESULT GetEventIndexDescriptionWide(uint Index, uint Which, PWSTR Buffer, uint BufferSize, uint* DescSize);
    HRESULT GetLogFile2(PSTR Buffer, uint BufferSize, uint* FileSize, uint* Flags);
    HRESULT OpenLogFile2(const(PSTR) File, uint Flags);
    HRESULT GetLogFile2Wide(PWSTR Buffer, uint BufferSize, uint* FileSize, uint* Flags);
    HRESULT OpenLogFile2Wide(const(PWSTR) File, uint Flags);
    HRESULT GetSystemVersionValues(uint* PlatformId, uint* Win32Major, uint* Win32Minor, uint* KdMajor, 
                                   uint* KdMinor);
    HRESULT GetSystemVersionString(uint Which, PSTR Buffer, uint BufferSize, uint* StringSize);
    HRESULT GetSystemVersionStringWide(uint Which, PWSTR Buffer, uint BufferSize, uint* StringSize);
    HRESULT GetContextStackTrace(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* StartContext, 
                                 uint StartContextSize, DEBUG_STACK_FRAME* Frames, uint FramesSize, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* FrameContexts, 
                                 uint FrameContextsSize, uint FrameContextsEntrySize, uint* FramesFilled);
    HRESULT OutputContextStackTrace(uint OutputControl, DEBUG_STACK_FRAME* Frames, uint FramesSize, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* FrameContexts, 
                                    uint FrameContextsSize, uint FrameContextsEntrySize, uint Flags);
    HRESULT GetStoredEventInformation(uint* Type, uint* ProcessId, uint* ThreadId, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Context, 
                                      uint ContextSize, uint* ContextUsed, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* ExtraInformation, 
                                      uint ExtraInformationSize, uint* ExtraInformationUsed);
    HRESULT GetManagedStatus(uint* Flags, uint WhichString, PSTR String, uint StringSize, uint* StringNeeded);
    HRESULT GetManagedStatusWide(uint* Flags, uint WhichString, PWSTR String, uint StringSize, uint* StringNeeded);
    HRESULT ResetManagedStatus(uint Flags);
    HRESULT GetStackTraceEx(ulong FrameOffset, ulong StackOffset, ulong InstructionOffset, 
                            DEBUG_STACK_FRAME_EX* Frames, uint FramesSize, uint* FramesFilled);
    HRESULT OutputStackTraceEx(uint OutputControl, DEBUG_STACK_FRAME_EX* Frames, uint FramesSize, uint Flags);
    HRESULT GetContextStackTraceEx(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* StartContext, 
                                   uint StartContextSize, DEBUG_STACK_FRAME_EX* Frames, uint FramesSize, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* FrameContexts, 
                                   uint FrameContextsSize, uint FrameContextsEntrySize, uint* FramesFilled);
    HRESULT OutputContextStackTraceEx(uint OutputControl, DEBUG_STACK_FRAME_EX* Frames, uint FramesSize, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* FrameContexts, 
                                      uint FrameContextsSize, uint FrameContextsEntrySize, uint Flags);
    HRESULT GetBreakpointByGuid(GUID* Guid, IDebugBreakpoint3* Bp);
    HRESULT GetExecutionStatusEx(uint* Status);
    HRESULT GetSynchronizationStatus(uint* SendsAttempted, uint* SecondsSinceLastResponse);
}

@GUID("b86fb3b1-80d4-475b-aea3-cf06539cf63a")
interface IDebugControl7 : IUnknown
{
    HRESULT GetInterrupt();
    HRESULT SetInterrupt(uint Flags);
    HRESULT GetInterruptTimeout(uint* Seconds);
    HRESULT SetInterruptTimeout(uint Seconds);
    HRESULT GetLogFile(PSTR Buffer, uint BufferSize, uint* FileSize, BOOL* Append);
    HRESULT OpenLogFile(const(PSTR) File, BOOL Append);
    HRESULT CloseLogFile();
    HRESULT GetLogMask(uint* Mask);
    HRESULT SetLogMask(uint Mask);
    HRESULT Input(PSTR Buffer, uint BufferSize, uint* InputSize);
    HRESULT ReturnInput(const(PSTR) Buffer);
    HRESULT Output(uint Mask, const(PSTR) Format);
    HRESULT OutputVaList(uint Mask, const(PSTR) Format, byte* Args);
    HRESULT ControlledOutput(uint OutputControl, uint Mask, const(PSTR) Format);
    HRESULT ControlledOutputVaList(uint OutputControl, uint Mask, const(PSTR) Format, byte* Args);
    HRESULT OutputPrompt(uint OutputControl, const(PSTR) Format);
    HRESULT OutputPromptVaList(uint OutputControl, const(PSTR) Format, byte* Args);
    HRESULT GetPromptText(PSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT OutputCurrentState(uint OutputControl, uint Flags);
    HRESULT OutputVersionInformation(uint OutputControl);
    HRESULT GetNotifyEventHandle(ulong* Handle);
    HRESULT SetNotifyEventHandle(ulong Handle);
    HRESULT Assemble(ulong Offset, const(PSTR) Instr, ulong* EndOffset);
    HRESULT Disassemble(ulong Offset, uint Flags, PSTR Buffer, uint BufferSize, uint* DisassemblySize, 
                        ulong* EndOffset);
    HRESULT GetDisassembleEffectiveOffset(ulong* Offset);
    HRESULT OutputDisassembly(uint OutputControl, ulong Offset, uint Flags, ulong* EndOffset);
    HRESULT OutputDisassemblyLines(uint OutputControl, uint PreviousLines, uint TotalLines, ulong Offset, 
                                   uint Flags, uint* OffsetLine, ulong* StartOffset, ulong* EndOffset, 
                                   ulong* LineOffsets);
    HRESULT GetNearInstruction(ulong Offset, int Delta, ulong* NearOffset);
    HRESULT GetStackTrace(ulong FrameOffset, ulong StackOffset, ulong InstructionOffset, DEBUG_STACK_FRAME* Frames, 
                          uint FramesSize, uint* FramesFilled);
    HRESULT GetReturnOffset(ulong* Offset);
    HRESULT OutputStackTrace(uint OutputControl, DEBUG_STACK_FRAME* Frames, uint FramesSize, uint Flags);
    HRESULT GetDebuggeeType(uint* Class, uint* Qualifier);
    HRESULT GetActualProcessorType(uint* Type);
    HRESULT GetExecutingProcessorType(uint* Type);
    HRESULT GetNumberPossibleExecutingProcessorTypes(uint* Number);
    HRESULT GetPossibleExecutingProcessorTypes(uint Start, uint Count, uint* Types);
    HRESULT GetNumberProcessors(uint* Number);
    HRESULT GetSystemVersion(uint* PlatformId, uint* Major, uint* Minor, PSTR ServicePackString, 
                             uint ServicePackStringSize, uint* ServicePackStringUsed, uint* ServicePackNumber, 
                             PSTR BuildString, uint BuildStringSize, uint* BuildStringUsed);
    HRESULT GetPageSize(uint* Size);
    HRESULT IsPointer64Bit();
    HRESULT ReadBugCheckData(uint* Code, ulong* Arg1, ulong* Arg2, ulong* Arg3, ulong* Arg4);
    HRESULT GetNumberSupportedProcessorTypes(uint* Number);
    HRESULT GetSupportedProcessorTypes(uint Start, uint Count, uint* Types);
    HRESULT GetProcessorTypeNames(uint Type, PSTR FullNameBuffer, uint FullNameBufferSize, uint* FullNameSize, 
                                  PSTR AbbrevNameBuffer, uint AbbrevNameBufferSize, uint* AbbrevNameSize);
    HRESULT GetEffectiveProcessorType(uint* Type);
    HRESULT SetEffectiveProcessorType(uint Type);
    HRESULT GetExecutionStatus(uint* Status);
    HRESULT SetExecutionStatus(uint Status);
    HRESULT GetCodeLevel(uint* Level);
    HRESULT SetCodeLevel(uint Level);
    HRESULT GetEngineOptions(uint* Options);
    HRESULT AddEngineOptions(uint Options);
    HRESULT RemoveEngineOptions(uint Options);
    HRESULT SetEngineOptions(uint Options);
    HRESULT GetSystemErrorControl(uint* OutputLevel, uint* BreakLevel);
    HRESULT SetSystemErrorControl(uint OutputLevel, uint BreakLevel);
    HRESULT GetTextMacro(uint Slot, PSTR Buffer, uint BufferSize, uint* MacroSize);
    HRESULT SetTextMacro(uint Slot, const(PSTR) Macro);
    HRESULT GetRadix(uint* Radix);
    HRESULT SetRadix(uint Radix);
    HRESULT Evaluate(const(PSTR) Expression, uint DesiredType, DEBUG_VALUE* Value, uint* RemainderIndex);
    HRESULT CoerceValue(DEBUG_VALUE* In, uint OutType, DEBUG_VALUE* Out);
    HRESULT CoerceValues(uint Count, DEBUG_VALUE* In, uint* OutTypes, DEBUG_VALUE* Out);
    HRESULT Execute(uint OutputControl, const(PSTR) Command, uint Flags);
    HRESULT ExecuteCommandFile(uint OutputControl, const(PSTR) CommandFile, uint Flags);
    HRESULT GetNumberBreakpoints(uint* Number);
    HRESULT GetBreakpointByIndex(uint Index, IDebugBreakpoint* Bp);
    HRESULT GetBreakpointById(uint Id, IDebugBreakpoint* Bp);
    HRESULT GetBreakpointParameters(uint Count, uint* Ids, uint Start, DEBUG_BREAKPOINT_PARAMETERS* Params);
    HRESULT AddBreakpoint(uint Type, uint DesiredId, IDebugBreakpoint* Bp);
    HRESULT RemoveBreakpoint(IDebugBreakpoint Bp);
    HRESULT AddExtension(const(PSTR) Path, uint Flags, ulong* Handle);
    HRESULT RemoveExtension(ulong Handle);
    HRESULT GetExtensionByPath(const(PSTR) Path, ulong* Handle);
    HRESULT CallExtension(ulong Handle, const(PSTR) Function, const(PSTR) Arguments);
    HRESULT GetExtensionFunction(ulong Handle, const(PSTR) FuncName, FARPROC* Function);
    HRESULT GetWindbgExtensionApis32(WINDBG_EXTENSION_APIS32* Api);
    HRESULT GetWindbgExtensionApis64(WINDBG_EXTENSION_APIS64* Api);
    HRESULT GetNumberEventFilters(uint* SpecificEvents, uint* SpecificExceptions, uint* ArbitraryExceptions);
    HRESULT GetEventFilterText(uint Index, PSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT GetEventFilterCommand(uint Index, PSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetEventFilterCommand(uint Index, const(PSTR) Command);
    HRESULT GetSpecificFilterParameters(uint Start, uint Count, DEBUG_SPECIFIC_FILTER_PARAMETERS* Params);
    HRESULT SetSpecificFilterParameters(uint Start, uint Count, DEBUG_SPECIFIC_FILTER_PARAMETERS* Params);
    HRESULT GetSpecificFilterArgument(uint Index, PSTR Buffer, uint BufferSize, uint* ArgumentSize);
    HRESULT SetSpecificFilterArgument(uint Index, const(PSTR) Argument);
    HRESULT GetExceptionFilterParameters(uint Count, uint* Codes, uint Start, 
                                         DEBUG_EXCEPTION_FILTER_PARAMETERS* Params);
    HRESULT SetExceptionFilterParameters(uint Count, DEBUG_EXCEPTION_FILTER_PARAMETERS* Params);
    HRESULT GetExceptionFilterSecondCommand(uint Index, PSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetExceptionFilterSecondCommand(uint Index, const(PSTR) Command);
    HRESULT WaitForEvent(uint Flags, uint Timeout);
    HRESULT GetLastEventInformation(uint* Type, uint* ProcessId, uint* ThreadId, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* ExtraInformation, 
                                    uint ExtraInformationSize, uint* ExtraInformationUsed, PSTR Description, 
                                    uint DescriptionSize, uint* DescriptionUsed);
    HRESULT GetCurrentTimeDate(uint* TimeDate);
    HRESULT GetCurrentSystemUpTime(uint* UpTime);
    HRESULT GetDumpFormatFlags(uint* FormatFlags);
    HRESULT GetNumberTextReplacements(uint* NumRepl);
    HRESULT GetTextReplacement(const(PSTR) SrcText, uint Index, PSTR SrcBuffer, uint SrcBufferSize, uint* SrcSize, 
                               PSTR DstBuffer, uint DstBufferSize, uint* DstSize);
    HRESULT SetTextReplacement(const(PSTR) SrcText, const(PSTR) DstText);
    HRESULT RemoveTextReplacements();
    HRESULT OutputTextReplacements(uint OutputControl, uint Flags);
    HRESULT GetAssemblyOptions(uint* Options);
    HRESULT AddAssemblyOptions(uint Options);
    HRESULT RemoveAssemblyOptions(uint Options);
    HRESULT SetAssemblyOptions(uint Options);
    HRESULT GetExpressionSyntax(uint* Flags);
    HRESULT SetExpressionSyntax(uint Flags);
    HRESULT SetExpressionSyntaxByName(const(PSTR) AbbrevName);
    HRESULT GetNumberExpressionSyntaxes(uint* Number);
    HRESULT GetExpressionSyntaxNames(uint Index, PSTR FullNameBuffer, uint FullNameBufferSize, uint* FullNameSize, 
                                     PSTR AbbrevNameBuffer, uint AbbrevNameBufferSize, uint* AbbrevNameSize);
    HRESULT GetNumberEvents(uint* Events);
    HRESULT GetEventIndexDescription(uint Index, uint Which, PSTR Buffer, uint BufferSize, uint* DescSize);
    HRESULT GetCurrentEventIndex(uint* Index);
    HRESULT SetNextEventIndex(uint Relation, uint Value, uint* NextIndex);
    HRESULT GetLogFileWide(PWSTR Buffer, uint BufferSize, uint* FileSize, BOOL* Append);
    HRESULT OpenLogFileWide(const(PWSTR) File, BOOL Append);
    HRESULT InputWide(PWSTR Buffer, uint BufferSize, uint* InputSize);
    HRESULT ReturnInputWide(const(PWSTR) Buffer);
    HRESULT OutputWide(uint Mask, const(PWSTR) Format);
    HRESULT OutputVaListWide(uint Mask, const(PWSTR) Format, byte* Args);
    HRESULT ControlledOutputWide(uint OutputControl, uint Mask, const(PWSTR) Format);
    HRESULT ControlledOutputVaListWide(uint OutputControl, uint Mask, const(PWSTR) Format, byte* Args);
    HRESULT OutputPromptWide(uint OutputControl, const(PWSTR) Format);
    HRESULT OutputPromptVaListWide(uint OutputControl, const(PWSTR) Format, byte* Args);
    HRESULT GetPromptTextWide(PWSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT AssembleWide(ulong Offset, const(PWSTR) Instr, ulong* EndOffset);
    HRESULT DisassembleWide(ulong Offset, uint Flags, PWSTR Buffer, uint BufferSize, uint* DisassemblySize, 
                            ulong* EndOffset);
    HRESULT GetProcessorTypeNamesWide(uint Type, PWSTR FullNameBuffer, uint FullNameBufferSize, uint* FullNameSize, 
                                      PWSTR AbbrevNameBuffer, uint AbbrevNameBufferSize, uint* AbbrevNameSize);
    HRESULT GetTextMacroWide(uint Slot, PWSTR Buffer, uint BufferSize, uint* MacroSize);
    HRESULT SetTextMacroWide(uint Slot, const(PWSTR) Macro);
    HRESULT EvaluateWide(const(PWSTR) Expression, uint DesiredType, DEBUG_VALUE* Value, uint* RemainderIndex);
    HRESULT ExecuteWide(uint OutputControl, const(PWSTR) Command, uint Flags);
    HRESULT ExecuteCommandFileWide(uint OutputControl, const(PWSTR) CommandFile, uint Flags);
    HRESULT GetBreakpointByIndex2(uint Index, IDebugBreakpoint2* Bp);
    HRESULT GetBreakpointById2(uint Id, IDebugBreakpoint2* Bp);
    HRESULT AddBreakpoint2(uint Type, uint DesiredId, IDebugBreakpoint2* Bp);
    HRESULT RemoveBreakpoint2(IDebugBreakpoint2 Bp);
    HRESULT AddExtensionWide(const(PWSTR) Path, uint Flags, ulong* Handle);
    HRESULT GetExtensionByPathWide(const(PWSTR) Path, ulong* Handle);
    HRESULT CallExtensionWide(ulong Handle, const(PWSTR) Function, const(PWSTR) Arguments);
    HRESULT GetExtensionFunctionWide(ulong Handle, const(PWSTR) FuncName, FARPROC* Function);
    HRESULT GetEventFilterTextWide(uint Index, PWSTR Buffer, uint BufferSize, uint* TextSize);
    HRESULT GetEventFilterCommandWide(uint Index, PWSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetEventFilterCommandWide(uint Index, const(PWSTR) Command);
    HRESULT GetSpecificFilterArgumentWide(uint Index, PWSTR Buffer, uint BufferSize, uint* ArgumentSize);
    HRESULT SetSpecificFilterArgumentWide(uint Index, const(PWSTR) Argument);
    HRESULT GetExceptionFilterSecondCommandWide(uint Index, PWSTR Buffer, uint BufferSize, uint* CommandSize);
    HRESULT SetExceptionFilterSecondCommandWide(uint Index, const(PWSTR) Command);
    HRESULT GetLastEventInformationWide(uint* Type, uint* ProcessId, uint* ThreadId, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* ExtraInformation, 
                                        uint ExtraInformationSize, uint* ExtraInformationUsed, PWSTR Description, 
                                        uint DescriptionSize, uint* DescriptionUsed);
    HRESULT GetTextReplacementWide(const(PWSTR) SrcText, uint Index, PWSTR SrcBuffer, uint SrcBufferSize, 
                                   uint* SrcSize, PWSTR DstBuffer, uint DstBufferSize, uint* DstSize);
    HRESULT SetTextReplacementWide(const(PWSTR) SrcText, const(PWSTR) DstText);
    HRESULT SetExpressionSyntaxByNameWide(const(PWSTR) AbbrevName);
    HRESULT GetExpressionSyntaxNamesWide(uint Index, PWSTR FullNameBuffer, uint FullNameBufferSize, 
                                         uint* FullNameSize, PWSTR AbbrevNameBuffer, uint AbbrevNameBufferSize, 
                                         uint* AbbrevNameSize);
    HRESULT GetEventIndexDescriptionWide(uint Index, uint Which, PWSTR Buffer, uint BufferSize, uint* DescSize);
    HRESULT GetLogFile2(PSTR Buffer, uint BufferSize, uint* FileSize, uint* Flags);
    HRESULT OpenLogFile2(const(PSTR) File, uint Flags);
    HRESULT GetLogFile2Wide(PWSTR Buffer, uint BufferSize, uint* FileSize, uint* Flags);
    HRESULT OpenLogFile2Wide(const(PWSTR) File, uint Flags);
    HRESULT GetSystemVersionValues(uint* PlatformId, uint* Win32Major, uint* Win32Minor, uint* KdMajor, 
                                   uint* KdMinor);
    HRESULT GetSystemVersionString(uint Which, PSTR Buffer, uint BufferSize, uint* StringSize);
    HRESULT GetSystemVersionStringWide(uint Which, PWSTR Buffer, uint BufferSize, uint* StringSize);
    HRESULT GetContextStackTrace(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* StartContext, 
                                 uint StartContextSize, DEBUG_STACK_FRAME* Frames, uint FramesSize, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* FrameContexts, 
                                 uint FrameContextsSize, uint FrameContextsEntrySize, uint* FramesFilled);
    HRESULT OutputContextStackTrace(uint OutputControl, DEBUG_STACK_FRAME* Frames, uint FramesSize, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* FrameContexts, 
                                    uint FrameContextsSize, uint FrameContextsEntrySize, uint Flags);
    HRESULT GetStoredEventInformation(uint* Type, uint* ProcessId, uint* ThreadId, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Context, 
                                      uint ContextSize, uint* ContextUsed, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* ExtraInformation, 
                                      uint ExtraInformationSize, uint* ExtraInformationUsed);
    HRESULT GetManagedStatus(uint* Flags, uint WhichString, PSTR String, uint StringSize, uint* StringNeeded);
    HRESULT GetManagedStatusWide(uint* Flags, uint WhichString, PWSTR String, uint StringSize, uint* StringNeeded);
    HRESULT ResetManagedStatus(uint Flags);
    HRESULT GetStackTraceEx(ulong FrameOffset, ulong StackOffset, ulong InstructionOffset, 
                            DEBUG_STACK_FRAME_EX* Frames, uint FramesSize, uint* FramesFilled);
    HRESULT OutputStackTraceEx(uint OutputControl, DEBUG_STACK_FRAME_EX* Frames, uint FramesSize, uint Flags);
    HRESULT GetContextStackTraceEx(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* StartContext, 
                                   uint StartContextSize, DEBUG_STACK_FRAME_EX* Frames, uint FramesSize, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* FrameContexts, 
                                   uint FrameContextsSize, uint FrameContextsEntrySize, uint* FramesFilled);
    HRESULT OutputContextStackTraceEx(uint OutputControl, DEBUG_STACK_FRAME_EX* Frames, uint FramesSize, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* FrameContexts, 
                                      uint FrameContextsSize, uint FrameContextsEntrySize, uint Flags);
    HRESULT GetBreakpointByGuid(GUID* Guid, IDebugBreakpoint3* Bp);
    HRESULT GetExecutionStatusEx(uint* Status);
    HRESULT GetSynchronizationStatus(uint* SendsAttempted, uint* SecondsSinceLastResponse);
    HRESULT GetDebuggeeType2(uint Flags, uint* Class, uint* Qualifier);
}

@GUID("88f7dfab-3ea7-4c3a-aefb-c4e8106173aa")
interface IDebugDataSpaces : IUnknown
{
    HRESULT ReadVirtual(ulong Offset, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                        uint BufferSize, uint* BytesRead);
    HRESULT WriteVirtual(ulong Offset, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                         uint BufferSize, uint* BytesWritten);
    HRESULT SearchVirtual(ulong Offset, ulong Length, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Pattern, 
                          uint PatternSize, uint PatternGranularity, ulong* MatchOffset);
    HRESULT ReadVirtualUncached(ulong Offset, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                                uint BufferSize, uint* BytesRead);
    HRESULT WriteVirtualUncached(ulong Offset, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                                 uint BufferSize, uint* BytesWritten);
    HRESULT ReadPointersVirtual(uint Count, ulong Offset, ulong* Ptrs);
    HRESULT WritePointersVirtual(uint Count, ulong Offset, ulong* Ptrs);
    HRESULT ReadPhysical(ulong Offset, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                         uint BufferSize, uint* BytesRead);
    HRESULT WritePhysical(ulong Offset, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                          uint BufferSize, uint* BytesWritten);
    HRESULT ReadControl(uint Processor, ulong Offset, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                        uint BufferSize, uint* BytesRead);
    HRESULT WriteControl(uint Processor, ulong Offset, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                         uint BufferSize, uint* BytesWritten);
    HRESULT ReadIo(uint InterfaceType, uint BusNumber, uint AddressSpace, ulong Offset, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                   uint BufferSize, uint* BytesRead);
    HRESULT WriteIo(uint InterfaceType, uint BusNumber, uint AddressSpace, ulong Offset, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                    uint BufferSize, uint* BytesWritten);
    HRESULT ReadMsr(uint Msr, ulong* Value);
    HRESULT WriteMsr(uint Msr, ulong Value);
    HRESULT ReadBusData(uint BusDataType, uint BusNumber, uint SlotNumber, uint Offset, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                        uint BufferSize, uint* BytesRead);
    HRESULT WriteBusData(uint BusDataType, uint BusNumber, uint SlotNumber, uint Offset, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                         uint BufferSize, uint* BytesWritten);
    HRESULT CheckLowMemory();
    HRESULT ReadDebuggerData(uint Index, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                             uint BufferSize, uint* DataSize);
    HRESULT ReadProcessorSystemData(uint Processor, uint Index, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                                    uint BufferSize, uint* DataSize);
}

@GUID("7a5e852f-96e9-468f-ac1b-0b3addc4a049")
interface IDebugDataSpaces2 : IUnknown
{
    HRESULT ReadVirtual(ulong Offset, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                        uint BufferSize, uint* BytesRead);
    HRESULT WriteVirtual(ulong Offset, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                         uint BufferSize, uint* BytesWritten);
    HRESULT SearchVirtual(ulong Offset, ulong Length, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Pattern, 
                          uint PatternSize, uint PatternGranularity, ulong* MatchOffset);
    HRESULT ReadVirtualUncached(ulong Offset, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                                uint BufferSize, uint* BytesRead);
    HRESULT WriteVirtualUncached(ulong Offset, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                                 uint BufferSize, uint* BytesWritten);
    HRESULT ReadPointersVirtual(uint Count, ulong Offset, ulong* Ptrs);
    HRESULT WritePointersVirtual(uint Count, ulong Offset, ulong* Ptrs);
    HRESULT ReadPhysical(ulong Offset, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                         uint BufferSize, uint* BytesRead);
    HRESULT WritePhysical(ulong Offset, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                          uint BufferSize, uint* BytesWritten);
    HRESULT ReadControl(uint Processor, ulong Offset, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                        uint BufferSize, uint* BytesRead);
    HRESULT WriteControl(uint Processor, ulong Offset, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                         uint BufferSize, uint* BytesWritten);
    HRESULT ReadIo(uint InterfaceType, uint BusNumber, uint AddressSpace, ulong Offset, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                   uint BufferSize, uint* BytesRead);
    HRESULT WriteIo(uint InterfaceType, uint BusNumber, uint AddressSpace, ulong Offset, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                    uint BufferSize, uint* BytesWritten);
    HRESULT ReadMsr(uint Msr, ulong* Value);
    HRESULT WriteMsr(uint Msr, ulong Value);
    HRESULT ReadBusData(uint BusDataType, uint BusNumber, uint SlotNumber, uint Offset, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                        uint BufferSize, uint* BytesRead);
    HRESULT WriteBusData(uint BusDataType, uint BusNumber, uint SlotNumber, uint Offset, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                         uint BufferSize, uint* BytesWritten);
    HRESULT CheckLowMemory();
    HRESULT ReadDebuggerData(uint Index, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                             uint BufferSize, uint* DataSize);
    HRESULT ReadProcessorSystemData(uint Processor, uint Index, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                                    uint BufferSize, uint* DataSize);
    HRESULT VirtualToPhysical(ulong Virtual, ulong* Physical);
    HRESULT GetVirtualTranslationPhysicalOffsets(ulong Virtual, ulong* Offsets, uint OffsetsSize, uint* Levels);
    HRESULT ReadHandleData(ulong Handle, uint DataType, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                           uint BufferSize, uint* DataSize);
    HRESULT FillVirtual(ulong Start, uint Size, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Pattern, 
                        uint PatternSize, uint* Filled);
    HRESULT FillPhysical(ulong Start, uint Size, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Pattern, 
                         uint PatternSize, uint* Filled);
    HRESULT QueryVirtual(ulong Offset, MEMORY_BASIC_INFORMATION64* Info);
}

@GUID("23f79d6c-8aaf-4f7c-a607-9995f5407e63")
interface IDebugDataSpaces3 : IUnknown
{
    HRESULT ReadVirtual(ulong Offset, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                        uint BufferSize, uint* BytesRead);
    HRESULT WriteVirtual(ulong Offset, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                         uint BufferSize, uint* BytesWritten);
    HRESULT SearchVirtual(ulong Offset, ulong Length, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Pattern, 
                          uint PatternSize, uint PatternGranularity, ulong* MatchOffset);
    HRESULT ReadVirtualUncached(ulong Offset, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                                uint BufferSize, uint* BytesRead);
    HRESULT WriteVirtualUncached(ulong Offset, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                                 uint BufferSize, uint* BytesWritten);
    HRESULT ReadPointersVirtual(uint Count, ulong Offset, ulong* Ptrs);
    HRESULT WritePointersVirtual(uint Count, ulong Offset, ulong* Ptrs);
    HRESULT ReadPhysical(ulong Offset, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                         uint BufferSize, uint* BytesRead);
    HRESULT WritePhysical(ulong Offset, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                          uint BufferSize, uint* BytesWritten);
    HRESULT ReadControl(uint Processor, ulong Offset, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                        uint BufferSize, uint* BytesRead);
    HRESULT WriteControl(uint Processor, ulong Offset, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                         uint BufferSize, uint* BytesWritten);
    HRESULT ReadIo(uint InterfaceType, uint BusNumber, uint AddressSpace, ulong Offset, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                   uint BufferSize, uint* BytesRead);
    HRESULT WriteIo(uint InterfaceType, uint BusNumber, uint AddressSpace, ulong Offset, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                    uint BufferSize, uint* BytesWritten);
    HRESULT ReadMsr(uint Msr, ulong* Value);
    HRESULT WriteMsr(uint Msr, ulong Value);
    HRESULT ReadBusData(uint BusDataType, uint BusNumber, uint SlotNumber, uint Offset, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                        uint BufferSize, uint* BytesRead);
    HRESULT WriteBusData(uint BusDataType, uint BusNumber, uint SlotNumber, uint Offset, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                         uint BufferSize, uint* BytesWritten);
    HRESULT CheckLowMemory();
    HRESULT ReadDebuggerData(uint Index, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                             uint BufferSize, uint* DataSize);
    HRESULT ReadProcessorSystemData(uint Processor, uint Index, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                                    uint BufferSize, uint* DataSize);
    HRESULT VirtualToPhysical(ulong Virtual, ulong* Physical);
    HRESULT GetVirtualTranslationPhysicalOffsets(ulong Virtual, ulong* Offsets, uint OffsetsSize, uint* Levels);
    HRESULT ReadHandleData(ulong Handle, uint DataType, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                           uint BufferSize, uint* DataSize);
    HRESULT FillVirtual(ulong Start, uint Size, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Pattern, 
                        uint PatternSize, uint* Filled);
    HRESULT FillPhysical(ulong Start, uint Size, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Pattern, 
                         uint PatternSize, uint* Filled);
    HRESULT QueryVirtual(ulong Offset, MEMORY_BASIC_INFORMATION64* Info);
    HRESULT ReadImageNtHeaders(ulong ImageBase, IMAGE_NT_HEADERS64* Headers);
    HRESULT ReadTagged(GUID* Tag, uint Offset, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                       uint BufferSize, uint* TotalSize);
    HRESULT StartEnumTagged(ulong* Handle);
    HRESULT GetNextTagged(ulong Handle, GUID* Tag, uint* Size);
    HRESULT EndEnumTagged(ulong Handle);
}

@GUID("d98ada1f-29e9-4ef5-a6c0-e53349883212")
interface IDebugDataSpaces4 : IUnknown
{
    HRESULT ReadVirtual(ulong Offset, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                        uint BufferSize, uint* BytesRead);
    HRESULT WriteVirtual(ulong Offset, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                         uint BufferSize, uint* BytesWritten);
    HRESULT SearchVirtual(ulong Offset, ulong Length, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Pattern, 
                          uint PatternSize, uint PatternGranularity, ulong* MatchOffset);
    HRESULT ReadVirtualUncached(ulong Offset, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                                uint BufferSize, uint* BytesRead);
    HRESULT WriteVirtualUncached(ulong Offset, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                                 uint BufferSize, uint* BytesWritten);
    HRESULT ReadPointersVirtual(uint Count, ulong Offset, ulong* Ptrs);
    HRESULT WritePointersVirtual(uint Count, ulong Offset, ulong* Ptrs);
    HRESULT ReadPhysical(ulong Offset, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                         uint BufferSize, uint* BytesRead);
    HRESULT WritePhysical(ulong Offset, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                          uint BufferSize, uint* BytesWritten);
    HRESULT ReadControl(uint Processor, ulong Offset, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                        uint BufferSize, uint* BytesRead);
    HRESULT WriteControl(uint Processor, ulong Offset, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                         uint BufferSize, uint* BytesWritten);
    HRESULT ReadIo(uint InterfaceType, uint BusNumber, uint AddressSpace, ulong Offset, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                   uint BufferSize, uint* BytesRead);
    HRESULT WriteIo(uint InterfaceType, uint BusNumber, uint AddressSpace, ulong Offset, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                    uint BufferSize, uint* BytesWritten);
    HRESULT ReadMsr(uint Msr, ulong* Value);
    HRESULT WriteMsr(uint Msr, ulong Value);
    HRESULT ReadBusData(uint BusDataType, uint BusNumber, uint SlotNumber, uint Offset, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                        uint BufferSize, uint* BytesRead);
    HRESULT WriteBusData(uint BusDataType, uint BusNumber, uint SlotNumber, uint Offset, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Buffer, 
                         uint BufferSize, uint* BytesWritten);
    HRESULT CheckLowMemory();
    HRESULT ReadDebuggerData(uint Index, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buffer, 
                             uint BufferSize, uint* DataSize);
    HRESULT ReadProcessorSystemData(uint Processor, uint Index, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                                    uint BufferSize, uint* DataSize);
    HRESULT VirtualToPhysical(ulong Virtual, ulong* Physical);
    HRESULT GetVirtualTranslationPhysicalOffsets(ulong Virtual, ulong* Offsets, uint OffsetsSize, uint* Levels);
    HRESULT ReadHandleData(ulong Handle, uint DataType, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                           uint BufferSize, uint* DataSize);
    HRESULT FillVirtual(ulong Start, uint Size, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Pattern, 
                        uint PatternSize, uint* Filled);
    HRESULT FillPhysical(ulong Start, uint Size, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Pattern, 
                         uint PatternSize, uint* Filled);
    HRESULT QueryVirtual(ulong Offset, MEMORY_BASIC_INFORMATION64* Info);
    HRESULT ReadImageNtHeaders(ulong ImageBase, IMAGE_NT_HEADERS64* Headers);
    HRESULT ReadTagged(GUID* Tag, uint Offset, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                       uint BufferSize, uint* TotalSize);
    HRESULT StartEnumTagged(ulong* Handle);
    HRESULT GetNextTagged(ulong Handle, GUID* Tag, uint* Size);
    HRESULT EndEnumTagged(ulong Handle);
    HRESULT GetOffsetInformation(uint Space, uint Which, ulong Offset, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                 uint BufferSize, uint* InfoSize);
    HRESULT GetNextDifferentlyValidOffsetVirtual(ulong Offset, ulong* NextOffset);
    HRESULT GetValidRegionVirtual(ulong Base, uint Size, ulong* ValidBase, uint* ValidSize);
    HRESULT SearchVirtual2(ulong Offset, ulong Length, uint Flags, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Pattern, 
                           uint PatternSize, uint PatternGranularity, ulong* MatchOffset);
    HRESULT ReadMultiByteStringVirtual(ulong Offset, uint MaxBytes, PSTR Buffer, uint BufferSize, 
                                       uint* StringBytes);
    HRESULT ReadMultiByteStringVirtualWide(ulong Offset, uint MaxBytes, uint CodePage, PWSTR Buffer, 
                                           uint BufferSize, uint* StringBytes);
    HRESULT ReadUnicodeStringVirtual(ulong Offset, uint MaxBytes, uint CodePage, PSTR Buffer, uint BufferSize, 
                                     uint* StringBytes);
    HRESULT ReadUnicodeStringVirtualWide(ulong Offset, uint MaxBytes, PWSTR Buffer, uint BufferSize, 
                                         uint* StringBytes);
    HRESULT ReadPhysical2(ulong Offset, uint Flags, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                          uint BufferSize, uint* BytesRead);
    HRESULT WritePhysical2(ulong Offset, uint Flags, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                           uint BufferSize, uint* BytesWritten);
}

@GUID("337be28b-5036-4d72-b6bf-c45fbb9f2eaa")
interface IDebugEventCallbacks : IUnknown
{
    HRESULT GetInterestMask(uint* Mask);
    HRESULT Breakpoint(IDebugBreakpoint Bp);
    HRESULT Exception(EXCEPTION_RECORD64* Exception, uint FirstChance);
    HRESULT CreateThread(ulong Handle, ulong DataOffset, ulong StartOffset);
    HRESULT ExitThread(uint ExitCode);
    HRESULT CreateProcessA(ulong ImageFileHandle, ulong Handle, ulong BaseOffset, uint ModuleSize, 
                           const(PSTR) ModuleName, const(PSTR) ImageName, uint CheckSum, uint TimeDateStamp, 
                           ulong InitialThreadHandle, ulong ThreadDataOffset, ulong StartOffset);
    HRESULT ExitProcess(uint ExitCode);
    HRESULT LoadModule(ulong ImageFileHandle, ulong BaseOffset, uint ModuleSize, const(PSTR) ModuleName, 
                       const(PSTR) ImageName, uint CheckSum, uint TimeDateStamp);
    HRESULT UnloadModule(const(PSTR) ImageBaseName, ulong BaseOffset);
    HRESULT SystemError(uint Error, uint Level);
    HRESULT SessionStatus(uint Status);
    HRESULT ChangeDebuggeeState(uint Flags, ulong Argument);
    HRESULT ChangeEngineState(uint Flags, ulong Argument);
    HRESULT ChangeSymbolState(uint Flags, ulong Argument);
}

@GUID("0690e046-9c23-45ac-a04f-987ac29ad0d3")
interface IDebugEventCallbacksWide : IUnknown
{
    HRESULT GetInterestMask(uint* Mask);
    HRESULT Breakpoint(IDebugBreakpoint2 Bp);
    HRESULT Exception(EXCEPTION_RECORD64* Exception, uint FirstChance);
    HRESULT CreateThread(ulong Handle, ulong DataOffset, ulong StartOffset);
    HRESULT ExitThread(uint ExitCode);
    HRESULT CreateProcessA(ulong ImageFileHandle, ulong Handle, ulong BaseOffset, uint ModuleSize, 
                           const(PWSTR) ModuleName, const(PWSTR) ImageName, uint CheckSum, uint TimeDateStamp, 
                           ulong InitialThreadHandle, ulong ThreadDataOffset, ulong StartOffset);
    HRESULT ExitProcess(uint ExitCode);
    HRESULT LoadModule(ulong ImageFileHandle, ulong BaseOffset, uint ModuleSize, const(PWSTR) ModuleName, 
                       const(PWSTR) ImageName, uint CheckSum, uint TimeDateStamp);
    HRESULT UnloadModule(const(PWSTR) ImageBaseName, ulong BaseOffset);
    HRESULT SystemError(uint Error, uint Level);
    HRESULT SessionStatus(uint Status);
    HRESULT ChangeDebuggeeState(uint Flags, ulong Argument);
    HRESULT ChangeEngineState(uint Flags, ulong Argument);
    HRESULT ChangeSymbolState(uint Flags, ulong Argument);
}

@GUID("61a4905b-23f9-4247-b3c5-53d087529ab7")
interface IDebugEventContextCallbacks : IUnknown
{
    HRESULT GetInterestMask(uint* Mask);
    HRESULT Breakpoint(IDebugBreakpoint2 Bp, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Context, 
                       uint ContextSize);
    HRESULT Exception(EXCEPTION_RECORD64* Exception, uint FirstChance, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Context, 
                      uint ContextSize);
    HRESULT CreateThread(ulong Handle, ulong DataOffset, ulong StartOffset, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Context, 
                         uint ContextSize);
    HRESULT ExitThread(uint ExitCode, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Context, 
                       uint ContextSize);
    HRESULT CreateProcessA(ulong ImageFileHandle, ulong Handle, ulong BaseOffset, uint ModuleSize, 
                           const(PWSTR) ModuleName, const(PWSTR) ImageName, uint CheckSum, uint TimeDateStamp, 
                           ulong InitialThreadHandle, ulong ThreadDataOffset, ulong StartOffset, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(12)))])*/void* Context, 
                           uint ContextSize);
    HRESULT ExitProcess(uint ExitCode, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Context, 
                        uint ContextSize);
    HRESULT LoadModule(ulong ImageFileHandle, ulong BaseOffset, uint ModuleSize, const(PWSTR) ModuleName, 
                       const(PWSTR) ImageName, uint CheckSum, uint TimeDateStamp, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(8)))])*/void* Context, 
                       uint ContextSize);
    HRESULT UnloadModule(const(PWSTR) ImageBaseName, ulong BaseOffset, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Context, 
                         uint ContextSize);
    HRESULT SystemError(uint Error, uint Level, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Context, 
                        uint ContextSize);
    HRESULT SessionStatus(uint Status);
    HRESULT ChangeDebuggeeState(uint Flags, ulong Argument, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Context, 
                                uint ContextSize);
    HRESULT ChangeEngineState(uint Flags, ulong Argument, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Context, 
                              uint ContextSize);
    HRESULT ChangeSymbolState(uint Flags, ulong Argument);
}

@GUID("9f50e42c-f136-499e-9a97-73036c94ed2d")
interface IDebugInputCallbacks : IUnknown
{
    HRESULT StartInput(uint BufferSize);
    HRESULT EndInput();
}

@GUID("4bf58045-d654-4c40-b0af-683090f356dc")
interface IDebugOutputCallbacks : IUnknown
{
    HRESULT Output(uint Mask, const(PSTR) Text);
}

@GUID("4c7fd663-c394-4e26-8ef1-34ad5ed3764c")
interface IDebugOutputCallbacksWide : IUnknown
{
    HRESULT Output(uint Mask, const(PWSTR) Text);
}

@GUID("67721fe9-56d2-4a44-a325-2b65513ce6eb")
interface IDebugOutputCallbacks2 : IUnknown
{
    HRESULT Output(uint Mask, const(PSTR) Text);
    HRESULT GetInterestMask(uint* Mask);
    HRESULT Output2(uint Which, uint Flags, ulong Arg, const(PWSTR) Text);
}

@GUID("ce289126-9e84-45a7-937e-67bb18691493")
interface IDebugRegisters : IUnknown
{
    HRESULT GetNumberRegisters(uint* Number);
    HRESULT GetDescription(uint Register, PSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                           DEBUG_REGISTER_DESCRIPTION* Desc);
    HRESULT GetIndexByName(const(PSTR) Name, uint* Index);
    HRESULT GetValue(uint Register, DEBUG_VALUE* Value);
    HRESULT SetValue(uint Register, DEBUG_VALUE* Value);
    HRESULT GetValues(uint Count, uint* Indices, uint Start, DEBUG_VALUE* Values);
    HRESULT SetValues(uint Count, uint* Indices, uint Start, DEBUG_VALUE* Values);
    HRESULT OutputRegisters(uint OutputControl, uint Flags);
    HRESULT GetInstructionOffset(ulong* Offset);
    HRESULT GetStackOffset(ulong* Offset);
    HRESULT GetFrameOffset(ulong* Offset);
}

@GUID("1656afa9-19c6-4e3a-97e7-5dc9160cf9c4")
interface IDebugRegisters2 : IUnknown
{
    HRESULT GetNumberRegisters(uint* Number);
    HRESULT GetDescription(uint Register, PSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                           DEBUG_REGISTER_DESCRIPTION* Desc);
    HRESULT GetIndexByName(const(PSTR) Name, uint* Index);
    HRESULT GetValue(uint Register, DEBUG_VALUE* Value);
    HRESULT SetValue(uint Register, DEBUG_VALUE* Value);
    HRESULT GetValues(uint Count, uint* Indices, uint Start, DEBUG_VALUE* Values);
    HRESULT SetValues(uint Count, uint* Indices, uint Start, DEBUG_VALUE* Values);
    HRESULT OutputRegisters(uint OutputControl, uint Flags);
    HRESULT GetInstructionOffset(ulong* Offset);
    HRESULT GetStackOffset(ulong* Offset);
    HRESULT GetFrameOffset(ulong* Offset);
    HRESULT GetDescriptionWide(uint Register, PWSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                               DEBUG_REGISTER_DESCRIPTION* Desc);
    HRESULT GetIndexByNameWide(const(PWSTR) Name, uint* Index);
    HRESULT GetNumberPseudoRegisters(uint* Number);
    HRESULT GetPseudoDescription(uint Register, PSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                                 ulong* TypeModule, uint* TypeId);
    HRESULT GetPseudoDescriptionWide(uint Register, PWSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                                     ulong* TypeModule, uint* TypeId);
    HRESULT GetPseudoIndexByName(const(PSTR) Name, uint* Index);
    HRESULT GetPseudoIndexByNameWide(const(PWSTR) Name, uint* Index);
    HRESULT GetPseudoValues(uint Source, uint Count, uint* Indices, uint Start, DEBUG_VALUE* Values);
    HRESULT SetPseudoValues(uint Source, uint Count, uint* Indices, uint Start, DEBUG_VALUE* Values);
    HRESULT GetValues2(uint Source, uint Count, uint* Indices, uint Start, DEBUG_VALUE* Values);
    HRESULT SetValues2(uint Source, uint Count, uint* Indices, uint Start, DEBUG_VALUE* Values);
    HRESULT OutputRegisters2(uint OutputControl, uint Source, uint Flags);
    HRESULT GetInstructionOffset2(uint Source, ulong* Offset);
    HRESULT GetStackOffset2(uint Source, ulong* Offset);
    HRESULT GetFrameOffset2(uint Source, ulong* Offset);
}

@GUID("f2528316-0f1a-4431-aeed-11d096e1e2ab")
interface IDebugSymbolGroup : IUnknown
{
    HRESULT GetNumberSymbols(uint* Number);
    HRESULT AddSymbol(const(PSTR) Name, uint* Index);
    HRESULT RemoveSymbolByName(const(PSTR) Name);
    HRESULT RemoveSymbolByIndex(uint Index);
    HRESULT GetSymbolName(uint Index, PSTR Buffer, uint BufferSize, uint* NameSize);
    HRESULT GetSymbolParameters(uint Start, uint Count, DEBUG_SYMBOL_PARAMETERS* Params);
    HRESULT ExpandSymbol(uint Index, BOOL Expand);
    HRESULT OutputSymbols(uint OutputControl, uint Flags, uint Start, uint Count);
    HRESULT WriteSymbol(uint Index, const(PSTR) Value);
    HRESULT OutputAsType(uint Index, const(PSTR) Type);
}

@GUID("6a7ccc5f-fb5e-4dcc-b41c-6c20307bccc7")
interface IDebugSymbolGroup2 : IUnknown
{
    HRESULT GetNumberSymbols(uint* Number);
    HRESULT AddSymbol(const(PSTR) Name, uint* Index);
    HRESULT RemoveSymbolByName(const(PSTR) Name);
    HRESULT RemoveSymbolByIndex(uint Index);
    HRESULT GetSymbolName(uint Index, PSTR Buffer, uint BufferSize, uint* NameSize);
    HRESULT GetSymbolParameters(uint Start, uint Count, DEBUG_SYMBOL_PARAMETERS* Params);
    HRESULT ExpandSymbol(uint Index, BOOL Expand);
    HRESULT OutputSymbols(uint OutputControl, uint Flags, uint Start, uint Count);
    HRESULT WriteSymbol(uint Index, const(PSTR) Value);
    HRESULT OutputAsType(uint Index, const(PSTR) Type);
    HRESULT AddSymbolWide(const(PWSTR) Name, uint* Index);
    HRESULT RemoveSymbolByNameWide(const(PWSTR) Name);
    HRESULT GetSymbolNameWide(uint Index, PWSTR Buffer, uint BufferSize, uint* NameSize);
    HRESULT WriteSymbolWide(uint Index, const(PWSTR) Value);
    HRESULT OutputAsTypeWide(uint Index, const(PWSTR) Type);
    HRESULT GetSymbolTypeName(uint Index, PSTR Buffer, uint BufferSize, uint* NameSize);
    HRESULT GetSymbolTypeNameWide(uint Index, PWSTR Buffer, uint BufferSize, uint* NameSize);
    HRESULT GetSymbolSize(uint Index, uint* Size);
    HRESULT GetSymbolOffset(uint Index, ulong* Offset);
    HRESULT GetSymbolRegister(uint Index, uint* Register);
    HRESULT GetSymbolValueText(uint Index, PSTR Buffer, uint BufferSize, uint* NameSize);
    HRESULT GetSymbolValueTextWide(uint Index, PWSTR Buffer, uint BufferSize, uint* NameSize);
    HRESULT GetSymbolEntryInformation(uint Index, DEBUG_SYMBOL_ENTRY* Entry);
}

@GUID("8c31e98c-983a-48a5-9016-6fe5d667a950")
interface IDebugSymbols : IUnknown
{
    HRESULT GetSymbolOptions(uint* Options);
    HRESULT AddSymbolOptions(uint Options);
    HRESULT RemoveSymbolOptions(uint Options);
    HRESULT SetSymbolOptions(uint Options);
    HRESULT GetNameByOffset(ulong Offset, PSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                            ulong* Displacement);
    HRESULT GetOffsetByName(const(PSTR) Symbol, ulong* Offset);
    HRESULT GetNearNameByOffset(ulong Offset, int Delta, PSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                                ulong* Displacement);
    HRESULT GetLineByOffset(ulong Offset, uint* Line, PSTR FileBuffer, uint FileBufferSize, uint* FileSize, 
                            ulong* Displacement);
    HRESULT GetOffsetByLine(uint Line, const(PSTR) File, ulong* Offset);
    HRESULT GetNumberModules(uint* Loaded, uint* Unloaded);
    HRESULT GetModuleByIndex(uint Index, ulong* Base);
    HRESULT GetModuleByModuleName(const(PSTR) Name, uint StartIndex, uint* Index, ulong* Base);
    HRESULT GetModuleByOffset(ulong Offset, uint StartIndex, uint* Index, ulong* Base);
    HRESULT GetModuleNames(uint Index, ulong Base, PSTR ImageNameBuffer, uint ImageNameBufferSize, 
                           uint* ImageNameSize, PSTR ModuleNameBuffer, uint ModuleNameBufferSize, 
                           uint* ModuleNameSize, PSTR LoadedImageNameBuffer, uint LoadedImageNameBufferSize, 
                           uint* LoadedImageNameSize);
    HRESULT GetModuleParameters(uint Count, ulong* Bases, uint Start, DEBUG_MODULE_PARAMETERS* Params);
    HRESULT GetSymbolModule(const(PSTR) Symbol, ulong* Base);
    HRESULT GetTypeName(ulong Module, uint TypeId, PSTR NameBuffer, uint NameBufferSize, uint* NameSize);
    HRESULT GetTypeId(ulong Module, const(PSTR) Name, uint* TypeId);
    HRESULT GetTypeSize(ulong Module, uint TypeId, uint* Size);
    HRESULT GetFieldOffset(ulong Module, uint TypeId, const(PSTR) Field, uint* Offset);
    HRESULT GetSymbolTypeId(const(PSTR) Symbol, uint* TypeId, ulong* Module);
    HRESULT GetOffsetTypeId(ulong Offset, uint* TypeId, ulong* Module);
    HRESULT ReadTypedDataVirtual(ulong Offset, ulong Module, uint TypeId, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                 uint BufferSize, uint* BytesRead);
    HRESULT WriteTypedDataVirtual(ulong Offset, ulong Module, uint TypeId, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                  uint BufferSize, uint* BytesWritten);
    HRESULT OutputTypedDataVirtual(uint OutputControl, ulong Offset, ulong Module, uint TypeId, uint Flags);
    HRESULT ReadTypedDataPhysical(ulong Offset, ulong Module, uint TypeId, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                  uint BufferSize, uint* BytesRead);
    HRESULT WriteTypedDataPhysical(ulong Offset, ulong Module, uint TypeId, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                   uint BufferSize, uint* BytesWritten);
    HRESULT OutputTypedDataPhysical(uint OutputControl, ulong Offset, ulong Module, uint TypeId, uint Flags);
    HRESULT GetScope(ulong* InstructionOffset, DEBUG_STACK_FRAME* ScopeFrame, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ScopeContext, 
                     uint ScopeContextSize);
    HRESULT SetScope(ulong InstructionOffset, DEBUG_STACK_FRAME* ScopeFrame, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ScopeContext, 
                     uint ScopeContextSize);
    HRESULT ResetScope();
    HRESULT GetScopeSymbolGroup(uint Flags, IDebugSymbolGroup Update, IDebugSymbolGroup* Symbols);
    HRESULT CreateSymbolGroup(IDebugSymbolGroup* Group);
    HRESULT StartSymbolMatch(const(PSTR) Pattern, ulong* Handle);
    HRESULT GetNextSymbolMatch(ulong Handle, PSTR Buffer, uint BufferSize, uint* MatchSize, ulong* Offset);
    HRESULT EndSymbolMatch(ulong Handle);
    HRESULT Reload(const(PSTR) Module);
    HRESULT GetSymbolPath(PSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT SetSymbolPath(const(PSTR) Path);
    HRESULT AppendSymbolPath(const(PSTR) Addition);
    HRESULT GetImagePath(PSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT SetImagePath(const(PSTR) Path);
    HRESULT AppendImagePath(const(PSTR) Addition);
    HRESULT GetSourcePath(PSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT GetSourcePathElement(uint Index, PSTR Buffer, uint BufferSize, uint* ElementSize);
    HRESULT SetSourcePath(const(PSTR) Path);
    HRESULT AppendSourcePath(const(PSTR) Addition);
    HRESULT FindSourceFile(uint StartElement, const(PSTR) File, uint Flags, uint* FoundElement, PSTR Buffer, 
                           uint BufferSize, uint* FoundSize);
    HRESULT GetSourceFileLineOffsets(const(PSTR) File, ulong* Buffer, uint BufferLines, uint* FileLines);
}

@GUID("3a707211-afdd-4495-ad4f-56fecdf8163f")
interface IDebugSymbols2 : IUnknown
{
    HRESULT GetSymbolOptions(uint* Options);
    HRESULT AddSymbolOptions(uint Options);
    HRESULT RemoveSymbolOptions(uint Options);
    HRESULT SetSymbolOptions(uint Options);
    HRESULT GetNameByOffset(ulong Offset, PSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                            ulong* Displacement);
    HRESULT GetOffsetByName(const(PSTR) Symbol, ulong* Offset);
    HRESULT GetNearNameByOffset(ulong Offset, int Delta, PSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                                ulong* Displacement);
    HRESULT GetLineByOffset(ulong Offset, uint* Line, PSTR FileBuffer, uint FileBufferSize, uint* FileSize, 
                            ulong* Displacement);
    HRESULT GetOffsetByLine(uint Line, const(PSTR) File, ulong* Offset);
    HRESULT GetNumberModules(uint* Loaded, uint* Unloaded);
    HRESULT GetModuleByIndex(uint Index, ulong* Base);
    HRESULT GetModuleByModuleName(const(PSTR) Name, uint StartIndex, uint* Index, ulong* Base);
    HRESULT GetModuleByOffset(ulong Offset, uint StartIndex, uint* Index, ulong* Base);
    HRESULT GetModuleNames(uint Index, ulong Base, PSTR ImageNameBuffer, uint ImageNameBufferSize, 
                           uint* ImageNameSize, PSTR ModuleNameBuffer, uint ModuleNameBufferSize, 
                           uint* ModuleNameSize, PSTR LoadedImageNameBuffer, uint LoadedImageNameBufferSize, 
                           uint* LoadedImageNameSize);
    HRESULT GetModuleParameters(uint Count, ulong* Bases, uint Start, DEBUG_MODULE_PARAMETERS* Params);
    HRESULT GetSymbolModule(const(PSTR) Symbol, ulong* Base);
    HRESULT GetTypeName(ulong Module, uint TypeId, PSTR NameBuffer, uint NameBufferSize, uint* NameSize);
    HRESULT GetTypeId(ulong Module, const(PSTR) Name, uint* TypeId);
    HRESULT GetTypeSize(ulong Module, uint TypeId, uint* Size);
    HRESULT GetFieldOffset(ulong Module, uint TypeId, const(PSTR) Field, uint* Offset);
    HRESULT GetSymbolTypeId(const(PSTR) Symbol, uint* TypeId, ulong* Module);
    HRESULT GetOffsetTypeId(ulong Offset, uint* TypeId, ulong* Module);
    HRESULT ReadTypedDataVirtual(ulong Offset, ulong Module, uint TypeId, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                 uint BufferSize, uint* BytesRead);
    HRESULT WriteTypedDataVirtual(ulong Offset, ulong Module, uint TypeId, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                  uint BufferSize, uint* BytesWritten);
    HRESULT OutputTypedDataVirtual(uint OutputControl, ulong Offset, ulong Module, uint TypeId, uint Flags);
    HRESULT ReadTypedDataPhysical(ulong Offset, ulong Module, uint TypeId, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                  uint BufferSize, uint* BytesRead);
    HRESULT WriteTypedDataPhysical(ulong Offset, ulong Module, uint TypeId, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                   uint BufferSize, uint* BytesWritten);
    HRESULT OutputTypedDataPhysical(uint OutputControl, ulong Offset, ulong Module, uint TypeId, uint Flags);
    HRESULT GetScope(ulong* InstructionOffset, DEBUG_STACK_FRAME* ScopeFrame, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ScopeContext, 
                     uint ScopeContextSize);
    HRESULT SetScope(ulong InstructionOffset, DEBUG_STACK_FRAME* ScopeFrame, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ScopeContext, 
                     uint ScopeContextSize);
    HRESULT ResetScope();
    HRESULT GetScopeSymbolGroup(uint Flags, IDebugSymbolGroup Update, IDebugSymbolGroup* Symbols);
    HRESULT CreateSymbolGroup(IDebugSymbolGroup* Group);
    HRESULT StartSymbolMatch(const(PSTR) Pattern, ulong* Handle);
    HRESULT GetNextSymbolMatch(ulong Handle, PSTR Buffer, uint BufferSize, uint* MatchSize, ulong* Offset);
    HRESULT EndSymbolMatch(ulong Handle);
    HRESULT Reload(const(PSTR) Module);
    HRESULT GetSymbolPath(PSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT SetSymbolPath(const(PSTR) Path);
    HRESULT AppendSymbolPath(const(PSTR) Addition);
    HRESULT GetImagePath(PSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT SetImagePath(const(PSTR) Path);
    HRESULT AppendImagePath(const(PSTR) Addition);
    HRESULT GetSourcePath(PSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT GetSourcePathElement(uint Index, PSTR Buffer, uint BufferSize, uint* ElementSize);
    HRESULT SetSourcePath(const(PSTR) Path);
    HRESULT AppendSourcePath(const(PSTR) Addition);
    HRESULT FindSourceFile(uint StartElement, const(PSTR) File, uint Flags, uint* FoundElement, PSTR Buffer, 
                           uint BufferSize, uint* FoundSize);
    HRESULT GetSourceFileLineOffsets(const(PSTR) File, ulong* Buffer, uint BufferLines, uint* FileLines);
    HRESULT GetModuleVersionInformation(uint Index, ulong Base, const(PSTR) Item, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                        uint BufferSize, uint* VerInfoSize);
    HRESULT GetModuleNameString(uint Which, uint Index, ulong Base, PSTR Buffer, uint BufferSize, uint* NameSize);
    HRESULT GetConstantName(ulong Module, uint TypeId, ulong Value, PSTR NameBuffer, uint NameBufferSize, 
                            uint* NameSize);
    HRESULT GetFieldName(ulong Module, uint TypeId, uint FieldIndex, PSTR NameBuffer, uint NameBufferSize, 
                         uint* NameSize);
    HRESULT GetTypeOptions(uint* Options);
    HRESULT AddTypeOptions(uint Options);
    HRESULT RemoveTypeOptions(uint Options);
    HRESULT SetTypeOptions(uint Options);
}

@GUID("f02fbecc-50ac-4f36-9ad9-c975e8f32ff8")
interface IDebugSymbols3 : IUnknown
{
    HRESULT GetSymbolOptions(uint* Options);
    HRESULT AddSymbolOptions(uint Options);
    HRESULT RemoveSymbolOptions(uint Options);
    HRESULT SetSymbolOptions(uint Options);
    HRESULT GetNameByOffset(ulong Offset, PSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                            ulong* Displacement);
    HRESULT GetOffsetByName(const(PSTR) Symbol, ulong* Offset);
    HRESULT GetNearNameByOffset(ulong Offset, int Delta, PSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                                ulong* Displacement);
    HRESULT GetLineByOffset(ulong Offset, uint* Line, PSTR FileBuffer, uint FileBufferSize, uint* FileSize, 
                            ulong* Displacement);
    HRESULT GetOffsetByLine(uint Line, const(PSTR) File, ulong* Offset);
    HRESULT GetNumberModules(uint* Loaded, uint* Unloaded);
    HRESULT GetModuleByIndex(uint Index, ulong* Base);
    HRESULT GetModuleByModuleName(const(PSTR) Name, uint StartIndex, uint* Index, ulong* Base);
    HRESULT GetModuleByOffset(ulong Offset, uint StartIndex, uint* Index, ulong* Base);
    HRESULT GetModuleNames(uint Index, ulong Base, PSTR ImageNameBuffer, uint ImageNameBufferSize, 
                           uint* ImageNameSize, PSTR ModuleNameBuffer, uint ModuleNameBufferSize, 
                           uint* ModuleNameSize, PSTR LoadedImageNameBuffer, uint LoadedImageNameBufferSize, 
                           uint* LoadedImageNameSize);
    HRESULT GetModuleParameters(uint Count, ulong* Bases, uint Start, DEBUG_MODULE_PARAMETERS* Params);
    HRESULT GetSymbolModule(const(PSTR) Symbol, ulong* Base);
    HRESULT GetTypeName(ulong Module, uint TypeId, PSTR NameBuffer, uint NameBufferSize, uint* NameSize);
    HRESULT GetTypeId(ulong Module, const(PSTR) Name, uint* TypeId);
    HRESULT GetTypeSize(ulong Module, uint TypeId, uint* Size);
    HRESULT GetFieldOffset(ulong Module, uint TypeId, const(PSTR) Field, uint* Offset);
    HRESULT GetSymbolTypeId(const(PSTR) Symbol, uint* TypeId, ulong* Module);
    HRESULT GetOffsetTypeId(ulong Offset, uint* TypeId, ulong* Module);
    HRESULT ReadTypedDataVirtual(ulong Offset, ulong Module, uint TypeId, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                 uint BufferSize, uint* BytesRead);
    HRESULT WriteTypedDataVirtual(ulong Offset, ulong Module, uint TypeId, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                  uint BufferSize, uint* BytesWritten);
    HRESULT OutputTypedDataVirtual(uint OutputControl, ulong Offset, ulong Module, uint TypeId, uint Flags);
    HRESULT ReadTypedDataPhysical(ulong Offset, ulong Module, uint TypeId, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                  uint BufferSize, uint* BytesRead);
    HRESULT WriteTypedDataPhysical(ulong Offset, ulong Module, uint TypeId, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                   uint BufferSize, uint* BytesWritten);
    HRESULT OutputTypedDataPhysical(uint OutputControl, ulong Offset, ulong Module, uint TypeId, uint Flags);
    HRESULT GetScope(ulong* InstructionOffset, DEBUG_STACK_FRAME* ScopeFrame, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ScopeContext, 
                     uint ScopeContextSize);
    HRESULT SetScope(ulong InstructionOffset, DEBUG_STACK_FRAME* ScopeFrame, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ScopeContext, 
                     uint ScopeContextSize);
    HRESULT ResetScope();
    HRESULT GetScopeSymbolGroup(uint Flags, IDebugSymbolGroup Update, IDebugSymbolGroup* Symbols);
    HRESULT CreateSymbolGroup(IDebugSymbolGroup* Group);
    HRESULT StartSymbolMatch(const(PSTR) Pattern, ulong* Handle);
    HRESULT GetNextSymbolMatch(ulong Handle, PSTR Buffer, uint BufferSize, uint* MatchSize, ulong* Offset);
    HRESULT EndSymbolMatch(ulong Handle);
    HRESULT Reload(const(PSTR) Module);
    HRESULT GetSymbolPath(PSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT SetSymbolPath(const(PSTR) Path);
    HRESULT AppendSymbolPath(const(PSTR) Addition);
    HRESULT GetImagePath(PSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT SetImagePath(const(PSTR) Path);
    HRESULT AppendImagePath(const(PSTR) Addition);
    HRESULT GetSourcePath(PSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT GetSourcePathElement(uint Index, PSTR Buffer, uint BufferSize, uint* ElementSize);
    HRESULT SetSourcePath(const(PSTR) Path);
    HRESULT AppendSourcePath(const(PSTR) Addition);
    HRESULT FindSourceFile(uint StartElement, const(PSTR) File, uint Flags, uint* FoundElement, PSTR Buffer, 
                           uint BufferSize, uint* FoundSize);
    HRESULT GetSourceFileLineOffsets(const(PSTR) File, ulong* Buffer, uint BufferLines, uint* FileLines);
    HRESULT GetModuleVersionInformation(uint Index, ulong Base, const(PSTR) Item, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                        uint BufferSize, uint* VerInfoSize);
    HRESULT GetModuleNameString(uint Which, uint Index, ulong Base, PSTR Buffer, uint BufferSize, uint* NameSize);
    HRESULT GetConstantName(ulong Module, uint TypeId, ulong Value, PSTR NameBuffer, uint NameBufferSize, 
                            uint* NameSize);
    HRESULT GetFieldName(ulong Module, uint TypeId, uint FieldIndex, PSTR NameBuffer, uint NameBufferSize, 
                         uint* NameSize);
    HRESULT GetTypeOptions(uint* Options);
    HRESULT AddTypeOptions(uint Options);
    HRESULT RemoveTypeOptions(uint Options);
    HRESULT SetTypeOptions(uint Options);
    HRESULT GetNameByOffsetWide(ulong Offset, PWSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                                ulong* Displacement);
    HRESULT GetOffsetByNameWide(const(PWSTR) Symbol, ulong* Offset);
    HRESULT GetNearNameByOffsetWide(ulong Offset, int Delta, PWSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                                    ulong* Displacement);
    HRESULT GetLineByOffsetWide(ulong Offset, uint* Line, PWSTR FileBuffer, uint FileBufferSize, uint* FileSize, 
                                ulong* Displacement);
    HRESULT GetOffsetByLineWide(uint Line, const(PWSTR) File, ulong* Offset);
    HRESULT GetModuleByModuleNameWide(const(PWSTR) Name, uint StartIndex, uint* Index, ulong* Base);
    HRESULT GetSymbolModuleWide(const(PWSTR) Symbol, ulong* Base);
    HRESULT GetTypeNameWide(ulong Module, uint TypeId, PWSTR NameBuffer, uint NameBufferSize, uint* NameSize);
    HRESULT GetTypeIdWide(ulong Module, const(PWSTR) Name, uint* TypeId);
    HRESULT GetFieldOffsetWide(ulong Module, uint TypeId, const(PWSTR) Field, uint* Offset);
    HRESULT GetSymbolTypeIdWide(const(PWSTR) Symbol, uint* TypeId, ulong* Module);
    HRESULT GetScopeSymbolGroup2(uint Flags, IDebugSymbolGroup2 Update, IDebugSymbolGroup2* Symbols);
    HRESULT CreateSymbolGroup2(IDebugSymbolGroup2* Group);
    HRESULT StartSymbolMatchWide(const(PWSTR) Pattern, ulong* Handle);
    HRESULT GetNextSymbolMatchWide(ulong Handle, PWSTR Buffer, uint BufferSize, uint* MatchSize, ulong* Offset);
    HRESULT ReloadWide(const(PWSTR) Module);
    HRESULT GetSymbolPathWide(PWSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT SetSymbolPathWide(const(PWSTR) Path);
    HRESULT AppendSymbolPathWide(const(PWSTR) Addition);
    HRESULT GetImagePathWide(PWSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT SetImagePathWide(const(PWSTR) Path);
    HRESULT AppendImagePathWide(const(PWSTR) Addition);
    HRESULT GetSourcePathWide(PWSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT GetSourcePathElementWide(uint Index, PWSTR Buffer, uint BufferSize, uint* ElementSize);
    HRESULT SetSourcePathWide(const(PWSTR) Path);
    HRESULT AppendSourcePathWide(const(PWSTR) Addition);
    HRESULT FindSourceFileWide(uint StartElement, const(PWSTR) File, uint Flags, uint* FoundElement, PWSTR Buffer, 
                               uint BufferSize, uint* FoundSize);
    HRESULT GetSourceFileLineOffsetsWide(const(PWSTR) File, ulong* Buffer, uint BufferLines, uint* FileLines);
    HRESULT GetModuleVersionInformationWide(uint Index, ulong Base, const(PWSTR) Item, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                            uint BufferSize, uint* VerInfoSize);
    HRESULT GetModuleNameStringWide(uint Which, uint Index, ulong Base, PWSTR Buffer, uint BufferSize, 
                                    uint* NameSize);
    HRESULT GetConstantNameWide(ulong Module, uint TypeId, ulong Value, PWSTR NameBuffer, uint NameBufferSize, 
                                uint* NameSize);
    HRESULT GetFieldNameWide(ulong Module, uint TypeId, uint FieldIndex, PWSTR NameBuffer, uint NameBufferSize, 
                             uint* NameSize);
    HRESULT IsManagedModule(uint Index, ulong Base);
    HRESULT GetModuleByModuleName2(const(PSTR) Name, uint StartIndex, uint Flags, uint* Index, ulong* Base);
    HRESULT GetModuleByModuleName2Wide(const(PWSTR) Name, uint StartIndex, uint Flags, uint* Index, ulong* Base);
    HRESULT GetModuleByOffset2(ulong Offset, uint StartIndex, uint Flags, uint* Index, ulong* Base);
    HRESULT AddSyntheticModule(ulong Base, uint Size, const(PSTR) ImagePath, const(PSTR) ModuleName, uint Flags);
    HRESULT AddSyntheticModuleWide(ulong Base, uint Size, const(PWSTR) ImagePath, const(PWSTR) ModuleName, 
                                   uint Flags);
    HRESULT RemoveSyntheticModule(ulong Base);
    HRESULT GetCurrentScopeFrameIndex(uint* Index);
    HRESULT SetScopeFrameByIndex(uint Index);
    HRESULT SetScopeFromJitDebugInfo(uint OutputControl, ulong InfoOffset);
    HRESULT SetScopeFromStoredEvent();
    HRESULT OutputSymbolByOffset(uint OutputControl, uint Flags, ulong Offset);
    HRESULT GetFunctionEntryByOffset(ulong Offset, uint Flags, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                                     uint BufferSize, uint* BufferNeeded);
    HRESULT GetFieldTypeAndOffset(ulong Module, uint ContainerTypeId, const(PSTR) Field, uint* FieldTypeId, 
                                  uint* Offset);
    HRESULT GetFieldTypeAndOffsetWide(ulong Module, uint ContainerTypeId, const(PWSTR) Field, uint* FieldTypeId, 
                                      uint* Offset);
    HRESULT AddSyntheticSymbol(ulong Offset, uint Size, const(PSTR) Name, uint Flags, DEBUG_MODULE_AND_ID* Id);
    HRESULT AddSyntheticSymbolWide(ulong Offset, uint Size, const(PWSTR) Name, uint Flags, DEBUG_MODULE_AND_ID* Id);
    HRESULT RemoveSyntheticSymbol(DEBUG_MODULE_AND_ID* Id);
    HRESULT GetSymbolEntriesByOffset(ulong Offset, uint Flags, DEBUG_MODULE_AND_ID* Ids, ulong* Displacements, 
                                     uint IdsCount, uint* Entries);
    HRESULT GetSymbolEntriesByName(const(PSTR) Symbol, uint Flags, DEBUG_MODULE_AND_ID* Ids, uint IdsCount, 
                                   uint* Entries);
    HRESULT GetSymbolEntriesByNameWide(const(PWSTR) Symbol, uint Flags, DEBUG_MODULE_AND_ID* Ids, uint IdsCount, 
                                       uint* Entries);
    HRESULT GetSymbolEntryByToken(ulong ModuleBase, uint Token, DEBUG_MODULE_AND_ID* Id);
    HRESULT GetSymbolEntryInformation(DEBUG_MODULE_AND_ID* Id, DEBUG_SYMBOL_ENTRY* Info);
    HRESULT GetSymbolEntryString(DEBUG_MODULE_AND_ID* Id, uint Which, PSTR Buffer, uint BufferSize, 
                                 uint* StringSize);
    HRESULT GetSymbolEntryStringWide(DEBUG_MODULE_AND_ID* Id, uint Which, PWSTR Buffer, uint BufferSize, 
                                     uint* StringSize);
    HRESULT GetSymbolEntryOffsetRegions(DEBUG_MODULE_AND_ID* Id, uint Flags, DEBUG_OFFSET_REGION* Regions, 
                                        uint RegionsCount, uint* RegionsAvail);
    HRESULT GetSymbolEntryBySymbolEntry(DEBUG_MODULE_AND_ID* FromId, uint Flags, DEBUG_MODULE_AND_ID* ToId);
    HRESULT GetSourceEntriesByOffset(ulong Offset, uint Flags, DEBUG_SYMBOL_SOURCE_ENTRY* Entries, 
                                     uint EntriesCount, uint* EntriesAvail);
    HRESULT GetSourceEntriesByLine(uint Line, const(PSTR) File, uint Flags, DEBUG_SYMBOL_SOURCE_ENTRY* Entries, 
                                   uint EntriesCount, uint* EntriesAvail);
    HRESULT GetSourceEntriesByLineWide(uint Line, const(PWSTR) File, uint Flags, 
                                       DEBUG_SYMBOL_SOURCE_ENTRY* Entries, uint EntriesCount, uint* EntriesAvail);
    HRESULT GetSourceEntryString(DEBUG_SYMBOL_SOURCE_ENTRY* Entry, uint Which, PSTR Buffer, uint BufferSize, 
                                 uint* StringSize);
    HRESULT GetSourceEntryStringWide(DEBUG_SYMBOL_SOURCE_ENTRY* Entry, uint Which, PWSTR Buffer, uint BufferSize, 
                                     uint* StringSize);
    HRESULT GetSourceEntryOffsetRegions(DEBUG_SYMBOL_SOURCE_ENTRY* Entry, uint Flags, DEBUG_OFFSET_REGION* Regions, 
                                        uint RegionsCount, uint* RegionsAvail);
    HRESULT GetSourceEntryBySourceEntry(DEBUG_SYMBOL_SOURCE_ENTRY* FromEntry, uint Flags, 
                                        DEBUG_SYMBOL_SOURCE_ENTRY* ToEntry);
}

@GUID("e391bbd8-9d8c-4418-840b-c006592a1752")
interface IDebugSymbols4 : IUnknown
{
    HRESULT GetSymbolOptions(uint* Options);
    HRESULT AddSymbolOptions(uint Options);
    HRESULT RemoveSymbolOptions(uint Options);
    HRESULT SetSymbolOptions(uint Options);
    HRESULT GetNameByOffset(ulong Offset, PSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                            ulong* Displacement);
    HRESULT GetOffsetByName(const(PSTR) Symbol, ulong* Offset);
    HRESULT GetNearNameByOffset(ulong Offset, int Delta, PSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                                ulong* Displacement);
    HRESULT GetLineByOffset(ulong Offset, uint* Line, PSTR FileBuffer, uint FileBufferSize, uint* FileSize, 
                            ulong* Displacement);
    HRESULT GetOffsetByLine(uint Line, const(PSTR) File, ulong* Offset);
    HRESULT GetNumberModules(uint* Loaded, uint* Unloaded);
    HRESULT GetModuleByIndex(uint Index, ulong* Base);
    HRESULT GetModuleByModuleName(const(PSTR) Name, uint StartIndex, uint* Index, ulong* Base);
    HRESULT GetModuleByOffset(ulong Offset, uint StartIndex, uint* Index, ulong* Base);
    HRESULT GetModuleNames(uint Index, ulong Base, PSTR ImageNameBuffer, uint ImageNameBufferSize, 
                           uint* ImageNameSize, PSTR ModuleNameBuffer, uint ModuleNameBufferSize, 
                           uint* ModuleNameSize, PSTR LoadedImageNameBuffer, uint LoadedImageNameBufferSize, 
                           uint* LoadedImageNameSize);
    HRESULT GetModuleParameters(uint Count, ulong* Bases, uint Start, DEBUG_MODULE_PARAMETERS* Params);
    HRESULT GetSymbolModule(const(PSTR) Symbol, ulong* Base);
    HRESULT GetTypeName(ulong Module, uint TypeId, PSTR NameBuffer, uint NameBufferSize, uint* NameSize);
    HRESULT GetTypeId(ulong Module, const(PSTR) Name, uint* TypeId);
    HRESULT GetTypeSize(ulong Module, uint TypeId, uint* Size);
    HRESULT GetFieldOffset(ulong Module, uint TypeId, const(PSTR) Field, uint* Offset);
    HRESULT GetSymbolTypeId(const(PSTR) Symbol, uint* TypeId, ulong* Module);
    HRESULT GetOffsetTypeId(ulong Offset, uint* TypeId, ulong* Module);
    HRESULT ReadTypedDataVirtual(ulong Offset, ulong Module, uint TypeId, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                 uint BufferSize, uint* BytesRead);
    HRESULT WriteTypedDataVirtual(ulong Offset, ulong Module, uint TypeId, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                  uint BufferSize, uint* BytesWritten);
    HRESULT OutputTypedDataVirtual(uint OutputControl, ulong Offset, ulong Module, uint TypeId, uint Flags);
    HRESULT ReadTypedDataPhysical(ulong Offset, ulong Module, uint TypeId, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                  uint BufferSize, uint* BytesRead);
    HRESULT WriteTypedDataPhysical(ulong Offset, ulong Module, uint TypeId, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                   uint BufferSize, uint* BytesWritten);
    HRESULT OutputTypedDataPhysical(uint OutputControl, ulong Offset, ulong Module, uint TypeId, uint Flags);
    HRESULT GetScope(ulong* InstructionOffset, DEBUG_STACK_FRAME* ScopeFrame, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ScopeContext, 
                     uint ScopeContextSize);
    HRESULT SetScope(ulong InstructionOffset, DEBUG_STACK_FRAME* ScopeFrame, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ScopeContext, 
                     uint ScopeContextSize);
    HRESULT ResetScope();
    HRESULT GetScopeSymbolGroup(uint Flags, IDebugSymbolGroup Update, IDebugSymbolGroup* Symbols);
    HRESULT CreateSymbolGroup(IDebugSymbolGroup* Group);
    HRESULT StartSymbolMatch(const(PSTR) Pattern, ulong* Handle);
    HRESULT GetNextSymbolMatch(ulong Handle, PSTR Buffer, uint BufferSize, uint* MatchSize, ulong* Offset);
    HRESULT EndSymbolMatch(ulong Handle);
    HRESULT Reload(const(PSTR) Module);
    HRESULT GetSymbolPath(PSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT SetSymbolPath(const(PSTR) Path);
    HRESULT AppendSymbolPath(const(PSTR) Addition);
    HRESULT GetImagePath(PSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT SetImagePath(const(PSTR) Path);
    HRESULT AppendImagePath(const(PSTR) Addition);
    HRESULT GetSourcePath(PSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT GetSourcePathElement(uint Index, PSTR Buffer, uint BufferSize, uint* ElementSize);
    HRESULT SetSourcePath(const(PSTR) Path);
    HRESULT AppendSourcePath(const(PSTR) Addition);
    HRESULT FindSourceFile(uint StartElement, const(PSTR) File, uint Flags, uint* FoundElement, PSTR Buffer, 
                           uint BufferSize, uint* FoundSize);
    HRESULT GetSourceFileLineOffsets(const(PSTR) File, ulong* Buffer, uint BufferLines, uint* FileLines);
    HRESULT GetModuleVersionInformation(uint Index, ulong Base, const(PSTR) Item, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                        uint BufferSize, uint* VerInfoSize);
    HRESULT GetModuleNameString(uint Which, uint Index, ulong Base, PSTR Buffer, uint BufferSize, uint* NameSize);
    HRESULT GetConstantName(ulong Module, uint TypeId, ulong Value, PSTR NameBuffer, uint NameBufferSize, 
                            uint* NameSize);
    HRESULT GetFieldName(ulong Module, uint TypeId, uint FieldIndex, PSTR NameBuffer, uint NameBufferSize, 
                         uint* NameSize);
    HRESULT GetTypeOptions(uint* Options);
    HRESULT AddTypeOptions(uint Options);
    HRESULT RemoveTypeOptions(uint Options);
    HRESULT SetTypeOptions(uint Options);
    HRESULT GetNameByOffsetWide(ulong Offset, PWSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                                ulong* Displacement);
    HRESULT GetOffsetByNameWide(const(PWSTR) Symbol, ulong* Offset);
    HRESULT GetNearNameByOffsetWide(ulong Offset, int Delta, PWSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                                    ulong* Displacement);
    HRESULT GetLineByOffsetWide(ulong Offset, uint* Line, PWSTR FileBuffer, uint FileBufferSize, uint* FileSize, 
                                ulong* Displacement);
    HRESULT GetOffsetByLineWide(uint Line, const(PWSTR) File, ulong* Offset);
    HRESULT GetModuleByModuleNameWide(const(PWSTR) Name, uint StartIndex, uint* Index, ulong* Base);
    HRESULT GetSymbolModuleWide(const(PWSTR) Symbol, ulong* Base);
    HRESULT GetTypeNameWide(ulong Module, uint TypeId, PWSTR NameBuffer, uint NameBufferSize, uint* NameSize);
    HRESULT GetTypeIdWide(ulong Module, const(PWSTR) Name, uint* TypeId);
    HRESULT GetFieldOffsetWide(ulong Module, uint TypeId, const(PWSTR) Field, uint* Offset);
    HRESULT GetSymbolTypeIdWide(const(PWSTR) Symbol, uint* TypeId, ulong* Module);
    HRESULT GetScopeSymbolGroup2(uint Flags, IDebugSymbolGroup2 Update, IDebugSymbolGroup2* Symbols);
    HRESULT CreateSymbolGroup2(IDebugSymbolGroup2* Group);
    HRESULT StartSymbolMatchWide(const(PWSTR) Pattern, ulong* Handle);
    HRESULT GetNextSymbolMatchWide(ulong Handle, PWSTR Buffer, uint BufferSize, uint* MatchSize, ulong* Offset);
    HRESULT ReloadWide(const(PWSTR) Module);
    HRESULT GetSymbolPathWide(PWSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT SetSymbolPathWide(const(PWSTR) Path);
    HRESULT AppendSymbolPathWide(const(PWSTR) Addition);
    HRESULT GetImagePathWide(PWSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT SetImagePathWide(const(PWSTR) Path);
    HRESULT AppendImagePathWide(const(PWSTR) Addition);
    HRESULT GetSourcePathWide(PWSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT GetSourcePathElementWide(uint Index, PWSTR Buffer, uint BufferSize, uint* ElementSize);
    HRESULT SetSourcePathWide(const(PWSTR) Path);
    HRESULT AppendSourcePathWide(const(PWSTR) Addition);
    HRESULT FindSourceFileWide(uint StartElement, const(PWSTR) File, uint Flags, uint* FoundElement, PWSTR Buffer, 
                               uint BufferSize, uint* FoundSize);
    HRESULT GetSourceFileLineOffsetsWide(const(PWSTR) File, ulong* Buffer, uint BufferLines, uint* FileLines);
    HRESULT GetModuleVersionInformationWide(uint Index, ulong Base, const(PWSTR) Item, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                            uint BufferSize, uint* VerInfoSize);
    HRESULT GetModuleNameStringWide(uint Which, uint Index, ulong Base, PWSTR Buffer, uint BufferSize, 
                                    uint* NameSize);
    HRESULT GetConstantNameWide(ulong Module, uint TypeId, ulong Value, PWSTR NameBuffer, uint NameBufferSize, 
                                uint* NameSize);
    HRESULT GetFieldNameWide(ulong Module, uint TypeId, uint FieldIndex, PWSTR NameBuffer, uint NameBufferSize, 
                             uint* NameSize);
    HRESULT IsManagedModule(uint Index, ulong Base);
    HRESULT GetModuleByModuleName2(const(PSTR) Name, uint StartIndex, uint Flags, uint* Index, ulong* Base);
    HRESULT GetModuleByModuleName2Wide(const(PWSTR) Name, uint StartIndex, uint Flags, uint* Index, ulong* Base);
    HRESULT GetModuleByOffset2(ulong Offset, uint StartIndex, uint Flags, uint* Index, ulong* Base);
    HRESULT AddSyntheticModule(ulong Base, uint Size, const(PSTR) ImagePath, const(PSTR) ModuleName, uint Flags);
    HRESULT AddSyntheticModuleWide(ulong Base, uint Size, const(PWSTR) ImagePath, const(PWSTR) ModuleName, 
                                   uint Flags);
    HRESULT RemoveSyntheticModule(ulong Base);
    HRESULT GetCurrentScopeFrameIndex(uint* Index);
    HRESULT SetScopeFrameByIndex(uint Index);
    HRESULT SetScopeFromJitDebugInfo(uint OutputControl, ulong InfoOffset);
    HRESULT SetScopeFromStoredEvent();
    HRESULT OutputSymbolByOffset(uint OutputControl, uint Flags, ulong Offset);
    HRESULT GetFunctionEntryByOffset(ulong Offset, uint Flags, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                                     uint BufferSize, uint* BufferNeeded);
    HRESULT GetFieldTypeAndOffset(ulong Module, uint ContainerTypeId, const(PSTR) Field, uint* FieldTypeId, 
                                  uint* Offset);
    HRESULT GetFieldTypeAndOffsetWide(ulong Module, uint ContainerTypeId, const(PWSTR) Field, uint* FieldTypeId, 
                                      uint* Offset);
    HRESULT AddSyntheticSymbol(ulong Offset, uint Size, const(PSTR) Name, uint Flags, DEBUG_MODULE_AND_ID* Id);
    HRESULT AddSyntheticSymbolWide(ulong Offset, uint Size, const(PWSTR) Name, uint Flags, DEBUG_MODULE_AND_ID* Id);
    HRESULT RemoveSyntheticSymbol(DEBUG_MODULE_AND_ID* Id);
    HRESULT GetSymbolEntriesByOffset(ulong Offset, uint Flags, DEBUG_MODULE_AND_ID* Ids, ulong* Displacements, 
                                     uint IdsCount, uint* Entries);
    HRESULT GetSymbolEntriesByName(const(PSTR) Symbol, uint Flags, DEBUG_MODULE_AND_ID* Ids, uint IdsCount, 
                                   uint* Entries);
    HRESULT GetSymbolEntriesByNameWide(const(PWSTR) Symbol, uint Flags, DEBUG_MODULE_AND_ID* Ids, uint IdsCount, 
                                       uint* Entries);
    HRESULT GetSymbolEntryByToken(ulong ModuleBase, uint Token, DEBUG_MODULE_AND_ID* Id);
    HRESULT GetSymbolEntryInformation(DEBUG_MODULE_AND_ID* Id, DEBUG_SYMBOL_ENTRY* Info);
    HRESULT GetSymbolEntryString(DEBUG_MODULE_AND_ID* Id, uint Which, PSTR Buffer, uint BufferSize, 
                                 uint* StringSize);
    HRESULT GetSymbolEntryStringWide(DEBUG_MODULE_AND_ID* Id, uint Which, PWSTR Buffer, uint BufferSize, 
                                     uint* StringSize);
    HRESULT GetSymbolEntryOffsetRegions(DEBUG_MODULE_AND_ID* Id, uint Flags, DEBUG_OFFSET_REGION* Regions, 
                                        uint RegionsCount, uint* RegionsAvail);
    HRESULT GetSymbolEntryBySymbolEntry(DEBUG_MODULE_AND_ID* FromId, uint Flags, DEBUG_MODULE_AND_ID* ToId);
    HRESULT GetSourceEntriesByOffset(ulong Offset, uint Flags, DEBUG_SYMBOL_SOURCE_ENTRY* Entries, 
                                     uint EntriesCount, uint* EntriesAvail);
    HRESULT GetSourceEntriesByLine(uint Line, const(PSTR) File, uint Flags, DEBUG_SYMBOL_SOURCE_ENTRY* Entries, 
                                   uint EntriesCount, uint* EntriesAvail);
    HRESULT GetSourceEntriesByLineWide(uint Line, const(PWSTR) File, uint Flags, 
                                       DEBUG_SYMBOL_SOURCE_ENTRY* Entries, uint EntriesCount, uint* EntriesAvail);
    HRESULT GetSourceEntryString(DEBUG_SYMBOL_SOURCE_ENTRY* Entry, uint Which, PSTR Buffer, uint BufferSize, 
                                 uint* StringSize);
    HRESULT GetSourceEntryStringWide(DEBUG_SYMBOL_SOURCE_ENTRY* Entry, uint Which, PWSTR Buffer, uint BufferSize, 
                                     uint* StringSize);
    HRESULT GetSourceEntryOffsetRegions(DEBUG_SYMBOL_SOURCE_ENTRY* Entry, uint Flags, DEBUG_OFFSET_REGION* Regions, 
                                        uint RegionsCount, uint* RegionsAvail);
    HRESULT GetSourceEntryBySourceEntry(DEBUG_SYMBOL_SOURCE_ENTRY* FromEntry, uint Flags, 
                                        DEBUG_SYMBOL_SOURCE_ENTRY* ToEntry);
    HRESULT GetScopeEx(ulong* InstructionOffset, DEBUG_STACK_FRAME_EX* ScopeFrame, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ScopeContext, 
                       uint ScopeContextSize);
    HRESULT SetScopeEx(ulong InstructionOffset, DEBUG_STACK_FRAME_EX* ScopeFrame, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ScopeContext, 
                       uint ScopeContextSize);
    HRESULT GetNameByInlineContext(ulong Offset, uint InlineContext, PSTR NameBuffer, uint NameBufferSize, 
                                   uint* NameSize, ulong* Displacement);
    HRESULT GetNameByInlineContextWide(ulong Offset, uint InlineContext, PWSTR NameBuffer, uint NameBufferSize, 
                                       uint* NameSize, ulong* Displacement);
    HRESULT GetLineByInlineContext(ulong Offset, uint InlineContext, uint* Line, PSTR FileBuffer, 
                                   uint FileBufferSize, uint* FileSize, ulong* Displacement);
    HRESULT GetLineByInlineContextWide(ulong Offset, uint InlineContext, uint* Line, PWSTR FileBuffer, 
                                       uint FileBufferSize, uint* FileSize, ulong* Displacement);
    HRESULT OutputSymbolByInlineContext(uint OutputControl, uint Flags, ulong Offset, uint InlineContext);
}

@GUID("c65fa83e-1e69-475e-8e0e-b5d79e9cc17e")
interface IDebugSymbols5 : IUnknown
{
    HRESULT GetSymbolOptions(uint* Options);
    HRESULT AddSymbolOptions(uint Options);
    HRESULT RemoveSymbolOptions(uint Options);
    HRESULT SetSymbolOptions(uint Options);
    HRESULT GetNameByOffset(ulong Offset, PSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                            ulong* Displacement);
    HRESULT GetOffsetByName(const(PSTR) Symbol, ulong* Offset);
    HRESULT GetNearNameByOffset(ulong Offset, int Delta, PSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                                ulong* Displacement);
    HRESULT GetLineByOffset(ulong Offset, uint* Line, PSTR FileBuffer, uint FileBufferSize, uint* FileSize, 
                            ulong* Displacement);
    HRESULT GetOffsetByLine(uint Line, const(PSTR) File, ulong* Offset);
    HRESULT GetNumberModules(uint* Loaded, uint* Unloaded);
    HRESULT GetModuleByIndex(uint Index, ulong* Base);
    HRESULT GetModuleByModuleName(const(PSTR) Name, uint StartIndex, uint* Index, ulong* Base);
    HRESULT GetModuleByOffset(ulong Offset, uint StartIndex, uint* Index, ulong* Base);
    HRESULT GetModuleNames(uint Index, ulong Base, PSTR ImageNameBuffer, uint ImageNameBufferSize, 
                           uint* ImageNameSize, PSTR ModuleNameBuffer, uint ModuleNameBufferSize, 
                           uint* ModuleNameSize, PSTR LoadedImageNameBuffer, uint LoadedImageNameBufferSize, 
                           uint* LoadedImageNameSize);
    HRESULT GetModuleParameters(uint Count, ulong* Bases, uint Start, DEBUG_MODULE_PARAMETERS* Params);
    HRESULT GetSymbolModule(const(PSTR) Symbol, ulong* Base);
    HRESULT GetTypeName(ulong Module, uint TypeId, PSTR NameBuffer, uint NameBufferSize, uint* NameSize);
    HRESULT GetTypeId(ulong Module, const(PSTR) Name, uint* TypeId);
    HRESULT GetTypeSize(ulong Module, uint TypeId, uint* Size);
    HRESULT GetFieldOffset(ulong Module, uint TypeId, const(PSTR) Field, uint* Offset);
    HRESULT GetSymbolTypeId(const(PSTR) Symbol, uint* TypeId, ulong* Module);
    HRESULT GetOffsetTypeId(ulong Offset, uint* TypeId, ulong* Module);
    HRESULT ReadTypedDataVirtual(ulong Offset, ulong Module, uint TypeId, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                 uint BufferSize, uint* BytesRead);
    HRESULT WriteTypedDataVirtual(ulong Offset, ulong Module, uint TypeId, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                  uint BufferSize, uint* BytesWritten);
    HRESULT OutputTypedDataVirtual(uint OutputControl, ulong Offset, ulong Module, uint TypeId, uint Flags);
    HRESULT ReadTypedDataPhysical(ulong Offset, ulong Module, uint TypeId, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                  uint BufferSize, uint* BytesRead);
    HRESULT WriteTypedDataPhysical(ulong Offset, ulong Module, uint TypeId, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                   uint BufferSize, uint* BytesWritten);
    HRESULT OutputTypedDataPhysical(uint OutputControl, ulong Offset, ulong Module, uint TypeId, uint Flags);
    HRESULT GetScope(ulong* InstructionOffset, DEBUG_STACK_FRAME* ScopeFrame, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ScopeContext, 
                     uint ScopeContextSize);
    HRESULT SetScope(ulong InstructionOffset, DEBUG_STACK_FRAME* ScopeFrame, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ScopeContext, 
                     uint ScopeContextSize);
    HRESULT ResetScope();
    HRESULT GetScopeSymbolGroup(uint Flags, IDebugSymbolGroup Update, IDebugSymbolGroup* Symbols);
    HRESULT CreateSymbolGroup(IDebugSymbolGroup* Group);
    HRESULT StartSymbolMatch(const(PSTR) Pattern, ulong* Handle);
    HRESULT GetNextSymbolMatch(ulong Handle, PSTR Buffer, uint BufferSize, uint* MatchSize, ulong* Offset);
    HRESULT EndSymbolMatch(ulong Handle);
    HRESULT Reload(const(PSTR) Module);
    HRESULT GetSymbolPath(PSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT SetSymbolPath(const(PSTR) Path);
    HRESULT AppendSymbolPath(const(PSTR) Addition);
    HRESULT GetImagePath(PSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT SetImagePath(const(PSTR) Path);
    HRESULT AppendImagePath(const(PSTR) Addition);
    HRESULT GetSourcePath(PSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT GetSourcePathElement(uint Index, PSTR Buffer, uint BufferSize, uint* ElementSize);
    HRESULT SetSourcePath(const(PSTR) Path);
    HRESULT AppendSourcePath(const(PSTR) Addition);
    HRESULT FindSourceFile(uint StartElement, const(PSTR) File, uint Flags, uint* FoundElement, PSTR Buffer, 
                           uint BufferSize, uint* FoundSize);
    HRESULT GetSourceFileLineOffsets(const(PSTR) File, ulong* Buffer, uint BufferLines, uint* FileLines);
    HRESULT GetModuleVersionInformation(uint Index, ulong Base, const(PSTR) Item, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                        uint BufferSize, uint* VerInfoSize);
    HRESULT GetModuleNameString(uint Which, uint Index, ulong Base, PSTR Buffer, uint BufferSize, uint* NameSize);
    HRESULT GetConstantName(ulong Module, uint TypeId, ulong Value, PSTR NameBuffer, uint NameBufferSize, 
                            uint* NameSize);
    HRESULT GetFieldName(ulong Module, uint TypeId, uint FieldIndex, PSTR NameBuffer, uint NameBufferSize, 
                         uint* NameSize);
    HRESULT GetTypeOptions(uint* Options);
    HRESULT AddTypeOptions(uint Options);
    HRESULT RemoveTypeOptions(uint Options);
    HRESULT SetTypeOptions(uint Options);
    HRESULT GetNameByOffsetWide(ulong Offset, PWSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                                ulong* Displacement);
    HRESULT GetOffsetByNameWide(const(PWSTR) Symbol, ulong* Offset);
    HRESULT GetNearNameByOffsetWide(ulong Offset, int Delta, PWSTR NameBuffer, uint NameBufferSize, uint* NameSize, 
                                    ulong* Displacement);
    HRESULT GetLineByOffsetWide(ulong Offset, uint* Line, PWSTR FileBuffer, uint FileBufferSize, uint* FileSize, 
                                ulong* Displacement);
    HRESULT GetOffsetByLineWide(uint Line, const(PWSTR) File, ulong* Offset);
    HRESULT GetModuleByModuleNameWide(const(PWSTR) Name, uint StartIndex, uint* Index, ulong* Base);
    HRESULT GetSymbolModuleWide(const(PWSTR) Symbol, ulong* Base);
    HRESULT GetTypeNameWide(ulong Module, uint TypeId, PWSTR NameBuffer, uint NameBufferSize, uint* NameSize);
    HRESULT GetTypeIdWide(ulong Module, const(PWSTR) Name, uint* TypeId);
    HRESULT GetFieldOffsetWide(ulong Module, uint TypeId, const(PWSTR) Field, uint* Offset);
    HRESULT GetSymbolTypeIdWide(const(PWSTR) Symbol, uint* TypeId, ulong* Module);
    HRESULT GetScopeSymbolGroup2(uint Flags, IDebugSymbolGroup2 Update, IDebugSymbolGroup2* Symbols);
    HRESULT CreateSymbolGroup2(IDebugSymbolGroup2* Group);
    HRESULT StartSymbolMatchWide(const(PWSTR) Pattern, ulong* Handle);
    HRESULT GetNextSymbolMatchWide(ulong Handle, PWSTR Buffer, uint BufferSize, uint* MatchSize, ulong* Offset);
    HRESULT ReloadWide(const(PWSTR) Module);
    HRESULT GetSymbolPathWide(PWSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT SetSymbolPathWide(const(PWSTR) Path);
    HRESULT AppendSymbolPathWide(const(PWSTR) Addition);
    HRESULT GetImagePathWide(PWSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT SetImagePathWide(const(PWSTR) Path);
    HRESULT AppendImagePathWide(const(PWSTR) Addition);
    HRESULT GetSourcePathWide(PWSTR Buffer, uint BufferSize, uint* PathSize);
    HRESULT GetSourcePathElementWide(uint Index, PWSTR Buffer, uint BufferSize, uint* ElementSize);
    HRESULT SetSourcePathWide(const(PWSTR) Path);
    HRESULT AppendSourcePathWide(const(PWSTR) Addition);
    HRESULT FindSourceFileWide(uint StartElement, const(PWSTR) File, uint Flags, uint* FoundElement, PWSTR Buffer, 
                               uint BufferSize, uint* FoundSize);
    HRESULT GetSourceFileLineOffsetsWide(const(PWSTR) File, ulong* Buffer, uint BufferLines, uint* FileLines);
    HRESULT GetModuleVersionInformationWide(uint Index, ulong Base, const(PWSTR) Item, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                            uint BufferSize, uint* VerInfoSize);
    HRESULT GetModuleNameStringWide(uint Which, uint Index, ulong Base, PWSTR Buffer, uint BufferSize, 
                                    uint* NameSize);
    HRESULT GetConstantNameWide(ulong Module, uint TypeId, ulong Value, PWSTR NameBuffer, uint NameBufferSize, 
                                uint* NameSize);
    HRESULT GetFieldNameWide(ulong Module, uint TypeId, uint FieldIndex, PWSTR NameBuffer, uint NameBufferSize, 
                             uint* NameSize);
    HRESULT IsManagedModule(uint Index, ulong Base);
    HRESULT GetModuleByModuleName2(const(PSTR) Name, uint StartIndex, uint Flags, uint* Index, ulong* Base);
    HRESULT GetModuleByModuleName2Wide(const(PWSTR) Name, uint StartIndex, uint Flags, uint* Index, ulong* Base);
    HRESULT GetModuleByOffset2(ulong Offset, uint StartIndex, uint Flags, uint* Index, ulong* Base);
    HRESULT AddSyntheticModule(ulong Base, uint Size, const(PSTR) ImagePath, const(PSTR) ModuleName, uint Flags);
    HRESULT AddSyntheticModuleWide(ulong Base, uint Size, const(PWSTR) ImagePath, const(PWSTR) ModuleName, 
                                   uint Flags);
    HRESULT RemoveSyntheticModule(ulong Base);
    HRESULT GetCurrentScopeFrameIndex(uint* Index);
    HRESULT SetScopeFrameByIndex(uint Index);
    HRESULT SetScopeFromJitDebugInfo(uint OutputControl, ulong InfoOffset);
    HRESULT SetScopeFromStoredEvent();
    HRESULT OutputSymbolByOffset(uint OutputControl, uint Flags, ulong Offset);
    HRESULT GetFunctionEntryByOffset(ulong Offset, uint Flags, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                                     uint BufferSize, uint* BufferNeeded);
    HRESULT GetFieldTypeAndOffset(ulong Module, uint ContainerTypeId, const(PSTR) Field, uint* FieldTypeId, 
                                  uint* Offset);
    HRESULT GetFieldTypeAndOffsetWide(ulong Module, uint ContainerTypeId, const(PWSTR) Field, uint* FieldTypeId, 
                                      uint* Offset);
    HRESULT AddSyntheticSymbol(ulong Offset, uint Size, const(PSTR) Name, uint Flags, DEBUG_MODULE_AND_ID* Id);
    HRESULT AddSyntheticSymbolWide(ulong Offset, uint Size, const(PWSTR) Name, uint Flags, DEBUG_MODULE_AND_ID* Id);
    HRESULT RemoveSyntheticSymbol(DEBUG_MODULE_AND_ID* Id);
    HRESULT GetSymbolEntriesByOffset(ulong Offset, uint Flags, DEBUG_MODULE_AND_ID* Ids, ulong* Displacements, 
                                     uint IdsCount, uint* Entries);
    HRESULT GetSymbolEntriesByName(const(PSTR) Symbol, uint Flags, DEBUG_MODULE_AND_ID* Ids, uint IdsCount, 
                                   uint* Entries);
    HRESULT GetSymbolEntriesByNameWide(const(PWSTR) Symbol, uint Flags, DEBUG_MODULE_AND_ID* Ids, uint IdsCount, 
                                       uint* Entries);
    HRESULT GetSymbolEntryByToken(ulong ModuleBase, uint Token, DEBUG_MODULE_AND_ID* Id);
    HRESULT GetSymbolEntryInformation(DEBUG_MODULE_AND_ID* Id, DEBUG_SYMBOL_ENTRY* Info);
    HRESULT GetSymbolEntryString(DEBUG_MODULE_AND_ID* Id, uint Which, PSTR Buffer, uint BufferSize, 
                                 uint* StringSize);
    HRESULT GetSymbolEntryStringWide(DEBUG_MODULE_AND_ID* Id, uint Which, PWSTR Buffer, uint BufferSize, 
                                     uint* StringSize);
    HRESULT GetSymbolEntryOffsetRegions(DEBUG_MODULE_AND_ID* Id, uint Flags, DEBUG_OFFSET_REGION* Regions, 
                                        uint RegionsCount, uint* RegionsAvail);
    HRESULT GetSymbolEntryBySymbolEntry(DEBUG_MODULE_AND_ID* FromId, uint Flags, DEBUG_MODULE_AND_ID* ToId);
    HRESULT GetSourceEntriesByOffset(ulong Offset, uint Flags, DEBUG_SYMBOL_SOURCE_ENTRY* Entries, 
                                     uint EntriesCount, uint* EntriesAvail);
    HRESULT GetSourceEntriesByLine(uint Line, const(PSTR) File, uint Flags, DEBUG_SYMBOL_SOURCE_ENTRY* Entries, 
                                   uint EntriesCount, uint* EntriesAvail);
    HRESULT GetSourceEntriesByLineWide(uint Line, const(PWSTR) File, uint Flags, 
                                       DEBUG_SYMBOL_SOURCE_ENTRY* Entries, uint EntriesCount, uint* EntriesAvail);
    HRESULT GetSourceEntryString(DEBUG_SYMBOL_SOURCE_ENTRY* Entry, uint Which, PSTR Buffer, uint BufferSize, 
                                 uint* StringSize);
    HRESULT GetSourceEntryStringWide(DEBUG_SYMBOL_SOURCE_ENTRY* Entry, uint Which, PWSTR Buffer, uint BufferSize, 
                                     uint* StringSize);
    HRESULT GetSourceEntryOffsetRegions(DEBUG_SYMBOL_SOURCE_ENTRY* Entry, uint Flags, DEBUG_OFFSET_REGION* Regions, 
                                        uint RegionsCount, uint* RegionsAvail);
    HRESULT GetSourceEntryBySourceEntry(DEBUG_SYMBOL_SOURCE_ENTRY* FromEntry, uint Flags, 
                                        DEBUG_SYMBOL_SOURCE_ENTRY* ToEntry);
    HRESULT GetScopeEx(ulong* InstructionOffset, DEBUG_STACK_FRAME_EX* ScopeFrame, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ScopeContext, 
                       uint ScopeContextSize);
    HRESULT SetScopeEx(ulong InstructionOffset, DEBUG_STACK_FRAME_EX* ScopeFrame, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ScopeContext, 
                       uint ScopeContextSize);
    HRESULT GetNameByInlineContext(ulong Offset, uint InlineContext, PSTR NameBuffer, uint NameBufferSize, 
                                   uint* NameSize, ulong* Displacement);
    HRESULT GetNameByInlineContextWide(ulong Offset, uint InlineContext, PWSTR NameBuffer, uint NameBufferSize, 
                                       uint* NameSize, ulong* Displacement);
    HRESULT GetLineByInlineContext(ulong Offset, uint InlineContext, uint* Line, PSTR FileBuffer, 
                                   uint FileBufferSize, uint* FileSize, ulong* Displacement);
    HRESULT GetLineByInlineContextWide(ulong Offset, uint InlineContext, uint* Line, PWSTR FileBuffer, 
                                       uint FileBufferSize, uint* FileSize, ulong* Displacement);
    HRESULT OutputSymbolByInlineContext(uint OutputControl, uint Flags, ulong Offset, uint InlineContext);
    HRESULT GetCurrentScopeFrameIndexEx(uint Flags, uint* Index);
    HRESULT SetScopeFrameByIndexEx(uint Flags, uint Index);
}

@GUID("6b86fe2c-2c4f-4f0c-9da2-174311acc327")
interface IDebugSystemObjects : IUnknown
{
    HRESULT GetEventThread(uint* Id);
    HRESULT GetEventProcess(uint* Id);
    HRESULT GetCurrentThreadId(uint* Id);
    HRESULT SetCurrentThreadId(uint Id);
    HRESULT GetCurrentProcessId(uint* Id);
    HRESULT SetCurrentProcessId(uint Id);
    HRESULT GetNumberThreads(uint* Number);
    HRESULT GetTotalNumberThreads(uint* Total, uint* LargestProcess);
    HRESULT GetThreadIdsByIndex(uint Start, uint Count, uint* Ids, uint* SysIds);
    HRESULT GetThreadIdByProcessor(uint Processor, uint* Id);
    HRESULT GetCurrentThreadDataOffset(ulong* Offset);
    HRESULT GetThreadIdByDataOffset(ulong Offset, uint* Id);
    HRESULT GetCurrentThreadTeb(ulong* Offset);
    HRESULT GetThreadIdByTeb(ulong Offset, uint* Id);
    HRESULT GetCurrentThreadSystemId(uint* SysId);
    HRESULT GetThreadIdBySystemId(uint SysId, uint* Id);
    HRESULT GetCurrentThreadHandle(ulong* Handle);
    HRESULT GetThreadIdByHandle(ulong Handle, uint* Id);
    HRESULT GetNumberProcesses(uint* Number);
    HRESULT GetProcessIdsByIndex(uint Start, uint Count, uint* Ids, uint* SysIds);
    HRESULT GetCurrentProcessDataOffset(ulong* Offset);
    HRESULT GetProcessIdByDataOffset(ulong Offset, uint* Id);
    HRESULT GetCurrentProcessPeb(ulong* Offset);
    HRESULT GetProcessIdByPeb(ulong Offset, uint* Id);
    HRESULT GetCurrentProcessSystemId(uint* SysId);
    HRESULT GetProcessIdBySystemId(uint SysId, uint* Id);
    HRESULT GetCurrentProcessHandle(ulong* Handle);
    HRESULT GetProcessIdByHandle(ulong Handle, uint* Id);
    HRESULT GetCurrentProcessExecutableName(PSTR Buffer, uint BufferSize, uint* ExeSize);
}

@GUID("0ae9f5ff-1852-4679-b055-494bee6407ee")
interface IDebugSystemObjects2 : IUnknown
{
    HRESULT GetEventThread(uint* Id);
    HRESULT GetEventProcess(uint* Id);
    HRESULT GetCurrentThreadId(uint* Id);
    HRESULT SetCurrentThreadId(uint Id);
    HRESULT GetCurrentProcessId(uint* Id);
    HRESULT SetCurrentProcessId(uint Id);
    HRESULT GetNumberThreads(uint* Number);
    HRESULT GetTotalNumberThreads(uint* Total, uint* LargestProcess);
    HRESULT GetThreadIdsByIndex(uint Start, uint Count, uint* Ids, uint* SysIds);
    HRESULT GetThreadIdByProcessor(uint Processor, uint* Id);
    HRESULT GetCurrentThreadDataOffset(ulong* Offset);
    HRESULT GetThreadIdByDataOffset(ulong Offset, uint* Id);
    HRESULT GetCurrentThreadTeb(ulong* Offset);
    HRESULT GetThreadIdByTeb(ulong Offset, uint* Id);
    HRESULT GetCurrentThreadSystemId(uint* SysId);
    HRESULT GetThreadIdBySystemId(uint SysId, uint* Id);
    HRESULT GetCurrentThreadHandle(ulong* Handle);
    HRESULT GetThreadIdByHandle(ulong Handle, uint* Id);
    HRESULT GetNumberProcesses(uint* Number);
    HRESULT GetProcessIdsByIndex(uint Start, uint Count, uint* Ids, uint* SysIds);
    HRESULT GetCurrentProcessDataOffset(ulong* Offset);
    HRESULT GetProcessIdByDataOffset(ulong Offset, uint* Id);
    HRESULT GetCurrentProcessPeb(ulong* Offset);
    HRESULT GetProcessIdByPeb(ulong Offset, uint* Id);
    HRESULT GetCurrentProcessSystemId(uint* SysId);
    HRESULT GetProcessIdBySystemId(uint SysId, uint* Id);
    HRESULT GetCurrentProcessHandle(ulong* Handle);
    HRESULT GetProcessIdByHandle(ulong Handle, uint* Id);
    HRESULT GetCurrentProcessExecutableName(PSTR Buffer, uint BufferSize, uint* ExeSize);
    HRESULT GetCurrentProcessUpTime(uint* UpTime);
    HRESULT GetImplicitThreadDataOffset(ulong* Offset);
    HRESULT SetImplicitThreadDataOffset(ulong Offset);
    HRESULT GetImplicitProcessDataOffset(ulong* Offset);
    HRESULT SetImplicitProcessDataOffset(ulong Offset);
}

@GUID("e9676e2f-e286-4ea3-b0f9-dfe5d9fc330e")
interface IDebugSystemObjects3 : IUnknown
{
    HRESULT GetEventThread(uint* Id);
    HRESULT GetEventProcess(uint* Id);
    HRESULT GetCurrentThreadId(uint* Id);
    HRESULT SetCurrentThreadId(uint Id);
    HRESULT GetCurrentProcessId(uint* Id);
    HRESULT SetCurrentProcessId(uint Id);
    HRESULT GetNumberThreads(uint* Number);
    HRESULT GetTotalNumberThreads(uint* Total, uint* LargestProcess);
    HRESULT GetThreadIdsByIndex(uint Start, uint Count, uint* Ids, uint* SysIds);
    HRESULT GetThreadIdByProcessor(uint Processor, uint* Id);
    HRESULT GetCurrentThreadDataOffset(ulong* Offset);
    HRESULT GetThreadIdByDataOffset(ulong Offset, uint* Id);
    HRESULT GetCurrentThreadTeb(ulong* Offset);
    HRESULT GetThreadIdByTeb(ulong Offset, uint* Id);
    HRESULT GetCurrentThreadSystemId(uint* SysId);
    HRESULT GetThreadIdBySystemId(uint SysId, uint* Id);
    HRESULT GetCurrentThreadHandle(ulong* Handle);
    HRESULT GetThreadIdByHandle(ulong Handle, uint* Id);
    HRESULT GetNumberProcesses(uint* Number);
    HRESULT GetProcessIdsByIndex(uint Start, uint Count, uint* Ids, uint* SysIds);
    HRESULT GetCurrentProcessDataOffset(ulong* Offset);
    HRESULT GetProcessIdByDataOffset(ulong Offset, uint* Id);
    HRESULT GetCurrentProcessPeb(ulong* Offset);
    HRESULT GetProcessIdByPeb(ulong Offset, uint* Id);
    HRESULT GetCurrentProcessSystemId(uint* SysId);
    HRESULT GetProcessIdBySystemId(uint SysId, uint* Id);
    HRESULT GetCurrentProcessHandle(ulong* Handle);
    HRESULT GetProcessIdByHandle(ulong Handle, uint* Id);
    HRESULT GetCurrentProcessExecutableName(PSTR Buffer, uint BufferSize, uint* ExeSize);
    HRESULT GetCurrentProcessUpTime(uint* UpTime);
    HRESULT GetImplicitThreadDataOffset(ulong* Offset);
    HRESULT SetImplicitThreadDataOffset(ulong Offset);
    HRESULT GetImplicitProcessDataOffset(ulong* Offset);
    HRESULT SetImplicitProcessDataOffset(ulong Offset);
    HRESULT GetEventSystem(uint* Id);
    HRESULT GetCurrentSystemId(uint* Id);
    HRESULT SetCurrentSystemId(uint Id);
    HRESULT GetNumberSystems(uint* Number);
    HRESULT GetSystemIdsByIndex(uint Start, uint Count, uint* Ids);
    HRESULT GetTotalNumberThreadsAndProcesses(uint* TotalThreads, uint* TotalProcesses, 
                                              uint* LargestProcessThreads, uint* LargestSystemThreads, 
                                              uint* LargestSystemProcesses);
    HRESULT GetCurrentSystemServer(ulong* Server);
    HRESULT GetSystemByServer(ulong Server, uint* Id);
    HRESULT GetCurrentSystemServerName(PSTR Buffer, uint BufferSize, uint* NameSize);
}

@GUID("489468e6-7d0f-4af5-87ab-25207454d553")
interface IDebugSystemObjects4 : IUnknown
{
    HRESULT GetEventThread(uint* Id);
    HRESULT GetEventProcess(uint* Id);
    HRESULT GetCurrentThreadId(uint* Id);
    HRESULT SetCurrentThreadId(uint Id);
    HRESULT GetCurrentProcessId(uint* Id);
    HRESULT SetCurrentProcessId(uint Id);
    HRESULT GetNumberThreads(uint* Number);
    HRESULT GetTotalNumberThreads(uint* Total, uint* LargestProcess);
    HRESULT GetThreadIdsByIndex(uint Start, uint Count, uint* Ids, uint* SysIds);
    HRESULT GetThreadIdByProcessor(uint Processor, uint* Id);
    HRESULT GetCurrentThreadDataOffset(ulong* Offset);
    HRESULT GetThreadIdByDataOffset(ulong Offset, uint* Id);
    HRESULT GetCurrentThreadTeb(ulong* Offset);
    HRESULT GetThreadIdByTeb(ulong Offset, uint* Id);
    HRESULT GetCurrentThreadSystemId(uint* SysId);
    HRESULT GetThreadIdBySystemId(uint SysId, uint* Id);
    HRESULT GetCurrentThreadHandle(ulong* Handle);
    HRESULT GetThreadIdByHandle(ulong Handle, uint* Id);
    HRESULT GetNumberProcesses(uint* Number);
    HRESULT GetProcessIdsByIndex(uint Start, uint Count, uint* Ids, uint* SysIds);
    HRESULT GetCurrentProcessDataOffset(ulong* Offset);
    HRESULT GetProcessIdByDataOffset(ulong Offset, uint* Id);
    HRESULT GetCurrentProcessPeb(ulong* Offset);
    HRESULT GetProcessIdByPeb(ulong Offset, uint* Id);
    HRESULT GetCurrentProcessSystemId(uint* SysId);
    HRESULT GetProcessIdBySystemId(uint SysId, uint* Id);
    HRESULT GetCurrentProcessHandle(ulong* Handle);
    HRESULT GetProcessIdByHandle(ulong Handle, uint* Id);
    HRESULT GetCurrentProcessExecutableName(PSTR Buffer, uint BufferSize, uint* ExeSize);
    HRESULT GetCurrentProcessUpTime(uint* UpTime);
    HRESULT GetImplicitThreadDataOffset(ulong* Offset);
    HRESULT SetImplicitThreadDataOffset(ulong Offset);
    HRESULT GetImplicitProcessDataOffset(ulong* Offset);
    HRESULT SetImplicitProcessDataOffset(ulong Offset);
    HRESULT GetEventSystem(uint* Id);
    HRESULT GetCurrentSystemId(uint* Id);
    HRESULT SetCurrentSystemId(uint Id);
    HRESULT GetNumberSystems(uint* Number);
    HRESULT GetSystemIdsByIndex(uint Start, uint Count, uint* Ids);
    HRESULT GetTotalNumberThreadsAndProcesses(uint* TotalThreads, uint* TotalProcesses, 
                                              uint* LargestProcessThreads, uint* LargestSystemThreads, 
                                              uint* LargestSystemProcesses);
    HRESULT GetCurrentSystemServer(ulong* Server);
    HRESULT GetSystemByServer(ulong Server, uint* Id);
    HRESULT GetCurrentSystemServerName(PSTR Buffer, uint BufferSize, uint* NameSize);
    HRESULT GetCurrentProcessExecutableNameWide(PWSTR Buffer, uint BufferSize, uint* ExeSize);
    HRESULT GetCurrentSystemServerNameWide(PWSTR Buffer, uint BufferSize, uint* NameSize);
}

interface DebugBaseEventCallbacks : IDebugEventCallbacks
{
}

interface DebugBaseEventCallbacksWide : IDebugEventCallbacksWide
{
}

@GUID("f2bce54e-4835-4f8a-836e-7981e29904d1")
interface IHostDataModelAccess : IUnknown
{
    HRESULT GetDataModel(IDataModelManager* manager, IDebugHost* host);
}

@GUID("0fc7557d-401d-4fca-9365-da1e9850697c")
interface IKeyStore : IUnknown
{
    HRESULT GetKey(const(PWSTR) key, IModelObject* object, IKeyStore* metadata);
    HRESULT SetKey(const(PWSTR) key, IModelObject object, IKeyStore metadata);
    HRESULT GetKeyValue(const(PWSTR) key, IModelObject* object, IKeyStore* metadata);
    HRESULT SetKeyValue(const(PWSTR) key, IModelObject object);
    HRESULT ClearKeys();
}

@GUID("e28c7893-3f4b-4b96-baca-293cdc55f45d")
interface IModelObject : IUnknown
{
    HRESULT GetContext(IDebugHostContext* context);
    HRESULT GetKind(ModelObjectKind* kind);
    HRESULT GetIntrinsicValue(VARIANT* intrinsicData);
    HRESULT GetIntrinsicValueAs(VARENUM vt, VARIANT* intrinsicData);
    HRESULT GetKeyValue(const(PWSTR) key, IModelObject* object, IKeyStore* metadata);
    HRESULT SetKeyValue(const(PWSTR) key, IModelObject object);
    HRESULT EnumerateKeyValues(IKeyEnumerator* enumerator);
    HRESULT GetRawValue(SymbolKind kind, const(PWSTR) name, uint searchFlags, IModelObject* object);
    HRESULT EnumerateRawValues(SymbolKind kind, uint searchFlags, IRawEnumerator* enumerator);
    HRESULT Dereference(IModelObject* object);
    HRESULT TryCastToRuntimeType(IModelObject* runtimeTypedObject);
    HRESULT GetConcept(const(GUID)* conceptId, IUnknown* conceptInterface, IKeyStore* conceptMetadata);
    HRESULT GetLocation(Location* location);
    HRESULT GetTypeInfo(IDebugHostType* type);
    HRESULT GetTargetInfo(Location* location, IDebugHostType* type);
    HRESULT GetNumberOfParentModels(ulong* numModels);
    HRESULT GetParentModel(ulong i, IModelObject* model, IModelObject* contextObject);
    HRESULT AddParentModel(IModelObject model, IModelObject contextObject, ubyte override_);
    HRESULT RemoveParentModel(IModelObject model);
    HRESULT GetKey(const(PWSTR) key, IModelObject* object, IKeyStore* metadata);
    HRESULT GetKeyReference(const(PWSTR) key, IModelObject* objectReference, IKeyStore* metadata);
    HRESULT SetKey(const(PWSTR) key, IModelObject object, IKeyStore metadata);
    HRESULT ClearKeys();
    HRESULT EnumerateKeys(IKeyEnumerator* enumerator);
    HRESULT EnumerateKeyReferences(IKeyEnumerator* enumerator);
    HRESULT SetConcept(const(GUID)* conceptId, IUnknown conceptInterface, IKeyStore conceptMetadata);
    HRESULT ClearConcepts();
    HRESULT GetRawReference(SymbolKind kind, const(PWSTR) name, uint searchFlags, IModelObject* object);
    HRESULT EnumerateRawReferences(SymbolKind kind, uint searchFlags, IRawEnumerator* enumerator);
    HRESULT SetContextForDataModel(IModelObject dataModelObject, IUnknown context);
    HRESULT GetContextForDataModel(IModelObject dataModelObject, IUnknown* context);
    HRESULT Compare(IModelObject other, IModelObject* ppResult);
    HRESULT IsEqualTo(IModelObject other, bool* equal);
}

@GUID("d61e19f4-ab3d-4344-9f7b-0993f3d58745")
interface IModelObject2 : IModelObject
{
    HRESULT EnumerateOwnKeyValues(IKeyEnumerator* ppEnumerator);
    HRESULT EnumerateOwnKeys(IKeyEnumerator* ppEnumerator);
    HRESULT EnumerateOwnKeyReferences(IKeyEnumerator* ppEnumerator);
}

@GUID("73fe19f4-a110-4500-8ed9-3c28896f508c")
interface IDataModelManager : IUnknown
{
    HRESULT Close();
    HRESULT CreateNoValue(IModelObject* object);
    HRESULT CreateErrorObject(HRESULT hrError, const(PWSTR) pwszMessage, IModelObject* object);
    HRESULT CreateTypedObject(IDebugHostContext context, Location objectLocation, IDebugHostType objectType, 
                              IModelObject* object);
    HRESULT CreateTypedObjectReference(IDebugHostContext context, Location objectLocation, 
                                       IDebugHostType objectType, IModelObject* object);
    HRESULT CreateSyntheticObject(IDebugHostContext context, IModelObject* object);
    HRESULT CreateDataModelObject(IDataModelConcept dataModel, IModelObject* object);
    HRESULT CreateIntrinsicObject(ModelObjectKind objectKind, VARIANT* intrinsicData, IModelObject* object);
    HRESULT CreateTypedIntrinsicObject(VARIANT* intrinsicData, IDebugHostType type, IModelObject* object);
    HRESULT GetModelForTypeSignature(IDebugHostTypeSignature typeSignature, IModelObject* dataModel);
    HRESULT GetModelForType(IDebugHostType type, IModelObject* dataModel, IDebugHostTypeSignature* typeSignature, 
                            IDebugHostSymbolEnumerator* wildcardMatches);
    HRESULT RegisterModelForTypeSignature(IDebugHostTypeSignature typeSignature, IModelObject dataModel);
    HRESULT UnregisterModelForTypeSignature(IModelObject dataModel, IDebugHostTypeSignature typeSignature);
    HRESULT RegisterExtensionForTypeSignature(IDebugHostTypeSignature typeSignature, IModelObject dataModel);
    HRESULT UnregisterExtensionForTypeSignature(IModelObject dataModel, IDebugHostTypeSignature typeSignature);
    HRESULT CreateMetadataStore(IKeyStore parentStore, IKeyStore* metadataStore);
    HRESULT GetRootNamespace(IModelObject* rootNamespace);
    HRESULT RegisterNamedModel(const(PWSTR) modelName, IModelObject modeObject);
    HRESULT UnregisterNamedModel(const(PWSTR) modelName);
    HRESULT AcquireNamedModel(const(PWSTR) modelName, IModelObject* modelObject);
}

@GUID("f412c5ea-2284-4622-a660-a697160d3312")
interface IDataModelManager2 : IDataModelManager
{
    HRESULT AcquireSubNamespace(const(PWSTR) modelName, const(PWSTR) subNamespaceModelName, 
                                const(PWSTR) accessName, IKeyStore metadata, IModelObject* namespaceModelObject);
    HRESULT CreateTypedIntrinsicObjectEx(IDebugHostContext context, VARIANT* intrinsicData, IDebugHostType type, 
                                         IModelObject* object);
}

@GUID("8642daf8-6ef5-4753-b53f-d83a5cee8100")
interface IDataModelManager3 : IDataModelManager2
{
    HRESULT AcquireFilteredSubNamespace(const(PWSTR) modelName, const(PWSTR) subNamespaceModelName, 
                                        const(PWSTR) accessName, IKeyStore metadata, IModelMethod filter, 
                                        IModelObject* namespaceModelObject, IFilteredNamespacePropertyToken* token);
    HRESULT EnumerateNamedModels(INamedModelsEnumerator* ppEnumerator);
}

@GUID("8898ad97-3a2e-421c-953f-035e15426b7c")
interface IDataModelManager4 : IDataModelManager3
{
    HRESULT CreateSyntheticObjectFromKeyStore(IDebugHostContext context, IKeyStore parentStore, 
                                              IModelObject* object);
}

@GUID("5253dcf8-5aff-4c62-b302-56a289e00998")
interface IModelKeyReference : IUnknown
{
    HRESULT GetKeyName(BSTR* keyName);
    HRESULT GetOriginalObject(IModelObject* originalObject);
    HRESULT GetContextObject(IModelObject* containingObject);
    HRESULT GetKey(IModelObject* object, IKeyStore* metadata);
    HRESULT GetKeyValue(IModelObject* object, IKeyStore* metadata);
    HRESULT SetKey(IModelObject object, IKeyStore metadata);
    HRESULT SetKeyValue(IModelObject object);
}

@GUID("5a0c63d9-0526-42b8-960c-9516a3254c85")
interface IModelPropertyAccessor : IUnknown
{
    HRESULT GetValue(const(PWSTR) key, IModelObject contextObject, IModelObject* value);
    HRESULT SetValue(const(PWSTR) key, IModelObject contextObject, IModelObject value);
}

@GUID("80600c1f-b90b-4896-82ad-1c00207909e8")
interface IModelMethod : IUnknown
{
    HRESULT Call(IModelObject pContextObject, ulong argCount, IModelObject* ppArguments, IModelObject* ppResult, 
                 IKeyStore* ppMetadata);
}

@GUID("345fa92e-5e00-4319-9cae-971f7601cdcf")
interface IKeyEnumerator : IUnknown
{
    HRESULT Reset();
    HRESULT GetNext(BSTR* key, IModelObject* value, IKeyStore* metadata);
}

@GUID("e13613f9-3a3c-40b5-8f48-1e5ebfb9b21b")
interface IRawEnumerator : IUnknown
{
    HRESULT Reset();
    HRESULT GetNext(BSTR* name, SymbolKind* kind, IModelObject* value);
}

@GUID("47bbfc0b-0b20-4e0c-882b-465d6ccac97c")
interface INamedModelsEnumerator : IUnknown
{
    HRESULT Reset();
    HRESULT GetNext(BSTR* pModelName, IModelObject* ppModel);
}

@GUID("fcb98d1d-1114-4fbf-b24c-effcb5def0d3")
interface IDataModelConcept : IUnknown
{
    HRESULT InitializeObject(IModelObject modelObject, IDebugHostTypeSignature matchingTypeSignature, 
                             IDebugHostSymbolEnumerator wildcardMatches);
    HRESULT GetName(BSTR* modelName);
}

@GUID("d28e8d70-6c00-4205-940d-501016601ea3")
interface IStringDisplayableConcept : IUnknown
{
    HRESULT ToDisplayString(IModelObject contextObject, IKeyStore metadata, BSTR* displayString);
}

@GUID("c7371568-5c78-4a00-a4ab-6ef8823184cb")
interface ICodeAddressConcept : IUnknown
{
    HRESULT GetContainingSymbol(IModelObject pContextObject, IDebugHostSymbol* ppSymbol);
}

@GUID("e4622136-927d-4490-874f-581f3e4e3688")
interface IModelIterator : IUnknown
{
    HRESULT Reset();
    HRESULT GetNext(IModelObject* object, ulong dimensions, IModelObject* indexers, IKeyStore* metadata);
}

@GUID("a4952c59-7144-4c76-873b-6046c0955ffc")
interface IObjectWrapperConcept : IUnknown
{
    HRESULT GetWrappedObject(IModelObject pContextObject, IModelObject* wrappedObject, 
                             WrappedObjectPreference* pUsagePreference);
}

@GUID("f5d49d0c-0b02-4301-9c9b-b3a6037628f3")
interface IIterableConcept : IUnknown
{
    HRESULT GetDefaultIndexDimensionality(IModelObject contextObject, ulong* dimensionality);
    HRESULT GetIterator(IModelObject contextObject, IModelIterator* iterator);
}

@GUID("d1fad99f-3f53-4457-850c-8051df2d3fb5")
interface IIndexableConcept : IUnknown
{
    HRESULT GetDimensionality(IModelObject contextObject, ulong* dimensionality);
    HRESULT GetAt(IModelObject contextObject, ulong indexerCount, IModelObject* indexers, IModelObject* object, 
                  IKeyStore* metadata);
    HRESULT SetAt(IModelObject contextObject, ulong indexerCount, IModelObject* indexers, IModelObject value);
}

@GUID("9d6c1d7b-a76f-4618-8068-5f76bd9a4e8a")
interface IPreferredRuntimeTypeConcept : IUnknown
{
    HRESULT CastToPreferredRuntimeType(IModelObject contextObject, IModelObject* object);
}

@GUID("b8c74943-6b2c-4eeb-b5c5-35d378a6d99d")
interface IDebugHost : IUnknown
{
    HRESULT GetHostDefinedInterface(IUnknown* hostUnk);
    HRESULT GetCurrentContext(IDebugHostContext* context);
    HRESULT GetDefaultMetadata(IKeyStore* defaultMetadataStore);
}

@GUID("a68c70d8-5ec0-46e5-b775-3134a48ea2e3")
interface IDebugHostContext : IUnknown
{
    HRESULT IsEqualTo(IDebugHostContext pContext, bool* pIsEqual);
}

@GUID("e92274a2-47f4-4538-a196-b83db25fe403")
interface IDebugHostContext2 : IDebugHostContext
{
    HRESULT GetAddressSpaceRelation(IDebugHostContext2 pContext, AddressSpaceRelation* pAddressSpaceRelation);
}

@GUID("5e67115d-5449-4553-a9e9-ca446578cab2")
interface IDebugHostContextExtension : IUnknown
{
    HRESULT AddExtensionData(uint blobId, uint dataSize, void* data);
    HRESULT FinalizeContext(IDebugHostContext* immutableContext);
}

@GUID("35ae8e40-f234-4ef1-b8ea-0dfbc58a2043")
interface IDebugHostContextExtensibility : IUnknown
{
    bool    HasExtensionData(uint blobId);
    HRESULT ReadExtensionData(uint blobId, uint bufferSize, void* buffer);
    HRESULT CloneContextForModification(IDebugHostContextExtension* extensionHandle);
    HRESULT CloneContextWithModification(uint blobId, uint dataSize, void* data, IDebugHostContext* clonedContext);
}

@GUID("eeb8fb43-b44e-4b0f-b871-65f0886fcaf2")
interface IDebugHostContextControl : IUnknown
{
    HRESULT SwitchTo();
    HRESULT GetContextAlternator(IDebugHostContextAlternator* contextAlternator);
}

@GUID("6301eee8-85e3-4058-a7c0-d37e0ea65f75")
interface IDebugHostContextAlternator : IUnknown
{
    HRESULT SwitchTo(ubyte fullSwitch);
    HRESULT SwitchBack();
}

@GUID("c8ff0f0b-fce9-467e-8bb3-5d69ef109c00")
interface IDebugHostErrorSink : IUnknown
{
    HRESULT ReportError(ErrorClass errClass, HRESULT hrError, const(PWSTR) message);
}

@GUID("0f819103-87de-4e96-8277-e05cd441fb22")
interface IDebugHostSymbol : IUnknown
{
    HRESULT GetContext(IDebugHostContext* context);
    HRESULT EnumerateChildren(SymbolKind kind, const(PWSTR) name, IDebugHostSymbolEnumerator* ppEnum);
    HRESULT GetSymbolKind(SymbolKind* kind);
    HRESULT GetName(BSTR* symbolName);
    HRESULT GetType(IDebugHostType* type);
    HRESULT GetContainingModule(IDebugHostModule* containingModule);
    HRESULT CompareAgainst(IDebugHostSymbol pComparisonSymbol, uint comparisonFlags, bool* pMatches);
}

@GUID("28d96c86-10a3-4976-b14e-eaef4790aa1f")
interface IDebugHostSymbolEnumerator : IUnknown
{
    HRESULT Reset();
    HRESULT GetNext(IDebugHostSymbol* symbol);
}

@GUID("d49eece8-8d12-4ce1-ab73-e5b63df4f9d3")
interface IDebugHostSymbolSubstitutionEnumerator : IDebugHostSymbolEnumerator
{
    HRESULT GetNextWithSubstitutionText(IDebugHostSymbol* symbol, BSTR* symbolText);
}

@GUID("c9ba3e18-d070-4378-bbd0-34613b346e1e")
interface IDebugHostModule : IDebugHostSymbol
{
    HRESULT GetImageName(ubyte allowPath, BSTR* imageName);
    HRESULT GetBaseLocation(Location* moduleBaseLocation);
    HRESULT GetVersion(ulong* fileVersion, ulong* productVersion);
    HRESULT FindTypeByName(const(PWSTR) typeName, IDebugHostType* type);
    HRESULT FindSymbolByRVA(ulong rva, IDebugHostSymbol* symbol);
    HRESULT FindSymbolByName(const(PWSTR) symbolName, IDebugHostSymbol* symbol);
}

@GUID("b51887e8-bcd0-4e8f-a8c7-434398b78c37")
interface IDebugHostModule2 : IDebugHostModule
{
    HRESULT FindContainingSymbolByRVA(ulong rva, IDebugHostSymbol* symbol, ulong* offset);
}

@GUID("68576417-9fab-4c69-8977-3a4d87cf08fd")
interface IDebugHostModule3 : IDebugHostModule2
{
    HRESULT GetRange(Location* moduleStart, Location* moduleEnd);
}

@GUID("41415136-38a4-474f-8e98-57e2dc64e565")
interface IDebugHostModule4 : IDebugHostModule3
{
    HRESULT FindTypeByName2(IDebugHostSymbol pEnclosingSymbol, const(PWSTR) typeName, IDebugHostType* type);
}

@GUID("ed36a63d-ad2b-467e-a0ca-4ca949357625")
interface IDebugHostModule5 : IDebugHostModule4
{
    HRESULT GetPrimaryCompilerInformation(KnownCompiler* pCompilerId, BSTR* pPrimaryCompilerString);
}

@GUID("3aadc353-2b14-4abb-9893-5e03458e07ee")
interface IDebugHostType : IDebugHostSymbol
{
    HRESULT GetTypeKind(TypeKind* kind);
    HRESULT GetSize(ulong* size);
    HRESULT GetBaseType(IDebugHostType* baseType);
    HRESULT GetHashCode(uint* hashCode);
    HRESULT GetIntrinsicType(IntrinsicKind* intrinsicKind, ushort* carrierType);
    HRESULT GetBitField(uint* lsbOfField, uint* lengthOfField);
    HRESULT GetPointerKind(PointerKind* pointerKind);
    HRESULT GetMemberType(IDebugHostType* memberType);
    HRESULT CreatePointerTo(PointerKind kind, IDebugHostType* newType);
    HRESULT GetArrayDimensionality(ulong* arrayDimensionality);
    HRESULT GetArrayDimensions(ulong dimensions, ArrayDimension* pDimensions);
    HRESULT CreateArrayOf(ulong dimensions, ArrayDimension* pDimensions, IDebugHostType* newType);
    HRESULT GetFunctionCallingConvention(CallingConventionKind* conventionKind);
    HRESULT GetFunctionReturnType(IDebugHostType* returnType);
    HRESULT GetFunctionParameterTypeCount(ulong* count);
    HRESULT GetFunctionParameterTypeAt(ulong i, IDebugHostType* parameterType);
    HRESULT IsGeneric(bool* isGeneric);
    HRESULT GetGenericArgumentCount(ulong* argCount);
    HRESULT GetGenericArgumentAt(ulong i, IDebugHostSymbol* argument);
}

@GUID("b28632b9-8506-4676-87ce-8f7e05e59876")
interface IDebugHostType2 : IDebugHostType
{
    HRESULT IsTypedef(bool* isTypedef);
    HRESULT GetTypedefBaseType(IDebugHostType2* baseType);
    HRESULT GetTypedefFinalBaseType(IDebugHostType2* finalBaseType);
    HRESULT GetFunctionVarArgsKind(VarArgsKind* varArgsKind);
    HRESULT GetFunctionInstancePointerType(IDebugHostType2* instancePointerType);
}

@GUID("8b0409ac-c1bb-433d-887a-ed12c3af0e7d")
interface IDebugHostType3 : IDebugHostType2
{
    HRESULT GetContainingType(IDebugHostType3* containingParentType);
}

@GUID("77d3cdc6-bd55-42bf-a4fd-d9aa60e3c1e1")
interface IDebugHostType4 : IDebugHostType3
{
    HRESULT GetExtendedArrayHeaderSize(ulong* headerSize);
    HRESULT GetExtendedArrayDimensions(ulong dimensions, ExtendedArrayDimension* pDimensions);
    HRESULT GetUDTKind(UDTKind* udtKind);
}

@GUID("db6716ce-8ee8-4c86-89db-a658915c87f4")
interface IDebugHostType5 : IDebugHostType4
{
    HRESULT IsBaseTypeOf(IDebugHostType pOtherType, bool* pIsBase);
}

@GUID("08b431ed-f684-4480-8c44-b543aa32ceb0")
interface IDebugHostType6 : IDebugHostType5
{
    HRESULT GetTaggedUnionTag(IDebugHostType* pTagType, uint* pTagOffset, VARIANT* pTagMask);
    HRESULT GetTaggedUnionTagRanges(IDebugHostTaggedUnionRangeEnumerator* pTagRangeEnumerator);
    HRESULT UpcastToTaggedUnionType(IDebugHostType pTaggedUnionType, IDebugHostType* pUpcastedCaseType);
}

@GUID("f4a035c0-4ca0-4b6d-bfd2-b378a0dbfe4c")
interface IDebugHostTaggedUnionRangeEnumerator : IUnknown
{
    HRESULT Reset();
    HRESULT GetNext(VARIANT* pLow, VARIANT* pHigh);
    HRESULT GetCount(uint* pCount);
}

@GUID("62787edc-fa76-4690-bd71-5e8c3e2937ec")
interface IDebugHostConstant : IDebugHostSymbol
{
    HRESULT GetValue(VARIANT* value);
}

@GUID("e06f6495-16bc-4cc9-b11d-2a6b23fa72f3")
interface IDebugHostField : IDebugHostSymbol
{
    HRESULT GetLocationKind(LocationKind* locationKind);
    HRESULT GetOffset(ulong* offset);
    HRESULT GetLocation(Location* location);
    HRESULT GetValue(VARIANT* value);
}

@GUID("99468a0b-ea92-4bd4-9efe-a266160578ca")
interface IDebugHostField2 : IDebugHostField
{
    HRESULT GetContainingType(IDebugHostType3* containingParentType);
}

@GUID("a3d64993-826c-44fa-897d-926f2fe7ad0b")
interface IDebugHostData : IDebugHostSymbol
{
    HRESULT GetLocationKind(LocationKind* locationKind);
    HRESULT GetLocation(Location* location);
    HRESULT GetValue(VARIANT* value);
}

@GUID("6c597ac9-fb4d-4f6d-9f39-22488539f8f4")
interface IDebugHostPublic : IDebugHostSymbol
{
    HRESULT GetLocationKind(LocationKind* locationKind);
    HRESULT GetLocation(Location* location);
}

@GUID("b94d57d2-390b-40f7-b5b4-b6db897d974b")
interface IDebugHostBaseClass : IDebugHostSymbol
{
    HRESULT GetOffset(ulong* offset);
}

@GUID("435460e2-fd3b-4275-b36c-88ef50188588")
interface IDebugHostBaseClass2 : IDebugHostBaseClass
{
    HRESULT IsVirtual(bool* pIsVirtual);
    HRESULT GetVirtualBaseOffsetLocation(long* pTableOffset, long* pSlotOffset, ulong* pSlotSize, 
                                         bool* pSlotIsSigned);
}

@GUID("854fd751-c2e1-4eb2-b525-6619cb97a588")
interface IDebugHostSymbols : IUnknown
{
    HRESULT CreateModuleSignature(const(PWSTR) pwszModuleName, const(PWSTR) pwszMinVersion, 
                                  const(PWSTR) pwszMaxVersion, IDebugHostModuleSignature* ppModuleSignature);
    HRESULT CreateTypeSignature(const(PWSTR) signatureSpecification, IDebugHostModule module_, 
                                IDebugHostTypeSignature* typeSignature);
    HRESULT CreateTypeSignatureForModuleRange(const(PWSTR) signatureSpecification, const(PWSTR) moduleName, 
                                              const(PWSTR) minVersion, const(PWSTR) maxVersion, 
                                              IDebugHostTypeSignature* typeSignature);
    HRESULT EnumerateModules(IDebugHostContext context, IDebugHostSymbolEnumerator* moduleEnum);
    HRESULT FindModuleByName(IDebugHostContext context, const(PWSTR) moduleName, IDebugHostModule* module_);
    HRESULT FindModuleByLocation(IDebugHostContext context, Location moduleLocation, IDebugHostModule* module_);
    HRESULT GetMostDerivedObject(IDebugHostContext pContext, Location location, IDebugHostType objectType, 
                                 Location* derivedLocation, IDebugHostType* derivedType);
}

@GUID("6baf1f48-65ee-4ff2-b3af-10c7f21d38b2")
interface IDebugHostSymbols2 : IDebugHostSymbols
{
    HRESULT DemangleSymbolName(IDebugHostSymbol pSymbol, uint flags, BSTR* pDemangledSymbolName);
}

@GUID("212149c9-9183-4a3e-b00e-4fd1dc95339b")
interface IDebugHostMemory : IUnknown
{
    HRESULT ReadBytes(IDebugHostContext context, Location location, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* buffer, 
                      ulong bufferSize, ulong* bytesRead);
    HRESULT WriteBytes(IDebugHostContext context, Location location, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* buffer, 
                       ulong bufferSize, ulong* bytesWritten);
    HRESULT ReadPointers(IDebugHostContext context, Location location, ulong count, ulong* pointers);
    HRESULT WritePointers(IDebugHostContext context, Location location, ulong count, ulong* pointers);
    HRESULT GetDisplayStringForLocation(IDebugHostContext context, Location location, ubyte verbose, 
                                        BSTR* locationName);
}

@GUID("eea033de-38f6-416b-a251-1d3771001270")
interface IDebugHostMemory2 : IDebugHostMemory
{
    HRESULT LinearizeLocation(IDebugHostContext context, Location location, Location* pLinearizedLocation);
}

@GUID("a515ed09-2bf3-4499-bb03-553790079f84")
interface IDebugHostMemory3 : IDebugHostMemory2
{
    HRESULT CanonicalizeLocation(IDebugHostContext context, Location location, Location* pCanonicalizedLocation);
}

@GUID("fe6b3658-da4b-44e3-8a58-6201322280e6")
interface IDebugHostMemory4 : IDebugHostMemory3
{
    HRESULT GetPhysicalAddressLocation(ulong physAddr, Location* pPhysicalAddressLocation);
    bool    IsPhysicalAddressLocation(Location* pLocation);
}

@GUID("df033400-4912-46e9-ba62-6ef2eb4d87d4")
interface IDebugHostMemory5 : IDebugHostMemory4
{
    HRESULT ReadIntrinsics(IDebugHostContext context, Location location, ushort vt, ulong count, VARIANT* vals, 
                           ulong* intrinsicsRead);
    HRESULT ReadOrdinalIntrinsics(IDebugHostContext context, Location location, ulong ordinalSize, 
                                  ubyte ordinalIsSigned, ulong count, VARIANT* vals, ulong* intrinsicsRead);
}

@GUID("0fef9a21-577e-4997-ac7b-1c4883241d99")
interface IDebugHostEvaluator : IUnknown
{
    HRESULT EvaluateExpression(IDebugHostContext context, const(PWSTR) expression, IModelObject bindingContext, 
                               IModelObject* result, IKeyStore* metadata);
    HRESULT EvaluateExtendedExpression(IDebugHostContext context, const(PWSTR) expression, 
                                       IModelObject bindingContext, IModelObject* result, IKeyStore* metadata);
}

@GUID("31e53a5a-01ee-4bbb-b899-4b46ae7d595c")
interface IDebugHostModuleSignature : IUnknown
{
    HRESULT IsMatch(IDebugHostModule pModule, bool* isMatch);
}

@GUID("3aadc353-2b14-4abb-9893-5e03458e07ee")
interface IDebugHostTypeSignature : IUnknown
{
    HRESULT GetHashCode(uint* hashCode);
    HRESULT IsMatch(IDebugHostType type, bool* isMatch, IDebugHostSymbolEnumerator* wildcardMatches);
    HRESULT CompareAgainst(IDebugHostTypeSignature typeSignature, SignatureComparison* result);
}

@GUID("21515b67-6720-4257-8a68-077dc944471c")
interface IDebugHostSymbol2 : IDebugHostSymbol
{
    HRESULT GetLanguage(LanguageKind* pKind);
}

@GUID("1b3fc1b3-d03d-43e0-8eb0-9aa4baa21edb")
interface IDebugHostSymbol3 : IDebugHostSymbol2
{
    HRESULT GetCompilerInformation(KnownCompiler* pCompilerId, BSTR* pCompilerString);
}

@GUID("4f3e1ce2-86b2-4c7a-9c65-d0a9d0eecf44")
interface IDebugHostStatus : IUnknown
{
    HRESULT PollUserInterrupt(bool* interruptRequested);
}

@GUID("4a168d3f-04d0-49c4-8f9a-7b5b3108c6c6")
interface IDebugHostStatus2 : IDebugHostStatus
{
    HRESULT SetUserInterrupt();
    HRESULT ClearUserInterrupt();
}

@GUID("3b362b0e-89f0-46c6-a663-dfdc95194aef")
interface IDataModelScriptClient : IUnknown
{
    HRESULT ReportError(ErrorClass errClass, HRESULT hrFail, const(PWSTR) message, uint line, uint position);
}

@GUID("1303dec4-fa3b-4f1b-9224-b953d16babb5")
interface IDataModelScriptTemplate : IUnknown
{
    HRESULT GetName(BSTR* templateName);
    HRESULT GetDescription(BSTR* templateDescription);
    HRESULT GetContent(IStream* contentStream);
}

@GUID("7b4d30fc-b14a-49f8-8d87-d9a1480c97f7")
interface IDataModelScript : IUnknown
{
    HRESULT GetName(BSTR* scriptName);
    HRESULT Rename(const(PWSTR) scriptName);
    HRESULT Populate(IStream contentStream);
    HRESULT Execute(IDataModelScriptClient client);
    HRESULT Unlink();
    HRESULT IsInvocable(bool* isInvocable);
    HRESULT InvokeMain(IDataModelScriptClient client);
}

@GUID("7d90cf81-bee2-4b91-9d49-8fec0f7d56d1")
interface IDataModelScript2 : IDataModelScript
{
    HRESULT GetScriptFullFilePathName(BSTR* scriptFullPathName);
    HRESULT SetScriptFullFilePathName(const(PWSTR) scriptFullPathName);
}

@GUID("69ce6ae2-2268-4e6f-b062-20ce62bfe677")
interface IDataModelScriptTemplateEnumerator : IUnknown
{
    HRESULT Reset();
    HRESULT GetNext(IDataModelScriptTemplate* templateContent);
}

@GUID("513461e0-4fca-48ce-8658-32f3e2056f3b")
interface IDataModelScriptProvider : IUnknown
{
    HRESULT GetName(BSTR* name);
    HRESULT GetExtension(BSTR* extension);
    HRESULT CreateScript(IDataModelScript* script);
    HRESULT GetDefaultTemplateContent(IDataModelScriptTemplate* templateContent);
    HRESULT EnumerateTemplates(IDataModelScriptTemplateEnumerator* enumerator);
}

@GUID("95ba00e2-704a-4fe2-a8f1-a7e7d8fb0941")
interface IDataModelScriptProviderEnumerator : IUnknown
{
    HRESULT Reset();
    HRESULT GetNext(IDataModelScriptProvider* provider);
}

@GUID("6fd11e33-e5ad-410b-8011-68c6bc4bf80d")
interface IDataModelScriptManager : IUnknown
{
    HRESULT GetDefaultNameBinder(IDataModelNameBinder* ppNameBinder);
    HRESULT RegisterScriptProvider(IDataModelScriptProvider provider);
    HRESULT UnregisterScriptProvider(IDataModelScriptProvider provider);
    HRESULT FindProviderForScriptType(const(PWSTR) scriptType, IDataModelScriptProvider* provider);
    HRESULT FindProviderForScriptExtension(const(PWSTR) scriptExtension, IDataModelScriptProvider* provider);
    HRESULT EnumerateScriptProviders(IDataModelScriptProviderEnumerator* enumerator);
}

@GUID("e7983fa1-80a7-498c-988f-518ddc5d4025")
interface IDynamicKeyProviderConcept : IUnknown
{
    HRESULT GetKey(IModelObject contextObject, const(PWSTR) key, IModelObject* keyValue, IKeyStore* metadata, 
                   bool* hasKey);
    HRESULT SetKey(IModelObject contextObject, const(PWSTR) key, IModelObject keyValue, IKeyStore metadata);
    HRESULT EnumerateKeys(IModelObject contextObject, IKeyEnumerator* ppEnumerator);
}

@GUID("95a7f7dd-602e-483f-9d06-a15c0ee13174")
interface IDynamicConceptProviderConcept : IUnknown
{
    HRESULT GetConcept(IModelObject contextObject, const(GUID)* conceptId, IUnknown* conceptInterface, 
                       IKeyStore* conceptMetadata, bool* hasConcept);
    HRESULT SetConcept(IModelObject contextObject, const(GUID)* conceptId, IUnknown conceptInterface, 
                       IKeyStore conceptMetadata);
    HRESULT NotifyParent(IModelObject parentModel);
    HRESULT NotifyParentChange(IModelObject parentModel);
    HRESULT NotifyDestruct();
}

@GUID("014d366a-1f23-4981-9219-b2db8b402054")
interface IDataModelScriptHostContext : IUnknown
{
    HRESULT NotifyScriptChange(IDataModelScript script, ScriptChangeKind changeKind);
    HRESULT GetNamespaceObject(IModelObject* namespaceObject);
}

@GUID("b70334a4-b92c-4570-93a1-d3eb686649a0")
interface IDebugHostScriptHost : IUnknown
{
    HRESULT CreateContext(IDataModelScript script, IDataModelScriptHostContext* scriptContext);
}

@GUID("af352b7b-8292-4c01-b360-2dc3696c65e7")
interface IDataModelNameBinder : IUnknown
{
    HRESULT BindValue(IModelObject contextObject, const(PWSTR) name, IModelObject* value, IKeyStore* metadata);
    HRESULT BindReference(IModelObject contextObject, const(PWSTR) name, IModelObject* reference, 
                          IKeyStore* metadata);
    HRESULT EnumerateValues(IModelObject contextObject, IKeyEnumerator* enumerator);
    HRESULT EnumerateReferences(IModelObject contextObject, IKeyEnumerator* enumerator);
}

@GUID("80e2f7c5-7159-4e92-887e-7e0347e88406")
interface IModelKeyReference2 : IModelKeyReference
{
    HRESULT OverrideContextObject(IModelObject newContextObject);
}

@GUID("a117a435-1fb4-4092-a2ab-a929576c1e87")
interface IDebugHostEvaluator2 : IDebugHostEvaluator
{
    HRESULT AssignTo(IModelObject assignmentReference, IModelObject assignmentValue, 
                     IModelObject* assignmentResult, IKeyStore* assignmentMetadata);
}

@GUID("d2419f4a-7e8d-4c15-a499-73902b015abb")
interface IDebugHostEvaluator3 : IDebugHostEvaluator2
{
    HRESULT Compare(IModelObject pLeft, IModelObject pRight, IModelObject* ppResult);
}

@GUID("3c2b24e1-11d0-4f86-8ae5-4df166f73253")
interface IDebugHostExtensibility : IUnknown
{
    HRESULT CreateFunctionAlias(const(PWSTR) aliasName, IModelObject functionObject);
    HRESULT DestroyFunctionAlias(const(PWSTR) aliasName);
}

@GUID("91cc55e7-2a22-4494-9710-b729dab48f71")
interface IDebugHostExtensibility2 : IDebugHostExtensibility
{
    HRESULT CreateFunctionAliasWithMetadata(const(PWSTR) aliasName, IModelObject functionObject, 
                                            IKeyStore metadata);
}

@GUID("4be234de-d397-4378-bbb4-9055a425d7d1")
interface IDebugHostExtensibility3 : IDebugHostExtensibility2
{
    HRESULT ExtendHostContext(uint blobSize, const(GUID)* identifier, uint* blobId);
    HRESULT QueryHostContextExtension(const(GUID)* identifier, uint* blobId, uint* blobSize);
    HRESULT ReleaseHostContextExtension(uint blobId);
}

@GUID("53159b6d-d4c4-471b-a863-5b110ca800ca")
interface IDataModelScriptDebugClient : IUnknown
{
    HRESULT NotifyDebugEvent(ScriptDebugEventInformation* pEventInfo, IDataModelScript pScript, 
                             IModelObject pEventDataObject, ScriptExecutionKind* resumeEventKind);
}

@GUID("0f9feed7-d045-4ac3-98a8-a98942cf6a35")
interface IDataModelScriptDebugVariableSetEnumerator : IUnknown
{
    HRESULT Reset();
    HRESULT GetNext(BSTR* variableName, IModelObject* variableValue, IKeyStore* variableMetadata);
}

@GUID("dec6ed5e-6360-4941-ab4c-a26409de4f82")
interface IDataModelScriptDebugStackFrame : IUnknown
{
    HRESULT GetName(BSTR* name);
    HRESULT GetPosition(ScriptDebugPosition* position, ScriptDebugPosition* positionSpanEnd, BSTR* lineText);
    HRESULT IsTransitionPoint(bool* isTransitionPoint);
    HRESULT GetTransition(IDataModelScript* transitionScript, bool* isTransitionContiguous);
    HRESULT Evaluate(const(PWSTR) pwszExpression, IModelObject* ppResult);
    HRESULT EnumerateLocals(IDataModelScriptDebugVariableSetEnumerator* variablesEnum);
    HRESULT EnumerateArguments(IDataModelScriptDebugVariableSetEnumerator* variablesEnum);
}

@GUID("051364dd-e449-443e-9762-fe578f4a5473")
interface IDataModelScriptDebugStack : IUnknown
{
    ulong   GetFrameCount();
    HRESULT GetStackFrame(ulong frameNumber, IDataModelScriptDebugStackFrame* stackFrame);
}

@GUID("6bb27b35-02e6-47cb-90a0-5371244032de")
interface IDataModelScriptDebugBreakpoint : IUnknown
{
    ulong   GetId();
    bool    IsEnabled();
    void    Enable();
    void    Disable();
    void    Remove();
    HRESULT GetPosition(ScriptDebugPosition* position, ScriptDebugPosition* positionSpanEnd, BSTR* lineText);
}

@GUID("39484a75-b4f3-4799-86da-691afa57b299")
interface IDataModelScriptDebugBreakpointEnumerator : IUnknown
{
    HRESULT Reset();
    HRESULT GetNext(IDataModelScriptDebugBreakpoint* breakpoint);
}

@GUID("de8e0945-9750-4471-ab76-a8f79d6ec350")
interface IDataModelScriptDebug : IUnknown
{
    ScriptDebugState GetDebugState();
    HRESULT GetCurrentPosition(ScriptDebugPosition* currentPosition, ScriptDebugPosition* positionSpanEnd, 
                               BSTR* lineText);
    HRESULT GetStack(IDataModelScriptDebugStack* stack);
    HRESULT SetBreakpoint(uint linePosition, uint columnPosition, IDataModelScriptDebugBreakpoint* breakpoint);
    HRESULT FindBreakpointById(ulong breakpointId, IDataModelScriptDebugBreakpoint* breakpoint);
    HRESULT EnumerateBreakpoints(IDataModelScriptDebugBreakpointEnumerator* breakpointEnum);
    HRESULT GetEventFilter(ScriptDebugEventFilter eventFilter, bool* isBreakEnabled);
    HRESULT SetEventFilter(ScriptDebugEventFilter eventFilter, ubyte isBreakEnabled);
    HRESULT StartDebugging(IDataModelScriptDebugClient debugClient);
    HRESULT StopDebugging(IDataModelScriptDebugClient debugClient);
}

@GUID("cbb10ed3-839e-426c-9243-e23535c1ae1a")
interface IDataModelScriptDebug2 : IDataModelScriptDebug
{
    HRESULT SetBreakpointAtFunction(const(PWSTR) functionName, IDataModelScriptDebugBreakpoint* breakpoint);
}

@GUID("a7830646-9f0c-4a31-ba19-503f33e6c8a3")
interface IComparableConcept : IUnknown
{
    HRESULT CompareObjects(IModelObject contextObject, IModelObject otherObject, int* comparisonResult);
}

@GUID("c52d5d3d-609d-4d5d-8a82-46b0acdec4f4")
interface IEquatableConcept : IUnknown
{
    HRESULT AreObjectsEqual(IModelObject contextObject, IModelObject otherObject, bool* isEqual);
}

@GUID("3dec5c44-f63a-4ca6-90f0-fd5c269fda59")
interface IActionEnumerator : IUnknown
{
    HRESULT Reset();
    HRESULT GetNext(BSTR* keyName, BSTR* actionName, BSTR* actionDescription, bool* actionIsDefault, 
                    IModelObject* actionMethod, IKeyStore* metadta);
}

@GUID("2cd9906f-f1b3-4463-828a-0addafe8baae")
interface IActionableConcept : IUnknown
{
    HRESULT EnumerateActions(IModelObject contextObject, IActionEnumerator* actionEnumerator);
}

@GUID("7fc09c9f-632d-48e8-a97b-2f4f2e5c1161")
interface IActionQueryConcept : IUnknown
{
    HRESULT EnumerateActions(IModelObject contextObject, IActionEnumerator* actionEnumerator);
}

@GUID("1a9409f1-f0e0-4b48-9a4e-5783548fb57a")
interface IConstructableConcept : IUnknown
{
    HRESULT CreateInstance(ulong argCount, IModelObject* ppArguments, IModelObject* ppInstance);
}

@GUID("f798139e-1b2c-4077-8d87-9fa5d044f3eb")
interface IDeconstructableConcept : IUnknown
{
    HRESULT GetConstructableModelName(IModelObject contextObject, BSTR* constructableModelName);
    HRESULT GetConstructorArgumentCount(IModelObject contextObject, ulong* argCount);
    HRESULT GetConstructorArguments(IModelObject contextObject, ulong argCount, IModelObject* constructorArguments);
}

@GUID("2f2f303b-39be-4b6d-9bfb-4faa49dbbd45")
interface IDebugHostFunctionLocalStorage : IUnknown
{
    HRESULT GetValidRange(ulong* start, ulong* end, bool* guaranteed);
    HRESULT GetStorageKind(StorageKind* kind);
    HRESULT GetRegister(uint* registerId);
    HRESULT GetOffset(long* offset);
}

@GUID("213b3725-36a2-45a0-9ea4-854d46d85195")
interface IDebugHostFunctionLocalStorage2 : IUnknown
{
    HRESULT GetExtendedRegisterAddressInfo(uint* registerId, long* offset, bool* isIndirectAccess, 
                                           int* indirectOffset);
}

@GUID("026c9e81-8b9f-4d32-9606-a394ec62b045")
interface IDebugHostFunctionLocalStorageEnumerator : IUnknown
{
    HRESULT Reset();
    HRESULT GetNext(IDebugHostFunctionLocalStorage* storage);
}

@GUID("89280ea8-b3b9-408c-be16-32ab28f5c0ac")
interface IDebugHostFunctionLocalDetails : IUnknown
{
    HRESULT GetName(BSTR* name);
    HRESULT GetType(IDebugHostType* localType);
    HRESULT EnumerateStorage(IDebugHostFunctionLocalStorageEnumerator* storageEnum);
    HRESULT GetLocalKind(LocalKind* kind);
    HRESULT GetArgumentPosition(ulong* argPosition);
}

@GUID("199a57b0-1967-4363-b25e-90c7e8a07f22")
interface IDebugHostFunctionLocalDetails2 : IDebugHostFunctionLocalDetails
{
    bool    IsInlineScope();
    HRESULT GetInlinedFunction(IDebugHostSymbol* inlineFunction);
}

@GUID("a61adc36-1ed5-40fe-a976-6a21cd81e811")
interface IDebugHostFunctionLocalDetailsEnumerator : IUnknown
{
    HRESULT Reset();
    HRESULT GetNext(IDebugHostFunctionLocalDetails* localDetails);
}

@GUID("a754393c-4fbe-4178-8ad5-fe6079ac048d")
interface IDebugHostFunctionIntrospection : IUnknown
{
    HRESULT EnumerateLocalsDetails(IDebugHostFunctionLocalDetailsEnumerator* localsEnum);
    HRESULT EnumerateInlineFunctionsByRVA(ulong rva, IDebugHostSymbolEnumerator* inlinesEnum);
    HRESULT FindContainingCodeRangeByRVA(ulong rva, Location* rangeStart, Location* rangeEnd);
    HRESULT FindSourceLocationByRVA(ulong rva, BSTR* sourceFile, ulong* sourceLine);
}

@GUID("8e1cb118-aa83-409a-aae9-c7ff78911a5f")
interface IDebugHostFunctionIntrospection2 : IDebugHostFunctionIntrospection
{
    HRESULT EnumerateLocalsDetailsEx(ubyte enumerateInlinedLocals, 
                                     IDebugHostFunctionLocalDetailsEnumerator* localsEnum);
}

@GUID("a24e286b-891a-40fc-8a3a-89b66eddce57")
interface IDebugHostFunctionIntrospection3 : IDebugHostFunctionIntrospection2
{
    HRESULT IsNoReturnFunction(bool* pIsNoReturnFunction);
}

@GUID("63832802-2db3-4de7-b76c-197ac15b5ec6")
interface IFilteredNamespacePropertyToken : IUnknown
{
    HRESULT RemoveFilter();
    HRESULT GetFilter(IModelMethod* ppFilter);
    HRESULT TrySetFilter(IModelMethod pFilter);
}

@GUID("3d06878f-97ab-4c5b-955e-fa647d3b137c")
interface IDebugHostContextTargetComposition : IUnknown
{
    HRESULT GetServiceManager(IDebugServiceManager** ppServiceManager);
    HRESULT GetServiceProcess(ISvcProcess** ppProcess);
    HRESULT GetServiceThread(ISvcThread** ppThread);
}

@GUID("3c4b6add-80e1-4c2b-afe1-9a1132586dd0")
interface IDebugHostSymbolsTargetComposition : IUnknown
{
    HRESULT GetTypeForServiceType(IDebugServiceManager* pServiceManager, ISvcModule* pModule, 
                                  ISvcSymbolType* pType, IDebugHostType* ppHostType);
}

interface IDebugFAEntryTags
{
    FA_ENTRY_TYPE GetType(DEBUG_FLR_PARAM_TYPE Tag);
    HRESULT SetType(DEBUG_FLR_PARAM_TYPE Tag, FA_ENTRY_TYPE EntryType);
    HRESULT GetProperties(DEBUG_FLR_PARAM_TYPE Tag, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSTR Name, 
                          uint* NameSize, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PSTR Description, 
                          uint* DescSize, uint* Flags);
    HRESULT SetProperties(DEBUG_FLR_PARAM_TYPE Tag, const(PSTR) Name, const(PSTR) Description, uint Flags);
    HRESULT GetTagByName(const(PSTR) PluginId, const(PSTR) TagName, DEBUG_FLR_PARAM_TYPE* Tag);
    BOOL    IsValidTagToSet(DEBUG_FLR_PARAM_TYPE Tag);
}

@GUID("ed0de363-451f-4943-820c-62dccdfa7e6d")
interface IDebugFailureAnalysis : IUnknown
{
    uint GetFailureClass();
    DEBUG_FAILURE_TYPE GetFailureType();
    uint GetFailureCode();
    FA_ENTRY* Get(DEBUG_FLR_PARAM_TYPE Tag);
    FA_ENTRY* GetNext(FA_ENTRY* Entry, DEBUG_FLR_PARAM_TYPE Tag, DEBUG_FLR_PARAM_TYPE TagMask);
    FA_ENTRY* GetString(DEBUG_FLR_PARAM_TYPE Tag, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSTR Str, 
                        uint MaxSize);
    FA_ENTRY* GetBuffer(DEBUG_FLR_PARAM_TYPE Tag, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buf, 
                        uint Size);
    FA_ENTRY* GetUlong(DEBUG_FLR_PARAM_TYPE Tag, uint* Value);
    FA_ENTRY* GetUlong64(DEBUG_FLR_PARAM_TYPE Tag, ulong* Value);
    FA_ENTRY* NextEntry(FA_ENTRY* Entry);
}

@GUID("ea15c288-8226-4b70-acf6-0be6b189e3ad")
interface IDebugFailureAnalysis2 : IUnknown
{
    uint    GetFailureClass();
    DEBUG_FAILURE_TYPE GetFailureType();
    uint    GetFailureCode();
    FA_ENTRY* Get(DEBUG_FLR_PARAM_TYPE Tag);
    FA_ENTRY* GetNext(FA_ENTRY* Entry, DEBUG_FLR_PARAM_TYPE Tag, DEBUG_FLR_PARAM_TYPE TagMask);
    FA_ENTRY* GetString(DEBUG_FLR_PARAM_TYPE Tag, PSTR Str, uint MaxSize);
    FA_ENTRY* GetBuffer(DEBUG_FLR_PARAM_TYPE Tag, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buf, 
                        uint Size);
    FA_ENTRY* GetUlong(DEBUG_FLR_PARAM_TYPE Tag, uint* Value);
    FA_ENTRY* GetUlong64(DEBUG_FLR_PARAM_TYPE Tag, ulong* Value);
    FA_ENTRY* NextEntry(FA_ENTRY* Entry);
    FA_ENTRY* SetString(DEBUG_FLR_PARAM_TYPE Tag, const(PSTR) Str);
    FA_ENTRY* SetExtensionCommand(DEBUG_FLR_PARAM_TYPE Tag, const(PSTR) Extension);
    FA_ENTRY* SetUlong(DEBUG_FLR_PARAM_TYPE Tag, uint Value);
    FA_ENTRY* SetUlong64(DEBUG_FLR_PARAM_TYPE Tag, ulong Value);
    FA_ENTRY* SetBuffer(DEBUG_FLR_PARAM_TYPE Tag, FA_ENTRY_TYPE EntryType, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buf, 
                        uint Size);
    FA_ENTRY* AddString(DEBUG_FLR_PARAM_TYPE Tag, const(PSTR) Str);
    FA_ENTRY* AddExtensionCommand(DEBUG_FLR_PARAM_TYPE Tag, const(PSTR) Extension);
    FA_ENTRY* AddUlong(DEBUG_FLR_PARAM_TYPE Tag, uint Value);
    FA_ENTRY* AddUlong64(DEBUG_FLR_PARAM_TYPE Tag, ulong Value);
    FA_ENTRY* AddBuffer(DEBUG_FLR_PARAM_TYPE Tag, FA_ENTRY_TYPE EntryType, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* Buf, 
                        uint Size);
    HRESULT GetDebugFATagControl(IDebugFAEntryTags* FATagControl);
    HRESULT GetAnalysisXml(IXMLDOMElement* ppXMLDOMElement);
    HRESULT AddStructuredAnalysisData(DEBUG_FLR_PARAM_TYPE Tag, IDebugFailureAnalysis2 Analysis);
}

@GUID("3627dc67-fd45-42ff-9ba4-4a67ee64619f")
interface IDebugFailureAnalysis3 : IUnknown
{
    uint    GetFailureClass();
    DEBUG_FAILURE_TYPE GetFailureType();
    uint    GetFailureCode();
    FA_ENTRY* Get(DEBUG_FLR_PARAM_TYPE Tag);
    FA_ENTRY* GetNext(FA_ENTRY* Entry, DEBUG_FLR_PARAM_TYPE Tag, DEBUG_FLR_PARAM_TYPE TagMask);
    FA_ENTRY* GetString(DEBUG_FLR_PARAM_TYPE Tag, PSTR Str, uint MaxSize);
    FA_ENTRY* GetBuffer(DEBUG_FLR_PARAM_TYPE Tag, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* Buf, 
                        uint Size);
    FA_ENTRY* GetUlong(DEBUG_FLR_PARAM_TYPE Tag, uint* Value);
    FA_ENTRY* GetUlong64(DEBUG_FLR_PARAM_TYPE Tag, ulong* Value);
    FA_ENTRY* NextEntry(FA_ENTRY* Entry);
    FA_ENTRY* SetString(DEBUG_FLR_PARAM_TYPE Tag, const(PSTR) Str);
    FA_ENTRY* SetExtensionCommand(DEBUG_FLR_PARAM_TYPE Tag, const(PSTR) Extension);
    FA_ENTRY* SetUlong(DEBUG_FLR_PARAM_TYPE Tag, uint Value);
    FA_ENTRY* SetUlong64(DEBUG_FLR_PARAM_TYPE Tag, ulong Value);
    FA_ENTRY* SetBuffer(DEBUG_FLR_PARAM_TYPE Tag, FA_ENTRY_TYPE EntryType, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buf, 
                        uint Size);
    FA_ENTRY* AddString(DEBUG_FLR_PARAM_TYPE Tag, const(PSTR) Str);
    FA_ENTRY* AddExtensionCommand(DEBUG_FLR_PARAM_TYPE Tag, const(PSTR) Extension);
    FA_ENTRY* AddUlong(DEBUG_FLR_PARAM_TYPE Tag, uint Value);
    FA_ENTRY* AddUlong64(DEBUG_FLR_PARAM_TYPE Tag, ulong Value);
    FA_ENTRY* AddBuffer(DEBUG_FLR_PARAM_TYPE Tag, FA_ENTRY_TYPE EntryType, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* Buf, 
                        uint Size);
    HRESULT GetDebugFATagControl(IDebugFAEntryTags* FATagControl);
    HRESULT GetAnalysisXml(IXMLDOMElement* ppXMLDOMElement);
    HRESULT AddStructuredAnalysisData(DEBUG_FLR_PARAM_TYPE Tag, IDebugFailureAnalysis2 Analysis);
    HRESULT AddThreads(IUnknown pDebugFailureThreadEnum);
    HRESULT AttributeGet(uint nIndex, VARIANT* pValue);
    HRESULT AttributeGetName(uint nIndex, BSTR* pName);
    HRESULT AttributeSet(uint nIndex, VARIANT Value);
    HRESULT BlameApplication(BSTR Postfix);
    HRESULT BlameProcess(BSTR Postfix);
    HRESULT BlameThread(IUnknown pThread);
    HRESULT BlameStitch(IUnknown pThread, BSTR Stitch);
    HRESULT BlameTEB(ulong Address);
    HRESULT BlameETHREAD(ulong Address);
    HRESULT ProblemClassIsSet(uint nIndex, VARIANT_BOOL* pSet);
    HRESULT ProblemClassDelete(uint nIndex);
    HRESULT ProblemClassSet(uint nIndex);
    HRESULT ProblemClassSetBSTR(uint nIndex, BSTR Value);
    HRESULT SetAdditionalXML(BSTR Key, IUnknown pXMLDOMElement);
    HRESULT GetAdditionalXML(BSTR Key, IUnknown* ppXMLDOMElement);
    HRESULT DeleteAdditionalXML(BSTR Key);
}


// GUIDs


const GUID IID_IActionEnumerator                          = GUIDOF!IActionEnumerator;
const GUID IID_IActionQueryConcept                        = GUIDOF!IActionQueryConcept;
const GUID IID_IActionableConcept                         = GUIDOF!IActionableConcept;
const GUID IID_ICodeAddressConcept                        = GUIDOF!ICodeAddressConcept;
const GUID IID_IComparableConcept                         = GUIDOF!IComparableConcept;
const GUID IID_IConstructableConcept                      = GUIDOF!IConstructableConcept;
const GUID IID_IDataModelConcept                          = GUIDOF!IDataModelConcept;
const GUID IID_IDataModelManager                          = GUIDOF!IDataModelManager;
const GUID IID_IDataModelManager2                         = GUIDOF!IDataModelManager2;
const GUID IID_IDataModelManager3                         = GUIDOF!IDataModelManager3;
const GUID IID_IDataModelManager4                         = GUIDOF!IDataModelManager4;
const GUID IID_IDataModelNameBinder                       = GUIDOF!IDataModelNameBinder;
const GUID IID_IDataModelScript                           = GUIDOF!IDataModelScript;
const GUID IID_IDataModelScript2                          = GUIDOF!IDataModelScript2;
const GUID IID_IDataModelScriptClient                     = GUIDOF!IDataModelScriptClient;
const GUID IID_IDataModelScriptDebug                      = GUIDOF!IDataModelScriptDebug;
const GUID IID_IDataModelScriptDebug2                     = GUIDOF!IDataModelScriptDebug2;
const GUID IID_IDataModelScriptDebugBreakpoint            = GUIDOF!IDataModelScriptDebugBreakpoint;
const GUID IID_IDataModelScriptDebugBreakpointEnumerator  = GUIDOF!IDataModelScriptDebugBreakpointEnumerator;
const GUID IID_IDataModelScriptDebugClient                = GUIDOF!IDataModelScriptDebugClient;
const GUID IID_IDataModelScriptDebugStack                 = GUIDOF!IDataModelScriptDebugStack;
const GUID IID_IDataModelScriptDebugStackFrame            = GUIDOF!IDataModelScriptDebugStackFrame;
const GUID IID_IDataModelScriptDebugVariableSetEnumerator = GUIDOF!IDataModelScriptDebugVariableSetEnumerator;
const GUID IID_IDataModelScriptHostContext                = GUIDOF!IDataModelScriptHostContext;
const GUID IID_IDataModelScriptManager                    = GUIDOF!IDataModelScriptManager;
const GUID IID_IDataModelScriptProvider                   = GUIDOF!IDataModelScriptProvider;
const GUID IID_IDataModelScriptProviderEnumerator         = GUIDOF!IDataModelScriptProviderEnumerator;
const GUID IID_IDataModelScriptTemplate                   = GUIDOF!IDataModelScriptTemplate;
const GUID IID_IDataModelScriptTemplateEnumerator         = GUIDOF!IDataModelScriptTemplateEnumerator;
const GUID IID_IDebugAdvanced                             = GUIDOF!IDebugAdvanced;
const GUID IID_IDebugAdvanced2                            = GUIDOF!IDebugAdvanced2;
const GUID IID_IDebugAdvanced3                            = GUIDOF!IDebugAdvanced3;
const GUID IID_IDebugAdvanced4                            = GUIDOF!IDebugAdvanced4;
const GUID IID_IDebugBreakpoint                           = GUIDOF!IDebugBreakpoint;
const GUID IID_IDebugBreakpoint2                          = GUIDOF!IDebugBreakpoint2;
const GUID IID_IDebugBreakpoint3                          = GUIDOF!IDebugBreakpoint3;
const GUID IID_IDebugClient                               = GUIDOF!IDebugClient;
const GUID IID_IDebugClient2                              = GUIDOF!IDebugClient2;
const GUID IID_IDebugClient3                              = GUIDOF!IDebugClient3;
const GUID IID_IDebugClient4                              = GUIDOF!IDebugClient4;
const GUID IID_IDebugClient5                              = GUIDOF!IDebugClient5;
const GUID IID_IDebugClient6                              = GUIDOF!IDebugClient6;
const GUID IID_IDebugClient7                              = GUIDOF!IDebugClient7;
const GUID IID_IDebugClient8                              = GUIDOF!IDebugClient8;
const GUID IID_IDebugClient9                              = GUIDOF!IDebugClient9;
const GUID IID_IDebugControl                              = GUIDOF!IDebugControl;
const GUID IID_IDebugControl2                             = GUIDOF!IDebugControl2;
const GUID IID_IDebugControl3                             = GUIDOF!IDebugControl3;
const GUID IID_IDebugControl4                             = GUIDOF!IDebugControl4;
const GUID IID_IDebugControl5                             = GUIDOF!IDebugControl5;
const GUID IID_IDebugControl6                             = GUIDOF!IDebugControl6;
const GUID IID_IDebugControl7                             = GUIDOF!IDebugControl7;
const GUID IID_IDebugDataSpaces                           = GUIDOF!IDebugDataSpaces;
const GUID IID_IDebugDataSpaces2                          = GUIDOF!IDebugDataSpaces2;
const GUID IID_IDebugDataSpaces3                          = GUIDOF!IDebugDataSpaces3;
const GUID IID_IDebugDataSpaces4                          = GUIDOF!IDebugDataSpaces4;
const GUID IID_IDebugEventCallbacks                       = GUIDOF!IDebugEventCallbacks;
const GUID IID_IDebugEventCallbacksWide                   = GUIDOF!IDebugEventCallbacksWide;
const GUID IID_IDebugEventContextCallbacks                = GUIDOF!IDebugEventContextCallbacks;
const GUID IID_IDebugFailureAnalysis                      = GUIDOF!IDebugFailureAnalysis;
const GUID IID_IDebugFailureAnalysis2                     = GUIDOF!IDebugFailureAnalysis2;
const GUID IID_IDebugFailureAnalysis3                     = GUIDOF!IDebugFailureAnalysis3;
const GUID IID_IDebugHost                                 = GUIDOF!IDebugHost;
const GUID IID_IDebugHostBaseClass                        = GUIDOF!IDebugHostBaseClass;
const GUID IID_IDebugHostBaseClass2                       = GUIDOF!IDebugHostBaseClass2;
const GUID IID_IDebugHostConstant                         = GUIDOF!IDebugHostConstant;
const GUID IID_IDebugHostContext                          = GUIDOF!IDebugHostContext;
const GUID IID_IDebugHostContext2                         = GUIDOF!IDebugHostContext2;
const GUID IID_IDebugHostContextAlternator                = GUIDOF!IDebugHostContextAlternator;
const GUID IID_IDebugHostContextControl                   = GUIDOF!IDebugHostContextControl;
const GUID IID_IDebugHostContextExtensibility             = GUIDOF!IDebugHostContextExtensibility;
const GUID IID_IDebugHostContextExtension                 = GUIDOF!IDebugHostContextExtension;
const GUID IID_IDebugHostContextTargetComposition         = GUIDOF!IDebugHostContextTargetComposition;
const GUID IID_IDebugHostData                             = GUIDOF!IDebugHostData;
const GUID IID_IDebugHostErrorSink                        = GUIDOF!IDebugHostErrorSink;
const GUID IID_IDebugHostEvaluator                        = GUIDOF!IDebugHostEvaluator;
const GUID IID_IDebugHostEvaluator2                       = GUIDOF!IDebugHostEvaluator2;
const GUID IID_IDebugHostEvaluator3                       = GUIDOF!IDebugHostEvaluator3;
const GUID IID_IDebugHostExtensibility                    = GUIDOF!IDebugHostExtensibility;
const GUID IID_IDebugHostExtensibility2                   = GUIDOF!IDebugHostExtensibility2;
const GUID IID_IDebugHostExtensibility3                   = GUIDOF!IDebugHostExtensibility3;
const GUID IID_IDebugHostField                            = GUIDOF!IDebugHostField;
const GUID IID_IDebugHostField2                           = GUIDOF!IDebugHostField2;
const GUID IID_IDebugHostFunctionIntrospection            = GUIDOF!IDebugHostFunctionIntrospection;
const GUID IID_IDebugHostFunctionIntrospection2           = GUIDOF!IDebugHostFunctionIntrospection2;
const GUID IID_IDebugHostFunctionIntrospection3           = GUIDOF!IDebugHostFunctionIntrospection3;
const GUID IID_IDebugHostFunctionLocalDetails             = GUIDOF!IDebugHostFunctionLocalDetails;
const GUID IID_IDebugHostFunctionLocalDetails2            = GUIDOF!IDebugHostFunctionLocalDetails2;
const GUID IID_IDebugHostFunctionLocalDetailsEnumerator   = GUIDOF!IDebugHostFunctionLocalDetailsEnumerator;
const GUID IID_IDebugHostFunctionLocalStorage             = GUIDOF!IDebugHostFunctionLocalStorage;
const GUID IID_IDebugHostFunctionLocalStorage2            = GUIDOF!IDebugHostFunctionLocalStorage2;
const GUID IID_IDebugHostFunctionLocalStorageEnumerator   = GUIDOF!IDebugHostFunctionLocalStorageEnumerator;
const GUID IID_IDebugHostMemory                           = GUIDOF!IDebugHostMemory;
const GUID IID_IDebugHostMemory2                          = GUIDOF!IDebugHostMemory2;
const GUID IID_IDebugHostMemory3                          = GUIDOF!IDebugHostMemory3;
const GUID IID_IDebugHostMemory4                          = GUIDOF!IDebugHostMemory4;
const GUID IID_IDebugHostMemory5                          = GUIDOF!IDebugHostMemory5;
const GUID IID_IDebugHostModule                           = GUIDOF!IDebugHostModule;
const GUID IID_IDebugHostModule2                          = GUIDOF!IDebugHostModule2;
const GUID IID_IDebugHostModule3                          = GUIDOF!IDebugHostModule3;
const GUID IID_IDebugHostModule4                          = GUIDOF!IDebugHostModule4;
const GUID IID_IDebugHostModule5                          = GUIDOF!IDebugHostModule5;
const GUID IID_IDebugHostModuleSignature                  = GUIDOF!IDebugHostModuleSignature;
const GUID IID_IDebugHostPublic                           = GUIDOF!IDebugHostPublic;
const GUID IID_IDebugHostScriptHost                       = GUIDOF!IDebugHostScriptHost;
const GUID IID_IDebugHostStatus                           = GUIDOF!IDebugHostStatus;
const GUID IID_IDebugHostStatus2                          = GUIDOF!IDebugHostStatus2;
const GUID IID_IDebugHostSymbol                           = GUIDOF!IDebugHostSymbol;
const GUID IID_IDebugHostSymbol2                          = GUIDOF!IDebugHostSymbol2;
const GUID IID_IDebugHostSymbol3                          = GUIDOF!IDebugHostSymbol3;
const GUID IID_IDebugHostSymbolEnumerator                 = GUIDOF!IDebugHostSymbolEnumerator;
const GUID IID_IDebugHostSymbolSubstitutionEnumerator     = GUIDOF!IDebugHostSymbolSubstitutionEnumerator;
const GUID IID_IDebugHostSymbols                          = GUIDOF!IDebugHostSymbols;
const GUID IID_IDebugHostSymbols2                         = GUIDOF!IDebugHostSymbols2;
const GUID IID_IDebugHostSymbolsTargetComposition         = GUIDOF!IDebugHostSymbolsTargetComposition;
const GUID IID_IDebugHostTaggedUnionRangeEnumerator       = GUIDOF!IDebugHostTaggedUnionRangeEnumerator;
const GUID IID_IDebugHostType                             = GUIDOF!IDebugHostType;
const GUID IID_IDebugHostType2                            = GUIDOF!IDebugHostType2;
const GUID IID_IDebugHostType3                            = GUIDOF!IDebugHostType3;
const GUID IID_IDebugHostType4                            = GUIDOF!IDebugHostType4;
const GUID IID_IDebugHostType5                            = GUIDOF!IDebugHostType5;
const GUID IID_IDebugHostType6                            = GUIDOF!IDebugHostType6;
const GUID IID_IDebugHostTypeSignature                    = GUIDOF!IDebugHostTypeSignature;
const GUID IID_IDebugInputCallbacks                       = GUIDOF!IDebugInputCallbacks;
const GUID IID_IDebugOutputCallbacks                      = GUIDOF!IDebugOutputCallbacks;
const GUID IID_IDebugOutputCallbacks2                     = GUIDOF!IDebugOutputCallbacks2;
const GUID IID_IDebugOutputCallbacksWide                  = GUIDOF!IDebugOutputCallbacksWide;
const GUID IID_IDebugOutputStream                         = GUIDOF!IDebugOutputStream;
const GUID IID_IDebugPlmClient                            = GUIDOF!IDebugPlmClient;
const GUID IID_IDebugPlmClient2                           = GUIDOF!IDebugPlmClient2;
const GUID IID_IDebugPlmClient3                           = GUIDOF!IDebugPlmClient3;
const GUID IID_IDebugRegisters                            = GUIDOF!IDebugRegisters;
const GUID IID_IDebugRegisters2                           = GUIDOF!IDebugRegisters2;
const GUID IID_IDebugSymbolGroup                          = GUIDOF!IDebugSymbolGroup;
const GUID IID_IDebugSymbolGroup2                         = GUIDOF!IDebugSymbolGroup2;
const GUID IID_IDebugSymbols                              = GUIDOF!IDebugSymbols;
const GUID IID_IDebugSymbols2                             = GUIDOF!IDebugSymbols2;
const GUID IID_IDebugSymbols3                             = GUIDOF!IDebugSymbols3;
const GUID IID_IDebugSymbols4                             = GUIDOF!IDebugSymbols4;
const GUID IID_IDebugSymbols5                             = GUIDOF!IDebugSymbols5;
const GUID IID_IDebugSystemObjects                        = GUIDOF!IDebugSystemObjects;
const GUID IID_IDebugSystemObjects2                       = GUIDOF!IDebugSystemObjects2;
const GUID IID_IDebugSystemObjects3                       = GUIDOF!IDebugSystemObjects3;
const GUID IID_IDebugSystemObjects4                       = GUIDOF!IDebugSystemObjects4;
const GUID IID_IDeconstructableConcept                    = GUIDOF!IDeconstructableConcept;
const GUID IID_IDynamicConceptProviderConcept             = GUIDOF!IDynamicConceptProviderConcept;
const GUID IID_IDynamicKeyProviderConcept                 = GUIDOF!IDynamicKeyProviderConcept;
const GUID IID_IEquatableConcept                          = GUIDOF!IEquatableConcept;
const GUID IID_IFilteredNamespacePropertyToken            = GUIDOF!IFilteredNamespacePropertyToken;
const GUID IID_IHostDataModelAccess                       = GUIDOF!IHostDataModelAccess;
const GUID IID_IIndexableConcept                          = GUIDOF!IIndexableConcept;
const GUID IID_IIterableConcept                           = GUIDOF!IIterableConcept;
const GUID IID_IKeyEnumerator                             = GUIDOF!IKeyEnumerator;
const GUID IID_IKeyStore                                  = GUIDOF!IKeyStore;
const GUID IID_IModelIterator                             = GUIDOF!IModelIterator;
const GUID IID_IModelKeyReference                         = GUIDOF!IModelKeyReference;
const GUID IID_IModelKeyReference2                        = GUIDOF!IModelKeyReference2;
const GUID IID_IModelMethod                               = GUIDOF!IModelMethod;
const GUID IID_IModelObject                               = GUIDOF!IModelObject;
const GUID IID_IModelObject2                              = GUIDOF!IModelObject2;
const GUID IID_IModelPropertyAccessor                     = GUIDOF!IModelPropertyAccessor;
const GUID IID_INamedModelsEnumerator                     = GUIDOF!INamedModelsEnumerator;
const GUID IID_IObjectWrapperConcept                      = GUIDOF!IObjectWrapperConcept;
const GUID IID_IPreferredRuntimeTypeConcept               = GUIDOF!IPreferredRuntimeTypeConcept;
const GUID IID_IRawEnumerator                             = GUIDOF!IRawEnumerator;
const GUID IID_IStringDisplayableConcept                  = GUIDOF!IStringDisplayableConcept;
