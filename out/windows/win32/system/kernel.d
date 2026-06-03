// Written in the D programming language.

module windows.win32.system.kernel;

public import windows.core;
public import windows.win32.foundation : PSTR;
public import windows.win32.system.diagnostics.debug_ : CONTEXT, EXCEPTION_RECORD;

extern(Windows) @nogc nothrow:


// Enums


alias EXCEPTION_DISPOSITION = int;
enum : int
{
    ExceptionContinueExecution = 0x00000000,
    ExceptionContinueSearch    = 0x00000001,
    ExceptionNestedException   = 0x00000002,
    ExceptionCollidedUnwind    = 0x00000003,
}

alias EVENT_TYPE = int;
enum : int
{
    NotificationEvent    = 0x00000000,
    SynchronizationEvent = 0x00000001,
}

alias TIMER_TYPE = int;
enum : int
{
    NotificationTimer    = 0x00000000,
    SynchronizationTimer = 0x00000001,
}

alias WAIT_TYPE = int;
enum : int
{
    WaitAll          = 0x00000000,
    WaitAny          = 0x00000001,
    WaitNotification = 0x00000002,
    WaitDequeue      = 0x00000003,
    WaitDpc          = 0x00000004,
}

alias NT_PRODUCT_TYPE = int;
enum : int
{
    NtProductWinNt    = 0x00000001,
    NtProductLanManNt = 0x00000002,
    NtProductServer   = 0x00000003,
}

