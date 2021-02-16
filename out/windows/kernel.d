module windows.kernel;

public import windows.core;
public import windows.dbg : CONTEXT, EXCEPTION_RECORD;

extern(Windows):


// Enums


enum : int
{
    ExceptionContinueExecution = 0x00000000,
    ExceptionContinueSearch    = 0x00000001,
    ExceptionNestedException   = 0x00000002,
    ExceptionCollidedUnwind    = 0x00000003,
}
alias EXCEPTION_DISPOSITION = int;

enum : int
{
    UNSPECIFIED_COMPARTMENT_ID = 0x00000000,
    DEFAULT_COMPARTMENT_ID     = 0x00000001,
}
alias COMPARTMENT_ID = int;

enum : int
{
    NotificationEvent    = 0x00000000,
    SynchronizationEvent = 0x00000001,
}
alias EVENT_TYPE = int;

enum : int
{
    NotificationTimer    = 0x00000000,
    SynchronizationTimer = 0x00000001,
}
alias TIMER_TYPE = int;

enum : int
{
    WaitAll          = 0x00000000,
    WaitAny          = 0x00000001,
    WaitNotification = 0x00000002,
    WaitDequeue      = 0x00000003,
}
alias WAIT_TYPE = int;

enum : int
{
    NtProductWinNt    = 0x00000001,
    NtProductLanManNt = 0x00000002,
    NtProductServer   = 0x00000003,
}
alias NT_PRODUCT_TYPE = int;

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
alias SUITE_TYPE = int;

// Callbacks

alias EXCEPTION_ROUTINE = EXCEPTION_DISPOSITION function(EXCEPTION_RECORD* ExceptionRecord, void* EstablisherFrame, 
                                                         CONTEXT* ContextRecord, void* DispatcherContext);

// Structs


struct LUID
{
    uint LowPart;
    int  HighPart;
}

struct QUAD
{
    union
    {
        long   UseThisFieldToCopy;
        double DoNotUseThisField;
    }
}

struct CSTRING
{
    ushort       Length;
    ushort       MaximumLength;
    const(byte)* Buffer;
}

struct LIST_ENTRY
{
    LIST_ENTRY* Flink;
    LIST_ENTRY* Blink;
}

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
        ubyte  _bitfield63;
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

struct OBJECT_ATTRIBUTES64
{
    uint  Length;
    ulong RootDirectory;
    ulong ObjectName;
    uint  Attributes;
    ulong SecurityDescriptor;
    ulong SecurityQualityOfService;
}

struct OBJECT_ATTRIBUTES32
{
    uint Length;
    uint RootDirectory;
    uint ObjectName;
    uint Attributes;
    uint SecurityDescriptor;
    uint SecurityQualityOfService;
}

struct OBJECTID
{
    GUID Lineage;
    uint Uniquifier;
}

