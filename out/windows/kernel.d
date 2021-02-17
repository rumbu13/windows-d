// Written in the D programming language.

module windows.kernel;

public import windows.core;
public import windows.dbg : CONTEXT, EXCEPTION_RECORD;

extern(Windows):


// Enums


alias EXCEPTION_DISPOSITION = int;
enum : int
{
    ExceptionContinueExecution = 0x00000000,
    ExceptionContinueSearch    = 0x00000001,
    ExceptionNestedException   = 0x00000002,
    ExceptionCollidedUnwind    = 0x00000003,
}

///The <b>COMPARTMENT_ID</b> enumeration indicates the network routing compartment identifier.
alias COMPARTMENT_ID = int;
enum : int
{
    ///Indicates that the routing compartment is undefined.
    UNSPECIFIED_COMPARTMENT_ID = 0x00000000,
    DEFAULT_COMPARTMENT_ID     = 0x00000001,
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

// Callbacks

alias EXCEPTION_ROUTINE = EXCEPTION_DISPOSITION function(EXCEPTION_RECORD* ExceptionRecord, void* EstablisherFrame, 
                                                         CONTEXT* ContextRecord, void* DispatcherContext);

// Structs


///Describes a local identifier for an adapter.
struct LUID
{
    ///Specifies a DWORD that contains the unsigned lower numbers of the id.
    uint LowPart;
    ///Specifies a LONG that contains the signed high numbers of the id.
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

///A <b>LIST_ENTRY</b> structure describes an entry in a doubly linked list or serves as the header for such a list.
struct LIST_ENTRY
{
    ///For a <b>LIST_ENTRY</b> structure that serves as a list entry, the <b>Flink</b> member points to the next entry
    ///in the list or to the list header if there is no next entry in the list. For a <b>LIST_ENTRY</b> structure that
    ///serves as the list header, the <b>Flink</b> member points to the first entry in the list or to the LIST_ENTRY
    ///structure itself if the list is empty.
    LIST_ENTRY* Flink;
    ///For a <b>LIST_ENTRY</b> structure that serves as a list entry, the <b>Blink</b> member points to the previous
    ///entry in the list or to the list header if there is no previous entry in the list. For a <b>LIST_ENTRY</b>
    ///structure that serves as the list header, the <b>Blink</b> member points to the last entry in the list or to the
    ///<b>LIST_ENTRY</b> structure itself if the list is empty.
    LIST_ENTRY* Blink;
}

///Represents an item in a singly linked list.
struct SINGLE_LIST_ENTRY
{
    ///A pointer to an <b>SLIST_ENTRY</b> structure that represents the next item in a singly linked list.
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

