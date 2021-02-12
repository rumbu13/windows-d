module windows.kernel;

public import system;
public import windows.debug;

extern(Windows):

enum EXCEPTION_DISPOSITION
{
    ExceptionContinueExecution = 0,
    ExceptionContinueSearch = 1,
    ExceptionNestedException = 2,
    ExceptionCollidedUnwind = 3,
}

enum COMPARTMENT_ID
{
    UNSPECIFIED_COMPARTMENT_ID = 0,
    DEFAULT_COMPARTMENT_ID = 1,
}

struct LUID
{
    uint LowPart;
    int HighPart;
}

struct QUAD
{
    _Anonymous_e__Union Anonymous;
}

enum EVENT_TYPE
{
    NotificationEvent = 0,
    SynchronizationEvent = 1,
}

enum TIMER_TYPE
{
    NotificationTimer = 0,
    SynchronizationTimer = 1,
}

enum WAIT_TYPE
{
    WaitAll = 0,
    WaitAny = 1,
    WaitNotification = 2,
    WaitDequeue = 3,
}

struct CSTRING
{
    ushort Length;
    ushort MaximumLength;
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
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
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
    uint Data;
}

struct STRING32
{
    ushort Length;
    ushort MaximumLength;
    uint Buffer;
}

struct STRING64
{
    ushort Length;
    ushort MaximumLength;
    ulong Buffer;
}

struct OBJECT_ATTRIBUTES64
{
    uint Length;
    ulong RootDirectory;
    ulong ObjectName;
    uint Attributes;
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
    Guid Lineage;
    uint Uniquifier;
}

alias EXCEPTION_ROUTINE = extern(Windows) EXCEPTION_DISPOSITION function(EXCEPTION_RECORD* ExceptionRecord, void* EstablisherFrame, CONTEXT* ContextRecord, void* DispatcherContext);
enum NT_PRODUCT_TYPE
{
    NtProductWinNt = 1,
    NtProductLanManNt = 2,
    NtProductServer = 3,
}

enum SUITE_TYPE
{
    SmallBusiness = 0,
    Enterprise = 1,
    BackOffice = 2,
    CommunicationServer = 3,
    TerminalServer = 4,
    SmallBusinessRestricted = 5,
    EmbeddedNT = 6,
    DataCenter = 7,
    SingleUserTS = 8,
    Personal = 9,
    Blade = 10,
    EmbeddedRestricted = 11,
    SecurityAppliance = 12,
    StorageServer = 13,
    ComputeServer = 14,
    WHServer = 15,
    PhoneNT = 16,
    MultiUserTS = 17,
    MaxSuiteType = 18,
}