alias SUITE_TYPE = int;
enum : int
{
    SmallBusiness           = 0x00000000,
    Enterprise              = 0x00000001,
    BackOffice              = 0x00000002,
    CommunicationServer     = 0x00000003,
    TerminalServer          = 0x00000004,
    SmallBusinessRestricted = 0x00000005,
    EmbeddedNT              = 0x00000006,
    DataCenter              = 0x00000007,
    SingleUserTS            = 0x00000008,
    Personal                = 0x00000009,
    Blade                   = 0x0000000a,
    EmbeddedRestricted      = 0x0000000b,
    SecurityAppliance       = 0x0000000c,
    StorageServer           = 0x0000000d,
    ComputeServer           = 0x0000000e,
    WHServer                = 0x0000000f,
    PhoneNT                 = 0x00000010,
    MultiUserTS             = 0x00000011,
    MaxSuiteType            = 0x00000012,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-compartment_id
alias COMPARTMENT_ID = int;
enum : int
{
    UNSPECIFIED_COMPARTMENT_ID = 0x00000000,
    DEFAULT_COMPARTMENT_ID     = 0x00000001,
}

// Constants


enum int OBJ_HANDLE_TAGBITS = 0x00000003;
enum uint RTL_BALANCED_NODE_RESERVED_PARENT_MASK = 0x00000003U;
enum uint NULL64 = 0x00000000U;

enum : uint
{
    MAXUCHAR  = 0x000000ffU,
    MAXUSHORT = 0x0000ffffU,
    MAXULONG  = 0xffffffffU,
}

// Callbacks

alias EXCEPTION_ROUTINE = EXCEPTION_DISPOSITION function(EXCEPTION_RECORD* ExceptionRecord, void* EstablisherFrame, 
                                                         CONTEXT* ContextRecord, void* DispatcherContext);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-slist_entry
struct SLIST_ENTRY
{
    SLIST_ENTRY* Next;
}

version(AArch64)
{
    union SLIST_HEADER
    {
        struct
        {
            ulong Alignment;
            ulong Region;
        }
        struct HeaderArm64
        {
            // Native bit field: Depth: [0-15], Sequence: [16-63]
            ulong _bitfield1;
            // Native bit field: Reserved: [0-3], NextEntry: [4-63]
            ulong _bitfield2;
        }
    }
}

struct QUAD
{
    union
    {
        long   UseThisFieldToCopy;
        double DoNotUseThisField;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-processor_number
struct PROCESSOR_NUMBER
{
    ushort Group;
    ubyte  Number;
    ubyte  Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdef/ns-ntdef-string
struct STRING
{
    ushort Length;
    ushort MaximumLength;
    PSTR   Buffer;
}

struct CSTRING
{
    ushort      Length;
    ushort      MaximumLength;
    const(PSTR) Buffer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdef/ns-ntdef-list_entry
struct LIST_ENTRY
{
    LIST_ENTRY* Flink;
    LIST_ENTRY* Blink;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdef/ns-ntdef-single_list_entry
struct SINGLE_LIST_ENTRY
{
    SINGLE_LIST_ENTRY* Next;
}

struct RTL_BALANCED_NODE
{
    union
    {
        RTL_BALANCED_NODE[2]* Children;
        struct
        {
            RTL_BALANCED_NODE* Left;
            RTL_BALANCED_NODE* Right;
        }
    }
    union
    {
        // Native bit field: Red: [0], Balance: [1-2]
        ubyte  _bitfield0;
        size_t ParentValue;
    }
}

struct LIST_ENTRY32
{
    uint Flink;
    uint Blink;
}

struct LIST_ENTRY64
{
    ulong Flink;
    ulong Blink;
}

struct SINGLE_LIST_ENTRY32
{
    uint Next;
}

struct WNF_STATE_NAME
{
    uint[2] Data;
}

struct STRING32
{
    ushort Length;
    ushort MaximumLength;
    uint   Buffer;
}

struct STRING64
{
    ushort Length;
    ushort MaximumLength;
    ulong  Buffer;
}

struct OBJECTID
{
    GUID Lineage;
    uint Uniquifier;
}

version(X86_64)
{
    union SLIST_HEADER
    {
        struct
        {
            ulong Alignment;
            ulong Region;
        }
        struct HeaderX64
        {
            // Native bit field: Depth: [0-15], Sequence: [16-63]
            ulong _bitfield1;
            // Native bit field: Reserved: [0-3], NextEntry: [4-63]
            ulong _bitfield2;
        }
    }
}

version(X86_64)
{
    struct FLOATING_SAVE_AREA
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
}

version(AArch64)
{
    struct FLOATING_SAVE_AREA
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
}

version(X86)
{
    struct FLOATING_SAVE_AREA
    {
        uint      ControlWord;
        uint      StatusWord;
        uint      TagWord;
        uint      ErrorOffset;
        uint      ErrorSelector;
        uint      DataOffset;
        uint      DataSelector;
        ubyte[80] RegisterArea;
        uint      Spare0;
    }
}

struct EXCEPTION_REGISTRATION_RECORD
{
    EXCEPTION_REGISTRATION_RECORD* Next;
    EXCEPTION_ROUTINE Handler;
}

struct NT_TIB
{
    EXCEPTION_REGISTRATION_RECORD* ExceptionList;
    void*   StackBase;
    void*   StackLimit;
    void*   SubSystemTib;
    union
    {
        void* FiberData;
        uint  Version;
    }
    void*   ArbitraryUserPointer;
    NT_TIB* Self;
}

version(X86)
{
    union SLIST_HEADER
    {
        ulong Alignment;
        struct
        {
            SINGLE_LIST_ENTRY Next;
            ushort            Depth;
            ushort            CpuId;
        }
    }
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ntdll.dll")
void RtlInitializeSListHead(SLIST_HEADER* ListHead);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ntdll.dll")
SLIST_ENTRY* RtlFirstEntrySList(const(SLIST_HEADER)* ListHead);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ntdll.dll")
SLIST_ENTRY* RtlInterlockedPopEntrySList(SLIST_HEADER* ListHead);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ntdll.dll")
SLIST_ENTRY* RtlInterlockedPushEntrySList(SLIST_HEADER* ListHead, SLIST_ENTRY* ListEntry);

@DllImport("ntdll.dll")
SLIST_ENTRY* RtlInterlockedPushListSListEx(SLIST_HEADER* ListHead, SLIST_ENTRY* List, SLIST_ENTRY* ListEnd, 
                                           uint Count);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ntdll.dll")
SLIST_ENTRY* RtlInterlockedFlushSList(SLIST_HEADER* ListHead);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ntdll.dll")
ushort RtlQueryDepthSList(SLIST_HEADER* ListHead);


